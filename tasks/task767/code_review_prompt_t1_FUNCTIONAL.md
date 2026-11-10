# CODE REVIEW - PASS FUNCTIONAL: Functional Logic (metodos, eventos, containers)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Functional Logic (metodos, eventos, containers)**.

## PROBLEMAS DETECTADOS (11)
- [MADDCOLUNA-PARAMS] Chamada mAddColuna com 4 parametros (esperado: 3). Assinatura correta: mAddColuna(campo, mascara_ou_vazio, titulo). NAO passar largura ou tabela como parametro. Exemplo: loc_oBusca.mAddColuna('Codigos', '', 'Codigo')
- [MADDCOLUNA-PARAMS] Chamada mAddColuna com 4 parametros (esperado: 3). Assinatura correta: mAddColuna(campo, mascara_ou_vazio, titulo). NAO passar largura ou tabela como parametro. Exemplo: loc_oBusca.mAddColuna('Codigos', '', 'Codigo')
- [MADDCOLUNA-PARAMS] Chamada mAddColuna com 4 parametros (esperado: 3). Assinatura correta: mAddColuna(campo, mascara_ou_vazio, titulo). NAO passar largura ou tabela como parametro. Exemplo: loc_oBusca.mAddColuna('Codigos', '', 'Codigo')
- [MADDCOLUNA-PARAMS] Chamada mAddColuna com 4 parametros (esperado: 3). Assinatura correta: mAddColuna(campo, mascara_ou_vazio, titulo). NAO passar largura ou tabela como parametro. Exemplo: loc_oBusca.mAddColuna('Codigos', '', 'Codigo')
- [MADDCOLUNA-PARAMS] Chamada mAddColuna com 4 parametros (esperado: 3). Assinatura correta: mAddColuna(campo, mascara_ou_vazio, titulo). NAO passar largura ou tabela como parametro. Exemplo: loc_oBusca.mAddColuna('Codigos', '', 'Codigo')
- [MADDCOLUNA-PARAMS] Chamada mAddColuna com 4 parametros (esperado: 3). Assinatura correta: mAddColuna(campo, mascara_ou_vazio, titulo). NAO passar largura ou tabela como parametro. Exemplo: loc_oBusca.mAddColuna('Codigos', '', 'Codigo')
- [MADDCOLUNA-PARAMS] Chamada mAddColuna com 4 parametros (esperado: 3). Assinatura correta: mAddColuna(campo, mascara_ou_vazio, titulo). NAO passar largura ou tabela como parametro. Exemplo: loc_oBusca.mAddColuna('Codigos', '', 'Codigo')
- [MADDCOLUNA-PARAMS] Chamada mAddColuna com 4 parametros (esperado: 3). Assinatura correta: mAddColuna(campo, mascara_ou_vazio, titulo). NAO passar largura ou tabela como parametro. Exemplo: loc_oBusca.mAddColuna('Codigos', '', 'Codigo')
- [METODO-INEXISTENTE] Metodo 'THIS.VerificarPermissao()' chamado mas NAO definido como PROCEDURE no Form nem herdado de FormBase. A LLM pode ter inventado este metodo. VERIFICAR se existe no legado e IMPLEMENTAR ou REMOVER a chamada.
- [GRID-WITH] Bloco WITH loc_oBO.this_nNdopes define .RecordSource E acessa .Column dentro do mesmo WITH. Isso causa 'Unknown member COLUMN1' porque colunas nao sao criadas imediatamente dentro de WITH. SOLUCAO: Mover .RecordSource e .ColumnCount para FORA do WITH (usar referencia explicita: loc_oBO.this_nNdopes.RecordSource).
- [GRID-HEADER] Header Caption '  #  ' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: Movimentação, #, Cores, Padrão, Ordem, G.Grp, Emp.. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.

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

### FORM (C:\4c\projeto\app\forms\operacionais\FormSigOpMop.prg) - TRECHOS RELEVANTES PARA PASS FUNCTIONAL (2939 linhas total):

*-- Linhas 17 a 119:
17: * destino - ver o cabecalho de SigOpMopBO.prg para o mapa das colunas.
18: *
19: * Fase 3/8 - ESTRUTURA BASE: esqueleto da classe (propriedades de estado,
20: * Init() recebendo o contexto do form chamador, InicializarForm(),
21: * ConfigurarPageFrame(), Destroy()) e a faixa do cabecalho
22: * (cnt_4c_Sombra/lbl_4c_LblSombra/lbl_4c_LblTitulo), com geometria TRANSCRITA
23: * do dump (tasks/task767/layout.json + SECAO 2 do arquivo de extracao).
24: *
25: * Fase 4/8 - GRADE E BOTOES DE ACAO: a grade de 7 colunas (grd_4c_Dados), a
26: * moldura (shp_4c_Shape1), os TRES botoes (cmd_4c_CmdInserir /
27: * cmd_4c_CmdExcluir / cmd_4c_CmdSair) com a regra de permissao do Init legado,
28: * a ordem de tabulacao e o funil de carga (CarregarDados -> MontaGrade ->
29: * ConfigurarColunasGrade / GarantirCheckBoxPadrao), mais os dois metodos de
30: * carga que isso exige no BO (CarregarConfiguracaoOperacao e CarregarGrade).
31: *
32: * NAO HA barra de seis botoes CRUD nem PageFrame Lista/Dados para esta fase
33: * entregar, e isso foi MEDIDO no dump, nao presumido: a SECAO 1 lista 25
34: * objetos, com ZERO "BaseClass: pageframe", UM "BaseClass: grid" (GradeSubN) e
35: * exatamente tres "BaseClass: commandbutton" (cmdExcluir, cmdSair, cmdInserir),
36: * todos com "Parent: SIGOPMOP". A superficie desta tela eh a GRADE, e eh ela
37: * que esta fase entrega - inventar Lista/Dados com Incluir/Alterar/Excluir/
38: * Buscar violaria o PILAR 1, e criar ConfigurarPaginaLista()/AlternarPagina()
39: * vazios so para casar com o roteiro generico seria o stub disfarcado que a
40: * regra de completude proibe.
41: *
42: * Fase 5/8 - CELULAS DIGITAVEIS SEM LOOKUP (Movimentacao e Cores): o When/
43: * Valid/LostFocus de Column1 (TextBoxMovimentacaoMop_4c) e Column3
44: * (TextBoxCoresMop_4c), instalados via Column.AddObject + CurrentControl +
45: * Sparse = .F. (regra #18/#46 - BINDEVENT em evento de celula de Grid NAO eh
46: * confiavel). GarantirCelulasEditaveisGrade() reinstala as duas celulas a
47: * cada MontaGrade(), pela mesma razao de GarantirCheckBoxPadrao(): o bind do
48: * cursor DERRUBA o que foi posto por AddObject.
49: *
50: * O Valid de "Cores" (ValidarCoresMopExec) ficou na Fase 5 porque usa
51: * GETCOLOR() - funcao NATIVA do VFP9 (seletor de cor do Windows), nao consulta
52: * em tabela: nao eh lookup, logo nao eh materia desta fase.
53: *
54: * Fase 6/8 - LOOKUPS DAS CELULAS DA GRADE: os TRES lookups que o dump declara,
55: * todos no Valid de uma celula de Column (nunca em AfterRowColChange, que
56: * entrega a coluna de DESTINO e validaria a linha errada - regra #46):
57: *
58: *   Column1 "Movimentacao" -> SigCdOpe   (dopes char(20) + ndopes numeric(4,0))
59: *       ValidarMovimentacaoMopExec/Corpo + ObterOperacaoInativa (a recusa de
60: *       operacao INATIVA, que o legado le do cursor de SigOpCdc), e o REPLACE
61: *       de ndopes, que eh o que preenche a coluna "  #  " da grade.
62: *   Column6 "G.Grp"        -> SigCdGpr   (codigos char(3) + descs char(40))
63: *       ValidarGrandeGrupoMopExec/Corpo mais o par GotFocus/LostFocus que o
64: *       legado usa como detector de alteracao (Tag de entrada x valor de saida
65: *       ligando this_lHouveInsercao).
66: *   Column7 "Emp."         -> SigCdEmp   (cemps char(3) + razas char(40))
67: *       ValidarEmpresaMopExec/Corpo.
68: *
69: * As duas celulas novas (TextBoxGrandeGrupoMop_4c e TextBoxEmpresaMop_4c, em
70: * classes\TextBoxGridLookup.prg) sao instaladas por
71: * GarantirCelulasEditaveisGrade() junto com as da Fase 5, pelo mesmo motivo de
72: * idempotencia: CarregarGrade() derruba o alias da grade e isso destroi o que
73: * foi posto por Column.AddObject. Como elas passam a ser o CurrentControl das
74: * Columns 6 e 7, os .Text1.* dessas colunas sairam de ConfigurarColunasGrade -
75: * a coluna deixa de desenhar o Text1, e manter aquelas linhas seria codigo
76: * morto. MaxLength vem da LARGURA DA COLUNA no schema (3, 3 e 20), nunca do
77: * Width em pixels (regra #19).
78: *
79: * Os tres lookups passam pelo contrato do FormBuscaAuxiliar (regra #37): 1o
80: * argumento eh o HANDLE da conexao, Show() SO quando this_lAchouRegistro eh
81: * .F. (com match exato o dialogo subiria por cima da celula ja resolvida) e
82: * atribuicao SO dentro da guarda this_lSelecionou - o legado le o cursor do
83: * picker mesmo quando o usuario sai com ESC, e com isso a celula recebia a
84: * primeira linha da busca parcial sem ninguem ter escolhido. Universo vazio
85: * NAO gera aviso nem apaga o que foi digitado (regra #50). Cada divergencia
86: * deliberada em relacao ao legado esta justificada no metodo correspondente.
87: *
88: * Os tres Exec sao WRAPPERS da guarda de reentrancia this_lEmLookup, com o
89: * corpo num <Nome>Corpo separado: o picker eh MODAL, tira o foco da celula e
90: * pode redisparar o proprio Valid, e corpo com RETURN antecipado dentro do
91: * wrapper deixaria a flag travada ligada, matando o lookup pelo resto da vida
92: * do form (regra #47).
93: *
94: * Sem conexao (harness/validacao de UI) nenhum dos tres lookups roda e o valor
95: * digitado eh aceito como esta: SQLEXEC com handle invalido dispara excecao, e
96: * Show() de form MODAL em teste headless travaria o processo.
97: *
98: * Fase 7/8 - EVENTOS PRINCIPAIS DOS BOTOES: BtnInserirClick/BtnExcluirClick
99: * (cmd_4c_CmdInserir/cmd_4c_CmdExcluir, TRANSCRITOS do Click do legado) e
100: * BtnEncerrarClick (cmd_4c_CmdSair - nome CANONICO que TesteAutomatico.prg
101: * procura), mais a alternancia exclusiva do CheckBox "Padrao" (Column4),
102: * instalada em GarantirCheckBoxPadrao com os 4 handlers Click/MouseDown/
103: * MouseUp/KeyPress + NODEFAULT (checkbox em coluna de Grid NAO alterna pelo
104: * binding nativo), e ControlarBotoesFormPai - equivalente ao mCtrlBotoes do
105: * legado, chamado por HabilitarFormPai com o MESMO par_lHabilitar, que
106: * desliga/religa granularmente os botoes do form chamador (FormOPE: o grupo
107: * CRUD cnt_4c_Botoes, cmd_4c_MultiSubN e cnt_4c_Saida.cmd_4c_Encerrar, todos
108: * na Page1 - Lista).
109: *
110: * Fase 8/8 - CONSOLIDACAO FINAL (gravacao): o bloco interno do cmdSair.Click
111: * legado, que as fases anteriores deixaram para esta, e os hooks de
112: * transferencia entre a linha da grade e o objeto de negocio.
113: *
114: *   BtnEncerrarClick  - agora completo, com os DOIS guards do legado (modo de
115: *       edicao pela visibilidade de Inserir/Excluir, e "houve mudanca?" pelas
116: *       flags lHouveIns/lHouveExcl) e os DOIS desfechos distintos do legado:
117: *       duplicidade ABORTA o encerramento ("Return .f." de dentro do Click),
118: *       falha de gravacao apenas avisa e a tela fecha.
119: *   ValidarDuplicidadeGrade - o "Select ... GROUP by 1,2,3 Into cursor Totais"

*-- Linhas 173 a 218:
173: * o legado nao possui, contra o PILAR 1.
174: *
175: * NENHUM metodo vazio foi criado para "cumprir fase": ConfigurarPageFrame()
176: * orquestra apenas o que esta entregue. Vincular BINDEVENT a metodo
177: * inexistente aborta a inicializacao do form, e metodo vazio viola a regra de
178: * completude - por isso os BINDEVENT dos botoes entram junto com os handlers
179: * que eles chamam, na Fase 7. Os botoes JA nascem com geometria, icone e a
180: * regra de permissao do legado: o que falta neles eh so a acao do clique.
181: *
182: * NAO existe barra de seis botoes de cadastro (inclusao/alteracao/consulta/
183: * remocao/busca) nesta tela, e isso foi LIDO no dump, nao presumido: a SECAO 1
184: * lista 25 objetos e os unicos CommandButton sao cmdExcluir, cmdSair e
185: * cmdInserir, todos com "Parent: SIGOPMOP". Nao ha CommandGroup, nao ha
186: * Grupo_Op nem Grupo_Saida, e o SCX nao declara a variavel de modo do
187: * frmcadastro. Reproduzir aqui aquela barra seria inventar interface que o
188: * legado nao possui, contra o PILAR 1.
189: *
190: * DataSession = 1 (sessao CORRENTE, nao "sessao global 1") eh o equivalente
191: * fiel ao "Set DataSession to pnDataSes" do Init legado: o dialogo passa a
192: * rodar na mesma sessao de dados do form chamador, e o cursor da grade cruza
193: * a fronteira normalmente. Medido no VFP9: form com DataSession = 1
194: * instanciado de dentro de um form DataSession = 2 roda na sessao PRIVADA do
195: * pai. O parametro par_nDataSession continua na assinatura por paridade com o
196: * legado e fica guardado em this_nDataSessionPai para rastreio, mas NAO se
197: * emite "SET DATASESSION TO" aqui: com DataSession = 1 o form ja esta na
198: * sessao do chamador, e o SET global deixaria efeito colateral depois do
199: * Release.
200: *==============================================================================
201: 
202: DEFINE CLASS FormSigOpMop AS FormBase
203: 
204:     *-- Geometria e aparencia TRANSCRITAS de SIGOPMOP (SECAO 2 do dump)
205:     Height       = 430
206:     Width        = 759
207:     Caption      = ""
208:     TitleBar     = 0
209:     ShowWindow   = 1
210:     ControlBox   = .F.
211:     MaxButton    = .F.
212:     MinButton    = .F.
213:     Movable      = .F.
214:     ClipControls = .F.
215:     BorderStyle  = 2
216:     DataSession  = 1
217:     AutoCenter   = .T.
218:     FontName     = "Tahoma"

*-- Linhas 257 a 489:
257:     *--------------------------------------------------------------------------
258:     * Guarda de REENTRANCIA dos lookups das celulas da grade.
259:     *
260:     * FormBuscaAuxiliar eh MODAL: o Show() bloqueia, tira o foco da celula e
261:     * pode fazer o proprio Valid disparar de novo quando o foco volta -
262:     * empilhando um segundo picker sobre o primeiro. A flag eh ligada no
263:     * WRAPPER de cada lookup (Validar<X>MopExec) e liberada por ele DEPOIS do
264:     * corpo, para valer tambem quando o corpo sai por um caminho de recusa.
265:     *
266:     * O corpo mora num metodo separado (Validar<X>MopCorpo) exatamente por
267:     * isso: corpo com RETURN antecipado dentro do proprio wrapper deixaria a
268:     * flag TRAVADA ligada e mataria o lookup pelo resto da vida do form.
269:     *--------------------------------------------------------------------------
270:     this_lEmLookup = .F.
271: 
272:     *--------------------------------------------------------------------------
273:     * Modo de operacao da tela. Nasce em "EDICAO" e nao em "LISTA" porque esta
274:     * tela nao tem pagina de lista: a grade EH a superficie de trabalho, e o
275:     * que define se ela aceita digitacao eh o modo do form PAI (this_cEscolha),
276:     * nao um modo proprio alternado por botoes.
277:     *--------------------------------------------------------------------------
278:     this_cModoAtual = "EDICAO"
279: 
280:     *--------------------------------------------------------------------------
281:     * Cursor da grade. Nome centralizado numa property para a grade nao perder
282:     * o bind quando as fases seguintes recarregarem os dados (o BO usa o mesmo
283:     * nome em this_cCursorDados).
284:     *--------------------------------------------------------------------------
285:     this_cCursorDados = "cursor_4c_Dados"
286: 
287:     *--------------------------------------------------------------------------
288:     * Init - recebe o contexto do form chamador, igual ao
289:     * "LParameters poForm, pnDataSes, pcEscolha" do Init legado, mais a
290:     * operacao PAI (que no legado vinha do cursor compartilhado crSigCdOpe).
291:     *
292:     * O Caption reproduz o do legado:
293:     *   'Geracao de Multiplas Operacoes ' + AllTrim( Proper( crSigCdOpe.Dopes ) )
294:     * Sem operacao informada fica so o titulo, sem o espaco sobrando no fim.
295:     *--------------------------------------------------------------------------
296:     PROCEDURE Init(par_oFormPai, par_nDataSession, par_cEscolha, par_cOperacaoPai)
297:         LOCAL loc_cTitulo, loc_cOperacao
298: 
299:         THIS.this_oFormPai        = IIF(VARTYPE(par_oFormPai) = "O", par_oFormPai, .NULL.)
300:         THIS.this_cEscolha        = IIF(VARTYPE(par_cEscolha) = "C", UPPER(ALLTRIM(par_cEscolha)), "")
301:         THIS.this_cOperacaoPai    = IIF(VARTYPE(par_cOperacaoPai) = "C", ALLTRIM(par_cOperacaoPai), "")
302:         THIS.this_nDataSessionPai = IIF(VARTYPE(par_nDataSession) = "N", par_nDataSession, 0)
303: 
304:         loc_cTitulo   = "Gera" + CHR(231) + CHR(227) + "o de Multiplas Opera" + CHR(231) + CHR(245) + "es"
305:         loc_cOperacao = ALLTRIM(PROPER(THIS.this_cOperacaoPai))
306: 
307:         IF !EMPTY(loc_cOperacao)
308:             loc_cTitulo = loc_cTitulo + " " + loc_cOperacao
309:         ENDIF
310: 
311:         THIS.Caption = loc_cTitulo
312: 
313:         *-- WindowType = 1 (modal) so em producao: no harness headless o Show()
314:         *-- modal bloqueia a execucao e a instanciacao estoura por timeout.
315:         IF !((TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI) OR ;
316:              (TYPE("gb_4c_ModoTeste") = "L" AND gb_4c_ModoTeste))
317:             THIS.WindowType = 1
318:             THIS.ShowWindow = 1
319:         ENDIF
320: 
321:         RETURN DODEFAULT()
322:     ENDPROC
323: 
324:     *--------------------------------------------------------------------------
325:     * InicializarForm - cria o Business Object, repassa a ele o contexto
326:     * recebido do form chamador, monta a estrutura visual e desabilita o form
327:     * PAI enquanto o dialogo esta aberto ("Thisform.ParentForm.Enabled = .F."
328:     * do Init legado). A reabilitacao mora no Destroy - ver o comentario de la.
329:     *--------------------------------------------------------------------------
330:     PROTECTED PROCEDURE InicializarForm()
331:         LOCAL loc_lSucesso, loc_oErro
332:         loc_lSucesso = .F.
333: 
334:         TRY
335:             THIS.this_oBusinessObject = CREATEOBJECT("SigOpMopBO")
336: 
337:             IF VARTYPE(THIS.this_oBusinessObject) != "O"
338:                 MsgErro("Erro ao criar objeto de neg" + CHR(243) + "cio SigOpMopBO." + CHR(13) + ;
339:                         "VARTYPE retornou: " + VARTYPE(THIS.this_oBusinessObject), ;
340:                         "Erro em InicializarForm")
341:             ELSE
342:                 *-- Contexto do form chamador para o BO: a operacao PAI entra em
343:                 *-- cdopes de toda linha nova (InicializarValoresPadrao) e o modo
344:                 *-- governa quem pode inserir/excluir.
345:                 THIS.this_oBusinessObject.this_cOperacaoPai = THIS.this_cOperacaoPai
346:                 THIS.this_oBusinessObject.this_cEscolha     = THIS.this_cEscolha
347: 
348:                 THIS.Picture = gc_4c_CaminhoIcones + "new_background.jpg"
349: 
350:                 THIS.ConfigurarPageFrame()
351: 
352:                 *-- Caption nos dois labels da faixa, como o Init legado faz:
353:                 *-- ThisForm.cntSombra.lblSombra.Caption = ThisForm.Caption
354:                 *-- ThisForm.cntSombra.lblTitulo.Caption = ThisForm.Caption
355:                 THIS.cnt_4c_Sombra.lbl_4c_LblSombra.Caption = THIS.Caption
356:                 THIS.cnt_4c_Sombra.lbl_4c_LblTitulo.Caption = THIS.Caption
357: 
358:                 THIS.TornarControlesVisiveis(THIS)
359: 
360:                 *-- DEPOIS da varredura: ela forca Visible = .T. em tudo e
361:                 *-- apagaria a decisao de permissao de Inserir/Excluir.
362:                 THIS.AplicarPermissoesBotoes()
363: 
364:                 *-- Depois do ULTIMO AddObject: TabIndex fora da faixa 1..N eh
365:                 *-- descartado em silencio.
366:                 THIS.AjustarOrdemTabulacao()
367: 
368:                 *-- Configuracao da operacao + linhas da grade + bind visual
369:                 THIS.CarregarDados()
370: 
371:                 *-- "Thisform.ParentForm.Enabled = .F." + "Thisform.mCtrlBotoes(.F.)"
372:                 *-- do Init legado: o chamador (form inteiro + botoes
373:                 *-- granulares) fica inerte enquanto este dialogo esta aberto.
374:                 THIS.HabilitarFormPai(.F.)
375: 
376:                 loc_lSucesso = .T.
377:             ENDIF
378:         CATCH TO loc_oErro
379:             MsgErro(loc_oErro.Message + CHR(13) + ;
380:                     "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
381:                     "Procedure: " + loc_oErro.Procedure, ;
382:                     "Erro em InicializarForm")
383:         ENDTRY
384: 
385:         RETURN loc_lSucesso
386:     ENDPROC
387: 
388:     *--------------------------------------------------------------------------
389:     * ConfigurarPageFrame - orquestra a montagem visual da tela.
390:     *
391:     * NAO existe PageFrame real: o legado SIGOPMOP eh flat (a SECAO 1 do dump
392:     * nao declara nenhum objeto de BaseClass pageframe, e as referencias a
393:     * "Pagina.Lista" no codigo dos metodos sao do form PAI, via
394:     * Thisform.ParentForm.Pagina.Lista). O nome do metodo eh mantido por
395:     * conformidade com o contrato do pipeline multi-fase.
396:     *
397:     * ORDEM IMPORTA: os tres botoes do legado ficam em Top = 3 com altura de
398:     * botao do framework, ou seja DENTRO da area da faixa (Top 0, Height 80).
399:     * Eles tem de ser criados DEPOIS dela para desenhar POR CIMA - invertido,
400:     * o cabecalho cobriria Inserir/Excluir/Encerrar. Por isso a faixa eh o
401:     * PRIMEIRO AddObject da tela, e as chamadas das fases seguintes
402:     * (ConfigurarGrade/ConfigurarBotoes) entram ABAIXO desta linha.
403:     *--------------------------------------------------------------------------
404:     PROTECTED PROCEDURE ConfigurarPageFrame()
405:         *-- A ordem abaixo eh a ORDEM DA ARVORE do SCX (SECAO 1 do dump):
406:         *-- cntSombra -> GradeSubN -> Shape1 -> cmdExcluir/cmdSair/cmdInserir.
407:         *-- Isso NAO eh estilo, eh z-order: o Shape1 tem BackStyle = 0 E
408:         *-- BorderStyle = 0 (nao desenha NADA) e, depois do reposicionamento
409:         *-- que AplicarPermissoesBotoes faz, cobre a faixa dos tres botoes
410:         *-- (Left 528..769 / Top 7..48 contra botoes em Left 533..758 /
411:         *-- Top 3..78). Criado DEPOIS deles, esse retangulo invisivel ficaria
412:         *-- por cima e BLOQUEARIA o clique sem desenhar nada; no SCX ele vem
413:         *-- antes e os botoes recebem o clique.
414:         THIS.ConfigurarCabecalho()
415:         THIS.ConfigurarGrade()
416:         THIS.ConfigurarMoldura()
417:         THIS.ConfigurarBotoes()
418:     ENDPROC
419: 
420:     *--------------------------------------------------------------------------
421:     * ConfigurarCabecalho - faixa cinza do titulo (SIGOPMOP.cntSombra) com os
422:     * dois labels sobrepostos: lblSombra em preto por tras e lblTitulo em
423:     * branco por cima, o que produz o relevo do framework legado.
424:     *
425:     * Geometria TRANSCRITA do dump:
426:     *   cntSombra  Top=0  Left=0  Width=800 Height=80 BackColor=100,100,100
427:     *              BorderWidth=0
428:     *   lblSombra  Top=18 Left=10 Width=769 Height=40 ForeColor=0,0,0
429:     *              Tahoma 18 bold, BackStyle=0, WordWrap=.T., Alignment=0
430:     *   lblTitulo  Top=17 Left=10 Width=769 Height=46 ForeColor=255,255,255
431:     *              Tahoma 18 bold, BackStyle=0, WordWrap=.T., Alignment=0
432:     *
433:     * O Width = 800 do container legado eh MAIOR que o Width = 759 do form (o
434:     * cntSombra do framework.vcx vem dimensionado para a tela de 800px e fica
435:     * recortado nesta); aqui usa-se THIS.Width para a faixa cobrir a largura
436:     * real sem sobra nem corte - o resultado visivel eh o mesmo, porque o
437:     * excedente do legado nunca foi desenhado.
438:     *
439:     * AutoSize = .F. explicito nos dois labels: AutoSize eh no-op em Label
440:     * criado por AddObject (a largura ficaria nos 100 do default) e, com
441:     * WordWrap = .T., descartaria a Height transcrita e cortaria a segunda
442:     * linha do titulo. Os Width/Height do dump JA sao o auto-size que o Form
443:     * Designer calculou, entao fixa-los eh reproducao fiel.
444:     *
445:     * ForeColor branco eh legitimo AQUI: lbl_4c_LblTitulo esta dentro de um
446:     * container OPACO escuro (BackStyle = 1 + BackColor 100,100,100), nao
447:     * sobre a textura clara do fundo.
448:     *--------------------------------------------------------------------------
449:     PROTECTED PROCEDURE ConfigurarCabecalho()
450:         THIS.AddObject("cnt_4c_Sombra", "Container")
451:         WITH THIS.cnt_4c_Sombra
452:             .Top           = 0
453:             .Left          = 0
454:             .Width         = THIS.Width
455:             .Height        = 80
456:             .BackStyle     = 1
457:             .BackColor     = RGB(100, 100, 100)
458:             .BorderWidth   = 0
459:             .SpecialEffect = 0
460:             .Visible       = .T.
461:         ENDWITH
462: 
463:         THIS.cnt_4c_Sombra.AddObject("lbl_4c_LblSombra", "Label")
464:         WITH THIS.cnt_4c_Sombra.lbl_4c_LblSombra
465:             .Top           = 18
466:             .Left          = 10
467:             .Width         = 769
468:             .Height        = 40
469:             .AutoSize      = .F.
470:             .BackStyle     = 0
471:             .WordWrap      = .T.
472:             .Alignment     = 0
473:             .FontName      = "Tahoma"
474:             .FontSize      = 18
475:             .FontBold      = .T.
476:             .FontUnderline = .F.
477:             .ForeColor     = RGB(0, 0, 0)
478:             .Caption       = THIS.Caption
479:             .Visible       = .T.
480:         ENDWITH
481: 
482:         THIS.cnt_4c_Sombra.AddObject("lbl_4c_LblTitulo", "Label")
483:         WITH THIS.cnt_4c_Sombra.lbl_4c_LblTitulo
484:             .Top         = 17
485:             .Left        = 10
486:             .Width       = 769
487:             .Height      = 46
488:             .AutoSize    = .F.
489:             .BackStyle   = 0

*-- Linhas 514 a 761:
514:     * posicao do alias. Se for coluna de TEXTO, o AddObject do CheckBox da
515:     * coluna "Padrao" estoura "Data type mismatch" DENTRO do AddObject (o
516:     * .Value do CheckBox nasce NUMERICO) - e o erro cai no TRY de
517:     * InicializarForm, que devolve .F., o CREATEOBJECT devolve o logico .F. e
518:     * o usuario aciona a opcao e NADA acontece, sem erro na tela e sem log.
519:     *
520:     * Por isso a sequencia INTEIRA (ColumnCount -> RecordSource ->
521:     * ControlSource de TODAS as colunas -> AddObject do CheckBox ->
522:     * CurrentControl -> largura/cabecalho) vive num funil unico, MontaGrade,
523:     * que roda em TODA repintura - nao aqui.
524:     *
525:     * RecordMark/DeleteMark em .F.: o dump declara so DeleteMark = .F. (a
526:     * classe eh "grid" cru, entao RecordMark ficava no default .T.), mas a
527:     * convencao do projeto para grade de form OPERACIONAL criada por
528:     * AddObject eh desligar as DUAS barras de marcacao. Nao ha perda
529:     * funcional - a linha corrente, que eh o que o botao Excluir consome,
530:     * tambem muda ao clicar em qualquer celula.
531:     *--------------------------------------------------------------------------
532:     PROTECTED PROCEDURE ConfigurarGrade()
533:         THIS.AddObject("grd_4c_Dados", "Grid")
534: 
535:         WITH THIS.grd_4c_Dados
536:             .Top           = 99
537:             .Left          = 58
538:             .Width         = 483
539:             .Height        = 311
540:             .FontName      = "Tahoma"
541:             .FontSize      = 8
542:             .RowHeight     = 16
543:             .ScrollBars    = 2
544:             .DeleteMark    = .F.
545:             .RecordMark    = .F.
546:             .GridLineColor = RGB(238, 238, 238)
547:             .ReadOnly      = .F.
548:             .Visible       = .T.
549:         ENDWITH
550:     ENDPROC
551: 
552:     *--------------------------------------------------------------------------
553:     * ConfigurarMoldura - Shape que emoldura a barra de botoes
554:     * (SIGOPMOP.Shape1), geometria TRANSCRITA do dump:
555:     *
556:     *   Shape1  Top=7 Left=229 Height=41 Width=59
557:     *           BackStyle=0  BorderStyle=0  BorderColor=136,189,188
558:     *
559:     * BackStyle = 0 (transparente) com BorderStyle = 0 (sem borda) significa
560:     * que este Shape NAO desenha nada - nem fundo, nem contorno. Ele eh
561:     * transcrito por fidelidade (PILAR 1) e porque o Init legado reposiciona
562:     * Left/Width dele em funcao de QUAIS botoes ficaram visiveis; esse
563:     * recalculo esta em AplicarPermissoesBotoes, com os valores de 229/59
564:     * aqui representando o estado de projeto, antes do ajuste.
565:     *
566:     * BorderColor transcrito mesmo com BorderStyle = 0: eh o valor do dump, e
567:     * manter os dois juntos deixa explicito que o invisivel eh intencional, e
568:     * nao propriedade esquecida.
569:     *--------------------------------------------------------------------------
570:     PROTECTED PROCEDURE ConfigurarMoldura()
571:         THIS.AddObject("shp_4c_Shape1", "Shape")
572: 
573:         WITH THIS.shp_4c_Shape1
574:             .Top         = 7
575:             .Left        = 229
576:             .Height      = 41
577:             .Width       = 59
578:             .BackStyle   = 0
579:             .BorderStyle = 0
580:             .BorderColor = RGB(136, 189, 188)
581:             .Visible     = .T.
582:         ENDWITH
583:     ENDPROC
584: 
585:     *--------------------------------------------------------------------------
586:     * ConfigurarBotoes - os TRES botoes da tela, pendurados DIRETO na Form
587:     * (nao ha container de botoes nem CommandGroup no SCX - a SECAO 1 lista
588:     * cmdExcluir/cmdSair/cmdInserir todos com "Parent: SIGOPMOP").
589:     *
590:     * Geometria TRANSCRITA do dump:
591:     *   cmdInserir Top=3 Left=533 Picture=cadastro_inserir_60.jpg Caption="Inserir"  TabIndex=4
592:     *   cmdExcluir Top=3 Left=608 Picture=cadastro_excluir_60.jpg Caption="Excluir"  TabIndex=2
593:     *   cmdSair    Top=3 Left=683 Picture=cadastro_sair_60.jpg    Caption="Encerrar" TabIndex=3 Cancel=.T.
594:     *
595:     * Width/Height: o dump NAO os declara (vinham da classe fwbtng do
596:     * framework legado, que nao foi portada). O passo entre os Left do SCX eh
597:     * de EXATAMENTE 75 (533 -> 608 -> 683), e 683 + 75 = 758 fecha na borda do
598:     * form de 759 - logo 75x75 eh a medida que o layout legado pressupoe, e eh
599:     * tambem a medida canonica dos botoes do projeto. As posicoes canonicas de
600:     * cnt_4c_Saida (Left = 917) NAO se aplicam aqui: sao dos cadastros de
601:     * 1000px e cairiam 158px fora desta tela.
602:     *
603:     * Picture TRANSCRITO do dump, nunca escolhido por semelhanca: o VFP9
604:     * aceita .Picture apontando para arquivo inexistente em SILENCIO (sem erro
605:     * de compilacao, sem erro de runtime, sem log) e o botao simplesmente nao
606:     * desenha icone. Os tres arquivos foram conferidos em vbmp\.
607:     *
608:     * Themes = .T. + DisabledPicture: estes sao CommandButton STANDALONE (fora
609:     * de CommandGroup) e o legado DESABILITA dois deles por permissao. Com
610:     * Themes = .F. + Enabled = .F. o icone nao renderiza e o botao vira uma
611:     * caixa com texto. A excecao Themes = .F. vale para Buttons(N) DENTRO de
612:     * CommandGroup, que nao eh o caso aqui.
613:     *
614:     * Enabled = .T. e Visible = .T. nascem ligados: quem decide eh
615:     * AplicarPermissoesBotoes, que roda DEPOIS de TornarControlesVisiveis
616:     * (essa varredura forca Visible = .T. em tudo e apagaria a decisao).
617:     *--------------------------------------------------------------------------
618:     PROTECTED PROCEDURE ConfigurarBotoes()
619:         *-- Ordem de criacao = ordem da arvore do SCX
620:         THIS.AddObject("cmd_4c_CmdExcluir", "CommandButton")
621:         WITH THIS.cmd_4c_CmdExcluir
622:             .Top             = 3
623:             .Left            = 608
624:             .Width           = 75
625:             .Height          = 75
626:             .Caption         = "Excluir"
627:             .Picture         = gc_4c_CaminhoIcones + "cadastro_excluir_60.jpg"
628:             .DisabledPicture = gc_4c_CaminhoIcones + "cadastro_excluir_60.jpg"
629:             .PicturePosition = 13
630:             .Themes          = .T.
631:             .SpecialEffect   = 0
632:             .FontName        = "Comic Sans MS"
633:             .FontSize        = 8
634:             .FontBold        = .T.
635:             .FontItalic      = .T.
636:             .ForeColor       = RGB(90, 90, 90)
637:             .BackColor       = RGB(255, 255, 255)
638:             .MousePointer    = 15
639:             .WordWrap        = .T.
640:             .AutoSize        = .F.
641:             .ToolTipText     = "Excluir a linha corrente da grade"
642:             .Enabled         = .T.
643:             .Visible         = .T.
644:         ENDWITH
645:         BINDEVENT(THIS.cmd_4c_CmdExcluir, "Click", THIS, "BtnExcluirClick")
646: 
647:         THIS.AddObject("cmd_4c_CmdSair", "CommandButton")
648:         WITH THIS.cmd_4c_CmdSair
649:             .Top             = 3
650:             .Left            = 683
651:             .Width           = 75
652:             .Height          = 75
653:             .Caption         = "Encerrar"
654:             .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
655:             .DisabledPicture = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
656:             .PicturePosition = 13
657:             .Themes          = .T.
658:             .SpecialEffect   = 0
659:             .FontName        = "Comic Sans MS"
660:             .FontSize        = 8
661:             .FontBold        = .T.
662:             .FontItalic      = .T.
663:             .ForeColor       = RGB(90, 90, 90)
664:             .BackColor       = RGB(255, 255, 255)
665:             .MousePointer    = 15
666:             .WordWrap        = .T.
667:             .AutoSize        = .F.
668:             *-- Cancel = .T. TRANSCRITO do dump: eh o que faz o ESC encerrar o
669:             *-- dialogo, e eh a UNICA saida desta tela (TitleBar = 0 e
670:             *-- ControlBox = .F., ou seja nao ha botao de fechar da janela).
671:             .Cancel          = .T.
672:             .ToolTipText     = "Gravar as altera" + CHR(231) + CHR(245) + "es e encerrar"
673:             .Enabled         = .T.
674:             .Visible         = .T.
675:         ENDWITH
676:         BINDEVENT(THIS.cmd_4c_CmdSair, "Click", THIS, "BtnEncerrarClick")
677: 
678:         THIS.AddObject("cmd_4c_CmdInserir", "CommandButton")
679:         WITH THIS.cmd_4c_CmdInserir
680:             .Top             = 3
681:             .Left            = 533
682:             .Width           = 75
683:             .Height          = 75
684:             .Caption         = "Inserir"
685:             .Picture         = gc_4c_CaminhoIcones + "cadastro_inserir_60.jpg"
686:             .DisabledPicture = gc_4c_CaminhoIcones + "cadastro_inserir_60.jpg"
687:             .PicturePosition = 13
688:             .Themes          = .T.
689:             .SpecialEffect   = 0
690:             .FontName        = "Comic Sans MS"
691:             .FontSize        = 8
692:             .FontBold        = .T.
693:             .FontItalic      = .T.
694:             .ForeColor       = RGB(90, 90, 90)
695:             .BackColor       = RGB(255, 255, 255)
696:             .MousePointer    = 15
697:             .WordWrap        = .T.
698:             .AutoSize        = .F.
699:             .ToolTipText     = "Inserir uma nova opera" + CHR(231) + CHR(227) + "o na grade"
700:             .Enabled         = .T.
701:             .Visible         = .T.
702:         ENDWITH
703:         BINDEVENT(THIS.cmd_4c_CmdInserir, "Click", THIS, "BtnInserirClick")
704:     ENDPROC
705: 
706:     *--------------------------------------------------------------------------
707:     * HabilitarFormPai - liga/desliga o form chamador E os botoes granulares
708:     * dele, equivalente ao par que o legado sempre aciona JUNTO:
709:     *   Init:          Thisform.ParentForm.Enabled = .F. + Thisform.mCtrlBotoes(.F.)
710:     *   cmdSair.Click: Thisform.ParentForm.Enabled = .T. + Thisform.mCtrlBotoes(.T.)
711:     *
712:     * O controle GRANULAR (mCtrlBotoes do legado) mora em
713:     * ControlarBotoesFormPai - aqui so delega, com o MESMO par_lHabilitar,
714:     * porque o legado nunca desacopla os dois.
715:     *
716:     * Guardado por PEMSTATUS porque o dialogo tambem pode ser instanciado sem
717:     * pai (harness de teste e validacao de UI chamam CREATEOBJECT sem
718:     * parametro) - sem a guarda, o Init falharia nesse cenario e o
719:     * CREATEOBJECT devolveria valor nao-objeto.
720:     *--------------------------------------------------------------------------
721:     PROCEDURE HabilitarFormPai(par_lHabilitar)
722:         LOCAL loc_lHabilitar
723:         loc_lHabilitar = IIF(VARTYPE(par_lHabilitar) = "L", par_lHabilitar, .F.)
724: 
725:         IF VARTYPE(THIS.this_oFormPai) = "O"
726:             IF PEMSTATUS(THIS.this_oFormPai, "Enabled", 5)
727:                 THIS.this_oFormPai.Enabled = loc_lHabilitar
728:             ENDIF
729:         ENDIF
730: 
731:         THIS.ControlarBotoesFormPai(loc_lHabilitar)
732:     ENDPROC
733: 
734:     *--------------------------------------------------------------------------
735:     * ControlarBotoesFormPai - equivalente ao mCtrlBotoes(plHabilita) do
736:     * legado (metodo do proprio SIGOPMOP): desliga/religa GRANULARMENTE os
737:     * botoes do form chamador, alem do Enabled do form inteiro que
738:     * HabilitarFormPai ja cobre.
739:     *
740:     * TRANSCRITO do legado:
741:     *   With Thisform.ParentForm.Pagina.Lista
742:     *       For lnI=1 to .Grupo_Op.ButtonCount
743:     *           If .Grupo_Op.Buttons(lnI).BaseClass = 'Commandbutton' And ;
744:     *              .Grupo_Op.Buttons(lnI).Visible
745:     *               .Grupo_Op.Buttons(lnI).Enabled = plHabilita
746:     *           EndIf
747:     *       EndFor
748:     *       .cmdFPOper.Enabled = plHabilita
749:     *       .cmdMultiSubN.Enabled = plHabilita
750:     *       .Grupo_Saida.Sair.Enabled = plHabilita
751:     *   EndWith
752:     *
753:     * Mapeamento para a arquitetura nova (FormOPE - Cadastro de Operacoes,
754:     * na Page1 - Lista):
755:     *   Grupo_Op (CommandGroup CRUD)   -> cnt_4c_Botoes (Container com
756:     *       cmd_4c_Incluir/Alterar/Visualizar/Excluir/Buscar)
757:     *   cmdMultiSubN (abre ESTE dialogo) -> cmd_4c_MultiSubN
758:     *   Grupo_Saida.Sair                 -> cnt_4c_Saida.cmd_4c_Encerrar
759:     *       (padrao canonico de saida - CLAUDE.md regra #10)
760:     *
761:     * cmdFPOper NAO tem equivalente confirmado no FormOPE migrado (nenhum

*-- Linhas 767 a 810:
767:     * dialogo pode ser instanciado sem pai (harness) - ausencia de qualquer
768:     * peca so faz esta parte da rotina ser pulada, nunca estoura o Click.
769:     *--------------------------------------------------------------------------
770:     PROTECTED PROCEDURE ControlarBotoesFormPai(par_lHabilitar)
771:         LOCAL loc_lHabilitar, loc_oPaginaLista, loc_oBotoesCrud, loc_nI, loc_oBotao
772:         loc_lHabilitar = IIF(VARTYPE(par_lHabilitar) = "L", par_lHabilitar, .F.)
773: 
774:         IF VARTYPE(THIS.this_oFormPai) != "O"
775:             RETURN
776:         ENDIF
777: 
778:         IF !PEMSTATUS(THIS.this_oFormPai, "pgf_4c_Paginas", 5)
779:             RETURN
780:         ENDIF
781: 
782:         IF !PEMSTATUS(THIS.this_oFormPai.pgf_4c_Paginas, "Page1", 5)
783:             RETURN
784:         ENDIF
785: 
786:         loc_oPaginaLista = THIS.this_oFormPai.pgf_4c_Paginas.Page1
787: 
788:         *-- Grupo_Op do legado -> cnt_4c_Botoes (grupo CRUD) na pagina Lista.
789:         IF PEMSTATUS(loc_oPaginaLista, "cnt_4c_Botoes", 5)
790:             loc_oBotoesCrud = loc_oPaginaLista.cnt_4c_Botoes
791: 
792:             FOR loc_nI = 1 TO loc_oBotoesCrud.ControlCount
793:                 loc_oBotao = loc_oBotoesCrud.Controls(loc_nI)
794: 
795:                 IF VARTYPE(loc_oBotao) = "O" AND UPPER(loc_oBotao.BaseClass) == "COMMANDBUTTON" AND ;
796:                    PEMSTATUS(loc_oBotao, "Visible", 5) AND loc_oBotao.Visible AND ;
797:                    PEMSTATUS(loc_oBotao, "Enabled", 5)
798:                     loc_oBotao.Enabled = loc_lHabilitar
799:                 ENDIF
800:             ENDFOR
801:         ENDIF
802: 
803:         *-- cmdMultiSubN do legado -> cmd_4c_MultiSubN (o proprio botao que
804:         *-- abre este dialogo), na mesma pagina.
805:         IF PEMSTATUS(loc_oPaginaLista, "cmd_4c_MultiSubN", 5)
806:             loc_oPaginaLista.cmd_4c_MultiSubN.Enabled = loc_lHabilitar
807:         ENDIF
808: 
809:         *-- Grupo_Saida.Sair do legado -> cnt_4c_Saida.cmd_4c_Encerrar.
810:         IF PEMSTATUS(loc_oPaginaLista, "cnt_4c_Saida", 5)

*-- Linhas 839 a 1125:
839:     * insere a linha DIRETO no cursor da grade, igual ao legado, e nao via
840:     * NovoRegistro()/BO (regra #51 - BO nao eh chamado para isto).
841:     *
842:     * PUBLIC (nao PROTECTED): alvo de BINDEVENT - regra CLAUDE.md #3.
843:     *--------------------------------------------------------------------------
844:     PROCEDURE BtnInserirClick()
845:         LOCAL loc_cCursor, loc_oErro
846: 
847:         TRY
848:             loc_cCursor = THIS.this_cCursorDados
849: 
850:             IF !USED(loc_cCursor)
851:                 MsgErro("Cursor da grade n" + CHR(227) + "o dispon" + CHR(237) + ;
852:                         "vel.", "Erro em BtnInserirClick")
853:             ELSE
854:                 THIS.this_lHouveInsercao = .T.
855: 
856:                 SELECT (loc_cCursor)
857:                 LOCATE FOR ALLTRIM(cdopes) == ALLTRIM(THIS.this_cOperacaoPai) AND ;
858:                            EMPTY(ALLTRIM(cnivels))
859: 
860:                 IF EOF()
861:                     INSERT INTO (loc_cCursor) (cdopes, cidchaves) ;
862:                         VALUES (ALLTRIM(THIS.this_cOperacaoPai), fUniqueIds())
863:                 ENDIF
864: 
865:                 SELECT (loc_cCursor)
866:                 THIS.grd_4c_Dados.Refresh()
867:                 THIS.grd_4c_Dados.Column1.SetFocus()
868:             ENDIF
869:         CATCH TO loc_oErro
870:             MsgErro(loc_oErro.Message + CHR(13) + ;
871:                     "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
872:                     "Procedure: " + loc_oErro.Procedure, ;
873:                     "Erro em BtnInserirClick")
874:         ENDTRY
875:     ENDPROC
876: 
877:     *--------------------------------------------------------------------------
878:     * BtnExcluirClick - Click de cmd_4c_CmdExcluir ("Excluir").
879:     *
880:     * TRANSCRITO do legado (SIGOPMOP.cmdExcluir.Click):
881:     *   Select crSigCdMop
882:     *   If Not Eof() And ( crSigCdMop.cDopes = crSigCdOpe.Dopes )
883:     *       Thisform.lHouveExcl = .T.
884:     *       Delete
885:     *       Skip
886:     *       Skip - 1
887:     *   Endif
888:     *   Thisform.GradeSubN.Refresh
889:     *
890:     * SET DELETED ON eh global (start\config.prg) - o DELETE some da grade
891:     * e do LOCATE/SCAN imediatamente, igual ao legado. A linha apagada pode
892:     * ja existir no SQL Server (cidchaves gravado numa sessao anterior) -
893:     * quem resolve isso no commit eh a Fase 8, que ainda nao existe aqui.
894:     *
895:     * PUBLIC (nao PROTECTED): alvo de BINDEVENT - regra CLAUDE.md #3.
896:     *--------------------------------------------------------------------------
897:     PROCEDURE BtnExcluirClick()
898:         LOCAL loc_cCursor, loc_oErro
899: 
900:         TRY
901:             loc_cCursor = THIS.this_cCursorDados
902: 
903:             IF USED(loc_cCursor)
904:                 SELECT (loc_cCursor)
905: 
906:                 IF !EOF() AND ALLTRIM(cdopes) == ALLTRIM(THIS.this_cOperacaoPai)
907:                     THIS.this_lHouveExclusao = .T.
908:                     DELETE
909:                     SKIP
910:                     SKIP -1
911:                 ENDIF
912:             ENDIF
913: 
914:             THIS.grd_4c_Dados.Refresh()
915:         CATCH TO loc_oErro
916:             MsgErro(loc_oErro.Message + CHR(13) + ;
917:                     "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
918:                     "Procedure: " + loc_oErro.Procedure, ;
919:                     "Erro em BtnExcluirClick")
920:         ENDTRY
921:     ENDPROC
922: 
923:     *--------------------------------------------------------------------------
924:     * BtnEncerrarClick - Click de cmd_4c_CmdSair ("Encerrar"), ligado tambem
925:     * ao ESC (.Cancel = .T. em ConfigurarBotoes) - a UNICA saida desta tela,
926:     * que nao tem ControlBox nem TitleBar.
927:     *
928:     * TRANSCRITO do legado (SIGOPMOP.cmdSair.Click):
929:     *   If Thisform.cmdInserir.Visible Or Thisform.cmdExcluir.Visible
930:     *       If ( Thisform.lHouveExcl Or Thisform.lHouveIns )
931:     *           <checagem de duplicidade + UpDate/Commit/RollBack do cursor>
932:     *       EndIf
933:     *   EndIf
934:     *   Thisform.ParentForm.Enabled = .T.
935:     *   Thisform.mCtrlBotoes(.T.)
936:     *   ThisForm.Release
937:     *
938:     * Os DOIS guards do legado sao regra, nao detalhe (regra #21b - "a condicao
939:     * que CERCA a validacao faz parte dela"):
940:     *
941:     *   1) "If Thisform.cmdInserir.Visible Or Thisform.cmdExcluir.Visible"
942:     *      So grava quando a tela esta em modo de EDICAO. Em PROCURAR os dois
943:     *      botoes ficam invisiveis (AplicarPermissoesBotoes, transcrito do Init
944:     *      legado) e NADA eh persistido - mesmo que o usuario tenha digitado nas
945:     *      celulas, porque o legado nao trava a grade em consulta: quem impede a
946:     *      gravacao eh exatamente este teste. Trocar por um teste de modo
947:     *      (this_cEscolha) daria o mesmo resultado hoje, mas deixaria de seguir
948:     *      a permissao do usuario (fChecaAcesso), que tambem entra na
949:     *      visibilidade.
950:     *
951:     *   2) "If ( Thisform.lHouveExcl Or Thisform.lHouveIns )"
952:     *      Nada mudou, nada a gravar - e nenhuma ida ao banco.
953:     *
954:     * Na duplicidade o legado faz "Return .f." de DENTRO do Click: a tela NAO
955:     * fecha, o form pai continua desabilitado e o usuario volta a grade para
956:     * corrigir. Na falha de GRAVACAO o legado so avisa e segue fechando - sao
957:     * dois desfechos DIFERENTES, por isso a checagem de duplicidade
958:     * (ValidarDuplicidadeGrade) e a gravacao (GravarGrade) sao metodos
959:     * separados e so a primeira pode abortar o encerramento.
960:     *
961:     * PUBLIC (nao PROTECTED): alvo de BINDEVENT e nome CANONICO que
962:     * TesteAutomatico.prg procura (TesteBtnEncerrarExiste) - regras #3 e #51.
963:     *--------------------------------------------------------------------------
964:     PROCEDURE BtnEncerrarClick()
965:         LOCAL loc_lEncerra, loc_oErro
966:         loc_lEncerra = .T.
967: 
968:         TRY
969:             IF THIS.cmd_4c_CmdInserir.Visible OR THIS.cmd_4c_CmdExcluir.Visible
970:                 IF THIS.this_lHouveExclusao OR THIS.this_lHouveInsercao
971:                     IF THIS.ValidarDuplicidadeGrade()
972:                         THIS.GravarGrade()
973:                     ELSE
974:                         loc_lEncerra = .F.
975:                     ENDIF
976:                 ENDIF
977:             ENDIF
978:         CATCH TO loc_oErro
979:             *-- Encerra mesmo assim (o legado tambem fecha quando a gravacao
980:             *-- falha); o que nao pode acontecer eh a falha ficar muda.
981:             MsgErro(loc_oErro.Message + CHR(13) + ;
982:                     "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
983:                     "Procedure: " + loc_oErro.Procedure, ;
984:                     "Erro em BtnEncerrarClick")
985:         ENDTRY
986: 
987:         *-- Cauda do cmdSair.Click legado, FORA do TRY:
988:         *--   Thisform.ParentForm.Enabled = .T.
989:         *--   Thisform.mCtrlBotoes(.T.)
990:         *--   ThisForm.Release
991:         *-- HabilitarFormPai cobre as duas primeiras linhas. Ela roda tambem no
992:         *-- Destroy (funil de QUALQUER caminho de fechamento) e eh idempotente:
993:         *-- chamar duas vezes com .T. nao tem efeito extra.
994:         IF loc_lEncerra
995:             THIS.HabilitarFormPai(.T.)
996:             THIS.Release()
997:         ENDIF
998:     ENDPROC
999: 
1000:     *--------------------------------------------------------------------------
1001:     * ValidarDuplicidadeGrade - checagem de duplicidade do cmdSair.Click.
1002:     *
1003:     * TRANSCRITA do legado:
1004:     *   Select CrSigCdMop
1005:     *   Go Bott
1006:     *   Go Top
1007:     *   Select cNivels as Dopes, Mercs, EmpDs, sum(1) as TT ;
1008:     *       From CrSigCdMop GROUP by 1,2,3 Into cursor Totais
1009:     *   Select Totais
1010:     *   Scan
1011:     *       If TT > 1
1012:     *           MessageBox('Operacao '+Alltrim(Totais.Dopes)+
1013:     *                      ' Digitada em Duplicidade!!!!',0+16,'Atencao')
1014:     *           Return .f.
1015:     *       EndIf
1016:     *   EndScan
1017:     *
1018:     * O trio de agrupamento eh cNivels + Mercs + EmpDs, NAO cNivels sozinho: a
1019:     * MESMA operacao filha pode repetir desde que o grande grupo ou a empresa de
1020:     * destino sejam diferentes. Reduzir a chave recusaria gravacao legitima.
1021:     *
1022:     * "Go Bott / Go Top" eh o idioma do legado para forcar a view remota a
1023:     * buscar TODAS as linhas antes de agrupar - num cursor LOCAL nao ha busca
1024:     * preguicosa e as duas linhas nao tem efeito, por isso nao foram
1025:     * transcritas. O que foi transcrito eh o que elas protegiam: o SELECT ve o
1026:     * cursor inteiro.
1027:     *
1028:     * MsgAviso, e nao MsgErro, apesar do icone 16 (Critical) do legado:
1029:     * duplicidade digitada eh validacao de ENTRADA do usuario, e a convencao do
1030:     * projeto reserva o dialogo vermelho (com "Fechar Aplicacao") para falha
1031:     * tecnica. A mensagem e o momento sao os mesmos.
1032:     *
1033:     * O RECNO corrente eh salvo e devolvido: o SELECT ... GROUP BY troca a area
1034:     * de trabalho e o usuario tem de voltar a encontrar a grade na linha em que
1035:     * estava para corrigir a duplicidade.
1036:     *
1037:     * PUBLIC: chamado por BtnEncerrarClick, que eh alvo de BINDEVENT, e util
1038:     * como ponto de verificacao de fora em teste.
1039:     *--------------------------------------------------------------------------
1040:     PROCEDURE ValidarDuplicidadeGrade()
1041:         LOCAL loc_lValido, loc_cCursor, loc_cTotais, loc_nRecno, loc_oErro
1042:         loc_lValido = .T.
1043:         loc_cCursor = THIS.this_cCursorDados
1044:         loc_cTotais = "cursor_4c_TotaisMop"
1045: 
1046:         TRY
1047:             IF USED(loc_cCursor)
1048:                 SELECT (loc_cCursor)
1049:                 loc_nRecno = RECNO()
1050: 
1051:                 IF USED(loc_cTotais)
1052:                     USE IN (loc_cTotais)
1053:                 ENDIF
1054: 
1055:                 SELECT cnivels AS dopes, mercs, empds, COUNT(*) AS tt ;
1056:                     FROM (loc_cCursor) ;
1057:                     GROUP BY 1, 2, 3 ;
1058:                     INTO CURSOR (loc_cTotais) READWRITE
1059: 
1060:                 SELECT (loc_cTotais)
1061:                 SCAN FOR tt > 1
1062:                     MsgAviso("Opera" + CHR(231) + CHR(227) + "o " + ;
1063:                              ALLTRIM(NVL(dopes, "")) + ;
1064:                              " Digitada em Duplicidade!!!!", ;
1065:                              "Aten" + CHR(231) + CHR(227) + "o")
1066:                     loc_lValido = .F.
1067:                     EXIT
1068:                 ENDSCAN
1069: 
1070:                 IF USED(loc_cTotais)
1071:                     USE IN (loc_cTotais)
1072:                 ENDIF
1073: 
1074:                 *-- Devolve o ponteiro da grade a linha em que o usuario estava.
1075:                 SELECT (loc_cCursor)
1076:                 IF BETWEEN(loc_nRecno, 1, RECCOUNT(loc_cCursor))
1077:                     GO (loc_nRecno)
1078:                 ENDIF
1079:                 THIS.grd_4c_Dados.Refresh()
1080:             ENDIF
1081:         CATCH TO loc_oErro
1082:             loc_lValido = .F.
1083:             MsgErro(loc_oErro.Message + CHR(13) + ;
1084:                     "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1085:                     "Procedure: " + loc_oErro.Procedure, ;
1086:                     "Erro em ValidarDuplicidadeGrade")
1087:         ENDTRY
1088: 
1089:         RETURN loc_lValido
1090:     ENDPROC
1091: 
1092:     *--------------------------------------------------------------------------
1093:     * GravarGrade - persiste a grade inteira em SigCdMop.
1094:     *
1095:     * Equivale ao bloco de gravacao do cmdSair.Click legado:
1096:     *   m.lnErro1 = SigCdOpe.poDatamgr.pnIdConn
1097:     *   With SigCdOpe
1098:     *       If m.lnErro1>0
1099:     *           m.lnErro1 = Iif(.poDataMgr.UpDate('crSigCdMop'),1,-1)
1100:     *       EndIf
1101:     *       If m.lnErro1>0
1102:     *           m.lnErro1 = .poDataMgr.Commit()
1103:     *       EndIf
1104:     *       If Not m.lnErro1>0
1105:     *           .poDataMgr.RollBack()
1106:     *       EndIf
1107:     *   EndWith
1108:     *   If Not m.lnErro1>0
1109:     *       = MessageBox('Erro na Gravacao dos Dados do Cadastro de Operacoes.',48)
1110:     *   EndIf
1111:     *
1112:     * O "UpDate('crSigCdMop')" do legado eh um TABLEUPDATE de VIEW REMOTA: o
1113:     * buffer sabia, registro por registro, quem era novo, alterado ou apagado.
1114:     * O cursor desta arquitetura NAO guarda esse estado - ele nasce de um
1115:     * "SELECT ... INTO CURSOR ... READWRITE", cujo Buffering eh 1 (regra #52),
1116:     * entao INSERT/DELETE no cursor nao esperam em buffer nenhum.
1117:     *
1118:     * O estado eh portanto RECONSTRUIDO por RECONCILIACAO contra o banco, numa
1119:     * unica consulta (BO.CarregarChavesGravadas):
1120:     *
1121:     *   chave na grade   E   no banco -> UPDATE  (BO.Salvar com registro existente)
1122:     *   chave na grade e NAO no banco -> INSERT  (BO.Salvar com registro novo)
1123:     *   chave no banco e NAO na grade -> DELETE  (BO.Excluir)
1124:     *
1125:     * A terceira linha eh o que substitui o DELETE do TABLEUPDATE: linha que o

*-- Linhas 1148 a 1193:
1148:     * resto do metodo: eh o idioma do projeto para gravacao e deixa as duas
1149:     * unicas linhas que escrevem no banco visiveis numa busca pelo nome do BO.
1150:     *
1151:     * PUBLIC: chamado por BtnEncerrarClick, que eh alvo de BINDEVENT.
1152:     *--------------------------------------------------------------------------
1153:     PROCEDURE GravarGrade()
1154:         LOCAL loc_lSucesso, loc_lFalhou, loc_oBO, loc_cCursor, loc_cChaves
1155:         LOCAL loc_nRecno, loc_nLinha, loc_cChave, loc_lNovo, loc_cMensagem
1156:         LOCAL loc_oErro
1157: 
1158:         loc_lSucesso = .F.
1159:         loc_lFalhou  = .F.
1160:         loc_nRecno   = 0
1161: 
1162:         TRY
1163:             loc_oBO     = THIS.this_oBusinessObject
1164:             loc_cCursor = THIS.this_cCursorDados
1165: 
1166:             DO CASE
1167:                 CASE VARTYPE(loc_oBO) != "O"
1168:                     MsgErro("Objeto de neg" + CHR(243) + "cio n" + CHR(227) + ;
1169:                             "o dispon" + CHR(237) + "vel para gravar a grade.", ;
1170:                             "Erro em GravarGrade")
1171: 
1172:                 CASE !USED(loc_cCursor)
1173:                     MsgErro("Cursor da grade n" + CHR(227) + "o dispon" + CHR(237) + ;
1174:                             "vel para gravar.", "Erro em GravarGrade")
1175: 
1176:                 CASE !loc_oBO.ConexaoAtiva()
1177:                     *-- Equivale ao "If m.lnErro1>0" do legado, que testa
1178:                     *-- poDataMgr.pnIdConn antes de tentar o UpDate.
1179:                     MsgErro("Sem conex" + CHR(227) + "o com o banco: as altera" + ;
1180:                             CHR(231) + CHR(245) + "es da grade N" + CHR(195) + "O foram " + ;
1181:                             "gravadas.", "Erro em GravarGrade")
1182: 
1183:                 CASE !loc_oBO.CarregarChavesGravadas()
1184:                     loc_cMensagem = ALLTRIM(NVL(loc_oBO.this_cMensagemErro, ""))
1185:                     IF EMPTY(loc_cMensagem)
1186:                         loc_cMensagem = "N" + CHR(227) + "o foi poss" + CHR(237) + ;
1187:                             "vel ler as opera" + CHR(231) + CHR(245) + "es j" + CHR(225) + ;
1188:                             " gravadas."
1189:                     ENDIF
1190:                     MsgErro(loc_cMensagem, "Erro em GravarGrade")
1191: 
1192:                 OTHERWISE
1193:                     loc_cChaves = loc_oBO.this_cCursorChaves

*-- Linhas 1339 a 1430:
1339:                                 ALLTRIM(loc_oBO.this_cMensagemErro)
1340:                         ENDIF
1341: 
1342:                         MsgAviso(loc_cMensagem, "Aten" + CHR(231) + CHR(227) + "o")
1343:                     ENDIF
1344: 
1345:                     IF USED(loc_cChaves)
1346:                         USE IN (loc_cChaves)
1347:                     ENDIF
1348:             ENDCASE
1349: 
1350:         CATCH TO loc_oErro
1351:             loc_lSucesso = .F.
1352:             MsgErro(loc_oErro.Message + CHR(13) + ;
1353:                     "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1354:                     "Procedure: " + loc_oErro.Procedure, ;
1355:                     "Erro em GravarGrade")
1356:         ENDTRY
1357: 
1358:         *-- Devolve o ponteiro da grade a linha em que o usuario estava.
1359:         IF USED(THIS.this_cCursorDados) AND loc_nRecno > 0
1360:             SELECT (THIS.this_cCursorDados)
1361:             IF BETWEEN(loc_nRecno, 1, RECCOUNT(THIS.this_cCursorDados))
1362:                 GO (loc_nRecno)
1363:             ENDIF
1364:         ENDIF
1365: 
1366:         RETURN loc_lSucesso
1367:     ENDPROC
1368: 
1369:     *--------------------------------------------------------------------------
1370:     * LocalizarChave - devolve .T. quando par_cChave existe em par_cAlias.
1371:     *
1372:     * LOCATE com ALLTRIM e "==", e nao SEEK sobre indice, de proposito: o
1373:     * projeto roda com SET EXACT ON (start\config.prg), e sob EXACT ON o SEEK
1374:     * exige a chave COMPLETA do indice - comparar char(20) exigiria reproduzir o
1375:     * padding exato dos dois lados, que eh justamente a armadilha da regra #42.
1376:     * Com ALLTRIM nas duas pontas o padding deixa de importar. As grades desta
1377:     * tela tem poucas linhas, entao a varredura nao pesa.
1378:     *
1379:     * "m.loc_cChave" (e nao "loc_cChave") porque dentro de LOCATE FOR o VFP
1380:     * resolve nome como CAMPO antes de variavel - o prefixo m. elimina a
1381:     * ambiguidade.
1382:     *
1383:     * O ALIAS e o RECNO correntes sao devolvidos: o metodo eh chamado de dentro
1384:     * de lacos que percorrem OUTRO cursor, e mover o ponteiro deles em silencio
1385:     * faria o laco pular ou repetir linhas.
1386:     *
1387:     * PUBLIC: usado por GravarGrade (alvo indireto de BINDEVENT) e util como
1388:     * ponto de verificacao de fora em teste.
1389:     *--------------------------------------------------------------------------
1390:     PROCEDURE LocalizarChave(par_cAlias, par_cChave)
1391:         LOCAL loc_lAchou, loc_cAliasAnterior, loc_nRecno, loc_cChave
1392: 
1393:         loc_lAchou = .F.
1394:         loc_cChave = ALLTRIM(NVL(par_cChave, ""))
1395: 
1396:         IF VARTYPE(par_cAlias) != "C"
1397:             RETURN .F.
1398:         ENDIF
1399: 
1400:         IF !USED(par_cAlias) OR EMPTY(loc_cChave)
1401:             RETURN .F.
1402:         ENDIF
1403: 
1404:         loc_cAliasAnterior = ALIAS()
1405: 
1406:         SELECT (par_cAlias)
1407:         loc_nRecno = RECNO()
1408: 
1409:         LOCATE FOR ALLTRIM(NVL(cidchaves, "")) == m.loc_cChave
1410:         loc_lAchou = FOUND()
1411: 
1412:         *-- RECNO() em EOF devolve RECCOUNT()+1, e "GO <esse numero>" estoura
1413:         *-- "Record is out of range" - por isso o BETWEEN.
1414:         IF BETWEEN(loc_nRecno, 1, RECCOUNT(par_cAlias))
1415:             GO (loc_nRecno)
1416:         ELSE
1417:             GO BOTTOM
1418:             IF !EOF()
1419:                 SKIP
1420:             ENDIF
1421:         ENDIF
1422: 
1423:         IF !EMPTY(loc_cAliasAnterior) AND USED(loc_cAliasAnterior)
1424:             SELECT (loc_cAliasAnterior)
1425:         ENDIF
1426: 
1427:         RETURN loc_lAchou
1428:     ENDPROC
1429: 
1430:     *--------------------------------------------------------------------------

*-- Linhas 1453 a 2076:
1453:     * Server eh blank-padded ANSI.
1454:     *
1455:     * PROTECTED **EXPLICITO**, e nao por estilo: FormBase.prg declara
1456:     * "PROTECTED PROCEDURE FormParaBO" (eh um hook que FormBase.Salvar chama por
1457:     * THIS.), e em VFP9 a subclasse NAO ALARGA escopo herdado - escrever
1458:     * "PROCEDURE FormParaBO" aqui deixaria o metodo protegido do mesmo jeito e
1459:     * MENTIRIA para quem le. Medido nesta tela em 2026-11-09: com a declaracao
1460:     * sem modificador, "loForm.FormParaBO()" de fora da classe estourou
1461:     * "Property FORMPARABO is not found." (erro 1734) - e num vfp9.exe -T esse
1462:     * Program Error eh um dialogo que ninguem fecha, ou seja o processo PENDURA
1463:     * sem log nenhum. Chamar sempre por THIS., de dentro da classe (GravarGrade).
1464:     * O mesmo vale para BOParaForm. CarregarLista NAO existe em FormBase, logo
1465:     * aquele sim eh publico de verdade.
1466:     *--------------------------------------------------------------------------
1467:     PROTECTED PROCEDURE FormParaBO()
1468:         LOCAL loc_lSucesso, loc_cCursor, loc_oBO, loc_cCdopes, loc_oErro
1469:         loc_lSucesso = .F.
1470: 
1471:         TRY
1472:             loc_cCursor = THIS.this_cCursorDados
1473:             loc_oBO     = THIS.this_oBusinessObject
1474: 
1475:             IF VARTYPE(loc_oBO) = "O" AND USED(loc_cCursor)
1476:                 SELECT (loc_cCursor)
1477: 
1478:                 IF !EOF()
1479:                     loc_cCdopes = ALLTRIM(TratarNulo(cdopes, ""))
1480: 
1481:                     IF EMPTY(loc_cCdopes)
1482:                         loc_cCdopes = ALLTRIM(THIS.this_cOperacaoPai)
1483:                     ENDIF
1484: 
1485:                     loc_oBO.this_cCdopes    = loc_cCdopes
1486:                     loc_oBO.this_cCidChaves = ALLTRIM(TratarNulo(cidchaves, ""))
1487:                     loc_oBO.this_cCnivels   = ALLTRIM(TratarNulo(cnivels, ""))
1488:                     loc_oBO.this_nNcors     = TratarNulo(ncors,   0)
1489:                     loc_oBO.this_nPadraos   = TratarNulo(padraos, 0)
1490:                     loc_oBO.this_nOrdems    = TratarNulo(ordems,  0)
1491:                     loc_oBO.this_cMercs     = ALLTRIM(TratarNulo(mercs, ""))
1492:                     loc_oBO.this_cEmpds     = ALLTRIM(TratarNulo(empds, ""))
1493:                     loc_oBO.this_cOpers     = ALLTRIM(TratarNulo(opers, ""))
1494: 
1495:                     *-- Coluna de EXIBICAO (vem do LEFT JOIN com SigCdOpe) - nao
1496:                     *-- existe em SigCdMop e nunca entra no INSERT/UPDATE.
1497:                     IF TYPE(loc_cCursor + ".ndopes") != "U"
1498:                         loc_oBO.this_nNdopes = TratarNulo(ndopes, 0)
1499:                     ENDIF
1500: 
1501:                     loc_lSucesso = .T.
1502:                 ENDIF
1503:             ENDIF
1504: 
1505:         CATCH TO loc_oErro
1506:             MsgErro(loc_oErro.Message + CHR(13) + ;
1507:                     "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1508:                     "Procedure: " + loc_oErro.Procedure, ;
1509:                     "Erro em FormParaBO")
1510:         ENDTRY
1511: 
1512:         RETURN loc_lSucesso
1513:     ENDPROC
1514: 
1515:     *--------------------------------------------------------------------------
1516:     * BOParaForm - transfere o objeto de negocio para a LINHA CORRENTE da grade.
1517:     *
1518:     * Caminho inverso de FormParaBO (ver o comentario dele sobre a linha da
1519:     * grade ser a ficha desta tela). Quem usa de fato eh GravarGrade, para
1520:     * devolver ao cursor a cidchaves gerada numa linha que chegou sem chave: sem
1521:     * essa volta, a reconciliacao da gravacao seguinte nao encontraria a linha e
1522:     * inseriria o MESMO registro outra vez.
1523:     *
1524:     * REPLACE num cursor exige que ele seja READWRITE - e eh
1525:     * (BO.CarregarGrade usa "SELECT ... INTO CURSOR ... READWRITE", e o
1526:     * cursor vazio inicial vem de CREATE CURSOR).
1527:     *
1528:     * Os char vao com ALLTRIM e o proprio VFP completa com espacos ate a largura
1529:     * da coluna; valor mais longo que a coluna eh truncado pelo VFP, igual ao
1530:     * LEFT() que o BO aplica no SQL.
1531:     *
1532:     * PROTECTED EXPLICITO pela MESMA razao de FormParaBO (ver o comentario
1533:     * dele): FormBase declara os dois como PROTECTED e VFP9 nao deixa a
1534:     * subclasse alargar o escopo.
1535:     *--------------------------------------------------------------------------
1536:     PROTECTED PROCEDURE BOParaForm()
1537:         LOCAL loc_lSucesso, loc_cCursor, loc_oBO, loc_oErro
1538:         loc_lSucesso = .F.
1539: 
1540:         TRY
1541:             loc_cCursor = THIS.this_cCursorDados
1542:             loc_oBO     = THIS.this_oBusinessObject
1543: 
1544:             IF VARTYPE(loc_oBO) = "O" AND USED(loc_cCursor)
1545:                 SELECT (loc_cCursor)
1546: 
1547:                 IF !EOF()
1548:                     REPLACE cdopes    WITH ALLTRIM(loc_oBO.this_cCdopes),    ;
1549:                             cidchaves WITH ALLTRIM(loc_oBO.this_cCidChaves), ;
1550:                             cnivels   WITH ALLTRIM(loc_oBO.this_cCnivels),   ;
1551:                             ncors     WITH loc_oBO.this_nNcors,              ;
1552:                             padraos   WITH loc_oBO.this_nPadraos,            ;
1553:                             ordems    WITH loc_oBO.this_nOrdems,             ;
1554:                             mercs     WITH ALLTRIM(loc_oBO.this_cMercs),     ;
1555:                             empds     WITH ALLTRIM(loc_oBO.this_cEmpds),     ;
1556:                             opers     WITH ALLTRIM(loc_oBO.this_cOpers)
1557: 
1558:                     IF TYPE(loc_cCursor + ".ndopes") != "U"
1559:                         REPLACE ndopes WITH loc_oBO.this_nNdopes
1560:                     ENDIF
1561: 
1562:                     loc_lSucesso = .T.
1563:                 ENDIF
1564:             ENDIF
1565: 
1566:         CATCH TO loc_oErro
1567:             MsgErro(loc_oErro.Message + CHR(13) + ;
1568:                     "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1569:                     "Procedure: " + loc_oErro.Procedure, ;
1570:                     "Erro em BOParaForm")
1571:         ENDTRY
1572: 
1573:         RETURN loc_lSucesso
1574:     ENDPROC
1575: 
1576:     *--------------------------------------------------------------------------
1577:     * CarregarLista - entrada PUBLICA de recarga da superficie de lista desta
1578:     * tela, que eh a GRADE (esta tela nao tem pagina de Lista separada).
1579:     *
1580:     * Nao eh um apelido de CarregarDados: ela acrescenta o que falta para a
1581:     * recarga ser utilizavel de fora da inicializacao - preservar a LINHA
1582:     * CORRENTE. BO.CarregarGrade RECRIA o cursor, e sem isto o usuario eh jogado
1583:     * de volta para a primeira linha a cada recarga. Eh o mesmo cuidado que o
1584:     * legado toma onde ele mesmo recarrega (o Click do CheckBox "Padrao" guarda
1585:     * e devolve lnRecno).
1586:     *
1587:     * A linha eh reencontrada pela cidchaves, nao pelo RECNO: a recarga vem
1588:     * ordenada por cdopes+cnivels e o numero do registro pode mudar.
1589:     *
1590:     * PUBLIC: eh por este nome que o harness (TesteAutomatico.prg) chama a
1591:     * recarga, de FORA da classe - regra #3.
1592:     *--------------------------------------------------------------------------
1593:     PROCEDURE CarregarLista()
1594:         LOCAL loc_lSucesso, loc_cCursor, loc_cChaveAtual, loc_oErro
1595:         loc_lSucesso    = .F.
1596:         loc_cChaveAtual = ""
1597: 
1598:         TRY
1599:             loc_cCursor = THIS.this_cCursorDados
1600: 
1601:             IF USED(loc_cCursor)
1602:                 SELECT (loc_cCursor)
1603:                 IF !EOF()
1604:                     loc_cChaveAtual = ALLTRIM(NVL(cidchaves, ""))
1605:                 ENDIF
1606:             ENDIF
1607: 
1608:             loc_lSucesso = THIS.CarregarDados()
1609: 
1610:             *-- Reler a property: CarregarDados a sincroniza com o BO.
1611:             loc_cCursor = THIS.this_cCursorDados
1612: 
1613:             IF loc_lSucesso AND !EMPTY(loc_cChaveAtual) AND USED(loc_cCursor)
1614:                 IF THIS.LocalizarChave(loc_cCursor, loc_cChaveAtual)
1615:                     SELECT (loc_cCursor)
1616:                     LOCATE FOR ALLTRIM(NVL(cidchaves, "")) == m.loc_cChaveAtual
1617:                     THIS.grd_4c_Dados.Refresh()
1618:                 ENDIF
1619:             ENDIF
1620: 
1621:         CATCH TO loc_oErro
1622:             MsgErro(loc_oErro.Message + CHR(13) + ;
1623:                     "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1624:                     "Procedure: " + loc_oErro.Procedure, ;
1625:                     "Erro em CarregarLista")
1626:         ENDTRY
1627: 
1628:         RETURN loc_lSucesso
1629:     ENDPROC
1630: 
1631:     *--------------------------------------------------------------------------
1632:     * VerificarPermissao - equivalente ao fChecaAcesso('SIGOPMOP', <operacao>)
1633:     * do Init legado.
1634:     *
1635:     * fChecaAcesso tem DUAS definicoes vivas no repo e a que VENCE eh a de
1636:     * Framework\sigacess.PRG, que abre conexao propria e consulta SigCdAcu.
1637:     * Em execucao headless sem SQL Server ela PENDURA - e penduraria DENTRO do
1638:     * CREATEOBJECT deste form, o que se le como "a tela nao instancia" quando o
1639:     * problema eh o banco. Por isso a chamada fica atras do mesmo guard de modo
1640:     * de teste que o Init ja usa para o WindowType.
1641:     *
1642:     * A chamada com 2 argumentos eh FIEL ao legado: os 3 parametros restantes de
1643:     * sigacess.PRG tem fallback proprio (pUsu cai em Usuar, pTot ausente avalia
1644:     * como .F.) - NAO "consertar" acrescentando argumentos.
1645:     *--------------------------------------------------------------------------
1646:     PROTECTED FUNCTION VerificarPermissao(par_cOperacao)
1647:         LOCAL loc_lPermitido
1648: 
1649:         IF (TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI) OR ;
1650:            (TYPE("gb_4c_ModoTeste")   = "L" AND gb_4c_ModoTeste)
1651:             RETURN .T.
1652:         ENDIF
1653: 
1654:         loc_lPermitido = fChecaAcesso("SIGOPMOP", par_cOperacao)
1655: 
1656:         RETURN IIF(VARTYPE(loc_lPermitido) = "L", loc_lPermitido, .F.)
1657:     ENDFUNC
1658: 
1659:     *--------------------------------------------------------------------------
1660:     * AplicarPermissoesBotoes - decide a visibilidade/habilitacao de Inserir e
1661:     * Excluir e reposiciona a moldura em funcao do que sobrou visivel.
1662:     *
1663:     * TRANSCRITO do Init legado:
1664:     *   .cmdInserir.Visible = fChecaAcesso('SIGOPMOP','INSERIR') And ;
1665:     *                         Iif( Type('Thisform.PcEscolha') # 'C', .T., ;
1666:     *                         InList( Thisform.PcEscolha,'INSERIR','ALTERAR') )
1667:     *   .cmdInserir.Enabled = <a mesma expressao>
1668:     *   .cmdExcluir.Visible = fChecaAcesso('SIGOPMOP','EXCLUIR') And <modo>
1669:     *   .cmdExcluir.Enabled = <a mesma expressao>
1670:     *   .shape1.Left  = IIF(.cmdInserir.visible, .cmdInserir.Left - 5, ;
1671:     *                   IIF(.cmdExcluir.visible, .cmdExcluir.left - 5, ;
1672:     *                       .cmdSair.Left - 5))
1673:     *   .shape1.width = IIF(.cmdInserir.visible, 3, ;
1674:     *                   IIF(.cmdExcluir.visible, 2, 1)) * .cmdsair.width + 16
1675:     *
1676:     * O "Iif( Type('Thisform.PcEscolha') # 'C', ...)" do legado cobre o caso do
1677:     * chamador que NAO passou o modo: a property fica logica (.F.) e o teste de
1678:     * tipo libera a acao. Aqui this_cEscolha eh sempre Caractere, entao o
1679:     * equivalente exato eh EMPTY() - modo nao informado libera, modo informado
1680:     * exige INSERIR/ALTERAR. Em PROCURAR os dois botoes desaparecem e a tela
1681:     * fica somente de consulta, como no legado.
1682:     *
1683:     * Roda DEPOIS de TornarControlesVisiveis de proposito: aquela varredura
1684:     * forca Visible = .T. em TODO controle e apagaria esta decisao.
1685:     *--------------------------------------------------------------------------
1686:     PROTECTED PROCEDURE AplicarPermissoesBotoes()
1687:         LOCAL loc_lModoEdicao, loc_lPodeInserir, loc_lPodeExcluir
1688:         LOCAL loc_nLeftMoldura, loc_nFatorMoldura
1689: 
1690:         *-- Modo do form PAI: sem modo informado, libera (legado: Type() # 'C')
1691:         loc_lModoEdicao = EMPTY(THIS.this_cEscolha) OR ;
1692:                           INLIST(THIS.this_cEscolha, "INSERIR", "ALTERAR")
1693: 
1694:         loc_lPodeInserir = THIS.VerificarPermissao("INSERIR") AND loc_lModoEdicao
1695:         loc_lPodeExcluir = THIS.VerificarPermissao("EXCLUIR") AND loc_lModoEdicao
1696: 
1697:         THIS.cmd_4c_CmdInserir.Visible = loc_lPodeInserir
1698:         THIS.cmd_4c_CmdInserir.Enabled = loc_lPodeInserir
1699: 
1700:         THIS.cmd_4c_CmdExcluir.Visible = loc_lPodeExcluir
1701:         THIS.cmd_4c_CmdExcluir.Enabled = loc_lPodeExcluir
1702: 
1703:         *-- Moldura acompanha o PRIMEIRO botao visivel, da esquerda para a
1704:         *-- direita, e cresce 1/2/3 larguras de botao conforme quantos sobraram.
1705:         DO CASE
1706:             CASE THIS.cmd_4c_CmdInserir.Visible
1707:                 loc_nLeftMoldura  = THIS.cmd_4c_CmdInserir.Left - 5
1708:                 loc_nFatorMoldura = 3
1709:             CASE THIS.cmd_4c_CmdExcluir.Visible
1710:                 loc_nLeftMoldura  = THIS.cmd_4c_CmdExcluir.Left - 5
1711:                 loc_nFatorMoldura = 2
1712:             OTHERWISE
1713:                 loc_nLeftMoldura  = THIS.cmd_4c_CmdSair.Left - 5
1714:                 loc_nFatorMoldura = 1
1715:         ENDCASE
1716: 
1717:         THIS.shp_4c_Shape1.Left  = loc_nLeftMoldura
1718:         THIS.shp_4c_Shape1.Width = loc_nFatorMoldura * THIS.cmd_4c_CmdSair.Width + 16
1719:     ENDPROC
1720: 
1721:     *--------------------------------------------------------------------------
1722:     * AjustarOrdemTabulacao - TabIndex TRANSCRITO do dump (GradeSubN = 1,
1723:     * cmdExcluir = 2, cmdSair = 3, cmdInserir = 4).
1724:     *
1725:     * Fica aqui, e nao em ConfigurarGrade/ConfigurarBotoes, porque TabIndex
1726:     * fora da faixa 1..N eh descartado em SILENCIO: a faixa so vale depois do
1727:     * ULTIMO controle focalizavel existir. Sao quatro (a grade e os tres
1728:     * botoes), logo 1..4.
1729:     *--------------------------------------------------------------------------
1730:     PROTECTED PROCEDURE AjustarOrdemTabulacao()
1731:         THIS.grd_4c_Dados.TabIndex        = 1
1732:         THIS.cmd_4c_CmdExcluir.TabIndex   = 2
1733:         THIS.cmd_4c_CmdSair.TabIndex      = 3
1734:         THIS.cmd_4c_CmdInserir.TabIndex   = 4
1735:     ENDPROC
1736: 
1737:     *--------------------------------------------------------------------------
1738:     * CarregarDados - funil UNICO de carga: configuracao da operacao, linhas da
1739:     * grade e remontagem do vinculo visual.
1740:     *
1741:     * Equivale ao bloco final do Init legado, que carrega LocalDcOpe
1742:     * (configuracao), faz ReQuery('crSigCdMop') e so DEPOIS liga a grade.
1743:     *
1744:     * A ordem eh obrigatoria: MontaGrade consulta this_nGerOpes para decidir se
1745:     * a coluna "Cores" aceita digitacao, e esse valor sai de
1746:     * CarregarConfiguracaoOperacao.
1747:     *
1748:     * MontaGrade roda SEMPRE depois da carga, mesmo quando a consulta falha:
1749:     * CarregarGrade DERRUBA o alias da grade, e fechar o alias de um Grid
1750:     * destroi o controle posto por Column.AddObject. A perda eh PARCIAL e por
1751:     * isso enganosa - largura e cabecalho sobrevivem, a grade continua bonita, e
1752:     * so o CheckBox da coluna "Padrao" desaparece, voltando a desenhar o Text1
1753:     * com 0/1 cru e sem como marcar linha nenhuma.
1754:     *--------------------------------------------------------------------------
1755:     PROCEDURE CarregarDados()
1756:         LOCAL loc_lSucesso, loc_oErro
1757:         loc_lSucesso = .F.
1758: 
1759:         TRY
1760:             IF VARTYPE(THIS.this_oBusinessObject) != "O"
1761:                 MsgErro("Objeto de neg" + CHR(243) + "cio n" + CHR(227) + ;
1762:                         "o dispon" + CHR(237) + "vel para carregar a grade.", ;
1763:                         "Erro em CarregarDados")
1764:             ELSE
1765:                 *-- Nome do cursor vem do BO (fonte unica), para a grade nao
1766:                 *-- ligar num alias diferente do que foi populado.
1767:                 THIS.this_cCursorDados = THIS.this_oBusinessObject.this_cCursorDados
1768: 
1769:                 THIS.this_oBusinessObject.CarregarConfiguracaoOperacao()
1770:                 THIS.this_oBusinessObject.CarregarGrade()
1771: 
1772:                 loc_lSucesso = THIS.MontaGrade()
1773:             ENDIF
1774:         CATCH TO loc_oErro
1775:             MsgErro(loc_oErro.Message + CHR(13) + ;
1776:                     "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1777:                     "Procedure: " + loc_oErro.Procedure, ;
1778:                     "Erro em CarregarDados")
1779:         ENDTRY
1780: 
1781:         RETURN loc_lSucesso
1782:     ENDPROC
1783: 
1784:     *--------------------------------------------------------------------------
1785:     * MontaGrade - vincula a grade ao cursor e configura as 7 colunas.
1786:     *
1787:     * Mapa de colunas TRANSCRITO do Init legado:
1788:     *   .RecordSource          = 'crSigCdMop'
1789:     *   .Column1.ControlSource = 'crSigCdMop.cNivels'   "Movimentacao"  150
1790:     *   .Column2.ControlSource = 'crSigCdMop.nDopes'    "  #  "          38  ReadOnly
1791:     *   .Column3.ControlSource = 'crSigCdMop.nCors'     "Cores"          80
1792:     *   .Column4.ControlSource = 'crSigCdMop.Padraos'   "Padrao"         50  CheckBox
1793:     *   .Column5.ControlSource = 'crSigCdMop.Ordems'    "Ordem"          45
1794:     *   .Column6.ControlSource = 'crSigCdMop.Mercs'     "G.Grp"          42
1795:     *   .Column7.ControlSource = 'crSigCdMop.EmpDs'     "Emp."           40
1796:     *
1797:     * A SEQUENCIA abaixo eh medida, nao estilistica:
1798:     *   ColumnCount -> RecordSource -> ControlSource de TODAS as colunas ->
1799:     *   Column4.AddObject(CheckBox) -> CurrentControl/Sparse -> larguras e
1800:     *   cabecalhos -> ReadOnly das colunas.
1801:     * Inverter os dois primeiros blocos faz o Grid se auto-ligar ao alias
1802:     * CORRENTE no instante do ColumnCount e o AddObject do CheckBox estourar
1803:     * "Data type mismatch" se a coluna 4 daquele alias for texto.
1804:     * Largura e cabecalho vem POR ULTIMO porque atribuir RecordSource/
1805:     * ControlSource os reseta (a largura volta ao default 90 e o Caption volta
1806:     * a "Header1").
1807:     *
1808:     * Este metodo eh IDEMPOTENTE e eh o funil de TODA repintura - nao da
1809:     * inicializacao apenas.
1810:     *--------------------------------------------------------------------------
1811:     PROCEDURE MontaGrade()
1812:         LOCAL loc_lSucesso, loc_oErro, loc_oGrade, loc_cCursor
1813:         loc_lSucesso = .F.
1814: 
1815:         TRY
1816:             loc_cCursor = THIS.this_cCursorDados
1817: 
1818:             IF !USED(loc_cCursor)
1819:                 *-- Sem cursor nao ha o que ligar; sair sem mexer na grade eh
1820:                 *-- melhor que ligar em alias inexistente, que derruba o Init.
1821:                 MsgAviso("Cursor da grade n" + CHR(227) + "o dispon" + CHR(237) + ;
1822:                          "vel: " + loc_cCursor, "Aten" + CHR(231) + CHR(227) + "o")
1823:             ELSE
1824:                 loc_oGrade = THIS.grd_4c_Dados
1825: 
1826:                 SELECT (loc_cCursor)
1827: 
1828:                 WITH loc_oGrade
1829:                     .ColumnCount      = 7
1830:                     .RecordSourceType = 1
1831:                     .RecordSource     = loc_cCursor
1832: 
1833:                     .Column1.ControlSource = loc_cCursor + ".cnivels"
1834:                     .Column2.ControlSource = loc_cCursor + ".ndopes"
1835:                     .Column3.ControlSource = loc_cCursor + ".ncors"
1836:                     .Column4.ControlSource = loc_cCursor + ".padraos"
1837:                     .Column5.ControlSource = loc_cCursor + ".ordems"
1838:                     .Column6.ControlSource = loc_cCursor + ".mercs"
1839:                     .Column7.ControlSource = loc_cCursor + ".empds"
1840:                 ENDWITH
1841: 
1842:                 *-- CheckBox da coluna "Padrao" so DEPOIS do bind, e de forma
1843:                 *-- idempotente (AddObject repetido num objeto vivo estoura).
1844:                 THIS.GarantirCheckBoxPadrao()
1845: 
1846:                 *-- Celulas customizadas de Movimentacao/Cores (Fase 5) -
1847:                 *-- mesma idempotencia: o bind acima recria as Columns.
1848:                 THIS.GarantirCelulasEditaveisGrade()
1849: 
1850:                 *-- Fonte das Columns e dos controles internos (dump: Tahoma 8
1851:                 *-- em todas as 7 colunas e em todos os Text1)
1852:                 loc_oGrade.FontName = "Tahoma"
1853:                 loc_oGrade.FontSize = 8
1854: 
1855:                 *-- Larguras, cabecalhos e travas, coluna a coluna
1856:                 THIS.ConfigurarColunasGrade()
1857: 
1858:                 *-- "Go Top In <cursor>" + Refresh do legado: popular o cursor
1859:                 *-- NAO repinta a grade sozinho.
1860:                 SELECT (loc_cCursor)
1861:                 GO TOP
1862:                 loc_oGrade.Refresh()
1863: 
1864:                 loc_lSucesso = .T.
1865:             ENDIF
1866:         CATCH TO loc_oErro
1867:             MsgErro(loc_oErro.Message + CHR(13) + ;
1868:                     "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1869:                     "Procedure: " + loc_oErro.Procedure, ;
1870:                     "Erro em MontaGrade")
1871:         ENDTRY
1872: 
1873:         RETURN loc_lSucesso
1874:     ENDPROC
1875: 
1876:     *--------------------------------------------------------------------------
1877:     * GarantirCheckBoxPadrao - instala o CheckBox da coluna "Padrao"
1878:     * (SIGOPMOP.GradeSubN.Column4.Check1) de forma IDEMPOTENTE.
1879:     *
1880:     * Column.AddObject sozinho NAO faz o controle aparecer: a coluna continua
1881:     * desenhando o Text1 dela ate receber CurrentControl com o NOME do controle
1882:     * adicionado. E sem Sparse = .F. o CheckBox apareceria so na linha corrente,
1883:     * com as demais linhas exibindo 0/1 como texto - o dump do legado ja declara
1884:     * Column4.Sparse = .F. por isso.
1885:     *
1886:     * Idempotente porque o metodo roda em toda repintura e o alias da grade eh
1887:     * derrubado a cada recarga: objeto recriado eh OUTRO objeto, e AddObject
1888:     * sobre um que ainda esta vivo estoura "already defined".
1889:     *
1890:     * GEOMETRIA NAO EH ATRIBUIVEL AQUI - medido no VFP9 em 2026-11-09. Em
1891:     * CheckBox que eh CurrentControl de uma Column, Top/Left/Width/Height sao
1892:     * geridos pelo VFP e ficam em 0,0,10,10 independentemente do que se atribua
1893:     * e da ORDEM em que se atribua. Medido com quatro variantes, grade com
1894:     * RowHeight = 16 e Column.Width = 50:
1895:     *
1896:     *   geometria ANTES do CurrentControl   -> T=0 L=0 W=10 H=10
1897:     *   geometria DEPOIS do CurrentControl  -> T=0 L=0 W=10 H=10
1898:     *   geometria DEPOIS de Grid.Refresh()  -> T=0 L=0 W=10 H=10
1899:     *   SEM atribuir geometria nenhuma      -> T=0 L=0 W=10 H=10
1900:     *
1901:     * Por isso os Top=24 / Left=13 / Height=17 / Width=60 do dump NAO sao
1902:     * transcritos: sao coordenadas de TEMPO DE PROJETO do Form Designer (Top=24
1903:     * em linha de 16px e 60 de largura em coluna de 50 ja mostram que nao sao de
1904:     * renderizacao), e atribui-las seria codigo morto sugerindo que a area
1905:     * clicavel foi ajustada quando nao foi. As demais propriedades PEGAM, e
1906:     * foram medidas uma a uma: Caption, Alignment, ReadOnly, Visible, FontName,
1907:     * FontSize e Value.
1908:     *
1909:     * .Value NUMERICO (0): CheckBox em VFP9 nasce com Value numerico (medido:
1910:     * VARTYPE = "N"), e padraos eh numeric(1,0). Atribuir .F. criaria Value
1911:     * logico e o primeiro REPLACE/comparacao estouraria "Operator/operand type
1912:     * mismatch".
1913:     *--------------------------------------------------------------------------
1914:     PROTECTED PROCEDURE GarantirCheckBoxPadrao()
1915:         IF PEMSTATUS(THIS.grd_4c_Dados.Column4, "chk_4c_Check1", 5)
1916:             *-- Ainda vivo: nao recriar.
1917:             RETURN .T.
1918:         ENDIF
1919: 
1920:         THIS.grd_4c_Dados.Column4.AddObject("chk_4c_Check1", "CheckBox")
1921: 
1922:         WITH THIS.grd_4c_Dados.Column4.chk_4c_Check1
1923:             .Caption   = ""
1924:             .Alignment = 0
1925:             .ReadOnly  = .F.
1926:             .Visible   = .T.
1927:             .FontName  = "Tahoma"
1928:             .FontSize  = 8
1929:             .Value     = 0
1930:         ENDWITH
1931: 
1932:         *-- CheckBox em coluna de Grid NAO alterna pelo binding nativo: os 4
1933:         *-- handlers suprimem o toggle automatico (NODEFAULT) e o REPLACE
1934:         *-- exclusivo de PadraoMopKeyPress eh quem decide o valor novo.
1935:         BINDEVENT(THIS.grd_4c_Dados.Column4.chk_4c_Check1, "Click",     THIS, "PadraoMopClick")
1936:         BINDEVENT(THIS.grd_4c_Dados.Column4.chk_4c_Check1, "MouseDown", THIS, "PadraoMopMouseDown")
1937:         BINDEVENT(THIS.grd_4c_Dados.Column4.chk_4c_Check1, "MouseUp",   THIS, "PadraoMopMouseUp")
1938:         BINDEVENT(THIS.grd_4c_Dados.Column4.chk_4c_Check1, "KeyPress",  THIS, "PadraoMopKeyPress")
1939: 
1940:         RETURN .T.
1941:     ENDPROC
1942: 
1943:     *--------------------------------------------------------------------------
1944:     * PadraoMopClick / PadraoMopMouseDown / PadraoMopMouseUp - suprimem o
1945:     * toggle NATIVO do CheckBox da coluna "Padrao" (grd_4c_Dados.Column4.
1946:     * chk_4c_Check1). Medido: CheckBox em coluna de Grid nao alterna o valor
1947:     * so por clique/tecla quando o toggle real precisa ser EXCLUSIVO entre
1948:     * linhas (REPLACE ALL) - por isso os tres so chamam NODEFAULT, e
1949:     * PadraoMopMouseUp delega para PadraoMopKeyPress(13, 0), que faz o
1950:     * trabalho de fato (equivalente a soltar o botao do mouse = Enter).
1951:     *
1952:     * PUBLIC (nao PROTECTED): alvo de BINDEVENT - regra CLAUDE.md #3.
1953:     *--------------------------------------------------------------------------
1954:     PROCEDURE PadraoMopClick()
1955:         NODEFAULT
1956:     ENDPROC
1957: 
1958:     PROCEDURE PadraoMopMouseDown(par_nButton, par_nShift, par_nX, par_nY)
1959:         NODEFAULT
1960:     ENDPROC
1961: 
1962:     PROCEDURE PadraoMopMouseUp(par_nButton, par_nShift, par_nX, par_nY)
1963:         THIS.PadraoMopKeyPress(13, 0)
1964:         NODEFAULT
1965:     ENDPROC
1966: 
1967:     *--------------------------------------------------------------------------
1968:     * PadraoMopKeyPress - alternancia EXCLUSIVA da coluna "Padrao": so UMA
1969:     * linha da operacao pode ser a padrao.
1970:     *
1971:     * TRANSCRITO do legado (SIGOPMOP.GradeSubN.Column4.Check1.Click - o
1972:     * legado le "This.Value"/"crSigCdMop.padraos" JA TROCADO pelo toggle
1973:     * nativo do CheckBox; aqui o toggle eh calculado a mao, porque os
1974:     * handlers acima suprimem o nativo):
1975:     *   Select crSigCdMop
1976:     *   lnRecno = Recno('crSigCdMop')
1977:     *   If crSigCdMop.padraos = 0
1978:     *       Update crSigCdMop Set padraos = 0
1979:     *       Go lnRecno
1980:     *   Else
1981:     *       Update crSigCdMop Set padraos = 0 Where Recno() # lnRecno
1982:     *       Update crSigCdMop Set padraos = 1 Where Recno() = lnRecno
1983:     *       Select crSigCdMop
1984:     *       Go lnRecno
1985:     *   EndIf
1986:     *   Select crSigCdMop
1987:     *   ThisForm.GradeSubN.Refresh
1988:     *
1989:     * Disparado so em Enter(13) ou Espaco(32), igual ao padrao do projeto
1990:     * para CheckBox de Grid (BINDEVENT KeyPress nao distingue tecla sozinho
1991:     * - o filtro fica dentro do handler).
1992:     *--------------------------------------------------------------------------
1993:     PROCEDURE PadraoMopKeyPress(par_nKeyCode, par_nShiftAltCtrl)
1994:         LOCAL loc_cCursor, loc_nRecno, loc_nNovoValor
1995: 
1996:         loc_cCursor = THIS.this_cCursorDados
1997: 
1998:         IF INLIST(NVL(par_nKeyCode, 0), 13, 32) AND USED(loc_cCursor) AND !EOF(loc_cCursor)
1999:             SELECT (loc_cCursor)
2000: 
2001:             loc_nRecno     = RECNO()
2002:             loc_nNovoValor = IIF(padraos = 0, 1, 0)
2003: 
2004:             REPLACE padraos WITH 0 ALL
2005: 
2006:             IF loc_nNovoValor = 1
2007:                 GOTO loc_nRecno
2008:                 REPLACE padraos WITH 1
2009:             ENDIF
2010: 
2011:             GOTO loc_nRecno
2012:             THIS.this_lHouveInsercao = .T.
2013:             THIS.grd_4c_Dados.Refresh()
2014:             NODEFAULT
2015:         ENDIF
2016:     ENDPROC
2017: 
2018:     *--------------------------------------------------------------------------
2019:     * GarantirCelulasEditaveisGrade - instala, de forma IDEMPOTENTE, as
2020:     * celulas customizadas das colunas "Movimentacao" (Column1) e "Cores"
2021:     * (Column3) - TextBoxMovimentacaoMop_4c / TextBoxCoresMop_4c
2022:     * (classes\TextBoxGridLookup.prg).
2023:     *
2024:     * Mesma razao da idempotencia de GarantirCheckBoxPadrao: este metodo roda
2025:     * em toda repintura (MontaGrade), e CarregarGrade DERRUBA o alias da
2026:     * grade antes de cada recarga - o que destroi qualquer objeto posto por
2027:     * Column.AddObject.
2028:     *
2029:     * Column.AddObject sozinho NAO faz o controle aparecer (regra #18): soh
2030:     * depois do CurrentControl receber o NOME do objeto a Column passa a
2031:     * desenhar ele no lugar do Text1 nativo. Sparse = .F. evita que o
2032:     * controle so apareca na linha corrente (dump do legado: Column1 e
2033:     * Column3 nao ficam Sparse por default so porque nunca precisaram antes
2034:     * de ganhar controle customizado).
2035:     *--------------------------------------------------------------------------
2036:     PROTECTED PROCEDURE GarantirCelulasEditaveisGrade()
2037:         LOCAL loc_oGrade
2038:         loc_oGrade = THIS.grd_4c_Dados
2039: 
2040:         IF !PEMSTATUS(loc_oGrade.Column1, "txt_4c_Movimentacao", 5)
2041:             loc_oGrade.Column1.AddObject("txt_4c_Movimentacao", "TextBoxMovimentacaoMop_4c")
2042:         ENDIF
2043:         loc_oGrade.Column1.CurrentControl = "txt_4c_Movimentacao"
2044:         loc_oGrade.Column1.Sparse         = .F.
2045: 
2046:         IF !PEMSTATUS(loc_oGrade.Column3, "txt_4c_Cores", 5)
2047:             loc_oGrade.Column3.AddObject("txt_4c_Cores", "TextBoxCoresMop_4c")
2048:         ENDIF
2049:         loc_oGrade.Column3.CurrentControl = "txt_4c_Cores"
2050:         loc_oGrade.Column3.Sparse         = .F.
2051: 
2052:         IF !PEMSTATUS(loc_oGrade.Column6, "txt_4c_GrandeGrupo", 5)
2053:             loc_oGrade.Column6.AddObject("txt_4c_GrandeGrupo", "TextBoxGrandeGrupoMop_4c")
2054:         ENDIF
2055:         loc_oGrade.Column6.CurrentControl = "txt_4c_GrandeGrupo"
2056:         loc_oGrade.Column6.Sparse         = .F.
2057: 
2058:         IF !PEMSTATUS(loc_oGrade.Column7, "txt_4c_Empresa", 5)
2059:             loc_oGrade.Column7.AddObject("txt_4c_Empresa", "TextBoxEmpresaMop_4c")
2060:         ENDIF
2061:         loc_oGrade.Column7.CurrentControl = "txt_4c_Empresa"
2062:         loc_oGrade.Column7.Sparse         = .F.
2063: 
2064:         RETURN .T.
2065:     ENDPROC
2066: 
2067:     *--------------------------------------------------------------------------
2068:     * ConfigurarColunasGrade - largura, cabecalho, mascara e travas das 7
2069:     * colunas, TRANSCRITAS do dump (SECAO 2).
2070:     *
2071:     * Roda sempre DEPOIS do bind: atribuir RecordSource/ControlSource reseta
2072:     * Column.Width para o default 90 e Header1.Caption para "Header1".
2073:     *
2074:     * Column.ReadOnly vem DEPOIS de Grid.ReadOnly (definido em ConfigurarGrade):
2075:     * o do grid propaga para as colunas e sobrescreveria estas travas.
2076:     *

*-- Linhas 2083 a 2126:
2083:     * Isto eh, so quando geropes = 2 a cor eh digitavel - e nesse caso o texto de
2084:     * TODAS as colunas passa a ser pintado com a cor gravada na linha.
2085:     *--------------------------------------------------------------------------
2086:     PROTECTED PROCEDURE ConfigurarColunasGrade()
2087:         LOCAL loc_oGrade, loc_cCursor
2088:         loc_oGrade  = THIS.grd_4c_Dados
2089:         loc_cCursor = THIS.this_cCursorDados
2090: 
2091:         *-- Column1 "Movimentacao" - operacao FILHA (cnivels char(20)).
2092:         *-- Aparencia do controle (FontName/BorderStyle/Margin/cores) vem da
2093:         *-- classe TextBoxMovimentacaoMop_4c (GarantirCelulasEditaveisGrade),
2094:         *-- que substitui o Text1 nativo - por isso nao se repete aqui.
2095:         WITH loc_oGrade.Column1
2096:             .Width     = 150
2097:             .Movable   = .F.
2098:             .Resizable = .F.
2099:             .Header1.Caption   = "Movimenta" + CHR(231) + CHR(227) + "o"
2100:             .Header1.Alignment = 2
2101:             .Header1.FontName  = "Tahoma"
2102:             .Header1.FontSize  = 8
2103:         ENDWITH
2104: 
2105:         *-- Column2 "  #  " - numero da operacao, vem do JOIN e NAO eh editavel
2106:         WITH loc_oGrade.Column2
2107:             .Width     = 38
2108:             .Movable   = .F.
2109:             .InputMask = "9999"
2110:             .Header1.Caption   = "  #  "
2111:             .Header1.Alignment = 2
2112:             .Header1.FontName  = "Tahoma"
2113:             .Header1.FontSize  = 8
2114:             .Text1.BorderStyle = 0
2115:             .Text1.Margin      = 0
2116:             .Text1.ForeColor   = RGB(0, 0, 0)
2117:             .Text1.BackColor   = RGB(255, 255, 255)
2118:             .Text1.ReadOnly    = .T.
2119:             .ReadOnly          = .T.
2120:         ENDWITH
2121: 
2122:         *-- Column3 "Cores" - cor RGB (ncors numeric(10,0)). InputMask/
2123:         *-- MaxLength/aparencia vem da classe TextBoxCoresMop_4c
2124:         *-- (GarantirCelulasEditaveisGrade), que substitui o Text1 nativo.
2125:         WITH loc_oGrade.Column3
2126:             .Width     = 80

*-- Linhas 2220 a 2316:
2220:     * customizado da Column (regra #3 - metodo delegado por objeto fora da
2221:     * hierarquia do form tem de ser PUBLIC).
2222:     *--------------------------------------------------------------------------
2223:     PROCEDURE CelulaMovimentacaoMopEditavel()
2224:         LOCAL loc_cCursor
2225:         loc_cCursor = THIS.this_cCursorDados
2226: 
2227:         IF !USED(loc_cCursor)
2228:             RETURN .F.
2229:         ENDIF
2230: 
2231:         RETURN ALLTRIM(EVALUATE(loc_cCursor + ".cdopes")) == ALLTRIM(THIS.this_cOperacaoPai) AND ;
2232:                EMPTY(ALLTRIM(EVALUATE(loc_cCursor + ".cnivels")))
2233:     ENDPROC
2234: 
2235:     *--------------------------------------------------------------------------
2236:     * MovimentacaoMopLostFocusExec - LostFocus da celula "Movimentacao".
2237:     *
2238:     * TRANSCRITO do legado (Column1.Text1.LostFocus):
2239:     *   If IsEmpty(This.Value) / Thisform.cmdSair.SetFocus / Endif
2240:     * (linha ficou sem Movimentacao - foca o botao de saida em vez de deixar
2241:     * o foco preso na grade).
2242:     *--------------------------------------------------------------------------
2243:     PROCEDURE MovimentacaoMopLostFocusExec(par_oTxt)
2244:         IF EMPTY(ALLTRIM(NVL(par_oTxt.Value, ""))) AND PEMSTATUS(THIS, "cmd_4c_CmdSair", 5)
2245:             THIS.cmd_4c_CmdSair.SetFocus()
2246:         ENDIF
2247:     ENDPROC
2248: 
2249:     *--------------------------------------------------------------------------
2250:     * ValidarMovimentacaoMopExec - Valid da celula "Movimentacao"
2251:     * (grd_4c_Dados.Column1.txt_4c_Movimentacao): LOOKUP em SigCdOpe.
2252:     *
2253:     * WRAPPER da guarda de reentrancia (ver this_lEmLookup). O corpo fica em
2254:     * ValidarMovimentacaoMopCorpo para que a flag seja SEMPRE liberada aqui,
2255:     * inclusive quando o corpo recusa o valor e devolve .F.
2256:     *--------------------------------------------------------------------------
2257:     PROCEDURE ValidarMovimentacaoMopExec(par_oTxt)
2258:         LOCAL loc_lAceita
2259: 
2260:         IF THIS.this_lEmLookup
2261:             RETURN .T.
2262:         ENDIF
2263: 
2264:         THIS.this_lEmLookup = .T.
2265:         loc_lAceita         = THIS.ValidarMovimentacaoMopCorpo(par_oTxt)
2266:         THIS.this_lEmLookup = .F.
2267: 
2268:         RETURN loc_lAceita
2269:     ENDPROC
2270: 
2271:     *--------------------------------------------------------------------------
2272:     * ValidarMovimentacaoMopCorpo - corpo do lookup da operacao FILHA.
2273:     *
2274:     * TRANSCRITO do legado (SIGOPMOP.GradeSubN.Column1.Text1.Valid):
2275:     *   If Not IsEmpty(This.Value)
2276:     *       xBrox = CreateObject('fwBuscaExt', <conn>, 'SigCdOpe', 'cpSigCdOpe',
2277:     *                 'Dopes', This.Value, 'Cadastro de Operacoes', .t., 'Dopes')
2278:     *       If Not xBrox.plAchouRegistro
2279:     *           xBrox.mAddColuna('Dopes',  '',     'Operacao', .t.)
2280:     *           xBrox.mAddColuna('nDopes', '9999', ' # ',      .f.)
2281:     *           xBrox.Show()
2282:     *       EndIf
2283:     *       =Seek(cpSigCdOpe.Dopes,'LocalDcOpe','Dopes')
2284:     *       If LocalDcOpe.OpeInatvs = 1
2285:     *           MessageBox('Esta Operacao esta Inativa!!!!',0+16,'Atencao...')
2286:     *           This.Value = ' '
2287:     *           Return .f.
2288:     *       Endif
2289:     *       This.Value = cpSigCdOpe.Dopes
2290:     *       Replace nDopes With CpSigCdOpe.nDopes in CrSigCdMop
2291:     *       This.Refresh
2292:     *   EndIf
2293:     *   Select CrSigCdMop
2294:     *   Return .t.
2295:     *
2296:     * O "LocalDcOpe" do legado eh o cursor de SigOpCdc que o Init carrega
2297:     * (Select Dopes, GerOpes, OpeInatvs From SigOpCdc + Index On Dopes) - aqui
2298:     * ele eh this_oBusinessObject.this_cCursorConfig, populado por
2299:     * CarregarConfiguracaoOperacao. A consulta de inatividade esta em
2300:     * ObterOperacaoInativa, que usa LOCATE e nao SEEK: o projeto roda com
2301:     * SET EXACT ON e, nesse modo, o SEEK exigiria a chave com o padding exato
2302:     * de char(20) (mesma razao ja documentada no BO).
2303:     *
2304:     * O REPLACE de ndopes eh o que preenche a coluna "  #  " da grade: ela NAO
2305:     * existe em SigCdMop, vem do JOIN com SigCdOpe, e por isso tem de ser
2306:     * gravada no cursor a mao quando o usuario escolhe a operacao FILHA.
2307:     *
2308:     * DUAS divergencias deliberadas em relacao ao legado, as duas pelo mesmo
2309:     * motivo (regras #37 e #50):
2310:     *
2311:     *   1. O legado le cpSigCdOpe.Dopes mesmo quando o usuario ABANDONA o
2312:     *      picker (ESC) - e nesse caso o cursor esta posicionado na primeira
2313:     *      linha da busca parcial, de modo que a celula recebe um valor que
2314:     *      ninguem escolheu. Aqui a atribuicao fica DENTRO da guarda
2315:     *      this_lSelecionou e o valor DIGITADO eh preservado.
2316:     *   2. Universo vazio NAO gera aviso nem apaga o que foi digitado: o

*-- Linhas 2326 a 2499:
2326:     * digitado eh aceito como esta: SQLEXEC com handle invalido dispara
2327:     * excecao, e abrir picker MODAL em teste headless travaria o processo.
2328:     *--------------------------------------------------------------------------
2329:     PROCEDURE ValidarMovimentacaoMopCorpo(par_oTxt)
2330:         LOCAL loc_lAceita, loc_cCursor, loc_cDigitado
2331: 
2332:         loc_lAceita   = .T.
2333:         loc_cCursor   = THIS.this_cCursorDados
2334:         loc_cDigitado = ALLTRIM(NVL(par_oTxt.Value, ""))
2335: 
2336:         *-- Sem conexao (harness/validacao de UI) o picker nao roda e o valor
2337:         *-- digitado eh aceito como esta: SQLEXEC com handle invalido dispara
2338:         *-- excecao, e abrir picker MODAL em teste headless travaria o processo.
2339:         IF !EMPTY(loc_cDigitado) AND TYPE("gnConnHandle") = "N" AND gnConnHandle > 0
2340:             loc_lAceita = THIS.AbrirBuscaMovimentacaoMop(par_oTxt)
2341:         ENDIF
2342: 
2343:         *-- "Select CrSigCdMop" do fim do Valid legado: o picker e o cursor de
2344:         *-- configuracao mexem na area de trabalho corrente, e a grade continua
2345:         *-- operando sobre o cursor dela.
2346:         IF USED(loc_cCursor)
2347:             SELECT (loc_cCursor)
2348:         ENDIF
2349: 
2350:         RETURN loc_lAceita
2351:     ENDPROC
2352: 
2353:     *--------------------------------------------------------------------------
2354:     * AbrirBuscaMovimentacaoMop - picker de SigCdOpe da celula "Movimentacao".
2355:     *
2356:     * Equivale ao bloco fwBuscaExt do Valid legado:
2357:     *   xBrox = CreateObject('fwBuscaExt', <conn>, 'SigCdOpe', 'cpSigCdOpe',
2358:     *             'Dopes', This.Value, 'Cadastro de Operacoes', .t., 'Dopes')
2359:     *   If Not xBrox.plAchouRegistro
2360:     *       xBrox.mAddColuna('Dopes',  '',     'Operacao', .t.)
2361:     *       xBrox.mAddColuna('nDopes', '9999', ' # ',      .f.)
2362:     *       xBrox.Show()
2363:     *   EndIf
2364:     *
2365:     * Devolve .F. SO quando a operacao escolhida esta INATIVA - ai o Valid
2366:     * precisa recusar o valor para o foco nao sair da celula (transcrito do
2367:     * "This.Value = ' ' / Return .f." do legado). Nos demais caminhos devolve
2368:     * .T.: nao achar nada NAO eh erro (regra #50).
2369:     *
2370:     * O REPLACE de ndopes eh o que preenche a coluna "  #  " da grade: ela NAO
2371:     * existe em SigCdMop, vem do JOIN com SigCdOpe, e por isso tem de ser
2372:     * gravada no cursor a mao quando o usuario escolhe a operacao FILHA.
2373:     *--------------------------------------------------------------------------
2374:     PROCEDURE AbrirBuscaMovimentacaoMop(par_oTxt)
2375:         LOCAL loc_lAceita, loc_cCursor, loc_cCursorBusca, loc_cDigitado
2376:         LOCAL loc_oBusca, loc_oErro, loc_cEscolhida, loc_nNdopes, loc_nInativa
2377: 
2378:         loc_lAceita      = .T.
2379:         loc_cCursor      = THIS.this_cCursorDados
2380:         loc_cCursorBusca = "cursor_4c_BuscaOpe"
2381:         loc_cDigitado    = ALLTRIM(NVL(par_oTxt.Value, ""))
2382: 
2383:         TRY
2384:             IF USED(loc_cCursorBusca)
2385:                 USE IN (loc_cCursorBusca)
2386:             ENDIF
2387: 
2388:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
2389:                 "SigCdOpe", loc_cCursorBusca, "dopes", loc_cDigitado, ;
2390:                 "Cadastro de Opera" + CHR(231) + CHR(245) + "es")
2391: 
2392:             IF VARTYPE(loc_oBusca) = "O"
2393:                 *-- Show() SO quando o Init nao resolveu sozinho: com match
2394:                 *-- exato o dialogo subiria por cima da celula ja resolvida
2395:                 IF !loc_oBusca.this_lAchouRegistro
2396:                     loc_oBusca.mAddColuna("dopes", "", ;
2397:                         "Opera" + CHR(231) + CHR(227) + "o")
2398:                     loc_oBusca.mAddColuna("ndopes", "9999", "  #  ")
2399:                     loc_oBusca.Show()
2400:                 ENDIF
2401: 
2402:                 IF loc_oBusca.this_lSelecionou AND USED(loc_cCursorBusca)
2403:                     loc_cEscolhida = ALLTRIM(NVL(EVALUATE(loc_cCursorBusca + ".dopes"), ""))
2404:                     loc_nNdopes    = TratarNulo(EVALUATE(loc_cCursorBusca + ".ndopes"), 0)
2405:                     loc_nInativa   = THIS.ObterOperacaoInativa(loc_cEscolhida)
2406: 
2407:                     IF loc_nInativa = 1
2408:                         MsgAviso("Esta Opera" + CHR(231) + CHR(227) + "o est" + ;
2409:                                  CHR(225) + " Inativa!!!!", ;
2410:                                  "Aten" + CHR(231) + CHR(227) + "o...")
2411:                         par_oTxt.Value = " "
2412:                         loc_lAceita    = .F.
2413:                     ELSE
2414:                         par_oTxt.Value = loc_cEscolhida
2415: 
2416:                         IF USED(loc_cCursor)
2417:                             REPLACE ndopes WITH loc_nNdopes IN (loc_cCursor)
2418:                         ENDIF
2419: 
2420:                         par_oTxt.Refresh()
2421:                     ENDIF
2422:                 ENDIF
2423: 
2424:                 IF USED(loc_cCursorBusca)
2425:                     USE IN (loc_cCursorBusca)
2426:                 ENDIF
2427: 
2428:                 loc_oBusca.Release()
2429:                 loc_oBusca = .NULL.
2430:             ENDIF
2431:         CATCH TO loc_oErro
2432:             MsgErro(loc_oErro.Message + CHR(13) + ;
2433:                     "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
2434:                     "Procedure: " + loc_oErro.Procedure, ;
2435:                     "Erro em AbrirBuscaMovimentacaoMop")
2436:         ENDTRY
2437: 
2438:         RETURN loc_lAceita
2439:     ENDPROC
2440: 
2441:     *--------------------------------------------------------------------------
2442:     * ObterOperacaoInativa - devolve 1 quando a operacao informada esta
2443:     * marcada como INATIVA em SigOpCdc, e 0 caso contrario.
2444:     *
2445:     * Equivale ao par do legado:
2446:     *   =Seek(cpSigCdOpe.Dopes,'LocalDcOpe','Dopes')
2447:     *   If LocalDcOpe.OpeInatvs = 1
2448:     *
2449:     * LOCATE em vez de SEEK por causa do SET EXACT ON do projeto (mesma razao
2450:     * do comentario de CarregarConfiguracaoOperacao no BO). A area de trabalho
2451:     * corrente eh salva e restaurada: o LOCATE roda no cursor de configuracao e
2452:     * quem chama continua precisando do cursor da GRADE selecionado.
2453:     *
2454:     * O VARTYPE eh conferido antes de comparar porque coluna de marcacao do
2455:     * SQL Server chega ao VFP ora Numerica (numeric(1,0)) ora Logica (bit),
2456:     * conforme o driver - comparar Logico com 1 estouraria
2457:     * "Operator/operand type mismatch" (regra #13).
2458:     *--------------------------------------------------------------------------
2459:     PROCEDURE ObterOperacaoInativa(par_cOperacao)
2460:         LOCAL loc_nInativa, loc_cCursorConfig, loc_cAreaAnterior, loc_uValor
2461: 
2462:         loc_nInativa = 0
2463: 
2464:         IF VARTYPE(THIS.this_oBusinessObject) != "O" OR ;
2465:            VARTYPE(par_cOperacao) != "C" OR EMPTY(ALLTRIM(par_cOperacao))
2466:             RETURN loc_nInativa
2467:         ENDIF
2468: 
2469:         loc_cCursorConfig = THIS.this_oBusinessObject.this_cCursorConfig
2470: 
2471:         IF !USED(loc_cCursorConfig)
2472:             RETURN loc_nInativa
2473:         ENDIF
2474: 
2475:         loc_cAreaAnterior = ALIAS()
2476: 
2477:         SELECT (loc_cCursorConfig)
2478:         LOCATE FOR ALLTRIM(dopes) == ALLTRIM(par_cOperacao)
2479: 
2480:         IF FOUND()
2481:             loc_uValor = TratarNulo(opeinatvs, 0)
2482: 
2483:             DO CASE
2484:                 CASE VARTYPE(loc_uValor) = "N"
2485:                     loc_nInativa = loc_uValor
2486:                 CASE VARTYPE(loc_uValor) = "L"
2487:                     loc_nInativa = IIF(loc_uValor, 1, 0)
2488:                 OTHERWISE
2489:                     loc_nInativa = 0
2490:             ENDCASE
2491:         ENDIF
2492: 
2493:         IF !EMPTY(loc_cAreaAnterior) AND USED(loc_cAreaAnterior)
2494:             SELECT (loc_cAreaAnterior)
2495:         ENDIF
2496: 
2497:         RETURN loc_nInativa
2498:     ENDPROC
2499: 

*-- Linhas 2509 a 2939:
2509:     * de editabilidade, na MESMA ordem do legado - eh dele que o Valid
2510:     * (ValidarCoresMopExec) decide se o usuario realmente mudou o valor.
2511:     *--------------------------------------------------------------------------
2512:     PROCEDURE CelulaCoresMopEditavel(par_oTxt)
2513:         LOCAL loc_cCursor
2514:         loc_cCursor = THIS.this_cCursorDados
2515: 
2516:         THIS.this_nValorAnterior = IIF(VARTYPE(par_oTxt.Value) = "N", par_oTxt.Value, 0)
2517: 
2518:         IF !USED(loc_cCursor)
2519:             RETURN .F.
2520:         ENDIF
2521: 
2522:         RETURN ALLTRIM(EVALUATE(loc_cCursor + ".cdopes")) == ALLTRIM(THIS.this_cOperacaoPai) AND ;
2523:                !EMPTY(ALLTRIM(EVALUATE(loc_cCursor + ".cnivels")))
2524:     ENDPROC
2525: 
2526:     *--------------------------------------------------------------------------
2527:     * ValidarCoresMopExec - Valid da celula "Cores".
2528:     *
2529:     * TRANSCRITO do legado (Column3.Text1.Valid):
2530:     *   If This.Value <> ThisForm.Antvalue
2531:     *       Thisform.lHouveIns = .T.
2532:     *       If This.Value > 0
2533:     *           x = GetColor(This.Value)
2534:     *           If x > 0 / This.Value = x / Else / This.Value = 0 / Endif
2535:     *           This.Refresh
2536:     *       Endif
2537:     *   Endif
2538:     * GETCOLOR() eh funcao NATIVA do VFP9 (abre o seletor de cor do Windows) -
2539:     * nao eh lookup em tabela, por isso o Valid inteiro fica nesta fase e nao
2540:     * na Fase 6 (que cobre os lookups de SigCdOpe/SigCdGpr/SigCdEmp).
2541:     *--------------------------------------------------------------------------
2542:     PROCEDURE ValidarCoresMopExec(par_oTxt)
2543:         LOCAL loc_nEscolhida
2544: 
2545:         IF par_oTxt.Value != THIS.this_nValorAnterior
2546:             THIS.this_lHouveInsercao = .T.
2547: 
2548:             IF par_oTxt.Value > 0
2549:                 loc_nEscolhida = GETCOLOR(par_oTxt.Value)
2550: 
2551:                 IF loc_nEscolhida > 0
2552:                     par_oTxt.Value = loc_nEscolhida
2553:                 ELSE
2554:                     par_oTxt.Value = 0
2555:                 ENDIF
2556: 
2557:                 par_oTxt.Refresh()
2558:             ENDIF
2559:         ENDIF
2560: 
2561:         RETURN .T.
2562:     ENDPROC
2563: 
2564:     *--------------------------------------------------------------------------
2565:     * GrandeGrupoMopGotFocusExec - GotFocus da celula "G.Grp"
2566:     * (grd_4c_Dados.Column6.txt_4c_GrandeGrupo).
2567:     *
2568:     * TRANSCRITO do legado (Column6.Text1.GotFocus):
2569:     *   This.Tag = This.Value
2570:     *
2571:     * Metade do detector de alteracao: o Tag guarda o valor de ENTRADA e o
2572:     * LostFocus compara com o de SAIDA. Sem este GotFocus o Tag nasceria vazio
2573:     * e QUALQUER passagem pela celula marcaria a tela como alterada.
2574:     *
2575:     * .Tag eh CHARACTER em VFP9 e nao aceita outro tipo - por isso guarda-se o
2576:     * ALLTRIM() do valor, nunca o valor cru.
2577:     *--------------------------------------------------------------------------
2578:     PROCEDURE GrandeGrupoMopGotFocusExec(par_oTxt)
2579:         par_oTxt.Tag = ALLTRIM(NVL(par_oTxt.Value, ""))
2580:     ENDPROC
2581: 
2582:     *--------------------------------------------------------------------------
2583:     * GrandeGrupoMopLostFocusExec - LostFocus da celula "G.Grp".
2584:     *
2585:     * TRANSCRITO do legado (Column6.Text1.LostFocus):
2586:     *   If (This.Tag <> This.Value)
2587:     *       Thisform.lHouveIns = .T.
2588:     *   EndIf
2589:     *
2590:     * A outra metade do detector: trocou o grande grupo, a tela passa a ter o
2591:     * que gravar. Eh esta flag que o cmdSair do legado consulta para decidir se
2592:     * executa a gravacao do cursor.
2593:     *--------------------------------------------------------------------------
2594:     PROCEDURE GrandeGrupoMopLostFocusExec(par_oTxt)
2595:         IF ALLTRIM(NVL(par_oTxt.Tag, "")) != ALLTRIM(NVL(par_oTxt.Value, ""))
2596:             THIS.this_lHouveInsercao = .T.
2597:         ENDIF
2598:     ENDPROC
2599: 
2600:     *--------------------------------------------------------------------------
2601:     * ValidarGrandeGrupoMopExec - Valid da celula "G.Grp": LOOKUP em SigCdGpr.
2602:     *
2603:     * WRAPPER da guarda de reentrancia (ver this_lEmLookup) - o corpo fica em
2604:     * ValidarGrandeGrupoMopCorpo para que a flag seja SEMPRE liberada aqui.
2605:     *--------------------------------------------------------------------------
2606:     PROCEDURE ValidarGrandeGrupoMopExec(par_oTxt)
2607:         LOCAL loc_lAceita
2608: 
2609:         IF THIS.this_lEmLookup
2610:             RETURN .T.
2611:         ENDIF
2612: 
2613:         THIS.this_lEmLookup = .T.
2614:         loc_lAceita         = THIS.ValidarGrandeGrupoMopCorpo(par_oTxt)
2615:         THIS.this_lEmLookup = .F.
2616: 
2617:         RETURN loc_lAceita
2618:     ENDPROC
2619: 
2620:     *--------------------------------------------------------------------------
2621:     * ValidarGrandeGrupoMopCorpo - corpo do lookup do grande grupo.
2622:     *
2623:     * TRANSCRITO do legado (SIGOPMOP.GradeSubN.Column6.Text1.Valid):
2624:     *   If Not Empty(This.Value)
2625:     *       loLista = CreateObject([fwBuscaExt], <conn>, [SigCdGpr],
2626:     *                   [crListaRemota], [Codigos], This.Value, [Selecao], .t.)
2627:     *       If Not loLista.plAchouRegistro
2628:     *           loLista.mAddColuna([Codigos], [], [Codigo])
2629:     *           loLista.mAddColuna([Descs],   [], [Descricao])
2630:     *           loLista.Show()
2631:     *       EndIf
2632:     *       This.Value = crListaRemota.Codigos
2633:     *       Use In crListaRemota
2634:     *   EndIf
2635:     *   This.Refresh
2636:     *
2637:     * Colunas conferidas em docs\schema.sql: SigCdGpr.codigos char(3) e
2638:     * SigCdGpr.descrs char(40) - NAO "descrs" (essa eh de SigCdGcr, que eh outra
2639:     * tabela). O destino na grade eh SigCdMop.mercs, tambem char(3).
2640:     *
2641:     * A atribuicao fica DENTRO da guarda this_lSelecionou (regra #37): o legado
2642:     * le crListaRemota.Codigos mesmo quando o usuario abandona o picker, e com
2643:     * isso a celula recebe a primeira linha da busca parcial sem ninguem ter
2644:     * escolhido. Universo vazio nao gera aviso nem apaga o digitado (regra #50).
2645:     *
2646:     * O Refresh final fica FORA do IF, igual ao legado.
2647:     *--------------------------------------------------------------------------
2648:     PROCEDURE ValidarGrandeGrupoMopCorpo(par_oTxt)
2649:         LOCAL loc_cCursor, loc_cDigitado
2650: 
2651:         loc_cCursor   = THIS.this_cCursorDados
2652:         loc_cDigitado = ALLTRIM(NVL(par_oTxt.Value, ""))
2653: 
2654:         *-- Sem conexao (harness/validacao de UI) o picker nao roda e o valor
2655:         *-- digitado eh aceito como esta.
2656:         IF !EMPTY(loc_cDigitado) AND TYPE("gnConnHandle") = "N" AND gnConnHandle > 0
2657:             THIS.AbrirBuscaGrandeGrupoMop(par_oTxt)
2658:         ENDIF
2659: 
2660:         IF USED(loc_cCursor)
2661:             SELECT (loc_cCursor)
2662:         ENDIF
2663: 
2664:         *-- O Refresh final fica FORA do IF, igual ao legado.
2665:         par_oTxt.Refresh()
2666: 
2667:         RETURN .T.
2668:     ENDPROC
2669: 
2670:     *--------------------------------------------------------------------------
2671:     * AbrirBuscaGrandeGrupoMop - picker de SigCdGpr da celula "G.Grp".
2672:     *
2673:     * Equivale ao bloco fwBuscaExt do Valid legado (Column6.Text1.Valid):
2674:     *   loLista = CreateObject([fwBuscaExt], <conn>, [SigCdGpr],
2675:     *               [crListaRemota], [Codigos], This.Value, [Selecao], .t.)
2676:     *   If Not loLista.plAchouRegistro
2677:     *       loLista.mAddColuna([Codigos], [], [Codigo])
2678:     *       loLista.mAddColuna([Descs],   [], [Descricao])
2679:     *       loLista.Show()
2680:     *   EndIf
2681:     *
2682:     * DIVERGENCIA deliberada: o legado faz "This.Value = crListaRemota.Codigos"
2683:     * FORA de qualquer guarda, inclusive quando o usuario ABANDONA o picker com
2684:     * ESC - e nesse caso o cursor esta na primeira linha da busca parcial, de
2685:     * modo que a celula recebe um valor que ninguem escolheu. Aqui a atribuicao
2686:     * fica DENTRO da guarda this_lSelecionou e o valor DIGITADO eh preservado
2687:     * (regras #37 e #50). Universo vazio nao avisa nem apaga o digitado.
2688:     *--------------------------------------------------------------------------
2689:     PROCEDURE AbrirBuscaGrandeGrupoMop(par_oTxt)
2690:         LOCAL loc_cCursorBusca, loc_cDigitado
2691:         LOCAL loc_oBusca, loc_oErro, loc_cEscolhido
2692: 
2693:         loc_cCursorBusca = "cursor_4c_BuscaGpr"
2694:         loc_cDigitado    = ALLTRIM(NVL(par_oTxt.Value, ""))
2695: 
2696:         TRY
2697:             IF USED(loc_cCursorBusca)
2698:                 USE IN (loc_cCursorBusca)
2699:             ENDIF
2700: 
2701:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
2702:                 "SigCdGpr", loc_cCursorBusca, "codigos", loc_cDigitado, ;
2703:                 "Sele" + CHR(231) + CHR(227) + "o")
2704: 
2705:             IF VARTYPE(loc_oBusca) = "O"
2706:                 IF !loc_oBusca.this_lAchouRegistro
2707:                     loc_oBusca.mAddColuna("codigos", "", "C" + CHR(243) + "digo")
2708:                     loc_oBusca.mAddColuna("descs", "", ;
2709:                         "Descri" + CHR(231) + CHR(227) + "o")
2710:                     loc_oBusca.Show()
2711:                 ENDIF
2712: 
2713:                 IF loc_oBusca.this_lSelecionou AND USED(loc_cCursorBusca)
2714:                     loc_cEscolhido = ALLTRIM(NVL(EVALUATE(loc_cCursorBusca + ".codigos"), ""))
2715:                     par_oTxt.Value = loc_cEscolhido
2716:                 ENDIF
2717: 
2718:                 IF USED(loc_cCursorBusca)
2719:                     USE IN (loc_cCursorBusca)
2720:                 ENDIF
2721: 
2722:                 loc_oBusca.Release()
2723:                 loc_oBusca = .NULL.
2724:             ENDIF
2725:         CATCH TO loc_oErro
2726:             MsgErro(loc_oErro.Message + CHR(13) + ;
2727:                     "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
2728:                     "Procedure: " + loc_oErro.Procedure, ;
2729:                     "Erro em AbrirBuscaGrandeGrupoMop")
2730:         ENDTRY
2731: 
2732:         RETURN .T.
2733:     ENDPROC
2734: 
2735:     *--------------------------------------------------------------------------
2736:     * ValidarEmpresaMopExec - Valid da celula "Emp."
2737:     * (grd_4c_Dados.Column7.txt_4c_Empresa): LOOKUP em SigCdEmp.
2738:     *
2739:     * WRAPPER da guarda de reentrancia (ver this_lEmLookup) - o corpo fica em
2740:     * ValidarEmpresaMopCorpo para que a flag seja SEMPRE liberada aqui.
2741:     *--------------------------------------------------------------------------
2742:     PROCEDURE ValidarEmpresaMopExec(par_oTxt)
2743:         LOCAL loc_lAceita
2744: 
2745:         IF THIS.this_lEmLookup
2746:             RETURN .T.
2747:         ENDIF
2748: 
2749:         THIS.this_lEmLookup = .T.
2750:         loc_lAceita         = THIS.ValidarEmpresaMopCorpo(par_oTxt)
2751:         THIS.this_lEmLookup = .F.
2752: 
2753:         RETURN loc_lAceita
2754:     ENDPROC
2755: 
2756:     *--------------------------------------------------------------------------
2757:     * ValidarEmpresaMopCorpo - corpo do lookup da empresa de destino.
2758:     *
2759:     * TRANSCRITO do legado (SIGOPMOP.GradeSubN.Column7.Text1.Valid):
2760:     *   If !IsEmpty( This.Value )
2761:     *       xBrox = CreateObject('fwbuscaext', <conn>, 'SigCdEmp', 'crSigCdEmp',
2762:     *                 'cEmps', This.Value, 'Empresas', .t., 'cEmps')
2763:     *       If  Not xBrox.plAchouRegistro
2764:     *           xBrox.mAddColuna('CEmps', 'XXXXXX', 'Codigo', .t.)
2765:     *           xBrox.mAddColuna('Razas', '', 'Descricao', .t.)
2766:     *           xBrox.Show()
2767:     *           This.Value = Iif( LastKey() # 27, Evaluate('crSigCdEmp.CEmps'), '' )
2768:     *       EndIf
2769:     *   Endif
2770:     *
2771:     * Colunas CANONICAS de SigCdEmp, conferidas em docs\schema.sql:
2772:     * cemps char(3) (codigo) e razas char(40) (descricao) - NUNCA "Emps" nem
2773:     * "NComps", que nao existem nessa tabela. O destino na grade eh
2774:     * SigCdMop.empds, tambem char(3).
2775:     *
2776:     * A mascara da coluna de codigo vai como "XXX" (tres posicoes = char(3)) e
2777:     * nao como o "XXXXXX" do dump: o legado tinha seis X para uma coluna de
2778:     * tres, e "XXX" eh tambem a forma canonica do projeto para SigCdEmp.cemps.
2779:     *
2780:     * DIVERGENCIA DELIBERADA: o legado limpa a celula quando o usuario sai do
2781:     * picker com ESC ("Iif( LastKey() # 27, ..., '' )"). O FormBuscaAuxiliar do
2782:     * projeto nao distingue ESC de universo vazio - as duas situacoes chegam
2783:     * como this_lSelecionou = .F. -, entao reproduzir o clear apagaria o codigo
2784:     * digitado tambem quando a consulta nao devolve linha nenhuma, que eh
2785:     * exatamente o defeito proibido pela regra #50 (o usuario fica sem como
2786:     * preencher o campo). Aqui o valor escolhido eh atribuido sob a guarda e, em
2787:     * qualquer outro caminho, o DIGITADO eh preservado.
2788:     *
2789:     * Esta celula NAO tem LostFocus no legado - editar so a empresa nao liga a
2790:     * flag de gravacao. Comportamento TRANSCRITO, nao esquecimento: na pratica a
2791:     * linha so chega a ter empresa depois de passar por Inserir, que ja liga a
2792:     * flag, e inventar aqui um LostFocus que o legado nao tem mudaria o criterio
2793:     * com que a tela decide gravar.
2794:     *--------------------------------------------------------------------------
2795:     PROCEDURE ValidarEmpresaMopCorpo(par_oTxt)
2796:         LOCAL loc_cCursor, loc_cDigitado
2797: 
2798:         loc_cCursor   = THIS.this_cCursorDados
2799:         loc_cDigitado = ALLTRIM(NVL(par_oTxt.Value, ""))
2800: 
2801:         *-- Sem conexao (harness/validacao de UI) o picker nao roda e o valor
2802:         *-- digitado eh aceito como esta.
2803:         IF !EMPTY(loc_cDigitado) AND TYPE("gnConnHandle") = "N" AND gnConnHandle > 0
2804:             THIS.AbrirBuscaEmpresaMop(par_oTxt)
2805:         ENDIF
2806: 
2807:         IF USED(loc_cCursor)
2808:             SELECT (loc_cCursor)
2809:         ENDIF
2810: 
2811:         RETURN .T.
2812:     ENDPROC
2813: 
2814:     *--------------------------------------------------------------------------
2815:     * AbrirBuscaEmpresaMop - picker de SigCdEmp da celula "Emp.".
2816:     *
2817:     * Equivale ao bloco fwBuscaExt do Valid legado (Column7.Text1.Valid):
2818:     *   xBrox = CreateObject('fwbuscaext', <conn>, 'SigCdEmp', 'crSigCdEmp',
2819:     *             'cEmps', This.Value, 'Empresas', .t., 'cEmps')
2820:     *   If Not xBrox.plAchouRegistro
2821:     *       xBrox.mAddColuna('CEmps', 'XXXXXX', 'Codigo',    .t.)
2822:     *       xBrox.mAddColuna('Razas', '',       'Descricao', .t.)
2823:     *       xBrox.Show()
2824:     *       This.Value = Iif( LastKey() # 27, Evaluate('crSigCdEmp.CEmps'), '' )
2825:     *   EndIf
2826:     *
2827:     * As colunas sao cemps char(3) + razas char(40) - nomes CANONICOS de
2828:     * SigCdEmp (NUNCA Cemps/Razas, que nao existem). A mascara do codigo eh
2829:     * "XXX", nao o "XXXXXX" do legado, porque a coluna eh char(3).
2830:     *
2831:     * DIVERGENCIA deliberada: o legado limpa a celula quando LastKey() = 27
2832:     * (ESC). Como o FormBuscaAuxiliar nao distingue ESC de universo vazio,
2833:     * reproduzir esse clear cairia exatamente no defeito da regra #50 - o
2834:     * usuario digitaria o codigo e o campo voltaria vazio, sem conseguir
2835:     * preencher. Aqui o valor so eh trocado sob this_lSelecionou (regra #37).
2836:     *--------------------------------------------------------------------------
2837:     PROCEDURE AbrirBuscaEmpresaMop(par_oTxt)
2838:         LOCAL loc_cCursorBusca, loc_cDigitado
2839:         LOCAL loc_oBusca, loc_oErro, loc_cEscolhida
2840: 
2841:         loc_cCursorBusca = "cursor_4c_BuscaEmp"
2842:         loc_cDigitado    = ALLTRIM(NVL(par_oTxt.Value, ""))
2843: 
2844:         TRY
2845:             IF USED(loc_cCursorBusca)
2846:                 USE IN (loc_cCursorBusca)
2847:             ENDIF
2848: 
2849:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
2850:                 "SigCdEmp", loc_cCursorBusca, "cemps", loc_cDigitado, ;
2851:                 "Empresas")
2852: 
2853:             IF VARTYPE(loc_oBusca) = "O"
2854:                 IF !loc_oBusca.this_lAchouRegistro
2855:                     loc_oBusca.mAddColuna("cemps", "XXX", "C" + CHR(243) + "digo")
2856:                     loc_oBusca.mAddColuna("razas", "", ;
2857:                         "Descri" + CHR(231) + CHR(227) + "o")
2858:                     loc_oBusca.Show()
2859:                 ENDIF
2860: 
2861:                 IF loc_oBusca.this_lSelecionou AND USED(loc_cCursorBusca)
2862:                     loc_cEscolhida = ALLTRIM(NVL(EVALUATE(loc_cCursorBusca + ".cemps"), ""))
2863:                     par_oTxt.Value = loc_cEscolhida
2864:                 ENDIF
2865: 
2866:                 IF USED(loc_cCursorBusca)
2867:                     USE IN (loc_cCursorBusca)
2868:                 ENDIF
2869: 
2870:                 loc_oBusca.Release()
2871:                 loc_oBusca = .NULL.
2872:             ENDIF
2873:         CATCH TO loc_oErro
2874:             MsgErro(loc_oErro.Message + CHR(13) + ;
2875:                     "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
2876:                     "Procedure: " + loc_oErro.Procedure, ;
2877:                     "Erro em AbrirBuscaEmpresaMop")
2878:         ENDTRY
2879: 
2880:         RETURN .T.
2881:     ENDPROC
2882: 
2883:     *--------------------------------------------------------------------------
2884:     * TornarControlesVisiveis - AddObject cria todo controle com Visible = .F.;
2885:     * este metodo percorre a arvore e liga a visibilidade.
2886:     *
2887:     * Nao ha lista de excecao aqui: o dump de SIGOPMOP nao declara Visible
2888:     * = .F. em objeto nenhum, e esta tela nao tem container flutuante
2889:     * alternado por botao. A visibilidade condicional que o legado tem eh a de
2890:     * cmdInserir/cmdExcluir, calculada por permissao e pelo modo do form PAI -
2891:     * ela eh aplicada DEPOIS desta varredura, junto com os botoes (Fase 4).
2892:     *--------------------------------------------------------------------------
2893:     PROCEDURE TornarControlesVisiveis(par_oContainer)
2894:         LOCAL loc_nI, loc_oControle
2895: 
2896:         FOR loc_nI = 1 TO par_oContainer.ControlCount
2897:             loc_oControle = par_oContainer.Controls(loc_nI)
2898: 
2899:             IF VARTYPE(loc_oControle) = "O"
2900:                 IF PEMSTATUS(loc_oControle, "Visible", 5)
2901:                     loc_oControle.Visible = .T.
2902:                 ENDIF
2903: 
2904:                 IF PEMSTATUS(loc_oControle, "ControlCount", 5) AND loc_oControle.ControlCount > 0
2905:                     THIS.TornarControlesVisiveis(loc_oControle)
2906:                 ENDIF
2907:             ENDIF
2908:         ENDFOR
2909:     ENDPROC
2910: 
2911:     *--------------------------------------------------------------------------
2912:     * Destroy - reabilita o form chamador e libera o objeto de negocio.
2913:     *
2914:     * A reabilitacao do pai eh FUNIL: o legado a faz no cmdSair.Click, que so
2915:     * cobre a saida pelo botao Encerrar; aqui ela fica no Destroy, que roda
2916:     * em qualquer caminho de fechamento (botao, ESC/Cancel, Release de fora).
2917:     * Sem isso, fechar o dialogo por outro caminho deixaria o Cadastro de
2918:     * Operacoes inerte para o resto da sessao - estado que ninguem restaura,
2919:     * nao estoura e nao entra em log.
2920:     *
2921:     * O cursor da grade NAO eh fechado aqui: com DataSession = 1 ele vive na
2922:     * sessao do form chamador (que eh quem continua a usa-lo depois deste
2923:     * dialogo fechar), igual ao legado, que roda na sessao do pai e nao fecha
2924:     * crSigCdMop no cmdSair.
2925:     *
2926:     * DODEFAULT() na ULTIMA linha, para que FormBase.Destroy execute e
2927:     * reconstrua os popups do menu principal.
2928:     *--------------------------------------------------------------------------
2929:     PROCEDURE Destroy()
2930:         THIS.HabilitarFormPai(.T.)
2931: 
2932:         IF VARTYPE(THIS.this_oBusinessObject) = "O"
2933:             THIS.this_oBusinessObject = .NULL.
2934:         ENDIF
2935: 
2936:         DODEFAULT()
2937:     ENDPROC
2938: 
2939: ENDDEFINE


### BO (C:\4c\projeto\app\classes\SigOpMopBO.prg):
*====================================================================
* SigOpMopBO.prg
*
* Business Object para Geracao de Multiplas Operacoes
* Origem legado: SIGOPMOP.SCX (form OPERACIONAL - dialogo filho de SIGCDOPE)
* Tabela: SigCdMop
* Herda de: BusinessBase
*
* A tela eh um dialogo filho aberto pelo Cadastro de Operacoes (SigCdOpe).
* Cada linha da grade eh um registro de SigCdMop que amarra a operacao PAI
* (cdopes) a uma operacao FILHA (cnivels), com cor, ordem, grande grupo e
* empresa de destino.
*
* Colunas de SigCdMop (TODAS NOT NULL - ver docs\schema.sql):
*   cdopes    char(20)        - operacao PAI  (crSigCdOpe.Dopes no legado)
*   cidchaves char(20)        - PK, gerada por fUniqueIds()
*   cnivels   char(20)        - operacao FILHA ("Movimentacao" na grade)
*   ncors     numeric(10,0)   - cor RGB ("Cores")
*   padraos   numeric(1,0)    - marca de linha padrao ("Padrao")
*   ordems    numeric(3,0)    - ordem de execucao ("Ordem")
*   mercs     char(3)         - grande grupo ("G.Grp")
*   empds     char(3)         - empresa de destino ("Emp.") - DEFAULT ('')
*   opers     char(1)         - sem controle na tela      - DEFAULT ('')
*
* ATENCAO: ndopes NAO existe em SigCdMop. Eh coluna de EXIBICAO da grade,
* lida de SigCdOpe.ndopes pelo legado ("Replace nDopes With CpSigCdOpe.nDopes
* in CrSigCdMop") e por isso NUNCA entra no INSERT/UPDATE desta tabela.
*====================================================================

DEFINE CLASS SigOpMopBO AS BusinessBase

    *----------------------------------------------------------------
    * Propriedades da entidade (mapeamento 1-para-1 com SigCdMop)
    *----------------------------------------------------------------
    this_cCidChaves   = ""    && cidchaves char(20)      - PK (fUniqueIds)
    this_cCdopes      = ""    && cdopes    char(20)      - operacao PAI
    this_cCnivels     = ""    && cnivels   char(20)      - operacao FILHA
    this_nNcors       = 0     && ncors     numeric(10,0) - cor RGB
    this_nPadraos     = 0     && padraos   numeric(1,0)  - linha padrao
    this_nOrdems      = 0     && ordems    numeric(3,0)  - ordem
    this_cMercs       = ""    && mercs     char(3)       - grande grupo
    this_cEmpds       = ""    && empds     char(3)       - empresa destino
    this_cOpers       = ""    && opers     char(1)       - sem UI (NOT NULL)

    *----------------------------------------------------------------
    * Propriedade de EXIBICAO - vem de SigCdOpe.ndopes, NAO de SigCdMop.
    * Fica no cursor da grade (coluna " # ") e nao eh persistida aqui.
    *----------------------------------------------------------------
    this_nNdopes      = 0     && ndopes    numeric(4,0)  - numero da operacao

    *----------------------------------------------------------------
    * Contexto recebido do form PAI (SigCdOpe) ao abrir o dialogo
    *----------------------------------------------------------------
    this_cOperacaoPai = ""    && Dopes da operacao corrente no form pai
    this_cEscolha     = ""    && Modo do pai: INSERIR / ALTERAR / PROCURAR

    *----------------------------------------------------------------
    * Configuracao da operacao (SigOpCdc) - decide o comportamento da grade
    *   geropes   <> 2 trava a coluna "Cores" (legado: Column3.ReadOnly = .T.)
    *   opeinatvs  = 1 recusa a operacao digitada em "Movimentacao"
    *----------------------------------------------------------------
    this_nGerOpes     = 0     && SigOpCdc.geropes   numeric(1,0)
    this_nOpeInatvs   = 0     && SigOpCdc.opeinatvs numeric(1,0)

    *----------------------------------------------------------------
    * Nomes de cursores (centralizados para a grade nao perder o bind)
    *----------------------------------------------------------------
    this_cCursorDados  = "cursor_4c_Dados"       && cursor da grade (crSigCdMop)
    this_cCursorTemp   = "cursor_4c_DadosTmp"    && destino dos SQLEXEC
    this_cCursorConfig = "cursor_4c_ConfigOpe"   && LocalDcOpe do legado
    this_cCursorBusca  = "cursor_4c_Busca"       && reserva (os lookups da grade usam um cursor por tabela)
    this_cCursorChaves = "cursor_4c_ChavesMop"   && cidchaves JA gravadas (reconciliacao da gravacao)

    *====================================================================
    * Init - Inicializa Business Object
    *====================================================================
    PROCEDURE Init()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            DODEFAULT()

            THIS.this_cTabela     = "SigCdMop"
            THIS.this_cCampoChave = "cidchaves"

            THIS.this_cCursorDados  = "cursor_4c_Dados"
            THIS.this_cCursorTemp   = "cursor_4c_DadosTmp"
            THIS.this_cCursorConfig = "cursor_4c_ConfigOpe"
            THIS.this_cCursorBusca  = "cursor_4c_Busca"
            THIS.this_cCursorChaves = "cursor_4c_ChavesMop"

            THIS.this_lEmEdicao     = .F.
            THIS.this_lNovoRegistro = .F.

            loc_lSucesso = .T.

        CATCH TO loc_oErro
            MostrarErro(loc_oErro, "SigOpMopBO.Init")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * ObterChavePrimaria - Retorna a chave primaria para a auditoria
    *====================================================================
    FUNCTION ObterChavePrimaria()
        RETURN ALLTRIM(THIS.this_cCidChaves)
    ENDFUNC

    *====================================================================
    * CarregarDoCursor - Carrega propriedades do BO a partir de uma linha
    * do cursor da grade (cursor_4c_Dados / crSigCdMop no legado).
    *
    * this_nNdopes NAO vem de SigCdMop - eh lido do mesmo cursor porque a
    * grade de SigOpMopBO.Buscar() ja traz essa coluna de exibicao vinda
    * do JOIN com SigCdOpe (ver comentario no cabecalho do arquivo).
    *====================================================================
    PROTECTED PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF USED(par_cAliasCursor)
                SELECT (par_cAliasCursor)
                THIS.this_cCidChaves = TratarNulo(cidchaves, "")
                THIS.this_cCdopes    = TratarNulo(cdopes,    "")
                THIS.this_cCnivels   = TratarNulo(cnivels,   "")
                THIS.this_nNcors     = TratarNulo(ncors,      0)
                THIS.this_nPadraos   = TratarNulo(padraos,    0)
                THIS.this_nOrdems    = TratarNulo(ordems,     0)
                THIS.this_cMercs     = TratarNulo(mercs,     "")
                THIS.this_cEmpds     = TratarNulo(empds,     "")
                THIS.this_cOpers     = TratarNulo(opers,     "")

                IF TYPE(par_cAliasCursor + ".ndopes") != "U"
                    THIS.this_nNdopes = TratarNulo(ndopes,  0)
                ENDIF

                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MostrarErro(loc_oErro.Message, "SigOpMopBO.CarregarDoCursor")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * Inserir - Insere nova linha na tabela SigCdMop
    *
    * Transcreve o cmdInserir.Click do legado (ver InicializarValoresPadrao):
    * todas as colunas sao NOT NULL, entao TODAS entram no INSERT - inclusive
    * empds/opers, que nao tem controle visivel na grade (regra #22).
    *====================================================================
    PROTECTED PROCEDURE Inserir()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso

        loc_lSucesso = .F.

        TRY
            TEXT TO loc_cSQL TEXTMERGE NOSHOW
                INSERT INTO SigCdMop (cidchaves, cdopes, cnivels, ncors, padraos, ordems, mercs, empds, opers)
                VALUES (
                    <<EscaparSQL(THIS.this_cCidChaves)>>,
                    <<EscaparSQL(THIS.this_cCdopes)>>,
                    <<EscaparSQL(THIS.this_cCnivels)>>,
                    <<FormatarNumeroSQL(THIS.this_nNcors, 0)>>,
                    <<FormatarNumeroSQL(THIS.this_nPadraos, 0)>>,
                    <<FormatarNumeroSQL(THIS.this_nOrdems, 0)>>,
                    <<EscaparSQL(THIS.this_cMercs)>>,
                    <<EscaparSQL(THIS.this_cEmpds)>>,
                    <<EscaparSQL(THIS.this_cOpers)>>
                )
            ENDTEXT

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("INSERT")
                loc_lSucesso = .T.
            ELSE
                MostrarErro("Erro ao inserir opera" + CHR(231) + CHR(227) + "o:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loc_oErro
            MostrarErro(loc_oErro.Message, "SigOpMopBO.Inserir")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * Atualizar - Atualiza linha existente na tabela SigCdMop
    *====================================================================
    PROTECTED PROCEDURE Atualizar()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso

        loc_lSucesso = .F.

        TRY
            TEXT TO loc_cSQL TEXTMERGE NOSHOW
                UPDATE SigCdMop
                SET cdopes  = <<EscaparSQL(THIS.this_cCdopes)>>,
                    cnivels = <<EscaparSQL(THIS.this_cCnivels)>>,
                    ncors   = <<FormatarNumeroSQL(THIS.this_nNcors, 0)>>,
                    padraos = <<FormatarNumeroSQL(THIS.this_nPadraos, 0)>>,
                    ordems  = <<FormatarNumeroSQL(THIS.this_nOrdems, 0)>>,
                    mercs   = <<EscaparSQL(THIS.this_cMercs)>>,
                    empds   = <<EscaparSQL(THIS.this_cEmpds)>>,
                    opers   = <<EscaparSQL(THIS.this_cOpers)>>
                WHERE cidchaves = <<EscaparSQL(THIS.this_cCidChaves)>>
            ENDTEXT

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("UPDATE")
                loc_lSucesso = .T.
            ELSE
                MostrarErro("Erro ao atualizar opera" + CHR(231) + CHR(227) + "o:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loc_oErro
            MostrarErro(loc_oErro.Message, "SigOpMopBO.Atualizar")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * LimparDados - Zera as propriedades da entidade
    *
    * Mantem o CONTEXTO (operacao pai, modo e configuracao da operacao):
    * ele vem do form pai na abertura do dialogo e vale para todas as
    * linhas, nao para uma linha so.
    *====================================================================
    PROCEDURE LimparDados()
        DODEFAULT()

        THIS.this_cCidChaves = ""
        THIS.this_cCdopes    = ""
        THIS.this_cCnivels   = ""
        THIS.this_nNcors     = 0
        THIS.this_nPadraos   = 0
        THIS.this_nOrdems    = 0
        THIS.this_cMercs     = ""
        THIS.this_cEmpds     = ""
        THIS.this_cOpers     = ""
        THIS.this_nNdopes    = 0

        RETURN .T.
    ENDPROC

    *====================================================================
    * InicializarValoresPadrao - Defaults da linha NOVA
    *
    * Transcreve o cmdInserir.Click do legado:
    *   Insert Into crSigCdMop (cDopes, CidChaves) ;
    *       Values (crSigCdOpe.Dopes, fUniqueIds())
    * Ou seja: a linha nova nasce amarrada a operacao PAI, com PK propria,
    * e o restante em branco/zero (as colunas sao NOT NULL, por isso
    * precisam de valor explicito - nunca NULL).
    *====================================================================
    PROTECTED PROCEDURE InicializarValoresPadrao()
        THIS.this_cCidChaves = fUniqueIds()
        THIS.this_cCdopes    = ALLTRIM(THIS.this_cOperacaoPai)
        THIS.this_cCnivels   = ""
        THIS.this_nNcors     = 0
        THIS.this_nPadraos   = 0
        THIS.this_nOrdems    = 0
        THIS.this_cMercs     = ""
        THIS.this_cEmpds     = ""
        THIS.this_cOpers     = ""
        THIS.this_nNdopes    = 0

        RETURN .T.
    ENDPROC

    *====================================================================
    * CarregarConfiguracaoOperacao - popula o cursor de configuracao das
    * operacoes (SigOpCdc) e resolve geropes/opeinatvs da operacao PAI.
    *
    * TRANSCRITO do Init legado:
    *   lcSql = [Select Dopes, GerOpes, OpeInatvs From SigOpCdc ]
    *   SigCdOpe.Podatamgr.Sqlexecute(lcSql,'LocalDcOpe')
    *   Select LocalDcOpe
    *   Index On Dopes Tag dopes
    *   =Seek(CrSigCdOpe.Dopes)
    *
    * O cursor carrega TODAS as operacoes de proposito, e NAO so a corrente:
    * o Valid da coluna "Movimentacao" reconsulta este mesmo cursor para
    * recusar a operacao digitada quando ela esta inativa ("=Seek(
    * cpSigCdOpe.Dopes,'LocalDcOpe','Dopes') / If LocalDcOpe.OpeInatvs = 1").
    * Filtrar aqui pela operacao PAI deixaria aquela checagem sem base.
    *
    * geropes decide se a coluna "Cores" aceita digitacao (<> 2 trava), e eh
    * por isso que esta carga roda ANTES da montagem da grade.
    *====================================================================
    PROCEDURE CarregarConfiguracaoOperacao()
        LOCAL loc_lSucesso, loc_cSQL, loc_nResultado, loc_oErro
        loc_lSucesso = .F.

        THIS.this_nGerOpes   = 0
        THIS.this_nOpeInatvs = 0

        TRY
            IF USED(THIS.this_cCursorConfig)
                USE IN (THIS.this_cCursorConfig)
            ENDIF

            loc_cSQL = "SELECT dopes, geropes, opeinatvs FROM SigOpCdc"

            loc_nResultado = -1
            IF TYPE("gnConnHandle") = "N" AND gnConnHandle > 0
                IF USED(THIS.this_cCursorTemp)
                    USE IN (THIS.this_cCursorTemp)
                ENDIF
                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, THIS.this_cCursorTemp)
            ENDIF

            IF loc_nResultado > 0 AND USED(THIS.this_cCursorTemp)
                SELECT * FROM (THIS.this_cCursorTemp) ;
                    INTO CURSOR (THIS.this_cCursorConfig) READWRITE
                USE IN (THIS.this_cCursorTemp)
            ELSE
                *-- Sem conexao (harness/validacao de UI) ou consulta recusada:
                *-- cursor VAZIO com a MESMA estrutura, para a grade continuar
                *-- montavel e a checagem de operacao inativa nao estourar.
                CREATE CURSOR (THIS.this_cCursorConfig) ( ;
                    dopes     C(20), ;
                    geropes   N(1, 0), ;
                    opeinatvs N(1, 0) )
            ENDIF

            *-- "Index On Dopes Tag dopes" do legado
            SELECT (THIS.this_cCursorConfig)
            INDEX ON dopes TAG dopes

            *-- Equivalente ao "=Seek(CrSigCdOpe.Dopes)". LOCATE em vez de SEEK
            *-- porque o projeto roda com SET EXACT ON, e nesse modo o SEEK
            *-- exigiria a chave com o padding exato de char(20) - ver a regra
            *-- do indice composto/SEEK parcial no CLAUDE.md.
            IF !EMPTY(ALLTRIM(THIS.this_cOperacaoPai))
                LOCATE FOR ALLTRIM(dopes) == ALLTRIM(THIS.this_cOperacaoPai)
                IF FOUND()
                    THIS.this_nGerOpes   = TratarNulo(geropes,    0)
                    THIS.this_nOpeInatvs = TratarNulo(opeinatvs,  0)
                ENDIF
            ENDIF

            loc_lSucesso = .T.

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Erro em CarregarConfiguracaoOperacao")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * CarregarGrade - popula o cursor da grade com as linhas de SigCdMop
    * da operacao PAI.
    *
    * A consulta eh a MESMA que o form chamador (SIGCDOPE) registra no
    * AddCursor de 'crSigCdMop' - transcrita de
    * tasks\task483\SIGCDOPE_form_codigo_fonte.txt:54214:
    *
    *   Select a.*, b.nDopes
    *     From SigCdMop a
    *     inner join SigCdOpe b on a.cnivels = b.Dopes
    *    Where a.cDopes = ?crSigCdOpe.Dopes
    *    Order by a.cDopes, a.cNivels
    *
    * O JOIN eh quem traz "ndopes" (o numero da operacao FILHA, coluna " # "
    * da grade), que NAO existe em SigCdMop.
    *
    * O JOIN eh LEFT, e NAO inner (corrigido na Fase 8). No legado o cursor da
    * grade nao eh um JOIN: eh o "crSigCdMop" do form PAI (SigCdOpe.poDataMgr),
    * que eh "SigCdMop" inteiro MAIS uma coluna LOCAL nDopes, preenchida a mao
    * pelo Valid da celula Movimentacao ("Replace nDopes With CpSigCdOpe.nDopes
    * in CrSigCdMop"). Ou seja: no legado a linha com cnivels em BRANCO - a que
    * o botao Inserir cria e o usuario pode deixar sem preencher - esta no
    * cursor e eh gravada pelo UpDate/Commit do cmdSair.
    *
    * Com INNER essa linha, uma vez gravada, NAO voltava do banco (nao ha
    * SigCdOpe com Dopes em branco): ela desaparecia da tela sem erro nenhum e,
    * pior, a reconciliacao da Fase 8 (GravarGrade) a leria como "existe no
    * banco e nao esta mais na grade" e a EXCLUIRIA - perda silenciosa de dado.
    * LEFT + ISNULL(b.ndopes, 0) deixa o cursor ser a imagem FIEL de
    * "SigCdMop WHERE cdopes = <operacao pai>", que eh o que a reconciliacao
    * pressupoe, e ISNULL mantem a coluna numeric(4,0) SEM nulo (CheckBox e
    * REPLACE sobre coluna anulavel estouram em runtime).
    *
    * O cursor tem de ser READWRITE: as colunas Movimentacao/Cores/Padrao/
    * Ordem/G.Grp/Emp. sao editaveis na grade, e cursor de SQLEXEC nasce
    * SOMENTE-LEITURA (a celula renderiza e nunca entra em edicao). Por isso
    * o SQLEXEC vai para um cursor TEMPORARIO e o cursor da grade sai de um
    * "SELECT * ... INTO CURSOR ... READWRITE".
    *
    * ATENCAO: este metodo DERRUBA o alias da grade, e fechar o alias de um
    * Grid destroi o controle posto por Column.AddObject (o CheckBox da
    * coluna Padrao) - perda PARCIAL e silenciosa, porque Width/Header
    * sobrevivem e so o CheckBox volta a desenhar o Text1. Quem chama este
    * metodo TEM de remontar a grade pelo funil (FormSigOpMop.MontaGrade).
    *====================================================================
    PROCEDURE CarregarGrade()
        LOCAL loc_lSucesso, loc_cSQL, loc_nResultado, loc_oErro
        loc_lSucesso = .F.

        TRY
            IF USED(THIS.this_cCursorDados)
                USE IN (THIS.this_cCursorDados)
            ENDIF

            TEXT TO loc_cSQL NOSHOW TEXTMERGE
                SELECT a.cdopes, a.cidchaves, a.cnivels, a.ncors,
                       a.padraos, a.ordems, a.mercs, a.empds, a.opers,
                       ISNULL(b.ndopes, 0) AS ndopes
                  FROM SigCdMop a
                  LEFT JOIN SigCdOpe b ON a.cnivels = b.dopes
                 WHERE a.cdopes = <<EscaparSQL(ALLTRIM(THIS.this_cOperacaoPai))>>
                 ORDER BY a.cdopes, a.cnivels
            ENDTEXT

            loc_nResultado = -1
            IF TYPE("gnConnHandle") = "N" AND gnConnHandle > 0
                IF USED(THIS.this_cCursorTemp)
                    USE IN (THIS.this_cCursorTemp)
                ENDIF
                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, THIS.this_cCursorTemp)
            ENDIF

            IF loc_nResultado > 0 AND USED(THIS.this_cCursorTemp)
                SELECT * FROM (THIS.this_cCursorTemp) ;
                    INTO CURSOR (THIS.this_cCursorDados) READWRITE
                USE IN (THIS.this_cCursorTemp)
                loc_lSucesso = .T.
            ELSE
                *-- Sem conexao ou consulta recusada: cursor vazio com a MESMA
                *-- estrutura da consulta, na MESMA ordem de colunas (o APPEND
                *-- de uma recarga futura casa por NOME, e a grade liga por
                *-- ControlSource - estrutura divergente quebraria os dois).
                THIS.CriarCursorGradeVazio()

                IF loc_nResultado <= 0 AND TYPE("gnConnHandle") = "N" AND gnConnHandle > 0
                    MsgErro("Erro ao carregar as opera" + CHR(231) + CHR(245) + "es m" + ;
                            CHR(250) + "ltiplas." + CHR(13) + CapturarErroSQL(), ;
                            "Erro SQL")
                ELSE
                    *-- Ausencia de conexao nao eh falha de carga: eh o cenario
                    *-- do harness, e a grade abre vazia e montavel.
                    loc_lSucesso = .T.
                ENDIF
            ENDIF

            IF USED(THIS.this_cCursorDados)
                SELECT (THIS.this_cCursorDados)
                GO TOP
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Erro em CarregarGrade")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * CriarCursorGradeVazio - estrutura do cursor da grade.
    *
    * Os tipos vem de docs\schema.sql (SigCdMop, todas NOT NULL) mais a
    * coluna de exibicao ndopes, que eh SigCdOpe.ndopes numeric(4,0).
    * A ordem eh a MESMA do SELECT de CarregarGrade - placeholder com
    * estrutura divergente do cursor real quebra o bind da grade.
    *
    * SEM "SET NULL ON" de proposito: a grade EDITA estas colunas, e NULL em
    * coluna numerica ligada a CheckBox/REPLACE estoura em runtime. Todas as
    * colunas de origem sao NOT NULL e o JOIN eh INNER, logo o resultado real
    * tambem nunca traz nulo.
    *====================================================================
    PROTECTED PROCEDURE CriarCursorGradeVazio()
        CREATE CURSOR (THIS.this_cCursorDados) ( ;
            cdopes    C(20), ;
            cidchaves C(20), ;
            cnivels   C(20), ;
            ncors     N(10, 0), ;
            padraos   N(1, 0), ;
            ordems    N(3, 0), ;
            mercs     C(3), ;
            empds     C(3), ;
            opers     C(1), ;
            ndopes    N(4, 0) )

        RETURN .T.
    ENDPROC

    *====================================================================
    * ConexaoAtiva - .T. quando gnConnHandle existe E eh um handle valido.
    *
    * Existe para que o teste nao seja escrito como
    *   IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
    * que eh o padrao dominante no projeto e tem um defeito latente: VFP9 NAO
    * faz curto-circuito em OR (nem em AND), entao "gnConnHandle <= 0" eh
    * avaliado AINDA QUE o TYPE tenha dado "U" - e comparar variavel
    * inexistente com 0 estoura "Variable GNCONNHANDLE is not found". Com IF
    * ANINHADO o segundo teste so acontece quando o primeiro garantiu o tipo.
    *
    * PUBLIC (sem PROTECTED) porque o FORM tambem pergunta, antes de comecar a
    * gravar a grade: metodo do BO chamado de fora nao pode ser PROTECTED em
    * nenhum nivel da heranca (regra #51), e BusinessBase nao declara este nome.
    *====================================================================
    FUNCTION ConexaoAtiva()
        IF TYPE("gnConnHandle") != "N"
            RETURN .F.
        ENDIF

        RETURN (gnConnHandle > 0)
    ENDFUNC

    *====================================================================
    * ExecutarExclusao - DELETE de UMA linha de SigCdMop.
    *
    * Chamado SO por BusinessBase.Excluir() (PROTECTED - de fora, sempre
    * Excluir(); regra #51). Sem este override a base devolveria .F. com
    * "Metodo ExecutarExclusao() sem override na subclasse" e a linha que o
    * usuario apagou na grade continuaria no banco.
    *
    * Equivale a parte de DELETE do "poDataMgr.UpDate('crSigCdMop')" do legado:
    * la o TABLEUPDATE da view enviava um DELETE por registro marcado; aqui
    * quem decide QUAIS linhas sumiram eh a reconciliacao do form
    * (FormSigOpMop.GravarGrade), e este metodo executa UMA delas.
    *
    * DUAS guardas, as duas deliberadas:
    *   1) chave VAZIA recusa a exclusao. "DELETE ... WHERE cidchaves = ''"
    *      casaria com TODA linha de chave em branco da tabela (comparacao de
    *      char no SQL Server eh blank-padded ANSI) - apagaria registro de
    *      outra operacao. Recusar deixa a linha no banco, que eh a falha
    *      SEGURA: ela reaparece na proxima abertura.
    *   2) "AND cdopes" junto da PK. cidchaves JA eh a primary key
    *      (sigcdmop_cidchaves), entao o filtro eh redundante no caminho
    *      normal - ele existe para que um defeito futuro na reconciliacao nao
    *      consiga apagar linha de OUTRA operacao pai. Se divergir, o DELETE
    *      nao afeta nenhuma linha e o registro sobrevive (falha segura).
    *
    * RegistrarAuditoria roda ANTES de a base chamar LimparDados(), porque
    * ObterChavePrimaria() le this_cCidChaves - zerada, a auditoria sairia sem
    * chave e BusinessBase.RegistrarAuditoria descartaria o log.
    *====================================================================
    PROTECTED PROCEDURE ExecutarExclusao()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso, loc_cChave, loc_oErro

        loc_lSucesso = .F.
        loc_cChave   = ALLTRIM(THIS.this_cCidChaves)

        TRY
            IF EMPTY(loc_cChave)
                THIS.this_cMensagemErro = "Linha sem chave prim" + CHR(225) + ;
                    "ria (cidchaves): exclus" + CHR(227) + "o recusada."
            ELSE
                TEXT TO loc_cSQL TEXTMERGE NOSHOW
                    DELETE FROM SigCdMop
                     WHERE cidchaves = <<EscaparSQL(loc_cChave)>>
                       AND cdopes    = <<EscaparSQL(ALLTRIM(THIS.this_cCdopes))>>
                ENDTEXT

                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

                IF loc_nResultado >= 0
                    THIS.RegistrarAuditoria("DELETE")
                    loc_lSucesso = .T.
                ELSE
                    MostrarErro("Erro ao excluir a opera" + CHR(231) + CHR(227) + ;
                        "o m" + CHR(250) + "ltipla:" + CHR(13) + CapturarErroSQL(), ;
                        "Erro SQL")
                ENDIF
            ENDIF

        CATCH TO loc_oErro
            MostrarErro(loc_oErro.Message, "SigOpMopBO.ExecutarExclusao")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * CarregarChavesGravadas - popula this_cCursorChaves com as cidchaves que
    * JA existem em SigCdMop para a operacao PAI.
    *
    * Eh a base da reconciliacao que substitui o "poDataMgr.UpDate(
    * 'crSigCdMop')" do legado. A view remota do legado sabia, pelo proprio
    * buffer, quais registros eram novos, alterados ou apagados; o cursor local
    * desta arquitetura NAO guarda esse estado (CURSORGETPROP("Buffering") = 1
    * num "SELECT ... INTO CURSOR ... READWRITE" - regra #52), entao o estado
    * eh RECONSTRUIDO comparando a grade com a imagem do banco:
    *
    *   chave na grade E no banco   -> UPDATE
    *   chave na grade e NAO no banco -> INSERT
    *   chave no banco e NAO na grade -> DELETE
    *
    * UMA consulta resolve as tres decisoes para todas as linhas. A alternativa
    * (um "SELECT COUNT(*)" por linha) daria N+1 idas ao servidor para o mesmo
    * resultado.
    *
    * O cursor fica SOMENTE-LEITURA de proposito: ele so eh lido por LOCATE.
    *====================================================================
    PROCEDURE CarregarChavesGravadas()
        LOCAL loc_lSucesso, loc_cSQL, loc_nResultado, loc_oErro
        loc_lSucesso = .F.

        TRY
            IF USED(THIS.this_cCursorChaves)
                USE IN (THIS.this_cCursorChaves)
            ENDIF

            TEXT TO loc_cSQL TEXTMERGE NOSHOW
                SELECT cidchaves
                  FROM SigCdMop
                 WHERE cdopes = <<EscaparSQL(ALLTRIM(THIS.this_cOperacaoPai))>>
            ENDTEXT

            IF !THIS.ConexaoAtiva()
                THIS.this_cMensagemErro = "Sem conex" + CHR(227) + "o com o banco: " + ;
                    "n" + CHR(227) + "o foi poss" + CHR(237) + "vel ler as opera" + ;
                    CHR(231) + CHR(245) + "es j" + CHR(225) + " gravadas."
            ELSE
                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, THIS.this_cCursorChaves)

                IF loc_nResultado > 0 AND USED(THIS.this_cCursorChaves)
                    loc_lSucesso = .T.
                ELSE
                    THIS.this_cMensagemErro = "Erro ao ler as opera" + CHR(231) + ;
                        CHR(245) + "es j" + CHR(225) + " gravadas:" + CHR(13) + ;
                        CapturarErroSQL()
                ENDIF
            ENDIF

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MostrarErro(loc_oErro.Message, "SigOpMopBO.CarregarChavesGravadas")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * ConfirmarGravacao / DesfazerGravacao - o par Commit/RollBack que o
    * cmdSair.Click do legado executa sobre a conexao:
    *
    *   If m.lnErro1>0
    *       m.lnErro1 = Iif(.poDataMgr.UpDate('crSigCdMop'),1,-1)
    *   EndIf
    *   If m.lnErro1>0
    *       m.lnErro1 = .poDataMgr.Commit()      && <- passo PROPRIO, com
    *   EndIf                                    &&    caminho de falha proprio
    *   If Not m.lnErro1>0
    *       .poDataMgr.RollBack()
    *   EndIf
    *
    * O Commit NAO eh detalhe de infraestrutura: neste ambiente a conexao nasce
    * com SQLGETPROP(h, "Transactions") = 2 (MANUAL), entao sem SQLCOMMIT o
    * INSERT/UPDATE/DELETE fica preso na transacao aberta e SOME se o processo
    * morrer - defeito mudo que ja aconteceu no projeto por descartar
    * exatamente este passo do legado.
    *
    * O par eh INERTE quando a conexao esta em auto-commit (Transactions = 1):
    * cada statement ja foi efetivado e nao ha transacao para confirmar ou
    * desfazer. O teste vem num IF ANINHADO, nunca "IF loc_lManual AND
    * SQLCOMMIT(...)": VFP9 nao faz curto-circuito em AND e chamaria o
    * SQLCOMMIT de qualquer jeito.
    *
    * ATENCAO (fiel ao legado, e por isso mantido): SQLROLLBACK desfaz a
    * transacao da CONEXAO, nao apenas o que este dialogo escreveu - igual ao
    * ".poDataMgr.RollBack()" do legado, que atua no mesmo DataMgr do form pai.
    * Como esta tela grava em UM lote e fecha, nao ha outra escrita em aberto.
    *====================================================================
    PROCEDURE ConfirmarGravacao()
        LOCAL loc_lSucesso, loc_lManual, loc_nResultado
        loc_lSucesso = .F.

        IF !THIS.ConexaoAtiva()
            THIS.this_cMensagemErro = "Sem conex" + CHR(227) + "o com o banco."
            RETURN .F.
        ENDIF

        loc_lManual = (SQLGETPROP(gnConnHandle, "Transactions") = 2)

        IF loc_lManual
            loc_nResultado = SQLCOMMIT(gnConnHandle)

            IF loc_nResultado = 1
                loc_lSucesso = .T.
            ELSE
                THIS.this_cMensagemErro = "Erro ao confirmar a transa" + CHR(231) + ;
                    CHR(227) + "o:" + CHR(13) + CapturarErroSQL()
            ENDIF
        ELSE
            *-- Auto-commit: cada statement ja esta efetivado, nada a confirmar.
            loc_lSucesso = .T.
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    PROCEDURE DesfazerGravacao()
        LOCAL loc_lSucesso, loc_lManual
        loc_lSucesso = .F.

        IF !THIS.ConexaoAtiva()
            RETURN .F.
        ENDIF

        loc_lManual = (SQLGETPROP(gnConnHandle, "Transactions") = 2)

        IF loc_lManual
            loc_lSucesso = (SQLROLLBACK(gnConnHandle) = 1)
        ELSE
            *-- Auto-commit: nao ha transacao aberta para desfazer. Devolve .F.
            *-- porque NADA foi desfeito - o chamador precisa saber que o que
            *-- gravou antes do erro ficou gravado.
            loc_lSucesso = .F.
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

ENDDEFINE


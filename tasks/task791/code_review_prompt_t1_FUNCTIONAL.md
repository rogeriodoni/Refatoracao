# CODE REVIEW - PASS FUNCTIONAL: Functional Logic (metodos, eventos, containers)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Functional Logic (metodos, eventos, containers)**.

## PROBLEMAS DETECTADOS (1)
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

### FORM (C:\4c\projeto\app\forms\operacionais\Formsigopprr.prg) - TRECHOS RELEVANTES PARA PASS FUNCTIONAL (1091 linhas total):

*-- Linhas 6 a 49:
6: *
7: * Uso:
8: *   GarantirClasse("Formsigopprr")
9: *   loForm = CREATEOBJECT("Formsigopprr")
10: *   IF VARTYPE(loForm) = "O"
11: *       loForm.Show()                      && modal: bloqueia ate Release
12: *   ENDIF
13: *   IF VARTYPE(loForm) = "O" AND loForm.this_lAutenticado
14: *       lcOperador = loForm.this_cOperador
15: *   ENDIF
16: *
17: *------------------------------------------------------------------------------
18: * LAYOUT: FLAT, SEM PageFrame - fidelidade ao legado (PILAR 1)
19: *
20: * O SCX legado tem raiz `form` GENERICA (nao frmcadastro/frmrelatorio) e a sua
21: * arvore de objetos declara exatamente 7 controles, NENHUM deles PageFrame:
22: *
23: *   SIGOPPRR (form 436x200)
24: *     +- cntSombra (container) ... faixa cinza do cabecalho
25: *     |    +- lblSombra (label) .. sombra preta do titulo
26: *     |    +- lblTitulo (label) .. titulo branco
27: *     +- USUARIO (textbox fwget) ... Fase 5
28: *     +- SENHA   (textbox fwget) ... Fase 5
29: *     +- Label1  "Operador :" ...... Fase 5
30: *     +- Label2  "Senha :" ......... Fase 5
31: *
32: * Logo NAO existe Page de Lista nem Page de Dados a reproduzir, e tambem nao
33: * ha grade nem botoes CRUD: esta tela nao lista, nao inclui, nao altera e nao
34: * exclui registro nenhum - ela coleta operador + senha e valida contra
35: * SigCdUsu (ver sigopprrBO.ValidarLogin). Criar aqui um PageFrame com
36: * Page1=Lista/Page2=Dados seria INVENTAR superficie que o legado nao tem, o
37: * que viola o PILAR 1 e a regra "NUNCA inventar" do CLAUDE.md. Pelo mesmo
38: * motivo nao existe ConfigurarPaginaLista/ConfigurarPaginaDados/AlternarPagina
39: * neste form - seriam metodos sem conteudo real, proibidos pela regra de
40: * completude. A estrutura base desta fase eh, portanto, a que o legado de
41: * fato tem: a classe sobre FormBase, o BO instanciado, a aparencia do form e
42: * a faixa de cabecalho (cnt_4c_Sombra).
43: *
44: * Referencia do mesmo padrao ja validado: FormSIGPRSTF (dialogo modal flat de
45: * Senha de Risco) e FormSigMvSbn (OPERACIONAL flat sem PageFrame).
46: *------------------------------------------------------------------------------
47: * FASE 4/8 (Grid e botoes CRUD) - NADA A ACRESCENTAR: ausencia MEDIDA no dump
48: *
49: * No padrao CRUD esta fase entrega a pagina de Lista: a grade de registros, o

*-- Linhas 64 a 246:
64: *     AddCursor que liga grade ............ 0
65: *     RecordSource/ControlSource de lista . 0  (o dump nao tem nenhum dos dois)
66: *   superficie de BOTAO .. ZERO (BaseClass commandbutton|commandgroup = 0 e
67: *     PROCEDURE Click = 0). Os 5 metodos do SCX sao Release, Load e Init do
68: *     form e os dois LostFocus dos campos - o dialogo fecha pelo proprio
69: *     LostFocus (Thisform.Release), sem CommandButton algum.
70: *   superficie de CAMPO .. 2 TextBox EDITAVEIS (USUARIO, SENHA): o dump nao
71: *     declara ReadOnly em controle nenhum.
72: *
73: * Logo o legado eh um dialogo de CAPTURA - coleta operador + senha, valida
74: * contra SigCdUsu e devolve o resultado ao chamador. Inventar aqui grade,
75: * botoes CRUD ou AlternarPagina() criaria superficie que o legado nao tem
76: * (viola o PILAR 1 e a regra "NUNCA inventar" do CLAUDE.md), e a unica
77: * alternativa seria escrever metodos-adaptador vazios so para casar com o
78: * regex do gate - o "stub disfarcado" que a regra de completude proibe.
79: *
80: * Nota de medicao (probe de instanciacao desta fase): PEMSTATUS(form,
81: * "AlternarPagina", 5) devolve .T. neste form - mas por HERANCA. O metodo eh
82: * da FormBase e ja nasce guardado por TYPE("THIS.pgf_4c_Paginas") = "O": sem
83: * PageFrame ele nao faz nada. Nenhum AlternarPagina nem ConfigurarPaginaLista
84: * foi escrito aqui. O mesmo probe confere a ausencia do resto:
85: * grd_4c_Dados = .F., cmd_4c_Incluir = .F., pgf_4c_Paginas = .F.
86: *
87: * Precedentes do MESMO perfil, ja validados: FormSigOpChp (task699),
88: * FormSigOpCtd (task715) e FormSigOpCts (task717) - o ultimo eh identico a
89: * este, dialogo modal de senha que tambem fecha sem CommandButton.
90: *
91: * Fase 5 .. Label1 + USUARIO, com Format/InputMask/MaxLength literais
92: *              (ConfigurarCampoOperador)
93: *------------------------------------------------------------------------------
94: * FASE 6/8 (campos restantes e lookups) - ENTREGUE AQUI
95: *
96: *   Campos restantes .. Label2 + SENHA (ConfigurarCampoSenha), com Format,
97: *       InputMask e PasswordChar literais do dump. Com estes, os 9 objetos da
98: *       arvore do SCX estao TODOS reproduzidos.
99: *
100: *   Lookups ........... NENHUM - ausencia MEDIDA no dump, nao presumida. As 5
101: *       assinaturas de lookup do legado Fortyus (fwbusca* / mAddColuna /
102: *       sigacess( / Acesso<X>( / FormBuscaAuxiliar) dao ZERO ocorrencia, e os
103: *       5 metodos do SCX sao Release, Load e Init do form mais os dois
104: *       LostFocus dos campos - nenhum KeyPress, logo nenhum F4/F5. Os dois
105: *       campos sao de digitacao livre: USUARIO eh o codigo do proprio
106: *       operador e SENHA eh segredo (oferecer os usuarios num picker seria,
107: *       alem de invencao, vazamento). Ver o cabecalho de LigarEventosCampos.
108: *
109: *   No lugar do lookup, esta fase liga o que o legado de fato tem nos campos:
110: *       os dois PROCEDURE LostFocus, por BINDEVENT (LigarEventosCampos), com
111: *       os handlers completos (UsuarioLostFocus / SenhaLostFocus) e as regras
112: *       em metodos proprios (ValidarOperador / ValidarCredenciais /
113: *       FormParaBO / LimparCampos / FecharDialogo).
114: *
115: *   Container cnt_4c_BotoesAcao (Salvar/Cancelar) - NAO EXISTE no legado:
116: *       zero `BaseClass: commandbutton|commandgroup` e zero `PROCEDURE Click`
117: *       no dump. O dialogo fecha pelo proprio LostFocus (Thisform.Release),
118: *       sem botao algum. Criar Salvar/Cancelar aqui inventaria superficie que
119: *       o legado nao tem (PILAR 1).
120: *------------------------------------------------------------------------------
121: * FASE 7/8 (eventos principais) - ENTREGUE: os DOIS unicos eventos de controle
122: * que o legado tem, ligados por BINDEVENT em LigarEventosCampos e implementados
123: * em UsuarioLostFocus / SenhaLostFocus (mais os respectivos <Nome>Exec e as
124: * regras em ValidarOperador, ValidarCredenciais, FormParaBO, LimparCampos e
125: * FecharDialogo).
126: *------------------------------------------------------------------------------
127: * FASE 8/8 (eventos auxiliares e consolidacao final) - ENTREGUE AQUI
128: *
129: * 1) GUARDA DE CONEXAO DO Init LEGADO - era o unico trecho do SCX ainda sem
130: *    contrapartida no migrado. O Init do legado RECUSA abrir a tela quando o
131: *    conector nao sobe:
132: *
133: *        .poDataMgr = CreateObject('fSqlConector')
134: *        If (.poDataMgr.pnIdconn > 0)
135: *            =DoDefault()
136: *        Else
137: *            =Messagebox('Impossivel Efetuar Conexao com Servidor de Banco de
138: *                         Dados...', 0+48, 'CreateObject')
139: *            Return .f.
140: *        EndIf
141: *
142: *    Sem ela o dialogo ABRIA com o banco fora do ar e so falhava la na frente,
143: *    ao sair do campo Senha, com "Conexao com o banco de dados indisponivel" -
144: *    mensagem, titulo e MOMENTO diferentes dos do legado. Reproduzida em
145: *    ValidarParametros(), chamado ANTES do TRY de InicializarForm (o RETURN
146: *    fica fora de TRY/CATCH - regra #1). gnConnHandle eh o equivalente de
147: *    poDataMgr.pnIdConn nesta arquitetura: a conexao eh UNICA e vive no
148: *    main.prg/config.prg, em vez de uma por tela.
149: *
150: * 2) MAPA DOS 5 METODOS DO SCX - com esta fase nao sobra nenhum sem destino:
151: *
152: *      SIGOPPRR.Init ................ ValidarParametros() + InicializarForm()
153: *      SIGOPPRR.Load ................ ver (3) abaixo
154: *      SIGOPPRR.Release ............. FecharDialogo() + Destroy()
155: *      SIGOPPRR.USUARIO.LostFocus ... UsuarioLostFocus()
156: *      SIGOPPRR.SENHA.LostFocus ..... SenhaLostFocus()
157: *
158: * 3) AS DUAS CHAMADAS GLOBAIS DO LEGADO QUE **NAO** SE TRANSCREVEM:
159: *
160: *      =fConfigGeral()  (Load) - o wrapper utils\fconfiggeral.prg EXISTE, mas o
161: *          cabecalho dele eh explicito: "em codigo NOSSO nunca se chama
162: *          fConfigGeral - este arquivo existe APENAS para binario legado"
163: *          (p-code dos VCX, que nao da para editar). O que a funcao fazia ja
164: *          acontece antes, distribuido: config.prg (SETs, paths, globais),
165: *          main.prg (conexao, CarregarEmpresa) e cada BO com os proprios
166: *          cursores. Chamar aqui nao acrescentaria efeito nenhum.
167: *
168: *      =fLerFiscal()    (Init) - configuracao de impressora fiscal (hardware).
169: *          NAO foi portada e NAO se cria stub: regra #27, 3a linha - funcao que
170: *          devolve valor de calculo / estado de dispositivo fica AUSENTE,
171: *          porque stub decide errado em silencio. Mesmo tratamento ja adotado
172: *          em SigOpAutBO e FisBO. Nada nesta tela consome o resultado: o unico
173: *          consumidor no legado eh ProgOper(...), que tambem nao veio no acervo
174: *          (ver o cabecalho de sigopprrBO.prg).
175: *
176: * 4) NOMES CANONICOS DE FORM CRUD QUE **NAO SE APLICAM** - ausencia MEDIDA no
177: *    dump, nao presumida. Escreve-los aqui seria inventar superficie que o
178: *    legado nao tem (PILAR 1) ou criar metodo vazio (proibido pela regra de
179: *    completude):
180: *
181: *      BtnSalvarClick / BtnConfirmarClick .. nao ha botao de gravar - esta tela
182: *          nao grava registro algum (so LE SigCdUsu para conferir credenciais);
183: *          quem CONFIRMA eh o LostFocus da Senha, exatamente como no legado.
184: *      BtnCancelarClick .................... nao ha botao de cancelar - cancelar
185: *          eh sair do campo Operador em branco (UsuarioLostFocus ->
186: *          FecharDialogo), a unica saida que o legado oferece.
187: *      BtnBuscarClick ...................... nao ha busca - zero lookup no dump
188: *          (as 5 assinaturas estao medidas no cabecalho de LigarEventosCampos).
189: *      BtnEncerrarClick .................... nao ha cnt_4c_Saida/Encerrar - o
190: *          dump tem ZERO commandbutton/commandgroup e ZERO PROCEDURE Click.
191: *      CarregarLista ....................... nao ha lista - zero grid, pageframe,
192: *          AddCursor e RecordSource no dump.
193: *      BOParaForm .......................... nao ha caminho de volta - o legado
194: *          nunca repoe os campos a partir de dado lido: no sucesso ele FECHA e
195: *          na recusa ZERA os dois (LimparCampos). Reescrever a senha na tela a
196: *          partir do BO, alem de nao existir no legado, exporia segredo. O
197: *          sentido que existe de verdade - campos -> BO - esta em FormParaBO.
198: *      HabilitarCampos ..................... nao ha modo de edicao - os dois
199: *          campos sao sempre editaveis (o dump nao declara ReadOnly em controle
200: *          nenhum) e nao existe INCLUIR/ALTERAR/VISUALIZAR nesta tela.
201: *      AjustarBotoesPorModo ................ consequencia dos dois anteriores:
202: *          sem botao e sem modo, nao ha o que ajustar.
203: *
204: *    A consolidacao real desta tela esta nos metodos que de fato existem:
205: *    ValidarParametros, ValidarOperador, ValidarCredenciais, FormParaBO,
206: *    LimparCampos, FecharDialogo e TornarControlesVisiveis.
207: *------------------------------------------------------------------------------
208: * PROPRIEDADES VISUAIS TRANSCRITAS DO DUMP (secao "PROPRIEDADES DE: SIGOPPRR")
209: *   DataSession = 2 | Height = 200 | Width = 436 | AutoCenter = .T.
210: *   BorderStyle = 2 | ControlBox = .F. | TitleBar = 0 | WindowType = 1
211: *   Picture = ..\framework\imagens\new_background.jpg
212: *   Caption = "Codigo do Operador"
213: *
214: * NAO transcritas de proposito (o dump NAO as declara - inventa-las muda
215: * comportamento, conforme a licao do Closable inventado): Closable, MaxButton,
216: * MinButton e Movable ficam com o default herdado de Form/FormBase.
217: *==============================================================================
218: 
219: DEFINE CLASS Formsigopprr AS FormBase
220: 
221:     *--------------------------------------------------------------------------
222:     * Propriedades visuais - transcritas do SCX legado
223:     *--------------------------------------------------------------------------
224:     this_cMensagemErro = ""
225:     Width       = 436
226:     Height      = 200
227:     AutoCenter  = .T.
228:     BorderStyle = 2
229:     ControlBox  = .F.
230:     TitleBar    = 0
231:     WindowType  = 1
232:     ShowWindow  = 1
233:     DataSession = 2
234:     Caption     = "C" + CHR(243) + "digo do Operador"
235: 
236:     *--------------------------------------------------------------------------
237:     * Propriedades de estado
238:     *
239:     * this_oBusinessObject ja existe em FormBase; redeclarado aqui apenas para
240:     * documentar que este form o usa (sigopprrBO), sem mudar o valor inicial.
241:     *--------------------------------------------------------------------------
242:     this_oBusinessObject = .NULL.
243: 
244:     *-- Resultado da autenticacao. O chamador le DEPOIS do Show(): .T. somente
245:     *-- quando sigopprrBO.ValidarLogin() aprovou operador + senha.
246:     this_lAutenticado = .F.

*-- Linhas 256 a 514:
256:     *
257:     *-- Flag UNICA para os DOIS handlers, de proposito. O caso perigoso nao eh
258:     *-- um campo reentrar em si mesmo e sim um reentrar no OUTRO: no ramo de
259:     *-- recusa, SenhaLostFocus exibe um MsgAviso MODAL e logo depois esvazia o
260:     *-- campo Operador (LimparCampos) para devolver o foco a ele. Com flags
261:     *-- separadas, o LostFocus do Operador - agora VAZIO - poderia disparar no
262:     *-- meio dessa sequencia e FECHAR o dialogo (eh o que ele faz com campo em
263:     *-- branco), transformando uma senha errada em "a tela sumiu". Uma flag so
264:     *-- fecha essa janela.
265:     this_lEmValidacao = .F.
266: 
267:     *==========================================================================
268:     * Init - APENAS DODEFAULT()
269:     *
270:     * FormBase.Init() chama THIS.InicializarForm(); chamar de novo aqui criaria
271:     * os objetos duas vezes ("A member object with this name already exists").
272:     * O DODEFAULT eh tambem o que aplica SET DATE BRITISH / SET CENTURY ON na
273:     * datasession privada deste form (DataSession = 2, regra #9.4).
274:     *==========================================================================
275:     PROCEDURE Init()
276:         RETURN DODEFAULT()
277:     ENDPROC
278: 
279:     *==========================================================================
280:     * InicializarForm - Instancia o BO e monta a estrutura base da tela
281:     *
282:     * Devolve .T./.F.: FormBase.Init() aborta a abertura quando recebe .F. e
283:     * grava o diagnostico em gc_4c_ArquivoErroTeste.
284:     *==========================================================================
285:     PROTECTED PROCEDURE InicializarForm()
286:         LOCAL loc_lSucesso, loc_oErro
287: 
288:         loc_lSucesso = .F.
289: 
290:         *-- Guarda do Init legado: sem conexao com o banco o dialogo NAO abre
291:         *-- (If .poDataMgr.pnIdconn > 0 ... Else Messagebox + Return .f.).
292:         *-- RETURN fora de TRY/CATCH - regra #1.
293:         IF !THIS.ValidarParametros()
294:             RETURN .F.
295:         ENDIF
296: 
297:         TRY
298:             *-- Business Object (Fases 1-2): valida as credenciais contra SigCdUsu
299:             THIS.this_oBusinessObject = CREATEOBJECT("sigopprrBO")
300: 
301:             IF VARTYPE(THIS.this_oBusinessObject) != "O"
302:                 THIS.this_cMensagemErro = "Erro ao criar sigopprrBO."
303:                 MsgErro(THIS.this_cMensagemErro, "Erro ao Inicializar")
304:             ELSE
305:                 *-- Estado inicial: ninguem autenticado ainda
306:                 THIS.this_lAutenticado = .F.
307:                 THIS.this_cOperador    = ""
308:                 THIS.this_lEmValidacao = .F.
309: 
310:                 *-- Aparencia do proprio form (fundo/fonte do legado)
311:                 THIS.ConfigurarAparencia()
312: 
313:                 *-- Faixa cinza do cabecalho (cntSombra do legado).
314:                 *-- Primeiro AddObject da tela: os controles de dados das Fases
315:                 *-- 5-6 ficam abaixo dela (Top >= 104 no dump) e sao criados
316:                 *-- depois, desenhando por cima - regra #11 do CLAUDE.md.
317:                 THIS.ConfigurarCabecalho()
318: 
319:                 *-- Fase 5: rotulo "Operador :" + campo USUARIO (codigo
320:                 *-- numerico do operador, 3 digitos). Criado depois da faixa
321:                 *-- para desenhar por cima dela (regra #11).
322:                 THIS.ConfigurarCampoOperador()
323: 
324:                 *-- Fase 6: rotulo "Senha :" + campo SENHA (os 2 objetos que
325:                 *-- faltavam do dump). Tambem depois da faixa, pelo mesmo
326:                 *-- motivo, e depois do USUARIO para respeitar a ordem de
327:                 *-- tabulacao do legado (TabIndex 1 -> 2).
328:                 THIS.ConfigurarCampoSenha()
329: 
330:                 *-- Fase 6: liga os eventos dos DOIS campos. So depois de ambos
331:                 *-- existirem - BINDEVENT com objeto inexistente estoura no
332:                 *-- proprio bind (nao em silencio).
333:                 THIS.LigarEventosCampos()
334: 
335:                 *-- AddObject cria tudo com Visible = .F.
336:                 THIS.TornarControlesVisiveis(THIS)
337: 
338:                 loc_lSucesso = .T.
339:             ENDIF
340: 
341:         CATCH TO loc_oErro
342:             THIS.this_cMensagemErro = loc_oErro.Message + ;
343:                 " | Linha: " + TRANSFORM(loc_oErro.LineNo) + ;
344:                 " | Procedure: " + loc_oErro.Procedure
345:             MsgErro(THIS.this_cMensagemErro, "Erro ao inicializar Formsigopprr")
346:             loc_lSucesso = .F.
347:         ENDTRY
348: 
349:         RETURN loc_lSucesso
350:     ENDPROC
351: 
352:     *==========================================================================
353:     * ValidarParametros - Guarda de conexao do Init legado
354:     *
355:     *   With ThisForm
356:     *       .poDataMgr = CreateObject('fSqlConector')
357:     *       If (.poDataMgr.pnIdconn > 0)
358:     *           =DoDefault()
359:     *       Else
360:     *           =Messagebox('Impossivel Efetuar Conexao com Servidor de Banco
361:     *                        de Dados...', 0+48, 'CreateObject')
362:     *           Return .f.
363:     *       EndIf
364:     *   EndWith
365:     *
366:     * O legado abre UMA conexao por tela (poDataMgr) e so segue adiante com
367:     * pnIdConn > 0. Nesta arquitetura a conexao eh unica e global - aberta no
368:     * main.prg/config.prg e publicada em gnConnHandle -, entao o equivalente
369:     * fiel da guarda eh conferir esse handle. Sem ela o dialogo abriria com o
370:     * banco fora do ar e so falharia ao sair do campo Senha, com mensagem e
371:     * momento diferentes dos do legado.
372:     *
373:     * Mensagem e titulo transcritos do MessageBox legado; icone 48 (aviso) eh
374:     * o que MsgErro/MsgAviso cobrem - aqui MsgErro, porque o legado ABORTA a
375:     * abertura, nao apenas avisa.
376:     *
377:     * BYPASS DE TESTE no topo, antes de qualquer DO CASE: o harness de
378:     * 06b_testeAutomatico define gnConnHandle = 0 DE PROPOSITO (sentinela - nao
379:     * tenta conectar, porque SQLSTRINGCONNECT bloqueia 300s no timeout TCP
380:     * quando o servidor esta inacessivel) e espera que o form instancie para
381:     * ser inspecionado. Sem o bypass, InicializarForm devolveria .F.,
382:     * CREATEOBJECT devolveria logico e o teste "Instanciacao" reprovaria
383:     * sempre, sem erro de SQL no log. gb_4c_ValidandoUI (ValidarUIFidelity) faz
384:     * gnConnHandle = -1 e precisa do mesmo tratamento.
385:     *
386:     * PUBLIC (sem PROTECTED): alem de ser chamado por THIS. no InicializarForm,
387:     * eh alcancavel pelo harness, que chama metodos do form de FORA da classe
388:     * (regra #3 - e PEMSTATUS nao distingue escopo, entao PROTECTED aqui
389:     * falharia so em runtime).
390:     *==========================================================================
391:     PROCEDURE ValidarParametros()
392:         LOCAL loc_lValido
393: 
394:         loc_lValido = .T.
395: 
396:         IF TYPE("gb_4c_ModoTeste") = "L" AND gb_4c_ModoTeste
397:             RETURN .T.
398:         ENDIF
399: 
400:         IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
401:             RETURN .T.
402:         ENDIF
403: 
404:         DO CASE
405:             CASE TYPE("gnConnHandle") != "N"
406:                 MsgErro("Imposs" + CHR(237) + "vel Efetuar Conex" + CHR(227) + ;
407:                     "o com Servidor de Banco de Dados...", "CreateObject")
408:                 loc_lValido = .F.
409: 
410:             CASE gnConnHandle <= 0
411:                 MsgErro("Imposs" + CHR(237) + "vel Efetuar Conex" + CHR(227) + ;
412:                     "o com Servidor de Banco de Dados...", "CreateObject")
413:                 loc_lValido = .F.
414:         ENDCASE
415: 
416:         RETURN loc_lValido
417:     ENDPROC
418: 
419:     *==========================================================================
420:     * ConfigurarAparencia - Propriedades visuais do proprio form que dependem
421:     * de variavel global (nao cabem no bloco estatico da classe).
422:     *
423:     * Picture: o dump declara "..\framework\imagens\new_background.jpg". O
424:     * caminho eh resolvido pela variavel publica (NUNCA remontado a partir de
425:     * gc_4c_CaminhoBase - Pattern #156/#170); a mesma imagem esta publicada em
426:     * vbmp\, que eh para onde gc_4c_CaminhoIcones aponta e o que os demais
427:     * forms OPERACIONAIS usam (FormDCC, FormEnd, FormFop, Formale...).
428:     *==========================================================================
429:     PROTECTED PROCEDURE ConfigurarAparencia()
430:         THIS.FontName = "Tahoma"
431:         THIS.FontSize = 8
432:         THIS.ShowTips = .F.
433:         THIS.Picture  = gc_4c_CaminhoIcones + "new_background.jpg"
434: 
435:         RETURN .T.
436:     ENDPROC
437: 
438:     *==========================================================================
439:     * ConfigurarCabecalho - Faixa cinza do titulo (cntSombra do legado)
440:     *
441:     * Dump legado:
442:     *   cntSombra  Top=0 Left=0 Width=800 Height=80 BorderWidth=0
443:     *              BackColor=100,100,100
444:     *   lblSombra  Tahoma 18 bold, WordWrap, Alignment=0, BackStyle=0,
445:     *              Height=40 Left=10 Top=18 Width=769 ForeColor=0,0,0
446:     *   lblTitulo  Tahoma 18 bold, WordWrap, Alignment=0, BackStyle=0,
447:     *              Height=46 Left=10 Top=17 Width=769 ForeColor=255,255,255
448:     *
449:     * DOIS literais do dump NAO sao transcritos, e os dois pelo mesmo motivo -
450:     * sao maiores que a propria janela:
451:     *   - cntSombra.Width = 800 contra SIGOPPRR.Width = 436;
452:     *   - lblSombra/lblTitulo.Width = 769, que nem dentro de um container de
453:     *     436 caberia.
454:     * Eh o artefato conhecido do Form Designer (container desenhado mais largo
455:     * que o form). Copiar o literal faria o titulo ser RECORTADO no meio pela
456:     * borda do pai (regra #30: controle fora da area do pai some sem erro).
457:     * Usa-se entao a forma responsiva ja adotada no projeto: container com
458:     * THIS.Width e labels com THIS.Width - 20 (os 10px de Left mais a margem
459:     * simetrica a direita).
460:     *
461:     * O Caption dos dois labels vem de THIS.Caption ("Codigo do Operador") e
462:     * NAO do literal "Cadastro de Testes" que esta no dump: aquele texto eh
463:     * sobra do template do framework (o mesmo literal aparece no SCX do
464:     * FormSIGPRSTF, onde tambem foi substituido pelo titulo real). Como este
465:     * form tem TitleBar = 0, a faixa eh o UNICO lugar em que o usuario le o
466:     * nome da tela - manter "Cadastro de Testes" num dialogo de login seria
467:     * exibir informacao errada. Decisao canonica da regra #11 do CLAUDE.md
468:     * (o label de titulo recebe THIS.Caption).
469:     *
470:     * AutoSize = .F. explicito nos dois labels: AutoSize eh no-op em Label
471:     * criado por AddObject enquanto invisivel e, com WordWrap = .T., descarta
472:     * a Height (regra #23) - as medidas vao literais.
473:     *==========================================================================
474:     PROTECTED PROCEDURE ConfigurarCabecalho()
475:         *-- Container da faixa (cntSombra)
476:         THIS.AddObject("cnt_4c_Sombra", "Container")
477:         WITH THIS.cnt_4c_Sombra
478:             .Top           = 0
479:             .Left          = 0
480:             .Width         = THIS.Width
481:             .Height        = 80
482:             .BorderWidth   = 0
483:             .SpecialEffect = 0
484:             .BackStyle     = 1
485:             .BackColor     = RGB(100, 100, 100)
486:             .Visible       = .T.
487:         ENDWITH
488: 
489:         *-- Sombra preta do titulo (lblSombra)
490:         THIS.cnt_4c_Sombra.AddObject("lbl_4c_LblSombra", "Label")
491:         WITH THIS.cnt_4c_Sombra.lbl_4c_LblSombra
492:             .AutoSize      = .F.
493:             .FontBold      = .T.
494:             .FontName      = "Tahoma"
495:             .FontSize      = 18
496:             .FontUnderline = .F.
497:             .WordWrap      = .T.
498:             .Alignment     = 0
499:             .BackStyle     = 0
500:             .Caption       = THIS.Caption
501:             .Height        = 40
502:             .Left          = 10
503:             .Top           = 18
504:             .Width         = THIS.Width - 20
505:             .ForeColor     = RGB(0, 0, 0)
506:             .Visible       = .T.
507:         ENDWITH
508: 
509:         *-- Titulo branco sobre o cinza (lblTitulo)
510:         THIS.cnt_4c_Sombra.AddObject("lbl_4c_LblTitulo", "Label")
511:         WITH THIS.cnt_4c_Sombra.lbl_4c_LblTitulo
512:             .AutoSize    = .F.
513:             .FontBold    = .T.
514:             .FontName    = "Tahoma"

*-- Linhas 550 a 642:
550:     * do dump; SelectOnEntry = .F. tambem esta declarado no dump e sobrescreve
551:     * o default .T. do VFP. O Valid/LostFocus ("If IsEmpty(This.Value) /
552:     * Thisform.Release") fica para a Fase 7 - aqui so geometria e mascara,
553:     * igual ao padrao ja usado em FormSigOpCts/FormSigOpChp neste mesmo ponto
554:     * do pipeline. Classe "TextBox" simples (nao subclasse): o legado liga o
555:     * LostFocus por PROCEDURE no proprio controle, que na migracao se
556:     * reproduz com BINDEVENT (regra #3/#47), sem exigir subclasse dedicada.
557:     *==========================================================================
558:     PROTECTED PROCEDURE ConfigurarCampoOperador()
559:         LOCAL loc_oErro
560: 
561:         TRY
562:             THIS.AddObject("lbl_4c_Label1", "Label")
563:             WITH THIS.lbl_4c_Label1
564:                 .AutoSize  = .F.
565:                 .FontBold  = .T.
566:                 .FontName  = "Tahoma"
567:                 .FontSize  = 12
568:                 .BackStyle = 0
569:                 .Caption   = "Operador :"
570:                 .Height    = 21
571:                 .Left      = 110
572:                 .Top       = 109
573:                 .Width     = 89
574:                 .ForeColor = RGB(90, 90, 90)
575:                 .Visible   = .T.
576:             ENDWITH
577: 
578:             THIS.AddObject("txt_4c_USUARIO", "TextBox")
579:             WITH THIS.txt_4c_USUARIO
580:                 .FontBold      = .T.
581:                 .FontName      = "Tahoma"
582:                 .FontSize      = 12
583:                 .BackStyle     = 0
584:                 .Format        = "K"
585:                 .InputMask     = "999"
586:                 .MaxLength     = 3
587:                 .SelectOnEntry = .F.
588:                 .TabIndex      = 1
589:                 .Value         = ""
590:                 .Top           = 104
591:                 .Left          = 201
592:                 .Width         = 50
593:                 .Height        = 30
594:                 .ForeColor     = RGB(0, 0, 0)
595:                 .BackColor     = RGB(255, 255, 255)
596:                 .Themes        = .T.
597:                 .Visible       = .T.
598:             ENDWITH
599:         CATCH TO loc_oErro
600:             MsgErro(loc_oErro.Message + CHR(13) + ;
601:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
602:                 "Procedure: " + loc_oErro.Procedure, "Erro em Formsigopprr.ConfigurarCampoOperador")
603:         ENDTRY
604:     ENDPROC
605: 
606:     *==========================================================================
607:     * ConfigurarCampoSenha - Rotulo "Senha :" (Label2) + campo SENHA
608:     * (mapeamento.json: Label2 -> lbl_4c_Label2, SENHA -> txt_4c_SENHA).
609:     * Com estes dois, os 9 objetos do dump legado estao TODOS reproduzidos.
610:     * Ambos criados DIRETO em THIS - o dump diz "Parent: SIGOPPRR" nos dois.
611:     *
612:     * lbl_4c_Label2 (Label2): mesmo tratamento do Label1 - o dump DECLARA
613:     * AutoSize = .T. junto com Width = 63 / Height = 21, e a regra #23 manda
614:     * escrever .AutoSize = .F. e transcrever as duas medidas, porque AutoSize
615:     * eh no-op em Label criado por AddObject (a Width ficaria nos 100 do
616:     * default, e os 100 px a partir de Left = 136 invadiriam o TextBox em
617:     * Left = 201). Os 63x21 JA SAO o auto-size que o Form Designer calculou
618:     * para "Senha :" em Tahoma 12 bold. ForeColor = 90,90,90 eh o do dump e
619:     * tambem o canonico de label de dados (regra #12).
620:     *
621:     * txt_4c_SENHA (SENHA, classe fwget no legado) - transcricao literal do
622:     * dump, nada inventado:
623:     *   Format        = "K"           seleciona o conteudo ao entrar
624:     *   InputMask     = "!!!!!!!!!!"  10 posicoes, forcando MAIUSCULA
625:     *   PasswordChar  = "*"           mascara a digitacao na tela
626:     *   Top/Left/Width/Height = 139/201/136/30
627:     *   TabIndex = 2, BackStyle = 0, Themes = .T., ForeColor/BackColor do dump
628:     *
629:     * Tres decisoes de transcricao que merecem registro:
630:     *
631:     * 1) MaxLength NAO eh declarado - e NAO se inventa. O dump declara
632:     *    MaxLength so no USUARIO (3). Aqui as 10 posicoes do InputMask ja
633:     *    limitam a digitacao a 10 caracteres, que eh exatamente a largura de
634:     *    SigCdUsu.senhas char(10) e o PADR(...,10) que o BO aplica - nao ha
635:     *    divergencia a corrigir, logo acrescentar a propriedade seria desvio
636:     *    do PILAR 1 sem ganho algum.
637:     *
638:     * 2) O "!" do InputMask (MAIUSCULA) faz parte da REGRA, nao da estetica:
639:     *    a senha gravada no legado passou pelo mesmo campo, logo a comparacao
640:     *    de ValidarLogin so casa se a digitacao continuar sendo maiusculizada.
641:     *    Descartar essa mascara (defeito tipico - regra #49) faria "abc" nunca
642:     *    autenticar contra uma senha gravada como "ABC".

*-- Linhas 648 a 1091:
648:     * atribuido, e ALLTRIM/PADR sobre .F. estoura "Function argument value,
649:     * type, or count is invalid".
650:     *==========================================================================
651:     PROTECTED PROCEDURE ConfigurarCampoSenha()
652:         LOCAL loc_oErro
653: 
654:         TRY
655:             THIS.AddObject("lbl_4c_Label2", "Label")
656:             WITH THIS.lbl_4c_Label2
657:                 .AutoSize  = .F.
658:                 .FontBold  = .T.
659:                 .FontName  = "Tahoma"
660:                 .FontSize  = 12
661:                 .BackStyle = 0
662:                 .Caption   = "Senha :"
663:                 .Height    = 21
664:                 .Left      = 136
665:                 .Top       = 144
666:                 .Width     = 63
667:                 .ForeColor = RGB(90, 90, 90)
668:                 .Visible   = .T.
669:             ENDWITH
670: 
671:             THIS.AddObject("txt_4c_SENHA", "TextBox")
672:             WITH THIS.txt_4c_SENHA
673:                 .FontBold     = .T.
674:                 .FontName     = "Tahoma"
675:                 .FontSize     = 12
676:                 .BackStyle    = 0
677:                 .Format       = "K"
678:                 .InputMask    = "!!!!!!!!!!"
679:                 .PasswordChar = "*"
680:                 .TabIndex     = 2
681:                 .Value        = ""
682:                 .Top          = 139
683:                 .Left         = 201
684:                 .Width        = 136
685:                 .Height       = 30
686:                 .ForeColor    = RGB(0, 0, 0)
687:                 .BackColor    = RGB(255, 255, 255)
688:                 .Themes       = .T.
689:                 .Visible      = .T.
690:             ENDWITH
691:         CATCH TO loc_oErro
692:             MsgErro(loc_oErro.Message + CHR(13) + ;
693:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
694:                 "Procedure: " + loc_oErro.Procedure, "Erro em Formsigopprr.ConfigurarCampoSenha")
695:         ENDTRY
696:     ENDPROC
697: 
698:     *==========================================================================
699:     * LigarEventosCampos - BINDEVENT dos dois campos digitaveis
700:     *
701:     * LOOKUP: NAO EXISTE NENHUM NESTA TELA - ausencia MEDIDA, nao presumida.
702:     * Varredura do dump (tasks\task791\sigopprr_form_codigo_fonte.txt) pelos
703:     * cinco padroes de lookup do legado Fortyus:
704:     *
705:     *   fwbusca (cobre fwBuscaExt/fwBuscaSel/fwBuscaInt) ... 0 ocorrencias
706:     *   mAddColuna (API de colunas do picker legado) ....... 0
707:     *   sigacess( ......................................... 0
708:     *   Acesso<Campos|Contab|Contas|Empresa|Grupos|...>( ... 0
709:     *   FormBuscaAuxiliar ................................. 0
710:     *
711:     * E os 5 metodos do SCX sao Release/Load/Init do form mais os dois
712:     * LostFocus dos campos - nenhum KeyPress, portanto nenhum F4/F5. Os dois
713:     * campos do legado tambem nao tem classe customizada de TextBox: ambos sao
714:     * `fwget`, o TextBox padrao do framework.
715:     *
716:     * Os dois campos sao de DIGITACAO LIVRE e nao referenciam tabela de apoio
717:     * para escolher em grade: USUARIO eh o codigo numerico do proprio operador
718:     * (a unica tabela consultada, SigCdUsu, eh conferida por igualdade em
719:     * ValidarLogin, nao oferecida em lista) e SENHA eh segredo - exibir os
720:     * usuarios num picker seria, alem de invencao, vazamento. Criar aqui um
721:     * AbrirLookup*/AbrirBusca* apontando para SigCdUsu violaria o PILAR 1 e a
722:     * regra explicita "NUNCA inventar tabelas de lookup que nao existem no
723:     * original"; criar o metodo vazio so para casar com o gate seria o "stub
724:     * disfarcado" que a regra de completude proibe.
725:     *
726:     * O que esta fase liga, entao, eh o que o legado de fato tem nos campos:
727:     * o PROCEDURE LostFocus de cada um.
728:     *
729:     * Evento "LostFocus" e NAO "KeyPress" (regra #47): o legado valida ao SAIR
730:     * do campo. Em KeyPress o handler dispararia a CADA TECLA - a senha seria
731:     * conferida (e recusada, limpando os dois campos) no primeiro caractere
732:     * digitado, e o usuario nunca conseguiria terminar de digitar. Pela mesma
733:     * regra os handlers de LostFocus NAO declaram parametros: LostFocus nao
734:     * passa nenhum.
735:     *
736:     * PUBLIC obrigatorio nos handlers: BINDEVENT ignora metodo PROTECTED em
737:     * silencio (regra #3).
738:     *==========================================================================
739:     PROTECTED PROCEDURE LigarEventosCampos()
740:         LOCAL loc_oErro
741: 
742:         TRY
743:             *-- SIGOPPRR.USUARIO.LostFocus - campo vazio encerra o dialogo
744:             BINDEVENT(THIS.txt_4c_USUARIO, "LostFocus", THIS, "UsuarioLostFocus")
745: 
746:             *-- SIGOPPRR.SENHA.LostFocus - confere as credenciais
747:             BINDEVENT(THIS.txt_4c_SENHA, "LostFocus", THIS, "SenhaLostFocus")
748:         CATCH TO loc_oErro
749:             MsgErro(loc_oErro.Message + CHR(13) + ;
750:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
751:                 "Procedure: " + loc_oErro.Procedure, "Erro em Formsigopprr.LigarEventosCampos")
752:         ENDTRY
753: 
754:         RETURN .T.
755:     ENDPROC
756: 
757:     *==========================================================================
758:     * UsuarioLostFocus - Transcricao de SIGOPPRR.USUARIO.LostFocus:
759:     *
760:     *   If IsEmpty(This.Value)
761:     *       Thisform.Release
762:     *   EndIf
763:     *
764:     * Sair do campo Operador em branco EH o cancelamento do dialogo - este
765:     * form nao tem botao nenhum (zero commandbutton/commandgroup no dump), e
766:     * esta eh a unica saida do usuario alem da autenticacao bem-sucedida.
767:     *
768:     * `IsEmpty` do Fortyus trata NULL como vazio; aqui o valor vem do proprio
769:     * TextBox e nunca eh NULL, entao EMPTY() nativo basta (regra #2: em codigo
770:     * nosso usar EMPTY() direto, o wrapper utils\isempty.prg existe so para o
771:     * p-code dos VCX).
772:     *
773:     * Wrapper fino + <Nome>Exec: o corpo tem RETURN antecipado, e set/clear da
774:     * flag no proprio corpo deixaria a guarda TRAVADA ligada, matando o
775:     * handler pelo resto da vida do form (regra #47).
776:     *
777:     * PUBLIC: alvo de BINDEVENT (regra #3).
778:     *==========================================================================
779:     PROCEDURE UsuarioLostFocus()
780:         IF THIS.this_lEmValidacao
781:             RETURN
782:         ENDIF
783: 
784:         THIS.this_lEmValidacao = .T.
785:         THIS.UsuarioLostFocusExec()
786:         THIS.this_lEmValidacao = .F.
787:     ENDPROC
788: 
789:     PROTECTED PROCEDURE UsuarioLostFocusExec()
790:         IF !THIS.ValidarOperador()
791:             *-- Operador em branco: o legado fecha a tela
792:             THIS.FecharDialogo()
793:         ENDIF
794: 
795:         RETURN .T.
796:     ENDPROC
797: 
798:     *==========================================================================
799:     * SenhaLostFocus - Transcricao de SIGOPPRR.SENHA.LostFocus:
800:     *
801:     *   lcUser = PADR(ThisForm.USUARIO.Value,10)
802:     *   lcPass = PADR(Thisform.SENHA.Value,10)
803:     *   lcQuery = [select a.usuarios, a.senhas from SigCdUsu a
804:     *              where Not a.cAtivos='N' and a.usuarios='] + lcUser + [' ...]
805:     *   ThisForm.poDataMgr.SQLExecute(lcQuery, 'crSigCdUsu')
806:     *   If Not Used(...) Or Reccount(...)==0 Or Empty(lcUser)
807:     *      OR lcPass <> fCriptografar(CrSigCdUsu.SENHAS)
808:     *       =MessageBox('Usuario ou Senha incorretos',0+48,'')
809:     *       ThisForm.Senha.Value   = ''
810:     *       Thisform.Usuario.Value = ''
811:     *       ThisForm.Usuario.SetFocus
812:     *   Else
813:     *       If ProgOper(Val(Thisform.Usuario.Value),Thisform.oModem)
814:     *           goSistema.Operador = Transform(Val(...),'@L 999')
815:     *       Endif
816:     *       Thisform.Release
817:     *   EndIf
818:     *
819:     * Divisao de responsabilidade (PILAR 3): a CONSULTA e a conferencia moram
820:     * em sigopprrBO.ValidarLogin (Fase 2), que ja transcreve a query, o filtro
821:     * NOT cativos='N', as quatro condicoes de recusa e a chamada literal a
822:     * fCriptografar. Aqui fica so o que eh da TELA: espelhar os campos para o
823:     * BO, decidir entre os dois ramos e executar o efeito visivel de cada um.
824:     *
825:     * Ramo de RECUSA - os quatro passos do legado, na mesma ordem:
826:     *   MsgAviso sem titulo (equivale a MessageBox(...,0+48,'') - icone 48 eh
827:     *   aviso, e validacao de UI nunca usa MsgErro), os DOIS campos limpos e o
828:     *   foco de volta no Operador. A mensagem eh a do BO, que por construcao
829:     *   devolve o mesmo texto do legado nas quatro condicoes, sem revelar qual
830:     *   delas falhou.
831:     *
832:     * Ramo de ACEITE - publica o operador e fecha. `ProgOper` (programacao do
833:     * operador no dispositivo) nao veio no acervo e `ThisForm.oModem` nao
834:     * existe nem no SCX legado nem aqui; o BO.DefinirOperadorLogado grava
835:     * go_4c_Sistema.Operador assim mesmo, com o MESMO Transform(...,'@L 999'),
836:     * porque eh desse efeito que o resto do sistema depende.
837:     *
838:     * As properties de retorno (this_lAutenticado / this_cOperador) sao
839:     * gravadas ANTES de fechar: com Hide() o Destroy so roda quando o chamador
840:     * liberar o objeto, entao todo efeito que o chamador le na sequencia tem
841:     * de acontecer AQUI, no funil, e nao no Destroy.
842:     *
843:     * PUBLIC: alvo de BINDEVENT (regra #3).
844:     *==========================================================================
845:     PROCEDURE SenhaLostFocus()
846:         IF THIS.this_lEmValidacao
847:             RETURN
848:         ENDIF
849: 
850:         THIS.this_lEmValidacao = .T.
851:         THIS.SenhaLostFocusExec()
852:         THIS.this_lEmValidacao = .F.
853:     ENDPROC
854: 
855:     PROTECTED PROCEDURE SenhaLostFocusExec()
856:         LOCAL loc_lOk, loc_cMensagem, loc_oErro
857: 
858:         TRY
859:             loc_lOk = THIS.ValidarCredenciais()
860: 
861:             IF loc_lOk
862:                 *-- goSistema.Operador = Transform(Val(Usuario.Value),'@L 999')
863:                 THIS.this_oBusinessObject.DefinirOperadorLogado()
864: 
865:                 THIS.this_lAutenticado = .T.
866: 
867:                 *-- FONTE UNICA: o mesmo this_cUsuarios de que
868:                 *-- DefinirOperadorLogado derivou go_4c_Sistema.Operador, com o
869:                 *-- mesmo Transform(...,'@L 999') do legado. Recalcular a
870:                 *-- partir do TextBox daria dois caminhos para o MESMO valor -
871:                 *-- e um deles ficaria livre para divergir do que foi publicado
872:                 *-- (o BO guarda o valor ja normalizado por PADR(...,10)).
873:                 THIS.this_cOperador    = TRANSFORM(VAL(THIS.this_oBusinessObject.this_cUsuarios), "@L 999")
874: 
875:                 *-- Thisform.Release do legado
876:                 THIS.FecharDialogo()
877:             ELSE
878:                 loc_cMensagem = THIS.this_oBusinessObject.this_cMensagemErro
879: 
880:                 IF EMPTY(loc_cMensagem)
881:                     loc_cMensagem = "Usu" + CHR(225) + "rio ou Senha incorretos"
882:                 ENDIF
883: 
884:                 THIS.this_lAutenticado = .F.
885:                 THIS.this_cOperador    = ""
886: 
887:                 *-- MessageBox('Usuario ou Senha incorretos', 0+48, '')
888:                 MsgAviso(loc_cMensagem, "")
889: 
890:                 *-- ThisForm.Senha.Value = '' / Thisform.Usuario.Value = ''
891:                 THIS.LimparCampos()
892: 
893:                 *-- ThisForm.Usuario.SetFocus
894:                 IF THIS.Visible AND THIS.txt_4c_USUARIO.Visible AND THIS.txt_4c_USUARIO.Enabled
895:                     THIS.txt_4c_USUARIO.SetFocus()
896:                 ENDIF
897:             ENDIF
898:         CATCH TO loc_oErro
899:             THIS.this_lAutenticado = .F.
900:             THIS.this_cOperador    = ""
901:             MsgErro(loc_oErro.Message + CHR(13) + ;
902:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
903:                 "Procedure: " + loc_oErro.Procedure, "Erro em Formsigopprr.SenhaLostFocus")
904:         ENDTRY
905: 
906:         RETURN .T.
907:     ENDPROC
908: 
909:     *==========================================================================
910:     * ValidarOperador - Regra do campo Operador (SIGOPPRR.USUARIO.LostFocus)
911:     *
912:     * Devolve .T. quando o campo tem conteudo e .F. quando esta em branco - o
913:     * chamador decide o que fazer com isso (o LostFocus fecha a tela, como o
914:     * legado). NAO exibe mensagem: o legado tambem nao exibe nenhuma neste
915:     * caminho, apenas fecha.
916:     *
917:     * TRANSFORM antes do ALLTRIM: com InputMask = "999" o TextBox pode
918:     * entregar NUMERICO, e ALLTRIM sobre numerico dispara erro 11.
919:     *
920:     * PUBLIC: chamado pelos handlers e disponivel para o fluxo das fases
921:     * seguintes.
922:     *==========================================================================
923:     PROCEDURE ValidarOperador()
924:         LOCAL loc_cOperador
925: 
926:         loc_cOperador = ALLTRIM(TRANSFORM(THIS.txt_4c_USUARIO.Value))
927: 
928:         RETURN !EMPTY(loc_cOperador)
929:     ENDPROC
930: 
931:     *==========================================================================
932:     * ValidarCredenciais - Conferencia completa de Operador + Senha
933:     *
934:     * Espelha os campos para o BO (FormParaBO) ANTES de validar: o legado le
935:     * ThisForm.USUARIO.Value / ThisForm.SENHA.Value, isto eh, o TEXTBOX eh a
936:     * fonte unica. Sem esse espelho, trocar o conteudo do campo e sair dele
937:     * validaria as credenciais ANTERIORES, guardadas no BO.
938:     *
939:     * Ordem: ValidarDados() (conferencia local, sem ida ao banco - o legado
940:     * trata operador vazio como recusa, via Empty(lcUser) dentro do If) e so
941:     * entao ValidarLogin(), que faz a consulta a SigCdUsu.
942:     *
943:     * Devolve .T./.F. e deixa o texto da recusa em
944:     * this_oBusinessObject.this_cMensagemErro - quem exibe eh o chamador,
945:     * porque eh ele que conhece o momento certo (o legado so avisa no
946:     * LostFocus da Senha).
947:     *
948:     * PUBLIC: chamado pelo handler e pelo fluxo das fases seguintes.
949:     *==========================================================================
950:     PROCEDURE ValidarCredenciais()
951:         LOCAL loc_lValido
952: 
953:         loc_lValido = .F.
954: 
955:         IF VARTYPE(THIS.this_oBusinessObject) = "O"
956:             THIS.FormParaBO()
957: 
958:             IF THIS.this_oBusinessObject.ValidarDados()
959:                 loc_lValido = THIS.this_oBusinessObject.ValidarLogin( ;
960:                     ALLTRIM(TRANSFORM(THIS.txt_4c_USUARIO.Value)), ;
961:                     ALLTRIM(TRANSFORM(THIS.txt_4c_SENHA.Value)))
962:             ENDIF
963:         ENDIF
964: 
965:         RETURN loc_lValido
966:     ENDPROC
967: 
968:     *==========================================================================
969:     * FormParaBO - Leva o conteudo dos dois campos da tela para o BO
970:     *
971:     * O PADR(...,10) do legado NAO eh aplicado aqui: ValidarLogin ja o faz, e
972:     * duplicar o padding mudaria quem casa com a chave char(10).
973:     *
974:     * TRANSFORM antes do ALLTRIM pelo mesmo motivo de ValidarOperador (o
975:     * TextBox com InputMask numerico pode entregar Numerico).
976:     *
977:     * PROTECTED - e nao por escolha: FormBase.prg:285 declara FormParaBO como
978:     * PROTECTED, e pela regra #51 o PROTECTED da base PREVALECE mesmo que a
979:     * subclasse omita o modificador (medido aqui com
980:     * PEMSTATUS(form, "FormParaBO", 2) = .T.). Esta chamado so de DENTRO da
981:     * classe (ValidarCredenciais); de fora o acesso estoura
982:     * "Property FORMPARABO is not found" - quem precisar do espelho a partir
983:     * de outro objeto deve passar por ValidarCredenciais().
984:     *==========================================================================
985:     PROTECTED PROCEDURE FormParaBO()
986:         IF VARTYPE(THIS.this_oBusinessObject) != "O"
987:             RETURN .F.
988:         ENDIF
989: 
990:         THIS.this_oBusinessObject.this_cUsuarios = ALLTRIM(TRANSFORM(THIS.txt_4c_USUARIO.Value))
991:         THIS.this_oBusinessObject.this_cSenhas   = ALLTRIM(TRANSFORM(THIS.txt_4c_SENHA.Value))
992: 
993:         RETURN .T.
994:     ENDPROC
995: 
996:     *==========================================================================
997:     * LimparCampos - Ramo de recusa do legado:
998:     *   ThisForm.Senha.Value = '' / Thisform.Usuario.Value = ''
999:     *
1000:     * Limpa tambem o estado do BO, para que a tentativa seguinte nao herde o
1001:     * cargo/setor do operador da tentativa anterior (sigopprrBO.LimparDados).
1002:     *
1003:     * PROTECTED pelo mesmo motivo de FormParaBO: FormBase.prg:276 ja declara
1004:     * LimparCampos como PROTECTED e a regra #51 faz isso valer aqui. Chamado
1005:     * so de dentro (SenhaLostFocusExec).
1006:     *==========================================================================
1007:     PROTECTED PROCEDURE LimparCampos()
1008:         THIS.txt_4c_SENHA.Value   = ""
1009:         THIS.txt_4c_USUARIO.Value = ""
1010: 
1011:         IF VARTYPE(THIS.this_oBusinessObject) = "O"
1012:             THIS.this_oBusinessObject.LimparDados()
1013:         ENDIF
1014: 
1015:         RETURN .T.
1016:     ENDPROC
1017: 
1018:     *==========================================================================
1019:     * FecharDialogo - Funil UNICO de fechamento da tela
1020:     *
1021:     * Hide() e NAO Release(), apesar de o legado escrever `Thisform.Release`.
1022:     * Medido no VFP9: Release() destroi o objeto mesmo com o chamador
1023:     * segurando a referencia (VARTYPE passa a "X"), e a leitura seguinte
1024:     * estoura "is not an object". Este dialogo existe justamente para DEVOLVER
1025:     * um resultado - o cabecalho deste arquivo documenta
1026:     * `loForm.this_lAutenticado` / `loForm.this_cOperador` lidos DEPOIS do
1027:     * Show() -, entao transcrever o Release ao pe da letra tornaria esse
1028:     * resultado inalcancavel.
1029:     *
1030:     * Para o usuario nao muda nada (Hide() em form modal tambem devolve o
1031:     * Show() e a tela some), e eh o desenho que o projeto ja adota em
1032:     * FormBuscaAuxiliar: o CHAMADOR chama Release() depois de ler.
1033:     *
1034:     * O legado nao tem `PROCEDURE Unload / Return`, nem o chamador abre com
1035:     * `DO FORM ... TO` - por isso nao se inventa Unload aqui.
1036:     *==========================================================================
1037:     PROCEDURE FecharDialogo()
1038:         IF THIS.Visible
1039:             THIS.Hide()
1040:         ENDIF
1041: 
1042:         RETURN .T.
1043:     ENDPROC
1044: 
1045:     *==========================================================================
1046:     * TornarControlesVisiveis - AddObject cria todo controle com Visible = .F.
1047:     * Percorre o container informado (ou o proprio form) tornando visivel o que
1048:     * tem a propriedade, e recursa nos containers filhos.
1049:     *
1050:     * PEMSTATUS antes de tocar Visible: nem toda classe base tem a propriedade
1051:     * (regra #33 - atribuir o que a classe nao tem derruba o Init e a tela nao
1052:     * abre).
1053:     *==========================================================================
1054:     PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
1055:         LOCAL loc_oAlvo, loc_nI, loc_oControle
1056: 
1057:         loc_oAlvo = IIF(VARTYPE(par_oContainer) = "O", par_oContainer, THIS)
1058: 
1059:         IF VARTYPE(loc_oAlvo) = "O" AND PEMSTATUS(loc_oAlvo, "ControlCount", 5)
1060:             FOR loc_nI = 1 TO loc_oAlvo.ControlCount
1061:                 loc_oControle = loc_oAlvo.Controls(loc_nI)
1062: 
1063:                 IF VARTYPE(loc_oControle) = "O"
1064:                     IF PEMSTATUS(loc_oControle, "Visible", 5)
1065:                         loc_oControle.Visible = .T.
1066:                     ENDIF
1067: 
1068:                     IF PEMSTATUS(loc_oControle, "ControlCount", 5)
1069:                         THIS.TornarControlesVisiveis(loc_oControle)
1070:                     ENDIF
1071:                 ENDIF
1072:             ENDFOR
1073:         ENDIF
1074: 
1075:         RETURN .T.
1076:     ENDPROC
1077: 
1078:     *==========================================================================
1079:     * Destroy - Solta o BO e devolve o controle a FormBase.Destroy(), que
1080:     * reconstroi os popups do menu principal (Pattern #145: sem o DODEFAULT na
1081:     * ULTIMA linha o menu do sistema encolhe depois que o dialogo fecha).
1082:     *==========================================================================
1083:     PROCEDURE Destroy()
1084:         IF VARTYPE(THIS.this_oBusinessObject) = "O"
1085:             THIS.this_oBusinessObject = .NULL.
1086:         ENDIF
1087: 
1088:         DODEFAULT()
1089:     ENDPROC
1090: 
1091: ENDDEFINE


### BO (C:\4c\projeto\app\classes\sigopprrBO.prg):
*==============================================================================
* sigopprrBO.prg - Business Object para Formsigopprr (Codigo do Operador)
* Herda de BusinessBase
*
* Form OPERACIONAL (dialogo de login/reautenticacao do operador). O legado
* (SIGOPPRR) nao faz CRUD - o Init() da tela conecta ao banco e chama
* fConfigGeral()/fLerFiscal(), e o LostFocus de Senha valida USUARIO + SENHA
* contra SigCdUsu (tabela de usuarios, nao editada por este dialogo):
*     lcUser = Padr(ThisForm.USUARIO.Value,10)
*     lcPass = Padr(ThisForm.SENHA.Value,10)
*     Select a.usuarios, a.senhas From SigCdUsu a
*         Where Not a.cAtivos='N' And a.usuarios = ?lcUser Order By 1
*     If Not Used('CrSigCdUsu') Or Reccount=0 Or Empty(lcUser) ;
*         Or lcPass <> fCriptografar(CrSigCdUsu.SENHAS)
*         *-- usuario/senha incorretos
*
* Como a tela so LE SigCdUsu para validar credenciais (nunca insere, altera
* ou exclui), o comportamento padrao herdado de BusinessBase para
* Inserir()/Atualizar()/ExecutarExclusao() ja eh o correto. Sobrescrever esses
* tres metodos aqui exigiria INVENTAR um INSERT/UPDATE em SigCdUsu que o
* legado nunca faz - o oposto da regra #22 do CLAUDE.md (a lista de colunas
* vem do schema, e a operacao vem do legado). ObterChavePrimaria() continua
* sobrescrito para que qualquer caminho herdado de auditoria reporte a chave
* certa (usuarios).
*
* Tabela ...: SigCdUsu (consulta de validacao)
* Chave .....: usuarios (char 10) - PK sigcdusu_usuarios
*
*------------------------------------------------------------------------------
* DEPENDENCIAS DO LEGADO FORTYUS QUE NAO VIERAM NO ACERVO (regra #27)
*
* fCriptografar(<senha gravada>) - devolve a senha em claro, comparavel com o
*   que o operador digitou. A funcao vive em sig.prg/SIGFUNCS.PRG, que nao
*   veio no acervo, e o algoritmo nao esta legivel em fonte nenhum. A chamada
*   eh transcrita LITERALMENTE em ValidarLogin(): se a funcao faltar, o VFP
*   estoura dentro do TRY e o CATCH devolve a mensagem pelo this_cMensagemErro
*   em vez de fechar a tela. NUNCA criar utils\fcriptografar.prg com algoritmo
*   inventado: hash inventado autentica quem nao deveria entrar, e em silencio.
*   Mesmo tratamento ja adotado em SigOpAlCBO, SigOpLimBO e SigOpCtsBO.
*
* ProgOper(<operador>, <modem>) - programa o codigo do operador no dispositivo
*   (modem/ECF) antes de publicar goSistema.Operador. Tambem nao veio no
*   acervo, e o objeto que o legado passa como 2o argumento (ThisForm.oModem)
*   nao existe nem no SCX legado nem no form migrado, entao a chamada nao eh
*   sequer expressavel aqui. DIVERGENCIA CONSCIENTE: DefinirOperadorLogado()
*   publica o operador SEM o passo de dispositivo - era o unico efeito do qual
*   o resto do sistema depende; sem ele o dialogo inteiro nao teria proposito.
*==============================================================================
DEFINE CLASS sigopprrBO AS BusinessBase

    *--------------------------------------------------------------------------
    * Propriedades - credenciais digitadas pelo operador
    * Tipos conferidos em docs/schema.sql (tabela sigcdusu):
    *   usuarios char(10) NOT NULL (PK) | senhas char(10) NOT NULL
    *--------------------------------------------------------------------------
    this_cUsuarios = ""    && SigCdUsu.usuarios - codigo do operador digitado (char 10)
    this_cSenhas   = ""    && SigCdUsu.senhas   - senha digitada em texto claro (char 10)

    *--------------------------------------------------------------------------
    * Propriedades - estado da validacao (NAO existem em SigCdUsu)
    *--------------------------------------------------------------------------
    this_lLoginValido = .F.    && .T. apos ValidarLogin() encontrar usuario/senha corretos

    *--------------------------------------------------------------------------
    * Propriedades - demais colunas de SigCdUsu, preenchidas por
    * CarregarDoCursor() com a linha do operador autenticado. Tipos conferidos
    * em docs/schema.sql (lido com Get-Content -Raw - o arquivo eh UTF-16,
    * regra #14):
    *   supervis char(1)   | ccargs char(10)  | limdescs char(1)
    *   ncomps char(30)    | deptos char(10)  | libpess char(1)
    *   libprods char(1)   | setores char(10) | cativos char(1)
    *   tdtsenhas datetime NULL                | iclis char(10)
    *   obrigsenhas numeric(1,0)               | libqtmins char(1)
    *
    * As duas colunas text de sigcdusu (mbiodigs = digital biometrica,
    * figjpgsuser = foto do usuario) ficam DE FORA de proposito: o legado deste
    * dialogo nunca as le, elas sao blobs, e o SELECT de ValidarLogin() lista
    * as colunas explicitamente - logo nao chegam ao cursor e nao ha o que
    * mapear. Tela que precisar da biometria/foto deve consulta-las no seu
    * proprio BO.
    *--------------------------------------------------------------------------
    this_cSupervis    = ""    && SigCdUsu.supervis  - indicador de supervisor (char 1)
    this_cCcargs      = ""    && SigCdUsu.ccargs    - cargo do operador (char 10)
    this_cLimdescs    = ""    && SigCdUsu.limdescs  - limite de desconto (char 1)
    this_cNcomps      = ""    && SigCdUsu.ncomps    - nome completo do operador (char 30)
    this_cDeptos      = ""    && SigCdUsu.deptos    - departamento (char 10)
    this_cLibpess     = ""    && SigCdUsu.libpess   - liberacao de dados pessoais (char 1)
    this_cLibprods    = ""    && SigCdUsu.libprods  - liberacao de produtos (char 1)
    this_cSetores     = ""    && SigCdUsu.setores   - setor do operador (char 10)
    this_cCativos     = ""    && SigCdUsu.cativos   - N = usuario inativo (char 1)
    this_dTdtsenhas   = {}    && SigCdUsu.tdtsenhas - data/hora da ultima troca de senha
    this_cIclis       = ""    && SigCdUsu.iclis     - conta/cliente vinculado (char 10)
    this_nObrigsenhas = 0     && SigCdUsu.obrigsenhas - numeric(1,0), NAO eh logico
    this_cLibqtmins   = ""    && SigCdUsu.libqtmins - liberacao de quantidade minima (char 1)

    *--------------------------------------------------------------------------
    * Cursor de trabalho da consulta de credenciais (equivale ao CrSigCdUsu do
    * legado; nome novo por causa do PILAR 3)
    *--------------------------------------------------------------------------
    this_cCursorUsuario = "cursor_4c_UsuarioLogin"

    *--------------------------------------------------------------------------
    * INIT - Construtor
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        LOCAL loc_lResultado, loc_oErro

        loc_lResultado = .F.

        TRY
            loc_lResultado = DODEFAULT()

            IF loc_lResultado
                THIS.this_cTabela     = "SigCdUsu"
                THIS.this_cCampoChave = "usuarios"

                *-- Estado inicial da validacao de login
                THIS.LimparDados()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, "Erro ao inicializar sigopprrBO")
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * CarregarDoCursor - Mapeia a linha corrente do cursor informado para as
    * propriedades do BO. Chamado por ValidarLogin() e por CarregarPorCodigo()
    * depois do SELECT em SigCdUsu.
    *
    * Metodo PUBLIC (a base tambem eh): o Form pode chamar de fora depois de
    * popular o cursor por conta propria - regra #51.
    *==========================================================================
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso, loc_cAlias, loc_oErro

        loc_lSucesso = .F.
        loc_cAlias   = IIF(VARTYPE(par_cAliasCursor) = "C", ALLTRIM(par_cAliasCursor), "")

        TRY
            IF !EMPTY(loc_cAlias) AND USED(loc_cAlias)
                SELECT (loc_cAlias)

                IF !EOF(loc_cAlias)
                    *-- usuarios char(10) - chave primaria
                    IF TYPE(loc_cAlias + ".usuarios") == "C"
                        THIS.this_cUsuarios = TratarNulo(usuarios, "")
                    ENDIF

                    *-- senhas char(10) vem no cursor para a conferencia de
                    *-- ValidarLogin, mas NAO eh copiada para propriedade
                    *-- nenhuma: a senha gravada nao fica viva na memoria do BO
                    *-- depois do login.

                    *-- supervis char(1)
                    IF TYPE(loc_cAlias + ".supervis") == "C"
                        THIS.this_cSupervis = TratarNulo(supervis, "")
                    ENDIF

                    *-- ccargs char(10)
                    IF TYPE(loc_cAlias + ".ccargs") == "C"
                        THIS.this_cCcargs = TratarNulo(ccargs, "")
                    ENDIF

                    *-- limdescs char(1)
                    IF TYPE(loc_cAlias + ".limdescs") == "C"
                        THIS.this_cLimdescs = TratarNulo(limdescs, "")
                    ENDIF

                    *-- ncomps char(30)
                    IF TYPE(loc_cAlias + ".ncomps") == "C"
                        THIS.this_cNcomps = TratarNulo(ncomps, "")
                    ENDIF

                    *-- deptos char(10)
                    IF TYPE(loc_cAlias + ".deptos") == "C"
                        THIS.this_cDeptos = TratarNulo(deptos, "")
                    ENDIF

                    *-- libpess char(1)
                    IF TYPE(loc_cAlias + ".libpess") == "C"
                        THIS.this_cLibpess = TratarNulo(libpess, "")
                    ENDIF

                    *-- libprods char(1)
                    IF TYPE(loc_cAlias + ".libprods") == "C"
                        THIS.this_cLibprods = TratarNulo(libprods, "")
                    ENDIF

                    *-- setores char(10)
                    IF TYPE(loc_cAlias + ".setores") == "C"
                        THIS.this_cSetores = TratarNulo(setores, "")
                    ENDIF

                    *-- cativos char(1) - N marca usuario inativo
                    IF TYPE(loc_cAlias + ".cativos") == "C"
                        THIS.this_cCativos = TratarNulo(cativos, "")
                    ENDIF

                    *-- tdtsenhas datetime NULL - ConverterParaData normaliza
                    *-- DATE/DATETIME/CHAR (regra #16: TTOD so aceita DATETIME)
                    IF INLIST(TYPE(loc_cAlias + ".tdtsenhas"), "T", "D")
                        THIS.this_dTdtsenhas = ConverterParaData(TratarNulo(tdtsenhas, {}))
                    ENDIF

                    *-- iclis char(10)
                    IF TYPE(loc_cAlias + ".iclis") == "C"
                        THIS.this_cIclis = TratarNulo(iclis, "")
                    ENDIF

                    *-- obrigsenhas numeric(1,0) - NAO eh logico, nao achatar
                    *-- para .T./.F. (perderia os valores diferentes de 0 e 1)
                    IF TYPE(loc_cAlias + ".obrigsenhas") == "N"
                        THIS.this_nObrigsenhas = NVL(obrigsenhas, 0)
                    ENDIF

                    *-- libqtmins char(1)
                    IF TYPE(loc_cAlias + ".libqtmins") == "C"
                        THIS.this_cLibqtmins = TratarNulo(libqtmins, "")
                    ENDIF

                    loc_lSucesso = .T.
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = "Erro ao ler os dados do operador:" + CHR(13) + ;
                loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo)
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * CarregarPorCodigo - Le a linha de SigCdUsu do operador informado e
    * preenche as propriedades, SEM conferir senha. Usado quando a tela so
    * precisa dos dados do operador (cargo/setor/nome) ja autenticado.
    *
    * Mantem o filtro do legado (Not cativos = N): operador inativo nao eh
    * encontrado, igual a consulta do SENHA.LostFocus.
    *==========================================================================
    PROCEDURE CarregarPorCodigo(par_cUsuario)
        LOCAL loc_lSucesso, loc_cSQL, loc_nResultado, loc_cUsuarioPad, loc_cCursor, loc_oErro

        loc_lSucesso            = .F.
        THIS.this_cMensagemErro = ""
        loc_cCursor             = THIS.this_cCursorUsuario
        loc_cUsuarioPad         = PADR(THIS.NormalizarTexto(par_cUsuario), 10)

        TRY
            IF EMPTY(loc_cUsuarioPad)
                THIS.this_cMensagemErro = "Operador n" + CHR(227) + "o informado."
            ELSE
                IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
                    THIS.this_cMensagemErro = "Conex" + CHR(227) + "o com o banco de dados " + ;
                        "indispon" + CHR(237) + "vel."
                ELSE
                    THIS.FecharCursorUsuario()

                    loc_cSQL = "SELECT a.usuarios, a.senhas, a.supervis, a.ccargs" + ;
                               ", a.limdescs, a.ncomps, a.deptos, a.libpess" + ;
                               ", a.libprods, a.setores, a.cativos, a.tdtsenhas" + ;
                               ", a.iclis, a.obrigsenhas, a.libqtmins" + ;
                               " FROM SigCdUsu a" + ;
                               " WHERE NOT a.cativos = 'N'" + ;
                               " AND a.usuarios = " + EscaparSQL(loc_cUsuarioPad) + ;
                               " ORDER BY a.usuarios"

                    loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, loc_cCursor)

                    IF loc_nResultado <= 0
                        THIS.this_cMensagemErro = "Erro ao consultar o operador:" + CHR(13) + ;
                            CapturarErroSQL()
                    ELSE
                        IF !USED(loc_cCursor) OR RECCOUNT(loc_cCursor) = 0
                            THIS.this_cMensagemErro = "Operador n" + CHR(227) + "o cadastrado " + ;
                                "ou inativo."
                        ELSE
                            SELECT (loc_cCursor)
                            GO TOP
                            loc_lSucesso = THIS.CarregarDoCursor(loc_cCursor)
                        ENDIF
                    ENDIF

                    THIS.FecharCursorUsuario()
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure
            THIS.FecharCursorUsuario()
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * ValidarLogin - Transcricao do SIGOPPRR.SENHA.LostFocus:
    *
    *   lcUser = PADR(ThisForm.USUARIO.Value,10)
    *   lcPass = PADR(Thisform.SENHA.Value,10)
    *   lcQuery = [select a.usuarios, a.senhas from SigCdUsu a
    *              where Not a.cAtivos='N' and a.usuarios='] + lcUser + [' order by 1]
    *   ThisForm.poDataMgr.SQLExecute(lcQuery, 'crSigCdUsu')
    *   If Not Used('CrSigCdUsu') Or Reccount('CrSigCdUsu')==0 Or Empty(lcUser) ;
    *      OR lcPass <> fCriptografar(CrSigCdUsu.SENHAS)
    *       *-- recusa
    *
    * Fidelidade preservada ponto a ponto:
    *  - PADR SEM ALLTRIM nos dois valores: o campo USUARIO tem InputMask 999
    *    e o legado compara o que esta no controle, com o espacamento que
    *    estiver la. ALLTRIM aqui mudaria quem casa com a chave char(10).
    *  - o filtro continua NOT cativos = N (usuario inativo nao autentica).
    *  - as quatro condicoes de recusa do If sao as mesmas, e todas devolvem a
    *    MESMA mensagem do legado (Usuario ou Senha incorretos), sem revelar
    *    qual delas falhou.
    *
    * Unica extensao: o SELECT lista as demais colunas escalares da linha (o
    * legado pede so usuarios+senhas) para preencher as propriedades de estado
    * declaradas neste BO. O criterio de autenticacao nao muda.
    *==========================================================================
    PROCEDURE ValidarLogin(par_cUsuario, par_cSenha)
        LOCAL loc_lSucesso, loc_cSQL, loc_nResultado, loc_cCursor
        LOCAL loc_cUsuarioPad, loc_cSenhaPad, loc_cSenhaGravada, loc_oErro

        loc_lSucesso            = .F.
        THIS.this_cMensagemErro = ""
        THIS.this_lLoginValido  = .F.
        loc_cCursor             = THIS.this_cCursorUsuario

        *-- PADR sem ALLTRIM, exatamente como o legado
        loc_cUsuarioPad = PADR(THIS.NormalizarTexto(par_cUsuario), 10)
        loc_cSenhaPad   = PADR(THIS.NormalizarTexto(par_cSenha), 10)

        THIS.this_cUsuarios = loc_cUsuarioPad
        THIS.this_cSenhas   = loc_cSenhaPad

        TRY
            IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
                THIS.this_cMensagemErro = "Conex" + CHR(227) + "o com o banco de dados " + ;
                    "indispon" + CHR(237) + "vel."
            ELSE
                THIS.FecharCursorUsuario()

                loc_cSQL = "SELECT a.usuarios, a.senhas, a.supervis, a.ccargs" + ;
                           ", a.limdescs, a.ncomps, a.deptos, a.libpess" + ;
                           ", a.libprods, a.setores, a.cativos, a.tdtsenhas" + ;
                           ", a.iclis, a.obrigsenhas, a.libqtmins" + ;
                           " FROM SigCdUsu a" + ;
                           " WHERE NOT a.cativos = 'N'" + ;
                           " AND a.usuarios = " + EscaparSQL(loc_cUsuarioPad) + ;
                           " ORDER BY a.usuarios"

                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, loc_cCursor)

                IF loc_nResultado <= 0
                    THIS.this_cMensagemErro = "Erro ao consultar o operador:" + CHR(13) + ;
                        CapturarErroSQL()
                ELSE
                    IF !USED(loc_cCursor) OR RECCOUNT(loc_cCursor) = 0 OR EMPTY(loc_cUsuarioPad)
                        *-- 3 das 4 condicoes do If legado
                        THIS.this_cMensagemErro = "Usu" + CHR(225) + "rio ou Senha incorretos"
                    ELSE
                        SELECT (loc_cCursor)
                        GO TOP

                        *-- 4a condicao: lcPass <> fCriptografar(CrSigCdUsu.SENHAS).
                        *-- fCriptografar NAO foi portada (ver cabecalho): a
                        *-- chamada eh literal e, faltando a funcao, o VFP
                        *-- estoura aqui dentro e cai no CATCH abaixo - que eh
                        *-- o comportamento desejado (ausencia VISIVEL), nunca
                        *-- um stub devolvendo valor de calculo.
                        loc_cSenhaGravada = fCriptografar(senhas)

                        IF loc_cSenhaPad == PADR(TratarNulo(loc_cSenhaGravada, ""), 10)
                            loc_lSucesso = THIS.CarregarDoCursor(loc_cCursor)

                            IF loc_lSucesso
                                THIS.this_lLoginValido = .T.
                            ELSE
                                THIS.this_cMensagemErro = "Erro ao ler os dados do operador " + ;
                                    "autenticado." + CHR(13) + THIS.this_cMensagemErro
                            ENDIF
                        ELSE
                            THIS.this_cMensagemErro = "Usu" + CHR(225) + "rio ou Senha incorretos"
                        ENDIF
                    ENDIF
                ENDIF

                THIS.FecharCursorUsuario()
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure
            THIS.FecharCursorUsuario()
        ENDTRY

        *-- A senha em claro nunca permanece viva no BO depois da conferencia
        THIS.this_cSenhas = ""

        IF !loc_lSucesso
            THIS.this_lLoginValido = .F.
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * DefinirOperadorLogado - Publica o operador autenticado em
    * go_4c_Sistema.Operador, no mesmo formato do legado:
    *
    *   If ProgOper(Val(Thisform.Usuario.Value), Thisform.oModem)
    *       goSistema.Operador = Transform(Val(Thisform.Usuario.Value),'@L 999')
    *   Endif
    *
    * ProgOper (programacao do operador no dispositivo) nao veio no acervo e o
    * objeto ThisForm.oModem nao existe nem no SCX legado nem no form migrado -
    * ver o cabecalho deste arquivo. O operador eh publicado assim mesmo: eh o
    * efeito do qual o resto do sistema depende.
    *
    * go_4c_Sistema eh um objeto Empty: ler/gravar property que ele nao tem
    * estoura "Property OPERADOR is not found" (medido no VFP9), e Empty nao
    * tem metodo AddProperty - por isso a criacao vai pela FUNCAO ADDPROPERTY().
    *==========================================================================
    PROCEDURE DefinirOperadorLogado()
        LOCAL loc_lSucesso, loc_cOperador, loc_oErro

        loc_lSucesso = .F.

        TRY
            IF THIS.this_lLoginValido AND !EMPTY(THIS.this_cUsuarios)
                loc_cOperador = TRANSFORM(VAL(THIS.this_cUsuarios), "@L 999")

                IF TYPE("go_4c_Sistema") = "O" AND !ISNULL(go_4c_Sistema)
                    IF PEMSTATUS(go_4c_Sistema, "Operador", 5)
                        go_4c_Sistema.Operador = loc_cOperador
                    ELSE
                        ADDPROPERTY(go_4c_Sistema, "Operador", loc_cOperador)
                    ENDIF

                    loc_lSucesso = .T.
                ELSE
                    THIS.this_cMensagemErro = "Objeto de sistema indispon" + CHR(237) + "vel " + ;
                        "para registrar o operador."
                ENDIF
            ELSE
                THIS.this_cMensagemErro = "Operador n" + CHR(227) + "o autenticado."
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * ValidarDados - Conferencia previa dos campos da tela, antes de gastar
    * uma ida ao banco. O legado trata operador vazio como recusa
    * (Empty(lcUser) entra no If de erro) e o LostFocus de USUARIO fecha o
    * dialogo quando o campo fica em branco.
    *
    * PUBLIC (como na base) - o Form chama de fora. Regra #51.
    *==========================================================================
    PROCEDURE ValidarDados()
        LOCAL loc_lValido

        loc_lValido             = .F.
        THIS.this_cMensagemErro = ""

        DO CASE
            CASE EMPTY(THIS.this_cUsuarios)
                THIS.this_cMensagemErro = "Operador n" + CHR(227) + "o informado."

            CASE EMPTY(THIS.this_cSenhas)
                THIS.this_cMensagemErro = "Senha n" + CHR(227) + "o informada."

            OTHERWISE
                loc_lValido = .T.
        ENDCASE

        RETURN loc_lValido
    ENDPROC

    *==========================================================================
    * LimparDados - Devolve o BO ao estado de "ninguem autenticado". Chamado
    * pelo Init e pelo Form a cada nova tentativa, para que a tentativa
    * seguinte nunca herde o cargo/setor do operador anterior.
    *==========================================================================
    PROCEDURE LimparDados()
        DODEFAULT()

        THIS.this_cUsuarios    = ""
        THIS.this_cSenhas      = ""
        THIS.this_lLoginValido = .F.

        THIS.this_cSupervis    = ""
        THIS.this_cCcargs      = ""
        THIS.this_cLimdescs    = ""
        THIS.this_cNcomps      = ""
        THIS.this_cDeptos      = ""
        THIS.this_cLibpess     = ""
        THIS.this_cLibprods    = ""
        THIS.this_cSetores     = ""
        THIS.this_cCativos     = ""
        THIS.this_dTdtsenhas   = {}
        THIS.this_cIclis       = ""
        THIS.this_nObrigsenhas = 0
        THIS.this_cLibqtmins   = ""

        RETURN .T.
    ENDPROC

    *==========================================================================
    * NormalizarTexto - Devolve sempre CARACTERE, qualquer que seja o tipo
    * recebido do controle (TextBox com InputMask numerico pode entregar
    * Numerico, e coluna anulavel chega como .NULL.). Existe para que o PADR de
    * ValidarLogin/CarregarPorCodigo nunca receba tipo errado - PADR com
    * numerico dispara "Function argument value, type, or count is invalid".
    *==========================================================================
    PROTECTED PROCEDURE NormalizarTexto(par_uValor)
        LOCAL loc_cTexto

        DO CASE
            CASE VARTYPE(par_uValor) = "C"
                loc_cTexto = par_uValor

            CASE ISNULL(par_uValor)
                loc_cTexto = ""

            CASE VARTYPE(par_uValor) = "N"
                loc_cTexto = ALLTRIM(TRANSFORM(par_uValor))

            OTHERWISE
                loc_cTexto = ""
        ENDCASE

        RETURN loc_cTexto
    ENDPROC

    *==========================================================================
    * FecharCursorUsuario - Fecha o cursor de trabalho da consulta de
    * credenciais. O guard pelo BUFFERING antes do TABLEREVERT eh a regra #52:
    * cursor nascido com Buffering = 1 faz TABLEREVERT estourar erro 1586, e
    * USE IN fecha o alias de qualquer modo.
    *==========================================================================
    PROTECTED PROCEDURE FecharCursorUsuario()
        LOCAL loc_cCursor

        loc_cCursor = THIS.this_cCursorUsuario

        IF USED(loc_cCursor)
            IF CURSORGETPROP("Buffering", loc_cCursor) > 1
                TABLEREVERT(.T., loc_cCursor)
            ENDIF
            USE IN (loc_cCursor)
        ENDIF

        RETURN .T.
    ENDPROC

    *==========================================================================
    * ObterChavePrimaria - Chave de SigCdUsu (usuarios char 10). Sobrescrito
    * para que o caminho herdado de auditoria do BusinessBase reporte a chave
    * correta. PROTECTED como na base: de fora ninguem chama (regra #51).
    *==========================================================================
    PROTECTED PROCEDURE ObterChavePrimaria()
        RETURN ALLTRIM(THIS.this_cUsuarios)
    ENDPROC

    *--------------------------------------------------------------------------
    * DESTROY - Garante que o cursor de trabalho nao fique aberto
    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
        THIS.FecharCursorUsuario()
        DODEFAULT()
    ENDPROC

ENDDEFINE


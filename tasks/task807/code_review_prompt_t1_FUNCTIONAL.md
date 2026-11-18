# CODE REVIEW - PASS FUNCTIONAL: Functional Logic (metodos, eventos, containers)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Functional Logic (metodos, eventos, containers)**.

## PROBLEMAS DETECTADOS (3)
- [METODO-INEXISTENTE] Metodo 'THIS.Caption()' chamado mas NAO definido como PROCEDURE no Form nem herdado de FormBase. A LLM pode ter inventado este metodo. VERIFICAR se existe no legado e IMPLEMENTAR ou REMOVER a chamada.
- [METODO-INEXISTENTE] Metodo 'THIS.Width()' chamado mas NAO definido como PROCEDURE no Form nem herdado de FormBase. A LLM pode ter inventado este metodo. VERIFICAR se existe no legado e IMPLEMENTAR ou REMOVER a chamada.
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

### FORM (C:\4c\projeto\app\forms\operacionais\FormSIGOPSTC.prg) - TRECHOS RELEVANTES PARA PASS FUNCTIONAL (1609 linhas total):

*-- Linhas 25 a 251:
25: *   completo da consulta e da colisao de nomes cUsuarios entre as tabelas.
26: *
27: * CHAMADA (equivale ao Do Form SIGOPSTC With ThisForm do legado):
28: *   loForm = CREATEOBJECT("FormSIGOPSTC", THISFORM)
29: *   IF VARTYPE(loForm) = "O"
30: *       loForm.Show()          && modal: so volta quando o dialogo fecha
31: *   ENDIF
32: *
33: *   O form pai precisa expor a property pcSelFile (char, nome do arquivo
34: *   ja transmitido) ANTES de abrir este dialogo - exatamente como o
35: *   legado exige ThisForm.poForm.pcSelFile.
36: *
37: * PARAMETRO (legado: LParameters poForm)
38: *   par_oFormPai - legado: poForm (RESERVED3/ClassInfo do SCX = "poform",
39: *                  custom property default .F. sobrescrita no Init). Form
40: *                  que abriu o dialogo; eh dele que vem pcSelFile
41: *                  (arquivo a consultar) e, so para auditoria,
42: *                  DataSessionId (ver NOTA abaixo).
43: *
44: * NOTA - ThisForm.DataSessionId = poForm.DataSessionId (legado)
45: *   DataSessionID eh propriedade READ-ONLY em runtime no VFP9 (so pode
46: *   ser lida, nunca atribuida) - a linha do legado nao sincroniza sessao
47: *   nenhuma de verdade. O valor eh so guardado para referencia/auditoria
48: *   em THIS.this_oBusinessObject.this_nDataSessionPai (property que a
49: *   Fase 1-2 ja antecipou com esse proposito), sem tentar reatribuir
50: *   DataSession em runtime (regra CLAUDE.md sobre propriedade read-only).
51: *
52: * NOTA - cabecalho cntSombra com Caption LITERAL "Cadastro de Testes"
53: *   Nos dialogos irmaos desta mesma familia (FormSigOpSpr/FormSigOpSlc,
54: *   tasks 803/805) o Init legado faz
55: *   ThisForm.cntSombra.lblSombra.Caption = ThisForm.Caption /
56: *   ThisForm.cntSombra.lblTitulo.Caption = ThisForm.Caption - por isso
57: *   aqueles migrados usam .Caption = THIS.Caption (dinamico). O Init de
58: *   SIGOPSTC (conferido linha a linha no dump, tasks\task807\
59: *   SIGOPSTC_form_codigo_fonte.txt) NAO faz essa copia: os dois labels
60: *   ficam com o literal "Cadastro de Testes" do Form Designer, nunca
61: *   atualizado para "Status da transmissao do Arquivo Cat" (Form.Caption).
62: *   Isso significa que, com TitleBar=0 (sem barra de titulo nativa), o
63: *   USUARIO NUNCA VE o Caption real do form em lugar nenhum da tela - um
64: *   defeito legitimo do legado, nao desta migracao. Regra #17 do
65: *   CLAUDE.md (transcrever formula/texto do legado, nao "corrigir"):
66: *   mantido literal "Cadastro de Testes" nos dois labels.
67: *
68: * FASE 3: estrutura base do form - DEFINE CLASS com as propriedades
69: * visuais transcritas do SCX, a propriedade de estado que espelha o poForm
70: * do Init legado, Init com o parametro, ValidarParametros, InicializarForm,
71: * ConfigurarDecoracao (Picture), ConfigurarCabecalho (cntSombra),
72: * TornarControlesVisiveis e Destroy.
73: *
74: * FASE 4: o corpo da tela - Shape1 (moldura) e Label1
75: * ("Arquivo :") em ConfigurarMoldura; Grid1 (a lista de tentativas de
76: * envio) em ConfigurarGrade + AplicarFormatoGrade; Commandgroup1 com o
77: * unico botao "Encerrar" em ConfigurarBotoes; e CarregarLista, o funil que
78: * chama THIS.this_oBusinessObject.CarregarSituacao(THIS.this_cArqMovsPai) e
79: * liga a grade ao cursor_4c_Envios da Fase 1-2.
80: *
81: * Esta tela NAO tem PageFrame nem CRUD (layout FLAT): o legado monta tudo
82: * direto na Form e o unico botao so fecha o dialogo, entao nao existem aqui
83: * os metodos de pagina/alternancia nem os seis botoes do padrao CRUD -
84: * inventa-los violaria o PILAR 1.
85: *
86: * FASE 5: a PRIMEIRA METADE dos campos do cabecalho de
87: * SigFiSit - Text1 (o arquivo, rotulado pelo Label1 que a Fase 4 criou),
88: * Label2 + Text2 ("Lote :") e Label3 + Text3 ("Empresa :") - em
89: * ConfigurarCamposCabecalho; mais AtualizarCabecalho, o espelho que copia
90: * para esses campos as properties que SIGOPSTCBO.CarregarDoCursor
91: * preenche. Eh o equivalente das linhas
92: *     ThisForm.Text1.Value = crTmpLgSit.cArqMovs
93: *     ThisForm.Text2.Value = crTmpLgSit.cNumLotes
94: *     ThisForm.Text3.Value = crTmpLgSit.cEmps
95: * do Init legado: ali os quatro Text recebem .Value DIRETO (nao ha
96: * ControlSource neles), e aqui a mesma copia acontece uma vez, no funil
97: * CarregarLista, logo depois da consulta.
98: *
99: * FASE 6: a SEGUNDA METADE dos campos e os eventos de dado.
100: *   - Label4 + Text4 ("Impresssora :", cImpFabs) fecham o cabecalho, em
101: *     ConfigurarCamposCabecalho, junto dos tres campos da Fase 5; o
102: *     AtualizarCabecalho passa a espelhar os QUATRO.
103: *   - Edit1 (ConfigurarCampoRetorno) eh o painel de DETALHE ao lado da
104: *     grade: exibe SigFiSii.cretornos da tentativa de envio selecionada.
105: *     Eh o UNICO campo da tela que muda ao navegar na grade - os quatro
106: *     Text mostram o cabecalho de SigFiSit, replicado em toda linha pelo
107: *     INNER JOIN. O ControlSource dele eh ligado em CarregarLista, com o
108: *     alias ja aberto (regra #41), como na penultima linha do Init legado.
109: *   - ConfigurarEventos liga, por BINDEVENT, o Grid1.AfterRowColChange do
110: *     legado a GradeAfterRowColChange -> AtualizarDetalheRetorno, a fonte
111: *     unica do painel de retorno (usada tambem na primeira exibicao, em
112: *     CarregarLista, para os dois caminhos nao divergirem).
113: *
114: * SEM LOOKUP: esta fase normalmente entrega tambem os lookups (F4/F5 ->
115: * FormBuscaAuxiliar), e aqui NAO HA NENHUM a entregar. Conferido no dump
116: * inteiro (tasks\task807\SIGOPSTC_form_codigo_fonte.txt): zero fwBuscaExt
117: * / fwBuscaSel / fwBuscaInt / sigacess() / AcessoEmpresa() / mAddColuna, e
118: * nenhum campo com PROCEDURE Valid. Nem poderia haver - os cinco campos de
119: * dado da tela (Text1..Text4 e Edit1) tem PROCEDURE When -> Return(.F.) no
120: * legado, isto eh, NENHUM aceita digitacao, e campo que nunca recebe foco
121: * nao tem onde digitar o codigo que abriria o picker. Inventar um lookup
122: * aqui violaria o PILAR 1 e a regra "NUNCA inventar tabelas de lookup que
123: * nao existem no original".
124: *
125: * FASE 7 (esta fase): o evento do botao - BtnEncerrarClick, o Click do
126: * UNICO botao da tela (ThisForm.Release do legado), ligado por BINDEVENT em
127: * ConfigurarEventos. Eh a unica saida do dialogo, ja que o form nao tem
128: * TitleBar nem ControlBox (Closable = .F.).
129: *
130: * SEM BOTAO CRUD: esta fase normalmente entrega os quatro handlers do padrao
131: * CRUD (BtnIncluirClick / BtnAlterarClick / BtnVisualizarClick /
132: * BtnExcluirClick) e aqui NAO HA NENHUM a entregar. Conferido no dump
133: * inteiro (tasks\task807\SIGOPSTC_form_codigo_fonte.txt):
134: *   - a Class do form eh "form" PURO, nao "frmcadastro" - logo nao ha a
135: *     barra CRUD que o framework Fortyus herda;
136: *   - zero "Grupo_Op" e zero "pcEscolha" (a variavel de MODO do
137: *     frmcadastro): esta tela nao tem modo INCLUIR/ALTERAR/VISUALIZAR,
138: *     porque nao grava nada;
139: *   - o unico CommandGroup tem ButtonCount = 1, e esse botao eh o Encerrar.
140: * Escrever os quatro nomes aqui obrigaria a INVENTAR botoes que o legado nao
141: * tem (viola o PILAR 1 e a regra "NUNCA inventar") ou a criar quatro metodos
142: * vazios (stub disfarcado, proibido pela regra de completude).
143: *
144: * FASE 8/8 (esta fase) - EVENTOS AUXILIARES E CONSOLIDACAO FINAL
145: *   A superficie que o legado tem ja estava inteira ao fim da Fase 7, e isso
146: *   foi CONFERIDO metodo a metodo contra a SECAO 3 do dump (que tem NOVE
147: *   metodos, nem um a mais):
148: *     SIGOPSTC.Init ................. Init (poForm) + InicializarForm +
149: *                                     CarregarLista + THIS.Refresh
150: *     Commandgroup1.Command2.Click .. BtnEncerrarClick   (BINDEVENT no Buttons(1))
151: *     Grid1.AfterRowColChange ....... GradeAfterRowColChange -> AtualizarDetalheRetorno
152: *     Edit1.When  -> Return(.F.) .... edt_4c_Edit1.ReadOnly  = .T. + TabStop = .F.
153: *     Text1.When  -> Return(.F.) .... txt_4c_Text1.ReadOnly  = .T. + TabStop = .F.
154: *     Text2.When  -> Return(.F.) .... txt_4c_Text2.ReadOnly  = .T. + TabStop = .F.
155: *     Text3.When  -> Return(.F.) .... txt_4c_Text3.ReadOnly  = .T. + TabStop = .F.
156: *     Text4.When  -> Return(.F.) .... txt_4c_Text4.ReadOnly  = .T. + TabStop = .F.
157: *   O unico ajuste desta fase foi de NOME: o funil de carga da grade, que
158: *   nasceu na Fase 4 como CarregarDados, passou a se chamar CarregarLista -
159: *   o nome canonico do projeto para o metodo que popula a grade, que eh
160: *   exatamente o que ele faz (ver a NOTA no proprio metodo).
161: *
162: *   OS TRES OUTROS NOMES CANONICOS DA FASE 8 NAO TEM REFERENTE NESTE LEGADO
163: *   BtnCancelarClick, FormParaBO e BOParaForm sao convencao do par
164: *   Page2(Dados) + modo INCLUIR/ALTERAR do frmcadastro:
165: *     - BtnCancelarClick cancela uma EDICAO em andamento, e aqui nao existe
166: *       edicao - os cinco campos de dado tem When -> Return(.F.) no legado,
167: *       nenhum aceita digitacao, e o unico botao da tela so fecha;
168: *     - FormParaBO escreve campo EDITAVEL de volta no BO, e nao ha nenhum;
169: *     - BOParaForm eh o sentido BO -> campo, que esta entregue e EM USO com
170: *       outro nome, porque aqui ele tem DOIS destinos distintos:
171: *       AtualizarCabecalho (as quatro properties de SigFiSit nos Text1..Text4)
172: *       e AtualizarDetalheRetorno (o cretornos da linha corrente no Edit1,
173: *       refeito a cada troca de linha). Um metodo unico chamado BOParaForm
174: *       mentiria sobre esse recorte, que eh o do proprio legado.
175: *   Escrever os tres obrigaria a INVENTAR superficie que o legado nao tem
176: *   (viola o PILAR 1) ou a criar metodo vazio (proibido pela regra de
177: *   completude).
178: *
179: *   INTEGRACAO - o que NAO se faz neste form, e por que
180: *     - menu.prg: NENHUM item. Esta tela eh dialogo FILHO que depende de
181: *       poForm.pcSelFile (o arquivo que o form pai acabou de transmitir);
182: *       aberta pelo menu, sem chamador, nao teria arquivo para consultar -
183: *       o proprio ValidarParametros recusa a abertura nesse caso. Mesmo
184: *       criterio ja aplicado aos outros dialogos filhos migrados
185: *       (FormSigOpCtd, FormSigOpCcj, FormSigPrCar, FormSIGPRSTF).
186: *     - config.prg: NENHUM SET PROCEDURE. Desde 2026-10-28 a carga eh SOB
187: *       DEMANDA (CLAUDE.md, secao config.prg) - acrescentar BO/Form ali eh
188: *       proibido. forms\operacionais ja esta no escopo de
189: *       automation\GerarIndiceClasses.ps1, entao start\indice_classes.txt
190: *       passa a listar FormSIGOPSTC/SIGOPSTCBO sozinho na proxima abertura.
191: *       Quem abre esta tela chama GarantirClasse("FormSIGOPSTC") antes do
192: *       CREATEOBJECT.
193: *
194: *   VERIFICACAO DESTA FASE (2026-11-18), toda com arquivo de saida como prova
195: *     COMPILACAO PROVADA (automation\CompilarF8SigOpStc807.prg): o smoke test
196: *     do VFP9 desta sessao PASSOU, FormSIGOPSTC.FXP e SIGOPSTCBO.FXP foram
197: *     gerados e NENHUM .ERR - com CONTROLE NEGATIVO na mesma rodada (copia
198: *     deste form com "PUBLIC PROCEDURE", regra #9.1, colada no fim: .ERR
199: *     apontando SO as duas linhas acrescentadas), o que prova de uma vez que
200: *     o detector funciona E que este arquivo compila limpo.
201: *     RUNTIME PROVADO (automation\ProbeF8SigOpStc807.prg): instancia COM e
202: *     SEM form pai; os sete metodos chamados de fora sao PUBLIC
203: *     (PEMSTATUS(...,2) = .F. nos sete); os DOIS BINDEVENT estao REGISTRADOS
204: *     (AEVENTS: AFTERROWCOLCHANGE -> GRADEAFTERROWCOLCHANGE no grid e CLICK ->
205: *     BTNENCERRARCLICK no Buttons(1)); CarregarLista liga a grade
206: *     (RecordSource + os dois ControlSource + headers Data/Usuario + larguras
207: *     65/95 preservados depois do rebind), liga o Edit1 por ControlSource e
208: *     espelha os quatro Text (CAT0001.TXT / 778899 / 001 / IMPFISCAL01);
209: *     trocar a linha corrente e chamar GradeAfterRowColChange troca o Edit1
210: *     (1a -> 2a tentativa); BtnEncerrarClick libera o form e o Destroy fecha
211: *     o cursor; nenhum MsgErro/MsgAviso disparado no caminho inteiro.
212: *     As tabelas SigFiSit/SigFiSii estao VAZIAS em DB_MBAHIA (COUNT(*) = 0
213: *     nas duas, medido nesta data), entao o probe injeta um BO de teste que
214: *     so troca a ORIGEM das linhas e delega ao CarregarDoCursor REAL - a
215: *     consulta real nao tem o que exibir e nao serviria de prova.
216: *     ESTATICO, tudo com resultado ZERO: acento literal em .prg (regra #4),
217: *     "this_X .Value" (regra #43), RETURN dentro de TRY (regra #1),
218: *     MESSAGEBOX direto, ISEMPTY/MostrarAviso/.Self/Controls("nome")
219: *     (regras #2/#9.3/#38/#34), TTOD/TABLEREVERT/EVALUATE-que-atribui
220: *     (regras #16/#52/#15), chamada a nome nao resolvido
221: *     (VerificarFuncoesNaoDefinidas, regra #13), propriedade inexistente na
222: *     classe (VerificarPropriedadesInexistentes, regra #33), metodo PROTECTED
223: *     chamado de fora (regra #51), lookup em KeyPress (regra #47),
224: *     Format/InputMask faltando (regra #49), coluna invalida no SQL
225: *     (ValidadorSQLSchema, 683 tabelas lidas do schema canonico) e
226: *     Test-CompletudeCodigo (TODO/stub) nos dois arquivos.
227: *==============================================================================
228: 
229: DEFINE CLASS FormSIGOPSTC AS FormBase
230: 
231:     *==========================================================================
232:     * PROPRIEDADES VISUAIS - transcritas do SCX legado (PILAR 1)
233:     *==========================================================================
234: 
235:     this_cMensagemErro = ""
236: 
237:     *-- SIGOPSTC: Height = 600 / Width = 800
238:     Height       = 600
239:     Width        = 800
240: 
241:     *-- BorderStyle = 2 (Sizable) / AutoCenter = .T. - ambos ja sao default
242:     *-- do FormBase, repetidos aqui por transcricao explicita do SCX
243:     BorderStyle  = 2
244:     AutoCenter   = .T.
245:     ShowTips     = .T.
246: 
247:     *-- Caption real do form (nunca exibido na tela - ver NOTA no
248:     *-- cabecalho deste arquivo: os labels do cabecalho usam literal
249:     *-- "Cadastro de Testes", nao THIS.Caption)
250:     Caption      = "Status da transmiss" + CHR(227) + "o do Arquivo Cat"
251: 

*-- Linhas 286 a 419:
286:     this_oFormPai = .NULL.
287: 
288:     *-- this_cArqMovsPai -> poForm.pcSelFile do legado, capturado em
289:     *-- InicializarForm. So e consumido pela Fase 5-6 (CarregarSituacao),
290:     *-- mas a captura acontece aqui porque depende so do form pai, nao de
291:     *-- nenhum controle criado nas fases seguintes
292:     this_cArqMovsPai = ""
293: 
294:     *==========================================================================
295:     * Init - LParameters poForm do legado
296:     *==========================================================================
297:     PROCEDURE Init
298:         LPARAMETERS par_oFormPai
299: 
300:         *-- Legado: Thisform.poForm = poForm
301:         IF VARTYPE(par_oFormPai) = "O"
302:             THIS.this_oFormPai = par_oFormPai
303:         ENDIF
304: 
305:         RETURN DODEFAULT()
306:     ENDPROC
307: 
308:     *==========================================================================
309:     * ValidarParametros - precondicao deste dialogo: sem form pai nao ha
310:     * como saber qual arquivo consultar (poForm.pcSelFile do legado).
311:     *
312:     * Metodo PUBLIC (regra #3): o harness de teste e o form pai o alcancam
313:     * de fora, e PROTECTED faria a chamada externa estourar em runtime.
314:     *
315:     * Bypass em modo teste/validacao de UI no TOPO: o ValidarUIFidelity e o
316:     * TesteAutomatico instanciam o form SEM ARGUMENTO NENHUM, e sem o
317:     * bypass a instanciacao reprovaria sempre.
318:     *
319:     * Os RETURN ficam FORA de TRY/CATCH (regra #1) - este metodo nao abre
320:     * bloco algum.
321:     *==========================================================================
322:     PROCEDURE ValidarParametros
323:         LOCAL loc_lValido
324:         loc_lValido = .T.
325: 
326:         IF TYPE("gb_4c_ModoTeste") = "L" AND gb_4c_ModoTeste
327:             RETURN .T.
328:         ENDIF
329: 
330:         IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
331:             RETURN .T.
332:         ENDIF
333: 
334:         IF VARTYPE(THIS.this_oFormPai) != "O"
335:             MsgErro("Esta tela s" + CHR(243) + " pode ser aberta a partir de " + ;
336:                     "outro formul" + CHR(225) + "rio.", ;
337:                     "Status da Transmiss" + CHR(227) + "o")
338:             loc_lValido = .F.
339:         ENDIF
340: 
341:         RETURN loc_lValido
342:     ENDPROC
343: 
344:     *==========================================================================
345:     * InicializarForm - estrutura base do dialogo
346:     *
347:     * Hook chamado pelo FormBase.Init. Retorna .T. em sucesso e .F. em falha
348:     * (nesse caso o CREATEOBJECT do chamador devolve logico, nao objeto).
349:     *==========================================================================
350:     PROTECTED PROCEDURE InicializarForm
351:         LOCAL loc_lSucesso, loc_oErro
352:         loc_lSucesso = .F.
353: 
354:         *-- Guarda de precondicao ANTES do TRY, para o RETURN nao ficar
355:         *-- dentro de TRY/CATCH (regra #1)
356:         IF !THIS.ValidarParametros()
357:             RETURN .F.
358:         ENDIF
359: 
360:         TRY
361:             *-- Business Object da Fase 1-2
362:             THIS.this_oBusinessObject = CREATEOBJECT("SIGOPSTCBO")
363: 
364:             IF VARTYPE(THIS.this_oBusinessObject) != "O"
365:                 MsgErro("Falha ao criar SIGOPSTCBO.", ;
366:                         "Status da Transmiss" + CHR(227) + "o")
367:             ELSE
368:                 *-- Legado: Thisform.poForm.pcSelFile - capturado aqui
369:                 *-- porque so depende do form pai (a Fase 5-6 consome este
370:                 *-- valor ao chamar CarregarSituacao)
371:                 *-- A guarda VARTYPE = "O" eh OBRIGATORIA antes do
372:                 *-- PEMSTATUS: medido no VFP9 em 2026-11-18,
373:                 *-- PEMSTATUS(.NULL., "x", 5) SOZINHO estoura "Function
374:                 *-- argument value, type, or count is invalid." (erro 11) -
375:                 *-- VARTYPE(.NULL.) eh "X", nao "O". Na guarda combinada
376:                 *-- com AND o PEMSTATUS nao chega a ser avaliado e nao
377:                 *-- estoura. Sem ela, o form NAO INSTANCIA quando nao ha
378:                 *-- form pai (harness/ValidarUIFidelity): o erro cai no
379:                 *-- CATCH, InicializarForm devolve .F. e o CREATEOBJECT do
380:                 *-- chamador devolve logico
381:                 IF VARTYPE(THIS.this_oFormPai) = "O" AND ;
382:                    PEMSTATUS(THIS.this_oFormPai, "pcSelFile", 5)
383:                     THIS.this_cArqMovsPai = TratarNulo(THIS.this_oFormPai.pcSelFile, "")
384:                 ENDIF
385: 
386:                 *-- Legado: Thisform.DataSessionId = poForm.DataSessionId -
387:                 *-- so documentado (ver NOTA no cabecalho deste arquivo);
388:                 *-- DataSessionID eh READ-ONLY em runtime, nunca reatribuida
389:                 IF VARTYPE(THIS.this_oFormPai) = "O" AND ;
390:                    PEMSTATUS(THIS.this_oFormPai, "DataSessionId", 5)
391:                     THIS.this_oBusinessObject.this_nDataSessionPai = ;
392:                         THIS.this_oFormPai.DataSessionId
393:                 ENDIF
394: 
395:                 *-- Fundo do form (Picture do SCX)
396:                 THIS.ConfigurarDecoracao()
397: 
398:                 *-- Cabecalho cinza (cntSombra do legado). PRIMEIRO
399:                 *-- AddObject do form: o Commandgroup1 da Fase 4 fica em
400:                 *-- Top = -2, DENTRO da faixa (Top 0..80), e precisa ser
401:                 *-- criado depois para desenhar por cima (regra #11)
402:                 THIS.ConfigurarCabecalho()
403: 
404:                 *-- Shape1 (moldura do corpo) e Label1 ("Arquivo :").
405:                 *-- Criados antes da grade e dos botoes, na ordem do SCX
406:                 THIS.ConfigurarMoldura()
407: 
408:                 *-- Grid1 -> grd_4c_Dados (uma linha por tentativa de envio)
409:                 THIS.ConfigurarGrade()
410: 
411:                 *-- Commandgroup1 (botao "Encerrar"). Vem DEPOIS do
412:                 *-- cabecalho porque fica em Top = -2..82, dentro da faixa
413:                 *-- cinza (Top 0..80), e so desenha por cima dela se for
414:                 *-- criado depois (regra #11)
415:                 THIS.ConfigurarBotoes()
416: 
417:                 *-- Text1 (arquivo), Label2 + Text2 (lote) e Label3 + Text3
418:                 *-- (empresa): o cabecalho do arquivo consultado. Criados
419:                 *-- DEPOIS do grupo de botoes, na ordem do SCX, sem risco de

*-- Linhas 428 a 547:
428:                 THIS.ConfigurarCampoRetorno()
429: 
430:                 *-- AddObject cria controle com Visible = .F.
431:                 THIS.TornarControlesVisiveis()
432: 
433:                 *-- BINDEVENT do AfterRowColChange do Grid. Depois de TODOS
434:                 *-- os AddObject: BINDEVENT com alvo inexistente estoura no
435:                 *-- proprio bind
436:                 THIS.ConfigurarEventos()
437: 
438:                 *-- Funil de carga: executa a consulta do Init legado e liga
439:                 *-- a grade ao cursor. Devolve .F. sem arquivo/conexao
440:                 *-- (caminho normal do harness), o que NAO impede a abertura
441:                 THIS.CarregarLista()
442: 
443:                 *-- Legado: This.Refresh (ultima linha do Init)
444:                 THIS.Refresh()
445: 
446:                 loc_lSucesso = .T.
447:             ENDIF
448: 
449:         CATCH TO loc_oErro
450:             THIS.this_cMensagemErro = loc_oErro.Message
451:             MsgErro("Erro ao inicializar FormSIGOPSTC: " + loc_oErro.Message + ;
452:                     " | Linha: " + TRANSFORM(loc_oErro.LineNo) + ;
453:                     " | Proc: " + loc_oErro.Procedure, "Erro")
454:             loc_lSucesso = .F.
455:         ENDTRY
456: 
457:         RETURN loc_lSucesso
458:     ENDPROC
459: 
460:     *==========================================================================
461:     * ConfigurarDecoracao - Picture do form (new_background.jpg do legado)
462:     *==========================================================================
463:     PROTECTED PROCEDURE ConfigurarDecoracao
464:         LOCAL loc_cImagemFundo
465:         loc_cImagemFundo = ""
466: 
467:         IF TYPE("gc_4c_CaminhoIcones") = "C"
468:             loc_cImagemFundo = gc_4c_CaminhoIcones + "new_background.jpg"
469:         ENDIF
470: 
471:         IF !EMPTY(loc_cImagemFundo) AND FILE(loc_cImagemFundo)
472:             THIS.Picture = loc_cImagemFundo
473:         ENDIF
474:     ENDPROC
475: 
476:     *==========================================================================
477:     * ConfigurarCabecalho - faixa cinza do topo (cntSombra do legado)
478:     *
479:     * Legado:
480:     *   cntSombra  Top=0  Left=0  Width=1100  Height=80  BorderWidth=0
481:     *              BackColor=100,100,100
482:     *   lblSombra  Top=18 Left=10 Width=769 Height=40 ForeColor=0,0,0
483:     *              Tahoma 18 bold, FontUnderline=.F., WordWrap=.T.,
484:     *              Alignment=0, BackStyle=0, Caption="Cadastro de Testes"
485:     *   lblTitulo  Top=17 Left=10 Width=769 Height=46 ForeColor=255,255,255
486:     *              Tahoma 18 bold, WordWrap=.T., Alignment=0, BackStyle=0,
487:     *              Caption="Cadastro de Testes"
488:     *
489:     * Caption LITERAL "Cadastro de Testes" nos dois labels - NAO dinamico
490:     * (THIS.Caption) - ver NOTA extensa no cabecalho deste arquivo: o Init
491:     * legado desta tela (diferente dos irmaos FormSigOpSpr/FormSigOpSlc)
492:     * nunca copia ThisForm.Caption para os labels, entao o usuario nunca
493:     * ve "Status da transmissao do Arquivo Cat" em lugar nenhum da tela.
494:     * Transcrito literal (regra #17 do CLAUDE.md).
495:     *
496:     * Width do container usa THIS.Width (canonico da faixa, regra #11) em
497:     * vez do literal 1100 do dump - aquele valor eh MAIOR que o Width do
498:     * proprio form (800) e deixaria a faixa recortada/cortada pelo form;
499:     * THIS.Width tambem acompanha o form se o layout mudar numa fase
500:     * futura.
501:     *
502:     * AutoSize = .F. explicito nos dois labels: com WordWrap = .T. o
503:     * AutoSize DESCARTA a Height e colapsa o texto para uma linha (regra
504:     * #23), e os 40/46 do dump sao o tamanho ja calculado pelo Form
505:     * Designer.
506:     *==========================================================================
507:     PROTECTED PROCEDURE ConfigurarCabecalho
508:         *-- Container da faixa (cntSombra)
509:         THIS.AddObject("cnt_4c_Sombra", "Container")
510:         WITH THIS.cnt_4c_Sombra
511:             .Top           = 0
512:             .Left          = 0
513:             .Width         = THIS.Width
514:             .Height        = 80
515:             .BorderWidth   = 0
516:             .BackStyle     = 1
517:             .BackColor     = RGB(100, 100, 100)
518:             .SpecialEffect = 0
519:             .Visible       = .T.
520:         ENDWITH
521: 
522:         *-- lblSombra: copia preta deslocada 1px, para dar profundidade ao
523:         *-- titulo. Criada ANTES do lblTitulo para ficar por baixo dele
524:         THIS.cnt_4c_Sombra.AddObject("lbl_4c_LblSombra", "Label")
525:         WITH THIS.cnt_4c_Sombra.lbl_4c_LblSombra
526:             .AutoSize      = .F.
527:             .FontBold      = .T.
528:             .FontName      = "Tahoma"
529:             .FontSize      = 18
530:             .FontUnderline = .F.
531:             .WordWrap      = .T.
532:             .Alignment     = 0
533:             .BackStyle     = 0
534:             .Caption       = "Cadastro de Testes"
535:             .Top           = 18
536:             .Left          = 10
537:             .Width         = 769
538:             .Height        = 40
539:             .ForeColor     = RGB(0, 0, 0)
540:             .Rotation      = 0
541:             .Visible       = .T.
542:         ENDWITH
543: 
544:         *-- lblTitulo: titulo branco sobre a faixa cinza. Branco eh correto
545:         *-- aqui porque o container eh OPACO e escuro (excecao prevista na
546:         *-- regra #12)
547:         THIS.cnt_4c_Sombra.AddObject("lbl_4c_LblTitulo", "Label")

*-- Linhas 593 a 636:
593:     * O Shape eh criado ANTES do label (ordem do SCX): mesmo transparente
594:     * (BackStyle = 0), quem vem depois desenha por cima.
595:     *==========================================================================
596:     PROTECTED PROCEDURE ConfigurarMoldura
597:         *-- Shape1 -> shp_4c_Shape1 (moldura em volta do corpo da tela)
598:         THIS.AddObject("shp_4c_Shape1", "Shape")
599:         WITH THIS.shp_4c_Shape1
600:             .Top         = 135
601:             .Left        = 62
602:             .Width       = 676
603:             .Height      = 387
604:             .BackStyle   = 0
605:             .BorderColor = RGB(90, 90, 90)
606:             .Visible     = .T.
607:         ENDWITH
608: 
609:         *-- Label1 -> lbl_4c_Label1 ("Arquivo :", rotulo do Text1 que entra
610:         *-- na fase seguinte)
611:         THIS.AddObject("lbl_4c_Label1", "Label")
612:         WITH THIS.lbl_4c_Label1
613:             .AutoSize  = .F.
614:             .FontName  = "Tahoma"
615:             .FontSize  = 8
616:             .BackStyle = 0
617:             .Caption   = "Arquivo :"
618:             .Top       = 144
619:             .Left      = 105
620:             .Width     = 46
621:             .Height    = 15
622:             .ForeColor = RGB(90, 90, 90)
623:             .Visible   = .T.
624:         ENDWITH
625:     ENDPROC
626: 
627:     *==========================================================================
628:     * ConfigurarGrade - Grid1 do legado -> grd_4c_Dados
629:     *
630:     * Eh a lista de TENTATIVAS DE ENVIO do arquivo (uma linha por registro de
631:     * SigFiSii), com duas colunas: a data do envio (b.tDtEnvs, apelidada
632:     * Envios) e o usuario (cUsuarios). Selecionar uma linha eh o que faz o
633:     * Edit1 da fase seguinte mostrar o retorno daquela tentativa.
634:     *
635:     * Transcricao do dump (SIGOPSTC.Grid1):
636:     *   ColumnCount=2  FontName="Tahoma"  FontSize=8  DeleteMark=.F.

*-- Linhas 661 a 704:
661:     * depois do RecordSource (atribuir RecordSource zera Column.Width e
662:     * Header1.Caption - Problema 48 / regra #41).
663:     *==========================================================================
664:     PROTECTED PROCEDURE ConfigurarGrade
665:         THIS.AddObject("grd_4c_Dados", "Grid")
666:         WITH THIS.grd_4c_Dados
667:             .ColumnCount = 2
668:             .FontName    = "Tahoma"
669:             .FontSize    = 8
670:             .DeleteMark  = .F.
671:             .RecordMark  = .F.
672:             .RowHeight   = 18
673:             .ScrollBars  = 2
674:             .Top         = 201
675:             .Left        = 69
676:             .Width       = 192
677:             .Height      = 312
678:             .HeaderHeight       = 0
679:             .Visible     = .T.
680:         ENDWITH
681: 
682:         THIS.AplicarFormatoGrade()
683:     ENDPROC
684: 
685:     *==========================================================================
686:     * AplicarFormatoGrade - FONTE UNICA da geometria/decoracao das colunas
687:     *
688:     * Transcricao do dump:
689:     *   Column1  Width=65  Movable=.F.  Resizable=.F.  ReadOnly=.T.
690:     *            FontName="Tahoma"  FontSize=8
691:     *            Header1: Tahoma 8, Alignment=2, Caption="Data",
692:     *                     ForeColor=36,84,155
693:     *            Text1:   Tahoma 8, BorderStyle=0, Margin=0, ReadOnly=.T.,
694:     *                     ForeColor=0,0,0, BackColor=255,255,255,
695:     *                     DisabledForeColor=0,0,0
696:     *   Column2  Width=95  Movable=.F.  Resizable=.F.  ReadOnly=.T.
697:     *            FontName="Tahoma"  FontSize=8
698:     *            Header1: Tahoma 8, Alignment=2, Caption="Usuario",
699:     *                     ForeColor=36,84,155
700:     *            Text1:   identico ao de Column1
701:     * Conferencia: 65 + 95 = 160, dentro dos Grid.Width = 192.
702:     *
703:     * Existe como metodo porque a grade eh formatada em DOIS momentos - na
704:     * montagem (ConfigurarGrade) e na carga (CarregarLista, depois do

*-- Linhas 713 a 756:
713:     * NAO existe em VFP9 (regra #38) - compila limpo e estoura "Property
714:     * SELF is not found" em runtime.
715:     *==========================================================================
716:     PROCEDURE AplicarFormatoGrade
717:         LOCAL loc_lAplicou
718:         loc_lAplicou = .F.
719: 
720:         IF PEMSTATUS(THIS, "grd_4c_Dados", 5)
721:             WITH THIS.grd_4c_Dados
722:                 *-- Column1 - Envios (b.tDtEnvs: data/hora da tentativa)
723:                 .Column1.Width                     = 65
724:                 .Column1.Movable                   = .F.
725:                 .Column1.Resizable                 = .F.
726:                 .Column1.FontName                  = "Tahoma"
727:                 .Column1.FontSize                  = 8
728:                 .Column1.ReadOnly                  = .T.
729:                 .Column1.Header1.Caption           = "Data"
730:                 .Column1.Header1.FontName          = "Tahoma"
731:                 .Column1.Header1.FontSize          = 8
732:                 .Column1.Header1.Alignment         = 2
733:                 .Column1.Header1.ForeColor         = RGB(36, 84, 155)
734:                 .Column1.Text1.FontName            = "Tahoma"
735:                 .Column1.Text1.FontSize            = 8
736:                 .Column1.Text1.BorderStyle         = 0
737:                 .Column1.Text1.Margin              = 0
738:                 .Column1.Text1.ReadOnly            = .T.
739:                 .Column1.Text1.ForeColor           = RGB(0, 0, 0)
740:                 .Column1.Text1.BackColor           = RGB(255, 255, 255)
741:                 .Column1.Text1.DisabledForeColor   = RGB(0, 0, 0)
742: 
743:                 *-- Column2 - cUsuarios (usuario do cabecalho SigFiSit,
744:                 *-- repetido em toda linha pelo JOIN - ver o cabecalho de
745:                 *-- SIGOPSTCBO.prg: eh o que o legado produz e foi
746:                 *-- transcrito, nao corrigido)
747:                 .Column2.Width                     = 95
748:                 .Column2.Movable                   = .F.
749:                 .Column2.Resizable                 = .F.
750:                 .Column2.FontName                  = "Tahoma"
751:                 .Column2.FontSize                  = 8
752:                 .Column2.ReadOnly                  = .T.
753:                 .Column2.Header1.Caption           = "Usu" + CHR(225) + "rio"
754:                 .Column2.Header1.FontName          = "Tahoma"
755:                 .Column2.Header1.FontSize          = 8
756:                 .Column2.Header1.Alignment         = 2

*-- Linhas 808 a 851:
808:     * apontando para arquivo inexistente falha em SILENCIO (regra #25) - o
809:     * botao fica so com o texto, sem erro nenhum.
810:     *==========================================================================
811:     PROTECTED PROCEDURE ConfigurarBotoes
812:         LOCAL loc_cIconeSair
813:         loc_cIconeSair = ""
814: 
815:         IF TYPE("gc_4c_CaminhoIcones") = "C"
816:             loc_cIconeSair = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
817:         ENDIF
818: 
819:         THIS.AddObject("cmg_4c_Botoes", "CommandGroup")
820:         WITH THIS.cmg_4c_Botoes
821:             .ButtonCount = 1
822: 
823:             *-- Command2 do legado (Cancel = .T.: eh o botao do ESC)
824:             WITH .Buttons(1)
825:                 .Caption    = "Encerrar"
826:                 .Cancel     = .T.
827:                 .Top        = 5
828:                 .Left       = 5
829:                 .Width      = 75
830:                 .Height     = 75
831:                 .FontName   = "Comic Sans MS"
832:                 .FontSize   = 8
833:                 .FontBold   = .T.
834:                 .FontItalic = .T.
835:                 .WordWrap   = .T.
836:                 .ForeColor  = RGB(90, 90, 90)
837:                 .BackColor  = RGB(255, 255, 255)
838:                 .Themes     = .F.
839:                 .TabIndex   = 2
840: 
841:                 IF !EMPTY(loc_cIconeSair) AND FILE(loc_cIconeSair)
842:                     .Picture         = loc_cIconeSair
843:                     .DisabledPicture = loc_cIconeSair
844:                     .PicturePosition = 13
845:                 ENDIF
846: 
847:                 .Visible = .T.
848:             ENDWITH
849: 
850:             .AutoSize      = .T.
851:             .BackStyle     = 0

*-- Linhas 886 a 959:
886:     *           Top=172 Left=83 Width=68 Height=15 ForeColor=90,90,90
887:     *   Text4   Tahoma 8  Top=168 Left=153 Width=571 Height=23
888:     *
889:     * SOMENTE EXIBICAO: os quatro Text tem PROCEDURE When -> Return(.F.) no
890:     * legado, isto eh, nunca recebem foco (o dialogo eh um visualizador, nao
891:     * grava nada). O equivalente canonico do projeto eh .ReadOnly = .T. +
892:     * .TabStop = .F. - NUNCA .Enabled = .F., que acinzentaria o texto,
893:     * enquanto o legado exibe o valor com a aparencia normal do fwget.
894:     *
895:     * Os labels ficam com AutoSize = .F. e Width/Height TRANSCRITOS: em
896:     * Label criado por AddObject o AutoSize eh no-op (a Width fica nos 100
897:     * do default) e pode descartar a Height (regra #23). Os 30x15 e 50x15 do
898:     * dump JA SAO o tamanho que o Form Designer calculou.
899:     *
900:     * Alignment NAO eh escrito em nenhum dos controles: o dump nao declara
901:     * nem nos labels (classe say: AutoSize/esquerda, regra #23) nem nos Text
902:     * (onde o default do VFP9 eh 3/Automatico, nao 0 - escrever 0 seria
903:     * mudar o alinhamento que o legado nao mexeu).
904:     *
905:     * ForeColor = RGB(90, 90, 90) nos labels eh o do dump e tambem o
906:     * canonico de label de dados (regra #12): branco ficaria INVISIVEL
907:     * sobre a Picture clara do form.
908:     *
909:     * MaxLength NAO eh escrito: o dump nao declara, e campo que nunca
910:     * recebe foco nao tem digitacao a limitar. As larguras das colunas em
911:     * docs\schema.sql (carqmovs char(12), cnumlotes char(10), cemps char(3),
912:     * cimpfabs char(20)) ficam registradas em SIGOPSTCBO.prg, que eh quem le
913:     * o banco.
914:     *
915:     * Cada label eh criado ANTES do Text que ele rotula (ordem do dump
916:     * dentro de cada par): label de caixa transparente criado depois
917:     * bloquearia o clique no campo (regra #23).
918:     *==========================================================================
919:     PROTECTED PROCEDURE ConfigurarCamposCabecalho
920:         *-- Text1 -> txt_4c_Text1 (carqmovs: o arquivo cuja transmissao esta
921:         *-- sendo consultada; rotulado pelo Label1 da Fase 4)
922:         THIS.AddObject("txt_4c_Text1", "TextBox")
923:         WITH THIS.txt_4c_Text1
924:             .FontName = "Tahoma"
925:             .FontSize = 8
926:             .Top      = 141
927:             .Left     = 153
928:             .Width    = 100
929:             .Height   = 23
930:             .Value    = ""
931:             .ReadOnly = .T.
932:             .TabStop  = .F.
933:             .Visible  = .T.
934:         ENDWITH
935: 
936:         *-- Label2 -> lbl_4c_Label2 ("Lote :", rotulo do Text2)
937:         THIS.AddObject("lbl_4c_Label2", "Label")
938:         WITH THIS.lbl_4c_Label2
939:             .AutoSize  = .F.
940:             .FontName  = "Tahoma"
941:             .FontSize  = 8
942:             .BackStyle = 0
943:             .Caption   = "Lote :"
944:             .Top       = 146
945:             .Left      = 373
946:             .Width     = 30
947:             .Height    = 15
948:             .ForeColor = RGB(90, 90, 90)
949:             .Visible   = .T.
950:         ENDWITH
951: 
952:         *-- Text2 -> txt_4c_Text2 (cnumlotes: numero do lote da transmissao)
953:         THIS.AddObject("txt_4c_Text2", "TextBox")
954:         WITH THIS.txt_4c_Text2
955:             .FontName = "Tahoma"
956:             .FontSize = 8
957:             .Top      = 142
958:             .Left     = 405
959:             .Width    = 100

*-- Linhas 1058 a 1268:
1058:     * dump SIM declara com ScrollBars = 2, fica lado a lado nos mesmos
1059:     * Top/Height (201/312), formando o par lista + detalhe.
1060:     *
1061:     * SOMENTE EXIBICAO: o legado tem PROCEDURE When -> Return(.F.) neste
1062:     * EditBox, igual aos quatro Text do cabecalho - o campo nunca recebe
1063:     * foco. Mesma conversao canonica usada em ConfigurarCamposCabecalho:
1064:     * .ReadOnly = .T. + .TabStop = .F., NUNCA .Enabled = .F. (que
1065:     * acinzentaria o texto do retorno, enquanto o legado o exibe com a
1066:     * aparencia normal).
1067:     *
1068:     * ControlSource NAO eh atribuido aqui: o legado so o liga DEPOIS da
1069:     * consulta (ThisForm.Edit1.ControlSource = [crTmpLgSit.cRetornos], na
1070:     * penultima linha do Init), e ligar a um alias que ainda nao existe
1071:     * derruba o Init. Medido no VFP9 em 2026-11-18
1072:     * (automation\p807c.prg): ControlSource apontando para alias FECHADO
1073:     * estoura "Erro 13 - Alias 'CRO' is not found." Quem liga eh
1074:     * CarregarLista, dentro da guarda USED() (regra #41).
1075:     *==========================================================================
1076:     PROTECTED PROCEDURE ConfigurarCampoRetorno
1077:         THIS.AddObject("edt_4c_Edit1", "EditBox")
1078:         WITH THIS.edt_4c_Edit1
1079:             .FontName = "Tahoma"
1080:             .FontSize = 8
1081:             .Top      = 201
1082:             .Left     = 260
1083:             .Width    = 470
1084:             .Height   = 312
1085:             .Value    = ""
1086:             .ReadOnly = .T.
1087:             .TabStop  = .F.
1088:             .Visible  = .T.
1089:         ENDWITH
1090:     ENDPROC
1091: 
1092:     *==========================================================================
1093:     * ConfigurarEventos - liga os eventos do legado aos handlers do form.
1094:     *
1095:     * Chamado no FIM do InicializarForm, depois de TODOS os AddObject: um
1096:     * BINDEVENT com delegate ou alvo inexistente estoura no proprio bind.
1097:     *
1098:     * Sao DOIS os eventos do legado a ligar: o Grid1.AfterRowColChange (o
1099:     * unico evento de DADO) e o Click do unico botao (Fase 7).
1100:     *
1101:     * O evento de dado eh o que o legado usa para refazer o Edit1 ao trocar
1102:     * de linha:
1103:     *
1104:     *     PROCEDURE AfterRowColChange
1105:     *     LPARAMETERS nColIndex
1106:     *     ThisForm.Edit1.Value = crTmpLgSit.cRetornos
1107:     *     ThisForm.Edit1.Refresh
1108:     *
1109:     * O evento de BOTAO eh o Click do membro do Commandgroup1:
1110:     *
1111:     *     PROCEDURE Command2.Click
1112:     *     ThisForm.Release
1113:     *
1114:     * O alvo do BINDEVENT eh Buttons(1), NAO o grupo: o dump mostra
1115:     * "Command1.Name = "Command2"" no bloco de propriedades do
1116:     * Commandgroup1, isto eh, o unico membro do grupo (ButtonCount = 1) foi
1117:     * RENOMEADO para "Command2" - logo o "PROCEDURE Command2.Click" da secao
1118:     * de metodos eh o Click DESSE botao, e nao codigo morto de um segundo
1119:     * botao que teria sido removido. Com o Click no proprio botao, ligar o
1120:     * handler ao grupo nao receberia o evento.
1121:     *
1122:     * O unico metodo do dump que NAO vira BINDEVENT sao os cinco PROCEDURE
1123:     * When -> Return(.F.) (Edit1/Text1..Text4), ja convertidos em
1124:     * .ReadOnly = .T. + .TabStop = .F. nos proprios controles - um When
1125:     * ligado por BINDEVENT nao bloquearia nada, porque o BINDEVENT DESCARTA
1126:     * o retorno do delegate.
1127:     *
1128:     * NAO existe lookup nesta tela para ligar: conferido no dump inteiro
1129:     * (tasks\task807\SIGOPSTC_form_codigo_fonte.txt), nao ha fwBuscaExt /
1130:     * fwBuscaSel / fwBuscaInt / sigacess() / AcessoEmpresa() / mAddColuna
1131:     * em lugar algum, e nenhum campo tem PROCEDURE Valid. Nem poderia
1132:     * haver: TODO campo desta tela eh somente-leitura (When -> .F.), e
1133:     * campo que nunca recebe foco nao tem onde digitar o codigo que abriria
1134:     * o picker. Inventar um FormBuscaAuxiliar aqui violaria o PILAR 1 e a
1135:     * regra "NUNCA inventar tabelas de lookup que nao existem no original".
1136:     *==========================================================================
1137:     PROTECTED PROCEDURE ConfigurarEventos
1138:         IF PEMSTATUS(THIS, "grd_4c_Dados", 5)
1139:             BINDEVENT(THIS.grd_4c_Dados, "AfterRowColChange", ;
1140:                       THIS, "GradeAfterRowColChange")
1141:         ENDIF
1142: 
1143:         *-- Legado: PROCEDURE Command2.Click -> ThisForm.Release (o membro
1144:         *-- Buttons(1) do Commandgroup1, renomeado para "Command2" no SCX)
1145:         IF PEMSTATUS(THIS, "cmg_4c_Botoes", 5)
1146:             IF THIS.cmg_4c_Botoes.ButtonCount >= 1
1147:                 BINDEVENT(THIS.cmg_4c_Botoes.Buttons(1), "Click", ;
1148:                           THIS, "BtnEncerrarClick")
1149:             ENDIF
1150:         ENDIF
1151:     ENDPROC
1152: 
1153:     *==========================================================================
1154:     * GradeAfterRowColChange - handler do Grid1.AfterRowColChange legado.
1155:     *
1156:     * Metodo PUBLIC (regra #3): BINDEVENT com metodo PROTECTED falha em
1157:     * SILENCIO - o evento nunca chegaria ao handler e o painel de retorno
1158:     * ficaria congelado na primeira linha, sem erro nenhum na tela.
1159:     *
1160:     * par_nColIndex eh declarado porque AfterRowColChange PASSA esse
1161:     * argumento (regra #3: handler sem o parametro estoura a cada troca de
1162:     * celula). Ele NAO eh usado para filtrar: o legado tambem nao filtra, e
1163:     * aqui o filtro seria errado - mestre-detalhe reage a troca de LINHA, e
1164:     * a coluna que recebeu o foco eh irrelevante. Esse eh justamente o uso
1165:     * CORRETO de AfterRowColChange (regra #46, que proibe o contrario:
1166:     * validar CELULA aqui, no lugar do Valid do TextBox da coluna).
1167:     *
1168:     * O corpo todo delega para AtualizarDetalheRetorno, a fonte unica que
1169:     * CarregarLista tambem usa - assim a primeira exibicao (logo depois da
1170:     * consulta) e a troca de linha nao podem divergir.
1171:     *==========================================================================
1172:     PROCEDURE GradeAfterRowColChange(par_nColIndex)
1173:         RETURN THIS.AtualizarDetalheRetorno()
1174:     ENDPROC
1175: 
1176:     *==========================================================================
1177:     * AtualizarDetalheRetorno - FONTE UNICA do painel de retorno (Edit1).
1178:     * Transcreve as duas linhas do AfterRowColChange legado:
1179:     *
1180:     *     ThisForm.Edit1.Value = crTmpLgSit.cRetornos
1181:     *     ThisForm.Edit1.Refresh
1182:     *
1183:     * O cursor eh alcancado por EVALUATE porque o nome do alias vem de
1184:     * ObterCursorEnvios (fonte unica), nao de um literal - e EVALUATE eh a
1185:     * forma certa para LEITURA por nome montado (regra #15).
1186:     *
1187:     * As duas linhas sao transcritas LITERALMENTE, e isso foi MEDIDO antes
1188:     * de decidir (automation\p807b.prg / p807c.prg, VFP9, 2026-11-18),
1189:     * porque atribuir .Value a controle com ControlSource ligado eh uma
1190:     * ESCRITA de volta no cursor:
1191:     *
1192:     *   cursor GRAVAVEL   .Value = <outro texto>  -> o CURSOR muda tambem
1193:     *   cursor READ-ONLY  .Value = <outro texto>  -> .Value muda, cursor NAO
1194:     *                                                (escrita descartada, sem erro)
1195:     *   cursor READ-ONLY  .Value = <o proprio campo> -> OK, sem erro
1196:     *   cursor READ-ONLY  Refresh() apos SKIP     -> .Value segue a linha corrente
1197:     *
1198:     * O cursor desta tela vem de SQLEXEC (somente-leitura: REPLACE nele da
1199:     * "Erro 111 - Cannot update the cursor, since it is read-only"), e a
1200:     * linha do legado atribui ao campo O PROPRIO VALOR DELE - logo nao ha
1201:     * escrita efetiva nem erro, e o Refresh seguinte reafirma o valor a
1202:     * partir do ControlSource. Transcrever as duas linhas eh seguro E fiel
1203:     * (regra #17), sem precisar "simplificar" para so o Refresh.
1204:     *
1205:     * Metodo PUBLIC (regra #3): o harness de teste e o GradeAfterRowColChange
1206:     * o alcancam, e PROTECTED faria a chamada externa estourar em runtime
1207:     * com "Property ATUALIZARDETALHERETORNO is not found".
1208:     *
1209:     * Sem o controle criado (chamada de fora antes do InicializarForm
1210:     * terminar, ou depois de um Init que falhou) ou sem o cursor aberto
1211:     * (harness sem conexao) nao ha o que exibir: devolve .F. sem tocar em
1212:     * nada. A guarda cobre o ALIAS, NAO o EOF, e nao envolve o valor em
1213:     * TratarNulo - os dois casos foram medidos no VFP9 em 2026-11-18
1214:     * (automation\p807d.prg), com cursor de coluna NULL igual ao do banco
1215:     * (SigFiSii.cretornos eh text NULL):
1216:     *
1217:     *   campo .NULL.  -> .Value fica .NULL. (VARTYPE "X") SEM erro, e a
1218:     *                    tela mostra BRANCO, porque NullDisplay eh ""
1219:     *   em EOF        -> ler o campo devolve o valor vazio da coluna, e
1220:     *                    tanto a atribuicao quanto o Refresh() passam
1221:     *
1222:     * Logo nao ha erro a prevenir: guardar o EOF deixaria o painel exibindo
1223:     * o retorno da linha ANTERIOR (o legado nao tem guarda alguma), e
1224:     * aplicar TratarNulo seria divergir do legado a troco de nada - o
1225:     * Refresh seguinte reafirma o valor a partir do ControlSource e
1226:     * desfaria a substituicao.
1227:     *==========================================================================
1228:     PROCEDURE AtualizarDetalheRetorno
1229:         LOCAL loc_lAtualizou, loc_cCursor
1230:         loc_lAtualizou = .F.
1231:         loc_cCursor    = THIS.ObterCursorEnvios()
1232: 
1233:         IF PEMSTATUS(THIS, "edt_4c_Edit1", 5) AND USED(loc_cCursor)
1234:             *-- Legado: ThisForm.Edit1.Value = crTmpLgSit.cRetornos
1235:             THIS.edt_4c_Edit1.Value = EVALUATE(loc_cCursor + ".cretornos")
1236: 
1237:             *-- Legado: ThisForm.Edit1.Refresh
1238:             THIS.edt_4c_Edit1.Refresh()
1239: 
1240:             loc_lAtualizou = .T.
1241:         ENDIF
1242: 
1243:         RETURN loc_lAtualizou
1244:     ENDPROC
1245: 
1246:     *==========================================================================
1247:     * AtualizarCabecalho - espelha as properties do BO nos campos de
1248:     * exibicao do cabecalho. Transcreve as atribuicoes do Init legado:
1249:     *
1250:     *     ThisForm.Text1.Value = crTmpLgSit.cArqMovs
1251:     *     ThisForm.Text2.Value = crTmpLgSit.cNumLotes
1252:     *     ThisForm.Text3.Value = crTmpLgSit.cEmps
1253:     *     ThisForm.Text4.Value = crTmpLgSit.cImpFabs
1254:     *
1255:     * O legado le o CURSOR direto; aqui a leitura do cursor ja aconteceu em
1256:     * SIGOPSTCBO.CarregarDoCursor (chamado por CarregarSituacao), que
1257:     * guardou cada coluna na property correspondente - FONTE UNICA desses
1258:     * valores, que nenhum outro ponto do form reconsulta.
1259:     *
1260:     * Chamado pelo funil CarregarLista logo depois da consulta, no mesmo
1261:     * ponto em que o legado faz as atribuicoes. Como os campos nao tem
1262:     * ControlSource (nem no legado), a copia nao se refaz sozinha: quem
1263:     * recarregar o cursor tem de passar por este metodo.
1264:     *
1265:     * ALLTRIM porque as colunas sao char() de largura fixa e vem com o
1266:     * padding do banco - em campo de exibicao alinhado a esquerda o efeito
1267:     * visual eh identico ao do legado, sem espaco pendurado no fim.
1268:     *

*-- Linhas 1277 a 1497:
1277:     * A guarda cobre os QUATRO campos de uma vez porque eles sao criados
1278:     * juntos, no mesmo ConfigurarCamposCabecalho - nao existe estado em que
1279:     * um exista e os outros nao. Ela eh necessaria porque este metodo eh
1280:     * PUBLIC: chamado de fora antes do InicializarForm terminar (ou depois
1281:     * de um Init que falhou), o acesso a membro inexistente estouraria.
1282:     *
1283:     * O Edit1 NAO entra aqui: ele nao exibe o cabecalho de SigFiSit (igual
1284:     * em toda linha), e sim o cretornos da linha CORRENTE do grid - quem o
1285:     * atualiza eh AtualizarDetalheRetorno, chamado tambem pelo
1286:     * AfterRowColChange.
1287:     *==========================================================================
1288:     PROCEDURE AtualizarCabecalho
1289:         LOCAL loc_lAtualizou, loc_oBO
1290:         loc_lAtualizou = .F.
1291: 
1292:         IF VARTYPE(THIS.this_oBusinessObject) = "O" AND ;
1293:            PEMSTATUS(THIS, "txt_4c_Text1", 5)
1294: 
1295:             loc_oBO = THIS.this_oBusinessObject
1296: 
1297:             *-- carqmovs -> Text1 (arquivo)
1298:             THIS.txt_4c_Text1.Value = ALLTRIM(TratarNulo(loc_oBO.this_cCArqMovs, ""))
1299: 
1300:             *-- cnumlotes -> Text2 (lote)
1301:             THIS.txt_4c_Text2.Value = ALLTRIM(TratarNulo(loc_oBO.this_cCNumLotes, ""))
1302: 
1303:             *-- cemps -> Text3 (empresa)
1304:             THIS.txt_4c_Text3.Value = ALLTRIM(TratarNulo(loc_oBO.this_cCEmps, ""))
1305: 
1306:             *-- cimpfabs -> Text4 (impressora fiscal)
1307:             THIS.txt_4c_Text4.Value = ALLTRIM(TratarNulo(loc_oBO.this_cCImpFabs, ""))
1308: 
1309:             *-- Legado: ThisForm.Refresh no fim do Init - repintar o campo
1310:             *-- depois de trocar o .Value, senao a tela pode seguir
1311:             *-- exibindo o valor anterior
1312:             THIS.txt_4c_Text1.Refresh()
1313:             THIS.txt_4c_Text2.Refresh()
1314:             THIS.txt_4c_Text3.Refresh()
1315:             THIS.txt_4c_Text4.Refresh()
1316: 
1317:             loc_lAtualizou = .T.
1318:         ENDIF
1319: 
1320:         RETURN loc_lAtualizou
1321:     ENDPROC
1322: 
1323:     *==========================================================================
1324:     * BtnEncerrarClick - Click do UNICO botao da tela ("Encerrar"), ligado
1325:     * por BINDEVENT em ConfigurarEventos ao Buttons(1) do cmg_4c_Botoes.
1326:     *
1327:     * Transcricao integral do legado (SIGOPSTC.Commandgroup1):
1328:     *
1329:     *     PROCEDURE Command2.Click
1330:     *     ThisForm.Release
1331:     *
1332:     * Eh a UNICA saida deste dialogo: o form tem TitleBar = 0 e
1333:     * ControlBox = .F. (-> Closable = .F.), entao nao ha X de janela nem
1334:     * menu de sistema para fechar. O botao tambem eh o do ESC
1335:     * (Buttons(1).Cancel = .T., transcrito do dump), e nesse caminho o VFP9
1336:     * dispara o MESMO Click - por isso ha um handler so para as duas formas
1337:     * de encerrar, sem duplicar comportamento.
1338:     *
1339:     * NAO ha nada a confirmar nem a gravar antes de fechar: esta tela eh um
1340:     * visualizador puro (os cinco campos tem When -> Return(.F.) no legado,
1341:     * nenhum aceita digitacao, e SIGOPSTCBO nao sobrescreve
1342:     * Inserir/Atualizar/ExecutarExclusao). Por isso o legado nao tem botao
1343:     * de Confirmar/Cancelar e este handler nao faz pergunta nenhuma ao
1344:     * usuario - acrescentar um MsgConfirma aqui seria inventar
1345:     * comportamento que o legado nao tem (PILAR 1).
1346:     *
1347:     * O fechamento do cursor de envios NAO eh repetido aqui: quem fecha eh o
1348:     * Destroy, pelo nome que ObterCursorEnvios resolve, e o THIS.Release()
1349:     * passa por ele. Fechar tambem neste ponto criaria uma segunda fonte
1350:     * para a mesma limpeza, com os dois caminhos livres para divergir; e o
1351:     * Destroy continua sendo necessario de qualquer forma, porque cobre
1352:     * tambem a destruicao do form sem passar por este botao.
1353:     *
1354:     * Sem TRY/CATCH de proposito: o metodo tem uma chamada so, que nao vai
1355:     * ao banco nem a cursor nenhum. Envolve-lo num TRY so criaria o risco da
1356:     * regra #1 (RETURN dentro de TRY/CATCH) sem nada a tratar - e, se o
1357:     * Release falhasse, engolir o erro deixaria o usuario preso numa tela
1358:     * sem outra saida.
1359:     *
1360:     * Metodo PUBLIC (regra #3): eh alvo de BINDEVENT - delegate PROTECTED
1361:     * falha em SILENCIO, e o botao Encerrar deixaria de fechar a tela sem
1362:     * erro nenhum - e o harness de teste tambem o chama de fora da classe.
1363:     *
1364:     * O retorno .T. existe para o harness: o BINDEVENT descarta o retorno do
1365:     * delegate.
1366:     *==========================================================================
1367:     PROCEDURE BtnEncerrarClick
1368:         *-- Legado: ThisForm.Release
1369:         THIS.Release()
1370: 
1371:         RETURN .T.
1372:     ENDPROC
1373: 
1374:     *==========================================================================
1375:     * ObterCursorEnvios - nome do alias da consulta (crTmpLgSit do legado).
1376:     *
1377:     * FONTE UNICA do nome: quem manda eh a property do BO
1378:     * (this_cCursorEnvios); o literal "cursor_4c_Envios" fica so como
1379:     * fallback para quando o BO ainda nao existe (form instanciado sem
1380:     * conexao pelo harness, ou Destroy depois de um Init que falhou).
1381:     *
1382:     * Metodo PUBLIC (regra #3): a fase seguinte e o harness o chamam de fora
1383:     * da classe.
1384:     *==========================================================================
1385:     PROCEDURE ObterCursorEnvios
1386:         LOCAL loc_cCursor
1387:         loc_cCursor = "cursor_4c_Envios"
1388: 
1389:         IF VARTYPE(THIS.this_oBusinessObject) = "O" AND ;
1390:            PEMSTATUS(THIS.this_oBusinessObject, "this_cCursorEnvios", 5)
1391:             IF !EMPTY(THIS.this_oBusinessObject.this_cCursorEnvios)
1392:                 loc_cCursor = ALLTRIM(THIS.this_oBusinessObject.this_cCursorEnvios)
1393:             ENDIF
1394:         ENDIF
1395: 
1396:         RETURN loc_cCursor
1397:     ENDPROC
1398: 
1399:     *==========================================================================
1400:     * CarregarLista - FUNIL de carga da grade. Transcreve o bloco do Init
1401:     * legado que consulta a situacao do arquivo e liga a grade ao cursor.
1402:     *
1403:     * NOME CANONICO (Fase 8, 2026-11-18): este metodo nasceu na Fase 4 como
1404:     * CarregarDados e foi renomeado para CarregarLista, o nome canonico do
1405:     * projeto para o metodo que popula a GRADE. Nao eh acomodacao a
1406:     * validador: esta tela TEM lista (Grid1) e popula-la eh justamente o
1407:     * trecho final do Init legado, entao o nome canonico descreve
1408:     * exatamente o que o metodo faz - e o PILAR 3 manda nomes diferentes do
1409:     * legado de qualquer forma. A renomeacao foi conferida em TODO o
1410:     * projeto antes de ser aplicada: nenhum outro arquivo (menu.prg,
1411:     * TesteAutomatico, probes de automation\) chamava CarregarDados deste
1412:     * form, entao nao ha call site externo a atualizar.
1413:     *
1414:     * O bloco transcrito do Init legado:
1415:     *
1416:     *     lcSelect = [Select a.*, b.*, b.tDtEnvs As Envios From SigFiSit a
1417:     *                 Inner Join SigFiSii b On a.cArqMovs = b.cArqMovs
1418:     *                 Where a.cArqMovs = '] + ThisForm.poForm.pcSelFile + [']
1419:     *     ThisForm.poForm.poDataMgr.SqlExecute(lcSelect, [crTmpLgSit])
1420:     *     ...
1421:     *     ThisForm.Grid1.RecordSource          = [crTmpLgSit]
1422:     *     ThisForm.Grid1.Column1.ControlSource = [crTmpLgSit.Envios]
1423:     *     ThisForm.Grid1.Column2.ControlSource = [crTmpLgSit.cUsuarios]
1424:     *
1425:     * A consulta mora em SIGOPSTCBO.CarregarSituacao (camada de dados), que
1426:     * tambem preenche as properties do cabecalho via CarregarDoCursor - sao
1427:     * elas que AtualizarCabecalho espelha em Text1..Text4. O Edit1 nao
1428:     * passa por property nenhuma: ele eh ligado por ControlSource ao
1429:     * cretornos da linha corrente, exatamente como no Init legado, e
1430:     * AtualizarDetalheRetorno faz a primeira exibicao.
1431:     *
1432:     * O arquivo consultado eh o this_cArqMovsPai, capturado de
1433:     * poForm.pcSelFile no InicializarForm. SEM arquivo nao ha consulta a
1434:     * fazer: devolve .F. de imediato, sem ir ao banco - eh o caminho normal
1435:     * do harness, que instancia o form sem form pai.
1436:     *
1437:     * Sem o cursor aberto o binding NAO eh aplicado: atribuir RecordSource
1438:     * de alias inexistente derruba o Init (regra #41).
1439:     *
1440:     * ColumnCount e RecordSource ficam FORA do WITH do Grid, para nao
1441:     * dividir bloco com o acesso a .Column1/.Column2. Reatribuir o MESMO
1442:     * ColumnCount nao recria as Column, e nao ha controle posto por
1443:     * Column.AddObject nesta grade a perder.
1444:     *
1445:     * Fecha com GO TOP + Refresh (regra #21a): popular/ligar cursor NAO
1446:     * repinta a grade sozinho - sem isso a grade fica visualmente vazia com
1447:     * o cursor cheio, e o diagnostico vai para o SQL.
1448:     *
1449:     * Metodo PUBLIC (regra #3): o harness de teste o chama de FORA da
1450:     * classe, sem argumento, e PROTECTED faria a chamada estourar em runtime
1451:     * com "Property CARREGARDADOS is not found".
1452:     *
1453:     * Nao ha RETURN dentro de TRY/CATCH (regra #1): as guardas ficam ANTES
1454:     * do TRY, o resultado sai por flag e o unico RETURN do bloco vem depois
1455:     * do ENDTRY.
1456:     *==========================================================================
1457:     PROCEDURE CarregarLista
1458:         LOCAL loc_lCarregou, loc_cCursor, loc_cArquivo, loc_oErro
1459:         loc_lCarregou = .F.
1460:         loc_cCursor   = THIS.ObterCursorEnvios()
1461:         loc_cArquivo  = ALLTRIM(THIS.this_cArqMovsPai)
1462: 
1463:         IF !PEMSTATUS(THIS, "grd_4c_Dados", 5)
1464:             RETURN .F.
1465:         ENDIF
1466: 
1467:         IF VARTYPE(THIS.this_oBusinessObject) != "O"
1468:             RETURN .F.
1469:         ENDIF
1470: 
1471:         *-- Legado: o filtro eh ThisForm.poForm.pcSelFile. Sem ele nao ha
1472:         *-- arquivo cuja transmissao consultar
1473:         IF EMPTY(loc_cArquivo)
1474:             RETURN .F.
1475:         ENDIF
1476: 
1477:         TRY
1478:             IF THIS.this_oBusinessObject.CarregarSituacao(loc_cArquivo) AND ;
1479:                USED(loc_cCursor)
1480: 
1481:                 SELECT (loc_cCursor)
1482:                 GO TOP
1483: 
1484:                 THIS.grd_4c_Dados.ColumnCount  = 2
1485:                 THIS.grd_4c_Dados.RecordSource = loc_cCursor
1486: 
1487:                 *-- Column1 = Envios (b.tDtEnvs), Column2 = cUsuarios
1488:                 WITH THIS.grd_4c_Dados
1489:                     .Column1.ControlSource = loc_cCursor + ".envios"
1490:                     .Column2.ControlSource = loc_cCursor + ".cusuarios"
1491:                 ENDWITH
1492: 
1493:                 *-- Rede de seguranca do Problema 48: RecordSource/
1494:                 *-- ControlSource zeram Column.Width e Header1.Caption.
1495:                 *-- Mesma fonte usada na montagem, entao nao ha numero
1496:                 *-- duplicado aqui
1497:                 THIS.AplicarFormatoGrade()

*-- Linhas 1531 a 1609:
1531:             MsgErro("Erro ao carregar a situa" + CHR(231) + CHR(227) + "o de " + ;
1532:                     "transmiss" + CHR(227) + "o: " + loc_oErro.Message + ;
1533:                     " | Linha: " + TRANSFORM(loc_oErro.LineNo) + ;
1534:                     " | Proc: " + loc_oErro.Procedure, ;
1535:                     "Status da Transmiss" + CHR(227) + "o")
1536:             loc_lCarregou = .F.
1537:         ENDTRY
1538: 
1539:         RETURN loc_lCarregou
1540:     ENDPROC
1541: 
1542:     *==========================================================================
1543:     * TornarControlesVisiveis - AddObject cria controles com Visible=.F.
1544:     * por padrao. Percorre recursivamente containers/sub-containers para
1545:     * tornar tudo visivel. Este dialogo nao tem containers flutuantes
1546:     * (toggle por botao) - todo o corpo fica sempre visivel quando a tela
1547:     * abre, diferente de outros forms OPERACIONAIS desta mesma pasta.
1548:     *==========================================================================
1549:     PROTECTED PROCEDURE TornarControlesVisiveis
1550:         LOCAL loc_nI, loc_oObjeto
1551: 
1552:         FOR loc_nI = 1 TO THIS.ControlCount
1553:             loc_oObjeto = THIS.Controls(loc_nI)
1554: 
1555:             IF VARTYPE(loc_oObjeto) = "O"
1556:                 IF PEMSTATUS(loc_oObjeto, "Visible", 5)
1557:                     loc_oObjeto.Visible = .T.
1558:                 ENDIF
1559: 
1560:                 IF PEMSTATUS(loc_oObjeto, "ControlCount", 5) AND loc_oObjeto.ControlCount > 0
1561:                     THIS.TornarControlesVisivelContainer(loc_oObjeto)
1562:                 ENDIF
1563:             ENDIF
1564:         ENDFOR
1565:     ENDPROC
1566: 
1567:     *==========================================================================
1568:     * TornarControlesVisivelContainer - recursao auxiliar de
1569:     * TornarControlesVisiveis para sub-containers (ex.: cnt_4c_Sombra)
1570:     *==========================================================================
1571:     PROTECTED PROCEDURE TornarControlesVisivelContainer(par_oContainer)
1572:         LOCAL loc_nI, loc_oObjeto
1573: 
1574:         FOR loc_nI = 1 TO par_oContainer.ControlCount
1575:             loc_oObjeto = par_oContainer.Controls(loc_nI)
1576: 
1577:             IF VARTYPE(loc_oObjeto) = "O"
1578:                 IF PEMSTATUS(loc_oObjeto, "Visible", 5)
1579:                     loc_oObjeto.Visible = .T.
1580:                 ENDIF
1581: 
1582:                 IF PEMSTATUS(loc_oObjeto, "ControlCount", 5) AND loc_oObjeto.ControlCount > 0
1583:                     THIS.TornarControlesVisivelContainer(loc_oObjeto)
1584:                 ENDIF
1585:             ENDIF
1586:         ENDFOR
1587:     ENDPROC
1588: 
1589:     *==========================================================================
1590:     * Destroy - fecha o cursor de envios (cursor_4c_Envios, criado por
1591:     * SIGOPSTCBO.CarregarSituacao atraves de CarregarLista) antes de
1592:     * encerrar. O nome do alias vem de ObterCursorEnvios, a fonte unica.
1593:     *
1594:     * DODEFAULT() na ULTIMA linha (regra do CLAUDE.md): FormBase.Destroy()
1595:     * zera this_oBusinessObject e restaura o menu principal apos form
1596:     * modal.
1597:     *==========================================================================
1598:     PROCEDURE Destroy
1599:         LOCAL loc_cCursor
1600:         loc_cCursor = THIS.ObterCursorEnvios()
1601: 
1602:         IF USED(loc_cCursor)
1603:             USE IN (loc_cCursor)
1604:         ENDIF
1605: 
1606:         RETURN DODEFAULT()
1607:     ENDPROC
1608: 
1609: ENDDEFINE


### BO (C:\4c\projeto\app\classes\SIGOPSTCBO.prg):
*==============================================================================
* SIGOPSTCBO.prg - Business Object para "Status da transmissao do Arquivo Cat"
*
* Origem legado : SIGOPSTC.SCX  (tasks\task807)
* Tipo de form  : OPERACIONAL (dialogo FILHO, modal, chamado por outro form
*                 pai que ja transmitiu um arquivo e guarda o nome dele em
*                 ThisForm.pcSelFile)
* Herda de      : BusinessBase
*
* O QUE A TELA FAZ (legado)
* -------------------------
* Dialogo SOMENTE LEITURA que mostra a situacao de transmissao de um arquivo
* "Cat" (SPED/fiscal) ja identificado pelo form pai. O legado recebe poForm
* (o form pai) no Init, le ThisForm.poForm.pcSelFile (o nome do arquivo
* selecionado na tela pai) e faz UMA UNICA consulta:
*
*   Select a.*, b.*, b.tDtEnvs As Envios From SigFiSit a
*     Inner Join SigFiSii b On a.cArqMovs = b.cArqMovs
*     Where a.cArqMovs = '<pcSelFile>'
*
* SigFiSit (alias a) eh a situacao "cabecalho" do arquivo (uma linha por
* arquivo transmitido - cArqMovs/cEmps/cNumLotes/cImpFabs/...). SigFiSii
* (alias b) eh o HISTORICO de tentativas de envio desse arquivo (uma linha
* por tentativa - cUsuarios/tDtEnvs/cRetornos). O INNER JOIN produz UMA
* LINHA POR TENTATIVA DE ENVIO, e o cursor resultante (crTmpLgSit no legado)
* alimenta tres blocos da tela ao mesmo tempo:
*   - Text1..Text4: le os campos de SigFiSit (cArqMovs/cNumLotes/cEmps/
*     cImpFabs) da PRIMEIRA linha do cursor (sao os mesmos em todas as
*     linhas, porque pertencem ao cabecalho replicado pelo JOIN).
*   - Grid1: RecordSource = cursor inteiro, Column1 = Envios (b.tDtEnvs,
*     uma data por tentativa), Column2 = cUsuarios (SigFiSit.cUsuarios -
*     nome de coluna duplicado entre a e b; o legado deixa o VFP resolver a
*     colisao, que preserva o nome original para a 1a ocorrencia - ou seja,
*     a coluna da grade mostra SEMPRE o usuario de SigFiSit, repetido em
*     toda linha, e NAO o usuario de cada tentativa de SigFiSii. Isso eh
*     reproduzido literalmente, regra "formula do legado se transcreve, nao
*     se corrige" - ver CLAUDE.md regra #17/comentario de pipeline).
*   - Edit1: ControlSource = cRetornos (SigFiSii.cRetornos, memo) da linha
*     CORRENTE do grid - por isso AfterRowColChange refaz Edit1.Value ao
*     navegar entre as tentativas de envio.
*
* Botao unico: "Encerrar" (Commandgroup1.Command1) so fecha o dialogo
* (ThisForm.Release) - nao ha Incluir/Alterar/Excluir.
*
* PERSISTENCIA
* -------------
* Nenhuma. Eh um visualizador puro - o comportamento herdado de
* BusinessBase para Inserir()/Atualizar()/ExecutarExclusao() (recusar a
* operacao) ja eh o correto; NAO sobrescrever esses metodos so para
* preencher.
*
* LARGURAS DO SCHEMA (docs\schema.sql) - usadas no MaxLength dos controles
* ------------------------------------------------------------------------
*   SigFiSit.carqmovs  char(12) NOT NULL   SigFiSit.cidchaves char(20) NOT NULL (PK)
*   SigFiSit.cemps     char(3)  NOT NULL   SigFiSit.cimpfabs  char(20) NOT NULL
*   SigFiSit.cnumlotes char(10) NOT NULL   SigFiSit.cretsites char(20) NOT NULL
*   SigFiSit.cstatenvs char(1)  NOT NULL   SigFiSit.cstatvals char(1)  NOT NULL
*   SigFiSit.cusuarios char(20) NOT NULL   SigFiSit.tdtenvs   datetime NULL
*   SigFiSit.tdtmovs   datetime NULL
*   SigFiSii.carqmovs  char(12) NOT NULL   SigFiSii.cidchaves char(20) NOT NULL (PK)
*   SigFiSii.cretornos text     NULL       SigFiSii.cusuarios char(10) NOT NULL
*   SigFiSii.tdtenvs   datetime NULL
*==============================================================================

DEFINE CLASS SIGOPSTCBO AS BusinessBase

    *--------------------------------------------------------------------------
    * ENTIDADE - cabecalho da situacao de transmissao (SigFiSit), exibido
    * em Text1..Text4 do dialogo. Uma linha por arquivo transmitido.
    *--------------------------------------------------------------------------
    this_cCArqMovs           = ""   && carqmovs  char(12) NOT NULL - nome do arquivo (filtro recebido do form pai, Text1)
    this_cCIdChaves          = ""   && cidchaves char(20) NOT NULL - PK Fortyus de SigFiSit
    this_cCEmps              = ""   && cemps     char(3)  NOT NULL - codigo da empresa (Text3)
    this_cCNumLotes          = ""   && cnumlotes char(10) NOT NULL - numero do lote (Text2)
    this_cCImpFabs           = ""   && cimpfabs  char(20) NOT NULL - identificador da impressora fiscal (Text4)
    this_cCRetSites          = ""   && cretsites char(20) NOT NULL - retorno do site da SEFAZ (nao exibido na tela, mas parte de a.*)
    this_cCStatEnvs          = ""   && cstatenvs char(1)  NOT NULL - status do envio (nao exibido na tela, mas parte de a.*)
    this_cCStatVals          = ""   && cstatvals char(1)  NOT NULL - status da validacao (nao exibido na tela, mas parte de a.*)
    this_cCUsuarios          = ""   && cusuarios char(20) NOT NULL - usuario de SigFiSit; eh este valor (e nao o de cada tentativa de SigFiSii) que aparece em Grid1.Column2, por colisao de nome no legado
    this_dTDtEnvs            = {}   && tdtenvs   datetime NULL - data/hora do ultimo envio do cabecalho (nao exibido na tela, mas parte de a.*)
    this_dTDtMovs            = {}   && tdtmovs   datetime NULL - data/hora do movimento (nao exibido na tela, mas parte de a.*)

    *--------------------------------------------------------------------------
    * CONTEXTO HERDADO DO FORM PAI
    * Legado: ThisForm.poForm / ThisForm.poForm.pcSelFile / ThisForm.poForm.
    * DataSessionId - o arquivo a consultar vem do form que chamou este
    * dialogo, nao de uma escolha feita aqui.
    *--------------------------------------------------------------------------
    this_nDataSessionPai     = 0    && DataSessionId do form pai (poForm.DataSessionId do legado)

    *--------------------------------------------------------------------------
    * ALIAS DE CURSOR (nome do legado entre parenteses - PILAR 3 manda
    * renomear). Uma unica consulta alimenta a grade (Grid1) E a caixa de
    * retorno (Edit1) - nao ha cursor separado para cada bloco.
    *--------------------------------------------------------------------------
    this_cCursorEnvios       = "cursor_4c_Envios"  && crTmpLgSit - uma linha por tentativa de envio (SigFiSii), com Envios/cUsuarios/cRetornos

    *--------------------------------------------------------------------------
    * Init - Inicializa o Business Object
    *
    * Define a tabela/chave de referencia (SigFiSit.cidchaves) usada so
    * para auditoria/identificacao - este BO nunca grava (visualizador
    * puro), entao Inserir/Atualizar/ExecutarExclusao permanecem com o
    * comportamento herdado de BusinessBase (recusar a operacao).
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        DODEFAULT()

        THIS.this_cTabela     = "SigFiSit"
        THIS.this_cCampoChave = "cidchaves"

        THIS.this_nDataSessionPai = 0

        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Retorna o valor da chave para a auditoria.
    * Nunca chamado (este BO nunca grava), mas a base exige o override.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ObterChavePrimaria()
        RETURN THIS.this_cCIdChaves
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Carrega o CABECALHO (campos de SigFiSit, replicados
    * em toda linha pelo JOIN) a partir da PRIMEIRA linha do cursor
    * posicionado por CarregarSituacao (cursor_4c_Envios). Equivalente ao
    * legado lendo crTmpLgSit.cArqMovs/cNumLotes/cEmps/cImpFabs em
    * Text1..Text4 - sempre da linha corrente, mas como as colunas de
    * SigFiSit sao identicas em todas as linhas (regra do JOIN), ler a
    * PRIMEIRA basta.
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lResultado
        loc_lResultado = .F.

        IF USED(par_cAliasCursor)
            SELECT (par_cAliasCursor)
            GO TOP
            IF !EOF()
                THIS.this_cCArqMovs  = TratarNulo(carqmovs,  "")
                THIS.this_cCIdChaves = TratarNulo(cidchaves, "")
                THIS.this_cCEmps     = TratarNulo(cemps,     "")
                THIS.this_cCNumLotes = TratarNulo(cnumlotes, "")
                THIS.this_cCImpFabs  = TratarNulo(cimpfabs,  "")
                THIS.this_cCRetSites = TratarNulo(cretsites, "")
                THIS.this_cCStatEnvs = TratarNulo(cstatenvs, "")
                THIS.this_cCStatVals = TratarNulo(cstatvals, "")
                THIS.this_cCUsuarios = TratarNulo(cusuarios, "")
                THIS.this_dTDtEnvs   = TratarNulo(tdtenvs,   {})
                THIS.this_dTDtMovs   = TratarNulo(tdtmovs,   {})

                loc_lResultado = .T.
            ENDIF
        ENDIF

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarSituacao - Executa a UNICA consulta do dialogo (equivalente ao
    * legado SIGOPSTC.Init) e popula cursor_4c_Envios: uma linha por
    * tentativa de envio (SigFiSii) do arquivo par_cArqMovs, com o
    * cabecalho de SigFiSit replicado em cada linha pelo INNER JOIN.
    *
    *   Select a.*, b.*, b.tDtEnvs As Envios From SigFiSit a
    *     Inner Join SigFiSii b On a.cArqMovs = b.cArqMovs
    *     Where a.cArqMovs = '<par_cArqMovs>'
    *
    * As colunas sao listadas explicitamente (nao a.*, b.*) porque carqmovs/
    * cidchaves/cusuarios/tdtenvs existem nas DUAS tabelas: listar os dois
    * lados duplicaria o nome no cursor VFP. Mantem-se so o lado de SigFiSit
    * (alias a) para essas quatro - EXATAMENTE o que o legado produz quando
    * o VFP resolve a colisao de nomes (regra de pipeline citada no
    * cabecalho deste arquivo): Grid1.Column2 (cUsuarios) mostra sempre o
    * usuario do CABECALHO (SigFiSit), nunca o de cada tentativa
    * (SigFiSii.cUsuarios) - formula do legado, transcrita e nao corrigida.
    *
    * cRetornos (memo de SigFiSii, exibido em Edit1 da linha corrente) e
    * Envios (b.tDtEnvs apelidado, exibido em Grid1.Column1) sao as duas
    * colunas que SO existem no cursor por virem de SigFiSii.
    *
    * Depois de popular o cursor, chama CarregarDoCursor para preencher o
    * cabecalho (Text1..Text4) a partir da primeira linha.
    *
    * Os RETURN de guarda ficam FORA do TRY/CATCH (regra #1).
    *--------------------------------------------------------------------------
    FUNCTION CarregarSituacao(par_cArqMovs)
        LOCAL loc_cArqMovs, loc_cSQL, loc_nResultado, loc_lResultado
        loc_lResultado = .F.

        loc_cArqMovs = IIF(VARTYPE(par_cArqMovs) = "C", par_cArqMovs, "")

        *-- Sem conexao nao ha o que consultar (probe/harness sem config.prg)
        IF TYPE("gnConnHandle") != "N"
            THIS.this_cMensagemErro = "Conex" + CHR(227) + "o com o banco indispon" + ;
                CHR(237) + "vel."
            RETURN .F.
        ENDIF

        IF gnConnHandle <= 0
            THIS.this_cMensagemErro = "Conex" + CHR(227) + "o com o banco indispon" + ;
                CHR(237) + "vel."
            RETURN .F.
        ENDIF

        TRY
            loc_cSQL = "SELECT a.carqmovs, a.cidchaves, a.cemps, a.cnumlotes," + ;
                       " a.cimpfabs, a.cretsites, a.cstatenvs, a.cstatvals," + ;
                       " a.cusuarios, a.tdtenvs, a.tdtmovs, b.cretornos," + ;
                       " b.tdtenvs AS envios" + ;
                       " FROM SigFiSit a" + ;
                       " INNER JOIN SigFiSii b ON a.carqmovs = b.carqmovs" + ;
                       " WHERE a.carqmovs = " + EscaparSQL(loc_cArqMovs)

            IF USED("cursor_4c_Envios")
                USE IN cursor_4c_Envios
            ENDIF

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Envios")

            IF loc_nResultado >= 0
                loc_lResultado = .T.
                THIS.CarregarDoCursor("cursor_4c_Envios")
            ELSE
                MsgErro("Erro ao buscar a situa" + CHR(231) + CHR(227) + "o de transmiss" + ;
                    CHR(227) + "o:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loException
            MsgErro("Erro em SIGOPSTCBO.CarregarSituacao:" + CHR(13) + ;
                loException.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDFUNC

ENDDEFINE


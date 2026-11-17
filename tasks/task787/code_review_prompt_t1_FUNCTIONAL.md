# CODE REVIEW - PASS FUNCTIONAL: Functional Logic (metodos, eventos, containers)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Functional Logic (metodos, eventos, containers)**.

## PROBLEMAS DETECTADOS (4)
- [METODO-INEXISTENTE] Metodo 'THIS.Width()' chamado mas NAO definido como PROCEDURE no Form nem herdado de FormBase. A LLM pode ter inventado este metodo. VERIFICAR se existe no legado e IMPLEMENTAR ou REMOVER a chamada.
- [METODO-INEXISTENTE] Metodo 'THIS.Caption()' chamado mas NAO definido como PROCEDURE no Form nem herdado de FormBase. A LLM pode ter inventado este metodo. VERIFICAR se existe no legado e IMPLEMENTAR ou REMOVER a chamada.
- [GRID-WITH] Bloco WITH loc_oGrid define .RecordSource E acessa .Column dentro do mesmo WITH. Isso causa 'Unknown member COLUMN1' porque colunas nao sao criadas imediatamente dentro de WITH. SOLUCAO: Mover .RecordSource e .ColumnCount para FORA do WITH (usar referencia explicita: loc_oGrid.RecordSource).
- [LAYOUT-POSITION] Controle 'optProcessados' (parent: SIGOPPOP.cntOperacoes): Left original=83 vs migrado 'obj_4c_OptProcessados' Left=5 (diff=78px, tolerancia=30px)

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

### FORM (C:\4c\projeto\app\forms\operacionais\Formsigoppop.prg) - TRECHOS RELEVANTES PARA PASS FUNCTIONAL (2486 linhas total):

*-- Linhas 38 a 206:
38: * lbl_4c_LblTitulo.
39: *
40: * FASE 3/8 - ESTRUTURA BASE (esta fase): DEFINE CLASS, propriedades
41: * visuais, Init()/Destroy(), InicializarForm() (cria sigoppopBO +
42: * fundo new_background.jpg) e ConfigurarLayout() com SO a faixa do
43: * cabecalho (ConfigurarCabecalho - cnt_4c_Sombra) e o container vazio
44: * que vai hospedar o CommandGroup de acao (cnt_4c_Botoes, posicionado
45: * na bbox de cmdBtnForm do dump - Top=-2/Left=769/Width=235/Height=85,
46: * flutuante/transparente sobre a faixa, regra CLAUDE.md #11: criado
47: * DEPOIS da faixa para desenhar por cima). O CommandGroup cmg_4c_
48: * CmdBtnForm (Limpar/Copiar/Encerrar) entra dentro deste container em
49: * fase posterior.
50: *
51: * FASE 4/8 - GRADE + BOTOES DE LINHA (layout FLAT, sem PageFrame,
52: * mesmo padrao de Formsigoppag): cnt_4c_Grade (equivalente a cntGrade)
53: * hospedando grd_4c_Dados (equivalente a GrdOperacoes, 11 colunas -
54: * Check1 de marcacao + Codigo/Data/Valor/Documento/Usuario/Origem/
55: * Destino/Orig./Dest./Movimentacao, regra #18
56: * Column.AddObject+CurrentControl+Sparse para a coluna de check) +
57: * cmg_4c_CmdBtnGrade (equivalente a cmdBtnGrade - Selecionar Tudo/
58: * Desmarcar/Documentos) + o funil CarregarLista() ligado a
59: * this_oBusinessObject.this_cCursorOperacoes (cursor_4c_Operacoes).
60: * Mapeamento das 10 colunas de dado (dump nao declara ControlSource
61: * explicito - GrdOperacoes e um Grid nativo sem metodo de bind no
62: * trecho de codigo disponivel; inferido pelos ToolTipText de cada
63: * Column.Text1 do dump, casando contra o CREATE CURSOR do legado -
64: * csOperacoes - citado em comportamento.json): Codigo->Numes,
65: * Data->Datas, Valor->Valos, Documento->Notas, Usuario->Usuars,
66: * Origem->ContaOs, Destino->ContaDs, Orig.->Emps, Dest.->EmpDs,
67: * Movimentacao->Dopes (mais largo - 242px - compativel com Dopes
68: * char(20)). O cursor so e POPULADO pelo Selecionar() do legado
69: * (cntOperacoes.cmdSelecionar.Valid), nao no Init - nesta fase o
70: * cursor_4c_Operacoes nasce vazio (casca) e CarregarLista() so
71: * faz o bind/repintura (regra #21 - popular cursor NAO repinta a
72: * grade); Selecionar() entra na Fase 7/8 e reusa este mesmo metodo
73: * para repintar depois de popular.
74: *
75: * FASE 5/8 - CAMPOS PRINCIPAIS (PARTE 1) - esta fase: cnt_4c_Operacoes
76: * (equivalente a cntOperacoes do dump) com lbl_4c_TituloOperacoes
77: * (titulo em negrito "Operacoes" - Label1 do dump), obj_4c_OptProcessados
78: * (OptionGroup "Nao Processadas"/"Ja Processadas" - 2 botoes, INDICE,
79: * regra "numeric(1,0) de 2 opcoes nao eh logica" - NUNCA converter para
80: * logico), lbl_4c_Processo + cbo_4c_CmbOperacoes (Processo de Copia -
81: * RowSourceType=2/Alias sobre this_cCursorProcessos, populado por
82: * sigoppopBO.CarregarProcessos() a partir de SigPcOoP.processos char(20);
83: * o legado le o texto selecionado via ListItem(ListIndex), NAO por
84: * codigos numeric - no migrado o equivalente e ler cbo.Value, que e o
85: * mesmo texto pela ColumnCount=1), lbl_4c_Periodo + txt_4c_DtIni +
86: * lbl_4c_Ate + txt_4c_DtFin (periodo - Value inicial = DATE(), igual ao
87: * Init legado), cmd_4c_CmdSelecionar (botao que dispara Selecionar()),
88: * chk_4c_Fwcheckbox1 (CheckBox grafico Picture=consultar.bmp que liga
89: * ThisForm.ShowTips - comportamento.json InteractiveChange) e
90: * chk_4c_ChkMensa (Exibir Mensagens de Erro - .Value NUMERICO, regra
91: * CLAUDE.md, NUNCA .T./.F.). BINDEVENT dos eventos (Click/
92: * InteractiveChange) fica para a Fase 7/8, junto com os demais botoes
93: * do form.
94: *
95: * Colisao de nome resolvida (regra "nomes legado diferem so na caixa
96: * colidem"): mapeamento.json mapeia TANTO Say1 ("Periodo :") QUANTO
97: * Label1 ("Operacoes") para "lbl_4c_Label1" - sao dois Labels distintos
98: * no MESMO container (cntOperacoes), e usar o mesmo nome AddObject
99: * estouraria "object already exists". Say1 ficou lbl_4c_Periodo (label
100: * de campo) e Label1 ficou lbl_4c_TituloOperacoes (titulo de secao em
101: * negrito, Left=13/Top=3/AutoSize=.T.) - nomes diferentes do mapeamento
102: * gerado, documentados aqui.
103: *
104: * Say2 (Caption = "?" no dump/layout.json, Left=464 entre getDtIni e
105: * getDtFin) - a extracao corrompeu o caractere; pela posicao (entre as
106: * duas datas do periodo) e o padrao "Periodo : <DtIni> a <DtFin>", o
107: * texto original e a preposicao "a". Migrado como lbl_4c_Ate = "a".
108: *
109: * FASE 6/8 (esta fase) - CAMPOS RESTANTES E LOOKUPS (PARTE 2):
110: * cnt_4c_Filtro (equivalente a cntFiltro do dump) com os 4 campos de
111: * empresa origem/destino (txt_4c_EmpOs/txt_4c_DEmpOs/txt_4c_EmpDs/
112: * txt_4c_DEmpDs) e cnt_4c_Complemento (equivalente a cntComplemento)
113: * com txt_4c_DtLanc e txt_4c_Toleras (Format "K"/InputMask "999.99"
114: * do dump). Os 4 campos de empresa tem lookup completo: o legado
115: * chama fAcessoEmpresa(Usuar, 'C'|'D', This.Value, getEmpX, getDEmpX,
116: * poDataMgr) no Valid de cada campo (comportamento.json) -
117: * fAcessoEmpresa() NAO existe no sistema novo (regra CLAUDE.md), e o
118: * padrao MODO LOOKUP (5 args, popula 2 textboxes) substituido eh o
119: * bloco FormBuscaAuxiliar apontando SigCdEmp (Cemps/Razas),
120: * referencia canonica Formsigatcrp.prg:2285-2445 (ValidarEmp/
121: * AbrirBuscaEmp/ValidarDemp/AbrirBuscaDemp) - NAO o
122: * VerificarAcessoEmpresa (modo CHECK, 2 args, sem UI), que nao se
123: * aplica aqui porque o legado preenche os DOIS textboxes a partir do
124: * picker. BINDEVENT em "KeyPress" com par_nKeyCode testado (F4=115
125: * abre o picker direto; Enter=13/Tab=9 fazem o SELECT exato e so
126: * abrem o picker em caso de miss) - regra CLAUDE.md #47, handler
127: * TESTA a tecla, entao KeyPress eh legitimo (nao precisa LostFocus
128: * nem guarda de reentrancia, que so vale para handler ligado a
129: * LostFocus). Pares: ValidarEmpOs/AbrirBuscaEmpOs (Cemps) +
130: * ValidarDEmpOs/AbrirBuscaDEmpOs (Razas, so ativo quando EmpOs esta
131: * vazio - When do dump) para Origem; ValidarEmpDs/AbrirBuscaEmpDs +
132: * ValidarDEmpDs/AbrirBuscaDEmpDs para Destino, mesmo padrao.
133: *
134: * FASE 7/8 (esta fase) - EVENTOS: BINDEVENT dos Click de cmg_4c_
135: * CmdBtnForm (btnLimpar/btnCopiar/btnSair - equivalentes a
136: * LimpaSelecao()/Processamento()/Release do legado, dump:
137: * sigoppop_form_codigo_fonte.txt:10809-10897) e de cmg_4c_CmdBtnGrade
138: * (btnMarcaTudo/btnDesmarcar/btnDocumentos, dump:10488-10513), Click
139: * de cmd_4c_CmdSelecionar (equivalente ao Valid legado "ThisForm.
140: * Selecionar()", dump:10713-10715 - migrado para "Click", que e o
141: * evento confiavel para CommandButton via BINDEVENT neste projeto) e
142: * os 4 handlers (Click/KeyPress/MouseDown/MouseUp, todos NODEFAULT) da
143: * coluna de marcacao da grade (regra CLAUDE.md #46 - Valid/KeyPress da
144: * celula, NUNCA AfterRowColChange; dump:10525-10575).
145: *
146: * THIS.LimpaSelecao() e os handlers de cmg_4c_CmdBtnGrade/Check1 sao
147: * AUTOSSUFICIENTES (so manipulam cursor_4c_Operacoes e estado visual -
148: * nenhuma dependencia de metodo ainda nao escrito). THIS.
149: * CmdSelecionarClick() e o ramo "Copiar" de CmdBtnFormClick() chamam
150: * THIS.this_oBusinessObject.Selecionar()/.Processamento() - metodos
151: * QUE AINDA NAO EXISTEM no BO (o legado so tem fonte completo, sem
152: * truncamento, para Selecionar - dump:9941-10289 - e para Processamento
153: * - dump:5652-9936, ~4300 linhas; este ultimo ainda abre uma conexao
154: * fSqlConector POR EMPRESA DE DESTINO, via Drives/cIdConns de
155: * SigCdLoc, porque no legado cada empresa mora em um arquivo .DBF
156: * fisico separado - premissa que NAO existe na arquitetura nova, onde
157: * todas as empresas compartilham o MESMO SQL Server/gnConnHandle e sao
158: * filtradas pela coluna Emps/EmpDs, Pilar 2). Forward-reference
159: * deliberada, documentada tambem no cabecalho de sigoppopBO.prg - a
160: * Fase 8/8 implementa os dois no BO, adaptando o algoritmo de
161: * Processamento() para o modelo de conexao unica em vez de abrir uma
162: * conexao fisica por empresa.
163: *
164: * FASE 8/8 (esta fase) - CONSOLIDACAO. No Form:
165: *   - fConfigGeral() e fChecaAcesso([SIGOPPOP],[OPJAPROC]) no
166: *     InicializarForm, como no Init legado (dump:10297 e 10440);
167: *   - o gate de AcertaEmpDopNums() do Init legado (dump:10323-10327),
168: *     que NAO abre a tela quando a chave EmpDopNums nao pode ser
169: *     corrigida (pulado em modo de teste/validacao de UI);
170: *   - os CINCO indices do cursor da grade (Load legado, dump:10459-
171: *     10463) e o laco final do Init legado (dump:10425-10431 - fonte
172: *     Courier New e colunas travadas da 2 em diante) mais o
173: *     DynamicForeColor que pinta de VERMELHO a operacao ja excluida;
174: *   - BOParaForm() (tolerancia e data inicial que o Selecionar do BO
175: *     altera) e AplicarOrdemGrade() (SigPcOoP.Ordems);
176: *   - no CmdSelecionarClick, a confirmacao de REPROCESSAMENTO e as
177: *     validacoes de periodo com SetFocus (dump:9951-10013);
178: *   - no CmdBtnFormClick, o fecho "LimpaSelecao + refazer a selecao"
179: *     que o legado executa ao concluir a copia.
180: *
181: * BO: sigoppopBO - Selecionar() e o ciclo de fiscais/logs, o acerto de
182: * EmpDopNums, as faixas de peso, a geracao de codigo de produto, o
183: * casamento de produto, o modo FRANQUIA completo (Financeiro +
184: * FazContra + log em SigPcOoL) e a Delecao da origem estao
185: * implementados. A copia da MOVIMENTACAO completa (LancaProduto/
186: * LancaProdutoF/LancaProducao + o laco de destinos do Processamento,
187: * ~6.900 linhas do dump) NAO esta transcrita: Processamento() recusa
188: * esse caminho ANTES de gravar qualquer coisa, com mensagem que diz o
189: * que falta - ver "ESTADO DESTA FASE" no cabecalho de
190: * sigoppopBO.Processamento().
191: * Herda de: FormBase
192: *====================================================================
193: 
194: DEFINE CLASS Formsigoppop AS FormBase
195: 
196:     *-- DataSession privada (fiel ao legado: DataSession=2). O fix
197:     *-- sistemico de FormBase.Init() (SET DATE TO BRITISH + SET
198:     *-- CENTURY ON) roda incondicionalmente, regra CLAUDE.md #9.4.
199:     DataSession  = 2
200: 
201:     ShowWindow   = 1
202:     WindowType   = 1          && canonico - legado declara 0 (modeless), que MATA a tela (CLAUDE.md "WindowType 0 transcrito do SCX mata a tela")
203: 
204:     Width        = 1000
205:     Height       = 600
206:     AutoCenter   = .T.

*-- Linhas 217 a 387:
217:     Caption = "Transfer" + CHR(234) + "ncia Entre Locais"
218: 
219:     *-- Nome do cursor da grade de operacoes candidatas/selecionadas -
220:     *-- copiado de sigoppopBO.this_cCursorOperacoes em InicializarForm
221:     *-- (fonte unica, evita literal duplicado). Usado por CarregarLista
222:     *-- (Fase 4/8) e fechado em Destroy().
223:     this_cCursorOperacoes = ""
224: 
225:     *-- Nome do cursor da lista de Processos de Copia (RowSource do
226:     *-- combo cbo_4c_CmbOperacoes) - copiado de sigoppopBO.this_cCursorProcessos
227:     *-- em InicializarForm. Usado por ConfigurarOperacoes (Fase 5/8) e
228:     *-- fechado em Destroy().
229:     this_cCursorProcessos = ""
230: 
231:     *====================================================================
232:     * Init - form de topo, sem parametros (legado nao tem Lparameters).
233:     * DODEFAULT() aciona FormBase.Init(), que chama InicializarForm().
234:     *====================================================================
235:     PROCEDURE Init()
236:         RETURN DODEFAULT()
237:     ENDPROC
238: 
239:     *====================================================================
240:     * InicializarForm - cria o Business Object, aplica o fundo padrao
241:     * do framework legado e monta a casca visual (Fase 3/8: so a faixa
242:     * do cabecalho + o container vazio de botoes).
243:     *====================================================================
244:     PROTECTED PROCEDURE InicializarForm()
245:         LOCAL loc_lSucesso, loc_oErro, loc_cPicture
246:         loc_lSucesso = .F.
247: 
248:         TRY
249:             THIS.this_oBusinessObject = CREATEOBJECT("sigoppopBO")
250: 
251:             IF VARTYPE(THIS.this_oBusinessObject) != "O"
252:                 MsgErro("Falha ao criar sigoppopBO.", "Erro")
253:             ELSE
254:                 THIS.this_cCursorOperacoes  = THIS.this_oBusinessObject.this_cCursorOperacoes
255:                 THIS.this_cCursorProcessos  = THIS.this_oBusinessObject.this_cCursorProcessos
256: 
257:                 loc_cPicture = gc_4c_CaminhoFramework + "imagens\new_background.jpg"
258:                 IF FILE(loc_cPicture)
259:                     THIS.Picture = loc_cPicture
260:                 ENDIF
261: 
262:                 *-- fConfigGeral() - primeira linha do Init legado
263:                 *-- (dump:10297). Carrega a configuracao geral do sistema
264:                 *-- legado; existe como wrapper em utils\fconfiggeral.prg
265:                 *-- (regra CLAUDE.md #27).
266:                 fConfigGeral()
267: 
268:                 THIS.this_oBusinessObject.CarregarProcessos()
269: 
270:                 *-- Cadastro de destinos do Processo de Copia e parametros
271:                 *-- gerais (crTodosDestinos / crSigCdPam / crSigCdPac do Init
272:                 *-- legado - dump:10354-10395). Lidos aqui para o BO nao
273:                 *-- depender de quem o chama.
274:                 THIS.this_oBusinessObject.CarregarDestinos()
275:                 THIS.this_oBusinessObject.CarregarParametros()
276: 
277:                 THIS.ConfigurarLayout()
278:                 THIS.CarregarLista()
279: 
280:                 *-- "If (.AcertaEmpDopNums() < 1) ... Return .f." do Init
281:                 *-- legado (dump:10323-10327): sem a chave EmpDopNums
282:                 *-- preenchida em SigMvCab/SigMvItn/SigMvPar a selecao nao
283:                 *-- encontra operacao nenhuma, entao o legado NAO abre a tela.
284:                 *-- Pulado em modo de teste/validacao de UI, que roda sem
285:                 *-- conexao (gnConnHandle = -1).
286:                 loc_lSucesso = .T.
287: 
288:                 IF (TYPE("gb_4c_ValidandoUI") != "L" OR !gb_4c_ValidandoUI) AND ;
289:                    (TYPE("gb_4c_ModoTeste") != "L" OR !gb_4c_ModoTeste)
290:                     IF !THIS.this_oBusinessObject.AcertaEmpDopNums()
291:                         MsgAviso("A Chave EmpDopNums Est" + CHR(225) + " Inv" + CHR(225) + ;
292:                             "lida e N" + CHR(227) + "o Foi Poss" + CHR(237) + "vel Corrigir o Erro." + CHR(13) + ;
293:                             "Contate o Suporte T" + CHR(233) + "cnico e Informe Este Problema.", ;
294:                             "Acerta EmpDopNums")
295:                         loc_lSucesso = .F.
296:                     ENDIF
297:                 ENDIF
298: 
299:                 *-- "cntOperacoes.optProcessados.Enabled = fChecaAcesso(
300:                 *-- [SIGOPPOP],[OPJAPROC])" do Init legado (dump:10440): so
301:                 *-- quem tem a permissao OPJAPROC pode pedir reprocessamento
302:                 *-- de operacoes ja copiadas.
303:                 IF loc_lSucesso
304:                     THIS.cnt_4c_Operacoes.obj_4c_OptProcessados.Enabled = ;
305:                         fChecaAcesso("SIGOPPOP", "OPJAPROC")
306:                 ENDIF
307:             ENDIF
308:         CATCH TO loc_oErro
309:             MsgErro(loc_oErro.Message + CHR(13) + ;
310:                 "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
311:                 "Procedure: " + loc_oErro.Procedure, "Erro em Formsigoppop.InicializarForm")
312:         ENDTRY
313: 
314:         RETURN loc_lSucesso
315:     ENDPROC
316: 
317:     *====================================================================
318:     * ConfigurarLayout - orquestrador de montagem visual (layout FLAT,
319:     * sem PageFrame - o legado nao tem). Fase 3/8: a faixa do cabecalho
320:     * e o container de botoes de acao. Fase 4/8: a grade de operacoes,
321:     * o CommandGroup de marcacao ao lado dela (cmg_4c_CmdBtnGrade) e o
322:     * CommandGroup de acao dentro do container (cmg_4c_CmdBtnForm).
323:     * Fase 5/8 em diante acrescenta os campos de filtro.
324:     *====================================================================
325:     PROTECTED PROCEDURE ConfigurarLayout()
326:         THIS.ConfigurarCabecalho()
327:         THIS.ConfigurarContainerBotoes()
328:         THIS.ConfigurarCmdBtnForm()
329:         THIS.ConfigurarGrid()
330:         THIS.ConfigurarCmdBtnGrade()
331:         THIS.ConfigurarOperacoes()
332:         THIS.ConfigurarFiltro()
333:         THIS.ConfigurarComplemento()
334:         THIS.ConfigurarEventosBotoes()
335:     ENDPROC
336: 
337:     *====================================================================
338:     * ConfigurarCabecalho - faixa cinza do topo com o titulo do form.
339:     * Nomes conforme tasks/task787/mapeamento.json (SIGOPPOP.cntSombra/
340:     * lblSombra/lblTitulo -> cnt_4c_Sombra/lbl_4c_LblSombra/
341:     * lbl_4c_LblTitulo). Width usa THIS.Width (canonico do projeto) em
342:     * vez do literal 1004 do dump, que extrapola o Width=1000 do form.
343:     * Caption dos labels fica .Caption = THIS.Caption (equivalente ao
344:     * "ThisForm.cntSombra.lblSombra.Caption = ThisForm.Caption" do
345:     * Init legado), nao o texto generico "Cadastro de Testes" do dump.
346:     *====================================================================
347:     PROTECTED PROCEDURE ConfigurarCabecalho()
348:         LOCAL loc_oCnt, loc_oErro
349: 
350:         TRY
351:             THIS.AddObject("cnt_4c_Sombra", "Container")
352:             loc_oCnt = THIS.cnt_4c_Sombra
353:             WITH loc_oCnt
354:                 .Top           = 0
355:                 .Left          = 0
356:                 .Width         = THIS.Width
357:                 .Height        = 80
358:                 .BackStyle     = 1
359:                 .BackColor     = RGB(100, 100, 100)
360:                 .BorderWidth   = 0
361:                 .SpecialEffect = 0
362:                 .Visible       = .T.
363:             ENDWITH
364: 
365:             loc_oCnt.AddObject("lbl_4c_LblSombra", "Label")
366:             WITH loc_oCnt.lbl_4c_LblSombra
367:                 .Top       = 15
368:                 .Left      = 10
369:                 .Width     = 769
370:                 .Height    = 40
371:                 .FontName  = "Tahoma"
372:                 .FontSize  = 18
373:                 .FontBold  = .T.
374:                 .WordWrap  = .T.
375:                 .Alignment = 0
376:                 .BackStyle = 0
377:                 .AutoSize  = .F.
378:                 .ForeColor = RGB(0, 0, 0)
379:                 .Caption   = THIS.Caption
380:                 .Visible   = .T.
381:             ENDWITH
382: 
383:             loc_oCnt.AddObject("lbl_4c_LblTitulo", "Label")
384:             WITH loc_oCnt.lbl_4c_LblTitulo
385:                 .Top       = 18
386:                 .Left      = 10
387:                 .Width     = 769

*-- Linhas 400 a 498:
400:         CATCH TO loc_oErro
401:             MsgErro(loc_oErro.Message + CHR(13) + ;
402:                 "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
403:                 "Procedure: " + loc_oErro.Procedure, "Erro em ConfigurarCabecalho")
404:         ENDTRY
405:     ENDPROC
406: 
407:     *====================================================================
408:     * ConfigurarContainerBotoes - container que hospeda o CommandGroup
409:     * de acao (equivalente a cmdBtnForm do dump - Limpar/Copiar/
410:     * Encerrar, 3 botoes, Top=-2/Left=769/Width=235/Height=85).
411:     * Transparente (BackStyle=0) e criado DEPOIS da faixa (regra
412:     * CLAUDE.md #11) para flutuar por cima dela - a bbox do legado
413:     * (Top=-2..83) cobre quase toda a altura da faixa (0..80).
414:     * O CommandGroup entra em ConfigurarCmdBtnForm(), logo a seguir.
415:     *====================================================================
416:     PROTECTED PROCEDURE ConfigurarContainerBotoes()
417:         LOCAL loc_oErro
418: 
419:         TRY
420:             THIS.AddObject("cnt_4c_Botoes", "Container")
421:             WITH THIS.cnt_4c_Botoes
422:                 .Top         = -2
423:                 .Left        =  542
424:                 .Width       = 235
425:                 .Height      = 85
426:                 .BackStyle   = 0
427:                 .BorderWidth = 0
428:                 .Visible     = .T.
429:             ENDWITH
430:         CATCH TO loc_oErro
431:             MsgErro(loc_oErro.Message + CHR(13) + ;
432:                 "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
433:                 "Procedure: " + loc_oErro.Procedure, "Erro em ConfigurarContainerBotoes")
434:         ENDTRY
435:     ENDPROC
436: 
437:     *====================================================================
438:     * ConfigurarCmdBtnForm - CommandGroup de acao do form, dentro de
439:     * cnt_4c_Botoes (equivalente a cmdBtnForm do dump: btnLimpar/
440:     * btnCopiar/btnSair). Sao os botoes REAIS do legado - este form
441:     * OPERACIONAL nao tem CRUD (Incluir/Alterar/Excluir), e inventar
442:     * esses botoes violaria o PILAR 1.
443:     *
444:     * Geometria: o grupo ocupa o container inteiro (Top/Left = 0,
445:     * 235x85 - a mesma bbox que o dump declara em coordenadas de form,
446:     * Top=-2/Left=769, ja absorvida pelo container). Os Buttons usam os
447:     * Top/Left do dump, que ja sao relativos ao grupo (5,5 / 5,80 /
448:     * 5,155, todos 75x75). Width/Height do grupo ficam EXPLICITOS em
449:     * vez de AutoSize = .T.: sao os mesmos numeros que o Form Designer
450:     * calculou, logo fixa-los eh reproducao fiel (regra CLAUDE.md #23).
451:     *
452:     * Picture/ForeColor/BackColor/Font/Themes transcritos do dump -
453:     * NUNCA inventar nome de icone (regra CLAUDE.md #25). O btnSair ja
454:     * nasce no padrao canonico de saida (75x75, Caption "Encerrar",
455:     * cadastro_sair_60.jpg), entao nao ha conflito com a regra #10.
456:     * Os Click entram na Fase 7/8.
457:     *====================================================================
458:     PROTECTED PROCEDURE ConfigurarCmdBtnForm()
459:         LOCAL loc_oErro
460: 
461:         TRY
462:             THIS.cnt_4c_Botoes.AddObject("cmg_4c_CmdBtnForm", "CommandGroup")
463:             WITH THIS.cnt_4c_Botoes.cmg_4c_CmdBtnForm
464:                 .Top         = 0
465:                 .Left        = 0
466:                 .Width       = 235
467:                 .Height      = 85
468:                 .ButtonCount = 3
469:                 .BackStyle   = 0
470:                 .BorderStyle = 0
471:                 .Value       = 1
472:                 .Visible     = .T.
473: 
474:                 WITH .Buttons(1)
475:                     .Top             = 5
476:                     .Left            = 5
477:                     .Height          = 75
478:                     .Width           = 75
479:                     .FontName        = "Comic Sans MS"
480:                     .FontSize        = 8
481:                     .FontBold        = .T.
482:                     .FontItalic      = .T.
483:                     .Caption         = "Limpar"
484:                     .ToolTipText     = "Limpar Sele" + CHR(231) + CHR(227) + "o"
485:                     .ForeColor       = RGB(90, 90, 90)
486:                     .BackColor       = RGB(255, 255, 255)
487:                     .Themes          = .F.
488:                     .Picture         = gc_4c_CaminhoIcones + "geral_limpa_grade_60.jpg"
489:                     .DisabledPicture = gc_4c_CaminhoIcones + "geral_limpa_grade_60.jpg"
490:                     *-- Desabilitado ate Selecionar() popular a grade (regra do
491:                     *-- legado: btnLimpar.Enabled = .f. no Init - dump:10313).
492:                     .Enabled         = .F.
493:                 ENDWITH
494: 
495:                 WITH .Buttons(2)
496:                     .Top             = 5
497:                     .Left            = 80
498:                     .Height          = 75

*-- Linhas 535 a 611:
535:         CATCH TO loc_oErro
536:             MsgErro(loc_oErro.Message + CHR(13) + ;
537:                 "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
538:                 "Procedure: " + loc_oErro.Procedure, "Erro em ConfigurarCmdBtnForm")
539:         ENDTRY
540:     ENDPROC
541: 
542:     *====================================================================
543:     * ConfigurarGrid - cria o cursor (casca) da grade de operacoes
544:     * candidatas (equivalente ao "Create Cursor csOperacoes" do Init
545:     * legado - regra OPERACIONAL #4: SET NULL ON antes do CREATE
546:     * CURSOR, pois os valores reais virao de SQLEXEC no Selecionar() da
547:     * Fase 7/8) e o container+Grid que a exibem (cnt_4c_Grade/
548:     * grd_4c_Dados, nomes conforme mapeamento.json).
549:     *
550:     * ORDEM OBRIGATORIA (regra "grid_autobind_area_corrente_quebra_
551:     * addobject_checkbox"): um Grid SEM RecordSource ainda atribuida
552:     * auto-binda sozinho ao alias CORRENTE no instante em que
553:     * ColumnCount e definido - e se a coluna que vai receber o
554:     * Column.AddObject("Check1","CheckBox") cair, por acaso, numa
555:     * coluna CHARACTER dessa auto-bind, o AddObject estoura "Data type
556:     * mismatch" DENTRO de si mesmo (CheckBox.Value nasce NUMERICO).
557:     * Por isso RecordSource + ControlSource de TODAS as colunas e
558:     * aplicado ANTES do AddObject do Check1 - nunca depois. ColumnCount
559:     * e fixado AQUI, UMA UNICA VEZ (regra "SOREDUZIRColumn" -
560:     * reatribuir ColumnCount recria as colunas e destroi o Check1).
561:     * CarregarLista() so REBINDA (RecordSource/ControlSource/Width/
562:     * Header1.Caption, que o RecordSource RESETA a cada chamada - regra
563:     * "Problema 48"), sem tocar no AddObject.
564:     *
565:     * Colunas 1 a 11 (Width/ToolTipText/FontName/FontSize transcritos
566:     * do dump): Column1 = Check1 (marcacao, regra #18 - AddObject +
567:     * CurrentControl + Sparse); Columns 2-11 = Text1 de exibicao
568:     * (Codigo/Data/Valor/Documento/Usuario/Origem/Destino/Orig./Dest./
569:     * Movimentacao).
570:     *====================================================================
571:     PROTECTED PROCEDURE ConfigurarGrid()
572:         LOCAL loc_cCursor, loc_oGrid, loc_nCol, loc_oColuna, loc_oErro
573: 
574:         loc_cCursor = THIS.this_cCursorOperacoes
575: 
576:         TRY
577:             IF !USED(loc_cCursor)
578:                 SET NULL ON
579:                 CREATE CURSOR (loc_cCursor) ;
580:                     (SelImp L NULL, Emps C(3) NULL, Dopes C(20) NULL, ;
581:                      Numes N(6, 0) NULL, Datas D NULL, Valos N(12, 2) NULL, ;
582:                      Notas C(10) NULL, Usuars C(10) NULL, ContaOs C(10) NULL, ;
583:                      ContaDs C(10) NULL, EmpDs C(3) NULL, Deletado L NULL)
584:                 SET NULL OFF
585: 
586:                 *-- Os CINCO indices do Load legado (dump:10459-10463). Um TAG
587:                 *-- por criterio de ordenacao do Processo de Copia
588:                 *-- (SigPcOoP.Ordems): 1-Operacao / 2-Data / 3-Nota /
589:                 *-- 4-Origem / 5-Destino. Sem eles o "SET ORDER TO TAG <x>"
590:                 *-- que AplicarOrdemGrade() faz depois de Selecionar nao tem
591:                 *-- em que se apoiar.
592:                 INDEX ON Emps + Dopes + STR(Numes, 6)                   TAG Operacao
593:                 INDEX ON DTOS(Datas) + Emps + Dopes + STR(Numes, 6)     TAG Data
594:                 INDEX ON Notas + Emps + Dopes + STR(Numes, 6)           TAG Nota
595:                 INDEX ON ContaOs + Emps + Dopes + STR(Numes, 6)         TAG Origem
596:                 INDEX ON ContaDs + Emps + Dopes + STR(Numes, 6)         TAG Destino
597:                 SET ORDER TO TAG Operacao
598:             ENDIF
599: 
600:             THIS.AddObject("cnt_4c_Grade", "Container")
601:             WITH THIS.cnt_4c_Grade
602:                 .Top         = 209
603:                 .Left        = 9
604:                 .Width       = 932
605:                 .Height      = 375
606:                 .BackStyle   = 0
607:                 .BorderWidth = 0
608:                 .SpecialEffect = 0
609:                 .Visible     = .T.
610:             ENDWITH
611: 

*-- Linhas 810 a 865:
810:         CATCH TO loc_oErro
811:             MsgErro(loc_oErro.Message + CHR(13) + ;
812:                 "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
813:                 "Procedure: " + loc_oErro.Procedure, "Erro em ConfigurarGrid")
814:         ENDTRY
815:     ENDPROC
816: 
817:     *====================================================================
818:     * ConfigurarCmdBtnGrade - CommandGroup de 3 botoes ao lado direito
819:     * da grade (equivalente a cmdBtnGrade do dump - Selecionar Tudo/
820:     * Desmarcar/Documentos). Posicao, Picture e cores transcritas do
821:     * dump; Themes = .F. nos Buttons internos (padrao canonico de
822:     * Buttons dentro de CommandGroup). Os Click (btnMarcaTudo/
823:     * btnDesmarcar/btnDocumentos) entram na Fase 7/8.
824:     *====================================================================
825:     PROTECTED PROCEDURE ConfigurarCmdBtnGrade()
826:         LOCAL loc_oErro
827: 
828:         TRY
829:             THIS.AddObject("cmg_4c_CmdBtnGrade", "CommandGroup")
830:             WITH THIS.cmg_4c_CmdBtnGrade
831:                 .Top         = 364
832:                 .Left        = 944
833:                 .Width       = 43
834:                 .Height      = 135
835:                 .ButtonCount = 3
836:                 .BackStyle   = 0
837:                 .BorderStyle = 0
838:                 .Value       = 1
839:                 .Visible     = .T.
840: 
841:                 WITH .Buttons(1)
842:                     .Top             = -1
843:                     .Left            = -1
844:                     .Height          = 45
845:                     .Width           = 45
846:                     .FontName        = "Verdana"
847:                     .FontSize        = 8
848:                     .Caption         = ""
849:                     .ToolTipText     = "Selecionar"
850:                     .ForeColor       = RGB(36, 84, 155)
851:                     .BackColor       = RGB(255, 255, 255)
852:                     .Themes          = .F.
853:                     .Picture         = gc_4c_CaminhoIcones + "geral_marcar_26.jpg"
854:                     .DisabledPicture = gc_4c_CaminhoIcones + "geral_marcar_26.jpg"
855:                     *-- Desabilitado ate Selecionar() popular a grade (regra do
856:                     *-- legado: btnMarcaTudo.Enabled = .f. no Init - dump:10315).
857:                     .Enabled         = .F.
858:                 ENDWITH
859: 
860:                 WITH .Buttons(2)
861:                     .Top             = 45
862:                     .Left            = -1
863:                     .Height          = 45
864:                     .Width           = 45
865:                     .FontName        = "Verdana"

*-- Linhas 898 a 1004:
898:         CATCH TO loc_oErro
899:             MsgErro(loc_oErro.Message + CHR(13) + ;
900:                 "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
901:                 "Procedure: " + loc_oErro.Procedure, "Erro em ConfigurarCmdBtnGrade")
902:         ENDTRY
903:     ENDPROC
904: 
905:     *====================================================================
906:     * ConfigurarOperacoes - cnt_4c_Operacoes (equivalente a cntOperacoes
907:     * do dump): titulo de secao, Processo de Copia (combo), periodo
908:     * (datas) e o botao Selecionar. Geometria/cores/fontes transcritas
909:     * do dump (tasks/task787/sigoppop_form_codigo_fonte_slim.txt). Ver
910:     * comentario de Fase 5/8 no topo do arquivo para a colisao de nome
911:     * Say1/Label1 e a leitura de Say2 ("a").
912:     *====================================================================
913:     PROTECTED PROCEDURE ConfigurarOperacoes()
914:         LOCAL loc_oCnt, loc_oErro
915: 
916:         TRY
917:             *-- Guarda defensiva: se CarregarProcessos() (chamado em
918:             *-- InicializarForm, antes desta fase) nao conseguiu abrir
919:             *-- conexao (ex.: modo de teste sem SQL Server), garantir que
920:             *-- o cursor existe antes de amarrar o RowSourceType=2 do
921:             *-- combo - senao o AddObject do ComboBox estoura.
922:             IF !USED(THIS.this_cCursorProcessos)
923:                 CREATE CURSOR (THIS.this_cCursorProcessos) (processos C(20))
924:             ENDIF
925: 
926:             THIS.AddObject("cnt_4c_Operacoes", "Container")
927:             loc_oCnt = THIS.cnt_4c_Operacoes
928:             WITH loc_oCnt
929:                 .Top         = 88
930:                 .Left        = 6
931:                 .Width       = 732
932:                 .Height      = 46
933:                 .BackStyle   = 0
934:                 .BorderWidth = 0
935:                 .SpecialEffect = 0
936:                 .Visible     = .T.
937:             ENDWITH
938: 
939:             *-- Label1 do dump - titulo de secao em negrito ("Operacoes").
940:             *-- Nome lbl_4c_TituloOperacoes (NAO lbl_4c_Label1 do
941:             *-- mapeamento.json - colide com Say1, ver comentario de topo).
942:             loc_oCnt.AddObject("lbl_4c_TituloOperacoes", "Label")
943:             WITH loc_oCnt.lbl_4c_TituloOperacoes
944:                 .Top       = 3
945:                 .Left      = 13
946:                 .Width     = 62
947:                 .Height    = 15
948:                 .FontName  = "Tahoma"
949:                 .FontSize  = 8
950:                 .FontBold  = .T.
951:                 .FontItalic = .F.
952:                 .BackStyle = 0
953:                 .AutoSize  = .F.
954:                 .Alignment = 0
955:                 .ForeColor = RGB(90, 90, 90)
956:                 .Caption   = "Oper" + "\<" + "a" + CHR(231) + CHR(245) + "es"
957:                 .Visible   = .T.
958:             ENDWITH
959: 
960:             *-- optProcessados - OptionGroup "Nao Processadas"/"Ja
961:             *-- Processadas". Value = INDICE (1/2), NUNCA booleano (regra
962:             *-- CLAUDE.md "numeric(1,0) de duas opcoes nao eh logica").
963:             *-- Default = 1 (Nao Processadas), igual a BO.this_nProcessados.
964:             loc_oCnt.AddObject("obj_4c_OptProcessados", "OptionGroup")
965:             WITH loc_oCnt.obj_4c_OptProcessados
966:                 .Top         = 5
967:                 .Left        = 83
968:                 .Width       = 235
969:                 .Height      = 15
970:                 .ButtonCount = 2
971:                 .BackStyle   = 0
972:                 .BorderStyle = 0
973:                 .Value       = 1
974:                 .Visible     = .T.
975: 
976:                 WITH .Buttons(1)
977:                     .Top       = -1
978:                     .Left      = 5
979:                     .FontName  = "Tahoma"
980:                     .FontSize  = 8
981:                     .BackStyle = 0
982:                     .AutoSize  = .T.
983:                     .Caption   = "N" + CHR(227) + "o Processadas"
984:                     .ForeColor = RGB(90, 90, 90)
985:                 ENDWITH
986: 
987:                 WITH .Buttons(2)
988:                     .Top       = -1
989:                     .Left      = 126
990:                     .FontName  = "Tahoma"
991:                     .FontSize  = 8
992:                     .BackStyle = 0
993:                     .AutoSize  = .T.
994:                     .Caption   = "J" + CHR(225) + " Processadas"
995:                     .ForeColor = RGB(90, 90, 90)
996:                 ENDWITH
997:             ENDWITH
998: 
999:             *-- Say3 do dump - "Processo :".
1000:             loc_oCnt.AddObject("lbl_4c_Processo", "Label")
1001:             WITH loc_oCnt.lbl_4c_Processo
1002:                 .Top        = 24
1003:                 .Left       = 23
1004:                 .Width      = 60

*-- Linhas 1017 a 1060:
1017:             *-- cmbOperacoes - Processo de Copia cadastrado (SigPcOoP).
1018:             *-- RowSourceType=2 (Alias) sobre this_cCursorProcessos,
1019:             *-- populado por sigoppopBO.CarregarProcessos() ANTES desta
1020:             *-- fase (THIS.InicializarForm() chama o BO antes de
1021:             *-- ConfigurarLayout()). ColumnCount=1 (so o texto Processos,
1022:             *-- char(20) - o legado le o mesmo texto via
1023:             *-- ListItem(ListIndex), nao por codigo numerico).
1024:             loc_oCnt.AddObject("cbo_4c_CmbOperacoes", "ComboBox")
1025:             WITH loc_oCnt.cbo_4c_CmbOperacoes
1026:                 .Top            = 20
1027:                 .Left           = 87
1028:                 .Width          = 196
1029:                 .Height         = 24
1030:                 .FontName       = "Courier New"
1031:                 .FontSize       = 8
1032:                 .SpecialEffect  = 1
1033:                 .Style          = 2
1034:                 .ColumnCount    = 1
1035:                 .RowSourceType  = 2
1036:                 .RowSource      = THIS.this_cCursorProcessos
1037:                 .ToolTipText    = "Opera" + CHR(231) + CHR(245) + "es de C" + CHR(243) + "pia Configuradas no Cadastro de Opera" + CHR(231) + CHR(245) + "es Para C" + CHR(243) + "pia"
1038:                 .BorderColor    = RGB(90, 90, 90)
1039:                 .Visible        = .T.
1040:             ENDWITH
1041: 
1042:             *-- Say1 do dump - "Periodo :". Nome lbl_4c_Periodo (NAO
1043:             *-- lbl_4c_Label1 do mapeamento.json - colide com Label1).
1044:             loc_oCnt.AddObject("lbl_4c_Periodo", "Label")
1045:             WITH loc_oCnt.lbl_4c_Periodo
1046:                 .Top        = 23
1047:                 .Left       = 323
1048:                 .Width      = 50
1049:                 .Height     = 15
1050:                 .FontName   = "Tahoma"
1051:                 .FontSize   = 8
1052:                 .FontItalic = .F.
1053:                 .BackStyle  = 0
1054:                 .AutoSize   = .F.
1055:                 .Alignment  = 0
1056:                 .ForeColor  = RGB(90, 90, 90)
1057:                 .Caption    = "Per" + CHR(237) + "odo :"
1058:                 .Visible    = .T.
1059:             ENDWITH
1060: 

*-- Linhas 1108 a 1246:
1108:             ENDWITH
1109: 
1110:             *-- cmdSelecionar - dispara Selecionar() (BO), que monta
1111:             *-- cursor_4c_Operacoes a partir do filtro. BINDEVENT do
1112:             *-- Click fica para a Fase 7/8.
1113:             loc_oCnt.AddObject("cmd_4c_CmdSelecionar", "CommandButton")
1114:             WITH loc_oCnt.cmd_4c_CmdSelecionar
1115:                 .Top         = 21
1116:                 .Left        = 595
1117:                 .Width       = 99
1118:                 .Height      = 23
1119:                 .FontName    = "Comic Sans MS"
1120:                 .FontSize    = 8
1121:                 .FontBold    = .T.
1122:                 .FontItalic  = .T.
1123:                 .Caption     = "\<Selecionar"
1124:                 .ToolTipText = "Seleciona as Opera" + CHR(231) + CHR(245) + "es Conforme os Dados Digitados"
1125:                 .ForeColor   = RGB(90, 90, 90)
1126:                 .BackColor   = RGB(255, 255, 255)
1127:                 .Themes      = .F.
1128:                 .Visible     = .T.
1129:             ENDWITH
1130: 
1131:             *-- fwcheckbox1 do dump - CheckBox grafico (Style=1,
1132:             *-- Picture=consultar.bmp do framework legado, rule #25 -
1133:             *-- NUNCA inventar nome de icone) que liga/desliga
1134:             *-- ThisForm.ShowTips (comportamento.json:
1135:             *-- "ThisForm.ShowTips = (This.Value = 1)" no InteractiveChange).
1136:             *-- .Value NUMERICO (regra CLAUDE.md). BINDEVENT do
1137:             *-- InteractiveChange fica para a Fase 7/8, junto com os
1138:             *-- demais eventos do form.
1139:             loc_oCnt.AddObject("chk_4c_Fwcheckbox1", "CheckBox")
1140:             WITH loc_oCnt.chk_4c_Fwcheckbox1
1141:                 .Top       = 21
1142:                 .Left      = 704
1143:                 .Width     = 24
1144:                 .Height    = 23
1145:                 .Style     = 1
1146:                 .Alignment = 0
1147:                 .Caption   = ""
1148:                 .Value     = 0
1149:                 .BackColor = RGB(255, 255, 255)
1150:                 .Picture   = gc_4c_CaminhoFramework + "imagens\consultar.bmp"
1151:                 .Visible   = .T.
1152:             ENDWITH
1153: 
1154:             *-- chkMensa - "Exibir Mensagens de Erro". .Value NUMERICO
1155:             *-- (regra CLAUDE.md), NUNCA .T./.F.. Default = 1 (marcado),
1156:             *-- igual a BO.this_lExibirMensagens = .T..
1157:             loc_oCnt.AddObject("chk_4c_ChkMensa", "CheckBox")
1158:             WITH loc_oCnt.chk_4c_ChkMensa
1159:                 .Top         = 3
1160:                 .Left        = 377
1161:                 .Width       = 180
1162:                 .Height      = 17
1163:                 .FontName    = "Tahoma"
1164:                 .FontSize    = 8
1165:                 .FontItalic  = .F.
1166:                 .AutoSize    = .F.
1167:                 .Alignment   = 0
1168:                 .BackStyle   = 0
1169:                 .Caption     = "Exibir Mensagens de Erro"
1170:                 .Value       = 1
1171:                 .ToolTipText = "Exibe Mensagens Relativas a Erros de Lan" + CHR(231) + "amento"
1172:                 .ForeColor   = RGB(90, 90, 90)
1173:                 .Visible     = .T.
1174:                 *-- Desabilitado ate Selecionar() popular a grade (regra do
1175:                 *-- legado: chkMensa.Enabled = .f. no Init - dump:10318).
1176:                 .Enabled     = .F.
1177:             ENDWITH
1178:         CATCH TO loc_oErro
1179:             MsgErro(loc_oErro.Message + CHR(13) + ;
1180:                 "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1181:                 "Procedure: " + loc_oErro.Procedure, "Erro em ConfigurarOperacoes")
1182:         ENDTRY
1183:     ENDPROC
1184: 
1185:     *====================================================================
1186:     * ConfigurarFiltro - cnt_4c_Filtro (equivalente a cntFiltro do dump):
1187:     * 2 pares codigo+descricao de empresa (Origem/Destino). Geometria/
1188:     * cores/fontes transcritas do dump (sigoppop_form_codigo_fonte_
1189:     * slim.txt). MaxLength=3 nos campos de codigo (regra CLAUDE.md
1190:     * "SigCdEmp TextBox de codigo - MaxLength=3 obrigatorio", conferido
1191:     * no dump - getEmpOs/getEmpDs ja declaram MaxLength=3).
1192:     *
1193:     * Lookup: o legado valida no Valid (ao sair do campo) chamando
1194:     * fAcessoEmpresa no modo LOOKUP de 5 argumentos (comportamento.json);
1195:     * aqui, como BINDEVENT em "Valid" de TextBox nao e confiavel (regra
1196:     * CLAUDE.md #3), o equivalente fica no "KeyPress", testando a tecla
1197:     * (F4=115 abre o picker direto; Enter=13/Tab=9 fazem o SELECT exato
1198:     * contra SigCdEmp e so abrem o picker em caso de miss - regra
1199:     * CLAUDE.md #47, sem necessidade de guarda de reentrancia porque o
1200:     * handler testa par_nKeyCode). Os pickers (AbrirBuscaEmpOs/
1201:     * AbrirBuscaDEmpOs/AbrirBuscaEmpDs/AbrirBuscaDEmpDs) e os validadores
1202:     * (ValidarEmpOs/ValidarDEmpOs/ValidarEmpDs/ValidarDEmpDs) estao
1203:     * definidos mais abaixo, no mesmo padrao de Formsigatcrp.prg:2285-
1204:     * 2445 (ValidarEmp/AbrirBuscaEmp/ValidarDemp/AbrirBuscaDemp).
1205:     *====================================================================
1206:     PROTECTED PROCEDURE ConfigurarFiltro()
1207:         LOCAL loc_oCnt, loc_oErro
1208: 
1209:         TRY
1210:             THIS.AddObject("cnt_4c_Filtro", "Container")
1211:             loc_oCnt = THIS.cnt_4c_Filtro
1212:             WITH loc_oCnt
1213:                 .Top         = 134
1214:                 .Left        = 6
1215:                 .Width       = 699
1216:                 .Height      = 89
1217:                 .BackStyle   = 0
1218:                 .BorderWidth = 0
1219:                 .SpecialEffect = 0
1220:                 .Visible     = .T.
1221:             ENDWITH
1222: 
1223:             *-- Label2 do dump - titulo de secao em negrito ("Filtro por Empresa").
1224:             loc_oCnt.AddObject("lbl_4c_FiltroEmpresa", "Label")
1225:             WITH loc_oCnt.lbl_4c_FiltroEmpresa
1226:                 .Top        = 1
1227:                 .Left       = 9
1228:                 .Width      = 105
1229:                 .Height     = 15
1230:                 .FontName   = "Tahoma"
1231:                 .FontSize   = 8
1232:                 .FontBold   = .T.
1233:                 .FontItalic = .F.
1234:                 .BackStyle  = 0
1235:                 .AutoSize   = .F.
1236:                 .Alignment  = 0
1237:                 .ForeColor  = RGB(90, 90, 90)
1238:                 .Caption    = "Filtro por " + "\<" + "Empresa"
1239:                 .Visible    = .T.
1240:             ENDWITH
1241: 
1242:             *-- Say4 do dump - "Origem :".
1243:             loc_oCnt.AddObject("lbl_4c_Origem", "Label")
1244:             WITH loc_oCnt.lbl_4c_Origem
1245:                 .Top        = 23
1246:                 .Left       = 31

*-- Linhas 1327 a 1858:
1327:                 .Visible       = .T.
1328:             ENDWITH
1329: 
1330:             BINDEVENT(loc_oCnt.txt_4c_EmpOs,  "KeyPress", THIS, "ValidarEmpOs")
1331:             BINDEVENT(loc_oCnt.txt_4c_DEmpOs, "KeyPress", THIS, "ValidarDEmpOs")
1332:             BINDEVENT(loc_oCnt.txt_4c_EmpDs,  "KeyPress", THIS, "ValidarEmpDs")
1333:             BINDEVENT(loc_oCnt.txt_4c_DEmpDs, "KeyPress", THIS, "ValidarDEmpDs")
1334:         CATCH TO loc_oErro
1335:             MsgErro(loc_oErro.Message + CHR(13) + ;
1336:                 "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1337:                 "Procedure: " + loc_oErro.Procedure, "Erro em ConfigurarFiltro")
1338:         ENDTRY
1339:     ENDPROC
1340: 
1341:     *====================================================================
1342:     * ValidarEmpOs - KeyPress em txt_4c_EmpOs (codigo da empresa ORIGEM).
1343:     *   F4        -> abre picker direto
1344:     *   Enter/Tab -> SQL exato em SigCdEmp.Cemps; hit preenche DEmpOs,
1345:     *                miss abre picker
1346:     *====================================================================
1347:     PROCEDURE ValidarEmpOs(par_nKeyCode, par_nShiftAltCtrl)
1348:         LOCAL loc_cVal, loc_nResult, loc_oErro
1349: 
1350:         IF par_nKeyCode = 115
1351:             THIS.AbrirBuscaEmpOs()
1352:             RETURN
1353:         ENDIF
1354: 
1355:         IF par_nKeyCode != 13 AND par_nKeyCode != 9
1356:             RETURN
1357:         ENDIF
1358: 
1359:         loc_cVal = ALLTRIM(THIS.cnt_4c_Filtro.txt_4c_EmpOs.Value)
1360:         IF EMPTY(loc_cVal)
1361:             THIS.cnt_4c_Filtro.txt_4c_DEmpOs.Value = ""
1362:             THIS.cnt_4c_Filtro.txt_4c_DEmpOs.Refresh
1363:             RETURN
1364:         ENDIF
1365: 
1366:         TRY
1367:             loc_nResult = SQLEXEC(gnConnHandle, ;
1368:                 "SELECT TOP 1 Cemps, Razas FROM SigCdEmp WHERE Cemps = " + EscaparSQL(loc_cVal), ;
1369:                 "cursor_4c_EmpOsVal")
1370:             IF loc_nResult > 0 AND USED("cursor_4c_EmpOsVal") AND !EOF("cursor_4c_EmpOsVal")
1371:                 SELECT cursor_4c_EmpOsVal
1372:                 THIS.cnt_4c_Filtro.txt_4c_EmpOs.Value  = ALLTRIM(cursor_4c_EmpOsVal.Cemps)
1373:                 THIS.cnt_4c_Filtro.txt_4c_DEmpOs.Value = ALLTRIM(cursor_4c_EmpOsVal.Razas)
1374:             ELSE
1375:                 THIS.AbrirBuscaEmpOs()
1376:             ENDIF
1377:             IF USED("cursor_4c_EmpOsVal")
1378:                 USE IN cursor_4c_EmpOsVal
1379:             ENDIF
1380:         CATCH TO loc_oErro
1381:             MsgErro(loc_oErro.Message, "Erro")
1382:         ENDTRY
1383:         THIS.cnt_4c_Filtro.txt_4c_EmpOs.Refresh
1384:         THIS.cnt_4c_Filtro.txt_4c_DEmpOs.Refresh
1385:     ENDPROC
1386: 
1387:     *====================================================================
1388:     * AbrirBuscaEmpOs - picker por Cemps em SigCdEmp (empresa ORIGEM).
1389:     *====================================================================
1390:     PROCEDURE AbrirBuscaEmpOs()
1391:         LOCAL loc_oBusca, loc_cValor, loc_cSQL, loc_nResult, loc_cTitulo, loc_lProsseguir, loc_oErro
1392: 
1393:         loc_cValor  = ALLTRIM(THIS.cnt_4c_Filtro.txt_4c_EmpOs.Value)
1394:         loc_cTitulo = "Sele" + CHR(231) + CHR(227) + "o de Empresa de Origem"
1395: 
1396:         IF USED("cursor_4c_BuscaEmpOs")
1397:             USE IN cursor_4c_BuscaEmpOs
1398:         ENDIF
1399: 
1400:         loc_lProsseguir = .T.
1401:         TRY
1402:             IF EMPTY(loc_cValor)
1403:                 loc_cSQL = "SELECT Cemps, Razas FROM SigCdEmp ORDER BY Cemps"
1404:             ELSE
1405:                 loc_cSQL = "SELECT Cemps, Razas FROM SigCdEmp " + ;
1406:                            "WHERE Cemps LIKE " + EscaparSQL(loc_cValor + "%") + ;
1407:                            " OR RTRIM(Razas) LIKE " + EscaparSQL(loc_cValor + "%") + ;
1408:                            " ORDER BY Cemps"
1409:             ENDIF
1410:             loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaEmpOs")
1411: 
1412:             IF (loc_nResult < 1 OR !USED("cursor_4c_BuscaEmpOs") OR RECCOUNT("cursor_4c_BuscaEmpOs") = 0) ;
1413:                     AND !EMPTY(loc_cValor)
1414:                 IF USED("cursor_4c_BuscaEmpOs")
1415:                     USE IN cursor_4c_BuscaEmpOs
1416:                 ENDIF
1417:                 loc_nResult = SQLEXEC(gnConnHandle, ;
1418:                     "SELECT Cemps, Razas FROM SigCdEmp ORDER BY Cemps", ;
1419:                     "cursor_4c_BuscaEmpOs")
1420:             ENDIF
1421: 
1422:             IF loc_nResult < 1 OR !USED("cursor_4c_BuscaEmpOs") OR RECCOUNT("cursor_4c_BuscaEmpOs") = 0
1423:                 MsgAviso("Nenhuma empresa encontrada.", "Empresa")
1424:                 loc_lProsseguir = .F.
1425:             ENDIF
1426: 
1427:             IF loc_lProsseguir
1428:                 loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
1429:                 IF VARTYPE(loc_oBusca) = "O"
1430:                     loc_oBusca.this_cCursorDestino = "cursor_4c_BuscaEmpOs"
1431:                     loc_oBusca.this_cTitulo        = loc_cTitulo
1432:                     loc_oBusca.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = loc_cTitulo
1433:                     loc_oBusca.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = loc_cTitulo
1434:                     loc_oBusca.mAddColuna("Cemps", "", "C" + CHR(243) + "digo")
1435:                     loc_oBusca.mAddColuna("Razas", "", "Raz" + CHR(227) + "o Social")
1436:                     loc_oBusca.Show()
1437:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaEmpOs")
1438:                         SELECT cursor_4c_BuscaEmpOs
1439:                         THIS.cnt_4c_Filtro.txt_4c_EmpOs.Value  = ALLTRIM(cursor_4c_BuscaEmpOs.Cemps)
1440:                         THIS.cnt_4c_Filtro.txt_4c_DEmpOs.Value = ALLTRIM(cursor_4c_BuscaEmpOs.Razas)
1441:                     ENDIF
1442:                     loc_oBusca.Release()
1443:                 ENDIF
1444:             ENDIF
1445:         CATCH TO loc_oErro
1446:             MsgErro(loc_oErro.Message, "Erro")
1447:         ENDTRY
1448: 
1449:         IF USED("cursor_4c_BuscaEmpOs")
1450:             USE IN cursor_4c_BuscaEmpOs
1451:         ENDIF
1452:         THIS.cnt_4c_Filtro.txt_4c_EmpOs.Refresh
1453:         THIS.cnt_4c_Filtro.txt_4c_DEmpOs.Refresh
1454:     ENDPROC
1455: 
1456:     *====================================================================
1457:     * ValidarDEmpOs - KeyPress em txt_4c_DEmpOs (razao social da empresa
1458:     * ORIGEM). Ativo apenas quando txt_4c_EmpOs esta vazio (equivalente
1459:     * ao When "Return Empty(ThisForm.cntFiltro.getEmpOs.Value)" do dump).
1460:     *   F4        -> abre picker direto
1461:     *   Enter/Tab -> SQL exato em SigCdEmp.Razas; miss abre picker
1462:     *====================================================================
1463:     PROCEDURE ValidarDEmpOs(par_nKeyCode, par_nShiftAltCtrl)
1464:         LOCAL loc_cVal, loc_nResult, loc_oErro
1465: 
1466:         IF par_nKeyCode = 115
1467:             THIS.AbrirBuscaDEmpOs()
1468:             RETURN
1469:         ENDIF
1470: 
1471:         IF par_nKeyCode != 13 AND par_nKeyCode != 9
1472:             RETURN
1473:         ENDIF
1474: 
1475:         IF !EMPTY(ALLTRIM(THIS.cnt_4c_Filtro.txt_4c_EmpOs.Value))
1476:             RETURN
1477:         ENDIF
1478: 
1479:         loc_cVal = ALLTRIM(THIS.cnt_4c_Filtro.txt_4c_DEmpOs.Value)
1480:         IF EMPTY(loc_cVal)
1481:             THIS.cnt_4c_Filtro.txt_4c_EmpOs.Value = ""
1482:             THIS.cnt_4c_Filtro.txt_4c_EmpOs.Refresh
1483:             RETURN
1484:         ENDIF
1485: 
1486:         TRY
1487:             loc_nResult = SQLEXEC(gnConnHandle, ;
1488:                 "SELECT TOP 1 Cemps, Razas FROM SigCdEmp WHERE Razas = " + EscaparSQL(loc_cVal), ;
1489:                 "cursor_4c_EmpOsVal")
1490:             IF loc_nResult > 0 AND USED("cursor_4c_EmpOsVal") AND !EOF("cursor_4c_EmpOsVal")
1491:                 SELECT cursor_4c_EmpOsVal
1492:                 THIS.cnt_4c_Filtro.txt_4c_EmpOs.Value  = ALLTRIM(cursor_4c_EmpOsVal.Cemps)
1493:                 THIS.cnt_4c_Filtro.txt_4c_DEmpOs.Value = ALLTRIM(cursor_4c_EmpOsVal.Razas)
1494:             ELSE
1495:                 THIS.AbrirBuscaDEmpOs()
1496:             ENDIF
1497:             IF USED("cursor_4c_EmpOsVal")
1498:                 USE IN cursor_4c_EmpOsVal
1499:             ENDIF
1500:         CATCH TO loc_oErro
1501:             MsgErro(loc_oErro.Message, "Erro")
1502:         ENDTRY
1503:         THIS.cnt_4c_Filtro.txt_4c_EmpOs.Refresh
1504:         THIS.cnt_4c_Filtro.txt_4c_DEmpOs.Refresh
1505:     ENDPROC
1506: 
1507:     *====================================================================
1508:     * AbrirBuscaDEmpOs - picker por Razas em SigCdEmp (empresa ORIGEM).
1509:     *====================================================================
1510:     PROCEDURE AbrirBuscaDEmpOs()
1511:         LOCAL loc_oBusca, loc_cValor, loc_cSQL, loc_nResult, loc_cTitulo, loc_lProsseguir, loc_oErro
1512: 
1513:         loc_cValor  = ALLTRIM(THIS.cnt_4c_Filtro.txt_4c_DEmpOs.Value)
1514:         loc_cTitulo = "Sele" + CHR(231) + CHR(227) + "o de Empresa de Origem"
1515: 
1516:         IF USED("cursor_4c_BuscaEmpOs")
1517:             USE IN cursor_4c_BuscaEmpOs
1518:         ENDIF
1519: 
1520:         loc_lProsseguir = .T.
1521:         TRY
1522:             IF EMPTY(loc_cValor)
1523:                 loc_cSQL = "SELECT Cemps, Razas FROM SigCdEmp ORDER BY Razas"
1524:             ELSE
1525:                 loc_cSQL = "SELECT Cemps, Razas FROM SigCdEmp " + ;
1526:                            "WHERE RTRIM(Razas) LIKE " + EscaparSQL(loc_cValor + "%") + ;
1527:                            " OR Cemps LIKE " + EscaparSQL(loc_cValor + "%") + ;
1528:                            " ORDER BY Razas"
1529:             ENDIF
1530:             loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaEmpOs")
1531: 
1532:             IF (loc_nResult < 1 OR !USED("cursor_4c_BuscaEmpOs") OR RECCOUNT("cursor_4c_BuscaEmpOs") = 0) ;
1533:                     AND !EMPTY(loc_cValor)
1534:                 IF USED("cursor_4c_BuscaEmpOs")
1535:                     USE IN cursor_4c_BuscaEmpOs
1536:                 ENDIF
1537:                 loc_nResult = SQLEXEC(gnConnHandle, ;
1538:                     "SELECT Cemps, Razas FROM SigCdEmp ORDER BY Razas", ;
1539:                     "cursor_4c_BuscaEmpOs")
1540:             ENDIF
1541: 
1542:             IF loc_nResult < 1 OR !USED("cursor_4c_BuscaEmpOs") OR RECCOUNT("cursor_4c_BuscaEmpOs") = 0
1543:                 MsgAviso("Nenhuma empresa encontrada.", "Empresa")
1544:                 loc_lProsseguir = .F.
1545:             ENDIF
1546: 
1547:             IF loc_lProsseguir
1548:                 loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
1549:                 IF VARTYPE(loc_oBusca) = "O"
1550:                     loc_oBusca.this_cCursorDestino = "cursor_4c_BuscaEmpOs"
1551:                     loc_oBusca.this_cTitulo        = loc_cTitulo
1552:                     loc_oBusca.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = loc_cTitulo
1553:                     loc_oBusca.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = loc_cTitulo
1554:                     loc_oBusca.mAddColuna("Razas", "", "Raz" + CHR(227) + "o Social")
1555:                     loc_oBusca.mAddColuna("Cemps", "", "C" + CHR(243) + "digo")
1556:                     loc_oBusca.Show()
1557:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaEmpOs")
1558:                         SELECT cursor_4c_BuscaEmpOs
1559:                         THIS.cnt_4c_Filtro.txt_4c_EmpOs.Value  = ALLTRIM(cursor_4c_BuscaEmpOs.Cemps)
1560:                         THIS.cnt_4c_Filtro.txt_4c_DEmpOs.Value = ALLTRIM(cursor_4c_BuscaEmpOs.Razas)
1561:                     ENDIF
1562:                     loc_oBusca.Release()
1563:                 ENDIF
1564:             ENDIF
1565:         CATCH TO loc_oErro
1566:             MsgErro(loc_oErro.Message, "Erro")
1567:         ENDTRY
1568: 
1569:         IF USED("cursor_4c_BuscaEmpOs")
1570:             USE IN cursor_4c_BuscaEmpOs
1571:         ENDIF
1572:         THIS.cnt_4c_Filtro.txt_4c_EmpOs.Refresh
1573:         THIS.cnt_4c_Filtro.txt_4c_DEmpOs.Refresh
1574:     ENDPROC
1575: 
1576:     *====================================================================
1577:     * ValidarEmpDs - KeyPress em txt_4c_EmpDs (codigo da empresa DESTINO).
1578:     *   F4        -> abre picker direto
1579:     *   Enter/Tab -> SQL exato em SigCdEmp.Cemps; hit preenche DEmpDs,
1580:     *                miss abre picker
1581:     *====================================================================
1582:     PROCEDURE ValidarEmpDs(par_nKeyCode, par_nShiftAltCtrl)
1583:         LOCAL loc_cVal, loc_nResult, loc_oErro
1584: 
1585:         IF par_nKeyCode = 115
1586:             THIS.AbrirBuscaEmpDs()
1587:             RETURN
1588:         ENDIF
1589: 
1590:         IF par_nKeyCode != 13 AND par_nKeyCode != 9
1591:             RETURN
1592:         ENDIF
1593: 
1594:         loc_cVal = ALLTRIM(THIS.cnt_4c_Filtro.txt_4c_EmpDs.Value)
1595:         IF EMPTY(loc_cVal)
1596:             THIS.cnt_4c_Filtro.txt_4c_DEmpDs.Value = ""
1597:             THIS.cnt_4c_Filtro.txt_4c_DEmpDs.Refresh
1598:             RETURN
1599:         ENDIF
1600: 
1601:         TRY
1602:             loc_nResult = SQLEXEC(gnConnHandle, ;
1603:                 "SELECT TOP 1 Cemps, Razas FROM SigCdEmp WHERE Cemps = " + EscaparSQL(loc_cVal), ;
1604:                 "cursor_4c_EmpDsVal")
1605:             IF loc_nResult > 0 AND USED("cursor_4c_EmpDsVal") AND !EOF("cursor_4c_EmpDsVal")
1606:                 SELECT cursor_4c_EmpDsVal
1607:                 THIS.cnt_4c_Filtro.txt_4c_EmpDs.Value  = ALLTRIM(cursor_4c_EmpDsVal.Cemps)
1608:                 THIS.cnt_4c_Filtro.txt_4c_DEmpDs.Value = ALLTRIM(cursor_4c_EmpDsVal.Razas)
1609:             ELSE
1610:                 THIS.AbrirBuscaEmpDs()
1611:             ENDIF
1612:             IF USED("cursor_4c_EmpDsVal")
1613:                 USE IN cursor_4c_EmpDsVal
1614:             ENDIF
1615:         CATCH TO loc_oErro
1616:             MsgErro(loc_oErro.Message, "Erro")
1617:         ENDTRY
1618:         THIS.cnt_4c_Filtro.txt_4c_EmpDs.Refresh
1619:         THIS.cnt_4c_Filtro.txt_4c_DEmpDs.Refresh
1620:     ENDPROC
1621: 
1622:     *====================================================================
1623:     * AbrirBuscaEmpDs - picker por Cemps em SigCdEmp (empresa DESTINO).
1624:     *====================================================================
1625:     PROCEDURE AbrirBuscaEmpDs()
1626:         LOCAL loc_oBusca, loc_cValor, loc_cSQL, loc_nResult, loc_cTitulo, loc_lProsseguir, loc_oErro
1627: 
1628:         loc_cValor  = ALLTRIM(THIS.cnt_4c_Filtro.txt_4c_EmpDs.Value)
1629:         loc_cTitulo = "Sele" + CHR(231) + CHR(227) + "o de Empresa de Destino"
1630: 
1631:         IF USED("cursor_4c_BuscaEmpDs")
1632:             USE IN cursor_4c_BuscaEmpDs
1633:         ENDIF
1634: 
1635:         loc_lProsseguir = .T.
1636:         TRY
1637:             IF EMPTY(loc_cValor)
1638:                 loc_cSQL = "SELECT Cemps, Razas FROM SigCdEmp ORDER BY Cemps"
1639:             ELSE
1640:                 loc_cSQL = "SELECT Cemps, Razas FROM SigCdEmp " + ;
1641:                            "WHERE Cemps LIKE " + EscaparSQL(loc_cValor + "%") + ;
1642:                            " OR RTRIM(Razas) LIKE " + EscaparSQL(loc_cValor + "%") + ;
1643:                            " ORDER BY Cemps"
1644:             ENDIF
1645:             loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaEmpDs")
1646: 
1647:             IF (loc_nResult < 1 OR !USED("cursor_4c_BuscaEmpDs") OR RECCOUNT("cursor_4c_BuscaEmpDs") = 0) ;
1648:                     AND !EMPTY(loc_cValor)
1649:                 IF USED("cursor_4c_BuscaEmpDs")
1650:                     USE IN cursor_4c_BuscaEmpDs
1651:                 ENDIF
1652:                 loc_nResult = SQLEXEC(gnConnHandle, ;
1653:                     "SELECT Cemps, Razas FROM SigCdEmp ORDER BY Cemps", ;
1654:                     "cursor_4c_BuscaEmpDs")
1655:             ENDIF
1656: 
1657:             IF loc_nResult < 1 OR !USED("cursor_4c_BuscaEmpDs") OR RECCOUNT("cursor_4c_BuscaEmpDs") = 0
1658:                 MsgAviso("Nenhuma empresa encontrada.", "Empresa")
1659:                 loc_lProsseguir = .F.
1660:             ENDIF
1661: 
1662:             IF loc_lProsseguir
1663:                 loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
1664:                 IF VARTYPE(loc_oBusca) = "O"
1665:                     loc_oBusca.this_cCursorDestino = "cursor_4c_BuscaEmpDs"
1666:                     loc_oBusca.this_cTitulo        = loc_cTitulo
1667:                     loc_oBusca.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = loc_cTitulo
1668:                     loc_oBusca.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = loc_cTitulo
1669:                     loc_oBusca.mAddColuna("Cemps", "", "C" + CHR(243) + "digo")
1670:                     loc_oBusca.mAddColuna("Razas", "", "Raz" + CHR(227) + "o Social")
1671:                     loc_oBusca.Show()
1672:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaEmpDs")
1673:                         SELECT cursor_4c_BuscaEmpDs
1674:                         THIS.cnt_4c_Filtro.txt_4c_EmpDs.Value  = ALLTRIM(cursor_4c_BuscaEmpDs.Cemps)
1675:                         THIS.cnt_4c_Filtro.txt_4c_DEmpDs.Value = ALLTRIM(cursor_4c_BuscaEmpDs.Razas)
1676:                     ENDIF
1677:                     loc_oBusca.Release()
1678:                 ENDIF
1679:             ENDIF
1680:         CATCH TO loc_oErro
1681:             MsgErro(loc_oErro.Message, "Erro")
1682:         ENDTRY
1683: 
1684:         IF USED("cursor_4c_BuscaEmpDs")
1685:             USE IN cursor_4c_BuscaEmpDs
1686:         ENDIF
1687:         THIS.cnt_4c_Filtro.txt_4c_EmpDs.Refresh
1688:         THIS.cnt_4c_Filtro.txt_4c_DEmpDs.Refresh
1689:     ENDPROC
1690: 
1691:     *====================================================================
1692:     * ValidarDEmpDs - KeyPress em txt_4c_DEmpDs (razao social da empresa
1693:     * DESTINO). Ativo apenas quando txt_4c_EmpDs esta vazio (equivalente
1694:     * ao When "Return Empty(ThisForm.cntFiltro.getEmpDs.Value)" do dump).
1695:     *   F4        -> abre picker direto
1696:     *   Enter/Tab -> SQL exato em SigCdEmp.Razas; miss abre picker
1697:     *====================================================================
1698:     PROCEDURE ValidarDEmpDs(par_nKeyCode, par_nShiftAltCtrl)
1699:         LOCAL loc_cVal, loc_nResult, loc_oErro
1700: 
1701:         IF par_nKeyCode = 115
1702:             THIS.AbrirBuscaDEmpDs()
1703:             RETURN
1704:         ENDIF
1705: 
1706:         IF par_nKeyCode != 13 AND par_nKeyCode != 9
1707:             RETURN
1708:         ENDIF
1709: 
1710:         IF !EMPTY(ALLTRIM(THIS.cnt_4c_Filtro.txt_4c_EmpDs.Value))
1711:             RETURN
1712:         ENDIF
1713: 
1714:         loc_cVal = ALLTRIM(THIS.cnt_4c_Filtro.txt_4c_DEmpDs.Value)
1715:         IF EMPTY(loc_cVal)
1716:             THIS.cnt_4c_Filtro.txt_4c_EmpDs.Value = ""
1717:             THIS.cnt_4c_Filtro.txt_4c_EmpDs.Refresh
1718:             RETURN
1719:         ENDIF
1720: 
1721:         TRY
1722:             loc_nResult = SQLEXEC(gnConnHandle, ;
1723:                 "SELECT TOP 1 Cemps, Razas FROM SigCdEmp WHERE Razas = " + EscaparSQL(loc_cVal), ;
1724:                 "cursor_4c_EmpDsVal")
1725:             IF loc_nResult > 0 AND USED("cursor_4c_EmpDsVal") AND !EOF("cursor_4c_EmpDsVal")
1726:                 SELECT cursor_4c_EmpDsVal
1727:                 THIS.cnt_4c_Filtro.txt_4c_EmpDs.Value  = ALLTRIM(cursor_4c_EmpDsVal.Cemps)
1728:                 THIS.cnt_4c_Filtro.txt_4c_DEmpDs.Value = ALLTRIM(cursor_4c_EmpDsVal.Razas)
1729:             ELSE
1730:                 THIS.AbrirBuscaDEmpDs()
1731:             ENDIF
1732:             IF USED("cursor_4c_EmpDsVal")
1733:                 USE IN cursor_4c_EmpDsVal
1734:             ENDIF
1735:         CATCH TO loc_oErro
1736:             MsgErro(loc_oErro.Message, "Erro")
1737:         ENDTRY
1738:         THIS.cnt_4c_Filtro.txt_4c_EmpDs.Refresh
1739:         THIS.cnt_4c_Filtro.txt_4c_DEmpDs.Refresh
1740:     ENDPROC
1741: 
1742:     *====================================================================
1743:     * AbrirBuscaDEmpDs - picker por Razas em SigCdEmp (empresa DESTINO).
1744:     *====================================================================
1745:     PROCEDURE AbrirBuscaDEmpDs()
1746:         LOCAL loc_oBusca, loc_cValor, loc_cSQL, loc_nResult, loc_cTitulo, loc_lProsseguir, loc_oErro
1747: 
1748:         loc_cValor  = ALLTRIM(THIS.cnt_4c_Filtro.txt_4c_DEmpDs.Value)
1749:         loc_cTitulo = "Sele" + CHR(231) + CHR(227) + "o de Empresa de Destino"
1750: 
1751:         IF USED("cursor_4c_BuscaEmpDs")
1752:             USE IN cursor_4c_BuscaEmpDs
1753:         ENDIF
1754: 
1755:         loc_lProsseguir = .T.
1756:         TRY
1757:             IF EMPTY(loc_cValor)
1758:                 loc_cSQL = "SELECT Cemps, Razas FROM SigCdEmp ORDER BY Razas"
1759:             ELSE
1760:                 loc_cSQL = "SELECT Cemps, Razas FROM SigCdEmp " + ;
1761:                            "WHERE RTRIM(Razas) LIKE " + EscaparSQL(loc_cValor + "%") + ;
1762:                            " OR Cemps LIKE " + EscaparSQL(loc_cValor + "%") + ;
1763:                            " ORDER BY Razas"
1764:             ENDIF
1765:             loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaEmpDs")
1766: 
1767:             IF (loc_nResult < 1 OR !USED("cursor_4c_BuscaEmpDs") OR RECCOUNT("cursor_4c_BuscaEmpDs") = 0) ;
1768:                     AND !EMPTY(loc_cValor)
1769:                 IF USED("cursor_4c_BuscaEmpDs")
1770:                     USE IN cursor_4c_BuscaEmpDs
1771:                 ENDIF
1772:                 loc_nResult = SQLEXEC(gnConnHandle, ;
1773:                     "SELECT Cemps, Razas FROM SigCdEmp ORDER BY Razas", ;
1774:                     "cursor_4c_BuscaEmpDs")
1775:             ENDIF
1776: 
1777:             IF loc_nResult < 1 OR !USED("cursor_4c_BuscaEmpDs") OR RECCOUNT("cursor_4c_BuscaEmpDs") = 0
1778:                 MsgAviso("Nenhuma empresa encontrada.", "Empresa")
1779:                 loc_lProsseguir = .F.
1780:             ENDIF
1781: 
1782:             IF loc_lProsseguir
1783:                 loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
1784:                 IF VARTYPE(loc_oBusca) = "O"
1785:                     loc_oBusca.this_cCursorDestino = "cursor_4c_BuscaEmpDs"
1786:                     loc_oBusca.this_cTitulo        = loc_cTitulo
1787:                     loc_oBusca.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = loc_cTitulo
1788:                     loc_oBusca.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = loc_cTitulo
1789:                     loc_oBusca.mAddColuna("Razas", "", "Raz" + CHR(227) + "o Social")
1790:                     loc_oBusca.mAddColuna("Cemps", "", "C" + CHR(243) + "digo")
1791:                     loc_oBusca.Show()
1792:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaEmpDs")
1793:                         SELECT cursor_4c_BuscaEmpDs
1794:                         THIS.cnt_4c_Filtro.txt_4c_EmpDs.Value  = ALLTRIM(cursor_4c_BuscaEmpDs.Cemps)
1795:                         THIS.cnt_4c_Filtro.txt_4c_DEmpDs.Value = ALLTRIM(cursor_4c_BuscaEmpDs.Razas)
1796:                     ENDIF
1797:                     loc_oBusca.Release()
1798:                 ENDIF
1799:             ENDIF
1800:         CATCH TO loc_oErro
1801:             MsgErro(loc_oErro.Message, "Erro")
1802:         ENDTRY
1803: 
1804:         IF USED("cursor_4c_BuscaEmpDs")
1805:             USE IN cursor_4c_BuscaEmpDs
1806:         ENDIF
1807:         THIS.cnt_4c_Filtro.txt_4c_EmpDs.Refresh
1808:         THIS.cnt_4c_Filtro.txt_4c_DEmpDs.Refresh
1809:     ENDPROC
1810: 
1811:     *====================================================================
1812:     * ConfigurarComplemento - cnt_4c_Complemento (equivalente a
1813:     * cntComplemento do dump): data de lancamento no destino e
1814:     * tolerancia AU. Geometria/Format/InputMask transcritos do dump
1815:     * (regra CLAUDE.md #49 - Format/InputMask do SCX sao OBRIGATORIOS).
1816:     * Sem lookup - campos simples, so transcricao de propriedades.
1817:     *====================================================================
1818:     PROTECTED PROCEDURE ConfigurarComplemento()
1819:         LOCAL loc_oCnt, loc_oErro
1820: 
1821:         TRY
1822:             THIS.AddObject("cnt_4c_Complemento", "Container")
1823:             loc_oCnt = THIS.cnt_4c_Complemento
1824:             WITH loc_oCnt
1825:                 .Top         = 151
1826:                 .Left        = 453
1827:                 .Width       = 240
1828:                 .Height      = 60
1829:                 .BackStyle   = 0
1830:                 .BorderWidth = 0
1831:                 .SpecialEffect = 0
1832:                 .Visible     = .T.
1833:             ENDWITH
1834: 
1835:             *-- Say1 do dump - "Lancar em :".
1836:             loc_oCnt.AddObject("lbl_4c_LancarEm", "Label")
1837:             WITH loc_oCnt.lbl_4c_LancarEm
1838:                 .Top       = 5
1839:                 .Left      = 20
1840:                 .Width     = 65
1841:                 .Height    = 15
1842:                 .FontName  = "Tahoma"
1843:                 .FontSize  = 8
1844:                 .BackStyle = 0
1845:                 .AutoSize  = .F.
1846:                 .Alignment = 0
1847:                 .ForeColor = RGB(90, 90, 90)
1848:                 .Caption   = "La" + "\<" + "n" + CHR(231) + "ar em :"
1849:                 .Visible   = .T.
1850:             ENDWITH
1851: 
1852:             *-- getDtLanc - data de lancamento das operacoes no DESTINO
1853:             *-- (vazia assume a data da origem - this_dDtLanc do BO).
1854:             loc_oCnt.AddObject("txt_4c_DtLanc", "TextBox")
1855:             WITH loc_oCnt.txt_4c_DtLanc
1856:                 .Top           = 1
1857:                 .Left          = 90
1858:                 .Width         = 80

*-- Linhas 1920 a 1981:
1920:         CATCH TO loc_oErro
1921:             MsgErro(loc_oErro.Message + CHR(13) + ;
1922:                 "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1923:                 "Procedure: " + loc_oErro.Procedure, "Erro em ConfigurarComplemento")
1924:         ENDTRY
1925:     ENDPROC
1926: 
1927:     *====================================================================
1928:     * CarregarLista - metodo UNICO de bind/repintura da grade de
1929:     * operacoes candidatas (cursor_4c_Operacoes), chamado por
1930:     * InicializarForm() (cursor ainda vazio, so pinta a casca da grade)
1931:     * e reusado pelo Selecionar() da Fase 7/8 (cursor ja populado).
1932:     *
1933:     * Ordem canonica (regra "Problema 48"/CLAUDE.md): RecordSource (que
1934:     * RESETA Width e Header1.Caption) -> ControlSource de cada coluna ->
1935:     * Width -> Header1.Caption -> GO TOP + Refresh (regra #21 - popular
1936:     * cursor nao repinta a grade por si so). ColumnCount NAO e
1937:     * reatribuido aqui (ja fixo em ConfigurarGrid - regra
1938:     * "SOREDUZIRColumn"); CurrentControl/Sparse do Column1 sao
1939:     * reforcados defensivamente apos o RecordSource.
1940:     *====================================================================
1941:     PROCEDURE CarregarLista()
1942:         LOCAL loc_oGrid, loc_cCursor, loc_oErro
1943: 
1944:         loc_cCursor = THIS.this_cCursorOperacoes
1945: 
1946:         IF !USED(loc_cCursor)
1947:             RETURN
1948:         ENDIF
1949: 
1950:         TRY
1951:             loc_oGrid = THIS.cnt_4c_Grade.grd_4c_Dados
1952: 
1953:             loc_oGrid.RecordSource = loc_cCursor
1954: 
1955:             loc_oGrid.Column1.ControlSource = loc_cCursor + ".SelImp"
1956:             loc_oGrid.Column1.AddObject("Check1", "CheckBox")
1957:             loc_oGrid.Column1.Check1.Caption = ""
1958:             loc_oGrid.Column1.CurrentControl = "Check1"
1959:             loc_oGrid.Column1.Sparse         = .F.
1960:             loc_oGrid.Column1.ReadOnly       = .F.
1961:             loc_oGrid.Column1.Width          = 15
1962: 
1963:             loc_oGrid.Column2.ControlSource = loc_cCursor + ".Numes"
1964:             loc_oGrid.Column2.Width         = 52
1965:             loc_oGrid.Column2.Header1.Caption = "C" + CHR(243) + "digo"
1966: 
1967:             loc_oGrid.Column3.ControlSource = loc_cCursor + ".Datas"
1968:             loc_oGrid.Column3.Width         = 80
1969:             loc_oGrid.Column3.Header1.Caption = "Data"
1970: 
1971:             loc_oGrid.Column4.ControlSource = loc_cCursor + ".Valos"
1972:             loc_oGrid.Column4.Width         = 104
1973:             loc_oGrid.Column4.Header1.Caption = "Valor"
1974: 
1975:             loc_oGrid.Column5.ControlSource = loc_cCursor + ".Notas"
1976:             loc_oGrid.Column5.Width         = 75
1977:             loc_oGrid.Column5.Header1.Caption = "Documento"
1978: 
1979:             loc_oGrid.Column6.ControlSource = loc_cCursor + ".Usuars"
1980:             loc_oGrid.Column6.Width         = 85
1981:             loc_oGrid.Column6.Header1.Caption = "Usu" + CHR(225) + "rio"

*-- Linhas 2007 a 2160:
2007:         CATCH TO loc_oErro
2008:             MsgErro(loc_oErro.Message + CHR(13) + ;
2009:                 "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
2010:                 "Procedure: " + loc_oErro.Procedure, "Erro em CarregarLista")
2011:         ENDTRY
2012:     ENDPROC
2013: 
2014:     *====================================================================
2015:     * ConfigurarEventosBotoes - BINDEVENT dos botoes de acao (cmg_4c_
2016:     * CmdBtnForm/cmg_4c_CmdBtnGrade/cmd_4c_CmdSelecionar), do checkbox
2017:     * grafico (chk_4c_Fwcheckbox1) e dos 4 handlers da coluna de
2018:     * marcacao da grade (Column1.Check1 - regra CLAUDE.md #46/#18).
2019:     * Chamado ao final de ConfigurarLayout(), depois que todos os
2020:     * controles referenciados ja existem (regra CLAUDE.md "BINDEVENT em
2021:     * objeto que ainda nao existe estoura no proprio bind").
2022:     *====================================================================
2023:     PROTECTED PROCEDURE ConfigurarEventosBotoes()
2024:         LOCAL loc_oErro
2025: 
2026:         TRY
2027:             BINDEVENT(THIS.cnt_4c_Operacoes.cmd_4c_CmdSelecionar, "Click", THIS, "CmdSelecionarClick")
2028:             BINDEVENT(THIS.cnt_4c_Operacoes.chk_4c_Fwcheckbox1, "InteractiveChange", THIS, "ChkFwcheckbox1InteractiveChange")
2029:             BINDEVENT(THIS.cnt_4c_Botoes.cmg_4c_CmdBtnForm, "Click", THIS, "CmdBtnFormClick")
2030:             BINDEVENT(THIS.cmg_4c_CmdBtnGrade, "Click", THIS, "CmdBtnGradeClick")
2031: 
2032:             WITH THIS.cnt_4c_Grade.grd_4c_Dados.Column1.Check1
2033:                 BINDEVENT(THIS.cnt_4c_Grade.grd_4c_Dados.Column1.Check1, "Click",     THIS, "Check1Click")
2034:                 BINDEVENT(THIS.cnt_4c_Grade.grd_4c_Dados.Column1.Check1, "KeyPress",  THIS, "Check1KeyPress")
2035:                 BINDEVENT(THIS.cnt_4c_Grade.grd_4c_Dados.Column1.Check1, "MouseDown", THIS, "Check1MouseDown")
2036:                 BINDEVENT(THIS.cnt_4c_Grade.grd_4c_Dados.Column1.Check1, "MouseUp",   THIS, "Check1MouseUp")
2037:             ENDWITH
2038:         CATCH TO loc_oErro
2039:             MsgErro(loc_oErro.Message + CHR(13) + ;
2040:                 "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
2041:                 "Procedure: " + loc_oErro.Procedure, "Erro em ConfigurarEventosBotoes")
2042:         ENDTRY
2043:     ENDPROC
2044: 
2045:     *====================================================================
2046:     * AtualizarFiltroNoBO - copia o filtro/periodo/processo/complemento
2047:     * da tela para as properties correspondentes do BO (cntFiltro/
2048:     * cntOperacoes/cntComplemento do legado -> this_cEmpOs/this_cEmpDs/
2049:     * this_dDtIni/this_dDtFin/this_cProcesso/this_nProcessados/
2050:     * this_lExibirMensagens/this_dDtLanc/this_nToleras - ver cabecalho
2051:     * de sigoppopBO.prg). Chamado por CmdSelecionarClick() antes de
2052:     * THIS.this_oBusinessObject.Selecionar().
2053:     *====================================================================
2054:     PROTECTED PROCEDURE AtualizarFiltroNoBO()
2055:         LOCAL loc_oBO
2056: 
2057:         loc_oBO = THIS.this_oBusinessObject
2058: 
2059:         loc_oBO.this_cEmpOs           = ALLTRIM(THIS.cnt_4c_Filtro.txt_4c_EmpOs.Value)
2060:         loc_oBO.this_cEmpDs           = ALLTRIM(THIS.cnt_4c_Filtro.txt_4c_EmpDs.Value)
2061:         loc_oBO.this_dDtIni           = ConverterParaData(THIS.cnt_4c_Operacoes.txt_4c_DtIni.Value)
2062:         loc_oBO.this_dDtFin           = ConverterParaData(THIS.cnt_4c_Operacoes.txt_4c_DtFin.Value)
2063:         loc_oBO.this_cProcesso        = ALLTRIM(THIS.cnt_4c_Operacoes.cbo_4c_CmbOperacoes.Value)
2064:         loc_oBO.this_nProcessados     = THIS.cnt_4c_Operacoes.obj_4c_OptProcessados.Value
2065:         loc_oBO.this_lExibirMensagens = (THIS.cnt_4c_Operacoes.chk_4c_ChkMensa.Value = 1)
2066:         loc_oBO.this_dDtLanc          = ConverterParaData(THIS.cnt_4c_Complemento.txt_4c_DtLanc.Value)
2067:         loc_oBO.this_nToleras         = THIS.cnt_4c_Complemento.txt_4c_Toleras.Value
2068:     ENDPROC
2069: 
2070:     *====================================================================
2071:     * CmdSelecionarClick - equivalente ao Valid legado de cmdSelecionar
2072:     * ("ThisForm.Selecionar()", dump:10713-10715) - migrado para Click
2073:     * (evento confiavel para CommandButton via BINDEVENT neste
2074:     * projeto). Delega a selecao de operacoes candidatas ao BO
2075:     * (Fase 8/8 - ver nota no cabecalho do arquivo) e, com sucesso,
2076:     * repinta a grade e reproduz o bloco de habilitar/desabilitar do
2077:     * legado (dump:10265-10287): trava o filtro/periodo/processo,
2078:     * libera Limpar/Copiar/MarcaTudo/Desmarcar/Documentos/ChkMensa.
2079:     *====================================================================
2080:     PROCEDURE CmdSelecionarClick()
2081:         LOCAL loc_oCnt, loc_dIni, loc_dFin, loc_lProsseguir, loc_oErro
2082: 
2083:         loc_lProsseguir = .T.
2084: 
2085:         TRY
2086:             loc_oCnt = THIS.cnt_4c_Operacoes
2087: 
2088:             *-- Confirmacao de REPROCESSAMENTO (dump:9951-9958): escolher
2089:             *-- "Ja Processadas" avisa que o destino pode receber registros
2090:             *-- duplicados e, recusando, volta a opcao para 1.
2091:             IF loc_oCnt.obj_4c_OptProcessados.Value = 2
2092:                 IF !MsgConfirma("Confirma a Sele" + CHR(231) + CHR(227) + "o de Opera" + ;
2093:                         CHR(231) + CHR(245) + "es J" + CHR(225) + " Processadas Anteriormente?" + CHR(13) + ;
2094:                         "Este Processo Poder" + CHR(225) + " Lan" + CHR(231) + "ar Registros Duplicados no Destino no" + CHR(13) + ;
2095:                         "Caso dos Mesmos N" + CHR(227) + "o Terem Sido Anteriormente Exclu" + CHR(237) + "dos.", ;
2096:                         "Aten" + CHR(231) + CHR(227) + "o")
2097:                     loc_oCnt.obj_4c_OptProcessados.Value = 1
2098:                     loc_lProsseguir = .F.
2099:                 ENDIF
2100:             ENDIF
2101: 
2102:             *-- Validacao do periodo (dump:9995-10013) - com SetFocus no
2103:             *-- campo recusado, por isso fica aqui e nao no BO.
2104:             IF loc_lProsseguir
2105:                 loc_dIni = ConverterParaData(loc_oCnt.txt_4c_DtIni.Value)
2106:                 loc_dFin = ConverterParaData(loc_oCnt.txt_4c_DtFin.Value)
2107: 
2108:                 DO CASE
2109:                 CASE EMPTY(loc_dIni)
2110:                     MsgAviso("Data Inicial Inv" + CHR(225) + "lida", "")
2111:                     loc_oCnt.txt_4c_DtIni.SetFocus()
2112:                     loc_lProsseguir = .F.
2113: 
2114:                 CASE EMPTY(loc_dFin)
2115:                     MsgAviso("Data Final Inv" + CHR(225) + "lida", "")
2116:                     loc_oCnt.txt_4c_DtFin.SetFocus()
2117:                     loc_lProsseguir = .F.
2118: 
2119:                 CASE loc_dFin < loc_dIni
2120:                     MsgAviso("A Data Final N" + CHR(227) + "o Pode Ser Menor Que a Inicial", "")
2121:                     loc_oCnt.txt_4c_DtFin.SetFocus()
2122:                     loc_lProsseguir = .F.
2123:                 ENDCASE
2124:             ENDIF
2125: 
2126:             IF loc_lProsseguir
2127:                 THIS.AtualizarFiltroNoBO()
2128:             ENDIF
2129: 
2130:             IF loc_lProsseguir AND THIS.this_oBusinessObject.Selecionar()
2131:                 *-- O Selecionar do BO pode ter MUDADO a tolerancia (vem do
2132:                 *-- processo) e recuado a data inicial (processo que copia
2133:                 *-- fiscais): a tela tem de refletir isso.
2134:                 THIS.BOParaForm()
2135: 
2136:                 THIS.CarregarLista()
2137:                 THIS.AplicarOrdemGrade()
2138: 
2139:                 WITH THIS.cnt_4c_Operacoes
2140:                     .txt_4c_DtIni.Enabled                     = .F.
2141:                     .txt_4c_DtFin.Enabled                     = .F.
2142:                     .obj_4c_OptProcessados.Buttons(1).Enabled = .F.
2143:                     .obj_4c_OptProcessados.Buttons(2).Enabled = .F.
2144:                     .cbo_4c_CmbOperacoes.Enabled               = .F.
2145:                     .cmd_4c_CmdSelecionar.Enabled               = .F.
2146:                     .chk_4c_ChkMensa.Enabled                    = .T.
2147:                 ENDWITH
2148: 
2149:                 WITH THIS.cnt_4c_Filtro
2150:                     .txt_4c_EmpOs.Enabled  = .F.
2151:                     .txt_4c_DEmpOs.Enabled = .F.
2152:                     .txt_4c_EmpDs.Enabled  = .F.
2153:                     .txt_4c_DEmpDs.Enabled = .F.
2154:                 ENDWITH
2155: 
2156:                 WITH THIS.cnt_4c_Botoes.cmg_4c_CmdBtnForm
2157:                     .Buttons(1).Enabled = .T.
2158:                     .Buttons(2).Enabled = .T.
2159:                 ENDWITH
2160: 

*-- Linhas 2169 a 2486:
2169:         CATCH TO loc_oErro
2170:             MsgErro(loc_oErro.Message + CHR(13) + ;
2171:                 "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
2172:                 "Procedure: " + loc_oErro.Procedure, "Erro em CmdSelecionarClick")
2173:         ENDTRY
2174:     ENDPROC
2175: 
2176:     *====================================================================
2177:     * BOParaForm - devolve a tela os dois valores que o Selecionar() do
2178:     * BO altera, reproduzindo o que o legado faz escrevendo direto no
2179:     * controle de dentro do proprio Selecionar:
2180:     *
2181:     *   this_nToleras -> cnt_4c_Complemento.txt_4c_Toleras
2182:     *       ("ThisForm.cntComplemento.getToleras.Value =
2183:     *         crSigPcOop.Toleras" - dump:9967)
2184:     *   this_dDtIni   -> cnt_4c_Operacoes.txt_4c_DtIni
2185:     *       (processo que copia fiscais recua a data inicial em 5 dias:
2186:     *        "getDtIni.Value = getDtIni.Value - 5" + Refresh -
2187:     *        dump:9969-9974)
2188:     *
2189:     * Par de AtualizarFiltroNoBO (Form -> BO). Chamado por
2190:     * CmdSelecionarClick depois de Selecionar().
2191:     *====================================================================
2192:     PROCEDURE BOParaForm()
2193:         LOCAL loc_oBO
2194: 
2195:         loc_oBO = THIS.this_oBusinessObject
2196: 
2197:         IF VARTYPE(loc_oBO) != "O"
2198:             RETURN
2199:         ENDIF
2200: 
2201:         THIS.cnt_4c_Complemento.txt_4c_Toleras.Value = loc_oBO.this_nToleras
2202:         THIS.cnt_4c_Complemento.txt_4c_Toleras.Refresh()
2203: 
2204:         IF !EMPTY(loc_oBO.this_dDtIni)
2205:             THIS.cnt_4c_Operacoes.txt_4c_DtIni.Value = loc_oBO.this_dDtIni
2206:             THIS.cnt_4c_Operacoes.txt_4c_DtIni.Refresh()
2207:         ENDIF
2208:     ENDPROC
2209: 
2210:     *====================================================================
2211:     * AplicarOrdemGrade - ordena a grade pelo criterio escolhido no
2212:     * Processo de Copia (SigPcOoP.Ordems, lido por Selecionar() em
2213:     * this_nOrdemGrade). Equivalente ao
2214:     * "Select csOperacoes / Set Order To Operacao / Do Case ... Set
2215:     * Order To Data|Nota|Origem|Destino / Go Top" do legado
2216:     * (dump:10251-10263). Os TAGs sao criados com o cursor, em
2217:     * ConfigurarGrid.
2218:     *====================================================================
2219:     PROCEDURE AplicarOrdemGrade()
2220:         LOCAL loc_cCursor, loc_nOrdem, loc_oErro
2221: 
2222:         loc_cCursor = THIS.this_cCursorOperacoes
2223: 
2224:         IF !USED(loc_cCursor)
2225:             RETURN
2226:         ENDIF
2227: 
2228:         TRY
2229:             loc_nOrdem = THIS.this_oBusinessObject.this_nOrdemGrade
2230: 
2231:             SELECT (loc_cCursor)
2232: 
2233:             DO CASE
2234:             CASE loc_nOrdem = 2
2235:                 SET ORDER TO TAG Data
2236:             CASE loc_nOrdem = 3
2237:                 SET ORDER TO TAG Nota
2238:             CASE loc_nOrdem = 4
2239:                 SET ORDER TO TAG Origem
2240:             CASE loc_nOrdem = 5
2241:                 SET ORDER TO TAG Destino
2242:             OTHERWISE
2243:                 SET ORDER TO TAG Operacao
2244:             ENDCASE
2245: 
2246:             GO TOP
2247:             THIS.cnt_4c_Grade.grd_4c_Dados.Refresh()
2248:         CATCH TO loc_oErro
2249:             MsgErro(loc_oErro.Message + CHR(13) + ;
2250:                 "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
2251:                 "Procedure: " + loc_oErro.Procedure, "Erro em AplicarOrdemGrade")
2252:         ENDTRY
2253:     ENDPROC
2254: 
2255:     *====================================================================
2256:     * ChkFwcheckbox1InteractiveChange - equivalente ao InteractiveChange
2257:     * legado ("ThisForm.ShowTips = (This.Value = 1)", dump:10727-10729).
2258:     *====================================================================
2259:     PROCEDURE ChkFwcheckbox1InteractiveChange()
2260:         THIS.ShowTips = (THIS.cnt_4c_Operacoes.chk_4c_Fwcheckbox1.Value = 1)
2261:     ENDPROC
2262: 
2263:     *====================================================================
2264:     * LimpaSelecao - equivalente ao metodo legado "limpaselecao"
2265:     * (dump:5610-5647): limpa o cursor de operacoes candidatas e
2266:     * devolve o filtro/periodo/processo ao estado inicial (reabilita
2267:     * para nova selecao, desabilita Limpar/Copiar/MarcaTudo/Desmarcar/
2268:     * Documentos/ChkMensa - espelho exato do bloco Enabled do legado).
2269:     * Metodo autossuficiente - nao depende de nenhum metodo do BO ainda
2270:     * nao escrito.
2271:     *====================================================================
2272:     PROCEDURE LimpaSelecao()
2273:         LOCAL loc_cCursor, loc_oErro
2274: 
2275:         loc_cCursor = THIS.this_cCursorOperacoes
2276: 
2277:         TRY
2278:             IF USED(loc_cCursor)
2279:                 SELECT (loc_cCursor)
2280:                 ZAP
2281:             ENDIF
2282: 
2283:             WITH THIS.cnt_4c_Operacoes
2284:                 .txt_4c_DtIni.Enabled                     = .T.
2285:                 .txt_4c_DtFin.Enabled                     = .T.
2286:                 .cbo_4c_CmbOperacoes.Enabled               = .T.
2287:                 .cmd_4c_CmdSelecionar.Enabled               = .T.
2288:                 .obj_4c_OptProcessados.Buttons(1).Enabled = .T.
2289:                 .obj_4c_OptProcessados.Buttons(2).Enabled = .T.
2290:                 .chk_4c_ChkMensa.Enabled                    = .F.
2291:             ENDWITH
2292: 
2293:             WITH THIS.cnt_4c_Filtro
2294:                 .txt_4c_EmpOs.Enabled  = .T.
2295:                 .txt_4c_DEmpOs.Enabled = .T.
2296:                 .txt_4c_EmpDs.Enabled  = .T.
2297:                 .txt_4c_DEmpDs.Enabled = .T.
2298:             ENDWITH
2299: 
2300:             WITH THIS.cnt_4c_Botoes.cmg_4c_CmdBtnForm
2301:                 .Buttons(1).Enabled = .F.
2302:                 .Buttons(2).Enabled = .F.
2303:             ENDWITH
2304: 
2305:             WITH THIS.cmg_4c_CmdBtnGrade
2306:                 .Buttons(1).Enabled = .F.
2307:                 .Buttons(2).Enabled = .F.
2308:                 .Buttons(3).Enabled = .F.
2309:             ENDWITH
2310: 
2311:             THIS.CarregarLista()
2312:             THIS.Refresh()
2313:         CATCH TO loc_oErro
2314:             MsgErro(loc_oErro.Message + CHR(13) + ;
2315:                 "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
2316:                 "Procedure: " + loc_oErro.Procedure, "Erro em LimpaSelecao")
2317:         ENDTRY
2318:     ENDPROC
2319: 
2320:     *====================================================================
2321:     * CmdBtnFormClick - equivalente ao Click de cmdBtnForm (dump:10809-
2322:     * 10897): Value=1 Limpar -> THIS.LimpaSelecao(); Value=2 Copiar ->
2323:     * guarda de selecao (regra CLAUDE.md #50 - "Select SelImp, Count(1)
2324:     * ... Where SelImp ... If Selecionados < 1" do legado, aqui via
2325:     * COUNT TO ... FOR SelImp apos SELECT do alias - regra CLAUDE.md
2326:     * "COUNT TO var IN alias PROIBIDO") seguida de THIS.
2327:     * this_oBusinessObject.Processamento() (Fase 8/8 - ver nota no
2328:     * cabecalho do arquivo); Value=3 Encerrar -> THIS.Release()
2329:     * (equivalente a "ThisForm.Release" do btnSair, dump:10885-10897).
2330:     *====================================================================
2331:     PROCEDURE CmdBtnFormClick()
2332:         LOCAL loc_oGrupo, loc_cCursor, loc_nSelecionados, loc_oErro
2333: 
2334:         loc_oGrupo  = THIS.cnt_4c_Botoes.cmg_4c_CmdBtnForm
2335:         loc_cCursor = THIS.this_cCursorOperacoes
2336: 
2337:         TRY
2338:             DO CASE
2339:             CASE loc_oGrupo.Value = 1 AND loc_oGrupo.Buttons(1).Enabled
2340:                 THIS.LimpaSelecao()
2341: 
2342:             CASE loc_oGrupo.Value = 2 AND loc_oGrupo.Buttons(2).Enabled
2343:                 loc_nSelecionados = 0
2344:                 IF USED(loc_cCursor)
2345:                     SELECT (loc_cCursor)
2346:                     COUNT TO loc_nSelecionados FOR SelImp
2347:                 ENDIF
2348: 
2349:                 IF loc_nSelecionados < 1
2350:                     MsgAviso("Nenhum Lan" + CHR(231) + "amento Foi Encontrado!!!", "Aten" + CHR(231) + CHR(227) + "o")
2351:                     THIS.cnt_4c_Operacoes.cbo_4c_CmbOperacoes.SetFocus
2352:                 ELSE
2353:                     *-- Fecho do legado, comum ao Processamento e ao
2354:                     *-- Financeiro (dump:9933-9934 e 2761-2762): copia
2355:                     *-- concluida devolve a tela ao estado inicial e refaz a
2356:                     *-- selecao, para o usuario ver o que ainda falta copiar.
2357:                     IF THIS.this_oBusinessObject.Processamento()
2358:                         THIS.LimpaSelecao()
2359:                         THIS.CmdSelecionarClick()
2360:                     ENDIF
2361:                 ENDIF
2362: 
2363:             CASE loc_oGrupo.Value = 3
2364:                 THIS.Release()
2365:             ENDCASE
2366:         CATCH TO loc_oErro
2367:             MsgErro(loc_oErro.Message + CHR(13) + ;
2368:                 "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
2369:                 "Procedure: " + loc_oErro.Procedure, "Erro em CmdBtnFormClick")
2370:         ENDTRY
2371:     ENDPROC
2372: 
2373:     *====================================================================
2374:     * CmdBtnGradeClick - equivalente ao Click de cmdBtnGrade (dump:
2375:     * 10488-10513): Value=1 Marca Tudo / Value=2 Desmarcar (REPLACE ALL
2376:     * SelImp na cursor_4c_Operacoes + GO TOP + Refresh) / Value=3
2377:     * Documentos (abre FormSigMvExp para a operacao corrente da grade,
2378:     * ou avisa se Deletado - equivalente a "Do Form SigMvExp With
2379:     * csOperacoes.Dopes, 'C', csOperacoes.Numes, csOperacoes.Emps,
2380:     * .t."). Metodo autossuficiente.
2381:     *====================================================================
2382:     PROCEDURE CmdBtnGradeClick()
2383:         LOCAL loc_oGrupo, loc_cCursor, loc_oForm, loc_oErro
2384: 
2385:         loc_oGrupo  = THIS.cmg_4c_CmdBtnGrade
2386:         loc_cCursor = THIS.this_cCursorOperacoes
2387: 
2388:         IF !USED(loc_cCursor)
2389:             RETURN
2390:         ENDIF
2391: 
2392:         TRY
2393:             DO CASE
2394:             CASE loc_oGrupo.Value = 1 AND loc_oGrupo.Buttons(1).Enabled
2395:                 SELECT (loc_cCursor)
2396:                 REPLACE ALL SelImp WITH .T.
2397:                 GO TOP
2398:                 THIS.cnt_4c_Grade.grd_4c_Dados.Refresh()
2399: 
2400:             CASE loc_oGrupo.Value = 2 AND loc_oGrupo.Buttons(2).Enabled
2401:                 SELECT (loc_cCursor)
2402:                 REPLACE ALL SelImp WITH .F.
2403:                 GO TOP
2404:                 THIS.cnt_4c_Grade.grd_4c_Dados.Refresh()
2405: 
2406:             CASE loc_oGrupo.Value = 3 AND loc_oGrupo.Buttons(3).Enabled
2407:                 SELECT (loc_cCursor)
2408:                 IF !EOF()
2409:                     IF Deletado
2410:                         MsgAviso("Essa Opera" + CHR(231) + CHR(227) + "o Foi Exclu" + CHR(237) + "da do Sistema!!!", "Aten" + CHR(231) + CHR(227) + "o!!!")
2411:                     ELSE
2412:                         loc_oForm = CREATEOBJECT("FormSigMvExp", Dopes, "C", Numes, Emps, .T.)
2413:                         IF VARTYPE(loc_oForm) = "O"
2414:                             loc_oForm.Show()
2415:                         ENDIF
2416:                     ENDIF
2417:                 ENDIF
2418:             ENDCASE
2419:         CATCH TO loc_oErro
2420:             MsgErro(loc_oErro.Message + CHR(13) + ;
2421:                 "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
2422:                 "Procedure: " + loc_oErro.Procedure, "Erro em CmdBtnGradeClick")
2423:         ENDTRY
2424:     ENDPROC
2425: 
2426:     *====================================================================
2427:     * Check1Click/KeyPress/MouseDown/MouseUp - toggle da marcacao
2428:     * (SelImp) da coluna 1 da grade. NODEFAULT nos 4 (equivalente ao
2429:     * legado, dump:10523-10575): o toggle nativo do CheckBox e
2430:     * SUPRIMIDO e o REPLACE e feito a mao, igual ao legado ("m.SelImp =
2431:     * (Not csOperacoes.SelImp) / Gather Memvar Fields SelImp"), regra
2432:     * CLAUDE.md #46 (Valid/KeyPress da celula, nao AfterRowColChange).
2433:     *====================================================================
2434:     PROCEDURE Check1Click()
2435:         NODEFAULT
2436:     ENDPROC
2437: 
2438:     PROCEDURE Check1KeyPress(par_nKeyCode, par_nShiftAltCtrl)
2439:         LOCAL loc_cCursor
2440: 
2441:         IF INLIST(par_nKeyCode, 13, 32)
2442:             loc_cCursor = THIS.this_cCursorOperacoes
2443:             IF USED(loc_cCursor)
2444:                 SELECT (loc_cCursor)
2445:                 REPLACE SelImp WITH !SelImp
2446:                 THIS.cnt_4c_Grade.grd_4c_Dados.Refresh()
2447:             ENDIF
2448:             NODEFAULT
2449:         ENDIF
2450:     ENDPROC
2451: 
2452:     PROCEDURE Check1MouseDown(par_nButton, par_nShift, par_nXCoord, par_nYCoord)
2453:         LOCAL loc_cCursor
2454: 
2455:         loc_cCursor = THIS.this_cCursorOperacoes
2456:         IF USED(loc_cCursor)
2457:             SELECT (loc_cCursor)
2458:             REPLACE SelImp WITH !SelImp
2459:             THIS.cnt_4c_Grade.grd_4c_Dados.Refresh()
2460:         ENDIF
2461:         NODEFAULT
2462:     ENDPROC
2463: 
2464:     PROCEDURE Check1MouseUp(par_nButton, par_nShift, par_nXCoord, par_nYCoord)
2465:         NODEFAULT
2466:     ENDPROC
2467: 
2468:     *====================================================================
2469:     * Destroy - fecha o cursor da grade de operacoes e o cursor da lista
2470:     * de Processos de Copia (RowSource do combo) e encadeia para
2471:     * FormBase.Destroy() (libera this_oBusinessObject e restaura o
2472:     * menu principal).
2473:     *====================================================================
2474:     PROCEDURE Destroy()
2475:         IF !EMPTY(THIS.this_cCursorOperacoes) AND USED(THIS.this_cCursorOperacoes)
2476:             USE IN (THIS.this_cCursorOperacoes)
2477:         ENDIF
2478: 
2479:         IF !EMPTY(THIS.this_cCursorProcessos) AND USED(THIS.this_cCursorProcessos)
2480:             USE IN (THIS.this_cCursorProcessos)
2481:         ENDIF
2482: 
2483:         DODEFAULT()
2484:     ENDPROC
2485: 
2486: ENDDEFINE


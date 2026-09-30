# CODE REVIEW - PASS FUNCTIONAL: Functional Logic (metodos, eventos, containers)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Functional Logic (metodos, eventos, containers)**.

## PROBLEMAS DETECTADOS (2)
- [METODO-INEXISTENTE] Metodo 'THIS.ValidarEnvio()' chamado mas NAO definido como PROCEDURE no Form nem herdado de FormBase. A LLM pode ter inventado este metodo. VERIFICAR se existe no legado e IMPLEMENTAR ou REMOVER a chamada.
- [GRID-WITH] Bloco WITH loc_oGrid define .RecordSource E acessa .Column dentro do mesmo WITH. Isso causa 'Unknown member COLUMN1' porque colunas nao sao criadas imediatamente dentro de WITH. SOLUCAO: Mover .RecordSource e .ColumnCount para FORA do WITH (usar referencia explicita: loc_oGrid.RecordSource).

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

### FORM (C:\4c\projeto\app\forms\operacionais\Formsigprema.prg) - TRECHOS RELEVANTES PARA PASS FUNCTIONAL (956 linhas total):

*-- Linhas 18 a 125:
18: *
19: * Historico de fases:
20: *   Fase 1/2: sigpremaBO.prg (propriedades + metodos de negocio completos)
21: *   Fase 3:   Formsigprema.prg - estrutura base (heranca, Init, InicializarForm,
22: *             ConfigurarCabecalho, TornarControlesVisiveis, Destroy)
23: *   Fase 4:   Grid grd_4c_Dados (5 colunas: Checks/Contas/Rclis/Emails/
24: *             EmpDopNums), botoes standalone cmd_4c_SelTudo/cmd_4c_Apaga
25: *             (legado SelTudo/apaga - nao ha container no SCX original),
26: *             cmg_4c_Encerrar (legado Commandgroup1/btnSair), cmd_4c_EnviarEmail
27: *             (legado btnEmail) e shp_4c_Decoracao (legado Shape1). CarregarDados
28: *             (BO.BuscarDadosProcessamento) e todos os handlers (ordenacao por
29: *             coluna, toggle de Checks, Marcar/Desmarcar Todos, Encerrar e envio
30: *             de e-mail via BO.EnviarEmailSelecionados) ja ligados nesta fase -
31: *             o BO ja tinha tudo pronto desde a Fase 1/2.
32: *   Fase 5:   Conferido campo a campo contra tasks\task602\layout.json e
33: *             sigprema_form_codigo_fonte.txt - forms OPERACIONAL FLAT como
34: *             este nao tem Page2/Dados com TextBoxes individuais (o "dado" da
35: *             tela inteira e' a lista do grd_4c_Dados, ja migrado na Fase 4).
36: *             Nao ha mais controles do SCX para adicionar. Dois eventos do
37: *             legado ficaram sem correspondente explicito e sao documentados
38: *             aqui para a ausencia ser auditavel, nao parecer esquecimento
39: *             (mesmo padrao de FormSigMvExp/FormSigMvMen):
40: *               Load ("=fConfigGeral()") - NAO PORTADO. fConfigGeral era
41: *               funcao GLOBAL de inicializacao da aplicacao legado; na
42: *               arquitetura nova esse papel e' do start\config.prg (roda uma
43: *               vez no startup). O wrapper utils\fconfiggeral.prg existe so
44: *               para o p-code dos VCX legado que ainda o chama (regra #27) -
45: *               codigo nosso nao o chama.
46: *               SIGPREMA.Registry1 / "ThisForm.btnEmail.Enabled =
47: *               ThisForm.Registry1.IsKey('PDFCreator.clsPDFCreator') Or
48: *               ThisForm.Registry1.IsKey('PDFCreatorBeta.JobQueue')" - NAO
49: *               PORTADO. No legado essa checagem so faz sentido porque
50: *               btnEmail.Click chama ImpDocto/criapdf (geracao do PDF anexo
51: *               via COM do PDFCreator), e o botao ficava desabilitado se o
52: *               PDFCreator nao estivesse instalado na maquina. Essa geracao
53: *               de anexo esta fora do escopo desta migracao (ver cabecalho de
54: *               sigpremaBO.prg - this_cArquivoEmail fica a cargo do Form/
55: *               futura integracao com relatorios), e o envio de e-mail via
56: *               BO.EnviarEmailSelecionados NAO depende de PDFCreator. Copiar
57: *               a checagem sem a funcionalidade que ela protege desabilitaria
58: *               o botao de Enviar Email em toda maquina sem PDFCreator, sem
59: *               nenhum ganho - seria pior que o legado, nao fiel a ele.
60: *   Fase 6:   LOOKUPS - nenhum. Conferido contra sigprema_form_codigo_fonte.txt
61: *             e analise.json ("lookups": []) procurando fwbuscaext, fwBuscaSel,
62: *             fwBuscaInt, mAddColuna, sigacess, Acesso* e PROCEDURE Valid com
63: *             busca: zero ocorrencias. Criar AbrirLookup*/AbrirBusca* aqui
64: *             seria INVENTAR tabela de lookup que o legado nao consulta
65: *             (violaria o PILAR 1 e a regra "NUNCA inventar tabelas de lookup").
66: *
67: *             CAMPOS RESTANTES - este form OPERACIONAL e' FLAT (sem PageFrame
68: *             Page1/Page2, ver Fase 3/5): nao existe "Page2 de Dados", o dado
69: *             da tela e' a lista crLocalTotal/cursor_4c_Dados exibida em
70: *             grd_4c_Dados, ja montada por inteiro na Fase 4. Conferidos os 5
71: *             ControlSource e os ReadOnly contra o SCX (Column6/ColumnOrder=1
72: *             = Checks W=17 RO=.F.; Column2 Conta W=80 RO=.T.; Column3 Nome
73: *             W=290 RO=.T.; Column4 Email W=290 RO=.F.; Column5 EmpDopNums
74: *             W=290 RO=.T.) - batem. Todos os controles do SCX ja foram migrados.
75: *
76: *             O que esta fase ACRESCENTA e' a validacao da unica celula
77: *             digitavel da tela, a coluna Email (Column4, a unica com
78: *             ReadOnly = .F. no SCX legado), que ate aqui nao tinha handler
79: *             nenhum:
80: *               ValidarEmailLinha / ValidarEmailLinhaKeyPress - normaliza o
81: *               e-mail digitado (LOWER + ALLTRIM, a mesma normalizacao que o
82: *               legado ja aplica no momento do envio) e grava de volta no
83: *               cursor, para o que aparece na grade ser igual ao que sai no
84: *               campo "Para". Ligados por KeyPress (ENTER/TAB) + LostFocus -
85: *               "Valid" nao dispara via BINDEVENT em TextBox.
86: *               ValidarEnvio - conferencia previa chamada por
87: *               BtnProcessarEmailClick, reproduzindo os dois criterios que o
88: *               proprio btnEmail.Click legado aplica sobre as linhas
89: *               ("Where Checks = 1" e "If IsEmpty(...emails) / Loop").
90: *               DESVIO DELIBERADO do legado, restrito a mensagem/aborto: no
91: *               legado esses dois casos sao silenciosos e a tela exibe
92: *               "Email enviado com sucesso!" e se fecha sem ter enviado nada
93: *               (o SCAN nao executa nenhuma iteracao e "llOk" continua .T.).
94: *               Nao reproduzir isso e' exigencia de CLAUDE.md #20 e da regra
95: *               de nunca anunciar sucesso sem ter havido o que processar. O
96: *               release do modo automatico continua incondicional, como no
97: *               legado.
98: *   Fase 7:   EVENTOS PRINCIPAIS - este form OPERACIONAL nao tem CRUD (o
99: *             legado SIGPREMA.SCX nao herda de frmcadastro, nao tem Grupo_Op
100: *             nem pcEscolha - e' so cabecalho + grade + botoes de acao direto
101: *             no form, ver layout.json/comportamento.json). Os 4 botoes reais
102: *             do legado (Commandgroup1/btnSair, btnEmail, SelTudo, apaga) ja
103: *             tinham handler completo desde a Fase 4 (BtnProcessarEmailClick/
104: *             BtnSelTudoClick/BtnApagaClick + o botao de saida). Criar
105: *             BtnIncluirClick/BtnAlterarClick/BtnVisualizarClick/
106: *             BtnExcluirClick aqui seria inventar CRUD que o legado nao tem
107: *             (violaria o PILAR 1). Unico ajuste desta fase: o handler do
108: *             botao de saida estava nomeado CmgEncerrarClick (prefixo do
109: *             objeto cmg_4c_Encerrar, nao da convencao de handler Btn/Cmd) -
110: *             renomeado para BtnEncerrarClick, consistente com os demais
111: *             handlers de botao do form.
112: *   Fase 8:   EVENTOS AUXILIARES E CONSOLIDACAO FINAL - conferencia final
113: *             deste form OPERACIONAL FLAT contra a lista canonica de metodos
114: *             de fechamento de fase (BtnBuscarClick/BtnEncerrarClick/
115: *             BtnSalvarClick/BtnCancelarClick/FormParaBO/BOParaForm/
116: *             HabilitarCampos/LimparCampos/CarregarLista/
117: *             AjustarBotoesPorModo). Essa lista e' convencao de form CRUD
118: *             (frmcadastro com Page1=Lista/Page2=Dados e modos INCLUIR/
119: *             ALTERAR/VISUALIZAR/EXCLUIR); o SIGPREMA legado nao tem NENHUMA
120: *             dessa estrutura (confirmado de novo aqui, no fechamento da
121: *             migracao, contra sigprema_form_codigo_fonte.txt):
122: *               BtnBuscarClick   - NAO SE APLICA. O legado nao tem campo de
123: *                 filtro/busca nenhum (grep por "buscar"/"filtro"/"pesquis"
124: *                 no dump: zero ocorrencias) - a grade e' populada por
125: *                 inteiro no Init (equivalente a CarregarDados/

*-- Linhas 156 a 371:
156: *                 transferem os campos de UMA ficha entre Form e BO; esta
157: *                 tela nao edita um registro por vez, opera em LOTE sobre as
158: *                 linhas de cursor_4c_Dados (equivalente a crLocalTotal) via
159: *                 ChkChecksInteractiveChange (grava direto no cursor) e
160: *                 ValidarEmailLinha (idem) - o "de-para" delas ja existe,
161: *                 so que na granularidade de LINHA da grade, nao de FICHA.
162: *               HabilitarCampos/LimparCampos - NAO SE APLICAM. Nao ha modo
163: *                 INCLUIR/ALTERAR/VISUALIZAR/EXCLUIR nem campos de ficha a
164: *                 habilitar/limpar - a UNICA celula editavel (Column4/
165: *                 Emails) fica sempre editavel, como no SCX legado
166: *                 (Column4.ReadOnly = .F. incondicional).
167: *               AjustarBotoesPorModo - NAO SE APLICA. Nao ha "modo" de tela
168: *                 (LISTA/INCLUIR/ALTERAR/VISUALIZAR) cujos botoes mudem de
169: *                 Enabled - os 4 botoes do legado (Enviar Email, Marcar
170: *                 Todos, Desmarcar Todos, Encerrar) ficam sempre habilitados.
171: *               CarregarLista - EQUIVALENTE JA EXISTE desde a Fase 3/4:
172: *                 CarregarDados() (que delega a
173: *                 sigpremaBO.BuscarDadosProcessamento) e' chamado em
174: *                 InicializarForm() e alimenta grd_4c_Dados, exatamente o
175: *                 papel que CarregarLista tem nos forms CRUD. O nome
176: *                 CarregarDados foi mantido (em vez de CarregarLista) porque
177: *                 e' o mesmo dado que a Fase 6 ja documentou como "a tela
178: *                 inteira e' a lista" - nao ha uma segunda fonte de dados
179: *                 (Page2/ficha) para o nome "Lista" precisar distinguir.
180: *
181: *             Nenhum metodo novo foi criado nesta fase (a unica mudanca de
182: *             codigo foi a renomeacao do handler de acao descrita acima): os
183: *             4 botoes reais do legado e a carga da grade ja estavam
184: *             completos e testados desde as Fases 3, 4 e 6. Revisao final contra
185: *             comportamento.json confirma que os unicos PROCEDURE do dump
186: *             ainda sem correspondente no migrado sao os ja documentados nas
187: *             Fases 5/6 como fora de escopo (criapdf/documento/impdocto -
188: *             cadeia de geracao de PDF via COM PDFCreator.clsPDFCreator +
189: *             REPORT FORM SigReDc2 + chamada a quatro outras telas de
190: *             relatorio - SigPrIdc/SigReIfx/SigReJob/SigOpIgm/SigReIiv -
191: *             nenhuma delas parte desta migracao; e Load/=fConfigGeral(),
192: *             papel que start\config.prg ja cumpre no startup da aplicacao
193: *             nova). memail (o corpo real de envio via CDO.Message) ja esta
194: *             transcrito em sigpremaBO.EnviarEmail desde a Fase 1/2.
195: *==============================================================================
196: DEFINE CLASS Formsigprema AS FormBase
197: 
198:     *-- Business Object
199:     this_oBusinessObject = .NULL.
200: 
201:     *-- Parametros recebidos no Init (equivalentes a prDopes/pAuto do legado)
202:     this_cDopesFiltro = ""    && prDopes - EmpDopNums para filtrar 1 movimento
203:     this_lAutomatico  = .F.   && pAuto - .T. quando chamado em modo automatico
204: 
205:     *-- Propriedades visuais (PILAR 1 - valores exatos do SCX legado)
206:     Top         = 0
207:     Left        = 0
208:     Height      = 600
209:     Width       = 1000
210:     BorderStyle = 2
211:     AutoCenter  = .T.
212:     TitleBar    = 0
213:     ShowWindow  = 1
214:     WindowType  = 1
215:     ControlBox  = .F.
216:     MaxButton   = .F.
217:     MinButton   = .F.
218:     Caption     = "Processamento e Gera" + CHR(231) + CHR(227) + "o de Email"
219:     FontName    = "Tahoma"
220:     FontSize    = 8
221: 
222:     *--------------------------------------------------------------------------
223:     * Init - Recebe os parametros equivalentes a prDopes/pAuto do legado
224:     *--------------------------------------------------------------------------
225:     PROCEDURE Init(par_cDopes, par_lAutomatico)
226:         THIS.this_cDopesFiltro = IIF(VARTYPE(par_cDopes) = "C", par_cDopes, "")
227:         THIS.this_lAutomatico  = IIF(VARTYPE(par_lAutomatico) = "L", par_lAutomatico, .F.)
228: 
229:         *-- DODEFAULT() dispara FormBase.Init() que chama THIS.InicializarForm()
230:         RETURN DODEFAULT()
231:     ENDPROC
232: 
233:     *--------------------------------------------------------------------------
234:     * InicializarForm - Chamado por FormBase.Init via DODEFAULT
235:     *--------------------------------------------------------------------------
236:     PROTECTED PROCEDURE InicializarForm()
237:         LOCAL loc_lSucesso, loc_oErro
238:         loc_lSucesso = .F.
239: 
240:         TRY
241:             THIS.this_oBusinessObject = CREATEOBJECT("sigpremaBO")
242: 
243:             IF VARTYPE(THIS.this_oBusinessObject) != "O"
244:                 MsgErro("Erro ao criar sigpremaBO." + CHR(13) + ;
245:                     "VARTYPE retornou: " + VARTYPE(THIS.this_oBusinessObject), ;
246:                     "Formsigprema.InicializarForm")
247:             ELSE
248:                 IF TYPE("gb_4c_ValidandoUI") != "L" OR !gb_4c_ValidandoUI
249:                     IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
250:                         MsgErro("Imposs" + CHR(237) + "vel Efetuar Conex" + CHR(227) + ;
251:                                 "o Com o Servidor de Banco de Dados...", ;
252:                                 "Conex" + CHR(227) + "o")
253:                     ENDIF
254:                 ENDIF
255: 
256:                 THIS.ConfigurarCabecalho()
257: 
258:                 *-- Grid.ColumnN.ControlSource exige o cursor JA existente (CLAUDE.md
259:                 *-- regra #41) - por isso o cursor eh criado/populado ANTES de montar
260:                 *-- o Grid. Em validacao de UI (sem SQL) usa placeholder vazio com a
261:                 *-- MESMA estrutura, igual ao padrao ja usado nos forms CRUD.
262:                 IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
263:                     THIS.CriarCursorPlaceholder()
264:                 ELSE
265:                     THIS.CarregarDados()
266:                 ENDIF
267: 
268:                 THIS.ConfigurarGrid()
269:                 THIS.ConfigurarBotoes()
270: 
271:                 THIS.TornarControlesVisiveis(THIS)
272: 
273:                 *-- Equivalente ao "If ThisForm.Automatico / ThisForm.btnEmail.Click() /
274:                 *-- ThisForm.Release / Return .f." do Init legado - so dispara quando o
275:                 *-- Form foi explicitamente criado em modo automatico (par_lAutomatico=.T.),
276:                 *-- nunca no fluxo interativo padrao nem em validacao de UI.
277:                 IF THIS.this_lAutomatico AND (TYPE("gb_4c_ValidandoUI") != "L" OR !gb_4c_ValidandoUI)
278:                     THIS.BtnProcessarEmailClick()
279:                 ENDIF
280: 
281:                 loc_lSucesso = .T.
282:             ENDIF
283:         CATCH TO loc_oErro
284:             MsgErro(loc_oErro.Message + CHR(13) + ;
285:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
286:                 "Procedure: " + loc_oErro.Procedure, ;
287:                 "Erro Formsigprema.InicializarForm")
288:         ENDTRY
289: 
290:         RETURN loc_lSucesso
291:     ENDPROC
292: 
293:     *--------------------------------------------------------------------------
294:     * CriarCursorPlaceholder - Estrutura vazia de cursor_4c_Dados usada apenas
295:     * quando gb_4c_ValidandoUI esta ativo (sem SQL disponivel), para o Grid ter
296:     * um cursor valido para ligar o ControlSource (CLAUDE.md regra #41).
297:     * Estrutura IDENTICA a criada em sigpremaBO.BuscarDadosProcessamento.
298:     *--------------------------------------------------------------------------
299:     PROTECTED PROCEDURE CriarCursorPlaceholder()
300:         IF USED("cursor_4c_Dados")
301:             USE IN cursor_4c_Dados
302:         ENDIF
303: 
304:         SET NULL ON
305:         CREATE CURSOR cursor_4c_Dados ;
306:             (Checks N(1) NULL, Grupos C(10) NULL, Contas C(10) NULL, ;
307:              Rclis C(50) NULL, Emails C(50) NULL, Mensagens M NULL, ;
308:              EmpDopNums C(29) NULL, Prioridade C(15) NULL)
309:         SET NULL OFF
310: 
311:         INDEX ON Contas TAG Contas
312:         INDEX ON Rclis  TAG Rclis
313:         INDEX ON Emails TAG Emails
314:     ENDPROC
315: 
316:     *--------------------------------------------------------------------------
317:     * CarregarDados - Popula cursor_4c_Dados (equivalente a crLocalTotal do
318:     * legado) via sigpremaBO.BuscarDadosProcessamento, usando o filtro recebido
319:     * no Init do form (this_cDopesFiltro - equivalente a prDopes do legado).
320:     * Erros de SQL ja sao exibidos dentro do proprio BO.
321:     *--------------------------------------------------------------------------
322:     PROTECTED PROCEDURE CarregarDados()
323:         THIS.this_oBusinessObject.BuscarDadosProcessamento(THIS.this_cDopesFiltro)
324:     ENDPROC
325: 
326:     *--------------------------------------------------------------------------
327:     * ConfigurarCabecalho - Constroi a faixa cinza superior do form
328:     * Equivalente ao cntSombra do SCX legado. Forms OPERACIONAIS nao usam
329:     * PageFrame CRUD - o cabecalho eh um container direto no form.
330:     *--------------------------------------------------------------------------
331:     PROTECTED PROCEDURE ConfigurarCabecalho()
332:         LOCAL loc_oErro
333: 
334:         TRY
335:             THIS.AddObject("cnt_4c_Sombra", "Container")
336:             WITH THIS.cnt_4c_Sombra
337:                 .Top         = 0
338:                 .Left        = 0
339:                 .Width       = THIS.Width
340:                 .Height      = 80
341:                 .BackColor   = RGB(100, 100, 100)
342:                 .BackStyle   = 1
343:                 .BorderWidth = 0
344: 
345:                 .AddObject("lbl_4c_Sombra", "Label")
346:                 WITH .lbl_4c_Sombra
347:                     .Top       = 18
348:                     .Left      = 10
349:                     .Width     = THIS.Width
350:                     .Height    = 40
351:                     .FontBold  = .T.
352:                     .FontName  = "Tahoma"
353:                     .FontSize  = 18
354:                     .AutoSize  = .F.
355:                     .BackStyle = 0
356:                     .WordWrap  = .T.
357:                     .Alignment = 0
358:                     .ForeColor = RGB(0, 0, 0)
359:                     .Caption   = THIS.Caption
360:                 ENDWITH
361: 
362:                 .AddObject("lbl_4c_Titulo", "Label")
363:                 WITH .lbl_4c_Titulo
364:                     .Top       = 17
365:                     .Left      = 10
366:                     .Width     = THIS.Width
367:                     .Height    = 46
368:                     .FontBold  = .T.
369:                     .FontName  = "Tahoma"
370:                     .FontSize  = 18
371:                     .AutoSize  = .F.

*-- Linhas 381 a 438:
381:         CATCH TO loc_oErro
382:             MsgErro(loc_oErro.Message + CHR(13) + ;
383:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
384:                 "Procedure: " + loc_oErro.Procedure, ;
385:                 "Erro Formsigprema.ConfigurarCabecalho")
386:         ENDTRY
387:     ENDPROC
388: 
389:     *--------------------------------------------------------------------------
390:     * ConfigurarGrid - Monta grd_4c_Dados (equivalente ao grade/fwgrade do
391:     * legado) ligado a cursor_4c_Dados. Ordem das colunas eh a ordem VISUAL do
392:     * legado (Checks/Contas/Rclis/Emails/EmpDopNums) - por isso nao precisamos
393:     * de ColumnOrder (propriedade a evitar, causa desalinhamento).
394:     *
395:     * cursor_4c_Dados DEVE existir antes desta chamada (CriarCursorPlaceholder
396:     * ou CarregarDados, chamados em InicializarForm) - CLAUDE.md regra #41.
397:     *--------------------------------------------------------------------------
398:     PROTECTED PROCEDURE ConfigurarGrid()
399:         LOCAL loc_oGrid, loc_oErro
400: 
401:         TRY
402:             THIS.AddObject("grd_4c_Dados", "Grid")
403:             loc_oGrid = THIS.grd_4c_Dados
404: 
405:             WITH loc_oGrid
406:                 .Top        = 126
407:                 .Left       = 3
408:                 .Width      = 993
409:                 .Height     = 469
410:                 .FontName   = "Verdana"
411:                 .FontSize   = 8
412:                 .RowHeight  = 18
413:                 .RecordMark = .F.
414:                 .DeleteMark = .F.
415:                 .ReadOnly   = .F.
416: 
417:                 .ColumnCount  = 5
418:                 .RecordSource = "cursor_4c_Dados"
419: 
420:                 *-- ControlSource das colunas de texto (logo apos o RecordSource -
421:                 *-- CLAUDE.md: RecordSource reseta customizacoes de coluna)
422:                 .Column2.ControlSource = "cursor_4c_Dados.Contas"
423:                 .Column3.ControlSource = "cursor_4c_Dados.Rclis"
424:                 .Column4.ControlSource = "cursor_4c_Dados.Emails"
425:                 .Column5.ControlSource = "cursor_4c_Dados.EmpDopNums"
426: 
427:                 *-- Coluna de selecao (equivalente ao Column6/fwcheckbox1 legado) -
428:                 *-- AddObject + CurrentControl OBRIGATORIAMENTE antes do ControlSource
429:                 *-- (CLAUDE.md regra #18)
430:                 .Column1.AddObject("chk_4c_Checks", "CheckBox")
431:                 WITH .Column1.chk_4c_Checks
432:                     .Caption   = ""
433:                     .Alignment = 0
434:                     .Value     = 0
435:                     .BackStyle = 0
436:                     .Visible   = .T.
437:                 ENDWITH
438:                 .Column1.CurrentControl = "chk_4c_Checks"

*-- Linhas 476 a 956:
476:                 .Visible = .T.
477:             ENDWITH
478: 
479:             BINDEVENT(loc_oGrid.Column1.chk_4c_Checks, "InteractiveChange", THIS, "ChkChecksInteractiveChange")
480: 
481:             *-- Column4 (Emails) e' a UNICA celula digitavel da grade, tanto no
482:             *-- legado (Column4.ReadOnly = .F. no SCX, contra .T. das demais)
483:             *-- quanto aqui. O que o usuario digitar nela e' exatamente o que
484:             *-- vai para o campo "Para"/"Cc" do envio, entao o valor precisa ser
485:             *-- normalizado e conferido ANTES de sair da celula.
486:             *-- "Valid" NAO dispara via BINDEVENT em TextBox (CLAUDE.md) - o
487:             *-- equivalente e' KeyPress (ENTER/TAB) + LostFocus.
488:             BINDEVENT(loc_oGrid.Column4.Text1, "KeyPress",  THIS, "ValidarEmailLinhaKeyPress")
489:             BINDEVENT(loc_oGrid.Column4.Text1, "LostFocus", THIS, "ValidarEmailLinha")
490: 
491:             BINDEVENT(loc_oGrid.Column2.Header1, "Click", THIS, "HeaderContasClick")
492:             BINDEVENT(loc_oGrid.Column3.Header1, "Click", THIS, "HeaderRclisClick")
493:             BINDEVENT(loc_oGrid.Column4.Header1, "Click", THIS, "HeaderEmailsClick")
494: 
495:             *-- Equivalente a "Thisform.grade.column3.header1.Click()" no fim do
496:             *-- Init legado - ordena por Nome (Rclis) e destaca o header ativo
497:             THIS.this_oBusinessObject.OrdenarPorColuna("Rclis")
498:             THIS.AtualizarDestaqueColunaOrdenada("Rclis")
499:         CATCH TO loc_oErro
500:             MsgErro(loc_oErro.Message + CHR(13) + ;
501:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
502:                 "Procedure: " + loc_oErro.Procedure, ;
503:                 "Erro Formsigprema.ConfigurarGrid")
504:         ENDTRY
505:     ENDPROC
506: 
507:     *--------------------------------------------------------------------------
508:     * AtualizarDestaqueColunaOrdenada - Destaca com fundo azul-esverdeado o
509:     * header da coluna usada na ordenacao corrente e volta as demais para o
510:     * cinza padrao - transcricao literal do Header1.Click do legado
511:     * (RGB(64,128,128) = coluna ativa / RGB(192,192,192) = colunas inativas).
512:     * par_cColuna: "Contas" | "Rclis" | "Emails"
513:     *--------------------------------------------------------------------------
514:     PROTECTED PROCEDURE AtualizarDestaqueColunaOrdenada(par_cColuna)
515:         LOCAL loc_nAtivo, loc_nInativo
516: 
517:         loc_nAtivo   = RGB(64, 128, 128)
518:         loc_nInativo = RGB(192, 192, 192)
519: 
520:         THIS.grd_4c_Dados.Column2.Header1.BackColor = IIF(par_cColuna = "Contas", loc_nAtivo, loc_nInativo)
521:         THIS.grd_4c_Dados.Column3.Header1.BackColor = IIF(par_cColuna = "Rclis",  loc_nAtivo, loc_nInativo)
522:         THIS.grd_4c_Dados.Column4.Header1.BackColor = IIF(par_cColuna = "Emails", loc_nAtivo, loc_nInativo)
523:     ENDPROC
524: 
525:     *--------------------------------------------------------------------------
526:     * ChkChecksInteractiveChange - Grava o novo estado do checkbox no cursor de
527:     * trabalho. Transcricao literal do "Replace Checks With this.Value in
528:     * crLocalTotal" do PROCEDURE InteractiveChange legado (Column6.fwcheckbox1).
529:     * PUBLIC (sem PROTECTED) - metodo alvo de BINDEVENT (CLAUDE.md regra #3).
530:     *--------------------------------------------------------------------------
531:     PROCEDURE ChkChecksInteractiveChange()
532:         LOCAL loc_oChk
533: 
534:         loc_oChk = THIS.grd_4c_Dados.Column1.chk_4c_Checks
535: 
536:         IF USED("cursor_4c_Dados")
537:             REPLACE Checks WITH loc_oChk.Value IN cursor_4c_Dados
538:         ENDIF
539:     ENDPROC
540: 
541:     *--------------------------------------------------------------------------
542:     * ValidarEmailLinhaKeyPress - Dispara a validacao da celula de e-mail ao
543:     * confirmar a digitacao com ENTER (13) ou TAB (9), que e' o equivalente do
544:     * Valid da celula no legado ("Valid" nao dispara via BINDEVENT em TextBox -
545:     * CLAUDE.md). PUBLIC (alvo de BINDEVENT, CLAUDE.md regra #3).
546:     *--------------------------------------------------------------------------
547:     PROCEDURE ValidarEmailLinhaKeyPress(par_nKeyCode, par_nShiftAltCtrl)
548:         IF par_nKeyCode = 13 OR par_nKeyCode = 9
549:             THIS.ValidarEmailLinha()
550:         ENDIF
551:     ENDPROC
552: 
553:     *--------------------------------------------------------------------------
554:     * ValidarEmailLinha - Normaliza o e-mail digitado na celula editavel da
555:     * grade (Column4/Emails, a unica com ReadOnly = .F. no SCX legado) e grava
556:     * o valor normalizado de volta no cursor de trabalho.
557:     *
558:     * A normalizacao aplicada e' a MESMA que o legado ja aplica no momento do
559:     * envio - ALLTRIM no destinatario/copia (btnEmail.Click:
560:     * "Alltrim(crLocaltotal2.emails)") e LOWER no remetente/servidor
561:     * ("Lower(Alltrim(Nvl(TmpEmpMail.PadEmails,[])))"). Fazer isso aqui, na
562:     * saida da celula, e' o que faz o que o usuario VE na grade ser igual ao
563:     * que de fato sai no e-mail; sem isso, um espaco a esquerda digitado por
564:     * engano continua invisivel na tela e vai inteiro para o campo "Para".
565:     *
566:     * NAO bloqueia nem rejeita conteudo: o legado nao tem Valid nesta celula e
567:     * o unico criterio que ele aplica sobre o e-mail e' "vazio -> pula a linha"
568:     * (btnEmail.Click: "If IsEmpty(crLocaltotal2.emails) / Loop"), criterio que
569:     * esta reproduzido em sigpremaBO.EnviarEmailSelecionados e conferido em
570:     * THIS.ValidarEnvio(). Impedir a digitacao aqui seria inventar regra que o
571:     * legado nao tem (PILAR 1).
572:     *
573:     * PUBLIC (alvo de BINDEVENT, CLAUDE.md regra #3).
574:     *--------------------------------------------------------------------------
575:     PROCEDURE ValidarEmailLinha()
576:         LOCAL loc_oTxt, loc_cDigitado, loc_cNormalizado, loc_oErro
577: 
578:         TRY
579:             loc_oTxt = THIS.grd_4c_Dados.Column4.Text1
580: 
581:             IF USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados")
582:                 loc_cDigitado    = TratarNulo(loc_oTxt.Value, "")
583:                 loc_cNormalizado = LOWER(ALLTRIM(loc_cDigitado))
584: 
585:                 *-- So grava quando mudou de fato: evita reescrever o cursor a
586:                 *-- cada passagem de foco pela celula.
587:                 IF loc_cNormalizado != loc_cDigitado
588:                     REPLACE Emails WITH loc_cNormalizado IN cursor_4c_Dados
589:                     loc_oTxt.Value = loc_cNormalizado
590:                     THIS.grd_4c_Dados.Refresh()
591:                 ENDIF
592:             ENDIF
593:         CATCH TO loc_oErro
594:             MsgErro(loc_oErro.Message + CHR(13) + ;
595:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
596:                 "Procedure: " + loc_oErro.Procedure, ;
597:                 "Erro Formsigprema.ValidarEmailLinha")
598:         ENDTRY
599:     ENDPROC
600: 
601:     *--------------------------------------------------------------------------
602:     * ValidarEnvio - Conferencia previa ao disparo do envio, executada por
603:     * BtnProcessarEmailClick ANTES de chamar o BO. Reproduz os dois criterios que
604:     * o proprio btnEmail.Click legado aplica sobre as linhas antes de enviar:
605:     *
606:     *   1) "Select * From crLocaltotal Where Checks = 1"  -> tem de haver ao
607:     *      menos UMA linha marcada;
608:     *   2) "If IsEmpty(crLocaltotal2.emails) / Loop"      -> das marcadas, ao
609:     *      menos UMA precisa ter e-mail preenchido.
610:     *
611:     * No legado esses dois criterios sao silenciosos: com nenhuma linha marcada
612:     * (ou com todas as marcadas sem e-mail) o SCAN nao executa nenhuma
613:     * iteracao, "llOk" continua .T. e a tela exibe "Email enviado com sucesso!"
614:     * e se fecha - sem ter enviado nada. Este metodo existe para NAO reproduzir
615:     * esse ponto: CLAUDE.md #20 (falha de gravacao nunca e' muda) e a regra de
616:     * nunca anunciar sucesso quando nao houve o que processar. O desvio e'
617:     * deliberado, cobre so a mensagem/aborto e esta registrado no cabecalho.
618:     *
619:     * Retorna .T. quando ha o que enviar; .F. (com MsgAviso ja exibido e foco
620:     * devolvido a grade) quando nao ha.
621:     *
622:     * PUBLIC - tambem e' chamado de fora pelo harness de teste (CLAUDE.md #3).
623:     *--------------------------------------------------------------------------
624:     FUNCTION ValidarEnvio()
625:         LOCAL loc_lValido, loc_nMarcadas, loc_nComEmail, loc_nRegAtual, loc_oErro
626: 
627:         loc_lValido  = .F.
628:         loc_nMarcadas = 0
629:         loc_nComEmail = 0
630: 
631:         TRY
632:             IF !USED("cursor_4c_Dados")
633:                 MsgAviso("Nenhum dado carregado para envio.", ;
634:                          "Processamento de Email")
635:             ELSE
636:                 *-- Preserva a linha corrente: a grade continua posicionada
637:                 *-- onde o usuario estava depois da conferencia.
638:                 SELECT cursor_4c_Dados
639:                 loc_nRegAtual = IIF(RECCOUNT() > 0, RECNO(), 0)
640: 
641:                 SCAN
642:                     IF NVL(cursor_4c_Dados.Checks, 0) = 1
643:                         loc_nMarcadas = loc_nMarcadas + 1
644: 
645:                         IF !EMPTY(ALLTRIM(TratarNulo(cursor_4c_Dados.Emails, "")))
646:                             loc_nComEmail = loc_nComEmail + 1
647:                         ENDIF
648:                     ENDIF
649:                 ENDSCAN
650: 
651:                 IF loc_nRegAtual > 0 AND loc_nRegAtual <= RECCOUNT()
652:                     GO loc_nRegAtual IN cursor_4c_Dados
653:                 ENDIF
654: 
655:                 DO CASE
656:                 CASE loc_nMarcadas = 0
657:                     MsgAviso("Nenhum destinat" + CHR(225) + "rio selecionado." + CHR(13) + ;
658:                              "Marque ao menos um e-mail para envio.", ;
659:                              "Processamento de Email")
660: 
661:                 CASE loc_nComEmail = 0
662:                     MsgAviso("Nenhuma das linhas marcadas tem e-mail preenchido." + CHR(13) + ;
663:                              "Informe o e-mail na coluna Email ou marque outra linha.", ;
664:                              "Processamento de Email")
665: 
666:                 OTHERWISE
667:                     loc_lValido = .T.
668:                 ENDCASE
669: 
670:                 IF !loc_lValido AND TYPE("THIS.grd_4c_Dados") = "O"
671:                     THIS.grd_4c_Dados.SetFocus()
672:                 ENDIF
673:             ENDIF
674:         CATCH TO loc_oErro
675:             loc_lValido = .F.
676:             MsgErro(loc_oErro.Message + CHR(13) + ;
677:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
678:                 "Procedure: " + loc_oErro.Procedure, ;
679:                 "Erro Formsigprema.ValidarEnvio")
680:         ENDTRY
681: 
682:         RETURN loc_lValido
683:     ENDFUNC
684: 
685:     *--------------------------------------------------------------------------
686:     * HeaderContasClick / HeaderRclisClick / HeaderEmailsClick - Reordenam o
687:     * cursor de trabalho pelo TAG correspondente, equivalente ao PROCEDURE
688:     * Click dos headers das colunas Conta/Nome/Email no legado. PUBLIC (alvo
689:     * de BINDEVENT).
690:     *--------------------------------------------------------------------------
691:     PROCEDURE HeaderContasClick()
692:         THIS.this_oBusinessObject.OrdenarPorColuna("Contas")
693:         THIS.AtualizarDestaqueColunaOrdenada("Contas")
694:         THIS.grd_4c_Dados.Refresh()
695:     ENDPROC
696: 
697:     PROCEDURE HeaderRclisClick()
698:         THIS.this_oBusinessObject.OrdenarPorColuna("Rclis")
699:         THIS.AtualizarDestaqueColunaOrdenada("Rclis")
700:         THIS.grd_4c_Dados.Refresh()
701:     ENDPROC
702: 
703:     PROCEDURE HeaderEmailsClick()
704:         THIS.this_oBusinessObject.OrdenarPorColuna("Emails")
705:         THIS.AtualizarDestaqueColunaOrdenada("Emails")
706:         THIS.grd_4c_Dados.Refresh()
707:     ENDPROC
708: 
709:     *--------------------------------------------------------------------------
710:     * ConfigurarBotoes - Monta os controles standalone do legado (nenhum deles
711:     * fica dentro de um container no SCX original): Shape1 (decorativo),
712:     * btnEmail, SelTudo (Marcar Todos), apaga (Desmarcar Todos) e Commandgroup1
713:     * (botao unico "Encerrar"). Todas as posicoes/tamanhos/icones sao os
714:     * valores EXATOS do SCX legado (PILAR 1).
715:     *--------------------------------------------------------------------------
716:     PROTECTED PROCEDURE ConfigurarBotoes()
717:         LOCAL loc_oErro
718: 
719:         TRY
720:             *-- Shape decorativo em torno do bloco Encerrar/Enviar Email (Shape1)
721:             THIS.AddObject("shp_4c_Decoracao", "Shape")
722:             WITH THIS.shp_4c_Decoracao
723:                 .Top           = 7
724:                 .Left          = 804
725:                 .Width         = 90
726:                 .Height        = 110
727:                 .BackStyle     = 0
728:                 .BorderStyle   = 0
729:                 .BorderWidth   = 1
730:                 .SpecialEffect = 1
731:                 .BorderColor   = RGB(136, 189, 188)
732:                 .Visible       = .T.
733:             ENDWITH
734: 
735:             *-- Enviar Email (legado btnEmail)
736:             THIS.AddObject("cmd_4c_EnviarEmail", "CommandButton")
737:             WITH THIS.cmd_4c_EnviarEmail
738:                 .Top             = 3
739:                 .Left            = 850
740:                 .Width           = 75
741:                 .Height          = 75
742:                 .FontBold        = .T.
743:                 .FontItalic      = .T.
744:                 .FontName        = "Comic Sans MS"
745:                 .FontSize        = 8
746:                 .Caption         = "Enviar Email"
747:                 .ToolTipText     = "Enviar Email"
748:                 .ForeColor       = RGB(90, 90, 90)
749:                 .BackColor       = RGB(255, 255, 255)
750:                 .Picture         = gc_4c_CaminhoIcones + "geral_envelope_60.jpg"
751:                 .Themes          = .T.
752:                 .DisabledPicture = gc_4c_CaminhoIcones + "geral_envelope_60.jpg"
753:                 .Visible         = .T.
754:             ENDWITH
755:             BINDEVENT(THIS.cmd_4c_EnviarEmail, "Click", THIS, "BtnProcessarEmailClick")
756: 
757:             *-- Marcar Todos (legado SelTudo)
758:             THIS.AddObject("cmd_4c_SelTudo", "CommandButton")
759:             WITH THIS.cmd_4c_SelTudo
760:                 .Top             = 84
761:                 .Left            = 4
762:                 .Width           = 40
763:                 .Height          = 40
764:                 .FontName        = "Verdana"
765:                 .FontSize        = 8
766:                 .WordWrap        = .T.
767:                 .Caption         = ""
768:                 .TabStop         = .F.
769:                 .ToolTipText     = "Marcar Todos"
770:                 .ForeColor       = RGB(36, 84, 155)
771:                 .BackColor       = RGB(255, 255, 255)
772:                 .Picture         = gc_4c_CaminhoIcones + "geral_marcar_26.jpg"
773:                 .Themes          = .T.
774:                 .DisabledPicture = gc_4c_CaminhoIcones + "geral_marcar_26.jpg"
775:                 .Visible         = .T.
776:             ENDWITH
777:             BINDEVENT(THIS.cmd_4c_SelTudo, "Click", THIS, "BtnSelTudoClick")
778: 
779:             *-- Desmarcar Todos (legado apaga)
780:             THIS.AddObject("cmd_4c_Apaga", "CommandButton")
781:             WITH THIS.cmd_4c_Apaga
782:                 .Top             = 84
783:                 .Left            = 43
784:                 .Width           = 40
785:                 .Height          = 40
786:                 .FontName        = "Verdana"
787:                 .FontSize        = 8
788:                 .WordWrap        = .T.
789:                 .Caption         = ""
790:                 .TabStop         = .F.
791:                 .ToolTipText     = "Desmarcar Todos"
792:                 .ForeColor       = RGB(36, 84, 155)
793:                 .BackColor       = RGB(255, 255, 255)
794:                 .Picture         = gc_4c_CaminhoIcones + "cadastro_excluir_26.jpg"
795:                 .Themes          = .T.
796:                 .DisabledPicture = gc_4c_CaminhoIcones + "cadastro_excluir_26.jpg"
797:                 .Visible         = .T.
798:             ENDWITH
799:             BINDEVENT(THIS.cmd_4c_Apaga, "Click", THIS, "BtnApagaClick")
800: 
801:             *-- Encerrar (legado Commandgroup1/btnSair)
802:             THIS.AddObject("cmg_4c_Encerrar", "CommandGroup")
803:             WITH THIS.cmg_4c_Encerrar
804:                 .Top           = -2
805:                 .Left          = 920
806:                 .Width         = 85
807:                 .Height        = 85
808:                 .ButtonCount   = 1
809:                 .BackStyle     = 0
810:                 .BorderStyle   = 0
811:                 .SpecialEffect = 1
812:                 .BorderColor   = RGB(136, 189, 188)
813:                 .Themes        = .F.
814: 
815:                 WITH .Buttons(1)
816:                     .Top         = 5
817:                     .Left        = 5
818:                     .Width       = 75
819:                     .Height      = 75
820:                     .FontBold    = .T.
821:                     .FontItalic  = .T.
822:                     .FontName    = "Comic Sans MS"
823:                     .FontSize    = 8
824:                     .Picture     = gc_4c_CaminhoIcones + "cadastro_cancelar_60.jpg"
825:                     .Cancel      = .T.
826:                     .Caption     = "Encerrar"
827:                     .ToolTipText = "[Esc] Encerrar"
828:                     .ForeColor   = RGB(90, 90, 90)
829:                     .BackColor   = RGB(255, 255, 255)
830:                     .Themes      = .F.
831:                 ENDWITH
832: 
833:                 .Visible = .T.
834:             ENDWITH
835:             BINDEVENT(THIS.cmg_4c_Encerrar, "Click", THIS, "BtnEncerrarClick")
836:         CATCH TO loc_oErro
837:             MsgErro(loc_oErro.Message + CHR(13) + ;
838:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
839:                 "Procedure: " + loc_oErro.Procedure, ;
840:                 "Erro Formsigprema.ConfigurarBotoes")
841:         ENDTRY
842:     ENDPROC
843: 
844:     *--------------------------------------------------------------------------
845:     * BtnSelTudoClick / BtnApagaClick - Marcam/desmarcam todas as linhas do
846:     * cursor de trabalho (equivalente ao Click dos botoes SelTudo/apaga do
847:     * legado). PUBLIC (alvo de BINDEVENT).
848:     *--------------------------------------------------------------------------
849:     PROCEDURE BtnSelTudoClick()
850:         THIS.this_oBusinessObject.MarcarTodos()
851:         THIS.Refresh()
852:     ENDPROC
853: 
854:     PROCEDURE BtnApagaClick()
855:         THIS.this_oBusinessObject.DesmarcarTodos()
856:         THIS.Refresh()
857:     ENDPROC
858: 
859:     *--------------------------------------------------------------------------
860:     * BtnEncerrarClick - Fecha a tela (equivalente ao PROCEDURE btnSair.Click
861:     * do Commandgroup1 legado). PUBLIC (alvo de BINDEVENT). Nomeado com o
862:     * prefixo Btn (e nao Cmg, do objeto cmg_4c_Encerrar) para ficar consistente
863:     * com os demais handlers de botao deste form (BtnSelTudoClick/BtnApagaClick/
864:     * BtnProcessarEmailClick).
865:     *--------------------------------------------------------------------------
866:     PROCEDURE BtnEncerrarClick()
867:         LPARAMETERS par_nIndicePressionado
868: 
869:         THIS.Release()
870:     ENDPROC
871: 
872:     *--------------------------------------------------------------------------
873:     * BtnProcessarEmailClick - Dispara o envio dos e-mails marcados (equivalente
874:     * ao PROCEDURE Click do btnEmail legado). Toda a logica de envio (contas
875:     * SMTP, laco pelos selecionados, log) ja esta em
876:     * sigpremaBO.EnviarEmailSelecionados - este handler so aciona e trata o
877:     * retorno, igual ao legado (fecha a tela em caso de sucesso e sempre que a
878:     * tela estiver em modo automatico). PUBLIC (alvo de BINDEVENT).
879:     *
880:     * this_cArquivoEmail fica vazio porque a geracao do PDF anexo (equivalente
881:     * ao ImpDocto do legado) depende de relatorios fora do escopo desta
882:     * migracao - ver cabecalho de sigpremaBO.prg.
883:     *--------------------------------------------------------------------------
884:     PROCEDURE BtnProcessarEmailClick()
885:         LOCAL loc_lOk
886: 
887:         loc_lOk = .F.
888: 
889:         *-- Conferencia previa: sem linha marcada (ou sem nenhuma marcada com
890:         *-- e-mail preenchido) nao ha o que enviar - pular o envio aqui evita
891:         *-- que a tela anuncie "Email enviado com sucesso!" sem ter enviado
892:         *-- nada. Ver comentario de ValidarEnvio (desvio deliberado do legado).
893:         IF THIS.ValidarEnvio()
894:             THIS.this_oBusinessObject.this_cArquivoEmail = ""
895: 
896:             loc_lOk = THIS.this_oBusinessObject.EnviarEmailSelecionados()
897: 
898:             IF loc_lOk
899:                 WAIT WINDOW "Email enviado com sucesso!" TIMEOUT 2
900:                 THIS.Release()
901:             ENDIF
902:         ENDIF
903: 
904:         *-- FORA do IF acima, de proposito: no legado o "If Thisform.automatico
905:         *-- / thisform.Release()" e' incondicional - a tela chamada em modo
906:         *-- automatico SEMPRE se fecha, tenha enviado ou nao. Condicionar este
907:         *-- release a validacao deixaria o processo automatico preso numa tela
908:         *-- aberta que ninguem vai fechar.
909:         IF THIS.this_lAutomatico
910:             THIS.Release()
911:         ENDIF
912:     ENDPROC
913: 
914:     *--------------------------------------------------------------------------
915:     * TornarControlesVisiveis - Torna visiveis todos os controles do form,
916:     * percorrendo containers e paginas de PageFrame recursivamente. AddObject
917:     * cria controles com Visible=.F. por padrao.
918:     *--------------------------------------------------------------------------
919:     PROCEDURE TornarControlesVisiveis(par_oContainer)
920:         LOCAL loc_nI, loc_oObjeto
921: 
922:         IF VARTYPE(par_oContainer) != "O"
923:             RETURN
924:         ENDIF
925: 
926:         FOR loc_nI = 1 TO par_oContainer.ControlCount
927:             loc_oObjeto = par_oContainer.Controls(loc_nI)
928: 
929:             IF VARTYPE(loc_oObjeto) = "O"
930:                 IF PEMSTATUS(loc_oObjeto, "Visible", 5)
931:                     loc_oObjeto.Visible = .T.
932:                 ENDIF
933: 
934:                 IF UPPER(loc_oObjeto.BaseClass) = "PAGEFRAME"
935:                     LOCAL loc_nP
936:                     FOR loc_nP = 1 TO loc_oObjeto.PageCount
937:                         THIS.TornarControlesVisiveis(loc_oObjeto.Pages(loc_nP))
938:                     ENDFOR
939:                 ENDIF
940: 
941:                 IF PEMSTATUS(loc_oObjeto, "ControlCount", 5) AND loc_oObjeto.ControlCount > 0
942:                     THIS.TornarControlesVisiveis(loc_oObjeto)
943:                 ENDIF
944:             ENDIF
945:         ENDFOR
946:     ENDPROC
947: 
948:     *--------------------------------------------------------------------------
949:     * Destroy - Libera o Business Object (que por sua vez libera os cursores
950:     * de trabalho abertos - ver sigpremaBO.Destroy)
951:     *--------------------------------------------------------------------------
952:     PROCEDURE Destroy()
953:         DODEFAULT()
954:     ENDPROC
955: 
956: ENDDEFINE


### BO (C:\4c\projeto\app\classes\sigpremaBO.prg):
*==============================================================================
* SIGPREMABO.PRG
* Business Object do formulario Formsigprema (Processamento e Geracao de Email)
* Responsabilidade: montar a lista de e-mails a enviar (movimentos
* de SigMvCab cruzados com SigCdCli e com os contatos padrao de SigCdPam),
* gerar o PDF do documento (via ImpDocto) e disparar o envio (via CDO.Message)
* usando os dados de conta de e-mail cadastrados em SigCdEmp.
*
* SIGPREMA nao tem uma unica tabela/CRUD associada no legado: o Init monta um
* cursor de trabalho (crLocalTotal) a partir de VARIAS consultas (SigMvCab +
* SigCdCli + SigCdPam), e os botoes da tela operam sobre esse cursor em lote.
* Por isso this_cTabela e this_cCampoChave permanecem vazios - nao ha um
* unico registro/PK sendo editado, e sim uma lista de linhas selecionaveis
* identificadas pela chave posicional EmpDopNums (Emps char(3) + Dopes
* char(20) + Str(Numes,6) = 29 chars - ver regra da chave posicional,
* CLAUDE.md Erro177: NUNCA aplicar ALLTRIM nas partes ao montar/comparar essa
* chave, so na chave inteira ja montada).
*
* BO SOMENTE-LEITURA - POR QUE NAO HA Inserir() / Atualizar() PROPRIOS
* --------------------------------------------------------------------
* Varredura do dump legado (tasks\task602\sigprema_form_codigo_fonte.txt):
* o form NAO grava em tabela nenhuma do SQL Server. Os unicos Insert Into /
* Replace do legado (linhas 829, 870, 1004, 1115, 1133) tem por destino o
* CURSOR LOCAL crLocalTotal; todo acesso remoto eh de LEITURA (SqlExecute
* com Select, e cursorquery). SigOpLog aparece so dentro do
* "not in (select Transacaos from sigoplog ...)" do Init - eh lido, nunca
* escrito por este form.
*
* Portanto Inserir(), Atualizar() e ExecutarExclusao() NAO sao sobrescritos
* aqui: o comportamento padrao herdado de BusinessBase (recusar a operacao
* e reportar pelo ExibirFalha do Salvar) ja eh o correto para esta tela, e
* escrever INSERT/UPDATE inventado violaria o PILAR 2 e a regra #22 do
* CLAUDE.md (lista de colunas tirada do schema, nunca adivinhada).
*
* O unico ponto do legado que PARECE gravar eh
* "fGravarLog('T', Thisform.Name, [], lcEdn)" (linha 1085). O de-para dos
* argumentos com dbo.SigOpLog nao foi confirmado - o fonte legado de
* fGravarLog nao veio no acervo - entao a chamada segue pelo wrapper
* no-op projeto\app\utils\fgravarlog.prg (mesma decisao documentada la).
* Ver RegistrarLogEnvio() no fim deste arquivo.
*==============================================================================

DEFINE CLASS sigpremaBO AS BusinessBase

    *-- Parametros recebidos pelo Init do form legado (prDopes, pAuto)
    this_cDopes         = ""    && prDopes - EmpDopNums usado para filtrar um unico movimento (vazio = processa todos os movimentos do dia ainda nao enviados)
    this_lAutomatico    = .F.   && pAuto - .T. quando a tela eh chamada em modo automatico (dispara o envio e fecha sozinha)
    this_cEmpresa       = ""    && Thisform.lcEmp - Substr(prDopes,1,3), codigo da empresa do movimento filtrado
    this_nTempo         = 5000  && Thisform.ntempo - timeout (ms) usado nos MessageBox/Wait Window do legado
    this_cEscolha       = ""    && Thisform.pcEscolha
    this_cArquivoEmail  = ""    && Thisform.pcArqEmail - caminho do PDF gerado para anexar ao e-mail

    *-- Intervalo de datas usado para buscar os movimentos do dia (pDti/pDtf)
    this_dDataInicial   = {}
    this_dDataFinal     = {}

    *-- Campos da linha corrente do cursor de trabalho crLocalTotal
    this_nChecks        = 0     && Checks N(1) - .T./1 quando a linha esta marcada para envio
    this_cGrupos        = ""    && grupos C(10)
    this_cContas        = ""    && Contas C(10) - codigo do cliente (SigCdCli.Iclis)
    this_cRclis         = ""    && Rclis C(50) - razao social/nome do cliente (ver CREATE CURSOR em BuscarDadosProcessamento)
    this_cEmails        = ""    && emails C(50)
    this_cMensagens     = ""    && mensagems M (memo)
    this_cEmpDopNums    = ""    && EmpDopNums C(29) - chave posicional Emps(3)+Dopes(20)+Str(Numes,6)
    this_cPrioridade    = ""    && prioridade C(15) - "NORMAL" por padrao

    *-- Dados da conta de e-mail da empresa (SigCdEmp), usados para disparar o envio
    this_cRemetente     = ""    && TmpEmpMail.PadEmails
    this_cServidorSmtp  = ""    && TmpEmpMail.PadServs
    this_cSenhaSmtp     = ""    && TmpEmpMail.PadSenhas
    this_nPortaSmtp     = 0     && TmpEmpMail.PadPortas

    *-- Parametros de um envio individual de e-mail (equivalentes ao PROCEDURE memail do legado)
    this_cDestinatario  = ""    && tcTo
    this_cCopia         = ""    && tcCC
    this_cAssunto       = ""    && tcAssunto
    this_cCorpo         = ""    && tcCorpo
    this_cAnexo         = ""    && tcAnexo

    *-- Alias do cursor de trabalho com a lista de e-mails a enviar
    *-- (equivalente a crLocalTotal do legado)
    this_cCursorDados   = "cursor_4c_Dados"

    *--------------------------------------------------------------------------
    * INIT - Construtor
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        *-- SIGPREMA nao tem tabela/PK unica associada (ver cabecalho do arquivo)
        THIS.this_cTabela = ""
        THIS.this_cCampoChave = ""

        DODEFAULT()

        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - SIGPREMA nao tem PK unica (ver cabecalho do
    * arquivo); devolve a chave posicional EmpDopNums da linha corrente do
    * cursor de trabalho, que eh o mais proximo de uma "identidade" que este
    * BO tem. RegistrarAuditoria() da base ja aborta sozinha quando a chave
    * vem vazia, entao nao ha auditoria indevida por causa disso.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ObterChavePrimaria()
        RETURN THIS.this_cEmpDopNums
    ENDPROC

    *--------------------------------------------------------------------------
    * MontarChaveEmpDopNums - Monta a chave posicional EmpDopNums char(29) =
    * Emps char(3) + Dopes char(20) + Str(Numes,6).
    *
    * CLAUDE.md Erro177: a chave eh POSICIONAL - NUNCA aplicar ALLTRIM nas
    * PARTES antes de concatenar (o padding faz parte da chave e o SELECT
    * que compara essa chave passa a devolver ZERO linhas em silencio). So a
    * chave INTEIRA, ja montada, pode levar ALLTRIM com seguranca.
    *--------------------------------------------------------------------------
    PROCEDURE MontarChaveEmpDopNums(par_cEmps, par_cDopes, par_nNumes)
        RETURN PADR(par_cEmps, 3) + PADR(par_cDopes, 20) + STR(par_nNumes, 6)
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Carrega as propriedades this_* a partir da linha
    * corrente do cursor de trabalho (this_cCursorDados / cursor_4c_Dados)
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso

        loc_lSucesso = .F.

        TRY
            IF USED(par_cAliasCursor)
                SELECT (par_cAliasCursor)

                THIS.this_nChecks     = NVL(Checks, 0)
                THIS.this_cGrupos     = TratarNulo(Grupos, "")
                THIS.this_cContas     = TratarNulo(Contas, "")
                THIS.this_cRclis      = TratarNulo(Rclis, "")
                THIS.this_cEmails     = TratarNulo(Emails, "")
                THIS.this_cMensagens  = TratarNulo(Mensagens, "")
                THIS.this_cEmpDopNums = TratarNulo(EmpDopNums, "")
                THIS.this_cPrioridade = TratarNulo(Prioridade, "")

                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo), ;
                    "Erro em sigpremaBO.CarregarDoCursor")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * BuscarDadosProcessamento - Monta this_cCursorDados (cursor_4c_Dados,
    * equivalente a crLocalTotal do legado) com a lista de e-mails a enviar.
    *
    * par_cDopes vazio -> processa TODOS os movimentos do dia ainda nao
    *   registrados em SigOpLog para o programa SIGPREMA (equivalente ao
    *   "Empty(prDopes)" do Init legado).
    * par_cDopes = EmpDopNums completo (29 chars) -> processa so aquele
    *   movimento (equivalente ao Else do Init legado).
    *
    * Retorna .T. se o carregamento foi bem-sucedido.
    *--------------------------------------------------------------------------
    PROCEDURE BuscarDadosProcessamento(par_cDopes)
        LOCAL loc_lSucesso, loc_lAbortar, loc_cSQL, loc_cDopesLimpo
        LOCAL loc_nChecksPam, loc_cGruposPam, loc_cContasPam, loc_cRclisPam, loc_cEmailsPam

        loc_lSucesso = .F.
        loc_lAbortar = .F.

        TRY
            THIS.this_cDopes = TratarNulo(par_cDopes, "")
            loc_cDopesLimpo  = ALLTRIM(THIS.this_cDopes)

            IF !EMPTY(loc_cDopesLimpo)
                THIS.this_cEmpresa = SUBSTR(loc_cDopesLimpo, 1, 3)
            ENDIF

            *-- Janela do dia corrente (equivalente a pDti/pDtf do legado)
            THIS.this_dDataInicial = DATETIME()
            THIS.this_dDataFinal   = DATETIME(YEAR(DATE()), MONTH(DATE()), DAY(DATE()), 23, 59, 59)

            *-- Recria o cursor de trabalho (equivalente ao Create Cursor crLocalTotal)
            IF USED(THIS.this_cCursorDados)
                USE IN (THIS.this_cCursorDados)
            ENDIF

            SET NULL ON
            CREATE CURSOR (THIS.this_cCursorDados) ;
                (Checks N(1) NULL, Grupos C(10) NULL, Contas C(10) NULL, ;
                 Rclis C(50) NULL, Emails C(50) NULL, Mensagens M NULL, ;
                 EmpDopNums C(29) NULL, Prioridade C(15) NULL)
            SET NULL OFF

            INDEX ON Contas TAG Contas
            INDEX ON Rclis  TAG Rclis
            INDEX ON Emails TAG Emails

            *-- Cabecalho dos movimentos (SigMvCab + SigCdCli)
            IF USED("cursor_4c_TmpMvCab")
                USE IN cursor_4c_TmpMvCab
            ENDIF

            IF EMPTY(loc_cDopesLimpo)
                loc_cSQL = "SELECT 1 AS Checks, a.EmpDopNums, a.Jobs, b.Rclis, b.Emails, b.Grupos, b.Iclis " + ;
                           "FROM SigMvCab a " + ;
                           "INNER JOIN SigCdCli b ON a.Contads = b.Iclis " + ;
                           "WHERE a.Datatrans BETWEEN " + FormatarDataSQL(THIS.this_dDataInicial) + ;
                           " AND " + FormatarDataSQL(THIS.this_dDataFinal) + " " + ;
                           "AND a.EmpDopNums NOT IN (SELECT Transacaos FROM SigOpLog WHERE Progs = 'SIGPREMA') " + ;
                           "ORDER BY a.EmpDopNums"
            ELSE
                loc_cSQL = "SELECT 1 AS Checks, a.EmpDopNums, a.Jobs, b.Rclis, b.Emails, b.Grupos, b.Iclis " + ;
                           "FROM SigMvCab a " + ;
                           "INNER JOIN SigCdCli b ON a.Contads = b.Iclis " + ;
                           "WHERE a.EmpDopNums = " + EscaparSQL(loc_cDopesLimpo)
            ENDIF

            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_TmpMvCab") < 1
                MsgErro("Favor reinicializar o processo!!!" + CHR(13) + ;
                        "Falha na conex" + CHR(227) + "o (TmpMvCab).", "Erro")
                loc_lAbortar = .T.
            ENDIF

            IF !loc_lAbortar
                *-- Grava os dados no cursor de trabalho para envio dos e-mails
                SELECT cursor_4c_TmpMvCab
                GO TOP
                SCAN
                    INSERT INTO (THIS.this_cCursorDados) ;
                        (Checks, Grupos, Contas, Rclis, Emails, Prioridade, EmpDopNums) ;
                        VALUES ;
                        (cursor_4c_TmpMvCab.Checks, cursor_4c_TmpMvCab.Grupos, ;
                         cursor_4c_TmpMvCab.Iclis, cursor_4c_TmpMvCab.Rclis, ;
                         cursor_4c_TmpMvCab.Emails, "NORMAL", cursor_4c_TmpMvCab.EmpDopNums)
                ENDSCAN

                *-- Contas do grupo parametrizado em SigCdPam (grpadats)
                IF USED("cursor_4c_LocalPAM")
                    USE IN cursor_4c_LocalPAM
                ENDIF

                loc_cSQL = "SELECT 0 AS Checks, c.Grupos, c.Iclis AS Contas, c.Rclis, c.Emails, '' AS Prioridade " + ;
                           "FROM SigCdPam p " + ;
                           "INNER JOIN SigCdCli c ON c.Grupos = p.Grpadats"

                IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_LocalPAM") < 1
                    MsgErro("Favor reinicializar o processo!!!" + CHR(13) + ;
                            "Falha na conex" + CHR(227) + "o (SigCdPam).", "Erro")
                    loc_lAbortar = .T.
                ENDIF
            ENDIF

            IF !loc_lAbortar
                *-- Adiciona os destinatarios do grupo parametrizado, filtrando
                *-- por Job quando o cliente tem restricao em SigClJob, e sem
                *-- duplicar quem ja foi inserido a partir do movimento
                SELECT cursor_4c_LocalPAM
                SCAN
                    IF USED("cursor_4c_TmpClJob")
                        USE IN cursor_4c_TmpClJob
                    ENDIF

                    loc_cSQL = "SELECT Jobs FROM SigClJob WHERE Iclis = " + ;
                               EscaparSQL(ALLTRIM(cursor_4c_LocalPAM.Contas))

                    IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_TmpClJob") < 1
                        MsgErro("Favor reinicializar o processo!!!" + CHR(13) + ;
                                "Falha na conex" + CHR(227) + "o (TmpClJob).", "Erro")
                        loc_lAbortar = .T.
                        EXIT
                    ENDIF

                    SELECT cursor_4c_TmpClJob
                    GO TOP
                    IF !EOF()
                        LOCATE FOR ALLTRIM(Jobs) = ALLTRIM(cursor_4c_TmpMvCab.Jobs)
                        IF EOF()
                            SELECT cursor_4c_LocalPAM
                            LOOP
                        ENDIF
                    ENDIF

                    loc_nChecksPam = cursor_4c_LocalPAM.Checks
                    loc_cGruposPam = ""
                    loc_cContasPam = ALLTRIM(cursor_4c_LocalPAM.Contas)
                    loc_cRclisPam  = ALLTRIM(cursor_4c_LocalPAM.Rclis)
                    loc_cEmailsPam = ALLTRIM(cursor_4c_LocalPAM.Emails)

                    SELECT (THIS.this_cCursorDados)
                    LOCATE FOR ALLTRIM(Contas) = loc_cContasPam AND ALLTRIM(Rclis) = loc_cRclisPam
                    IF EOF()
                        INSERT INTO (THIS.this_cCursorDados) ;
                            (Checks, Grupos, Contas, Rclis, Emails, EmpDopNums, Prioridade) ;
                            VALUES ;
                            (loc_nChecksPam, loc_cGruposPam, loc_cContasPam, loc_cRclisPam, ;
                             loc_cEmailsPam, THIS.this_cDopes, "NORMAL")
                    ENDIF

                    SELECT cursor_4c_LocalPAM
                ENDSCAN
            ENDIF

            IF !loc_lAbortar
                *-- Ordena por nome, igual ao legado (column3.header1.Click no Init)
                THIS.OrdenarPorColuna("Rclis")
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo), ;
                    "Erro em sigpremaBO.BuscarDadosProcessamento")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * MarcarTodos - Marca todas as linhas do cursor de trabalho (Checks = 1),
    * equivalente ao botao SelTudo do legado
    *--------------------------------------------------------------------------
    PROCEDURE MarcarTodos()
        IF USED(THIS.this_cCursorDados)
            SELECT (THIS.this_cCursorDados)
            GO TOP
            REPLACE ALL Checks WITH 1
            GO TOP
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * DesmarcarTodos - Desmarca todas as linhas do cursor de trabalho
    * (Checks = 0), equivalente ao botao apaga (Desmarcar Todos) do legado
    *--------------------------------------------------------------------------
    PROCEDURE DesmarcarTodos()
        IF USED(THIS.this_cCursorDados)
            SELECT (THIS.this_cCursorDados)
            GO TOP
            REPLACE ALL Checks WITH 0
            GO TOP
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * OrdenarPorColuna - Reordena o cursor de trabalho pelo TAG solicitado,
    * equivalente ao Click dos headers de coluna do grid legado.
    * par_cTag: "Contas" | "Rclis" | "Emails"
    *--------------------------------------------------------------------------
    PROCEDURE OrdenarPorColuna(par_cTag)
        IF USED(THIS.this_cCursorDados)
            SELECT (THIS.this_cCursorDados)
            DO CASE
            CASE UPPER(ALLTRIM(par_cTag)) = "CONTAS"
                SET ORDER TO TAG Contas
            CASE UPPER(ALLTRIM(par_cTag)) = "RCLIS"
                SET ORDER TO TAG Rclis
            CASE UPPER(ALLTRIM(par_cTag)) = "EMAILS"
                SET ORDER TO TAG Emails
            ENDCASE
            GO TOP
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterDadosContaEmail - Busca a conta de e-mail (SMTP) parametrizada
    * para a empresa em SigCdEmp e popula this_cRemetente/this_cServidorSmtp/
    * this_cSenhaSmtp/this_nPortaSmtp (equivalente a consulta a TmpEmpMail no
    * PROCEDURE Click do btnEmail legado). par_cCodEmpresa deve vir de
    * go_4c_Sistema.cCodEmpresa - NUNCA da legada _Empr.
    *--------------------------------------------------------------------------
    PROCEDURE ObterDadosContaEmail(par_cCodEmpresa)
        LOCAL loc_lSucesso, loc_cSQL

        loc_lSucesso = .F.

        TRY
            IF USED("cursor_4c_TmpEmpMail")
                USE IN cursor_4c_TmpEmpMail
            ENDIF

            loc_cSQL = "SELECT PadEmails, PadServs, PadSenhas, PadPortas " + ;
                       "FROM SigCdEmp WHERE Cemps = " + EscaparSQL(ALLTRIM(par_cCodEmpresa))

            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_TmpEmpMail") < 1
                MsgErro("Favor reinicializar o processo!!!" + CHR(13) + ;
                        "Falha na conex" + CHR(227) + "o (TmpEmpMail).", "Erro")
            ELSE
                SELECT cursor_4c_TmpEmpMail
                GO TOP
                IF !EOF()
                    THIS.this_cRemetente    = LOWER(ALLTRIM(TratarNulo(PadEmails, "")))
                    THIS.this_cServidorSmtp = LOWER(ALLTRIM(TratarNulo(PadServs, "")))
                    THIS.this_cSenhaSmtp    = ALLTRIM(TratarNulo(PadSenhas, ""))
                    THIS.this_nPortaSmtp    = NVL(PadPortas, 0)
                    loc_lSucesso = .T.
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo), ;
                    "Erro em sigpremaBO.ObterDadosContaEmail")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * EnviarEmail - Dispara o envio via CDO.Message (SMTP).
    *
    * DE ONDE VEM ESTE CORPO: o btnEmail.Click legado (linha 1079) chama a
    * funcao GLOBAL EnviaEmail(...), que NAO veio no acervo (nao esta em
    * Framework\sigacess.PRG nem em lugar nenhum do dump). O que veio foi o
    * PROCEDURE memail do proprio SCX (linha 695) - mesma rotina CDO, com a
    * ordem dos argumentos diferente - e memail nunca eh chamado no legado
    * (a unica outra mencao, linha 1163, esta comentada). Este metodo eh a
    * transcricao do corpo de memail, que eh a melhor evidencia disponivel
    * do que EnviaEmail faz.
    *
    * Por isso NAO se cria wrapper utils\enviaemail.prg (regra #27 do
    * CLAUDE.md): a chamada mora no codigo do FORM, que estamos migrando -
    * ela eh substituida por este metodo, nao redirecionada.
    *
    * De-para dos argumentos, conferido contra a chamada legada
    * EnviaEmail(lcReceptor, lcTxtMensagem, lcAssunto, lcArqAnexo, lcFrom,
    *            lcReceptorCopia, lcServer, lcSenha, lnPorta):
    *   lcReceptor      -> par_cPara        lcFrom   -> par_cRemetente
    *   lcReceptorCopia -> par_cCopia       lcServer -> par_cServidor
    *   lcAssunto       -> par_cAssunto     lcSenha  -> par_cSenha
    *   lcTxtMensagem   -> par_cCorpo       lnPorta  -> par_nPorta
    *   lcArqAnexo      -> par_cAnexo
    *
    * Retorna .T. se o e-mail foi enviado com sucesso.
    *--------------------------------------------------------------------------
    PROCEDURE EnviarEmail(par_cPara, par_cCopia, par_cAssunto, par_cCorpo, ;
                          par_cAnexo, par_cRemetente, par_cServidor, ;
                          par_cSenha, par_nPorta)
        LOCAL loc_lOk, loc_lEnvioOk, loc_oEmail

        loc_lOk      = .F.
        loc_lEnvioOk = .T.

        TRY
            IF TYPE('CREATEOBJECT("CDO.Message")') != "O"
                MsgAviso("Problemas para instanciar o objeto CDO.Message.", ;
                         "Aten" + CHR(231) + CHR(227) + "o")
            ELSE
                loc_oEmail = CREATEOBJECT("CDO.Message")

                WITH loc_oEmail.Configuration.Fields
                    .Item("http://schemas.microsoft.com/cdo/configuration/sendusing")            = 2
                    .Item("http://schemas.microsoft.com/cdo/configuration/smtpserver")            = LOWER(par_cServidor)
                    .Item("http://schemas.microsoft.com/cdo/configuration/smtpconnectiontimeout") = 10
                    .Item("http://schemas.microsoft.com/cdo/configuration/smtpserverport")        = IIF(par_nPorta = 0, 25, par_nPorta)
                    .Item("http://schemas.microsoft.com/cdo/configuration/smtpauthenticate")      = 1
                    .Item("http://schemas.microsoft.com/cdo/configuration/sendusername")          = LOWER(par_cRemetente)
                    .Item("http://schemas.microsoft.com/cdo/configuration/sendpassword")          = par_cSenha
                    .Item("http://schemas.microsoft.com/cdo/configuration/smtpusessl")            = IIF(par_nPorta = 465, 1, 0)
                    .Update()
                ENDWITH

                WITH loc_oEmail
                    .To       = LOWER(par_cPara)
                    .Cc       = LOWER(NVL(par_cCopia, ""))
                    .From     = LOWER(par_cRemetente)
                    .Subject  = ALLTRIM(par_cAssunto)
                    .TextBody = ALLTRIM(par_cCorpo)

                    IF !EMPTY(par_cAnexo)
                        IF FILE(par_cAnexo)
                            .AddAttachment(par_cAnexo)
                        ELSE
                            loc_lEnvioOk = .F.
                            MsgAviso("N" + CHR(227) + "o foi encontrado o arquivo:" + CHR(13) + ;
                                     par_cAnexo + CHR(13) + "para ser anexado.", ;
                                     "Aten" + CHR(231) + CHR(227) + "o")
                        ENDIF
                    ENDIF

                    IF loc_lEnvioOk
                        TRY
                            .Send()
                            loc_lOk = .T.
                        CATCH TO loc_oErroEnvio
                            *-- O legado NAO fica calado aqui: o Catch do
                            *-- PROCEDURE memail avisa com
                            *-- Wait Window "Dados do e-mail invalidos." TimeOut 5.
                            *-- Transcrito como WAIT WINDOW ... TIMEOUT 5 para
                            *-- manter o aviso sem travar o envio em lote (o
                            *-- SCAN do chamador continua nos demais
                            *-- destinatarios), e CLAUDE.md #9 (CATCH nunca
                            *-- silencioso) fica atendido.
                            WAIT WINDOW "Dados do e-mail inv" + CHR(225) + "lidos." TIMEOUT 5
                            loc_lOk = .F.
                        ENDTRY
                    ENDIF
                ENDWITH

                loc_oEmail = .NULL.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo), ;
                    "Erro em sigpremaBO.EnviarEmail")
        ENDTRY

        RETURN loc_lOk
    ENDPROC

    *--------------------------------------------------------------------------
    * RegistrarLogEnvio - Registra o envio do movimento no log do sistema.
    *
    * fGravarLog (utils\fgravarlog.prg) eh um WRAPPER NO-OP INTENCIONAL: o
    * de-para real dos argumentos com SigOpLog nao foi confirmado contra o
    * fonte legado (ver cabecalho do proprio wrapper) - gravar direto em
    * SigOpLog com um de-para adivinhado seria a exata invencao que a regra
    * #17 do CLAUDE.md proibe. O legado tambem descarta o retorno da chamada
    * (`fGravarLog('T', Thisform.Name, [], lcEdn)` sem `=`), entao manter o
    * no-op aqui reproduz o comportamento observavel (o envio nao fica
    * marcado como processado em SigOpLog, igual ao legado).
    *--------------------------------------------------------------------------
    PROCEDURE RegistrarLogEnvio(par_cEmpDopNums)
        RETURN fGravarLog("T", "Formsigprema", "", par_cEmpDopNums)
    ENDPROC

    *--------------------------------------------------------------------------
    * EnviarEmailSelecionados - Envia o e-mail para os destinatarios marcados
    * (Checks = 1) em this_cCursorDados, equivalente ao PROCEDURE Click do
    * btnEmail legado. A conta de envio vem de go_4c_Sistema.cCodEmpresa
    * (equivalente a _Empr legada - CLAUDE.md: NUNCA usar _EMPR).
    *
    * this_cArquivoEmail deve ser preenchido pelo chamador (Form) ANTES de
    * chamar este metodo, com o caminho do PDF a anexar, quando aplicavel -
    * a geracao do anexo (equivalente ao ImpDocto do legado, que aciona os
    * relatorios SigPrIdc/SigReIfx/SigOpIgm) depende de rotinas de impressao
    * do legado fora do escopo desta migracao e fica a cargo do Form.
    *
    * Reproduz o comportamento do legado de enviar UM e-mail POR
    * destinatario marcado (o destinatario principal fica fixo no primeiro
    * marcado e os demais entram como copia, cumulativamente) - nao eh um
    * envio unico em lote.
    *
    * Retorna .T. se o ULTIMO envio realizado teve sucesso (mesmo criterio
    * do llOk do legado, que eh reiniciado a cada iteracao do Scan).
    *--------------------------------------------------------------------------
    PROCEDURE EnviarEmailSelecionados()
        LOCAL loc_lOk, loc_cReceptor, loc_cReceptorCopia
        LOCAL loc_cAssunto, loc_cTxtMensagem, loc_cArqAnexo, loc_cEdn

        loc_lOk = .F.

        TRY
            IF !USED(THIS.this_cCursorDados)
                MsgAviso("Nenhum dado carregado para envio.", "Processamento de Email")
            ELSE
                IF !THIS.ObterDadosContaEmail(go_4c_Sistema.cCodEmpresa)
                    *-- erro ja exibido em ObterDadosContaEmail
                ELSE
                    IF USED("cursor_4c_Selecionados")
                        USE IN cursor_4c_Selecionados
                    ENDIF

                    SELECT * FROM (THIS.this_cCursorDados) WHERE Checks = 1 ;
                        INTO CURSOR cursor_4c_Selecionados READWRITE

                    SELECT cursor_4c_Selecionados

                    IF RECCOUNT() = 0
                        MsgAviso("Nenhum destinat" + CHR(225) + "rio selecionado." + CHR(13) + ;
                                 "Marque ao menos um e-mail para envio.", "Processamento de Email")
                    ELSE
                        loc_cReceptor      = ""
                        loc_cReceptorCopia = ""
                        loc_cAssunto       = ""
                        loc_cTxtMensagem   = ""

                        SELECT cursor_4c_Selecionados
                        SCAN
                            IF EMPTY(ALLTRIM(TratarNulo(cursor_4c_Selecionados.Emails, "")))
                                LOOP
                            ENDIF

                            loc_cEdn = cursor_4c_Selecionados.EmpDopNums

                            *-- Transcricao literal do legado: quem vira
                            *-- destinatario PRINCIPAL eh o registro de
                            *-- RECNO() = 1, nao "o primeiro com e-mail
                            *-- preenchido". A diferenca aparece quando a 1a
                            *-- linha marcada esta sem e-mail: o LOOP acima a
                            *-- descarta ANTES deste teste, entao nenhuma
                            *-- linha assume o To e o envio sai com
                            *-- destinatario vazio (as demais entram como
                            *-- copia). Comportamento do legado - NAO
                            *-- "corrigir" aqui (CLAUDE.md #17: transcrever,
                            *-- nunca reescrever a regra do legado).
                            IF RECNO() = 1
                                loc_cReceptor    = ALLTRIM(cursor_4c_Selecionados.Emails)
                                loc_cTxtMensagem = TratarNulo(cursor_4c_Selecionados.Mensagens, "")
                                loc_cAssunto     = ""
                            ELSE
                                IF !EMPTY(ALLTRIM(cursor_4c_Selecionados.Emails))
                                    loc_cReceptorCopia = loc_cReceptorCopia + ;
                                        IIF(EMPTY(loc_cReceptorCopia), "", ",") + ;
                                        ALLTRIM(cursor_4c_Selecionados.Emails)
                                ENDIF
                            ENDIF

                            loc_cArqAnexo = THIS.this_cArquivoEmail

                            WAIT WINDOW CHR(13) + "Aguarde... gerando EMAIL" NOWAIT NOCLEAR

                            loc_lOk = THIS.EnviarEmail(loc_cReceptor, loc_cReceptorCopia, ;
                                loc_cAssunto, loc_cTxtMensagem, loc_cArqAnexo, ;
                                THIS.this_cRemetente, THIS.this_cServidorSmtp, ;
                                THIS.this_cSenhaSmtp, THIS.this_nPortaSmtp)

                            WAIT CLEAR

                            IF loc_lOk
                                THIS.RegistrarLogEnvio(loc_cEdn)
                            ENDIF

                            SELECT cursor_4c_Selecionados
                        ENDSCAN
                    ENDIF

                    IF USED("cursor_4c_Selecionados")
                        USE IN cursor_4c_Selecionados
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo), ;
                    "Erro em sigpremaBO.EnviarEmailSelecionados")
        ENDTRY

        RETURN loc_lOk
    ENDPROC

    *--------------------------------------------------------------------------
    * Destroy - Libera os cursores de trabalho abertos por este BO
    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
        IF USED(THIS.this_cCursorDados)
            USE IN (THIS.this_cCursorDados)
        ENDIF
        IF USED("cursor_4c_TmpMvCab")
            USE IN cursor_4c_TmpMvCab
        ENDIF
        IF USED("cursor_4c_LocalPAM")
            USE IN cursor_4c_LocalPAM
        ENDIF
        IF USED("cursor_4c_TmpClJob")
            USE IN cursor_4c_TmpClJob
        ENDIF
        IF USED("cursor_4c_TmpEmpMail")
            USE IN cursor_4c_TmpEmpMail
        ENDIF
        IF USED("cursor_4c_Selecionados")
            USE IN cursor_4c_Selecionados
        ENDIF

        DODEFAULT()
    ENDPROC

ENDDEFINE


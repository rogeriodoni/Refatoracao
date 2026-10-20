# CODE REVIEW - PASS FUNCTIONAL: Functional Logic (metodos, eventos, containers)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Functional Logic (metodos, eventos, containers)**.

## PROBLEMAS DETECTADOS (1)
- [METODO-INEXISTENTE] Metodo 'THIS.Width()' chamado mas NAO definido como PROCEDURE no Form nem herdado de FormBase. A LLM pode ter inventado este metodo. VERIFICAR se existe no legado e IMPLEMENTAR ou REMOVER a chamada.

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

### FORM (C:\4c\projeto\app\forms\operacionais\FormSigPrSnd.prg) - TRECHOS RELEVANTES PARA PASS FUNCTIONAL (1338 linhas total):

*-- Linhas 71 a 397:
71: * NO-OP em controle criado assim), por isso aqui sai .AutoSize = .F. com
72: * o Width/Height JA calculados pelo Form Designer, transcritos do dump.
73: *
74: * O BINDEVENT dos quatro Click entra nas Fases 7/8 (btnSenPend chamara
75: * CarregarDados(); btnGerSen/btnExcel/Saida terao seus proprios handlers,
76: * lendo THIS.txt_4c_Qtdsen.Value direto, igual ao legado thisform.
77: * getqtdsen.Value).
78: *
79: * FASE 6/8 (esta fase): "campos restantes e lookups". MEDIDO no dump
80: * SigPrSnd_form_codigo_fonte.txt, o legado NAO TEM:
81: *
82: *   (a) LOOKUP ALGUM. Varredura dos cinco padroes de picker do legado
83: *       Fortyus - fwbusca* (Ext/Sel/Int), mAddColuna, sigacess(),
84: *       Acesso<X>() e FormBuscaAuxiliar - devolve ZERO ocorrencia. O
85: *       unico CreateObject do dump eh o gerenciador de conexao
86: *       (CreateObject('fSqlConector', ThisForm.Name) no Init), que NAO
87: *       eh picker. O dump tambem nao tem PROCEDURE Valid, KeyPress nem
88: *       DblClick em controle nenhum. Criar aqui um AbrirLookup*/
89: *       AbrirBusca* seria INVENTAR tabela de lookup que o legado nunca
90: *       consultou - viola o PILAR 1 e a regra explicita "NUNCA inventar
91: *       tabelas de lookup". Por isso NAO ha metodo de lookup neste form,
92: *       e isso eh o estado CORRETO - nao eh fase incompleta.
93: *
94: *   (b) CAMPO RESTANTE. O legado tem UM unico campo de dados
95: *       (Label3 + getqtdsen), ja entregue na Fase 5 - nao ha "segunda
96: *       metade" de campos nesta tela.
97: *
98: *   (c) cnt_4c_BotoesAcao (Confirmar/Cancelar). Este eh um dialogo
99: *       OPERACIONAL, nao um CRUD: os quatro botoes do legado
100: *       (btnSenPend/btnExcel/btnGerSen/Saida) sao standalone e ja foram
101: *       criados na Fase 4. O legado nao tem Salvar nem Cancelar.
102: *
103: * O que esta fase ENTREGA, entao, eh a superficie de evento e validacao
104: * do unico campo que existe:
105: *
106: *   ConfigurarEventos()    - BINDEVENT do txt_4c_Qtdsen (PUBLIC, regra #3).
107: *   TxtQtdsenLostFocus()   - normaliza .Value para NUMERICO ao sair do
108: *        campo. No legado o getqtdsen tem .Value = 0 e Format = "K", e o
109: *        tipo era garantido pelo proprio controle; no migrado o TextBox
110: *        nasce por AddObject SEM ControlSource, entao o tipo de .Value
111: *        nao eh garantido por coluna nenhuma (mesma familia da regra #16:
112: *        "o form funciona em ALTERAR e explode em INCLUIR porque o legado
113: *        tinha ControlSource e o migrado nao"). Normalizacao SILENCIOSA -
114: *        nao exibe dialogo, porque o legado nao valida ao SAIR do campo
115: *        (ver ValidarQtdeSenhas abaixo); por o aviso aqui inventaria um
116: *        modal que o legado nao tem (PILAR 1) e eh exatamente o defeito
117: *        da regra #47/#50.
118: *   ObterQtdeSenhas()      - leitura normalizada do campo, equivalente ao
119: *        'lnQtd = thisform.getqtdsen.Value' do legado.
120: *   ValidarQtdeSenhas()    - TRANSCRICAO do guard de campo obrigatorio que
121: *        no legado mora no TOPO do Click de btnGerSen:
122: *            If Empty(thisform.getQtdSen.Value)
123: *                =Messagebox('Qtde de senhas obrigatorio.',48,[Aviso])
124: *                ThisForm.getQtdSen.Setfocus()
125: *                Return .f.
126: *            EndIf
127: *        A validacao do legado mora em DOIS lugares (o metodo de
128: *        validacao E o Click do botao) - ela eh validacao DO CAMPO, logo
129: *        pertence a esta fase; quem a CHAMA eh o BtnGerSenClick da Fase 7,
130: *        no mesmo ponto em que o legado a executa. Nao ligada a LostFocus
131: *        de proposito, pelo motivo acima.
132: *
133: * FASE 7/8 (esta fase): "eventos principais dos botoes". Os quatro nomes do
134: * roteiro generico - BtnIncluirClick/BtnAlterarClick/BtnVisualizarClick/
135: * BtnExcluirClick - sao convencao de form CRUD (a barra Incluir/Alterar/
136: * Visualizar/Excluir da Page1 de Lista do frmcadastro). MEDIDO no dump, este
137: * legado NAO TEM barra CRUD nenhuma: herda de `form` puro (nao de
138: * frmcadastro), nao tem Grupo_Op, nao tem a variavel de modo pcEscolha e
139: * nenhum dos seus quatro botoes tem nome de verbo CRUD. Criar esses quatro
140: * metodos aqui significaria INVENTAR botoes que o legado nao tem (viola o
141: * PILAR 1 e a regra "NUNCA inventar") ou deixar metodo vazio (proibido pela
142: * regra de completude). O que esta fase entrega sao os Click dos botoes de
143: * ACAO que o legado REALMENTE tem:
144: *
145: *   BtnGerSenClick()        - btnGerSen ("Gerar Senha"), a acao PRINCIPAL da
146: *        tela: guard de campo obrigatorio -> confirmacao -> geracao/gravacao
147: *        atomica no BO -> re-bind da grade -> aviso para anotar as senhas ->
148: *        zera a quantidade. Transcricao passo a passo do Click legado.
149: *   BtnSenPendClick()       - btnSenPend, dispara CarregarDados() (o
150: *        "Select * From SigPrSnd Where EmpDopNums = ''" do Click legado).
151: *   RecarregarGradeDoTemp() - funil unico do ZAP + APPEND FROM DBF() +
152: *        re-bind da grade, que o legado repete identico nos DOIS Clicks.
153: *
154: * Os dois BINDEVENT de Click entram em ConfigurarEventos (sempre guardados
155: * por PEMSTATUS do controle: BINDEVENT com objeto inexistente estoura no
156: * proprio BIND e derruba o Init). O Click de btnExcel (planilha) e o de Saida
157: * (ThisForm.Release) sao os eventos AUXILIARES e ficam para a Fase 8 - nao se
158: * liga aqui um Click cujo handler ainda nao existe.
159: *
160: * No BO, esta fase apoia-se em tres metodos novos (SigPrSndBO.prg):
161: * ContarSenhasIguais (o ChkRegister do fSqlConector legado), GerarSenhaUnica
162: * (o laco fKeyGen + ChkRegister) e GerarSenhasLivres (o Zap + For/Insert +
163: * Update + Commit/RollBack, num SQLEXEC unico com SAVE TRANSACTION para a
164: * gravacao ser de fato tudo-ou-nada como no legado).
165: *
166: * FASE 8/8 (esta fase): "eventos auxiliares e consolidacao final". Conferido
167: * metodo a metodo contra comportamento.json (totalMetodos=8): dos 8 metodos
168: * do legado, 6 ja estavam portados (Init/Load/Release na Fase 3, Click de
169: * btnSenPend/btnGerSen na Fase 7, When de grdSenha.Column1.Text1 nas Fases
170: * 4/6 via Column1.ReadOnly/Text1.ReadOnly). Faltavam os DOIS que a propria
171: * Fase 7 ja apontava como "auxiliares" - o Click de btnExcel e o de Saida:
172: *
173: *   BtnExcelClick() - TRANSCRICAO do Click de btnExcel ("Excel"): exporta a
174: *        coluna Senhads do cursor da grade (cursor_4c_Senhas) para planilha
175: *        XLS ou TXT delimitado, via PUTFILE() + fVerificaPasta() (wrapper ja
176: *        existente em utils\, criado exatamente para este padrao do VCX
177: *        DocumentoExcel do framework legado) + COPY TO. O "On Error llErr =
178: *        .t." do legado (trap global, que nao existe na arquitetura nova)
179: *        virou TRY/CATCH; MESSAGEBOX (proibido) virou MsgAviso - os DOIS
180: *        avisos do legado usam icone 48 (exclamacao/aviso), nenhum dos dois
181: *        eh erro tecnico.
182: *   BtnSaidaClick() - TRANSCRICAO do Click de Saida (ThisForm.Release).
183: *        Nome do handler pelo NOME DO OBJETO do legado (Saida -> cmd_4c_
184: *        Saida, por mapeamento.json), igual ao padrao ja adotado no legado-
185: *        irmao Formsigprsen.prg (BtnSaidaClick) - NAO "BtnEncerrarClick" do
186: *        roteiro generico de CRUD, que este form OPERACIONAL nao segue.
187: *
188: * Os dois BINDEVENT entram em ConfigurarEventos, junto dos dois ja ligados
189: * na Fase 7 - mesma guarda por PEMSTATUS do CONTROLE (BINDEVENT com objeto
190: * inexistente estoura no proprio BIND).
191: *
192: * O roteiro generico desta fase (BtnBuscarClick/BtnEncerrarClick/
193: * BtnSalvarClick/BtnCancelarClick/FormParaBO/BOParaForm/HabilitarCampos/
194: * LimparCampos/CarregarLista/AjustarBotoesPorModo) presume um form CRUD com
195: * Page1=Lista/Page2=Dados - NAO SE APLICA a este legado (confirmado contra o
196: * dump, analise.json e layout.json, mesma conclusao do legado-irmao
197: * Formsigprsen.prg):
198: *
199: *   - BtnBuscarClick / CarregarLista: a "busca" real do legado eh o Click
200: *     de btnSenPend (Select ... Where EmpDopNums = ''), ja portado como
201: *     BtnSenPendClick/CarregarDados na Fase 7 - criar outro handler
202: *     duplicaria a mesma acao.
203: *   - BtnSalvarClick / FormParaBO / BOParaForm / HabilitarCampos /
204: *     LimparCampos: o UNICO campo de dados (txt_4c_Qtdsen) nao eh uma
205: *     property do BO persistida por mapeamento Form<->BO - ele eh um
206: *     PARAMETRO lido uma vez (ObterQtdeSenhas()) e passado direto a
207: *     GerarSenhasLivres(loc_nQtd), exatamente como 'lnQtd =
208: *     thisform.getqtdsen.Value' no legado. Nao ha "registro" para
209: *     Incluir/Alterar/Visualizar - cada clique em "Gerar Senha" eh uma
210: *     operacao completa e imediata.
211: *   - BtnEncerrarClick / BtnCancelarClick: o UNICO botao de saida do
212: *     legado eh Saida.Click (ThisForm.Release), portado nesta fase como
213: *     BtnSaidaClick.
214: *   - AjustarBotoesPorModo: o legado nao tem pcEscolha/modos (INCLUIR/
215: *     ALTERAR/VISUALIZAR/EXCLUIR) - e um dialogo de UMA acao so (gerar
216: *     senhas livres), sem alternancia de pagina nem de estado de botoes.
217: *
218: * Inventar qualquer um desses metodos criaria UI/funcionalidade que o
219: * legado nao tem (PILAR 1) ou um stub sem logica real (proibido pela regra
220: * de completude) - as duas coisas sao erro, nao omissao.
221: *
222: * Integracao (checklist da tarefa): config.prg ja carrega SigPrSndBO.prg/
223: * FormSigPrSnd.prg dinamicamente via ADIR (nao exige SET PROCEDURE manual);
224: * o item de menu (popFerramentas, ao lado de "Gerar Senha do Dia") e o
225: * PROCEDURE AbrirFormSigPrSnd entram nesta fase em menu.prg.
226: *
227: * Arquitetura: FormBase (UI) -> BusinessBase (BO) -> DataAccess (SQL Server)
228: *==============================================================================
229: 
230: DEFINE CLASS FormSigPrSnd AS FormBase
231: 
232:     *-- Propriedades visuais (fieis ao SIGPRSND.scx)
233:     Width        = 500
234:     Height       = 324
235:     Caption      = "Senhas livres"
236:     ShowWindow   = 1
237:     WindowType   = 1
238: 
239:     *-- Dialogo modal sem barra de titulo (fiel ao legado)
240:     ControlBox   = .F.
241:     Closable     = .F.
242:     MaxButton    = .F.
243:     MinButton    = .F.
244:     ClipControls = .F.
245:     TitleBar     = 0
246:     BorderStyle  = 2
247:     AutoCenter   = .T.
248:     ShowTips     = .T.
249:     DataSession  = 2
250: 
251:     *-- Business Object (geracao de senhas livres - ver SigPrSndBO.prg)
252:     this_oBusinessObject = .NULL.
253: 
254:     *--------------------------------------------------------------------------
255:     PROCEDURE Init()
256:         RETURN DODEFAULT()
257:     ENDPROC
258: 
259:     *--------------------------------------------------------------------------
260:     * InicializarForm - Valida a conexao (guarda do Init legado), instancia
261:     * o Business Object e monta a faixa de titulo. Grid/campo de quantidade/
262:     * botoes entram nas proximas fases.
263:     *--------------------------------------------------------------------------
264:     PROTECTED PROCEDURE InicializarForm()
265:         LOCAL loc_lSucesso, loc_oErro
266:         loc_lSucesso = .F.
267: 
268:         IF THIS.ValidarParametros()
269:             TRY
270:                 THIS.Picture = gc_4c_CaminhoIcones + "new_background.jpg"
271: 
272:                 THIS.this_oBusinessObject = CREATEOBJECT("SigPrSndBO")
273: 
274:                 IF VARTYPE(THIS.this_oBusinessObject) != "O"
275:                     MsgErro("Erro ao criar SigPrSndBO." + CHR(13) + ;
276:                         "VARTYPE retornou: " + VARTYPE(THIS.this_oBusinessObject), ;
277:                         "Erro de Inicializa" + CHR(231) + CHR(227) + "o")
278:                 ELSE
279:                     THIS.ConfigurarCabecalho()
280:                     THIS.ConfigurarGrid()
281:                     THIS.ConfigurarBotoes()
282:                     THIS.ConfigurarCampos()
283:                     THIS.ConfigurarEventos()
284: 
285:                     *-- Cursor de trabalho das senhas + bind da grade. O
286:                     *-- cursor nasce VAZIO e a grade abre vazia DE PROPOSITO
287:                     *-- (regra #35a): o legado so consulta dados no Click de
288:                     *-- btnSenPend / btnGerSen, nunca no Init.
289:                     IF THIS.CriarCursorDados()
290:                         THIS.VincularGrade()
291:                     ENDIF
292: 
293:                     loc_lSucesso = .T.
294:                 ENDIF
295:             CATCH TO loc_oErro
296:                 MsgErro(loc_oErro.Message + CHR(13) + ;
297:                     "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
298:                     "Procedure: " + loc_oErro.Procedure, ;
299:                     "Erro ao Inicializar FormSigPrSnd")
300:                 loc_lSucesso = .F.
301:             ENDTRY
302:         ENDIF
303: 
304:         RETURN loc_lSucesso
305:     ENDPROC
306: 
307:     *--------------------------------------------------------------------------
308:     * ValidarParametros - guarda de conexao do Init legado:
309:     *     .poDataMgr = CreateObject('fSqlConector', ThisForm.Name)
310:     *     If (.poDataMgr.pnIdconn > 0)
311:     *         =DoDefault()
312:     *     Else
313:     *         =Messagebox('Impossivel Efetuar Conexao com Servidor de Banco
314:     *                      de Dados...', 0+48, 'CreateObject')
315:     *         Return .f.
316:     *     EndIf
317:     * gnConnHandle substitui o poDataMgr.pnIdconn (conexao global aberta em
318:     * main.prg). PUBLIC (sem PROTECTED) porque o harness de teste automatico
319:     * chama metodos do form de fora da classe (regra #3 / CLAUDE.md).
320:     *--------------------------------------------------------------------------
321:     PROCEDURE ValidarParametros()
322:         LOCAL loc_lValido
323:         loc_lValido = .T.
324: 
325:         IF TYPE("gb_4c_ModoTeste") = "L" AND gb_4c_ModoTeste
326:             RETURN .T.
327:         ENDIF
328:         IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
329:             RETURN .T.
330:         ENDIF
331: 
332:         DO CASE
333:             CASE TYPE("gnConnHandle") != "N"
334:                 loc_lValido = .F.
335:             CASE gnConnHandle <= 0
336:                 loc_lValido = .F.
337:         ENDCASE
338: 
339:         IF !loc_lValido
340:             MsgErro("Imposs" + CHR(237) + "vel Efetuar Conex" + CHR(227) + ;
341:                 "o com Servidor de Banco de Dados...", "CreateObject")
342:         ENDIF
343: 
344:         RETURN loc_lValido
345:     ENDPROC
346: 
347:     *--------------------------------------------------------------------------
348:     * ConfigurarCabecalho - Faixa cinza com o titulo (cntSombra do legado).
349:     * Width do container normalizado para THIS.Width (o dump legado traz
350:     * Width=800, herdado da classe compartilhada do Framework - maior que o
351:     * Form, que e 500; mesma normalizacao ja aplicada em Formsigprsen.prg
352:     * para o legado-irmao SIGPRSEN). Labels mantem a Width=769 literal do
353:     * dump (AutoSize=.F., BackStyle=0 transparente - a sobra nao pinta nada
354:     * e nao bloqueia clique em controle nenhum, porque e criada ANTES de
355:     * qualquer outro controle).
356:     *--------------------------------------------------------------------------
357:     PROTECTED PROCEDURE ConfigurarCabecalho()
358:         THIS.AddObject("cnt_4c_Sombra", "Container")
359:         WITH THIS.cnt_4c_Sombra
360:             .Top         = 0
361:             .Left        = 0
362:             .Width       = THIS.Width
363:             .Height      = 80
364:             .BackColor   = RGB(100, 100, 100)
365:             .BorderWidth = 0
366:             .Visible     = .T.
367: 
368:             .AddObject("lbl_4c_LblSombra", "Label")
369:             WITH .lbl_4c_LblSombra
370:                 .Top       = 18
371:                 .Left      = 10
372:                 .Width     = THIS.Width
373:                 .Height    = 40
374:                 .FontName  = "Tahoma"
375:                 .FontSize  = 18
376:                 .FontBold  = .T.
377:                 .Alignment = 0
378:                 .BackStyle = 0
379:                 .ForeColor = RGB(0, 0, 0)
380:                 .Caption   = THIS.Caption
381:                 .WordWrap  = .T.
382:                 .Visible   = .T.
383:             ENDWITH
384: 
385:             .AddObject("lbl_4c_LblTitulo", "Label")
386:             WITH .lbl_4c_LblTitulo
387:                 .Top       = 17
388:                 .Left      = 10
389:                 .Width     = THIS.Width
390:                 .Height    = 46
391:                 .FontName  = "Tahoma"
392:                 .FontSize  = 18
393:                 .FontBold  = .T.
394:                 .Alignment = 0
395:                 .BackStyle = 0
396:                 .ForeColor = RGB(255, 255, 255)
397:                 .Caption   = THIS.Caption

*-- Linhas 412 a 462:
412:     * OPERACIONAL (barra de marcacao lateral indevida).
413:     *
414:     * NAO liga RecordSource/ControlSource aqui: esse bind mora em
415:     * VincularGrade(), que eh chamado no InicializarForm (com o cursor
416:     * vazio, para o cabecalho "Senhas geradas" aparecer) e de novo em TODO
417:     * caminho que repopula o cursor - exatamente como o legado, que repete
418:     * o bloco de bind no Click de btnSenPend E no de btnGerSen. Concentrar
419:     * num metodo unico evita que um dos caminhos esqueca de reaplicar
420:     * Width/Header1.Caption, que o RecordSource reseta (Problema 48).
421:     *--------------------------------------------------------------------------
422:     PROTECTED PROCEDURE ConfigurarGrid()
423:         THIS.AddObject("grd_4c_Dados", "Grid")
424:         WITH THIS.grd_4c_Dados
425:             .Top                = 110
426:             .Left               = 48
427:             .Width              = 140
428:             .Height             = 162
429:             .ColumnCount        = 1
430:             .FontName           = "Verdana"
431:             .FontSize           = 8
432:             .HeaderHeight       = 16
433:             .RowHeight          = 16
434:             .ScrollBars         = 2
435:             .AllowHeaderSizing  = .F.
436:             .AllowRowSizing     = .F.
437:             .DeleteMark         = .F.
438:             .RecordMark         = .F.
439:             .GridLineColor      = RGB(238, 238, 238)
440: 
441:             WITH .Column1
442:                 .ColumnOrder = 1
443:                 .Width       = 100
444:                 .FontSize    = 8
445:                 .ReadOnly    = .T.
446: 
447:                 WITH .Header1
448:                     .FontName  = "Verdana"
449:                     .FontSize  = 8
450:                     .Alignment = 2
451:                     .ForeColor = RGB(36, 84, 155)
452:                     .Caption   = "Senhas geradas"
453:                 ENDWITH
454: 
455:                 WITH .Text1
456:                     .FontSize = 8
457:                     .ReadOnly = .T.
458:                 ENDWITH
459:             ENDWITH
460: 
461:             .Visible = .T.
462:         ENDWITH

*-- Linhas 475 a 518:
475:     * btnGerSen/Saida ficam em Top=4, dentro da faixa do cabecalho
476:     * (Height=80), e precisam desenhar POR CIMA dela.
477:     *--------------------------------------------------------------------------
478:     PROTECTED PROCEDURE ConfigurarBotoes()
479:         THIS.AddObject("cmd_4c_BtnSenPend", "CommandButton")
480:         WITH THIS.cmd_4c_BtnSenPend
481:             .Top             = 190
482:             .Left            = 251
483:             .Width           = 75
484:             .Height          = 75
485:             .Caption         = "Senhas pendentes"
486:             .FontName        = "Comic Sans MS"
487:             .FontBold        = .T.
488:             .FontItalic      = .T.
489:             .FontSize        = 8
490:             .ForeColor       = RGB(90, 90, 90)
491:             .BackColor       = RGB(255, 255, 255)
492:             .PicturePosition = 13
493:             .SpecialEffect   = 0
494:             .MousePointer    = 15
495:             .WordWrap        = .T.
496:             .AutoSize        = .F.
497:             .Themes          = .T.
498:             .Picture         = gc_4c_CaminhoIcones + "geral_lupa_60.jpg"
499:             .DisabledPicture = gc_4c_CaminhoIcones + "geral_lupa_60.jpg"
500:             .Visible         = .T.
501:         ENDWITH
502: 
503:         THIS.AddObject("cmd_4c_BtnExcel", "CommandButton")
504:         WITH THIS.cmd_4c_BtnExcel
505:             .Top             = 4
506:             .Left            = 275
507:             .Width           = 75
508:             .Height          = 75
509:             .Caption         = "Excel"
510:             .FontName        = "Comic Sans MS"
511:             .FontBold        = .T.
512:             .FontItalic      = .T.
513:             .FontSize        = 8
514:             .ForeColor       = RGB(90, 90, 90)
515:             .BackColor       = RGB(255, 255, 255)
516:             .PicturePosition = 13
517:             .SpecialEffect   = 0
518:             .MousePointer    = 15

*-- Linhas 590 a 1338:
590:     * literalmente do dump; .Value = 0 (numerico, ControlSource vazio no
591:     * legado - o campo so eh lido por codigo, nunca gravado no banco).
592:     *--------------------------------------------------------------------------
593:     PROTECTED PROCEDURE ConfigurarCampos()
594:         THIS.AddObject("lbl_4c_Label3", "Label")
595:         WITH THIS.lbl_4c_Label3
596:             .Top       = 87
597:             .Left      = 54
598:             .Width     = 86
599:             .Height    = 15
600:             .FontName  = "Tahoma"
601:             .FontSize  = 8
602:             .AutoSize  = .F.
603:             .BackStyle = 0
604:             .Alignment = 0
605:             .ForeColor = RGB(90, 90, 90)
606:             .Caption   = "Qtde de Senhas :"
607:             .Visible   = .T.
608:         ENDWITH
609: 
610:         THIS.AddObject("txt_4c_Qtdsen", "TextBox")
611:         WITH THIS.txt_4c_Qtdsen
612:             .Top           = 84
613:             .Left          = 152
614:             .Width         = 31
615:             .Height        = 23
616:             .FontName      = "Tahoma"
617:             .FontSize      = 8
618:             .Alignment     = 3
619:             .Value         = 0
620:             .Format        = "K"
621:             .MaxLength     = 3
622:             .SpecialEffect = 1
623:             .ForeColor     = RGB(90, 90, 90)
624:             .BorderColor   = RGB(100, 100, 100)
625:             .Themes        = .F.
626:             .Visible       = .T.
627:         ENDWITH
628:     ENDPROC
629: 
630:     *--------------------------------------------------------------------------
631:     * ConfigurarEventos - Liga os eventos dos CAMPOS do form. Chamado DEPOIS
632:     * de ConfigurarCampos(), que eh quem cria o txt_4c_Qtdsen (BINDEVENT em
633:     * controle inexistente estoura no proprio BIND).
634:     *
635:     * O legado NAO tem lookup nenhum (ver cabecalho, item (a)) - nao ha
636:     * KeyPress de F3/F4 nem DblClick de picker para ligar aqui. O unico
637:     * evento de campo do dump inteiro eh
638:     *     SIGPRSND.grdSenha.Column1.Text1.When -> Return .f.
639:     * ou seja, a celula da grade nao aceita digitacao. Esse comportamento JA
640:     * esta reproduzido de forma ESTATICA em ConfigurarGrid()/VincularGrade()
641:     * (Column1.ReadOnly = .T. + Text1.ReadOnly = .T.), que eh o equivalente
642:     * canonico do projeto - e eh a unica forma que funciona: BINDEVENT
643:     * DESCARTA o valor de retorno do delegate, entao um "When" ligado por
644:     * BINDEVENT nao bloquearia edicao nenhuma (regra conhecida do projeto).
645:     * Por isso NAO ha BINDEVENT de "When" aqui.
646:     *
647:     * O Click dos quatro botoes do legado entra nas Fases 7/8 (Eventos
648:     * Principais / Auxiliares) - nao se liga aqui um Click cujo handler
649:     * ainda nao existe, porque BINDEVENT com delegate inexistente estoura
650:     * na hora do BIND.
651:     *
652:     * PUBLIC (sem PROTECTED): BINDEVENT so funciona com metodo PUBLIC e o
653:     * harness de teste automatico chama metodos do form de FORA da classe
654:     * (regra #3 / #51 do CLAUDE.md).
655:     *--------------------------------------------------------------------------
656:     PROCEDURE ConfigurarEventos()
657:         LOCAL loc_lSucesso, loc_oErro
658:         loc_lSucesso = .F.
659: 
660:         TRY
661:             IF PEMSTATUS(THIS, "txt_4c_Qtdsen", 5)
662:                 BINDEVENT(THIS.txt_4c_Qtdsen, "LostFocus", THIS, "TxtQtdsenLostFocus")
663:                 loc_lSucesso = .T.
664:             ENDIF
665: 
666:             *-- Click dos botoes de ACAO do legado (Fase 7). Cada BINDEVENT eh
667:             *-- guardado pelo PEMSTATUS do CONTROLE porque BINDEVENT com objeto
668:             *-- inexistente estoura no proprio BIND, derrubando o Init inteiro.
669:             IF PEMSTATUS(THIS, "cmd_4c_BtnSenPend", 5)
670:                 BINDEVENT(THIS.cmd_4c_BtnSenPend, "Click", THIS, "BtnSenPendClick")
671:             ENDIF
672: 
673:             IF PEMSTATUS(THIS, "cmd_4c_BtnGerSen", 5)
674:                 BINDEVENT(THIS.cmd_4c_BtnGerSen, "Click", THIS, "BtnGerSenClick")
675:             ENDIF
676: 
677:             *-- Click dos botoes AUXILIARES do legado (Fase 8): exportar para
678:             *-- Excel e encerrar a tela. Mesma guarda por PEMSTATUS do
679:             *-- CONTROLE das duas linhas acima.
680:             IF PEMSTATUS(THIS, "cmd_4c_BtnExcel", 5)
681:                 BINDEVENT(THIS.cmd_4c_BtnExcel, "Click", THIS, "BtnExcelClick")
682:             ENDIF
683: 
684:             IF PEMSTATUS(THIS, "cmd_4c_Saida", 5)
685:                 BINDEVENT(THIS.cmd_4c_Saida, "Click", THIS, "BtnSaidaClick")
686:             ENDIF
687:         CATCH TO loc_oErro
688:             MsgErro(loc_oErro.Message + CHR(13) + ;
689:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
690:                 "Procedure: " + loc_oErro.Procedure, ;
691:                 "Erro em ConfigurarEventos")
692:             loc_lSucesso = .F.
693:         ENDTRY
694: 
695:         RETURN loc_lSucesso
696:     ENDPROC
697: 
698:     *--------------------------------------------------------------------------
699:     * TxtQtdsenLostFocus - Normaliza o conteudo de txt_4c_Qtdsen para
700:     * NUMERICO ao sair do campo.
701:     *
702:     * NAO exibe dialogo e NAO abre picker: o legado nao valida este campo ao
703:     * SAIR dele (o unico guard esta no Click de "Gerar Senha" - ver
704:     * ValidarQtdeSenhas). Avisar aqui inventaria um modal que o legado nao
705:     * tem, e apagar o digitado pelo usuario eh exatamente o defeito das
706:     * regras #47 e #50.
707:     *
708:     * Por que normalizar: no legado o getqtdsen nasce com .Value = 0 e o
709:     * tipo eh sustentado pelo proprio controle; no migrado o TextBox eh
710:     * criado por AddObject SEM ControlSource, entao nada garante que .Value
711:     * continue numerico depois de uma atribuicao por codigo (mesma familia
712:     * da regra #16). Normalizar no funil de saida do campo faz
713:     * ObterQtdeSenhas()/ValidarQtdeSenhas() e o laco de geracao da Fase 7
714:     * trabalharem sempre sobre numero.
715:     *
716:     * Sem parametros: LostFocus nao passa nenhum (declarar par_nKeyCode aqui
717:     * seria assinatura de handler de KeyPress - regra #47).
718:     *
719:     * PUBLIC (sem PROTECTED): exigencia do BINDEVENT (regra #3).
720:     *--------------------------------------------------------------------------
721:     PROCEDURE TxtQtdsenLostFocus()
722:         LOCAL loc_nQtd, loc_oErro
723: 
724:         TRY
725:             IF PEMSTATUS(THIS, "txt_4c_Qtdsen", 5)
726:                 loc_nQtd = THIS.ObterQtdeSenhas()
727: 
728:                 *-- So reescreve quando o conteudo NAO esta no tipo esperado,
729:                 *-- para nao mexer no que o usuario digitou sem necessidade.
730:                 IF VARTYPE(THIS.txt_4c_Qtdsen.Value) != "N"
731:                     THIS.txt_4c_Qtdsen.Value = loc_nQtd
732:                 ENDIF
733:             ENDIF
734:         CATCH TO loc_oErro
735:             MsgErro(loc_oErro.Message + CHR(13) + ;
736:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
737:                 "Procedure: " + loc_oErro.Procedure, ;
738:                 "Erro em TxtQtdsenLostFocus")
739:         ENDTRY
740:     ENDPROC
741: 
742:     *--------------------------------------------------------------------------
743:     * ObterQtdeSenhas - Leitura normalizada do campo "Qtde de Senhas".
744:     * Equivalente ao 'lnQtd = thisform.getqtdsen.Value' do Click de btnGerSen,
745:     * com a guarda de VARTYPE que o legado nao precisava ter (o controle dele
746:     * era numerico por construcao; o migrado nao tem ControlSource).
747:     *
748:     * Devolve SEMPRE um numero. Nao exibe mensagem - quem avisa eh
749:     * ValidarQtdeSenhas(), no mesmo ponto em que o legado avisa.
750:     *
751:     * PUBLIC: usado pelo BtnGerSenClick da Fase 7 e pelo harness (regra #3).
752:     *--------------------------------------------------------------------------
753:     PROCEDURE ObterQtdeSenhas()
754:         LOCAL loc_nQtd, loc_uValor
755:         loc_nQtd = 0
756: 
757:         IF PEMSTATUS(THIS, "txt_4c_Qtdsen", 5)
758:             loc_uValor = THIS.txt_4c_Qtdsen.Value
759: 
760:             DO CASE
761:                 CASE VARTYPE(loc_uValor) = "N"
762:                     loc_nQtd = loc_uValor
763:                 CASE VARTYPE(loc_uValor) = "C"
764:                     loc_nQtd = VAL(ALLTRIM(loc_uValor))
765:                 OTHERWISE
766:                     loc_nQtd = 0
767:             ENDCASE
768:         ENDIF
769: 
770:         RETURN loc_nQtd
771:     ENDPROC
772: 
773:     *--------------------------------------------------------------------------
774:     * ValidarQtdeSenhas - Campo "Qtde de Senhas" obrigatorio. TRANSCRICAO do
775:     * guard que abre o Click de btnGerSen no legado:
776:     *
777:     *     If Empty(thisform.getQtdSen.Value)
778:     *         =Messagebox('Qtde de senhas obrigatorio.',48,[Aviso])
779:     *         ThisForm.getQtdSen.Setfocus()
780:     *         Return .f.
781:     *     EndIf
782:     *
783:     * Mantidos o TEXTO e o TITULO do legado (icone 48 = aviso -> MsgAviso,
784:     * que eh a funcao canonica do projeto para validacao de UI; MESSAGEBOX
785:     * direto eh proibido). EMPTY(0) eh .T. em VFP9, entao o campo zerado
786:     * reprova exatamente como no legado.
787:     *
788:     * NAO acrescenta limite superior: o teto ja eh o MaxLength = 3 do
789:     * TextBox, transcrito do dump - inventar aqui um "maximo de N senhas"
790:     * seria regra de negocio que o legado nao tem.
791:     *
792:     * Chamado pelo BtnGerSenClick (Fase 7), no MESMO ponto do legado - nao
793:     * no LostFocus do campo (ver cabecalho).
794:     *
795:     * PUBLIC: chamado de fora da classe pelo harness de teste (regra #51 -
796:     * metodo que o form/teste chama de fora nunca pode ser PROTECTED).
797:     *--------------------------------------------------------------------------
798:     PROCEDURE ValidarQtdeSenhas()
799:         LOCAL loc_lValido, loc_nQtd
800:         loc_lValido = .T.
801: 
802:         loc_nQtd = THIS.ObterQtdeSenhas()
803: 
804:         IF EMPTY(loc_nQtd)
805:             MsgAviso("Qtde de senhas obrigat" + CHR(243) + "rio.", "Aviso")
806: 
807:             IF PEMSTATUS(THIS, "txt_4c_Qtdsen", 5) AND THIS.txt_4c_Qtdsen.Enabled ;
808:                     AND THIS.txt_4c_Qtdsen.Visible
809:                 THIS.txt_4c_Qtdsen.SetFocus()
810:             ENDIF
811: 
812:             loc_lValido = .F.
813:         ENDIF
814: 
815:         RETURN loc_lValido
816:     ENDPROC
817: 
818:     *--------------------------------------------------------------------------
819:     * CriarCursorDados - Cria o cursor de trabalho da grade (cursor_4c_Senhas,
820:     * equivalente ao crSigPrSnd do legado) delegando o SQL ao Business Object.
821:     *
822:     * No legado isso mora no Init, via poDataMgr.AddCursor com uma chave
823:     * SENTINELA (Replicate(Chr(254), 20)) que nao casa com registro nenhum:
824:     * o cursor nasce VAZIO e com a estrutura completa de SigPrSnd, pronto
825:     * para receber o Insert Into/Replace do Click de "Gerar Senha".
826:     *
827:     * PUBLIC (sem PROTECTED): o harness de teste automatico chama metodos do
828:     * form de FORA da classe (regra #3 / #51 do CLAUDE.md).
829:     *--------------------------------------------------------------------------
830:     PROCEDURE CriarCursorDados()
831:         LOCAL loc_lSucesso, loc_oErro
832:         loc_lSucesso = .F.
833: 
834:         TRY
835:             IF VARTYPE(THIS.this_oBusinessObject) = "O"
836:                 loc_lSucesso = THIS.this_oBusinessObject.CriarCursorSenhas()
837:             ENDIF
838:         CATCH TO loc_oErro
839:             MsgErro(loc_oErro.Message + CHR(13) + ;
840:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
841:                 "Procedure: " + loc_oErro.Procedure, ;
842:                 "Erro em CriarCursorDados")
843:             loc_lSucesso = .F.
844:         ENDTRY
845: 
846:         RETURN loc_lSucesso
847:     ENDPROC
848: 
849:     *--------------------------------------------------------------------------
850:     * VincularGrade - Liga grd_4c_Dados ao cursor_4c_Senhas. TRANSCRITO do
851:     * bloco que o legado repete no Click de btnSenPend E de btnGerSen:
852:     *     Select crSigPrSnd
853:     *     Go top
854:     *     Thisform.grdSenha.RecordSource = [crSigPrSnd]
855:     *     ThisForm.grdSenha.Column1.ControlSource = [crSigPrSnd.Senhads]
856:     *     ThisForm.grdSenha.Refresh()
857:     *
858:     * ORDEM OBRIGATORIA (regra #41 / Problema 48): ColumnCount -> RecordSource
859:     * -> ControlSource -> Width -> Header1.Caption. Atribuir RecordSource
860:     * RESETA Column.Width para o default 90 e o Header1.Caption para
861:     * "Header1", entao as propriedades visuais da coluna TEM de ser
862:     * reaplicadas DEPOIS do ControlSource - em TODO site que re-liga a grade,
863:     * e nao so no ConfigurarGrid.
864:     *
865:     * Reatribuir ColumnCount aqui eh seguro porque esta Column NAO tem
866:     * controle posto por AddObject (so os nativos Header1/Text1) - a regra
867:     * "nunca reatribuir ColumnCount" existe para proteger CheckBox/
868:     * OptionGroup criados em coluna, que nao eh o caso.
869:     *
870:     * PUBLIC (sem PROTECTED): chamado pelos handlers de Click (Fases 7/8) e
871:     * pelo harness de teste (regra #3).
872:     *--------------------------------------------------------------------------
873:     PROCEDURE VincularGrade()
874:         LOCAL loc_oGrid, loc_lSucesso, loc_oErro
875:         loc_lSucesso = .F.
876: 
877:         TRY
878:             IF USED("cursor_4c_Senhas") AND PEMSTATUS(THIS, "grd_4c_Dados", 5)
879:                 loc_oGrid = THIS.grd_4c_Dados
880: 
881:                 SELECT cursor_4c_Senhas
882:                 GO TOP
883: 
884:                 loc_oGrid.RecordSource = ""
885:                 loc_oGrid.ColumnCount  = 1
886:                 loc_oGrid.RecordSource = "cursor_4c_Senhas"
887: 
888:                 loc_oGrid.Column1.ControlSource = "cursor_4c_Senhas.senhads"
889: 
890:                 *-- Reaplicar DEPOIS do RecordSource/ControlSource (ver acima).
891:                 *-- Valores identicos aos do dump legado (grdSenha.Column1 /
892:                 *-- Column1.Header1 / Column1.Text1).
893:                 WITH loc_oGrid.Column1
894:                     .ColumnOrder = 1
895:                     .Width       = 100
896:                     .FontSize    = 8
897:                     .ReadOnly    = .T.
898: 
899:                     WITH .Header1
900:                         .FontName  = "Verdana"
901:                         .FontSize  = 8
902:                         .Alignment = 2
903:                         .ForeColor = RGB(36, 84, 155)
904:                         .Caption   = "Senhas geradas"
905:                     ENDWITH
906: 
907:                     WITH .Text1
908:                         .FontSize = 8
909:                         .ReadOnly = .T.
910:                     ENDWITH
911:                 ENDWITH
912: 
913:                 loc_oGrid.Refresh()
914:                 loc_lSucesso = .T.
915:             ENDIF
916:         CATCH TO loc_oErro
917:             MsgErro(loc_oErro.Message + CHR(13) + ;
918:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
919:                 "Procedure: " + loc_oErro.Procedure, ;
920:                 "Erro em VincularGrade")
921:             loc_lSucesso = .F.
922:         ENDTRY
923: 
924:         RETURN loc_lSucesso
925:     ENDPROC
926: 
927:     *--------------------------------------------------------------------------
928:     * CarregarDados - Carrega na grade as senhas ainda NAO vinculadas a
929:     * documento. TRANSCRITO do Click de btnSenPend:
930:     *     Thisform.grdSenha.RecordSource = []
931:     *     lcQuery = [Select * From SigPrSnd Where EmpDopNums = '']
932:     *     ThisForm.poDataMgr.SqlExecute(lcQuery,'crSigPrSnd')
933:     *     Select crSigPrSnd / Go top / <re-liga a grade> / Refresh()
934:     *
935:     * O SQL fica no BO e devolve cursor_4c_SenhasTemp; aqui o alias da grade
936:     * eh recarregado com ZAP + APPEND FROM DBF(), que PRESERVA estrutura,
937:     * RecordSource, ControlSource e as larguras - fechar e recriar o alias
938:     * derrubaria o bind e deixaria a grade permanentemente vazia com o cursor
939:     * cheio (regra #21a: SQLEXEC sobre alias de Grid zera o ColumnCount).
940:     *
941:     * O ZAP vai GUARDADO por SET SAFETY OFF: SAFETY eh escopado por data
942:     * session e este form eh DataSession = 2, onde ela vale ON mesmo com o
943:     * SET SAFETY OFF do main.prg - sem a guarda o ZAP abre o dialogo modal
944:     * de confirmacao e CONGELA a tela.
945:     *
946:     * Fecha com GO TOP + Refresh da grade: popular o cursor NAO repinta a
947:     * grade sozinho (regra #21).
948:     *
949:     * PUBLIC (sem PROTECTED): chamado pelo handler de Click (Fase 7) e pelo
950:     * harness de teste (regra #3).
951:     *--------------------------------------------------------------------------
952:     PROCEDURE CarregarDados()
953:         LOCAL loc_lSucesso, loc_oErro
954:         loc_lSucesso = .F.
955: 
956:         TRY
957:             IF VARTYPE(THIS.this_oBusinessObject) = "O"
958:                 *-- Garante o alias da grade (primeira carga, ou cursor
959:                 *-- derrubado por outro fluxo)
960:                 IF !USED("cursor_4c_Senhas")
961:                     THIS.CriarCursorDados()
962:                 ENDIF
963: 
964:                 IF USED("cursor_4c_Senhas") ;
965:                         AND THIS.this_oBusinessObject.CarregarSenhasPendentes()
966: 
967:                     *-- ZAP + APPEND FROM DBF + re-bind da grade moram no funil
968:                     *-- unico RecarregarGradeDoTemp (Fase 7), compartilhado com
969:                     *-- o Click de btnGerSen - o legado repete o MESMO bloco de
970:                     *-- re-bind nos dois Clicks (Problema 48 / regra #41).
971:                     loc_lSucesso = THIS.RecarregarGradeDoTemp()
972:                 ENDIF
973:             ENDIF
974:         CATCH TO loc_oErro
975:             MsgErro(loc_oErro.Message + CHR(13) + ;
976:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
977:                 "Procedure: " + loc_oErro.Procedure, ;
978:                 "Erro em CarregarDados")
979:             loc_lSucesso = .F.
980:         ENDTRY
981: 
982:         RETURN loc_lSucesso
983:     ENDPROC
984: 
985:     *--------------------------------------------------------------------------
986:     * RecarregarGradeDoTemp - recarrega o alias da grade a partir de
987:     * cursor_4c_SenhasTemp e repinta a grade.
988:     *
989:     * FUNIL UNICO dos dois caminhos que trazem linhas para a grade (o Click de
990:     * btnSenPend, via CarregarDados, e o Click de btnGerSen): o legado repete
991:     * o MESMO bloco de re-bind nos dois Clicks, e manter uma copia por caminho
992:     * eh como um deles acaba esquecendo de reaplicar Width/Header1.Caption, que
993:     * o RecordSource reseta (Problema 48 / regra #41).
994:     *
995:     * ZAP + APPEND FROM DBF() em vez de recriar o alias: SQLEXEC (ou USE IN +
996:     * SELECT INTO) sobre o alias ligado a um Grid FECHA e RECRIA o alias,
997:     * zerando RecordSource/ControlSource/ColumnCount - a grade viraria um
998:     * retangulo branco pelo RESTO da vida do form (regra #21a). O ZAP preserva
999:     * estrutura e bind; o APPEND casa as colunas por NOME.
1000:     *
1001:     * O ZAP vai GUARDADO por SET SAFETY OFF: SAFETY eh escopado por data
1002:     * session e este form eh DataSession = 2, onde ela vale ON mesmo com o
1003:     * SET SAFETY OFF do main.prg - sem a guarda o ZAP abre o dialogo modal de
1004:     * confirmacao e CONGELA a tela.
1005:     *
1006:     * Fecha com GO TOP + Refresh da grade (dentro de VincularGrade): popular o
1007:     * cursor NAO repinta a grade sozinho (regra #21).
1008:     *
1009:     * PUBLIC (sem PROTECTED): chamado pelos handlers de Click e pelo harness de
1010:     * teste automatico, que chama metodos do form de FORA da classe (regra #3 /
1011:     * #51 do CLAUDE.md).
1012:     *--------------------------------------------------------------------------
1013:     PROCEDURE RecarregarGradeDoTemp()
1014:         LOCAL loc_lSucesso, loc_cSafety, loc_oErro
1015:         loc_lSucesso = .F.
1016: 
1017:         TRY
1018:             *-- Garante o alias da grade (primeira carga, ou cursor derrubado
1019:             *-- por outro fluxo)
1020:             IF !USED("cursor_4c_Senhas")
1021:                 THIS.CriarCursorDados()
1022:             ENDIF
1023: 
1024:             IF USED("cursor_4c_Senhas") AND USED("cursor_4c_SenhasTemp")
1025:                 loc_cSafety = SET("SAFETY")
1026:                 SET SAFETY OFF
1027:                 ZAP IN cursor_4c_Senhas
1028:                 IF loc_cSafety = "ON"
1029:                     SET SAFETY ON
1030:                 ENDIF
1031: 
1032:                 SELECT cursor_4c_Senhas
1033:                 APPEND FROM DBF("cursor_4c_SenhasTemp")
1034: 
1035:                 USE IN cursor_4c_SenhasTemp
1036: 
1037:                 SELECT cursor_4c_Senhas
1038:                 GO TOP
1039: 
1040:                 THIS.VincularGrade()
1041:                 loc_lSucesso = .T.
1042:             ENDIF
1043:         CATCH TO loc_oErro
1044:             MsgErro(loc_oErro.Message + CHR(13) + ;
1045:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1046:                 "Procedure: " + loc_oErro.Procedure, ;
1047:                 "Erro em RecarregarGradeDoTemp")
1048:             loc_lSucesso = .F.
1049:         ENDTRY
1050: 
1051:         RETURN loc_lSucesso
1052:     ENDPROC
1053: 
1054:     *--------------------------------------------------------------------------
1055:     * BtnSenPendClick - Click de btnSenPend, o botao que lista as senhas ainda
1056:     * nao vinculadas a documento algum. TRANSCRITO:
1057:     *
1058:     *     Thisform.grdSenha.RecordSource = []
1059:     *     lcQuery = [Select * From SigPrSnd Where EmpDopNums = '']
1060:     *     ThisForm.poDataMgr.SqlExecute(lcQuery,'crSigPrSnd')
1061:     *     Select crSigPrSnd
1062:     *     Go top
1063:     *     Thisform.grdSenha.RecordSource = [crSigPrSnd]
1064:     *     ThisForm.grdSenha.Column1.ControlSource = [crSigPrSnd.Senhads]
1065:     *     ThisForm.grdSenha.Refresh()
1066:     *
1067:     * O corpo inteiro ja mora em CarregarDados() (consulta no BO + ZAP/APPEND +
1068:     * re-bind da grade); aqui fica o Click, que eh so o disparo.
1069:     *
1070:     * NAO exibe mensagem quando a consulta volta VAZIA: o legado nao avisa nada
1071:     * nesse caso - a grade simplesmente fica sem linhas. Inventar um
1072:     * MsgAviso("Nenhuma senha ...") aqui seria modal que o legado nao tem
1073:     * (PILAR 1), que eh o defeito das regras #47/#50.
1074:     *
1075:     * PUBLIC: exigencia do BINDEVENT (regra #3) e do harness (regra #51).
1076:     *--------------------------------------------------------------------------
1077:     PROCEDURE BtnSenPendClick()
1078:         LOCAL loc_lSucesso, loc_oErro
1079:         loc_lSucesso = .F.
1080: 
1081:         TRY
1082:             loc_lSucesso = THIS.CarregarDados()
1083:         CATCH TO loc_oErro
1084:             MsgErro(loc_oErro.Message + CHR(13) + ;
1085:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1086:                 "Procedure: " + loc_oErro.Procedure, ;
1087:                 "Erro em BtnSenPendClick")
1088:             loc_lSucesso = .F.
1089:         ENDTRY
1090: 
1091:         RETURN loc_lSucesso
1092:     ENDPROC
1093: 
1094:     *--------------------------------------------------------------------------
1095:     * BtnGerSenClick - Click de btnGerSen ("Gerar Senha"). Acao PRINCIPAL da
1096:     * tela. TRANSCRITO do legado, na MESMA ordem:
1097:     *
1098:     *   1. campo obrigatorio      -> THIS.ValidarQtdeSenhas()
1099:     *          If Empty(thisform.getQtdSen.Value)
1100:     *              =Messagebox('Qtde de senhas obrigatorio.',48,[Aviso])
1101:     *              ThisForm.getQtdSen.Setfocus() / Return .f.
1102:     *   2. confirmacao do usuario -> MsgConfirma(...)
1103:     *          If Messagebox([Deseja realmente gerar ] + Alltrim(Str(lnQtd)) +
1104:     *                        [ senhas livres?],4+32+256,[Gerar Senha]) = 7
1105:     *              Return .f.
1106:     *   3. Zap + geracao + gravacao + Commit/RollBack -> BO.GerarSenhasLivres()
1107:     *   4. re-bind da grade com as senhas geradas     -> RecarregarGradeDoTemp()
1108:     *   5. aviso de sucesso
1109:     *          =Messagebox([Favor anotar as senhas geradas.],48,[Senhas Livres])
1110:     *   6. thisform.getqtdsen.Value = 0
1111:     *
1112:     * MsgConfirma devolve LOGICO (.T. = Sim), nao numero: comparar com 6 ou 7
1113:     * eh o defeito da regra #7. Ela usa MESSAGEBOX com 4+32 (Sim/Nao + icone de
1114:     * pergunta); o legado soma ainda 256 (segundo botao como default, ou seja o
1115:     * "Nao" pre-selecionado). MESSAGEBOX direto eh PROIBIDO no projeto, entao
1116:     * fica a funcao canonica - a diferenca eh qual botao chega pre-selecionado.
1117:     *
1118:     * A mensagem de sucesso usa MsgAviso porque o legado usa o icone 48
1119:     * (exclamacao/aviso) - eh um recado para o usuario ANOTAR as senhas, nao um
1120:     * "gravado com sucesso" qualquer, e MsgAviso eh a funcao canonica do
1121:     * projeto para icone 48.
1122:     *
1123:     * O passo 6 (zerar o campo) roda SO em caso de sucesso: no legado ele esta
1124:     * depois do If/Else de Commit/RollBack, mas os dois RETURN anteriores (campo
1125:     * vazio e confirmacao negada) desviam antes de chegar la, e com a gravacao
1126:     * falhando nao faz sentido apagar a quantidade que o usuario digitou - ele
1127:     * vai querer tentar de novo (regra #50).
1128:     *
1129:     * PUBLIC: exigencia do BINDEVENT (regra #3) e do harness (regra #51).
1130:     *--------------------------------------------------------------------------
1131:     PROCEDURE BtnGerSenClick()
1132:         LOCAL loc_nQtd, loc_lSucesso, loc_lProsseguir, loc_oErro
1133:         loc_lSucesso    = .F.
1134:         loc_lProsseguir = .T.
1135: 
1136:         *-- Os dois guards do legado ficam FORA do TRY, para o desvio ser um
1137:         *-- RETURN de verdade e nao um salto para o CATCH (regra #1)
1138:         IF !THIS.ValidarQtdeSenhas()
1139:             RETURN .F.
1140:         ENDIF
1141: 
1142:         loc_nQtd = THIS.ObterQtdeSenhas()
1143: 
1144:         IF !MsgConfirma("Deseja realmente gerar " + ALLTRIM(STR(loc_nQtd)) + ;
1145:                 " senhas livres?", "Gerar Senha")
1146:             RETURN .F.
1147:         ENDIF
1148: 
1149:         TRY
1150:             IF VARTYPE(THIS.this_oBusinessObject) != "O"
1151:                 MsgErro("Business Object n" + CHR(227) + "o inicializado.", "Gerar Senha")
1152:                 loc_lProsseguir = .F.
1153:             ENDIF
1154: 
1155:             IF loc_lProsseguir
1156:                 IF THIS.this_oBusinessObject.GerarSenhasLivres(loc_nQtd)
1157:                     *-- A grade passa a exibir SO as senhas recem-geradas, como
1158:                     *-- no legado (que faz Zap no cursor antes de gerar)
1159:                     THIS.RecarregarGradeDoTemp()
1160: 
1161:                     MsgAviso("Favor anotar as senhas geradas.", "Senhas Livres")
1162: 
1163:                     IF PEMSTATUS(THIS, "txt_4c_Qtdsen", 5)
1164:                         THIS.txt_4c_Qtdsen.Value = 0
1165:                     ENDIF
1166: 
1167:                     loc_lSucesso = .T.
1168:                 ELSE
1169:                     *-- BusinessBase.ExibirFalha ja mostrou o motivo e marcou
1170:                     *-- this_lErroExibido; nao repetir a mensagem (regra #20)
1171:                     IF !THIS.this_oBusinessObject.this_lErroExibido
1172:                         MsgErro("N" + CHR(227) + "o foi poss" + CHR(237) + ;
1173:                             "vel gerar as senhas livres.", "Gerar Senha")
1174:                     ENDIF
1175:                 ENDIF
1176:             ENDIF
1177:         CATCH TO loc_oErro
1178:             MsgErro(loc_oErro.Message + CHR(13) + ;
1179:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1180:                 "Procedure: " + loc_oErro.Procedure, ;
1181:                 "Erro em BtnGerSenClick")
1182:             loc_lSucesso = .F.
1183:         ENDTRY
1184: 
1185:         RETURN loc_lSucesso
1186:     ENDPROC
1187: 
1188: 
1189:     *--------------------------------------------------------------------------
1190:     * BtnExcelClick - Click de btnExcel ("Excel"). Exporta a coluna de senhas
1191:     * atualmente exibida na grade (cursor_4c_Senhas) para planilha XLS ou
1192:     * TXT delimitado. TRANSCRITO do legado:
1193:     *
1194:     *     Select SenhaDs as Senhas From crSigPrSnd Into Cursor TmpPrSnd
1195:     *     Select TmpPrSnd
1196:     *     llErr = .f.
1197:     *     lcErr = On([Error]) / On Error llErr = .t.
1198:     *     lcExl = PutFile([Nome da Planilha], [], [XLS;TXT])
1199:     *     If fVerificaPasta(lcExl, 2)
1200:     *         If (Lower(Alltrim(JustExt(lcExl))) = [xls])
1201:     *             Copy To (lcExl) Type Xl5
1202:     *         Else
1203:     *             Copy To (lcExl) Delimited With '' With Character ';'
1204:     *         EndIf
1205:     *         If File(lcExl)
1206:     *             =MessageBox([Arquivo gerado com sucesso], 0+48+32, ;
1207:     *                 [Geracao de Planilha])
1208:     *         EndIf
1209:     *     Else
1210:     *         llErr = .t.
1211:     *     EndIf
1212:     *     If llErr
1213:     *         =MessageBox([Falha na Geracao da Planilha. Verifique o ;
1214:     *             Diretorio ou Planilha Em Uso], 0+48+32, [Geracao de Planilha])
1215:     *     EndIf
1216:     *     On Error &lcErr.
1217:     *     Use in TmpPrSnd
1218:     *
1219:     * O "On Error llErr = .t." (trap global, inexistente na arquitetura
1220:     * nova) virou TRY/CATCH em volta do COPY TO. MESSAGEBOX e PROIBIDO - os
1221:     * DOIS avisos do legado usam icone 48 (exclamacao/aviso, nao 16/erro),
1222:     * entao os dois mapeiam para MsgAviso.
1223:     *
1224:     * NAO ha guarda extra para "lcExl vazio" (usuario cancelou o PutFile):
1225:     * o legado tambem nao tem - fVerificaPasta("",...) ja devolve .F. (ver
1226:     * utils\fverificapasta.prg) e cai no MESMO "Falha na Geracao..." que o
1227:     * legado mostraria. Transcricao literal, nao aproximacao (PILAR 1).
1228:     *
1229:     * PutFile()/GETFILE nativos do VFP9 continuam existindo sem troca.
1230:     * fVerificaPasta() ja existe em utils\ (wrapper de compatibilidade para
1231:     * o mesmo padrao do VCX DocumentoExcel do framework legado - mesmo
1232:     * contrato, 2o parametro ignorado).
1233:     *
1234:     * PUBLIC: exigencia do BINDEVENT (regra #3) e do harness (regra #51).
1235:     *--------------------------------------------------------------------------
1236:     PROCEDURE BtnExcelClick()
1237:         LOCAL loc_cArquivo, loc_lErro, loc_oErro
1238:         loc_lErro = .F.
1239: 
1240:         IF !USED("cursor_4c_Senhas")
1241:             RETURN .F.
1242:         ENDIF
1243: 
1244:         TRY
1245:             IF USED("cursor_4c_TmpSenhas")
1246:                 USE IN cursor_4c_TmpSenhas
1247:             ENDIF
1248: 
1249:             SELECT senhads AS Senhas FROM cursor_4c_Senhas ;
1250:                 INTO CURSOR cursor_4c_TmpSenhas
1251: 
1252:             SELECT cursor_4c_TmpSenhas
1253: 
1254:             loc_cArquivo = PUTFILE("Nome da Planilha", "", "XLS;TXT")
1255: 
1256:             IF fVerificaPasta(loc_cArquivo, 2)
1257:                 TRY
1258:                     IF LOWER(ALLTRIM(JUSTEXT(loc_cArquivo))) = "xls"
1259:                         COPY TO (loc_cArquivo) TYPE XL5
1260:                     ELSE
1261:                         COPY TO (loc_cArquivo) DELIMITED WITH "" WITH CHARACTER ";"
1262:                     ENDIF
1263:                 CATCH TO loc_oErro
1264:                     loc_lErro = .T.
1265:                 ENDTRY
1266: 
1267:                 IF !loc_lErro AND FILE(loc_cArquivo)
1268:                     MsgAviso("Arquivo gerado com sucesso", ;
1269:                         "Gera" + CHR(231) + CHR(227) + "o de Planilha")
1270:                 ENDIF
1271:             ELSE
1272:                 loc_lErro = .T.
1273:             ENDIF
1274:         CATCH TO loc_oErro
1275:             loc_lErro = .T.
1276:         ENDTRY
1277: 
1278:         IF loc_lErro
1279:             MsgAviso("Falha na Gera" + CHR(231) + CHR(227) + "o da Planilha. " + ;
1280:                 "Verifique o Diret" + CHR(243) + "rio ou Planilha Em Uso", ;
1281:                 "Gera" + CHR(231) + CHR(227) + "o de Planilha")
1282:         ENDIF
1283: 
1284:         IF USED("cursor_4c_TmpSenhas")
1285:             USE IN cursor_4c_TmpSenhas
1286:         ENDIF
1287: 
1288:         RETURN !loc_lErro
1289:     ENDPROC
1290: 
1291:     *--------------------------------------------------------------------------
1292:     * BtnSaidaClick - Click de Saida (cmd_4c_Saida, caption "Encerrar").
1293:     * Fiel ao legado:
1294:     *     PROCEDURE Click
1295:     *     ThisForm.Release
1296:     *
1297:     * Nome do handler pelo NOME DO OBJETO do legado ("Saida"), nao pelo
1298:     * roteiro generico de CRUD ("BtnEncerrarClick") - este form OPERACIONAL
1299:     * nao segue esse roteiro (ver cabecalho do arquivo). Mesmo padrao do
1300:     * legado-irmao Formsigprsen.prg (BtnSaidaClick).
1301:     *
1302:     * PUBLIC: exigencia do BINDEVENT (regra #3) e do harness (regra #51).
1303:     *--------------------------------------------------------------------------
1304:     PROCEDURE BtnSaidaClick()
1305:         THIS.Release()
1306:     ENDPROC
1307: 
1308:     *--------------------------------------------------------------------------
1309:     * Destroy - Libera o Business Object (DODEFAULT() ao final - regra do
1310:     * CorretorAutomatico #145: sem ela o menu do sistema encolhe visualmente).
1311:     *--------------------------------------------------------------------------
1312:     PROCEDURE Destroy()
1313:         IF USED("cursor_4c_SenhasTemp")
1314:             USE IN cursor_4c_SenhasTemp
1315:         ENDIF
1316:         IF USED("cursor_4c_SenhasEstrut")
1317:             USE IN cursor_4c_SenhasEstrut
1318:         ENDIF
1319:         IF USED("cursor_4c_TmpSenhas")
1320:             USE IN cursor_4c_TmpSenhas
1321:         ENDIF
1322:         IF USED("cursor_4c_Senhas")
1323:             *-- TABLEREVERT SO com buffering ligado (ver SigPrSndBO.
1324:             *-- CriarCursorSenhas): sem buffer ele dispara erro, e erro no
1325:             *-- Destroy impede a tela de FECHAR.
1326:             IF CURSORGETPROP("Buffering", "cursor_4c_Senhas") > 1
1327:                 TABLEREVERT(.T., "cursor_4c_Senhas")
1328:             ENDIF
1329:             USE IN cursor_4c_Senhas
1330:         ENDIF
1331: 
1332:         IF VARTYPE(THIS.this_oBusinessObject) = "O"
1333:             THIS.this_oBusinessObject = .NULL.
1334:         ENDIF
1335:         DODEFAULT()
1336:     ENDPROC
1337: 
1338: ENDDEFINE


### BO (C:\4c\projeto\app\classes\SigPrSndBO.prg):
*============================================================================
* SigPrSndBO.prg - Business Object para Senhas Livres (Geracao de Senhas)
*
* Tabela: SigPrSnd  (PK: cidchaves char(20))
*
* Herda de: BusinessBase
* Criado em: Fase 1 - Propriedades e Init
*============================================================================

DEFINE CLASS SigPrSndBO AS BusinessBase

    *==========================================================================
    * Propriedades da entidade SigPrSnd (campos do banco)
    *==========================================================================
    this_cCidchaves  = ""   && char(20)      - Chave primaria (gerada via fUniqueIds)
    this_dDatas      = {}   && datetime NULL - Data de geracao da senha
    this_nDocs       = 0    && numeric(10,0) - Numero do documento vinculado
    this_cHoras      = ""   && char(8)       - Hora de geracao da senha
    this_cMotivos    = ""   && char(40)      - Motivo da geracao da senha
    this_cOperas     = ""   && char(20)      - Operacao vinculada a senha
    this_cSenhads    = ""   && char(6)       - Senha gerada (codigo)
    this_cSolicits   = ""   && char(10)      - Solicitante da senha
    this_cUsuars     = ""   && char(10)      - Usuario que gerou a senha
    this_nValors     = 0    && numeric(11,2) - Valor vinculado a senha
    this_nTipos      = 0    && numeric(1,0)  - Tipo da senha (0=Livre)
    this_cEmps       = ""   && char(3)       - Codigo da empresa
    this_cFpags      = ""   && char(12)      - Forma de pagamento vinculada
    this_cEmpdopnums = ""   && char(29)      - Chave de vinculo Empresa+Documento+Operacao+Numero
    this_nPerlimite  = 0    && numeric(5,2)  - Percentual limite vinculado a senha

    *==========================================================================
    * Estado interno da geracao de senhas (nao sao colunas de SigPrSnd)
    *
    * this_lRandSemeado    - RAND() do VFP9 comeca numa semente FIXA, entao sem
    *      RAND(-1) (semente do relogio) duas sessoes gerariam a MESMA sequencia
    *      de candidatos. Semeado UMA vez por instancia do BO.
    * this_nMaxTentativasSenha - teto de tentativas por senha. O legado escreve
    *      "Do While _Inicio = 0" SEM teto: com a faixa de senhas esgotada, ou
    *      com a consulta de duplicidade falhando, aquele laco gira para sempre
    *      e CONGELA o dialogo modal sem mensagem nenhuma. O teto eh um desvio
    *      DELIBERADO do legado - ver GerarSenhaUnica.
    *==========================================================================
    this_lRandSemeado        = .F.
    this_nMaxTentativasSenha = 100

    *==========================================================================
    * Init - Inicializa o Business Object configurando tabela e chave primaria
    *==========================================================================
    PROCEDURE Init()
        LOCAL loc_lResultado
        loc_lResultado = .F.

        TRY
            DODEFAULT()
            THIS.this_cTabela     = "SigPrSnd"
            THIS.this_cCampoChave = "cidchaves"
            loc_lResultado = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * ObterChavePrimaria - Retorna a chave primaria do registro atual
    * (usada por RegistrarAuditoria)
    *==========================================================================
    PROTECTED PROCEDURE ObterChavePrimaria()
        RETURN ALLTRIM(THIS.this_cCidchaves)
    ENDPROC

    *==========================================================================
    * CarregarDoCursor - Carrega as propriedades do BO a partir do cursor
    * REGRA CRITICA: SELECT (par_cAliasCursor) ANTES de acessar os campos
    * (nao usar sintaxe campo - erro de sintaxe em VFP9)
    *==========================================================================
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF USED(par_cAliasCursor)
                SELECT (par_cAliasCursor)
                THIS.this_cCidchaves  = TratarNulo(cidchaves,  "")
                THIS.this_dDatas      = ConverterParaData(TratarNulo(datas, {}))
                THIS.this_nDocs       = TratarNulo(docs,       0)
                THIS.this_cHoras      = TratarNulo(horas,      "")
                THIS.this_cMotivos    = TratarNulo(motivos,    "")
                THIS.this_cOperas     = TratarNulo(operas,     "")
                THIS.this_cSenhads    = TratarNulo(senhads,    "")
                THIS.this_cSolicits   = TratarNulo(solicits,   "")
                THIS.this_cUsuars     = TratarNulo(usuars,     "")
                THIS.this_nValors     = TratarNulo(valors,     0)
                THIS.this_nTipos      = TratarNulo(tipos,      0)
                THIS.this_cEmps       = TratarNulo(emps,       "")
                THIS.this_cFpags      = TratarNulo(fpags,      "")
                THIS.this_cEmpdopnums = TratarNulo(empdopnums, "")
                THIS.this_nPerlimite  = TratarNulo(perlimite,  0)
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MostrarErro("Erro ao carregar do cursor:" + CHR(13) + loc_oErro.Message, "SigPrSndBO.CarregarDoCursor")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * Inserir - Grava uma nova senha livre na tabela SigPrSnd
    * Cobre TODAS as colunas NOT NULL (regra #22 CLAUDE.md)
    *==========================================================================
    PROCEDURE Inserir()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF EMPTY(ALLTRIM(THIS.this_cCidchaves))
                THIS.this_cCidchaves = fUniqueIds()
            ENDIF

            TEXT TO loc_cSQL TEXTMERGE NOSHOW
                INSERT INTO SigPrSnd (cidchaves, datas, docs, horas, motivos, operas, senhads, solicits, usuars, valors, tipos, emps, fpags, empdopnums, perlimite)
                VALUES (
                    <<EscaparSQL(THIS.this_cCidchaves)>>,
                    <<FormatarDataSQL(THIS.this_dDatas)>>,
                    <<FormatarNumeroSQL(THIS.this_nDocs, 0)>>,
                    <<EscaparSQL(THIS.this_cHoras)>>,
                    <<EscaparSQL(THIS.this_cMotivos)>>,
                    <<EscaparSQL(THIS.this_cOperas)>>,
                    <<EscaparSQL(THIS.this_cSenhads)>>,
                    <<EscaparSQL(THIS.this_cSolicits)>>,
                    <<EscaparSQL(THIS.this_cUsuars)>>,
                    <<FormatarNumeroSQL(THIS.this_nValors, 2)>>,
                    <<FormatarNumeroSQL(THIS.this_nTipos, 0)>>,
                    <<EscaparSQL(THIS.this_cEmps)>>,
                    <<EscaparSQL(THIS.this_cFpags)>>,
                    <<EscaparSQL(THIS.this_cEmpdopnums)>>,
                    <<FormatarNumeroSQL(THIS.this_nPerlimite, 2)>>
                )
            ENDTEXT

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("INSERT")
                loc_lSucesso = .T.
            ELSE
                MostrarErro("Erro ao gravar a senha livre:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loc_oErro
            MostrarErro("Erro ao inserir:" + CHR(13) + loc_oErro.Message, "SigPrSndBO.Inserir")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * Atualizar - Atualiza registro existente na tabela SigPrSnd
    * (o legado nao altera senhas ja geradas - este metodo existe para
    * completar a arquitetura em camadas, por exemplo ao vincular a senha
    * a um documento/operacao apos a geracao)
    *==========================================================================
    PROCEDURE Atualizar()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            TEXT TO loc_cSQL TEXTMERGE NOSHOW
                UPDATE SigPrSnd
                SET datas      = <<FormatarDataSQL(THIS.this_dDatas)>>,
                    docs       = <<FormatarNumeroSQL(THIS.this_nDocs, 0)>>,
                    horas      = <<EscaparSQL(THIS.this_cHoras)>>,
                    motivos    = <<EscaparSQL(THIS.this_cMotivos)>>,
                    operas     = <<EscaparSQL(THIS.this_cOperas)>>,
                    senhads    = <<EscaparSQL(THIS.this_cSenhads)>>,
                    solicits   = <<EscaparSQL(THIS.this_cSolicits)>>,
                    usuars     = <<EscaparSQL(THIS.this_cUsuars)>>,
                    valors     = <<FormatarNumeroSQL(THIS.this_nValors, 2)>>,
                    tipos      = <<FormatarNumeroSQL(THIS.this_nTipos, 0)>>,
                    emps       = <<EscaparSQL(THIS.this_cEmps)>>,
                    fpags      = <<EscaparSQL(THIS.this_cFpags)>>,
                    empdopnums = <<EscaparSQL(THIS.this_cEmpdopnums)>>,
                    perlimite  = <<FormatarNumeroSQL(THIS.this_nPerlimite, 2)>>
                WHERE cidchaves = <<EscaparSQL(THIS.this_cCidchaves)>>
            ENDTEXT

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("UPDATE")
                loc_lSucesso = .T.
            ELSE
                MostrarErro("Erro ao atualizar a senha livre:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loc_oErro
            MostrarErro("Erro ao atualizar:" + CHR(13) + loc_oErro.Message, "SigPrSndBO.Atualizar")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * CriarCursorSenhas - Cria o cursor de trabalho das senhas, VAZIO e
    * READWRITE, com a estrutura EXATA de SigPrSnd.
    *
    * TRANSCRITO do Init legado, que monta o cursor com uma chave SENTINELA
    * que nao casa com registro nenhum - ele nasce VAZIO DE PROPOSITO, e a
    * grade abre vazia esperando o usuario acionar btnSenPend ou
    * btnGerSen:
    *     pIds      = Replicate(Chr(254), 20)
    *     lcQrySend = [Select * From SigPrSnd Where cIdChaves = '] + pIds + [']
    *     .AddCursor('SigPrSnd','cIdChaves','crSigPrSnd','','',lcQrySend)
    *
    * READWRITE eh OBRIGATORIO: o Click de btnGerSen faz Zap/Insert Into/
    * Replace nesse cursor, e cursor devolvido por SQLEXEC nasce
    * SOMENTE-LEITURA. Por isso o SQLEXEC vai para um alias de ESTRUTURA e o
    * cursor final sai de um SELECT ... INTO CURSOR ... READWRITE.
    *
    * PUBLIC (sem PROTECTED): o Form chama este metodo de FORA da classe
    * (regra #51 - PROTECTED em qualquer nivel da heranca faz a chamada
    * externa estourar "Property CRIARCURSORSENHAS is not found").
    *==========================================================================
    PROCEDURE CriarCursorSenhas()
        LOCAL loc_cSQL, loc_nResultado, loc_cNull, loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        TRY
            *-- Derruba o cursor anterior (e as edicoes nao gravadas dele) para o
            *-- SELECT seguinte nao falhar com "uncommitted changes"
            IF USED("cursor_4c_Senhas")
                *-- TABLEREVERT SO com buffering ligado: medido no VFP9, cursor
                *-- de SELECT ... INTO CURSOR READWRITE tem Buffering = 1 (sem
                *-- buffer) e TABLEREVERT nele DISPARA ERRO - em tela headless
                *-- isso vira dialogo de Program Error que CONGELA o processo.
                IF CURSORGETPROP("Buffering", "cursor_4c_Senhas") > 1
                    TABLEREVERT(.T., "cursor_4c_Senhas")
                ENDIF
                USE IN cursor_4c_Senhas
            ENDIF
            IF USED("cursor_4c_SenhasEstrut")
                USE IN cursor_4c_SenhasEstrut
            ENDIF

            loc_nResultado = -1

            IF TYPE("gnConnHandle") = "N" AND gnConnHandle > 0
                loc_cSQL = "SELECT * FROM SigPrSnd WHERE cidchaves = " + ;
                    EscaparSQL(REPLICATE(CHR(254), 20))

                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_SenhasEstrut")
            ENDIF

            IF loc_nResultado >= 0 AND USED("cursor_4c_SenhasEstrut")
                *-- Estrutura vinda do proprio banco (PILAR 2: nenhuma coluna
                *-- inventada) e cursor final READWRITE
                SELECT * FROM cursor_4c_SenhasEstrut ;
                    INTO CURSOR cursor_4c_Senhas READWRITE
                USE IN cursor_4c_SenhasEstrut
            ELSE
                *-- Sem conexao (modo de teste/validacao de UI): estrutura
                *-- declarada na MESMA ORDEM de docs\schema.sql, para que o
                *-- APPEND FROM DBF() de CarregarSenhasPendentes case por nome
                loc_cNull = SET("NULL")
                SET NULL ON
                CREATE CURSOR cursor_4c_Senhas ( ;
                    datas      T        NULL, ;
                    docs       N(10, 0) NULL, ;
                    horas      C(8)     NULL, ;
                    motivos    C(40)    NULL, ;
                    operas     C(20)    NULL, ;
                    senhads    C(6)     NULL, ;
                    solicits   C(10)    NULL, ;
                    usuars     C(10)    NULL, ;
                    valors     N(11, 2) NULL, ;
                    cidchaves  C(20)    NULL, ;
                    tipos      N(1, 0)  NULL, ;
                    emps       C(3)     NULL, ;
                    fpags      C(12)    NULL, ;
                    empdopnums C(29)    NULL, ;
                    perlimite  N(5, 2)  NULL)
                IF loc_cNull = "OFF"
                    SET NULL OFF
                ENDIF
            ENDIF

            loc_lSucesso = USED("cursor_4c_Senhas")

        CATCH TO loc_oErro
            MostrarErro("Erro ao criar o cursor de senhas:" + CHR(13) + ;
                loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo), ;
                "SigPrSndBO.CriarCursorSenhas")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * CarregarSenhasPendentes - Consulta as senhas ainda NAO vinculadas a
    * documento algum e devolve o resultado em cursor_4c_SenhasTemp.
    *
    * TRANSCRITO do Click de btnSenPend:
    *     lcQuery = [Select * From SigPrSnd Where EmpDopNums = '']
    *     ThisForm.poDataMgr.SqlExecute(lcQuery,'crSigPrSnd')
    *
    * O resultado vai para um cursor TEMPORARIO - NUNCA direto no alias da
    * grade: SQLEXEC sobre o alias ligado a um Grid FECHA e RECRIA o alias,
    * zerando RecordSource/ControlSource/ColumnCount (a grade vira um
    * retangulo branco pelo resto da vida do form). Quem recarrega o alias
    * da grade eh o Form, com ZAP + APPEND FROM DBF() (regra #21a / #35).
    *
    * PUBLIC (sem PROTECTED): chamado pelo Form (regra #51).
    *==========================================================================
    PROCEDURE CarregarSenhasPendentes()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        TRY
            IF USED("cursor_4c_SenhasTemp")
                USE IN cursor_4c_SenhasTemp
            ENDIF

            IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
                THIS.this_cMensagemErro = "Sem conex" + CHR(227) + "o com o " + ;
                    "Servidor de Banco de Dados."
            ELSE
                loc_cSQL = "SELECT * FROM SigPrSnd WHERE empdopnums = " + EscaparSQL("")

                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_SenhasTemp")

                IF loc_nResultado >= 0
                    loc_lSucesso = .T.
                ELSE
                    MostrarErro("Erro ao consultar as senhas pendentes:" + CHR(13) + ;
                        CapturarErroSQL(), "Erro SQL")
                ENDIF
            ENDIF

        CATCH TO loc_oErro
            MostrarErro("Erro ao carregar as senhas pendentes:" + CHR(13) + ;
                loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo), ;
                "SigPrSndBO.CarregarSenhasPendentes")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC


    *==========================================================================
    * ContarSenhasIguais - quantas linhas de SigPrSnd ja usam esta senha.
    *
    * Equivalente do ChkRegister do fSqlConector legado, chamado dentro do laco
    * de geracao do Click de btnGerSen:
    *     If ThisForm.poDataMgr.ChkRegister('SigPrSnd','SenhaDs',_Inicio)
    *         _Inicio = 0
    *     Endif
    * ChkRegister NAO existe no BusinessBase - a forma canonica do projeto eh
    * SELECT COUNT(*) + NVL(...) > 0.
    *
    * Ret: >= 0 = quantidade encontrada; -1 = NAO FOI POSSIVEL CONSULTAR.
    * O -1 eh indispensavel: devolver 0 ("nao existe") numa consulta que falhou
    * faria o gerador aceitar uma senha possivelmente DUPLICADA, e devolver um
    * valor positivo faria o laco girar para sempre. Quem chama distingue os
    * tres casos.
    *
    * Preserva o alias corrente: o gerador roda com cursor_4c_SenhasTemp
    * selecionado e perder essa selecao embaralharia o laco de fora.
    *
    * PUBLIC (sem PROTECTED): chamado pelo Form/harness (regra #51).
    *==========================================================================
    PROCEDURE ContarSenhasIguais(par_cSenha)
        LOCAL loc_cSQL, loc_nResultado, loc_nTotal, loc_cAliasAnt, loc_oErro
        loc_nTotal    = -1
        loc_cAliasAnt = ALIAS()

        TRY
            DO CASE
                CASE VARTYPE(par_cSenha) != "C" OR EMPTY(ALLTRIM(par_cSenha))
                    THIS.this_cMensagemErro = "Senha inv" + CHR(225) + "lida para confer" + ;
                        CHR(234) + "ncia de duplicidade."

                CASE TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
                    THIS.this_cMensagemErro = "Sem conex" + CHR(227) + "o com o Servidor " + ;
                        "de Banco de Dados."

                OTHERWISE
                    IF USED("cursor_4c_ChkSenha")
                        USE IN cursor_4c_ChkSenha
                    ENDIF

                    loc_cSQL = "SELECT COUNT(*) AS nExiste FROM SigPrSnd WHERE senhads = " + ;
                        EscaparSQL(par_cSenha)

                    loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ChkSenha")

                    IF loc_nResultado >= 0 AND USED("cursor_4c_ChkSenha")
                        SELECT cursor_4c_ChkSenha
                        GO TOP
                        IF EOF("cursor_4c_ChkSenha")
                            loc_nTotal = 0
                        ELSE
                            loc_nTotal = NVL(cursor_4c_ChkSenha.nExiste, 0)
                        ENDIF
                    ELSE
                        THIS.this_cMensagemErro = CapturarErroSQL()
                    ENDIF

                    IF USED("cursor_4c_ChkSenha")
                        USE IN cursor_4c_ChkSenha
                    ENDIF
            ENDCASE
        CATCH TO loc_oErro
            MostrarErro("Erro ao conferir a senha gerada:" + CHR(13) + ;
                loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo), ;
                "SigPrSndBO.ContarSenhasIguais")
            loc_nTotal = -1
        ENDTRY

        IF !EMPTY(loc_cAliasAnt) AND USED(loc_cAliasAnt)
            SELECT (loc_cAliasAnt)
        ENDIF

        RETURN loc_nTotal
    ENDPROC

    *==========================================================================
    * GerarSenhaUnica - devolve UMA senha de 6 digitos que ainda nao existe,
    * nem em SigPrSnd nem no lote que esta sendo montado. "" = falhou.
    *
    * TRANSCRICAO do laco do Click de btnGerSen:
    *     _Inicio = 0
    *     Do While _Inicio = 0
    *         _Inicio = fKeyGen()
    *         If ThisForm.poDataMgr.ChkRegister('SigPrSnd','SenhaDs',_Inicio)
    *             _Inicio =  0
    *         Endif
    *     Enddo
    *     lcSenha = Str(_Inicio,6)
    *
    * fKeyGen() NAO FOI PORTADA e o fonte dela nao existe no acervo (so as
    * chamadas, em 3 SCX). Chamar o nome nu seria o defeito da regra #13 (VFP9
    * procuraria fkeygen.prg em disco e estouraria em RUNTIME, ao clicar o
    * botao). NAO cabe wrapper em utils\ como na regra #27: aquilo existe para
    * p-code COMPILADO de VCX, que nao da para editar - aqui o unico chamador
    * eh este .prg, entao a geracao mora no BO, que eh a camada certa.
    *
    * O CONTRATO de fKeyGen esta determinado pelo proprio call site: o legado
    * NAO confia no valor devolvido (confere duplicidade a cada volta e repete),
    * ou seja a funcao eh um gerador de CANDIDATO, nao de chave unica - um
    * contador sequencial (fGerUniqueKey) nao precisaria do laco. Por isso aqui
    * eh sorteio + a MESMA conferencia do legado.
    *
    * FAIXA 100000..999999 - decisao DELIBERADA, registrada porque eh o unico
    * ponto em que nao ha dump para transcrever: Str(n, 6) sobre a coluna
    * senhads char(6) so ocupa os 6 caracteres sem sobra de espaco quando n tem
    * 6 digitos. Com n menor, STR alinha a DIREITA e a senha gravada sairia com
    * espacos na frente ("   123"), que eh o que o usuario leria na grade e
    * levaria para a planilha do btnExcel.
    *
    * TETO DE TENTATIVAS - segundo desvio deliberado (ver a declaracao de
    * this_nMaxTentativasSenha, no topo da classe).
    *
    * Par: par_cCursorLote - alias (opcional) do lote em montagem. As senhas ja
    *      sorteadas nesta mesma rodada AINDA NAO ESTAO em SigPrSnd, entao a
    *      consulta do legado nao as veria e duas linhas do mesmo lote poderiam
    *      sair iguais.
    *
    * PUBLIC (sem PROTECTED): chamado pelo Form/harness (regra #51).
    *==========================================================================
    PROCEDURE GerarSenhaUnica(par_cCursorLote)
        LOCAL loc_cSenha, loc_nCandidato, loc_nTentativa, loc_nExiste
        LOCAL loc_lAchou, loc_lNoLote, loc_cAliasAnt, loc_oErro
        loc_cSenha    = ""
        loc_lAchou    = .F.
        loc_cAliasAnt = ALIAS()

        TRY
            IF !THIS.this_lRandSemeado
                *-- RAND(-1) semeia pelo relogio do sistema (uma vez por BO)
                = RAND(-1)
                THIS.this_lRandSemeado = .T.
            ENDIF

            loc_nTentativa = 0

            DO WHILE !loc_lAchou AND loc_nTentativa < THIS.this_nMaxTentativasSenha
                loc_nTentativa = loc_nTentativa + 1

                loc_nCandidato = INT(RAND() * 900000) + 100000
                loc_cSenha     = STR(loc_nCandidato, 6)

                *-- Duplicidade DENTRO do lote em montagem
                loc_lNoLote = .F.
                IF VARTYPE(par_cCursorLote) = "C" AND !EMPTY(par_cCursorLote)
                    IF USED(par_cCursorLote)
                        SELECT (par_cCursorLote)
                        LOCATE FOR ALLTRIM(senhads) == ALLTRIM(loc_cSenha)
                        loc_lNoLote = FOUND()
                    ENDIF
                ENDIF

                IF loc_lNoLote
                    loc_cSenha = ""
                ELSE
                    *-- Duplicidade em SigPrSnd (o ChkRegister do legado)
                    loc_nExiste = THIS.ContarSenhasIguais(loc_cSenha)

                    DO CASE
                        CASE loc_nExiste < 0
                            *-- Consulta falhou: abortar em vez de girar o laco
                            *-- ou aceitar senha possivelmente duplicada
                            loc_cSenha     = ""
                            loc_nTentativa = THIS.this_nMaxTentativasSenha
                        CASE loc_nExiste = 0
                            loc_lAchou = .T.
                        OTHERWISE
                            loc_cSenha = ""
                    ENDCASE
                ENDIF
            ENDDO

            IF !loc_lAchou
                loc_cSenha = ""
                IF EMPTY(ALLTRIM(NVL(THIS.this_cMensagemErro, "")))
                    THIS.this_cMensagemErro = "N" + CHR(227) + "o foi poss" + CHR(237) + ;
                        "vel obter uma senha livre dispon" + CHR(237) + "vel ap" + CHR(243) + "s " + ;
                        ALLTRIM(STR(THIS.this_nMaxTentativasSenha)) + " tentativas."
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MostrarErro("Erro ao gerar a senha:" + CHR(13) + ;
                loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo), ;
                "SigPrSndBO.GerarSenhaUnica")
            loc_cSenha = ""
        ENDTRY

        IF !EMPTY(loc_cAliasAnt) AND USED(loc_cAliasAnt)
            SELECT (loc_cAliasAnt)
        ENDIF

        RETURN loc_cSenha
    ENDPROC

    *==========================================================================
    * GerarSenhasLivres - gera par_nQtd senhas livres e as grava em SigPrSnd.
    *
    * TRANSCRICAO do corpo do Click de btnGerSen (depois do guard de campo
    * obrigatorio e da confirmacao, que moram no Form):
    *     Select crSigPrSnd / Zap
    *     ldData = Datetime()
    *     For n = 1 to lnQtd
    *         Insert Into crSigPrSnd (Usuars, Datas, Tipos) Values (Usuar, ldData, 0)
    *         <gera senha unica>
    *         Replace Senhads With lcSenha, Horas With Time(), cIdChaves With fUniqueIds()
    *     Next
    *     llOk = ThisForm.poDataMgr.Update('crSigPrSnd')
    *     If llOk / Commit() / Else / RollBack() / Endif
    *
    * O que foi transcrito LITERALMENTE, e eh facil perder:
    *   - ldData FORA do laco: as N senhas compartilham o MESMO datetime, e
    *     Time() eh por linha. Nao sao a mesma informacao.
    *   - Tipos = 0 LITERAL (senha livre), nao this_nTipos.
    *   - Usuars = o usuario logado (o PUBLIC `Usuar` do legado, que nesta
    *     arquitetura eh gc_4c_UsuarioLogado - PILAR 3).
    *   - As demais colunas vao em BRANCO/ZERO, como no legado: la o Insert Into
    *     lista so 3 colunas e o resto vem do registro em branco do AddCursor.
    *     Em especial empdopnums fica VAZIA de proposito - eh exatamente o que
    *     o Click de btnSenPend consulta para achar as senhas ainda livres, e
    *     preencher emps aqui tiraria a senha dessa lista.
    *   - Todas as 15 colunas aparecem no INSERT: 14 delas sao NOT NULL sem
    *     DEFAULT no schema e omitir qualquer uma faz o SQL Server recusar o
    *     INSERT inteiro (regra #22).
    *
    * ATOMICIDADE - o legado eh tudo-ou-nada (um TABLEUPDATE do cursor inteiro
    * + Commit/RollBack). Um par BEGIN/COMMIT em SQLEXECs separados NAO
    * reproduz isso: a conexao nasce com Transactions = 2 e @@TRANCOUNT ja vale
    * 1, entao o BEGIN so aninha o contador e o ROLLBACK depois nao desfaz
    * nada. Por isso os N INSERT vao num SQLEXEC UNICO, com SAVE TRANSACTION/
    * TRY/CATCH/THROW em T-SQL - mesmo padrao de SIGOPCCOBO.ConfirmarCorrecao
    * e ProdutoBO.CopiarProduto.
    *
    * COMMIT - como @@TRANCOUNT ja eh 1, o lote usa SAVE TRANSACTION e NAO
    * comita: quem efetiva eh o SQLCOMMIT, que eh o Commit() do legado. IF
    * ANINHADO, nunca "IF loc_lManual AND SQLCOMMIT(...)" - VFP9 nao faz
    * curto-circuito e chamaria o SQLCOMMIT de qualquer forma.
    *
    * SAIDA: as senhas gravadas ficam em cursor_4c_SenhasTemp, que eh o cursor
    * que o Form usa para repintar a grade (ZAP + APPEND FROM DBF). Se a
    * gravacao FALHAR o cursor eh DERRUBADO, para a tela nao exibir senha que
    * nao foi gravada.
    *
    * PUBLIC (sem PROTECTED): chamado pelo Form/harness (regra #51).
    *==========================================================================
    PROCEDURE GerarSenhasLivres(par_nQtd)
        LOCAL loc_nQtd, loc_nI, loc_cSenha, loc_cChave, loc_cHora, loc_cUsuario
        LOCAL loc_tData, loc_cInserts, loc_cLote, loc_cCRLF, loc_nResultado
        LOCAL loc_lSucesso, loc_lManual, loc_lLoteCompleto, loc_cNull, loc_oErro

        loc_lSucesso            = .F.
        loc_lLoteCompleto       = .F.
        loc_lManual             = .F.
        loc_cInserts            = ""
        loc_cCRLF               = CHR(13) + CHR(10)
        THIS.this_cMensagemErro = ""
        THIS.this_lErroExibido  = .F.

        TRY
            loc_nQtd = IIF(VARTYPE(par_nQtd) = "N", INT(par_nQtd), 0)

            DO CASE
                CASE loc_nQtd <= 0
                    THIS.this_cMensagemErro = "Qtde de senhas obrigat" + CHR(243) + "rio."
                    THIS.ExibirFalha("Gerar Senha")

                CASE TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
                    THIS.this_cMensagemErro = "Sem conex" + CHR(227) + "o com o Servidor " + ;
                        "de Banco de Dados."
                    THIS.ExibirFalha("Gerar Senha")

                OTHERWISE
                    loc_lManual = (SQLGETPROP(gnConnHandle, "Transactions") = 2)

                    *-- Lote em montagem. Mesma lista e mesma ORDEM de colunas
                    *-- de CriarCursorSenhas (que eh a ordem do schema), porque
                    *-- o APPEND FROM DBF() do Form casa por NOME.
                    IF USED("cursor_4c_SenhasTemp")
                        USE IN cursor_4c_SenhasTemp
                    ENDIF

                    loc_cNull = SET("NULL")
                    SET NULL ON
                    CREATE CURSOR cursor_4c_SenhasTemp ( ;
                        datas      T        NULL, ;
                        docs       N(10, 0) NULL, ;
                        horas      C(8)     NULL, ;
                        motivos    C(40)    NULL, ;
                        operas     C(20)    NULL, ;
                        senhads    C(6)     NULL, ;
                        solicits   C(10)    NULL, ;
                        usuars     C(10)    NULL, ;
                        valors     N(11, 2) NULL, ;
                        cidchaves  C(20)    NULL, ;
                        tipos      N(1, 0)  NULL, ;
                        emps       C(3)     NULL, ;
                        fpags      C(12)    NULL, ;
                        empdopnums C(29)    NULL, ;
                        perlimite  N(5, 2)  NULL)
                    IF loc_cNull = "OFF"
                        SET NULL OFF
                    ENDIF

                    *-- "Usuar" do legado; char(10) no schema
                    loc_cUsuario = LEFT(ALLTRIM(IIF(TYPE("gc_4c_UsuarioLogado") = "C", ;
                        gc_4c_UsuarioLogado, "")), 10)

                    *-- ldData = Datetime() UMA vez, FORA do laco (fiel)
                    loc_tData = DATETIME()

                    loc_lLoteCompleto = .T.

                    FOR loc_nI = 1 TO loc_nQtd
                        loc_cSenha = THIS.GerarSenhaUnica("cursor_4c_SenhasTemp")

                        IF EMPTY(loc_cSenha)
                            loc_lLoteCompleto = .F.
                            EXIT
                        ENDIF

                        loc_cChave = fUniqueIds()
                        loc_cHora  = LEFT(TIME(), 8)

                        INSERT INTO cursor_4c_SenhasTemp ( ;
                                datas, docs, horas, motivos, operas, senhads, solicits, ;
                                usuars, valors, cidchaves, tipos, emps, fpags, ;
                                empdopnums, perlimite) ;
                            VALUES ( ;
                                loc_tData, 0, loc_cHora, "", "", loc_cSenha, "", ;
                                loc_cUsuario, 0, loc_cChave, 0, "", "", ;
                                "", 0)

                        loc_cInserts = loc_cInserts + ;
                            "INSERT INTO SigPrSnd (cidchaves, datas, docs, horas, motivos, " + ;
                            "operas, senhads, solicits, usuars, valors, tipos, emps, fpags, " + ;
                            "empdopnums, perlimite) VALUES (" + ;
                            EscaparSQL(loc_cChave) + ", " + ;
                            FormatarDataSQL(loc_tData) + ", " + ;
                            FormatarNumeroSQL(0, 0) + ", " + ;
                            EscaparSQL(loc_cHora) + ", " + ;
                            EscaparSQL("") + ", " + ;
                            EscaparSQL("") + ", " + ;
                            EscaparSQL(loc_cSenha) + ", " + ;
                            EscaparSQL("") + ", " + ;
                            EscaparSQL(loc_cUsuario) + ", " + ;
                            FormatarNumeroSQL(0, 2) + ", " + ;
                            FormatarNumeroSQL(0, 0) + ", " + ;
                            EscaparSQL("") + ", " + ;
                            EscaparSQL("") + ", " + ;
                            EscaparSQL("") + ", " + ;
                            FormatarNumeroSQL(0, 2) + ");" + loc_cCRLF
                    ENDFOR

                    IF loc_lLoteCompleto AND !EMPTY(loc_cInserts)
                        loc_cLote = "SET NOCOUNT ON;" + loc_cCRLF + ;
                            "DECLARE @nivel int = @@TRANCOUNT;" + loc_cCRLF + ;
                            "IF @nivel = 0 BEGIN TRANSACTION" + loc_cCRLF + ;
                            "ELSE SAVE TRANSACTION Snd4c;" + loc_cCRLF + ;
                            "BEGIN TRY" + loc_cCRLF + ;
                            loc_cInserts + ;
                            "IF @nivel = 0 COMMIT TRANSACTION;" + loc_cCRLF + ;
                            "END TRY" + loc_cCRLF + ;
                            "BEGIN CATCH" + loc_cCRLF + ;
                            "IF @nivel = 0 BEGIN IF @@TRANCOUNT > 0 ROLLBACK TRANSACTION; END" + loc_cCRLF + ;
                            "ELSE BEGIN IF XACT_STATE() = 1 ROLLBACK TRANSACTION Snd4c; END;" + loc_cCRLF + ;
                            "THROW;" + loc_cCRLF + ;
                            "END CATCH"

                        loc_nResultado = SQLEXEC(gnConnHandle, loc_cLote)

                        IF loc_nResultado >= 0
                            loc_lSucesso = .T.
                        ELSE
                            THIS.this_cMensagemErro = CapturarErroSQL()
                        ENDIF

                        *-- LogAuditoria das linhas gravadas, ANTES do commit,
                        *-- para o registro de auditoria ser efetivado junto
                        IF loc_lSucesso
                            SELECT cursor_4c_SenhasTemp
                            GO TOP
                            SCAN
                                THIS.this_cCidchaves = ALLTRIM(NVL(cursor_4c_SenhasTemp.cidchaves, ""))
                                THIS.RegistrarAuditoria("INSERT")
                                SELECT cursor_4c_SenhasTemp
                            ENDSCAN
                        ENDIF

                        *-- Commit()/RollBack() do legado. IF ANINHADO de
                        *-- proposito: VFP9 nao faz curto-circuito em AND.
                        IF loc_lManual
                            IF loc_lSucesso
                                = SQLCOMMIT(gnConnHandle)
                            ELSE
                                = SQLROLLBACK(gnConnHandle)
                            ENDIF
                        ENDIF

                        IF !loc_lSucesso
                            *-- Nada foi gravado: derrubar o lote para a tela
                            *-- nao exibir senha inexistente no banco
                            IF USED("cursor_4c_SenhasTemp")
                                USE IN cursor_4c_SenhasTemp
                            ENDIF
                            THIS.ExibirFalha("Gerar Senha")
                        ENDIF
                    ELSE
                        IF USED("cursor_4c_SenhasTemp")
                            USE IN cursor_4c_SenhasTemp
                        ENDIF
                        IF EMPTY(ALLTRIM(NVL(THIS.this_cMensagemErro, "")))
                            THIS.this_cMensagemErro = "N" + CHR(227) + "o foi poss" + CHR(237) + ;
                                "vel gerar as " + ALLTRIM(STR(loc_nQtd)) + " senhas livres."
                        ENDIF
                        THIS.ExibirFalha("Gerar Senha")
                    ENDIF
            ENDCASE
        CATCH TO loc_oErro
            IF loc_lManual
                = SQLROLLBACK(gnConnHandle)
            ENDIF
            IF USED("cursor_4c_SenhasTemp")
                USE IN cursor_4c_SenhasTemp
            ENDIF
            MostrarErro("Erro ao gerar as senhas livres:" + CHR(13) + ;
                loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo), ;
                "SigPrSndBO.GerarSenhasLivres")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC


ENDDEFINE


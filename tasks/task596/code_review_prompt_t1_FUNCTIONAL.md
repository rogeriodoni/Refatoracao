# CODE REVIEW - PASS FUNCTIONAL: Functional Logic (metodos, eventos, containers)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Functional Logic (metodos, eventos, containers)**.

## PROBLEMAS DETECTADOS (2)
- [CONTAINER-VISIVEL] TornarControlesVisiveis() NAO filtra containers ocultos: CNT_4C_SOMBRA. Estes containers tem Visible=.F. mas serao forcados a Visible=.T. pelo metodo recursivo.
- [METODO-INEXISTENTE] Metodo 'THIS.ObterDataDoFormPai()' chamado mas NAO definido como PROCEDURE no Form nem herdado de FormBase. A LLM pode ter inventado este metodo. VERIFICAR se existe no legado e IMPLEMENTAR ou REMOVER a chamada.

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

### FORM (C:\4c\projeto\app\forms\operacionais\FormSIGPRCPR.prg) - TRECHOS RELEVANTES PARA PASS FUNCTIONAL (1037 linhas total):

*-- Linhas 7 a 82:
7: * BO:      SIGPRCPRBO (ver classes\SIGPRCPRBO.prg)
8: *
9: * Fase 3/8: Estrutura base.
10: *   - DEFINE CLASS + propriedades visuais/estado
11: *   - Init / InicializarForm / Destroy
12: *   - ConfigurarCabecalho (cnt_4c_Sombra + lbl_4c_LblSombra/lbl_4c_LblTitulo)
13: *   - TornarControlesVisiveis recursivo
14: *
15: * Fase 4/8: Grid e botoes.
16: *   - ConfigurarGrid (grd_4c_Dados - equivalente a Grade/TmpBaixa, com o
17: *     cursor_4c_Baixa pre-criado com a MESMA estrutura que
18: *     o metodo de carga de etiquetas do SIGPRCPRBO usa)
19: *   - VincularGrid (bind do cursor + larguras + headers, na ordem canonica
20: *     RecordSource -> ControlSource -> Width -> Header1.Caption)
21: *   - CarregarDados (equivalente a "PROCEDURE carregabars" do legado:
22: *     carga do cursor da grade + GO TOP + Refresh + visibilidade dos
23: *     controles conforme Eof())
24: *   - AjustarVisibilidadePorEtiquetas (Grade/Txt_Leitura/Get_Leitura/Ok/
25: *     Conferencia .Visible = Not Eof(), igual ao fim do carregabars legado)
26: *   - ConfigurarBotoes (cmd_4c_Conferencia/cmd_4c_Ok/cmd_4c_Sair) + handlers
27: *     Click (delegam a SIGPRCPRBO.ConferenciaAutomatica()/
28: *     ConfirmarConferencia())
29: *
30: * Fase 5/8: Campo Data (1a metade dos campos principais).
31: *   - ConfigurarCampoData (lbl_4c_Label2 + txt_4c_Data - equivalente a
32: *     Label2/Get_Data do legado: TextBox READONLY que so exibe a data
33: *     recebida do form pai, igual ao "Get_Data.When = Return .f." +
34: *     "ThisForm.Get_Data.Value = ThisForm.ParentForm.Get_Data.Value" do
35: *     Init legado)
36: *   - ObterDataDoFormPai (le a data do form pai por nome; o form pai -
37: *     Ordem de Producao - ainda nao foi migrado, entao cai para DATE()
38: *     se a property nao existir, para o campo nunca abrir vazio)
39: *
40: * Fase 6/8: Campo de leitura de codigo de barra (2a metade dos campos -
41: * NAO HA LOOKUP neste form: o codigo-fonte original nao tem nenhum
42: * fwbuscaext/sigacess/CreateObject de busca, entao nenhum foi inventado).
43: *   - ConfigurarCampoLeitura (lbl_4c_Txt_Leitura + txt_4c_Leitura -
44: *     equivalente a Txt_Leitura/Get_Leitura do legado: label + TextBox
45: *     NUMERICO de leitura de codigo de barra, Visible=.F. ate haver
46: *     etiqueta em aberto - AjustarVisibilidadePorEtiquetas, ja escrito na
47: *     Fase 4, controla a visibilidade dos dois)
48: *   - LeituraKeyPress/ValidarLeituraCodigoBarra (equivalente ao Valid do
49: *     Get_Leitura: delega a SIGPRCPRBO.ProcessarLeituraCodigoBarra()
50: *     (Fase 2), traduz o resultado nas MESMAS mensagens do legado,
51: *     repinta a grade e zera o campo para a proxima leitura - igual a
52: *     "This.Value = 0" no fim do Valid legado, em AMBOS os caminhos)
53: *
54: * Fase 7/8: Eventos principais dos botoes.
55: *   O template generico desta fase pede BtnIncluirClick/BtnAlterarClick/
56: *   BtnVisualizarClick/BtnExcluirClick, que sao a barra CRUD do frmcadastro.
57: *   Este legado NAO TEM CRUD: o SCX herda de "form" puro (nao de frmcadastro),
58: *   nao tem Grupo_Op, nao tem pcEscolha e tem EXATAMENTE 3 botoes - Sair, Ok e
59: *   Conferencia, todos commandbutton soltos. Criar os 4 nomes aqui seria
60: *   INVENTAR botao que o legado nao tem (viola o PILAR 1) ou gerar metodo vazio
61: *   (proibido pela regra de completude). Os eventos dos botoes que o legado
62: *   REALMENTE tem sao BtnConferenciaClick/BtnOkClick/BtnSairClick, escritos na
63: *   Fase 4 e conferidos aqui contra os Click do dump legado.
64: *
65: *   O que esta fase ACRESCENTOU, por serem eventos do legado que a traducao
66: *   anterior nao cobria:
67: *   - LeituraWhen (Get_Leitura.When = "Set Confirm On") e LeituraLostFocus
68: *     (Get_Leitura.LostFocus = "Set Confirm Off"). Sem CONFIRM ON o TextBox
69: *     de mascara "99999999999999" sai do campo sozinho no 14o digito e o ENTER
70: *     do leitor de codigo de barra vaza para outro controle.
71: *   - o caminho do Valid legado que o KeyPress nao alcanca: sair do campo com o
72: *     MOUSE (clique em Ok/Conf. Auto) tambem processa a leitura em aberto, com
73: *     guarda de reentrancia (this_lProcessandoLeitura).
74: *   - SET CONFIRM OFF no Destroy: este form nao tem DataSession = 2, entao o
75: *     SET vale para a sessao CORRENTE e nao pode vazar para a aplicacao.
76: *
77: * Fase 8/8: Consolidacao final.
78: *   O template generico desta fase pede BtnBuscarClick/BtnEncerrarClick/
79: *   BtnSalvarClick/BtnCancelarClick, FormParaBO/BOParaForm, HabilitarCampos/
80: *   LimparCampos, CarregarLista/AjustarBotoesPorModo - vocabulario do
81: *   frmcadastro (Lista+Dados, modos INCLUIR/ALTERAR/VISUALIZAR/EXCLUIR). Este
82: *   dialogo NAO tem PageFrame, NAO tem modo de edicao por registro e NAO

*-- Linhas 98 a 141:
98: *   nenhum popup - eh aberto so pelo botao de conferencia da Ordem de
99: *   Producao (form pai ainda nao migrado), via "LParameters _Form". Registrar
100: *   um item de menu aqui inventaria uma rota de navegacao que o usuario do
101: *   legado nunca teve (viola o PILAR 1). SET PROCEDURE de BO/Form nao precisa
102: *   de entrada manual: config.prg ja varre classes\*BO.prg e
103: *   forms\operacionais\Form*.prg via ADIR (secao "Dynamic Loading").
104: *
105: *   O que esta fase efetivamente corrigiu, por ser uma lacuna real na
106: *   consolidacao das fases anteriores: Init() criava o BO mas nunca
107: *   preenchia this_cEmpresa/this_cUsuario (propriedades declaradas e usadas
108: *   no carregamento de etiquetas e em ConfirmarConferencia para montar
109: *   EmpDopNums/EmpGruEsts e para Usuars de SigMvCab/SigMvItn/SigMvHst, mas
110: *   sem nenhum ponto no form que as atribuisse). Sem isso, this_cEmpresa
111: *   ficaria "" a sessao inteira: MontarEmpDopNums(THIS.this_cEmpresa, ...)
112: *   geraria uma chave com os 3 primeiros caracteres em branco (PADR(""),3))
113: *   e o SEEK/ConsultarRegistro contra SigOpEtq.EmpDopNums NUNCA casaria - a
114: *   tela abriria sempre com "Nenhuma Etiqueta Selecionada", mascarando
115: *   qualquer etiqueta real em aberto. Corrigido lendo os globais que o
116: *   startup novo ja mantem (go_4c_Sistema.cCodEmpresa/gc_4c_UsuarioLogado -
117: *   equivalentes a _EMPR/Usuar do legado, que este form nao recebe do form
118: *   pai) logo apos criar o BO.
119: *
120: * Layout OPERACIONAL flat (800x400, igual ao legado) - dialogo modal SEM
121: * PageFrame Lista/Dados do padrao CRUD.
122: *==============================================================================
123: 
124: DEFINE CLASS FormSIGPRCPR AS FormBase
125: 
126:     *--------------------------------------------------------------------------
127:     * Propriedades visuais do form
128:     *--------------------------------------------------------------------------
129:     this_cMensagemErro = ""
130:     Width        = 800
131:     Height       = 400
132:     AutoCenter   = .T.
133:     TitleBar     = 0
134:     ShowWindow   = 1
135:     ControlBox   = .F.
136:     Closable     = .F.
137:     MaxButton    = .F.
138:     MinButton    = .F.
139:     ClipControls = .F.
140:     WindowType   = 1
141:     FontName     = "Tahoma"

*-- Linhas 150 a 284:
150:     this_oParent         = .NULL.
151: 
152:     *-- Guarda de reentrancia da leitura de codigo de barra: ValidarLeitura-
153:     *-- CodigoBarra exibe MsgAviso e devolve o foco ao campo, e as duas coisas
154:     *-- disparam LostFocus de novo - sem a flag o handler se empilharia.
155:     this_lProcessandoLeitura = .F.
156: 
157:     *==========================================================================
158:     * Init - Cria o BO e guarda referencia ao form pai (equivalente ao
159:     * "LParameters _Form" + "ThisForm.ParentForm = _Form" do legado).
160:     * par_oParent : form pai (Ordem de Producao) que abriu este dialogo
161:     *==========================================================================
162:     FUNCTION Init(par_oParent)
163:         IF VARTYPE(par_oParent) = "O"
164:             THIS.this_oParent = par_oParent
165:         ENDIF
166: 
167:         THIS.this_oBusinessObject = CREATEOBJECT("SIGPRCPRBO")
168:         IF VARTYPE(THIS.this_oBusinessObject) != "O"
169:             MsgErro("Erro ao criar SIGPRCPRBO.", "Erro")
170:             RETURN .F.
171:         ENDIF
172: 
173:         *-- Equivalente a _Empr/Usuar do legado (cursores/globais Fortyus que o
174:         *-- startup novo NAO pre-carrega mais - CLAUDE.md: "_EMPR: LEGACY -
175:         *-- NUNCA usar -> go_4c_Sistema.cCodEmpresa"). Sem isto, EmpDopNums/
176:         *-- EmpGruEsts nasceriam com a empresa em branco (MontarEmpDopNums/
177:         *-- MontarEmpGruEsts nunca fariam ALLTRIM - regra de chave posicional -
178:         *-- e o SEEK contra SigOpEtq.EmpDopNums nunca casaria) e SigMvCab/
179:         *-- SigMvItn/SigMvHst gravariam Usuars em branco.
180:         THIS.this_oBusinessObject.this_cEmpresa = go_4c_Sistema.cCodEmpresa
181:         THIS.this_oBusinessObject.this_cUsuario = gc_4c_UsuarioLogado
182: 
183:         RETURN DODEFAULT()
184:     ENDFUNC
185: 
186:     *==========================================================================
187:     * InicializarForm - Monta a estrutura base do form
188:     * Deve retornar .T. em sucesso e .F. em falha (contrato do FormBase.Init)
189:     *==========================================================================
190:     PROTECTED PROCEDURE InicializarForm()
191:         LOCAL loc_lSucesso, loc_oErro, loc_lModoValidacaoOuTeste
192: 
193:         loc_lSucesso = .F.
194:         loc_lModoValidacaoOuTeste = (TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI) OR ;
195:                                     (TYPE("gb_4c_ModoTeste")   = "L" AND gb_4c_ModoTeste)
196: 
197:         TRY
198:             THIS.ConfigurarCabecalho()
199: 
200:             THIS.ConfigurarCampoData()
201: 
202:             THIS.ConfigurarCampoLeitura()
203: 
204:             THIS.ConfigurarGrid()
205: 
206:             THIS.ConfigurarBotoes()
207: 
208:             THIS.TornarControlesVisiveis(THIS)
209: 
210:             *-- Carga da grade: o Init legado chama "ThisForm.CarregaBars"
211:             *-- ANTES de vincular a Grade. Sem etiqueta em aberto o legado
212:             *-- apenas avisa e esconde Grade/leitura/Ok/Conferencia - a tela
213:             *-- CONTINUA abrindo (so com o Encerrar), por isso o retorno de
214:             *-- CarregarDados NAO entra em loc_lSucesso.
215:             *-- Em validacao de UI / modo teste nao existe form pai nem
216:             *-- conexao SQL: a carga eh pulada e o form abre so com o layout.
217:             IF !loc_lModoValidacaoOuTeste
218:                 THIS.CarregarDados()
219:             ENDIF
220: 
221:             loc_lSucesso = .T.
222: 
223:         CATCH TO loc_oErro
224:             THIS.this_cMensagemErro = loc_oErro.Message
225:             MsgErro(loc_oErro.Message + CHR(13) + ;
226:                     "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
227:                     "Procedure: " + loc_oErro.Procedure, ;
228:                     "Erro em FormSIGPRCPR.InicializarForm")
229:         ENDTRY
230: 
231:         RETURN loc_lSucesso
232:     ENDPROC
233: 
234:     *==========================================================================
235:     * ConfigurarCabecalho - Container cinza com titulo (cntSombra legado)
236:     * cnt_4c_Sombra: Top=0 Left=0 Width=800 Height=80 BackColor=RGB(100,100,100)
237:     *==========================================================================
238:     PROTECTED PROCEDURE ConfigurarCabecalho()
239:         THIS.AddObject("cnt_4c_Sombra", "Container")
240:         WITH THIS.cnt_4c_Sombra
241:             .Top         = 0
242:             .Left        = 0
243:             .Width       = THIS.Width
244:             .Height      = 80
245:             .BackStyle   = 1
246:             .BackColor   = RGB(100, 100, 100)
247:             .BorderWidth = 0
248:             .Visible     = .T.
249:         ENDWITH
250: 
251:         THIS.cnt_4c_Sombra.AddObject("lbl_4c_LblSombra", "Label")
252:         WITH THIS.cnt_4c_Sombra.lbl_4c_LblSombra
253:             .Top        = 18
254:             .Left       = 10
255:             .Width      = THIS.Width - 20
256:             .Height     = 40
257:             .FontName   = "Tahoma"
258:             .FontSize   = 16
259:             .FontBold   = .T.
260:             .ForeColor  = RGB(0, 0, 0)
261:             .BackStyle  = 0
262:             .WordWrap   = .T.
263:             .AutoSize   = .F.
264:             .Caption    = THIS.Caption
265:             .Visible    = .T.
266:         ENDWITH
267: 
268:         THIS.cnt_4c_Sombra.AddObject("lbl_4c_LblTitulo", "Label")
269:         WITH THIS.cnt_4c_Sombra.lbl_4c_LblTitulo
270:             .Top        = 17
271:             .Left       = 10
272:             .Width      = THIS.Width - 20
273:             .Height     = 46
274:             .FontName   = "Tahoma"
275:             .FontSize   = 16
276:             .FontBold   = .T.
277:             .ForeColor  = RGB(255, 255, 255)
278:             .BackStyle  = 0
279:             .WordWrap   = .T.
280:             .AutoSize   = .F.
281:             .Caption    = THIS.Caption
282:             .Visible    = .T.
283:         ENDWITH
284:     ENDPROC

*-- Linhas 290 a 333:
290:     * usuario nunca digita nela. Posicoes/propriedades EXATAS do SCX
291:     * legado (Label2/Get_Data).
292:     *==========================================================================
293:     PROTECTED PROCEDURE ConfigurarCampoData()
294:         THIS.AddObject("lbl_4c_Label2", "Label")
295:         WITH THIS.lbl_4c_Label2
296:             .Top       = 110
297:             .Left      = 133
298:             .Width     = 35
299:             .Height    = 15
300:             .AutoSize  = .F.
301:             .BackStyle = 0
302:             .FontName  = "Tahoma"
303:             .FontSize  = 8
304:             .ForeColor = RGB(90, 90, 90)
305:             .Caption   = "Data : "
306:             .Visible   = .T.
307:         ENDWITH
308: 
309:         THIS.AddObject("txt_4c_Data", "TextBox")
310:         WITH THIS.txt_4c_Data
311:             .Top               = 107
312:             .Left              = 170
313:             .Width             = 80
314:             .Height            = 23
315:             .FontName          = "Tahoma"
316:             .FontSize          = 8
317:             .Alignment         = 3
318:             .ReadOnly          = .T.
319:             .SpecialEffect     = 1
320:             .DisabledBackColor = RGB(255, 255, 255)
321:             .BorderColor       = RGB(100, 100, 100)
322:             .Value             = THIS.ObterDataDoFormPai()
323:             .Visible           = .T.
324:         ENDWITH
325:     ENDPROC
326: 
327:     *==========================================================================
328:     * ObterDataDoFormPai - Equivalente a "ThisForm.Get_Data.Value =
329:     * ThisForm.ParentForm.Get_Data.Value" do Init legado. O form pai (Ordem
330:     * de Producao) ainda nao foi migrado para a nova arquitetura; ate la,
331:     * tenta ler a data pelo nome novo (txt_4c_Data) e depois pelo nome
332:     * legado (Get_Data), e cai para DATE() se nenhum existir ou vier vazio -
333:     * o campo nunca abre em branco/invalido.

*-- Linhas 362 a 583:
362:     * leitura de codigo de barra. Posicoes/propriedades EXATAS do SCX
363:     * legado. Visible = .F. nos dois (igual ao legado - so ficam visiveis
364:     * quando ha etiqueta em aberto; ver AjustarVisibilidadePorEtiquetas,
365:     * escrito na Fase 4, e o skip em TornarControlesVisiveis abaixo).
366:     *
367:     * lbl_4c_Txt_Leitura: o SCX declara AutoSize=.T. mas NAO WordWrap - regra
368:     * do projeto (#23): AutoSize=.T. eh no-op em Label criado por AddObject,
369:     * entao usar AutoSize=.F. + Width/Height EXATOS do dump (86x15), que ja
370:     * sao o auto-size calculado pelo Form Designer legado.
371:     *
372:     * txt_4c_Leitura: InputMask="99999999999999" (14 digitos, igual ao SCX) e
373:     * .Value = 0 (NUMERICO) - o Valid legado termina com "This.Value = 0" e a
374:     * BO (SIGPRCPRBO.ProcessarLeituraCodigoBarra) exige par_nCodigoBarra
375:     * numerico, entao o campo tem de nascer numerico, nao "".
376:     *==========================================================================
377:     PROTECTED PROCEDURE ConfigurarCampoLeitura()
378:         THIS.AddObject("lbl_4c_Txt_Leitura", "Label")
379:         WITH THIS.lbl_4c_Txt_Leitura
380:             .Top       = 359
381:             .Left      = 133
382:             .Width     = 86
383:             .Height    = 15
384:             .AutoSize  = .F.
385:             .Alignment = 0
386:             .BackStyle = 0
387:             .FontName  = "Tahoma"
388:             .FontSize  = 8
389:             .ForeColor = RGB(90, 90, 90)
390:             .Caption   = "C" + CHR(243) + "digo de barra :"
391:             .Visible   = .F.
392:         ENDWITH
393: 
394:         THIS.AddObject("txt_4c_Leitura", "TextBox")
395:         WITH THIS.txt_4c_Leitura
396:             .Top         = 355
397:             .Left        = 221
398:             .Width       = 108
399:             .Height      = 23
400:             .FontName    = "Tahoma"
401:             .FontSize    = 8
402:             .InputMask   = "99999999999999"
403:             .BorderColor = RGB(100, 100, 100)
404:             .Value       = 0
405:             .Visible     = .F.
406:         ENDWITH
407:         BINDEVENT(THIS.txt_4c_Leitura, "KeyPress",  THIS, "LeituraKeyPress")
408:         BINDEVENT(THIS.txt_4c_Leitura, "When",      THIS, "LeituraWhen")
409:         BINDEVENT(THIS.txt_4c_Leitura, "KeyPress", THIS, "LeituraLostFocus")
410:     ENDPROC
411: 
412:     *==========================================================================
413:     * LeituraWhen - equivalente ao When do Get_Leitura legado, que eh
414:     * "Set Confirm On" e MAIS NADA.
415:     *
416:     * Com SET CONFIRM OFF (default do VFP9) um TextBox sai do campo SOZINHO no
417:     * instante em que a mascara enche - e aqui a mascara eh "99999999999999",
418:     * 14 digitos, exatamente o tamanho de um codigo de barra. O leitor digita
419:     * os 14 digitos e SO DEPOIS manda o ENTER: sem CONFIRM ON o campo ja saiu
420:     * no 14o digito e o ENTER solto vai para o controle que ficou com o foco.
421:     * Por isso o legado liga CONFIRM ao ENTRAR no campo e desliga ao SAIR
422:     * (LeituraLostFocus) - nao eh detalhe de estilo, eh o que faz a leitura
423:     * por scanner funcionar.
424:     *==========================================================================
425:     PROCEDURE LeituraWhen()
426:         SET CONFIRM ON
427:         RETURN .T.
428:     ENDPROC
429: 
430:     *==========================================================================
431:     * LeituraLostFocus - equivalente ao LostFocus do Get_Leitura legado
432:     * ("Set Confirm Off"), MAIS o caminho do Valid legado que o KeyPress nao
433:     * cobre.
434:     *
435:     * O Valid legado dispara ao sair do campo por QUALQUER meio, inclusive
436:     * clique do mouse em Ok/Conf. Auto. Traduzir o Valid so em KeyPress
437:     * (ENTER/TAB) perde o codigo digitado quando o usuario sai com o mouse -
438:     * ele digita a etiqueta, clica em Ok e a leitura nunca eh processada.
439:     *
440:     * O "Return 0" do Valid legado (com valor preenchido) mantem o foco no
441:     * campo: o clique em Ok eh engolido e o usuario clica de novo. Isso eh
442:     * reproduzido pelo SetFocus do fim de ValidarLeituraCodigoBarra.
443:     *
444:     * SEM chamar CarregarDados/SQLEXEC aqui (regra do projeto: LostFocus
445:     * dispara sempre e nao serve para recarga) - so o processamento da leitura
446:     * em aberto, com a guarda de reentrancia.
447:     *==========================================================================
448:     PROCEDURE LeituraLostFocus(par_nKeyCode, par_nShiftAltCtrl)
449:         SET CONFIRM OFF
450: 
451:         IF THIS.this_lProcessandoLeitura
452:             RETURN
453:         ENDIF
454: 
455:         IF VARTYPE(THIS.txt_4c_Leitura) != "O" OR THIS.txt_4c_Leitura.Value = 0
456:             RETURN
457:         ENDIF
458: 
459:         THIS.ValidarLeituraCodigoBarra()
460:     ENDPROC
461: 
462:     *==========================================================================
463:     * LeituraKeyPress - dispara a validacao em ENTER/TAB (BINDEVENT "Valid"
464:     * NAO funciona em TextBox - regra do projeto). O scanner de codigo de
465:     * barra tipicamente envia ENTER apos o codigo.
466:     *==========================================================================
467:     PROCEDURE LeituraKeyPress(par_nKeyCode, par_nShiftAltCtrl)
468:         IF INLIST(par_nKeyCode, 13, 9)
469:             THIS.ValidarLeituraCodigoBarra()
470:         ENDIF
471:     ENDPROC
472: 
473:     *==========================================================================
474:     * ValidarLeituraCodigoBarra - equivalente ao Valid do Get_Leitura legado:
475:     * delega a SIGPRCPRBO.ProcessarLeituraCodigoBarra() (Fase 2 - ja faz o
476:     * SEEK/REPLACE no cursor_4c_Baixa) e traduz o status devolvido nas
477:     * MESMAS mensagens do legado. "This.Value = 0" do legado roda em AMBOS
478:     * os caminhos (achou ou nao achou) - aqui tambem, fora do DO CASE.
479:     *==========================================================================
480:     PROCEDURE ValidarLeituraCodigoBarra()
481:         LOCAL loc_nCodigo, loc_cResultado
482: 
483:         loc_nCodigo = THIS.txt_4c_Leitura.Value
484: 
485:         IF loc_nCodigo = 0
486:             RETURN
487:         ENDIF
488: 
489:         IF VARTYPE(THIS.this_oBusinessObject) != "O"
490:             RETURN
491:         ENDIF
492: 
493:         *-- Guarda de reentrancia: o MsgAviso e o SetFocus abaixo tiram e
494:         *-- devolvem o foco, e os dois disparam LostFocus outra vez. A flag eh
495:         *-- ligada APOS os RETURN de guarda acima (nenhum RETURN entre ligar e
496:         *-- desligar, senao ela ficaria presa em .T.).
497:         THIS.this_lProcessandoLeitura = .T.
498: 
499:         loc_cResultado = THIS.this_oBusinessObject.ProcessarLeituraCodigoBarra(loc_nCodigo)
500: 
501:         DO CASE
502:             CASE loc_cResultado = "JA_LIDO"
503:                 MsgAviso("C" + CHR(243) + "digo de Barras J" + CHR(225) + " Foi Lido!!!", ;
504:                          "Aten" + CHR(231) + CHR(227) + "o")
505:             CASE loc_cResultado = "NAO_CADASTRADO"
506:                 MsgAviso("C" + CHR(243) + "digo de Barras N" + CHR(227) + "o Cadastrado!!!", ;
507:                          "Aten" + CHR(231) + CHR(227) + "o")
508:             CASE loc_cResultado = "SEM_CURSOR"
509:                 MsgAviso("Nenhuma etiqueta carregada para conferir.", ;
510:                          "Aten" + CHR(231) + CHR(227) + "o")
511:         ENDCASE
512: 
513:         *-- Popular/alterar o cursor da grade NAO repinta sozinho
514:         THIS.grd_4c_Dados.Refresh()
515: 
516:         THIS.txt_4c_Leitura.Value = 0
517: 
518:         IF THIS.Visible AND THIS.txt_4c_Leitura.Visible
519:             THIS.txt_4c_Leitura.SetFocus()
520:         ENDIF
521: 
522:         THIS.this_lProcessandoLeitura = .F.
523:     ENDPROC
524: 
525:     *==========================================================================
526:     * ConfigurarGrid - Grade legado (grd_4c_Dados): 5 colunas (CodBarra,
527:     * CPros, Dopes, Numes, QtdeLido), ligadas ao MESMO cursor que
528:     * o metodo de carga de etiquetas do SIGPRCPRBO cria (this_cCursorBaixa,
529:     * default "cursor_4c_Baixa" - equivalente a TmpBaixa do legado).
530:     *
531:     * O cursor eh pre-criado AQUI, vazio, com a estrutura EXATA da
532:     * CREATE CURSOR do BO (regra do projeto: Column.ControlSource antes do
533:     * cursor existir derruba o Init - erro176/regra #41) - sem isso o
534:     * ColumnN.ControlSource abaixo estouraria "Alias is not found" e o
535:     * CREATEOBJECT("FormSIGPRCPR") devolveria .F. antes de qualquer etiqueta
536:     * ser carregada.
537:     *
538:     * Grid.Visible = .F. (legado: Grade.Visible = .F. no SCX, so vira .T.
539:     * quando ha etiquetas em aberto - equivalente a "ThisForm.Grade.Visible
540:     * = Not Eof()" no fim do CarregaBars legado). TornarControlesVisiveis
541:     * tem de IGNORAR este controle (ver skip abaixo).
542:     *==========================================================================
543:     PROTECTED PROCEDURE ConfigurarGrid()
544:         LOCAL loc_cCursor
545: 
546:         loc_cCursor = THIS.this_oBusinessObject.this_cCursorBaixa
547: 
548:         IF USED(loc_cCursor)
549:             USE IN (loc_cCursor)
550:         ENDIF
551:         CREATE CURSOR (loc_cCursor) ;
552:             (CodBarra N(14,0), CPros C(14), Dopes C(20), Numes N(6,0), ;
553:              Qtde N(9,3), QtdeLido N(9,3), Nops N(10,0), Grupods C(10), Contads C(10))
554: 
555:         *-- Os MESMOS dois indices que o metodo de carga de etiquetas do SIGPRCPRBO
556:         *-- cria. Nao eh enfeite: o cursor placeholder tem de ser IDENTICO ao do
557:         *-- BO (campos E tags). SIGPRCPRBO.ProcessarLeituraCodigoBarra() e
558:         *-- ConferenciaAutomatica() fazem "SET ORDER TO TAG CodBarra" antes do
559:         *-- SEEK (igual ao "Set Order to CodBarra" do Valid legado) e
560:         *-- ConfirmarConferencia() usa "TAG GruConta" (o "Set Order to GruConta"
561:         *-- do Ok legado). Sem as tags aqui, o SET ORDER estoura "Table has no
562:         *-- index order set" FORA de qualquer TRY/CATCH - o usuario ve o
563:         *-- Program Error CRU do VFP no lugar do dialogo do sistema.
564:         INDEX ON CodBarra TAG CodBarra
565:         INDEX ON Grupods + Contads TAG GruConta
566: 
567:         THIS.AddObject("grd_4c_Dados", "Grid")
568:         WITH THIS.grd_4c_Dados
569:             .Top               = 140
570:             .Left              = 133
571:             .Width             = 534
572:             .Height            = 207
573:             .FontName          = "Tahoma"
574:             .FontSize          = 8
575:             .AllowHeaderSizing = .F.
576:             .AllowRowSizing    = .F.
577:             .DeleteMark        = .F.
578:             .RecordMark        = .F.
579:             .RowHeight         = 17
580:             .ScrollBars        = 2
581:             .ReadOnly          = .T.
582:             .ColumnCount       = 5
583:             .Visible           = .F.

*-- Linhas 661 a 704:
661:     * 108/108/154/61/75; regra do DynamicForeColor: azul quando QtdeLido <> 0,
662:     * que eh o "Iif( TmpBaixa.QtdeLido#0, Rgb(0,0,255), Rgb(0,0,0) )" legado).
663:     *==========================================================================
664:     PROCEDURE VincularGrid()
665:         LOCAL loc_cCursor, loc_cCorDinamica
666: 
667:         IF VARTYPE(THIS.this_oBusinessObject) != "O"
668:             RETURN .F.
669:         ENDIF
670: 
671:         loc_cCursor = THIS.this_oBusinessObject.this_cCursorBaixa
672: 
673:         IF !USED(loc_cCursor)
674:             RETURN .F.
675:         ENDIF
676: 
677:         loc_cCorDinamica = "IIF(" + loc_cCursor + ".QtdeLido <> 0, RGB(0,0,255), RGB(0,0,0))"
678: 
679:         *-- ColumnCount so eh reatribuido se estiver diferente: REDUZIR
680:         *-- ColumnCount recria os objetos de coluna e destroi configuracao.
681:         IF THIS.grd_4c_Dados.ColumnCount != 5
682:             THIS.grd_4c_Dados.ColumnCount = 5
683:         ENDIF
684: 
685:         THIS.grd_4c_Dados.RecordSource = loc_cCursor
686: 
687:         THIS.grd_4c_Dados.Column1.ControlSource = loc_cCursor + ".CodBarra"
688:         THIS.grd_4c_Dados.Column2.ControlSource = loc_cCursor + ".CPros"
689:         THIS.grd_4c_Dados.Column3.ControlSource = loc_cCursor + ".Dopes"
690:         THIS.grd_4c_Dados.Column4.ControlSource = loc_cCursor + ".Numes"
691:         THIS.grd_4c_Dados.Column5.ControlSource = loc_cCursor + ".QtdeLido"
692: 
693:         THIS.grd_4c_Dados.Column1.DynamicForeColor = loc_cCorDinamica
694:         THIS.grd_4c_Dados.Column2.DynamicForeColor = loc_cCorDinamica
695:         THIS.grd_4c_Dados.Column3.DynamicForeColor = loc_cCorDinamica
696:         THIS.grd_4c_Dados.Column4.DynamicForeColor = loc_cCorDinamica
697:         THIS.grd_4c_Dados.Column5.DynamicForeColor = loc_cCorDinamica
698: 
699:         *-- Width DEPOIS do RecordSource/ControlSource (ordem obrigatoria)
700:         THIS.grd_4c_Dados.Column1.Width = 108
701:         THIS.grd_4c_Dados.Column2.Width = 108
702:         THIS.grd_4c_Dados.Column3.Width = 154
703:         THIS.grd_4c_Dados.Column4.Width = 61
704:         THIS.grd_4c_Dados.Column5.Width = 75

*-- Linhas 714 a 1037:
714:     ENDPROC
715: 
716:     *==========================================================================
717:     * CarregarDados - Carga da grade. Equivalente a "PROCEDURE carregabars" do
718:     * legado (SIGPRCPR.SCX), chamado pelo Init legado e por todo caminho que
719:     * precise repopular a grade.
720:     *
721:     * O legado monta TmpBaixa varrendo TmpEnc -> SigOpEtq -> SigMvCab/SigCdOpe;
722:     * essa logica INTEIRA vive no metodo de carga de etiquetas do SIGPRCPRBO
723:     * (Fases 1-2), entao aqui o form so: delega a carga, RE-VINCULA a grade (o
724:     * BO recria o cursor e o binding cai - ver VincularGrid), posiciona no
725:     * primeiro registro, repinta e ajusta a visibilidade dos controles.
726:     *
727:     * Fim do carregabars legado, reproduzido fielmente:
728:     *   Select TmpBaixa / Go Top
729:     *   If Eof() / =Messagebox('Nenhuma Etiqueta Selecionada Nesta Operacao!!!', 32, '')
730:     *   ThisForm.Grade.Visible = Not Eof()   (idem Txt_Leitura/Get_Leitura/Ok/Conferencia)
731:     *   ThisForm.Get_Leitura.SetFocus
732:     *
733:     * O legado NAO aborta a tela quando nao ha etiqueta: apenas avisa e esconde
734:     * os controles de conferencia, deixando so o Encerrar. Retorna .T. quando
735:     * ha pelo menos uma etiqueta em aberto.
736:     *==========================================================================
737:     PROCEDURE CarregarDados()
738:         LOCAL loc_lTemEtiquetas, loc_cCursor, loc_oErro, loc_lAvisoExibido
739: 
740:         loc_lTemEtiquetas = .F.
741:         loc_lAvisoExibido = .F.
742: 
743:         TRY
744:             IF VARTYPE(THIS.this_oBusinessObject) = "O"
745:                 loc_cCursor = THIS.this_oBusinessObject.this_cCursorBaixa
746: 
747:                 *-- A carga pode falhar por parametro/operacao ausente. O BO
748:                 *-- deixa o motivo em this_cMensagemErro; aqui vale MsgAviso
749:                 *-- (validacao de uso, nao erro tecnico) e o fluxo segue para
750:                 *-- esconder os controles, igual ao legado.
751:                 IF !THIS.this_oBusinessObject.CarregarEtiquetasPendentes()
752:                     IF !EMPTY(THIS.this_oBusinessObject.this_cMensagemErro)
753:                         MsgAviso(THIS.this_oBusinessObject.this_cMensagemErro, ;
754:                                  "Aten" + CHR(231) + CHR(227) + "o")
755:                         loc_lAvisoExibido = .T.
756:                     ENDIF
757:                 ENDIF
758: 
759:                 *-- Re-vincula SEMPRE: a carga de etiquetas fez
760:                 *-- USE IN + CREATE CURSOR e o binding do Grid caiu.
761:                 THIS.VincularGrid()
762: 
763:                 IF USED(loc_cCursor)
764:                     SELECT (loc_cCursor)
765:                     GO TOP
766:                     loc_lTemEtiquetas = !EOF(loc_cCursor)
767:                 ENDIF
768: 
769:                 *-- Aviso do legado. Suprimido quando o BO ja explicou o
770:                 *-- motivo acima, para nao empilhar dois dialogos (o legado
771:                 *-- exibe UMA mensagem).
772:                 IF !loc_lTemEtiquetas AND !loc_lAvisoExibido
773:                     MsgAviso("Nenhuma Etiqueta Selecionada Nesta Opera" + ;
774:                              CHR(231) + CHR(227) + "o!!!", ;
775:                              "Aten" + CHR(231) + CHR(227) + "o")
776:                 ENDIF
777: 
778:                 THIS.AjustarVisibilidadePorEtiquetas(loc_lTemEtiquetas)
779: 
780:                 *-- Popular o cursor NAO repinta a grade sozinho
781:                 THIS.grd_4c_Dados.Refresh()
782: 
783:                 *-- "ThisForm.Get_Leitura.SetFocus" do legado. So com o form JA
784:                 *-- visivel: na primeira carga (dentro do InicializarForm) o
785:                 *-- form ainda nao foi exibido e SetFocus estouraria.
786:                 IF loc_lTemEtiquetas AND THIS.Visible AND ;
787:                    PEMSTATUS(THIS, "txt_4c_Leitura", 5)
788:                     IF VARTYPE(THIS.txt_4c_Leitura) = "O" AND THIS.txt_4c_Leitura.Visible
789:                         THIS.txt_4c_Leitura.SetFocus()
790:                     ENDIF
791:                 ENDIF
792:             ELSE
793:                 THIS.this_cMensagemErro = "Business Object n" + CHR(227) + ;
794:                     "o dispon" + CHR(237) + "vel para carregar as etiquetas."
795:                 MsgAviso(THIS.this_cMensagemErro, "Aten" + CHR(231) + CHR(227) + "o")
796:             ENDIF
797: 
798:         CATCH TO loc_oErro
799:             loc_lTemEtiquetas = .F.
800:             THIS.this_cMensagemErro = loc_oErro.Message
801:             MsgErro(loc_oErro.Message + CHR(13) + ;
802:                     "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
803:                     "Procedure: " + loc_oErro.Procedure, ;
804:                     "Erro em FormSIGPRCPR.CarregarDados")
805:         ENDTRY
806: 
807:         RETURN loc_lTemEtiquetas
808:     ENDPROC
809: 
810:     *==========================================================================
811:     * AjustarVisibilidadePorEtiquetas - reproduz o bloco final do carregabars
812:     * legado: Grade, Txt_Leitura, Get_Leitura, Ok e Conferencia ficam visiveis
813:     * SOMENTE quando existe etiqueta em aberto (Visible = Not Eof()). O Sair/
814:     * Encerrar permanece sempre visivel (o legado nao o esconde), para o
815:     * usuario poder fechar o dialogo mesmo sem nada a conferir.
816:     *
817:     * lbl_4c_Txt_Leitura / txt_4c_Leitura sao criados na Fase 6
818:     * (ConfigurarCampoLeitura) - o PEMSTATUS antes de tocar cada um foi
819:     * escrito aqui na Fase 4, antes deles existirem, e continua valendo.
820:     *==========================================================================
821:     PROCEDURE AjustarVisibilidadePorEtiquetas(par_lTemEtiquetas)
822:         LOCAL loc_lVisivel
823: 
824:         loc_lVisivel = par_lTemEtiquetas
825: 
826:         THIS.grd_4c_Dados.Visible = loc_lVisivel
827: 
828:         IF PEMSTATUS(THIS, "cmd_4c_Ok", 5)
829:             THIS.cmd_4c_Ok.Visible = loc_lVisivel
830:         ENDIF
831: 
832:         IF PEMSTATUS(THIS, "cmd_4c_Conferencia", 5)
833:             THIS.cmd_4c_Conferencia.Visible = loc_lVisivel
834:         ENDIF
835: 
836:         IF PEMSTATUS(THIS, "lbl_4c_Txt_Leitura", 5)
837:             THIS.lbl_4c_Txt_Leitura.Visible = loc_lVisivel
838:         ENDIF
839: 
840:         IF PEMSTATUS(THIS, "txt_4c_Leitura", 5)
841:             THIS.txt_4c_Leitura.Visible = loc_lVisivel
842:         ENDIF
843:     ENDPROC
844: 
845:     *==========================================================================
846:     * ConfigurarBotoes - 3 botoes standalone do legado (Conferencia/Ok/Sair),
847:     * mesmo padrao de dialogo OPERACIONAL do projeto (ver FormGrupo: Top=3,
848:     * Width/Height=75, Themes=.T.+DisabledPicture para icone renderizar com
849:     * Enabled=.F. - regra do projeto sobre standalone CommandButton).
850:     * Posicoes EXATAS do SCX legado: Conferencia Left=575, Ok Left=650,
851:     * Sair Left=725.
852:     *==========================================================================
853:     PROTECTED PROCEDURE ConfigurarBotoes()
854:         THIS.AddObject("cmd_4c_Conferencia", "CommandButton")
855:         WITH THIS.cmd_4c_Conferencia
856:             .Top             = 3
857:             .Left            = 575
858:             .Width           = 75
859:             .Height          = 75
860:             .Caption         = "\<Conf. Auto"
861:             .Picture         = gc_4c_CaminhoIcones + "geral_servicos_60.jpg"
862:             .DisabledPicture = gc_4c_CaminhoIcones + "geral_servicos_60.jpg"
863:             .FontName        = "Tahoma"
864:             .FontBold        = .T.
865:             .FontItalic      = .T.
866:             .FontSize        = 8
867:             .ForeColor       = RGB(90, 90, 90)
868:             .BackColor       = RGB(255, 255, 255)
869:             .Themes          = .T.
870:             .SpecialEffect   = 0
871:             .PicturePosition = 13
872:             .MousePointer    = 15
873:             .WordWrap        = .T.
874:             .AutoSize        = .F.
875:         ENDWITH
876:         BINDEVENT(THIS.cmd_4c_Conferencia, "Click", THIS, "BtnConferenciaClick")
877: 
878:         THIS.AddObject("cmd_4c_Ok", "CommandButton")
879:         WITH THIS.cmd_4c_Ok
880:             .Top             = 3
881:             .Left            = 650
882:             .Width           = 75
883:             .Height          = 75
884:             .Caption         = "\<Ok"
885:             .Picture         = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
886:             .DisabledPicture = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
887:             .FontName        = "Tahoma"
888:             .FontBold        = .T.
889:             .FontItalic      = .T.
890:             .FontSize        = 8
891:             .ForeColor       = RGB(90, 90, 90)
892:             .BackColor       = RGB(255, 255, 255)
893:             .Themes          = .T.
894:             .SpecialEffect   = 0
895:             .PicturePosition = 13
896:             .MousePointer    = 15
897:             .WordWrap        = .T.
898:             .AutoSize        = .F.
899:         ENDWITH
900:         BINDEVENT(THIS.cmd_4c_Ok, "Click", THIS, "BtnOkClick")
901: 
902:         THIS.AddObject("cmd_4c_Sair", "CommandButton")
903:         WITH THIS.cmd_4c_Sair
904:             .Top             = 3
905:             .Left            = 725
906:             .Width           = 75
907:             .Height          = 75
908:             .Caption         = "Encerrar"
909:             .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
910:             .DisabledPicture = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
911:             .Cancel          = .T.
912:             .FontName        = "Tahoma"
913:             .FontBold        = .T.
914:             .FontItalic      = .T.
915:             .FontSize        = 8
916:             .ForeColor       = RGB(90, 90, 90)
917:             .BackColor       = RGB(255, 255, 255)
918:             .Themes          = .T.
919:             .SpecialEffect   = 0
920:             .PicturePosition = 13
921:             .MousePointer    = 15
922:             .WordWrap        = .T.
923:             .AutoSize        = .F.
924:         ENDWITH
925:         BINDEVENT(THIS.cmd_4c_Sair, "Click", THIS, "BtnSairClick")
926:     ENDPROC
927: 
928:     *==========================================================================
929:     * BtnConferenciaClick - equivalente ao Click do "Conf. Auto" legado:
930:     * marca TODAS as etiquetas em aberto como conferidas (delega a
931:     * SIGPRCPRBO.ConferenciaAutomatica()) e repinta a grade (regra do
932:     * projeto: popular/alterar cursor da grade NUNCA repinta sozinho).
933:     *==========================================================================
934:     PROCEDURE BtnConferenciaClick()
935:         IF VARTYPE(THIS.this_oBusinessObject) = "O"
936:             IF THIS.this_oBusinessObject.ConferenciaAutomatica()
937:                 THIS.grd_4c_Dados.Refresh()
938:             ENDIF
939:         ENDIF
940:     ENDPROC
941: 
942:     *==========================================================================
943:     * BtnOkClick - equivalente ao Click do Ok legado: confirma com o usuario,
944:     * delega a gravacao em lote a SIGPRCPRBO.ConfirmarConferencia() e, em
945:     * sucesso, reabilita o form pai e encerra o dialogo (equivalente a
946:     * "ThisForm.ParentForm.Enabled = .t." + "ThisForm.Release" do legado).
947:     * Em falha sem exception (ex.: nenhuma etiqueta conferida), o BO deixa a
948:     * mensagem em this_cMensagemErro e o form exibe via MsgAviso.
949:     *==========================================================================
950:     PROCEDURE BtnOkClick()
951:         LOCAL loc_lSucesso
952: 
953:         IF !MsgConfirma("Confirma a Confer" + CHR(234) + "ncia das Etiquetas?", "Confirmar")
954:             IF PEMSTATUS(THIS, "txt_4c_Leitura", 5) AND VARTYPE(THIS.txt_4c_Leitura) = "O"
955:                 THIS.txt_4c_Leitura.SetFocus()
956:             ENDIF
957:             RETURN
958:         ENDIF
959: 
960:         loc_lSucesso = .F.
961:         IF VARTYPE(THIS.this_oBusinessObject) = "O"
962:             loc_lSucesso = THIS.this_oBusinessObject.ConfirmarConferencia()
963:         ENDIF
964: 
965:         IF loc_lSucesso
966:             IF VARTYPE(THIS.this_oParent) = "O"
967:                 THIS.this_oParent.Enabled = .T.
968:             ENDIF
969:             THIS.Release()
970:         ELSE
971:             IF VARTYPE(THIS.this_oBusinessObject) = "O" AND !EMPTY(THIS.this_oBusinessObject.this_cMensagemErro)
972:                 MsgAviso(THIS.this_oBusinessObject.this_cMensagemErro, "Aten" + CHR(231) + CHR(227) + "o")
973:             ENDIF
974:         ENDIF
975:     ENDPROC
976: 
977:     *==========================================================================
978:     * BtnSairClick - equivalente ao Click do Sair legado: reabilita o form
979:     * pai e encerra o dialogo SEM gravar nada.
980:     *==========================================================================
981:     PROCEDURE BtnSairClick()
982:         IF VARTYPE(THIS.this_oParent) = "O"
983:             THIS.this_oParent.Enabled = .T.
984:         ENDIF
985:         THIS.Release()
986:     ENDPROC
987: 
988:     *==========================================================================
989:     * TornarControlesVisiveis - Recursivo, aplica Visible=.T. em toda
990:     * hierarquia. Skip: grd_4c_Dados/lbl_4c_Txt_Leitura/txt_4c_Leitura ficam
991:     * Visible=.F. (legado: so aparecem quando ha etiquetas em aberto - ver
992:     * ConfigurarGrid/ConfigurarCampoLeitura e AjustarVisibilidadePorEtiquetas,
993:     * chamado por CarregarDados logo depois desta varredura).
994:     *==========================================================================
995:     PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
996:         LOCAL loc_i, loc_oControl
997: 
998:         FOR loc_i = 1 TO par_oContainer.ControlCount
999:             loc_oControl = par_oContainer.Controls(loc_i)
1000: 
1001:             IF VARTYPE(loc_oControl) = "O"
1002:                 IF INLIST(UPPER(loc_oControl.Name), "GRD_4C_DADOS", "LBL_4C_TXT_LEITURA", "TXT_4C_LEITURA")
1003:                     LOOP
1004:                 ENDIF
1005: 
1006:                 IF PEMSTATUS(loc_oControl, "Visible", 5)
1007:                     loc_oControl.Visible = .T.
1008:                 ENDIF
1009:                 IF PEMSTATUS(loc_oControl, "ControlCount", 5) AND loc_oControl.ControlCount > 0
1010:                     THIS.TornarControlesVisiveis(loc_oControl)
1011:                 ENDIF
1012:             ENDIF
1013:         ENDFOR
1014:     ENDPROC
1015: 
1016:     *==========================================================================
1017:     * Destroy - Libera referencias. DODEFAULT no fim (rebuild menu).
1018:     *==========================================================================
1019:     PROCEDURE Destroy()
1020:         *-- Rede de seguranca do SET CONFIRM ON ligado por LeituraWhen: este
1021:         *-- form NAO tem DataSession = 2, entao o SET vale para a sessao
1022:         *-- CORRENTE e ficaria ligado no resto da aplicacao se a tela fosse
1023:         *-- fechada com o foco ainda no campo de leitura (o LostFocus que o
1024:         *-- desliga nao teria rodado).
1025:         SET CONFIRM OFF
1026: 
1027:         IF VARTYPE(THIS.this_oBusinessObject) = "O" AND USED(THIS.this_oBusinessObject.this_cCursorBaixa)
1028:             USE IN (THIS.this_oBusinessObject.this_cCursorBaixa)
1029:         ENDIF
1030: 
1031:         THIS.this_oBusinessObject = .NULL.
1032:         THIS.this_oParent         = .NULL.
1033: 
1034:         DODEFAULT()
1035:     ENDPROC
1036: 
1037: ENDDEFINE


### BO (C:\4c\projeto\app\classes\SIGPRCPRBO.prg):
*==============================================================================
* SIGPRCPRBO.prg - Business Object para Conferencia e Reserva de Producao
* Origem legada: SIGPRCPR.SCX (dialogo modal chamado por um form pai de
*                Ordem de Producao - recebe ParentForm, Get_Data.Value e
*                crSigCdPac.SigKeys do form que o abre)
* Herda de: BusinessBase
*
* Este dialogo NAO eh um CRUD de registro unico: ele confere (leitura de
* codigo de barra) etiquetas de producao ainda nao confirmadas e, ao
* confirmar, GERA em lote um cabecalho SigMvCab por combinacao Grupo/Conta
* de destino, com os detalhes SigMvItn e os DOIS historicos SigMvHst (saida
* da conta de confirmacao, entrada na conta de destino), alem de mover as
* etiquetas em SigOpEtq. Por isso a "gravacao" real fica em
* ConfirmarConferencia() (equivalente ao Click do Ok legado), e nao em
* Inserir()/Atualizar() por registro - ver comentario acima desses metodos.
*
* Fase 2/8: Metodos de negocio (equivalentes a CarregaBars/Valid do
* Get_Leitura/Click do Conferencia/Click do Ok do legado), CarregarDoCursor,
* ObterChavePrimaria.
*==============================================================================
DEFINE CLASS SIGPRCPRBO AS BusinessBase

    *-- Identificacao - a "entidade" persistida por este dialogo eh o
    *-- cabecalho de movimento gerado na confirmacao (equivalente ao Salvar)
    this_cTabela      = "SigMvCab"
    this_cCampoChave  = "cidchaves"

    *-- Contexto recebido do form pai (fluxo modal legado via ParentForm)
    this_cEmpresa         = ""    && Empresa (Emps) - equivalente a go_4c_Sistema.cCodEmpresa do legado
    this_cUsuario         = ""    && Usuario logado (Usuar do legado)
    this_dDataBase        = {}    && Data (Get_Data.Value do form pai) - exibicao readonly
    this_cSigKey          = ""    && SigKeys (crSigCdPac.SigKeys do form pai/CarregarParametrosSistema)

    *-- Nome do cursor com as operacoes selecionadas no form pai (Dopps/Numps),
    *-- equivalente a TmpEnc do legado. O CALLER (form/BO chamador) deve
    *-- popular este cursor ANTES de chamar o metodo de carga de etiquetas.
    this_cCursorOperacoes = "cursor_4c_Operacoes"

    *-- Parametros do sistema (SigCdPam) usados na conferencia/reserva -
    *-- carregados por CarregarParametrosSistema()
    this_cGrupoConfirmacao   = ""    && GruConfs
    this_cContaConfirmacao   = ""    && ConConfs
    this_cDopeCitens         = ""    && DopeCitens (operacao de cite/transferencia parcial)
    this_cGrupoReserva       = ""    && GruReservs
    this_cContaReserva       = ""    && ConReservs
    this_cGrupoEstoque       = ""    && GrupoEsts
    this_cContaEstoque       = ""    && ContaEsts
    this_cDopeTransferencia  = ""    && TransfEncs (operacao do documento gerado ao confirmar)

    *-- Estado da grade de etiquetas (cursor equivalente a TmpBaixa do legado)
    this_cCursorBaixa      = "cursor_4c_Baixa"    && Nome fixo do cursor da grade
    this_lPossuiEtiquetas  = .F.                  && .T. quando ha pelo menos 1 etiqueta pendente

    *-- Leitura de codigo de barras
    this_cCodigoBarraLido  = ""

    *-- Linha CORRENTE do cursor de baixa (grid), populada por CarregarDoCursor
    *-- - espelha os campos de TmpBaixa do registro em foco na grade
    this_cCodigoBarraAtual    = ""
    this_cProdutoAtual        = ""
    this_cOperacaoAtual       = ""
    this_nNumeroAtual         = 0
    this_nQuantidadeAtual     = 0
    this_nQuantidadeLidaAtual = 0
    this_nSequenciaAtual      = 0
    this_cGrupoContaAtual     = ""    && Grupods da linha corrente
    this_cContaContaAtual     = ""    && Contads da linha corrente

    *-- Chave do ultimo documento de conferencia gerado (SigMvCab.cidchaves) -
    *-- usada por ObterChavePrimaria()/RegistrarAuditoria() ao confirmar
    this_cCidChaveGerada = ""

    *--------------------------------------------------------------------------
    * Init - Inicializa o BO
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_lSucesso = DODEFAULT()

            THIS.this_cTabela     = "SigMvCab"
            THIS.this_cCampoChave = "cidchaves"

            IF EMPTY(THIS.this_cCursorOperacoes)
                THIS.this_cCursorOperacoes = "cursor_4c_Operacoes"
            ENDIF
            IF EMPTY(THIS.this_cCursorBaixa)
                THIS.this_cCursorBaixa = "cursor_4c_Baixa"
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, ;
                "Erro em SIGPRCPRBO.Init")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * MontarEmpDopNums / MontarEmpGruEsts - chaves POSICIONAIS concatenadas.
    * NUNCA usar ALLTRIM nas partes: o padding faz parte da chave (regra do
    * projeto sobre chaves posicionais - Erro177). EmpDopNums = Emps(3) +
    * Dopes(20) + Str(Numes,6) = 29 (bate com char(29) do schema). EmpGruEsts
    * = Emp(3) + Grupo(10) + Conta(10) = 23 (bate com char(23) do schema).
    *==========================================================================
    PROTECTED PROCEDURE MontarEmpDopNums(par_cEmp, par_cDope, par_nNume)
        RETURN PADR(par_cEmp, 3) + PADR(par_cDope, 20) + STR(par_nNume, 6)
    ENDPROC

    PROTECTED PROCEDURE MontarEmpGruEsts(par_cEmp, par_cGrupo, par_cConta)
        RETURN PADR(par_cEmp, 3) + PADR(par_cGrupo, 10) + PADR(par_cConta, 10)
    ENDPROC

    *==========================================================================
    * ConsultarRegistro - helper generico equivalente ao
    * ThisForm.poDataMgr.CursorQuery(tabela, alias, campoChave, valor, campos)
    * do legado: SELECT <campos> FROM <tabela> WHERE <condicao> INTO CURSOR
    * <alias>. Fecha o cursor anterior (se existir) antes de reconsultar.
    * Devolve .T. apenas quando a consulta teve sucesso E trouxe pelo menos
    * 1 linha (equivalente ao "If Not Eof()" que cerca cada CursorQuery no
    * legado).
    *==========================================================================
    PROTECTED PROCEDURE ConsultarRegistro(par_cTabela, par_cAlias, par_cWhere, par_cCampos)
        LOCAL loc_cSQL, loc_nResultado, loc_cCampos

        IF USED(par_cAlias)
            USE IN (par_cAlias)
        ENDIF

        loc_cCampos = IIF(VARTYPE(par_cCampos) = "C" AND !EMPTY(par_cCampos), par_cCampos, "*")

        loc_cSQL = "SELECT " + loc_cCampos + " FROM " + par_cTabela + " WHERE " + par_cWhere

        loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, par_cAlias)

        RETURN (loc_nResultado >= 0) AND USED(par_cAlias) AND RECCOUNT(par_cAlias) > 0
    ENDPROC

    *==========================================================================
    * CarregarParametrosSistema - carrega os parametros de SigCdPam
    * (equivalente ao acesso direto a crSigCdPam no legado, que ja vinha
    * pre-carregado no startup do Fortyus - ver regra do projeto sobre
    * cursores globais Fortyus) e a SigKey de SigCdPac (Thisform.SigKey =
    * CrSigCdPac.SigKeys no Init legado). Chamado no inicio da
    * carga de etiquetas.
    *==========================================================================
    PROCEDURE CarregarParametrosSistema()
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        TRY
            IF THIS.ConsultarRegistro("SigCdPam", "cursor_4c_Pam", "1 = 1", ;
                    "GruConfs, ConConfs, DopeCitens, GruReservs, ConReservs, GrupoEsts, ContaEsts, TransfEncs")
                SELECT cursor_4c_Pam
                THIS.this_cGrupoConfirmacao  = TratarNulo(GruConfs, "")
                THIS.this_cContaConfirmacao  = TratarNulo(ConConfs, "")
                THIS.this_cDopeCitens        = TratarNulo(DopeCitens, "")
                THIS.this_cGrupoReserva      = TratarNulo(GruReservs, "")
                THIS.this_cContaReserva      = TratarNulo(ConReservs, "")
                THIS.this_cGrupoEstoque      = TratarNulo(GrupoEsts, "")
                THIS.this_cContaEstoque      = TratarNulo(ContaEsts, "")
                THIS.this_cDopeTransferencia = TratarNulo(TransfEncs, "")
                loc_lSucesso = .T.
            ELSE
                THIS.this_cMensagemErro = "Configura" + CHR(231) + CHR(227) + "o de Par" + CHR(226) + ;
                    "metros do Sistema N" + CHR(227) + "o Encontrada (SigCdPam)."
            ENDIF

            IF loc_lSucesso AND THIS.ConsultarRegistro("SigCdPac", "cursor_4c_Pac", "1 = 1", "SigKeys")
                THIS.this_cSigKey = TratarNulo(cursor_4c_Pac.SigKeys, "")
            ENDIF
        CATCH TO loc_oErro
            loc_lSucesso = .F.
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message + CHR(13) + "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro em CarregarParametrosSistema")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * CalcularQtdeBaixaCitacao - equivalente ao bloco "If Not
    * Empty(_DopeCit) ... EndIf" do CarregaBars legado. Quando existe uma
    * operacao de citacao (DopeCitens) e o documento gerador tambem existe
    * como movimento de citacao, aloca a quantidade da etiqueta contra as
    * linhas ainda nao baixadas (SigMvItn para produto simples - lnTipoEstos
    * = 1, SigMvIts+SigMvItn para produto com grade - lnTipoEstos 2/3/4) e
    * devolve a quantidade que foi baixada via citacao (_QtCit do legado).
    * Devolve -1 se uma escrita no SQL Server falhar (o caller deve abortar
    * o carregamento).
    *==========================================================================
    PROTECTED FUNCTION CalcularQtdeBaixaCitacao(par_cEmpos, par_cCPros, par_cCodCors, par_cCodTams, ;
            par_nNumeOs, par_nTipoEstos, par_nQtdeEtiqueta, par_dAgora)
        LOCAL loc_cChaveCite, loc_nBaixa, loc_nPendente, loc_nVal
        LOCAL loc_lBaixouTudo, loc_lPendenteMaior, loc_cSQL

        loc_nBaixa = par_nQtdeEtiqueta

        IF EMPTY(THIS.this_cDopeCitens)
            RETURN 0
        ENDIF

        loc_cChaveCite = THIS.MontarEmpDopNums(par_cEmpos, THIS.this_cDopeCitens, par_nNumeOs)

        IF !THIS.ConsultarRegistro("SigMvCab", "cursor_4c_MovCite", "EmpDopNums = " + EscaparSQL(loc_cChaveCite), "cidchaves")
            RETURN 0
        ENDIF

        IF par_nTipoEstos = 1
            IF THIS.ConsultarRegistro("SigMvItn", "cursor_4c_ItensCite", ;
                    "EmpDopNums = " + EscaparSQL(loc_cChaveCite) + " AND CPros = " + EscaparSQL(par_cCPros), ;
                    "cIdChaves, QtBaixas, Qtds")
                SELECT cursor_4c_ItensCite
                GO TOP
                SCAN WHILE loc_nBaixa > 0
                    IF (cursor_4c_ItensCite.Qtds - cursor_4c_ItensCite.QtBaixas) != 0
                        loc_nPendente = cursor_4c_ItensCite.Qtds - cursor_4c_ItensCite.QtBaixas
                        IF loc_nPendente > loc_nBaixa
                            loc_nVal   = loc_nBaixa
                            loc_nBaixa = 0
                        ELSE
                            loc_nVal   = loc_nPendente
                            loc_nBaixa = loc_nBaixa - loc_nPendente
                        ENDIF
                        loc_lBaixouTudo = (cursor_4c_ItensCite.QtBaixas + loc_nVal = cursor_4c_ItensCite.Qtds)

                        loc_cSQL = "UPDATE SigMvItn SET QtBaixas = QtBaixas + " + FormatarNumeroSQL(loc_nVal, 3) + ", " + ;
                            "ChkSubn = " + IIF(loc_lBaixouTudo, "1", "0") + ", DtAlts = " + FormatarDataSQL(par_dAgora) + " " + ;
                            "WHERE cIdChaves = " + EscaparSQL(cursor_4c_ItensCite.cIdChaves)

                        IF SQLEXEC(gnConnHandle, loc_cSQL) < 1
                            THIS.this_cMensagemErro = "Favor Reinicializar o Processo!!! (LocalEestI)" + CHR(13) + CapturarErroSQL()
                            RETURN -1
                        ENDIF
                        SQLCOMMIT(gnConnHandle)
                    ENDIF
                    SELECT cursor_4c_ItensCite
                ENDSCAN
            ENDIF
        ELSE
            IF THIS.ConsultarRegistro("SigMvIts", "cursor_4c_GradesCite", ;
                    "EmpDopNums = " + EscaparSQL(loc_cChaveCite) + ;
                    " AND CPros = " + EscaparSQL(par_cCPros) + ;
                    " AND CodCors = " + EscaparSQL(par_cCodCors) + ;
                    " AND CodTams = " + EscaparSQL(par_cCodTams), ;
                    "cIdChaves, EmpDopNums, CItens, QtBaixas, Qtds")
                SELECT cursor_4c_GradesCite
                GO TOP
                SCAN WHILE loc_nBaixa > 0
                    IF THIS.ConsultarRegistro("SigMvItn", "cursor_4c_ItenCiteItn", ;
                            "EmpDopNums = " + EscaparSQL(cursor_4c_GradesCite.EmpDopNums) + ;
                            " AND CItens = " + FormatarNumeroSQL(cursor_4c_GradesCite.CItens, 0), ;
                            "cIdChaves, QtBaixas, Qtds")

                        loc_nPendente = cursor_4c_GradesCite.Qtds - cursor_4c_GradesCite.QtBaixas
                        IF loc_nPendente != 0
                            loc_lPendenteMaior = (loc_nPendente > loc_nBaixa)
                            loc_nVal        = IIF(loc_lPendenteMaior, loc_nBaixa, loc_nPendente)
                            loc_lBaixouTudo = (cursor_4c_GradesCite.QtBaixas + loc_nVal = cursor_4c_GradesCite.Qtds)

                            loc_cSQL = "UPDATE SigMvIts SET QtBaixas = QtBaixas + " + FormatarNumeroSQL(loc_nVal, 3) + ", " + ;
                                "ChkSubn = " + IIF(loc_lBaixouTudo, "1", "0") + " " + ;
                                "WHERE cIdChaves = " + EscaparSQL(cursor_4c_GradesCite.cIdChaves)
                            IF SQLEXEC(gnConnHandle, loc_cSQL) < 1
                                THIS.this_cMensagemErro = "Favor Reinicializar o Processo!!! (LocalEstI2)" + CHR(13) + CapturarErroSQL()
                                RETURN -1
                            ENDIF
                            SQLCOMMIT(gnConnHandle)

                            loc_cSQL = "UPDATE SigMvItn SET QtBaixas = QtBaixas + " + FormatarNumeroSQL(loc_nVal, 3) + ", " + ;
                                "DtAlts = " + FormatarDataSQL(par_dAgora) + " " + ;
                                "WHERE cIdChaves = " + EscaparSQL(cursor_4c_ItenCiteItn.cIdChaves)
                            IF SQLEXEC(gnConnHandle, loc_cSQL) < 1
                                THIS.this_cMensagemErro = "Favor Reinicializar o Processo!!! (LocalEestI - CItens)" + CHR(13) + CapturarErroSQL()
                                RETURN -1
                            ENDIF
                            SQLCOMMIT(gnConnHandle)

                            loc_nBaixa = IIF(loc_lPendenteMaior, 0, loc_nBaixa - loc_nPendente)
                        ENDIF
                    ENDIF
                    SELECT cursor_4c_GradesCite
                ENDSCAN
            ENDIF
        ENDIF

        RETURN par_nQtdeEtiqueta - loc_nBaixa
    ENDFUNC

    *==========================================================================
    * Carga das etiquetas do documento - equivalente a CarregaBars() do legado.
    * Para cada operacao (Dopps/Numps) do cursor THIS.this_cCursorOperacoes
    * (equivalente a TmpEnc, populado pelo CALLER), busca as etiquetas de
    * SigOpEtq atualmente na conta de confirmacao (GruConfs/ConConfs) e
    * calcula, para cada uma, a conta de destino (reserva do parametro, do
    * cliente ou do movimento de origem) e a parcela ja baixada por citacao
    * (CalcularQtdeBaixaCitacao), inserindo 1 ou 2 linhas por etiqueta em
    * THIS.this_cCursorBaixa (equivalente a TmpBaixa).
    *
    * Nao repinta grade nem mostra mensagem de "nenhuma etiqueta" - isso e
    * responsabilidade do Form (equivalente ao final de CarregaBars que
    * mexe em Visible/SetFocus), que deve checar THIS.this_lPossuiEtiquetas
    * apos chamar este metodo.
    *==========================================================================
    PROCEDURE CarregarEtiquetasPendentes()
        LOCAL loc_lSucesso, loc_oErro, loc_lProsseguir, loc_lFalhouCarga
        LOCAL loc_cChaveDoc, loc_dAgora
        LOCAL loc_nCBars, loc_cGrupos, loc_cContas, loc_cCPros, loc_cDopeOs, loc_cEmposE
        LOCAL loc_nNumeOs, loc_nNopsE, loc_nQtds, loc_cCodCorsE, loc_cCodTamsE
        LOCAL loc_cDopesOrigem, loc_cGrupoosOrig, loc_cContaosOrig, loc_cGrupodsOrig, loc_cContadsOrig
        LOCAL loc_lGlobalOuServico, loc_cTGrupo, loc_cTConta, loc_cGrupo, loc_cConta
        LOCAL loc_nTipoEstos, loc_cCGrus, loc_cGruProds, loc_cConProds
        LOCAL loc_nQtEti, loc_nQtCit

        loc_lSucesso     = .F.
        loc_lProsseguir  = .T.
        loc_lFalhouCarga = .F.

        TRY
            IF USED(THIS.this_cCursorBaixa)
                USE IN (THIS.this_cCursorBaixa)
            ENDIF
            CREATE CURSOR (THIS.this_cCursorBaixa) ;
                (CodBarra N(14,0), CPros C(14), Dopes C(20), Numes N(6,0), ;
                 Qtde N(9,3), QtdeLido N(9,3), Nops N(10,0), Grupods C(10), Contads C(10))
            INDEX ON CodBarra TAG CodBarra
            INDEX ON Grupods + Contads TAG GruConta

            IF !THIS.CarregarParametrosSistema()
                loc_lProsseguir = .F.
            ENDIF

            IF loc_lProsseguir AND !USED(THIS.this_cCursorOperacoes)
                THIS.this_cMensagemErro = "Nenhuma opera" + CHR(231) + CHR(227) + "o selecionada para confer" + CHR(234) + "ncia."
                loc_lProsseguir = .F.
            ENDIF

            IF loc_lProsseguir
                loc_dAgora = DATETIME()

                SELECT (THIS.this_cCursorOperacoes)
                SCAN FOR !EMPTY(Dopps) AND !EMPTY(Numps)
                    loc_cChaveDoc = THIS.MontarEmpDopNums(THIS.this_cEmpresa, Dopps, Numps)

                    IF !THIS.ConsultarRegistro("SigOpEtq", "cursor_4c_Etiqueta", ;
                            "EmpDopNums = " + EscaparSQL(loc_cChaveDoc), "*")
                        SELECT (THIS.this_cCursorOperacoes)
                        LOOP
                    ENDIF

                    SELECT cursor_4c_Etiqueta
                    SCAN
                        loc_nCBars    = cursor_4c_Etiqueta.CBars
                        loc_cGrupos   = cursor_4c_Etiqueta.Grupos
                        loc_cContas   = cursor_4c_Etiqueta.Contas
                        loc_cCPros    = cursor_4c_Etiqueta.CPros
                        loc_cDopeOs   = cursor_4c_Etiqueta.DopeOs
                        loc_cEmposE   = cursor_4c_Etiqueta.Empos
                        loc_nNumeOs   = cursor_4c_Etiqueta.NumeOs
                        loc_nNopsE    = cursor_4c_Etiqueta.Nops
                        loc_nQtds     = cursor_4c_Etiqueta.Qtds
                        loc_cCodCorsE = cursor_4c_Etiqueta.CodCors
                        loc_cCodTamsE = cursor_4c_Etiqueta.CodTams

                        IF loc_cGrupos + loc_cContas != THIS.this_cGrupoConfirmacao + THIS.this_cContaConfirmacao
                            SELECT cursor_4c_Etiqueta
                            LOOP
                        ENDIF

                        IF !THIS.ConsultarRegistro("SigMvCab", "cursor_4c_MovOrigem", ;
                                "EmpDopNums = " + EscaparSQL(THIS.MontarEmpDopNums(loc_cEmposE, loc_cDopeOs, loc_nNumeOs)), "*")
                            SELECT cursor_4c_Etiqueta
                            LOOP
                        ENDIF
                        loc_cDopesOrigem = cursor_4c_MovOrigem.Dopes
                        loc_cGrupoosOrig = cursor_4c_MovOrigem.Grupoos
                        loc_cContaosOrig = cursor_4c_MovOrigem.Contaos
                        loc_cGrupodsOrig = cursor_4c_MovOrigem.Grupods
                        loc_cContadsOrig = cursor_4c_MovOrigem.Contads

                        loc_lGlobalOuServico = .F.
                        IF THIS.ConsultarRegistro("SigCdOpe", "cursor_4c_TipoOper", ;
                                "Dopes = " + EscaparSQL(loc_cDopesOrigem), "Globalizas, Servicos")
                            loc_lGlobalOuServico = (cursor_4c_TipoOper.Globalizas = 1 OR cursor_4c_TipoOper.Servicos = 1)
                        ENDIF

                        IF loc_lGlobalOuServico
                            loc_cTGrupo = loc_cGrupoosOrig
                            loc_cTConta = loc_cContaosOrig
                        ELSE
                            loc_cTGrupo = loc_cGrupodsOrig
                            loc_cTConta = loc_cContadsOrig
                        ENDIF

                        loc_cGrupo = IIF(EMPTY(THIS.this_cGrupoReserva), loc_cTGrupo, THIS.this_cGrupoReserva)
                        loc_cConta = IIF(EMPTY(THIS.this_cContaReserva), loc_cTConta, THIS.this_cContaReserva)

                        loc_nTipoEstos = 1
                        IF THIS.ConsultarRegistro("SigCdPro", "cursor_4c_Produto", "CPros = " + EscaparSQL(loc_cCPros), "CGrus")
                            loc_cCGrus = cursor_4c_Produto.CGrus
                            IF THIS.ConsultarRegistro("SigCdGrp", "cursor_4c_Grupo", "CGrus = " + EscaparSQL(loc_cCGrus), "TipoEstos")
                                loc_nTipoEstos = IIF(INLIST(cursor_4c_Grupo.TipoEstos, 2, 3, 4), cursor_4c_Grupo.TipoEstos, 1)
                            ENDIF
                        ENDIF

                        IF THIS.ConsultarRegistro("SigCdCli", "cursor_4c_Cliente", "IClis = " + EscaparSQL(loc_cTConta), "GruProds, ConProds")
                            loc_cGruProds = TratarNulo(cursor_4c_Cliente.GruProds, "")
                            loc_cConProds = TratarNulo(cursor_4c_Cliente.ConProds, "")
                        ELSE
                            loc_cGruProds = ""
                            loc_cConProds = ""
                        ENDIF

                        loc_nQtCit = THIS.CalcularQtdeBaixaCitacao(loc_cEmposE, loc_cCPros, loc_cCodCorsE, loc_cCodTamsE, ;
                                        loc_nNumeOs, loc_nTipoEstos, loc_nQtds, loc_dAgora)

                        IF loc_nQtCit < 0
                            THIS.this_cMensagemErro = "Falha ao processar baixa de cita" + CHR(231) + CHR(227) + ;
                                "o para a etiqueta " + TRANSFORM(loc_nCBars) + "."
                            loc_lFalhouCarga = .T.
                            SELECT cursor_4c_Etiqueta
                            EXIT
                        ENDIF

                        loc_nQtEti = loc_nQtds - loc_nQtCit

                        loc_cGrupo = IIF(EMPTY(loc_cGruProds), loc_cGrupo, loc_cGruProds)
                        loc_cConta = IIF(EMPTY(loc_cConProds), loc_cConta, loc_cConProds)

                        IF loc_nQtEti != 0
                            INSERT INTO (THIS.this_cCursorBaixa) (CodBarra, CPros, Dopes, Numes, Qtde, QtdeLido, Nops, Grupods, Contads) ;
                                VALUES (loc_nCBars, loc_cCPros, loc_cDopeOs, loc_nNumeOs, loc_nQtEti, 0, loc_nNopsE, loc_cGrupo, loc_cConta)
                        ENDIF

                        IF loc_nQtCit != 0
                            INSERT INTO (THIS.this_cCursorBaixa) (CodBarra, CPros, Dopes, Numes, Qtde, QtdeLido, Nops, Grupods, Contads) ;
                                VALUES (loc_nCBars, loc_cCPros, loc_cDopeOs, loc_nNumeOs, loc_nQtCit, 0, loc_nNopsE, ;
                                        THIS.this_cGrupoEstoque, THIS.this_cContaEstoque)
                        ENDIF

                        SELECT cursor_4c_Etiqueta
                    ENDSCAN

                    SELECT (THIS.this_cCursorOperacoes)

                    IF loc_lFalhouCarga
                        EXIT
                    ENDIF
                ENDSCAN

                THIS.this_lPossuiEtiquetas = (RECCOUNT(THIS.this_cCursorBaixa) > 0)
            ENDIF
        CATCH TO loc_oErro
            loc_lFalhouCarga = .T.
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message + CHR(13) + "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro ao carregar etiquetas pendentes")
        ENDTRY

        loc_lSucesso = loc_lProsseguir AND !loc_lFalhouCarga

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * ProcessarLeituraCodigoBarra - equivalente ao Valid do Get_Leitura.
    * Recebe o codigo de barra digitado/lido e devolve um status para o
    * Form decidir a mensagem/refresh (o dialogo MsgAviso e o Refresh() do
    * Grid sao responsabilidade da UI, nao do BO):
    *   "VAZIO"          - nada foi digitado (o legado nao faz nada)
    *   "SEM_CURSOR"     - a carga de etiquetas ainda nao rodou
    *   "LIDO"           - encontrou a etiqueta e marcou QtdeLido = Qtde
    *   "JA_LIDO"        - encontrou a etiqueta mas ja estava conferida
    *   "NAO_CADASTRADO" - codigo de barra nao existe no cursor de baixa
    *==========================================================================
    FUNCTION ProcessarLeituraCodigoBarra(par_nCodigoBarra)
        LOCAL loc_cResultado

        loc_cResultado = "VAZIO"

        IF VARTYPE(par_nCodigoBarra) != "N" OR par_nCodigoBarra = 0
            RETURN loc_cResultado
        ENDIF

        THIS.this_cCodigoBarraLido = TRANSFORM(par_nCodigoBarra)

        IF !USED(THIS.this_cCursorBaixa)
            RETURN "SEM_CURSOR"
        ENDIF

        SELECT (THIS.this_cCursorBaixa)
        SET ORDER TO TAG CodBarra

        IF SEEK(par_nCodigoBarra)
            IF EVALUATE(THIS.this_cCursorBaixa + ".QtdeLido") = 0
                REPLACE QtdeLido WITH Qtde IN (THIS.this_cCursorBaixa)
                loc_cResultado = "LIDO"
            ELSE
                loc_cResultado = "JA_LIDO"
            ENDIF
        ELSE
            loc_cResultado = "NAO_CADASTRADO"
        ENDIF

        RETURN loc_cResultado
    ENDFUNC

    *==========================================================================
    * ConferenciaAutomatica - equivalente ao Click do botao "Conf. Auto"
    * (Conferencia): marca TODAS as etiquetas em aberto como conferidas.
    *==========================================================================
    PROCEDURE ConferenciaAutomatica()
        IF !USED(THIS.this_cCursorBaixa)
            RETURN .F.
        ENDIF

        SELECT (THIS.this_cCursorBaixa)
        SET ORDER TO TAG CodBarra
        REPLACE ALL QtdeLido WITH Qtde IN (THIS.this_cCursorBaixa)

        RETURN .T.
    ENDPROC

    *==========================================================================
    * CarregarDoCursor - mapeia a linha CORRENTE de THIS.this_cCursorBaixa
    * (equivalente a TmpBaixa) para as properties this_*Atual, usadas pelo
    * Form para exibir/realcar a linha em foco na grade.
    *==========================================================================
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        IF VARTYPE(par_cAliasCursor) = "C" AND !EMPTY(par_cAliasCursor) AND USED(par_cAliasCursor)
            SELECT (par_cAliasCursor)

            THIS.this_cCodigoBarraAtual    = TRANSFORM(TratarNulo(CodBarra, 0))
            THIS.this_cProdutoAtual        = TratarNulo(CPros, "")
            THIS.this_cOperacaoAtual       = TratarNulo(Dopes, "")
            THIS.this_nNumeroAtual         = TratarNulo(Numes, 0)
            THIS.this_nQuantidadeAtual     = TratarNulo(Qtde, 0)
            THIS.this_nQuantidadeLidaAtual = TratarNulo(QtdeLido, 0)
            THIS.this_nSequenciaAtual      = TratarNulo(Nops, 0)
            THIS.this_cGrupoContaAtual     = TratarNulo(Grupods, "")
            THIS.this_cContaContaAtual     = TratarNulo(Contads, "")

            loc_lSucesso = .T.
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * ObterChavePrimaria - chave do documento de confirmacao gerado por
    * ConfirmarConferencia() (SigMvCab.cidchaves). So fica preenchida DEPOIS
    * de uma confirmacao com sucesso - eh o que RegistrarAuditoria() usa.
    *==========================================================================
    PROTECTED PROCEDURE ObterChavePrimaria()
        RETURN THIS.this_cCidChaveGerada
    ENDPROC

    *==========================================================================
    * Inserir()/Atualizar()/ExecutarExclusao() - este dialogo NAO grava um
    * registro por vez: a "gravacao" real (equivalente ao Click do Ok
    * legado) e uma confirmacao em LOTE que cria 1 cabecalho SigMvCab por
    * combinacao Grupods/Contads presente no cursor de etiquetas conferidas,
    * mais os detalhes SigMvItn/SigMvHst e o reposicionamento das etiquetas
    * em SigOpEtq - por isso vive em ConfirmarConferencia(), que chama
    * THIS.RegistrarAuditoria() ao final com sucesso. O comportamento padrao
    * herdado de BusinessBase (recusar Inserir/Atualizar/ExecutarExclusao
    * isolados) ja eh o correto para este dialogo.
    *==========================================================================

    *==========================================================================
    * ConfirmarConferencia - equivalente ao Click do Ok. Para cada
    * combinacao Grupods/Contads com QtdeLido <> 0 no cursor de baixa, gera
    * 1 cabecalho SigMvCab (documento TransfEncs), e para cada etiqueta
    * conferida daquele grupo/conta grava o detalhe SigMvItn e os 2
    * historicos SigMvHst (S = saida da conta de confirmacao, E = entrada
    * na conta de destino), recalculando custo/posicao (fRecalculaP/
    * fRecalculaC) e movendo a etiqueta em SigOpEtq para o grupo/conta de
    * destino. Tudo dentro de uma unica transacao manual (Transactions=2
    * neste ambiente): falha em qualquer passo faz SQLROLLBACK, sucesso
    * completo faz SQLCOMMIT + RegistrarAuditoria.
    *==========================================================================
    FUNCTION ConfirmarConferencia()
        LOCAL loc_lSucesso, loc_oErro, loc_lFalhou, loc_lProsseguir
        LOCAL loc_cDope, loc_nNume, loc_cChaveCab, loc_cGrupoCab, loc_cContaCab
        LOCAL loc_nItem, loc_cSQL, loc_dAgora, loc_cCidC, loc_nSeq, loc_cCidCE, loc_nSeqE
        LOCAL loc_cCunis, loc_cDpros, loc_cCodCors, loc_cCodTams, loc_cEmpos
        LOCAL loc_nCodBarraLin, loc_cCProsLin, loc_nQtdeLidaLin

        loc_lSucesso    = .F.
        loc_lFalhou     = .F.
        loc_lProsseguir = .T.

        IF !USED(THIS.this_cCursorBaixa) OR RECCOUNT(THIS.this_cCursorBaixa) = 0
            THIS.this_cMensagemErro = "N" + CHR(227) + "o h" + CHR(225) + " etiquetas carregadas para confirmar."
            RETURN .F.
        ENDIF

        TRY
            loc_dAgora = DATETIME()
            loc_cDope  = THIS.this_cDopeTransferencia

            IF USED("cursor_4c_ConfCabec")
                USE IN cursor_4c_ConfCabec
            ENDIF
            SELECT DISTINCT Grupods, Contads ;
                FROM (THIS.this_cCursorBaixa) ;
                WHERE QtdeLido != 0 ;
                INTO CURSOR cursor_4c_ConfCabec READWRITE

            IF RECCOUNT("cursor_4c_ConfCabec") = 0
                THIS.this_cMensagemErro = "Nenhuma etiqueta foi conferida - realize a leitura antes de confirmar."
                loc_lProsseguir = .F.
            ENDIF

            IF loc_lProsseguir
                SELECT cursor_4c_ConfCabec
                SCAN
                    loc_cGrupoCab = cursor_4c_ConfCabec.Grupods
                    loc_cContaCab = cursor_4c_ConfCabec.Contads

                    loc_nNume     = fGerUniqueKey(THIS.this_cEmpresa + loc_cDope)
                    loc_cChaveCab = THIS.MontarEmpDopNums(THIS.this_cEmpresa, loc_cDope, loc_nNume)

                    loc_cSQL = "INSERT INTO SigMvCab (Emps, Dopes, Numes, MascNum, Datas, Datars, Usuars, " + ;
                        "Grupoos, Contaos, Grupods, Contads, EmpDopNums, cidchaves, DtAlts, EmpGopNums) VALUES (" + ;
                        EscaparSQL(THIS.this_cEmpresa) + ", " + EscaparSQL(loc_cDope) + ", " + FormatarNumeroSQL(loc_nNume, 0) + ", " + ;
                        EscaparSQL(ALLTRIM(fGerMascara(loc_nNume))) + ", " + FormatarDataSQL(loc_dAgora) + ", " + FormatarDataSQL(loc_dAgora) + ", " + ;
                        EscaparSQL(THIS.this_cUsuario) + ", " + EscaparSQL(THIS.this_cGrupoConfirmacao) + ", " + EscaparSQL(THIS.this_cContaConfirmacao) + ", " + ;
                        EscaparSQL(loc_cGrupoCab) + ", " + EscaparSQL(loc_cContaCab) + ", " + ;
                        EscaparSQL(loc_cChaveCab) + ", " + EscaparSQL(fUniqueIds()) + ", " + FormatarDataSQL(loc_dAgora) + ", " + ;
                        EscaparSQL(THIS.MontarEmpDopNums(THIS.this_cEmpresa, "", 0)) + ")"

                    IF SQLEXEC(gnConnHandle, loc_cSQL) < 1
                        THIS.this_cMensagemErro = "Favor Reinicializar o Processo!!! (SigMvCab)" + CHR(13) + CapturarErroSQL()
                        loc_lFalhou = .T.
                        SELECT cursor_4c_ConfCabec
                        EXIT
                    ENDIF

                    THIS.this_cCidChaveGerada = loc_cChaveCab

                    loc_nItem = 0
                    SELECT (THIS.this_cCursorBaixa)
                    SCAN FOR Grupods + Contads == loc_cGrupoCab + loc_cContaCab AND QtdeLido != 0
                        loc_nItem        = loc_nItem + 1
                        loc_nCodBarraLin = CodBarra
                        loc_cCProsLin    = CPros
                        loc_nQtdeLidaLin = QtdeLido

                        loc_cCunis = ""
                        loc_cDpros = ""
                        IF THIS.ConsultarRegistro("SigCdPro", "cursor_4c_ProdutoConf", "CPros = " + EscaparSQL(loc_cCProsLin), "Cunis, Dpros")
                            loc_cCunis = TratarNulo(cursor_4c_ProdutoConf.Cunis, "")
                            loc_cDpros = TratarNulo(cursor_4c_ProdutoConf.Dpros, "")
                        ENDIF

                        loc_cCodCors = ""
                        loc_cCodTams = ""
                        loc_cEmpos   = ""
                        IF THIS.ConsultarRegistro("SigOpEtq", "cursor_4c_EtiquetaConf", ;
                                "CBars = " + FormatarNumeroSQL(loc_nCodBarraLin, 0), "CodCors, CodTams, Empos")
                            loc_cCodCors = TratarNulo(cursor_4c_EtiquetaConf.CodCors, "")
                            loc_cCodTams = TratarNulo(cursor_4c_EtiquetaConf.CodTams, "")
                            loc_cEmpos   = TratarNulo(cursor_4c_EtiquetaConf.Empos, "")
                        ENDIF

                        loc_cSQL = "INSERT INTO SigMvItn (CItens, Emps, Dopes, Numes, CPros, Qtds, Cunis, DPros, Opers, " + ;
                            "CodBarras, EmpDopNums, cIdChaves, DtAlts) VALUES (" + ;
                            FormatarNumeroSQL(loc_nItem, 0) + ", " + EscaparSQL(THIS.this_cEmpresa) + ", " + EscaparSQL(loc_cDope) + ", " + ;
                            FormatarNumeroSQL(loc_nNume, 0) + ", " + EscaparSQL(loc_cCProsLin) + ", " + ;
                            FormatarNumeroSQL(loc_nQtdeLidaLin, 3) + ", " + EscaparSQL(loc_cCunis) + ", " + ;
                            EscaparSQL(loc_cDpros) + ", " + EscaparSQL("S") + ", " + ;
                            FormatarNumeroSQL(loc_nCodBarraLin, 0) + ", " + ;
                            EscaparSQL(loc_cChaveCab) + ", " + EscaparSQL(fUniqueIds()) + ", " + FormatarDataSQL(loc_dAgora) + ")"

                        IF SQLEXEC(gnConnHandle, loc_cSQL) < 1
                            THIS.this_cMensagemErro = "Favor Reinicializar o Processo!!! (SigMvItn)" + CHR(13) + CapturarErroSQL()
                            loc_lFalhou = .T.
                            SELECT (THIS.this_cCursorBaixa)
                            EXIT
                        ENDIF

                        loc_nSeq  = fGerUniqueKey(DTOS(DATE()))
                        loc_cCidC = DTOS(DATE()) + "S" + TRANSFORM(loc_nSeq, "@L 999999") + THIS.this_cSigKey

                        loc_cSQL = "INSERT INTO SigMvHst (Usuars, Datas, Datars, Emps, Empos, Dopes, Numes, Cpros, Qtds, " + ;
                            "Opers, Grupos, Estos, CodBarras, CodCors, CodTams, cIdChaves, EmpDopNums, EmpGruEsts, " + ;
                            "OriDopNums, Seqs) VALUES (" + ;
                            EscaparSQL(THIS.this_cUsuario) + ", " + FormatarDataSQL(loc_dAgora) + ", " + FormatarDataSQL(loc_dAgora) + ", " + ;
                            EscaparSQL(loc_cEmpos) + ", " + EscaparSQL(THIS.this_cEmpresa) + ", " + EscaparSQL(loc_cDope) + ", " + ;
                            FormatarNumeroSQL(loc_nNume, 0) + ", " + EscaparSQL(loc_cCProsLin) + ", " + ;
                            FormatarNumeroSQL(loc_nQtdeLidaLin, 3) + ", " + EscaparSQL("S") + ", " + ;
                            EscaparSQL(THIS.this_cGrupoConfirmacao) + ", " + EscaparSQL(THIS.this_cContaConfirmacao) + ", " + ;
                            FormatarNumeroSQL(loc_nCodBarraLin, 0) + ", " + EscaparSQL(loc_cCodCors) + ", " + ;
                            EscaparSQL(loc_cCodTams) + ", " + EscaparSQL(loc_cCidC) + ", " + ;
                            EscaparSQL(THIS.MontarEmpDopNums(loc_cEmpos, loc_cDope, loc_nNume)) + ", " + ;
                            EscaparSQL(THIS.MontarEmpGruEsts(loc_cEmpos, THIS.this_cGrupoConfirmacao, THIS.this_cContaConfirmacao)) + ", " + ;
                            EscaparSQL(THIS.MontarEmpDopNums(loc_cEmpos, loc_cDope, loc_nNume)) + ", " + FormatarNumeroSQL(loc_nSeq, 0) + ")"

                        IF SQLEXEC(gnConnHandle, loc_cSQL) < 1
                            THIS.this_cMensagemErro = "Favor Reinicializar o Processo!!! (SigMvHst - S)" + CHR(13) + CapturarErroSQL()
                            loc_lFalhou = .T.
                            SELECT (THIS.this_cCursorBaixa)
                            EXIT
                        ENDIF

                        fRecalculaP(loc_cEmpos, THIS.this_cGrupoConfirmacao, THIS.this_cContaConfirmacao, ;
                            loc_cCProsLin, loc_dAgora, loc_cCodCors, loc_cCodTams, gnConnHandle)
                        fRecalculaC(loc_cEmpos, loc_cCProsLin, loc_dAgora, gnConnHandle)

                        loc_nSeqE  = fGerUniqueKey(DTOS(DATE()))
                        loc_cCidCE = DTOS(DATE()) + "E" + TRANSFORM(loc_nSeqE, "@L 999999") + THIS.this_cSigKey

                        loc_cSQL = "INSERT INTO SigMvHst (Usuars, Datas, Datars, Emps, Empos, Dopes, Numes, Cpros, Qtds, " + ;
                            "Opers, Grupos, Estos, CodBarras, CodCors, CodTams, CidChaves, EmpDopNums, EmpGruEsts, " + ;
                            "OriDopNums, Seqs) VALUES (" + ;
                            EscaparSQL(THIS.this_cUsuario) + ", " + FormatarDataSQL(loc_dAgora) + ", " + FormatarDataSQL(loc_dAgora) + ", " + ;
                            EscaparSQL(loc_cEmpos) + ", " + EscaparSQL(THIS.this_cEmpresa) + ", " + EscaparSQL(loc_cDope) + ", " + ;
                            FormatarNumeroSQL(loc_nNume, 0) + ", " + EscaparSQL(loc_cCProsLin) + ", " + ;
                            FormatarNumeroSQL(loc_nQtdeLidaLin, 3) + ", " + EscaparSQL("E") + ", " + ;
                            EscaparSQL(loc_cGrupoCab) + ", " + EscaparSQL(loc_cContaCab) + ", " + ;
                            FormatarNumeroSQL(loc_nCodBarraLin, 0) + ", " + EscaparSQL(loc_cCodCors) + ", " + ;
                            EscaparSQL(loc_cCodTams) + ", " + EscaparSQL(loc_cCidCE) + ", " + ;
                            EscaparSQL(THIS.MontarEmpDopNums(loc_cEmpos, loc_cDope, loc_nNume)) + ", " + ;
                            EscaparSQL(THIS.MontarEmpGruEsts(loc_cEmpos, loc_cGrupoCab, loc_cContaCab)) + ", " + ;
                            EscaparSQL(THIS.MontarEmpDopNums(loc_cEmpos, loc_cDope, loc_nNume)) + ", " + FormatarNumeroSQL(loc_nSeqE, 0) + ")"

                        IF SQLEXEC(gnConnHandle, loc_cSQL) < 1
                            THIS.this_cMensagemErro = "Favor Reinicializar o Processo!!! (SigMvHst - E)" + CHR(13) + CapturarErroSQL()
                            loc_lFalhou = .T.
                            SELECT (THIS.this_cCursorBaixa)
                            EXIT
                        ENDIF

                        fRecalculaP(loc_cEmpos, loc_cGrupoCab, loc_cContaCab, ;
                            loc_cCProsLin, loc_dAgora, loc_cCodCors, loc_cCodTams, gnConnHandle)
                        fRecalculaC(loc_cEmpos, loc_cCProsLin, loc_dAgora, gnConnHandle)

                        loc_cSQL = "UPDATE SigOpEtq SET Grupos = " + EscaparSQL(loc_cGrupoCab) + ", " + ;
                            "Contas = " + EscaparSQL(loc_cContaCab) + ", DtMovs = " + FormatarDataSQL(loc_dAgora) + " " + ;
                            "WHERE CBars = " + FormatarNumeroSQL(loc_nCodBarraLin, 0)

                        IF SQLEXEC(gnConnHandle, loc_cSQL) < 1
                            THIS.this_cMensagemErro = "Favor Reinicializar o Processo!!! (SigOpEtq)" + CHR(13) + CapturarErroSQL()
                            loc_lFalhou = .T.
                            SELECT (THIS.this_cCursorBaixa)
                            EXIT
                        ENDIF

                        SELECT (THIS.this_cCursorBaixa)
                    ENDSCAN

                    SELECT cursor_4c_ConfCabec

                    IF loc_lFalhou
                        EXIT
                    ENDIF
                ENDSCAN
            ENDIF

            IF loc_lProsseguir AND !loc_lFalhou
                IF !fRecalculaP(.T., gnConnHandle, .T.)
                    THIS.this_cMensagemErro = "Favor Reinicializar o Processo!!! (Consolida" + CHR(231) + CHR(227) + "o SigOpClP)"
                    loc_lFalhou = .T.
                ENDIF
            ENDIF

            IF loc_lProsseguir AND !loc_lFalhou
                IF !fRecalculaC(.T., .T., .F., gnConnHandle, .T.)
                    THIS.this_cMensagemErro = "Favor Reinicializar o Processo!!! (Consolida" + CHR(231) + CHR(227) + "o SigOpClC)"
                    loc_lFalhou = .T.
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            loc_lFalhou = .T.
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message + CHR(13) + "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro ao confirmar confer" + CHR(234) + "ncia")
        ENDTRY

        IF !loc_lProsseguir OR loc_lFalhou
            SQLROLLBACK(gnConnHandle)
            loc_lSucesso = .F.
        ELSE
            SQLCOMMIT(gnConnHandle)
            THIS.RegistrarAuditoria("CONFIRMAR")
            loc_lSucesso = .T.
        ENDIF

        RETURN loc_lSucesso
    ENDFUNC

ENDDEFINE


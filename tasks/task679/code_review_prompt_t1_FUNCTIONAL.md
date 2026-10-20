# CODE REVIEW - PASS FUNCTIONAL: Functional Logic (metodos, eventos, containers)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Functional Logic (metodos, eventos, containers)**.

## PROBLEMAS DETECTADOS (3)
- [METODO-INEXISTENTE] Metodo 'THIS.Width()' chamado mas NAO definido como PROCEDURE no Form nem herdado de FormBase. A LLM pode ter inventado este metodo. VERIFICAR se existe no legado e IMPLEMENTAR ou REMOVER a chamada.
- [LAYOUT-POSITION] Controle 'Container1' (parent: SigTfSup): Top original=137 vs migrado 'cnt_4c_Container1' Top=16 (diff=121px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Container1' (parent: SigTfSup): Left original=114 vs migrado 'cnt_4c_Container1' Left=7 (diff=107px, tolerancia=30px)

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

### FORM (C:\4c\projeto\app\forms\operacionais\FormSIGPRSTF.prg) - TRECHOS RELEVANTES PARA PASS FUNCTIONAL (539 linhas total):

*-- Linhas 31 a 161:
31: *                                                 AddObject estouraria
32: *                                                 "A member object with this
33: *                                                 name already exists" dentro
34: *                                                 do TRY do InicializarForm -
35: *                                                 o form abriria como .F. e o
36: *                                                 menu nao faria nada)
37: *   Label3            -> lbl_4c_Label3          (esta fase)
38: *   SENHA             -> txt_4c_SENHA           (esta fase - campo real)
39: *   Container1        -> cnt_4c_Container1      (esta fase)
40: *   Container1.Label1 -> lbl_4c_Label1          (esta fase)
41: *
42: * FASE 3 (estrutura base): o SCX nao tem PageFrame nem paginas Lista/Dados
43: * (analise.json: temGrid=false; layout.json nao declara PageFrame nenhum) -
44: * o roteiro generico "PageFrame com Page1 (Lista) e Page2 (Dados)" NAO se
45: * aplica a este legado; inventar essa UI violaria o PILAR 1 ("NUNCA inventar
46: * tabelas de lookup/estrutura que nao existem no original"). Aquela fase
47: * criou so a faixa de titulo (cntSombra), unico elemento estrutural fixo do
48: * dialogo.
49: *
50: * FASE 4 (esta fase): o roteiro generico desta fase ("Grid e botoes CRUD na
51: * Page1") tambem NAO se aplica - o SigTfSup e um dialogo modal de senha, sem
52: * lista/grade de registros e sem PageFrame (confirmado em analise.json e
53: * layout.json, que nao declaram grid nenhum). O trabalho real desta fase e
54: * completar os objetos que a Fase 3 ainda nao havia criado: o shape decorativo, o
55: * campo de senha (real + decorativo sobreposto), a legenda, o container do
56: * texto de instrucao e o CommandGroup de saida/cancelar - com os handlers
57: * SENHA.KeyPress (ENTER confirma) e CANCELA.Click (cancela), que sao os
58: * UNICOS eventos de controle que o comportamento.json lista para este form.
59: *
60: * FASE 5 (campos principais - "Parte 1" de Page2): o roteiro generico desta
61: * fase tambem NAO se aplica - o SigTfSup nao tem PageFrame nem Page2 (ver
62: * FASE 3/4 acima), entao nao ha "metade dos campos de Page2" para acrescentar.
63: * Este e um layout CAPTURA (dialogo OPERACIONAL que so coleta um valor
64: * digitado, sem ControlSource/cursor por tras - confirmado no dump: SENHA e
65: * GetSenha nao declaram ControlSource, e o unico ControlSource do form,
66: * SAIDA.ControlSource="OPSENHA", e residuo inerte do CommandGroup, sem
67: * variavel OPSENHA declarada em lugar nenhum nem leitura em metodo algum).
68: * Os DOIS campos do legado (GetSenha decorativo + SENHA real) ja foram
69: * transcritos INTEGRALMENTE na Fase 4 (txt_4c_SenhaSupervisor e txt_4c_SENHA
70: * em ConfigurarCampos acima) - acrescentar campo novo aqui seria inventar
71: * estrutura que o legado nao tem (viola o PILAR 1 e a regra "NUNCA inventar").
72: * Nenhuma alteracao funcional nesta fase; apenas este comentario, documentando
73: * a decisao (mesmo padrao das Fases 3 e 4).
74: *
75: * FASE 6 (campos restantes e lookups): o roteiro generico ("ultimos 50% dos
76: * campos + lookups com AbrirLookupXxx/FormBuscaAuxiliar") tambem NAO se aplica
77: * - comportamento.json confirma temLookup=false nos 4 metodos do legado, e
78: * nenhum deles chama fwBuscaExt/fwBuscaSel/fwBuscaInt/sigacess/Acesso*; o
79: * unico campo DIGITAVEL do dialogo (txt_4c_SENHA) nao tem PROCEDURE Valid no
80: * legado - a confirmacao (ENTER) e o proprio KeyPress (ver SECAO 3 do dump:
81: * SigTfSup.SENHA so declara KeyPress, nunca Valid). O trabalho real desta
82: * fase e so de NOMENCLATURA: o handler que reproduz esse comportamento
83: * (equivalente ao Valid do campo digitavel, ainda que o legado o combine com
84: * o KeyPress em vez de separar em evento proprio) segue a convencao canonica
85: * do projeto, Validar<Campo>, e nao o nome de evento SenhaKeyPress usado nas
86: * fases anteriores. Renomeado para ValidarSenha nesta fase (mesma logica,
87: * mesmo BINDEVENT em "KeyPress" - BINDEVENT em "Valid" nao dispara de forma
88: * confiavel em TextBox, regra #3).
89: *
90: * FASE 7 (eventos principais): o roteiro generico ("BtnIncluirClick/
91: * BtnAlterarClick/BtnVisualizarClick/BtnExcluirClick") tambem NAO se aplica -
92: * o SigTfSup nao tem CRUD nenhum (Class: form puro, sem frmcadastro, sem
93: * Grupo_Op, sem pcEscolha - ver SECAO 1/2 do dump): e um dialogo modal de
94: * senha com UM UNICO botao real (SAIDA, CommandGroup com ButtonCount=1).
95: * Inventar os 4 botoes CRUD violaria o PILAR 1 ("NUNCA inventar estrutura
96: * que o legado nao tem") - mesma excecao ja aplicada nas Fases 3/4/5/6.
97: * O trabalho real desta fase e o handler do unico botao que o legado tem:
98: * o CommandGroup.Buttons(1).Click (CANCELA, equivalente ao SigTfSup.SAIDA.
99: * CANCELA.Click do dump) PRECISA de um nome enumeravel pelo gate das fases
100: * seguintes (convencao Btn<Acao>Click, nao o nome do objeto legado) - por
101: * isso o handler da Fase 4 (CancelarClick) foi renomeado para
102: * BtnCancelarClick nesta fase (mesma logica, mesmo BINDEVENT em "Click"),
103: * e e tambem o nome que a Fase 8 exige nominalmente. ValidarSenha (o
104: * ENTER do campo de senha) permanece com o nome de validacao de campo -
105: * nao e um botao e nao faz parte dessa convencao.
106: *
107: * FASE 8 (eventos auxiliares e consolidacao final - ESTA FASE): o roteiro
108: * generico ("BtnBuscarClick/BtnEncerrarClick/BtnSalvarClick/BtnCancelarClick,
109: * FormParaBO/BOParaForm completos, HabilitarCampos, LimparCampos,
110: * CarregarLista, AjustarBotoesPorModo") e o template do padrao CRUD
111: * (frmcadastro: Page1=Lista com grid + botoes de busca/navegacao, Page2=
112: * Dados com Salvar/Cancelar) e NAO se aplica a este dialogo - mesma excecao
113: * documentada nas Fases 3 a 7, pelos MESMOS motivos (SigTfSup nao tem
114: * PageFrame, nao tem Page1/Page2, nao tem grid, nao tem tabela propria -
115: * ver analise.json: temGrid=false; comportamento.json: totalMetodos=4,
116: * metodosComSQL=0). Os 4 metodos do legado (Init, "Procedure"/RETURN
117: * (lcSenha), SAIDA.Click, SENHA.KeyPress) ja estao TODOS implementados,
118: * com paridade 100%, desde as Fases 3 a 7:
119: *   - Init                    -> InicializarForm/ConfigurarCabecalho/
120: *                                 ConfigurarCampos/ConfigurarSaida (fase 3/4)
121: *   - "Procedure" RETURN(lcSenha) -> SIGPRSTFBO.ObterSenha() (fase 1/2) -
122: *                                 devolve THIS.this_cSenha somente se
123: *                                 THIS.this_lConfirmou, reproduzindo que o
124: *                                 RETURN do legado so era alcancado apos o
125: *                                 ENTER no campo (nunca apos o Cancelar)
126: *   - SAIDA.CANCELA.Click      -> BtnCancelarClick() (fase 4/7)
127: *   - SENHA.KeyPress           -> ValidarSenha() (fase 4/6)
128: *
129: * O trabalho REAL desta fase foi extrair, desses dois handlers, os TRES
130: * hooks canonicos da arquitetura (PILAR 3) que tem referente de verdade
131: * neste dialogo - eles existiam como atribuicao solta dentro do handler, o
132: * que deixava os nomes canonicos vivos so no comentario deste cabecalho:
133: *   - FormParaBO   txt_4c_SENHA.Value -> BO.this_cSenha (caminho VIVO:
134: *                  chamado por ValidarSenha, o ENTER que confirma o dialogo)
135: *   - BOParaForm   BO.this_cSenha -> txt_4c_SENHA.Value (caminho VIVO:
136: *                  chamado por LimparCampos)
137: *   - LimparCampos equivalente ao ThisForm.Senha.Value = "" do CANCELA.Click
138: *                  legado, com FONTE UNICA no BO (BO.LimparDados zera a senha
139: *                  e a flag de confirmacao; BOParaForm reflete isso no campo)
140: *                  - chamado por BtnCancelarClick
141: * Os tres sao PROTECTED porque FormBase ja os declara assim (formbase.prg
142: * linhas 276-287) e subclasse nao alarga escopo herdado; sao chamados com
143: * THIS. de dentro da propria classe (regra #8).
144: *
145: * Os demais nomes do roteiro seguem sem referente neste legado e por isso
146: * NAO foram criados: CarregarLista (nao ha grid nem cursor de listagem),
147: * HabilitarCampos/AjustarBotoesPorModo (nao ha modo INCLUIR/ALTERAR/
148: * VISUALIZAR - e um dialogo de captura unica) e BtnBuscarClick/
149: * BtnEncerrarClick/BtnSalvarClick (o SCX tem UM unico botao, o Cancelar -
150: * CommandGroup SAIDA, ButtonCount=1, membro CANCELA com Cancel=.T.). Criar
151: * esses metodos vazios ou com logica fabricada violaria tanto o PILAR 1
152: * (inventar estrutura/fluxo que o legado nao tem) quanto a regra de "nunca
153: * gerar stub disfarcado" - a funcionalidade real do dialogo (capturar a
154: * senha do supervisor e devolve-la ao form chamador via
155: * SIGPRSTFBO.ObterSenha(), ou devolver vazio se cancelado) esta completa e
156: * testavel ponta a ponta.
157: *
158: * Gate da Fase 8: o bloco do botao de acao reprovava este form com
159: * "BtnSalvarClick (ou BtnConfirmarClick/BtnGravarClick/BtnProcessaClick)"
160: * porque Test-LegadoCliqueSoFecha nao conhecia os dois idiomas do
161: * CANCELA.Click legado - fechar com RELEASE WINDOWS (o legado nunca escreve

*-- Linhas 169 a 298:
169: *
170: * Integracao (menu.prg): SigTfSup e um dialogo PARAMETRIZADO, chamado
171: * programaticamente por outros forms (padrao DO FORM SigTfSup WITH ... /
172: * CREATEOBJECT + Show(1) + leitura do retorno), nunca pelo usuario direto
173: * via item de menu - nao ha Caption de menu no dump nem referencia a
174: * popMovimentos/popCadastros para este form. NAO adicionar item de menu
175: * (inventar entrada de menu para um dialogo auxiliar violaria o PILAR 1).
176: * config.prg ja carrega FormSIGPRSTF.prg/SIGPRSTFBO.prg automaticamente via
177: * ADIR() (carregamento dinamico - ver CLAUDE.md "config.prg - Dynamic
178: * Loading"), sem necessidade de SET PROCEDURE manual. Forms que no legado
179: * chamam "DO FORM SigTfSup WITH <8 parametros>" (Formsigproef.prg,
180: * SIGPRTFHBO.prg) sao uma tela DIFERENTE, de assinatura incompativel (8-12
181: * parametros de pinpad/SiTef, nada a ver com o dialogo simples de senha do
182: * supervisor aqui migrado) e ja foram documentados como fora de escopo
183: * nessas migracoes anteriores (acervo nao contem esse outro SigTfSup) -
184: * nao devem ser redirecionados para FormSIGPRSTF.
185: *==============================================================================
186: 
187: DEFINE CLASS FormSIGPRSTF AS FormBase
188: 
189:     *-- Propriedades visuais (fieis ao SigTfSup.scx)
190:     Height      = 200
191:     Width       = 400
192:     Caption     = "Senha de Risco"
193:     ShowWindow  = 1
194:     WindowType  = 1
195: 
196:     *-- Dialogo modal sem barra de titulo (fiel ao legado)
197:     AutoCenter  = .T.
198:     BorderStyle = 2
199:     ControlBox  = .F.
200:     MaxButton   = .F.
201:     MinButton   = .F.
202:     TitleBar    = 0
203: 
204:     *====================================================================
205:     * Init - inicializacao padrao via FormBase (ver InicializarForm abaixo).
206:     * O legado so declara PUBLIC lcSenha e ajusta Container1.Label1.Caption
207:     * no seu Init (ver comportamento.json) - sem checagem de conexao SQL,
208:     * por isso nao ha ValidarParametros() aqui (diferente de outros dialogos
209:     * OPERACIONAIS que guardam gnConnHandle antes de montar a tela).
210:     *====================================================================
211:     PROCEDURE Init()
212:         RETURN DODEFAULT()
213:     ENDPROC
214: 
215:     *====================================================================
216:     * InicializarForm - Instancia o Business Object e monta o layout completo
217:     * do dialogo: faixa de titulo (fase 3), campos de senha/instrucao e
218:     * botao de saida/cancelar (esta fase).
219:     *====================================================================
220:     PROTECTED PROCEDURE InicializarForm()
221:         LOCAL loc_lResultado, loc_oErro
222:         loc_lResultado = .F.
223: 
224:         TRY
225:             THIS.this_oBusinessObject = CREATEOBJECT("SIGPRSTFBO")
226: 
227:             THIS.ConfigurarCabecalho()
228:             THIS.ConfigurarCampos()
229:             THIS.ConfigurarSaida()
230: 
231:             loc_lResultado = .T.
232:         CATCH TO loc_oErro
233:             MostrarErro(loc_oErro.Message + CHR(13) + ;
234:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
235:                 "Procedure: " + loc_oErro.Procedure, "Erro")
236:             loc_lResultado = .F.
237:         ENDTRY
238: 
239:         RETURN loc_lResultado
240:     ENDPROC
241: 
242:     *====================================================================
243:     * ConfigurarCabecalho - Faixa cinza com o titulo (cntSombra do legado).
244:     *
245:     * Caption transcrito LITERALMENTE do dump ("Cadastro de Testes") - o
246:     * SCX declara esse texto explicitamente em lblSombra.Caption e
247:     * lblTitulo.Caption (SECAO 2 do dump), embora o Caption do FORM seja
248:     * "Senha de Risco". O Init do legado nunca sobrescreve esses dois
249:     * Captions (so altera Container1.Label1, na fase seguinte) - a
250:     * divergencia e do proprio SigTfSup.SCX e deve ser preservada (PILAR 1:
251:     * transcrever o legado, nunca "corrigir" uma inconsistencia dele).
252:     *
253:     * Width = THIS.Width (nao o literal 800/769 do dump, maior que o form
254:     * de 400px) - padrao canonico da faixa de cabecalho (CLAUDE.md regra
255:     * #11) e dos labels dentro dela (lesson "cabecalho_label_width_dump_
256:     * maior_que_form"): copiar o literal clipa o titulo.
257:     *====================================================================
258:     PROTECTED PROCEDURE ConfigurarCabecalho()
259:         THIS.AddObject("cnt_4c_Sombra", "Container")
260:         WITH THIS.cnt_4c_Sombra
261:             .Top         = 0
262:             .Left        = 0
263:             .Width       = THIS.Width
264:             .Height      = 80
265:             .BackColor   = RGB(100, 100, 100)
266:             .BorderWidth = 0
267:             .Visible     = .T.
268: 
269:             .AddObject("lbl_4c_LblSombra", "Label")
270:             WITH .lbl_4c_LblSombra
271:                 .Top       = 18
272:                 .Left      = 10
273:                 .Width     = THIS.Width
274:                 .Height    = 40
275:                 .FontName  = "Tahoma"
276:                 .FontSize  = 18
277:                 .FontBold  = .T.
278:                 .Alignment = 0
279:                 .BackStyle = 0
280:                 .ForeColor = RGB(0, 0, 0)
281:                 .Caption   = "Cadastro de Testes"
282:                 .WordWrap  = .T.
283:                 .Visible   = .T.
284:             ENDWITH
285: 
286:             .AddObject("lbl_4c_LblTitulo", "Label")
287:             WITH .lbl_4c_LblTitulo
288:                 .Top         = 17
289:                 .Left        = 10
290:                 .Width       = THIS.Width
291:                 .Height      = 46
292:                 .FontName    = "Tahoma"
293:                 .FontSize    = 18
294:                 .FontBold    = .T.
295:                 .Alignment   = 0
296:                 .BackStyle   = 0
297:                 .ForeColor   = RGB(255, 255, 255)
298:                 .Caption     = "Cadastro de Testes"

*-- Linhas 318 a 361:
318:     * InputMask/Format vazios no dump (GetSenha.InputMask="", SENHA.Format="")
319:     * sao override vazio do Form Designer - NAO transcrever (regra #49).
320:     *====================================================================
321:     PROTECTED PROCEDURE ConfigurarCampos()
322:         THIS.AddObject("shp_4c_Shape1", "Shape")
323:         WITH THIS.shp_4c_Shape1
324:             .Top           = 90
325:             .Left          = 76
326:             .Width         = 247
327:             .Height        = 42
328:             .SpecialEffect = 0
329:             .Visible       = .T.
330:         ENDWITH
331: 
332:         *-- GetSenha: decorativo, Enabled=.F., criado ANTES de SENHA para
333:         *-- ficar por baixo no z-order (fiel ao SCX)
334:         THIS.AddObject("txt_4c_SenhaSupervisor", "TextBox")
335:         WITH THIS.txt_4c_SenhaSupervisor
336:             .Top       = 99
337:             .Left      = 214
338:             .Width     = 100
339:             .Height    = 23
340:             .FontName  = "Tahoma"
341:             .FontSize  = 8
342:             .Enabled   = .F.
343:             .ForeColor = RGB(0, 0, 0)
344:             .Value     = ""
345:             .Visible   = .T.
346:         ENDWITH
347: 
348:         THIS.AddObject("lbl_4c_Label3", "Label")
349:         WITH THIS.lbl_4c_Label3
350:             .Top       = 104
351:             .Left      = 87
352:             .Width     = 108
353:             .Height    = 15
354:             .AutoSize  = .F.
355:             .FontName  = "Tahoma"
356:             .FontSize  = 8
357:             .Alignment = 0
358:             .ForeColor = RGB(90, 90, 90)
359:             .Caption   = "Senha do Supervisor :"
360:             .BackStyle = 0
361:             .Visible   = .T.

*-- Linhas 378 a 539:
378:             .Value        = ""
379:             .Visible      = .T.
380:         ENDWITH
381:         BINDEVENT(THIS.txt_4c_SENHA, "KeyPress", THIS, "ValidarSenha")
382: 
383:         THIS.AddObject("cnt_4c_Container1", "Container")
384:         WITH THIS.cnt_4c_Container1
385:             .Top           = 137
386:             .Left          = 114
387:             .Width         = 171
388:             .Height        = 56
389:             .SpecialEffect = 0
390:             .Visible       = .T.
391: 
392:             .AddObject("lbl_4c_Label1", "Label")
393:             WITH .lbl_4c_Label1
394:                 .Top       = 16
395:                 .Left      = 7
396:                 .Width     = 157
397:                 .Height    = 30
398:                 .AutoSize  = .F.
399:                 .FontBold  = .T.
400:                 .FontName  = "Trebuchet MS"
401:                 .FontSize  = 10
402:                 .Alignment = 2
403:                 .ForeColor = RGB(90, 90, 90)
404:                 .BackStyle = 0
405:                 *-- Caption inicial do SCX; InicializarForm sobrescreve a
406:                 *-- seguir com o texto que o Init() do legado gera em
407:                 *-- runtime (equivalente a ThisForm.Container1.Label1.Caption)
408:                 .Caption   = "Insira ou Passe o Cartao"
409:                 .Visible   = .T.
410:             ENDWITH
411:         ENDWITH
412: 
413:         *-- Equivalente ao SigTfSup.Init() legado:
414:         *-- ThisForm.Container1.Label1.Caption="Digite a Senha"+CHR(13)+"do Supervisor"
415:         THIS.cnt_4c_Container1.lbl_4c_Label1.Caption = "Digite a Senha" + CHR(13) + "do Supervisor"
416:     ENDPROC
417: 
418:     *====================================================================
419:     * ConfigurarSaida - CommandGroup de saida/cancelar (SAIDA do legado,
420:     * botao interno CANCELA). ControlSource="OPSENHA" do SCX nao e
421:     * reproduzido: nenhum metodo do comportamento.json le ThisForm.SAIDA.Value
422:     * e nao ha variavel OPSENHA declarada em lugar nenhum do dump - e
423:     * residuo inerte do legado, sem efeito no comportamento visivel.
424:     *====================================================================
425:     PROTECTED PROCEDURE ConfigurarSaida()
426:         THIS.AddObject("obj_4c_SAIDA", "CommandGroup")
427:         WITH THIS.obj_4c_SAIDA
428:             .ButtonCount  = 1
429:             .Top          = -2
430:             .Left         = 320
431:             .Width        = 85
432:             .Height       = 85
433:             .BackStyle    = 0
434:             .BorderStyle  = 0
435:             .BackColor    = RGB(255, 255, 255)
436:             .Visible      = .T.
437: 
438:             WITH .Buttons(1)
439:                 .Top       = 5
440:                 .Left      = 5
441:                 .Width     = 75
442:                 .Height    = 75
443:                 .FontName  = "Comic Sans MS"
444:                 .FontSize  = 8
445:                 .FontBold  = .T.
446:                 .FontItalic = .F.
447:                 .Caption   = "\<Cancelar"
448:                 .Picture   = gc_4c_CaminhoIcones + "cadastro_cancelar_60.jpg"
449:                 .Cancel    = .T.
450:                 .ForeColor = RGB(90, 90, 90)
451:                 .BackColor = RGB(255, 255, 255)
452:                 .Themes    = .F.
453:             ENDWITH
454:         ENDWITH
455:         BINDEVENT(THIS.obj_4c_SAIDA.Buttons(1), "Click", THIS, "BtnCancelarClick")
456:     ENDPROC
457: 
458:     *====================================================================
459:     * ValidarSenha - Equivalente ao SigTfSup.SENHA.KeyPress legado (o legado
460:     * nao tem PROCEDURE Valid separado para este campo - a confirmacao com
461:     * ENTER E o Valid, feitos no mesmo evento):
462:     *   IF nKeyCode = 13
463:     *       lcSenha = ThisForm.SeNHA.Value
464:     *       RELEASE Windows
465:     *   ENDIF
466:     *
467:     * PUBLIC (sem PROTECTED) porque esta ligado via BINDEVENT (regra #3).
468:     *====================================================================
469:     PROCEDURE ValidarSenha(par_nKeyCode, par_nShiftAltCtrl)
470:         IF par_nKeyCode = 13
471:             THIS.FormParaBO()
472:             THIS.this_oBusinessObject.this_lConfirmou = .T.
473:             THIS.Release()
474:         ENDIF
475:     ENDPROC
476: 
477:     *====================================================================
478:     * BtnCancelarClick - Equivalente ao SigTfSup.SAIDA.CANCELA.Click legado:
479:     *   ThisForm.Senha.Value=""
480:     *   RELEASE Windows
481:     *
482:     * Nomeado pela ACAO (Btn<Acao>Click), nao pelo objeto legado (CANCELA) -
483:     * PILAR 3 e convencao exigida pelos gates das Fases 7/8 (ver comentario
484:     * da FASE 7 no cabecalho do arquivo).
485:     *
486:     * PUBLIC (sem PROTECTED) porque esta ligado via BINDEVENT (regra #3).
487:     *====================================================================
488:     PROCEDURE BtnCancelarClick()
489:         THIS.LimparCampos()
490:         THIS.Release()
491:     ENDPROC
492: 
493:     *====================================================================
494:     * FormParaBO - Transfere o campo digitado para o Business Object.
495:     *
496:     * Caminho VIVO: chamado por ValidarSenha (o ENTER que confirma o
497:     * dialogo). Equivale ao "lcSenha = ThisForm.SeNHA.Value" do
498:     * SigTfSup.SENHA.KeyPress legado - a diferenca e que o valor vai para
499:     * a property do BO (PILAR 3) em vez de uma variavel PUBLIC.
500:     *
501:     * PROTECTED: FormBase declara o hook assim (formbase.prg:285) e
502:     * subclasse nao alarga escopo herdado - e chamado com THIS. de dentro
503:     * da propria classe (regra #8).
504:     *====================================================================
505:     PROTECTED PROCEDURE FormParaBO()
506:         THIS.this_oBusinessObject.this_cSenha = THIS.txt_4c_SENHA.Value
507:     ENDPROC
508: 
509:     *====================================================================
510:     * BOParaForm - Reflete no campo a senha guardada no Business Object.
511:     *
512:     * Caminho VIVO: chamado por LimparCampos (apos BO.LimparDados, para
513:     * que o campo acompanhe a senha zerada). Sentido inverso de FormParaBO,
514:     * com a MESMA fonte unica - a property do BO.
515:     *
516:     * PROTECTED: FormBase declara o hook assim (formbase.prg:280).
517:     *====================================================================
518:     PROTECTED PROCEDURE BOParaForm()
519:         THIS.txt_4c_SENHA.Value = THIS.this_oBusinessObject.this_cSenha
520:     ENDPROC
521: 
522:     *====================================================================
523:     * LimparCampos - Equivalente ao "ThisForm.Senha.Value = """"" do
524:     * SigTfSup.SAIDA.CANCELA.Click legado: zera a senha para que o form
525:     * chamador leia vazio (= o usuario cancelou, ver SIGPRSTFBO.ObterSenha).
526:     *
527:     * FONTE UNICA no BO: BO.LimparDados zera this_cSenha e this_lConfirmou,
528:     * e BOParaForm reflete isso no campo - assim o campo e o BO nunca
529:     * divergem (o legado, sendo modal e de registro unico, nao tinha esse
530:     * risco; aqui o form pode ser reexibido pelo chamador).
531:     *
532:     * PROTECTED: FormBase declara o hook assim (formbase.prg:276).
533:     *====================================================================
534:     PROTECTED PROCEDURE LimparCampos()
535:         THIS.this_oBusinessObject.LimparDados()
536:         THIS.BOParaForm()
537:     ENDPROC
538: 
539: ENDDEFINE


### BO (C:\4c\projeto\app\classes\SIGPRSTFBO.prg):
*==============================================================================
* SIGPRSTFBO.prg
*
* Business Object para SIGPRSTF (Senha de Risco - Senha do Supervisor)
*
* Este form NAO persiste dados em tabela propria - e um dialogo OPERACIONAL
* modal (WindowType = 1) que solicita a senha do supervisor para autorizar
* uma operacao de risco. O legado (SigTfSup.SCX) apenas captura o valor
* digitado no campo Senha em lcSenha e devolve esse valor ao form chamador
* via Unload; a validacao da senha contra o cadastro de usuarios/
* supervisores e responsabilidade do form que abriu o dialogo - nao faz
* parte do codigo fonte original deste form (comportamento.json nao lista
* nenhuma query SQL nem validacao em SigTfSup).
*
* Tabela: (nenhuma - dialogo parametrizado, sem persistencia propria)
*==============================================================================

DEFINE CLASS SIGPRSTFBO AS BusinessBase

    *-- Propriedades da entidade (espelham as properties customizadas do
    *-- form legado SigTfSup)
    this_cSenha = ""       && lcSenha - Senha do Supervisor digitada pelo usuario
    this_lConfirmou = .F.  && .T. quando o usuario confirmou a senha (ENTER), .F. quando cancelou

    *====================================================================
    * Init - Inicializa Business Object
    *====================================================================
    PROCEDURE Init()
        DODEFAULT()

        *-- Dialogo parametrizado: nao ha tabela nem campo chave proprios
        THIS.this_cTabela = ""
        THIS.this_cCampoChave = ""

        THIS.this_cSenha = ""
        THIS.this_lConfirmou = .F.

        RETURN .T.
    ENDPROC

    *====================================================================
    * LimparDados - Reinicia a senha digitada e a flag de confirmacao
    *
    * Equivalente ao SigTfSup.SAIDA.Click do legado (ThisForm.Senha.Value = "")
    * - usado pelo form chamador antes de reexibir o dialogo, garantindo que
    * uma senha de uma tentativa anterior nunca sobreviva para a proxima.
    *====================================================================
    PROCEDURE LimparDados()
        DODEFAULT()

        THIS.this_cSenha = ""
        THIS.this_lConfirmou = .F.
    ENDPROC

    *====================================================================
    * ObterSenha - Devolve a senha digitada, SOMENTE se o usuario confirmou
    * com ENTER (equivalente ao "RETURN (lcSenha)" do legado, que so era
    * atingido apos o KeyPress do campo Senha - SAIDA.Click libera a janela
    * sem passar por esse retorno, com o valor ja limpo).
    *
    * A validacao da senha contra o cadastro de usuarios/supervisores e
    * responsabilidade do form chamador - nao faz parte do SigTfSup original.
    *====================================================================
    PROCEDURE ObterSenha()
        IF !THIS.this_lConfirmou
            RETURN ""
        ENDIF

        RETURN THIS.this_cSenha
    ENDPROC

    *====================================================================
    * CarregarDoCursor - Dialogo parametrizado sem cursor/tabela propria
    * (ver cabecalho do arquivo); o comportamento padrao herdado de
    * BusinessBase ja eh o correto para este BO.
    *====================================================================
    PROCEDURE CarregarDoCursor(pcCursor)
        RETURN DODEFAULT(pcCursor)
    ENDPROC

    *====================================================================
    * ObterChavePrimaria - Dialogo sem registro persistido: nao ha chave
    * primaria propria para auditar (ver Inserir/Atualizar abaixo).
    *====================================================================
    PROTECTED PROCEDURE ObterChavePrimaria()
        RETURN ""
    ENDPROC

    *====================================================================
    * Inserir / Atualizar - NAO sobrescritos propositalmente.
    *
    * SigTfSup nao grava em tabela nenhuma: e um dialogo modal que apenas
    * captura a senha do supervisor (ver ObterSenha acima) e devolve o
    * controle ao form chamador. O comportamento padrao herdado de
    * BusinessBase (recusar a operacao) ja eh o correto aqui - criar um
    * INSERT/UPDATE para este BO violaria o PILAR 2 (inventar persistencia
    * que o sistema legado nao tem). Por isso RegistrarAuditoria tambem
    * nunca e chamado a partir deste BO.
    *====================================================================

ENDDEFINE


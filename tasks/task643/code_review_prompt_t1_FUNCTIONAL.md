# CODE REVIEW - PASS FUNCTIONAL: Functional Logic (metodos, eventos, containers)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Functional Logic (metodos, eventos, containers)**.

## PROBLEMAS DETECTADOS (1)
- [METODO-INEXISTENTE] Metodo 'THIS.CarregarUniversoOperacoes()' chamado mas NAO definido como PROCEDURE no Form nem herdado de FormBase. A LLM pode ter inventado este metodo. VERIFICAR se existe no legado e IMPLEMENTAR ou REMOVER a chamada.

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

### FORM (C:\4c\projeto\app\forms\operacionais\FormSigOpAtu.prg) - TRECHOS RELEVANTES PARA PASS FUNCTIONAL (1050 linhas total):

*-- Linhas 39 a 106:
39: * Alignment no dump, logo .Alignment=0 com Width explicita, CLAUDE.md
40: * regra #23) e txt_4c_DopEstq (DopEstq/fwget do legado, ligado a
41: * SigCdOpe.dopes char(20) - regra "SigCdOpe eh single-column" acima).
42: * So a geometria/visual - BINDEVENT do Valid fica para a Fase 7.
43: *
44: * FASE 6/8 - CAMPOS RESTANTES E LOOKUPS: nao sobrou nenhum campo de
45: * dados (o legado tem UM so, entregue na Fase 5), entao esta fase
46: * entrega (a) o ultimo objeto de tela - cmd_4c_Command1, o "Ok"
47: * (Command1/fwbtng do legado) - e (b) o LOOKUP do campo DopEstq
48: * COMPLETO, que eh o trabalho principal desta fase.
49: *
50: * O "equivalente do cnt_4c_BotoesAcao (Salvar/Cancelar)" do roteiro
51: * CRUD aqui eh esse botao unico, criado DIRETO no Form (o SCX nao tem
52: * container de botoes). Ele sai desta fase com o Click JA
53: * implementado (BtnOkClick): botao visivel sem funcionalidade real
54: * seria stub, o que o pipeline proibe - ver nota em BtnOkClick sobre
55: * a transcricao literal do Click legado.
56: *
57: * LOOKUP (o Valid do DopEstq legado): o legado faz Seek no cursor
58: * global Fortyus CrOpera e, falhando, abre o picker fwBuscaInt
59: * ('CrOpera','Dopes',...,'Operacoes') com mAddColuna('Dopes','','Codigo').
60: * No migrado isso vira FormBuscaAuxiliar sobre o MESMO universo, com a
61: * MESMA coluna/titulo - ver a entrega (1) da Fase 8 abaixo, que trocou
62: * o "SigCdOpe inteira" desta fase pelo proprio crOpera quando ele esta
63: * aberto. Eventos:
64: *   DopEstqLostFocus  - equivalente do Valid (regra #47: lookup vai em
65: *     LostFocus, nunca em KeyPress sem testar a tecla; regra #34:
66: *     BINDEVENT em "Valid" nao dispara de forma confiavel em TextBox).
67: *   DopEstqKeyPress   - ENTER/TAB resolvem o digitado, F4/F5 abrem o
68: *     picker; TESTA a tecla antes de abrir (regra #47).
69: *   DopEstqDblClick   - atalho de mouse para o mesmo picker.
70: *   AbrirLookupDopEstq - funil unico; regra #36 (1o argumento eh o
71: *     HANDLE) e regra #37 (guarda this_lAchouRegistro antes do Show(),
72: *     atribuicao SO sob this_lSelecionou).
73: *
74: * FASE 7/8 - EVENTOS PRINCIPAIS: os quatro nomes canonicos
75: * BtnIncluirClick/BtnAlterarClick/BtnVisualizarClick/BtnExcluirClick
76: * NAO existem aqui, e isso eh deliberado: sao a barra CRUD da Page1 do
77: * frmcadastro, e este legado nao tem CRUD nenhum (Class: form puro, sem
78: * frmcadastro, sem Grupo_Op, sem pcEscolha, sem X.Click de verbo CRUD).
79: * Inventa-los violaria o PILAR 1 e so poderia produzir metodo vazio, que
80: * o pipeline proibe. O UNICO botao do dump eh o Command1/"Ok", cujo
81: * evento eh BtnOkClick.
82: *
83: * O trabalho REAL desta fase foi o CONTRATO DE RETORNO do BtnOkClick: o
84: * dialogo nao existe para si mesmo - ele eh chamado pelo "Acerto de
85: * Inventario" do SIGCDBAL ("Do Form SigOpAtu" seguido de
86: * "If Not Used('crOpera') Or IsEmpty(crOpera.Dopes) / Return",
87: * SIGCDBAL_form_codigo_fonte.txt:6014-6019), que LE a Operacao escolhida
88: * logo depois. Como estava, o Click fazia THIS.Release(): o form se
89: * destruia junto com o BO e o chamador NAO TINHA COMO LER nada - o
90: * dialogo "funcionava" na tela e devolvia NADA, sem erro e sem log. Ver
91: * BtnOkClick e PublicarOperacaoEscolhida.
92: *
93: * FASE 8/8 - CONSOLIDACAO FINAL. Quatro entregas, todas com call site
94: * real - metodo que ninguem chama eh stub, e stub o pipeline proibe:
95: *
96: * (1) UNIVERSO DO LOOKUP - fecha a pendencia aberta na Fase 6. O picker
97: *     consultava SigCdOpe INTEIRA, e o universo legitimo eh o
98: *     subconjunto que o CHAMADOR preparou em crOpera ("Where Parcs <> 1
99: *     And Opers = 3 And DigItens = 1 And Caixas <> 1",
100: *     SIGCDBAL_form_codigo_fonte.txt:5476). Nao eh refinamento
101: *     opcional: o legado chama fwBusca*Int* ('CrOpera','Dopes',...), o
102: *     picker de CURSOR LOCAL - ele JA navegava crOpera, nunca a tabela.
103: *     Consultar SigCdOpe inteira era desvio do PILAR 1 e produzia a
104: *     pior UX possivel: o usuario escolhia no picker uma operacao que o
105: *     PublicarOperacaoEscolhida recusava logo depois.
106: *     Ver CarregarUniversoOperacoes e AbrirLookupDopEstq.

*-- Linhas 123 a 285:
123: *
124: * (3) HOOKS DE TRANSFERENCIA COMPLETOS - BOParaForm (contraparte do
125: *     FormParaBO da Fase 7) e LimparCampos, chamados em
126: *     InicializarForm e no caminho de cancelamento.
127: *
128: * (4) LIBERACAO DE RECURSOS - QueryUnload publica o cancelamento quando
129: *     a tela morre sem confirmar; Destroy fecha o cursor do picker.
130: *
131: * Metodos CRUD-canonicos que seguem NAO se aplicando: ver o comentario
132: * dedicado antes de Destroy().
133: *
134: * Herda de: FormBase
135: *====================================================================
136: 
137: DEFINE CLASS FormSigOpAtu AS FormBase
138: 
139:     *-- Propriedades visuais (copiadas do SCX legado - SIGOPATU)
140:     this_cMensagemErro = ""
141:     Width       = 800
142:     Height      = 130
143:     Caption     = "Opera" + CHR(231) + CHR(227) + "o para Atualiza" + CHR(231) + CHR(227) + "o"
144:     AutoCenter  = .T.
145:     BorderStyle = 2
146:     ShowWindow = 1
147:     ControlBox  = .F.
148:     Movable     = .F.
149:     TitleBar    = 0
150:     WindowType  = 1
151: 
152:     *-- Propriedades do Form
153:     this_oBusinessObject = .NULL.
154: 
155:     *-- Guarda de reentrancia do lookup (regra #37): o FormBuscaAuxiliar eh
156:     *-- MODAL, tira o foco do campo e redispara o proprio LostFocus.
157:     this_lEmLookup = .F.
158: 
159:     *-- Guarda de valor-nao-mudou: depois de o picker devolver o foco ao
160:     *-- campo, o LostFocus dispara de novo com o MESMO valor. Sem este memo
161:     *-- o picker reabriria em laco e prenderia o usuario no dialogo modal.
162:     *-- Sentinela CHR(0) (nenhum valor digitavel bate) para que a PRIMEIRA
163:     *-- validacao sempre aconteca, inclusive com o campo vazio.
164:     this_cUltimoDopEstqValidado = CHR(0)
165: 
166:     *-- CONTRATO DE RETORNO para o form chamador (Fase 7/8).
167:     *-- O legado nao devolve nada por valor: o SIGCDBAL/"Acerto de
168:     *-- Inventario" faz "Do Form SigOpAtu" e logo depois LE O RESULTADO
169:     *-- do cursor dele proprio (SIGCDBAL_form_codigo_fonte.txt:6014-6019):
170:     *--
171:     *--     Do Form SigOpAtu
172:     *--     If Not Used('crOpera') Or IsEmpty(crOpera.Dopes)
173:     *--         && caso nao tenha escolhido a operacao cancel o processamento...
174:     *--         Return
175:     *--     Endif
176:     *--
177:     *-- Isto eh: a SAIDA do dialogo eh a LINHA em que o cursor "crOpera"
178:     *-- ficou POSICIONADO. O crOpera NAO eh deste dialogo - eh do
179:     *-- CHAMADOR, que o cria filtrado no proprio Init
180:     *-- (SIGCDBAL_form_codigo_fonte.txt:5476-5484: "Select * From SigCdOpe
181:     *-- Where Parcs <> 1 And Opers = 3 And DigItens = 1 And Caixas <> 1" +
182:     *-- "Index On Dopes Tag Dopes") e de onde, depois, le "crOpera.Dopes"
183:     *-- (linhas 6097/6104/6154) E "crOpera.Estoqs" (linha 6132). O Valid
184:     *-- legado so dava "Select CrOpera / Seek()", ou seja POSICIONAVA o
185:     *-- cursor do chamador - e essa posicao era a resposta.
186:     *--
187:     *-- Estas duas properties sao o mesmo contrato em forma utilizavel pelo
188:     *-- sistema novo (canonico do projeto - formbuscaauxiliar.prg:367-369:
189:     *-- o botao de confirmar marca a flag e faz Hide(), e o CHAMADOR le o
190:     *-- resultado depois do Show()).
191:     this_lConfirmado         = .F.
192:     this_cDopEstqSelecionado = ""
193: 
194:     *====================================================================
195:     * Init
196:     *====================================================================
197:     PROCEDURE Init()
198:         RETURN DODEFAULT()
199:     ENDPROC
200: 
201:     *====================================================================
202:     * InicializarForm - cria o Business Object e monta a faixa do
203:     * cabecalho (cnt_4c_Sombra).
204:     *====================================================================
205:     PROTECTED PROCEDURE InicializarForm()
206:         LOCAL loc_lSucesso, loc_oErro
207:         loc_lSucesso = .F.
208: 
209:         TRY
210:             THIS.this_oBusinessObject = CREATEOBJECT("SigOpAtuBO")
211: 
212:             IF VARTYPE(THIS.this_oBusinessObject) = "O"
213:                 THIS.ConfigurarLayoutBase()
214:                 THIS.ConfigurarCampos()
215:                 THIS.ConfigurarBotaoOk()
216:                 THIS.ConfigurarEventos()
217: 
218:                 *-- Estado inicial da tela vem do BO (hooks da Fase 8/8):
219:                 *   LimparCampos zera o memo de validacao e o contrato de
220:                 *   retorno e chama BOParaForm, que escreve no campo o
221:                 *   valor que a property do BO carrega. Com o BO recem
222:                 *   criado isso da campo vazio - o mesmo estado inicial do
223:                 *   legado - e, ao mesmo tempo, da aos dois hooks um call
224:                 *   site REAL em vez de deixa-los como decoracao.
225:                 THIS.LimparCampos()
226:                 loc_lSucesso = .T.
227:             ENDIF
228:         CATCH TO loc_oErro
229:             THIS.this_cMensagemErro = loc_oErro.Message
230:             MsgErro(loc_oErro.Message + CHR(13) + "Linha: " + TRANSFORM(loc_oErro.LineNo) + ;
231:                 CHR(13) + "Procedure: " + loc_oErro.Procedure, "Erro ao inicializar Opera" + ;
232:                 CHR(231) + CHR(227) + "o para Atualiza" + CHR(231) + CHR(227) + "o")
233:             loc_lSucesso = .F.
234:         ENDTRY
235: 
236:         RETURN loc_lSucesso
237:     ENDPROC
238: 
239:     *====================================================================
240:     * ConfigurarLayoutBase - fundo (Picture do legado) e faixa do
241:     * cabecalho (cnt_4c_Sombra, equivalente ao cntSombra legado). Campo
242:     * (DopEstq), label (Say1) e botao (Command1) entram nas fases
243:     * seguintes.
244:     *====================================================================
245:     PROTECTED PROCEDURE ConfigurarLayoutBase()
246:         THIS.Picture = gc_4c_CaminhoFramework + "imagens\new_background.jpg"
247: 
248:         THIS.AddObject("cnt_4c_Sombra", "Container")
249:         WITH THIS.cnt_4c_Sombra
250:             .Top         = 0
251:             .Left        = 0
252:             .Width       = THIS.Width
253:             .Height      = 80
254:             .BorderWidth = 0
255:             .BackStyle   = 1
256:             .BackColor   = RGB(100, 100, 100)
257:             .Visible     = .T.
258:         ENDWITH
259: 
260:         *-- lblSombra: Init legado faz ThisForm.cntSombra.lblSombra.Caption
261:         *   = ThisForm.Caption - reproduzido direto no .Caption abaixo.
262:         THIS.cnt_4c_Sombra.AddObject("lbl_4c_LblSombra", "Label")
263:         WITH THIS.cnt_4c_Sombra.lbl_4c_LblSombra
264:             .FontBold      = .T.
265:             .FontName      = "Tahoma"
266:             .FontSize      = 18
267:             .FontUnderline = .F.
268:             .WordWrap      = .T.
269:             .AutoSize      = .F.
270:             .Alignment     = 0
271:             .BackStyle     = 0
272:             .Caption       = THIS.Caption
273:             .Height        = 40
274:             .Left          = 10
275:             .Top           = 18
276:             .Width         = 769
277:             .ForeColor     = RGB(0, 0, 0)
278:             .Visible       = .T.
279:         ENDWITH
280: 
281:         *-- lblTitulo: idem - ThisForm.cntSombra.lblTitulo.Caption = ThisForm.Caption
282:         THIS.cnt_4c_Sombra.AddObject("lbl_4c_LblTitulo", "Label")
283:         WITH THIS.cnt_4c_Sombra.lbl_4c_LblTitulo
284:             .FontBold  = .T.
285:             .FontName  = "Tahoma"

*-- Linhas 307 a 354:
307:     * ForeColor declarado -> RGB(90,90,90) - regra #12).
308:     * txt_4c_DopEstq = DopEstq (fwget), ligado a SigCdOpe.dopes char(20)
309:     * - MaxLength = 20 (regra #19, largura vem do SCHEMA, nao do Width
310:     * em pixels). BINDEVENT do Valid (lookup em SigCdOpe) fica para a
311:     * Fase 7 (regra #47 - lookup vai em LostFocus, nao em KeyPress sem
312:     * testar a tecla).
313:     *====================================================================
314:     PROTECTED PROCEDURE ConfigurarCampos()
315:         THIS.AddObject("lbl_4c_Label1", "Label")
316:         WITH THIS.lbl_4c_Label1
317:             .FontName  = "Tahoma"
318:             .FontSize  = 8
319:             .FontBold  = .F.
320:             .AutoSize  = .F.
321:             .Alignment = 0
322:             .BackStyle = 0
323:             .ForeColor = RGB(90, 90, 90)
324:             .Caption   = "Opera" + CHR(231) + CHR(227) + "o de Estoque :"
325:             .Left      = 105
326:             .Top       = 94
327:             .Width     = 130
328:             .Height    = 17
329:             .Visible   = .T.
330:         ENDWITH
331: 
332:         THIS.AddObject("txt_4c_DopEstq", "TextBox")
333:         WITH THIS.txt_4c_DopEstq
334:             .FontName  = "Tahoma"
335:             .FontSize  = 8
336:             .Value     = ""
337:             .MaxLength = 20
338:             .Left      = 241
339:             .Top       = 91
340:             .Width     = 150
341:             .Height    = 21
342:             .TabIndex  = 2
343:             .Visible   = .T.
344:         ENDWITH
345:     ENDPROC
346: 
347:     *====================================================================
348:     * ConfigurarBotaoOk - Fase 6/8: Command1 do legado (mapeamento.json:
349:     * SIGOPATU.Command1 -> cmd_4c_Command1). Unico botao do form, criado
350:     * DIRETO no Form porque o SCX nao tem container de botoes.
351:     *
352:     * Top/Left/Picture/Caption EXATOS do dump
353:     * (SigOpAtu_form_codigo_fonte.txt:147-152). Width/Height/FontName/
354:     * FontSize/FontBold/FontItalic/ForeColor/BackColor/MousePointer/

*-- Linhas 368 a 595:
368:     * classe fwbtng nao declara Left/Top, logo nao ha valor "da classe"
369:     * para preferir). Icone e caption ficam inteiros na area visivel.
370:     *====================================================================
371:     PROTECTED PROCEDURE ConfigurarBotaoOk()
372:         THIS.AddObject("cmd_4c_Command1", "CommandButton")
373:         WITH THIS.cmd_4c_Command1
374:             .Top             = 3
375:             .Left            = 723
376:             .Width           = 80
377:             .Height          = 100
378:             .Caption         = "\<Ok"
379:             .Picture         = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
380:             .DisabledPicture = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
381:             .FontName        = "Comic Sans MS"
382:             .FontSize        = 8
383:             .FontBold        = .T.
384:             .FontItalic      = .T.
385:             .ForeColor       = RGB(90, 90, 90)
386:             .BackColor       = RGB(255, 255, 255)
387:             .Themes          = .T.
388:             .MousePointer    = 15
389:             .WordWrap        = .T.
390:             .Visible         = .T.
391:         ENDWITH
392:     ENDPROC
393: 
394:     *====================================================================
395:     * ConfigurarEventos - Fase 6/8: liga os dois unicos eventos do dump
396:     * (DopEstq.Valid e Command1.Click). Chamado por ULTIMO em
397:     * InicializarForm, depois de ConfigurarCampos/ConfigurarBotaoOk -
398:     * BINDEVENT precisa dos objetos ja criados.
399:     *
400:     * Todos os handlers sao PUBLIC (sem PROTECTED): BINDEVENT com metodo
401:     * PROTECTED falha em SILENCIO (regra #3).
402:     *====================================================================
403:     PROTECTED PROCEDURE ConfigurarEventos()
404:         *-- Equivalente do Valid legado. "LostFocus" e nao "Valid" porque
405:         *   BINDEVENT em "Valid" nao dispara de forma confiavel em TextBox
406:         *   (regra #34); e nao "KeyPress" solto porque ali o picker subiria
407:         *   a CADA tecla, antes de o usuario terminar de digitar (regra #47).
408:         BINDEVENT(THIS.txt_4c_DopEstq, "LostFocus", THIS, "DopEstqLostFocus")
409: 
410:         *-- KeyPress TESTANDO a tecla (regra #47): ENTER/TAB resolvem o
411:         *   valor digitado, F4/F5 abrem o picker direto.
412:         BINDEVENT(THIS.txt_4c_DopEstq, "KeyPress", THIS, "DopEstqKeyPress")
413: 
414:         *-- Atalho de mouse para o mesmo funil de lookup.
415:         BINDEVENT(THIS.txt_4c_DopEstq, "DblClick", THIS, "DopEstqDblClick")
416: 
417:         BINDEVENT(THIS.cmd_4c_Command1, "Click", THIS, "BtnOkClick")
418:     ENDPROC
419: 
420:     *====================================================================
421:     * DopEstqLostFocus - Wrapper do funil de validacao do campo (Valid
422:     * legado). O corpo vive em DopEstqLostFocusExec para que a flag de
423:     * reentrancia seja SEMPRE liberada, inclusive nos RETURN antecipados
424:     * (regra #47: set/clear no wrapper, nunca em volta de um corpo com
425:     * RETURN no meio, senao a flag trava ligada e MATA o lookup pelo
426:     * resto da vida do form).
427:     *====================================================================
428:     PROCEDURE DopEstqLostFocus()
429:         IF THIS.this_lEmLookup
430:             RETURN
431:         ENDIF
432: 
433:         THIS.this_lEmLookup = .T.
434:         THIS.DopEstqLostFocusExec()
435:         THIS.this_lEmLookup = .F.
436:     ENDPROC
437: 
438:     *====================================================================
439:     * DopEstqLostFocusExec - Corpo do Valid legado:
440:     *
441:     *   Select CrOpera / Go Top / Set Near On
442:     *   If !Seek(This.Value)
443:     *       loLista = CreateObject('fwBuscaInt','CrOpera','Dopes',This.Value,'Operacoes')
444:     *       loLista.mAddColuna('Dopes','','Codigo')
445:     *       loLista.Show()
446:     *   EndIf
447:     *
448:     * O Seek + picker viraram UMA chamada a AbrirLookupDopEstq: o Init do
449:     * FormBuscaAuxiliar JA faz o match exato e sinaliza em
450:     * this_lAchouRegistro, que eh o equivalente direto do !Seek(). Por
451:     * isso NAO ha SQLEXEC de existencia aqui - duplicar a checagem antes
452:     * do picker eh proibido pela regra #37 (so cria caminho para
453:     * divergir), motivo pelo qual SigOpAtuBO.ExisteOperacao() nao eh
454:     * chamado neste fluxo.
455:     *====================================================================
456:     PROCEDURE DopEstqLostFocusExec()
457:         LOCAL loc_cValor
458:         loc_cValor = ALLTRIM(NVL(THIS.txt_4c_DopEstq.Value, ""))
459: 
460:         *-- Campo VAZIO: nenhum picker e NENHUMA mensagem (regra #50 -
461:         *   universo/valor vazio nao eh erro, e avisar + apagar impediria
462:         *   o usuario de preencher). Tambem NAO se auto-preenche com o
463:         *   primeiro registro: pegar "o primeiro que casa" sem escolha do
464:         *   usuario eh o defeito ja proibido no projeto (fAcessoContas).
465:         *   O campo em branco segue para o botao "Ok", que eh quem avisa
466:         *   no legado - ver BtnOkClick.
467:         IF EMPTY(loc_cValor)
468:             THIS.this_cUltimoDopEstqValidado = ""
469:             RETURN
470:         ENDIF
471: 
472:         *-- Valor ja validado nesta passagem: nao reabrir o picker.
473:         IF loc_cValor == THIS.this_cUltimoDopEstqValidado
474:             RETURN
475:         ENDIF
476: 
477:         THIS.AbrirLookupDopEstq(loc_cValor)
478: 
479:         THIS.this_cUltimoDopEstqValidado = ALLTRIM(NVL(THIS.txt_4c_DopEstq.Value, ""))
480:     ENDPROC
481: 
482:     *====================================================================
483:     * DopEstqKeyPress - ENTER(13)/TAB(9) resolvem o valor digitado;
484:     * F4(115)/F5(116) abrem o picker direto. O teste da tecla eh
485:     * OBRIGATORIO (regra #47) - sem ele o dialogo modal subiria a cada
486:     * caractere e o usuario nao conseguiria terminar de digitar o codigo.
487:     * Assinatura com os parametros do evento (regra #3: handler de
488:     * KeyPress SEM parametros estoura a cada tecla).
489:     *
490:     * Guarda save/restore e nao set/clear (regra #47): este eh um IRMAO
491:     * do funil e pode ser acionado de dentro do proprio fluxo de lookup;
492:     * um clear simples liberaria a flag cedo demais.
493:     *====================================================================
494:     PROCEDURE DopEstqKeyPress(par_nKeyCode, par_nShiftAltCtrl)
495:         LOCAL loc_lEmLookupAnt
496: 
497:         IF !INLIST(par_nKeyCode, 13, 9, 115, 116)
498:             RETURN
499:         ENDIF
500: 
501:         IF EMPTY(ALLTRIM(NVL(THIS.txt_4c_DopEstq.Value, ""))) AND ;
502:                 INLIST(par_nKeyCode, 13, 9)
503:             *-- ENTER/TAB com campo vazio: deixa o foco seguir (regra #50).
504:             *   F4/F5 continuam abrindo o picker com a lista completa.
505:             RETURN
506:         ENDIF
507: 
508:         loc_lEmLookupAnt    = THIS.this_lEmLookup
509:         THIS.this_lEmLookup = .T.
510: 
511:         THIS.AbrirLookupDopEstq(ALLTRIM(NVL(THIS.txt_4c_DopEstq.Value, "")))
512:         THIS.this_cUltimoDopEstqValidado = ALLTRIM(NVL(THIS.txt_4c_DopEstq.Value, ""))
513: 
514:         THIS.this_lEmLookup = loc_lEmLookupAnt
515:     ENDPROC
516: 
517:     *====================================================================
518:     * DopEstqDblClick - Atalho de mouse para o picker. Mesma guarda
519:     * save/restore do irmao de KeyPress (regra #47).
520:     *====================================================================
521:     PROCEDURE DopEstqDblClick()
522:         LOCAL loc_lEmLookupAnt
523: 
524:         loc_lEmLookupAnt    = THIS.this_lEmLookup
525:         THIS.this_lEmLookup = .T.
526: 
527:         THIS.AbrirLookupDopEstq(ALLTRIM(NVL(THIS.txt_4c_DopEstq.Value, "")))
528:         THIS.this_cUltimoDopEstqValidado = ALLTRIM(NVL(THIS.txt_4c_DopEstq.Value, ""))
529: 
530:         THIS.this_lEmLookup = loc_lEmLookupAnt
531:     ENDPROC
532: 
533:     *====================================================================
534:     * CarregarUniversoOperacoes - Monta o cursor que o lookup navega.
535:     *
536:     * O legado chama fwBusca*Int* ('CrOpera','Dopes',...), que eh o
537:     * picker de cursor LOCAL: o universo dele NUNCA foi "SigCdOpe
538:     * inteira" - era o crOpera que o CHAMADOR montou ja filtrado
539:     * ("Select * From SigCdOpe Where Parcs <> 1 And Opers = 3 And
540:     * DigItens = 1 And Caixas <> 1", SIGCDBAL_form_codigo_fonte.txt:5476)
541:     * e indexou por Dopes (SIGCDBAL:5483).
542:     *
543:     * Por isso aqui NAO se reescreve aquele WHERE: copiar o filtro do
544:     * chamador para dentro do dialogo seria filtro INVENTADO - o dialogo
545:     * nao o conhece, e outro chamador teria outro. O filtro chega pronto
546:     * DENTRO do crOpera; basta copiar as linhas dele.
547:     *
548:     * Sem crOpera aberto, o dialogo foi acionado fora do SIGCDBAL: ai o
549:     * universo honesto eh SigCdOpe, superconjunto de qualquer crOpera.
550:     *
551:     * UMA coluna so (Dopes), como no mAddColuna unico do legado:
552:     * SigCdOpe eh SINGLE-COLUMN (CLAUDE.md) - dopes char(20) eh a PK E a
553:     * descricao (CONSTRAINT sigcdope_dopes PRIMARY KEY (dopes)). NUNCA
554:     * acrescentar descrs/Descrs: a coluna nao existe e o
555:     * FormBuscaAuxiliar estoura ao montar o grid.
556:     *
557:     * READWRITE no ramo local porque cursor de SELECT ... INTO CURSOR
558:     * nasce somente-leitura; o Grid do picker precisa navegar nele.
559:     *====================================================================
560:     PROTECTED FUNCTION CarregarUniversoOperacoes()
561:         LOCAL loc_lSucesso, loc_nResultado, loc_cAliasAnt, loc_oErro
562:         loc_lSucesso  = .F.
563:         loc_cAliasAnt = ALIAS()
564: 
565:         TRY
566:             IF USED("cursor_4c_BuscaOpe")
567:                 USE IN cursor_4c_BuscaOpe
568:             ENDIF
569: 
570:             IF USED("crOpera") AND TYPE("crOpera.Dopes") = "C"
571:                 *-- Universo do CHAMADOR - o CrOpera do fwBuscaInt legado.
572:                 SELECT Dopes ;
573:                     FROM crOpera ;
574:                     ORDER BY Dopes ;
575:                     INTO CURSOR cursor_4c_BuscaOpe READWRITE
576: 
577:                 loc_lSucesso = USED("cursor_4c_BuscaOpe")
578:             ELSE
579:                 IF TYPE("gnConnHandle") = "N" AND gnConnHandle > 0
580:                     loc_nResultado = SQLEXEC(gnConnHandle, ;
581:                         "SELECT Dopes FROM SigCdOpe ORDER BY Dopes", ;
582:                         "cursor_4c_BuscaOpe")
583: 
584:                     loc_lSucesso = (loc_nResultado > 0 AND USED("cursor_4c_BuscaOpe"))
585: 
586:                     IF NOT loc_lSucesso
587:                         MsgErro("N" + CHR(227) + "o foi poss" + CHR(237) + "vel carregar as " + ;
588:                             "Opera" + CHR(231) + CHR(245) + "es de Estoque." + CHR(13) + ;
589:                             CapturarErroSQL(), "Opera" + CHR(231) + CHR(227) + ;
590:                             "o para Atualiza" + CHR(231) + CHR(227) + "o")
591:                     ENDIF
592:                 ENDIF
593:             ENDIF
594: 
595:             *-- Universo VAZIO nao eh erro e nao recebe aviso (regra #50):

*-- Linhas 603 a 842:
603:         CATCH TO loc_oErro
604:             loc_lSucesso = .F.
605:             MsgErro(loc_oErro.Message + CHR(13) + "Linha: " + TRANSFORM(loc_oErro.LineNo) + ;
606:                 CHR(13) + "Procedure: " + loc_oErro.Procedure, ;
607:                 "Opera" + CHR(231) + CHR(245) + "es de Estoque")
608:         ENDTRY
609: 
610:         IF NOT EMPTY(loc_cAliasAnt) AND USED(loc_cAliasAnt)
611:             SELECT (loc_cAliasAnt)
612:         ENDIF
613: 
614:         RETURN loc_lSucesso
615:     ENDFUNC
616: 
617:     *====================================================================
618:     * AbrirLookupDopEstq - Funil UNICO do lookup de Operacao de Estoque.
619:     * Reproduz o Valid legado inteiro, sobre o universo que
620:     * CarregarUniversoOperacoes acabou de montar:
621:     *
622:     *   Select CrOpera / Go Top / Set Near On
623:     *   If !Seek(This.Value)
624:     *       loLista = CreateObject('fwBuscaInt','CrOpera','Dopes',This.Value,'Operacoes')
625:     *       loLista.mAddColuna('Dopes','','Codigo')
626:     *       loLista.Show()
627:     *   EndIf
628:     *   ... This.Value = Evaluate('CrOpera.dopes') ... This.Refresh
629:     *
630:     * O match EXATO (o "If !Seek") roda sobre o MESMO cursor que o picker
631:     * exibe - fonte UNICA, nenhum caminho para divergir, que eh o que a
632:     * regra #37 cobra ao proibir consulta de existencia duplicada antes
633:     * do picker. Por isso o FormBuscaAuxiliar eh usado em modo CURSOR
634:     * (CREATEOBJECT sem parametros + this_cCursorDestino) e nao em modo
635:     * tabela: la o Init refaria a consulta por conta propria, contra
636:     * SigCdOpe inteira, reabrindo o desvio de universo que a Fase 8
637:     * fechou. Em modo cursor this_lAchouRegistro nao eh usado - quem
638:     * responde "achei exato?" eh o LOCATE logo abaixo.
639:     *
640:     * LOCATE e nao SEEK: SEEK depende de TAG, e com SET EXACT ON
641:     * (config.prg) chave parcial em char nao casa de forma confiavel.
642:     *
643:     * Nada escolhido => o codigo digitado FICA (regras #37/#50): apagar o
644:     * que o usuario digitou eh exatamente o defeito do Erro198. Aqui o
645:     * legado reatribuia This.Value = CrOpera.dopes em TODOS os caminhos
646:     * (com Set Near On isso trazia o registro MAIS PROXIMO mesmo sem
647:     * escolha nenhuma); reproduzir isso gravaria um valor que o usuario
648:     * nao escolheu. Desvio consciente do PILAR 1, limitado ao caminho de
649:     * cancelamento do picker.
650:     *
651:     * O .Refresh() do campo eh o This.Refresh do fim do Valid legado.
652:     *====================================================================
653:     PROCEDURE AbrirLookupDopEstq(par_cValor)
654:         LOCAL loc_oBusca, loc_cValor, loc_cAliasAnt, loc_cTitulo, loc_oErro
655:         loc_oBusca    = .NULL.
656:         loc_cValor    = IIF(VARTYPE(par_cValor) = "C", ALLTRIM(par_cValor), "")
657:         loc_cAliasAnt = ALIAS()
658:         loc_cTitulo   = "Opera" + CHR(231) + CHR(245) + "es"
659: 
660:         TRY
661:             IF THIS.CarregarUniversoOperacoes()
662:                 SELECT cursor_4c_BuscaOpe
663:                 LOCATE FOR UPPER(ALLTRIM(NVL(cursor_4c_BuscaOpe.Dopes, ""))) == UPPER(loc_cValor)
664: 
665:                 IF FOUND()
666:                     *-- Ramo "Else" do Valid legado: o campo recebe o valor
667:                     *   canonico do cursor (grafia/caixa da tabela).
668:                     THIS.txt_4c_DopEstq.Value = ALLTRIM(NVL(cursor_4c_BuscaOpe.Dopes, ""))
669:                     THIS.txt_4c_DopEstq.Refresh()
670:                 ELSE
671:                     loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
672: 
673:                     IF VARTYPE(loc_oBusca) = "O"
674:                         *-- Modo CURSOR: sem os parametros de Init o
675:                         *   FormBuscaAuxiliar nao consulta nada por conta
676:                         *   propria - so exibe o cursor que recebe aqui.
677:                         loc_oBusca.this_cCursorDestino = "cursor_4c_BuscaOpe"
678:                         loc_oBusca.this_cTitulo        = loc_cTitulo
679: 
680:                         IF PEMSTATUS(loc_oBusca, "cnt_4c_Cabecalho", 5)
681:                             loc_oBusca.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = loc_cTitulo
682:                             loc_oBusca.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = loc_cTitulo
683:                         ENDIF
684: 
685:                         *-- UMA coluna so - mAddColuna('Dopes','','Codigo')
686:                         *   do legado (SigCdOpe eh single-column).
687:                         loc_oBusca.mAddColuna("Dopes", "", "C" + CHR(243) + "digo")
688:                         loc_oBusca.Show()
689: 
690:                         *-- O picker sai do Show() apenas OCULTO
691:                         *   (BtnSelecionarClick faz Hide(), nao Release()),
692:                         *   entao o cursor continua aberto e POSICIONADO na
693:                         *   linha escolhida - eh de la que o valor eh lido.
694:                         IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaOpe")
695:                             SELECT cursor_4c_BuscaOpe
696:                             THIS.txt_4c_DopEstq.Value = ALLTRIM(NVL(cursor_4c_BuscaOpe.Dopes, ""))
697:                             THIS.txt_4c_DopEstq.Refresh()
698:                         ENDIF
699: 
700:                         *-- Release ANTES do USE IN: o Grid do picker ainda
701:                         *   tem o cursor como RecordSource enquanto o form
702:                         *   existe.
703:                         loc_oBusca.Release()
704:                         loc_oBusca = .NULL.
705:                     ENDIF
706:                 ENDIF
707:             ENDIF
708:         CATCH TO loc_oErro
709:             MsgErro(loc_oErro.Message + CHR(13) + "Linha: " + TRANSFORM(loc_oErro.LineNo) + ;
710:                 CHR(13) + "Procedure: " + loc_oErro.Procedure, ;
711:                 "Busca de Opera" + CHR(231) + CHR(227) + "o de Estoque")
712:         ENDTRY
713: 
714:         IF USED("cursor_4c_BuscaOpe")
715:             USE IN cursor_4c_BuscaOpe
716:         ENDIF
717: 
718:         IF NOT EMPTY(loc_cAliasAnt) AND USED(loc_cAliasAnt)
719:             SELECT (loc_cAliasAnt)
720:         ENDIF
721:     ENDPROC
722: 
723:     *====================================================================
724:     * BtnOkClick - Command1.Click legado, transcrito LITERALMENTE:
725:     *
726:     *   If Empty(ThisForm.DopEstq.Value)
727:     *       MessageBox('Operacao Invalida !!!',48,'Campo Obrigatorio')
728:     *       ThisForm.DopEstq.SetFocus
729:     *   EndIf
730:     *   ThisForm.Release
731:     *   Return(.T.)
732:     *
733:     * ATENCAO - o Release do legado esta FORA do IF: o dialogo avisa que
734:     * a Operacao eh invalida, chama SetFocus (que nao tem efeito algum,
735:     * porque a tela fecha logo depois) e FECHA DO MESMO JEITO, com o
736:     * campo vazio. Isso NAO eh descuido desta migracao nem descuido do
737:     * legado: campo vazio eh justamente o canal de CANCELAMENTO que o
738:     * chamador le ("caso nao tenha escolhido a operacao cancel o
739:     * processamento...", SIGCDBAL_form_codigo_fonte.txt:6016-6019). Por
740:     * isso o fechamento incondicional eh MANTIDO (PILAR 1) - o que nao
741:     * pode faltar eh a PUBLICACAO do resultado, abaixo.
742:     *
743:     * MessageBox(...,48,...) -> MsgAviso (mesmo icone 48; MESSAGEBOX
744:     * direto eh proibido no projeto e nao se suprime em modo de teste).
745:     *
746:     * Hide() e NAO Release(): com Release() o form se destroi junto com o
747:     * this_oBusinessObject, e o chamador - que acabou de desbloquear do
748:     * Show() modal - NAO TEM MAIS COMO LER a Operacao escolhida. O
749:     * FormParaBO() sozinho nao resolve: ele grava numa instancia de BO
750:     * que morre na mesma linha. Canonico do projeto para dialogo que
751:     * devolve valor: formbuscaauxiliar.prg:367-369 (BtnSelecionarClick =
752:     * flag + Hide(); quem solta eh o chamador). Sem isso o dialogo
753:     * "funciona" na tela e devolve NADA - falha silenciosa, sem erro e
754:     * sem log, exatamente a familia das regras #20/#42.
755:     *====================================================================
756:     PROCEDURE BtnOkClick()
757:         LOCAL loc_cValor
758:         loc_cValor = ALLTRIM(NVL(THIS.txt_4c_DopEstq.Value, ""))
759: 
760:         THIS.FormParaBO()
761: 
762:         IF EMPTY(loc_cValor)
763:             MsgAviso("Opera" + CHR(231) + CHR(227) + "o Inv" + CHR(225) + "lida !!!", ;
764:                 "Campo Obrigat" + CHR(243) + "rio")
765:             THIS.txt_4c_DopEstq.SetFocus()
766: 
767:             *-- Campo vazio EH o canal de cancelamento do legado, entao
768:             *   passa pelo MESMO funil do cancelamento - nao existem duas
769:             *   versoes do que "cancelar" faz.
770:             THIS.BtnCancelarClick()
771:         ELSE
772:             THIS.PublicarOperacaoEscolhida(loc_cValor)
773:         ENDIF
774: 
775:         THIS.Hide()
776:     ENDPROC
777: 
778:     *====================================================================
779:     * BtnCancelarClick - Funil UNICO de cancelamento.
780:     *
781:     * NAO eh botao novo: o SCX nao tem Cancelar, e inventar um violaria o
782:     * PILAR 1. Este eh o NOME do caminho de cancelamento que o legado JA
783:     * tem - sair do dialogo com o campo vazio -, extraido para um metodo
784:     * porque ha mais de uma entrada para ele (o Ok com campo em branco e
785:     * a morte da tela sem confirmacao, via QueryUnload) e porque o que
786:     * ele faz nao eh "nada": tem de deixar o CHAMADOR enxergando o
787:     * cancelamento.
788:     *
789:     * O chamador testa "Not Used('crOpera') Or IsEmpty(crOpera.Dopes)"
790:     * (SIGCDBAL_form_codigo_fonte.txt:6016). Como ele faz "Go Top" em
791:     * crOpera ao montar o cursor (SIGCDBAL:5484), NAO mexer na posicao
792:     * deixaria o cursor na PRIMEIRA operacao e o chamador leria o
793:     * cancelamento como "o usuario escolheu a operacao 1" - gravacao
794:     * errada, sem erro e sem log. Por isso cancelar passa valor VAZIO
795:     * para PublicarOperacaoEscolhida, que empurra crOpera para EOF: o
796:     * unico estado em que crOpera.Dopes le vazio.
797:     *
798:     * O campo digitado NAO eh apagado aqui (regras #37/#50) - quem
799:     * cancela ja esta saindo, e limpar a tela na saida nao ajuda
800:     * ninguem; o que vale eh o contrato publicado.
801:     *====================================================================
802:     PROCEDURE BtnCancelarClick()
803:         THIS.PublicarOperacaoEscolhida("")
804:     ENDPROC
805: 
806:     *====================================================================
807:     * PublicarOperacaoEscolhida - Entrega o resultado do dialogo nos DOIS
808:     * canais, porque o legado usa um e o sistema novo usa o outro:
809:     *
810:     *  (a) properties this_lConfirmado / this_cDopEstqSelecionado - o que
811:     *      um chamador MIGRADO le depois do Show() (ver o contrato
812:     *      transcrito no bloco de properties).
813:     *
814:     *  (b) o cursor "crOpera" do CHAMADOR, POSICIONADO - o canal do
815:     *      legado. O Valid legado fazia "Select CrOpera / Seek(...)" e
816:     *      era essa POSICAO que o SIGCDBAL lia em seguida, inclusive uma
817:     *      coluna que este dialogo nem exibe (crOpera.Estoqs,
818:     *      SIGCDBAL_form_codigo_fonte.txt:6132).
819:     *
820:     * O crOpera NAO eh criado aqui - ele eh do chamador (query FILTRADA:
821:     * "Where Parcs <> 1 And Opers = 3 And DigItens = 1 And Caixas <> 1").
822:     * Criar um cursor homonimo de 1 linha mascararia a lista filtrada do
823:     * chamador e faria o fluxo seguinte ler dado errado; por isso o canal
824:     * (b) so eh usado quando o cursor JA esta aberto, como no legado.
825:     *
826:     * POSICIONAR vale para os DOIS desfechos, e esse eh o ponto fino
827:     * (entrega (2) da Fase 8):
828:     *
829:     *   CONFIRMOU -> crOpera na linha escolhida.
830:     *   CANCELOU  -> crOpera em EOF. O chamador decide por
831:     *                "IsEmpty(crOpera.Dopes)" (SIGCDBAL:6016), e ele
832:     *                mesmo deu "Go Top" no cursor ao monta-lo
833:     *                (SIGCDBAL:5484): deixar a posicao intacta faria o
834:     *                cancelamento ser lido como "escolheu a PRIMEIRA
835:     *                operacao da lista". EOF eh o unico estado em que
836:     *                crOpera.Dopes le vazio - e LOCATE FOR .F. eh a
837:     *                forma de chegar la sem depender de indice nem do
838:     *                cursor ter registros.
839:     *
840:     * Codigo que NAO esta em crOpera tambem cai no ramo de cancelamento,
841:     * pelo mesmo motivo: o cursor ficaria parado onde estava e o chamador
842:     * leria a linha de OUTRA operacao sem perceber (regra #17). Com o

*-- Linhas 849 a 1012:
849:     * nao casa de forma confiavel (regra do INDEX/SEEK parcial). O LOCATE
850:     * por ALLTRIM compara o valor util e nao depende de indice nenhum.
851:     *====================================================================
852:     PROCEDURE PublicarOperacaoEscolhida(par_cValor)
853:         LOCAL loc_cValor, loc_lOk, loc_cAliasAnt, loc_oErro
854:         loc_cValor    = IIF(VARTYPE(par_cValor) = "C", ALLTRIM(par_cValor), "")
855:         loc_lOk       = NOT EMPTY(loc_cValor)
856:         loc_cAliasAnt = ALIAS()
857: 
858:         *-- Canal (b): posiciona o cursor do chamador, se ele existir.
859:         IF USED("crOpera") AND TYPE("crOpera.Dopes") = "C"
860:             TRY
861:                 SELECT crOpera
862: 
863:                 IF loc_lOk
864:                     LOCATE FOR UPPER(ALLTRIM(NVL(crOpera.Dopes, ""))) == UPPER(loc_cValor)
865: 
866:                     IF NOT FOUND()
867:                         loc_lOk = .F.
868:                         MsgAviso("Opera" + CHR(231) + CHR(227) + "o [" + loc_cValor + ;
869:                             "] n" + CHR(227) + "o est" + CHR(225) + " dispon" + CHR(237) + ;
870:                             "vel para esta atualiza" + CHR(231) + CHR(227) + "o.", ;
871:                             "Opera" + CHR(231) + CHR(227) + "o Inv" + CHR(225) + "lida")
872:                     ENDIF
873:                 ENDIF
874: 
875:                 *-- Cancelamento (campo vazio, ou codigo fora do universo
876:                 *   do chamador): EOF, para crOpera.Dopes ler vazio. O
877:                 *   LOCATE acima ja deixa o cursor em EOF quando nao
878:                 *   encontra, mas o caminho do campo VAZIO nao passa por
879:                 *   ele - entao o reposicionamento tem de ser explicito.
880:                 IF NOT loc_lOk
881:                     LOCATE FOR .F.
882:                 ENDIF
883:             CATCH TO loc_oErro
884:                 loc_lOk = .F.
885:                 MsgErro(loc_oErro.Message + CHR(13) + "Linha: " + ;
886:                     TRANSFORM(loc_oErro.LineNo) + CHR(13) + "Procedure: " + ;
887:                     loc_oErro.Procedure, "Opera" + CHR(231) + CHR(227) + ;
888:                     "o para Atualiza" + CHR(231) + CHR(227) + "o")
889:             ENDTRY
890: 
891:             IF NOT EMPTY(loc_cAliasAnt) AND USED(loc_cAliasAnt)
892:                 SELECT (loc_cAliasAnt)
893:             ENDIF
894:         ENDIF
895: 
896:         *-- Canal (a): properties lidas pelo chamador migrado.
897:         THIS.this_lConfirmado         = loc_lOk
898:         THIS.this_cDopEstqSelecionado = IIF(loc_lOk, loc_cValor, "")
899:     ENDPROC
900: 
901: 
902:     *====================================================================
903:     * FormParaBO - Copia o unico campo de tela (txt_4c_DopEstq) para a
904:     * property correspondente do BO (this_cDopEstq / SigCdOpe.dopes).
905:     * PROTECTED como em FormBase: metodo protegido na base PREVALECE
906:     * sobre override sem modificador na subclasse (regra #51), entao
907:     * tentar "alargar" o escopo aqui seria ilusorio - o metodo eh
908:     * chamado so de dentro da classe (BtnOkClick).
909:     *====================================================================
910:     PROTECTED FUNCTION FormParaBO()
911:         LOCAL loc_lResultado
912:         loc_lResultado = .F.
913: 
914:         IF VARTYPE(THIS.this_oBusinessObject) = "O"
915:             THIS.this_oBusinessObject.this_cDopEstq = ;
916:                 ALLTRIM(NVL(THIS.txt_4c_DopEstq.Value, ""))
917:             loc_lResultado = .T.
918:         ENDIF
919: 
920:         RETURN loc_lResultado
921:     ENDFUNC
922: 
923:     *====================================================================
924:     * BOParaForm - Contraparte do FormParaBO: leva a property do BO
925:     * (this_cDopEstq / SigCdOpe.dopes) para o unico campo de tela.
926:     *
927:     * PROTECTED porque FormBase ja declara o hook assim, e PROTECTED na
928:     * base PREVALECE sobre override sem modificador na subclasse (regra
929:     * #51) - declarar sem o modificador daria a ILUSAO de metodo
930:     * publico. Os dois call sites sao internos: LimparCampos (estado
931:     * inicial, via InicializarForm) e qualquer recarga futura.
932:     *
933:     * Atribuir .Value sempre com string (NVL + ALLTRIM): TextBox criado
934:     * com .Value = "" eh CARACTERE, e deixar um .NULL. do banco chegar
935:     * ali trocaria o tipo do controle.
936:     *====================================================================
937:     PROTECTED FUNCTION BOParaForm()
938:         LOCAL loc_lResultado
939:         loc_lResultado = .F.
940: 
941:         IF VARTYPE(THIS.this_oBusinessObject) = "O"
942:             THIS.txt_4c_DopEstq.Value = ;
943:                 ALLTRIM(NVL(THIS.this_oBusinessObject.this_cDopEstq, ""))
944:             THIS.txt_4c_DopEstq.Refresh()
945:             loc_lResultado = .T.
946:         ENDIF
947: 
948:         RETURN loc_lResultado
949:     ENDFUNC
950: 
951:     *====================================================================
952:     * LimparCampos - Repoe o estado inicial do dialogo.
953:     *
954:     * NAO eh o LimparCampos de form CRUD (que alterna entre modo de
955:     * edicao e modo lista - aqui nao ha modos). Eh o ponto UNICO que
956:     * devolve a tela ao estado de abertura, e por isso cuida das TRES
957:     * coisas que compoem esse estado, nao so do campo:
958:     *
959:     *   1. o campo, que vem do BO (BOParaForm) e nao de um "" literal -
960:     *      assim a tela e a property nunca divergem;
961:     *   2. o memo de valor-ja-validado, que precisa voltar ao sentinela
962:     *      CHR(0) e nao a "": com "" o campo em branco passaria a contar
963:     *      como "ja validado" e a PRIMEIRA validacao nao aconteceria;
964:     *   3. o contrato de retorno, que tem de voltar a "nao confirmado" -
965:     *      resto de uma confirmacao anterior lido por um chamador novo
966:     *      eh exatamente a falha silenciosa que a Fase 8 veio fechar.
967:     *
968:     * NAO mexe em crOpera: o cursor eh do CHAMADOR e so
969:     * PublicarOperacaoEscolhida tem motivo para reposiciona-lo.
970:     *====================================================================
971:     PROTECTED PROCEDURE LimparCampos()
972:         THIS.this_cUltimoDopEstqValidado = CHR(0)
973:         THIS.this_lConfirmado            = .F.
974:         THIS.this_cDopEstqSelecionado    = ""
975:         THIS.this_lEmLookup              = .F.
976: 
977:         THIS.BOParaForm()
978:     ENDPROC
979: 
980:     *====================================================================
981:     * Metodos CRUD-canonicos que NAO se aplicam a este dialogo (analise
982:     * fechada desde a Fase 3 e reconfirmada na consolidacao). SigOpAtu
983:     * eh um dialogo modal UNICO (1 campo + 1 botao), sem
984:     * Page1(Lista)/Page2(Dados), sem lista de registros e sem modos
985:     * INCLUIR/ALTERAR/VISUALIZAR/EXCLUIR:
986:     *
987:     *   BtnSalvarClick/BtnBuscarClick/BtnEncerrarClick - convencao de
988:     *     form CRUD (Page1 "Lista" com Buscar/Encerrar, Page2 "Dados"
989:     *     com Salvar/Cancelar). O unico botao deste legado se chama
990:     *     "Ok" (Command1/cmd_4c_Command1 + BtnOkClick, Fase 6/8), e ele
991:     *     NAO grava: SigCdOpe eh consultada, nunca escrita por esta
992:     *     tela (ver cabecalho do SigOpAtuBO.prg).
993:     *   CarregarLista/AjustarBotoesPorModo - pressupoem grid de LISTA e
994:     *     modo atual (this_cModoAtual). analise.json confirma
995:     *     temGrid=false; layout.json nao declara nenhum BaseClass
996:     *     grid/pageframe. O cursor que a Fase 8 passou a montar
997:     *     (CarregarUniversoOperacoes) NAO eh uma lista da tela: ele
998:     *     existe so enquanto o picker esta aberto e eh fechado em
999:     *     seguida.
1000:     *   HabilitarCampos - pressupoe alternancia entre modo de edicao e
1001:     *     modo de consulta. Aqui ha UM campo, sempre editavel, e UM
1002:     *     fluxo: o dialogo abre, o usuario digita ou escolhe a Operacao
1003:     *     e confirma. Um HabilitarCampos aqui so poderia ser metodo sem
1004:     *     chamador - stub, que o pipeline proibe.
1005:     *
1006:     * BtnCancelarClick e LimparCampos SAIRAM desta lista na Fase 8: os
1007:     * dois ganharam conteudo e call site reais (ver cada um acima).
1008:     *====================================================================
1009: 
1010:     *====================================================================
1011:     * QueryUnload - Ultima linha de defesa do contrato de retorno.
1012:     *

*-- Linhas 1022 a 1050:
1022:     * por aqui, e sem a guarda o EOF apagaria a escolha que acabou de
1023:     * ser publicada.
1024:     *====================================================================
1025:     PROCEDURE QueryUnload()
1026:         IF NOT THIS.this_lConfirmado
1027:             THIS.BtnCancelarClick()
1028:         ENDIF
1029: 
1030:         RETURN DODEFAULT()
1031:     ENDPROC
1032: 
1033:     *====================================================================
1034:     * Destroy - Fecha o cursor do picker (AbrirLookupDopEstq ja o fecha
1035:     * no caminho normal; aqui cobre a saida por excecao) e delega ao
1036:     * FormBase, que libera o Business Object e rebuilda os popups do
1037:     * menu principal (fix menu-shrinks de forms modais).
1038:     *
1039:     * crOpera NAO eh fechado: o cursor eh do CHAMADOR, que continua
1040:     * lendo dele depois que este dialogo morre.
1041:     *====================================================================
1042:     PROCEDURE Destroy()
1043:         IF USED("cursor_4c_BuscaOpe")
1044:             USE IN cursor_4c_BuscaOpe
1045:         ENDIF
1046: 
1047:         DODEFAULT()
1048:     ENDPROC
1049: 
1050: ENDDEFINE


### BO (C:\4c\projeto\app\classes\SigOpAtuBO.prg):
*============================================================================
* SigOpAtuBO.prg - Business Object para o dialogo "Operacao para Atualizacao"
*
* Tabela principal : SigCdOpe  (PK: dopes char(20) - coluna unica, codigo
*                     e descricao ao mesmo tempo - regra CLAUDE.md
*                     "SigCdOpe eh single-column")
*
* Este BO suporta um dialogo OPERACIONAL simples (SIGOPATU no legado): o
* usuario informa/seleciona o codigo de uma Operacao de Estoque ja
* cadastrada em SigCdOpe e confirma. Nao ha INSERT/UPDATE/DELETE no legado -
* o unico codigo-fonte do dialogo (Comando1.Click e DopEstq.Valid, ver
* tasks\task643\comportamento.json) apenas valida o valor digitado contra o
* cursor CrOpera (Seek) e, se nao encontrar, abre o picker (fwBuscaInt) para
* escolha; o botao "Ok" so confere que o campo nao esta vazio e libera o
* form. Nao ha AddCursor nem TABLEUPDATE: SigCdOpe eh consultada, nunca
* gravada, por esta tela.
*
* Fase 2/8: Inserir() e Atualizar() permanecem SEM override - o
* comportamento padrao herdado de BusinessBase (recusar a operacao) ja eh o
* correto para este BO, porque inventar um INSERT/UPDATE em SigCdOpe aqui
* violaria a regra de que a lista de colunas vem do schema/legado, nunca de
* suposicao, e este dialogo nunca grava naquela tabela.
*
* Herda de: BusinessBase
* Criado em: Fase 1 - Propriedades e Init
* Completado em: Fase 2 - CarregarDoCursor() e ObterChavePrimaria()
*============================================================================

DEFINE CLASS SigOpAtuBO AS BusinessBase

    *==========================================================================
    * Propriedade da entidade SigCdOpe (chave e descricao, na mesma coluna)
    *==========================================================================
    this_cDopEstq = ""   && char(20) - Operacao de Estoque (SigCdOpe.dopes)

    *==========================================================================
    * Init - Inicializa o Business Object configurando tabela e chave primaria
    *==========================================================================
    PROCEDURE Init()
        LOCAL loc_lResultado
        loc_lResultado = .F.

        TRY
            *-- A tabela TEM de ir no DODEFAULT: BusinessBase.Init() so cria
            *-- this_oDataAccess quando recebe pcTabela. Com DODEFAULT() vazio
            *-- o objeto de acesso a dados fica .NULL. e todo metodo herdado
            *-- que depende dele (Buscar) devolve .F. com "Objeto de acesso a
            *-- dados nao inicializado".
            DODEFAULT("SigCdOpe")
            THIS.this_cTabela     = "SigCdOpe"
            THIS.this_cCampoChave = "dopes"
            loc_lResultado = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * ObterChavePrimaria - Retorna a chave primaria (dopes)
    *==========================================================================
    PROTECTED PROCEDURE ObterChavePrimaria()
        RETURN ALLTRIM(THIS.this_cDopEstq)
    ENDPROC

    *==========================================================================
    * CarregarDoCursor - Carrega this_cDopEstq a partir de um cursor que
    * contenha a coluna dopes (regra CLAUDE.md #9: SELECT (par_cAliasCursor)
    * antes de acessar os campos, nunca campo)
    *==========================================================================
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lResultado
        loc_lResultado = .F.

        IF !EMPTY(par_cAliasCursor) AND USED(par_cAliasCursor)
            SELECT (par_cAliasCursor)
            THIS.this_cDopEstq = TratarNulo(dopes, "C")
            loc_lResultado = .T.
        ENDIF

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * ExisteOperacao - Confere se o codigo informado existe em SigCdOpe.
    * Usado pelo Form (Valid/LostFocus do campo DopEstq) para reproduzir o
    * Seek(This.Value, 'CrOpera') do legado antes de abrir o picker
    * FormBuscaAuxiliar - regra CLAUDE.md "SigCdOpe eh single-column"
    * (NUNCA referenciar descrs/Descrs: dopes eh codigo E descricao).
    *==========================================================================
    FUNCTION ExisteOperacao(par_cCodigo)
        LOCAL loc_nResultado, loc_lExiste
        loc_lExiste = .F.

        IF EMPTY(par_cCodigo)
            RETURN .F.
        ENDIF

        IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
            RETURN .F.
        ENDIF

        IF USED("cursor_4c_SigOpAtu_Existe")
            USE IN cursor_4c_SigOpAtu_Existe
        ENDIF

        loc_nResultado = SQLEXEC(gnConnHandle, ;
            "SELECT Dopes FROM SigCdOpe WHERE Dopes = " + EscaparSQL(ALLTRIM(par_cCodigo)), ;
            "cursor_4c_SigOpAtu_Existe")

        IF loc_nResultado > 0
            loc_lExiste = (RECCOUNT("cursor_4c_SigOpAtu_Existe") > 0)
        ENDIF

        IF USED("cursor_4c_SigOpAtu_Existe")
            USE IN cursor_4c_SigOpAtu_Existe
        ENDIF

        RETURN loc_lExiste
    ENDFUNC

ENDDEFINE


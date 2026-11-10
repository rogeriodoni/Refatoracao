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

### FORM (C:\4c\projeto\app\forms\operacionais\FormSigOpNFd.prg) - TRECHOS RELEVANTES PARA PASS FUNCTIONAL (1541 linhas total):

*-- Linhas 54 a 97:
54: *                          correcao)
55: *
56: * FASE 3/8 - ESTRUTURA BASE: esqueleto do form (propriedades visuais,
57: * Init/InicializarForm, BO e o cabecalho). CONCLUIDA.
58: *
59: * FASE 4/8 - BOTOES DE ACAO (ramo FLAT, sem grid): cnt_4c_Botoes com os 2
60: * botoes reais do legado (Enviar = btnSelItens.Click, Cancelar = btnSair.
61: * Click). CONCLUIDA. BtnCancelarClick() reproduz o legado por completo
62: * (reabilita o form pai + Release). BtnEnviarClick() reproduz a guarda de
63: * descricao minima (regra #17 do CLAUDE.md - guard transcrito literalmente)
64: * e grava o evento via SigOpNFdBO.Salvar() (Inserir() ja implementado na
65: * Fase 2). O restante do fluxo legado (contexto da nota via SQLEXEC proprio,
66: * SAT.dll/DarumaFramework.dll, protocolo de arquivos da UniNFe, e-mail,
67: * Gerarnota) ainda NAO existe em nenhum ponto do projeto - documentado no
68: * cabecalho de BtnEnviarClick() e no cabecalho de SigOpNFdBO.prg
69: * ("fases seguintes"), nao e omissao silenciosa (regra fundamental do
70: * CLAUDE.md).
71: *
72: * FASE 5/8 - CAMPOS PRINCIPAIS (ramo FLAT, "Parte 1" dos campos restantes):
73: * cnt_4c_Observacao (descricao do evento - lbl_4c_LblEve + obj_4c_GetDesc),
74: * cnt_4c_NFe (numero da nota - lbl_4c_LblEmiss + txt_4c_Nfe, somente
75: * exibicao, When = .F. no dump) e cnt_4c_Data (data/hora do evento -
76: * lbl_4c_LblEntregas + txt_4c_Data, editavel, When = .T. no dump, valor
77: * inicial = DATETIME() como no Init legado - "thisform.cntData.getData.
78: * Value = ttoc(DATEtime())"). CONCLUIDA. BtnEnviarClick() agora le a
79: * descricao do CONTROLE real (obj_4c_GetDesc.Value) em vez de ler
80: * this_cNfedesc direto do BO (o container nao existia nas fases
81: * anteriores - comentario da Fase 4 ja sinalizava esta pendencia).
82: *
83: * FASE 6/8 - CAMPOS RESTANTES (ramo FLAT, "Parte 2" - sem lookups: este
84: * form nao tem nenhum fwBuscaExt/sigacess no dump, todos os campos sao
85: * somente exibicao ou digitacao direta). ConfigurarCamposRestantes()
86: * adiciona os ultimos filhos diretos do form: cnt_4c_Seq (sequencia do
87: * evento, somente exibicao, When = .F. no dump - igual a cnt_4c_NFe),
88: * txt_4c_Evento (GetEvento - rotulo do evento, somente exibicao,
89: * populado a partir de this_cRotuloCancelamento/this_cRotuloCarta
90: * conforme this_cEvento, igual ao "IF thisform.Evento = 'CAN' ...
91: * thisform.getEvento.Value = ..." do Init legado), chk_4c_Refazer e
92: * chk_4c_Verao (CheckBox). CONCLUIDA.
93: *
94: * VALIDACAO DOS CAMPOS DIGITAVEIS (a parte "lookups" desta fase): o dump
95: * NAO tem lookup algum - zero fwBuscaExt/fwBuscaSel/fwBuscaInt/sigacess/
96: * mAddColuna/Acesso*() -, e nenhum campo referencia tabela auxiliar.
97: * Criar AbrirLookup*/AbrirBusca* aqui seria inventar picker e tabela que o

*-- Linhas 114 a 233:
114: *     converte.
115: *
116: * Ambos em "LostFocus", nunca "KeyPress" (regra #47), e o de data com
117: * guarda de reentrancia (wrapper + Exec), porque MsgAviso e modal.
118: *
119: * Tambem adiciona o equivalente ao atucur() legado:
120: * AtualizarCursorEvento() no Form (chamado no fim de InicializarForm,
121: * mesma posicao do "thisform.atucur()" no Init legado, e em
122: * ChkRefazerClick quando o Refazer esta desmarcado ou nao acha evento
123: * anterior) delega a SigOpNFdBO.AtualizarUltimoEvento()/
124: * ConsultarUltimoEvento() (metodos novos). Como no legado, atucur NAO
125: * persiste nada: ele so PREPARA o registro (o "APPEND BLANK + replace" do
126: * legado mexe apenas no cursor em memoria) e define o modo do BO -
127: * NovoRegistro no ramo de linha nova, EditarRegistro no ramo de reuso do
128: * evento 'CAN'. Quem grava e BtnEnviarClick, uma vez, com a descricao
129: * final - igual ao "replace nfedesc with lcdesc" + Update + Commit do
130: * Click legado.
131: *
132: * Estes metodos tem uma GUARDA explicita contra this_cNfiEmpDopNums
133: * vazio: a leitura do CONTEXTO da nota (SigMvNfi, via DataSession
134: * compartilhada no legado) ainda nao existe em nenhuma fase deste BO -
135: * mesma pendencia ja documentada em BtnEnviarClick() e no cabecalho de
136: * SigOpNFdBO.prg. Sem a chave da nota, gravar um evento deixaria
137: * empdopnums/emps/nfis em branco (pior que nao gravar nada) - por isso a
138: * guarda, e nao e omissao silenciosa: esta documentada nos tres lugares
139: * (aqui, no BO e em BtnEnviarClick).
140: *
141: * Refazer.Click legado (linhas 1759-1782 do dump) e reproduzido em
142: * ChkRefazerClick(): marcado, consulta o ultimo evento e so cria
143: * sequencia nova se nao achar nenhum; desmarcado, sempre atualiza (cria
144: * sequencia nova). Verao nao tem Click no legado - e lido direto no
145: * fuso horario do evento (linha 1142 do dump); aqui ChkVeraoChange()
146: * espelha o estado no BO (this_lHorarioVerao/this_cFusoHorario) a cada
147: * mudanca, para BtnEnviarClick usar o valor atual quando a fase que monta
148: * o XML do evento for implementada.
149: *
150: * FASE 7/8 - EVENTOS PRINCIPAIS DOS BOTOES: medido no dump (SECAO 1 -
151: * ESTRUTURA + grep por "^PROCEDURE"/".Click") que o unico objeto com
152: * BaseClass commandbutton/commandgroup e cntBotoes (Registro 10,
153: * ButtonCount = 2), e os UNICOS dois "PROCEDURE *.Click" do arquivo
154: * inteiro sao btnSelItens.Click (linha 977, 700 linhas) e btnSair.Click
155: * (linha 1683, 3 linhas) - ja portados na FASE 4/8 (BtnEnviarClick /
156: * BtnCancelarClick, acima). Nao ha Grupo_Op, nao ha pcEscolha, nao ha
157: * herranca de frmcadastro/frmrelatorio e nao ha NENHUMA ocorrencia de
158: * Incluir/Alterar/Visualizar/Excluir/Inserir no dump - o SIGOPNFD e um
159: * dialogo de UMA acao (Enviar) + Cancelar, nao um cadastro CRUD. Criar
160: * BtnIncluirClick/BtnAlterarClick/BtnVisualizarClick/BtnExcluirClick
161: * aqui inventaria botoes e fluxo que o legado nunca teve (violaria o
162: * PILAR 1 e a regra fundamental "nunca inventar funcionalidade").
163: *
164: * Re-auditoria dos pares BINDEVENT+handler (ja entregues nas fases
165: * anteriores), conferida nesta fase:
166: *   - Buttons(1)/Buttons(2) de cnt_4c_Botoes -> BtnEnviarClick/
167: *     BtnCancelarClick: ambos PUBLIC (sem PROTECTED - regra #3), ambos
168: *     com BINDEVENT("Click", ...) chamado DEPOIS do WITH que configura
169: *     os Buttons (ConfigurarBotoesAcao);
170: *   - Buttons(2).Cancel = .T. cobre o ESC (equivalente ao btnSair do
171: *     legado, que tambem e o botao de cancelamento do CommandGroup);
172: *   - BtnCancelarClick usa THIS.Release() (nao Hide()) - dialogo modal
173: *     sem valor de retorno para o chamador ler depois de fechado, igual
174: *     ao "Thisform.Release" do legado;
175: *   - chk_4c_Refazer/chk_4c_Verao -> ChkRefazerClick/ChkVeraoChange:
176: *     idem PUBLIC, BINDEVENT apos o WITH (ConfigurarCamposRestantes);
177: *   - obj_4c_GetDesc/txt_4c_Data -> ValidarDescricaoEvento/
178: *     ValidarDataEvento: BINDEVENT em "LostFocus" (regra #47), nunca
179: *     "KeyPress";
180: *   - properties que os handlers tocam (this_cNfedesc, this_dNfedte,
181: *     this_nTamMinDescricao, this_cNfis, this_nNfeseq, this_lRefazer,
182: *     this_lHorarioVerao, this_cFusoHorario) conferidas DECLARADAS em
183: *     SigOpNFdBO.prg (Fase 1) - nenhuma e dinamica;
184: *   - this_cMensagemErro conferida em BusinessBase (heranca);
185: *   - .Picture dos dois botoes (cadastro_salvar_60.jpg,
186: *     cadastro_sair_60.jpg) e do form (new_background.jpg) conferidos
187: *     existentes em vbmp\ (regra #25 - .Picture inexistente falha em
188: *     silencio).
189: *
190: * Metodo Load do legado (linha 948 do dump: "&&Do Parametros_Iniciais")
191: * e comentario puro, sem codigo - nao ha o que portar. Zero outro
192: * evento no dump (zero Grid, zero KeyPress/Valid alem dos dois ja
193: * cobertos, zero InteractiveChange alem de Verao) alcanca a tela sem
194: * ja estar coberto pelas fases anteriores.
195: *
196: * FASE 8/8 - EVENTOS AUXILIARES E CONSOLIDACAO FINAL. Entrega os hooks
197: * canonicos do projeto, cada um com o conteudo REAL que o legado tem, e
198: * elimina a duplicacao que as fases 6/7 deixaram (o mesmo bloco de
199: * espelhamento BO -> controles aparecia COPIADO em AtualizarCursorEvento
200: * e em ChkRefazerClick - CLAUDE.md #44, item 6: fonte unica):
201: *
202: *   FormParaBO()  - controles -> BO. Mapeia os QUATRO controles que o
203: *     legado le de volta (todos os sites do dump): getDesc (linhas 999 e
204: *     1120), getData (CTOT nas linhas 571, 1220 e 1469), Refazer (linhas
205: *     1310 e 1519) e Verao (linha 1142). getNfe/getSeq/GetEvento NAO
206: *     entram: tem "When -> Return .f." no dump, sao somente EXIBICAO e o
207: *     legado nunca le o valor deles - ler um campo de exibicao de volta
208: *     sobrescreveria a property com o que o proprio BO acabou de escrever
209: *     nele (e com BRANCO antes da primeira carga).
210: *
211: *   BOParaForm(par_nSequencia) - BO -> controles. E o bloco final do
212: *     atucur legado (linhas 577-579) e o do ramo "achou evento" do
213: *     Refazer.Click (linhas 1771-1775), que sao o MESMO bloco com UMA
214: *     diferenca: a sequencia exibida. No atucur e lnUltSeq (ultimo + 1);
215: *     no Refazer e crSigMvNfd.nfeseq (a do evento encontrado, SEM o + 1).
216: *     Dai o parametro - sem ele a consolidacao dos dois perderia essa
217: *     distincao do legado em silencio.
218: *
219: *   CarregarLista() - funil publico de carga (nome canonico do projeto,
220: *     que o harness de teste chama de FORA da classe, por isso PUBLIC -
221: *     regra #3/#51): delega a AtualizarCursorEvento(), que e o atucur.
222: *     NAO ha grade neste form (layout.json nao declara nenhum objeto
223: *     baseClass=grid), logo nao ha RecordSource/GO TOP/Grid.Refresh a
224: *     fazer - o equivalente aqui e a consulta do ultimo evento mais o
225: *     THIS.Refresh() do fim do atucur. Mesmo padrao de funil de
226: *     FormSigOpNch.CarregarLista() -> CarregarGrade().
227: *
228: *   HabilitarCampos(par_lHabilitar) - fonte UNICA do estado Enabled dos
229: *     controles, derivado do When de cada um no dump: getDesc e getData
230: *     ("When -> Return .t.") acompanham o parametro; getNfe, getSeq e
231: *     GetEvento ("When -> Return .f.") ficam SEMPRE desabilitados, em
232: *     qualquer valor do parametro. PUBLIC porque o harness de teste a
233: *     chama de fora da classe.

*-- Linhas 259 a 302:
259: *   - BtnSalvarClick / BtnBuscarClick / BtnEncerrarClick: o SIGOPNFD tem
260: *     EXATAMENTE DOIS botoes (cntBotoes.Command1 "\<Enviar" =
261: *     btnSelItens, cntBotoes.Command2 "\<Cancelar" = btnSair) e os
262: *     UNICOS dois "PROCEDURE *.Click" do dump sao os desses dois - ja
263: *     portados como BtnEnviarClick/BtnCancelarClick. Nao existe
264: *     Salvar/Buscar/Encerrar no legado; o botao que GRAVA e o Enviar, e
265: *     o handler leva o nome da acao dele.
266: *   - AjustarBotoesPorModo: nao ha MODO neste dialogo (zero pcEscolha,
267: *     zero frmcadastro, zero Grupo_Op no dump) e nao ha uma unica
268: *     atribuicao a ".Enabled"/".Visible" de controle em todo o legado -
269: *     as duas ocorrencias de "Enabled" sao "ParentForm.Enabled = .T."
270: *     (linhas 907 e 1684), que ja estao em HabilitarFormPai. Os dois
271: *     botoes ficam sempre habilitados.
272: *   - AlternarPagina: form FLAT, sem PageFrame (ver PILAR 3 acima).
273: *
274: * Herda de: FormBase
275: *==============================================================================
276: 
277: DEFINE CLASS FormSigOpNFd AS FormBase
278: 
279:     *-- Propriedades visuais (pixel-perfect SCX original - PILAR 1)
280:     Width       = 758
281:     Height      = 387
282:     AutoCenter  = .T.
283:     Caption     = "Eventos NFe"
284:     ShowWindow = 1
285:     ControlBox  = .F.
286:     MaxButton   = .F.
287:     MinButton   = .F.
288:     Movable     = .F.
289:     KeyPreview  = .T.
290:     TitleBar    = 0
291:     WindowType  = 1
292:     WindowState = 0
293:     AlwaysOnTop = .F.
294:     BorderStyle = 2
295:     ShowTips    = .T.
296:     DataSession = 2
297: 
298:     *-- Referencias ao form pai (pForm1/pForm2 do legado) e ao BO
299:     this_oFormPai        = .NULL.
300:     this_oFormPai2       = .NULL.
301:     this_nDataSessionPai = 0
302:     this_oBusinessObject = .NULL.

*-- Linhas 316 a 445:
316:     this_cDataEventoAnterior = ""
317: 
318:     *-- Guarda de reentrancia dos handlers de LostFocus que exibem dialogo
319:     *-- (regra #37/#47 do CLAUDE.md): MsgAviso eh MODAL, tira o foco do
320:     *-- campo e faz o proprio LostFocus disparar de novo.
321:     this_lEmValidacao = .F.
322: 
323:     *==========================================================================
324:     * Init - Armazena os parametros recebidos do form pai antes de DODEFAULT
325:     * (equivalente ao Lparameters pForm1, pForm2, pDId, pEvento do legado).
326:     *==========================================================================
327:     PROCEDURE Init(par_oFormPai, par_oFormPai2, par_nDataSessionPai, par_cEvento)
328:         LOCAL loc_lResultado
329:         loc_lResultado = .F.
330: 
331:         IF VARTYPE(par_oFormPai) = "O"
332:             THIS.this_oFormPai = par_oFormPai
333:         ENDIF
334: 
335:         IF VARTYPE(par_oFormPai2) = "O"
336:             THIS.this_oFormPai2 = par_oFormPai2
337:         ENDIF
338: 
339:         THIS.this_nDataSessionPai = IIF(VARTYPE(par_nDataSessionPai) = "N", par_nDataSessionPai, 0)
340:         THIS.this_cEvento         = IIF(VARTYPE(par_cEvento) = "C", UPPER(ALLTRIM(par_cEvento)), "")
341: 
342:         loc_lResultado = DODEFAULT()
343:         RETURN loc_lResultado
344:     ENDPROC
345: 
346:     *==========================================================================
347:     * InicializarForm - Cria o BO, espelha o evento recebido nele e monta o
348:     * cabecalho, os botoes de acao (Enviar/Cancelar) e todos os campos do
349:     * dump (cntObservacao/cntNFe/cntData/cntSeq/GetEvento/Refazer/Verao).
350:     * Por fim, reproduz o atucur() incondicional do Init legado via
351:     * AtualizarCursorEvento() (guardado contra a ausencia do contexto da
352:     * nota - ver cabecalho da classe e de SigOpNFdBO.prg).
353:     *==========================================================================
354:     PROTECTED PROCEDURE InicializarForm()
355:         LOCAL loc_lSucesso, loc_oErro
356:         loc_lSucesso = .F.
357: 
358:         TRY
359:             THIS.Picture = gc_4c_CaminhoIcones + "new_background.jpg"
360: 
361:             *-- Legado (Init, linha ~907): With ThisForm / .ParentForm.Enabled
362:             *-- = .T. / EndWith - forca o form pai habilitado mesmo com este
363:             *-- dialogo modal por cima (WindowType = 1 ja bloqueia a entrada
364:             *-- nele; o legado faz isso para o caso do pai ter ficado
365:             *-- desabilitado por algum fluxo anterior).
366:             THIS.HabilitarFormPai(.T.)
367: 
368:             THIS.this_oBusinessObject = CREATEOBJECT("SigOpNFdBO")
369:             IF VARTYPE(THIS.this_oBusinessObject) <> "O"
370:                 MsgErro("Erro ao criar SigOpNFdBO. VARTYPE retornou: " + ;
371:                         VARTYPE(THIS.this_oBusinessObject), "FormSigOpNFd.InicializarForm")
372:             ELSE
373:                 THIS.this_oBusinessObject.this_cEvento = THIS.this_cEvento
374: 
375:                 THIS.ConfigurarCabecalho()
376:                 THIS.ConfigurarBotoesAcao()
377:                 THIS.ConfigurarCamposPrincipais()
378:                 THIS.ConfigurarCamposRestantes()
379: 
380:                 *-- Legado (Init, linha 918): thisform.atucur() - roda
381:                 *-- incondicionalmente, depois de getEvento/getData e antes
382:                 *-- da leitura de SigMvCab/LocalOpe (ainda nao portada).
383:                 THIS.AtualizarCursorEvento()
384: 
385:                 loc_lSucesso = .T.
386:             ENDIF
387: 
388:         CATCH TO loc_oErro
389:             MsgErro(loc_oErro.Message + CHR(13) + ;
390:                     "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
391:                     "Procedure: " + loc_oErro.Procedure, ;
392:                     "Erro em FormSigOpNFd.InicializarForm")
393:         ENDTRY
394: 
395:         RETURN loc_lSucesso
396:     ENDPROC
397: 
398:     *==========================================================================
399:     * ConfigurarCabecalho - Faixa cinza do topo (cntSombra do legado), com os
400:     * dois labels espelhando THIS.Caption (legado: ThisForm.cntSombra.
401:     * lblSombra.Caption = ThisForm.Caption, idem lblTitulo). Geometria e cores
402:     * transcritas literalmente do dump (SigOpNFd_form_codigo_fonte.txt,
403:     * SECAO 2 - PROPRIEDADES DE SIGOPNFD.cntSombra/.lblSombra/.lblTitulo).
404:     *==========================================================================
405:     PROTECTED PROCEDURE ConfigurarCabecalho()
406:         LOCAL loc_oCnt
407: 
408:         THIS.AddObject("cnt_4c_Sombra", "Container")
409:         loc_oCnt = THIS.cnt_4c_Sombra
410:         WITH loc_oCnt
411:             .Top         = 0
412:             .Left        = 0
413:             .Width       = THIS.Width
414:             .Height      = 80
415:             .BorderWidth = 0
416:             .BackColor   = RGB(100, 100, 100)
417:             .Visible     = .T.
418:         ENDWITH
419: 
420:         loc_oCnt.AddObject("lbl_4c_LblSombra", "Label")
421:         WITH loc_oCnt.lbl_4c_LblSombra
422:             .FontBold      = .T.
423:             .FontName      = "Tahoma"
424:             .FontSize      = 18
425:             .FontUnderline = .F.
426:             .WordWrap      = .T.
427:             .Alignment     = 0
428:             .BackStyle     = 0
429:             .AutoSize      = .F.
430:             .Caption       = THIS.Caption
431:             .Height        = 40
432:             .Left          = 10
433:             .Top           = 18
434:             .Width         = 769
435:             .ForeColor     = RGB(0, 0, 0)
436:             .Visible       = .T.
437:         ENDWITH
438: 
439:         loc_oCnt.AddObject("lbl_4c_LblTitulo", "Label")
440:         WITH loc_oCnt.lbl_4c_LblTitulo
441:             .FontBold    = .T.
442:             .FontName    = "Tahoma"
443:             .FontSize    = 18
444:             .WordWrap    = .T.
445:             .Alignment   = 0

*-- Linhas 471 a 514:
471:     * de acao do framework legado, igual ao cntSombra/cnt_4c_Saida dos
472:     * cadastros).
473:     *==========================================================================
474:     PROTECTED PROCEDURE ConfigurarBotoesAcao()
475:         LOCAL loc_oCmg
476: 
477:         THIS.AddObject("cnt_4c_Botoes", "CommandGroup")
478:         loc_oCmg = THIS.cnt_4c_Botoes
479:         WITH loc_oCmg
480:             .ButtonCount  = 2
481:             .AutoSize     = .T.
482:             .BackStyle    = 0
483:             .BorderStyle  = 0
484:             .SpecialEffect = 1
485:             .BorderColor  = RGB(136, 189, 188)
486:             .Value        = 0
487:             .Top          = -2
488:             .Left         = 601
489:             .Width        = 160
490:             .Height       = 85
491:             .Themes       = .F.
492:             .Visible      = .T.
493:         ENDWITH
494: 
495:         WITH loc_oCmg.Buttons(1)
496:             .AutoSize      = .F.
497:             .Top           = 5
498:             .Left          = 5
499:             .Height        = 75
500:             .Width         = 75
501:             .FontBold      = .T.
502:             .FontItalic    = .T.
503:             .FontName      = "Comic Sans MS"
504:             .FontSize      = 8
505:             .WordWrap      = .T.
506:             .Picture       = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
507:             .Caption       = "\<Enviar"
508:             .MousePointer  = 15
509:             .ToolTipText   = "Gravar os Dados Informados"
510:             .SpecialEffect = 0
511:             .PicturePosition = 13
512:             .ForeColor     = RGB(90, 90, 90)
513:             .BackColor     = RGB(255, 255, 255)
514:             .Themes        = .F.

*-- Linhas 535 a 612:
535:             .Themes        = .F.
536:         ENDWITH
537: 
538:         BINDEVENT(loc_oCmg.Buttons(1), "Click", THIS, "BtnEnviarClick")
539:         BINDEVENT(loc_oCmg.Buttons(2), "Click", THIS, "BtnCancelarClick")
540:     ENDPROC
541: 
542:     *==========================================================================
543:     * ConfigurarCamposPrincipais - Fase 5/8 (Parte 1 dos campos restantes do
544:     * dump, filhos DIRETOS do form - ramo FLAT, sem Page1/Page2):
545:     *
546:     *   cnt_4c_Observacao <- cntObservacao (lblEve + getDesc - descricao do
547:     *     evento, ControlSource = "crSigMvNfd.nfedesc" no legado; aqui o
548:     *     valor eh sincronizado manualmente com SigOpNFdBO.this_cNfedesc em
549:     *     BtnEnviarClick, ja que este form nao tem FormParaBO/BOParaForm)
550:     *
551:     *   cnt_4c_NFe <- cntNFe (lblEmiss + txt_4c_Nfe - numero da nota/nfis;
552:     *     When do getNfe retorna .F. no dump -> campo NAO recebe foco,
553:     *     .Enabled = .F. aqui. Valor vem de crsigmvnfi.nfis via atucur() -
554:     *     ainda nao portado, ver cabecalho de SigOpNFdBO.prg)
555:     *
556:     *   cnt_4c_Data <- cntData (lblEntregas + txt_4c_Data - data/hora do
557:     *     evento; When do getData retorna .T. no dump -> campo RECEBE foco
558:     *     (editavel, ao contrario de getNfe/getSeq/GetEvento). Valor
559:     *     inicial = DATETIME(), reproduzindo o Init legado -
560:     *     "thisform.cntData.getData.Value = ttoc(DATEtime())" - que roda
561:     *     ANTES do atucur() e nao depende de nenhum cursor)
562:     *
563:     * Geometria/cores/CHR() transcritos literalmente do dump (SECAO 2 -
564:     * PROPRIEDADES DE SIGOPNFD.cntObservacao/.cntNFe/.cntData e filhos).
565:     *
566:     * Labels (classe say do legado, sem Width/Alignment declarados -
567:     * cntObservacao.lblEve/cntNFe.lblEmiss - ou com AutoSize = .T. no dump
568:     * mas que eh NO-OP em Label criado por AddObject - cntData.lblEntregas):
569:     * regra #23 do CLAUDE.md - .AutoSize = .F. + .Alignment = 0 + .Width
570:     * explicita que caiba o texto, dentro da largura do container pai.
571:     *==========================================================================
572:     PROTECTED PROCEDURE ConfigurarCamposPrincipais()
573:         LOCAL loc_oCnt
574: 
575:         *-- cntObservacao: descricao do evento (justificativa/correcao)
576:         THIS.AddObject("cnt_4c_Observacao", "Container")
577:         loc_oCnt = THIS.cnt_4c_Observacao
578:         WITH loc_oCnt
579:             .Top         = 167
580:             .Left        = 40
581:             .Width       = 722
582:             .Height      = 219
583:             .BackStyle   = 0
584:             .BorderWidth = 0
585:             .Visible     = .T.
586:         ENDWITH
587: 
588:         loc_oCnt.AddObject("lbl_4c_LblEve", "Label")
589:         WITH loc_oCnt.lbl_4c_LblEve
590:             .FontBold  = .T.
591:             .FontName  = "Tahoma"
592:             .FontSize  = 8
593:             .BackStyle = 0
594:             .AutoSize  = .F.
595:             .Alignment = 0
596:             .Caption   = "Descri" + CHR(231) + CHR(227) + "o do evento:"
597:             .Left      = 3
598:             .Top       = 23
599:             .Width     = 200
600:             .ForeColor = RGB(90, 90, 90)
601:             .Visible   = .T.
602:         ENDWITH
603: 
604:         loc_oCnt.AddObject("obj_4c_GetDesc", "EditBox")
605:         WITH loc_oCnt.obj_4c_GetDesc
606:             .Height        = 144
607:             .Left          = 3
608:             .Top           = 46
609:             .Width         = 691
610:             .SpecialEffect = 1
611:             .BorderColor   = RGB(90, 90, 90)
612:             .Value         = ""

*-- Linhas 729 a 772:
729:     * criado por AddObject) - .AutoSize = .F. + Width/Height explicitos do
730:     * dump, em vez do AutoSize = .T. que o dump declara.
731:     *==========================================================================
732:     PROTECTED PROCEDURE ConfigurarCamposRestantes()
733:         LOCAL loc_oCnt
734: 
735:         *-- cntSeq: sequencia do evento (nfeseq) - somente exibicao
736:         THIS.AddObject("cnt_4c_Seq", "Container")
737:         loc_oCnt = THIS.cnt_4c_Seq
738:         WITH loc_oCnt
739:             .Top         = 119
740:             .Left        = 303
741:             .Width       = 86
742:             .Height      = 45
743:             .BackStyle   = 0
744:             .BorderWidth = 0
745:             .Visible     = .T.
746:         ENDWITH
747: 
748:         loc_oCnt.AddObject("lbl_4c_LblRecepcaos", "Label")
749:         WITH loc_oCnt.lbl_4c_LblRecepcaos
750:             .FontBold  = .T.
751:             .FontName  = "Tahoma"
752:             .FontSize  = 8
753:             .BackStyle = 0
754:             .AutoSize  = .F.
755:             .Alignment = 0
756:             .Caption   = "Sequ" + CHR(234) + "ncia"
757:             .Height    = 15
758:             .Left      = 3
759:             .Top       = 3
760:             .Width     = 60
761:             .ForeColor = RGB(90, 90, 90)
762:             .Visible   = .T.
763:         ENDWITH
764: 
765:         loc_oCnt.AddObject("txt_4c_Seq", "TextBox")
766:         WITH loc_oCnt.txt_4c_Seq
767:             .Height        = 23
768:             .Left          = 3
769:             .Top           = 20
770:             .Width         = 80
771:             .SpecialEffect = 1
772:             .BorderColor   = RGB(90, 90, 90)

*-- Linhas 845 a 1249:
845:             .Visible     = .T.
846:         ENDWITH
847: 
848:         BINDEVENT(THIS.chk_4c_Refazer, "Click", THIS, "ChkRefazerClick")
849:         BINDEVENT(THIS.chk_4c_Verao, "InteractiveChange", THIS, "ChkVeraoChange")
850: 
851:         *-- Semente do "ultimo valor valido" do campo de data/hora: o valor
852:         *-- que ConfigurarCamposPrincipais acabou de por (TTOC(DATETIME()),
853:         *-- igual ao Init legado) JA eh valido por construcao.
854:         THIS.this_cDataEventoAnterior = THIS.cnt_4c_Data.txt_4c_Data.Value
855: 
856:         *-- Validacao dos DOIS campos digitaveis do legado (os unicos cujo
857:         *-- When devolve .T. no dump: cntObservacao.getDesc e
858:         *-- cntData.getData; getNfe/getSeq/GetEvento tem When -> .F. e
859:         *-- estao com .Enabled = .F. aqui). Em "LostFocus", nunca em
860:         *-- "KeyPress" - o equivalente do Valid do legado eh SAIR do campo
861:         *-- (regra #47 do CLAUDE.md); em KeyPress o dialogo subiria a cada
862:         *-- tecla digitada.
863:         *--
864:         *-- Este form NAO tem lookup algum: nao existe fwBuscaExt/
865:         *-- fwBuscaSel/fwBuscaInt/sigacess/mAddColuna em nenhum ponto do
866:         *-- dump legado (conferido por busca nos 6 padroes), e nenhum campo
867:         *-- referencia tabela auxiliar. Criar AbrirLookup*/AbrirBusca* aqui
868:         *-- seria inventar picker e tabela que o original nao consulta -
869:         *-- proibido pelo PILAR 1 e pela regra "NUNCA inventar tabelas de
870:         *-- lookup que nao existem no original".
871:         BINDEVENT(THIS.cnt_4c_Observacao.obj_4c_GetDesc, "LostFocus", THIS, "ValidarDescricaoEvento")
872:         BINDEVENT(THIS.cnt_4c_Data.txt_4c_Data, "LostFocus", THIS, "ValidarDataEvento")
873: 
874:         *-- Fase 8: com todos os controles do dump ja criados, o estado
875:         *-- Enabled passa a sair de HabilitarCampos (fonte unica derivada do
876:         *-- When de cada campo no legado) e o rotulo do evento, de
877:         *-- BOParaForm. Os dois ficam AQUI, no fim do ultimo metodo de
878:         *-- configuracao, porque so agora existe a superficie inteira:
879:         *-- HabilitarCampos toca controles dos TRES containers de campo
880:         *-- (cnt_4c_Observacao/cnt_4c_Data da Fase 5 e cnt_4c_Seq da Fase 6)
881:         *-- mais os filhos diretos do form.
882:         THIS.HabilitarCampos(.T.)
883:         THIS.BOParaForm()
884:     ENDPROC
885: 
886:     *==========================================================================
887:     * ValidarDescricaoEvento - Equivalente, nesta arquitetura, ao
888:     * ControlSource do getDesc legado.
889:     *
890:     * No dump, getDesc declara ControlSource = "crSigMvNfd.nfedesc" (SECAO 2
891:     * - PROPRIEDADES DE SIGOPNFD.cntObservacao.getDesc): o texto digitado vai
892:     * para o cursor do evento CONTINUAMENTE, e e dali que todo o resto do
893:     * legado o le - "IF LEN(ALLTRIM(crsigmvnfd.nfedesc)) < 15" (linha 1120),
894:     * "lcJu = ALLTRIM(thisform.cntObservacao.getDesc.Value)" (linha 999) e
895:     * "lcDesc = ALLTRIM(fLimpaTexto(crSigMvNfd.nfedesc))" (linha 1209).
896:     *
897:     * Nesta arquitetura nao ha ControlSource (o BO le/grava por SQLEXEC), e
898:     * o controle eh a fonte UNICA do texto: sem este espelhamento, o valor
899:     * digitado so chegaria ao BO dentro de BtnEnviarClick - e qualquer
900:     * recarga anterior a isso (ChkRefazerClick no ramo "achou evento",
901:     * AtualizarCursorEvento) reescreve obj_4c_GetDesc.Value a partir de
902:     * this_cNfedesc e APAGA o que o usuario digitou, sem erro e sem log. No
903:     * legado isso nao acontece justamente porque o ControlSource ja havia
904:     * gravado o texto no cursor.
905:     *
906:     * NAO exibe mensagem: o ControlSource do legado nao avisa nada, e a
907:     * unica critica da descricao ("Descricao do evento invalida", LEN < 15)
908:     * mora no Click do botao Enviar - reproduzida em BtnEnviarClick. Avisar
909:     * aqui inventaria comportamento e, pior, atrapalharia quem esta no meio
910:     * da digitacao (regra #50 do CLAUDE.md).
911:     *
912:     * Fase 8: a atribuicao solta a this_cNfedesc deu lugar a FormParaBO(),
913:     * fonte unica da transferencia controles -> BO (CLAUDE.md #44, item 6).
914:     * Varrer os quatro controles em vez de um nao muda nada aqui: os outros
915:     * tres recebem o valor que ja esta neles.
916:     *==========================================================================
917:     PROCEDURE ValidarDescricaoEvento()
918:         THIS.FormParaBO()
919:     ENDPROC
920: 
921:     *==========================================================================
922:     * ValidarDataEvento / ValidarDataEventoExec - Reproduz a restricao de
923:     * entrada que a classe fweditdata do Framework dava ao getData legado.
924:     *
925:     * O legado le esse campo com CTOT() em TRES pontos (linhas 571, 1220 e
926:     * 1469 do dump): "nfedte with CTOT(thisform.cntData.getData.Value)" no
927:     * atucur e "b = ttoc(CTOT(thisform.cntData.getData.Value))" nas duas
928:     * montagens do dhEvento enviado a SEFAZ. La isso e seguro porque getData
929:     * e um fweditdata (framework.vcx: TextBox de data, Value = {},
930:     * tpcalendario = 3, com calendario) - o controle nao deixa o campo
931:     * guardar algo que nao seja data/hora.
932:     *
933:     * Aqui o controle e um TextBox comum de valor CARACTERE (fidelidade ao
934:     * "thisform.cntData.getData.Value = ttoc(DATEtime())" do Init legado),
935:     * logo o usuario pode digitar qualquer coisa. CTOT() de texto invalido
936:     * devolve DATETIME VAZIO - sem erro e sem aviso - e o evento seria
937:     * gravado/enviado com dhEvento em branco. Este handler repoe a
938:     * restricao: aceita o campo VAZIO (a propria classe declara
939:     * NullDisplay = "//", ou seja, vazio e estado valido), normaliza o que
940:     * converte para a forma canonica TTOC() e, no que nao converte, avisa e
941:     * devolve o ultimo valor valido - que e o que o controle de data do
942:     * legado faz ao recusar a tecla.
943:     *
944:     * Wrapper + Exec (regra #47): o corpo tem RETURN antecipado e o MsgAviso
945:     * e MODAL (redispara o LostFocus). Com set/clear no proprio corpo a
946:     * flag travaria ligada no primeiro RETURN e MATARIA a validacao pelo
947:     * resto da vida do form.
948:     *==========================================================================
949:     PROCEDURE ValidarDataEvento()
950:         LOCAL loc_oErro
951: 
952:         IF THIS.this_lEmValidacao
953:             RETURN
954:         ENDIF
955: 
956:         THIS.this_lEmValidacao = .T.
957: 
958:         *-- TRY no WRAPPER, nao no corpo: qualquer excecao dentro do Exec
959:         *-- (o SetFocus do ramo invalido, por exemplo) deixaria a flag
960:         *-- LIGADA e mataria a validacao pelo resto da vida do form - o
961:         *-- mesmo estrago que a regra #47 descreve para o RETURN antecipado.
962:         TRY
963:             THIS.ValidarDataEventoExec()
964:         CATCH TO loc_oErro
965:             MsgErro(loc_oErro.Message + CHR(13) + ;
966:                     "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
967:                     "Procedure: " + loc_oErro.Procedure, ;
968:                     "Erro em FormSigOpNFd.ValidarDataEvento")
969:         ENDTRY
970: 
971:         THIS.this_lEmValidacao = .F.
972:     ENDPROC
973: 
974:     PROCEDURE ValidarDataEventoExec()
975:         LOCAL loc_cDigitado, loc_tConvertido, loc_lValido, loc_oErro
976: 
977:         loc_cDigitado = ALLTRIM(TRANSFORM(THIS.cnt_4c_Data.txt_4c_Data.Value))
978: 
979:         *-- Campo vazio e estado VALIDO (NullDisplay = "//" no dump): o
980:         *-- legado nao obriga data/hora aqui, e CTOT("") devolve DATETIME
981:         *-- vazio tanto no legado quanto aqui.
982:         IF EMPTY(loc_cDigitado)
983:             THIS.this_cDataEventoAnterior = ""
984:             THIS.FormParaBO()
985:             RETURN
986:         ENDIF
987: 
988:         loc_lValido     = .F.
989:         loc_tConvertido = {/:}
990: 
991:         *-- CTOT() de texto nao-convertivel devolve DATETIME vazio em vez de
992:         *-- estourar; o TRY cobre tambem o caso de erro, para o diagnostico
993:         *-- nao depender de qual dos dois comportamentos ocorre.
994:         TRY
995:             loc_tConvertido = CTOT(loc_cDigitado)
996:             loc_lValido     = (VARTYPE(loc_tConvertido) = "T" AND !EMPTY(loc_tConvertido))
997:         CATCH TO loc_oErro
998:             loc_lValido = .F.
999:         ENDTRY
1000: 
1001:         IF loc_lValido
1002:             *-- Normaliza para a forma canonica do legado (TTOC), para que
1003:             *-- o CTOT() de quem consome o campo receba sempre o mesmo
1004:             *-- formato que o Init gerou.
1005:             THIS.cnt_4c_Data.txt_4c_Data.Value = TTOC(loc_tConvertido)
1006:             THIS.this_cDataEventoAnterior      = THIS.cnt_4c_Data.txt_4c_Data.Value
1007:         ELSE
1008:             MsgAviso("Data/Hora do evento inv" + CHR(225) + "lida.", ;
1009:                      "Aten" + CHR(231) + CHR(227) + "o")
1010:             THIS.cnt_4c_Data.txt_4c_Data.Value = THIS.this_cDataEventoAnterior
1011:             THIS.cnt_4c_Data.txt_4c_Data.SetFocus()
1012:         ENDIF
1013: 
1014:         *-- Fase 8: o espelhamento no BO (antes feito com uma atribuicao
1015:         *-- solta a this_dNfedte dentro de cada ramo) passa por FormParaBO,
1016:         *-- fonte unica da transferencia controles -> BO. Fica FORA do
1017:         *-- IF/ELSE de proposito: nos DOIS ramos o controle acabou de ser
1018:         *-- reescrito (valor normalizado no ramo valido, ultimo valor valido
1019:         *-- no invalido), e o BO tem de acompanhar - antes, o ramo invalido
1020:         *-- devolvia o campo ao valor bom na tela e deixava no BO a data que
1021:         *-- CTOT() nao soube converter.
1022:         THIS.FormParaBO()
1023:     ENDPROC
1024: 
1025:     *==========================================================================
1026:     * ChkRefazerClick - Refazer.Click do legado (linhas 1759-1782 do dump):
1027:     *
1028:     *   IF this.value = 1
1029:     *       <consulta o ultimo evento da nota>
1030:     *       IF EOF('crSigMvNfd')
1031:     *           thisform.atucur        && nao achou - cria sequencia nova
1032:     *       ELSE
1033:     *           <so espelha os campos do evento encontrado>
1034:     *       ENDIF
1035:     *   ELSE
1036:     *       thisform.atucur            && desmarcado - sempre cria sequencia
1037:     *   ENDIF
1038:     *==========================================================================
1039:     PROCEDURE ChkRefazerClick()
1040:         LOCAL loc_oBO
1041: 
1042:         IF VARTYPE(THIS.this_oBusinessObject) != "O"
1043:             RETURN
1044:         ENDIF
1045:         loc_oBO = THIS.this_oBusinessObject
1046: 
1047:         *-- Espelha o estado dos controles no BO. O legado le
1048:         *-- "thisform.refazer.Value = 1" direto nos dois ramos de envio
1049:         *-- (linhas 1310 e 1519 do dump - reenvio do XML de cancelamento e
1050:         *-- reimpressao da ultima carta), entao a fase que portar a montagem
1051:         *-- do XML precisa do valor ATUAL em this_lRefazer. Fase 8: a
1052:         *-- atribuicao solta deu lugar a FormParaBO(), que cobre os QUATRO
1053:         *-- controles que o legado le de volta - fonte unica
1054:         *-- (CLAUDE.md #44, item 6).
1055:         THIS.FormParaBO()
1056: 
1057:         IF THIS.chk_4c_Refazer.Value = 1
1058:             IF loc_oBO.ConsultarUltimoEvento()
1059:                 *-- Achou o ultimo evento desta nota/evento - so espelha os
1060:                 *-- campos (NAO cria sequencia nova, igual ao ramo ELSE do
1061:                 *-- legado). A sequencia exibida aqui eh a do evento
1062:                 *-- ENCONTRADO - "thisform.cntSeq.getSeq.value =
1063:                 *-- crsigmvnfd.nfeseq" (linha 1774 do dump), SEM o "+ 1" que
1064:                 *-- o atucur aplica: por isso o parametro de BOParaForm.
1065:                 THIS.BOParaForm(loc_oBO.this_nNfeseq)
1066:             ELSE
1067:                 THIS.AtualizarCursorEvento()
1068:             ENDIF
1069:         ELSE
1070:             THIS.AtualizarCursorEvento()
1071:         ENDIF
1072:     ENDPROC
1073: 
1074:     *==========================================================================
1075:     * ChkVeraoChange - Verao nao tem Click no legado; o CheckBox e lido
1076:     * direto na montagem do dhEvento (linha 1142 do dump: "lcVerao =
1077:     * IIF(thisform.verao.Value=1,'02:00','03:00')"). Aqui so espelha o
1078:     * estado no BO a cada mudanca, para o metodo que montar o XML do evento
1079:     * usar THIS.this_oBusinessObject.this_cFusoHorario.
1080:     *
1081:     * Fase 8: as duas atribuicoes soltas deram lugar a FormParaBO(), onde o
1082:     * "IIF(thisform.verao.Value=1,'02:00','03:00')" do legado agora mora uma
1083:     * UNICA vez (CLAUDE.md #44, item 6).
1084:     *==========================================================================
1085:     PROCEDURE ChkVeraoChange()
1086:         THIS.FormParaBO()
1087:     ENDPROC
1088: 
1089:     *==========================================================================
1090:     * AtualizarCursorEvento - Equivalente ao atucur() legado (linhas
1091:     * 548-584 do dump) do lado do Form: delega a SigOpNFdBO.
1092:     * AtualizarUltimoEvento() (que decide se PREPARA sequencia nova ou reusa
1093:     * a existente - sem gravar, igual ao atucur, que so mexe no cursor em
1094:     * memoria) e, so quando ele tem sucesso, espelha os
1095:     * campos atualizados nos controles da tela - igual ao legado
1096:     * ("thisform.cntNFe.getNfe.value = ... / thisform.cntSeq.getSeq.value =
1097:     * ... / thisform.cntObservacao.getDesc.value = ... / ThisForm.Refresh").
1098:     *
1099:     * A data/hora que o BO recebe eh a do CONTROLE - equivale ao
1100:     * "CTOT(thisform.cntData.getData.Value)" do legado (linha 571). Fase 8:
1101:     * a leitura do controle deixou de ser feita aqui com um CTOT() solto e
1102:     * passa por FormParaBO(), que eh quem normaliza e guarda o valor em
1103:     * this_dNfedte (fonte unica - CLAUDE.md #44, item 6); o argumento
1104:     * continua sendo passado porque eh o contrato de
1105:     * AtualizarUltimoEvento().
1106:     *
1107:     * A sequencia exibida eh this_nUltimaSequencia - o lnUltSeq do legado
1108:     * ("thisform.cntSeq.getSeq.value = lnUltSeq", linha 578), que eh o
1109:     * ultimo nfeseq + 1 (ou 1, quando nao ha evento anterior) e vale nos
1110:     * DOIS ramos do atucur, inclusive no de reuso. Nao confundir com
1111:     * this_nNfeseq, que eh a sequencia do evento ENCONTRADO e eh o que o
1112:     * Refazer.Click exibe (ver ChkRefazerClick).
1113:     *
1114:     * LimparCampos() reproduz o "nfedesc with ''" do APPEND legado (linha
1115:     * 572) e por isso roda SO no ramo da sequencia nova, que eh onde aquele
1116:     * replace esta - this_lNovoRegistro eh exatamente o que
1117:     * AtualizarUltimoEvento acabou de definir (NovoRegistro no ramo novo,
1118:     * EditarRegistro no de reuso).
1119:     *
1120:     * AtualizarUltimoEvento() tem guarda propria contra o contexto da nota
1121:     * ainda nao lido (this_cNfiEmpDopNums vazio - ver cabecalho da classe e
1122:     * de SigOpNFdBO.prg): quando a guarda bloqueia, devolve .F. e este
1123:     * metodo simplesmente nao atualiza nada na tela (os campos continuam no
1124:     * default vazio/zero ate a fase que portar a leitura de SigMvNfi).
1125:     *==========================================================================
1126:     PROCEDURE AtualizarCursorEvento()
1127:         LOCAL loc_oBO, loc_lAtualizou
1128:         loc_lAtualizou = .F.
1129: 
1130:         IF VARTYPE(THIS.this_oBusinessObject) != "O"
1131:             RETURN .F.
1132:         ENDIF
1133:         loc_oBO = THIS.this_oBusinessObject
1134: 
1135:         THIS.FormParaBO()
1136: 
1137:         IF loc_oBO.AtualizarUltimoEvento(loc_oBO.this_dNfedte)
1138:             IF loc_oBO.this_lNovoRegistro
1139:                 THIS.LimparCampos()
1140:             ENDIF
1141: 
1142:             THIS.BOParaForm(loc_oBO.this_nUltimaSequencia)
1143:             loc_lAtualizou = .T.
1144:         ENDIF
1145: 
1146:         RETURN loc_lAtualizou
1147:     ENDPROC
1148: 
1149:     *==========================================================================
1150:     * CarregarLista - Funil PUBLICO de carga desta tela, no nome canonico do
1151:     * projeto. Delega a AtualizarCursorEvento(), que eh o atucur() legado -
1152:     * a consulta do ultimo evento da nota mais o espelhamento nos controles.
1153:     *
1154:     * NAO ha grade neste form (layout.json nao declara um unico objeto
1155:     * baseClass=grid, e a SECAO 1 do dump confirma: nenhum grid/pageframe),
1156:     * logo nao ha RecordSource/ControlSource de coluna, GO TOP nem
1157:     * Grid.Refresh a fazer aqui - o repintar equivalente eh o
1158:     * "ThisForm.Refresh" com que o atucur termina, dentro de BOParaForm.
1159:     * Mesmo padrao de funil de FormSigOpNch.CarregarLista() ->
1160:     * CarregarGrade().
1161:     *
1162:     * PUBLIC (sem PROTECTED) de proposito: o harness de teste chama
1163:     * oForm.CarregarLista() de FORA da classe, e metodo PROTECTED falha ali
1164:     * em runtime mesmo com PEMSTATUS(...,5) devolvendo .T. (regras #3 e #51
1165:     * do CLAUDE.md).
1166:     *==========================================================================
1167:     PROCEDURE CarregarLista()
1168:         RETURN THIS.AtualizarCursorEvento()
1169:     ENDPROC
1170: 
1171:     *==========================================================================
1172:     * FormParaBO - Transferencia CONTROLES -> BO.
1173:     *
1174:     * Cobre os QUATRO controles que o legado le de volta, com todos os seus
1175:     * sites no dump:
1176:     *
1177:     *   cntObservacao.getDesc -> this_cNfedesc
1178:     *       "lcJu = ALLTRIM(thisform.cntObservacao.getDesc.Value)" (linha
1179:     *       999) e, via ControlSource, "LEN(ALLTRIM(crsigmvnfd.nfedesc))"
1180:     *       (linha 1120) e "fLimpaTexto(crSigMvNfd.nfedesc)" (linha 1209).
1181:     *
1182:     *   cntData.getData -> this_dNfedte
1183:     *       "CTOT(thisform.cntData.getData.Value)" (linhas 571, 1220 e
1184:     *       1469). CTOT de texto nao-convertivel devolve DATETIME VAZIO sem
1185:     *       erro, e eh exatamente esse o valor que o legado gravaria -
1186:     *       ValidarDataEvento eh quem impede o campo de chegar nesse estado.
1187:     *
1188:     *   Refazer -> this_lRefazer
1189:     *       "thisform.refazer.Value = 1" (linhas 1310 e 1519).
1190:     *
1191:     *   Verao -> this_lHorarioVerao / this_cFusoHorario
1192:     *       "lcVerao = IIF(thisform.verao.Value=1,'02:00','03:00')"
1193:     *       (linha 1142).
1194:     *
1195:     * getNfe, getSeq e GetEvento NAO entram: os tres tem "When -> Return
1196:     * .f." no dump (somente EXIBICAO) e o legado nunca le o valor deles -
1197:     * quem escreve nesses campos eh o proprio BO, atraves de BOParaForm.
1198:     * Ler um campo de exibicao de volta sobrescreveria a property com o que
1199:     * o BO acabou de por nela e, antes da primeira carga, com BRANCO.
1200:     *
1201:     * this_cEvento tambem nao entra: vem do pEvento do Init (parametro do
1202:     * form pai), nao de controle nenhum, e eh espelhado no BO uma vez em
1203:     * InicializarForm.
1204:     *
1205:     * PROTECTED EXPLICITO: FormBase declara FormParaBO como PROTECTED e o
1206:     * VFP9 nao deixa a subclasse ALARGAR o escopo - escrever sem o
1207:     * modificador apenas esconderia que o metodo continua protegido.
1208:     *==========================================================================
1209:     PROTECTED PROCEDURE FormParaBO()
1210:         LOCAL loc_oBO, loc_lSucesso
1211:         loc_lSucesso = .F.
1212: 
1213:         IF VARTYPE(THIS.this_oBusinessObject) != "O"
1214:             RETURN .F.
1215:         ENDIF
1216:         loc_oBO = THIS.this_oBusinessObject
1217: 
1218:         IF PEMSTATUS(THIS, "cnt_4c_Observacao", 5)
1219:             loc_oBO.this_cNfedesc = ALLTRIM(THIS.cnt_4c_Observacao.obj_4c_GetDesc.Value)
1220:         ENDIF
1221: 
1222:         IF PEMSTATUS(THIS, "cnt_4c_Data", 5)
1223:             loc_oBO.this_dNfedte = CTOT(ALLTRIM(TRANSFORM(THIS.cnt_4c_Data.txt_4c_Data.Value)))
1224:         ENDIF
1225: 
1226:         IF PEMSTATUS(THIS, "chk_4c_Refazer", 5)
1227:             loc_oBO.this_lRefazer = (THIS.chk_4c_Refazer.Value = 1)
1228:         ENDIF
1229: 
1230:         IF PEMSTATUS(THIS, "chk_4c_Verao", 5)
1231:             loc_oBO.this_lHorarioVerao = (THIS.chk_4c_Verao.Value = 1)
1232:             loc_oBO.this_cFusoHorario  = IIF(THIS.chk_4c_Verao.Value = 1, "02:00", "03:00")
1233:         ENDIF
1234: 
1235:         loc_lSucesso = .T.
1236: 
1237:         RETURN loc_lSucesso
1238:     ENDPROC
1239: 
1240:     *==========================================================================
1241:     * BOParaForm - Transferencia BO -> CONTROLES.
1242:     *
1243:     * Eh o bloco final do atucur legado (linhas 577-579)
1244:     *
1245:     *   thisform.cntNFe.getNfe.value         = crsigmvnfi.nfis
1246:     *   thisform.cntSeq.getSeq.value         = lnUltSeq
1247:     *   thisform.cntObservacao.getDesc.value = crsigmvnfd.nfedesc
1248:     *   ThisForm.Refresh
1249:     *

*-- Linhas 1277 a 1320:
1277:     * PROTECTED EXPLICITO pelo mesmo motivo de FormParaBO (FormBase declara
1278:     * BOParaForm como PROTECTED e VFP9 nao permite alargar o escopo).
1279:     *==========================================================================
1280:     PROTECTED PROCEDURE BOParaForm(par_nSequencia)
1281:         LOCAL loc_oBO, loc_nSeq, loc_lSucesso
1282:         loc_lSucesso = .F.
1283: 
1284:         IF VARTYPE(THIS.this_oBusinessObject) != "O"
1285:             RETURN .F.
1286:         ENDIF
1287:         loc_oBO = THIS.this_oBusinessObject
1288: 
1289:         loc_nSeq = IIF(VARTYPE(par_nSequencia) = "N", par_nSequencia, ;
1290:                        loc_oBO.this_nUltimaSequencia)
1291: 
1292:         IF PEMSTATUS(THIS, "cnt_4c_NFe", 5)
1293:             THIS.cnt_4c_NFe.txt_4c_Nfe.Value = ALLTRIM(loc_oBO.this_cNfiNfis)
1294:         ENDIF
1295: 
1296:         IF PEMSTATUS(THIS, "cnt_4c_Seq", 5)
1297:             THIS.cnt_4c_Seq.txt_4c_Seq.Value = loc_nSeq
1298:         ENDIF
1299: 
1300:         IF PEMSTATUS(THIS, "cnt_4c_Observacao", 5)
1301:             THIS.cnt_4c_Observacao.obj_4c_GetDesc.Value = loc_oBO.this_cNfedesc
1302:         ENDIF
1303: 
1304:         IF PEMSTATUS(THIS, "txt_4c_Evento", 5)
1305:             THIS.txt_4c_Evento.Value = IIF(loc_oBO.this_cEvento = "CAN", ;
1306:                 loc_oBO.this_cRotuloCancelamento, loc_oBO.this_cRotuloCarta)
1307:         ENDIF
1308: 
1309:         *-- "ThisForm.Refresh" com que o atucur e o ramo de reuso do
1310:         *-- Refazer.Click terminam - popular nao repinta sozinho (regra #21)
1311:         THIS.Refresh()
1312: 
1313:         loc_lSucesso = .T.
1314: 
1315:         RETURN loc_lSucesso
1316:     ENDPROC
1317: 
1318:     *==========================================================================
1319:     * HabilitarCampos - Fonte UNICA do estado Enabled dos controles.
1320:     *

*-- Linhas 1341 a 1384:
1341:     * PUBLIC (sem PROTECTED): o harness de teste chama
1342:     * oForm.HabilitarCampos(...) de fora da classe (regras #3 e #51).
1343:     *==========================================================================
1344:     PROCEDURE HabilitarCampos(par_lHabilitar)
1345:         LOCAL loc_lHabilitar
1346: 
1347:         loc_lHabilitar = IIF(VARTYPE(par_lHabilitar) = "L", par_lHabilitar, .T.)
1348: 
1349:         *-- Campos digitaveis do legado (When -> Return .t.)
1350:         IF PEMSTATUS(THIS, "cnt_4c_Observacao", 5)
1351:             THIS.cnt_4c_Observacao.obj_4c_GetDesc.Enabled = loc_lHabilitar
1352:         ENDIF
1353: 
1354:         IF PEMSTATUS(THIS, "cnt_4c_Data", 5)
1355:             THIS.cnt_4c_Data.txt_4c_Data.Enabled = loc_lHabilitar
1356:         ENDIF
1357: 
1358:         *-- CheckBox: o dump nao declara When para nenhum dos dois
1359:         IF PEMSTATUS(THIS, "chk_4c_Refazer", 5)
1360:             THIS.chk_4c_Refazer.Enabled = loc_lHabilitar
1361:         ENDIF
1362: 
1363:         IF PEMSTATUS(THIS, "chk_4c_Verao", 5)
1364:             THIS.chk_4c_Verao.Enabled = loc_lHabilitar
1365:         ENDIF
1366: 
1367:         *-- Campos de EXIBICAO (When -> Return .f.): nunca recebem foco, em
1368:         *-- nenhum estado da tela
1369:         IF PEMSTATUS(THIS, "cnt_4c_NFe", 5)
1370:             THIS.cnt_4c_NFe.txt_4c_Nfe.Enabled = .F.
1371:         ENDIF
1372: 
1373:         IF PEMSTATUS(THIS, "cnt_4c_Seq", 5)
1374:             THIS.cnt_4c_Seq.txt_4c_Seq.Enabled = .F.
1375:         ENDIF
1376: 
1377:         IF PEMSTATUS(THIS, "txt_4c_Evento", 5)
1378:             THIS.txt_4c_Evento.Enabled = .F.
1379:         ENDIF
1380: 
1381:         RETURN .T.
1382:     ENDPROC
1383: 
1384:     *==========================================================================

*-- Linhas 1403 a 1541:
1403:     * (FormBase declara LimparCampos como PROTECTED e o VFP9 nao permite
1404:     * alargar o escopo de metodo herdado).
1405:     *==========================================================================
1406:     PROTECTED PROCEDURE LimparCampos()
1407:         IF VARTYPE(THIS.this_oBusinessObject) = "O"
1408:             THIS.this_oBusinessObject.this_cNfedesc = ""
1409:         ENDIF
1410: 
1411:         IF PEMSTATUS(THIS, "cnt_4c_Observacao", 5)
1412:             THIS.cnt_4c_Observacao.obj_4c_GetDesc.Value = ""
1413:         ENDIF
1414: 
1415:         RETURN .T.
1416:     ENDPROC
1417: 
1418:     *==========================================================================
1419:     * BtnCancelarClick - btnSair.Click do legado (linhas 1683-1686 do dump):
1420:     *   Thisform.parentform.enabled = .T.
1421:     *   Thisform.release
1422:     *==========================================================================
1423:     PROCEDURE BtnCancelarClick()
1424:         THIS.HabilitarFormPai(.T.)
1425:         THIS.Release()
1426:     ENDPROC
1427: 
1428:     *==========================================================================
1429:     * BtnEnviarClick - btnSelItens.Click do legado (linhas 977-1678 do dump).
1430:     *
1431:     * Reproduz aqui a parte do fluxo que e PURAMENTE validacao de dados (as
1432:     * guardas que antecedem a montagem/envio do XML, linhas 1107-1123 e 1120
1433:     * do dump - nenhuma delas depende de arquivo em disco, DLL ou processo
1434:     * externo) e a gravacao do evento em SigMvNfd (equivalente ao
1435:     * atucur()/APPEND BLANK, ja implementado em SigOpNFdBO.Inserir() - Fase
1436:     * 2) atraves de loc_oBO.Salvar() (BusinessBase - chama ValidarDados() e
1437:     * Inserir(), e ja exibe a falha sozinha quando Salvar() devolve .F. -
1438:     * regra #20 do CLAUDE.md, "o form NAO precisa de ELSE").
1439:     *
1440:     * NAO reproduzido nesta fase - depende de infraestrutura que ainda nao
1441:     * existe em NENHUM ponto do projeto novo (nao e omissao silenciosa: a
1442:     * propria SigOpNFdBO.prg, Fase 2, ja documenta estes passos em
1443:     * "Fluxo do legado (a reproduzir nas fases seguintes)"):
1444:     *   - leitura do CONTEXTO da nota (SigMvNfi/SigPrNfe/SigMvCab/SigCdOpe+
1445:     *     SigOpCdd/Cdc/Cdi/SigCdEmp/SigCdCli) - as properties this_cNfi*/
1446:     *     this_cStats/this_cCabDopes/this_nCupFis/this_cEmp* ja existem no BO
1447:     *     (Fase 1) mas nenhum metodo as popula ainda;
1448:     *   - cancelamento de NFCe via DarumaFramework.dll (CupFis = 5) e de CF-e
1449:     *     via SAT.dll (CupFis = 6, canccfe());
1450:     *   - protocolo de arquivos da UniNFe (envio/validar/retorno, esperaarq/
1451:     *     esperauniler do ParentForm2) e geracao/assinatura do XML do evento;
1452:     *   - envio de e-mail (enviaEmail) e geracao automatica de operacao
1453:     *     (Gerarnota) quando SigOpCdc.Geropes = 4.
1454:     *==========================================================================
1455:     PROCEDURE BtnEnviarClick()
1456:         LOCAL loc_oBO
1457: 
1458:         IF VARTYPE(THIS.this_oBusinessObject) != "O"
1459:             RETURN
1460:         ENDIF
1461:         loc_oBO = THIS.this_oBusinessObject
1462: 
1463:         *-- Legado (linhas 1406 e 1649): replace nfedesc with lcdesc in
1464:         *-- crSigMvNfd, imediatamente antes do Update/Commit -
1465:         *-- cnt_4c_Observacao.obj_4c_GetDesc (equivalente a getDesc, Fase 5)
1466:         *-- eh a fonte UNICA do texto digitado. ValidarDescricaoEvento ja
1467:         *-- espelha a cada LostFocus (equivalente ao ControlSource do
1468:         *-- legado); aqui o espelhamento eh repetido para cobrir o caso de o
1469:         *-- usuario clicar Enviar com o cursor AINDA dentro do EditBox, em
1470:         *-- que o LostFocus nao chegou a disparar. Fase 8: por FormParaBO,
1471:         *-- que faz o mesmo para os QUATRO controles que o legado le de
1472:         *-- volta - a descricao, a data/hora (os tres CTOT do dump) e os
1473:         *-- dois CheckBox, todos consumidos pelo fluxo de envio.
1474:         THIS.FormParaBO()
1475: 
1476:         *-- Legado (linha 1120): IF LEN(ALLTRIM(crsigmvnfd.nfedesc)) < 15
1477:         IF LEN(loc_oBO.this_cNfedesc) < loc_oBO.this_nTamMinDescricao
1478:             MsgAviso("Descri" + CHR(231) + CHR(227) + "o do evento inv" + ;
1479:                      CHR(225) + "lida", "Aten" + CHR(231) + CHR(227) + "o")
1480:             RETURN
1481:         ENDIF
1482: 
1483:         *-- O MODO de gravacao ja foi definido por AtualizarCursorEvento ->
1484:         *-- SigOpNFdBO.AtualizarUltimoEvento (equivalente ao atucur): linha
1485:         *-- nova -> NovoRegistro (Salvar roteia para Inserir); evento 'CAN'
1486:         *-- reaproveitado -> EditarRegistro (Salvar roteia para Atualizar).
1487:         *-- NAO chamar NovoRegistro() aqui: forcaria INSERT tambem no ramo de
1488:         *-- reuso, criando um registro duplicado onde o legado faz UPDATE.
1489:         *-- Salvar() ja exibe a propria falha quando devolve .F. (regra #20
1490:         *-- do CLAUDE.md - inclusive o caso "nao esta em modo de edicao",
1491:         *-- que e como a ausencia do contexto da nota se manifesta enquanto
1492:         *-- a leitura de SigMvNfi nao for portada).
1493:         loc_oBO.Salvar()
1494: 
1495:         *-- Legado (linha 1676, ULTIMA instrucao do Click antes do
1496:         *-- "RETURN lOk"): "thisform.atucur()  && atualiza cursor". Fica
1497:         *-- FORA de qualquer IF no legado - roda tanto no caminho de sucesso
1498:         *-- quanto nos de falha do envio -, e por isso tambem roda aqui sem
1499:         *-- condicionar ao retorno de Salvar(). Depois de gravar, a tela se
1500:         *-- recarrega: a consulta volta a buscar o ultimo evento da nota e a
1501:         *-- sequencia exibida avanca.
1502:         *--
1503:         *-- O RETURN antecipado da guarda de descricao, acima, PULA este
1504:         *-- atucur - igual ao "return" nu do legado (linha 1122), que sai do
1505:         *-- Click sem alcancar a linha 1676.
1506:         THIS.AtualizarCursorEvento()
1507:     ENDPROC
1508: 
1509:     *==========================================================================
1510:     * HabilitarFormPai - Habilita/desabilita o form que abriu este dialogo
1511:     * (this_oFormPai = ThisForm.ParentForm no legado). Guardado por VARTYPE
1512:     * porque em validacao de UI / modo teste o dialogo e instanciado sem pai.
1513:     *==========================================================================
1514:     PROTECTED PROCEDURE HabilitarFormPai(par_lHabilitar)
1515:         IF VARTYPE(THIS.this_oFormPai) = "O"
1516:             THIS.this_oFormPai.Enabled = IIF(VARTYPE(par_lHabilitar) = "L", par_lHabilitar, .T.)
1517:         ENDIF
1518:     ENDPROC
1519: 
1520:     *==========================================================================
1521:     * Destroy - Rede de seguranca: reabilita o form pai (caso o usuario
1522:     * feche a janela por outro caminho que nao o BtnCancelarClick, que ja
1523:     * reabilita) e libera BO/referencias antes do DODEFAULT().
1524:     *==========================================================================
1525:     PROCEDURE Destroy()
1526:         LOCAL loc_oErro
1527: 
1528:         THIS.HabilitarFormPai(.T.)
1529: 
1530:         TRY
1531:             THIS.this_oBusinessObject = .NULL.
1532:             THIS.this_oFormPai        = .NULL.
1533:             THIS.this_oFormPai2       = .NULL.
1534:         CATCH TO loc_oErro
1535:             *-- Destruicao nao bloqueia saida
1536:         ENDTRY
1537: 
1538:         DODEFAULT()
1539:     ENDPROC
1540: 
1541: ENDDEFINE


### BO (C:\4c\projeto\app\classes\SigOpNFdBO.prg):
*==============================================================================
* SigOpNFdBO.prg - Business Object para SigOpNFd (Eventos NFe)
*
* Form OPERACIONAL (SIGOPNFD.SCX, Caption "Eventos NFe"). NAO eh cadastro
* CRUD: eh um dialogo FILHO, aberto pelo form de movimentacao/nota fiscal
* (ParentForm) passando (pForm1, pForm2, pDId, pEvento), que registra na
* SEFAZ um EVENTO sobre uma NFe ja emitida:
*
*   pEvento = 'CAN' -> CANCELAMENTO       (tpEvento 110111)
*   pEvento = 'CAR' -> CARTA DE CORRECAO  (tpEvento 110110)
*
* Fluxo do legado (a reproduzir nas fases seguintes):
*
*   Init do form
*     - Evento := pEvento; rotulo do campo GetEvento conforme o evento
*     - getData.Value := ttoc(DATETIME())
*     - atucur()  -> le o ULTIMO evento desta operacao e, se for 'CAR' ou se
*                    nao houver linha, APPEND BLANK + Replace no cursor de
*                    SigMvNfd com nfeseq = ultimo + 1 (1 quando nao ha linha)
*     - le SigMvCab pela chave empdopnums da nota
*     - le a configuracao da operacao (SigCdOpe + SigOpCdd + SigOpCdc +
*       SigOpCdi) para o cursor LocalOpe
*
*   atucur (metodo do form legado)
*     Select * From SigMvNfd Where empdopnums = <chave> And nfeEve = <evento>
*       Order By nfeseq desc
*     lnUltSeq = IIF(EOF(), 1, nfeseq + 1)
*     Replace cidchaves With fUniqueIds(), nfis, dopes, numes, emps,
*             empdopnums, nfedte With CTOT(getData.Value), nfedesc With '',
*             nfeeve With Evento, nfeseq With lnUltSeq
*     Espelha nfis / nfeseq / nfedesc nos campos da tela
*
*   btnSelItens.Click ("Enviar") - tres caminhos, decididos por SigCdOpe.CupFis
*     CupFis = 5 -> NFCe emitida pelo Migrate: cancela pela DLL
*                   DarumaFramework (tCFCancelar_NFCe_Daruma), exigindo
*                   SigPrNfe.stats = 'EMI' e situacao '100' na consulta
*     CupFis = 6 -> CF-e do SAT: canccfe() monta o XML de cancelamento
*                   (cursor CFTags) e grava SigMvNfi.canxml
*     demais     -> NFe pela UniNFe: valida/envia o XML do evento, le o
*                   retorno (cStat/xMotivo), grava SigMvNfd.nfexml +
*                   nfedesc, marca SigMvNfi.cancelas / SigPrNfe.stats e
*                   envia o XML por e-mail ao cliente
*     Fecha SEMPRE com atucur() (repopula o cursor do evento)
*
*   conscan (metodo do form legado)
*     Monta consSitNFe versao 4.00, envia pela UniNFe e, com cStat 100/101,
*     grava SigPrNfe.stats = 'CAN' / statts = '0' / prots = <nProt>
*
*   Refazer.Click
*     Marcado    -> reusa o ULTIMO evento gravado (nao cria sequencia nova):
*                   reenvia o XML de cancelamento ou reimprime a carta
*     Desmarcado -> atucur() (volta a criar a proxima sequencia)
*
* TABELAS E COLUNAS - todos os nomes conferidos em docs/schema.sql lido com
* Get-Content -Raw (o arquivo eh UTF-16; grep/findstr devolvem ZERO em
* silencio - regra #14 do CLAUDE.md):
*
*   SigMvNfd (tabela principal deste BO - um registro por EVENTO da nota)
*     cidchaves  char(20)      NOT NULL  PK (fUniqueIds no legado)
*     dopes      char(20)      NOT NULL
*     empdopnums char(29)      NOT NULL  Emps(3) + Dopes(20) + Str(Numes,6)
*     emps       char(3)       NOT NULL
*     nfedesc    text          NULL      justificativa / texto da correcao
*     nfedte     datetime      NULL      data/hora do evento (dhEvento)
*     nfeeve     char(3)       NOT NULL  'CAN' ou 'CAR'
*     nfeprt     char(15)      NOT NULL  protocolo
*     nfeseq     numeric(2,0)  NOT NULL  nSeqEvento (1..99)
*     nfexml     text          NULL      XML do evento autorizado
*     nfis       char(6)       NOT NULL  numero da nota
*     numes      numeric(6,0)  NOT NULL
*     numeronota char(10)      NOT NULL
*
*   SigMvNfi (nota fiscal de origem - crSigMvNfi no legado; gravada pelo
*            form PAI, lida e marcada por este fluxo)
*     cidchaves char(20), empdopnums char(29), emps char(3), dopes char(20),
*     numes numeric(6,0), nfis char(6), series char(8), clifors char(20),
*     emis datetime NULL, nfechv char(44), nfeprt char(15),
*     nfexml text NULL, canxml text NULL, cancelas bit
*
*   SigPrNfe (situacao da NFe - crSigPrNfe no legado)
*     stats char(3), statts char(1), prots char(15), arquivos char(250)
*
*   SigMvCab (cabecalho do movimento - crSigMvCab no legado)
*     empdopnums char(29), dopes char(20), lcancelas bit
*
*   SigCdOpe  cupfis numeric(1,0), dopes char(20)   (5=NFCe Migrate, 6=SAT)
*   SigOpCdd  configgers char(250)  (posicao 239..241 = empresa emitente)
*   SigOpCdc  cncaixas char(3), geropes numeric(1,0), dopenfs char(20)
*   SigCdPac  direxpsdfs char(200) (pasta de backup do XML)
*   SigCdEmp  cemps char(3) PK, razas char(40), cgcs char(20),
*             pastas char(50), textonfe text, emailnfe char(250),
*             servs char(50), senhas char(30), portas numeric(3,0),
*             textopaf text
*             ATENCAO (regra #48): a coluna de empresa de SigCdEmp eh
*             CEMPS; em SigMvNfd/SigMvNfi/SigPrNfe/SigMvCab eh EMPS.
*   SigCdCli  iclis char(10) PK, emails char(50)
*
* Nao sobrescreve Inserir()/Atualizar()/ExecutarExclusao() no sentido CRUD
* classico: a gravacao do evento (Fase 2) espelha o APPEND BLANK + Replace
* do legado sobre SigMvNfd, por isso this_cTabela/this_cCampoChave apontam
* para SigMvNfd/cidchaves.
*
* Herda de: BusinessBase
* Criado em: Fase 1 - Propriedades e Init
*==============================================================================

DEFINE CLASS SigOpNFdBO AS BusinessBase

    *==========================================================================
    * SigMvNfd - registro do EVENTO (tabela principal deste BO)
    *
    * nfedte eh declarada com {/:} (DATETIME vazio, VARTYPE "T") e NAO com {}
    * (DATE): a hora faz parte do dhEvento enviado a SEFAZ, e so com tipo "T"
    * o FormatarDataSQL() acrescenta " HH:MM:SS" ao literal. Pelo mesmo motivo
    * NUNCA aplicar TTOD() a esta property (regra #16) - o valor vem de
    * CTOT(<TextBox>.Value) no form e pode chegar como DATE quando o campo
    * esta vazio; normalizar com ConverterParaData() apenas onde se quiser a
    * DATA pura (nome da pasta de autorizados, por exemplo).
    *==========================================================================
    this_cCidchaves  = ""     && cidchaves  char(20) NOT NULL - PK (fUniqueIds)
    this_cDopes      = ""     && dopes      char(20) NOT NULL - documento da operacao
    this_cEmpDopNums = ""     && empdopnums char(29) NOT NULL - Emps+Dopes+Str(Numes,6)
    this_cEmps       = ""     && emps       char(3)  NOT NULL - empresa do movimento
    this_cNfedesc    = ""     && nfedesc    text     NULL     - justificativa / correcao
    this_dNfedte     = {/:}   && nfedte     datetime NULL     - data/hora do evento
    this_cNfeeve     = ""     && nfeeve     char(3)  NOT NULL - 'CAN' ou 'CAR'
    this_cNfeprt     = ""     && nfeprt     char(15) NOT NULL - protocolo do evento
    this_nNfeseq     = 0      && nfeseq     numeric(2,0) NOT NULL - nSeqEvento (1..99)
    this_cNfexml     = ""     && nfexml     text     NULL     - XML do evento autorizado
    this_cNfis       = ""     && nfis       char(6)  NOT NULL - numero da nota
    this_nNumes      = 0      && numes      numeric(6,0) NOT NULL
    this_cNumeroNota = ""     && numeronota char(10) NOT NULL

    *==========================================================================
    * SigMvNfi - nota fiscal de ORIGEM (crSigMvNfi no legado)
    *
    * Prefixo "Nfi" nos nomes porque SigMvNfi e SigMvNfd tem colunas
    * HOMONIMAS com conteudo diferente (nfis, nfeprt, nfexml, emps, dopes,
    * numes, empdopnums, cidchaves): sem o prefixo, o protocolo da NOTA
    * sobrescreveria o protocolo do EVENTO.
    *==========================================================================
    this_cNfiCidchaves  = ""     && cidchaves  char(20) - PK da nota
    this_cNfiEmpDopNums = ""     && empdopnums char(29) - liga nota, evento e cabecalho
    this_cNfiEmps       = ""     && emps       char(3)
    this_cNfiDopes      = ""     && dopes      char(20)
    this_nNfiNumes      = 0      && numes      numeric(6,0)
    this_cNfiNfis       = ""     && nfis       char(6)  - numero da nota (exibido na tela)
    this_cNfiSeries     = ""     && series     char(8)  - serie da nota
    this_cNfiCliFors    = ""     && clifors    char(20) - cliente/fornecedor (SigCdCli.IClis)
    this_dNfiEmis       = {/:}   && emis       datetime NULL - emissao (pasta de autorizados)
    this_cNfiNfechv     = ""     && nfechv     char(44) - chave de acesso da NFe (cId / chNFe)
    this_cNfiNfeprt     = ""     && nfeprt     char(15) - protocolo da AUTORIZACAO (nProt)
    this_cNfiNfexml     = ""     && nfexml     text NULL - XML de autorizacao (origem do tpAmb)
    this_cNfiCanxml     = ""     && canxml     text NULL - XML do cancelamento
    this_lNfiCancelas   = .F.    && cancelas   bit - nota cancelada

    *==========================================================================
    * SigPrNfe - situacao da NFe (crSigPrNfe no legado)
    *
    * stats = 'EMI' eh pre-requisito para os dois eventos; o cancelamento
    * tambem aceita 'CAN' (reenvio). Ao autorizar o cancelamento o legado
    * grava stats = 'CAN' + statts = '0' e, no conscan, prots = <nProt>.
    *==========================================================================
    this_cStats    = ""   && stats    char(3)   - 'EMI' / 'CAN'
    this_cStatts   = ""   && statts   char(1)   - '0' apos cancelar
    this_cProts    = ""   && prots    char(15)  - protocolo retornado pela consulta
    this_cArquivos = ""   && arquivos char(250) - justificativa gravada no cancelamento de NFCe

    *==========================================================================
    * SigMvCab - cabecalho do movimento (crSigMvCab no legado)
    *==========================================================================
    this_cCabDopes     = ""    && dopes     char(20) - operacao do movimento (le a config da operacao)
    this_lCabLCancelas = .F.   && lcancelas bit - marca a OPERACAO como cancelada

    *==========================================================================
    * Configuracao da OPERACAO (cursor LocalOpe do legado: SigCdOpe +
    * SigOpCdd + SigOpCdc + SigOpCdi) e parametros do sistema (SigCdPac)
    *==========================================================================
    this_nCupFis     = 0    && SigCdOpe.cupfis     numeric(1,0) - 5=NFCe Migrate, 6=CF-e SAT, outros=NFe
    this_cConfigGers = ""   && SigOpCdd.configgers char(250)    - 239..241 = empresa emitente
    this_cCnCaixas   = ""   && SigOpCdc.cncaixas   char(3)      - numero do caixa (SAT: numeroCaixa)
    this_nGeropes    = 0    && SigOpCdc.geropes    numeric(1,0) - 4 = gera operacao automatica
    this_cDopenfs    = ""   && SigOpCdc.dopenfs    char(20)     - operacao gerada automaticamente
    this_cDirExpSdfs = ""   && SigCdPac.direxpsdfs char(200)    - pasta de backup do XML

    *==========================================================================
    * Empresa EMITENTE (cursor LocalEmp do legado: SigCdEmp da empresa
    * resolvida em ConfigGers 239..241, com fallback na empresa da nota)
    *
    * textopaf guarda, em posicoes FIXAS, os dados do SAT:
    *   1..14    CNPJ da casa de software (CNPJ da AC)
    *   16..359  assinatura (signAC)
    *   361..370 fabricante do equipamento SAT
    *==========================================================================
    this_cEmpCemps    = ""   && SigCdEmp.cemps    char(3) PK - empresa emitente
    this_cEmpRazas    = ""   && SigCdEmp.razas    char(40)
    this_cEmpCgcs     = ""   && SigCdEmp.cgcs     char(20) - CNPJ (a pasta do XML usa so os digitos)
    this_cEmpPastas   = ""   && SigCdEmp.pastas   char(50) - pasta raiz da UniNFe (cPathUni)
    this_cEmpTextoNfe = ""   && SigCdEmp.textonfe text NULL - corpo do e-mail
    this_cEmpEmailNfe = ""   && SigCdEmp.emailnfe char(250) - remetente / copia
    this_cEmpServs    = ""   && SigCdEmp.servs    char(50) - servidor SMTP
    this_cEmpSenhas   = ""   && SigCdEmp.senhas   char(30) - senha SMTP
    this_nEmpPortas   = 0    && SigCdEmp.portas   numeric(3,0) - porta SMTP
    this_cEmpTextoPaf = ""   && SigCdEmp.textopaf text NULL - dados do SAT em posicoes fixas

    *==========================================================================
    * Destinatario (SigCdCli) - e-mail para onde vai o XML do evento
    *==========================================================================
    this_cEmailCliente = ""   && SigCdCli.emails char(50) - WHERE IClis = SigMvNfi.clifors

    *==========================================================================
    * Estado do EVENTO em edicao (campos da tela e parametro de abertura)
    *
    * this_cEvento eh o pEvento recebido pelo form; os rotulos exibidos no
    * campo GetEvento sao atribuidos no Init (precisam de CHR() para os
    * acentos, e declaracao de property nao aceita chamada de funcao).
    *==========================================================================
    this_cEvento             = ""    && 'CAN' (cancelamento) ou 'CAR' (carta de correcao)
    this_cRotuloEvento       = ""    && texto exibido no campo GetEvento
    this_cRotuloCancelamento = ""    && 'CANCELAMENTO'      (atribuido no Init)
    this_cRotuloCarta        = ""    && 'CARTA DE CORRECAO'  (atribuido no Init, com CHR())
    this_lRefazer            = .F.   && CheckBox Refazer: reusa o ULTIMO evento gravado
    this_lHorarioVerao       = .F.   && CheckBox Horario de Verao: fuso 02:00 em vez de 03:00
    this_cFusoHorario        = ""    && '02:00' / '03:00' - sufixo do dhEvento (vem do CheckBox)
    this_nUltimaSequencia    = 0     && lnUltSeq do atucur: ultimo nfeseq + 1 (1 se nao ha evento)

    *==========================================================================
    * Constantes do evento NFe (layout nacional) - transcritas do legado
    *==========================================================================
    this_cTpEventoCancelamento = "110111"   && tpEvento do cancelamento
    this_cTpEventoCarta        = "110110"   && tpEvento da carta de correcao
    this_cVersaoEvento         = "1.00"     && versao do envEvento / evento / detEvento
    this_cVersaoConsulta       = "4.00"     && versao do consSitNFe (conscan)
    this_nTamMinDescricao      = 15         && LEN(ALLTRIM(nfedesc)) < 15 recusa o envio
    this_nMaxSequencia         = 99         && nfeseq eh numeric(2,0): 1..99

    *==========================================================================
    * Retorno da SEFAZ / do SAT (lido do XML de retorno)
    *==========================================================================
    this_cTipoAmbiente     = ""   && tpAmb extraido do XML de autorizacao da nota
    this_cStatusRetorno    = ""   && cStat (135 / 'EVENTO REGISTRADO' no evento; 100/101 no conscan)
    this_cMotivoRetorno    = ""   && xMotivo
    this_cMensagemRetorno  = ""   && mensagem montada para o usuario (cCampo no legado)
    this_cProtocoloRetorno = ""   && nProt retornado pela consulta de situacao
    this_cConteudoXml      = ""   && conteudo do XML autorizado (gravado em nfexml / canxml)

    *==========================================================================
    * Caminhos de arquivo da UniNFe - a pasta raiz vem de SigCdEmp.pastas e as
    * subpastas sao FIXAS no legado (nomes transcritos literalmente, pois sao
    * os nomes que o UniNFe monitora em disco)
    *==========================================================================
    this_cPathUni      = ""   && cPathUni - SigCdEmp.pastas
    this_cPathNFe      = ""   && cPathUni + <CNPJ sem pontuacao> + "\"
    this_cPathBackup   = ""   && SigCdPac.direxpsdfs ou cPathUni + "BKP\"
    this_cCnpjEmitente = ""   && SigCdEmp.cgcs sem ponto, barra e hifen
    this_cChaveAcesso  = ""   && cId - SigMvNfi.nfechv (44 posicoes)

    this_cPastaEnvio       = "envio\"
    this_cPastaEnviado     = "Enviado\"
    this_cPastaEmProc      = "Enviado\EmProcessamento\"
    this_cPastaEnvioLote   = "EnvioEmLote\"
    this_cPastaErro        = "Erro\"
    this_cPastaRetorno     = "Retorno\"
    this_cPastaValidar     = "Validar\"
    this_cPastaBkEnviados  = "BKenviados\"
    this_cPastaAssinado    = "Assinado\"
    this_cPastaValidado    = "Validado\"
    this_cPastaAutorizados = "Enviado\Autorizados\"
    this_cPastaPdf         = "PDF\"
    this_cPastaTxt         = "TXT\"

    *==========================================================================
    * CF-e do SAT (canccfe do legado) - dados lidos de SigCdEmp.textopaf
    *==========================================================================
    this_cCnpjAC        = ""   && textopaf 1..14    - CNPJ da casa de software
    this_cAssinaturaAC  = ""   && textopaf 16..359  - signAC
    this_cFabricanteSat = ""   && textopaf 361..370 - SWEDA / BEMAT / outros
    this_nCodFabricante = 0    && 3=SWEDA, 2=BEMAT, 0=demais
    this_cXmlCancelaSat = ""   && XML de cancelamento devolvido pelo SAT (pcXml no legado)

    *==========================================================================
    * Nomes dos cursores usados pelo BO e pelo Form (mantidos em property
    * para o Form nao repetir literais - mesmo padrao do SigOpNchBO)
    *==========================================================================
    this_cCursorEventos    = "cursor_4c_Eventos"     && SigMvNfd (crSigMvNfd no legado)
    this_cCursorNota       = "cursor_4c_Nota"        && SigMvNfi (crSigMvNfi)
    this_cCursorSitNFe     = "cursor_4c_SitNFe"      && SigPrNfe (crSigPrNfe)
    this_cCursorCabecalho  = "cursor_4c_Cabecalho"   && SigMvCab (crSigMvCab)
    this_cCursorOperacao   = "cursor_4c_Operacao"    && SigCdOpe + SigOpCdd/Cdc/Cdi (LocalOpe)
    this_cCursorEmpresa    = "cursor_4c_Empresa"     && SigCdEmp (LocalEmp)
    this_cCursorCliente    = "cursor_4c_Cliente"     && SigCdCli (LocalCliD)
    this_cCursorParametros = "cursor_4c_Parametros"  && SigCdPac (crSigCdPac)
    this_cCursorTagsCFe    = "cursor_4c_TagsCFe"     && CFTags - estrutura do XML do SAT

    *==========================================================================
    * Init - Configura tabela/chave principal (SigMvNfd) e os rotulos de
    *        evento que dependem de CHR() para os acentos.
    *
    * NAO faz acesso a banco: Init que retorna .F. mata o form, e o BO eh
    * instanciado tambem pelo harness de teste, sem gnConnHandle valido.
    *==========================================================================
    PROCEDURE Init()
        LOCAL loc_lResultado
        loc_lResultado = .F.

        TRY
            DODEFAULT()

            *-- Tabela gravada por este BO: um registro por evento da nota
            THIS.this_cTabela     = "SigMvNfd"
            THIS.this_cCampoChave = "cidchaves"

            *-- Rotulos exibidos no campo GetEvento (legado: Init do form)
            THIS.this_cRotuloCancelamento = "CANCELAMENTO"
            THIS.this_cRotuloCarta        = "CARTA DE CORRE" + CHR(199) + CHR(195) + "O"

            *-- Fuso default do dhEvento: sem horario de verao o legado usa
            *-- '03:00' (IIF(thisform.verao.Value = 1, '02:00', '03:00'))
            THIS.this_cFusoHorario = "03:00"

            loc_lResultado = .T.

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Erro ao inicializar SigOpNFdBO")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * ObterChavePrimaria - Valor da PK de SigMvNfd para RegistrarAuditoria
    *==========================================================================
    PROTECTED PROCEDURE ObterChavePrimaria()
        RETURN ALLTRIM(NVL(THIS.this_cCidchaves, ""))
    ENDPROC

    *==========================================================================
    * CarregarDoCursor - Carrega a linha corrente de SigMvNfd (crSigMvNfd no
    * legado - par_cAliasCursor eh tipicamente THIS.this_cCursorEventos) nas
    * properties deste BO. Mapeia TODAS as 13 colunas da tabela, na ordem do
    * schema (regra #22 do CLAUDE.md - conferido em docs/schema.sql lido com
    * Get-Content -Raw, por ser UTF-16).
    *
    * SELECT (par_cAliasCursor) primeiro, depois campo sem alias (Problema 9
    * do FORMCOR_LICOES_APRENDIDAS.md - "campo" eh sintaxe invalida
    * em VFP9).
    *==========================================================================
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lResultado
        loc_lResultado = .F.

        IF VARTYPE(par_cAliasCursor) = "C" AND USED(par_cAliasCursor)
            SELECT (par_cAliasCursor)

            IF !EOF()
                THIS.this_cCidchaves  = TratarNulo(cidchaves, "")
                THIS.this_cDopes      = TratarNulo(dopes, "")
                THIS.this_cEmpDopNums = TratarNulo(empdopnums, "")
                THIS.this_cEmps       = TratarNulo(emps, "")
                THIS.this_cNfedesc    = TratarNulo(nfedesc, "")
                THIS.this_dNfedte     = TratarNulo(nfedte, {/:})
                THIS.this_cNfeeve     = TratarNulo(nfeeve, "")
                THIS.this_cNfeprt     = TratarNulo(nfeprt, "")
                THIS.this_nNfeseq     = TratarNulo(nfeseq, 0)
                THIS.this_cNfexml     = TratarNulo(nfexml, "")
                THIS.this_cNfis       = TratarNulo(nfis, "")
                THIS.this_nNumes      = TratarNulo(numes, 0)
                THIS.this_cNumeroNota = TratarNulo(numeronota, "")

                loc_lResultado = .T.
            ENDIF
        ENDIF

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * MontarInsertEvento - Fonte UNICA do SQL de INSERT em SigMvNfd. Espelha o
    * "APPEND BLANK + Replace" do atucur() legado (linhas 564-574 do dump):
    *
    *   replace cidchaves with fUniqueIds(), nfis with crsigmvnfi.nfis,
    *           dopes with crsigmvnfi.dopes, numes with crsigmvnfi.numes,
    *           emps with crsigmvnfi.emps, empdopnums with crsigmvnfi.empdopnums,
    *           nfedte with CTOT(thisform.cntData.getData.Value),
    *           nfedesc with '', nfeeve with thisform.Evento,
    *           nfeseq with lnUltSeq in crSigMvNfd
    *
    * nfis/dopes/numes/emps/empdopnums vem das properties "Nfi" (espelham
    * crSigMvNfi - a nota de ORIGEM), nao das properties homonimas da nota
    * (que sao colunas DIFERENTES, com conteudo do proprio EVENTO).
    *
    * nfeprt char(15) NOT NULL e numeronota char(10) NOT NULL NUNCA aparecem
    * no atucur() nem em nenhum outro ponto do dump legado contra crSigMvNfd -
    * exatamente a armadilha da regra #22 (coluna invisivel no dump porque so
    * existia no buffer em branco do AddCursor). Gravar EscaparSQL("") para
    * as duas explicitamente, para nao violar o NOT NULL.
    *
    * nfedesc e nfexml sao NULL no schema. nfedesc vai com this_cNfedesc (e
    * NAO com '' literal): o '' do APPEND legado e valor INICIAL do cursor em
    * memoria - quando a linha chega de fato ao banco, pelo
    * "poDataMgr.Update([crSigMvNfd])" do Click, ela ja passou pelo "replace
    * nfedesc with lcdesc" (linhas 1406 e 1649 do dump) e carrega a
    * justificativa digitada. Gravar '' aqui perderia a descricao em todo
    * evento novo - exatamente o campo que o fluxo existe para registrar.
    * nfexml fica NULL (o legado nunca o toca antes da autorizacao; quem
    * grava o XML autorizado e Atualizar()).
    *==========================================================================
    PROTECTED PROCEDURE MontarInsertEvento()
        LOCAL loc_cSQL

        loc_cSQL = "INSERT INTO SigMvNfd (cidchaves, dopes, empdopnums, emps, " + ;
                   "nfedesc, nfedte, nfeeve, nfeprt, nfeseq, nfexml, nfis, " + ;
                   "numes, numeronota) VALUES (" + ;
                   EscaparSQL(LEFT(THIS.this_cCidchaves, 20)) + ", " + ;
                   EscaparSQL(LEFT(THIS.this_cDopes, 20)) + ", " + ;
                   EscaparSQL(LEFT(THIS.this_cEmpDopNums, 29)) + ", " + ;
                   EscaparSQL(LEFT(THIS.this_cEmps, 3)) + ", " + ;
                   EscaparSQL(THIS.this_cNfedesc) + ", " + ;
                   FormatarDataSQL(THIS.this_dNfedte) + ", " + ;
                   EscaparSQL(LEFT(THIS.this_cNfeeve, 3)) + ", " + ;
                   EscaparSQL(LEFT(THIS.this_cNfeprt, 15)) + ", " + ;
                   FormatarNumeroSQL(THIS.this_nNfeseq, 0) + ", " + ;
                   "NULL, " + ;
                   EscaparSQL(LEFT(THIS.this_cNfis, 6)) + ", " + ;
                   FormatarNumeroSQL(THIS.this_nNumes, 0) + ", " + ;
                   EscaparSQL(LEFT(THIS.this_cNumeroNota, 10)) + ")"

        RETURN loc_cSQL
    ENDPROC

    *==========================================================================
    * MontarUpdateEvento - Fonte UNICA do SQL de UPDATE em SigMvNfd. Espelha o
    * UNICO Update que o legado faz contra crSigMvNfd (btnSelItens.Click,
    * linhas 1405-1406 e 1648-1649 do dump, repetido nos tres caminhos de
    * envio - NFCe/Migrate nao atualiza SigMvNfd, so SAT e UniNFe):
    *
    *   replace nfexml with cConteudoxml in crSigMvNfd
    *   replace nfedesc with lcdesc in crSigMvNfd
    *
    * So essas DUAS colunas sao tocadas em algum ponto do fluxo legado depois
    * do INSERT inicial - o resto do registro (chave, nota de origem, sequencia)
    * nasce certo no atucur() e nunca muda. Atualizar nfedte/nfeprt/nfeseq aqui
    * seria regra de negocio inventada (regra #17 do CLAUDE.md).
    *==========================================================================
    PROTECTED PROCEDURE MontarUpdateEvento()
        LOCAL loc_cSQL

        loc_cSQL = "UPDATE SigMvNfd SET " + ;
                   "nfedesc = " + EscaparSQL(THIS.this_cNfedesc) + ", " + ;
                   "nfexml = " + IIF(EMPTY(THIS.this_cNfexml), "NULL", EscaparSQL(THIS.this_cNfexml)) + ;
                   " WHERE cidchaves = " + EscaparSQL(LEFT(THIS.this_cCidchaves, 20))

        RETURN loc_cSQL
    ENDPROC

    *==========================================================================
    * Inserir - INSERT de UM evento em SigMvNfd (caminho BusinessBase.Salvar e
    * o equivalente, nesta arquitetura, do atucur()/APPEND BLANK legado).
    *
    * cidchaves eh gerado AQUI quando ainda vazio, reproduzindo
    * "replace cidchaves with fUniqueIds()" - NUNCA string vazia (regra #22:
    * colidiria no indice unico do segundo evento).
    *==========================================================================
    PROCEDURE Inserir()
        LOCAL loc_lSucesso, loc_cSQL, loc_nResultado, loc_cErro, loc_oErro

        loc_lSucesso = .F.
        THIS.this_cMensagemErro = ""

        TRY
            IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
                THIS.this_cMensagemErro = "Conex" + CHR(227) + "o com o banco de " + ;
                                          "dados indispon" + CHR(237) + "vel."
            ELSE
                IF EMPTY(THIS.this_cCidchaves)
                    THIS.this_cCidchaves = fUniqueIds()
                ENDIF

                loc_cSQL = THIS.MontarInsertEvento()
                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

                IF loc_nResultado < 0
                    loc_cErro = CapturarErroSQL()
                    THIS.this_cMensagemErro = "Erro na Grava" + CHR(231) + CHR(227) + ;
                        "o do Evento da NFe." + CHR(13) + loc_cErro
                    MsgErro(THIS.this_cMensagemErro, "Erro")
                    THIS.this_lErroExibido = .T.
                ELSE
                    THIS.RegistrarAuditoria("INSERT")
                    loc_lSucesso = .T.
                ENDIF
            ENDIF

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Erro em SigOpNFdBO.Inserir")
            THIS.this_lErroExibido = .T.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * ConsultarUltimoEvento - SELECT do atucur() legado (linhas 552-558 do
    * dump):
    *
    *   lcEDN = crSigmvNfi.empdopnums
    *   lcQuery = Select * From SigMvNfd Where empdopnums = <lcEDN>
    *             and nfeEve = <thisform.Evento> order by nfeseq desc
    *
    * Carrega a linha mais recente (se houver) nas properties deste BO via
    * CarregarDoCursor. NAO faz APPEND BLANK - isso fica em
    * AtualizarUltimoEvento(), que decide se cria linha nova ou reusa esta.
    *
    * GUARDA: this_cNfiEmpDopNums (chave da nota de origem) ainda nao e
    * populada em nenhuma fase deste BO - a leitura do contexto da nota via
    * SigMvNfi (que no legado chega pela DataSession compartilhada com o
    * form pai) e a mesma pendencia ja documentada em
    * FormSigOpNFd.BtnEnviarClick e no cabecalho desta classe ("Fluxo do
    * legado... fases seguintes"). Consultar com a chave vazia casaria
    * empdopnums = '' e corromperia o diagnostico de "encontrado"/"nao
    * encontrado" - por isso o metodo nao tenta a consulta nesse caso.
    *==========================================================================
    PROCEDURE ConsultarUltimoEvento()
        LOCAL loc_lEncontrado, loc_cSQL, loc_nResultado, loc_oErro
        loc_lEncontrado = .F.

        IF EMPTY(THIS.this_cNfiEmpDopNums)
            RETURN .F.
        ENDIF

        TRY
            IF TYPE("gnConnHandle") = "N" AND gnConnHandle > 0
                IF USED(THIS.this_cCursorEventos)
                    USE IN (THIS.this_cCursorEventos)
                ENDIF

                loc_cSQL = "SELECT * FROM SigMvNfd WHERE empdopnums = " + ;
                           EscaparSQL(LEFT(THIS.this_cNfiEmpDopNums, 29)) + ;
                           " AND nfeeve = " + EscaparSQL(LEFT(THIS.this_cEvento, 3)) + ;
                           " ORDER BY nfeseq DESC"

                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, THIS.this_cCursorEventos)

                IF loc_nResultado >= 0 AND USED(THIS.this_cCursorEventos) AND !EOF(THIS.this_cCursorEventos)
                    THIS.CarregarDoCursor(THIS.this_cCursorEventos)
                    loc_lEncontrado = .T.
                ENDIF
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Erro em SigOpNFdBO.ConsultarUltimoEvento")
        ENDTRY

        RETURN loc_lEncontrado
    ENDPROC

    *==========================================================================
    * AtualizarUltimoEvento - Equivalente ao atucur() legado completo (linhas
    * 548-584 do dump): consulta o ultimo evento (ConsultarUltimoEvento) e,
    * quando o evento e 'CAR' (carta de correcao sempre gera sequencia nova)
    * OU nao ha nenhum evento anterior, PREPARA a linha nova (equivalente ao
    * "APPEND BLANK + Replace" do legado). Quando acha um evento 'CAN'
    * existente, apenas REUSA os dados ja carregados por
    * ConsultarUltimoEvento (igual ao legado, que nesse caso NAO cria linha
    * nova).
    *
    * NAO PERSISTE NADA - e isso e fidelidade ao legado, nao omissao. O
    * "APPEND BLANK + replace ... in crSigMvNfd" do atucur mexe apenas no
    * CURSOR em memoria; quem grava e o Click do botao Enviar, que faz
    * "replace nfedesc with lcdesc in crSigMvNfd" e so entao
    * "poDataMgr.Update([crSigMvNfd]) + Commit()" (linhas 1406-1430 e
    * 1649-1660 do dump). Chamar Salvar() aqui gravaria um evento de
    * descricao vazia a CADA abertura do dialogo (inclusive quando o usuario
    * desiste e clica Cancelar) e um SEGUNDO registro no Enviar.
    *
    * O que este metodo deixa pronto e o MODO de gravacao do BO:
    * NovoRegistro() no ramo da linha nova (Salvar -> Inserir) e
    * EditarRegistro() no ramo de reuso (Salvar -> Atualizar). Quem dispara
    * a gravacao e FormSigOpNFd.BtnEnviarClick, com a descricao final ja
    * lida do controle.
    *
    * par_dDataHora equivale a "CTOT(thisform.cntData.getData.Value)" do
    * legado - o Form passa o valor atual do campo de data/hora, porque esta
    * e uma leitura de CONTROLE da tela (camada de UI), nao de cursor.
    *
    * Mesma guarda de ConsultarUltimoEvento: sem this_cNfiEmpDopNums nao ha
    * como montar um registro valido (emps/dopes/numes/nfis viriam vazios),
    * entao o metodo nao grava nada e devolve .F.
    *==========================================================================
    PROCEDURE AtualizarUltimoEvento(par_dDataHora)
        LOCAL loc_lEncontrado, loc_lSucesso
        loc_lSucesso = .F.

        IF EMPTY(THIS.this_cNfiEmpDopNums)
            RETURN .F.
        ENDIF

        loc_lEncontrado = THIS.ConsultarUltimoEvento()
        THIS.this_nUltimaSequencia = IIF(loc_lEncontrado, THIS.this_nNfeseq + 1, 1)

        IF THIS.this_cEvento = "CAR" OR !loc_lEncontrado
            THIS.NovoRegistro()

            THIS.this_cCidchaves  = ""
            THIS.this_cDopes      = THIS.this_cNfiDopes
            THIS.this_cEmpDopNums = THIS.this_cNfiEmpDopNums
            THIS.this_cEmps       = THIS.this_cNfiEmps
            THIS.this_nNumes      = THIS.this_nNfiNumes
            THIS.this_cNfis       = THIS.this_cNfiNfis
            THIS.this_cNfedesc    = ""
            THIS.this_dNfedte     = IIF(VARTYPE(par_dDataHora) = "T", par_dDataHora, {/:})
            THIS.this_cNfeeve     = THIS.this_cEvento
            THIS.this_nNfeseq     = THIS.this_nUltimaSequencia

            loc_lSucesso = .T.
        ELSE
            *-- Legado nao faz APPEND neste ramo: REUSA a linha que o SELECT
            *-- trouxe (this_cCidchaves/this_cNfedesc/this_nNfeseq/this_cNfis
            *-- ja vieram de ConsultarUltimoEvento via CarregarDoCursor), e o
            *-- "replace nfedesc ... in crSigMvNfd" do Click vira UPDATE.
            *-- EditarRegistro deixa this_lNovoRegistro = .F., que eh o que
            *-- faz BusinessBase.Salvar() rotear para Atualizar() em vez de
            *-- Inserir().
            *--
            *-- RESET do modo ANTES de EditarRegistro: BusinessBase.
            *-- EditarRegistro() RECUSA (devolve .F. com "Nao ha registro
            *-- para editar") quando this_lNovoRegistro ainda esta .T., e
            *-- este metodo eh um FUNIL que roda VARIAS vezes na mesma vida
            *-- do form - uma abertura em 'CAR'/sem evento anterior passa
            *-- pelo ramo de cima e deixa a flag ligada, e a chamada seguinte
            *-- (Refazer desmarcado, ou o atucur do fim do Enviar) cai aqui
            *-- com ela ainda ligada. Sem o reset, o ramo de reuso falharia e
            *-- o BO continuaria em modo INSERT: o Salvar seguinte gravaria
            *-- um registro DUPLICADO onde o legado faz UPDATE.
            *--
            *-- A flag eh zerada na mao, e NAO por CancelarEdicao(): aquele
            *-- chama LimparDados() quando this_lNovoRegistro esta .T., o que
            *-- apagaria as properties que ConsultarUltimoEvento acabou de
            *-- carregar do banco, logo acima.
            THIS.this_lNovoRegistro = .F.
            loc_lSucesso = THIS.EditarRegistro()
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * Atualizar - UPDATE do evento existente em SigMvNfd (nfedesc/nfexml) -
    * caminho usado depois que a SEFAZ/SAT autoriza o evento e o XML/
    * justificativa definitivos sao conhecidos.
    *==========================================================================
    PROCEDURE Atualizar()
        LOCAL loc_lSucesso, loc_cSQL, loc_nResultado, loc_cErro, loc_oErro

        loc_lSucesso = .F.
        THIS.this_cMensagemErro = ""

        TRY
            IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
                THIS.this_cMensagemErro = "Conex" + CHR(227) + "o com o banco de " + ;
                                          "dados indispon" + CHR(237) + "vel."
            ELSE
                IF EMPTY(THIS.this_cCidchaves)
                    THIS.this_cMensagemErro = "Evento da NFe n" + CHR(227) + ;
                        "o identificado para atualiza" + CHR(231) + CHR(227) + "o."
                ELSE
                    loc_cSQL = THIS.MontarUpdateEvento()
                    loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

                    IF loc_nResultado < 0
                        loc_cErro = CapturarErroSQL()
                        THIS.this_cMensagemErro = "Erro na Grava" + CHR(231) + CHR(227) + ;
                            "o do Evento da NFe." + CHR(13) + loc_cErro
                        MsgErro(THIS.this_cMensagemErro, "Erro")
                        THIS.this_lErroExibido = .T.
                    ELSE
                        THIS.RegistrarAuditoria("UPDATE")
                        loc_lSucesso = .T.
                    ENDIF
                ENDIF
            ENDIF

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Erro em SigOpNFdBO.Atualizar")
            THIS.this_lErroExibido = .T.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

ENDDEFINE


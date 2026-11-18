# CODE REVIEW - PASS FUNCTIONAL: Functional Logic (metodos, eventos, containers)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Functional Logic (metodos, eventos, containers)**.

## PROBLEMAS DETECTADOS (4)
- [METODO-INEXISTENTE] Metodo 'THIS.Caption()' chamado mas NAO definido como PROCEDURE no Form nem herdado de FormBase. A LLM pode ter inventado este metodo. VERIFICAR se existe no legado e IMPLEMENTAR ou REMOVER a chamada.
- [METODO-INEXISTENTE] Metodo 'THIS.Width()' chamado mas NAO definido como PROCEDURE no Form nem herdado de FormBase. A LLM pode ter inventado este metodo. VERIFICAR se existe no legado e IMPLEMENTAR ou REMOVER a chamada.
- [METODO-INEXISTENTE] Metodo 'THIS.Controls()' chamado mas NAO definido como PROCEDURE no Form nem herdado de FormBase. A LLM pode ter inventado este metodo. VERIFICAR se existe no legado e IMPLEMENTAR ou REMOVER a chamada.
- [GRID-WITH] Bloco WITH THIS.grd_4c_Dados define .RecordSource E acessa .Column dentro do mesmo WITH. Isso causa 'Unknown member COLUMN1' porque colunas nao sao criadas imediatamente dentro de WITH. SOLUCAO: Mover .RecordSource e .ColumnCount para FORA do WITH (usar referencia explicita: THIS.grd_4c_Dados.RecordSource).

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

### FORM (C:\4c\projeto\app\forms\operacionais\FormSigOpSlc.prg) - TRECHOS RELEVANTES PARA PASS FUNCTIONAL (1654 linhas total):

*-- Linhas 28 a 96:
28: *
29: * CHAMADA (equivale ao Do Form SigOpSlc With _GetConta, _GetMoeda, ThisForm
30: * do legado):
31: *   loForm = CREATEOBJECT("FormSigOpSlc", par_lGetConta, par_lGetMoeda, THISFORM)
32: *   IF VARTYPE(loForm) = "O"
33: *       loForm.Show()          && modal: so volta quando o dialogo fecha
34: *   ENDIF
35: *
36: *   Como no legado, o Release eh do PROPRIO dialogo (Cancela.Click e
37: *   Confirma.Click chamam ThisForm.Release - fase 7), nao do chamador. O
38: *   resultado chega ao pai pelas propriedades que os botoes escrevem nele
39: *   (CanceladoExterno / MoedaMaior), nao por retorno de metodo.
40: *
41: * PARAMETROS (legado: LParameters _GetConta, _GetMoeda, _Parent)
42: *   par_lGetConta - aceito por simetria com a assinatura legada, mas SEMPRE
43: *                   sobrescrito para .F. (regra #17 - ver SigOpSlcBO.prg)
44: *   par_lGetMoeda - legado: _GetMoeda. Controla a visibilidade do bloco de
45: *                   moeda e o ajuste de altura da tela (fases seguintes).
46: *                   Omitido, assume .T. (bloco de moeda visivel, que eh o
47: *                   uso real desta tela)
48: *   par_oFormPai  - legado: _Parent. Form que abriu o dialogo e que recebe o
49: *                   resultado (ThisForm.ParentForm, RESERVED3/ClassInfo do
50: *                   SCX = "parentform")
51: *
52: * FASE 3: estrutura base do form - DEFINE CLASS com as propriedades
53: * visuais transcritas do SCX, as propriedades de estado (espelho do
54: * _GetConta/_GetMoeda/_Parent do Init legado), Init com os tres parametros,
55: * ValidarParametros, InicializarForm, ConfigurarDecoracao (Picture),
56: * ConfigurarCabecalho (cntSombra), TornarControlesVisiveis e Destroy.
57: *
58: * FASE 4: bloco de moeda (Label1, SayMoeda, get_cd_moeda, get_ds_moeda -
59: * ConfigurarBlocoMoeda) e o bloco de Grupo/Conta PERMANENTEMENTE OCULTO
60: * (Grade, SayGrupo, SayConta, Get_Grupo, Get_Conta, Get_DCONTA -
61: * ConfigurarBlocoContaGrupo), ambos criados depois do cabecalho. Esta tela
62: * NAO eh um cadastro CRUD (sem Page1=Lista/Page2=Dados, sem botoes Incluir/
63: * Alterar/Excluir) - eh um dialogo modal FILHO que so devolve um codigo de
64: * moeda ao form pai (ver cabecalho de SigOpSlcBO.prg); a grade que existe
65: * no SCX (RecordSource = "TmpCliente") pertence ao bloco morto de Conta,
66: * nunca a uma lista de registros deste form.
67: *
68: * FASE 5 (esta fase): ajuste de altura/posicao do Init legado
69: * (AjustarLayoutConformeMoeda) e a busca do default de moeda no cursor do
70: * chamador (CarregarMoedaDefaultDeTmpBaixa). Legado:
71: *
72: *     If !_GetMoeda
73: *         This.Height = This.Height - 25
74: *     Else
75: *         Select TmpBaixa
76: *         Scan for Tipos = 'X'
77: *             This.Get_cd_moeda.value = moedas
78: *             =Seek( moedas, 'crSigCdMoe', 'CMoes' )
79: *             This.Get_ds_moeda.value = crSigCdMoe.dmoes
80: *             exit
81: *         Endscan
82: *     Endif
83: *     If !_GetConta And _GetMoeda
84: *         This.Get_cd_moeda.Top = 50
85: *         This.Get_ds_moeda.top = 50
86: *         This.SayMoeda.top = 54
87: *         This.Height = 100
88: *     Endif
89: *     This.Refresh
90: *
91: * Como this_lExibirConta eh SEMPRE .F. (regra #17), "!_GetConta And
92: * _GetMoeda" equivale sempre a "_GetMoeda" - os dois Ifs do legado cobrem
93: * so os DOIS estados de this_lExibirMoeda (nao quatro combinacoes):
94: *   this_lExibirMoeda = .F. -> This.Height -= 25 (375), sem reposicionar
95: *   this_lExibirMoeda = .T. -> busca o default em TmpBaixa E reposiciona
96: *       get_cd_moeda/get_ds_moeda/SayMoeda, com Height = 100

*-- Linhas 113 a 213:
113: *     get_ds_moeda.Valid: mesma logica, Seek por DMoes
114: *     get_ds_moeda.When:  Return IsEmpty(Thisform.Get_Cd_Moeda.Value)
115: *
116: * CdMoedaLostFocus/DsMoedaLostFocus (BINDEVENT em "LostFocus", nao em
117: * "Valid" - BINDEVENT nao eh confiavel em "Valid" de TextBox, e em
118: * "KeyPress" sem testar a tecla o picker abriria a cada caractere digitado,
119: * regra #47) chamam ValidarMoedaPorCodigo/ValidarMoedaPorDescricao do BO; a
120: * busca por fwBuscaSel vira AbrirBuscaMoeda, Pattern A do FormBuscaAuxiliar
121: * (regra #36/#37 - match exato tentado no Init via this_lAchouRegistro,
122: * Show() so se nao achou, atribuicao so sob this_lSelecionou), igual ao
123: * padrao ja usado para SigCdMoe em Formccr.prg. Guarda de reentrancia
124: * this_lEmLookup (regra #37): o picker eh MODAL e tira o foco do campo, o
125: * que redispara o proprio LostFocus - por isso o corpo de cada handler vive
126: * num metodo *Exec separado, liberado mesmo com RETURN antecipado.
127: *
128: * DsMoedaWhen reproduz o When via BINDEVENT (padrao estabelecido em
129: * FormSigOpBcb.prg/FormSigOpCcl.prg - "When" aceita handler PUBLIC
130: * retornando o logico que decide o foco, diferente de "Valid").
131: *
132: * FASE 7 (esta fase): Click de cmd_4c_Confirma/cmd_4c_Cancela
133: * (CmdConfirmaClick/CmdCancelaClick) - gravam direto em
134: * this_oFormPai.MoedaMaior/CanceladoExterno (ThisForm.ParentForm no legado,
135: * NAO eh um cadastro CRUD: nao ha Incluir/Alterar/Excluir/Visualizar no SCX
136: * nem no Init legado - os UNICOS botoes sao Confirma ("\<Ok") e Cancela
137: * ("Encerrar"), ja criados na fase 4 (ConfigurarBotoesAcao).
138: *
139: * FASE 8 (esta fase): eventos auxiliares do bloco de Grupo/Conta
140: * (ConfigurarEventosContaGrupo) - nao ha FormParaBO/BOParaForm/CarregarLista/
141: * HabilitarCampos/AjustarBotoesPorModo neste form: ele NAO eh um cadastro
142: * CRUD (sem Page1=Lista/Page2=Dados, sem botoes Incluir/Alterar/Excluir), e
143: * sim um dialogo FILHO com dois botoes de saida (Confirma/Cancela, ja ligados
144: * na fase 7). O que faltava para fechar a paridade com o comportamento.json
145: * eram os eventos do bloco oculto de Grupo/Conta - SigOpSlcBO.prg (NOTA do
146: * cabecalho) ja antecipa isso: "Os validadores desses campos ... ficam no
147: * Form (camada de UI), que eh quem os aciona via BINDEVENT". Legado:
148: *
149: *     Get_Grupo.Valid:  If !fAcessoContab(Usuar,'C',This.Value,This,'',
150: *                           Thisform.get_conta.value) / Messagebox('Acesso
151: *                           Negado...',48,'') / This.Value = '' / Endif
152: *     Get_Conta.Valid:  mesma logica com fAcessoContas(Usuar,Get_Grupo.Value,
153: *                           'C',This.Value,This.Get_Conta,This.Get_dConta)
154: *     Get_DCONTA.Valid: mesma logica, tipo 'D'
155: *     Get_DCONTA.When:  Return IsEmpty(Thisform.Get_Conta.Value)
156: *     Grade (AfterRowColChange): ThisForm.Get_Grupo/Get_Conta/Get_DConta.Value
157: *                           = Grupo/Conta/Nome (linha corrente de TmpCliente)
158: *     Grade.ColumnN.Text1.KeyPress: Tab/Enter -> Get_Grupo.SetFocus
159: *
160: * fAcessoContab/fAcessoContas JA EXISTEM como helpers globais portados em
161: * utils\functions.prg (linhas 709/991) e escrevem direto nos TextBox
162: * recebidos por parametro (pCod/pDsc, pSt1/pSt2) - por isso os handlers so
163: * delegam, sem duplicar logica de UI. "This" nos dois ultimos Valid do dump
164: * refere-se ao FORM (ThisForm.Get_Grupo/Get_Conta/Get_DConta), nao ao
165: * TextBox do evento - unico jeito de "This.Get_Grupo" fazer sentido, ja que
166: * TextBox nao tem membro Get_Grupo; aqui o handler mora no FORM (THIS ja eh
167: * o form), entao a leitura fica direta.
168: *
169: * Mesmo com estes handlers implementados, o bloco PERMANECE inatingivel pelo
170: * usuario (this_lExibirConta eh sempre .F. - regra #17): a implementacao
171: * fecha a paridade estrutural com o comportamento.json sem reativar o
172: * bloco. BINDEVENT em "LostFocus" (nao em "Valid", que nao eh confiavel em
173: * TextBox - regra #47) e MsgAviso no lugar do Messagebox cru (icone 48 =
174: * aviso, regra MESSAGEBOX PROIBIDO do CLAUDE.md).
175: *==============================================================================
176: 
177: DEFINE CLASS FormSigOpSlc AS FormBase
178: 
179:     *==========================================================================
180:     * PROPRIEDADES VISUAIS - transcritas do SCX legado (PILAR 1)
181:     *==========================================================================
182: 
183:     *-- SIGOPSLC: Height = 400 / Width = 800
184:     this_cMensagemErro = ""
185:     Height       = 400
186:     Width        = 800
187: 
188:     *-- BorderStyle = 2 (Sizable) / AutoCenter = .T. / ShowTips = .T.
189:     BorderStyle  = 2
190:     AutoCenter   = .T.
191:     ShowTips     = .T.
192: 
193:     *-- Caption = "" no SCX legado. O Init legado copia ThisForm.Caption
194:     *-- (vazio) para os dois labels do cabecalho - transcrito literal, sem
195:     *-- inventar titulo (PILAR 1)
196:     Caption      = ""
197: 
198:     *-- TitleBar = 0 / Closable = .F. / MaxButton = .F. / MinButton = .F. /
199:     *-- Movable = .F. / ClipControls = .F. - as SEIS sao declaradas no SCX.
200:     *-- Sem barra de titulo e sem Closable, a unica saida eh pelos botoes
201:     *-- Cancela/Confirma (fase 7)
202:     TitleBar     = 0
203:     Closable     = .F.
204:     MaxButton    = .F.
205:     MinButton    = .F.
206:     Movable      = .F.
207:     ClipControls = .F.
208: 
209:     *-- WindowType = 1 (modal), como o SCX declara. O pai abre este dialogo
210:     *-- e precisa que o Show() bloqueie ate o usuario escolher Cancelar ou
211:     *-- Confirmar
212:     WindowType   = 1
213:     WindowState  = 0

*-- Linhas 248 a 487:
248:     this_lExibirMoeda = .T.
249: 
250:     *-- this_lEmLookup -> guarda de reentrancia do lookup de moeda (fase 6,
251:     *-- regra #37 do CLAUDE.md). O picker FormBuscaAuxiliar eh MODAL e tira
252:     *-- o foco do campo, o que redispara o proprio LostFocus
253:     this_lEmLookup = .F.
254: 
255:     *==========================================================================
256:     * Init - LParameters _GetConta, _GetMoeda, _Parent do legado
257:     *==========================================================================
258:     PROCEDURE Init
259:         LPARAMETERS par_lGetConta, par_lGetMoeda, par_oFormPai
260: 
261:         *-- Legado: _GetConta = .f. (hardcode incondicional, regra #17) -
262:         *-- par_lGetConta eh aceito so por simetria com a assinatura legada
263:         *-- e NUNCA usado, exatamente como SigOpSlcBO.Init faz com
264:         *-- par_lExibirConta
265:         THIS.this_lExibirConta = .F.
266: 
267:         *-- Legado: _GetMoeda (parametro real, sem hardcode)
268:         IF VARTYPE(par_lGetMoeda) = "L"
269:             THIS.this_lExibirMoeda = par_lGetMoeda
270:         ELSE
271:             THIS.this_lExibirMoeda = .T.
272:         ENDIF
273: 
274:         *-- Legado: ThisForm.ParentForm = _Parent
275:         IF VARTYPE(par_oFormPai) = "O"
276:             THIS.this_oFormPai = par_oFormPai
277:         ENDIF
278: 
279:         RETURN DODEFAULT()
280:     ENDPROC
281: 
282:     *==========================================================================
283:     * ValidarParametros - precondicao deste dialogo: sem form pai nao ha
284:     * quem receba CanceladoExterno/MoedaMaior (fase 7), e o legado tambem
285:     * depende dessa referencia (ThisForm.ParentForm.CanceladoExterno/
286:     * MoedaMaior nos dois Click).
287:     *
288:     * Metodo PUBLIC (regra #3): o harness de teste e o form pai o alcancam
289:     * de fora, e PROTECTED faria a chamada externa estourar em runtime.
290:     *
291:     * Bypass em modo teste/validacao de UI no TOPO: o ValidarUIFidelity e o
292:     * TesteAutomatico instanciam o form SEM ARGUMENTO NENHUM, e sem o bypass
293:     * a instanciacao reprovaria sempre.
294:     *
295:     * Os RETURN ficam FORA de TRY/CATCH (regra #1) - este metodo nao abre
296:     * bloco algum.
297:     *==========================================================================
298:     PROCEDURE ValidarParametros
299:         LOCAL loc_lValido
300:         loc_lValido = .T.
301: 
302:         IF TYPE("gb_4c_ModoTeste") = "L" AND gb_4c_ModoTeste
303:             RETURN .T.
304:         ENDIF
305: 
306:         IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
307:             RETURN .T.
308:         ENDIF
309: 
310:         IF VARTYPE(THIS.this_oFormPai) != "O"
311:             MsgErro("Esta tela s" + CHR(243) + " pode ser aberta a partir de " + ;
312:                     "outro formul" + CHR(225) + "rio.", ;
313:                     "Sele" + CHR(231) + CHR(227) + "o de Moeda")
314:             loc_lValido = .F.
315:         ENDIF
316: 
317:         RETURN loc_lValido
318:     ENDPROC
319: 
320:     *==========================================================================
321:     * InicializarForm - estrutura base do dialogo
322:     *
323:     * Hook chamado pelo FormBase.Init. Retorna .T. em sucesso e .F. em falha
324:     * (nesse caso o CREATEOBJECT do chamador devolve logico, nao objeto).
325:     *==========================================================================
326:     PROTECTED PROCEDURE InicializarForm
327:         LOCAL loc_lSucesso, loc_oErro
328:         loc_lSucesso = .F.
329: 
330:         *-- Guarda de precondicao ANTES do TRY, para o RETURN nao ficar
331:         *-- dentro de TRY/CATCH (regra #1)
332:         IF !THIS.ValidarParametros()
333:             RETURN .F.
334:         ENDIF
335: 
336:         TRY
337:             *-- Business Object da Fase 1-2. Legado: Init(_GetConta eh
338:             *-- sempre .f., _GetMoeda eh o parametro real) - mesma logica
339:             THIS.this_oBusinessObject = CREATEOBJECT("SigOpSlcBO", ;
340:                 THIS.this_lExibirConta, THIS.this_lExibirMoeda)
341: 
342:             IF VARTYPE(THIS.this_oBusinessObject) != "O"
343:                 MsgErro("Falha ao criar SigOpSlcBO.", ;
344:                         "Sele" + CHR(231) + CHR(227) + "o de Moeda")
345:             ELSE
346:                 *-- Fundo do form (Picture do SCX)
347:                 THIS.ConfigurarDecoracao()
348: 
349:                 *-- Cabecalho cinza (cntSombra do legado). PRIMEIRO AddObject
350:                 *-- do form: os botoes Cancela/Confirma ficam em Top = 3,
351:                 *-- DENTRO da faixa (Top 0..80), e precisam ser criados
352:                 *-- depois para desenhar por cima (regra #11)
353:                 THIS.ConfigurarCabecalho()
354: 
355:                 *-- Botoes de acao Confirma (Ok) e Cancela (Encerrar) -
356:                 *-- criados LOGO APOS o cabecalho, pelo motivo acima
357:                 THIS.ConfigurarBotoesAcao()
358: 
359:                 *-- Bloco de moeda (visivel por padrao, controlado por
360:                 *-- this_lExibirMoeda)
361:                 THIS.ConfigurarBlocoMoeda()
362: 
363:                 *-- Bloco de Grupo/Conta - PERMANENTEMENTE OCULTO (regra #17:
364:                 *-- this_lExibirConta eh sempre .F.)
365:                 THIS.ConfigurarBlocoContaGrupo()
366: 
367:                 *-- Eventos auxiliares do bloco de Grupo/Conta (fase 8) -
368:                 *-- precisa dos controles ja criados pelo metodo acima
369:                 THIS.ConfigurarEventosContaGrupo()
370: 
371:                 *-- Liga a Grade ao cursor TmpCliente do form pai. Devolve
372:                 *-- .F. quando o cursor nao esta aberto (chamador que nao
373:                 *-- usa o bloco de Conta - que eh o caso de TODOS, regra
374:                 *-- #17); isso NAO eh falha de inicializacao, por isso o
375:                 *-- retorno nao entra em loc_lSucesso
376:                 THIS.CarregarDados()
377: 
378:                 *-- Ajuste de altura/posicao + default de moeda (TmpBaixa)
379:                 *-- do Init legado - precisa dos controles do bloco de
380:                 *-- moeda ja criados (ConfigurarBlocoMoeda, acima)
381:                 THIS.AjustarLayoutConformeMoeda()
382: 
383:                 *-- FASE 6+: lookup de moeda e os Click dos dois botoes
384:                 *-- entram nas proximas fases
385: 
386:                 *-- AddObject cria controle com Visible = .F.
387:                 THIS.TornarControlesVisiveis()
388: 
389:                 *-- Legado: This.Refresh (ultima linha do Init)
390:                 THIS.Refresh()
391: 
392:                 loc_lSucesso = .T.
393:             ENDIF
394: 
395:         CATCH TO loc_oErro
396:             THIS.this_cMensagemErro = loc_oErro.Message
397:             MsgErro("Erro ao inicializar FormSigOpSlc: " + loc_oErro.Message + ;
398:                     " | Linha: " + TRANSFORM(loc_oErro.LineNo) + ;
399:                     " | Proc: " + loc_oErro.Procedure, "Erro")
400:             loc_lSucesso = .F.
401:         ENDTRY
402: 
403:         RETURN loc_lSucesso
404:     ENDPROC
405: 
406:     *==========================================================================
407:     * ConfigurarDecoracao - Picture do form (new_background.jpg do legado)
408:     *==========================================================================
409:     PROTECTED PROCEDURE ConfigurarDecoracao
410:         LOCAL loc_cImagemFundo
411:         loc_cImagemFundo = ""
412: 
413:         IF TYPE("gc_4c_CaminhoIcones") = "C"
414:             loc_cImagemFundo = gc_4c_CaminhoIcones + "new_background.jpg"
415:         ENDIF
416: 
417:         IF !EMPTY(loc_cImagemFundo) AND FILE(loc_cImagemFundo)
418:             THIS.Picture = loc_cImagemFundo
419:         ENDIF
420:     ENDPROC
421: 
422:     *==========================================================================
423:     * ConfigurarCabecalho - faixa cinza do topo (cntSombra do legado)
424:     *
425:     * Legado:
426:     *   cntSombra  Top=0  Left=0  Width=800  Height=80  BorderWidth=0
427:     *              BackColor=100,100,100
428:     *   lblSombra  Top=18 Left=10 Width=769 Height=40 ForeColor=0,0,0
429:     *              Tahoma 18 bold, FontUnderline=.F., WordWrap=.T.,
430:     *              Alignment=0, BackStyle=0
431:     *   lblTitulo  Top=17 Left=10 Width=769 Height=46 ForeColor=255,255,255
432:     *              Tahoma 18 bold, WordWrap=.T., Alignment=0, BackStyle=0
433:     *
434:     * O Init legado sobrescreve os dois Caption com ThisForm.Caption (que eh
435:     * ""), por isso .Caption = THIS.Caption (dinamico), nao o literal
436:     * "Cadastro de Testes" que aparece no dump (esse literal eh so o default
437:     * do Form Designer, nunca chega a ser exibido).
438:     *
439:     * Width do container usa THIS.Width (canonico da faixa, regra #11) em
440:     * vez do literal 800 - sao o mesmo valor aqui, mas THIS.Width acompanha
441:     * o form se o Height/Width mudar na fase 5 (ajuste de altura).
442:     *
443:     * AutoSize = .F. explicito nos dois labels: com WordWrap = .T. o
444:     * AutoSize DESCARTA a Height e colapsa o texto para uma linha (regra
445:     * #23), e os 40/46 do dump sao o tamanho ja calculado pelo Form Designer.
446:     *==========================================================================
447:     PROTECTED PROCEDURE ConfigurarCabecalho
448:         *-- Container da faixa (cntSombra)
449:         THIS.AddObject("cnt_4c_Sombra", "Container")
450:         WITH THIS.cnt_4c_Sombra
451:             .Top           = 0
452:             .Left          = 0
453:             .Width         = THIS.Width
454:             .Height        = 80
455:             .BorderWidth   = 0
456:             .BackStyle     = 1
457:             .BackColor     = RGB(100, 100, 100)
458:             .SpecialEffect = 0
459:             .Visible       = .T.
460:         ENDWITH
461: 
462:         *-- lblSombra: copia preta deslocada 1px, para dar profundidade ao
463:         *-- titulo. Criada ANTES do lblTitulo para ficar por baixo dele
464:         THIS.cnt_4c_Sombra.AddObject("lbl_4c_LblSombra", "Label")
465:         WITH THIS.cnt_4c_Sombra.lbl_4c_LblSombra
466:             .AutoSize      = .F.
467:             .FontBold      = .T.
468:             .FontName      = "Tahoma"
469:             .FontSize      = 18
470:             .FontUnderline = .F.
471:             .WordWrap      = .T.
472:             .Alignment     = 0
473:             .BackStyle     = 0
474:             .Caption       = THIS.Caption
475:             .Top           = 18
476:             .Left          = 10
477:             .Width         = 769
478:             .Height        = 40
479:             .ForeColor     = RGB(0, 0, 0)
480:             .Rotation      = 0
481:             .Visible       = .T.
482:         ENDWITH
483: 
484:         *-- lblTitulo: titulo branco sobre a faixa cinza. Branco eh correto
485:         *-- aqui porque o container eh OPACO e escuro (excecao prevista na
486:         *-- regra #12)
487:         THIS.cnt_4c_Sombra.AddObject("lbl_4c_LblTitulo", "Label")

*-- Linhas 548 a 769:
548:     * o caso aqui.
549:     *
550:     * Os Click (Cancela -> CanceladoExterno do pai, Confirma -> MoedaMaior
551:     * do pai) sao ligados por BINDEVENT no fim desta procedure, nos metodos
552:     * CmdCancelaClick/CmdConfirmaClick (fase 7).
553:     *==========================================================================
554:     PROTECTED PROCEDURE ConfigurarBotoesAcao
555:         LOCAL loc_cIconeOk, loc_cIconeSair
556:         loc_cIconeOk   = ""
557:         loc_cIconeSair = ""
558: 
559:         IF TYPE("gc_4c_CaminhoIcones") = "C"
560:             loc_cIconeOk   = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
561:             loc_cIconeSair = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
562:         ENDIF
563: 
564:         *-- Confirma -> cmd_4c_Confirma ("\<Ok": o \< marca o atalho Alt+O,
565:         *-- transcrito literal do Caption do SCX)
566:         THIS.AddObject("cmd_4c_Confirma", "CommandButton")
567:         WITH THIS.cmd_4c_Confirma
568:             .Caption      = "\<Ok"
569:             .Top          = 3
570:             .Left         = 650
571:             .Width        = 75
572:             .Height       = 75
573:             .FontName     = "Comic Sans MS"
574:             .FontSize     = 8
575:             .FontBold     = .T.
576:             .FontItalic   = .T.
577:             .WordWrap     = .T.
578:             .AutoSize     = .F.
579:             .ForeColor    = RGB(90, 90, 90)
580:             .BackColor    = RGB(255, 255, 255)
581:             .MousePointer = 15
582:             .Themes       = .T.
583:             .Enabled      = .T.
584:             .ToolTipText  = "Confirma a moeda selecionada"
585: 
586:             IF !EMPTY(loc_cIconeOk) AND FILE(loc_cIconeOk)
587:                 .Picture         = loc_cIconeOk
588:                 .DisabledPicture = loc_cIconeOk
589:                 .PicturePosition = 13
590:             ENDIF
591: 
592:             .Visible = .T.
593:         ENDWITH
594:         BINDEVENT(THIS.cmd_4c_Confirma, "Click", THIS, "CmdConfirmaClick")
595: 
596:         *-- Cancela -> cmd_4c_Cancela (Cancel = .T.: eh o botao do ESC no
597:         *-- legado, e neste dialogo sem ControlBox eh a unica saida)
598:         THIS.AddObject("cmd_4c_Cancela", "CommandButton")
599:         WITH THIS.cmd_4c_Cancela
600:             .Caption      = "Encerrar"
601:             .Cancel       = .T.
602:             .Top          = 3
603:             .Left         = 725
604:             .Width        = 75
605:             .Height       = 75
606:             .FontName     = "Comic Sans MS"
607:             .FontSize     = 8
608:             .FontBold     = .T.
609:             .FontItalic   = .T.
610:             .WordWrap     = .T.
611:             .AutoSize     = .F.
612:             .ForeColor    = RGB(90, 90, 90)
613:             .BackColor    = RGB(255, 255, 255)
614:             .MousePointer = 15
615:             .Themes       = .T.
616:             .Enabled      = .T.
617:             .ToolTipText  = "Encerra sem selecionar moeda"
618: 
619:             IF !EMPTY(loc_cIconeSair) AND FILE(loc_cIconeSair)
620:                 .Picture         = loc_cIconeSair
621:                 .DisabledPicture = loc_cIconeSair
622:                 .PicturePosition = 13
623:             ENDIF
624: 
625:             .Visible = .T.
626:         ENDWITH
627:         BINDEVENT(THIS.cmd_4c_Cancela, "Click", THIS, "CmdCancelaClick")
628:     ENDPROC
629: 
630:     *==========================================================================
631:     * CmdConfirmaClick - Confirma.Click do legado:
632:     *
633:     *     ThisForm.ParentForm.MoedaMaior = ThisForm.get_cd_moeda.value
634:     *     ThisForm.Release
635:     *
636:     * Grava o codigo de moeda escolhido DIRETO na property do form pai (sem
637:     * metodo intermediario, igual ao legado) e fecha o dialogo. O legado nao
638:     * valida nada aqui - mesmo com o campo vazio, grava vazio e fecha (regra
639:     * #17: transcrever literal, sem inventar validacao que o legado nao tem).
640:     *
641:     * PEMSTATUS guarda a atribuicao: o contrato (property MoedaMaior) eh do
642:     * form PAI, nao deste dialogo, e sem a guarda um pai que nao declare essa
643:     * property faria THIS.this_oFormPai.MoedaMaior estourar "Property
644:     * MOEDAMAIOR is not found" em vez de simplesmente nao devolver nada.
645:     *
646:     * THIS.this_oBusinessObject.Confirmar() (fase 8, consolidacao): marca
647:     * this_lConfirmou/this_lCancelado no BO - sem efeito no que chega ao
648:     * form pai (que continua sendo gravado aqui, exatamente como o legado),
649:     * mas fecha o metodo que a fase 2 criou e a fase 7 deixou sem chamador.
650:     *
651:     * Metodo PUBLIC (regra #3): alvo de BINDEVENT tem de ser publico.
652:     *==========================================================================
653:     PROCEDURE CmdConfirmaClick
654:         LOCAL loc_oErro
655: 
656:         TRY
657:             IF VARTYPE(THIS.this_oFormPai) = "O"
658:                 IF PEMSTATUS(THIS.this_oFormPai, "MoedaMaior", 5) AND ;
659:                    PEMSTATUS(THIS, "txt_4c__cd_moeda", 5)
660:                     THIS.this_oFormPai.MoedaMaior = THIS.txt_4c__cd_moeda.Value
661:                 ENDIF
662:             ENDIF
663: 
664:             IF VARTYPE(THIS.this_oBusinessObject) = "O"
665:                 THIS.this_oBusinessObject.Confirmar()
666:             ENDIF
667: 
668:             THIS.Release()
669:         CATCH TO loc_oErro
670:             MsgErro("Erro ao confirmar a moeda selecionada: " + loc_oErro.Message, ;
671:                     "Sele" + CHR(231) + CHR(227) + "o de Moeda")
672:         ENDTRY
673:     ENDPROC
674: 
675:     *==========================================================================
676:     * CmdCancelaClick - Cancela.Click do legado:
677:     *
678:     *     ThisForm.ParentForm.CanceladoExterno = .T.
679:     *     ThisForm.Release
680:     *
681:     * Avisa o form pai que o usuario desistiu e fecha o dialogo. Mesma
682:     * guarda de PEMSTATUS da CmdConfirmaClick, pelo mesmo motivo (contrato
683:     * eh do form pai).
684:     *
685:     * THIS.this_oBusinessObject.Cancelar() (fase 8, consolidacao) - mesmo
686:     * racional da chamada a Confirmar() em CmdConfirmaClick.
687:     *
688:     * Metodo PUBLIC (regra #3): alvo de BINDEVENT tem de ser publico. Tambem
689:     * alcancavel direto (Cancel = .T. no AddObject - ESC aciona o botao).
690:     *==========================================================================
691:     PROCEDURE CmdCancelaClick
692:         LOCAL loc_oErro
693: 
694:         TRY
695:             IF VARTYPE(THIS.this_oFormPai) = "O"
696:                 IF PEMSTATUS(THIS.this_oFormPai, "CanceladoExterno", 5)
697:                     THIS.this_oFormPai.CanceladoExterno = .T.
698:                 ENDIF
699:             ENDIF
700: 
701:             IF VARTYPE(THIS.this_oBusinessObject) = "O"
702:                 THIS.this_oBusinessObject.Cancelar()
703:             ENDIF
704: 
705:             THIS.Release()
706:         CATCH TO loc_oErro
707:             MsgErro("Erro ao encerrar a sele" + CHR(231) + CHR(227) + "o de moeda: " + ;
708:                     loc_oErro.Message, "Sele" + CHR(231) + CHR(227) + "o de Moeda")
709:         ENDTRY
710:     ENDPROC
711: 
712:     *==========================================================================
713:     * ConfigurarBlocoMoeda - Label1 (texto instrucional), SayMoeda,
714:     * get_cd_moeda e get_ds_moeda do legado.
715:     *
716:     * Legado (Init):
717:     *   This.Get_cd_moeda.Visible = _GetMoeda
718:     *   This.Get_ds_moeda.Visible = _GetMoeda
719:     *   This.SayMoeda.Visible     = _GetMoeda
720:     *
721:     * Label1 NAO eh tocado pelo Init legado - fica sempre visivel,
722:     * independente de _GetMoeda (regra #17: transcrever literal).
723:     *
724:     * Reposicionamento condicional (Get_cd_moeda.Top=50, Get_ds_moeda.Top=50,
725:     * SayMoeda.Top=54, This.Height=100 quando !_GetConta And _GetMoeda) e o
726:     * default de moeda lido de TmpBaixa ficam para a FASE 5 - aqui os
727:     * controles nascem nas posicoes ORIGINAIS do dump (Top=284/287).
728:     *==========================================================================
729:     PROTECTED PROCEDURE ConfigurarBlocoMoeda
730:         *-- Label1 -> lbl_4c_Label1 (texto instrucional, sempre visivel)
731:         THIS.AddObject("lbl_4c_Label1", "Label")
732:         WITH THIS.lbl_4c_Label1
733:             .FontName  = "Tahoma"
734:             .FontSize  = 8
735:             .WordWrap  = .T.
736:             .Alignment = 2
737:             .BackStyle = 0
738:             .AutoSize  = .F.
739:             .Caption   = "Selecione a moeda para efetuar lan" + CHR(231) + ;
740:                          "amentos de cr" + CHR(233) + "dito."
741:             .Top       = 90
742:             .Left      = 295
743:             .Width     = 209
744:             .Height    = 36
745:             .ForeColor = RGB(90, 90, 90)
746:             .Visible   = .T.
747:         ENDWITH
748: 
749:         *-- SayMoeda -> lbl_4c_Moeda ("Moeda : "). Visibilidade segue
750:         *-- this_lExibirMoeda (legado: This.SayMoeda.Visible = _GetMoeda)
751:         THIS.AddObject("lbl_4c_Moeda", "Label")
752:         WITH THIS.lbl_4c_Moeda
753:             .AutoSize  = .T.
754:             .FontName  = "Tahoma"
755:             .Caption   = "Moeda : "
756:             .Top       = 287
757:             .Left      = 232
758:             .Width     = 44
759:             .ForeColor = RGB(90, 90, 90)
760:             .Visible   = THIS.this_lExibirMoeda
761:         ENDWITH
762: 
763:         *-- get_cd_moeda -> txt_4c__cd_moeda (codigo da moeda - crSigCdMoe.CMoes
764:         *-- char(3)). Format = "K!" e InputMask = "" no dump (InputMask vazio
765:         *-- eh override vazio do Form Designer, nao se transcreve - regra #49)
766:         THIS.AddObject("txt_4c__cd_moeda", "TextBox")
767:         WITH THIS.txt_4c__cd_moeda
768:             .Value     = ""
769:             .Format    = "K!"

*-- Linhas 791 a 991:
791:             .Visible   = THIS.this_lExibirMoeda
792:         ENDWITH
793: 
794:         *-- FASE 6 - lookup de moeda. "LostFocus" (nao "Valid": BINDEVENT
795:         *-- nao eh confiavel em "Valid" de TextBox; nao "KeyPress": sem
796:         *-- testar a tecla o picker abriria a cada caractere - regra #47).
797:         *-- "When" reproduz get_ds_moeda.When do legado (padrao
798:         *-- FormSigOpBcb.prg/FormSigOpCcl.prg)
799:         BINDEVENT(THIS.txt_4c__cd_moeda, "LostFocus", THIS, "CdMoedaLostFocus")
800:         BINDEVENT(THIS.txt_4c__ds_moeda, "LostFocus", THIS, "DsMoedaLostFocus")
801:         BINDEVENT(THIS.txt_4c__ds_moeda, "When", THIS, "DsMoedaWhen")
802:     ENDPROC
803: 
804:     *==========================================================================
805:     * DsMoedaWhen - get_ds_moeda.When do legado:
806:     *     Return IsEmpty(Thisform.Get_Cd_Moeda.Value)
807:     *
808:     * Enquanto o codigo da moeda estiver vazio, a descricao pode receber
809:     * foco (usuario pode digitar a descricao para buscar); com o codigo
810:     * preenchido, o foco NAO entra na descricao - o usuario so digita UM dos
811:     * dois caminhos por vez. BINDEVENT em "When" (nao em "Valid"/
812:     * "LostFocus") reproduz a propriedade When do legado - padrao
813:     * estabelecido em FormSigOpBcb.prg/FormSigOpCcl.prg.
814:     *
815:     * Metodo PUBLIC/FUNCTION (regra #3 do CLAUDE.md): BINDEVENT exige alvo
816:     * publico, e PROTECTED faria o bind falhar silenciosamente.
817:     *==========================================================================
818:     FUNCTION DsMoedaWhen()
819:         IF !PEMSTATUS(THIS, "txt_4c__cd_moeda", 5)
820:             RETURN .T.
821:         ENDIF
822: 
823:         RETURN EMPTY(ALLTRIM(THIS.txt_4c__cd_moeda.Value))
824:     ENDFUNC
825: 
826:     *==========================================================================
827:     * CdMoedaLostFocus - get_cd_moeda.Valid do legado:
828:     *
829:     *     If !IsEmpty(This.Value) And !Seek(This.Value, 'crSigCdMoe', 'CMoes')
830:     *         <fwBuscaSel>
831:     *     Else
832:     *         If IsEmpty(This.Value)
833:     *             <Cd e Ds viram ''>
834:     *         Endif
835:     *     Endif
836:     *
837:     * Guarda de reentrancia (regra #37): o picker eh MODAL e tira o foco do
838:     * campo, o que redispara este proprio LostFocus. O corpo vive em
839:     * CdMoedaLostFocusExec para a flag ser liberada mesmo com RETURN
840:     * antecipado.
841:     *==========================================================================
842:     PROCEDURE CdMoedaLostFocus()
843:         IF THIS.this_lEmLookup
844:             RETURN
845:         ENDIF
846:         THIS.this_lEmLookup = .T.
847:         THIS.CdMoedaLostFocusExec()
848:         THIS.this_lEmLookup = .F.
849:     ENDPROC
850: 
851:     PROCEDURE CdMoedaLostFocusExec()
852:         LOCAL loc_cCodigo
853: 
854:         IF !PEMSTATUS(THIS, "txt_4c__cd_moeda", 5) OR !PEMSTATUS(THIS, "txt_4c__ds_moeda", 5)
855:             RETURN
856:         ENDIF
857: 
858:         loc_cCodigo = ALLTRIM(THIS.txt_4c__cd_moeda.Value)
859: 
860:         *-- Legado: Else / If IsEmpty(This.Value) -> os dois viram ''
861:         IF EMPTY(loc_cCodigo)
862:             THIS.txt_4c__ds_moeda.Value = ""
863:             IF VARTYPE(THIS.this_oBusinessObject) = "O"
864:                 THIS.this_oBusinessObject.ValidarMoedaPorCodigo("")
865:             ENDIF
866:             RETURN
867:         ENDIF
868: 
869:         IF VARTYPE(THIS.this_oBusinessObject) != "O"
870:             RETURN
871:         ENDIF
872: 
873:         IF THIS.this_oBusinessObject.ValidarMoedaPorCodigo(loc_cCodigo)
874:             THIS.txt_4c__cd_moeda.Value = THIS.this_oBusinessObject.this_cCdMoeda
875:             THIS.txt_4c__ds_moeda.Value = THIS.this_oBusinessObject.this_cDsMoeda
876:         ELSE
877:             *-- Nao achou: abre o picker direto, SEM MsgAviso e SEM apagar o
878:             *-- digitado (regra #50) - o valor atual vira prefixo de busca
879:             THIS.AbrirBuscaMoeda(loc_cCodigo)
880:         ENDIF
881:     ENDPROC
882: 
883:     *==========================================================================
884:     * DsMoedaLostFocus - get_ds_moeda.Valid do legado (mesma logica de
885:     * CdMoedaLostFocus, Seek original por DMoes). Mesmo padrao de guarda de
886:     * reentrancia.
887:     *==========================================================================
888:     PROCEDURE DsMoedaLostFocus()
889:         IF THIS.this_lEmLookup
890:             RETURN
891:         ENDIF
892:         THIS.this_lEmLookup = .T.
893:         THIS.DsMoedaLostFocusExec()
894:         THIS.this_lEmLookup = .F.
895:     ENDPROC
896: 
897:     PROCEDURE DsMoedaLostFocusExec()
898:         LOCAL loc_cDescricao
899: 
900:         IF !PEMSTATUS(THIS, "txt_4c__cd_moeda", 5) OR !PEMSTATUS(THIS, "txt_4c__ds_moeda", 5)
901:             RETURN
902:         ENDIF
903: 
904:         loc_cDescricao = ALLTRIM(THIS.txt_4c__ds_moeda.Value)
905: 
906:         IF EMPTY(loc_cDescricao)
907:             THIS.txt_4c__cd_moeda.Value = ""
908:             IF VARTYPE(THIS.this_oBusinessObject) = "O"
909:                 THIS.this_oBusinessObject.ValidarMoedaPorDescricao("")
910:             ENDIF
911:             RETURN
912:         ENDIF
913: 
914:         IF VARTYPE(THIS.this_oBusinessObject) != "O"
915:             RETURN
916:         ENDIF
917: 
918:         IF THIS.this_oBusinessObject.ValidarMoedaPorDescricao(loc_cDescricao)
919:             THIS.txt_4c__cd_moeda.Value = THIS.this_oBusinessObject.this_cCdMoeda
920:             THIS.txt_4c__ds_moeda.Value = THIS.this_oBusinessObject.this_cDsMoeda
921:         ELSE
922:             THIS.AbrirBuscaMoeda(loc_cDescricao)
923:         ENDIF
924:     ENDPROC
925: 
926:     *==========================================================================
927:     * AbrirBuscaMoeda - picker de SigCdMoe. Pattern A do FormBuscaAuxiliar
928:     * (regras #36/#37 do CLAUDE.md), igual ao padrao ja usado para SigCdMoe
929:     * em Formccr.prg: 1o argumento eh o HANDLE de conexao, match exato
930:     * tentado no proprio Init (this_lAchouRegistro), Show() so quando nao
931:     * achou, atribuicao so sob this_lSelecionou.
932:     *
933:     * par_cValorFiltro - o que o usuario tinha digitado (codigo OU
934:     * descricao, dependendo de quem chamou); vira o 5o argumento do Init.
935:     *
936:     * Legado: fwBuscaSel aberto pelo Valid de get_cd_moeda/get_ds_moeda
937:     * quando o Seek em crSigCdMoe (cursor global legado) falha.
938:     *==========================================================================
939:     PROCEDURE AbrirBuscaMoeda(par_cValorFiltro)
940:         LOCAL loc_oBusca, loc_oErro
941: 
942:         IF !PEMSTATUS(THIS, "txt_4c__cd_moeda", 5) OR !PEMSTATUS(THIS, "txt_4c__ds_moeda", 5)
943:             RETURN
944:         ENDIF
945: 
946:         IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
947:             RETURN
948:         ENDIF
949: 
950:         TRY
951:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
952:                 "SigCdMoe", "cursor_4c_BuscaMoeda", "cmoes", ;
953:                 IIF(VARTYPE(par_cValorFiltro) = "C", par_cValorFiltro, ""), ;
954:                 "Sele" + CHR(231) + CHR(227) + "o de Moeda")
955: 
956:             IF VARTYPE(loc_oBusca) = "O"
957:                 IF !loc_oBusca.this_lAchouRegistro
958:                     loc_oBusca.mAddColuna("cmoes", "", "C" + CHR(243) + "digo")
959:                     loc_oBusca.mAddColuna("dmoes", "", "Descri" + CHR(231) + CHR(227) + "o")
960:                     loc_oBusca.Show()
961:                 ENDIF
962: 
963:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaMoeda")
964:                     SELECT cursor_4c_BuscaMoeda
965:                     THIS.txt_4c__cd_moeda.Value = ALLTRIM(TratarNulo(cmoes, ""))
966:                     THIS.txt_4c__ds_moeda.Value = ALLTRIM(TratarNulo(dmoes, ""))
967: 
968:                     IF VARTYPE(THIS.this_oBusinessObject) = "O"
969:                         THIS.this_oBusinessObject.this_cCdMoeda = THIS.txt_4c__cd_moeda.Value
970:                         THIS.this_oBusinessObject.this_cDsMoeda = THIS.txt_4c__ds_moeda.Value
971:                     ENDIF
972:                 ENDIF
973: 
974:                 loc_oBusca.Release()
975:             ENDIF
976: 
977:             IF USED("cursor_4c_BuscaMoeda")
978:                 USE IN cursor_4c_BuscaMoeda
979:             ENDIF
980:         CATCH TO loc_oErro
981:             MsgErro("Erro ao abrir a busca de moeda: " + loc_oErro.Message, ;
982:                     "Sele" + CHR(231) + CHR(227) + "o de Moeda")
983:         ENDTRY
984:     ENDPROC
985: 
986:     *==========================================================================
987:     * ConfigurarBlocoContaGrupo - Grade, SayGrupo, SayConta, Get_Grupo,
988:     * Get_Conta e Get_DCONTA do legado.
989:     *
990:     * PERMANENTEMENTE OCULTO (regra #17 do CLAUDE.md): o Init legado recebe
991:     * _GetConta como parametro e, na linha seguinte, sobrescreve

*-- Linhas 1000 a 1043:
1000:     * estiver aberto nesta sessao (DataSession = 1) - sem essa guarda, um
1001:     * cursor ausente derrubaria o Init (regra #41 do CLAUDE.md).
1002:     *==========================================================================
1003:     PROTECTED PROCEDURE ConfigurarBlocoContaGrupo
1004:         *-- SayGrupo -> lbl_4c_Grupo
1005:         THIS.AddObject("lbl_4c_Grupo", "Label")
1006:         WITH THIS.lbl_4c_Grupo
1007:             .FontName  = "Tahoma"
1008:             .Caption   = "Grupo : "
1009:             .Left      = 235
1010:             .Top       = 310
1011:             .ForeColor = RGB(90, 90, 90)
1012:             .Visible   = THIS.this_lExibirConta
1013:         ENDWITH
1014: 
1015:         *-- SayConta -> lbl_4c_Conta
1016:         THIS.AddObject("lbl_4c_Conta", "Label")
1017:         WITH THIS.lbl_4c_Conta
1018:             .FontName  = "Tahoma"
1019:             .Caption   = "Conta : "
1020:             .Left      = 235
1021:             .Top       = 332
1022:             .ForeColor = RGB(90, 90, 90)
1023:             .Visible   = THIS.this_lExibirConta
1024:         ENDWITH
1025: 
1026:         *-- Get_Grupo -> txt_4c_Grupo (legado: ControlSource = "crSigCdPgr.Grupos")
1027:         THIS.AddObject("txt_4c_Grupo", "TextBox")
1028:         WITH THIS.txt_4c_Grupo
1029:             .Value    = ""
1030:             .Format   = "K!"
1031:             .Top      = 308
1032:             .Left     = 278
1033:             .Height   = 21
1034:             .Width    = 79
1035:             .FontName = "Tahoma"
1036:             .FontSize = 8
1037:             IF USED("crSigCdPgr")
1038:                 .ControlSource = "crSigCdPgr.Grupos"
1039:             ENDIF
1040:             .Visible  = THIS.this_lExibirConta
1041:         ENDWITH
1042: 
1043:         *-- Get_Conta -> txt_4c_Conta (legado: ControlSource = "crSigCdPgr.Contas")

*-- Linhas 1071 a 1094:
1071:             .FontSize    = 8
1072:             .ToolTipText = "Passe o Cheque na Leitora"
1073:             .Visible     = THIS.this_lExibirConta
1074:         ENDWITH
1075: 
1076:         *-- Grade -> grd_4c_Dados (legado: RecordSource = "TmpCliente",
1077:         *-- cursor do FORM PAI)
1078:         THIS.AddObject("grd_4c_Dados", "Grid")
1079:         WITH THIS.grd_4c_Dados
1080:             .ColumnCount       = 3
1081:             .FontName          = "Tahoma"
1082:             .FontSize          = 8
1083:             .AllowHeaderSizing = .F.
1084:             .AllowRowSizing    = .F.
1085:             .DeleteMark        = .F.
1086:             .RecordMark        = .F.
1087:             .Top               = 123
1088:             .Left              = 230
1089:             .Width             = 339
1090:             .Height            = 155
1091:             .RowHeight         = 17
1092:             .ScrollBars        = 2
1093:             .ReadOnly          = .T.
1094:             .Visible           = THIS.this_lExibirConta

*-- Linhas 1121 a 1164:
1121:     * Metodo PUBLIC: o form pai pode reaplicar o formato depois de repopular
1122:     * o proprio TmpCliente.
1123:     *==========================================================================
1124:     PROCEDURE AplicarFormatoGrade
1125:         LOCAL loc_lAplicou
1126:         loc_lAplicou = .F.
1127: 
1128:         IF PEMSTATUS(THIS, "grd_4c_Dados", 5)
1129:             WITH THIS.grd_4c_Dados
1130:                 .Column1.Width             = 65
1131:                 .Column1.Movable           = .F.
1132:                 .Column1.Resizable         = .F.
1133:                 .Column1.FontSize          = 8
1134:                 .Column1.Header1.Caption   = "Grupo"
1135:                 .Column1.Header1.FontName  = "Tahoma"
1136:                 .Column1.Header1.FontSize  = 8
1137:                 .Column1.Header1.Alignment = 2
1138:                 .Column1.Header1.ForeColor = RGB(90, 90, 90)
1139: 
1140:                 .Column2.Width             = 65
1141:                 .Column2.Movable           = .F.
1142:                 .Column2.Resizable         = .F.
1143:                 .Column2.FontSize          = 8
1144:                 .Column2.Header1.Caption   = "Conta"
1145:                 .Column2.Header1.FontName  = "Tahoma"
1146:                 .Column2.Header1.FontSize  = 8
1147:                 .Column2.Header1.Alignment = 2
1148:                 .Column2.Header1.ForeColor = RGB(90, 90, 90)
1149: 
1150:                 .Column3.Width             = 175
1151:                 .Column3.Movable           = .F.
1152:                 .Column3.Resizable         = .F.
1153:                 .Column3.FontSize          = 8
1154:                 .Column3.Header1.Caption   = "Nome"
1155:                 .Column3.Header1.FontName  = "Tahoma"
1156:                 .Column3.Header1.FontSize  = 8
1157:                 .Column3.Header1.Alignment = 2
1158:                 .Column3.Header1.ForeColor = RGB(90, 90, 90)
1159:             ENDWITH
1160: 
1161:             loc_lAplicou = .T.
1162:         ENDIF
1163: 
1164:         RETURN loc_lAplicou

*-- Linhas 1187 a 1622:
1187:     * o chama de fora, SEM argumento, e PROTECTED faria a chamada estourar
1188:     * em runtime com "Property CARREGARDADOS is not found".
1189:     *==========================================================================
1190:     PROCEDURE CarregarDados
1191:         LOCAL loc_lCarregou, loc_oErro
1192:         loc_lCarregou = .F.
1193: 
1194:         IF !PEMSTATUS(THIS, "grd_4c_Dados", 5)
1195:             RETURN .F.
1196:         ENDIF
1197: 
1198:         IF !USED("TmpCliente")
1199:             RETURN .F.
1200:         ENDIF
1201: 
1202:         TRY
1203:             WITH THIS.grd_4c_Dados
1204:                 *-- ColumnCount antes do RecordSource. Reatribuir o MESMO
1205:                 *-- valor nao recria as Column (nao ha controle posto por
1206:                 *-- Column.AddObject nesta grade a perder)
1207:                 .ColumnCount = 3
1208: 
1209:                 .RecordSource = "TmpCliente"
1210: 
1211:                 *-- Colunas do dump: Column1=Grupo, Column2=Conta,
1212:                 *-- Column3=Nome (os campos que o AfterRowColChange legado
1213:                 *-- le para alimentar Get_Grupo/Get_Conta/Get_DConta)
1214:                 .Column1.ControlSource = "TmpCliente.Grupo"
1215:                 .Column2.ControlSource = "TmpCliente.Conta"
1216:                 .Column3.ControlSource = "TmpCliente.Nome"
1217:             ENDWITH
1218: 
1219:             *-- Rede de seguranca do Problema 48: RecordSource/ControlSource
1220:             *-- podem zerar Width e Header1.Caption. Mesma fonte usada na
1221:             *-- montagem, entao nao ha numero duplicado aqui
1222:             THIS.AplicarFormatoGrade()
1223: 
1224:             *-- Legado: a Grade so mostra dado depois do posicionamento +
1225:             *-- repintura (o Init legado termina com This.Refresh)
1226:             GO TOP IN TmpCliente
1227:             THIS.grd_4c_Dados.Refresh()
1228: 
1229:             loc_lCarregou = .T.
1230: 
1231:         CATCH TO loc_oErro
1232:             THIS.this_cMensagemErro = loc_oErro.Message
1233:             MsgErro("Erro ao carregar a grade de contas: " + loc_oErro.Message + ;
1234:                     " | Linha: " + TRANSFORM(loc_oErro.LineNo) + ;
1235:                     " | Proc: " + loc_oErro.Procedure, ;
1236:                     "Sele" + CHR(231) + CHR(227) + "o de Moeda")
1237:             loc_lCarregou = .F.
1238:         ENDTRY
1239: 
1240:         RETURN loc_lCarregou
1241:     ENDPROC
1242: 
1243:     *==========================================================================
1244:     * ConfigurarEventosContaGrupo - liga os eventos do bloco de Grupo/Conta
1245:     * (fase 8). Chamado logo depois de ConfigurarBlocoContaGrupo, que cria
1246:     * txt_4c_Grupo/txt_4c_Conta/txt_4c_DCONTA/grd_4c_Dados.
1247:     *
1248:     * BINDEVENT em "LostFocus" (nao "Valid" - nao confiavel em TextBox,
1249:     * regra #47) para os tres campos; "When" so no DCONTA (unico que o
1250:     * legado declara); "AfterRowColChange" na Grade SEM filtro de coluna
1251:     * (sincroniza os tres campos com a linha corrente - uso legitimo da
1252:     * regra #46); "KeyPress" nos Text1 das tres colunas (navegacao Tab/
1253:     * Enter -> foco em Grupo, igual ao legado).
1254:     *==========================================================================
1255:     PROTECTED PROCEDURE ConfigurarEventosContaGrupo
1256:         IF PEMSTATUS(THIS, "txt_4c_Grupo", 5)
1257:             BINDEVENT(THIS.txt_4c_Grupo, "LostFocus", THIS, "ValidarGrupoLostFocus")
1258:         ENDIF
1259: 
1260:         IF PEMSTATUS(THIS, "txt_4c_Conta", 5)
1261:             BINDEVENT(THIS.txt_4c_Conta, "LostFocus", THIS, "ValidarContaLostFocus")
1262:         ENDIF
1263: 
1264:         IF PEMSTATUS(THIS, "txt_4c_DCONTA", 5)
1265:             BINDEVENT(THIS.txt_4c_DCONTA, "LostFocus", THIS, "ValidarDContaLostFocus")
1266:             BINDEVENT(THIS.txt_4c_DCONTA, "When", THIS, "DContaWhen")
1267:         ENDIF
1268: 
1269:         IF PEMSTATUS(THIS, "grd_4c_Dados", 5)
1270:             BINDEVENT(THIS.grd_4c_Dados, "AfterRowColChange", THIS, "GradeAfterRowColChange")
1271: 
1272:             IF PEMSTATUS(THIS.grd_4c_Dados, "Column1", 5) AND PEMSTATUS(THIS.grd_4c_Dados.Column1, "Text1", 5)
1273:                 BINDEVENT(THIS.grd_4c_Dados.Column1.Text1, "KeyPress", THIS, "GradeColunaKeyPress")
1274:             ENDIF
1275:             IF PEMSTATUS(THIS.grd_4c_Dados, "Column2", 5) AND PEMSTATUS(THIS.grd_4c_Dados.Column2, "Text1", 5)
1276:                 BINDEVENT(THIS.grd_4c_Dados.Column2.Text1, "KeyPress", THIS, "GradeColunaKeyPress")
1277:             ENDIF
1278:             IF PEMSTATUS(THIS.grd_4c_Dados, "Column3", 5) AND PEMSTATUS(THIS.grd_4c_Dados.Column3, "Text1", 5)
1279:                 BINDEVENT(THIS.grd_4c_Dados.Column3.Text1, "KeyPress", THIS, "GradeColunaKeyPress")
1280:             ENDIF
1281:         ENDIF
1282:     ENDPROC
1283: 
1284:     *==========================================================================
1285:     * ValidarGrupoLostFocus - Get_Grupo.Valid do legado:
1286:     *
1287:     *     If !fAcessoContab( Usuar, 'C', This.Value, This,'',
1288:     *                        Thisform.get_conta.value )
1289:     *         Messagebox( 'Acesso Negado...', 48, '' )
1290:     *         This.Value = ''
1291:     *     Endif
1292:     *
1293:     * fAcessoContab (utils\functions.prg) ja escreve This.Value/.Refresh
1294:     * sozinho quando recebe um objeto em pCod - por isso o 4o argumento eh o
1295:     * proprio TextBox, igual ao legado passa "This".
1296:     *
1297:     * Metodo PUBLIC (regra #3): alvo de BINDEVENT tem de ser publico.
1298:     *==========================================================================
1299:     PROCEDURE ValidarGrupoLostFocus
1300:         LOCAL loc_oErro
1301: 
1302:         IF !PEMSTATUS(THIS, "txt_4c_Grupo", 5) OR !PEMSTATUS(THIS, "txt_4c_Conta", 5)
1303:             RETURN
1304:         ENDIF
1305: 
1306:         TRY
1307:             IF !fAcessoContab(gc_4c_UsuarioLogado, "C", THIS.txt_4c_Grupo.Value, ;
1308:                     THIS.txt_4c_Grupo, "", THIS.txt_4c_Conta.Value)
1309:                 MsgAviso("Acesso Negado...", "")
1310:                 THIS.txt_4c_Grupo.Value = ""
1311:             ENDIF
1312:         CATCH TO loc_oErro
1313:             MsgErro("Erro ao validar o grupo: " + loc_oErro.Message, ;
1314:                     "Sele" + CHR(231) + CHR(227) + "o de Moeda")
1315:         ENDTRY
1316:     ENDPROC
1317: 
1318:     *==========================================================================
1319:     * ValidarContaLostFocus - Get_Conta.Valid do legado:
1320:     *
1321:     *     If !fAcessoContas( Usuar, This.Get_Grupo.Value, 'C', This.Value,
1322:     *                        This.Get_Conta, This.Get_dConta )
1323:     *         Messagebox( 'Acesso Negado...', 48, '' )
1324:     *         This.Get_Conta.Value = ''
1325:     *         This.Get_dConta.Value = ''
1326:     *     Endif
1327:     *
1328:     * "This" no dump refere-se ao FORM (unico jeito de "This.Get_Grupo"
1329:     * fazer sentido, ja que o TextBox Get_Conta nao tem esse membro) - este
1330:     * handler mora no form, entao THIS ja eh a referencia correta.
1331:     *==========================================================================
1332:     PROCEDURE ValidarContaLostFocus
1333:         LOCAL loc_oErro
1334: 
1335:         IF !PEMSTATUS(THIS, "txt_4c_Grupo", 5) OR !PEMSTATUS(THIS, "txt_4c_Conta", 5) ;
1336:                 OR !PEMSTATUS(THIS, "txt_4c_DCONTA", 5)
1337:             RETURN
1338:         ENDIF
1339: 
1340:         TRY
1341:             IF !fAcessoContas(gc_4c_UsuarioLogado, THIS.txt_4c_Grupo.Value, "C", ;
1342:                     THIS.txt_4c_Conta.Value, THIS.txt_4c_Conta, THIS.txt_4c_DCONTA)
1343:                 MsgAviso("Acesso Negado...", "")
1344:                 THIS.txt_4c_Conta.Value  = ""
1345:                 THIS.txt_4c_DCONTA.Value = ""
1346:             ENDIF
1347:         CATCH TO loc_oErro
1348:             MsgErro("Erro ao validar a conta: " + loc_oErro.Message, ;
1349:                     "Sele" + CHR(231) + CHR(227) + "o de Moeda")
1350:         ENDTRY
1351:     ENDPROC
1352: 
1353:     *==========================================================================
1354:     * ValidarDContaLostFocus - Get_DCONTA.Valid do legado (mesma logica de
1355:     * ValidarContaLostFocus, 'D' no lugar de 'C' - tipo busca por
1356:     * descricao/leitora de cheque):
1357:     *
1358:     *     If !fAcessoContas( Usuar, This.Get_Grupo.Value, 'D', This.Value,
1359:     *                        This.Get_Conta, This.Get_dConta )
1360:     *         Messagebox( 'Acesso Negado...', 48, '' )
1361:     *         This.Get_Conta.Value = ''
1362:     *         This.Get_dConta.Value = ''
1363:     *     Endif
1364:     *==========================================================================
1365:     PROCEDURE ValidarDContaLostFocus
1366:         LOCAL loc_oErro
1367: 
1368:         IF !PEMSTATUS(THIS, "txt_4c_Grupo", 5) OR !PEMSTATUS(THIS, "txt_4c_Conta", 5) ;
1369:                 OR !PEMSTATUS(THIS, "txt_4c_DCONTA", 5)
1370:             RETURN
1371:         ENDIF
1372: 
1373:         TRY
1374:             IF !fAcessoContas(gc_4c_UsuarioLogado, THIS.txt_4c_Grupo.Value, "D", ;
1375:                     THIS.txt_4c_DCONTA.Value, THIS.txt_4c_Conta, THIS.txt_4c_DCONTA)
1376:                 MsgAviso("Acesso Negado...", "")
1377:                 THIS.txt_4c_Conta.Value  = ""
1378:                 THIS.txt_4c_DCONTA.Value = ""
1379:             ENDIF
1380:         CATCH TO loc_oErro
1381:             MsgErro("Erro ao validar a conta: " + loc_oErro.Message, ;
1382:                     "Sele" + CHR(231) + CHR(227) + "o de Moeda")
1383:         ENDTRY
1384:     ENDPROC
1385: 
1386:     *==========================================================================
1387:     * DContaWhen - Get_DCONTA.When do legado:
1388:     *     Return IsEmpty(Thisform.Get_Conta.Value)
1389:     *
1390:     * O foco so entra em DCONTA enquanto Conta estiver vazia (fluxo de
1391:     * leitora de cheque - ToolTipText "Passe o Cheque na Leitora").
1392:     *
1393:     * Metodo PUBLIC/FUNCTION (regra #3): BINDEVENT exige alvo publico.
1394:     *==========================================================================
1395:     FUNCTION DContaWhen()
1396:         IF !PEMSTATUS(THIS, "txt_4c_Conta", 5)
1397:             RETURN .T.
1398:         ENDIF
1399: 
1400:         RETURN EMPTY(ALLTRIM(THIS.txt_4c_Conta.Value))
1401:     ENDFUNC
1402: 
1403:     *==========================================================================
1404:     * GradeAfterRowColChange - Grade (Procedure) do legado:
1405:     *
1406:     *     LPARAMETERS nColIndex
1407:     *     ThisForm.Get_Grupo.Value = Grupo
1408:     *     ThisForm.Get_Conta.Value = Conta
1409:     *     ThisForm.Get_DConta.Value = Nome
1410:     *
1411:     * Sincroniza os tres campos com a linha corrente de TmpCliente (mesmos
1412:     * campos ligados em CarregarDados: Column1/2/3 -> Grupo/Conta/Nome).
1413:     * SEM filtro de coluna - uso legitimo de AfterRowColChange (regra #46):
1414:     * nao valida celula, so espelha o registro atual.
1415:     *==========================================================================
1416:     PROCEDURE GradeAfterRowColChange(par_nColIndex)
1417:         IF !PEMSTATUS(THIS, "txt_4c_Grupo", 5) OR !PEMSTATUS(THIS, "txt_4c_Conta", 5) ;
1418:                 OR !PEMSTATUS(THIS, "txt_4c_DCONTA", 5)
1419:             RETURN
1420:         ENDIF
1421: 
1422:         IF !USED("TmpCliente") OR EOF("TmpCliente")
1423:             RETURN
1424:         ENDIF
1425: 
1426:         THIS.txt_4c_Grupo.Value  = TratarNulo(TmpCliente.Grupo, "")
1427:         THIS.txt_4c_Conta.Value  = TratarNulo(TmpCliente.Conta, "")
1428:         THIS.txt_4c_DCONTA.Value = TratarNulo(TmpCliente.Nome, "")
1429:     ENDPROC
1430: 
1431:     *==========================================================================
1432:     * GradeColunaKeyPress - Grade.ColumnN.Text1.KeyPress do legado (as tres
1433:     * colunas tem o mesmo corpo):
1434:     *
1435:     *     LPARAMETERS nKeyCode, nShiftAltCtrl
1436:     *     If nKeyCode = 9 or nKeyCode = 13
1437:     *         ThisForm.Get_Grupo.SetFocus
1438:     *     Endif
1439:     *==========================================================================
1440:     PROCEDURE GradeColunaKeyPress(par_nKeyCode, par_nShiftAltCtrl)
1441:         IF par_nKeyCode = 9 OR par_nKeyCode = 13
1442:             IF PEMSTATUS(THIS, "txt_4c_Grupo", 5)
1443:                 THIS.txt_4c_Grupo.SetFocus()
1444:             ENDIF
1445:         ENDIF
1446:     ENDPROC
1447: 
1448:     *==========================================================================
1449:     * AjustarLayoutConformeMoeda - ajuste de altura/posicao do Init legado:
1450:     *
1451:     *   If !_GetMoeda
1452:     *       This.Height = This.Height - 25
1453:     *   Else
1454:     *       <busca o default de moeda em TmpBaixa - CarregarMoedaDefaultDeTmpBaixa>
1455:     *   Endif
1456:     *   If !_GetConta And _GetMoeda
1457:     *       This.Get_cd_moeda.Top = 50
1458:     *       This.Get_ds_moeda.top = 50
1459:     *       This.SayMoeda.top = 54
1460:     *       This.Height = 100
1461:     *   Endif
1462:     *
1463:     * Como this_lExibirConta eh SEMPRE .F. (regra #17), "!_GetConta And
1464:     * _GetMoeda" equivale sempre a "_GetMoeda" - os dois Ifs do legado
1465:     * cobrem so os DOIS estados de this_lExibirMoeda:
1466:     *
1467:     *   this_lExibirMoeda = .F. -> Height -= 25 (375), sem reposicionar
1468:     *   this_lExibirMoeda = .T. -> busca o default em TmpBaixa E reposiciona
1469:     *       get_cd_moeda/get_ds_moeda/SayMoeda, com Height = 100
1470:     *
1471:     * Chamado do InicializarForm, DEPOIS de ConfigurarBlocoMoeda (os
1472:     * controles reposicionados precisam existir) e ANTES de
1473:     * TornarControlesVisiveis.
1474:     *==========================================================================
1475:     PROTECTED PROCEDURE AjustarLayoutConformeMoeda
1476:         IF !THIS.this_lExibirMoeda
1477:             THIS.Height = THIS.Height - 25
1478:         ELSE
1479:             THIS.CarregarMoedaDefaultDeTmpBaixa()
1480: 
1481:             IF PEMSTATUS(THIS, "txt_4c__cd_moeda", 5)
1482:                 THIS.txt_4c__cd_moeda.Top = 50
1483:             ENDIF
1484:             IF PEMSTATUS(THIS, "txt_4c__ds_moeda", 5)
1485:                 THIS.txt_4c__ds_moeda.Top = 50
1486:             ENDIF
1487:             IF PEMSTATUS(THIS, "lbl_4c_Moeda", 5)
1488:                 THIS.lbl_4c_Moeda.Top = 54
1489:             ENDIF
1490: 
1491:             THIS.Height = 100
1492:         ENDIF
1493:     ENDPROC
1494: 
1495:     *==========================================================================
1496:     * CarregarMoedaDefaultDeTmpBaixa - legado:
1497:     *
1498:     *   Select TmpBaixa
1499:     *   Scan for Tipos = 'X'
1500:     *       This.Get_cd_moeda.value = moedas
1501:     *       =Seek( moedas, 'crSigCdMoe', 'CMoes' )
1502:     *       This.Get_ds_moeda.value = crSigCdMoe.dmoes
1503:     *       exit
1504:     *   Endscan
1505:     *
1506:     * TmpBaixa eh cursor do FORM PAI (mesma situacao de TmpCliente e
1507:     * crSigCdPgr na fase 4) - sem ele aberto nesta DataSession = 1, nao ha
1508:     * default a buscar, e isso NAO eh erro (devolve .F. calado).
1509:     *
1510:     * O Seek legado em crSigCdMoe (cursor global, SEM checar o resultado)
1511:     * equivale aqui a ValidarMoedaPorCodigo(), que faz o SQLEXEC em
1512:     * SigCdMoe e preserva o codigo encontrado em TmpBaixa mesmo que a
1513:     * busca na tabela de moedas nao encontre nada (regra #37/#50 - nunca
1514:     * apagar um codigo ja resolvido).
1515:     *
1516:     * Restaura o alias corrente ao final: SELECT TmpBaixa muda a work area
1517:     * ativa, e este metodo roda antes de qualquer outra carga do form.
1518:     *==========================================================================
1519:     PROTECTED PROCEDURE CarregarMoedaDefaultDeTmpBaixa
1520:         LOCAL loc_cAliasAnterior, loc_cMoedaDefault, loc_oErro
1521:         loc_cMoedaDefault = ""
1522: 
1523:         IF !USED("TmpBaixa")
1524:             RETURN .F.
1525:         ENDIF
1526: 
1527:         loc_cAliasAnterior = ALIAS()
1528: 
1529:         TRY
1530:             SELECT TmpBaixa
1531:             SCAN FOR Tipos = "X"
1532:                 loc_cMoedaDefault = TratarNulo(moedas, "")
1533:                 EXIT
1534:             ENDSCAN
1535:         CATCH TO loc_oErro
1536:             THIS.this_cMensagemErro = "Erro ao ler a moeda padr" + CHR(227) + ;
1537:                 "o em TmpBaixa: " + loc_oErro.Message
1538:         ENDTRY
1539: 
1540:         IF !EMPTY(loc_cAliasAnterior) AND USED(loc_cAliasAnterior)
1541:             SELECT (loc_cAliasAnterior)
1542:         ENDIF
1543: 
1544:         IF EMPTY(loc_cMoedaDefault)
1545:             RETURN .F.
1546:         ENDIF
1547: 
1548:         IF VARTYPE(THIS.this_oBusinessObject) = "O"
1549:             THIS.this_oBusinessObject.ValidarMoedaPorCodigo(loc_cMoedaDefault)
1550: 
1551:             IF PEMSTATUS(THIS, "txt_4c__cd_moeda", 5)
1552:                 THIS.txt_4c__cd_moeda.Value = THIS.this_oBusinessObject.this_cCdMoeda
1553:             ENDIF
1554:             IF PEMSTATUS(THIS, "txt_4c__ds_moeda", 5)
1555:                 THIS.txt_4c__ds_moeda.Value = THIS.this_oBusinessObject.this_cDsMoeda
1556:             ENDIF
1557:         ENDIF
1558: 
1559:         RETURN .T.
1560:     ENDPROC
1561: 
1562:     *==========================================================================
1563:     * TornarControlesVisiveis - AddObject cria todo controle com
1564:     * Visible = .F.; este metodo percorre o form e os containers tornando
1565:     * visivel o que foi criado.
1566:     *
1567:     * Metodo PUBLIC (regra #3): o harness de teste o chama de fora.
1568:     *
1569:     * Esta fase ja tem o bloco de Grupo/Conta (this_lExibirConta sempre .F.)
1570:     * e o bloco de moeda (this_lExibirMoeda): o loop generico forca .T. em
1571:     * TUDO, entao os dois blocos tem de ser re-ocultados/reavaliados DEPOIS
1572:     * do loop - exatamente como o Init legado faz com
1573:     * This.Grade.Visible = _GetConta etc.
1574:     *==========================================================================
1575:     PROCEDURE TornarControlesVisiveis
1576:         LOCAL loc_nI, loc_nJ, loc_oControle, loc_oFilho
1577: 
1578:         FOR loc_nI = 1 TO THIS.ControlCount
1579:             loc_oControle = THIS.Controls(loc_nI)
1580: 
1581:             IF VARTYPE(loc_oControle) != "O"
1582:                 LOOP
1583:             ENDIF
1584: 
1585:             IF PEMSTATUS(loc_oControle, "Visible", 5)
1586:                 loc_oControle.Visible = .T.
1587:             ENDIF
1588: 
1589:             IF PEMSTATUS(loc_oControle, "ControlCount", 5)
1590:                 IF loc_oControle.ControlCount > 0
1591:                     FOR loc_nJ = 1 TO loc_oControle.ControlCount
1592:                         loc_oFilho = loc_oControle.Controls(loc_nJ)
1593: 
1594:                         IF VARTYPE(loc_oFilho) = "O"
1595:                             IF PEMSTATUS(loc_oFilho, "Visible", 5)
1596:                                 loc_oFilho.Visible = .T.
1597:                             ENDIF
1598:                         ENDIF
1599:                     ENDFOR
1600:                 ENDIF
1601:             ENDIF
1602:         ENDFOR
1603: 
1604:         *-- Bloco de Grupo/Conta - SEMPRE oculto (regra #17: this_lExibirConta
1605:         *-- eh forcado a .F. no Init, para qualquer chamador)
1606:         IF PEMSTATUS(THIS, "grd_4c_Dados", 5)
1607:             THIS.grd_4c_Dados.Visible = THIS.this_lExibirConta
1608:         ENDIF
1609:         IF PEMSTATUS(THIS, "lbl_4c_Grupo", 5)
1610:             THIS.lbl_4c_Grupo.Visible = THIS.this_lExibirConta
1611:         ENDIF
1612:         IF PEMSTATUS(THIS, "lbl_4c_Conta", 5)
1613:             THIS.lbl_4c_Conta.Visible = THIS.this_lExibirConta
1614:         ENDIF
1615:         IF PEMSTATUS(THIS, "txt_4c_Grupo", 5)
1616:             THIS.txt_4c_Grupo.Visible = THIS.this_lExibirConta
1617:         ENDIF
1618:         IF PEMSTATUS(THIS, "txt_4c_Conta", 5)
1619:             THIS.txt_4c_Conta.Visible = THIS.this_lExibirConta
1620:         ENDIF
1621:         IF PEMSTATUS(THIS, "txt_4c_DCONTA", 5)
1622:             THIS.txt_4c_DCONTA.Visible = THIS.this_lExibirConta

*-- Linhas 1645 a 1654:
1645:     * MoedaMaior) depois que este dialogo fecha. Aqui a referencia eh apenas
1646:     * anulada, para nao segurar o pai alem do tempo.
1647:     *==========================================================================
1648:     PROCEDURE Destroy
1649:         THIS.this_oFormPai = .NULL.
1650: 
1651:         DODEFAULT()
1652:     ENDPROC
1653: 
1654: ENDDEFINE


### BO (C:\4c\projeto\app\classes\SigOpSlcBO.prg):
*==============================================================================
* SigOpSlcBO.prg
*
* Business Object para FormSigOpSlc - Dialogo de Selecao de Moeda (e Conta,
* bloco permanentemente oculto - ver NOTA abaixo)
* Legado: SigOpSlc.SCX (task803)
*
* Tabela: SigCdMoe (somente CONSULTA/VALIDACAO, nunca gravacao)
*
*------------------------------------------------------------------------------
* FUNCAO DA TELA
*
* Dialogo FILHO, modal e sem barra de titulo (no SCX: WindowType = 1,
* TitleBar = 0, ControlBox ausente/Closable = .F., 800 x 400, BorderStyle = 2),
* aberto por um form pai que guarda a referencia em ThisForm.ParentForm
* (RESERVED3/ClassInfo do SCX = "parentform"). O legado abre assim:
*
*     Do Form SigOpSlc With _GetConta, _GetMoeda, ThisForm
*
* Os dois primeiros parametros ligam/desligam blocos de controles (Visible),
* e o terceiro eh o form que vai receber o resultado.
*
*------------------------------------------------------------------------------
* O CONTRATO - O QUE VOLTA PARA O FORM PAI
*
* Os dois botoes escrevem DIRETO em ThisForm.ParentForm, sem metodo
* intermediario:
*
*     Cancela.Click  -> ThisForm.ParentForm.CanceladoExterno = .T. / Release
*     Confirma.Click -> ThisForm.ParentForm.MoedaMaior = ThisForm.get_cd_moeda.Value / Release
*
* Ou seja: o UNICO dado que realmente sai desta tela eh o codigo da moeda
* escolhida (ou a confirmacao de que o usuario cancelou). O bloco de
* Grupo/Conta NUNCA alimenta o pai - ver a nota abaixo sobre por que ele
* existe no SCX mas esta morto.
*
*------------------------------------------------------------------------------
* NOTA - O BLOCO DE CONTA/GRUPO ESTA PERMANENTEMENTE OCULTO (regra #17)
*
* O Init legado recebe _GetConta como parametro e, na linha seguinte,
* SOBRESCREVE o valor recebido:
*
*     LParameters _GetConta, _GetMoeda, _Parent
*     _GetConta = .f.                    && <- ignora o que o chamador mandou
*     This.Grade.Visible     = _GetConta
*     This.Get_Grupo.Visible = _GetConta
*     This.Get_Conta.Visible = _GetConta
*     This.Get_dConta.Visible = _GetConta
*     This.SayGrupo.Visible  = _GetConta
*     This.SayConta.Visible  = _GetConta
*
* Isso significa que a Grade (RecordSource = "TmpCliente"), os campos
* Get_Grupo/Get_Conta/Get_DConta (ControlSource = crSigCdPgr.Grupos/Contas) e
* os respectivos Say ficam SEMPRE invisiveis, para QUALQUER chamador - eh
* codigo morto no legado, e se transcreve LITERAL (regra #17: nao se
* "corrige" removendo o hardcode nem se reativa o bloco). As properties deste
* BO que espelham esse bloco (this_cGrupo/this_cConta/this_cDConta) existem
* so para completude estrutural (paridade com os controles do SCX) - nenhum
* fluxo as alimenta de fato.
*
* Os validadores desses campos (Get_Grupo.Valid/Get_Conta.Valid/
* Get_DConta.Valid) chamam fAcessoContab()/fAcessoContas(), que JA EXISTEM
* como helpers globais em utils\functions.prg (linhas 709 e 991) - nao
* precisam de wrapper neste BO, e ficam no Form (camada de UI), que eh quem
* os aciona via BINDEVENT.
*
*------------------------------------------------------------------------------
* A MOEDA - O UNICO DADO QUE DE FATO CIRCULA
*
* get_cd_moeda.Valid e get_ds_moeda.Valid fazem Seek em 'crSigCdMoe' (cursor
* global legado) por CMoes/DMoes e, nao achando, abrem fwBuscaSel. No sistema
* novo o equivalente eh validar/buscar direto em SigCdMoe via SQLEXEC e
* FormBuscaAuxiliar (padrao do projeto - docs/lookup_implementation.md),
* dai this_cTabela = "SigCdMoe" / this_cCampoChave = "CMoes" neste BO.
*
* Quando _GetMoeda = .T., o Init legado tambem busca um valor DEFAULT de
* moeda varrendo um cursor do CHAMADOR (TmpBaixa, Scan For Tipos = 'X',
* pega o campo moedas da primeira linha). TmpBaixa, assim como TmpCliente e
* crSigCdPgr acima, NAO pertence a este dialogo - sao cursores que o form
* pai ja deixa abertos antes do Do Form (mesmo padrao documentado em
* SigOpCtdBO.prg: tabela do chamador nao se declara aqui). A leitura desse
* default fica para a fase do Form (que tem acesso ao cursor do pai), nao
* para este BO.
*
*------------------------------------------------------------------------------
* AJUSTE DE ALTURA (Init legado) - FICA NA FASE DO FORM, NAO AQUI
*
*     If !_GetMoeda
*         This.Height = This.Height - 25
*     Else
*         <busca o default em TmpBaixa>
*     Endif
*     If !_GetConta And _GetMoeda      && _GetConta e sempre .F., entao
*         <reposiciona get_cd_moeda/get_ds_moeda/SayMoeda e This.Height=100>
*     Endif
*
* Esse ajuste eh layout puro (Height/Top de controles) - nao ha property de
* BO que o represente. this_lExibirMoeda eh o que decide qual dos dois
* ramos a fase do Form vai aplicar.
*
*------------------------------------------------------------------------------
* NOTA DE ARQUITETURA - SOMENTE LEITURA/VALIDACAO
*
* Este BO nao sobrescreve Inserir()/Atualizar()/ExecutarExclusao(): o dump do
* legado nao tem INSERT/UPDATE/DELETE/TABLEUPDATE - a tela so VALIDA um
* codigo de moeda e devolve a escolha ao chamador. O comportamento padrao
* herdado de BusinessBase (recusar a gravacao) ja eh o correto.
*==============================================================================

DEFINE CLASS SigOpSlcBO AS BusinessBase

    *--------------------------------------------------------------------------
    * BLOCO MOEDA - o unico dado que de fato sai desta tela
    *--------------------------------------------------------------------------
    this_lExibirMoeda = .T.    && legado: parametro _GetMoeda (Visible de get_cd_moeda/get_ds_moeda/SayMoeda)
    this_cCdMoeda      = ""    && legado: Get_cd_moeda.Value -> crSigCdMoe.CMoes -> ParentForm.MoedaMaior
    this_cDsMoeda      = ""    && legado: Get_ds_moeda.Value -> crSigCdMoe.DMoes (so exibicao)

    *--------------------------------------------------------------------------
    * BLOCO GRUPO/CONTA - SEMPRE OCULTO no legado (_GetConta = .f. hardcoded
    * no Init, independente do que o chamador passar - ver nota no cabecalho).
    * Mantido so por completude estrutural com os controles do SCX.
    *--------------------------------------------------------------------------
    this_lExibirConta = .F.    && legado: _GetConta, FORCADO .F. no Init (regra #17)
    this_cGrupo       = ""     && legado: Get_Grupo.Value  -> crSigCdPgr.Grupos (bloco oculto)
    this_cConta       = ""     && legado: Get_Conta.Value  -> crSigCdPgr.Contas (bloco oculto)
    this_cDConta      = ""     && legado: Get_DConta.Value -> descricao da conta (bloco oculto)

    *--------------------------------------------------------------------------
    * RESULTADO DA INTERACAO - o que os dois botoes decidem
    *--------------------------------------------------------------------------
    this_lCancelado = .F.      && legado: ParentForm.CanceladoExterno (Cancela.Click)
    this_lConfirmou = .F.      && .T. so quando o botao Confirma foi acionado

    *==========================================================================
    * Init - Inicializa o Business Object
    *
    * Parametros, ambos opcionais:
    *     par_lExibirConta - aceito por simetria com a assinatura do form
    *                        legado (_GetConta), mas SEMPRE sobrescrito para
    *                        .F. - o legado forca isso incondicionalmente logo
    *                        apos o LParameters, e isso se transcreve literal
    *                        (regra #17), nao se "corrige".
    *     par_lExibirMoeda - legado: _GetMoeda. Omitido, assume .T. (bloco de
    *                        moeda visivel, que eh o uso real desta tela).
    *==========================================================================
    PROCEDURE Init(par_lExibirConta, par_lExibirMoeda)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            DODEFAULT()
            THIS.this_cTabela     = "SigCdMoe"
            THIS.this_cCampoChave = "CMoes"

            *-- Legado: _GetConta = .f. (hardcode incondicional, regra #17)
            THIS.this_lExibirConta = .F.

            *-- Legado: _GetMoeda (parametro real, sem hardcode)
            IF VARTYPE(par_lExibirMoeda) = "L"
                THIS.this_lExibirMoeda = par_lExibirMoeda
            ELSE
                THIS.this_lExibirMoeda = .T.
            ENDIF

            THIS.this_cCdMoeda  = ""
            THIS.this_cDsMoeda  = ""
            THIS.this_cGrupo    = ""
            THIS.this_cConta    = ""
            THIS.this_cDConta   = ""
            THIS.this_lCancelado = .F.
            THIS.this_lConfirmou = .F.

            loc_lSucesso = .T.
        CATCH TO loException
            MostrarErro(loException, "SigOpSlcBO.Init")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * CarregarDoCursor - Carrega this_cCdMoeda/this_cDsMoeda a partir de UM
    * registro de cursor com as colunas cmoes/dmoes (SigCdMoe).
    *
    * Usado por ValidarMoedaPorCodigo/ValidarMoedaPorDescricao logo depois do
    * SQLEXEC, e tambem pelo Form apos o usuario escolher um registro no
    * FormBuscaAuxiliar (regra #37 do CLAUDE.md).
    *
    * PUBLIC (sem PROTECTED) porque BusinessBase.CarregarDoCursor() ja eh
    * PUBLIC - PROTECTED aqui so na subclasse nao bloqueia a chamada externa
    * (regra #51), mas manter o MESMO modificador da base evita confusao.
    *
    * SELECT (par_cAliasCursor) ANTES de acessar os campos - a sintaxe
    * campo nao existe em VFP9 (regra #9 da migration_guide).
    *==========================================================================
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso, loc_cAlias, loc_oErro
        loc_lSucesso = .F.

        loc_cAlias = IIF(VARTYPE(par_cAliasCursor) = "C", ALLTRIM(par_cAliasCursor), "")

        TRY
            IF !EMPTY(loc_cAlias) AND USED(loc_cAlias)
                SELECT (loc_cAlias)

                IF !EOF(loc_cAlias)
                    *-- cmoes char(3) - legado: crSigCdMoe.CMoes
                    IF TYPE(loc_cAlias + ".cmoes") == "C"
                        THIS.this_cCdMoeda = TratarNulo(cmoes, "")
                    ENDIF

                    *-- dmoes char(15) - legado: crSigCdMoe.DMoes
                    IF TYPE(loc_cAlias + ".dmoes") == "C"
                        THIS.this_cDsMoeda = TratarNulo(dmoes, "")
                    ENDIF

                    loc_lSucesso = .T.
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = "Erro ao ler os dados da moeda:" + CHR(13) + loc_oErro.Message
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * ValidarMoedaPorCodigo - get_cd_moeda.Valid do legado:
    *
    *     If !IsEmpty(This.Value) And !Seek(This.Value, 'crSigCdMoe', 'CMoes')
    *         <abre fwBuscaSel, atualiza Cd/Ds com a escolha ou com '' se ESC>
    *     Else
    *         If IsEmpty(This.Value)
    *             <Cd e Ds viram ''>
    *         Endif
    *     Endif
    *
    * Equivalente no sistema novo: SQLEXEC em SigCdMoe por cmoes. Achando,
    * carrega this_cCdMoeda/this_cDsMoeda via CarregarDoCursor e devolve .T.
    * Vazio, limpa os dois e devolve .T. (o legado nao trata isso como erro).
    * Nao achando, PRESERVA o codigo digitado em this_cCdMoeda - NUNCA se
    * apaga o que o usuario digitou (regra #37/#50) - e devolve .F. para o
    * Form abrir o FormBuscaAuxiliar (equivalente ao fwBuscaSel do legado).
    *==========================================================================
    PROCEDURE ValidarMoedaPorCodigo(par_cCodigo)
        LOCAL loc_lSucesso, loc_cCodigo, loc_cSQL, loc_nResultado, loc_oErro
        loc_lSucesso = .F.
        THIS.this_cMensagemErro = ""

        loc_cCodigo = IIF(VARTYPE(par_cCodigo) = "C", ALLTRIM(par_cCodigo), "")

        *-- Legado: Else / If IsEmpty(This.Value) -> ambos limpos, sem erro
        IF EMPTY(loc_cCodigo)
            THIS.this_cCdMoeda = ""
            THIS.this_cDsMoeda = ""
            RETURN .T.
        ENDIF

        TRY
            IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
                THIS.this_cCdMoeda = loc_cCodigo
                THIS.this_cMensagemErro = "Conex" + CHR(227) + "o com o banco de dados " + ;
                    "n" + CHR(227) + "o dispon" + CHR(237) + "vel."
            ELSE
                IF USED("cursor_4c_Moeda")
                    IF CURSORGETPROP("Buffering", "cursor_4c_Moeda") > 1
                        TABLEREVERT(.T., "cursor_4c_Moeda")
                    ENDIF
                    USE IN cursor_4c_Moeda
                ENDIF

                loc_cSQL = "SELECT cmoes, dmoes" + ;
                           "  FROM SigCdMoe" + ;
                           " WHERE cmoes = " + EscaparSQL(loc_cCodigo)

                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Moeda")

                IF loc_nResultado > 0 AND USED("cursor_4c_Moeda") AND RECCOUNT("cursor_4c_Moeda") > 0
                    SELECT cursor_4c_Moeda
                    GO TOP
                    loc_lSucesso = THIS.CarregarDoCursor("cursor_4c_Moeda")
                ELSE
                    *-- Nao achou: preserva o digitado, NAO limpa (regra #50)
                    THIS.this_cCdMoeda = loc_cCodigo
                    IF loc_nResultado < 0
                        THIS.this_cMensagemErro = "Erro ao consultar a moeda:" + CHR(13) + CapturarErroSQL()
                    ENDIF
                    loc_lSucesso = .F.
                ENDIF

                IF USED("cursor_4c_Moeda")
                    USE IN cursor_4c_Moeda
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = "Erro ao validar a moeda:" + CHR(13) + loc_oErro.Message
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * ValidarMoedaPorDescricao - get_ds_moeda.Valid do legado: mesma logica de
    * ValidarMoedaPorCodigo, mas o Seek original casa por DMoes em vez de
    * CMoes:
    *
    *     If !IsEmpty(This.Value) And !Seek(This.Value, 'crSigCdMoe', 'DMoes')
    *         <abre fwBuscaSel>
    *     Else
    *         If IsEmpty(This.Value)
    *             <Cd e Ds viram ''>
    *         Endif
    *     Endif
    *==========================================================================
    PROCEDURE ValidarMoedaPorDescricao(par_cDescricao)
        LOCAL loc_lSucesso, loc_cDescricao, loc_cSQL, loc_nResultado, loc_oErro
        loc_lSucesso = .F.
        THIS.this_cMensagemErro = ""

        loc_cDescricao = IIF(VARTYPE(par_cDescricao) = "C", ALLTRIM(par_cDescricao), "")

        IF EMPTY(loc_cDescricao)
            THIS.this_cCdMoeda = ""
            THIS.this_cDsMoeda = ""
            RETURN .T.
        ENDIF

        TRY
            IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
                THIS.this_cDsMoeda = loc_cDescricao
                THIS.this_cMensagemErro = "Conex" + CHR(227) + "o com o banco de dados " + ;
                    "n" + CHR(227) + "o dispon" + CHR(237) + "vel."
            ELSE
                IF USED("cursor_4c_Moeda")
                    IF CURSORGETPROP("Buffering", "cursor_4c_Moeda") > 1
                        TABLEREVERT(.T., "cursor_4c_Moeda")
                    ENDIF
                    USE IN cursor_4c_Moeda
                ENDIF

                loc_cSQL = "SELECT cmoes, dmoes" + ;
                           "  FROM SigCdMoe" + ;
                           " WHERE dmoes = " + EscaparSQL(loc_cDescricao)

                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Moeda")

                IF loc_nResultado > 0 AND USED("cursor_4c_Moeda") AND RECCOUNT("cursor_4c_Moeda") > 0
                    SELECT cursor_4c_Moeda
                    GO TOP
                    loc_lSucesso = THIS.CarregarDoCursor("cursor_4c_Moeda")
                ELSE
                    *-- Nao achou: preserva o digitado, NAO limpa (regra #50)
                    THIS.this_cDsMoeda = loc_cDescricao
                    IF loc_nResultado < 0
                        THIS.this_cMensagemErro = "Erro ao consultar a moeda:" + CHR(13) + CapturarErroSQL()
                    ENDIF
                    loc_lSucesso = .F.
                ENDIF

                IF USED("cursor_4c_Moeda")
                    USE IN cursor_4c_Moeda
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = "Erro ao validar a moeda:" + CHR(13) + loc_oErro.Message
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * CarregarPorCodigo - contrato padrao do projeto (carga pela chave
    * primaria). Para este BO a chave EH a propria moeda, entao eh sinonimo
    * de ValidarMoedaPorCodigo (mesmo padrao de SigOpCotBO.CarregarPorCodigo).
    *==========================================================================
    PROCEDURE CarregarPorCodigo(par_cCodigo)
        RETURN THIS.ValidarMoedaPorCodigo(par_cCodigo)
    ENDPROC

    *==========================================================================
    * Confirmar - legado: Confirma.Click
    *     ThisForm.ParentForm.MoedaMaior = ThisForm.get_cd_moeda.value
    *     ThisForm.Release
    *
    * O legado NAO valida o valor antes de atribuir - mesmo com
    * get_cd_moeda vazio, o Confirma grava e fecha (regra #17: transcrever
    * literal, sem inventar validacao nova). Copiar this_cCdMoeda para a
    * property do form pai e fechar a tela (Release) ficam no Form, que eh
    * quem tem a referencia ao pai e ao proprio ciclo de vida da janela.
    *==========================================================================
    PROCEDURE Confirmar()
        THIS.this_lConfirmou = .T.
        THIS.this_lCancelado = .F.
        RETURN .T.
    ENDPROC

    *==========================================================================
    * Cancelar - legado: Cancela.Click
    *     ThisForm.ParentForm.CanceladoExterno = .T.
    *     ThisForm.Release
    *==========================================================================
    PROCEDURE Cancelar()
        THIS.this_lCancelado = .T.
        THIS.this_lConfirmou = .F.
        RETURN .T.
    ENDPROC

    *==========================================================================
    * ObterChavePrimaria - chave de SigCdMoe (cmoes). PROTECTED porque a
    * BusinessBase declara assim (o modificador da base PREVALECE - regra
    * #51); nunca chamado de fora, e aqui so existe por completude, ja que
    * este BO nunca chega a RegistrarAuditoria (Inserir/Atualizar nao sao
    * sobrescritos - ver NOTA DE ARQUITETURA no cabecalho do arquivo).
    *==========================================================================
    PROTECTED PROCEDURE ObterChavePrimaria()
        RETURN ALLTRIM(THIS.this_cCdMoeda)
    ENDPROC

    *==========================================================================
    * LimparDados - devolve o BO ao estado inicial (mesmo valor do Init,
    * exceto this_lExibirMoeda/this_lExibirConta, que sao parametros de
    * abertura da tela e nao mudam durante o uso do dialogo).
    *==========================================================================
    PROCEDURE LimparDados()
        DODEFAULT()

        THIS.this_cCdMoeda   = ""
        THIS.this_cDsMoeda   = ""
        THIS.this_cGrupo     = ""
        THIS.this_cConta     = ""
        THIS.this_cDConta    = ""
        THIS.this_lCancelado = .F.
        THIS.this_lConfirmou = .F.

        RETURN .T.
    ENDPROC

ENDDEFINE


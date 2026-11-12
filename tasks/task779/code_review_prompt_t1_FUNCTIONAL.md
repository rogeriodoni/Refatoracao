# CODE REVIEW - PASS FUNCTIONAL: Functional Logic (metodos, eventos, containers)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Functional Logic (metodos, eventos, containers)**.

## PROBLEMAS DETECTADOS (4)
- [CONTAINER-VISIVEL] TornarControlesVisiveis() NAO filtra containers ocultos: CNT_4C_SOMBRA. Estes containers tem Visible=.F. mas serao forcados a Visible=.T. pelo metodo recursivo.
- [BUSCA-CURSOR] CREATEOBJECT('FormBuscaAuxiliar') sem parametros mas NAO define this_cCursorDestino. No Modo 2 (sem params), DEVE definir this_cCursorDestino com o cursor local pre-existente ANTES de chamar Show().
- [LOSTFOCUS-SEM-GUARDIA] Handler 'ValidarPedido' (via BINDEVENT LostFocus) abre janela de busca mas NAO verifica se o valor mudou. No legado, Valid so dispara quando o valor MUDA, mas LostFocus dispara SEMPRE. CORRIGIR: Adicionar propriedade this_cUltimoValidarPedidoValidado e comparar no inicio do handler: IF loc_cValor == THIS.this_cUltimo... THEN RETURN. Atualizar apos validacao bem-sucedida.
- [LOSTFOCUS-SEM-GUARDIA] Handler 'ValidarTamanho' (via BINDEVENT LostFocus) abre janela de busca mas NAO verifica se o valor mudou. No legado, Valid so dispara quando o valor MUDA, mas LostFocus dispara SEMPRE. CORRIGIR: Adicionar propriedade this_cUltimoValidarTamanhoValidado e comparar no inicio do handler: IF loc_cValor == THIS.this_cUltimo... THEN RETURN. Atualizar apos validacao bem-sucedida.

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

### FORM (C:\4c\projeto\app\forms\operacionais\Formsigopped.prg) - TRECHOS RELEVANTES PARA PASS FUNCTIONAL (1456 linhas total):

*-- Linhas 23 a 148:
23: * CsTmpPed do pai ficariam invisiveis para este dialogo (sessao privada
24: * isolada) e nenhum metodo de BtnSalvarClick/Init funcionaria. Transcrito
25: * fielmente: SET DATASESSION TO (par_nDataSessionPai) dentro do Init, ANTES
26: * de DODEFAULT() (que dispara InicializarForm).
27: *
28: * this_oFormPai equivale a property customizada "parentform" do legado
29: * (RESERVED3 ClassInfo: antvalue/parentform/podatamgr/*calctotais).
30: * this_cAntValu equivale a "AntValu" (usada em GetPedido.Valid, fase
31: * posterior, para detectar troca de abreviacao digitada). poDataMgr nao tem
32: * equivalente nesta arquitetura (gnConnHandle compartilhado via config.prg).
33: *
34: * Caption/acentos sempre por CHR() - nunca literal acentuado em .PRG.
35: *
36: * Herda de: FormBase          BO associado: sigoppedBO
37: * Criado em: Fase 3 - Estrutura base (classe, Init, cabecalho)
38: *
39: * Fase 3/8: estrutura base e o cabecalho (cntSombra + lblSombra + lblTitulo).
40: * Fase 4/8: CommandGroup de acao "OK" (obj_4c_OK: btnSair/"Retornar" +
41: * btnGravar/"Gravar") - unico bloco de "botoes" real desta tela (nao ha
42: * cnt_4c_Botoes/cnt_4c_BotoesAcao genericos: o legado nao os tem, e
43: * inventa-los violaria o PILAR 1). BtnSalvarClick ja referencia os 8 campos
44: * txt_4c_* que entram na Fase 5 (forward reference resolvida quando aquela
45: * fase adicionar os controles via AddObject).
46: * Fase 5/8: Shape1 (moldura decorativa) + a PRIMEIRA linha de campos
47: * (Produto/Descricao/Cor/Tam./Qtde - getDPros/Say10/get_prod/Say1/getCor/
48: * Say2/getTam/Say4/GetQtde), transcritos do dump com compensacao NENHUMA de
49: * PageFrame (nao existe PageFrame aqui - os Tops do dump sao absolutos).
50: * TabIndex do dump confirma o agrupamento por linha (Say10=1 .. GetQtde=9
51: * na 1a linha; Say3=10 .. getTamanho=17 na 2a).
52: * Fase 6/8: a SEGUNDA linha de campos (Pedido/Repetir/Peso/Tam. -
53: * Say3/GetPedido/Say5/getRepetir/Say6/Get_Peso/Say7/getTamanho) + lookups
54: * completos: ValidarPedido/AbrirBuscaPedido (fwbuscasel sobre o cursor
55: * LOCAL CsTmpPed - FormBuscaAuxiliar.DefinirCursor()/.Mostrar(), regra
56: * CLAUDE.md #36/#37, pois NAO ha SQL Server envolvido),
57: * ValidarTamanho/AbrirLookupTamanho (fwbuscaext/SigCdTam via gnConnHandle,
58: * padrao canonico do projeto) e ValidarRepetir (limite contra
59: * GetQtde.Value, sem lookup). Todos ligados via BINDEVENT "LostFocus"
60: * (regra CLAUDE.md #47 - Valid do legado equivale a validar na SAIDA do
61: * campo, nunca KeyPress sem testar a tecla).
62: * Fase 7/8: a orquestracao completa do Init legado, que nao faz sentido
63: * fatiar em "visibilidade" (fase 7) e "SQL" (fase 8) porque no legado sao o
64: * MESMO bloco - a visibilidade de Say7/getTamanho depende diretamente do
65: * resultado da consulta de crTmpGru. Implementado em dois metodos chamados
66: * no fim de InicializarForm, apos TornarControlesVisiveis (que forca
67: * Visible=.T. em todo AddObject e precisa ser desfeito explicitamente para
68: * os dois controles condicionais):
69: *   - CarregarPedidosDisponiveis(): "lcSql = [Select a.cDopes, ...]" + 2
70: *     INDEX ON do Init - popula CsTmpPed (consumido por ValidarPedido/
71: *     AbrirBuscaPedido, ja implementados na Fase 6). Fonte de cDopes eh o
72: *     cursor TprMvCab do form PAI (visivel aqui via SET DATASESSION TO
73: *     par_nDataSessionPai, no Init).
74: *   - CarregarDadosProduto(): leitura de crTpmMvItn (Qtde via Count For Not
75: *     Empty + Get_Peso.Value = Pesos), as duas consultas de verificacao de
76: *     conexao (crTmpUni/crTmpGru) e a visibilidade condicional de Say7/
77: *     getTamanho (regra: Empty(lcTam) AND crTmpGru.TipoEstos em 3,4).
78: * Em ambos os metodos, falha de SQLEXEC (com conexao disponivel) aborta a
79: * abertura do form - "Return 0" do Init legado equivale a
80: * loc_lSucesso = .F. em InicializarForm (CREATEOBJECT devolve .F.). Sem
81: * conexao/parent form (harness de teste, ValidarUIFidelity) os dois metodos
82: * sao no-op bem-sucedido - mesmo padrao de FormSigOpPec.InicializarForm
83: * (loc_lModoValidacaoOuTeste).
84: *
85: * O "Load" do legado (=fConfigGeral()) NAO eh portado, de proposito: eh o
86: * mesmo caso ja decidido e documentado em FormSigOpOpe.prg/
87: * projeto\app\utils\fconfiggeral.prg - fConfigGeral era funcao GLOBAL da
88: * aplicacao legado que nao veio no acervo, e o que ela fazia (configuracao
89: * global) ja acontece antes: config.prg (SETs/paths/aliases), main.prg
90: * (conexao) e os proprios metodos de carga deste form. Chama-la aqui
91: * mascararia a ausencia em vez de mostra-la - regra #2 do CLAUDE.md: em
92: * codigo NOSSO nunca se chama fConfigGeral.
93: *
94: * "Release" do legado (so chamava ThisForm.poDataMgr.Release + DoDefault) -
95: * ja implementado em Destroy() desde a Fase 4 (poDataMgr nao existe nesta
96: * arquitetura).
97: *
98: * Fase 8/8: consolidacao final. Este form OPERACIONAL nao segue o roteiro
99: * generico de form CRUD (sem Page1=Lista/Page2=Dados, sem BtnBuscar/
100: * BtnEncerrar/BtnCancelar/CarregarLista/HabilitarCampos/LimparCampos/
101: * AjustarBotoesPorModo - o legado nao tem nenhum desses: sao DOIS botoes
102: * no SCX (btnGravar e btnSair), nao ha grade nem modo de edicao
103: * cancelavel, o unico "Buscar" eh o lookup de pedido/tamanho ja entregue
104: * na Fase 6 e o unico "Encerrar" eh BtnSairClick, na Fase 4) - inventa-los
105: * violaria o PILAR 1 e cria-los vazios violaria a regra de completude.
106: * O que esta fase fez:
107: *   - FormParaBO(): THIS.this_oBusinessObject era criado em
108: *     InicializarForm (Fase 3) e nunca usado - o handler do Gravar (Fase 7)
109: *     duplicava inline a mesma logica que
110: *     sigoppedBO.GravarAbreviacaoNosItens ja implementava desde a Fase 2.
111: *     FormParaBO() + THIS.this_oBusinessObject.Atualizar() substituem a
112: *     duplicacao (PILAR 3 - Form nao manipula o cursor de persistencia
113: *     direto).
114: *   - BOParaForm(): contrapartida da transferencia, consumida por
115: *     CarregarDadosProduto - a carga da tela passou a ser cursor -> BO
116: *     (CarregarDoCursor) -> tela, em vez de o Form ler coluna de cursor
117: *     para pintar campo.
118: *   - BtnSalvarClick: o handler do botao "Gravar" usa o NOME canonico do
119: *     projeto (BtnSalvarClick), nao o nome do objeto legado (btnGravar) -
120: *     o Caption continua "Gravar", transcrito do dump (PILAR 1), e o
121: *     handler do botao de abandono segue BtnSairClick, do Caption
122: *     "Retornar". Dentro dele: (a) as 5 leituras vestigiais do legado
123: *     passaram a ser GUARDADAS por USED()/PEMSTATUS - sem guarda, um alias
124: *     ausente estourava e caia no CATCH ANTES da gravacao, isto eh, codigo
125: *     morto matava o unico trabalho real do botao; (b) a falha de gravacao
126: *     deixou de ser muda (regra CLAUDE.md #20 - Atualizar() eh chamado
127: *     direto, fora do Salvar() que chama ExibirFalha()) e o dialogo so
128: *     fecha quando GRAVOU.
129: *   - ReadOnly = .T. nos 5 campos que o legado declara com
130: *     "When / Return .F." (get_prod/getDPros/getCor/getTam/GetQtde) -
131: *     estavam digitaveis no migrado, e produto/cor/tamanho sao justamente
132: *     as 3 chaves que FormParaBO entrega ao BO para localizar o item a
133: *     gravar.
134: *==============================================================================
135: 
136: DEFINE CLASS Formsigopped AS FormBase
137: 
138:     *==========================================================================
139:     * Propriedades visuais - transcritas do dump do SCX legado (secao
140:     * "PROPRIEDADES DE: SIGOPPED"). WindowType = 1: Show() desta classe
141:     * SEMPRE roda modal, mesmo sem parametro. ControlBox/TitleBar: sem X e
142:     * sem barra de titulo - nenhum botao de sistema desenha. AlwaysOnTop +
143:     * AutoCenter: dialogo flutuante centralizado sobre a tela do form pai.
144:     *==========================================================================
145:     Height      = 211
146:     Width       = 773
147:     DataSession = 2
148:     ShowWindow = 1

*-- Linhas 187 a 338:
187:     *==========================================================================
188:     * Init - replica "LParameters pform, datses" do legado. par_oFormPai e
189:     * par_nDataSessionPai sao OPCIONAIS: o harness de teste e a validacao de
190:     * UI instanciam o form sem parametro nenhum (CREATEOBJECT("Formsigopped")).
191:     * SET DATASESSION TO roda ANTES de DODEFAULT() (que dispara
192:     * InicializarForm via FormBase.Init), replicando a ordem exata do Init
193:     * legado ("Set Datasession To DatSes" eh a 1a linha executavel, antes de
194:     * qualquer SQL). NUNCA chamar InicializarForm aqui tambem - DODEFAULT()
195:     * chamar duas vezes estoura "member object already exists" nos AddObject).
196:     *==========================================================================
197:     PROCEDURE Init(par_oFormPai, par_nDataSessionPai)
198:         IF VARTYPE(par_oFormPai) = "O"
199:             THIS.this_oFormPai = par_oFormPai
200:         ENDIF
201: 
202:         IF VARTYPE(par_nDataSessionPai) = "N" AND par_nDataSessionPai > 0
203:             SET DATASESSION TO (par_nDataSessionPai)
204:         ENDIF
205: 
206:         RETURN DODEFAULT()
207:     ENDPROC
208: 
209:     *==========================================================================
210:     * InicializarForm - monta a estrutura base: fundo do form, Business
211:     * Object e o cabecalho (unico bloco visual entregue nesta fase). Os
212:     * demais blocos (CommandGroup OK, Shape1, campos) entram em
213:     * ConfigurarPageFrame nas fases seguintes, na mesma ordem do dump do SCX.
214:     *==========================================================================
215:     PROTECTED PROCEDURE InicializarForm()
216:         LOCAL loc_lSucesso, loc_oErro
217:         loc_lSucesso = .F.
218: 
219:         TRY
220:             *-- Fundo do form (legado: Picture = ..\framework\imagens\new_background.jpg)
221:             THIS.Picture = gc_4c_CaminhoIcones + "new_background.jpg"
222: 
223:             *-- Garantir crTpmMvItn para o .ControlSource dos campos de
224:             *-- Produto/Descricao/Cor/Tam. (ConfigurarCamposProduto). Em
225:             *-- producao o cursor ja existe (mantido pelo form PAI, visivel
226:             *-- aqui via SET DATASESSION TO par_nDataSessionPai no Init);
227:             *-- sem form pai (harness de teste/ValidarUIFidelity instancia
228:             *-- sem parametro nenhum, na DataSession PRIVADA desta classe)
229:             *-- o placeholder evita "Alias 'CRTPMMVITN' is not found" ao
230:             *-- vincular o ControlSource. Padrao idem FormEnd.ConfigurarCampos.
231:             IF !USED("crTpmMvItn")
232:                 CREATE CURSOR crTpmMvItn (cItens N(9,0), cPros C(14), DPros C(65), ;
233:                     CodCors C(14), CodTams C(14), Abrevis C(14), cItem2 N(9,0), ;
234:                     Opers C(14), Pesos N(9,3))
235:             ENDIF
236: 
237:             THIS.this_oBusinessObject = CREATEOBJECT("sigoppedBO")
238: 
239:             IF VARTYPE(THIS.this_oBusinessObject) != "O"
240:                 MsgErro("Erro ao criar objeto de neg" + CHR(243) + "cio sigoppedBO.", ;
241:                     "Erro em InicializarForm")
242:             ELSE
243:                 THIS.ConfigurarPageFrame()
244: 
245:                 THIS.TornarControlesVisiveis(THIS)
246: 
247:                 *-- Orquestracao do Init legado (ver comentario de cabecalho -
248:                 *-- "Fase 7/8"). Falha de SQLEXEC com conexao disponivel
249:                 *-- aborta a abertura do form, equivalente ao "Return 0" do
250:                 *-- Init legado.
251:                 IF THIS.CarregarPedidosDisponiveis() AND THIS.CarregarDadosProduto()
252:                     loc_lSucesso = .T.
253:                 ELSE
254:                     loc_lSucesso = .F.
255:                 ENDIF
256:             ENDIF
257:         CATCH TO loc_oErro
258:             MsgErro(loc_oErro.Message + CHR(13) + ;
259:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
260:                 "Procedure: " + loc_oErro.Procedure, ;
261:                 "Erro em InicializarForm")
262:         ENDTRY
263: 
264:         RETURN loc_lSucesso
265:     ENDPROC
266: 
267:     *==========================================================================
268:     * ConfigurarPageFrame - orquestra a montagem visual. Nao existe PageFrame
269:     * real neste form (objeto raiz do legado eh "Class: form" generico, sem
270:     * frmcadastro/Page1=Lista/Page2=Dados) - o nome eh mantido so por
271:     * convencao com o restante do pipeline (mesmo padrao de FormSigOpPec.prg/
272:     * FormSigOpGar.prg, outros forms OPERACIONAIS sem PageFrame). Ordem de
273:     * criacao conforme o dump (ver SECAO 1 do codigo fonte): cntSombra ->
274:     * Shape1 -> OK -> campos (fases seguintes).
275:     *==========================================================================
276:     PROTECTED PROCEDURE ConfigurarPageFrame()
277:         THIS.ConfigurarCabecalho()
278:         THIS.ConfigurarBotaoAcao()
279:         THIS.ConfigurarCamposProduto()
280:         THIS.ConfigurarCamposPedido()
281:     ENDPROC
282: 
283:     *==========================================================================
284:     * ConfigurarCabecalho - faixa cinza superior com o titulo da tela
285:     * (cntSombra do legado) e os dois labels sobrepostos que produzem o
286:     * efeito de sombra: lblSombra em preto (Top = 18) sob lblTitulo em branco
287:     * (Top = 17). Width/Height/Font/ForeColor transcritos do dump (secao
288:     * "PROPRIEDADES DE: SIGOPPED.cntSombra" e dos dois labels filhos).
289:     *
290:     * Os dois labels declaram WordWrap = .T. no dump: AutoSize = .F. + Width/
291:     * Height explicitos (regra CLAUDE.md #23 - AutoSize eh no-op em Label
292:     * criado por AddObject e, com WordWrap, descarta a Height).
293:     *
294:     * Caption = THIS.Caption transcreve o "ThisForm.cntSombra.lblSombra.
295:     * Caption = ThisForm.Caption" / "...lblTitulo.Caption = ThisForm.Caption"
296:     * do Init legado.
297:     *==========================================================================
298:     PROTECTED PROCEDURE ConfigurarCabecalho()
299:         LOCAL loc_oCab
300: 
301:         THIS.AddObject("cnt_4c_Sombra", "Container")
302:         loc_oCab = THIS.cnt_4c_Sombra
303:         WITH loc_oCab
304:             .Top         = 0
305:             .Left        = 0
306:             .Width       = THIS.Width
307:             .Height      = 80
308:             .BackStyle   = 1
309:             .BackColor   = RGB(100, 100, 100)
310:             .BorderWidth = 0
311:             .Visible     = .T.
312:         ENDWITH
313: 
314:         loc_oCab.AddObject("lbl_4c_LblSombra", "Label")
315:         WITH loc_oCab.lbl_4c_LblSombra
316:             .AutoSize      = .F.
317:             .Top           = 18
318:             .Left          = 10
319:             .Width         = 769
320:             .Height        = 40
321:             .FontName      = "Tahoma"
322:             .FontSize      = 18
323:             .FontBold      = .T.
324:             .FontUnderline = .F.
325:             .WordWrap      = .T.
326:             .Alignment     = 0
327:             .BackStyle     = 0
328:             .ForeColor     = RGB(0, 0, 0)
329:             .Caption       = THIS.Caption
330:             .Visible       = .T.
331:         ENDWITH
332: 
333:         loc_oCab.AddObject("lbl_4c_LblTitulo", "Label")
334:         WITH loc_oCab.lbl_4c_LblTitulo
335:             .AutoSize    = .F.
336:             .Top         = 17
337:             .Left        = 10
338:             .Width       = 769

*-- Linhas 354 a 401:
354:     * ConfigurarBotaoAcao - cria obj_4c_OK (CommandGroup "OK" do legado),
355:     * unico bloco de botoes desta tela: Buttons(1) = btnSair ("Retornar",
356:     * Cancel=.T.) e Buttons(2) = btnGravar ("Gravar"). Posicao/propriedades
357:     * EXATAS do dump (secao "PROPRIEDADES DE: SIGOPPED.OK"). BINDEVENT em
358:     * ButtonsClick delegando para metodo PUBLIC (regra CLAUDE.md #3 -
359:     * BINDEVENT exige metodo PUBLIC, PROTECTED falha em silencio).
360:     *==========================================================================
361:     PROTECTED PROCEDURE ConfigurarBotaoAcao()
362:         LOCAL loc_oErro
363: 
364:         TRY
365:             THIS.AddObject("obj_4c_OK", "CommandGroup")
366:             WITH THIS.obj_4c_OK
367:                 .Top          = -2
368:                 .Left         = 616
369:                 .Width        = 160
370:                 .Height       = 85
371:                 .ButtonCount  = 2
372:                 .BackStyle    = 0
373:                 .BorderStyle  = 0
374:                 .SpecialEffect = 1
375:                 .BorderColor  = RGB(136, 189, 188)
376:                 .Themes       = .F.
377:                 .Value        = 0
378:                 .Visible      = .T.
379: 
380:                 WITH .Buttons(1)
381:                     .Top         = 5
382:                     .Left        = 80
383:                     .Width       = 75
384:                     .Height      = 75
385:                     .FontBold    = .T.
386:                     .FontItalic  = .T.
387:                     .FontName    = "Comic Sans MS"
388:                     .FontSize    = 8
389:                     .WordWrap    = .T.
390:                     .Picture     = gc_4c_CaminhoIcones + "relatorio_sair_60.jpg"
391:                     .Caption     = "Retornar"
392:                     .MousePointer = 15
393:                     .ToolTipText = "[Esc] Voltar Para a Tela Principal da " + ;
394:                         "Opera" + CHR(231) + CHR(227) + "o"
395:                     .SpecialEffect = 0
396:                     .ForeColor   = RGB(90, 90, 90)
397:                     .BackColor   = RGB(255, 255, 255)
398:                     .Themes      = .F.
399:                     .Cancel      = .T.
400:                 ENDWITH
401: 

*-- Linhas 417 a 552:
417:                 ENDWITH
418:             ENDWITH
419: 
420:             BINDEVENT(THIS.obj_4c_OK.Buttons(1), "Click", THIS, "BtnSairClick")
421:             BINDEVENT(THIS.obj_4c_OK.Buttons(2), "Click", THIS, "BtnSalvarClick")
422:         CATCH TO loc_oErro
423:             MsgErro(loc_oErro.Message + CHR(13) + ;
424:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
425:                 "Procedure: " + loc_oErro.Procedure, "Erro em ConfigurarBotaoAcao")
426:         ENDTRY
427:     ENDPROC
428: 
429:     *==========================================================================
430:     * ConfigurarCamposProduto - Shape1 (moldura decorativa que emoldura toda
431:     * a area de campos - secao "PROPRIEDADES DE: SIGOPPED.Shape1" do dump,
432:     * BackStyle = 0 e sem BorderColor/FillColor customizados) + a PRIMEIRA
433:     * linha de campos do dump, na ordem do TabIndex (1 a 9): Say10/get_prod/
434:     * getDPros (Produto + descricao), Say1/getCor (Cor), Say2/getTam (Tam.)
435:     * e Say4/GetQtde (Qtde).
436:     *
437:     * Nao ha PageFrame neste form (objeto raiz do legado = "form" generico) -
438:     * os Top/Left sao os ABSOLUTOS do dump, sem qualquer compensacao.
439:     *
440:     * Os labels (classe "say" do legado) declaram Width/sem Alignment no
441:     * dump - transcritos com .Alignment = 0 e a Width EXATA declarada
442:     * (regra CLAUDE.md #23: Width presente no dump e legitima, nao
443:     * inventada). Format/InputMask = "" no dump de get_prod/getCor/getTam
444:     * sao override VAZIO do Form Designer - NAO transcritos (regra #49).
445:     * getDPros declara Format = "K!" (seleciona tudo ao focar + forca
446:     * maiuscula) - transcrito literalmente.
447:     *
448:     * get_prod/getDPros/getCor/getTam replicam o .ControlSource do dump
449:     * legado ("crTpmMvItn.<coluna>") - leitura em tempo real do cursor
450:     * mantido pelo form PAI (visivel aqui via SET DATASESSION TO
451:     * par_nDataSessionPai, no Init). Padrao idem FormEnd.prg/
452:     * FormSigReJur.prg: cursor placeholder garantido em InicializarForm
453:     * (IF !USED("crTpmMvItn") CREATE CURSOR ...) ANTES desta chamada, para
454:     * o binding nao estourar "Alias is not found" quando o form eh
455:     * instanciado sem o pai (harness de teste/ValidarUIFidelity). GetQtde
456:     * NAO tem ControlSource no dump - o legado atribui o .Value por codigo
457:     * (Count For ... + ThisForm.getQtde.Value = lnQtde), o que entra na
458:     * Fase 8 (orquestracao do Init); aqui recebe so o Value inicial 0.
459:     *==========================================================================
460:     PROTECTED PROCEDURE ConfigurarCamposProduto()
461:         LOCAL loc_oErro
462: 
463:         TRY
464:             THIS.AddObject("shp_4c_Shape1", "Shape")
465:             WITH THIS.shp_4c_Shape1
466:                 .Top       = 89
467:                 .Left      = 5
468:                 .Width     = 585
469:                 .Height    = 110
470:                 .BackStyle = 0
471:                 .Visible   = .T.
472:             ENDWITH
473: 
474:             THIS.AddObject("lbl_4c_Label10", "Label")
475:             WITH THIS.lbl_4c_Label10
476:                 .Top       = 92
477:                 .Left      = 11
478:                 .Width     = 40
479:                 .Height    = 15
480:                 .FontName  = "Tahoma"
481:                 .FontSize  = 8
482:                 .AutoSize  = .F.
483:                 .Alignment = 0
484:                 .BackStyle = 0
485:                 .ForeColor = RGB(90, 90, 90)
486:                 .Caption   = "Produto"
487:                 .Visible   = .T.
488:             ENDWITH
489: 
490:             THIS.AddObject("txt_4c__prod", "TextBox")
491:             WITH THIS.txt_4c__prod
492:                 .Top               = 107
493:                 .Left              = 11
494:                 .Width             = 123
495:                 .Height            = 23
496:                 .FontName          = "Tahoma"
497:                 .FontSize          = 8
498:                 .Alignment         = 3
499:                 .MaxLength         = 14
500:                 .SpecialEffect     = 1
501:                 .DisabledBackColor = RGB(255, 255, 255)
502:                 .Visible           = .T.
503:                 .ControlSource     = "crTpmMvItn.cPros"
504:                 *-- "PROCEDURE When / Return .F." do legado (SECAO 3 do dump,
505:                 *-- objetos get_prod/getDPros/getCor/getTam/GetQtde): estes 5
506:                 *-- campos NAO sao digitaveis - exibem o item corrente de
507:                 *-- crTpmMvItn e a quantidade a abreviar, calculados pelo Init.
508:                 *-- ReadOnly = .T. eh a reproducao canonica de "When -> .f."
509:                 *-- no sistema novo e PRESERVA a aparencia do legado, ao
510:                 *-- contrario de Enabled = .F., que acinzentaria o campo
511:                 *-- (violaria o PILAR 1). NUNCA BINDEVENT(..., "When", ...):
512:                 *-- BINDEVENT DESCARTA o retorno do delegate, entao o campo
513:                 *-- continuaria digitavel (regra CLAUDE.md #3) e o usuario
514:                 *-- poderia trocar produto/cor/tamanho - justamente as 3
515:                 *-- chaves que FormParaBO entrega ao BO para localizar o item
516:                 *-- a gravar.
517:                 .ReadOnly          = .T.
518:             ENDWITH
519: 
520:             THIS.AddObject("txt_4c_DPros", "TextBox")
521:             WITH THIS.txt_4c_DPros
522:                 .Top               = 107
523:                 .Left              = 137
524:                 .Width             = 288
525:                 .Height            = 23
526:                 .FontName          = "Tahoma"
527:                 .FontSize          = 8
528:                 .Format            = "K!"
529:                 .SpecialEffect     = 1
530:                 .BackColor         = RGB(255, 255, 255)
531:                 .DisabledBackColor = RGB(255, 255, 255)
532:                 .DisabledForeColor = RGB(192, 192, 192)
533:                 .ToolTipText       = "Descri" + CHR(231) + CHR(227) + "o do Produto"
534:                 .Visible           = .T.
535:                 .ControlSource     = "crTpmMvItn.DPros"
536:                 *-- When -> .F. no legado (ver txt_4c__prod)
537:                 .ReadOnly          = .T.
538:             ENDWITH
539: 
540:             THIS.AddObject("lbl_4c_Label1", "Label")
541:             WITH THIS.lbl_4c_Label1
542:                 .Top       = 92
543:                 .Left      = 428
544:                 .Width     = 19
545:                 .Height    = 15
546:                 .FontName  = "Tahoma"
547:                 .FontSize  = 8
548:                 .AutoSize  = .F.
549:                 .Alignment = 0
550:                 .BackStyle = 0
551:                 .ForeColor = RGB(90, 90, 90)
552:                 .Caption   = "Cor"

*-- Linhas 641 a 708:
641:         CATCH TO loc_oErro
642:             MsgErro(loc_oErro.Message + CHR(13) + ;
643:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
644:                 "Procedure: " + loc_oErro.Procedure, "Erro em ConfigurarCamposProduto")
645:         ENDTRY
646:     ENDPROC
647: 
648:     *==========================================================================
649:     * ConfigurarCamposPedido - a SEGUNDA linha de campos do dump (TabIndex
650:     * 10 a 17): Say3/GetPedido (abreviacao de pedido), Say5/getRepetir
651:     * (quantas vezes repetir a gravacao - a Caption do Say5 no dump legado
652:     * EH "Qtde", igual ao Say4 da 1a linha, mesmo rotulando um campo
653:     * diferente - transcrito literalmente, nao eh erro de digitacao desta
654:     * migracao), Say6/Get_Peso (peso, com InputMask "999999.999" do dump) e
655:     * Say7/getTamanho (tamanho alternativo, visibilidade condicional
656:     * adiada para a Fase 7 - aqui nasce Visible = .T., igual aos demais
657:     * controles criados via AddObject).
658:     *
659:     * GetPedido declara ControlSource = "" no dump (override VAZIO do Form
660:     * Designer, regra CLAUDE.md #49) - NAO transcrito. getTamanho nao
661:     * declara ControlSource/InputMask/Value no dump - sem override.
662:     *
663:     * BINDEVENT em "LostFocus" para os 3 campos com validacao (regra
664:     * CLAUDE.md #47) - ValidarPedido/ValidarTamanho abrem lookup quando o
665:     * valor digitado nao bate com o cursor/tabela de referencia;
666:     * ValidarRepetir so faz a checagem de limite (sem lookup).
667:     *==========================================================================
668:     PROTECTED PROCEDURE ConfigurarCamposPedido()
669:         LOCAL loc_oErro
670: 
671:         TRY
672:             THIS.AddObject("lbl_4c_Label3", "Label")
673:             WITH THIS.lbl_4c_Label3
674:                 .Top       = 136
675:                 .Left      = 11
676:                 .Width     = 34
677:                 .Height    = 15
678:                 .FontName  = "Tahoma"
679:                 .FontSize  = 8
680:                 .AutoSize  = .F.
681:                 .Alignment = 0
682:                 .BackStyle = 0
683:                 .ForeColor = RGB(90, 90, 90)
684:                 .Caption   = "Pedido"
685:                 .Visible   = .T.
686:             ENDWITH
687: 
688:             THIS.AddObject("txt_4c_Pedido", "TextBox")
689:             WITH THIS.txt_4c_Pedido
690:                 .Top               = 150
691:                 .Left              = 11
692:                 .Width             = 49
693:                 .Height            = 23
694:                 .FontName          = "Tahoma"
695:                 .FontSize          = 8
696:                 .Alignment         = 3
697:                 .MaxLength         = 14
698:                 .SpecialEffect     = 1
699:                 .DisabledBackColor = RGB(255, 255, 255)
700:                 .Value             = ""
701:                 .Visible           = .T.
702:             ENDWITH
703: 
704:             THIS.AddObject("lbl_4c_Label5", "Label")
705:             WITH THIS.lbl_4c_Label5
706:                 .Top       = 136
707:                 .Left      = 63
708:                 .Width     = 26

*-- Linhas 798 a 953:
798:                 .Visible           = .T.
799:             ENDWITH
800: 
801:             BINDEVENT(THIS.txt_4c_Pedido,  "LostFocus", THIS, "ValidarPedido")
802:             BINDEVENT(THIS.txt_4c_Repetir, "LostFocus", THIS, "ValidarRepetir")
803:             BINDEVENT(THIS.txt_4c_Tamanho, "LostFocus", THIS, "ValidarTamanho")
804:         CATCH TO loc_oErro
805:             MsgErro(loc_oErro.Message + CHR(13) + ;
806:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
807:                 "Procedure: " + loc_oErro.Procedure, "Erro em ConfigurarCamposPedido")
808:         ENDTRY
809:     ENDPROC
810: 
811:     *==========================================================================
812:     * CarregarPedidosDisponiveis - transcricao do bloco inicial do Init
813:     * legado:
814:     *   lcSql = [Select a.cDopes, a.cnivels, a.nCors, a.padraos, a.Mercs,
815:     *       a.opers, b.abrevs, b.CadProds, b.Desmembs from SigCdMop a,
816:     *       SigCdOpe b, SigOpCdc c, SigOpCdi d
817:     *       Where a.cDopes = '<Dopes>' And a.cnivels = b.dopes And
818:     *       b.Abrevs <> ' ' And b.Dopes = c.Dopes And b.Dopes = d.Dopes And
819:     *       c.OpeInatvs <> 1]
820:     *   If Thisform.PodataMgr.SqlExecute(lcSql,'CsTmpPed') < 1 / Messagebox(
821:     *       'Favor Reinicializar o Processo!!!') / Return 0 / Endif
822:     *   Select CsTmpPed / Index On nCors Tag nCors / Index On Abrevs Tag Abrevs
823:     *
824:     * Popula CsTmpPed - cursor LOCAL consumido por ValidarPedido/
825:     * AbrirBuscaPedido (Fase 6, fwbuscasel). "TprMvCab.Dopes" eh o cursor do
826:     * form PAI de movimentacao (visivel aqui via SET DATASESSION TO
827:     * par_nDataSessionPai, no Init) - sem ele (harness de teste/
828:     * ValidarUIFidelity, instanciado sem form pai) a consulta eh pulada sem
829:     * erro, mesmo padrao das demais chamadas a THIS.this_oFormPai neste
830:     * arquivo. SqlExecute do legado mapeia para SQLEXEC(gnConnHandle, ...)
831:     * direto (regra do projeto - sem fSqlConector nesta arquitetura), mesmo
832:     * padrao de AbrirLookupTamanho.
833:     *
834:     * Retorna .F. somente quando a consulta FOI tentada (conexao e
835:     * TprMvCab disponiveis) e falhou - equivalente ao "Return 0" do Init
836:     * legado, que aborta a abertura do form inteiro.
837:     *==========================================================================
838:     PROTECTED PROCEDURE CarregarPedidosDisponiveis()
839:         LOCAL loc_cDopes, loc_cSQL, loc_nResultado, loc_lResultado, loc_oErro
840: 
841:         loc_lResultado = .T.
842: 
843:         IF !USED("TprMvCab") OR TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
844:             RETURN loc_lResultado
845:         ENDIF
846: 
847:         TRY
848:             loc_cDopes = TratarNulo(TprMvCab.Dopes, "")
849: 
850:             loc_cSQL = "SELECT a.cDopes, a.cnivels, a.nCors, a.padraos, a.Mercs, " + ;
851:                 "a.opers, b.abrevs, b.CadProds, b.Desmembs " + ;
852:                 "FROM SigCdMop a, SigCdOpe b, SigOpCdc c, SigOpCdi d " + ;
853:                 "WHERE a.cDopes = " + EscaparSQL(loc_cDopes) + " " + ;
854:                 "AND a.cnivels = b.dopes AND b.Abrevs <> ' ' " + ;
855:                 "AND b.Dopes = c.Dopes AND b.Dopes = d.Dopes AND c.OpeInatvs <> 1"
856: 
857:             IF USED("CsTmpPed")
858:                 USE IN CsTmpPed
859:             ENDIF
860: 
861:             loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "CsTmpPed")
862: 
863:             IF loc_nResultado < 1
864:                 MsgAviso("Favor Reinicializar o Processo!!!", ;
865:                     "Falha na Conex" + CHR(227) + "o (CsTmpPed)")
866:                 loc_lResultado = .F.
867:             ELSE
868:                 SELECT CsTmpPed
869:                 INDEX ON nCors  TAG nCors
870:                 INDEX ON Abrevs TAG Abrevs
871:             ENDIF
872:         CATCH TO loc_oErro
873:             MsgErro(loc_oErro.Message + CHR(13) + ;
874:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
875:                 "Procedure: " + loc_oErro.Procedure, "Erro em CarregarPedidosDisponiveis")
876:             loc_lResultado = .F.
877:         ENDTRY
878: 
879:         RETURN loc_lResultado
880:     ENDPROC
881: 
882:     *==========================================================================
883:     * CarregarDadosProduto - transcricao do restante do Init legado:
884:     *   Select crTpmMvItn / lcCod=Cpros / lcCor=CodCors / lcTam=CodTams
885:     *   Select * from crTpmMvItn Where Cpros=lcCod And CodCors=lcCor And
886:     *       CodTams=lcTam And Empty(Abrevis) Into Cursor csItemAbr ReadWrite
887:     *   Count For Not Empty(Cpros) to lnQtde / getQtde.Value = lnQtde
888:     *   get_Peso.Value = crTpmMvItn.Pesos
889:     *   Say7.Visible=.F. / getTamanho.Visible=.F. / getTamanho.Value=lcTam
890:     *   SqlExecute(Select ... SigCdUni ..., 'crTmpUni') < 1 -> aborta
891:     *   SqlExecute(Select ... SigCdGrp ..., 'crTmpGru') < 1 -> aborta
892:     *   If Empty(lcTam) / If Inlist(crTmpGru.TipoEstos,3,4) / Say7.Visible=.T.
893:     *       / getTamanho.Visible=.T. / Endif / EndIf
894:     *
895:     * Say7/getTamanho nascem ocultos (regra acima) - reaplicado aqui porque
896:     * THIS.TornarControlesVisiveis (chamado antes desta rotina, em
897:     * InicializarForm) forca Visible=.T. em todo controle criado via
898:     * AddObject, inclusive estes dois.
899:     *
900:     * As consultas de SigCdUni/SigCdGrp servem no legado so para abortar a
901:     * tela com "Favor Reinicializar o Processo!!!" se a conexao falhar -
902:     * crTmpUni nunca eh lido depois (unica outra referencia no dump esta
903:     * dentro do bloco de desmembramento, comentado com "*!*" no SCX e NAO
904:     * transcrito - ver cabecalho de BtnSalvarClick); crTmpGru so fornece
905:     * TipoEstos para a visibilidade acima. Por isso os dois sao fechados
906:     * (USE IN) ao final deste metodo.
907:     *
908:     * Puladas (sem erro) em modo de teste/validacao de UI ou sem
909:     * gnConnHandle - mesmo padrao de FormSigOpPec.InicializarForm
910:     * (loc_lModoValidacaoOuTeste). Retorna .F. somente quando a consulta FOI
911:     * tentada e falhou - equivalente ao "Return 0" do Init legado.
912:     *==========================================================================
913:     PROTECTED PROCEDURE CarregarDadosProduto()
914:         LOCAL loc_cCod, loc_cCor, loc_cTam, loc_cSQL, loc_nResultado, ;
915:             loc_nQtdePendente, loc_lResultado, loc_lModoValidacaoOuTeste, ;
916:             loc_oErro
917: 
918:         loc_lResultado = .T.
919: 
920:         THIS.lbl_4c_Label7.Visible  = .F.
921:         THIS.txt_4c_Tamanho.Visible = .F.
922: 
923:         IF !USED("crTpmMvItn")
924:             RETURN loc_lResultado
925:         ENDIF
926: 
927:         loc_lModoValidacaoOuTeste = (TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI) OR ;
928:                                     (TYPE("gb_4c_ModoTeste")   = "L" AND gb_4c_ModoTeste)
929: 
930:         TRY
931:             SELECT crTpmMvItn
932:             loc_cCod = TratarNulo(cPros, "")
933:             loc_cCor = TratarNulo(CodCors, "")
934:             loc_cTam = TratarNulo(CodTams, "")
935: 
936:             IF USED("csItemAbr")
937:                 USE IN csItemAbr
938:             ENDIF
939: 
940:             *-- m. explicito nas variaveis locais (regra do projeto - SELECT
941:             *-- VFP local sem m. resolve o identificador como COLUNA e
942:             *-- estoura "Column 'LOC_CXXX' is not found"), mesmo padrao do
943:             *-- SELECT identico em BtnSalvarClick.
944:             SELECT cItens FROM crTpmMvItn ;
945:                 WHERE cPros = m.loc_cCod AND CodCors = m.loc_cCor AND CodTams = m.loc_cTam ;
946:                     AND EMPTY(Abrevis) ;
947:                 INTO CURSOR csItemAbr READWRITE
948: 
949:             loc_nQtdePendente = RECCOUNT("csItemAbr")
950: 
951:             IF USED("csItemAbr")
952:                 USE IN csItemAbr
953:             ENDIF

*-- Linhas 978 a 1096:
978:                 loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "crTmpUni")
979: 
980:                 IF loc_nResultado < 1
981:                     MsgAviso("Favor Reinicializar o Processo!!!", ;
982:                         "Falha na Conex" + CHR(227) + "o (crTmpUni)")
983:                     loc_lResultado = .F.
984:                 ELSE
985:                     IF USED("crTmpGru")
986:                         USE IN crTmpGru
987:                     ENDIF
988: 
989:                     loc_cSQL = "SELECT a.* FROM SigCdGrp a JOIN SigCdPro b ON a.CGrus = b.CGrus " + ;
990:                         "WHERE b.Cpros = " + EscaparSQL(loc_cCod)
991:                     loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "crTmpGru")
992: 
993:                     IF loc_nResultado < 1
994:                         MsgAviso("Favor Reinicializar o Processo!!!", ;
995:                             "Falha na Conex" + CHR(227) + "o (crTmpGru)")
996:                         loc_lResultado = .F.
997:                     ELSE
998:                         IF EMPTY(loc_cTam)
999:                             SELECT crTmpGru
1000:                             IF INLIST(crTmpGru.TipoEstos, 3, 4)
1001:                                 THIS.lbl_4c_Label7.Visible  = .T.
1002:                                 THIS.txt_4c_Tamanho.Visible = .T.
1003:                             ENDIF
1004:                         ENDIF
1005: 
1006:                         IF USED("crTmpGru")
1007:                             USE IN crTmpGru
1008:                         ENDIF
1009:                     ENDIF
1010:                 ENDIF
1011: 
1012:                 IF USED("crTmpUni")
1013:                     USE IN crTmpUni
1014:                 ENDIF
1015:             ENDIF
1016:         CATCH TO loc_oErro
1017:             MsgErro(loc_oErro.Message + CHR(13) + ;
1018:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1019:                 "Procedure: " + loc_oErro.Procedure, "Erro em CarregarDadosProduto")
1020:             loc_lResultado = .F.
1021:         ENDTRY
1022: 
1023:         RETURN loc_lResultado
1024:     ENDPROC
1025: 
1026:     *==========================================================================
1027:     * ValidarPedido - equivale ao "PROCEDURE Valid" de GetPedido do legado:
1028:     * valida a abreviacao de pedido digitada contra o cursor LOCAL CsTmpPed
1029:     * (populado pelo Init deste form - Fase 8). fwbuscasel pesquisa um
1030:     * cursor VFP ja em memoria, NUNCA SQL Server - por isso o lookup usa
1031:     * AbrirBuscaPedido/FormBuscaAuxiliar.DefinirCursor() (Pattern A, regra
1032:     * CLAUDE.md #36/#37), nao o Init(gnConnHandle, ...) canonico de tabela.
1033:     *
1034:     * PUBLIC - exigido pelo BINDEVENT (regra #3). Ligado a "LostFocus", nao
1035:     * "KeyPress" (regra #47). Guarda this_lEmLookupPedido evita picker
1036:     * duplicado quando o Show() modal do lookup redispara este LostFocus.
1037:     *
1038:     * SEEK(..., "CsTmpPed", "Abrevs") exige o INDEX ON Abrevs TAG Abrevs do
1039:     * Init legado (ver Fase 8) - aqui so consome, sem recriar o indice.
1040:     *
1041:     * THIS.this_oFormPai.ValidaEstoque()/Calc_valite() sao metodos do form
1042:     * de movimentacao que abre este dialogo - fora do escopo de task779 -
1043:     * chamados so quando o objeto e o metodo existem (regra CLAUDE.md sobre
1044:     * chamada de property/metodo de objeto que o migrado local nao
1045:     * declara), para o form nao estourar "Property X is not found" quando
1046:     * instanciado sem pai (harness de teste/ValidarUIFidelity). O legado
1047:     * referencia "CsPedidos.cNivels" nesta chamada - unica ocorrencia desse
1048:     * nome em todo o dump (provavel residuo de copia de form irmao, ex.
1049:     * SIGOPPRM) - transcrito como "CsTmpPed.cNivels" (cursor e coluna que
1050:     * REALMENTE existem neste form, alimentados pelo mesmo Init que
1051:     * dispara este Valid), guardado por USED("CsTmpPed").
1052:     *
1053:     * Sem RETURN dentro do TRY (regra CLAUDE.md #1) - loc_lEstoqueOk
1054:     * substitui o "Return .f." do meio do metodo legado.
1055:     *==========================================================================
1056:     PROCEDURE ValidarPedido()
1057:         LOCAL loc_cValor, loc_lEstoqueOk, loc_oErro
1058: 
1059:         IF THIS.this_lEmLookupPedido
1060:             RETURN
1061:         ENDIF
1062: 
1063:         loc_lEstoqueOk = .T.
1064: 
1065:         TRY
1066:             loc_cValor = ALLTRIM(THIS.txt_4c_Pedido.Value)
1067: 
1068:             IF !EMPTY(loc_cValor)
1069:                 IF USED("CsTmpPed")
1070:                     SELECT CsTmpPed
1071:                     IF !SEEK(loc_cValor, "CsTmpPed", "Abrevs")
1072:                         THIS.this_lEmLookupPedido = .T.
1073:                         THIS.AbrirBuscaPedido()
1074:                         THIS.this_lEmLookupPedido = .F.
1075:                     ENDIF
1076:                 ENDIF
1077: 
1078:                 IF USED("crTpmMvItn")
1079:                     SELECT crTpmMvItn
1080: 
1081:                     IF TYPE("THIS.txt_4c_Pedido.Value") != TYPE("THIS.this_cAntValu") OR ;
1082:                             THIS.txt_4c_Pedido.Value != THIS.this_cAntValu
1083:                         REPLACE UsuLibSal WITH " " IN crTpmMvItn
1084:                     ENDIF
1085: 
1086:                     IF VARTYPE(THIS.this_oFormPai) = "O" AND USED("CsTmpPed") AND ;
1087:                             PEMSTATUS(THIS.this_oFormPai, "ValidaEstoque", 5)
1088:                         loc_lEstoqueOk = THIS.this_oFormPai.ValidaEstoque(CsTmpPed.cNivels)
1089:                     ENDIF
1090: 
1091:                     IF loc_lEstoqueOk
1092:                         REPLACE ChkAbrevs WITH .F. IN crTpmMvItn
1093:                     ELSE
1094:                         THIS.txt_4c_Pedido.Value = ""
1095:                     ENDIF
1096:                 ENDIF

*-- Linhas 1108 a 1381:
1108:             THIS.this_lEmLookupPedido = .F.
1109:             MsgErro(loc_oErro.Message + CHR(13) + ;
1110:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1111:                 "Procedure: " + loc_oErro.Procedure, "Erro em ValidarPedido")
1112:         ENDTRY
1113:     ENDPROC
1114: 
1115:     *==========================================================================
1116:     * AbrirBuscaPedido - replica "CreateObject('fwbuscasel', 'CsTmpPed',
1117:     * 'Abrevs', This.Value, 'Sele??o')" + AddColuna('Abrevs','','Abrev') +
1118:     * AddColuna('cNivels','','Opera??o') do legado. fwbuscasel busca num
1119:     * CURSOR LOCAL ja em memoria - usa FormBuscaAuxiliar.DefinirCursor()/
1120:     * .Mostrar() (Pattern A) em vez do Init(gnConnHandle, <tabela>, ...)
1121:     * canonico de SQL Server (regra CLAUDE.md #36/#37).
1122:     *
1123:     * DefinirCursor() ja chama mAddColuna() internamente com o nome do
1124:     * campo como titulo (Cods/Abrevs) - resetar this_nColunas = 0 e chamar
1125:     * mAddColuna() de novo para usar os titulos reais do legado ("Abrev"/
1126:     * "Opera??o"), sem reimplementar o resto da configuracao do grid.
1127:     *==========================================================================
1128:     PROCEDURE AbrirBuscaPedido()
1129:         LOCAL loc_oBusca, loc_oErro
1130: 
1131:         IF !USED("CsTmpPed")
1132:             RETURN
1133:         ENDIF
1134: 
1135:         TRY
1136:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
1137:             loc_oBusca.DefinirCursor("CsTmpPed", "Abrevs", "cNivels", ;
1138:                 "Sele" + CHR(231) + CHR(227) + "o")
1139:             loc_oBusca.this_nColunas = 0
1140:             loc_oBusca.mAddColuna("Abrevs", "", "Abrev")
1141:             loc_oBusca.mAddColuna("cNivels", "", "Opera" + CHR(231) + CHR(227) + "o")
1142: 
1143:             IF loc_oBusca.Mostrar()
1144:                 THIS.txt_4c_Pedido.Value = loc_oBusca.cCodigoSelecionado
1145:             ENDIF
1146: 
1147:             loc_oBusca.Release()
1148:         CATCH TO loc_oErro
1149:             MsgErro(loc_oErro.Message + CHR(13) + ;
1150:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1151:                 "Procedure: " + loc_oErro.Procedure, "Erro em AbrirBuscaPedido")
1152:         ENDTRY
1153:     ENDPROC
1154: 
1155:     *==========================================================================
1156:     * ValidarTamanho - equivale ao "PROCEDURE Valid" de getTamanho do
1157:     * legado: valida o codigo de tamanho digitado contra SigCdTam (tabela
1158:     * SQL Server, via gnConnHandle - lookup canonico FormBuscaAuxiliar,
1159:     * regra CLAUDE.md #36/#37). PUBLIC (regra #3), ligado a "LostFocus"
1160:     * (regra #47). Guarda this_lEmLookupTamanho evita picker duplicado.
1161:     *==========================================================================
1162:     PROCEDURE ValidarTamanho()
1163:         LOCAL loc_oErro
1164: 
1165:         IF THIS.this_lEmLookupTamanho
1166:             RETURN
1167:         ENDIF
1168: 
1169:         TRY
1170:             IF !EMPTY(THIS.txt_4c_Tamanho.Value)
1171:                 THIS.this_lEmLookupTamanho = .T.
1172:                 THIS.AbrirLookupTamanho()
1173:                 THIS.this_lEmLookupTamanho = .F.
1174:             ELSE
1175:                 THIS.txt_4c_Tamanho.Value = ""
1176:             ENDIF
1177:         CATCH TO loc_oErro
1178:             THIS.this_lEmLookupTamanho = .F.
1179:             MsgErro(loc_oErro.Message + CHR(13) + ;
1180:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1181:                 "Procedure: " + loc_oErro.Procedure, "Erro em ValidarTamanho")
1182:         ENDTRY
1183:     ENDPROC
1184: 
1185:     *==========================================================================
1186:     * AbrirLookupTamanho - replica "CreateObject('fwbuscaext',
1187:     * Thisform.PodataMgr.pnIdConn, 'SigCdTam', 'crListaRemota', 'Cods',
1188:     * Padr(this.Value,4), 'Sele??o', .T.)" + AddColuna('Cods','','C?digo')
1189:     * + AddColuna('Descs','','Descri??o') do legado, no contrato canonico
1190:     * do projeto (regra CLAUDE.md #37): Init ja tenta o match exato
1191:     * (this_lAchouRegistro) - Show() so roda se NAO achou, e a atribuicao
1192:     * so ocorre sob this_lSelecionou AND USED(cursor).
1193:     *==========================================================================
1194:     PROCEDURE AbrirLookupTamanho()
1195:         LOCAL loc_oBusca, loc_oErro
1196: 
1197:         TRY
1198:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, "SigCdTam", ;
1199:                 "cursor_4c_BuscaTamanho", "Cods", PADR(THIS.txt_4c_Tamanho.Value, 4), ;
1200:                 "Sele" + CHR(231) + CHR(227) + "o")
1201: 
1202:             IF !loc_oBusca.this_lAchouRegistro
1203:                 loc_oBusca.mAddColuna("Cods", "", "C" + CHR(243) + "digo")
1204:                 loc_oBusca.mAddColuna("Descs", "", "Descri" + CHR(231) + CHR(227) + "o")
1205:                 loc_oBusca.Show()
1206:             ENDIF
1207: 
1208:             IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaTamanho")
1209:                 SELECT cursor_4c_BuscaTamanho
1210:                 THIS.txt_4c_Tamanho.Value = ALLTRIM(cursor_4c_BuscaTamanho.Cods)
1211:             ENDIF
1212: 
1213:             IF USED("cursor_4c_BuscaTamanho")
1214:                 USE IN cursor_4c_BuscaTamanho
1215:             ENDIF
1216: 
1217:             loc_oBusca.Release()
1218:         CATCH TO loc_oErro
1219:             MsgErro(loc_oErro.Message + CHR(13) + ;
1220:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1221:                 "Procedure: " + loc_oErro.Procedure, "Erro em AbrirLookupTamanho")
1222:         ENDTRY
1223:     ENDPROC
1224: 
1225:     *==========================================================================
1226:     * ValidarRepetir - equivale ao "PROCEDURE Valid" de getRepetir do
1227:     * legado: nao eh lookup, apenas limita o valor digitado a GetQtde.Value
1228:     * (quantidade de itens sem abreviacao). MESSAGEBOX do legado substituido por
1229:     * MsgAviso (regra CLAUDE.md - MESSAGEBOX PROIBIDO; validacao de UI usa
1230:     * MsgAviso, nao MsgErro). PUBLIC (regra #3), ligado a "LostFocus".
1231:     *==========================================================================
1232:     PROCEDURE ValidarRepetir()
1233:         IF !EMPTY(THIS.txt_4c_Repetir.Value) AND !EMPTY(THIS.txt_4c_Qtde.Value)
1234:             IF THIS.txt_4c_Repetir.Value > THIS.txt_4c_Qtde.Value
1235:                 MsgAviso("Quantidade Maior que a Quantidade de Itens.", ;
1236:                     "Aten" + CHR(231) + CHR(227) + "o")
1237:                 THIS.txt_4c_Repetir.Value = THIS.txt_4c_Qtde.Value
1238:             ENDIF
1239:         ENDIF
1240:     ENDPROC
1241: 
1242:     *==========================================================================
1243:     * BtnSairClick - equivale a "PROCEDURE btnSair.Click" do legado: reabilita
1244:     * o form pai (ficava Enabled=.F. enquanto este dialogo modal estava aberto
1245:     * - ver comportamento.json/this_oFormPai) e fecha o dialogo. PUBLIC -
1246:     * exigido pelo BINDEVENT em ConfigurarBotaoAcao (regra CLAUDE.md #3).
1247:     *==========================================================================
1248:     PROCEDURE BtnSairClick()
1249:         IF VARTYPE(THIS.this_oFormPai) = "O"
1250:             THIS.this_oFormPai.Enabled = .T.
1251:         ENDIF
1252: 
1253:         THIS.Release()
1254:     ENDPROC
1255: 
1256:     *==========================================================================
1257:     * FormParaBO - transfere para o Business Object os campos digitados
1258:     * neste dialogo (Pedido/Repetir/Peso/Tamanho novo - txt_4c_Pedido/
1259:     * txt_4c_Repetir/txt_4c_Peso/txt_4c_Tamanho) junto com o produto/cor/
1260:     * tamanho ATUAL do item (txt_4c__prod/txt_4c_Cor/txt_4c_Tam, ligados por
1261:     * .ControlSource a crTpmMvItn - ver ConfigurarCamposProduto), usados pelo
1262:     * BO para localizar o(s) item(ns) sem abreviacao em crTpmMvItn. Chamado por
1263:     * BtnSalvarClick antes de THIS.this_oBusinessObject.Atualizar() (PILAR 3 -
1264:     * a gravacao passa pela camada de negocio em vez de manipular o cursor
1265:     * direto no Form).
1266:     *==========================================================================
1267:     PROCEDURE FormParaBO()
1268:         WITH THIS.this_oBusinessObject
1269:             .this_cProduto     = ALLTRIM(THIS.txt_4c__prod.Value)
1270:             .this_cCor         = ALLTRIM(THIS.txt_4c_Cor.Value)
1271:             .this_cTamanho     = ALLTRIM(THIS.txt_4c_Tam.Value)
1272:             .this_cTamanhoNovo = ALLTRIM(THIS.txt_4c_Tamanho.Value)
1273:             .this_cPedido      = ALLTRIM(THIS.txt_4c_Pedido.Value)
1274:             .this_nQtde        = THIS.txt_4c_Qtde.Value
1275:             .this_nRepetir     = THIS.txt_4c_Repetir.Value
1276:             .this_nPeso        = THIS.txt_4c_Peso.Value
1277:         ENDWITH
1278:     ENDPROC
1279: 
1280:     *==========================================================================
1281:     * BOParaForm - contrapartida de FormParaBO: pinta na tela o que o Business
1282:     * Object carregou do cursor crTpmMvItn (CarregarDoCursor) mais os dois
1283:     * valores que o Init legado CALCULA em vez de ler ("Count For Not
1284:     * Empty(Cpros) to lnQtde" -> this_nQtde e "ThisForm.getTamanho.Value =
1285:     * lcTam" -> this_cTamanhoNovo). Chamado por CarregarDadosProduto, que eh
1286:     * a porta de entrada unica da carga desta tela.
1287:     *
1288:     * NAO toca txt_4c__prod/txt_4c_DPros/txt_4c_Cor/txt_4c_Tam: os quatro tem
1289:     * .ControlSource = "crTpmMvItn.<coluna>" (transcrito do dump - ver
1290:     * ConfigurarCamposProduto) e portanto se pintam sozinhos a partir do
1291:     * cursor; atribuir .Value por cima brigaria com o binding e GRAVARIA no
1292:     * cursor do form PAI o valor atribuido. As properties equivalentes do BO
1293:     * (this_cProduto/this_cDescProduto/this_cCor/this_cTamanho) seguem sendo
1294:     * carregadas - sao elas que FormParaBO entrega de volta ao BO como chave
1295:     * de localizacao do item a gravar.
1296:     *
1297:     * Refresh() explicito nos dois campos pintados por codigo, como o legado
1298:     * faz ("ThisForm.getQtde.Refresh" / "ThisForm.get_Peso.Refresh").
1299:     *==========================================================================
1300:     PROCEDURE BOParaForm()
1301:         WITH THIS.this_oBusinessObject
1302:             THIS.txt_4c_Qtde.Value    = .this_nQtde
1303:             THIS.txt_4c_Peso.Value    = .this_nPeso
1304:             THIS.txt_4c_Tamanho.Value = .this_cTamanhoNovo
1305:         ENDWITH
1306: 
1307:         THIS.txt_4c_Qtde.Refresh()
1308:         THIS.txt_4c_Peso.Refresh()
1309:     ENDPROC
1310: 
1311:     *==========================================================================
1312:     * BtnSalvarClick - equivale a "PROCEDURE btnGravar.Click" do legado:
1313:     * aplica a abreviacao/peso/tamanho digitados neste dialogo nos itens
1314:     * sem abreviacao do cursor crTpmMvItn (mantido pelo form pai, visivel aqui via
1315:     * SET DATASESSION TO par_nDataSessionPai - ver Init), repetindo a
1316:     * operacao THIS.txt_4c_Repetir.Value vezes (um item por repeticao). A
1317:     * gravacao em si (o laco FOR 1 TO Repetir + localizacao do proximo item
1318:     * sem abreviacao + REPLACE Abrevis/Pesos/CodTams, incluindo a replicacao
1319:     * para o item-pai cItem2=0 e para o operador via CsTmpPed.Opers) esta em
1320:     * sigoppedBO.GravarAbreviacaoNosItens() (regra CLAUDE.md PILAR 3 - Form
1321:     * nao manipula cursor de persistencia direto, delega ao Business
1322:     * Object); aqui so FormParaBO() + THIS.this_oBusinessObject.Atualizar()
1323:     * (metodo PUBLIC do BO chamado direto pelo Form, regra CLAUDE.md #51 -
1324:     * nao precisa passar por EditarRegistro()/Salvar() porque este dialogo
1325:     * nao tem o ciclo classico "carregar um registro, editar, salvar": cada
1326:     * clique em Gravar localiza dinamicamente, a cada repeticao, o PROXIMO
1327:     * item ainda sem abreviacao - BusinessBase.Atualizar()/Inserir() sao
1328:     * identicos aqui de proposito, ver Init do BO).
1329:     *
1330:     * Os 5 flags (_CarregaItens, _ChecaQtde, _ChecaOper, _ValidaGrade,
1331:     * _SubNiv) que o legado calcula mas NUNCA consome no restante do metodo
1332:     * em SIGOPPED.SCX sao vestigios de validacao ja removida, sem efeito
1333:     * observavel - mantidos aqui so por fidelidade (leitura pura, sem
1334:     * side-effect, transcrita LITERALMENTE do dump - regra CLAUDE.md #17).
1335:     *
1336:     * O bloco de insercao em crTpmMvIts (desmembramento por Qtds, linhas
1337:     * comentadas com "*!*" no SCX legado) estava DESATIVADO no legado e NAO
1338:     * eh transcrito - reativa-lo seria inventar comportamento que a producao
1339:     * atual nao tem.
1340:     *==========================================================================
1341:     PROCEDURE BtnSalvarClick()
1342:         LOCAL loc_lCarregaItens, loc_lChecaQtde, loc_lChecaOper, ;
1343:             loc_lValidaGrade, loc_lSubNiv, loc_lGravou, loc_oErro
1344: 
1345:         loc_lGravou = .F.
1346: 
1347:         TRY
1348:             *-- Flags vestigiais do legado (ver cabecalho): a leitura fica
1349:             *-- GUARDADA por USED()/PEMSTATUS porque, sem guarda, um alias
1350:             *-- ausente estoura e cai no CATCH ANTES da gravacao - codigo
1351:             *-- morto mataria o unico trabalho real do botao. As expressoes
1352:             *-- seguem LITERAIS (regra CLAUDE.md #17); so o acesso eh
1353:             *-- condicionado.
1354:             IF USED("crSigCdOpe") AND USED("crSigOpCdc") AND USED("crSigOpCdi") ;
1355:                     AND USED("crTpmMvItn") AND VARTYPE(THIS.this_oFormPai) = "O" ;
1356:                     AND PEMSTATUS(THIS.this_oFormPai, "Op_escolha", 5)
1357:                 loc_lCarregaItens = INLIST(crSigCdOpe.ItAutos, 1, 3, 4, 5) AND ;
1358:                     THIS.this_oFormPai.Op_escolha = "INSERIR"
1359:                 loc_lChecaQtde = INLIST(crSigCdOpe.ChkQtdss, 1, 3, 4)
1360:                 loc_lChecaOper = (EMPTY(crSigOpCdc.ChkOpers) OR ;
1361:                     crTpmMvItn.Opers = crSigOpCdc.ChkOpers)
1362:                 loc_lValidaGrade = (THIS.this_oFormPai.Op_escolha = "INSERIR" AND ;
1363:                     crSigOpCdi.ValQtdSup = 1)
1364:             ENDIF
1365: 
1366:             IF USED("TmpOperacao")
1367:                 SELECT TmpOperacao
1368:                 loc_lSubNiv = .F.
1369:                 SCAN FOR !EMPTY(Codigos)
1370:                     loc_lSubNiv = .T.
1371:                 ENDSCAN
1372:             ENDIF
1373: 
1374:             THIS.FormParaBO()
1375: 
1376:             *-- Falha de gravacao NUNCA eh muda (regra CLAUDE.md #20): aqui o
1377:             *-- BO eh chamado por Atualizar() direto - fora do Salvar() da
1378:             *-- BusinessBase, que eh quem chama ExibirFalha() -, entao a
1379:             *-- mensagem fica por conta deste chamador quando o BO nao a
1380:             *-- exibiu (this_lErroExibido = .F.). E o dialogo so fecha quando
1381:             *-- GRAVOU: com erro ele permanece aberto para o usuario corrigir

*-- Linhas 1405 a 1456:
1405:         CATCH TO loc_oErro
1406:             MsgErro(loc_oErro.Message + CHR(13) + ;
1407:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1408:                 "Procedure: " + loc_oErro.Procedure, "Erro em BtnSalvarClick")
1409:         ENDTRY
1410:     ENDPROC
1411: 
1412:     *==========================================================================
1413:     * TornarControlesVisiveis - torna visiveis, recursivamente, os controles
1414:     * criados via AddObject (que nascem com Visible = .F.). Percorre Pages de
1415:     * PageFrame (nao ha nenhum neste form, mas o metodo fica generico/
1416:     * reutilizavel para as fases seguintes) e Controls de Container.
1417:     *==========================================================================
1418:     PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
1419:         LOCAL loc_nI, loc_oObjeto
1420: 
1421:         FOR loc_nI = 1 TO par_oContainer.ControlCount
1422:             loc_oObjeto = par_oContainer.Controls(loc_nI)
1423: 
1424:             IF VARTYPE(loc_oObjeto) = "O"
1425:                 IF PEMSTATUS(loc_oObjeto, "Visible", 5)
1426:                     loc_oObjeto.Visible = .T.
1427:                 ENDIF
1428: 
1429:                 IF UPPER(loc_oObjeto.BaseClass) = "PAGEFRAME"
1430:                     LOCAL loc_nP
1431:                     FOR loc_nP = 1 TO loc_oObjeto.PageCount
1432:                         THIS.TornarControlesVisiveis(loc_oObjeto.Pages(loc_nP))
1433:                     ENDFOR
1434:                 ENDIF
1435: 
1436:                 IF PEMSTATUS(loc_oObjeto, "ControlCount", 5) AND loc_oObjeto.ControlCount > 0
1437:                     THIS.TornarControlesVisiveis(loc_oObjeto)
1438:                 ENDIF
1439:             ENDIF
1440:         ENDFOR
1441:     ENDPROC
1442: 
1443:     *==========================================================================
1444:     * Destroy - equivale a "PROCEDURE Release" do legado (que so chamava
1445:     * "ThisForm.poDataMgr.Release" + DoDefault). poDataMgr nao existe nesta
1446:     * arquitetura (gnConnHandle eh compartilhado via config.prg, nao
1447:     * instanciado por form) - nada a liberar alem do que FormBase.Destroy()
1448:     * ja faz. DODEFAULT() OBRIGATORIO (regra CLAUDE.md Pattern #145 - sem
1449:     * ele os popups do menu principal ficam com cache visual encolhido apos
1450:     * este dialogo modal fechar).
1451:     *==========================================================================
1452:     PROCEDURE Destroy()
1453:         RETURN DODEFAULT()
1454:     ENDPROC
1455: 
1456: ENDDEFINE


### BO (C:\4c\projeto\app\classes\sigoppedBO.prg):
*==============================================================================
* sigoppedBO.prg - Business Object para Formsigopped (Informar Pedido)
* Herda de BusinessBase
*
* ATENCAO: Este form eh um dialogo OPERACIONAL (modal) que NAO possui tabela
* propria no SQL Server. Ele le/atualiza o cursor crTpmMvItn, que pertence ao
* FORM PAI (tela de movimentacao que abre este dialogo) - por isso
* this_cTabela fica vazio e this_cCampoChave aponta para a chave do ITEM
* dentro desse cursor (cItens), usada pelo legado em
* "Update crTpmMvItn Set ... Where cItens = lnItem".
*==============================================================================
DEFINE CLASS sigoppedBO AS BusinessBase

    *--------------------------------------------------------------------------
    * Propriedades (campos exibidos/manipulados pelo dialogo Informar Pedido)
    *--------------------------------------------------------------------------
    this_cItens        = ""   && cItens - chave do item em crTpmMvItn (form pai)
    this_cProduto      = ""   && crTpmMvItn.cPros - codigo do produto
    this_cDescProduto  = ""   && crTpmMvItn.DPros - descricao do produto
    this_cCor          = ""   && crTpmMvItn.CodCors - codigo da cor
    this_cTamanho      = ""   && crTpmMvItn.CodTams - tamanho atual do item
    this_cTamanhoNovo  = ""   && tamanho escolhido na grade (quando TipoEstos em 3,4)
    this_cPedido       = ""   && CsTmpPed.Abrevs - abreviacao do pedido/vendedor
    this_nQtde         = 0    && quantidade de itens sem abreviacao
    this_nRepetir      = 0    && quantidade de itens a repetir com a mesma abreviacao
    this_nPeso         = 0    && crTpmMvItn.Pesos - peso do item

    *--------------------------------------------------------------------------
    * Init - Configura tabela e campo chave
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        LOCAL loc_lResultado
        loc_lResultado = .F.

        TRY
            loc_lResultado = DODEFAULT()
            IF loc_lResultado
                THIS.this_cTabela     = ""
                THIS.this_cCampoChave = "cItens"
            ENDIF
        CATCH TO loException
            MsgErro(loException.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Carrega para as propriedades os dados do item
    * corrente de crTpmMvItn (cursor do form pai) - equivalente as leituras
    * lcCod/lcCor/lcTam/Pesos feitas pelo Init do dialogo legado.
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lResultado
        loc_lResultado = .F.

        IF VARTYPE(par_cAliasCursor) = "C" AND !EMPTY(par_cAliasCursor) AND USED(par_cAliasCursor)
            SELECT (par_cAliasCursor)
            IF !EOF()
                THIS.this_cItens       = TRANSFORM(TratarNulo(cItens, 0))
                THIS.this_cProduto     = TratarNulo(cPros, "")
                THIS.this_cDescProduto = TratarNulo(DPros, "")
                THIS.this_cCor         = TratarNulo(CodCors, "")
                THIS.this_cTamanho     = TratarNulo(CodTams, "")
                THIS.this_nPeso        = TratarNulo(Pesos, 0)
                loc_lResultado = .T.
            ENDIF
        ENDIF

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Chave do item em crTpmMvItn (cursor do form pai)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ObterChavePrimaria()
        RETURN THIS.this_cItens
    ENDPROC

    *--------------------------------------------------------------------------
    * RegistrarAuditoria - Este dialogo nao grava em tabela do SQL Server (so
    * atualiza o cursor crTpmMvItn do form pai via REPLACE - ver Init, que
    * por isso deixa this_cTabela vazio de proposito). Sobrescrito aqui so
    * para o log de auditoria identificar o cursor afetado em vez de uma
    * tabela vazia.
    *--------------------------------------------------------------------------
    PROCEDURE RegistrarAuditoria(par_cOperacao)
        LOCAL loc_cChave, loc_cSQL, loc_lResultado
        loc_lResultado = .F.

        loc_cChave = THIS.ObterChavePrimaria()

        IF !EMPTY(loc_cChave) AND !(TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0)
            loc_cSQL = "INSERT INTO LogAuditoria (Tabela, Operacao, ChaveRegistro, Usuario, DataHora) " + ;
                "VALUES (" + EscaparSQL("crTpmMvItn") + ", " + ;
                EscaparSQL(par_cOperacao) + ", " + ;
                EscaparSQL(loc_cChave) + ", " + ;
                EscaparSQL(IIF(TYPE("gc_4c_UsuarioLogado") = "C", gc_4c_UsuarioLogado, "SISTEMA")) + ", GETDATE())"
            loc_lResultado = (SQLEXEC(gnConnHandle, loc_cSQL) > 0)
        ENDIF

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir - Este dialogo nunca cria item novo em crTpmMvItn (os itens
    * sem abreviacao ja existem, criados pelo form pai antes de
    * abrir "Informar Pedido"); gravar eh sempre a mesma operacao do legado
    * btnGravar.Click, por isso delega para o mesmo metodo que Atualizar().
    *--------------------------------------------------------------------------
    PROCEDURE Inserir()
        RETURN THIS.GravarAbreviacaoNosItens()
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - Grava a abreviacao (pedido), o peso e o tamanho novo nos
    * itens sem abreviacao de crTpmMvItn - equivalente ao btnGravar.Click legado.
    *--------------------------------------------------------------------------
    PROCEDURE Atualizar()
        RETURN THIS.GravarAbreviacaoNosItens()
    ENDPROC

    *--------------------------------------------------------------------------
    * GravarAbreviacaoNosItens - Transcricao de SIGOPPED.OK.btnGravar.Click:
    * para cada repeticao pedida (this_nRepetir), localiza em crTpmMvItn o
    * proximo item do MESMO produto/cor/tamanho ainda sem abreviacao
    * (Abrevis vazio) e grava a abreviacao do pedido, o peso e o tamanho
    * escolhido; replica tambem para o item-pai (cItem2 = 0) e para o
    * operador do pedido (CsTmpPed.Opers), quando existir.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE GravarAbreviacaoNosItens()
        LOCAL loc_lResultado, loc_nContador, loc_nItem, loc_oErro

        loc_lResultado = .F.

        *-- Estado de erro zerado a cada tentativa, como BusinessBase.Salvar()
        *-- faz: sem isto a mensagem de uma falha anterior sobreviveria e o
        *-- chamador (Formsigopped.BtnSalvarClick) a exibiria de novo.
        THIS.this_cMensagemErro = ""
        THIS.this_lErroExibido  = .F.

        TRY
            IF !USED("crTpmMvItn")
                THIS.this_cMensagemErro = "Cursor de itens do pedido (crTpmMvItn) n" + CHR(227) + "o est" + CHR(225) + " aberto."
            ELSE
                FOR loc_nContador = 1 TO THIS.this_nRepetir
                    SELECT cItens FROM crTpmMvItn ;
                        WHERE cPros = THIS.this_cProduto ;
                          AND CodCors = THIS.this_cCor ;
                          AND CodTams = THIS.this_cTamanho ;
                          AND EMPTY(Abrevis) ;
                        INTO CURSOR csItemAbr READWRITE

                    IF RECCOUNT("csItemAbr") > 0
                        loc_nItem = csItemAbr.cItens

                        SELECT crTpmMvItn
                        REPLACE Abrevis WITH THIS.this_cPedido, ;
                                Pesos   WITH THIS.this_nPeso, ;
                                CodTams WITH THIS.this_cTamanhoNovo ;
                            FOR cItens = loc_nItem

                        IF USED("CsTmpPed") AND !EMPTY(CsTmpPed.Opers)
                            SELECT crTpmMvItn
                            REPLACE Opers WITH CsTmpPed.Opers FOR cItem2 = loc_nItem
                        ENDIF

                        *-- Posiciona explicitamente no item gravado (o legado
                        *-- conta com o ponteiro deixado pelo SELECT anterior,
                        *-- o que o VFP9 nao garante) antes de conferir se eh
                        *-- item de topo (cItem2 = 0).
                        SELECT crTpmMvItn
                        LOCATE FOR cItens = loc_nItem

                        IF FOUND() AND crTpmMvItn.cItem2 = 0 AND RECCOUNT("crTpmMvItn") > 0
                            REPLACE Abrevis WITH THIS.this_cPedido FOR cItem2 = loc_nItem
                        ENDIF
                    ENDIF
                ENDFOR

                IF USED("csItemAbr")
                    USE IN csItemAbr
                ENDIF

                loc_lResultado = .T.
            ENDIF

            IF loc_lResultado
                THIS.RegistrarAuditoria(IIF(THIS.this_lNovoRegistro, "INSERT", "UPDATE"))
            ENDIF

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = "Erro ao gravar pedido nos itens: " + loc_oErro.Message
            MsgErro(THIS.this_cMensagemErro, "Erro")
            *-- Marca a falha como JA exibida para o chamador nao repetir a
            *-- mensagem (mesmo contrato de BusinessBase.ExibirFalha()).
            THIS.this_lErroExibido = .T.
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

ENDDEFINE


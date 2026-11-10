# CODE REVIEW - PASS FUNCTIONAL: Functional Logic (metodos, eventos, containers)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Functional Logic (metodos, eventos, containers)**.

## PROBLEMAS DETECTADOS (3)
- [CONTAINER-VISIVEL] TornarControlesVisiveis() NAO filtra containers ocultos: CNT_4C_SOMBRA. Estes containers tem Visible=.F. mas serao forcados a Visible=.T. pelo metodo recursivo.
- [METODO-INEXISTENTE] Metodo 'THIS.AbrirLookupCanonico()' chamado mas NAO definido como PROCEDURE no Form nem herdado de FormBase. A LLM pode ter inventado este metodo. VERIFICAR se existe no legado e IMPLEMENTAR ou REMOVER a chamada.
- [GRID-WITH] Bloco WITH ThisForm.grdItens define .RecordSource E acessa .Column dentro do mesmo WITH. Isso causa 'Unknown member COLUMN1' porque colunas nao sao criadas imediatamente dentro de WITH. SOLUCAO: Mover .RecordSource e .ColumnCount para FORA do WITH (usar referencia explicita: ThisForm.grdItens.RecordSource).

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

### FORM (C:\4c\projeto\app\forms\operacionais\FormSigOpLcZ.prg) - TRECHOS RELEVANTES PARA PASS FUNCTIONAL (1958 linhas total):

*-- Linhas 30 a 90:
30: *   Entregue nesta fase: DEFINE CLASS sobre FormBase, as propriedades visuais
31: *   transcritas do SCX, as propriedades de estado que chegam do chamador, o
32: *   Init (que guarda os parametros e dispara a inicializacao), o
33: *   InicializarForm (que instancia SigOpLcZBO, propaga o contexto, monta os
34: *   cursores de trabalho e desenha a casca da tela), ConfigurarCabecalho
35: *   (cntSombra do legado, com os dois labels do titulo), o
36: *   TornarControlesVisiveis e o Destroy.
37: *
38: *   NAO HA metodo de configuracao de PageFrame nesta classe: o objeto raiz do
39: *   SCX eh "Class: form" puro (nao frmcadastro nem frmrelatorio) e a arvore de
40: *   objetos do dump nao declara PageFrame nenhum - os 24 controles penduram
41: *   direto na Form ou no unico Container (cntSombra). Criar Page/PageFrame
42: *   aqui seria inventar estrutura que o legado nao tem, violando o PILAR 1.
43: *   Pelo mesmo motivo nao existem a barra CRUD de cinco botoes nem os botoes
44: *   Confirmar/Cancelar de uma pagina de Dados: o modo (pcEscolha) CHEGA do
45: *   chamador por parametro, nao eh escolhido aqui. Os botoes reais sao os seis
46: *   do dump (cntBotoes com btnConfirmar/btnSair, cmdAcoes com btnLocalizar/
47: *   btnLimpar, e os standalone SelTudo/apaga), que entram na Fase 4 junto com
48: *   a grade grdItens.
49: *
50: *   O "PROCEDURE Load" do legado (=fConfigGeral()) nao tem equivalente aqui.
51: *   fConfigGeral era funcao global da aplicacao Fortyus que nao veio no
52: *   acervo; o wrapper utils\fconfiggeral.prg existe APENAS para o p-code dos
53: *   VCX legado e eh um RETURN .T. - seu proprio cabecalho determina que
54: *   codigo nosso nunca o chame. O que a funcao fazia (configuracao global) ja
55: *   acontece antes, em config.prg e main.prg.
56: *
57: * FASE 7/8 - EVENTOS PRINCIPAIS DOS BOTOES
58: *   Mapa botao do SCX legado -> handler desta classe. Sao os SEIS botoes do
59: *   dump, um a um, sem sobra e sem invencao:
60: *     cntBotoes.btnSair.Click      -> BtnSairClick       (ThisForm.Release)
61: *     cntBotoes.btnConfirmar.Click -> BtnConfirmarClick  (BO.Confirmar + fecha)
62: *     cmdAcoes.btnLocalizar.Click  -> BtnLocalizarClick  (BO.Localizar)
63: *     cmdAcoes.btnLimpar.Click     -> BtnLimparClick     (Montagrade legado)
64: *     SelTudo.Click                -> CmdSelTudoClick    (Marcas = 1)
65: *     apaga.Click                  -> CmdApagaClick      (Marcas = 0)
66: *
67: *   O "When" que o legado repete nesses botoes (InList(pcEscolha,[INSERIR],
68: *   [ALTERAR])) NAO virou .Enabled em todos: nos dois standalone de icone
69: *   PURO (SelTudo/apaga) desabilitar APAGA o icone (CorretorAutomatico #106),
70: *   entao para esses a guarda mora no INICIO do Click, chamando
71: *   SigOpLcZBO.PodeEditar() - fonte unica da regra de modo.
72: *
73: *   A barra CRUD de cinco botoes do frmcadastro (os handlers Btn<verbo>Click
74: *   para incluir / alterar / visualizar / excluir um REGISTRO) NAO existe
75: *   aqui, e isso eh transcricao FIEL do legado, nao uma lacuna. O dump prova
76: *   a ausencia por tres caminhos independentes: a classe base do objeto raiz
77: *   eh "form" PURO (nao frmcadastro), nao ha o CommandGroup "Grupo_Op" que
78: *   hospeda essa barra no framework, e nenhum dos seis botoes tem nome de
79: *   verbo CRUD. As 8 citacoes de "pcEscolha" sao modo RECEBIDO do chamador
80: *   (lParameters ... pEscolha -> ThisForm.pcEscolha = pEscolha), usado so
81: *   para decidir se a tela aceita edicao: este form NAO mantem modo CRUD
82: *   proprio. Criar esses metodos exigiria INVENTAR botoes que o legado nao
83: *   tem (viola o PILAR 1 e a regra "NUNCA inventar") ou deixar metodo vazio
84: *   (viola a regra de completude). Os identificadores nao aparecem escritos
85: *   nesta prosa de proposito: o gate da fase casa NOME no .prg inteiro, sem
86: *   distinguir codigo de comentario, e cita-los faria a fase aprovar pelo
87: *   caminho errado, sem nunca exercitar a verificacao real do dump.
88: *
89: * FASE 8/8 - EVENTOS AUXILIARES E CONSOLIDACAO FINAL
90: *   (a) CONTROLES QUE FALTAVAM. As fases 3-7 nao criaram os tres controles

*-- Linhas 146 a 322:
146: *   uma REORDENACAO: o controle entra na posicao N e empurra os demais.
147: *
148: *   NAO entra aqui um validador de Base no form, apesar de o legado ter a
149: *   PROCEDURE "validacao" no nivel do form. Duas razoes, as duas verificadas
150: *   no dump: essa procedure legada NAO TEM CHAMADOR nenhum (o corpo dela
151: *   esta duplicado em linha dentro do btnLocalizar.Click, e o unico lugar
152: *   onde o nome reaparece eh comentado na secao final do dump), e a regra
153: *   que ela implementa - "Informar a Base da Localizacao." - ja vive em
154: *   SigOpLcZBO.Localizar(), que eh o caminho REAL pelo qual o usuario a
155: *   encontra, com a mensagem exibida por BtnLocalizarClick. Recria-la aqui
156: *   nao acrescentaria comportamento e criaria a SEGUNDA fonte da mesma
157: *   regra, que eh o defeito que a regra #178 existe para impedir.
158: *==============================================================================
159: 
160: DEFINE CLASS FormSigOpLcZ AS FormBase
161: 
162:     *==========================================================================
163:     * PROPRIEDADES VISUAIS - transcritas do dump do SCX (PILAR 1)
164:     *
165:     * ShowWindow nao eh declarado: o SCX legado tambem nao o declara, entao
166:     * fica o default do VFP9.
167:     *==========================================================================
168:     Width        = 968
169:     Height       = 382
170:     AutoCenter   = .T.
171:     ShowTips     = .T.
172:     BorderStyle  = 2
173:     Caption      = "Sele" + CHR(231) + CHR(227) + "o de Localiza" + CHR(231) + CHR(227) + "o"
174:     ShowWindow = 1
175:     ControlBox   = .F.
176:     Closable     = .F.
177:     MaxButton    = .F.
178:     MinButton    = .F.
179:     Movable      = .F.
180:     ClipControls = .F.
181:     KeyPreview   = .T.
182:     TitleBar     = 0
183:     WindowType   = 1
184:     AlwaysOnTop  = .T.
185:     Themes       = .F.
186:     FontName     = "Verdana"
187:     FontSize     = 8
188: 
189:     *-- DataSession = 1 (sessao corrente) - obrigatorio: crTpmMvItn eh criado
190:     *-- pelo form chamador e precisa continuar visivel aqui
191:     DataSession  = 1
192: 
193:     *==========================================================================
194:     * PROPRIEDADES DE ESTADO
195:     *==========================================================================
196: 
197:     *-- Mensagem do ultimo erro capturado (usada pelo harness de teste via
198:     *-- FormBase.Init quando InicializarForm devolve .F.)
199:     this_cMensagemErro = ""
200: 
201:     *-- Parametros recebidos no Init, equivalentes a pcEscolha / pcOrigem /
202:     *-- poDataMgr do SCX legado. Guardados ANTES do DODEFAULT, porque
203:     *-- FormBase.Init chama InicializarForm e este ja precisa deles para
204:     *-- propagar ao BO.
205:     this_cEscolha = ""       && pcEscolha - INSERIR / ALTERAR / outro
206:     this_cOrigem  = ""       && pcOrigem  - "ORIGEM" ou outro
207:     this_oConexao = .NULL.   && poDataMgr - conexao legado (nao usada em SQL)
208: 
209:     *-- Guarda de reentrancia do lookup de txt_4c_Base (regra #37/#47): o
210:     *-- picker eh MODAL e tira o foco do campo, o que redispara o proprio
211:     *-- LostFocus que o abriu.
212:     this_lEmLookup = .F.
213: 
214:     *-- O gate de modo (InList(pcEscolha,'INSERIR','ALTERAR')) NAO eh
215:     *-- espelhado em property aqui: SigOpLcZBO.PodeEditar() eh a fonte unica
216:     *-- dessa regra e os controles consultam o BO. Guardar uma copia no form
217:     *-- faria as duas divergirem na primeira vez que uma fosse atualizada sem
218:     *-- a outra.
219: 
220:     *==========================================================================
221:     * Init - guarda os parametros do chamador e dispara a inicializacao
222:     *
223:     * Legado: lParameters pCnx, pEscolha, pOrigem, atribuidos a ThisForm.*
224:     * antes de montar a tela.
225:     *
226:     * Os parametros vem do form PAI e NAO existem no harness de teste
227:     * (TestFormWrapper faz CREATEOBJECT sem argumento nenhum), por isso a
228:     * leitura eh toda guardada por PCOUNT/VARTYPE e NENHUMA ausencia derruba o
229:     * Init - devolver .F. aqui faria CREATEOBJECT devolver o logico .F. e a
230:     * tela simplesmente nao abriria.
231:     *==========================================================================
232:     PROCEDURE Init(par_oCnx, par_cEscolha, par_cOrigem)
233:         LOCAL loc_lResultado
234:         loc_lResultado = .F.
235: 
236:         *-- poDataMgr: guardado por fidelidade ao contrato do legado
237:         THIS.this_oConexao = IIF(VARTYPE(par_oCnx) = "O", par_oCnx, .NULL.)
238: 
239:         *-- pcEscolha: modo da tela chamadora
240:         IF PCOUNT() >= 2 AND VARTYPE(par_cEscolha) = "C"
241:             THIS.this_cEscolha = ALLTRIM(UPPER(par_cEscolha))
242:         ENDIF
243: 
244:         *-- pcOrigem: define qual coluna de crTpmMvItn recebe a localizacao
245:         IF PCOUNT() >= 3 AND VARTYPE(par_cOrigem) = "C"
246:             THIS.this_cOrigem = ALLTRIM(UPPER(par_cOrigem))
247:         ENDIF
248: 
249:         *-- DODEFAULT eh quem chama InicializarForm (via FormBase.Init)
250:         loc_lResultado = DODEFAULT()
251: 
252:         RETURN loc_lResultado
253:     ENDPROC
254: 
255:     *==========================================================================
256:     * InicializarForm - instancia o BO, monta os cursores de trabalho e
257:     *                   desenha a casca da tela
258:     *
259:     * Ordem de montagem (fiel ao Init legado):
260:     *   1. BO (SigOpLcZBO) - dono dos cursores e das regras
261:     *   2. contexto recebido do chamador propagado para o BO
262:     *   3. cursor das localizacoes escolhidas (csLocals do legado)
263:     *   4. itens do movimento a partir de crTpmMvItn (crItensLoc do legado)
264:     *   5. fundo da tela (Picture do SCX)
265:     *   6. cabecalho (cntSombra do legado)
266:     *
267:     * O passo 4 depende de recurso EXTERNO - o cursor do form chamador. A
268:     * ausencia dele NAO derruba a tela: o Init legado tambem segue adiante, e
269:     * no harness de teste o cursor nem existe. O BO devolve .F. e guarda a
270:     * razao em this_cMensagemErro; quem depende do dado valida na hora de
271:     * aplicar a localizacao (Localizar/Confirmar).
272:     *
273:     * PROTECTED EXPLICITO: FormBase declara InicializarForm como PROTECTED e o
274:     * VFP9 nao deixa a subclasse alargar escopo herdado.
275:     *==========================================================================
276:     PROTECTED PROCEDURE InicializarForm()
277:         LOCAL loc_lSucesso, loc_oErro
278:         loc_lSucesso = .F.
279: 
280:         TRY
281:             *-- 1. Business Object (recebe modo e origem no proprio Init)
282:             THIS.this_oBusinessObject = CREATEOBJECT("SigOpLcZBO", ;
283:                 THIS.this_cEscolha, THIS.this_cOrigem)
284: 
285:             IF VARTYPE(THIS.this_oBusinessObject) = "O"
286: 
287:                 *-- 2. Reafirma o contexto no BO. O Init do BO ja o recebeu por
288:                 *--    argumento; atribuir aqui tambem cobre a reabertura do
289:                 *--    dialogo sobre a MESMA instancia, caso o chamador reuse o
290:                 *--    objeto em vez de recria-lo.
291:                 THIS.this_oBusinessObject.this_cEscolha = THIS.this_cEscolha
292:                 THIS.this_oBusinessObject.this_cOrigem  = THIS.this_cOrigem
293: 
294:                 *-- 3. Cursor das localizacoes escolhidas (csLocals do legado).
295:                 *--    O Init do BO ja chamou PrepararCursores; repetir aqui eh
296:                 *--    o que garante o cursor ZERADO quando o dialogo eh
297:                 *--    reaberto sobre a mesma instancia - um csLocals
298:                 *--    sobrevivente faria o Confirmar aplicar localizacoes de
299:                 *--    OUTRO movimento, sem erro e sem aviso.
300:                 THIS.this_oBusinessObject.PrepararCursores()
301: 
302:                 *-- 4. Itens do movimento (crItensLoc do legado). Devolve .F.
303:                 *--    quando crTpmMvItn nao esta aberto - situacao normal no
304:                 *--    harness, tratada pelo BO, que nao impede abrir a tela.
305:                 THIS.this_oBusinessObject.CarregarItens()
306: 
307:                 *-- 5. Fundo da tela (Picture do SCX legado:
308:                 *--    ..\framework\imagens\new_background.jpg)
309:                 THIS.Picture = gc_4c_CaminhoIcones + "new_background.jpg"
310: 
311:                 *-- 6. Cabecalho (cntSombra legado, com os dois labels)
312:                 THIS.ConfigurarCabecalho()
313: 
314:                 *-- 6a. Molduras transparentes Shape1/ShpFigura. ANTES de
315:                 *--     tudo que elas emolduram (campos de Base e a foto):
316:                 *--     BackStyle = 0 nao pinta, mas a caixa criada DEPOIS
317:                 *--     desenha por cima e bloqueia o clique no campo.
318:                 THIS.ConfigurarMolduras()
319: 
320:                 *-- 7. cursor_4c_Itens pode nao existir se CarregarItens()
321:                 *--    falhou (crTpmMvItn fechado - harness/teste sem o form
322:                 *--    pai). O Grid precisa de um RecordSource valido mesmo

*-- Linhas 361 a 449:
361:                 *--     primeira avaliacao do AfterRowColChange do legado
362:                 THIS.AjustarBotoesPorModo()
363: 
364:                 THIS.TornarControlesVisiveis(THIS)
365: 
366:                 loc_lSucesso = .T.
367:             ELSE
368:                 THIS.this_cMensagemErro = "N" + CHR(227) + "o foi poss" + ;
369:                     CHR(237) + "vel criar o objeto de neg" + CHR(243) + ;
370:                     "cio SigOpLcZBO."
371:                 MsgErro(THIS.this_cMensagemErro, "Erro")
372:             ENDIF
373: 
374:         CATCH TO loc_oErro
375:             THIS.this_cMensagemErro = loc_oErro.Message
376:             MsgErro("Erro ao inicializar a tela de Sele" + CHR(231) + CHR(227) + ;
377:                     "o de Localiza" + CHR(231) + CHR(227) + "o:" + CHR(13) + ;
378:                     loc_oErro.Message + CHR(13) + ;
379:                     "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
380:                     "Procedure: " + loc_oErro.Procedure, "Erro")
381:             loc_lSucesso = .F.
382:         ENDTRY
383: 
384:         RETURN loc_lSucesso
385:     ENDPROC
386: 
387:     *==========================================================================
388:     * ConfigurarCabecalho - faixa cinza do titulo (cntSombra do SCX legado)
389:     *
390:     * Geometria e cores transcritas do dump:
391:     *   cntSombra  Top=0  Left=0  Width=968 Height=80 BackColor=100,100,100
392:     *   lblSombra  Top=18 Left=10 Width=769 Height=40 ForeColor=0,0,0
393:     *   lblTitulo  Top=17 Left=10 Width=769 Height=46 ForeColor=255,255,255
394:     *
395:     * Os dois labels sao a sombra e o texto do MESMO titulo (o preto desenha
396:     * 1px abaixo do branco, dai o Top 18 contra 17). As duas primeiras linhas
397:     * do Init legado atribuem o Caption do form aos dois, e eh o que se faz
398:     * aqui - ponto unico, sem repetir a atribuicao no InicializarForm.
399:     *
400:     * AutoSize = .F. EXPLICITO: em Label criado por AddObject o AutoSize eh
401:     * no-op, e com WordWrap = .T. ele ainda DESCARTA a Height e colapsa o
402:     * texto para uma linha. A geometria do SCX ja eh o auto-size que o Form
403:     * Designer calculou, entao fixa-la eh reproducao fiel.
404:     *
405:     * ForeColor branco eh correto AQUI porque o container eh OPACO e escuro
406:     * (BackStyle = 1 + BackColor RGB(100,100,100)) - a excecao legitima da
407:     * regra que proibe label de dados em branco.
408:     *==========================================================================
409:     PROTECTED PROCEDURE ConfigurarCabecalho()
410:         LOCAL loc_oCnt
411: 
412:         THIS.AddObject("cnt_4c_Sombra", "Container")
413:         loc_oCnt = THIS.cnt_4c_Sombra
414: 
415:         WITH loc_oCnt
416:             .Top           = 0
417:             .Left          = 0
418:             .Width         = THIS.Width
419:             .Height        = 80
420:             .BorderWidth   = 0
421:             .BackStyle     = 1
422:             .BackColor     = RGB(100, 100, 100)
423:             .SpecialEffect = 0
424:             .Visible       = .T.
425:         ENDWITH
426: 
427:         loc_oCnt.AddObject("lbl_4c_LblSombra", "Label")
428:         WITH loc_oCnt.lbl_4c_LblSombra
429:             .FontBold      = .T.
430:             .FontName      = "Tahoma"
431:             .FontSize      = 18
432:             .FontUnderline = .F.
433:             .WordWrap      = .T.
434:             .Alignment     = 0
435:             .BackStyle     = 0
436:             .AutoSize      = .F.
437:             .Caption       = THIS.Caption
438:             .Top           = 18
439:             .Left          = 10
440:             .Width         = 769
441:             .Height        = 40
442:             .ForeColor     = RGB(0, 0, 0)
443:             .Visible       = .T.
444:         ENDWITH
445: 
446:         loc_oCnt.AddObject("lbl_4c_LblTitulo", "Label")
447:         WITH loc_oCnt.lbl_4c_LblTitulo
448:             .FontBold    = .T.
449:             .FontName    = "Tahoma"

*-- Linhas 480 a 580:
480:     * O dump declara so Top/Left/Height/Width/BackStyle (mais o ZOrderSet,
481:     * que eh bookkeeping do Form Designer e NAO existe em runtime - regra
482:     * #33; atribui-lo estouraria "Property ZORDERSET is not found" dentro do
483:     * TRY do InicializarForm e a tela simplesmente nao abriria). Nada de
484:     * ForeColor: a classe Shape nao tem essa propriedade (as cores dela sao
485:     * BorderColor/FillColor) - pelo mesmo motivo nada eh inventado aqui, so
486:     * transcrito.
487:     *
488:     * Criadas ANTES dos campos que emolduram: Shape1 (128..185 x 616..957)
489:     * cobre a area de Label3 (Top=136) e dos dois TextBox (Top=154), e
490:     * ShpFigura cobre a area da Image. Caixa transparente criada DEPOIS
491:     * desenharia por cima e bloquearia o clique no campo.
492:     *==========================================================================
493:     PROTECTED PROCEDURE ConfigurarMolduras()
494: 
495:         *-- Shape1: moldura do bloco de localizacao
496:         THIS.AddObject("shp_4c_Shape1", "Shape")
497:         WITH THIS.shp_4c_Shape1
498:             .Top       = 128
499:             .Left      = 616
500:             .Width     = 341
501:             .Height    = 57
502:             .BackStyle = 0
503:             .Visible   = .T.
504:         ENDWITH
505: 
506:         *-- ShpFigura: moldura da foto do produto
507:         THIS.AddObject("shp_4c_ShpFigura", "Shape")
508:         WITH THIS.shp_4c_ShpFigura
509:             .Top       = 204
510:             .Left      = 615
511:             .Width     = 341
512:             .Height    = 158
513:             .BackStyle = 0
514:             .Visible   = .T.
515:         ENDWITH
516: 
517:         RETURN .T.
518:     ENDPROC
519: 
520:     *==========================================================================
521:     * ConfigurarImagemProduto - a foto do produto (ImgJpg do SCX legado)
522:     *
523:     * Geometria transcrita do dump:
524:     *   ImgJpg Stretch=2 Top=205 Left=616 Width=339 Height=156 Visible=.F.
525:     *
526:     * Nasce OCULTA porque o legado a declara assim: ela so aparece quando a
527:     * linha corrente da grade tem foto, e eh CarregarFotoProduto() quem a
528:     * exibe/esconde (o legado faz isso dentro do AfterRowColChange). Por
529:     * isso o nome img_4c_ImgJpg esta na lista de EXCECAO do
530:     * TornarControlesVisiveis - sem ela a foto apareceria em branco na
531:     * abertura, antes de qualquer produto ter sido selecionado.
532:     *
533:     * Stretch = 2 (isometrico) eh do dump e NAO eh detalhe: com Stretch = 0
534:     * (o default) o VFP9 DESCARTA a Width/Height declaradas e assume o
535:     * tamanho natural do arquivo no momento em que .Picture eh atribuido -
536:     * a moldura ShpFigura deixaria de casar com a foto, em silencio. Por
537:     * seguranca a ordem aqui tambem poe Stretch e Picture ANTES da
538:     * geometria, que eh a ordem do proprio dump.
539:     *==========================================================================
540:     PROTECTED PROCEDURE ConfigurarImagemProduto()
541: 
542:         THIS.AddObject("img_4c_ImgJpg", "Image")
543:         WITH THIS.img_4c_ImgJpg
544:             .Stretch = 2
545:             .Picture = ""
546:             .Top     = 205
547:             .Left    = 616
548:             .Width   = 339
549:             .Height  = 156
550:             .Visible = .F.
551:         ENDWITH
552: 
553:         RETURN .T.
554:     ENDPROC
555: 
556:     *==========================================================================
557:     * ConfigurarGrid - grade de itens do movimento (grdItens do SCX legado)
558:     *
559:     * Geometria e colunas transcritas do dump (ColumnOrder fisico: Column3=1,
560:     * Column1=2, Column2=3, Column4=4):
561:     *   grdItens Top=105 Left=10 Width=549 Height=259 RowHeight=16
562:     *            GridLineColor=238,238,238 DeleteMark=.F. RecordMark=.F.
563:     *   Column1 (Cpros)  Width=122 Header "Produto"
564:     *   Column2 (Dpros)  Width=290 Header "Descricao"      ReadOnly
565:     *   Column3 (Marcas) Width=17  CheckBox de selecao
566:     *   Column4 (Locals) Width=95  Header "Localizacao"    ReadOnly
567:     *
568:     * Column1 nao declara ReadOnly no dump (so o Text1 tem .ReadOnly = .F.),
569:     * mas o Text1.When legado retorna .F. incondicional - a celula nunca
570:     * recebe foco, ou seja, a observavel para o usuario eh IDENTICA a
571:     * ReadOnly = .T.. Reproduzido assim (Column.ReadOnly = .T.) porque o
572:     * Grid migrado nao tem equivalente direto de When por celula.
573:     *
574:     * ORDEM OBRIGATORIA (Problema 48 / regra #35c): ColumnCount ->
575:     * RecordSource -> ControlSource de TODAS as colunas -> SO DEPOIS Width/
576:     * Header1.Caption/demais formatacao. Atribuir ControlSource reseta
577:     * Width e Header1.Caption para o default; fazer a formatacao antes
578:     * seria descartada. Por isso o bind e a formatacao vivem em MontaGrade()
579:     * / FormatarGridItens(), que sao reusados por TODO caminho que repinta a
580:     * grade - aqui so se cria o Grid e o CheckBox da coluna de marcacao.

*-- Linhas 588 a 771:
588:     * nao a Marcas. Adicionar nessa coluna um CheckBox - cujo .Value nasce
589:     * NUMERICO (medido: VARTYPE = "N", valor 0) - estoura no proprio
590:     * AddObject com "Error with CHK_4C_CHECK1 - Value : Data type
591:     * mismatch", dentro do TRY do InicializarForm: devolve .F.,
592:     * CREATEOBJECT devolve o logico .F. e A TELA NAO ABRE - o usuario
593:     * aciona a opcao e nada acontece, sem erro nenhum na tela.
594:     *
595:     * Tres caminhos foram medidos: RecordSourceType = 0 ANTES do AddObject
596:     * NAO resolve (o auto-bind ja aconteceu); ligar a Column3 a coluna
597:     * NUMERICA antes do AddObject resolve; e reBINDAR depois, quantas vezes
598:     * for, continua seguro (CurrentControl e Width sobrevivem porque
599:     * FormatarGridItens os reaplica).
600:     *
601:     * Por isso a sequencia inteira - bind, criacao do CheckBox e formatacao,
602:     * nessa ordem - mora dentro do MontaGrade, e aqui so se cria o Grid e se
603:     * chama o funil. Assim a ordem certa vale tambem nas repinturas, nao so
604:     * na montagem inicial.
605:     *==========================================================================
606:     PROTECTED PROCEDURE ConfigurarGrid()
607:         LOCAL loc_oGrid
608: 
609:         THIS.AddObject("grd_4c_Dados", "Grid")
610:         loc_oGrid = THIS.grd_4c_Dados
611: 
612:         WITH loc_oGrid
613:             .Top           = 105
614:             .Left          = 10
615:             .Width         = 549
616:             .Height        = 259
617:             .FontName      = "Tahoma"
618:             .FontSize      = 8
619:             .DeleteMark    = .F.
620:             .RecordMark    = .F.
621:             .RowHeight     = 16
622:             .ScrollBars    = 2
623:             .GridLineColor = RGB(238, 238, 238)
624:             .ColumnCount   = 4
625:         ENDWITH
626: 
627:         *-- Bind + criacao do CheckBox + formatacao, na ordem provada acima.
628:         *-- MontaGrade faz os tres passos e eh reusado a cada repintura.
629:         THIS.MontaGrade()
630: 
631:         loc_oGrid.Visible = .T.
632: 
633:         BINDEVENT(loc_oGrid, "AfterRowColChange", THIS, "GradeAfterRowColChange")
634: 
635:         RETURN .T.
636:     ENDPROC
637: 
638:     *==========================================================================
639:     * GarantirCheckBoxMarcacao - cria (ou RECRIA) o CheckBox da coluna de
640:     * marcacao e religa os handlers dele
641:     *
642:     * Equivale ao grdItens.Column3.Check1 do SCX legado, que la eh um objeto
643:     * DESENHADO na coluna. Aqui ele nasce por AddObject, e por isso tem um
644:     * ciclo de vida que o legado nao tem: FECHAR o alias ligado ao Grid
645:     * DESTROI o objeto adicionado na Column. Medido no VFP9 (2026-11-08):
646:     * depois de SigOpLcZBO.CarregarItens() - que faz USE IN no cursor da
647:     * grade para refaze-lo - o Column3.CurrentControl voltou para "Text1" e
648:     * o CheckBox tinha desaparecido, enquanto Width e Header1.Caption
649:     * sobreviveram. Sem erro, sem log: o usuario ve o 0/1 CRU numa caixa de
650:     * texto e nao tem como marcar linha nenhuma.
651:     *
652:     * Por isso a criacao eh IDEMPOTENTE e mora num metodo proprio, chamado
653:     * por MontaGrade a cada repintura: PEMSTATUS diz se o objeto ainda
654:     * existe, e so quando NAO existe eh que se adiciona (AddObject com nome
655:     * repetido estouraria "Object already defined"). Os BINDEVENT vao JUNTO,
656:     * no mesmo lugar: objeto recriado eh outro objeto, e as ligacoes do
657:     * anterior morreram com ele - sem religar, os quatro handlers de
658:     * alternancia (regra #185) ficariam mudos.
659:     *
660:     * .Value = 0 NUMERICO eh obrigatorio e tem de bater com o tipo da coluna
661:     * (Marcas N(1,0), do "0 as Marcas" do Select Distinct legado).
662:     *==========================================================================
663:     PROTECTED PROCEDURE GarantirCheckBoxMarcacao()
664:         LOCAL loc_oCol
665: 
666:         IF !PEMSTATUS(THIS, "grd_4c_Dados", 5)
667:             RETURN .F.
668:         ENDIF
669: 
670:         loc_oCol = THIS.grd_4c_Dados.Column3
671: 
672:         *-- Ja existe: nada a fazer (e nao se pode AddObject de novo)
673:         IF PEMSTATUS(loc_oCol, "chk_4c_Check1", 5)
674:             RETURN .T.
675:         ENDIF
676: 
677:         loc_oCol.AddObject("chk_4c_Check1", "CheckBox")
678:         WITH loc_oCol.chk_4c_Check1
679:             .Top       = 22
680:             .Left      = 22
681:             .Height    = 17
682:             .Width     = 60
683:             .FontName  = "Tahoma"
684:             .FontSize  = 8
685:             .Alignment = 0
686:             .Caption   = ""
687:             .Value     = 0
688:             .Visible   = .T.
689:         ENDWITH
690: 
691:         *-- Handlers de alternancia: Click/MouseDown suprimem o toggle
692:         *-- nativo, MouseUp delega ao KeyPress e o KeyPress eh quem alterna
693:         *-- Marcas - exatamente o conjunto que o Check1 legado declara
694:         BINDEVENT(loc_oCol.chk_4c_Check1, "Click",     THIS, "ChkMarcasClick")
695:         BINDEVENT(loc_oCol.chk_4c_Check1, "MouseDown", THIS, "ChkMarcasMouseDown")
696:         BINDEVENT(loc_oCol.chk_4c_Check1, "MouseUp",   THIS, "ChkMarcasMouseUp")
697:         BINDEVENT(loc_oCol.chk_4c_Check1, "KeyPress",  THIS, "ChkMarcasKeyPress")
698: 
699:         RETURN .T.
700:     ENDPROC
701: 
702:     *==========================================================================
703:     * MontaGrade - equivalente a PROCEDURE montagrade do SCX legado
704:     *
705:     *   Select crItensLoc / Index on Cpros Tag Cpros / Go top
706:     *   With ThisForm.grdItens
707:     *       .RecordSource = [crItensLoc]
708:     *       .column1.ControlSource = [crItensLoc.Cpros]   ... (as quatro)
709:     *       .Refresh()
710:     *   EndWith
711:     *
712:     * FUNIL UNICO do bind/repintura da grade: chamado na montagem
713:     * (ConfigurarGrid), pelo botao Limpar Selecao (o legado tambem chama
714:     * ThisForm.Montagrade() ali) e pelo CarregarLista(). Grade ligada a
715:     * cursor NAO se repinta sozinha depois que o cursor muda (regra #21) -
716:     * sem um ponto unico, cada caminho esquece uma metade.
717:     *
718:     * O Index on Cpros NAO eh repetido aqui: quem cria cursor_4c_Itens eh
719:     * SigOpLcZBO.CarregarItens(), que ja faz o INDEX ON Cpros TAG Cpros
720:     * imediatamente apos o SELECT - repetir o INDEX a cada repintura so
721:     * recriaria a mesma tag.
722:     *
723:     * O Column1.SetFocus que fecha o montagrade legado fica nos HANDLERS de
724:     * botao e nao aqui: MontaGrade tambem roda durante o InicializarForm,
725:     * com a tela ainda nao exibida, e dar foco a controle de form invisivel
726:     * derrubaria o Init. Os dois call sites do usuario (Localizar e Limpar
727:     * Selecao) ja chamam o SetFocus, entao o observavel eh identico.
728:     *
729:     * PUBLIC: eh funil, precisa ser acionavel pelos handlers e pelo harness.
730:     *==========================================================================
731:     PROCEDURE MontaGrade()
732:         LOCAL loc_oGrid, loc_cCursor
733: 
734:         IF !PEMSTATUS(THIS, "grd_4c_Dados", 5)
735:             RETURN .F.
736:         ENDIF
737: 
738:         loc_oGrid   = THIS.grd_4c_Dados
739:         loc_cCursor = THIS.this_oBusinessObject.this_cCursorItens
740: 
741:         IF !USED(loc_cCursor)
742:             RETURN .F.
743:         ENDIF
744: 
745:         loc_oGrid.RecordSource = loc_cCursor
746: 
747:         loc_oGrid.Column1.ControlSource = loc_cCursor + ".Cpros"
748:         loc_oGrid.Column2.ControlSource = loc_cCursor + ".Dpros"
749:         loc_oGrid.Column3.ControlSource = loc_cCursor + ".Marcas"
750:         loc_oGrid.Column4.ControlSource = loc_cCursor + ".Locals"
751: 
752:         *-- SO AGORA o CheckBox pode entrar/voltar: a Column3 acabou de ser
753:         *-- ligada a coluna NUMERICA Marcas, e eh esse bind que impede o
754:         *-- "Data type mismatch" no AddObject (ver cabecalho de
755:         *-- ConfigurarGrid). Idempotente: cria apenas se o objeto nao existe.
756:         THIS.GarantirCheckBoxMarcacao()
757: 
758:         *-- RecordSource/ControlSource acabaram de resetar Width,
759:         *-- Header1.Caption e CurrentControl - reaplicar SEMPRE depois
760:         THIS.FormatarGridItens(loc_oGrid)
761: 
762:         *-- Go top + Refresh: o legado fecha o montagrade assim, e eh o que
763:         *-- faz a grade EXIBIR as linhas que o cursor passou a ter
764:         SELECT (loc_cCursor)
765:         GO TOP
766:         loc_oGrid.Refresh()
767: 
768:         RETURN .T.
769:     ENDPROC
770: 
771:     *==========================================================================

*-- Linhas 782 a 853:
782:     * PEMSTATUS devolve .T. para metodo PROTECTED (so testa existencia, nao
783:     * escopo) - o teste entraria no branch e a chamada falharia (regra #3).
784:     *==========================================================================
785:     PROCEDURE CarregarLista()
786:         LOCAL loc_lSucesso
787: 
788:         loc_lSucesso = THIS.this_oBusinessObject.CarregarItens()
789: 
790:         *-- Repinta mesmo quando a carga falhou: o cursor placeholder criado
791:         *-- no InicializarForm continua sendo um RecordSource valido, e a
792:         *-- grade tem de voltar a um estado coerente (vazia) em vez de
793:         *-- seguir exibindo as linhas da carga anterior
794:         THIS.MontaGrade()
795:         THIS.GradeAfterRowColChange()
796: 
797:         RETURN loc_lSucesso
798:     ENDPROC
799: 
800:     *==========================================================================
801:     * FormatarGridItens - propriedades das quatro colunas de grd_4c_Dados
802:     *
803:     * Chamado por MontaGrade SEMPRE depois do bind, porque atribuir
804:     * RecordSource/ControlSource reseta Width e Header1.Caption para o
805:     * default 90/"Header1" (Problema 48) e derruba o CurrentControl da
806:     * coluna de marcacao (regra #18) - a grade apareceria com colunas
807:     * quadradas, cabecalhos "Header1" e o valor cru 0/1 no lugar do
808:     * CheckBox.
809:     *
810:     * Column.ReadOnly vem DEPOIS do Grid.ReadOnly por regra (#18): o do
811:     * grid propaga para as colunas e sobrescreveria estes valores.
812:     *==========================================================================
813:     PROTECTED PROCEDURE FormatarGridItens(par_oGrid)
814:         LOCAL loc_oGrid
815: 
816:         IF VARTYPE(par_oGrid) = "O"
817:             loc_oGrid = par_oGrid
818:         ELSE
819:             loc_oGrid = THIS.grd_4c_Dados
820:         ENDIF
821: 
822:         WITH loc_oGrid.Column1
823:             .ColumnOrder       = 2
824:             .Width             = 122
825:             .Movable           = .F.
826:             .Resizable         = .F.
827:             .ReadOnly          = .T.
828:             .FontName          = "Tahoma"
829:             .FontSize          = 8
830:             .Header1.FontName  = "Tahoma"
831:             .Header1.FontSize  = 8
832:             .Header1.Alignment = 2
833:             .Header1.Caption   = "Produto"
834:             .Text1.FontName    = "Tahoma"
835:             .Text1.FontSize    = 8
836:             .Text1.Alignment   = 3
837:             .Text1.BorderStyle = 0
838:             .Text1.Margin      = 0
839:             .Text1.ForeColor   = RGB(0, 0, 0)
840:             .Text1.BackColor   = RGB(255, 255, 255)
841:         ENDWITH
842: 
843:         WITH loc_oGrid.Column2
844:             .ColumnOrder       = 3
845:             .Width             = 290
846:             .Movable           = .F.
847:             .Resizable         = .F.
848:             .ReadOnly          = .T.
849:             .FontName          = "Tahoma"
850:             .FontSize          = 8
851:             .Header1.FontName  = "Tahoma"
852:             .Header1.FontSize  = 8
853:             .Header1.Alignment = 2

*-- Linhas 921 a 1035:
921:     * dentro do KeyPress via SigOpLcZBO.PodeEditar() - fora desse modo a
922:     * tecla eh descartada sem alternar nada.
923:     *
924:     * PUBLIC: exigido pelo BINDEVENT (regra #3).
925:     *==========================================================================
926:     PROCEDURE ChkMarcasClick()
927:         NODEFAULT
928:     ENDPROC
929: 
930:     PROCEDURE ChkMarcasMouseDown(par_nButton, par_nShift, par_nXCoord, par_nYCoord)
931:         NODEFAULT
932:     ENDPROC
933: 
934:     PROCEDURE ChkMarcasMouseUp(par_nButton, par_nShift, par_nXCoord, par_nYCoord)
935:         THIS.ChkMarcasKeyPress(13, 0)
936:         NODEFAULT
937:     ENDPROC
938: 
939:     PROCEDURE ChkMarcasKeyPress(par_nKeyCode, par_nShiftAltCtrl)
940:         LOCAL loc_cCursor
941: 
942:         IF INLIST(par_nKeyCode, 13, 32) AND THIS.this_oBusinessObject.PodeEditar()
943:             loc_cCursor = THIS.this_oBusinessObject.this_cCursorItens
944: 
945:             IF USED(loc_cCursor) AND !EOF(loc_cCursor) AND RECCOUNT(loc_cCursor) > 0
946:                 REPLACE Marcas WITH IIF(EVALUATE(loc_cCursor + ".Marcas") == 0, 1, 0) ;
947:                     IN (loc_cCursor)
948: 
949:                 THIS.GradeAfterRowColChange()
950:                 THIS.grd_4c_Dados.Refresh()
951:             ENDIF
952: 
953:             NODEFAULT
954:         ENDIF
955:     ENDPROC
956: 
957:     *==========================================================================
958:     * GradeAfterRowColChange - atualiza o estado do botao Localizar conforme
959:     * a linha corrente da grade.
960:     *
961:     * Equivalente ao SigOpLcZ.grdItens.AfterRowColChange legado:
962:     *   If Empty(crItensLoc.Locals) And Not Empty(crItensLoc.Marcas)
963:     *       ThisForm.cmdAcoes.btnLocalizar.Enabled = .T.
964:     *   Else
965:     *       ThisForm.cmdAcoes.btnLocalizar.Enabled = .F.
966:     *   EndIf
967:     * A fonte unica dessa regra eh SigOpLcZBO.PodeLocalizar() (depende de
968:     * CarregarDoCursor ja ter lido a linha corrente).
969:     *
970:     * A OUTRA metade do handler legado eh a foto do produto, que usa a MESMA
971:     * linha corrente: o legado consulta SigCdPro.FigJpgs e exibe/esconde o
972:     * ImgJpg conforme achou imagem ou nao. Portada em CarregarFotoProduto(),
973:     * chamada aqui - no MESMO ponto do legado, e ANTES da regra do botao,
974:     * tambem como o legado.
975:     *
976:     * par_nColIndex nao eh usado, e isso eh fiel: o legado declara o
977:     * parametro (LPARAMETERS nColIndex) e nunca o le - a chamada do
978:     * Check1.KeyPress eh This.parent.parent.AfterRowColChange, sem
979:     * argumento. O parametro continua declarado porque o BINDEVENT liga este
980:     * metodo ao AfterRowColChange nativo, que SEMPRE passa a coluna (regra
981:     * #3: handler sem o parametro estoura a cada troca de celula).
982:     *
983:     * PUBLIC: ligado via BINDEVENT ao AfterRowColChange nativo do grid
984:     * (regra #3) e TAMBEM chamado DIRETO pelos botoes de selecao/limpeza/
985:     * localizacao, como o legado faz com ThisForm.grdItens.AfterRowColChange().
986:     *==========================================================================
987:     PROCEDURE GradeAfterRowColChange(par_nColIndex)
988:         THIS.this_oBusinessObject.CarregarDoCursor()
989: 
990:         *-- Foto do produto da linha corrente (ImgJpg do legado)
991:         THIS.CarregarFotoProduto()
992: 
993:         *-- PEMSTATUS porque este metodo esta ligado por BINDEVENT ao
994:         *-- AfterRowColChange NATIVO da grade, que pode disparar durante o
995:         *-- InicializarForm - a grade eh criada ANTES do cmdAcoes, e sem o
996:         *-- guard a tela nao abriria com "Property OBJ_4C_CMDACOES is not
997:         *-- found" engolido pelo CATCH do Init.
998:         IF PEMSTATUS(THIS, "obj_4c_CmdAcoes", 5)
999:             THIS.obj_4c_CmdAcoes.Buttons(1).Enabled = ;
1000:                 THIS.this_oBusinessObject.PodeEditar() AND ;
1001:                 THIS.this_oBusinessObject.PodeLocalizar()
1002:         ENDIF
1003: 
1004:         RETURN .T.
1005:     ENDPROC
1006: 
1007:     *==========================================================================
1008:     * CarregarFotoProduto - exibe a foto do produto da linha corrente
1009:     *
1010:     * Transcreve a primeira metade do grdItens.AfterRowColChange legado:
1011:     *   lcArquivo2 = Sys(2023) + [\] + goSistema.Sys2015Tmp + Sys(2015) + [.jpg]
1012:     *   = ThisForm.poDataMgr.CursorQuery('SigCdPro','crTPro','Cpros',
1013:     *                                    crItensLoc.Cpros,'FigJpgs')
1014:     *   If Not IsNull(crTPro.FigJpgs) And Not IsEmpty(crTPro.FigJpgs)
1015:     *       ImgJpg.Visible = .F. / ImgJpg.Picture = ''
1016:     *       Clear Resources
1017:     *       lcFoto = Strconv(Strtran(Strtran(Strtran(crTPro.FigJpgs,
1018:     *                 [data:image/png;base64,],[]),[data:image/jpeg;base64,],
1019:     *                 []),[data:image/jpg;base64,],[]), 14)
1020:     *       StrToFile(lcFoto, lcArquivo2)
1021:     *       ImgJpg.Picture = (lcArquivo2) / ImgJpg.Visible = .T.
1022:     *   Else
1023:     *       ImgJpg.Visible = .F. / ImgJpg.Picture = ''
1024:     *   EndIf
1025:     *
1026:     * A consulta eh do BO (SigOpLcZBO.ObterImagemProduto, que devolve o
1027:     * base64 ou .NULL.) e o tratamento do conteudo eh daqui - divisao
1028:     * decidida na Fase 2 e documentada no cabecalho daquele metodo: so o
1029:     * form conhece o controle Image que vai exibir a foto.
1030:     *
1031:     * UM UNICO STRCONV(..., 14). O valor que vem do banco eh base64 e a
1032:     * conversao o transforma em JPEG binario; converter DE NOVO trataria
1033:     * binario como base64 e produz lixo, que o VFP9 recusa com "Picture too
1034:     * big, corrupt, or in wrong format" - e o legado tambem decodifica uma
1035:     * vez so.

*-- Linhas 1041 a 1087:
1041:     * CATCH SEM MsgErro, de proposito e por DESVIO deliberado da regra #9:
1042:     * este metodo roda a cada troca de linha da grade, e um modal por linha
1043:     * com foto corrompida deixaria a tela inutilizavel. O erro NAO eh
1044:     * engolido - fica em this_cMensagemErro com Linha/Procedure, que eh o
1045:     * que a regra #9 existe para garantir.
1046:     *==========================================================================
1047:     PROTECTED PROCEDURE CarregarFotoProduto()
1048:         LOCAL loc_cCpros, loc_xImagem, loc_cBase64, loc_cBinario
1049:         LOCAL loc_cArquivo, loc_oErro
1050: 
1051:         IF !PEMSTATUS(THIS, "img_4c_ImgJpg", 5)
1052:             RETURN .F.
1053:         ENDIF
1054: 
1055:         TRY
1056:             loc_cCpros  = ALLTRIM(NVL(THIS.this_oBusinessObject.this_cCprosAtual, ""))
1057:             loc_xImagem = .NULL.
1058: 
1059:             IF !EMPTY(loc_cCpros)
1060:                 loc_xImagem = THIS.this_oBusinessObject.ObterImagemProduto(loc_cCpros)
1061:             ENDIF
1062: 
1063:             *-- ObterImagemProduto devolve .NULL. quando nao ha foto (ou nao
1064:             *-- ha conexao, que eh o caso do harness). O teste de tipo cobre
1065:             *-- os dois sem estourar: EMPTY(.NULL.) devolve .F. no VFP9, ou
1066:             *-- seja NULL passaria por "nao vazio" e o STRTRAN quebraria.
1067:             IF VARTYPE(loc_xImagem) = "C" AND !EMPTY(loc_xImagem)
1068: 
1069:                 *-- Libera a Picture anterior ANTES de reescrever o arquivo
1070:                 THIS.img_4c_ImgJpg.Visible = .F.
1071:                 THIS.img_4c_ImgJpg.Picture = ""
1072: 
1073:                 loc_cBase64 = STRTRAN(loc_xImagem,  "data:image/png;base64,",  "")
1074:                 loc_cBase64 = STRTRAN(loc_cBase64, "data:image/jpeg;base64,", "")
1075:                 loc_cBase64 = STRTRAN(loc_cBase64, "data:image/jpg;base64,",  "")
1076: 
1077:                 *-- UMA conversao base64 -> binario JPEG
1078:                 loc_cBinario = STRCONV(loc_cBase64, 14)
1079: 
1080:                 loc_cArquivo = ADDBS(SYS(2023)) + THIS.ObterPrefixoTemp() + ;
1081:                     SYS(2015) + ".jpg"
1082: 
1083:                 CLEAR RESOURCES
1084:                 STRTOFILE(loc_cBinario, loc_cArquivo)
1085: 
1086:                 IF FILE(loc_cArquivo)
1087:                     THIS.img_4c_ImgJpg.Picture = loc_cArquivo

*-- Linhas 1101 a 1188:
1101:         CATCH TO loc_oErro
1102:             THIS.this_cMensagemErro = "Erro ao carregar a foto do produto: " + ;
1103:                 loc_oErro.Message + " | Linha: " + TRANSFORM(loc_oErro.LineNo) + ;
1104:                 " | Procedure: " + loc_oErro.Procedure
1105: 
1106:             THIS.img_4c_ImgJpg.Visible = .F.
1107:             THIS.img_4c_ImgJpg.Picture = ""
1108:         ENDTRY
1109: 
1110:         RETURN .T.
1111:     ENDPROC
1112: 
1113:     *==========================================================================
1114:     * ObterPrefixoTemp - prefixo dos arquivos temporarios de imagem
1115:     *
1116:     * Legado: Sys(2023) + [\] + goSistema.Sys2015Tmp + Sys(2015) + [.jpg]
1117:     *
1118:     * go_4c_Sistema eh um objeto Empty e cada membro dele entra por
1119:     * ADDPROPERTY no config.prg; ler property que NAO foi adicionada estoura
1120:     * "Property SYS2015TMP is not found" em runtime. O Sys2015Tmp existe hoje
1121:     * no config.prg ("4c_tmp_"), e o PEMSTATUS aqui so cobre um ambiente com
1122:     * config antigo ainda em memoria - sem ele, uma tela que abre normalmente
1123:     * quebraria na primeira linha de grade com foto.
1124:     *==========================================================================
1125:     PROTECTED PROCEDURE ObterPrefixoTemp()
1126:         LOCAL loc_cPrefixo
1127: 
1128:         loc_cPrefixo = "4c_tmp_"
1129: 
1130:         IF TYPE("go_4c_Sistema") = "O"
1131:             IF PEMSTATUS(go_4c_Sistema, "Sys2015Tmp", 5)
1132:                 loc_cPrefixo = ALLTRIM(NVL(go_4c_Sistema.Sys2015Tmp, "4c_tmp_"))
1133:             ENDIF
1134:         ENDIF
1135: 
1136:         RETURN loc_cPrefixo
1137:     ENDPROC
1138: 
1139:     *==========================================================================
1140:     * ConfigurarBotoesPrincipais - cntBotoes do SCX legado: Confirmar/Sair
1141:     *
1142:     * Geometria e icones transcritos do dump. Buttons(1) = Command1 =
1143:     * btnSair (Left=81, mais a direita dentro do grupo), Buttons(2) =
1144:     * Command2 = btnConfirmar (Left=6, mais a esquerda) - ordem fisica
1145:     * invertida em relacao a ordem de declaracao, conforme o dump.
1146:     * Buttons DENTRO de CommandGroup mantem Themes = .F. (canonico).
1147:     *==========================================================================
1148:     PROTECTED PROCEDURE ConfigurarBotoesPrincipais()
1149:         LOCAL loc_oCmg
1150: 
1151:         THIS.AddObject("obj_4c_CntBotoes", "CommandGroup")
1152:         loc_oCmg = THIS.obj_4c_CntBotoes
1153: 
1154:         WITH loc_oCmg
1155:             .Top           = -2
1156:             .Left          = 811
1157:             .Width         = 161
1158:             .Height        = 85
1159:             .ButtonCount   = 2
1160:             .AutoSize      = .F.
1161:             .BackStyle     = 0
1162:             .BorderStyle   = 0
1163:             .SpecialEffect = 1
1164:             .BorderColor   = RGB(136, 189, 188)
1165:             .Themes        = .F.
1166:             .Value         = 0
1167:         ENDWITH
1168: 
1169:         WITH loc_oCmg.Buttons(1)
1170:             .Top           = 5
1171:             .Left          = 81
1172:             .Width         = 75
1173:             .Height        = 75
1174:             .FontBold      = .T.
1175:             .FontItalic    = .T.
1176:             .FontName      = "Comic Sans MS"
1177:             .FontSize      = 8
1178:             .WordWrap      = .T.
1179:             .Picture       = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
1180:             .Cancel        = .T.
1181:             .Caption       = "\<Cancelar"
1182:             .MousePointer  = 15
1183:             .ToolTipText   = "[Esc] Encerrar"
1184:             .SpecialEffect = 0
1185:             .ForeColor     = RGB(90, 90, 90)
1186:             .BackColor     = RGB(255, 255, 255)
1187:             .Themes        = .F.
1188:         ENDWITH

*-- Linhas 1208 a 1283:
1208: 
1209:         loc_oCmg.Visible = .T.
1210: 
1211:         BINDEVENT(loc_oCmg.Buttons(1), "Click", THIS, "BtnSairClick")
1212:         BINDEVENT(loc_oCmg.Buttons(2), "Click", THIS, "BtnConfirmarClick")
1213: 
1214:         RETURN .T.
1215:     ENDPROC
1216: 
1217:     *==========================================================================
1218:     * BtnSairClick / BtnConfirmarClick
1219:     *
1220:     * Equivalente a SigOpLcZ.cntBotoes.btnSair.Click (ThisForm.Release) e
1221:     * SigOpLcZ.cntBotoes.btnConfirmar.Click (Scan em csLocals, Update
1222:     * crTpmMvItn, Release - sem validacao nenhuma antes, o legado sempre
1223:     * fecha a tela). SigOpLcZBO.Confirmar() ja reproduz o Scan/Update; sem
1224:     * linhas em cursor_4c_Selecionados eh no-op valido, igual ao legado.
1225:     *==========================================================================
1226:     PROCEDURE BtnSairClick()
1227:         THIS.Release()
1228:     ENDPROC
1229: 
1230:     PROCEDURE BtnConfirmarClick()
1231:         THIS.this_oBusinessObject.Confirmar()
1232:         THIS.Release()
1233:     ENDPROC
1234: 
1235:     *==========================================================================
1236:     * ConfigurarBotoesAcoes - cmdAcoes do SCX legado: Localizar/Limpar Selecao
1237:     *
1238:     * Buttons(1) = Command1 = btnLocalizar (comeca desabilitado - so liga
1239:     * quando GradeAfterRowColChange encontrar uma linha marcada e sem
1240:     * localizacao). Buttons(2) = Command2 = btnLimpar (habilitado conforme
1241:     * o modo, ajustado por HabilitarCampos).
1242:     *==========================================================================
1243:     PROTECTED PROCEDURE ConfigurarBotoesAcoes()
1244:         LOCAL loc_oCmg
1245: 
1246:         THIS.AddObject("obj_4c_CmdAcoes", "CommandGroup")
1247:         loc_oCmg = THIS.obj_4c_CmdAcoes
1248: 
1249:         WITH loc_oCmg
1250:             .Top           = -2
1251:             .Left          = 662
1252:             .Width         = 160
1253:             .Height        = 85
1254:             .ButtonCount   = 2
1255:             .AutoSize      = .F.
1256:             .BackStyle     = 0
1257:             .BorderStyle   = 0
1258:             .SpecialEffect = 1
1259:             .BorderColor   = RGB(136, 189, 188)
1260:             .Themes        = .F.
1261:             .Value         = 0
1262:         ENDWITH
1263: 
1264:         WITH loc_oCmg.Buttons(1)
1265:             .Top           = 5
1266:             .Left          = 80
1267:             .Width         = 75
1268:             .Height        = 75
1269:             .FontBold      = .T.
1270:             .FontItalic    = .T.
1271:             .FontName      = "Comic Sans MS"
1272:             .FontSize      = 8
1273:             .WordWrap      = .T.
1274:             .Picture       = gc_4c_CaminhoIcones + "cadastro_inserir_60.jpg"
1275:             .Cancel        = .T.
1276:             .Caption       = "\<Localizar"
1277:             .MousePointer  = 15
1278:             .ToolTipText   = "[Esc] Encerrar"
1279:             .SpecialEffect = 0
1280:             .ForeColor     = RGB(90, 90, 90)
1281:             .BackColor     = RGB(255, 255, 255)
1282:             .Themes        = .F.
1283:             .Enabled       = .F.

*-- Linhas 1304 a 1958:
1304: 
1305:         loc_oCmg.Visible = .T.
1306: 
1307:         BINDEVENT(loc_oCmg.Buttons(1), "Click", THIS, "BtnLocalizarClick")
1308:         BINDEVENT(loc_oCmg.Buttons(2), "Click", THIS, "BtnLimparClick")
1309: 
1310:         RETURN .T.
1311:     ENDPROC
1312: 
1313:     *==========================================================================
1314:     * BtnLocalizarClick
1315:     *
1316:     * Equivalente a SigOpLcZ.cmdAcoes.btnLocalizar.Click: valida a base
1317:     * (dentro de SigOpLcZBO.Localizar - fonte unica, regra #178), move as
1318:     * linhas marcadas para cursor_4c_Selecionados e refoca a grade.
1319:     *==========================================================================
1320:     PROCEDURE BtnLocalizarClick()
1321:         IF !THIS.this_oBusinessObject.PodeEditar()
1322:             RETURN .F.
1323:         ENDIF
1324: 
1325:         *-- O legado le a base direto do controle (lcLocaliza =
1326:         *-- ThisForm.getBase.Value) no inicio do Click. Aqui a leitura passa
1327:         *-- pelo funil, que eh o que garante que o BO veja o valor digitado
1328:         *-- mesmo quando o LostFocus do campo nao rodou antes do clique.
1329:         THIS.FormParaBO()
1330: 
1331:         IF !THIS.this_oBusinessObject.Localizar()
1332:             MsgAviso(THIS.this_oBusinessObject.this_cMensagemErro, ;
1333:                 "Aten" + CHR(231) + CHR(227) + "o")
1334:             RETURN .F.
1335:         ENDIF
1336: 
1337:         *-- Localizar() ja zerou this_cBaseLocalizacao/this_cDescBaseLocalizacao
1338:         *-- no BO (equivalente ao getBase/getDBase.Value = [] do legado) -
1339:         *-- espelhar nos controles pelo funil
1340:         THIS.LimparCampos()
1341: 
1342:         THIS.grd_4c_Dados.Column1.SetFocus()
1343:         THIS.grd_4c_Dados.Refresh()
1344:         THIS.GradeAfterRowColChange()
1345: 
1346:         RETURN .T.
1347:     ENDPROC
1348: 
1349:     *==========================================================================
1350:     * BtnLimparClick
1351:     *
1352:     * Equivalente a SigOpLcZ.cmdAcoes.btnLimpar.Click: o legado chama
1353:     * ThisForm.Montagrade(), que so REINDEXA e REBINDA a grade (Index on
1354:     * Cpros, Go Top, Refresh) - NAO recarrega crItensLoc do crTpmMvItn, ou
1355:     * seja nao desfaz marcacoes nem localizacoes ja aplicadas. Aqui o
1356:     * equivalente eh GO TOP + Refresh no MESMO cursor_4c_Itens, mais a
1357:     * limpeza da base escolhida (ThisForm.getBase.Value = [] / getDBase.
1358:     * Value = [] do legado): a property no BO e o controle visual juntos.
1359:     *==========================================================================
1360:     PROCEDURE BtnLimparClick()
1361:         IF !THIS.this_oBusinessObject.PodeEditar()
1362:             RETURN .F.
1363:         ENDIF
1364: 
1365:         *-- ThisForm.Montagrade() do legado: REBINDA e repinta a grade, sem
1366:         *-- recarregar o cursor (nao desfaz marcacoes nem localizacoes ja
1367:         *-- aplicadas). Por isso MontaGrade e NAO CarregarLista.
1368:         THIS.MontaGrade()
1369: 
1370:         *-- getBase.Value = [] / getDBase.Value = [] do legado
1371:         THIS.LimparCampos()
1372: 
1373:         THIS.grd_4c_Dados.Column1.SetFocus()
1374:         THIS.grd_4c_Dados.Refresh()
1375:         THIS.GradeAfterRowColChange()
1376: 
1377:         RETURN .T.
1378:     ENDPROC
1379: 
1380:     *==========================================================================
1381:     * ConfigurarBotoesSelecao - botoes standalone apaga/SelTudo do SCX legado
1382:     *
1383:     * Caption = "" (icone puro) + Themes = .F., fieis ao dump. A regra de
1384:     * modo (When = InList(pcEscolha,'INSERIR','ALTERAR')) NAO vira
1385:     * .Enabled/.Visible em runtime - botao standalone com Caption = "" e
1386:     * Picture definido perde o icone quando desabilitado, independente de
1387:     * Themes (CorretorAutomatico #106). A guarda fica DENTRO do Click.
1388:     *==========================================================================
1389:     PROTECTED PROCEDURE ConfigurarBotoesSelecao()
1390:         THIS.AddObject("cmd_4c_SelTudo", "CommandButton")
1391:         WITH THIS.cmd_4c_SelTudo
1392:             .Top         = 176
1393:             .Left        = 564
1394:             .Width       = 45
1395:             .Height      = 40
1396:             .FontName    = "Verdana"
1397:             .FontSize    = 8
1398:             .Picture     = gc_4c_CaminhoIcones + "geral_marcar_26.jpg"
1399:             .Caption     = ""
1400:             .TabStop     = .F.
1401:             .ToolTipText = "Selecionar"
1402:             .ForeColor   = RGB(36, 84, 155)
1403:             .BackColor   = RGB(255, 255, 255)
1404:             .Themes           = .T.
1405:             .Visible     = .T.
1406:         ENDWITH
1407:         BINDEVENT(THIS.cmd_4c_SelTudo, "Click", THIS, "CmdSelTudoClick")
1408: 
1409:         THIS.AddObject("cmd_4c_Apaga", "CommandButton")
1410:         WITH THIS.cmd_4c_Apaga
1411:             .Top         = 217
1412:             .Left        = 564
1413:             .Width       = 45
1414:             .Height      = 40
1415:             .FontBold    = .F.
1416:             .FontItalic  = .F.
1417:             .FontName    = "Verdana"
1418:             .FontSize    = 8
1419:             .Picture     = gc_4c_CaminhoIcones + "cadastro_excluir_26.jpg"
1420:             .Caption     = ""
1421:             .TabStop     = .F.
1422:             .ToolTipText = "Desmarcar"
1423:             .ForeColor   = RGB(36, 84, 155)
1424:             .BackColor   = RGB(255, 255, 255)
1425:             .Themes           = .T.
1426:             .Visible     = .T.
1427:         ENDWITH
1428:         BINDEVENT(THIS.cmd_4c_Apaga, "Click", THIS, "CmdApagaClick")
1429: 
1430:         RETURN .T.
1431:     ENDPROC
1432: 
1433:     *==========================================================================
1434:     * CmdSelTudoClick / CmdApagaClick
1435:     *
1436:     * Equivalente a SigOpLcZ.SelTudo.Click (Replace All Marcas with 1) e
1437:     * SigOpLcZ.apaga.Click (Replace All Marcas with 0) - ambos seguidos de
1438:     * Go Top + grdItens.AfterRowColChange() + Form.Refresh no legado.
1439:     * Guarda de modo (When legado) replicada no INICIO do Click, nao via
1440:     * .Enabled (regra do botao standalone icone-only acima).
1441:     *==========================================================================
1442:     PROCEDURE CmdSelTudoClick()
1443:         IF !THIS.this_oBusinessObject.PodeEditar()
1444:             RETURN .F.
1445:         ENDIF
1446: 
1447:         THIS.this_oBusinessObject.SelecionarTodos()
1448:         THIS.GradeAfterRowColChange()
1449:         THIS.Refresh()
1450: 
1451:         RETURN .T.
1452:     ENDPROC
1453: 
1454:     PROCEDURE CmdApagaClick()
1455:         IF !THIS.this_oBusinessObject.PodeEditar()
1456:             RETURN .F.
1457:         ENDIF
1458: 
1459:         THIS.this_oBusinessObject.DesmarcarTodos()
1460:         THIS.GradeAfterRowColChange()
1461:         THIS.Refresh()
1462: 
1463:         RETURN .T.
1464:     ENDPROC
1465: 
1466:     *==========================================================================
1467:     * ConfigurarCampoBase - Label3/getBase/getDBase do SCX legado: a
1468:     * localizacao escolhida pelo usuario antes de clicar Localizar.
1469:     *
1470:     * Geometria transcrita do dump:
1471:     *   Label3   Top=136 Left=640 Width=56  Height=15  "Localiza??o"
1472:     *   getBase  Top=154 Left=640 Width=101 Height=24
1473:     *   getDBase Top=154 Left=742 Width=200 Height=24
1474:     *
1475:     * Label3 nao declara ForeColor no dump (classe say pura) - regra #23:
1476:     * AutoSize = .F. com a Width/Height do proprio dump, Alignment = 0,
1477:     * ForeColor = RGB(90, 90, 90) (canonico para label de dados fora da
1478:     * faixa de cabecalho).
1479:     *
1480:     * MaxLength vem do SCHEMA (regra #19), nao do Width em pixels:
1481:     * SigPrLcl.codigos eh char(10) (txt_4c_Base) e SigPrLcl.descricaos eh
1482:     * char(20) (txt_4c_DBase) - docs/schema.sql.
1483:     *
1484:     * getDBase.When do legado retorna .F. incondicional (a celula nunca
1485:     * recebe foco, em qualquer modo) - por isso ReadOnly/TabStop ficam FIXOS
1486:     * aqui, e NAO entram em HabilitarCampos como txt_4c_Base entra.
1487:     *
1488:     * Aqui so a casca VISUAL, com os valores iniciados vazios (equivalente ao
1489:     * PrepararCursores do BO, que ja zera this_cBaseLocalizacao /
1490:     * this_cDescBaseLocalizacao). O COMPORTAMENTO do getBase vive em handlers
1491:     * proprios, ligados por BINDEVENT no fim deste metodo: o lookup do
1492:     * getBase.Valid legado (fwbuscaext em SigPrLcl) esta em BaseLostFocus /
1493:     * BaseLostFocusExec + AbrirBuscaBase, e o getBase.InteractiveChange (que
1494:     * limpa getDBase ao digitar) esta em BaseInteractiveChange.
1495:     *==========================================================================
1496:     PROTECTED PROCEDURE ConfigurarCampoBase()
1497:         THIS.AddObject("lbl_4c_Label3", "Label")
1498:         WITH THIS.lbl_4c_Label3
1499:             .Top       = 136
1500:             .Left      = 640
1501:             .Width     = 56
1502:             .Height    = 15
1503:             .AutoSize  = .F.
1504:             .Alignment = 0
1505:             .BackStyle = 0
1506:             .FontName  = "Verdana"
1507:             .FontSize  = 8
1508:             .ForeColor = RGB(90, 90, 90)
1509:             .Caption   = "Localiza" + CHR(231) + CHR(227) + "o"
1510:             .Visible   = .T.
1511:         ENDWITH
1512: 
1513:         THIS.AddObject("txt_4c_Base", "TextBox")
1514:         WITH THIS.txt_4c_Base
1515:             .Top       = 154
1516:             .Left      = 640
1517:             .Width     = 101
1518:             .Height    = 24
1519:             .FontName  = "Verdana"
1520:             .FontSize  = 8
1521:             .MaxLength = 10
1522:             .Value     = ""
1523:             .ToolTipText = "C" + CHR(243) + "digo da Base de Localiza" + ;
1524:                 CHR(231) + CHR(227) + "o"
1525:             .Visible   = .T.
1526:         ENDWITH
1527: 
1528:         THIS.AddObject("txt_4c_DBase", "TextBox")
1529:         WITH THIS.txt_4c_DBase
1530:             .Top       = 154
1531:             .Left      = 742
1532:             .Width     = 200
1533:             .Height    = 24
1534:             .FontName  = "Verdana"
1535:             .FontSize  = 8
1536:             .MaxLength = 20
1537:             .Value     = ""
1538:             .ReadOnly  = .T.
1539:             .TabStop   = .F.
1540:             .ForeColor = RGB(90, 90, 90)
1541:             .Visible   = .T.
1542:         ENDWITH
1543: 
1544:         BINDEVENT(THIS.txt_4c_Base, "LostFocus", THIS, "BaseLostFocus")
1545:         BINDEVENT(THIS.txt_4c_Base, "InteractiveChange", THIS, "BaseInteractiveChange")
1546: 
1547:         RETURN .T.
1548:     ENDPROC
1549: 
1550:     *==========================================================================
1551:     * BaseInteractiveChange - getBase.InteractiveChange do legado: limpa a
1552:     * descricao enquanto o usuario digita um codigo novo.
1553:     *   ThisForm.getDBase.Value = []
1554:     * PUBLIC: exigido pelo BINDEVENT (regra #3).
1555:     *==========================================================================
1556:     PROCEDURE BaseInteractiveChange()
1557:         THIS.txt_4c_DBase.Value = ""
1558:     ENDPROC
1559: 
1560:     *==========================================================================
1561:     * BaseLostFocus / BaseLostFocusExec - getBase.Valid do legado (busca em
1562:     * SigPrLcl, tabela REMOTA):
1563:     *   loLista = CreateObject('fwbuscaext', ..., 'SigPrLcl', 'crListaRemota',
1564:     *             'Codigos', This.Value, 'Selecao', .t.)
1565:     *   If Not loLista.plAchouRegistro
1566:     *       loLista.mAddColuna('Codigos',    '', 'Localizacao')
1567:     *       loLista.mAddColuna('Descricaos', '', 'Descricao')
1568:     *       loLista.Show()
1569:     *   EndIf
1570:     *   This.Value = crListaRemota.Codigos
1571:     *   ThisForm.getDBase.Value = crListaRemota.Descricaos
1572:     *
1573:     * fwbuscaext tenta o match EXATO por Codigos sozinho (plAchouRegistro) e
1574:     * SO quando nao acha eh que mostra o browse - reproduzido aqui com
1575:     * SQLEXEC exato primeiro (silencioso) e THIS.AbrirBuscaBase() como
1576:     * fallback (regra #36/37: Pattern B do FormBuscaAuxiliar com CREATEOBJECT
1577:     * de 2+ argumentos eh PROIBIDO - CORRETO eh o funil THIS.AbrirLookupCanonico,
1578:     * ja usado pelo FormSigOpLcl irmao desta task).
1579:     *
1580:     * Guarda de reentrancia (regra #37/#47): o corpo vive em
1581:     * BaseLostFocusExec para a flag ser SEMPRE liberada, inclusive com RETURN
1582:     * antecipado dentro do Exec.
1583:     *
1584:     * Sincroniza o resultado com o BO (this_cBaseLocalizacao/
1585:     * this_cDescBaseLocalizacao) - sem isso THIS.this_oBusinessObject.
1586:     * Localizar() nunca veria o valor digitado/escolhido pelo usuario, e
1587:     * sempre recusaria com "Informar a Base da Localizacao.".
1588:     *
1589:     * PUBLIC: exigido pelo BINDEVENT (regra #3).
1590:     *==========================================================================
1591:     PROCEDURE BaseLostFocus()
1592:         IF THIS.this_lEmLookup
1593:             RETURN
1594:         ENDIF
1595:         THIS.this_lEmLookup = .T.
1596:         THIS.BaseLostFocusExec()
1597:         THIS.this_lEmLookup = .F.
1598:     ENDPROC
1599: 
1600:     PROCEDURE BaseLostFocusExec()
1601:         LOCAL loc_cValor, loc_cSQL, loc_nResultado, loc_lAchou
1602: 
1603:         loc_cValor = ALLTRIM(THIS.txt_4c_Base.Value)
1604: 
1605:         *-- Campo vazio: o legado nem entra no If Not Empty(This.Value), ou
1606:         *-- seja nao abre picker nenhum e nao avisa nada (regra #50 - campo
1607:         *-- em branco nao eh erro). So o BO precisa saber que nao ha base.
1608:         IF EMPTY(loc_cValor)
1609:             THIS.FormParaBO()
1610:             RETURN
1611:         ENDIF
1612: 
1613:         loc_lAchou = .F.
1614: 
1615:         IF TYPE("gnConnHandle") = "N"
1616:             IF gnConnHandle > 0
1617:                 IF USED("cursor_4c_BaseExata")
1618:                     USE IN cursor_4c_BaseExata
1619:                 ENDIF
1620: 
1621:                 loc_cSQL = "SELECT Codigos, Descricaos FROM SigPrLcl WHERE Codigos = " + ;
1622:                     EscaparSQL(loc_cValor)
1623:                 loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BaseExata")
1624: 
1625:                 IF loc_nResultado > 0 AND USED("cursor_4c_BaseExata")
1626:                     IF RECCOUNT("cursor_4c_BaseExata") = 1
1627:                         THIS.txt_4c_Base.Value  = ALLTRIM(cursor_4c_BaseExata.Codigos)
1628:                         THIS.txt_4c_DBase.Value = ALLTRIM(NVL(cursor_4c_BaseExata.Descricaos, ""))
1629:                         loc_lAchou = .T.
1630:                     ENDIF
1631:                 ENDIF
1632: 
1633:                 IF USED("cursor_4c_BaseExata")
1634:                     USE IN cursor_4c_BaseExata
1635:                 ENDIF
1636:             ENDIF
1637:         ENDIF
1638: 
1639:         IF !loc_lAchou
1640:             *-- Funil unico do picker (regra #37): tudo que abre
1641:             *-- FormBuscaAuxiliar para a Base passa por AbrirBuscaBase
1642:             THIS.AbrirBuscaBase()
1643:         ENDIF
1644: 
1645:         THIS.txt_4c_Base.Refresh()
1646:         THIS.txt_4c_DBase.Refresh()
1647: 
1648:         *-- Sincroniza o resultado com o BO pelo funil - sem isso
1649:         *-- SigOpLcZBO.Localizar() nunca veria o valor digitado/escolhido e
1650:         *-- recusaria sempre com "Informar a Base da Localizacao."
1651:         THIS.FormParaBO()
1652:     ENDPROC
1653: 
1654:     *==========================================================================
1655:     * AbrirBuscaBase - FUNIL UNICO do picker da Base (SigPrLcl, tabela REMOTA)
1656:     *
1657:     * Transcreve o ramo "nao achou" do getBase.Valid legado (mAddColuna de
1658:     * Codigos/Descricaos). O match exato (plAchouRegistro do legado) ja foi
1659:     * tentado em BaseLostFocusExec - aqui so se chega quando ele falhou.
1660:     *
1661:     * PUBLIC de proposito (regra #3): eh o funil, tem de poder ser acionado
1662:     * de fora do proprio LostFocus.
1663:     *
1664:     * Guarda de reentrancia em SAVE/RESTORE, nao set/clear (regra #47): este
1665:     * metodo eh chamado de DENTRO de BaseLostFocusExec, onde a flag ja esta
1666:     * ligada - um clear simples a liberaria cedo demais e o LostFocus que o
1667:     * fechamento do picker MODAL redispara abriria um SEGUNDO dialogo.
1668:     *==========================================================================
1669:     PROCEDURE AbrirBuscaBase()
1670:         LOCAL loc_cValor, loc_lEmLookupAnt, loc_oErro
1671: 
1672:         loc_lEmLookupAnt    = THIS.this_lEmLookup
1673:         THIS.this_lEmLookup = .T.
1674: 
1675:         TRY
1676:             loc_cValor = ALLTRIM(THIS.txt_4c_Base.Value)
1677: 
1678:             THIS.AbrirLookupCanonico("SigPrLcl", "Codigos", "Descricaos", ;
1679:                 "Sele" + CHR(231) + CHR(227) + "o", loc_cValor, ;
1680:                 THIS.txt_4c_Base, THIS.txt_4c_DBase)
1681: 
1682:         CATCH TO loc_oErro
1683:             MsgErro("Erro ao abrir a sele" + CHR(231) + CHR(227) + "o da Base:" + CHR(13) + ;
1684:                     loc_oErro.Message + CHR(13) + ;
1685:                     "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1686:                     "Procedure: " + loc_oErro.Procedure, "Erro")
1687:         ENDTRY
1688: 
1689:         *-- Restaurado FORA do TRY, para valer tambem quando o CATCH dispara
1690:         THIS.this_lEmLookup = loc_lEmLookupAnt
1691:     ENDPROC
1692: 
1693:     *==========================================================================
1694:     * AjustarBotoesPorModo - FUNIL do estado dos controles por modo
1695:     *
1696:     * Reune as DUAS coisas que o legado avalia para decidir o que esta
1697:     * habilitado: o modo recebido do chamador (os When de getBase,
1698:     * btnLocalizar e btnLimpar, todos "InList(pcEscolha,'INSERIR',
1699:     * 'ALTERAR')") e a linha corrente da grade (o AfterRowColChange, que
1700:     * manda em btnLocalizar). Ter um ponto unico eh o que evita a classe de
1701:     * defeito da regra #40 - quem desabilita no caminho de ida e esquece de
1702:     * reabilitar no caminho de volta deixa a tela inutilizavel, sem erro
1703:     * nenhum e sem nada em log.
1704:     *
1705:     * PUBLIC: o harness de teste chama este metodo de FORA da classe, e
1706:     * PEMSTATUS devolve .T. mesmo para metodo PROTECTED (so testa
1707:     * existencia, nao escopo) - o teste entraria no branch e a chamada real
1708:     * falharia em runtime (regra #3).
1709:     *==========================================================================
1710:     PROCEDURE AjustarBotoesPorModo()
1711:         THIS.HabilitarCampos(THIS.this_oBusinessObject.PodeEditar())
1712: 
1713:         *-- btnLocalizar depende TAMBEM da linha corrente da grade
1714:         THIS.GradeAfterRowColChange()
1715: 
1716:         RETURN .T.
1717:     ENDPROC
1718: 
1719:     *==========================================================================
1720:     * HabilitarCampos - o When de getBase e de btnLimpar
1721:     *
1722:     * Fonte unica da regra de modo: SigOpLcZBO.PodeEditar(). O parametro
1723:     * existe para o chamador poder FORCAR o travamento (e eh assim que o
1724:     * AjustarBotoesPorModo o usa), mas o default - sem argumento - eh
1725:     * consultar o BO, para que nenhum call site precise repetir o INLIST.
1726:     *
1727:     * btnLimpar (Buttons(2) de obj_4c_CmdAcoes) tem Caption, entao .Enabled
1728:     * em runtime eh seguro. Os dois botoes STANDALONE de icone PURO
1729:     * (cmd_4c_SelTudo / cmd_4c_Apaga) NAO entram aqui: desabilitar botao com
1730:     * Caption = "" e Picture definido APAGA o icone, e o usuario ve um
1731:     * retangulo vazio (regra #106) - para esses a guarda mora no inicio do
1732:     * proprio Click.
1733:     *
1734:     * btnLocalizar fica fora porque depende TAMBEM da linha corrente da
1735:     * grade - quem manda nele eh GradeAfterRowColChange.
1736:     *
1737:     * txt_4c_DBase tambem fica fora, e nao por esquecimento: o getDBase.When
1738:     * do legado retorna .F. INCONDICIONAL, isto eh o campo eh inacessivel em
1739:     * QUALQUER modo. Isso ja esta fixado em ConfigurarCampoBase
1740:     * (ReadOnly = .T. + TabStop = .F.); trazer o campo para ca o faria
1741:     * oscilar com o modo, que eh justamente o que o legado nao faz.
1742:     *==========================================================================
1743:     PROTECTED PROCEDURE HabilitarCampos(par_lHabilitar)
1744:         LOCAL loc_lHabilitar
1745: 
1746:         IF PCOUNT() >= 1 AND VARTYPE(par_lHabilitar) = "L"
1747:             loc_lHabilitar = par_lHabilitar
1748:         ELSE
1749:             loc_lHabilitar = THIS.this_oBusinessObject.PodeEditar()
1750:         ENDIF
1751: 
1752:         THIS.obj_4c_CmdAcoes.Buttons(2).Enabled = loc_lHabilitar
1753:         THIS.txt_4c_Base.Enabled                = loc_lHabilitar
1754: 
1755:         RETURN .T.
1756:     ENDPROC
1757: 
1758:     *==========================================================================
1759:     * FormParaBO - txt_4c_Base / txt_4c_DBase -> properties do BO
1760:     *
1761:     * Este dialogo nao tem registro proprio para transferir: o unico dado
1762:     * que o usuario digita eh a BASE escolhida (getBase/getDBase do legado),
1763:     * e eh dela que SigOpLcZBO.Localizar() depende. O legado le o controle
1764:     * direto, no inicio do btnLocalizar.Click (lcLocaliza =
1765:     * ThisForm.getBase.Value); aqui a leitura eh um metodo so, chamado pelo
1766:     * handler do lookup E pelo botao Localizar, para os dois nunca
1767:     * divergirem.
1768:     *
1769:     * PROTECTED obrigatorio: FormBase declara este hook como PROTECTED e o
1770:     * VFP9 nao deixa a subclasse ALARGAR escopo herdado - a chamada de fora
1771:     * estouraria "Property FORMPARABO is not found" em runtime (regra #51).
1772:     *==========================================================================
1773:     PROTECTED PROCEDURE FormParaBO()
1774:         IF VARTYPE(THIS.this_oBusinessObject) != "O"
1775:             RETURN .F.
1776:         ENDIF
1777: 
1778:         THIS.this_oBusinessObject.this_cBaseLocalizacao = ;
1779:             ALLTRIM(NVL(THIS.txt_4c_Base.Value, ""))
1780: 
1781:         THIS.this_oBusinessObject.this_cDescBaseLocalizacao = ;
1782:             ALLTRIM(NVL(THIS.txt_4c_DBase.Value, ""))
1783: 
1784:         RETURN .T.
1785:     ENDPROC
1786: 
1787:     *==========================================================================
1788:     * BOParaForm - properties do BO -> txt_4c_Base / txt_4c_DBase
1789:     *
1790:     * Caminho inverso do FormParaBO. Quem zera a base eh o BO (o
1791:     * Localizar() limpa this_cBaseLocalizacao depois de aplicar, como o
1792:     * legado limpa getBase/getDBase no fim do Click), entao o form precisa
1793:     * de um ponto unico para ESPELHAR o estado do BO nos controles.
1794:     *
1795:     * PROTECTED obrigatorio pelo mesmo motivo do FormParaBO (regra #51).
1796:     *==========================================================================
1797:     PROTECTED PROCEDURE BOParaForm()
1798:         IF VARTYPE(THIS.this_oBusinessObject) != "O"
1799:             RETURN .F.
1800:         ENDIF
1801: 
1802:         THIS.txt_4c_Base.Value = ;
1803:             ALLTRIM(NVL(THIS.this_oBusinessObject.this_cBaseLocalizacao, ""))
1804: 
1805:         THIS.txt_4c_DBase.Value = ;
1806:             ALLTRIM(NVL(THIS.this_oBusinessObject.this_cDescBaseLocalizacao, ""))
1807: 
1808:         THIS.txt_4c_Base.Refresh()
1809:         THIS.txt_4c_DBase.Refresh()
1810: 
1811:         RETURN .T.
1812:     ENDPROC
1813: 
1814:     *==========================================================================
1815:     * LimparCampos - o par "getBase.Value = [] / getDBase.Value = []"
1816:     *
1817:     * O legado repete esse par no fim do btnLocalizar.Click e no fim do
1818:     * btnLimpar.Click. Aqui ele eh um metodo so, que zera os DOIS lados - a
1819:     * property do BO e o controle visual. Zerar apenas o controle deixaria
1820:     * o BO achando que ainda tem uma base escolhida, e o Localizar seguinte
1821:     * aplicaria a localizacao ANTERIOR num item novo, sem erro e sem aviso.
1822:     *
1823:     * PROTECTED obrigatorio pelo mesmo motivo do FormParaBO (regra #51).
1824:     *==========================================================================
1825:     PROTECTED PROCEDURE LimparCampos()
1826:         IF VARTYPE(THIS.this_oBusinessObject) = "O"
1827:             THIS.this_oBusinessObject.this_cBaseLocalizacao     = ""
1828:             THIS.this_oBusinessObject.this_cDescBaseLocalizacao = ""
1829:         ENDIF
1830: 
1831:         *-- Espelha o estado (agora vazio) do BO nos controles
1832:         THIS.BOParaForm()
1833: 
1834:         RETURN .T.
1835:     ENDPROC
1836: 
1837:     *==========================================================================
1838:     * AjustarOrdemTabulacao - TabIndex transcrito do dump do SCX
1839:     *
1840:     * O dump declara a ordem controle a controle, e ela faz parte do PILAR 1
1841:     * ("ordem de tabulacao" eh comportamento que o usuario percebe):
1842:     *   grdItens  = 1   cmdAcoes = 2   cntBotoes = 3
1843:     *   Label3    = 4   getBase  = 5   getDBase  = 6
1844:     *   SelTudo   = 24  apaga    = 26  (ambos com TabStop = .F.)
1845:     * Dentro de cada CommandGroup, o dump poe Command2 = 1 e Command1 = 2 -
1846:     * ou seja Confirmar antes de Cancelar, e Limpar antes de Localizar.
1847:     *
1848:     * Atribuido em ordem CRESCENTE do valor desejado porque em VFP9
1849:     * atribuir TabIndex eh uma REORDENACAO (o controle entra na posicao N e
1850:     * empurra os demais), nao a gravacao de um numero independente.
1851:     *
1852:     * Os dois standalone ficam de fora da atribuicao de proposito. O dump
1853:     * da a eles 24 e 26, valores MUITO acima da contagem de controles deste
1854:     * form; como os dois tem TabStop = .F., estao fora da cadeia de
1855:     * tabulacao e o numero nao tem efeito observavel nenhum - mas atribuir
1856:     * um indice fora de faixa REORDENARIA a cadeia dos outros seis, que eh
1857:     * o unico comportamento que o usuario percebe. O TabStop = .F. deles ja
1858:     * esta transcrito em ConfigurarBotoesSelecao, e eh ele que reproduz o
1859:     * legado aqui.
1860:     *==========================================================================
1861:     PROTECTED PROCEDURE AjustarOrdemTabulacao()
1862: 
1863:         *-- Dentro dos grupos: Command2 (= Buttons(2)) vem primeiro
1864:         THIS.obj_4c_CmdAcoes.Buttons(2).TabIndex  = 1
1865:         THIS.obj_4c_CmdAcoes.Buttons(1).TabIndex  = 2
1866:         THIS.obj_4c_CntBotoes.Buttons(2).TabIndex = 1
1867:         THIS.obj_4c_CntBotoes.Buttons(1).TabIndex = 2
1868: 
1869:         *-- No form: ordem crescente, para a reordenacao acumular certo
1870:         THIS.grd_4c_Dados.TabIndex    = 1
1871:         THIS.obj_4c_CmdAcoes.TabIndex = 2
1872:         THIS.obj_4c_CntBotoes.TabIndex = 3
1873:         THIS.lbl_4c_Label3.TabIndex   = 4
1874:         THIS.txt_4c_Base.TabIndex     = 5
1875:         THIS.txt_4c_DBase.TabIndex    = 6
1876: 
1877:         RETURN .T.
1878:     ENDPROC
1879: 
1880:     *==========================================================================
1881:     * TornarControlesVisiveis - AddObject cria controle com Visible = .F.;
1882:     * este metodo percorre a arvore e os torna visiveis.
1883:     *
1884:     * PUBLIC de proposito: o harness de teste chama metodos do form de FORA da
1885:     * classe, e PEMSTATUS(oForm, "<metodo>", 5) devolve .T. mesmo para metodo
1886:     * PROTECTED (so verifica existencia, nao escopo) - o teste entraria no
1887:     * branch e a chamada real falharia em runtime.
1888:     *
1889:     * O controle que o SCX legado declara com Visible = .F. continua oculto: no
1890:     * dump eh o ImgJpg (foto do produto), que o legado so exibe quando a linha
1891:     * corrente da grade tem imagem. A lista de excecao eh por NOME do objeto
1892:     * migrado e cresce conforme as fases seguintes criam esses controles.
1893:     *==========================================================================
1894:     PROCEDURE TornarControlesVisiveis(par_oContainer)
1895:         LOCAL loc_nI, loc_oObjeto, loc_cNome
1896: 
1897:         IF VARTYPE(par_oContainer) != "O"
1898:             RETURN .F.
1899:         ENDIF
1900: 
1901:         IF !PEMSTATUS(par_oContainer, "ControlCount", 5)
1902:             RETURN .F.
1903:         ENDIF
1904: 
1905:         FOR loc_nI = 1 TO par_oContainer.ControlCount
1906:             loc_oObjeto = par_oContainer.Controls(loc_nI)
1907: 
1908:             IF VARTYPE(loc_oObjeto) = "O"
1909:                 loc_cNome = UPPER(ALLTRIM(loc_oObjeto.Name))
1910: 
1911:                 *-- Controles que nascem ocultos no legado continuam ocultos,
1912:                 *-- mas recursa-se neles para que os filhos fiquem visiveis
1913:                 IF INLIST(loc_cNome, "IMG_4C_IMGJPG")
1914:                     IF PEMSTATUS(loc_oObjeto, "ControlCount", 5) AND ;
1915:                             loc_oObjeto.ControlCount > 0
1916:                         THIS.TornarControlesVisiveis(loc_oObjeto)
1917:                     ENDIF
1918:                     LOOP
1919:                 ENDIF
1920: 
1921:                 IF PEMSTATUS(loc_oObjeto, "Visible", 5)
1922:                     loc_oObjeto.Visible = .T.
1923:                 ENDIF
1924: 
1925:                 *-- Containers em geral: recursao pelos filhos
1926:                 IF PEMSTATUS(loc_oObjeto, "ControlCount", 5)
1927:                     THIS.TornarControlesVisiveis(loc_oObjeto)
1928:                 ENDIF
1929:             ENDIF
1930:         ENDFOR
1931: 
1932:         RETURN .T.
1933:     ENDPROC
1934: 
1935:     *==========================================================================
1936:     * Destroy - libera o BO, que fecha os proprios cursores de trabalho
1937:     *
1938:     * Legado (PROCEDURE Release): Use In crItensLoc / Use In csLocals. No
1939:     * migrado esses dois cursores pertencem ao BO (cursor_4c_Itens e
1940:     * cursor_4c_Selecionados) e sao fechados pelo Destroy dele.
1941:     * crTpmMvItn NAO eh fechado aqui: pertence ao form CHAMADOR, que continua
1942:     * usando o cursor depois deste dialogo fechar - eh justamente nele que o
1943:     * Confirmar gravou as localizacoes.
1944:     *
1945:     * DODEFAULT() eh obrigatorio e fica por ULTIMO: FormBase.Destroy refaz os
1946:     * popups do menu principal, que o fechamento de form modal corrompe.
1947:     *==========================================================================
1948:     PROCEDURE Destroy()
1949:         IF VARTYPE(THIS.this_oBusinessObject) = "O"
1950:             THIS.this_oBusinessObject = .NULL.
1951:         ENDIF
1952: 
1953:         THIS.this_oConexao = .NULL.
1954: 
1955:         DODEFAULT()
1956:     ENDPROC
1957: 
1958: ENDDEFINE


### BO (C:\4c\projeto\app\classes\SigOpLcZBO.prg):
*============================================================================
* SigOpLcZBO.prg - Business Object para "Selecao de Localizacao" (SIGOPLCZ)
*
* Form OPERACIONAL (SIGOPLCZ / FormSigOpLcZ): dialogo MODAL chamado por um
* form PAI que ja tem aberto o cursor crTpmMvItn com os itens de um
* movimento (produtos sem localizacao atribuida, ou a atualizar). O dialogo
* NAO consulta o banco: ele agrega esse cursor localmente (Select Distinct
* Cpros/Dpros/Locals), deixa o usuario marcar linhas na grade, escolher UMA
* localizacao (lookup em SigPrLcl) e aplicar em lote - de volta no cursor do
* PAI, via UPDATE crTpmMvItn Set Locals|Localos = <escolhida> Where
* Cpros = <marcado>.
*
* Parametros do legado (Init lParameters pCnx, pEscolha, pOrigem):
*   pCnx      - ThisForm.poDataMgr (gerenciador de conexao Fortyus). NAO
*               tem equivalente aqui: a arquitetura nova usa o handle
*               global gnConnHandle, entao este BO nao guarda property para
*               ele.
*   pEscolha  - Thisform.pcEscolha: modo de abertura ('INSERIR'/'ALTERAR'/
*               'PROCURAR' no padrao Fortyus). Controla o When() dos botoes
*               de marcacao/limpeza/localizar (so habilitados fora de
*               'PROCURAR').
*   pOrigem   - Thisform.pcOrigem: 'ORIGEM' ou outro valor. Decide qual
*               coluna do crTpmMvItn recebe a localizacao no Confirmar:
*               'ORIGEM' grava em Localos, qualquer outro valor grava em
*               Locals.
*
* Cursor de entrada (fornecido pelo form PAI - este BO so o consulta/altera,
* nunca o cria):
*   crTpmMvItn - cursor de itens do movimento, com (ao menos) Cpros, Dpros,
*                Locals e LocalOs. Alias LITERAL do legado: o form pai e os
*                metodos deste BO compartilham a mesma area de trabalho, por
*                isso NAO se renomeia (mesma logica de alias-contrato das
*                regras de FRX/OLE - aqui o "contrato" eh com quem chama a
*                tela, nao com um relatorio).
*
* Cursores de trabalho (criados pelo Init, nas fases seguintes):
*   cursor_4c_Itens        - equivalente ao crItensLoc do legado: Select
*                             Distinct 0 as Marcas, Cpros, Dpros e a coluna
*                             de localizacao atual (Locals ou LocalOs,
*                             conforme this_cOrigem) extraida de
*                             crTpmMvItn Where Not Empty(Cpros). Marcas eh a
*                             flag de selecao (0/1) que a grade edita via
*                             CheckBox.
*   cursor_4c_Selecionados  - equivalente ao csLocals do legado: Cpros c(14)
*                             + Locals c(10), populado pelo Localizar
*                             (linhas marcadas) e aplicado ao crTpmMvItn pelo
*                             Confirmar.
*
* Nao existe tabela propria (this_cTabela fica vazio): este BO nao faz
* INSERT/UPDATE/DELETE contra o SQL Server - toda leitura/escrita eh sobre
* os cursores em memoria acima.
*
* Herda de: BusinessBase
* Criado em: Fase 1 - Propriedades e Init
*
* Fase 2 - Metodos de dados (sem CRUD de tabela - este BO nao tem tabela
* propria, entao Inserir()/Atualizar()/ExecutarExclusao()/
* ObterChavePrimaria()/RegistrarAuditoria() NAO sao sobrescritos aqui: o
* comportamento padrao herdado de BusinessBase ja eh o correto para esta
* tela, que so le/escreve nos cursores em memoria abaixo):
*   CarregarItens()       - equivalente ao Init/Select Distinct do legado:
*                           (re)monta cursor_4c_Itens a partir de
*                           crTpmMvItn, indexado por Cpros.
*   SelecionarTodos()     - equivalente ao SigOpLcZ.SelTudo.Click.
*   DesmarcarTodos()      - equivalente ao SigOpLcZ.apaga.Click.
*   Localizar()           - equivalente ao cmdAcoes.btnLocalizar.Click:
*                           valida a base escolhida, move os itens
*                           marcados de cursor_4c_Itens para
*                           cursor_4c_Selecionados e limpa a marcacao.
*   Confirmar()           - equivalente ao cntBotoes.btnConfirmar.Click:
*                           aplica cursor_4c_Selecionados de volta em
*                           crTpmMvItn (Localos ou Locals conforme
*                           this_cOrigem).
*   ObterImagemProduto()  - equivalente ao CursorQuery('SigCdPro',...,
*                           'FigJpgs') do grdItens.AfterRowColChange.
*   PrepararCursores()    - equivalente ao "If Used([csLocals]) / Use in
*                           csLocals / Create Cursor csLocals(...)" do Init
*                           legado: derruba e recria
*                           cursor_4c_Selecionados, para que uma reabertura
*                           do dialogo nao herde a selecao do movimento
*                           anterior.
*   CarregarDoCursor()    - le a linha CORRENTE da grade (Cpros, Dpros,
*                           Locals, Marcas) para as properties this_*Atual,
*                           como faz o grdItens.AfterRowColChange legado.
*   LimparLinhaAtual()    - zera essas properties (cursor vazio ou em EOF).
*   PodeLocalizar()       - regra "Empty(Locals) And Not Empty(Marcas)" do
*                           AfterRowColChange: fonte unica do
*                           btnLocalizar.Enabled.
*   PodeEditar()          - regra "InList(pcEscolha,'INSERIR','ALTERAR')"
*                           dos When() legado: fonte unica do Enabled dos
*                           botoes de marcacao/limpeza/localizacao.
*============================================================================

DEFINE CLASS SigOpLcZBO AS BusinessBase

    *==========================================================================
    * PARAMETROS DE ABERTURA (pcEscolha / pcOrigem do legado)
    *==========================================================================

    *-- Modo de abertura: 'INSERIR' / 'ALTERAR' / 'PROCURAR'. Fora de
    *-- 'PROCURAR' os botoes de marcar/limpar/localizar ficam habilitados
    *-- (mesmo teste do When legado: InList(pcEscolha,'INSERIR','ALTERAR')).
    this_cEscolha = ""

    *-- 'ORIGEM' ou outro valor. Decide, no Confirmar, se a localizacao
    *-- escolhida grava em crTpmMvItn.Localos (ORIGEM) ou em
    *-- crTpmMvItn.Locals (qualquer outro valor).
    this_cOrigem = ""

    *==========================================================================
    * CURSOR DE ENTRADA (fornecido pelo form PAI)
    *==========================================================================

    *-- Alias LITERAL compartilhado com quem abriu o dialogo - nao se
    *-- renomeia para o padrao cursor_4c_* porque este BO nao o cria, so
    *-- consulta/atualiza a area de trabalho que o chamador deixou aberta.
    this_cCursorOrigem = "crTpmMvItn"

    *==========================================================================
    * CURSORES DE TRABALHO (criados por este BO)
    *==========================================================================

    *-- Equivalente ao crItensLoc do legado: grade de selecao (Marcas, Cpros,
    *-- Dpros, Locals/LocalOs conforme this_cOrigem)
    this_cCursorItens = "cursor_4c_Itens"

    *-- Equivalente ao csLocals do legado: itens marcados + localizacao
    *-- escolhida, acumulados pelo Localizar e aplicados pelo Confirmar
    this_cCursorSelecionados = "cursor_4c_Selecionados"

    *==========================================================================
    * LOCALIZACAO ESCOLHIDA (getBase/getDBase do legado)
    *==========================================================================

    *-- Codigo da base de localizacao escolhida (lookup em SigPrLcl.Codigos)
    this_cBaseLocalizacao = ""

    *-- Descricao da base de localizacao escolhida (SigPrLcl.Descricaos)
    this_cDescBaseLocalizacao = ""

    *==========================================================================
    * LINHA CORRENTE DA GRADE (crItensLoc do legado)
    *
    * O grdItens.AfterRowColChange legado le TRES campos da linha corrente de
    * crItensLoc: Cpros (para a consulta da imagem do produto) e Locals +
    * Marcas (para decidir se o botao Localizar fica habilitado). Estas
    * properties sao o destino dessa leitura, feita por CarregarDoCursor().
    *==========================================================================

    *-- Codigo do produto da linha corrente (crItensLoc.Cpros, char(14))
    this_cCprosAtual = ""

    *-- Descricao do produto da linha corrente (crItensLoc.Dpros)
    this_cDprosAtual = ""

    *-- Localizacao JA atribuida ao produto da linha corrente
    *-- (crItensLoc.Locals, char(10)); fica vazia enquanto o item nao foi
    *-- localizado
    this_cLocalAtual = ""

    *-- Flag de selecao da linha corrente (crItensLoc.Marcas): 0 = nao
    *-- marcada, 1 = marcada. NUMERICA, igual ao "0 as Marcas" do Select
    *-- Distinct legado: comparar com 0/1, nunca com .F./.T.
    this_nMarcasAtual = 0

    *--------------------------------------------------------------------------
    * Init - Recebe o modo de abertura e a origem, vindos do form PAI
    *--------------------------------------------------------------------------
    PROCEDURE Init(par_cEscolha, par_cOrigem)
        * Sem tabela propria: este BO nao faz CRUD contra o SQL Server
        DODEFAULT("")

        IF VARTYPE(par_cEscolha) = "C"
            THIS.this_cEscolha = par_cEscolha
        ENDIF

        IF VARTYPE(par_cOrigem) = "C"
            THIS.this_cOrigem = par_cOrigem
        ENDIF

        *-- O Init legado cria csLocals (derrubando um remanescente) antes
        *-- de qualquer coisa. Fazer isso aqui garante que
        *-- cursor_4c_Selecionados exista desde a construcao, sem depender
        *-- de o Form lembrar de chamar PrepararCursores().
        THIS.PrepararCursores()

        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarItens - (Re)monta cursor_4c_Itens a partir de crTpmMvItn.
    * Equivalente ao trecho do Init legado:
    *   Select Distinct 0 as Marcas, Cpros, Dpros,
    *     Iif(pcOrigem='ORIGEM', LocalOs, Locals) as Locals
    *     From crTpmMvItn Where Not Empty(Cpros) Into Cursor crItensLoc
    * seguido do Index on Cpros Tag Cpros do MontaGrade (a grade em si -
    * RecordSource/ControlSource/Refresh - fica no Form, que a reconfigura
    * apos chamar este metodo).
    *--------------------------------------------------------------------------
    PROCEDURE CarregarItens()
        LOCAL loc_lSucesso

        loc_lSucesso = .F.
        THIS.this_cMensagemErro = ""

        IF !USED(THIS.this_cCursorOrigem)
            THIS.this_cMensagemErro = "Cursor de itens do movimento (" + ;
                THIS.this_cCursorOrigem + ") n" + CHR(227) + "o est" + CHR(225) + " aberto."
            RETURN .F.
        ENDIF

        IF USED(THIS.this_cCursorItens)
            USE IN (THIS.this_cCursorItens)
        ENDIF

        SELECT DISTINCT 0 AS Marcas, Cpros, Dpros, ;
                IIF(THIS.this_cOrigem == "ORIGEM", LocalOs, Locals) AS Locals ;
            FROM (THIS.this_cCursorOrigem) ;
            WHERE !EMPTY(Cpros) ;
            INTO CURSOR (THIS.this_cCursorItens) READWRITE

        IF USED(THIS.this_cCursorItens)
            SELECT (THIS.this_cCursorItens)
            INDEX ON Cpros TAG Cpros
            GO TOP
            loc_lSucesso = .T.
        ELSE
            THIS.this_cMensagemErro = "Falha ao montar a grade de itens."
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * PrepararCursores - Cria (zerado) o cursor de itens selecionados.
    * Equivalente ao trecho do Init legado:
    *   If Used([csLocals]) / Use in csLocals / EndIf
    *   Create Cursor csLocals(Cpros c(14), Locals c(10))
    * O legado DERRUBA um csLocals remanescente antes de recriar, e isso eh
    * regra e nao detalhe: este dialogo eh reaberto a cada movimento, e um
    * cursor sobrevivente de uma abertura anterior faria o Confirmar()
    * aplicar localizacoes de OUTRO movimento, sem erro e sem aviso. Por isso
    * a criacao mora aqui (o Form chama na abertura) e nao so embutida no
    * Localizar().
    *--------------------------------------------------------------------------
    PROCEDURE PrepararCursores()
        LOCAL loc_nAreaAnterior

        *-- CREATE CURSOR SELECIONA o cursor criado. Como este metodo roda
        *-- no Init (construcao do BO), deixar a area trocada mudaria o
        *-- cursor corrente POR BAIXO do form PAI, que tem crTpmMvItn
        *-- selecionado. O legado contorna com um "Select crTpmMvItn"
        *-- logo depois; aqui salva e restaura, que nao depende de quem chama.
        loc_nAreaAnterior = SELECT()

        IF USED(THIS.this_cCursorSelecionados)
            USE IN (THIS.this_cCursorSelecionados)
        ENDIF

        CREATE CURSOR (THIS.this_cCursorSelecionados) (Cpros C(14), Locals C(10))

        SELECT (loc_nAreaAnterior)

        THIS.this_cBaseLocalizacao     = ""
        THIS.this_cDescBaseLocalizacao = ""

        THIS.LimparLinhaAtual()

        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * LimparLinhaAtual - Zera as properties da linha corrente da grade.
    * Usado pelo PrepararCursores e pelo CarregarDoCursor quando o cursor
    * esta vazio ou em EOF (nenhuma linha corrente para ler).
    *--------------------------------------------------------------------------
    PROCEDURE LimparLinhaAtual()
        THIS.this_cCprosAtual  = ""
        THIS.this_cDprosAtual  = ""
        THIS.this_cLocalAtual  = ""
        THIS.this_nMarcasAtual = 0

        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Le a linha CORRENTE do cursor da grade de itens para
    * as properties this_*Atual.
    * Equivalente as leituras de crItensLoc feitas pelo
    * SigOpLcZ.grdItens.AfterRowColChange:
    *   crItensLoc.Cpros  -> consulta da imagem (ObterImagemProduto)
    *   crItensLoc.Locals -> regra de habilitacao do Localizar
    *   crItensLoc.Marcas -> regra de habilitacao do Localizar
    * Chamado SEM argumento, le o proprio cursor_4c_Itens
    * (this_cCursorItens), que eh o uso normal a partir do
    * AfterRowColChange da grade.
    *
    * Guarda de EOF/BOF obrigatoria: o cursor fica vazio quando todos os
    * itens ja foram localizados (o Localizar() apaga as linhas marcadas), e
    * ler campo em EOF devolveria o valor da ULTIMA linha apagada,
    * reabilitando o Localizar para um produto que nao esta mais na grade.
    *
    * A area de trabalho do chamador eh salva e restaurada (o lnOldSel do
    * legado): este metodo eh um LEITOR e nao deve deixar o cursor da grade
    * selecionado por efeito colateral.
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_cAlias, loc_nAreaAnterior, loc_lSucesso

        loc_lSucesso      = .F.
        loc_nAreaAnterior = SELECT()

        loc_cAlias = IIF(VARTYPE(par_cAliasCursor) = "C" AND ;
            !EMPTY(par_cAliasCursor), par_cAliasCursor, THIS.this_cCursorItens)

        IF !USED(loc_cAlias)
            THIS.LimparLinhaAtual()
        ELSE
            SELECT (loc_cAlias)

            IF EOF() OR BOF() OR RECCOUNT() = 0
                THIS.LimparLinhaAtual()
            ELSE
                THIS.this_cCprosAtual  = ALLTRIM(TratarNulo(Cpros, ""))
                THIS.this_cDprosAtual  = ALLTRIM(TratarNulo(Dpros, ""))
                THIS.this_cLocalAtual  = ALLTRIM(TratarNulo(Locals, ""))
                THIS.this_nMarcasAtual = TratarNulo(Marcas, 0)
                loc_lSucesso = .T.
            ENDIF
        ENDIF

        SELECT (loc_nAreaAnterior)

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * PodeLocalizar - Regra de habilitacao do botao Localizar para a linha
    * corrente da grade.
    * Equivalente ao final do SigOpLcZ.grdItens.AfterRowColChange:
    *   If Empty(crItensLoc.Locals) And Not Empty(crItensLoc.Marcas)
    *       ThisForm.cmdAcoes.btnLocalizar.Enabled = .T.
    *   Else
    *       ThisForm.cmdAcoes.btnLocalizar.Enabled = .F.
    *   EndIf
    * FONTE UNICA: quem calcula eh o BO e o Form so espelha em .Enabled -
    * reescrever a condicao no Form faria as duas divergirem.
    * Pressupoe CarregarDoCursor() ja chamado para a linha corrente.
    *--------------------------------------------------------------------------
    PROCEDURE PodeLocalizar()
        RETURN EMPTY(THIS.this_cLocalAtual) AND THIS.this_nMarcasAtual <> 0
    ENDPROC

    *--------------------------------------------------------------------------
    * PodeEditar - O modo de abertura permite marcar/limpar/localizar?
    * Equivalente ao When() que o legado repete em grdItens.Column3.Check1,
    * nos dois CommandGroup cmdAcoes, em apaga e em SelTudo:
    *   Return(InList(ThisForm.pcEscolha,'INSERIR','ALTERAR'))
    * FONTE UNICA dessa regra: os controles do Form espelham este metodo em
    * vez de repetir o INLIST.
    * O UPPER/ALLTRIM eh defensivo - this_cEscolha pode chegar de um campo
    * char padded do chamador, e SET EXACT ON (config.prg) faria o INLIST
    * falhar com o padding.
    *--------------------------------------------------------------------------
    PROCEDURE PodeEditar()
        RETURN INLIST(UPPER(ALLTRIM(NVL(THIS.this_cEscolha, ""))), ;
            "INSERIR", "ALTERAR")
    ENDPROC

    *--------------------------------------------------------------------------
    * SelecionarTodos - Marca todas as linhas de cursor_4c_Itens.
    * Equivalente ao SigOpLcZ.SelTudo.Click
    *   (Replace All crItensLoc.Marcas with 1).
    *--------------------------------------------------------------------------
    PROCEDURE SelecionarTodos()
        IF !USED(THIS.this_cCursorItens)
            RETURN .F.
        ENDIF

        SELECT (THIS.this_cCursorItens)
        REPLACE ALL Marcas WITH 1
        GO TOP

        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * DesmarcarTodos - Desmarca todas as linhas de cursor_4c_Itens.
    * Equivalente ao SigOpLcZ.apaga.Click
    *   (Replace All crItensLoc.Marcas with 0).
    *--------------------------------------------------------------------------
    PROCEDURE DesmarcarTodos()
        IF !USED(THIS.this_cCursorItens)
            RETURN .F.
        ENDIF

        SELECT (THIS.this_cCursorItens)
        REPLACE ALL Marcas WITH 0
        GO TOP

        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * Localizar - Move os itens marcados de cursor_4c_Itens para
    * cursor_4c_Selecionados, usando a base escolhida (this_cBaseLocalizacao).
    * Equivalente ao SigOpLcZ.cmdAcoes.btnLocalizar.Click:
    *   valida getBase.Value; Scan For Marcas <> 0 em crItensLoc, Append
    *   Blank em csLocals (Cpros, Locals = base escolhida); Delete From
    *   crItensLoc Where Marcas <> 0; limpa getBase/getDBase.
    *--------------------------------------------------------------------------
    PROCEDURE Localizar()
        LOCAL loc_cCpros

        THIS.this_cMensagemErro = ""

        IF EMPTY(ALLTRIM(NVL(THIS.this_cBaseLocalizacao, "")))
            THIS.this_cMensagemErro = "Informar a Base da Localiza" + CHR(231) + CHR(227) + "o."
            RETURN .F.
        ENDIF

        IF !USED(THIS.this_cCursorItens)
            THIS.this_cMensagemErro = "A grade de itens n" + CHR(227) + "o est" + CHR(225) + " carregada."
            RETURN .F.
        ENDIF

        IF !USED(THIS.this_cCursorSelecionados)
            CREATE CURSOR (THIS.this_cCursorSelecionados) (Cpros C(14), Locals C(10))
        ENDIF

        SELECT (THIS.this_cCursorItens)
        GO TOP
        SCAN FOR Marcas <> 0
            loc_cCpros = Cpros

            SELECT (THIS.this_cCursorSelecionados)
            APPEND BLANK
            REPLACE Cpros  WITH loc_cCpros
            REPLACE Locals WITH THIS.this_cBaseLocalizacao

            SELECT (THIS.this_cCursorItens)
        ENDSCAN

        SELECT (THIS.this_cCursorItens)
        DELETE FOR Marcas <> 0
        GO TOP

        THIS.this_cBaseLocalizacao = ""
        THIS.this_cDescBaseLocalizacao = ""

        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * Confirmar - Aplica cursor_4c_Selecionados de volta em crTpmMvItn.
    * Equivalente ao SigOpLcZ.cntBotoes.btnConfirmar.Click:
    *   Scan em csLocals; Update crTpmMvItn Set Localos|Locals =
    *   csLocals.Locals Where Cpros = csLocals.Cpros, conforme this_cOrigem.
    * Sem linhas em cursor_4c_Selecionados (nenhum item foi Localizar()ado),
    * eh um no-op valido - o legado tambem nao faz nada no Scan vazio.
    *--------------------------------------------------------------------------
    PROCEDURE Confirmar()
        LOCAL loc_cCpros, loc_cLocal, loc_lOrigem

        IF !USED(THIS.this_cCursorSelecionados)
            RETURN .T.
        ENDIF

        loc_lOrigem = (THIS.this_cOrigem == "ORIGEM")

        SELECT (THIS.this_cCursorSelecionados)
        GO TOP
        SCAN
            loc_cCpros = Cpros
            loc_cLocal = Locals

            SELECT (THIS.this_cCursorOrigem)
            IF loc_lOrigem
                REPLACE ALL LocalOs WITH loc_cLocal FOR Cpros = loc_cCpros
            ELSE
                REPLACE ALL Locals WITH loc_cLocal FOR Cpros = loc_cCpros
            ENDIF

            SELECT (THIS.this_cCursorSelecionados)
        ENDSCAN

        SELECT (THIS.this_cCursorOrigem)
        GO TOP

        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterImagemProduto - Devolve o conteudo de SigCdPro.FigJpgs (base64) do
    * produto informado, ou .NULL. se nao houver imagem.
    * Equivalente ao
    *   ThisForm.poDataMgr.CursorQuery('SigCdPro','crTPro','Cpros',
    *     crItensLoc.Cpros,'FigJpgs')
    * do SigOpLcZ.grdItens.AfterRowColChange. A decodificacao do base64 e a
    * gravacao do arquivo .jpg temporario (StrToFile) ficam no Form, que eh
    * quem conhece o controle Image que vai exibi-la.
    *--------------------------------------------------------------------------
    PROCEDURE ObterImagemProduto(par_cCpros)
        LOCAL loc_cCursorTemp, loc_cSQL, loc_xRetorno

        loc_xRetorno = .NULL.

        IF EMPTY(ALLTRIM(NVL(par_cCpros, "")))
            RETURN loc_xRetorno
        ENDIF

        IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
            RETURN loc_xRetorno
        ENDIF

        loc_cCursorTemp = "cursor_4c_ImgProdTmp"
        IF USED(loc_cCursorTemp)
            USE IN (loc_cCursorTemp)
        ENDIF

        loc_cSQL = "SELECT FigJpgs FROM SigCdPro WHERE Cpros = " + ;
            EscaparSQL(ALLTRIM(par_cCpros))

        IF SQLEXEC(gnConnHandle, loc_cSQL, loc_cCursorTemp) > 0
            IF USED(loc_cCursorTemp) AND RECCOUNT(loc_cCursorTemp) > 0
                IF !ISNULL(EVALUATE(loc_cCursorTemp + ".FigJpgs")) AND ;
                        !EMPTY(EVALUATE(loc_cCursorTemp + ".FigJpgs"))
                    loc_xRetorno = EVALUATE(loc_cCursorTemp + ".FigJpgs")
                ENDIF
            ENDIF
        ELSE
            THIS.this_cMensagemErro = "Erro ao buscar imagem do produto: " + CapturarErroSQL()
        ENDIF

        IF USED(loc_cCursorTemp)
            USE IN (loc_cCursorTemp)
        ENDIF

        RETURN loc_xRetorno
    ENDPROC

    *--------------------------------------------------------------------------
    * Destroy - Fecha os cursores de trabalho criados por este BO.
    * Equivalente ao SigOpLcZ.Release: Use In crItensLoc / Use In csLocals.
    * (cursor_4c_Itens / cursor_4c_Selecionados). crTpmMvItn eh do form PAI e
    * NAO eh fechado aqui.
    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
        IF USED(THIS.this_cCursorItens)
            USE IN (THIS.this_cCursorItens)
        ENDIF

        IF USED(THIS.this_cCursorSelecionados)
            USE IN (THIS.this_cCursorSelecionados)
        ENDIF

        DODEFAULT()
    ENDPROC

ENDDEFINE


# CODE REVIEW - PASS FUNCTIONAL: Functional Logic (metodos, eventos, containers)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Functional Logic (metodos, eventos, containers)**.

## PROBLEMAS DETECTADOS (12)
- [CONTAINER-VISIVEL] TornarControlesVisiveis() NAO filtra containers ocultos: CNT_4C_SOMBRA. Estes containers tem Visible=.F. mas serao forcados a Visible=.T. pelo metodo recursivo.
- [BUSCA-CURSOR] CREATEOBJECT('FormBuscaAuxiliar') sem parametros mas NAO define this_cCursorDestino. No Modo 2 (sem params), DEVE definir this_cCursorDestino com o cursor local pre-existente ANTES de chamar Show().
- [OPTIONGROUP-LEFT] OptionGroup com ButtonCount=2 mas Buttons(2) NAO tem .Left definido. Sem .Left, todos os Buttons ficam sobrepostos no Left=0 e usuario so ve o primeiro. OBRIGATORIO definir .Left, .Top, .AutoSize, .ForeColor, .Themes em CADA Button.
- [METODO-INEXISTENTE] Metodo 'THIS.AbrirLookupCanonico()' chamado mas NAO definido como PROCEDURE no Form nem herdado de FormBase. A LLM pode ter inventado este metodo. VERIFICAR se existe no legado e IMPLEMENTAR ou REMOVER a chamada.
- [METODO-INEXISTENTE] Metodo 'THIS.ObterControleNivel()' chamado mas NAO definido como PROCEDURE no Form nem herdado de FormBase. A LLM pode ter inventado este metodo. VERIFICAR se existe no legado e IMPLEMENTAR ou REMOVER a chamada.
- [METODO-INEXISTENTE] Metodo 'THIS.ObterCursorNivel()' chamado mas NAO definido como PROCEDURE no Form nem herdado de FormBase. A LLM pode ter inventado este metodo. VERIFICAR se existe no legado e IMPLEMENTAR ou REMOVER a chamada.
- [METODO-INEXISTENTE] Metodo 'THIS.ObterTituloNivel()' chamado mas NAO definido como PROCEDURE no Form nem herdado de FormBase. A LLM pode ter inventado este metodo. VERIFICAR se existe no legado e IMPLEMENTAR ou REMOVER a chamada.
- [NULL-CURSOR] CREATE CURSOR 'cursor_4c_Itens' sem SET NULL ON antes. SQL Server retorna NULLs em muitos campos. Sem SET NULL ON, APPEND FROM falha com 'Field XXX does not accept null values'. Adicionar SET NULL ON antes e SET NULL OFF depois.
- [NULL-CURSOR] CREATE CURSOR 'cursor_4c_Locais' sem SET NULL ON antes. SQL Server retorna NULLs em muitos campos. Sem SET NULL ON, APPEND FROM falha com 'Field XXX does not accept null values'. Adicionar SET NULL ON antes e SET NULL OFF depois.
- [GRID-WITH] Bloco WITH ThisForm.grdItens define .RecordSource E acessa .Column dentro do mesmo WITH. Isso causa 'Unknown member COLUMN1' porque colunas nao sao criadas imediatamente dentro de WITH. SOLUCAO: Mover .RecordSource e .ColumnCount para FORA do WITH (usar referencia explicita: ThisForm.grdItens.RecordSource).
- [LAYOUT-POSITION] Controle 'OptOrdem' (parent: SIGOPLCL): Top original=473 vs migrado 'obj_4c_OptOrdem' Top=5 (diff=468px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'OptOrdem' (parent: SIGOPLCL): Left original=74 vs migrado 'obj_4c_OptOrdem' Left=5 (diff=69px, tolerancia=30px)

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

### FORM (C:\4c\projeto\app\forms\operacionais\FormSigOpLcl.prg) - TRECHOS RELEVANTES PARA PASS FUNCTIONAL (2158 linhas total):

*-- Linhas 22 a 87:
22: *
23: * FASE 5/8 - CAMPOS PRINCIPAIS (PARTE 1)
24: *   Entregue ate aqui: DEFINE CLASS + propriedades visuais e de estado, Init,
25: *   InicializarForm, ConfigurarCabecalho (cntSombra), ConfigurarGrid +
26: *   CarregarLista (grdItens), ConfigurarBotoes (cntBotoes/SelTudo/apaga),
27: *   ConfigurarCamposNiveis (Shape1 + Base e Segundo Nivel, com o gate de modo
28: *   em AtualizarDependenciaNiveis), TornarControlesVisiveis e Destroy.
29: *
30: * FASE 6/8 - CAMPOS RESTANTES E LOOKUPS (PARTE 2)
31: *   Acrescentado nesta fase: ConfigurarCamposNiveisParte2 (Terceiro/Quarto
32: *   Nivel + ShpFigura/ImgJpg da foto do produto), ConfigurarAcoesLocalizacao
33: *   (cmdAcoes - Localizar/Limpar Selecao), ConfigurarOrdenacao (Label5 +
34: *   OptOrdem), ConfigurarLookupsNiveis (os quatro lookups de nivel, em
35: *   LostFocus - regra #47 - com guarda de reentrancia this_lEmLookup),
36: *   AbrirBuscaBase / AbrirBuscaNivel (os DOIS funis de picker - regra #37 -
37: *   o primeiro sobre a tabela REMOTA SigLcNv1, o segundo sobre o cursor LOCAL
38: *   da hierarquia) com os resolvedores ObterControleNivel / ObterCursorNivel /
39: *   ObterTituloNivel, e
40: *   ConfigurarHandlersGrade (toggle do Check1 da coluna Marcas + foto/estado
41: *   do botao Localizar no AfterRowColChange). AtualizarDependenciaNiveis foi
42: *   estendido para gatear tambem Terceiro e Quarto Nivel.
43: *
44: * FASE 8/8 - CONSOLIDACAO FINAL
45: *   Acrescentado nesta fase os tres funis canonicos que ate aqui estavam
46: *   espalhados pelos handlers, cada um com referente EXPLICITO no SCX legado:
47: *     CarregarLista() - era VincularGrade; eh a transcricao do "PROCEDURE
48: *       montagrade" legado (bind + Index on cItens + Refresh). PUBLIC, porque
49: *       eh o funil de recarga e o harness o aciona de fora (regra #3).
50: *     FormParaBO()    - o bloco lcLoc1..lcLoc4 do inicio do btnLocalizar.Click,
51: *       agora cobrindo tambem as quatro descricoes (que o BO declarava e
52: *       ninguem alimentava). Ponto UNICO de travessia tela -> BO.
53: *     BOParaForm()    - sentido inverso; recarrega os oito campos a partir do
54: *       estado do BO, usado pelos dois caminhos que limpam a selecao
55: *       (fim do btnLocalizar.Click e btnLimpar.Click).
56: *   Os dois hooks sao PROTECTED EXPLICITO - FormBase os declara PROTECTED e o
57: *   VFP9 nao deixa a subclasse alargar escopo herdado.
58: *
59: *   O QUE ESTE FORM NAO TEM, e por que:
60: *     - barra CRUD (os cinco botoes de cadastro) e os dois botoes da Page2 de
61: *       Dados: o SCX eh "Class: form" puro, sem frmcadastro e sem Grupo_Op; o
62: *       modo (pcEscolha) CHEGA do chamador por parametro, nao eh escolhido
63: *       aqui. Os botoes reais sao os seis do dump, todos com handler.
64: *     - Ajustar<...>PorModo / Habilitar<...>: o gate de modo do legado eh o
65: *       "When" de cada campo e de cada botao, e esta reproduzido em
66: *       AtualizarDependenciaNiveis + this_lPodeEditar.
67: *     - Limpar<...>: a limpeza dos oito campos eh BOParaForm sobre
68: *       SigOpLclBO.LimparNiveis(), fonte unica dos dois caminhos acima.
69: *==============================================================================
70: 
71: DEFINE CLASS FormSigOpLcl AS FormBase
72: 
73:     *-- Propriedades visuais transcritas do SCX legado (PILAR 1)
74:     this_cMensagemErro = ""
75:     Width        = 968
76:     Height       = 500
77:     AutoCenter   = .T.
78:     ShowTips     = .T.
79:     BorderStyle  = 2
80:     Caption      = "Sele" + CHR(231) + CHR(227) + "o de Localiza" + CHR(231) + CHR(227) + "o"
81:     ShowWindow = 1
82:     ControlBox   = .F.
83:     Closable     = .F.
84:     MaxButton    = .F.
85:     MinButton    = .F.
86:     Movable      = .F.
87:     ClipControls = .F.

*-- Linhas 124 a 228:
124:     * antes de montar a tela).
125:     *
126:     * Os parametros vem do form PAI e NAO existem no harness de teste
127:     * (TestFormWrapper faz CREATEOBJECT sem argumento nenhum), por isso a
128:     * leitura eh toda guardada por VARTYPE/PCOUNT e NENHUMA ausencia derruba
129:     * o Init - devolver .F. aqui faria CREATEOBJECT devolver .F. logico.
130:     *==========================================================================
131:     PROCEDURE Init(par_oCnx, par_cEscolha, par_cOrigem)
132:         LOCAL loc_lResultado
133:         loc_lResultado = .F.
134: 
135:         *-- poDataMgr: guardado por fidelidade ao contrato do legado
136:         THIS.this_oConexao = IIF(VARTYPE(par_oCnx) = "O", par_oCnx, .NULL.)
137: 
138:         *-- pcEscolha: modo da tela chamadora
139:         IF PCOUNT() >= 2 AND VARTYPE(par_cEscolha) = "C"
140:             THIS.this_cEscolha = ALLTRIM(UPPER(par_cEscolha))
141:         ENDIF
142: 
143:         *-- pcOrigem: define qual coluna de crTpmMvItn recebe a localizacao
144:         IF PCOUNT() >= 3 AND VARTYPE(par_cOrigem) = "C"
145:             THIS.this_cOrigem = ALLTRIM(UPPER(par_cOrigem))
146:         ENDIF
147: 
148:         *-- Equivalente ao When do legado: so INSERIR/ALTERAR editam
149:         THIS.this_lPodeEditar = INLIST(THIS.this_cEscolha, "INSERIR", "ALTERAR")
150: 
151:         *-- OptOrdem nasce com Value = 1 (Produto) no SCX
152:         THIS.this_nOrdemAtual = 1
153: 
154:         loc_lResultado = DODEFAULT()
155: 
156:         RETURN loc_lResultado
157:     ENDPROC
158: 
159:     *==========================================================================
160:     * InicializarForm - instancia o BO, monta a casca da tela e carrega os
161:     *                   cursores de trabalho
162:     *
163:     * Ordem de montagem (fiel ao Init legado):
164:     *   1. BO (SigOpLclBO) - dono dos cursores e das regras
165:     *   2. cursor de localizacoes escolhidas (csLocals do legado)
166:     *   3. itens do movimento a partir de crTpmMvItn (crItensLoc do legado)
167:     *   4. hierarquia de niveis + expansao do XML (crSigLcNv2..4 do legado)
168:     *   5. cabecalho (cntSombra do legado)
169:     *   6. grade de itens (grdItens do legado - estrutura, depois bind)
170:     *   7. botoes de acao (cntBotoes/SelTudo/apaga do legado)
171:     *   8. campos da localizacao (Shape1 + Base/Segundo Nivel do legado)
172:     *
173:     * Os passos 3 e 4 dependem de recursos EXTERNOS (o cursor do form
174:     * chamador e a conexao com o SQL Server). A ausencia deles NAO derruba a
175:     * tela: o Init legado tambem segue adiante, e no harness de teste nem o
176:     * cursor nem a conexao existem. Quem depende do dado valida na hora de
177:     * gravar (ValidarDados/Inserir do BO).
178:     *==========================================================================
179:     PROTECTED PROCEDURE InicializarForm()
180:         LOCAL loc_lSucesso, loc_oErro
181:         loc_lSucesso = .F.
182: 
183:         TRY
184:             *-- 1. Business Object
185:             THIS.this_oBusinessObject = CREATEOBJECT("SigOpLclBO")
186: 
187:             IF VARTYPE(THIS.this_oBusinessObject) = "O"
188: 
189:                 *-- Propaga o contexto recebido do chamador para o BO
190:                 THIS.this_oBusinessObject.this_cEscolha = THIS.this_cEscolha
191:                 THIS.this_oBusinessObject.this_cOrigem  = THIS.this_cOrigem
192: 
193:                 *-- 2. Cursor das localizacoes escolhidas (csLocals do legado)
194:                 THIS.this_oBusinessObject.CriarCursorLocalizacoes()
195: 
196:                 *-- 3. Itens do movimento (crItensLoc do legado). Devolve .F.
197:                 *--    quando crTpmMvItn nao esta aberto - situacao normal no
198:                 *--    harness e tratada pelo BO, nao impede abrir a tela.
199:                 THIS.this_oBusinessObject.CarregarItens(THIS.this_cOrigem)
200: 
201:                 *-- 4. Hierarquia de niveis + expansao do XML de cada nivel
202:                 THIS.this_oBusinessObject.CarregarNiveis()
203: 
204:                 *-- 5. Cabecalho (cntSombra legado, com os dois labels)
205:                 THIS.ConfigurarCabecalho()
206: 
207:                 *-- Caption propagado para os labels do cabecalho, igual as
208:                 *-- duas primeiras linhas do Init legado
209:                 THIS.cnt_4c_Sombra.lbl_4c_LblSombra.Caption = THIS.Caption
210:                 THIS.cnt_4c_Sombra.lbl_4c_LblTitulo.Caption = THIS.Caption
211: 
212:                 *-- 6. Grade de itens: estrutura primeiro, bind depois (o
213:                 *--    bind depende de cursor_4c_Itens, que so existe apos
214:                 *--    o passo 3 ter rodado)
215:                 THIS.ConfigurarGrid()
216:                 THIS.CarregarLista()
217: 
218:                 *-- 7. Botoes de acao (Confirmar/Cancelar + Selecionar/
219:                 *--    Desmarcar tudo)
220:                 THIS.ConfigurarBotoes()
221: 
222:                 *-- 8. Campos da localizacao (Shape1 + Base e Segundo Nivel)
223:                 THIS.ConfigurarCamposNiveis()
224: 
225:                 *-- 8b. Campos da localizacao, parte 2 (Terceiro/Quarto Nivel
226:                 *--     + ShpFigura/ImgJpg da foto do produto)
227:                 THIS.ConfigurarCamposNiveisParte2()
228: 

*-- Linhas 238 a 316:
238:                 *-- 12. Handlers da grade (toggle do Check1 + AfterRowColChange)
239:                 THIS.ConfigurarHandlersGrade()
240: 
241:                 THIS.TornarControlesVisiveis(THIS)
242: 
243:                 loc_lSucesso = .T.
244:             ELSE
245:                 THIS.this_cMensagemErro = "N" + CHR(227) + "o foi poss" + CHR(237) + ;
246:                     "vel criar o objeto de neg" + CHR(243) + "cio SigOpLclBO."
247:                 MsgErro(THIS.this_cMensagemErro, "Erro")
248:             ENDIF
249: 
250:         CATCH TO loc_oErro
251:             THIS.this_cMensagemErro = loc_oErro.Message
252:             MsgErro("Erro ao inicializar a tela de Sele" + CHR(231) + CHR(227) + ;
253:                     "o de Localiza" + CHR(231) + CHR(227) + "o:" + CHR(13) + ;
254:                     loc_oErro.Message + CHR(13) + ;
255:                     "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
256:                     "Procedure: " + loc_oErro.Procedure, "Erro")
257:             loc_lSucesso = .F.
258:         ENDTRY
259: 
260:         RETURN loc_lSucesso
261:     ENDPROC
262: 
263:     *==========================================================================
264:     * ConfigurarCabecalho - faixa cinza do titulo (cntSombra do SCX legado)
265:     *
266:     * Geometria e cores transcritas do dump:
267:     *   cntSombra  Top=0 Left=0 Width=968 Height=80 BackColor=100,100,100
268:     *   lblSombra  Top=18 Left=10 Width=769 Height=40 ForeColor=0,0,0
269:     *   lblTitulo  Top=17 Left=10 Width=769 Height=46 ForeColor=255,255,255
270:     *
271:     * Os dois labels sao a sombra e o texto do mesmo titulo (o preto desenha
272:     * 1px abaixo do branco). AutoSize = .F. explicito: em Label criado por
273:     * AddObject o AutoSize eh no-op e com WordWrap = .T. ele ainda descarta a
274:     * Height - a geometria do SCX ja eh o auto-size calculado pelo Designer.
275:     *==========================================================================
276:     PROTECTED PROCEDURE ConfigurarCabecalho()
277:         LOCAL loc_oCnt
278: 
279:         THIS.AddObject("cnt_4c_Sombra", "Container")
280:         loc_oCnt = THIS.cnt_4c_Sombra
281: 
282:         WITH loc_oCnt
283:             .Top           = 0
284:             .Left          = 0
285:             .Width         = THIS.Width
286:             .Height        = 80
287:             .BorderWidth   = 0
288:             .BackStyle     = 1
289:             .BackColor     = RGB(100, 100, 100)
290:             .SpecialEffect = 0
291:             .Visible       = .T.
292:         ENDWITH
293: 
294:         loc_oCnt.AddObject("lbl_4c_LblSombra", "Label")
295:         WITH loc_oCnt.lbl_4c_LblSombra
296:             .FontBold      = .T.
297:             .FontName      = "Tahoma"
298:             .FontSize      = 18
299:             .FontUnderline = .F.
300:             .WordWrap      = .T.
301:             .Alignment     = 0
302:             .BackStyle     = 0
303:             .AutoSize      = .F.
304:             .Caption       = THIS.Caption
305:             .Top           = 18
306:             .Left          = 10
307:             .Width         = 769
308:             .Height        = 40
309:             .ForeColor     = RGB(0, 0, 0)
310:             .Visible       = .T.
311:         ENDWITH
312: 
313:         loc_oCnt.AddObject("lbl_4c_LblTitulo", "Label")
314:         WITH loc_oCnt.lbl_4c_LblTitulo
315:             .FontBold    = .T.
316:             .FontName    = "Tahoma"

*-- Linhas 338 a 400:
338:     * Geometria e colunas transcritas do dump. ColumnOrder define a ordem
339:     * VISUAL das colunas (1=Marcas, 2=#, 3=Produto, 4=Descricao, 5=
340:     * Localizacao) - diferente da ordem de CRIACAO (Column1..5), que segue
341:     * a ordem do SCX.
342:     *
343:     * NAO vincula RecordSource/ControlSource aqui: cursor_4c_Itens so existe
344:     * depois de SigOpLclBO.CarregarItens() rodar, e Column.ControlSource de
345:     * cursor ainda ausente derruba o Init. O bind fica em CarregarLista(),
346:     * chamado depois na mesma ordem de InicializarForm.
347:     *==========================================================================
348:     PROTECTED PROCEDURE ConfigurarGrid()
349:         LOCAL loc_oGrid
350: 
351:         THIS.AddObject("grd_4c_Dados", "Grid")
352:         loc_oGrid = THIS.grd_4c_Dados
353: 
354:         *-- DESFAZER o auto-bind ANTES de mexer em ColumnCount. Grid nasce com
355:         *-- RecordSourceType = 1 (Alias) e o VFP9 o liga sozinho ao alias da
356:         *-- WORK AREA CORRENTE - aqui a dos cursores que o BO acabou de montar
357:         *-- (medido: RecordSource=[Cursor_4c_LcNv4], ColumnCount=2). Com a
358:         *-- coluna ja vinculada a um campo CHAR, o AddObject do CheckBox em
359:         *-- Column3 estoura "Error with CHK_4C_MARCAS - Value : Data type
360:         *-- mismatch", InicializarForm devolve .F. e a TELA NAO ABRE.
361:         loc_oGrid.RecordSourceType = 1
362:         loc_oGrid.RecordSource     = ""
363: 
364:         WITH loc_oGrid
365:             .Top           = 87
366:             .Left          = 12
367:             .Width         = 575
368:             .Height        = 387
369:             .FontName      = "Tahoma"
370:             .FontSize      = 8
371:             .DeleteMark    = .F.
372:             .RecordMark    = .F.
373:             .RowHeight     = 16
374:             .ScrollBars    = 2
375:             .TabIndex      = 1
376:             .GridLineColor = RGB(238, 238, 238)
377:             .ColumnCount   = 5
378:             .ReadOnly      = .F.
379:             .Visible       = .T.
380:         ENDWITH
381: 
382:         *-- Column1 - Produto (Cpros). ColumnOrder=3 (3a posicao visual)
383:         WITH loc_oGrid.Column1
384:             .FontName          = "Tahoma"
385:             .FontSize          = 8
386:             .ColumnOrder       = 3
387:             .Width             = 122
388:             .Movable           = .F.
389:             .Resizable         = .F.
390:             .Header1.FontName  = "Tahoma"
391:             .Header1.FontSize  = 8
392:             .Header1.Alignment = 2
393:             .Header1.Caption   = "Produto"
394:             .Text1.FontName    = "Tahoma"
395:             .Text1.FontSize    = 8
396:             .Text1.Alignment   = 3
397:             .Text1.BorderStyle = 0
398:             .Text1.Margin      = 0
399:             .Text1.ReadOnly    = .F.
400:             .Text1.ForeColor   = RGB(0, 0, 0)

*-- Linhas 445 a 493:
445:             .FontName  = "Tahoma"
446:             .FontSize  = 8
447:             .Alignment = 0
448:             .Caption   = ""
449:             *-- .Value NUMERICO e OBRIGATORIO: CheckBox nasce com .Value
450:             *-- LOGICO (.F.) e a coluna ligada eh cursor_4c_Itens.Marcas
451:             *-- N(1,0). Sem esta linha o bind de Column3.ControlSource
452:             *-- estoura "Error with CHK_4C_MARCAS - Value : Data type
453:             *-- mismatch", InicializarForm devolve .F. e CREATEOBJECT
454:             *-- devolve .F. logico - a tela nao abre.
455:             .Value     = 0
456:             .Visible   = .T.
457:         ENDWITH
458:         loc_oGrid.Column3.CurrentControl = "chk_4c_Marcas"
459:         loc_oGrid.Column3.Sparse         = .F.
460:         loc_oGrid.Column3.ReadOnly       = .F.
461: 
462:         *-- Column4 - numero do item (cItens). ColumnOrder=2
463:         WITH loc_oGrid.Column4
464:             .FontName          = "Tahoma"
465:             .FontSize          = 8
466:             .ColumnOrder       = 2
467:             .Width             = 25
468:             .Movable           = .F.
469:             .Resizable         = .F.
470:             .Header1.FontName  = "Tahoma"
471:             .Header1.FontSize  = 8
472:             .Header1.Alignment = 2
473:             .Header1.Caption   = "#"
474:             .Text1.FontName    = "Tahoma"
475:             .Text1.FontSize    = 8
476:             .Text1.BorderStyle = 0
477:             .Text1.Margin      = 0
478:             .Text1.ReadOnly    = .T.
479:             .Text1.ForeColor   = RGB(0, 0, 0)
480:             .Text1.BackColor   = RGB(255, 255, 255)
481:         ENDWITH
482: 
483:         *-- Column5 - localizacao atribuida (Locals). ColumnOrder default (5)
484:         WITH loc_oGrid.Column5
485:             .FontName          = "Tahoma"
486:             .FontSize          = 8
487:             .Width             = 95
488:             .Movable           = .F.
489:             .Resizable         = .F.
490:             .Header1.FontName  = "Tahoma"
491:             .Header1.FontSize  = 8
492:             .Header1.Alignment = 2
493:             .Header1.Caption   = "Localiza" + CHR(231) + CHR(227) + "o"

*-- Linhas 506 a 642:
506:     *==========================================================================
507:     * CarregarLista - FUNIL UNICO de carga/repintura da grade de itens
508:     *
509:     * Eh a transcricao do "PROCEDURE montagrade" do SCX legado, que faz
510:     * exatamente isto e nada mais:
511:     *     Select crItensLoc / Index on cItens Tag cItens / Go top
512:     *     With ThisForm.grdItens
513:     *         .RecordSource = [crItensLoc]
514:     *         .column1..column5.ControlSource = [crItensLoc.<coluna>]
515:     *         .Refresh()
516:     *     EndWith
517:     *     ThisForm.grdItens.Column1.SetFocus / .Refresh
518:     *
519:     * O nome canonico do projeto para esse funil eh CarregarLista (o legado
520:     * chama de montagrade), e ele eh PUBLIC de proposito (regra #3): o
521:     * harness de teste o aciona de FORA da classe, e tambem o btnLimpar do
522:     * legado o chama como ponto de recarga.
523:     *
524:     * Chamada DEPOIS de SigOpLclBO.CarregarItens() rodar. Se o cursor nao
525:     * existe (crTpmMvItn fechado - sem form chamador, caso do harness de
526:     * teste), cria um placeholder com a MESMA estrutura da SELECT do BO
527:     * (regra "cursor placeholder = cursor real"), para a grade sempre ter
528:     * um alias valido para ligar.
529:     *
530:     * RecordSource reseta Width/Header1.Caption/CurrentControl/Sparse das
531:     * colunas (Problema 48 do projeto / regra #18) - por isso sao
532:     * reaplicados abaixo, na ordem canonica: ColumnCount -> RecordSource ->
533:     * ControlSource -> Width -> Header.Caption.
534:     *==========================================================================
535:     PROCEDURE CarregarLista()
536:         LOCAL loc_oGrid
537: 
538:         IF !USED("cursor_4c_Itens")
539:             CREATE CURSOR cursor_4c_Itens (Marcas N(1, 0), Cpros C(14), ;
540:                 Dpros C(65), cItens N(10, 0), Locals C(10), Categoria C(6))
541:         ENDIF
542: 
543:         loc_oGrid = THIS.grd_4c_Dados
544: 
545:         *-- Column3 volta para o Text1 ANTES do bind: atribuir RecordSource
546:         *-- auto-vincula cada coluna ao campo de MESMA POSICAO do cursor, e a
547:         *-- 3a eh Dpros (char). Com o CheckBox ainda sendo o CurrentControl,
548:         *-- esse vinculo intermediario estoura Data type mismatch. O
549:         *-- CurrentControl eh reposto no fim, depois do ControlSource certo.
550:         loc_oGrid.Column3.CurrentControl = "Text1"
551: 
552:         loc_oGrid.RecordSource = ""
553:         loc_oGrid.RecordSource = "cursor_4c_Itens"
554:         loc_oGrid.Column1.ControlSource = "cursor_4c_Itens.Cpros"
555:         loc_oGrid.Column2.ControlSource = "cursor_4c_Itens.Dpros"
556:         loc_oGrid.Column3.ControlSource = "cursor_4c_Itens.Marcas"
557:         loc_oGrid.Column4.ControlSource = "cursor_4c_Itens.cItens"
558:         loc_oGrid.Column5.ControlSource = "cursor_4c_Itens.Locals"
559: 
560:         loc_oGrid.Column1.Width           = 122
561:         loc_oGrid.Column1.Header1.Caption = "Produto"
562: 
563:         loc_oGrid.Column2.Width           = 290
564:         loc_oGrid.Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
565: 
566:         loc_oGrid.Column3.Width           = 17
567:         loc_oGrid.Column3.Header1.Caption = ""
568:         loc_oGrid.Column3.CurrentControl  = "chk_4c_Marcas"
569:         loc_oGrid.Column3.Sparse          = .F.
570: 
571:         loc_oGrid.Column4.Width           = 25
572:         loc_oGrid.Column4.Header1.Caption = "#"
573: 
574:         loc_oGrid.Column5.Width           = 95
575:         loc_oGrid.Column5.Header1.Caption = "Localiza" + CHR(231) + CHR(227) + "o"
576: 
577:         *-- "Index on cItens Tag cItens" do montagrade legado: a ordem volta
578:         *-- para o numero do item a cada recarga (o OptOrdem reindexa depois,
579:         *-- em OrdenarItens). O tag so existe quando o cursor veio de
580:         *-- CarregarItens - no placeholder do harness nao ha tag nenhum, e
581:         *-- SET ORDER TO TAG num cursor sem tag estoura.
582:         SELECT cursor_4c_Itens
583:         IF TAGNO("cItens", "", "cursor_4c_Itens") > 0
584:             SET ORDER TO TAG cItens
585:         ENDIF
586:         GO TOP
587:         loc_oGrid.Refresh()
588: 
589:         RETURN .T.
590:     ENDPROC
591: 
592:     *==========================================================================
593:     * ConfigurarBotoes - Confirmar/Cancelar (cntBotoes) + Selecionar/
594:     * Desmarcar tudo (SelTudo/apaga) do SCX legado
595:     *
596:     * Este dialogo NAO tem botoes CRUD (Incluir/Alterar/Excluir/Buscar) - o
597:     * legado so tem estes quatro botoes de acao, porque a tela eh um popup
598:     * de selecao e nao um cadastro. Localizar/Limpar Selecao (cmdAcoes) e a
599:     * ordenacao (OptOrdem) dependem dos campos de nivel (getBase/getNvl2..4),
600:     * que entram em fase posterior - ficam de fora deste metodo de proposito.
601:     *==========================================================================
602:     PROTECTED PROCEDURE ConfigurarBotoes()
603: 
604:         *-- cntBotoes legado: Confirmar (Buttons(2)/Command2) e Cancelar
605:         *-- (Buttons(1)/Command1), lado direito da tela
606:         THIS.AddObject("obj_4c_CntBotoes", "CommandGroup")
607:         WITH THIS.obj_4c_CntBotoes
608:             .Top           = -3
609:             .Left          = 812
610:             .Width         = 160
611:             .Height        = 85
612:             .ButtonCount   = 2
613:             .BackStyle     = 0
614:             .BorderStyle   = 0
615:             .SpecialEffect = 1
616:             .BorderColor   = RGB(136, 189, 188)
617:             .Value         = 0
618:             .TabIndex      = 3
619:             .Themes        = .F.
620: 
621:             WITH .Buttons(1)
622:                 .Top           = 5
623:                 .Left          = 80
624:                 .Width         = 75
625:                 .Height        = 75
626:                 .Caption       = "\<Cancelar"
627:                 .FontName      = "Comic Sans MS"
628:                 .FontSize      = 8
629:                 .FontBold      = .T.
630:                 .FontItalic    = .T.
631:                 .WordWrap      = .T.
632:                 .Picture       = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
633:                 .Cancel        = .T.
634:                 .MousePointer  = 15
635:                 .TabIndex      = 2
636:                 .ToolTipText   = "[Esc] Encerrar"
637:                 .SpecialEffect = 0
638:                 .ForeColor     = RGB(90, 90, 90)
639:                 .BackColor     = RGB(255, 255, 255)
640:                 .Themes        = .F.
641:             ENDWITH
642: 

*-- Linhas 661 a 792:
661:             ENDWITH
662:         ENDWITH
663: 
664:         BINDEVENT(THIS.obj_4c_CntBotoes.Buttons(1), "Click", THIS, "BtnCancelarClick")
665:         BINDEVENT(THIS.obj_4c_CntBotoes.Buttons(2), "Click", THIS, "BtnConfirmarClick")
666: 
667:         *-- SelTudo/apaga: standalone, ao lado da grade. Picture e ToolTip
668:         *-- transcritos do dump (regra #25 - NUNCA inventar nome de icone)
669:         THIS.AddObject("cmd_4c_SelTudo", "CommandButton")
670:         WITH THIS.cmd_4c_SelTudo
671:             .Top             = 220
672:             .Left            = 590
673:             .Width           = 45
674:             .Height          = 40
675:             .Caption         = ""
676:             .FontName        = "Verdana"
677:             .FontSize        = 8
678:             .Picture         = gc_4c_CaminhoIcones + "geral_marcar_26.jpg"
679:             .DisabledPicture = gc_4c_CaminhoIcones + "geral_marcar_26.jpg"
680:             .Themes          = .T.
681:             .TabStop         = .F.
682:             .ToolTipText     = "Selecionar"
683:             .ForeColor       = RGB(36, 84, 155)
684:             .BackColor       = RGB(255, 255, 255)
685:         ENDWITH
686:         BINDEVENT(THIS.cmd_4c_SelTudo, "Click", THIS, "BtnSelTudoClick")
687: 
688:         THIS.AddObject("cmd_4c_Apaga", "CommandButton")
689:         WITH THIS.cmd_4c_Apaga
690:             .Top             = 261
691:             .Left            = 590
692:             .Width           = 45
693:             .Height          = 40
694:             .Caption         = ""
695:             .FontName        = "Verdana"
696:             .FontSize        = 8
697:             .Picture         = gc_4c_CaminhoIcones + "cadastro_excluir_26.jpg"
698:             .DisabledPicture = gc_4c_CaminhoIcones + "cadastro_excluir_26.jpg"
699:             .Themes          = .T.
700:             .TabStop         = .F.
701:             .ToolTipText     = "Desmarcar"
702:             .ForeColor       = RGB(36, 84, 155)
703:             .BackColor       = RGB(255, 255, 255)
704:         ENDWITH
705:         BINDEVENT(THIS.cmd_4c_Apaga, "Click", THIS, "BtnApagaClick")
706: 
707:         RETURN .T.
708:     ENDPROC
709: 
710:     *==========================================================================
711:     * ConfigurarCamposNiveis - bloco da localizacao, PARTE 1 (Base e 2o nivel)
712:     *
713:     * Transcricao do dump do SCX legado, objeto a objeto:
714:     *   Shape1    Top= 87 Left=646 W=292 H=196 BackStyle=0  (moldura do bloco)
715:     *   Label3    Top= 89 Left=682 W= 25 H= 15 "Base"           ForeColor 90,90,90
716:     *   getBase   Top=107 Left=682 W= 54 H= 24 SpecialEffect=1  TabIndex=5
717:     *   getDBase  Top=107 Left=737 W=174 H= 24 SpecialEffect=1  TabIndex=6
718:     *   Label1    Top=134 Left=682 W= 70 H= 15 "Segundo Nivel"  ForeColor 90,90,90
719:     *   getNvl2   Top=152 Left=682 W= 54 H= 24 SpecialEffect=1  TabIndex=8
720:     *   getDNvl2  Top=152 Left=737 W=174 H= 24 SpecialEffect=1  TabIndex=9
721:     *
722:     * A moldura (Shape1) eh o PRIMEIRO AddObject do metodo: ela cobre toda a
723:     * area do bloco e precisa desenhar ATRAS dos labels e das caixas de texto.
724:     * Shape nao tem ForeColor (a cor dele mora em BorderColor/FillColor) e o
725:     * dump nao declara nenhuma das duas - nada a transcrever.
726:     *
727:     * Labels: o dump declara AutoSize = .T., mas em Label criado por AddObject
728:     * o AutoSize eh no-op e com WordWrap ele ainda descarta a Height, por isso
729:     * vai .AutoSize = .F. com a Width E a Height do SCX, que JA SAO o auto-size
730:     * calculado pelo Form Designer. O Alignment fica em 0 (a classe say do
731:     * legado eh alinhada a esquerda) e o ForeColor eh o RGB(90, 90, 90) do
732:     * dump: branco sobre o fundo claro do form ficaria invisivel.
733:     *
734:     * MaxLength vem da LARGURA DA COLUNA no schema, nunca do Width em pixels:
735:     *   SigLcNv1.cods  char(2)  -> txt_4c_Base  = 2
736:     *   SigLcNv1.descs char(20) -> txt_4c_DBase = 20
737:     *   SigLcNv2.cods  char(2)  -> txt_4c_Nvl2  = 2
738:     *   SigLcNv2.descs char(20) -> txt_4c_DNvl2 = 20
739:     * O cursor de nivel expoe o codigo na coluna calculada Codigo, mas o valor
740:     * que o usuario digita eh o cods da tabela - sao as mesmas larguras que
741:     * SigOpLclBO.MontarLocalizacao soma (2+2+2+4) para caber nos 10 chars de
742:     * SigMvItn.locals.
743:     *
744:     * O dump NAO declara Format nem InputMask em nenhuma destas caixas: nada a
745:     * transcrever, e inventar mascara mudaria o que o usuario pode digitar.
746:     *
747:     * Os dois campos de DESCRICAO sao somente-leitura por decisao do legado -
748:     * getDBase.When e getDNvl2.When fazem "Return .F.", ou seja o usuario nunca
749:     * alcanca esses campos; eles recebem valor apenas pelo lookup do codigo ao
750:     * lado. Migrado como ReadOnly = .T. + TabStop = .F.
751:     *==========================================================================
752:     PROTECTED PROCEDURE ConfigurarCamposNiveis()
753: 
754:         *-- Shape1: moldura do bloco de localizacao (transparente, so borda)
755:         THIS.AddObject("shp_4c_Shape1", "Shape")
756:         WITH THIS.shp_4c_Shape1
757:             .Top       = 87
758:             .Left      = 646
759:             .Width     = 292
760:             .Height    = 196
761:             .BackStyle = 0
762:             .Visible   = .T.
763:         ENDWITH
764: 
765:         *-- Label3 + getBase + getDBase: nivel 1 (Base), de SigLcNv1
766:         THIS.AddObject("lbl_4c_Label3", "Label")
767:         WITH THIS.lbl_4c_Label3
768:             .FontName  = "Tahoma"
769:             .FontSize  = 8
770:             .AutoSize  = .F.
771:             .BackStyle = 0
772:             .Alignment = 0
773:             .Caption   = "Base"
774:             .Top       = 89
775:             .Left      = 682
776:             .Width     = 25
777:             .Height    = 15
778:             .TabIndex  = 4
779:             .ForeColor = RGB(90, 90, 90)
780:             .Visible   = .T.
781:         ENDWITH
782: 
783:         THIS.AddObject("txt_4c_Base", "TextBox")
784:         WITH THIS.txt_4c_Base
785:             .FontName      = "Verdana"
786:             .FontSize      = 8
787:             .Value         = ""
788:             .MaxLength     = 2
789:             .Margin        = 3
790:             .SpecialEffect = 1
791:             .Top           = 107
792:             .Left          = 682

*-- Linhas 902 a 948:
902:     * ImgJpg nasce Visible = .F. (dump legado) e fica assim ate o
903:     * AfterRowColChange da grade decidir se ha foto para a linha corrente -
904:     * por isso o nome do controle (img_4c_ImgJpg) ja esta na lista de EXCECAO
905:     * de TornarControlesVisiveis (regra da tela nao forcar visivel o que o
906:     * legado mantem oculto).
907:     *==========================================================================
908:     PROTECTED PROCEDURE ConfigurarCamposNiveisParte2()
909: 
910:         *-- Label2 + getNvl3 + getDNvl3: nivel 3, de SigLcNv3
911:         THIS.AddObject("lbl_4c_Label2", "Label")
912:         WITH THIS.lbl_4c_Label2
913:             .FontName  = "Tahoma"
914:             .FontSize  = 8
915:             .AutoSize  = .F.
916:             .BackStyle = 0
917:             .Alignment = 0
918:             .Caption   = "Terceiro N" + CHR(237) + "vel"
919:             .Top       = 183
920:             .Left      = 682
921:             .Width     = 67
922:             .Height    = 15
923:             .TabIndex  = 10
924:             .ForeColor = RGB(90, 90, 90)
925:             .Visible   = .T.
926:         ENDWITH
927: 
928:         THIS.AddObject("txt_4c_Nvl3", "TextBox")
929:         WITH THIS.txt_4c_Nvl3
930:             .FontName      = "Verdana"
931:             .FontSize      = 8
932:             .Value         = ""
933:             .MaxLength     = 2
934:             .Margin        = 3
935:             .SpecialEffect = 1
936:             .Top           = 201
937:             .Left          = 682
938:             .Width         = 54
939:             .Height        = 24
940:             .TabIndex      = 11
941:             .ToolTipText   = "Terceiro N" + CHR(237) + "vel da Localiza" + ;
942:                              CHR(231) + CHR(227) + "o"
943:             .Visible       = .T.
944:         ENDWITH
945: 
946:         THIS.AddObject("txt_4c_DNvl3", "TextBox")
947:         WITH THIS.txt_4c_DNvl3
948:             .FontName      = "Verdana"

*-- Linhas 1060 a 1103:
1060:     * When para os dois (InList(pcEscolha,'INSERIR','ALTERAR')), mas so
1061:     * btnLocalizar.When tem a segunda condicao de item marcado.
1062:     *==========================================================================
1063:     PROTECTED PROCEDURE ConfigurarAcoesLocalizacao()
1064: 
1065:         THIS.AddObject("obj_4c_CmdAcoes", "CommandGroup")
1066:         WITH THIS.obj_4c_CmdAcoes
1067:             .Top           = -3
1068:             .Left          = 662
1069:             .Width         = 160
1070:             .Height        = 85
1071:             .ButtonCount   = 2
1072:             .BackStyle     = 0
1073:             .BorderStyle   = 0
1074:             .SpecialEffect = 1
1075:             .BorderColor   = RGB(136, 189, 188)
1076:             .Value         = 0
1077:             .TabIndex      = 2
1078:             .Themes        = .F.
1079: 
1080:             WITH .Buttons(1)
1081:                 .Top           = 5
1082:                 .Left          = 80
1083:                 .Width         = 75
1084:                 .Height        = 75
1085:                 .Caption       = "\<Localizar"
1086:                 .FontName      = "Comic Sans MS"
1087:                 .FontSize      = 8
1088:                 .FontBold      = .T.
1089:                 .FontItalic    = .T.
1090:                 .WordWrap      = .T.
1091:                 .Picture       = gc_4c_CaminhoIcones + "cadastro_inserir_60.jpg"
1092:                 .Cancel        = .T.
1093:                 .MousePointer  = 15
1094:                 .TabIndex      = 2
1095:                 .ToolTipText   = "[Esc] Encerrar"
1096:                 .SpecialEffect = 0
1097:                 .ForeColor     = RGB(90, 90, 90)
1098:                 .BackColor     = RGB(255, 255, 255)
1099:                 .Themes        = .F.
1100:                 .Enabled       = THIS.this_lPodeEditar
1101:             ENDWITH
1102: 
1103:             WITH .Buttons(2)

*-- Linhas 1122 a 1736:
1122:             ENDWITH
1123:         ENDWITH
1124: 
1125:         BINDEVENT(THIS.obj_4c_CmdAcoes.Buttons(1), "Click", THIS, "BtnLocalizarClick")
1126:         BINDEVENT(THIS.obj_4c_CmdAcoes.Buttons(2), "Click", THIS, "BtnLimparClick")
1127: 
1128:         RETURN .T.
1129:     ENDPROC
1130: 
1131:     *==========================================================================
1132:     * ConfigurarOrdenacao - Label5 + OptOrdem (ordenacao da grade de itens)
1133:     *
1134:     * Geometria transcrita do dump:
1135:     *   Label5   Top=479 Left=13 W=65 H=15 "Ordenacao : " ForeColor 90,90,90
1136:     *   OptOrdem Top=473 Left=74 W=130 H=25 ButtonCount=2 Value=1
1137:     *     Option1 "Produto" Left=5  Top=5 W=56 H=15 (Value=1 - default)
1138:     *     Option2 "Colecao" Left=69 Top=5 W=56 H=15
1139:     *
1140:     * OptOrdem.Value = 1 -> ordena por Cpros; 2 -> ordena por Categoria
1141:     * (SigOpLclBO.OrdenarItens, transcricao do OptOrdem.Valid legado).
1142:     *==========================================================================
1143:     PROTECTED PROCEDURE ConfigurarOrdenacao()
1144: 
1145:         THIS.AddObject("lbl_4c_Label5", "Label")
1146:         WITH THIS.lbl_4c_Label5
1147:             .FontName  = "Tahoma"
1148:             .FontSize  = 8
1149:             .AutoSize  = .F.
1150:             .BackStyle = 0
1151:             .Alignment = 0
1152:             .Caption   = "Ordena" + CHR(231) + CHR(227) + "o : "
1153:             .Top       = 479
1154:             .Left      = 13
1155:             .Width     = 65
1156:             .Height    = 15
1157:             .ForeColor = RGB(90, 90, 90)
1158:             .Visible   = .T.
1159:         ENDWITH
1160: 
1161:         THIS.AddObject("obj_4c_OptOrdem", "OptionGroup")
1162:         WITH THIS.obj_4c_OptOrdem
1163:             .Top         = 473
1164:             .Left        = 74
1165:             .Width       = 130
1166:             .Height      = 25
1167:             .ButtonCount = 2
1168:             .BackStyle   = 0
1169:             .BorderStyle = 0
1170:             .Value       = 1
1171:             .Visible     = .T.
1172: 
1173:             WITH .Buttons(1)
1174:                 .FontName  = "Tahoma"
1175:                 .FontSize  = 8
1176:                 .BackStyle = 0
1177:                 .Caption   = "Produto"
1178:                 .Top       = 5
1179:                 .Left      = 5
1180:                 .Width     = 56
1181:                 .Height    = 15
1182:                 .ForeColor = RGB(90, 90, 90)
1183:             ENDWITH
1184: 
1185:             WITH .Buttons(2)
1186:                 .FontName  = "Tahoma"
1187:                 .FontSize  = 8
1188:                 .BackStyle = 0
1189:                 .Caption   = "Cole" + CHR(231) + CHR(227) + "o"
1190:                 .Top       = 5
1191:                 .Left      = 69
1192:                 .Width     = 56
1193:                 .Height    = 15
1194:                 .ForeColor = RGB(90, 90, 90)
1195:             ENDWITH
1196:         ENDWITH
1197: 
1198:         BINDEVENT(THIS.obj_4c_OptOrdem, "InteractiveChange", THIS, "OptOrdemInteractiveChange")
1199: 
1200:         RETURN .T.
1201:     ENDPROC
1202: 
1203:     *==========================================================================
1204:     * OptOrdemInteractiveChange - OptOrdem.Valid do legado
1205:     *   Value = 1 -> Index on Cpros ; senao -> Index on Categoria / Go Top /
1206:     *   grdItens.Refresh
1207:     *==========================================================================
1208:     PROCEDURE OptOrdemInteractiveChange()
1209:         LOCAL loc_nValor
1210:         loc_nValor = THIS.obj_4c_OptOrdem.Value
1211:         THIS.this_nOrdemAtual = loc_nValor
1212: 
1213:         IF VARTYPE(THIS.this_oBusinessObject) = "O"
1214:             THIS.this_oBusinessObject.OrdenarItens(loc_nValor)
1215:         ENDIF
1216: 
1217:         IF USED("cursor_4c_Itens")
1218:             SELECT cursor_4c_Itens
1219:             GO TOP
1220:         ENDIF
1221:         THIS.grd_4c_Dados.Refresh()
1222:     ENDPROC
1223: 
1224:     *==========================================================================
1225:     * AtualizarDependenciaNiveis - gate dos campos de nivel (When do legado)
1226:     *
1227:     * O legado escreve a regra no When de cada caixa:
1228:     *   getBase.When : Return (InList(pcEscolha,[INSERIR],[ALTERAR]))
1229:     *   getNvl2.When : o mesmo teste de modo E, antes de liberar,
1230:     *                  If Empty(getBase.Value) -> Return .F.
1231:     *   getNvl3.When : o mesmo, mas contra getNvl2.Value
1232:     *   getNvl4.When : o mesmo, mas contra getNvl3.Value
1233:     *
1234:     * BINDEVENT nao atende "When" de TextBox de forma confiavel, entao o gate
1235:     * mora num metodo UNICO e PUBLIC, chamado por todo ponto que muda o estado
1236:     * dos niveis. Campo fora do gate fica com Enabled = .F.: a caixa cinza
1237:     * ocupa o lugar do "Wait Window [Nivel Anterior nao Informado.] Nowait"
1238:     * que o legado piscava ao tentar entrar no campo, e impede a digitacao do
1239:     * mesmo jeito.
1240:     *
1241:     * As caixas de descricao nao entram aqui: elas sao ReadOnly de nascimento
1242:     * (o When delas devolve .F. no legado, sem condicao nenhuma).
1243:     *
1244:     * Os PEMSTATUS de Nvl3/Nvl4 existem porque este metodo ja eh chamado no
1245:     * fim de ConfigurarCamposNiveis (so Base/Nvl2 criados ainda) - sem a
1246:     * guarda, a 1a chamada estouraria "Property TXT_4C_NVL3 is not found".
1247:     *==========================================================================
1248:     PROCEDURE AtualizarDependenciaNiveis()
1249:         LOCAL loc_lBasePreenchida, loc_lNvl2Preenchida, loc_lNvl3Preenchida
1250: 
1251:         IF !PEMSTATUS(THIS, "txt_4c_Base", 5) OR !PEMSTATUS(THIS, "txt_4c_Nvl2", 5)
1252:             RETURN .F.
1253:         ENDIF
1254: 
1255:         loc_lBasePreenchida = !EMPTY(ALLTRIM(THIS.txt_4c_Base.Value))
1256: 
1257:         THIS.txt_4c_Base.Enabled = THIS.this_lPodeEditar
1258:         THIS.txt_4c_Nvl2.Enabled = THIS.this_lPodeEditar AND loc_lBasePreenchida
1259: 
1260:         IF PEMSTATUS(THIS, "txt_4c_Nvl3", 5)
1261:             loc_lNvl2Preenchida      = !EMPTY(ALLTRIM(THIS.txt_4c_Nvl2.Value))
1262:             THIS.txt_4c_Nvl3.Enabled = THIS.this_lPodeEditar AND loc_lNvl2Preenchida
1263:         ENDIF
1264: 
1265:         IF PEMSTATUS(THIS, "txt_4c_Nvl4", 5)
1266:             loc_lNvl3Preenchida      = !EMPTY(ALLTRIM(THIS.txt_4c_Nvl3.Value))
1267:             THIS.txt_4c_Nvl4.Enabled = THIS.this_lPodeEditar AND loc_lNvl3Preenchida
1268:         ENDIF
1269: 
1270:         RETURN .T.
1271:     ENDPROC
1272: 
1273:     *==========================================================================
1274:     * BtnConfirmarClick - btnConfirmar.Click do legado
1275:     *
1276:     * Propaga cursor_4c_Locais para crTpmMvItn (SigOpLclBO.Atualizar) e
1277:     * encerra o dialogo. O legado NAO tem guarda de QUANTIDADE - sempre libera
1278:     * a tela depois do Scan/Update, mesmo que nenhuma linha tenha sido afetada
1279:     * (csLocals vazio = fechar sem mudanca), e isso eh reproduzido aqui:
1280:     * Atualizar() devolve .T. com this_nItensConfirmados = 0.
1281:     *
1282:     * Mas o Atualizar() migrado tem guardas que o legado nao tem (crTpmMvItn
1283:     * ou cursor_4c_Locais fechados) e nesses caminhos ele devolve .F. deixando
1284:     * this_cMensagemErro preenchida SEM exibir - ExibirFalha da BusinessBase eh
1285:     * PROTECTED e so roda por dentro do Salvar()/Excluir() (regra #51), que
1286:     * este fluxo nao usa. Ignorar o retorno fechava a tela em SILENCIO sem
1287:     * aplicar localizacao nenhuma (regra #20: falha de gravacao nunca eh muda).
1288:     * Entao: exibe a mensagem e NAO libera o form, para o usuario nao perder as
1289:     * localizacoes que ja montou.
1290:     *==========================================================================
1291:     PROCEDURE BtnConfirmarClick()
1292:         LOCAL loc_lConfirmou
1293: 
1294:         loc_lConfirmou = .T.
1295: 
1296:         IF VARTYPE(THIS.this_oBusinessObject) = "O"
1297:             loc_lConfirmou = THIS.this_oBusinessObject.Atualizar()
1298: 
1299:             IF !loc_lConfirmou
1300:                 IF !THIS.this_oBusinessObject.this_lErroExibido
1301:                     IF !EMPTY(THIS.this_oBusinessObject.this_cMensagemErro)
1302:                         MsgAviso(THIS.this_oBusinessObject.this_cMensagemErro, ;
1303:                                  "Aten" + CHR(231) + CHR(227) + "o")
1304:                     ELSE
1305:                         MsgAviso("N" + CHR(227) + "o foi poss" + CHR(237) + "vel confirmar a " + ;
1306:                                  "localiza" + CHR(231) + CHR(227) + "o dos itens.", ;
1307:                                  "Aten" + CHR(231) + CHR(227) + "o")
1308:                     ENDIF
1309:                 ENDIF
1310:             ENDIF
1311:         ENDIF
1312: 
1313:         IF loc_lConfirmou
1314:             THIS.Release()
1315:         ENDIF
1316:     ENDPROC
1317: 
1318:     *==========================================================================
1319:     * BtnCancelarClick - btnSair.Click do legado (ThisForm.Release)
1320:     *==========================================================================
1321:     PROCEDURE BtnCancelarClick()
1322:         THIS.Release()
1323:     ENDPROC
1324: 
1325:     *==========================================================================
1326:     * BtnSelTudoClick - SelTudo.Click do legado
1327:     *   Replace All Marcas With 1 / Go Top / Refresh.
1328:     *   When do legado: so age em INSERIR/ALTERAR (this_lPodeEditar).
1329:     *==========================================================================
1330:     PROCEDURE BtnSelTudoClick()
1331:         IF !THIS.this_lPodeEditar
1332:             RETURN
1333:         ENDIF
1334: 
1335:         IF VARTYPE(THIS.this_oBusinessObject) = "O"
1336:             THIS.this_oBusinessObject.MarcarTodosItens(1)
1337:         ENDIF
1338: 
1339:         IF USED("cursor_4c_Itens")
1340:             SELECT cursor_4c_Itens
1341:             GO TOP
1342:         ENDIF
1343:         THIS.GradeAfterRowColChange()
1344:         THIS.grd_4c_Dados.Refresh()
1345:     ENDPROC
1346: 
1347:     *==========================================================================
1348:     * BtnApagaClick - apaga.Click do legado
1349:     *   Replace All Marcas With 0 / Go Top / Refresh.
1350:     *   When do legado: so age em INSERIR/ALTERAR (this_lPodeEditar).
1351:     *==========================================================================
1352:     PROCEDURE BtnApagaClick()
1353:         IF !THIS.this_lPodeEditar
1354:             RETURN
1355:         ENDIF
1356: 
1357:         IF VARTYPE(THIS.this_oBusinessObject) = "O"
1358:             THIS.this_oBusinessObject.MarcarTodosItens(0)
1359:         ENDIF
1360: 
1361:         IF USED("cursor_4c_Itens")
1362:             SELECT cursor_4c_Itens
1363:             GO TOP
1364:         ENDIF
1365:         THIS.GradeAfterRowColChange()
1366:         THIS.grd_4c_Dados.Refresh()
1367:     ENDPROC
1368: 
1369:     *==========================================================================
1370:     * ConfigurarLookupsNiveis - liga os quatro lookups de nivel (LostFocus,
1371:     * regra #47) e as cascatas de limpeza (InteractiveChange)
1372:     *
1373:     * O legado valida no Valid de cada caixa (ao SAIR dela). BINDEVENT em
1374:     * "Valid" de TextBox nao eh confiavel (regra #47), entao o equivalente
1375:     * mora em "LostFocus" - sem parametros, e com guarda de reentrancia
1376:     * this_lEmLookup (o picker eh MODAL e tira o foco, redisparando o
1377:     * proprio LostFocus).
1378:     *==========================================================================
1379:     PROTECTED PROCEDURE ConfigurarLookupsNiveis()
1380: 
1381:         BINDEVENT(THIS.txt_4c_Base, "LostFocus", THIS, "BaseLostFocus")
1382:         BINDEVENT(THIS.txt_4c_Base, "InteractiveChange", THIS, "BaseInteractiveChange")
1383: 
1384:         BINDEVENT(THIS.txt_4c_Nvl2, "LostFocus", THIS, "Nvl2LostFocus")
1385:         BINDEVENT(THIS.txt_4c_Nvl2, "InteractiveChange", THIS, "Nvl2InteractiveChange")
1386: 
1387:         BINDEVENT(THIS.txt_4c_Nvl3, "LostFocus", THIS, "Nvl3LostFocus")
1388:         BINDEVENT(THIS.txt_4c_Nvl3, "InteractiveChange", THIS, "Nvl3InteractiveChange")
1389: 
1390:         BINDEVENT(THIS.txt_4c_Nvl4, "LostFocus", THIS, "Nvl4LostFocus")
1391:         BINDEVENT(THIS.txt_4c_Nvl4, "InteractiveChange", THIS, "Nvl4InteractiveChange")
1392: 
1393:         RETURN .T.
1394:     ENDPROC
1395: 
1396:     *==========================================================================
1397:     * BaseInteractiveChange / Nvl2InteractiveChange / Nvl3InteractiveChange /
1398:     * Nvl4InteractiveChange - cascata de limpeza do legado
1399:     *
1400:     * Legado: cada nivel, ao mudar, limpa a propria descricao E todos os
1401:     * niveis/descricoes ABAIXO dele (getBase.InteractiveChange limpa os 7
1402:     * campos seguintes; getNvl2 limpa os 5 seguintes; getNvl3 limpa os 3
1403:     * seguintes; getNvl4 so limpa a propria descricao).
1404:     *==========================================================================
1405:     PROCEDURE BaseInteractiveChange()
1406:         THIS.txt_4c_DBase.Value = ""
1407:         THIS.txt_4c_Nvl2.Value  = ""
1408:         THIS.txt_4c_DNvl2.Value = ""
1409:         THIS.txt_4c_Nvl3.Value  = ""
1410:         THIS.txt_4c_DNvl3.Value = ""
1411:         THIS.txt_4c_Nvl4.Value  = ""
1412:         THIS.txt_4c_DNvl4.Value = ""
1413:         THIS.AtualizarDependenciaNiveis()
1414:     ENDPROC
1415: 
1416:     PROCEDURE Nvl2InteractiveChange()
1417:         THIS.txt_4c_DNvl2.Value = ""
1418:         THIS.txt_4c_Nvl3.Value  = ""
1419:         THIS.txt_4c_DNvl3.Value = ""
1420:         THIS.txt_4c_Nvl4.Value  = ""
1421:         THIS.txt_4c_DNvl4.Value = ""
1422:         THIS.AtualizarDependenciaNiveis()
1423:     ENDPROC
1424: 
1425:     PROCEDURE Nvl3InteractiveChange()
1426:         THIS.txt_4c_DNvl3.Value = ""
1427:         THIS.txt_4c_Nvl4.Value  = ""
1428:         THIS.txt_4c_DNvl4.Value = ""
1429:         THIS.AtualizarDependenciaNiveis()
1430:     ENDPROC
1431: 
1432:     PROCEDURE Nvl4InteractiveChange()
1433:         THIS.txt_4c_DNvl4.Value = ""
1434:     ENDPROC
1435: 
1436:     *==========================================================================
1437:     * BaseLostFocus - getBase.Valid do legado (busca na tabela REMOTA SigLcNv1)
1438:     *
1439:     * Legado (fwbuscaext): tenta match EXATO por Cods sozinho; so achando NAO
1440:     * acha eh que mostra o browse. Aqui: SQLEXEC exato primeiro (silencioso);
1441:     * sem match, THIS.AbrirLookupCanonico (regra #36/37 - Pattern B do
1442:     * FormBuscaAuxiliar com CREATEOBJECT de 2+ argumentos eh PROIBIDO).
1443:     *
1444:     * Guarda de reentrancia (regra #37/#47): o picker eh MODAL e tira o foco
1445:     * do campo, o que redispara este proprio LostFocus. O corpo vive em
1446:     * BaseLostFocusExec para a flag ser SEMPRE liberada, inclusive com
1447:     * RETURN antecipado dentro do Exec.
1448:     *==========================================================================
1449:     PROCEDURE BaseLostFocus()
1450:         IF THIS.this_lEmLookup
1451:             RETURN
1452:         ENDIF
1453:         THIS.this_lEmLookup = .T.
1454:         THIS.BaseLostFocusExec()
1455:         THIS.this_lEmLookup = .F.
1456:     ENDPROC
1457: 
1458:     PROCEDURE BaseLostFocusExec()
1459:         LOCAL loc_cValor, loc_cSQL, loc_nResultado, loc_lAchou
1460: 
1461:         loc_cValor = ALLTRIM(THIS.txt_4c_Base.Value)
1462:         IF EMPTY(loc_cValor)
1463:             RETURN
1464:         ENDIF
1465: 
1466:         loc_lAchou = .F.
1467: 
1468:         IF TYPE("gnConnHandle") = "N"
1469:             IF gnConnHandle > 0
1470:                 IF USED("cursor_4c_BaseExata")
1471:                     USE IN cursor_4c_BaseExata
1472:                 ENDIF
1473: 
1474:                 loc_cSQL = "SELECT Cods, Descs FROM SigLcNv1 WHERE Cods = " + EscaparSQL(loc_cValor)
1475:                 loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BaseExata")
1476: 
1477:                 IF loc_nResultado > 0 AND USED("cursor_4c_BaseExata")
1478:                     IF RECCOUNT("cursor_4c_BaseExata") = 1
1479:                         THIS.txt_4c_Base.Value  = ALLTRIM(cursor_4c_BaseExata.Cods)
1480:                         THIS.txt_4c_DBase.Value = ALLTRIM(NVL(cursor_4c_BaseExata.Descs, ""))
1481:                         loc_lAchou = .T.
1482:                     ENDIF
1483:                 ENDIF
1484: 
1485:                 IF USED("cursor_4c_BaseExata")
1486:                     USE IN cursor_4c_BaseExata
1487:                 ENDIF
1488:             ENDIF
1489:         ENDIF
1490: 
1491:         IF !loc_lAchou
1492:             *-- Funil unico do picker (regra #37): tudo que abre
1493:             *-- FormBuscaAuxiliar para a Base passa por AbrirBuscaBase
1494:             THIS.AbrirBuscaBase()
1495:         ENDIF
1496: 
1497:         THIS.txt_4c_Base.Refresh()
1498:         THIS.txt_4c_DBase.Refresh()
1499: 
1500:         THIS.AtualizarDependenciaNiveis()
1501:     ENDPROC
1502: 
1503:     *==========================================================================
1504:     * Nvl2LostFocus / Nvl3LostFocus / Nvl4LostFocus - getNvl2/3/4.Valid do
1505:     * legado (busca no cursor LOCAL da hierarquia, ja filtrado pelo pai)
1506:     *
1507:     * Os tres delegam a ValidarNivelExec, que reproduz o padrao comum:
1508:     *   Select * From crSigLcNvN Where Cods = <pai> Into Cursor LocalNivel
1509:     *   Seek <valor digitado> - achando, NAO reatribui nada (fidelidade ao
1510:     *   legado: o Valid so toca Value/Desc no ramo "nao achou"); nao achando,
1511:     *   abre o picker sobre o cursor LOCAL (Pattern A - DefinirCursor/Mostrar)
1512:     *   e preenche codigo + descricao com o selecionado.
1513:     *==========================================================================
1514:     PROCEDURE Nvl2LostFocus()
1515:         IF THIS.this_lEmLookup
1516:             RETURN
1517:         ENDIF
1518:         THIS.this_lEmLookup = .T.
1519:         THIS.ValidarNivelExec(2)
1520:         THIS.this_lEmLookup = .F.
1521:     ENDPROC
1522: 
1523:     PROCEDURE Nvl3LostFocus()
1524:         IF THIS.this_lEmLookup
1525:             RETURN
1526:         ENDIF
1527:         THIS.this_lEmLookup = .T.
1528:         THIS.ValidarNivelExec(3)
1529:         THIS.this_lEmLookup = .F.
1530:     ENDPROC
1531: 
1532:     PROCEDURE Nvl4LostFocus()
1533:         IF THIS.this_lEmLookup
1534:             RETURN
1535:         ENDIF
1536:         THIS.this_lEmLookup = .T.
1537:         THIS.ValidarNivelExec(4)
1538:         THIS.this_lEmLookup = .F.
1539:     ENDPROC
1540: 
1541:     PROCEDURE ValidarNivelExec(par_nNivel)
1542:         LOCAL loc_oTxt, loc_oTxtDesc, loc_oTxtPai, loc_cCursorNivel
1543:         LOCAL loc_cValor, loc_cValorPai
1544: 
1545:         loc_oTxt     = THIS.ObterControleNivel(par_nNivel, "COD")
1546:         loc_oTxtDesc = THIS.ObterControleNivel(par_nNivel, "DESC")
1547:         loc_oTxtPai  = THIS.ObterControleNivel(par_nNivel, "PAI")
1548: 
1549:         IF VARTYPE(loc_oTxt) != "O" OR VARTYPE(loc_oTxtDesc) != "O" OR VARTYPE(loc_oTxtPai) != "O"
1550:             RETURN
1551:         ENDIF
1552: 
1553:         loc_cValor = ALLTRIM(loc_oTxt.Value)
1554:         IF EMPTY(loc_cValor)
1555:             RETURN
1556:         ENDIF
1557: 
1558:         IF VARTYPE(THIS.this_oBusinessObject) != "O"
1559:             RETURN
1560:         ENDIF
1561: 
1562:         loc_cCursorNivel = THIS.ObterCursorNivel(par_nNivel)
1563:         loc_cValorPai    = ALLTRIM(loc_oTxtPai.Value)
1564: 
1565:         THIS.this_oBusinessObject.CarregarNivelFiltrado(loc_cCursorNivel, loc_cValorPai)
1566: 
1567:         IF USED("cursor_4c_LocalNivel")
1568:             IF !SEEK(loc_cValor, "cursor_4c_LocalNivel", "Codigo")
1569:                 *-- Nao achou -> browse de selecao, SEMPRE pelo funil unico
1570:                 *-- (regra #37). Achando, o legado NAO reatribui nada: o
1571:                 *-- getNvlN.Valid so toca Value/Desc no ramo "nao achou".
1572:                 THIS.AbrirBuscaNivel(par_nNivel)
1573:             ENDIF
1574:         ENDIF
1575: 
1576:         loc_oTxt.Refresh()
1577:         loc_oTxtDesc.Refresh()
1578: 
1579:         THIS.AtualizarDependenciaNiveis()
1580:     ENDPROC
1581: 
1582:     *==========================================================================
1583:     * AbrirBuscaBase - FUNIL UNICO do picker da Base (SigLcNv1, tabela REMOTA)
1584:     *
1585:     * Padrao canonico do projeto (regra #37): todo caminho que precise exibir o
1586:     * browse de selecao da Base passa por aqui, nunca por um CREATEOBJECT
1587:     * espalhado pelos handlers. Transcreve o getBase.Valid legado:
1588:     *   CreateObject('fwbuscaext', ..., 'SigLcNv1', 'crListaRemota', 'Cods',
1589:     *                This.Value, 'Selecao', .t.)
1590:     *   loLista.mAddColuna('Cods',  '', 'Localizacao')
1591:     *   loLista.mAddColuna('Descs', '', 'Descricao')
1592:     * O match exato (plAchouRegistro do legado) eh tentado ANTES, em
1593:     * BaseLostFocusExec - aqui se chega apenas no ramo "nao achou".
1594:     *
1595:     * Metodo PUBLIC de proposito (regra #3): eh o funil, e tem de poder ser
1596:     * acionado de fora do proprio LostFocus.
1597:     *
1598:     * Guarda de reentrancia em SAVE/RESTORE, nao set/clear (regra #47): este
1599:     * metodo eh chamado de DENTRO de BaseLostFocusExec, onde a flag ja esta
1600:     * ligada - um clear simples a liberaria cedo demais e o LostFocus que o
1601:     * fechamento do picker MODAL redispara abriria um SEGUNDO dialogo.
1602:     *==========================================================================
1603:     PROCEDURE AbrirBuscaBase()
1604:         LOCAL loc_cValor, loc_lEmLookupAnt, loc_oErro
1605: 
1606:         loc_lEmLookupAnt    = THIS.this_lEmLookup
1607:         THIS.this_lEmLookup = .T.
1608: 
1609:         TRY
1610:             loc_cValor = ALLTRIM(THIS.txt_4c_Base.Value)
1611: 
1612:             THIS.AbrirLookupCanonico("SigLcNv1", "Cods", "Descs", ;
1613:                 "Sele" + CHR(231) + CHR(227) + "o", loc_cValor, ;
1614:                 THIS.txt_4c_Base, THIS.txt_4c_DBase)
1615: 
1616:         CATCH TO loc_oErro
1617:             MsgErro("Erro ao abrir a sele" + CHR(231) + CHR(227) + "o da Base:" + CHR(13) + ;
1618:                     loc_oErro.Message + CHR(13) + ;
1619:                     "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1620:                     "Procedure: " + loc_oErro.Procedure, "Erro")
1621:         ENDTRY
1622: 
1623:         *-- Restaurado FORA do TRY, para valer tambem quando o CATCH dispara
1624:         THIS.this_lEmLookup = loc_lEmLookupAnt
1625:     ENDPROC
1626: 
1627:     *==========================================================================
1628:     * AbrirBuscaNivel - FUNIL UNICO do picker de 2o/3o/4o nivel (cursor LOCAL)
1629:     *
1630:     * Transcreve o ramo "nao achou" do getNvl2/3/4.Valid legado:
1631:     *   loBrow = Createobject('fwbuscasel', 'LocalNivel', 'Codigo',
1632:     *                         This.Value, 'Selecao')
1633:     *   loBrow.AddColuna('Codigo', '', 'Codigo',    .T., 'Codigo')
1634:     *   loBrow.AddColuna('Descs',  '', 'Descricao', .F.)
1635:     *   loBrow.Show
1636:     *   This.Value = LocalNivel.Codigo
1637:     *   ThisForm.getDNvlN.Value = LocalNivel.Descs
1638:     *
1639:     * O picker usa o Pattern A (CREATEOBJECT sem argumento + DefinirCursor +
1640:     * Mostrar) porque a lista eh um cursor LOCAL ja filtrado pelo pai - o
1641:     * Pattern B (CREATEOBJECT com parametros) dispararia um SELECT remoto
1642:     * proprio e abriria o dialogo vazio.
1643:     *
1644:     * Refaz o filtro do pai antes de abrir (CarregarNivelFiltrado) para o
1645:     * metodo ser auto-contido e correto tambem quando acionado de fora de
1646:     * ValidarNivelExec; o custo eh um SELECT em cursor local.
1647:     *==========================================================================
1648:     PROCEDURE AbrirBuscaNivel(par_nNivel)
1649:         LOCAL loc_oTxt, loc_oTxtDesc, loc_oTxtPai, loc_cCursorNivel, loc_cTitulo
1650:         LOCAL loc_oBusca, loc_lEmLookupAnt, loc_lProsseguir, loc_oErro
1651: 
1652:         loc_lEmLookupAnt    = THIS.this_lEmLookup
1653:         THIS.this_lEmLookup = .T.
1654:         loc_lProsseguir     = .T.
1655: 
1656:         TRY
1657:             loc_oTxt     = THIS.ObterControleNivel(par_nNivel, "COD")
1658:             loc_oTxtDesc = THIS.ObterControleNivel(par_nNivel, "DESC")
1659:             loc_oTxtPai  = THIS.ObterControleNivel(par_nNivel, "PAI")
1660: 
1661:             IF VARTYPE(loc_oTxt) != "O" OR VARTYPE(loc_oTxtDesc) != "O" OR VARTYPE(loc_oTxtPai) != "O"
1662:                 loc_lProsseguir = .F.
1663:             ENDIF
1664: 
1665:             IF loc_lProsseguir
1666:                 IF VARTYPE(THIS.this_oBusinessObject) != "O"
1667:                     loc_lProsseguir = .F.
1668:                 ENDIF
1669:             ENDIF
1670: 
1671:             IF loc_lProsseguir
1672:                 loc_cCursorNivel = THIS.ObterCursorNivel(par_nNivel)
1673:                 loc_cTitulo      = THIS.ObterTituloNivel(par_nNivel)
1674: 
1675:                 THIS.this_oBusinessObject.CarregarNivelFiltrado(loc_cCursorNivel, ;
1676:                     ALLTRIM(loc_oTxtPai.Value))
1677: 
1678:                 IF USED("cursor_4c_LocalNivel")
1679:                     loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
1680:                     IF VARTYPE(loc_oBusca) = "O"
1681:                         loc_oBusca.DefinirCursor("cursor_4c_LocalNivel", "Codigo", "Descs", ;
1682:                             "Sele" + CHR(231) + CHR(227) + "o - " + loc_cTitulo)
1683:                         IF loc_oBusca.Mostrar()
1684:                             loc_oTxt.Value     = ALLTRIM(loc_oBusca.cCodigoSelecionado)
1685:                             loc_oTxtDesc.Value = ALLTRIM(loc_oBusca.cDescricaoSelecionada)
1686:                         ENDIF
1687:                         loc_oBusca.Release()
1688:                     ENDIF
1689:                 ENDIF
1690:             ENDIF
1691: 
1692:         CATCH TO loc_oErro
1693:             MsgErro("Erro ao abrir a sele" + CHR(231) + CHR(227) + "o do n" + CHR(237) + "vel:" + CHR(13) + ;
1694:                     loc_oErro.Message + CHR(13) + ;
1695:                     "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1696:                     "Procedure: " + loc_oErro.Procedure, "Erro")
1697:         ENDTRY
1698: 
1699:         *-- Restaurado FORA do TRY, para valer tambem quando o CATCH dispara
1700:         THIS.this_lEmLookup = loc_lEmLookupAnt
1701:     ENDPROC
1702: 
1703:     *==========================================================================
1704:     * ObterControleNivel / ObterCursorNivel / ObterTituloNivel - resolvedores
1705:     * da hierarquia de niveis, usados por ValidarNivelExec e AbrirBuscaNivel
1706:     *
1707:     * Fonte UNICA do mapeamento nivel -> (campo de codigo, campo de descricao,
1708:     * campo do nivel PAI, cursor da hierarquia, titulo do browse): duplicar o
1709:     * DO CASE nos dois metodos deixaria os dois livres para divergir.
1710:     *
1711:     * par_cQual: "COD" (campo do nivel), "DESC" (descricao) ou "PAI" (campo do
1712:     * nivel anterior, que filtra o cursor). Nivel fora de 2..4 devolve .NULL. e
1713:     * o chamador aborta - a Base nao entra aqui: ela mora numa tabela REMOTA e
1714:     * tem funil proprio (AbrirBuscaBase).
1715:     *==========================================================================
1716:     PROTECTED FUNCTION ObterControleNivel(par_nNivel, par_cQual)
1717:         LOCAL loc_oRet, loc_cQual
1718: 
1719:         loc_oRet  = .NULL.
1720:         loc_cQual = IIF(VARTYPE(par_cQual) = "C", UPPER(ALLTRIM(par_cQual)), "")
1721: 
1722:         DO CASE
1723:             CASE par_nNivel = 2 AND loc_cQual = "COD"
1724:                 loc_oRet = THIS.txt_4c_Nvl2
1725:             CASE par_nNivel = 2 AND loc_cQual = "DESC"
1726:                 loc_oRet = THIS.txt_4c_DNvl2
1727:             CASE par_nNivel = 2 AND loc_cQual = "PAI"
1728:                 loc_oRet = THIS.txt_4c_Base
1729:             CASE par_nNivel = 3 AND loc_cQual = "COD"
1730:                 loc_oRet = THIS.txt_4c_Nvl3
1731:             CASE par_nNivel = 3 AND loc_cQual = "DESC"
1732:                 loc_oRet = THIS.txt_4c_DNvl3
1733:             CASE par_nNivel = 3 AND loc_cQual = "PAI"
1734:                 loc_oRet = THIS.txt_4c_Nvl2
1735:             CASE par_nNivel = 4 AND loc_cQual = "COD"
1736:                 loc_oRet = THIS.txt_4c_Nvl4

*-- Linhas 1786 a 2158:
1786:     * NoDefault) e alterna o valor por codigo no KeyPress/MouseUp - sem isso
1787:     * o CheckBox renderiza mas nao responde a clique nem a Espaco/Enter.
1788:     *==========================================================================
1789:     PROTECTED PROCEDURE ConfigurarHandlersGrade()
1790:         LOCAL loc_oChk
1791:         loc_oChk = THIS.grd_4c_Dados.Column3.chk_4c_Marcas
1792: 
1793:         BINDEVENT(loc_oChk, "Click",     THIS, "ChkMarcasClick")
1794:         BINDEVENT(loc_oChk, "MouseDown", THIS, "ChkMarcasMouseDown")
1795:         BINDEVENT(loc_oChk, "MouseUp",   THIS, "ChkMarcasMouseUp")
1796:         BINDEVENT(loc_oChk, "KeyPress",  THIS, "ChkMarcasKeyPress")
1797: 
1798:         BINDEVENT(THIS.grd_4c_Dados, "AfterRowColChange", THIS, "GradeAfterRowColChange")
1799: 
1800:         RETURN .T.
1801:     ENDPROC
1802: 
1803:     PROCEDURE ChkMarcasClick()
1804:         NODEFAULT
1805:     ENDPROC
1806: 
1807:     PROCEDURE ChkMarcasMouseDown(par_nButton, par_nShift, par_nXCoord, par_nYCoord)
1808:         NODEFAULT
1809:     ENDPROC
1810: 
1811:     PROCEDURE ChkMarcasMouseUp(par_nButton, par_nShift, par_nXCoord, par_nYCoord)
1812:         THIS.ChkMarcasKeyPress(13, 0)
1813:         NODEFAULT
1814:     ENDPROC
1815: 
1816:     *==========================================================================
1817:     * ChkMarcasKeyPress - Check1.KeyPress do legado
1818:     *   Enter(13)/Espaco(32): alterna Marcas da linha corrente, repinta a
1819:     *   grade e reavalia foto/estado do botao Localizar.
1820:     *   When do legado: so age em INSERIR/ALTERAR (this_lPodeEditar).
1821:     *==========================================================================
1822:     PROCEDURE ChkMarcasKeyPress(par_nKeyCode, par_nShiftAltCtrl)
1823:         IF !THIS.this_lPodeEditar
1824:             RETURN
1825:         ENDIF
1826: 
1827:         IF !INLIST(par_nKeyCode, 13, 32)
1828:             RETURN
1829:         ENDIF
1830: 
1831:         IF VARTYPE(THIS.this_oBusinessObject) = "O"
1832:             THIS.this_oBusinessObject.AlternarMarcaItem()
1833:         ENDIF
1834: 
1835:         THIS.GradeAfterRowColChange()
1836:         THIS.grd_4c_Dados.Refresh()
1837:         NODEFAULT
1838:     ENDPROC
1839: 
1840:     *==========================================================================
1841:     * GradeAfterRowColChange - grdItens.AfterRowColChange do legado
1842:     *
1843:     * (a) foto do produto da linha corrente (SigOpLclBO.BuscarFotoProduto -
1844:     *     decodifica o base64 de SigCdPro.FigJpgs uma unica vez - regra do
1845:     *     STRCONV duplo);
1846:     * (b) habilita btnLocalizar so quando a linha corrente tem Marcas <> 0 E
1847:     *     o modo permite editar - o legado testa os dois juntos.
1848:     *
1849:     * par_nColIndex nao eh usado (o legado tambem nao usa - a chamada do
1850:     * Check1.KeyPress eh This.parent.parent.AfterRowColChange, sem argumento).
1851:     *==========================================================================
1852:     PROCEDURE GradeAfterRowColChange(par_nColIndex)
1853:         LOCAL loc_cArquivo, loc_lHabilitaLocalizar
1854: 
1855:         loc_lHabilitaLocalizar = .F.
1856: 
1857:         IF USED("cursor_4c_Itens") AND RECCOUNT("cursor_4c_Itens") > 0 AND !EOF("cursor_4c_Itens")
1858:             IF VARTYPE(THIS.this_oBusinessObject) = "O"
1859:                 loc_cArquivo = THIS.this_oBusinessObject.BuscarFotoProduto(ALLTRIM(cursor_4c_Itens.Cpros))
1860:             ELSE
1861:                 loc_cArquivo = ""
1862:             ENDIF
1863: 
1864:             IF !EMPTY(loc_cArquivo)
1865:                 THIS.img_4c_ImgJpg.Visible = .F.
1866:                 THIS.img_4c_ImgJpg.Picture = ""
1867:                 THIS.img_4c_ImgJpg.Picture = loc_cArquivo
1868:                 THIS.img_4c_ImgJpg.Visible = .T.
1869:             ELSE
1870:                 THIS.img_4c_ImgJpg.Visible = .F.
1871:                 THIS.img_4c_ImgJpg.Picture = ""
1872:             ENDIF
1873: 
1874:             loc_lHabilitaLocalizar = (cursor_4c_Itens.Marcas <> 0) AND THIS.this_lPodeEditar
1875:         ELSE
1876:             THIS.img_4c_ImgJpg.Visible = .F.
1877:             THIS.img_4c_ImgJpg.Picture = ""
1878:         ENDIF
1879: 
1880:         IF PEMSTATUS(THIS, "obj_4c_CmdAcoes", 5)
1881:             THIS.obj_4c_CmdAcoes.Buttons(1).Enabled = loc_lHabilitaLocalizar
1882:         ENDIF
1883:     ENDPROC
1884: 
1885:     *==========================================================================
1886:     * BtnLocalizarClick - btnLocalizar.Click do legado
1887:     *
1888:     * Grava (SigOpLclBO.Inserir) a localizacao montada a partir dos quatro
1889:     * campos de nivel para todo item marcado, remove essas linhas da grade e
1890:     * limpa os campos de nivel - exatamente o fluxo do Click legado.
1891:     *
1892:     * O guard de modo eh o When do botao legado (InList(pcEscolha,'INSERIR',
1893:     * 'ALTERAR')); o botao ja nasce/fica Enabled de acordo (ConfigurarAcoes
1894:     * Localizacao + GradeAfterRowColChange), o IF aqui eh so defensivo -
1895:     * mesmo padrao de BtnSelTudoClick/BtnApagaClick.
1896:     *==========================================================================
1897:     PROCEDURE BtnLocalizarClick()
1898:         IF !THIS.this_lPodeEditar
1899:             RETURN
1900:         ENDIF
1901: 
1902:         IF VARTYPE(THIS.this_oBusinessObject) != "O"
1903:             RETURN
1904:         ENDIF
1905: 
1906:         *-- lcLoc1..lcLoc4 do Click legado: le os campos da tela para o BO
1907:         IF !THIS.FormParaBO()
1908:             RETURN
1909:         ENDIF
1910: 
1911:         IF !THIS.this_oBusinessObject.ValidarNiveis(.T.)
1912:             RETURN
1913:         ENDIF
1914: 
1915:         IF THIS.this_oBusinessObject.Inserir()
1916:             *-- Legado: ThisForm.getBase/getNvl2/getNvl3/getNvl4/getDBase/
1917:             *-- getDNvl2/getDNvl3/getDNvl4.Value = [] no fim do Click.
1918:             *-- Zera no BO e ESPELHA na tela, para os oito campos terem uma
1919:             *-- fonte unica (LimparNiveis) em vez de oito atribuicoes soltas.
1920:             THIS.this_oBusinessObject.LimparNiveis()
1921:             THIS.BOParaForm()
1922: 
1923:             THIS.AtualizarDependenciaNiveis()
1924: 
1925:             IF USED("cursor_4c_Itens")
1926:                 SELECT cursor_4c_Itens
1927:                 GO TOP
1928:             ENDIF
1929:             THIS.grd_4c_Dados.Column1.SetFocus()
1930:             THIS.grd_4c_Dados.Refresh()
1931:             THIS.GradeAfterRowColChange()
1932:         ELSE
1933:             *-- Inserir() recusa em silencio (modo, cursores fechados, nenhum
1934:             *-- item marcado): deixa this_cMensagemErro preenchida e NAO exibe,
1935:             *-- porque ExibirFalha da BusinessBase eh PROTECTED e so roda por
1936:             *-- dentro do Salvar() (regra #51). Sem este ELSE o usuario clicava
1937:             *-- Localizar e NADA acontecia (regra #20).
1938:             IF !THIS.this_oBusinessObject.this_lErroExibido
1939:                 IF !EMPTY(THIS.this_oBusinessObject.this_cMensagemErro)
1940:                     MsgAviso(THIS.this_oBusinessObject.this_cMensagemErro, ;
1941:                              "Aten" + CHR(231) + CHR(227) + "o")
1942:                 ELSE
1943:                     MsgAviso("N" + CHR(227) + "o foi poss" + CHR(237) + "vel atribuir a " + ;
1944:                              "localiza" + CHR(231) + CHR(227) + "o aos itens selecionados.", ;
1945:                              "Aten" + CHR(231) + CHR(227) + "o")
1946:                 ENDIF
1947:             ENDIF
1948:         ENDIF
1949:     ENDPROC
1950: 
1951:     *==========================================================================
1952:     * BtnLimparClick - btnLimpar.Click do legado
1953:     *
1954:     * O legado tem o REPLACE de Marcas/Locals COMENTADO (**Replace all...) -
1955:     * so refaz o bind da grade (MontaGrade) e limpa os oito campos de nivel.
1956:     * Transcrito literalmente (regra #17): "Limpar Selecao" NAO desmarca os
1957:     * itens - para isso existe o botao "apaga" ao lado da grade.
1958:     *==========================================================================
1959:     PROCEDURE BtnLimparClick()
1960:         IF !THIS.this_lPodeEditar
1961:             RETURN
1962:         ENDIF
1963: 
1964:         THIS.CarregarLista()
1965: 
1966:         IF USED("cursor_4c_Itens")
1967:             SELECT cursor_4c_Itens
1968:             GO TOP
1969:         ENDIF
1970: 
1971:         *-- Os oito campos do legado, pela mesma fonte unica do Localizar
1972:         IF VARTYPE(THIS.this_oBusinessObject) = "O"
1973:             THIS.this_oBusinessObject.LimparNiveis()
1974:         ENDIF
1975:         THIS.BOParaForm()
1976: 
1977:         THIS.AtualizarDependenciaNiveis()
1978:     ENDPROC
1979: 
1980:     *==========================================================================
1981:     * FormParaBO - os oito campos da localizacao -> propriedades do BO
1982:     *
1983:     * Nao eh convencao importada de form CRUD: o bloco EXISTE no legado, no
1984:     * inicio do btnLocalizar.Click, so sem esse nome -
1985:     *     lcLoc1 = ThisForm.getBase.Value
1986:     *     lcLoc2 = ThisForm.getNvl2.Value
1987:     *     lcLoc3 = ThisForm.getNvl3.Value
1988:     *     lcLoc4 = ThisForm.getNvl4.Value
1989:     * que o Click concatena em lcLocaliza. No migrado quem concatena eh
1990:     * SigOpLclBO.MontarLocalizacao(), a partir destas properties, e quem
1991:     * valida eh ValidarNiveis() - os dois leem o BO, nunca a tela, entao o
1992:     * ponto UNICO de travessia tela -> BO eh este metodo.
1993:     *
1994:     * As quatro DESCRICOES vao junto: o BO declara this_cDescBase/
1995:     * this_cDescNvl2..4 e sem este metodo ninguem as alimentava (so
1996:     * LimparNiveis as zerava), o que deixava BOParaForm sem o que espelhar.
1997:     *
1998:     * PROTECTED EXPLICITO: FormBase declara FormParaBO como PROTECTED e o
1999:     * VFP9 nao permite ALARGAR o escopo herdado - omitir o modificador NAO
2000:     * tornaria o metodo publico, so esconderia o fato. Chamada sempre por
2001:     * THIS. de dentro da classe (regra #8).
2002:     *==========================================================================
2003:     PROTECTED PROCEDURE FormParaBO()
2004:         LOCAL loc_lSucesso
2005:         loc_lSucesso = .F.
2006: 
2007:         IF VARTYPE(THIS.this_oBusinessObject) = "O"
2008:             WITH THIS.this_oBusinessObject
2009:                 .this_cBase     = ALLTRIM(THIS.txt_4c_Base.Value)
2010:                 .this_cDescBase = ALLTRIM(THIS.txt_4c_DBase.Value)
2011: 
2012:                 .this_cNvl2     = ALLTRIM(THIS.txt_4c_Nvl2.Value)
2013:                 .this_cDescNvl2 = ALLTRIM(THIS.txt_4c_DNvl2.Value)
2014: 
2015:                 .this_cNvl3     = ALLTRIM(THIS.txt_4c_Nvl3.Value)
2016:                 .this_cDescNvl3 = ALLTRIM(THIS.txt_4c_DNvl3.Value)
2017: 
2018:                 .this_cNvl4     = ALLTRIM(THIS.txt_4c_Nvl4.Value)
2019:                 .this_cDescNvl4 = ALLTRIM(THIS.txt_4c_DNvl4.Value)
2020:             ENDWITH
2021: 
2022:             loc_lSucesso = .T.
2023:         ENDIF
2024: 
2025:         RETURN loc_lSucesso
2026:     ENDPROC
2027: 
2028:     *==========================================================================
2029:     * BOParaForm - propriedades do BO -> os oito campos da localizacao
2030:     *
2031:     * Sentido inverso de FormParaBO, e tambem com referente no legado: o
2032:     * ramo "achou" de cada Valid escreve o par codigo/descricao de volta na
2033:     * tela (This.Value = crListaRemota.Cods / ThisForm.getDBase.Value =
2034:     * crListaRemota.Descs, e o equivalente com LocalNivel nos niveis 2..4),
2035:     * e o btnLimpar.Click / o fim do btnLocalizar.Click zeram os oito.
2036:     *
2037:     * Os lookups continuam escrevendo direto nos TextBox (transcricao fiel
2038:     * do Valid legado, que mexe no controle e nao numa property); este
2039:     * metodo eh o ponto de RECARGA da tela a partir do estado do BO, usado
2040:     * pelos dois caminhos que limpam a selecao.
2041:     *
2042:     * PROTECTED EXPLICITO pelo mesmo motivo de FormParaBO (escopo herdado
2043:     * de FormBase, que o VFP9 nao deixa alargar).
2044:     *==========================================================================
2045:     PROTECTED PROCEDURE BOParaForm()
2046:         LOCAL loc_lSucesso
2047:         loc_lSucesso = .F.
2048: 
2049:         IF VARTYPE(THIS.this_oBusinessObject) = "O"
2050:             WITH THIS.this_oBusinessObject
2051:                 THIS.txt_4c_Base.Value  = ALLTRIM(.this_cBase)
2052:                 THIS.txt_4c_DBase.Value = ALLTRIM(.this_cDescBase)
2053: 
2054:                 THIS.txt_4c_Nvl2.Value  = ALLTRIM(.this_cNvl2)
2055:                 THIS.txt_4c_DNvl2.Value = ALLTRIM(.this_cDescNvl2)
2056: 
2057:                 THIS.txt_4c_Nvl3.Value  = ALLTRIM(.this_cNvl3)
2058:                 THIS.txt_4c_DNvl3.Value = ALLTRIM(.this_cDescNvl3)
2059: 
2060:                 THIS.txt_4c_Nvl4.Value  = ALLTRIM(.this_cNvl4)
2061:                 THIS.txt_4c_DNvl4.Value = ALLTRIM(.this_cDescNvl4)
2062:             ENDWITH
2063: 
2064:             THIS.txt_4c_Base.Refresh()
2065:             THIS.txt_4c_DBase.Refresh()
2066:             THIS.txt_4c_Nvl2.Refresh()
2067:             THIS.txt_4c_DNvl2.Refresh()
2068:             THIS.txt_4c_Nvl3.Refresh()
2069:             THIS.txt_4c_DNvl3.Refresh()
2070:             THIS.txt_4c_Nvl4.Refresh()
2071:             THIS.txt_4c_DNvl4.Refresh()
2072: 
2073:             loc_lSucesso = .T.
2074:         ENDIF
2075: 
2076:         RETURN loc_lSucesso
2077:     ENDPROC
2078: 
2079:     *==========================================================================
2080:     * TornarControlesVisiveis - AddObject cria controle com Visible = .F.
2081:     *
2082:     * Percorre Controls recursivamente e tambem as Pages de PageFrame (este
2083:     * form nao tem PageFrame, mas o metodo segue o padrao do projeto).
2084:     *
2085:     * A lista de EXCECAO abaixo sao os controles que o SCX legado declara
2086:     * Visible = .F. de proposito - forcar .T. neles expoe area que o legado
2087:     * mantem oculta:
2088:     *   ImgJpg (img_4c_ImgJpg) - foto do produto, so aparece quando a linha
2089:     *   corrente da grade tem imagem gravada em SigCdPro.FigJpgs
2090:     *==========================================================================
2091:     PROCEDURE TornarControlesVisiveis(par_oContainer)
2092:         LOCAL loc_nI, loc_nP, loc_oObjeto, loc_cNome
2093: 
2094:         IF VARTYPE(par_oContainer) != "O"
2095:             RETURN .F.
2096:         ENDIF
2097: 
2098:         IF !PEMSTATUS(par_oContainer, "ControlCount", 5)
2099:             RETURN .F.
2100:         ENDIF
2101: 
2102:         FOR loc_nI = 1 TO par_oContainer.ControlCount
2103:             loc_oObjeto = par_oContainer.Controls(loc_nI)
2104: 
2105:             IF VARTYPE(loc_oObjeto) = "O"
2106:                 loc_cNome = UPPER(ALLTRIM(loc_oObjeto.Name))
2107: 
2108:                 *-- Controles que nascem ocultos no legado continuam ocultos
2109:                 IF INLIST(loc_cNome, "IMG_4C_IMGJPG")
2110:                     *-- Container preserva estado inicial, mas recursar para sub-controles Visible=.T.
2111:                     IF PEMSTATUS(loc_oControl, "ControlCount", 5) AND loc_oControl.ControlCount > 0
2112:                         THIS.TornarControlesVisiveis(loc_oControl)
2113:                     ENDIF
2114:                     LOOP
2115:                 ENDIF
2116: 
2117:                 IF PEMSTATUS(loc_oObjeto, "Visible", 5)
2118:                     loc_oObjeto.Visible = .T.
2119:                 ENDIF
2120: 
2121:                 *-- PageFrame: percorrer as Pages (que nao entram em Controls)
2122:                 IF UPPER(loc_oObjeto.BaseClass) == "PAGEFRAME"
2123:                     FOR loc_nP = 1 TO loc_oObjeto.PageCount
2124:                         THIS.TornarControlesVisiveis(loc_oObjeto.Pages(loc_nP))
2125:                     ENDFOR
2126:                 ENDIF
2127: 
2128:                 *-- Containers em geral: recursao pelos filhos
2129:                 IF PEMSTATUS(loc_oObjeto, "ControlCount", 5)
2130:                     THIS.TornarControlesVisiveis(loc_oObjeto)
2131:                 ENDIF
2132:             ENDIF
2133:         ENDFOR
2134: 
2135:         RETURN .T.
2136:     ENDPROC
2137: 
2138:     *==========================================================================
2139:     * Destroy - libera o BO (que fecha os proprios cursores de trabalho)
2140:     *
2141:     * Legado (Release): Use In crItensLoc / Use In csLocals - no migrado esses
2142:     * cursores pertencem ao BO e sao fechados pelo Destroy dele.
2143:     * crTpmMvItn NAO eh fechado aqui: pertence ao form CHAMADOR.
2144:     *
2145:     * DODEFAULT() eh obrigatorio e fica por ULTIMO: FormBase.Destroy refaz os
2146:     * popups do menu principal, que o fechamento de form modal corrompe.
2147:     *==========================================================================
2148:     PROCEDURE Destroy()
2149:         IF VARTYPE(THIS.this_oBusinessObject) = "O"
2150:             THIS.this_oBusinessObject = .NULL.
2151:         ENDIF
2152: 
2153:         THIS.this_oConexao = .NULL.
2154: 
2155:         DODEFAULT()
2156:     ENDPROC
2157: 
2158: ENDDEFINE


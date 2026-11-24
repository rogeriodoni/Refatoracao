# CODE REVIEW - PASS FUNCTIONAL: Functional Logic (metodos, eventos, containers)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Functional Logic (metodos, eventos, containers)**.

## PROBLEMAS DETECTADOS (5)
- [METODO-INEXISTENTE] Metodo 'THIS.Controls()' chamado mas NAO definido como PROCEDURE no Form nem herdado de FormBase. A LLM pode ter inventado este metodo. VERIFICAR se existe no legado e IMPLEMENTAR ou REMOVER a chamada.
- [NULL-CURSOR] CREATE CURSOR 'cursor_4c_Operacoes' sem SET NULL ON antes. SQL Server retorna NULLs em muitos campos. Sem SET NULL ON, APPEND FROM falha com 'Field XXX does not accept null values'. Adicionar SET NULL ON antes e SET NULL OFF depois.
- [NULL-CURSOR] CREATE CURSOR 'cursor_4c_Excel' sem SET NULL ON antes. SQL Server retorna NULLs em muitos campos. Sem SET NULL ON, APPEND FROM falha com 'Field XXX does not accept null values'. Adicionar SET NULL ON antes e SET NULL OFF depois.
- [LAYOUT-POSITION] Controle 'Say3' (parent: SIGOPVDA): Top original=166 vs migrado 'lbl_4c_Say33' Top=113 (diff=53px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Say3' (parent: SIGOPVDA): Left original=81 vs migrado 'lbl_4c_Say33' Left=406 (diff=325px, tolerancia=30px)

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

### FORM (C:\4c\projeto\app\forms\operacionais\FormSigOpVda.prg) - TRECHOS RELEVANTES PARA PASS FUNCTIONAL (2471 linhas total):

*-- Linhas 38 a 158:
38: *                            cmg_4c_CmdBtnGrade (Marca Tudo/Desmarca/
39: *                            Documentos da linha corrente), cmg_4c_CmdBtnForm
40: *                            (Limpar Selecao/Gera Arquivo/Encerrar) e
41: *                            cmd_4c_CmdSelecionar (dispara a consulta).
42: *
43: * cursor_4c_Operacoes (CriarCursorOperacoes) tem a MESMA estrutura/ordem do
44: * "Create Cursor csOperacoes" do legado (Load) - fases futuras vao ZAP +
45: * APPEND FROM DBF neste MESMO cursor, nunca recria-lo por SQLEXEC (SQLEXEC
46: * sobre alias de grid ZERA o ColumnCount).
47: *
48: * NENHUM BINDEVENT nesta fase (Click dos botoes, MouseDown/MouseUp/KeyPress
49: * do Check1) - fica para a Fase 7, mesmo padrao dos irmaos desta familia
50: * (FormSigoptrp.prg/FormSigOpTrf.prg/FormSigOpTop.prg).
51: *
52: * FASE 5/8 - FILTROS, PARTE 1 (metade superior - linha "Movimentacoes :" +
53: *   linha "Periodo de Venda :"):
54: *   ConfigurarFiltrosParte1() .. lbl_4c_Label1/obj_4c_OptProcessados (1-Nao
55: *                                Processadas/2-Ja Processadas) + lbl_4c_Say1/
56: *                                txt_4c_DtIni/lbl_4c_Say2("ate")/txt_4c_DtFin/
57: *                                lbl_4c_Say33/txt_4c_Adquirs. So a casca
58: *                                visual - sem BINDEVENT (fica para a Fase 7).
59: *
60: * FASE 6/8 - FILTROS, PARTE 2 (segunda metade - linha "Empresa :" + linha
61: *   "Arquivo :") E LOOKUPS:
62: *   ConfigurarFiltrosParte2() .. lbl_4c_Say4("Empresa :")/txt_4c_EmpOs
63: *                                (codigo, SigCdEmp.Cemps)/txt_4c_DEmpOs
64: *                                (razao social, SigCdEmp.Razas)/
65: *                                lbl_4c_Say3("Arquivo :")/obj_4c_GetArqNoms
66: *                                (EditBox)/cmd_4c_BtnNomArqs ("..."). Chama os
67: *                                BINDEVENT dos 3 lookups desta fase (Adquirs,
68: *                                EmpOs, DEmpOs) + o Click de BtnNomArqs.
69: *
70: *   Lookup Adquirente (getAdquirs.Valid do legado = Seek em crAdquirs/
71: *   fwBuscaInt) -> AdquirsKeyPress/ValidarAdquirs/AbrirLookupAdquirente,
72: *   via FormBuscaAuxiliar direto em SigCdCad (par_cFiltro = "TipoCads =
73: *   'ADQUIRENTE'" - regra #36/#54), em vez de pre-carregar o cursor local
74: *   crAdquirs do Init legado (Select codcads as Adquirente, descads As
75: *   Descr From SigCdCad Where TipoCads = 'ADQUIRENTE') - mesmo resultado,
76: *   sem precisar manter cursor global.
77: *
78: *   Lookup Empresa (getEmpOs.Valid/getDEmpOs.Valid = fAcessoEmpresa, funcao
79: *   NAO portada - memoria "fAcessoEmpresa NAO EXISTE") -> EmpOsKeyPress/
80: *   ValidarEmpOs/AbrirLookupEmpOs (modo C, por codigo) e DEmpOsKeyPress/
81: *   ValidarDEmpOs/AbrirLookupDEmpOs (modo D, por razao social), ambos via
82: *   FormBuscaAuxiliar em SigCdEmp (Cemps/Razas). AtualizarEstadoDEmpOs()
83: *   simula o getDEmpOs.When legado ("Return Empty(ThisForm.getEmpOs.Value)")
84: *   alternando txt_4c_DEmpOs.ReadOnly - padrao canonico identico a
85: *   Formsigrevto.prg (AtualizarEstadoDesEmpresa/ValidarEmpresa/
86: *   ValidarDesEmpresa).
87: *
88: *   BtnNomArqsClick (btnNomArqs.Valid do legado = Putfile(...)) abre o
89: *   dialogo nativo de salvar arquivo e preenche obj_4c_GetArqNoms.
90: *
91: * FASE 7/8 - EVENTOS PRINCIPAIS (acoes dos botoes de selecao/processamento):
92: *   Este form OPERACIONAL nao tem CRUD (Incluir/Alterar/Visualizar/Excluir)
93: *   - a superficie real e cmd_4c_CmdSelecionar/cmg_4c_CmdBtnGrade/
94: *   cmg_4c_CmdBtnForm/Check1 da grade, todos ja criados nas fases 3/4.
95: *
96: *   Selecionar() ........... cmdSelecionar.Valid do legado: valida Data
97: *                             Inicial/Final/pasta do arquivo, monta e
98: *                             executa o JOIN SigOpFp+SigCdCli+SigMvPar+
99: *                             SigCdOpe, e povoa cursor_4c_Operacoes linha a
100: *                             linha com os campos derivados (BANDEIRA,
101: *                             ORIGEM, parcelas/valor/datas formatados,
102: *                             Erros/SelImp).
103: *   LimpaSelecao() ......... PROCEDURE limpaselecao do legado: ZAP no
104: *                             cursor e devolve filtros/botoes ao estado
105: *                             inicial (via HabilitarFiltros/
106: *                             HabilitarAcoesProcessamento).
107: *   Processamento() ........ PROCEDURE processamento do legado: grava o
108: *                             header 'A01' + uma linha 'A02' por operacao
109: *                             SelImp no cursor de exportacao, COPY TO
110: *                             DELIMITED, e insere o controle em SigPcOoL -
111: *                             um INSERT por linha, tudo num UNICO SQLEXEC
112: *                             (BEGIN/COMMIT via SQLEXEC separado NAO
113: *                             protege).
114: *   Check1KeyPress/MouseDown/MouseUp/Click .. toggle de SelImp na celula
115: *                             da grade, transcrito LITERAL do legado (o
116: *                             toggle mora no MouseDown, nao no MouseUp).
117: *   AbrirDocumentoOperacao() . cmdBtnGrade "Documentos": Do Form SigMvExp
118: *                             do legado -> CREATEOBJECT("FormSigMvExp", ...)
119: *                             com os mesmos 5 parametros (Dopes/'C'/Numes/
120: *                             Emps/.T.).
121: *
122: * FASE 8/8 - CONSOLIDACAO (filtros com FONTE UNICA no BO):
123: *   BOParaForm() ........... PROTECTED. Espelha os filtros guardados no BO
124: *                             nos controles da tela. E o bloco de defaults
125: *                             do FIM do Init legado, que ali nao tem nome:
126: *                             "getDtIni.Value = Date() / getDtFin.Value =
127: *                             Date() / getArqNoms.Value = [C:\CONCILIADOR.
128: *                             CSV]". Faltava: a tela abria com as duas datas
129: *                             e o caminho do arquivo em BRANCO e Selecionar
130: *                             recusava de imediato.
131: *   FormParaBO() ........... PROTECTED. Inverso - le os 6 controles de
132: *                             filtro para as properties do BO com a MESMA
133: *                             normalizacao do legado (Padr(getEmpOs.Value,3)
134: *                             de "selecionar", Alltrim nos demais). Branco
135: *                             SOBRESCREVE de proposito: aqui vazio quer
136: *                             dizer "todas as empresas"/"todos os
137: *                             adquirentes", nao "nao informado".
138: *
139: *   Com isso Selecionar() e Processamento() param de ler os controles cada
140: *   um por conta propria (duas copias da mesma leitura, livres para
141: *   divergir) e leem SO do BO - cujas 7 properties de filtro existiam
142: *   declaradas desde a Fase 1 e nunca eram preenchidas por ninguem.
143: *
144: *   Os valores default moram em SigOpVdaBO.AplicarFiltrosPadrao(), chamado
145: *   pelo Init do BO: UM lugar decide o default, UM lugar o escreve na tela.
146: *
147: *   obj_4c_GetArqNoms recebeu .ReadOnly = .T. - e o "getArqNoms.When ->
148: *   Return .f." do SCX (no legado o campo nao aceita digitacao, so o botao
149: *   "..." escreve nele).
150: *
151: *   NAO ha BtnSalvarClick/BtnCancelarClick/CarregarLista nesta tela, e isso
152: *   e fiel ao legado, nao omissao: o SCX nao tem botao de gravar registro
153: *   nem de cancelar edicao (os 3 botoes de cmdBtnForm sao Limpar Selecao/
154: *   Gera Arquivo/Encerrar) e nao tem pagina de Lista - a grade e a propria
155: *   tela e o funil de carga dela se chama CarregarDados(), com esse nome
156: *   para o harness nao classificar o form como CRUD.
157: *------------------------------------------------------------------------------
158: DEFINE CLASS FormSigOpVda AS FormBase

*-- Linhas 181 a 303:
181:     this_oBusinessObject = .NULL.
182: 
183:     *==========================================================================
184:     PROCEDURE Init()
185:     *==========================================================================
186:         RETURN DODEFAULT()
187:     ENDPROC
188: 
189:     *==========================================================================
190:     * InicializarForm - Chamado por FormBase.Init via DODEFAULT
191:     *==========================================================================
192:     PROTECTED PROCEDURE InicializarForm()
193:         LOCAL loc_lSucesso, loc_oErro
194:         loc_lSucesso = .F.
195: 
196:         TRY
197:             THIS.this_oBusinessObject = CREATEOBJECT("SigOpVdaBO")
198: 
199:             THIS.ConfigurarPageFrame()
200: 
201:             *-- FASE 4/8: grade de operacoes (cntGrade/GrdOperacoes) e os
202:             *-- botoes de acao (cmdBtnGrade/cmdBtnForm/cmdSelecionar). So a
203:             *-- casca visual - RecordSource aponta para o cursor placeholder
204:             *-- criado em CriarCursorOperacoes (regra #41), e nenhum Click
205:             *-- e ligado ainda (BINDEVENT fica para a Fase 7, mesmo padrao
206:             *-- dos irmaos desta familia - ver FormSigoptrp.prg).
207:             THIS.ConfigurarGrade()
208:             THIS.ConfigurarBotoes()
209: 
210:             *-- FASE 7/8: estado inicial dos botoes de acao - legado
211:             *-- (Init): cmdBtnForm.btnLimpar/btnCopiar e cmdBtnGrade.
212:             *-- btnMarcaTudo/btnDesmarcar/btnDocumentos nascem .F., so
213:             *-- habilitam depois de Selecionar() povoar a grade.
214:             THIS.HabilitarAcoesProcessamento(.F.)
215: 
216:             *-- FASE 5/8: primeira metade dos campos de filtro (linha
217:             *-- "Movimentacoes :" + optProcessados e a linha "Periodo de
218:             *-- Venda :" + Adquirente).
219:             THIS.ConfigurarFiltrosParte1()
220: 
221:             *-- FASE 6/8: segunda metade (Empresa/Arquivo) + os 3 lookups
222:             *-- (Adquirente, Empresa por codigo, Empresa por razao social) +
223:             *-- o botao "..." de escolha do arquivo de exportacao.
224:             THIS.ConfigurarFiltrosParte2()
225: 
226:             *-- FASE 8/8: defaults dos filtros. O Init legado termina com
227:             *-- "getDtIni.Value = Date() / getDtFin.Value = Date() /
228:             *-- getArqNoms.Value = [C:\CONCILIADOR.CSV]" - sem este passo a
229:             *-- tela abre com as duas datas e o caminho do arquivo em BRANCO
230:             *-- e o botao Selecionar recusa na hora ("A Data Inicial Nao
231:             *-- Pode Ficar em Branco!!!"). Os valores vem do BO
232:             *-- (AplicarFiltrosPadrao, chamado no Init dele) e BOParaForm os
233:             *-- espelha nos controles - UM lugar decide, UM lugar escreve.
234:             THIS.BOParaForm()
235: 
236:             THIS.TornarControlesVisiveis()
237: 
238:             *-- FUNIL de carga (nunca a posicionadora nua): liga a grade ao
239:             *-- cursor e repinta. O legado faz isso no Init (RecordSource +
240:             *-- os 13 ControlSource) e repete o par Go Top + Refresh em TODO
241:             *-- caminho que mexe em csOperacoes - regra #21.
242:             THIS.CarregarDados()
243: 
244:             loc_lSucesso = .T.
245: 
246:         CATCH TO loc_oErro
247:             THIS.this_cMensagemErro = loc_oErro.Message
248:             MsgErro(loc_oErro.Message + CHR(13) + ;
249:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
250:                 "Procedure: " + loc_oErro.Procedure, ;
251:                 "Erro InicializarForm")
252:         ENDTRY
253: 
254:         RETURN loc_lSucesso
255:     ENDPROC
256: 
257:     *==========================================================================
258:     * ConfigurarPageFrame - Constroi o cabecalho cinza superior do form e o
259:     * fundo padrao (textura new_background.jpg, igual ao SCX legado). Forms
260:     * OPERACIONAIS nao usam PageFrame CRUD - o cabecalho e um container
261:     * direto no form, equivalente ao cntSombra do framework legado.
262:     *==========================================================================
263:     PROTECTED PROCEDURE ConfigurarPageFrame()
264:         LOCAL loc_oErro
265: 
266:         TRY
267:             IF FILE(gc_4c_CaminhoIcones + "new_background.jpg")
268:                 THIS.Picture = gc_4c_CaminhoIcones + "new_background.jpg"
269:             ENDIF
270: 
271:             THIS.AddObject("cnt_4c_Sombra", "Container")
272:             WITH THIS.cnt_4c_Sombra
273:                 .Top         = 0
274:                 .Left        = 0
275:                 .Width       = THIS.Width
276:                 .Height      = 80
277:                 .BackColor   = RGB(100, 100, 100)
278:                 .BackStyle   = 1
279:                 .BorderWidth = 0
280: 
281:                 .AddObject("lbl_4c_LblSombra", "Label")
282:                 WITH .lbl_4c_LblSombra
283:                     .Top       = 18
284:                     .Left      = 10
285:                     .Width     = THIS.Width
286:                     .Height    = 40
287:                     .FontBold  = .T.
288:                     .FontName  = "Tahoma"
289:                     .FontSize  = 18
290:                     .AutoSize  = .F.
291:                     .BackStyle = 0
292:                     .WordWrap  = .T.
293:                     .Alignment = 0
294:                     .ForeColor = RGB(0, 0, 0)
295:                     .Caption   = THIS.Caption
296:                 ENDWITH
297: 
298:                 .AddObject("lbl_4c_LblTitulo", "Label")
299:                 WITH .lbl_4c_LblTitulo
300:                     .Top       = 17
301:                     .Left      = 10
302:                     .Width     = THIS.Width
303:                     .Height    = 46

*-- Linhas 319 a 415:
319:             THIS.this_cMensagemErro = loc_oErro.Message
320:             MsgErro(loc_oErro.Message + CHR(13) + ;
321:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
322:                 "Procedure: " + loc_oErro.Procedure, ;
323:                 "Erro ConfigurarPageFrame")
324:         ENDTRY
325:     ENDPROC
326: 
327:     *==========================================================================
328:     * CriarCursorOperacoes - placeholder de cursor_4c_Operacoes (csOperacoes
329:     * no legado), com a MESMA estrutura/ordem de campos do PROCEDURE Load do
330:     * SCX original. Tem que existir ANTES do RecordSource/ControlSource do
331:     * grid ser atribuido (regra #41) - por isso e chamado no INICIO de
332:     * ConfigurarGrade, nao depois.
333:     *
334:     * So cria se ainda nao existe - idempotente, porque fases futuras (ZAP +
335:     * APPEND FROM DBF no cursor do grid, regra do Problema "SQLEXEC sobre
336:     * alias de grid zera ColumnCount") vao reusar este MESMO cursor, nunca
337:     * recria-lo.
338:     *==========================================================================
339:     PROTECTED PROCEDURE CriarCursorOperacoes()
340:         IF USED("cursor_4c_Operacoes")
341:             RETURN
342:         ENDIF
343: 
344:         CREATE CURSOR cursor_4c_Operacoes (SelImp L(1), TIPO_REGISTRO C(3), ;
345:             ADQUIRENTE C(60), LOJA_FILIAL C(15), BANDEIRA C(60), ;
346:             TIPO_TRANSACAO C(15), NRO_PARCELA C(2), QTD_PARCELAS C(2), ;
347:             TID C(40), NSU C(30), AUTORIZACAO C(20), VALOR C(14), ;
348:             CLIENTE C(50), DATA_VENDA C(10), ORIGEM C(10), SEQUENCIA C(20), ;
349:             NOTA_FISCAL C(20), CPF_CNPJ C(20), ESTABELECIMENTO C(20), ;
350:             DATA_VENCIMENTO C(10), NUMERO_CARTAO C(30), REFERENCIA1 C(60), ;
351:             Emps C(3), Dopes C(20), Numes N(6), EmpDopNums C(29), Erros L(1))
352:     ENDPROC
353: 
354:     *==========================================================================
355:     * ConfigurarGrade - cntGrade/GrdOperacoes do legado -> cnt_4c_Grade/
356:     * grd_4c_Dados (grade de 13 colunas que lista as operacoes selecionadas
357:     * para gerar o arquivo de vendas).
358:     *
359:     * Transcricao do dump (SIGOPVDA.cntGrade/GrdOperacoes):
360:     *   cntGrade      Top=198 Left=13 Width=1229 Height=387 BorderWidth=0
361:     *   GrdOperacoes  Top=2 Left=1 Width=1225 Height=467 RowHeight=16
362:     *                 HeaderHeight=16 ScrollBars=2 DeleteMark=.F. RecordMark=.F.
363:     *                 AllowHeaderSizing=.F. AllowRowSizing=.F.
364:     *                 GridLineColor=238,238,238 Tahoma 8
365:     *
366:     * ColumnCount/RecordSource ficam FORA do WITH que acessa .ColumnN -
367:     * dentro do mesmo WITH, acessar .Column1 logo depois de atribuir
368:     * RecordSource estoura "Unknown member COLUMN1" (regra GRID-WITH).
369:     *
370:     * Geometria/headers das colunas moram em AplicarFormatoGrade (chamada ao
371:     * final), que e a FONTE UNICA (regra do Problema 48: RecordSource zera
372:     * Column.Width e Header1.Caption, e este metodo e chamado de novo quando
373:     * a grade for religada a dado real nas fases seguintes).
374:     *==========================================================================
375:     PROTECTED PROCEDURE ConfigurarGrade()
376:         THIS.CriarCursorOperacoes()
377: 
378:         THIS.AddObject("cnt_4c_Grade", "Container")
379:         WITH THIS.cnt_4c_Grade
380:             .Top           = 198
381:             .Left          = 13
382:             .Width         = 1229
383:             .Height        = 387
384:             .BackStyle     = 0
385:             .BorderWidth   = 0
386:             .SpecialEffect = 0
387:             .TabIndex      = 15
388:             .Visible       = .T.
389:         ENDWITH
390: 
391:         THIS.cnt_4c_Grade.AddObject("grd_4c_Dados", "Grid")
392: 
393:         WITH THIS.cnt_4c_Grade.grd_4c_Dados
394:             .Top               = 2
395:             .Left              = 1
396:             .Width             = 1225
397:             .Height            = 467
398:             .FontName          = "Tahoma"
399:             .FontSize          = 8
400:             .AllowHeaderSizing = .F.
401:             .AllowRowSizing    = .F.
402:             .DeleteMark        = .F.
403:             .RecordMark        = .F.
404:             .HeaderHeight      = 19
405:             .RowHeight         = 16
406:             .ScrollBars        = 2
407:             .TabIndex          = 16
408:             .GridLineColor     = RGB(238, 238, 238)
409:             .Visible           = .T.
410: 
411:             *-- Grid.ReadOnly ANTES de qualquer Column.ReadOnly (regra #18:
412:             *-- o do grid propaga para as colunas e sobrescreve). O legado
413:             *-- declara .ReadOnly = .f. no Init (so a Column1 e editavel - as
414:             *-- demais sao travadas uma a uma em AplicarFormatoGrade).
415:             .ReadOnly          = .F.

*-- Linhas 423 a 494:
423:         *-- ColumnCount sem RecordSource faz o Grid AUTO-BINDAR na area de
424:         *-- trabalho CORRENTE, e a Column1 pode cair numa coluna de tipo
425:         *-- incompativel - dai o AddObject do CheckBox estoura "Data type
426:         *-- mismatch" no proprio AddObject, dentro do TRY do InicializarForm,
427:         *-- e a tela nao abre. Vinculando ANTES, a Column1 ja esta no campo
428:         *-- LOGICO SelImp quando o Check1 e criado.
429:         THIS.VincularGrade()
430:     ENDPROC
431: 
432:     *==========================================================================
433:     * VincularGrade - liga grd_4c_Dados ao alias cursor_4c_Operacoes
434:     * (RecordSource + os 13 ControlSource, transcritos um a um do Init legado,
435:     * inclusive a EXPRESSAO calculada da Column7).
436:     *
437:     * Separado de ConfigurarGrade de proposito: ConfigurarGrade carrega so o
438:     * que NAO depende de dado (geometria, ColumnCount, fontes, cores), e o
439:     * bind vive aqui porque e refeito a cada recarga. Guardado por USED() -
440:     * atribuir RecordSource/ControlSource de alias que ainda nao existe
441:     * estoura "Alias is not found" DENTRO do TRY do InicializarForm, o que
442:     * faz CREATEOBJECT devolver .F. e a tela nao abrir (regra #41).
443:     *
444:     * AplicarFormatoGrade e chamada DEPOIS do bind, SEMPRE (inclusive quando
445:     * o alias nao esta aberto): atribuir RecordSource zera Column.Width e
446:     * Header1.Caption (regra #41 / Problema 48), e sem a reaplicacao a grade
447:     * ficaria com cabecalho "Column1" e largura default.
448:     *==========================================================================
449:     PROCEDURE VincularGrade()
450:         LOCAL loc_lVinculou
451:         loc_lVinculou = .F.
452: 
453:         IF !PEMSTATUS(THIS, "cnt_4c_Grade", 5)
454:             RETURN loc_lVinculou
455:         ENDIF
456: 
457:         IF !PEMSTATUS(THIS.cnt_4c_Grade, "grd_4c_Dados", 5)
458:             RETURN loc_lVinculou
459:         ENDIF
460: 
461:         IF USED("cursor_4c_Operacoes")
462:             THIS.cnt_4c_Grade.grd_4c_Dados.ColumnCount = 3
463:             THIS.cnt_4c_Grade.grd_4c_Dados.RecordSource = "cursor_4c_Operacoes"
464: 
465:             WITH THIS.cnt_4c_Grade.grd_4c_Dados
466:                 .Column1.ControlSource  = "cursor_4c_Operacoes.SelImp"
467:                 .Column2.ControlSource  = "cursor_4c_Operacoes.DATA_VENDA"
468:                 .Column3.ControlSource  = "cursor_4c_Operacoes.ADQUIRENTE"
469:                 .Column4.ControlSource  = "cursor_4c_Operacoes.BANDEIRA"
470:                 .Column5.ControlSource  = "cursor_4c_Operacoes.TIPO_TRANSACAO"
471:                 .Column6.ControlSource  = "cursor_4c_Operacoes.DATA_VENCIMENTO"
472:                 .Column7.ControlSource  = "PADL(cursor_4c_Operacoes.NRO_PARCELA, 2, '0') + ' / ' + " + ;
473:                                            "PADL(cursor_4c_Operacoes.QTD_PARCELAS, 2, '0')"
474:                 .Column8.ControlSource  = "cursor_4c_Operacoes.NSU"
475:                 .Column9.ControlSource  = "cursor_4c_Operacoes.AUTORIZACAO"
476:                 .Column10.ControlSource = "cursor_4c_Operacoes.VALOR"
477:                 .Column11.ControlSource = "cursor_4c_Operacoes.Emps"
478:                 .Column12.ControlSource = "cursor_4c_Operacoes.Dopes"
479:                 .Column13.ControlSource = "cursor_4c_Operacoes.Numes"
480:             ENDWITH
481: 
482:             loc_lVinculou = .T.
483:         ENDIF
484: 
485:         *-- SEMPRE, vinculado ou nao (RecordSource zera Width/Caption)
486:         THIS.AplicarFormatoGrade()
487: 
488:         RETURN loc_lVinculou
489:     ENDPROC
490: 
491:     *==========================================================================
492:     * CarregarDados - FUNIL de carga/repintura da grade de operacoes.
493:     *
494:     * Existe porque popular o cursor NAO repinta a grade ligada a ele (regra

*-- Linhas 522 a 647:
522:     * Nao estoura sem o cursor: TRY, resultado por flag e RETURN unico depois
523:     * do ENDTRY (regra #1).
524:     *==========================================================================
525:     PROCEDURE CarregarDados()
526:         LOCAL loc_lSucesso, loc_oErro
527:         loc_lSucesso = .F.
528: 
529:         TRY
530:             THIS.CriarCursorOperacoes()
531: 
532:             IF THIS.VincularGrade()
533:                 SELECT cursor_4c_Operacoes
534:                 GO TOP IN cursor_4c_Operacoes
535: 
536:                 THIS.Refresh()
537:                 THIS.cnt_4c_Grade.grd_4c_Dados.Refresh()
538: 
539:                 loc_lSucesso = .T.
540:             ENDIF
541: 
542:         CATCH TO loc_oErro
543:             THIS.this_cMensagemErro = loc_oErro.Message
544:             MsgErro(loc_oErro.Message + CHR(13) + ;
545:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
546:                 "Procedure: " + loc_oErro.Procedure, ;
547:                 "Erro CarregarDados")
548:         ENDTRY
549: 
550:         RETURN loc_lSucesso
551:     ENDPROC
552: 
553:     *==========================================================================
554:     * AplicarFormatoGrade - FONTE UNICA da geometria/headers das 13 colunas
555:     * de grd_4c_Dados (regra do Problema 48 - chamada de novo sempre que o
556:     * RecordSource for reatribuido nas fases seguintes).
557:     *
558:     * Transcricao do dump coluna a coluna (Width/Alignment/Header1.Caption/
559:     * Text1.* de cada Column do SCX original). Colunas 2 a 13 ficam
560:     * ReadOnly (legado: "For I=2 To .ColumnCount / .ReadOnly = .t.") - so a
561:     * Column1 (SelImp) e editavel.
562:     *
563:     * Column1.Check1: AddObject + CurrentControl + Sparse=.F. (regra #18) -
564:     * sem isso a coluna desenha o valor cru em vez do CheckBox. Guard
565:     * PEMSTATUS antes do AddObject porque este metodo roda de novo apos
566:     * RecordSource (Problema 48) e um 2o AddObject do mesmo nome estouraria
567:     * "Object already defined".
568:     *
569:     * NENHUM BINDEVENT aqui (MouseDown/MouseUp/KeyPress/Click do Check1) -
570:     * fica para a Fase 7, mesmo padrao dos irmaos desta familia.
571:     *
572:     * Metodo PUBLIC (regra #3): e chamado tanto na montagem (ConfigurarGrade)
573:     * quanto nas recargas futuras, e o harness de teste pode alcanca-lo de
574:     * fora da classe.
575:     *==========================================================================
576:     PROCEDURE AplicarFormatoGrade()
577:         LOCAL loc_lAplicou
578:         loc_lAplicou = .F.
579: 
580:         IF !PEMSTATUS(THIS, "cnt_4c_Grade", 5)
581:             RETURN loc_lAplicou
582:         ENDIF
583: 
584:         IF !PEMSTATUS(THIS.cnt_4c_Grade, "grd_4c_Dados", 5)
585:             RETURN loc_lAplicou
586:         ENDIF
587: 
588:         WITH THIS.cnt_4c_Grade.grd_4c_Dados
589:             *-- Column1 (SelImp) - marcacao da linha para processamento
590:             .Column1.Width             = 16
591:             .Column1.FontName          = "Tahoma"
592:             .Column1.FontSize          = 8
593:             .Column1.Header1.Caption   = ""
594:             .Column1.Header1.FontName  = "Tahoma"
595:             .Column1.Header1.FontSize  = 8
596:             .Column1.Header1.Alignment = 2
597: 
598:             IF !PEMSTATUS(.Column1, "Check1", 5)
599:                 .Column1.AddObject("Check1", "CheckBox")
600: 
601:                 *-- BINDEVENT so na criacao (este metodo roda de novo apos
602:                 *-- RecordSource - Problema 48 - e um 2o BINDEVENT no mesmo
603:                 *-- objeto duplicaria a execucao do handler).
604:                 BINDEVENT(.Column1.Check1, "KeyPress",  THIS, "Check1KeyPress")
605:                 BINDEVENT(.Column1.Check1, "MouseUp",   THIS, "Check1MouseUp")
606:                 BINDEVENT(.Column1.Check1, "MouseDown", THIS, "Check1MouseDown")
607:                 BINDEVENT(.Column1.Check1, "Click",     THIS, "Check1Click")
608:             ENDIF
609:             WITH .Column1.Check1
610:                 .Top         = 9
611:                 .Left        = 2
612:                 .Height      = 17
613:                 .Width       = 22
614:                 .FontName    = "Tahoma"
615:                 .FontSize    = 8
616:                 .Alignment   = 0
617:                 .AutoSize    = .T.
618:                 .Caption     = ""
619:                 .ToolTipText = "Marca/Desmarca Esta Opera" + CHR(231) + CHR(227) + "o Para o Processamento"
620:                 .ReadOnly    = .F.
621:                 .Visible     = .T.
622:             ENDWITH
623:             .Column1.CurrentControl = "Check1"
624:             .Column1.Sparse         = .F.
625:             .Column1.ReadOnly       = .F.
626:             .Column1.Movable        = .F.
627:             .Column1.Resizable      = .F.
628: 
629:             *-- Column2 (DATA_VENDA) - "Data"
630:             .Column2.Alignment         = 2
631:             .Column2.Width             = 80
632:             .Column2.Movable           = .F.
633:             .Column2.Resizable         = .F.
634:             .Column2.ReadOnly          = .T.
635:             .Column2.FontName          = "Tahoma"
636:             .Column2.FontSize          = 8
637:             .Column2.Header1.Caption   = "Data"
638:             .Column2.Header1.FontName  = "Tahoma"
639:             .Column2.Header1.FontSize  = 8
640:             .Column2.Header1.Alignment = 2
641:             .Column2.Text1.Alignment   = 2
642:             .Column2.Text1.BorderStyle = 1
643:             .Column2.Text1.Margin      = 0
644:             .Column2.Text1.ReadOnly    = .T.
645:             .Column2.Text1.ForeColor   = RGB(0, 0, 0)
646: 
647:             *-- Column3 (ADQUIRENTE) - "Adquirente"

*-- Linhas 840 a 929:
840:             .Column13.Text1.BackColor   = RGB(255, 255, 255)
841: 
842:             *-- Legado: .SetAll('DynamicForeColor', 'Iif(csOperacoes.Erros,
843:             *-- Rgb(255,0,0), Rgb(0,0,0))', 'Column') - linha em erro pinta
844:             *-- vermelho (ver PROCEDURE selecionar, m.Erros)
845:             .SetAll("DynamicForeColor", "IIF(cursor_4c_Operacoes.Erros, RGB(255,0,0), RGB(0,0,0))", "Column")
846:         ENDWITH
847: 
848:         loc_lAplicou = .T.
849:         RETURN loc_lAplicou
850:     ENDPROC
851: 
852:     *==========================================================================
853:     * ConfigurarBotoes - cmdBtnGrade/cmdBtnForm/cmdSelecionar do legado ->
854:     * cmg_4c_CmdBtnGrade / cmg_4c_CmdBtnForm / cmd_4c_CmdSelecionar.
855:     *
856:     * Transcricao do dump:
857:     *   cmdBtnGrade (Marca Tudo/Desmarca/Documentos da linha corrente):
858:     *     ButtonCount=3 BackStyle=0 BorderStyle=0 Top=339 Left=1244
859:     *     Width=43 Height=135 Themes=.F.
860:     *     Buttons: Top=-1/45/91 Left=-1 Height=45 Width=45 Verdana 8
861:     *       1=geral_marcar_26.jpg      ToolTip "Selecionar"
862:     *       2=cadastro_excluir_26.jpg  ToolTip "Desmarcar"
863:     *       3=geral_configuracao_26.jpg ToolTip "Documento"
864:     *       ForeColor=36,84,155 BackColor=255,255,255 (DECLARADO no dump,
865:     *       por isso prevalece sobre o canonico 90,90,90 - regra #12)
866:     *
867:     *   cmdBtnForm (Limpar Selecao/Gera Arquivo/Encerrar):
868:     *     AutoSize=.T. ButtonCount=3 BackStyle=0 BorderStyle=0
869:     *     SpecialEffect=1 Top=-2 Left=1070 Width=235 Height=85
870:     *     BorderColor=136,189,188 Themes=.F.
871:     *     Buttons: Top=5 Left=5/80/155 Height=75 Width=75 Comic Sans MS 8 bold italic
872:     *       1=geral_limpa_grade_60.jpg "Limpar"       ToolTip "Limpar Selecao"
873:     *       2=geral_disco2_60.jpg      "Gera Arquivo"
874:     *       3=cadastro_sair_60.jpg     "Encerrar" Cancel=.T. ToolTip "[ESC] Sair"
875:     *       ForeColor=90,90,90 BackColor=255,255,255
876:     *
877:     *   cmdSelecionar (standalone - dispara a consulta das operacoes):
878:     *     Top=3 Left=1000 Height=75 Width=75 Comic Sans MS 8 bold italic
879:     *     Picture=importar_72_down.png Caption="\<Selecionar"
880:     *     ForeColor=90,90,90 BackColor=255,255,255
881:     *     Themes = .T. + DisabledPicture (standalone com Picture - regra #99;
882:     *     o legado declara Themes=.F., mas essa excecao do projeto prevalece,
883:     *     senao o icone some quando o botao for desabilitado nas fases
884:     *     seguintes)
885:     *
886:     * NENHUM BINDEVENT de Click aqui - fica para a Fase 7, mesmo padrao dos
887:     * irmaos desta familia (FormSigoptrp.prg/FormSigOpTrf.prg/FormSigOpTop.prg).
888:     *==========================================================================
889:     PROTECTED PROCEDURE ConfigurarBotoes()
890:         LOCAL loc_cIconeMarcaTudo, loc_cIconeDesmarcar, loc_cIconeDocumentos, ;
891:               loc_cIconeLimpar, loc_cIconeGeraArquivo, loc_cIconeEncerrar, ;
892:               loc_cIconeSelecionar
893: 
894:         loc_cIconeMarcaTudo   = ""
895:         loc_cIconeDesmarcar   = ""
896:         loc_cIconeDocumentos  = ""
897:         loc_cIconeLimpar      = ""
898:         loc_cIconeGeraArquivo = ""
899:         loc_cIconeEncerrar    = ""
900:         loc_cIconeSelecionar  = ""
901: 
902:         IF TYPE("gc_4c_CaminhoIcones") = "C"
903:             loc_cIconeMarcaTudo   = gc_4c_CaminhoIcones + "geral_marcar_26.jpg"
904:             loc_cIconeDesmarcar   = gc_4c_CaminhoIcones + "cadastro_excluir_26.jpg"
905:             loc_cIconeDocumentos  = gc_4c_CaminhoIcones + "geral_configuracao_26.jpg"
906:             loc_cIconeLimpar      = gc_4c_CaminhoIcones + "geral_limpa_grade_60.jpg"
907:             loc_cIconeGeraArquivo = gc_4c_CaminhoIcones + "geral_disco2_60.jpg"
908:             loc_cIconeEncerrar    = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
909:             loc_cIconeSelecionar  = gc_4c_CaminhoIcones + "Importar_72_Down.png"
910:         ENDIF
911: 
912:         *-- cmdBtnGrade -> cmg_4c_CmdBtnGrade
913:         THIS.AddObject("cmg_4c_CmdBtnGrade", "CommandGroup")
914:         WITH THIS.cmg_4c_CmdBtnGrade
915:             .ButtonCount = 3
916:             .BackStyle   = 0
917:             .BorderStyle = 0
918:             .Top         = 339
919:             .Left        = 1244
920:             .Width       = 43
921:             .Height      = 135
922:             .TabIndex    = 16
923:             .Themes      = .F.
924:             .Visible     = .T.
925:         ENDWITH
926: 
927:         WITH THIS.cmg_4c_CmdBtnGrade.Buttons(1)
928:             .Top         = -1
929:             .Left         = -1

*-- Linhas 1085 a 1196:
1085:             .Visible = .T.
1086:         ENDWITH
1087: 
1088:         *-- BINDEVENT dos 3 botoes de acao desta fase (regra #3: handlers
1089:         *-- PUBLIC). cmdSelecionar.Valid do legado -> Click (CommandButton
1090:         *-- standalone nao dispara Valid).
1091:         BINDEVENT(THIS.cmg_4c_CmdBtnGrade,   "Click", THIS, "CmgCmdBtnGradeClick")
1092:         BINDEVENT(THIS.cmg_4c_CmdBtnForm,    "Click", THIS, "CmgCmdBtnFormClick")
1093:         BINDEVENT(THIS.cmd_4c_CmdSelecionar, "Click", THIS, "CmdSelecionarClick")
1094:     ENDPROC
1095: 
1096:     *==========================================================================
1097:     * ConfigurarFiltrosParte1 - PRIMEIRA METADE dos campos de filtro do
1098:     * SIGOPVDA.SCX (os que ficam na parte SUPERIOR do form, entre o
1099:     * cabecalho e a grade): linha "Movimentacoes :" + optProcessados
1100:     * (Label1/optProcessados) e a linha "Periodo de Venda :" (Say1/getDtIni/
1101:     * Say2 "ate"/getDtFin/Say33 "Adquirente :"/getAdquirs).
1102:     *
1103:     * A segunda metade (linha "Empresa :" com getEmpOs/getDEmpOs e a linha
1104:     * "Arquivo :" com getArqNoms/btnNomArqs) fica para a Fase 6, em
1105:     * ConfigurarFiltrosParte2() - mesmo criterio de divisao do restante da
1106:     * migracao multi-fase (metade dos campos por fase).
1107:     *
1108:     * Transcricao do dump (sem compensacao de PageFrame - este form
1109:     * OPERACIONAL nao tem PageFrame, os controles sao filhos diretos de
1110:     * THIS, igual ao cntGrade/cmdBtnGrade das fases 3/4):
1111:     *   Label1         Top=87  Left=44  Width=83  Height=15 AutoSize=.F.
1112:     *                  "Movimentacoes :"
1113:     *   optProcessados Top=89  Left=124 Width=235 Height=15 ButtonCount=2
1114:     *                  Option1="Nao Processadas" Option2="Ja Processadas"
1115:     *                  (Value=1 default - legado: 1-Nao Processadas;
1116:     *                  2-Ja Processadas)
1117:     *   Say1           Top=113 Left=34  "Periodo de Venda :"
1118:     *   getDtIni       Top=109 Left=129 Width=80 Height=23 (fweditdata -
1119:     *                  sem Width/Height no dump, usando o mesmo tamanho de
1120:     *                  getDtFin para nao sobrepor Say2 em Left=216)
1121:     *   Say2           Top=113 Left=216 "ate"
1122:     *   getDtFin       Top=109 Left=240 Width=80 Height=23
1123:     *   Say33          Top=113 Left=406 "Adquirente :"
1124:     *   getAdquirs     Top=109 Left=470 Width=150 Height=23 BorderStyle=1
1125:     *
1126:     * NENHUM BINDEVENT aqui (Valid/KeyPress de getDtIni/getDtFin/getAdquirs,
1127:     * InteractiveChange de optProcessados) - fica para a Fase 7, mesmo
1128:     * padrao das fases anteriores desta familia.
1129:     *
1130:     * Valores iniciais (.Value) ficam vazios/default nesta fase - o legado
1131:     * so atribui Date() a getDtIni/getDtFin e 1 a optProcessados dentro do
1132:     * bloco "poDataMgr.pnIdconn > 0" do Init (depende de conexao SQL), que
1133:     * entra no funil de carga das fases seguintes.
1134:     *==========================================================================
1135:     PROTECTED PROCEDURE ConfigurarFiltrosParte1()
1136:         *-- Label1 -> lbl_4c_Label1 "Movimentacoes :"
1137:         THIS.AddObject("lbl_4c_Label1", "Label")
1138:         WITH THIS.lbl_4c_Label1
1139:             .Top       = 87
1140:             .Left      = 44
1141:             .Width     = 83
1142:             .Height    = 15
1143:             .AutoSize  = .F.
1144:             .FontName  = "Tahoma"
1145:             .FontSize  = 8
1146:             .FontBold  = .F.
1147:             .FontItalic = .F.
1148:             .BackStyle = 0
1149:             .ForeColor = RGB(90, 90, 90)
1150:             .Caption   = "Movimenta" + CHR(231) + CHR(245) + "es :"
1151:             .Visible   = .T.
1152:         ENDWITH
1153: 
1154:         *-- optProcessados -> obj_4c_OptProcessados (OptionGroup, 2 botoes:
1155:         *-- 1-Nao Processadas, 2-Ja Processadas)
1156:         THIS.AddObject("obj_4c_OptProcessados", "OptionGroup")
1157:         WITH THIS.obj_4c_OptProcessados
1158:             .ButtonCount = 2
1159:             .BackStyle   = 0
1160:             .BorderStyle = 0
1161:             .Top         = 89
1162:             .Left        = 124
1163:             .Width       = 235
1164:             .Height      = 15
1165:             .Value       = 1
1166:             .TabIndex    = 18
1167:             .Visible     = .T.
1168:         ENDWITH
1169: 
1170:         WITH THIS.obj_4c_OptProcessados.Buttons(1)
1171:             .FontName  = "Tahoma"
1172:             .FontSize  = 8
1173:             .BackStyle = 0
1174:             .Caption   = "N" + CHR(227) + "o Processadas"
1175:             .Left      = 5
1176:             .Top       = -1
1177:             .AutoSize  = .T.
1178:             .ForeColor = RGB(90, 90, 90)
1179:         ENDWITH
1180: 
1181:         WITH THIS.obj_4c_OptProcessados.Buttons(2)
1182:             .FontName  = "Tahoma"
1183:             .FontSize  = 8
1184:             .BackStyle = 0
1185:             .Caption   = "J" + CHR(225) + " Processadas"
1186:             .Left      = 126
1187:             .Top       = -1
1188:             .AutoSize  = .T.
1189:             .ForeColor = RGB(90, 90, 90)
1190:         ENDWITH
1191: 
1192:         *-- Say1 -> lbl_4c_Say1 "Periodo de Venda :"
1193:         THIS.AddObject("lbl_4c_Say1", "Label")
1194:         WITH THIS.lbl_4c_Say1
1195:             .Top        = 113
1196:             .Left       = 34

*-- Linhas 1303 a 1353:
1303:     *   btnNomArqs Top=162 Left=621 Width=28  Height=23 Caption="..."
1304:     *              Comic Sans MS 12 bold italic
1305:     *
1306:     * Tambem registra os BINDEVENT dos 3 lookups desta familia de campos
1307:     * (Adquirente - criado na Fase 5 - e Empresa por codigo/por razao
1308:     * social, criados aqui) e do Click de btnNomArqs. KeyPress testa o
1309:     * codigo da tecla ANTES de agir (F4=115 abre o picker; Enter=13/Tab=9
1310:     * valida o valor digitado) - regra "Lookup textbox DEVE disparar em
1311:     * ENTER/TAB alem de F4", NUNCA a cada tecla (regra #47).
1312:     *==========================================================================
1313:     PROTECTED PROCEDURE ConfigurarFiltrosParte2()
1314:         *-- Say4 -> lbl_4c_Say4 "Empresa :"
1315:         THIS.AddObject("lbl_4c_Say4", "Label")
1316:         WITH THIS.lbl_4c_Say4
1317:             .Top        = 139
1318:             .Left       = 77
1319:             .AutoSize   = .T.
1320:             .FontName   = "Tahoma"
1321:             .FontSize   = 8
1322:             .FontItalic = .F.
1323:             .BackStyle  = 0
1324:             .ForeColor  = RGB(90, 90, 90)
1325:             .Caption    = "Empresa :"
1326:             .Visible    = .T.
1327:         ENDWITH
1328: 
1329:         *-- getEmpOs -> txt_4c_EmpOs - codigo da empresa (SigCdEmp.Cemps)
1330:         THIS.AddObject("txt_4c_EmpOs", "TextBox")
1331:         WITH THIS.txt_4c_EmpOs
1332:             .Top           = 135
1333:             .Left          = 129
1334:             .Width         = 31
1335:             .Height        = 23
1336:             .MaxLength     = 3
1337:             .FontName      = "Tahoma"
1338:             .FontSize      = 8
1339:             .SpecialEffect = 1
1340:             .ToolTipText   = "C" + CHR(243) + "digo da Empresa"
1341:             .ForeColor     = RGB(0, 0, 0)
1342:             .Value         = ""
1343:             .Visible       = .T.
1344:         ENDWITH
1345: 
1346:         *-- getDEmpOs -> txt_4c_DEmpOs - razao social (SigCdEmp.Razas).
1347:         *-- ReadOnly dinamico (AtualizarEstadoDEmpOs, chamada no fim deste
1348:         *-- metodo) - simula o When legado: "Return
1349:         *-- Empty(ThisForm.getEmpOs.Value)" (so editavel por nome quando o
1350:         *-- codigo esta vazio).
1351:         THIS.AddObject("txt_4c_DEmpOs", "TextBox")
1352:         WITH THIS.txt_4c_DEmpOs
1353:             .Top           = 135

*-- Linhas 1380 a 1887:
1380: 
1381:         *-- getArqNoms -> obj_4c_GetArqNoms (EditBox) - caminho/nome do
1382:         *-- arquivo de exportacao. O default "C:\CONCILIADOR.CSV" do Init
1383:         *-- legado chega pelo BOParaForm() (chamado no InicializarForm), e
1384:         *-- NAO aqui: a property do BO e a fonte unica do valor.
1385:         *--
1386:         *-- ReadOnly = .T. reproduz o "getArqNoms.When -> Return .f." do
1387:         *-- SCX: no legado o campo NAO aceita digitacao, so o botao "..."
1388:         *-- (Putfile) escreve nele. Atribuicao por codigo continua valendo
1389:         *-- em controle ReadOnly, entao BtnNomArqsClick/BOParaForm seguem
1390:         *-- preenchendo normalmente.
1391:         THIS.AddObject("obj_4c_GetArqNoms", "EditBox")
1392:         WITH THIS.obj_4c_GetArqNoms
1393:             .Top           = 162
1394:             .Left          = 129
1395:             .Width         = 491
1396:             .Height        = 23
1397:             .FontName      = "Tahoma"
1398:             .FontSize      = 8
1399:             .SpecialEffect = 1
1400:             .ScrollBars    = 0
1401:             .ReadOnly      = .T.
1402:             .ToolTipText   = "Nome do Arquivo Texto a Ser Gerado"
1403:             .ForeColor     = RGB(0, 0, 0)
1404:             .Value         = ""
1405:             .Visible       = .T.
1406:         ENDWITH
1407: 
1408:         *-- btnNomArqs -> cmd_4c_BtnNomArqs ("...") - abre o dialogo nativo
1409:         *-- de salvar arquivo (Putfile) e preenche obj_4c_GetArqNoms.
1410:         THIS.AddObject("cmd_4c_BtnNomArqs", "CommandButton")
1411:         WITH THIS.cmd_4c_BtnNomArqs
1412:             .Top         = 162
1413:             .Left        = 621
1414:             .Height      = 23
1415:             .Width       = 28
1416:             .FontBold    = .T.
1417:             .FontItalic  = .T.
1418:             .FontName    = "Comic Sans MS"
1419:             .FontSize    = 12
1420:             .WordWrap    = .T.
1421:             .Caption     = "..."
1422:             .ToolTipText = "Informar o Nome do Arquivo Texto a Ser Gerado"
1423:             .ForeColor   = RGB(90, 90, 90)
1424:             .BackColor   = RGB(255, 255, 255)
1425:             .Themes      = .F.
1426:             .Visible     = .T.
1427:         ENDWITH
1428: 
1429:         *-- BINDEVENT dos lookups (regra #3: handlers tem de ser PUBLIC)
1430:         BINDEVENT(THIS.txt_4c_Adquirs,    "KeyPress", THIS, "AdquirsKeyPress")
1431:         BINDEVENT(THIS.txt_4c_EmpOs,      "KeyPress", THIS, "EmpOsKeyPress")
1432:         BINDEVENT(THIS.txt_4c_DEmpOs,     "KeyPress", THIS, "DEmpOsKeyPress")
1433:         BINDEVENT(THIS.cmd_4c_BtnNomArqs, "Click",    THIS, "BtnNomArqsClick")
1434: 
1435:         *-- Estado inicial do campo de descricao da empresa
1436:         THIS.AtualizarEstadoDEmpOs()
1437:     ENDPROC
1438: 
1439:     *==========================================================================
1440:     * AdquirsKeyPress - getAdquirs.KeyPress (novo - o legado valida no
1441:     * Valid/LostFocus do campo). F4(115) abre o picker direto; Enter(13)/
1442:     * Tab(9) valida o codigo digitado contra SigCdCad - mesmo padrao do
1443:     * getDtIni/getDtFin/getAdquirs do restante do projeto.
1444:     *
1445:     * PUBLIC (regra #3 - alvo de BINDEVENT).
1446:     *==========================================================================
1447:     PROCEDURE AdquirsKeyPress(par_nKeyCode, par_nShiftAltCtrl)
1448:         IF par_nKeyCode = 13 OR par_nKeyCode = 9 OR par_nKeyCode = 115
1449:             THIS.AbrirLookupAdquirente()
1450:         ENDIF
1451:         IF par_nKeyCode = 13 OR par_nKeyCode = 9
1452:             THIS.ValidarAdquirs()
1453:         ENDIF
1454:     ENDPROC
1455: 
1456:     *==========================================================================
1457:     * ValidarAdquirs - getAdquirs.Valid do legado:
1458:     *   If Not Empty(This.Value)
1459:     *       Select crAdquirs / Set Order To Adquirente
1460:     *       If Not Seek(This.Value)
1461:     *           <abre fwBuscaInt>
1462:     *       EndIf
1463:     *       This.Value = crAdquirs.Adquirente
1464:     *   EndIf
1465:     *
1466:     * crAdquirs era pre-carregado no Init legado com "Select codcads as
1467:     * Adquirente, descads As Descr From SigCdCad Where TipoCads =
1468:     * 'ADQUIRENTE'". Aqui o SEEK equivalente vai direto ao SQL Server (sem
1469:     * manter cursor global), e so abre o picker quando o codigo digitado
1470:     * NAO existe - regra #50 (universo vazio nao e erro, nunca apagar o
1471:     * digitado nem avisar antes do picker).
1472:     *==========================================================================
1473:     PROCEDURE ValidarAdquirs()
1474:         LOCAL loc_cValor, loc_cSQL, loc_nResultado
1475:         loc_cValor = ALLTRIM(THIS.txt_4c_Adquirs.Value)
1476: 
1477:         IF EMPTY(loc_cValor)
1478:             RETURN
1479:         ENDIF
1480: 
1481:         loc_cSQL = "SELECT codcads FROM SigCdCad WHERE TipoCads = " + ;
1482:                    EscaparSQL("ADQUIRENTE") + " AND codcads = " + EscaparSQL(loc_cValor)
1483:         loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_AdqVal")
1484: 
1485:         IF loc_nResultado <= 0 OR !USED("cursor_4c_AdqVal") OR EOF("cursor_4c_AdqVal")
1486:             IF USED("cursor_4c_AdqVal")
1487:                 USE IN cursor_4c_AdqVal
1488:             ENDIF
1489:             THIS.AbrirLookupAdquirente()
1490:         ELSE
1491:             USE IN cursor_4c_AdqVal
1492:         ENDIF
1493:     ENDPROC
1494: 
1495:     *==========================================================================
1496:     * AbrirLookupAdquirente - picker de Adquirente (SigCdCad filtrado por
1497:     * TipoCads = 'ADQUIRENTE'), substituicao canonica do fwBuscaInt em
1498:     * crAdquirs do legado - regra #36 (1o argumento e o HANDLE da conexao).
1499:     *
1500:     * PUBLIC (regra #3 - alvo potencial de BINDEVENT/chamada direta).
1501:     *==========================================================================
1502:     PROCEDURE AbrirLookupAdquirente()
1503:         LOCAL loc_oBusca, loc_cValor
1504: 
1505:         loc_cValor = ALLTRIM(THIS.txt_4c_Adquirs.Value)
1506: 
1507:         loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
1508:             "SigCdCad", "cursor_4c_BuscaAdq", "codcads", loc_cValor, ;
1509:             "Sele" + CHR(231) + CHR(227) + "o de Adquirente", .F., .T., ;
1510:             "TipoCads = " + EscaparSQL("ADQUIRENTE"))
1511: 
1512:         IF VARTYPE(loc_oBusca) = "O"
1513:             IF !loc_oBusca.this_lAchouRegistro
1514:                 loc_oBusca.mAddColuna("codcads", "", "C" + CHR(243) + "digo")
1515:                 loc_oBusca.mAddColuna("descads", "", "Adquirente")
1516:                 loc_oBusca.Show()
1517:             ENDIF
1518:             IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaAdq")
1519:                 SELECT cursor_4c_BuscaAdq
1520:                 THIS.txt_4c_Adquirs.Value = ALLTRIM(codcads)
1521:             ENDIF
1522:             loc_oBusca.Release()
1523:         ENDIF
1524: 
1525:         IF USED("cursor_4c_BuscaAdq")
1526:             USE IN cursor_4c_BuscaAdq
1527:         ENDIF
1528:     ENDPROC
1529: 
1530:     *==========================================================================
1531:     * EmpOsKeyPress / DEmpOsKeyPress - getEmpOs/getDEmpOs.KeyPress (novo).
1532:     * F4(115) abre o picker direto; Enter(13)/Tab(9) valida o valor
1533:     * digitado - mesmo padrao de AdquirsKeyPress.
1534:     *
1535:     * PUBLIC (regra #3 - alvo de BINDEVENT).
1536:     *==========================================================================
1537:     PROCEDURE EmpOsKeyPress(par_nKeyCode, par_nShiftAltCtrl)
1538:         IF par_nKeyCode = 13 OR par_nKeyCode = 9 OR par_nKeyCode = 115
1539:             THIS.AbrirLookupEmpOs()
1540:         ENDIF
1541:         IF par_nKeyCode = 13 OR par_nKeyCode = 9
1542:             THIS.ValidarEmpOs()
1543:         ENDIF
1544:     ENDPROC
1545: 
1546:     PROCEDURE DEmpOsKeyPress(par_nKeyCode, par_nShiftAltCtrl)
1547:         IF par_nKeyCode = 13 OR par_nKeyCode = 9 OR par_nKeyCode = 115
1548:             THIS.AbrirLookupDEmpOs()
1549:         ENDIF
1550:         IF par_nKeyCode = 13 OR par_nKeyCode = 9
1551:             THIS.ValidarDEmpOs()
1552:         ENDIF
1553:     ENDPROC
1554: 
1555:     *==========================================================================
1556:     * AtualizarEstadoDEmpOs - simula o getDEmpOs.When do legado:
1557:     *   "Return Empty(ThisForm.getEmpOs.Value)"
1558:     * txt_4c_DEmpOs so e editavel (pesquisa reversa por razao social)
1559:     * quando txt_4c_EmpOs esta vazio - mesmo padrao de
1560:     * Formsigrevto.AtualizarEstadoDesEmpresa.
1561:     *
1562:     * PUBLIC (regra #3 - chamado pelos Validar*/AbrirLookup* de Empresa).
1563:     *==========================================================================
1564:     PROCEDURE AtualizarEstadoDEmpOs()
1565:         THIS.txt_4c_DEmpOs.ReadOnly = !EMPTY(ALLTRIM(THIS.txt_4c_EmpOs.Value))
1566:     ENDPROC
1567: 
1568:     *==========================================================================
1569:     * ValidarEmpOs - getEmpOs.Valid do legado:
1570:     *   =fAcessoEmpresa(Usuar, 'C', This.Value, ThisForm.getEmpOs,
1571:     *                    ThisForm.getDEmpOs, ThisForm.poDataMgr)
1572:     * fAcessoEmpresa NAO foi portada (memoria "fAcessoEmpresa NAO EXISTE") -
1573:     * substituicao canonica: resolve o codigo digitado contra SigCdEmp e
1574:     * preenche a razao social; sem match, abre o picker (regra #50 - sem
1575:     * MsgAviso, sem apagar o codigo digitado).
1576:     *==========================================================================
1577:     PROCEDURE ValidarEmpOs()
1578:         LOCAL loc_cValor, loc_cSQL, loc_nResultado
1579:         loc_cValor = ALLTRIM(THIS.txt_4c_EmpOs.Value)
1580: 
1581:         IF EMPTY(loc_cValor)
1582:             THIS.txt_4c_DEmpOs.Value = ""
1583:             THIS.AtualizarEstadoDEmpOs()
1584:             RETURN
1585:         ENDIF
1586: 
1587:         loc_cSQL = "SELECT Cemps, Razas FROM SigCdEmp WHERE Cemps = " + EscaparSQL(loc_cValor)
1588:         loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_EmpVal")
1589: 
1590:         IF loc_nResultado > 0 AND USED("cursor_4c_EmpVal") AND !EOF("cursor_4c_EmpVal")
1591:             THIS.txt_4c_DEmpOs.Value = ALLTRIM(cursor_4c_EmpVal.Razas)
1592:         ELSE
1593:             THIS.txt_4c_DEmpOs.Value = ""
1594:         ENDIF
1595: 
1596:         IF USED("cursor_4c_EmpVal")
1597:             USE IN cursor_4c_EmpVal
1598:         ENDIF
1599: 
1600:         IF EMPTY(THIS.txt_4c_DEmpOs.Value)
1601:             THIS.AbrirLookupEmpOs()
1602:         ENDIF
1603: 
1604:         THIS.AtualizarEstadoDEmpOs()
1605:     ENDPROC
1606: 
1607:     *==========================================================================
1608:     * AbrirLookupEmpOs - picker de Empresa por codigo (SigCdEmp.Cemps).
1609:     *==========================================================================
1610:     PROCEDURE AbrirLookupEmpOs()
1611:         LOCAL loc_oBusca, loc_cValor
1612:         loc_cValor = ALLTRIM(THIS.txt_4c_EmpOs.Value)
1613: 
1614:         loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
1615:             "SigCdEmp", "cursor_4c_BuscaEmp", "Cemps", loc_cValor, ;
1616:             "Sele" + CHR(231) + CHR(227) + "o de Empresa")
1617: 
1618:         IF VARTYPE(loc_oBusca) = "O"
1619:             IF !loc_oBusca.this_lAchouRegistro
1620:                 loc_oBusca.mAddColuna("Cemps", "", "C" + CHR(243) + "digo")
1621:                 loc_oBusca.mAddColuna("Razas", "", "Raz" + CHR(227) + "o Social")
1622:                 loc_oBusca.Show()
1623:             ENDIF
1624:             IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaEmp")
1625:                 THIS.txt_4c_EmpOs.Value  = ALLTRIM(cursor_4c_BuscaEmp.Cemps)
1626:                 THIS.txt_4c_DEmpOs.Value = ALLTRIM(cursor_4c_BuscaEmp.Razas)
1627:             ENDIF
1628:             loc_oBusca.Release()
1629:         ENDIF
1630: 
1631:         IF USED("cursor_4c_BuscaEmp")
1632:             USE IN cursor_4c_BuscaEmp
1633:         ENDIF
1634: 
1635:         THIS.AtualizarEstadoDEmpOs()
1636:     ENDPROC
1637: 
1638:     *==========================================================================
1639:     * ValidarDEmpOs - getDEmpOs.Valid do legado:
1640:     *   =fAcessoEmpresa(Usuar, 'D', This.Value, ThisForm.getEmpOs,
1641:     *                    ThisForm.getDEmpOs, ThisForm.poDataMgr)
1642:     * So age quando o codigo esta vazio (equivalente ao getDEmpOs.When,
1643:     * que no legado impede ATE de entrar no campo por codigo preenchido -
1644:     * aqui a mesma condicao e checada no Valid, porque ReadOnly dinamico ja
1645:     * bloqueia a digitacao via AtualizarEstadoDEmpOs). Resolve a razao
1646:     * social digitada contra SigCdEmp.Razas (prefixo, LIKE 'valor%').
1647:     *==========================================================================
1648:     PROCEDURE ValidarDEmpOs()
1649:         LOCAL loc_cValor, loc_cSQL, loc_nResultado
1650: 
1651:         IF !EMPTY(ALLTRIM(THIS.txt_4c_EmpOs.Value))
1652:             RETURN
1653:         ENDIF
1654: 
1655:         loc_cValor = ALLTRIM(THIS.txt_4c_DEmpOs.Value)
1656:         IF EMPTY(loc_cValor)
1657:             THIS.txt_4c_EmpOs.Value = ""
1658:             RETURN
1659:         ENDIF
1660: 
1661:         loc_cSQL = "SELECT Cemps, Razas FROM SigCdEmp WHERE Razas LIKE " + ;
1662:                    EscaparSQL(loc_cValor + "%")
1663:         loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_EmpDescVal")
1664: 
1665:         IF loc_nResultado > 0 AND USED("cursor_4c_EmpDescVal") AND !EOF("cursor_4c_EmpDescVal")
1666:             THIS.txt_4c_EmpOs.Value  = ALLTRIM(cursor_4c_EmpDescVal.Cemps)
1667:             THIS.txt_4c_DEmpOs.Value = ALLTRIM(cursor_4c_EmpDescVal.Razas)
1668:             IF USED("cursor_4c_EmpDescVal")
1669:                 USE IN cursor_4c_EmpDescVal
1670:             ENDIF
1671:         ELSE
1672:             IF USED("cursor_4c_EmpDescVal")
1673:                 USE IN cursor_4c_EmpDescVal
1674:             ENDIF
1675:             THIS.AbrirLookupDEmpOs()
1676:         ENDIF
1677:     ENDPROC
1678: 
1679:     *==========================================================================
1680:     * AbrirLookupDEmpOs - picker de Empresa por razao social
1681:     * (SigCdEmp.Razas), mesmo padrao de Formsigrevto.AbrirBuscaDesEmpresa.
1682:     *==========================================================================
1683:     PROCEDURE AbrirLookupDEmpOs()
1684:         LOCAL loc_oBusca, loc_cValor
1685:         loc_cValor = ALLTRIM(THIS.txt_4c_DEmpOs.Value)
1686: 
1687:         loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
1688:             "SigCdEmp", "cursor_4c_BuscaEmpD", "Razas", loc_cValor, ;
1689:             "Sele" + CHR(231) + CHR(227) + "o de Empresa", .F., .T., "")
1690: 
1691:         IF VARTYPE(loc_oBusca) = "O"
1692:             IF loc_oBusca.this_lSelecionou AND loc_oBusca.this_lAchouRegistro
1693:                 THIS.txt_4c_DEmpOs.Value = ALLTRIM(cursor_4c_BuscaEmpD.Razas)
1694:                 THIS.txt_4c_EmpOs.Value  = ALLTRIM(cursor_4c_BuscaEmpD.Cemps)
1695:             ELSE
1696:                 IF !loc_oBusca.this_lAchouRegistro
1697:                     loc_oBusca.mAddColuna("Razas", "", "Raz" + CHR(227) + "o Social")
1698:                     loc_oBusca.mAddColuna("Cemps", "", "C" + CHR(243) + "digo")
1699:                     loc_oBusca.Show()
1700:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaEmpD")
1701:                         THIS.txt_4c_DEmpOs.Value = ALLTRIM(cursor_4c_BuscaEmpD.Razas)
1702:                         THIS.txt_4c_EmpOs.Value  = ALLTRIM(cursor_4c_BuscaEmpD.Cemps)
1703:                     ENDIF
1704:                 ENDIF
1705:             ENDIF
1706:             loc_oBusca.Release()
1707:         ENDIF
1708: 
1709:         IF USED("cursor_4c_BuscaEmpD")
1710:             USE IN cursor_4c_BuscaEmpD
1711:         ENDIF
1712: 
1713:         THIS.AtualizarEstadoDEmpOs()
1714:     ENDPROC
1715: 
1716:     *==========================================================================
1717:     * BtnNomArqsClick - btnNomArqs.Valid do legado:
1718:     *   lcArq = Putfile([Nome do Arquivo], [C:\CONCILIADOR.CSV], [CSV])
1719:     *   ThisForm.getArqNoms.Value = lcArq
1720:     * PUTFILE() devolve string vazia quando o usuario cancela o dialogo -
1721:     * nesse caso o campo permanece com o valor anterior (igual ao legado,
1722:     * que so atribui quando lcArq retorna preenchido - PUTFILE sem
1723:     * confirmacao devolve "").
1724:     *
1725:     * PUBLIC (regra #3 - alvo de BINDEVENT).
1726:     *==========================================================================
1727:     PROCEDURE BtnNomArqsClick()
1728:         LOCAL loc_cArquivo
1729:         loc_cArquivo = PUTFILE("Nome do Arquivo", "C:\CONCILIADOR.CSV", "CSV")
1730: 
1731:         IF !EMPTY(loc_cArquivo)
1732:             THIS.obj_4c_GetArqNoms.Value = loc_cArquivo
1733:         ENDIF
1734:     ENDPROC
1735: 
1736:     *==========================================================================
1737:     * HabilitarFiltros - habilita/desabilita os 9 controles de filtro
1738:     * (periodo/processados/empresa/arquivo), equivalente ao bloco
1739:     * "With ThisForm / .getDtIni.Enabled = ... / EndWith" repetido no
1740:     * Init/Selecionar/LimpaSelecao do legado. getAdquirs NAO entra (o
1741:     * legado nunca alterna o Enabled dele em lugar nenhum).
1742:     *==========================================================================
1743:     PROTECTED PROCEDURE HabilitarFiltros(par_lHabilitar)
1744:         THIS.txt_4c_DtIni.Enabled                    = par_lHabilitar
1745:         THIS.txt_4c_DtFin.Enabled                    = par_lHabilitar
1746:         THIS.cmd_4c_CmdSelecionar.Enabled             = par_lHabilitar
1747:         THIS.obj_4c_OptProcessados.Buttons(1).Enabled = par_lHabilitar
1748:         THIS.obj_4c_OptProcessados.Buttons(2).Enabled = par_lHabilitar
1749:         THIS.obj_4c_GetArqNoms.Enabled                = par_lHabilitar
1750:         THIS.cmd_4c_BtnNomArqs.Enabled                 = par_lHabilitar
1751:         THIS.txt_4c_EmpOs.Enabled                      = par_lHabilitar
1752:         THIS.txt_4c_DEmpOs.Enabled                     = par_lHabilitar
1753:     ENDPROC
1754: 
1755:     *==========================================================================
1756:     * HabilitarAcoesProcessamento - habilita/desabilita os 2 botoes de
1757:     * cmg_4c_CmdBtnForm (Limpar/Gera Arquivo) e os 3 de cmg_4c_CmdBtnGrade
1758:     * (Marca Tudo/Desmarcar/Documentos) - equivalente aos blocos "With
1759:     * ThisForm.cmdBtnForm"/"With ThisForm.cmdBtnGrade" do Init/Selecionar/
1760:     * LimpaSelecao do legado. O 3o botao de cmg_4c_CmdBtnForm (Encerrar)
1761:     * NAO entra - o legado nunca o desabilita.
1762:     *==========================================================================
1763:     PROTECTED PROCEDURE HabilitarAcoesProcessamento(par_lHabilitar)
1764:         THIS.cmg_4c_CmdBtnForm.Buttons(1).Enabled  = par_lHabilitar
1765:         THIS.cmg_4c_CmdBtnForm.Buttons(2).Enabled  = par_lHabilitar
1766:         THIS.cmg_4c_CmdBtnGrade.Buttons(1).Enabled = par_lHabilitar
1767:         THIS.cmg_4c_CmdBtnGrade.Buttons(2).Enabled = par_lHabilitar
1768:         THIS.cmg_4c_CmdBtnGrade.Buttons(3).Enabled = par_lHabilitar
1769:     ENDPROC
1770: 
1771:     *==========================================================================
1772:     * CmdSelecionarClick - cmdSelecionar.Valid do legado (CommandButton
1773:     * standalone nao dispara Valid em VFP9 - mapeado para Click).
1774:     *==========================================================================
1775:     PROCEDURE CmdSelecionarClick()
1776:         THIS.Selecionar()
1777:     ENDPROC
1778: 
1779:     *==========================================================================
1780:     * Selecionar - PROCEDURE selecionar do legado: valida Data Inicial/
1781:     * Final/pasta do arquivo de exportacao, monta e executa o JOIN
1782:     * SigOpFp+SigCdCli+SigMvPar+SigCdOpe (filtrado por empresa/adquirente/
1783:     * periodo/situacao de processamento ja gravada em SigPcOoL), e povoa
1784:     * cursor_4c_Operacoes linha a linha com os campos derivados.
1785:     *
1786:     * RETURN so FORA do TRY (regra #1) - loc_lValido encadeia os 4 guards
1787:     * de validacao do legado (cada MessageBox + SetFocus + Return .f.).
1788:     *
1789:     * PUBLIC (regra #3): alvo de BINDEVENT (CmdSelecionarClick) e mesmo
1790:     * nome do PROCEDURE legado (harness pode chamar direto).
1791:     *==========================================================================
1792:     PROCEDURE Selecionar()
1793:         LOCAL loc_cEmp, loc_lNaoProcessados, loc_dDtIni, loc_dDtFin, ;
1794:               loc_cArquivo, loc_cAdquirente, loc_dDtFinHora, loc_cSQL, ;
1795:               loc_nResultado, loc_lValido, loc_lErros, loc_cBandeira, ;
1796:               loc_cOrigem, loc_lSucesso, loc_oErro
1797:         loc_lSucesso = .F.
1798: 
1799:         TRY
1800:             IF USED("cursor_4c_Operacoes")
1801:                 ZAP IN cursor_4c_Operacoes
1802:             ENDIF
1803: 
1804:             *-- FONTE UNICA dos filtros: FormParaBO() transfere os 6
1805:             *-- controles de filtro para as properties do BO aplicando a
1806:             *-- MESMA normalizacao do legado (Padr(getEmpOs.Value, 3),
1807:             *-- Alltrim nos demais), e a partir daqui o metodo le do BO.
1808:             *-- Antes, Selecionar e Processamento liam os controles cada um
1809:             *-- por conta propria - duas copias da mesma leitura, livres
1810:             *-- para divergir no primeiro filtro novo.
1811:             loc_lValido = THIS.FormParaBO()
1812: 
1813:             IF loc_lValido
1814:                 WITH THIS.this_oBusinessObject
1815:                     loc_cEmp            = PADR(.this_cEmps, 3)
1816:                     loc_lNaoProcessados = (.this_nProcessados = 1)
1817:                     loc_dDtIni          = .this_dDataIni
1818:                     loc_dDtFin          = .this_dDataFin
1819:                     loc_cArquivo        = ALLTRIM(.this_cArquivo)
1820:                     loc_cAdquirente     = ALLTRIM(.this_cAdquirente)
1821:                 ENDWITH
1822:             ENDIF
1823: 
1824:             IF loc_lValido AND EMPTY(loc_dDtIni)
1825:                 MsgAviso("A Data Inicial N" + CHR(227) + "o Pode Ficar em Branco!!!", ;
1826:                     "Aten" + CHR(231) + CHR(227) + "o!!!")
1827:                 THIS.txt_4c_DtIni.SetFocus()
1828:                 loc_lValido = .F.
1829:             ENDIF
1830: 
1831:             IF loc_lValido AND EMPTY(loc_dDtFin)
1832:                 MsgAviso("A Data Final N" + CHR(227) + "o Pode Ficar em Branco!!!", ;
1833:                     "Aten" + CHR(231) + CHR(227) + "o!!!")
1834:                 THIS.txt_4c_DtFin.SetFocus()
1835:                 loc_lValido = .F.
1836:             ENDIF
1837: 
1838:             IF loc_lValido AND loc_dDtIni > loc_dDtFin
1839:                 MsgAviso("A Data Inicial N" + CHR(227) + "o Pode Ser Maior do Que a Data Final!!!", ;
1840:                     "Aten" + CHR(231) + CHR(227) + "o!!!")
1841:                 THIS.txt_4c_DtIni.SetFocus()
1842:                 loc_lValido = .F.
1843:             ENDIF
1844: 
1845:             IF loc_lValido AND (EMPTY(loc_cArquivo) OR EMPTY(JUSTPATH(loc_cArquivo)) ;
1846:                     OR !DIRECTORY(JUSTPATH(loc_cArquivo)))
1847:                 MsgAviso("O Arquivo a Ser Gerado Precisa Ser Informado!!!", ;
1848:                     "Aten" + CHR(231) + CHR(227) + "o!!!")
1849:                 THIS.cmd_4c_BtnNomArqs.SetFocus()
1850:                 loc_lValido = .F.
1851:             ENDIF
1852: 
1853:             IF loc_lValido
1854:                 loc_dDtFinHora = DATETIME(YEAR(loc_dDtFin), MONTH(loc_dDtFin), DAY(loc_dDtFin), 23, 59, 59)
1855: 
1856:                 loc_cSQL = "SELECT 'A02' AS TIPO_REGISTRO, p.Adquirente AS ADQUIRENTE," + ;
1857:                     " p.Emps AS LOJA_FILIAL, f.Bandeira AS BANDEIRA1, d.RClis AS BANDEIRA2," + ;
1858:                     " f.Opers AS TIPO_TRANSACAO, p.Parcs AS NRO_PARCELA, p.TParcs AS QTD_PARCELAS," + ;
1859:                     " SPACE(40) AS TID, p.NSU AS NSU, p.Autoriza AS AUTORIZACAO, p.Valos AS VALOR," + ;
1860:                     " SPACE(50) AS CLIENTE, p.Datas AS DATA_VENDA, f.CCupomNvs AS ORIGEM," + ;
1861:                     " '' AS SEQUENCIA, '' AS NOTA_FISCAL, '' AS CPF_CNPJ, f.CodEstabs AS ESTABELECIMENTO," + ;
1862:                     " p.Vencs AS DATA_VENCIMENTO, '' AS NUMERO_CARTAO," + ;
1863:                     " p.EmpDopNums + p.FPags + STR(p.Nopers, 10) AS REFERENCIA1," + ;
1864:                     " p.Emps, p.Dopes, p.Numes, p.EmpDopNums" + ;
1865:                     " FROM SigOpFP f, SigCdCli d, SigMvPar p, SigCdOpe o" + ;
1866:                     " WHERE f.Infos = 'T'" + ;
1867:                     "   AND f.ContaDs = d.IClis" + ;
1868:                     "   AND p.FPags = f.FPags" + ;
1869:                     IIF(EMPTY(loc_cEmp), "", "   AND p.Emps = " + EscaparSQL(loc_cEmp)) + ;
1870:                     IIF(EMPTY(loc_cAdquirente), "", "   AND p.Adquirente = " + EscaparSQL(loc_cAdquirente)) + ;
1871:                     "   AND p.Datas BETWEEN " + FormatarDataSQL(loc_dDtIni) + " AND " + FormatarDataSQL(loc_dDtFinHora) + ;
1872:                     "   AND p.Dopes = o.Dopes" + ;
1873:                     "   AND NOT o.Vendas = 2" + ;
1874:                     "   AND p.Vencs IS NOT NULL" + ;
1875:                     "   AND p.EmpDopNums " + IIF(loc_lNaoProcessados, "NOT ", "") + ;
1876:                     "   IN (SELECT DISTINCT b.EmpDopNums FROM SigPcOoL b WHERE b.Tipos = " + EscaparSQL("SIGOPVDA") + ")" + ;
1877:                     " ORDER BY p.Datas, p.EmpDopNums, p.FPags, p.Parcs"
1878: 
1879:                 IF USED("cursor_4c_Selecao")
1880:                     USE IN cursor_4c_Selecao
1881:                 ENDIF
1882: 
1883:                 loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Selecao")
1884: 
1885:                 IF loc_nResultado < 0 OR !USED("cursor_4c_Selecao")
1886:                     MsgErro("Erro ao consultar as opera" + CHR(231) + CHR(245) + "es:" + CHR(13) + ;
1887:                         CapturarErroSQL(), "Erro SQL")

*-- Linhas 1910 a 1930:
1910:                             loc_cBandeira = IIF(EMPTY(ALLTRIM(cursor_4c_Selecao.BANDEIRA1)), ;
1911:                                 ALLTRIM(cursor_4c_Selecao.BANDEIRA2), ALLTRIM(cursor_4c_Selecao.BANDEIRA1))
1912:                             loc_cOrigem = IIF(EMPTY(ALLTRIM(cursor_4c_Selecao.ORIGEM)), "POS", ;
1913:                                 ALLTRIM(cursor_4c_Selecao.ORIGEM))
1914: 
1915:                             INSERT INTO cursor_4c_Operacoes (SelImp, TIPO_REGISTRO, ADQUIRENTE, ;
1916:                                 LOJA_FILIAL, BANDEIRA, TIPO_TRANSACAO, NRO_PARCELA, QTD_PARCELAS, ;
1917:                                 TID, NSU, AUTORIZACAO, VALOR, CLIENTE, DATA_VENDA, ORIGEM, ;
1918:                                 SEQUENCIA, NOTA_FISCAL, CPF_CNPJ, ESTABELECIMENTO, DATA_VENCIMENTO, ;
1919:                                 NUMERO_CARTAO, REFERENCIA1, Emps, Dopes, Numes, EmpDopNums, Erros) ;
1920:                                 VALUES (!loc_lErros, cursor_4c_Selecao.TIPO_REGISTRO, ;
1921:                                 cursor_4c_Selecao.ADQUIRENTE, cursor_4c_Selecao.LOJA_FILIAL, ;
1922:                                 loc_cBandeira, cursor_4c_Selecao.TIPO_TRANSACAO, ;
1923:                                 ALLTRIM(STR(cursor_4c_Selecao.NRO_PARCELA, 3)), ;
1924:                                 ALLTRIM(STR(cursor_4c_Selecao.QTD_PARCELAS, 3)), ;
1925:                                 cursor_4c_Selecao.TID, cursor_4c_Selecao.NSU, ;
1926:                                 cursor_4c_Selecao.AUTORIZACAO, ;
1927:                                 STRTRAN(ALLTRIM(STR(cursor_4c_Selecao.VALOR, 12, 2)), ".", ","), ;
1928:                                 cursor_4c_Selecao.CLIENTE, ;
1929:                                 DTOC(ConverterParaData(cursor_4c_Selecao.DATA_VENDA)), loc_cOrigem, ;
1930:                                 cursor_4c_Selecao.SEQUENCIA, cursor_4c_Selecao.NOTA_FISCAL, ;

*-- Linhas 1955 a 2129:
1955:             THIS.this_cMensagemErro = loc_oErro.Message
1956:             MsgErro(loc_oErro.Message + CHR(13) + ;
1957:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1958:                 "Procedure: " + loc_oErro.Procedure, ;
1959:                 "Erro Selecionar")
1960:         ENDTRY
1961: 
1962:         RETURN loc_lSucesso
1963:     ENDPROC
1964: 
1965:     *==========================================================================
1966:     * LimpaSelecao - PROCEDURE limpaselecao do legado: esvazia
1967:     * cursor_4c_Operacoes e devolve filtros/botoes ao estado inicial.
1968:     *
1969:     * PUBLIC (regra #3): chamado por Selecionar/Processamento e mesmo nome
1970:     * do PROCEDURE legado.
1971:     *==========================================================================
1972:     PROCEDURE LimpaSelecao()
1973:         LOCAL loc_lSucesso, loc_oErro
1974:         loc_lSucesso = .F.
1975: 
1976:         TRY
1977:             IF USED("cursor_4c_Operacoes")
1978:                 ZAP IN cursor_4c_Operacoes
1979:             ENDIF
1980: 
1981:             THIS.HabilitarFiltros(.T.)
1982:             THIS.HabilitarAcoesProcessamento(.F.)
1983: 
1984:             THIS.CarregarDados()
1985:             THIS.Refresh()
1986: 
1987:             loc_lSucesso = .T.
1988: 
1989:         CATCH TO loc_oErro
1990:             THIS.this_cMensagemErro = loc_oErro.Message
1991:             MsgErro(loc_oErro.Message + CHR(13) + ;
1992:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1993:                 "Procedure: " + loc_oErro.Procedure, ;
1994:                 "Erro LimpaSelecao")
1995:         ENDTRY
1996: 
1997:         RETURN loc_lSucesso
1998:     ENDPROC
1999: 
2000:     *==========================================================================
2001:     * Processamento - PROCEDURE processamento do legado: grava o header
2002:     * 'A01' (nomes das colunas) + uma linha 'A02' por operacao SelImp no
2003:     * cursor de exportacao, COPY TO DELIMITED, e insere o controle em
2004:     * SigPcOoL (um INSERT por linha, tudo num UNICO SQLEXEC - BEGIN/COMMIT
2005:     * via SQLEXEC separado NAO protege, a conexao ja nasce com @@TRANCOUNT
2006:     * = 1 - regra "BEGIN/COMMIT via SQLEXEC nao protege").
2007:     *
2008:     * Nao apaga o arquivo se o lote SQL falhar (igual ao legado: o arquivo
2009:     * ja foi gravado em disco ANTES da tentativa de commit).
2010:     *
2011:     * PUBLIC (regra #3): chamado por CmgCmdBtnFormClick e mesmo nome do
2012:     * PROCEDURE legado.
2013:     *==========================================================================
2014:     PROCEDURE Processamento()
2015:         LOCAL loc_lNaoProcessados, loc_cArquivo, loc_nOrdem, loc_lOk, ;
2016:               loc_cInserts, loc_cSQLLote, loc_cProdutosFlag, loc_nResultado, ;
2017:               loc_lFiltrosOk, loc_oErro
2018:         loc_lOk = .F.
2019: 
2020:         TRY
2021:             *-- FONTE UNICA dos filtros, igual a Selecionar: FormParaBO()
2022:             *-- recarrega as properties do BO a partir dos controles (o
2023:             *-- legado tambem relia optProcessados/getArqNoms aqui) e
2024:             *-- Processamento le do BO, nunca mais do controle.
2025:             loc_lFiltrosOk      = THIS.FormParaBO()
2026:             loc_lNaoProcessados = .T.
2027:             loc_cArquivo        = ""
2028: 
2029:             IF loc_lFiltrosOk
2030:                 WITH THIS.this_oBusinessObject
2031:                     loc_lNaoProcessados = (.this_nProcessados = 1)
2032:                     loc_cArquivo        = ALLTRIM(.this_cArquivo)
2033:                 ENDWITH
2034:             ENDIF
2035: 
2036:             loc_cProdutosFlag = IIF(loc_lNaoProcessados, "", "J" + CHR(193) + " PROCESSADOS")
2037: 
2038:             *-- RETURN so FORA do TRY (regra #1): o corpo inteiro fica sob a
2039:             *-- flag, em vez de abandonar o bloco no meio.
2040:             IF !loc_lFiltrosOk
2041:                 MsgErro("N" + CHR(227) + "o foi poss" + CHR(237) + "vel ler os filtros da tela." + ;
2042:                     CHR(13) + "Nenhum arquivo foi gerado.", "Aten" + CHR(231) + CHR(227) + "o!!!")
2043:             ELSE
2044:                 IF USED("cursor_4c_Excel")
2045:                     USE IN cursor_4c_Excel
2046:                 ENDIF
2047: 
2048:                 CREATE CURSOR cursor_4c_Excel (TIPO_REGISTRO C(3), ADQUIRENTE C(60), ;
2049:                     LOJA_FILIAL C(15), BANDEIRA C(60), TIPO_TRANSACAO C(15), ;
2050:                     NRO_PARCELA C(2), QTD_PARCELAS C(2), TID C(40), NSU C(30), ;
2051:                     AUTORIZACAO C(20), VALOR C(14), CLIENTE C(50), DATA_VENDA C(10), ;
2052:                     ORIGEM C(10), SEQUENCIA C(20), NOTA_FISCAL C(20), CPF_CNPJ C(20), ;
2053:                     ESTABELECIMENTO C(20), DATA_VENCIMENTO C(10), NUMERO_CARTAO C(30), ;
2054:                     REFERENCIA1 C(60))
2055: 
2056:                 *-- Header 'A01' - o legado grava os NOMES das colunas como a
2057:                 *-- 1a linha do arquivo exportado.
2058:                 INSERT INTO cursor_4c_Excel (TIPO_REGISTRO, ADQUIRENTE, LOJA_FILIAL, ;
2059:                     BANDEIRA, TIPO_TRANSACAO, NRO_PARCELA, QTD_PARCELAS, TID, NSU, ;
2060:                     AUTORIZACAO, VALOR, CLIENTE, DATA_VENDA, ORIGEM, SEQUENCIA, ;
2061:                     NOTA_FISCAL, CPF_CNPJ, ESTABELECIMENTO, DATA_VENCIMENTO, ;
2062:                     NUMERO_CARTAO, REFERENCIA1) ;
2063:                     VALUES ("A01", "ADQUIRENTE", "LOJA_FILIAL", "BANDEIRA", ;
2064:                     "TIPO_TRANSACAO", "NRO_PARCELA", "QTD_PARCELAS", "TID", "NSU", ;
2065:                     "AUTORIZA" + CHR(199) + CHR(195) + "O", "VALOR", "CLIENTE", ;
2066:                     "DATA_VENDA", "ORIGEM", "SEQUENCIA", "NOTA_FISCAL", "CPF_CNPJ", ;
2067:                     "ESTABELECIMENTO", "DATA_VENCIMENTO", "NUMERO_CARTAO", "REFERENCIA1")
2068: 
2069:                 loc_nOrdem   = 0
2070:                 loc_cInserts = ""
2071: 
2072:                 SELECT cursor_4c_Operacoes
2073:                 SCAN FOR SelImp
2074:                     loc_nOrdem = loc_nOrdem + 1
2075: 
2076:                     INSERT INTO cursor_4c_Excel (TIPO_REGISTRO, ADQUIRENTE, LOJA_FILIAL, ;
2077:                         BANDEIRA, TIPO_TRANSACAO, NRO_PARCELA, QTD_PARCELAS, TID, NSU, ;
2078:                         AUTORIZACAO, VALOR, CLIENTE, DATA_VENDA, ORIGEM, SEQUENCIA, ;
2079:                         NOTA_FISCAL, CPF_CNPJ, ESTABELECIMENTO, DATA_VENCIMENTO, ;
2080:                         NUMERO_CARTAO, REFERENCIA1) ;
2081:                         VALUES (cursor_4c_Operacoes.TIPO_REGISTRO, cursor_4c_Operacoes.ADQUIRENTE, ;
2082:                         cursor_4c_Operacoes.LOJA_FILIAL, cursor_4c_Operacoes.BANDEIRA, ;
2083:                         cursor_4c_Operacoes.TIPO_TRANSACAO, cursor_4c_Operacoes.NRO_PARCELA, ;
2084:                         cursor_4c_Operacoes.QTD_PARCELAS, cursor_4c_Operacoes.TID, ;
2085:                         cursor_4c_Operacoes.NSU, cursor_4c_Operacoes.AUTORIZACAO, ;
2086:                         cursor_4c_Operacoes.VALOR, cursor_4c_Operacoes.CLIENTE, ;
2087:                         cursor_4c_Operacoes.DATA_VENDA, cursor_4c_Operacoes.ORIGEM, ;
2088:                         ALLTRIM(STR(loc_nOrdem, 20)), cursor_4c_Operacoes.NOTA_FISCAL, ;
2089:                         cursor_4c_Operacoes.CPF_CNPJ, cursor_4c_Operacoes.ESTABELECIMENTO, ;
2090:                         cursor_4c_Operacoes.DATA_VENCIMENTO, cursor_4c_Operacoes.NUMERO_CARTAO, ;
2091:                         cursor_4c_Operacoes.REFERENCIA1)
2092: 
2093:                     loc_cInserts = loc_cInserts + ;
2094:                         "INSERT INTO SigPcOoL (tipos, emps, dopes, numes, empds, dopeds," + ;
2095:                         " numeds, datas, usuars, produtos, cidchaves, edndests, empdopnums," + ;
2096:                         " processos, nopers) VALUES (" + ;
2097:                         EscaparSQL("SIGOPVDA") + "," + ;
2098:                         EscaparSQL(ALLTRIM(cursor_4c_Operacoes.Emps)) + "," + ;
2099:                         EscaparSQL(ALLTRIM(cursor_4c_Operacoes.Dopes)) + "," + ;
2100:                         FormatarNumeroSQL(cursor_4c_Operacoes.Numes, 0) + "," + ;
2101:                         EscaparSQL("") + "," + EscaparSQL("") + "," + FormatarNumeroSQL(0, 0) + "," + ;
2102:                         "GETDATE()," + ;
2103:                         EscaparSQL(gc_4c_UsuarioLogado) + "," + ;
2104:                         EscaparSQL(loc_cProdutosFlag) + "," + ;
2105:                         EscaparSQL(ALLTRIM(fUniqueIds())) + "," + ;
2106:                         EscaparSQL("") + "," + ;
2107:                         EscaparSQL(ALLTRIM(cursor_4c_Operacoes.EmpDopNums)) + "," + ;
2108:                         EscaparSQL(ALLTRIM(cursor_4c_Operacoes.REFERENCIA1)) + "," + ;
2109:                         FormatarNumeroSQL(0, 0) + ");" + CHR(13)
2110: 
2111:                     SELECT cursor_4c_Operacoes
2112:                 ENDSCAN
2113: 
2114:                 SELECT cursor_4c_Excel
2115:                 COPY TO (loc_cArquivo) DELIMITED
2116: 
2117:                 IF !FILE(loc_cArquivo)
2118:                     MsgErro("N" + CHR(227) + "o Foi Poss" + CHR(237) + "vel Gerar o Arquivo!!! " + ;
2119:                         "Verifique Suas Permiss" + CHR(245) + "es!!!", "Aten" + CHR(231) + CHR(227) + "o!!!")
2120:                 ELSE
2121:                     loc_cSQLLote = "SET NOCOUNT ON;" + CHR(13) + ;
2122:                         "DECLARE @nivel4c int = @@TRANCOUNT;" + CHR(13) + ;
2123:                         "IF @nivel4c = 0 BEGIN TRANSACTION ELSE SAVE TRANSACTION Op4cVda;" + CHR(13) + ;
2124:                         "BEGIN TRY" + CHR(13) + ;
2125:                         loc_cInserts + ;
2126:                         "IF @nivel4c = 0 COMMIT TRANSACTION;" + CHR(13) + ;
2127:                         "END TRY" + CHR(13) + ;
2128:                         "BEGIN CATCH" + CHR(13) + ;
2129:                         "IF @nivel4c = 0" + CHR(13) + ;

*-- Linhas 2148 a 2471:
2148:                         THIS.Selecionar()
2149:                         loc_lOk = .T.
2150:                     ENDIF
2151:                 ENDIF
2152: 
2153:                 IF USED("cursor_4c_Excel")
2154:                     USE IN cursor_4c_Excel
2155:                 ENDIF
2156:             ENDIF
2157: 
2158:         CATCH TO loc_oErro
2159:             THIS.this_cMensagemErro = loc_oErro.Message
2160:             MsgErro(loc_oErro.Message + CHR(13) + ;
2161:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
2162:                 "Procedure: " + loc_oErro.Procedure, ;
2163:                 "Erro Processamento")
2164:         ENDTRY
2165: 
2166:         RETURN loc_lOk
2167:     ENDPROC
2168: 
2169:     *==========================================================================
2170:     * CmgCmdBtnGradeClick - cmdBtnGrade.Click do legado (Marca Tudo/
2171:     * Desmarcar/Documentos da linha corrente).
2172:     *==========================================================================
2173:     PROCEDURE CmgCmdBtnGradeClick()
2174:         LOCAL loc_oGrp
2175:         loc_oGrp = THIS.cmg_4c_CmdBtnGrade
2176: 
2177:         DO CASE
2178:         CASE loc_oGrp.Value = 1 AND loc_oGrp.Buttons(1).Enabled
2179:             *-- Marca Tudo
2180:             IF USED("cursor_4c_Operacoes")
2181:                 SELECT cursor_4c_Operacoes
2182:                 REPLACE ALL SelImp WITH .T. FOR !Erros
2183:                 GO TOP
2184:                 THIS.cnt_4c_Grade.grd_4c_Dados.Refresh()
2185:             ENDIF
2186: 
2187:         CASE loc_oGrp.Value = 2 AND loc_oGrp.Buttons(2).Enabled
2188:             *-- Desmarcar
2189:             IF USED("cursor_4c_Operacoes")
2190:                 SELECT cursor_4c_Operacoes
2191:                 REPLACE ALL SelImp WITH .F.
2192:                 GO TOP
2193:                 THIS.cnt_4c_Grade.grd_4c_Dados.Refresh()
2194:             ENDIF
2195: 
2196:         CASE loc_oGrp.Value = 3 AND loc_oGrp.Buttons(3).Enabled
2197:             *-- Documentos (legado: Do Form SigMvExp)
2198:             THIS.AbrirDocumentoOperacao()
2199:         ENDCASE
2200:     ENDPROC
2201: 
2202:     *==========================================================================
2203:     * AbrirDocumentoOperacao - cmdBtnGrade "Documentos" do legado:
2204:     *   Do Form SigMvExp With csOperacoes.Dopes, 'C', csOperacoes.Numes,
2205:     *                          csOperacoes.Emps, .t.
2206:     * -> CREATEOBJECT("FormSigMvExp", par_cDopes, par_cTipos, par_nNumes,
2207:     *                  par_cEmps, par_lConsulta, par_nCaixa, par_lMacro)
2208:     *==========================================================================
2209:     PROCEDURE AbrirDocumentoOperacao()
2210:         LOCAL loc_oForm
2211: 
2212:         IF !USED("cursor_4c_Operacoes") OR EOF("cursor_4c_Operacoes")
2213:             RETURN
2214:         ENDIF
2215: 
2216:         loc_oForm = CREATEOBJECT("FormSigMvExp", ALLTRIM(cursor_4c_Operacoes.Dopes), ;
2217:             "C", cursor_4c_Operacoes.Numes, cursor_4c_Operacoes.Emps, .T.)
2218: 
2219:         IF VARTYPE(loc_oForm) = "O"
2220:             loc_oForm.Show()
2221:         ENDIF
2222:     ENDPROC
2223: 
2224:     *==========================================================================
2225:     * CmgCmdBtnFormClick - cmdBtnForm.Click do legado (Limpar Selecao/Gera
2226:     * Arquivo/Encerrar). O guard de "nenhum lancamento selecionado" (Select
2227:     * ... Count(1) ... Group By SelImp) roda ANTES do Do Case, so quando o
2228:     * botao clicado e o 2o (Gera Arquivo) - igual ao legado.
2229:     *==========================================================================
2230:     PROCEDURE CmgCmdBtnFormClick()
2231:         LOCAL loc_oGrp, loc_nSelecionados
2232: 
2233:         loc_oGrp = THIS.cmg_4c_CmdBtnForm
2234: 
2235:         IF loc_oGrp.Value = 2
2236:             loc_nSelecionados = 0
2237: 
2238:             IF USED("cursor_4c_Operacoes")
2239:                 IF USED("cursor_4c_ContaSel")
2240:                     USE IN cursor_4c_ContaSel
2241:                 ENDIF
2242:                 SELECT COUNT(*) AS Selecionados FROM cursor_4c_Operacoes ;
2243:                     WHERE SelImp INTO CURSOR cursor_4c_ContaSel
2244:                 IF USED("cursor_4c_ContaSel")
2245:                     loc_nSelecionados = cursor_4c_ContaSel.Selecionados
2246:                     USE IN cursor_4c_ContaSel
2247:                 ENDIF
2248:             ENDIF
2249: 
2250:             IF loc_nSelecionados < 1
2251:                 MsgAviso("Nenhum Lan" + CHR(231) + "amento Foi Selecionado!!!", "Processamento")
2252:                 THIS.txt_4c_DtIni.SetFocus()
2253:                 RETURN
2254:             ENDIF
2255:         ENDIF
2256: 
2257:         DO CASE
2258:         CASE loc_oGrp.Value = 1 AND loc_oGrp.Buttons(1).Enabled
2259:             *-- Limpar Selecao
2260:             THIS.LimpaSelecao()
2261: 
2262:         CASE loc_oGrp.Value = 2 AND loc_oGrp.Buttons(2).Enabled
2263:             *-- Gera Arquivo
2264:             THIS.Processamento()
2265: 
2266:         CASE loc_oGrp.Value = 3
2267:             *-- Encerrar ([ESC] Sair)
2268:             THIS.Release()
2269:         ENDCASE
2270:     ENDPROC
2271: 
2272:     *==========================================================================
2273:     * Check1ToggleSelImp - fonte unica do toggle de SelImp na celula
2274:     * corrente da grade (regra do Problema 48/#21: popular cursor NAO
2275:     * repinta a grade - o Refresh e obrigatorio).
2276:     *==========================================================================
2277:     PROCEDURE Check1ToggleSelImp()
2278:         IF USED("cursor_4c_Operacoes") AND !EOF("cursor_4c_Operacoes")
2279:             REPLACE cursor_4c_Operacoes.SelImp WITH !cursor_4c_Operacoes.SelImp
2280:             THIS.cnt_4c_Grade.grd_4c_Dados.Refresh()
2281:         ENDIF
2282:     ENDPROC
2283: 
2284:     *==========================================================================
2285:     * Check1KeyPress/MouseUp/MouseDown/Click - Column1.Check1 do legado,
2286:     * TRANSCRITO LITERAL: o toggle mora no MouseDown (Gather Memvar +
2287:     * Refresh + NoDefault); MouseUp e Click so suprimem o default; KeyPress
2288:     * toggla em Enter(13)/Espaco(32). PUBLIC (regra #3 - alvo de BINDEVENT).
2289:     *==========================================================================
2290:     PROCEDURE Check1KeyPress(par_nKeyCode, par_nShiftAltCtrl)
2291:         IF INLIST(par_nKeyCode, 13, 32)
2292:             THIS.Check1ToggleSelImp()
2293:             NODEFAULT
2294:         ENDIF
2295:     ENDPROC
2296: 
2297:     PROCEDURE Check1MouseUp(par_nButton, par_nShift, par_nXCoord, par_nYCoord)
2298:         NODEFAULT
2299:     ENDPROC
2300: 
2301:     PROCEDURE Check1MouseDown(par_nButton, par_nShift, par_nXCoord, par_nYCoord)
2302:         THIS.Check1ToggleSelImp()
2303:         NODEFAULT
2304:     ENDPROC
2305: 
2306:     PROCEDURE Check1Click()
2307:         NODEFAULT
2308:     ENDPROC
2309: 
2310:     *==========================================================================
2311:     * BOParaForm - leva os filtros de selecao guardados no BO para os
2312:     * controles da tela. E o bloco de defaults do Init legado, que nao tem
2313:     * esse nome la mas existe literalmente:
2314:     *
2315:     *   .getDtIni.Value   = Date()
2316:     *   .getDtFin.Value   = Date()
2317:     *   .getArqNoms.Value = [C:\CONCILIADOR.CSV]
2318:     *
2319:     * Os valores moram em SigOpVdaBO.AplicarFiltrosPadrao() - aqui so se
2320:     * espelha a property no controle, para haver UM lugar que decide o
2321:     * default e UM lugar que o escreve na tela.
2322:     *
2323:     * PROTECTED obrigatoriamente: FormBase declara BOParaForm como
2324:     * PROTECTED e VFP9 nao permite ALARGAR o escopo de metodo herdado.
2325:     *
2326:     * Nao estoura com o BO ausente nem antes dos controles existirem: os
2327:     * dois guards checam, resultado por flag e RETURN unico depois do
2328:     * ENDTRY (regra #1).
2329:     *==========================================================================
2330:     PROTECTED PROCEDURE BOParaForm()
2331:         LOCAL loc_lSucesso, loc_oErro
2332:         loc_lSucesso = .F.
2333: 
2334:         IF VARTYPE(THIS.this_oBusinessObject) != "O"
2335:             RETURN loc_lSucesso
2336:         ENDIF
2337: 
2338:         IF !PEMSTATUS(THIS, "txt_4c_DtIni", 5)
2339:             RETURN loc_lSucesso
2340:         ENDIF
2341: 
2342:         TRY
2343:             WITH THIS.this_oBusinessObject
2344:                 THIS.txt_4c_DtIni.Value  = ConverterParaData(.this_dDataIni)
2345:                 THIS.txt_4c_DtFin.Value  = ConverterParaData(.this_dDataFin)
2346:                 THIS.txt_4c_EmpOs.Value  = ALLTRIM(.this_cEmps)
2347:                 THIS.txt_4c_DEmpOs.Value = ALLTRIM(.this_cDescEmps)
2348:                 THIS.txt_4c_Adquirs.Value = ALLTRIM(.this_cAdquirente)
2349:                 THIS.obj_4c_GetArqNoms.Value = ALLTRIM(.this_cArquivo)
2350: 
2351:                 *-- OptionGroup e 1-based (1-Nao Processadas / 2-Ja
2352:                 *-- Processadas): nunca atribuir 0 a um controle 1-based.
2353:                 THIS.obj_4c_OptProcessados.Value = ;
2354:                     IIF(BETWEEN(.this_nProcessados, 1, 2), .this_nProcessados, 1)
2355:             ENDWITH
2356: 
2357:             *-- getDEmpOs.When do legado depende do getEmpOs recem-escrito.
2358:             THIS.AtualizarEstadoDEmpOs()
2359: 
2360:             loc_lSucesso = .T.
2361: 
2362:         CATCH TO loc_oErro
2363:             THIS.this_cMensagemErro = loc_oErro.Message
2364:             MsgErro(loc_oErro.Message + CHR(13) + ;
2365:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
2366:                 "Procedure: " + loc_oErro.Procedure, ;
2367:                 "Erro BOParaForm")
2368:         ENDTRY
2369: 
2370:         RETURN loc_lSucesso
2371:     ENDPROC
2372: 
2373:     *==========================================================================
2374:     * FormParaBO - inverso de BOParaForm: le os 6 controles de filtro e
2375:     * grava nas properties do BO, aplicando a MESMA normalizacao do legado
2376:     * (selecionar: "lcEmp = Padr(ThisForm.getEmpOs.Value, 3)", Alltrim nos
2377:     * demais). Depois disto Selecionar() e Processamento() leem SO do BO.
2378:     *
2379:     * Campo em BRANCO SOBRESCREVE a property de proposito - aqui vazio e um
2380:     * valor com significado, nao "nao informado": empresa vazia significa
2381:     * TODAS as empresas e adquirente vazio significa TODOS os adquirentes
2382:     * (o IIF(EMPTY(...)) de Selecionar simplesmente omite a clausula do
2383:     * WHERE). Por isso NAO se aplica o guard "branco nao sobrescreve" usado
2384:     * em tela de configuracao resolvida.
2385:     *
2386:     * As validacoes do legado (data em branco, inicial > final, pasta do
2387:     * arquivo inexistente) continuam em Selecionar(), que e onde o SCX as
2388:     * tem - este metodo so transfere.
2389:     *
2390:     * PROTECTED obrigatoriamente (FormBase declara FormParaBO PROTECTED e
2391:     * VFP9 nao permite alargar escopo de metodo herdado).
2392:     *==========================================================================
2393:     PROTECTED PROCEDURE FormParaBO()
2394:         LOCAL loc_lSucesso, loc_oErro
2395:         loc_lSucesso = .F.
2396: 
2397:         IF VARTYPE(THIS.this_oBusinessObject) != "O"
2398:             RETURN loc_lSucesso
2399:         ENDIF
2400: 
2401:         TRY
2402:             WITH THIS.this_oBusinessObject
2403:                 *-- Padr(...,3) e o do legado: SigCdEmp.Cemps e char(3) e a
2404:                 *-- comparacao em SigMvPar.Emps tambem (chave POSICIONAL -
2405:                 *-- regra #42). EMPTY("   ") continua .T., entao o filtro
2406:                 *-- vazio segue significando "todas as empresas".
2407:                 .this_cEmps       = PADR(ALLTRIM(THIS.txt_4c_EmpOs.Value), 3)
2408:                 .this_cDescEmps   = ALLTRIM(THIS.txt_4c_DEmpOs.Value)
2409:                 .this_dDataIni    = ConverterParaData(THIS.txt_4c_DtIni.Value)
2410:                 .this_dDataFin    = ConverterParaData(THIS.txt_4c_DtFin.Value)
2411:                 .this_nProcessados = THIS.obj_4c_OptProcessados.Value
2412:                 .this_cArquivo    = ALLTRIM(THIS.obj_4c_GetArqNoms.Value)
2413:                 .this_cAdquirente = ALLTRIM(THIS.txt_4c_Adquirs.Value)
2414:             ENDWITH
2415: 
2416:             loc_lSucesso = .T.
2417: 
2418:         CATCH TO loc_oErro
2419:             THIS.this_cMensagemErro = loc_oErro.Message
2420:             MsgErro(loc_oErro.Message + CHR(13) + ;
2421:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
2422:                 "Procedure: " + loc_oErro.Procedure, ;
2423:                 "Erro FormParaBO")
2424:         ENDTRY
2425: 
2426:         RETURN loc_lSucesso
2427:     ENDPROC
2428: 
2429:     *==========================================================================
2430:     * TornarControlesVisiveis - Torna visiveis os controles ja criados nesta
2431:     * fase (AddObject nasce Visible=.F.). Varre recursivamente para que as
2432:     * fases seguintes (grade dentro de cnt_4c_Grade, CommandGroups de botoes)
2433:     * fiquem automaticamente cobertas sem precisar reescrever este metodo.
2434:     *==========================================================================
2435:     PROTECTED PROCEDURE TornarControlesVisiveis()
2436:         LOCAL loc_nI
2437: 
2438:         FOR loc_nI = 1 TO THIS.ControlCount
2439:             THIS.TornarVisivelRecursivo(THIS.Controls(loc_nI))
2440:         ENDFOR
2441:     ENDPROC
2442: 
2443:     *==========================================================================
2444:     * TornarVisivelRecursivo - torna par_oObjeto e seus filhos (Controls e,
2445:     * se for PageFrame, Pages) visiveis, recursivamente.
2446:     *==========================================================================
2447:     PROTECTED PROCEDURE TornarVisivelRecursivo(par_oObjeto)
2448:         LOCAL loc_nI
2449: 
2450:         IF VARTYPE(par_oObjeto) != "O"
2451:             RETURN
2452:         ENDIF
2453: 
2454:         IF PEMSTATUS(par_oObjeto, "Visible", 5)
2455:             par_oObjeto.Visible = .T.
2456:         ENDIF
2457: 
2458:         IF PEMSTATUS(par_oObjeto, "PageCount", 5)
2459:             FOR loc_nI = 1 TO par_oObjeto.PageCount
2460:                 THIS.TornarVisivelRecursivo(par_oObjeto.Pages(loc_nI))
2461:             ENDFOR
2462:         ENDIF
2463: 
2464:         IF PEMSTATUS(par_oObjeto, "ControlCount", 5)
2465:             FOR loc_nI = 1 TO par_oObjeto.ControlCount
2466:                 THIS.TornarVisivelRecursivo(par_oObjeto.Controls(loc_nI))
2467:             ENDFOR
2468:         ENDIF
2469:     ENDPROC
2470: 
2471: ENDDEFINE


### BO (C:\4c\projeto\app\classes\SigOpVdaBO.prg):
*------------------------------------------------------------------------------
* SigOpVdaBO - Business Object de Geracao de Arquivos de Vendas
* Baseado no formulario legado SIGOPVDA (SigOpVda.SCX)
* Tabela principal: SigPcOoL (controle de operacoes ja processadas)
*------------------------------------------------------------------------------
DEFINE CLASS SigOpVdaBO AS BusinessBase

    *-- Filtros de selecao (Pagina de criterios do form)
    this_cEmps = ""
    this_cDescEmps = ""
    this_dDataIni = {}
    this_dDataFin = {}
    this_nProcessados = 1
    this_cArquivo = ""
    this_cAdquirente = ""

    *-- Campos do registro de controle (SigPcOoL) gravado por operacao processada
    this_cTipos = ""
    this_cEmpsReg = ""      && emps da LINHA processada (empresa do movimento) - NAO confundir com this_cEmps (filtro digitado na tela)
    this_cDopes = ""
    this_nNumes = 0
    this_dDatas = {}
    this_cUsuars = ""
    this_cProdutos = ""
    this_cProcessos = ""
    this_cIdChaves = ""
    this_cEmpDopNums = ""

    *--------------------------------------------------------------------------
    * Init - Inicializa o BusinessObject
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        THIS.this_cTabela = "SigPcOoL"
        THIS.this_cCampoChave = "cIdChaves"

        DODEFAULT()

        *-- Filtros nascem com os defaults do Init legado (ver
        *-- AplicarFiltrosPadrao). O form os leva para a tela no
        *-- BOParaForm() chamado pelo InicializarForm.
        THIS.AplicarFiltrosPadrao()
    ENDPROC

    *--------------------------------------------------------------------------
    * AplicarFiltrosPadrao - valores iniciais dos filtros de selecao,
    * transcritos do bloco de defaults do Init do SCX legado (dentro do
    * "If (.poDataMgr.pnIdconn > 0)"):
    *
    *   .getDtIni.Value   = Date()
    *   .getDtFin.Value   = Date()
    *   .getArqNoms.Value = [C:\CONCILIADOR.CSV]
    *   optProcessados.Value = 1   (1-Nao Processadas / 2-Ja Processadas)
    *
    * Sem isto a tela abre com as duas datas e o caminho do arquivo em
    * BRANCO e o botao Selecionar recusa de imediato ("A Data Inicial Nao
    * Pode Ficar em Branco!!!" / "O Arquivo a Ser Gerado Precisa Ser
    * Informado!!!") - divergencia silenciosa do legado, que ja abre a tela
    * pronta para o dia corrente.
    *
    * Empresa, descricao da empresa e adquirente ficam VAZIOS de proposito:
    * o legado nao os preenche, e vazio significa "todas as empresas" /
    * "todos os adquirentes" nas duas consultas (o IIF(EMPTY(...)) de
    * Selecionar simplesmente omite a clausula do WHERE).
    *
    * PUBLIC (regra #51): o Form chama este metodo de FORA da classe.
    *--------------------------------------------------------------------------
    PROCEDURE AplicarFiltrosPadrao()
        THIS.this_cEmps         = ""
        THIS.this_cDescEmps     = ""
        THIS.this_dDataIni      = DATE()
        THIS.this_dDataFin      = DATE()
        THIS.this_nProcessados  = 1
        THIS.this_cArquivo      = "C:\CONCILIADOR.CSV"
        THIS.this_cAdquirente   = ""

        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * LimparDados - Limpa as propriedades do registro de controle
    *--------------------------------------------------------------------------
    PROCEDURE LimparDados()
        DODEFAULT()

        THIS.this_cTipos = ""
        THIS.this_cEmpsReg = ""
        THIS.this_cDopes = ""
        THIS.this_nNumes = 0
        THIS.this_dDatas = {}
        THIS.this_cUsuars = ""
        THIS.this_cProdutos = ""
        THIS.this_cProcessos = ""
        THIS.this_cIdChaves = ""
        THIS.this_cEmpDopNums = ""
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - cidchaves char(20), PK de SigPcOoL
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ObterChavePrimaria()
        RETURN ALLTRIM(NVL(THIS.this_cIdChaves, ""))
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Carrega as propriedades do registro de controle a
    * partir da linha corrente de um alias no formato de SigPcOoL/crSigPcOoL
    * (tipos, emps, dopes, numes, datas, usuars, produtos, processos,
    * cidchaves, empdopnums).
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        IF VARTYPE(par_cAliasCursor) != "C" OR EMPTY(par_cAliasCursor) OR !USED(par_cAliasCursor)
            RETURN .F.
        ENDIF

        IF EOF(par_cAliasCursor)
            RETURN .F.
        ENDIF

        SELECT (par_cAliasCursor)

        THIS.this_cTipos      = TratarNulo(tipos, "")
        THIS.this_cEmpsReg    = TratarNulo(emps, "")
        THIS.this_cDopes      = TratarNulo(dopes, "")
        THIS.this_nNumes      = TratarNulo(numes, 0)
        THIS.this_dDatas      = ConverterParaData(TratarNulo(datas, {}))
        THIS.this_cUsuars     = TratarNulo(usuars, "")
        THIS.this_cProdutos   = TratarNulo(produtos, "")
        THIS.this_cProcessos  = TratarNulo(processos, "")
        THIS.this_cIdChaves   = TratarNulo(cidchaves, "")
        THIS.this_cEmpDopNums = TratarNulo(empdopnums, "")

        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir - Grava um registro de controle em SigPcOoL (uma linha por
    * operacao de venda processada/exportada), reproduzindo o
    * "Insert Into crSigPcOoL (...)" do metodo Processamento() do legado.
    *
    * cidchaves (PK char(20)) e gerado com fUniqueIds() quando ainda nao foi
    * atribuido - NUNCA string vazia, senao a linha seguinte do lote colide
    * no indice unico sigpcool_cidchaves (regra #22 do CLAUDE.md).
    *
    * empds/dopeds/numeds/edndests/nopers sao NOT NULL sem DEFAULT no schema
    * mas o legado nunca os preenche (o Insert Into do SCX lista so 10 das 15
    * colunas) - no fluxo legado eles chegam em branco/zero porque o cursor
    * crSigPcOoL nasce de AddCursor (estrutura completa da tabela, valores
    * default do tipo). Aqui o INSERT via SQLEXEC precisa declarar esses
    * mesmos defaults explicitamente, senao o SQL Server recusa a linha
    * inteira por tentar gravar NULL numa coluna que nao aceita.
    *--------------------------------------------------------------------------
    PROCEDURE Inserir()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso, loc_oErro
        loc_lSucesso = .F.
        THIS.this_cMensagemErro = ""

        TRY
            IF EMPTY(ALLTRIM(NVL(THIS.this_cIdChaves, "")))
                THIS.this_cIdChaves = ALLTRIM(fUniqueIds())
            ENDIF

            loc_cSQL = "INSERT INTO SigPcOoL" + ;
                       " (tipos, emps, dopes, numes, empds, dopeds, numeds, datas," + ;
                       "  usuars, produtos, cidchaves, edndests, empdopnums, processos, nopers)" + ;
                       " VALUES (" + ;
                       EscaparSQL(THIS.this_cTipos) + "," + ;
                       EscaparSQL(THIS.this_cEmpsReg) + "," + ;
                       EscaparSQL(THIS.this_cDopes) + "," + ;
                       FormatarNumeroSQL(THIS.this_nNumes, 0) + "," + ;
                       EscaparSQL("") + "," + ;
                       EscaparSQL("") + "," + ;
                       FormatarNumeroSQL(0, 0) + "," + ;
                       "GETDATE()," + ;
                       EscaparSQL(THIS.this_cUsuars) + "," + ;
                       EscaparSQL(THIS.this_cProdutos) + "," + ;
                       EscaparSQL(THIS.this_cIdChaves) + "," + ;
                       EscaparSQL("") + "," + ;
                       EscaparSQL(THIS.this_cEmpDopNums) + "," + ;
                       EscaparSQL(THIS.this_cProcessos) + "," + ;
                       FormatarNumeroSQL(0, 0) + ")"

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("INSERT")
                loc_lSucesso = .T.
            ELSE
                THIS.this_cMensagemErro = "Erro ao gravar controle de opera" + CHR(231) + CHR(227) + ;
                    "o processada:" + CHR(13) + CapturarErroSQL()
                MsgErro(THIS.this_cMensagemErro, "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro("Erro ao gravar controle de opera" + CHR(231) + CHR(227) + "o processada:" + ;
                CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - Corrige um registro de controle ja gravado em SigPcOoL,
    * identificado pela PK cidchaves. O legado (SIGOPVDA) nunca faz UPDATE
    * nesta tabela - cada linha e gravada uma unica vez no Processamento() e
    * nunca mais tocada - mas o metodo e implementado para completar o
    * contrato de BusinessBase.Salvar() (THIS.this_lNovoRegistro = .F.).
    *--------------------------------------------------------------------------
    PROCEDURE Atualizar()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso, loc_oErro
        loc_lSucesso = .F.
        THIS.this_cMensagemErro = ""

        TRY
            IF EMPTY(ALLTRIM(NVL(THIS.this_cIdChaves, "")))
                THIS.this_cMensagemErro = "Registro sem chave para altera" + CHR(231) + CHR(227) + "o"
            ELSE
                loc_cSQL = "UPDATE SigPcOoL SET" + ;
                           " tipos = "      + EscaparSQL(THIS.this_cTipos) + "," + ;
                           " emps = "       + EscaparSQL(THIS.this_cEmpsReg) + "," + ;
                           " dopes = "      + EscaparSQL(THIS.this_cDopes) + "," + ;
                           " numes = "      + FormatarNumeroSQL(THIS.this_nNumes, 0) + "," + ;
                           " usuars = "     + EscaparSQL(THIS.this_cUsuars) + "," + ;
                           " produtos = "   + EscaparSQL(THIS.this_cProdutos) + "," + ;
                           " processos = "  + EscaparSQL(THIS.this_cProcessos) + "," + ;
                           " empdopnums = " + EscaparSQL(THIS.this_cEmpDopNums) + ;
                           " WHERE cidchaves = " + EscaparSQL(THIS.this_cIdChaves)

                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

                IF loc_nResultado >= 0
                    THIS.RegistrarAuditoria("UPDATE")
                    loc_lSucesso = .T.
                ELSE
                    THIS.this_cMensagemErro = "Erro ao atualizar controle de opera" + CHR(231) + CHR(227) + ;
                        "o processada:" + CHR(13) + CapturarErroSQL()
                    MsgErro(THIS.this_cMensagemErro, "Erro SQL")
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro("Erro ao atualizar controle de opera" + CHR(231) + CHR(227) + "o processada:" + ;
                CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

ENDDEFINE


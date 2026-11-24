# CODE REVIEW - PASS FUNCTIONAL: Functional Logic (metodos, eventos, containers)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Functional Logic (metodos, eventos, containers)**.

## PROBLEMAS DETECTADOS (3)
- [METODO-INEXISTENTE] Metodo 'THIS.Controls()' chamado mas NAO definido como PROCEDURE no Form nem herdado de FormBase. A LLM pode ter inventado este metodo. VERIFICAR se existe no legado e IMPLEMENTAR ou REMOVER a chamada.
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

### FORM (C:\4c\projeto\app\forms\operacionais\FormSigOpVda.prg) - TRECHOS RELEVANTES PARA PASS FUNCTIONAL (2475 linhas total):

*-- Linhas 45 a 158:
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

*-- Linhas 319 a 417:
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
344:         SET NULL ON
345:         CREATE CURSOR cursor_4c_Operacoes (SelImp L(1), TIPO_REGISTRO C(3), ;
346:             ADQUIRENTE C(60), LOJA_FILIAL C(15), BANDEIRA C(60), ;
347:             TIPO_TRANSACAO C(15), NRO_PARCELA C(2), QTD_PARCELAS C(2), ;
348:             TID C(40), NSU C(30), AUTORIZACAO C(20), VALOR C(14), ;
349:             CLIENTE C(50), DATA_VENDA C(10), ORIGEM C(10), SEQUENCIA C(20), ;
350:             NOTA_FISCAL C(20), CPF_CNPJ C(20), ESTABELECIMENTO C(20), ;
351:             DATA_VENCIMENTO C(10), NUMERO_CARTAO C(30), REFERENCIA1 C(60), ;
352:             Emps C(3), Dopes C(20), Numes N(6), EmpDopNums C(29), Erros L(1))
353:         SET NULL OFF
354:     ENDPROC
355: 
356:     *==========================================================================
357:     * ConfigurarGrade - cntGrade/GrdOperacoes do legado -> cnt_4c_Grade/
358:     * grd_4c_Dados (grade de 13 colunas que lista as operacoes selecionadas
359:     * para gerar o arquivo de vendas).
360:     *
361:     * Transcricao do dump (SIGOPVDA.cntGrade/GrdOperacoes):
362:     *   cntGrade      Top=198 Left=13 Width=1229 Height=387 BorderWidth=0
363:     *   GrdOperacoes  Top=2 Left=1 Width=1225 Height=467 RowHeight=16
364:     *                 HeaderHeight=16 ScrollBars=2 DeleteMark=.F. RecordMark=.F.
365:     *                 AllowHeaderSizing=.F. AllowRowSizing=.F.
366:     *                 GridLineColor=238,238,238 Tahoma 8
367:     *
368:     * ColumnCount/RecordSource ficam FORA do WITH que acessa .ColumnN -
369:     * dentro do mesmo WITH, acessar .Column1 logo depois de atribuir
370:     * RecordSource estoura "Unknown member COLUMN1" (regra GRID-WITH).
371:     *
372:     * Geometria/headers das colunas moram em AplicarFormatoGrade (chamada ao
373:     * final), que e a FONTE UNICA (regra do Problema 48: RecordSource zera
374:     * Column.Width e Header1.Caption, e este metodo e chamado de novo quando
375:     * a grade for religada a dado real nas fases seguintes).
376:     *==========================================================================
377:     PROTECTED PROCEDURE ConfigurarGrade()
378:         THIS.CriarCursorOperacoes()
379: 
380:         THIS.AddObject("cnt_4c_Grade", "Container")
381:         WITH THIS.cnt_4c_Grade
382:             .Top           = 198
383:             .Left          = 13
384:             .Width         = 1229
385:             .Height        = 387
386:             .BackStyle     = 0
387:             .BorderWidth   = 0
388:             .SpecialEffect = 0
389:             .TabIndex      = 15
390:             .Visible       = .T.
391:         ENDWITH
392: 
393:         THIS.cnt_4c_Grade.AddObject("grd_4c_Dados", "Grid")
394: 
395:         WITH THIS.cnt_4c_Grade.grd_4c_Dados
396:             .Top               = 2
397:             .Left              = 1
398:             .Width             = 1225
399:             .Height            = 467
400:             .FontName          = "Tahoma"
401:             .FontSize          = 8
402:             .AllowHeaderSizing = .F.
403:             .AllowRowSizing    = .F.
404:             .DeleteMark        = .F.
405:             .RecordMark        = .F.
406:             .HeaderHeight      = 19
407:             .RowHeight         = 16
408:             .ScrollBars        = 2
409:             .TabIndex          = 16
410:             .GridLineColor     = RGB(238, 238, 238)
411:             .Visible           = .T.
412: 
413:             *-- Grid.ReadOnly ANTES de qualquer Column.ReadOnly (regra #18:
414:             *-- o do grid propaga para as colunas e sobrescreve). O legado
415:             *-- declara .ReadOnly = .f. no Init (so a Column1 e editavel - as
416:             *-- demais sao travadas uma a uma em AplicarFormatoGrade).
417:             .ReadOnly          = .F.

*-- Linhas 425 a 491:
425:         *-- ColumnCount sem RecordSource faz o Grid AUTO-BINDAR na area de
426:         *-- trabalho CORRENTE, e a Column1 pode cair numa coluna de tipo
427:         *-- incompativel - dai o AddObject do CheckBox estoura "Data type
428:         *-- mismatch" no proprio AddObject, dentro do TRY do InicializarForm,
429:         *-- e a tela nao abre. Vinculando ANTES, a Column1 ja esta no campo
430:         *-- LOGICO SelImp quando o Check1 e criado.
431:         THIS.VincularGrade()
432:     ENDPROC
433: 
434:     *==========================================================================
435:     * VincularGrade - liga grd_4c_Dados ao alias cursor_4c_Operacoes
436:     * (RecordSource + os 13 ControlSource, transcritos um a um do Init legado,
437:     * inclusive a EXPRESSAO calculada da Column7).
438:     *
439:     * Separado de ConfigurarGrade de proposito: ConfigurarGrade carrega so o
440:     * que NAO depende de dado (geometria, ColumnCount, fontes, cores), e o
441:     * bind vive aqui porque e refeito a cada recarga. Guardado por USED() -
442:     * atribuir RecordSource/ControlSource de alias que ainda nao existe
443:     * estoura "Alias is not found" DENTRO do TRY do InicializarForm, o que
444:     * faz CREATEOBJECT devolver .F. e a tela nao abrir (regra #41).
445:     *
446:     * AplicarFormatoGrade e chamada DEPOIS do bind, SEMPRE (inclusive quando
447:     * o alias nao esta aberto): atribuir RecordSource zera Column.Width e
448:     * Header1.Caption (regra #41 / Problema 48), e sem a reaplicacao a grade
449:     * ficaria com cabecalho "Column1" e largura default.
450:     *==========================================================================
451:     PROCEDURE VincularGrade()
452:         LOCAL loc_lVinculou
453:         loc_lVinculou = .F.
454: 
455:         IF !PEMSTATUS(THIS, "cnt_4c_Grade", 5)
456:             RETURN loc_lVinculou
457:         ENDIF
458: 
459:         IF !PEMSTATUS(THIS.cnt_4c_Grade, "grd_4c_Dados", 5)
460:             RETURN loc_lVinculou
461:         ENDIF
462: 
463:         IF USED("cursor_4c_Operacoes")
464:             THIS.cnt_4c_Grade.grd_4c_Dados.ColumnCount = 3
465:             THIS.cnt_4c_Grade.grd_4c_Dados.RecordSource = "cursor_4c_Operacoes"
466: 
467:             WITH THIS.cnt_4c_Grade.grd_4c_Dados
468:                 .Column1.ControlSource  = "cursor_4c_Operacoes.SelImp"
469:                 .Column2.ControlSource  = "cursor_4c_Operacoes.DATA_VENDA"
470:                 .Column3.ControlSource  = "cursor_4c_Operacoes.ADQUIRENTE"
471:                 .Column4.ControlSource  = "cursor_4c_Operacoes.BANDEIRA"
472:                 .Column5.ControlSource  = "cursor_4c_Operacoes.TIPO_TRANSACAO"
473:                 .Column6.ControlSource  = "cursor_4c_Operacoes.DATA_VENCIMENTO"
474:                 .Column7.ControlSource  = "PADL(cursor_4c_Operacoes.NRO_PARCELA, 2, '0') + ' / ' + " + ;
475:                                            "PADL(cursor_4c_Operacoes.QTD_PARCELAS, 2, '0')"
476:                 .Column8.ControlSource  = "cursor_4c_Operacoes.NSU"
477:                 .Column9.ControlSource  = "cursor_4c_Operacoes.AUTORIZACAO"
478:                 .Column10.ControlSource = "cursor_4c_Operacoes.VALOR"
479:                 .Column11.ControlSource = "cursor_4c_Operacoes.Emps"
480:                 .Column12.ControlSource = "cursor_4c_Operacoes.Dopes"
481:                 .Column13.ControlSource = "cursor_4c_Operacoes.Numes"
482:             ENDWITH
483: 
484:             loc_lVinculou = .T.
485:         ENDIF
486: 
487:         *-- SEMPRE, vinculado ou nao (RecordSource zera Width/Caption)
488:         THIS.AplicarFormatoGrade()
489: 
490:         RETURN loc_lVinculou
491:     ENDPROC

*-- Linhas 524 a 649:
524:     * Nao estoura sem o cursor: TRY, resultado por flag e RETURN unico depois
525:     * do ENDTRY (regra #1).
526:     *==========================================================================
527:     PROCEDURE CarregarDados()
528:         LOCAL loc_lSucesso, loc_oErro
529:         loc_lSucesso = .F.
530: 
531:         TRY
532:             THIS.CriarCursorOperacoes()
533: 
534:             IF THIS.VincularGrade()
535:                 SELECT cursor_4c_Operacoes
536:                 GO TOP IN cursor_4c_Operacoes
537: 
538:                 THIS.Refresh()
539:                 THIS.cnt_4c_Grade.grd_4c_Dados.Refresh()
540: 
541:                 loc_lSucesso = .T.
542:             ENDIF
543: 
544:         CATCH TO loc_oErro
545:             THIS.this_cMensagemErro = loc_oErro.Message
546:             MsgErro(loc_oErro.Message + CHR(13) + ;
547:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
548:                 "Procedure: " + loc_oErro.Procedure, ;
549:                 "Erro CarregarDados")
550:         ENDTRY
551: 
552:         RETURN loc_lSucesso
553:     ENDPROC
554: 
555:     *==========================================================================
556:     * AplicarFormatoGrade - FONTE UNICA da geometria/headers das 13 colunas
557:     * de grd_4c_Dados (regra do Problema 48 - chamada de novo sempre que o
558:     * RecordSource for reatribuido nas fases seguintes).
559:     *
560:     * Transcricao do dump coluna a coluna (Width/Alignment/Header1.Caption/
561:     * Text1.* de cada Column do SCX original). Colunas 2 a 13 ficam
562:     * ReadOnly (legado: "For I=2 To .ColumnCount / .ReadOnly = .t.") - so a
563:     * Column1 (SelImp) e editavel.
564:     *
565:     * Column1.Check1: AddObject + CurrentControl + Sparse=.F. (regra #18) -
566:     * sem isso a coluna desenha o valor cru em vez do CheckBox. Guard
567:     * PEMSTATUS antes do AddObject porque este metodo roda de novo apos
568:     * RecordSource (Problema 48) e um 2o AddObject do mesmo nome estouraria
569:     * "Object already defined".
570:     *
571:     * NENHUM BINDEVENT aqui (MouseDown/MouseUp/KeyPress/Click do Check1) -
572:     * fica para a Fase 7, mesmo padrao dos irmaos desta familia.
573:     *
574:     * Metodo PUBLIC (regra #3): e chamado tanto na montagem (ConfigurarGrade)
575:     * quanto nas recargas futuras, e o harness de teste pode alcanca-lo de
576:     * fora da classe.
577:     *==========================================================================
578:     PROCEDURE AplicarFormatoGrade()
579:         LOCAL loc_lAplicou
580:         loc_lAplicou = .F.
581: 
582:         IF !PEMSTATUS(THIS, "cnt_4c_Grade", 5)
583:             RETURN loc_lAplicou
584:         ENDIF
585: 
586:         IF !PEMSTATUS(THIS.cnt_4c_Grade, "grd_4c_Dados", 5)
587:             RETURN loc_lAplicou
588:         ENDIF
589: 
590:         WITH THIS.cnt_4c_Grade.grd_4c_Dados
591:             *-- Column1 (SelImp) - marcacao da linha para processamento
592:             .Column1.Width             = 16
593:             .Column1.FontName          = "Tahoma"
594:             .Column1.FontSize          = 8
595:             .Column1.Header1.Caption   = ""
596:             .Column1.Header1.FontName  = "Tahoma"
597:             .Column1.Header1.FontSize  = 8
598:             .Column1.Header1.Alignment = 2
599: 
600:             IF !PEMSTATUS(.Column1, "Check1", 5)
601:                 .Column1.AddObject("Check1", "CheckBox")
602: 
603:                 *-- BINDEVENT so na criacao (este metodo roda de novo apos
604:                 *-- RecordSource - Problema 48 - e um 2o BINDEVENT no mesmo
605:                 *-- objeto duplicaria a execucao do handler).
606:                 BINDEVENT(.Column1.Check1, "KeyPress",  THIS, "Check1KeyPress")
607:                 BINDEVENT(.Column1.Check1, "MouseUp",   THIS, "Check1MouseUp")
608:                 BINDEVENT(.Column1.Check1, "MouseDown", THIS, "Check1MouseDown")
609:                 BINDEVENT(.Column1.Check1, "Click",     THIS, "Check1Click")
610:             ENDIF
611:             WITH .Column1.Check1
612:                 .Top         = 9
613:                 .Left        = 2
614:                 .Height      = 17
615:                 .Width       = 22
616:                 .FontName    = "Tahoma"
617:                 .FontSize    = 8
618:                 .Alignment   = 0
619:                 .AutoSize    = .T.
620:                 .Caption     = ""
621:                 .ToolTipText = "Marca/Desmarca Esta Opera" + CHR(231) + CHR(227) + "o Para o Processamento"
622:                 .ReadOnly    = .F.
623:                 .Visible     = .T.
624:             ENDWITH
625:             .Column1.CurrentControl = "Check1"
626:             .Column1.Sparse         = .F.
627:             .Column1.ReadOnly       = .F.
628:             .Column1.Movable        = .F.
629:             .Column1.Resizable      = .F.
630: 
631:             *-- Column2 (DATA_VENDA) - "Data"
632:             .Column2.Alignment         = 2
633:             .Column2.Width             = 80
634:             .Column2.Movable           = .F.
635:             .Column2.Resizable         = .F.
636:             .Column2.ReadOnly          = .T.
637:             .Column2.FontName          = "Tahoma"
638:             .Column2.FontSize          = 8
639:             .Column2.Header1.Caption   = "Data"
640:             .Column2.Header1.FontName  = "Tahoma"
641:             .Column2.Header1.FontSize  = 8
642:             .Column2.Header1.Alignment = 2
643:             .Column2.Text1.Alignment   = 2
644:             .Column2.Text1.BorderStyle = 1
645:             .Column2.Text1.Margin      = 0
646:             .Column2.Text1.ReadOnly    = .T.
647:             .Column2.Text1.ForeColor   = RGB(0, 0, 0)
648: 
649:             *-- Column3 (ADQUIRENTE) - "Adquirente"

*-- Linhas 843 a 931:
843: 
844:             *-- Legado: .SetAll('DynamicForeColor', 'Iif(csOperacoes.Erros,
845:             *-- Rgb(255,0,0), Rgb(0,0,0))', 'Column') - linha em erro pinta
846:             *-- vermelho (ver PROCEDURE selecionar, m.Erros)
847:             .SetAll("DynamicForeColor", "IIF(cursor_4c_Operacoes.Erros, RGB(255,0,0), RGB(0,0,0))", "Column")
848:         ENDWITH
849: 
850:         loc_lAplicou = .T.
851:         RETURN loc_lAplicou
852:     ENDPROC
853: 
854:     *==========================================================================
855:     * ConfigurarBotoes - cmdBtnGrade/cmdBtnForm/cmdSelecionar do legado ->
856:     * cmg_4c_CmdBtnGrade / cmg_4c_CmdBtnForm / cmd_4c_CmdSelecionar.
857:     *
858:     * Transcricao do dump:
859:     *   cmdBtnGrade (Marca Tudo/Desmarca/Documentos da linha corrente):
860:     *     ButtonCount=3 BackStyle=0 BorderStyle=0 Top=339 Left=1244
861:     *     Width=43 Height=135 Themes=.F.
862:     *     Buttons: Top=-1/45/91 Left=-1 Height=45 Width=45 Verdana 8
863:     *       1=geral_marcar_26.jpg      ToolTip "Selecionar"
864:     *       2=cadastro_excluir_26.jpg  ToolTip "Desmarcar"
865:     *       3=geral_configuracao_26.jpg ToolTip "Documento"
866:     *       ForeColor=36,84,155 BackColor=255,255,255 (DECLARADO no dump,
867:     *       por isso prevalece sobre o canonico 90,90,90 - regra #12)
868:     *
869:     *   cmdBtnForm (Limpar Selecao/Gera Arquivo/Encerrar):
870:     *     AutoSize=.T. ButtonCount=3 BackStyle=0 BorderStyle=0
871:     *     SpecialEffect=1 Top=-2 Left=1070 Width=235 Height=85
872:     *     BorderColor=136,189,188 Themes=.F.
873:     *     Buttons: Top=5 Left=5/80/155 Height=75 Width=75 Comic Sans MS 8 bold italic
874:     *       1=geral_limpa_grade_60.jpg "Limpar"       ToolTip "Limpar Selecao"
875:     *       2=geral_disco2_60.jpg      "Gera Arquivo"
876:     *       3=cadastro_sair_60.jpg     "Encerrar" Cancel=.T. ToolTip "[ESC] Sair"
877:     *       ForeColor=90,90,90 BackColor=255,255,255
878:     *
879:     *   cmdSelecionar (standalone - dispara a consulta das operacoes):
880:     *     Top=3 Left=1000 Height=75 Width=75 Comic Sans MS 8 bold italic
881:     *     Picture=importar_72_down.png Caption="\<Selecionar"
882:     *     ForeColor=90,90,90 BackColor=255,255,255
883:     *     Themes = .T. + DisabledPicture (standalone com Picture - regra #99;
884:     *     o legado declara Themes=.F., mas essa excecao do projeto prevalece,
885:     *     senao o icone some quando o botao for desabilitado nas fases
886:     *     seguintes)
887:     *
888:     * NENHUM BINDEVENT de Click aqui - fica para a Fase 7, mesmo padrao dos
889:     * irmaos desta familia (FormSigoptrp.prg/FormSigOpTrf.prg/FormSigOpTop.prg).
890:     *==========================================================================
891:     PROTECTED PROCEDURE ConfigurarBotoes()
892:         LOCAL loc_cIconeMarcaTudo, loc_cIconeDesmarcar, loc_cIconeDocumentos, ;
893:               loc_cIconeLimpar, loc_cIconeGeraArquivo, loc_cIconeEncerrar, ;
894:               loc_cIconeSelecionar
895: 
896:         loc_cIconeMarcaTudo   = ""
897:         loc_cIconeDesmarcar   = ""
898:         loc_cIconeDocumentos  = ""
899:         loc_cIconeLimpar      = ""
900:         loc_cIconeGeraArquivo = ""
901:         loc_cIconeEncerrar    = ""
902:         loc_cIconeSelecionar  = ""
903: 
904:         IF TYPE("gc_4c_CaminhoIcones") = "C"
905:             loc_cIconeMarcaTudo   = gc_4c_CaminhoIcones + "geral_marcar_26.jpg"
906:             loc_cIconeDesmarcar   = gc_4c_CaminhoIcones + "cadastro_excluir_26.jpg"
907:             loc_cIconeDocumentos  = gc_4c_CaminhoIcones + "geral_configuracao_26.jpg"
908:             loc_cIconeLimpar      = gc_4c_CaminhoIcones + "geral_limpa_grade_60.jpg"
909:             loc_cIconeGeraArquivo = gc_4c_CaminhoIcones + "geral_disco2_60.jpg"
910:             loc_cIconeEncerrar    = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
911:             loc_cIconeSelecionar  = gc_4c_CaminhoIcones + "Importar_72_Down.png"
912:         ENDIF
913: 
914:         *-- cmdBtnGrade -> cmg_4c_CmdBtnGrade
915:         THIS.AddObject("cmg_4c_CmdBtnGrade", "CommandGroup")
916:         WITH THIS.cmg_4c_CmdBtnGrade
917:             .ButtonCount = 3
918:             .BackStyle   = 0
919:             .BorderStyle = 0
920:             .Top         = 339
921:             .Left        = 1244
922:             .Width       = 43
923:             .Height      = 135
924:             .TabIndex    = 16
925:             .Themes      = .F.
926:             .Visible     = .T.
927:         ENDWITH
928: 
929:         WITH THIS.cmg_4c_CmdBtnGrade.Buttons(1)
930:             .Top         = -1
931:             .Left         = -1

*-- Linhas 1087 a 1198:
1087:             .Visible = .T.
1088:         ENDWITH
1089: 
1090:         *-- BINDEVENT dos 3 botoes de acao desta fase (regra #3: handlers
1091:         *-- PUBLIC). cmdSelecionar.Valid do legado -> Click (CommandButton
1092:         *-- standalone nao dispara Valid).
1093:         BINDEVENT(THIS.cmg_4c_CmdBtnGrade,   "Click", THIS, "CmgCmdBtnGradeClick")
1094:         BINDEVENT(THIS.cmg_4c_CmdBtnForm,    "Click", THIS, "CmgCmdBtnFormClick")
1095:         BINDEVENT(THIS.cmd_4c_CmdSelecionar, "Click", THIS, "CmdSelecionarClick")
1096:     ENDPROC
1097: 
1098:     *==========================================================================
1099:     * ConfigurarFiltrosParte1 - PRIMEIRA METADE dos campos de filtro do
1100:     * SIGOPVDA.SCX (os que ficam na parte SUPERIOR do form, entre o
1101:     * cabecalho e a grade): linha "Movimentacoes :" + optProcessados
1102:     * (Label1/optProcessados) e a linha "Periodo de Venda :" (Say1/getDtIni/
1103:     * Say2 "ate"/getDtFin/Say33 "Adquirente :"/getAdquirs).
1104:     *
1105:     * A segunda metade (linha "Empresa :" com getEmpOs/getDEmpOs e a linha
1106:     * "Arquivo :" com getArqNoms/btnNomArqs) fica para a Fase 6, em
1107:     * ConfigurarFiltrosParte2() - mesmo criterio de divisao do restante da
1108:     * migracao multi-fase (metade dos campos por fase).
1109:     *
1110:     * Transcricao do dump (sem compensacao de PageFrame - este form
1111:     * OPERACIONAL nao tem PageFrame, os controles sao filhos diretos de
1112:     * THIS, igual ao cntGrade/cmdBtnGrade das fases 3/4):
1113:     *   Label1         Top=87  Left=44  Width=83  Height=15 AutoSize=.F.
1114:     *                  "Movimentacoes :"
1115:     *   optProcessados Top=89  Left=124 Width=235 Height=15 ButtonCount=2
1116:     *                  Option1="Nao Processadas" Option2="Ja Processadas"
1117:     *                  (Value=1 default - legado: 1-Nao Processadas;
1118:     *                  2-Ja Processadas)
1119:     *   Say1           Top=113 Left=34  "Periodo de Venda :"
1120:     *   getDtIni       Top=109 Left=129 Width=80 Height=23 (fweditdata -
1121:     *                  sem Width/Height no dump, usando o mesmo tamanho de
1122:     *                  getDtFin para nao sobrepor Say2 em Left=216)
1123:     *   Say2           Top=113 Left=216 "ate"
1124:     *   getDtFin       Top=109 Left=240 Width=80 Height=23
1125:     *   Say33          Top=113 Left=406 "Adquirente :"
1126:     *   getAdquirs     Top=109 Left=470 Width=150 Height=23 BorderStyle=1
1127:     *
1128:     * NENHUM BINDEVENT aqui (Valid/KeyPress de getDtIni/getDtFin/getAdquirs,
1129:     * InteractiveChange de optProcessados) - fica para a Fase 7, mesmo
1130:     * padrao das fases anteriores desta familia.
1131:     *
1132:     * Valores iniciais (.Value) ficam vazios/default nesta fase - o legado
1133:     * so atribui Date() a getDtIni/getDtFin e 1 a optProcessados dentro do
1134:     * bloco "poDataMgr.pnIdconn > 0" do Init (depende de conexao SQL), que
1135:     * entra no funil de carga das fases seguintes.
1136:     *==========================================================================
1137:     PROTECTED PROCEDURE ConfigurarFiltrosParte1()
1138:         *-- Label1 -> lbl_4c_Label1 "Movimentacoes :"
1139:         THIS.AddObject("lbl_4c_Label1", "Label")
1140:         WITH THIS.lbl_4c_Label1
1141:             .Top       = 87
1142:             .Left      = 44
1143:             .Width     = 83
1144:             .Height    = 15
1145:             .AutoSize  = .F.
1146:             .FontName  = "Tahoma"
1147:             .FontSize  = 8
1148:             .FontBold  = .F.
1149:             .FontItalic = .F.
1150:             .BackStyle = 0
1151:             .ForeColor = RGB(90, 90, 90)
1152:             .Caption   = "Movimenta" + CHR(231) + CHR(245) + "es :"
1153:             .Visible   = .T.
1154:         ENDWITH
1155: 
1156:         *-- optProcessados -> obj_4c_OptProcessados (OptionGroup, 2 botoes:
1157:         *-- 1-Nao Processadas, 2-Ja Processadas)
1158:         THIS.AddObject("obj_4c_OptProcessados", "OptionGroup")
1159:         WITH THIS.obj_4c_OptProcessados
1160:             .ButtonCount = 2
1161:             .BackStyle   = 0
1162:             .BorderStyle = 0
1163:             .Top         = 89
1164:             .Left        = 124
1165:             .Width       = 235
1166:             .Height      = 15
1167:             .Value       = 1
1168:             .TabIndex    = 18
1169:             .Visible     = .T.
1170:         ENDWITH
1171: 
1172:         WITH THIS.obj_4c_OptProcessados.Buttons(1)
1173:             .FontName  = "Tahoma"
1174:             .FontSize  = 8
1175:             .BackStyle = 0
1176:             .Caption   = "N" + CHR(227) + "o Processadas"
1177:             .Left      = 5
1178:             .Top       = -1
1179:             .AutoSize  = .T.
1180:             .ForeColor = RGB(90, 90, 90)
1181:         ENDWITH
1182: 
1183:         WITH THIS.obj_4c_OptProcessados.Buttons(2)
1184:             .FontName  = "Tahoma"
1185:             .FontSize  = 8
1186:             .BackStyle = 0
1187:             .Caption   = "J" + CHR(225) + " Processadas"
1188:             .Left      = 126
1189:             .Top       = -1
1190:             .AutoSize  = .T.
1191:             .ForeColor = RGB(90, 90, 90)
1192:         ENDWITH
1193: 
1194:         *-- Say1 -> lbl_4c_Say1 "Periodo de Venda :"
1195:         THIS.AddObject("lbl_4c_Say1", "Label")
1196:         WITH THIS.lbl_4c_Say1
1197:             .Top        = 113
1198:             .Left       = 34

*-- Linhas 1305 a 1355:
1305:     *   btnNomArqs Top=162 Left=621 Width=28  Height=23 Caption="..."
1306:     *              Comic Sans MS 12 bold italic
1307:     *
1308:     * Tambem registra os BINDEVENT dos 3 lookups desta familia de campos
1309:     * (Adquirente - criado na Fase 5 - e Empresa por codigo/por razao
1310:     * social, criados aqui) e do Click de btnNomArqs. KeyPress testa o
1311:     * codigo da tecla ANTES de agir (F4=115 abre o picker; Enter=13/Tab=9
1312:     * valida o valor digitado) - regra "Lookup textbox DEVE disparar em
1313:     * ENTER/TAB alem de F4", NUNCA a cada tecla (regra #47).
1314:     *==========================================================================
1315:     PROTECTED PROCEDURE ConfigurarFiltrosParte2()
1316:         *-- Say4 -> lbl_4c_Say4 "Empresa :"
1317:         THIS.AddObject("lbl_4c_Say4", "Label")
1318:         WITH THIS.lbl_4c_Say4
1319:             .Top        = 139
1320:             .Left       = 77
1321:             .AutoSize   = .T.
1322:             .FontName   = "Tahoma"
1323:             .FontSize   = 8
1324:             .FontItalic = .F.
1325:             .BackStyle  = 0
1326:             .ForeColor  = RGB(90, 90, 90)
1327:             .Caption    = "Empresa :"
1328:             .Visible    = .T.
1329:         ENDWITH
1330: 
1331:         *-- getEmpOs -> txt_4c_EmpOs - codigo da empresa (SigCdEmp.Cemps)
1332:         THIS.AddObject("txt_4c_EmpOs", "TextBox")
1333:         WITH THIS.txt_4c_EmpOs
1334:             .Top           = 135
1335:             .Left          = 129
1336:             .Width         = 31
1337:             .Height        = 23
1338:             .MaxLength     = 3
1339:             .FontName      = "Tahoma"
1340:             .FontSize      = 8
1341:             .SpecialEffect = 1
1342:             .ToolTipText   = "C" + CHR(243) + "digo da Empresa"
1343:             .ForeColor     = RGB(0, 0, 0)
1344:             .Value         = ""
1345:             .Visible       = .T.
1346:         ENDWITH
1347: 
1348:         *-- getDEmpOs -> txt_4c_DEmpOs - razao social (SigCdEmp.Razas).
1349:         *-- ReadOnly dinamico (AtualizarEstadoDEmpOs, chamada no fim deste
1350:         *-- metodo) - simula o When legado: "Return
1351:         *-- Empty(ThisForm.getEmpOs.Value)" (so editavel por nome quando o
1352:         *-- codigo esta vazio).
1353:         THIS.AddObject("txt_4c_DEmpOs", "TextBox")
1354:         WITH THIS.txt_4c_DEmpOs
1355:             .Top           = 135

*-- Linhas 1382 a 1889:
1382: 
1383:         *-- getArqNoms -> obj_4c_GetArqNoms (EditBox) - caminho/nome do
1384:         *-- arquivo de exportacao. O default "C:\CONCILIADOR.CSV" do Init
1385:         *-- legado chega pelo BOParaForm() (chamado no InicializarForm), e
1386:         *-- NAO aqui: a property do BO e a fonte unica do valor.
1387:         *--
1388:         *-- ReadOnly = .T. reproduz o "getArqNoms.When -> Return .f." do
1389:         *-- SCX: no legado o campo NAO aceita digitacao, so o botao "..."
1390:         *-- (Putfile) escreve nele. Atribuicao por codigo continua valendo
1391:         *-- em controle ReadOnly, entao BtnNomArqsClick/BOParaForm seguem
1392:         *-- preenchendo normalmente.
1393:         THIS.AddObject("obj_4c_GetArqNoms", "EditBox")
1394:         WITH THIS.obj_4c_GetArqNoms
1395:             .Top           = 162
1396:             .Left          = 129
1397:             .Width         = 491
1398:             .Height        = 23
1399:             .FontName      = "Tahoma"
1400:             .FontSize      = 8
1401:             .SpecialEffect = 1
1402:             .ScrollBars    = 0
1403:             .ReadOnly      = .T.
1404:             .ToolTipText   = "Nome do Arquivo Texto a Ser Gerado"
1405:             .ForeColor     = RGB(0, 0, 0)
1406:             .Value         = ""
1407:             .Visible       = .T.
1408:         ENDWITH
1409: 
1410:         *-- btnNomArqs -> cmd_4c_BtnNomArqs ("...") - abre o dialogo nativo
1411:         *-- de salvar arquivo (Putfile) e preenche obj_4c_GetArqNoms.
1412:         THIS.AddObject("cmd_4c_BtnNomArqs", "CommandButton")
1413:         WITH THIS.cmd_4c_BtnNomArqs
1414:             .Top         = 162
1415:             .Left        = 621
1416:             .Height      = 23
1417:             .Width       = 28
1418:             .FontBold    = .T.
1419:             .FontItalic  = .T.
1420:             .FontName    = "Comic Sans MS"
1421:             .FontSize    = 12
1422:             .WordWrap    = .T.
1423:             .Caption     = "..."
1424:             .ToolTipText = "Informar o Nome do Arquivo Texto a Ser Gerado"
1425:             .ForeColor   = RGB(90, 90, 90)
1426:             .BackColor   = RGB(255, 255, 255)
1427:             .Themes      = .F.
1428:             .Visible     = .T.
1429:         ENDWITH
1430: 
1431:         *-- BINDEVENT dos lookups (regra #3: handlers tem de ser PUBLIC)
1432:         BINDEVENT(THIS.txt_4c_Adquirs,    "KeyPress", THIS, "AdquirsKeyPress")
1433:         BINDEVENT(THIS.txt_4c_EmpOs,      "KeyPress", THIS, "EmpOsKeyPress")
1434:         BINDEVENT(THIS.txt_4c_DEmpOs,     "KeyPress", THIS, "DEmpOsKeyPress")
1435:         BINDEVENT(THIS.cmd_4c_BtnNomArqs, "Click",    THIS, "BtnNomArqsClick")
1436: 
1437:         *-- Estado inicial do campo de descricao da empresa
1438:         THIS.AtualizarEstadoDEmpOs()
1439:     ENDPROC
1440: 
1441:     *==========================================================================
1442:     * AdquirsKeyPress - getAdquirs.KeyPress (novo - o legado valida no
1443:     * Valid/LostFocus do campo). F4(115) abre o picker direto; Enter(13)/
1444:     * Tab(9) valida o codigo digitado contra SigCdCad - mesmo padrao do
1445:     * getDtIni/getDtFin/getAdquirs do restante do projeto.
1446:     *
1447:     * PUBLIC (regra #3 - alvo de BINDEVENT).
1448:     *==========================================================================
1449:     PROCEDURE AdquirsKeyPress(par_nKeyCode, par_nShiftAltCtrl)
1450:         IF par_nKeyCode = 13 OR par_nKeyCode = 9 OR par_nKeyCode = 115
1451:             THIS.AbrirLookupAdquirente()
1452:         ENDIF
1453:         IF par_nKeyCode = 13 OR par_nKeyCode = 9
1454:             THIS.ValidarAdquirs()
1455:         ENDIF
1456:     ENDPROC
1457: 
1458:     *==========================================================================
1459:     * ValidarAdquirs - getAdquirs.Valid do legado:
1460:     *   If Not Empty(This.Value)
1461:     *       Select crAdquirs / Set Order To Adquirente
1462:     *       If Not Seek(This.Value)
1463:     *           <abre fwBuscaInt>
1464:     *       EndIf
1465:     *       This.Value = crAdquirs.Adquirente
1466:     *   EndIf
1467:     *
1468:     * crAdquirs era pre-carregado no Init legado com "Select codcads as
1469:     * Adquirente, descads As Descr From SigCdCad Where TipoCads =
1470:     * 'ADQUIRENTE'". Aqui o SEEK equivalente vai direto ao SQL Server (sem
1471:     * manter cursor global), e so abre o picker quando o codigo digitado
1472:     * NAO existe - regra #50 (universo vazio nao e erro, nunca apagar o
1473:     * digitado nem avisar antes do picker).
1474:     *==========================================================================
1475:     PROCEDURE ValidarAdquirs()
1476:         LOCAL loc_cValor, loc_cSQL, loc_nResultado
1477:         loc_cValor = ALLTRIM(THIS.txt_4c_Adquirs.Value)
1478: 
1479:         IF EMPTY(loc_cValor)
1480:             RETURN
1481:         ENDIF
1482: 
1483:         loc_cSQL = "SELECT codcads FROM SigCdCad WHERE TipoCads = " + ;
1484:                    EscaparSQL("ADQUIRENTE") + " AND codcads = " + EscaparSQL(loc_cValor)
1485:         loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_AdqVal")
1486: 
1487:         IF loc_nResultado <= 0 OR !USED("cursor_4c_AdqVal") OR EOF("cursor_4c_AdqVal")
1488:             IF USED("cursor_4c_AdqVal")
1489:                 USE IN cursor_4c_AdqVal
1490:             ENDIF
1491:             THIS.AbrirLookupAdquirente()
1492:         ELSE
1493:             USE IN cursor_4c_AdqVal
1494:         ENDIF
1495:     ENDPROC
1496: 
1497:     *==========================================================================
1498:     * AbrirLookupAdquirente - picker de Adquirente (SigCdCad filtrado por
1499:     * TipoCads = 'ADQUIRENTE'), substituicao canonica do fwBuscaInt em
1500:     * crAdquirs do legado - regra #36 (1o argumento e o HANDLE da conexao).
1501:     *
1502:     * PUBLIC (regra #3 - alvo potencial de BINDEVENT/chamada direta).
1503:     *==========================================================================
1504:     PROCEDURE AbrirLookupAdquirente()
1505:         LOCAL loc_oBusca, loc_cValor
1506: 
1507:         loc_cValor = ALLTRIM(THIS.txt_4c_Adquirs.Value)
1508: 
1509:         loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
1510:             "SigCdCad", "cursor_4c_BuscaAdq", "codcads", loc_cValor, ;
1511:             "Sele" + CHR(231) + CHR(227) + "o de Adquirente", .F., .T., ;
1512:             "TipoCads = " + EscaparSQL("ADQUIRENTE"))
1513: 
1514:         IF VARTYPE(loc_oBusca) = "O"
1515:             IF !loc_oBusca.this_lAchouRegistro
1516:                 loc_oBusca.mAddColuna("codcads", "", "C" + CHR(243) + "digo")
1517:                 loc_oBusca.mAddColuna("descads", "", "Adquirente")
1518:                 loc_oBusca.Show()
1519:             ENDIF
1520:             IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaAdq")
1521:                 SELECT cursor_4c_BuscaAdq
1522:                 THIS.txt_4c_Adquirs.Value = ALLTRIM(codcads)
1523:             ENDIF
1524:             loc_oBusca.Release()
1525:         ENDIF
1526: 
1527:         IF USED("cursor_4c_BuscaAdq")
1528:             USE IN cursor_4c_BuscaAdq
1529:         ENDIF
1530:     ENDPROC
1531: 
1532:     *==========================================================================
1533:     * EmpOsKeyPress / DEmpOsKeyPress - getEmpOs/getDEmpOs.KeyPress (novo).
1534:     * F4(115) abre o picker direto; Enter(13)/Tab(9) valida o valor
1535:     * digitado - mesmo padrao de AdquirsKeyPress.
1536:     *
1537:     * PUBLIC (regra #3 - alvo de BINDEVENT).
1538:     *==========================================================================
1539:     PROCEDURE EmpOsKeyPress(par_nKeyCode, par_nShiftAltCtrl)
1540:         IF par_nKeyCode = 13 OR par_nKeyCode = 9 OR par_nKeyCode = 115
1541:             THIS.AbrirLookupEmpOs()
1542:         ENDIF
1543:         IF par_nKeyCode = 13 OR par_nKeyCode = 9
1544:             THIS.ValidarEmpOs()
1545:         ENDIF
1546:     ENDPROC
1547: 
1548:     PROCEDURE DEmpOsKeyPress(par_nKeyCode, par_nShiftAltCtrl)
1549:         IF par_nKeyCode = 13 OR par_nKeyCode = 9 OR par_nKeyCode = 115
1550:             THIS.AbrirLookupDEmpOs()
1551:         ENDIF
1552:         IF par_nKeyCode = 13 OR par_nKeyCode = 9
1553:             THIS.ValidarDEmpOs()
1554:         ENDIF
1555:     ENDPROC
1556: 
1557:     *==========================================================================
1558:     * AtualizarEstadoDEmpOs - simula o getDEmpOs.When do legado:
1559:     *   "Return Empty(ThisForm.getEmpOs.Value)"
1560:     * txt_4c_DEmpOs so e editavel (pesquisa reversa por razao social)
1561:     * quando txt_4c_EmpOs esta vazio - mesmo padrao de
1562:     * Formsigrevto.AtualizarEstadoDesEmpresa.
1563:     *
1564:     * PUBLIC (regra #3 - chamado pelos Validar*/AbrirLookup* de Empresa).
1565:     *==========================================================================
1566:     PROCEDURE AtualizarEstadoDEmpOs()
1567:         THIS.txt_4c_DEmpOs.ReadOnly = !EMPTY(ALLTRIM(THIS.txt_4c_EmpOs.Value))
1568:     ENDPROC
1569: 
1570:     *==========================================================================
1571:     * ValidarEmpOs - getEmpOs.Valid do legado:
1572:     *   =fAcessoEmpresa(Usuar, 'C', This.Value, ThisForm.getEmpOs,
1573:     *                    ThisForm.getDEmpOs, ThisForm.poDataMgr)
1574:     * fAcessoEmpresa NAO foi portada (memoria "fAcessoEmpresa NAO EXISTE") -
1575:     * substituicao canonica: resolve o codigo digitado contra SigCdEmp e
1576:     * preenche a razao social; sem match, abre o picker (regra #50 - sem
1577:     * MsgAviso, sem apagar o codigo digitado).
1578:     *==========================================================================
1579:     PROCEDURE ValidarEmpOs()
1580:         LOCAL loc_cValor, loc_cSQL, loc_nResultado
1581:         loc_cValor = ALLTRIM(THIS.txt_4c_EmpOs.Value)
1582: 
1583:         IF EMPTY(loc_cValor)
1584:             THIS.txt_4c_DEmpOs.Value = ""
1585:             THIS.AtualizarEstadoDEmpOs()
1586:             RETURN
1587:         ENDIF
1588: 
1589:         loc_cSQL = "SELECT Cemps, Razas FROM SigCdEmp WHERE Cemps = " + EscaparSQL(loc_cValor)
1590:         loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_EmpVal")
1591: 
1592:         IF loc_nResultado > 0 AND USED("cursor_4c_EmpVal") AND !EOF("cursor_4c_EmpVal")
1593:             THIS.txt_4c_DEmpOs.Value = ALLTRIM(cursor_4c_EmpVal.Razas)
1594:         ELSE
1595:             THIS.txt_4c_DEmpOs.Value = ""
1596:         ENDIF
1597: 
1598:         IF USED("cursor_4c_EmpVal")
1599:             USE IN cursor_4c_EmpVal
1600:         ENDIF
1601: 
1602:         IF EMPTY(THIS.txt_4c_DEmpOs.Value)
1603:             THIS.AbrirLookupEmpOs()
1604:         ENDIF
1605: 
1606:         THIS.AtualizarEstadoDEmpOs()
1607:     ENDPROC
1608: 
1609:     *==========================================================================
1610:     * AbrirLookupEmpOs - picker de Empresa por codigo (SigCdEmp.Cemps).
1611:     *==========================================================================
1612:     PROCEDURE AbrirLookupEmpOs()
1613:         LOCAL loc_oBusca, loc_cValor
1614:         loc_cValor = ALLTRIM(THIS.txt_4c_EmpOs.Value)
1615: 
1616:         loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
1617:             "SigCdEmp", "cursor_4c_BuscaEmp", "Cemps", loc_cValor, ;
1618:             "Sele" + CHR(231) + CHR(227) + "o de Empresa")
1619: 
1620:         IF VARTYPE(loc_oBusca) = "O"
1621:             IF !loc_oBusca.this_lAchouRegistro
1622:                 loc_oBusca.mAddColuna("Cemps", "", "C" + CHR(243) + "digo")
1623:                 loc_oBusca.mAddColuna("Razas", "", "Raz" + CHR(227) + "o Social")
1624:                 loc_oBusca.Show()
1625:             ENDIF
1626:             IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaEmp")
1627:                 THIS.txt_4c_EmpOs.Value  = ALLTRIM(cursor_4c_BuscaEmp.Cemps)
1628:                 THIS.txt_4c_DEmpOs.Value = ALLTRIM(cursor_4c_BuscaEmp.Razas)
1629:             ENDIF
1630:             loc_oBusca.Release()
1631:         ENDIF
1632: 
1633:         IF USED("cursor_4c_BuscaEmp")
1634:             USE IN cursor_4c_BuscaEmp
1635:         ENDIF
1636: 
1637:         THIS.AtualizarEstadoDEmpOs()
1638:     ENDPROC
1639: 
1640:     *==========================================================================
1641:     * ValidarDEmpOs - getDEmpOs.Valid do legado:
1642:     *   =fAcessoEmpresa(Usuar, 'D', This.Value, ThisForm.getEmpOs,
1643:     *                    ThisForm.getDEmpOs, ThisForm.poDataMgr)
1644:     * So age quando o codigo esta vazio (equivalente ao getDEmpOs.When,
1645:     * que no legado impede ATE de entrar no campo por codigo preenchido -
1646:     * aqui a mesma condicao e checada no Valid, porque ReadOnly dinamico ja
1647:     * bloqueia a digitacao via AtualizarEstadoDEmpOs). Resolve a razao
1648:     * social digitada contra SigCdEmp.Razas (prefixo, LIKE 'valor%').
1649:     *==========================================================================
1650:     PROCEDURE ValidarDEmpOs()
1651:         LOCAL loc_cValor, loc_cSQL, loc_nResultado
1652: 
1653:         IF !EMPTY(ALLTRIM(THIS.txt_4c_EmpOs.Value))
1654:             RETURN
1655:         ENDIF
1656: 
1657:         loc_cValor = ALLTRIM(THIS.txt_4c_DEmpOs.Value)
1658:         IF EMPTY(loc_cValor)
1659:             THIS.txt_4c_EmpOs.Value = ""
1660:             RETURN
1661:         ENDIF
1662: 
1663:         loc_cSQL = "SELECT Cemps, Razas FROM SigCdEmp WHERE Razas LIKE " + ;
1664:                    EscaparSQL(loc_cValor + "%")
1665:         loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_EmpDescVal")
1666: 
1667:         IF loc_nResultado > 0 AND USED("cursor_4c_EmpDescVal") AND !EOF("cursor_4c_EmpDescVal")
1668:             THIS.txt_4c_EmpOs.Value  = ALLTRIM(cursor_4c_EmpDescVal.Cemps)
1669:             THIS.txt_4c_DEmpOs.Value = ALLTRIM(cursor_4c_EmpDescVal.Razas)
1670:             IF USED("cursor_4c_EmpDescVal")
1671:                 USE IN cursor_4c_EmpDescVal
1672:             ENDIF
1673:         ELSE
1674:             IF USED("cursor_4c_EmpDescVal")
1675:                 USE IN cursor_4c_EmpDescVal
1676:             ENDIF
1677:             THIS.AbrirLookupDEmpOs()
1678:         ENDIF
1679:     ENDPROC
1680: 
1681:     *==========================================================================
1682:     * AbrirLookupDEmpOs - picker de Empresa por razao social
1683:     * (SigCdEmp.Razas), mesmo padrao de Formsigrevto.AbrirBuscaDesEmpresa.
1684:     *==========================================================================
1685:     PROCEDURE AbrirLookupDEmpOs()
1686:         LOCAL loc_oBusca, loc_cValor
1687:         loc_cValor = ALLTRIM(THIS.txt_4c_DEmpOs.Value)
1688: 
1689:         loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
1690:             "SigCdEmp", "cursor_4c_BuscaEmpD", "Razas", loc_cValor, ;
1691:             "Sele" + CHR(231) + CHR(227) + "o de Empresa", .F., .T., "")
1692: 
1693:         IF VARTYPE(loc_oBusca) = "O"
1694:             IF loc_oBusca.this_lSelecionou AND loc_oBusca.this_lAchouRegistro
1695:                 THIS.txt_4c_DEmpOs.Value = ALLTRIM(cursor_4c_BuscaEmpD.Razas)
1696:                 THIS.txt_4c_EmpOs.Value  = ALLTRIM(cursor_4c_BuscaEmpD.Cemps)
1697:             ELSE
1698:                 IF !loc_oBusca.this_lAchouRegistro
1699:                     loc_oBusca.mAddColuna("Razas", "", "Raz" + CHR(227) + "o Social")
1700:                     loc_oBusca.mAddColuna("Cemps", "", "C" + CHR(243) + "digo")
1701:                     loc_oBusca.Show()
1702:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaEmpD")
1703:                         THIS.txt_4c_DEmpOs.Value = ALLTRIM(cursor_4c_BuscaEmpD.Razas)
1704:                         THIS.txt_4c_EmpOs.Value  = ALLTRIM(cursor_4c_BuscaEmpD.Cemps)
1705:                     ENDIF
1706:                 ENDIF
1707:             ENDIF
1708:             loc_oBusca.Release()
1709:         ENDIF
1710: 
1711:         IF USED("cursor_4c_BuscaEmpD")
1712:             USE IN cursor_4c_BuscaEmpD
1713:         ENDIF
1714: 
1715:         THIS.AtualizarEstadoDEmpOs()
1716:     ENDPROC
1717: 
1718:     *==========================================================================
1719:     * BtnNomArqsClick - btnNomArqs.Valid do legado:
1720:     *   lcArq = Putfile([Nome do Arquivo], [C:\CONCILIADOR.CSV], [CSV])
1721:     *   ThisForm.getArqNoms.Value = lcArq
1722:     * PUTFILE() devolve string vazia quando o usuario cancela o dialogo -
1723:     * nesse caso o campo permanece com o valor anterior (igual ao legado,
1724:     * que so atribui quando lcArq retorna preenchido - PUTFILE sem
1725:     * confirmacao devolve "").
1726:     *
1727:     * PUBLIC (regra #3 - alvo de BINDEVENT).
1728:     *==========================================================================
1729:     PROCEDURE BtnNomArqsClick()
1730:         LOCAL loc_cArquivo
1731:         loc_cArquivo = PUTFILE("Nome do Arquivo", "C:\CONCILIADOR.CSV", "CSV")
1732: 
1733:         IF !EMPTY(loc_cArquivo)
1734:             THIS.obj_4c_GetArqNoms.Value = loc_cArquivo
1735:         ENDIF
1736:     ENDPROC
1737: 
1738:     *==========================================================================
1739:     * HabilitarFiltros - habilita/desabilita os 9 controles de filtro
1740:     * (periodo/processados/empresa/arquivo), equivalente ao bloco
1741:     * "With ThisForm / .getDtIni.Enabled = ... / EndWith" repetido no
1742:     * Init/Selecionar/LimpaSelecao do legado. getAdquirs NAO entra (o
1743:     * legado nunca alterna o Enabled dele em lugar nenhum).
1744:     *==========================================================================
1745:     PROTECTED PROCEDURE HabilitarFiltros(par_lHabilitar)
1746:         THIS.txt_4c_DtIni.Enabled                    = par_lHabilitar
1747:         THIS.txt_4c_DtFin.Enabled                    = par_lHabilitar
1748:         THIS.cmd_4c_CmdSelecionar.Enabled             = par_lHabilitar
1749:         THIS.obj_4c_OptProcessados.Buttons(1).Enabled = par_lHabilitar
1750:         THIS.obj_4c_OptProcessados.Buttons(2).Enabled = par_lHabilitar
1751:         THIS.obj_4c_GetArqNoms.Enabled                = par_lHabilitar
1752:         THIS.cmd_4c_BtnNomArqs.Enabled                 = par_lHabilitar
1753:         THIS.txt_4c_EmpOs.Enabled                      = par_lHabilitar
1754:         THIS.txt_4c_DEmpOs.Enabled                     = par_lHabilitar
1755:     ENDPROC
1756: 
1757:     *==========================================================================
1758:     * HabilitarAcoesProcessamento - habilita/desabilita os 2 botoes de
1759:     * cmg_4c_CmdBtnForm (Limpar/Gera Arquivo) e os 3 de cmg_4c_CmdBtnGrade
1760:     * (Marca Tudo/Desmarcar/Documentos) - equivalente aos blocos "With
1761:     * ThisForm.cmdBtnForm"/"With ThisForm.cmdBtnGrade" do Init/Selecionar/
1762:     * LimpaSelecao do legado. O 3o botao de cmg_4c_CmdBtnForm (Encerrar)
1763:     * NAO entra - o legado nunca o desabilita.
1764:     *==========================================================================
1765:     PROTECTED PROCEDURE HabilitarAcoesProcessamento(par_lHabilitar)
1766:         THIS.cmg_4c_CmdBtnForm.Buttons(1).Enabled  = par_lHabilitar
1767:         THIS.cmg_4c_CmdBtnForm.Buttons(2).Enabled  = par_lHabilitar
1768:         THIS.cmg_4c_CmdBtnGrade.Buttons(1).Enabled = par_lHabilitar
1769:         THIS.cmg_4c_CmdBtnGrade.Buttons(2).Enabled = par_lHabilitar
1770:         THIS.cmg_4c_CmdBtnGrade.Buttons(3).Enabled = par_lHabilitar
1771:     ENDPROC
1772: 
1773:     *==========================================================================
1774:     * CmdSelecionarClick - cmdSelecionar.Valid do legado (CommandButton
1775:     * standalone nao dispara Valid em VFP9 - mapeado para Click).
1776:     *==========================================================================
1777:     PROCEDURE CmdSelecionarClick()
1778:         THIS.Selecionar()
1779:     ENDPROC
1780: 
1781:     *==========================================================================
1782:     * Selecionar - PROCEDURE selecionar do legado: valida Data Inicial/
1783:     * Final/pasta do arquivo de exportacao, monta e executa o JOIN
1784:     * SigOpFp+SigCdCli+SigMvPar+SigCdOpe (filtrado por empresa/adquirente/
1785:     * periodo/situacao de processamento ja gravada em SigPcOoL), e povoa
1786:     * cursor_4c_Operacoes linha a linha com os campos derivados.
1787:     *
1788:     * RETURN so FORA do TRY (regra #1) - loc_lValido encadeia os 4 guards
1789:     * de validacao do legado (cada MessageBox + SetFocus + Return .f.).
1790:     *
1791:     * PUBLIC (regra #3): alvo de BINDEVENT (CmdSelecionarClick) e mesmo
1792:     * nome do PROCEDURE legado (harness pode chamar direto).
1793:     *==========================================================================
1794:     PROCEDURE Selecionar()
1795:         LOCAL loc_cEmp, loc_lNaoProcessados, loc_dDtIni, loc_dDtFin, ;
1796:               loc_cArquivo, loc_cAdquirente, loc_dDtFinHora, loc_cSQL, ;
1797:               loc_nResultado, loc_lValido, loc_lErros, loc_cBandeira, ;
1798:               loc_cOrigem, loc_lSucesso, loc_oErro
1799:         loc_lSucesso = .F.
1800: 
1801:         TRY
1802:             IF USED("cursor_4c_Operacoes")
1803:                 ZAP IN cursor_4c_Operacoes
1804:             ENDIF
1805: 
1806:             *-- FONTE UNICA dos filtros: FormParaBO() transfere os 6
1807:             *-- controles de filtro para as properties do BO aplicando a
1808:             *-- MESMA normalizacao do legado (Padr(getEmpOs.Value, 3),
1809:             *-- Alltrim nos demais), e a partir daqui o metodo le do BO.
1810:             *-- Antes, Selecionar e Processamento liam os controles cada um
1811:             *-- por conta propria - duas copias da mesma leitura, livres
1812:             *-- para divergir no primeiro filtro novo.
1813:             loc_lValido = THIS.FormParaBO()
1814: 
1815:             IF loc_lValido
1816:                 WITH THIS.this_oBusinessObject
1817:                     loc_cEmp            = PADR(.this_cEmps, 3)
1818:                     loc_lNaoProcessados = (.this_nProcessados = 1)
1819:                     loc_dDtIni          = .this_dDataIni
1820:                     loc_dDtFin          = .this_dDataFin
1821:                     loc_cArquivo        = ALLTRIM(.this_cArquivo)
1822:                     loc_cAdquirente     = ALLTRIM(.this_cAdquirente)
1823:                 ENDWITH
1824:             ENDIF
1825: 
1826:             IF loc_lValido AND EMPTY(loc_dDtIni)
1827:                 MsgAviso("A Data Inicial N" + CHR(227) + "o Pode Ficar em Branco!!!", ;
1828:                     "Aten" + CHR(231) + CHR(227) + "o!!!")
1829:                 THIS.txt_4c_DtIni.SetFocus()
1830:                 loc_lValido = .F.
1831:             ENDIF
1832: 
1833:             IF loc_lValido AND EMPTY(loc_dDtFin)
1834:                 MsgAviso("A Data Final N" + CHR(227) + "o Pode Ficar em Branco!!!", ;
1835:                     "Aten" + CHR(231) + CHR(227) + "o!!!")
1836:                 THIS.txt_4c_DtFin.SetFocus()
1837:                 loc_lValido = .F.
1838:             ENDIF
1839: 
1840:             IF loc_lValido AND loc_dDtIni > loc_dDtFin
1841:                 MsgAviso("A Data Inicial N" + CHR(227) + "o Pode Ser Maior do Que a Data Final!!!", ;
1842:                     "Aten" + CHR(231) + CHR(227) + "o!!!")
1843:                 THIS.txt_4c_DtIni.SetFocus()
1844:                 loc_lValido = .F.
1845:             ENDIF
1846: 
1847:             IF loc_lValido AND (EMPTY(loc_cArquivo) OR EMPTY(JUSTPATH(loc_cArquivo)) ;
1848:                     OR !DIRECTORY(JUSTPATH(loc_cArquivo)))
1849:                 MsgAviso("O Arquivo a Ser Gerado Precisa Ser Informado!!!", ;
1850:                     "Aten" + CHR(231) + CHR(227) + "o!!!")
1851:                 THIS.cmd_4c_BtnNomArqs.SetFocus()
1852:                 loc_lValido = .F.
1853:             ENDIF
1854: 
1855:             IF loc_lValido
1856:                 loc_dDtFinHora = DATETIME(YEAR(loc_dDtFin), MONTH(loc_dDtFin), DAY(loc_dDtFin), 23, 59, 59)
1857: 
1858:                 loc_cSQL = "SELECT 'A02' AS TIPO_REGISTRO, p.Adquirente AS ADQUIRENTE," + ;
1859:                     " p.Emps AS LOJA_FILIAL, f.Bandeira AS BANDEIRA1, d.RClis AS BANDEIRA2," + ;
1860:                     " f.Opers AS TIPO_TRANSACAO, p.Parcs AS NRO_PARCELA, p.TParcs AS QTD_PARCELAS," + ;
1861:                     " SPACE(40) AS TID, p.NSU AS NSU, p.Autoriza AS AUTORIZACAO, p.Valos AS VALOR," + ;
1862:                     " SPACE(50) AS CLIENTE, p.Datas AS DATA_VENDA, f.CCupomNvs AS ORIGEM," + ;
1863:                     " '' AS SEQUENCIA, '' AS NOTA_FISCAL, '' AS CPF_CNPJ, f.CodEstabs AS ESTABELECIMENTO," + ;
1864:                     " p.Vencs AS DATA_VENCIMENTO, '' AS NUMERO_CARTAO," + ;
1865:                     " p.EmpDopNums + p.FPags + STR(p.Nopers, 10) AS REFERENCIA1," + ;
1866:                     " p.Emps, p.Dopes, p.Numes, p.EmpDopNums" + ;
1867:                     " FROM SigOpFP f, SigCdCli d, SigMvPar p, SigCdOpe o" + ;
1868:                     " WHERE f.Infos = 'T'" + ;
1869:                     "   AND f.ContaDs = d.IClis" + ;
1870:                     "   AND p.FPags = f.FPags" + ;
1871:                     IIF(EMPTY(loc_cEmp), "", "   AND p.Emps = " + EscaparSQL(loc_cEmp)) + ;
1872:                     IIF(EMPTY(loc_cAdquirente), "", "   AND p.Adquirente = " + EscaparSQL(loc_cAdquirente)) + ;
1873:                     "   AND p.Datas BETWEEN " + FormatarDataSQL(loc_dDtIni) + " AND " + FormatarDataSQL(loc_dDtFinHora) + ;
1874:                     "   AND p.Dopes = o.Dopes" + ;
1875:                     "   AND NOT o.Vendas = 2" + ;
1876:                     "   AND p.Vencs IS NOT NULL" + ;
1877:                     "   AND p.EmpDopNums " + IIF(loc_lNaoProcessados, "NOT ", "") + ;
1878:                     "   IN (SELECT DISTINCT b.EmpDopNums FROM SigPcOoL b WHERE b.Tipos = " + EscaparSQL("SIGOPVDA") + ")" + ;
1879:                     " ORDER BY p.Datas, p.EmpDopNums, p.FPags, p.Parcs"
1880: 
1881:                 IF USED("cursor_4c_Selecao")
1882:                     USE IN cursor_4c_Selecao
1883:                 ENDIF
1884: 
1885:                 loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Selecao")
1886: 
1887:                 IF loc_nResultado < 0 OR !USED("cursor_4c_Selecao")
1888:                     MsgErro("Erro ao consultar as opera" + CHR(231) + CHR(245) + "es:" + CHR(13) + ;
1889:                         CapturarErroSQL(), "Erro SQL")

*-- Linhas 1957 a 2056:
1957:             THIS.this_cMensagemErro = loc_oErro.Message
1958:             MsgErro(loc_oErro.Message + CHR(13) + ;
1959:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1960:                 "Procedure: " + loc_oErro.Procedure, ;
1961:                 "Erro Selecionar")
1962:         ENDTRY
1963: 
1964:         RETURN loc_lSucesso
1965:     ENDPROC
1966: 
1967:     *==========================================================================
1968:     * LimpaSelecao - PROCEDURE limpaselecao do legado: esvazia
1969:     * cursor_4c_Operacoes e devolve filtros/botoes ao estado inicial.
1970:     *
1971:     * PUBLIC (regra #3): chamado por Selecionar/Processamento e mesmo nome
1972:     * do PROCEDURE legado.
1973:     *==========================================================================
1974:     PROCEDURE LimpaSelecao()
1975:         LOCAL loc_lSucesso, loc_oErro
1976:         loc_lSucesso = .F.
1977: 
1978:         TRY
1979:             IF USED("cursor_4c_Operacoes")
1980:                 ZAP IN cursor_4c_Operacoes
1981:             ENDIF
1982: 
1983:             THIS.HabilitarFiltros(.T.)
1984:             THIS.HabilitarAcoesProcessamento(.F.)
1985: 
1986:             THIS.CarregarDados()
1987:             THIS.Refresh()
1988: 
1989:             loc_lSucesso = .T.
1990: 
1991:         CATCH TO loc_oErro
1992:             THIS.this_cMensagemErro = loc_oErro.Message
1993:             MsgErro(loc_oErro.Message + CHR(13) + ;
1994:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1995:                 "Procedure: " + loc_oErro.Procedure, ;
1996:                 "Erro LimpaSelecao")
1997:         ENDTRY
1998: 
1999:         RETURN loc_lSucesso
2000:     ENDPROC
2001: 
2002:     *==========================================================================
2003:     * Processamento - PROCEDURE processamento do legado: grava o header
2004:     * 'A01' (nomes das colunas) + uma linha 'A02' por operacao SelImp no
2005:     * cursor de exportacao, COPY TO DELIMITED, e insere o controle em
2006:     * SigPcOoL (um INSERT por linha, tudo num UNICO SQLEXEC - BEGIN/COMMIT
2007:     * via SQLEXEC separado NAO protege, a conexao ja nasce com @@TRANCOUNT
2008:     * = 1 - regra "BEGIN/COMMIT via SQLEXEC nao protege").
2009:     *
2010:     * Nao apaga o arquivo se o lote SQL falhar (igual ao legado: o arquivo
2011:     * ja foi gravado em disco ANTES da tentativa de commit).
2012:     *
2013:     * PUBLIC (regra #3): chamado por CmgCmdBtnFormClick e mesmo nome do
2014:     * PROCEDURE legado.
2015:     *==========================================================================
2016:     PROCEDURE Processamento()
2017:         LOCAL loc_lNaoProcessados, loc_cArquivo, loc_nOrdem, loc_lOk, ;
2018:               loc_cInserts, loc_cSQLLote, loc_cProdutosFlag, loc_nResultado, ;
2019:               loc_lFiltrosOk, loc_oErro
2020:         loc_lOk = .F.
2021: 
2022:         TRY
2023:             *-- FONTE UNICA dos filtros, igual a Selecionar: FormParaBO()
2024:             *-- recarrega as properties do BO a partir dos controles (o
2025:             *-- legado tambem relia optProcessados/getArqNoms aqui) e
2026:             *-- Processamento le do BO, nunca mais do controle.
2027:             loc_lFiltrosOk      = THIS.FormParaBO()
2028:             loc_lNaoProcessados = .T.
2029:             loc_cArquivo        = ""
2030: 
2031:             IF loc_lFiltrosOk
2032:                 WITH THIS.this_oBusinessObject
2033:                     loc_lNaoProcessados = (.this_nProcessados = 1)
2034:                     loc_cArquivo        = ALLTRIM(.this_cArquivo)
2035:                 ENDWITH
2036:             ENDIF
2037: 
2038:             loc_cProdutosFlag = IIF(loc_lNaoProcessados, "", "J" + CHR(193) + " PROCESSADOS")
2039: 
2040:             *-- RETURN so FORA do TRY (regra #1): o corpo inteiro fica sob a
2041:             *-- flag, em vez de abandonar o bloco no meio.
2042:             IF !loc_lFiltrosOk
2043:                 MsgErro("N" + CHR(227) + "o foi poss" + CHR(237) + "vel ler os filtros da tela." + ;
2044:                     CHR(13) + "Nenhum arquivo foi gerado.", "Aten" + CHR(231) + CHR(227) + "o!!!")
2045:             ELSE
2046:                 IF USED("cursor_4c_Excel")
2047:                     USE IN cursor_4c_Excel
2048:                 ENDIF
2049: 
2050:                 SET NULL ON
2051:                 CREATE CURSOR cursor_4c_Excel (TIPO_REGISTRO C(3), ADQUIRENTE C(60), ;
2052:                     LOJA_FILIAL C(15), BANDEIRA C(60), TIPO_TRANSACAO C(15), ;
2053:                     NRO_PARCELA C(2), QTD_PARCELAS C(2), TID C(40), NSU C(30), ;
2054:                     AUTORIZACAO C(20), VALOR C(14), CLIENTE C(50), DATA_VENDA C(10), ;
2055:                     ORIGEM C(10), SEQUENCIA C(20), NOTA_FISCAL C(20), CPF_CNPJ C(20), ;
2056:                     ESTABELECIMENTO C(20), DATA_VENCIMENTO C(10), NUMERO_CARTAO C(30), ;

*-- Linhas 2163 a 2475:
2163:             THIS.this_cMensagemErro = loc_oErro.Message
2164:             MsgErro(loc_oErro.Message + CHR(13) + ;
2165:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
2166:                 "Procedure: " + loc_oErro.Procedure, ;
2167:                 "Erro Processamento")
2168:         ENDTRY
2169: 
2170:         RETURN loc_lOk
2171:     ENDPROC
2172: 
2173:     *==========================================================================
2174:     * CmgCmdBtnGradeClick - cmdBtnGrade.Click do legado (Marca Tudo/
2175:     * Desmarcar/Documentos da linha corrente).
2176:     *==========================================================================
2177:     PROCEDURE CmgCmdBtnGradeClick()
2178:         LOCAL loc_oGrp
2179:         loc_oGrp = THIS.cmg_4c_CmdBtnGrade
2180: 
2181:         DO CASE
2182:         CASE loc_oGrp.Value = 1 AND loc_oGrp.Buttons(1).Enabled
2183:             *-- Marca Tudo
2184:             IF USED("cursor_4c_Operacoes")
2185:                 SELECT cursor_4c_Operacoes
2186:                 REPLACE ALL SelImp WITH .T. FOR !Erros
2187:                 GO TOP
2188:                 THIS.cnt_4c_Grade.grd_4c_Dados.Refresh()
2189:             ENDIF
2190: 
2191:         CASE loc_oGrp.Value = 2 AND loc_oGrp.Buttons(2).Enabled
2192:             *-- Desmarcar
2193:             IF USED("cursor_4c_Operacoes")
2194:                 SELECT cursor_4c_Operacoes
2195:                 REPLACE ALL SelImp WITH .F.
2196:                 GO TOP
2197:                 THIS.cnt_4c_Grade.grd_4c_Dados.Refresh()
2198:             ENDIF
2199: 
2200:         CASE loc_oGrp.Value = 3 AND loc_oGrp.Buttons(3).Enabled
2201:             *-- Documentos (legado: Do Form SigMvExp)
2202:             THIS.AbrirDocumentoOperacao()
2203:         ENDCASE
2204:     ENDPROC
2205: 
2206:     *==========================================================================
2207:     * AbrirDocumentoOperacao - cmdBtnGrade "Documentos" do legado:
2208:     *   Do Form SigMvExp With csOperacoes.Dopes, 'C', csOperacoes.Numes,
2209:     *                          csOperacoes.Emps, .t.
2210:     * -> CREATEOBJECT("FormSigMvExp", par_cDopes, par_cTipos, par_nNumes,
2211:     *                  par_cEmps, par_lConsulta, par_nCaixa, par_lMacro)
2212:     *==========================================================================
2213:     PROCEDURE AbrirDocumentoOperacao()
2214:         LOCAL loc_oForm
2215: 
2216:         IF !USED("cursor_4c_Operacoes") OR EOF("cursor_4c_Operacoes")
2217:             RETURN
2218:         ENDIF
2219: 
2220:         loc_oForm = CREATEOBJECT("FormSigMvExp", ALLTRIM(cursor_4c_Operacoes.Dopes), ;
2221:             "C", cursor_4c_Operacoes.Numes, cursor_4c_Operacoes.Emps, .T.)
2222: 
2223:         IF VARTYPE(loc_oForm) = "O"
2224:             loc_oForm.Show()
2225:         ENDIF
2226:     ENDPROC
2227: 
2228:     *==========================================================================
2229:     * CmgCmdBtnFormClick - cmdBtnForm.Click do legado (Limpar Selecao/Gera
2230:     * Arquivo/Encerrar). O guard de "nenhum lancamento selecionado" (Select
2231:     * ... Count(1) ... Group By SelImp) roda ANTES do Do Case, so quando o
2232:     * botao clicado e o 2o (Gera Arquivo) - igual ao legado.
2233:     *==========================================================================
2234:     PROCEDURE CmgCmdBtnFormClick()
2235:         LOCAL loc_oGrp, loc_nSelecionados
2236: 
2237:         loc_oGrp = THIS.cmg_4c_CmdBtnForm
2238: 
2239:         IF loc_oGrp.Value = 2
2240:             loc_nSelecionados = 0
2241: 
2242:             IF USED("cursor_4c_Operacoes")
2243:                 IF USED("cursor_4c_ContaSel")
2244:                     USE IN cursor_4c_ContaSel
2245:                 ENDIF
2246:                 SELECT COUNT(*) AS Selecionados FROM cursor_4c_Operacoes ;
2247:                     WHERE SelImp INTO CURSOR cursor_4c_ContaSel
2248:                 IF USED("cursor_4c_ContaSel")
2249:                     loc_nSelecionados = cursor_4c_ContaSel.Selecionados
2250:                     USE IN cursor_4c_ContaSel
2251:                 ENDIF
2252:             ENDIF
2253: 
2254:             IF loc_nSelecionados < 1
2255:                 MsgAviso("Nenhum Lan" + CHR(231) + "amento Foi Selecionado!!!", "Processamento")
2256:                 THIS.txt_4c_DtIni.SetFocus()
2257:                 RETURN
2258:             ENDIF
2259:         ENDIF
2260: 
2261:         DO CASE
2262:         CASE loc_oGrp.Value = 1 AND loc_oGrp.Buttons(1).Enabled
2263:             *-- Limpar Selecao
2264:             THIS.LimpaSelecao()
2265: 
2266:         CASE loc_oGrp.Value = 2 AND loc_oGrp.Buttons(2).Enabled
2267:             *-- Gera Arquivo
2268:             THIS.Processamento()
2269: 
2270:         CASE loc_oGrp.Value = 3
2271:             *-- Encerrar ([ESC] Sair)
2272:             THIS.Release()
2273:         ENDCASE
2274:     ENDPROC
2275: 
2276:     *==========================================================================
2277:     * Check1ToggleSelImp - fonte unica do toggle de SelImp na celula
2278:     * corrente da grade (regra do Problema 48/#21: popular cursor NAO
2279:     * repinta a grade - o Refresh e obrigatorio).
2280:     *==========================================================================
2281:     PROCEDURE Check1ToggleSelImp()
2282:         IF USED("cursor_4c_Operacoes") AND !EOF("cursor_4c_Operacoes")
2283:             REPLACE cursor_4c_Operacoes.SelImp WITH !cursor_4c_Operacoes.SelImp
2284:             THIS.cnt_4c_Grade.grd_4c_Dados.Refresh()
2285:         ENDIF
2286:     ENDPROC
2287: 
2288:     *==========================================================================
2289:     * Check1KeyPress/MouseUp/MouseDown/Click - Column1.Check1 do legado,
2290:     * TRANSCRITO LITERAL: o toggle mora no MouseDown (Gather Memvar +
2291:     * Refresh + NoDefault); MouseUp e Click so suprimem o default; KeyPress
2292:     * toggla em Enter(13)/Espaco(32). PUBLIC (regra #3 - alvo de BINDEVENT).
2293:     *==========================================================================
2294:     PROCEDURE Check1KeyPress(par_nKeyCode, par_nShiftAltCtrl)
2295:         IF INLIST(par_nKeyCode, 13, 32)
2296:             THIS.Check1ToggleSelImp()
2297:             NODEFAULT
2298:         ENDIF
2299:     ENDPROC
2300: 
2301:     PROCEDURE Check1MouseUp(par_nButton, par_nShift, par_nXCoord, par_nYCoord)
2302:         NODEFAULT
2303:     ENDPROC
2304: 
2305:     PROCEDURE Check1MouseDown(par_nButton, par_nShift, par_nXCoord, par_nYCoord)
2306:         THIS.Check1ToggleSelImp()
2307:         NODEFAULT
2308:     ENDPROC
2309: 
2310:     PROCEDURE Check1Click()
2311:         NODEFAULT
2312:     ENDPROC
2313: 
2314:     *==========================================================================
2315:     * BOParaForm - leva os filtros de selecao guardados no BO para os
2316:     * controles da tela. E o bloco de defaults do Init legado, que nao tem
2317:     * esse nome la mas existe literalmente:
2318:     *
2319:     *   .getDtIni.Value   = Date()
2320:     *   .getDtFin.Value   = Date()
2321:     *   .getArqNoms.Value = [C:\CONCILIADOR.CSV]
2322:     *
2323:     * Os valores moram em SigOpVdaBO.AplicarFiltrosPadrao() - aqui so se
2324:     * espelha a property no controle, para haver UM lugar que decide o
2325:     * default e UM lugar que o escreve na tela.
2326:     *
2327:     * PROTECTED obrigatoriamente: FormBase declara BOParaForm como
2328:     * PROTECTED e VFP9 nao permite ALARGAR o escopo de metodo herdado.
2329:     *
2330:     * Nao estoura com o BO ausente nem antes dos controles existirem: os
2331:     * dois guards checam, resultado por flag e RETURN unico depois do
2332:     * ENDTRY (regra #1).
2333:     *==========================================================================
2334:     PROTECTED PROCEDURE BOParaForm()
2335:         LOCAL loc_lSucesso, loc_oErro
2336:         loc_lSucesso = .F.
2337: 
2338:         IF VARTYPE(THIS.this_oBusinessObject) != "O"
2339:             RETURN loc_lSucesso
2340:         ENDIF
2341: 
2342:         IF !PEMSTATUS(THIS, "txt_4c_DtIni", 5)
2343:             RETURN loc_lSucesso
2344:         ENDIF
2345: 
2346:         TRY
2347:             WITH THIS.this_oBusinessObject
2348:                 THIS.txt_4c_DtIni.Value  = ConverterParaData(.this_dDataIni)
2349:                 THIS.txt_4c_DtFin.Value  = ConverterParaData(.this_dDataFin)
2350:                 THIS.txt_4c_EmpOs.Value  = ALLTRIM(.this_cEmps)
2351:                 THIS.txt_4c_DEmpOs.Value = ALLTRIM(.this_cDescEmps)
2352:                 THIS.txt_4c_Adquirs.Value = ALLTRIM(.this_cAdquirente)
2353:                 THIS.obj_4c_GetArqNoms.Value = ALLTRIM(.this_cArquivo)
2354: 
2355:                 *-- OptionGroup e 1-based (1-Nao Processadas / 2-Ja
2356:                 *-- Processadas): nunca atribuir 0 a um controle 1-based.
2357:                 THIS.obj_4c_OptProcessados.Value = ;
2358:                     IIF(BETWEEN(.this_nProcessados, 1, 2), .this_nProcessados, 1)
2359:             ENDWITH
2360: 
2361:             *-- getDEmpOs.When do legado depende do getEmpOs recem-escrito.
2362:             THIS.AtualizarEstadoDEmpOs()
2363: 
2364:             loc_lSucesso = .T.
2365: 
2366:         CATCH TO loc_oErro
2367:             THIS.this_cMensagemErro = loc_oErro.Message
2368:             MsgErro(loc_oErro.Message + CHR(13) + ;
2369:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
2370:                 "Procedure: " + loc_oErro.Procedure, ;
2371:                 "Erro BOParaForm")
2372:         ENDTRY
2373: 
2374:         RETURN loc_lSucesso
2375:     ENDPROC
2376: 
2377:     *==========================================================================
2378:     * FormParaBO - inverso de BOParaForm: le os 6 controles de filtro e
2379:     * grava nas properties do BO, aplicando a MESMA normalizacao do legado
2380:     * (selecionar: "lcEmp = Padr(ThisForm.getEmpOs.Value, 3)", Alltrim nos
2381:     * demais). Depois disto Selecionar() e Processamento() leem SO do BO.
2382:     *
2383:     * Campo em BRANCO SOBRESCREVE a property de proposito - aqui vazio e um
2384:     * valor com significado, nao "nao informado": empresa vazia significa
2385:     * TODAS as empresas e adquirente vazio significa TODOS os adquirentes
2386:     * (o IIF(EMPTY(...)) de Selecionar simplesmente omite a clausula do
2387:     * WHERE). Por isso NAO se aplica o guard "branco nao sobrescreve" usado
2388:     * em tela de configuracao resolvida.
2389:     *
2390:     * As validacoes do legado (data em branco, inicial > final, pasta do
2391:     * arquivo inexistente) continuam em Selecionar(), que e onde o SCX as
2392:     * tem - este metodo so transfere.
2393:     *
2394:     * PROTECTED obrigatoriamente (FormBase declara FormParaBO PROTECTED e
2395:     * VFP9 nao permite alargar escopo de metodo herdado).
2396:     *==========================================================================
2397:     PROTECTED PROCEDURE FormParaBO()
2398:         LOCAL loc_lSucesso, loc_oErro
2399:         loc_lSucesso = .F.
2400: 
2401:         IF VARTYPE(THIS.this_oBusinessObject) != "O"
2402:             RETURN loc_lSucesso
2403:         ENDIF
2404: 
2405:         TRY
2406:             WITH THIS.this_oBusinessObject
2407:                 *-- Padr(...,3) e o do legado: SigCdEmp.Cemps e char(3) e a
2408:                 *-- comparacao em SigMvPar.Emps tambem (chave POSICIONAL -
2409:                 *-- regra #42). EMPTY("   ") continua .T., entao o filtro
2410:                 *-- vazio segue significando "todas as empresas".
2411:                 .this_cEmps       = PADR(ALLTRIM(THIS.txt_4c_EmpOs.Value), 3)
2412:                 .this_cDescEmps   = ALLTRIM(THIS.txt_4c_DEmpOs.Value)
2413:                 .this_dDataIni    = ConverterParaData(THIS.txt_4c_DtIni.Value)
2414:                 .this_dDataFin    = ConverterParaData(THIS.txt_4c_DtFin.Value)
2415:                 .this_nProcessados = THIS.obj_4c_OptProcessados.Value
2416:                 .this_cArquivo    = ALLTRIM(THIS.obj_4c_GetArqNoms.Value)
2417:                 .this_cAdquirente = ALLTRIM(THIS.txt_4c_Adquirs.Value)
2418:             ENDWITH
2419: 
2420:             loc_lSucesso = .T.
2421: 
2422:         CATCH TO loc_oErro
2423:             THIS.this_cMensagemErro = loc_oErro.Message
2424:             MsgErro(loc_oErro.Message + CHR(13) + ;
2425:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
2426:                 "Procedure: " + loc_oErro.Procedure, ;
2427:                 "Erro FormParaBO")
2428:         ENDTRY
2429: 
2430:         RETURN loc_lSucesso
2431:     ENDPROC
2432: 
2433:     *==========================================================================
2434:     * TornarControlesVisiveis - Torna visiveis os controles ja criados nesta
2435:     * fase (AddObject nasce Visible=.F.). Varre recursivamente para que as
2436:     * fases seguintes (grade dentro de cnt_4c_Grade, CommandGroups de botoes)
2437:     * fiquem automaticamente cobertas sem precisar reescrever este metodo.
2438:     *==========================================================================
2439:     PROTECTED PROCEDURE TornarControlesVisiveis()
2440:         LOCAL loc_nI
2441: 
2442:         FOR loc_nI = 1 TO THIS.ControlCount
2443:             THIS.TornarVisivelRecursivo(THIS.Controls(loc_nI))
2444:         ENDFOR
2445:     ENDPROC
2446: 
2447:     *==========================================================================
2448:     * TornarVisivelRecursivo - torna par_oObjeto e seus filhos (Controls e,
2449:     * se for PageFrame, Pages) visiveis, recursivamente.
2450:     *==========================================================================
2451:     PROTECTED PROCEDURE TornarVisivelRecursivo(par_oObjeto)
2452:         LOCAL loc_nI
2453: 
2454:         IF VARTYPE(par_oObjeto) != "O"
2455:             RETURN
2456:         ENDIF
2457: 
2458:         IF PEMSTATUS(par_oObjeto, "Visible", 5)
2459:             par_oObjeto.Visible = .T.
2460:         ENDIF
2461: 
2462:         IF PEMSTATUS(par_oObjeto, "PageCount", 5)
2463:             FOR loc_nI = 1 TO par_oObjeto.PageCount
2464:                 THIS.TornarVisivelRecursivo(par_oObjeto.Pages(loc_nI))
2465:             ENDFOR
2466:         ENDIF
2467: 
2468:         IF PEMSTATUS(par_oObjeto, "ControlCount", 5)
2469:             FOR loc_nI = 1 TO par_oObjeto.ControlCount
2470:                 THIS.TornarVisivelRecursivo(par_oObjeto.Controls(loc_nI))
2471:             ENDFOR
2472:         ENDIF
2473:     ENDPROC
2474: 
2475: ENDDEFINE


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


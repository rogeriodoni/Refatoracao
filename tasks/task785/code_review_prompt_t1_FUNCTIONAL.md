# CODE REVIEW - PASS FUNCTIONAL: Functional Logic (metodos, eventos, containers)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Functional Logic (metodos, eventos, containers)**.

## PROBLEMAS DETECTADOS (2)
- [LOSTFOCUS-SEM-GUARDIA] Handler 'ValidarCodTamsLostFocus' (via BINDEVENT LostFocus) abre janela de busca mas NAO verifica se o valor mudou. No legado, Valid so dispara quando o valor MUDA, mas LostFocus dispara SEMPRE. CORRIGIR: Adicionar propriedade this_cUltimoValidarCodTamsLostFocusValidado e comparar no inicio do handler: IF loc_cValor == THIS.this_cUltimo... THEN RETURN. Atualizar apos validacao bem-sucedida.
- [NULL-CURSOR] CREATE CURSOR 'cursor_4c_Dados' sem SET NULL ON antes. SQL Server retorna NULLs em muitos campos. Sem SET NULL ON, APPEND FROM falha com 'Field XXX does not accept null values'. Adicionar SET NULL ON antes e SET NULL OFF depois.

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

### FORM (C:\4c\projeto\app\forms\operacionais\FormSIGOPPEN.prg) - TRECHOS RELEVANTES PARA PASS FUNCTIONAL (1409 linhas total):

*-- Linhas 68 a 195:
68:     this_lEmLookupCodTams  = .F.     && guarda de reentrancia (regra #37/#47 CLAUDE.md)
69: 
70:     *==========================================================================
71:     * Init - APENAS DODEFAULT (FormBase.Init chama InicializarForm)
72:     *==========================================================================
73:     PROCEDURE Init()
74:         RETURN DODEFAULT()
75:     ENDPROC
76: 
77:     *==========================================================================
78:     * Destroy - Encerramento do form (sem cursores proprios ainda nesta fase)
79:     *==========================================================================
80:     PROCEDURE Destroy()
81:         DODEFAULT()
82:     ENDPROC
83: 
84:     *==========================================================================
85:     * InicializarForm - Chamado por FormBase.Init via DODEFAULT
86:     *==========================================================================
87:     PROTECTED PROCEDURE InicializarForm()
88:         LOCAL loc_lSucesso, loc_lContinuar, loc_oErro
89:         loc_lSucesso   = .F.
90:         loc_lContinuar = .T.
91: 
92:         TRY
93:             THIS.this_oBusinessObject = CREATEOBJECT("SIGOPPENBO")
94:             IF VARTYPE(THIS.this_oBusinessObject) <> "O"
95:                 MsgErro("Falha ao criar SIGOPPENBO.", "Erro")
96:                 loc_lContinuar = .F.
97:             ENDIF
98: 
99:             IF loc_lContinuar
100:                 THIS.ConfigurarPageFrame()
101:                 THIS.ConfigurarPaginaLista()
102:                 THIS.ConfigurarPaginaDados()
103: 
104:                 *-- Pula carga SQL durante validacao de UI (gnConnHandle = -1 -
105:                 *-- regra do FORMCOR_LICOES_APRENDIDAS.md / #06 Problema 4)
106:                 IF TYPE("gb_4c_ValidandoUI") != "L" OR !gb_4c_ValidandoUI
107:                     THIS.CarregarLista()
108:                 ENDIF
109: 
110:                 THIS.pgf_4c_Paginas.Visible    = .T.
111:                 THIS.pgf_4c_Paginas.ActivePage  = 1
112:                 THIS.this_cModoAtual            = "LISTA"
113: 
114:                 loc_lSucesso = .T.
115:             ENDIF
116: 
117:         CATCH TO loc_oErro
118:             MsgErro(loc_oErro.Message + CHR(13) + ;
119:                     "Linha: " + TRANSFORM(loc_oErro.LineNo), "Erro ao inicializar FormSIGOPPEN")
120:             loc_lSucesso = .F.
121:         ENDTRY
122: 
123:         RETURN loc_lSucesso
124:     ENDPROC
125: 
126:     *==========================================================================
127:     * ConfigurarPageFrame - Cria pgf_4c_Paginas (2 paginas: Lista e Dados)
128:     *==========================================================================
129:     PROTECTED PROCEDURE ConfigurarPageFrame()
130:         THIS.AddObject("pgf_4c_Paginas", "PageFrame")
131:         WITH THIS.pgf_4c_Paginas
132:             .Top       = 0
133:             .Left      = 0
134:             .Width     = THIS.Width
135:             .Height    = THIS.Height
136:             .Tabs      = .F.
137:             .PageCount = 2
138:             .Visible   = .F.
139:         ENDWITH
140:     ENDPROC
141: 
142:     *==========================================================================
143:     * ConfigurarPaginaLista - Page1: faixa de cabecalho + grade principal
144:     * (worklist de pendencias em subniveis, legado SIGOPPEN.Grade ligado a
145:     * TmpPends) + CommandGroup com os botoes REAIS do legado (cntBotoes:
146:     * Produtos/Encerrar). Esta tela NAO eh CRUD - o legado nao tem Incluir/
147:     * Alterar/Excluir (e um worklist de aprovacao/reprovacao de pendencias) -
148:     * entao o template generico de Fase 4 ("grid + 6 botoes CRUD") NAO se
149:     * aplica aqui. Mesmo precedente de FormSigOpPck (task783): constroi-se
150:     * os controles REAIS do legado, nunca botoes CRUD inventados (REGRA
151:     * FUNDAMENTAL / PILAR 1 do CLAUDE.md). Cnt_SelItem (painel de selecao
152:     * de produtos) e Cnt_Status (painel de aprovacao) ficam para fases
153:     * posteriores.
154:     *==========================================================================
155:     PROTECTED PROCEDURE ConfigurarPaginaLista()
156:         LOCAL loc_oPg
157:         loc_oPg = THIS.pgf_4c_Paginas.Page1
158: 
159:         *-- Faixa cinza do cabecalho (equivalente cntSombra do legado)
160:         loc_oPg.AddObject("cnt_4c_Cabecalho", "Container")
161:         WITH loc_oPg.cnt_4c_Cabecalho
162:             .Top         = 0
163:             .Left        = 0
164:             .Width       = THIS.Width
165:             .Height      = 80
166:             .BackStyle   = 1
167:             .BackColor   = RGB(100, 100, 100)
168:             .BorderWidth = 0
169:             .Visible     = .T.
170: 
171:             .AddObject("lbl_4c_Sombra", "Label")
172:             WITH .lbl_4c_Sombra
173:                 .Top       = 15
174:                 .Left      = 10
175:                 .Width     = THIS.Width
176:                 .Height    = 40
177:                 .AutoSize  = .F.
178:                 .WordWrap  = .T.
179:                 .FontBold  = .T.
180:                 .FontName  = "Tahoma"
181:                 .FontSize  = 16
182:                 .BackStyle = 0
183:                 .ForeColor = RGB(0, 0, 0)
184:                 .Caption   = THIS.Caption
185:                 .Visible   = .T.
186:             ENDWITH
187: 
188:             .AddObject("lbl_4c_Titulo", "Label")
189:             WITH .lbl_4c_Titulo
190:                 .Top       = 18
191:                 .Left      = 10
192:                 .Width     = THIS.Width
193:                 .Height    = 46
194:                 .AutoSize  = .F.
195:                 .WordWrap  = .T.

*-- Linhas 208 a 270:
208:         *-- o Column.ControlSource de cada coluna ja poder ser ligado nesta
209:         *-- fase sem derrubar o Init (regra #41 CLAUDE.md: ControlSource de
210:         *-- cursor ainda inexistente estoura "Alias ... is not found" dentro
211:         *-- do TRY do InicializarForm). A POPULACAO real (SQLEXEC/APPEND a
212:         *-- partir de SigMvCab) fica para a fase do BO - SIGOPPENBO.prg ainda
213:         *-- nao tem Buscar/CarregarLista nesta fase.
214:         IF !USED("cursor_4c_Dados")
215:             CREATE CURSOR cursor_4c_Dados ( ;
216:                 Flag        L, ;
217:                 Emps        C(3), ;
218:                 Dopes       C(20), ;
219:                 Numes       N(6), ;
220:                 MascNum     C(6), ;
221:                 Datas       T NULL, ;
222:                 TpFats      C(3), ;
223:                 Origem      C(21), ;
224:                 Destino     C(21), ;
225:                 Valos       N(12,2), ;
226:                 Notas       C(6), ;
227:                 ChkSubN     N(1), ;
228:                 Obss        M NULL, ;
229:                 DescsO      C(40), ;
230:                 DescsD      C(40), ;
231:                 cIdChaves   C(10), ;
232:                 Usuars      C(10), ;
233:                 EmpDs       C(3), ;
234:                 pStatus     C(1), ;
235:                 DtEnts      T NULL, ;
236:                 ObsCabMovs  C(40), ;
237:                 Jobs        C(10), ;
238:                 Apagar      N(1), ;
239:                 PedidoWeb   C(50), ;
240:                 IDEntrega   C(50), ;
241:                 ChaveNota   C(44), ;
242:                 IDTransp    C(15), ;
243:                 NumeroNota  C(10), ;
244:                 EmpRet      C(3))
245:         ENDIF
246: 
247:         *-- Grade principal (legado: SIGOPPEN.Grade, RecordSource "tmppends")
248:         loc_oPg.AddObject("grd_4c_Dados", "Grid")
249: 
250:         *-- ColumnCount/RecordSource FORA do WITH (regra: colunas so existem
251:         *-- depois destas duas; Width/Caption de cada coluna tem de vir
252:         *-- DEPOIS do ControlSource, senao o VFP reseta para o default
253:         *-- 90/"Column1" - Problema 48 do FORMCOR_LICOES_APRENDIDAS.md)
254:         loc_oPg.grd_4c_Dados.ColumnCount  = 10
255:         loc_oPg.grd_4c_Dados.RecordSource = "cursor_4c_Dados"
256: 
257:         WITH loc_oPg.grd_4c_Dados
258:             .Top                = 213
259:             .Left               = 26
260:             .Width              = 999
261:             .Height             = 236
262:             .FontName           = "Verdana"
263:             .FontSize           = 8
264:             .HeaderHeight       = 22
265:             .RowHeight          = 16
266:             .ScrollBars         = 2
267:             .RecordMark         = .F.
268:             .ReadOnly           = .F.
269:             .HighlightBackColor = RGB(137, 209, 248)
270:             .HighlightForeColor = RGB(0, 0, 0)

*-- Linhas 280 a 300:
280:             *-- grade; sem Op_Escolha o guard negaria TODA marcacao, entao a
281:             *-- coluna fica habilitada - o toggle real esta em
282:             *-- ChkFlagKeyPress (regra #18: AddObject + CurrentControl +
283:             *-- Sparse=.F., DEPOIS do Grid.ReadOnly acima).
284:             .Column1.ColumnOrder       = 1
285:             .Column1.ControlSource     = "cursor_4c_Dados.Flag"
286:             .Column1.Width             = 20
287:             .Column1.Movable           = .F.
288:             .Column1.Resizable         = .F.
289:             .Column1.ReadOnly          = .F.
290:             .Column1.Sparse            = .F.
291:             .Column1.Alignment         = 2
292:             .Column1.FontName          = "Verdana"
293:             .Column1.FontSize          = 8
294:             .Column1.Header1.Caption   = ""
295:             .Column1.Header1.Alignment = 2
296:             .Column1.Header1.FontName  = "Verdana"
297:             .Column1.Header1.FontSize  = 8
298: 
299:             .Column1.AddObject("chk_4c_Flag", "CheckBox")
300:             WITH .Column1.chk_4c_Flag

*-- Linhas 315 a 467:
315:             *-- Toggle da marcacao (legado: Grade.seleciona.fwcheckbox1.Click)
316:             *-- - CheckBox de Column exige os 4 handlers com NODEFAULT (regra
317:             *-- #46/pattern #185 CLAUDE.md), senao o clique nao alterna nada.
318:             BINDEVENT(.Column1.chk_4c_Flag, "Click",     THIS, "ChkFlagClick")
319:             BINDEVENT(.Column1.chk_4c_Flag, "MouseDown", THIS, "ChkFlagMouseDown")
320:             BINDEVENT(.Column1.chk_4c_Flag, "MouseUp",   THIS, "ChkFlagMouseUp")
321:             BINDEVENT(.Column1.chk_4c_Flag, "KeyPress",  THIS, "ChkFlagKeyPress")
322: 
323:             *-- Marcar/desmarcar TODAS as linhas de uma vez (legado:
324:             *-- Grade.seleciona.Header1.Click)
325:             BINDEVENT(.Column1.Header1, "Click", THIS, "HeaderSelecionaClick")
326: 
327:             *-- Column8 "empresa" (ColumnOrder=2) - caption "Emp"
328:             .Column8.ColumnOrder       = 2
329:             .Column8.ControlSource     = "cursor_4c_Dados.Emps"
330:             .Column8.Width             = 31
331:             .Column8.ReadOnly          = .T.
332:             .Column8.FontName          = "Verdana"
333:             .Column8.FontSize          = 8
334:             .Column8.Header1.Caption   = "Emp"
335:             .Column8.Header1.Alignment = 2
336:             .Column8.Header1.FontName  = "Verdana"
337:             .Column8.Header1.FontSize  = 8
338: 
339:             *-- Column3 "codigo" (ColumnOrder=3) - ControlSource EXPRESSAO
340:             *-- (legado: 'PADL(TmpPends.NUMES,10,[0])') - nao eh campo puro,
341:             *-- entao ReadOnly=.T. eh definitivo (nao da para gravar de volta
342:             *-- numa expressao), nao so um stand-in desta fase.
343:             .Column3.ColumnOrder       = 3
344:             .Column3.ControlSource     = "PADL(cursor_4c_Dados.Numes, 10, '0')"
345:             .Column3.Width             = 80
346:             .Column3.Movable           = .F.
347:             .Column3.Resizable         = .F.
348:             .Column3.ReadOnly          = .T.
349:             .Column3.FontName          = "Verdana"
350:             .Column3.FontSize          = 8
351:             .Column3.Header1.Caption   = "Codigo"
352:             .Column3.Header1.Alignment = 2
353:             .Column3.Header1.FontName  = "Verdana"
354:             .Column3.Header1.FontSize  = 8
355: 
356:             *-- Column9 "operacao" (ColumnOrder=4) - caption "Movimentacao".
357:             *-- Confirmado no dump (linha ~7590): esta coluna exibe o CODIGO
358:             *-- da operacao (Dopes), apesar do nome "operacao"/caption
359:             *-- "Movimentacao" - this.grade.Operacao.controlsource =
360:             *-- 'TmpPends.Dopes'. Transcrito literal, nao reinterpretado.
361:             .Column9.ColumnOrder       = 4
362:             .Column9.ControlSource     = "cursor_4c_Dados.Dopes"
363:             .Column9.Width             = 270
364:             .Column9.ReadOnly          = .T.
365:             .Column9.FontName          = "Verdana"
366:             .Column9.FontSize          = 8
367:             .Column9.Header1.Caption   = "Movimenta" + CHR(231) + CHR(227) + "o"
368:             .Column9.Header1.Alignment = 2
369:             .Column9.Header1.FontName  = "Verdana"
370:             .Column9.Header1.FontSize  = 8
371: 
372:             *-- Column4 "data" (ColumnOrder=5)
373:             .Column4.ColumnOrder       = 5
374:             .Column4.ControlSource     = "cursor_4c_Dados.Datas"
375:             .Column4.Width             = 70
376:             .Column4.Movable           = .F.
377:             .Column4.Resizable         = .F.
378:             .Column4.ReadOnly          = .T.
379:             .Column4.FontName          = "Verdana"
380:             .Column4.FontSize          = 8
381:             .Column4.Header1.Caption   = "Data"
382:             .Column4.Header1.Alignment = 2
383:             .Column4.Header1.FontName  = "Verdana"
384:             .Column4.Header1.FontSize  = 8
385: 
386:             *-- Column5 "Grupo" (ColumnOrder=6) - caption "Origem". ReadOnly
387:             *-- forcado para .T. nesta fase (sem Valid/lookup wireado ainda,
388:             *-- celula editavel "morta" confunde o usuario) - a lookup de
389:             *-- Grupo/Conta de origem/destino entra junto com os handlers de
390:             *-- grade (Fases 6/7, regra #46/#47 do CLAUDE.md).
391:             .Column5.ColumnOrder       = 6
392:             .Column5.ControlSource     = "cursor_4c_Dados.Origem"
393:             .Column5.Width             = 150
394:             .Column5.Movable           = .F.
395:             .Column5.Resizable         = .F.
396:             .Column5.ReadOnly          = .T.
397:             .Column5.FontName          = "Verdana"
398:             .Column5.FontSize          = 8
399:             .Column5.Header1.Caption   = "Origem"
400:             .Column5.Header1.Alignment = 2
401:             .Column5.Header1.FontName  = "Verdana"
402:             .Column5.Header1.FontSize  = 8
403: 
404:             *-- Column6 "Conta" (ColumnOrder=7) - caption "Destino" (mesma
405:             *-- ressalva de ReadOnly da Column5)
406:             .Column6.ColumnOrder       = 7
407:             .Column6.ControlSource     = "cursor_4c_Dados.Destino"
408:             .Column6.Width             = 150
409:             .Column6.Movable           = .F.
410:             .Column6.Resizable         = .F.
411:             .Column6.ReadOnly          = .T.
412:             .Column6.FontName          = "Verdana"
413:             .Column6.FontSize          = 8
414:             .Column6.Header1.Caption   = "Destino"
415:             .Column6.Header1.Alignment = 2
416:             .Column6.Header1.FontName  = "Verdana"
417:             .Column6.Header1.FontSize  = 8
418: 
419:             *-- Column2 "documento" (ColumnOrder=8) - caption "Docto." (mesma
420:             *-- ressalva de ReadOnly - sem Valid wireado ainda)
421:             .Column2.ColumnOrder       = 8
422:             .Column2.ControlSource     = "cursor_4c_Dados.Notas"
423:             .Column2.Width             = 68
424:             .Column2.Movable           = .F.
425:             .Column2.Resizable         = .F.
426:             .Column2.ReadOnly          = .T.
427:             .Column2.FontName          = "Verdana"
428:             .Column2.FontSize          = 8
429:             .Column2.Header1.Caption   = "Docto."
430:             .Column2.Header1.Alignment = 2
431:             .Column2.Header1.FontName  = "Verdana"
432:             .Column2.Header1.FontSize  = 8
433: 
434:             *-- Column7 "Valor" (ColumnOrder=9)
435:             .Column7.ColumnOrder       = 9
436:             .Column7.ControlSource     = "cursor_4c_Dados.Valos"
437:             .Column7.Width             = 91
438:             .Column7.Movable           = .F.
439:             .Column7.Resizable         = .F.
440:             .Column7.ReadOnly          = .T.
441:             .Column7.FontName          = "Verdana"
442:             .Column7.FontSize          = 8
443:             .Column7.Header1.Caption   = "Valor"
444:             .Column7.Header1.Alignment = 2
445:             .Column7.Header1.FontName  = "Verdana"
446:             .Column7.Header1.FontSize  = 8
447: 
448:             *-- Column10 "EmpDestino" (sem ColumnOrder explicito no dump -
449:             *-- mantem o default/ultima posicao) - caption "EmpD". Dump
450:             *-- legado tem ReadOnly=.F., mas sem handler nesta fase forcado
451:             *-- para .T. pela mesma razao das colunas Grupo/Conta/documento.
452:             .Column10.ControlSource     = "cursor_4c_Dados.EmpDs"
453:             .Column10.Width             = 39
454:             .Column10.ReadOnly          = .T.
455:             .Column10.FontName          = "Verdana"
456:             .Column10.FontSize          = 8
457:             .Column10.Header1.Caption   = "EmpD"
458:             .Column10.Header1.Alignment = 2
459:             .Column10.Header1.FontName  = "Verdana"
460:             .Column10.Header1.FontSize  = 8
461:         ENDWITH
462: 
463:         *-- CommandGroup com os botoes REAIS do legado (legado: cntBotoes -
464:         *-- Produtos/Encerrar). Esta tela NAO tem Incluir/Alterar/Excluir -
465:         *-- NAO inventar botoes CRUD (REGRA FUNDAMENTAL do CLAUDE.md).
466:         *-- Clicks: ver CmdBotoesClick, mais abaixo neste metodo.
467:         loc_oPg.AddObject("obj_4c_CmgBotoes", "CommandGroup")

*-- Linhas 528 a 637:
528: 
529:         *-- Dispatcher de clique do grupo Produtos/Encerrar (legado:
530:         *-- cntBotoes.btnSelItens.Click / cntBotoes.btnSair.Click)
531:         BINDEVENT(loc_oPg.obj_4c_CmgBotoes, "Click", THIS, "CmdBotoesClick")
532: 
533:         *-- Botao "Subniveis" (legado: SIGOPPEN.SubNiveis, Top=130/Left=284/
534:         *-- 75x75, Picture geral_subnivel_60.jpg). Abre o detalhamento em
535:         *-- subniveis da linha corrente da grade. ZOrderSet=14 do dump NAO eh
536:         *-- transcrito: eh bookkeeping do Form Designer e nao existe em
537:         *-- runtime (regra #33 CLAUDE.md).
538:         loc_oPg.AddObject("cmd_4c_SubNiveis", "CommandButton")
539:         WITH loc_oPg.cmd_4c_SubNiveis
540:             .Top             = 130
541:             .Left            = 284
542:             .Width           = 75
543:             .Height          = 75
544:             .FontBold        = .T.
545:             .FontItalic      = .T.
546:             .FontName        = "Comic Sans MS"
547:             .FontSize        = 8
548:             .WordWrap        = .T.
549:             .Picture         = gc_4c_CaminhoIcones + "geral_subnivel_60.jpg"
550:             .DisabledPicture = gc_4c_CaminhoIcones + "geral_subnivel_60.jpg"
551:             .Caption         = "\<Subn" + CHR(237) + "veis"
552:             .ToolTipText     = "Subn" + CHR(237) + "veis"
553:             .MousePointer    = 15
554:             .PicturePosition = 13
555:             .ForeColor       = RGB(90, 90, 90)
556:             .BackColor       = RGB(255, 255, 255)
557:             .Themes          = .T.
558:             .Visible         = .T.
559:         ENDWITH
560: 
561:         BINDEVENT(loc_oPg.cmd_4c_SubNiveis, "Click", THIS, "BtnSubNiveisClick")
562: 
563:         *-- Botao "..." de liberacao de consulta de TODOS os subniveis
564:         *-- (legado: SIGOPPEN.BtnLiberar, Top=564/Left=210/18x19, Caption
565:         *-- "..."). O Init legado o deixa oculto e so o revela quando
566:         *-- Type([CrSigOpCdI.ValTmpSubn])=[N] And CrSigOpCdI.ValTmpSubn = 1 -
567:         *-- CrSigOpCdI eh montado pelo metodo "Carregar" do legado, que vem
568:         *-- com a carga da grade; ate la vale o estado inicial do legado
569:         *-- (oculto), transcrito literalmente.
570:         loc_oPg.AddObject("cmd_4c_Liberar", "CommandButton")
571:         WITH loc_oPg.cmd_4c_Liberar
572:             .Top               = 564
573:             .Left              = 210
574:             .Width             = 18
575:             .Height            = 19
576:             .FontName          = "Tahoma"
577:             .FontSize          = 7
578:             .Caption           = "..."
579:             .ToolTipText       = "Libera Consulta de Todos Subn" + CHR(237) + "veis"
580:             .ForeColor         = RGB(90, 90, 90)
581:             .BackColor         = RGB(255, 255, 255)
582:             .DisabledBackColor = RGB(255, 255, 255)
583:             .Visible           = .F.
584:         ENDWITH
585: 
586:         BINDEVENT(loc_oPg.cmd_4c_Liberar, "Click", THIS, "BtnLiberarClick")
587:     ENDPROC
588: 
589:     *==========================================================================
590:     * ConfigurarPaginaDados - Page2: painel de Status da Movimentacao
591:     * (equivalente Cnt_Status do legado - Aprovar/Reprovar/Cancelar).
592:     * Faixa de cabecalho (regra #11 CLAUDE.md - cabecalho nas DUAS paginas) +
593:     * container de botoes de acao, reposicionado para DEPOIS da faixa, +
594:     * campos (Status/Tam/Observacao). Clicks: ver CmdStatusClick/
595:     * BtnEncerrarStatusClick, mais abaixo neste metodo.
596:     *==========================================================================
597:     PROTECTED PROCEDURE ConfigurarPaginaDados()
598:         LOCAL loc_oPg
599:         loc_oPg = THIS.pgf_4c_Paginas.Page2
600: 
601:         *-- Faixa cinza do cabecalho (equivalente cntSombra do legado,
602:         *-- replicada aqui igual a Page1 - regra #11). DEVE ser o PRIMEIRO
603:         *-- AddObject da pagina: cnt_4c_BotoesAcao (Top=32, dentro da area
604:         *-- da faixa) e demais controles de acao desenham POR CIMA por
605:         *-- terem sido criados DEPOIS dela.
606:         loc_oPg.AddObject("cnt_4c_Cabecalho", "Container")
607:         WITH loc_oPg.cnt_4c_Cabecalho
608:             .Top         = 0
609:             .Left        = 0
610:             .Width       = THIS.Width
611:             .Height      = 80
612:             .BackStyle   = 1
613:             .BackColor   = RGB(100, 100, 100)
614:             .BorderWidth = 0
615:             .Visible     = .T.
616: 
617:             .AddObject("lbl_4c_Sombra", "Label")
618:             WITH .lbl_4c_Sombra
619:                 .Top       = 15
620:                 .Left      = 10
621:                 .Width     = THIS.Width
622:                 .Height    = 40
623:                 .AutoSize  = .F.
624:                 .WordWrap  = .T.
625:                 .FontBold  = .T.
626:                 .FontName  = "Tahoma"
627:                 .FontSize  = 16
628:                 .BackStyle = 0
629:                 .ForeColor = RGB(0, 0, 0)
630:                 .Caption   = THIS.Caption
631:                 .Visible   = .T.
632:             ENDWITH
633: 
634:             .AddObject("lbl_4c_Titulo", "Label")
635:             WITH .lbl_4c_Titulo
636:                 .Top       = 18
637:                 .Left      = 10

*-- Linhas 737 a 801:
737: 
738:             *-- Dispatcher de Aprovar/Reprovar/Cancelar (legado:
739:             *-- Cnt_Status.Commandgroup1.Command1/2/3.Click)
740:             BINDEVENT(.obj_4c_CmgStatus, "Click", THIS, "CmdStatusClick")
741:         ENDWITH
742: 
743:         *-- Shape5 (legado: Cnt_Status.Shape5, Top=34/Left=340) - borda 3D
744:         *-- decorativa ao lado do CommandGroup. Fica no mesmo Top do grupo
745:         *-- (32..34), sem deslocamento - companheira visual da barra de
746:         *-- acao do topo, mesma excecao da regra #11.
747:         loc_oPg.AddObject("shp_4c_Shape5", "Shape")
748:         WITH loc_oPg.shp_4c_Shape5
749:             .Top           = 34
750:             .Left          = 340
751:             .Width         = 85
752:             .Height        = 82
753:             .BorderWidth   = 1
754:             .SpecialEffect = 1
755:             .Visible       = .T.
756:         ENDWITH
757: 
758:         *-- Say1 "Status da Movimentacao" (legado: Cnt_Status.Say1, Top=4) -
759:         *-- deslocado para Top=84 (imediatamente abaixo da faixa, que ocupa
760:         *-- 0-80). Label NAO esta na lista de excecoes da regra #11 (que
761:         *-- cobre so Container/CommandButton/OptionGroup da barra de acao).
762:         loc_oPg.AddObject("lbl_4c_Status", "Label")
763:         WITH loc_oPg.lbl_4c_Status
764:             .Top       = 84
765:             .Left      = 151
766:             .Width     = 230
767:             .Height    = 15
768:             .AutoSize  = .F.
769:             .Alignment = 0
770:             .BackStyle = 0
771:             .FontName  = "Tahoma"
772:             .FontSize  = 8
773:             .ForeColor = RGB(90, 90, 90)
774:             .Caption   = "Status da Movimenta" + CHR(231) + CHR(227) + "o"
775:             .Visible   = .T.
776:         ENDWITH
777: 
778:         *-- Label9 "Tam" (legado: Cnt_Status.Label9, Top=115/Left=5)
779:         loc_oPg.AddObject("lbl_4c_Tam", "Label")
780:         WITH loc_oPg.lbl_4c_Tam
781:             .Top       = 115
782:             .Left      = 5
783:             .Width     = 22
784:             .Height    = 15
785:             .AutoSize  = .F.
786:             .Alignment = 0
787:             .BackStyle = 0
788:             .FontName  = "Tahoma"
789:             .FontSize  = 8
790:             .ForeColor = RGB(90, 90, 90)
791:             .Caption   = "Tam"
792:             .Visible   = .T.
793:         ENDWITH
794: 
795:         *-- getCodTams (legado: Cnt_Status.getCodTams, Top=131/Left=5) -
796:         *-- codigo do Tamanho associado ao subnivel selecionado na grade
797:         *-- (lookup fwbuscaext contra SigCdTam.Cods - comportamento.json).
798:         loc_oPg.AddObject("txt_4c_CodTams", "TextBox")
799:         WITH loc_oPg.txt_4c_CodTams
800:             .Top         = 131
801:             .Left        = 5

*-- Linhas 811 a 857:
811:         ENDWITH
812: 
813:         *-- Lookup do Tamanho (legado: Cnt_Status.getCodTams.Valid -
814:         *-- fwbuscaext contra SigCdTam.Cods). BINDEVENT em LostFocus, que
815:         *-- eh o equivalente ao Valid do legado (regra #47 CLAUDE.md) - NAO
816:         *-- KeyPress sem testar a tecla, que abriria o picker a cada letra.
817:         BINDEVENT(loc_oPg.txt_4c_CodTams, "LostFocus", THIS, "ValidarCodTamsLostFocus")
818: 
819:         *-- Label10 "Observacao" (legado: Cnt_Status.Label10, Top=115/Left=47)
820:         loc_oPg.AddObject("lbl_4c_Observacao", "Label")
821:         WITH loc_oPg.lbl_4c_Observacao
822:             .Top       = 115
823:             .Left      = 47
824:             .Width     = 60
825:             .Height    = 15
826:             .AutoSize  = .F.
827:             .Alignment = 0
828:             .BackStyle = 0
829:             .FontName  = "Tahoma"
830:             .FontSize  = 8
831:             .ForeColor = RGB(90, 90, 90)
832:             .Caption   = "Observa" + CHR(231) + CHR(227) + "o"
833:             .Visible   = .T.
834:         ENDWITH
835: 
836:         *-- txtObses (legado: Cnt_Status.txtObses, EditBox, Top=131/Left=47)
837:         *-- - texto de aprovacao/reprovacao/cancelamento, concatenado pelo
838:         *-- BO com o usuario logado (ver BtnAprovarClick/BtnReprovarClick/
839:         *-- BtnCancelarClick). Sem ControlSource - o legado tambem nao liga a
840:         *-- cursor (ControlSource = "").
841:         loc_oPg.AddObject("edt_4c_Observacoes", "EditBox")
842:         WITH loc_oPg.edt_4c_Observacoes
843:             .Top           = 131
844:             .Left          = 47
845:             .Width         = 487
846:             .Height        = 101
847:             .Value         = ""
848:             .BorderStyle   = 1
849:             .SpecialEffect = 1
850:             .FontName      = "Tahoma"
851:             .FontSize      = 8
852:             .Visible       = .T.
853:         ENDWITH
854: 
855:         *-- btnCancela "Encerrar" (legado: Cnt_Status.btnCancela, classe
856:         *-- fwbtng, Top=37/Left=342/Width=80 - sem Height explicito no
857:         *-- dump, herda 75 da classe fwbtng/padrao canonico de botao).

*-- Linhas 878 a 1361:
878: 
879:         *-- Dismiss do painel de Status sem gravar (legado:
880:         *-- Cnt_Status.btnCancela.Click)
881:         BINDEVENT(loc_oPg.cmd_4c_Encerrar, "Click", THIS, "BtnEncerrarStatusClick")
882:     ENDPROC
883: 
884:     *==========================================================================
885:     * ValidarCodTamsLostFocus - Lookup do campo Tamanho do painel de Status
886:     * (legado: Cnt_Status.getCodTams.Valid - fwbuscaext contra SigCdTam,
887:     * chave Cods). PUBLIC (BINDEVENT exige metodo PUBLIC - regra #3
888:     * CLAUDE.md). Guarda de reentrancia (regra #37): o picker eh MODAL e,
889:     * ao tirar o foco, pode redisparar o proprio LostFocus.
890:     *==========================================================================
891:     PROCEDURE ValidarCodTamsLostFocus()
892:         LOCAL loc_oPg, loc_oBusca, loc_cValor, loc_oErro
893: 
894:         IF THIS.this_lEmLookupCodTams
895:             RETURN
896:         ENDIF
897:         THIS.this_lEmLookupCodTams = .T.
898: 
899:         TRY
900:             loc_oPg    = THIS.pgf_4c_Paginas.Page2
901:             loc_cValor = ALLTRIM(loc_oPg.txt_4c_CodTams.Value)
902: 
903:             IF !EMPTY(loc_cValor)
904:                 loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
905:                     "SigCdTam", "cursor_4c_BuscaTam", "Cods", loc_cValor, ;
906:                     "Sele" + CHR(231) + CHR(227) + "o")
907: 
908:                 IF VARTYPE(loc_oBusca) = "O"
909:                     IF !loc_oBusca.this_lAchouRegistro
910:                         loc_oBusca.mAddColuna("Cods",  "", "C" + CHR(243) + "digo")
911:                         loc_oBusca.mAddColuna("Descs", "", "Descri" + CHR(231) + CHR(227) + "o")
912:                         loc_oBusca.Show()
913:                     ENDIF
914: 
915:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaTam")
916:                         loc_oPg.txt_4c_CodTams.Value = ALLTRIM(cursor_4c_BuscaTam.Cods)
917:                     ENDIF
918: 
919:                     IF USED("cursor_4c_BuscaTam")
920:                         USE IN cursor_4c_BuscaTam
921:                     ENDIF
922:                     loc_oBusca.Release()
923:                 ENDIF
924: 
925:                 loc_oPg.txt_4c_CodTams.Refresh()
926:             ENDIF
927:         CATCH TO loc_oErro
928:             MsgErro(loc_oErro.Message, "Erro ao buscar Tamanho")
929:         ENDTRY
930: 
931:         THIS.this_lEmLookupCodTams = .F.
932:     ENDPROC
933: 
934:     *==========================================================================
935:     * AlternarPagina - Funil unico de navegacao entre LISTA (Page1 - grade
936:     * de pendencias) e STATUS (Page2 - painel de Aprovar/Reprovar/Cancelar,
937:     * equivalente Cnt_Status do legado). PUBLIC (nao PROTECTED): o
938:     * TesteAutomatico.prg chama metodos de navegacao do form direto de fora
939:     * da classe, sem BINDEVENT (regra "TesteAutoprotec"/#3 do CLAUDE.md).
940:     * Esta tela NAO eh CRUD - nao ha botoes de lista para reabilitar (regra
941:     * #40 nao se aplica, mesmo precedente de FormSigOpPck/task783), so o
942:     * modo atual do form. NAO chama THIS.this_oBusinessObject.Buscar(...)/
943:     * CarregarLista() - SIGOPPENBO.prg ainda nao tem esse metodo nesta fase;
944:     * chamar algo inexistente estouraria em runtime (regra #13 CLAUDE.md).
945:     *==========================================================================
946:     PROCEDURE AlternarPagina(par_nPagina)
947:         THIS.pgf_4c_Paginas.ActivePage = par_nPagina
948: 
949:         IF par_nPagina = 1
950:             THIS.this_cModoAtual = "LISTA"
951:         ELSE
952:             THIS.this_cModoAtual = "STATUS"
953: 
954:             *-- txtObses/getCodTams nao tem ControlSource no legado (campos
955:             *-- de entrada livre a cada abertura do painel) - limpar ao
956:             *-- entrar evita que o texto digitado para a linha anterior
957:             *-- sobre e seja aplicado por engano a esta.
958:             THIS.pgf_4c_Paginas.Page2.edt_4c_Observacoes.Value = ""
959:             THIS.pgf_4c_Paginas.Page2.txt_4c_CodTams.Value     = ""
960:         ENDIF
961:     ENDPROC
962: 
963:     *==========================================================================
964:     * CarregarLista - Popula cursor_4c_Dados (worklist de pendencias em
965:     * subniveis) via SIGOPPENBO.Buscar() e repinta a grade da Page1 (regra
966:     * #21 CLAUDE.md - popular cursor NAO repinta a grade sozinho). Chamada
967:     * no Init (ver InicializarForm) - aprovar/reprovar/cancelar NAO
968:     * recarregam do banco, so atualizam o cursor em memoria (ver
969:     * AplicarStatusMovimento), entao esta tela nao precisa de um botao
970:     * "Buscar" separado (o legado tambem nao tem um - regra fundamental:
971:     * nao inventar botao que o legado nao tem). PUBLIC (nao PROTECTED): o
972:     * TesteAutomatico.prg chama metodos de carga do form direto de fora da
973:     * classe, sem BINDEVENT (regra "TesteAutoprotec"/#3 CLAUDE.md).
974:     *==========================================================================
975:     PROCEDURE CarregarLista()
976:         LOCAL loc_lSucesso
977:         loc_lSucesso = .F.
978: 
979:         IF VARTYPE(THIS.this_oBusinessObject) = "O"
980:             loc_lSucesso = THIS.this_oBusinessObject.Buscar("")
981:         ENDIF
982: 
983:         IF USED("cursor_4c_Dados")
984:             GO TOP IN cursor_4c_Dados
985:             THIS.pgf_4c_Paginas.Page1.grd_4c_Dados.Refresh()
986:         ENDIF
987: 
988:         RETURN loc_lSucesso
989:     ENDPROC
990: 
991:     *==========================================================================
992:     * ChkFlagClick/MouseDown/MouseUp - Suprimem o toggle nativo do CheckBox
993:     * de Column (regra #46 CLAUDE.md / pattern #185) - a alternancia real
994:     * acontece em ChkFlagKeyPress, chamado por MouseUp/Enter/Espaco.
995:     *==========================================================================
996:     PROCEDURE ChkFlagClick()
997:         NODEFAULT
998:     ENDPROC
999: 
1000:     PROCEDURE ChkFlagMouseDown(par_nButton, par_nShift, par_nX, par_nY)
1001:         NODEFAULT
1002:     ENDPROC
1003: 
1004:     PROCEDURE ChkFlagMouseUp(par_nButton, par_nShift, par_nX, par_nY)
1005:         THIS.ChkFlagKeyPress(13, 0)
1006:         NODEFAULT
1007:     ENDPROC
1008: 
1009:     *==========================================================================
1010:     * ChkFlagKeyPress - Alterna a marcacao da linha corrente (legado:
1011:     * Grade.seleciona.fwcheckbox1.Click - "If !This.Value / ThisForm.
1012:     * Desmarca / Else / This.Value = ThisForm.Marca() / Endif"). Marca()/
1013:     * Desmarca() do legado preparam ~10 cursores de trabalho (crTpmMvItn,
1014:     * crTpmMvIts, crSigSubMv, xBaixaSS, ...) para a baixa em subniveis - esse
1015:     * subsistema de carga de itens ainda nao foi migrado (fica para fase
1016:     * dedicada); aqui fica o efeito visivel e auditavel da marcacao: alterna
1017:     * Flag no cursor da grade e, ao MARCAR a linha, abre o painel de Status
1018:     * (legado: "If oPendSnope.tStatus = 1 / ThisForm.Cnt_Status.Visible =
1019:     * .T." - aqui simplificado para toda marcacao, ja que a tela nao tem
1020:     * ainda o fluxo alternativo de baixa direta sem aprovacao).
1021:     *==========================================================================
1022:     PROCEDURE ChkFlagKeyPress(par_nKeyCode, par_nShiftAltCtrl)
1023:         LOCAL loc_lNovoValor
1024: 
1025:         IF !INLIST(par_nKeyCode, 13, 32) OR !USED("cursor_4c_Dados") OR EOF("cursor_4c_Dados")
1026:             RETURN
1027:         ENDIF
1028: 
1029:         loc_lNovoValor = !cursor_4c_Dados.Flag
1030:         REPLACE Flag WITH loc_lNovoValor IN cursor_4c_Dados
1031:         THIS.pgf_4c_Paginas.Page1.grd_4c_Dados.Refresh()
1032:         NODEFAULT
1033: 
1034:         IF loc_lNovoValor
1035:             THIS.AlternarPagina(2)
1036:         ENDIF
1037:     ENDPROC
1038: 
1039:     *==========================================================================
1040:     * HeaderSelecionaClick - Marca/desmarca todas as linhas da grade (legado:
1041:     * Grade.seleciona.Header1.Click - alterna o Tag do header entre 'X' e
1042:     * ' ' e aplica Flag a todas as linhas do cursor).
1043:     *==========================================================================
1044:     PROCEDURE HeaderSelecionaClick()
1045:         LOCAL loc_oGrid, loc_lMarcarTudo
1046: 
1047:         IF !USED("cursor_4c_Dados")
1048:             RETURN
1049:         ENDIF
1050: 
1051:         loc_oGrid      = THIS.pgf_4c_Paginas.Page1.grd_4c_Dados
1052:         loc_lMarcarTudo = (loc_oGrid.Column1.Header1.Tag <> "X")
1053: 
1054:         SELECT cursor_4c_Dados
1055:         SCAN
1056:             REPLACE Flag WITH loc_lMarcarTudo
1057:         ENDSCAN
1058:         GO TOP IN cursor_4c_Dados
1059: 
1060:         loc_oGrid.Column1.Header1.Tag = IIF(loc_lMarcarTudo, "X", "")
1061:         loc_oGrid.Refresh()
1062:     ENDPROC
1063: 
1064:     *==========================================================================
1065:     * CmdBotoesClick - Dispatcher do grupo Produtos/Encerrar da Page1
1066:     * (legado: cntBotoes - Buttons(1)=btnSelItens, Buttons(2)=btnSair).
1067:     * O legado tem um Click POR BOTAO; aqui o CommandGroup entrega um unico
1068:     * evento com o indice, e cada ramo delega ao handler nomeado do botao
1069:     * correspondente - um para um com o legado.
1070:     *==========================================================================
1071:     PROCEDURE CmdBotoesClick(par_nValue)
1072:         DO CASE
1073:         CASE par_nValue = 1
1074:             THIS.BtnSelItensClick()
1075:         CASE par_nValue = 2
1076:             THIS.BtnSairClick()
1077:         ENDCASE
1078:     ENDPROC
1079: 
1080:     *==========================================================================
1081:     * BtnSelItensClick - Botao "Produtos" (legado: cntBotoes.btnSelItens.
1082:     * Click - "If Not TmpPends.Flag / Thisform.Grade.SetFocus / Else <monta
1083:     * a grade de itens do subnivel e exibe Cnt_SelItem> / Endif").
1084:     *
1085:     * O ramo ELSE do legado religa Thisform.Cnt_SelItem.Grade a crTpmMvItn
1086:     * (dez ControlSource + InputMask derivado de CrSigOpCdd.CasQtds) e torna
1087:     * o painel visivel. crTpmMvItn eh um dos cursores de trabalho montados
1088:     * pelo metodo "Carregar" do legado (~2860 linhas), que entra junto com a
1089:     * carga da grade principal; enquanto o cursor nao existe, religar a grade
1090:     * estouraria "Alias CRTPMMVITN is not found" (regra #41 CLAUDE.md). O
1091:     * guard de marcacao abaixo eh transcrito literal e ja eh o caminho que o
1092:     * usuario percorre hoje: sem linha marcada, o foco volta para a grade.
1093:     *==========================================================================
1094:     PROCEDURE BtnSelItensClick()
1095:         IF !USED("cursor_4c_Dados") OR EOF("cursor_4c_Dados") OR !cursor_4c_Dados.Flag
1096:             THIS.pgf_4c_Paginas.Page1.grd_4c_Dados.SetFocus()
1097:             RETURN
1098:         ENDIF
1099: 
1100:         *-- Linha marcada: o legado troca a grade principal pelo painel de
1101:         *-- itens. Sem crTpmMvItn o painel nao tem o que exibir, entao avisa
1102:         *-- em vez de abrir uma grade vazia (regra #27 CLAUDE.md: ausencia
1103:         *-- tem de ficar VISIVEL, nunca mascarada).
1104:         IF !USED("crTpmMvItn")
1105:             MsgAviso("Os itens do subn" + CHR(237) + "vel n" + CHR(227) + "o est" + ;
1106:                      CHR(227) + "o carregados para esta movimenta" + CHR(231) + CHR(227) + ;
1107:                      "o.", "Produtos")
1108:             THIS.pgf_4c_Paginas.Page1.grd_4c_Dados.SetFocus()
1109:             RETURN
1110:         ENDIF
1111: 
1112:         SELECT crTpmMvItn
1113:         SET ORDER TO
1114:         GO TOP
1115:         REPLACE ALL Marcas WITH .T.
1116:         GO TOP IN crTpmMvItn
1117:     ENDPROC
1118: 
1119:     *==========================================================================
1120:     * BtnSairClick - Botao "Encerrar" da Page1 (legado: cntBotoes.btnSair.
1121:     * Click, Cancel = .T.).
1122:     *
1123:     * No legado este botao eh a FINALIZACAO da movimentacao: alem do
1124:     * "ThisForm.Release", ele recalcula impostos, totais, cotacao e parcelas
1125:     * chamando metodos do form PAI (ThisForm.parentform.CalcImposto /
1126:     * AtuaTot / Cotacao / CalculaPar / calc_valite / AcioCancela e o
1127:     * Grupo_Salva.Salva.Click dele) sobre os cursores de trabalho TprMvCab,
1128:     * crTpmMvItn, crTpmMvIts, xPar, TmpOperacao, TmpPendR e crStsMvPec.
1129:     * O SIGOPPEN eh um dialogo FILHO: o legado recebe o pai no Init
1130:     * (pform/pForm2) e todo esse bloco opera exclusivamente sobre ele. A
1131:     * cadeia pai + cursores de trabalho entra com a carga da grade; o que
1132:     * pertence a ESTE form - fechar a tela - eh transcrito aqui.
1133:     *==========================================================================
1134:     PROCEDURE BtnSairClick()
1135:         THIS.Release()
1136:     ENDPROC
1137: 
1138:     *==========================================================================
1139:     * BtnSubNiveisClick - Botao "Subniveis" (legado: SIGOPPEN.SubNiveis.Click
1140:     * - "Thisform.Podatamgr = Thisform.ParentForm.Podatamgr / Do Form
1141:     * SigMvSbn with Thisform, TmpPends.Emps, TmpPends.Dopes, TmpPends.Numes").
1142:     *
1143:     * A primeira linha do legado so repassa o gerenciador de conexao do pai;
1144:     * na arquitetura nova a conexao eh a global gnConnHandle, entao resta a
1145:     * abertura do dialogo. CREATEOBJECT no lugar de DO FORM (o projeto nao
1146:     * tem .SCX; alem disso o indice de carga sob demanda so enxerga
1147:     * CREATEOBJECT) e Show() FORA do TRY, porque FormSigMvSbn eh modal e o
1148:     * TRY engoliria os erros da tela filha inteira, derrubando a referencia
1149:     * LOCAL e fechando-a sozinha (regra #29 CLAUDE.md).
1150:     *==========================================================================
1151:     PROCEDURE BtnSubNiveisClick()
1152:         LOCAL loc_oForm, loc_oErro
1153:         loc_oForm = .NULL.
1154: 
1155:         IF !USED("cursor_4c_Dados") OR EOF("cursor_4c_Dados")
1156:             THIS.pgf_4c_Paginas.Page1.grd_4c_Dados.SetFocus()
1157:             RETURN
1158:         ENDIF
1159: 
1160:         TRY
1161:             loc_oForm = CREATEOBJECT("FormSigMvSbn", THIS, ;
1162:                                      cursor_4c_Dados.Emps, ;
1163:                                      cursor_4c_Dados.Dopes, ;
1164:                                      cursor_4c_Dados.Numes)
1165:         CATCH TO loc_oErro
1166:             MsgErro("Erro ao abrir os Subn" + CHR(237) + "veis da movimenta" + CHR(231) + ;
1167:                     CHR(227) + "o:" + CHR(13) + loc_oErro.Message + CHR(13) + ;
1168:                     "Linha: " + TRANSFORM(loc_oErro.LineNo), "Erro")
1169:             loc_oForm = .NULL.
1170:         ENDTRY
1171: 
1172:         IF VARTYPE(loc_oForm) = "O"
1173:             loc_oForm.Show()
1174:         ENDIF
1175:     ENDPROC
1176: 
1177:     *==========================================================================
1178:     * BtnLiberarClick - Botao "..." de liberacao da consulta de TODOS os
1179:     * subniveis (legado: SIGOPPEN.BtnLiberar.Click).
1180:     *
1181:     * Legado: avisa que a liberacao exige autorizacao, chama o dialogo de
1182:     * senha de supervisor ("Do Form SigOpSen With 'LIBSUBN', ... To
1183:     * _Retorno"), aceita apenas retorno iniciado por "*" e, confirmada a
1184:     * autorizacao, recarrega a grade com o sexto parametro de "Carregar"
1185:     * ligado (LibPend = .T.).
1186:     *
1187:     * O SigOpSen do legado existe somente em C:\4install\FortyusMC\Fortyus\,
1188:     * fora do SET PATH montado pelo config.prg - a chamada estoura "File
1189:     * 'sigopsen.scx' does not exist". Sendo um gate de AUTORIZACAO, a falha eh
1190:     * tratada FAIL-CLOSED e VISIVEL: ausencia do dialogo = NAO autorizado,
1191:     * com o mesmo desfecho do "Autorizacao nao Confirmada" do legado. E
1192:     * PROIBIDO trocar por MsgConfirma ou por um caminho que simplesmente
1193:     * libere - seria conceder acesso sem senha, em silencio.
1194:     *==========================================================================
1195:     PROCEDURE BtnLiberarClick()
1196:         LOCAL loc_cRetorno, loc_cUsuLibs, loc_lAutorizado, loc_oErro
1197: 
1198:         loc_cRetorno    = ""
1199:         loc_cUsuLibs    = ""
1200:         loc_lAutorizado = .F.
1201: 
1202:         MsgAviso("Liberar Consulta de Todos Subn" + CHR(237) + "veis somente com " + ;
1203:                  "Autoriza" + CHR(231) + CHR(227) + "o!!", "ERRO")
1204: 
1205:         *-- TRY cobre SO a chamada do dialogo (regra #29): a avaliacao do
1206:         *-- retorno fica fora, para o fluxo nao depender do CATCH.
1207:         TRY
1208:             DO FORM SigOpSen WITH "LIBSUBN", ;
1209:                  "Libera Consulta de Todos Subn" + CHR(237) + "veis", "" TO loc_cRetorno
1210:         CATCH TO loc_oErro
1211:             loc_cRetorno = ""
1212:             MsgErro("O di" + CHR(225) + "logo de autoriza" + CHR(231) + CHR(227) + "o " + ;
1213:                     "(SigOpSen) n" + CHR(227) + "o est" + CHR(225) + " dispon" + CHR(237) + ;
1214:                     "vel neste ambiente, portanto a libera" + CHR(231) + CHR(227) + "o " + ;
1215:                     "foi NEGADA." + CHR(13) + loc_oErro.Message, "Autoriza" + CHR(231) + ;
1216:                     CHR(227) + "o Indispon" + CHR(237) + "vel")
1217:         ENDTRY
1218: 
1219:         IF VARTYPE(loc_cRetorno) = "C" AND LEFT(loc_cRetorno, 1) = "*"
1220:             loc_lAutorizado = .T.
1221:             loc_cUsuLibs    = SUBSTR(loc_cRetorno, 2, 10)
1222:         ENDIF
1223: 
1224:         IF !loc_lAutorizado
1225:             MsgAviso("Autoriza" + CHR(231) + CHR(227) + "o n" + CHR(227) + "o " + ;
1226:                      "Confirmada!!", "Aten" + CHR(231) + CHR(227) + "o")
1227:             RETURN
1228:         ENDIF
1229: 
1230:         IF EMPTY(loc_cUsuLibs)
1231:             RETURN
1232:         ENDIF
1233: 
1234:         *-- Autorizada: o legado zera TmpPends e refaz a carga com LibPend
1235:         *-- ligado. A flag fica no BO (this_lLibPend) para quando o filtro
1236:         *-- de acesso por empresa (fAcessoEmpresa, regra fundamental: fora
1237:         *-- de escopo sem o form chamador - ver nota de SIGOPPENBO.Buscar)
1238:         *-- for implementado; hoje SIGOPPENBO.Buscar() nao restringe por
1239:         *-- empresa, entao a flag ainda nao muda o resultado da consulta -
1240:         *-- recarregar aqui e necessario mesmo assim, pois sem isso o
1241:         *-- usuario autorizado via o mesmo ZAP sem reconsulta que deixava a
1242:         *-- grade vazia antes desta fase.
1243:         THIS.this_oBusinessObject.this_lLibPend = .T.
1244:         THIS.CarregarLista()
1245:     ENDPROC
1246: 
1247:     *==========================================================================
1248:     * CmdStatusClick - Dispatcher do grupo de status da Page2 (legado:
1249:     * Cnt_Status.Commandgroup1 - Command1=Aprovada, Command2=Reprovada,
1250:     * Command3=Cancelada). Cada ramo delega ao handler nomeado do botao,
1251:     * um para um com os tres Click do legado.
1252:     *==========================================================================
1253:     PROCEDURE CmdStatusClick(par_nValue)
1254:         DO CASE
1255:         CASE par_nValue = 1
1256:             THIS.BtnAprovarClick()
1257:         CASE par_nValue = 2
1258:             THIS.BtnReprovarClick()
1259:         CASE par_nValue = 3
1260:             THIS.BtnCancelarClick()
1261:         ENDCASE
1262:     ENDPROC
1263: 
1264:     *==========================================================================
1265:     * BtnAprovarClick / BtnReprovarClick / BtnCancelarClick - os tres botoes
1266:     * do grupo de status (legado: Cnt_Status.Commandgroup1.Command1.Click /
1267:     * Command2.Click / Command3.Click). Os tres compartilham o mesmo corpo no
1268:     * legado (monta a observacao, grava pStatus e devolve a Lista), variando
1269:     * so a posicao lida em StsGrvs e o texto do prefixo - por isso o corpo
1270:     * comum fica em AplicarStatusMovimento.
1271:     *==========================================================================
1272:     PROCEDURE BtnAprovarClick()
1273:         THIS.AplicarStatusMovimento(1)
1274:     ENDPROC
1275: 
1276:     PROCEDURE BtnReprovarClick()
1277:         THIS.AplicarStatusMovimento(2)
1278:     ENDPROC
1279: 
1280:     PROCEDURE BtnCancelarClick()
1281:         THIS.AplicarStatusMovimento(3)
1282:     ENDPROC
1283: 
1284:     *==========================================================================
1285:     * AplicarStatusMovimento - Corpo comum de Aprovar(1)/Reprovar(2)/
1286:     * Cancelar(3). Status gravado vem de SigOpCdd.StsGrvs (char(3)
1287:     * posicional - regra #42), carregado via SIGOPPENBO.CarregarConfigOperacao.
1288:     * Antes de chamar Atualizar(), repoe no BO os valores REAIS gravados em
1289:     * SigMvCab (CarregarDoCursor a partir de uma consulta fresca) - sem isso,
1290:     * Atualizar() reescreveria ChkSubn/ChkBxParcs com o default .F. das
1291:     * properties do BO (nunca carregadas para esta linha), corrompendo esses
1292:     * campos a cada aprovacao.
1293:     *==========================================================================
1294:     PROTECTED PROCEDURE AplicarStatusMovimento(par_nValue)
1295:         LOCAL loc_oPg, loc_oBO, loc_cBusca, loc_cSQL, loc_cObsAnterior, ;
1296:               loc_cObsNova, loc_cStatus
1297: 
1298:         loc_oPg = THIS.pgf_4c_Paginas.Page2
1299:         loc_oBO = THIS.this_oBusinessObject
1300: 
1301:         IF !USED("cursor_4c_Dados") OR EOF("cursor_4c_Dados")
1302:             RETURN
1303:         ENDIF
1304: 
1305:         *-- Reprovar/Cancelar exigem motivo preenchido (legado: Command2.
1306:         *-- Click/Command3.Click - MessageBox + Return quando txtObses esta
1307:         *-- vazio)
1308:         IF par_nValue = 2 AND EMPTY(loc_oPg.edt_4c_Observacoes.Value)
1309:             MsgAviso("Necess" + CHR(225) + "rio informar o motivo da reprova" + ;
1310:                      CHR(231) + CHR(227) + "o!", "Motivo N" + CHR(227) + "o Preenchido")
1311:             loc_oPg.edt_4c_Observacoes.SetFocus()
1312:             RETURN
1313:         ENDIF
1314: 
1315:         IF par_nValue = 3 AND EMPTY(loc_oPg.edt_4c_Observacoes.Value)
1316:             MsgAviso("Necess" + CHR(225) + "rio informar o motivo do cancelamento!", ;
1317:                      "Motivo N" + CHR(227) + "o Preenchido")
1318:             loc_oPg.edt_4c_Observacoes.SetFocus()
1319:             RETURN
1320:         ENDIF
1321: 
1322:         loc_cBusca = cursor_4c_Dados.Emps + cursor_4c_Dados.Dopes + STR(cursor_4c_Dados.Numes, 6)
1323: 
1324:         IF !loc_oBO.CarregarConfigOperacao(cursor_4c_Dados.Dopes)
1325:             RETURN
1326:         ENDIF
1327: 
1328:         *-- Repoe no BO os valores REAIS do registro (ver nota do cabecalho)
1329:         IF USED("cursor_4c_MovAtual")
1330:             USE IN cursor_4c_MovAtual
1331:         ENDIF
1332:         loc_cSQL = "SELECT * FROM SigMvCab WHERE EmpDopNums = " + EscaparSQL(loc_cBusca)
1333:         IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_MovAtual") < 0 OR ;
1334:            !USED("cursor_4c_MovAtual") OR RECCOUNT("cursor_4c_MovAtual") = 0
1335:             MsgErro("N" + CHR(227) + "o foi poss" + CHR(237) + "vel localizar a " + ;
1336:                     "movimenta" + CHR(231) + CHR(227) + "o para atualiza" + CHR(231) + ;
1337:                     CHR(227) + "o." + CHR(13) + CapturarErroSQL(), "Erro SQL")
1338:             IF USED("cursor_4c_MovAtual")
1339:                 USE IN cursor_4c_MovAtual
1340:             ENDIF
1341:             RETURN
1342:         ENDIF
1343:         loc_oBO.CarregarDoCursor("cursor_4c_MovAtual")
1344:         USE IN cursor_4c_MovAtual
1345: 
1346:         loc_cObsAnterior = ALLTRIM(TratarNulo(cursor_4c_Dados.Obss, "C"))
1347: 
1348:         DO CASE
1349:         CASE par_nValue = 1
1350:             loc_cStatus = SUBSTR(loc_oBO.this_cStsGrvs, 1, 1)
1351:             IF !EMPTY(loc_oPg.edt_4c_Observacoes.Value)
1352:                 loc_cObsNova = IIF(!EMPTY(loc_cObsAnterior), loc_cObsAnterior + CHR(13), "") + ;
1353:                                "Aprova" + CHR(231) + CHR(227) + "o : " + ;
1354:                                ALLTRIM(loc_oPg.edt_4c_Observacoes.Value) + " (" + ;
1355:                                ALLTRIM(gc_4c_UsuarioLogado) + ")"
1356:             ELSE
1357:                 loc_cObsNova = "Aprovado!"
1358:             ENDIF
1359: 
1360:         CASE par_nValue = 2
1361:             loc_cStatus  = SUBSTR(loc_oBO.this_cStsGrvs, 2, 1)

*-- Linhas 1374 a 1409:
1374: 
1375:         loc_oBO.this_cObses   = loc_cObsNova
1376:         loc_oBO.this_cPStatus = loc_cStatus
1377: 
1378:         IF loc_oBO.Atualizar()
1379:             REPLACE Obss WITH loc_cObsNova, pStatus WITH loc_cStatus IN cursor_4c_Dados
1380: 
1381:             IF par_nValue = 3
1382:                 REPLACE Flag WITH .F. IN cursor_4c_Dados
1383:             ENDIF
1384: 
1385:             THIS.pgf_4c_Paginas.Page1.grd_4c_Dados.Refresh()
1386:             MsgInfo("Status da movimenta" + CHR(231) + CHR(227) + "o atualizado com " + ;
1387:                     "sucesso!", "Confirmar")
1388:             THIS.AlternarPagina(1)
1389: 
1390:             IF loc_oBO.this_lGrvAutos
1391:                 THIS.Release()
1392:             ENDIF
1393:         ENDIF
1394:     ENDPROC
1395: 
1396:     *==========================================================================
1397:     * BtnEncerrarStatusClick - Fecha o painel de Status sem gravar (legado:
1398:     * Cnt_Status.btnCancela.Click - desmarca a linha e devolve a Lista).
1399:     *==========================================================================
1400:     PROCEDURE BtnEncerrarStatusClick()
1401:         IF USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados")
1402:             REPLACE Flag WITH .F. IN cursor_4c_Dados
1403:             THIS.pgf_4c_Paginas.Page1.grd_4c_Dados.Refresh()
1404:         ENDIF
1405: 
1406:         THIS.AlternarPagina(1)
1407:     ENDPROC
1408: 
1409: ENDDEFINE


### BO (C:\4c\projeto\app\classes\SIGOPPENBO.prg):
*==============================================================================
* SIGOPPENBO.prg - Business Object para Pendencias Em Subniveis (SIGOPPEN)
* Tabela principal: SigMvCab (cabecalho da movimentacao em aberto)
* Tabelas relacionadas: SigMvItn, SigCdOpe, SigCdEmp, SigCdPro, SigPrTrp,
*                        SigOpCdd, SigClJob, SigBxEst, SigSubMv
*==============================================================================

DEFINE CLASS SIGOPPENBO AS BusinessBase

    *-- Identificacao da movimentacao em aberto (SigMvCab) -------------------
    this_cEmps          = ""    && char(3)  - Empresa da movimentacao
    this_cDopes         = ""    && char(20) - Codigo da operacao (Dopes)
    this_nNumes         = 0     && numeric(6,0) - Numero sequencial da movimentacao
    this_cEmpDopNums    = ""    && char(29) - Chave combinada Emps+Dopes+Str(Numes,6)
    this_cCidChaves     = ""    && char(20) - Chave unica (PK de SigMvCab)
    this_cMascNum       = ""    && char(10) - Numero mascarado para exibicao em tela
    this_dDatas         = {}    && datetime - Data da movimentacao
    this_cNotas         = ""    && char(6)  - Numero da nota fiscal (legado)
    this_cNumeroNota    = ""    && char(10) - Numero da nota fiscal (NF-e)
    this_cPedidoWeb     = ""    && char(50) - Identificacao do pedido Web
    this_cIdTransp      = ""    && char(15) - Identificacao da transportadora
    this_cObsCabMovs    = ""    && char(40) - Observacao do cabecalho da movimentacao
    this_cObses         = ""    && text     - Observacoes gerais (memo)
    this_cPStatus       = ""    && char(1)  - Status de aprovacao da movimentacao
    this_cStatusAprRep  = ""    && char(1)  - Status aplicado na ultima Aprovacao/Reprovacao
    this_lChkSubn       = .F.   && bit      - Indica se ja foi baixada em subniveis
    this_lChkBxParcs    = .F.   && bit      - Indica baixa parcial permitida
    this_lChkQtdss      = .F.   && bit      - Indica conferencia de quantidades habilitada
    this_cGrupoOs       = ""    && char(10) - Grupo de origem
    this_cContaOs       = ""    && char(10) - Conta de origem
    this_cGrupoDs       = ""    && char(10) - Grupo de destino
    this_cContaDs       = ""    && char(10) - Conta de destino
    this_cGrResps       = ""    && char(10) - Grupo responsavel
    this_cVends         = ""    && char(10) - Responsavel/Vendedor
    this_dPrazoEnts     = {}    && datetime - Prazo de entrega
    this_nValOs         = 0     && numeric(11,2) - Valor da operacao de origem

    *-- Configuracao da operacao vigente (SigCdOpe / SigOpCdd) --------------
    this_cDopesAtual    = ""    && char(20) - Operacao vigente sendo tratada
    this_nDopesNivel    = 0     && numeric  - Nivel da operacao (Nivels)
    this_cOpera         = ""    && char(1)  - Tipo de operacao (Opers)
    this_nPuxaOrigem    = 0     && numeric  - ConOSubs: forma de puxar origem
    this_nPuxaDestino   = 0     && numeric  - ConDSubs: forma de puxar destino
    this_cOpePad        = ""    && char(20) - Operacao padrao associada (OpePads)
    this_cOpePadC       = ""    && char(20) - Operacao padrao de componentes (OpePadcs)
    this_lBaixaSubN     = .F.   && bit      - BaixaSns: baixa automatica em subniveis
    this_lBxParc        = .F.   && bit      - BxParcials: permite baixa parcial
    this_lBxAutos       = .F.   && bit      - BxAutos: baixa automatica
    this_cCarOpCr       = ""    && char(1)  - Opcrs: tipo de carga de operacao credito
    this_nMarcaSubns    = 0     && numeric  - MarcaSubns: marca subniveis ao localizar
    this_nCupFis        = 0     && numeric(1,0) - CupFis: tipo de cupom fiscal
    this_nDigItens      = 0     && numeric  - DigItens: permite digitar itens manualmente
    this_nVars          = 0     && numeric(9,4) - Vars: variacao percentual da operacao
    this_cCfos          = ""    && char     - Cfos: codigo fiscal da operacao
    this_nNDopes        = 0     && numeric  - nDopes: nivel numerico da operacao
    this_nParcs         = 0     && numeric  - parcs: quantidade de parcelas
    this_cCMoes         = ""    && char(3)  - cMoes: moeda da operacao
    this_nNDdVals       = 0     && numeric  - nDdVals: dias de vencimento padrao
    this_lValpres       = .F.   && bit      - Valpres: valores pre-definidos
    this_cCadprods      = ""    && char     - cadprods: cadastra produto na operacao

    *-- Filtros e parametros de tela (Init/Carregar do legado) --------------
    this_nMeses         = 0     && numeric  - Qtd. de meses do filtro de periodo
    this_dAntValue      = {}    && date     - Valor anterior do filtro de meses
    this_lLibPend       = .F.   && logical  - Libera visualizacao de subniveis bloqueados
    this_lChkPends      = .F.   && logical  - Filtra apenas pendencias marcadas
    this_lDdBloqueado   = .F.   && logical  - Indica filtro de datas bloqueado
    this_nNfServicos    = 0     && numeric  - Tipo de nota fiscal de servicos
    this_lBuscProd      = .F.   && logical  - Indica busca restrita por produto (pbusprod)
    this_lSelecStatus   = .F.   && logical  - Indica que o status foi selecionado no painel
    this_nItemMov       = 0     && numeric  - Item de movimentacao em edicao (ItemMov)
    this_cCfgTitOrigem      = "" && char   - Titulo configurado para "Origem"
    this_cCfgTitDestino     = "" && char   - Titulo configurado para "Destino"
    this_cCfgTitVendedor    = "" && char   - Titulo configurado para "Vendedor"
    this_cCfgTitResponsavel = "" && char   - Titulo configurado para "Responsavel"
    this_cCfgTitJob         = "" && char   - Titulo configurado para "Job"
    this_cCfgTitListaVends  = "" && char   - Titulo configurado para lista de vendedores
    this_cCodigo        = ""    && char    - Codigo digitado no filtro "Procura"
    this_cDoc           = ""    && char(6) - Documento digitado no filtro "Documento"
    this_cLocPed        = ""    && char    - Pedido/Localizacao digitada no filtro
    this_cCpros         = ""    && char(10)- Produto filtrado na pesquisa
    this_cIdTranspFiltro= ""    && char    - Transportadora filtrada na pesquisa
    this_lLiberaConsulta= .F.   && logical - Autorizacao para liberar consulta de subniveis

    *-- Itens da movimentacao (crTpmMvItn / SigMvItn) ------------------------
    this_nCItem         = 0     && numeric - Contador de itens no processo de carga
    this_nQtds          = 0     && numeric - Quantidade do item corrente
    this_nQtdsP         = 0     && numeric - Quantidade original do item (antes de ajuste)
    this_nValCars       = 0     && numeric - Valor carregado do item corrente
    this_nTotCar        = 0     && numeric - Total carregado (rateio de frete/despesas)
    this_nTotite        = 0     && numeric - Total de itens apos agrupamento

    *-- Configuracao de status de gravacao (SigOpCdd.StsGrvs/GrvAutos) ------
    this_cStsGrvs       = ""    && char(3) - pos1=Aprovado pos2=Reprovado pos3=Cancelado
    this_lGrvAutos      = .F.   && bit - fecha a tela automaticamente apos gravar o status

    *==========================================================================
    * Init - Inicializa o Business Object configurando tabela e campo chave
    *==========================================================================
    PROCEDURE Init()
        LOCAL loc_lResultado

        loc_lResultado = .F.

        TRY
            DODEFAULT()

            THIS.this_cTabela     = "SigMvCab"
            THIS.this_cCampoChave = "EmpDopNums"

            THIS.this_nMeses  = 0
            THIS.this_dAntValue = DATE()

            loc_lResultado = .T.

        CATCH TO loc_oErro
            MsgErro("Erro ao inicializar SIGOPPENBO: " + loc_oErro.Message, "Erro")
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * ObterChavePrimaria - Retorna a chave usada nos UPDATE/auditoria (EmpDopNums,
    * o this_cCampoChave configurado no Init). char(29) posicional (Emps+Dopes+
    * Str(Numes,6)) lido direto da coluna - ALLTRIM na chave INTEIRA eh inofensivo
    * (char no SQL Server compara com blank-padding ANSI); regra #42 so proibe
    * ALLTRIM nas PARTES internas de uma montagem manual.
    *==========================================================================
    PROTECTED PROCEDURE ObterChavePrimaria()
        RETURN ALLTRIM(THIS.this_cEmpDopNums)
    ENDPROC

    *==========================================================================
    * CarregarDoCursor - Mapeia campos de SigMvCab (cabecalho da movimentacao
    * em aberto) do cursor informado para as propriedades do BO.
    * this_cStatusAprRep (status aplicado na ultima Aprovacao/Reprovacao) e
    * this_lChkQtdss (ChkQtdss) NAO sao colunas de SigMvCab - o primeiro eh
    * variavel de trabalho do form, o segundo vem da config da operacao em
    * SigCdOpe - por isso ficam fora deste mapeamento.
    *==========================================================================
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        IF USED(par_cAliasCursor) AND !EOF(par_cAliasCursor)
            SELECT (par_cAliasCursor)

            THIS.this_cEmps        = ALLTRIM(TratarNulo(Emps,       "C"))
            THIS.this_cDopes       = ALLTRIM(TratarNulo(Dopes,      "C"))
            THIS.this_nNumes       = TratarNulo(Numes,              "N")
            THIS.this_cEmpDopNums  = ALLTRIM(TratarNulo(EmpDopNums, "C"))
            THIS.this_cCidChaves   = ALLTRIM(TratarNulo(CidChaves,  "C"))
            THIS.this_cMascNum     = ALLTRIM(TratarNulo(MascNum,    "C"))
            THIS.this_dDatas       = ConverterParaData(TratarNulo(Datas, "D"))
            THIS.this_cNotas       = ALLTRIM(TratarNulo(Notas,       "C"))
            THIS.this_cNumeroNota  = ALLTRIM(TratarNulo(NumeroNota,  "C"))
            THIS.this_cPedidoWeb   = ALLTRIM(TratarNulo(PedidoWeb,   "C"))
            THIS.this_cIdTransp    = ALLTRIM(TratarNulo(IdTransp,    "C"))
            THIS.this_cObsCabMovs  = ALLTRIM(TratarNulo(ObsCabMovs,  "C"))
            THIS.this_cObses       = TratarNulo(Obses, "C")
            THIS.this_cPStatus     = ALLTRIM(TratarNulo(PStatus,     "C"))
            THIS.this_lChkSubn     = ConverterParaLogico(ChkSubn)
            THIS.this_lChkBxParcs  = ConverterParaLogico(ChkBxParcs)
            THIS.this_cGrupoOs     = ALLTRIM(TratarNulo(GrupoOs,     "C"))
            THIS.this_cContaOs     = ALLTRIM(TratarNulo(ContaOs,     "C"))
            THIS.this_cGrupoDs     = ALLTRIM(TratarNulo(GrupoDs,     "C"))
            THIS.this_cContaDs     = ALLTRIM(TratarNulo(ContaDs,     "C"))
            THIS.this_cGrResps     = ALLTRIM(TratarNulo(GrResps,     "C"))
            THIS.this_cVends       = ALLTRIM(TratarNulo(Vends,       "C"))
            THIS.this_dPrazoEnts   = ConverterParaData(TratarNulo(PrazoEnts, "D"))
            THIS.this_nValOs       = TratarNulo(ValOs, "N")

            THIS.this_lNovoRegistro = .F.
            loc_lSucesso = .T.
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * Inserir - Mantem o comportamento padrao herdado de BusinessBase (recusa a
    * operacao). Conferido no codigo fonte legado (SIGOPPEN_form_codigo_fonte.txt)
    * e no comportamento.json: a tela so aprova/reprova/cancela/baixa movimentos
    * EM ABERTO que ja existem em SigMvCab (varios "Update SigMvCab Set ...") -
    * em nenhum ponto o legado faz "Insert Into SigMvCab". Sobrescrever Inserir()
    * aqui exigiria inventar valores para as ~140 colunas NOT NULL de SigMvCab
    * que esta tela nunca grava, violando o PILAR 2 (schema identico) e o
    * PILAR 1 (a tela nao cria movimentacao nova).
    *==========================================================================

    *==========================================================================
    * Atualizar - UPDATE SigMvCab com os campos que as acoes de Aprovar/
    * Reprovar/Cancelar/Baixar Subnivel do legado alteram (Cnt_Status.
    * Commandgroup1.Click Command1/2/3 e o fluxo de SubNiveis), consolidados
    * num unico UPDATE pela chave EmpDopNums.
    *==========================================================================
    PROCEDURE Atualizar()
        LOCAL loc_lSucesso, loc_lContinuar, loc_cSQL, loc_cChave, loc_oErro
        loc_lSucesso   = .F.
        loc_lContinuar = .T.

        TRY
            loc_cChave = THIS.ObterChavePrimaria()

            IF EMPTY(loc_cChave)
                MsgErro("Chave do movimento (EmpDopNums) n" + CHR(227) + "o definida " + ;
                        "para atualiza" + CHR(231) + CHR(227) + "o.", "Erro")
                loc_lContinuar = .F.
            ENDIF

            IF loc_lContinuar
                loc_cSQL = "UPDATE SigMvCab SET " + ;
                           "Usuals = "     + EscaparSQL(PADR(gc_4c_UsuarioLogado, 10)) + ", " + ;
                           "DtAlts = GETDATE(), " + ;
                           "Obses = "      + EscaparSQL(THIS.this_cObses) + ", " + ;
                           "pStatus = "    + EscaparSQL(PADR(THIS.this_cPStatus, 1)) + ", " + ;
                           "ChkSubn = "    + IIF(THIS.this_lChkSubn, "1", "0") + ", " + ;
                           "ChkBxParcs = " + IIF(THIS.this_lChkBxParcs, "1", "0") + ", " + ;
                           "DtBaixas = "   + IIF(THIS.this_lChkSubn, "GETDATE()", "NULL") + " " + ;
                           "WHERE EmpDopNums = " + EscaparSQL(loc_cChave)

                IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Upd") >= 0
                    THIS.RegistrarAuditoria("UPDATE")
                    loc_lSucesso = .T.
                ELSE
                    MsgErro("Falha ao atualizar a pend" + CHR(234) + "ncia em subn" + ;
                            CHR(237) + "veis." + CHR(13) + CapturarErroSQL(), "Erro SQL")
                ENDIF

                IF USED("cursor_4c_Upd")
                    USE IN cursor_4c_Upd
                ENDIF
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo), "Erro SIGOPPENBO.Atualizar")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * Buscar - Carrega a worklist de pendencias em subniveis (Page1/
    * grd_4c_Dados) a partir de SigMvCab. Equivalente REDUZIDO do metodo
    * "Carregar" do legado (SIGOPPEN_form_codigo_fonte.txt, PROCEDURE
    * carregar, ~650 linhas).
    *
    * ESCOPO DELIBERADAMENTE REDUZIDO (documentado, NAO omitido em
    * silencio - REGRA FUNDAMENTAL do CLAUDE.md): o "Carregar" legado so
    * roda dentro de um dialogo FILHO aberto por uma tela de movimentacao
    * especifica ("Do Form SigOpPen With ThisForm, ..."), que fixa a
    * variavel de modulo TprMvCab (cabecalho da movimentacao do
    * CHAMADOR) e carrega quatro cursores de configuracao POR OPERACAO
    * (crSigCdOpe/CrSigOpCdc/CrSigOpCdd/CrSigOpCdI) antes de montar a
    * consulta - sao eles que decidem, operacao por operacao, qual conta
    * vale como "origem"/"destino" (_PuxaOrigem/_PuxaDestino), quais
    * status ficam visiveis (StsSubs), o filtro de acesso por empresa
    * (fAcessoEmpresa) e o agrupamento por nivel de subnivel (SigOpCsn).
    * Esta task expoe FormSIGOPPEN como tela INDEPENDENTE no menu
    * (popMovimentos - "Pendencias em Subniveis"), sem nenhum form
    * chamador: TprMvCab e crSigCdOpe NUNCA existem neste caminho, e
    * fabricar os dois so para preencher o metodo seria inventar regra
    * de negocio (tambem PROIBIDO pelo CLAUDE.md).
    *
    * O que fica, fiel ao legado e sem depender do contexto ausente: a
    * condicao-base de pendencia - "ChkSubn = 0" - eh, em TODA variante
    * do WHERE do legado, o filtro que sempre aparece (Iif(crSigCdOpe.
    * Subns = 1,[a.ChkSubn = ?llsubnt And ],...) com llsubnt = .F." -
    * aqui aplicada a TODAS as operacoes de uma vez, no lugar de uma
    * unica operacao escolhida pelo form chamador. Origem/Destino usam
    * Grupo+Conta diretos de SigMvCab (sem o desvio _PuxaOrigem/
    * _PuxaDestino, que depende de configuracao por operacao) e a
    * descricao da conta vem de SigCdCli.Rclis - mesma tabela/coluna que
    * o legado consulta por CrEest.ContaOs/contads (dump, linha ~3480).
    *==========================================================================
    PROCEDURE Buscar(par_cFiltro)
        LOCAL loc_lSucesso, loc_cSQL, loc_cFiltro, loc_oErro
        loc_lSucesso = .F.
        loc_cFiltro  = TratarNulo(par_cFiltro, "C")

        TRY
            IF USED("cursor_4c_DadosTmp")
                USE IN cursor_4c_DadosTmp
            ENDIF

            loc_cSQL = "SELECT a.Emps, a.Dopes, a.Numes, a.MascNum, a.Datas, a.TpFats, " + ;
                       "RTRIM(a.GrupoOs) + '/' + RTRIM(a.ContaOs) AS Origem, " + ;
                       "RTRIM(a.GrupoDs) + '/' + RTRIM(a.ContaDs) AS Destino, " + ;
                       "a.Valos, a.Notas, a.ChkSubn AS ChkSubN, " + ;
                       "CONVERT(VARCHAR(8000), a.Obses) AS Obss, " + ;
                       "ISNULL(co.Rclis, '') AS DescsO, ISNULL(cd.Rclis, '') AS DescsD, " + ;
                       "LEFT(a.CidChaves, 10) AS cIdChaves, a.Usuars, a.EmpDs, a.pStatus, " + ;
                       "a.PrazoEnts AS DtEnts, a.ObsCabMovs, a.Jobs, a.PedidoWeb, " + ;
                       "a.IDEntrega, a.ChaveNota, a.IDTransp, a.NumeroNota, a.EmpRet " + ;
                       "FROM SigMvCab a " + ;
                       "LEFT JOIN SigCdCli co ON co.Iclis = a.ContaOs " + ;
                       "LEFT JOIN SigCdCli cd ON cd.Iclis = a.ContaDs " + ;
                       "WHERE a.ChkSubn = 0"

            IF !EMPTY(loc_cFiltro)
                loc_cSQL = loc_cSQL + " AND (" + loc_cFiltro + ")"
            ENDIF

            loc_cSQL = loc_cSQL + " ORDER BY a.Datas, a.Emps, a.Dopes, a.Numes"

            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_DadosTmp") >= 0
                IF USED("cursor_4c_Dados")
                    SELECT cursor_4c_Dados
                    ZAP
                    IF USED("cursor_4c_DadosTmp") AND RECCOUNT("cursor_4c_DadosTmp") > 0
                        APPEND FROM DBF("cursor_4c_DadosTmp")
                    ENDIF
                    GO TOP IN cursor_4c_Dados
                ENDIF
                loc_lSucesso = .T.
            ELSE
                MsgErro("Falha ao buscar pend" + CHR(234) + "ncias em subn" + CHR(237) + ;
                        "veis." + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

            IF USED("cursor_4c_DadosTmp")
                USE IN cursor_4c_DadosTmp
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo), "Erro SIGOPPENBO.Buscar")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * CarregarConfigOperacao - Le StsGrvs/GrvAutos de SigOpCdd para a operacao
    * informada. StsGrvs eh char(3) posicional: pos1 = status gravado ao
    * Aprovar, pos2 = status gravado ao Reprovar, pos3 = status gravado ao
    * Cancelar (legado: Cnt_Status.Commandgroup1.Command1/2/3.Click -
    * Substr(crSigOpCdd.StsGrvs, 1|2|3, 1)). Usado pelo form antes de montar
    * o UPDATE de aprovacao/reprovacao/cancelamento.
    *==========================================================================
    PROCEDURE CarregarConfigOperacao(par_cDopes)
        LOCAL loc_lSucesso, loc_cSQL, loc_oErro
        loc_lSucesso = .F.

        TRY
            THIS.this_cStsGrvs  = ""
            THIS.this_lGrvAutos = .F.

            IF USED("cursor_4c_CfgOpe")
                USE IN cursor_4c_CfgOpe
            ENDIF

            loc_cSQL = "SELECT StsGrvs, GrvAutos FROM SigOpCdd " + ;
                       "WHERE Dopes = " + EscaparSQL(PADR(par_cDopes, 20))

            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_CfgOpe") >= 0
                IF USED("cursor_4c_CfgOpe") AND RECCOUNT("cursor_4c_CfgOpe") > 0
                    SELECT cursor_4c_CfgOpe
                    GO TOP
                    THIS.this_cStsGrvs  = PADR(TratarNulo(StsGrvs, "C"), 3)
                    THIS.this_lGrvAutos = (TratarNulo(GrvAutos, "N") = 1)
                    loc_lSucesso = .T.
                ELSE
                    MsgErro("Configura" + CHR(231) + CHR(227) + "o da opera" + CHR(231) + ;
                            CHR(227) + "o " + ALLTRIM(par_cDopes) + " n" + CHR(227) + ;
                            "o encontrada em SigOpCdd.", "Erro")
                ENDIF
            ELSE
                MsgErro("Falha ao carregar a configura" + CHR(231) + CHR(227) + "o da " + ;
                        "opera" + CHR(231) + CHR(227) + "o." + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

            IF USED("cursor_4c_CfgOpe")
                USE IN cursor_4c_CfgOpe
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo), "Erro SIGOPPENBO.CarregarConfigOperacao")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

ENDDEFINE


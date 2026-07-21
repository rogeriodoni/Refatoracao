# CODE REVIEW - PASS FUNCTIONAL: Functional Logic (metodos, eventos, containers)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Functional Logic (metodos, eventos, containers)**.

## PROBLEMAS DETECTADOS (1)
- [METODO-INEXISTENTE] Metodo 'THIS.Controls()' chamado mas NAO definido como PROCEDURE no Form nem herdado de FormBase. A LLM pode ter inventado este metodo. VERIFICAR se existe no legado e IMPLEMENTAR ou REMOVER a chamada.

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

### FORM (C:\4c\projeto\app\forms\operacionais\FormSigPrRss.prg) - TRECHOS RELEVANTES PARA PASS FUNCTIONAL (630 linhas total):

*-- Linhas 35 a 145:
35:     this_lErroConexao   = .F.       && .T. se houve queda de conexao com BD
36: 
37:     *==========================================================================
38:     PROCEDURE Init(par_pParam, par_pUsuario, par_pOnLine)
39:     *==========================================================================
40:         *-- DataSession=2 reseta SET DATE/CENTURY (regra 9.4)
41:         SET DATE TO BRITISH
42:         SET CENTURY ON
43: 
44:         *-- Capturar parametros antes de DODEFAULT
45:         THIS.this_lParametrizado = (TYPE("par_pParam")   = "C")
46:         THIS.this_cUsuario       = IIF(TYPE("par_pUsuario") = "C", par_pUsuario, SPACE(10))
47:         THIS.this_lOnline        = (TYPE("par_pOnLine")   = "L" AND par_pOnLine)
48: 
49:         *-- DODEFAULT() chama FormBase.Init() -> InicializarForm()
50:         RETURN DODEFAULT()
51:     ENDPROC
52: 
53:     *==========================================================================
54:     PROTECTED PROCEDURE InicializarForm
55:     *==========================================================================
56:         LOCAL loc_lSucesso, loc_oErro
57:         loc_lSucesso = .F.
58: 
59:         TRY
60:             THIS.this_oBusinessObject = CREATEOBJECT("SigPrRssBO")
61:             IF VARTYPE(THIS.this_oBusinessObject) # "O"
62:                 MsgErro("Erro ao criar objeto de neg" + CHR(243) + "cio SigPrRssBO.", "Erro")
63:             ELSE
64:                 *-- Background do form (como no original)
65:                 THIS.Picture = gc_4c_CaminhoBase + "..\..\..\Framework\imagens\new_background.jpg"
66: 
67:                 *-- Montar interface visual (form OPERACIONAL: layout direto no form, sem PageFrame)
68:                 THIS.ConfigurarPageFrame()
69:                 THIS.TornarControlesVisiveis()
70: 
71:                 *-- Sincronizar caption das labels com o titulo do form
72:                 THIS.cnt_4c_Sombra.lbl_4c_Sombra.Caption = THIS.Caption
73:                 THIS.cnt_4c_Sombra.lbl_4c_Titulo.Caption = THIS.Caption
74: 
75:                 IF THIS.this_lParametrizado
76:                     THIS.IniciarLogProcessamento()
77:                 ENDIF
78: 
79:                 loc_lSucesso = .T.
80:             ENDIF
81:         CATCH TO loc_oErro
82:             MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
83:                 " PROC=" + loc_oErro.Procedure, "Erro FormSigPrRss.InicializarForm")
84:         ENDTRY
85: 
86:         RETURN loc_lSucesso
87:     ENDPROC
88: 
89:     *==========================================================================
90:     * ConfigurarPageFrame - Entry point de layout do form OPERACIONAL
91:     * Form OPERACIONAL nao usa PageFrame (dialog 580x120 com controles diretos)
92:     * Metodo mantido para consistencia com pipeline de migracao e centraliza
93:     * chamadas de setup visual do form.
94:     *==========================================================================
95:     PROTECTED PROCEDURE ConfigurarPageFrame
96:         THIS.ConfigurarCabecalho()
97:         THIS.ConfigurarBotoes()
98:         THIS.ConfigurarStatusLabel()
99:     ENDPROC
100: 
101:     *==========================================================================
102:     * ConfigurarCabecalho - Container escuro com titulo (cntSombra original)
103:     * Padrao correto: AddObject fora do WITH para evitar WITH aninhado (Erro47)
104:     *==========================================================================
105:     PROTECTED PROCEDURE ConfigurarCabecalho
106:         THIS.AddObject("cnt_4c_Sombra", "Container")
107:         WITH THIS.cnt_4c_Sombra
108:             .Visible     = .T.
109:             .Top         = 0
110:             .Left        = 0
111:             .Width       = THIS.Width
112:             .Height      = 80
113:             .BorderWidth = 0
114:             .BackColor   = RGB(100,100,100)
115:         ENDWITH
116: 
117:         THIS.cnt_4c_Sombra.AddObject("lbl_4c_Sombra", "Label")
118:         WITH THIS.cnt_4c_Sombra.lbl_4c_Sombra
119:             .Visible       = .T.
120:             .Top           = 18
121:             .Left          = 10
122:             .Width         = THIS.Width
123:             .Height        = 40
124:             .Caption       = THIS.Caption
125:             .FontBold      = .T.
126:             .FontName      = "Tahoma"
127:             .FontSize      = 18
128:             .FontUnderline = .F.
129:             .WordWrap      = .T.
130:             .Alignment     = 0
131:             .AutoSize      = .F.
132:             .BackStyle     = 0
133:             .ForeColor     = RGB(0,0,0)
134:         ENDWITH
135: 
136:         THIS.cnt_4c_Sombra.AddObject("lbl_4c_Titulo", "Label")
137:         WITH THIS.cnt_4c_Sombra.lbl_4c_Titulo
138:             .Visible    = .T.
139:             .Top        = 17
140:             .Left       = 10
141:             .Width      = THIS.Width
142:             .Height     = 46
143:             .Caption    = THIS.Caption
144:             .FontBold   = .T.
145:             .FontName   = "Tahoma"

*-- Linhas 155 a 322:
155:     *==========================================================================
156:     * ConfigurarBotoes - Botoes Processar (OK) e Encerrar (SAIR) + Shape decorativo
157:     *==========================================================================
158:     PROTECTED PROCEDURE ConfigurarBotoes
159:         *-- Shape decorativo (Shape1: Top=7, Left=478, Width=90, Height=27)
160:         THIS.AddObject("shp_4c_Shape1", "Shape")
161:         WITH THIS.shp_4c_Shape1
162:             .Top         = 7
163:             .Left        = 478
164:             .Height      = 27
165:             .Width       = 90
166:             .BackStyle   = 0
167:             .BorderStyle = 0
168:             .BorderColor = RGB(136,189,188)
169:         ENDWITH
170: 
171:         *-- Botao Processar (OK no legado: Left=430, Top=3, 75x75)
172:         *-- Themes=.T. + DisabledPicture: necessario para standalone com Enabled=.F. (regra #99)
173:         THIS.AddObject("cmd_4c_Processar", "CommandButton")
174:         WITH THIS.cmd_4c_Processar
175:             .Top             = 3
176:             .Left            = 430
177:             .Width           = 75
178:             .Height          = 75
179:             .Caption         = "Processar"
180:             .FontName        = "Tahoma"
181:             .FontSize        = 8
182:             .FontBold        = .T.
183:             .FontItalic      = .T.
184:             .ForeColor       = RGB(90,90,90)
185:             .BackColor       = RGB(255,255,255)
186:             .Themes          = .T.
187:             .SpecialEffect   = 0
188:             .PicturePosition = 13
189:             .WordWrap        = .T.
190:             .AutoSize        = .F.
191:             .MousePointer    = 15
192:             .Picture         = gc_4c_CaminhoIcones + "geral_processar_60.jpg"
193:             .DisabledPicture = gc_4c_CaminhoIcones + "geral_processar_60.jpg"
194:             .ToolTipText     = ""
195:         ENDWITH
196:         BINDEVENT(THIS.cmd_4c_Processar, "Click", THIS, "BtnProcessarClick")
197: 
198:         *-- Botao Encerrar (SAIR no legado: Left=505, Top=3, 75x75)
199:         THIS.AddObject("cmd_4c_Encerrar", "CommandButton")
200:         WITH THIS.cmd_4c_Encerrar
201:             .Top             = 3
202:             .Left            = 505
203:             .Width           = 75
204:             .Height          = 75
205:             .Caption         = "Encerrar"
206:             .FontName        = "Tahoma"
207:             .FontSize        = 8
208:             .FontBold        = .T.
209:             .FontItalic      = .T.
210:             .ForeColor       = RGB(90,90,90)
211:             .BackColor       = RGB(255,255,255)
212:             .Themes           = .T.
213:             .SpecialEffect   = 0
214:             .PicturePosition = 13
215:             .WordWrap        = .T.
216:             .AutoSize        = .F.
217:             .MousePointer    = 15
218:             .Cancel          = .T.
219:             .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
220:             .ToolTipText     = "[ESC] Sair"
221:         ENDWITH
222:         BINDEVENT(THIS.cmd_4c_Encerrar, "Click", THIS, "BtnEncerrarClick")
223:     ENDPROC
224: 
225:     *==========================================================================
226:     * ConfigurarStatusLabel - Label de progresso (Label1 original: Top=94, Left=135)
227:     *==========================================================================
228:     PROTECTED PROCEDURE ConfigurarStatusLabel
229:         THIS.AddObject("lbl_4c_Status", "Label")
230:         WITH THIS.lbl_4c_Status
231:             .Visible   = .T.
232:             .Top       = 94
233:             .Left      = 135
234:             .Width     = 309
235:             .Height    = 20
236:             .Caption   = ""
237:             .FontBold  = .T.
238:             .FontName  = "Tahoma"
239:             .FontSize  = 8
240:             .BackStyle = 0
241:             .ForeColor = RGB(90,90,90)
242:         ENDWITH
243:     ENDPROC
244: 
245:     *==========================================================================
246:     * TornarControlesVisiveis - Torna todos controles do form e sub-containers visiveis
247:     *==========================================================================
248:     PROTECTED PROCEDURE TornarControlesVisiveis
249:         LOCAL loc_i, loc_j, loc_oControl, loc_oSub
250:         FOR loc_i = 1 TO THIS.ControlCount
251:             loc_oControl = THIS.Controls(loc_i)
252:             IF VARTYPE(loc_oControl) = "O"
253:                 IF PEMSTATUS(loc_oControl, "Visible", 5)
254:                     loc_oControl.Visible = .T.
255:                 ENDIF
256:                 IF PEMSTATUS(loc_oControl, "ControlCount", 5) AND loc_oControl.ControlCount > 0
257:                     FOR loc_j = 1 TO loc_oControl.ControlCount
258:                         loc_oSub = loc_oControl.Controls(loc_j)
259:                         IF VARTYPE(loc_oSub) = "O" AND PEMSTATUS(loc_oSub, "Visible", 5)
260:                             loc_oSub.Visible = .T.
261:                         ENDIF
262:                     ENDFOR
263:                 ENDIF
264:             ENDIF
265:         ENDFOR
266:     ENDPROC
267: 
268:     *==========================================================================
269:     * Activate - Se modo batch, inicia processamento automaticamente
270:     *==========================================================================
271:     PROCEDURE Activate
272:         DODEFAULT()
273:         IF THIS.this_lParametrizado
274:             THIS.BtnProcessarClick()
275:         ENDIF
276:     ENDPROC
277: 
278:     *==========================================================================
279:     * BtnProcessarClick - Loop principal de recalculo de saldos
280:     * Migrado de: SIGPRRSS.OK.Click (157 linhas)
281:     *==========================================================================
282:     PROCEDURE BtnProcessarClick
283:         LOCAL loc_lOk, loc_lErroCnx, loc_nMov, loc_oBO
284:         LOCAL loc_nKey, loc_nErr, loc_cOldErr, loc_lQuit
285:         loc_oBO      = THIS.this_oBusinessObject
286:         loc_lErroCnx = .F.
287:         loc_nMov     = 1
288: 
289:         THIS.cmd_4c_Processar.Enabled = .F.
290:         THIS.this_lProcessando = .T.
291: 
292:         DO WHILE .T.
293:             THIS.cmd_4c_Encerrar.Enabled = .F.
294: 
295:             THIS.lbl_4c_Status.Caption = "Aguardando Contas Para Processar" + ;
296:                 REPLICATE(".", loc_nMov)
297:             loc_nMov = IIF(loc_nMov < 5, loc_nMov + 1, 1)
298:             THIS.lbl_4c_Status.Refresh()
299: 
300:             *-- Buscar registros em fila SigOpCls
301:             loc_lOk = loc_oBO.BuscarNaFila(ALLTRIM(THIS.this_cUsuario), THIS.this_lOnline)
302: 
303:             IF !loc_lOk
304:                 loc_lErroCnx = .T.
305:             ELSE
306:                 SELECT CrSigOpCls
307:                 SCAN
308:                     *-- Marcar registro em processamento (lock otimista)
309:                     IF !loc_oBO.MarcarProcessando(CrSigOpCls.CidChaves)
310:                         *-- Verificar se e queda de conexao
311:                         IF SQLEXEC(gnConnHandle, "SELECT 1 AS Chk") < 0
312:                             EXIT
313:                         ENDIF
314:                         LOOP
315:                     ENDIF
316: 
317:                     IF USED("crRecalculaS")
318:                         USE IN crRecalculaS
319:                     ENDIF
320: 
321:                     *-- Recalcular saldo do lancamento
322:                     loc_lOk = loc_oBO.RecalcularSaldo(CrSigOpCls.Grupos, ;

*-- Linhas 386 a 630:
386:     *==========================================================================
387:     * BtnEncerrarClick - Fecha o formulario
388:     *==========================================================================
389:     PROCEDURE BtnEncerrarClick
390:         THIS.Release()
391:     ENDPROC
392: 
393:     *==========================================================================
394:     * IniciarLogProcessamento - Cabecalho do log Fortyus.Log (modo batch)
395:     *==========================================================================
396:     PROTECTED PROCEDURE IniciarLogProcessamento
397:         LOCAL loc_cArq, loc_cLinha
398:         loc_cArq = "Fortyus.Log"
399:         STRTOFILE("", loc_cArq, .T.)
400:         loc_cLinha = REPLICATE("=", 80)
401:         STRTOFILE(loc_cLinha + CHR(10), loc_cArq, .T.)
402:         loc_cLinha = "Iniciando o Processamento : Fortyus.Exe (SigOpClS) - Rec" + ;
403:             CHR(225) + "lculo de Saldos"
404:         STRTOFILE(loc_cLinha + CHR(10), loc_cArq, .T.)
405:         loc_cLinha = "Data : " + DTOC(DATE()) + " - Hora : " + TIME()
406:         STRTOFILE(loc_cLinha + CHR(10), loc_cArq, .T.)
407:         loc_cLinha = REPLICATE("=", 80)
408:         STRTOFILE(loc_cLinha + CHR(10), loc_cArq, .T.)
409:     ENDPROC
410: 
411:     *==========================================================================
412:     * FinalizarLogProcessamento - Rodape do log Fortyus.Log (modo batch)
413:     *==========================================================================
414:     PROTECTED PROCEDURE FinalizarLogProcessamento
415:         LOCAL loc_cArq, loc_cLinha
416:         loc_cArq = "Fortyus.Log"
417:         STRTOFILE("", loc_cArq, .T.)
418:         loc_cLinha = REPLICATE("=", 80)
419:         STRTOFILE(loc_cLinha + CHR(10), loc_cArq, .T.)
420:         loc_cLinha = "Concluindo o Processamento : Fortyus.Exe (SigOpClS) - Rec" + ;
421:             CHR(225) + "lculo de Saldos"
422:         STRTOFILE(loc_cLinha + CHR(10), loc_cArq, .T.)
423:         loc_cLinha = "Data : " + DTOC(DATE()) + " - Hora : " + TIME()
424:         STRTOFILE(loc_cLinha + CHR(10), loc_cArq, .T.)
425:         loc_cLinha = REPLICATE("=", 80)
426:         STRTOFILE(loc_cLinha + CHR(10), loc_cArq, .T.)
427:     ENDPROC
428: 
429:     *==========================================================================
430:     * ConfigurarPaginaLista - No-op semantico para form OPERACIONAL
431:     * Este dialog (580x120) nao tem PageFrame/Grid/CRUD. O layout eh direto no
432:     * form (cabecalho + botao Processar + botao Encerrar + label status), ja
433:     * montado por ConfigurarPageFrame(). Metodo mantido para compatibilidade
434:     * com a validacao do pipeline (fase 4 checa presenca do simbolo).
435:     *==========================================================================
436:     PROTECTED PROCEDURE ConfigurarPaginaLista
437:         *-- Form OPERACIONAL: sem Page1/Lista. Setup ja feito em ConfigurarPageFrame().
438:         RETURN .T.
439:     ENDPROC
440: 
441:     *==========================================================================
442:     * ConfigurarPaginaDados - No-op semantico para form OPERACIONAL
443:     * Este dialog (580x120) nao tem Page2/Dados. Nao ha campos de entrada
444:     * a adicionar - todos os controles (cabecalho, botoes, label de status)
445:     * ja foram montados em ConfigurarPageFrame() nas fases anteriores.
446:     * Metodo mantido para compatibilidade com a validacao do pipeline (fase 5).
447:     *==========================================================================
448:     PROTECTED PROCEDURE ConfigurarPaginaDados
449:         *-- Form OPERACIONAL: sem Page2/Dados. Setup ja feito em ConfigurarPageFrame().
450:         RETURN .T.
451:     ENDPROC
452: 
453:     *==========================================================================
454:     * AlternarPagina - No-op semantico para form OPERACIONAL
455:     * Este dialog tem estado unico (nao alterna entre LISTA/DADOS). A logica
456:     * de fluxo eh controlada por this_lProcessando (habilitando/desabilitando
457:     * cmd_4c_Processar e cmd_4c_Encerrar dentro de BtnProcessarClick).
458:     *==========================================================================
459:     PROTECTED PROCEDURE AlternarPagina(par_nPagina)
460:         *-- Form OPERACIONAL: pagina unica, nenhuma alternancia necessaria.
461:         RETURN .T.
462:     ENDPROC
463: 
464:     *==========================================================================
465:     * BtnIncluirClick - No-op semantico para form OPERACIONAL
466:     * Este dialog de processamento em fila nao tem operacao de inclusao de
467:     * registros pelo usuario. Registros em SigOpCls sao inseridos pelo
468:     * sistema automaticamente. Metodo presente para compatibilidade com o
469:     * pipeline de validacao de fases.
470:     *==========================================================================
471:     PROCEDURE BtnIncluirClick
472:         *-- Form OPERACIONAL: inclusao gerenciada pelo sistema (fila SigOpCls).
473:         RETURN .T.
474:     ENDPROC
475: 
476:     *==========================================================================
477:     * BtnAlterarClick - No-op semantico para form OPERACIONAL
478:     * Este dialog executa processamento de fila; nao ha edicao manual de
479:     * registros. Metodo presente para compatibilidade com o pipeline de
480:     * validacao de fases.
481:     *==========================================================================
482:     PROCEDURE BtnAlterarClick
483:         *-- Form OPERACIONAL: sem edicao manual de registros.
484:         RETURN .T.
485:     ENDPROC
486: 
487:     *==========================================================================
488:     * BtnVisualizarClick - No-op semantico para form OPERACIONAL
489:     * Este dialog nao tem modo de visualizacao individual de registro.
490:     * O status do processamento e exibido em lbl_4c_Status em tempo real.
491:     * Metodo presente para compatibilidade com o pipeline de validacao de fases.
492:     *==========================================================================
493:     PROCEDURE BtnVisualizarClick
494:         *-- Form OPERACIONAL: status de processamento exibido via lbl_4c_Status.
495:         RETURN .T.
496:     ENDPROC
497: 
498:     *==========================================================================
499:     * BtnExcluirClick - No-op semantico para form OPERACIONAL
500:     * Registros sao removidos de SigOpCls automaticamente pelo
501:     * BtnProcessarClick apos processamento bem-sucedido (via DeletarDaFila).
502:     * Nao ha exclusao manual pelo usuario. Metodo presente para compatibilidade
503:     * com o pipeline de validacao de fases.
504:     *==========================================================================
505:     PROCEDURE BtnExcluirClick
506:         *-- Form OPERACIONAL: exclusao de fila feita automaticamente em BtnProcessarClick.
507:         RETURN .T.
508:     ENDPROC
509: 
510:     *==========================================================================
511:     * CarregarLista - Sem-op semantico para form OPERACIONAL
512:     * Este dialog nao tem grid/lista de registros. O estado da fila e
513:     * consultado em tempo real durante BtnProcessarClick via BuscarNaFila.
514:     *==========================================================================
515:     PROCEDURE CarregarLista
516:         RETURN .T.
517:     ENDPROC
518: 
519:     *==========================================================================
520:     * FormParaBO - Propaga parametros de execucao do form para o BO
521:     * Este dialog nao tem campos de entrada CRUD. Os parametros de execucao
522:     * (usuario, online, parametrizado) sao propagados para o BO.
523:     *==========================================================================
524:     PROTECTED PROCEDURE FormParaBO
525:         IF VARTYPE(THIS.this_oBusinessObject) # "O"
526:             RETURN .F.
527:         ENDIF
528:         WITH THIS.this_oBusinessObject
529:             .this_lParametrizado = THIS.this_lParametrizado
530:             .this_cUsuario       = THIS.this_cUsuario
531:             .this_lOnline        = THIS.this_lOnline
532:             .this_lProcessando   = THIS.this_lProcessando
533:         ENDWITH
534:         RETURN .T.
535:     ENDPROC
536: 
537:     *==========================================================================
538:     * BOParaForm - Sincroniza estado do BO de volta para o form
539:     * Atualiza estado de processamento exibido no form conforme BO.
540:     *==========================================================================
541:     PROTECTED PROCEDURE BOParaForm
542:         IF VARTYPE(THIS.this_oBusinessObject) # "O"
543:             RETURN .F.
544:         ENDIF
545:         THIS.this_lProcessando = THIS.this_oBusinessObject.this_lProcessando
546:         THIS.this_lErroConexao = THIS.this_oBusinessObject.this_lErroConexao
547:         RETURN .T.
548:     ENDPROC
549: 
550:     *==========================================================================
551:     * HabilitarCampos - Habilita/desabilita controles conforme estado
552:     * par_lHabilitar: .T. = habilitado (aguardando), .F. = processando
553:     *==========================================================================
554:     PROTECTED PROCEDURE HabilitarCampos(par_lHabilitar)
555:         IF PEMSTATUS(THIS, "cmd_4c_Processar", 5)
556:             THIS.cmd_4c_Processar.Enabled = par_lHabilitar
557:         ENDIF
558:         IF PEMSTATUS(THIS, "cmd_4c_Encerrar", 5)
559:             THIS.cmd_4c_Encerrar.Enabled  = par_lHabilitar
560:         ENDIF
561:     ENDPROC
562: 
563:     *==========================================================================
564:     * LimparCampos - Limpa o label de status
565:     *==========================================================================
566:     PROTECTED PROCEDURE LimparCampos
567:         IF PEMSTATUS(THIS, "lbl_4c_Status", 5)
568:             THIS.lbl_4c_Status.Caption = ""
569:         ENDIF
570:     ENDPROC
571: 
572:     *==========================================================================
573:     * AjustarBotoesPorModo - Ajusta botoes conforme estado de processamento
574:     * Chamado antes de iniciar e apos concluir BtnProcessarClick.
575:     *==========================================================================
576:     PROTECTED PROCEDURE AjustarBotoesPorModo
577:         LOCAL loc_lHabilitar
578:         loc_lHabilitar = !THIS.this_lProcessando
579:         THIS.HabilitarCampos(loc_lHabilitar)
580:     ENDPROC
581: 
582:     *==========================================================================
583:     * BtnBuscarClick - Sem-op semantico para form OPERACIONAL
584:     * Busca/consulta de fila feita internamente por BtnProcessarClick.
585:     *==========================================================================
586:     PROCEDURE BtnBuscarClick
587:         RETURN .T.
588:     ENDPROC
589: 
590:     *==========================================================================
591:     * BtnSalvarClick - Sem-op semantico para form OPERACIONAL
592:     * Nao ha operacao de salvar manual; gravacao e feita por GravarHistorico.
593:     *==========================================================================
594:     PROCEDURE BtnSalvarClick
595:         RETURN .T.
596:     ENDPROC
597: 
598:     *==========================================================================
599:     * BtnCancelarClick - Sem-op semantico para form OPERACIONAL
600:     * Nao ha edicao de campos a cancelar; o botao Encerrar fecha o dialog.
601:     *==========================================================================
602:     PROCEDURE BtnCancelarClick
603:         RETURN .T.
604:     ENDPROC
605: 
606:     *==========================================================================
607:     PROCEDURE Destroy
608:     *==========================================================================
609:         IF VARTYPE(THIS.this_oBusinessObject) = "O"
610:             THIS.this_oBusinessObject = .NULL.
611:         ENDIF
612:         IF USED("CrSigOpCls")
613:             USE IN CrSigOpCls
614:         ENDIF
615:         IF USED("crRecalculaS")
616:             USE IN crRecalculaS
617:         ENDIF
618:         IF USED("TmpSccr")
619:             USE IN TmpSccr
620:         ENDIF
621:         IF USED("TmpMccr")
622:             USE IN TmpMccr
623:         ENDIF
624:         IF USED("CrSigPrSlS")
625:             USE IN CrSigPrSlS
626:         ENDIF
627:         DODEFAULT()
628:     ENDPROC
629: 
630: ENDDEFINE


### BO (C:\4c\projeto\app\classes\SigPrRssBO.prg):
*==============================================================================
* SigPrRssBO.prg - Business Object: Rec" + CHR(225) + "lculo de Saldos
* Tabela principal: SigPrSlS (fila de processamento de saldos)
* Gerado: 2026-07-18
*==============================================================================
DEFINE CLASS SigPrRssBO AS BusinessBase

    *-- Tabela e chave
    this_cTabela     = "SigPrSlS"
    this_cCampoChave = "CidChaves"

    *-- Controle de processamento (mapeados das props legadas do form)
    this_lParametrizado = .F.   && Iniciado via linha de comando (modo batch)
    this_cUsuario       = "          "   && Filtro de usuario (Space(10))
    this_lOnline        = .F.   && Modo online (processa apenas registros Onlines=1)

    *-- Estado de execucao
    this_lProcessando  = .F.   && .T. enquanto loop principal esta rodando
    this_lErroConexao  = .F.   && .T. se houve queda de conexao com BD

    *-- Campos de SigOpCls usados no processamento
    this_cCidChaves    = ""    && Chave do registro em processamento
    this_cGrupos       = ""    && Grupo da conta
    this_cContas       = ""    && Conta
    this_cMoedas       = ""    && Moeda
    this_dDatas        = {}    && Data do lancamento
    this_nOnlines      = 0     && Flag online (NUMERIC 1,0)
    this_cUsuars       = ""    && Usuario do lancamento
    this_cGruConMoes   = ""    && Chave composta grupo+conta+moeda

    *--------------------------------------------------------------------------
    PROCEDURE Init()
    *--------------------------------------------------------------------------
        DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ObterChavePrimaria()
    *--------------------------------------------------------------------------
        RETURN THIS.this_cCidChaves
    ENDPROC

    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE CarregarDoCursor(par_cAliasCursor)
    *--------------------------------------------------------------------------
        IF USED(par_cAliasCursor)
            SELECT (par_cAliasCursor)
            THIS.this_cCidChaves  = TratarNulo(cidchaves,  "C")
            THIS.this_cGrupos     = TratarNulo(grupos,     "C")
            THIS.this_cContas     = TratarNulo(contas,     "C")
            THIS.this_cMoedas     = TratarNulo(moedas,     "C")
            THIS.this_dDatas      = TratarNulo(datas,      "D")
            THIS.this_nOnlines    = NVL(onlines, 0)
            THIS.this_cUsuars     = TratarNulo(usuars,     "C")
            THIS.this_cGruConMoes = TratarNulo(gruconmoes, "C")
            RETURN .T.
        ENDIF
        RETURN .F.
    ENDPROC

    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ValidarDados()
    *--------------------------------------------------------------------------
        IF EMPTY(THIS.this_cCidChaves)
            THIS.this_cMensagemErro = "CidChaves obrigat" + CHR(243) + "rio."
            MsgAviso(THIS.this_cMensagemErro, "Aten" + CHR(231) + CHR(227) + "o")
            RETURN .F.
        ENDIF
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Inserir()
    *--------------------------------------------------------------------------
        LOCAL loc_lSucesso, loc_oErro, loc_cSQL
        loc_lSucesso = .F.

        TRY
            IF THIS.ValidarDados()
                loc_cSQL = "INSERT INTO SigPrSlS " + ;
                    "(cidchaves, contas, datas, gruconmoes, grupos, moedas, onlines, usuars) " + ;
                    "VALUES (" + ;
                    EscaparSQL(THIS.this_cCidChaves)             + ", " + ;
                    EscaparSQL(THIS.this_cContas)                + ", " + ;
                    FormatarDataSQL(THIS.this_dDatas)            + ", " + ;
                    EscaparSQL(THIS.this_cGruConMoes)            + ", " + ;
                    EscaparSQL(THIS.this_cGrupos)                + ", " + ;
                    EscaparSQL(THIS.this_cMoedas)                + ", " + ;
                    FormatarNumeroSQL(THIS.this_nOnlines, 0)     + ", " + ;
                    EscaparSQL(THIS.this_cUsuars)                + ")"

                IF SQLEXEC(gnConnHandle, loc_cSQL) > 0
                    THIS.RegistrarAuditoria("INSERT")
                    loc_lSucesso = .T.
                ELSE
                    MostrarErro("Erro ao inserir em SigPrSlS." + CHR(13) + ;
                        CapturarErroSQL(), "Erro SQL")
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MostrarErro("Erro ao inserir em SigPrSlS:" + CHR(13) + ;
                loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo), "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Atualizar()
    *--------------------------------------------------------------------------
        LOCAL loc_lSucesso, loc_oErro, loc_cSQL
        loc_lSucesso = .F.

        TRY
            IF THIS.ValidarDados()
                loc_cSQL = "UPDATE SigPrSlS SET " + ;
                    "contas     = " + EscaparSQL(THIS.this_cContas)            + ", " + ;
                    "datas      = " + FormatarDataSQL(THIS.this_dDatas)        + ", " + ;
                    "gruconmoes = " + EscaparSQL(THIS.this_cGruConMoes)        + ", " + ;
                    "grupos     = " + EscaparSQL(THIS.this_cGrupos)            + ", " + ;
                    "moedas     = " + EscaparSQL(THIS.this_cMoedas)            + ", " + ;
                    "onlines    = " + FormatarNumeroSQL(THIS.this_nOnlines, 0) + ", " + ;
                    "usuars     = " + EscaparSQL(THIS.this_cUsuars)            + " " + ;
                    "WHERE cidchaves = " + EscaparSQL(THIS.this_cCidChaves)

                IF SQLEXEC(gnConnHandle, loc_cSQL) > 0
                    THIS.RegistrarAuditoria("UPDATE")
                    loc_lSucesso = .T.
                ELSE
                    MostrarErro("Erro ao atualizar SigPrSlS." + CHR(13) + ;
                        CapturarErroSQL(), "Erro SQL")
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MostrarErro("Erro ao atualizar SigPrSlS:" + CHR(13) + ;
                loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo), "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * BuscarNaFila - Consulta SigOpCls para obter registros a processar
    * Popula cursor CrSigOpCls. Filtros: usuario especifico e/ou modo online.
    *--------------------------------------------------------------------------
    FUNCTION BuscarNaFila(par_cUsuario, par_lOnline)
        LOCAL loc_lSucesso, loc_oErro, loc_cSQL
        loc_lSucesso = .F.

        TRY
            IF USED("CrSigOpCls")
                USE IN CrSigOpCls
            ENDIF

            IF !EMPTY(par_cUsuario) OR par_lOnline
                loc_cSQL = "SELECT 0 AS Flag, * FROM SigOpCls WHERE Onlines = 1"
                IF !EMPTY(par_cUsuario)
                    loc_cSQL = loc_cSQL + " AND Usuars = " + EscaparSQL(par_cUsuario)
                ENDIF
                loc_cSQL = loc_cSQL + " ORDER BY GruConMoes"
            ELSE
                loc_cSQL = "SELECT 0 AS Flag, * FROM SigOpCls ORDER BY GruConMoes"
            ENDIF

            loc_lSucesso = (SQLEXEC(gnConnHandle, loc_cSQL, "CrSigOpCls") > 0)
        CATCH TO loc_oErro
            MostrarErro("Erro ao buscar registros em SigOpCls:" + CHR(13) + ;
                loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * MarcarProcessando - Toca registro em SigOpCls (lock otimista)
    *--------------------------------------------------------------------------
    FUNCTION MarcarProcessando(par_cCidChaves)
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        TRY
            loc_lSucesso = (SQLEXEC(gnConnHandle, ;
                "UPDATE SigOpCls SET Usuars = Usuars " + ;
                "WHERE CidChaves = " + EscaparSQL(par_cCidChaves)) > 0)
        CATCH TO loc_oErro
            MostrarErro("Erro ao marcar processamento em SigOpCls:" + CHR(13) + ;
                loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * VerificarMovimentos - Verifica se existe impeditivo em SigMvSlc/SigMvCcr
    * Retorna .T. se pode continuar o processamento do registro
    *--------------------------------------------------------------------------
    FUNCTION VerificarMovimentos(par_cGruConMoes)
        LOCAL loc_lSucesso, loc_oErro, loc_cSQL, loc_nRes
        loc_lSucesso = .F.

        TRY
            IF USED("cursor_4c_TmpSccr")
                USE IN cursor_4c_TmpSccr
            ENDIF

            *-- Verificar SigMvSlc
            loc_cSQL = "SELECT CidChaves FROM SigMvSlc " + ;
                "WHERE GruConMoes = " + EscaparSQL(par_cGruConMoes)
            loc_nRes = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_TmpSccr")

            IF loc_nRes > 0 AND RECCOUNT("cursor_4c_TmpSccr") > 0
                loc_lSucesso = .T.
            ELSE
                *-- Verificar SigMvCcr
                IF USED("cursor_4c_TmpMccr")
                    USE IN cursor_4c_TmpMccr
                ENDIF

                loc_cSQL = "SELECT GruConMoes, SUM(1) AS TT FROM SigMvCcr " + ;
                    "WHERE GruConMoes = " + EscaparSQL(par_cGruConMoes) + " " + ;
                    "GROUP BY GruConMoes"
                loc_nRes = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_TmpMccr")

                IF loc_nRes >= 0 AND USED("cursor_4c_TmpMccr") AND ;
                        RECCOUNT("cursor_4c_TmpMccr") > 0 AND cursor_4c_TmpMccr.TT > 0
                    loc_lSucesso = .F.
                ELSE
                    loc_lSucesso = .T.
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MostrarErro("Erro ao verificar movimentos:" + CHR(13) + ;
                loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * GravarHistorico - Registra em SigPrSlS o lancamento processado
    * Equivale ao SCATTER CrSigOpCls / ZAP CrSigPrSlS / APPEND / GATHER do legado
    *--------------------------------------------------------------------------
    FUNCTION GravarHistorico(par_cCidChaves, par_cGrupos, par_cContas, par_dDatas, ;
                             par_cMoedas, par_cGruConMoes, par_nOnlines, par_cUsuars)
        LOCAL loc_lSucesso, loc_oErro, loc_cSQL, loc_nCheck
        loc_lSucesso = .F.

        TRY
            *-- Remover entrada anterior se existir (emula ZAP do cursor)
            IF USED("cursor_4c_ChkSlS")
                USE IN cursor_4c_ChkSlS
            ENDIF
            loc_nCheck = SQLEXEC(gnConnHandle, ;
                "SELECT cidchaves FROM SigPrSlS WHERE cidchaves = " + ;
                EscaparSQL(par_cCidChaves), "cursor_4c_ChkSlS")
            IF loc_nCheck > 0 AND RECCOUNT("cursor_4c_ChkSlS") > 0
                SQLEXEC(gnConnHandle, "DELETE FROM SigPrSlS WHERE cidchaves = " + ;
                    EscaparSQL(par_cCidChaves))
            ENDIF

            loc_cSQL = "INSERT INTO SigPrSlS " + ;
                "(cidchaves, contas, datas, gruconmoes, grupos, moedas, onlines, usuars) " + ;
                "VALUES (" + ;
                EscaparSQL(par_cCidChaves)          + ", " + ;
                EscaparSQL(par_cContas)              + ", " + ;
                FormatarDataSQL(par_dDatas)          + ", " + ;
                EscaparSQL(par_cGruConMoes)          + ", " + ;
                EscaparSQL(par_cGrupos)              + ", " + ;
                EscaparSQL(par_cMoedas)              + ", " + ;
                FormatarNumeroSQL(par_nOnlines, 0)   + ", " + ;
                EscaparSQL(par_cUsuars)              + ")"

            loc_lSucesso = (SQLEXEC(gnConnHandle, loc_cSQL) > 0)
        CATCH TO loc_oErro
            MostrarErro("Erro ao gravar hist" + CHR(243) + "rico em SigPrSlS:" + ;
                CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * DeletarDaFila - Remove registro ja processado da fila SigOpCls
    *--------------------------------------------------------------------------
    FUNCTION DeletarDaFila(par_cCidChaves)
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        TRY
            loc_lSucesso = (SQLEXEC(gnConnHandle, ;
                "DELETE FROM SigOpCls WHERE CidChaves = " + ;
                EscaparSQL(par_cCidChaves)) > 0)
        CATCH TO loc_oErro
            MostrarErro("Erro ao remover da fila SigOpCls:" + CHR(13) + ;
                loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * RecalcularSaldo - Invoca fRecalculaS (Framework legado) para recalc de saldo
    * Equivale a: fRecalculaS(Grupos, Contas, Datas, Moedas, DataMgr) do legado
    *--------------------------------------------------------------------------
    FUNCTION RecalcularSaldo(par_cGrupos, par_cContas, par_dDatas, par_cMoedas)
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        TRY
            loc_lSucesso = fRecalculaS(par_cGrupos, par_cContas, par_dDatas, ;
                par_cMoedas, gnConnHandle)
        CATCH TO loc_oErro
            MostrarErro("Erro ao recalcular saldo:" + CHR(13) + ;
                loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * FinalizarRecalculo - Segunda chamada de fRecalculaS (modo finalizacao)
    * Equivale a: fRecalculaS(.T., DataMgr, .T., .F., .F., .T.) do legado
    *--------------------------------------------------------------------------
    FUNCTION FinalizarRecalculo()
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        TRY
            loc_lSucesso = fRecalculaS(.T., gnConnHandle, .T., .F., .F., .T.)
        CATCH TO loc_oErro
            MostrarErro("Erro ao finalizar rec" + CHR(225) + "lculo:" + CHR(13) + ;
                loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

ENDDEFINE


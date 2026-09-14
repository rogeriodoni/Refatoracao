# CODE REVIEW - PASS VISUAL: Visual Properties (alinhamento, titulos, tipos)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Visual Properties (alinhamento, titulos, tipos)**.

## PROBLEMAS DETECTADOS (1)
- [TITULO-NAO-PROPAGADO] Form define Caption mas NAO propaga para lbl_4c_Sombra/lbl_4c_Titulo. O titulo na tela ficara incorreto (ex: 'Cadastro de Testes' ao inves do titulo real). CORRIGIR: No InicializarForm, APOS ConfigurarPageFrame, adicionar: THIS.pgf_4c_Paginas.Page1.cnt_4c_Sombra.lbl_4c_Sombra.Caption = THIS.Caption (e idem para lbl_4c_Titulo)

## INSTRUCOES DE CORRECAO
### Foco deste pass: CORRECOES VISUAIS
- [ALINHAMENTO] Botoes cmd_4c_* com Top diferente no mesmo grupo horizontal
  - Identificar Top mais frequente no grupo, alinhar os desalinhados
- [ALINHAMENTO-CONTAINER] Botoes no mesmo container cnt_4c_* com Top diferente
- [TITULO-NAO-PROPAGADO] Caption do form nao propagado para lbl_4c_Sombra/lbl_4c_Titulo
- [CHECKBOX-TIPO] CheckBox.Value tipo inconsistente (.F. vs 0/1)
- [FONTNAME-ERRADO] FontName 'Comic Sans MS' encontrado - substituir por 'Tahoma'

## REGRAS OBRIGATORIAS
- Corrigir APENAS os problemas listados, NAO alterar logica de negocio
- NAO remover campos, funcionalidades ou lookups
- **PROIBIDO alterar propriedades visuais** (Width, Height, Top, Left, BackColor, ForeColor, FontName, FontSize) EXCETO se o problema eh especificamente de ALINHAMENTO
- NUNCA juntar linhas com `;` numa linha unica
- Usar Write tool para salvar os arquivos corrigidos nos mesmos caminhos


## CODIGO ATUAL DOS ARQUIVOS

### FORM (C:\4c\projeto\app\forms\relatorios\FormSIGREVIS.prg) - TRECHOS RELEVANTES PARA PASS VISUAL (1431 linhas total):

*-- Linhas 68 a 76:
68:         loc_lSucesso   = .F.
69:         loc_lContinuar = .T.
70:         TRY
71:             THIS.Caption = "Relat" + CHR(243) + "rio de Visitas"
72: 
73:             IF TYPE("gc_4c_CaminhoIcones") = "U"
74:                 gc_4c_CaminhoIcones = ""
75:             ENDIF
76:             THIS.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"

*-- Linhas 110 a 121:
110:                 THIS.ConfigurarPaginaLista()
111: 
112:                 *-- Vincular Click dos botoes de relatorio
113:                 BINDEVENT(THIS.cnt_4c_Botoes.cmd_4c_Visualizar, "Click", THIS, "BtnVisualizarClick")
114:                 BINDEVENT(THIS.cnt_4c_Botoes.cmd_4c_Imprimir,   "Click", THIS, "BtnImprimirClick")
115:                 BINDEVENT(THIS.cnt_4c_Botoes.cmd_4c_Excel,      "Click", THIS, "BtnExcelClick")
116:                 BINDEVENT(THIS.cnt_4c_Botoes.cmd_4c_Sair,       "Click", THIS, "BtnSairClick")
117: 
118:                 *-- Valores iniciais dos campos de filtro
119:                 THIS.LimparCampos()
120: 
121:                 THIS.Visible = .T.

*-- Linhas 138 a 268:
138:     PROTECTED PROCEDURE ConfigurarCabecalho()
139:         THIS.AddObject("cnt_4c_Cabecalho", "Container")
140:         WITH THIS.cnt_4c_Cabecalho
141:             .Top         = 0
142:             .Left        = 0
143:             .Width       = THIS.Width
144:             .Height      = 80
145:             .BackStyle   = 1
146:             .BackColor   = RGB(53, 53, 53)
147:             .BorderWidth = 0
148:             .Visible     = .T.
149: 
150:             *-- Sombra (deslocada 2px para efeito 3D do texto branco)
151:             .AddObject("lbl_4c_Sombra", "Label")
152:             WITH .lbl_4c_Sombra
153:                 .Top       = 22
154:                 .Left      = 22
155:                 .Width     = THIS.Width
156:                 .Height    = 30
157:                 .Caption   = "Relat" + CHR(243) + "rio de Visitas"
158:                 .FontName  = "Tahoma"
159:                 .FontSize  = 14
160:                 .FontBold  = .T.
161:                 .ForeColor = RGB(0, 0, 0)
162:                 .BackStyle = 0
163:                 .Visible   = .T.
164:             ENDWITH
165: 
166:             *-- Titulo em branco (sobre a sombra)
167:             .AddObject("lbl_4c_Titulo", "Label")
168:             WITH .lbl_4c_Titulo
169:                 .Top       = 20
170:                 .Left      = 20
171:                 .Width     = THIS.Width
172:                 .Height    = 30
173:                 .Caption   = "Relat" + CHR(243) + "rio de Visitas"
174:                 .FontName  = "Tahoma"
175:                 .FontSize  = 14
176:                 .FontBold  = .T.
177:                 .ForeColor = RGB(255, 255, 255)
178:                 .BackStyle = 0
179:                 .Visible   = .T.
180:             ENDWITH
181:         ENDWITH
182:     ENDPROC
183: 
184:     *--------------------------------------------------------------------------
185:     * ConfigurarBotoes - Container de botoes de relatorio (btnReport area)
186:     *   Original: btnReport.Top=-3, Left=526, Height=85, Width=305
187:     *   Botoes: Visualiza(6), Imprime(72), DocExcel(138), Sair(204) - W=60 cada
188:     *   Eventos Click sao vinculados nas fases seguintes (Fase 7).
189:     *--------------------------------------------------------------------------
190:     PROTECTED PROCEDURE ConfigurarBotoes()
191:         THIS.AddObject("cnt_4c_Botoes", "Container")
192:         WITH THIS.cnt_4c_Botoes
193:             .Top         = 0
194:             .Left        =  542
195:             .Width       = 325
196:             .Height      = 80
197:             .BackStyle   = 0
198:             .BorderWidth = 0
199:             .Visible     = .T.
200:         ENDWITH
201: 
202:         *-- Visualizar (preview em tela)
203:         THIS.cnt_4c_Botoes.AddObject("cmd_4c_Visualizar", "CommandButton")
204:         WITH THIS.cnt_4c_Botoes.cmd_4c_Visualizar
205:             .Top             = 4
206:             .Left            = 4
207:             .Width           = 67
208:             .Height          = 70
209:             .Caption         = "Visualizar"
210:             .FontName        = "Tahoma"
211:             .FontSize        = 8
212:             .Picture         = gc_4c_CaminhoIcones + "relatorio_video_26.jpg"
213:             .PicturePosition = 1
214:             .Themes          = .F.
215:             .BackColor       = RGB(255, 255, 255)
216:             .ForeColor       = RGB(90, 90, 90)
217:             .Visible         = .T.
218:         ENDWITH
219: 
220:         *-- Imprimir (impressora padrao)
221:         THIS.cnt_4c_Botoes.AddObject("cmd_4c_Imprimir", "CommandButton")
222:         WITH THIS.cnt_4c_Botoes.cmd_4c_Imprimir
223:             .Top             = 4
224:             .Left            = 79
225:             .Width           = 67
226:             .Height          = 70
227:             .Caption         = "Imprimir"
228:             .FontName        = "Tahoma"
229:             .FontSize        = 8
230:             .Picture         = gc_4c_CaminhoIcones + "relatorio_impressora_26.jpg"
231:             .PicturePosition = 1
232:             .Themes          = .F.
233:             .BackColor       = RGB(255, 255, 255)
234:             .ForeColor       = RGB(90, 90, 90)
235:             .Visible         = .T.
236:         ENDWITH
237: 
238:         *-- Excel (exportar dados)
239:         THIS.cnt_4c_Botoes.AddObject("cmd_4c_Excel", "CommandButton")
240:         WITH THIS.cnt_4c_Botoes.cmd_4c_Excel
241:             .Top             = 4
242:             .Left            = 154
243:             .Width           = 67
244:             .Height          = 70
245:             .Caption         = "Excel"
246:             .FontName        = "Tahoma"
247:             .FontSize        = 8
248:             .Picture         = gc_4c_CaminhoIcones + "relatorio_excel_26.jpg"
249:             .PicturePosition = 1
250:             .Themes          = .F.
251:             .BackColor       = RGB(255, 255, 255)
252:             .ForeColor       = RGB(90, 90, 90)
253:             .Visible         = .T.
254:         ENDWITH
255: 
256:         *-- Encerrar (fechar form)
257:         THIS.cnt_4c_Botoes.AddObject("cmd_4c_Sair", "CommandButton")
258:         WITH THIS.cnt_4c_Botoes.cmd_4c_Sair
259:             .Top             = 4
260:             .Left            = 229
261:             .Width           = 75
262:             .Height          = 75
263:             .Caption         = "Encerrar"
264:             .FontName        = "Tahoma"
265:             .FontSize        = 8
266:             .Picture         = gc_4c_CaminhoIcones + "relatorio_sair_60.jpg"
267:             .PicturePosition = 1
268:             .Themes          = .F.

*-- Linhas 293 a 308:
293:         loc_oPgf.PageCount = 1
294: 
295:         *-- Posicionamento: logo abaixo do cabecalho (80px) ate o fim do form
296:         loc_oPgf.Top    = 85
297:         loc_oPgf.Left   = -1
298:         loc_oPgf.Width  = THIS.Width + 2
299:         loc_oPgf.Height = THIS.Height - 85
300:         loc_oPgf.Tabs   = .F.
301: 
302:         *-- Configurar Page1 (FORA de qualquer WITH - usar referencia direta)
303:         loc_oPgf.Page1.Caption   = "Filtros"
304:         loc_oPgf.Page1.FontName  = "Tahoma"
305:         loc_oPgf.Page1.FontSize  = 8
306:         loc_oPgf.Page1.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
307:         loc_oPgf.Page1.BackColor = RGB(255, 255, 255)
308:         loc_oPgf.Page1.ForeColor = RGB(90, 90, 90)

*-- Linhas 327 a 353:
327:         loc_oPg = THIS.pgf_4c_Paginas.Page1
328: 
329:         *-- Label "Periodo :"
330:         loc_oPg.AddObject("lbl_4c_LblPeriodo", "Label")
331:         WITH loc_oPg.lbl_4c_LblPeriodo
332:             .Top       = 26
333:             .Left      = 209
334:             .Width     = 45
335:             .Height    = 15
336:             .Caption   = "Per" + CHR(237) + "odo :"
337:             .FontName  = "Tahoma"
338:             .FontSize  = 8
339:             .ForeColor = RGB(90, 90, 90)
340:             .BackStyle = 0
341:             .Visible   = .T.
342:         ENDWITH
343: 
344:         *-- Data inicial
345:         loc_oPg.AddObject("txt_4c_Datai", "TextBox")
346:         WITH loc_oPg.txt_4c_Datai
347:             .Top         = 21
348:             .Left        = 260
349:             .Width       = 80
350:             .Height      = 25
351:             .Value       = {}
352:             .Format      = "D"
353:             .FontName    = "Tahoma"

*-- Linhas 359 a 385:
359:         ENDWITH
360: 
361:         *-- Label "a" (separador entre datas)
362:         loc_oPg.AddObject("lbl_4c_A", "Label")
363:         WITH loc_oPg.lbl_4c_A
364:             .Top       = 26
365:             .Left      = 348
366:             .Width     = 10
367:             .Height    = 15
368:             .Caption   = "a"
369:             .FontName  = "Tahoma"
370:             .FontSize  = 8
371:             .ForeColor = RGB(90, 90, 90)
372:             .BackStyle = 0
373:             .Visible   = .T.
374:         ENDWITH
375: 
376:         *-- Data final
377:         loc_oPg.AddObject("txt_4c_Dataf", "TextBox")
378:         WITH loc_oPg.txt_4c_Dataf
379:             .Top         = 21
380:             .Left        = 360
381:             .Width       = 80
382:             .Height      = 25
383:             .Value       = {}
384:             .Format      = "D"
385:             .FontName    = "Tahoma"

*-- Linhas 391 a 417:
391:         ENDWITH
392: 
393:         *-- Label "Representante :"
394:         loc_oPg.AddObject("lbl_4c_LblRepr", "Label")
395:         WITH loc_oPg.lbl_4c_LblRepr
396:             .Top       = 53
397:             .Left      = 173
398:             .Width     = 81
399:             .Height    = 15
400:             .Caption   = "Representante :"
401:             .FontName  = "Tahoma"
402:             .FontSize  = 8
403:             .ForeColor = RGB(90, 90, 90)
404:             .BackStyle = 0
405:             .Visible   = .T.
406:         ENDWITH
407: 
408:         *-- Codigo do representante (F4 -> SigCdCli filtrado por Grupos)
409:         loc_oPg.AddObject("txt_4c_CdRepr", "TextBox")
410:         WITH loc_oPg.txt_4c_CdRepr
411:             .Top         = 48
412:             .Left        = 260
413:             .Width       = 80
414:             .Height      = 25
415:             .Value       = ""
416:             .MaxLength   = 6
417:             .FontName    = "Tahoma"

*-- Linhas 425 a 434:
425:         *-- Descricao do representante (preenchida pelo lookup)
426:         loc_oPg.AddObject("txt_4c_DsRepr", "TextBox")
427:         WITH loc_oPg.txt_4c_DsRepr
428:             .Top         = 48
429:             .Left        = 342
430:             .Width       = 313
431:             .Height      = 25
432:             .Value       = ""
433:             .MaxLength   = 40
434:             .FontName    = "Tahoma"

*-- Linhas 440 a 466:
440:         ENDWITH
441: 
442:         *-- Label "Conta :"
443:         loc_oPg.AddObject("lbl_4c_LblConta", "Label")
444:         WITH loc_oPg.lbl_4c_LblConta
445:             .Top       = 80
446:             .Left      = 216
447:             .Width     = 38
448:             .Height    = 15
449:             .Caption   = "Conta :"
450:             .FontName  = "Tahoma"
451:             .FontSize  = 8
452:             .ForeColor = RGB(90, 90, 90)
453:             .BackStyle = 0
454:             .Visible   = .T.
455:         ENDWITH
456: 
457:         *-- Codigo da conta (F4 -> SigCdCli, sem filtro de grupo)
458:         loc_oPg.AddObject("txt_4c_CdConta", "TextBox")
459:         WITH loc_oPg.txt_4c_CdConta
460:             .Top         = 75
461:             .Left        = 260
462:             .Width       = 80
463:             .Height      = 25
464:             .Value       = ""
465:             .MaxLength   = 6
466:             .FontName    = "Tahoma"

*-- Linhas 474 a 483:
474:         *-- Descricao da conta (preenchida pelo lookup)
475:         loc_oPg.AddObject("txt_4c_DsConta", "TextBox")
476:         WITH loc_oPg.txt_4c_DsConta
477:             .Top         = 75
478:             .Left        = 342
479:             .Width       = 313
480:             .Height      = 25
481:             .Value       = ""
482:             .MaxLength   = 40
483:             .FontName    = "Tahoma"

*-- Linhas 513 a 639:
513:         loc_oPg = THIS.pgf_4c_Paginas.Page1
514: 
515:         *-- Label "Venda :"
516:         loc_oPg.AddObject("lbl_4c_LblVenda", "Label")
517:         WITH loc_oPg.lbl_4c_LblVenda
518:             .Top       = 110
519:             .Left      = 215
520:             .Width     = 39
521:             .Height    = 15
522:             .Caption   = "Venda :"
523:             .FontName  = "Tahoma"
524:             .FontSize  = 8
525:             .ForeColor = RGB(90, 90, 90)
526:             .BackStyle = 0
527:             .Visible   = .T.
528:         ENDWITH
529: 
530:         *-- OptionGroup Venda (Sim / Nao / Todos) - ButtonCount ANTES de Buttons(3)
531:         loc_oPg.AddObject("opt_4c_Venda", "OptionGroup")
532:         loc_oPg.opt_4c_Venda.ButtonCount = 3
533:         WITH loc_oPg.opt_4c_Venda
534:             .Top         = 104
535:             .Left        = 260
536:             .Width       = 246
537:             .Height      = 27
538:             .BackStyle   = 0
539:             .BorderStyle = 0
540:             .Visible     = .T.
541:         ENDWITH
542:         WITH loc_oPg.opt_4c_Venda.Buttons(1)
543:             .Caption   = "Sim"
544:             .Left      = 5
545:             .Top       = 5
546:             .Width     = 57
547:             .Height    = 17
548:             .FontName  = "Tahoma"
549:             .FontSize  = 8
550:             .BackStyle = 0
551:             .AutoSize  = .F.
552:             .ForeColor = RGB(90, 90, 90)
553:         ENDWITH
554:         WITH loc_oPg.opt_4c_Venda.Buttons(2)
555:             .Caption   = "N" + CHR(227) + "o"
556:             .Left      = 92
557:             .Top       = 5
558:             .Width     = 57
559:             .Height    = 17
560:             .FontName  = "Tahoma"
561:             .FontSize  = 8
562:             .BackStyle = 0
563:             .AutoSize  = .F.
564:             .ForeColor = RGB(90, 90, 90)
565:         ENDWITH
566:         WITH loc_oPg.opt_4c_Venda.Buttons(3)
567:             .Caption   = "Ambos"
568:             .Left      = 179
569:             .Top       = 5
570:             .Width     = 57
571:             .Height    = 17
572:             .FontName  = "Tahoma"
573:             .FontSize  = 8
574:             .BackStyle = 0
575:             .AutoSize  = .F.
576:             .ForeColor = RGB(90, 90, 90)
577:         ENDWITH
578:         loc_oPg.opt_4c_Venda.Value = 3
579: 
580:         *-- Label "Pedidos :"
581:         loc_oPg.AddObject("lbl_4c_LblPedido", "Label")
582:         WITH loc_oPg.lbl_4c_LblPedido
583:             .Top       = 136
584:             .Left      = 208
585:             .Width     = 46
586:             .Height    = 15
587:             .Caption   = "Pedidos :"
588:             .FontName  = "Tahoma"
589:             .FontSize  = 8
590:             .ForeColor = RGB(90, 90, 90)
591:             .BackStyle = 0
592:             .Visible   = .T.
593:         ENDWITH
594: 
595:         *-- OptionGroup Pedido (Sim / Nao / Todos) - ButtonCount ANTES de Buttons(3)
596:         loc_oPg.AddObject("opt_4c_Pedido", "OptionGroup")
597:         loc_oPg.opt_4c_Pedido.ButtonCount = 3
598:         WITH loc_oPg.opt_4c_Pedido
599:             .Top         = 130
600:             .Left        = 260
601:             .Width       = 246
602:             .Height      = 27
603:             .BackStyle   = 0
604:             .BorderStyle = 0
605:             .Visible     = .T.
606:         ENDWITH
607:         WITH loc_oPg.opt_4c_Pedido.Buttons(1)
608:             .Caption   = "Sim"
609:             .Left      = 5
610:             .Top       = 5
611:             .Width     = 57
612:             .Height    = 17
613:             .FontName  = "Tahoma"
614:             .FontSize  = 8
615:             .BackStyle = 0
616:             .AutoSize  = .F.
617:             .ForeColor = RGB(90, 90, 90)
618:         ENDWITH
619:         WITH loc_oPg.opt_4c_Pedido.Buttons(2)
620:             .Caption   = "N" + CHR(227) + "o"
621:             .Left      = 92
622:             .Top       = 5
623:             .Width     = 57
624:             .Height    = 17
625:             .FontName  = "Tahoma"
626:             .FontSize  = 8
627:             .BackStyle = 0
628:             .AutoSize  = .F.
629:             .ForeColor = RGB(90, 90, 90)
630:         ENDWITH
631:         WITH loc_oPg.opt_4c_Pedido.Buttons(3)
632:             .Caption   = "Ambos"
633:             .Left      = 179
634:             .Top       = 5
635:             .Width     = 57
636:             .Height    = 17
637:             .FontName  = "Tahoma"
638:             .FontSize  = 8
639:             .BackStyle = 0

*-- Linhas 1309 a 1324:
1309:             ENDIF
1310:             loc_oPg = THIS.pgf_4c_Paginas.Page1
1311:             WITH THIS.this_oRelatorio
1312:                 loc_oPg.txt_4c_Datai.Value   = .this_dDtInicial
1313:                 loc_oPg.txt_4c_Dataf.Value   = .this_dDtFinal
1314:                 loc_oPg.txt_4c_CdConta.Value = .this_cCdConta
1315:                 loc_oPg.txt_4c_DsConta.Value = .this_cDsConta
1316:                 loc_oPg.txt_4c_CdRepr.Value  = .this_cCdRepr
1317:                 loc_oPg.txt_4c_DsRepr.Value  = .this_cDsRepr
1318:                 loc_oPg.opt_4c_Venda.Value   = .this_nOpcaoVenda
1319:                 loc_oPg.opt_4c_Pedido.Value  = .this_nOpcaoPedido
1320:             ENDWITH
1321:             THIS.AtualizarEstadoCamposDescricao()
1322:         CATCH TO loc_oErro
1323:             MsgErro(loc_oErro.Message, "Erro")
1324:         ENDTRY

*-- Linhas 1364 a 1375:
1364:     PROCEDURE AjustarBotoesPorModo()
1365:         TRY
1366:             IF VARTYPE(THIS.cnt_4c_Botoes) = "O"
1367:                 THIS.cnt_4c_Botoes.cmd_4c_Visualizar.Enabled = .T.
1368:                 THIS.cnt_4c_Botoes.cmd_4c_Imprimir.Enabled   = .T.
1369:                 THIS.cnt_4c_Botoes.cmd_4c_Excel.Enabled      = .T.
1370:                 THIS.cnt_4c_Botoes.cmd_4c_Sair.Enabled       = .T.
1371:             ENDIF
1372:         CATCH TO loc_oErro
1373:             MsgErro(loc_oErro.Message, "Erro")
1374:         ENDTRY
1375:     ENDPROC


### BO (C:\4c\projeto\app\classes\SIGREVISBO.prg):
*==============================================================================
* SIGREVISBO.PRG
* Business Object para Relatorio de Visitas (SIGREVIS)
* Herda de RelatorioBase
*
* Tabela principal: SigCdVis
* Relatorio FRX: SigReVis.frx
*
* Filtros:
*   - Periodo (data inicial / data final)
*   - Conta   (codigo + descricao - campo iclis/rclis de SigCdCli)
*   - Representante (codigo + descricao - campo iclis/rclis de SigCdCli,
*                    filtrado por Grupos = this_cGrupo)
*   - Opcao Venda  (1=Sim / 2=Nao / 3=Ambos)
*   - Opcao Pedido (1=Sim / 2=Nao / 3=Ambos)
*==============================================================================

DEFINE CLASS SIGREVISBO AS RelatorioBase

    *-- Filtro: periodo
    this_dDtInicial     = {}
    this_dDtFinal       = {}

    *-- Filtro: conta (iclis / rclis de SigCdCli)
    this_cCdConta       = ""
    this_cDsConta       = ""

    *-- Filtro: representante (iclis / rclis de SigCdCli, filtrado por Grupos)
    this_cCdRepr        = ""
    this_cDsRepr        = ""

    *-- Filtro: opcoes (1=Sim, 2=Nao, 3=Ambos - espelha Value do OptionGroup original)
    this_nOpcaoVenda    = 3
    this_nOpcaoPedido   = 3

    *-- Grupo padrao do usuario logado (GrPadVens de SigCdPam)
    *   Corresponde a propriedade custom 'antgru' do form legado SIGREVIS
    this_cGrupo         = ""

    *-- .T. quando o representante foi bloqueado automaticamente no Init
    *   (usuario sem permissao ALTCONTA em SIGCDVIS via fChecaAcesso)
    this_lReprBloqueado = .F.

    *-- Nome do cursor de saida populado por PrepararDados()
    this_cCursorDados   = "crSigCdVis"

    *--------------------------------------------------------------------------
    * Init - Configura BO do relatorio de visitas
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        THIS.this_cTabela     = "SigCdVis"
        THIS.this_cCampoChave = ""
        RETURN DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    * InicializarFiltros - Carrega parametros iniciais e grupo padrao do usuario.
    * Chamado pelo form em InicializarForm().
    * Equivalente ao bloco de Init() do form legado SIGREVIS que carrega
    * GrPadVens de SigCdPam e verifica permissao ALTCONTA via fChecaAcesso.
    *--------------------------------------------------------------------------
    PROCEDURE InicializarFiltros()
        LOCAL loc_lSucesso, loc_cSQL, loc_nResult
        loc_lSucesso = .F.
        TRY
            *-- Buscar grupo padrao do usuario (GrPadVens de SigCdPam)
            loc_cSQL = "SELECT GrPadVens FROM SigCdPam"
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Pam")
            IF loc_nResult < 1
                THIS.this_cMensagemErro = "Falha ao carregar par" + CHR(226) + ;
                    "metros do sistema (SigCdPam)"
                loc_lSucesso = .F.
            ENDIF
            SELECT cursor_4c_Pam
            THIS.this_cGrupo = ALLTRIM(GrPadVens)
            USE IN cursor_4c_Pam

            *-- Sistema novo: acesso irrestrito a conta/representante para todos os usuarios
            THIS.this_lReprBloqueado = .F.

            loc_lSucesso = .T.
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * PrepararDados - Monta cursor crSigCdVis com dados de visitas conforme
    * filtros definidos nas propriedades this_*.
    * Equivalente ao metodo 'processamento' do form legado SIGREVIS.
    * Tambem cria cursor CsCabecalho para cabecalho do relatorio FRX.
    *--------------------------------------------------------------------------
    PROCEDURE PrepararDados()
        LOCAL loc_lSucesso, loc_cSQL, loc_cWhere, loc_nResult
        LOCAL loc_dDtI, loc_dDtF, loc_cDtFSQL
        LOCAL loc_cEmpresa, loc_cTitulo, loc_cPeriodo
        loc_lSucesso = .F.
        TRY
            *-- Normalizar datas: sem data = faixa maxima historica
            loc_dDtI = IIF(EMPTY(THIS.this_dDtInicial), {^1900-01-01}, THIS.this_dDtInicial)
            loc_dDtF = IIF(EMPTY(THIS.this_dDtFinal),   {^2099-12-31}, THIS.this_dDtFinal)

            *-- Data final com 23:59:59 para cobrir dia inteiro (campo DATETIME)
            loc_cDtFSQL = "'" + ;
                PADL(YEAR(loc_dDtF),  4, "0") + "-" + ;
                PADL(MONTH(loc_dDtF), 2, "0") + "-" + ;
                PADL(DAY(loc_dDtF),   2, "0") + " 23:59:59'"

            *-- Clausula WHERE adicional com filtros opcionais
            loc_cWhere = ""

            *-- Filtro conta (iclis de SigCdCli)
            IF !EMPTY(ALLTRIM(THIS.this_cCdConta))
                loc_cWhere = loc_cWhere + ;
                    " AND a.iclis = " + EscaparSQL(ALLTRIM(THIS.this_cCdConta))
            ENDIF

            *-- Filtro representante (Contas de SigCdVis = iclis de SigCdCli)
            IF !EMPTY(ALLTRIM(THIS.this_cCdRepr))
                loc_cWhere = loc_cWhere + ;
                    " AND a.Contas = " + EscaparSQL(ALLTRIM(THIS.this_cCdRepr))
            ENDIF

            *-- Fechar cursor anterior se existir
            IF USED(THIS.this_cCursorDados)
                USE IN (THIS.this_cCursorDados)
            ENDIF

            *-- Query principal: SigCdVis com JOIN duplo em SigCdCli
            *-- b = conta do cliente (a.iclis), c = representante (a.Contas)
            loc_cSQL = "SELECT a.*," + ;
                " b.rclis AS descri," + ;
                " c.rclis AS repr," + ;
                " CASE WHEN a.vendas=1 THEN 'Sim'" + ;
                "      ELSE 'N" + CHR(227) + "o' END AS descvendas," + ;
                " CASE WHEN a.pedidos=1 THEN 'Sim'" + ;
                "      ELSE 'N" + CHR(227) + "o' END AS descpedidos" + ;
                " FROM SigCdVis a" + ;
                " INNER JOIN SigCdCli b ON a.iclis = b.iclis" + ;
                " INNER JOIN SigCdCli c ON a.Contas = c.iclis" + ;
                " WHERE a.Grupos = " + EscaparSQL(THIS.this_cGrupo) + ;
                " AND a.Datas BETWEEN " + FormatarDataSQL(loc_dDtI) + ;
                " AND " + loc_cDtFSQL + ;
                loc_cWhere + ;
                " ORDER BY a.Contas"

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, THIS.this_cCursorDados)
            IF loc_nResult < 1
                THIS.this_cMensagemErro = "Erro ao buscar dados de visitas"
                loc_lSucesso = .F.
            ENDIF

            *-- Cursor de cabecalho para o relatorio (CsCabecalho)
            loc_cEmpresa = ""
            loc_cSQL = "SELECT Razas FROM SigCdEmp"
            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_EmpCab") > 0
                SELECT cursor_4c_EmpCab
                IF !EOF()
                    loc_cEmpresa = ALLTRIM(cursor_4c_EmpCab.Razas)
                ENDIF
                USE IN cursor_4c_EmpCab
            ENDIF

            loc_cTitulo  = "Relat" + CHR(243) + "rio de Visitas"
            loc_cPeriodo = "Per" + CHR(237) + "odo: " + DTOC(loc_dDtI) + ;
                " " + CHR(150) + " " + DTOC(loc_dDtF)

            IF USED("CsCabecalho")
                USE IN CsCabecalho
            ENDIF
            CREATE CURSOR CsCabecalho (cb_empresa C(80), cb_titulo C(80), cb_periodo C(80))
            INSERT INTO CsCabecalho (cb_empresa, cb_titulo, cb_periodo) ;
                VALUES (loc_cEmpresa, loc_cTitulo, loc_cPeriodo)

            SELECT (THIS.this_cCursorDados)
            loc_lSucesso = .T.
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Restaura filtros a partir de um cursor de configuracao
    * salva (filtros usados anteriormente pelo usuario).
    *
    * Espera um cursor com os campos opcionais:
    *   dt_inicial, dt_final  (data)
    *   cd_conta,   ds_conta  (char)
    *   cd_repr,    ds_repr   (char)
    *   opc_venda,  opc_pedido (numerico 1/2/3)
    *
    * Cada campo eh aplicado somente se existir no cursor (uso de TYPE() para
    * verificar presenca). Util para "ultimo filtro usado" sem quebrar quando
    * o esquema do cursor evoluir.
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso, loc_cAlias
        loc_lSucesso = .F.
        TRY
            IF EMPTY(par_cAliasCursor) OR !USED(par_cAliasCursor)
                THIS.this_cMensagemErro = "Cursor de filtros n" + CHR(227) + ;
                    "o dispon" + CHR(237) + "vel: " + TRANSFORM(par_cAliasCursor)
                loc_lSucesso = .F.
            ENDIF

            loc_cAlias = ALLTRIM(par_cAliasCursor)
            SELECT (loc_cAlias)
            IF EOF()
                THIS.this_cMensagemErro = "Cursor de filtros vazio"
                loc_lSucesso = .F.
            ENDIF

            *-- Periodo
            IF TYPE(loc_cAlias + ".dt_inicial") = "D"
                THIS.this_dDtInicial = EVALUATE(loc_cAlias + ".dt_inicial")
            ENDIF
            IF TYPE(loc_cAlias + ".dt_final") = "D"
                THIS.this_dDtFinal = EVALUATE(loc_cAlias + ".dt_final")
            ENDIF

            *-- Conta
            IF TYPE(loc_cAlias + ".cd_conta") = "C"
                THIS.this_cCdConta = ALLTRIM(EVALUATE(loc_cAlias + ".cd_conta"))
            ENDIF
            IF TYPE(loc_cAlias + ".ds_conta") = "C"
                THIS.this_cDsConta = ALLTRIM(EVALUATE(loc_cAlias + ".ds_conta"))
            ENDIF

            *-- Representante
            IF TYPE(loc_cAlias + ".cd_repr") = "C"
                THIS.this_cCdRepr = ALLTRIM(EVALUATE(loc_cAlias + ".cd_repr"))
            ENDIF
            IF TYPE(loc_cAlias + ".ds_repr") = "C"
                THIS.this_cDsRepr = ALLTRIM(EVALUATE(loc_cAlias + ".ds_repr"))
            ENDIF

            *-- Opcoes Venda/Pedido (manter dentro de 1..3, default 3=Ambos)
            IF TYPE(loc_cAlias + ".opc_venda") = "N"
                THIS.this_nOpcaoVenda = IIF(BETWEEN(EVALUATE(loc_cAlias + ".opc_venda"), 1, 3), ;
                    EVALUATE(loc_cAlias + ".opc_venda"), 3)
            ENDIF
            IF TYPE(loc_cAlias + ".opc_pedido") = "N"
                THIS.this_nOpcaoPedido = IIF(BETWEEN(EVALUATE(loc_cAlias + ".opc_pedido"), 1, 3), ;
                    EVALUATE(loc_cAlias + ".opc_pedido"), 3)
            ENDIF

            loc_lSucesso = .T.
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir - BLOQUEADO: relatorios nao persistem dados.
    *
    * Override defensivo: caso o BO seja usado por engano como CRUD, retorna
    * erro explicito ao inves de corromper o banco com INSERT vazio.
    * Equivale a recusa do form legado SIGREVIS, que nao tinha botao "Incluir".
    *--------------------------------------------------------------------------
    PROCEDURE Inserir()
        THIS.this_cMensagemErro = "Opera" + CHR(231) + CHR(227) + ;
            "o n" + CHR(227) + "o suportada: relat" + CHR(243) + ;
            "rios de visitas n" + CHR(227) + "o gravam registros." + CHR(13) + ;
            "Use PrepararDados() seguido de Imprimir()."
        RETURN .F.
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - BLOQUEADO: relatorios nao persistem dados.
    *
    * Override defensivo: simetrico a Inserir(). Reports nao modificam SigCdVis;
    * apenas extraem dados via SELECT em PrepararDados().
    *--------------------------------------------------------------------------
    PROCEDURE Atualizar()
        THIS.this_cMensagemErro = "Opera" + CHR(231) + CHR(227) + ;
            "o n" + CHR(227) + "o suportada: relat" + CHR(243) + ;
            "rios de visitas n" + CHR(227) + "o alteram registros." + CHR(13) + ;
            "Use PrepararDados() seguido de Imprimir()."
        RETURN .F.
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Relatorio nao tem chave primaria
    *--------------------------------------------------------------------------
    PROCEDURE ObterChavePrimaria()
        RETURN ""
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterMensagemErro - Retorna mensagem de erro atual
    *--------------------------------------------------------------------------
    PROCEDURE ObterMensagemErro()
        RETURN THIS.this_cMensagemErro
    ENDPROC

    *--------------------------------------------------------------------------
    * Destroy - Fecha cursores abertos por InicializarFiltros e PrepararDados
    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
        IF USED("cursor_4c_Pam")
            USE IN cursor_4c_Pam
        ENDIF
        IF USED("cursor_4c_EmpCab")
            USE IN cursor_4c_EmpCab
        ENDIF
        IF USED(THIS.this_cCursorDados)
            USE IN (THIS.this_cCursorDados)
        ENDIF
        IF USED("CsCabecalho")
            USE IN CsCabecalho
        ENDIF
        DODEFAULT()
    ENDPROC

ENDDEFINE


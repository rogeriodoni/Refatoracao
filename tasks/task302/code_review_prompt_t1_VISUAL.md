# CODE REVIEW - PASS VISUAL: Visual Properties (alinhamento, titulos, tipos)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Visual Properties (alinhamento, titulos, tipos)**.

## PROBLEMAS DETECTADOS (3)
- [TITULO-NAO-PROPAGADO] Form define Caption mas NAO propaga para lbl_4c_Sombra/lbl_4c_Titulo. O titulo na tela ficara incorreto (ex: 'Cadastro de Testes' ao inves do titulo real). CORRIGIR: No InicializarForm, APOS ConfigurarPageFrame, adicionar: THIS.pgf_4c_Paginas.Page1.cnt_4c_Sombra.lbl_4c_Sombra.Caption = THIS.Caption (e idem para lbl_4c_Titulo)
- [FONTNAME-ERRADO] Linha 453: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 475: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.

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

### FORM (C:\4c\projeto\app\forms\operacionais\Formsigprila.prg) - TRECHOS RELEVANTES PARA PASS VISUAL (976 linhas total):

*-- Linhas 59 a 67:
59:             IF VARTYPE(THIS.this_oBusinessObject) # "O"
60:                 MsgErro("Erro ao criar sigprilaBO.", "Erro")
61:             ELSE
62:                 THIS.Caption = "Importa" + CHR(231) + CHR(227) + "o de Planilha"
63: 
64:                 THIS.ConfigurarPageFrame()
65:                 THIS.ConfigurarCabecalho()
66:                 THIS.ConfigurarPaginaLista()
67:                 THIS.ConfigurarPaginaDados()

*-- Linhas 93 a 133:
93: 
94:         THIS.AddObject("cnt_4c_Cabecalho", "Container")
95:         WITH THIS.cnt_4c_Cabecalho
96:             .Top         = 0
97:             .Left        = 0
98:             .Width       = loc_nW
99:             .Height      = 80
100:             .BackStyle   = 1
101:             .BackColor   = RGB(100, 100, 100)
102:             .BorderWidth = 0
103: 
104:             .AddObject("lbl_4c_Sombra", "Label")
105:             WITH .lbl_4c_Sombra
106:                 .AutoSize  = .F.
107:                 .Width     = loc_nW
108:                 .Height    = 40
109:                 .Top       = 18
110:                 .Left      = 10
111:                 .Caption   = loc_cCaption
112:                 .FontName  = "Tahoma"
113:                 .FontSize  = 18
114:                 .FontBold  = .T.
115:                 .BackStyle = 0
116:                 .ForeColor = RGB(0, 0, 0)
117:                 .WordWrap  = .T.
118:                 .Alignment = 0
119:             ENDWITH
120: 
121:             .AddObject("lbl_4c_Titulo", "Label")
122:             WITH .lbl_4c_Titulo
123:                 .AutoSize  = .F.
124:                 .Width     = loc_nW
125:                 .Height    = 46
126:                 .Top       = 17
127:                 .Left      = 10
128:                 .Caption   = loc_cCaption
129:                 .FontName  = "Tahoma"
130:                 .FontSize  = 18
131:                 .FontBold  = .T.
132:                 .BackStyle = 0
133:                 .ForeColor = RGB(255, 255, 255)

*-- Linhas 143 a 169:
143:     *==========================================================================
144:         THIS.AddObject("cnt_4c_Planilha", "Container")
145:         WITH THIS.cnt_4c_Planilha
146:             .Top          = 96
147:             .Left         = 167
148:             .Width        = 466
149:             .Height       = 221
150:             .BackStyle    = 0
151:             .BorderWidth  = 0
152:             .SpecialEffect = 0
153: 
154:             *-- Label Tipo:
155:             .AddObject("lbl_4c_Say3", "Label")
156:             WITH .lbl_4c_Say3
157:                 .AutoSize  = .T.
158:                 .FontBold  = .T.
159:                 .FontName  = "Tahoma"
160:                 .FontSize  = 8
161:                 .Caption   = "Tipo:"
162:                 .Height    = 15
163:                 .Left      = 54
164:                 .Top       = 15
165:                 .Width     = 29
166:                 .BackStyle = 0
167:                 .ForeColor = RGB(90, 90, 90)
168:             ENDWITH
169: 

*-- Linhas 178 a 203:
178:                 .RowSource      = ""
179:                 .FirstElement   = 1
180:                 .Height         = 23
181:                 .Left           = 85
182:                 .Style          = 2
183:                 .Top            = 12
184:                 .Width          = 187
185:                 .ForeColor      = RGB(0, 0, 0)
186:             ENDWITH
187: 
188:             *-- Label Planilha:
189:             .AddObject("lbl_4c_Say4", "Label")
190:             WITH .lbl_4c_Say4
191:                 .AutoSize  = .T.
192:                 .FontBold  = .T.
193:                 .FontName  = "Tahoma"
194:                 .FontSize  = 8
195:                 .Caption   = "Planilha:"
196:                 .Height    = 15
197:                 .Left      = 34
198:                 .Top       = 40
199:                 .Width     = 49
200:                 .BackStyle = 0
201:                 .ForeColor = RGB(90, 90, 90)
202:             ENDWITH
203: 

*-- Linhas 209 a 253:
209:                 .ControlSource       = ""
210:                 .Enabled             = .F.
211:                 .Height              = 23
212:                 .Left                = 85
213:                 .MaxLength           = 0
214:                 .ReadOnly            = .T.
215:                 .Top                 = 37
216:                 .Width               = 336
217:                 .ForeColor           = RGB(0, 0, 0)
218:                 .DisabledBackColor   = RGB(255, 255, 255)
219:             ENDWITH
220: 
221:             *-- Botao abrir arquivo XLS
222:             .AddObject("cmd_4c_Cmdgetp", "CommandButton")
223:             WITH .cmd_4c_Cmdgetp
224:                 .Top         = 36
225:                 .Left        = 423
226:                 .Height      = 25
227:                 .Width       = 36
228:                 .FontName    = "Verdana"
229:                 .FontSize    = 8
230:                 .Picture     = gc_4c_CaminhoIcones + "a_fold1.bmp"
231:                 .Caption     = ""
232:                 .ForeColor   = RGB(36, 84, 155)
233:                 .BackColor   = RGB(255, 255, 255)
234:                 .Themes      = .T.
235:                 .DisabledPicture = gc_4c_CaminhoIcones + "a_fold1.bmp"
236:             ENDWITH
237: 
238:             *-- Label Ordem das Colunas na Planilha:
239:             .AddObject("lbl_4c_Say1", "Label")
240:             WITH .lbl_4c_Say1
241:                 .AutoSize  = .T.
242:                 .FontBold  = .T.
243:                 .FontName  = "Tahoma"
244:                 .FontSize  = 8
245:                 .Caption   = "Ordem das Colunas na Planilha:"
246:                 .Height    = 15
247:                 .Left      = 85
248:                 .Top       = 63
249:                 .Width     = 177
250:                 .BackStyle = 0
251:                 .ForeColor = RGB(90, 90, 90)
252:             ENDWITH
253: 

*-- Linhas 263 a 288:
263:                 .RowSource        = ""
264:                 .FirstElement     = 1
265:                 .Height           = 124
266:                 .Left             = 82
267:                 .MoverBars        = .T.
268:                 .SpecialEffect    = 0
269:                 .Top              = 78
270:                 .Width            = 191
271:             ENDWITH
272: 
273:             *-- Label Validar: (oculto por padrao - visivel para TRANSFERENCIA etc)
274:             .AddObject("lbl_4c_Say5", "Label")
275:             WITH .lbl_4c_Say5
276:                 .AutoSize  = .T.
277:                 .FontBold  = .T.
278:                 .FontName  = "Tahoma"
279:                 .FontSize  = 8
280:                 .Caption   = "Validar :"
281:                 .Height    = 15
282:                 .Left      = 290
283:                 .Top       = 82
284:                 .Width     = 47
285:                 .BackStyle = 0
286:                 .ForeColor = RGB(90, 90, 90)
287:                 .Visible   = .F.
288:             ENDWITH

*-- Linhas 295 a 360:
295:                 .BackStyle   = 0
296:                 .Value       = 1
297:                 .Height      = 65
298:                 .Left        = 335
299:                 .Top         = 80
300:                 .Width       = 123
301:                 .Themes      = .T.
302:                 .Visible     = .F.
303: 
304:                 WITH .Buttons(1)
305:                     .Caption   = "C" + CHR(243) + "digo"
306:                     .Height    = 15
307:                     .Left      = 5
308:                     .Top       = 5
309:                     .Width     = 51
310:                     .AutoSize  = .T.
311:                     .BackStyle = 0
312:                     .ForeColor = RGB(90, 90, 90)
313:                     .Themes    = .F.
314:                 ENDWITH
315: 
316:                 WITH .Buttons(2)
317:                     .Caption   = "Descritivo"
318:                     .Height    = 15
319:                     .Left      = 5
320:                     .Top       = 22
321:                     .Width     = 65
322:                     .AutoSize  = .T.
323:                     .BackStyle = 0
324:                     .FontName  = "Tahoma"
325:                     .FontSize  = 8
326:                     .ForeColor = RGB(90, 90, 90)
327:                     .Themes    = .F.
328:                 ENDWITH
329: 
330:                 WITH .Buttons(3)
331:                     .Caption   = "Refer" + CHR(234) + "ncia Forn."
332:                     .Height    = 15
333:                     .Left      = 5
334:                     .Top       = 41
335:                     .Width     = 99
336:                     .AutoSize  = .T.
337:                     .BackStyle = 0
338:                     .FontName  = "Tahoma"
339:                     .FontSize  = 8
340:                     .ForeColor = RGB(90, 90, 90)
341:                     .Themes    = .F.
342:                 ENDWITH
343:             ENDWITH
344: 
345:             *-- Label Preco: (oculto por padrao - visivel para PEDIDO tipos)
346:             .AddObject("lbl_4c_Say6", "Label")
347:             WITH .lbl_4c_Say6
348:                 .AutoSize  = .T.
349:                 .FontBold  = .T.
350:                 .FontName  = "Tahoma"
351:                 .FontSize  = 8
352:                 .Caption   = "Pre" + CHR(231) + "o :"
353:                 .Height    = 15
354:                 .Left      = 297
355:                 .Top       = 142
356:                 .Width     = 40
357:                 .BackStyle = 0
358:                 .ForeColor = RGB(90, 90, 90)
359:                 .Visible   = .F.
360:             ENDWITH

*-- Linhas 367 a 481:
367:                 .BackStyle   = 0
368:                 .Value       = 1
369:                 .Height      = 44
370:                 .Left        = 335
371:                 .Top         = 140
372:                 .Width       = 123
373:                 .Themes      = .T.
374:                 .Visible     = .F.
375: 
376:                 WITH .Buttons(1)
377:                     .Caption   = "Venda"
378:                     .Height    = 15
379:                     .Left      = 5
380:                     .Top       = 5
381:                     .Width     = 48
382:                     .AutoSize  = .T.
383:                     .BackStyle = 0
384:                     .ForeColor = RGB(90, 90, 90)
385:                     .Themes    = .F.
386:                 ENDWITH
387: 
388:                 WITH .Buttons(2)
389:                     .Caption   = "Custo"
390:                     .Height    = 15
391:                     .Left      = 5
392:                     .Top       = 22
393:                     .Width     = 46
394:                     .AutoSize  = .T.
395:                     .BackStyle = 0
396:                     .FontName  = "Tahoma"
397:                     .FontSize  = 8
398:                     .ForeColor = RGB(90, 90, 90)
399:                     .Themes    = .F.
400:                 ENDWITH
401:             ENDWITH
402: 
403:             *-- Label Clique e Arraste para Mudar
404:             .AddObject("lbl_4c_Say2", "Label")
405:             WITH .lbl_4c_Say2
406:                 .AutoSize  = .T.
407:                 .FontBold  = .T.
408:                 .FontName  = "Tahoma"
409:                 .FontSize  = 8
410:                 .Caption   = "Clique e Arraste para Mudar"
411:                 .Height    = 15
412:                 .Left      = 83
413:                 .Top       = 204
414:                 .Width     = 160
415:                 .BackStyle = 0
416:                 .ForeColor = RGB(90, 90, 90)
417:             ENDWITH
418: 
419:             *-- Checkbox Cabecalho na 1a Linha
420:             .AddObject("chk_4c_Cabecalho", "CheckBox")
421:             WITH .chk_4c_Cabecalho
422:                 .Top         = 204
423:                 .Left        = 289
424:                 .Height      = 15
425:                 .Width       = 142
426:                 .FontBold    = .T.
427:                 .FontName    = "Tahoma"
428:                 .FontSize    = 8
429:                 .AutoSize    = .T.
430:                 .Alignment   = 0
431:                 .BackStyle   = 0
432:                 .Caption     = "Cabe" + CHR(231) + "alho na 1" + CHR(170) + " Linha"
433:                 .Value       = 0
434:                 .ForeColor   = RGB(90, 90, 90)
435:             ENDWITH
436:         ENDWITH
437:     ENDPROC
438: 
439:     *==========================================================================
440:     PROTECTED PROCEDURE ConfigurarBotoes
441:     *==========================================================================
442:         *-- Botao Processar (Command1 do legado: Left=650, Top=3)
443:         THIS.AddObject("cmd_4c_Processar", "CommandButton")
444:         WITH THIS.cmd_4c_Processar
445:             .Top             = 3
446:             .Left            = 650
447:             .Width           = 75
448:             .Height          = 75
449:             .Caption         = "Processar"
450:             .Picture         = gc_4c_CaminhoIcones + "geral_processar_60.jpg"
451:             .DisabledPicture = gc_4c_CaminhoIcones + "geral_processar_60.jpg"
452:             .Themes          = .T.
453:             .FontName        = "Comic Sans MS"
454:             .FontSize        = 8
455:             .FontBold        = .T.
456:             .FontItalic      = .T.
457:             .ForeColor       = RGB(90, 90, 90)
458:             .BackColor       = RGB(255, 255, 255)
459:             .WordWrap        = .T.
460:             .MousePointer    = 15
461:         ENDWITH
462: 
463:         *-- Botao Encerrar (Command2 do legado: Left=725, Top=3)
464:         THIS.AddObject("cmd_4c_Encerrar", "CommandButton")
465:         WITH THIS.cmd_4c_Encerrar
466:             .Top             = 3
467:             .Left            = 725
468:             .Width           = 75
469:             .Height          = 75
470:             .Caption         = "Encerrar"
471:             .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
472:             .DisabledPicture = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
473:             .Cancel          = .T.
474:             .Themes          = .T.
475:             .FontName        = "Comic Sans MS"
476:             .FontSize        = 8
477:             .FontBold        = .T.
478:             .FontItalic      = .T.
479:             .ForeColor       = RGB(90, 90, 90)
480:             .BackColor       = RGB(255, 255, 255)
481:             .WordWrap        = .T.

*-- Linhas 487 a 495:
487:     * ConfigurarPaginaLista - Monta o painel de entrada (equivalente logico da
488:     * Page1 Lista do pipeline CRUD). Formsigprila e OPERACIONAL (layout flat
489:     * 800x350 sem PageFrame): agrupa combo de tipo, textbox do arquivo,
490:     * listbox de colunas, option groups de validacao/preco e checkbox de
491:     * cabecalho no container cnt_4c_Planilha.
492:     *==========================================================================
493:     PROTECTED PROCEDURE ConfigurarPaginaLista
494:         THIS.ConfigurarPainelPlanilha()
495:     ENDPROC

*-- Linhas 536 a 549:
536:             IF PEMSTATUS(THIS.cnt_4c_Planilha, "obj_4c_OptTipo", 5)
537:                 THIS.cnt_4c_Planilha.obj_4c_OptTipo.Value  = 1
538:                 THIS.cnt_4c_Planilha.obj_4c_OptTipo.Visible = .F.
539:                 THIS.cnt_4c_Planilha.lbl_4c_Say5.Visible    = .F.
540:             ENDIF
541:             IF PEMSTATUS(THIS.cnt_4c_Planilha, "obj_4c_OptPreco", 5)
542:                 THIS.cnt_4c_Planilha.obj_4c_OptPreco.Value  = 1
543:                 THIS.cnt_4c_Planilha.obj_4c_OptPreco.Visible = .F.
544:                 THIS.cnt_4c_Planilha.lbl_4c_Say6.Visible     = .F.
545:             ENDIF
546: 
547:             *-- Descarta cursores de processamento anterior para nova importacao
548:             IF USED("TmpPlanilha")
549:                 USE IN TmpPlanilha

*-- Linhas 573 a 584:
573:     *==========================================================================
574:         BINDEVENT(THIS.cnt_4c_Planilha.cbo_4c_CmbTipos, "InteractiveChange", ;
575:             THIS, "CmbTiposInteractiveChange")
576:         BINDEVENT(THIS.cnt_4c_Planilha.cmd_4c_Cmdgetp, "Click", ;
577:             THIS, "CmdgetpClick")
578:         BINDEVENT(THIS.cmd_4c_Processar, "Click", THIS, "CmdokClick")
579:         BINDEVENT(THIS.cmd_4c_Encerrar, "Click",  THIS, "CmdsairClick")
580:         BINDEVENT(THIS, "KeyPress", THIS, "FormKeyPress")
581:     ENDPROC
582: 
583:     *==========================================================================
584:     * TornarControlesVisiveis - Torna controles visiveis recursivamente.

*-- Linhas 608 a 616:
608: 
609:             *-- Controles condicionais ou com Visible gerenciado externamente preservam estado
610:             IF INLIST(loc_cNome, "OBJ_4C_OPTTIPO", "OBJ_4C_OPTPRECO", ;
611:                     "LBL_4C_SAY5", "LBL_4C_SAY6", "CNT_4C_CABECALHO")
612:                 *-- Container preserva estado inicial, mas recursar para sub-controles Visible=.T.
613:                 IF PEMSTATUS(loc_oControl, "ControlCount", 5) AND loc_oControl.ControlCount > 0
614:                     THIS.TornarControlesVisiveis(loc_oControl)
615:                 ENDIF
616:                 LOOP

*-- Linhas 654 a 664:
654: 
655:         WITH THIS.cnt_4c_Planilha
656:             .obj_4c_List1.RowSource = loc_cColunaLi
657:             .lbl_4c_Say5.Visible    = loc_lVisOpt
658:             .obj_4c_OptTipo.Visible = loc_lVisOpt
659:             .lbl_4c_Say6.Visible    = loc_lVisPreco
660:             .obj_4c_OptPreco.Visible = loc_lVisPreco
661:             .Visible     = .T.
662:         ENDWITH
663:     ENDPROC
664: 

*-- Linhas 698 a 706:
698:         loc_cArquivo = ALLTRIM(NVL(THIS.cnt_4c_Planilha.txt_4c_Planilha.Value, ""))
699:         IF EMPTY(loc_cArquivo)
700:             MsgAviso("Arquivo Inv" + CHR(225) + "lido")
701:             THIS.cnt_4c_Planilha.cmd_4c_Cmdgetp.SetFocus
702:             RETURN
703:         ENDIF
704: 
705:         loc_nTipo      = THIS.cnt_4c_Planilha.obj_4c_OptTipo.Value
706:         loc_nPreco     = THIS.cnt_4c_Planilha.obj_4c_OptPreco.Value

*-- Linhas 749 a 763:
749:         loc_cArquivo = ALLTRIM(NVL(THIS.cnt_4c_Planilha.txt_4c_Planilha.Value, ""))
750:         IF EMPTY(loc_cArquivo)
751:             MsgAviso("Selecione o arquivo de planilha antes de visualizar.")
752:             THIS.cnt_4c_Planilha.cmd_4c_Cmdgetp.SetFocus
753:             RETURN
754:         ENDIF
755: 
756:         IF !FILE(loc_cArquivo)
757:             MsgAviso("Arquivo n" + CHR(227) + "o encontrado:" + CHR(13) + loc_cArquivo)
758:             THIS.cnt_4c_Planilha.cmd_4c_Cmdgetp.SetFocus
759:             RETURN
760:         ENDIF
761: 
762:         loc_cRotina = ""
763:         IF USED("ComboTipo") AND !EOF("ComboTipo")

*-- Linhas 851 a 873:
851: 
852:     *==========================================================================
853:     * HabilitarCampos - Habilita ou desabilita controles de entrada.
854:     * cmd_4c_Cmdgetp tem Caption="" (icone-only) - nao recebe .Enabled conforme
855:     * regra de standalone icon-only buttons.
856:     *==========================================================================
857:     PROCEDURE HabilitarCampos(par_lHabilitar)
858:         LOCAL loc_lHab
859:         loc_lHab = IIF(VARTYPE(par_lHabilitar) = "L", par_lHabilitar, .T.)
860: 
861:         WITH THIS.cnt_4c_Planilha
862:             .cbo_4c_CmbTipos.Enabled  = loc_lHab
863:             .chk_4c_Cabecalho.Enabled = loc_lHab
864:             .Visible     = .T.
865:         ENDWITH
866: 
867:         IF PEMSTATUS(THIS, "cmd_4c_Processar", 5)
868:             THIS.cmd_4c_Processar.Enabled = loc_lHab
869:         ENDIF
870:     ENDPROC
871: 
872:     *==========================================================================
873:     * LimparCampos - Limpa todos os campos de entrada e cursores temporarios

*-- Linhas 883 a 894:
883:                 .obj_4c_List1.Clear()
884:                 .obj_4c_OptTipo.Value    = 1
885:                 .obj_4c_OptTipo.Visible  = .F.
886:                 .lbl_4c_Say5.Visible     = .F.
887:                 .obj_4c_OptPreco.Value   = 1
888:                 .obj_4c_OptPreco.Visible = .F.
889:                 .lbl_4c_Say6.Visible     = .F.
890:             ENDWITH
891: 
892:             IF USED("TmpPlanilha")
893:                 USE IN TmpPlanilha
894:             ENDIF

*-- Linhas 918 a 926:
918:     ENDPROC
919: 
920:     *==========================================================================
921:     * AjustarBotoesPorModo - Habilita cmd_4c_Processar somente quando tipo
922:     * e arquivo estao preenchidos. Formsigprila nao tem modos CRUD; "modo"
923:     * aqui equivale ao estado de preenchimento dos campos obrigatorios.
924:     *==========================================================================
925:     PROCEDURE AjustarBotoesPorModo()
926:         LOCAL loc_lTipoOk, loc_lArqOk

*-- Linhas 934 a 943:
934:             loc_lArqOk = !EMPTY(NVL(THIS.cnt_4c_Planilha.txt_4c_Planilha.Value, ""))
935:         ENDIF
936: 
937:         IF PEMSTATUS(THIS, "cmd_4c_Processar", 5)
938:             THIS.cmd_4c_Processar.Enabled = (loc_lTipoOk AND loc_lArqOk)
939:         ENDIF
940:     ENDPROC
941: 
942:     *==========================================================================
943:     PROCEDURE Destroy


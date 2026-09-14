# CODE REVIEW - PASS VISUAL: Visual Properties (alinhamento, titulos, tipos)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Visual Properties (alinhamento, titulos, tipos)**.

## PROBLEMAS DETECTADOS (1)
- [LAYOUT-POSITION] Controle 'TpRel' (parent: SIGREFC1): Top original=174 vs migrado 'opt_4c_TpRel' Top=89 (diff=85px, tolerancia=30px)

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

### FORM (C:\4c\projeto\app\forms\relatorios\Formsigrefc1.prg) - TRECHOS RELEVANTES PARA PASS VISUAL (1027 linhas total):

*-- Linhas 53 a 61:
53:         loc_lSucesso   = .F.
54:         loc_lContinuar = .T.
55:         TRY
56:             THIS.Caption = "Fechamento de Caixa"
57: 
58:             IF TYPE("gc_4c_CaminhoIcones") = "U"
59:                 gc_4c_CaminhoIcones = ""
60:             ENDIF
61:             THIS.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"

*-- Linhas 80 a 89:
80:                 *-- PageFrame com 1 pagina de filtros
81:                 THIS.ConfigurarPageFrame()
82: 
83:                 THIS.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
84:                 THIS.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
85: 
86:                 *-- Campos de filtro na Page1 + OptionGroup + BINDEVENTs
87:                 THIS.ConfigurarPaginaLista()
88: 
89:                 *-- Vincular Click dos botoes do relatorio

*-- Linhas 115 a 192:
115:     PROTECTED PROCEDURE ConfigurarCabecalho()
116:         THIS.AddObject("cnt_4c_Cabecalho", "Container")
117:         WITH THIS.cnt_4c_Cabecalho
118:             .Top         = 0
119:             .Left        = 0
120:             .Width       = THIS.Width
121:             .Height      = 80
122:             .BackStyle   = 1
123:             .BackColor   = RGB(100, 100, 100)
124:             .BorderWidth = 0
125:             .Visible     = .T.
126: 
127:             *-- Sombra (deslocada 2px para efeito 3D do texto branco)
128:             .AddObject("lbl_4c_Sombra", "Label")
129:             WITH .lbl_4c_Sombra
130:                 .Top       = 22
131:                 .Left      = 22
132:                 .Width     = THIS.Width
133:                 .Height    = 30
134:                 .Caption   = "Fechamento de Caixa"
135:                 .FontName  = "Tahoma"
136:                 .FontSize  = 14
137:                 .FontBold  = .T.
138:                 .ForeColor = RGB(0, 0, 0)
139:                 .BackStyle = 0
140:                 .Visible   = .T.
141:             ENDWITH
142: 
143:             *-- Titulo em branco (sobre a sombra)
144:             .AddObject("lbl_4c_Titulo", "Label")
145:             WITH .lbl_4c_Titulo
146:                 .Top       = 20
147:                 .Left      = 20
148:                 .Width     = THIS.Width
149:                 .Height    = 30
150:                 .Caption   = "Fechamento de Caixa"
151:                 .FontName  = "Tahoma"
152:                 .FontSize  = 14
153:                 .FontBold  = .T.
154:                 .ForeColor = RGB(255, 255, 255)
155:                 .BackStyle = 0
156:                 .Visible   = .T.
157:             ENDWITH
158:         ENDWITH
159:     ENDPROC
160: 
161:     *--------------------------------------------------------------------------
162:     * ConfigurarBotoes - CommandGroup de botoes do relatorio (btnReport area)
163:     *   Original: btnReport.Left=534, Top=0
164:     *   Botoes: Visualiza(5), Imprime(71), DocExcel(137), Sair(203) - W=65 cada
165:     *--------------------------------------------------------------------------
166:     PROTECTED PROCEDURE ConfigurarBotoes()
167:         THIS.AddObject("cmg_4c_Botoes", "CommandGroup")
168:         WITH THIS.cmg_4c_Botoes
169:             .Top           = 0
170:             .Left          = 529
171:             .Width         = 273
172:             .Height        = 80
173:             .ButtonCount   = 4
174:             .BackStyle     = 0
175:             .BorderStyle   = 0
176:             .BorderColor   = RGB(136, 189, 188)
177:             .SpecialEffect = 1
178:             .Themes        = .F.
179:             .Visible       = .T.
180: 
181:             *-- Visualizar (preview em tela)
182:             WITH .Buttons(1)
183:                 .Top             = 5
184:                 .Left            = 5
185:                 .Width           = 65
186:                 .Height          = 70
187:                 .Caption         = "Visualizar"
188:                 .FontBold        = .T.
189:                 .FontItalic      = .T.
190:                 .BackColor       = RGB(255, 255, 255)
191:                 .ForeColor       = RGB(90, 90, 90)
192:                 .Picture         = gc_4c_CaminhoIcones + "relatorio_video_26.jpg"

*-- Linhas 200 a 212:
200: 
201:             *-- Imprimir (impressora)
202:             WITH .Buttons(2)
203:                 .Top             = 5
204:                 .Left            = 71
205:                 .Width           = 65
206:                 .Height          = 70
207:                 .Caption         = "Imprimir"
208:                 .FontName        = "Tahoma"
209:                 .FontBold        = .T.
210:                 .FontItalic      = .T.
211:                 .FontSize        = 8
212:                 .BackColor       = RGB(255, 255, 255)

*-- Linhas 222 a 234:
222: 
223:             *-- Excel (exportar dados)
224:             WITH .Buttons(3)
225:                 .Top             = 5
226:                 .Left            = 137
227:                 .Width           = 65
228:                 .Height          = 70
229:                 .Caption         = "Excel"
230:                 .FontName        = "Tahoma"
231:                 .FontBold        = .T.
232:                 .FontItalic      = .T.
233:                 .FontSize        = 8
234:                 .BackColor       = RGB(255, 255, 255)

*-- Linhas 244 a 256:
244: 
245:             *-- Encerrar (fechar form - ESC)
246:             WITH .Buttons(4)
247:                 .Top             = 5
248:                 .Left            = 203
249:                 .Width           = 65
250:                 .Height          = 70
251:                 .Caption         = "Encerrar"
252:                 .Cancel          = .T.
253:                 .FontName        = "Tahoma"
254:                 .FontBold        = .T.
255:                 .FontItalic      = .T.
256:                 .FontSize        = 8

*-- Linhas 280 a 295:
280:         *-- PageCount OBRIGATORIAMENTE antes de acessar Page1
281:         loc_oPgf.PageCount = 1
282: 
283:         loc_oPgf.Top    = 85
284:         loc_oPgf.Left   = -1
285:         loc_oPgf.Width  = THIS.Width + 2
286:         loc_oPgf.Height = THIS.Height - 85
287:         loc_oPgf.Tabs   = .F.
288: 
289:         *-- Configurar Page1 (FORA de WITH - referencia direta)
290:         loc_oPgf.Page1.Caption   = "Filtros"
291:         loc_oPgf.Page1.FontName  = "Tahoma"
292:         loc_oPgf.Page1.FontSize  = 8
293:         loc_oPgf.Page1.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
294:         loc_oPgf.Page1.BackColor = RGB(255, 255, 255)
295:         loc_oPgf.Page1.ForeColor = RGB(90, 90, 90)

*-- Linhas 310 a 336:
310:         loc_oPg = THIS.pgf_4c_Paginas.Page1
311: 
312:         *-- Label "Empresa :"
313:         loc_oPg.AddObject("lbl_4c_LblEmpresa", "Label")
314:         WITH loc_oPg.lbl_4c_LblEmpresa
315:             .Top       = 38
316:             .Left      = 214
317:             .Width     = 48
318:             .Height    = 15
319:             .Caption   = "Empresa :"
320:             .FontName  = "Tahoma"
321:             .FontSize  = 8
322:             .ForeColor = RGB(90, 90, 90)
323:             .BackStyle = 0
324:             .Visible   = .T.
325:         ENDWITH
326: 
327:         *-- Codigo da empresa (MaxLength=3, uppercase - original Format="K!")
328:         loc_oPg.AddObject("txt_4c_CdEmpresa", "TextBox")
329:         WITH loc_oPg.txt_4c_CdEmpresa
330:             .Top           = 35
331:             .Left          = 267
332:             .Width         = 31
333:             .Height        = 23
334:             .Value         = ""
335:             .MaxLength     = 3
336:             .InputMask     = "!"

*-- Linhas 345 a 354:
345:         *-- Descricao da empresa (readonly, preenchida pelo lookup)
346:         loc_oPg.AddObject("txt_4c_DsEmpresa", "TextBox")
347:         WITH loc_oPg.txt_4c_DsEmpresa
348:             .Top           = 35
349:             .Left          = 300
350:             .Width         = 289
351:             .Height        = 23
352:             .Value         = ""
353:             .MaxLength     = 40
354:             .FontName      = "Tahoma"

*-- Linhas 360 a 386:
360:         ENDWITH
361: 
362:         *-- Label "Periodo :"
363:         loc_oPg.AddObject("lbl_4c_LblPeriodo", "Label")
364:         WITH loc_oPg.lbl_4c_LblPeriodo
365:             .Top       = 63
366:             .Left      = 219
367:             .Width     = 48
368:             .Height    = 15
369:             .Caption   = "Per" + CHR(237) + "odo :"
370:             .FontName  = "Tahoma"
371:             .FontSize  = 8
372:             .ForeColor = RGB(90, 90, 90)
373:             .BackStyle = 0
374:             .Visible   = .T.
375:         ENDWITH
376: 
377:         *-- Data inicial (original: get_dt_inicial, Left=267, Top=145)
378:         loc_oPg.AddObject("txt_4c_DtInicial", "TextBox")
379:         WITH loc_oPg.txt_4c_DtInicial
380:             .Top           = 60
381:             .Left          = 267
382:             .Width         = 80
383:             .Height        = 23
384:             .Value         = {}
385:             .Format        = "D"
386:             .FontName      = "Tahoma"

*-- Linhas 392 a 418:
392:         ENDWITH
393: 
394:         *-- Separador "a" entre datas (original: Say1, Left=351, Caption="a")
395:         loc_oPg.AddObject("lbl_4c_SepDatas", "Label")
396:         WITH loc_oPg.lbl_4c_SepDatas
397:             .Top       = 63
398:             .Left      = 351
399:             .Width     = 10
400:             .Height    = 15
401:             .Caption   = "a"
402:             .FontName  = "Tahoma"
403:             .FontSize  = 8
404:             .ForeColor = RGB(90, 90, 90)
405:             .BackStyle = 0
406:             .Visible   = .T.
407:         ENDWITH
408: 
409:         *-- Data final (original: get_dt_final, Left=364, Top=145)
410:         loc_oPg.AddObject("txt_4c_DtFinal", "TextBox")
411:         WITH loc_oPg.txt_4c_DtFinal
412:             .Top           = 60
413:             .Left          = 364
414:             .Width         = 80
415:             .Height        = 23
416:             .Value         = {}
417:             .Format        = "D"
418:             .FontName      = "Tahoma"

*-- Linhas 424 a 438:
424:         ENDWITH
425: 
426:         *-- Label "Tipo :" (original: Say3, Left=235, Top=179)
427:         loc_oPg.AddObject("lbl_4c_LblTipo", "Label")
428:         WITH loc_oPg.lbl_4c_LblTipo
429:             .Top       = 94
430:             .Left      = 235
431:             .Width     = 30
432:             .Height    = 15
433:             .Caption   = "Tipo :"
434:             .FontName  = "Tahoma"
435:             .FontSize  = 8
436:             .ForeColor = RGB(90, 90, 90)
437:             .BackStyle = 0
438:             .Visible   = .T.

*-- Linhas 451 a 506:
451:     PROTECTED PROCEDURE ConfigurarPaginaDados()
452:         LOCAL loc_oPg
453:         loc_oPg = THIS.pgf_4c_Paginas.Page1
454: 
455:         *-- OptionGroup TpRel (original: ButtonCount=2, Top=174, Left=256)
456:         loc_oPg.AddObject("opt_4c_TpRel", "OptionGroup")
457:         loc_oPg.opt_4c_TpRel.ButtonCount = 2
458:         WITH loc_oPg.opt_4c_TpRel
459:             .Top         = 89
460:             .Left        = 256
461:             .Width       = 155
462:             .Height      = 47
463:             .BackStyle   = 0
464:             .BorderStyle = 0
465:             .Visible     = .T.
466:         ENDWITH
467:         WITH loc_oPg.opt_4c_TpRel.Buttons(1)
468:             .Caption   = "Vis" + CHR(227) + "o detalhada"
469:             .Left      = 7
470:             .Top       = 5
471:             .Width     = 94
472:             .Height    = 15
473:             .FontName  = "Tahoma"
474:             .FontSize  = 8
475:             .BackStyle = 0
476:             .AutoSize  = .F.
477:             .ForeColor = RGB(90, 90, 90)
478:         ENDWITH
479:         WITH loc_oPg.opt_4c_TpRel.Buttons(2)
480:             .Caption   = "Mapa de Fechamento"
481:             .Left      = 7
482:             .Top       = 26
483:             .Width     = 121
484:             .Height    = 15
485:             .FontName  = "Tahoma"
486:             .FontSize  = 8
487:             .BackStyle = 0
488:             .AutoSize  = .F.
489:             .ForeColor = RGB(90, 90, 90)
490:         ENDWITH
491:         loc_oPg.opt_4c_TpRel.Value = 1
492: 
493:         *-- Vincular handlers de teclado (F4=115, ENTER=13, TAB=9)
494:         BINDEVENT(loc_oPg.txt_4c_CdEmpresa, "KeyPress", THIS, "TeclaCdEmpresa")
495:         BINDEVENT(loc_oPg.txt_4c_DsEmpresa, "KeyPress", THIS, "TeclaDsEmpresa")
496:         BINDEVENT(loc_oPg.txt_4c_DtInicial, "KeyPress", THIS, "TeclaDataInicial")
497:         BINDEVENT(loc_oPg.txt_4c_DtFinal,   "KeyPress", THIS, "TeclaDataFinal")
498: 
499:         *-- DblClick tambem abre lookup de empresa
500:         BINDEVENT(loc_oPg.txt_4c_CdEmpresa, "DblClick", THIS, "AbrirBuscaCdEmpresa")
501:         BINDEVENT(loc_oPg.txt_4c_DsEmpresa, "DblClick", THIS, "AbrirBuscaDsEmpresa")
502:     ENDPROC
503: 
504:     *--------------------------------------------------------------------------
505:     * LimparCampos - Restaura filtros para valores padrao.
506:     *   Empresa = empresa logada (go_4c_Sistema), datas = hoje, tipo = 1.

*-- Linhas 529 a 549:
529:                     USE IN cursor_4c_EmpInit
530:                 ENDIF
531:             ENDIF
532:             loc_oPg.txt_4c_DtInicial.Value = DATE()
533:             loc_oPg.txt_4c_DtFinal.Value   = DATE()
534:             loc_oPg.opt_4c_TpRel.Value     = 1
535:         CATCH TO loc_oErro
536:             MsgErro(loc_oErro.Message, "Erro LimparCampos")
537:         ENDTRY
538:     ENDPROC
539: 
540:     *--------------------------------------------------------------------------
541:     * AlternarPagina - Ativa pagina no PageFrame (1 pagina neste relatorio).
542:     *   Reposiciona foco no campo Empresa apos retornar ao filtro.
543:     *--------------------------------------------------------------------------
544:     PROCEDURE AlternarPagina(par_nPagina)
545:         LOCAL loc_oPgf, loc_oPg
546:         TRY
547:             loc_oPgf = THIS.pgf_4c_Paginas
548:             IF VARTYPE(loc_oPgf) = "O"
549:                 loc_oPgf.ActivePage = 1

*-- Linhas 567 a 587:
567:         WITH THIS.this_oRelatorio
568:             .this_cCodEmpresa = ALLTRIM(loc_oPg.txt_4c_CdEmpresa.Value)
569:             .this_cDesEmpresa = ALLTRIM(loc_oPg.txt_4c_DsEmpresa.Value)
570:             .this_dDtInicial  = loc_oPg.txt_4c_DtInicial.Value
571:             .this_dDtFinal    = loc_oPg.txt_4c_DtFinal.Value
572:             .this_nTpRel      = loc_oPg.opt_4c_TpRel.Value
573:         ENDWITH
574:     ENDPROC
575: 
576:     *--------------------------------------------------------------------------
577:     * ValidarPeriodo - Verifica data final >= data inicial.
578:     *--------------------------------------------------------------------------
579:     PROTECTED PROCEDURE ValidarPeriodo()
580:         LOCAL loc_oPg, loc_dIni, loc_dFim
581:         loc_oPg  = THIS.pgf_4c_Paginas.Page1
582:         loc_dIni = loc_oPg.txt_4c_DtInicial.Value
583:         loc_dFim = loc_oPg.txt_4c_DtFinal.Value
584:         IF !EMPTY(loc_dIni) AND !EMPTY(loc_dFim) AND loc_dIni > loc_dFim
585:             MsgAviso("Data Final Menor Que a Inicial!!!", ;
586:                 "Aten" + CHR(231) + CHR(227) + "o")
587:             loc_oPg.txt_4c_DtFinal.SetFocus()

*-- Linhas 718 a 739:
718:                     .txt_4c_DtInicial.Enabled = loc_lEnable
719:                 ENDIF
720:                 IF PEMSTATUS(.txt_4c_DtFinal, "Enabled", 5)
721:                     .txt_4c_DtFinal.Enabled = loc_lEnable
722:                 ENDIF
723:                 IF PEMSTATUS(.opt_4c_TpRel, "Enabled", 5)
724:                     .opt_4c_TpRel.Enabled = loc_lEnable
725:                 ENDIF
726:             ENDWITH
727:             IF PEMSTATUS(THIS.cmg_4c_Botoes, "Enabled", 5)
728:                 THIS.cmg_4c_Botoes.Enabled = loc_lEnable
729:             ENDIF
730:         CATCH TO loc_oErro
731:             MsgErro(loc_oErro.Message, "HabilitarCampos")
732:         ENDTRY
733:     ENDPROC
734: 
735:     *--------------------------------------------------------------------------
736:     * BOParaForm - Carrega propriedades do BO nos controles do formulario.
737:     *   Inverso de FormParaRelatorio. Util para repopular tela apos erro
738:     *   ou ao reabrir com parametros salvos.
739:     *--------------------------------------------------------------------------

*-- Linhas 747 a 767:
747:             WITH THIS.this_oRelatorio
748:                 loc_oPg.txt_4c_CdEmpresa.Value = ALLTRIM(.this_cCodEmpresa)
749:                 loc_oPg.txt_4c_DsEmpresa.Value = ALLTRIM(.this_cDesEmpresa)
750:                 loc_oPg.txt_4c_DtInicial.Value = .this_dDtInicial
751:                 loc_oPg.txt_4c_DtFinal.Value   = .this_dDtFinal
752:                 loc_oPg.opt_4c_TpRel.Value     = IIF(.this_nTpRel >= 1 AND .this_nTpRel <= 2, ;
753:                     .this_nTpRel, 1)
754:             ENDWITH
755:         CATCH TO loc_oErro
756:             MsgErro(loc_oErro.Message, "BOParaForm")
757:         ENDTRY
758:     ENDPROC
759: 
760:     *--------------------------------------------------------------------------
761:     * FormParaBO - Alias semantico de FormParaRelatorio (contratos CRUD).
762:     *   Forms CRUD chamam FormParaBO; este form de relatorio delega para
763:     *   FormParaRelatorio que ja implementa a coleta dos filtros.
764:     *--------------------------------------------------------------------------
765:     PROCEDURE FormParaBO()
766:         THIS.FormParaRelatorio()
767:     ENDPROC


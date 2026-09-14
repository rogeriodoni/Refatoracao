# CODE REVIEW - PASS VISUAL: Visual Properties (alinhamento, titulos, tipos)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Visual Properties (alinhamento, titulos, tipos)**.

## PROBLEMAS DETECTADOS (2)
- [LAYOUT-POSITION] Controle 'optTipImps' (parent: SIGREHCP): Top original=196 vs migrado 'opt_4c_OptTipImps' Top=111 (diff=85px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'lblEmpresa' (parent: SIGREHCP): Top original=123 vs migrado 'lbl_4c_LblEmpresa' Top=38 (diff=85px, tolerancia=30px)

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

### FORM (C:\4c\projeto\app\forms\relatorios\FormSIGREHCP.prg) - TRECHOS RELEVANTES PARA PASS VISUAL (1234 linhas total):

*-- Linhas 6 a 26:
6: *
7: * Filtros (Page1):
8: *   - Empresa  (txt_4c_CEmps/txt_4c_DEmps) - oculto quando CalcCustos=1
9: *   - Periodo  (txt_4c_DtInicial / txt_4c_DtFinal)
10: *   - Produto  (txt_4c_CPros/txt_4c_DPros) - lookup SigCdPro
11: *   - Tipo Impressao: opt_4c_OptTipImps (1=Relacao Padrao / 2=Modelo 3)
12: *
13: * Relatorios:
14: *   SigRehc1.frx -> Empresa+Produto (CalcCustos<>1, TipoImps=1)
15: *   SigRehc2.frx -> Produto apenas  (CalcCustos=1,  TipoImps=1)
16: *   SigRehc3.frx -> Modelo 3 Livro Fiscal (TipoImps=2)
17: *==============================================================================
18: 
19: DEFINE CLASS FormSIGREHCP AS FormBase
20: 
21:     *-- Dimensoes e aparencia (EXATAS do original: Width=800, Height=300)
22:     Height      = 300
23:     Width       = 800
24:     DataSession = 2
25:     ShowWindow  = 1
26:     WindowType  = 1

*-- Linhas 55 a 63:
55:         loc_lSucesso   = .F.
56:         loc_lContinuar = .T.
57:         TRY
58:             THIS.Caption = "Relat" + CHR(243) + "rio de Hist" + CHR(243) + ;
59:                 "rico de Custo de Produtos"
60: 
61:             IF TYPE("gc_4c_CaminhoIcones") = "U"
62:                 gc_4c_CaminhoIcones = ""
63:             ENDIF

*-- Linhas 77 a 86:
77:                 THIS.ConfigurarBotoes()
78:                 THIS.ConfigurarPageFrame()
79: 
80:                 THIS.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
81:                 THIS.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
82: 
83:                 THIS.ConfigurarPaginaLista()
84: 
85:                 *-- Vincular botoes do CommandGroup
86:                 BINDEVENT(THIS.cmg_4c_Botoes.Buttons(1), "Click", THIS, "BtnVisualizarClick")

*-- Linhas 117 a 156:
117:     PROTECTED PROCEDURE ConfigurarCabecalho()
118:         THIS.AddObject("cnt_4c_Cabecalho", "Container")
119:         WITH THIS.cnt_4c_Cabecalho
120:             .Top         = 0
121:             .Left        = 0
122:             .Width       = THIS.Width
123:             .Height      = 80
124:             .BackStyle   = 1
125:             .BackColor   = RGB(100, 100, 100)
126:             .BorderWidth = 0
127:             .Visible     = .T.
128: 
129:             .AddObject("lbl_4c_Sombra", "Label")
130:             WITH .lbl_4c_Sombra
131:                 .Top       = 22
132:                 .Left      = 22
133:                 .Width     = THIS.Width
134:                 .Height    = 30
135:                 .Caption   = "Relat" + CHR(243) + "rio de Hist" + CHR(243) + ;
136:                              "rico de Custo de Produtos"
137:                 .FontName  = "Tahoma"
138:                 .FontSize  = 14
139:                 .FontBold  = .T.
140:                 .ForeColor = RGB(0, 0, 0)
141:                 .BackStyle = 0
142:                 .Visible   = .T.
143:             ENDWITH
144: 
145:             .AddObject("lbl_4c_Titulo", "Label")
146:             WITH .lbl_4c_Titulo
147:                 .Top       = 20
148:                 .Left      = 20
149:                 .Width     = THIS.Width
150:                 .Height    = 30
151:                 .Caption   = "Relat" + CHR(243) + "rio de Hist" + CHR(243) + ;
152:                              "rico de Custo de Produtos"
153:                 .FontName  = "Tahoma"
154:                 .FontSize  = 14
155:                 .FontBold  = .T.
156:                 .ForeColor = RGB(255, 255, 255)

*-- Linhas 162 a 194:
162: 
163:     *--------------------------------------------------------------------------
164:     * ConfigurarBotoes - CommandGroup de 4 botoes de relatorio
165:     *   Original: btnReport.Left=526, 4 botoes (Visualiza/Imprime/DocExcel/Sair)
166:     *   Geometria do framework frmrelatorio: Left=529, Width=273, Height=80
167:     *--------------------------------------------------------------------------
168:     PROTECTED PROCEDURE ConfigurarBotoes()
169:         THIS.AddObject("cmg_4c_Botoes", "CommandGroup")
170:         WITH THIS.cmg_4c_Botoes
171:             .Top           = 0
172:             .Left          = 529
173:             .Width         = 273
174:             .Height        = 80
175:             .ButtonCount   = 4
176:             .BackStyle     = 0
177:             .BorderStyle   = 0
178:             .BorderColor   = RGB(136, 189, 188)
179:             .SpecialEffect = 1
180:             .Themes        = .F.
181:             .Visible       = .T.
182: 
183:             *-- Visualizar (preview em tela)
184:             WITH .Buttons(1)
185:                 .Top             = 5
186:                 .Left            = 5
187:                 .Width           = 65
188:                 .Height          = 70
189:                 .Caption         = "Visualizar"
190:                 .FontBold        = .T.
191:                 .FontItalic      = .T.
192:                 .BackColor       = RGB(255, 255, 255)
193:                 .ForeColor       = RGB(90, 90, 90)
194:                 .Picture         = gc_4c_CaminhoIcones + "relatorio_video_26.jpg"

*-- Linhas 202 a 214:
202: 
203:             *-- Imprimir (impressora)
204:             WITH .Buttons(2)
205:                 .Top             = 5
206:                 .Left            = 71
207:                 .Width           = 65
208:                 .Height          = 70
209:                 .Caption         = "Imprimir"
210:                 .FontName        = "Tahoma"
211:                 .FontBold        = .T.
212:                 .FontItalic      = .T.
213:                 .FontSize        = 8
214:                 .BackColor       = RGB(255, 255, 255)

*-- Linhas 224 a 236:
224: 
225:             *-- Excel (exportar dados)
226:             WITH .Buttons(3)
227:                 .Top             = 5
228:                 .Left            = 137
229:                 .Width           = 65
230:                 .Height          = 70
231:                 .Caption         = "Excel"
232:                 .FontName        = "Tahoma"
233:                 .FontBold        = .T.
234:                 .FontItalic      = .T.
235:                 .FontSize        = 8
236:                 .BackColor       = RGB(255, 255, 255)

*-- Linhas 246 a 258:
246: 
247:             *-- Encerrar (fechar form - ESC)
248:             WITH .Buttons(4)
249:                 .Top             = 5
250:                 .Left            = 203
251:                 .Width           = 65
252:                 .Height          = 70
253:                 .Caption         = "Encerrar"
254:                 .Cancel          = .T.
255:                 .FontName        = "Tahoma"
256:                 .FontBold        = .T.
257:                 .FontItalic      = .T.
258:                 .FontSize        = 8

*-- Linhas 284 a 298:
284:         loc_oPgf.PageCount = 1
285: 
286:         *-- Abaixo do cabecalho (80px) ate o fundo do form
287:         loc_oPgf.Top    = 85
288:         loc_oPgf.Left   = -1
289:         loc_oPgf.Width  = THIS.Width + 2
290:         loc_oPgf.Height = THIS.Height - 85
291:         loc_oPgf.Tabs   = .F.
292: 
293:         loc_oPgf.Page1.Caption   = "Filtros"
294:         loc_oPgf.Page1.FontName  = "Tahoma"
295:         loc_oPgf.Page1.FontSize  = 8
296:         loc_oPgf.Page1.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
297:         loc_oPgf.Page1.BackColor = RGB(255, 255, 255)
298:         loc_oPgf.Page1.ForeColor = RGB(90, 90, 90)

*-- Linhas 310 a 337:
310:         LOCAL loc_oPg
311:         loc_oPg = THIS.pgf_4c_Paginas.Page1
312: 
313:         *-- EMPRESA (original: lblEmpresa.Top=123 -> 38; getCEmps.Top=120 -> 35)
314:         loc_oPg.AddObject("lbl_4c_LblEmpresa", "Label")
315:         WITH loc_oPg.lbl_4c_LblEmpresa
316:             .Top       = 38
317:             .Left      = 199
318:             .Width     = 50
319:             .Height    = 15
320:             .Caption   = "Empresa :"
321:             .FontName  = "Tahoma"
322:             .FontSize  = 8
323:             .ForeColor = RGB(90, 90, 90)
324:             .BackStyle = 0
325:             .Visible   = .T.
326:         ENDWITH
327: 
328:         *-- Codigo da empresa (3 chars, InputMask XXX)
329:         loc_oPg.AddObject("txt_4c_CEmps", "TextBox")
330:         WITH loc_oPg.txt_4c_CEmps
331:             .Top           = 35
332:             .Left          = 254
333:             .Width         = 31
334:             .Height        = 23
335:             .Value         = ""
336:             .MaxLength     = 3
337:             .InputMask     = "XXX"

*-- Linhas 347 a 356:
347:         *-- Descricao da empresa (preenchida pelo lookup ou digitacao)
348:         loc_oPg.AddObject("txt_4c_DEmps", "TextBox")
349:         WITH loc_oPg.txt_4c_DEmps
350:             .Top           = 35
351:             .Left          = 288
352:             .Width         = 303
353:             .Height        = 23
354:             .Value         = ""
355:             .MaxLength     = 40
356:             .Format        = "K"

*-- Linhas 362 a 453:
362:             .Visible       = .T.
363:         ENDWITH
364: 
365:         *-- PERIODO (original: Say1.Top=149 -> 64; getDtInicial.Top=146 -> 61)
366:         loc_oPg.AddObject("lbl_4c_Label1", "Label")
367:         WITH loc_oPg.lbl_4c_Label1
368:             .Top       = 64
369:             .Left      = 204
370:             .Width     = 45
371:             .Height    = 15
372:             .Caption   = "Per" + CHR(237) + "odo :"
373:             .FontName  = "Tahoma"
374:             .FontSize  = 8
375:             .ForeColor = RGB(90, 90, 90)
376:             .BackStyle = 0
377:             .Visible   = .T.
378:         ENDWITH
379: 
380:         *-- Data inicial (original: getDtInicial.Left=254)
381:         loc_oPg.AddObject("txt_4c_DtInicial", "TextBox")
382:         WITH loc_oPg.txt_4c_DtInicial
383:             .Top           = 61
384:             .Left          = 254
385:             .Width         = 80
386:             .Height        = 23
387:             .Value         = {}
388:             .Format        = "D"
389:             .FontName      = "Tahoma"
390:             .FontSize      = 8
391:             .BackColor     = RGB(255, 255, 255)
392:             .ForeColor     = RGB(0, 0, 0)
393:             .SpecialEffect = 1
394:             .Visible       = .T.
395:         ENDWITH
396: 
397:         *-- Label "ate" (original: Say4.Top=149 -> 64; Left=339)
398:         loc_oPg.AddObject("lbl_4c_Label4", "Label")
399:         WITH loc_oPg.lbl_4c_Label4
400:             .Top       = 64
401:             .Left      = 339
402:             .Width     = 20
403:             .Height    = 15
404:             .Caption   = "at" + CHR(233)
405:             .FontName  = "Tahoma"
406:             .FontSize  = 8
407:             .ForeColor = RGB(90, 90, 90)
408:             .BackStyle = 0
409:             .Visible   = .T.
410:         ENDWITH
411: 
412:         *-- Data final (original: getDtFinal.Left=364)
413:         loc_oPg.AddObject("txt_4c_DtFinal", "TextBox")
414:         WITH loc_oPg.txt_4c_DtFinal
415:             .Top           = 61
416:             .Left          = 364
417:             .Width         = 80
418:             .Height        = 23
419:             .Value         = {}
420:             .Format        = "D"
421:             .FontName      = "Tahoma"
422:             .FontSize      = 8
423:             .BackColor     = RGB(255, 255, 255)
424:             .ForeColor     = RGB(0, 0, 0)
425:             .SpecialEffect = 1
426:             .Visible       = .T.
427:         ENDWITH
428: 
429:         *-- PRODUTO (original: Say3.Top=175 -> 90; getCPros.Top=172 -> 87)
430:         loc_oPg.AddObject("lbl_4c_Label3", "Label")
431:         WITH loc_oPg.lbl_4c_Label3
432:             .Top       = 90
433:             .Left      = 202
434:             .Width     = 47
435:             .Height    = 15
436:             .Caption   = "Produto :"
437:             .FontName  = "Tahoma"
438:             .FontSize  = 8
439:             .ForeColor = RGB(90, 90, 90)
440:             .BackStyle = 0
441:             .Visible   = .T.
442:         ENDWITH
443: 
444:         *-- Codigo do produto (14 chars, F4 abre lookup SigCdPro)
445:         loc_oPg.AddObject("txt_4c_CPros", "TextBox")
446:         WITH loc_oPg.txt_4c_CPros
447:             .Top           = 87
448:             .Left          = 254
449:             .Width         = 108
450:             .Height        = 23
451:             .Value         = ""
452:             .MaxLength     = 14
453:             .Format        = "K"

*-- Linhas 462 a 471:
462:         *-- Descricao do produto (preenchida pelo lookup)
463:         loc_oPg.AddObject("txt_4c_DPros", "TextBox")
464:         WITH loc_oPg.txt_4c_DPros
465:             .Top           = 87
466:             .Left          = 365
467:             .Width         = 290
468:             .Height        = 23
469:             .Value         = ""
470:             .MaxLength     = 40
471:             .Format        = "K"

*-- Linhas 490 a 550:
490:         LOCAL loc_oPg
491:         loc_oPg = THIS.pgf_4c_Paginas.Page1
492: 
493:         *-- TIPO DE IMPRESSAO (original: Say11.Top=201 -> 116; opt.Top=196 -> 111)
494:         loc_oPg.AddObject("lbl_4c_Label11", "Label")
495:         WITH loc_oPg.lbl_4c_Label11
496:             .Top       = 116
497:             .Left      = 152
498:             .Width     = 97
499:             .Height    = 15
500:             .Caption   = "Tipo de Impress" + CHR(227) + "o :"
501:             .FontName  = "Tahoma"
502:             .FontSize  = 8
503:             .ForeColor = RGB(90, 90, 90)
504:             .BackStyle = 0
505:             .Visible   = .T.
506:         ENDWITH
507: 
508:         *-- OptionGroup: Relacao Padrao / Modelo 3
509:         *   ButtonCount ANTES de acessar Buttons(N)
510:         loc_oPg.AddObject("opt_4c_OptTipImps", "OptionGroup")
511:         loc_oPg.opt_4c_OptTipImps.ButtonCount = 2
512:         WITH loc_oPg.opt_4c_OptTipImps
513:             .Top         = 111
514:             .Left        = 248
515:             .Width       = 222
516:             .Height      = 27
517:             .BackStyle   = 0
518:             .BorderStyle = 0
519:             .Value       = 1
520:             .Visible     = .T.
521:         ENDWITH
522:         WITH loc_oPg.opt_4c_OptTipImps.Buttons(1)
523:             .Caption     = "Rela" + CHR(231) + CHR(227) + "o Padr" + CHR(227) + "o"
524:             .Left        = 5
525:             .Top         = 6
526:             .Width       = 108
527:             .Height      = 15
528:             .FontName    = "Tahoma"
529:             .FontSize    = 8
530:             .BackStyle   = 0
531:             .AutoSize    = .F.
532:             .ForeColor   = RGB(90, 90, 90)
533:             .ToolTipText = "Impress" + CHR(227) + "o de Relat" + CHR(243) + "rio Padr" + CHR(227) + "o"
534:         ENDWITH
535:         WITH loc_oPg.opt_4c_OptTipImps.Buttons(2)
536:             .Caption     = "Modelo 3"
537:             .Left        = 129
538:             .Top         = 6
539:             .Width       = 83
540:             .Height      = 17
541:             .FontName    = "Tahoma"
542:             .FontSize    = 8
543:             .BackStyle   = 0
544:             .AutoSize    = .F.
545:             .ForeColor   = RGB(90, 90, 90)
546:             .ToolTipText = "Imprimir o Modelo 3 Para Livro Fiscal"
547:         ENDWITH
548: 
549:         *-- Empresa: KeyPress e DblClick
550:         BINDEVENT(loc_oPg.txt_4c_CEmps, "KeyPress", THIS, "TeclaCEmps")

*-- Linhas 577 a 604:
577:             loc_oPg.txt_4c_DEmps.Value       = ""
578:             loc_oPg.txt_4c_DtInicial.Value   = DATE()
579:             loc_oPg.txt_4c_DtFinal.Value     = DATE()
580:             loc_oPg.txt_4c_CPros.Value       = ""
581:             loc_oPg.txt_4c_DPros.Value       = ""
582:             loc_oPg.opt_4c_OptTipImps.Value  = 1
583:             THIS.AtualizarEstadoCamposDescricao()
584:         CATCH TO loc_oErro
585:             MsgErro(loc_oErro.Message, "Erro")
586:         ENDTRY
587:     ENDPROC
588: 
589:     *--------------------------------------------------------------------------
590:     * OcultarCamposEmpresa - Oculta e desabilita campos de empresa
591:     *   Chamado quando CalcCustos=1: custo calculado por produto apenas,
592:     *   sem necessidade de filtrar por empresa.
593:     *   Equivalente ao bloco do Init original que oculta getCEmps/getDEmps/lblEmpresa.
594:     *--------------------------------------------------------------------------
595:     PROCEDURE OcultarCamposEmpresa()
596:         LOCAL loc_oPg
597:         TRY
598:             loc_oPg = THIS.pgf_4c_Paginas.Page1
599:             loc_oPg.lbl_4c_LblEmpresa.Visible = .F.
600:             loc_oPg.txt_4c_CEmps.Visible      = .F.
601:             loc_oPg.txt_4c_DEmps.Visible      = .F.
602:             loc_oPg.txt_4c_CEmps.Enabled      = .F.
603:             loc_oPg.txt_4c_DEmps.Enabled      = .F.
604:         CATCH TO loc_oErro

*-- Linhas 635 a 655:
635:             .this_dDtFinal   = loc_oPg.txt_4c_DtFinal.Value
636:             .this_cCPros     = ALLTRIM(loc_oPg.txt_4c_CPros.Value)
637:             .this_cDPros     = ALLTRIM(loc_oPg.txt_4c_DPros.Value)
638:             .this_cCEmps     = ALLTRIM(loc_oPg.txt_4c_CEmps.Value)
639:             .this_cDEmps     = ALLTRIM(loc_oPg.txt_4c_DEmps.Value)
640:             .this_nTipoImps  = loc_oPg.opt_4c_OptTipImps.Value
641:         ENDWITH
642:     ENDPROC
643: 
644:     *--------------------------------------------------------------------------
645:     * ValidarFiltros - Valida datas antes de imprimir/visualizar
646:     *   Equivalente a validacao no btnReport.Click do form legado SIGREHCP
647:     *--------------------------------------------------------------------------
648:     PROTECTED PROCEDURE ValidarFiltros()
649:         LOCAL loc_oPg, loc_dIni, loc_dFim
650:         loc_oPg  = THIS.pgf_4c_Paginas.Page1
651:         loc_dIni = loc_oPg.txt_4c_DtInicial.Value
652:         loc_dFim = loc_oPg.txt_4c_DtFinal.Value
653: 
654:         IF EMPTY(loc_dIni)
655:             MsgAviso("Data Inicial Inv" + CHR(225) + "lida!!!", ;

*-- Linhas 1101 a 1146:
1101:             ENDIF
1102:             loc_oPg = THIS.pgf_4c_Paginas.Page1
1103:             WITH THIS.this_oRelatorio
1104:                 loc_oPg.txt_4c_DtInicial.Value  = .this_dDtInicial
1105:                 loc_oPg.txt_4c_DtFinal.Value    = .this_dDtFinal
1106:                 loc_oPg.txt_4c_CPros.Value      = .this_cCPros
1107:                 loc_oPg.txt_4c_DPros.Value      = .this_cDPros
1108:                 loc_oPg.txt_4c_CEmps.Value      = .this_cCEmps
1109:                 loc_oPg.txt_4c_DEmps.Value      = .this_cDEmps
1110:                 loc_oPg.opt_4c_OptTipImps.Value = .this_nTipoImps
1111:             ENDWITH
1112:             THIS.AtualizarEstadoCamposDescricao()
1113:         CATCH TO loc_oErro
1114:             MsgErro(loc_oErro.Message, "Erro")
1115:         ENDTRY
1116:     ENDPROC
1117: 
1118:     PROCEDURE HabilitarCampos(par_lHabilitar)
1119:         LOCAL loc_oPg, loc_lHab
1120:         TRY
1121:             IF PCOUNT() = 0
1122:                 loc_lHab = .T.
1123:             ELSE
1124:                 loc_lHab = par_lHabilitar
1125:             ENDIF
1126:             loc_oPg = THIS.pgf_4c_Paginas.Page1
1127:             loc_oPg.txt_4c_CEmps.Enabled         = loc_lHab
1128:             loc_oPg.txt_4c_DtInicial.Enabled     = loc_lHab
1129:             loc_oPg.txt_4c_DtFinal.Enabled       = loc_lHab
1130:             loc_oPg.txt_4c_CPros.Enabled         = loc_lHab
1131:             loc_oPg.opt_4c_OptTipImps.Enabled    = loc_lHab
1132:             IF loc_lHab
1133:                 THIS.AtualizarEstadoCamposDescricao()
1134:             ELSE
1135:                 loc_oPg.txt_4c_DEmps.Enabled = .F.
1136:                 loc_oPg.txt_4c_DPros.Enabled = .F.
1137:             ENDIF
1138:         CATCH TO loc_oErro
1139:             MsgErro(loc_oErro.Message, "Erro")
1140:         ENDTRY
1141:     ENDPROC
1142: 
1143:     PROCEDURE AjustarBotoesPorModo()
1144:         TRY
1145:             IF VARTYPE(THIS.cmg_4c_Botoes) = "O"
1146:                 THIS.cmg_4c_Botoes.Buttons(1).Enabled = .T.


### BO (C:\4c\projeto\app\classes\SIGREHCPBO.prg):
*==============================================================================
* SIGREHCPBO.PRG
* BO para Relatorio de Historico de Custo de Produtos
* Relatorios: SigRehc1.frx / SigRehc2.frx / SigRehc3.frx
*
* Filtros:
*   - Empresa (CEmps/DEmps) - apenas quando CalcCustos <> 1
*   - Produto (CPros/DPros)
*   - Periodo (DtInicial / DtFinal)
*   - TipoImps: 1=Relacao Padrao, 2=Modelo 3
*
* CalcCustos lido de SigCdPaC.calccustos:
*   1 = por Produto apenas (SigRehc2)
*   outros = por Empresa+Produto (SigRehc1)
*==============================================================================

DEFINE CLASS SIGREHCPBO AS RelatorioBase

    this_dDtInicial     = {}
    this_dDtFinal       = {}
    this_cCPros         = ""
    this_cDPros         = ""
    this_cCEmps         = ""
    this_cDEmps         = ""
    this_nTipoImps      = 1
    this_nCalcCustos    = 0

    *--------------------------------------------------------------------------
    PROCEDURE Init()
        LOCAL loc_lResultado
        loc_lResultado = .F.
        TRY
            loc_lResultado = DODEFAULT()
            IF loc_lResultado
                THIS.ObterParametros()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
            loc_lResultado = .F.
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterParametros - Le CalcCustos da tabela SigCdPaC
    *--------------------------------------------------------------------------
    PROCEDURE ObterParametros()
        LOCAL loc_cSQL, loc_nResult
        TRY
            loc_cSQL = "SELECT TOP 1 calccustos FROM SigCdPaC"
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Param")
            IF loc_nResult > 0
                SELECT cursor_4c_Param
                IF !EOF()
                    THIS.this_nCalcCustos = NVL(calccustos, 0)
                ENDIF
                USE IN cursor_4c_Param
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarFiltros - Valida campos de filtro antes de imprimir
    * Retorna "" se OK, ou nome do campo com erro
    *--------------------------------------------------------------------------
    PROCEDURE ValidarFiltros()
        LOCAL loc_cErro
        loc_cErro = ""

        IF EMPTY(THIS.this_dDtInicial)
            loc_cErro = "DataInicial"
        ELSE
            IF EMPTY(THIS.this_dDtFinal)
            loc_cErro = "DataFinal"
        ELSE
            IF THIS.this_dDtFinal < THIS.this_dDtInicial
            loc_cErro = "Periodo"
            ENDIF
            ENDIF
        ENDIF

        RETURN loc_cErro
    ENDPROC

    *--------------------------------------------------------------------------
    * PrepararDados - Monta cursor de dados para os FRX SigRehc1/2/3
    *
    * Cursor gerado: cursor_4c_Rehcp
    * Colunas: cpros, dpros, custofs, fcustos, pcuss, pvens, datas
    *--------------------------------------------------------------------------
    PROCEDURE PrepararDados()
        LOCAL loc_lResultado, loc_cSQL, loc_cWhere, loc_nResult
        loc_lResultado = .F.
        TRY
            loc_cWhere = "1=1"

            IF !EMPTY(THIS.this_cCPros)
                loc_cWhere = loc_cWhere + ;
                    " AND p.cpros = " + EscaparSQL(ALLTRIM(THIS.this_cCPros))
            ENDIF

            IF !EMPTY(THIS.this_dDtInicial)
                loc_cWhere = loc_cWhere + ;
                    " AND p.datas >= " + FormatarDataSQL(THIS.this_dDtInicial)
            ENDIF

            IF !EMPTY(THIS.this_dDtFinal)
                loc_cWhere = loc_cWhere + ;
                    " AND p.datas <= " + FormatarDataSQL(THIS.this_dDtFinal)
            ENDIF

            loc_cSQL = "SELECT p.cpros, p.dpros, p.custofs, p.fcustos, " + ;
                       "p.pcuss, p.pvens, p.datas " + ;
                       "FROM SigCdPro p " + ;
                       "WHERE " + loc_cWhere + ;
                       " ORDER BY p.cpros"

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Rehcp")

            IF loc_nResult > 0
                loc_lResultado = .T.
            ELSE
                THIS.this_cMensagemErro = "Erro ao buscar dados do relat" + ;
                    CHR(243) + "rio"
            ENDIF

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterCaminhoRelatorio - Determina qual FRX usar conforme filtros
    *
    * TipoImps=1 (Relacao Padrao):
    *   CalcCustos=1 -> SigRehc2 (por Produto)
    *   outro        -> SigRehc1 (por Empresa+Produto)
    * TipoImps=2 -> SigRehc3 (Modelo 3 Livro Fiscal)
    *--------------------------------------------------------------------------
    PROCEDURE ObterCaminhoRelatorio()
        LOCAL loc_cArquivo
        IF THIS.this_nTipoImps = 1
            IF THIS.this_nCalcCustos = 1
                loc_cArquivo = "SigRehc2"
            ELSE
                loc_cArquivo = "SigRehc1"
            ENDIF
        ELSE
            loc_cArquivo = "SigRehc3"
        ENDIF
        RETURN gc_4c_CaminhoReports + loc_cArquivo + ".frx"
    ENDPROC

    *--------------------------------------------------------------------------
    * Imprimir - Prepara dados e envia para impressora
    *--------------------------------------------------------------------------
    PROCEDURE Imprimir()
        LOCAL loc_lResultado, loc_cArquivo
        loc_lResultado = .F.
        TRY
            IF !THIS.PrepararDados()
                loc_lResultado = .F.
            ENDIF
            loc_cArquivo = THIS.ObterCaminhoRelatorio()
            SET POINT TO [,]
            SET SEPARATOR TO [.]
            REPORT FORM (loc_cArquivo) TO PRINT PROMPT NOCONSOLE
            SET POINT TO [.]
            SET SEPARATOR TO [,]
            loc_lResultado = .T.
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * Visualizar - Prepara dados e exibe preview na tela
    *--------------------------------------------------------------------------
    PROCEDURE Visualizar()
        LOCAL loc_lResultado, loc_cArquivo
        loc_lResultado = .F.
        TRY
            IF !THIS.PrepararDados()
                loc_lResultado = .F.
            ENDIF
            loc_cArquivo = THIS.ObterCaminhoRelatorio()
            SET POINT TO [,]
            SET SEPARATOR TO [.]
            REPORT FORM (loc_cArquivo) PREVIEW NOCONSOLE
            SET POINT TO [.]
            SET SEPARATOR TO [,]
            loc_lResultado = .T.
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterMensagemErro - Retorna ultima mensagem de erro
    *--------------------------------------------------------------------------
    PROCEDURE ObterMensagemErro()
        RETURN THIS.this_cMensagemErro
    ENDPROC

ENDDEFINE


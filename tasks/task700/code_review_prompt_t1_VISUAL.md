# CODE REVIEW - PASS VISUAL: Visual Properties (alinhamento, titulos, tipos)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Visual Properties (alinhamento, titulos, tipos)**.

## PROBLEMAS DETECTADOS (4)
- [LAYOUT-POSITION] Controle 'GetTipo' (parent: SIGOPCHR): Top original=204 vs migrado 'obj_4c_GetTipo' Top=5 (diff=199px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'GetTipo' (parent: SIGOPCHR): Left original=238 vs migrado 'obj_4c_GetTipo' Left=5 (diff=233px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'lbl_estoque' (parent: SIGOPCHR): Top original=183 vs migrado 'lbl_4c_Lbl_estoque' Top=98 (diff=85px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'ImpNConta' (parent: SIGOPCHR): Top original=209 vs migrado 'chk_4c_ImpNConta' Top=124 (diff=85px, tolerancia=30px)

## INSTRUCOES DE CORRECAO
### Foco deste pass: CORRECOES VISUAIS
- [ALINHAMENTO] Botoes cmd_4c_* com Top diferente no mesmo grupo horizontal
  - Identificar Top mais frequente no grupo, alinhar os desalinhados
- [ALINHAMENTO-CONTAINER] Botoes no mesmo container cnt_4c_* com Top diferente
- [TITULO-NAO-PROPAGADO] Caption do form nao propagado para lbl_4c_Sombra/lbl_4c_Titulo
- [CHECKBOX-TIPO] CheckBox.Value tipo inconsistente (.F. vs 0/1)
- [FONTNAME-ERRADO] FontName 'Comic Sans MS' numa tela cujo dump legado NAO declara essa fonte - trocar por 'Tahoma' SO nas linhas apontadas, nunca "todas as ocorrencias" (Erro178: o legado do SIGCDPRO declara Comic Sans MS nos 8 botoes de navegacao, e a troca em massa virou regressao de PILAR 1)

## REGRAS OBRIGATORIAS
- Corrigir APENAS os problemas listados, NAO alterar logica de negocio
- NAO remover campos, funcionalidades ou lookups
- **PROIBIDO alterar propriedades visuais** (Width, Height, Top, Left, BackColor, ForeColor, FontName, FontSize) EXCETO se o problema eh especificamente de ALINHAMENTO
- NUNCA juntar linhas com `;` numa linha unica
- Usar Write tool para salvar os arquivos corrigidos nos mesmos caminhos


## CODIGO ATUAL DOS ARQUIVOS

### FORM (C:\4c\projeto\app\forms\relatorios\FormSIGOPCHR.prg) - TRECHOS RELEVANTES PARA PASS VISUAL (1341 linhas total):

*-- Linhas 54 a 62:
54:         loc_lContinuar = .T.
55: 
56:         TRY
57:             THIS.Caption = "Rela" + CHR(231) + CHR(227) + "o de Cheques"
58: 
59:             IF TYPE("gc_4c_CaminhoIcones") = "U"
60:                 gc_4c_CaminhoIcones = ""
61:             ENDIF
62:             IF TYPE("gc_4c_CaminhoReports") = "U"

*-- Linhas 78 a 87:
78:                 THIS.ConfigurarPageFrame()
79:                 THIS.ConfigurarPaginaLista()
80: 
81:                 THIS.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
82:                 THIS.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
83: 
84:                 *-- Repoe os defaults do Init legado e aplica os dois When do
85:                 *-- SCX (getDGrupo/getDConta so editaveis com o codigo vazio).
86:                 THIS.LimparCampos()
87:                 THIS.AjustarBotoesPorModo()

*-- Linhas 106 a 144:
106:     PROTECTED PROCEDURE ConfigurarCabecalho()
107:         THIS.AddObject("cnt_4c_Cabecalho", "Container")
108:         WITH THIS.cnt_4c_Cabecalho
109:             .Top         = 0
110:             .Left        = 0
111:             .Width       = THIS.Width
112:             .Height      = 80
113:             .BackStyle   = 1
114:             .BackColor   = RGB(100, 100, 100)
115:             .BorderWidth = 0
116:             .Visible     = .T.
117: 
118:             .AddObject("lbl_4c_Sombra", "Label")
119:             WITH .lbl_4c_Sombra
120:                 .Top       = 22
121:                 .Left      = 22
122:                 .Width     = THIS.Width
123:                 .Height    = 30
124:                 .Caption   = "Rela" + CHR(231) + CHR(227) + "o de Cheques"
125:                 .FontName  = "Tahoma"
126:                 .FontSize  = 14
127:                 .FontBold  = .T.
128:                 .ForeColor = RGB(0, 0, 0)
129:                 .BackStyle = 0
130:                 .Visible   = .T.
131:             ENDWITH
132: 
133:             .AddObject("lbl_4c_Titulo", "Label")
134:             WITH .lbl_4c_Titulo
135:                 .Top       = 20
136:                 .Left      = 20
137:                 .Width     = THIS.Width
138:                 .Height    = 30
139:                 .Caption   = "Rela" + CHR(231) + CHR(227) + "o de Cheques"
140:                 .FontName  = "Tahoma"
141:                 .FontSize  = 14
142:                 .FontBold  = .T.
143:                 .ForeColor = RGB(255, 255, 255)
144:                 .BackStyle = 0

*-- Linhas 155 a 180:
155:     PROTECTED PROCEDURE ConfigurarBotoes()
156:         THIS.AddObject("cmg_4c_Botoes", "CommandGroup")
157:         WITH THIS.cmg_4c_Botoes
158:             .Top           = -2
159:             .Left          = 495
160:             .Width         = 310
161:             .Height        = 85
162:             .ButtonCount   = 4
163:             .BackStyle     = 0
164:             .BorderStyle   = 0
165:             .BorderColor   = RGB(136, 189, 188)
166:             .SpecialEffect = 1
167:             .Themes        = .F.
168:             .Visible       = .T.
169: 
170:             WITH .Buttons(1)
171:                 .Top             = 5
172:                 .Left            = 5
173:                 .Width           = 75
174:                 .Height          = 75
175:                 .Caption         = "Visualizar"
176:                 .FontName        = "Comic Sans MS"
177:                 .FontSize        = 8
178:                 .FontBold        = .T.
179:                 .FontItalic      = .T.
180:                 .BackColor       = RGB(255, 255, 255)

*-- Linhas 189 a 201:
189:             ENDWITH
190: 
191:             WITH .Buttons(2)
192:                 .Top             = 5
193:                 .Left            = 80
194:                 .Width           = 75
195:                 .Height          = 75
196:                 .Caption         = "Imprimir"
197:                 .FontName        = "Comic Sans MS"
198:                 .FontBold        = .T.
199:                 .FontItalic      = .T.
200:                 .FontSize        = 8
201:                 .BackColor       = RGB(255, 255, 255)

*-- Linhas 210 a 222:
210:             ENDWITH
211: 
212:             WITH .Buttons(3)
213:                 .Top             = 5
214:                 .Left            = 155
215:                 .Width           = 75
216:                 .Height          = 75
217:                 .Caption         = "Arquivos Email"
218:                 .WordWrap        = .T.
219:                 .FontName        = "Comic Sans MS"
220:                 .FontBold        = .T.
221:                 .FontItalic      = .T.
222:                 .FontSize        = 8

*-- Linhas 232 a 244:
232:             ENDWITH
233: 
234:             WITH .Buttons(4)
235:                 .Top             = 5
236:                 .Left            = 230
237:                 .Width           = 75
238:                 .Height          = 75
239:                 .Caption         = "Encerrar"
240:                 .Cancel          = .T.
241:                 .WordWrap        = .T.
242:                 .FontName        = "Comic Sans MS"
243:                 .FontBold        = .T.
244:                 .FontItalic      = .T.

*-- Linhas 275 a 289:
275:         *-- PageCount OBRIGATORIAMENTE antes de acessar Page1
276:         loc_oPgf.PageCount = 1
277: 
278:         loc_oPgf.Top    = 85
279:         loc_oPgf.Left   = -1
280:         loc_oPgf.Width  = THIS.Width + 2
281:         loc_oPgf.Height = THIS.Height - 85
282:         loc_oPgf.Tabs   = .F.
283: 
284:         loc_oPgf.Page1.Caption   = "Filtros"
285:         loc_oPgf.Page1.FontName  = "Tahoma"
286:         loc_oPgf.Page1.FontSize  = 8
287:         loc_oPgf.Page1.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
288:         loc_oPgf.Page1.BackColor = RGB(255, 255, 255)
289:         loc_oPgf.Page1.ForeColor = RGB(90, 90, 90)

*-- Linhas 296 a 304:
296:     * ConfigurarPaginaLista - Adiciona os campos de filtro na Page1 (Filtros)
297:     *
298:     * Forms REPORT (frmrelatorio) tem layout FLAT com 1 unica Page. Posicoes
299:     * ajustadas relativas ao PageFrame.Top=85 (Top_original - 85):
300:     *   Operacao  : Top=109->24 (label) / Top=106->21 (campo)
301:     *   Periodo   : Top=133->48 (label) / Top=131->46 (campos) / Top=135->50 (separador)
302:     *   Grupo     : Top=158->73 (label) / Top=156->71 (campos)
303:     *   Conta     : Top=183->98 (label) / Top=181->96 (campos)
304:     *   Tipo      : Top=208->123 (label) / Top=204->119 (OptionGroup)

*-- Linhas 330 a 358:
330:         loc_oPg = THIS.pgf_4c_Paginas.Page1
331: 
332:         *-- Label "Operacao :"
333:         loc_oPg.AddObject("lbl_4c_Label1", "Label")
334:         WITH loc_oPg.lbl_4c_Label1
335:             .Top       = 24
336:             .Left      = 185
337:             .Width     = 56
338:             .Height    = 15
339:             .Caption   = "Opera" + CHR(231) + CHR(227) + "o :"
340:             .FontName  = "Tahoma"
341:             .FontSize  = 8
342:             .ForeColor = RGB(90, 90, 90)
343:             .BackStyle = 0
344:             .Alignment = 0
345:             .AutoSize  = .F.
346:             .Visible   = .T.
347:         ENDWITH
348: 
349:         *-- Operacao (SigCdOpt.Operacaos, MaxLength=15)
350:         loc_oPg.AddObject("txt_4c_Oper", "TextBox")
351:         WITH loc_oPg.txt_4c_Oper
352:             .Top         = 21
353:             .Left        = 243
354:             .Width       = 115
355:             .Height      = 23
356:             .MaxLength   = 15
357:             .Value       = ""
358:             .FontName    = "Tahoma"

*-- Linhas 364 a 458:
364:         ENDWITH
365: 
366:         *-- Label "Periodo :"
367:         loc_oPg.AddObject("lbl_4c_Label3", "Label")
368:         WITH loc_oPg.lbl_4c_Label3
369:             .Top       = 48
370:             .Left      = 196
371:             .Width     = 45
372:             .Height    = 15
373:             .Caption   = "Per" + CHR(237) + "odo :"
374:             .FontName  = "Tahoma"
375:             .FontSize  = 8
376:             .ForeColor = RGB(90, 90, 90)
377:             .BackStyle = 0
378:             .Alignment = 0
379:             .AutoSize  = .F.
380:             .Visible   = .T.
381:         ENDWITH
382: 
383:         *-- Data Inicial
384:         loc_oPg.AddObject("txt_4c_DataI", "TextBox")
385:         WITH loc_oPg.txt_4c_DataI
386:             .Top         = 46
387:             .Left        = 243
388:             .Width       = 80
389:             .Height      = 23
390:             .Value       = DATE() - 30
391:             .FontName    = "Tahoma"
392:             .FontSize    = 8
393:             .BackColor   = RGB(255, 255, 255)
394:             .ForeColor   = RGB(90, 90, 90)
395:             .BorderStyle = 1
396:             .Visible     = .T.
397:         ENDWITH
398: 
399:         *-- Label separador entre as datas
400:         loc_oPg.AddObject("lbl_4c_Label2", "Label")
401:         WITH loc_oPg.lbl_4c_Label2
402:             .Top       = 50
403:             .Left      = 327
404:             .Width     = 8
405:             .Height    = 15
406:             .Caption   = "a"
407:             .FontName  = "Tahoma"
408:             .FontSize  = 8
409:             .ForeColor = RGB(90, 90, 90)
410:             .BackStyle = 0
411:             .Alignment = 0
412:             .AutoSize  = .F.
413:             .Visible   = .T.
414:         ENDWITH
415: 
416:         *-- Data Final
417:         loc_oPg.AddObject("txt_4c_DataF", "TextBox")
418:         WITH loc_oPg.txt_4c_DataF
419:             .Top         = 46
420:             .Left        = 338
421:             .Width       = 80
422:             .Height      = 23
423:             .Value       = DATE()
424:             .FontName    = "Tahoma"
425:             .FontSize    = 8
426:             .BackColor   = RGB(255, 255, 255)
427:             .ForeColor   = RGB(90, 90, 90)
428:             .BorderStyle = 1
429:             .Visible     = .T.
430:         ENDWITH
431: 
432:         *-- Label "Grupo :"
433:         loc_oPg.AddObject("lbl_4c_Label5", "Label")
434:         WITH loc_oPg.lbl_4c_Label5
435:             .Top       = 73
436:             .Left      = 203
437:             .Width     = 38
438:             .Height    = 15
439:             .Caption   = "Grupo :"
440:             .FontName  = "Tahoma"
441:             .FontSize  = 8
442:             .ForeColor = RGB(90, 90, 90)
443:             .BackStyle = 0
444:             .Alignment = 0
445:             .AutoSize  = .F.
446:             .Visible   = .T.
447:         ENDWITH
448: 
449:         *-- Codigo do Grupo (SigCdGcr.Codigos, MaxLength=10)
450:         loc_oPg.AddObject("txt_4c_Grupo", "TextBox")
451:         WITH loc_oPg.txt_4c_Grupo
452:             .Top         = 71
453:             .Left        = 243
454:             .Width       = 80
455:             .Height      = 23
456:             .MaxLength   = 10
457:             .Value       = ""
458:             .FontName    = "Tahoma"

*-- Linhas 466 a 475:
466:         *-- Descricao do Grupo (SigCdGcr.Descrs, MaxLength=40)
467:         loc_oPg.AddObject("txt_4c_DGrupo", "TextBox")
468:         WITH loc_oPg.txt_4c_DGrupo
469:             .Top         = 71
470:             .Left        = 325
471:             .Width       = 150
472:             .Height      = 23
473:             .MaxLength   = 40
474:             .Value       = ""
475:             .FontName    = "Tahoma"

*-- Linhas 481 a 509:
481:         ENDWITH
482: 
483:         *-- Label "Conta :"
484:         loc_oPg.AddObject("lbl_4c_Lbl_estoque", "Label")
485:         WITH loc_oPg.lbl_4c_Lbl_estoque
486:             .Top       = 98
487:             .Left      = 203
488:             .Width     = 38
489:             .Height    = 15
490:             .Caption   = "Conta :"
491:             .FontName  = "Tahoma"
492:             .FontSize  = 8
493:             .ForeColor = RGB(90, 90, 90)
494:             .BackStyle = 0
495:             .Alignment = 0
496:             .AutoSize  = .F.
497:             .Visible   = .T.
498:         ENDWITH
499: 
500:         *-- Codigo da Conta (SigCdCli.IClis, MaxLength=10)
501:         loc_oPg.AddObject("txt_4c_Conta", "TextBox")
502:         WITH loc_oPg.txt_4c_Conta
503:             .Top         = 96
504:             .Left        = 243
505:             .Width       = 80
506:             .Height      = 23
507:             .MaxLength   = 10
508:             .Value       = ""
509:             .FontName    = "Tahoma"

*-- Linhas 517 a 526:
517:         *-- Descricao da Conta (SigCdCli.RClis, MaxLength=50)
518:         loc_oPg.AddObject("txt_4c_DConta", "TextBox")
519:         WITH loc_oPg.txt_4c_DConta
520:             .Top         = 96
521:             .Left        = 325
522:             .Width       = 290
523:             .Height      = 23
524:             .MaxLength   = 50
525:             .Value       = ""
526:             .FontName    = "Tahoma"

*-- Linhas 532 a 546:
532:         ENDWITH
533: 
534:         *-- Label "Tipo :"
535:         loc_oPg.AddObject("lbl_4c_Label4", "Label")
536:         WITH loc_oPg.lbl_4c_Label4
537:             .Top       = 123
538:             .Left      = 212
539:             .Width     = 29
540:             .Height    = 15
541:             .Caption   = "Tipo :"
542:             .FontName  = "Tahoma"
543:             .FontSize  = 8
544:             .ForeColor = RGB(90, 90, 90)
545:             .BackStyle = 0
546:             .Alignment = 0

*-- Linhas 552 a 604:
552:         loc_oPg.AddObject("obj_4c_GetTipo", "OptionGroup")
553:         loc_oPg.obj_4c_GetTipo.ButtonCount = 2
554:         WITH loc_oPg.obj_4c_GetTipo
555:             .Top         = 119
556:             .Left        = 238
557:             .Width       = 144
558:             .Height      = 27
559:             .BackStyle   = 0
560:             .BorderStyle = 0
561:             .Value       = 1
562:             .Themes      = .F.
563:             .Visible     = .T.
564: 
565:             WITH .Buttons(1)
566:                 .Caption   = "Geral"
567:                 .Top       = 5
568:                 .Left      = 5
569:                 .Width     = 61
570:                 .Height    = 17
571:                 .FontName  = "Comic Sans MS"
572:                 .FontSize  = 8
573:                 .BackStyle = 0
574:                 .ForeColor = RGB(90, 90, 90)
575:                 .Themes    = .F.
576:             ENDWITH
577: 
578:             WITH .Buttons(2)
579:                 .Caption   = "Pendente"
580:                 .Top       = 5
581:                 .Left      = 62
582:                 .Width     = 77
583:                 .Height    = 17
584:                 .FontName  = "Comic Sans MS"
585:                 .FontSize  = 8
586:                 .BackStyle = 0
587:                 .ForeColor = RGB(90, 90, 90)
588:                 .Themes    = .F.
589:             ENDWITH
590:         ENDWITH
591: 
592:         *-- Imprime Nome da Conta
593:         loc_oPg.AddObject("chk_4c_ImpNConta", "CheckBox")
594:         WITH loc_oPg.chk_4c_ImpNConta
595:             .Top       = 124
596:             .Left      = 399
597:             .Width     = 133
598:             .Height    = 15
599:             .Caption   = "Imprime Nome da Conta"
600:             .FontName  = "Tahoma"
601:             .FontSize  = 8
602:             .ForeColor = RGB(90, 90, 90)
603:             .BackStyle = 0
604:             .Value     = 0

*-- Linhas 921 a 929:
921:     *     txt_4c_Conta     -> this_cConta
922:     *     txt_4c_DConta    -> this_cDescConta
923:     *     chk_4c_ImpNConta -> this_lImpNConta (regra #187: comparar = 1,
924:     *                         NUNCA atribuir o numerico do CheckBox direto
925:     *                         a property logica)
926:     *--------------------------------------------------------------------------
927:     PROCEDURE FormParaRelatorio()
928:         LOCAL loc_oPg
929:         loc_oPg = THIS.pgf_4c_Paginas.Page1

*-- Linhas 1160 a 1168:
1160:                 IF PEMSTATUS(loc_oPg, "txt_4c_DConta", 5)
1161:                     loc_oPg.txt_4c_DConta.ReadOnly = !loc_lHab
1162:                 ENDIF
1163:                 *-- OptionGroup e CheckBox nao tem ReadOnly: usar Enabled
1164:                 IF PEMSTATUS(loc_oPg, "obj_4c_GetTipo", 5)
1165:                     loc_oPg.obj_4c_GetTipo.Enabled = loc_lHab
1166:                 ENDIF
1167:                 IF PEMSTATUS(loc_oPg, "chk_4c_ImpNConta", 5)
1168:                     loc_oPg.chk_4c_ImpNConta.Enabled = loc_lHab

*-- Linhas 1239 a 1247:
1239:                     loc_nTipo = IIF(BETWEEN(loc_nTipo, 1, 2), loc_nTipo, 1)
1240:                     loc_oPg.obj_4c_GetTipo.Value = loc_nTipo
1241: 
1242:                     *-- CheckBox.Value eh NUMERICO; a property do BO eh LOGICA.
1243:                     *-- Conversao explicita, tolerando a property chegar
1244:                     *-- numerica (coluna bit do SQL Server muda de tipo
1245:                     *-- conforme o driver).
1246:                     DO CASE
1247:                         CASE VARTYPE(.this_lImpNConta) = "L"


### BO (C:\4c\projeto\app\classes\SIGOPCHRBO.prg):
*==============================================================================
* SIGOPCHRBO.PRG
* Business Object para Relatorio de Relacao de Cheques
*
* Herda de: RelatorioBase
* Form: FormSIGOPCHR.prg
* Relatorio original: SIGOPCHR.SCX / SigOpChr.FRX
*==============================================================================

DEFINE CLASS SIGOPCHRBO AS RelatorioBase

    *-- Identificacao do relatorio
    this_cArquivoRelatorio  = "SigOpChr"
    this_cTituloRelatorio   = ""
    this_cSubtituloRelatorio = ""

    *-- Filtros de parametro do formulario (legado: Get_Oper/GetDataI/GetDataF/GetTipo/getGrupo/getConta/ImpNConta)
    this_cOperacao          = ""
    this_dDataInicial       = {}
    this_dDataFinal         = {}
    this_nTipo              = 1
    this_cGrupo             = ""
    this_cDescGrupo         = ""
    this_cConta             = ""
    this_cDescConta         = ""
    this_lImpNConta         = .F.

    *-- Cursores principais consumidos pelo FRX (nomes preservados do legado)
    this_cCursorDados       = "CsImpressao"
    this_cCursorCabecalho   = "csCabecalho"

    *--------------------------------------------------------------------------
    * Init - Construtor do BO de Relatorio de Cheques
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        THIS.this_cTabela     = ""
        THIS.this_cCampoChave = ""

        THIS.this_cTituloRelatorio = "Rela" + CHR(231) + CHR(227) + "o de Cheques"

        THIS.this_dDataInicial = DATE() - 30
        THIS.this_dDataFinal   = DATE()
        THIS.this_nTipo        = 1

        RETURN DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarParametros - Valida filtros antes de PrepararDados
    * Equivale ao bloco de validacao de btnReport.Click do legado
    * (Data Inicial/Final invalidas, Final < Inicial).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ValidarParametros()
        THIS.this_cMensagemErro = ""

        IF EMPTY(THIS.this_dDataInicial)
            THIS.this_cMensagemErro = "Data Inicial Inv" + CHR(225) + "lida!!!"
            RETURN .F.
        ENDIF

        IF EMPTY(THIS.this_dDataFinal)
            THIS.this_cMensagemErro = "Data Final Inv" + CHR(225) + "lida!!!"
            RETURN .F.
        ENDIF

        IF THIS.this_dDataFinal < THIS.this_dDataInicial
            THIS.this_cMensagemErro = "A Data Final N" + CHR(227) + ;
                "o Pode Ser Menor do que a Inicial!!!"
            RETURN .F.
        ENDIF

        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * CriarCabecalho - Popula cursor csCabecalho referenciado pelo FRX legado
    * SigOpChr.frx tem Dataenvironment com alias csCabecalho (Empresa, Titulo,
    * Subtitulo, Quebra, Nconta). Estrutura preservada do legado
    * (SIGOPCHR.processamento).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE CriarCabecalho()
        LOCAL loc_cEmp, loc_cRazas, loc_cEmpresa, loc_cTitulo, loc_cSubtitulo
        LOCAL loc_lQuebra, loc_nResult

        loc_cEmp = ALLTRIM(go_4c_Sistema.cCodEmpresa)

        loc_cRazas = ""
        IF USED("cursor_4c_EmpCab")
            USE IN cursor_4c_EmpCab
        ENDIF
        loc_nResult = SQLEXEC(gnConnHandle, ;
            "SELECT Razas FROM SigCdEmp WHERE Cemps = " + EscaparSQL(loc_cEmp), ;
            "cursor_4c_EmpCab")
        IF loc_nResult > 0 AND USED("cursor_4c_EmpCab") AND RECCOUNT("cursor_4c_EmpCab") > 0
            loc_cRazas = ALLTRIM(cursor_4c_EmpCab.Razas)
        ENDIF
        IF USED("cursor_4c_EmpCab")
            USE IN cursor_4c_EmpCab
        ENDIF
        loc_cEmpresa = loc_cEmp + IIF(EMPTY(loc_cRazas), "", " - " + loc_cRazas)

        loc_cTitulo = "Rela" + CHR(231) + CHR(227) + "o " + ;
            IIF(THIS.this_nTipo = 1, "Geral de Cheques - ", "de Cheques Pendentes - ") + ;
            IIF(EMPTY(ALLTRIM(THIS.this_cOperacao)), ;
                "Todas as Opera" + CHR(231) + CHR(245) + "es", ;
                ALLTRIM(THIS.this_cOperacao))

        loc_cSubtitulo = "Per" + CHR(237) + "odo : " + DTOC(THIS.this_dDataInicial) + ;
            " at" + CHR(233) + " " + DTOC(THIS.this_dDataFinal) + "     " + ;
            IIF(EMPTY(ALLTRIM(THIS.this_cGrupo)), ;
                "Todos os Grupos", "Grupo : " + ALLTRIM(THIS.this_cGrupo)) + "  " + ;
            IIF(EMPTY(ALLTRIM(THIS.this_cConta)), ;
                "Todas as Contas", "Conta : " + ALLTRIM(THIS.this_cConta))

        loc_lQuebra = EMPTY(ALLTRIM(THIS.this_cConta))

        IF USED("csCabecalho")
            USE IN csCabecalho
        ENDIF
        CREATE CURSOR csCabecalho (Empresa C(80), Titulo C(80), Subtitulo C(80), ;
            Quebra L(1), Nconta L)
        INSERT INTO csCabecalho (Empresa, Titulo, Subtitulo, Quebra, Nconta) ;
            VALUES (loc_cEmpresa, loc_cTitulo, loc_cSubtitulo, loc_lQuebra, ;
                    THIS.this_lImpNConta)

        SELECT csCabecalho
        GO TOP
    ENDPROC

    *--------------------------------------------------------------------------
    * PrepararDados - Monta WHERE a partir dos filtros e executa a consulta
    * Transcricao de SIGOPCHR.processamento:
    *   From SigChe a, SigCdOpt b, SigCdCli c
    *   Where a.Vencs Between ?ldDatai And ?ldDataF
    *     [And a.Umovs = lcOpera] [And a.GrClis = lcGrupo] [And a.IClis = lcConta]
    *     [And b.Tipos = 'DB' quando this_nTipo = 2 (nao liquidado)]
    *     And a.Umovs = b.Operacaos And a.Iclis = c.Iclis
    *   Order By 1,2,3,4,5,6,7,8,9,10
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE PrepararDados()
        LOCAL loc_lSucesso, loc_oErro, loc_cSQL, loc_cWhere
        LOCAL loc_tDataFinal, loc_nResult

        loc_lSucesso = .F.

        TRY
            IF !THIS.ValidarParametros()
                loc_lSucesso = .F.
            ELSE
                THIS.CriarCabecalho()

                *-- Data final inclui o dia inteiro (fDtoSQL(ldDataF,'23:59:59') no legado)
                loc_tDataFinal = DATETIME(YEAR(THIS.this_dDataFinal), ;
                    MONTH(THIS.this_dDataFinal), DAY(THIS.this_dDataFinal), 23, 59, 59)

                loc_cWhere = " a.Vencs BETWEEN " + FormatarDataSQL(THIS.this_dDataInicial) + ;
                             " AND " + FormatarDataSQL(loc_tDataFinal)

                IF !EMPTY(ALLTRIM(THIS.this_cOperacao))
                    loc_cWhere = loc_cWhere + " AND a.Umovs = " + ;
                        EscaparSQL(ALLTRIM(THIS.this_cOperacao))
                ENDIF
                IF !EMPTY(ALLTRIM(THIS.this_cGrupo))
                    loc_cWhere = loc_cWhere + " AND a.GrClis = " + ;
                        EscaparSQL(ALLTRIM(THIS.this_cGrupo))
                ENDIF
                IF !EMPTY(ALLTRIM(THIS.this_cConta))
                    loc_cWhere = loc_cWhere + " AND a.IClis = " + ;
                        EscaparSQL(ALLTRIM(THIS.this_cConta))
                ENDIF
                IF THIS.this_nTipo = 2
                    loc_cWhere = loc_cWhere + " AND b.Tipos = " + EscaparSQL("DB")
                ENDIF

                loc_cSQL = "SELECT a.Vencs, a.GrClis AS Grupos, a.IClis AS Contas," + ;
                           " a.Umovs, a.Emps, a.Bancos, a.Agencias, a.NContas," + ;
                           " a.NCheques, a.Valors, b.Tipos, c.Rclis" + ;
                           " FROM SigChe a" + ;
                           " INNER JOIN SigCdOpt b ON a.Umovs = b.Operacaos" + ;
                           " INNER JOIN SigCdCli c ON a.IClis = c.IClis" + ;
                           " WHERE" + loc_cWhere + ;
                           " ORDER BY a.Vencs, a.GrClis, a.IClis, a.Umovs, a.Emps," + ;
                           " a.Bancos, a.Agencias, a.NContas, a.NCheques, a.Valors"

                IF USED(THIS.this_cCursorDados)
                    USE IN (THIS.this_cCursorDados)
                ENDIF

                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, THIS.this_cCursorDados)
                IF loc_nResult < 0
                    THIS.this_cMensagemErro = "Erro ao buscar cheques" + CHR(13) + ;
                        CapturarErroSQL()
                    loc_lSucesso = .F.
                ELSE
                    SELECT (THIS.this_cCursorDados)
                    GO TOP
                    loc_lSucesso = .T.
                ENDIF
            ENDIF

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro em PrepararDados")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ExecutarReportForm (Pattern #117) - Executa REPORT FORM apenas se o FRX
    * existir e o cursor nao estiver vazio. Isola SET POINT/SEPARATOR/
    * REPORTBEHAVIOR durante o REPORT FORM porque o FRX legado Fortyus foi
    * desenhado com POINT="." + REPORTBEHAVIOR 80. Restaura o menu principal
    * depois do PREVIEW (Erro63).
    * par_cModo: "PREVIEW" | "PRINTER_PROMPT" | "PRINTER"
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ExecutarReportForm(par_cRelatorioBase, par_cModo, par_cCursorDados)
        LOCAL loc_cFRX
        loc_cFRX = FULLPATH(gc_4c_CaminhoReports + par_cRelatorioBase + ".frx")

        IF NOT FILE(loc_cFRX)
            MostrarErro("Arquivo de relat" + CHR(243) + "rio n" + CHR(227) + ;
                "o encontrado:" + CHR(13) + loc_cFRX + CHR(13) + CHR(13) + ;
                "O FRX legado ainda n" + CHR(227) + ;
                "o foi portado para o novo sistema.", "Erro")
            RETURN .F.
        ENDIF

        *-- Guard cursor vazio: evita preview em branco / impressao vazia (Erro30)
        IF VARTYPE(par_cCursorDados) == "C" AND !EMPTY(par_cCursorDados)
            IF !USED(par_cCursorDados) OR RECCOUNT(par_cCursorDados) = 0
                MsgAviso("Nenhum cheque encontrado com os filtros informados.", ;
                    "Aten" + CHR(231) + CHR(227) + "o")
                RETURN .F.
            ENDIF
        ENDIF

        LOCAL loc_cPointOrig, loc_cSepOrig, loc_nBehaviorOrig
        loc_cPointOrig    = SET("POINT")
        loc_cSepOrig      = SET("SEPARATOR")
        loc_nBehaviorOrig = SET("REPORTBEHAVIOR")
        SET POINT TO "."
        SET SEPARATOR TO ","
        SET REPORTBEHAVIOR 80

        DO CASE
            CASE par_cModo == "PREVIEW"
                REPORT FORM (loc_cFRX) PREVIEW NOCONSOLE
            CASE par_cModo == "PRINTER_PROMPT"
                REPORT FORM (loc_cFRX) TO PRINTER PROMPT NOCONSOLE
            CASE par_cModo == "PRINTER"
                REPORT FORM (loc_cFRX) TO PRINTER NOCONSOLE
        ENDCASE

        SET POINT TO (loc_cPointOrig)
        SET SEPARATOR TO (loc_cSepOrig)
        SET REPORTBEHAVIOR (loc_nBehaviorOrig)

        *-- Restaurar menu (Erro63): REPORT FORM PREVIEW abre toolbar propria
        *-- que corrompe o cache visual do _MSYSMENU.
        TRY
            SET SYSMENU TO DEFAULT
            RELEASE POPUP popArquivo, popCadastros, popMovimentos, popRelatorios, popFerramentas, popAjuda
            CriarMenuPrincipal()
        CATCH
            *-- CriarMenuPrincipal fora do escopo (teste automatizado) - silencioso
        ENDTRY

        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * Visualizar - Prepara dados e exibe o relatorio em preview na tela
    *--------------------------------------------------------------------------
    PROCEDURE Visualizar()
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        TRY
            THIS.this_cMensagemErro = ""
            IF THIS.PrepararDados()
                SELECT (THIS.this_cCursorDados)
                GO TOP
                loc_lSucesso = THIS.ExecutarReportForm("SigOpChr", "PREVIEW", THIS.this_cCursorDados)
                IF loc_lSucesso
                    THIS.RegistrarAuditoria("VISUALIZAR")
                ENDIF
            ELSE
                IF !EMPTY(THIS.this_cMensagemErro)
                    MsgErro(THIS.this_cMensagemErro, "Rela" + CHR(231) + CHR(227) + "o de Cheques")
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro ao visualizar relat" + CHR(243) + "rio")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Imprimir - Prepara dados e envia o relatorio para a impressora
    *--------------------------------------------------------------------------
    PROCEDURE Imprimir()
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        TRY
            THIS.this_cMensagemErro = ""
            IF THIS.PrepararDados()
                SELECT (THIS.this_cCursorDados)
                GO TOP
                loc_lSucesso = THIS.ExecutarReportForm("SigOpChr", "PRINTER_PROMPT", THIS.this_cCursorDados)
                IF loc_lSucesso
                    THIS.RegistrarAuditoria("IMPRESSAO")
                ENDIF
            ELSE
                IF !EMPTY(THIS.this_cMensagemErro)
                    MsgErro(THIS.this_cMensagemErro, "Rela" + CHR(231) + CHR(227) + "o de Cheques")
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro ao imprimir relat" + CHR(243) + "rio")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * GerarExcel - Exporta o relatorio para arquivo ASCII (Pattern #167)
    *--------------------------------------------------------------------------
    PROCEDURE GerarExcel()
        LOCAL loc_lSucesso, loc_cArquivo, loc_oErro
        loc_lSucesso = .F.

        TRY
            THIS.this_cMensagemErro = ""
            IF THIS.PrepararDados()
                IF USED(THIS.this_cCursorDados) AND RECCOUNT(THIS.this_cCursorDados) > 0
                    SELECT (THIS.this_cCursorDados)
                    GO TOP
                    loc_cArquivo = SYS(5) + CURDIR() + "sigopchr_" + ;
                                   STRTRAN(DTOC(DATE()), "/", "") + ".xls"
                    REPORT FORM (gc_4c_CaminhoReports + THIS.this_cArquivoRelatorio) ;
                        TO FILE (loc_cArquivo) NOCONSOLE ASCII
                    IF FILE(loc_cArquivo)
                        MsgInfo("Arquivo gerado:" + CHR(13) + loc_cArquivo, "Excel")
                        THIS.RegistrarAuditoria("EXCEL")
                    ENDIF
                    loc_lSucesso = .T.
                ELSE
                    THIS.this_cMensagemErro = "Nenhum cheque encontrado com os filtros informados."
                    MsgAviso(THIS.this_cMensagemErro, "Aten" + CHR(231) + CHR(227) + "o")
                ENDIF
            ELSE
                IF !EMPTY(THIS.this_cMensagemErro)
                    MsgErro(THIS.this_cMensagemErro, "Rela" + CHR(231) + CHR(227) + "o de Cheques")
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "GerarExcel")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterMensagemErro - Retorna mensagem de erro da ultima operacao
    *--------------------------------------------------------------------------
    PROCEDURE ObterMensagemErro()
        RETURN THIS.this_cMensagemErro
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Chave composta dos filtros, usada em RegistrarAuditoria
    *--------------------------------------------------------------------------
    PROCEDURE ObterChavePrimaria()
        RETURN "OPER=" + ALLTRIM(THIS.this_cOperacao) + ;
               ";TIPO=" + ALLTRIM(STR(THIS.this_nTipo, 1)) + ;
               ";GRUPO=" + ALLTRIM(THIS.this_cGrupo) + ;
               ";CONTA=" + ALLTRIM(THIS.this_cConta) + ;
               ";DT=" + DTOC(THIS.this_dDataInicial) + "-" + DTOC(THIS.this_dDataFinal)
    ENDPROC

    *--------------------------------------------------------------------------
    * RegistrarAuditoria - Registra a geracao do relatorio em LogAuditoria
    *--------------------------------------------------------------------------
    PROCEDURE RegistrarAuditoria(par_cOperacao)
        LOCAL loc_lSucesso, loc_cSQL, loc_cChave, loc_nResult, loc_cUsuario, loc_oErro
        loc_lSucesso = .F.

        TRY
            loc_cUsuario = ""
            IF TYPE("gc_4c_UsuarioLogado") = "C"
                loc_cUsuario = ALLTRIM(NVL(gc_4c_UsuarioLogado, ""))
            ENDIF

            loc_cChave = THIS.ObterChavePrimaria()

            loc_cSQL = "INSERT INTO LogAuditoria " + ;
                       "(Tabela, Operacao, ChaveRegistro, Usuario, DataHora) VALUES (" + ;
                       EscaparSQL("SigChe") + ", " + ;
                       EscaparSQL(par_cOperacao) + ", " + ;
                       EscaparSQL(loc_cChave) + ", " + ;
                       EscaparSQL(loc_cUsuario) + ", " + ;
                       "GETDATE())"

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)
            loc_lSucesso = (loc_nResult >= 0)
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Destroy - Libera cursores abertos por PrepararDados/CriarCabecalho
    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
        LOCAL loc_aCursores(3), loc_nI
        loc_aCursores(1) = THIS.this_cCursorDados
        loc_aCursores(2) = "csCabecalho"
        loc_aCursores(3) = "cursor_4c_EmpCab"

        FOR loc_nI = 1 TO 3
            IF USED(loc_aCursores(loc_nI))
                USE IN (loc_aCursores(loc_nI))
            ENDIF
        ENDFOR

        DODEFAULT()
    ENDPROC

ENDDEFINE


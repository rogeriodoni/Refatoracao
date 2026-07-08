# CODE REVIEW - PASS VISUAL: Visual Properties (alinhamento, titulos, tipos)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Visual Properties (alinhamento, titulos, tipos)**.

## PROBLEMAS DETECTADOS (4)
- [LAYOUT-POSITION] Controle 'lbl_periodo' (parent: SIGREIFP): Top original=104 vs migrado 'lbl_4c_Lbl_periodo' Top=19 (diff=85px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'lbl_periodo_a' (parent: SIGREIFP): Top original=104 vs migrado 'lbl_4c_Lbl_periodo_a' Top=19 (diff=85px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label2' (parent: SIGREIFP): Top original=181 vs migrado 'lbl_4c_Label2' Top=96 (diff=85px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label3' (parent: SIGREIFP): Top original=157 vs migrado 'lbl_4c_Label3' Top=72 (diff=85px, tolerancia=30px)

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

### FORM (C:\4c\projeto\app\forms\relatorios\FormSigReIfp.prg) - TRECHOS RELEVANTES PARA PASS VISUAL (1249 linhas total):

*-- Linhas 15 a 26:
15: *        SigReIfD (niv=5), SigReIfE (niv=6), SigReIfF (niv=7)
16: *
17: * Objetos (mapeamento.json):
18: *   shp_4c_Shp_materia_prima, lbl_4c_Label1, lbl_4c_Lbl_periodo,
19: *   txt_4c_DsGrupo, txt_4c_CdGrupo, txt_4c__dt_inicial, lbl_4c_Lbl_periodo_a,
20: *   txt_4c__dt_final, lbl_4c_Label2, lbl_4c_Label3, txt_4c__ifor,
21: *   txt_4c__tpmat, txt_4c__dfor, obj_4c_NivImprs, lbl_4c_Label4
22: *==============================================================================
23: 
24: DEFINE CLASS FormSigReIfp AS FormBase
25: 
26:     *-- Dimensoes exatas do original (Width=647, Height=254)

*-- Linhas 60 a 68:
60:         loc_lSucesso   = .F.
61:         loc_lContinuar = .T.
62:         TRY
63:             THIS.Caption = "Relat" + CHR(243) + "rio de Falhas / Perdas"
64: 
65:             IF TYPE("gc_4c_CaminhoIcones") = "U"
66:                 gc_4c_CaminhoIcones = ""
67:             ENDIF
68:             THIS.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"

*-- Linhas 84 a 93:
84:                 THIS.ConfigurarPaginaLista()
85:                 THIS.ConfigurarPaginaDados()
86: 
87:                 THIS.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
88:                 THIS.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
89: 
90:                 BINDEVENT(THIS.cmg_4c_Botoes.Buttons(1), "Click", THIS, "BtnVisualizarClick")
91:                 BINDEVENT(THIS.cmg_4c_Botoes.Buttons(2), "Click", THIS, "BtnImprimirClick")
92:                 BINDEVENT(THIS.cmg_4c_Botoes.Buttons(3), "Click", THIS, "BtnExcelClick")
93:                 BINDEVENT(THIS.cmg_4c_Botoes.Buttons(4), "Click", THIS, "BtnSairClick")

*-- Linhas 112 a 186:
112:     PROTECTED PROCEDURE ConfigurarCabecalho()
113:         THIS.AddObject("cnt_4c_Cabecalho", "Container")
114:         WITH THIS.cnt_4c_Cabecalho
115:             .Top         = 0
116:             .Left        = 0
117:             .Width       = THIS.Width
118:             .Height      = 80
119:             .BackStyle   = 1
120:             .BackColor   = RGB(100, 100, 100)
121:             .BorderWidth = 0
122:             .Visible     = .T.
123: 
124:             .AddObject("lbl_4c_Sombra", "Label")
125:             WITH .lbl_4c_Sombra
126:                 .Top       = 22
127:                 .Left      = 22
128:                 .Width     = THIS.Width
129:                 .Height    = 30
130:                 .Caption   = "Relat" + CHR(243) + "rio de Falhas / Perdas"
131:                 .FontName  = "Tahoma"
132:                 .FontSize  = 14
133:                 .FontBold  = .T.
134:                 .ForeColor = RGB(0, 0, 0)
135:                 .BackStyle = 0
136:                 .Visible   = .T.
137:             ENDWITH
138: 
139:             .AddObject("lbl_4c_Titulo", "Label")
140:             WITH .lbl_4c_Titulo
141:                 .Top       = 20
142:                 .Left      = 20
143:                 .Width     = THIS.Width
144:                 .Height    = 30
145:                 .Caption   = "Relat" + CHR(243) + "rio de Falhas / Perdas"
146:                 .FontName  = "Tahoma"
147:                 .FontSize  = 14
148:                 .FontBold  = .T.
149:                 .ForeColor = RGB(255, 255, 255)
150:                 .BackStyle = 0
151:                 .Visible   = .T.
152:             ENDWITH
153:         ENDWITH
154:     ENDPROC
155: 
156:     *--------------------------------------------------------------------------
157:     * ConfigurarBotoes - CommandGroup de 4 botoes do relatorio
158:     *   Original: btnReport.Left=340, Width=310, 4 botoes (V/I/D/S)
159:     *   Novo: cmg_4c_Botoes.Left=340, Width=273, botoes Width=65
160:     *--------------------------------------------------------------------------
161:     PROTECTED PROCEDURE ConfigurarBotoes()
162:         THIS.AddObject("cmg_4c_Botoes", "CommandGroup")
163:         WITH THIS.cmg_4c_Botoes
164:             .Top           = 0
165:             .Left          = 340
166:             .Width         = 273
167:             .Height        = 80
168:             .ButtonCount   = 4
169:             .BackStyle     = 0
170:             .BorderStyle   = 0
171:             .BorderColor   = RGB(136, 189, 188)
172:             .SpecialEffect = 1
173:             .Themes        = .F.
174:             .Visible       = .T.
175: 
176:             WITH .Buttons(1)
177:                 .Top             = 5
178:                 .Left            = 5
179:                 .Width           = 65
180:                 .Height          = 70
181:                 .Caption         = "Visualizar"
182:                 .FontBold        = .T.
183:                 .FontItalic      = .T.
184:                 .BackColor       = RGB(255, 255, 255)
185:                 .ForeColor       = RGB(90, 90, 90)
186:                 .Picture         = gc_4c_CaminhoIcones + "relatorio_video_26.jpg"

*-- Linhas 193 a 205:
193:             ENDWITH
194: 
195:             WITH .Buttons(2)
196:                 .Top             = 5
197:                 .Left            = 71
198:                 .Width           = 65
199:                 .Height          = 70
200:                 .Caption         = "Imprimir"
201:                 .FontName        = "Tahoma"
202:                 .FontBold        = .T.
203:                 .FontItalic      = .T.
204:                 .FontSize        = 8
205:                 .BackColor       = RGB(255, 255, 255)

*-- Linhas 214 a 226:
214:             ENDWITH
215: 
216:             WITH .Buttons(3)
217:                 .Top             = 5
218:                 .Left            = 137
219:                 .Width           = 65
220:                 .Height          = 70
221:                 .Caption         = "Excel"
222:                 .FontName        = "Tahoma"
223:                 .FontBold        = .T.
224:                 .FontItalic      = .T.
225:                 .FontSize        = 8
226:                 .BackColor       = RGB(255, 255, 255)

*-- Linhas 235 a 247:
235:             ENDWITH
236: 
237:             WITH .Buttons(4)
238:                 .Top             = 5
239:                 .Left            = 203
240:                 .Width           = 65
241:                 .Height          = 70
242:                 .Caption         = "Encerrar"
243:                 .Cancel          = .T.
244:                 .FontName        = "Tahoma"
245:                 .FontBold        = .T.
246:                 .FontItalic      = .T.
247:                 .FontSize        = 8

*-- Linhas 270 a 284:
270:         loc_oPgf = THIS.pgf_4c_Paginas
271: 
272:         loc_oPgf.PageCount = 1
273:         loc_oPgf.Top    = 85
274:         loc_oPgf.Left   = -1
275:         loc_oPgf.Width  = THIS.Width + 2
276:         loc_oPgf.Height = THIS.Height - 85
277:         loc_oPgf.Tabs   = .F.
278: 
279:         loc_oPgf.Page1.Caption   = "Filtros"
280:         loc_oPgf.Page1.FontName  = "Tahoma"
281:         loc_oPgf.Page1.FontSize  = 8
282:         loc_oPgf.Page1.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
283:         loc_oPgf.Page1.BackColor = RGB(255, 255, 255)
284:         loc_oPgf.Page1.ForeColor = RGB(90, 90, 90)

*-- Linhas 320 a 369:
320: 
321:     *--------------------------------------------------------------------------
322:     * ConfigurarPaginaFiltros - Adiciona todos os controles de filtro em Page1
323:     *   Posicoes: originais do SCX (relativas ao form) menos PageFrame.Top=85
324:     *   Campos de nivel 7 (TpMat, Ifor/Dfor, CdGrupo/DsGrupo) ficam dentro da
325:     *   borda decorativa shp_4c_Shp_materia_prima (top=11, h=139).
326:     *--------------------------------------------------------------------------
327:     PROTECTED PROCEDURE ConfigurarPaginaFiltros()
328:         LOCAL loc_oPg
329:         loc_oPg = THIS.pgf_4c_Paginas.Page1
330: 
331:         *-- Borda decorativa ao redor dos campos de nivel 7
332:         *   Original: top=96, left=86, w=461, h=139 -> page: top=11
333:         loc_oPg.AddObject("shp_4c_Shp_materia_prima", "Shape")
334:         WITH loc_oPg.shp_4c_Shp_materia_prima
335:             .Top         = 11
336:             .Left        = 86
337:             .Width       = 461
338:             .Height      = 139
339:             .BackStyle   = 0
340:             .BorderStyle = 0
341:             .BorderColor = RGB(136, 189, 188)
342:             .Visible     = .T.
343:         ENDWITH
344: 
345:         *-- Label "Periodo :" (original: top=104, left=147 -> page: top=19)
346:         loc_oPg.AddObject("lbl_4c_Lbl_periodo", "Label")
347:         WITH loc_oPg.lbl_4c_Lbl_periodo
348:             .AutoSize  = .T.
349:             .Top       = 19
350:             .Left      = 147
351:             .Width     = 45
352:             .Caption   = "Per" + CHR(237) + "odo :"
353:             .FontName  = "Tahoma"
354:             .FontSize  = 8
355:             .ForeColor = RGB(90, 90, 90)
356:             .BackStyle = 0
357:             .Visible   = .T.
358:         ENDWITH
359: 
360:         *-- Data inicial (original: top=101, left=199 -> page: top=16)
361:         loc_oPg.AddObject("txt_4c__dt_inicial", "TextBox")
362:         WITH loc_oPg.txt_4c__dt_inicial
363:             .Top         = 16
364:             .Left        = 199
365:             .Width       = 80
366:             .Height      = 25
367:             .Value       = {}
368:             .Format      = "D"
369:             .FontName    = "Tahoma"

*-- Linhas 375 a 401:
375:         ENDWITH
376: 
377:         *-- Separador "a" entre datas (original: top=104, left=284 -> page: top=19)
378:         loc_oPg.AddObject("lbl_4c_Lbl_periodo_a", "Label")
379:         WITH loc_oPg.lbl_4c_Lbl_periodo_a
380:             .AutoSize  = .T.
381:             .Top       = 19
382:             .Left      = 284
383:             .Width     = 8
384:             .Caption   = "a"
385:             .FontName  = "Tahoma"
386:             .FontSize  = 8
387:             .ForeColor = RGB(90, 90, 90)
388:             .BackStyle = 0
389:             .Visible   = .T.
390:         ENDWITH
391: 
392:         *-- Data final (original: top=101, left=295 -> page: top=16)
393:         loc_oPg.AddObject("txt_4c__dt_final", "TextBox")
394:         WITH loc_oPg.txt_4c__dt_final
395:             .Top         = 16
396:             .Left        = 295
397:             .Width       = 80
398:             .Height      = 25
399:             .Value       = {}
400:             .Format      = "D"
401:             .FontName    = "Tahoma"

*-- Linhas 407 a 432:
407:         ENDWITH
408: 
409:         *-- Label "Tipo de Relatorio:" (original: top=132, left=105 -> page: top=47)
410:         loc_oPg.AddObject("lbl_4c_Label4", "Label")
411:         WITH loc_oPg.lbl_4c_Label4
412:             .Top       = 47
413:             .Left      = 105
414:             .Caption   = "Tipo de Relat" + CHR(243) + "rio:"
415:             .FontName  = "Tahoma"
416:             .FontSize  = 8
417:             .ForeColor = RGB(90, 90, 90)
418:             .BackStyle = 0
419:             .Visible   = .T.
420:         ENDWITH
421: 
422:         *-- Spinner NivImprs (original: top=127, left=199 -> page: top=42)
423:         *   Range 0-7 conforme original (KeyboardLowValue=0, KeyboardHighValue=7)
424:         loc_oPg.AddObject("obj_4c_NivImprs", "Spinner")
425:         WITH loc_oPg.obj_4c_NivImprs
426:             .Top                = 42
427:             .Left               = 199
428:             .Width              = 33
429:             .Height             = 25
430:             .Value              = 1
431:             .SpinnerHighValue   = 7.00
432:             .SpinnerLowValue    = 0.00

*-- Linhas 441 a 468:
441:         ENDWITH
442: 
443:         *-- Label "Tipo de Material :" (original: top=157, left=107 -> page: top=72)
444:         loc_oPg.AddObject("lbl_4c_Label3", "Label")
445:         WITH loc_oPg.lbl_4c_Label3
446:             .AutoSize  = .T.
447:             .Top       = 72
448:             .Left      = 107
449:             .Width     = 85
450:             .Height    = 15
451:             .Caption   = "Tipo de Material :"
452:             .FontName  = "Tahoma"
453:             .FontSize  = 8
454:             .ForeColor = RGB(90, 90, 90)
455:             .BackStyle = 0
456:             .Visible   = .T.
457:         ENDWITH
458: 
459:         *-- Tipo de material (original: top=154, left=199 -> page: top=69) [Nivel 7]
460:         loc_oPg.AddObject("txt_4c__tpmat", "TextBox")
461:         WITH loc_oPg.txt_4c__tpmat
462:             .Top         = 69
463:             .Left        = 199
464:             .Width       = 115
465:             .Height      = 23
466:             .Value       = ""
467:             .MaxLength   = 15
468:             .FontName    = "Tahoma"

*-- Linhas 475 a 502:
475:         ENDWITH
476: 
477:         *-- Label "Recuperadora :" (original: top=181, left=115 -> page: top=96)
478:         loc_oPg.AddObject("lbl_4c_Label2", "Label")
479:         WITH loc_oPg.lbl_4c_Label2
480:             .AutoSize  = .F.
481:             .Top       = 96
482:             .Left      = 115
483:             .Width     = 87
484:             .Height    = 17
485:             .Caption   = "Recuperadora :"
486:             .FontName  = "Tahoma"
487:             .FontSize  = 8
488:             .ForeColor = RGB(90, 90, 90)
489:             .BackStyle = 0
490:             .Visible   = .T.
491:         ENDWITH
492: 
493:         *-- Codigo recuperadora (original: top=179, left=199 -> page: top=94) [Nivel 7]
494:         loc_oPg.AddObject("txt_4c__ifor", "TextBox")
495:         WITH loc_oPg.txt_4c__ifor
496:             .Top         = 94
497:             .Left        = 199
498:             .Width       = 80
499:             .Height      = 23
500:             .Value       = ""
501:             .MaxLength   = 10
502:             .FontName    = "Tahoma"

*-- Linhas 512 a 521:
512:         *   Editavel apenas quando nivel=7 E ifor esta vazio (busca por nome)
513:         loc_oPg.AddObject("txt_4c__dfor", "TextBox")
514:         WITH loc_oPg.txt_4c__dfor
515:             .Top         = 94
516:             .Left        = 281
517:             .Width       = 233
518:             .Height      = 23
519:             .Value       = ""
520:             .MaxLength   = 40
521:             .FontName    = "Tahoma"

*-- Linhas 528 a 554:
528:         ENDWITH
529: 
530:         *-- Label "Grupo :" (original: top=208, left=154 -> page: top=123)
531:         loc_oPg.AddObject("lbl_4c_Label1", "Label")
532:         WITH loc_oPg.lbl_4c_Label1
533:             .AutoSize  = .T.
534:             .Top       = 123
535:             .Left      = 154
536:             .Width     = 38
537:             .Caption   = "Grupo :"
538:             .FontName  = "Tahoma"
539:             .FontSize  = 8
540:             .ForeColor = RGB(90, 90, 90)
541:             .BackStyle = 0
542:             .Visible   = .T.
543:         ENDWITH
544: 
545:         *-- Codigo do setor (original: top=204, left=199 -> page: top=119) [Nivel 7]
546:         loc_oPg.AddObject("txt_4c_CdGrupo", "TextBox")
547:         WITH loc_oPg.txt_4c_CdGrupo
548:             .Top         = 119
549:             .Left        = 199
550:             .Width       = 80
551:             .Height      = 25
552:             .Value       = ""
553:             .MaxLength   = 10
554:             .Format      = "K"

*-- Linhas 563 a 572:
563:         *-- Descricao do setor (original: top=204, left=281 -> page: top=119) [sempre ReadOnly]
564:         loc_oPg.AddObject("txt_4c_DsGrupo", "TextBox")
565:         WITH loc_oPg.txt_4c_DsGrupo
566:             .Top         = 119
567:             .Left        = 281
568:             .Width       = 233
569:             .Height      = 25
570:             .Value       = ""
571:             .MaxLength   = 20
572:             .Format      = "K"

*-- Linhas 1214 a 1222:
1214:                 "apenas N" + CHR(237) + "vel 7"
1215:             loc_oPg.txt_4c_DsGrupo.ToolTipText     = "[DblClick] Selecionar setor - " + ;
1216:                 "preenchido automaticamente ao informar o c" + CHR(243) + "digo"
1217:             loc_oPg.lbl_4c_Label4.ToolTipText      = "Selecione o n" + CHR(237) + "vel de detalhe do relat" + CHR(243) + "rio"
1218:         CATCH TO loc_oErro
1219:             MsgErro(loc_oErro.Message, "Erro")
1220:         ENDTRY
1221:     ENDPROC
1222: 


### BO (C:\4c\projeto\app\classes\SigReIfpBO.prg):
*==============================================================================
* SIGREIFPBO.PRG
* Business Object para Relatorio de Falhas / Perdas
*
* Herda de RelatorioBase
* Form: FormSigReIfp
* Relatorios FRX: SigReIfA..SigReIfF (conforme NivImprs 1-7)
* Tabela principal de dados: SigCdFea
* Tabelas auxiliares: SigCdGcr, SigCdCli, SigOpOpt
*==============================================================================

DEFINE CLASS SigReIfpBO AS RelatorioBase

    *-- Filtros do relatorio
    this_dDtInicial     = {}
    this_dDtFinal       = {}
    this_nNivImprs      = 1
    this_cTpMat         = ""
    this_cIfor          = ""
    this_cDfor          = ""
    this_cCdGrupo       = ""
    this_cDsGrupo       = ""

    *-- Cursor de dados produzido por PrepararDados (mantido como TmpRelat para compatibilidade com FRX)
    this_cCursorDados   = "TmpRelat"

    *--------------------------------------------------------------------------
    * Init - Inicializa BO e carrega cursores auxiliares de setores e clientes
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            THIS.this_cTabela     = ""
            THIS.this_cCampoChave = ""
            IF DODEFAULT()
                loc_lSucesso = THIS.CarregarCursoresAuxiliares()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarCursoresAuxiliares - Carrega TmpGccr (setores) e TmpCli (clientes)
    * Chamado uma vez no Init; cursores persistem durante a vida do BO
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE CarregarCursoresAuxiliares()
        LOCAL loc_lSucesso, loc_cSQL, loc_nRes
        loc_lSucesso = .F.
        TRY
            IF USED("TmpGccr")
                USE IN TmpGccr
            ENDIF
            IF USED("TmpCli")
                USE IN TmpCli
            ENDIF

            *-- Setores com BalFalPers = 1
            loc_cSQL = "SELECT * FROM SigCdGcr WHERE BalFalPers = 1"
            loc_nRes = SQLEXEC(gnConnHandle, loc_cSQL, "TmpGccr")
            IF loc_nRes < 0
                THIS.this_cMensagemErro = "Erro ao carregar setores (TmpGccr)"
                MsgErro("Erro ao carregar setores. Verifique a conex" + CHR(227) + "o.", "Erro")
                loc_lSucesso = .F.
            ENDIF
            SELECT TmpGccr
            INDEX ON Codigos TAG Grupos

            *-- Clientes vinculados a setores com BalFalPers = 1
            loc_cSQL = "SELECT a.* FROM SigCdCli a, SigCdGcr b " + ;
                       "WHERE a.Grupos = b.Codigos AND b.BalFalPers = 1"
            loc_nRes = SQLEXEC(gnConnHandle, loc_cSQL, "TmpCli")
            IF loc_nRes < 0
                THIS.this_cMensagemErro = "Erro ao carregar clientes (TmpCli)"
                MsgErro("Erro ao carregar clientes. Verifique a conex" + CHR(227) + "o.", "Erro")
                loc_lSucesso = .F.
            ENDIF
            SELECT TmpCli
            INDEX ON Iclis          TAG Iclis
            INDEX ON Grupos + Iclis TAG Grupos

            loc_lSucesso = .T.
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * PrepararDados - Monta TmpRelat e dbCabecalho para os FRX de relatorio
    * Replica a logica do PROCEDURE processamento do form legado SIGREIFP
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE PrepararDados()
        LOCAL loc_lSucesso, loc_cSQL, loc_nRes
        LOCAL loc_ldDti, loc_ldDtf, loc_lnNiv, loc_lcNiv
        LOCAL loc_lcTpM, loc_lcFor, loc_lcGrp
        LOCAL loc_nTotGccr, loc_nTotCli, loc_nTotClig
        LOCAL loc_lnTrab, loc_lnFalha, loc_lnPeso, loc_lnPerda, loc_lnTPerda
        LOCAL loc_lnRecupera, loc_lnPesob, loc_lnReccb, loc_lnRecsb
        LOCAL loc_cCab, loc_cSub, loc_cEmp, loc_cTit
        LOCAL loc_cDtI, loc_cDtF
        LOCAL loc_cGrSeek, loc_cIfors7

        loc_lSucesso = .F.
        TRY
            *-- Obter filtros do BO
            loc_ldDti  = THIS.this_dDtInicial
            loc_ldDtf  = THIS.this_dDtFinal
            loc_lnNiv  = THIS.this_nNivImprs
            loc_lcNiv  = STR(loc_lnNiv, 1)
            loc_lcTpM  = ALLTRIM(THIS.this_cTpMat)
            loc_lcFor  = ALLTRIM(THIS.this_cIfor)
            loc_lcGrp  = ALLTRIM(THIS.this_cCdGrupo)

            *-- Validar periodo
            IF EMPTY(loc_ldDti) OR EMPTY(loc_ldDtf)
                THIS.this_cMensagemErro = "Informe o per" + CHR(237) + "odo inicial e final"
                MsgAviso("Informe o per" + CHR(237) + "odo inicial e final.", ;
                         "Aten" + CHR(231) + CHR(227) + "o")
                loc_lSucesso = .F.
            ENDIF

            *-- Verificar cursores auxiliares
            IF !USED("TmpGccr") OR !USED("TmpCli")
                IF !THIS.CarregarCursoresAuxiliares()
                    loc_lSucesso = .F.
                ENDIF
            ENDIF

            *-- Fechar cursores de execucoes anteriores
            IF USED("TmpRelat")
                USE IN TmpRelat
            ENDIF
            IF USED("csSelecao")
                USE IN csSelecao
            ENDIF
            IF USED("dbCabecalho")
                USE IN dbCabecalho
            ENDIF
            IF USED("crSigCdCli")
                USE IN crSigCdCli
            ENDIF
            IF USED("crSigCdEmp")
                USE IN crSigCdEmp
            ENDIF

            *-- Criar cursor de resultado (mesmo esquema que o original)
            CREATE CURSOR TmpRelat (Operacs c(30), Totas n(12,2), Grupos c(10), Dgrupos c(30), ;
                Contas c(10), Rclis c(30), ;
                falhags n(12,2), Recupgs n(12,2), Perdags n(12,2), Falhaps n(7,2), Recupps n(7,2), ;
                Perdaps n(7,2), Trabs n(12,2), fatrabs n(7,2), recfals n(7,2), Perdidos n(7,2), ;
                pertrabs n(7,2), TpOps c(15), Pesbs n(12,2), recCcobs n(12,2), RecScobs n(12,2), ;
                recpesos n(7,2), Nivels c(1), Datas d)
            INDEX ON Operacs                             TAG Operacao
            INDEX ON Nivels + Grupos                     TAG Grupos
            INDEX ON Contas                              TAG Contas
            INDEX ON Grupos + Contas                     TAG GruCon
            INDEX ON Grupos + TpOps                      TAG GruTp
            INDEX ON TpOps + Grupos + Contas + DTOS(Datas) TAG TpGruCond

            *-- Buscar registros de falhas/perdas no periodo (YYYYMMDD + tempo para DATETIME)
            loc_cDtI = DTOC(loc_ldDti, 1)
            loc_cDtF = DTOC(loc_ldDtf, 1)
            loc_cSQL = "SELECT * FROM SigCdFea " + ;
                       "WHERE Datas BETWEEN " + EscaparSQL(loc_cDtI) + " AND " + EscaparSQL(loc_cDtF + " 23:59:59") + ;
                       " AND (Tipos = 'F' OR (Tipos = 'P' AND Baixas = 1))"
            loc_nRes = SQLEXEC(gnConnHandle, loc_cSQL, "csSelecao")
            IF loc_nRes < 0
                THIS.this_cMensagemErro = "Erro ao buscar dados de falhas/perdas"
                MsgErro("Erro ao buscar dados. Verifique a conex" + CHR(227) + "o.", "Erro")
                loc_lSucesso = .F.
            ENDIF

            *-- Contar totais dos cursores auxiliares
            SELECT TmpGccr
            COUNT TO loc_nTotGccr

            SELECT TmpCli
            COUNT TO loc_nTotCli

            *=========================================
            * NIVEL 1 - Resumo global (totais)
            *=========================================
            IF (loc_lnNiv = 1)
                SELECT TmpRelat
                SET ORDER TO
                SELECT csSelecao
                SUM Produzidos, Falhas, Pesoccbs TO loc_lnTrab, loc_lnFalha, loc_lnPeso
                loc_lnPerda = loc_lnFalha - loc_lnPeso
                SELECT TmpRelat
                APPEND BLANK
                REPLACE Operacs WITH "Produzido (g)", ;
                        Totas   WITH loc_lnTrab
                APPEND BLANK
                REPLACE Operacs WITH "Falha (g)", ;
                        Totas   WITH loc_lnFalha
                APPEND BLANK
                REPLACE Operacs WITH "Recupera" + CHR(231) + CHR(227) + "o c/Cobr (g)", ;
                        Totas   WITH loc_lnPeso
                APPEND BLANK
                REPLACE Operacs WITH "Perda (g)", ;
                        Totas   WITH loc_lnPerda
                APPEND BLANK
                REPLACE Operacs WITH "Falha/Produzido (%)", ;
                        Totas   WITH IIF(loc_lnTrab <> 0, (loc_lnFalha / loc_lnTrab * 100), 0)
                APPEND BLANK
                REPLACE Operacs WITH "Recupera" + CHR(231) + CHR(227) + "o/Falha (%)", ;
                        Totas   WITH IIF(loc_lnFalha <> 0, (loc_lnPeso / loc_lnFalha * 100), 0)
                APPEND BLANK
                REPLACE Operacs WITH "Perda/Produzido (%)", ;
                        Totas   WITH IIF(loc_lnTrab <> 0, (loc_lnPerda / loc_lnTrab * 100), 0)
            ENDIF

            *=========================================
            * NIVEL 2 - Por setor (Grupos)
            *=========================================
            IF (loc_lnNiv = 2)
                SELECT TmpRelat
                SET ORDER TO Grupos
                SELECT csSelecao
                SCAN
                    IF EMPTY(csSelecao.Grupos) AND EMPTY(csSelecao.Contas) AND ;
                       !EMPTY(csSelecao.Produzidos)
                        LOOP
                    ENDIF

                    IF EMPTY(csSelecao.Grupos)
                        loc_lnRecupera = IIF(loc_nTotGccr > 0, csSelecao.Pesoccbs / loc_nTotGccr, 0)
                        SELECT TmpGccr
                        SCAN
                            SELECT TmpRelat
                            SET ORDER TO Grupos
                            SEEK loc_lcNiv + TmpGccr.Codigos
                            IF EOF()
                                APPEND BLANK
                                REPLACE Grupos  WITH TmpGccr.Codigos, ;
                                        Dgrupos WITH TmpGccr.Descrs, ;
                                        Nivels  WITH loc_lcNiv
                            ENDIF
                            REPLACE Recupgs WITH Recupgs + loc_lnRecupera
                        ENDSCAN
                    ELSE
                        SELECT TmpGccr
                        SET ORDER TO Grupos
                        SEEK csSelecao.Grupos
                        loc_lnRecupera = csSelecao.Pesoccbs
                        SELECT TmpRelat
                        SEEK loc_lcNiv + csSelecao.Grupos
                        IF EOF()
                            APPEND BLANK
                            REPLACE Grupos  WITH csSelecao.Grupos, ;
                                    Dgrupos WITH TmpGccr.Descrs, ;
                                    Nivels  WITH loc_lcNiv
                        ENDIF
                        REPLACE Recupgs WITH Recupgs + loc_lnRecupera
                        REPLACE falhags WITH falhags + csSelecao.Falhas
                        REPLACE Trabs   WITH Trabs   + csSelecao.Trabs
                    ENDIF
                ENDSCAN

                SELECT TmpRelat
                SUM falhags, Recupgs TO loc_lnFalha, loc_lnPeso
                loc_lnTPerda = loc_lnFalha - loc_lnPeso
                SCAN
                    REPLACE Perdags WITH falhags - Recupgs, ;
                            Falhaps WITH IIF(loc_lnFalha  <> 0, (falhags  / loc_lnFalha  * 100), 0), ;
                            Recupps WITH IIF(loc_lnPeso   <> 0, (Recupgs  / loc_lnPeso   * 100), 0), ;
                            Perdaps WITH IIF(loc_lnTPerda <> 0, (Perdags  / loc_lnTPerda * 100), 0)
                ENDSCAN
            ENDIF

            *=========================================
            * NIVEL 3 - Por cliente (falhas)
            *=========================================
            IF (loc_lnNiv = 3)
                SELECT TmpRelat
                SET ORDER TO Contas
                SELECT csSelecao
                SUM Falhas TO loc_lnFalha
                SCAN
                    IF EMPTY(csSelecao.Grupos) AND EMPTY(csSelecao.Contas) AND ;
                       !EMPTY(csSelecao.Produzidos)
                        LOOP
                    ENDIF
                    IF csSelecao.Tipos = "F"
                        =SEEK(csSelecao.Contas, "TmpCli", "Iclis")
                        SELECT TmpRelat
                        SEEK csSelecao.Contas
                        IF EOF()
                            APPEND BLANK
                            REPLACE Contas WITH csSelecao.Contas, ;
                                    Rclis  WITH TmpCli.Rclis, ;
                                    Nivels WITH loc_lcNiv
                        ENDIF
                        REPLACE falhags WITH falhags + csSelecao.Falhas
                    ENDIF
                ENDSCAN
                SELECT TmpRelat
                SCAN
                    REPLACE Falhaps WITH IIF(loc_lnFalha <> 0, (falhags / loc_lnFalha * 100), 0)
                ENDSCAN
            ENDIF

            *=========================================
            * NIVEL 4 - Por cliente (recuperacoes)
            *=========================================
            IF (loc_lnNiv = 4)
                SELECT TmpRelat
                SET ORDER TO Contas
                SELECT csSelecao
                SCAN
                    IF EMPTY(csSelecao.Grupos) AND EMPTY(csSelecao.Contas) AND ;
                       !EMPTY(csSelecao.Produzidos)
                        LOOP
                    ENDIF

                    IF EMPTY(csSelecao.Grupos)
                        loc_lnRecupera = IIF(loc_nTotCli > 0, csSelecao.Pesoccbs / loc_nTotCli, 0)
                        SELECT TmpCli
                        SCAN
                            SELECT TmpRelat
                            SET ORDER TO Contas
                            SEEK TmpCli.Iclis
                            IF EOF()
                                APPEND BLANK
                                REPLACE Contas WITH TmpCli.Iclis, ;
                                        Rclis  WITH TmpCli.Rclis, ;
                                        Nivels WITH loc_lcNiv
                            ENDIF
                            REPLACE Recupgs WITH Recupgs + loc_lnRecupera
                        ENDSCAN
                    ELSE
                        IF EMPTY(csSelecao.Contas)
                            loc_cGrSeek = csSelecao.Grupos
                            SELECT TmpCli
                            SET ORDER TO Grupos
                            SEEK loc_cGrSeek
                            COUNT TO loc_nTotClig WHILE Grupos = loc_cGrSeek
                            loc_lnRecupera = IIF(loc_nTotClig > 0, ;
                                csSelecao.Pesoccbs / loc_nTotClig, 0)
                            SEEK loc_cGrSeek
                            SCAN WHILE Grupos = loc_cGrSeek
                                SELECT TmpRelat
                                SEEK TmpCli.Iclis
                                IF EOF()
                                    APPEND BLANK
                                    REPLACE Contas WITH TmpCli.Iclis, ;
                                            Rclis  WITH TmpCli.Rclis, ;
                                            Nivels WITH loc_lcNiv
                                ENDIF
                                REPLACE Recupgs WITH Recupgs + loc_lnRecupera
                            ENDSCAN
                        ELSE
                            loc_lnRecupera = csSelecao.Pesoccbs
                            =SEEK(csSelecao.Contas, "TmpCli", "Iclis")
                            SELECT TmpRelat
                            SEEK csSelecao.Contas
                            IF EOF()
                                APPEND BLANK
                                REPLACE Contas WITH TmpCli.Iclis, ;
                                        Rclis  WITH TmpCli.Rclis, ;
                                        Nivels WITH loc_lcNiv
                            ENDIF
                            REPLACE falhags WITH falhags + csSelecao.Falhas
                            REPLACE Recupgs WITH Recupgs + loc_lnRecupera
                        ENDIF
                    ENDIF
                ENDSCAN

                SELECT TmpRelat
                SUM falhags - Recupgs TO loc_lnTPerda
                SCAN
                    REPLACE Perdags WITH falhags - Recupgs
                    REPLACE Perdaps WITH IIF(loc_lnTPerda <> 0, (Perdags / loc_lnTPerda * 100), 0)
                ENDSCAN
            ENDIF

            *=========================================
            * NIVEL 5 - Por setor e cliente
            *=========================================
            IF (loc_lnNiv = 5)
                SELECT TmpRelat
                SET ORDER TO GruCon
                SELECT csSelecao
                SCAN
                    IF EMPTY(csSelecao.Grupos) AND EMPTY(csSelecao.Contas) AND ;
                       !EMPTY(csSelecao.Produzidos)
                        LOOP
                    ENDIF

                    IF csSelecao.Tipos = "F"
                        SELECT TmpRelat
                        SEEK csSelecao.Grupos + csSelecao.Contas
                        IF EOF()
                            APPEND BLANK
                            REPLACE Grupos WITH csSelecao.Grupos, ;
                                    Contas WITH csSelecao.Contas
                        ENDIF
                        REPLACE Trabs   WITH Trabs   + csSelecao.Trabs
                        REPLACE falhags WITH falhags + csSelecao.Falhas
                    ELSE
                        IF EMPTY(csSelecao.Grupos)
                            loc_lnRecupera = IIF(loc_nTotCli > 0, csSelecao.Pesoccbs / loc_nTotCli, 0)
                            SELECT TmpCli
                            SCAN
                                SELECT TmpRelat
                                SEEK TmpCli.Grupos + TmpCli.Iclis
                                IF EOF()
                                    APPEND BLANK
                                    REPLACE Grupos WITH TmpCli.Grupos, ;
                                            Contas WITH TmpCli.Iclis
                                ENDIF
                                REPLACE Recupgs WITH Recupgs + loc_lnRecupera
                            ENDSCAN
                        ELSE
                            IF EMPTY(csSelecao.Contas)
                                loc_cGrSeek = csSelecao.Grupos
                                SELECT TmpCli
                                SET ORDER TO Grupos
                                SEEK loc_cGrSeek
                                COUNT TO loc_nTotClig WHILE Grupos = loc_cGrSeek
                                loc_lnRecupera = IIF(loc_nTotClig > 0, ;
                                    csSelecao.Pesoccbs / loc_nTotClig, 0)
                                SEEK loc_cGrSeek
                                SCAN WHILE Grupos = loc_cGrSeek
                                    SELECT TmpRelat
                                    SEEK TmpCli.Grupos + TmpCli.Iclis
                                    IF EOF()
                                        APPEND BLANK
                                        REPLACE Contas WITH TmpCli.Iclis, ;
                                                Grupos WITH TmpCli.Grupos
                                    ENDIF
                                    REPLACE Recupgs WITH Recupgs + loc_lnRecupera
                                ENDSCAN
                            ELSE
                                loc_lnRecupera = csSelecao.Pesoccbs
                                =SEEK(csSelecao.Contas, "TmpCli", "Iclis")
                                SELECT TmpRelat
                                SEEK csSelecao.Grupos + csSelecao.Contas
                                IF EOF()
                                    APPEND BLANK
                                    REPLACE Contas WITH TmpCli.Iclis, ;
                                            Grupos WITH TmpCli.Grupos
                                ENDIF
                                REPLACE falhags WITH falhags + csSelecao.Falhas
                                REPLACE Recupgs WITH Recupgs + loc_lnRecupera
                            ENDIF
                        ENDIF
                    ENDIF
                ENDSCAN

                SELECT TmpRelat
                SCAN
                    REPLACE Perdags  WITH falhags - Recupgs, ;
                            fatrabs  WITH IIF(Trabs   <> 0, (falhags  / Trabs   * 100), 0), ;
                            recfals  WITH IIF(falhags <> 0, (Recupgs  / falhags * 100), 0), ;
                            Pertrabs WITH IIF(Trabs   <> 0, (Perdags  / Trabs   * 100), 0), ;
                            Perdidos WITH IIF(falhags <> 0, (Perdags  / falhags * 100), 0)
                ENDSCAN
            ENDIF

            *=========================================
            * NIVEL 6 - Por setor e tipo de material
            *=========================================
            IF (loc_lnNiv = 6)
                SELECT TmpRelat
                SET ORDER TO GruTp
                SELECT csSelecao
                SCAN
                    IF (csSelecao.Tipos = "F") OR ;
                       (EMPTY(csSelecao.Grupos) AND EMPTY(csSelecao.Contas) AND ;
                        !EMPTY(csSelecao.Produzidos))
                        LOOP
                    ENDIF

                    IF EMPTY(csSelecao.Grupos)
                        loc_lnPesob = IIF(loc_nTotGccr > 0, csSelecao.Brutos   / loc_nTotGccr, 0)
                        loc_lnReccb = IIF(loc_nTotGccr > 0, csSelecao.Pesoccbs / loc_nTotGccr, 0)
                        loc_lnRecsb = IIF(loc_nTotGccr > 0, csSelecao.Pesoscbs / loc_nTotGccr, 0)
                        SELECT TmpGccr
                        SCAN
                            SELECT TmpRelat
                            SET ORDER TO GruTp
                            SEEK TmpGccr.Codigos + csSelecao.TpMats
                            IF EOF()
                                APPEND BLANK
                                REPLACE Grupos WITH TmpGccr.Codigos, ;
                                        TpOps  WITH csSelecao.TpMats
                            ENDIF
                            REPLACE Pesbs    WITH Pesbs    + loc_lnPesob, ;
                                    recCcobs WITH recCcobs + loc_lnReccb, ;
                                    RecScobs WITH RecScobs + loc_lnRecsb
                        ENDSCAN
                    ELSE
                        loc_lnPesob = csSelecao.Brutos
                        loc_lnReccb = csSelecao.Pesoccbs
                        loc_lnRecsb = csSelecao.Pesoscbs
                        SELECT TmpRelat
                        SET ORDER TO GruTp
                        SEEK csSelecao.Grupos + csSelecao.TpMats
                        IF EOF()
                            APPEND BLANK
                            REPLACE Grupos WITH csSelecao.Grupos, ;
                                    TpOps  WITH csSelecao.TpMats
                        ENDIF
                        REPLACE Pesbs    WITH Pesbs    + loc_lnPesob, ;
                                recCcobs WITH recCcobs + loc_lnReccb, ;
                                RecScobs WITH RecScobs + loc_lnRecsb
                    ENDIF
                ENDSCAN

                SELECT TmpRelat
                SCAN
                    REPLACE recpesos WITH IIF(Pesbs <> 0, (RecScobs / Pesbs * 100), 0)
                ENDSCAN
            ENDIF

            *=========================================
            * NIVEL 7 - Detalhado (tipo+setor+cliente+data)
            *=========================================
            IF (loc_lnNiv = 7)
                SELECT TmpRelat
                SET ORDER TO TpGruCond
                SELECT csSelecao
                SCAN
                    IF csSelecao.Tipos = "F" OR ;
                       (EMPTY(csSelecao.Grupos) AND EMPTY(csSelecao.Contas) AND ;
                        !EMPTY(csSelecao.Produzidos))
                        LOOP
                    ENDIF
                    IF !EMPTY(loc_lcTpM) AND loc_lcTpM <> ALLTRIM(csSelecao.TpMats)
                        LOOP
                    ENDIF
                    IF !EMPTY(loc_lcFor) AND loc_lcFor <> ALLTRIM(csSelecao.Ifors)
                        LOOP
                    ENDIF
                    IF !EMPTY(loc_lcGrp) AND loc_lcGrp <> ALLTRIM(csSelecao.Grupos)
                        LOOP
                    ENDIF

                    *-- Buscar descricao da recuperadora via TmpCli (cursor em memoria)
                    loc_cIfors7 = ALLTRIM(csSelecao.Ifors)
                    LOCAL loc_cRclis7
                    loc_cRclis7 = ""
                    IF USED("TmpCli")
                        =SEEK(loc_cIfors7, "TmpCli", "Iclis")
                        IF !EOF("TmpCli") AND ALLTRIM(TmpCli.Iclis) = loc_cIfors7
                            loc_cRclis7 = ALLTRIM(TmpCli.Rclis)
                        ENDIF
                    ENDIF

                    loc_lnPesob = csSelecao.Brutos
                    loc_lnRecsb = csSelecao.Pesoscbs
                    SELECT TmpRelat
                    APPEND BLANK
                    REPLACE Contas   WITH csSelecao.Grupos, ;
                            TpOps    WITH csSelecao.TpMats, ;
                            Datas    WITH csSelecao.Datas, ;
                            Grupos   WITH csSelecao.Ifors, ;
                            Dgrupos  WITH loc_cRclis7, ;
                            Pesbs    WITH Pesbs    + csSelecao.Brutos, ;
                            RecScobs WITH RecScobs + csSelecao.Pesoscbs, ;
                            recpesos WITH IIF(Pesbs <> 0, (RecScobs / Pesbs * 100), 0)
                ENDSCAN
            ENDIF

            *-- Montar cabecalho para os FRX
            loc_cCab = "Rela" + CHR(231) + CHR(227) + "o de Falhas / Perdas"
            loc_cSub = "Per" + CHR(237) + "odo: " + DTOC(loc_ldDti) + " a " + DTOC(loc_ldDtf)

            *-- Razao social da empresa via go_4c_Sistema
            loc_cEmp = go_4c_Sistema.cCodEmpresa + " - " + ALLTRIM(go_4c_Sistema.cEmpresa)

            *-- Linha de filtros ativos
            loc_cTit = IIF(!EMPTY(loc_lcTpM), loc_lcTpM, "") + ;
                       IIF(!EMPTY(loc_lcFor), " / " + loc_lcFor, "") + ;
                       IIF(!EMPTY(loc_lcGrp), " / " + loc_lcGrp, "")
            loc_cTit = IIF(!EMPTY(loc_cTit), "Filtros: " + loc_cTit, "")

            *-- Cursor de cabecalho usado pelos FRX
            IF USED("dbCabecalho")
                USE IN dbCabecalho
            ENDIF
            CREATE CURSOR dbCabecalho (Titulo c(100), SubTitulo c(100), NomeEmpresa c(100), Periodos c(100))
            INSERT INTO dbCabecalho (Titulo, Periodos, NomeEmpresa, SubTitulo) ;
                VALUES (loc_cCab, loc_cTit, loc_cEmp, loc_cSub)

            *-- Posicionar TmpRelat no inicio para o FRX
            SELECT TmpRelat
            GO TOP

            loc_lSucesso = .T.
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Imprimir - Prepara dados e imprime com dialogo de impressora
    *--------------------------------------------------------------------------
    PROCEDURE Imprimir()
        LOCAL loc_lSucesso, loc_cFrx
        loc_lSucesso = .F.
        TRY
            IF !THIS.PrepararDados()
                loc_lSucesso = .F.
            ENDIF
            loc_cFrx = THIS.ObterRelatorioFrx()
            IF EMPTY(loc_cFrx)
                THIS.this_cMensagemErro = "N" + CHR(237) + "vel de relat" + CHR(243) + ;
                    "rio inv" + CHR(225) + "lido"
                MsgAviso("N" + CHR(237) + "vel de relat" + CHR(243) + "rio inv" + CHR(225) + ;
                         "lido (0 ou > 7).", "Aten" + CHR(231) + CHR(227) + "o")
                loc_lSucesso = .F.
            ENDIF
            REPORT FORM (loc_cFrx) TO PRINT PROMPT NOCONSOLE
            loc_lSucesso = .T.
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Visualizar - Prepara dados e exibe o relatorio em preview
    *--------------------------------------------------------------------------
    PROCEDURE Visualizar()
        LOCAL loc_lSucesso, loc_cFrx
        loc_lSucesso = .F.
        TRY
            IF !THIS.PrepararDados()
                loc_lSucesso = .F.
            ENDIF
            loc_cFrx = THIS.ObterRelatorioFrx()
            IF EMPTY(loc_cFrx)
                THIS.this_cMensagemErro = "N" + CHR(237) + "vel de relat" + CHR(243) + ;
                    "rio inv" + CHR(225) + "lido"
                MsgAviso("N" + CHR(237) + "vel de relat" + CHR(243) + "rio inv" + CHR(225) + ;
                         "lido (0 ou > 7).", "Aten" + CHR(231) + CHR(227) + "o")
                loc_lSucesso = .F.
            ENDIF
            REPORT FORM (loc_cFrx) PREVIEW NOCONSOLE
            loc_lSucesso = .T.
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterRelatorioFrx - Retorna caminho do FRX conforme NivImprs
    *--------------------------------------------------------------------------
    FUNCTION ObterRelatorioFrx()
        LOCAL loc_cFrx
        loc_cFrx = ""
        DO CASE
            CASE THIS.this_nNivImprs = 1
                loc_cFrx = gc_4c_CaminhoReports + "SigReIfA.frx"
            CASE THIS.this_nNivImprs = 2
                loc_cFrx = gc_4c_CaminhoReports + "SigReIfB.frx"
            CASE THIS.this_nNivImprs = 3 OR THIS.this_nNivImprs = 4
                loc_cFrx = gc_4c_CaminhoReports + "SigReIfC.frx"
            CASE THIS.this_nNivImprs = 5
                loc_cFrx = gc_4c_CaminhoReports + "SigReIfD.frx"
            CASE THIS.this_nNivImprs = 6
                loc_cFrx = gc_4c_CaminhoReports + "SigReIfE.frx"
            CASE THIS.this_nNivImprs = 7
                loc_cFrx = gc_4c_CaminhoReports + "SigReIfF.frx"
        ENDCASE
        RETURN loc_cFrx
    ENDFUNC

    *--------------------------------------------------------------------------
    * ObterMensagemErro - Retorna ultima mensagem de erro
    *--------------------------------------------------------------------------
    FUNCTION ObterMensagemErro()
        RETURN THIS.this_cMensagemErro
    ENDFUNC

    *--------------------------------------------------------------------------
    * Destroy - Libera todos os cursores do ciclo de vida do BO
    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
        IF USED("TmpGccr")
            USE IN TmpGccr
        ENDIF
        IF USED("TmpCli")
            USE IN TmpCli
        ENDIF
        IF USED("TmpRelat")
            USE IN TmpRelat
        ENDIF
        IF USED("csSelecao")
            USE IN csSelecao
        ENDIF
        IF USED("dbCabecalho")
            USE IN dbCabecalho
        ENDIF
        IF USED("crSigCdCli")
            USE IN crSigCdCli
        ENDIF
        IF USED("crSigCdEmp")
            USE IN crSigCdEmp
        ENDIF
        DODEFAULT()
    ENDPROC

ENDDEFINE


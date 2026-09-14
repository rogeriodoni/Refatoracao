# CODE REVIEW - PASS VISUAL: Visual Properties (alinhamento, titulos, tipos)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Visual Properties (alinhamento, titulos, tipos)**.

## PROBLEMAS DETECTADOS (2)
- [FONTNAME-ERRADO] Linha 194: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 216: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.

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

### FORM (C:\4c\projeto\app\forms\operacionais\FormSIGMDETQ.prg) - TRECHOS RELEVANTES PARA PASS VISUAL (920 linhas total):

*-- Linhas 86 a 133:
86:     PROTECTED PROCEDURE ConfigurarPageFrame()
87:         THIS.AddObject("cnt_4c_Sombra", "Container")
88:         WITH THIS.cnt_4c_Sombra
89:             .Top         = 0
90:             .Left        = 0
91:             .Width       = 800
92:             .Height      = 80
93:             .BackColor   = RGB(100, 100, 100)
94:             .BorderWidth = 0
95:             .Visible     = .T.
96: 
97:             .AddObject("lbl_4c_LblSombra", "Label")
98:             WITH .lbl_4c_LblSombra
99:                 .Top           = 18
100:                 .Left          = 10
101:                 .Width         = 769
102:                 .Height        = 40
103:                 .FontBold      = .T.
104:                 .FontName      = "Tahoma"
105:                 .FontSize      = 18
106:                 .FontUnderline = .F.
107:                 .BackStyle     = 0
108:                 .WordWrap      = .T.
109:                 .Alignment     = 0
110:                 .ForeColor     = RGB(0, 0, 0)
111:                 .Caption       = "Muda Cor / Tamanho Etiqueta"
112:                 .Visible       = .T.
113:             ENDWITH
114: 
115:             .AddObject("lbl_4c_LblTitulo", "Label")
116:             WITH .lbl_4c_LblTitulo
117:                 .Top       = 17
118:                 .Left      = 10
119:                 .Width     = 769
120:                 .Height    = 46
121:                 .FontBold  = .T.
122:                 .FontName  = "Tahoma"
123:                 .FontSize  = 18
124:                 .BackStyle = 0
125:                 .WordWrap  = .T.
126:                 .Alignment = 0
127:                 .ForeColor = RGB(255, 255, 255)
128:                 .Caption   = "Muda Cor / Tamanho Etiqueta"
129:                 .Visible   = .T.
130:             ENDWITH
131:         ENDWITH
132:     ENDPROC
133: 

*-- Linhas 182 a 222:
182:     *   Cancelar  (Command1): Left=562+80=642, Top=-2+5=3
183:     *==========================================================================
184:     PROTECTED PROCEDURE ConfigurarBotoes()
185:         THIS.AddObject("cmd_4c_Processar", "CommandButton")
186:         WITH THIS.cmd_4c_Processar
187:             .Top             = 3
188:             .Left            = 567
189:             .Height          = 75
190:             .Width           = 75
191:             .Caption         = "\<Processar"
192:             .FontBold        = .T.
193:             .FontItalic      = .T.
194:             .FontName        = "Comic Sans MS"
195:             .FontSize        = 8
196:             .WordWrap        = .T.
197:             .ForeColor       = RGB(90, 90, 90)
198:             .BackColor       = RGB(255, 255, 255)
199:             .SpecialEffect   = 0
200:             .Themes          = .F.
201:             .MousePointer    = 15
202:             .PicturePosition = 13
203:             .Picture         = gc_4c_CaminhoBase + "Framework\imagens\geral_configuracao_60.jpg"
204:             .ToolTipText     = "Confirmar a Sele" + CHR(231) + CHR(227) + "o"
205:         ENDWITH
206: 
207:         THIS.AddObject("cmd_4c_Cancelar", "CommandButton")
208:         WITH THIS.cmd_4c_Cancelar
209:             .Top             = 3
210:             .Left            = 642
211:             .Height          = 75
212:             .Width           = 75
213:             .Caption         = "\<Cancelar"
214:             .FontBold        = .T.
215:             .FontItalic      = .T.
216:             .FontName        = "Comic Sans MS"
217:             .FontSize        = 8
218:             .WordWrap        = .T.
219:             .ForeColor       = RGB(90, 90, 90)
220:             .BackColor       = RGB(255, 255, 255)
221:             .SpecialEffect   = 0
222:             .Themes          = .F.

*-- Linhas 246 a 255:
246:     * Eventos dos campos de entrada sao vinculados em fases posteriores
247:     *==========================================================================
248:     PROTECTED PROCEDURE ConfigurarBINDEVENTs()
249:         BINDEVENT(THIS.cmd_4c_Processar, "Click", THIS, "BtnProcessarClick")
250:         BINDEVENT(THIS.cmd_4c_Cancelar,  "Click", THIS, "BtnCancelarClick")
251:         BINDEVENT(THIS.txt_4c_Barras, "KeyPress",          THIS, "TxtBarrasKeyPress")
252:         BINDEVENT(THIS.txt_4c_Barras, "InteractiveChange", THIS, "TxtBarrasInteractiveChange")
253:         BINDEVENT(THIS.txt_4c_CorNew, "KeyPress",          THIS, "TxtCorNewKeyPress")
254:         BINDEVENT(THIS.txt_4c_TamNew, "KeyPress",          THIS, "TxtTamNewKeyPress")
255:     ENDPROC

*-- Linhas 319 a 477:
319:         *-- Shape1: caixa ao redor do campo Codigo de Barra
320:         THIS.AddObject("shp_4c_Shape1", "Shape")
321:         WITH THIS.shp_4c_Shape1
322:             .Top       = 85
323:             .Left      = 28
324:             .Width     = 232
325:             .Height    = 31
326:             .BackStyle = 0
327:             .FillStyle = 1
328:         ENDWITH
329: 
330:         *-- Shape2: caixa externa Antigo+Novo
331:         THIS.AddObject("shp_4c_Shape2", "Shape")
332:         WITH THIS.shp_4c_Shape2
333:             .Top       = 118
334:             .Left      = 28
335:             .Width     = 399
336:             .Height    = 80
337:             .BackStyle = 0
338:             .FillStyle = 1
339:         ENDWITH
340: 
341:         *-- Shape4: caixa Antigo (metade esquerda)
342:         THIS.AddObject("shp_4c_Shape4", "Shape")
343:         WITH THIS.shp_4c_Shape4
344:             .Top       = 118
345:             .Left      = 28
346:             .Width     = 197
347:             .Height    = 80
348:             .BackStyle = 0
349:             .FillStyle = 1
350:         ENDWITH
351: 
352:         *-- Shape3: linha de header Antigo/Novo
353:         THIS.AddObject("shp_4c_Shape3", "Shape")
354:         WITH THIS.shp_4c_Shape3
355:             .Top       = 118
356:             .Left      = 28
357:             .Width     = 399
358:             .Height    = 24
359:             .BackStyle = 0
360:             .FillStyle = 1
361:         ENDWITH
362: 
363:         *-- lbl_4c_Say1: "Codigo de Barra :"
364:         THIS.AddObject("lbl_4c_Say1", "Label")
365:         WITH THIS.lbl_4c_Say1
366:             .Top       = 92
367:             .Left      = 56
368:             .AutoSize  = .T.
369:             .FontName  = "Tahoma"
370:             .FontSize  = 8
371:             .BackStyle = 0
372:             .ForeColor = RGB(90, 90, 90)
373:             .Caption   = "C" + CHR(243) + "digo de \<Barra :"
374:         ENDWITH
375: 
376:         *-- lbl_4c_Label1: "Antigo" - FontBold + FontSize 10 conforme original
377:         THIS.AddObject("lbl_4c_Label1", "Label")
378:         WITH THIS.lbl_4c_Label1
379:             .Top      = 122
380:             .Left     = 94
381:             .Width    = 45
382:             .Height   = 18
383:             .AutoSize = .T.
384:             .FontBold = .T.
385:             .FontName = "Tahoma"
386:             .FontSize = 10
387:             .BackStyle = 0
388:             .ForeColor = RGB(90, 90, 90)
389:             .Caption   = "Antigo"
390:         ENDWITH
391: 
392:         *-- lbl_4c_Label2: "Novo" - FontBold + FontSize 10 conforme original
393:         THIS.AddObject("lbl_4c_Label2", "Label")
394:         WITH THIS.lbl_4c_Label2
395:             .Top      = 122
396:             .Left     = 292
397:             .Width    = 34
398:             .Height   = 18
399:             .AutoSize = .T.
400:             .FontBold = .T.
401:             .FontName = "Tahoma"
402:             .FontSize = 10
403:             .BackStyle = 0
404:             .ForeColor = RGB(90, 90, 90)
405:             .Caption   = "Novo"
406:         ENDWITH
407: 
408:         *-- lbl_4c_Label3: "Cor :" (Antigo)
409:         THIS.AddObject("lbl_4c_Label3", "Label")
410:         WITH THIS.lbl_4c_Label3
411:             .Top       = 150
412:             .Left      = 76
413:             .Width     = 26
414:             .Height    = 15
415:             .AutoSize  = .T.
416:             .FontName  = "Tahoma"
417:             .FontSize  = 8
418:             .BackStyle = 0
419:             .ForeColor = RGB(90, 90, 90)
420:             .Caption   = "Cor :"
421:         ENDWITH
422: 
423:         *-- lbl_4c_Label4: "Tamanho :" (Antigo)
424:         THIS.AddObject("lbl_4c_Label4", "Label")
425:         WITH THIS.lbl_4c_Label4
426:             .Top       = 174
427:             .Left      = 49
428:             .Width     = 53
429:             .Height    = 15
430:             .AutoSize  = .T.
431:             .FontName  = "Tahoma"
432:             .FontSize  = 8
433:             .BackStyle = 0
434:             .ForeColor = RGB(90, 90, 90)
435:             .Caption   = "Tamanho :"
436:         ENDWITH
437: 
438:         *-- lbl_4c_Label5: "Cor :" (Novo)
439:         THIS.AddObject("lbl_4c_Label5", "Label")
440:         WITH THIS.lbl_4c_Label5
441:             .Top       = 150
442:             .Left      = 272
443:             .Width     = 26
444:             .Height    = 15
445:             .AutoSize  = .T.
446:             .FontName  = "Tahoma"
447:             .FontSize  = 8
448:             .BackStyle = 0
449:             .ForeColor = RGB(90, 90, 90)
450:             .Caption   = "Cor :"
451:         ENDWITH
452: 
453:         *-- lbl_4c_Label6: "Tamanho :" (Novo)
454:         THIS.AddObject("lbl_4c_Label6", "Label")
455:         WITH THIS.lbl_4c_Label6
456:             .Top       = 174
457:             .Left      = 245
458:             .Width     = 53
459:             .Height    = 15
460:             .AutoSize  = .T.
461:             .FontName  = "Tahoma"
462:             .FontSize  = 8
463:             .BackStyle = 0
464:             .ForeColor = RGB(90, 90, 90)
465:             .Caption   = "Tamanho :"
466:         ENDWITH
467: 
468:         *-- txt_4c_Barras: campo Codigo de Barra (numerico 14 digitos, seleciona ao focar)
469:         THIS.AddObject("txt_4c_Barras", "TextBox")
470:         WITH THIS.txt_4c_Barras
471:             .Top           = 89
472:             .Left          = 145
473:             .Width         = 108
474:             .Height        = 21
475:             .Value         = ""
476:             .Format        = "K"
477:             .InputMask     = "99999999999999"

*-- Linhas 484 a 493:
484:         *-- txt_4c_CorAnt: Cor Antigo (somente leitura - When retorna .F. no original)
485:         THIS.AddObject("txt_4c_CorAnt", "TextBox")
486:         WITH THIS.txt_4c_CorAnt
487:             .Top           = 147
488:             .Left          = 108
489:             .Width         = 73
490:             .Height        = 21
491:             .Value         = ""
492:             .ReadOnly      = .T.
493:             .SpecialEffect = 1

*-- Linhas 499 a 508:
499:         *-- txt_4c_TamAnt: Tamanho Antigo (somente leitura - When retorna .F. no original)
500:         THIS.AddObject("txt_4c_TamAnt", "TextBox")
501:         WITH THIS.txt_4c_TamAnt
502:             .Top           = 171
503:             .Left          = 108
504:             .Width         = 73
505:             .Height        = 21
506:             .Value         = ""
507:             .ReadOnly      = .T.
508:             .SpecialEffect = 1

*-- Linhas 514 a 523:
514:         *-- txt_4c_CorNew: Cor Novo (lookup SigCdCor via F4/ENTER/TAB, max 3 chars)
515:         THIS.AddObject("txt_4c_CorNew", "TextBox")
516:         WITH THIS.txt_4c_CorNew
517:             .Top           = 147
518:             .Left          = 304
519:             .Width         = 73
520:             .Height        = 21
521:             .Value         = ""
522:             .MaxLength     = 3
523:             .SpecialEffect = 1

*-- Linhas 529 a 538:
529:         *-- txt_4c_TamNew: Tamanho Novo (lookup SigCdTam via F4/ENTER/TAB, max 3 chars)
530:         THIS.AddObject("txt_4c_TamNew", "TextBox")
531:         WITH THIS.txt_4c_TamNew
532:             .Top           = 171
533:             .Left          = 304
534:             .Width         = 73
535:             .Height        = 21
536:             .Value         = ""
537:             .MaxLength     = 3
538:             .SpecialEffect = 1

*-- Linhas 816 a 824:
816:             THIS.txt_4c_Barras.Enabled    = par_lHabilitar
817:             THIS.txt_4c_CorNew.Enabled    = par_lHabilitar
818:             THIS.txt_4c_TamNew.Enabled    = par_lHabilitar
819:             THIS.cmd_4c_Processar.Enabled = par_lHabilitar
820:         CATCH TO loc_oErro
821:             MsgErro(loc_oErro.Message, "Erro HabilitarCampos")
822:         ENDTRY
823:     ENDPROC
824: 

*-- Linhas 861 a 873:
861:     PROCEDURE AjustarBotoesPorModo()
862:         LOCAL loc_oErro
863:         TRY
864:             IF PEMSTATUS(THIS, "cmd_4c_Processar", 5)
865:                 THIS.cmd_4c_Processar.Enabled = .T.
866:             ENDIF
867:             IF PEMSTATUS(THIS, "cmd_4c_Cancelar", 5)
868:                 THIS.cmd_4c_Cancelar.Enabled = .T.
869:             ENDIF
870:         CATCH TO loc_oErro
871:             MsgErro(loc_oErro.Message, "Erro AjustarBotoesPorModo")
872:         ENDTRY
873:     ENDPROC


### BO (C:\4c\projeto\app\classes\SIGMDETQBO.prg):
*------------------------------------------------------------------------------
* SIGMDETQBO.prg - Business Object: Mudanca de Cor/Tamanho de Etiqueta
* Herda de BusinessBase
* Tabela principal: SigOpEtq (etiquetas de operacao)
*------------------------------------------------------------------------------
DEFINE CLASS SIGMDETQBO AS BusinessBase

    *-- Codigo de barras da etiqueta (numerico)
    this_nCodBarras  = 0

    *-- Codigo do produto (de CrSigOpEtq.CPros / CrSigMvHst.CPros)
    this_cCPros      = ""

    *-- Codigo da empresa (de CrSigMvHst.Emps)
    this_cEmps       = ""

    *-- Cor e Tamanho ANTIGOS (lidos de CrSigOpEtq.CodCors / .CodTams)
    this_cCorAnt     = ""
    this_cTamAnt     = ""

    *-- Cor e Tamanho NOVOS (informados pelo usuario, lookup SigCdCor / SigCdTam)
    this_cCorNew     = ""
    this_cTamNew     = ""

    *-- Chave de sessao do sistema (de crSigCdPac.SigKeys)
    this_cSigKey     = ""

    *-- Codigo da operacao padrao para mudanca cor/tamanho (de crSigCdPac.DopCorTam)
    this_cDopCorTam  = ""

    *--------------------------------------------------------------------------
    * Init - Configura tabela e campo chave
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        this_cTabela     = "SigOpEtq"
        this_cCampoChave = "CBars"
        DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarParametros - Carrega SigCdPac: SigKeys e DopCorTam
    * Deve ser chamado no InicializarForm do Form antes de qualquer operacao
    *--------------------------------------------------------------------------
    PROCEDURE CarregarParametros()
        LOCAL loc_lSucesso, loc_cSQL, loc_oErro
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "SELECT TOP 1 SigKeys, DopCorTam FROM SigCdPac"
            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Pac") >= 1
                IF RECCOUNT("cursor_4c_Pac") > 0
                    SELECT cursor_4c_Pac
                    THIS.this_cSigKey    = ALLTRIM(cursor_4c_Pac.SigKeys)
                    THIS.this_cDopCorTam = ALLTRIM(cursor_4c_Pac.DopCorTam)
                    IF EMPTY(THIS.this_cDopCorTam)
                        MsgAviso("Opera" + CHR(231) + CHR(227) + "o Padr" + CHR(227) + "o para Mudan" + CHR(231) + "a de Cor/Tamanho n" + CHR(227) + "o definida nos Par" + CHR(226) + "metros do Sistema.", "Aten" + CHR(231) + CHR(227) + "o")
                    ELSE
                        loc_lSucesso = .T.
                    ENDIF
                ELSE
                    MsgErro("Par" + CHR(226) + "metros do sistema n" + CHR(227) + "o encontrados em SigCdPac.", "Erro")
                ENDIF
                IF USED("cursor_4c_Pac")
                    USE IN cursor_4c_Pac
                ENDIF
            ELSE
                MsgErro("Falha ao carregar par" + CHR(226) + "metros do sistema (SigCdPac).", "Erro")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro CarregarParametros")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * BuscarPorBarras - Valida e carrega dados da etiqueta pelo codigo de barras
    * Popula: this_nCodBarras, this_cCPros, this_cEmps, this_cCorAnt, this_cTamAnt
    * Retorna .T. se encontrado e valido
    *--------------------------------------------------------------------------
    PROCEDURE BuscarPorBarras(par_nCodBarras)
        LOCAL loc_lSucesso, loc_lContinuar, loc_nCodBars, loc_cSQL, loc_oErro

        loc_lSucesso   = .F.
        loc_lContinuar = .T.

        TRY
            loc_nCodBars = IIF(VARTYPE(par_nCodBarras) = "C", VAL(par_nCodBarras), par_nCodBarras)

            IF EMPTY(loc_nCodBars)
                loc_lContinuar = .F.
            ENDIF

            *-- Passo 1: Localiza em SigOpEtq + SigOpEta (trata barcode antigo)
            IF loc_lContinuar
                loc_cSQL = "SELECT a.CPros, a.CBars, b.cbars_old " + ;
                           "FROM SigOpEtq a " + ;
                           "LEFT JOIN sigopeta b ON a.cpros = b.cpros AND a.cbars = b.cbars_new " + ;
                           "WHERE (a.CBars = " + TRANSFORM(loc_nCodBars) + ;
                           " OR b.cbars_old = " + TRANSFORM(loc_nCodBars) + ")"
                IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Etiqs") < 1
                    MsgErro("Favor reinicializar o processo!!!", "Falha (CrEtiqs)")
                    loc_lContinuar = .F.
                ENDIF
            ENDIF

            IF loc_lContinuar
                SELECT cursor_4c_Etiqs
                GO TOP
                IF RECCOUNT("cursor_4c_Etiqs") > 0
                    loc_nCodBars = cursor_4c_Etiqs.CBars
                ENDIF
                IF USED("cursor_4c_Etiqs")
                    USE IN cursor_4c_Etiqs
                ENDIF
            ENDIF

            *-- Passo 2: Carrega dados completos da etiqueta
            IF loc_lContinuar
                loc_cSQL = "SELECT * FROM SigOpEtq WHERE CBars = " + TRANSFORM(loc_nCodBars)
                IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_SigOpEtq") < 1
                    MsgErro("Favor reinicializar o processo!!!", "Falha (CrSigOpEtq)")
                    loc_lContinuar = .F.
                ENDIF
            ENDIF

            IF loc_lContinuar
                IF RECCOUNT("cursor_4c_SigOpEtq") = 0
                    MsgAviso("Barra N" + CHR(227) + "o Localizado!", "Aviso")
                    loc_lContinuar = .F.
                ENDIF
            ENDIF

            IF loc_lContinuar
                SELECT cursor_4c_SigOpEtq
                IF EMPTY(cursor_4c_SigOpEtq.Contas) OR EMPTY(cursor_4c_SigOpEtq.Grupos)
                    MsgAviso("Barra j" + CHR(225) + " Vendido!", "Aviso")
                    loc_lContinuar = .F.
                ENDIF
            ENDIF

            *-- Passo 3: Valida conta transitoria no historico
            IF loc_lContinuar
                loc_cSQL = "SELECT TOP 1 Estos FROM SigMvHst WHERE codbarras = " + ;
                           TRANSFORM(loc_nCodBars) + " ORDER BY Seqs DESC"
                IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_MvHstVal") >= 1
                    IF RECCOUNT("cursor_4c_MvHstVal") > 0
                        SELECT cursor_4c_MvHstVal
                        IF INLIST(ALLTRIM(cursor_4c_MvHstVal.Estos), "15000100", "15000150", "15000113")
                            MsgAviso("O Barra Informado Est" + CHR(225) + " Em Uma Conta Transit" + CHR(243) + "ria/" + ;
                                     "Transferencia e N" + CHR(227) + "o Pode Realizar a Altera" + CHR(231) + CHR(227) + "o " + ;
                                     "Dos Dados. Favor Verificar.", "Aten" + CHR(231) + CHR(227) + "o")
                            loc_lContinuar = .F.
                        ENDIF
                    ENDIF
                    IF USED("cursor_4c_MvHstVal")
                        USE IN cursor_4c_MvHstVal
                    ENDIF
                ENDIF
            ENDIF

            *-- Passo 4: Popula propriedades do BO
            IF loc_lContinuar
                SELECT cursor_4c_SigOpEtq
                THIS.this_nCodBarras = loc_nCodBars
                THIS.this_cCPros     = ALLTRIM(cursor_4c_SigOpEtq.CPros)
                THIS.this_cCorAnt    = ALLTRIM(cursor_4c_SigOpEtq.CodCors)
                THIS.this_cTamAnt    = ALLTRIM(cursor_4c_SigOpEtq.CodTams)
                loc_lSucesso = .T.
            ENDIF

            IF USED("cursor_4c_SigOpEtq")
                USE IN cursor_4c_SigOpEtq
            ENDIF
            IF USED("cursor_4c_MvHstVal")
                USE IN cursor_4c_MvHstVal
            ENDIF
            IF USED("cursor_4c_Etiqs")
                USE IN cursor_4c_Etiqs
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro BuscarPorBarras")
            IF USED("cursor_4c_Etiqs")
                USE IN cursor_4c_Etiqs
            ENDIF
            IF USED("cursor_4c_SigOpEtq")
                USE IN cursor_4c_SigOpEtq
            ENDIF
            IF USED("cursor_4c_MvHstVal")
                USE IN cursor_4c_MvHstVal
            ENDIF
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Mapeia cursor SigOpEtq para propriedades do BO
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        IF USED(par_cAliasCursor)
            SELECT (par_cAliasCursor)
            THIS.this_nCodBarras = TratarNulo(CBars,    "N")
            THIS.this_cCPros     = ALLTRIM(TratarNulo(CPros,   "C"))
            THIS.this_cCorAnt    = ALLTRIM(TratarNulo(CodCors, "C"))
            THIS.this_cTamAnt    = ALLTRIM(TratarNulo(CodTams, "C"))
            loc_lSucesso = .T.
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Retorna codigo de barras como string
    *--------------------------------------------------------------------------
    PROCEDURE ObterChavePrimaria()
        RETURN TRANSFORM(THIS.this_nCodBarras)
    ENDPROC

    *--------------------------------------------------------------------------
    * ProcessarAlteracao - Processa mudanca de Cor/Tamanho da etiqueta
    * Pre-condicao: BuscarPorBarras() e CarregarParametros() ja executados
    *               this_cCorNew e this_cTamNew devem estar preenchidos
    * Fluxo: INSERT SigMvCab + INSERT SigMvHst(S) + INSERT SigMvHst(E) + UPDATE SigOpEtq
    *--------------------------------------------------------------------------
    PROCEDURE ProcessarAlteracao()
        LOCAL loc_lSucesso, loc_lTransacao, loc_lContinuar
        LOCAL loc_nCodBarras, loc_cCorOld, loc_cTamOld, loc_cCorNew, loc_cTamNew
        LOCAL loc_cProd, loc_cEmps, loc_nTipoEstos
        LOCAL loc_cIds, loc_nPSeq, loc_nNume
        LOCAL loc_dtData, loc_dData, loc_cSQL, loc_cMsg, loc_oErro
        *-- Campos capturados do historico anterior
        LOCAL loc_cUnits, loc_cMoedas, loc_nTotas, loc_dDataTrans
        LOCAL loc_cEmpos, loc_nCodBarrasHist, loc_nQtds, loc_cGrupos
        LOCAL loc_cEstos, loc_nRecalMeds, loc_cObs, loc_nPesos
        LOCAL loc_cEmpGruEsts, loc_cOriDopNums, loc_nBcIpis, loc_dDtAudits

        loc_lSucesso   = .F.
        loc_lTransacao = .F.
        loc_lContinuar = .T.

        TRY
            loc_nCodBarras = THIS.this_nCodBarras
            loc_cCorOld    = ALLTRIM(THIS.this_cCorAnt)
            loc_cTamOld    = ALLTRIM(THIS.this_cTamAnt)
            loc_cCorNew    = ALLTRIM(THIS.this_cCorNew)
            loc_cTamNew    = ALLTRIM(THIS.this_cTamNew)
            loc_dtData     = DATETIME()
            loc_dData      = DATE()

            *-- Passo 1: Carrega historico mais recente para obter campos de cabecalho
            IF loc_lContinuar
                loc_cSQL = "SELECT TOP 1 Emps, CPros, Units, Moedas, Totas, DataTrans, Empos, " + ;
                           "CodBarras, Qtds, Grupos, Estos, RecalMeds, Obs, Pesos, " + ;
                           "DtAudits, EmpGruEsts, OriDopNums, BcIpis " + ;
                           "FROM SigMvHst WHERE codbarras = " + TRANSFORM(loc_nCodBarras) + ;
                           " ORDER BY Seqs DESC"
                IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_MvHstProc") < 1
                    MsgErro("Favor reinicializar o processo!!!", "Falha (SigMvHst)")
                    loc_lContinuar = .F.
                ENDIF
            ENDIF

            IF loc_lContinuar AND RECCOUNT("cursor_4c_MvHstProc") = 0
                MsgErro("Hist" + CHR(243) + "rico n" + CHR(227) + "o encontrado para o barras.", "Erro")
                loc_lContinuar = .F.
            ENDIF

            IF loc_lContinuar
                SELECT cursor_4c_MvHstProc
                loc_cEmps          = ALLTRIM(cursor_4c_MvHstProc.Emps)
                loc_cProd          = ALLTRIM(cursor_4c_MvHstProc.CPros)
                loc_cUnits         = ALLTRIM(cursor_4c_MvHstProc.Units)
                loc_cMoedas        = ALLTRIM(cursor_4c_MvHstProc.Moedas)
                loc_nTotas         = cursor_4c_MvHstProc.Totas
                loc_dDataTrans     = cursor_4c_MvHstProc.DataTrans
                loc_cEmpos         = ALLTRIM(cursor_4c_MvHstProc.Empos)
                loc_nCodBarrasHist = cursor_4c_MvHstProc.CodBarras
                loc_nQtds          = cursor_4c_MvHstProc.Qtds
                loc_cGrupos        = ALLTRIM(cursor_4c_MvHstProc.Grupos)
                loc_cEstos         = ALLTRIM(cursor_4c_MvHstProc.Estos)
                loc_nRecalMeds     = IIF(VARTYPE(cursor_4c_MvHstProc.RecalMeds) = "L", ;
                                         IIF(cursor_4c_MvHstProc.RecalMeds, 1, 0), ;
                                         cursor_4c_MvHstProc.RecalMeds)
                loc_cObs           = ALLTRIM(cursor_4c_MvHstProc.Obs)
                loc_nPesos         = cursor_4c_MvHstProc.Pesos
                loc_cEmpGruEsts    = ALLTRIM(cursor_4c_MvHstProc.EmpGruEsts)
                loc_cOriDopNums    = ALLTRIM(cursor_4c_MvHstProc.OriDopNums)
                loc_nBcIpis        = cursor_4c_MvHstProc.BcIpis
                loc_dDtAudits      = cursor_4c_MvHstProc.DtAudits
                IF USED("cursor_4c_MvHstProc")
                    USE IN cursor_4c_MvHstProc
                ENDIF
            ENDIF

            *-- Passo 2: Valida TipoEstos do grupo do produto
            IF loc_lContinuar
                loc_cSQL = "SELECT b.tipoestos " + ;
                           "FROM sigcdpro a " + ;
                           "JOIN sigcdgrp b ON a.cgrus = b.cgrus " + ;
                           "WHERE a.cpros = " + EscaparSQL(loc_cProd)
                IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_GruposProc") >= 1 AND RECCOUNT("cursor_4c_GruposProc") > 0
                    SELECT cursor_4c_GruposProc
                    loc_nTipoEstos = cursor_4c_GruposProc.TipoEstos
                    IF INLIST(loc_nTipoEstos, 2, 4) AND EMPTY(loc_cCorNew)
                        MsgAviso("Favor Informar a Cor.", "Aten" + CHR(231) + CHR(227) + "o")
                        loc_lContinuar = .F.
                    ENDIF
                    IF loc_lContinuar AND INLIST(loc_nTipoEstos, 3, 4) AND EMPTY(loc_cTamNew)
                        MsgAviso("Favor Informar o Tamanho.", "Aten" + CHR(231) + CHR(227) + "o")
                        loc_lContinuar = .F.
                    ENDIF
                    IF loc_lContinuar AND loc_nTipoEstos = 3 AND !EMPTY(loc_cCorNew)
                        loc_cCorNew = ""
                    ENDIF
                    IF loc_lContinuar AND loc_nTipoEstos = 2 AND !EMPTY(loc_cTamNew)
                        loc_cTamNew = ""
                    ENDIF
                ENDIF
                IF USED("cursor_4c_GruposProc")
                    USE IN cursor_4c_GruposProc
                ENDIF
            ENDIF

            *-- Passo 3: Gera chaves unicas
            IF loc_lContinuar
                loc_nNume = fGerUniqueKey(ALLTRIM(THIS.this_cDopCorTam) + loc_cEmps)
                loc_cIds  = DTOS(loc_dData) + "S" + ;
                            TRANSFORM(fGerUniqueKey(DTOS(loc_dData)), "@L 999999") + ;
                            ALLTRIM(THIS.this_cSigKey)
                loc_nPSeq = fGerUniqueKey("HISTBAR")
            ENDIF

            *-- Passo 4: Inicia transacao
            IF loc_lContinuar
                IF SQLEXEC(gnConnHandle, "BEGIN TRANSACTION") >= 1
                    loc_lTransacao = .T.
                ELSE
                    MsgErro("Falha ao iniciar transa" + CHR(231) + CHR(227) + "o.", "Erro")
                    loc_lContinuar = .F.
                ENDIF
            ENDIF

            *-- Passo 5: INSERT em SigMvCab
            IF loc_lContinuar
                loc_cSQL = "INSERT INTO SigMvCab " + ;
                           "(Emps, Dopes, Numes, Usuars, Datars, DataS, Mascnum, CidChaves, EmpDopNums) " + ;
                           "VALUES (" + ;
                           EscaparSQL(loc_cEmps) + ", " + ;
                           EscaparSQL(ALLTRIM(THIS.this_cDopCorTam)) + ", " + ;
                           FormatarNumeroSQL(loc_nNume) + ", " + ;
                           EscaparSQL(gc_4c_UsuarioLogado) + ", " + ;
                           THIS.FormatarDatetimeSQL(loc_dtData) + ", " + ;
                           "'" + SUBSTR(DTOS(loc_dData), 1, 4) + "-" + ;
                                 SUBSTR(DTOS(loc_dData), 5, 2) + "-" + ;
                                 SUBSTR(DTOS(loc_dData), 7, 2) + "', " + ;
                           EscaparSQL(ALLTRIM(fGerMascara(loc_nNume))) + ", " + ;
                           EscaparSQL(fUniqueIds()) + ", " + ;
                           EscaparSQL(loc_cEmps + ALLTRIM(THIS.this_cDopCorTam) + STR(loc_nNume, 6)) + ;
                           ")"
                IF SQLEXEC(gnConnHandle, loc_cSQL) < 1
                    MsgErro("Favor reinicializar o processo!!!", "Falha (SigMvCab)")
                    loc_lContinuar = .F.
                ENDIF
            ENDIF

            *-- Passo 6: INSERT SigMvHst Saida (Opers='S', CodCors/CodTams ANTIGOS)
            IF loc_lContinuar
                loc_cSQL = "INSERT INTO SigMvHst " + ;
                           "(Usuars, DataRs, Emps, Opers, Dopes, Numes, DataS, DtAudits, CPros, Units, " + ;
                           "Moedas, Totas, DataTrans, Empos, CodBarras, Qtds, Grupos, " + ;
                           "Estos, RecalMeds, Obs, CodCors, CodTams, Pesos, CidChaves, EmpDopNums, " + ;
                           "EmpGruEsts, OriDopNums, BcIpis, Seqs) " + ;
                           "VALUES (" + ;
                           EscaparSQL(gc_4c_UsuarioLogado) + ", " + ;
                           THIS.FormatarDatetimeSQL(loc_dtData) + ", " + ;
                           EscaparSQL(loc_cEmps) + ", " + ;
                           "'S', " + ;
                           EscaparSQL(ALLTRIM(THIS.this_cDopCorTam)) + ", " + ;
                           FormatarNumeroSQL(loc_nNume) + ", " + ;
                           "'" + SUBSTR(DTOS(loc_dData), 1, 4) + "-" + ;
                                 SUBSTR(DTOS(loc_dData), 5, 2) + "-" + ;
                                 SUBSTR(DTOS(loc_dData), 7, 2) + "', " + ;
                           FormatarDataSQL(loc_dDtAudits) + ", " + ;
                           EscaparSQL(loc_cProd) + ", " + ;
                           EscaparSQL(loc_cUnits) + ", " + ;
                           EscaparSQL(loc_cMoedas) + ", " + ;
                           FormatarNumeroSQL(loc_nTotas) + ", " + ;
                           FormatarDataSQL(loc_dDataTrans) + ", " + ;
                           EscaparSQL(loc_cEmpos) + ", " + ;
                           FormatarNumeroSQL(loc_nCodBarrasHist) + ", " + ;
                           FormatarNumeroSQL(loc_nQtds) + ", " + ;
                           EscaparSQL(loc_cGrupos) + ", " + ;
                           EscaparSQL(loc_cEstos) + ", " + ;
                           FormatarNumeroSQL(loc_nRecalMeds) + ", " + ;
                           EscaparSQL(loc_cObs) + ", " + ;
                           EscaparSQL(loc_cCorOld) + ", " + ;
                           EscaparSQL(loc_cTamOld) + ", " + ;
                           FormatarNumeroSQL(loc_nPesos) + ", " + ;
                           EscaparSQL(loc_cIds) + ", " + ;
                           EscaparSQL(loc_cEmps + ALLTRIM(THIS.this_cDopCorTam) + STR(loc_nNume, 6)) + ", " + ;
                           EscaparSQL(loc_cEmpGruEsts) + ", " + ;
                           EscaparSQL(loc_cOriDopNums) + ", " + ;
                           FormatarNumeroSQL(loc_nBcIpis) + ", " + ;
                           FormatarNumeroSQL(loc_nPSeq) + ;
                           ")"
                IF SQLEXEC(gnConnHandle, loc_cSQL) < 1
                    MsgErro("Favor reinicializar o processo!!!", "Falha Hist Sa" + CHR(237) + "da")
                    loc_lContinuar = .F.
                ENDIF
            ENDIF

            *-- Passo 7: INSERT SigMvHst Entrada (Opers='E', CodCors/CodTams NOVOS)
            IF loc_lContinuar
                loc_cIds  = DTOS(loc_dData) + "E" + ;
                            TRANSFORM(fGerUniqueKey(DTOS(loc_dData)), "@L 999999") + ;
                            ALLTRIM(THIS.this_cSigKey)
                loc_nPSeq = fGerUniqueKey("HISTBAR")

                loc_cSQL = "INSERT INTO SigMvHst " + ;
                           "(Usuars, DataRs, Emps, Opers, Dopes, Numes, DataS, DtAudits, CPros, Units, " + ;
                           "Moedas, Totas, DataTrans, Empos, CodBarras, Qtds, Grupos, " + ;
                           "Estos, RecalMeds, Obs, CodCors, CodTams, Pesos, CidChaves, " + ;
                           "EmpDopNums, EmpGruEsts, OriDopNums, BcIpis, Seqs) " + ;
                           "VALUES (" + ;
                           EscaparSQL(gc_4c_UsuarioLogado) + ", " + ;
                           THIS.FormatarDatetimeSQL(loc_dtData) + ", " + ;
                           EscaparSQL(loc_cEmps) + ", " + ;
                           "'E', " + ;
                           EscaparSQL(ALLTRIM(THIS.this_cDopCorTam)) + ", " + ;
                           FormatarNumeroSQL(loc_nNume) + ", " + ;
                           "'" + SUBSTR(DTOS(loc_dData), 1, 4) + "-" + ;
                                 SUBSTR(DTOS(loc_dData), 5, 2) + "-" + ;
                                 SUBSTR(DTOS(loc_dData), 7, 2) + "', " + ;
                           FormatarDataSQL(loc_dDtAudits) + ", " + ;
                           EscaparSQL(loc_cProd) + ", " + ;
                           EscaparSQL(loc_cUnits) + ", " + ;
                           EscaparSQL(loc_cMoedas) + ", " + ;
                           FormatarNumeroSQL(loc_nTotas) + ", " + ;
                           FormatarDataSQL(loc_dDataTrans) + ", " + ;
                           EscaparSQL(loc_cEmpos) + ", " + ;
                           FormatarNumeroSQL(loc_nCodBarrasHist) + ", " + ;
                           FormatarNumeroSQL(loc_nQtds) + ", " + ;
                           EscaparSQL(loc_cGrupos) + ", " + ;
                           EscaparSQL(loc_cEstos) + ", " + ;
                           FormatarNumeroSQL(loc_nRecalMeds) + ", " + ;
                           EscaparSQL(loc_cObs) + ", " + ;
                           EscaparSQL(loc_cCorNew) + ", " + ;
                           EscaparSQL(loc_cTamNew) + ", " + ;
                           FormatarNumeroSQL(loc_nPesos) + ", " + ;
                           EscaparSQL(loc_cIds) + ", " + ;
                           EscaparSQL(loc_cEmps + ALLTRIM(THIS.this_cDopCorTam) + STR(loc_nNume, 6)) + ", " + ;
                           EscaparSQL(loc_cEmpGruEsts) + ", " + ;
                           EscaparSQL(loc_cOriDopNums) + ", " + ;
                           FormatarNumeroSQL(loc_nBcIpis) + ", " + ;
                           FormatarNumeroSQL(loc_nPSeq) + ;
                           ")"
                IF SQLEXEC(gnConnHandle, loc_cSQL) < 1
                    MsgErro("Favor reinicializar o processo!!!", "Falha Hist Entrada")
                    loc_lContinuar = .F.
                ENDIF
            ENDIF

            *-- Passo 8: UPDATE SigOpEtq com novos CodCors/CodTams
            IF loc_lContinuar
                loc_cSQL = "UPDATE SigOpEtq SET " + ;
                           "CodCors = " + EscaparSQL(loc_cCorNew) + ", " + ;
                           "CodTams = " + EscaparSQL(loc_cTamNew) + ;
                           " WHERE CBars = " + TRANSFORM(loc_nCodBarras)
                IF SQLEXEC(gnConnHandle, loc_cSQL) < 1
                    MsgErro("Favor reinicializar o processo!!!", "Falha (SigOpEtq)")
                    loc_lContinuar = .F.
                ENDIF
            ENDIF

            *-- Passo 9: Recalculo de estoque via SqlCalcP2 e fRecalculaC
            IF loc_lContinuar
                CREATE CURSOR cursor_4c_LocalHis ;
                    (Emps C(10), Grupos C(10), Estos C(20), CPros C(15), DataS D, CodCors C(6), CodTams C(6))
                INSERT INTO cursor_4c_LocalHis VALUES ;
                    (loc_cEmps, loc_cGrupos, loc_cEstos, loc_cProd, loc_dData, loc_cCorOld, loc_cTamOld)
                INSERT INTO cursor_4c_LocalHis VALUES ;
                    (loc_cEmps, loc_cGrupos, loc_cEstos, loc_cProd, loc_dData, loc_cCorNew, loc_cTamNew)
                SELECT cursor_4c_LocalHis
                GO TOP
                SCAN
                    =SqlCalcP2(cursor_4c_LocalHis.Emps, cursor_4c_LocalHis.Grupos, ;
                               cursor_4c_LocalHis.Estos, cursor_4c_LocalHis.CPros, ;
                               cursor_4c_LocalHis.DataS, cursor_4c_LocalHis.CodCors, ;
                               cursor_4c_LocalHis.CodTams, gnConnHandle)
                    =SqlCalcP2(.T., gnConnHandle, .T.)
                    =fRecalculaC(cursor_4c_LocalHis.Emps, cursor_4c_LocalHis.CPros, ;
                                 cursor_4c_LocalHis.DataS, gnConnHandle)
                    SELECT cursor_4c_LocalHis
                ENDSCAN
                IF USED("cursor_4c_LocalHis")
                    USE IN cursor_4c_LocalHis
                ENDIF
            ENDIF

            *-- Passo 10: Commit ou Rollback
            IF loc_lContinuar
                IF SQLEXEC(gnConnHandle, "COMMIT") >= 1
                    loc_lTransacao = .F.
                    loc_lSucesso   = .T.
                ELSE
                    MsgErro("Falha ao confirmar transa" + CHR(231) + CHR(227) + "o.", "Erro")
                    SQLEXEC(gnConnHandle, "ROLLBACK")
                    loc_lTransacao = .F.
                ENDIF
            ELSE
                IF loc_lTransacao
                    SQLEXEC(gnConnHandle, "ROLLBACK")
                    loc_lTransacao = .F.
                ENDIF
            ENDIF

            *-- Passo 11: Log de auditoria (somente apos sucesso)
            IF loc_lSucesso
                loc_cMsg = "Barra : " + TRANSFORM(loc_nCodBarras) + ;
                           " *** Anterior(C:" + loc_cCorOld + ",T:" + loc_cTamOld + ;
                           ") Novo(C:" + loc_cCorNew + ",T:" + loc_cTamNew + ") *** "
                =fGravarLog("T", "SIGMDETQ", ALLTRIM(THIS.this_cDopCorTam), loc_cMsg, gc_4c_UsuarioLogado)
                THIS.RegistrarAuditoria("ALTERAR")
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ProcessarAltera" + CHR(231) + CHR(227) + "o")
            IF loc_lTransacao
                SQLEXEC(gnConnHandle, "ROLLBACK")
            ENDIF
            IF USED("cursor_4c_MvHstProc")
                USE IN cursor_4c_MvHstProc
            ENDIF
            IF USED("cursor_4c_GruposProc")
                USE IN cursor_4c_GruposProc
            ENDIF
            IF USED("cursor_4c_LocalHis")
                USE IN cursor_4c_LocalHis
            ENDIF
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir - Operacao CRUD (form OPERACIONAL): delega para ProcessarAlteracao
    * Form SIGMDETQ nao possui insert tradicional. A operacao unica eh a
    * mudanca de cor/tamanho da etiqueta, que gera INSERT em SigMvCab/SigMvHst
    * e UPDATE em SigOpEtq atomicamente dentro de ProcessarAlteracao().
    *--------------------------------------------------------------------------
    PROCEDURE Inserir()
        RETURN THIS.ProcessarAlteracao()
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - Operacao CRUD (form OPERACIONAL): delega para ProcessarAlteracao
    * A "atualizacao" da etiqueta (troca de cor/tamanho) segue o mesmo fluxo
    * transacional de ProcessarAlteracao (UPDATE SigOpEtq + historico).
    *--------------------------------------------------------------------------
    PROCEDURE Atualizar()
        RETURN THIS.ProcessarAlteracao()
    ENDPROC

    *--------------------------------------------------------------------------
    * RegistrarAuditoria - Registra operacao em LogAuditoria
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE RegistrarAuditoria(par_cOperacao)
        LOCAL loc_cSQL, loc_oErro

        TRY
            loc_cSQL = "INSERT INTO LogAuditoria (Tabela, Operacao, ChavePrimaria, Usuario, DataHora) " + ;
                       "VALUES (" + ;
                       EscaparSQL("SigOpEtq") + ", " + ;
                       EscaparSQL(par_cOperacao) + ", " + ;
                       EscaparSQL(TRANSFORM(THIS.this_nCodBarras)) + ", " + ;
                       EscaparSQL(gc_4c_UsuarioLogado) + ", " + ;
                       THIS.FormatarDatetimeSQL(DATETIME()) + ;
                       ")"
            SQLEXEC(gnConnHandle, loc_cSQL)
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro RegistrarAuditoria")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * FormatarDatetimeSQL - Converte DATETIME VFP para CONVERT SQL Server
    * Retorna: CONVERT(DATETIME, 'AAAA-MM-DD HH:MM:SS', 120)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE FormatarDatetimeSQL(par_dtVal)
        LOCAL loc_cDate, loc_cTime
        loc_cDate = PADL(TRANSFORM(YEAR(par_dtVal)),   4, "0") + "-" + ;
                    PADL(TRANSFORM(MONTH(par_dtVal)),  2, "0") + "-" + ;
                    PADL(TRANSFORM(DAY(par_dtVal)),    2, "0")
        loc_cTime = PADL(TRANSFORM(HOUR(par_dtVal)),   2, "0") + ":" + ;
                    PADL(TRANSFORM(MINUTE(par_dtVal)), 2, "0") + ":" + ;
                    PADL(TRANSFORM(SEC(par_dtVal)),    2, "0")
        RETURN "CONVERT(DATETIME, '" + loc_cDate + " " + loc_cTime + "', 120)"
    ENDPROC

ENDDEFINE


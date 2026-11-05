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
- [FONTNAME-ERRADO] FontName 'Comic Sans MS' numa tela cujo dump legado NAO declara essa fonte - trocar por 'Tahoma' SO nas linhas apontadas, nunca "todas as ocorrencias" (Erro178: o legado do SIGCDPRO declara Comic Sans MS nos 8 botoes de navegacao, e a troca em massa virou regressao de PILAR 1)

## REGRAS OBRIGATORIAS
- Corrigir APENAS os problemas listados, NAO alterar logica de negocio
- NAO remover campos, funcionalidades ou lookups
- **PROIBIDO alterar propriedades visuais** (Width, Height, Top, Left, BackColor, ForeColor, FontName, FontSize) EXCETO se o problema eh especificamente de ALINHAMENTO
- NUNCA juntar linhas com `;` numa linha unica
- Usar Write tool para salvar os arquivos corrigidos nos mesmos caminhos


## CODIGO ATUAL DOS ARQUIVOS

### FORM (C:\4c\projeto\app\forms\relatorios\FormSIGOPFLU.prg) - TRECHOS RELEVANTES PARA PASS VISUAL (1269 linhas total):

*-- Linhas 51 a 59:
51:         loc_lSucesso   = .F.
52:         loc_lContinuar = .T.
53:         TRY
54:             THIS.Caption = "Impress" + CHR(227) + "o de FollowUp"
55: 
56:             IF TYPE("gc_4c_CaminhoIcones") = "U"
57:                 gc_4c_CaminhoIcones = ""
58:             ENDIF
59:             IF TYPE("gc_4c_CaminhoReports") = "U"

*-- Linhas 93 a 131:
93:     PROTECTED PROCEDURE ConfigurarCabecalho()
94:         THIS.AddObject("cnt_4c_Cabecalho", "Container")
95:         WITH THIS.cnt_4c_Cabecalho
96:             .Top         = 0
97:             .Left        = 0
98:             .Width       = THIS.Width
99:             .Height      = 80
100:             .BackStyle   = 1
101:             .BackColor   = RGB(100, 100, 100)
102:             .BorderWidth = 0
103:             .Visible     = .T.
104: 
105:             .AddObject("lbl_4c_Sombra", "Label")
106:             WITH .lbl_4c_Sombra
107:                 .Top       = 22
108:                 .Left      = 22
109:                 .Width     = THIS.Width
110:                 .Height    = 30
111:                 .Caption   = "Impress" + CHR(227) + "o de FollowUp"
112:                 .FontName  = "Tahoma"
113:                 .FontSize  = 14
114:                 .FontBold  = .T.
115:                 .ForeColor = RGB(0, 0, 0)
116:                 .BackStyle = 0
117:                 .Visible   = .T.
118:             ENDWITH
119: 
120:             .AddObject("lbl_4c_Titulo", "Label")
121:             WITH .lbl_4c_Titulo
122:                 .Top       = 20
123:                 .Left      = 20
124:                 .Width     = THIS.Width
125:                 .Height    = 30
126:                 .Caption   = "Impress" + CHR(227) + "o de FollowUp"
127:                 .FontName  = "Tahoma"
128:                 .FontSize  = 14
129:                 .FontBold  = .T.
130:                 .ForeColor = RGB(255, 255, 255)
131:                 .BackStyle = 0

*-- Linhas 142 a 175:
142:     *
143:     *   Geometria transcrita do SCX legado (os overrides do SCX PRECEDEM os
144:     *   defaults do framework.vcx):
145:     *     btnReport.Top=-2 Left=495 Width=310 Height=85
146:     *     Visualiza/Imprime/DocExcel/Sair: Top=5 Width=75 Height=75
147:     *     Lefts = 5 / 80 / 155 / 230  (230+75 = 305 <= 310, nenhum botao corta)
148:     *--------------------------------------------------------------------------
149:     PROTECTED PROCEDURE ConfigurarBotoes()
150:         THIS.AddObject("cmg_4c_Botoes", "CommandGroup")
151:         WITH THIS.cmg_4c_Botoes
152:             .Top           = -2
153:             .Left          = 495
154:             .Width         = 310
155:             .Height        = 85
156:             .ButtonCount   = 4
157:             .BackStyle     = 0
158:             .BorderStyle   = 0
159:             .BorderColor   = RGB(136, 189, 188)
160:             .SpecialEffect = 1
161:             .Themes        = .F.
162:             .Visible       = .T.
163: 
164:             *-- Botao 1: Visualizar (preview em tela)
165:             WITH .Buttons(1)
166:                 .Top             = 5
167:                 .Left            = 5
168:                 .Width           = 75
169:                 .Height          = 75
170:                 .Caption         = "\<Visualizar"
171:                 .FontName        = "Comic Sans MS"
172:                 .FontSize        = 8
173:                 .FontBold        = .T.
174:                 .FontItalic      = .T.
175:                 .BackColor       = RGB(255, 255, 255)

*-- Linhas 186 a 198:
186: 
187:             *-- Botao 2: Imprimir (impressora com dialogo)
188:             WITH .Buttons(2)
189:                 .Top             = 5
190:                 .Left            = 80
191:                 .Width           = 75
192:                 .Height          = 75
193:                 .Caption         = "\<Imprimir"
194:                 .FontName        = "Comic Sans MS"
195:                 .FontSize        = 8
196:                 .FontBold        = .T.
197:                 .FontItalic      = .T.
198:                 .BackColor       = RGB(255, 255, 255)

*-- Linhas 208 a 220:
208: 
209:             *-- Botao 3: Arquivos Email (geracao de arquivo para envio)
210:             WITH .Buttons(3)
211:                 .Top             = 5
212:                 .Left            = 155
213:                 .Width           = 75
214:                 .Height          = 75
215:                 .Caption         = "\<Arquivos Email"
216:                 .WordWrap        = .T.
217:                 .FontName        = "Comic Sans MS"
218:                 .FontSize        = 8
219:                 .FontBold        = .T.
220:                 .FontItalic      = .T.

*-- Linhas 231 a 243:
231: 
232:             *-- Botao 4: Encerrar (Cancel = .T. para o ESC fechar o form)
233:             WITH .Buttons(4)
234:                 .Top             = 5
235:                 .Left            = 230
236:                 .Width           = 75
237:                 .Height          = 75
238:                 .Caption         = "\<Encerrar"
239:                 .WordWrap        = .T.
240:                 .Cancel          = .T.
241:                 .FontName        = "Comic Sans MS"
242:                 .FontSize        = 8
243:                 .FontBold        = .T.

*-- Linhas 285 a 299:
285:         *-- PageCount OBRIGATORIAMENTE antes de acessar Page1
286:         loc_oPgf.PageCount = 1
287: 
288:         loc_oPgf.Top    = 85
289:         loc_oPgf.Left   = -1
290:         loc_oPgf.Width  = THIS.Width + 2
291:         loc_oPgf.Height = THIS.Height - 85
292:         loc_oPgf.Tabs   = .F.
293: 
294:         loc_oPgf.Page1.Caption   = "Filtros"
295:         loc_oPgf.Page1.FontName  = "Tahoma"
296:         loc_oPgf.Page1.FontSize  = 8
297:         loc_oPgf.Page1.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
298:         loc_oPgf.Page1.BackColor = RGB(255, 255, 255)
299:         loc_oPgf.Page1.ForeColor = RGB(90, 90, 90)

*-- Linhas 342 a 354:
342:         *----------------------------------------------------------------------
343:         *-- Linha 1: Periodo (Data Inicial ate Data Final)
344:         *----------------------------------------------------------------------
345:         loc_oPagina.AddObject("lbl_4c_Label2", "Label")
346:         WITH loc_oPagina.lbl_4c_Label2
347:             .Caption   = "Per" + CHR(237) + "odo :"
348:             .Left      = 195
349:             .Top       = 16
350:             .Width     = 45
351:             .Height    = 15
352:             .AutoSize  = .F.
353:             .Alignment = 0
354:             .FontName  = "Tahoma"

*-- Linhas 363 a 372:
363:         WITH loc_oPagina.txt_4c_DtInicial
364:             *-- Legado: ThisForm.GetDtInicial.Value = Date() no Init
365:             .Value             = DATE()
366:             .Left              = 242
367:             .Top               = 13
368:             .Width             = 80
369:             .Height            = 23
370:             .Alignment         = 3
371:             .FontName          = "Tahoma"
372:             .FontSize          = 8

*-- Linhas 379 a 392:
379:             .Visible           = .T.
380:         ENDWITH
381: 
382:         loc_oPagina.AddObject("lbl_4c_Label3", "Label")
383:         WITH loc_oPagina.lbl_4c_Label3
384:             *-- Separador do periodo: a-grave (CHR(224)), como no SCX
385:             .Caption   = CHR(224)
386:             .Left      = 328
387:             .Top       = 16
388:             .Width     = 8
389:             .Height    = 15
390:             .AutoSize  = .F.
391:             .Alignment = 0
392:             .FontName  = "Tahoma"

*-- Linhas 401 a 410:
401:         WITH loc_oPagina.txt_4c_DtFinal
402:             *-- Legado: ThisForm.GetDtFinal.Value = Date() no Init
403:             .Value             = DATE()
404:             .Left              = 341
405:             .Top               = 13
406:             .Width             = 80
407:             .Height            = 23
408:             .Alignment         = 3
409:             .FontName          = "Tahoma"
410:             .FontSize          = 8

*-- Linhas 420 a 432:
420:         *----------------------------------------------------------------------
421:         *-- Linha 2: Grupo contabil (SigCdGcr.Codigos + SigCdGcr.Descrs)
422:         *----------------------------------------------------------------------
423:         loc_oPagina.AddObject("lbl_4c_Label1", "Label")
424:         WITH loc_oPagina.lbl_4c_Label1
425:             .Caption   = "Grupo :"
426:             .Left      = 202
427:             .Top       = 43
428:             .Width     = 38
429:             .Height    = 15
430:             .AutoSize  = .F.
431:             .Alignment = 0
432:             .FontName  = "Tahoma"

*-- Linhas 440 a 449:
440:         loc_oPagina.AddObject("txt_4c_Grupo", "TextBox")
441:         WITH loc_oPagina.txt_4c_Grupo
442:             .Value             = ""
443:             .Left              = 242
444:             .Top               = 39
445:             .Width             = 80
446:             .Height            = 25
447:             .MaxLength         = 10
448:             .Format            = "K"
449:             .FontName          = "Tahoma"

*-- Linhas 459 a 468:
459:         loc_oPagina.AddObject("txt_4c_DGrupo", "TextBox")
460:         WITH loc_oPagina.txt_4c_DGrupo
461:             .Value             = ""
462:             .Left              = 324
463:             .Top               = 39
464:             .Width             = 150
465:             .Height            = 25
466:             .MaxLength         = 20
467:             .Format            = "K"
468:             .FontName          = "Tahoma"

*-- Linhas 501 a 513:
501:         *----------------------------------------------------------------------
502:         *-- Linha 3: Conta (SigCdCli.IClis + SigCdCli.RClis)
503:         *----------------------------------------------------------------------
504:         loc_oPagina.AddObject("lbl_4c_Lbl_estoque", "Label")
505:         WITH loc_oPagina.lbl_4c_Lbl_estoque
506:             .Caption   = "Conta :"
507:             .Left      = 202
508:             .Top       = 70
509:             .Width     = 38
510:             .Height    = 15
511:             .AutoSize  = .F.
512:             .Alignment = 0
513:             .FontName  = "Tahoma"

*-- Linhas 521 a 530:
521:         loc_oPagina.AddObject("txt_4c_Conta", "TextBox")
522:         WITH loc_oPagina.txt_4c_Conta
523:             .Value             = ""
524:             .Left              = 242
525:             .Top               = 66
526:             .Width             = 80
527:             .Height            = 25
528:             .MaxLength         = 10
529:             .Format            = "K"
530:             .Alignment         = 0

*-- Linhas 545 a 554:
545:         loc_oPagina.AddObject("txt_4c_DConta", "TextBox")
546:         WITH loc_oPagina.txt_4c_DConta
547:             .Value             = ""
548:             .Left              = 324
549:             .Top               = 66
550:             .Width             = 290
551:             .Height            = 25
552:             .MaxLength         = 40
553:             .Format            = "K"
554:             .FontName          = "Tahoma"

*-- Linhas 562 a 578:
562: 
563:         *----------------------------------------------------------------------
564:         *-- Linha 4: Opcao de impressao (Data / Hora da ocorrencia)
565:         *   CheckBox.Value eh NUMERICO (0/1). AutoSize entra .F. (eh no-op em
566:         *   CheckBox criado por AddObject) com Width/Height do SCX.
567:         *----------------------------------------------------------------------
568:         loc_oPagina.AddObject("chk_4c_ChkData", "CheckBox")
569:         WITH loc_oPagina.chk_4c_ChkData
570:             .Caption       = "Imprime Data / Hora da Ocorr" + CHR(234) + "ncia"
571:             .Value         = 0
572:             .Left          = 242
573:             .Top           = 106
574:             .Width         = 185
575:             .Height        = 15
576:             .AutoSize      = .F.
577:             .Alignment     = 0
578:             .BackStyle     = 0

*-- Linhas 1213 a 1221:
1213:     *   form. Usado para restaurar a tela apos reprocessamento ou preset
1214:     *   (ex.: reabrir com o mesmo Grupo/Conta da ultima execucao).
1215:     *   chk_4c_ChkData.Value eh NUMERICO (0/1) e this_lImpData eh LOGICO no
1216:     *   BO - a conversao IIF eh obrigatoria (regra #CheckBoxValueLogicalProp).
1217:     *   PROTECTED pelo mesmo motivo de FormParaBO (herdado de FormBase).
1218:     *--------------------------------------------------------------------------
1219:     PROTECTED PROCEDURE BOParaForm()
1220:         LOCAL loc_oPagina, loc_lProsseguir, loc_oErro
1221:         loc_lProsseguir = .T.


### BO (C:\4c\projeto\app\classes\SIGOPFLUBO.prg):
*==============================================================================
* SIGOPFLUBO.PRG
* Business Object para Relatorio de FollowUp de Clientes/Contas
*
* Herda de: RelatorioBase
* Form: FormSIGOPFLU.prg
* Relatorio original: SIGOPFLU.SCX / SigOpFlu.FRX
*==============================================================================

DEFINE CLASS SIGOPFLUBO AS RelatorioBase

    *-- Identificacao do relatorio
    this_cArquivoRelatorio  = "SigOpFlu"
    this_cTituloRelatorio   = ""

    *-- Filtros de parametro do formulario (Periodo)
    this_dDtInicial         = {}
    this_dDtFinal           = {}

    *-- Filtro de Grupo (SigCdGcr - cgrus/descrs)
    this_cGrupo             = ""
    this_cDGrupo            = ""

    *-- Filtro de Conta/Cliente (SigCdCli - iclis/rclis)
    this_cConta             = ""
    this_cDConta            = ""

    *-- Opcao de impressao (ChkData do legado)
    this_lImpData           = .F.

    *-- Cabecalho do relatorio (Empresa/Titulo/SubTitulo/ImpData)
    this_cEmpresa           = ""

    *-- Cursores gerados por PrepararDados (nomes identicos ao legado,
    *-- pois o FRX SigOpFlu.frx faz binding por esses aliases)
    this_cCursorCabecalho   = "CsCabecalho"
    this_cCursorDados       = "CsFwUp"

    *--------------------------------------------------------------------------
    * Init - Construtor. Define titulo do relatorio e aliases de cursor.
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        DODEFAULT()

        THIS.this_cTabela          = ""
        THIS.this_cCampoChave      = ""
        THIS.this_cTituloRelatorio = "Impress" + CHR(227) + "o de FollowUp"

        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * PrepararDados - Valida filtros, monta cursores CsCabecalho (header do
    * FRX) e CsFwUp (historico de ocorrencias SigCdClh JOIN SigCdCli), nos
    * mesmos aliases/colunas do legado (processamento do SIGOPFLU.SCX).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE PrepararDados()
        LOCAL loc_lSucesso, loc_cSQL, loc_cGrupo, loc_cConta
        LOCAL loc_cEmpresa, loc_cTitulo, loc_cSubTitulo, loc_dtDataFim
        LOCAL loc_nResultado, loc_oErro

        loc_lSucesso = .F.

        TRY
            IF USED(THIS.this_cCursorCabecalho)
                USE IN (THIS.this_cCursorCabecalho)
            ENDIF
            IF USED(THIS.this_cCursorDados)
                USE IN (THIS.this_cCursorDados)
            ENDIF

            IF EMPTY(THIS.this_dDtInicial)
                THIS.this_cMensagemErro = "Data Inicial Inv" + CHR(225) + "lida !!!"
            ELSE
                IF EMPTY(THIS.this_dDtFinal)
                    THIS.this_cMensagemErro = "Data Final Inv" + CHR(225) + "lida !!!"
                ELSE
                    IF THIS.this_dDtFinal < THIS.this_dDtInicial
                        THIS.this_cMensagemErro = "Data Final n" + CHR(227) + "o pode ser maior que a Inicial !!!"
                    ELSE
                        IF EMPTY(THIS.this_cGrupo)
                            THIS.this_cMensagemErro = "Grupo Inv" + CHR(225) + "lido !!!"
                        ELSE

                            loc_cGrupo = ALLTRIM(THIS.this_cGrupo)
                            loc_cConta = ALLTRIM(THIS.this_cConta)

                            *-- Cabecalho do relatorio (Empresa/Titulo/SubTitulo/ImpData)
                            loc_cEmpresa = ALLTRIM(go_4c_Sistema.cCodEmpresa) + " - " + ;
                                           ALLTRIM(go_4c_Sistema.cEmpresa)
                            loc_cTitulo = ALLTRIM("Relat" + CHR(243) + "rio de FollowUp de " + ;
                                           PROPER(ALLTRIM(THIS.this_cDGrupo)))
                            loc_cSubTitulo = ALLTRIM("Per" + CHR(237) + "odo : " + ;
                                           DTOC(THIS.this_dDtInicial) + " " + CHR(224) + " " + ;
                                           DTOC(THIS.this_dDtFinal))

                            THIS.this_cEmpresa = loc_cEmpresa

                            CREATE CURSOR (THIS.this_cCursorCabecalho) ;
                                (Empresa C(80), Titulo C(80), SubTitulo C(80), ImpData L)
                            INSERT INTO (THIS.this_cCursorCabecalho) ;
                                (Empresa, Titulo, SubTitulo, ImpData) ;
                                VALUES (loc_cEmpresa, loc_cTitulo, loc_cSubTitulo, THIS.this_lImpData)

                            *-- Historico de ocorrencias (SigCdClh) no periodo/grupo/conta
                            loc_dtDataFim = DATETIME(YEAR(THIS.this_dDtFinal), ;
                                MONTH(THIS.this_dDtFinal), DAY(THIS.this_dDtFinal), 23, 59, 59)

                            loc_cSQL = "SELECT a.IClis, a.Datas, a.Hists, a.Obs, b.Cpfs, b.RClis " + ;
                                       "FROM SigCdClh a INNER JOIN SigCdCli b ON a.IClis = b.IClis " + ;
                                       "WHERE a.Datas BETWEEN " + FormatarDataSQL(THIS.this_dDtInicial) + ;
                                       " AND " + FormatarDataSQL(loc_dtDataFim) + ;
                                       " AND a.Grupos = " + EscaparSQL(loc_cGrupo)

                            IF !EMPTY(loc_cConta)
                                loc_cSQL = loc_cSQL + " AND a.IClis = " + EscaparSQL(loc_cConta)
                            ENDIF

                            loc_cSQL = loc_cSQL + " ORDER BY a.IClis, a.Datas, a.Hists, b.Cpfs, b.RClis"

                            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, THIS.this_cCursorDados)

                            IF loc_nResultado < 0
                                THIS.this_cMensagemErro = "Erro ao buscar dados de FollowUp." + ;
                                    CHR(13) + CapturarErroSQL()
                            ELSE
                                IF RECCOUNT(THIS.this_cCursorDados) = 0
                                    THIS.this_cMensagemErro = "Nenhum registro encontrado para os filtros informados."
                                ELSE
                                    SELECT (THIS.this_cCursorDados)
                                    GO TOP
                                    loc_lSucesso = .T.
                                ENDIF
                            ENDIF
                        ENDIF
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "PrepararDados")
            THIS.this_cMensagemErro = loc_oErro.Message
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ExecutarReportForm (Pattern #117/#123) - Executa REPORT FORM apenas se
    * o FRX existir; isola SET POINT/SEPARATOR/REPORTBEHAVIOR (FRXs legados
    * Fortyus foram desenhados em modo 80); restaura o menu principal depois
    * do preview (Erro63). par_cModo: "PREVIEW" | "PRINTER_PROMPT" | "PRINTER".
    * par_cCursorDados eh opcional - se informado e vazio, avisa e sai sem
    * abrir preview em branco.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ExecutarReportForm(par_cRelatorioBase, par_cModo, par_cCursorDados)
        LOCAL loc_cFRX, loc_cPointOrig, loc_cSepOrig, loc_nBehaviorOrig

        loc_cFRX = FULLPATH(gc_4c_CaminhoReports + par_cRelatorioBase + ".frx")

        IF NOT FILE(loc_cFRX)
            MostrarErro("Arquivo de relat" + CHR(243) + "rio n" + CHR(227) + "o encontrado:" + CHR(13) + ;
                loc_cFRX + CHR(13) + CHR(13) + ;
                "O FRX legado ainda n" + CHR(227) + "o foi portado para o novo sistema.", "Erro")
            RETURN .F.
        ENDIF

        IF VARTYPE(par_cCursorDados) == "C" AND !EMPTY(par_cCursorDados)
            IF !USED(par_cCursorDados) OR RECCOUNT(par_cCursorDados) = 0
                MsgAviso("Nenhum registro encontrado com os filtros informados.", ;
                    "Aten" + CHR(231) + CHR(227) + "o")
                RETURN .F.
            ENDIF
        ENDIF

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
    * Visualizar - Exibe o relatorio em preview na tela
    *--------------------------------------------------------------------------
    PROCEDURE Visualizar()
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.
        TRY
            IF THIS.PrepararDados()
                loc_lSucesso = THIS.ExecutarReportForm(THIS.this_cArquivoRelatorio, "PREVIEW", ;
                    THIS.this_cCursorDados)
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Visualizar")
            THIS.this_cMensagemErro = loc_oErro.Message
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Imprimir - Envia o relatorio para a impressora (com dialogo de escolha)
    *--------------------------------------------------------------------------
    PROCEDURE Imprimir()
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.
        TRY
            IF THIS.PrepararDados()
                loc_lSucesso = THIS.ExecutarReportForm(THIS.this_cArquivoRelatorio, "PRINTER_PROMPT", ;
                    THIS.this_cCursorDados)
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Imprimir")
            THIS.this_cMensagemErro = loc_oErro.Message
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * GerarExcel - Exporta o relatorio para arquivo .xls
    *--------------------------------------------------------------------------
    PROCEDURE GerarExcel()
        LOCAL loc_lSucesso, loc_cArquivo, loc_oErro
        loc_lSucesso = .F.
        TRY
            IF THIS.PrepararDados()
                IF USED(THIS.this_cCursorDados) AND RECCOUNT(THIS.this_cCursorDados) > 0
                    SELECT (THIS.this_cCursorDados)
                    GO TOP
                    loc_cArquivo = SYS(5) + CURDIR() + "SigOpFlu_" + ;
                                   STRTRAN(DTOC(DATE()), "/", "") + ".xls"
                    REPORT FORM (gc_4c_CaminhoReports + THIS.this_cArquivoRelatorio) ;
                        TO FILE (loc_cArquivo) NOCONSOLE ASCII
                    IF FILE(loc_cArquivo)
                        MsgInfo("Arquivo gerado:" + CHR(13) + loc_cArquivo, "Excel")
                    ENDIF
                    loc_lSucesso = .T.
                ELSE
                    THIS.this_cMensagemErro = "Nenhum registro encontrado com os filtros informados."
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "GerarExcel")
            THIS.this_cMensagemErro = loc_oErro.Message
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterMensagemErro - Retorna a ultima mensagem de erro/validacao
    *--------------------------------------------------------------------------
    PROCEDURE ObterMensagemErro()
        RETURN THIS.this_cMensagemErro
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Relatorio nao persiste registro; retorna chave
    * composta dos filtros principais, para fins de auditoria/log.
    *--------------------------------------------------------------------------
    PROCEDURE ObterChavePrimaria()
        LOCAL loc_cChave
        loc_cChave = IIF(EMPTY(THIS.this_dDtInicial), SPACE(8), DTOS(THIS.this_dDtInicial)) + "|" + ;
                     IIF(EMPTY(THIS.this_dDtFinal), SPACE(8), DTOS(THIS.this_dDtFinal)) + "|" + ;
                     ALLTRIM(THIS.this_cGrupo) + "|" + ;
                     ALLTRIM(THIS.this_cConta)
        RETURN loc_cChave
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Nao aplicavel a relatorios (RelatorioBase nao
    * persiste dados); mantido para compatibilidade com o padrao do pipeline.
    * A carga dos filtros vem do Form (FormParaRelatorio).
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir - Nao aplicavel ao relatorio de FollowUp (frmrelatorio nao
    * persiste dados). A acao equivalente eh Visualizar()/Imprimir().
    *--------------------------------------------------------------------------
    PROCEDURE Inserir()
        THIS.this_cMensagemErro = "Opera" + CHR(231) + CHR(227) + "o n" + CHR(227) + ;
                                   "o aplic" + CHR(225) + "vel a relat" + CHR(243) + "rios"
        RETURN .F.
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - Nao aplicavel ao relatorio de FollowUp. Vide Inserir().
    *--------------------------------------------------------------------------
    PROCEDURE Atualizar()
        THIS.this_cMensagemErro = "Opera" + CHR(231) + CHR(227) + "o n" + CHR(227) + ;
                                   "o aplic" + CHR(225) + "vel a relat" + CHR(243) + "rios"
        RETURN .F.
    ENDPROC

    *--------------------------------------------------------------------------
    * Destroy - Libera os cursores do relatorio
    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
        IF USED(THIS.this_cCursorDados)
            USE IN (THIS.this_cCursorDados)
        ENDIF
        IF USED(THIS.this_cCursorCabecalho)
            USE IN (THIS.this_cCursorCabecalho)
        ENDIF
        DODEFAULT()
    ENDPROC

ENDDEFINE


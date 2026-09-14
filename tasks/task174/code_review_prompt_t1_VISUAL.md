# CODE REVIEW - PASS VISUAL: Visual Properties (alinhamento, titulos, tipos)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Visual Properties (alinhamento, titulos, tipos)**.

## PROBLEMAS DETECTADOS (2)
- [TITULO-NAO-PROPAGADO] Form define Caption mas NAO propaga para lbl_4c_Sombra/lbl_4c_Titulo. O titulo na tela ficara incorreto (ex: 'Cadastro de Testes' ao inves do titulo real). CORRIGIR: No InicializarForm, APOS ConfigurarPageFrame, adicionar: THIS.pgf_4c_Paginas.Page1.cnt_4c_Sombra.lbl_4c_Sombra.Caption = THIS.Caption (e idem para lbl_4c_Titulo)
- [FONTNAME-ERRADO] Linha 388: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.

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

### FORM (C:\4c\projeto\app\forms\operacionais\Formsigprema.prg) - TRECHOS RELEVANTES PARA PASS VISUAL (1238 linhas total):

*-- Linhas 49 a 57:
49:                 THIS.BorderStyle  = 2
50:                 THIS.TitleBar     = 0
51:                 THIS.ControlBox   = .F.
52:                 THIS.Caption      = "Processamento e Gera" + CHR(231) + CHR(227) + "o de Email"
53:                 THIS.FontName     = "Tahoma"
54:                 THIS.FontSize     = 8
55:                 THIS.WindowType   = 1
56:                 THIS.ShowTips     = .T.
57: 

*-- Linhas 130 a 138:
130:     * Este metodo finaliza a area de dados:
131:     *   1. Aplica sort visual inicial (coluna Nome/Rclis destacada em teal)
132:     *   2. Normaliza BackColor dos demais headers em cinza claro
133:     *   3. Ajusta alinhamento do header do checkbox
134:     *   4. Garante que o grid comece com valores default consistentes
135:     *--------------------------------------------------------------------------
136:     PROTECTED PROCEDURE ConfigurarPaginaDados()
137:         LOCAL loc_oGrid
138: 

*-- Linhas 149 a 172:
149:         loc_oGrid.Column4.Header1.BackColor = RGB(192, 192, 192)
150:         loc_oGrid.Column5.Header1.BackColor = RGB(192, 192, 192)
151: 
152:         *-- Alinhamento do header do checkbox (centralizado)
153:         loc_oGrid.Column1.Header1.Alignment = 2
154: 
155:         *-- Modo somente-leitura no grid inteiro exceto checkbox
156:         loc_oGrid.Column2.ReadOnly = .T.
157:         loc_oGrid.Column3.ReadOnly = .T.
158:         loc_oGrid.Column5.ReadOnly = .T.
159: 
160:         RETURN .T.
161:     ENDPROC
162: 
163:     *--------------------------------------------------------------------------
164:     * ConfigurarPaginaLista - Cria grid principal e botoes auxiliares
165:     * Layout original:
166:     *   grade: Top=126, Left=3, Width=993, Height=469, ColumnCount=5
167:     *   Column5(ordem 1) = CheckBox, Width=17
168:     *   Column1(ordem 2) = Conta,    Width=80
169:     *   Column2(ordem 3) = Nome,     Width=290
170:     *   Column3(ordem 4) = Email,    Width=290
171:     *   Column4(ordem 5) = Mensagem, Width=290
172:     *   SelTudo: Top=84, Left=4,  W=40, H=40, Picture=geral_marcar_26.jpg

*-- Linhas 180 a 189:
180:         THIS.AddObject("grd_4c_Dados", "Grid")
181:         loc_oGrid = THIS.grd_4c_Dados
182:         WITH loc_oGrid
183:             .Top              = 126
184:             .Left             = 3
185:             .Width            = 993
186:             .Height           = 469
187:             .ColumnCount      = 5
188:             .FontName         = "Verdana"
189:             .FontSize         = 8

*-- Linhas 199 a 223:
199:             .RecordSource     = "cursor_4c_Dados"
200:             .Visible          = .T.
201: 
202:             *-- Coluna 1: CheckBox (selecao)
203:             WITH .Column1
204:                 .Width         = 17
205:                 .ColumnOrder   = 1
206:                 .ReadOnly      = .F.
207:                 .Sparse        = .F.
208:                 .FontName      = "Verdana"
209:                 .FontSize      = 8
210:                 .AddObject("Check1", "CheckBox")
211:                 WITH .Check1
212:                     .Caption   = ""
213:                     .Value     = 0
214:                     .Visible   = .T.
215:                 ENDWITH
216:                 .CurrentControl  = "Check1"
217:                 .ControlSource   = "cursor_4c_Dados.Checks"
218:                 .Header1.Caption = ""
219:                 .Header1.FontName = "Tahoma"
220:                 .Header1.FontSize = 8
221:             ENDWITH
222: 
223:             *-- Coluna 2: Conta

*-- Linhas 240 a 248:
240:                     .Visible     = .T.
241:                 ENDWITH
242:                 .CurrentControl  = "Text1"
243:                 .Header1.Caption  = "Conta"
244:                 .Header1.FontName = "Tahoma"
245:                 .Header1.FontSize = 8
246:                 .Header1.Alignment = 2
247:             ENDWITH
248: 

*-- Linhas 266 a 274:
266:                     .Visible     = .T.
267:                 ENDWITH
268:                 .CurrentControl  = "Text1"
269:                 .Header1.Caption  = "Nome"
270:                 .Header1.FontName = "Tahoma"
271:                 .Header1.FontSize = 8
272:                 .Header1.Alignment = 2
273:             ENDWITH
274: 

*-- Linhas 292 a 300:
292:                     .Visible     = .T.
293:                 ENDWITH
294:                 .CurrentControl  = "Text1"
295:                 .Header1.Caption  = "Email"
296:                 .Header1.FontName = "Tahoma"
297:                 .Header1.FontSize = 8
298:                 .Header1.Alignment = 2
299:             ENDWITH
300: 

*-- Linhas 317 a 325:
317:                     .Visible       = .T.
318:                 ENDWITH
319:                 .CurrentControl  = "Edit1"
320:                 .Header1.Caption  = "Movimenta" + CHR(231) + CHR(227) + "o de Estoque"
321:                 .Header1.FontName = "Tahoma"
322:                 .Header1.FontSize = 8
323:                 .Header1.Alignment = 2
324:             ENDWITH
325:         ENDWITH

*-- Linhas 336 a 411:
336:         BINDEVENT(loc_oGrid.Column3.Header1, "Click", THIS, "GrdHeader3Click")
337:         BINDEVENT(loc_oGrid.Column4.Header1, "Click", THIS, "GrdHeader4Click")
338: 
339:         *-- Handler de InteractiveChange no CheckBox para atualizar cursor
340:         BINDEVENT(loc_oGrid.Column1.Check1, "InteractiveChange", THIS, "ChkSelChange")
341: 
342:         *-- Botao SelTudo (Marcar Todos)
343:         THIS.AddObject("cmd_4c_SelTudo", "CommandButton")
344:         WITH THIS.cmd_4c_SelTudo
345:             .Top          = 84
346:             .Left         = 4
347:             .Height       = 40
348:             .Width        = 40
349:             .FontName     = "Verdana"
350:             .FontSize     = 8
351:             .WordWrap     = .T.
352:             .Caption      = ""
353:             .ToolTipText  = "Marcar Todos"
354:             .ForeColor    = RGB(36, 84, 155)
355:             .BackColor    = RGB(255, 255, 255)
356:             .Themes       = .T.
357:             .Picture      = gc_4c_CaminhoIcones + "geral_marcar_26.jpg"
358:             .DisabledPicture = gc_4c_CaminhoIcones + "geral_marcar_26.jpg"
359:             .TabStop      = .F.
360:             .Visible      = .T.
361:         ENDWITH
362:         BINDEVENT(THIS.cmd_4c_SelTudo, "Click", THIS, "CmdSelTudoClick")
363: 
364:         *-- Botao apaga (Desmarcar Todos)
365:         THIS.AddObject("cmd_4c_Apaga", "CommandButton")
366:         WITH THIS.cmd_4c_Apaga
367:             .Top          = 84
368:             .Left         = 43
369:             .Height       = 40
370:             .Width        = 40
371:             .FontName     = "Verdana"
372:             .FontSize     = 8
373:             .WordWrap     = .T.
374:             .Caption      = ""
375:             .ToolTipText  = "Desmarcar Todos"
376:             .ForeColor    = RGB(36, 84, 155)
377:             .BackColor    = RGB(255, 255, 255)
378:             .Themes       = .T.
379:             .Picture      = gc_4c_CaminhoIcones + "cadastro_excluir_26.jpg"
380:             .DisabledPicture = gc_4c_CaminhoIcones + "cadastro_excluir_26.jpg"
381:             .TabStop      = .F.
382:             .Visible      = .T.
383:         ENDWITH
384:         BINDEVENT(THIS.cmd_4c_Apaga, "Click", THIS, "CmdApagaClick")
385: 
386:         *-- Botao Enviar Email
387:         THIS.AddObject("cmd_4c_BtnEmail", "CommandButton")
388:         WITH THIS.cmd_4c_BtnEmail
389:             .Top          = 3
390:             .Left         = 850
391:             .Height       = 75
392:             .Width        = 75
393:             .FontBold     = .T.
394:             .FontItalic   = .T.
395:             .FontName     = "Comic Sans MS"
396:             .FontSize     = 8
397:             .Caption      = "Enviar Email"
398:             .ToolTipText  = "Enviar Email"
399:             .ForeColor    = RGB(90, 90, 90)
400:             .BackColor    = RGB(255, 255, 255)
401:             .Themes       = .T.
402:             .Picture      = gc_4c_CaminhoIcones + "geral_envelope_60.jpg"
403:             .DisabledPicture = gc_4c_CaminhoIcones + "geral_envelope_60.jpg"
404:             .Visible      = .T.
405:         ENDWITH
406:         BINDEVENT(THIS.cmd_4c_BtnEmail, "Click", THIS, "CmdBtnEmailClick")
407:     ENDPROC
408: 
409:     *--------------------------------------------------------------------------
410:     * GrdHeader2Click - Ordena grid pela coluna Conta
411:     *--------------------------------------------------------------------------

*-- Linhas 443 a 451:
443:     ENDPROC
444: 
445:     *--------------------------------------------------------------------------
446:     * ChkSelChange - Atualiza campo Checks no cursor quando CheckBox muda
447:     *--------------------------------------------------------------------------
448:     PROCEDURE ChkSelChange()
449:         LOCAL loc_oChk
450:         loc_oChk = THIS.grd_4c_Dados.Column1.Check1
451:         IF USED("cursor_4c_Dados")

*-- Linhas 486 a 549:
486:     PROTECTED PROCEDURE ConfigurarCabecalho()
487:         THIS.AddObject("cnt_4c_Cabecalho", "Container")
488:         WITH THIS.cnt_4c_Cabecalho
489:             .Top         = 0
490:             .Left        = 0
491:             .Width       = THIS.Width
492:             .Height      = 80
493:             .BorderWidth = 0
494:             .BackStyle   = 1
495:             .BackColor   = RGB(100, 100, 100)
496:             .Visible     = .T.
497: 
498:             .AddObject("lbl_4c_Sombra", "Label")
499:             WITH .lbl_4c_Sombra
500:                 .Top      = 18
501:                 .Left     = 10
502:                 .Width    = THIS.Width
503:                 .Height   = 40
504:                 .AutoSize = .F.
505:                 .FontName = "Tahoma"
506:                 .FontSize = 18
507:                 .FontBold = .T.
508:                 .BackStyle = 0
509:                 .ForeColor = RGB(0, 0, 0)
510:                 .WordWrap  = .T.
511:                 .Alignment = 0
512:                 .Caption   = "Processamento e Gera" + CHR(231) + CHR(227) + "o de Email"
513:                 .Visible   = .T.
514:             ENDWITH
515: 
516:             .AddObject("lbl_4c_Titulo", "Label")
517:             WITH .lbl_4c_Titulo
518:                 .Top         = 17
519:                 .Left        = 10
520:                 .Width       = THIS.Width
521:                 .Height      = 46
522:                 .AutoSize    = .F.
523:                 .FontName    = "Tahoma"
524:                 .FontSize    = 18
525:                 .FontBold    = .T.
526:                 .BackStyle   = 0
527:                 .ForeColor   = RGB(255, 255, 255)
528:                 .WordWrap    = .T.
529:                 .Alignment   = 0
530:                 .Caption     = "Processamento e Gera" + CHR(231) + CHR(227) + "o de Email"
531:                 .ToolTipText = "T" + CHR(237) + "tulo do Relat" + CHR(243) + "rio"
532:                 .Visible     = .T.
533:             ENDWITH
534:         ENDWITH
535:     ENDPROC
536: 
537:     *--------------------------------------------------------------------------
538:     * ConfigurarShape1 - Cria elemento decorativo ao redor do botao Email
539:     *--------------------------------------------------------------------------
540:     PROTECTED PROCEDURE ConfigurarShape1()
541:         THIS.AddObject("shp_4c_Shape1", "Shape")
542:         WITH THIS.shp_4c_Shape1
543:             .Top          = 7
544:             .Left         = 804
545:             .Height       = 110
546:             .Width        = 90
547:             .BackStyle    = 0
548:             .BorderStyle  = 0
549:             .BorderWidth  = 1

*-- Linhas 559 a 586:
559:     PROTECTED PROCEDURE ConfigurarSaida()
560:         THIS.AddObject("cmg_4c_Saida", "CommandGroup")
561:         WITH THIS.cmg_4c_Saida
562:             .Top           = -2
563:             .Left          = 920
564:             .Width         = 85
565:             .Height        = 85
566:             .ButtonCount   = 1
567:             .BackStyle     = 0
568:             .BorderStyle   = 0
569:             .SpecialEffect = 1
570:             .BorderColor   = RGB(136, 189, 188)
571:             .Themes        = .F.
572:             .Visible       = .T.
573: 
574:             WITH .Buttons(1)
575:                 .Top         = 5
576:                 .Left        = 5
577:                 .Height      = 75
578:                 .Width       = 75
579:                 .FontBold    = .T.
580:                 .FontItalic  = .T.
581:                 .Caption     = "Encerrar"
582:                 .ToolTipText = "[Esc] Encerrar"
583:                 .ForeColor   = RGB(90, 90, 90)
584:                 .BackColor   = RGB(255, 255, 255)
585:                 .Themes      = .F.
586:                 .Cancel      = .T.


### BO (C:\4c\projeto\app\classes\sigpremaBO.prg):
*==============================================================================
* sigpremaBO.prg - Business Object: Processamento e Geracao de Email
* Herda de: BusinessBase
* Form: Formsigprema.prg (OPERACIONAL)
*==============================================================================

DEFINE CLASS sigpremaBO AS BusinessBase

    *-- Parametros de entrada do processo
    this_cEmpDopNums = ""    && Identificador completo do movimento (Emps+Dopes+Numes C29)
    this_cEmps       = ""    && Codigo da empresa (3 chars)
    this_cDopes      = ""    && Tipo de operacao (chars 4-23)
    this_nNumes      = 0     && Numero do movimento (chars 24-29)
    this_lAutomatico = .F.   && Modo automatico: processa e encerra sem interacao

    *-- Estado do processo de email
    this_cArqEmail   = ""    && Caminho do arquivo PDF gerado para anexo
    this_cEscolha    = ""    && Escolha de operacao retornada pelo ImpDocto

    *-- Configuracoes de email extraidas de SigCdEmp
    this_cPadEmails  = ""    && Email remetente (PadEmails)
    this_cPadServs   = ""    && Servidor SMTP (PadServs)
    this_cPadSenhas  = ""    && Senha SMTP (PadSenhas)
    this_nPadPortas  = 0     && Porta SMTP (PadPortas)

    *-- Estado da disponibilidade do PDFCreator
    this_lEmailAtivo = .F.   && .T. se PDFCreator esta registrado no sistema

    *-- Propriedades da linha do cursor (para CarregarDoCursor)
    this_cContas     = ""    && Codigo da conta/cliente (Iclis)
    this_cRclis      = ""    && Nome do cliente/conta (Rclis)
    this_cEmails     = ""    && Endereco de email
    this_cGrupos     = ""    && Grupo do cliente
    this_cMensagems  = ""    && Corpo da mensagem
    this_cPrioridade = ""    && Prioridade (NORMAL/etc)
    this_nChecks     = 0     && Flag de selecao para envio (0=nao, 1=sim)

    *--------------------------------------------------------------------------
    PROCEDURE Init()
    *--------------------------------------------------------------------------
        THIS.this_cTabela     = "SigMvCab"
        THIS.this_cCampoChave = "EmpDopNums"
        DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Mapeia campos do cursor para propriedades do BO
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        IF USED(par_cAliasCursor)
            SELECT (par_cAliasCursor)
            THIS.this_nChecks     = TratarNulo(Checks, "N")
            THIS.this_cGrupos     = TratarNulo(grupos, "C")
            THIS.this_cContas     = TratarNulo(Contas, "C")
            THIS.this_cRclis      = TratarNulo(Rclis, "C")
            THIS.this_cEmails     = TratarNulo(emails, "C")
            THIS.this_cMensagems  = TratarNulo(mensagems, "C")
            THIS.this_cEmpDopNums = TratarNulo(EmpDopNums, "C")
            THIS.this_cPrioridade = TratarNulo(prioridade, "C")
            THIS.this_cEmps       = SUBSTR(THIS.this_cEmpDopNums, 1, 3)
            THIS.this_cDopes      = SUBSTR(THIS.this_cEmpDopNums, 4, 20)
            THIS.this_nNumes      = VAL(SUBSTR(THIS.this_cEmpDopNums, 24, 6))
            RETURN .T.
        ENDIF
        RETURN .F.
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarListaEmail - Carrega cursor_4c_Local com movimentos para envio
    * par_cDopes: EmpDopNums do movimento especifico (vazio = todos do dia)
    *--------------------------------------------------------------------------
    PROCEDURE CarregarListaEmail(par_cDopes)
        LOCAL loc_lSucesso, loc_cQuery
        loc_lSucesso = .F.

        TRY
            IF USED("cursor_4c_Local")
                USE IN cursor_4c_Local
            ENDIF

            SET NULL ON
            CREATE CURSOR cursor_4c_Local (;
                Checks     N(1)    NULL,;
                grupos     C(10)   NULL,;
                Contas     C(10)   NULL,;
                Rclis      C(30)   NULL,;
                emails     C(50)   NULL,;
                mensagems  M,;
                EmpDopNums C(29)   NULL,;
                prioridade C(15)   NULL;
            )
            SET NULL OFF
            INDEX ON Contas     TAG Contas
            INDEX ON Rclis      TAG Rclis
            INDEX ON emails     TAG Emails

            *-- Carrega movimentos: especifico ou todos do dia sem log
            IF EMPTY(par_cDopes)
                loc_cQuery = "SELECT 1 AS Checks, a.EmpDopNums, a.Jobs, " + ;
                             "b.Rclis, b.Rclis AS Rclis2, b.emails, b.grupos, b.iclis " + ;
                             "FROM SigMvCab a " + ;
                             "INNER JOIN SigCdCli b ON a.Contads = b.Iclis " + ;
                             "WHERE CONVERT(date, a.datatrans) = CONVERT(date, GETDATE()) " + ;
                             "AND a.EmpDopNums NOT IN (" + ;
                             "  SELECT transacaos FROM SigOpLog WHERE progs = 'SIGPREMA'" + ;
                             ") " + ;
                             "ORDER BY a.EmpDopNums"
            ELSE
                loc_cQuery = "SELECT 1 AS Checks, a.EmpDopNums, a.Jobs, " + ;
                             "b.Rclis, b.Rclis AS Rclis2, b.emails, b.grupos, b.iclis " + ;
                             "FROM SigMvCab a " + ;
                             "INNER JOIN SigCdCli b ON a.Contads = b.Iclis " + ;
                             "WHERE a.EmpDopNums = " + EscaparSQL(par_cDopes)
            ENDIF

            IF SQLEXEC(gnConnHandle, loc_cQuery, "cursor_4c_MvTemp") < 1
                MsgErro("Falha ao carregar movimentos para email.", "Erro")
                loc_lSucesso = .F.
            ENDIF

            SELECT cursor_4c_MvTemp
            SCAN
                INSERT INTO cursor_4c_Local ;
                    (Checks, grupos, Contas, Rclis, emails, prioridade, EmpDopNums) ;
                    VALUES (cursor_4c_MvTemp.Checks, cursor_4c_MvTemp.grupos, ;
                            cursor_4c_MvTemp.iclis, cursor_4c_MvTemp.Rclis, ;
                            cursor_4c_MvTemp.emails, "NORMAL", cursor_4c_MvTemp.EmpDopNums)
            ENDSCAN
            IF USED("cursor_4c_MvTemp")
                USE IN cursor_4c_MvTemp
            ENDIF

            *-- Carrega clientes do grupo PAM (SigCdPam)
            loc_cQuery = "SELECT 0 AS Checks, c.grupos, c.iclis AS Contas, " + ;
                         "c.rclis, c.emails, '' AS prioridade " + ;
                         "FROM SigCdPam p " + ;
                         "INNER JOIN SigCdCli c ON c.grupos = p.grpadats"

            IF SQLEXEC(gnConnHandle, loc_cQuery, "cursor_4c_PamTemp") >= 1
                SELECT cursor_4c_PamTemp
                SCAN
                    LOCAL loc_cJobQuery, loc_cContasPam, loc_cRclisPam, loc_cEmailsPam
                    loc_cContasPam = cursor_4c_PamTemp.Contas
                    loc_cRclisPam  = cursor_4c_PamTemp.Rclis
                    loc_cEmailsPam = cursor_4c_PamTemp.emails

                    *-- Verifica se cliente tem job associado ao movimento
                    loc_cJobQuery = "SELECT Jobs FROM SigClJob WHERE Iclis = " + ;
                                   EscaparSQL(loc_cContasPam)
                    IF SQLEXEC(gnConnHandle, loc_cJobQuery, "cursor_4c_JobTemp") >= 1
                        SELECT cursor_4c_JobTemp
                        GO TOP
                        IF !EOF()
                            *-- Insere apenas se nao existe ja no cursor
                            SELECT cursor_4c_Local
                            LOCATE FOR ALLTRIM(cursor_4c_Local.Contas) = ALLTRIM(loc_cContasPam) ;
                                    AND ALLTRIM(cursor_4c_Local.Rclis)  = ALLTRIM(loc_cRclisPam)
                            IF EOF()
                                INSERT INTO cursor_4c_Local ;
                                    (Checks, grupos, Contas, Rclis, emails, EmpDopNums, prioridade) ;
                                    VALUES (0, "", loc_cContasPam, loc_cRclisPam, ;
                                            loc_cEmailsPam, par_cDopes, "NORMAL")
                            ENDIF
                        ENDIF
                        IF USED("cursor_4c_JobTemp")
                            USE IN cursor_4c_JobTemp
                        ENDIF
                    ENDIF
                    SELECT cursor_4c_PamTemp
                ENDSCAN
                IF USED("cursor_4c_PamTemp")
                    USE IN cursor_4c_PamTemp
                ENDIF
            ENDIF

            SELECT cursor_4c_Local
            GO TOP
            loc_lSucesso = .T.

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo), ;
                    "Erro ao carregar lista de email")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * BuscarConfigEmail - Carrega configuracoes SMTP de sigcdemp para this_*
    *--------------------------------------------------------------------------
    PROCEDURE BuscarConfigEmail()
        LOCAL loc_lSucesso, loc_cQuery
        loc_lSucesso = .F.

        TRY
            loc_cQuery = "SELECT pademails, padservs, padsenhas, padportas " + ;
                         "FROM sigcdemp WHERE cemps = " + EscaparSQL(go_4c_Sistema.cCodEmpresa)

            IF SQLEXEC(gnConnHandle, loc_cQuery, "cursor_4c_EmpEmail") >= 1
                SELECT cursor_4c_EmpEmail
                GO TOP
                IF !EOF()
                    THIS.this_cPadEmails = ALLTRIM(NVL(pademails, ""))
                    THIS.this_cPadServs  = ALLTRIM(NVL(padservs, ""))
                    THIS.this_cPadSenhas = ALLTRIM(NVL(padsenhas, ""))
                    THIS.this_nPadPortas = NVL(padportas, 0)
                    loc_lSucesso = .T.
                ENDIF
                IF USED("cursor_4c_EmpEmail")
                    USE IN cursor_4c_EmpEmail
                ENDIF
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo), ;
                    "Erro ao buscar configura" + CHR(231) + CHR(227) + "o de email")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir - Registra envio de email no log de operacoes (SigOpLog)
    * Chamado apos cada email enviado com sucesso
    *--------------------------------------------------------------------------
    PROCEDURE Inserir()
        LOCAL loc_lSucesso, loc_cSQL
        loc_lSucesso = .F.

        TRY
            IF EMPTY(ALLTRIM(THIS.this_cEmpDopNums))
                MsgAviso("Identifica" + CHR(231) + CHR(227) + "o do movimento n" + ;
                         CHR(227) + "o informada.", "Aviso")
                loc_lSucesso = .F.
            ENDIF

            loc_cSQL = "INSERT INTO SigOpLog " + ;
                       "(usuaredes, datars, horas, progs, opers, usuasis, " + ;
                       " parametros, transacaos, cversaos, cidchaves, copias) " + ;
                       "VALUES (" + ;
                       EscaparSQL(gc_4c_UsuarioLogado) + ", " + ;
                       "GETDATE(), " + ;
                       EscaparSQL(LEFT(TIME(), 8)) + ", " + ;
                       "'SIGPREMA', 'T', " + ;
                       EscaparSQL(gc_4c_UsuarioLogado) + ", " + ;
                       "'', " + ;
                       EscaparSQL(ALLTRIM(THIS.this_cEmpDopNums)) + ", " + ;
                       "'', '', 0)"

            IF SQLEXEC(gnConnHandle, loc_cSQL) > 0
                THIS.RegistrarAuditoria("INSERIR")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao registrar log de envio de email.", "Erro")
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo), ;
                    "Erro ao registrar email")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - Nao aplicavel para este form operacional
    *--------------------------------------------------------------------------
    PROCEDURE Atualizar()
        RETURN .F.
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Retorna chave primaria do movimento atual
    *--------------------------------------------------------------------------
    PROCEDURE ObterChavePrimaria()
        RETURN THIS.this_cEmpDopNums
    ENDPROC

    *--------------------------------------------------------------------------
    * RegistrarAuditoria - Registra operacao na tabela LogAuditoria
    *--------------------------------------------------------------------------
    PROCEDURE RegistrarAuditoria(par_cOperacao)
        LOCAL loc_lSucesso, loc_cSQL
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "INSERT INTO LogAuditoria " + ;
                       "(Usuario, Operacao, Tabela, ChaveRegistro, DataHora) " + ;
                       "VALUES (" + ;
                       EscaparSQL(gc_4c_UsuarioLogado) + ", " + ;
                       EscaparSQL(par_cOperacao) + ", " + ;
                       "'SigMvCab', " + ;
                       EscaparSQL(THIS.ObterChavePrimaria()) + ", " + ;
                       "GETDATE())"

            SQLEXEC(gnConnHandle, loc_cSQL)
            loc_lSucesso = .T.

        CATCH TO loc_oErro
            *-- Auditoria nao bloqueia operacao principal
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

ENDDEFINE


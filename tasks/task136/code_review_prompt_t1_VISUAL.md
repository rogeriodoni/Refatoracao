# CODE REVIEW - PASS VISUAL: Visual Properties (alinhamento, titulos, tipos)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Visual Properties (alinhamento, titulos, tipos)**.

## PROBLEMAS DETECTADOS (1)
- [FONTNAME-ERRADO] Linha 485: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.

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

### FORM (C:\4c\projeto\app\forms\operacionais\FormSigPdM11.prg) - TRECHOS RELEVANTES PARA PASS VISUAL (1587 linhas total):

*-- Linhas 54 a 62:
54:         Visible = .F.
55: 
56:     *-- Label "Contas de :"
57:     ADD OBJECT lbl_4c_ContasLabel AS Label WITH ;
58:         AutoSize = .T., FontBold = .T., FontName = "Tahoma", FontSize = 8, ;
59:         BackStyle = 0, Caption = "Contas de :", ;
60:         Height = 15, Left = 634, Top = 96, Width = 64, ;
61:         ForeColor = RGB(90,90,90), Visible = .F.
62: 

*-- Linhas 97 a 105:
97:         ReadOnly = .T., Visible = .F.
98: 
99:     *-- Label descricao do servico
100:     ADD OBJECT lbl_4c_Label3 AS Label WITH ;
101:         AutoSize = .T., FontName = "Tahoma", FontSize = 8, ;
102:         BackStyle = 0, ;
103:         Height = 15, Left = 128, Top = 548, Width = 108, ;
104:         ForeColor = RGB(90,90,90), Visible = .F.
105: 

*-- Linhas 143 a 151:
143:         ENDIF
144: 
145:         TRY
146:             THIS.Caption = "Pagamento de Servi" + CHR(231) + "os"
147:             THIS.Picture = gc_4c_CaminhoIcones + "new_background.jpg"
148: 
149:             THIS.this_oBusinessObject.this_cPcEscolha = THIS.this_cPcEscolha
150: 
151:             *-- Bloqueia tela durante setup (equivalente a This.LockScreen = .t. do legado)

*-- Linhas 321 a 388:
321:         loc_cCaption = THIS.Caption
322: 
323:         WITH THIS.cnt_4c_Sombra
324:             .ADDOBJECT("lbl_4c_LblSombra", "Label")
325:             WITH .lbl_4c_LblSombra
326:                 .FontBold   = .T.
327:                 .FontName   = "Tahoma"
328:                 .FontSize   = 18
329:                 .WordWrap   = .T.
330:                 .Alignment  = 0
331:                 .BackStyle  = 0
332:                 .Caption    = loc_cCaption
333:                 .Height     = 40
334:                 .Left       = 10
335:                 .Top        = 18
336:                 .Width      = 769
337:                 .ForeColor  = RGB(0,0,0)
338:                 .Visible    = .T.
339:             ENDWITH
340: 
341:             .ADDOBJECT("lbl_4c_LblTitulo", "Label")
342:             WITH .lbl_4c_LblTitulo
343:                 .FontBold   = .T.
344:                 .FontName   = "Tahoma"
345:                 .FontSize   = 18
346:                 .WordWrap   = .T.
347:                 .Alignment  = 0
348:                 .BackStyle  = 0
349:                 .Caption    = loc_cCaption
350:                 .Height     = 46
351:                 .Left       = 10
352:                 .Top        = 17
353:                 .Width      = 769
354:                 .ForeColor  = RGB(255,255,255)
355:                 .Visible    = .T.
356:             ENDWITH
357:         ENDWITH
358:     ENDPROC
359: 
360:     *==========================================================================
361:     * ConfigurarOperacao - Configura container de informacoes da operacao
362:     *==========================================================================
363:     PROTECTED PROCEDURE ConfigurarOperacao()
364:         WITH THIS.cnt_4c_Operacao
365:             .ADDOBJECT("lbl_4c_Say4", "Label")
366:             WITH .lbl_4c_Say4
367:                 .FontName  = "Tahoma"
368:                 .FontSize  = 8
369:                 .BackStyle = 0
370:                 .Caption   = "Movimenta" + CHR(231) + CHR(227) + "o :"
371:                 .Left      = 23
372:                 .Top       = 14
373:                 .ForeColor = RGB(90,90,90)
374:                 .Visible   = .T.
375:             ENDWITH
376: 
377:             *-- Empresa (tmpnens.emps)
378:             .ADDOBJECT("txt_4c_Empresa", "TextBox")
379:             WITH .txt_4c_Empresa
380:                 .ControlSource     = "tmpnens.emps"
381:                 .Height            = 23
382:                 .Left              = 103
383:                 .Top               = 10
384:                 .Width             = 36
385:                 .ReadOnly          = .T.
386:                 .FontName          = "Tahoma"
387:                 .FontSize          = 8
388:                 .DisabledBackColor = RGB(255,255,255)

*-- Linhas 394 a 403:
394:             WITH .txt_4c_Operacao
395:                 .ControlSource     = "tmpnens.dopps"
396:                 .Height            = 23
397:                 .Left              = 141
398:                 .Top               = 10
399:                 .Width             = 156
400:                 .ReadOnly          = .T.
401:                 .FontName          = "Tahoma"
402:                 .FontSize          = 8
403:                 .DisabledBackColor = RGB(255,255,255)

*-- Linhas 410 a 419:
410:                 .ControlSource     = "tmpnens.numps"
411:                 .Format            = "L"
412:                 .InputMask         = "9999999999"
413:                 .Left              = 299
414:                 .Top               = 10
415:                 .Width             = 81
416:                 .ReadOnly          = .T.
417:                 .FontName          = "Tahoma"
418:                 .FontSize          = 8
419:                 .DisabledBackColor = RGB(255,255,255)

*-- Linhas 431 a 491:
431:                 .FontName  = "Tahoma"
432:                 .FontSize  = 8
433:                 .BackStyle = 0
434:                 .Caption   = "Movimenta" + CHR(231) + CHR(227) + "o"
435:                 .Value     = 1
436:                 .Height    = 15
437:                 .Left      = 3
438:                 .Top       = 5
439:                 .Width     = 87
440:                 .AutoSize  = .T.
441:                 .ForeColor = RGB(90,90,90)
442:             ENDWITH
443: 
444:             WITH .Buttons(2)
445:                 .FontName  = "Tahoma"
446:                 .FontSize  = 8
447:                 .BackStyle = 0
448:                 .Caption   = "Cadastro"
449:                 .Height    = 15
450:                 .Left      = 112
451:                 .Top       = 5
452:                 .Width     = 62
453:                 .AutoSize  = .T.
454:                 .ForeColor = RGB(90,90,90)
455:             ENDWITH
456:         ENDWITH
457:     ENDPROC
458: 
459:     *==========================================================================
460:     * ConfigurarDescricaoServico - Configura label e textbox de descricao
461:     *==========================================================================
462:     PROTECTED PROCEDURE ConfigurarDescricaoServico()
463:         WITH THIS.lbl_4c_Label3
464:             .Caption = "Descri" + CHR(231) + CHR(227) + "o do Servi" + CHR(231) + "o :"
465:         ENDWITH
466: 
467:         WITH THIS.txt_4c_DescCat
468:             .ControlSource = "xNensiS.cDescs"
469:         ENDWITH
470:     ENDPROC
471: 
472:     *==========================================================================
473:     * ConfigurarSaida - Adiciona cmd_4c_Ok no cnt_4c_Saida
474:     *==========================================================================
475:     PROTECTED PROCEDURE ConfigurarSaida()
476:         WITH THIS.cnt_4c_Saida
477:             .ADDOBJECT("cmd_4c_Ok", "CommandButton")
478:             WITH .cmd_4c_Ok
479:                 .Left            = 5
480:                 .Top             = 5
481:                 .Width           = 75
482:                 .Height          = 75
483:                 .Caption         = "OK"
484:                 .Picture         = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
485:                 .FontName        = "Comic Sans MS"
486:                 .FontBold        = .T.
487:                 .FontItalic      = .T.
488:                 .FontSize        = 8
489:                 .ForeColor       = RGB(90,90,90)
490:                 .BackColor       = RGB(255,255,255)
491:                 .SpecialEffect   = 0

*-- Linhas 497 a 505:
497:                 .Visible         = .T.
498:             ENDWITH
499:         ENDWITH
500:         BINDEVENT(THIS.cnt_4c_Saida.cmd_4c_Ok, "Click", THIS, "BtnOkClick")
501:     ENDPROC
502: 
503:     *==========================================================================
504:     * BtnOkClick - Valida, grava itens e fecha o form retornando controle ao pai
505:     *==========================================================================

*-- Linhas 587 a 595:
587:                     .Format        = "L"
588:                     .InputMask     = "9999999999"
589:                     WITH .Header1
590:                         .Caption   = "O.S."
591:                         .Alignment = 2
592:                         .FontName  = "Tahoma"
593:                         .FontSize  = 8
594:                     ENDWITH
595:                     WITH .Text1

*-- Linhas 611 a 619:
611:                     .Resizable     = .F.
612:                     .FontBold      = .T.
613:                     WITH .Header1
614:                         .Caption   = "Cat."
615:                         .Alignment = 2
616:                         .FontName  = "Tahoma"
617:                         .FontSize  = 8
618:                     ENDWITH
619:                     WITH .Text1

*-- Linhas 635 a 643:
635:                     .Resizable     = .F.
636:                     .FontBold      = .T.
637:                     WITH .Header1
638:                         .Caption   = "Valor"
639:                         .Alignment = 2
640:                         .FontName  = "Tahoma"
641:                         .FontSize  = 8
642:                     ENDWITH
643:                     WITH .Text1

*-- Linhas 659 a 667:
659:                     .Resizable     = .F.
660:                     .FontBold      = .T.
661:                     WITH .Header1
662:                         .Caption   = "Quantidade"
663:                         .Alignment = 2
664:                         .FontName  = "Tahoma"
665:                         .FontSize  = 8
666:                     ENDWITH
667:                     WITH .Text1

*-- Linhas 682 a 690:
682:                     .Resizable     = .F.
683:                     .FontBold      = .T.
684:                     WITH .Header1
685:                         .Caption   = "Conta"
686:                         .Alignment = 2
687:                         .FontName  = "Tahoma"
688:                         .FontSize  = 8
689:                     ENDWITH
690:                     WITH .Text1

*-- Linhas 705 a 713:
705:                     .Resizable     = .F.
706:                     .FontBold      = .T.
707:                     WITH .Header1
708:                         .Caption   = "Grupo"
709:                         .Alignment = 2
710:                         .FontName  = "Tahoma"
711:                         .FontSize  = 8
712:                     ENDWITH
713:                     WITH .Text1

*-- Linhas 728 a 736:
728:                     .Resizable     = .F.
729:                     .FontBold      = .T.
730:                     WITH .Header1
731:                         .Caption   = "Retrab."
732:                         .Alignment = 2
733:                         .FontName  = "Tahoma"
734:                         .FontSize  = 8
735:                     ENDWITH
736:                     WITH .Text1

*-- Linhas 751 a 759:
751:                     .Movable       = .F.
752:                     .FontBold      = .T.
753:                     WITH .Header1
754:                         .Caption   = "Valor Retrab."
755:                         .Alignment = 2
756:                         .FontName  = "Tahoma"
757:                         .FontSize  = 8
758:                     ENDWITH
759:                     WITH .Text1

*-- Linhas 775 a 783:
775:                     .Resizable     = .F.
776:                     .FontBold      = .T.
777:                     WITH .Header1
778:                         .Caption   = "Valor Indicado"
779:                         .Alignment = 2
780:                         .FontName  = "Tahoma"
781:                         .FontSize  = 8
782:                     ENDWITH
783:                     WITH .Text1


### BO (C:\4c\projeto\app\classes\SigPdM11BO.prg):
*==============================================================================
* SigPdM11BO.prg - Business Object para Pagamento de Servicos (SIGPDM11)
* Gerencia validacao e atualizacao de itens de servico em pagamento
*
* Form de origem: SigPdM11.SCX (sub-form aberto pelo form pai com parametros)
* Cursor principal: xNensiS (itens do pagamento, gerenciado pela datasession pai)
*==============================================================================
DEFINE CLASS SigPdM11BO AS BusinessBase

    *-- Configuracao da entidade de dados
    this_cTabela      = "xNensiS"
    this_cCampoChave  = "Nenvs"

    *--------------------------------------------------------------------------
    * Campos do cursor xNensiS (itens de servico do pagamento)
    *--------------------------------------------------------------------------
    this_nNenvs       = 0     && Numero do envelope / O.S. (Nenvs)
    this_cCats        = ""    && Codigo da categoria (cats)
    this_nFators      = 0     && Valor do servico (Fators)
    this_nQtds        = 0     && Quantidade (qtds)
    this_cContafs     = ""    && Conta (Contafs)
    this_cGrupofs     = ""    && Grupo (Grupofs)
    this_cCretrabs    = ""    && Codigo do retrabalho (cRetrabs)
    this_nCoefs       = 0     && Valor do servico de retrabalho (Coefs)
    this_nCoefinfs    = 0     && Valor do servico informado (Coefinfs)
    this_lRetrabs     = .F.   && Flag de retrabalho (Retrabs)
    this_lOsRets      = .F.   && Flag de O.S. de retorno (OsRets)
    this_cCdescs      = ""    && Descricao do servico (cDescs)
    this_cGrupofins   = ""    && Grupo financeiro (GrupoFins)
    this_cMoedas      = ""    && Codigo da moeda (Moedas)

    *--------------------------------------------------------------------------
    * Contexto da operacao - cabecalho vindo de tmpnens (leitura apenas)
    *--------------------------------------------------------------------------
    this_nNumps       = 0     && Numero da operacao (tmpnens.numps)
    this_cEmps        = ""    && Empresa (tmpnens.emps)
    this_cDopps       = ""    && Descricao da operacao (tmpnens.dopps)

    *--------------------------------------------------------------------------
    * Estado de execucao
    *--------------------------------------------------------------------------
    this_cPcEscolha   = ""    && Modo atual: INSERIR / ALTERAR (herdado do form pai)
    this_nOptMov      = 1     && Opcao contas: 1=Movimentacao, 2=Cadastro

    *--------------------------------------------------------------------------
    * Dados do servico validado (populados apos busca em crSigCdSvc)
    *--------------------------------------------------------------------------
    this_nCoefSvc     = 0     && Coeficiente do servico (crSigCdSvc.Coefs)
    this_nCoefRetr    = 0     && Coeficiente de retrabalho (crSigCdSvc.CoefRetrs)
    this_cMoedSvc     = ""    && Moeda do servico (crSigCdSvc.CMoeds)
    this_cGruFinSvc   = ""    && Grupo financeiro do servico (crSigCdSvc.GruFins)

    *--------------------------------------------------------------------------
    * Descricao da categoria (populada apos CursorQuery em SigCdCat)
    *--------------------------------------------------------------------------
    this_cDescsCat    = ""

    *--------------------------------------------------------------------------
    * Ultimo valor conhecido do campo Categoria para controle de alteracao
    *--------------------------------------------------------------------------
    this_cAntValueCats = ""

    *--------------------------------------------------------------------------
    * Init - Inicializa o Business Object de Pagamento de Servicos
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        this_cTabela     = "xNensiS"
        this_cCampoChave = "Nenvs"
        RETURN DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Mapeia colunas do cursor xNensiS para propriedades BO
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lRet, loc_oErro
        loc_lRet = .F.

        TRY
            IF USED(par_cAliasCursor) AND !EOF(par_cAliasCursor)
                SELECT (par_cAliasCursor)
                this_nNenvs     = NVL(Nenvs, 0)
                this_cCats      = ALLTRIM(NVL(Cats, ""))
                this_nFators    = NVL(Fators, 0)
                this_nQtds      = NVL(Qtds, 0)
                this_cContafs   = ALLTRIM(NVL(Contafs, ""))
                this_cGrupofs   = ALLTRIM(NVL(Grupofs, ""))
                this_cCretrabs  = ALLTRIM(NVL(cRetrabs, ""))
                this_nCoefs     = NVL(Coefs, 0)
                this_nCoefinfs  = NVL(Coefinfs, 0)
                IF VARTYPE(Retrabs) = "L"
                    this_lRetrabs = NVL(Retrabs, .F.)
                ELSE
                    this_lRetrabs = IIF(NVL(Retrabs, 0) = 1, .T., .F.)
                ENDIF
                IF VARTYPE(OsRets) = "L"
                    this_lOsRets = NVL(OsRets, .F.)
                ELSE
                    this_lOsRets = IIF(NVL(OsRets, 0) = 1, .T., .F.)
                ENDIF
                this_cCdescs    = ALLTRIM(NVL(cDescs, ""))
                this_cGrupofins = ALLTRIM(NVL(GrupoFins, ""))
                this_cMoedas    = ALLTRIM(NVL(Moedas, ""))
                loc_lRet = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro em CarregarDoCursor")
        ENDTRY

        RETURN loc_lRet
    ENDPROC

    *--------------------------------------------------------------------------
    * GravarItens - Valida e atualiza dados de servico nos itens do pagamento
    * Equivalente ao Gravacat() do legado
    * par_lChkCoef: .T. = verificar coeficiente (retorna .F. se nao encontrado)
    *               .F. = sempre retornar .T.
    *--------------------------------------------------------------------------
    PROCEDURE GravarItens(par_lChkCoef)
        LOCAL loc_lRet, loc_nRecno, loc_nFatorRetr, loc_lSucesso, loc_oErro

        loc_lRet     = .T.
        loc_lSucesso = .T.

        TRY
            IF INLIST(this_cPcEscolha, "INSERIR", "ALTERAR")
                SELECT xNensiS
                loc_nRecno = RECNO()

                SCAN
                    IF !EMPTY(ALLTRIM(xNensiS.Cats))
                        *-- Validar servico e carregar dados de preco
                        IF THIS.ValidarServico(xNensiS.Cats, xNensiS.GrupoFs, xNensiS.ContaFs)
                            *-- Buscar descricao da categoria via SQL
                            THIS.BuscarDescricaoCategoria(ALLTRIM(xNensiS.Cats))

                            *-- Atualizar valores no cursor com dados do servico
                            SELECT xNensiS
                            REPLACE Fators    WITH this_nCoefSvc, ;
                                    Coefs     WITH this_nCoefRetr, ;
                                    Moedas    WITH this_cMoedSvc, ;
                                    GrupoFins WITH this_cGruFinSvc, ;
                                    cDescs    WITH this_cDescsCat

                            *-- Se tem retrabalho, recalcular Coefs = servico * fator_retrabalho
                            IF !EMPTY(ALLTRIM(xNensiS.cRetrabs))
                                loc_nFatorRetr = THIS.BuscarFatorRetrabalho(ALLTRIM(xNensiS.cRetrabs))
                                IF loc_nFatorRetr > 0
                                    REPLACE Coefs WITH this_nCoefSvc * loc_nFatorRetr IN xNensiS
                                ENDIF
                            ENDIF
                        ELSE
                            loc_lRet = .F.
                        ENDIF
                    ENDIF
                ENDSCAN

                SELECT xNensiS
                IF loc_nRecno > 0
                    GO loc_nRecno
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro em GravarItens")
            loc_lSucesso = .F.
        ENDTRY

        IF par_lChkCoef
            RETURN loc_lRet AND loc_lSucesso
        ELSE
            RETURN .T.
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarServico - Valida servico em SigCdSvc e carrega dados de preco
    * Retorna .T. se servico encontrado, .F. se nao encontrado
    * Prioridade: exato (cats+grupo+conta) > grupo+sem conta > so categoria
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ValidarServico(par_cCats, par_cGrupoFs, par_cContaFs)
        LOCAL loc_lEncontrado, loc_nWa, loc_oErro

        loc_lEncontrado = .F.
        this_nCoefSvc   = 0
        this_nCoefRetr  = 0
        this_cMoedSvc   = ""
        this_cGruFinSvc = ""

        TRY
            IF USED("crSigCdSvc")
                loc_nWa = SELECT()
                SELECT crSigCdSvc
                SET ORDER TO CaGruCo
                DO CASE
                CASE SEEK(par_cCats + par_cGrupoFs + par_cContaFs)
                    loc_lEncontrado = .T.
                CASE SEEK(par_cCats + par_cGrupoFs + SPACE(10))
                    loc_lEncontrado = .T.
                CASE SEEK(par_cCats + SPACE(20))
                    loc_lEncontrado = .T.
                ENDCASE
                IF loc_lEncontrado
                    this_nCoefSvc   = NVL(crSigCdSvc.Coefs, 0)
                    this_nCoefRetr  = NVL(crSigCdSvc.CoefRetrs, 0)
                    this_cMoedSvc   = ALLTRIM(NVL(crSigCdSvc.CMoeds, ""))
                    this_cGruFinSvc = ALLTRIM(NVL(crSigCdSvc.GruFins, ""))
                ENDIF
                SELECT (loc_nWa)
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro em ValidarServico")
        ENDTRY

        RETURN loc_lEncontrado
    ENDPROC

    *--------------------------------------------------------------------------
    * BuscarDescricaoCategoria - Busca descricao da categoria em SigCdCat
    * Popula this_cDescsCat com Desc2s
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE BuscarDescricaoCategoria(par_cCodCat)
        LOCAL loc_cSQL, loc_nResult, loc_oErro

        this_cDescsCat = ""

        TRY
            loc_cSQL = "SELECT Desc2s FROM SigCdCat WHERE Cods = " + EscaparSQL(par_cCodCat)

            IF USED("cursor_4c_Cat")
                USE IN cursor_4c_Cat
            ENDIF

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Cat")

            IF loc_nResult > 0 AND !EOF("cursor_4c_Cat")
                SELECT cursor_4c_Cat
                this_cDescsCat = ALLTRIM(NVL(Desc2s, ""))
            ENDIF

            IF USED("cursor_4c_Cat")
                USE IN cursor_4c_Cat
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro em BuscarDescricaoCategoria")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BuscarFatorRetrabalho - Busca fator de multiplicacao em SigPrCrt
    * Retorna Fators do retrabalho para calcular Coefs = servico * fator
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION BuscarFatorRetrabalho(par_cCodRetrab)
        LOCAL loc_cSQL, loc_nResult, loc_nFator, loc_oErro

        loc_nFator = 0

        TRY
            loc_cSQL = "SELECT Fators FROM SigPrCrt " + ;
                       "WHERE Cods = " + EscaparSQL(par_cCodRetrab) + ;
                       "  AND (Emps = " + EscaparSQL(go_4c_Sistema.cCodEmpresa) + ;
                       "  OR LTRIM(RTRIM(Emps)) = '')"

            IF USED("cursor_4c_Retr")
                USE IN cursor_4c_Retr
            ENDIF

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Retr")

            IF loc_nResult > 0 AND !EOF("cursor_4c_Retr")
                SELECT cursor_4c_Retr
                loc_nFator = NVL(Fators, 0)
            ENDIF

            IF USED("cursor_4c_Retr")
                USE IN cursor_4c_Retr
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro em BuscarFatorRetrabalho")
        ENDTRY

        RETURN loc_nFator
    ENDFUNC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Retorna chave primaria do registro atual de xNensiS
    *--------------------------------------------------------------------------
    FUNCTION ObterChavePrimaria()
        IF USED("xNensiS") AND !EOF("xNensiS")
            SELECT xNensiS
            RETURN TRANSFORM(xNensiS.Nenvs)
        ENDIF
        RETURN ""
    ENDFUNC

ENDDEFINE


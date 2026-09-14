# CODE REVIEW - PASS SQL: SQL Validation (colunas, tabelas, aspas, filtros)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **SQL Validation (colunas, tabelas, aspas, filtros)**.

## PROBLEMAS DETECTADOS (1)
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'DESCS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: ESPECIENFS, ESPECIES

## INSTRUCOES DE CORRECAO
### Foco deste pass: CORRECOES SQL
- [GRID-SQL] Campos no ControlSource que nao existem no CREATE CURSOR/SELECT
- [SQL-COLUNA] Nomes de colunas que NAO existem na tabela (validado contra banco real)
  - A mensagem mostra colunas VALIDAS - usar nome EXATO
  - Se sugere "voce quis dizer 'X'?", usar X
- [SQL-TABELA] Tabela inventada que nao existe no original
- [SQL-ASPAS] Aspas duplicadas ou concatenacao sem EscaparSQL
  - EscaparSQL() JA retorna com aspas. FormatarDataSQL() idem.
- [SQL-FILTRO-INVENTADO] Condicao WHERE inventada pela LLM - REMOVER
- [TRANSACAO-AVULSA] COMMIT/ROLLBACK sem BEGIN TRANSACTION - REMOVER

## REGRAS OBRIGATORIAS
- Corrigir APENAS os problemas listados, NAO alterar logica de negocio
- NAO remover campos, funcionalidades ou lookups
- **PROIBIDO alterar propriedades visuais** (Width, Height, Top, Left, BackColor, ForeColor, FontName, FontSize) EXCETO se o problema eh especificamente de ALINHAMENTO
- NUNCA juntar linhas com `;` numa linha unica
- Usar Write tool para salvar os arquivos corrigidos nos mesmos caminhos

### LINHAS SQL/CONTROLSOURCE DO CODIGO ORIGINAL (referencia):
  ControlSource = "crSigCdEsp.Especies"
  ControlSource = "crSigCdEsp.Descs"
  ControlSource = "crSigCdEsp.Provs"
  ControlSource = "crSigCdEsp.Obrigs"
			lcQuery = [Select cIdChaves ] + ;
					    [From SigMvCcr ] + ;
			If (ThisForm.poDataMgr.SqlExecute(lcQuery, [LocalBus]) < 1)
			Select LocalBus
			lcQuery = [Select Dopes ] + ;
					    [From SigCdOpe ] + ;
			If (ThisForm.poDataMgr.SqlExecute(lcQuery, [LocalBus]) < 1)
			Select LocalBus
Select crSigCdEsp
Select crSigCdEsp

## CODIGO ATUAL DOS ARQUIVOS

### FORM (C:\4c\projeto\app\forms\cadastros\FormEsp.prg) - TRECHOS RELEVANTES PARA PASS SQL (1093 linhas total):

*-- Linhas 355 a 373:
355:             .HighlightBackColor = RGB(255, 255, 255)
356:             .HighlightForeColor = RGB(15, 41, 104)
357:             .HighlightStyle     = 2
358:             .DeleteMark         = .F.
359:             .RecordMark         = .F.
360:             .RowHeight          = 16
361:             .ScrollBars         = 2
362:             .Visible            = .T.
363:         ENDWITH
364: 
365:         THIS.TornarControlesVisiveis(loc_oPagina)
366:     ENDPROC
367: 
368:     *==========================================================================
369:     * ConfigurarPaginaDados - Configura Page2: botoes + campos (Fases 5-6)
370:     * Legado: Grupo_Salva.Left=836, Top=-6, Width=161, Height=85
371:     * Compensacao PageFrame: +29 em todos os Tops
372:     *==========================================================================
373:     PROTECTED PROCEDURE ConfigurarPaginaDados()

*-- Linhas 457 a 475:
457:         ENDWITH
458: 
459:         *-- TextBox Codigo (getCodigo: Top=133, Left=323, Width=52; compensado Top=162)
460:         *-- Format=K! (uppercase+select), MaxLength=6, SpecialEffect=1 (flat border)
461:         loc_oPagina.AddObject("txt_4c_Codigo", "TextBox")
462:         WITH loc_oPagina.txt_4c_Codigo
463:             .Value         = ""
464:             .Top           = 162
465:             .Left          = 323
466:             .Width         = 52
467:             .Height        = 23
468:             .MaxLength     = 6
469:             .Format        = "K!"
470:             .SpecialEffect = 1
471:             .FontName      = "Tahoma"
472:             .FontSize      = 8
473:             .ForeColor     = RGB(0, 0, 0)
474:             .Enabled       = .F.
475:             .Visible       = .T.

*-- Linhas 493 a 511:
493:         ENDWITH
494: 
495:         *-- TextBox Descricao (getDescs: Top=158, Left=323, Width=290, Height=25; compensado Top=187)
496:         *-- Format=K! (uppercase+select), MaxLength=40, SpecialEffect=1
497:         loc_oPagina.AddObject("txt_4c_Descricao", "TextBox")
498:         WITH loc_oPagina.txt_4c_Descricao
499:             .Value         = ""
500:             .Top           = 187
501:             .Left          = 323
502:             .Width         = 290
503:             .Height        = 25
504:             .MaxLength     = 40
505:             .Format        = "K!"
506:             .SpecialEffect = 1
507:             .FontName      = "Tahoma"
508:             .FontSize      = 8
509:             .ForeColor     = RGB(0, 0, 0)
510:             .Enabled       = .F.
511:             .Visible       = .T.

*-- Linhas 529 a 547:
529:         ENDWITH
530: 
531:         *-- OptionGroup Provs (optProvs: Top=185, Left=319; compensado Top=214)
532:         *-- ControlSource=crSigCdEsp.Provs; Option1=Com Provisao(Left=5), Option2=Sem Provisao(Left=110)
533:         loc_oPagina.AddObject("opt_4c_OptProvs", "OptionGroup")
534:         WITH loc_oPagina.opt_4c_OptProvs
535:             .ButtonCount = 2
536:             .Top         = 214
537:             .Left        = 319
538:             .AutoSize    = .T.
539:             .BackStyle   = 0
540:             .BorderStyle = 0
541:             .Enabled     = .F.
542:             .Visible     = .T.
543:             WITH .Buttons(1)
544:                 .Caption   = "Com Provis" + CHR(227) + "o"
545:                 .Left      = 5
546:                 .Top       = 5
547:                 .AutoSize  = .T.

*-- Linhas 578 a 596:
578:         ENDWITH
579: 
580:         *-- OptionGroup Obrigs (OptObrigs: Top=209, Left=319; compensado Top=238)
581:         *-- ControlSource=crSigCdEsp.Obrigs; Option1=Sim(Left=5), Option2=Nao(Left=58)
582:         loc_oPagina.AddObject("opt_4c_OptObrigs", "OptionGroup")
583:         WITH loc_oPagina.opt_4c_OptObrigs
584:             .ButtonCount = 2
585:             .Top         = 238
586:             .Left        = 319
587:             .AutoSize    = .T.
588:             .BackStyle   = 0
589:             .BorderStyle = 0
590:             .Enabled     = .F.
591:             .Visible     = .T.
592:             WITH .Buttons(1)
593:                 .Caption   = "Sim"
594:                 .Left      = 5
595:                 .Top       = 5
596:                 .AutoSize  = .T.

*-- Linhas 629 a 648:
629:                     loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Lista
630:                     loc_oGrid.ColumnCount = 2
631:                     loc_oGrid.RecordSource             = "cursor_4c_Dados"
632:                     loc_oGrid.Column1.ControlSource    = "cursor_4c_Dados.especies"
633:                     loc_oGrid.Column2.ControlSource    = "cursor_4c_Dados.descs"
634:                     loc_oGrid.Column1.Width            = 150
635:                     loc_oGrid.Column2.Width            = 290
636:                     loc_oGrid.Column1.Header1.Caption  = "Esp" + CHR(233) + "cie"
637:                     loc_oGrid.Column2.Header1.Caption  = "Descri" + CHR(231) + CHR(227) + "o"
638:                     THIS.FormatarGridLista(loc_oGrid)
639:                     loc_lResultado = .T.
640:                 ENDIF
641:             ENDIF
642:         CATCH TO loc_oErro
643:             MsgErro("Erro em CarregarLista:" + CHR(13) + loc_oErro.Message, "Erro")
644:             loc_lResultado = .F.
645:         ENDTRY
646: 
647:         RETURN loc_lResultado
648:     ENDPROC

*-- Linhas 718 a 736:
718:         ENDIF
719: 
720:         TRY
721:             SELECT cursor_4c_Dados
722:             loc_cCodigo = ALLTRIM(cursor_4c_Dados.especies)
723: 
724:             IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
725:                 THIS.this_cModoAtual = "VISUALIZAR"
726:                 THIS.BOParaForm()
727:                 THIS.HabilitarCampos(.F.)
728:                 THIS.AlternarPagina(2)
729:                 loc_lResultado = .T.
730:             ELSE
731:                 MsgAviso("Registro n" + CHR(227) + "o encontrado.", ;
732:                          "Aten" + CHR(231) + CHR(227) + "o")
733:             ENDIF
734:         CATCH TO loc_oErro
735:             MsgErro("Erro em BtnVisualizarClick:" + CHR(13) + loc_oErro.Message, "Erro")
736:         ENDTRY

*-- Linhas 753 a 771:
753:         ENDIF
754: 
755:         TRY
756:             SELECT cursor_4c_Dados
757:             loc_cCodigo = ALLTRIM(cursor_4c_Dados.especies)
758: 
759:             IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
760:                 THIS.this_oBusinessObject.EditarRegistro()
761:                 THIS.this_cModoAtual = "ALTERAR"
762:                 THIS.BOParaForm()
763:                 THIS.HabilitarCampos(.T.)
764:                 THIS.AlternarPagina(2)
765:                 loc_lResultado = .T.
766:             ELSE
767:                 MsgAviso("Registro n" + CHR(227) + "o encontrado.", ;
768:                          "Aten" + CHR(231) + CHR(227) + "o")
769:             ENDIF
770:         CATCH TO loc_oErro
771:             MsgErro("Erro em BtnAlterarClick:" + CHR(13) + loc_oErro.Message, "Erro")

*-- Linhas 787 a 805:
787:             RETURN .F.
788:         ENDIF
789: 
790:         SELECT cursor_4c_Dados
791:         loc_cCodigo = ALLTRIM(cursor_4c_Dados.especies)
792: 
793:         IF !MsgConfirma("Confirma a exclus" + CHR(227) + "o da esp" + CHR(233) + ;
794:                         "cie '" + loc_cCodigo + "'?", ;
795:                         "Confirmar Exclus" + CHR(227) + "o")
796:             RETURN .F.
797:         ENDIF
798: 
799:         loc_lResultado = .F.
800: 
801:         TRY
802:             IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
803:                 IF THIS.this_oBusinessObject.Excluir()
804:                     MsgInfo("Registro exclu" + CHR(237) + "do com sucesso!", "Sucesso")
805:                     THIS.CarregarLista()

*-- Linhas 877 a 895:
877: 
878:     *==========================================================================
879:     * FormParaBO - Transfere valores dos campos do Form para o BO
880:     * Legado: ChkRegister le do cursor crSigCdEsp via ControlSource
881:     *==========================================================================
882:     PROTECTED PROCEDURE FormParaBO()
883:         LOCAL loc_oPagina
884:         loc_oPagina = THIS.pgf_4c_Paginas.Page2
885: 
886:         TRY
887:             IF PEMSTATUS(loc_oPagina, "txt_4c_Codigo", 5)
888:                 THIS.this_oBusinessObject.this_cEspecies = ;
889:                     ALLTRIM(loc_oPagina.txt_4c_Codigo.Value)
890:             ENDIF
891: 
892:             IF PEMSTATUS(loc_oPagina, "txt_4c_Descricao", 5)
893:                 THIS.this_oBusinessObject.this_cDescs = ;
894:                     ALLTRIM(loc_oPagina.txt_4c_Descricao.Value)
895:             ENDIF


### BO (C:\4c\projeto\app\classes\EspBO.prg):
*==============================================================================
* EspBO.prg - Business Object para Cadastro de Especies
* Tabela: SigCdEsp
* Herda de: BusinessBase
*==============================================================================
DEFINE CLASS EspBO AS BusinessBase

    *-- Propriedades de configuracao da tabela
    this_cTabela      = "SigCdEsp"
    this_cCampoChave  = "especies"

    *-- Propriedades de dados (mapeiam colunas de SigCdEsp)
    this_cEspecies    = ""    && char(6) - PK
    this_cDescs       = ""    && char(40)
    this_nProvs       = 1     && numeric(1,0) - 1=Com Provisao, 2=Sem Provisao
    this_nObrigs      = 1     && numeric(1,0) - 1=Sim, 2=Nao

    *--------------------------------------------------------------------------
    * Init - Configura tabela e campo chave
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        DODEFAULT()
        THIS.this_cTabela     = "SigCdEsp"
        THIS.this_cCampoChave = "especies"
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Retorna PK para auditoria
    *--------------------------------------------------------------------------
    FUNCTION ObterChavePrimaria()
        RETURN THIS.this_cEspecies
    ENDFUNC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Carrega propriedades do BO a partir de um cursor
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lResultado
        loc_lResultado = .F.

        IF USED(par_cAliasCursor)
            SELECT (par_cAliasCursor)
            THIS.this_cEspecies = TratarNulo(especies, "C")
            THIS.this_cDescs    = TratarNulo(descs,    "C")
            THIS.this_nProvs    = TratarNulo(provs,    "N")
            THIS.this_nObrigs   = TratarNulo(obrigs,   "N")
            loc_lResultado = .T.
        ENDIF

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * Buscar - Carrega lista de registros em cursor_4c_Dados
    *--------------------------------------------------------------------------
    FUNCTION Buscar(par_cFiltro)
        LOCAL loc_cSQL, loc_nResultado, loc_lResultado
        loc_lResultado = .F.

        TRY
            loc_cSQL = "SELECT especies, descs, provs, obrigs" + ;
                       " FROM SigCdEsp" + ;
                       " ORDER BY especies"

            IF !EMPTY(par_cFiltro)
                loc_cSQL = "SELECT especies, descs, provs, obrigs" + ;
                           " FROM SigCdEsp" + ;
                           " WHERE especies LIKE " + EscaparSQL(par_cFiltro + "%") + ;
                           " OR descs LIKE " + EscaparSQL("%" + par_cFiltro + "%") + ;
                           " ORDER BY especies"
            ENDIF

            *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
            IF USED("cursor_4c_Dados")
                TABLEREVERT(.T., "cursor_4c_Dados")
                USE IN cursor_4c_Dados
            ENDIF

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")

            IF loc_nResultado > 0
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao buscar esp" + CHR(233) + "cies:" + CHR(13) + ;
                        CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em Buscar:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDFUNC

    *--------------------------------------------------------------------------
    * CarregarPorCodigo - Carrega um registro pelo codigo da especie
    *--------------------------------------------------------------------------
    FUNCTION CarregarPorCodigo(par_cCodigo)
        LOCAL loc_cSQL, loc_nResultado, loc_lResultado
        loc_lResultado = .F.

        TRY
            loc_cSQL = "SELECT especies, descs, provs, obrigs" + ;
                       " FROM SigCdEsp" + ;
                       " WHERE especies = " + EscaparSQL(par_cCodigo)

            *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
            IF USED("cursor_4c_Carrega")
                TABLEREVERT(.T., "cursor_4c_Carrega")
                USE IN cursor_4c_Carrega
            ENDIF

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")

            IF loc_nResultado > 0 AND RECCOUNT("cursor_4c_Carrega") > 0
                loc_lResultado = THIS.CarregarDoCursor("cursor_4c_Carrega")
                THIS.this_lNovoRegistro = .F.
            ENDIF

            IF USED("cursor_4c_Carrega")
                USE IN cursor_4c_Carrega
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em CarregarPorCodigo:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDFUNC

    *--------------------------------------------------------------------------
    * Inserir - INSERT na tabela SigCdEsp (PROTECTED - chamado por Salvar)
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION Inserir()
        LOCAL loc_cSQL, loc_nResultado, loc_lResultado
        loc_lResultado = .F.

        TRY
            loc_cSQL = "INSERT INTO SigCdEsp (especies, descs, provs, obrigs)" + ;
                       " VALUES (" + ;
                       EscaparSQL(THIS.this_cEspecies) + ", " + ;
                       EscaparSQL(THIS.this_cDescs)    + ", " + ;
                       FormatarNumeroSQL(THIS.this_nProvs) + ", " + ;
                       FormatarNumeroSQL(THIS.this_nObrigs) + ;
                       ")"

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado > 0
                THIS.RegistrarAuditoria("INSERT")
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao inserir esp" + CHR(233) + "cie:" + CHR(13) + ;
                        CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em Inserir:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDFUNC

    *--------------------------------------------------------------------------
    * Atualizar - UPDATE na tabela SigCdEsp (PROTECTED - chamado por Salvar)
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION Atualizar()
        LOCAL loc_cSQL, loc_nResultado, loc_lResultado
        loc_lResultado = .F.

        TRY
            loc_cSQL = "UPDATE SigCdEsp SET" + ;
                       " descs  = " + EscaparSQL(THIS.this_cDescs)          + ", " + ;
                       " provs  = " + FormatarNumeroSQL(THIS.this_nProvs)   + ", " + ;
                       " obrigs = " + FormatarNumeroSQL(THIS.this_nObrigs)  + ;
                       " WHERE especies = " + EscaparSQL(THIS.this_cEspecies)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado > 0
                THIS.RegistrarAuditoria("UPDATE")
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao atualizar esp" + CHR(233) + "cie:" + CHR(13) + ;
                        CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em Atualizar:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDFUNC

    *--------------------------------------------------------------------------
    * ExecutarExclusao - DELETE na tabela SigCdEsp (PROTECTED - chamado por Excluir)
    * Valida uso em SigMvCcr (EspecieNfs) e SigCdOpe (Especies) antes de excluir
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION ExecutarExclusao()
        LOCAL loc_cSQL, loc_nResultado, loc_lResultado
        loc_lResultado = .F.

        TRY
            *-- Verificar uso em SigMvCcr
            loc_cSQL = "SELECT TOP 1 cIdChaves FROM SigMvCcr" + ;
                       " WHERE EspecieNfs = " + EscaparSQL(THIS.this_cEspecies)
            *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
            IF USED("cursor_4c_ChkMvCcr")
                TABLEREVERT(.T., "cursor_4c_ChkMvCcr")
                USE IN cursor_4c_ChkMvCcr
            ENDIF

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ChkMvCcr")

            IF loc_nResultado > 0 AND RECCOUNT("cursor_4c_ChkMvCcr") > 0
                MsgAviso("A Esp" + CHR(233) + "cie Est" + CHR(225) + " Em Uso Nos T" + ;
                         CHR(237) + "tulos e N" + CHR(227) + "o Pode Ser Exclu" + ;
                         CHR(237) + "da!!!", "Aten" + CHR(231) + CHR(227) + "o")
            ELSE
                *-- Verificar uso em SigCdOpe
                loc_cSQL = "SELECT TOP 1 Dopes FROM SigCdOpe" + ;
                           " WHERE Especies = " + EscaparSQL(THIS.this_cEspecies)
                *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
                IF USED("cursor_4c_ChkOpe")
                    TABLEREVERT(.T., "cursor_4c_ChkOpe")
                    USE IN cursor_4c_ChkOpe
                ENDIF

                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ChkOpe")

                IF loc_nResultado > 0 AND RECCOUNT("cursor_4c_ChkOpe") > 0
                    SELECT cursor_4c_ChkOpe
                    GO TOP
                    MsgAviso("A Esp" + CHR(233) + "cie Est" + CHR(225) + " Em Uso Na Opera" + ;
                             CHR(231) + CHR(227) + "o " + CHR(34) + ;
                             ALLTRIM(cursor_4c_ChkOpe.Dopes) + CHR(34) + ;
                             " e N" + CHR(227) + "o Pode Ser Exclu" + CHR(237) + "da!!!", ;
                             "Aten" + CHR(231) + CHR(227) + "o")
                ELSE
                    *-- Sem dependencias - executar exclusao
                    loc_cSQL = "DELETE FROM SigCdEsp" + ;
                               " WHERE especies = " + EscaparSQL(THIS.this_cEspecies)
                    loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

                    IF loc_nResultado > 0
                        THIS.RegistrarAuditoria("DELETE")
                        loc_lResultado = .T.
                    ELSE
                        MsgErro("Erro ao excluir esp" + CHR(233) + "cie:" + CHR(13) + ;
                                CapturarErroSQL(), "Erro SQL")
                    ENDIF
                ENDIF

                IF USED("cursor_4c_ChkOpe")
                    USE IN cursor_4c_ChkOpe
                ENDIF
            ENDIF

            IF USED("cursor_4c_ChkMvCcr")
                USE IN cursor_4c_ChkMvCcr
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em ExecutarExclusao:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDFUNC

    *--------------------------------------------------------------------------
    * Validar - Valida dados antes de salvar
    *--------------------------------------------------------------------------
    FUNCTION Validar()
        LOCAL loc_lResultado
        loc_lResultado = .T.

        IF EMPTY(ALLTRIM(THIS.this_cEspecies))
            MsgAviso("C" + CHR(243) + "digo Inv" + CHR(225) + "lido!!!", ;
                     "Aten" + CHR(231) + CHR(227) + "o")
            loc_lResultado = .F.
        ENDIF

        IF loc_lResultado AND EMPTY(ALLTRIM(THIS.this_cDescs))
            MsgAviso("Descri" + CHR(231) + CHR(227) + "o Inv" + CHR(225) + "lida!!!", ;
                     "Aten" + CHR(231) + CHR(227) + "o")
            loc_lResultado = .F.
        ENDIF

        IF loc_lResultado AND THIS.this_nProvs = 0
            MsgAviso("Integra" + CHR(231) + CHR(227) + "o Cont" + CHR(225) + ;
                     "bil Inv" + CHR(225) + "lida!!!", ;
                     "Aten" + CHR(231) + CHR(227) + "o")
            loc_lResultado = .F.
        ENDIF

        RETURN loc_lResultado
    ENDFUNC

    *--------------------------------------------------------------------------
    * VerificarDuplicidade - Verifica se codigo ja existe (para INSERT)
    *--------------------------------------------------------------------------
    FUNCTION VerificarDuplicidade()
        LOCAL loc_cSQL, loc_nResultado, loc_lExiste
        loc_lExiste = .F.

        TRY
            loc_cSQL = "SELECT TOP 1 especies FROM SigCdEsp" + ;
                       " WHERE especies = " + EscaparSQL(THIS.this_cEspecies)
            *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
            IF USED("cursor_4c_ChkDup")
                TABLEREVERT(.T., "cursor_4c_ChkDup")
                USE IN cursor_4c_ChkDup
            ENDIF

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ChkDup")

            IF loc_nResultado > 0 AND RECCOUNT("cursor_4c_ChkDup") > 0
                loc_lExiste = .T.
                MsgAviso("C" + CHR(243) + "digo J" + CHR(225) + " Cadastrado!!!", ;
                         "Aten" + CHR(231) + CHR(227) + "o")
            ENDIF

            IF USED("cursor_4c_ChkDup")
                USE IN cursor_4c_ChkDup
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em VerificarDuplicidade:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lExiste
    ENDFUNC

ENDDEFINE


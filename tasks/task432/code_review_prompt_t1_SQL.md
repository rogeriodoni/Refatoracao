# CODE REVIEW - PASS SQL: SQL Validation (colunas, tabelas, aspas, filtros)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **SQL Validation (colunas, tabelas, aspas, filtros)**.

## PROBLEMAS DETECTADOS (1)
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'CIDCHAVES' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: GRUCARTITS

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
  ControlSource = "crSigCdFtr.Resps"
  ControlSource = "crSigCdFtr.nResps"
lcQryCFTeR = [Select * From SigCdFtr Where GruCarTits = ?pKey Order By cIdChaves]
		ThisForm.Pagina.Lista.Grade.Column2.ControlSource = [Iif(crSigCdFtr.nResps = 1, 'Sim', 'Não')] 
Select crSigCdFtr

## CODIGO ATUAL DOS ARQUIVOS

### FORM (C:\4c\projeto\app\forms\cadastros\FormFte.prg) - TRECHOS RELEVANTES PARA PASS SQL (1029 linhas total):

*-- Linhas 487 a 505:
487:             .HighlightBackColor = RGB(255, 255, 255)
488:             .HighlightForeColor = RGB(15, 41, 104)
489:             .HighlightStyle     = 2
490:             .DeleteMark         = .F.
491:             .RecordMark         = .F.
492:             .RowHeight          = 16
493:             .ScrollBars         = 2
494:             .Column1.Header1.Caption = "Respostas"
495:             .Column1.Alignment       = 0
496:             .Column2.Header1.Caption = "Fixa"
497:             .Column2.Alignment       = 2
498:             .Visible            = .T.
499:         ENDWITH
500: 
501:         THIS.TornarControlesVisiveis(loc_oPg1)
502:     ENDPROC
503: 
504:     *==========================================================================
505:     * CarregarLista - Busca fichas tecnicas do contexto e vincula ao Grid

*-- Linhas 524 a 546:
524:                 loc_oGrid.RecordSource = "cursor_4c_Dados"
525: 
526:                 WITH loc_oGrid
527:                     .Column1.ControlSource   = "cursor_4c_Dados.Resps"
528:                     .Column1.Width           = 795
529:                     .Column1.Header1.Caption = "Respostas"
530:                     .Column1.Alignment       = 0
531:                     .Column2.ControlSource   = "IIF(cursor_4c_Dados.nResps=1,'Sim','N" + CHR(227) + "o')"
532:                     .Column2.Width           = 75
533:                     .Column2.Header1.Caption = "Fixa"
534:                     .Column2.Alignment       = 2
535:                 ENDWITH
536: 
537:                 THIS.FormatarGridLista(loc_oGrid)
538:                 loc_oGrid.Refresh()
539:                 loc_lResultado = .T.
540:             ENDIF
541: 
542:         CATCH TO loException
543:             MsgErro("Erro em CarregarLista:" + CHR(13) + loException.Message + ;
544:                     CHR(13) + "Linha: " + TRANSFORM(loException.LineNo), "Erro")
545:         ENDTRY
546: 

*-- Linhas 697 a 715:
697:             RETURN
698:         ENDIF
699: 
700:         SELECT cursor_4c_Dados
701:         loc_cIdChave = ALLTRIM(cursor_4c_Dados.cIdChaves)
702: 
703:         IF EMPTY(loc_cIdChave)
704:             MsgAviso("Nenhum registro selecionado.", "Aviso")
705:             RETURN
706:         ENDIF
707: 
708:         IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cIdChave)
709:             THIS.this_cModoAtual = "VISUALIZAR"
710:             THIS.BOParaForm()
711:             THIS.HabilitarCampos(.F.)
712:             THIS.AjustarBotoesPorModo()
713:             THIS.AlternarPagina(2)
714:         ENDIF
715:     ENDPROC

*-- Linhas 729 a 747:
729:             RETURN
730:         ENDIF
731: 
732:         SELECT cursor_4c_Dados
733:         loc_cIdChave = ALLTRIM(cursor_4c_Dados.cIdChaves)
734: 
735:         IF EMPTY(loc_cIdChave)
736:             MsgAviso("Nenhum registro selecionado.", "Aviso")
737:             RETURN
738:         ENDIF
739: 
740:         IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cIdChave)
741:             THIS.this_oBusinessObject.EditarRegistro()
742:             THIS.this_cModoAtual = "ALTERAR"
743:             THIS.BOParaForm()
744:             THIS.HabilitarCampos(.T.)
745:             THIS.AjustarBotoesPorModo()
746:             THIS.AlternarPagina(2)
747:         ENDIF

*-- Linhas 762 a 780:
762:             RETURN
763:         ENDIF
764: 
765:         SELECT cursor_4c_Dados
766:         loc_cIdChave = ALLTRIM(cursor_4c_Dados.cIdChaves)
767: 
768:         IF EMPTY(loc_cIdChave)
769:             MsgAviso("Nenhum registro selecionado.", "Aviso")
770:             RETURN
771:         ENDIF
772: 
773:         IF MsgConfirma("Confirma a exclus" + CHR(227) + "o desta ficha t" + CHR(233) + "cnica?", ;
774:                        "Confirmar Exclus" + CHR(227) + "o")
775:             IF !THIS.this_oBusinessObject.CarregarPorCodigo(loc_cIdChave)
776:                 MsgErro("Erro ao carregar registro para exclus" + CHR(227) + "o.", "Erro")
777:                 RETURN
778:             ENDIF
779: 
780:             IF THIS.this_oBusinessObject.Excluir()


### BO (C:\4c\projeto\app\classes\FteBO.prg):
*==============================================================================
* FteBO.prg - Business Object para Fichas Tecnicas
* Tabela: SigCdFtr
* PK: cIdChaves
*==============================================================================
DEFINE CLASS FteBO AS BusinessBase

    *-- Chave primaria
    this_cIdChaves    = ""

    *-- Campos de contexto (filtro/PK composta)
    this_cCGrus       = ""    && CGrus - Grupo
    this_cSGrus       = ""    && SGrus - SubGrupo
    this_cCCars       = ""    && CCars - Cargo
    this_cCTits       = ""    && CTits - Titulo
    this_cGruCarTits  = ""    && GruCarTits - Chave composta (CGrus+CCars+CTits+SGrus)

    *-- Campos de conteudo
    this_cResps       = ""    && Resps - Texto da resposta (memo)
    this_nNResps      = 0     && nResps - Resposta Fixa (0=Nao, 1=Sim)

    *-- Contexto de abertura (parametros recebidos pelo form)
    this_cContextGrupos  = ""
    this_cContextSubGrp  = ""
    this_cContextCargos  = ""
    this_cContextTitulos = ""

    *--------------------------------------------------------------------------
    PROCEDURE Init()
    *--------------------------------------------------------------------------
        DODEFAULT()
        THIS.this_cTabela     = "SigCdFtr"
        THIS.this_cCampoChave = "cIdChaves"
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    PROCEDURE ObterChavePrimaria()
    *--------------------------------------------------------------------------
        RETURN THIS.this_cIdChaves
    ENDPROC

    *--------------------------------------------------------------------------
    * Buscar - SELECT filtrado pelo contexto (GruCarTits = CGrus+CCars+CTits+SGrus)
    *--------------------------------------------------------------------------
    FUNCTION Buscar(par_cFiltro)
        LOCAL loc_cSQL, loc_cChave, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cChave = THIS.this_cContextGrupos + THIS.this_cContextCargos + ;
                         THIS.this_cContextTitulos + THIS.this_cContextSubGrp

            loc_cSQL = "SELECT cIdChaves, CGrus, SGrus, CCars, CTits, GruCarTits," + ;
                       " Resps, nResps" + ;
                       " FROM SigCdFtr" + ;
                       " WHERE GruCarTits = " + EscaparSQL(loc_cChave)

            IF !EMPTY(ALLTRIM(par_cFiltro))
                loc_cSQL = loc_cSQL + " AND (" + par_cFiltro + ")"
            ENDIF

            loc_cSQL = loc_cSQL + " ORDER BY cIdChaves"

            *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
            IF USED("cursor_4c_Dados")
                TABLEREVERT(.T., "cursor_4c_Dados")
                USE IN cursor_4c_Dados
            ENDIF

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")

            IF loc_nResultado >= 0
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao buscar fichas t" + CHR(233) + "cnicas:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loException
            MsgErro("Erro em Buscar:" + CHR(13) + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * CarregarPorCodigo - Carrega registro por PK (cIdChaves)
    *--------------------------------------------------------------------------
    FUNCTION CarregarPorCodigo(par_cCodigo)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "SELECT cIdChaves, CGrus, SGrus, CCars, CTits, GruCarTits," + ;
                       " Resps, nResps" + ;
                       " FROM SigCdFtr" + ;
                       " WHERE cIdChaves = " + EscaparSQL(ALLTRIM(par_cCodigo))

            *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
            IF USED("cursor_4c_Carrega")
                TABLEREVERT(.T., "cursor_4c_Carrega")
                USE IN cursor_4c_Carrega
            ENDIF

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")

            IF loc_nResultado >= 0 AND RECCOUNT("cursor_4c_Carrega") > 0
                loc_lSucesso = THIS.CarregarDoCursor("cursor_4c_Carrega")
                THIS.this_lNovoRegistro = .F.
            ELSE
                IF loc_nResultado < 0
                    MsgErro("Erro ao carregar ficha t" + CHR(233) + "cnica:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                ENDIF
            ENDIF

            IF USED("cursor_4c_Carrega")
                USE IN cursor_4c_Carrega
            ENDIF
        CATCH TO loException
            MsgErro("Erro em CarregarPorCodigo:" + CHR(13) + loException.Message, "Erro")
            IF USED("cursor_4c_Carrega")
                USE IN cursor_4c_Carrega
            ENDIF
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Mapeia colunas do cursor para propriedades do BO
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        IF USED(par_cAliasCursor)
            SELECT (par_cAliasCursor)
            THIS.this_cIdChaves   = TratarNulo(cIdChaves,   "C")
            THIS.this_cCGrus      = TratarNulo(CGrus,        "C")
            THIS.this_cSGrus      = TratarNulo(SGrus,        "C")
            THIS.this_cCCars      = TratarNulo(CCars,        "C")
            THIS.this_cCTits      = TratarNulo(CTits,        "C")
            THIS.this_cGruCarTits = TratarNulo(GruCarTits,   "C")
            THIS.this_cResps      = TratarNulo(Resps,        "C")
            THIS.this_nNResps     = TratarNulo(nResps,       "N")
            loc_lSucesso = .T.
        ENDIF

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * Inserir - INSERT na tabela SigCdFtr (PROTECTED)
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION Inserir()
        LOCAL loc_cSQL, loc_cNovaChave, loc_nResId, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cNovaChave = ""
            loc_nResId = SQLEXEC(gnConnHandle, "SELECT CONVERT(varchar(36), NEWID()) AS NovaChave", "cursor_4c_NewId")
            IF loc_nResId >= 0 AND RECCOUNT("cursor_4c_NewId") > 0
                loc_cNovaChave = ALLTRIM(cursor_4c_NewId.NovaChave)
            ENDIF
            IF USED("cursor_4c_NewId")
                USE IN cursor_4c_NewId
            ENDIF

            IF EMPTY(loc_cNovaChave)
                MsgErro("Erro ao gerar chave prim" + CHR(225) + "ria.", "Erro")
            ELSE
                THIS.this_cIdChaves   = loc_cNovaChave
                THIS.this_cGruCarTits = THIS.this_cCGrus + THIS.this_cCCars + ;
                                        THIS.this_cCTits + THIS.this_cSGrus

                loc_cSQL = "INSERT INTO SigCdFtr" + ;
                           " (cIdChaves, CGrus, SGrus, CCars, CTits, GruCarTits, Resps, nResps)" + ;
                           " VALUES (" + ;
                           EscaparSQL(THIS.this_cIdChaves)   + ", " + ;
                           EscaparSQL(THIS.this_cCGrus)      + ", " + ;
                           EscaparSQL(THIS.this_cSGrus)      + ", " + ;
                           EscaparSQL(THIS.this_cCCars)      + ", " + ;
                           EscaparSQL(THIS.this_cCTits)      + ", " + ;
                           EscaparSQL(THIS.this_cGruCarTits) + ", " + ;
                           EscaparSQL(THIS.this_cResps)      + ", " + ;
                           FormatarNumeroSQL(THIS.this_nNResps) + ;
                           ")"

                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
                IF loc_nResultado >= 0
                    THIS.RegistrarAuditoria("INSERT")
                    loc_lSucesso = .T.
                ELSE
                    MsgErro("Erro ao inserir ficha t" + CHR(233) + "cnica:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                ENDIF
            ENDIF
        CATCH TO loException
            MsgErro("Erro em Inserir:" + CHR(13) + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * Atualizar - UPDATE na tabela SigCdFtr (PROTECTED)
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION Atualizar()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            THIS.this_cGruCarTits = THIS.this_cCGrus + THIS.this_cCCars + ;
                                    THIS.this_cCTits + THIS.this_cSGrus

            loc_cSQL = "UPDATE SigCdFtr SET" + ;
                       " CGrus = "      + EscaparSQL(THIS.this_cCGrus)      + "," + ;
                       " SGrus = "      + EscaparSQL(THIS.this_cSGrus)      + "," + ;
                       " CCars = "      + EscaparSQL(THIS.this_cCCars)      + "," + ;
                       " CTits = "      + EscaparSQL(THIS.this_cCTits)      + "," + ;
                       " GruCarTits = " + EscaparSQL(THIS.this_cGruCarTits) + "," + ;
                       " Resps = "      + EscaparSQL(THIS.this_cResps)      + "," + ;
                       " nResps = "     + FormatarNumeroSQL(THIS.this_nNResps) + ;
                       " WHERE cIdChaves = " + EscaparSQL(THIS.this_cIdChaves)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("UPDATE")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao atualizar ficha t" + CHR(233) + "cnica:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loException
            MsgErro("Erro em Atualizar:" + CHR(13) + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * ExecutarExclusao - DELETE na tabela SigCdFtr (PROTECTED)
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION ExecutarExclusao()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "DELETE FROM SigCdFtr" + ;
                       " WHERE cIdChaves = " + EscaparSQL(THIS.this_cIdChaves)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("DELETE")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao excluir ficha t" + CHR(233) + "cnica:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loException
            MsgErro("Erro em ExecutarExclusao:" + CHR(13) + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

ENDDEFINE


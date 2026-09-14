# CODE REVIEW - PASS SQL: SQL Validation (colunas, tabelas, aspas, filtros)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **SQL Validation (colunas, tabelas, aspas, filtros)**.

## PROBLEMAS DETECTADOS (1)
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'CIDCHAVES' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: CODS

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
  ControlSource = "crSigPrSer.Cods"
  ControlSource = "crSigPrSer.Descs"
  ControlSource = "crSigPrSer.qtDias"
		lcQuery = [Select Cods ] + ;
				    [From SigPrSer ] + ;
		If (ThisForm.poDataMgr.SqlExecute(lcQuery, [LocalBus]) < 1)

## CODIGO ATUAL DOS ARQUIVOS

### FORM (C:\4c\projeto\app\forms\cadastros\FormSER.prg) - TRECHOS RELEVANTES PARA PASS SQL (946 linhas total):

*-- Linhas 358 a 376:
358:             .HighlightBackColor = RGB(255, 255, 255)
359:             .HighlightForeColor = RGB(15, 41, 104)
360:             .HighlightStyle     = 2
361:             .DeleteMark         = .F.
362:             .RecordMark         = .F.
363:             .RowHeight          = 16
364:             .ScrollBars         = 2
365:             .GridLines          = 3
366:             .Visible            = .T.
367:         ENDWITH
368: 
369:         WITH loc_oGrid.Column1
370:             .Width     = 80
371:             .Alignment = 0
372:             .FontName  = "Tahoma"
373:             .FontSize  = 8
374:         ENDWITH
375:         loc_oGrid.Column1.Header1.Caption = "C" + CHR(243) + "digo"
376: 

*-- Linhas 605 a 628:
605:                 loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Lista
606: 
607:                 IF THIS.this_oBusinessObject.Buscar("")
608:                     *-- RecordSource ANTES de ControlSource (Problem #48)
609:                     loc_oGrid.ColumnCount = 2
610:                     loc_oGrid.RecordSource = "cursor_4c_Dados"
611:                     loc_oGrid.Column1.ControlSource = "cursor_4c_Dados.Cods"
612:                     loc_oGrid.Column2.ControlSource = "cursor_4c_Dados.Descs"
613:                     *-- Width e Headers APOS ControlSource (Problem #32)
614:                     loc_oGrid.Column1.Width = 80
615:                     loc_oGrid.Column2.Width = 200
616:                     loc_oGrid.Column1.Header1.Caption = "C" + CHR(243) + "digo"
617:                     loc_oGrid.Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
618:                     THIS.FormatarGridLista(loc_oGrid)
619:                     loc_lResultado = .T.
620:                 ENDIF
621:             ENDIF
622:         CATCH TO loc_oErro
623:             MsgErro("Erro:" + CHR(13) + loc_oErro.Message, "Erro")
624:             loc_lResultado = .F.
625:         ENDTRY
626: 
627:         RETURN loc_lResultado
628:     ENDPROC

*-- Linhas 771 a 789:
771:             RETURN
772:         ENDIF
773: 
774:         SELECT cursor_4c_Dados
775:         loc_cChave = ALLTRIM(cursor_4c_Dados.Cods)
776: 
777:         IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cChave)
778:             THIS.BOParaForm()
779:             THIS.this_cModoAtual = "VISUALIZAR"
780:             THIS.HabilitarCampos(.F.)
781:             THIS.AjustarBotoesPorModo()
782:             THIS.pgf_4c_Paginas.ActivePage = 2
783:             THIS.pgf_4c_Paginas.Page2.cnt_4c_BotoesAcao.cmd_4c_Confirmar.SetFocus()
784:         ELSE
785:             MsgAviso("Registro n" + CHR(227) + "o encontrado.", "Visualizar")
786:         ENDIF
787:     ENDPROC
788: 
789:     *==========================================================================

*-- Linhas 798 a 816:
798:             RETURN
799:         ENDIF
800: 
801:         SELECT cursor_4c_Dados
802:         loc_cChave = ALLTRIM(cursor_4c_Dados.Cods)
803: 
804:         IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cChave)
805:             THIS.this_oBusinessObject.EditarRegistro()
806:             THIS.BOParaForm()
807:             THIS.this_cModoAtual = "ALTERAR"
808:             THIS.HabilitarCampos(.T.)
809:             THIS.AjustarBotoesPorModo()
810:             THIS.pgf_4c_Paginas.ActivePage = 2
811:             THIS.pgf_4c_Paginas.Page2.txt_4c_Descricao.SetFocus()
812:         ELSE
813:             MsgAviso("Registro n" + CHR(227) + "o encontrado.", "Alterar")
814:         ENDIF
815:     ENDPROC
816: 

*-- Linhas 825 a 843:
825:             RETURN
826:         ENDIF
827: 
828:         SELECT cursor_4c_Dados
829:         loc_cChave = ALLTRIM(cursor_4c_Dados.Cods)
830: 
831:         IF !MsgConfirma("Confirma a exclus" + CHR(227) + "o deste registro?", "Excluir")
832:             RETURN
833:         ENDIF
834: 
835:         IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cChave)
836:             IF THIS.this_oBusinessObject.Excluir()
837:                 MsgInfo("Registro exclu" + CHR(237) + "do com sucesso!", "Excluir")
838:                 THIS.CarregarLista()
839:             ELSE
840:                 MsgErro("Erro ao excluir o registro.", "Excluir")
841:             ENDIF
842:         ELSE
843:             MsgAviso("Registro n" + CHR(227) + "o encontrado.", "Excluir")


### BO (C:\4c\projeto\app\classes\SERBO.prg):
*==============================================================================
* SERBO.prg - Business Object para Servicos dos Produtos
* Tabela: SigPrSer
* Herda de: BusinessBase
* Fase 1/8: Propriedades e Init
*==============================================================================

DEFINE CLASS SERBO AS BusinessBase

    *-- Propriedades de dados (espelham colunas de SigPrSer)
    this_cIdChaves  = ""  && cidchaves char(20) - chave primaria UUID gerada por fUniqueIds
    this_cCodigo    = ""  && cods char(3) - codigo do servico (chave de negocio)
    this_cDescricao = ""  && descs char(30) - descricao do servico
    this_nQtDias    = 0   && qtdias numeric(3,0) - dias para entrega

    *--------------------------------------------------------------------------
    * Init - Configura tabela e campo chave
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        DODEFAULT()
        THIS.this_cTabela     = "SigPrSer"
        THIS.this_cCampoChave = "cidchaves"
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * Buscar - Carrega servicos no cursor_4c_Dados com filtro opcional
    *--------------------------------------------------------------------------
    PROCEDURE Buscar(par_cFiltro)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF USED("cursor_4c_Dados")
                USE IN cursor_4c_Dados
            ENDIF

            loc_cSQL = "SELECT a.cIdChaves, a.Cods, a.Descs, a.qtDias" + ;
                       " FROM SigPrSer a"

            IF !EMPTY(ALLTRIM(par_cFiltro))
                loc_cSQL = loc_cSQL + ;
                           " WHERE a.Cods LIKE " + EscaparSQL(ALLTRIM(par_cFiltro) + "%")
            ENDIF

            loc_cSQL = loc_cSQL + " ORDER BY a.Cods"

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")

            IF loc_nResultado >= 0
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao buscar servi" + CHR(231) + CHR(245) + "os:" + CHR(13) + ;
                        CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarPorCodigo - Carrega servico pelo codigo de negocio (Cods)
    *--------------------------------------------------------------------------
    PROCEDURE CarregarPorCodigo(par_cCodigo)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF USED("cursor_4c_Carrega")
                USE IN cursor_4c_Carrega
            ENDIF

            loc_cSQL = "SELECT a.cIdChaves, a.Cods, a.Descs, a.qtDias" + ;
                       " FROM SigPrSer a" + ;
                       " WHERE a.Cods = " + EscaparSQL(par_cCodigo)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")

            IF loc_nResultado >= 0 AND RECCOUNT("cursor_4c_Carrega") > 0
                loc_lSucesso = THIS.CarregarDoCursor("cursor_4c_Carrega")
                THIS.this_lNovoRegistro = .F.
            ELSE
                IF loc_nResultado < 0
                    MsgErro("Erro ao carregar servi" + CHR(231) + CHR(227) + "o:" + CHR(13) + ;
                            CapturarErroSQL(), "Erro SQL")
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        IF USED("cursor_4c_Carrega")
            USE IN cursor_4c_Carrega
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Mapeia colunas do cursor para propriedades do BO
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        IF USED(par_cAliasCursor)
            SELECT (par_cAliasCursor)
            THIS.this_cIdChaves  = TratarNulo(cIdChaves, "C")
            THIS.this_cCodigo    = TratarNulo(Cods,      "C")
            THIS.this_cDescricao = TratarNulo(Descs,     "C")
            THIS.this_nQtDias    = TratarNulo(qtDias,    "N")
            loc_lSucesso = .T.
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Retorna a chave primaria para auditoria
    *--------------------------------------------------------------------------
    PROCEDURE ObterChavePrimaria()
        RETURN ALLTRIM(THIS.this_cIdChaves)
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir - INSERT em SigPrSer
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Inserir()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            *-- Verificar se codigo ja existe
            IF USED("cursor_4c_Verifica")
                USE IN cursor_4c_Verifica
            ENDIF

            loc_nResultado = SQLEXEC(gnConnHandle, ;
                "SELECT Cods FROM SigPrSer WHERE Cods = " + EscaparSQL(ALLTRIM(THIS.this_cCodigo)), ;
                "cursor_4c_Verifica")

            IF loc_nResultado >= 0 AND RECCOUNT("cursor_4c_Verifica") > 0
                MsgAviso("C" + CHR(243) + "digo j" + CHR(225) + " cadastrado!", ;
                         "Aten" + CHR(231) + CHR(227) + "o")
            ELSE
                *-- Gerar UUID para a chave primaria
                THIS.this_cIdChaves = fUniqueIds()

                loc_cSQL = "INSERT INTO SigPrSer (cIdChaves, Cods, Descs, qtDias)" + ;
                           " VALUES (" + ;
                           EscaparSQL(ALLTRIM(THIS.this_cIdChaves)) + ", " + ;
                           EscaparSQL(ALLTRIM(THIS.this_cCodigo)) + ", " + ;
                           EscaparSQL(ALLTRIM(THIS.this_cDescricao)) + ", " + ;
                           FormatarNumeroSQL(THIS.this_nQtDias) + ;
                           ")"

                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Ins")

                IF loc_nResultado >= 0
                    THIS.RegistrarAuditoria("INSERT")
                    loc_lSucesso = .T.
                ELSE
                    MsgErro("Erro ao inserir servi" + CHR(231) + CHR(227) + "o:" + CHR(13) + ;
                            CapturarErroSQL(), "Erro SQL")
                ENDIF

                IF USED("cursor_4c_Ins")
                    USE IN cursor_4c_Ins
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        IF USED("cursor_4c_Verifica")
            USE IN cursor_4c_Verifica
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - UPDATE em SigPrSer (codigo Cods nao e alterado apos insert)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Atualizar()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "UPDATE SigPrSer SET" + ;
                       " Descs = "  + EscaparSQL(ALLTRIM(THIS.this_cDescricao)) + "," + ;
                       " qtDias = " + FormatarNumeroSQL(THIS.this_nQtDias) + ;
                       " WHERE cIdChaves = " + EscaparSQL(ALLTRIM(THIS.this_cIdChaves))

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Upd")

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("UPDATE")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao atualizar servi" + CHR(231) + CHR(227) + "o:" + CHR(13) + ;
                        CapturarErroSQL(), "Erro SQL")
            ENDIF

            IF USED("cursor_4c_Upd")
                USE IN cursor_4c_Upd
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ExecutarExclusao - DELETE de SigPrSer
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ExecutarExclusao()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "DELETE FROM SigPrSer" + ;
                       " WHERE cIdChaves = " + EscaparSQL(ALLTRIM(THIS.this_cIdChaves))

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Del")

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("DELETE")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao excluir servi" + CHR(231) + CHR(227) + "o:" + CHR(13) + ;
                        CapturarErroSQL(), "Erro SQL")
            ENDIF

            IF USED("cursor_4c_Del")
                USE IN cursor_4c_Del
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

ENDDEFINE


# CODE REVIEW - PASS SQL: SQL Validation (colunas, tabelas, aspas, filtros)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **SQL Validation (colunas, tabelas, aspas, filtros)**.

## PROBLEMAS DETECTADOS (2)
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'DESCS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: CODS
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

### FORM (C:\4c\projeto\app\forms\cadastros\FormSER.prg) - TRECHOS RELEVANTES PARA PASS SQL (944 linhas total):

*-- Linhas 356 a 374:
356:             .HighlightBackColor = RGB(255, 255, 255)
357:             .HighlightForeColor = RGB(15, 41, 104)
358:             .HighlightStyle     = 2
359:             .DeleteMark         = .F.
360:             .RecordMark         = .F.
361:             .RowHeight          = 16
362:             .ScrollBars         = 2
363:             .GridLines          = 3
364:             .Visible            = .T.
365:         ENDWITH
366: 
367:         WITH loc_oGrid.Column1
368:             .Width     = 80
369:             .Alignment = 0
370:             .FontName  = "Tahoma"
371:             .FontSize  = 8
372:         ENDWITH
373:         loc_oGrid.Column1.Header1.Caption = "C" + CHR(243) + "digo"
374: 

*-- Linhas 603 a 626:
603:                 loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Lista
604: 
605:                 IF THIS.this_oBusinessObject.Buscar("")
606:                     *-- RecordSource ANTES de ControlSource (Problem #48)
607:                     loc_oGrid.ColumnCount = 2
608:                     loc_oGrid.RecordSource = "cursor_4c_Dados"
609:                     loc_oGrid.Column1.ControlSource = "cursor_4c_Dados.Cods"
610:                     loc_oGrid.Column2.ControlSource = "cursor_4c_Dados.Descs"
611:                     *-- Width e Headers APOS ControlSource (Problem #32)
612:                     loc_oGrid.Column1.Width = 80
613:                     loc_oGrid.Column2.Width = 200
614:                     loc_oGrid.Column1.Header1.Caption = "C" + CHR(243) + "digo"
615:                     loc_oGrid.Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
616:                     THIS.FormatarGridLista(loc_oGrid)
617:                     loc_lResultado = .T.
618:                 ENDIF
619:             ENDIF
620:         CATCH TO loc_oErro
621:             MsgErro("Erro:" + CHR(13) + loc_oErro.Message, "Erro")
622:             loc_lResultado = .F.
623:         ENDTRY
624: 
625:         RETURN loc_lResultado
626:     ENDPROC

*-- Linhas 769 a 787:
769:             RETURN
770:         ENDIF
771: 
772:         SELECT cursor_4c_Dados
773:         loc_cChave = ALLTRIM(cursor_4c_Dados.cIdChaves)
774: 
775:         IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cChave)
776:             THIS.BOParaForm()
777:             THIS.this_cModoAtual = "VISUALIZAR"
778:             THIS.HabilitarCampos(.F.)
779:             THIS.AjustarBotoesPorModo()
780:             THIS.pgf_4c_Paginas.ActivePage = 2
781:             THIS.pgf_4c_Paginas.Page2.cnt_4c_BotoesAcao.cmd_4c_Confirmar.SetFocus()
782:         ELSE
783:             MsgAviso("Registro n" + CHR(227) + "o encontrado.", "Visualizar")
784:         ENDIF
785:     ENDPROC
786: 
787:     *==========================================================================

*-- Linhas 796 a 814:
796:             RETURN
797:         ENDIF
798: 
799:         SELECT cursor_4c_Dados
800:         loc_cChave = ALLTRIM(cursor_4c_Dados.cIdChaves)
801: 
802:         IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cChave)
803:             THIS.this_oBusinessObject.EditarRegistro()
804:             THIS.BOParaForm()
805:             THIS.this_cModoAtual = "ALTERAR"
806:             THIS.HabilitarCampos(.T.)
807:             THIS.AjustarBotoesPorModo()
808:             THIS.pgf_4c_Paginas.ActivePage = 2
809:             THIS.pgf_4c_Paginas.Page2.txt_4c_Descricao.SetFocus()
810:         ELSE
811:             MsgAviso("Registro n" + CHR(227) + "o encontrado.", "Alterar")
812:         ENDIF
813:     ENDPROC
814: 

*-- Linhas 823 a 841:
823:             RETURN
824:         ENDIF
825: 
826:         SELECT cursor_4c_Dados
827:         loc_cChave = ALLTRIM(cursor_4c_Dados.cIdChaves)
828: 
829:         IF !MsgConfirma("Confirma a exclus" + CHR(227) + "o deste registro?", "Excluir")
830:             RETURN
831:         ENDIF
832: 
833:         IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cChave)
834:             IF THIS.this_oBusinessObject.Excluir()
835:                 MsgInfo("Registro exclu" + CHR(237) + "do com sucesso!", "Excluir")
836:                 THIS.CarregarLista()
837:             ELSE
838:                 MsgErro("Erro ao excluir o registro.", "Excluir")
839:             ENDIF
840:         ELSE
841:             MsgAviso("Registro n" + CHR(227) + "o encontrado.", "Excluir")


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
                           " WHERE a.Cods LIKE " + EscaparSQL(ALLTRIM(par_cFiltro) + "%") + ;
                           " OR a.Descs LIKE " + EscaparSQL("%" + ALLTRIM(par_cFiltro) + "%")
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
    * CarregarPorCodigo - Carrega servico pela chave primaria (cIdChaves)
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
                       " WHERE a.cIdChaves = " + EscaparSQL(par_cCodigo)

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


# CODE REVIEW - PASS SQL: SQL Validation (colunas, tabelas, aspas, filtros)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **SQL Validation (colunas, tabelas, aspas, filtros)**.

## PROBLEMAS DETECTADOS (1)
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'CIDCHAVES' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: EMPS, TABDES, CARGOS, FPAGS, DTINIS, DTFINS

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
  ControlSource = "crSigCdCmi.emps"
  ControlSource = "crSigCdCmi.cargos"
  ControlSource = "crSigCdCmi.fpags"
  ControlSource = "crSigCdCmi.tabdes"
  ControlSource = "crSigCdCmi.dtfins"
  ControlSource = "crSigCdCmi.dtinis"
  ControlSource = "crSigCdCmi.comiss"
Select crSigCdCmi
lcQryComi = 'Select * From SigCdCmi'
Select crSigCdCmi
Select crSigCdCmi
		lcSQLCmd = [Select Emps, Cargos, TabDes, DtInis, DtFins ] + ;
					 [From SigCdCmi ] + ;
		If (ThisForm.poDataMgr.SQLExecute(lcSQLCmd, 'crTmp') < 1)

## CODIGO ATUAL DOS ARQUIVOS

### FORM (C:\4c\projeto\app\forms\cadastros\FormICM.prg) - TRECHOS RELEVANTES PARA PASS SQL (1347 linhas total):

*-- Linhas 330 a 348:
330:         loc_oGrid.HighlightBackColor = RGB(255, 255, 255)
331:         loc_oGrid.HighlightForeColor = RGB(15, 41, 104)
332:         loc_oGrid.HighlightStyle   = 2
333:         loc_oGrid.DeleteMark       = .F.
334:         loc_oGrid.RecordMark       = .F.
335:         loc_oGrid.RowHeight        = 16
336:         loc_oGrid.ScrollBars       = 2
337:         loc_oGrid.ReadOnly         = .T.
338:         loc_oGrid.Visible          = .T.
339: 
340:         THIS.TornarControlesVisiveis(loc_oPagina)
341:     ENDPROC
342: 
343:     *==========================================================================
344:     PROTECTED PROCEDURE ConfigurarPaginaDados()
345:     *==========================================================================
346:         LOCAL loc_oPagina
347:         loc_oPagina = THIS.pgf_4c_Paginas.Page2
348: 

*-- Linhas 779 a 805:
779:                     loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Lista
780:                     loc_oGrid.ColumnCount = 9
781:                     loc_oGrid.RecordSource       = "cursor_4c_Dados"
782:                     loc_oGrid.Column1.ControlSource = "cursor_4c_Dados.emps"
783:                     loc_oGrid.Column2.ControlSource = "cursor_4c_Dados.razas"
784:                     loc_oGrid.Column3.ControlSource = "cursor_4c_Dados.tabdes"
785:                     loc_oGrid.Column4.ControlSource = "cursor_4c_Dados.descrs_tabdes"
786:                     loc_oGrid.Column5.ControlSource = "cursor_4c_Dados.cargos"
787:                     loc_oGrid.Column6.ControlSource = "cursor_4c_Dados.fpags"
788:                     loc_oGrid.Column7.ControlSource = "cursor_4c_Dados.dtinis"
789:                     loc_oGrid.Column8.ControlSource = "cursor_4c_Dados.dtfins"
790:                     loc_oGrid.Column9.ControlSource = "cursor_4c_Dados.comiss"
791:                     loc_oGrid.Column1.Width      = 35
792:                     loc_oGrid.Column2.Width      = 160
793:                     loc_oGrid.Column3.Width      = 75
794:                     loc_oGrid.Column4.Width      = 140
795:                     loc_oGrid.Column5.Width      = 80
796:                     loc_oGrid.Column6.Width      = 90
797:                     loc_oGrid.Column7.Width      = 80
798:                     loc_oGrid.Column8.Width      = 80
799:                     loc_oGrid.Column9.Width      = 55
800:                     loc_oGrid.Column9.Alignment  = 2
801:                     loc_oGrid.Column1.Header1.Caption = "Emp"
802:                     loc_oGrid.Column2.Header1.Caption = "Empresa"
803:                     loc_oGrid.Column3.Header1.Caption = "Tb.Desconto"
804:                     loc_oGrid.Column4.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o Tabela"
805:                     loc_oGrid.Column5.Header1.Caption = "Cargo"

*-- Linhas 868 a 925:
868:             MsgAviso("Selecione um registro para visualizar.", "")
869:             RETURN
870:         ENDIF
871:         SELECT cursor_4c_Dados
872:         loc_cId = ALLTRIM(cursor_4c_Dados.cidchaves)
873:         IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cId)
874:             THIS.this_cModoAtual = "VISUALIZAR"
875:             THIS.AjustarBotoesPorModo()
876:             THIS.BOParaForm()
877:             THIS.HabilitarCampos(.F.)
878:             THIS.AlternarPagina(2)
879:         ENDIF
880:     ENDPROC
881: 
882:     *==========================================================================
883:     PROCEDURE BtnAlterarClick()
884:     *==========================================================================
885:         LOCAL loc_cId
886:         IF !USED("cursor_4c_Dados") OR EOF("cursor_4c_Dados")
887:             MsgAviso("Selecione um registro para alterar.", "")
888:             RETURN
889:         ENDIF
890:         SELECT cursor_4c_Dados
891:         loc_cId = ALLTRIM(cursor_4c_Dados.cidchaves)
892:         IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cId)
893:             THIS.this_oBusinessObject.EditarRegistro()
894:             THIS.this_cModoAtual = "ALTERAR"
895:             THIS.AjustarBotoesPorModo()
896:             THIS.BOParaForm()
897:             THIS.HabilitarCampos(.T.)
898:             THIS.AlternarPagina(2)
899:         ENDIF
900:     ENDPROC
901: 
902:     *==========================================================================
903:     PROCEDURE BtnExcluirClick()
904:     *==========================================================================
905:         LOCAL loc_cId
906:         IF !USED("cursor_4c_Dados") OR EOF("cursor_4c_Dados")
907:             MsgAviso("Selecione um registro para excluir.", "")
908:             RETURN
909:         ENDIF
910:         SELECT cursor_4c_Dados
911:         loc_cId = ALLTRIM(cursor_4c_Dados.cidchaves)
912:         IF MsgConfirma("Deseja excluir este " + CHR(237) + "ndice de comiss" + CHR(227) + "o?", ;
913:                        "Confirmar Exclus" + CHR(227) + "o")
914:             IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cId)
915:                 IF THIS.this_oBusinessObject.Excluir()
916:                     MsgInfo("Registro exclu" + CHR(237) + "do com sucesso!", "")
917:                     THIS.CarregarLista()
918:                 ENDIF
919:             ENDIF
920:         ENDIF
921:     ENDPROC
922: 
923:     *==========================================================================
924:     PROCEDURE BtnBuscarClick()
925:     *==========================================================================


### BO (C:\4c\projeto\app\classes\ICMBO.prg):
*==============================================================================
* ICMBO.prg - Business Object: Cadastro de Indices de Comissao
* Tabela: SigCdCmi
* PK: cidchaves (char 20, gerado via fUniqueIds)
*==============================================================================

DEFINE CLASS ICMBO AS BusinessBase

    *-- Campos da tabela SigCdCmi
    this_cEmps      = ""    && char(3)  - Empresa
    this_cCargos    = ""    && char(10) - Cargo
    this_cFPags     = ""    && char(12) - Condicao de Pagamento
    this_cTabDes    = ""    && char(10) - Tabela de Desconto
    this_dDtInis    = {}    && datetime - Data Inicial do Periodo
    this_dDtFins    = {}    && datetime - Data Final do Periodo
    this_nComiss    = 0     && numeric(4,2) - Percentual de Comissao
    this_cIdChaves  = ""    && char(20) - Chave unica (PK, gerado por fUniqueIds)
    this_tDtAlts    = {}    && datetime - Data/hora ultima alteracao

    *-- Campos descricao (lookup, nao armazenados no banco)
    this_cDEmpresa  = ""    && Razao social da empresa (SigCdEmp.Razas)
    this_cDCargo    = ""    && Descricao do cargo (SigCdCrg.DCargs)
    this_cDTabDes   = ""    && Descricao da tabela de desconto (SigOpTdz.Descrs)

    *--------------------------------------------------------------------------
    PROCEDURE Init()
    *--------------------------------------------------------------------------
        LOCAL loc_lResultado
        loc_lResultado = .F.
        TRY
            DODEFAULT()
            THIS.this_cTabela     = "SigCdCmi"
            THIS.this_cCampoChave = "cidchaves"
            loc_lResultado = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "ICMBO.Init")
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    FUNCTION ObterChavePrimaria()
    *--------------------------------------------------------------------------
        RETURN THIS.this_cIdChaves
    ENDPROC

    *--------------------------------------------------------------------------
    FUNCTION Buscar(par_cFiltro)
    *--------------------------------------------------------------------------
        LOCAL loc_lResultado, loc_cSQL, loc_cWhere, loc_nResult
        loc_lResultado = .F.

        TRY
            loc_cWhere = ""
            IF VARTYPE(par_cFiltro) = "C" AND !EMPTY(ALLTRIM(par_cFiltro))
                loc_cWhere = " WHERE " + par_cFiltro
            ENDIF

            loc_cSQL = "SELECT a.cidchaves, a.emps, a.tabdes, a.cargos, a.fpags," + ;
                       " a.dtinis, a.dtfins, a.comiss, a.dtalts," + ;
                       " ISNULL(b.razas, '') AS razas," + ;
                       " ISNULL(c.dcargs, '') AS dcargs," + ;
                       " ISNULL(d.descrs, '') AS descrs_tabdes" + ;
                       " FROM SigCdCmi a" + ;
                       " LEFT JOIN SigCdEmp b ON b.cemps = a.cemps" + ;
                       " LEFT JOIN SigCdCrg c ON c.ccargs = a.cargos" + ;
                       " LEFT JOIN SigOpTdz d ON d.codigos = a.tabdes" + ;
                       loc_cWhere + ;
                       " ORDER BY a.emps, a.tabdes, a.cargos, a.fpags"

            IF USED("cursor_4c_Dados")
                USE IN cursor_4c_Dados
            ENDIF

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")
            IF loc_nResult > 0
                GO TOP IN cursor_4c_Dados
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao buscar " + CHR(237) + "ndices de comiss" + CHR(227) + "o:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + "Linha: " + TRANSFORM(loc_oErro.LineNo), "ICMBO.Buscar")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    FUNCTION CarregarPorCodigo(par_cIdChaves)
    *--------------------------------------------------------------------------
        LOCAL loc_lResultado, loc_cSQL, loc_nResult
        loc_lResultado = .F.

        TRY
            loc_cSQL = "SELECT a.cidchaves, a.emps, a.tabdes, a.cargos, a.fpags," + ;
                       " a.dtinis, a.dtfins, a.comiss, a.dtalts," + ;
                       " ISNULL(b.razas, '') AS razas," + ;
                       " ISNULL(c.dcargs, '') AS dcargs," + ;
                       " ISNULL(d.descrs, '') AS descrs_tabdes" + ;
                       " FROM SigCdCmi a" + ;
                       " LEFT JOIN SigCdEmp b ON b.cemps = a.cemps" + ;
                       " LEFT JOIN SigCdCrg c ON c.ccargs = a.cargos" + ;
                       " LEFT JOIN SigOpTdz d ON d.codigos = a.tabdes" + ;
                       " WHERE a.cidchaves = " + EscaparSQL(ALLTRIM(par_cIdChaves))

            IF USED("cursor_4c_Carrega")
                USE IN cursor_4c_Carrega
            ENDIF

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")
            IF loc_nResult > 0 AND RECCOUNT("cursor_4c_Carrega") > 0
                GO TOP IN cursor_4c_Carrega
                loc_lResultado = THIS.CarregarDoCursor("cursor_4c_Carrega")
                THIS.this_lNovoRegistro = .F.
            ELSE
                MsgErro("Registro n" + CHR(227) + "o encontrado.", "ICMBO.CarregarPorCodigo")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + "Linha: " + TRANSFORM(loc_oErro.LineNo), "ICMBO.CarregarPorCodigo")
        ENDTRY

        IF USED("cursor_4c_Carrega")
            USE IN cursor_4c_Carrega
        ENDIF

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    FUNCTION CarregarDoCursor(par_cAliasCursor)
    *--------------------------------------------------------------------------
        LOCAL loc_lResultado
        loc_lResultado = .F.

        IF USED(par_cAliasCursor)
            SELECT (par_cAliasCursor)
            THIS.this_cIdChaves  = ALLTRIM(TratarNulo(cidchaves,  "C"))
            THIS.this_cEmps      = ALLTRIM(TratarNulo(emps,       "C"))
            THIS.this_cTabDes    = ALLTRIM(TratarNulo(tabdes,     "C"))
            THIS.this_cCargos    = ALLTRIM(TratarNulo(cargos,     "C"))
            THIS.this_cFPags     = ALLTRIM(TratarNulo(fpags,      "C"))
            THIS.this_dDtInis    = TratarNulo(dtinis, "D")
            THIS.this_dDtFins    = TratarNulo(dtfins, "D")
            THIS.this_nComiss    = TratarNulo(comiss, "N")
            THIS.this_tDtAlts    = TratarNulo(dtalts, "D")
            IF TYPE(par_cAliasCursor + ".razas") != "U"
                THIS.this_cDEmpresa = ALLTRIM(TratarNulo(razas,         "C"))
                THIS.this_cDCargo   = ALLTRIM(TratarNulo(dcargs,        "C"))
                THIS.this_cDTabDes  = ALLTRIM(TratarNulo(descrs_tabdes, "C"))
            ENDIF
            loc_lResultado = .T.
        ENDIF

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    PROTECTED FUNCTION Inserir()
    *--------------------------------------------------------------------------
        LOCAL loc_lResultado, loc_cSQL, loc_nResult, loc_cId
        LOCAL loc_nResultDup, loc_cSQLDup, loc_lDuplicado
        loc_lResultado = .F.
        loc_lDuplicado = .F.

        TRY
            *-- Verificar duplicidade (Emps+Cargos+FPags+TabDes+DtInis+DtFins)
            loc_cSQLDup = "SELECT cidchaves FROM SigCdCmi" + ;
                          " WHERE emps = "   + EscaparSQL(THIS.this_cEmps)   + ;
                          " AND cargos = "   + EscaparSQL(THIS.this_cCargos) + ;
                          " AND fpags = "    + EscaparSQL(THIS.this_cFPags)  + ;
                          " AND tabdes = "   + EscaparSQL(THIS.this_cTabDes) + ;
                          " AND dtinis = "   + FormatarDataSQL(THIS.this_dDtInis) + ;
                          " AND dtfins = "   + FormatarDataSQL(THIS.this_dDtFins)

            IF USED("cursor_4c_DupVerif")
                USE IN cursor_4c_DupVerif
            ENDIF
            loc_nResultDup = SQLEXEC(gnConnHandle, loc_cSQLDup, "cursor_4c_DupVerif")
            IF loc_nResultDup > 0 AND RECCOUNT("cursor_4c_DupVerif") > 0
                loc_lDuplicado = .T.
                MsgAviso("Dados j" + CHR(225) + " cadastrados para esta combina" + CHR(231) + CHR(227) + "o!", "")
            ENDIF
            IF USED("cursor_4c_DupVerif")
                USE IN cursor_4c_DupVerif
            ENDIF

            IF !loc_lDuplicado
                *-- Gerar chave unica
                loc_cId = fUniqueIds()
                THIS.this_cIdChaves = loc_cId

                loc_cSQL = "INSERT INTO SigCdCmi (cidchaves, emps, tabdes, cargos, fpags," + ;
                           " dtinis, dtfins, comiss, dtalts)" + ;
                           " VALUES (" + ;
                           EscaparSQL(loc_cId) + ", " + ;
                           EscaparSQL(THIS.this_cEmps)   + ", " + ;
                           EscaparSQL(THIS.this_cTabDes)  + ", " + ;
                           EscaparSQL(THIS.this_cCargos)  + ", " + ;
                           EscaparSQL(THIS.this_cFPags)   + ", " + ;
                           FormatarDataSQL(THIS.this_dDtInis) + ", " + ;
                           FormatarDataSQL(THIS.this_dDtFins) + ", " + ;
                           FormatarNumeroSQL(THIS.this_nComiss) + ", " + ;
                           "GETDATE())"

                *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
                IF USED("cursor_4c_Ins")
                    TABLEREVERT(.T., "cursor_4c_Ins")
                    USE IN cursor_4c_Ins
                ENDIF

                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Ins")
                IF loc_nResult > 0
                    IF USED("cursor_4c_Ins")
                        USE IN cursor_4c_Ins
                    ENDIF
                    THIS.RegistrarAuditoria("INSERT")
                    loc_lResultado = .T.
                ELSE
                    IF USED("cursor_4c_Ins")
                        USE IN cursor_4c_Ins
                    ENDIF
                    MsgErro("Erro ao inserir " + CHR(237) + "ndice de comiss" + CHR(227) + "o:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            IF USED("cursor_4c_DupVerif")
                USE IN cursor_4c_DupVerif
            ENDIF
            IF USED("cursor_4c_Ins")
                USE IN cursor_4c_Ins
            ENDIF
            MsgErro(loc_oErro.Message + CHR(13) + "Linha: " + TRANSFORM(loc_oErro.LineNo), "ICMBO.Inserir")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    PROTECTED FUNCTION Atualizar()
    *--------------------------------------------------------------------------
        LOCAL loc_lResultado, loc_cSQL, loc_nResult
        loc_lResultado = .F.

        TRY
            loc_cSQL = "UPDATE SigCdCmi SET" + ;
                       " emps = "   + EscaparSQL(THIS.this_cEmps)   + ", " + ;
                       " tabdes = " + EscaparSQL(THIS.this_cTabDes)  + ", " + ;
                       " cargos = " + EscaparSQL(THIS.this_cCargos)  + ", " + ;
                       " fpags = "  + EscaparSQL(THIS.this_cFPags)   + ", " + ;
                       " dtinis = " + FormatarDataSQL(THIS.this_dDtInis) + ", " + ;
                       " dtfins = " + FormatarDataSQL(THIS.this_dDtFins) + ", " + ;
                       " comiss = " + FormatarNumeroSQL(THIS.this_nComiss) + ", " + ;
                       " dtalts = GETDATE()" + ;
                       " WHERE cidchaves = " + EscaparSQL(THIS.this_cIdChaves)

            *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
            IF USED("cursor_4c_Upd")
                TABLEREVERT(.T., "cursor_4c_Upd")
                USE IN cursor_4c_Upd
            ENDIF

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Upd")
            IF loc_nResult > 0
                IF USED("cursor_4c_Upd")
                    USE IN cursor_4c_Upd
                ENDIF
                THIS.RegistrarAuditoria("UPDATE")
                loc_lResultado = .T.
            ELSE
                IF USED("cursor_4c_Upd")
                    USE IN cursor_4c_Upd
                ENDIF
                MsgErro("Erro ao atualizar " + CHR(237) + "ndice de comiss" + CHR(227) + "o:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            IF USED("cursor_4c_Upd")
                USE IN cursor_4c_Upd
            ENDIF
            MsgErro(loc_oErro.Message + CHR(13) + "Linha: " + TRANSFORM(loc_oErro.LineNo), "ICMBO.Atualizar")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    PROTECTED FUNCTION ExecutarExclusao()
    *--------------------------------------------------------------------------
        LOCAL loc_lResultado, loc_cSQL, loc_nResult
        loc_lResultado = .F.

        TRY
            loc_cSQL = "DELETE FROM SigCdCmi WHERE cidchaves = " + ;
                       EscaparSQL(THIS.this_cIdChaves)

            *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
            IF USED("cursor_4c_Del")
                TABLEREVERT(.T., "cursor_4c_Del")
                USE IN cursor_4c_Del
            ENDIF

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Del")
            IF loc_nResult > 0
                IF USED("cursor_4c_Del")
                    USE IN cursor_4c_Del
                ENDIF
                THIS.RegistrarAuditoria("DELETE")
                loc_lResultado = .T.
            ELSE
                IF USED("cursor_4c_Del")
                    USE IN cursor_4c_Del
                ENDIF
                MsgErro("Erro ao excluir " + CHR(237) + "ndice de comiss" + CHR(227) + "o:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            IF USED("cursor_4c_Del")
                USE IN cursor_4c_Del
            ENDIF
            MsgErro(loc_oErro.Message + CHR(13) + "Linha: " + TRANSFORM(loc_oErro.LineNo), "ICMBO.ExecutarExclusao")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

ENDDEFINE


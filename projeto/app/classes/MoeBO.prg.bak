*==============================================================================
* MoeBO.prg - Business Object para Cadastro de Moedas
* Tabela: SigCdMoe
* Chave primaria: cmoes char(3)
*==============================================================================

DEFINE CLASS MoeBO AS BusinessBase

    *-- Chave primaria
    this_cCodigo      = ""    && char(3)       cmoes  - Codigo da moeda (PK)

    *-- Dados cadastrais
    this_cDescricao   = ""    && char(15)      dmoes  - Descricao da moeda
    this_lCotas       = .F.   && bit           cotas  - Permite cotacao
    this_dDataTrans   = {}    && datetime NULL  datatrans - Data transacao

    *-- Fator multiplicador / ordem relatorios
    this_cFmults      = ""    && char(1)       fmults     - Fator multiplicador (N=Nao / S=Sim)
    this_nNordrels    = 0     && numeric(1,0)  nordrels   - N da coluna nos relatorios (0-5)

    *-- Codificacao etiqueta produto
    this_cDisfpres    = ""    && char(1)       disfpres   - Codifica na etiqueta (N/S/A/P)
    this_nValadics    = 0     && numeric(3,0)  valadics   - Valor adicional

    *-- Moeda equivalente
    this_cMoeqs       = ""    && char(3)       moeqs      - Codigo da moeda equivalente (FK SigCdMoe.cmoes)
    this_nQtdeqs      = 0     && numeric(12,6) qtdeqs     - Quantidade moeda equivalente
    this_nToleras     = 0     && numeric(4,2)  toleras    - Tolerancia conversao

    *-- Classificacao
    this_cGrumoes     = ""    && char(10)      grumoes    - Grupo
    this_cSubmoes     = ""    && char(10)      submoes    - Sub-grupo

    *-- Configuracao gerencial
    this_lTabrefs     = .F.   && bit           tabrefs    - Imprime tabela referencia
    this_cFpags       = ""    && char(12)      fpags      - Cond. pagamento automatica (FK SigOpFp.fpags)
    this_nConsultas   = 1     && numeric(1,0)  consultas  - Listar na consulta (1=Sim / 2=Nao)
    this_nObgfator    = 0     && numeric(1,0)  obgfator   - Obrigatorio fator

    *--------------------------------------------------------------------------
    PROCEDURE Init()
        DODEFAULT()
        THIS.this_cTabela     = "SigCdMoe"
        THIS.this_cCampoChave = "cmoes"
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    FUNCTION ObterChavePrimaria()
        RETURN ALLTRIM(THIS.this_cCodigo)
    ENDFUNC

    *--------------------------------------------------------------------------
    FUNCTION Buscar(par_cFiltro)
        LOCAL loc_cSQL, loc_nResult, loc_lSucesso
        loc_lSucesso = .F.
        TRY
            IF USED("cursor_4c_Dados")
                USE IN cursor_4c_Dados
            ENDIF

            loc_cSQL = "SELECT cmoes, dmoes, nordrels, cotas" + ;
                " FROM SigCdMoe"

            IF !EMPTY(par_cFiltro)
                loc_cSQL = loc_cSQL + " WHERE " + par_cFiltro
            ENDIF

            loc_cSQL = loc_cSQL + " ORDER BY cmoes"

            *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
            IF USED("cursor_4c_Dados")
                TABLEREVERT(.T., "cursor_4c_Dados")
                USE IN cursor_4c_Dados
            ENDIF

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")
            IF loc_nResult > 0
                IF USED("cursor_4c_Dados")
                    GO TOP IN cursor_4c_Dados
                ENDIF
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao buscar moedas:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em Buscar: " + loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    FUNCTION CarregarPorCodigo(par_cCodigo)
        LOCAL loc_cSQL, loc_nResult, loc_lSucesso
        loc_lSucesso = .F.
        TRY
            IF USED("cursor_4c_Carrega")
                USE IN cursor_4c_Carrega
            ENDIF

            loc_cSQL = "SELECT cmoes, dmoes, cotas, datatrans, fmults, nordrels," + ;
                " disfpres, valadics, moeqs, qtdeqs, toleras," + ;
                " grumoes, submoes, tabrefs, fpags, consultas, obgfator" + ;
                " FROM SigCdMoe" + ;
                " WHERE cmoes = " + EscaparSQL(ALLTRIM(par_cCodigo))

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")
            IF loc_nResult > 0 AND RECCOUNT("cursor_4c_Carrega") > 0
                loc_lSucesso = THIS.CarregarDoCursor("cursor_4c_Carrega")
                THIS.this_lNovoRegistro = .F.
            ELSE
                MsgAviso("Moeda n" + CHR(227) + "o encontrada: " + ALLTRIM(par_cCodigo), "N" + CHR(227) + "o Encontrado")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em CarregarPorCodigo: " + loc_oErro.Message, "Erro")
        ENDTRY
        IF USED("cursor_4c_Carrega")
            USE IN cursor_4c_Carrega
        ENDIF
        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    PROTECTED FUNCTION CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        IF USED(par_cAliasCursor)
            SELECT (par_cAliasCursor)
            THIS.this_cCodigo    = TratarNulo(cmoes,    "C")
            THIS.this_cDescricao = TratarNulo(dmoes,    "C")
            IF VARTYPE(cotas) = "L"
                THIS.this_lCotas = cotas
            ELSE
                THIS.this_lCotas = (NVL(cotas, 0) = 1)
            ENDIF
            THIS.this_cFmults    = TratarNulo(fmults,   "C")
            THIS.this_nNordrels  = TratarNulo(nordrels, "N")
            THIS.this_cDisfpres  = TratarNulo(disfpres, "C")
            THIS.this_nValadics  = TratarNulo(valadics, "N")
            THIS.this_cMoeqs     = TratarNulo(moeqs,    "C")
            THIS.this_nQtdeqs    = TratarNulo(qtdeqs,   "N")
            THIS.this_nToleras   = TratarNulo(toleras,  "N")
            THIS.this_cGrumoes   = TratarNulo(grumoes,  "C")
            THIS.this_cSubmoes   = TratarNulo(submoes,  "C")
            IF VARTYPE(tabrefs) = "L"
                THIS.this_lTabrefs = tabrefs
            ELSE
                THIS.this_lTabrefs = (NVL(tabrefs, 0) = 1)
            ENDIF
            THIS.this_cFpags     = TratarNulo(fpags,    "C")
            THIS.this_nConsultas = TratarNulo(consultas,"N")
            THIS.this_nObgfator  = TratarNulo(obgfator, "N")
            IF ISNULL(datatrans) OR EMPTY(datatrans)
                THIS.this_dDataTrans = {}
            ELSE
                THIS.this_dDataTrans = datatrans
            ENDIF
            loc_lSucesso = .T.
        ENDIF
        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    PROTECTED FUNCTION ValidarDados()
        LOCAL loc_cSQL, loc_nResult, loc_lValido
        loc_lValido = .T.

        IF EMPTY(ALLTRIM(THIS.this_cCodigo))
            MsgAviso("C" + CHR(243) + "digo da moeda n" + CHR(227) + "o pode ser vazio!", ;
                "Valida" + CHR(231) + CHR(227) + "o")
            loc_lValido = .F.
        ENDIF

        IF loc_lValido AND EMPTY(ALLTRIM(THIS.this_cDescricao))
            MsgAviso("Descri" + CHR(231) + CHR(227) + "o da moeda n" + CHR(227) + "o pode ser vazia!", ;
                "Valida" + CHR(231) + CHR(227) + "o")
            loc_lValido = .F.
        ENDIF

        IF loc_lValido AND !BETWEEN(THIS.this_nNordrels, 0, 5)
            MsgAviso("Ordem de Impress" + CHR(227) + "o nos Relat" + CHR(243) + ;
                "rios inv" + CHR(225) + "lida (0 a 5)!", "Valida" + CHR(231) + CHR(227) + "o")
            loc_lValido = .F.
        ENDIF

        IF loc_lValido AND THIS.this_lNovoRegistro
            TRY
                IF USED("cursor_4c_ValidaMoe")
                    USE IN cursor_4c_ValidaMoe
                ENDIF
                loc_cSQL = "SELECT cmoes FROM SigCdMoe" + ;
                    " WHERE cmoes = " + EscaparSQL(ALLTRIM(THIS.this_cCodigo))
                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ValidaMoe")
                IF loc_nResult > 0 AND RECCOUNT("cursor_4c_ValidaMoe") > 0
                    MsgAviso("Moeda j" + CHR(225) + " cadastrada!", "Valida" + CHR(231) + CHR(227) + "o")
                    loc_lValido = .F.
                ENDIF
            CATCH TO loc_oErro
                MsgErro("Erro na valida" + CHR(231) + CHR(227) + "o: " + loc_oErro.Message, "Erro")
                loc_lValido = .F.
            ENDTRY
            IF USED("cursor_4c_ValidaMoe")
                USE IN cursor_4c_ValidaMoe
            ENDIF
        ENDIF

        RETURN loc_lValido
    ENDFUNC

    *--------------------------------------------------------------------------
    PROTECTED FUNCTION Inserir()
        LOCAL loc_cSQL, loc_nResult, loc_lSucesso, loc_cDisfpres
        loc_lSucesso = .F.

        loc_cDisfpres = THIS.this_cDisfpres
        IF EMPTY(ALLTRIM(loc_cDisfpres))
            loc_cDisfpres = "S"
        ENDIF

        TRY
            loc_cSQL = "INSERT INTO SigCdMoe" + ;
                " (cmoes, dmoes, cotas, datatrans, fmults, nordrels," + ;
                " disfpres, valadics, moeqs, qtdeqs, toleras," + ;
                " grumoes, submoes, tabrefs, fpags, consultas, obgfator)" + ;
                " VALUES (" + ;
                EscaparSQL(ALLTRIM(THIS.this_cCodigo)) + ", " + ;
                EscaparSQL(ALLTRIM(THIS.this_cDescricao)) + ", " + ;
                IIF(THIS.this_lCotas, "1", "0") + ", " + ;
                "GETDATE(), " + ;
                EscaparSQL(THIS.this_cFmults) + ", " + ;
                FormatarNumeroSQL(THIS.this_nNordrels) + ", " + ;
                EscaparSQL(loc_cDisfpres) + ", " + ;
                FormatarNumeroSQL(THIS.this_nValadics) + ", " + ;
                EscaparSQL(ALLTRIM(THIS.this_cMoeqs)) + ", " + ;
                FormatarNumeroSQL(THIS.this_nQtdeqs) + ", " + ;
                FormatarNumeroSQL(THIS.this_nToleras) + ", " + ;
                EscaparSQL(ALLTRIM(THIS.this_cGrumoes)) + ", " + ;
                EscaparSQL(ALLTRIM(THIS.this_cSubmoes)) + ", " + ;
                IIF(THIS.this_lTabrefs, "1", "0") + ", " + ;
                EscaparSQL(ALLTRIM(THIS.this_cFpags)) + ", " + ;
                FormatarNumeroSQL(THIS.this_nConsultas) + ", " + ;
                FormatarNumeroSQL(THIS.this_nObgfator) + ")"

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nResult > 0
                THIS.RegistrarAuditoria("INSERT")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao inserir moeda:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em Inserir: " + loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    PROTECTED FUNCTION Atualizar()
        LOCAL loc_cSQL, loc_nResult, loc_lSucesso, loc_cDisfpres
        loc_lSucesso = .F.

        loc_cDisfpres = THIS.this_cDisfpres
        IF EMPTY(ALLTRIM(loc_cDisfpres))
            loc_cDisfpres = "S"
        ENDIF

        TRY
            loc_cSQL = "UPDATE SigCdMoe SET" + ;
                " dmoes = " + EscaparSQL(ALLTRIM(THIS.this_cDescricao)) + "," + ;
                " cotas = " + IIF(THIS.this_lCotas, "1", "0") + "," + ;
                " datatrans = GETDATE()," + ;
                " fmults = " + EscaparSQL(THIS.this_cFmults) + "," + ;
                " nordrels = " + FormatarNumeroSQL(THIS.this_nNordrels) + "," + ;
                " disfpres = " + EscaparSQL(loc_cDisfpres) + "," + ;
                " valadics = " + FormatarNumeroSQL(THIS.this_nValadics) + "," + ;
                " moeqs = " + EscaparSQL(ALLTRIM(THIS.this_cMoeqs)) + "," + ;
                " qtdeqs = " + FormatarNumeroSQL(THIS.this_nQtdeqs) + "," + ;
                " toleras = " + FormatarNumeroSQL(THIS.this_nToleras) + "," + ;
                " grumoes = " + EscaparSQL(ALLTRIM(THIS.this_cGrumoes)) + "," + ;
                " submoes = " + EscaparSQL(ALLTRIM(THIS.this_cSubmoes)) + "," + ;
                " tabrefs = " + IIF(THIS.this_lTabrefs, "1", "0") + "," + ;
                " fpags = " + EscaparSQL(ALLTRIM(THIS.this_cFpags)) + "," + ;
                " consultas = " + FormatarNumeroSQL(THIS.this_nConsultas) + "," + ;
                " obgfator = " + FormatarNumeroSQL(THIS.this_nObgfator) + ;
                " WHERE cmoes = " + EscaparSQL(ALLTRIM(THIS.this_cCodigo))

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nResult > 0
                THIS.RegistrarAuditoria("UPDATE")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao atualizar moeda:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em Atualizar: " + loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    PROTECTED FUNCTION ExecutarExclusao()
        LOCAL loc_cSQL, loc_nResult, loc_lSucesso, loc_lPodeExcluir
        loc_lSucesso   = .F.
        loc_lPodeExcluir = .F.

        *-- Verificar se há cotações cadastradas
        TRY
            IF USED("cursor_4c_VerifCot")
                USE IN cursor_4c_VerifCot
            ENDIF
            loc_cSQL = "SELECT TOP 1 cidchaves FROM SigCdCot" + ;
                " WHERE cmoes = " + EscaparSQL(ALLTRIM(THIS.this_cCodigo))
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_VerifCot")
            IF loc_nResult > 0 AND RECCOUNT("cursor_4c_VerifCot") > 0
                MsgErro("Imposs" + CHR(237) + "vel excluir moeda com cota" + CHR(231) + ;
                    CHR(227) + "o cadastrada!", "Exclus" + CHR(227) + "o Inv" + CHR(225) + "lida")
            ELSE
                loc_lPodeExcluir = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao verificar cota" + CHR(231) + CHR(245) + "es: " + loc_oErro.Message, "Erro")
        ENDTRY
        IF USED("cursor_4c_VerifCot")
            USE IN cursor_4c_VerifCot
        ENDIF

        IF loc_lPodeExcluir
            TRY
                loc_cSQL = "DELETE FROM SigCdMoe" + ;
                    " WHERE cmoes = " + EscaparSQL(ALLTRIM(THIS.this_cCodigo))
                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)
                IF loc_nResult > 0
                    THIS.RegistrarAuditoria("DELETE")
                    loc_lSucesso = .T.
                ELSE
                    MsgErro("Erro ao excluir moeda:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                ENDIF
            CATCH TO loc_oErro
                MsgErro("Erro em ExecutarExclusao: " + loc_oErro.Message, "Erro")
            ENDTRY
        ENDIF
        RETURN loc_lSucesso
    ENDFUNC

ENDDEFINE

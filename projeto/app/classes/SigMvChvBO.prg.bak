*==============================================================================
* SIGMVCHVBO.PRG
* Business Object - Chaves de Nota (SigMvChv)
*
* Form OPERACIONAL: dialogo auxiliar chamado por outro form para o usuario
* incluir/excluir Chaves de Nota (ChaveNota) associadas a um documento pai
* (EmpDopNums). No legado (SIGMVCHV.Init) o form manipula um cursor local
* crChaves ja populado pelo form chamador (Select crChaves / Go Top) e so
* grava a tabela real por fora (fluxo comentado no legado, nunca ativo).
*
* Tabela SigMvChv existe no schema (chavenota, empdopnums, pkchaves - mesmas
* 3 colunas do cursor crChaves) - este BO usa arquitetura em camadas (PILAR 3)
* e persiste cada linha na tabela via Inserir/Atualizar/ExecutarExclusao.
*==============================================================================

DEFINE CLASS SigMvChvBO AS BusinessBase

    *-- Propriedades especificas da entidade SigMvChv (linha do cursor crChaves)
    this_cChaveNota  = ""   && crChaves.ChaveNota  - chave da nota digitada pelo usuario
    this_cEmpDopNums = ""   && crChaves.EmpDopNums - empresa + numero do documento pai
    this_cPkChaves   = ""   && crChaves.pkChaves   - chave primaria Fortyus (Sys(2015)+Sys(2015))

    *--------------------------------------------------------------------------
    * Init - Construtor
    * Tabela SigMvChv (chavenota, empdopnums, pkchaves) existe no schema com
    * as mesmas 3 colunas do cursor local crChaves do legado - THIS BO grava
    * cada linha nela via Inserir/Atualizar (arquitetura camadas, PILAR 3).
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        DODEFAULT()

        THIS.this_cTabela     = "SigMvChv"
        THIS.this_cCampoChave = "pkChaves"

        THIS.this_cChaveNota  = ""
        THIS.this_cEmpDopNums = ""
        THIS.this_cPkChaves   = ""

        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Retorna chave primaria para auditoria
    *--------------------------------------------------------------------------
    PROCEDURE ObterChavePrimaria()
        RETURN ALLTRIM(THIS.this_cPkChaves)
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Carrega propriedades do BO a partir de uma linha do
    * cursor informado (crChaves ou cursor_4c_Dados, mesma estrutura)
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lResultado
        loc_lResultado = .F.

        TRY
            IF USED(par_cAliasCursor)
                SELECT (par_cAliasCursor)
                THIS.this_cChaveNota  = TratarNulo(ChaveNota, "C")
                THIS.this_cEmpDopNums = TratarNulo(EmpDopNums, "C")
                THIS.this_cPkChaves   = TratarNulo(pkChaves, "C")
                loc_lResultado = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * LimparDados - Limpa propriedades de dados
    *--------------------------------------------------------------------------
    PROCEDURE LimparDados()
        THIS.this_cChaveNota  = ""
        THIS.this_cEmpDopNums = ""
        THIS.this_cPkChaves   = ""
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarDados - Valida dados antes de salvar
    * Mesma checagem do legado: ChaveNota nao pode ficar vazia (Valid do
    * grade.Column1.Text1 so processa "If Not Empty(This.Value)")
    *--------------------------------------------------------------------------
    PROCEDURE ValidarDados()
        IF EMPTY(ALLTRIM(THIS.this_cChaveNota))
            THIS.this_cMensagemErro = "Chave da nota " + CHR(233) + " obrigat" + CHR(243) + "ria"
            MsgAviso(THIS.this_cMensagemErro, "Valida" + CHR(231) + CHR(227) + "o")
            RETURN .F.
        ENDIF

        IF EMPTY(ALLTRIM(THIS.this_cEmpDopNums))
            THIS.this_cMensagemErro = "Documento de origem (EmpDopNums) " + CHR(227) + "o informado"
            MsgAviso(THIS.this_cMensagemErro, "Valida" + CHR(231) + CHR(227) + "o")
            RETURN .F.
        ENDIF

        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * ExisteChaveDuplicada - Espelha o Valid do legado: bloqueia gravar duas
    * linhas com a mesma ChaveNota (Select ChaveNota, Count(*) ... Group By)
    *--------------------------------------------------------------------------
    PROCEDURE ExisteChaveDuplicada(par_cChaveNota, par_cPkChavesAtual)
        LOCAL loc_cSQL, loc_nResultado, loc_lDuplicada
        loc_lDuplicada = .F.

        TRY
            IF USED("cursor_4c_DupChv")
                USE IN cursor_4c_DupChv
            ENDIF

            loc_cSQL = "SELECT pkchaves FROM SigMvChv WHERE chavenota = " + ;
                       EscaparSQL(ALLTRIM(par_cChaveNota)) + ;
                       " AND empdopnums = " + EscaparSQL(ALLTRIM(THIS.this_cEmpDopNums)) + ;
                       " AND pkchaves <> " + EscaparSQL(ALLTRIM(par_cPkChavesAtual))

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_DupChv")

            IF loc_nResultado >= 0 AND RECCOUNT("cursor_4c_DupChv") > 0
                loc_lDuplicada = .T.
            ENDIF

            IF USED("cursor_4c_DupChv")
                USE IN cursor_4c_DupChv
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lDuplicada
    ENDPROC

    *--------------------------------------------------------------------------
    * Buscar - Lista as chaves de nota de um documento (grid da lista).
    * A grade edita ChaveNota diretamente na celula (transcricao do
    * grade.Column1.Text1 legado), entao o cursor NAO pode ficar somente-
    * leitura como o SQLEXEC entrega por padrao - converte via cursor
    * temporario para cursor_4c_Dados READWRITE.
    *--------------------------------------------------------------------------
    PROCEDURE Buscar(par_cFiltro)
        LOCAL loc_cSQL, loc_nResultado, loc_lResultado
        loc_lResultado = .F.

        TRY
            IF USED("cursor_4c_DadosTmp")
                USE IN cursor_4c_DadosTmp
            ENDIF
            IF USED("cursor_4c_Dados")
                USE IN cursor_4c_Dados
            ENDIF

            IF VARTYPE(par_cFiltro) = "C" AND !EMPTY(ALLTRIM(par_cFiltro))
                loc_cSQL = "SELECT chavenota AS ChaveNota, empdopnums AS EmpDopNums," + ;
                           " pkchaves AS pkChaves FROM SigMvChv" + ;
                           " WHERE empdopnums = " + EscaparSQL(ALLTRIM(par_cFiltro)) + ;
                           " ORDER BY chavenota"
            ELSE
                loc_cSQL = "SELECT chavenota AS ChaveNota, empdopnums AS EmpDopNums," + ;
                           " pkchaves AS pkChaves FROM SigMvChv ORDER BY chavenota"
            ENDIF

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_DadosTmp")

            IF loc_nResultado >= 0
                SELECT * FROM cursor_4c_DadosTmp INTO CURSOR cursor_4c_Dados READWRITE
                IF USED("cursor_4c_DadosTmp")
                    USE IN cursor_4c_DadosTmp
                ENDIF
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao buscar chaves de nota:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir - INSERT INTO SigMvChv (PROTECTED, chamado por Salvar())
    * Gera pkChaves via fUniqueIds() quando ainda nao preenchida, igual ao
    * legado (Sys(2015)+Sys(2015)) so que com o helper canonico do sistema.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Inserir()
        LOCAL loc_cSQL, loc_nResultado, loc_lResultado
        loc_lResultado = .F.

        TRY
            IF EMPTY(ALLTRIM(THIS.this_cPkChaves))
                THIS.this_cPkChaves = LEFT(fUniqueIds(), 20)
            ENDIF

            loc_cSQL = "INSERT INTO SigMvChv (chavenota, empdopnums, pkchaves) VALUES (" + ;
                       EscaparSQL(LEFT(ALLTRIM(THIS.this_cChaveNota), 44)) + ", " + ;
                       EscaparSQL(LEFT(ALLTRIM(THIS.this_cEmpDopNums), 29)) + ", " + ;
                       EscaparSQL(LEFT(ALLTRIM(THIS.this_cPkChaves), 20)) + ")"

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_InsChv")
            IF USED("cursor_4c_InsChv")
                USE IN cursor_4c_InsChv
            ENDIF

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("INSERT")
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao inserir chave de nota:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - UPDATE SigMvChv (PROTECTED, chamado por Salvar())
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Atualizar()
        LOCAL loc_cSQL, loc_nResultado, loc_lResultado
        loc_lResultado = .F.

        TRY
            IF EMPTY(ALLTRIM(THIS.this_cPkChaves))
                MsgErro("Chave prim" + CHR(225) + "ria n" + CHR(227) + "o informada para altera" + CHR(231) + CHR(227) + "o", "Erro")
            ELSE
                loc_cSQL = "UPDATE SigMvChv SET " + ;
                           "chavenota = " + EscaparSQL(LEFT(ALLTRIM(THIS.this_cChaveNota), 44)) + ", " + ;
                           "empdopnums = " + EscaparSQL(LEFT(ALLTRIM(THIS.this_cEmpDopNums), 29)) + ;
                           " WHERE pkchaves = " + EscaparSQL(ALLTRIM(THIS.this_cPkChaves))

                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_AltChv")
                IF USED("cursor_4c_AltChv")
                    USE IN cursor_4c_AltChv
                ENDIF

                IF loc_nResultado >= 0
                    THIS.RegistrarAuditoria("UPDATE")
                    loc_lResultado = .T.
                ELSE
                    MsgErro("Erro ao alterar chave de nota:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * ExecutarExclusao - DELETE FROM SigMvChv (PROTECTED, chamado por Excluir())
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ExecutarExclusao()
        LOCAL loc_cSQL, loc_nResultado, loc_lResultado
        loc_lResultado = .F.

        TRY
            IF EMPTY(ALLTRIM(THIS.this_cPkChaves))
                MsgErro("Chave prim" + CHR(225) + "ria n" + CHR(227) + "o informada para exclus" + CHR(227) + "o", "Erro")
            ELSE
                loc_cSQL = "DELETE FROM SigMvChv WHERE pkchaves = " + ;
                           EscaparSQL(ALLTRIM(THIS.this_cPkChaves))

                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ExcChv")
                IF USED("cursor_4c_ExcChv")
                    USE IN cursor_4c_ExcChv
                ENDIF

                IF loc_nResultado >= 0
                    THIS.RegistrarAuditoria("DELETE")
                    loc_lResultado = .T.
                ELSE
                    MsgErro("Erro ao excluir chave de nota:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

ENDDEFINE

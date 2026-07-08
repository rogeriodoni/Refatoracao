*==============================================================================
* SIGPRCOTBO.prg - Business Object para Cotacoes de Moeda
* Tabela: SigCdCot
* PK: cidchaves
*==============================================================================
DEFINE CLASS SIGPRCOTBO AS BusinessBase

    *-- Campos da tabela SigCdCot
    this_cCmoes     = ""    && char(3)       - Codigo da moeda
    this_dDatas     = {}    && date          - Data da cotacao
    this_cHoras     = ""    && char(8)       - Hora da cotacao (HH:MM:SS)
    this_nValos     = 0     && numeric(11,6) - Valor da cotacao
    this_cCidChaves = ""    && char(20)      - Chave unica (PK)
    this_dDtAlts    = {}    && date          - Data de alteracao
    this_cUsuars    = ""    && char(10)      - Usuario que cadastrou

    *--------------------------------------------------------------------------
    PROCEDURE Init()
        THIS.this_cTabela     = "SigCdCot"
        THIS.this_cCampoChave = "cidchaves"
        DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ObterChavePrimaria()
        RETURN THIS.this_cCidChaves
    ENDPROC

    *--------------------------------------------------------------------------
    * GerarChaveUnica - Substituto do fUniqueIds() do legado
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION GerarChaveUnica()
        RETURN LEFT(SYS(2015) + SYS(2015), 20)
    ENDFUNC

    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE CarregarDoCursor(par_cAliasCursor)
        IF USED(par_cAliasCursor)
            SELECT (par_cAliasCursor)
            THIS.this_cCmoes     = TratarNulo(cmoes,     "C")
            THIS.this_dDatas     = TratarNulo(datas,     "D")
            THIS.this_cHoras     = TratarNulo(horas,     "C")
            THIS.this_nValos     = TratarNulo(valos,     "N")
            THIS.this_cCidChaves = TratarNulo(cidchaves, "C")
            THIS.this_dDtAlts    = TratarNulo(dtalts,    "D")
            THIS.this_cUsuars    = TratarNulo(usuars,    "C")
            RETURN .T.
        ENDIF
        RETURN .F.
    ENDPROC

    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ValidarDados()
        IF EMPTY(THIS.this_cCmoes)
            MsgAviso("Informe o c" + CHR(243) + "digo da moeda.", "Aviso")
            RETURN .F.
        ENDIF
        IF EMPTY(THIS.this_dDatas)
            MsgAviso("Informe a data da cota" + CHR(231) + CHR(227) + "o.", "Aviso")
            RETURN .F.
        ENDIF
        IF EMPTY(THIS.this_cHoras)
            MsgAviso("Informe a hora da cota" + CHR(231) + CHR(227) + "o.", "Aviso")
            RETURN .F.
        ENDIF
        IF THIS.this_nValos = 0
            MsgAviso("Informe o valor da cota" + CHR(231) + CHR(227) + "o.", "Aviso")
            RETURN .F.
        ENDIF
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * ExecutarInsercao - Override BusinessBase: INSERT com this_* properties
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ExecutarInsercao()
        LOCAL loc_lSucesso, loc_cSQL
        loc_lSucesso = .F.
        TRY
            IF EMPTY(THIS.this_cCidChaves)
                THIS.this_cCidChaves = THIS.GerarChaveUnica()
            ENDIF
            THIS.this_dDtAlts = DATE()
            THIS.this_cUsuars = ALLTRIM(gc_4c_UsuarioLogado)

            loc_cSQL = "INSERT INTO SigCdCot " + ;
                       "(cmoes, datas, horas, valos, cidchaves, dtalts, usuars) " + ;
                       "VALUES (" + ;
                       EscaparSQL(ALLTRIM(THIS.this_cCmoes))    + ", " + ;
                       FormatarDataSQL(THIS.this_dDatas)         + ", " + ;
                       EscaparSQL(ALLTRIM(THIS.this_cHoras))    + ", " + ;
                       FormatarNumeroSQL(THIS.this_nValos)       + ", " + ;
                       EscaparSQL(ALLTRIM(THIS.this_cCidChaves)) + ", " + ;
                       FormatarDataSQL(THIS.this_dDtAlts)        + ", " + ;
                       EscaparSQL(ALLTRIM(THIS.this_cUsuars))   + ")"

            IF SQLEXEC(gnConnHandle, loc_cSQL) > 0
                THIS.RegistrarAuditoria("INSERIR")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao inserir cota" + CHR(231) + CHR(227) + "o.", "Erro")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ExecutarAtualizacao - Override BusinessBase: UPDATE com this_* properties
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ExecutarAtualizacao()
        LOCAL loc_lSucesso, loc_cSQL
        loc_lSucesso = .F.
        TRY
            THIS.this_dDtAlts = DATE()
            THIS.this_cUsuars = ALLTRIM(gc_4c_UsuarioLogado)

            loc_cSQL = "UPDATE SigCdCot SET " + ;
                       "datas  = " + FormatarDataSQL(THIS.this_dDatas)      + ", " + ;
                       "horas  = " + EscaparSQL(ALLTRIM(THIS.this_cHoras))  + ", " + ;
                       "valos  = " + FormatarNumeroSQL(THIS.this_nValos)    + ", " + ;
                       "dtalts = " + FormatarDataSQL(THIS.this_dDtAlts)     + ", " + ;
                       "usuars = " + EscaparSQL(ALLTRIM(THIS.this_cUsuars)) + " " + ;
                       "WHERE cidchaves = " + EscaparSQL(ALLTRIM(THIS.this_cCidChaves))

            IF SQLEXEC(gnConnHandle, loc_cSQL) > 0
                THIS.RegistrarAuditoria("ATUALIZAR")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao atualizar cota" + CHR(231) + CHR(227) + "o.", "Erro")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ExecutarExclusao - Override BusinessBase: DELETE pela PK
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ExecutarExclusao()
        LOCAL loc_lSucesso, loc_cSQL
        loc_lSucesso = .F.
        TRY
            loc_cSQL = "DELETE FROM SigCdCot WHERE cidchaves = " + ;
                       EscaparSQL(ALLTRIM(THIS.this_cCidChaves))

            IF SQLEXEC(gnConnHandle, loc_cSQL) > 0
                THIS.RegistrarAuditoria("EXCLUIR")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao excluir cota" + CHR(231) + CHR(227) + "o.", "Erro")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * BuscarCotacoes - Carrega cotacoes de uma moeda no cursor de trabalho
    * Usa cursor temporario + ZAP/APPEND para nao destruir colunas do grid
    *--------------------------------------------------------------------------
    PROCEDURE BuscarCotacoes(par_cMoes)
        LOCAL loc_lSucesso, loc_cSQL, loc_cMoesFmt
        loc_lSucesso = .F.
        TRY
            loc_cMoesFmt = EscaparSQL(ALLTRIM(par_cMoes))
            loc_cSQL = "SELECT cmoes, datas, horas, valos, cidchaves, dtalts, usuars " + ;
                       "FROM SigCdCot " + ;
                       "WHERE cmoes = " + loc_cMoesFmt + " " + ;
                       "ORDER BY datas, horas"

            IF USED("cursor_4c_CotacoesTemp")
                USE IN cursor_4c_CotacoesTemp
            ENDIF

            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_CotacoesTemp") > 0
                IF USED("cursor_4c_Cotacoes")
                    *-- Cursor ja existe (grid bound): apenas limpar e recarregar
                    SELECT cursor_4c_Cotacoes
                    ZAP
                    APPEND FROM DBF("cursor_4c_CotacoesTemp")
                    GO BOTTOM
                ELSE
                    *-- Primeira carga: criar cursor com estrutura e indices
                    SET NULL ON
                    CREATE CURSOR cursor_4c_Cotacoes ;
                        (cmoes C(3) NULL, datas D NULL, horas C(8) NULL, ;
                         valos N(11,6) NULL, cidchaves C(20) NULL, ;
                         dtalts D NULL, usuars C(10) NULL)
                    SET NULL OFF
                    INDEX ON ALLTRIM(cidchaves) TAG cidchaves
                    INDEX ON ALLTRIM(cmoes) + DTOS(datas) + ALLTRIM(horas) TAG cotacaos
                    APPEND FROM DBF("cursor_4c_CotacoesTemp")
                    GO BOTTOM
                ENDIF
                USE IN cursor_4c_CotacoesTemp
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao carregar cota" + CHR(231) + CHR(245) + "es.", "Erro")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * InserirNovaCotacao - Insere nova linha com data/hora atuais e valos=0
    * Replica inserir.Click do legado: persiste no SQL + adiciona ao cursor local
    * O usuario preenche o valor (valos) diretamente no grid apos a insercao
    *--------------------------------------------------------------------------
    PROCEDURE InserirNovaCotacao(par_cMoes)
        LOCAL loc_lSucesso, loc_cSQL, loc_cChave, loc_cMoesFmt
        LOCAL loc_cDtFmt, loc_cHora, loc_cDtAltFmt, loc_cUsuFmt
        loc_lSucesso = .F.
        TRY
            loc_cChave    = THIS.GerarChaveUnica()
            loc_cMoesFmt  = EscaparSQL(ALLTRIM(par_cMoes))
            loc_cDtFmt    = FormatarDataSQL(DATE())
            loc_cHora     = TIME()
            loc_cDtAltFmt = FormatarDataSQL(DATE())
            loc_cUsuFmt   = EscaparSQL(ALLTRIM(gc_4c_UsuarioLogado))

            *-- Inserir no SQL Server sem valos (usuario preenche no grid)
            loc_cSQL = "INSERT INTO SigCdCot " + ;
                       "(cmoes, datas, horas, cidchaves, dtalts, usuars) " + ;
                       "VALUES (" + ;
                       loc_cMoesFmt          + ", " + ;
                       loc_cDtFmt            + ", " + ;
                       EscaparSQL(loc_cHora) + ", " + ;
                       EscaparSQL(loc_cChave)+ ", " + ;
                       loc_cDtAltFmt         + ", " + ;
                       loc_cUsuFmt           + ")"

            IF SQLEXEC(gnConnHandle, loc_cSQL) > 0
                *-- Adicionar ao cursor de trabalho para exibicao imediata no grid
                IF USED("cursor_4c_Cotacoes")
                    SELECT cursor_4c_Cotacoes
                    SET ORDER TO
                    INSERT INTO cursor_4c_Cotacoes ;
                        (cmoes, datas, horas, valos, cidchaves, dtalts, usuars) ;
                        VALUES ;
                        (par_cMoes, DATE(), loc_cHora, 0, ;
                         loc_cChave, DATE(), ALLTRIM(gc_4c_UsuarioLogado))
                ENDIF
                THIS.this_cCidChaves = loc_cChave
                THIS.RegistrarAuditoria("INSERIR")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao inserir cota" + CHR(231) + CHR(227) + "o.", "Erro")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ExcluirCotacaoAtual - Exclui cotacao do SQL Server pelo cidchaves
    * Replica delete.Click do legado
    *--------------------------------------------------------------------------
    PROCEDURE ExcluirCotacaoAtual(par_cCidChaves)
        LOCAL loc_lSucesso, loc_cSQL, loc_cChaveFmt
        loc_lSucesso = .F.
        TRY
            IF EMPTY(par_cCidChaves)
                MsgAviso("Nenhum registro selecionado para exclus" + CHR(227) + "o.", "Aviso")
                loc_lSucesso = .F.
            ENDIF
            loc_cChaveFmt = EscaparSQL(ALLTRIM(par_cCidChaves))
            loc_cSQL = "DELETE FROM SigCdCot WHERE cidchaves = " + loc_cChaveFmt

            IF SQLEXEC(gnConnHandle, loc_cSQL) > 0
                THIS.this_cCidChaves = par_cCidChaves
                THIS.RegistrarAuditoria("EXCLUIR")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao excluir cota" + CHR(231) + CHR(227) + "o.", "Erro")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * VerificarCotacaoDuplicada - Checa se ja existe cotacao para moeda+data+hora
    * Replica hora.Text1.Valid do legado
    * Retorna .T. se duplicata encontrada (excluindo o proprio registro atual)
    *--------------------------------------------------------------------------
    PROCEDURE VerificarCotacaoDuplicada(par_cMoes, par_dDatas, par_cHoras, par_cCidChavesAtual)
        LOCAL loc_lDuplicada
        loc_lDuplicada = .F.
        TRY
            IF USED("cursor_4c_Cotacoes")
                SELECT cursor_4c_Cotacoes
                SET ORDER TO cotacaos
                IF SEEK(ALLTRIM(par_cMoes) + DTOS(par_dDatas) + ALLTRIM(par_cHoras))
                    IF ALLTRIM(cidchaves) <> ALLTRIM(par_cCidChavesAtual)
                        loc_lDuplicada = .T.
                    ENDIF
                ENDIF
                SET ORDER TO
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lDuplicada
    ENDPROC

    *--------------------------------------------------------------------------
    * SalvarCotacoes - Persiste todas as alteracoes do cursor no SQL Server
    * Replica sair.Click do legado: remove invalidos e atualiza validos
    *--------------------------------------------------------------------------
    PROCEDURE SalvarCotacoes()
        LOCAL loc_lSucesso, loc_cSQL, loc_cChaveFmt, loc_cDtFmt, loc_cHoraFmt, loc_cValFmt
        loc_lSucesso = .F.
        TRY
            IF !USED("cursor_4c_Cotacoes")
                loc_lSucesso = .F.
            ENDIF

            *-- Remover registros invalidos (sem data)
            SELECT cursor_4c_Cotacoes
            GO TOP
            SCAN
                IF EMPTY(cursor_4c_Cotacoes.datas)
                    IF !EMPTY(ALLTRIM(cursor_4c_Cotacoes.cidchaves))
                        loc_cChaveFmt = EscaparSQL(ALLTRIM(cursor_4c_Cotacoes.cidchaves))
                        loc_cSQL = "DELETE FROM SigCdCot WHERE cidchaves = " + loc_cChaveFmt
                        SQLEXEC(gnConnHandle, loc_cSQL)
                    ENDIF
                    DELETE
                ENDIF
                SELECT cursor_4c_Cotacoes
            ENDSCAN

            *-- Atualizar registros validos no SQL Server com valores editados no grid
            SELECT cursor_4c_Cotacoes
            GO TOP
            SCAN
                IF !DELETED() AND !EMPTY(ALLTRIM(cursor_4c_Cotacoes.cidchaves))
                    loc_cChaveFmt = EscaparSQL(ALLTRIM(cursor_4c_Cotacoes.cidchaves))
                    loc_cDtFmt    = FormatarDataSQL(cursor_4c_Cotacoes.datas)
                    loc_cHoraFmt  = EscaparSQL(ALLTRIM(cursor_4c_Cotacoes.horas))
                    loc_cValFmt   = FormatarNumeroSQL(cursor_4c_Cotacoes.valos)

                    loc_cSQL = "UPDATE SigCdCot SET " + ;
                               "datas = " + loc_cDtFmt   + ", " + ;
                               "horas = " + loc_cHoraFmt + ", " + ;
                               "valos = " + loc_cValFmt  + " " + ;
                               "WHERE cidchaves = " + loc_cChaveFmt

                    SQLEXEC(gnConnHandle, loc_cSQL)
                ENDIF
                SELECT cursor_4c_Cotacoes
            ENDSCAN

            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

ENDDEFINE

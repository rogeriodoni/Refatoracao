*====================================================================
* SigPrCarBO.prg
* Business Object: Caracteristicas do Produto (sigprcar)
* Tabela principal: sigprcar
* Sub-form: aberto pelo form de produto (SigPrApr/SigPrAop)
*====================================================================

DEFINE CLASS SigPrCarBO AS BusinessBase

    *-- Campos da tabela sigprcar
    this_cCodigos  = ""    && char(20) - codigo da caracteristica (FK SIGCRRAP)
    this_cCpros    = ""    && char(14) - codigo do produto (FK SigCdPro)
    this_cPkChaves = ""    && char(20) - chave primaria

    *-- Campo de exibicao: vem de SIGCRRAP.descrs, NAO armazenado em sigprcar
    this_cDescrs   = ""    && char(40) - descricao da caracteristica

    *-- Contexto do produto pai (passado pelo form chamador)
    this_cCgrus    = ""    && char(3) - grupo do produto (filtro de lookup SigCrRap)

    *-- Flags de controle de sessao (consultados pelo form pai apos fechar)
    this_lHouveIncl = .F.  && houve insercao nesta sessao
    this_lHouveExcl = .F.  && houve exclusao nesta sessao

    *====================================================================
    * Init - Inicializa Business Object
    *====================================================================
    PROCEDURE Init()
        DODEFAULT()
        THIS.this_cTabela     = "sigprcar"
        THIS.this_cCampoChave = "pkchaves"
        RETURN .T.
    ENDPROC

    *====================================================================
    * CarregarDoCursor - Carrega propriedades do BO a partir de um cursor
    * par_cAliasCursor: alias do cursor (crSigPrCar ou outro)
    *====================================================================
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        IF USED(par_cAliasCursor)
            SELECT (par_cAliasCursor)
            THIS.this_cCodigos  = TratarNulo(codigos,  "C")
            THIS.this_cCpros    = TratarNulo(cpros,    "C")
            THIS.this_cPkChaves = TratarNulo(pkchaves, "C")
            IF TYPE("descrs") != "U"
                THIS.this_cDescrs = TratarNulo(descrs, "C")
            ENDIF
            RETURN .T.
        ENDIF
        RETURN .F.
    ENDPROC

    *====================================================================
    * ObterChavePrimaria - Retorna valor da chave primaria (pkchaves)
    *====================================================================
    PROTECTED FUNCTION ObterChavePrimaria()
        RETURN THIS.this_cPkChaves
    ENDFUNC

    *====================================================================
    * Inserir - SQL INSERT INTO sigprcar
    *====================================================================
    PROTECTED PROCEDURE Inserir()
        LOCAL loc_lResultado, loc_cSQL, loc_oErro
        loc_lResultado = .F.
        TRY
            loc_cSQL = "INSERT INTO sigprcar (codigos, cpros, pkchaves) VALUES (" + ;
                       EscaparSQL(THIS.this_cCodigos) + ", " + ;
                       EscaparSQL(THIS.this_cCpros)   + ", " + ;
                       EscaparSQL(THIS.this_cPkChaves) + ")"
            IF SQLEXEC(gnConnHandle, loc_cSQL) > 0
                THIS.RegistrarAuditoria("INSERIR")
                loc_lResultado = .T.
            ELSE
                THIS.this_cMensagemErro = "Erro ao inserir caracter" + CHR(237) + "stica do produto."
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = "Erro ao inserir: " + loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    *====================================================================
    * Atualizar - SQL UPDATE sigprcar
    *====================================================================
    PROTECTED PROCEDURE Atualizar()
        LOCAL loc_lResultado, loc_cSQL, loc_oErro
        loc_lResultado = .F.
        TRY
            loc_cSQL = "UPDATE sigprcar SET codigos = " + ;
                       EscaparSQL(THIS.this_cCodigos) + ;
                       " WHERE pkchaves = " + EscaparSQL(THIS.this_cPkChaves)
            IF SQLEXEC(gnConnHandle, loc_cSQL) > 0
                THIS.RegistrarAuditoria("ATUALIZAR")
                loc_lResultado = .T.
            ELSE
                THIS.this_cMensagemErro = "Erro ao atualizar caracter" + CHR(237) + "stica do produto."
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = "Erro ao atualizar: " + loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    *====================================================================
    * ExecutarExclusao - SQL DELETE FROM sigprcar
    *====================================================================
    PROTECTED PROCEDURE ExecutarExclusao()
        LOCAL loc_lResultado, loc_cSQL, loc_oErro
        loc_lResultado = .F.
        TRY
            loc_cSQL = "DELETE FROM sigprcar WHERE pkchaves = " + ;
                       EscaparSQL(THIS.this_cPkChaves)
            IF SQLEXEC(gnConnHandle, loc_cSQL) > 0
                THIS.RegistrarAuditoria("EXCLUIR")
                loc_lResultado = .T.
            ELSE
                THIS.this_cMensagemErro = "Erro ao excluir caracter" + CHR(237) + "stica do produto."
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = "Erro ao excluir: " + loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    *====================================================================
    * InserirNovaLinha - Insere linha vazia no cursor local
    * Equivalente a cmdInserir.Click do legado
    * par_cCursorCarac: alias do cursor local (ex: "crSigPrCar")
    * par_cCpros: codigo do produto pai
    *====================================================================
    PROCEDURE InserirNovaLinha(par_cCursorCarac, par_cCpros)
        LOCAL loc_lResultado, loc_cPkChaves, loc_oErro
        loc_lResultado = .F.
        TRY
            IF !USED(par_cCursorCarac)
                THIS.this_cMensagemErro = "Cursor " + par_cCursorCarac + ;
                    " n" + CHR(227) + "o est" + CHR(225) + " aberto."
            ELSE
                *-- Verifica se ja existe linha vazia para este produto
                SELECT (par_cCursorCarac)
                LOCATE FOR RTRIM(cpros) == RTRIM(par_cCpros) AND EMPTY(codigos) AND !DELETED()
                IF !EOF()
                    loc_lResultado = .T.
                ELSE
                    *-- Obtem chave unica do SQL Server
                    IF SQLEXEC(gnConnHandle, "SELECT CAST(NEWID() AS CHAR(36)) AS nid", "cursor_4c_PrCarNewid") > 0
                        SELECT cursor_4c_PrCarNewid
                        loc_cPkChaves = LEFT(ALLTRIM(nid), 20)
                        USE IN cursor_4c_PrCarNewid
                    ELSE
                        loc_cPkChaves = LEFT(SYS(2015) + SYS(2015), 20)
                    ENDIF

                    *-- Insere linha vazia no cursor local
                    SELECT (par_cCursorCarac)
                    INSERT INTO (par_cCursorCarac) (cpros, pkchaves, codigos, descrs) ;
                        VALUES (par_cCpros, loc_cPkChaves, "", "")

                    THIS.this_lHouveIncl = .T.
                    loc_lResultado = .T.
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = "Erro ao inserir nova linha: " + loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    *====================================================================
    * ExcluirLinhaAtual - Remove o registro corrente do cursor local
    * Equivalente a cmdExcluir.Click do legado
    * par_cCursorCarac: alias do cursor local
    * par_cCpros: codigo do produto (verificacao de seguranca)
    *====================================================================
    PROCEDURE ExcluirLinhaAtual(par_cCursorCarac, par_cCpros)
        LOCAL loc_lResultado, loc_oErro
        loc_lResultado = .F.
        TRY
            IF !USED(par_cCursorCarac)
                THIS.this_cMensagemErro = "Cursor " + par_cCursorCarac + ;
                    " n" + CHR(227) + "o est" + CHR(225) + " aberto."
            ELSE
                SELECT (par_cCursorCarac)
                IF !EOF() AND RTRIM(cpros) == RTRIM(par_cCpros)
                    DELETE
                    SKIP
                    SKIP -1
                    THIS.this_lHouveExcl = .T.
                    loc_lResultado = .T.
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = "Erro ao excluir linha: " + loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    *====================================================================
    * LimparLinhasVazias - Remove linhas sem codigo do cursor local
    * Chamado antes de fechar o form (cmdSair.Click do legado)
    * par_cCursorCarac: alias do cursor local
    *====================================================================
    PROCEDURE LimparLinhasVazias(par_cCursorCarac)
        LOCAL loc_oErro
        TRY
            IF USED(par_cCursorCarac)
                SELECT (par_cCursorCarac)
                SCAN WHILE !EOF()
                    IF EMPTY(codigos)
                        DELETE
                    ENDIF
                ENDSCAN
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = "Erro ao limpar linhas vazias: " + loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *====================================================================
    * BuscarCodigoExato - Busca codigo exato em SIGCRRAP
    * Retorna .T. se encontrado, cursor par_cCursorDestino tem 1 linha
    * par_cCodigos: valor a buscar
    * par_cCgrus: grupo do produto (filtro)
    * par_cCursorDestino: cursor a popular com resultado
    *====================================================================
    PROCEDURE BuscarCodigoExato(par_cCodigos, par_cCgrus, par_cCursorDestino)
        LOCAL loc_lResultado, loc_cSQL, loc_oErro
        loc_lResultado = .F.
        TRY
            IF USED(par_cCursorDestino)
                USE IN (par_cCursorDestino)
            ENDIF

            loc_cSQL = "SELECT TOP 1 codigos, descrs FROM SIGCRRAP " + ;
                       "WHERE codigos = " + EscaparSQL(par_cCodigos) + ;
                       " AND cgrus IN (" + EscaparSQL(par_cCgrus) + ", '   ')"

            IF SQLEXEC(gnConnHandle, loc_cSQL, par_cCursorDestino) > 0
                SELECT (par_cCursorDestino)
                loc_lResultado = !EOF()
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = "Erro ao buscar c" + CHR(243) + "digo: " + loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    *====================================================================
    * BuscarDescricaoExata - Busca descricao exata em SIGCRRAP
    * Retorna .T. se encontrado, cursor par_cCursorDestino tem 1 linha
    *====================================================================
    PROCEDURE BuscarDescricaoExata(par_cDescrs, par_cCgrus, par_cCursorDestino)
        LOCAL loc_lResultado, loc_cSQL, loc_oErro
        loc_lResultado = .F.
        TRY
            IF USED(par_cCursorDestino)
                USE IN (par_cCursorDestino)
            ENDIF

            loc_cSQL = "SELECT TOP 1 codigos, descrs FROM SIGCRRAP " + ;
                       "WHERE descrs = " + EscaparSQL(par_cDescrs) + ;
                       " AND cgrus IN (" + EscaparSQL(par_cCgrus) + ", '   ')"

            IF SQLEXEC(gnConnHandle, loc_cSQL, par_cCursorDestino) > 0
                SELECT (par_cCursorDestino)
                loc_lResultado = !EOF()
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = "Erro ao buscar descri" + CHR(231) + CHR(227) + "o: " + loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    *====================================================================
    * BuscarCaracteristicasPorCodigo - Lista para picker (Column1)
    * Busca registros em SIGCRRAP por LIKE no campo codigos
    * par_cValor: prefixo digitado
    * par_cCgrus: grupo do produto (filtro)
    * par_cCursorDestino: cursor a popular
    *====================================================================
    PROCEDURE BuscarCaracteristicasPorCodigo(par_cValor, par_cCgrus, par_cCursorDestino)
        LOCAL loc_lResultado, loc_cSQL, loc_oErro, loc_cLike
        loc_lResultado = .F.
        TRY
            IF USED(par_cCursorDestino)
                USE IN (par_cCursorDestino)
            ENDIF

            IF EMPTY(par_cValor)
                loc_cSQL = "SELECT codigos, descrs FROM SIGCRRAP " + ;
                           "WHERE cgrus IN (" + EscaparSQL(par_cCgrus) + ", '   ') " + ;
                           "ORDER BY codigos"
            ELSE
                loc_cLike = EscaparSQL(RTRIM(par_cValor) + "%")
                loc_cSQL = "SELECT codigos, descrs FROM SIGCRRAP " + ;
                           "WHERE codigos LIKE " + loc_cLike + ;
                           " AND cgrus IN (" + EscaparSQL(par_cCgrus) + ", '   ') " + ;
                           "ORDER BY codigos"
            ENDIF

            IF SQLEXEC(gnConnHandle, loc_cSQL, par_cCursorDestino) > 0
                loc_lResultado = .T.
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = "Erro ao buscar caracter" + CHR(237) + "sticas: " + loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    *====================================================================
    * BuscarCaracteristicasPorDescricao - Lista para picker (Column2)
    * Busca registros em SIGCRRAP por LIKE no campo descrs
    *====================================================================
    PROCEDURE BuscarCaracteristicasPorDescricao(par_cValor, par_cCgrus, par_cCursorDestino)
        LOCAL loc_lResultado, loc_cSQL, loc_oErro, loc_cLike
        loc_lResultado = .F.
        TRY
            IF USED(par_cCursorDestino)
                USE IN (par_cCursorDestino)
            ENDIF

            IF EMPTY(par_cValor)
                loc_cSQL = "SELECT codigos, descrs FROM SIGCRRAP " + ;
                           "WHERE cgrus IN (" + EscaparSQL(par_cCgrus) + ", '   ') " + ;
                           "ORDER BY descrs"
            ELSE
                loc_cLike = EscaparSQL(RTRIM(par_cValor) + "%")
                loc_cSQL = "SELECT codigos, descrs FROM SIGCRRAP " + ;
                           "WHERE descrs LIKE " + loc_cLike + ;
                           " AND cgrus IN (" + EscaparSQL(par_cCgrus) + ", '   ') " + ;
                           "ORDER BY descrs"
            ENDIF

            IF SQLEXEC(gnConnHandle, loc_cSQL, par_cCursorDestino) > 0
                loc_lResultado = .T.
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = "Erro ao buscar caracter" + CHR(237) + "sticas: " + loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    *====================================================================
    * VerificarDuplicidade - Checa se codigo ja existe no cursor local
    * para o mesmo produto (exceto o registro corrente)
    * Retorna .T. se duplicado
    * par_cCodigos: codigo a verificar
    * par_cPkChaveAtual: pkchaves do registro corrente (excluido da busca)
    * par_cCursorCarac: alias do cursor local
    *====================================================================
    PROCEDURE VerificarDuplicidade(par_cCodigos, par_cPkChaveAtual, par_cCursorCarac)
        LOCAL loc_lDuplicado, loc_oErro
        loc_lDuplicado = .F.
        TRY
            IF USED(par_cCursorCarac) AND !EMPTY(par_cCodigos)
                SELECT codigos FROM (par_cCursorCarac) ;
                    WHERE RTRIM(codigos) == RTRIM(par_cCodigos) ;
                    AND RTRIM(pkchaves) != RTRIM(par_cPkChaveAtual) ;
                    AND !DELETED() ;
                    INTO CURSOR cursor_4c_PrCarDupCheck
                SELECT cursor_4c_PrCarDupCheck
                loc_lDuplicado = !EOF()
                USE IN cursor_4c_PrCarDupCheck
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = "Erro ao verificar duplicidade: " + loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lDuplicado
    ENDPROC

    *====================================================================
    * SalvarTodasCaracteristicas - Persiste cursor local no SQL Server
    * Chamado pelo form pai (SigPrAop/SigPrApr) ao salvar o produto
    * Estrategia: DELETE todas as do produto + INSERT das validas
    * par_cCursorCarac: alias do cursor local
    * par_cCpros: codigo do produto pai
    *====================================================================
    PROCEDURE SalvarTodasCaracteristicas(par_cCursorCarac, par_cCpros)
        LOCAL loc_lResultado, loc_cSQL, loc_oErro, loc_lOk
        loc_lResultado = .F.
        TRY
            *-- Remove todas as caracteristicas anteriores do produto
            loc_cSQL = "DELETE FROM sigprcar WHERE cpros = " + EscaparSQL(par_cCpros)
            IF SQLEXEC(gnConnHandle, loc_cSQL) >= 0
                loc_lOk = .T.
                *-- Reinsere todas as linhas validas do cursor local
                IF USED(par_cCursorCarac)
                    SELECT (par_cCursorCarac)
                    GO TOP
                    SCAN WHILE !EOF() AND loc_lOk
                        IF !DELETED() AND !EMPTY(codigos)
                            loc_cSQL = "INSERT INTO sigprcar (codigos, cpros, pkchaves) VALUES (" + ;
                                       EscaparSQL(codigos) + ", " + ;
                                       EscaparSQL(par_cCpros) + ", " + ;
                                       EscaparSQL(pkchaves) + ")"
                            IF SQLEXEC(gnConnHandle, loc_cSQL) < 0
                                THIS.this_cMensagemErro = "Erro ao salvar caracter" + ;
                                    CHR(237) + "stica: " + ALLTRIM(codigos)
                                loc_lOk = .F.
                            ENDIF
                        ENDIF
                    ENDSCAN
                ENDIF
                IF loc_lOk
                    loc_lResultado = .T.
                ENDIF
            ELSE
                THIS.this_cMensagemErro = "Erro ao excluir caracter" + CHR(237) + ;
                    "sticas anteriores do produto."
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = "Erro ao salvar caracter" + CHR(237) + ;
                "sticas: " + loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

ENDDEFINE

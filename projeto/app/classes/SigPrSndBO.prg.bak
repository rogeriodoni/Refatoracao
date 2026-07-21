*==============================================================================
* SigPrSndBO.prg - Business Object: Senhas Livres
* Tabela: SigPrSnd
* Chave: cidchaves char(20)
*==============================================================================
DEFINE CLASS SigPrSndBO AS BusinessBase

    *-- Configuracao da tabela
    this_cTabela      = "SigPrSnd"
    this_cCampoChave  = "cidchaves"

    *-- Propriedades mapeadas para colunas de SigPrSnd
    this_cCidChaves   = ""   && cidchaves char(20) PK NOT NULL
    this_dDatas       = {}   && datas     datetime NULL
    this_nDocs        = 0    && docs      numeric(10,0) NOT NULL
    this_cHoras       = ""   && horas     char(8) NOT NULL
    this_cMotivos     = ""   && motivos   char(40) NOT NULL
    this_cOperas      = ""   && operas    char(20) NOT NULL
    this_cSenhads     = ""   && senhads   char(6) NOT NULL
    this_cSolicits    = ""   && solicits  char(10) NOT NULL
    this_cUsuars      = ""   && usuars    char(10) NOT NULL
    this_nValors      = 0    && valors    numeric(11,2) NOT NULL
    this_nTipos       = 0    && tipos     numeric(1,0) NOT NULL
    this_cEmps        = ""   && emps      char(3) NOT NULL
    this_cFpags       = ""   && fpags     char(12) NOT NULL
    this_cEmpDopNums  = ""   && empdopnums char(29) NOT NULL
    this_nPerlimite   = 0    && perlimite numeric(5,2) NOT NULL

    *--------------------------------------------------------------------------
    PROCEDURE Init()
        THIS.this_cTabela     = "SigPrSnd"
        THIS.this_cCampoChave = "cidchaves"
        DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    FUNCTION ObterChavePrimaria()
        RETURN THIS.this_cCidChaves
    ENDFUNC

    *--------------------------------------------------------------------------
    * Buscar - Inicializa cursor vazio com estrutura de SigPrSnd
    *--------------------------------------------------------------------------
    PROCEDURE Buscar(par_cFiltro)
        LOCAL loc_lSucesso, loc_cSQL
        loc_lSucesso = .F.
        TRY
            *-- Query que retorna 0 registros para criar cursor estruturado vazio
            loc_cSQL = "SELECT * FROM SigPrSnd WHERE cidchaves = " + ;
                EscaparSQL(REPLICATE(CHR(254), 20))
            IF USED("crSigPrSnd")
                USE IN crSigPrSnd
            ENDIF
            IF SQLEXEC(gnConnHandle, loc_cSQL, "crSigPrSnd") > 0
                SELECT crSigPrSnd
                GO TOP
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Mapeia campos do cursor para propriedades do BO
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            IF USED(par_cAliasCursor)
                SELECT (par_cAliasCursor)
                THIS.this_cCidChaves  = TratarNulo(cidchaves,  "C")
                THIS.this_dDatas      = TratarNulo(datas,      "D")
                THIS.this_nDocs       = TratarNulo(docs,       "N")
                THIS.this_cHoras      = TratarNulo(horas,      "C")
                THIS.this_cMotivos    = TratarNulo(motivos,    "C")
                THIS.this_cOperas     = TratarNulo(operas,     "C")
                THIS.this_cSenhads    = TratarNulo(senhads,    "C")
                THIS.this_cSolicits   = TratarNulo(solicits,   "C")
                THIS.this_cUsuars     = TratarNulo(usuars,     "C")
                THIS.this_nValors     = TratarNulo(valors,     "N")
                THIS.this_nTipos      = TratarNulo(tipos,      "N")
                THIS.this_cEmps       = TratarNulo(emps,       "C")
                THIS.this_cFpags      = TratarNulo(fpags,      "C")
                THIS.this_cEmpDopNums = TratarNulo(empdopnums, "C")
                THIS.this_nPerlimite  = TratarNulo(perlimite,  "N")
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir - INSERT INTO SigPrSnd (todas as colunas NOT NULL)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Inserir()
        LOCAL loc_lSucesso, loc_cSQL
        loc_lSucesso = .F.
        TRY
            IF EMPTY(THIS.this_cCidChaves)
                THIS.this_cCidChaves = THIS.GerarIdUnico()
            ENDIF
            loc_cSQL = "INSERT INTO SigPrSnd " + ;
                "(cidchaves, usuars, datas, tipos, senhads, horas, " + ;
                " emps, docs, motivos, operas, solicits, valors, fpags, empdopnums, perlimite) " + ;
                "VALUES (" + ;
                EscaparSQL(THIS.this_cCidChaves)              + ", " + ;
                EscaparSQL(LEFT(THIS.this_cUsuars, 10))       + ", " + ;
                "GETDATE(), "                                          + ;
                FormatarNumeroSQL(THIS.this_nTipos, 0)        + ", " + ;
                EscaparSQL(LEFT(THIS.this_cSenhads, 6))       + ", " + ;
                EscaparSQL(LEFT(THIS.this_cHoras, 8))         + ", " + ;
                EscaparSQL(LEFT(THIS.this_cEmps, 3))          + ", " + ;
                FormatarNumeroSQL(THIS.this_nDocs, 0)         + ", " + ;
                EscaparSQL(LEFT(THIS.this_cMotivos, 40))      + ", " + ;
                EscaparSQL(LEFT(THIS.this_cOperas, 20))       + ", " + ;
                EscaparSQL(LEFT(THIS.this_cSolicits, 10))     + ", " + ;
                FormatarNumeroSQL(THIS.this_nValors, 2)       + ", " + ;
                EscaparSQL(LEFT(THIS.this_cFpags, 12))        + ", " + ;
                EscaparSQL(LEFT(THIS.this_cEmpDopNums, 29))   + ", " + ;
                FormatarNumeroSQL(THIS.this_nPerlimite, 2)    + ;
                ")"
            IF SQLEXEC(gnConnHandle, loc_cSQL) > 0
                THIS.RegistrarAuditoria("I")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao inserir senha em SigPrSnd.", "Erro")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - UPDATE SigPrSnd
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Atualizar()
        LOCAL loc_lSucesso, loc_cSQL
        loc_lSucesso = .F.
        TRY
            loc_cSQL = "UPDATE SigPrSnd SET " + ;
                "usuars     = " + EscaparSQL(LEFT(THIS.this_cUsuars, 10))     + ", " + ;
                "datas      = " + FormatarDataSQL(THIS.this_dDatas)           + ", " + ;
                "tipos      = " + FormatarNumeroSQL(THIS.this_nTipos, 0)      + ", " + ;
                "senhads    = " + EscaparSQL(LEFT(THIS.this_cSenhads, 6))     + ", " + ;
                "horas      = " + EscaparSQL(LEFT(THIS.this_cHoras, 8))       + ", " + ;
                "emps       = " + EscaparSQL(LEFT(THIS.this_cEmps, 3))        + ", " + ;
                "docs       = " + FormatarNumeroSQL(THIS.this_nDocs, 0)       + ", " + ;
                "motivos    = " + EscaparSQL(LEFT(THIS.this_cMotivos, 40))    + ", " + ;
                "operas     = " + EscaparSQL(LEFT(THIS.this_cOperas, 20))     + ", " + ;
                "solicits   = " + EscaparSQL(LEFT(THIS.this_cSolicits, 10))   + ", " + ;
                "valors     = " + FormatarNumeroSQL(THIS.this_nValors, 2)     + ", " + ;
                "fpags      = " + EscaparSQL(LEFT(THIS.this_cFpags, 12))      + ", " + ;
                "empdopnums = " + EscaparSQL(LEFT(THIS.this_cEmpDopNums, 29)) + ", " + ;
                "perlimite  = " + FormatarNumeroSQL(THIS.this_nPerlimite, 2)  + " "  + ;
                "WHERE cidchaves = " + EscaparSQL(THIS.this_cCidChaves)
            IF SQLEXEC(gnConnHandle, loc_cSQL) > 0
                THIS.RegistrarAuditoria("A")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao atualizar senha em SigPrSnd.", "Erro")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ExecutarExclusao - DELETE FROM SigPrSnd
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ExecutarExclusao()
        LOCAL loc_lSucesso, loc_cSQL
        loc_lSucesso = .F.
        TRY
            loc_cSQL = "DELETE FROM SigPrSnd " + ;
                "WHERE cidchaves = " + EscaparSQL(THIS.this_cCidChaves)
            IF SQLEXEC(gnConnHandle, loc_cSQL) > 0
                THIS.RegistrarAuditoria("E")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao excluir senha de SigPrSnd.", "Erro")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * BuscarSemVinculo - Carrega senhas livres com EmpDopNums em branco
    *--------------------------------------------------------------------------
    PROCEDURE BuscarSemVinculo()
        LOCAL loc_lSucesso, loc_cSQL
        loc_lSucesso = .F.
        TRY
            loc_cSQL = "SELECT * FROM SigPrSnd WHERE EmpDopNums = ''"
            IF USED("crSigPrSnd")
                USE IN crSigPrSnd
            ENDIF
            IF SQLEXEC(gnConnHandle, loc_cSQL, "crSigPrSnd") > 0
                SELECT crSigPrSnd
                GO TOP
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * GerarSenhas - Gera N senhas livres e insere em SigPrSnd
    *--------------------------------------------------------------------------
    PROCEDURE GerarSenhas(par_nQtd)
        LOCAL loc_lSucesso, loc_n, loc_nSenha, loc_cSenha, loc_cId
        LOCAL loc_cSQL, loc_cChaves, loc_lTransacao, loc_lErroSQL
        loc_lSucesso   = .F.
        loc_cChaves    = ""
        loc_lTransacao = .F.
        loc_lErroSQL   = .F.
        TRY
            IF VARTYPE(par_nQtd) != "N" OR par_nQtd <= 0
                MsgAviso("Quantidade de senhas inv" + CHR(225) + "lida.", "Aviso")
            ELSE
                IF MsgConfirma("Deseja realmente gerar " + ;
                    ALLTRIM(STR(par_nQtd)) + " senhas livres?", "Gerar Senha")
                    SQLEXEC(gnConnHandle, "BEGIN TRANSACTION")
                    loc_lTransacao = .T.
                    FOR loc_n = 1 TO par_nQtd
                        IF !loc_lErroSQL
                            *-- Gera senha unica nao existente em SigPrSnd
                            loc_nSenha = 0
                            DO WHILE loc_nSenha = 0
                                loc_nSenha = THIS.GerarSenhaAleatoria()
                                loc_cSenha = STR(loc_nSenha, 6)
                                IF THIS.SenhaExisteSQL(loc_cSenha)
                                    loc_nSenha = 0
                                ENDIF
                            ENDDO
                            loc_cId  = THIS.GerarIdUnico()
                            loc_cSQL = "INSERT INTO SigPrSnd " + ;
                                "(cidchaves, usuars, datas, tipos, senhads, horas, " + ;
                                " emps, docs, motivos, operas, solicits, valors, fpags, empdopnums, perlimite) " + ;
                                "VALUES (" + ;
                                EscaparSQL(loc_cId) + ", " + ;
                                EscaparSQL(LEFT(ALLTRIM(gc_4c_UsuarioLogado), 10)) + ", " + ;
                                "GETDATE(), " + ;
                                "0, " + ;
                                EscaparSQL(loc_cSenha) + ", " + ;
                                EscaparSQL(LEFT(TIME(), 8)) + ", " + ;
                                EscaparSQL(LEFT(ALLTRIM(go_4c_Sistema.cCodEmpresa), 3)) + ", " + ;
                                "0, '', '', '', 0, '', '', 0" + ;
                                ")"
                            IF SQLEXEC(gnConnHandle, loc_cSQL) <= 0
                                MsgErro("Erro ao gravar senha " + ALLTRIM(loc_cSenha) + ".", "Erro")
                                loc_lErroSQL = .T.
                            ELSE
                                IF EMPTY(loc_cChaves)
                                    loc_cChaves = "'" + loc_cId + "'"
                                ELSE
                                    loc_cChaves = loc_cChaves + ",'" + loc_cId + "'"
                                ENDIF
                            ENDIF
                        ENDIF
                    ENDFOR
                    IF loc_lErroSQL
                        SQLEXEC(gnConnHandle, "ROLLBACK")
                        loc_lTransacao = .F.
                    ELSE
                        SQLEXEC(gnConnHandle, "COMMIT")
                        loc_lTransacao = .F.
                        *-- Recarrega cursor com as senhas recem geradas
                        IF USED("crSigPrSnd")
                            USE IN crSigPrSnd
                        ENDIF
                        loc_cSQL = "SELECT * FROM SigPrSnd WHERE cidchaves IN (" + loc_cChaves + ")"
                        IF SQLEXEC(gnConnHandle, loc_cSQL, "crSigPrSnd") > 0
                            SELECT crSigPrSnd
                            GO TOP
                        ENDIF
                        MsgInfo("Favor anotar as senhas geradas.", "Senhas Livres")
                        loc_lSucesso = .T.
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            IF loc_lTransacao
                SQLEXEC(gnConnHandle, "ROLLBACK")
            ENDIF
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * SenhaExisteSQL - Verifica se senha ja existe em SigPrSnd
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION SenhaExisteSQL(par_cSenha)
        LOCAL loc_lExiste, loc_cSQL, loc_nCount
        loc_lExiste = .F.
        TRY
            loc_cSQL = "SELECT COUNT(*) AS nExiste FROM SigPrSnd WHERE SenhaDs = " + ;
                EscaparSQL(par_cSenha)
            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_SenhaCheck") > 0
                IF USED("cursor_4c_SenhaCheck")
                    loc_nCount  = cursor_4c_SenhaCheck.nExiste
                    loc_lExiste = NVL(loc_nCount, 0) > 0
                    USE IN cursor_4c_SenhaCheck
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lExiste
    ENDFUNC

    *--------------------------------------------------------------------------
    * GerarSenhaAleatoria - Gera numero aleatorio de 6 digitos (100000-999999)
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION GerarSenhaAleatoria()
        RETURN INT(RAND() * 900000) + 100000
    ENDFUNC

    *--------------------------------------------------------------------------
    * GerarIdUnico - Gera identificador unico de 20 caracteres para cidchaves
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION GerarIdUnico()
        LOCAL loc_cId
        loc_cId = SYS(2015) + SYS(2015)
        RETURN LEFT(loc_cId, 20)
    ENDFUNC

ENDDEFINE

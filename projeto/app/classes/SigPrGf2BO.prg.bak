*==============================================================================
* SigPrGf2BO.prg - Business Object para Grafico de Falha X Recuperacao Mensal
* Herda de: BusinessBase
* Form OPERACIONAL - exibe grafico a partir de cursor crRel1 pre-populado
*==============================================================================
DEFINE CLASS SigPrGf2BO AS BusinessBase

    *-- Chave selecionada no combo (Grupo/Vendedor)
    this_cChave1    = ""
    *-- Titulo do grafico (linha 1 + CRLF + linha 2)
    this_cTitulo    = ""
    *-- Empresa associada ao grafico
    this_cEmpresa   = ""
    *-- Numero de grupos no grafico (Falha + Recuperacao = 2 por padrao)
    this_nNumGrupos = 0
    *-- Numero de meses no grafico
    this_nNumMeses  = 0
    *-- String com labels dos meses (TAB-separado)
    this_cStrMeses  = ""
    *-- String com valores de Falha (TAB-separado)
    this_cStrFalhas = ""
    *-- String com valores de Recuperacao (TAB-separado)
    this_cStrRecup  = ""

    *--------------------------------------------------------------------------
    * Init - Configura tabela e chave (sem tabela propria neste form OPERACIONAL)
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        THIS.this_cTabela     = ""
        THIS.this_cCampoChave = ""
        DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - retorna chave (cChave1) do grafico corrente
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION ObterChavePrimaria()
        RETURN ALLTRIM(THIS.this_cChave1)
    ENDFUNC

    *--------------------------------------------------------------------------
    * LimparDados - reseta propriedades do grafico corrente
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE LimparDados()
        THIS.this_cChave1    = ""
        THIS.this_cTitulo    = ""
        THIS.this_cEmpresa   = ""
        THIS.this_nNumGrupos = 0
        THIS.this_nNumMeses  = 0
        THIS.this_cStrMeses  = ""
        THIS.this_cStrFalhas = "Falha"
        THIS.this_cStrRecup  = "Recupera" + CHR(231) + CHR(227) + "o"
        THIS.this_cMensagemErro = ""
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - le linha atual do cursor de origem (crRel1) e
    *                    popula todas as propriedades utilizadas pelo grafico
    * par_cAliasCursor : alias do cursor VFP com as colunas cEmps, cTitulo1s,
    *                    cTitulo2s, cEmpresas, cStranomes, nFalhas, nPesoccbs
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso, loc_oErro, loc_nNmeses, loc_cChave
        LOCAL loc_cStrMeses, loc_cStrFalhas, loc_cStrRecup

        loc_lSucesso   = .F.
        loc_nNmeses    = 0
        loc_cStrMeses  = ""
        loc_cStrFalhas = "Falha"
        loc_cStrRecup  = "Recupera" + CHR(231) + CHR(227) + "o"

        TRY
            IF VARTYPE(par_cAliasCursor) != "C" OR EMPTY(par_cAliasCursor)
                THIS.this_cMensagemErro = "Alias do cursor n" + CHR(227) + "o informado"
                loc_lSucesso = .F.
            ENDIF

            IF !USED(par_cAliasCursor)
                THIS.this_cMensagemErro = "Cursor '" + par_cAliasCursor + "' n" + CHR(227) + "o est" + CHR(225) + " aberto"
                loc_lSucesso = .F.
            ENDIF

            SELECT (par_cAliasCursor)

            IF EOF() OR BOF()
                THIS.this_cMensagemErro = "Cursor '" + par_cAliasCursor + "' sem registro corrente"
                loc_lSucesso = .F.
            ENDIF

            loc_cChave = EVALUATE(par_cAliasCursor + ".cEmps")

            THIS.this_cChave1  = ALLTRIM(loc_cChave)
            THIS.this_cTitulo  = ALLTRIM(EVALUATE(par_cAliasCursor + ".cTitulo1s")) + CHR(13) + ;
                                 ALLTRIM(EVALUATE(par_cAliasCursor + ".cTitulo2s"))
            THIS.this_cEmpresa = ALLTRIM(EVALUATE(par_cAliasCursor + ".cEmpresas"))

            SCAN WHILE EVALUATE(par_cAliasCursor + ".cEmps") == loc_cChave
                loc_nNmeses    = loc_nNmeses + 1
                loc_cStrMeses  = loc_cStrMeses  + CHR(9) + ALLTRIM(EVALUATE(par_cAliasCursor + ".cStranomes"))
                loc_cStrFalhas = loc_cStrFalhas + CHR(9) + ALLTRIM(TRANSFORM(EVALUATE(par_cAliasCursor + ".nFalhas"),   "999,999,999.99"))
                loc_cStrRecup  = loc_cStrRecup  + CHR(9) + ALLTRIM(TRANSFORM(EVALUATE(par_cAliasCursor + ".nPesoccbs"), "999,999,999.99"))
            ENDSCAN

            THIS.this_nNumGrupos = 2
            THIS.this_nNumMeses  = loc_nNmeses
            THIS.this_cStrMeses  = loc_cStrMeses
            THIS.this_cStrFalhas = loc_cStrFalhas
            THIS.this_cStrRecup  = loc_cStrRecup

            loc_lSucesso = (loc_nNmeses > 0)

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir - grava linha corrente do grafico no cursor local crGrafico1
    *           (equivalente a "Insert Into crGrafico1..." do legado, linha 510)
    * NAO grava em banco: form OPERACIONAL de visualizacao read-only
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Inserir()
        LOCAL loc_lSucesso, loc_oErro, loc_cChavePad

        loc_lSucesso = .F.

        TRY
            IF EMPTY(THIS.this_cChave1)
                THIS.this_cMensagemErro = "Chave do gr" + CHR(225) + "fico n" + CHR(227) + "o informada"
                loc_lSucesso = .F.
            ENDIF

            IF !USED("crGrafico1")
                CREATE CURSOR crGrafico1 ( ;
                    gGrafico1s g(4), ;
                    cChave1s   c(100), ;
                    cempresas  c(254), ;
                    ctitulo1s  c(128))
            ENDIF

            loc_cChavePad = PADR(THIS.this_cChave1, 100)

            SELECT crGrafico1
            LOCATE FOR cChave1s == loc_cChavePad
            IF FOUND()
                THIS.this_cMensagemErro = "Gr" + CHR(225) + "fico j" + CHR(225) + " existente para a chave '" + ALLTRIM(THIS.this_cChave1) + "'"
                loc_lSucesso = .F.
            ENDIF

            INSERT INTO crGrafico1 (cChave1s, ctitulo1s, cempresas) ;
                VALUES (loc_cChavePad, ;
                        PADR(THIS.this_cTitulo, 128), ;
                        PADR(THIS.this_cEmpresa, 254))

            THIS.RegistrarAuditoria("INSERT")
            loc_lSucesso = .T.

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = "Erro ao inserir gr" + CHR(225) + "fico: " + loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - atualiza titulo/empresa da linha corrente em crGrafico1
    *             (usado quando dados do grafico sao regerados para mesma chave)
    * NAO grava em banco: form OPERACIONAL de visualizacao read-only
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Atualizar()
        LOCAL loc_lSucesso, loc_oErro, loc_cChavePad

        loc_lSucesso = .F.

        TRY
            IF EMPTY(THIS.this_cChave1)
                THIS.this_cMensagemErro = "Chave do gr" + CHR(225) + "fico n" + CHR(227) + "o informada"
                loc_lSucesso = .F.
            ENDIF

            IF !USED("crGrafico1")
                THIS.this_cMensagemErro = "Cursor crGrafico1 n" + CHR(227) + "o est" + CHR(225) + " aberto"
                loc_lSucesso = .F.
            ENDIF

            loc_cChavePad = PADR(THIS.this_cChave1, 100)

            SELECT crGrafico1
            LOCATE FOR cChave1s == loc_cChavePad
            IF !FOUND()
                THIS.this_cMensagemErro = "Gr" + CHR(225) + "fico n" + CHR(227) + "o encontrado para a chave '" + ALLTRIM(THIS.this_cChave1) + "'"
                loc_lSucesso = .F.
            ENDIF

            REPLACE ctitulo1s WITH PADR(THIS.this_cTitulo,  128), ;
                    cempresas WITH PADR(THIS.this_cEmpresa, 254) ;
                    IN crGrafico1

            THIS.RegistrarAuditoria("UPDATE")
            loc_lSucesso = .T.

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = "Erro ao atualizar gr" + CHR(225) + "fico: " + loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * RegistrarAuditoria - registra geracao/atualizacao do grafico em LogAuditoria
    *                      Como o form nao tem tabela propria, usa "SigPrGf2" como
    *                      identificador da tela e cChave1 como chave do registro
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE RegistrarAuditoria(par_cOperacao)
        LOCAL loc_cSQL, loc_cChave, loc_cUsuario, loc_oErro

        TRY
            loc_cChave = ALLTRIM(THIS.this_cChave1)

            IF EMPTY(loc_cChave)
                loc_lResultado = .F.
            ENDIF

            IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
                loc_lResultado = .F.
            ENDIF

            loc_cUsuario = IIF(TYPE("gc_4c_UsuarioLogado") = "C", gc_4c_UsuarioLogado, "SISTEMA")

            loc_cSQL = "INSERT INTO LogAuditoria (Tabela, Operacao, ChaveRegistro, Usuario, DataHora) " + ;
                       "VALUES (" + EscaparSQL("SigPrGf2") + ", " + ;
                                    EscaparSQL(par_cOperacao) + ", " + ;
                                    EscaparSQL(loc_cChave) + ", " + ;
                                    EscaparSQL(loc_cUsuario) + ", GETDATE())"

            SQLEXEC(gnConnHandle, loc_cSQL)

        CATCH TO loc_oErro
            * Falha em auditoria nao interrompe fluxo do grafico
        ENDTRY

        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarChaves - popula cursor_4c_Chaves com valores distintos de cEmps
    *                  a partir do cursor crRel1 pre-populado pelo form chamador
    * par_cCursorRel: alias do cursor de origem (normalmente "crRel1")
    *--------------------------------------------------------------------------
    FUNCTION CarregarChaves(par_cCursorRel)
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        TRY
            IF !USED(par_cCursorRel)
                MsgErro("Cursor de origem '" + par_cCursorRel + "' n" + CHR(227) + "o est" + CHR(225) + " aberto.", "Erro")
                loc_lSucesso = .F.
            ENDIF

            IF USED("cursor_4c_Chaves")
                USE IN cursor_4c_Chaves
            ENDIF

            SELECT DISTINCT cEmps FROM (par_cCursorRel) ORDER BY 1 INTO CURSOR cursor_4c_Chaves READWRITE
            INDEX ON cEmps TAG cEmps
            GO TOP IN cursor_4c_Chaves

            loc_lSucesso = .T.

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * ObterDadosPorChave - le cursor crRel1 para a chave informada e preenche
    *                      propriedades do BO com strings TAB-delimitadas
    *                      prontas para alimentar o grafico MSGraph
    * par_cChave      : valor de cEmps a filtrar
    * par_cCursorRel  : alias do cursor de origem (normalmente "crRel1")
    * Retorna .T. se encontrou dados, .F. caso contrario
    *--------------------------------------------------------------------------
    FUNCTION ObterDadosPorChave(par_cChave, par_cCursorRel)
        LOCAL loc_lSucesso, loc_oErro, loc_nNmeses
        LOCAL loc_cStrMeses, loc_cStrFalhas, loc_cStrRecup
        loc_lSucesso   = .F.
        loc_nNmeses    = 0
        loc_cStrMeses  = ""
        loc_cStrFalhas = "Falha"
        loc_cStrRecup  = "Recupera" + CHR(231) + CHR(227) + "o"

        TRY
            IF !USED(par_cCursorRel)
                loc_lSucesso = .F.
            ENDIF

            SELECT (par_cCursorRel)
            SET ORDER TO "" IN (par_cCursorRel)
            LOCATE FOR cEmps == par_cChave

            IF FOUND()
                THIS.this_cTitulo  = ALLTRIM(cTitulo1s) + CHR(13) + ALLTRIM(cTitulo2s)
                THIS.this_cEmpresa = ALLTRIM(cEmpresas)

                SCAN WHILE cEmps == par_cChave
                    loc_nNmeses    = loc_nNmeses + 1
                    loc_cStrMeses  = loc_cStrMeses + CHR(9) + ALLTRIM(cStranomes)
                    loc_cStrFalhas = loc_cStrFalhas + CHR(9) + ALLTRIM(TRANSFORM(nFalhas, "999,999,999.99"))
                    loc_cStrRecup  = loc_cStrRecup  + CHR(9) + ALLTRIM(TRANSFORM(nPesoccbs, "999,999,999.99"))
                ENDSCAN

                THIS.this_cChave1    = par_cChave
                THIS.this_nNumGrupos = 2
                THIS.this_nNumMeses  = loc_nNmeses
                THIS.this_cStrMeses  = loc_cStrMeses
                THIS.this_cStrFalhas = loc_cStrFalhas
                THIS.this_cStrRecup  = loc_cStrRecup

                loc_lSucesso = .T.
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

ENDDEFINE

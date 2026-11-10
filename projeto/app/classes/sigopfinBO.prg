*====================================================================
* sigopfinBO.prg
*
* Business Object para Configuracao de Lancamentos Financeiros
* Tabela: sigopfin
* Herda de: BusinessBase
*
* Cada registro de sigopfin eh uma LINHA de configuracao (origem dos
* valores a serem lancados) associada a uma movimentacao (dopes, FK
* para SigOpOpe.Dopes). A tela (Formsigopfin) exibe/edita varias
* linhas simultaneamente num grid; este BO trata uma linha por vez.
*====================================================================

DEFINE CLASS sigopfinBO AS BusinessBase

    *-- Propriedades da entidade (mapeamento para tabela sigopfin)
    this_cCidChaves = ""    && cidchaves char(20) - PK (Fortyus)
    this_cCodigos   = ""    && codigos   char(10) - FK para origem (crTabOpFin.Codigos)
    this_cComandos  = ""    && comandos  text     - memo de comandos de programacao
    this_cContaAcs  = ""    && contaacs  char(11)
    this_cContaAds  = ""    && contaads  char(11)
    this_cContaCcs  = ""    && contaccs  char(11)
    this_cContaCds  = ""    && contacds  char(11)
    this_cContaEcs  = ""    && contaecs  char(11)
    this_cContaEds  = ""    && contaeds  char(11)
    this_cContaPcs  = ""    && contapcs  char(11)
    this_cContaPds  = ""    && contapds  char(11)
    this_dDatAlts   = {}    && datalts   datetime
    this_dDatIncs   = {}    && datincs   datetime
    this_cDopes     = ""    && dopes     char(20) - FK para SigOpOpe.Dopes (movimentacao)
    this_cGrupoAcs  = ""    && grupoacs  char(11)
    this_cGrupoAds  = ""    && grupoads  char(11)
    this_cGrupoCcs  = ""    && grupoccs  char(11)
    this_cGrupoCds  = ""    && grupocds  char(11)
    this_cGrupoEcs  = ""    && grupoecs  char(11)
    this_cGrupoEds  = ""    && grupoeds  char(11)
    this_cGrupoPcs  = ""    && grupopcs  char(11)
    this_cGrupoPds  = ""    && grupopds  char(11)
    this_cMoedas    = ""    && moedas    char(3)
    this_cMovTits   = ""    && movtits   char(20)
    this_cNotas     = ""    && notas     text     - memo de notas sobre a configuracao
    this_nOrdem     = 0     && ordem     numeric(3,0)
    this_cTipos     = ""    && tipos     char(1)
    this_cTitBans   = ""    && titbans   char(12)
    this_cUsuAlts   = ""    && usualts   char(10)
    this_cUsuIncs   = ""    && usuincs   char(10)
    this_nChkEmpds  = 0     && chkempds  numeric(1,0)

    *-- Propriedade NAO persistida: descricao exibida no grid (origem do
    *-- lookup contra crTabOpFin.Descrs, casada por this_cCodigos). Nao
    *-- existe coluna "descrs" em sigopfin - eh so exibicao.
    this_cDescricao = ""

    *====================================================================
    * Init - Inicializa Business Object
    *====================================================================
    PROCEDURE Init()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            DODEFAULT()
            THIS.this_cTabela     = "sigopfin"
            THIS.this_cCampoChave = "cidchaves"
            loc_lSucesso = .T.
        CATCH TO loException
            MostrarErro(loException, "sigopfinBO.Init")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * ObterChavePrimaria - Retorna a chave primaria do registro atual
    * (usada por RegistrarAuditoria)
    *====================================================================
    PROTECTED PROCEDURE ObterChavePrimaria()
        RETURN ALLTRIM(THIS.this_cCidChaves)
    ENDPROC

    *====================================================================
    * CarregarDoCursor - Mapeia os campos do cursor para as propriedades
    * da linha de configuracao (sigopfin). par_cAliasCursor eh o alias do
    * cursor posicionado no registro a carregar (ex.: resultado de um
    * SQLEXEC pela chave cidchaves, ou a linha corrente de crGrdValores).
    *====================================================================
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        IF USED(par_cAliasCursor)
            SELECT (par_cAliasCursor)
            THIS.this_cCidChaves = TratarNulo(cidchaves, "")
            THIS.this_cCodigos   = TratarNulo(codigos,   "")
            THIS.this_cComandos  = TratarNulo(comandos,  "")
            THIS.this_cContaAcs  = TratarNulo(contaacs,  "")
            THIS.this_cContaAds  = TratarNulo(contaads,  "")
            THIS.this_cContaCcs  = TratarNulo(contaccs,  "")
            THIS.this_cContaCds  = TratarNulo(contacds,  "")
            THIS.this_cContaEcs  = TratarNulo(contaecs,  "")
            THIS.this_cContaEds  = TratarNulo(contaeds,  "")
            THIS.this_cContaPcs  = TratarNulo(contapcs,  "")
            THIS.this_cContaPds  = TratarNulo(contapds,  "")
            THIS.this_dDatAlts   = TratarNulo(datalts,   {})
            THIS.this_dDatIncs   = TratarNulo(datincs,   {})
            THIS.this_cDopes     = TratarNulo(dopes,     "")
            THIS.this_cGrupoAcs  = TratarNulo(grupoacs,  "")
            THIS.this_cGrupoAds  = TratarNulo(grupoads,  "")
            THIS.this_cGrupoCcs  = TratarNulo(grupoccs,  "")
            THIS.this_cGrupoCds  = TratarNulo(grupocds,  "")
            THIS.this_cGrupoEcs  = TratarNulo(grupoecs,  "")
            THIS.this_cGrupoEds  = TratarNulo(grupoeds,  "")
            THIS.this_cGrupoPcs  = TratarNulo(grupopcs,  "")
            THIS.this_cGrupoPds  = TratarNulo(grupopds,  "")
            THIS.this_cMoedas    = TratarNulo(moedas,    "")
            THIS.this_cMovTits   = TratarNulo(movtits,   "")
            THIS.this_cNotas     = TratarNulo(notas,     "")
            THIS.this_nOrdem     = TratarNulo(ordem,     0)
            THIS.this_cTipos     = TratarNulo(tipos,     "")
            THIS.this_cTitBans   = TratarNulo(titbans,   "")
            THIS.this_cUsuAlts   = TratarNulo(usualts,   "")
            THIS.this_cUsuIncs   = TratarNulo(usuincs,   "")
            THIS.this_nChkEmpds  = TratarNulo(chkempds,  0)

            *-- descrs nao eh coluna de sigopfin: so chega quando o cursor de
            *-- origem for montado com JOIN contra crTabOpFin/SigOpOpe (lookup
            *-- da descricao exibida na grade). Mapear so quando presente.
            IF TYPE(par_cAliasCursor + ".descrs") != "U"
                THIS.this_cDescricao = TratarNulo(descrs, "")
            ELSE
                THIS.this_cDescricao = ""
            ENDIF

            loc_lSucesso = .T.
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * Inserir - INSERT de uma linha de configuracao na tabela sigopfin
    *====================================================================
    PROCEDURE Inserir()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            THIS.this_cCidChaves = LEFT(fUniqueIds(), 20)
            THIS.this_cUsuIncs   = gc_4c_UsuarioLogado

            loc_cSQL = "INSERT INTO sigopfin (cidchaves, codigos, comandos, contaacs," + ;
                       " contaads, contaccs, contacds, contaecs, contaeds, contapcs," + ;
                       " contapds, datalts, datincs, dopes, grupoacs, grupoads," + ;
                       " grupoccs, grupocds, grupoecs, grupoeds, grupopcs, grupopds," + ;
                       " moedas, movtits, notas, ordem, tipos, titbans, usualts," + ;
                       " usuincs, chkempds)" + ;
                       " VALUES (" + ;
                       EscaparSQL(THIS.this_cCidChaves) + "," + ;
                       EscaparSQL(THIS.this_cCodigos)   + "," + ;
                       EscaparSQL(THIS.this_cComandos)  + "," + ;
                       EscaparSQL(THIS.this_cContaAcs)  + "," + ;
                       EscaparSQL(THIS.this_cContaAds)  + "," + ;
                       EscaparSQL(THIS.this_cContaCcs)  + "," + ;
                       EscaparSQL(THIS.this_cContaCds)  + "," + ;
                       EscaparSQL(THIS.this_cContaEcs)  + "," + ;
                       EscaparSQL(THIS.this_cContaEds)  + "," + ;
                       EscaparSQL(THIS.this_cContaPcs)  + "," + ;
                       EscaparSQL(THIS.this_cContaPds)  + "," + ;
                       "NULL," + ;
                       "GETDATE()," + ;
                       EscaparSQL(THIS.this_cDopes)     + "," + ;
                       EscaparSQL(THIS.this_cGrupoAcs)  + "," + ;
                       EscaparSQL(THIS.this_cGrupoAds)  + "," + ;
                       EscaparSQL(THIS.this_cGrupoCcs)  + "," + ;
                       EscaparSQL(THIS.this_cGrupoCds)  + "," + ;
                       EscaparSQL(THIS.this_cGrupoEcs)  + "," + ;
                       EscaparSQL(THIS.this_cGrupoEds)  + "," + ;
                       EscaparSQL(THIS.this_cGrupoPcs)  + "," + ;
                       EscaparSQL(THIS.this_cGrupoPds)  + "," + ;
                       EscaparSQL(THIS.this_cMoedas)    + "," + ;
                       EscaparSQL(THIS.this_cMovTits)   + "," + ;
                       EscaparSQL(THIS.this_cNotas)     + "," + ;
                       FormatarNumeroSQL(THIS.this_nOrdem, 0) + "," + ;
                       EscaparSQL(THIS.this_cTipos)     + "," + ;
                       EscaparSQL(THIS.this_cTitBans)   + "," + ;
                       EscaparSQL(THIS.this_cUsuAlts)   + "," + ;
                       EscaparSQL(THIS.this_cUsuIncs)   + "," + ;
                       FormatarNumeroSQL(THIS.this_nChkEmpds, 0) + ;
                       ")"

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("INSERT")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao inserir configura" + CHR(231) + CHR(227) + "o financeira:" + ;
                    CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao inserir configura" + CHR(231) + CHR(227) + "o financeira:" + ;
                CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * Atualizar - UPDATE de uma linha de configuracao na tabela sigopfin
    *====================================================================
    PROCEDURE Atualizar()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            THIS.this_cUsuAlts = gc_4c_UsuarioLogado

            loc_cSQL = "UPDATE sigopfin SET" + ;
                       " codigos   = " + EscaparSQL(THIS.this_cCodigos)   + "," + ;
                       " comandos  = " + EscaparSQL(THIS.this_cComandos)  + "," + ;
                       " contaacs  = " + EscaparSQL(THIS.this_cContaAcs)  + "," + ;
                       " contaads  = " + EscaparSQL(THIS.this_cContaAds)  + "," + ;
                       " contaccs  = " + EscaparSQL(THIS.this_cContaCcs)  + "," + ;
                       " contacds  = " + EscaparSQL(THIS.this_cContaCds)  + "," + ;
                       " contaecs  = " + EscaparSQL(THIS.this_cContaEcs)  + "," + ;
                       " contaeds  = " + EscaparSQL(THIS.this_cContaEds)  + "," + ;
                       " contapcs  = " + EscaparSQL(THIS.this_cContaPcs)  + "," + ;
                       " contapds  = " + EscaparSQL(THIS.this_cContaPds)  + "," + ;
                       " datalts   = GETDATE()," + ;
                       " dopes     = " + EscaparSQL(THIS.this_cDopes)     + "," + ;
                       " grupoacs  = " + EscaparSQL(THIS.this_cGrupoAcs)  + "," + ;
                       " grupoads  = " + EscaparSQL(THIS.this_cGrupoAds)  + "," + ;
                       " grupoccs  = " + EscaparSQL(THIS.this_cGrupoCcs)  + "," + ;
                       " grupocds  = " + EscaparSQL(THIS.this_cGrupoCds)  + "," + ;
                       " grupoecs  = " + EscaparSQL(THIS.this_cGrupoEcs)  + "," + ;
                       " grupoeds  = " + EscaparSQL(THIS.this_cGrupoEds)  + "," + ;
                       " grupopcs  = " + EscaparSQL(THIS.this_cGrupoPcs)  + "," + ;
                       " grupopds  = " + EscaparSQL(THIS.this_cGrupoPds)  + "," + ;
                       " moedas    = " + EscaparSQL(THIS.this_cMoedas)    + "," + ;
                       " movtits   = " + EscaparSQL(THIS.this_cMovTits)   + "," + ;
                       " notas     = " + EscaparSQL(THIS.this_cNotas)     + "," + ;
                       " ordem     = " + FormatarNumeroSQL(THIS.this_nOrdem, 0) + "," + ;
                       " tipos     = " + EscaparSQL(THIS.this_cTipos)     + "," + ;
                       " titbans   = " + EscaparSQL(THIS.this_cTitBans)   + "," + ;
                       " usualts   = " + EscaparSQL(THIS.this_cUsuAlts)   + "," + ;
                       " chkempds  = " + FormatarNumeroSQL(THIS.this_nChkEmpds, 0) + ;
                       " WHERE cidchaves = " + EscaparSQL(THIS.this_cCidChaves)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("UPDATE")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao atualizar configura" + CHR(231) + CHR(227) + "o financeira:" + ;
                    CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao atualizar configura" + CHR(231) + CHR(227) + "o financeira:" + ;
                CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

ENDDEFINE

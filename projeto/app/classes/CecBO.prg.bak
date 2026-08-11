*==============================================================================
* CecBO.prg - Business Object para Cadastro de Acesso a Consulta Generica
* Tabela: SigFiChc
* Chave funcional: Emps + Tipos (composta)
*==============================================================================

DEFINE CLASS CecBO AS BusinessBase

    *-- Campos de identificacao / chave composta funcional
    this_cEmps        = ""   && char(3)  Empresa (FK SigCdEmp.cEmps)
    this_cTipos       = ""   && char(20) Tipo de Consulta (CHEQUE PRE / SERASA / ACSP)

    *-- Campos de acesso CHEQUE PRE
    this_cCtr         = ""   && char(100) Contrato
    this_cRde         = ""   && char(100) Codigo da Rede
    this_cRdeLja      = ""   && char(100) Codigo da Loja

    *-- Campos de acesso nao-CHEQUE PRE
    this_cLogon       = ""   && char(8)  Logon
    this_cNSenha      = ""   && char(8)  nSenha (campo interno, armazenado no banco)
    this_cSenha       = ""   && char(8)  Senha de acesso

    *-- Valores de referencia
    this_nVlrMin      = 0    && numeric(11,2) Valor Minimo
    this_nVlrFixo     = 0    && numeric(11,2) Valor Fixo

    *-- Configuracao de conexao
    this_cCipchps     = ""   && char(32) URL / IP Proxy
    this_nPortachps   = 0    && int      Porta
    this_cVersao      = ""   && char(10) Versao

    *-- Consulta Serasa
    this_cCTipos      = ""   && char(2)  Tipo Consulta Serasa (CP / CH)

    *-- Proxy
    this_cUsuProxys   = ""   && char(64) Usuario Proxy
    this_cSenProxys   = ""   && char(20) Senha Proxy

    *-- Campo de exibicao (JOIN com SigCdEmp)
    this_cRazas       = ""   && char(40) Razao Social (SigCdEmp.Razas, somente leitura)

    *--------------------------------------------------------------------------
    PROCEDURE Init()
        DODEFAULT()
        THIS.this_cTabela     = "SigFiChc"
        THIS.this_cCampoChave = "Emps"
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    FUNCTION ObterChavePrimaria()
        RETURN THIS.this_cEmps + "-" + THIS.this_cTipos
    ENDFUNC

    *--------------------------------------------------------------------------
    * Buscar - Lista registros com JOIN para exibir Razao Social
    *--------------------------------------------------------------------------
    PROCEDURE Buscar(par_cFiltro)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "SELECT a.Emps, a.Tipos, a.Ctr, a.Rde, a.RdeLja," + ;
                       " a.Logon, a.Senha, a.VlrMin, a.VlrFixo, a.cipchps, a.nPortachps," + ;
                       " a.cTipos, a.cUsuProxys, a.cSenProxys, b.Razas" + ;
                       " FROM SigFiChc a" + ;
                       " INNER JOIN SigCdEmp b ON a.Cemps = b.Cemps"

            IF !EMPTY(ALLTRIM(par_cFiltro))
                loc_cSQL = loc_cSQL + " WHERE a.Emps = " + EscaparSQL(par_cFiltro)
            ENDIF

            loc_cSQL = loc_cSQL + " ORDER BY a.Emps, a.Tipos"

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")
            IF loc_nResultado >= 0
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao buscar acessos:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao buscar acessos:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarPorCodigo - Carrega um registro pela chave composta Emps+Tipos
    *--------------------------------------------------------------------------
    PROCEDURE CarregarPorCodigo(par_cEmps, par_cTipos)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "SELECT a.Emps, a.Tipos, a.Ctr, a.Rde, a.RdeLja," + ;
                       " a.Logon, a.Senha, a.VlrMin, a.VlrFixo, a.cipchps, a.nPortachps," + ;
                       " a.cTipos, a.cUsuProxys, a.cSenProxys, b.Razas" + ;
                       " FROM SigFiChc a" + ;
                       " INNER JOIN SigCdEmp b ON a.Cemps = b.Cemps" + ;
                       " WHERE a.Emps = " + EscaparSQL(par_cEmps) + ;
                       " AND a.Tipos = " + EscaparSQL(par_cTipos)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")
            IF loc_nResultado >= 0 AND RECCOUNT("cursor_4c_Carrega") > 0
                loc_lSucesso = THIS.CarregarDoCursor("cursor_4c_Carrega")
                THIS.this_lNovoRegistro = .F.
            ENDIF

            IF USED("cursor_4c_Carrega")
                USE IN cursor_4c_Carrega
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao carregar acesso:" + CHR(13) + loc_oErro.Message, "Erro")
            IF USED("cursor_4c_Carrega")
                USE IN cursor_4c_Carrega
            ENDIF
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * VerificarDuplicidade - Verifica se ja existe registro com Emps+Tipos
    *--------------------------------------------------------------------------
    PROCEDURE VerificarDuplicidade()
        LOCAL loc_cSQL, loc_nResultado, loc_lExiste
        loc_lExiste = .F.

        TRY
            loc_cSQL = "SELECT Emps FROM SigFiChc" + ;
                       " WHERE Emps = " + EscaparSQL(THIS.this_cEmps) + ;
                       " AND Tipos = " + EscaparSQL(THIS.this_cTipos)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dupl")
            IF loc_nResultado >= 0 AND RECCOUNT("cursor_4c_Dupl") > 0
                loc_lExiste = .T.
            ENDIF

            IF USED("cursor_4c_Dupl")
                USE IN cursor_4c_Dupl
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao verificar duplicidade:" + CHR(13) + loc_oErro.Message, "Erro")
            IF USED("cursor_4c_Dupl")
                USE IN cursor_4c_Dupl
            ENDIF
        ENDTRY

        RETURN loc_lExiste
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Mapeia campos do cursor para propriedades do BO
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        IF USED(par_cAliasCursor)
            SELECT (par_cAliasCursor)
            THIS.this_cEmps       = TratarNulo(Emps,        "C")
            THIS.this_cTipos      = TratarNulo(Tipos,       "C")
            THIS.this_cCtr        = TratarNulo(Ctr,         "C")
            THIS.this_cRde        = TratarNulo(Rde,         "C")
            THIS.this_cRdeLja     = TratarNulo(RdeLja,      "C")
            THIS.this_cLogon      = TratarNulo(Logon,       "C")
            THIS.this_cSenha      = TratarNulo(Senha,       "C")
            THIS.this_nVlrMin     = TratarNulo(VlrMin,      "N")
            THIS.this_nVlrFixo    = TratarNulo(VlrFixo,     "N")
            THIS.this_cCipchps    = TratarNulo(cipchps,     "C")
            THIS.this_nPortachps  = TratarNulo(nPortachps,  "N")
            THIS.this_cCTipos     = TratarNulo(cTipos,      "C")
            THIS.this_cUsuProxys  = TratarNulo(cUsuProxys,  "C")
            THIS.this_cSenProxys  = TratarNulo(cSenProxys,  "C")
            THIS.this_cRazas      = TratarNulo(Razas,       "C")
            loc_lSucesso = .T.
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir - INSERT na tabela SigFiChc
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Inserir()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "INSERT INTO SigFiChc" + ;
                       " (Emps, Tipos, Ctr, Rde, RdeLja," + ;
                       " Logon, Senha, VlrMin, VlrFixo, cipchps, nPortachps," + ;
                       " cTipos, cUsuProxys, cSenProxys)" + ;
                       " VALUES (" + ;
                       EscaparSQL(THIS.this_cEmps) + "," + ;
                       EscaparSQL(THIS.this_cTipos) + "," + ;
                       EscaparSQL(THIS.this_cCtr) + "," + ;
                       EscaparSQL(THIS.this_cRde) + "," + ;
                       EscaparSQL(THIS.this_cRdeLja) + "," + ;
                       EscaparSQL(THIS.this_cLogon) + "," + ;
                       EscaparSQL(THIS.this_cSenha) + "," + ;
                       FormatarNumeroSQL(THIS.this_nVlrMin) + "," + ;
                       FormatarNumeroSQL(THIS.this_nVlrFixo) + "," + ;
                       EscaparSQL(THIS.this_cCipchps) + "," + ;
                       FormatarNumeroSQL(THIS.this_nPortachps) + "," + ;
                       EscaparSQL(THIS.this_cCTipos) + "," + ;
                       EscaparSQL(THIS.this_cUsuProxys) + "," + ;
                       EscaparSQL(THIS.this_cSenProxys) + ;
                       ")"

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("INSERT")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao inserir acesso:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao inserir acesso:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - UPDATE na tabela SigFiChc (Emps e Tipos sao chave, nao alterar)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Atualizar()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "UPDATE SigFiChc SET" + ;
                       " Ctr = " + EscaparSQL(THIS.this_cCtr) + "," + ;
                       " Rde = " + EscaparSQL(THIS.this_cRde) + "," + ;
                       " RdeLja = " + EscaparSQL(THIS.this_cRdeLja) + "," + ;
                       " Logon = " + EscaparSQL(THIS.this_cLogon) + "," + ;
                       " Senha = " + EscaparSQL(THIS.this_cSenha) + "," + ;
                       " VlrMin = " + FormatarNumeroSQL(THIS.this_nVlrMin) + "," + ;
                       " VlrFixo = " + FormatarNumeroSQL(THIS.this_nVlrFixo) + "," + ;
                       " cipchps = " + EscaparSQL(THIS.this_cCipchps) + "," + ;
                       " nPortachps = " + FormatarNumeroSQL(THIS.this_nPortachps) + "," + ;
                       " cTipos = " + EscaparSQL(THIS.this_cCTipos) + "," + ;
                       " cUsuProxys = " + EscaparSQL(THIS.this_cUsuProxys) + "," + ;
                       " cSenProxys = " + EscaparSQL(THIS.this_cSenProxys) + ;
                       " WHERE Emps = " + EscaparSQL(THIS.this_cEmps) + ;
                       " AND Tipos = " + EscaparSQL(THIS.this_cTipos)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("UPDATE")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao atualizar acesso:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao atualizar acesso:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ExecutarExclusao - DELETE da tabela SigFiChc
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ExecutarExclusao()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "DELETE FROM SigFiChc WHERE Emps = " + EscaparSQL(THIS.this_cEmps) + ;
                       " AND Tipos = " + EscaparSQL(THIS.this_cTipos)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("DELETE")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao excluir acesso:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao excluir acesso:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

ENDDEFINE

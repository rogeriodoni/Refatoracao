*==============================================================================
* PcpBO.prg - Business Object: Planejamento e Controle da Produ??o
* Tabela principal: SigCdPcz
* Criado: 2026-08-22 | Task496
*==============================================================================

DEFINE CLASS PcpBO AS BusinessBase

    *-- Propriedades da tabela SigCdPcz
    this_nCodigos   = 0       && codigos numeric(10,0) - PK
    this_cContas    = ""      && contas  char(10)
    this_cCvens     = ""      && cvens   char(10)
    this_dDatas     = {}      && datas   datetime
    this_cDopes     = ""      && dopes   char(20)
    this_dDtLancs   = {}      && dtlancs datetime
    this_dEmissaoF  = {}      && emissaof datetime
    this_dEmissaoI  = {}      && emissaoi datetime
    this_cEmps      = ""      && emps    char(3)
    this_nNumefs    = 0       && numefs  numeric(6,0)
    this_nNumeis    = 0       && numeis  numeric(6,0)
    this_dPrevfs    = {}      && prevfs  datetime
    this_dPrevis    = {}      && previs  datetime
    this_cTitulos   = ""      && titulos char(50)

    *--------------------------------------------------------------------------
    PROCEDURE Init()
        DODEFAULT()
        THIS.this_cTabela     = "SigCdPcz"
        THIS.this_cCampoChave = "Codigos"
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Retorna chave primaria para auditoria
    *--------------------------------------------------------------------------
    PROCEDURE ObterChavePrimaria()
        RETURN TRANSFORM(THIS.this_nCodigos)
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Carrega propriedades do BO a partir de um cursor
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lResultado
        loc_lResultado = .F.

        IF USED(par_cAliasCursor)
            SELECT (par_cAliasCursor)
            THIS.this_nCodigos  = TratarNulo(Codigos,  "N")
            THIS.this_cContas   = TratarNulo(Contas,   "C")
            THIS.this_cCvens    = TratarNulo(Cvens,    "C")
            THIS.this_dDatas    = TratarNulo(Datas,    "D")
            THIS.this_cDopes    = TratarNulo(Dopes,    "C")
            THIS.this_dDtLancs  = TratarNulo(Dtlancs,  "D")
            THIS.this_dEmissaoF = TratarNulo(Emissaof, "D")
            THIS.this_dEmissaoI = TratarNulo(Emissaoi, "D")
            THIS.this_cEmps     = TratarNulo(Emps,     "C")
            THIS.this_nNumefs   = TratarNulo(Numefs,   "N")
            THIS.this_nNumeis   = TratarNulo(Numeis,   "N")
            THIS.this_dPrevfs   = TratarNulo(Prevfs,   "D")
            THIS.this_dPrevis   = TratarNulo(Previs,   "D")
            THIS.this_cTitulos  = TratarNulo(Titulos,  "C")
            THIS.this_lNovoRegistro = .F.
            loc_lResultado = .T.
        ENDIF

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * Buscar - Lista registros no cursor_4c_Dados
    *--------------------------------------------------------------------------
    PROCEDURE Buscar(par_cFiltro)
        LOCAL loc_lResultado, loc_cSQL, loc_nResult
        loc_lResultado = .F.

        TRY
            loc_cSQL = "SELECT Codigos, Titulos, Datas, Emps" + ;
                       " FROM SigCdPcz" + ;
                       " ORDER BY Codigos"

            IF !EMPTY(par_cFiltro)
                loc_cSQL = "SELECT Codigos, Titulos, Datas, Emps" + ;
                           " FROM SigCdPcz" + ;
                           " WHERE " + par_cFiltro + ;
                           " ORDER BY Codigos"
            ENDIF

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")

            IF loc_nResult >= 0
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao buscar registros: " + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loException
            MsgErro("Erro em Buscar: " + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarPorCodigo - Carrega registro pelo codigo (PK)
    *--------------------------------------------------------------------------
    PROCEDURE CarregarPorCodigo(par_nCodigo)
        LOCAL loc_lResultado, loc_cSQL, loc_nResult
        loc_lResultado = .F.

        TRY
            loc_cSQL = "SELECT Codigos, Contas, Cvens, Datas, Dopes," + ;
                       " Dtlancs, Emissaof, Emissaoi, Emps," + ;
                       " Numefs, Numeis, Prevfs, Previs, Titulos" + ;
                       " FROM SigCdPcz" + ;
                       " WHERE Codigos = " + FormatarNumeroSQL(par_nCodigo)

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")

            IF loc_nResult >= 0 AND RECCOUNT("cursor_4c_Carrega") > 0
                loc_lResultado = THIS.CarregarDoCursor("cursor_4c_Carrega")
            ENDIF

            IF USED("cursor_4c_Carrega")
                USE IN cursor_4c_Carrega
            ENDIF
        CATCH TO loException
            MsgErro("Erro em CarregarPorCodigo: " + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir - Insere novo registro (PROTECTED - chamado por Salvar)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Inserir()
        LOCAL loc_lResultado, loc_cSQL, loc_nResult
        loc_lResultado = .F.

        TRY
            loc_cSQL = "INSERT INTO SigCdPcz" + ;
                       " (Codigos, Contas, Cvens, Datas, Dopes," + ;
                       "  Dtlancs, Emissaof, Emissaoi, Emps," + ;
                       "  Numefs, Numeis, Prevfs, Previs, Titulos)" + ;
                       " VALUES (" + ;
                       FormatarNumeroSQL(THIS.this_nCodigos) + ", " + ;
                       EscaparSQL(THIS.this_cContas)  + ", " + ;
                       EscaparSQL(THIS.this_cCvens)   + ", " + ;
                       FormatarDataSQL(THIS.this_dDatas) + ", " + ;
                       EscaparSQL(THIS.this_cDopes)   + ", " + ;
                       FormatarDataSQL(THIS.this_dDtLancs) + ", " + ;
                       FormatarDataSQL(THIS.this_dEmissaoF) + ", " + ;
                       FormatarDataSQL(THIS.this_dEmissaoI) + ", " + ;
                       EscaparSQL(THIS.this_cEmps)    + ", " + ;
                       FormatarNumeroSQL(THIS.this_nNumefs) + ", " + ;
                       FormatarNumeroSQL(THIS.this_nNumeis) + ", " + ;
                       FormatarDataSQL(THIS.this_dPrevfs) + ", " + ;
                       FormatarDataSQL(THIS.this_dPrevis) + ", " + ;
                       EscaparSQL(THIS.this_cTitulos) + ")"

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResult >= 0
                THIS.RegistrarAuditoria("INSERT")
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao inserir registro: " + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loException
            MsgErro("Erro em Inserir: " + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - Atualiza registro existente (PROTECTED - chamado por Salvar)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Atualizar()
        LOCAL loc_lResultado, loc_cSQL, loc_nResult
        loc_lResultado = .F.

        TRY
            loc_cSQL = "UPDATE SigCdPcz SET" + ;
                       " Contas    = " + EscaparSQL(THIS.this_cContas)   + ", " + ;
                       " Cvens     = " + EscaparSQL(THIS.this_cCvens)    + ", " + ;
                       " Datas     = " + FormatarDataSQL(THIS.this_dDatas) + ", " + ;
                       " Dopes     = " + EscaparSQL(THIS.this_cDopes)    + ", " + ;
                       " Dtlancs   = " + FormatarDataSQL(THIS.this_dDtLancs) + ", " + ;
                       " Emissaof  = " + FormatarDataSQL(THIS.this_dEmissaoF) + ", " + ;
                       " Emissaoi  = " + FormatarDataSQL(THIS.this_dEmissaoI) + ", " + ;
                       " Emps      = " + EscaparSQL(THIS.this_cEmps)     + ", " + ;
                       " Numefs    = " + FormatarNumeroSQL(THIS.this_nNumefs) + ", " + ;
                       " Numeis    = " + FormatarNumeroSQL(THIS.this_nNumeis) + ", " + ;
                       " Prevfs    = " + FormatarDataSQL(THIS.this_dPrevfs) + ", " + ;
                       " Previs    = " + FormatarDataSQL(THIS.this_dPrevis) + ", " + ;
                       " Titulos   = " + EscaparSQL(THIS.this_cTitulos) + ;
                       " WHERE Codigos = " + FormatarNumeroSQL(THIS.this_nCodigos)

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResult >= 0
                THIS.RegistrarAuditoria("UPDATE")
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao atualizar registro: " + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loException
            MsgErro("Erro em Atualizar: " + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * ExecutarExclusao - Exclui registro das 4 tabelas relacionadas
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ExecutarExclusao()
        LOCAL loc_lResultado, loc_cSQL, loc_nResult, loc_cCodigo
        loc_lResultado = .F.

        TRY
            loc_cCodigo = FormatarNumeroSQL(THIS.this_nCodigos)

            *-- Excluir da tabela principal SigCdPcz (1/4)
            loc_cSQL = "DELETE FROM SigCdPcz WHERE Codigos = " + loc_cCodigo
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nResult < 0
                MsgErro("Erro ao excluir SigCdPcz: " + CapturarErroSQL(), "Erro SQL")
                loc_lResultado = .F.
            ELSE
                *-- Excluir SigCdPco (2/4)
                loc_cSQL = "DELETE FROM SigCdPco WHERE Codigos = " + loc_cCodigo
                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)
                IF loc_nResult < 0
                    MsgErro("Erro ao excluir SigCdPco: " + CapturarErroSQL(), "Erro SQL")
                ELSE
                    *-- Excluir SigCdPcp (3/4)
                    loc_cSQL = "DELETE FROM SigCdPcp WHERE Codigos = " + loc_cCodigo
                    loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)
                    IF loc_nResult < 0
                        MsgErro("Erro ao excluir SigCdPcp: " + CapturarErroSQL(), "Erro SQL")
                    ELSE
                        *-- Excluir SigCdPcg (4/4)
                        loc_cSQL = "DELETE FROM SigCdPcg WHERE Codigos = " + loc_cCodigo
                        loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)
                        IF loc_nResult < 0
                            MsgErro("Erro ao excluir SigCdPcg: " + CapturarErroSQL(), "Erro SQL")
                        ELSE
                            THIS.RegistrarAuditoria("DELETE")
                            loc_lResultado = .T.
                        ENDIF
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loException
            MsgErro("Erro em ExecutarExclusao: " + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * BuscarOperacoes - Carrega cursor TmpOper com operacoes de producao
    *--------------------------------------------------------------------------
    PROCEDURE BuscarOperacoes()
        LOCAL loc_lResultado, loc_cSQL, loc_nResult
        loc_lResultado = .F.

        TRY
            loc_cSQL = "SELECT Dopes, NDopes, Globalizas, Reservas" + ;
                       " FROM SigCdOpe" + ;
                       " WHERE Globalizas IN (1, 2)" + ;
                       " ORDER BY Dopes"

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Operacoes")

            IF loc_nResult >= 0
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao buscar opera" + CHR(231) + CHR(245) + "es: " + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loException
            MsgErro("Erro em BuscarOperacoes: " + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * BuscarParametros - Carrega parametros do sistema (SigCdPam)
    *--------------------------------------------------------------------------
    PROCEDURE BuscarParametros()
        LOCAL loc_lResultado, loc_cSQL, loc_nResult, loc_cCampos
        loc_lResultado = .F.

        TRY
            loc_cCampos = "DopEmphs, DopReqcs, DopPedcs, DopComps, TransfRes, GrPadClis, DoppPads," + ;
                          " DopTrfCps, GrPadVens, PrevProds, GrupoEsts, ContaEsts, GruReservs," + ;
                          " ConReservs, AgrupEmph, grTrans, DoppServs, mascnums, GruEstps, ConEstps," + ;
                          " transfencs, Ouros, GruConfs, ConConfs, GlobAutos"

            loc_cSQL = "SELECT " + loc_cCampos + " FROM SigCdPam"

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Parametros")

            IF loc_nResult >= 0
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao buscar par" + CHR(226) + "metros: " + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loException
            MsgErro("Erro em BuscarParametros: " + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarCodigo - Verifica se codigo ja existe na base
    *--------------------------------------------------------------------------
    PROCEDURE ValidarCodigo(par_nCodigo)
        LOCAL loc_lExiste, loc_cSQL, loc_nResult
        loc_lExiste = .F.

        TRY
            loc_cSQL = "SELECT COUNT(*) AS Total FROM SigCdPcz" + ;
                       " WHERE Codigos = " + FormatarNumeroSQL(par_nCodigo)

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Valid")

            IF loc_nResult >= 0 AND RECCOUNT("cursor_4c_Valid") > 0
                SELECT cursor_4c_Valid
                loc_lExiste = (cursor_4c_Valid.Total > 0)
            ENDIF

            IF USED("cursor_4c_Valid")
                USE IN cursor_4c_Valid
            ENDIF
        CATCH TO loException
            MsgErro("Erro em ValidarCodigo: " + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lExiste
    ENDPROC

    *--------------------------------------------------------------------------
    * GerarCodigoUnico - Gera proximo codigo unico (substitui fGerUniqueKey)
    *--------------------------------------------------------------------------
    PROCEDURE GerarCodigoUnico()
        LOCAL loc_nCodigo, loc_cSQL, loc_nResult
        loc_nCodigo = 0

        TRY
            loc_cSQL = "SELECT ISNULL(MAX(Codigos), 0) + 1 AS ProxCodigo FROM SigCdPcz"

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ProxCodigo")

            IF loc_nResult >= 0 AND RECCOUNT("cursor_4c_ProxCodigo") > 0
                SELECT cursor_4c_ProxCodigo
                loc_nCodigo = cursor_4c_ProxCodigo.ProxCodigo
            ENDIF

            IF USED("cursor_4c_ProxCodigo")
                USE IN cursor_4c_ProxCodigo
            ENDIF
        CATCH TO loException
            MsgErro("Erro em GerarCodigoUnico: " + loException.Message, "Erro")
        ENDTRY

        RETURN loc_nCodigo
    ENDPROC

ENDDEFINE

*==============================================================================
* SIGREHCPBO.PRG
* BO para Relatorio de Historico de Custo de Produtos
* Relatorios: SigRehc1.frx / SigRehc2.frx / SigRehc3.frx
*
* Filtros:
*   - Empresa (CEmps/DEmps) - apenas quando CalcCustos <> 1
*   - Produto (CPros/DPros)
*   - Periodo (DtInicial / DtFinal)
*   - TipoImps: 1=Relacao Padrao, 2=Modelo 3
*
* CalcCustos lido de SigCdPaC.calccustos:
*   1 = por Produto apenas (SigRehc2)
*   outros = por Empresa+Produto (SigRehc1)
*==============================================================================

DEFINE CLASS SIGREHCPBO AS RelatorioBase

    this_dDtInicial     = {}
    this_dDtFinal       = {}
    this_cCPros         = ""
    this_cDPros         = ""
    this_cCEmps         = ""
    this_cDEmps         = ""
    this_nTipoImps      = 1
    this_nCalcCustos    = 0

    *--------------------------------------------------------------------------
    PROCEDURE Init()
        LOCAL loc_lResultado
        loc_lResultado = .F.
        TRY
            loc_lResultado = DODEFAULT()
            IF loc_lResultado
                THIS.ObterParametros()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
            loc_lResultado = .F.
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterParametros - Le CalcCustos da tabela SigCdPaC
    *--------------------------------------------------------------------------
    PROCEDURE ObterParametros()
        LOCAL loc_cSQL, loc_nResult
        TRY
            loc_cSQL = "SELECT TOP 1 calccustos FROM SigCdPaC"
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Param")
            IF loc_nResult > 0
                SELECT cursor_4c_Param
                IF !EOF()
                    THIS.this_nCalcCustos = NVL(calccustos, 0)
                ENDIF
                USE IN cursor_4c_Param
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarFiltros - Valida campos de filtro antes de imprimir
    * Retorna "" se OK, ou nome do campo com erro
    *--------------------------------------------------------------------------
    PROCEDURE ValidarFiltros()
        LOCAL loc_cErro
        loc_cErro = ""

        IF EMPTY(THIS.this_dDtInicial)
            loc_cErro = "DataInicial"
        ELSE
            IF EMPTY(THIS.this_dDtFinal)
            loc_cErro = "DataFinal"
        ELSE
            IF THIS.this_dDtFinal < THIS.this_dDtInicial
            loc_cErro = "Periodo"
            ENDIF
            ENDIF
        ENDIF

        RETURN loc_cErro
    ENDPROC

    *--------------------------------------------------------------------------
    * PrepararDados - Monta cursor de dados para os FRX SigRehc1/2/3
    *
    * Cursor gerado: cursor_4c_Rehcp
    * Colunas: cpros, dpros, custofs, fcustos, pcuss, pvens, datas
    *--------------------------------------------------------------------------
    PROCEDURE PrepararDados()
        LOCAL loc_lResultado, loc_cSQL, loc_cWhere, loc_nResult
        loc_lResultado = .F.
        TRY
            loc_cWhere = "1=1"

            IF !EMPTY(THIS.this_cCPros)
                loc_cWhere = loc_cWhere + ;
                    " AND p.cpros = " + EscaparSQL(ALLTRIM(THIS.this_cCPros))
            ENDIF

            IF !EMPTY(THIS.this_dDtInicial)
                loc_cWhere = loc_cWhere + ;
                    " AND p.datas >= " + FormatarDataSQL(THIS.this_dDtInicial)
            ENDIF

            IF !EMPTY(THIS.this_dDtFinal)
                loc_cWhere = loc_cWhere + ;
                    " AND p.datas <= " + FormatarDataSQL(THIS.this_dDtFinal)
            ENDIF

            loc_cSQL = "SELECT p.cpros, p.dpros, p.custofs, p.fcustos, " + ;
                       "p.pcuss, p.pvens, p.datas " + ;
                       "FROM SigCdPro p " + ;
                       "WHERE " + loc_cWhere + ;
                       " ORDER BY p.cpros"

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Rehcp")

            IF loc_nResult > 0
                loc_lResultado = .T.
            ELSE
                THIS.this_cMensagemErro = "Erro ao buscar dados do relat" + ;
                    CHR(243) + "rio"
            ENDIF

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterCaminhoRelatorio - Determina qual FRX usar conforme filtros
    *
    * TipoImps=1 (Relacao Padrao):
    *   CalcCustos=1 -> SigRehc2 (por Produto)
    *   outro        -> SigRehc1 (por Empresa+Produto)
    * TipoImps=2 -> SigRehc3 (Modelo 3 Livro Fiscal)
    *--------------------------------------------------------------------------
    PROCEDURE ObterCaminhoRelatorio()
        LOCAL loc_cArquivo
        IF THIS.this_nTipoImps = 1
            IF THIS.this_nCalcCustos = 1
                loc_cArquivo = "SigRehc2"
            ELSE
                loc_cArquivo = "SigRehc1"
            ENDIF
        ELSE
            loc_cArquivo = "SigRehc3"
        ENDIF
        RETURN gc_4c_CaminhoReports + loc_cArquivo + ".frx"
    ENDPROC

    *--------------------------------------------------------------------------
    * Imprimir - Prepara dados e envia para impressora
    *--------------------------------------------------------------------------
    PROCEDURE Imprimir()
        LOCAL loc_lResultado, loc_cArquivo
        loc_lResultado = .F.
        TRY
            IF !THIS.PrepararDados()
                loc_lResultado = .F.
            ENDIF
            loc_cArquivo = THIS.ObterCaminhoRelatorio()
            SET POINT TO [,]
            SET SEPARATOR TO [.]
            REPORT FORM (loc_cArquivo) TO PRINT PROMPT NOCONSOLE
            SET POINT TO [.]
            SET SEPARATOR TO [,]
            loc_lResultado = .T.
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * Visualizar - Prepara dados e exibe preview na tela
    *--------------------------------------------------------------------------
    PROCEDURE Visualizar()
        LOCAL loc_lResultado, loc_cArquivo
        loc_lResultado = .F.
        TRY
            IF !THIS.PrepararDados()
                loc_lResultado = .F.
            ENDIF
            loc_cArquivo = THIS.ObterCaminhoRelatorio()
            SET POINT TO [,]
            SET SEPARATOR TO [.]
            REPORT FORM (loc_cArquivo) PREVIEW NOCONSOLE
            SET POINT TO [.]
            SET SEPARATOR TO [,]
            loc_lResultado = .T.
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterMensagemErro - Retorna ultima mensagem de erro
    *--------------------------------------------------------------------------
    PROCEDURE ObterMensagemErro()
        RETURN THIS.this_cMensagemErro
    ENDPROC

ENDDEFINE

*==============================================================================
* prcBO.prg - Business Object: Cadastro de Movimenta" + CHR(231) + CHR(245) + "es Para C" + CHR(243) + "pia
* Tabela principal : SigPcOoP (PK: codigos numeric(6,0))
* Tabelas filhas   : SigPcOoI (cidchaves PK), SigPcOog (cidchaves PK)
* Herda de         : BusinessBase (app\classes\businessbase.prg)
* Task             : task501
*==============================================================================
SET SAFETY OFF
SET RESOURCE OFF

DEFINE CLASS prcBO AS BusinessBase

    *-- Campos da tabela SigPcOoP
    this_cProcessos  = ""   && processos  CHAR(20)    - nome/chave do processo
    this_cEmps       = ""   && emps       CHAR(3)     - empresa
    this_cDopes      = ""   && dopes      CHAR(20)    - operacao
    this_nCodigos    = 0    && codigos    NUM(6,0)    - PK
    this_nNotas      = 0    && notas      NUM(1,0)
    this_nOrdems     = 0    && ordems     NUM(1,0)
    this_nApagar     = 0    && apagar     NUM(1,0)
    this_nFiscal     = 0    && fiscal     NUM(1,0)
    this_nImprimir   = 0    && imprimir   NUM(1,0)
    this_nLogs       = 0    && logs       NUM(1,0)
    this_nToleras    = 0    && toleras    NUM(11,2)
    this_cClass      = ""   && class      CHAR(15)
    this_cGrupo      = ""   && grupo      CHAR(15)

    *==========================================================================
    PROCEDURE Init()
    *==========================================================================
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            DODEFAULT()
            THIS.this_cTabela     = "SigPcOoP"
            THIS.this_cCampoChave = "codigos"
            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + "Linha: " + TRANSFORM(loc_oErro.LineNo), "prcBO.Init")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    FUNCTION ObterChavePrimaria()
    *==========================================================================
        RETURN TRANSFORM(THIS.this_nCodigos)
    ENDFUNC

    *==========================================================================
    * Buscar - SELECT lista para o grid
    * par_cFiltro: condicao WHERE adicional (sem WHERE) ou "" para todos
    *==========================================================================
    FUNCTION Buscar(par_cFiltro)
    *==========================================================================
        LOCAL loc_cSQL, loc_nResult, loc_lSucesso, loc_cWhere
        loc_lSucesso = .F.

        TRY
            IF USED("cursor_4c_Dados")
                USE IN cursor_4c_Dados
            ENDIF

            loc_cWhere = ""
            IF VARTYPE(par_cFiltro) = "C" AND !EMPTY(ALLTRIM(par_cFiltro))
                loc_cWhere = " WHERE " + par_cFiltro
            ENDIF

            loc_cSQL = "SELECT processos, emps, codigos" + ;
                       " FROM SigPcOoP" + loc_cWhere + ;
                       " ORDER BY processos"

            *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
            IF USED("cursor_4c_Dados")
                TABLEREVERT(.T., "cursor_4c_Dados")
                USE IN cursor_4c_Dados
            ENDIF

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")

            IF loc_nResult >= 0
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao buscar processos de c" + CHR(243) + "pia:" + ;
                    CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em prcBO.Buscar:" + CHR(13) + loc_oErro.Message + ;
                    CHR(13) + "Linha: " + TRANSFORM(loc_oErro.LineNo), "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *==========================================================================
    * CarregarPorCodigo - Carrega registro pelo codigos (PK)
    *==========================================================================
    FUNCTION CarregarPorCodigo(par_nCodigos)
    *==========================================================================
        LOCAL loc_cSQL, loc_nResult, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF USED("cursor_4c_Registro")
                USE IN cursor_4c_Registro
            ENDIF

            loc_cSQL = "SELECT processos, emps, dopes, codigos, notas, ordems," + ;
                       " apagar, fiscal, imprimir, logs, toleras, class AS tclass, grupo" + ;
                       " FROM SigPcOoP" + ;
                       " WHERE codigos = " + FormatarNumeroSQL(par_nCodigos)

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Registro")

            IF loc_nResult >= 0 AND RECCOUNT("cursor_4c_Registro") > 0
                loc_lSucesso = THIS.CarregarDoCursor("cursor_4c_Registro")
            ENDIF

            IF USED("cursor_4c_Registro")
                USE IN cursor_4c_Registro
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em prcBO.CarregarPorCodigo:" + CHR(13) + loc_oErro.Message + ;
                    CHR(13) + "Linha: " + TRANSFORM(loc_oErro.LineNo), "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *==========================================================================
    * CarregarDoCursor - Popula propriedades do BO a partir do cursor
    *==========================================================================
    FUNCTION CarregarDoCursor(par_cAliasCursor)
    *==========================================================================
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF USED(par_cAliasCursor)
                SELECT (par_cAliasCursor)
                THIS.this_cProcessos = TratarNulo(processos, "")
                THIS.this_cEmps      = TratarNulo(emps,      "")
                THIS.this_cDopes     = TratarNulo(dopes,     "")
                THIS.this_nCodigos   = TratarNulo(codigos,   0)
                THIS.this_nNotas     = TratarNulo(notas,     0)
                THIS.this_nOrdems    = TratarNulo(ordems,    0)
                THIS.this_nApagar    = TratarNulo(apagar,    0)
                THIS.this_nFiscal    = TratarNulo(fiscal,    0)
                THIS.this_nImprimir  = TratarNulo(imprimir,  0)
                THIS.this_nLogs      = TratarNulo(logs,      0)
                THIS.this_nToleras   = TratarNulo(toleras,   0)
                THIS.this_cClass     = TratarNulo(tclass,    "")
                THIS.this_cGrupo     = TratarNulo(grupo,     "")
                THIS.this_lNovoRegistro = .F.
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em prcBO.CarregarDoCursor:" + CHR(13) + loc_oErro.Message + ;
                    CHR(13) + "Linha: " + TRANSFORM(loc_oErro.LineNo), "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *==========================================================================
    PROTECTED FUNCTION Inserir()
    *==========================================================================
        LOCAL loc_cSQL, loc_nResult, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            THIS.this_nCodigos = THIS.ObterProxCodigos()

            loc_cSQL = "INSERT INTO SigPcOoP" + ;
                       " (processos, emps, dopes, codigos, notas, ordems," + ;
                       "  apagar, fiscal, imprimir, logs, toleras, class, grupo)" + ;
                       " VALUES (" + ;
                       EscaparSQL(THIS.this_cProcessos)           + ", " + ;
                       EscaparSQL(THIS.this_cEmps)                + ", " + ;
                       EscaparSQL(THIS.this_cDopes)               + ", " + ;
                       FormatarNumeroSQL(THIS.this_nCodigos)      + ", " + ;
                       FormatarNumeroSQL(THIS.this_nNotas)        + ", " + ;
                       FormatarNumeroSQL(THIS.this_nOrdems)       + ", " + ;
                       FormatarNumeroSQL(THIS.this_nApagar)       + ", " + ;
                       FormatarNumeroSQL(THIS.this_nFiscal)       + ", " + ;
                       FormatarNumeroSQL(THIS.this_nImprimir)     + ", " + ;
                       FormatarNumeroSQL(THIS.this_nLogs)         + ", " + ;
                       FormatarNumeroSQL(THIS.this_nToleras)      + ", " + ;
                       EscaparSQL(THIS.this_cClass)               + ", " + ;
                       EscaparSQL(THIS.this_cGrupo)               + ")"

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResult >= 0
                THIS.RegistrarAuditoria("INSERT")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao inserir processo de c" + CHR(243) + "pia:" + ;
                    CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em prcBO.Inserir:" + CHR(13) + loc_oErro.Message + ;
                    CHR(13) + "Linha: " + TRANSFORM(loc_oErro.LineNo), "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *==========================================================================
    PROTECTED FUNCTION Atualizar()
    *==========================================================================
        LOCAL loc_cSQL, loc_nResult, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "UPDATE SigPcOoP SET" + ;
                       " processos = " + EscaparSQL(THIS.this_cProcessos)       + ", " + ;
                       " emps      = " + EscaparSQL(THIS.this_cEmps)            + ", " + ;
                       " dopes     = " + EscaparSQL(THIS.this_cDopes)           + ", " + ;
                       " notas     = " + FormatarNumeroSQL(THIS.this_nNotas)    + ", " + ;
                       " ordems    = " + FormatarNumeroSQL(THIS.this_nOrdems)   + ", " + ;
                       " apagar    = " + FormatarNumeroSQL(THIS.this_nApagar)   + ", " + ;
                       " fiscal    = " + FormatarNumeroSQL(THIS.this_nFiscal)   + ", " + ;
                       " imprimir  = " + FormatarNumeroSQL(THIS.this_nImprimir) + ", " + ;
                       " logs      = " + FormatarNumeroSQL(THIS.this_nLogs)     + ", " + ;
                       " toleras   = " + FormatarNumeroSQL(THIS.this_nToleras)  + ", " + ;
                       " class     = " + EscaparSQL(THIS.this_cClass)           + ", " + ;
                       " grupo     = " + EscaparSQL(THIS.this_cGrupo)           + ;
                       " WHERE codigos = " + FormatarNumeroSQL(THIS.this_nCodigos)

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResult >= 0
                THIS.RegistrarAuditoria("UPDATE")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao atualizar processo de c" + CHR(243) + "pia:" + ;
                    CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em prcBO.Atualizar:" + CHR(13) + loc_oErro.Message + ;
                    CHR(13) + "Linha: " + TRANSFORM(loc_oErro.LineNo), "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *==========================================================================
    * ExecutarExclusao - Exclui em cascata: OoI -> OoG -> SigCdPrg -> OoP
    *==========================================================================
    PROTECTED FUNCTION ExecutarExclusao()
    *==========================================================================
        LOCAL loc_cSQL, loc_nResult, loc_lSucesso, loc_cProc
        loc_lSucesso = .F.

        TRY
            loc_cProc = ALLTRIM(THIS.this_cProcessos)

            loc_cSQL = "DELETE FROM SigPcOoI WHERE processos = " + EscaparSQL(loc_cProc)
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nResult < 0
                MsgErro("Erro ao excluir itens SigPcOoI:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ELSE
                loc_cSQL = "DELETE FROM SigPcOog WHERE processos = " + EscaparSQL(loc_cProc)
                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)
                IF loc_nResult < 0
                    MsgErro("Erro ao excluir grupos SigPcOog:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                ELSE
                    *-- Remove entrada em SigCdPrg (erro nao critico)
                    loc_cSQL = "DELETE FROM SigCdPrg" + ;
                               " WHERE programas = " + EscaparSQL(PADR("SIGCDPRC", 15)) + ;
                               " AND parametros = " + EscaparSQL(PADL(TRANSFORM(THIS.this_nCodigos), 10, "0"))
                    SQLEXEC(gnConnHandle, loc_cSQL)

                    loc_cSQL = "DELETE FROM SigPcOoP WHERE codigos = " + FormatarNumeroSQL(THIS.this_nCodigos)
                    loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)
                    IF loc_nResult >= 0
                        THIS.RegistrarAuditoria("DELETE")
                        loc_lSucesso = .T.
                    ELSE
                        MsgErro("Erro ao excluir SigPcOoP:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em prcBO.ExecutarExclusao:" + CHR(13) + loc_oErro.Message + ;
                    CHR(13) + "Linha: " + TRANSFORM(loc_oErro.LineNo), "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *==========================================================================
    * ObterProxCodigos - Gera proximo codigos (MAX+1) em SigPcOoP
    *==========================================================================
    PROTECTED FUNCTION ObterProxCodigos()
    *==========================================================================
        LOCAL loc_cSQL, loc_nResult, loc_nProx
        loc_nProx = 1

        TRY
            IF USED("cursor_4c_MaxCod")
                USE IN cursor_4c_MaxCod
            ENDIF

            loc_cSQL = "SELECT ISNULL(MAX(codigos), 0) + 1 AS proxcod FROM SigPcOoP"
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_MaxCod")

            IF loc_nResult > 0 AND !EOF("cursor_4c_MaxCod")
                loc_nProx = cursor_4c_MaxCod.proxcod
            ENDIF

            IF USED("cursor_4c_MaxCod")
                USE IN cursor_4c_MaxCod
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em prcBO.ObterProxCodigos:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_nProx
    ENDFUNC

    *==========================================================================
    * SalvarItens - Persiste csDestinos e csDestinoG no banco
    * par_cProcessos : nome do processo
    * par_nCodigos   : PK do processo
    *==========================================================================
    FUNCTION SalvarItens(par_cProcessos, par_nCodigos)
    *==========================================================================
        LOCAL loc_cSQL, loc_nResult, loc_lSucesso, loc_cCidChaves, loc_cFkChaves
        loc_lSucesso = .F.

        TRY
            *-- Limpa filhos anteriores
            loc_cSQL = "DELETE FROM SigPcOoI WHERE processos = " + EscaparSQL(par_cProcessos)
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nResult < 0
                MsgErro("Erro ao limpar SigPcOoI:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ELSE
                loc_cSQL = "DELETE FROM SigPcOog WHERE processos = " + EscaparSQL(par_cProcessos)
                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)
                IF loc_nResult < 0
                    MsgErro("Erro ao limpar SigPcOog:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                ELSE
                    IF USED("csDestinos")
                        SELECT csDestinos
                        SCAN
                            loc_cCidChaves = fUniqueIds()
                            loc_cFkChaves  = loc_cCidChaves

                            loc_cSQL = "INSERT INTO SigPcOoI" + ;
                                " (processos, emps, dopes, codigos, drives, empds," + ;
                                "  dopeds, tpprodutos, dias, gruconos, gruconds," + ;
                                "  agrupar, pctmins, pctmaxs, custos, imagem, barras," + ;
                                "  novocods, empdests, gdegrupos, cidchaves," + ;
                                "  franquias, oricompos, cunis, mccrs, delets, chkcons," + ;
                                "  cortams, desitens, destinos, montaobs, origems," + ;
                                "  semitens, situas, cheques, mantemmats, mantprods," + ;
                                "  recalculos, mantdpros, fiscais, impostos, pctcopias," + ;
                                "  movcparc, movmzeros, opitens, pctcomps, globalizas, moevals, atucli)" + ;
                                " VALUES (" + ;
                                EscaparSQL(par_cProcessos)                              + ", " + ;
                                EscaparSQL(ALLTRIM(csDestinos.Emps))                   + ", " + ;
                                EscaparSQL(ALLTRIM(csDestinos.Dopes))                  + ", " + ;
                                FormatarNumeroSQL(par_nCodigos)                        + ", " + ;
                                EscaparSQL(ALLTRIM(csDestinos.Drives))                 + ", " + ;
                                EscaparSQL(ALLTRIM(csDestinos.EmpDs))                  + ", " + ;
                                EscaparSQL(ALLTRIM(csDestinos.DopeDs))                 + ", " + ;
                                FormatarNumeroSQL(csDestinos.TpProdutos)               + ", " + ;
                                FormatarNumeroSQL(csDestinos.Dias)                     + ", " + ;
                                FormatarNumeroSQL(csDestinos.GruconOs)                 + ", " + ;
                                FormatarNumeroSQL(csDestinos.GruconDs)                 + ", " + ;
                                FormatarNumeroSQL(csDestinos.Agrupar)                  + ", " + ;
                                FormatarNumeroSQL(csDestinos.PctMins)                  + ", " + ;
                                FormatarNumeroSQL(csDestinos.PctMaxs)                  + ", " + ;
                                FormatarNumeroSQL(csDestinos.Custos)                   + ", " + ;
                                FormatarNumeroSQL(csDestinos.Imagem)                   + ", " + ;
                                FormatarNumeroSQL(csDestinos.Barras)                   + ", " + ;
                                FormatarNumeroSQL(csDestinos.NovoCods)                 + ", " + ;
                                FormatarNumeroSQL(csDestinos.EmpDests)                 + ", " + ;
                                EscaparSQL(ALLTRIM(csDestinos.GdeGrupos))              + ", " + ;
                                EscaparSQL(loc_cCidChaves)                             + ", " + ;
                                FormatarNumeroSQL(csDestinos.Franquias)                + ", " + ;
                                FormatarNumeroSQL(csDestinos.OriCompos)                + ", " + ;
                                EscaparSQL(ALLTRIM(csDestinos.CUnis))                  + ", " + ;
                                FormatarNumeroSQL(csDestinos.Mccrs)                    + ", " + ;
                                FormatarNumeroSQL(csDestinos.Delets)                   + ", " + ;
                                FormatarNumeroSQL(csDestinos.ChkCons)                  + ", " + ;
                                FormatarNumeroSQL(csDestinos.CorTams)                  + ", " + ;
                                FormatarNumeroSQL(csDestinos.DesItens)                 + ", " + ;
                                EscaparSQL(ALLTRIM(csDestinos.Destinos))               + ", " + ;
                                FormatarNumeroSQL(csDestinos.MontaObs)                 + ", " + ;
                                EscaparSQL(ALLTRIM(csDestinos.Origems))                + ", " + ;
                                FormatarNumeroSQL(csDestinos.SemItens)                 + ", " + ;
                                FormatarNumeroSQL(csDestinos.Situas)                   + ", " + ;
                                FormatarNumeroSQL(csDestinos.Cheques)                  + ", " + ;
                                FormatarNumeroSQL(csDestinos.MantemMats)               + ", " + ;
                                FormatarNumeroSQL(csDestinos.MantProds)                + ", " + ;
                                FormatarNumeroSQL(csDestinos.Recalculos)               + ", " + ;
                                FormatarNumeroSQL(csDestinos.MantDPros)                + ", " + ;
                                FormatarNumeroSQL(csDestinos.Fiscais)                  + ", " + ;
                                FormatarNumeroSQL(csDestinos.Impostos)                 + ", " + ;
                                FormatarNumeroSQL(csDestinos.PctCopias)                + ", " + ;
                                FormatarNumeroSQL(csDestinos.MovcParc)                 + ", " + ;
                                FormatarNumeroSQL(csDestinos.MovMZeros)                + ", " + ;
                                EscaparSQL(ALLTRIM(csDestinos.OpItens))                + ", " + ;
                                FormatarNumeroSQL(csDestinos.pctcomps)                 + ", " + ;
                                FormatarNumeroSQL(csDestinos.Globalizas)               + ", " + ;
                                FormatarNumeroSQL(csDestinos.MoeVals)                  + ", " + ;
                                "0)"

                            SQLEXEC(gnConnHandle, loc_cSQL)

                            *-- Grupos correspondentes do csDestinoG
                            IF USED("csDestinoG")
                                LOCAL loc_cIdRef
                                loc_cIdRef = ALLTRIM(csDestinos.cIdChaves)
                                SELECT csDestinoG
                                SCAN FOR ALLTRIM(csDestinoG.fkChaves) == loc_cIdRef ;
                                        AND (!EMPTY(ALLTRIM(csDestinoG.Mercs)) OR !EMPTY(ALLTRIM(csDestinoG.Cgrus)))
                                    loc_cSQL = "INSERT INTO SigPcOog" + ;
                                        " (processos, cidchaves, cunis, fkchaves, mercs, cgrus)" + ;
                                        " VALUES (" + ;
                                        EscaparSQL(par_cProcessos)                           + ", " + ;
                                        EscaparSQL(fUniqueIds())                              + ", " + ;
                                        EscaparSQL(ALLTRIM(csDestinoG.CUnis))                + ", " + ;
                                        EscaparSQL(loc_cFkChaves)                             + ", " + ;
                                        EscaparSQL(ALLTRIM(csDestinoG.Mercs))                + ", " + ;
                                        EscaparSQL(ALLTRIM(csDestinoG.Cgrus))                + ")"
                                    SQLEXEC(gnConnHandle, loc_cSQL)
                                ENDSCAN
                                SELECT csDestinos
                            ENDIF
                        ENDSCAN
                        loc_lSucesso = .T.
                    ELSE
                        MsgErro("Cursor csDestinos n" + CHR(227) + "o encontrado.", "Erro")
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em prcBO.SalvarItens:" + CHR(13) + loc_oErro.Message + ;
                    CHR(13) + "Linha: " + TRANSFORM(loc_oErro.LineNo), "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *==========================================================================
    * AtualizarSigCdPrg - Registra/atualiza entrada em SigCdPrg
    *==========================================================================
    FUNCTION AtualizarSigCdPrg(par_cProcessos, par_nCodigos)
    *==========================================================================
        LOCAL loc_cSQL, loc_nResult, loc_lSucesso, loc_cProg, loc_cParam
        loc_lSucesso = .F.

        TRY
            loc_cProg  = PADR("SIGCDPRC", 15)
            loc_cParam = PADL(TRANSFORM(par_nCodigos), 10, "0")

            loc_cSQL = "DELETE FROM SigCdPrg" + ;
                       " WHERE programas = " + EscaparSQL(loc_cProg) + ;
                       " AND parametros = " + EscaparSQL(loc_cParam)
            SQLEXEC(gnConnHandle, loc_cSQL)

            loc_cSQL = "INSERT INTO SigCdPrg (programas, parametros, descricaos)" + ;
                       " VALUES (" + ;
                       EscaparSQL(loc_cProg)                   + ", " + ;
                       EscaparSQL(loc_cParam)                  + ", " + ;
                       EscaparSQL(ALLTRIM(par_cProcessos))     + ")"

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResult >= 0
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao atualizar SigCdPrg:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em prcBO.AtualizarSigCdPrg:" + CHR(13) + loc_oErro.Message + ;
                    CHR(13) + "Linha: " + TRANSFORM(loc_oErro.LineNo), "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

ENDDEFINE

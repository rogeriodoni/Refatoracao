*==============================================================================
* sigopdivBO.prg - Business Object para Separacao de Industrializacao (SIGOPDIV)
* Herda de: BusinessBase
* Tabela principal: SigOpPic
* Fase 1/8: Propriedades e Init()
*==============================================================================

DEFINE CLASS sigopdivBO AS BusinessBase

    *--------------------------------------------------------------------------
    * Identificacao da tabela principal
    *--------------------------------------------------------------------------
    this_cTabela     = "SigOpPic"
    this_cCampoChave = "cidchaves"

    *--------------------------------------------------------------------------
    * Propriedades de contexto operacional do formulario
    * Espelham as properties customizadas do form legado SIGOPDIV
    * (codant, operacao, divisaoop, sigkey, envelopado, envelope, cemps,
    * lautomatico) - poDataMgr nao e portado pois o novo sistema usa
    * gnConnHandle direto.
    *--------------------------------------------------------------------------
    this_cCodAnt        = ""    && Codigo anterior (codant)
    this_cTipoOperacao  = ""    && Operacao: "D"=Divide Industrializacao, "R"=Reinicia
    this_cDivisaoOp     = ""    && Documento de divisao gerado (Divisaoop / SigCdPam.DivOps)
    this_cSigKey        = ""    && Chave de geracao de ids (SigKey / SigCdPac.SigKeys)
    this_lEnvelopado    = .F.   && Indica se a OP esta envelopada (Envelopado)
    this_nEnvelope      = 0     && Numero da OP envelope (Envelope)
    this_cEmpresa       = ""    && Empresa corrente (cEmps / _Empr)
    this_lAutomatico    = .F.   && Indica execucao automatica via parametro (lAutomatico)
    this_nNumeroOp      = 0     && Numero da O.P. em processamento (lnOp / pNop)

    *--------------------------------------------------------------------------
    * Propriedades de SigOpPic (registro/pedacos de OP em processamento)
    *--------------------------------------------------------------------------
    this_cCidchaves   = ""    && Chave primaria (PK)
    this_cEmps        = ""    && Empresa
    this_cDopps       = ""    && Documento da O.P.
    this_nNumps       = 0     && Numero da O.P.
    this_nNops        = 0     && Numero da O.P. (chave de agrupamento)
    this_cDopes       = ""    && Documento do pedido
    this_nNumes       = 0     && Numero do pedido
    this_dDataps      = {}    && Data de geracao da O.P.
    this_dDataes      = {}    && Data de entrega do pedido
    this_nQtds        = 0     && Quantidade
    this_cObss        = ""    && Observacoes
    this_nSeqdivs     = 0     && Sequencia de divisao
    this_cCpros       = ""    && Codigo do produto
    this_lDivs        = .F.   && Indica se o item foi dividido
    this_cCodcors     = ""    && Codigo da cor
    this_cCodtams     = ""    && Codigo do tamanho
    this_cUsuars      = ""    && Usuario responsavel
    this_nNopmaes     = 0     && Numero da O.P. mae (origem da divisao)
    this_nQtdcpnts    = 0     && Quantidade de componentes
    this_cEmpds       = ""    && Empresa de destino
    this_cEmpdopnums  = ""    && Chave Empresa+Documento+Numero (posicional)
    this_cEmpdnps     = ""    && Chave Empresa+Documento+NumeroOP (posicional)
    this_cEmpdopnops  = ""    && Chave Empresa+Documento+NumeroOPMae (posicional)
    this_cDpros       = ""    && Descricao do produto
    this_cNotas       = ""    && Nota do produto
    this_nCitens      = 0     && Item/componente
    this_nPesos       = 0     && Peso
    this_lImprs       = .F.   && Indica se foi impresso
    this_nCodbarras   = 0     && Codigo de barras (OP de servico com barra)
    this_nQtdtubos    = 0     && Quantidade de tubos
    this_lIimprs      = .F.   && Indica impressao secundaria
    this_cMoedas      = ""    && Moeda
    this_nUnits       = 0     && Valor unitario
    this_dDtfunds     = {}    && Data de fundicao
    this_nNfunds      = 0     && Numero da fundicao
    this_cCodtgops    = ""    && Codigo da tag da O.P.
    this_dDatatrans   = {}    && Data de transferencia
    this_cLocals      = ""    && Local
    this_nNtrans      = 0     && Numero da transferencia
    this_dDtgeras     = {}    && Data de geracao

    *==========================================================================
    PROCEDURE Init()
    *==========================================================================
        LOCAL loc_lSucesso

        loc_lSucesso = .F.

        TRY
            DODEFAULT()

            THIS.this_cTabela     = "SigOpPic"
            THIS.this_cCampoChave = "cidchaves"

            loc_lSucesso = .T.

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    PROCEDURE ObterChavePrimaria()
    *==========================================================================
    *-- Retorna a chave primaria do registro corrente
        RETURN THIS.this_cCidchaves
    ENDPROC

    *==========================================================================
    * CarregarDoCursor - Popula as propriedades a partir de um cursor
    * aberto com SELECT * FROM SigOpPic (ou subconjunto com os mesmos nomes)
    *==========================================================================
    PROTECTED FUNCTION CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso

        loc_lSucesso = .F.

        IF USED(par_cAliasCursor)
            SELECT (par_cAliasCursor)

            THIS.this_cCidchaves   = TratarNulo(cidchaves,   "")
            THIS.this_cEmps        = TratarNulo(emps,        "")
            THIS.this_cDopps       = TratarNulo(dopps,       "")
            THIS.this_nNumps       = TratarNulo(numps,       0)
            THIS.this_nNops        = TratarNulo(nops,        0)
            THIS.this_cDopes       = TratarNulo(dopes,       "")
            THIS.this_nNumes       = TratarNulo(numes,       0)
            THIS.this_dDataps      = TratarNulo(dataps,      {})
            THIS.this_dDataes      = TratarNulo(dataes,      {})
            THIS.this_nQtds        = TratarNulo(qtds,        0)
            THIS.this_cObss        = TratarNulo(obss,        "")
            THIS.this_nSeqdivs     = TratarNulo(seqdivs,     0)
            THIS.this_cCpros       = TratarNulo(cpros,       "")
            THIS.this_lDivs        = ConverterParaLogico(divs)
            THIS.this_cCodcors     = TratarNulo(codcors,     "")
            THIS.this_cCodtams     = TratarNulo(codtams,     "")
            THIS.this_cUsuars      = TratarNulo(usuars,      "")
            THIS.this_nNopmaes     = TratarNulo(nopmaes,     0)
            THIS.this_nQtdcpnts    = TratarNulo(qtdcpnts,    0)
            THIS.this_cEmpds       = TratarNulo(empds,       "")
            THIS.this_cEmpdopnums  = TratarNulo(empdopnums,  "")
            THIS.this_cEmpdnps     = TratarNulo(empdnps,     "")
            THIS.this_cEmpdopnops  = TratarNulo(empdopnops,  "")
            THIS.this_cDpros       = TratarNulo(dpros,       "")
            THIS.this_cNotas       = TratarNulo(notas,       "")
            THIS.this_nCitens      = TratarNulo(citens,      0)
            THIS.this_nPesos       = TratarNulo(pesos,       0)
            THIS.this_lImprs       = ConverterParaLogico(imprs)
            THIS.this_nCodbarras   = TratarNulo(codbarras,   0)
            THIS.this_nQtdtubos    = TratarNulo(qtdtubos,    0)
            THIS.this_lIimprs      = ConverterParaLogico(iimprs)
            THIS.this_cMoedas      = TratarNulo(moedas,      "")
            THIS.this_nUnits       = TratarNulo(units,       0)
            THIS.this_dDtfunds     = TratarNulo(dtfunds,     {})
            THIS.this_nNfunds      = TratarNulo(nfunds,      0)
            THIS.this_cCodtgops    = TratarNulo(codtgops,    "")
            THIS.this_dDatatrans   = TratarNulo(datatrans,   {})
            THIS.this_cLocals      = TratarNulo(locals,      "")
            THIS.this_nNtrans      = TratarNulo(ntrans,      0)
            THIS.this_dDtgeras     = TratarNulo(dtgeras,     {})

            loc_lSucesso = .T.
        ENDIF

        RETURN loc_lSucesso
    ENDFUNC

    *==========================================================================
    * Inserir - INSERT na tabela SigOpPic
    * cidchaves (PK) e gerado via fUniqueIds(), igual ao legado
    * (Insert Into crSigOpPic ... fUniqueIds() ...)
    *==========================================================================
    PROTECTED FUNCTION Inserir()
        LOCAL loc_cSQL, loc_nResult, loc_lSucesso

        loc_lSucesso = .F.

        TRY
            IF EMPTY(THIS.this_cCidchaves)
                THIS.this_cCidchaves = fUniqueIds()
            ENDIF

            loc_cSQL = "INSERT INTO SigOpPic" + ;
                       " (cidchaves, emps, dopps, numps, nops, dopes, numes, dataps, dataes, qtds," + ;
                       "  obss, seqdivs, cpros, divs, codcors, codtams, usuars, nopmaes, qtdcpnts," + ;
                       "  empds, empdopnums, empdnps, empdopnops, dpros, notas, citens, pesos," + ;
                       "  imprs, codbarras, qtdtubos, iimprs, moedas, units, dtfunds, nfunds," + ;
                       "  codtgops, datatrans, locals, ntrans, dtgeras)" + ;
                       " VALUES (" + ;
                       EscaparSQL(THIS.this_cCidchaves)         + ", " + ;
                       EscaparSQL(THIS.this_cEmps)              + ", " + ;
                       EscaparSQL(THIS.this_cDopps)             + ", " + ;
                       FormatarNumeroSQL(THIS.this_nNumps, 0)   + ", " + ;
                       FormatarNumeroSQL(THIS.this_nNops, 0)    + ", " + ;
                       EscaparSQL(THIS.this_cDopes)             + ", " + ;
                       FormatarNumeroSQL(THIS.this_nNumes, 0)   + ", " + ;
                       FormatarDataSQL(THIS.this_dDataps)       + ", " + ;
                       FormatarDataSQL(THIS.this_dDataes)       + ", " + ;
                       FormatarNumeroSQL(THIS.this_nQtds, 3)    + ", " + ;
                       EscaparSQL(THIS.this_cObss)              + ", " + ;
                       FormatarNumeroSQL(THIS.this_nSeqdivs, 0) + ", " + ;
                       EscaparSQL(THIS.this_cCpros)             + ", " + ;
                       IIF(THIS.this_lDivs, "1", "0")           + ", " + ;
                       EscaparSQL(THIS.this_cCodcors)           + ", " + ;
                       EscaparSQL(THIS.this_cCodtams)           + ", " + ;
                       EscaparSQL(THIS.this_cUsuars)            + ", " + ;
                       FormatarNumeroSQL(THIS.this_nNopmaes, 0) + ", " + ;
                       FormatarNumeroSQL(THIS.this_nQtdcpnts, 0) + ", " + ;
                       EscaparSQL(THIS.this_cEmpds)             + ", " + ;
                       EscaparSQL(THIS.this_cEmpdopnums)        + ", " + ;
                       EscaparSQL(THIS.this_cEmpdnps)           + ", " + ;
                       EscaparSQL(THIS.this_cEmpdopnops)        + ", " + ;
                       EscaparSQL(THIS.this_cDpros)             + ", " + ;
                       EscaparSQL(THIS.this_cNotas)             + ", " + ;
                       FormatarNumeroSQL(THIS.this_nCitens, 0)  + ", " + ;
                       FormatarNumeroSQL(THIS.this_nPesos, 3)   + ", " + ;
                       IIF(THIS.this_lImprs, "1", "0")          + ", " + ;
                       FormatarNumeroSQL(THIS.this_nCodbarras, 0) + ", " + ;
                       FormatarNumeroSQL(THIS.this_nQtdtubos, 3)  + ", " + ;
                       IIF(THIS.this_lIimprs, "1", "0")         + ", " + ;
                       EscaparSQL(THIS.this_cMoedas)            + ", " + ;
                       FormatarNumeroSQL(THIS.this_nUnits, 6)   + ", " + ;
                       FormatarDataSQL(THIS.this_dDtfunds)      + ", " + ;
                       FormatarNumeroSQL(THIS.this_nNfunds, 0)  + ", " + ;
                       EscaparSQL(THIS.this_cCodtgops)          + ", " + ;
                       FormatarDataSQL(THIS.this_dDatatrans)    + ", " + ;
                       EscaparSQL(THIS.this_cLocals)            + ", " + ;
                       FormatarNumeroSQL(THIS.this_nNtrans, 0)  + ", " + ;
                       FormatarDataSQL(THIS.this_dDtgeras)      + ")"

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nResult >= 0
                THIS.RegistrarAuditoria("INSERT")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao inserir registro:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em sigopdivBO.Inserir: " + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *==========================================================================
    * Atualizar - UPDATE na tabela SigOpPic (identifica pela PK cidchaves)
    *==========================================================================
    PROTECTED FUNCTION Atualizar()
        LOCAL loc_cSQL, loc_nResult, loc_lSucesso

        loc_lSucesso = .F.

        TRY
            loc_cSQL = "UPDATE SigOpPic SET" + ;
                       "  emps        = " + EscaparSQL(THIS.this_cEmps)               + "," + ;
                       "  dopps       = " + EscaparSQL(THIS.this_cDopps)              + "," + ;
                       "  numps       = " + FormatarNumeroSQL(THIS.this_nNumps, 0)    + "," + ;
                       "  nops        = " + FormatarNumeroSQL(THIS.this_nNops, 0)     + "," + ;
                       "  dopes       = " + EscaparSQL(THIS.this_cDopes)              + "," + ;
                       "  numes       = " + FormatarNumeroSQL(THIS.this_nNumes, 0)    + "," + ;
                       "  dataps      = " + FormatarDataSQL(THIS.this_dDataps)        + "," + ;
                       "  dataes      = " + FormatarDataSQL(THIS.this_dDataes)        + "," + ;
                       "  qtds        = " + FormatarNumeroSQL(THIS.this_nQtds, 3)     + "," + ;
                       "  obss        = " + EscaparSQL(THIS.this_cObss)               + "," + ;
                       "  seqdivs     = " + FormatarNumeroSQL(THIS.this_nSeqdivs, 0)  + "," + ;
                       "  cpros       = " + EscaparSQL(THIS.this_cCpros)              + "," + ;
                       "  divs        = " + IIF(THIS.this_lDivs, "1", "0")            + "," + ;
                       "  codcors     = " + EscaparSQL(THIS.this_cCodcors)            + "," + ;
                       "  codtams     = " + EscaparSQL(THIS.this_cCodtams)            + "," + ;
                       "  usuars      = " + EscaparSQL(THIS.this_cUsuars)             + "," + ;
                       "  nopmaes     = " + FormatarNumeroSQL(THIS.this_nNopmaes, 0)  + "," + ;
                       "  qtdcpnts    = " + FormatarNumeroSQL(THIS.this_nQtdcpnts, 0) + "," + ;
                       "  empds       = " + EscaparSQL(THIS.this_cEmpds)              + "," + ;
                       "  empdopnums  = " + EscaparSQL(THIS.this_cEmpdopnums)         + "," + ;
                       "  empdnps     = " + EscaparSQL(THIS.this_cEmpdnps)            + "," + ;
                       "  empdopnops  = " + EscaparSQL(THIS.this_cEmpdopnops)         + "," + ;
                       "  dpros       = " + EscaparSQL(THIS.this_cDpros)              + "," + ;
                       "  notas       = " + EscaparSQL(THIS.this_cNotas)              + "," + ;
                       "  citens      = " + FormatarNumeroSQL(THIS.this_nCitens, 0)   + "," + ;
                       "  pesos       = " + FormatarNumeroSQL(THIS.this_nPesos, 3)    + "," + ;
                       "  imprs       = " + IIF(THIS.this_lImprs, "1", "0")           + "," + ;
                       "  codbarras   = " + FormatarNumeroSQL(THIS.this_nCodbarras, 0) + "," + ;
                       "  qtdtubos    = " + FormatarNumeroSQL(THIS.this_nQtdtubos, 3) + "," + ;
                       "  iimprs      = " + IIF(THIS.this_lIimprs, "1", "0")          + "," + ;
                       "  moedas      = " + EscaparSQL(THIS.this_cMoedas)             + "," + ;
                       "  units       = " + FormatarNumeroSQL(THIS.this_nUnits, 6)    + "," + ;
                       "  dtfunds     = " + FormatarDataSQL(THIS.this_dDtfunds)       + "," + ;
                       "  nfunds      = " + FormatarNumeroSQL(THIS.this_nNfunds, 0)   + "," + ;
                       "  codtgops    = " + EscaparSQL(THIS.this_cCodtgops)           + "," + ;
                       "  datatrans   = " + FormatarDataSQL(THIS.this_dDatatrans)     + "," + ;
                       "  locals      = " + EscaparSQL(THIS.this_cLocals)             + "," + ;
                       "  ntrans      = " + FormatarNumeroSQL(THIS.this_nNtrans, 0)   + "," + ;
                       "  dtgeras     = " + FormatarDataSQL(THIS.this_dDtgeras)       + ;
                       " WHERE cidchaves = " + EscaparSQL(THIS.this_cCidchaves)

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nResult >= 0
                THIS.RegistrarAuditoria("UPDATE")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao atualizar registro:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em sigopdivBO.Atualizar: " + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC


    *==========================================================================
    * ExecutarConsulta - Helper interno: roda uma consulta no SQL Server
    * devolvendo o resultado num cursor local. Fecha o alias antes, guardando
    * o TABLEREVERT pelo BUFFERING (cursor de SQLEXEC nasce com Buffering 1 e
    * TABLEREVERT sem buffering dispara erro 1586).
    * NUNCA e usado sobre o alias de um Grid (isso zeraria o ColumnCount) - os
    * aliases daqui sao todos de trabalho, nenhum e RecordSource de grade.
    * Retorno: >= 0 sucesso (igual ao SQLEXEC), -1 falha
    *==========================================================================
    PROTECTED FUNCTION ExecutarConsulta(par_cSQL, par_cCursor)
        LOCAL loc_nResultado

        IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
            THIS.this_cMensagemErro = "Sem conex" + CHR(227) + "o com o banco de dados."
            RETURN -1
        ENDIF

        IF !EMPTY(par_cCursor)
            THIS.FecharCursor(par_cCursor)
        ENDIF

        IF EMPTY(par_cCursor)
            loc_nResultado = SQLEXEC(gnConnHandle, par_cSQL)
        ELSE
            loc_nResultado = SQLEXEC(gnConnHandle, par_cSQL, par_cCursor)
        ENDIF

        RETURN loc_nResultado
    ENDFUNC

    *==========================================================================
    * MensagemReinicializar - Texto unico das falhas de conexao do legado
    * ("Favor Reinicializar o Processo!!!" + o passo que falhou)
    *==========================================================================
    PROTECTED FUNCTION MensagemReinicializar(par_cPasso)
        RETURN "Favor Reinicializar o Processo!!!" + CHR(13) + ;
               "Falha na conex" + CHR(227) + "o (" + par_cPasso + ")" + CHR(13) + ;
               CapturarErroSQL()
    ENDFUNC

    *==========================================================================
    * CarregarDivisoesOp - Carrega na grade de divisao os itens (pedidos) da
    * O.P. informada pelo usuario. Transcreve a parte de DADOS do
    * SIGOPDIV.Get_OP.Valid do legado:
    *
    *   1. resolve a O.P. de ENVELOPE (SigCdOpd.ChkDests = 1 -> SigPdMvf), que
    *      pode SUBSTITUIR o numero digitado (this_nNumeroOp);
    *   2. confere se a O.P. existe (SigOpPic) e e da empresa corrente;
    *   3. confere se nao foi encerrada (SigCdNec.ChkSubn);
    *   4. confere se o setor permite divisao (SigCdGcr.BlqDivOps);
    *   5. recusa O.P. de servico com codigo de barras (SigOpPic.CodBarras);
    *   6. numera a sequencia de divisao (UPDATE SigOpPic.SeqDivs) e insere uma
    *      linha por item no cursor da grade, com a conta resolvida em
    *      SigMvCab/SigCdOpe (globalizada/servico -> ContaOs, senao ContaDs);
    *   7. carrega os insumos da nota de entrada (SigCdNei) do grupo mais
    *      recente, usados depois pela geracao da O.P.
    *
    * par_nNop            : numero da O.P. digitado
    * par_cCursorDivisoes : alias do cursor da grade (Temp_DivOp do legado)
    * par_cCursorInsumos  : alias do cursor de insumos (xNensi do legado)
    *
    * Retorno: 1 = carregou | 0 = recusado por regra | -1 = falha de execucao
    *          Em 0 e -1 a mensagem fica em this_cMensagemErro.
    *
    * O corpo mora em ExecutarCargaDivisoes porque depende de varios RETURN
    * antecipados, proibidos dentro de TRY/CATCH.
    *==========================================================================
    FUNCTION CarregarDivisoesOp(par_nNop, par_cCursorDivisoes, par_cCursorInsumos)
        LOCAL loc_nStatus, loc_oErro

        loc_nStatus = -1

        TRY
            loc_nStatus = THIS.ExecutarCargaDivisoes(par_nNop, par_cCursorDivisoes, ;
                                                     par_cCursorInsumos)
        CATCH TO loc_oErro
            loc_nStatus = -1
            THIS.this_cMensagemErro = loc_oErro.Message + CHR(13) + ;
                                      "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                                      "Procedure: " + loc_oErro.Procedure
        ENDTRY

        RETURN loc_nStatus
    ENDFUNC

    *==========================================================================
    * ExecutarCargaDivisoes - Corpo de CarregarDivisoesOp (ver cabecalho la).
    * PROTECTED: so o wrapper chama - o form nunca chama metodo PROTECTED do BO.
    *==========================================================================
    PROTECTED FUNCTION ExecutarCargaDivisoes(par_nNop, par_cCursorDivisoes, par_cCursorInsumos)
        LOCAL loc_nNop, loc_nCitem, loc_cSQL, loc_cBusca, loc_cDopps, loc_cEdn
        LOCAL loc_cConta, loc_cGrupo, loc_lTemNec, loc_lEncerrada

        THIS.this_cMensagemErro = ""
        THIS.this_lEnvelopado   = .F.
        THIS.this_nEnvelope     = 0
        THIS.this_cCpros        = ""

        loc_nNop            = par_nNop
        THIS.this_nNumeroOp = loc_nNop

        *----------------------------------------------------------------------
        * 1. O.P. de ENVELOPE
        *    Legado: lcSql = [Select Dopps From SigCdOpd where ChkDests = 1 ]
        *----------------------------------------------------------------------
        loc_cSQL = "SELECT Dopps FROM SigCdOpd WHERE ChkDests = 1"
        IF THIS.ExecutarConsulta(loc_cSQL, "cursor_4c_OpdDest") < 0
            THIS.this_cMensagemErro = THIS.MensagemReinicializar("SigCdOpd")
            RETURN -1
        ENDIF

        IF RECCOUNT("cursor_4c_OpdDest") > 0
            SELECT cursor_4c_OpdDest
            GO TOP
            loc_cDopps = TratarNulo(cursor_4c_OpdDest.Dopps, "")

            *-- EmpDnPs char(33) e chave POSICIONAL: Emps char(3) +
            *-- Dopps char(20) + Str(Nops,10) = 33. PADR explicito - ALLTRIM
            *-- nas partes interiores encurtaria a chave e ela nunca casaria.
            loc_cBusca = PADR(THIS.this_cEmpresa, 3) + PADR(loc_cDopps, 20) + ;
                         STR(loc_nNop, 10)

            loc_cSQL = "SELECT Nops, Numps FROM SigPdMvf" + ;
                       " WHERE EmpDnPs = " + EscaparSQL(loc_cBusca)
            IF THIS.ExecutarConsulta(loc_cSQL, "cursor_4c_MfasEnv") < 0
                THIS.this_cMensagemErro = THIS.MensagemReinicializar("SigPdMvf - EmpDnPs")
                RETURN -1
            ENDIF

            IF RECCOUNT("cursor_4c_MfasEnv") > 0
                SELECT cursor_4c_MfasEnv
                GO TOP
                *-- O numero digitado e SUBSTITUIDO pela O.P. do envelope
                loc_nNop              = TratarNulo(cursor_4c_MfasEnv.Nops, 0)
                THIS.this_nNumeroOp   = loc_nNop
                THIS.this_lEnvelopado = .T.
                THIS.this_nEnvelope   = TratarNulo(cursor_4c_MfasEnv.Numps, 0)
            ELSE
                loc_cSQL = "SELECT Nops, Numps FROM SigPdMvf" + ;
                           " WHERE Nops = " + FormatarNumeroSQL(loc_nNop, 0) + ;
                           "   AND Dopps = " + EscaparSQL(ALLTRIM(loc_cDopps))
                IF THIS.ExecutarConsulta(loc_cSQL, "cursor_4c_MfasEnv") < 0
                    THIS.this_cMensagemErro = THIS.MensagemReinicializar("SigPdMvf - Nops/Dopps")
                    RETURN -1
                ENDIF
                IF RECCOUNT("cursor_4c_MfasEnv") > 0
                    SELECT cursor_4c_MfasEnv
                    GO TOP
                    THIS.this_lEnvelopado = .T.
                    THIS.this_nEnvelope   = TratarNulo(cursor_4c_MfasEnv.Numps, 0)
                ENDIF
            ENDIF
        ENDIF

        *----------------------------------------------------------------------
        * 2. A O.P. existe e e da empresa corrente?
        *    Legado: CursorQuery('SigOpPic','TmpOpi','Nops',pNop)
        *----------------------------------------------------------------------
        loc_cSQL = "SELECT Emps, Dopps, EmpDopNops FROM SigOpPic" + ;
                   " WHERE Nops = " + FormatarNumeroSQL(loc_nNop, 0)
        IF THIS.ExecutarConsulta(loc_cSQL, "cursor_4c_OpiBusca") < 0
            THIS.this_cMensagemErro = THIS.MensagemReinicializar("SigOpPic - Nops")
            RETURN -1
        ENDIF

        IF RECCOUNT("cursor_4c_OpiBusca") = 0
            THIS.this_cMensagemErro = "O.P. n" + CHR(227) + "o localizada!!"
            RETURN 0
        ENDIF

        SELECT cursor_4c_OpiBusca
        GO TOP
        IF ALLTRIM(TratarNulo(cursor_4c_OpiBusca.Emps, "")) <> ALLTRIM(THIS.this_cEmpresa)
            THIS.this_cMensagemErro = "Op " + ALLTRIM(STR(loc_nNop)) + " " + CHR(233) + ;
                                      " de outra empresa " + ;
                                      ALLTRIM(TratarNulo(cursor_4c_OpiBusca.Emps, ""))
            RETURN 0
        ENDIF

        loc_cEdn             = TratarNulo(cursor_4c_OpiBusca.EmpDopNops, "")
        THIS.this_cDivisaoOp = ALLTRIM(TratarNulo(cursor_4c_OpiBusca.Dopps, ""))

        *----------------------------------------------------------------------
        * 3. A O.P. ja foi encerrada?
        *    Legado: CursorQuery('SigCdNec','TmpNens','EmpDnPs',lcEdn,[ChkSubn])
        *    ChkSubn e coluna BIT - o driver devolve ora logico ora numerico,
        *    por isso ConverterParaLogico em vez de comparar com 1.
        *----------------------------------------------------------------------
        loc_cSQL = "SELECT ChkSubn FROM SigCdNec" + ;
                   " WHERE EmpDnPs = " + EscaparSQL(loc_cEdn)
        IF THIS.ExecutarConsulta(loc_cSQL, "cursor_4c_NecBusca") < 0
            THIS.this_cMensagemErro = THIS.MensagemReinicializar("SigCdNec - EmpDnPs")
            RETURN -1
        ENDIF

        loc_lTemNec    = (RECCOUNT("cursor_4c_NecBusca") > 0)
        loc_lEncerrada = .F.
        IF loc_lTemNec
            SELECT cursor_4c_NecBusca
            GO TOP
            loc_lEncerrada = ConverterParaLogico(cursor_4c_NecBusca.ChkSubn)
        ENDIF

        IF !loc_lTemNec
            THIS.this_cMensagemErro = "O.P. n" + CHR(227) + "o localizada!!"
            RETURN 0
        ENDIF
        IF loc_lEncerrada
            THIS.this_cMensagemErro = "O.P. j" + CHR(225) + " foi encerrada!!"
            RETURN 0
        ENDIF

        *----------------------------------------------------------------------
        * 4. O setor da O.P. permite divisao? (SigCdGcr.BlqDivOps)
        *----------------------------------------------------------------------
        loc_cSQL = "SELECT Nops, Emps, Dopps, Numps, cIdChaves, Grupods FROM SigPdMvf" + ;
                   " WHERE Nops = " + FormatarNumeroSQL(loc_nNop, 0) + ;
                   " ORDER BY Nops DESC, cIdChaves DESC"
        IF THIS.ExecutarConsulta(loc_cSQL, "cursor_4c_MfasLocal") < 0
            THIS.this_cMensagemErro = THIS.MensagemReinicializar("LocalMfas")
            RETURN -1
        ENDIF

        loc_cGrupo = ""
        IF RECCOUNT("cursor_4c_MfasLocal") > 0
            SELECT cursor_4c_MfasLocal
            GO TOP
            loc_cGrupo = ALLTRIM(TratarNulo(cursor_4c_MfasLocal.Grupods, ""))
        ENDIF

        IF !EMPTY(loc_cGrupo)
            loc_cSQL = "SELECT BlqDivOps FROM SigCdGcr" + ;
                       " WHERE codigos = " + EscaparSQL(loc_cGrupo)
            IF THIS.ExecutarConsulta(loc_cSQL, "cursor_4c_GcrBusca") < 0
                THIS.this_cMensagemErro = THIS.MensagemReinicializar("SigCdGcr - codigos")
                RETURN -1
            ENDIF
            IF RECCOUNT("cursor_4c_GcrBusca") > 0
                SELECT cursor_4c_GcrBusca
                GO TOP
                IF TratarNulo(cursor_4c_GcrBusca.BlqDivOps, 0) = 1
                    THIS.this_cMensagemErro = "Setor Bloqueado para Divis" + CHR(227) + "o de Op!!!"
                    RETURN 0
                ENDIF
            ENDIF
        ENDIF

        *----------------------------------------------------------------------
        * 5. Itens da O.P. + recusa de O.P. de servico com codigo de barras
        *----------------------------------------------------------------------
        loc_cSQL = "SELECT cidchaves, dopes, numes, qtds, dataes, obss, cpros," + ;
                   " codcors, codtams, empds, dpros, notas, citens, pesos," + ;
                   " codbarras, empdopnums FROM SigOpPic" + ;
                   " WHERE Nops = " + FormatarNumeroSQL(loc_nNop, 0)
        *-- SEM ORDER BY, igual ao legado ("Select * From SigOpPic Where
        *-- Nops = ?pNop"): a ordem do servidor e' a ordem em que a grade
        *-- aparece E a ordem em que SeqDivs e' numerado - inventar uma
        *-- ordenacao aqui mudaria a numeracao gravada.
        IF THIS.ExecutarConsulta(loc_cSQL, "cursor_4c_OpiLocal") < 0
            THIS.this_cMensagemErro = THIS.MensagemReinicializar("LocalOpi")
            RETURN -1
        ENDIF

        IF RECCOUNT("cursor_4c_OpiLocal") = 0
            THIS.this_cMensagemErro = "O.P. n" + CHR(227) + "o localizada!!"
            RETURN 0
        ENDIF

        SELECT cursor_4c_OpiLocal
        GO TOP
        IF TratarNulo(cursor_4c_OpiLocal.CodBarras, 0) > 0
            THIS.this_cMensagemErro = "Op de Servi" + CHR(231) + "o com Barra n" + ;
                                      CHR(227) + "o pode ser Dividido!!!"
            RETURN 0
        ENDIF

        *-- Produto exibido no campo Get_Produto (somente leitura)
        THIS.this_cCpros = ALLTRIM(TratarNulo(cursor_4c_OpiLocal.Cpros, ""))

        *----------------------------------------------------------------------
        * 6. Numera a sequencia de divisao e monta a grade (1 linha por item)
        *----------------------------------------------------------------------
        loc_nCitem = 1
        SELECT cursor_4c_OpiLocal
        SCAN
            loc_cSQL = "UPDATE SigOpPic SET SeqDivs = " + ;
                       FormatarNumeroSQL(loc_nCitem, 0) + ;
                       " WHERE CidChaves = " + ;
                       EscaparSQL(TratarNulo(cursor_4c_OpiLocal.CidChaves, ""))
            IF THIS.ExecutarConsulta(loc_cSQL, "") < 0
                THIS.this_cMensagemErro = THIS.MensagemReinicializar("Update - SigOpPic")
                RETURN -1
            ENDIF

            *-- Conta do movimento: operacao globalizada ou de servico usa a
            *-- conta de ORIGEM (ContaOs); as demais usam a de DESTINO (ContaDs).
            loc_cSQL = "SELECT a.ContaOs, a.ContaDs, b.Globalizas, b.Servicos" + ;
                       " FROM SigMvCab a, SigCdOpe b" + ;
                       " WHERE a.EmpDopNums = " + ;
                       EscaparSQL(TratarNulo(cursor_4c_OpiLocal.EmpDopNums, "")) + ;
                       "   AND a.Dopes = b.Dopes"
            IF THIS.ExecutarConsulta(loc_cSQL, "cursor_4c_ContaBusca") < 0
                THIS.this_cMensagemErro = THIS.MensagemReinicializar("LocalEest")
                RETURN -1
            ENDIF

            loc_cConta = ""
            IF RECCOUNT("cursor_4c_ContaBusca") > 0
                SELECT cursor_4c_ContaBusca
                GO TOP
                IF TratarNulo(cursor_4c_ContaBusca.Globalizas, 0) = 1 OR ;
                   TratarNulo(cursor_4c_ContaBusca.Servicos, 0) = 1
                    loc_cConta = TratarNulo(cursor_4c_ContaBusca.ContaOs, "")
                ELSE
                    loc_cConta = TratarNulo(cursor_4c_ContaBusca.ContaDs, "")
                ENDIF
            ENDIF

            *-- Legado: Replace SeqDivs with _citem (no cursor local) +
            *-- Insert Into Temp_DivOp (...). Aqui APPEND BLANK + REPLACE, para
            *-- nao depender de name expression em INSERT INTO. O cursor da
            *-- grade NUNCA recebe SQLEXEC (isso zeraria o ColumnCount).
            SELECT (par_cCursorDivisoes)
            APPEND BLANK
            REPLACE Dopes   WITH TratarNulo(cursor_4c_OpiLocal.Dopes, ""), ;
                    Numes   WITH TratarNulo(cursor_4c_OpiLocal.Numes, 0), ;
                    Qtds    WITH TratarNulo(cursor_4c_OpiLocal.Qtds, 0), ;
                    Dataes  WITH ConverterParaData(cursor_4c_OpiLocal.Dataes), ;
                    Obss    WITH TratarNulo(cursor_4c_OpiLocal.Obss, ""), ;
                    SeqDivs WITH loc_nCitem, ;
                    Cpros   WITH TratarNulo(cursor_4c_OpiLocal.Cpros, ""), ;
                    CodCors WITH TratarNulo(cursor_4c_OpiLocal.CodCors, ""), ;
                    CodTams WITH TratarNulo(cursor_4c_OpiLocal.CodTams, ""), ;
                    Empds   WITH TratarNulo(cursor_4c_OpiLocal.Empds, ""), ;
                    Dpros   WITH LEFT(TratarNulo(cursor_4c_OpiLocal.Dpros, ""), 40), ;
                    Notas   WITH TratarNulo(cursor_4c_OpiLocal.Notas, ""), ;
                    Contas  WITH loc_cConta, ;
                    Citens  WITH TratarNulo(cursor_4c_OpiLocal.Citens, 0), ;
                    Pesos   WITH TratarNulo(cursor_4c_OpiLocal.Pesos, 0)

            *-- O legado tem aqui um "Replace SeqDivs with _citem" no CURSOR
            *-- LOCAL (LocalOpi) que e codigo MORTO: Grupo_Salva.Click
            *-- reconsulta o mesmo alias com outra query
            *-- ("Select Nops From SigOpPic Where Numps = ?Numop") antes que
            *-- alguem leia SeqDivs dele. A sequencia fica gravada onde e de
            *-- fato lida: no servidor (UPDATE acima) e na coluna SeqDivs do
            *-- cursor da grade.
            SELECT cursor_4c_OpiLocal

            loc_nCitem = loc_nCitem + 1
        ENDSCAN

        *----------------------------------------------------------------------
        * 7. Insumos da nota de entrada (SigCdNei) do grupo mais recente
        *----------------------------------------------------------------------
        IF !THIS.CarregarInsumosOp(loc_nNop, par_cCursorInsumos)
            RETURN -1
        ENDIF

        SELECT (par_cCursorDivisoes)
        GO TOP

        RETURN 1
    ENDFUNC

    *==========================================================================
    * CarregarInsumosOp - Carrega no cursor de insumos (xNensi do legado) as
    * linhas de SigCdNei do grupo (EmpDnPs) que o legado escolhe:
    *
    *   lcQuery = [Select a.*, b.Datas, c.SepPedras, c.GrComps
    *              From SigCdNei a, SigCdNec b, SigCdOpd c
    *              Where a.Nops = ?pNop And a.Empdnps = b.EmpDnps
    *                And a.Dopps = c.Dopps Order by b.Datas Desc, b.EmpDnPs Desc]
    *   Scan / If (Not InList(SepPedras,1,3)) And (GrComps = 1) / Exit / EndScan
    *   _Chave = EmpDnPs / Scan While EmpDnPs = _Chave -> xNensi
    *
    * O grupo escolhido e o PRIMEIRO (mais recente, pela ordenacao) cuja
    * operacao NAO separa pedras e agrupa componentes. Nao havendo nenhum, o
    * legado chega ao fim do cursor e o grupo fica VAZIO - comportamento
    * reproduzido aqui.
    *
    * PROTECTED: so ExecutarCargaDivisoes chama.
    * Retorno: .T. executou (mesmo com grupo vazio) | .F. falha de SQL
    *==========================================================================
    PROTECTED FUNCTION CarregarInsumosOp(par_nNop, par_cCursorInsumos)
        LOCAL loc_cSQL, loc_cChave, loc_lAchou, loc_cSafety, loc_lSucesso

        loc_lSucesso = .F.

        loc_cSQL = "SELECT a.*, b.Datas, c.SepPedras, c.GrComps" + ;
                   " FROM SigCdNei a, SigCdNec b, SigCdOpd c" + ;
                   " WHERE a.Nops = " + FormatarNumeroSQL(par_nNop, 0) + ;
                   "   AND a.EmpDnPs = b.EmpDnPs" + ;
                   "   AND a.Dopps = c.Dopps" + ;
                   " ORDER BY b.Datas DESC, b.EmpDnPs DESC"

        IF THIS.ExecutarConsulta(loc_cSQL, "cursor_4c_NensiLocal") < 0
            THIS.this_cMensagemErro = THIS.MensagemReinicializar("SigCdNei")
        ELSE
            *-- ZAP preserva estrutura e binding do alias (fechar e recriar
            *-- derrubaria quem estiver ligado a ele). SET SAFETY e escopado
            *-- por data session e vale ON na sessao privada do form, onde ZAP
            *-- abriria dialogo modal e congelaria a tela - por isso o guard.
            loc_cSafety = SET("SAFETY")
            SET SAFETY OFF
            SELECT (par_cCursorInsumos)
            ZAP
            IF loc_cSafety = "ON"
                SET SAFETY ON
            ENDIF

            loc_lAchou = .F.
            SELECT cursor_4c_NensiLocal
            GO TOP
            SCAN
                IF !INLIST(TratarNulo(cursor_4c_NensiLocal.SepPedras, 0), 1, 3) AND ;
                   TratarNulo(cursor_4c_NensiLocal.GrComps, 0) = 1
                    loc_lAchou = .T.
                    EXIT
                ENDIF
            ENDSCAN

            IF loc_lAchou
                loc_cChave = TratarNulo(cursor_4c_NensiLocal.EmpDnPs, "")
                SCAN WHILE TratarNulo(cursor_4c_NensiLocal.EmpDnPs, "") == loc_cChave
                    *-- SCATTER/GATHER MEMVAR e o equivalente VFP do
                    *-- "Scatter to Memvar / Append from array Memvar" legado:
                    *-- casa por NOME, entao as 3 colunas extras do JOIN
                    *-- (Datas/SepPedras/GrComps) sao ignoradas, igual ao
                    *-- xNensi, que tem so as colunas de SigCdNei.
                    SCATTER MEMVAR MEMO
                    SELECT (par_cCursorInsumos)
                    APPEND BLANK
                    GATHER MEMVAR MEMO
                    SELECT cursor_4c_NensiLocal
                ENDSCAN
            ENDIF

            loc_lSucesso = .T.
        ENDIF

        RETURN loc_lSucesso
    ENDFUNC

    *==========================================================================
    * LimparCursoresTrabalho - Fecha os cursores auxiliares abertos pela carga
    * (os de trabalho do BO, nunca os cursores das grades do form). Chamado
    * pelo Destroy do form para nao deixar alias orfao na data session.
    *==========================================================================
    PROCEDURE LimparCursoresTrabalho()
        THIS.FecharCursor("cursor_4c_OpdDest")
        THIS.FecharCursor("cursor_4c_MfasEnv")
        THIS.FecharCursor("cursor_4c_OpiBusca")
        THIS.FecharCursor("cursor_4c_NecBusca")
        THIS.FecharCursor("cursor_4c_MfasLocal")
        THIS.FecharCursor("cursor_4c_GcrBusca")
        THIS.FecharCursor("cursor_4c_OpiLocal")
        THIS.FecharCursor("cursor_4c_ContaBusca")
        THIS.FecharCursor("cursor_4c_NensiLocal")
    ENDPROC

    *==========================================================================
    * FecharCursor - Fecha um alias de trabalho, guardando o TABLEREVERT pelo
    * BUFFERING (TABLEREVERT sem buffering dispara erro 1586 - cursor de
    * SQLEXEC nasce com Buffering 1).
    *==========================================================================
    PROTECTED PROCEDURE FecharCursor(par_cAlias)
        IF USED(par_cAlias)
            IF CURSORGETPROP("Buffering", par_cAlias) > 1
                TABLEREVERT(.T., par_cAlias)
            ENDIF
            USE IN (par_cAlias)
        ENDIF
    ENDPROC
ENDDEFINE

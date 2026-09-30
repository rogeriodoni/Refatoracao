*============================================================================
* SigPrGlpBO.prg - Business Object para Previa da Globalizacao (SIGPRGLP)
*
* Form OPERACIONAL (SIGPRGLP / FormSigPrGlp): tela de PREVIA/CONFIRMACAO
* do processamento disparado pelo SigPrGlo (Processamento de O.P.) ou pela
* Reserva Automatica - recebe do chamador (via Init legado com LParameters
* _ParentForm, _Data, _ReservaAuto, pCnx, _nGerEmphPdr, _autom, _numeroOp)
* os cursores temporarios ja calculados (TmpFinal/TmpDisp/TmpSaldo/TmpSaldG/
* TmpLinha/SelPedra) e, ao confirmar (botao Processar), efetiva a geracao
* das Ordens de Producao gravando em SigOpPic/SigPdMvf/SigCdNec/SigMvCab/
* SigMvHst/SigBxEst/SigMvItn/SigMvIts/SigCdNei.
*
* Herda de: BusinessBase
* Criado em: Fase 1 - Propriedades e Init
* Completado em: Fase 2 - Metodos de carga/processamento (Processar/CarregarDoCursor)
*============================================================================

DEFINE CLASS SigPrGlpBO AS BusinessBase

    *==========================================================================
    * Flags/parametros de modo - equivalem aos parametros recebidos no Init
    * do form legado (LParameters _ParentForm, _Data, _ReservaAuto, pCnx,
    * _nGerEmphPdr, _autom, _numeroOp)
    *==========================================================================
    this_lReserva      = .F.        && _ReservaAuto - .T. = "Previa da Reserva Automatica"
    this_nEmphPdr      = 0          && _nGerEmphPdr - empresa padrao de geracao (ThisForm.Emphpdr)
    this_lAutomatico   = .F.        && _autom - processamento automatico (sem interacao)
    this_nNumeroDaOp   = 0          && _numeroOp - numero da O.P. manual (ThisForm.Numerodaop)
    this_cSigKey       = SPACE(3)   && CrSigCdPac.sigKeys - chave de sistema (ThisForm.SigKey)

    *==========================================================================
    * Parametros do sistema (SigCdPam), referenciados ao longo do
    * processamento (Processar/validacoes) - equivalente ao cursor
    * crSigCdPam do Init legado, aqui recarregado para o BO nao depender
    * do form SigPrGlo que o chamou
    *==========================================================================
    this_cPamDopEmphs   = SPACE(20)  && SigCdPam.dopemphs
    this_cPamDopReqcs   = SPACE(20)  && SigCdPam.dopreqcs
    this_cPamDopPedcs   = SPACE(20)  && SigCdPam.doppedcs
    this_cPamDopComps   = SPACE(20)  && SigCdPam.dopcomps
    this_cPamTransfRes  = SPACE(20)  && SigCdPam.transfres
    this_cPamDoppPads   = SPACE(20)  && SigCdPam.dopppads
    this_cPamDopTrfCps  = SPACE(20)  && SigCdPam.doptrfcps
    this_cPamGruReservs = SPACE(10)  && SigCdPam.grureservs
    this_cPamConReservs = SPACE(10)  && SigCdPam.conreservs
    this_nPamAgrupEmph  = 0          && SigCdPam.agrupemph
    this_cPamOuros      = SPACE(14)  && SigCdPam.ouros
    this_cPamTpOpEntAus = SPACE(15)  && SigCdPam.tpopentaus
    this_cPamDopEntAus  = SPACE(20)  && SigCdPam.dopentaus
    this_nPamAutComps   = 0          && SigCdPam.autcomps
    this_nPamGlobAutos  = 0          && SigCdPam.globautos
    this_cPamGruConfs   = SPACE(10)  && SigCdPam.gruconfs
    this_cPamConConfs   = SPACE(10)  && SigCdPam.conconfs

    *==========================================================================
    * Parametros de configuracao (SigCdPac) lidos pelo Processar
    *==========================================================================
    this_cPacOpPdCompra = SPACE(20)  && SigCdPac.oppdcompra - operacao de pedido de compra de acabado
    this_nPacOpZers     = 0          && SigCdPac.opzers
    this_nPacAgrupReqs  = 0          && SigCdPac.agrupreqs - 1 = agrupa requisicao por fornecedor + prazo

    *==========================================================================
    * DbParam - o legado monta um cursor "DBParam" de UMA linha no Click do
    * SigPrGlo (grandparent) e o SIGPRGLP le tres colunas dele:
    *   CodTgOps = _lcTpGOp (tipo de geracao da OP escolhido no Container1)
    *   OpZers   = Iif(GerPorTp, CrTmpTpGop.OpZers, CrSigCdPac.OpZers)
    *   EntPes   = Iif(GerPorTp, CrTmpTpGop.EntPes, 0)
    * (CrTmpTpGop = SigInTgo filtrado pelo tipo escolhido.)
    * O cursor nao foi portado (SigPrGloBO registra "DBParam criado, nunca
    * lido"), entao as tres colunas viram properties deste BO, resolvidas em
    * CarregarDbParam() a partir do tipo de geracao / GerPorTp que o FORM le
    * do grandparent (FormSigPrGlo), exatamente como o legado fazia.
    *==========================================================================
    this_cTipoGeracaoOP = SPACE(10)  && _lcTpGOp (grandparent SigPrGloBO.this_cTipoGeracaoOP)
    this_lGerPorTp      = .F.        && ThisForm.GerPorTp do grandparent
    this_cDbCodTgOps    = SPACE(10)  && DBParam.CodTgOps
    this_nDbOpZers      = 0          && DBParam.OpZers
    this_nDbEntPes      = 0          && DBParam.EntPes

    *==========================================================================
    * Previsao de entrega / data de geracao - no legado vem de
    * ThisForm.ParentForm.ParentForm.Cnt_Previsao.GetPrevisao/GetGeracao
    * (FormSigPrGlo.cnt_4c_Previsao.txt_4c_Previsao/txt_4c_Geracao). O FORM
    * repassa para ca antes de chamar Processar().
    *==========================================================================
    this_dPrevisao      = {}         && _Prev
    this_dDataGeracao   = {}         && _DtGera

    *==========================================================================
    * Resultado do processamento
    *==========================================================================
    this_cMensagemErro   = ""        && ultima mensagem de erro (o form espelha)
    this_nNumeroOpGerada = 0         && _Nump - numero da OP efetivada por Processar()

    *==========================================================================
    * Colunas da O.P. gerada (SigOpPic) - this_cTabela/this_cCampoChave
    * definidos no Init - registro efetivado por THIS.Processar() (Fase 2)
    *==========================================================================
    this_dOpDataEs      = {}         && dataes
    this_dOpDataPs      = {}         && dataps
    this_cOpDopes       = SPACE(20)  && dopes
    this_cOpDopps       = SPACE(20)  && dopps
    this_cOpEmps        = SPACE(3)   && emps
    this_nOpNops        = 0          && nops
    this_nOpNumes       = 0          && numes
    this_nOpNumps       = 0          && numps
    this_cOpObss        = ""         && obss (memo)
    this_nOpQtds        = 0          && qtds
    this_dOpDataTrans   = {}         && datatrans
    this_cOpLocals      = SPACE(10)  && locals
    this_nOpNtrans      = 0          && ntrans
    this_cOpCpros       = SPACE(14)  && cpros
    this_cOpEmpds       = SPACE(3)   && empds
    this_dOpDtGeras     = {}         && dtgeras
    this_nOpSeqDivs     = 0          && seqdivs
    this_cOpCodCors     = SPACE(4)   && codcors
    this_cOpCodTams     = SPACE(4)   && codtams
    this_lOpDivs        = .F.        && divs (bit)
    this_lOpImprs       = .F.        && imprs (bit)
    this_cOpUsuars      = SPACE(10)  && usuars
    this_nOpNopMaes     = 0          && nopmaes
    this_nOpPesos       = 0          && pesos
    this_cOpCidChaves   = SPACE(20)  && cidchaves (PK)
    this_nOpCodBarras   = 0          && codbarras
    this_nOpQtdCpnts    = 0          && qtdcpnts
    this_nOpQtdTubos    = 0          && qtdtubos
    this_lOpIImprs      = .F.        && iimprs (bit)
    this_cOpMoedas      = SPACE(3)   && moedas
    this_nOpUnits       = 0          && units
    this_dOpDtFunds     = {}         && dtfunds
    this_nOpNFunds      = 0          && nfunds
    this_cOpDpros       = SPACE(65)  && dpros
    this_cOpEmpDNps     = SPACE(33)  && empdnps
    this_cOpEmpDopNops  = SPACE(33)  && empdopnops
    this_cOpEmpDopNums  = SPACE(29)  && empdopnums
    this_cOpNotas       = SPACE(6)   && notas
    this_cOpCodTGops    = SPACE(10)  && codtgops
    this_nOpCitens      = 0          && citens

    *--------------------------------------------------------------------------
    * Init - Inicializa o Business Object configurando a tabela/chave de
    * referencia (SigOpPic/cidchaves - registro efetivado pelo botao
    * Processar do form legado) e carrega os parametros do sistema
    * (SigCdPam) usados na validacao/processamento
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        LOCAL loc_lResultado, loc_oErro
        loc_lResultado = .F.

        TRY
            DODEFAULT()
            THIS.this_cTabela     = "SigOpPic"
            THIS.this_cCampoChave = "cidchaves"

            IF TYPE("gnConnHandle") = "N" AND gnConnHandle > 0

                IF USED("cursor_4c_SigCdPam")
                    USE IN cursor_4c_SigCdPam
                ENDIF
                SQLEXEC(gnConnHandle, ;
                    "SELECT dopemphs, dopreqcs, doppedcs, dopcomps, transfres, " + ;
                    "dopppads, doptrfcps, grureservs, conreservs, agrupemph, " + ;
                    "ouros, tpopentaus, dopentaus, autcomps " + ;
                    "FROM SigCdPam", ;
                    "cursor_4c_SigCdPam")

                IF USED("cursor_4c_SigCdPam") AND !EOF("cursor_4c_SigCdPam")
                    THIS.this_cPamDopEmphs   = PADR(TratarNulo(cursor_4c_SigCdPam.dopemphs, ""), 20)
                    THIS.this_cPamDopReqcs   = PADR(TratarNulo(cursor_4c_SigCdPam.dopreqcs, ""), 20)
                    THIS.this_cPamDopPedcs   = PADR(TratarNulo(cursor_4c_SigCdPam.doppedcs, ""), 20)
                    THIS.this_cPamDopComps   = PADR(TratarNulo(cursor_4c_SigCdPam.dopcomps, ""), 20)
                    THIS.this_cPamTransfRes  = PADR(TratarNulo(cursor_4c_SigCdPam.transfres, ""), 20)
                    THIS.this_cPamDoppPads   = PADR(TratarNulo(cursor_4c_SigCdPam.dopppads, ""), 20)
                    THIS.this_cPamDopTrfCps  = PADR(TratarNulo(cursor_4c_SigCdPam.doptrfcps, ""), 20)
                    THIS.this_cPamGruReservs = PADR(TratarNulo(cursor_4c_SigCdPam.grureservs, ""), 10)
                    THIS.this_cPamConReservs = PADR(TratarNulo(cursor_4c_SigCdPam.conreservs, ""), 10)
                    THIS.this_nPamAgrupEmph  = TratarNulo(cursor_4c_SigCdPam.agrupemph, 0)
                    THIS.this_cPamOuros      = PADR(TratarNulo(cursor_4c_SigCdPam.ouros, ""), 14)
                    THIS.this_cPamTpOpEntAus = PADR(TratarNulo(cursor_4c_SigCdPam.tpopentaus, ""), 15)
                    THIS.this_cPamDopEntAus  = PADR(TratarNulo(cursor_4c_SigCdPam.dopentaus, ""), 20)
                    THIS.this_nPamAutComps   = TratarNulo(cursor_4c_SigCdPam.autcomps, 0)
                ENDIF
                IF USED("cursor_4c_SigCdPam")
                    USE IN cursor_4c_SigCdPam
                ENDIF

            ENDIF

            loc_lResultado = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Retorna a chave primaria (SigOpPic.cidchaves) do
    * registro corrente, usada por RegistrarAuditoria()
    *--------------------------------------------------------------------------
    FUNCTION ObterChavePrimaria()
        RETURN ALLTRIM(THIS.this_cOpCidChaves)
    ENDFUNC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Carrega as properties this_* (registro de SigOpPic
    * efetivado por THIS.Processar()) a partir do cursor informado.
    * REGRA CRITICA: SELECT (par_cAliasCursor) ANTES de acessar campos
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        TRY
            IF USED(par_cAliasCursor)
                SELECT (par_cAliasCursor)

                THIS.this_dOpDataEs     = TratarNulo(dataes,     {})
                THIS.this_dOpDataPs     = TratarNulo(dataps,     {})
                THIS.this_cOpDopes      = TratarNulo(dopes,      SPACE(20))
                THIS.this_cOpDopps      = TratarNulo(dopps,      SPACE(20))
                THIS.this_cOpEmps       = TratarNulo(emps,       SPACE(3))
                THIS.this_nOpNops       = TratarNulo(nops,       0)
                THIS.this_nOpNumes      = TratarNulo(numes,      0)
                THIS.this_nOpNumps      = TratarNulo(numps,      0)
                THIS.this_cOpObss       = TratarNulo(obss,       "")
                THIS.this_nOpQtds       = TratarNulo(qtds,       0)
                THIS.this_dOpDataTrans  = TratarNulo(datatrans,  {})
                THIS.this_cOpLocals     = TratarNulo(locals,     SPACE(10))
                THIS.this_nOpNtrans     = TratarNulo(ntrans,     0)
                THIS.this_cOpCpros      = TratarNulo(cpros,      SPACE(14))
                THIS.this_cOpEmpds      = TratarNulo(empds,      SPACE(3))
                THIS.this_dOpDtGeras    = TratarNulo(dtgeras,    {})
                THIS.this_nOpSeqDivs    = TratarNulo(seqdivs,    0)
                THIS.this_cOpCodCors    = TratarNulo(codcors,    SPACE(4))
                THIS.this_cOpCodTams    = TratarNulo(codtams,    SPACE(4))
                THIS.this_lOpDivs       = TratarNulo(divs,       .F.)
                THIS.this_lOpImprs      = TratarNulo(imprs,      .F.)
                THIS.this_cOpUsuars     = TratarNulo(usuars,     SPACE(10))
                THIS.this_nOpNopMaes    = TratarNulo(nopmaes,    0)
                THIS.this_nOpPesos      = TratarNulo(pesos,      0)
                THIS.this_cOpCidChaves  = TratarNulo(cidchaves,  SPACE(20))
                THIS.this_nOpCodBarras  = TratarNulo(codbarras,  0)
                THIS.this_nOpQtdCpnts   = TratarNulo(qtdcpnts,   0)
                THIS.this_nOpQtdTubos   = TratarNulo(qtdtubos,   0)
                THIS.this_lOpIImprs     = TratarNulo(iimprs,     .F.)
                THIS.this_cOpMoedas     = TratarNulo(moedas,     SPACE(3))
                THIS.this_nOpUnits      = TratarNulo(units,      0)
                THIS.this_dOpDtFunds    = TratarNulo(dtfunds,    {})
                THIS.this_nOpNFunds     = TratarNulo(nfunds,     0)
                THIS.this_cOpDpros      = TratarNulo(dpros,      SPACE(65))
                THIS.this_cOpEmpDNps    = TratarNulo(empdnps,    SPACE(33))
                THIS.this_cOpEmpDopNops = TratarNulo(empdopnops, SPACE(33))
                THIS.this_cOpEmpDopNums = TratarNulo(empdopnums, SPACE(29))
                THIS.this_cOpNotas      = TratarNulo(notas,      SPACE(6))
                THIS.this_cOpCodTGops   = TratarNulo(codtgops,   SPACE(10))
                THIS.this_nOpCitens     = TratarNulo(citens,     0)

                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MostrarErro("Erro ao carregar do cursor:" + CHR(13) + loc_oErro.Message, "SigPrGlpBO.CarregarDoCursor")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir - Efetiva a O.P. gravando o registro em SigOpPic
    * (cidchaves eh a PK Fortyus - nunca gravar vazia, senao o proximo
    * registro colide no indice unico sigoppic_cidchaves)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Inserir()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        TRY
            IF EMPTY(ALLTRIM(THIS.this_cOpCidChaves))
                THIS.this_cOpCidChaves = PADR(fUniqueIds(), 20)
            ENDIF

            TEXT TO loc_cSQL TEXTMERGE NOSHOW
                INSERT INTO SigOpPic (dataes, dataps, dopes, dopps, emps, nops, numes, numps,
                    obss, qtds, datatrans, locals, ntrans, cpros, empds, dtgeras, seqdivs,
                    codcors, codtams, divs, imprs, usuars, nopmaes, pesos, cidchaves,
                    codbarras, qtdcpnts, qtdtubos, iimprs, moedas, units, dtfunds, nfunds,
                    dpros, empdnps, empdopnops, empdopnums, notas, codtgops, citens)
                VALUES (
                    <<FormatarDataSQL(THIS.this_dOpDataEs)>>,
                    <<FormatarDataSQL(THIS.this_dOpDataPs)>>,
                    <<EscaparSQL(LEFT(ALLTRIM(THIS.this_cOpDopes), 20))>>,
                    <<EscaparSQL(LEFT(ALLTRIM(THIS.this_cOpDopps), 20))>>,
                    <<EscaparSQL(LEFT(ALLTRIM(THIS.this_cOpEmps), 3))>>,
                    <<FormatarNumeroSQL(THIS.this_nOpNops, 0)>>,
                    <<FormatarNumeroSQL(THIS.this_nOpNumes, 0)>>,
                    <<FormatarNumeroSQL(THIS.this_nOpNumps, 0)>>,
                    <<EscaparSQL(THIS.this_cOpObss)>>,
                    <<FormatarNumeroSQL(THIS.this_nOpQtds, 3)>>,
                    <<FormatarDataSQL(THIS.this_dOpDataTrans)>>,
                    <<EscaparSQL(LEFT(ALLTRIM(THIS.this_cOpLocals), 10))>>,
                    <<FormatarNumeroSQL(THIS.this_nOpNtrans, 0)>>,
                    <<EscaparSQL(LEFT(ALLTRIM(THIS.this_cOpCpros), 14))>>,
                    <<EscaparSQL(LEFT(ALLTRIM(THIS.this_cOpEmpds), 3))>>,
                    <<FormatarDataSQL(THIS.this_dOpDtGeras)>>,
                    <<FormatarNumeroSQL(THIS.this_nOpSeqDivs, 0)>>,
                    <<EscaparSQL(LEFT(ALLTRIM(THIS.this_cOpCodCors), 4))>>,
                    <<EscaparSQL(LEFT(ALLTRIM(THIS.this_cOpCodTams), 4))>>,
                    <<FormatarNumeroSQL(IIF(THIS.this_lOpDivs, 1, 0), 0)>>,
                    <<FormatarNumeroSQL(IIF(THIS.this_lOpImprs, 1, 0), 0)>>,
                    <<EscaparSQL(LEFT(ALLTRIM(THIS.this_cOpUsuars), 10))>>,
                    <<FormatarNumeroSQL(THIS.this_nOpNopMaes, 0)>>,
                    <<FormatarNumeroSQL(THIS.this_nOpPesos, 3)>>,
                    <<EscaparSQL(PADR(THIS.this_cOpCidChaves, 20))>>,
                    <<FormatarNumeroSQL(THIS.this_nOpCodBarras, 0)>>,
                    <<FormatarNumeroSQL(THIS.this_nOpQtdCpnts, 0)>>,
                    <<FormatarNumeroSQL(THIS.this_nOpQtdTubos, 3)>>,
                    <<FormatarNumeroSQL(IIF(THIS.this_lOpIImprs, 1, 0), 0)>>,
                    <<EscaparSQL(LEFT(ALLTRIM(THIS.this_cOpMoedas), 3))>>,
                    <<FormatarNumeroSQL(THIS.this_nOpUnits, 6)>>,
                    <<FormatarDataSQL(THIS.this_dOpDtFunds)>>,
                    <<FormatarNumeroSQL(THIS.this_nOpNFunds, 0)>>,
                    <<EscaparSQL(LEFT(ALLTRIM(THIS.this_cOpDpros), 65))>>,
                    <<EscaparSQL(PADR(THIS.this_cOpEmpDNps, 33))>>,
                    <<EscaparSQL(PADR(THIS.this_cOpEmpDopNops, 33))>>,
                    <<EscaparSQL(PADR(THIS.this_cOpEmpDopNums, 29))>>,
                    <<EscaparSQL(LEFT(ALLTRIM(THIS.this_cOpNotas), 6))>>,
                    <<EscaparSQL(LEFT(ALLTRIM(THIS.this_cOpCodTGops), 10))>>,
                    <<FormatarNumeroSQL(THIS.this_nOpCitens, 0)>>
                )
            ENDTEXT

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("INSERT")
                loc_lSucesso = .T.
            ELSE
                MostrarErro("Erro ao inserir registro em SigOpPic:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loc_oErro
            MostrarErro("Erro ao inserir:" + CHR(13) + loc_oErro.Message, "SigPrGlpBO.Inserir")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - Atualiza o registro de SigOpPic identificado por cidchaves
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Atualizar()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        TRY
            TEXT TO loc_cSQL TEXTMERGE NOSHOW
                UPDATE SigOpPic
                SET dataes     = <<FormatarDataSQL(THIS.this_dOpDataEs)>>,
                    dataps     = <<FormatarDataSQL(THIS.this_dOpDataPs)>>,
                    dopes      = <<EscaparSQL(LEFT(ALLTRIM(THIS.this_cOpDopes), 20))>>,
                    dopps      = <<EscaparSQL(LEFT(ALLTRIM(THIS.this_cOpDopps), 20))>>,
                    emps       = <<EscaparSQL(LEFT(ALLTRIM(THIS.this_cOpEmps), 3))>>,
                    nops       = <<FormatarNumeroSQL(THIS.this_nOpNops, 0)>>,
                    numes      = <<FormatarNumeroSQL(THIS.this_nOpNumes, 0)>>,
                    numps      = <<FormatarNumeroSQL(THIS.this_nOpNumps, 0)>>,
                    obss       = <<EscaparSQL(THIS.this_cOpObss)>>,
                    qtds       = <<FormatarNumeroSQL(THIS.this_nOpQtds, 3)>>,
                    datatrans  = <<FormatarDataSQL(THIS.this_dOpDataTrans)>>,
                    locals     = <<EscaparSQL(LEFT(ALLTRIM(THIS.this_cOpLocals), 10))>>,
                    ntrans     = <<FormatarNumeroSQL(THIS.this_nOpNtrans, 0)>>,
                    cpros      = <<EscaparSQL(LEFT(ALLTRIM(THIS.this_cOpCpros), 14))>>,
                    empds      = <<EscaparSQL(LEFT(ALLTRIM(THIS.this_cOpEmpds), 3))>>,
                    dtgeras    = <<FormatarDataSQL(THIS.this_dOpDtGeras)>>,
                    seqdivs    = <<FormatarNumeroSQL(THIS.this_nOpSeqDivs, 0)>>,
                    codcors    = <<EscaparSQL(LEFT(ALLTRIM(THIS.this_cOpCodCors), 4))>>,
                    codtams    = <<EscaparSQL(LEFT(ALLTRIM(THIS.this_cOpCodTams), 4))>>,
                    divs       = <<FormatarNumeroSQL(IIF(THIS.this_lOpDivs, 1, 0), 0)>>,
                    imprs      = <<FormatarNumeroSQL(IIF(THIS.this_lOpImprs, 1, 0), 0)>>,
                    usuars     = <<EscaparSQL(LEFT(ALLTRIM(THIS.this_cOpUsuars), 10))>>,
                    nopmaes    = <<FormatarNumeroSQL(THIS.this_nOpNopMaes, 0)>>,
                    pesos      = <<FormatarNumeroSQL(THIS.this_nOpPesos, 3)>>,
                    codbarras  = <<FormatarNumeroSQL(THIS.this_nOpCodBarras, 0)>>,
                    qtdcpnts   = <<FormatarNumeroSQL(THIS.this_nOpQtdCpnts, 0)>>,
                    qtdtubos   = <<FormatarNumeroSQL(THIS.this_nOpQtdTubos, 3)>>,
                    iimprs     = <<FormatarNumeroSQL(IIF(THIS.this_lOpIImprs, 1, 0), 0)>>,
                    moedas     = <<EscaparSQL(LEFT(ALLTRIM(THIS.this_cOpMoedas), 3))>>,
                    units      = <<FormatarNumeroSQL(THIS.this_nOpUnits, 6)>>,
                    dtfunds    = <<FormatarDataSQL(THIS.this_dOpDtFunds)>>,
                    nfunds     = <<FormatarNumeroSQL(THIS.this_nOpNFunds, 0)>>,
                    dpros      = <<EscaparSQL(LEFT(ALLTRIM(THIS.this_cOpDpros), 65))>>,
                    empdnps    = <<EscaparSQL(PADR(THIS.this_cOpEmpDNps, 33))>>,
                    empdopnops = <<EscaparSQL(PADR(THIS.this_cOpEmpDopNops, 33))>>,
                    empdopnums = <<EscaparSQL(PADR(THIS.this_cOpEmpDopNums, 29))>>,
                    notas      = <<EscaparSQL(LEFT(ALLTRIM(THIS.this_cOpNotas), 6))>>,
                    codtgops   = <<EscaparSQL(LEFT(ALLTRIM(THIS.this_cOpCodTGops), 10))>>,
                    citens     = <<FormatarNumeroSQL(THIS.this_nOpCitens, 0)>>
                WHERE cidchaves = <<EscaparSQL(ALLTRIM(THIS.this_cOpCidChaves))>>
            ENDTEXT

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("UPDATE")
                loc_lSucesso = .T.
            ELSE
                MostrarErro("Erro ao atualizar registro em SigOpPic:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loc_oErro
            MostrarErro("Erro ao atualizar:" + CHR(13) + loc_oErro.Message, "SigPrGlpBO.Atualizar")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * FASE 8 - PROCESSAMENTO (Processar / AtualizaPeso / GravaHis)
    *
    * Transcricao do Click do botao Processar do form legado
    * (SIGPRGLP.Processar.Click, tasks\task617\SigPrGlp_form_codigo_fonte.txt
    * linhas 4255-5893) e dos dois metodos auxiliares que ele usa
    * (SIGPRGLP.atualizapeso, linhas 2736-2773, e SIGPRGLP.gravahis, linhas
    * 2778-2843).
    *
    * EQUIVALENCIAS LEGADO -> MIGRADO (fixadas nesta fase):
    *   ThisForm.poDataMgr.SqlExecute(q, c)  -> THIS.ExecutarSQL(q, c, rotulo)
    *   ThisForm.poDataMgr.CursorQuery(...)  -> THIS.ConsultarTabela(...)
    *   ThisForm.poDataMgr.Update('crXxx')   -> THIS.PersistirCursor('crXxx', 'Xxx')
    *   ThisForm.poDataMgr.Commit()/RollBack -> SQLCOMMIT()/SQLROLLBACK()
    *   _Empr                                -> go_4c_Sistema.cCodEmpresa
    *   Usuar                                -> gc_4c_UsuarioLogado
    *   ThisForm.Sigkey                      -> THIS.this_cSigKey
    *   DbParam.<col>                        -> THIS.this_cDbCodTgOps /
    *                                           this_nDbOpZers / this_nDbEntPes
    *   MessageBox(...) + Return 0           -> THIS.this_cMensagemErro + aborto
    *
    * REGRA #1 (CLAUDE.md): nenhum RETURN dentro de TRY/CATCH. Todos os
    * "Return 0" do legado viram a bandeira PRIVATE loc_lAbortar, propagada
    * por EXIT em cascata nos SCAN/DO WHILE aninhados e testada com
    * IF !loc_lAbortar nos blocos seguintes - mesmo idioma de
    * SigPrGloBO.Processar().
    *
    * ESTADO COMPARTILHADO: o Click legado eh um procedimento UNICO com
    * variaveis Private/Local visiveis do inicio ao fim (_Nump, _Dope, _Nume,
    * _Citens, _TProd, _TPeso, ...). Aqui ele foi quebrado em metodos por
    * bloco para nao estourar o limite de codigo por procedimento do VFP9, e
    * essas variaveis sao declaradas PRIVATE em Processar() - continuam
    * visiveis nos metodos chamados, exatamente como no legado. NAO trocar
    * por LOCAL: os metodos de bloco deixariam de enxerga-las.
    *==========================================================================

    *--------------------------------------------------------------------------
    * ExecutarSQL - Substitui ThisForm.poDataMgr.SqlExecute(lcQuery, cursor).
    *
    * O legado testa "< 1" e aborta; aqui vale a convencao ja adotada no resto
    * do projeto (FormSigPrGlp.BtnConfirmarDispProdutoClick, linhas 3181/3393/
    * 3424): so "< 0" eh FALHA DE SQL. Zero linhas eh resultado legitimo e
    * segue o fluxo - o legado abortava tambem com zero linhas porque o
    * SqlExecute do Fortyus devolvia o numero de linhas, e varias dessas
    * consultas retornam zero por natureza (ex.: TmpOpi conferindo se o numero
    * da O.P. ja existe, que SO pode prosseguir com zero linhas).
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION ExecutarSQL(par_cSQL, par_cCursor, par_cRotulo)
        LOCAL loc_nRet, loc_lOk, loc_cAliasAnt

        *-- O SqlExecute do Fortyus PRESERVA a area de trabalho selecionada:
        *-- o legado chama SqlExecute DENTRO de SCAN (ex.: dump 5139, no SCAN
        *-- de TmpPedra) sem reselecionar depois, e o ENDSCAN continua no
        *-- cursor certo. SQLEXEC(), ao contrario, SELECIONA o cursor de
        *-- resultado. Sem salvar/restaurar aqui, o SKIP implicito do ENDSCAN
        *-- cairia no cursor errado - erro silencioso de varredura.
        loc_cAliasAnt = ALIAS()

        IF VARTYPE(par_cCursor) = "C" AND !EMPTY(par_cCursor)
            IF USED(par_cCursor)
                USE IN (par_cCursor)
            ENDIF
            loc_nRet = SQLEXEC(gnConnHandle, par_cSQL, par_cCursor)
        ELSE
            loc_nRet = SQLEXEC(gnConnHandle, par_cSQL)
        ENDIF

        IF !EMPTY(loc_cAliasAnt) AND USED(loc_cAliasAnt)
            SELECT (loc_cAliasAnt)
        ENDIF

        loc_lOk = (loc_nRet >= 0)

        IF !loc_lOk
            THIS.this_cMensagemErro = "Favor Reinicializar o Processo!!!" + CHR(13) + ;
                "(" + TRANSFORM(par_cRotulo) + ") " + CapturarErroSQL()
        ENDIF

        RETURN loc_lOk
    ENDFUNC

    *--------------------------------------------------------------------------
    * ConsultarTabela - Substitui ThisForm.poDataMgr.CursorQuery(tabela,
    * cursorDestino, campoChave, valorChave [, camposRetorno]), helper do
    * gerenciador de dados Fortyus que NAO existe no sistema migrado.
    *
    * Vira um SELECT simples. O cursor resultante fica ABERTO (o legado le
    * campos dele logo em seguida, e com zero linhas o VFP devolve o valor em
    * branco do campo, sem erro - comportamento identico ao do legado).
    * Somente-leitura: quem precisa de INSERT/INDEX usa AbrirCursorTabela().
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION ConsultarTabela(par_cTabela, par_cCursor, par_cCampoChave, ;
            par_uValorChave, par_cCampos)

        LOCAL loc_cCampos, loc_cValor, loc_nRet, loc_lOk, loc_cAliasAnt

        *-- Preserva a area de trabalho selecionada, como o CursorQuery do
        *-- Fortyus (o legado o chama DENTRO de SCAN - dump 5096, SCAN de
        *-- TmpEmpH - sem reselecionar depois). Ver nota em ExecutarSQL.
        loc_cAliasAnt = ALIAS()
        loc_cCampos = "*"
        IF VARTYPE(par_cCampos) = "C" AND !EMPTY(par_cCampos)
            loc_cCampos = par_cCampos
        ENDIF

        DO CASE
            CASE VARTYPE(par_uValorChave) = "N"
                loc_cValor = FormatarNumeroSQL(par_uValorChave, 0)
            CASE VARTYPE(par_uValorChave) = "D" OR VARTYPE(par_uValorChave) = "T"
                loc_cValor = FormatarDataSQL(par_uValorChave)
            OTHERWISE
                loc_cValor = EscaparSQL(ALLTRIM(TratarNulo(par_uValorChave, "")))
        ENDCASE

        IF USED(par_cCursor)
            USE IN (par_cCursor)
        ENDIF

        loc_nRet = SQLEXEC(gnConnHandle, ;
            "SELECT " + loc_cCampos + " FROM " + par_cTabela + ;
            " WHERE " + par_cCampoChave + " = " + loc_cValor, par_cCursor)

        IF !EMPTY(loc_cAliasAnt) AND USED(loc_cAliasAnt)
            SELECT (loc_cAliasAnt)
        ENDIF

        loc_lOk = (loc_nRet >= 0 AND USED(par_cCursor))

        IF !loc_lOk
            THIS.this_cMensagemErro = "Favor Reinicializar o Processo!!!" + CHR(13) + ;
                "(" + par_cTabela + ") " + CapturarErroSQL()
        ENDIF

        RETURN loc_lOk
    ENDFUNC

    *--------------------------------------------------------------------------
    * AbrirCursorTabela - Cria (ou recria VAZIO) um cursor READWRITE com a
    * estrutura COMPLETA da tabela informada.
    *
    * Equivale ao AddCursor('<tabela>', ...) do gerenciador Fortyus, que era
    * como os cursores crSigOpPic/crSigPdMvf/crSigCdNec/crSigCdNei/crSigMvCab/
    * crSigMvHst/crSigBxEst/crSigMvItn/crSigMvIts chegavam ao Click legado
    * ja com TODAS as colunas da tabela destino e em branco - por isso o
    * "Update('crXxx')" (TABLEUPDATE) do legado gravava o registro INTEIRO e
    * nunca esbarrava em coluna NOT NULL ausente.
    *
    * Reproduzir a estrutura completa (em vez de inferir a lista de campos
    * pelos Insert Into do legado) eh o que garante a regra #22 do CLAUDE.md:
    * toda coluna NOT NULL sem DEFAULT da tabela destino esta no cursor e,
    * portanto, no INSERT montado por PersistirCursor().
    *
    * Substitui o "Select <cursor> / Zap" do topo do Click legado por
    * USE IN + recriacao: ZAP em cursor de DataSession privada ja travou a
    * tela neste projeto (licao registrada na memoria do time), e o efeito
    * util - cursor vazio com a mesma estrutura - eh o mesmo.
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION AbrirCursorTabela(par_cCursor, par_cTabela)
        LOCAL loc_nRet, loc_lOk
        loc_lOk = .F.

        IF USED(par_cCursor)
            USE IN (par_cCursor)
        ENDIF
        IF USED("cursor_4c_Estrut")
            USE IN cursor_4c_Estrut
        ENDIF

        loc_nRet = SQLEXEC(gnConnHandle, ;
            "SELECT * FROM " + par_cTabela + " WHERE 1 = 0", "cursor_4c_Estrut")

        IF loc_nRet >= 0 AND USED("cursor_4c_Estrut")
            SELECT * FROM cursor_4c_Estrut WHERE .F. INTO CURSOR (par_cCursor) READWRITE
            USE IN cursor_4c_Estrut
            loc_lOk = USED(par_cCursor)
        ENDIF

        IF !loc_lOk
            THIS.this_cMensagemErro = "Favor Reinicializar o Processo!!!" + CHR(13) + ;
                "(estrutura de " + par_cTabela + ") " + CapturarErroSQL()
        ENDIF

        RETURN loc_lOk
    ENDFUNC

    *--------------------------------------------------------------------------
    * ValorSQLDeCampo - Formata UM campo do cursor para o VALUES do INSERT,
    * pelo TIPO VFP do campo (nunca por palpite de nome). Sempre pelos
    * helpers canonicos do projeto (regra #5 do CLAUDE.md), que ja devolvem
    * COM aspas.
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION ValorSQLDeCampo(par_cCursor, par_cCampo, par_cTipo, par_nDec)
        LOCAL loc_uValor, loc_cRet

        loc_uValor = EVALUATE(par_cCursor + "." + par_cCampo)

        DO CASE
            CASE par_cTipo $ "CMVQ"
                loc_cRet = EscaparSQL(TratarNulo(loc_uValor, ""))
            CASE par_cTipo $ "NFIBY"
                loc_cRet = FormatarNumeroSQL(TratarNulo(loc_uValor, 0), par_nDec)
            CASE par_cTipo = "L"
                loc_cRet = IIF(TratarNulo(loc_uValor, .F.), "1", "0")
            CASE par_cTipo $ "DT"
                loc_cRet = FormatarDataSQL(TratarNulo(loc_uValor, {}))
            OTHERWISE
                loc_cRet = "NULL"
        ENDCASE

        RETURN loc_cRet
    ENDFUNC

    *--------------------------------------------------------------------------
    * PersistirCursor - Substitui ThisForm.poDataMgr.Update('<cursor>') do
    * legado (TABLEUPDATE do cursor amarrado por AddCursor): grava em
    * <par_cTabela>, linha a linha, TODAS as colunas do cursor.
    *
    * Como AbrirCursorTabela() criou o cursor com a estrutura completa da
    * tabela, a lista de colunas do INSERT eh a lista de colunas da TABELA -
    * cobrindo por construcao toda coluna NOT NULL (regra #22), inclusive as
    * que nao aparecem em tela nem no dump do legado.
    *
    * Cursor inexistente ou vazio nao eh erro: o legado tambem chamava
    * Update() em cursor vazio (quando o ramo que o alimenta nao rodou) e
    * seguia adiante.
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION PersistirCursor(par_cCursor, par_cTabela)
        LOCAL loc_lOk, loc_nI, loc_nCampos, loc_cCols, loc_cVals, loc_cSQL, loc_nRet
        LOCAL ARRAY loc_aCampos[1, 18]

        loc_lOk = .T.

        IF !USED(par_cCursor) OR RECCOUNT(par_cCursor) = 0
            RETURN .T.
        ENDIF

        loc_nCampos = AFIELDS(loc_aCampos, par_cCursor)
        loc_cCols   = ""
        FOR loc_nI = 1 TO loc_nCampos
            loc_cCols = loc_cCols + IIF(loc_nI = 1, "", ", ") + ;
                LOWER(ALLTRIM(loc_aCampos[loc_nI, 1]))
        ENDFOR

        SELECT (par_cCursor)
        GO TOP
        SCAN
            loc_cVals = ""
            FOR loc_nI = 1 TO loc_nCampos
                loc_cVals = loc_cVals + IIF(loc_nI = 1, "", ", ") + ;
                    THIS.ValorSQLDeCampo(par_cCursor, ALLTRIM(loc_aCampos[loc_nI, 1]), ;
                        loc_aCampos[loc_nI, 2], loc_aCampos[loc_nI, 4])
            ENDFOR

            loc_cSQL = "INSERT INTO " + par_cTabela + " (" + loc_cCols + ") VALUES (" + loc_cVals + ")"
            loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nRet < 0
                THIS.this_cMensagemErro = "Favor Reinicializar o Processo!!!" + CHR(13) + ;
                    "(Update - " + par_cCursor + ") " + CapturarErroSQL()
                loc_lOk = .F.
                EXIT
            ENDIF
        ENDSCAN

        RETURN loc_lOk
    ENDFUNC

    *--------------------------------------------------------------------------
    * ReservarSequencia - Forma de BLOCO do fGerUniqueKey legado.
    *
    * O GravaHis legado chama fGerUniqueKey com QUATRO argumentos
    * (fGerUniqueKey(Dtos(Datas),,,_nRegistro + 1)), reservando um bloco de N
    * numeros de uma vez e devolvendo o ULTIMO do bloco - dai
    * "_Inicio = _Reservado - _nRegistro". O fGerUniqueKey portado
    * (projeto\app\utils\functions.prg) tem UM parametro e emite UM numero,
    * entao o bloco eh reservado aqui, com o MESMO contador
    * (dbo.SIGSYSEQ) e a MESMA instrucao atomica que ele usa.
    *
    * Fallback: se a chave ainda nao existe em SIGSYSEQ (UPDATE afeta zero
    * linhas), delega N vezes ao proprio fGerUniqueKey, que sabe semear a
    * chave nova - assim nao se duplica a regra de semente aqui.
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION ReservarSequencia(par_cChave, par_nQtd)
        LOCAL loc_cChave, loc_nQtd, loc_nRet, loc_nUltimo, loc_nI, loc_lManual

        loc_cChave  = ALLTRIM(TratarNulo(par_cChave, ""))
        loc_nQtd    = MAX(1, INT(TratarNulo(par_nQtd, 1)))
        loc_nUltimo = 0

        IF EMPTY(loc_cChave)
            RETURN 0
        ENDIF

        IF loc_nQtd = 1
            RETURN fGerUniqueKey(loc_cChave)
        ENDIF

        loc_lManual = (SQLGETPROP(gnConnHandle, "Transactions") = 2)

        IF USED("cursor_4c_SeqBloco")
            USE IN cursor_4c_SeqBloco
        ENDIF

        loc_nRet = SQLEXEC(gnConnHandle, ;
            "UPDATE SIGSYSEQ SET conteudo = conteudo + " + FormatarNumeroSQL(loc_nQtd, 0) + ;
            " OUTPUT inserted.conteudo AS novo" + ;
            " WHERE valor = " + EscaparSQL(loc_cChave), ;
            "cursor_4c_SeqBloco")

        IF loc_nRet > 0 AND USED("cursor_4c_SeqBloco") AND RECCOUNT("cursor_4c_SeqBloco") > 0
            GO TOP IN cursor_4c_SeqBloco
            loc_nUltimo = INT(TratarNulo(cursor_4c_SeqBloco.novo, 0))
        ENDIF

        IF USED("cursor_4c_SeqBloco")
            USE IN cursor_4c_SeqBloco
        ENDIF

        IF loc_lManual
            IF loc_nUltimo > 0
                = SQLCOMMIT(gnConnHandle)
            ELSE
                = SQLROLLBACK(gnConnHandle)
            ENDIF
        ENDIF

        *-- Chave ainda inexistente em SIGSYSEQ: emite um a um pelo
        *-- fGerUniqueKey, que cria a chave com a semente correta.
        IF loc_nUltimo = 0
            FOR loc_nI = 1 TO loc_nQtd
                loc_nUltimo = fGerUniqueKey(loc_cChave)
                IF loc_nUltimo = 0
                    EXIT
                ENDIF
            ENDFOR
        ENDIF

        RETURN loc_nUltimo
    ENDFUNC

    *--------------------------------------------------------------------------
    * BuscarCompos - Reconstrucao de fBuscarCompos(poDataMgr, empDopNums,
    * cpros, citens, filtro), chamada uma unica vez no Click legado
    * (dump linha 4984) e cujo retorno GATEIA um ramo:
    *
    *     lcBusca = fBuscarCompos(ThisForm.poDataMgr, lcepn, TmpFinal.Cpros,
    *                             TmpFinal.citens, '')
    *     If !Empty(lcBusca)
    *         Select * from &lcBusca. into cursor crSigPrCpo READWRITE
    *     EndIf
    *     Select crSigPrCpo
    *     Scan ... crSigPrCpo.Mats / .Qtds / .Pesos / .Cpros
    *
    * ATENCAO - INCERTEZA DOCUMENTADA: o fonte original de fBuscarCompos NAO
    * existe no acervo (procurado em projeto\app\utils, Framework\ e nos dumps
    * de tasks\). O contrato abaixo foi deduzido de DUAS passagens do PROPRIO
    * Click legado que fazem a mesma busca de composicao a mao:
    *
    *   - linha 4579: composicao SUBSTITUIDA na O.P.
    *       Select a.*, b.cgrus From SigSubMv a inner join SigCdPro b
    *        on a.mats = b.cpros
    *       where a.empdopnums = ?lcepn and a.cpros = ?TmpFinal.CPros
    *         and a.citem2 = ?TmpFinal.citens
    *
    *   - linhas 5564-5581 (bloco automatico): a MESMA consulta em SigSubMv e,
    *       "If Reccount('TmpCompo') = 0", o fallback para a composicao PADRAO
    *       do produto em SigPrCpo.
    *
    * Dai: devolve o nome do cursor com a composicao SUBSTITUIDA quando ela
    * existe para (empdopnums, cpros, citem2) e, quando nao existe, o da
    * composicao PADRAO (SigPrCpo por Cpros). Devolve string VAZIA quando
    * nenhuma das duas traz linha - e eh isso que o "If !Empty(lcBusca)" do
    * legado testa. Os quatro campos consumidos a seguir (Mats, Qtds, Pesos,
    * Cpros) existem nas DUAS tabelas (conferido em docs/schema.sql).
    *
    * par_cFiltro eh transcrito como condicao adicional opcional - o unico
    * call site passa string vazia.
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION BuscarCompos(par_cEmpDopNums, par_cCpros, par_nCitens, par_cFiltro)
        LOCAL loc_cFiltro, loc_cSQL, loc_cRet

        loc_cRet = ""
        loc_cFiltro = ""
        IF VARTYPE(par_cFiltro) = "C" AND !EMPTY(par_cFiltro)
            loc_cFiltro = " AND (" + par_cFiltro + ")"
        ENDIF

        *-- 1) composicao SUBSTITUIDA na movimentacao (SigSubMv)
        loc_cSQL = "SELECT a.Mats, a.Cpros, a.Qtds, a.Pesos, a.CItens, a.Citem2, b.CGrus" + ;
            " FROM SigSubMv a INNER JOIN SigCdPro b ON a.Mats = b.CPros" + ;
            " WHERE a.EmpDopNums = " + EscaparSQL(par_cEmpDopNums) + ;
            " AND a.CPros = " + EscaparSQL(ALLTRIM(par_cCpros)) + ;
            " AND a.Citem2 = " + FormatarNumeroSQL(par_nCitens, 0) + loc_cFiltro

        IF THIS.ExecutarSQL(loc_cSQL, "cursor_4c_CompoSub", "fBuscarCompos - SigSubMv")
            IF USED("cursor_4c_CompoSub") AND RECCOUNT("cursor_4c_CompoSub") > 0
                loc_cRet = "cursor_4c_CompoSub"
            ENDIF
        ENDIF

        *-- 2) fallback: composicao PADRAO do produto (SigPrCpo)
        IF EMPTY(loc_cRet) AND EMPTY(THIS.this_cMensagemErro)
            loc_cSQL = "SELECT a.Mats, a.Cpros, a.Qtds, a.Pesos, b.CGrus" + ;
                " FROM SigPrCpo a INNER JOIN SigCdPro b ON a.Mats = b.CPros" + ;
                " WHERE a.CPros = " + EscaparSQL(ALLTRIM(par_cCpros)) + loc_cFiltro

            IF THIS.ExecutarSQL(loc_cSQL, "cursor_4c_CompoPad", "fBuscarCompos - SigPrCpo")
                IF USED("cursor_4c_CompoPad") AND RECCOUNT("cursor_4c_CompoPad") > 0
                    loc_cRet = "cursor_4c_CompoPad"
                ENDIF
            ENDIF
        ENDIF

        RETURN loc_cRet
    ENDFUNC

    *==========================================================================
    * NOTA DE ESCOPO - fRecalculaP / fRecalculaC (recalculo de custo medio)
    *
    * O Click legado chama fRecalculaP/fRecalculaC em 12 pontos: 10 deles com
    * o retorno DESCARTADO (=fRecalculaP(...)), logo apos cada Insert Into
    * crSigMvHst, e 2 pares no fecho (dump linhas 5462/5466 e 5864/5868) na
    * forma de lote (fRecalculaP(.t., poDataMgr) / fRecalculaC(.t.,.f.,.f.,
    * poDataMgr)), onde o retorno gateia llErro.
    *
    * As DUAS funcoes NAO existem no acervo - nem como .prg, nem como fonte no
    * Framework, nem como string no p-code dos VCX (varredura binaria feita em
    * 2026-09-29 sobre Framework\*.VCT/*.VCX, origem\, tasks\ e projeto\).
    * Elas recalculam custo medio / preco medio de estoque (SigOpClP/SigOpClC).
    *
    * DECISAO (regra #27 do CLAUDE.md, 3a linha da tabela - funcao que produz
    * VALOR DE CALCULO fica AUSENTE e visivel, nunca vira stub): as chamadas
    * foram OMITIDAS, nao stubadas. Inventar um recalculo de custo medio
    * gravaria numero financeiro errado em silencio - risco muito maior do que
    * a ausencia. Os dois pares de fecho tambem foram omitidos SEM marcar
    * llErro: marcar erro abortaria e desfaria TODA a geracao de O.P. por
    * causa de uma funcao que nao existe.
    *
    * CONSEQUENCIA FUNCIONAL A REPORTAR: apos Processar(), o custo/preco medio
    * de estoque NAO eh recalculado. Os movimentos (SigMvHst/SigBxEst/
    * SigMvItn/SigMvIts/SigMvCab/SigOpPic/SigPdMvf/SigCdNec/SigCdNei) sao
    * gravados corretamente; falta apenas o recalculo derivado, que fica
    * de fora por decisao deliberada (ver justificativa acima). Mesmo
    * tratamento ja adotado em dmoBO.RecalcularEstoque/RecalcularCusto.
    *
    * Cada ponto de chamada esta marcado abaixo com o comentario
    * "*-- fRecalculaP/fRecalculaC: omitido (ver NOTA DE ESCOPO)".
    *==========================================================================

    *--------------------------------------------------------------------------
    * CarregarParametrosProcessamento - Completa os parametros de sistema que
    * o Processar() usa e que o Init() desta classe ainda nao carregava:
    *
    *   SigCdPam.GlobAutos / GruConfs / ConConfs  (properties ja declaradas)
    *   SigCdPac.OpPdCompra / OpZers / AgrupReqs / SigKeys
    *
    * No legado esses valores vinham dos cursores globais crSigCdPam e
    * crSigCdPac que o form pai (SIGPRGLO) deixava abertos na DataSession
    * compartilhada. Aqui sao relidos do banco para o BO nao depender do pai
    * - mesma decisao ja tomada no Init() para o resto de SigCdPam.
    *
    * SigKeys so eh sobrescrito quando o FORM nao o preencheu
    * (FormSigPrGlp.InicializarForm le CrSigCdPac.sigKeys quando o cursor
    * global existe) - o valor do form tem precedencia.
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION CarregarParametrosProcessamento()
        LOCAL loc_lOk
        loc_lOk = .F.

        IF USED("cursor_4c_PamProc")
            USE IN cursor_4c_PamProc
        ENDIF
        IF SQLEXEC(gnConnHandle, ;
                "SELECT globautos, gruconfs, conconfs FROM SigCdPam", ;
                "cursor_4c_PamProc") >= 0 AND USED("cursor_4c_PamProc")

            IF !EOF("cursor_4c_PamProc")
                THIS.this_nPamGlobAutos = TratarNulo(cursor_4c_PamProc.globautos, 0)
                THIS.this_cPamGruConfs  = PADR(TratarNulo(cursor_4c_PamProc.gruconfs, ""), 10)
                THIS.this_cPamConConfs  = PADR(TratarNulo(cursor_4c_PamProc.conconfs, ""), 10)
            ENDIF
            USE IN cursor_4c_PamProc
            loc_lOk = .T.
        ELSE
            THIS.this_cMensagemErro = "Favor Reinicializar o Processo!!!" + CHR(13) + ;
                "(SigCdPam) " + CapturarErroSQL()
        ENDIF

        IF loc_lOk
            loc_lOk = .F.
            IF USED("cursor_4c_PacProc")
                USE IN cursor_4c_PacProc
            ENDIF
            IF SQLEXEC(gnConnHandle, ;
                    "SELECT oppdcompra, opzers, agrupreqs, sigkeys FROM SigCdPac", ;
                    "cursor_4c_PacProc") >= 0 AND USED("cursor_4c_PacProc")

                IF !EOF("cursor_4c_PacProc")
                    THIS.this_cPacOpPdCompra = PADR(TratarNulo(cursor_4c_PacProc.oppdcompra, ""), 20)
                    THIS.this_nPacOpZers     = TratarNulo(cursor_4c_PacProc.opzers, 0)
                    THIS.this_nPacAgrupReqs  = TratarNulo(cursor_4c_PacProc.agrupreqs, 0)

                    IF EMPTY(ALLTRIM(THIS.this_cSigKey))
                        THIS.this_cSigKey = PADR(TratarNulo(cursor_4c_PacProc.sigkeys, ""), 3)
                    ENDIF
                ENDIF
                USE IN cursor_4c_PacProc
                loc_lOk = .T.
            ELSE
                THIS.this_cMensagemErro = "Favor Reinicializar o Processo!!!" + CHR(13) + ;
                    "(SigCdPac) " + CapturarErroSQL()
            ENDIF
        ENDIF

        RETURN loc_lOk
    ENDFUNC

    *--------------------------------------------------------------------------
    * CarregarDbParam - Resolve as tres colunas do cursor "DBParam" do legado.
    *
    * O DBParam eh montado no Click do SigPrGlo (grandparent), nao no SIGPRGLP:
    *
    *     =Seek(_lcTpGOp,'CrTmpTpGOp')
    *     Create Cursor DBParam (CodTgOps c(10), OpZers n(1), EntPes n(1))
    *     Insert Into DbParam (CodTgOps, OpZers, EntPes) Values (
    *         _lcTpGOp,
    *         Iif(ThisForm.GerPorTp, CrTmpTpGop.OpZers, CrSigCdPac.OpZers),
    *         Iif(ThisForm.GerPorTp, CrTmpTpGop.EntPes, 0))
    *
    * CrTmpTpGop eh SigInTgo filtrado por Codigos = _lcTpGOp (colunas codigos,
    * descs, entpes, opzers, dopps - conferidas em docs/schema.sql).
    * CrSigCdPac.OpZers eh SigCdPac.opzers (THIS.this_nPacOpZers, carregado em
    * CarregarParametrosProcessamento).
    *
    * O cursor nao foi portado; as tres colunas viram properties deste BO e
    * sao lidas ao longo do Processar() (Pesos de crSigPdMvf, CodTgOps de
    * crSigOpPic e o gate da entrada automatica).
    *--------------------------------------------------------------------------
    FUNCTION CarregarDbParam()
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        TRY
            THIS.this_cDbCodTgOps = PADR(ALLTRIM(THIS.this_cTipoGeracaoOP), 10)

            IF THIS.this_lGerPorTp
                *-- CrTmpTpGop = SigInTgo Where Codigos = _lcTpGOp
                THIS.this_nDbOpZers = 0
                THIS.this_nDbEntPes = 0

                IF USED("cursor_4c_TpGOp")
                    USE IN cursor_4c_TpGOp
                ENDIF
                IF TYPE("gnConnHandle") = "N" AND gnConnHandle > 0
                    IF SQLEXEC(gnConnHandle, ;
                            "SELECT opzers, entpes FROM SigInTgo WHERE codigos = " + ;
                            EscaparSQL(ALLTRIM(THIS.this_cTipoGeracaoOP)), ;
                            "cursor_4c_TpGOp") >= 0 AND USED("cursor_4c_TpGOp")

                        IF !EOF("cursor_4c_TpGOp")
                            THIS.this_nDbOpZers = TratarNulo(cursor_4c_TpGOp.opzers, 0)
                            THIS.this_nDbEntPes = TratarNulo(cursor_4c_TpGOp.entpes, 0)
                        ENDIF
                        USE IN cursor_4c_TpGOp
                        loc_lSucesso = .T.
                    ELSE
                        THIS.this_cMensagemErro = "Favor Reinicializar o Processo!!!" + CHR(13) + ;
                            "(SigInTgo) " + CapturarErroSQL()
                    ENDIF
                ENDIF
            ELSE
                THIS.this_nDbOpZers = THIS.this_nPacOpZers
                THIS.this_nDbEntPes = 0
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "SigPrGlpBO.CarregarDbParam")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * AtualizaPeso - Transcricao de SIGPRGLP.atualizapeso (dump 2736-2773).
    *
    * Opera sobre o cursor CORRENTE (cCompo = Alias() no legado; o chamador faz
    * "Select LocalCompo" imediatamente antes) e devolve o peso total dos
    * componentes que entram no custo.
    *
    * crSigCdPam.AutComps -> THIS.this_nPamAutComps (carregado no Init).
    * crSigCdCom -> cursor global preparado pelo FORM
    * (FormSigPrGlp.PrepararCursoresDeTrabalho), com Tipos/Custos/CGrus.
    *
    * Acesso aos campos do cursor corrente por EVALUATE: o legado usa macro
    * (&cCompo..CGrus), que aqui seria macro-substituicao desnecessaria -
    * EVALUATE eh a forma canonica de LEITURA por nome (regra #15).
    *
    * Falha de SQL grava this_cMensagemErro e devolve 0; o chamador aborta ao
    * ver a mensagem preenchida (o legado fazia MessageBox + Return 0).
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION AtualizaPeso()
        LOCAL loc_cCompo, loc_nTotQtd, loc_cQuery, loc_nFator, loc_cUni, loc_lFalhou

        loc_cCompo  = ALIAS()
        loc_nTotQtd = 0
        loc_lFalhou = .F.

        IF EMPTY(loc_cCompo) OR !USED(loc_cCompo)
            RETURN 0
        ENDIF

        IF THIS.this_nPamAutComps != 1
            SELECT (loc_cCompo)
            SCAN
                IF !USED("crSigCdCom")
                    LOOP
                ENDIF

                SELECT crSigCdCom
                GO TOP IN crSigCdCom
                LOCATE FOR crSigCdCom.CGrus = EVALUATE(loc_cCompo + ".CGrus") ;
                       AND crSigCdCom.Custos = 1

                IF !EOF("crSigCdCom")
                    loc_cQuery = "SELECT a.cUnis, a.cUnips, b.BPesos" + ;
                        " FROM SigCdPro a, SigCdGrp b" + ;
                        " WHERE a.CPros = " + EscaparSQL(ALLTRIM(EVALUATE(loc_cCompo + ".Mats"))) + ;
                        " AND a.CGrus = b.CGrus"

                    IF !THIS.ExecutarSQL(loc_cQuery, "crSomaGru", "crSomaGru - 1")
                        loc_lFalhou = .T.
                        EXIT
                    ENDIF

                    GO TOP IN crSomaGru

                    IF !EOF("crSomaGru") AND INLIST(TratarNulo(crSomaGru.BPesos, 0), 1, 3)
                        loc_cUni = IIF(TratarNulo(crSomaGru.BPesos, 0) = 1, ;
                            TratarNulo(crSomaGru.cUnis, ""), TratarNulo(crSomaGru.cUnips, ""))

                        IF !THIS.ExecutarSQL( ;
                                "SELECT Fators FROM SigCdUni WHERE Cunis = " + ;
                                EscaparSQL(ALLTRIM(loc_cUni)), "LocalUni", "LocalUni")
                            loc_lFalhou = .T.
                            EXIT
                        ENDIF

                        loc_nFator = 1
                        IF USED("LocalUni") AND !EOF("LocalUni")
                            loc_nFator = IIF(TratarNulo(LocalUni.Fators, 0) = 0, 1, ;
                                TratarNulo(LocalUni.Fators, 0))
                        ENDIF

                        SELECT (loc_cCompo)
                        loc_nTotQtd = loc_nTotQtd + ( ;
                            IIF(TratarNulo(crSomaGru.BPesos, 0) = 1, ;
                                EVALUATE(loc_cCompo + ".Qtds"), ;
                                EVALUATE(loc_cCompo + ".Pesos")) * loc_nFator)
                    ENDIF
                ENDIF

                SELECT (loc_cCompo)
            ENDSCAN

            SELECT (loc_cCompo)
        ENDIF

        IF loc_lFalhou
            loc_nTotQtd = 0
        ENDIF

        RETURN loc_nTotQtd
    ENDFUNC

    *--------------------------------------------------------------------------
    * GravaHis - Transcricao de SIGPRGLP.gravahis (dump 2778-2843).
    *
    * Atribui as chaves primarias do historico de estoque (crSigMvHst):
    * CidChaves = Dtos(Datas) + <letra da operacao> + Transform(seq,"@L 999999")
    *             + SigKey     e    Seqs = sequencial da chave 'HISTBAR'.
    *
    * As duas sequencias sao BLOCOS reservados de uma vez (ver
    * ReservarSequencia) - o legado chama fGerUniqueKey com o 4o argumento.
    *
    * LocalOpe (SigCdOpe + SigCdOpd das operacoes presentes no historico) eh
    * montado igual ao legado, mas so era consumido pelo bloco *!* comentado
    * logo abaixo (a regra de trocar E/S por H/K foi desativada em 23/10/2015).
    * Mantido por fidelidade e para nao alterar o estado dos cursores.
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION GravaHis()
        LOCAL loc_lOk, loc_cSql, loc_nRegistro, loc_nReservado, loc_nInicio
        LOCAL loc_nRerSeq, loc_nIniSeq, loc_cNewOpe

        loc_lOk = .T.

        IF !USED("crSigMvHst")
            RETURN .T.
        ENDIF

        *-- LocalOpe: estrutura vazia de CrSigCdOpe (Select ... Where 0=1)
        IF USED("LocalOpe")
            USE IN LocalOpe
        ENDIF
        IF THIS.ExecutarSQL( ;
                "SELECT Dopes, Estoqs, Origems, Destinos, EstOrigs, EstDests" + ;
                " FROM SigCdOpe WHERE 1 = 0", "cursor_4c_OpeEstr", "LocalOpe")

            SELECT * FROM cursor_4c_OpeEstr WHERE .F. INTO CURSOR LocalOpe READWRITE
            USE IN cursor_4c_OpeEstr
        ELSE
            loc_lOk = .F.
        ENDIF

        IF loc_lOk
            SELECT DISTINCT Dopes FROM crSigMvHst INTO CURSOR SelOperacao

            SELECT SelOperacao
            SCAN
                loc_cSql = "SELECT Dopes, Estoqs, Origems, Destinos, EstOrigs, EstDests" + ;
                    " FROM SigCdOpe WHERE Dopes = " + EscaparSQL(ALLTRIM(SelOperacao.Dopes))
                IF !THIS.ExecutarSQL(loc_cSql, "xTmpOpe", "xTmpOpe")
                    loc_lOk = .F.
                    EXIT
                ENDIF
                IF USED("xTmpOpe") AND RECCOUNT("xTmpOpe") > 0
                    SELECT LocalOpe
                    APPEND FROM DBF("xTmpOpe")
                ENDIF
                SELECT SelOperacao
            ENDSCAN
        ENDIF

        IF loc_lOk
            SELECT LocalOpe
            INDEX ON Dopes TAG Dopes

            SELECT SelOperacao
            SCAN
                loc_cSql = "SELECT Dopps AS Dopes, 1 AS Estoqs, Origems, Destinos," + ;
                    " EstOrigs, EstDests FROM SigCdOpd WHERE Dopps = " + ;
                    EscaparSQL(ALLTRIM(SelOperacao.Dopes))
                IF !THIS.ExecutarSQL(loc_cSql, "xTmpOpe", "xTmpOpe - Opd")
                    loc_lOk = .F.
                    EXIT
                ENDIF
                IF USED("xTmpOpe") AND RECCOUNT("xTmpOpe") > 0
                    SELECT LocalOpe
                    APPEND FROM DBF("xTmpOpe")
                ENDIF
                SELECT SelOperacao
            ENDSCAN
        ENDIF

        IF loc_lOk
            WAIT WINDOW "Criando Chaves Prim" + CHR(225) + "rias no Arquivo de Hist" + ;
                CHR(243) + "rico " NOWAIT

            SELECT crSigMvHst
            GO TOP
            loc_nRegistro = RECCOUNT("crSigMvHst")

            IF loc_nRegistro > 0
                *-- Bloco de chaves do historico (uma chave por DATA do 1o
                *-- registro, igual ao legado: fGerUniqueKey(Dtos(Datas),,,N+1))
                *-- O legado repete o fGerUniqueKey ate sair diferente de zero
                *-- ("DO While _Reservado = 0 And _nRegistro > 0"), o que com
                *-- falha permanente de conexao vira laco INFINITO. Aqui uma
                *-- unica reserva ja eh atomica; zero significa falha real e
                *-- ABORTA - seguir adiante gravaria CidChaves com sequencial
                *-- NEGATIVO (_Reservado - _nRegistro), colidindo no indice
                *-- unico de SigMvHst.
                loc_nReservado = THIS.ReservarSequencia(DTOS(crSigMvHst.Datas), loc_nRegistro + 1)
                loc_nRerSeq    = 0
                IF loc_nReservado > 0
                    loc_nRerSeq = THIS.ReservarSequencia("HISTBAR", loc_nRegistro + 1)
                ENDIF

                IF loc_nReservado = 0 OR loc_nRerSeq = 0
                    WAIT CLEAR
                    THIS.this_cMensagemErro = "Favor Reinicializar o Processo!!!" + CHR(13) + ;
                        "N" + CHR(227) + "o foi poss" + CHR(237) + "vel reservar a numera" + ;
                        CHR(231) + CHR(227) + "o do hist" + CHR(243) + "rico de estoque."
                    RETURN .F.
                ENDIF

                loc_nInicio = loc_nReservado - loc_nRegistro
                loc_nIniSeq = loc_nRerSeq - loc_nRegistro

                SELECT crSigMvHst
                SCAN
                    loc_nInicio = loc_nInicio + 1
                    loc_nIniSeq = loc_nIniSeq + 1

                    *-- Tiago - 23/10/2015: grava no cidchaves a MESMA letra da
                    *-- movimentacao, para o historico ficar na ordem certa
                    *-- (o bloco *!* que trocava E/S por H/K esta desativado no
                    *-- legado e NAO foi transcrito)
                    loc_cNewOpe = TratarNulo(crSigMvHst.Opers, " ")

                    REPLACE CidChaves WITH DTOS(crSigMvHst.Datas) + loc_cNewOpe + ;
                            TRANSFORM(loc_nInicio, "@L 999999") + THIS.this_cSigKey, ;
                            Seqs      WITH loc_nIniSeq ;
                        IN crSigMvHst

                    *-- fRecalculaP/fRecalculaC: omitido (ver NOTA DE ESCOPO)
                ENDSCAN
            ENDIF

            WAIT CLEAR
        ENDIF

        RETURN loc_lOk
    ENDFUNC

    *--------------------------------------------------------------------------
    * PrepararCursoresDestino - Equivale ao bloco de "Select crXxx / Zap" do
    * topo do Click legado (dump 4261-4288). Os nove cursores de gravacao nao
    * existem na cadeia migrada (nem SigPrGloBO/FormSigPrGlo nem SigPrGl2BO/
    * FormSigPrGl2 os criam, e o dump legado do SIGPRGLO tampouco): sao
    * recriados aqui, VAZIOS e com a estrutura COMPLETA da tabela destino.
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION PrepararCursoresDestino()
        LOCAL loc_lOk

        loc_lOk = THIS.AbrirCursorTabela("crSigOpPic", "SigOpPic")
        IF loc_lOk
            loc_lOk = THIS.AbrirCursorTabela("crSigPdMvf", "SigPdMvf")
        ENDIF
        IF loc_lOk
            loc_lOk = THIS.AbrirCursorTabela("crSigCdNec", "SigCdNec")
        ENDIF
        IF loc_lOk
            loc_lOk = THIS.AbrirCursorTabela("crSigMvCab", "SigMvCab")
        ENDIF
        IF loc_lOk
            loc_lOk = THIS.AbrirCursorTabela("crSigMvHst", "SigMvHst")
        ENDIF
        IF loc_lOk
            loc_lOk = THIS.AbrirCursorTabela("crSigBxEst", "SigBxEst")
        ENDIF
        IF loc_lOk
            loc_lOk = THIS.AbrirCursorTabela("crSigMvItn", "SigMvItn")
        ENDIF
        IF loc_lOk
            loc_lOk = THIS.AbrirCursorTabela("crSigMvIts", "SigMvIts")
        ENDIF
        IF loc_lOk
            loc_lOk = THIS.AbrirCursorTabela("crSigCdNei", "SigCdNei")
        ENDIF

        *-- Select * From CrSigCdNei Where 0=1 Into Cursor GrSigCdNei ReadWrite
        IF loc_lOk
            IF USED("GrSigCdNei")
                USE IN GrSigCdNei
            ENDIF
            SELECT * FROM crSigCdNei WHERE .F. INTO CURSOR GrSigCdNei READWRITE
            loc_lOk = USED("GrSigCdNei")
        ENDIF

        *-- crTplMvIts / crTpmMvItn: no legado nascem de
        *-- CursorQuery('SigMvIts'/'SigMvItn', ..., 'cIdChaves', fUniqueIds()),
        *-- isto eh, cursor VAZIO com a estrutura da tabela (a chave sorteada
        *-- nunca casa). Sao cursores de TRABALHO, diferentes de crSigMvIts/
        *-- crSigMvItn - a consolidacao de um para o outro esta em
        *-- ConsolidarMovimentoItens().
        IF loc_lOk
            loc_lOk = THIS.AbrirCursorTabela("crTplMvIts", "SigMvIts")
            IF loc_lOk
                SELECT crTplMvIts
                INDEX ON Cpros TAG Cpros
            ENDIF
        ENDIF
        IF loc_lOk
            loc_lOk = THIS.AbrirCursorTabela("crTpmMvItn", "SigMvItn")
            IF loc_lOk
                SELECT crTpmMvItn
                INDEX ON Cpros TAG Cpros
            ENDIF
        ENDIF

        RETURN loc_lOk
    ENDFUNC

    *--------------------------------------------------------------------------
    * FecharCursoresProcessamento - Libera os cursores de trabalho criados por
    * Processar(), tornando-o reexecutavel na mesma sessao do form.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE FecharCursoresProcessamento()
        LOCAL ARRAY loc_aCursores[34]
        LOCAL loc_nI

        loc_aCursores[1]  = "crSigOpPic"
        loc_aCursores[2]  = "crSigPdMvf"
        loc_aCursores[3]  = "crSigCdNec"
        loc_aCursores[4]  = "crSigCdNei"
        loc_aCursores[5]  = "crSigMvCab"
        loc_aCursores[6]  = "crSigMvHst"
        loc_aCursores[7]  = "crSigBxEst"
        loc_aCursores[8]  = "crSigMvItn"
        loc_aCursores[9]  = "crSigMvIts"
        loc_aCursores[10] = "GrSigCdNei"
        loc_aCursores[11] = "crTplMvIts"
        loc_aCursores[12] = "crTpmMvItn"
        loc_aCursores[13] = "TmpEmpH"
        loc_aCursores[14] = "TmpPedra"
        loc_aCursores[15] = "TmpMatPrz"
        loc_aCursores[16] = "TmpEstoque"
        loc_aCursores[17] = "TmpOpePed"
        loc_aCursores[18] = "TmpOpi"
        loc_aCursores[19] = "TmpUltItn"
        loc_aCursores[20] = "TempEest"
        loc_aCursores[21] = "TempEestI"
        loc_aCursores[22] = "TempEsti2"
        loc_aCursores[23] = "LocalCompo"
        loc_aCursores[24] = "LocalOpe"
        loc_aCursores[25] = "SelOperacao"
        loc_aCursores[26] = "xTmpOpe"
        loc_aCursores[27] = "crSigPrCpo"
        loc_aCursores[28] = "cursor_4c_CompoSub"
        loc_aCursores[29] = "cursor_4c_CompoPad"
        loc_aCursores[30] = "pEstoque"
        loc_aCursores[31] = "TmpNensi"
        loc_aCursores[32] = "xNensi"
        loc_aCursores[33] = "TmpLinF"
        loc_aCursores[34] = "TmpCompo"

        FOR loc_nI = 1 TO ALEN(loc_aCursores)
            IF USED(loc_aCursores[loc_nI])
                USE IN (loc_aCursores[loc_nI])
            ENDIF
        ENDFOR
    ENDPROC

    *==========================================================================
    * Processar - Transcricao do Click do botao Processar (SIGPRGLP.Processar.
    * Click, dump linhas 4255-5893). Efetiva a geracao das Ordens de Producao.
    *
    * CONTRATO (fixado em FormSigPrGlp.BtnProcessarClick): sem parametros. O
    * form preenche antes this_dPrevisao (_Prev), this_dDataGeracao (_DtGera),
    * this_cTipoGeracaoOP (_lcTpGOp) e this_lGerPorTp (GerPorTp). Devolve .T.
    * em sucesso, com this_nNumeroOpGerada = _Nump; em falha devolve .F. com
    * this_cMensagemErro preenchido (o form exibe via MsgErro).
    *
    * NAO transcrito (codigo morto conferido linha a linha no dump):
    *   - "Set Step On" (linha 5121) - abre o debugger do VFP, nao vai para
    *     producao
    *   - bloco *!* de override de _Dopp por TmpSigInTgo.Dopps (4296-4300)
    *   - blocos *!* que trocavam a letra E/S por H/K no CidChaves do
    *     historico (desativados pelo proprio legado em 23/10/2015)
    *   - "_Qtdcpnt = (crSigCdPro.QtdCpnts * _QtBaixado)" comentado em 4452
    *   - consulta comentada de SigPrCpo em 5571-5573
    *
    * FICA NO FORM (camada de apresentacao, ja implementada/decidida la):
    *   - "Do Form SigReGli With _Nump, ThisForm" (impressao da O.P. gerada)
    *   - ThisForm.Enabled / Processar.Enabled / Disponivel.Enabled /
    *     TotLinha.Enabled = .f. e o Cancelar.Click() + Keyboard '{ESC}' do
    *     fecho, que o BtnProcessarClick ja cobre fechando o form
    *--------------------------------------------------------------------------
    FUNCTION Processar()
        LOCAL loc_lSucesso, loc_oErro, loc_cExactOrig

        *-- Estado compartilhado com os metodos de bloco (ver nota de
        *-- arquitetura acima): PRIVATE, como as Private/Local do Click legado
        PRIVATE loc_lAbortar, loc_tDay, loc_cEmpr, loc_cUsuar
        PRIVATE loc_cDopp, loc_cDope, loc_nNump, loc_nNumpe, loc_nSeqs
        PRIVATE loc_cCpros, loc_cReff, loc_cCor, loc_cTam, loc_dPrev, loc_dDtGera
        PRIVATE loc_nTProd, loc_nTPeso, loc_cClinha, loc_cNota
        PRIVATE loc_cGrupoD, loc_cContaD, loc_cGrupoC, loc_cContaC
        PRIVATE loc_nNume, loc_nCitens, loc_cDopePed, loc_nNopComp, loc_nQtBaixado
        PRIVATE loc_cDopEntAu, loc_nNumEntAu, loc_cChave, loc_cChave2, loc_lGrvEest
        PRIVATE loc_nSeq, loc_cDpTrf, loc_nNopI, loc_nNopF

        loc_lSucesso = .F.
        loc_lAbortar = .F.
        THIS.this_cMensagemErro   = ""
        THIS.this_nNumeroOpGerada = 0

        IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
            THIS.this_cMensagemErro = "Sem conex" + CHR(227) + "o com o banco de dados." + CHR(13) + ;
                "Favor Reinicializar o Processo!!!"
            RETURN .F.
        ENDIF
        IF !USED("TmpFinal")
            THIS.this_cMensagemErro = "Os dados da pr" + CHR(233) + "via n" + CHR(227) + ;
                "o est" + CHR(227) + "o dispon" + CHR(237) + "veis." + CHR(13) + ;
                "Favor Reinicializar o Processo!!!"
            RETURN .F.
        ENDIF

        *-- SET EXACT: o Click legado roda com o default do VFP (EXACT OFF) e
        *-- depende disso - faz DEZENAS de SEEK PARCIAIS sobre indices
        *-- COMPOSTOS (Seek(SelPedra.Cpros) sobre CMats+Grupos+Contas,
        *-- Seek(TmpFinal.Cpros+CodCors+CodTams) sobre um indice de 6 partes
        *-- em TmpSaldG, Seek(nTran) sobre nTrans, ...). O config.prg deste
        *-- projeto liga SET EXACT ON (linha 231) e, medido no VFP9
        *-- (2026-09-29, ver FormSigPrGlp.AplicarFaixaSaldoContas), com EXACT
        *-- ON o SEEK parcial devolve .F. - as buscas NUNCA casariam e o
        *-- processamento gravaria material/requisicao duplicados em silencio,
        *-- sem nenhum erro na tela.
        *-- Restaurado no fim, inclusive no caminho do CATCH.
        loc_cExactOrig = SET("EXACT")
        SET EXACT OFF

        TRY
            *-- pDay = Datetime()
            loc_tDay   = DATETIME()
            loc_cEmpr  = PADR(go_4c_Sistema.cCodEmpresa, 3)
            loc_cUsuar = PADR(LEFT(ALLTRIM(gc_4c_UsuarioLogado), 10), 10)

            *-- Parametros do sistema + DBParam (o legado ja os tinha nos
            *-- cursores globais crSigCdPam/crSigCdPac/DBParam)
            IF !THIS.CarregarParametrosProcessamento()
                loc_lAbortar = .T.
            ENDIF
            IF !loc_lAbortar AND !THIS.CarregarDbParam()
                loc_lAbortar = .T.
            ENDIF

            *-- Select crSigOpPic / Zap  ... (9 cursores) + GrSigCdNei
            IF !loc_lAbortar AND !THIS.PrepararCursoresDestino()
                loc_lAbortar = .T.
            ENDIF

            IF !loc_lAbortar
                *-- _Dopp = crSigCdPam.DoppPads / _Dope = crSigCdPam.TransfRes
                loc_cDopp = PADR(THIS.this_cPamDoppPads, 20)
                loc_cDope = PADR(THIS.this_cPamTransfRes, 20)

                IF !THIS.ConsultarTabela("SigCdOpd", "crSigCdOpd", "Dopps", ALLTRIM(loc_cDopp))
                    loc_lAbortar = .T.
                ENDIF
            ENDIF

            *-- Numero da O.P. (_Nump) + conferencia de duplicidade
            IF !loc_lAbortar
                loc_nNump = 0
                IF !THIS.this_lReserva
                    IF THIS.this_nPamGlobAutos = 2 AND THIS.this_nNumeroDaOp > 0
                        loc_nNump = THIS.this_nNumeroDaOp
                    ELSE
                        loc_nNump = fGerUniqueKey(ALLTRIM(loc_cDopp))
                    ENDIF

                    IF !THIS.ExecutarSQL("SELECT Numps FROM SigOpPic WHERE Numps = " + ;
                            FormatarNumeroSQL(loc_nNump, 0), "TmpOpi", "TmpOpi")
                        loc_lAbortar = .T.
                    ELSE
                        IF RECCOUNT("TmpOpi") > 0
                            THIS.this_cMensagemErro = "N" + CHR(250) + "mero de Op j" + CHR(225) + ;
                                " existe. Favor Corrigir!!!"
                            loc_lAbortar = .T.
                        ENDIF
                    ENDIF
                ENDIF
            ENDIF

            IF !loc_lAbortar
                loc_nSeqs   = 0
                loc_cCpros  = ""
                loc_cReff   = SPACE(15)
                loc_cCor    = SPACE(4)
                loc_cTam    = SPACE(2)
                loc_dPrev   = ConverterParaData(THIS.this_dPrevisao)
                loc_dDtGera = ConverterParaData(THIS.this_dDataGeracao)
                loc_nTProd  = 0
                loc_nTPeso  = 0
                loc_cClinha = SPACE(10)
                loc_cNota   = SPACE(6)
                loc_cGrupoD = SPACE(10)
                loc_cContaD = SPACE(10)
                loc_nNumpe  = (loc_nNump * 10000) + 1
                loc_nNume   = 0
                loc_nCitens = 0

                *-- Cursores de acumulo de componentes / pedras / prazos
                IF USED("TmpEmpH")
                    USE IN TmpEmpH
                ENDIF
                CREATE CURSOR TmpEmpH (Grupos C(10), Contas C(10), cGrus C(3), cMats C(14), ;
                    Qtds N(12,3), QtdReqs N(12,3), QtdEsts N(12,3), QtdMins N(12,3), ;
                    QtdPedcs N(12,3), QtdComps N(12,3), QtdEmphs N(12,3), QtdGReqs N(12,3), ;
                    cpro2s C(10), Pesos N(12,3))
                INDEX ON Cgrus + Cmats TAG GruMat
                INDEX ON CMats + cpro2s TAG CMats

                IF USED("TmpPedra")
                    USE IN TmpPedra
                ENDIF
                CREATE CURSOR TmpPedra (Grupos C(10), Contas C(10), cGrus C(3), cMats C(14), ;
                    Qtds N(12,3), QtdReqs N(12,3), QtdEsts N(12,3), QtdMins N(12,3), ;
                    QtdPedcs N(12,3), QtdComps N(12,3), QtdEmphs N(12,3), QtdGReqs N(12,3), ;
                    Pesos N(12,3))
                INDEX ON Cgrus + Cmats TAG GruMat
                INDEX ON CMats TAG CMats
                INDEX ON CMats + Grupos + Contas TAG MatGruCon

                IF USED("TmpMatPrz")
                    USE IN TmpMatPrz
                ENDIF
                CREATE CURSOR TmpMatPrz (cMats C(14), Qtds N(12,3), Pesos N(12,3), ;
                    PrazoEnts D, QtBaixas N(12,3))
                INDEX ON DTOC(PrazoEnts) + Cmats TAG MatPrazo DESC

                *-- _DopePed = crSigCdPac.OpPdCompra
                loc_cDopePed = PADR(THIS.this_cPacOpPdCompra, 20)
                IF !THIS.ConsultarTabela("SigCdOpe", "TmpOpePed", "Dopes", ALLTRIM(loc_cDopePed))
                    loc_lAbortar = .T.
                ENDIF
            ENDIF

            *-- 1) Producao / pedido de compra de acabado (dump 4363-4666)
            IF !loc_lAbortar
                THIS.ProcessarProducao()
            ENDIF

            *-- 2) Empenho de estoque + baixa das movimentacoes (4668-4927)
            IF !loc_lAbortar
                THIS.ProcessarEstoque()
            ENDIF

            *-- 3) Componentes/pedras: empenho, requisicao e pedido (4929-5235)
            IF !loc_lAbortar
                THIS.ProcessarComponentes()
            ENDIF

            *-- 4) Consolidacao crTpmMvItn/crTplMvIts -> crSigMvItn/crSigMvIts
            IF !loc_lAbortar
                THIS.ConsolidarMovimentoItens()
            ENDIF

            *-- 5) Entrada automatica de peso/material (5254-5417)
            IF !loc_lAbortar
                THIS.ProcessarEntradaAutomatica()
            ENDIF

            *-- 6) Chaves do historico + gravacao efetiva + commit (5419-5479)
            IF !loc_lAbortar
                IF THIS.GravarMovimentos()
                    loc_lSucesso = .T.
                ELSE
                    loc_lAbortar = .T.
                ENDIF
            ENDIF

            *-- 7) Modo automatico: gera o fluxo de fases/transferencia e
            *--    grava o segundo lote (5491-5891)
            IF loc_lSucesso AND THIS.this_lAutomatico
                IF !THIS.ProcessarModoAutomatico()
                    loc_lSucesso = .F.
                ENDIF
            ENDIF

            IF loc_lSucesso
                THIS.this_nNumeroOpGerada = loc_nNump
            ENDIF

        CATCH TO loc_oErro
            *-- Regra #9 (CATCH nunca silencioso): a mensagem NAO some - fica
            *-- em this_cMensagemErro e o FormSigPrGlp.BtnProcessarClick a
            *-- exibe via MsgErro sempre que Processar() devolve .F. Exibir
            *-- aqui tambem duplicaria o dialogo para o usuario.
            = SQLROLLBACK(gnConnHandle)
            THIS.this_cMensagemErro = loc_oErro.Message + " [Ln:" + TRANSFORM(loc_oErro.LineNo) + ;
                " / " + TRANSFORM(loc_oErro.Procedure) + "]"
            loc_lSucesso = .F.
        ENDTRY

        THIS.FecharCursoresProcessamento()

        IF loc_cExactOrig = "ON"
            SET EXACT ON
        ELSE
            SET EXACT OFF
        ENDIF

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * ProcessarProducao - Transcricao de "If Not ThisForm.Reserva ... EndIf"
    * (dump 4363-4666): varre TmpFinal na ordem de agrupamento da O.P. e, para
    * cada item com Produzir <> 0, ou gera a O.P. de producao (crSigOpPic +
    * crSigPdMvf + crSigCdNec + GrSigCdNei, quebrando por QtPcs da linha), ou
    * - quando SigCdPac.OpPdCompra esta configurado e o produto NAO eh de
    * fabricacao propria (SigCdPro.FabrProPrs <> 1) - gera pedido de compra do
    * acabado (crSigMvCab + crTpmMvItn + crTplMvIts).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ProcessarProducao()
        LOCAL loc_cMat, loc_nQtdPrz, loc_nQtdLim, loc_nQtBaixar, loc_nVezes
        LOCAL loc_cCidC, loc_cIds, loc_nQtdTb, loc_nQtdcpnt, loc_nUnits, loc_cMoedas
        LOCAL loc_cQuery, loc_nBaixaAtual, loc_nPendente, loc_nPQtd, loc_nPQt2
        LOCAL loc_cEdn, loc_cPIds, loc_cPId2, loc_cForn, loc_nTotPed, loc_nPesoCmp
        LOCAL loc_lProsseguir

        IF THIS.this_lReserva
            RETURN
        ENDIF

        SELECT TmpFinal
        INDEX ON Linhas + Reffs + Cpros + Notas + CodCors + CodTams + GrupoDs + ContaDs TAG Cpros
        SET ORDER TO Cpros
        GO TOP

        DO WHILE !EOF("TmpFinal") AND !loc_lAbortar

            IF TmpFinal.Produzir != 0

                loc_lProsseguir = THIS.ConsultarTabela("SigCdPro", "crSigCdPro", "CPros", ALLTRIM(TmpFinal.CPros))
                IF loc_lProsseguir
                    loc_lProsseguir = THIS.ConsultarTabela("SigCdLin", "CrSigCdLin", "Linhas", ALLTRIM(TmpFinal.Linhas))
                ENDIF
                IF loc_lProsseguir
                    loc_lProsseguir = THIS.ConsultarTabela("SigCdGrp", "CrSigCdGrp", "CGrus", ;
                        ALLTRIM(crSigCdPro.Cgrus), "Mercs, GeraTubs")
                ENDIF
                IF loc_lProsseguir
                    loc_lProsseguir = THIS.ConsultarTabela("SigCdGpr", "CrSigCdGpr", "Codigos", ;
                        ALLTRIM(CrSigCdGrp.Mercs), "MatPrincs, cpqtds")
                ENDIF
                IF !loc_lProsseguir
                    loc_lAbortar = .T.
                    EXIT
                ENDIF

                *-- Tiago - Real Gold - 24/08/2015 - Se estiver configurado para
                *-- gerar pedido de compra de acabado, so industrializa os
                *-- produtos de fabricacao propria
                IF EMPTY(THIS.this_cPacOpPdCompra) OR ;
                        (!EMPTY(THIS.this_cPacOpPdCompra) AND crSigCdPro.FabrProPrs = 1)

                    loc_cMat = IIF(!EMPTY(crSigCdPro.MatPrincs), crSigCdPro.MatPrincs, ;
                        IIF(!EMPTY(CrSigCdGpr.Matprincs), CrSigCdGpr.MatPrincs, THIS.this_cPamOuros))

                    loc_nQtdPrz   = TmpFinal.Produzir
                    loc_nQtdLim   = IIF(CrSigCdLin.QtPcs = 0, TmpFinal.Produzir, CrSigCdLin.QtPcs)
                    loc_nQtBaixar = TmpFinal.Produzir
                    loc_nVezes    = 0

                    DO WHILE loc_nQtBaixar > 0 AND !loc_lAbortar

                        loc_nVezes = loc_nVezes + 1

                        IF loc_nQtBaixar < loc_nQtdLim
                            loc_nQtBaixado = loc_nQtBaixar
                            loc_nQtBaixar  = 0
                        ELSE
                            loc_nQtBaixar  = loc_nQtBaixar - loc_nQtdLim
                            loc_nQtBaixado = loc_nQtdLim
                        ENDIF

                        *-- Quebra de grupo da O.P.: muda Linha/Referencia/
                        *-- Produto/Nota/Cor/Grupo/Conta de destino, ou a mesma
                        *-- combinacao dividida em mais de um lote (_lnVezes > 1)
                        IF (loc_cClinha + loc_cReff + loc_cCpros + loc_cNota + loc_cCor + ;
                                loc_cGrupoD + loc_cContaD != ;
                                TmpFinal.Linhas + TmpFinal.Reffs + TmpFinal.CPros + ;
                                TmpFinal.Notas + TmpFinal.CodCors + TmpFinal.GrupoDs + ;
                                TmpFinal.ContaDs) OR loc_nVezes > 1

                            loc_cClinha = TmpFinal.Linhas
                            loc_cCpros  = TmpFinal.CPros
                            loc_cCor    = TmpFinal.CodCors
                            loc_cTam    = TmpFinal.CodTams
                            loc_cReff   = TmpFinal.Reffs
                            loc_cGrupoD = TmpFinal.GrupoDs
                            loc_cContaD = TmpFinal.ContaDs
                            loc_nSeqs   = loc_nSeqs + 1
                            loc_cNota   = TmpFinal.Notas
                            loc_nNopComp = (loc_nNump * 10000) + loc_nSeqs
                            loc_cCidC   = DTOS(loc_dDtGera) + ;
                                TRANSFORM(fGerUniqueKey(DTOS(loc_dDtGera)), "@L 999999") + ;
                                THIS.this_cSigKey

                            INSERT INTO crSigPdMvf (Emps, Dopps, Numps, Datars, Datas, Usuars, ;
                                    Grupoos, Contaos, Grupods, Contads, Nops, CodPds, Unids, ;
                                    Pesos, Qtds, Ordems, cIdChaves, EmpDopNums, EmpDNps) ;
                                VALUES (loc_cEmpr, loc_cDopp, loc_nNopComp, DATETIME(), loc_dDtGera, ;
                                    loc_cUsuar, crSigCdOpd.GruOrigs, crSigCdOpd.ConOrigs, ;
                                    loc_cGrupoD, loc_cContaD, loc_nNopComp, loc_cCpros, ;
                                    crSigCdPro.CUnis, IIF(THIS.this_nDbOpZers = 1, 0, loc_nTPeso), ;
                                    loc_nTProd, 1, loc_cCidC, ;
                                    loc_cEmpr + SPACE(20) + STR(0, 6), ;
                                    loc_cEmpr + loc_cDopp + STR(loc_nNopComp, 10))

                            loc_cIds = DTOS(loc_dDtGera) + ;
                                TRANSFORM(fGerUniqueKey(DTOS(loc_dDtGera)), "@L 999999") + ;
                                THIS.this_cSigKey

                            INSERT INTO crSigCdNec (Emps, Dopps, Numps, Datars, Datas, Usuars, ;
                                    TotPesos, Grupoos, Contaos, Grupods, Contads, cIdChaves, ;
                                    EmpDNps, Jobs) ;
                                VALUES (loc_cEmpr, loc_cDopp, loc_nNopComp, DATETIME(), loc_dDtGera, ;
                                    loc_cUsuar, loc_nTPeso, crSigCdOpd.GruOrigs, crSigCdOpd.ConOrigs, ;
                                    loc_cGrupoD, loc_cContaD, loc_cIds, ;
                                    loc_cEmpr + loc_cDopp + STR(loc_nNopComp, 10), TmpFinal.Jobs)

                            INSERT INTO GrSigCdNei (Emps, Dopps, Numps, Nops, Nenvs, Cmats, ;
                                    Cdescs, cUnis, Pesos, Qtds, TpOps, EmpDNps, cIdChaves) ;
                                VALUES (loc_cEmpr, loc_cDopp, loc_nNopComp, loc_nNopComp, ;
                                    loc_nNopComp, loc_cMat, crSigCdPro.Dpros, crSigCdPro.Cunis, ;
                                    IIF(crSigCdGpr.cpqtds = 1, loc_nTProd, loc_nTPeso), ;
                                    IIF(crSigCdGpr.cpqtds = 1, loc_nTProd, loc_nTPeso), ;
                                    THIS.this_cPamTpOpEntAus, ;
                                    loc_cEmpr + loc_cDopp + STR(loc_nNopComp, 10), fUniqueIds())

                            loc_nTProd = 0
                            loc_nTPeso = 0
                        ENDIF

                        loc_nNopComp = (loc_nNump * 10000) + loc_nSeqs

                        *-- Tiago - 17/08/11 - Vianna: quantidade de pecas do
                        *-- tubo por componentes ou por matrizes (GeraTubs = 2)
                        IF crSigCdGrp.GeraTubs != 2
                            loc_nQtdTb = crSigCdPro.QtdCpnts
                        ELSE
                            IF !THIS.ExecutarSQL( ;
                                    "SELECT SUM(qtds) AS total FROM SigPrMtz WHERE Cpros = " + ;
                                    EscaparSQL(ALLTRIM(TmpFinal.CPros)), "crSigPrMtz", "crSigPrMtz")
                                loc_lAbortar = .T.
                                EXIT
                            ENDIF
                            SELECT crSigPrMtz
                            loc_nQtdTb = crSigPrMtz.Total
                        ENDIF
                        loc_nQtdcpnt = (NVL(loc_nQtdTb, 0) * loc_nQtBaixado)

                        loc_nUnits  = 0
                        loc_cMoedas = SPACE(3)

                        loc_cEdn = TmpFinal.Emps + TmpFinal.Dopes + STR(TmpFinal.Numes, 6)

                        loc_cQuery = "SELECT * FROM SigMvItn" + ;
                            " WHERE EmpDopNums = " + EscaparSQL(loc_cEdn) + ;
                            " AND CPros = " + EscaparSQL(TmpFinal.Cpros)

                        IF !THIS.ExecutarSQL(loc_cQuery, "TempEestI", "TempEestI")
                            loc_lAbortar = .T.
                            EXIT
                        ENDIF

                        SELECT TempEestI
                        SCAN
                            IF TempEestI.CItens = TmpFinal.Citens
                                loc_nUnits  = TempEestI.Units
                                loc_cMoedas = TempEestI.Moedas
                                EXIT
                            ENDIF
                        ENDSCAN

                        INSERT INTO crSigOpPic (Emps, Dopps, Numps, Nops, Dopes, Numes, Dataes, ;
                                Dataps, Obss, Qtds, Cpros, DtGeras, CodCors, CodTams, Pesos, ;
                                QtdCpnts, Units, Moedas, cIdChaves, EmpDopNums, EmpDNps, Notas, ;
                                Empds, EmpDopNops, Dpros, CodTgOps, Citens) ;
                            VALUES (loc_cEmpr, loc_cDopp, loc_nNump, loc_nNopComp, TmpFinal.Dopes, ;
                                TmpFinal.Numes, loc_dPrev, TmpFinal.Datas, TmpFinal.Obsps, ;
                                loc_nQtBaixado, loc_cCpros, loc_dDtGera, TmpFinal.CodCors, ;
                                TmpFinal.CodTams, loc_nQtBaixado * TmpFinal.Peso, loc_nQtdcpnt, ;
                                loc_nUnits, loc_cMoedas, fUniqueIds(), ;
                                TmpFinal.Emps + TmpFinal.Dopes + STR(TmpFinal.Numes, 6), ;
                                loc_cEmpr + loc_cDopp + STR(loc_nNump, 10), TmpFinal.Notas, ;
                                TmpFinal.Emps, loc_cEmpr + loc_cDopp + STR(loc_nNopComp, 10), ;
                                TmpFinal.Dpros, THIS.this_cDbCodTgOps, TmpFinal.cItens)

                        *-- Baixa da quantidade produzida nos itens da
                        *-- movimentacao de origem (SigMvItn / SigMvIts)
                        SELECT TempEestI
                        loc_nBaixaAtual = loc_nQtBaixado
                        SCAN WHILE loc_nBaixaAtual > 0
                            loc_cEdn  = TempEestI.Emps + TempEestI.Dopes + STR(TempEestI.Numes, 6)
                            loc_cPIds = TempEestI.cIdChaves

                            IF (TempEestI.Qtds - TempEestI.QtBaixas - TempEestI.QtProds) != 0

                                loc_cQuery = "SELECT * FROM SigMvIts" + ;
                                    " WHERE EmpDopNums = " + EscaparSQL(loc_cEdn) + ;
                                    " AND CItens = " + FormatarNumeroSQL(TempEestI.Citens, 0)

                                IF !THIS.ExecutarSQL(loc_cQuery, "TempEsti2", "TempEsti2 - 1")
                                    loc_lAbortar = .T.
                                    EXIT
                                ENDIF

                                SELECT TempEsti2
                                GO TOP
                                IF EOF("TempEsti2")
                                    loc_nPendente = TempEestI.Qtds - TempEestI.QtBaixas - TempEestI.QtProds
                                    IF loc_nPendente > loc_nBaixaAtual
                                        loc_nPQtd = TempEestI.QtProds + loc_nBaixaAtual
                                        loc_nBaixaAtual = 0
                                    ELSE
                                        loc_nPQtd = TempEestI.QtProds + loc_nPendente
                                        loc_nBaixaAtual = loc_nBaixaAtual - loc_nPendente
                                    ENDIF

                                    loc_cQuery = "UPDATE SigMvItn SET DtAlts = " + ;
                                        FormatarDataSQL(loc_tDay) + ", QtProds = " + ;
                                        FormatarNumeroSQL(loc_nPQtd, 3) + ;
                                        " WHERE cIdChaves = " + EscaparSQL(loc_cPIds)

                                    IF !THIS.ExecutarSQL(loc_cQuery, "", "Update - 1")
                                        loc_lAbortar = .T.
                                        EXIT
                                    ENDIF
                                ELSE
                                    SELECT TempEsti2
                                    SCAN WHILE loc_nBaixaAtual > 0
                                        loc_cPId2 = TempEsti2.cIdChaves

                                        loc_nPendente = TempEsti2.Qtds - TempEsti2.QtBaixas - TempEsti2.QtProds
                                        IF loc_nPendente != 0
                                            IF loc_nPendente > loc_nBaixaAtual
                                                loc_nPQtd = TempEestI.QtProds + loc_nBaixaAtual
                                                loc_nPQt2 = TempEsti2.QtProds + loc_nBaixaAtual
                                                loc_nBaixaAtual = 0
                                            ELSE
                                                loc_nPQtd = TempEestI.QtProds + loc_nPendente
                                                loc_nPQt2 = TempEsti2.QtProds + loc_nPendente
                                                loc_nBaixaAtual = loc_nBaixaAtual - loc_nPendente
                                            ENDIF

                                            loc_cQuery = "UPDATE SigMvItn SET DtAlts = " + ;
                                                FormatarDataSQL(loc_tDay) + ", QtProds = " + ;
                                                FormatarNumeroSQL(loc_nPQtd, 3) + ;
                                                " WHERE cIdChaves = " + EscaparSQL(loc_cPIds)

                                            IF !THIS.ExecutarSQL(loc_cQuery, "", "Update - 2")
                                                loc_lAbortar = .T.
                                                EXIT
                                            ENDIF

                                            loc_cQuery = "UPDATE SigMvIts SET QtProds = " + ;
                                                FormatarNumeroSQL(loc_nPQt2, 3) + ;
                                                " WHERE cIdChaves = " + EscaparSQL(loc_cPId2)

                                            IF !THIS.ExecutarSQL(loc_cQuery, "", "Update - 3")
                                                loc_lAbortar = .T.
                                                EXIT
                                            ENDIF
                                        ENDIF
                                    ENDSCAN
                                    IF loc_lAbortar
                                        EXIT
                                    ENDIF
                                ENDIF
                            ENDIF
                        ENDSCAN
                        IF loc_lAbortar
                            EXIT
                        ENDIF

                        loc_cQuery = "UPDATE SigMvCab SET Nops = " + ;
                            FormatarNumeroSQL(loc_nNump, 0) + ", DtAlts = " + ;
                            FormatarDataSQL(loc_tDay) + " WHERE EmpDopNums = " + ;
                            EscaparSQL(TmpFinal.Emps + TmpFinal.Dopes + STR(TmpFinal.Numes, 6))

                        IF !THIS.ExecutarSQL(loc_cQuery, "", "Update - 4")
                            loc_lAbortar = .T.
                            EXIT
                        ENDIF

                        *-- Composicao substituida na O.P.: se existir e o
                        *-- sistema estiver configurado (AutComps <> 1), o peso
                        *-- vem da composicao e nao do peso do item
                        loc_cEdn = TmpFinal.Emps + TmpFinal.Dopes + STR(TmpFinal.Numes, 6)
                        loc_cQuery = "SELECT a.*, b.cgrus FROM SigSubMv a" + ;
                            " INNER JOIN SigCdPro b ON a.mats = b.cpros" + ;
                            " WHERE a.empdopnums = " + EscaparSQL(loc_cEdn) + ;
                            " AND a.cpros = " + EscaparSQL(TmpFinal.CPros) + ;
                            " AND a.citem2 = " + FormatarNumeroSQL(TmpFinal.citens, 0)

                        IF !THIS.ExecutarSQL(loc_cQuery, "LocalCompo", "LocalCompo")
                            loc_lAbortar = .T.
                            EXIT
                        ENDIF

                        IF THIS.this_nPamAutComps != 1 AND RECCOUNT("LocalCompo") > 0
                            SELECT LocalCompo
                            loc_nPesoCmp = THIS.AtualizaPeso()
                            IF !EMPTY(THIS.this_cMensagemErro)
                                loc_lAbortar = .T.
                                EXIT
                            ENDIF
                            loc_nTProd = loc_nTProd + loc_nQtBaixado
                            loc_nTPeso = loc_nTPeso + (loc_nQtBaixado * loc_nPesoCmp)

                            SELECT crSigOpPic
                            REPLACE Pesos WITH loc_nQtBaixado * loc_nPesoCmp IN crSigOpPic
                        ELSE
                            loc_nTProd = loc_nTProd + loc_nQtBaixado
                            loc_nTPeso = loc_nTPeso + (loc_nQtBaixado * TmpFinal.Peso)
                        ENDIF

                        SELECT crSigPdMvf
                        REPLACE Pesos WITH IIF(THIS.this_nDbOpZers = 1, 0, loc_nTPeso), ;
                                Qtds  WITH loc_nTProd IN crSigPdMvf

                        SELECT GrSigCdNei
                        REPLACE Pesos WITH IIF(crSigCdGpr.cpqtds = 1, loc_nTProd, loc_nTPeso), ;
                                Qtds  WITH IIF(crSigCdGpr.cpqtds = 1, loc_nTProd, loc_nTPeso) ;
                            IN GrSigCdNei

                        SELECT crSigCdNec
                        REPLACE TotPesos WITH loc_nTPeso IN crSigCdNec
                        IF THIS.this_lAutomatico
                            REPLACE Autos WITH .T. IN crSigCdNec
                        ENDIF

                    ENDDO

                ELSE
                    *-- Pedido de compra do produto acabado
                    loc_cForn = PADR(IIF(!EMPTY(crSigCdPro.Ifors), crSigCdPro.Ifors, ;
                        TmpOpePed.ConOrigs), 10)
                    loc_nTotPed = TmpFinal.Produzir

                    SELECT crSigMvCab
                    GO TOP
                    LOCATE FOR crSigMvCab.Dopes = PADR(THIS.this_cPacOpPdCompra, 20) ;
                           AND crSigMvCab.ContaDs = loc_cForn
                    IF !EOF("crSigMvCab")
                        loc_nNume = crSigMvCab.Numes

                        SELECT MAX(Citens) AS Citens FROM crTpmMvItn ;
                            WHERE crTpmMvItn.Emps = m.loc_cEmpr ;
                              AND crTpmMvItn.Dopes = m.loc_cDopePed ;
                              AND crTpmMvItn.Numes = m.loc_nNume ;
                            INTO CURSOR TmpUltItn
                        loc_nCitens = NVL(TmpUltItn.Citens, 0) + 1
                    ELSE
                        loc_nCitens = 9999
                    ENDIF

                    IF loc_nCitens >= 9999
                        loc_nCitens = 1
                        loc_nNume   = fGerUniqueKey(loc_cEmpr + loc_cDopePed)

                        INSERT INTO crSigMvCab (Emps, Dopes, Numes, MascNum, Datas, Datars, ;
                                Usuars, Grupoos, Contaos, Grupods, Contads, Nops, Obses, ;
                                Empdopnums, cIdChaves, DtAlts) ;
                            VALUES (loc_cEmpr, loc_cDopePed, loc_nNume, ;
                                ALLTRIM(fGerMascara(loc_nNume)), loc_dDtGera, DATETIME(), ;
                                loc_cUsuar, TmpOpePed.GruOrigs, loc_cForn, TmpOpePed.GruDests, ;
                                TmpOpePed.ConDests, loc_nNump, ;
                                "[ OP: " + STR(loc_nNump) + "] ", ;
                                loc_cEmpr + loc_cDopePed + STR(loc_nNume, 6), ;
                                fUniqueIds(), DATETIME())
                    ENDIF

                    INSERT INTO crTpmMvItn (Emps, Dopes, Numes, CPros, Qtds, Cunis, DPros, ;
                            Opers, Citens, Pesos, cUniPs, Obs) ;
                        VALUES (loc_cEmpr, loc_cDopePed, loc_nNume, TmpFinal.Cpros, loc_nTotPed, ;
                            crSigCdPro.Cunis, crSigCdPro.Dpros, "E", loc_nCitens, ;
                            CrSigCdPro.PesoMs, CrSigCdPro.cUniPs, TmpFinal.Obsps)

                    IF !EMPTY(TmpFinal.CodCors) OR !EMPTY(TmpFinal.CodTams)
                        INSERT INTO crTplMvIts (cItens, Emps, Dopes, Numes, CPros, Qtds, Pesos, ;
                                CodCors, CodTams, QtdEmbs) ;
                            VALUES (loc_nCitens, loc_cEmpr, loc_cDopePed, loc_nNume, ;
                                TmpFinal.CPros, loc_nTotPed, CrSigCdPro.PesoMs, ;
                                TmpFinal.CodCors, TmpFinal.CodTams, 1)
                    ENDIF

                    loc_cQuery = "UPDATE SigMvCab SET Nops = " + ;
                        FormatarNumeroSQL(loc_nNump, 0) + ", DtAlts = " + ;
                        FormatarDataSQL(loc_tDay) + " WHERE EmpDopNums = " + ;
                        EscaparSQL(TmpFinal.Emps + TmpFinal.Dopes + STR(TmpFinal.Numes, 6))

                    IF !THIS.ExecutarSQL(loc_cQuery, "", "Update - 4.1")
                        loc_lAbortar = .T.
                        EXIT
                    ENDIF
                ENDIF
            ENDIF

            SELECT TmpFinal
            SKIP
        ENDDO
    ENDPROC

    *--------------------------------------------------------------------------
    * ProcessarEstoque - Transcricao do dump 4668-4927. Monta TmpEstoque
    * (o que sai do estoque para nao ser produzido), gera a movimentacao de
    * transferencia/reserva (crSigMvCab + crTpmMvItn + crTplMvIts), o historico
    * de estoque (crSigMvHst) e baixa QtProds/QtReservas em SigMvItn/SigMvIts,
    * registrando as baixas em crSigBxEst.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ProcessarEstoque()
        LOCAL loc_nXBaixa, loc_nXReser, loc_cEdn, loc_cQuery, loc_lTemItem2
        LOCAL loc_nQtBaixar, loc_cPIds, loc_nPQtd, loc_cPNop, loc_lProsseguir

        IF USED("TmpSaldG")
            SELECT TmpSaldG
            *-- "Select TmpSaldg / Set Order To" do legado: derrubar a ordem
            *-- tambem derruba o SET KEY que o Init/AfterRowColChange legado
            *-- mantinha no item corrente. No migrado essa restricao eh um
            *-- SET FILTER (FormSigPrGlp.AplicarFaixaSaldoContas), que
            *-- SOBREVIVE ao SET ORDER TO - sem limpa-lo aqui, o REPLACE ALL
            *-- abaixo e todo o empenho de estoque enxergariam SO o produto
            *-- selecionado na grade.
            SET FILTER TO
            SET ORDER TO
            REPLACE ALL Reservs WITH Saldo - Disps IN TmpSaldG
        ENDIF

        IF USED("TmpEstoque")
            USE IN TmpEstoque
        ENDIF
        CREATE CURSOR TmpEstoque (EmpDs C(3), Cpros C(14), CodCors C(4), CodTams C(4), ;
            Emps C(3), Dopes C(20), Numes N(6), grupos C(10), Estos C(10), Estoque N(12,3))
        INDEX ON EmpDs + Grupos + Estos + Emps + Dopes + STR(Numes, 6) TAG EmpDopNum

        SELECT TmpFinal
        SET ORDER TO
        SCAN
            IF !THIS.ConsultarTabela("SigCdPro", "crSigCdPro", "CPros", ;
                    ALLTRIM(TmpFinal.CPros), "FabrProPrs")
                loc_lAbortar = .T.
                EXIT
            ENDIF

            IF TmpFinal.Estoque != 0 AND ;
                    IIF(!EMPTY(THIS.this_cPacOpPdCompra) AND crSigCdPro.FabrProPrs != 1, .F., .T.)

                loc_nXBaixa = TmpFinal.Estoque

                IF USED("TmpSaldG")
                    SELECT TmpSaldG
                    SET ORDER TO Cpros
                    = SEEK(TmpFinal.Cpros + TmpFinal.CodCors + TmpFinal.CodTams)
                    SCAN WHILE TmpSaldG.Cpros = TmpFinal.Cpros ;
                            AND TmpSaldG.CodCors = TmpFinal.CodCors ;
                            AND TmpSaldG.CodTams = TmpFinal.CodTams ;
                            AND loc_nXBaixa > 0

                        IF TmpSaldG.Reservs >= loc_nXBaixa
                            REPLACE TmpSaldg.Reservs WITH TmpSaldg.Reservs - loc_nXBaixa IN TmpSaldG
                            INSERT INTO TmpEstoque (Cpros, CodCors, CodTams, Emps, dopes, ;
                                    Numes, Grupos, Estos, Estoque, EmpDs) ;
                                VALUES (TmpFinal.Cpros, TmpFinal.CodCors, TmpFinal.CodTams, ;
                                    TmpFinal.Emps, TmpFinal.Dopes, TmpFinal.Numes, ;
                                    TmpSaldg.Grupos, TmpSaldG.Estos, loc_nXBaixa, TmpSaldG.Emps)
                            loc_nXBaixa = 0
                        ELSE
                            *-- Rafael - 06/2016 - Se o Saldo for o mesmo do
                            *-- estoque, usou outro tamanho para nao produzir
                            IF (TmpSaldg.Reservs > 0) OR (TmpFinal.Estoque = TmpFinal.Saldo)
                                loc_nXBaixa = loc_nXBaixa - TmpSaldg.Reservs
                                loc_nXReser = IIF(TmpFinal.Estoque = TmpFinal.Saldo, ;
                                    loc_nXBaixa, TmpSaldg.Reservs)
                                INSERT INTO TmpEstoque (Cpros, CodCors, CodTams, Emps, dopes, ;
                                        Numes, Grupos, Estos, Estoque, EmpDs) ;
                                    VALUES (TmpFinal.Cpros, TmpFinal.CodCors, TmpFinal.CodTams, ;
                                        TmpFinal.Emps, TmpFinal.Dopes, TmpFinal.Numes, ;
                                        TmpSaldg.Grupos, TmpSaldg.Estos, loc_nXReser, TmpSaldG.Emps)
                                REPLACE TmpSaldg.Reservs WITH 0 IN TmpSaldG
                            ENDIF
                        ENDIF
                        SELECT TmpSaldG
                    ENDSCAN
                ENDIF
            ENDIF

            *-- Tiago - Real Gold - 24/08/2015 - Com pedido de compra de
            *-- acabado configurado, gera reserva (empenho) de TODAS as pecas
            *-- que serao compradas, tendo ou nao estoque
            IF !EMPTY(THIS.this_cPacOpPdCompra) AND crSigCdPro.FabrProPrs != 1
                INSERT INTO TmpEstoque (Cpros, CodCors, CodTams, Emps, dopes, Numes, ;
                        Grupos, Estos, Estoque, EmpDs) ;
                    VALUES (TmpFinal.Cpros, TmpFinal.CodCors, TmpFinal.CodTams, ;
                        TmpFinal.Emps, TmpFinal.Dopes, TmpFinal.Numes, ;
                        "", "", TmpFinal.Qtds, TmpFinal.Emps)
            ENDIF

            SELECT TmpFinal
        ENDSCAN

        IF loc_lAbortar
            RETURN
        ENDIF

        loc_lGrvEest = .F.
        loc_cChave   = SPACE(30)
        loc_cChave2  = SPACE(22)
        loc_nCitens  = 1

        SELECT TmpEstoque
        SET ORDER TO EmpDopNum
        SCAN
            loc_lProsseguir = THIS.ConsultarTabela("SigCdPro", "crSigCdPro", "CPros", ALLTRIM(TmpEstoque.CPros))
            IF loc_lProsseguir
                loc_lProsseguir = THIS.ConsultarTabela("SigCdGrp", "crSigCdGrp", "CGrus", ALLTRIM(crSigCdPro.CGrus))
            ENDIF
            IF !loc_lProsseguir
                loc_lAbortar = .T.
                EXIT
            ENDIF

            SELECT TmpEstoque

            IF (TmpEstoque.EmpDs + TmpEstoque.Grupos + TmpEstoque.Estos != loc_cChave2) OR ;
                    (TmpEstoque.Emps + TmpEstoque.Dopes + STR(TmpEstoque.Numes, 6) != loc_cChave)

                IF TmpEstoque.EmpDs + TmpEstoque.Grupos + TmpEstoque.Estos != loc_cChave2
                    loc_lGrvEest = .F.
                ENDIF
                loc_cChave2 = TmpEstoque.EmpDs + TmpEstoque.Grupos + TmpEstoque.Estos
                loc_cChave  = TmpEstoque.Emps + TmpEstoque.Dopes + STR(TmpEstoque.Numes, 6)

                loc_cEdn = TmpEstoque.Emps + TmpEstoque.Dopes + STR(TmpEstoque.Numes, 6)

                loc_cQuery = "UPDATE SigMvCab SET Nops = " + FormatarNumeroSQL(loc_nNump, 0) + ;
                    ", DtAlts = " + FormatarDataSQL(loc_tDay) + ;
                    " WHERE EmpDopNums = " + EscaparSQL(loc_cEdn)

                IF !THIS.ExecutarSQL(loc_cQuery, "", "Update - 5")
                    loc_lAbortar = .T.
                    EXIT
                ENDIF

                loc_lProsseguir = THIS.ConsultarTabela("SigCdOpe", "crSigCdOpe", "Dopes", ALLTRIM(TmpEstoque.Dopes))
                IF loc_lProsseguir
                    loc_lProsseguir = THIS.ConsultarTabela("SigMvCab", "TempEest", "EmpDopNums", loc_cEdn)
                ENDIF
                IF !loc_lProsseguir
                    loc_lAbortar = .T.
                    EXIT
                ENDIF

                IF crSigCdOpe.Globalizas = 1
                    loc_cGrupoD = PADR(TempEest.Grupoos, 10)
                    loc_cContaD = PADR(TempEest.Contaos, 10)
                ELSE
                    loc_cGrupoD = PADR(TempEest.Grupods, 10)
                    loc_cContaD = PADR(TempEest.Contads, 10)
                ENDIF

                IF !EMPTY(THIS.this_cPamGruReservs)
                    loc_cGrupoD = PADR(THIS.this_cPamGruReservs, 10)
                ENDIF
                IF !EMPTY(THIS.this_cPamConReservs)
                    loc_cContaD = PADR(THIS.this_cPamConReservs, 10)
                ENDIF

                IF (THIS.this_nPamAgrupEmph = 2 AND !EMPTY(THIS.this_cPamGruReservs) ;
                        AND !loc_lGrvEest) OR (THIS.this_nPamAgrupEmph != 2)

                    loc_nNume   = fGerUniqueKey(TmpEstoque.EmpDs + loc_cDope)
                    loc_nCitens = 1

                    INSERT INTO crSigMvCab (Emps, Dopes, Numes, MascNum, Datas, Datars, Usuars, ;
                            Grupoos, Contaos, Grupods, Contads, Nops, Obses, cIdChaves, ;
                            Dtalts, EmpDopNums, EmpDs) ;
                        VALUES (TmpEstoque.EmpDs, loc_cDope, loc_nNume, ;
                            ALLTRIM(fGerMascara(loc_nNume)), loc_dDtGera, DATETIME(), loc_cUsuar, ;
                            TmpEstoque.grupos, TmpEstoque.Estos, loc_cGrupoD, loc_cContaD, loc_nNump, ;
                            IIF(THIS.this_lReserva, ;
                                "[ Reserva Autom" + CHR(225) + "tica ]", ;
                                "[ OP: " + STR(loc_nNump) + "] ") + loc_cChave, ;
                            fUniqueIds(), DATETIME(), ;
                            TmpEstoque.Empds + loc_cDope + STR(loc_nNume, 6), loc_cEmpr)
                    loc_lGrvEest = .T.
                ELSE
                    loc_cEdn = TmpEstoque.Emps + loc_cDope + STR(loc_nNume, 6)
                    IF !THIS.ConsultarTabela("SigMvCab", "TempEest", "EmpDopNums", loc_cEdn)
                        loc_lAbortar = .T.
                        EXIT
                    ENDIF

                    loc_cPNop = TempEest.Obses + " / " + loc_cChave

                    loc_cQuery = "UPDATE SigMvCab SET Obses = " + EscaparSQL(loc_cPNop) + ;
                        ", DtAlts = " + FormatarDataSQL(loc_tDay) + ;
                        " WHERE EmpDopNums = " + EscaparSQL(loc_cEdn)

                    IF !THIS.ExecutarSQL(loc_cQuery, "", "Update - 6")
                        loc_lAbortar = .T.
                        EXIT
                    ENDIF
                ENDIF
            ENDIF

            INSERT INTO crTpmMvItn (Emps, Dopes, Numes, CPros, Qtds, Cunis, DPros, Opers, cItens) ;
                VALUES (TmpEstoque.EmpDs, loc_cDope, loc_nNume, TmpEstoque.CPros, ;
                    TmpEstoque.Estoque, crSigCdPro.Cunis, crSigCdPro.Dpros, "S", loc_nCitens)

            IF crSigCdGrp.TipoEstos > 1
                INSERT INTO crTplMvIts (cItens, Emps, Dopes, Numes, CPros, Qtds, CodCors, ;
                        CodTams, QtdEmbs) ;
                    VALUES (loc_nCitens, TmpEstoque.EmpDs, loc_cDope, loc_nNume, ;
                        TmpEstoque.CPros, TmpEstoque.Estoque, TmpEstoque.CodCors, ;
                        TmpEstoque.CodTams, 1)
            ENDIF

            loc_nCitens = loc_nCitens + 1

            IF !THIS.ConsultarTabela("SigCdOpe", "crSigCdOpe", "Dopes", ALLTRIM(loc_cDope))
                loc_lAbortar = .T.
                EXIT
            ENDIF

            IF crSigCdOpe.Estoqs = 1
                INSERT INTO crSigMvHst (Usuars, Datas, Datars, Emps, Dopes, Numes, Empos, Cpros, ;
                        Qtds, Opers, Grupos, Estos, CodCors, CodTams, EmpDopNums, EmpGruEsts, ;
                        OriDopNums, cIdChaves, Seqs) ;
                    VALUES (loc_cUsuar, loc_dDtGera, DATETIME(), TmpEstoque.EmpDs, loc_cDope, ;
                        loc_nNume, loc_cEmpr, TmpEstoque.CPros, TmpEstoque.Estoque, "S", ;
                        TmpEstoque.Grupos, TmpEstoque.Estos, TmpEstoque.CodCors, TmpEstoque.CodTams, ;
                        TmpEstoque.Empds + loc_cDope + STR(loc_nNume, 6), ;
                        TmpEstoque.EmpDs + TmpEstoque.Grupos + TmpEstoque.Estos, ;
                        TmpEstoque.EmpDs + loc_cDope + STR(loc_nNume, 6), fUniqueIds(), 0)

                INSERT INTO crSigMvHst (Usuars, Datas, Datars, Emps, Dopes, Numes, Empos, Cpros, ;
                        Qtds, Opers, Grupos, Estos, CodCors, CodTams, EmpDopNums, EmpGruEsts, ;
                        OriDopNums, cIdChaves, Seqs) ;
                    VALUES (loc_cUsuar, loc_dDtGera, DATETIME(), loc_cEmpr, loc_cDope, loc_nNume, ;
                        loc_cEmpr, TmpEstoque.CPros, TmpEstoque.Estoque, "E", loc_cGrupoD, ;
                        loc_cContaD, TmpEstoque.CodCors, TmpEstoque.CodTams, ;
                        loc_cEmpr + loc_cDope + STR(loc_nNume, 6), ;
                        loc_cEmpr + loc_cGrupoD + loc_cContaD, ;
                        TmpEstoque.EmpDs + loc_cDope + STR(loc_nNume, 6), fUniqueIds(), 0)
            ENDIF

            *-- Baixa da quantidade que NAO sera produzida (QtProds)
            loc_nQtBaixar = TmpEstoque.Estoque

            loc_cQuery = "SELECT * FROM SigMvIts WHERE EmpDopNums = " + ;
                EscaparSQL(TmpEstoque.Emps + TmpEstoque.Dopes + STR(TmpEstoque.Numes, 6)) + ;
                " AND CPros = " + EscaparSQL(TmpEstoque.Cpros)

            IF !THIS.ExecutarSQL(loc_cQuery, "TempEsti2", "TempEsti2 - 2")
                loc_lAbortar = .T.
                EXIT
            ENDIF
            GO TOP IN TempEsti2
            loc_lTemItem2 = !EOF("TempEsti2")

            loc_cQuery = "SELECT * FROM SigMvItn WHERE EmpDopNums = " + ;
                EscaparSQL(TmpEstoque.Emps + TmpEstoque.Dopes + STR(TmpEstoque.Numes, 6)) + ;
                " AND CPros = " + EscaparSQL(TmpEstoque.Cpros)

            IF !THIS.ExecutarSQL(loc_cQuery, "TempEestI", "TempEestI")
                loc_lAbortar = .T.
                EXIT
            ENDIF

            SELECT TempEestI
            SCAN WHILE loc_nQtBaixar > 0
                loc_cPIds = TempEestI.cIdChaves
                IF TempEestI.QtProds + loc_nQtBaixar <= TempEestI.Qtds
                    loc_nPQtd      = TempEestI.QtProds + loc_nQtBaixar
                    loc_nQtBaixado = loc_nQtBaixar
                    loc_nQtBaixar  = 0
                ELSE
                    loc_nQtBaixar  = loc_nQtBaixar - (TempEestI.Qtds - TempEestI.QtProds)
                    loc_nQtBaixado = TempEestI.Qtds - TempEestI.QtProds
                    loc_nPQtd      = TempEestI.Qtds
                ENDIF

                loc_cQuery = "UPDATE SigMvItn SET QtProds = " + FormatarNumeroSQL(loc_nPQtd, 3) + ;
                    ", QtReservas = " + ;
                    IIF(THIS.this_lReserva, FormatarNumeroSQL(loc_nPQtd, 3), ;
                        FormatarNumeroSQL(loc_nQtBaixado, 3)) + ;
                    ", DtAlts = " + FormatarDataSQL(loc_tDay) + ;
                    " WHERE cIdChaves = " + EscaparSQL(loc_cPIds)

                IF !THIS.ExecutarSQL(loc_cQuery, "", "Update - 7")
                    loc_lAbortar = .T.
                    EXIT
                ENDIF

                IF !loc_lTemItem2
                    INSERT INTO crSigBxEst (Emps, Dopes, Numes, CItens, Cpros, Datas, Empbs, ;
                            Dopebs, Numebs, Qtdfs, CidChaves, EmpDopNums, EmpDopNumb) ;
                        VALUES (loc_cEmpr, loc_cDope, loc_nNume, TempEestI.CItens, ;
                            TempEestI.Cpros, loc_dDtGera, TempEestI.Emps, TempEestI.Dopes, ;
                            TempEestI.Numes, loc_nQtBaixado, fUniqueIds(), ;
                            loc_cEmpr + loc_cDope + STR(loc_nNume, 6), ;
                            TempEestI.Emps + TempEestI.Dopes + STR(TempEestI.Numes, 6))
                ENDIF
            ENDSCAN
            IF loc_lAbortar
                EXIT
            ENDIF

            loc_nQtBaixar = TmpEstoque.Estoque

            SELECT TempEsti2
            SCAN WHILE loc_nQtBaixar > 0
                IF (TempEsti2.CodCors != TmpEstoque.CodCors) OR ;
                        (TempEsti2.CodTams != TmpEstoque.CodTams)
                    LOOP
                ENDIF

                loc_cPIds = TempEsti2.cIdChaves

                IF TempEsti2.QtProds + loc_nQtBaixar <= TempEsti2.Qtds
                    loc_nPQtd      = TempEsti2.QtProds + loc_nQtBaixar
                    loc_nQtBaixado = loc_nQtBaixar
                    loc_nQtBaixar  = 0
                ELSE
                    loc_nQtBaixar  = loc_nQtBaixar - (TempEsti2.Qtds - TempEsti2.QtProds)
                    loc_nQtBaixado = TempEsti2.Qtds - TempEsti2.QtProds
                    loc_nPQtd      = TempEsti2.Qtds
                ENDIF

                loc_cQuery = "UPDATE SigMvIts SET QtProds = " + FormatarNumeroSQL(loc_nPQtd, 3) + ;
                    ", QtReservas = " + ;
                    IIF(THIS.this_lReserva, FormatarNumeroSQL(loc_nPQtd, 3), ;
                        FormatarNumeroSQL(loc_nQtBaixado, 3)) + ;
                    ", DtAlts = " + FormatarDataSQL(loc_tDay) + ;
                    " WHERE cIdChaves = " + EscaparSQL(loc_cPIds)

                IF !THIS.ExecutarSQL(loc_cQuery, "", "Update - 8")
                    loc_lAbortar = .T.
                    EXIT
                ENDIF

                INSERT INTO crSigBxEst (Emps, Dopes, Numes, CItens, Cpros, Datas, Empbs, Dopebs, ;
                        Numebs, Qtdfs, CodCors, CodTams, cIdChaves, EmpDopNums, EmpDopNumb) ;
                    VALUES (loc_cEmpr, loc_cDope, loc_nNume, TempEsti2.CItens, TempEsti2.cpros, ;
                        loc_dDtGera, TempEsti2.Emps, TempEsti2.Dopes, TempEsti2.Numes, ;
                        loc_nQtBaixado, TempEsti2.CodCors, TempEsti2.CodTams, fUniqueIds(), ;
                        loc_cEmpr + loc_cDope + STR(loc_nNume, 6), ;
                        TempEsti2.Emps + TempEsti2.Dopes + STR(TempEsti2.Numes, 6))
            ENDSCAN
            IF loc_lAbortar
                EXIT
            ENDIF

            SELECT TmpEstoque
        ENDSCAN
    ENDPROC

    *--------------------------------------------------------------------------
    * ProcessarComponentes - Transcricao do dump 4929-5235. So roda com as
    * tres operacoes de componente configuradas (DopEmphs/DopReqcs/DopPedcs),
    * fora da Reserva Automatica e com geracao de empenho ligada (Emphpdr).
    *
    * Acumula em TmpPedra (necessidade por material), TmpMatPrz (necessidade
    * por prazo de entrega) e TmpEmpH (empenho por material + produto pai) as
    * pedras avulsas (SelPedra) e a composicao de cada produto a produzir;
    * desconta o que ja esta em aberto (empenho/requisicao/pedido/compra/
    * transferencia) e o estoque (SigMvEst); e gera o empenho
    * (SigCdPam.DopEmphs) e a requisicao de compra (SigCdPam.DopReqcs).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ProcessarComponentes()
        LOCAL loc_nQtde, loc_nPeso, loc_cBusca, loc_cQuery, loc_cSql
        LOCAL loc_nX, loc_cOperBusca, loc_cCampo, loc_cEds, loc_cEdn
        LOCAL loc_cCgru, loc_cForn, loc_nQtdEmphs, loc_nQtd, loc_nTotReq, loc_nBaixa
        LOCAL loc_nPesMd, loc_nPesoReq, loc_dDtEnt, loc_lProsseguir

        IF EMPTY(THIS.this_cPamDopEmphs) OR EMPTY(THIS.this_cPamDopReqcs) OR ;
                EMPTY(THIS.this_cPamDopPedcs) OR THIS.this_lReserva OR ;
                EMPTY(THIS.this_nEmphPdr)
            RETURN
        ENDIF

        *-- 1) Pedras/componentes avulsos digitados na grade de Requisicoes
        IF USED("SelPedra")
            SELECT SelPedra
            SCAN
                IF EMPTY(SelPedra.Cpros) OR SelPedra.Qtds <= 0
                    LOOP
                ENDIF

                loc_lProsseguir = THIS.ConsultarTabela("SigCdPro", "crSigCdPro", "CPros", ALLTRIM(SelPedra.Cpros))
                IF loc_lProsseguir
                    loc_lProsseguir = THIS.ConsultarTabela("SigCdUni", "crSigCdUni", "CUnis", ALLTRIM(crSigCdPro.CUnis))
                ENDIF
                IF loc_lProsseguir
                    loc_lProsseguir = THIS.ConsultarTabela("SigCdGrp", "crSigCdGrp", "CGrus", ALLTRIM(crSigCdPro.CGrus))
                ENDIF
                IF !loc_lProsseguir
                    loc_lAbortar = .T.
                    EXIT
                ENDIF

                IF crSigCdGrp.CEstoqs = 1 AND !EMPTY(crSigCdGrp.GruEstps) AND !EMPTY(crSigCdGrp.ConEstps)
                    loc_nQtde = SelPedra.Qtds

                    SELECT TmpPedra
                    IF !SEEK(SelPedra.Cpros)
                        INSERT INTO TmpPedra (Grupos, Contas, cGrus, cMats, QtdMins) ;
                            VALUES (crSigCdGrp.GruEstps, crSigCdGrp.ConEstps, ;
                                crSigCdPro.CGrus, SelPedra.cpros, crSigCdPro.QMins)
                    ENDIF
                    REPLACE Qtds WITH Qtds + loc_nQtde IN TmpPedra

                    *-- Tiago - 13/03/2012 - Vianna: material necessario por
                    *-- prazo de entrega, para gerar requisicao por prazo
                    SELECT TmpMatPrz
                    IF !SEEK(DTOC(DATE()) + SelPedra.Cpros)
                        INSERT INTO TmpMatPrz (cMats, PrazoEnts) ;
                            VALUES (SelPedra.cpros, DATE())
                    ENDIF
                    REPLACE Qtds WITH Qtds + loc_nQtde IN TmpMatPrz

                    SELECT TmpEmpH
                    IF !SEEK(SelPedra.Cpros + SelPedra.Cpro2s)
                        INSERT INTO TmpEmpH (Grupos, Contas, cGrus, cMats, QtdMins, Cpro2s) ;
                            VALUES (crSigCdGrp.GruEstps, crSigCdGrp.ConEstps, ;
                                crSigCdPro.CGrus, SelPedra.cpros, crSigCdPro.QMins, SelPedra.Cpro2s)
                    ENDIF
                    REPLACE Qtds WITH Qtds + loc_nQtde IN TmpEmpH
                ENDIF

                SELECT SelPedra
            ENDSCAN
        ENDIF

        IF loc_lAbortar
            RETURN
        ENDIF

        *-- 2) Composicao dos produtos a produzir
        SELECT TmpFinal
        SET ORDER TO Cpros
        SCAN
            IF TmpFinal.Produzir = 0
                LOOP
            ENDIF

            loc_cSql = "SELECT GerEmphs FROM SigOpCdc WHERE Dopes = " + ;
                EscaparSQL(TmpFinal.Dopes)
            IF !THIS.ExecutarSQL(loc_cSql, "TmpDcOpe", "TmpDcOpe")
                loc_lAbortar = .T.
                EXIT
            ENDIF

            IF TratarNulo(TmpDcOpe.GerEmphs, 0) != 1
                LOOP
            ENDIF

            loc_cEdn   = TmpFinal.Emps + TmpFinal.Dopes + STR(TmpFinal.Numes, 6)
            loc_cBusca = THIS.BuscarCompos(loc_cEdn, TmpFinal.Cpros, TmpFinal.citens, "")
            IF !EMPTY(THIS.this_cMensagemErro)
                loc_lAbortar = .T.
                EXIT
            ENDIF

            IF USED("crSigPrCpo")
                USE IN crSigPrCpo
            ENDIF
            *-- "Select * from &lcBusca. into cursor crSigPrCpo READWRITE" do
            *-- legado, sem macro-substituicao: BuscarCompos() so devolve um
            *-- destes dois nomes (composicao substituida x padrao)
            IF loc_cBusca == "cursor_4c_CompoSub"
                SELECT * FROM cursor_4c_CompoSub INTO CURSOR crSigPrCpo READWRITE
            ENDIF
            IF loc_cBusca == "cursor_4c_CompoPad"
                SELECT * FROM cursor_4c_CompoPad INTO CURSOR crSigPrCpo READWRITE
            ENDIF

            IF USED("crSigPrCpo")
                SELECT crSigPrCpo
                SCAN
                    loc_lProsseguir = THIS.ConsultarTabela("SigCdPro", "crSigCdPro", "CPros", ALLTRIM(crSigPrCpo.Mats))
                    IF loc_lProsseguir
                        loc_lProsseguir = THIS.ConsultarTabela("SigCdUni", "crSigCdUni", "CUnis", ALLTRIM(crSigCdPro.CUnis))
                    ENDIF
                    IF loc_lProsseguir
                        loc_lProsseguir = THIS.ConsultarTabela("SigCdGrp", "crSigCdGrp", "CGrus", ALLTRIM(crSigCdPro.CGrus))
                    ENDIF
                    IF !loc_lProsseguir
                        loc_lAbortar = .T.
                        EXIT
                    ENDIF

                    IF crSigCdGrp.CEstoqs = 1 AND !EMPTY(crSigCdGrp.GruEstps) AND ;
                            !EMPTY(crSigCdGrp.ConEstps)

                        loc_nQtde = TmpFinal.Produzir * crSigPrCpo.Qtds
                        loc_nPeso = TmpFinal.Produzir * CrSigPrCpo.Pesos

                        SELECT TmpPedra
                        IF !SEEK(crSigPrCpo.Mats)
                            INSERT INTO TmpPedra (Grupos, Contas, cGrus, cMats, QtdMins) ;
                                VALUES (crSigCdGrp.GruEstps, crSigCdGrp.ConEstps, ;
                                    crSigCdPro.CGrus, crSigPrCpo.Mats, crSigCdPro.QMins)
                        ENDIF
                        REPLACE Qtds  WITH Qtds  + loc_nQtde, ;
                                Pesos WITH Pesos + loc_nPeso IN TmpPedra

                        *-- Tiago - 13/03/2012 - Vianna: 1 = agrupa por
                        *-- fornecedor + prazo de entrega, 2 = so fornecedor
                        SELECT TmpMatPrz
                        loc_dDtEnt = IIF(THIS.this_nPacAgrupReqs = 1, ;
                            NVL(TmpFinal.Entregas, CTOD("")), DATE())
                        IF !SEEK(DTOC(loc_dDtEnt) + crSigPrCpo.Mats)
                            INSERT INTO TmpMatPrz (cMats, PrazoEnts) ;
                                VALUES (crSigPrCpo.Mats, loc_dDtEnt)
                        ENDIF
                        REPLACE Qtds  WITH Qtds  + loc_nQtde, ;
                                Pesos WITH Pesos + loc_nPeso IN TmpMatPrz

                        SELECT TmpEmpH
                        IF !SEEK(CrSigPrCpo.Mats + CrSigPrCpo.Cpros)
                            INSERT INTO TmpEmpH (Grupos, Contas, cGrus, cMats, QtdMins, Cpro2s) ;
                                VALUES (crSigCdGrp.GruEstps, crSigCdGrp.ConEstps, ;
                                    crSigCdPro.CGrus, crSigPrCpo.Mats, crSigCdPro.QMins, ;
                                    CrSigPrCpo.Cpros)
                        ENDIF
                        REPLACE Qtds  WITH Qtds  + loc_nQtde, ;
                                Pesos WITH Pesos + loc_nPeso IN TmpEmpH
                    ENDIF

                    SELECT crSigPrCpo
                ENDSCAN
                IF loc_lAbortar
                    EXIT
                ENDIF
            ENDIF

            SELECT TmpFinal
        ENDSCAN

        IF loc_lAbortar
            RETURN
        ENDIF

        *-- 3) Desconta o que ja esta em aberto nas 5 operacoes de componente
        *--    (Tiago - 07/07/2015 - ChkSubn = 0 restringe as movimentacoes
        *--    ainda nao baixadas, por desempenho)
        FOR loc_nX = 1 TO 5
            DO CASE
                CASE loc_nX = 1
                    loc_cOperBusca = THIS.this_cPamDopEmphs
                CASE loc_nX = 2
                    loc_cOperBusca = THIS.this_cPamDopReqcs
                CASE loc_nX = 3
                    loc_cOperBusca = THIS.this_cPamDopPedcs
                CASE loc_nX = 4
                    loc_cOperBusca = THIS.this_cPamDopComps
                OTHERWISE
                    loc_cOperBusca = THIS.this_cPamDopTrfCps
            ENDCASE

            *-- lcCampo = 'Qtd' + Iif(X=1,'Emphs',Iif(X=2,'Reqs',
            *--           Iif(X=3,'Pedcs','Comps')))  -> X=4 e X=5 usam QtdComps
            DO CASE
                CASE loc_nX = 1
                    loc_cCampo = "QtdEmphs"
                CASE loc_nX = 2
                    loc_cCampo = "QtdReqs"
                CASE loc_nX = 3
                    loc_cCampo = "QtdPedcs"
                OTHERWISE
                    loc_cCampo = "QtdComps"
            ENDCASE

            IF EMPTY(loc_cOperBusca)
                LOOP
            ENDIF

            loc_cEds = loc_cEmpr + PADR(loc_cOperBusca, 20)

            loc_cQuery = "SELECT * FROM SigMvCab WHERE EmpDopNums BETWEEN " + ;
                EscaparSQL(loc_cEds + "     0") + " AND " + ;
                EscaparSQL(loc_cEds + "999999") + " AND ChkSubn = 0"

            IF !THIS.ExecutarSQL(loc_cQuery, "TempEest", "TempEest")
                loc_lAbortar = .T.
                EXIT
            ENDIF

            SELECT TempEest
            SCAN
                loc_cEdn = TempEest.Emps + TempEest.Dopes + STR(TempEest.Numes, 6)
                IF !THIS.ConsultarTabela("SigMvItn", "TempEestI", "EmpDopNums", loc_cEdn)
                    loc_lAbortar = .T.
                    EXIT
                ENDIF

                SELECT TempEestI
                SCAN
                    IF (TempEestI.Qtds - TempEestI.QtBaixas) > 0
                        SELECT TmpPedra
                        IF SEEK(TempEestI.Cpros)
                            DO CASE
                                CASE loc_cCampo = "QtdEmphs"
                                    REPLACE QtdEmphs WITH QtdEmphs + ;
                                        (TempEestI.Qtds - TempEestI.QtBaixas) IN TmpPedra
                                CASE loc_cCampo = "QtdReqs"
                                    REPLACE QtdReqs WITH QtdReqs + ;
                                        (TempEestI.Qtds - TempEestI.QtBaixas) IN TmpPedra
                                CASE loc_cCampo = "QtdPedcs"
                                    REPLACE QtdPedcs WITH QtdPedcs + ;
                                        (TempEestI.Qtds - TempEestI.QtBaixas) IN TmpPedra
                                OTHERWISE
                                    REPLACE QtdComps WITH QtdComps + ;
                                        (TempEestI.Qtds - TempEestI.QtBaixas) IN TmpPedra
                            ENDCASE
                        ENDIF
                    ENDIF
                    SELECT TempEestI
                ENDSCAN
                IF loc_lAbortar
                    EXIT
                ENDIF
                SELECT TempEest
            ENDSCAN
            IF loc_lAbortar
                EXIT
            ENDIF
        ENDFOR

        IF loc_lAbortar
            RETURN
        ENDIF

        *-- 4) Estoque disponivel dos grupos/contas de componente
        loc_cQuery = "SELECT b.* FROM SigMvEst b" + ;
            " WHERE NOT b.Sqtds = 0 AND b.Grupos + b.Estos IN (" + ;
            "SELECT GruEstps + ConEstPs AS Contas FROM SigCdGrp" + ;
            " WHERE NOT GruEstPs = " + EscaparSQL(SPACE(10)) + ;
            " AND NOT ConEstPs = " + EscaparSQL(SPACE(10)) + ;
            " GROUP BY GruEstPs, ConEstPs)"

        IF !THIS.ExecutarSQL(loc_cQuery, "pEstoque", "pEstoque")
            loc_lAbortar = .T.
            RETURN
        ENDIF
        GO TOP IN pEstoque

        SELECT pEstoque
        SCAN
            SELECT TmpPedra
            *-- Tiago - 17/02/2012 - Vianna: a checagem de estoque tem de
            *-- olhar tambem o grupo/conta configurado no grupo de produtos
            IF SEEK(pEstoque.Cpros + pEstoque.Grupos + pEstoque.Estos, "TmpPedra", "MatGruCon")
                REPLACE QtdEsts WITH QtdEsts + pEstoque.Sqtds IN TmpPedra
            ENDIF
            SELECT pEstoque
        ENDSCAN

        *-- 5) Empenho dos componentes (SigCdPam.DopEmphs)
        SELECT TmpEmpH
        SET ORDER TO GruMat
        GO TOP
        loc_cCgru   = TmpEmpH.CGrus
        loc_nCitens = 9999
        SCAN
            IF !THIS.ConsultarTabela("SigCdPro", "crSigCdPro", "CPros", ALLTRIM(TmpEmpH.CMats))
                loc_lAbortar = .T.
                EXIT
            ENDIF

            IF TmpEmpH.Cgrus != loc_cCgru
                loc_nCitens = 9999
                loc_cCgru   = TmpEmpH.Cgrus
            ENDIF

            IF loc_nCitens >= 9999
                loc_nCitens = 1
                loc_cDope   = PADR(THIS.this_cPamDopEmphs, 20)
                loc_nNume   = fGerUniqueKey(loc_cEmpr + loc_cDope)

                INSERT INTO crSigMvCab (Emps, Dopes, Numes, MascNum, Datas, Datars, Usuars, ;
                        Grupoos, Contaos, Nops, Obses, EmpDopNums, cIdChaves, DtAlts) ;
                    VALUES (loc_cEmpr, loc_cDope, loc_nNume, ALLTRIM(fGerMascara(loc_nNume)), ;
                        loc_dDtGera, DATETIME(), loc_cUsuar, TmpEmpH.Grupos, TmpEmpH.contas, ;
                        loc_nNump, "[ OP: " + STR(loc_nNump) + "] ", ;
                        loc_cEmpr + loc_cDope + STR(loc_nNume, 6), fUniqueIds(), DATETIME())
            ENDIF

            INSERT INTO crTpmMvItn (Emps, Dopes, Numes, CPros, Qtds, Cunis, DPros, Opers, ;
                    Citens, cPro2s, Pesos, cUnips) ;
                VALUES (loc_cEmpr, loc_cDope, loc_nNume, TmpEmpH.cMats, TmpEmpH.Qtds, ;
                    crSigCdPro.Cunis, crSigCdPro.Dpros, "S", loc_nCitens, TmpEmpH.Cpro2s, ;
                    TmpEmpH.Pesos, CrSigCdPro.cUniPs)

            loc_nCitens = loc_nCitens + 1
            SELECT TmpEmpH
        ENDSCAN

        IF loc_lAbortar
            RETURN
        ENDIF

        *-- 6) Quantidade a requisitar por material (QtdGReqs)
        SELECT TmpPedra
        SCAN
            *-- Tiago - 19/08: nao checa estoque se a operacao de Requisicao
            *-- estiver configurada para nao checar (SigOpCdc.VerEsts = 2)
            loc_cDope = PADR(THIS.this_cPamDopReqcs, 20)

            loc_lProsseguir = THIS.ConsultarTabela("SigOpCdd", "crSigOpCdd", "Dopes", ;
                ALLTRIM(loc_cDope), "ChkResComp")
            IF loc_lProsseguir
                loc_lProsseguir = THIS.ConsultarTabela("SigOpCdc", "crSigOpCdc", "Dopes", ;
                    ALLTRIM(loc_cDope), "verests")
            ENDIF
            IF !loc_lProsseguir
                loc_lAbortar = .T.
                EXIT
            ENDIF

            IF TratarNulo(crSigOpCdc.verests, 0) != 2

                *-- Rafael - 04/07/2016 - quantidade de pecas ja requisitadas
                *-- para o componente
                loc_nQtdEmphs = 0
                loc_cQuery = "select Isnull(SUM(qtds),0) - Isnull(SUM(qtbaixas),0) as Qtds" + ;
                    " from SigMvItn where empdopnums in(" + ;
                    " select empdopnums from SigMvCab where empdopnums in(" + ;
                    " SELECT distinct EmpDopNums FROM SigBxEst" + ;
                    " WHERE dopebs = " + EscaparSQL(ALLTRIM(loc_cDope)) + ;
                    " and cpros = " + EscaparSQL(TmpPedra.CMats) + " and qtdes > 0 )" + ;
                    " and chksubn = 0) and cpros = " + EscaparSQL(TmpPedra.CMats) + ;
                    " And chksubn = 0 "

                IF !THIS.ExecutarSQL(loc_cQuery, "pQtdsReq", "pQtdsReq")
                    loc_lAbortar = .T.
                    EXIT
                ENDIF

                loc_nQtdEmphs = IIF(TratarNulo(pQtdsReq.Qtds, 0) > 0, TratarNulo(pQtdsReq.Qtds, 0), 0)

                IF TratarNulo(crSigOpCdd.ChkResComp, 0) != 1
                    loc_nQtd = TmpPedra.Qtds - (TmpPedra.QtdEsts - TmpPedra.QtdMins + ;
                        TmpPedra.QtdReqs + TmpPedra.QtdPedcs + TmpPedra.QtdComps - ;
                        TmpPedra.QtdEmphs + loc_nQtdEmphs)
                ELSE
                    loc_nQtd = (TmpPedra.Qtds - TmpPedra.QtdEsts)
                ENDIF

                IF loc_nQtd > 0
                    REPLACE QtdgReqs WITH loc_nQtd IN TmpPedra
                ENDIF
            ELSE
                *-- Tiago - 06/12/2011 - Muredu: sem checagem de estoque, gera
                *-- requisicao de toda a composicao
                REPLACE QtdgReqs WITH TmpPedra.Qtds IN TmpPedra
            ENDIF

            SELECT TmpPedra
        ENDSCAN

        IF loc_lAbortar
            RETURN
        ENDIF

        *-- 7) Requisicao de compra (SigCdPam.DopReqcs), por fornecedor + prazo
        SELECT TmpPedra
        SET ORDER TO GruMat
        GO TOP
        loc_cCgru = TmpPedra.CGrus

        *-- Tiago - 31/01/2011 - requisicao por fornecedor
        IF !THIS.ConsultarTabela("SigCdPro", "crTmpPro", "CPros", ALLTRIM(TmpPedra.CMats), "ifors")
            loc_lAbortar = .T.
            RETURN
        ENDIF
        loc_cForn = PADR(crTmpPro.Ifors, 10)

        loc_nCitens = 9999
        SELECT TmpPedra
        SCAN
            IF TmpPedra.QtdGreqs <= 0
                LOOP
            ENDIF
            loc_nTotReq = TmpPedra.QtdGreqs

            loc_lProsseguir = THIS.ConsultarTabela("SigCdPro", "crSigCdPro", "CPros", ALLTRIM(TmpPedra.CMats))
            IF loc_lProsseguir
                loc_lProsseguir = THIS.ConsultarTabela("SigCdUni", "LocalUni", "CUnis", ;
                    ALLTRIM(crSigCdPro.CUniPs), "Fators")
            ENDIF
            IF !loc_lProsseguir
                loc_lAbortar = .T.
                EXIT
            ENDIF

            DO WHILE loc_nTotReq > 0 AND !loc_lAbortar
                SELECT TmpMatPrz
                SCAN FOR TmpMatPrz.CMats = TmpPedra.CMats
                    IF TmpMatPrz.Qtds - TmpMatPrz.QtBaixas > 0
                        EXIT
                    ENDIF
                ENDSCAN

                loc_nBaixa = IIF(TmpMatPrz.Qtds > TmpMatPrz.QtBaixas AND ;
                    loc_nTotReq >= TmpMatPrz.Qtds, ;
                    (TmpMatPrz.Qtds - TmpMatPrz.QtBaixas), loc_nTotReq)
                loc_nTotReq = loc_nTotReq - loc_nBaixa
                REPLACE TmpMatPrz.QtBaixas WITH TmpMatPrz.QtBaixas + loc_nBaixa IN TmpMatPrz

                SELECT crSigMvCab
                GO TOP
                LOCATE FOR crSigMvCab.Dopes = PADR(THIS.this_cPamDopReqcs, 20) ;
                       AND crSigMvCab.PrazoEnts = IIF(EMPTY(TmpMatPrz.PrazoEnts), DATE(), ;
                            TmpMatPrz.PrazoEnts) ;
                       AND crSigMvCab.ContaDs = PADR(crSigCdPro.Ifors, 10)
                IF !EOF("crSigMvCab")
                    loc_cDope = crSigMvCab.Dopes
                    loc_nNume = crSigMvCab.Numes

                    SELECT MAX(Citens) AS Citens FROM crTpmMvItn ;
                        WHERE crTpmMvItn.Emps = m.loc_cEmpr ;
                          AND crTpmMvItn.Dopes = m.loc_cDope ;
                          AND crTpmMvItn.Numes = m.loc_nNume ;
                        INTO CURSOR TmpUltItn
                    loc_nCitens = NVL(TmpUltItn.Citens, 0) + 1
                ELSE
                    loc_nCitens = 9999
                    loc_cCgru   = TmpPedra.Cgrus
                    loc_cForn   = PADR(crSigCdPro.Ifors, 10)
                ENDIF

                IF loc_nCitens >= 9999
                    loc_nCitens = 1
                    loc_cDope   = PADR(THIS.this_cPamDopReqcs, 20)
                    loc_nNume   = fGerUniqueKey(loc_cEmpr + loc_cDope)

                    IF !THIS.ConsultarTabela("SigCdOpe", "crSigCdOpe", "Dopes", ALLTRIM(loc_cDope))
                        loc_lAbortar = .T.
                        EXIT
                    ENDIF
                    loc_cForn = PADR(IIF(!EMPTY(loc_cForn), loc_cForn, crSigCdOpe.ConOrigs), 10)

                    INSERT INTO crSigMvCab (Emps, Dopes, Numes, MascNum, Datas, Datars, Usuars, ;
                            Grupoos, Contaos, Grupods, Contads, Nops, Obses, Empdopnums, ;
                            cIdChaves, DtAlts, PrazoEnts) ;
                        VALUES (loc_cEmpr, loc_cDope, loc_nNume, ALLTRIM(fGerMascara(loc_nNume)), ;
                            loc_dDtGera, DATETIME(), loc_cUsuar, crSigCdOpe.GruOrigs, loc_cForn, ;
                            crSigCdOpe.GruDests, crSigCdOpe.ConDests, loc_nNump, ;
                            "[ OP: " + STR(loc_nNump) + "] ", ;
                            loc_cEmpr + loc_cDope + STR(loc_nNume, 6), fUniqueIds(), DATETIME(), ;
                            TmpMatPrz.PrazoEnts)
                ENDIF

                *-- Tiago - 12/04/2011 - Vianna: com o fator da segunda unidade
                *-- em 0 ou 1 o campo Peso controla QUANTIDADE, entao nao ha
                *-- calculo de peso total
                loc_nPesMd = IIF(TmpPedra.Pesos = 0, 0, ;
                    IIF(INLIST(TratarNulo(LocalUni.Fators, 0), 0, 1), ;
                        (TmpPedra.Qtds / TmpPedra.Pesos), (TmpPedra.Pesos / TmpPedra.Qtds)))
                loc_nPesoReq = IIF(INLIST(TratarNulo(LocalUni.Fators, 0), 0, 1), ;
                    TmpPedra.Pesos, ROUND(loc_nBaixa * loc_nPesMd, 3))

                INSERT INTO crTpmMvItn (Emps, Dopes, Numes, CPros, Qtds, Cunis, DPros, Opers, ;
                        Citens, Pesos, cUniPs) ;
                    VALUES (loc_cEmpr, loc_cDope, loc_nNume, TmpPedra.cMats, loc_nBaixa, ;
                        crSigCdPro.Cunis, crSigCdPro.Dpros, "S", loc_nCitens, loc_nPesoReq, ;
                        CrSigCdPro.cUniPs)

                loc_nCitens = loc_nCitens + 1
            ENDDO

            IF loc_lAbortar
                EXIT
            ENDIF
            SELECT TmpPedra
        ENDSCAN
    ENDPROC

    *--------------------------------------------------------------------------
    * ConsolidarMovimentoItens - Transcricao do dump 5237-5252. Transfere os
    * cursores de trabalho crTpmMvItn/crTplMvIts (itens montados ao longo do
    * processamento) para os cursores de GRAVACAO crSigMvItn/crSigMvIts,
    * gerando cIdChaves e EmpDopNums de cada linha.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConsolidarMovimentoItens()

        SELECT crTpmMvItn
        SCAN
            INSERT INTO crSigMvItn (Emps, Dopes, Numes, CPros, Qtds, Cunis, DPros, Opers, ;
                    Citens, EmpDopNums, CidChaves, DtAlts, cpro2s, Pesos, cUniPs, Obs) ;
                VALUES (crTpmMvItn.Emps, crTpmMvItn.Dopes, crTpmMvItn.Numes, crTpmMvItn.CPros, ;
                    crTpmMvItn.Qtds, crTpmMvItn.Cunis, crTpmMvItn.Dpros, crTpmMvItn.Opers, ;
                    crTpmMvItn.citens, ;
                    crTpmMvItn.Emps + crTpmMvItn.Dopes + STR(crTpmMvItn.Numes, 6), ;
                    fUniqueIds(), DATETIME(), crTpmMvItn.Cpro2s, crTpmMvItn.Pesos, ;
                    crTpmMvItn.cUniPs, crTpmMvItn.Obs)
            SELECT crTpmMvItn
        ENDSCAN

        SELECT crTplMvIts
        SCAN
            INSERT INTO crSigMvIts (cItens, Emps, Dopes, Numes, CPros, Qtds, CodCors, CodTams, ;
                    CidChaves, EmpDopNums, QtdEmbs) ;
                VALUES (crTplMvIts.Citens, crTplMvIts.Emps, crTplMvIts.Dopes, crTplMvIts.Numes, ;
                    crTplMvIts.CPros, crTplMvIts.Qtds, crTplMvIts.CodCors, crTplMvIts.CodTams, ;
                    fUniqueIds(), ;
                    crTplMvIts.Emps + crTplMvIts.Dopes + STR(crTplMvIts.Numes, 6), 1)
            SELECT crTplMvIts
        ENDSCAN
    ENDPROC

    *--------------------------------------------------------------------------
    * ProcessarEntradaAutomatica - Transcricao do dump 5254-5417. So roda com
    * SigCdPam.DopEntAus + SigCdPam.TpOpEntAus configurados e DBParam.EntPes=1
    * (o "entrega peso" do tipo de geracao da O.P.): transfere GrSigCdNei para
    * o cursor de gravacao crSigCdNei, criando a necessidade (crSigCdNec) e o
    * historico de estoque (crSigMvHst) da operacao de entrada automatica.
    *
    * Dois ramos, conforme a operacao (SigCdOpd) tenha ou nao grupo/conta de
    * DESTINO: com destino, tudo eh agrupado numa unica necessidade; sem
    * destino, ha uma necessidade por combinacao Dopps+origem+destino.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ProcessarEntradaAutomatica()
        LOCAL loc_cTpOp, loc_nTPesoAc, loc_lGravou, loc_cMat, loc_nQtde, loc_nPesoIt
        LOCAL loc_cOper, loc_cIds, loc_nEnv, loc_nPesoAc

        loc_cDopEntAu = PADR(THIS.this_cPamDopEntAus, 20)
        loc_cTpOp     = THIS.this_cPamTpOpEntAus

        IF EMPTY(loc_cDopEntAu) OR EMPTY(loc_cTpOp) OR THIS.this_nDbEntPes != 1
            RETURN
        ENDIF

        SELECT crSigCdNec
        INDEX ON EmpDnPs TAG EmpDnPs
        INDEX ON Dopps + GrupoOs + ContaOs + GrupoDs + ContaDs TAG DopEntAu

        SELECT GrSigCdNei
        LOCATE FOR .F.

        IF !THIS.ConsultarTabela("SigCdOpd", "crSigCdOpd", "Dopps", ALLTRIM(loc_cDopEntAu), ;
                "Dopps, GruOrigs, ConOrigs, GruDests, ConDests, Origems, Destinos, EstOrigs, EstDests")
            loc_lAbortar = .T.
            RETURN
        ENDIF

        IF !EMPTY(crSigCdOpd.GruDests) AND !EMPTY(crSigCdOpd.ConDests)

            loc_cGrupoC = PADR(crSigCdOpd.GruOrigs, 10)
            loc_cContaC = PADR(crSigCdOpd.ConOrigs, 10)
            loc_cGrupoD = PADR(crSigCdOpd.GruDests, 10)
            loc_cContaD = PADR(crSigCdOpd.ConDests, 10)

            loc_nNumEntAu = fGerUniqueKey(ALLTRIM(loc_cDopEntAu))

            IF USED("TmpNensi")
                USE IN TmpNensi
            ENDIF
            SELECT Cmats, Cdescs, cUnis, TpOps, Nops, Nenvs, SUM(Pesos) AS Pesos, ;
                    SUM(Qtds) AS Qtds, SUM(Peso2s) AS Peso2s ;
                FROM GrSigCdNei INTO CURSOR TmpNensi GROUP BY 1, 2, 3, 4, 5, 6

            SELECT TmpNensi

            loc_nTPesoAc = 0
            loc_lGravou  = .F.

            SCAN
                loc_lGravou = .T.
                loc_cMat    = TmpNensi.Cmats

                IF !THIS.ConsultarTabela("SigCdPro", "crSigCdPro", "Cpros", ALLTRIM(loc_cMat), ;
                        "Cpros, Dpros, Cunis, MatPrincs")
                    loc_lAbortar = .T.
                    EXIT
                ENDIF

                INSERT INTO crSigCdNei (Emps, Dopps, Numps, Cmats, Cdescs, cUnis, Pesos, Qtds, ;
                        TpOps, EmpDNps, cIdChaves, Peso2s, Nenvs, Nops) ;
                    VALUES (loc_cEmpr, loc_cDopEntAu, loc_nNumEntAu, TmpNensi.Cmats, ;
                        TmpNensi.cDescs, TmpNensi.Cunis, TmpNensi.Pesos, TmpNensi.Qtds, ;
                        THIS.this_cPamTpOpEntAus, ;
                        loc_cEmpr + loc_cDopEntAu + STR(loc_nNumEntAu, 10), fUniqueIds(), ;
                        TmpNensi.peso2s, TmpNensi.Nenvs, TmpNensi.Nops)

                loc_nTPesoAc = loc_nTPesoAc + TmpNensi.Pesos
                loc_nQtde    = TmpNensi.Qtds
                loc_nPesoIt  = TmpNensi.Peso2s

                IF crSigCdOpd.Origems = 1 AND INLIST(crSigCdOpd.EstOrigs, 1, 2)
                    loc_cOper = IIF(crSigCdOpd.EstOrigs = 1, "E", "S")
                    *-- DtAudits: o legado grava Null; {} persiste como NULL
                    *-- identico (FormatarDataSQL trata os dois casos)
                    INSERT INTO crSigMvHst (Empos, Emps, Dopes, Numes, Datars, Datas, DtAudits, ;
                            Grupos, Estos, Cpros, Opers, Qtds, cidChaves, empdopnums, ;
                            empgruests, OriDopNums, Seqs, Pesos) ;
                        VALUES (loc_cEmpr, loc_cEmpr, loc_cDopEntAu, loc_nNumEntAu, DATE(), ;
                            DATE(), {}, loc_cGrupoC, loc_cContaC, loc_cMat, loc_cOper, ;
                            loc_nQtde, " ", ;
                            loc_cEmpr + loc_cDopEntAu + STR(loc_nNumEntAu, 6), ;
                            loc_cEmpr + loc_cGrupoC + loc_cContaC, ;
                            loc_cEmpr + loc_cDopEntAu + STR(loc_nNumEntAu, 6), 0, loc_nPesoIt)

                    *-- fRecalculaP/fRecalculaC: omitido (ver NOTA DE ESCOPO)
                ENDIF

                IF crSigCdOpd.Destinos = 1 AND INLIST(crSigCdOpd.EstDests, 1, 2)
                    loc_cOper = IIF(crSigCdOpd.EstDests = 1, "E", "S")
                    INSERT INTO crSigMvHst (Empos, Emps, Dopes, Numes, Datars, Datas, DtAudits, ;
                            Grupos, Estos, Cpros, Opers, Qtds, cidchaves, empdopnums, ;
                            empgruests, OriDopNums, Seqs, Pesos) ;
                        VALUES (loc_cEmpr, loc_cEmpr, loc_cDopEntAu, loc_nNumEntAu, DATE(), ;
                            DATE(), {}, loc_cGrupoD, loc_cContaD, loc_cMat, loc_cOper, ;
                            loc_nQtde, " ", ;
                            loc_cEmpr + loc_cDopEntAu + STR(loc_nNumEntAu, 6), ;
                            loc_cEmpr + loc_cGrupoD + loc_cContaD, ;
                            loc_cEmpr + loc_cDopEntAu + STR(loc_nNumEntAu, 6), 0, loc_nPesoIt)

                    *-- fRecalculaP/fRecalculaC: omitido (ver NOTA DE ESCOPO)
                ENDIF

                SELECT TmpNensi
            ENDSCAN

            IF loc_lAbortar
                RETURN
            ENDIF

            IF loc_lGravou
                loc_cIds = DTOS(DATE()) + ;
                    TRANSFORM(fGerUniqueKey(DTOS(DATE())), "@L 999999") + THIS.this_cSigKey

                INSERT INTO crSigCdNec (Emps, Dopps, Numps, Datars, Datas, Usuars, Grupoos, ;
                        Contaos, Grupods, Contads, TotPesos, Nops, cIdChaves, EmpDNps) ;
                    VALUES (loc_cEmpr, loc_cDopEntAu, loc_nNumEntAu, DATETIME(), DATETIME(), ;
                        loc_cUsuar, loc_cGrupoC, loc_cContaC, loc_cGrupoD, loc_cContaD, ;
                        loc_nTPesoAc, loc_nNumpe, loc_cIds, ;
                        loc_cEmpr + loc_cDopEntAu + STR(loc_nNumEntAu, 10))
            ENDIF

        ELSE

            IF USED("TmpNensi")
                USE IN TmpNensi
            ENDIF
            SELECT * FROM GrSigCdNei INTO CURSOR TmpNensi ORDER BY EmpDnPs, Nops

            loc_nPesoAc  = 0
            loc_nTPesoAc = 0

            SELECT TmpNensi
            SCAN
                loc_nEnv = TmpNensi.nEnvs

                = SEEK(TmpNensI.EmpDnPs, "crSigCdNec", "EmpDnPs")

                loc_cGrupoC = PADR(crSigCdNec.GrupoOs, 10)
                loc_cContaC = PADR(crSigCdNec.ContaOs, 10)
                loc_cGrupoD = PADR(IIF(!EMPTY(crSigCdOpd.GruDests), crSigCdOpd.GruDests, ;
                    crSigCdNec.GrupoDs), 10)
                loc_cContaD = PADR(crSigCdNec.ContaDs, 10)

                IF !SEEK(loc_cDopEntAu + loc_cGrupoC + loc_cContaC + loc_cGrupoD + loc_cContaD, ;
                        "crSigCdNec", "DopEntAu")

                    loc_nNumEntAu = fGerUniqueKey(ALLTRIM(loc_cDopEntAu))
                    loc_cIds = DTOS(DATE()) + ;
                        TRANSFORM(fGerUniqueKey(DTOS(DATE())), "@L 999999") + THIS.this_cSigKey

                    INSERT INTO crSigCdNec (Emps, Dopps, Numps, Datars, Datas, Usuars, Grupoos, ;
                            Contaos, Grupods, Contads, TotPesos, Nops, cIdChaves, EmpDNps, Docus) ;
                        VALUES (loc_cEmpr, loc_cDopEntAu, loc_nNumEntAu, DATETIME(), DATETIME(), ;
                            loc_cUsuar, loc_cGrupoC, loc_cContaC, loc_cGrupoD, loc_cContaD, ;
                            loc_nTPesoAc, loc_nNumpe, loc_cIds, ;
                            loc_cEmpr + loc_cDopEntAu + STR(loc_nNumEntAu, 10), STR(loc_nNumpe))

                    loc_nPesoAc  = 0
                    loc_nTPesoAc = 0
                ENDIF

                SELECT TmpNensi
                loc_nQtde   = TmpNensi.Qtds
                loc_nPesoIt = TmpNensi.Peso2s
                loc_cMat    = TmpNensi.cMats

                loc_nTPesoAc = loc_nTPesoAc + TmpNensi.Pesos

                IF !THIS.ConsultarTabela("SigCdPro", "crSigCdPro", "Cpros", ALLTRIM(loc_cMat), ;
                        "Cpros, Dpros, Cunis, MatPrincs")
                    loc_lAbortar = .T.
                    EXIT
                ENDIF

                INSERT INTO crSigCdNei (Emps, Dopps, Numps, Cmats, Cdescs, cUnis, Pesos, Qtds, ;
                        TpOps, EmpDNps, cIdChaves, nenvs, Peso2s, Nops) ;
                    VALUES (loc_cEmpr, loc_cDopEntAu, loc_nNumEntAu, loc_cMat, crSigCdPro.Dpros, ;
                        crSigCdPro.Cunis, TmpNensi.Pesos, TmpNensi.Qtds, ;
                        THIS.this_cPamTpOpEntAus, ;
                        loc_cEmpr + loc_cDopEntAu + STR(loc_nNumEntAu, 10), fUniqueIds(), ;
                        loc_nEnv, TmpNensi.Peso2s, TmpNensi.Nops)

                IF crSigCdOpd.Origems = 1 AND INLIST(crSigCdOpd.EstOrigs, 1, 2)
                    loc_cOper = IIF(crSigCdOpd.EstOrigs = 1, "E", "S")
                    INSERT INTO crSigMvHst (Empos, Emps, Dopes, Numes, Datars, Datas, DtAudits, ;
                            Grupos, Estos, Cpros, Opers, Qtds, cidChaves, empdopnums, ;
                            empgruests, OriDopNums, Seqs, Pesos) ;
                        VALUES (loc_cEmpr, loc_cEmpr, loc_cDopEntAu, loc_nNumEntAu, DATE(), ;
                            DATE(), {}, loc_cGrupoC, loc_cContaC, loc_cMat, loc_cOper, ;
                            loc_nQtde, " ", ;
                            loc_cEmpr + loc_cDopEntAu + STR(loc_nNumEntAu, 6), ;
                            loc_cEmpr + loc_cGrupoC + loc_cContaC, ;
                            loc_cEmpr + loc_cDopEntAu + STR(loc_nNumEntAu, 6), 0, loc_nPesoIt)

                    *-- fRecalculaP/fRecalculaC: omitido (ver NOTA DE ESCOPO)
                ENDIF

                IF crSigCdOpd.Destinos = 1 AND INLIST(crSigCdOpd.EstDests, 1, 2)
                    loc_cOper = IIF(crSigCdOpd.EstDests = 1, "E", "S")
                    INSERT INTO crSigMvHst (Empos, Emps, Dopes, Numes, Datars, Datas, DtAudits, ;
                            Grupos, Estos, Cpros, Opers, Qtds, cidchaves, empdopnums, ;
                            empgruests, OriDopNums, Seqs, Pesos) ;
                        VALUES (loc_cEmpr, loc_cEmpr, loc_cDopEntAu, loc_nNumEntAu, DATE(), ;
                            DATE(), {}, loc_cGrupoD, loc_cContaD, loc_cMat, loc_cOper, ;
                            loc_nQtde, " ", ;
                            loc_cEmpr + loc_cDopEntAu + STR(loc_nNumEntAu, 6), ;
                            loc_cEmpr + loc_cGrupoD + loc_cContaD, ;
                            loc_cEmpr + loc_cDopEntAu + STR(loc_nNumEntAu, 6), 0, loc_nPesoIt)

                    *-- fRecalculaP/fRecalculaC: omitido (ver NOTA DE ESCOPO)
                ENDIF

                SELECT TmpNensi
            ENDSCAN
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * GravarMovimentos - Transcricao do dump 5419-5479: chaves primarias do
    * historico (GravaHis) e gravacao efetiva dos nove cursores nas tabelas,
    * tudo em UMA transacao manual (a conexao deste ambiente nasce com
    * Transactions = 2), como o Commit()/RollBack() unico do legado.
    *
    * NAO transcrito: "Select Min(Datas) as Datas From CrSigMvCab Into Cursor
    * TmpGdm" (linha 5423) - o cursor TmpGdm eh criado e NUNCA lido, nem aqui
    * nem no resto do form (conferido no dump inteiro).
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION GravarMovimentos()
        LOCAL loc_lErro

        SELECT crSigMvHst
        GO TOP
        IF !THIS.GravaHis()
            = SQLROLLBACK(gnConnHandle)
            RETURN .F.
        ENDIF

        loc_lErro = .F.

        IF !loc_lErro AND !THIS.PersistirCursor("crSigOpPic", "SigOpPic")
            loc_lErro = .T.
        ENDIF
        IF !loc_lErro AND !THIS.PersistirCursor("crSigPdMvf", "SigPdMvf")
            loc_lErro = .T.
        ENDIF
        IF !loc_lErro AND !THIS.PersistirCursor("crSigCdNec", "SigCdNec")
            loc_lErro = .T.
        ENDIF
        IF !loc_lErro AND !THIS.PersistirCursor("crSigCdNei", "SigCdNei")
            loc_lErro = .T.
        ENDIF
        IF !loc_lErro AND !THIS.PersistirCursor("crSigMvCab", "SigMvCab")
            loc_lErro = .T.
        ENDIF
        IF !loc_lErro AND !THIS.PersistirCursor("crSigMvHst", "SigMvHst")
            loc_lErro = .T.
        ENDIF
        IF !loc_lErro AND !THIS.PersistirCursor("crSigBxEst", "SigBxEst")
            loc_lErro = .T.
        ENDIF
        IF !loc_lErro AND !THIS.PersistirCursor("crSigMvItn", "SigMvItn")
            loc_lErro = .T.
        ENDIF
        IF !loc_lErro AND !THIS.PersistirCursor("crSigMvIts", "SigMvIts")
            loc_lErro = .T.
        ENDIF

        *-- fRecalculaP(.t., poDataMgr) / fRecalculaC(.t.,.f.,.f., poDataMgr):
        *-- omitidos (ver NOTA DE ESCOPO). Nao marcam llErro - abortar por
        *-- causa de uma funcao inexistente desfaria toda a geracao da O.P.

        IF !loc_lErro
            IF SQLCOMMIT(gnConnHandle) < 1
                THIS.this_cMensagemErro = "Favor Reinicializar o Processo!!!" + CHR(13) + ;
                    "(Commit) " + CapturarErroSQL()
                loc_lErro = .T.
            ENDIF
        ENDIF

        IF loc_lErro
            = SQLROLLBACK(gnConnHandle)
        ENDIF

        RETURN !loc_lErro
    ENDFUNC

    *--------------------------------------------------------------------------
    * ProcessarModoAutomatico - Transcricao do dump 5491-5891 ("If ThisForm.
    * automatico ... EndIf"). Gera automaticamente o fluxo de fases de
    * producao da O.P. recem-criada: para cada item da O.P. (TmpOpi) percorre
    * a sequencia de fases da linha (SigCdLnf), criando a necessidade
    * (crSigCdNec), o programa de fases (crSigPdMvf), os componentes de cada
    * fase (crSigCdNei) e o historico de estoque (crSigMvHst), e grava tudo
    * numa SEGUNDA transacao.
    *
    * As quatro validacoes de operacao automatica (SigCdOpd.Autos = 1 de
    * Movimento e = 2 de Encerramento, exigindo EXATAMENTE uma de cada) viram
    * this_cMensagemErro + retorno .F., no lugar dos MessageBox + Cancelar.
    * Click() + Return 0 do legado. O fechamento da tela fica no FORM.
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION ProcessarModoAutomatico()
        LOCAL loc_lOk, loc_lErro, loc_cSql, loc_cGrpO, loc_cCtaO, loc_cGrpD, loc_cCtaD
        LOCAL loc_dDtGe, loc_cUsuarLin, loc_nQtAnt, loc_nPsAnt, loc_nTran, loc_nInicio
        LOCAL loc_cIds, loc_cOper, loc_cXOper
        LOCAL ARRAY loc_aNensi[1, 18]

        loc_lOk   = .T.
        loc_lErro = .F.

        *-- Operacao de producao automatica de MOVIMENTO (Autos = 1)
        IF !THIS.ExecutarSQL("Select dopps From SigCdOpd where Autos = 1 ", ;
                "CrSigCdOpd", "CrSigCdOpd - Autos 1")
            RETURN .F.
        ENDIF
        IF RECCOUNT("CrSigCdOpd") = 0
            THIS.this_cMensagemErro = "Nenhuma Opera" + CHR(231) + CHR(227) + ;
                "o de Produ" + CHR(231) + CHR(227) + "o definida como autom" + CHR(225) + ;
                "tica de Movimento!!!"
            RETURN .F.
        ENDIF
        IF RECCOUNT("CrSigCdOpd") > 1
            THIS.this_cMensagemErro = "Mais de Uma Opera" + CHR(231) + CHR(227) + ;
                "o de Produ" + CHR(231) + CHR(227) + "o definida como autom" + CHR(225) + ;
                "tica de Movimento!!!"
            RETURN .F.
        ENDIF
        GO TOP IN CrSigCdOpd

        *-- Operacao de producao automatica de ENCERRAMENTO (Autos = 2)
        IF !THIS.ExecutarSQL("Select Dopps From SigCdOpd Where Autos = 2 ", ;
                "CrTmpOpp", "CrTmpOpp - Autos 2")
            RETURN .F.
        ENDIF
        IF RECCOUNT("CrTmpOpp") = 0
            THIS.this_cMensagemErro = "Nenhuma Opera" + CHR(231) + CHR(227) + ;
                "o de Produ" + CHR(231) + CHR(227) + "o definida como autom" + CHR(225) + ;
                "tica de Encerramento!!!"
            RETURN .F.
        ENDIF
        IF RECCOUNT("CrTmpOpp") > 1
            THIS.this_cMensagemErro = "Mais de Uma Opera" + CHR(231) + CHR(227) + ;
                "o de Produ" + CHR(231) + CHR(227) + "o definida como autom" + CHR(225) + ;
                "tica de Encerramento!!!"
            RETURN .F.
        ENDIF
        GO TOP IN CrTmpOpp
        loc_cDpTrf = PADR(CrTmpOpp.Dopps, 20)

        *-- Reabre os quatro cursores de gravacao (o legado faz Zap) e cria
        *-- os indices que este bloco usa
        IF !THIS.AbrirCursorTabela("crSigPdMvf", "SigPdMvf")
            RETURN .F.
        ENDIF
        SELECT crSigPdMvf
        INDEX ON nTrans TAG nTrans

        IF !THIS.AbrirCursorTabela("crSigCdNec", "SigCdNec")
            RETURN .F.
        ENDIF
        SELECT crSigCdNec
        INDEX ON Grupoos + contaOs + GrupoDs + ContaDs + DTOS(Datas) + STR(nAceites, 10) TAG Gravacao

        IF !THIS.AbrirCursorTabela("crSigCdNei", "SigCdNei")
            RETURN .F.
        ENDIF
        SELECT crSigCdNei
        INDEX ON nTrans TAG nTrans

        IF !THIS.AbrirCursorTabela("crSigMvHst", "SigMvHst")
            RETURN .F.
        ENDIF

        SELECT crSigCdNei
        = AFIELDS(loc_aNensi, "crSigCdNei")
        IF USED("xNensi")
            USE IN xNensi
        ENDIF
        CREATE CURSOR xNensi FROM ARRAY loc_aNensi

        *-- Fases de producao por linha
        IF !THIS.ExecutarSQL("Select * From SigCdLnf ", "cursor_4c_LinfTmp", "TmpLinf")
            RETURN .F.
        ENDIF
        IF USED("TmpLinF")
            USE IN TmpLinF
        ENDIF
        SELECT * FROM cursor_4c_LinfTmp INTO CURSOR TmpLinF READWRITE
        USE IN cursor_4c_LinfTmp
        SELECT TmpLinF
        INDEX ON Linhas + STR(Ordems, 2) TAG Linhas

        loc_nNopI = (loc_nNump * 10000) + 1
        loc_nNopF = (loc_nNump * 10000) + 9999
        loc_nSeq  = 1

        *-- ATENCAO - CORRECAO DE DEFEITO DO LEGADO: a consulta original
        *-- (dump 5554-5555) NAO traz EmpDopNums nem Citens, mas a consulta de
        *-- composicao logo abaixo (5566) referencia TmpOpi.empdopnums e
        *-- TmpOpi.citens - em VFP isso estoura "Variable not found" em
        *-- runtime. As duas colunas foram acrescentadas como MAX(), e NAO no
        *-- GROUP BY, justamente para NAO alterar a granularidade do
        *-- agrupamento original (dentro de um mesmo Nops/Cpros/CodTams as
        *-- linhas de SigOpPic compartilham a mesma origem).
        loc_cSql = "Select a.Cpros, a.Nops, b.Linhas, b.cUnis, a.EmpdopNops, a.CodTams," + ;
            " MAX(a.EmpDopNums) as EmpDopNums, MAX(a.Citens) as Citens," + ;
            " sum(a.Qtds) as Qtds, Sum(a.Pesos) as Pesos From SigOpPic a, SigCdPro b " + ;
            "Where a.Nops Between " + FormatarNumeroSQL(loc_nNopI, 0) + " And " + ;
            FormatarNumeroSQL(loc_nNopF, 0) + " And a.cpros = b.cpros " + ;
            "Group by a.Cpros, a.Nops, b.Linhas, b.Cunis, a.EmpDopNops, a.CodTams "

        IF !THIS.ExecutarSQL(loc_cSql, "cursor_4c_OpiTmp", "TmpOpi")
            RETURN .F.
        ENDIF
        IF USED("TmpOpi")
            USE IN TmpOpi
        ENDIF
        SELECT * FROM cursor_4c_OpiTmp INTO CURSOR TmpOpi READWRITE
        USE IN cursor_4c_OpiTmp
        SELECT TmpOpi
        INDEX ON Nops TAG Nops
        INDEX ON Linhas + cpros TAG Linha

        SELECT TmpOpi
        SCAN
            *-- Composicao SUBSTITUIDA na O.P. e, na falta dela, a composicao
            *-- PADRAO do produto (com a substituicao por tamanho de SigSubCp)
            loc_cSql = "Select a.Mats, a.Qtds, b.cunis, b.Pesoms, b.Cgrus, b.dpros," + ;
                " c.Fators, b.Varias, d.Mercs " + ;
                "From SigSubMv a, SigCdPro b, SigCdUni c, SigCdGrp d " + ;
                "Where a.empdopnums = " + EscaparSQL(TmpOpi.empdopnums) + ;
                " and a.Cpros = " + EscaparSQL(TmpOpi.Cpros) + ;
                " and a.citem2 = " + FormatarNumeroSQL(TmpOpi.citens, 0) + ;
                " and a.mats = b.Cpros and b.Cunis = c.Cunis And b.Cgrus = d.Cgrus "

            IF !THIS.ExecutarSQL(loc_cSql, "TmpCompo", "TmpCompo")
                loc_lOk = .F.
                EXIT
            ENDIF

            IF RECCOUNT("TmpCompo") = 0
                loc_cSql = "Select a.Mats, b.cunis, b.Pesoms, b.Cgrus, b.dpros, c.Fators," + ;
                    " b.Varias, d.Mercs, " + ;
                    "Case When e.Qtds is null Then a.Qtds Else e.Qtds End as Qtds " + ;
                    "From SigPrCpo a inner Join SigCdPro b On a.mats = b.Cpros " + ;
                    "Inner Join SigCdUni c On b.Cunis = c.Cunis " + ;
                    "Inner Join SigCdGrp d On b.Cgrus = d.Cgrus " + ;
                    "Left Join SigSubCp e On a.mats = e.Mats And e.CodTams = " + ;
                    EscaparSQL(TmpOpi.CodTams) + " " + ;
                    "Where a.Cpros = " + EscaparSQL(TmpOpi.Cpros) + ;
                    " and a.mats = b.Cpros and b.Cunis = c.Cunis And b.Cgrus = d.Cgrus"

                IF !THIS.ExecutarSQL(loc_cSql, "TmpCompo", "TmpCompo - padrao")
                    loc_lOk = .F.
                    EXIT
                ENDIF
            ENDIF

            *-- "Select xNensi / Zap": recria vazio (ZAP em DataSession
            *-- privada ja travou a tela neste projeto)
            IF USED("xNensi")
                USE IN xNensi
            ENDIF
            CREATE CURSOR xNensi FROM ARRAY loc_aNensi

            SELECT TmpLinF
            IF !SEEK(TmpOpi.Linhas)
                MsgAviso("Linha :" + ALLTRIM(TmpOpi.Linhas) + " do Produto: " + ;
                    ALLTRIM(TmpOpi.cpros) + " nao Cadastrada!!!", "Aten" + CHR(231) + CHR(227) + "o")
                SELECT TmpOpi
                LOOP
            ENDIF
            loc_cGrpO     = PADR(TmpLinF.Grupos, 10)
            loc_cCtaO     = PADR(TmpLinF.Contas, 10)
            loc_dDtGe     = loc_dDtGera + TmpLinf.nDias
            loc_cUsuarLin = PADR(IIF(EMPTY(TmpLinf.Usuars), loc_cUsuar, TmpLinf.Usuars), 10)

            IF DOW(loc_dDtGe) = 7
                loc_dDtGe = loc_dDtGe + 2
            ELSE
                IF DOW(loc_dDtGe) = 1
                    loc_dDtGe = loc_dDtGe + 1
                ENDIF
            ENDIF

            SELECT TmpLinF
            SKIP
            SCAN WHILE TmpLinF.Linhas = TmpOpi.Linhas
                loc_cGrpD = PADR(TmpLinf.Grupos, 10)
                loc_cCtaD = PADR(TmpLinf.Contas, 10)

                SELECT crSigCdNec
                IF !SEEK(loc_cGrpO + loc_cCtaO + loc_cGrpD + loc_cCtaD + DTOS(loc_dDtGe) + ;
                        STR(TmpLinf.Ordems, 10))
                    APPEND BLANK
                    REPLACE GrupoOs  WITH loc_cGrpO, ;
                            ContaOs  WITH loc_cCtaO, ;
                            GrupoDs  WITH loc_cGrpD, ;
                            ContaDs  WITH loc_cCtaD, ;
                            Datas    WITH loc_dDtGe, ;
                            Dopps    WITH CrSigCdOpd.Dopps, ;
                            nTrans   WITH loc_nSeq, ;
                            Usuars   WITH loc_cUsuarLin, ;
                            nAceites WITH TmpLinf.Ordems ;
                        IN crSigCdNec

                    loc_nSeq = loc_nSeq + 1
                ENDIF

                INSERT INTO CrSigPdMvf (Grupoos, Contaos, Grupods, Contads, NOps, NEnvs, ;
                        Codpds, Unids, Pesos, Qtds, Ordems, nTrans, Usuars) ;
                    VALUES (loc_cGrpO, loc_cCtaO, loc_cGrpD, loc_cCtaD, TmpOpi.Nops, ;
                        TmpOpi.Nops, TmpOpi.Cpros, TmpOpi.Cunis, TmpOpi.Pesos, TmpOpi.Qtds, ;
                        TmpLinf.Ordems, CrSigCdNec.nTrans, loc_cUsuarLin)

                IF !EMPTY(TmpLinf.Cgrus) OR !EMPTY(TmpLinf.Mercs)
                    SELECT TmpCompo
                    SCAN
                        IF (TmpCompo.Cgrus = TmpLinf.Cgrus AND !EMPTY(TmpLinf.Cgrus)) OR ;
                                (TmpCompo.Mercs = TmpLinf.Mercs AND !EMPTY(TmpLinf.Mercs))

                            IF TmpCompo.Varias = 1 AND TmpOpi.Cpros != THIS.this_cPamOuros
                                loc_nQtAnt = TmpOpi.Pesos
                                loc_nPsAnt = TmpOpi.Pesos
                            ELSE
                                loc_nQtAnt = TmpCompo.Qtds * TmpOpi.Qtds
                                loc_nPsAnt = IIF(TmpCompo.Fators != 0, ;
                                    loc_nQtAnt * Tmpcompo.Fators, TmpCompo.Pesoms * TmpOpi.Qtds)
                            ENDIF

                            INSERT INTO xNensi (Nops, NEnvs, CMats, CDescs, CUnis, CGrus, ;
                                    Qtds, Pesos) ;
                                VALUES (TmpOpi.Nops, TmpOpi.Nops, TmpCompo.Mats, ;
                                    TmpCompo.Dpros, TmpCompo.CUnis, TmpCompo.CGrus, ;
                                    loc_nQtAnt, loc_nPsAnt)
                        ENDIF
                        SELECT TmpCompo
                    ENDSCAN
                ENDIF

                SELECT xNensi
                SCAN
                    SCATTER MEMVAR
                    INSERT INTO crSigCdNei FROM MEMVAR
                    REPLACE nTrans WITH CrSigCdNec.nTrans IN crSigCdNei
                    SELECT xNensi
                ENDSCAN

                SELECT TmpLinF
            ENDSCAN

            loc_cGrpD = PADR(THIS.this_cPamGruConfs, 10)
            loc_cCtaD = PADR(THIS.this_cPamConConfs, 10)

            SELECT crSigCdNec
            IF !SEEK(loc_cGrpO + loc_cCtaO + loc_cGrpD + loc_cCtaD + DTOS(loc_dDtGe) + STR(99, 10))
                APPEND BLANK
                REPLACE GrupoOs  WITH loc_cGrpO, ;
                        ContaOs  WITH loc_cCtaO, ;
                        GrupoDs  WITH loc_cGrpD, ;
                        ContaDs  WITH loc_cCtaD, ;
                        Datas    WITH loc_dDtGe, ;
                        Dopps    WITH loc_cDpTrf, ;
                        Usuars   WITH loc_cUsuar, ;
                        nTrans   WITH loc_nSeq, ;
                        nAceites WITH 99 ;
                    IN crSigCdNec

                loc_nSeq = loc_nSeq + 1
            ENDIF

            INSERT INTO CrSigPdMvf (Grupoos, Contaos, Grupods, Contads, NOps, NEnvs, Codpds, ;
                    Unids, Pesos, Qtds, Ordems, nTrans, Usuars) ;
                VALUES (loc_cGrpO, loc_cCtaO, loc_cGrpD, loc_cCtaD, TmpOpi.Nops, TmpOpi.Nops, ;
                    TmpOpi.Cpros, TmpOpi.Cunis, TmpOpi.Pesos, TmpOpi.Qtds, TmpLinf.Ordems, ;
                    CrSigCdNec.nTrans, loc_cUsuar)

            SELECT xNensi
            SCAN
                SCATTER MEMVAR
                INSERT INTO crSigCdNei FROM MEMVAR
                REPLACE nTrans WITH CrSigCdNec.nTrans IN crSigCdNei
                SELECT xNensi
            ENDSCAN

            SELECT TmpOpi
        ENDSCAN

        IF !loc_lOk
            = SQLROLLBACK(gnConnHandle)
            RETURN .F.
        ENDIF

        *-- Numeracao definitiva das necessidades + historico das fases
        SELECT crSigCdNec
        INDEX ON DTOS(Datas) + STR(nAceites, 10) TAG Datas
        SCAN
            loc_nTran   = crSigCdNec.nTrans
            loc_nInicio = fGerUniqueKey(ALLTRIM(CrSigCdNec.Dopps) + loc_cEmpr)
            loc_cIds    = DTOS(CrSigCdNec.Datas) + ;
                TRANSFORM(fGerUniqueKey(DTOS(CrSigCdNec.Datas)), "@L 999999") + THIS.this_cSigKey

            REPLACE Emps      WITH loc_cEmpr, ;
                    Numps     WITH loc_nInicio, ;
                    Datars    WITH DATETIME(), ;
                    Nops      WITH loc_nNopI, ;
                    Autos     WITH .T., ;
                    CidChaves WITH loc_cIds, ;
                    EmpDnPs   WITH loc_cEmpr + CrSigCdNec.Dopps + STR(loc_nInicio, 10) ;
                IN crSigCdNec

            SELECT crSigPdMvf
            = SEEK(loc_nTran)
            SCAN WHILE crSigPdMvf.nTrans = loc_nTran
                REPLACE Emps      WITH loc_cEmpr, ;
                        Dopps     WITH CrSigCdNec.Dopps, ;
                        Numps     WITH loc_nInicio, ;
                        Usuars    WITH CrSigCdNec.Usuars, ;
                        Datars    WITH DATETIME(), ;
                        Datas     WITH CrSigCdNec.Datas, ;
                        CidChaves WITH DTOS(CrSigCdNec.Datas) + ;
                            TRANSFORM(fGerUniqueKey(DTOS(CrSigCdNec.Datas)), "@L 999999") + ;
                            THIS.this_cSigKey, ;
                        EmpDnPs   WITH loc_cEmpr + CrSigCdNec.Dopps + STR(loc_nInicio, 10) ;
                    IN crSigPdMvf
                SELECT crSigPdMvf
            ENDSCAN

            loc_cSql = "Select * From SigCdOpd Where Dopps = " + ;
                EscaparSQL(ALLTRIM(CrSigCdNec.Dopps))
            IF !THIS.ExecutarSQL(loc_cSql, "CrSigCdOpd", "CrSigCdOpd - fase")
                loc_lOk = .F.
                EXIT
            ENDIF

            SELECT crSigCdNei
            = SEEK(loc_nTran)
            SCAN WHILE crSigCdNei.nTrans = loc_nTran
                REPLACE Emps      WITH loc_cEmpr, ;
                        Dopps     WITH CrSigCdNec.Dopps, ;
                        Numps     WITH loc_nInicio, ;
                        CidChaves WITH fUniqueIds(), ;
                        EmpDnPs   WITH loc_cEmpr + CrSigCdNec.Dopps + STR(loc_nInicio, 10) ;
                    IN crSigCdNei

                loc_cSql = "Select Cgrus From SigCdPro Where Cpros = " + ;
                    EscaparSQL(ALLTRIM(CrSigCdNei.Cmats))
                IF !THIS.ExecutarSQL(loc_cSql, "LocalPro", "LocalPro")
                    loc_lOk = .F.
                    EXIT
                ENDIF

                loc_cSql = "Select cEstoqs From SigCdGrp Where Cgrus = " + ;
                    EscaparSQL(ALLTRIM(LocalPro.Cgrus))
                IF !THIS.ExecutarSQL(loc_cSql, "LocalGru", "LocalGru")
                    loc_lOk = .F.
                    EXIT
                ENDIF

                IF INLIST(crSigCdOpd.EstOrigs, 1, 2) AND (crSigCdOpd.BxOEsts = 2) ;
                        AND (LocalGru.CEstoqs = 1)
                    loc_cOper  = IIF(crSigCdOpd.EstOrigs = 1, "E", "S")
                    loc_cXOper = loc_cOper
                    *-- Tiago - 23/10/2015: grava no cidchaves a MESMA letra da
                    *-- movimentacao (o bloco *!* que trocava por H/K esta
                    *-- desativado no legado)
                    loc_cIds = DTOS(CrSigCdNec.Datas) + loc_cXOper + ;
                        TRANSFORM(fGerUniqueKey(DTOS(CrSigCdNec.Datas)), "@L 999999") + ;
                        THIS.this_cSigKey

                    INSERT INTO crSigMvHst (Usuars, Datars, Emps, Opers, Dopes, Numes, Datas, ;
                            CPros, Empos, Qtds, Grupos, Estos, cIdChaves, EmpDopNums, ;
                            EmpGruEsts, DtAlts, OriDopNums, Seqs) ;
                        VALUES (CrSigCdNec.Usuars, DATETIME(), loc_cEmpr, loc_cOper, ;
                            CrSigCdNec.Dopps, CrSigCdNei.Numps, CrSigCdNec.Datas, ;
                            CrSigCdNei.CMats, loc_cEmpr, CrSigCdNei.Qtds, CrSigCdNec.Grupoos, ;
                            CrSigCdNec.Contaos, loc_cIds, ;
                            loc_cEmpr + CrSigCdNec.Dopps + STR(CrSigCdNei.Numps, 6), ;
                            loc_cEmpr + CrSigCdNec.Grupoos + CrSigCdNec.Contaos, ;
                            DATETIME(), ;
                            loc_cEmpr + CrSigCdNec.Dopps + STR(CrSigCdNei.Numps, 6), 0)

                    *-- fRecalculaP/fRecalculaC: omitido (ver NOTA DE ESCOPO)
                ENDIF

                IF INLIST(crSigCdOpd.EstDests, 1, 2) AND (crSigCdOpd.BxDEsts = 2) ;
                        AND (LocalGru.CEstoqs = 1)
                    loc_cOper  = IIF(crSigCdOpd.EstDests = 1, "E", "S")
                    loc_cXOper = loc_cOper
                    loc_cIds = DTOS(CrSigCdNec.Datas) + loc_cXOper + ;
                        TRANSFORM(fGerUniqueKey(DTOS(CrSigCdNec.Datas)), "@L 999999") + ;
                        THIS.this_cSigKey

                    INSERT INTO crSigMvHst (Usuars, Datars, Emps, Opers, Dopes, Numes, Datas, ;
                            CPros, Empos, Qtds, Grupos, Estos, cIdChaves, EmpDopNums, ;
                            EmpGruEsts, DtAlts, OriDopNums, Seqs) ;
                        VALUES (CrSigCdNec.Usuars, DATETIME(), loc_cEmpr, loc_cOper, ;
                            CrSigCdNec.Dopps, CrSigCdNei.Numps, CrSigCdNec.Datas, ;
                            CrSigCdNei.CMats, loc_cEmpr, CrSigCdNei.Qtds, CrSigCdNec.Grupods, ;
                            CrSigCdNec.Contads, loc_cIds, ;
                            loc_cEmpr + CrSigCdNec.Dopps + STR(CrSigCdNei.Numps, 6), ;
                            loc_cEmpr + CrSigCdNec.Grupods + CrSigCdNec.Contads, ;
                            DATETIME(), ;
                            loc_cEmpr + CrSigCdNec.Dopps + STR(CrSigCdNei.Numps, 6), 0)

                    *-- fRecalculaP/fRecalculaC: omitido (ver NOTA DE ESCOPO)
                ENDIF

                SELECT crSigCdNei
            ENDSCAN

            IF !loc_lOk
                EXIT
            ENDIF

            IF INLIST(crSigCdOpd.EstDests, 1, 2) AND (crSigCdOpd.BxDEsts = 1)

                IF USED("TmpHis")
                    USE IN TmpHis
                ENDIF
                SELECT DISTINCT b.Nops, b.Cpros, b.Qtds ;
                    FROM crSigCdNei a, TmpOpi b ;
                    WHERE a.nTrans = m.loc_nTran AND a.Nops = b.Nops ;
                    INTO CURSOR TmpHis

                loc_cOper = IIF(crSigCdOpd.EstDests = 1, "E", "S")

                SELECT TmpHis
                SCAN
                    loc_cIds = DTOS(CrSigCdNec.Datas) + loc_cOper + ;
                        TRANSFORM(fGerUniqueKey(DTOS(CrSigCdNec.Datas)), "@L 999999") + ;
                        THIS.this_cSigKey

                    INSERT INTO crSigMvHst (Usuars, Datars, Emps, Opers, Dopes, Numes, Datas, ;
                            CPros, Empos, Qtds, Grupos, Estos, cIdChaves, EmpDopNums, ;
                            EmpGruEsts, DtAlts, OriDopNums, Seqs) ;
                        VALUES (CrSigCdNec.Usuars, DATETIME(), loc_cEmpr, loc_cOper, ;
                            CrSigCdNec.Dopps, CrSigCdNec.Numps, CrSigCdNec.Datas, ;
                            TmpHis.CPros, loc_cEmpr, TmpHis.Qtds, CrSigCdNec.Grupods, ;
                            CrSigCdNec.Contads, loc_cIds, ;
                            loc_cEmpr + CrSigCdNec.Dopps + STR(CrSigCdNec.Numps, 6), ;
                            loc_cEmpr + CrSigCdNec.Grupods + CrSigCdNec.Contads, DATETIME(), ;
                            loc_cEmpr + CrSigCdNec.Dopps + STR(CrSigCdNec.Numps, 6), 0)

                    *-- fRecalculaP/fRecalculaC: omitido (ver NOTA DE ESCOPO)
                    SELECT TmpHis
                ENDSCAN
            ENDIF

            SELECT crSigCdNec
        ENDSCAN

        IF !loc_lOk
            = SQLROLLBACK(gnConnHandle)
            RETURN .F.
        ENDIF

        SELECT crSigMvHst
        GO TOP

        *-- Marca como subnotada a necessidade original de cada item da O.P.
        SELECT TmpOpi
        SCAN
            loc_cSql = "Select CidChaves From SigCdNec Where EmpDnPs = " + ;
                EscaparSQL(TmpOpi.EmpDopNops)
            IF !THIS.ExecutarSQL(loc_cSql, "LocalNens", "Update - crSigCdNec")
                loc_lErro = .T.
                EXIT
            ENDIF

            SELECT LocalNens
            SCAN
                loc_cSql = "Update SigCdNec Set ChkSubn = 1 Where cidChaves = " + ;
                    EscaparSQL(LocalNens.CidChaves)
                IF !THIS.ExecutarSQL(loc_cSql, "", "Update - crSigCdNec 1")
                    loc_lErro = .T.
                    EXIT
                ENDIF
                SELECT LocalNens
            ENDSCAN
            IF loc_lErro
                EXIT
            ENDIF
            SELECT TmpOpi
        ENDSCAN

        IF !loc_lErro AND !THIS.PersistirCursor("crSigPdMvf", "SigPdMvf")
            loc_lErro = .T.
        ENDIF
        IF !loc_lErro AND !THIS.PersistirCursor("crSigCdNec", "SigCdNec")
            loc_lErro = .T.
        ENDIF
        IF !loc_lErro AND !THIS.PersistirCursor("crSigMvHst", "SigMvHst")
            loc_lErro = .T.
        ENDIF
        IF !loc_lErro AND !THIS.PersistirCursor("crSigCdNei", "SigCdNei")
            loc_lErro = .T.
        ENDIF

        *-- fRecalculaP / fRecalculaC de lote: omitidos (ver NOTA DE ESCOPO)

        IF !loc_lErro
            IF SQLCOMMIT(gnConnHandle) < 1
                THIS.this_cMensagemErro = "Favor Reinicializar o Processo!!!" + CHR(13) + ;
                    "(Commit) " + CapturarErroSQL()
                loc_lErro = .T.
            ENDIF
        ENDIF

        IF loc_lErro
            = SQLROLLBACK(gnConnHandle)
        ENDIF

        RETURN !loc_lErro
    ENDFUNC

ENDDEFINE

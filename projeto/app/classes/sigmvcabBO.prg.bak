*==============================================================================
* sigmvcabBO.prg - Business Object para Movimentacao de Cabecalho (SigMvCab)
*
* Tabela principal : SigMvCab
* Chave primaria   : EmpDopNums (composta: Emps + Dopes + STR(Numes,6))
* Herda de         : BusinessBase
*
* FASE 1/8 - Declaracoes de propriedades e Init()
* Fases seguintes adicionarao: CarregarDoCursor, Inserir, Atualizar,
*   ExecutarExclusao, Buscar, CarregarPorCodigo, ObterChavePrimaria
*==============================================================================

DEFINE CLASS sigmvcabBO AS BusinessBase

    *--------------------------------------------------------------------------
    * Chave primaria composta
    *--------------------------------------------------------------------------
    this_cEmps              = ""    && Empresa (C3) - parte 1 da PK
    this_cDopes             = ""    && Codigo da Operacao (C20) - parte 2 da PK
    this_nNumes             = 0     && Numero da movimentacao (N6) - parte 3 da PK
    this_cEmpDopNums        = ""    && Chave composta calculada (C29)

    *--------------------------------------------------------------------------
    * Datas
    *--------------------------------------------------------------------------
    this_dDatas             = {}    && Data do movimento
    this_dDatatrans         = {}    && Data de transferencia / contabilizacao
    this_dDatars            = {}    && Data de referencia (datars)
    this_dDtfecha           = {}    && Data de fechamento

    *--------------------------------------------------------------------------
    * Contas de Origem e Destino
    *--------------------------------------------------------------------------
    this_cGrupoos           = ""    && Grupo Origem (C10)
    this_cContaos           = ""    && Conta Origem (C10)
    this_cGrupods           = ""    && Grupo Destino (C10)
    this_cContads           = ""    && Conta Destino (C10)
    this_cIclis             = ""    && Codigo do Cliente (C10)

    *--------------------------------------------------------------------------
    * Vendedor / Responsavel / Job
    *--------------------------------------------------------------------------
    this_cGrupovendedors    = ""    && Grupo do Vendedor (C10)
    this_cContavendedors    = ""    && Conta do Vendedor (C10)
    this_cGruporespons      = ""    && Grupo Responsavel (C10)
    this_cContarespons      = ""    && Conta Responsavel (C10)
    this_cGrupojobs         = ""    && Grupo do Job (C10)
    this_cContajobs         = ""    && Conta do Job (C10)
    this_cJobs              = ""    && Codigo do Job (C10)
    this_cVends             = ""    && Vendedor (C10) - campo legado Vends
    this_cGrvends           = ""    && Gravacao de vendedor (C10)

    *--------------------------------------------------------------------------
    * Valores Financeiros
    *--------------------------------------------------------------------------
    this_nValos             = 0     && Valor total do movimento
    this_nValvars           = 0     && Valor de variacao (desconto/acrescimo)
    this_nValdevs           = 0     && Valor de devolucao
    this_nValndevs          = 0     && Valor nao devolvido
    this_nValinis           = 0     && Valor inicial (antes de variacoes)
    this_nAcres             = 0     && Acrescimo financeiro
    this_nVars              = 0     && Percentual de variacao
    this_nDesconto          = 0     && Desconto total
    this_nFrete             = 0     && Valor do frete
    this_nSeguro            = 0     && Valor do seguro
    this_nDespaces          = 0     && Despesas acessorias
    this_nIpi               = 0     && Valor IPI
    this_nIcms              = 0     && Valor ICMS
    this_nIss               = 0     && Valor ISS

    *--------------------------------------------------------------------------
    * Identificacao e Controle
    *--------------------------------------------------------------------------
    this_cNotas             = ""    && Numero da nota/documento (C6)
    this_cSeries            = ""    && Serie da nota (C3)
    this_cObses             = ""    && Observacoes do movimento
    this_nCodobs            = 0     && Codigo da observacao padrao
    this_cCidchaves         = ""    && Chave unica do registro (UUID)
    this_cOpers             = ""    && Tipo operacao (E=Entrada/S=Saida)
    this_cEcfs              = ""    && Numero do ECF
    this_cMascnum           = ""    && Numero mascarado do documento

    *--------------------------------------------------------------------------
    * Configuracoes Operacionais
    *--------------------------------------------------------------------------
    this_cTabds             = ""    && Tabela de desconto (C10)
    this_cLprecos           = ""    && Lista de precos (C10)
    this_cTpfats            = ""    && Tipo de faturamento (C10)
    this_cTransps           = ""    && Codigo da transportadora (C10)
    this_cEmpds             = ""    && Empresa destino para faturamento (C3)
    this_cLocals            = ""    && Local / deposito (C10)
    this_cTpMovs            = ""    && Tipo de movimento (C3)
    this_cCodtrans          = ""    && Codigo do transportador (C10)
    this_cMeiotrans         = ""    && Meio de transporte (C1)
    this_cCompets           = ""    && Competencia (MMAAAA)

    *--------------------------------------------------------------------------
    * Numericos Auxiliares
    *--------------------------------------------------------------------------
    this_nNemps             = 0     && Numero interno da empresa (N)
    this_nNtrans            = 0     && Numero da transacao TEF
    this_nNumolds           = 0     && Numero anterior (antes de alteracao)
    this_nLotechqs          = 0     && Lote de cheques (N)

    *--------------------------------------------------------------------------
    * Campos Logicos de Controle
    *--------------------------------------------------------------------------
    this_lChkbxparcs        = .F.   && Indica baixa parcial de parcelas
    this_lChksubn           = .F.   && Indica sub-nivel
    this_lDevols            = .F.   && Indica devolucao
    this_lCancelas          = .F.   && Indica cancelamento
    this_lChkregister       = .F.   && Flag de registro especial

    *--------------------------------------------------------------------------
    * Descricoes e Textos
    *--------------------------------------------------------------------------
    this_cDescs             = ""    && Descricao/historico do lancamento
    this_cDesc2s            = ""    && Descricao complementar
    this_cFpubls            = ""    && Forma de publicidade (C10)

    *--------------------------------------------------------------------------
    * Auditoria e Confirmacao
    *--------------------------------------------------------------------------
    this_cUsualts           = ""    && Usuario que realizou ultima alteracao (C10)
    this_cDtaudits          = ""    && Data/hora da ultima auditoria

    *--------------------------------------------------------------------------
    * Campos de Controle Interno do Form (nao gravados em SigMvCab)
    *--------------------------------------------------------------------------
    this_cPcescolha         = ""    && Modo atual: INSERIR/ALTERAR/EXCLUIR/CONSULTAR
    this_lNovoregistro      = .T.   && .T. = INSERT, .F. = UPDATE

    *==========================================================================
    * Init - Configura propriedades basicas do BO
    *==========================================================================
    PROCEDURE Init()
        DODEFAULT()
        THIS.this_cTabela      = "SigMvCab"
        THIS.this_cCampoChave  = "EmpDopNums"
        RETURN .T.
    ENDPROC

    *==========================================================================
    * ObterChavePrimaria - Retorna valor da chave primaria atual
    * (Sobrescreve BusinessBase para chave composta)
    *==========================================================================
    FUNCTION ObterChavePrimaria()
        RETURN ALLTRIM(THIS.this_cEmpDopNums)
    ENDFUNC

    *==========================================================================
    * MontarChaveComposta - Calcula EmpDopNums a partir dos tres componentes
    *==========================================================================
    FUNCTION MontarChaveComposta()
        LOCAL loc_cChave
        loc_cChave = PADR(ALLTRIM(THIS.this_cEmps), 3) + ;
                     PADR(ALLTRIM(THIS.this_cDopes), 20) + ;
                     PADL(TRANSFORM(INT(THIS.this_nNumes)), 6, "0")
        THIS.this_cEmpDopNums = loc_cChave
        RETURN loc_cChave
    ENDFUNC


    *==========================================================================
    * CarregarDoCursor - Carrega propriedades a partir do cursor informado
    *==========================================================================
    PROTECTED PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        IF USED(par_cAliasCursor)
            SELECT (par_cAliasCursor)

            *-- Chave composta
            THIS.this_cEmps          = TratarNulo(emps,       "")
            THIS.this_cDopes         = TratarNulo(dopes,      "")
            THIS.this_nNumes         = TratarNulo(numes,       0)
            THIS.this_cEmpDopNums    = TratarNulo(empdopnums, "")

            *-- Datas (SQLEXEC retorna DateTime; converte para Date)
            THIS.this_dDatas         = IIF(VARTYPE(datas)     ="T", TTOD(datas),     TratarNulo(datas,     {}))
            THIS.this_dDatatrans     = IIF(VARTYPE(datatrans) ="T", TTOD(datatrans), TratarNulo(datatrans, {}))
            THIS.this_dDatars        = IIF(VARTYPE(datars)    ="T", TTOD(datars),    TratarNulo(datars,    {}))
            THIS.this_dDtfecha       = IIF(VARTYPE(dtfechas)  ="T", TTOD(dtfechas),  TratarNulo(dtfechas,  {}))

            *-- Contas origem / destino / cliente
            THIS.this_cGrupoos       = TratarNulo(grupoos,   "")
            THIS.this_cContaos       = TratarNulo(contaos,   "")
            THIS.this_cGrupods       = TratarNulo(grupods,   "")
            THIS.this_cContads       = TratarNulo(contads,   "")
            THIS.this_cIclis         = TratarNulo(iclis,     "")

            *-- Vendedor / Responsavel / Job
            THIS.this_cGrupovendedors= TratarNulo(grupos,    "")
            THIS.this_cVends         = TratarNulo(vends,     "")
            THIS.this_cGrvends       = TratarNulo(grvends,   "")
            THIS.this_cGruporespons  = TratarNulo(grresps,   "")
            THIS.this_cContarespons  = TratarNulo(resps,     "")
            THIS.this_cJobs          = TratarNulo(jobs,      "")

            *-- Valores financeiros
            THIS.this_nValos         = TratarNulo(valos,      0)
            THIS.this_nValvars       = TratarNulo(valvars,    0)
            THIS.this_nValdevs       = TratarNulo(valdevs,    0)
            THIS.this_nValndevs      = TratarNulo(valndevs,   0)
            THIS.this_nValinis       = TratarNulo(valinis,    0)
            THIS.this_nAcres         = TratarNulo(acres,      0)
            THIS.this_nVars          = TratarNulo(vars,       0)
            THIS.this_nDesconto      = TratarNulo(descs,      0)

            *-- Identificacao
            THIS.this_cNotas         = TratarNulo(notas,     "")
            THIS.this_cObses         = TratarNulo(obses,     "")
            THIS.this_nCodobs        = TratarNulo(codobs,     0)
            THIS.this_cCidchaves     = TratarNulo(cidchaves, "")
            THIS.this_cOpers         = TratarNulo(opers,     "")
            THIS.this_cEcfs          = TratarNulo(ecfs,      "")
            THIS.this_cMascnum       = TratarNulo(mascnum,   "")

            *-- Configuracoes operacionais
            THIS.this_cTabds         = TratarNulo(tabds,     "")
            THIS.this_cLprecos       = TratarNulo(lprecos,   "")
            THIS.this_cTpfats        = TratarNulo(tpfats,    "")
            THIS.this_cTransps       = IIF(TratarNulo(transps, 0) = 1, "S", "")
            THIS.this_cEmpds         = TratarNulo(empds,     "")
            THIS.this_cLocals        = TratarNulo(locals,    "")
            THIS.this_cTpMovs        = TratarNulo(tpmovs,    "")
            THIS.this_cCodtrans      = TratarNulo(codtrans,  "")
            THIS.this_cMeiotrans     = TratarNulo(meiotrans, "")
            THIS.this_cCompets       = TratarNulo(compet,    "")

            *-- Numericos auxiliares
            THIS.this_nNemps         = VAL(TratarNulo(nemps, "0"))
            THIS.this_nNtrans        = TratarNulo(ntrans,    0)
            THIS.this_nNumolds       = TratarNulo(numolds,   0)
            THIS.this_nLotechqs      = TratarNulo(lotechqs,  0)

            *-- Campos logicos
            THIS.this_lChkbxparcs    = (TratarNulo(chkbxparcs, 0) = 1)
            THIS.this_lChksubn       = (TratarNulo(chksubn,    0) = 1)
            THIS.this_lDevols        = (TratarNulo(devols,     0) > 0)
            THIS.this_lCancelas      = (TratarNulo(lcancelas,  0) = 1)
            THIS.this_lChkregister   = (TratarNulo(chkencerra, 0) = 1)

            *-- Descricoes e auditoria
            THIS.this_cFpubls        = TratarNulo(fpubls,   "")
            THIS.this_cUsualts       = TratarNulo(usuals,   "")
            THIS.this_cDtaudits      = IIF(ISNULL(dtaudits), "", TTOC(dtaudits))
            THIS.this_cDescs         = TRANSFORM(TratarNulo(descs,  0))
            THIS.this_cDesc2s        = TRANSFORM(TratarNulo(desc2s, 0))

            THIS.this_lNovoRegistro  = .F.
            loc_lSucesso = .T.
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * CarregarPorCodigo - Carrega registro pelo EmpDopNums (chave composta)
    * par_cChave : valor de empdopnums (C29)
    *==========================================================================
    PROCEDURE CarregarPorCodigo(par_cChave)
        LOCAL loc_lSucesso, loc_cSQL, loc_nResultado
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "SELECT empdopnums, emps, dopes, numes," + ;
                       " datas, datatrans, datars, dtfechas," + ;
                       " grupoos, contaos, grupods, contads, iclis," + ;
                       " grupos, vends, grvends, grresps, resps, jobs," + ;
                       " valos, valvars, valdevs, valndevs, valinis," + ;
                       " acres, vars, descs, desc2s," + ;
                       " notas, obses, codobs, cidchaves, opers, ecfs, mascnum," + ;
                       " tabds, lprecos, tpfats, transps, empds, locals," + ;
                       " tpmovs, codtrans, meiotrans, compet," + ;
                       " nemps, ntrans, numolds, lotechqs," + ;
                       " chkbxparcs, chksubn, devols, lcancelas, chkencerra," + ;
                       " fpubls, usuals, dtaudits" + ;
                       " FROM SigMvCab" + ;
                       " WHERE empdopnums = " + EscaparSQL(ALLTRIM(par_cChave))

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")
            IF loc_nResultado > 0 AND RECCOUNT("cursor_4c_Carrega") > 0
                loc_lSucesso = THIS.CarregarDoCursor("cursor_4c_Carrega")
                THIS.this_lNovoRegistro = .F.
            ENDIF

            IF USED("cursor_4c_Carrega")
                USE IN cursor_4c_Carrega
            ENDIF
        CATCH TO loException
            MostrarErro(loException, "sigmvcabBO.CarregarPorCodigo")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * Buscar - Carrega lista de movimentos para cursor_4c_Dados
    * par_cFiltro : filtro livre (pode conter WHERE parcial ou vazio)
    *==========================================================================
    PROCEDURE Buscar(par_cFiltro)
        LOCAL loc_lSucesso, loc_cSQL, loc_nResultado, loc_cWhere
        loc_lSucesso = .F.

        TRY
            loc_cWhere = " WHERE 1=1"

            IF !EMPTY(ALLTRIM(par_cFiltro))
                loc_cWhere = loc_cWhere + " AND (" + ;
                    "empdopnums LIKE " + EscaparSQL("%" + ALLTRIM(par_cFiltro) + "%") + ;
                    " OR notas LIKE " + EscaparSQL("%" + ALLTRIM(par_cFiltro) + "%") + ;
                    " OR iclis LIKE " + EscaparSQL("%" + ALLTRIM(par_cFiltro) + "%") + ;
                    ")"
            ENDIF

            loc_cSQL = "SELECT empdopnums, emps, dopes, numes, datas," + ;
                       " iclis, valos, opers, notas, cidchaves," + ;
                       " grupoos, contaos, grupods, contads" + ;
                       " FROM SigMvCab" + ;
                       loc_cWhere + ;
                       " ORDER BY datas DESC, numes DESC"

            IF USED("cursor_4c_Dados")
                USE IN cursor_4c_Dados
            ENDIF

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")
            IF loc_nResultado >= 0
                IF RECCOUNT("cursor_4c_Dados") > 0
                    GO TOP IN cursor_4c_Dados
                ENDIF
                loc_lSucesso = .T.
            ELSE
                MostrarErro("Erro ao buscar movimentos:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loException
            MostrarErro(loException, "sigmvcabBO.Buscar")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * BuscarComFiltro - Busca com filtros avancados (empresa, operacao, datas)
    * par_cEmps     : codigo da empresa (C3)
    * par_cDopes    : codigo da operacao (C20) - vazio = todas
    * par_dDtIni    : data inicial (D)
    * par_dDtFim    : data final (D)
    *==========================================================================
    PROCEDURE BuscarComFiltro(par_cEmps, par_cDopes, par_dDtIni, par_dDtFim)
        LOCAL loc_lSucesso, loc_cSQL, loc_nResultado, loc_cWhere
        loc_lSucesso = .F.

        TRY
            loc_cWhere = " WHERE 1=1"

            IF !EMPTY(ALLTRIM(par_cEmps))
                loc_cWhere = loc_cWhere + " AND emps = " + EscaparSQL(ALLTRIM(par_cEmps))
            ENDIF

            IF !EMPTY(ALLTRIM(par_cDopes))
                loc_cWhere = loc_cWhere + " AND dopes = " + EscaparSQL(ALLTRIM(par_cDopes))
            ENDIF

            IF !EMPTY(par_dDtIni)
                loc_cWhere = loc_cWhere + " AND datas >= " + FormatarDataSQL(par_dDtIni)
            ENDIF

            IF !EMPTY(par_dDtFim)
                loc_cWhere = loc_cWhere + " AND datas <= " + FormatarDataSQL(par_dDtFim)
            ENDIF

            loc_cSQL = "SELECT empdopnums, emps, dopes, numes, datas," + ;
                       " iclis, valos, opers, notas, cidchaves," + ;
                       " grupoos, contaos, grupods, contads, lcancelas" + ;
                       " FROM SigMvCab" + ;
                       loc_cWhere + ;
                       " ORDER BY datas DESC, numes DESC"

            IF USED("cursor_4c_Dados")
                USE IN cursor_4c_Dados
            ENDIF

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")
            IF loc_nResultado >= 0
                IF RECCOUNT("cursor_4c_Dados") > 0
                    GO TOP IN cursor_4c_Dados
                ENDIF
                loc_lSucesso = .T.
            ELSE
                MostrarErro("Erro ao buscar movimentos:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loException
            MostrarErro(loException, "sigmvcabBO.BuscarComFiltro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * Inserir - Executa INSERT na tabela SigMvCab
    * Estrategia: constroi SQL em partes (cCols / cVals) para manter
    * facil verificacao de paridade entre colunas e valores.
    *==========================================================================
    PROTECTED PROCEDURE Inserir()
        LOCAL loc_lSucesso, loc_nResultado
        LOCAL loc_cChave, loc_cCidChave
        LOCAL loc_cVals, loc_cSQL
        loc_lSucesso = .F.

        TRY
            *-- Monta chave composta e garante cidchaves preenchido
            loc_cChave    = THIS.MontarChaveComposta()
            loc_cCidChave = IIF(EMPTY(ALLTRIM(THIS.this_cCidchaves)), ;
                                fUniqueIds(), ALLTRIM(THIS.this_cCidchaves))
            THIS.this_cCidchaves = loc_cCidChave

            *-- Valores BO-mapeados (ordem identica ao INSERT abaixo)
            loc_cVals = EscaparSQL(loc_cChave)                              + "," + ;
                        EscaparSQL(ALLTRIM(THIS.this_cEmps))                + "," + ;
                        EscaparSQL(ALLTRIM(THIS.this_cDopes))               + "," + ;
                        FormatarNumeroSQL(THIS.this_nNumes)                 + "," + ;
                        EscaparSQL(loc_cCidChave)                           + ","

            loc_cVals = loc_cVals + ;
                        FormatarDataSQL(THIS.this_dDatas)                   + "," + ;
                        FormatarDataSQL(THIS.this_dDatatrans)               + "," + ;
                        FormatarDataSQL(THIS.this_dDatars)                  + "," + ;
                        FormatarDataSQL(THIS.this_dDtfecha)                 + ","

            loc_cVals = loc_cVals + ;
                        EscaparSQL(ALLTRIM(THIS.this_cGrupoos))             + "," + ;
                        EscaparSQL(ALLTRIM(THIS.this_cContaos))             + "," + ;
                        EscaparSQL(ALLTRIM(THIS.this_cGrupods))             + "," + ;
                        EscaparSQL(ALLTRIM(THIS.this_cContads))             + "," + ;
                        EscaparSQL(ALLTRIM(THIS.this_cIclis))               + ","

            loc_cVals = loc_cVals + ;
                        EscaparSQL(ALLTRIM(THIS.this_cGrupovendedors))      + "," + ;
                        EscaparSQL(ALLTRIM(THIS.this_cVends))               + "," + ;
                        EscaparSQL(ALLTRIM(THIS.this_cGrvends))             + "," + ;
                        EscaparSQL(ALLTRIM(THIS.this_cGruporespons))        + "," + ;
                        EscaparSQL(ALLTRIM(THIS.this_cContarespons))        + "," + ;
                        EscaparSQL(ALLTRIM(THIS.this_cJobs))                + ","

            loc_cVals = loc_cVals + ;
                        FormatarNumeroSQL(THIS.this_nValos)                 + "," + ;
                        FormatarNumeroSQL(THIS.this_nValvars)               + "," + ;
                        FormatarNumeroSQL(THIS.this_nValdevs)               + "," + ;
                        FormatarNumeroSQL(THIS.this_nValndevs)              + "," + ;
                        FormatarNumeroSQL(THIS.this_nValinis)               + ","

            loc_cVals = loc_cVals + ;
                        FormatarNumeroSQL(THIS.this_nAcres)                 + "," + ;
                        FormatarNumeroSQL(THIS.this_nVars)                  + "," + ;
                        FormatarNumeroSQL(THIS.this_nDesconto)              + "," + ;
                        "0,"

            loc_cVals = loc_cVals + ;
                        EscaparSQL(ALLTRIM(THIS.this_cNotas))               + "," + ;
                        EscaparSQL(THIS.this_cObses)                        + "," + ;
                        FormatarNumeroSQL(THIS.this_nCodobs)                + "," + ;
                        EscaparSQL(ALLTRIM(THIS.this_cOpers))               + "," + ;
                        EscaparSQL(ALLTRIM(THIS.this_cEcfs))                + "," + ;
                        EscaparSQL(ALLTRIM(THIS.this_cMascnum))             + ","

            loc_cVals = loc_cVals + ;
                        EscaparSQL(ALLTRIM(THIS.this_cTabds))               + "," + ;
                        EscaparSQL(ALLTRIM(THIS.this_cLprecos))             + "," + ;
                        EscaparSQL(ALLTRIM(THIS.this_cTpfats))              + "," + ;
                        IIF(!EMPTY(THIS.this_cTransps), "1", "0")           + "," + ;
                        EscaparSQL(ALLTRIM(THIS.this_cEmpds))               + "," + ;
                        EscaparSQL(ALLTRIM(THIS.this_cLocals))              + ","

            loc_cVals = loc_cVals + ;
                        EscaparSQL(ALLTRIM(THIS.this_cTpMovs))              + "," + ;
                        EscaparSQL(ALLTRIM(THIS.this_cCodtrans))            + "," + ;
                        EscaparSQL(ALLTRIM(THIS.this_cMeiotrans))           + "," + ;
                        EscaparSQL(ALLTRIM(THIS.this_cCompets))             + ","

            loc_cVals = loc_cVals + ;
                        EscaparSQL(TRANSFORM(THIS.this_nNemps))             + "," + ;
                        FormatarNumeroSQL(THIS.this_nNtrans)                + "," + ;
                        FormatarNumeroSQL(THIS.this_nNumolds)               + "," + ;
                        FormatarNumeroSQL(THIS.this_nLotechqs)              + ","

            loc_cVals = loc_cVals + ;
                        IIF(THIS.this_lChkbxparcs,  "1", "0")              + "," + ;
                        IIF(THIS.this_lChksubn,     "1", "0")              + "," + ;
                        IIF(THIS.this_lDevols,      "1", "0")              + "," + ;
                        IIF(THIS.this_lCancelas,    "1", "0")              + "," + ;
                        IIF(THIS.this_lChkregister, "1", "0")              + ","

            loc_cVals = loc_cVals + ;
                        EscaparSQL(ALLTRIM(THIS.this_cFpubls))              + "," + ;
                        EscaparSQL(ALLTRIM(THIS.this_cUsualts))             + ","

            *-- Campos nao-mapeados no BO: valores default
            loc_cVals = loc_cVals + "0,'',0,'','',"    && npedclis,antecs,codpeds,ifors,ncarnecs
            loc_cVals = loc_cVals + "0,'',0,0,0,"      && nops,nrcons,valacres,valdes2s,valdescs
            loc_cVals = loc_cVals + "0,0,0,'','',"     && valservs,valencs,valobxs,noforms,auditors
            loc_cVals = loc_cVals + "'','',0,'',"       && empgopnums,contaes,localents,localizas
            loc_cVals = loc_cVals + "0,0,'','',"        && chkpagos,chkpgs,empdnbxs,empdncrds
            loc_cVals = loc_cVals + "'','',0,'',"       && obsagends,operadors,vcompensas,motdscs
            loc_cVals = loc_cVals + "0,0,0,0,"          && ndeclaras,numbalds,numbals,priors
            loc_cVals = loc_cVals + "0,0,0,'','',"     && procbals,procdbal,protats,usupagos,ultgrvs
            loc_cVals = loc_cVals + "'',0,0,'',0,"      && moeits,rnops,impress,pstatus,valvarps
            loc_cVals = loc_cVals + "'',0,0,'','',"     && cifccfs,cupfis,idconta,ncupoms,status
            loc_cVals = loc_cVals + "0,0,'',"           && valtrans,impcpfs,ccfgnfs
            loc_cVals = loc_cVals + "0,0,0,'','',"     && ptax1s,ptax2s,ptax3s,obscabmovs,codobs2
            loc_cVals = loc_cVals + "0,0,0,0,"          && valserfix,perserfix,valosfix,perdesc
            loc_cVals = loc_cVals + "'','','','',0,"    && pedidoweb,cdrastreio,identrega,idtransp,peracresc
            loc_cVals = loc_cVals + "'','','',"         && empfats,numeronota,chavenota
            loc_cVals = loc_cVals + "'',"               && contaccs
            loc_cVals = loc_cVals + "'','','','',0,"    && usuars,usulibs,cotusus,espes,qtdes
            loc_cVals = loc_cVals + "0,0,0,0,''"        && cofs,livros,utilizados,trfisicos,dgopes

            loc_cSQL = "INSERT INTO SigMvCab (" + ;
                "empdopnums,emps,dopes,numes,cidchaves,datas,datatrans," + ;
                "datars,dtfechas,grupoos,contaos,grupods,contads,iclis," + ;
                "grupos,vends,grvends,grresps,resps,jobs,valos,valvars," + ;
                "valdevs,valndevs,valinis,acres,vars,descs,desc2s,notas," + ;
                "obses,codobs,opers,ecfs,mascnum,tabds,lprecos,tpfats," + ;
                "transps,empds,locals,tpmovs,codtrans,meiotrans,compet," + ;
                "nemps,ntrans,numolds,lotechqs,chkbxparcs,chksubn,devols," + ;
                "lcancelas,chkencerra,fpubls,usuals,npedclis,antecs,codpeds," + ;
                "ifors,ncarnecs,nops,nrcons,valacres,valdes2s,valdescs," + ;
                "valservs,valencs,valobxs,noforms,auditors,empgopnums," + ;
                "contaes,localents,localizas,chkpagos,chkpgs,empdnbxs," + ;
                "empdncrds,obsagends,operadors,vcompensas,motdscs,ndeclaras," + ;
                "numbalds,numbals,priors,procbals,procdbal,protats,usupagos," + ;
                "ultgrvs,moeits,rnops,impress,pstatus,valvarps,cifccfs,cupfis," + ;
                "idconta,ncupoms,status,valtrans,impcpfs,ccfgnfs,ptax1s," + ;
                "ptax2s,ptax3s,obscabmovs,codobs2,valserfix,perserfix,valosfix," + ;
                "perdesc,pedidoweb,cdrastreio,identrega,idtransp,peracresc," + ;
                "empfats,numeronota,chavenota,contaccs,usuars,usulibs,cotusus," + ;
                "espes,qtdes,cofs,livros,utilizados,trfisicos,dgopes" + ;
                ") VALUES (" + loc_cVals + ")"

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nResultado > 0
                THIS.RegistrarAuditoria("INSERT")
                loc_lSucesso = .T.
            ELSE
                THIS.this_cMensagemErro = CapturarErroSQL()
            ENDIF
        CATCH TO loException
            MostrarErro(loException, "sigmvcabBO.Inserir")
            THIS.this_cMensagemErro = loException.Message
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * Atualizar - Executa UPDATE na tabela SigMvCab pelo empdopnums
    *==========================================================================
    PROTECTED PROCEDURE Atualizar()
        LOCAL loc_lSucesso, loc_cSQL, loc_nResultado
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "UPDATE SigMvCab SET"
            loc_cSQL = loc_cSQL + " datas = "      + FormatarDataSQL(THIS.this_dDatas)              + ","
            loc_cSQL = loc_cSQL + " datatrans = "  + FormatarDataSQL(THIS.this_dDatatrans)          + ","
            loc_cSQL = loc_cSQL + " datars = "     + FormatarDataSQL(THIS.this_dDatars)             + ","
            loc_cSQL = loc_cSQL + " dtfechas = "   + FormatarDataSQL(THIS.this_dDtfecha)            + ","
            loc_cSQL = loc_cSQL + " grupoos = "    + EscaparSQL(ALLTRIM(THIS.this_cGrupoos))        + ","
            loc_cSQL = loc_cSQL + " contaos = "    + EscaparSQL(ALLTRIM(THIS.this_cContaos))        + ","
            loc_cSQL = loc_cSQL + " grupods = "    + EscaparSQL(ALLTRIM(THIS.this_cGrupods))        + ","
            loc_cSQL = loc_cSQL + " contads = "    + EscaparSQL(ALLTRIM(THIS.this_cContads))        + ","
            loc_cSQL = loc_cSQL + " iclis = "      + EscaparSQL(ALLTRIM(THIS.this_cIclis))          + ","
            loc_cSQL = loc_cSQL + " grupos = "     + EscaparSQL(ALLTRIM(THIS.this_cGrupovendedors)) + ","
            loc_cSQL = loc_cSQL + " vends = "      + EscaparSQL(ALLTRIM(THIS.this_cVends))          + ","
            loc_cSQL = loc_cSQL + " grvends = "    + EscaparSQL(ALLTRIM(THIS.this_cGrvends))        + ","
            loc_cSQL = loc_cSQL + " grresps = "    + EscaparSQL(ALLTRIM(THIS.this_cGruporespons))   + ","
            loc_cSQL = loc_cSQL + " resps = "      + EscaparSQL(ALLTRIM(THIS.this_cContarespons))   + ","
            loc_cSQL = loc_cSQL + " jobs = "       + EscaparSQL(ALLTRIM(THIS.this_cJobs))           + ","
            loc_cSQL = loc_cSQL + " valos = "      + FormatarNumeroSQL(THIS.this_nValos)            + ","
            loc_cSQL = loc_cSQL + " valvars = "    + FormatarNumeroSQL(THIS.this_nValvars)          + ","
            loc_cSQL = loc_cSQL + " valdevs = "    + FormatarNumeroSQL(THIS.this_nValdevs)          + ","
            loc_cSQL = loc_cSQL + " valndevs = "   + FormatarNumeroSQL(THIS.this_nValndevs)         + ","
            loc_cSQL = loc_cSQL + " valinis = "    + FormatarNumeroSQL(THIS.this_nValinis)          + ","
            loc_cSQL = loc_cSQL + " acres = "      + FormatarNumeroSQL(THIS.this_nAcres)            + ","
            loc_cSQL = loc_cSQL + " vars = "       + FormatarNumeroSQL(THIS.this_nVars)             + ","
            loc_cSQL = loc_cSQL + " descs = "      + FormatarNumeroSQL(THIS.this_nDesconto)         + ","
            loc_cSQL = loc_cSQL + " notas = "      + EscaparSQL(ALLTRIM(THIS.this_cNotas))          + ","
            loc_cSQL = loc_cSQL + " obses = "      + EscaparSQL(THIS.this_cObses)                   + ","
            loc_cSQL = loc_cSQL + " codobs = "     + FormatarNumeroSQL(THIS.this_nCodobs)           + ","
            loc_cSQL = loc_cSQL + " opers = "      + EscaparSQL(ALLTRIM(THIS.this_cOpers))          + ","
            loc_cSQL = loc_cSQL + " ecfs = "       + EscaparSQL(ALLTRIM(THIS.this_cEcfs))           + ","
            loc_cSQL = loc_cSQL + " mascnum = "    + EscaparSQL(ALLTRIM(THIS.this_cMascnum))        + ","
            loc_cSQL = loc_cSQL + " tabds = "      + EscaparSQL(ALLTRIM(THIS.this_cTabds))          + ","
            loc_cSQL = loc_cSQL + " lprecos = "    + EscaparSQL(ALLTRIM(THIS.this_cLprecos))        + ","
            loc_cSQL = loc_cSQL + " tpfats = "     + EscaparSQL(ALLTRIM(THIS.this_cTpfats))         + ","
            loc_cSQL = loc_cSQL + " transps = "    + IIF(!EMPTY(THIS.this_cTransps), "1", "0")      + ","
            loc_cSQL = loc_cSQL + " empds = "      + EscaparSQL(ALLTRIM(THIS.this_cEmpds))          + ","
            loc_cSQL = loc_cSQL + " locals = "     + EscaparSQL(ALLTRIM(THIS.this_cLocals))         + ","
            loc_cSQL = loc_cSQL + " tpmovs = "     + EscaparSQL(ALLTRIM(THIS.this_cTpMovs))         + ","
            loc_cSQL = loc_cSQL + " codtrans = "   + EscaparSQL(ALLTRIM(THIS.this_cCodtrans))       + ","
            loc_cSQL = loc_cSQL + " meiotrans = "  + EscaparSQL(ALLTRIM(THIS.this_cMeiotrans))      + ","
            loc_cSQL = loc_cSQL + " compet = "     + EscaparSQL(ALLTRIM(THIS.this_cCompets))        + ","
            loc_cSQL = loc_cSQL + " ntrans = "     + FormatarNumeroSQL(THIS.this_nNtrans)           + ","
            loc_cSQL = loc_cSQL + " numolds = "    + FormatarNumeroSQL(THIS.this_nNumolds)          + ","
            loc_cSQL = loc_cSQL + " lotechqs = "   + FormatarNumeroSQL(THIS.this_nLotechqs)         + ","
            loc_cSQL = loc_cSQL + " chkbxparcs = " + IIF(THIS.this_lChkbxparcs, "1", "0")          + ","
            loc_cSQL = loc_cSQL + " chksubn = "    + IIF(THIS.this_lChksubn, "1", "0")             + ","
            loc_cSQL = loc_cSQL + " devols = "     + IIF(THIS.this_lDevols, "1", "0")              + ","
            loc_cSQL = loc_cSQL + " lcancelas = "  + IIF(THIS.this_lCancelas, "1", "0")            + ","
            loc_cSQL = loc_cSQL + " chkencerra = " + IIF(THIS.this_lChkregister, "1", "0")         + ","
            loc_cSQL = loc_cSQL + " fpubls = "     + EscaparSQL(ALLTRIM(THIS.this_cFpubls))         + ","
            loc_cSQL = loc_cSQL + " usuals = "     + EscaparSQL(ALLTRIM(THIS.this_cUsualts))        + ","
            loc_cSQL = loc_cSQL + " dtalts = GETDATE()"
            loc_cSQL = loc_cSQL + " WHERE empdopnums = " + EscaparSQL(ALLTRIM(THIS.this_cEmpDopNums))

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nResultado > 0
                THIS.RegistrarAuditoria("UPDATE")
                loc_lSucesso = .T.
            ELSE
                THIS.this_cMensagemErro = CapturarErroSQL()
            ENDIF
        CATCH TO loException
            MostrarErro(loException, "sigmvcabBO.Atualizar")
            THIS.this_cMensagemErro = loException.Message
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * ExecutarExclusao - Executa DELETE na tabela SigMvCab
    *==========================================================================
    PROTECTED PROCEDURE ExecutarExclusao()
        LOCAL loc_lSucesso, loc_cSQL, loc_nResultado
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "DELETE FROM SigMvCab" + ;
                       " WHERE empdopnums = " + EscaparSQL(ALLTRIM(THIS.this_cEmpDopNums))

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nResultado > 0
                THIS.RegistrarAuditoria("DELETE")
                loc_lSucesso = .T.
            ELSE
                THIS.this_cMensagemErro = CapturarErroSQL()
            ENDIF
        CATCH TO loException
            MostrarErro(loException, "sigmvcabBO.ExecutarExclusao")
            THIS.this_cMensagemErro = loException.Message
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

ENDDEFINE

*============================================================================
* SigPrGloBO.prg - Business Object para Processamento de O.P. (SIGPRGLO)
*
* Form OPERACIONAL (SIGPRGLO / FormSigPrGlo): tela de parametros que dispara
* o processamento em lote de Ordens de Producao a partir das movimentacoes
* em aberto (SigMvCab/SigMvItn), filtradas por periodo de emissao/entrega,
* operacao, conta (compradora) e conta responsavel (vendedor), gravando o
* resultado em cursores temporarios (SigTempd/CrSigTempd) antes de efetivar
* a geracao das O.P.s (SigOpPic/SigOpPii/SigCdNec/...).
*
* Reusado pelo legado em tres modos, controlados pelos parametros do Init:
*   - Processamento normal de O.P. (this_lReserva=.F., this_lGerPorTp=.F.)
*   - Reserva Automatica (this_lReserva=.T.)
*   - Processamento por Tipo de O.P. (this_lGerPorTp=.T., habilita Container1)
*
* Herda de: BusinessBase
* Criado em: Fase 1 - Propriedades e Init
* Completado em: Fase 2 - Metodos de processamento (Processar/CarregarDoCursor)
*============================================================================

DEFINE CLASS SigPrGloBO AS BusinessBase

    *==========================================================================
    * Flags de modo - equivalem a ThisForm.Reserva/automatico/Pordestino/
    * GerPorTp do legado, recebidos via parametro no Init do form legado
    * (LParameters _Reserva, _Autom, _PorDestino, lcNomeFrm1, pTipo)
    *==========================================================================
    this_lReserva     = .F.   && .T. = "Processar Reserva Automatica"
    this_lAutomatico  = .F.   && .T. = processamento automatico (sem interacao)
    this_lPorDestino  = .F.   && .T. = globalizacao por destino
    this_lGerPorTp    = .F.   && .T. = "Processar Ordem de Producao por Tipo" (habilita Container1/Get_TpGOp)

    *==========================================================================
    * Filtros - Periodo de Emissao e Previsao de Entrega (GetDataei/GetDataef/
    * GetDatapi/GetDatapf)
    *==========================================================================
    this_dDataEmissaoIni  = {}   && GetDataei - periodo de emissao, de
    this_dDataEmissaoFim  = {}   && GetDataef - periodo de emissao, ate
    this_dDataPrazoIni    = {}   && GetDatapi - previsao de entrega, de
    this_dDataPrazoFim    = {}   && GetDatapf - previsao de entrega, ate

    *==========================================================================
    * Filtros - Conta (Movimentacao) - container Conta (Get_grupo/Get_conta/
    * Get_dconta) - SigMvCab.GrupoOs/ContaOs quando Globalizas=1
    *==========================================================================
    this_cContaGrupo      = SPACE(10)  && Conta.Get_grupo
    this_cContaConta      = SPACE(10)  && Conta.Get_conta
    this_cContaDescricao  = SPACE(40)  && Conta.Get_dconta (lookup, nao gravado)

    *==========================================================================
    * Filtros - Responsavel/Vendedor - container Responsavel (Get_grupo/
    * Get_conta/Get_dconta) - SigMvCab.GrVends/Vends
    *==========================================================================
    this_cRespGrupo       = SPACE(10)  && Responsavel.Get_grupo
    this_cRespConta       = SPACE(10)  && Responsavel.Get_conta
    this_cRespDescricao   = SPACE(40)  && Responsavel.Get_dconta (lookup, nao gravado)

    *==========================================================================
    * Filtros - Movimentacao/Operacao - container Operacao (Get_Operacao/
    * Get_Operacaoi/Get_Operacaof) - SigCdOpe.Dopes / SigMvCab.Numes
    *==========================================================================
    this_cOperacao        = SPACE(20)  && Operacao.Get_Operacao
    this_nOperacaoIni     = 0          && Operacao.Get_Operacaoi
    this_nOperacaoFim     = 0          && Operacao.Get_Operacaof

    *==========================================================================
    * Filtro - Empresa - container Empresa (get_cd_empresa/get_ds_empresa/
    * Chec_pedra) - SigCdEmp.Cemps/Razas
    *==========================================================================
    this_cEmpresaCodigo   = SPACE(3)   && Empresa.get_cd_empresa - SigCdEmp.Cemps
    this_cEmpresaRazao    = SPACE(40)  && Empresa.get_ds_empresa - SigCdEmp.Razas (lookup)
    this_lNaoEmpenharPedra = .F.       && Empresa.Chec_pedra - "Nao Empenhar Pedras"

    *==========================================================================
    * Previsao/Geracao - container Cnt_Previsao (GetPrevisao/GetGeracao)
    *==========================================================================
    this_dPrevisaoEntrega = {}   && Cnt_Previsao.GetPrevisao - Date() + SigCdPam.PrevProds
    this_dDataGeracao     = {}   && Cnt_Previsao.GetGeracao  - Date() quando nao automatico

    *==========================================================================
    * Numero da O.P. manual - container Cnt_Op (GetNop), visivel apenas
    * quando SigCdPam.GlobAutos = 2 And !this_lReserva
    *==========================================================================
    this_nNumeroOP        = 0    && Cnt_Op.GetNop

    *==========================================================================
    * Tipo de Geracao da OP - Container1 (Get_TpGOp), habilitado apenas
    * quando this_lGerPorTp = .T. - SigInTgo.Codigos
    *==========================================================================
    this_cTipoGeracaoOP   = SPACE(10)  && Container1.Get_TpGOp

    *==========================================================================
    * Parametros do sistema (SigCdPam), carregados uma unica vez no Init -
    * equivalente ao CursorQuery('SigCdPam','crSigCdPam',...,[lcCampos]) do
    * Init() legado
    *==========================================================================
    this_cPamDopEmphs     = SPACE(20)  && SigCdPam.dopemphs
    this_cPamDopReqcs     = SPACE(20)  && SigCdPam.dopreqcs
    this_cPamDopPedcs     = SPACE(20)  && SigCdPam.doppedcs
    this_cPamDopComps     = SPACE(20)  && SigCdPam.dopcomps
    this_cPamTransfRes    = SPACE(20)  && SigCdPam.transfres
    this_cPamGrPadClis    = SPACE(10)  && SigCdPam.grpadclis
    this_cPamDoppPads     = SPACE(20)  && SigCdPam.dopppads
    this_cPamDopTrfCps    = SPACE(20)  && SigCdPam.doptrfcps
    this_cPamGrPadVens    = SPACE(10)  && SigCdPam.grpadvens
    this_nPamPrevProds    = 0          && SigCdPam.prevprods
    this_cPamGrupoEsts    = SPACE(10)  && SigCdPam.grupoests
    this_cPamContaEsts    = SPACE(10)  && SigCdPam.contaests
    this_cPamGruReservs   = SPACE(10)  && SigCdPam.grureservs
    this_cPamConReservs   = SPACE(10)  && SigCdPam.conreservs
    this_nPamAgrupEmph    = 0          && SigCdPam.agrupemph
    this_cPamDoppServs    = SPACE(20)  && SigCdPam.doppservs
    this_nPamMascnums     = 0          && SigCdPam.mascnums
    this_cPamGruEstps     = SPACE(10)  && SigCdPam.gruestps
    this_cPamConEstps     = SPACE(10)  && SigCdPam.conestps
    this_cPamTransfencs   = SPACE(20)  && SigCdPam.transfencs
    this_cPamOuros        = SPACE(14)  && SigCdPam.ouros
    this_cPamGruConfs     = SPACE(10)  && SigCdPam.gruconfs
    this_cPamConConfs     = SPACE(10)  && SigCdPam.conconfs
    this_nPamGlobAutos    = 0          && SigCdPam.globautos
    this_cPamDopEntAus    = SPACE(20)  && SigCdPam.dopentaus
    this_cPamTpOpEntAus   = SPACE(15)  && SigCdPam.tpopentaus
    this_nPamAutComps     = 0          && SigCdPam.autcomps

    *==========================================================================
    * Colunas da tabela de staging SigTempd (this_cTabela/this_cCampoChave
    * definidos no Init) - equivalente ao cursor crSigTempd amarrado via
    * .Podatamgr2.AddCursor('SigTempd','CidChaves','CrSigTempd','','') do
    * Init legado. Prefixo "Td" evita colisao com as properties de filtro/
    * parametro acima (este bloco espelha a TABELA, nao a tela)
    *==========================================================================
    this_cTdCidChaves     = SPACE(64)  && cidchaves - chave primaria (NOT NULL)
    this_nTdCbars         = 0          && cbars
    this_cTdCgrus         = SPACE(3)   && cgrus
    this_cTdCidQuerys     = SPACE(20)  && cidquerys
    this_cTdCpros         = SPACE(10)  && cpros
    this_cTdEmpDopNums    = SPACE(29)  && empdopnums
    this_cTdEmpos         = SPACE(3)   && empos
    this_nTdQtds          = 0          && qtds
    this_cTdCmoes         = SPACE(3)   && cmoes
    this_cTdCnSuAdms      = SPACE(20)  && cnsuadms
    this_nTdCodObs        = 0          && codobs
    this_cTdContas        = SPACE(10)  && contas
    this_dTdDatas         = {}         && datas
    this_cTdDgopes        = SPACE(20)  && dgopes
    this_cTdDopes         = SPACE(20)  && dopes
    this_cTdDpros         = SPACE(65)  && dpros (NOT NULL)
    this_dTdDtAlts        = {}         && dtalts
    this_cTdEmpDopNum2    = SPACE(29)  && empdopnum2
    this_cTdEmpGruEsts    = SPACE(23)  && empgruests
    this_cTdEmps          = SPACE(3)   && emps
    this_cTdGrupos        = SPACE(10)  && grupos
    this_cTdMascNum       = SPACE(10)  && mascnum
    this_nTdNopers        = 0          && nopers
    this_nTdNumes         = 0          && numes
    this_cTdObss          = ""         && obss (memo)
    this_cTdOpers         = SPACE(1)   && opers
    this_cTdRazas         = SPACE(40)  && razas
    this_nTdValors        = 0          && valors
    this_nTdValpres       = 0          && valpres
    this_cTdDescrs        = SPACE(80)  && descrs
    this_cTdNewFld        = SPACE(10)  && newfld
    this_nTdVars          = 0          && vars

    *==========================================================================
    * Init - Inicializa o Business Object configurando a tabela/chave de
    * referencia (SigTempd/CidChaves - AddCursor('SigTempd','CidChaves',
    * 'CrSigTempd','','') do Init legado) e carrega os parametros do sistema
    * usados no processamento (SigCdPam)
    *==========================================================================
    PROCEDURE Init()
        LOCAL loc_lResultado, loc_oErro
        loc_lResultado = .F.

        TRY
            DODEFAULT()
            THIS.this_cTabela     = "SigTempd"
            THIS.this_cCampoChave = "cidchaves"

            IF TYPE("gnConnHandle") = "N" AND gnConnHandle > 0

                IF USED("cursor_4c_SigCdPam")
                    USE IN cursor_4c_SigCdPam
                ENDIF
                SQLEXEC(gnConnHandle, ;
                    "SELECT dopemphs, dopreqcs, doppedcs, dopcomps, transfres, " + ;
                    "grpadclis, dopppads, doptrfcps, grpadvens, prevprods, " + ;
                    "grupoests, contaests, grureservs, conreservs, agrupemph, " + ;
                    "doppservs, mascnums, gruestps, conestps, transfencs, ouros, " + ;
                    "gruconfs, conconfs, globautos, dopentaus, tpopentaus, autcomps " + ;
                    "FROM SigCdPam", ;
                    "cursor_4c_SigCdPam")

                IF USED("cursor_4c_SigCdPam") AND !EOF("cursor_4c_SigCdPam")
                    THIS.this_cPamDopEmphs   = PADR(TratarNulo(cursor_4c_SigCdPam.dopemphs, ""), 20)
                    THIS.this_cPamDopReqcs   = PADR(TratarNulo(cursor_4c_SigCdPam.dopreqcs, ""), 20)
                    THIS.this_cPamDopPedcs   = PADR(TratarNulo(cursor_4c_SigCdPam.doppedcs, ""), 20)
                    THIS.this_cPamDopComps   = PADR(TratarNulo(cursor_4c_SigCdPam.dopcomps, ""), 20)
                    THIS.this_cPamTransfRes  = PADR(TratarNulo(cursor_4c_SigCdPam.transfres, ""), 20)
                    THIS.this_cPamGrPadClis  = PADR(TratarNulo(cursor_4c_SigCdPam.grpadclis, ""), 10)
                    THIS.this_cPamDoppPads   = PADR(TratarNulo(cursor_4c_SigCdPam.dopppads, ""), 20)
                    THIS.this_cPamDopTrfCps  = PADR(TratarNulo(cursor_4c_SigCdPam.doptrfcps, ""), 20)
                    THIS.this_cPamGrPadVens  = PADR(TratarNulo(cursor_4c_SigCdPam.grpadvens, ""), 10)
                    THIS.this_nPamPrevProds  = TratarNulo(cursor_4c_SigCdPam.prevprods, 0)
                    THIS.this_cPamGrupoEsts  = PADR(TratarNulo(cursor_4c_SigCdPam.grupoests, ""), 10)
                    THIS.this_cPamContaEsts  = PADR(TratarNulo(cursor_4c_SigCdPam.contaests, ""), 10)
                    THIS.this_cPamGruReservs = PADR(TratarNulo(cursor_4c_SigCdPam.grureservs, ""), 10)
                    THIS.this_cPamConReservs = PADR(TratarNulo(cursor_4c_SigCdPam.conreservs, ""), 10)
                    THIS.this_nPamAgrupEmph  = TratarNulo(cursor_4c_SigCdPam.agrupemph, 0)
                    THIS.this_cPamDoppServs  = PADR(TratarNulo(cursor_4c_SigCdPam.doppservs, ""), 20)
                    THIS.this_nPamMascnums   = TratarNulo(cursor_4c_SigCdPam.mascnums, 0)
                    THIS.this_cPamGruEstps   = PADR(TratarNulo(cursor_4c_SigCdPam.gruestps, ""), 10)
                    THIS.this_cPamConEstps   = PADR(TratarNulo(cursor_4c_SigCdPam.conestps, ""), 10)
                    THIS.this_cPamTransfencs = PADR(TratarNulo(cursor_4c_SigCdPam.transfencs, ""), 20)
                    THIS.this_cPamOuros      = PADR(TratarNulo(cursor_4c_SigCdPam.ouros, ""), 14)
                    THIS.this_cPamGruConfs   = PADR(TratarNulo(cursor_4c_SigCdPam.gruconfs, ""), 10)
                    THIS.this_cPamConConfs   = PADR(TratarNulo(cursor_4c_SigCdPam.conconfs, ""), 10)
                    THIS.this_nPamGlobAutos  = TratarNulo(cursor_4c_SigCdPam.globautos, 0)
                    THIS.this_cPamDopEntAus  = PADR(TratarNulo(cursor_4c_SigCdPam.dopentaus, ""), 20)
                    THIS.this_cPamTpOpEntAus = PADR(TratarNulo(cursor_4c_SigCdPam.tpopentaus, ""), 15)
                    THIS.this_nPamAutComps   = TratarNulo(cursor_4c_SigCdPam.autcomps, 0)
                ENDIF
                IF USED("cursor_4c_SigCdPam")
                    USE IN cursor_4c_SigCdPam
                ENDIF

                * Valores padrao equivalentes ao final do Init legado -
                * Conta.Get_Grupo/Responsavel.Get_Grupo iniciam em branco
                * (o legado zera mesmo tendo crSigCdPam.GrPadClis/GrPadVens
                * disponivel - comentario "&&crSigCdPam.GrPadClis" mostra que
                * a atribuicao real foi desativada no legado) e a Previsao de
                * Entrega parte de Date() + PrevProds
                THIS.this_cContaGrupo      = SPACE(10)
                THIS.this_cRespGrupo       = SPACE(10)
                THIS.this_dPrevisaoEntrega = DATE() + THIS.this_nPamPrevProds

                IF !THIS.this_lAutomatico
                    THIS.this_dDataGeracao = DATE()
                ENDIF

            ENDIF

            loc_lResultado = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Mapeia a linha corrente do cursor de staging
    * (crSigTempd/SigTempd, amarrado no Init via AddCursor) para as
    * properties this_Td* desta classe
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        IF !EMPTY(par_cAliasCursor) AND USED(par_cAliasCursor)
            SELECT (par_cAliasCursor)
            THIS.this_cTdCidChaves  = TratarNulo(cidchaves, "")
            THIS.this_nTdCbars      = TratarNulo(cbars, 0)
            THIS.this_cTdCgrus      = TratarNulo(cgrus, "")
            THIS.this_cTdCidQuerys  = TratarNulo(cidquerys, "")
            THIS.this_cTdCpros      = TratarNulo(cpros, "")
            THIS.this_cTdEmpDopNums = TratarNulo(empdopnums, "")
            THIS.this_cTdEmpos      = TratarNulo(empos, "")
            THIS.this_nTdQtds       = TratarNulo(qtds, 0)
            THIS.this_cTdCmoes      = TratarNulo(cmoes, "")
            THIS.this_cTdCnSuAdms   = TratarNulo(cnsuadms, "")
            THIS.this_nTdCodObs     = TratarNulo(codobs, 0)
            THIS.this_cTdContas     = TratarNulo(contas, "")
            THIS.this_dTdDatas      = TratarNulo(datas, {})
            THIS.this_cTdDgopes     = TratarNulo(dgopes, "")
            THIS.this_cTdDopes      = TratarNulo(dopes, "")
            THIS.this_cTdDpros      = TratarNulo(dpros, "")
            THIS.this_dTdDtAlts     = TratarNulo(dtalts, {})
            THIS.this_cTdEmpDopNum2 = TratarNulo(empdopnum2, "")
            THIS.this_cTdEmpGruEsts = TratarNulo(empgruests, "")
            THIS.this_cTdEmps       = TratarNulo(emps, "")
            THIS.this_cTdGrupos     = TratarNulo(grupos, "")
            THIS.this_cTdMascNum    = TratarNulo(mascnum, "")
            THIS.this_nTdNopers     = TratarNulo(nopers, 0)
            THIS.this_nTdNumes      = TratarNulo(numes, 0)
            THIS.this_cTdObss       = TratarNulo(obss, "")
            THIS.this_cTdOpers      = TratarNulo(opers, "")
            THIS.this_cTdRazas      = TratarNulo(razas, "")
            THIS.this_nTdValors     = TratarNulo(valors, 0)
            THIS.this_nTdValpres    = TratarNulo(valpres, 0)
            THIS.this_cTdDescrs     = TratarNulo(descrs, "")
            THIS.this_cTdNewFld     = TratarNulo(newfld, "")
            THIS.this_nTdVars       = TratarNulo(vars, 0)
            loc_lSucesso = .T.
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Chave primaria da tabela de staging (cidchaves)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ObterChavePrimaria()
        RETURN ALLTRIM(THIS.this_cTdCidChaves)
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir - INSERT completo em SigTempd (tabela de staging amarrada via
    * AddCursor no Init legado, sem query = registro inteiro gravado). Cobre
    * as duas colunas NOT NULL sem default (cidchaves via fUniqueIds() quando
    * ausente, dpros com valor em branco) e todas as demais colunas do schema.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Inserir()
        LOCAL loc_lSucesso, loc_nResultado, loc_oErro, loc_cSQL
        loc_lSucesso = .F.

        IF EMPTY(ALLTRIM(THIS.this_cTdCidChaves))
            THIS.this_cTdCidChaves = fUniqueIds()
        ENDIF
        IF EMPTY(ALLTRIM(THIS.this_cTdDpros))
            THIS.this_cTdDpros = " "
        ENDIF

        TRY
            loc_cSQL = "INSERT INTO SigTempd (" + ;
                "cidchaves, cbars, cgrus, cidquerys, cpros, empdopnums, empos, qtds, " + ;
                "cmoes, cnsuadms, codobs, contas, datas, dgopes, dopes, dpros, dtalts, " + ;
                "empdopnum2, empgruests, emps, grupos, mascnum, nopers, numes, obss, " + ;
                "opers, razas, valors, valpres, descrs, newfld, vars" + ;
                ") VALUES (" + ;
                EscaparSQL(LEFT(ALLTRIM(THIS.this_cTdCidChaves), 64)) + ", " + ;
                FormatarNumeroSQL(THIS.this_nTdCbars, 0) + ", " + ;
                EscaparSQL(LEFT(THIS.this_cTdCgrus, 3)) + ", " + ;
                EscaparSQL(LEFT(THIS.this_cTdCidQuerys, 20)) + ", " + ;
                EscaparSQL(LEFT(THIS.this_cTdCpros, 10)) + ", " + ;
                EscaparSQL(LEFT(THIS.this_cTdEmpDopNums, 29)) + ", " + ;
                EscaparSQL(LEFT(THIS.this_cTdEmpos, 3)) + ", " + ;
                FormatarNumeroSQL(THIS.this_nTdQtds, 2) + ", " + ;
                EscaparSQL(LEFT(THIS.this_cTdCmoes, 3)) + ", " + ;
                EscaparSQL(LEFT(THIS.this_cTdCnSuAdms, 20)) + ", " + ;
                FormatarNumeroSQL(THIS.this_nTdCodObs, 0) + ", " + ;
                EscaparSQL(LEFT(THIS.this_cTdContas, 10)) + ", " + ;
                FormatarDataSQL(THIS.this_dTdDatas) + ", " + ;
                EscaparSQL(LEFT(THIS.this_cTdDgopes, 20)) + ", " + ;
                EscaparSQL(LEFT(THIS.this_cTdDopes, 20)) + ", " + ;
                EscaparSQL(LEFT(ALLTRIM(THIS.this_cTdDpros), 65)) + ", " + ;
                FormatarDataSQL(THIS.this_dTdDtAlts) + ", " + ;
                EscaparSQL(LEFT(THIS.this_cTdEmpDopNum2, 29)) + ", " + ;
                EscaparSQL(LEFT(THIS.this_cTdEmpGruEsts, 23)) + ", " + ;
                EscaparSQL(LEFT(THIS.this_cTdEmps, 3)) + ", " + ;
                EscaparSQL(LEFT(THIS.this_cTdGrupos, 10)) + ", " + ;
                EscaparSQL(LEFT(THIS.this_cTdMascNum, 10)) + ", " + ;
                FormatarNumeroSQL(THIS.this_nTdNopers, 0) + ", " + ;
                FormatarNumeroSQL(THIS.this_nTdNumes, 0) + ", " + ;
                EscaparSQL(THIS.this_cTdObss) + ", " + ;
                EscaparSQL(LEFT(THIS.this_cTdOpers, 1)) + ", " + ;
                EscaparSQL(LEFT(THIS.this_cTdRazas, 40)) + ", " + ;
                FormatarNumeroSQL(THIS.this_nTdValors, 2) + ", " + ;
                FormatarNumeroSQL(THIS.this_nTdValpres, 0) + ", " + ;
                EscaparSQL(LEFT(THIS.this_cTdDescrs, 80)) + ", " + ;
                EscaparSQL(LEFT(THIS.this_cTdNewFld, 10)) + ", " + ;
                FormatarNumeroSQL(THIS.this_nTdVars, 4) + ")"

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 1
                THIS.RegistrarAuditoria("INSERT")
                loc_lSucesso = .T.
            ELSE
                THIS.this_cMensagemErro = "Erro ao inserir registro em SigTempd." + CHR(13) + CapturarErroSQL()
                MsgErro(THIS.this_cMensagemErro, "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro ao Inserir")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - UPDATE completo em SigTempd pela chave cidchaves
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Atualizar()
        LOCAL loc_lSucesso, loc_nResultado, loc_oErro, loc_cSQL
        loc_lSucesso = .F.

        IF EMPTY(ALLTRIM(THIS.this_cTdCidChaves))
            THIS.this_cMensagemErro = "Chave do registro (cidchaves) n" + CHR(227) + "o informada para atualiza" + CHR(231) + CHR(227) + "o."
            RETURN .F.
        ENDIF

        TRY
            loc_cSQL = "UPDATE SigTempd SET " + ;
                "cbars = " + FormatarNumeroSQL(THIS.this_nTdCbars, 0) + ", " + ;
                "cgrus = " + EscaparSQL(LEFT(THIS.this_cTdCgrus, 3)) + ", " + ;
                "cidquerys = " + EscaparSQL(LEFT(THIS.this_cTdCidQuerys, 20)) + ", " + ;
                "cpros = " + EscaparSQL(LEFT(THIS.this_cTdCpros, 10)) + ", " + ;
                "empdopnums = " + EscaparSQL(LEFT(THIS.this_cTdEmpDopNums, 29)) + ", " + ;
                "empos = " + EscaparSQL(LEFT(THIS.this_cTdEmpos, 3)) + ", " + ;
                "qtds = " + FormatarNumeroSQL(THIS.this_nTdQtds, 2) + ", " + ;
                "cmoes = " + EscaparSQL(LEFT(THIS.this_cTdCmoes, 3)) + ", " + ;
                "cnsuadms = " + EscaparSQL(LEFT(THIS.this_cTdCnSuAdms, 20)) + ", " + ;
                "codobs = " + FormatarNumeroSQL(THIS.this_nTdCodObs, 0) + ", " + ;
                "contas = " + EscaparSQL(LEFT(THIS.this_cTdContas, 10)) + ", " + ;
                "datas = " + FormatarDataSQL(THIS.this_dTdDatas) + ", " + ;
                "dgopes = " + EscaparSQL(LEFT(THIS.this_cTdDgopes, 20)) + ", " + ;
                "dopes = " + EscaparSQL(LEFT(THIS.this_cTdDopes, 20)) + ", " + ;
                "dpros = " + EscaparSQL(LEFT(ALLTRIM(THIS.this_cTdDpros), 65)) + ", " + ;
                "dtalts = " + FormatarDataSQL(THIS.this_dTdDtAlts) + ", " + ;
                "empdopnum2 = " + EscaparSQL(LEFT(THIS.this_cTdEmpDopNum2, 29)) + ", " + ;
                "empgruests = " + EscaparSQL(LEFT(THIS.this_cTdEmpGruEsts, 23)) + ", " + ;
                "emps = " + EscaparSQL(LEFT(THIS.this_cTdEmps, 3)) + ", " + ;
                "grupos = " + EscaparSQL(LEFT(THIS.this_cTdGrupos, 10)) + ", " + ;
                "mascnum = " + EscaparSQL(LEFT(THIS.this_cTdMascNum, 10)) + ", " + ;
                "nopers = " + FormatarNumeroSQL(THIS.this_nTdNopers, 0) + ", " + ;
                "numes = " + FormatarNumeroSQL(THIS.this_nTdNumes, 0) + ", " + ;
                "obss = " + EscaparSQL(THIS.this_cTdObss) + ", " + ;
                "opers = " + EscaparSQL(LEFT(THIS.this_cTdOpers, 1)) + ", " + ;
                "razas = " + EscaparSQL(LEFT(THIS.this_cTdRazas, 40)) + ", " + ;
                "valors = " + FormatarNumeroSQL(THIS.this_nTdValors, 2) + ", " + ;
                "valpres = " + FormatarNumeroSQL(THIS.this_nTdValpres, 0) + ", " + ;
                "descrs = " + EscaparSQL(LEFT(THIS.this_cTdDescrs, 80)) + ", " + ;
                "newfld = " + EscaparSQL(LEFT(THIS.this_cTdNewFld, 10)) + ", " + ;
                "vars = " + FormatarNumeroSQL(THIS.this_nTdVars, 4) + " " + ;
                "WHERE cidchaves = " + EscaparSQL(LEFT(ALLTRIM(THIS.this_cTdCidChaves), 64))

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 1
                THIS.RegistrarAuditoria("UPDATE")
                loc_lSucesso = .T.
            ELSE
                THIS.this_cMensagemErro = "Erro ao atualizar registro em SigTempd." + CHR(13) + CapturarErroSQL()
                MsgErro(THIS.this_cMensagemErro, "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro ao Atualizar")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Nota de arquitetura: este form nao exclui registros de SigTempd (o
    * Click do botao Processar do legado so cria/consulta cursores locais
    * TmpCabec/TmpItens e delega a SigPrGl2 - ver SigPrGl2BO.ExecutarProcessamento
    * para o ciclo completo de escrita/limpeza do staging). O comportamento
    * padrao herdado de BusinessBase para ExecutarExclusao() ja e o correto
    * aqui.
    *--------------------------------------------------------------------------

    *--------------------------------------------------------------------------
    * FecharCursoresProcessamento - fecha os cursores de trabalho de uma
    * execucao anterior de Processar() (idempotente - permite clicar em
    * Processar mais de uma vez na mesma sessao do form sem "Alias already
    * in use")
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE FecharCursoresProcessamento()
        LOCAL loc_aCursores[12], loc_nI
        loc_aCursores[1]  = "TmpOper"
        loc_aCursores[2]  = "TmpCabec"
        loc_aCursores[3]  = "TmpItens"
        loc_aCursores[4]  = "crSigCdOpd"
        loc_aCursores[5]  = "Produtos"
        loc_aCursores[6]  = "cursor_4c_TempEest"
        loc_aCursores[7]  = "cursor_4c_TempEestI"
        loc_aCursores[8]  = "cursor_4c_TempEsti2"
        loc_aCursores[9]  = "crSigCdPro"
        loc_aCursores[10] = "crSigCdGrp"
        loc_aCursores[11] = "crSigPrMtz"
        loc_aCursores[12] = "crLocalCli"

        FOR loc_nI = 1 TO ALEN(loc_aCursores)
            IF USED(loc_aCursores[loc_nI])
                USE IN (loc_aCursores[loc_nI])
            ENDIF
        ENDFOR
    ENDPROC

    *--------------------------------------------------------------------------
    * Processar - Transcricao do Click do botao Processar (SIGPRGLO.Processar.
    * Click, tasks\task615\SigPrGlo_form_codigo_fonte.txt linhas 1383-1703):
    * varre as movimentacoes em aberto (SigMvCab/SigMvItn/SigMvIts) que casam
    * com os filtros da tela e monta os cursores TmpCabec/TmpItens - deixados
    * ABERTOS na DataSession corrente para o FormSigPrGl2 (Do Form SigPrGl2
    * With ... do legado), que exige a estrutura fixada em
    * FormSigPrGl2.ConfigurarGrids/SigPrGl2BO.CarregarDoCursor (task614) -
    * NAO alterar nomes/tamanhos de campo aqui sem alterar o form filho junto.
    *
    * O contrato do form filho RENOMEOU o antigo par Grupo/Conta (legado) para
    * GrupoOs/ContaOs (grupo e conta DE ORIGEM, copiados literais de
    * SigMvCab) e manteve Conta/DConta como o codigo/descricao da conta
    * RESOLVIDA por Globalizas (_ContaG do legado - exibida como "Cliente" na
    * grade do form filho, ver FormSigPrGl2.prg:354-357). O campo Grupov
    * (GrVends) do legado nao existe mais no contrato - CarregarDoCursor do
    * SigPrGl2BO nao le esse campo.
    *
    * NAO transcrito (codigo morto/de depuracao no legado, conferido linha a
    * linha no dump e contra o form filho - grep em SigPrGl2BO.prg/
    * FormSigPrGl2.prg confirmando ausencia de uso):
    *   - "Set Step On" (abre o debugger do VFP - nao pode ir para producao)
    *   - bloco comentado (*!*) de override de _Dopp por TmpSigInTgo.Dopps
    *   - cursor DBParam (criado, nunca lido - nem pelo proprio Click nem
    *     pelo form filho)
    *   - CrSigCdPac/CrTmpTpGop dentro do Click (alimentavam so o DBParam
    *     morto - os dois cursores tem uso LEGITIMO em outro lugar do form,
    *     mas nao aqui)
    *   - cursor SelPedra (criado, nunca populado nem lido em lugar nenhum)
    *
    * Retorna .T. mesmo quando nenhum item casar com o filtro (TmpCabec/
    * TmpItens ficam vazios, porem existentes) - quem decide a mensagem
    * "Nenhum Item Selecionado Para Processar!!!" e o FORM, olhando
    * RECCOUNT() depois da chamada (mesma fonte unica ja usada na regra de
    * grade/validacao: o BO calcula, o form so espelha). Retorna .F. so em
    * falha de validacao (guardado em this_cMensagemErro) ou falha de SQL.
    *--------------------------------------------------------------------------
    FUNCTION Processar(par_dDataEmiIni, par_dDataEmiFim, par_dDataPzoIni, par_dDataPzoFim, ;
            par_cOperacao, par_nOperacaoIni, par_nOperacaoFim, ;
            par_cContaGrupo, par_cContaConta, par_cRespGrupo, par_cRespConta, ;
            par_cEmpresa, par_cTipoGeracaoOP)

        LOCAL loc_lSucesso, loc_oErro, loc_nResultado
        LOCAL loc_cCondeDatas, loc_cCondpDatas, loc_cDopp, loc_cQuery
        LOCAL loc_cEdn, loc_lProcessa, loc_nTPeso, loc_nSaldo, loc_nPeso, loc_nBaixa, loc_nQtdTb
        LOCAL loc_cGrupoG, loc_cContaG, loc_cGrupoD, loc_cContaD
        LOCAL loc_oProg, loc_lAbortar

        loc_lSucesso = .F.
        loc_lAbortar = .F.
        THIS.this_cMensagemErro = ""

        *-- Validacao de intervalo invertido (mesma regra do Form - o BO
        *-- tambem garante isso para quem chamar Processar() direto). Fica
        *-- FORA do TRY de proposito: sao comparacoes puras de data, entao o
        *-- early-exit pode ser RETURN de verdade. Dentro de TRY o RETURN nao
        *-- retorna - ele ABANDONA o bloco e cai no CATCH (regra #1 do
        *-- CLAUDE.md), e o chamador receberia .T. com os cursores vazios.
        IF !EMPTY(par_dDataEmiFim) AND !EMPTY(par_dDataEmiIni) AND par_dDataEmiFim < par_dDataEmiIni
            THIS.this_cMensagemErro = "A Data Final Deve Ser Maior Que a Inicial!!!"
            RETURN .F.
        ENDIF
        IF !EMPTY(par_dDataPzoFim) AND !EMPTY(par_dDataPzoIni) AND par_dDataPzoFim < par_dDataPzoIni
            THIS.this_cMensagemErro = "A Data Final Deve Ser Maior Que a Inicial!!!"
            RETURN .F.
        ENDIF

        TRY
            THIS.FecharCursoresProcessamento()

            *-- _Conde (periodo de emissao) - so entra na consulta quando a
            *-- data final foi preenchida (guard identico ao legado). Upper
            *-- bound reescrito como "< dia seguinte" (equivalente a
            *-- "<= 23:59:59" do legado) porque FormatarDataSQL() nao aceita
            *-- hora
            IF EMPTY(par_dDataEmiFim)
                loc_cCondeDatas = ""
            ELSE
                loc_cCondeDatas = "Datas >= " + FormatarDataSQL(par_dDataEmiIni) + ;
                    " AND Datas < " + FormatarDataSQL(par_dDataEmiFim + 1) + " AND "
            ENDIF

            *-- _Condp (prazo de entrega) - transcricao literal da arvore de
            *-- IFs do legado (Ini/Fim podem vir isolados)
            IF EMPTY(par_dDataPzoIni)
                IF EMPTY(par_dDataPzoFim)
                    loc_cCondpDatas = ""
                ELSE
                    loc_cCondpDatas = "PrazoEnts < " + FormatarDataSQL(par_dDataPzoFim + 1) + " AND "
                ENDIF
            ELSE
                IF EMPTY(par_dDataPzoFim)
                    loc_cCondpDatas = "PrazoEnts >= " + FormatarDataSQL(par_dDataPzoIni) + " AND "
                ELSE
                    loc_cCondpDatas = "PrazoEnts >= " + FormatarDataSQL(par_dDataPzoIni) + ;
                        " AND PrazoEnts < " + FormatarDataSQL(par_dDataPzoFim + 1) + " AND "
                ENDIF
            ENDIF

            *-- TmpOper: operacoes validas para OP (Globalizas IN (1,2)),
            *-- equivalente ao TmpOper2->TmpOper do Init legado. Fica ABERTO
            *-- ao final - contrato de SigPrGl2BO.this_cCursorOperacoes, que
            *-- faz SEEK por Dopes sem SET ORDER previo
            loc_cQuery = "SELECT a.Dopes, a.Globalizas, a.Opers, ISNULL(a.Reservas,0) AS Reservas, " + ;
                "ISNULL(b.OpeGops,' ') AS OpeGops, ISNULL(b.CodTgOps,' ') AS CodTgOps, " + ;
                "ISNULL(b.chkObs,0) AS ChkObs, ISNULL(c.carcompos,0) AS carcompos " + ;
                "FROM SigCdOpe a LEFT JOIN SigOpCdd b ON b.dopes = a.dopes " + ;
                "LEFT JOIN SigOpCdc c ON a.dopes = c.dopes " + ;
                "WHERE a.Globalizas IN (1,2)"
            IF !EMPTY(par_cOperacao)
                loc_cQuery = loc_cQuery + " AND a.Dopes = " + EscaparSQL(par_cOperacao)
            ENDIF

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cQuery, "TmpOper")
            IF loc_nResultado < 1 OR !USED("TmpOper")
                THIS.this_cMensagemErro = "Favor Reinicializar o Processo!!! (TmpOper)" + CHR(13) + CapturarErroSQL()
                loc_lAbortar = .T.
            ENDIF

            IF !loc_lAbortar
                SELECT TmpOper
                INDEX ON Dopes TAG Dopes
                GO TOP
                IF EOF()
                    THIS.this_cMensagemErro = "Nenhuma Opera" + CHR(231) + CHR(227) + "o Configurada Para Processar Ordem de Produ" + CHR(231) + CHR(227) + "o!!!"
                    loc_lAbortar = .T.
                ENDIF
            ENDIF

            *-- Corpo da varredura guardado por loc_lAbortar: as falhas de SQL
            *-- e as validacoes acima nao podem sair por RETURN (regra #1 -
            *-- RETURN dentro de TRY abandona o bloco em vez de retornar), e os
            *-- SCAN aninhados propagam o aborto por EXIT em cascata.
            IF !loc_lAbortar
                *-- SigCdOpd (grupo/conta de DESTINO padrao da geracao) - _Dopp
                *-- vem do parametro de sistema ja carregado no Init (DoppPads)
                loc_cDopp = ALLTRIM(THIS.this_cPamDoppPads)
                SQLEXEC(gnConnHandle, "SELECT TOP 1 GruDests, ConDests FROM SigCdOpd WHERE Dopps = " + EscaparSQL(loc_cDopp), "crSigCdOpd")
                IF !USED("crSigCdOpd")
                    CREATE CURSOR crSigCdOpd (GruDests C(10), ConDests C(10))
                    APPEND BLANK
                ENDIF

                *-- Cursores de trabalho - estrutura EXATA exigida por
                *-- SigPrGl2BO.CarregarDoCursor/ExecutarProcessamento (contrato
                *-- fixado em FormSigPrGl2.ConfigurarGrids, task614)
                CREATE CURSOR TmpCabec (Flag L, Emps C(3), Dopes C(20), Numes N(6), ;
                    Datas D, Entregas D, Peso N(9,3), Contav C(10), Conta C(10), ;
                    DConta C(50), Obs M NULL, Notas C(6), GrupoOs C(10), ContaOs C(10), ;
                    GrupoDs C(10), ContaDs C(10), Jobs C(10))
                INDEX ON Emps + Dopes + STR(Numes, 6) TAG EmpDopNum
                INDEX ON DTOS(Entregas) + Emps + Dopes + STR(Numes, 6) TAG Entrega
                SET ORDER TO EmpDopNum

                CREATE CURSOR TmpItens (Emps C(3), Dopes C(20), Numes N(6), CPros C(14), ;
                    CodCors C(4), CodTams C(4), Linhas C(10), Citens N(10), Qtds N(10,3), ;
                    Saldo N(10,3), Peso N(9,3), Obs M NULL, Notas C(6), Dpros C(40), Reffs C(40))
                INDEX ON Emps + Dopes + STR(Numes, 6) TAG EmpDopNum
                INDEX ON CPros TAG CPros
                SET ORDER TO EmpDopNum

                *-- Varredura das operacoes validas (TmpOper) -> movimentacoes
                *-- em aberto (SigMvCab) -> itens (SigMvItn/SigMvIts)
                SELECT TmpOper
                SCAN
                    IF THIS.this_lGerPorTp AND ALLTRIM(TmpOper.CodTgOps) != ALLTRIM(par_cTipoGeracaoOP)
                        LOOP
                    ENDIF

                    loc_cQuery = "SELECT Emps, Dopes, Numes, Datas, PrazoEnts, GrupoOs, ContaOs, " + ;
                        "GrupoDs, ContaDs, GrVends, Vends, Obses, rNops, Notas, Jobs " + ;
                        "FROM SigMvCab WHERE " + loc_cCondeDatas + loc_cCondpDatas + ;
                        "Emps = " + EscaparSQL(par_cEmpresa) + " AND Dopes = " + EscaparSQL(ALLTRIM(TmpOper.Dopes)) + " AND "

                    IF !EMPTY(par_cContaGrupo)
                        IF TmpOper.Globalizas = 1
                            loc_cQuery = loc_cQuery + "GrupoOs = " + EscaparSQL(par_cContaGrupo) + " AND "
                        ELSE
                            IF TmpOper.Globalizas = 2
                                loc_cQuery = loc_cQuery + "GrupoDs = " + EscaparSQL(par_cContaGrupo) + " AND "
                            ENDIF
                        ENDIF
                    ENDIF
                    IF !EMPTY(par_cContaConta)
                        IF TmpOper.Globalizas = 1
                            loc_cQuery = loc_cQuery + "ContaOs = " + EscaparSQL(par_cContaConta) + " AND "
                        ELSE
                            IF TmpOper.Globalizas = 2
                                loc_cQuery = loc_cQuery + "ContaDs = " + EscaparSQL(par_cContaConta) + " AND "
                            ENDIF
                        ENDIF
                    ENDIF
                    IF !EMPTY(par_cRespGrupo)
                        loc_cQuery = loc_cQuery + "GrVends = " + EscaparSQL(par_cRespGrupo) + " AND "
                    ENDIF
                    IF !EMPTY(par_cRespConta)
                        loc_cQuery = loc_cQuery + "Vends = " + EscaparSQL(par_cRespConta) + " AND "
                    ENDIF
                    loc_cQuery = loc_cQuery + "Nops = 0"

                    IF USED("cursor_4c_TempEest")
                        USE IN cursor_4c_TempEest
                    ENDIF
                    loc_nResultado = SQLEXEC(gnConnHandle, loc_cQuery, "cursor_4c_TempEest")
                    IF loc_nResultado < 1
                        THIS.this_cMensagemErro = "Favor Reinicializar o Processo!!! (TempEest)" + CHR(13) + CapturarErroSQL()
                        loc_lAbortar = .T.
                        EXIT
                    ENDIF

                    SELECT cursor_4c_TempEest
                    loc_oProg = CREATEOBJECT("fwprogressbar", ;
                        "Processando Opera" + CHR(231) + CHR(227) + "o " + ALLTRIM(TmpOper.Dopes) + "...", RECCOUNT())
                    loc_oProg.Show()
                    SCAN
                        loc_oProg.Update(.T.)

                        IF !EMPTY(par_cOperacao) AND par_nOperacaoIni != 0 AND par_nOperacaoFim != 0 ;
                                AND !BETWEEN(cursor_4c_TempEest.Numes, par_nOperacaoIni, par_nOperacaoFim)
                            LOOP
                        ENDIF

                        IF TmpOper.Globalizas = 1
                            loc_cGrupoG = cursor_4c_TempEest.GrupoOs
                            loc_cContaG = cursor_4c_TempEest.ContaOs
                        ELSE
                            loc_cGrupoG = cursor_4c_TempEest.GrupoDs
                            loc_cContaG = cursor_4c_TempEest.ContaDs
                        ENDIF

                        IF THIS.this_lReserva AND cursor_4c_TempEest.rNops > 0
                            LOOP
                        ENDIF

                        loc_nTPeso    = 0
                        loc_lProcessa = .F.
                        loc_cEdn = cursor_4c_TempEest.Emps + cursor_4c_TempEest.Dopes + STR(cursor_4c_TempEest.Numes, 6)

                        IF USED("cursor_4c_TempEestI")
                            USE IN cursor_4c_TempEestI
                        ENDIF
                        SQLEXEC(gnConnHandle, ;
                            "SELECT CPros, CItens, Qtds, QtBaixas, QtProds, Pesos, Emps, Dopes, Numes, " + ;
                            "Obs, Notas, Dpros, Opers, Citem2 FROM SigMvItn WHERE EmpDopNums = " + EscaparSQL(loc_cEdn), ;
                            "cursor_4c_TempEestI")

                        IF USED("cursor_4c_TempEestI")
                            SELECT cursor_4c_TempEestI
                            SCAN
                                IF TmpOper.Opers = 3 AND !EMPTY(ALLTRIM(TmpOper.OpeGops)) AND cursor_4c_TempEestI.Opers != TmpOper.OpeGops
                                    LOOP
                                ENDIF
                                IF TmpOper.carcompos = 5 AND cursor_4c_TempEestI.Citem2 != 0
                                    LOOP
                                ENDIF

                                IF USED("crSigCdPro")
                                    USE IN crSigCdPro
                                ENDIF
                                SQLEXEC(gnConnHandle, ;
                                    "SELECT Pesoms, Linhas, QtdCpnts, DPros, Reffs, Cgrus FROM SigCdPro WHERE CPros = " + ;
                                    EscaparSQL(ALLTRIM(cursor_4c_TempEestI.CPros)), "crSigCdPro")
                                IF !USED("crSigCdPro") OR EOF("crSigCdPro")
                                    LOOP
                                ENDIF

                                IF USED("crSigCdGrp")
                                    USE IN crSigCdGrp
                                ENDIF
                                SQLEXEC(gnConnHandle, ;
                                    "SELECT GeraTubs FROM SigCdGrp WHERE CGrus = " + EscaparSQL(ALLTRIM(crSigCdPro.Cgrus)), "crSigCdGrp")

                                IF USED("cursor_4c_TempEsti2")
                                    USE IN cursor_4c_TempEsti2
                                ENDIF
                                loc_nResultado = SQLEXEC(gnConnHandle, ;
                                    "SELECT Emps, Dopes, Numes, CPros, CItens, Qtds, QtBaixas, QtProds, Pesos, CodCors, CodTams " + ;
                                    "FROM SigMvIts WHERE EmpDopNums = " + EscaparSQL(loc_cEdn) + ;
                                    " AND CItens = " + FormatarNumeroSQL(cursor_4c_TempEestI.CItens, 0), ;
                                    "cursor_4c_TempEsti2")
                                IF loc_nResultado < 0
                                    THIS.this_cMensagemErro = "Favor Reinicializar o Processo!!! (TempEsti2)" + CHR(13) + CapturarErroSQL()
                                    loc_lAbortar = .T.
                                    EXIT
                                ENDIF

                                IF !USED("cursor_4c_TempEsti2") OR EOF("cursor_4c_TempEsti2")
                                    loc_nBaixa = IIF(cursor_4c_TempEestI.QtBaixas > 0 AND cursor_4c_TempEestI.QtBaixas >= cursor_4c_TempEestI.QtProds, ;
                                        cursor_4c_TempEestI.QtBaixas - cursor_4c_TempEestI.QtProds, 0) + cursor_4c_TempEestI.QtProds
                                    loc_nSaldo = cursor_4c_TempEestI.Qtds - loc_nBaixa
                                    loc_nPeso  = IIF(EMPTY(cursor_4c_TempEestI.Pesos), crSigCdPro.Pesoms, cursor_4c_TempEestI.Pesos)
                                    IF loc_nSaldo != 0
                                        INSERT INTO TmpItens (Emps, Dopes, Numes, CPros, Qtds, Saldo, Obs, Peso, Linhas, Citens, Notas, Dpros, Reffs) ;
                                            VALUES (cursor_4c_TempEestI.Emps, cursor_4c_TempEestI.Dopes, cursor_4c_TempEestI.Numes, ;
                                                cursor_4c_TempEestI.CPros, cursor_4c_TempEestI.Qtds, loc_nSaldo, cursor_4c_TempEestI.Obs, ;
                                                loc_nPeso, crSigCdPro.Linhas, cursor_4c_TempEestI.CItens, cursor_4c_TempEestI.Notas, ;
                                                cursor_4c_TempEestI.Dpros, crSigCdPro.Reffs)

                                        loc_nTPeso    = loc_nTPeso + (loc_nPeso * loc_nSaldo)
                                        loc_lProcessa = .T.

                                        IF crSigCdGrp.GeraTubs != 2
                                            loc_nQtdTb = crSigCdPro.QtdCpnts
                                        ELSE
                                            IF USED("crSigPrMtz")
                                                USE IN crSigPrMtz
                                            ENDIF
                                            SQLEXEC(gnConnHandle, ;
                                                "SELECT SUM(qtds) AS total FROM SigPrMtz WHERE Cpros = " + ;
                                                EscaparSQL(ALLTRIM(cursor_4c_TempEestI.CPros)), "crSigPrMtz")
                                            loc_nQtdTb = TratarNulo(crSigPrMtz.total, 0)
                                        ENDIF
                                        IF loc_nQtdTb = 0
                                            IF !USED("Produtos")
                                                CREATE CURSOR Produtos (Cpros C(14), Dpros C(40))
                                                INDEX ON Cpros TAG Cpros
                                            ENDIF
                                            IF !SEEK(ALLTRIM(cursor_4c_TempEestI.CPros), "Produtos", "Cpros")
                                                INSERT INTO Produtos (Cpros, DPros) VALUES (cursor_4c_TempEestI.CPros, crSigCdPro.DPros)
                                            ENDIF
                                        ENDIF
                                    ENDIF
                                ELSE
                                    SELECT cursor_4c_TempEsti2
                                    SCAN
                                        loc_nBaixa = IIF(cursor_4c_TempEsti2.QtBaixas > 0 AND cursor_4c_TempEsti2.QtBaixas >= cursor_4c_TempEsti2.QtProds, ;
                                            cursor_4c_TempEsti2.QtBaixas - cursor_4c_TempEsti2.QtProds, 0) + cursor_4c_TempEsti2.QtProds
                                        loc_nSaldo = cursor_4c_TempEsti2.Qtds - loc_nBaixa
                                        loc_nPeso  = IIF(EMPTY(cursor_4c_TempEsti2.Pesos), crSigCdPro.Pesoms, cursor_4c_TempEsti2.Pesos)
                                        IF loc_nSaldo != 0
                                            INSERT INTO TmpItens (Emps, Dopes, Numes, CPros, Qtds, Saldo, Obs, Peso, Linhas, ;
                                                    CodCors, CodTams, Citens, Notas, Dpros, Reffs) ;
                                                VALUES (cursor_4c_TempEsti2.Emps, cursor_4c_TempEsti2.Dopes, cursor_4c_TempEsti2.Numes, ;
                                                    cursor_4c_TempEsti2.CPros, cursor_4c_TempEsti2.Qtds, loc_nSaldo, cursor_4c_TempEestI.Obs, ;
                                                    loc_nPeso, crSigCdPro.Linhas, cursor_4c_TempEsti2.CodCors, cursor_4c_TempEsti2.CodTams, ;
                                                    cursor_4c_TempEsti2.CItens, cursor_4c_TempEestI.Notas, cursor_4c_TempEestI.Dpros, crSigCdPro.Reffs)

                                            loc_nTPeso    = loc_nTPeso + (loc_nPeso * loc_nSaldo)
                                            loc_lProcessa = .T.

                                            IF crSigCdGrp.GeraTubs != 2
                                                loc_nQtdTb = crSigCdPro.QtdCpnts
                                            ELSE
                                                IF USED("crSigPrMtz")
                                                    USE IN crSigPrMtz
                                                ENDIF
                                                SQLEXEC(gnConnHandle, ;
                                                    "SELECT SUM(qtds) AS total FROM SigPrMtz WHERE Cpros = " + ;
                                                    EscaparSQL(ALLTRIM(cursor_4c_TempEestI.CPros)), "crSigPrMtz")
                                                loc_nQtdTb = TratarNulo(crSigPrMtz.total, 0)
                                            ENDIF
                                            IF loc_nQtdTb = 0
                                                IF !USED("Produtos")
                                                    CREATE CURSOR Produtos (Cpros C(14), Dpros C(40))
                                                    INDEX ON Cpros TAG Cpros
                                                ENDIF
                                                IF !SEEK(ALLTRIM(cursor_4c_TempEestI.CPros), "Produtos", "Cpros")
                                                    INSERT INTO Produtos (Cpros, DPros) VALUES (cursor_4c_TempEestI.CPros, crSigCdPro.DPros)
                                                ENDIF
                                            ENDIF
                                        ENDIF
                                        SELECT cursor_4c_TempEestI
                                    ENDSCAN
                                ENDIF
                                SELECT cursor_4c_TempEestI
                            ENDSCAN
                        ENDIF

                        *-- Propaga o aborto do SCAN interno (regra #1 - sem RETURN
                        *-- dentro de TRY, o early-exit sai em cascata por EXIT)
                        IF loc_lAbortar
                            EXIT
                        ENDIF

                        IF loc_lProcessa
                            loc_cGrupoD = IIF(EMPTY(crSigCdOpd.GruDests), cursor_4c_TempEest.GrupoDs, crSigCdOpd.GruDests)
                            loc_cContaD = IIF(EMPTY(crSigCdOpd.ConDests), cursor_4c_TempEest.ContaDs, crSigCdOpd.ConDests)

                            IF USED("crLocalCli")
                                USE IN crLocalCli
                            ENDIF
                            SQLEXEC(gnConnHandle, "SELECT RClis FROM SigCdCli WHERE IClis = " + EscaparSQL(ALLTRIM(loc_cContaG)), "crLocalCli")
                            IF !USED("crLocalCli")
                                THIS.this_cMensagemErro = "Favor Reinicializar o Processo!!! (LocalCli)" + CHR(13) + CapturarErroSQL()
                                loc_lAbortar = .T.
                                EXIT
                            ENDIF

                            INSERT INTO TmpCabec (Flag, Emps, Dopes, Numes, Datas, Entregas, Peso, Contav, Conta, DConta, ;
                                    Obs, Notas, GrupoOs, ContaOs, GrupoDs, ContaDs, Jobs) ;
                                VALUES (.T., cursor_4c_TempEest.Emps, cursor_4c_TempEest.Dopes, cursor_4c_TempEest.Numes, ;
                                    cursor_4c_TempEest.Datas, cursor_4c_TempEest.PrazoEnts, loc_nTPeso, cursor_4c_TempEest.Vends, ;
                                    loc_cContaG, IIF(!EOF("crLocalCli"), ALLTRIM(crLocalCli.RClis), ""), ;
                                    cursor_4c_TempEest.Obses, cursor_4c_TempEest.Notas, cursor_4c_TempEest.GrupoOs, ;
                                    cursor_4c_TempEest.ContaOs, loc_cGrupoD, loc_cContaD, cursor_4c_TempEest.Jobs)

                            IF USED("crLocalCli")
                                USE IN crLocalCli
                            ENDIF
                        ENDIF

                        SELECT cursor_4c_TempEest
                    ENDSCAN
                    loc_oProg.Complete(.T.)
                    loc_oProg.Release()

                    IF loc_lAbortar
                        EXIT
                    ENDIF

                    SELECT TmpOper
                ENDSCAN

                IF !loc_lAbortar
                    GO TOP IN TmpCabec
                    GO TOP IN TmpItens
                    loc_lSucesso = .T.
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message + " [Ln:" + TRANSFORM(loc_oErro.LineNo) + "]"
            MsgErro(THIS.this_cMensagemErro, "Erro ao Processar")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

ENDDEFINE

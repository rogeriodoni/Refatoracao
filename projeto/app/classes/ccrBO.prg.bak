*=============================================================================
* ccrBO.prg - Business Object para Grupos de Contas Corrente
* Herda de BusinessBase
* Tabela: SigCdGcr | Chave: Codigos
* Join: SigCdCss (Classes -> classes, Descrs as DClasses)
*=============================================================================

DEFINE CLASS ccrBO AS BusinessBase

    *--------------------------------------------------------------------------
    * Propriedades - Identificacao principal
    *--------------------------------------------------------------------------
    this_cCodigos     = ""           && Codigos    - PK (C)
    this_cDescrs      = ""           && Descrs     - Descricao (C)
    this_cInterno     = ""           && Interno    - Codigo interno (C)
    this_cDigito      = ""           && Digito     - Digito verificador (C, visivel se TpCods=1)
    this_cClasses     = ""           && Classes    - FK SigCdCss.classes (C)
    this_cDClasses    = ""           && DClasses   - Alias de SigCdCss.Descrs (nao salvo no BD)
    this_nTpCods      = 1            && TpCods     - Tipo: 1=Empresa, 2=C/C (N)
    this_nTpEmps      = 1            && TpEmps     - Tipo empresa: 1=Empresa, 2=C/C (N, visivel se TpCods=1)
    this_nTpCads      = 1            && TpCads     - Tipo cadastro (N)

    *--------------------------------------------------------------------------
    * Campo de configuracao codificada - 40 posicoes
    *--------------------------------------------------------------------------
    this_cCfgCdGcr    = ""           && CfgCdGcr  - Configuracoes codificadas (C,40)

    *--------------------------------------------------------------------------
    * Configuracoes decodificadas de CfgCdGcr - Aba Geral
    * (1=Sim, 2=Nao para OptionGroups com 2 botoes)
    *--------------------------------------------------------------------------
    this_nOptComple   = 2            && Opt_Comple   - Complemento
    this_nOptPessoais = 2            && Opt_Pessoais - Dados Pessoais
    this_nOptRefBancs = 2            && Opt_RefBancs - Ref. Bancarias
    this_nOptFollowUp = 2            && Opt_FollowUp - Follow-Up
    this_nOptFiscais  = 2            && Opt_Fiscais  - Dados Fiscais
    this_nOptContabs  = 2            && Opt_Contabs  - Dados Contabeis
    this_nOptEmpresa  = 2            && Opt_Empresa  - Dados da Empresa
    this_nOptCaract   = 2            && Opt_Caracteris - Caracteristicas
    this_nOptPerfil   = 2            && fwoption2    - Perfil
    this_nOptCargos   = 2            && Opt_Cargo    - Cargos
    this_nOptRespos   = 2            && Opt_Respos   - Possui Responsavel
    this_nOptLimCre   = 1            && Opt_LimCre   - Limite Credito (1=Sim, 2=Nao, 3=Sim-Saldo)
    this_nOptComi     = 2            && Opt_Comi     - Comissao
    this_nOptDadosCom = 2            && Opt_DadosCom - Dados Comerciais
    this_nOptChkLimCr = 2            && opt_ChkLimCr - Checa Limite Credito
    this_nOptColetor  = 2            && Opt_Coletor  - Grupo Padrao (11 opcoes)
    this_nOptPreCad   = 2            && optPreCad    - Pre Cadastro

    *--------------------------------------------------------------------------
    * Campos Geral - diretos
    *--------------------------------------------------------------------------
    this_cGrupoGeral  = ""           && Get_grupo (Geral) - Grupo contabilidade (C)
    this_nVrlimc      = 0            && Get_vrlimc  - Valor Limite Credito (N)
    this_cCdMoeda     = ""           && get_cd_moeda - Codigo Moeda Comissao (C)
    this_cDsMoeda     = ""           && get_ds_moeda - Descricao Moeda (nao salvo, derivado de lookup)
    this_nMolimc      = 0            && get_molimc  - Moeda Limite Credito (N)
    this_cRodRelCC    = ""           && getRodRelCC - Rodape Relatorio Conta Corrente (M)

    *--------------------------------------------------------------------------
    * Configuracoes decodificadas de CfgCdGcr - Aba Cadastro/Financeiro
    *--------------------------------------------------------------------------
    this_nObrMails    = 2            && getObrMails  - E-mail Obrigatorio
    this_nObrNome     = 2            && getObrNome   - Nome Obrigatorio
    this_nVincPgRcs   = 2            && optVincPgRcs - Vincula Conta PG/RC
    this_nObrSit      = 2            && getObrSit    - Situacao Obrigatoria
    this_nObrTlm      = 2            && getObrTlm    - Telemarketing Obrigatorio
    this_nObrCla      = 2            && getObrCla    - Classificacao Obrigatoria
    this_nObrSeg      = 2            && getObrSeg    - Segmento Obrigatorio
    this_nObrIbge     = 2            && getObrIbge   - Cod IBGE Obrigatorio
    this_nFpublSobr   = 2            && Optfpublsobr - F.Publicidade Obrigatoria
    this_nNascObrig   = 2            && Fwoption8    - Data Nascimento Obrigatoria
    this_nCpfObrig    = 1            && Opt_CPFObrig - CPF/CNPJ Obrigatorio (1=Nao, 2=Sim, 3=SIM-Dupla, 4=Nao-Dupla)
    this_nCepObrig    = 1            && Opt_CEPObrig - CEP Obrigatorio (1=Nao, 2=Sim, 3=Sim-buscar)
    this_nRgObrig     = 2            && fwoption2    - RG/IE Obrigatorio
    this_nMFotos      = 2            && Opt_MFotos   - Mostrar Foto
    this_nObservacao  = 1            && fwoption1(Cad) - Observacao (1=Nao Mostrar, 2=Sempre, 3=Mostrar Botao)
    this_nCpfFixo     = 1            && optCpffixo   - CPF/CNPJ Fixo (1=CPF, 2=CNPJ, 3=Ambos)
    this_nCaracCad    = 2            && optCarac     - Caracteristica (Cadastro)
    this_nAceJob      = 2            && optAceJob    - Acesso Job
    this_nCCustoTit   = 2            && Opt_CCusto   - Habilita Centro de Custos nos Titulos
    this_nLogAlt      = 2            && Fwoption6    - Log de Alteracoes
    this_nInfSenha    = 2            && Fwoption7    - Informar Senha na Alteracao
    this_nCntVinc     = 2            && Fwoption4    - Conta Vinculada ao Grupo
    this_nDupEnd      = 2            && Fwoption5    - Verifica Duplicidade de Endereco
    this_nRestEnd     = 2            && Fwoption9(Cad) - Verifica Restricao de Endereco
    this_nIntegCont   = 1            && Opt_Integ    - Integracao Contabil (1=Nao, 2=Sim, 3=SemContraPartida)
    this_nPadPreench  = 1            && Fwoption3    - Padrao de Preenchimento (1=Nenhum, 2=Pagamentos, 3=Recebimentos, 4=Ambos)
    this_nVincContas  = 2            && optVincPgRcs - Vincula as Contas no Pag/Rec
    this_nTitBaixado  = 2            && OptTitBaixado - Visualizar Titulos nao Baixados
    this_nCalcIMeds   = 2            && optCalcIMeds - Calc. I.Medias
    this_nSitPdrIdx   = 1            && getSituas    - Situacao Padrao (indice)

    *--------------------------------------------------------------------------
    * Campos Cadastro - diretos
    *--------------------------------------------------------------------------
    this_cContint     = ""           && Getcontint - Conta Corrente Interna (C)
    this_cSituas      = ""           && getSituas  - Codigo Situacao Padrao (C)

    *--------------------------------------------------------------------------
    * Campos Estoque / Industria - opcoes
    *--------------------------------------------------------------------------
    this_nOptLimEsto  = 2            && Opt_LimEsto  - Limite de Estoque
    this_nOptVerEst   = 2            && Opt_VerEst   - Avalia Estoque
    this_nOptEstPAcab = 2            && Opt_EstPAcab - Estoque Produto Acabado
    this_nOptChkLimEst= 2            && opt_ChkLimest - Checa Limite de Estoque
    this_nOptCCustoEst= 2            && Opt_CCusto(Est) - Centro de Custos
    this_nOptSaldo    = 1            && Opt_Saldo    - Calculo de Saldo (1=Online, 2=Background)
    this_nOptRelevante= 2            && Opt_Relevante - Empresa Relevante
    this_nOptBlqConGV = 2            && Opt_BlqConGV - Bloqueia Consulta Vendas
    this_nOptPatrim   = 2            && Opt_Patrim   - Patrimonial por Etiqueta
    this_nOpTipoInvs  = 1            && OpTipoInvs   - Inventario (1=Proprio, 2=ProprioPoder3p, 3=NosMeio3p)
    this_nOptGBals    = 2            && Opt_GBals    - Balanco Fabrica (1=Sim, 2=Nao)
    this_nOptUnifBal  = 1            && Opt_UnifBal  - Balanco Unificado
    this_nOptFalPers  = 2            && Opt_FalPers  - Balanco Falhas/Perdas
    this_nOptBlqDivOp = 2            && Opt_BlqDivOp - Bloqueia Divisao de OF
    this_nGetOsPend   = 2            && Get_OsPend   - OS Pendente Dt.Entrega
    this_nObjDupTit   = 2            && ObjDupTit    - Checa Duplicidade de Titulo
    this_nOpCompagru  = 1            && op_compagru  - Agrupa Componentes (1=Sim, 2=Nao, 3=MaterialPrincipal)
    this_nFwoption1Est= 1            && Fwoption1(Est) - Controle de Lote (1=Sim, 2=Nao, 3=Multiplos)

    *--------------------------------------------------------------------------
    * Campos Estoque / Industria - diretos
    *--------------------------------------------------------------------------
    this_nDdR         = 0            && get_ddr      - Dias Bloqueio Retroativo (N)
    this_nDdF         = 0            && get_ddf      - Dias Bloqueio Futuro (N)
    this_cGrupoEst    = ""           && Get_grupo(Est) - Grupo Dif. Balanco (C)
    this_nDifPeso     = 0            && Get_DifPeso  - Diferenca de Peso (N)
    this_cSinal       = ""           && Get_Sinal    - Sinal combo (+/-/P/Q) (C)
    this_cTfalhas     = ""           && Get_tfalhas  - Tipo Falhas (P ou Q) (C)
    this_nChkTrfPeso  = 1            && Chk_TrfPeso  - Transfere Peso (5 opcoes)
    this_cGetAgrupa   = ""           && Get_Agrupa   - Agrupamento (C)
    this_cGrupoFalha  = ""           && GetGrupoFalha - Grupo de Falha (C)
    this_cContaFalha  = ""           && GetContaFalha - Conta de Falha (C)
    this_cDsContaFalha= ""           && getDsContas(Est) - Descricao Conta Falha (nao salvo)
    this_cContaPdr    = ""           && getContaPdr  - Conta Padrao (C)
    this_cDsContaPdr  = ""           && getDsContaPdr - Descricao Conta Padrao (nao salvo)

    *-- Resumo de Composicao (Container1 com 3 checkboxes)
    this_lCheck1      = .F.          && Check1 - Os
    this_lCheck2      = .F.          && Check2 - Alianca
    this_lCheck3      = .F.          && Check3 - Fundicao

    *--------------------------------------------------------------------------
    * Campos fiscais codificados - CfgFisXXs
    * Cada campo fiscal armazena: Grupo + Conta + Aliquota + Receita (encoded)
    *--------------------------------------------------------------------------

    *-- ICMS (CfgFisICs)
    this_cGrupoICMS   = ""           && getCdGrupos - Grupo ICMS
    this_cContaICMS   = ""           && getCdContas - Conta ICMS
    this_cDsContaICMS = ""           && getDsContas - Descricao Conta ICMS (nao salvo)
    this_nPctICMS     = 0            && getPctAliqs - Aliquota ICMS (N)
    this_cRecICMS     = ""           && getReceitas - Receita ICMS (C)

    *-- IPI (CfgFisIPs)
    this_cGrupoIPI    = ""
    this_cContaIPI    = ""
    this_cDsContaIPI  = ""
    this_nPctIPI      = 0
    this_cRecIPI      = ""

    *-- II (CfgFisIIs)
    this_cGrupoII     = ""
    this_cContaII     = ""
    this_cDsContaII   = ""
    this_nPctII       = 0
    this_cRecII       = ""

    *-- ISS (CfgFisISs)
    this_cGrupoISS    = ""
    this_cContaISS    = ""
    this_cDsContaISS  = ""
    this_nPctISS      = 0
    this_cRecISS      = ""

    *-- IRRF (CfgFisIRs)
    this_cGrupoIRRF   = ""
    this_cContaIRRF   = ""
    this_cDsContaIRRF = ""
    this_nPctIRRF     = 0
    this_cRecIRRF     = ""

    *-- INSS (CfgFisINs)
    this_cGrupoINSS   = ""
    this_cContaINSS   = ""
    this_cDsContaINSS = ""
    this_nPctINSS     = 0
    this_cRecINSS     = ""

    *-- PIS (CfgFisPIs)
    this_cGrupoPIS    = ""
    this_cContaPIS    = ""
    this_cDsContaPIS  = ""
    this_nPctPIS      = 0
    this_cRecPIS      = ""

    *-- CSSL (CfgFisCSs)
    this_cGrupoCSL    = ""
    this_cContaCSL    = ""
    this_cDsContaCSL  = ""
    this_nPctCSL      = 0
    this_cRecCSL      = ""

    *-- COFINS (CfgFisCOs)
    this_cGrupoCOF    = ""
    this_cContaCOF    = ""
    this_cDsContaCOF  = ""
    this_nPctCOF      = 0
    this_cRecCOF      = ""

    *==========================================================================
    PROCEDURE Init()
    *==========================================================================
        DODEFAULT()
        THIS.this_cTabela     = "SigCdGcr"
        THIS.this_cCampoChave = "Codigos"
        RETURN .T.
    ENDPROC

    *==========================================================================
    PROCEDURE ObterChavePrimaria()
    *==========================================================================
    *-- Retorna o valor da chave primaria para o sistema de auditoria
        RETURN THIS.this_cCodigos
    ENDPROC

    *==========================================================================
    PROCEDURE Buscar(par_cFiltro)
    *==========================================================================
    *-- Busca registros para a grade da lista (Codigos, Descrs, Internos, TpCods, DClasses)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
                IF !USED("cursor_4c_Dados")
                    SET NULL ON
                    CREATE CURSOR cursor_4c_Dados (Codigos C(10), Descrs C(40), Internos C(20), TpCods N(1,0), DClasses C(40))
                    SET NULL OFF
                ENDIF
                loc_lSucesso = .T.
            ELSE
                loc_cSQL = "SELECT a.Codigos, a.Descrs, a.Internos, a.TpCods, b.Descrs AS DClasses" + ;
                           " FROM SigCdGcr a" + ;
                           " LEFT JOIN SigCdCss b ON a.Classes = b.Classes"
                IF !EMPTY(par_cFiltro)
                    loc_cSQL = loc_cSQL + " WHERE " + par_cFiltro
                ENDIF
                loc_cSQL = loc_cSQL + " ORDER BY a.Codigos"

                IF USED("cursor_4c_Dados")
                    loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_DadosTmp")
                    IF loc_nResultado >= 0
                        SELECT cursor_4c_Dados
                        ZAP
                        APPEND FROM DBF("cursor_4c_DadosTmp")
                        USE IN cursor_4c_DadosTmp
                        loc_lSucesso = .T.
                    ELSE
                        MostrarErro("Erro ao buscar grupos CCR:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                    ENDIF
                ELSE
                    loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")
                    IF loc_nResultado >= 0
                        loc_lSucesso = .T.
                    ELSE
                        MostrarErro("Erro ao buscar grupos CCR:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loException
            MostrarErro("Erro ao buscar:" + CHR(13) + loException.Message, "ccrBO.Buscar")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    PROCEDURE CarregarPorCodigo(par_cCodigo)
    *==========================================================================
    *-- Carrega todos os campos de SigCdGcr + DClasses do JOIN para o BO
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "SELECT a.*, b.Descrs AS DClasses" + ;
                       " FROM SigCdGcr a" + ;
                       " LEFT JOIN SigCdCss b ON a.Classes = b.Classes" + ;
                       " WHERE a.codigos = " + EscaparSQL(par_cCodigo)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")

            IF loc_nResultado >= 0
                IF RECCOUNT("cursor_4c_Carrega") > 0
                    loc_lSucesso = THIS.CarregarDoCursor("cursor_4c_Carrega")
                    THIS.this_lNovoRegistro = .F.
                ELSE
                    MsgAviso("Grupo de Conta Corrente n" + CHR(227) + "o encontrado!")
                ENDIF
                IF USED("cursor_4c_Carrega")
                    USE IN cursor_4c_Carrega
                ENDIF
            ELSE
                MostrarErro("Erro ao carregar grupo CCR:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loException
            MostrarErro("Erro ao carregar:" + CHR(13) + loException.Message, "ccrBO.CarregarPorCodigo")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    PROTECTED PROCEDURE CarregarDoCursor(par_cAliasCursor)
    *==========================================================================
    *-- Mapeia todos os campos do cursor para propriedades do BO
        LOCAL loc_lSucesso, loc_cOsalfuns, loc_nSinal
        loc_lSucesso = .F.

        TRY
            IF USED(par_cAliasCursor)
                SELECT (par_cAliasCursor)

                *-- Identificacao
                THIS.this_cCodigos  = TratarNulo(Codigos,  "C")
                THIS.this_cDescrs   = TratarNulo(Descrs,   "C")
                THIS.this_cInterno  = TratarNulo(Internos, "C")
                THIS.this_cDigito   = TratarNulo(DgCods,   "C")
                THIS.this_cClasses  = TratarNulo(Classes,  "C")
                THIS.this_cDClasses = TratarNulo(DClasses, "C")
                THIS.this_nTpCods   = TratarNulo(TpCods,   "N")
                THIS.this_nTpEmps   = TratarNulo(TpEmps,   "N")
                THIS.this_nTpCads   = TratarNulo(TpCads,   "N")
                THIS.this_cCfgCdGcr = TratarNulo(CfgCdGcr, "C")

                *-- Opcoes Aba Geral (colunas individuais em SigCdGcr)
                THIS.this_nOptGBals    = TratarNulo(GerBals,   "N")
                THIS.this_nOptCargos   = TratarNulo(Cargos,    "N")
                THIS.this_nOptColetor  = TratarNulo(Coletors,  "N")
                THIS.this_nOptComi     = TratarNulo(Comis,     "N")
                THIS.this_nOptDadosCom = TratarNulo(DadComs,   "N")
                THIS.this_nOptFiscais  = TratarNulo(Fiscais,   "N")
                THIS.this_nOptFollowUp = TratarNulo(FollowUps, "N")
                THIS.this_nOptLimCre   = TratarNulo(LimCres,   "N")
                THIS.this_nOptPessoais = TratarNulo(Pessoais,  "N")
                THIS.this_nOptRefBancs = TratarNulo(RefBancs,  "N")
                THIS.this_nOptRespos   = TratarNulo(Respos,    "N")
                THIS.this_nOptComple   = TratarNulo(Complems,  "N")
                THIS.this_nOptContabs  = TratarNulo(Contabs,   "N")
                THIS.this_nOptEmpresa  = TratarNulo(Empresas,  "N")
                THIS.this_nOptCaract   = TratarNulo(Caracteris,"N")
                THIS.this_nOptChkLimCr = TratarNulo(ChkLimCrds,"N")
                THIS.this_nOptPreCad   = TratarNulo(PreCad,    "N")

                *-- Campos diretos Aba Geral
                THIS.this_cGrupoGeral  = TratarNulo(GruFals,   "C")  && grufals -> Get_grupo Geral
                THIS.this_cContint     = TratarNulo(ContConts, "C")  && Conta Corrente Interna
                THIS.this_nVrlimc      = TratarNulo(VrLimCre,  "N")
                THIS.this_cCdMoeda     = TratarNulo(ComMordas, "C")  && Moeda Comissao
                THIS.this_cRodRelCC    = IIF(ISNULL(RodRelCC), '', RodRelCC)

                *-- Decodificar CfgCdGcr para campos Cadastro sem coluna propria
                THIS.DecodificarCfgCdGcr()

                *-- Sobrepor com colunas individuais Cadastro/Financeiro (mais confiaveis)
                THIS.this_nFpublSobr   = TratarNulo(FpublSobr, "N")
                THIS.this_nNascObrig   = TratarNulo(DtNascObr, "N")
                THIS.this_nCpfObrig    = TratarNulo(CpfObrigs, "N")
                THIS.this_nCepObrig    = TratarNulo(CepObris,  "N")
                THIS.this_nRgObrig     = TratarNulo(RgObrigs,  "N")
                THIS.this_nMFotos      = TratarNulo(MFotos,    "N")
                THIS.this_nObservacao  = TratarNulo(Observas,  "N")
                THIS.this_nCaracCad    = TratarNulo(InfCads,   "N")
                THIS.this_nCCustoTit   = TratarNulo(CcustoTit, "N")
                THIS.this_nLogAlt      = TratarNulo(LogAlt,    "N")
                THIS.this_nInfSenha    = TratarNulo(InfSenha,  "N")
                THIS.this_nCntVinc     = TratarNulo(CtVinculas,"N")
                THIS.this_nDupEnd      = TratarNulo(ChkEndDs,  "N")
                THIS.this_nRestEnd     = TratarNulo(ChkEndRs,  "N")
                THIS.this_nIntegCont   = TratarNulo(IntConts,  "N")
                THIS.this_nPadPreench  = TratarNulo(PadPgRecs, "N")
                THIS.this_nTitBaixado  = TratarNulo(TitBaixado,"N")
                THIS.this_nCalcIMeds   = TratarNulo(CalcIMeds, "N")
                THIS.this_cSituas      = ""  && Carregado via lookup na UI

                *-- Opcoes Estoque/Industria
                THIS.this_nOptLimEsto  = TratarNulo(LimEstoqs, "N")
                THIS.this_nOptVerEst   = TratarNulo(VerEsts,   "N")
                THIS.this_nOptEstPAcab = TratarNulo(Estoques,  "N")
                THIS.this_nOptChkLimEst= TratarNulo(ChkLimEsts,"N")
                THIS.this_nOptCCustoEst= TratarNulo(CCustos,   "N")
                THIS.this_nOptSaldo    = TratarNulo(CalcSalds, "N")
                THIS.this_nOptRelevante= TratarNulo(EmpreLevs, "N")
                THIS.this_nOptBlqConGV = TratarNulo(BlqConGVs, "N")
                THIS.this_nOptPatrim   = TratarNulo(PatriEtqs, "N")
                THIS.this_nOpTipoInvs  = TratarNulo(TipoInvs,  "N")
                THIS.this_nOptUnifBal  = TratarNulo(UnifBals,  "N")
                THIS.this_nOptFalPers  = TratarNulo(BalFalPers,"N")
                THIS.this_nOptBlqDivOp = TratarNulo(BlqDivOps, "N")
                THIS.this_nGetOsPend   = TratarNulo(OsPends,   "N")
                THIS.this_nObjDupTit   = TratarNulo(ChkTits,   "N")
                THIS.this_nOpCompagru  = TratarNulo(CompaGrus, "N")
                THIS.this_nFwoption1Est= TratarNulo(CtrlLotes, "N")

                *-- Campos diretos Estoque
                THIS.this_nDdR         = TratarNulo(DdRetros,  "N")
                THIS.this_nDdF         = TratarNulo(DdFutus,   "N")
                THIS.this_cGrupoEst    = TratarNulo(GrupoLms,  "C")  && grupolms -> Grupo Dif. Balanco
                THIS.this_nDifPeso     = TratarNulo(DifPesAgs, "N")
                THIS.this_cTfalhas     = TratarNulo(Pqs,       "C")
                THIS.this_nChkTrfPeso  = TratarNulo(TrfPesas,  "N")
                THIS.this_cGetAgrupa   = TratarNulo(Agrupas,   "C")
                THIS.this_cGrupoFalha  = TratarNulo(GrupoFalha,"C")
                THIS.this_cContaFalha  = TratarNulo(ContaFalha,"C")
                THIS.this_cContaPdr    = TratarNulo(ContaPdr,  "C")

                *-- Sinal: numeric(1,0) -> char (+/-/P/Q)
                loc_nSinal = TratarNulo(Sinals, "N")
                THIS.this_cSinal = IIF(loc_nSinal=2, '-', IIF(loc_nSinal=3, 'P', IIF(loc_nSinal=4, 'Q', '+')))

                *-- Checkboxes Os/Alianca/Fundicao (osalfuns C(3): '1'=marcado, '0'=desmarcado)
                loc_cOsalfuns = PADR(TratarNulo(OsAlFuns, "C"), 3)
                THIS.this_lCheck1 = (SUBSTR(loc_cOsalfuns, 1, 1) = '1')
                THIS.this_lCheck2 = (SUBSTR(loc_cOsalfuns, 2, 1) = '1')
                THIS.this_lCheck3 = (SUBSTR(loc_cOsalfuns, 3, 1) = '1')

                *-- Campos Faturamento/Fiscal (decodificar CfgFis* - 50 chars cada)
                THIS.DecodificarFiscal("IC", TratarNulo(CfgFisICs, "C"))
                THIS.DecodificarFiscal("IP", TratarNulo(CfgFisIPs, "C"))
                THIS.DecodificarFiscal("II", TratarNulo(CfgFisIIs, "C"))
                THIS.DecodificarFiscal("IS", TratarNulo(CfgFisISs, "C"))
                THIS.DecodificarFiscal("IR", TratarNulo(CfgFisIRs, "C"))
                THIS.DecodificarFiscal("IN", TratarNulo(CfgFisINs, "C"))
                THIS.DecodificarFiscal("PI", TratarNulo(CfgFisPIs, "C"))
                THIS.DecodificarFiscal("CS", TratarNulo(CfgFisCSs, "C"))
                THIS.DecodificarFiscal("CO", TratarNulo(CfgFisCOs, "C"))

                loc_lSucesso = .T.
            ENDIF
        CATCH TO loException
            MostrarErro("Erro ao carregar do cursor:" + CHR(13) + loException.Message, "ccrBO.CarregarDoCursor")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    PROTECTED PROCEDURE ValidarDados()
    *==========================================================================
    *-- Valida campos obrigatorios antes de salvar
        LOCAL loc_lValido, loc_cSQL, loc_nResultado
        loc_lValido = .T.

        IF EMPTY(THIS.this_cCodigos)
            MsgAviso("C" + CHR(243) + "digo obrigat" + CHR(243) + "rio!")
            loc_lValido = .F.
        ENDIF

        IF loc_lValido AND EMPTY(THIS.this_cDescrs)
            MsgAviso("Descri" + CHR(231) + CHR(227) + "o obrigat" + CHR(243) + "ria!")
            loc_lValido = .F.
        ENDIF

        *-- Verificar duplicidade de codigo em novo registro
        IF loc_lValido AND THIS.this_lNovoRegistro
            TRY
                loc_cSQL = "SELECT COUNT(*) AS qtd FROM SigCdGcr WHERE codigos = " + EscaparSQL(THIS.this_cCodigos)
                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ChkDup")
                IF loc_nResultado >= 0
                    SELECT cursor_4c_ChkDup
                    IF qtd > 0
                        MsgAviso("C" + CHR(243) + "digo j" + CHR(225) + " cadastrado!")
                        loc_lValido = .F.
                    ENDIF
                    USE IN cursor_4c_ChkDup
                ENDIF
            CATCH TO loException
                MostrarErro("Erro ao verificar duplicidade:" + CHR(13) + loException.Message, "ccrBO.ValidarDados")
                loc_lValido = .F.
            ENDTRY
        ENDIF

        RETURN loc_lValido
    ENDPROC

    *==========================================================================
    PROTECTED PROCEDURE Inserir()
    *==========================================================================
    *-- INSERT INTO SigCdGcr com todos os campos obrigatorios
        LOCAL loc_lSucesso, loc_nResultado, loc_cSQL, loc_cVals
        LOCAL loc_nSinal_n, loc_cOsalfuns
        loc_lSucesso = .F.

        TRY
            *-- Codificar CfgCdGcr antes de salvar
            THIS.CodificarCfgCdGcr()

            *-- Calcular valores especiais
            loc_nSinal_n  = IIF(THIS.this_cSinal='+', 1, IIF(THIS.this_cSinal='-', 2, IIF(THIS.this_cSinal='P', 3, IIF(THIS.this_cSinal='Q', 4, 1))))
            loc_cOsalfuns = IIF(THIS.this_lCheck1,'1','0') + IIF(THIS.this_lCheck2,'1','0') + IIF(THIS.this_lCheck3,'1','0')

            *-- Montar lista de valores (mesma ordem das colunas)
            loc_cVals = EscaparSQL(THIS.this_cCodigos)
            loc_cVals = loc_cVals + ", " + EscaparSQL(THIS.this_cDescrs)
            loc_cVals = loc_cVals + ", " + EscaparSQL(THIS.this_cInterno)
            loc_cVals = loc_cVals + ", " + EscaparSQL(THIS.this_cDigito)
            loc_cVals = loc_cVals + ", " + EscaparSQL(THIS.this_cClasses)
            loc_cVals = loc_cVals + ", " + FormatarNumeroSQL(THIS.this_nTpCods, 0)
            loc_cVals = loc_cVals + ", " + FormatarNumeroSQL(THIS.this_nTpEmps, 0)
            loc_cVals = loc_cVals + ", " + FormatarNumeroSQL(THIS.this_nTpCads, 0)
            *-- Opcoes Geral
            loc_cVals = loc_cVals + ", " + FormatarNumeroSQL(THIS.this_nOptGBals, 0)
            loc_cVals = loc_cVals + ", " + FormatarNumeroSQL(THIS.this_nOptCargos, 0)
            loc_cVals = loc_cVals + ", " + FormatarNumeroSQL(THIS.this_nCepObrig, 0)
            loc_cVals = loc_cVals + ", " + FormatarNumeroSQL(THIS.this_nOptColetor, 0)
            loc_cVals = loc_cVals + ", " + FormatarNumeroSQL(THIS.this_nOptComi, 0)
            loc_cVals = loc_cVals + ", " + FormatarNumeroSQL(THIS.this_nCpfObrig, 0)
            loc_cVals = loc_cVals + ", " + FormatarNumeroSQL(THIS.this_nOptDadosCom, 0)
            loc_cVals = loc_cVals + ", " + FormatarNumeroSQL(THIS.this_nOptFiscais, 0)
            loc_cVals = loc_cVals + ", " + FormatarNumeroSQL(THIS.this_nOptFollowUp, 0)
            loc_cVals = loc_cVals + ", " + FormatarNumeroSQL(THIS.this_nOptLimCre, 0)
            loc_cVals = loc_cVals + ", " + FormatarNumeroSQL(THIS.this_nOptPessoais, 0)
            loc_cVals = loc_cVals + ", " + FormatarNumeroSQL(THIS.this_nOptRefBancs, 0)
            loc_cVals = loc_cVals + ", " + FormatarNumeroSQL(THIS.this_nOptRespos, 0)
            *-- Campos diretos e opcoes mistas
            loc_cVals = loc_cVals + ", " + FormatarNumeroSQL(THIS.this_nMFotos, 0)
            loc_cVals = loc_cVals + ", " + EscaparSQL(THIS.this_cGrupoGeral)
            loc_cVals = loc_cVals + ", " + EscaparSQL(THIS.this_cContint)
            loc_cVals = loc_cVals + ", " + FormatarNumeroSQL(THIS.this_nIntegCont, 0)
            loc_cVals = loc_cVals + ", " + FormatarNumeroSQL(THIS.this_nOptContabs, 0)
            loc_cVals = loc_cVals + ", " + FormatarNumeroSQL(THIS.this_nOptEmpresa, 0)
            loc_cVals = loc_cVals + ", " + FormatarNumeroSQL(THIS.this_nOptEstPAcab, 0)
            loc_cVals = loc_cVals + ", " + FormatarNumeroSQL(THIS.this_nOptSaldo, 0)
            loc_cVals = loc_cVals + ", " + FormatarNumeroSQL(THIS.this_nOptUnifBal, 0)
            loc_cVals = loc_cVals + ", " + FormatarNumeroSQL(THIS.this_nOptComple, 0)
            loc_cVals = loc_cVals + ", " + FormatarNumeroSQL(THIS.this_nOptRelevante, 0)
            loc_cVals = loc_cVals + ", " + FormatarNumeroSQL(THIS.this_nOptFalPers, 0)
            loc_cVals = loc_cVals + ", " + FormatarNumeroSQL(THIS.this_nOptLimEsto, 0)
            loc_cVals = loc_cVals + ", " + FormatarNumeroSQL(THIS.this_nOptBlqDivOp, 0)
            loc_cVals = loc_cVals + ", " + FormatarNumeroSQL(THIS.this_nOptCCustoEst, 0)
            loc_cVals = loc_cVals + ", " + FormatarNumeroSQL(THIS.this_nDdF, 0)
            loc_cVals = loc_cVals + ", " + FormatarNumeroSQL(THIS.this_nDdR, 0)
            loc_cVals = loc_cVals + ", " + FormatarNumeroSQL(THIS.this_nOptVerEst, 0)
            loc_cVals = loc_cVals + ", " + FormatarNumeroSQL(THIS.this_nOptBlqConGV, 0)
            loc_cVals = loc_cVals + ", " + FormatarNumeroSQL(THIS.this_nOpTipoInvs, 0)
            loc_cVals = loc_cVals + ", " + FormatarNumeroSQL(THIS.this_nOptCaract, 0)
            loc_cVals = loc_cVals + ", " + FormatarNumeroSQL(THIS.this_nObservacao, 0)
            loc_cVals = loc_cVals + ", " + FormatarNumeroSQL(THIS.this_nOptChkLimCr, 0)
            loc_cVals = loc_cVals + ", " + FormatarNumeroSQL(THIS.this_nOptChkLimEst, 0)
            loc_cVals = loc_cVals + ", " + FormatarNumeroSQL(THIS.this_nCaracCad, 0)
            loc_cVals = loc_cVals + ", " + EscaparSQL(loc_cOsalfuns)
            loc_cVals = loc_cVals + ", " + FormatarNumeroSQL(THIS.this_nOptPatrim, 0)
            loc_cVals = loc_cVals + ", " + FormatarNumeroSQL(THIS.this_nRgObrig, 0)
            loc_cVals = loc_cVals + ", " + FormatarNumeroSQL(THIS.this_nCalcIMeds, 0)
            *-- Colunas sem controle no formulario atual
            loc_cVals = loc_cVals + ", 0"  && ddsems
            loc_cVals = loc_cVals + ", 0"  && hordd
            loc_cVals = loc_cVals + ", 0"  && tpprecos
            loc_cVals = loc_cVals + ", " + EscaparSQL(THIS.this_cCdMoeda)
            loc_cVals = loc_cVals + ", " + FormatarNumeroSQL(THIS.this_nObjDupTit, 0)
            loc_cVals = loc_cVals + ", " + FormatarNumeroSQL(THIS.this_nGetOsPend, 0)
            loc_cVals = loc_cVals + ", " + FormatarNumeroSQL(THIS.this_nOpCompagru, 0)
            loc_cVals = loc_cVals + ", " + FormatarNumeroSQL(THIS.this_nChkTrfPeso, 0)
            loc_cVals = loc_cVals + ", " + FormatarNumeroSQL(THIS.this_nDifPeso, 3)
            loc_cVals = loc_cVals + ", 0"  && fichatecs
            loc_cVals = loc_cVals + ", " + EscaparSQL(THIS.this_cTfalhas)
            loc_cVals = loc_cVals + ", " + FormatarNumeroSQL(loc_nSinal_n, 0)
            loc_cVals = loc_cVals + ", " + EscaparSQL(THIS.this_cGrupoEst)
            loc_cVals = loc_cVals + ", " + EscaparSQL(THIS.this_cGetAgrupa)
            loc_cVals = loc_cVals + ", " + EscaparSQL(THIS.this_cRodRelCC)
            loc_cVals = loc_cVals + ", " + FormatarNumeroSQL(THIS.this_nPadPreench, 0)
            loc_cVals = loc_cVals + ", " + FormatarNumeroSQL(THIS.this_nDupEnd, 0)
            loc_cVals = loc_cVals + ", " + FormatarNumeroSQL(THIS.this_nRestEnd, 0)
            loc_cVals = loc_cVals + ", " + FormatarNumeroSQL(THIS.this_nFwoption1Est, 0)
            loc_cVals = loc_cVals + ", " + EscaparSQL(PADR(THIS.this_cCfgCdGcr, 40))
            *-- CfgFis* (Fiscal - 9 tipos)
            loc_cVals = loc_cVals + ", " + EscaparSQL(THIS.CodificarFiscal("CO"))
            loc_cVals = loc_cVals + ", " + EscaparSQL(THIS.CodificarFiscal("CS"))
            loc_cVals = loc_cVals + ", " + EscaparSQL(THIS.CodificarFiscal("IC"))
            loc_cVals = loc_cVals + ", " + EscaparSQL(THIS.CodificarFiscal("II"))
            loc_cVals = loc_cVals + ", " + EscaparSQL(THIS.CodificarFiscal("IN"))
            loc_cVals = loc_cVals + ", " + EscaparSQL(THIS.CodificarFiscal("IP"))
            loc_cVals = loc_cVals + ", " + EscaparSQL(THIS.CodificarFiscal("IR"))
            loc_cVals = loc_cVals + ", " + EscaparSQL(THIS.CodificarFiscal("IS"))
            loc_cVals = loc_cVals + ", " + EscaparSQL(THIS.CodificarFiscal("PI"))
            loc_cVals = loc_cVals + ", " + FormatarNumeroSQL(THIS.this_nTitBaixado, 0)
            loc_cVals = loc_cVals + ", '   '"  && molimcre C(3) - this_nMolimc e N; incompatibilidade de tipo da fase 1
            loc_cVals = loc_cVals + ", " + FormatarNumeroSQL(THIS.this_nVrlimc, 2)
            *-- Colunas com DEFAULT mas que devem ser salvas explicitamente
            loc_cVals = loc_cVals + ", " + FormatarNumeroSQL(THIS.this_nCCustoTit, 0)
            loc_cVals = loc_cVals + ", " + FormatarNumeroSQL(THIS.this_nLogAlt, 0)
            loc_cVals = loc_cVals + ", " + FormatarNumeroSQL(THIS.this_nFpublSobr, 0)
            loc_cVals = loc_cVals + ", " + FormatarNumeroSQL(THIS.this_nInfSenha, 0)
            loc_cVals = loc_cVals + ", " + FormatarNumeroSQL(THIS.this_nOptPreCad, 0)
            loc_cVals = loc_cVals + ", " + FormatarNumeroSQL(THIS.this_nNascObrig, 0)
            loc_cVals = loc_cVals + ", " + EscaparSQL(THIS.this_cGrupoFalha)
            loc_cVals = loc_cVals + ", " + EscaparSQL(THIS.this_cContaFalha)
            loc_cVals = loc_cVals + ", " + FormatarNumeroSQL(THIS.this_nCntVinc, 0)
            loc_cVals = loc_cVals + ", " + EscaparSQL(THIS.this_cContaPdr)
            *-- Campos de descricao (calculados/display - salvar vazios)
            loc_cVals = loc_cVals + ", '', '', '', '', '', ''"
            *-- Colunas mais recentes sem controle no formulario (default 0)
            loc_cVals = loc_cVals + ", 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0"

            loc_cSQL = "INSERT INTO SigCdGcr (" + ;
                "codigos, descrs, internos, dgcods, classes, tpcods, tpemps, tpcads, " + ;
                "gerbals, cargos, cepobris, coletors, comis, cpfobrigs, dadcoms, " + ;
                "fiscais, followups, limcres, pessoais, refbancs, respos, " + ;
                "mfotos, grufals, contconts, intconts, contabs, empresas, estoques, " + ;
                "calcsalds, unifbals, complems, emprelevs, balfalpers, " + ;
                "limestoqs, blqdivops, ccustos, ddfutus, ddretros, verests, blqcongvs, " + ;
                "tipoinvs, caracteris, observas, chklimcrds, chklimests, infcads, " + ;
                "osalfuns, patrietqs, rgobrigs, calcimeds, " + ;
                "ddsems, hordd, tpprecos, commoedas, chktits, ospends, " + ;
                "compagrus, trfpesas, difpesags, fichatecs, pqs, sinals, " + ;
                "grupolms, agrupas, rodrelcc, padpgrecs, chkendds, chkendrs, ctrlotes, " + ;
                "cfgcdgcr, " + ;
                "cfgfiscos, cfgfiscss, cfgfisics, cfgfisiis, cfgfisins, " + ;
                "cfgfisips, cfgfisirs, cfgfisiss, cfgfispis, " + ;
                "titbaixado, molimcre, vrlimcre, " + ;
                "ccustotit, logalt, fpublsobr, infsenha, precad, dtnascobr, " + ;
                "grupofalha, contafalha, ctvinculas, contapdr, " + ;
                "desccalcimeds, descsit, descfpubls, desctlm, desccla, descseg, " + ;
                "bairroobr, cidasobr, ctainatv, endobr, invisivel, nascobr, numobr, " + ;
                "paisesobr, sexobr, tel1obr, tel2obr, defhideshow, dtespobr, Obrtelefone" + ;
                ") VALUES (" + loc_cVals + ")"

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("INSERT")
                loc_lSucesso = .T.
            ELSE
                MostrarErro("Erro ao inserir grupo CCR:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao inserir:" + CHR(13) + loException.Message, "ccrBO.Inserir")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    PROTECTED PROCEDURE Atualizar()
    *==========================================================================
    *-- UPDATE SigCdGcr com todos os campos (exceto PK)
        LOCAL loc_lSucesso, loc_nResultado, loc_cSQL, loc_cSet
        LOCAL loc_nSinal_n, loc_cOsalfuns
        loc_lSucesso = .F.

        TRY
            *-- Codificar CfgCdGcr antes de salvar
            THIS.CodificarCfgCdGcr()

            *-- Calcular valores especiais
            loc_nSinal_n  = IIF(THIS.this_cSinal='+', 1, IIF(THIS.this_cSinal='-', 2, IIF(THIS.this_cSinal='P', 3, IIF(THIS.this_cSinal='Q', 4, 1))))
            loc_cOsalfuns = IIF(THIS.this_lCheck1,'1','0') + IIF(THIS.this_lCheck2,'1','0') + IIF(THIS.this_lCheck3,'1','0')

            *-- Montar clausula SET
            loc_cSet = " descrs     = " + EscaparSQL(THIS.this_cDescrs)
            loc_cSet = loc_cSet + ", internos   = " + EscaparSQL(THIS.this_cInterno)
            loc_cSet = loc_cSet + ", dgcods     = " + EscaparSQL(THIS.this_cDigito)
            loc_cSet = loc_cSet + ", classes    = " + EscaparSQL(THIS.this_cClasses)
            loc_cSet = loc_cSet + ", tpcods     = " + FormatarNumeroSQL(THIS.this_nTpCods, 0)
            loc_cSet = loc_cSet + ", tpemps     = " + FormatarNumeroSQL(THIS.this_nTpEmps, 0)
            loc_cSet = loc_cSet + ", tpcads     = " + FormatarNumeroSQL(THIS.this_nTpCads, 0)
            *-- Opcoes Geral
            loc_cSet = loc_cSet + ", gerbals    = " + FormatarNumeroSQL(THIS.this_nOptGBals, 0)
            loc_cSet = loc_cSet + ", cargos     = " + FormatarNumeroSQL(THIS.this_nOptCargos, 0)
            loc_cSet = loc_cSet + ", cepobris   = " + FormatarNumeroSQL(THIS.this_nCepObrig, 0)
            loc_cSet = loc_cSet + ", coletors   = " + FormatarNumeroSQL(THIS.this_nOptColetor, 0)
            loc_cSet = loc_cSet + ", comis      = " + FormatarNumeroSQL(THIS.this_nOptComi, 0)
            loc_cSet = loc_cSet + ", cpfobrigs  = " + FormatarNumeroSQL(THIS.this_nCpfObrig, 0)
            loc_cSet = loc_cSet + ", dadcoms    = " + FormatarNumeroSQL(THIS.this_nOptDadosCom, 0)
            loc_cSet = loc_cSet + ", fiscais    = " + FormatarNumeroSQL(THIS.this_nOptFiscais, 0)
            loc_cSet = loc_cSet + ", followups  = " + FormatarNumeroSQL(THIS.this_nOptFollowUp, 0)
            loc_cSet = loc_cSet + ", limcres    = " + FormatarNumeroSQL(THIS.this_nOptLimCre, 0)
            loc_cSet = loc_cSet + ", pessoais   = " + FormatarNumeroSQL(THIS.this_nOptPessoais, 0)
            loc_cSet = loc_cSet + ", refbancs   = " + FormatarNumeroSQL(THIS.this_nOptRefBancs, 0)
            loc_cSet = loc_cSet + ", respos     = " + FormatarNumeroSQL(THIS.this_nOptRespos, 0)
            loc_cSet = loc_cSet + ", complems   = " + FormatarNumeroSQL(THIS.this_nOptComple, 0)
            loc_cSet = loc_cSet + ", contabs    = " + FormatarNumeroSQL(THIS.this_nOptContabs, 0)
            loc_cSet = loc_cSet + ", empresas   = " + FormatarNumeroSQL(THIS.this_nOptEmpresa, 0)
            loc_cSet = loc_cSet + ", caracteris = " + FormatarNumeroSQL(THIS.this_nOptCaract, 0)
            loc_cSet = loc_cSet + ", chklimcrds = " + FormatarNumeroSQL(THIS.this_nOptChkLimCr, 0)
            loc_cSet = loc_cSet + ", precad     = " + FormatarNumeroSQL(THIS.this_nOptPreCad, 0)
            *-- Campos diretos Geral
            loc_cSet = loc_cSet + ", mfotos     = " + FormatarNumeroSQL(THIS.this_nMFotos, 0)
            loc_cSet = loc_cSet + ", grufals    = " + EscaparSQL(THIS.this_cGrupoGeral)
            loc_cSet = loc_cSet + ", contconts  = " + EscaparSQL(THIS.this_cContint)
            loc_cSet = loc_cSet + ", intconts   = " + FormatarNumeroSQL(THIS.this_nIntegCont, 0)
            loc_cSet = loc_cSet + ", vrlimcre   = " + FormatarNumeroSQL(THIS.this_nVrlimc, 2)
            loc_cSet = loc_cSet + ", commoedas  = " + EscaparSQL(THIS.this_cCdMoeda)
            loc_cSet = loc_cSet + ", rodrelcc   = " + EscaparSQL(THIS.this_cRodRelCC)
            *-- Cadastro/Financeiro diretos
            loc_cSet = loc_cSet + ", observas   = " + FormatarNumeroSQL(THIS.this_nObservacao, 0)
            loc_cSet = loc_cSet + ", rgobrigs   = " + FormatarNumeroSQL(THIS.this_nRgObrig, 0)
            loc_cSet = loc_cSet + ", ccustotit  = " + FormatarNumeroSQL(THIS.this_nCCustoTit, 0)
            loc_cSet = loc_cSet + ", logalt     = " + FormatarNumeroSQL(THIS.this_nLogAlt, 0)
            loc_cSet = loc_cSet + ", fpublsobr  = " + FormatarNumeroSQL(THIS.this_nFpublSobr, 0)
            loc_cSet = loc_cSet + ", infsenha   = " + FormatarNumeroSQL(THIS.this_nInfSenha, 0)
            loc_cSet = loc_cSet + ", dtnascobr  = " + FormatarNumeroSQL(THIS.this_nNascObrig, 0)
            loc_cSet = loc_cSet + ", ctvinculas = " + FormatarNumeroSQL(THIS.this_nCntVinc, 0)
            loc_cSet = loc_cSet + ", chkendds   = " + FormatarNumeroSQL(THIS.this_nDupEnd, 0)
            loc_cSet = loc_cSet + ", chkendrs   = " + FormatarNumeroSQL(THIS.this_nRestEnd, 0)
            loc_cSet = loc_cSet + ", padpgrecs  = " + FormatarNumeroSQL(THIS.this_nPadPreench, 0)
            loc_cSet = loc_cSet + ", titbaixado = " + FormatarNumeroSQL(THIS.this_nTitBaixado, 0)
            loc_cSet = loc_cSet + ", calcimeds  = " + FormatarNumeroSQL(THIS.this_nCalcIMeds, 0)
            loc_cSet = loc_cSet + ", infcads    = " + FormatarNumeroSQL(THIS.this_nCaracCad, 0)
            *-- Estoque opcoes
            loc_cSet = loc_cSet + ", estoques   = " + FormatarNumeroSQL(THIS.this_nOptEstPAcab, 0)
            loc_cSet = loc_cSet + ", calcsalds  = " + FormatarNumeroSQL(THIS.this_nOptSaldo, 0)
            loc_cSet = loc_cSet + ", unifbals   = " + FormatarNumeroSQL(THIS.this_nOptUnifBal, 0)
            loc_cSet = loc_cSet + ", emprelevs  = " + FormatarNumeroSQL(THIS.this_nOptRelevante, 0)
            loc_cSet = loc_cSet + ", balfalpers = " + FormatarNumeroSQL(THIS.this_nOptFalPers, 0)
            loc_cSet = loc_cSet + ", limestoqs  = " + FormatarNumeroSQL(THIS.this_nOptLimEsto, 0)
            loc_cSet = loc_cSet + ", blqdivops  = " + FormatarNumeroSQL(THIS.this_nOptBlqDivOp, 0)
            loc_cSet = loc_cSet + ", ccustos    = " + FormatarNumeroSQL(THIS.this_nOptCCustoEst, 0)
            loc_cSet = loc_cSet + ", ddfutus    = " + FormatarNumeroSQL(THIS.this_nDdF, 0)
            loc_cSet = loc_cSet + ", ddretros   = " + FormatarNumeroSQL(THIS.this_nDdR, 0)
            loc_cSet = loc_cSet + ", verests    = " + FormatarNumeroSQL(THIS.this_nOptVerEst, 0)
            loc_cSet = loc_cSet + ", blqcongvs  = " + FormatarNumeroSQL(THIS.this_nOptBlqConGV, 0)
            loc_cSet = loc_cSet + ", tipoinvs   = " + FormatarNumeroSQL(THIS.this_nOpTipoInvs, 0)
            loc_cSet = loc_cSet + ", chklimests = " + FormatarNumeroSQL(THIS.this_nOptChkLimEst, 0)
            loc_cSet = loc_cSet + ", patrietqs  = " + FormatarNumeroSQL(THIS.this_nOptPatrim, 0)
            loc_cSet = loc_cSet + ", ospends    = " + FormatarNumeroSQL(THIS.this_nGetOsPend, 0)
            loc_cSet = loc_cSet + ", chktits    = " + FormatarNumeroSQL(THIS.this_nObjDupTit, 0)
            loc_cSet = loc_cSet + ", compagrus  = " + FormatarNumeroSQL(THIS.this_nOpCompagru, 0)
            loc_cSet = loc_cSet + ", ctrlotes   = " + FormatarNumeroSQL(THIS.this_nFwoption1Est, 0)
            *-- Estoque diretos
            loc_cSet = loc_cSet + ", grupolms   = " + EscaparSQL(THIS.this_cGrupoEst)
            loc_cSet = loc_cSet + ", difpesags  = " + FormatarNumeroSQL(THIS.this_nDifPeso, 3)
            loc_cSet = loc_cSet + ", pqs        = " + EscaparSQL(THIS.this_cTfalhas)
            loc_cSet = loc_cSet + ", sinals     = " + FormatarNumeroSQL(loc_nSinal_n, 0)
            loc_cSet = loc_cSet + ", trfpesas   = " + FormatarNumeroSQL(THIS.this_nChkTrfPeso, 0)
            loc_cSet = loc_cSet + ", agrupas    = " + EscaparSQL(THIS.this_cGetAgrupa)
            loc_cSet = loc_cSet + ", grupofalha = " + EscaparSQL(THIS.this_cGrupoFalha)
            loc_cSet = loc_cSet + ", contafalha = " + EscaparSQL(THIS.this_cContaFalha)
            loc_cSet = loc_cSet + ", contapdr   = " + EscaparSQL(THIS.this_cContaPdr)
            loc_cSet = loc_cSet + ", osalfuns   = " + EscaparSQL(loc_cOsalfuns)
            *-- CfgCdGcr + CfgFis*
            loc_cSet = loc_cSet + ", cfgcdgcr   = " + EscaparSQL(PADR(THIS.this_cCfgCdGcr, 40))
            loc_cSet = loc_cSet + ", cfgfiscos  = " + EscaparSQL(THIS.CodificarFiscal("CO"))
            loc_cSet = loc_cSet + ", cfgfiscss  = " + EscaparSQL(THIS.CodificarFiscal("CS"))
            loc_cSet = loc_cSet + ", cfgfisics  = " + EscaparSQL(THIS.CodificarFiscal("IC"))
            loc_cSet = loc_cSet + ", cfgfisiis  = " + EscaparSQL(THIS.CodificarFiscal("II"))
            loc_cSet = loc_cSet + ", cfgfisins  = " + EscaparSQL(THIS.CodificarFiscal("IN"))
            loc_cSet = loc_cSet + ", cfgfisips  = " + EscaparSQL(THIS.CodificarFiscal("IP"))
            loc_cSet = loc_cSet + ", cfgfisirs  = " + EscaparSQL(THIS.CodificarFiscal("IR"))
            loc_cSet = loc_cSet + ", cfgfisiss  = " + EscaparSQL(THIS.CodificarFiscal("IS"))
            loc_cSet = loc_cSet + ", cfgfispis  = " + EscaparSQL(THIS.CodificarFiscal("PI"))

            loc_cSQL = "UPDATE SigCdGcr SET" + loc_cSet + ;
                       " WHERE codigos = " + EscaparSQL(THIS.this_cCodigos)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("UPDATE")
                loc_lSucesso = .T.
            ELSE
                MostrarErro("Erro ao atualizar grupo CCR:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao atualizar:" + CHR(13) + loException.Message, "ccrBO.Atualizar")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    PROTECTED PROCEDURE ExecutarExclusao()
    *==========================================================================
    *-- Verifica dependencias e exclui registro de SigCdGcr
        LOCAL loc_lSucesso, loc_nResultado, loc_cSQL, loc_cCodigo, loc_lDependencias
        loc_lSucesso    = .F.
        loc_lDependencias = .F.

        TRY
            loc_cCodigo = THIS.this_cCodigos

            *-- Verificar dependencias em SigMvCcr
            IF !loc_lDependencias
                loc_cSQL = "SELECT COUNT(*) AS qtd FROM SigMvCcr WHERE Grupos = " + EscaparSQL(loc_cCodigo)
                IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ChkDep") >= 0
                    SELECT cursor_4c_ChkDep
                    loc_lDependencias = (qtd > 0)
                    USE IN cursor_4c_ChkDep
                ENDIF
            ENDIF

            *-- Verificar dependencias em SigCdCli
            IF !loc_lDependencias
                loc_cSQL = "SELECT COUNT(*) AS qtd FROM SigCdCli WHERE Grupos = " + EscaparSQL(loc_cCodigo)
                IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ChkDep") >= 0
                    SELECT cursor_4c_ChkDep
                    loc_lDependencias = (qtd > 0)
                    USE IN cursor_4c_ChkDep
                ENDIF
            ENDIF

            *-- Verificar dependencias em SigMvCab
            IF !loc_lDependencias
                loc_cSQL = "SELECT COUNT(*) AS qtd FROM SigMvCab WHERE Grupos = " + EscaparSQL(loc_cCodigo)
                IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ChkDep") >= 0
                    SELECT cursor_4c_ChkDep
                    loc_lDependencias = (qtd > 0)
                    USE IN cursor_4c_ChkDep
                ENDIF
            ENDIF

            IF loc_lDependencias
                MsgAviso("Aten" + CHR(231) + CHR(227) + "o!!! Existem L" + CHR(97) + "n" + CHR(231) + "amentos Efetuados Neste Grupo!!!")
            ELSE
                loc_cSQL = "DELETE FROM SigCdGcr WHERE codigos = " + EscaparSQL(loc_cCodigo)
                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
                IF loc_nResultado >= 0
                    THIS.RegistrarAuditoria("DELETE")
                    loc_lSucesso = .T.
                ELSE
                    MostrarErro("Erro ao excluir grupo CCR:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                ENDIF
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao excluir:" + CHR(13) + loException.Message, "ccrBO.ExecutarExclusao")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    PROTECTED PROCEDURE DecodificarCfgCdGcr()
    *==========================================================================
    *-- Decodifica o campo CfgCdGcr (40 posicoes) para propriedades individuais
    *-- Cada posicao armazena 1 digito: valor do OptionGroup (1, 2, 3, etc.)
    *-- Posicoes conhecidas (legado): 1=ObrMails, 2=ObrNome, 3=VincPgRcs, 4=ObrSit,
    *-- 5=ObrTlm, 6=ObrCla, 7=ObrSeg, 8=ObrIbge, 9=CpfFixo, 10=CaracCad,
    *-- 11=AceJob, 12=VincContas
        LOCAL loc_cCfg, loc_nVal
        loc_cCfg = PADR(THIS.this_cCfgCdGcr, 40)

        *-- Posicao 1: E-mail Obrigatorio
        loc_nVal = INT(VAL(SUBSTR(loc_cCfg, 1, 1)))
        THIS.this_nObrMails  = IIF(loc_nVal < 1, 2, loc_nVal)

        *-- Posicao 2: Nome Obrigatorio
        loc_nVal = INT(VAL(SUBSTR(loc_cCfg, 2, 1)))
        THIS.this_nObrNome   = IIF(loc_nVal < 1, 2, loc_nVal)

        *-- Posicao 3: Vincula Conta PG/RC
        loc_nVal = INT(VAL(SUBSTR(loc_cCfg, 3, 1)))
        THIS.this_nVincPgRcs = IIF(loc_nVal < 1, 2, loc_nVal)

        *-- Posicao 4: Situacao Obrigatoria
        loc_nVal = INT(VAL(SUBSTR(loc_cCfg, 4, 1)))
        THIS.this_nObrSit    = IIF(loc_nVal < 1, 2, loc_nVal)

        *-- Posicao 5: Telemarketing Obrigatorio
        loc_nVal = INT(VAL(SUBSTR(loc_cCfg, 5, 1)))
        THIS.this_nObrTlm    = IIF(loc_nVal < 1, 2, loc_nVal)

        *-- Posicao 6: Classificacao Obrigatoria
        loc_nVal = INT(VAL(SUBSTR(loc_cCfg, 6, 1)))
        THIS.this_nObrCla    = IIF(loc_nVal < 1, 2, loc_nVal)

        *-- Posicao 7: Segmento Obrigatorio
        loc_nVal = INT(VAL(SUBSTR(loc_cCfg, 7, 1)))
        THIS.this_nObrSeg    = IIF(loc_nVal < 1, 2, loc_nVal)

        *-- Posicao 8: Cod IBGE Obrigatorio
        loc_nVal = INT(VAL(SUBSTR(loc_cCfg, 8, 1)))
        THIS.this_nObrIbge   = IIF(loc_nVal < 1, 2, loc_nVal)

        *-- Posicao 9: CPF/CNPJ Fixo (1=CPF, 2=CNPJ, 3=Ambos)
        loc_nVal = INT(VAL(SUBSTR(loc_cCfg, 9, 1)))
        THIS.this_nCpfFixo   = IIF(loc_nVal < 1, 1, loc_nVal)

        *-- Posicao 10: Caracteristica no Cadastro
        loc_nVal = INT(VAL(SUBSTR(loc_cCfg, 10, 1)))
        THIS.this_nCaracCad  = IIF(loc_nVal < 1, 2, loc_nVal)

        *-- Posicao 11: Acesso Job
        loc_nVal = INT(VAL(SUBSTR(loc_cCfg, 11, 1)))
        THIS.this_nAceJob    = IIF(loc_nVal < 1, 2, loc_nVal)

        *-- Posicao 12: Vincula Contas no Pag/Rec
        loc_nVal = INT(VAL(SUBSTR(loc_cCfg, 12, 1)))
        THIS.this_nVincContas= IIF(loc_nVal < 1, 2, loc_nVal)
    ENDPROC

    *==========================================================================
    PROTECTED PROCEDURE CodificarCfgCdGcr()
    *==========================================================================
    *-- Codifica propriedades individuais no campo CfgCdGcr (40 posicoes)
        LOCAL loc_cResult
        loc_cResult = REPLICATE('0', 40)

        loc_cResult = STUFF(loc_cResult, 1,  1, STR(THIS.this_nObrMails,  1))
        loc_cResult = STUFF(loc_cResult, 2,  1, STR(THIS.this_nObrNome,   1))
        loc_cResult = STUFF(loc_cResult, 3,  1, STR(THIS.this_nVincPgRcs, 1))
        loc_cResult = STUFF(loc_cResult, 4,  1, STR(THIS.this_nObrSit,    1))
        loc_cResult = STUFF(loc_cResult, 5,  1, STR(THIS.this_nObrTlm,    1))
        loc_cResult = STUFF(loc_cResult, 6,  1, STR(THIS.this_nObrCla,    1))
        loc_cResult = STUFF(loc_cResult, 7,  1, STR(THIS.this_nObrSeg,    1))
        loc_cResult = STUFF(loc_cResult, 8,  1, STR(THIS.this_nObrIbge,   1))
        loc_cResult = STUFF(loc_cResult, 9,  1, STR(THIS.this_nCpfFixo,   1))
        loc_cResult = STUFF(loc_cResult, 10, 1, STR(THIS.this_nCaracCad,  1))
        loc_cResult = STUFF(loc_cResult, 11, 1, STR(THIS.this_nAceJob,    1))
        loc_cResult = STUFF(loc_cResult, 12, 1, STR(THIS.this_nVincContas,1))

        THIS.this_cCfgCdGcr = loc_cResult
    ENDPROC

    *==========================================================================
    PROTECTED PROCEDURE DecodificarFiscal(par_cTipo, par_cEncoded)
    *==========================================================================
    *-- Decodifica campo CfgFis* (50 chars) para propriedades do tipo fiscal
    *-- Formato: Grupo(10) + Conta(10) + Pct(8,4 decimais) + Receita(10) + padding(12)
        LOCAL loc_cEncoded, loc_cGrupo, loc_cConta, loc_nPct, loc_cReceita
        loc_cEncoded = PADR(IIF(ISNULL(par_cEncoded), '', par_cEncoded), 50)
        loc_cGrupo   = ALLTRIM(SUBSTR(loc_cEncoded, 1,  10))
        loc_cConta   = ALLTRIM(SUBSTR(loc_cEncoded, 11, 10))
        loc_nPct     = VAL(ALLTRIM(SUBSTR(loc_cEncoded, 21, 8)))
        loc_cReceita = ALLTRIM(SUBSTR(loc_cEncoded, 29, 10))

        DO CASE
        CASE par_cTipo = "IC"
            THIS.this_cGrupoICMS = loc_cGrupo
            THIS.this_cContaICMS = loc_cConta
            THIS.this_nPctICMS   = loc_nPct
            THIS.this_cRecICMS   = loc_cReceita
        CASE par_cTipo = "IP"
            THIS.this_cGrupoIPI  = loc_cGrupo
            THIS.this_cContaIPI  = loc_cConta
            THIS.this_nPctIPI    = loc_nPct
            THIS.this_cRecIPI    = loc_cReceita
        CASE par_cTipo = "II"
            THIS.this_cGrupoII   = loc_cGrupo
            THIS.this_cContaII   = loc_cConta
            THIS.this_nPctII     = loc_nPct
            THIS.this_cRecII     = loc_cReceita
        CASE par_cTipo = "IS"
            THIS.this_cGrupoISS  = loc_cGrupo
            THIS.this_cContaISS  = loc_cConta
            THIS.this_nPctISS    = loc_nPct
            THIS.this_cRecISS    = loc_cReceita
        CASE par_cTipo = "IR"
            THIS.this_cGrupoIRRF = loc_cGrupo
            THIS.this_cContaIRRF = loc_cConta
            THIS.this_nPctIRRF   = loc_nPct
            THIS.this_cRecIRRF   = loc_cReceita
        CASE par_cTipo = "IN"
            THIS.this_cGrupoINSS = loc_cGrupo
            THIS.this_cContaINSS = loc_cConta
            THIS.this_nPctINSS   = loc_nPct
            THIS.this_cRecINSS   = loc_cReceita
        CASE par_cTipo = "PI"
            THIS.this_cGrupoPIS  = loc_cGrupo
            THIS.this_cContaPIS  = loc_cConta
            THIS.this_nPctPIS    = loc_nPct
            THIS.this_cRecPIS    = loc_cReceita
        CASE par_cTipo = "CS"
            THIS.this_cGrupoCSL  = loc_cGrupo
            THIS.this_cContaCSL  = loc_cConta
            THIS.this_nPctCSL    = loc_nPct
            THIS.this_cRecCSL    = loc_cReceita
        CASE par_cTipo = "CO"
            THIS.this_cGrupoCOF  = loc_cGrupo
            THIS.this_cContaCOF  = loc_cConta
            THIS.this_nPctCOF    = loc_nPct
            THIS.this_cRecCOF    = loc_cReceita
        ENDCASE
    ENDPROC

    *==========================================================================
    PROTECTED PROCEDURE CodificarFiscal(par_cTipo)
    *==========================================================================
    *-- Codifica propriedades do tipo fiscal em string de 50 chars
    *-- Formato: Grupo(10) + Conta(10) + Pct(8,4 decimais) + Receita(10) + padding(12)
        LOCAL loc_cGrupo, loc_cConta, loc_nPct, loc_cReceita, loc_cResult
        loc_cGrupo   = ""
        loc_cConta   = ""
        loc_nPct     = 0
        loc_cReceita = ""

        DO CASE
        CASE par_cTipo = "IC"
            loc_cGrupo   = THIS.this_cGrupoICMS
            loc_cConta   = THIS.this_cContaICMS
            loc_nPct     = THIS.this_nPctICMS
            loc_cReceita = THIS.this_cRecICMS
        CASE par_cTipo = "IP"
            loc_cGrupo   = THIS.this_cGrupoIPI
            loc_cConta   = THIS.this_cContaIPI
            loc_nPct     = THIS.this_nPctIPI
            loc_cReceita = THIS.this_cRecIPI
        CASE par_cTipo = "II"
            loc_cGrupo   = THIS.this_cGrupoII
            loc_cConta   = THIS.this_cContaII
            loc_nPct     = THIS.this_nPctII
            loc_cReceita = THIS.this_cRecII
        CASE par_cTipo = "IS"
            loc_cGrupo   = THIS.this_cGrupoISS
            loc_cConta   = THIS.this_cContaISS
            loc_nPct     = THIS.this_nPctISS
            loc_cReceita = THIS.this_cRecISS
        CASE par_cTipo = "IR"
            loc_cGrupo   = THIS.this_cGrupoIRRF
            loc_cConta   = THIS.this_cContaIRRF
            loc_nPct     = THIS.this_nPctIRRF
            loc_cReceita = THIS.this_cRecIRRF
        CASE par_cTipo = "IN"
            loc_cGrupo   = THIS.this_cGrupoINSS
            loc_cConta   = THIS.this_cContaINSS
            loc_nPct     = THIS.this_nPctINSS
            loc_cReceita = THIS.this_cRecINSS
        CASE par_cTipo = "PI"
            loc_cGrupo   = THIS.this_cGrupoPIS
            loc_cConta   = THIS.this_cContaPIS
            loc_nPct     = THIS.this_nPctPIS
            loc_cReceita = THIS.this_cRecPIS
        CASE par_cTipo = "CS"
            loc_cGrupo   = THIS.this_cGrupoCSL
            loc_cConta   = THIS.this_cContaCSL
            loc_nPct     = THIS.this_nPctCSL
            loc_cReceita = THIS.this_cRecCSL
        CASE par_cTipo = "CO"
            loc_cGrupo   = THIS.this_cGrupoCOF
            loc_cConta   = THIS.this_cContaCOF
            loc_nPct     = THIS.this_nPctCOF
            loc_cReceita = THIS.this_cRecCOF
        OTHERWISE
            RETURN SPACE(50)
        ENDCASE

        *-- Montar string de 50 chars: Grupo(10)+Conta(10)+Pct(8)+Receita(10)+padding(12)
        loc_cResult = PADR(loc_cGrupo,   10) + ;
                      PADR(loc_cConta,   10) + ;
                      STR(loc_nPct,   8, 4)  + ;
                      PADR(loc_cReceita, 10) + ;
                      SPACE(12)

        RETURN PADR(loc_cResult, 50)
    ENDPROC

ENDDEFINE

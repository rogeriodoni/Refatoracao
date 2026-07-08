*==============================================================================
* sigpdmp2BO.prg - Business Object para Componentes de Producao (SIGPDMP2)
* Herda de: BusinessBase
* Form OPERACIONAL: Sub-form de edicao de componentes por fase de producao.
* Opera sobre cursor VFP xNensi (componentes da OP) passado pelo form pai.
* Fase 1/8: Propriedades e Init()
*==============================================================================

DEFINE CLASS sigpdmp2BO AS BusinessBase

    *--------------------------------------------------------------------------
    * Identificacao - sem tabela SQL direta (opera em cursor VFP xNensi)
    *--------------------------------------------------------------------------
    this_cTabela     = ""
    this_cCampoChave = ""

    *--------------------------------------------------------------------------
    * Contexto do form pai (recebidos no Init do form via parametros)
    *--------------------------------------------------------------------------
    this_cPcEscolha     = ""    && "INSERIR" / "ALTERAR" / "VISUALIZAR" / "EXCLUIR"
    this_cPEmps         = ""    && Empresa do form pai (pEmps)
    this_cPDopps        = ""    && Dopps da OP aberta pelo form pai

    *--------------------------------------------------------------------------
    * Propriedades da linha corrente do cursor xNensi (grid de componentes)
    *--------------------------------------------------------------------------
    this_cEmps          = ""    && Empresa (Emps C3)
    this_cDopps         = ""    && Codigo da OP de origem (Dopps)
    this_nNumps         = 0     && Numero da producao (Numps)
    this_nNops          = 0     && Numero da Ordem de Producao (Nops)
    this_nNenvs         = 0     && Numero do envelope / lote (Nenvs)
    this_cCMats         = ""    && Codigo do material / componente (CMats C14)
    this_cCDescs        = ""    && Descricao do componente (CDescs)
    this_cCGrus         = ""    && Codigo do grupo do produto (CGrus)
    this_cCUnis         = ""    && Unidade de medida da quantidade (Cunis)
    this_cCUniPs        = ""    && Unidade de medida do peso (CUniPs)
    this_cTpOps         = ""    && Tipo de material / operacao (TpOps)
    this_nQtds          = 0     && Quantidade (Qtds N12,3)
    this_nPesos         = 0     && Peso fabricacao (Pesos N12,3)
    this_nPeso2s        = 0     && Peso da unidade (Peso2s N12,3)
    this_nPsFaseAnt     = 0     && Peso da fase anterior (PsFaseAnt N12,3)
    this_nQtFaseAnt     = 0     && Quantidade da fase anterior (QtFaseAnt N12,3)
    this_nPs2FaseAnt    = 0     && Peso secundario da fase anterior (Ps2FaseAnt N12,3)
    this_cCodCors       = ""    && Codigo da cor (CodCors C4)
    this_cCodTams       = ""    && Codigo do tamanho (CodTams C4)
    this_nNLotes        = 0     && Numero do lote (nLotes)
    this_nAmarracao     = 0     && Codigo de amarracao/agregacao (Amarracao)
    this_cCats          = ""    && Categoria do servico (Cats C6)
    this_nFators        = 0     && Fator / valor do servico (Fators N12,2)
    this_nCoefs         = 0     && Coeficiente de retrabalho (Coefs N12,2)
    this_cMoedas        = ""    && Codigo da moeda do servico (Moedas C3)
    this_lServicos      = .F.   && Linha e um servico? (Servicos BIT->LOGICAL)
    this_nServAuto      = 0     && Tipo de servico automatico: 1=auto 2=valor (ServAuto N1)
    this_cGrupoFins     = ""    && Grupo financeiro do servico (GrupoFins)
    this_cGrupoFs       = ""    && Grupo financeiro do funcionario (GrupoFs)
    this_cContaFs       = ""    && Conta do funcionario (ContaFs)
    this_cLibProds      = ""    && Codigo de liberacao do produto (LibProds)
    this_lCarCompos     = .F.   && Linha carrega composicao? (CarCompos BIT->LOGICAL)
    this_cMatPrincs     = ""    && Material principal do semiacabado (MatPrincs C14)
    this_lRetrabs       = .F.   && Linha tem retrabalho? (Retrabs BIT->LOGICAL)
    this_cCodnConfs     = ""    && Codigo de nao-conformidade (CodnConfs)
    this_cObss          = ""    && Observacao da linha (Obss)
    this_lFlagIncs      = .F.   && Flag de inclusao manual (FlagIncs BIT->LOGICAL)
    this_nRateio        = 0     && Tipo de rateio: 1=composto 2=agg_inv 3=agg 5=direto (Rateio N1)
    this_lVisivel       = .F.   && Linha visivel no grid? (Visivel BIT->LOGICAL)
    this_lNChkSep       = .F.   && Checar separacao? (NChkSep BIT->LOGICAL)

    *--------------------------------------------------------------------------
    * Descricoes de lookup (nao persistidas, preenchidas via query de apoio)
    *--------------------------------------------------------------------------
    this_cDsCMats       = ""    && Descricao do produto (DPros de SigCdPro)
    this_cDsCGrus       = ""    && Descricao do grupo (DGrus de SigCdGrp)
    this_cDsMoedas      = ""    && Descricao da moeda (DMoes de SigCdMoe)
    this_cDsCodCors     = ""    && Descricao da cor (Descs de SigCdCor)
    this_cDsCodTams     = ""    && Descricao do tamanho (Descs de SigCdTam)
    this_cDsTpOps       = ""    && Descricao do tipo de material (de SigCdRpo / SigOpOpt)
    this_cDsCats        = ""    && Descricao da categoria de servico (de crSigCdSvc)

    *--------------------------------------------------------------------------
    * Estado operacional do form (sincronizados com propriedades do Form)
    *--------------------------------------------------------------------------
    this_lInfoLote      = .F.   && OP usa controle de lote? (InfoLote do form)
    this_lInfoEnve      = .F.   && Envelope obrigatorio? (InfoEnve: EnvObrigs=1)
    this_lEditaEnve     = .F.   && Editar envelope? (EditaEnve: EnvObrigs=3)
    this_nCtrlAgrega    = 0     && Contador de grupos de agregacao (CtrlAgrega)
    this_lAlteraServico = .F.   && Usuario pode alterar valor do servico? (AlteraServico)
    this_nTrfPesa       = 0     && Tipo de transferencia de peso (TrfPesa de crSigCdOpd)
    this_nCompAgru      = 0     && Tipo de composicao agregada (CompAgru de crSigCdOpd)
    this_lLibInserir    = .T.   && Botao Inserir liberado? (LibInserir)
    this_lInibeInserir  = .T.   && Permissao inserir? (InibeInserir via fChecaAcesso)
    this_lInibeAlterar  = .T.   && Permissao alterar? (InibeAlterar via fChecaAcesso)
    this_lInibeExcluir  = .T.   && Permissao excluir? (InibeExcluir via fChecaAcesso)

    *--------------------------------------------------------------------------
    * Valores anteriores usados nas validacoes de campo do grid
    *--------------------------------------------------------------------------
    this_cAntValue      = ""    && Valor anterior do campo Componente (14 chars)
    this_nAntQtde       = 0     && Quantidade antes da edicao (AntQtde)
    this_nAntPeso       = 0     && Peso antes da edicao (AntPeso / Antpeso)
    this_nAntValueP     = 0     && Valor do campo Peso2s antes da edicao (AntValueP)
    this_cObsAnterior   = ""    && TpOps da linha anterior (ObsAnterior, Repete Tipo Material)

    *--------------------------------------------------------------------------
    * Configuracao da balanca serial (de crSigCdPam)
    *--------------------------------------------------------------------------
    this_nBalPorta      = 0     && Porta COM da balanca (BalPortas)
    this_nBalVelocidade = 0     && Velocidade serial (BalVelocs)
    this_nBalTpParidade = 0     && Tipo de paridade (BalTppars)
    this_nBalBits       = 0     && Bits da balanca (BalBits)
    this_nBalParidade   = 0     && Paridade da balanca (BalParids)

    *--------------------------------------------------------------------------
    * Configuracao da OP corrente (cache de crSigCdOpd para validacoes)
    *--------------------------------------------------------------------------
    this_nGrOdns        = 0     && Grupo de ordem (GrOdns): 1=por grupo
    this_nSepPedras     = 0     && Separacao de pedras (SepPedras)
    this_nChkQtdPs      = 0     && Checagem quantidade/peso (ChkQtdPs)
    this_nPesoFixs      = 0     && Peso fixo (PesoFixs): 2=proporcional ao mat principal
    this_nPesoBals      = 0     && Peso via balanca (PesoBals): 1=balanca obrigatoria
    this_nPagServs      = 0     && Pagamento de servicos (PagServs)
    this_lPccs          = .F.   && Usa PCC? (Pccs BIT->LOGICAL)
    this_nBtnRets       = 0     && Visibilidade do botao Retrabalho (BtnRets)
    this_nBtnIncs       = 0     && Visibilidade do botao Nao-Conforme (BtnIncs)
    this_nBtnPags       = 0     && Visibilidade do botao Pagamento (BtnPags)
    this_nInibAlts      = 0     && Inibe alteracoes? (InibAlts)
    this_nMensagens     = 0     && Exibe mensagens de produto? (Mensagens)
    this_nQtdNegs       = 0     && Aceita quantidade negativa? (QtdNegs)
    this_cMatPads       = ""    && Material padrao da OP (MatPads C14)
    this_cChkMtPrs      = 0     && Checa material principal? (ChkMtPrs)
    this_cTpPadraos     = ""    && Tipo padrao de material da OP (TpPadraos)
    this_nCasQtds       = 0     && Casas decimais da quantidade (CasQtds)
    this_cDopps_Op      = ""    && Dopps da operacao de configuracao (crSigCdOpd.Dopps)
    this_nNdopps        = 0     && Ndopps da operacao (crSigCdOpd.Ndopps)

    *==========================================================================
    PROCEDURE Init()
    *==========================================================================
        LOCAL loc_lSucesso

        loc_lSucesso = .F.

        TRY
            DODEFAULT()

            THIS.this_cTabela     = ""
            THIS.this_cCampoChave = ""

            loc_lSucesso = .T.

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    PROTECTED PROCEDURE ObterChavePrimaria()
    *==========================================================================
        RETURN TRANSFORM(THIS.this_nNops) + "|" + ;
               TRANSFORM(THIS.this_nNenvs) + "|" + ;
               ALLTRIM(THIS.this_cCMats)
    ENDPROC

    *==========================================================================
    * Inserir - Insere linha corrente (this_*) no cursor xNensi
    * Sobrescreve BusinessBase.Inserir(). O form OPERACIONAL persiste em cursor
    * VFP (xNensi); a gravacao SQL definitiva e feita pelo form pai apos ok.
    *==========================================================================
    PROTECTED PROCEDURE Inserir()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF !USED("xNensi")
                THIS.this_cMensagemErro = "Cursor xNensi n" + CHR(227) + "o aberto"
                loc_lSucesso = loc_lSucesso
            ENDIF

            INSERT INTO xNensi ( ;
                Emps, Dopps, Numps, Nops, Nenvs, ;
                CMats, CDescs, CGrus, Cunis, CUniPs, TpOps, ;
                Qtds, Pesos, Peso2s, ;
                PsFaseAnt, QtFaseAnt, Ps2FaseAnt, ;
                CodCors, CodTams, nLotes, Amarracao, ;
                Cats, Fators, Coefs, Moedas, ;
                Servicos, ServAuto, LibProds, CarCompos, MatPrincs, ;
                Retrabs, CodnConfs, Obss, FlagIncs, Rateio, ;
                Visivel, NChkSep) ;
                VALUES ( ;
                THIS.this_cEmps, THIS.this_cDopps, THIS.this_nNumps, ;
                THIS.this_nNops, THIS.this_nNenvs, ;
                THIS.this_cCMats, THIS.this_cCDescs, THIS.this_cCGrus, ;
                THIS.this_cCUnis, THIS.this_cCUniPs, THIS.this_cTpOps, ;
                THIS.this_nQtds, THIS.this_nPesos, THIS.this_nPeso2s, ;
                THIS.this_nPsFaseAnt, THIS.this_nQtFaseAnt, THIS.this_nPs2FaseAnt, ;
                THIS.this_cCodCors, THIS.this_cCodTams, THIS.this_nNLotes, THIS.this_nAmarracao, ;
                THIS.this_cCats, THIS.this_nFators, THIS.this_nCoefs, THIS.this_cMoedas, ;
                THIS.this_lServicos, THIS.this_nServAuto, THIS.this_cLibProds, ;
                THIS.this_lCarCompos, THIS.this_cMatPrincs, ;
                THIS.this_lRetrabs, THIS.this_cCodnConfs, THIS.this_cObss, ;
                THIS.this_lFlagIncs, THIS.this_nRateio, ;
                THIS.this_lVisivel, THIS.this_lNChkSep)

            THIS.RegistrarAuditoria("INSERT")
            loc_lSucesso = .T.

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = "Erro ao inserir: " + loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro Inserir")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * Atualizar - Atualiza linha corrente do cursor xNensi com this_*
    * Sobrescreve BusinessBase.Atualizar(). Opera sobre a linha posicionada
    * no cursor xNensi (chave Nops + Nenvs + CMats via ObterChavePrimaria).
    *==========================================================================
    PROTECTED PROCEDURE Atualizar()
        LOCAL loc_lSucesso, loc_cOrdemAnterior
        loc_lSucesso = .F.

        TRY
            IF !USED("xNensi")
                THIS.this_cMensagemErro = "Cursor xNensi n" + CHR(227) + "o aberto"
                loc_lSucesso = loc_lSucesso
            ENDIF

            SELECT xNensi
            loc_cOrdemAnterior = ORDER()
            SET ORDER TO NopMatCat

            IF !SEEK(STR(THIS.this_nNops, 10) + THIS.this_cCMats)
                IF !EMPTY(loc_cOrdemAnterior)
                    SET ORDER TO (loc_cOrdemAnterior)
                ELSE
                    SET ORDER TO Editar
                ENDIF
                THIS.this_cMensagemErro = "Registro n" + CHR(227) + "o encontrado em xNensi"
                loc_lSucesso = loc_lSucesso
            ENDIF

            REPLACE ;
                Emps        WITH THIS.this_cEmps, ;
                Dopps       WITH THIS.this_cDopps, ;
                Numps       WITH THIS.this_nNumps, ;
                Nenvs       WITH THIS.this_nNenvs, ;
                CDescs      WITH THIS.this_cCDescs, ;
                CGrus       WITH THIS.this_cCGrus, ;
                Cunis       WITH THIS.this_cCUnis, ;
                CUniPs      WITH THIS.this_cCUniPs, ;
                TpOps       WITH THIS.this_cTpOps, ;
                Qtds        WITH THIS.this_nQtds, ;
                Pesos       WITH THIS.this_nPesos, ;
                Peso2s      WITH THIS.this_nPeso2s, ;
                PsFaseAnt   WITH THIS.this_nPsFaseAnt, ;
                QtFaseAnt   WITH THIS.this_nQtFaseAnt, ;
                Ps2FaseAnt  WITH THIS.this_nPs2FaseAnt, ;
                CodCors     WITH THIS.this_cCodCors, ;
                CodTams     WITH THIS.this_cCodTams, ;
                nLotes      WITH THIS.this_nNLotes, ;
                Amarracao   WITH THIS.this_nAmarracao, ;
                Cats        WITH THIS.this_cCats, ;
                Fators      WITH THIS.this_nFators, ;
                Coefs       WITH THIS.this_nCoefs, ;
                Moedas      WITH THIS.this_cMoedas, ;
                Servicos    WITH THIS.this_lServicos, ;
                ServAuto    WITH THIS.this_nServAuto, ;
                LibProds    WITH THIS.this_cLibProds, ;
                CarCompos   WITH THIS.this_lCarCompos, ;
                MatPrincs   WITH THIS.this_cMatPrincs, ;
                Retrabs     WITH THIS.this_lRetrabs, ;
                CodnConfs   WITH THIS.this_cCodnConfs, ;
                Obss        WITH THIS.this_cObss, ;
                FlagIncs    WITH THIS.this_lFlagIncs, ;
                Rateio      WITH THIS.this_nRateio, ;
                Visivel     WITH THIS.this_lVisivel, ;
                NChkSep     WITH THIS.this_lNChkSep ;
                IN xNensi

            IF !EMPTY(loc_cOrdemAnterior)
                SET ORDER TO (loc_cOrdemAnterior)
            ELSE
                SET ORDER TO Editar
            ENDIF

            THIS.RegistrarAuditoria("UPDATE")
            loc_lSucesso = .T.

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = "Erro ao atualizar: " + loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro Atualizar")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * ExecutarExclusao - Marca a linha corrente do cursor xNensi como deletada
    * Sobrescreve BusinessBase.ExecutarExclusao(). A persistencia SQL e feita
    * pelo form pai ao confirmar a sub-tela.
    *==========================================================================
    PROTECTED PROCEDURE ExecutarExclusao()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF !USED("xNensi")
                THIS.this_cMensagemErro = "Cursor xNensi n" + CHR(227) + "o aberto"
                loc_lSucesso = loc_lSucesso
            ENDIF

            SELECT xNensi
            IF EOF() OR BOF()
                THIS.this_cMensagemErro = "Nenhuma linha posicionada para excluir"
                loc_lSucesso = loc_lSucesso
            ENDIF

            DELETE IN xNensi
            THIS.RegistrarAuditoria("DELETE")
            loc_lSucesso = .T.

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = "Erro ao excluir: " + loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro Excluir")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * RegistrarAuditoria - Loga operacao em LogAuditoria
    * par_cOperacao: "INSERT" | "UPDATE" | "DELETE"
    * Tabela logica: "xNensi" (cursor operacional do form SIGPDMP2)
    *==========================================================================
    PROTECTED PROCEDURE RegistrarAuditoria(par_cOperacao)
        LOCAL loc_cSQL, loc_cChave, loc_cUsuario, loc_cTabelaLog

        TRY
            loc_cChave = THIS.ObterChavePrimaria()
            IF EMPTY(loc_cChave)
                loc_lResultado = .F.
            ENDIF

            loc_cTabelaLog = "xNensi"
            loc_cUsuario   = IIF(TYPE("gc_4c_UsuarioLogado") = "C", gc_4c_UsuarioLogado, "SISTEMA")

            loc_cSQL = "INSERT INTO LogAuditoria (Tabela, Operacao, ChaveRegistro, Usuario, DataHora) " + ;
                       "VALUES (" + EscaparSQL(loc_cTabelaLog) + ", " + ;
                                    EscaparSQL(par_cOperacao) + ", " + ;
                                    EscaparSQL(loc_cChave) + ", " + ;
                                    EscaparSQL(loc_cUsuario) + ", GETDATE())"

            IF TYPE("gnConnHandle") = "N" AND gnConnHandle > 0
                SQLEXEC(gnConnHandle, loc_cSQL)
            ENDIF

        CATCH TO loc_oErro
            * Falha em auditoria nao deve interromper operacao do form operacional
        ENDTRY

        RETURN .T.
    ENDPROC

    *==========================================================================
    * CarregarDoCursor - Carrega propriedades a partir do registro corrente
    * par_cAliasCursor: alias do cursor de origem (normalmente "xNensi")
    *==========================================================================
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF !USED(par_cAliasCursor)
                loc_lSucesso = loc_lSucesso
            ENDIF

            SELECT (par_cAliasCursor)

            THIS.this_cEmps       = NVL(Emps,       "")
            THIS.this_cDopps      = NVL(Dopps,      "")
            THIS.this_nNumps      = NVL(Numps,       0)
            THIS.this_nNops       = NVL(Nops,         0)
            THIS.this_nNenvs      = NVL(Nenvs,        0)
            THIS.this_cCMats      = NVL(CMats,       "")
            THIS.this_cCDescs     = NVL(CDescs,      "")
            THIS.this_cCGrus      = NVL(CGrus,       "")
            THIS.this_cCUnis      = NVL(Cunis,       "")
            THIS.this_cCUniPs     = NVL(CUniPs,      "")
            THIS.this_cTpOps      = NVL(TpOps,       "")
            THIS.this_nQtds       = NVL(Qtds,         0)
            THIS.this_nPesos      = NVL(Pesos,        0)
            THIS.this_nPeso2s     = NVL(Peso2s,       0)
            THIS.this_nPsFaseAnt  = NVL(PsFaseAnt,    0)
            THIS.this_nQtFaseAnt  = NVL(QtFaseAnt,    0)
            THIS.this_nPs2FaseAnt = NVL(Ps2FaseAnt,   0)
            THIS.this_cCodCors    = NVL(CodCors,     "")
            THIS.this_cCodTams    = NVL(CodTams,     "")
            THIS.this_nNLotes     = NVL(nLotes,       0)
            THIS.this_nAmarracao  = NVL(Amarracao,    0)
            THIS.this_cCats       = NVL(Cats,        "")
            THIS.this_nFators     = NVL(Fators,       0)
            THIS.this_nCoefs      = NVL(Coefs,        0)
            THIS.this_cMoedas     = NVL(Moedas,      "")
            THIS.this_nServAuto   = NVL(ServAuto,     0)
            THIS.this_cLibProds   = NVL(LibProds,    "")
            THIS.this_cMatPrincs  = NVL(MatPrincs,   "")
            THIS.this_cCodnConfs  = NVL(CodnConfs,   "")
            THIS.this_cObss       = NVL(Obss,        "")
            THIS.this_nRateio     = NVL(Rateio,       0)

            *-- Campos BIT do SQL Server chegam como LOGICAL no VFP9
            IF VARTYPE(Servicos) = "L"
                THIS.this_lServicos = Servicos
            ELSE
                THIS.this_lServicos = IIF(NVL(Servicos, .F.), .T., .F.)
            ENDIF

            IF VARTYPE(CarCompos) = "L"
                THIS.this_lCarCompos = CarCompos
            ELSE
                THIS.this_lCarCompos = IIF(NVL(CarCompos, .F.), .T., .F.)
            ENDIF

            IF VARTYPE(Retrabs) = "L"
                THIS.this_lRetrabs = Retrabs
            ELSE
                THIS.this_lRetrabs = IIF(NVL(Retrabs, .F.), .T., .F.)
            ENDIF

            IF VARTYPE(FlagIncs) = "L"
                THIS.this_lFlagIncs = FlagIncs
            ELSE
                THIS.this_lFlagIncs = IIF(NVL(FlagIncs, .F.), .T., .F.)
            ENDIF

            IF VARTYPE(Visivel) = "L"
                THIS.this_lVisivel = Visivel
            ELSE
                THIS.this_lVisivel = IIF(NVL(Visivel, .F.), .T., .F.)
            ENDIF

            IF VARTYPE(NChkSep) = "L"
                THIS.this_lNChkSep = NChkSep
            ELSE
                THIS.this_lNChkSep = IIF(NVL(NChkSep, .F.), .T., .F.)
            ENDIF

            loc_lSucesso = .T.

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao carregar cursor")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * InserirNaGrade - Insere nova linha vazia no cursor xNensi
    * Replica logica do Inserir.Click do legado (SIGPDMP2)
    * par_cAliasTmpNens: alias do cursor TmpNens (dados da producao)
    * par_cAliasOpd:     alias do crSigCdOpd (configuracao da OP)
    * par_nCompAgru:     CompAgru do form (tipo de composicao agregada)
    * Retorna .T. se inseriu / posicionou com sucesso
    *==========================================================================
    PROCEDURE InserirNaGrade(par_cAliasTmpNens, par_cAliasOpd, par_nCompAgru)
        LOCAL loc_lSucesso
        LOCAL loc_cEmps, loc_cDopps, loc_nNumps, loc_cTpPadraos, loc_nPsFaseAnt

        loc_lSucesso = .F.

        TRY
            IF !USED("xNensi") OR !USED(par_cAliasTmpNens) OR !USED(par_cAliasOpd)
                loc_lSucesso = loc_lSucesso
            ENDIF

            SELECT (par_cAliasTmpNens)
            loc_cEmps  = Emps
            loc_cDopps = Dopps
            loc_nNumps = Numps

            SELECT (par_cAliasOpd)
            loc_cTpPadraos = TpPadraos

            SELECT xNensi
            SET ORDER TO NopMatCat

            IF !SEEK(STR(0, 10) + SPACE(13))
                *-- Nenhuma linha vazia: insere nova linha em branco
                INSERT INTO xNensi (Emps, Dopps, Numps, Visivel, Rateio, FlagIncs, TpOps, NChkSep) ;
                             VALUES (loc_cEmps, loc_cDopps, loc_nNumps, .T., 5, .T., loc_cTpPadraos, .T.)
                loc_lSucesso = .T.
            ELSE
                *-- Ja existe linha vazia; se CompAgru=1 com peso anterior, insere outra
                loc_nPsFaseAnt = xNensi.PsFaseAnt
                IF (par_nCompAgru = 1) AND (loc_nPsFaseAnt <> 0)
                    INSERT INTO xNensi (Emps, Dopps, Numps, Visivel, Rateio, FlagIncs, TpOps, NChkSep) ;
                                 VALUES (loc_cEmps, loc_cDopps, loc_nNumps, .T., 5, .T., loc_cTpPadraos, .T.)
                ENDIF
                loc_lSucesso = .T.
            ENDIF

            SET ORDER TO Editar

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao inserir na grade")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * ExcluirDaGrade - Remove linha(s) do cursor xNensi conforme config da OP
    * Replica logica do Excluir.Click do legado (SIGPDMP2)
    * par_nSepPedras: CrSigCdOpd.SepPedras
    * par_nChkQtdPs:  CrSigCdOpd.CHKQTDPS
    * Retorna .T. se excluiu com sucesso
    *==========================================================================
    PROCEDURE ExcluirDaGrade(par_nSepPedras, par_nChkQtdPs)
        LOCAL loc_lSucesso
        LOCAL loc_cCMats, loc_nNenvs, loc_nNops, loc_nAmarracao, loc_lFlagIncs

        loc_lSucesso = .F.

        TRY
            IF !USED("xNensi")
                loc_lSucesso = loc_lSucesso
            ENDIF

            SELECT xNensi
            IF EOF() OR BOF()
                loc_lSucesso = loc_lSucesso
            ENDIF

            loc_cCMats     = xNensi.CMats
            loc_nNenvs     = xNensi.Nenvs
            loc_nNops      = xNensi.Nops
            loc_nAmarracao = xNensi.Amarracao
            loc_lFlagIncs  = IIF(VARTYPE(xNensi.FlagIncs) = "L", xNensi.FlagIncs, ;
                                 IIF(NVL(xNensi.FlagIncs, .F.), .T., .F.))

            SET ORDER TO

            IF par_nSepPedras = 4
                *-- Separacao de pedras: deleta pelo CMats (exceto linhas de servico)
                DELETE ALL FOR loc_cCMats = CMats AND !Servicos

            ELSE
                IF par_nChkQtdPs = 4
                    *-- ChkQtdPs=4: deleta somente agregados da mesma amarracao se FlagIncs
                    IF loc_lFlagIncs
                        DELETE ALL FOR FlagIncs AND loc_cCMats = CMats AND Amarracao = loc_nAmarracao
                    ENDIF

                ELSE
                    *-- Padrao: deleta por Nenvs+Nops ou por amarracao
                    IF loc_nAmarracao = 0
                        DELETE ALL FOR FlagIncs AND loc_cCMats = CMats AND ;
                                        loc_nNenvs = Nenvs AND loc_nNops = Nops
                    ELSE
                        DELETE ALL FOR FlagIncs AND ;
                                        IIF(!EMPTY(loc_nAmarracao), Amarracao = loc_nAmarracao, CMats = loc_cCMats)
                    ENDIF
                ENDIF
            ENDIF

            SET ORDER TO Editar
            loc_lSucesso = .T.

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao excluir da grade")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * ValidarGradeAntesFechar - Valida todos os lancamentos antes de fechar
    * Replica logica do ok.Click do legado (SIGPDMP2)
    * par_cPcEscolha:    modo ("INSERIR" / "ALTERAR" / "VISUALIZAR")
    * par_cAliasTmpNens: alias do cursor TmpNens
    * par_cAliasOpd:     alias do cursor crSigCdOpd
    * Retorna "" se valido; mensagem de aviso se invalido
    *==========================================================================
    PROCEDURE ValidarGradeAntesFechar(par_cPcEscolha, par_cAliasTmpNens, par_cAliasOpd)
        LOCAL loc_cMensagem, loc_nResult, loc_cSQL
        LOCAL loc_lDispNensi, loc_lChkCor, loc_lChkTam, loc_lDupTpO
        LOCAL loc_nGrOdns, loc_nQtdNegs
        LOCAL loc_cGrupoOs, loc_cEmps, loc_cDopps, loc_nNumps

        loc_cMensagem  = ""
        loc_lDispNensi = .F.
        loc_lChkCor    = .F.
        loc_lChkTam    = .F.
        loc_lDupTpO    = .F.

        TRY
            IF !INLIST(par_cPcEscolha, "INSERIR", "ALTERAR")
                loc_lResultado = loc_cMensagem
            ENDIF

            IF !USED("xNensi") OR !USED(par_cAliasOpd) OR !USED(par_cAliasTmpNens)
                loc_lResultado = loc_cMensagem
            ENDIF

            SELECT (par_cAliasOpd)
            loc_nGrOdns  = GrOdns
            loc_nQtdNegs = QtdNegs

            IF loc_nGrOdns = 1
                loc_lResultado = loc_cMensagem
            ENDIF

            SELECT (par_cAliasTmpNens)
            loc_cGrupoOs = GrupoOs
            loc_cEmps    = Emps
            loc_cDopps   = Dopps
            loc_nNumps   = Numps

            SELECT xNensi
            SCAN
                IF EMPTY(TpOps) AND EMPTY(Cats)
                    loc_lDispNensi = .T.
                    EXIT
                ENDIF

                *-- Checa duplicidade de TpOps por envelope
                loc_cSQL = "SELECT DupTpOps FROM SigOpOpt WHERE cods = '" + ALLTRIM(TpOps) + "'"
                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_LocalOpt")

                IF loc_nResult > 0 AND !EOF("cursor_4c_LocalOpt")
                    IF cursor_4c_LocalOpt.DupTpOps = 1 AND Nenvs <> 0
                        LOCAL loc_cKeyEmpDn
                        loc_cKeyEmpDn = ALLTRIM(loc_cEmps) + ALLTRIM(loc_cDopps) + STR(loc_nNumps, 10)

                        loc_cSQL = "SELECT a.Nenvs, a.TpOps FROM SigCdNei a, SigCdNec b " + ;
                                   "WHERE a.Nenvs = " + TRANSFORM(Nenvs) + " " + ;
                                   "AND a.TpOps = '" + ALLTRIM(TpOps) + "' " + ;
                                   "AND a.EmpDnPs = b.EmpDnPs " + ;
                                   "AND b.GrupoOs = '" + ALLTRIM(loc_cGrupoOs) + "' " + ;
                                   "AND a.EmpDnPs <> '" + loc_cKeyEmpDn + "'"

                        loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_DupNensi")
                        IF loc_nResult > 0 AND RECCOUNT("cursor_4c_DupNensi") > 0
                            loc_lDupTpO = .T.
                            IF USED("cursor_4c_DupNensi")
                                USE IN cursor_4c_DupNensi
                            ENDIF
                            IF USED("cursor_4c_LocalOpt")
                                USE IN cursor_4c_LocalOpt
                            ENDIF
                            SELECT xNensi
                            EXIT
                        ENDIF
                        IF USED("cursor_4c_DupNensi")
                            USE IN cursor_4c_DupNensi
                        ENDIF
                    ENDIF
                ENDIF
                IF USED("cursor_4c_LocalOpt")
                    USE IN cursor_4c_LocalOpt
                ENDIF

                SELECT xNensi

                *-- Checa Cor e Tamanho obrigatorios
                IF !EMPTY(Cmats)
                    loc_cSQL = "SELECT b.Cores, b.Tams FROM SigCdPro a, SigCdGrp b " + ;
                               "WHERE a.Cpros = '" + ALLTRIM(Cmats) + "' AND a.Cgrus = b.Cgrus"
                    loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_CrTmpGru")

                    IF loc_nResult > 0 AND !EOF("cursor_4c_CrTmpGru")
                        IF cursor_4c_CrTmpGru.Cores = 1 AND EMPTY(CodCors)
                            loc_lChkCor = .T.
                            IF USED("cursor_4c_CrTmpGru")
                                USE IN cursor_4c_CrTmpGru
                            ENDIF
                            SELECT xNensi
                            EXIT
                        ENDIF
                        IF cursor_4c_CrTmpGru.Tams = 1 AND EMPTY(CodTams)
                            loc_lChkTam = .T.
                        ENDIF
                    ENDIF
                    IF USED("cursor_4c_CrTmpGru")
                        USE IN cursor_4c_CrTmpGru
                    ENDIF
                ENDIF

                SELECT xNensi

                *-- Checa quantidade quando QtdNegs=3
                IF !EMPTY(CMats) AND (Qtds <= 0) AND (loc_nQtdNegs = 3)
                    loc_cMensagem = "Existem Lan" + CHR(231) + "amentos Sem Quantidade e Essa" + CHR(13) + ;
                                    "Movimenta" + CHR(231) + CHR(227) + "o Necessita Que Seja Informada!"
                    EXIT
                ENDIF
            ENDSCAN

            IF EMPTY(loc_cMensagem)
                DO CASE
                    CASE loc_lDispNensi
                        loc_cMensagem = "Existem Lan" + CHR(231) + "amentos Sem Tipo de Material!!!"
                    CASE loc_lChkCor
                        loc_cMensagem = "Existem Lan" + CHR(231) + "amentos Sem Cor!!!"
                    CASE loc_lChkTam
                        loc_cMensagem = "Existem Lan" + CHR(231) + "amentos Sem Tamanho!!!"
                    CASE loc_lDupTpO
                        loc_cMensagem = "Tipo de Material j" + CHR(225) + " Lan" + CHR(231) + "ado para este Envelope!!!"
                ENDCASE
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao validar grade")
        ENDTRY

        RETURN loc_cMensagem
    ENDPROC

    *==========================================================================
    * ValidarInfoEnve - Verifica lancamentos sem envelope obrigatorio
    * par_cAliasOpd:  alias do cursor crSigCdOpd
    * par_lInfoEnve:  flag se OP usa envelope obrigatorio
    * Retorna .T. se ha lancamento sem envelope (erro)
    *==========================================================================
    PROCEDURE ValidarInfoEnve(par_cAliasOpd, par_lInfoEnve)
        LOCAL loc_lDispEnve, loc_nSepPedras

        loc_lDispEnve = .F.

        TRY
            IF par_lInfoEnve AND USED("xNensi") AND USED(par_cAliasOpd)
                SELECT (par_cAliasOpd)
                loc_nSepPedras = SepPedras

                SELECT xNensi
                SCAN
                    IF EMPTY(Nenvs) AND (Rateio = 5 OR (Rateio = 1 AND FlagIncs)) AND loc_nSepPedras <> 4
                        loc_lDispEnve = .T.
                        EXIT
                    ENDIF
                ENDSCAN
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao validar envelope")
        ENDTRY

        RETURN loc_lDispEnve
    ENDPROC

    *==========================================================================
    * DesmembraComposicao - Desmembra produto semiacabado em componentes
    * Replica logica do PROCEDURE desmembrac do legado (SIGPDMP2)
    * par_cAliasOpd:   alias do cursor crSigCdOpd
    * par_nCtrlAgrega: valor corrente de CtrlAgrega no form
    * Retorna novo valor de CtrlAgrega se sucesso, ou -1 se erro
    *==========================================================================
    PROCEDURE DesmembraComposicao(par_cAliasOpd, par_nCtrlAgrega)
        LOCAL loc_nNovoCtrlAgrega, loc_nResult, loc_cSQL
        LOCAL loc_cMat, loc_nOp, loc_cTpOp, loc_nLote
        LOCAL loc_nQtdAnt, loc_nPesoAnt, loc_nAmarraAnt, loc_nReg
        LOCAL loc_nAmarraX, loc_nPesoTot, loc_nQtde

        loc_nNovoCtrlAgrega = -1

        TRY
            IF !USED("xNensi") OR !USED("xMFas")
                loc_lResultado = loc_nNovoCtrlAgrega
            ENDIF

            SELECT xNensi
            loc_nReg       = RECNO()
            loc_cMat       = ALLTRIM(xNensi.CMats)
            loc_nOp        = xNensi.Nenvs
            loc_cTpOp      = ALLTRIM(xNensi.TpOPs)
            loc_nLote      = xNensi.nLotes
            loc_nQtdAnt    = xNensi.Qtds
            loc_nPesoAnt   = xNensi.Pesos
            loc_nAmarraAnt = xNensi.Amarracao

            *-- Remove agregados anteriores se havia amarracao
            IF loc_nAmarraAnt <> 0
                SET ORDER TO
                GO TOP
                DELETE ALL FOR FlagIncs AND Amarracao = loc_nAmarraAnt AND CMats <> loc_cMat
                SET ORDER TO Editar
                GO loc_nReg
            ENDIF

            *-- Busca quantidade de pecas na OP em xMFas
            SELECT xMFas
            GO TOP
            LOCATE FOR Nops = loc_nOp
            IF EOF()
                loc_lResultado = loc_nNovoCtrlAgrega
            ENDIF
            loc_nQtde = xMFas.Qtds

            *-- Incrementa amarracao
            loc_nNovoCtrlAgrega = par_nCtrlAgrega + 1
            loc_nAmarraX        = loc_nNovoCtrlAgrega

            *-- Carrega composicao do material semiacabado via SQL
            loc_cSQL = "SELECT a.Mats, a.DCompos, a.Qtds, a.UniCompos, a.Pesos, a.CuniPs, " + ;
                       "b.Cgrus, b.Varias, c.TpMovs, a.Pesos AS Peso2s " + ;
                       "FROM SigPrCpo a " + ;
                       "INNER JOIN SigCdPro b ON a.Mats = b.Cpros " + ;
                       "INNER JOIN SigCdGrp c ON a.Cgrus = c.Cgrus " + ;
                       "WHERE a.Cpros = " + EscaparSQL(loc_cMat)

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_TmpPrCpo")
            IF loc_nResult < 1
                MsgErro("Falha na Conex" + CHR(227) + "o (crTmpPrCpo)", "Erro")
                loc_nNovoCtrlAgrega = -1
                loc_lResultado = loc_nNovoCtrlAgrega
            ENDIF

            *-- Calcula pesos totais dos componentes de peso fixo
            loc_nPesoTot = 0

            SELECT cursor_4c_TmpPrCpo
            SCAN
                LOCAL loc_nFator1, loc_nFator2, loc_nQtdCmp, loc_nPesoCmp

                loc_nFator1 = 1
                loc_nFator2 = 1

                IF !EMPTY(ALLTRIM(UniCompoS))
                    loc_cSQL = "SELECT Fators FROM SigCdUni WHERE CUnis = '" + ALLTRIM(UniCompoS) + "'"
                    IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_LUni") > 0 AND !EOF("cursor_4c_LUni")
                        loc_nFator1 = NVL(cursor_4c_LUni.Fators, 1)
                    ENDIF
                    IF USED("cursor_4c_LUni")
                        USE IN cursor_4c_LUni
                    ENDIF
                ENDIF

                IF !EMPTY(ALLTRIM(CUniPs))
                    loc_cSQL = "SELECT Fators FROM SigCdUni WHERE CUnis = '" + ALLTRIM(CUniPs) + "'"
                    IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_LUni2") > 0 AND !EOF("cursor_4c_LUni2")
                        loc_nFator2 = NVL(cursor_4c_LUni2.Fators, 1)
                    ENDIF
                    IF USED("cursor_4c_LUni2")
                        USE IN cursor_4c_LUni2
                    ENDIF
                ENDIF

                SELECT cursor_4c_TmpPrCpo

                IF Varias <> 1
                    loc_nQtdCmp  = loc_nQtde * Qtds
                    loc_nPesoCmp = loc_nQtde * Pesos

                    REPLACE Qtds WITH loc_nQtdCmp, Peso2s WITH loc_nPesoCmp IN cursor_4c_TmpPrCpo

                    IF TpMovs <> 1
                        IF loc_nFator1 <> 1
                            LOCAL loc_nPesoCalc
                            loc_nPesoCalc = loc_nQtdCmp * loc_nFator1
                            REPLACE Pesos WITH loc_nPesoCalc IN cursor_4c_TmpPrCpo
                            loc_nPesoTot  = loc_nPesoTot + loc_nPesoCalc
                        ELSE
                            IF loc_nFator2 <> 1 AND !EMPTY(ALLTRIM(CUniPs))
                                LOCAL loc_nPesoCalc2
                                loc_nPesoCalc2 = loc_nPesoCmp * loc_nFator2
                                REPLACE Pesos WITH loc_nPesoCalc2 IN cursor_4c_TmpPrCpo
                                loc_nPesoTot   = loc_nPesoTot + loc_nPesoCalc2
                            ENDIF
                        ENDIF
                    ENDIF
                ENDIF
            ENDSCAN

            *-- Lanca componentes de peso fixo na grade
            SELECT cursor_4c_TmpPrCpo
            SCAN
                IF Varias <> 1
                    *-- Grade principal (Rateio=1, Visivel=.T.)
                    INSERT INTO xNensi (CMats, Cunis, CDescs, CGrus, Nops, Rateio, FlagIncs, Nenvs, ;
                                        Qtds, Pesos, TpOps, nLotes, Peso2s, CodCors, CodTams, cUniPs, ;
                                        QtFaseAnt, Ps2FaseAnt, PsFaseAnt, Amarracao, Visivel, NChkSep, CarCompos) ;
                                VALUES (Mats, UniCompos, DCompos, CGrus, loc_nOp, 1, .T., loc_nOp, ;
                                        Qtds, Pesos, loc_cTpOp, loc_nLote, Peso2s, [], [], CUniPs, ;
                                        Qtds, Peso2s, Pesos, loc_nAmarraX, .T., .T., .T.)

                    *-- Grade de material agregado (Rateio=3, Visivel=.F.)
                    INSERT INTO xNensi (CMats, Cunis, CDescs, CGrus, Nops, Rateio, FlagIncs, Nenvs, ;
                                        Qtds, Pesos, TpOps, nLotes, Peso2s, CodCors, CodTams, cUniPs, ;
                                        QtFaseAnt, Ps2FaseAnt, PsFaseAnt, Amarracao, Visivel) ;
                                VALUES (Mats, UniCompos, DCompos, CGrus, loc_nOp, 3, .T., loc_nOp, ;
                                        Qtds, Pesos, loc_cTpOp, loc_nLote, Peso2s, [], [], CUniPs, ;
                                        Qtds, Peso2s, Pesos, loc_nAmarraX, .F.)
                ENDIF
            ENDSCAN

            IF USED("cursor_4c_TmpPrCpo")
                USE IN cursor_4c_TmpPrCpo
            ENDIF

            *-- Busca e lanca o material principal do semiacabado na grade
            loc_cSQL = "SELECT b.Cpros, b.DPros, b.Cgrus, b.Cunis, b.CuniPs " + ;
                       "FROM SigCdPro a " + ;
                       "INNER JOIN SigCdPro b ON a.MatPrincs = b.Cpros " + ;
                       "WHERE a.Cpros = " + EscaparSQL(loc_cMat)
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_TmpPro")

            IF loc_nResult > 0 AND !EOF("cursor_4c_TmpPro")
                INSERT INTO xNensi (CMats, Cunis, CDescs, CGrus, Nops, Rateio, FlagIncs, Nenvs, ;
                                    Qtds, Pesos, TpOps, nLotes, Peso2s, CodCors, CodTams, cUniPs, ;
                                    QtFaseAnt, Ps2FaseAnt, PsFaseAnt, Amarracao, Visivel, NChkSep, CarCompos) ;
                             VALUES (cursor_4c_TmpPro.Cpros, cursor_4c_TmpPro.Cunis, ;
                                     cursor_4c_TmpPro.DPros, cursor_4c_TmpPro.Cgrus, ;
                                     loc_nOp, 1, .T., loc_nOp, ;
                                     loc_nQtdAnt - loc_nPesoTot, loc_nPesoAnt - loc_nPesoTot, ;
                                     loc_cTpOp, loc_nLote, 0, [], [], cursor_4c_TmpPro.CuniPs, ;
                                     loc_nQtdAnt - loc_nPesoTot, 0, loc_nPesoAnt - loc_nPesoTot, ;
                                     loc_nAmarraX, .T., .T., .T.)

                *-- Copia para grade de agregados (Rateio=3, Visivel=.F.)
                SELECT xNensi
                GO BOTTOM
                SCATTER MEMO MEMVAR
                m.Visivel  = .F.
                m.NChkSep  = .F.
                m.Rateio   = 3
                INSERT INTO xNensi FROM MEMVAR
            ENDIF

            IF USED("cursor_4c_TmpPro")
                USE IN cursor_4c_TmpPro
            ENDIF

            *-- Amarra o semiacabado original com os componentes
            SELECT xNensi
            GO loc_nReg
            REPLACE Amarracao WITH loc_nAmarraX, CarCompos WITH .T.

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao desmembrar composi" + CHR(231) + CHR(227) + "o")
            loc_nNovoCtrlAgrega = -1
        ENDTRY

        RETURN loc_nNovoCtrlAgrega
    ENDPROC

    *==========================================================================
    * ProcessarPerdaPeso - Gerencia navegacao e insercao apos edicao de peso
    * Replica logica do PROCEDURE lostpeso do legado (SIGPDMP2)
    * par_cAliasTmpNens: alias do cursor TmpNens
    * par_cAliasOpd:     alias do cursor crSigCdOpd
    * par_lInfoLote:     flag se OP usa controle de lote
    * par_lInserirAuto:  valor do Chk_InserirAuto
    * par_lRepeteMat:    valor do Chk_RepeteMat
    * par_cObsAnterior:  TpOps da linha anterior (ObsAnterior)
    * Retorna .T. se processou com sucesso
    *==========================================================================
    PROCEDURE ProcessarPerdaPeso(par_cAliasTmpNens, par_cAliasOpd, par_lInfoLote, ;
                                  par_lInserirAuto, par_lRepeteMat, par_cObsAnterior)
        LOCAL loc_lSucesso, loc_cSQL
        LOCAL loc_cMats, loc_cTpOps, loc_nNops, loc_nNenv, loc_nRecno

        loc_lSucesso = .F.

        TRY
            IF !USED("xNensi") OR !USED(par_cAliasTmpNens) OR !USED(par_cAliasOpd)
                loc_lSucesso = loc_lSucesso
            ENDIF

            IF par_lInfoLote
                loc_lSucesso = .T.
                loc_lSucesso = loc_lSucesso
            ENDIF

            SELECT (par_cAliasOpd)
            LOCAL loc_nPesoFixs, loc_cMatPads
            loc_nPesoFixs = PesoFixs
            loc_cMatPads  = MatPads

            SELECT xNensi

            *-- Se PesoFixs=2 e material principal definido, insere linha do mat principal
            IF (loc_nPesoFixs = 2) AND !FlagIncs AND !EMPTY(ALLTRIM(MatPrincs))
                loc_cMats  = ALLTRIM(MatPrincs)
                loc_cTpOps = ALLTRIM(TpOps)
                loc_nNops  = Nops
                loc_nNenv  = Nenvs
                loc_nRecno = RECNO()

                loc_cSQL = "SELECT CUnis, DPros, CGrus FROM SigCdPro WHERE Cpros = " + EscaparSQL(loc_cMats)
                IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_LocalPro") > 0 AND !EOF("cursor_4c_LocalPro")
                    SELECT xNensi
                    SET ORDER TO NopCMat
                    IF !SEEK(STR(loc_nNops, 10) + loc_cMats)
                        INSERT INTO xNensi (CMats, Cunis, CDescs, CGrus, Nops, Rateio, FlagIncs, Nenvs, ;
                                            Qtds, Pesos, TpOps) ;
                                     VALUES (loc_cMats, cursor_4c_LocalPro.Cunis, ;
                                             cursor_4c_LocalPro.DPros, cursor_4c_LocalPro.CGrus, ;
                                             loc_nNops, 2, .F., loc_nNenv, 0, 0, loc_cTpOps)
                    ENDIF
                ENDIF
                IF USED("cursor_4c_LocalPro")
                    USE IN cursor_4c_LocalPro
                ENDIF

                SELECT xNensi
                SET ORDER TO Editar
                GO loc_nRecno
            ENDIF

            *-- Avanca para proxima linha; se EOF e InserirAuto, insere nova
            SELECT xNensi
            IF !EOF()
                SKIP
            ENDIF

            IF EOF()
                IF par_lInserirAuto
                    SELECT (par_cAliasTmpNens)
                    LOCAL loc_cEmpsAI, loc_cDoppsAI, loc_nNumpsAI
                    loc_cEmpsAI  = Emps
                    loc_cDoppsAI = Dopps
                    loc_nNumpsAI = Numps

                    SELECT (par_cAliasOpd)
                    LOCAL loc_cTpPadraosAI
                    loc_cTpPadraosAI = TpPadraos

                    SELECT xNensi
                    INSERT INTO xNensi (Emps, Dopps, Numps, Visivel, Rateio, FlagIncs, TpOps, NChkSep) ;
                                 VALUES (loc_cEmpsAI, loc_cDoppsAI, loc_nNumpsAI, .T., 5, .T., ;
                                         loc_cTpPadraosAI, .T.)
                    SET ORDER TO Editar
                    GO BOTTOM

                    *-- Preenche CMats com material padrao se linha em branco
                    IF EMPTY(ALLTRIM(CMats)) AND EMPTY(ALLTRIM(NVL(TRANSFORM(Nops), "")))
                        LOCAL loc_cMatPad
                        loc_cMatPad = IIF(EMPTY(ALLTRIM(loc_cMatPads)), "", ALLTRIM(loc_cMatPads))
                        IF !EMPTY(loc_cMatPad)
                            REPLACE CMats WITH loc_cMatPad
                        ENDIF
                    ENDIF

                    IF par_lRepeteMat AND !EMPTY(ALLTRIM(par_cObsAnterior))
                        REPLACE TpOps WITH par_cObsAnterior
                    ENDIF
                ENDIF
            ENDIF

            loc_lSucesso = .T.

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao processar perda de peso")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * BuscarLotes - Carrega lotes em aberto do funcionario (cmdLotes.Click)
    * par_cGrupoOs: GrupoOs do TmpNens
    * par_cContaOs: ContaOs do TmpNens
    * Cursor resultado: cursor_4c_Lotes (nLotes N, CMats C, Saldo N)
    * Retorna .T. se carregou com sucesso
    *==========================================================================
    PROCEDURE BuscarLotes(par_cGrupoOs, par_cContaOs)
        LOCAL loc_lSucesso, loc_nResult, loc_cSQL, loc_nLote

        loc_lSucesso = .F.

        TRY
            IF USED("cursor_4c_Lotes")
                USE IN cursor_4c_Lotes
            ENDIF

            *-- Busca lotes nao encerrados (chksubn = 0/false)
            loc_cSQL = "SELECT nLotes FROM SigPdNlt " + ;
                       "WHERE chksubn = 0 " + ;
                       "AND Grupos = '" + ALLTRIM(par_cGrupoOs) + "' " + ;
                       "AND Contas = '" + ALLTRIM(par_cContaOs) + "' " + ;
                       "ORDER BY nlotes"

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_LocalNlt")
            IF loc_nResult < 1
                MsgErro("Falha na Conex" + CHR(227) + "o (Localnlt)", "Erro")
                loc_lSucesso = loc_lSucesso
            ENDIF

            SET NULL ON
            CREATE CURSOR cursor_4c_Lotes (nLotes N(10,0) NULL, CMats C(14) NULL, Saldo N(12,3) NULL)
            SET NULL OFF

            SELECT cursor_4c_LocalNlt
            SCAN
                loc_nLote = cursor_4c_LocalNlt.nLotes
                SELECT cursor_4c_Lotes
                INSERT INTO cursor_4c_Lotes (nLotes, CMats, Saldo) ;
                                     VALUES (loc_nLote, "", 0)
            ENDSCAN

            IF USED("cursor_4c_LocalNlt")
                USE IN cursor_4c_LocalNlt
            ENDIF

            loc_lSucesso = .T.

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao buscar lotes")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * EncerraPCC - Processa encerramento PCC: agrega materiais com variacao
    * Replica logica do EncerraPCC.Click do legado (SIGPDMP2)
    * par_cAliasOpd: alias do cursor crSigCdOpd
    * par_cOuros:    codigo do material "ouro" / material padrao a excluir
    * Retorna .T. se processou com sucesso
    *==========================================================================
    PROCEDURE EncerraPCC(par_cAliasOpd, par_cOuros)
        LOCAL loc_lSucesso, loc_nResult, loc_cSQL, loc_cMatAtual

        loc_lSucesso = .F.

        TRY
            IF !USED("xNensi")
                loc_lSucesso = loc_lSucesso
            ENDIF

            SET NULL ON
            CREATE CURSOR cursor_4c_TmpX (CMats C(14) NULL, Qtds N(12,3) NULL, Pesos N(12,3) NULL)
            SET NULL OFF

            INDEX ON CMats TAG CMats

            *-- Acumula totais por material com variacao
            SELECT xNensi
            SET ORDER TO
            SCAN
                IF EMPTY(ALLTRIM(CMats)) OR ALLTRIM(CMats) = ALLTRIM(par_cOuros)
                    LOOP
                ENDIF

                loc_cSQL = "SELECT Varias FROM SigCdPro WHERE Cpros = '" + ALLTRIM(CMats) + "'"
                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_LocalProPCC")

                IF loc_nResult > 0 AND !EOF("cursor_4c_LocalProPCC")
                    IF cursor_4c_LocalProPCC.Varias <> 1
                        IF USED("cursor_4c_LocalProPCC")
                            USE IN cursor_4c_LocalProPCC
                        ENDIF
                        LOOP
                    ENDIF
                ENDIF
                IF USED("cursor_4c_LocalProPCC")
                    USE IN cursor_4c_LocalProPCC
                ENDIF

                SELECT xNensi
                loc_cMatAtual = ALLTRIM(CMats)

                SELECT cursor_4c_TmpX
                IF !SEEK(loc_cMatAtual)
                    INSERT INTO cursor_4c_TmpX (CMats, Qtds, Pesos) VALUES (loc_cMatAtual, 0, 0)
                    SEEK loc_cMatAtual
                ENDIF
                REPLACE Qtds  WITH NVL(Qtds,  0) + xNensi.QtFaseAnt, ;
                        Pesos WITH NVL(Pesos, 0) + xNensi.PsFaseAnt
                SELECT xNensi
            ENDSCAN

            *-- Insere linhas para cada material com saldo > 0
            SELECT cursor_4c_TmpX
            SCAN
                IF NVL(Qtds, 0) = 0
                    LOOP
                ENDIF

                LOCAL loc_nQtdX, loc_nPesoX
                loc_cMatAtual = ALLTRIM(CMats)
                loc_nQtdX     = NVL(Qtds, 0)
                loc_nPesoX    = NVL(Pesos, 0)

                loc_cSQL = "SELECT Cpros, DPros, Cgrus, Cunis, CuniPs FROM SigCdPro " + ;
                           "WHERE Cpros = " + EscaparSQL(loc_cMatAtual)
                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ProPCC")

                IF loc_nResult > 0 AND !EOF("cursor_4c_ProPCC")
                    INSERT INTO xNensi (CMats, Cunis, CDescs, CGrus, Nops, Rateio, FlagIncs, Nenvs, ;
                                        Qtds, Pesos, TpOps, nLotes, Visivel, NChkSep) ;
                                 VALUES (cursor_4c_ProPCC.Cpros, cursor_4c_ProPCC.Cunis, ;
                                         cursor_4c_ProPCC.DPros,  cursor_4c_ProPCC.Cgrus, ;
                                         0, 5, .T., 0, loc_nQtdX, loc_nPesoX, ;
                                         SPACE(4), 0, .T., .T.)
                ENDIF
                IF USED("cursor_4c_ProPCC")
                    USE IN cursor_4c_ProPCC
                ENDIF
            ENDSCAN

            IF USED("cursor_4c_TmpX")
                USE IN cursor_4c_TmpX
            ENDIF

            loc_lSucesso = .T.

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao encerrar PCC")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

ENDDEFINE

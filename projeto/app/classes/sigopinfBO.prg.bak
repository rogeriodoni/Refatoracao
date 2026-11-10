*====================================================================
* sigopinfBO.prg
*
* Business Object para o dialogo "Informacoes Gerais" (SIGOPINF)
* Entidade base: SigMvCab (cabecalho do movimento/operacao)
* Herda de: BusinessBase
*
* NOTA: SIGOPINF e um dialogo FILHO, aberto pelo form de cabecalho da
* operacao (ParentForm) e que edita um SUBCONJUNTO de colunas do cursor
* TprMvCab (cursor de trabalho do pai, equivalente a SigMvCab). Este BO
* nao persiste diretamente em SigMvCab - quem grava o cabecalho e o
* form pai, quando a operacao principal e salva (os controles desta
* tela ja escrevem direto em TprMvCab via ControlSource).
*
* O UNICO caminho de gravacao direta no legado (SIGOPINF.cntBotoes.Click,
* ramo Else) acontece em modo CONSULTAR, quando o usuario tem acesso
* ALTINFO liberado: um UPDATE pontual da coluna Obses, pela chave
* CidChaves. E esse caminho que Atualizar() reproduz aqui.
*
* Nomes de coluna confirmados em docs/schema.sql (UTF-16) e no dump
* SIGOPINF.ControlSource (tasks/task751/sigopinf_form_codigo_fonte.txt):
*   cntVolumes.getQtds      -> Qtdes       (numeric)
*   cntVolumes.getEspes     -> Espes       (char)
*   cntVolumes.getPLiqs     -> PLiqs       (numeric)
*   cntVolumes.getPBrus     -> PBrus       (numeric)
*   cntVolumes.getValTrans  -> ValTrans    (numeric)
*   cntObservacao.getCodObs -> CodObs      (numeric)
*   cntObservacao.getDesObs -> Obses       (text/memo)
*   CntObs2.btnMultObs      -> CodObs2     (char)
*   cntProtocolo.getProtocolos -> Protats  (numeric)
*   cntEntrega.getContas    -> ContaEs     (char)
*   cntCodigos.getCodigos   -> MascNum     (char)
*   cntDocumentos.getDocumentos -> Notas   (char)
*   cntDocumentos.GetNumeroNota -> NumeroNota (char)
*   cntEcfs.getEcfs         -> Ecfs        (char)
*   cntNemps.getNemps       -> Nemps       (char)
*   cntEmiss.getEmiss       -> DtEmis      (datetime)
*   cntEntregas.getEntregas -> PrazoEnts   (datetime)
*   cntRecepcaos.getRecepcaos -> DtRecs    (datetime)
*   cntPrzEnts.getPrzEnts   -> PrzClis     (datetime)
*   cntPedido.getPedido     -> nPedClis    (numeric)
*   cntLivre.getNLivDg      -> NLivDg      (numeric)
*====================================================================

DEFINE CLASS sigopinfBO AS BusinessBase

    *-- Identificacao do movimento (TprMvCab - chave posicional)
    this_cEmps        = ""    && TprMvCab.Emps char(3) - empresa
    this_cDopes       = ""    && TprMvCab.Dopes char(20) - tipo de documento/operacao
    this_nNumes       = 0     && TprMvCab.Numes numeric - numero do documento
    this_cEmpDopNums  = ""    && TprMvCab.EmpDopNums char(29) - chave posicional (Emps + Dopes + Str(Numes,6))
    this_cCidChaves   = ""    && TprMvCab.CidChaves char - chave do registro, usada no UPDATE pontual de Obses (modo CONSULTAR + acesso ALTINFO)

    *-- Datas (containers cntEmiss/cntEntregas/cntPrzEnts/cntRecepcaos)
    this_dDatas       = {}    && TprMvCab.Datas - data do movimento (usada em validacoes de prazo; nao editavel nesta tela)
    this_dDtEmis      = {}    && TprMvCab.DtEmis - data de emissao do documento
    this_dPrazoEnts   = {}    && TprMvCab.PrazoEnts - prazo de entrega
    this_dPrzClis     = {}    && TprMvCab.PrzClis - data prometida ao cliente
    this_dRecepcaos   = {}    && TprMvCab.DtRecs - data de recepcao

    *-- Contas (container cntEntrega - conta/nome/cpf-cnpj da entrega)
    this_cContaDs     = ""    && TprMvCab.ContaDs - conta (duplicata)
    this_cContaOs     = ""    && TprMvCab.ContaOs - conta (ordem de servico)
    this_cContaEs     = ""    && TprMvCab.ContaEs - conta de entrega
    this_cDescContaEs = ""    && Nome/razao social da conta de entrega (consulta auxiliar SigCdCli - NAO persistido em TprMvCab)
    this_cCpfContaEs  = ""    && CPF/CNPJ da conta de entrega (consulta auxiliar SigCdCli - NAO persistido em TprMvCab)

    *-- Observacoes (container cntObservacao/CntObs2)
    this_nCodObs      = 0     && TprMvCab.CodObs - codigo da observacao (crSigCdObs.Codigos)
    this_cObses       = ""    && TprMvCab.Obses - texto da observacao (memo)
    this_cCodObs2     = ""    && TprMvCab.CodObs2 - codigos de observacoes de finalidade (lista concatenada)

    *-- Entrega/protocolo/documentos
    this_nLocalEnts   = 0     && TprMvCab.LocalEnts numeric - codigo do endereco alternativo de entrega (SigCdCee.Codigos)
    this_nProtocolos  = 0     && TprMvCab.Protats numeric - protocolo
    this_cCodigos     = ""    && TprMvCab.MascNum - mascara/codigo de referencia da tela (cntCodigos)
    this_cDocumentos  = ""    && TprMvCab.Notas - numero do documento
    this_cNumeroNota  = ""    && TprMvCab.NumeroNota - numero da nota fiscal
    this_cEcfs        = ""    && TprMvCab.Ecfs - identificacao do ECF
    this_cNemps       = ""    && TprMvCab.Nemps - numero de serie da impressora fiscal (criptografado)
    this_nPedido      = 0     && TprMvCab.nPedClis numeric - numero do pedido
    this_nNLivDg      = 0     && TprMvCab.NLivDg numeric - numero do lacre

    *-- Volumes/transporte (container cntVolumes)
    this_nQtds        = 0     && TprMvCab.Qtdes - quantidade de volumes
    this_cEspes       = ""    && TprMvCab.Espes - especie do volume
    this_nPLiqs       = 0     && TprMvCab.PLiqs - peso liquido
    this_nPBrus       = 0     && TprMvCab.PBrus - peso bruto
    this_nValTrans    = 0     && TprMvCab.ValTrans - valor do transporte

    *====================================================================
    * Init - Inicializa Business Object
    *====================================================================
    PROCEDURE Init()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            DODEFAULT()
            THIS.this_cTabela     = "SigMvCab"
            THIS.this_cCampoChave = "CidChaves"
            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * ObterChavePrimaria - chave do registro corrente (TprMvCab.CidChaves)
    * Usada por RegistrarAuditoria() apos o UPDATE pontual de Obses.
    *====================================================================
    PROTECTED PROCEDURE ObterChavePrimaria()
        RETURN THIS.this_cCidChaves
    ENDPROC

    *====================================================================
    * CarregarDoCursor - Carrega as propriedades do BO a partir do cursor
    * de trabalho do form pai (TprMvCab). Cada campo e lido sob guarda de
    * TYPE() porque o alias recebido pode trazer so um subconjunto das
    * colunas (ex.: cursor de teste automatizado).
    *====================================================================
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lResultado
        loc_lResultado = .F.
        TRY
            IF USED(par_cAliasCursor)
                SELECT (par_cAliasCursor)

                *-- Identificacao do movimento
                IF TYPE("Emps") != "U"
                    THIS.this_cEmps = TratarNulo(Emps, "C")
                ENDIF
                IF TYPE("Dopes") != "U"
                    THIS.this_cDopes = TratarNulo(Dopes, "C")
                ENDIF
                IF TYPE("Numes") != "U"
                    THIS.this_nNumes = TratarNulo(Numes, "N")
                ENDIF
                IF TYPE("EmpDopNums") != "U"
                    THIS.this_cEmpDopNums = TratarNulo(EmpDopNums, "C")
                ENDIF
                IF TYPE("CidChaves") != "U"
                    THIS.this_cCidChaves = TratarNulo(CidChaves, "C")
                ENDIF

                *-- Datas
                IF TYPE("Datas") != "U"
                    THIS.this_dDatas = TratarNulo(Datas, "D")
                ENDIF
                IF TYPE("DtEmis") != "U"
                    THIS.this_dDtEmis = TratarNulo(DtEmis, "D")
                ENDIF
                IF TYPE("PrazoEnts") != "U"
                    THIS.this_dPrazoEnts = TratarNulo(PrazoEnts, "D")
                ENDIF
                IF TYPE("PrzClis") != "U"
                    THIS.this_dPrzClis = TratarNulo(PrzClis, "D")
                ENDIF
                IF TYPE("DtRecs") != "U"
                    THIS.this_dRecepcaos = TratarNulo(DtRecs, "D")
                ENDIF

                *-- Contas
                IF TYPE("ContaDs") != "U"
                    THIS.this_cContaDs = TratarNulo(ContaDs, "C")
                ENDIF
                IF TYPE("ContaOs") != "U"
                    THIS.this_cContaOs = TratarNulo(ContaOs, "C")
                ENDIF
                IF TYPE("ContaEs") != "U"
                    THIS.this_cContaEs = TratarNulo(ContaEs, "C")
                ENDIF

                *-- Observacoes
                IF TYPE("CodObs") != "U"
                    THIS.this_nCodObs = TratarNulo(CodObs, "N")
                ENDIF
                IF TYPE("Obses") != "U"
                    THIS.this_cObses = TratarNulo(Obses, "C")
                ENDIF
                IF TYPE("CodObs2") != "U"
                    THIS.this_cCodObs2 = TratarNulo(CodObs2, "C")
                ENDIF

                *-- Entrega/protocolo/documentos
                IF TYPE("LocalEnts") != "U"
                    THIS.this_nLocalEnts = TratarNulo(LocalEnts, "N")
                ENDIF
                IF TYPE("Protats") != "U"
                    THIS.this_nProtocolos = TratarNulo(Protats, "N")
                ENDIF
                IF TYPE("MascNum") != "U"
                    THIS.this_cCodigos = TratarNulo(MascNum, "C")
                ENDIF
                IF TYPE("Notas") != "U"
                    THIS.this_cDocumentos = TratarNulo(Notas, "C")
                ENDIF
                IF TYPE("NumeroNota") != "U"
                    THIS.this_cNumeroNota = TratarNulo(NumeroNota, "C")
                ENDIF
                IF TYPE("Ecfs") != "U"
                    THIS.this_cEcfs = TratarNulo(Ecfs, "C")
                ENDIF
                IF TYPE("Nemps") != "U"
                    THIS.this_cNemps = TratarNulo(Nemps, "C")
                ENDIF
                IF TYPE("nPedClis") != "U"
                    THIS.this_nPedido = TratarNulo(nPedClis, "N")
                ENDIF
                IF TYPE("NLivDg") != "U"
                    THIS.this_nNLivDg = TratarNulo(NLivDg, "N")
                ENDIF

                *-- Volumes/transporte
                IF TYPE("Qtdes") != "U"
                    THIS.this_nQtds = TratarNulo(Qtdes, "N")
                ENDIF
                IF TYPE("Espes") != "U"
                    THIS.this_cEspes = TratarNulo(Espes, "C")
                ENDIF
                IF TYPE("PLiqs") != "U"
                    THIS.this_nPLiqs = TratarNulo(PLiqs, "N")
                ENDIF
                IF TYPE("PBrus") != "U"
                    THIS.this_nPBrus = TratarNulo(PBrus, "N")
                ENDIF
                IF TYPE("ValTrans") != "U"
                    THIS.this_nValTrans = TratarNulo(ValTrans, "N")
                ENDIF

                loc_lResultado = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    *====================================================================
    * Inserir - Nao aplicavel a este dialogo. O cabecalho do movimento
    * (SigMvCab) e criado pelo form PAI (operacao principal) quando a
    * operacao e salva; SIGOPINF so edita colunas do cursor TprMvCab
    * (ja atualizado em memoria pelos proprios controles via
    * ControlSource) e devolve o controle com ThisForm.Return.
    *====================================================================
    PROCEDURE Inserir()
        RETURN .F.
    ENDPROC

    *====================================================================
    * Atualizar - Reproduz o UNICO caminho de gravacao direta do legado
    * (SIGOPINF.cntBotoes.Click, ramo Else): em modo CONSULTAR, com
    * acesso ALTINFO liberado, confirma apenas a observacao (Obses) do
    * cabecalho, pela chave CidChaves. O Form e quem decide, antes de
    * chamar Salvar()/Atualizar(), se o acesso ALTINFO permite a acao -
    * este metodo so executa a gravacao em si.
    *====================================================================
    PROCEDURE Atualizar()
        LOCAL loc_lResultado, loc_cSQL, loc_nResultado
        loc_lResultado = .F.
        TRY
            IF EMPTY(THIS.this_cCidChaves)
                THIS.this_cMensagemErro = "Chave do registro n" + CHR(227) + "o informada."
            ELSE
                loc_cSQL = "UPDATE SigMvCab SET " + ;
                           "Obses = " + EscaparSQL(ALLTRIM(THIS.this_cObses)) + " " + ;
                           "WHERE CidChaves = " + EscaparSQL(THIS.this_cCidChaves)

                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
                IF loc_nResultado < 1
                    THIS.this_cMensagemErro = "Erro ao atualizar a observa" + CHR(231) + CHR(227) + "o do movimento."
                    MsgErro(THIS.this_cMensagemErro, "Erro")
                ELSE
                    THIS.RegistrarAuditoria("A")
                    loc_lResultado = .T.
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

ENDDEFINE

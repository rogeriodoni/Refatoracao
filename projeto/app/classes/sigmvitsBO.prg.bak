*===============================================================================
* sigmvitsBO.prg - Business Object para Caixa (Frente de Loja / PDV)
* Tabela principal: SigMvCab (cabecalho do movimento/cupom em processamento)
* PK tecnica: empdopnums char(29) = Emps + Dopes + Str(Numes,6)
* Origem legado: SIGMVITS ("Caixa"), pagina/container filho do PDV completo
* Tabelas relacionadas usadas pelo legado (fases seguintes): crTpmMvItn (SigMvItn,
* itens do cupom), SigOpFp/SigOpFpi (formas de pagamento), SigFiFis/SigFiMpf
* (config. fiscal da impressora), SigCdCli (identificacao do cliente/conta),
* SigCdOpe (config. da operacao), SigCdPam (parametros gerais do sistema)
*===============================================================================
DEFINE CLASS sigmvitsBO AS BusinessBase

    *-- Identificacao da tabela (BusinessBase)
    this_cTabela     = "SigMvCab"
    this_cCampoChave = "empdopnums"

    *---------------------------------------------------------------------------
    * Propriedades - SigMvCab (cabecalho do movimento/cupom - TprMvCab no legado)
    *---------------------------------------------------------------------------
    this_cEmpdopnums = ""   && empdopnums char(29) NOT NULL - Chave tecnica (Emps+Dopes+Str(Numes,6))
    this_cEmps       = ""   && emps       char(3)  NOT NULL - Empresa
    this_cDopes      = ""   && dopes      char(20) NOT NULL - Codigo da operacao (tipo de movimento)
    this_nNumes      = 0    && numes      numeric(6,0) NOT NULL - Numero do documento/cupom
    this_cEmpds      = ""   && empds      char(3)  NOT NULL - Empresa do documento
    this_cNemps      = ""   && nemps      char(40) NOT NULL - Nome da empresa (grade/historico)
    this_dDatas      = {}   && datas      datetime NULL - Data do movimento
    this_cContads    = ""   && contads    char(10) NOT NULL - Conta destino (cliente)
    this_cContaos    = ""   && contaos    char(10) NOT NULL - Conta origem
    this_cGrupods    = ""   && grupods    char(10) NOT NULL - Grupo destino
    this_cGrupoos    = ""   && grupoos    char(10) NOT NULL - Grupo origem
    this_cResps      = ""   && resps      char(10) NOT NULL - Responsavel/vendedor destino
    this_cGrresps    = ""   && grresps    char(10) NOT NULL - Grupo do responsavel destino
    this_cVends      = ""   && vends      char(10) NOT NULL - Vendedor
    this_cGrvends    = ""   && grvends    char(10) NOT NULL - Grupo do vendedor
    this_cTabds      = ""   && tabds      char(10) NOT NULL - Tabela de desconto
    this_cLprecos    = ""   && lprecos    char(30) NOT NULL - Lista de precos
    this_cMascnum    = ""   && mascnum    char(10) NOT NULL - Mascara de numeracao do documento
    this_nNpedclis   = 0    && npedclis   numeric(11,0) NOT NULL - Numero do pedido do cliente
    this_cTpfats     = ""   && tpfats     char(3)  NOT NULL - Tipo de faturamento
    this_cEcfs       = ""   && ecfs       char(7)  NOT NULL - Numero de serie do ECF
    this_cNcupoms    = ""   && ncupoms    char(6)  NOT NULL - Numero do cupom fiscal
    this_cCodtrans   = ""   && codtrans   char(10) NOT NULL - Codigo da transacao (TEF/cartao)
    this_cMotdscs    = ""   && motdscs    char(10) NOT NULL - Motivo do desconto
    this_cEspes      = ""   && espes      char(10) NOT NULL - Especie (documento/moeda)
    this_cNotas      = ""   && notas      char(6)  NOT NULL - Numero da nota (impressao)
    this_cObses      = ""   && obses      text NULL - Observacoes (memo)
    this_dPrazoents  = {}   && prazoents  datetime NULL - Prazo de entrega
    this_dDtagends   = {}   && dtagends   datetime NULL - Data agendada
    this_nQtdes      = 0    && qtdes      numeric(6,0) NOT NULL - Quantidade de itens do cupom
    this_nPbrus      = 0    && pbrus      numeric(10,3) NULL - Peso bruto
    this_nPliqs      = 0    && pliqs      numeric(10,3) NULL - Peso liquido
    this_nUtilizados = 0    && utilizados numeric(1,0) NOT NULL - Flag de utilizacao
    this_nLocalents  = 0    && localents  numeric(10,0) NOT NULL - Local de entrega
    this_nValos      = 0    && valos      numeric(11,2) NOT NULL - Valor total do documento
    this_nValinis    = 0    && valinis    numeric(11,2) NOT NULL - Valor inicial (bruto dos itens)
    this_nValdevs    = 0    && valdevs    numeric(11,2) NOT NULL - Valor devolvido
    this_nValobxs    = 0    && valobxs    numeric(11,2) NOT NULL - Valor baixado
    this_nValservs   = 0    && valservs   numeric(11,2) NOT NULL - Valor de servicos
    this_nValvars    = 0    && valvars    numeric(11,2) NOT NULL - Valor de variacao (desconto/acrescimo)
    this_nValvarps   = 0    && valvarps   numeric(11,2) NOT NULL - Valor de variacao percentual
    this_nVars       = 0    && vars       numeric(9,4) NOT NULL - Percentual de variacao
    this_lChkpagos   = .F.  && chkpagos   bit NOT NULL - Flag pagamento conferido
    this_lChksubn    = .F.  && chksubn    bit NOT NULL - Flag possui sub-nivel
    this_lLcancelas  = .F.  && lcancelas  bit NOT NULL - Flag documento cancelado

    *---------------------------------------------------------------------------
    * Init - Configurar tabela e chave primaria
    *---------------------------------------------------------------------------
    PROCEDURE Init()
        DODEFAULT()
        THIS.this_cTabela     = "SigMvCab"
        THIS.this_cCampoChave = "empdopnums"
        RETURN .T.
    ENDPROC

    *---------------------------------------------------------------------------
    * ObterChavePrimaria - Para auditoria (BusinessBase override)
    *---------------------------------------------------------------------------
    PROTECTED PROCEDURE ObterChavePrimaria()
        RETURN ALLTRIM(THIS.this_cEmpdopnums)
    ENDPROC

    *---------------------------------------------------------------------------
    * CarregarDoCursor - Carrega do cursor SQL para as propriedades do BO.
    * SEMPRE usa SELECT (par_cAliasCursor) antes de acessar os campos -
    * "campo" e sintaxe invalida em VFP9 (regra #9 CLAUDE.md).
    *---------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF USED(par_cAliasCursor)
                SELECT (par_cAliasCursor)

                THIS.this_cEmpdopnums = TratarNulo(empdopnums, "")
                THIS.this_cEmps       = TratarNulo(emps, "")
                THIS.this_cDopes      = TratarNulo(dopes, "")
                THIS.this_nNumes      = TratarNulo(numes, 0)
                THIS.this_cEmpds      = TratarNulo(empds, "")
                THIS.this_cNemps      = TratarNulo(nemps, "")
                THIS.this_dDatas      = TratarNulo(datas, {})
                THIS.this_cContads    = TratarNulo(contads, "")
                THIS.this_cContaos    = TratarNulo(contaos, "")
                THIS.this_cGrupods    = TratarNulo(grupods, "")
                THIS.this_cGrupoos    = TratarNulo(grupoos, "")
                THIS.this_cResps      = TratarNulo(resps, "")
                THIS.this_cGrresps    = TratarNulo(grresps, "")
                THIS.this_cVends      = TratarNulo(vends, "")
                THIS.this_cGrvends    = TratarNulo(grvends, "")
                THIS.this_cTabds      = TratarNulo(tabds, "")
                THIS.this_cLprecos    = TratarNulo(lprecos, "")
                THIS.this_cMascnum    = TratarNulo(mascnum, "")
                THIS.this_nNpedclis   = TratarNulo(npedclis, 0)
                THIS.this_cTpfats     = TratarNulo(tpfats, "")
                THIS.this_cEcfs       = TratarNulo(ecfs, "")
                THIS.this_cNcupoms    = TratarNulo(ncupoms, "")
                THIS.this_cCodtrans   = TratarNulo(codtrans, "")
                THIS.this_cMotdscs    = TratarNulo(motdscs, "")
                THIS.this_cEspes      = TratarNulo(espes, "")
                THIS.this_cNotas      = TratarNulo(notas, "")
                THIS.this_cObses      = TratarNulo(obses, "")
                THIS.this_dPrazoents  = TratarNulo(prazoents, {})
                THIS.this_dDtagends   = TratarNulo(dtagends, {})
                THIS.this_nQtdes      = TratarNulo(qtdes, 0)
                THIS.this_nPbrus      = TratarNulo(pbrus, 0)
                THIS.this_nPliqs      = TratarNulo(pliqs, 0)
                THIS.this_nUtilizados = TratarNulo(utilizados, 0)
                THIS.this_nLocalents  = TratarNulo(localents, 0)
                THIS.this_nValos      = TratarNulo(valos, 0)
                THIS.this_nValinis    = TratarNulo(valinis, 0)
                THIS.this_nValdevs    = TratarNulo(valdevs, 0)
                THIS.this_nValobxs    = TratarNulo(valobxs, 0)
                THIS.this_nValservs   = TratarNulo(valservs, 0)
                THIS.this_nValvars    = TratarNulo(valvars, 0)
                THIS.this_nValvarps   = TratarNulo(valvarps, 0)
                THIS.this_nVars       = TratarNulo(vars, 0)

                IF VARTYPE(chkpagos) = "L"
                    THIS.this_lChkpagos = chkpagos
                ELSE
                    THIS.this_lChkpagos = (NVL(chkpagos, 0) = 1)
                ENDIF

                IF VARTYPE(chksubn) = "L"
                    THIS.this_lChksubn = chksubn
                ELSE
                    THIS.this_lChksubn = (NVL(chksubn, 0) = 1)
                ENDIF

                IF VARTYPE(lcancelas) = "L"
                    THIS.this_lLcancelas = lcancelas
                ELSE
                    THIS.this_lLcancelas = (NVL(lcancelas, 0) = 1)
                ENDIF

                loc_lSucesso = .T.
            ENDIF
        CATCH TO loException
            MsgErro(loException.Message, "Erro em sigmvitsBO.CarregarDoCursor")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *---------------------------------------------------------------------------
    * Inserir - Insere novo registro em SigMvCab (PROTECTED, chamado por
    * BusinessBase.Salvar() quando this_lNovoRegistro = .T.)
    *
    * SigMvCab tem 158 colunas, quase todas NOT NULL sem DEFAULT (regra #22
    * CLAUDE.md). Este BO so declara propriedade para as colunas que o
    * container "Caixa" (SIGMVITS) de fato le/grava - as demais colunas
    * NOT NULL recebem o default do TIPO (char="", numeric/bit=0) para nao
    * violar a constraint; colunas NULLABLE sem propriedade sao OMITIDAS da
    * lista (o SQL Server preenche NULL sozinho). cidchaves eh a PK real
    * (fUniqueIds()) - NUNCA string vazia, senao a inclusao inteira falha
    * por colisao/violacao da PRIMARY KEY.
    *---------------------------------------------------------------------------
    PROTECTED PROCEDURE Inserir()
        LOCAL loc_cSQL, loc_cCidchaves, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cCidchaves = LEFT(fUniqueIds(), 20)

            *-- Campo computado: Emps + Dopes + Numes (chave de movimentacao)
            THIS.this_cEmpdopnums = PADR(THIS.this_cEmps, 3) + PADR(THIS.this_cDopes, 20) + STR(THIS.this_nNumes, 6)

            *-- Quebrado em multiplas atribuicoes (nao um unico "+;" continuado):
            *-- VFP9 junta linhas continuadas por ";" numa unica LINHA LOGICA
            *-- com limite de 8192 caracteres ("Line is too long" em runtime).
            loc_cSQL = "INSERT INTO SigMvCab ("
            loc_cSQL = loc_cSQL + "npedclis, acres, antecs, chksubn, codpeds, contads, contaos, datas,"
            loc_cSQL = loc_cSQL + "desc2s, descs, devols, dopes, empds, emps, grresps, grupods,"
            loc_cSQL = loc_cSQL + "grupoos, grupos, grvends, iclis, ifors, locals, lotechqs, lprecos,"
            loc_cSQL = loc_cSQL + "mascnum, ncarnecs, nemps, nops, notas, nrcons, ntrans, numes,"
            loc_cSQL = loc_cSQL + "numolds, obses, opers, prazoents, resps, tabds, tpfats, transps,"
            loc_cSQL = loc_cSQL + "usuals, usuars, usulibs, valacres, valdes2s, valdescs, valdevs, valencs,"
            loc_cSQL = loc_cSQL + "valinis, valos, valservs, valvars, vars, vends, cotusus, espes,"
            loc_cSQL = loc_cSQL + "pbrus, pliqs, qtdes, lcancelas, cofs, livros, chkbxparcs, ecfs,"
            loc_cSQL = loc_cSQL + "codobs, dgopes, trfisicos, utilizados, valndevs, valobxs, noforms, auditors,"
            loc_cSQL = loc_cSQL + "cidchaves, empdopnums, empgopnums, contaes, dtagends, localents, localizas, chkpagos,"
            loc_cSQL = loc_cSQL + "chkpgs, codtrans, empdnbxs, empdncrds, obsagends, operadors, vcompensas, motdscs,"
            loc_cSQL = loc_cSQL + "ndeclaras, numbalds, numbals, priors, procbals, procdbal, protats, usupagos,"
            loc_cSQL = loc_cSQL + "ultgrvs, moeits, rnops, impress, pstatus, valvarps, cifccfs, cupfis,"
            loc_cSQL = loc_cSQL + "idconta, ncupoms, status, valtrans, impcpfs, ccfgnfs, fpubls, jobs,"
            loc_cSQL = loc_cSQL + "ptax1s, ptax2s, ptax3s, obscabmovs, codobs2, valserfix, perserfix, valosfix,"
            loc_cSQL = loc_cSQL + "chkencerra, perdesc, compet, pedidoweb, cdrastreio, identrega, idtransp, peracresc,"
            loc_cSQL = loc_cSQL + "tpmovs, empfats, numeronota, meiotrans, chavenota, contaccs, grupoccs, natend,"
            loc_cSQL = loc_cSQL + "nlivdg, presente, chaveexterna, empret, msgpresnte, ckoperpend, usuconfs"
            loc_cSQL = loc_cSQL + ") VALUES ("
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nNpedclis, 0) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(0, 4) + ","
            loc_cSQL = loc_cSQL + EscaparSQL("") + ","
            loc_cSQL = loc_cSQL + IIF(THIS.this_lChksubn, 1, 0) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(0, 0) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cContads, 10)) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cContaos, 10)) + ","
            loc_cSQL = loc_cSQL + FormatarDataSQL(THIS.this_dDatas) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(0, 2) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(0, 4) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(0, 0) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cDopes, 20)) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cEmpds, 3)) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cEmps, 3)) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cGrresps, 10)) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cGrupods, 10)) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cGrupoos, 10)) + ","
            loc_cSQL = loc_cSQL + EscaparSQL("") + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cGrvends, 10)) + ","
            loc_cSQL = loc_cSQL + EscaparSQL("") + ","
            loc_cSQL = loc_cSQL + EscaparSQL("") + ","
            loc_cSQL = loc_cSQL + EscaparSQL("") + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(0, 0) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cLprecos, 30)) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cMascnum, 10)) + ","
            loc_cSQL = loc_cSQL + EscaparSQL("") + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cNemps, 40)) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(0, 0) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cNotas, 6)) + ","
            loc_cSQL = loc_cSQL + EscaparSQL("") + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(0, 0) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nNumes, 0) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(0, 0) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(THIS.this_cObses) + ","
            loc_cSQL = loc_cSQL + EscaparSQL("") + ","
            loc_cSQL = loc_cSQL + FormatarDataSQL(THIS.this_dPrazoents) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cResps, 10)) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cTabds, 10)) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cTpfats, 3)) + ","
            loc_cSQL = loc_cSQL + "0" + ","
            loc_cSQL = loc_cSQL + EscaparSQL("") + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(gc_4c_UsuarioLogado, 10)) + ","
            loc_cSQL = loc_cSQL + EscaparSQL("") + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(0, 2) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(0, 2) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(0, 2) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nValdevs, 2) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(0, 2) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nValinis, 2) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nValos, 2) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nValservs, 2) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nValvars, 2) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nVars, 4) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cVends, 10)) + ","
            loc_cSQL = loc_cSQL + EscaparSQL("") + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cEspes, 10)) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nPbrus, 3) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nPliqs, 3) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nQtdes, 0) + ","
            loc_cSQL = loc_cSQL + IIF(THIS.this_lLcancelas, 1, 0) + ","
            loc_cSQL = loc_cSQL + "0" + ","
            loc_cSQL = loc_cSQL + "0" + ","
            loc_cSQL = loc_cSQL + "0" + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cEcfs, 7)) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(0, 0) + ","
            loc_cSQL = loc_cSQL + EscaparSQL("") + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(0, 0) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nUtilizados, 0) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(0, 2) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nValobxs, 2) + ","
            loc_cSQL = loc_cSQL + EscaparSQL("") + ","
            loc_cSQL = loc_cSQL + EscaparSQL("") + ","
            loc_cSQL = loc_cSQL + EscaparSQL(loc_cCidchaves) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cEmpdopnums, 29)) + ","
            loc_cSQL = loc_cSQL + EscaparSQL("") + ","
            loc_cSQL = loc_cSQL + EscaparSQL("") + ","
            loc_cSQL = loc_cSQL + FormatarDataSQL(THIS.this_dDtagends) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nLocalents, 0) + ","
            loc_cSQL = loc_cSQL + EscaparSQL("") + ","
            loc_cSQL = loc_cSQL + IIF(THIS.this_lChkpagos, 1, 0) + ","
            loc_cSQL = loc_cSQL + "0" + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cCodtrans, 10)) + ","
            loc_cSQL = loc_cSQL + EscaparSQL("") + ","
            loc_cSQL = loc_cSQL + EscaparSQL("") + ","
            loc_cSQL = loc_cSQL + EscaparSQL("") + ","
            loc_cSQL = loc_cSQL + EscaparSQL("") + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(0, 2) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cMotdscs, 10)) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(0, 0) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(0, 0) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(0, 0) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(0, 0) + ","
            loc_cSQL = loc_cSQL + "0" + ","
            loc_cSQL = loc_cSQL + "0" + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(0, 0) + ","
            loc_cSQL = loc_cSQL + EscaparSQL("") + ","
            loc_cSQL = loc_cSQL + EscaparSQL("") + ","
            loc_cSQL = loc_cSQL + EscaparSQL("") + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(0, 0) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(0, 0) + ","
            loc_cSQL = loc_cSQL + EscaparSQL("") + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nValvarps, 2) + ","
            loc_cSQL = loc_cSQL + EscaparSQL("") + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(0, 0) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(0, 0) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cNcupoms, 6)) + ","
            loc_cSQL = loc_cSQL + EscaparSQL("") + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(0, 2) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(0, 0) + ","
            loc_cSQL = loc_cSQL + EscaparSQL("") + ","
            loc_cSQL = loc_cSQL + EscaparSQL("") + ","
            loc_cSQL = loc_cSQL + EscaparSQL("") + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(0, 2) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(0, 2) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(0, 2) + ","
            loc_cSQL = loc_cSQL + EscaparSQL("") + ","
            loc_cSQL = loc_cSQL + EscaparSQL("") + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(0, 2) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(0, 2) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(0, 2) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(0, 0) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(0, 2) + ","
            loc_cSQL = loc_cSQL + EscaparSQL("") + ","
            loc_cSQL = loc_cSQL + EscaparSQL("") + ","
            loc_cSQL = loc_cSQL + EscaparSQL("") + ","
            loc_cSQL = loc_cSQL + EscaparSQL("") + ","
            loc_cSQL = loc_cSQL + EscaparSQL("") + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(0, 2) + ","
            loc_cSQL = loc_cSQL + EscaparSQL("") + ","
            loc_cSQL = loc_cSQL + EscaparSQL("") + ","
            loc_cSQL = loc_cSQL + EscaparSQL("") + ","
            loc_cSQL = loc_cSQL + EscaparSQL("") + ","
            loc_cSQL = loc_cSQL + EscaparSQL("") + ","
            loc_cSQL = loc_cSQL + EscaparSQL("") + ","
            loc_cSQL = loc_cSQL + EscaparSQL("") + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(0, 0) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(0, 0) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(0, 0) + ","
            loc_cSQL = loc_cSQL + EscaparSQL("") + ","
            loc_cSQL = loc_cSQL + EscaparSQL("") + ","
            loc_cSQL = loc_cSQL + EscaparSQL("") + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(0, 0) + ","
            loc_cSQL = loc_cSQL + EscaparSQL("") + ")"

            IF USED("cursor_4c_Insert")
                USE IN cursor_4c_Insert
            ENDIF

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Insert")

            IF loc_nResultado < 0
                MsgErro("Erro ao inserir movimento:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ELSE
                THIS.RegistrarAuditoria("INSERT")
                IF USED("cursor_4c_Insert")
                    USE IN cursor_4c_Insert
                ENDIF
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loException
            MsgErro(loException.Message, "Erro em sigmvitsBO.Inserir")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *---------------------------------------------------------------------------
    * Atualizar - Atualiza registro existente em SigMvCab (WHERE empdopnums,
    * chave tecnica desta entidade - Emps+Dopes+Str(Numes,6) - regra #22).
    * cidchaves (PK real da tabela) NUNCA e regravado num UPDATE.
    *---------------------------------------------------------------------------
    PROTECTED PROCEDURE Atualizar()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            *-- Campo computado: Emps + Dopes + Numes (chave de movimentacao)
            THIS.this_cEmpdopnums = PADR(THIS.this_cEmps, 3) + PADR(THIS.this_cDopes, 20) + STR(THIS.this_nNumes, 6)

            *-- Quebrado em multiplas atribuicoes (nao um unico "+;" continuado):
            *-- VFP9 junta linhas continuadas por ";" numa unica LINHA LOGICA
            *-- com limite de 8192 caracteres ("Line is too long" em runtime).
            loc_cSQL = "UPDATE SigMvCab SET"
            loc_cSQL = loc_cSQL + " npedclis = " + FormatarNumeroSQL(THIS.this_nNpedclis, 0) + ","
            loc_cSQL = loc_cSQL + " chksubn = " + IIF(THIS.this_lChksubn, 1, 0) + ","
            loc_cSQL = loc_cSQL + " contads = " + EscaparSQL(LEFT(THIS.this_cContads, 10)) + ","
            loc_cSQL = loc_cSQL + " contaos = " + EscaparSQL(LEFT(THIS.this_cContaos, 10)) + ","
            loc_cSQL = loc_cSQL + " datas = " + FormatarDataSQL(THIS.this_dDatas) + ","
            loc_cSQL = loc_cSQL + " dopes = " + EscaparSQL(LEFT(THIS.this_cDopes, 20)) + ","
            loc_cSQL = loc_cSQL + " empds = " + EscaparSQL(LEFT(THIS.this_cEmpds, 3)) + ","
            loc_cSQL = loc_cSQL + " emps = " + EscaparSQL(LEFT(THIS.this_cEmps, 3)) + ","
            loc_cSQL = loc_cSQL + " grresps = " + EscaparSQL(LEFT(THIS.this_cGrresps, 10)) + ","
            loc_cSQL = loc_cSQL + " grupods = " + EscaparSQL(LEFT(THIS.this_cGrupods, 10)) + ","
            loc_cSQL = loc_cSQL + " grupoos = " + EscaparSQL(LEFT(THIS.this_cGrupoos, 10)) + ","
            loc_cSQL = loc_cSQL + " grvends = " + EscaparSQL(LEFT(THIS.this_cGrvends, 10)) + ","
            loc_cSQL = loc_cSQL + " lprecos = " + EscaparSQL(LEFT(THIS.this_cLprecos, 30)) + ","
            loc_cSQL = loc_cSQL + " mascnum = " + EscaparSQL(LEFT(THIS.this_cMascnum, 10)) + ","
            loc_cSQL = loc_cSQL + " nemps = " + EscaparSQL(LEFT(THIS.this_cNemps, 40)) + ","
            loc_cSQL = loc_cSQL + " notas = " + EscaparSQL(LEFT(THIS.this_cNotas, 6)) + ","
            loc_cSQL = loc_cSQL + " numes = " + FormatarNumeroSQL(THIS.this_nNumes, 0) + ","
            loc_cSQL = loc_cSQL + " obses = " + EscaparSQL(THIS.this_cObses) + ","
            loc_cSQL = loc_cSQL + " prazoents = " + FormatarDataSQL(THIS.this_dPrazoents) + ","
            loc_cSQL = loc_cSQL + " resps = " + EscaparSQL(LEFT(THIS.this_cResps, 10)) + ","
            loc_cSQL = loc_cSQL + " tabds = " + EscaparSQL(LEFT(THIS.this_cTabds, 10)) + ","
            loc_cSQL = loc_cSQL + " tpfats = " + EscaparSQL(LEFT(THIS.this_cTpfats, 3)) + ","
            loc_cSQL = loc_cSQL + " usuars = " + EscaparSQL(LEFT(gc_4c_UsuarioLogado, 10)) + ","
            loc_cSQL = loc_cSQL + " valdevs = " + FormatarNumeroSQL(THIS.this_nValdevs, 2) + ","
            loc_cSQL = loc_cSQL + " valinis = " + FormatarNumeroSQL(THIS.this_nValinis, 2) + ","
            loc_cSQL = loc_cSQL + " valos = " + FormatarNumeroSQL(THIS.this_nValos, 2) + ","
            loc_cSQL = loc_cSQL + " valservs = " + FormatarNumeroSQL(THIS.this_nValservs, 2) + ","
            loc_cSQL = loc_cSQL + " valvars = " + FormatarNumeroSQL(THIS.this_nValvars, 2) + ","
            loc_cSQL = loc_cSQL + " vars = " + FormatarNumeroSQL(THIS.this_nVars, 4) + ","
            loc_cSQL = loc_cSQL + " vends = " + EscaparSQL(LEFT(THIS.this_cVends, 10)) + ","
            loc_cSQL = loc_cSQL + " espes = " + EscaparSQL(LEFT(THIS.this_cEspes, 10)) + ","
            loc_cSQL = loc_cSQL + " pbrus = " + FormatarNumeroSQL(THIS.this_nPbrus, 3) + ","
            loc_cSQL = loc_cSQL + " pliqs = " + FormatarNumeroSQL(THIS.this_nPliqs, 3) + ","
            loc_cSQL = loc_cSQL + " qtdes = " + FormatarNumeroSQL(THIS.this_nQtdes, 0) + ","
            loc_cSQL = loc_cSQL + " lcancelas = " + IIF(THIS.this_lLcancelas, 1, 0) + ","
            loc_cSQL = loc_cSQL + " ecfs = " + EscaparSQL(LEFT(THIS.this_cEcfs, 7)) + ","
            loc_cSQL = loc_cSQL + " utilizados = " + FormatarNumeroSQL(THIS.this_nUtilizados, 0) + ","
            loc_cSQL = loc_cSQL + " valobxs = " + FormatarNumeroSQL(THIS.this_nValobxs, 2) + ","
            loc_cSQL = loc_cSQL + " empdopnums = " + EscaparSQL(LEFT(THIS.this_cEmpdopnums, 29)) + ","
            loc_cSQL = loc_cSQL + " dtagends = " + FormatarDataSQL(THIS.this_dDtagends) + ","
            loc_cSQL = loc_cSQL + " localents = " + FormatarNumeroSQL(THIS.this_nLocalents, 0) + ","
            loc_cSQL = loc_cSQL + " chkpagos = " + IIF(THIS.this_lChkpagos, 1, 0) + ","
            loc_cSQL = loc_cSQL + " codtrans = " + EscaparSQL(LEFT(THIS.this_cCodtrans, 10)) + ","
            loc_cSQL = loc_cSQL + " motdscs = " + EscaparSQL(LEFT(THIS.this_cMotdscs, 10)) + ","
            loc_cSQL = loc_cSQL + " valvarps = " + FormatarNumeroSQL(THIS.this_nValvarps, 2) + ","
            loc_cSQL = loc_cSQL + " ncupoms = " + EscaparSQL(LEFT(THIS.this_cNcupoms, 6))
            loc_cSQL = loc_cSQL + " WHERE empdopnums = " + EscaparSQL(LEFT(THIS.this_cEmpdopnums, 29))

            IF USED("cursor_4c_Update")
                USE IN cursor_4c_Update
            ENDIF

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Update")

            IF loc_nResultado < 0
                MsgErro("Erro ao atualizar movimento:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ELSE
                THIS.RegistrarAuditoria("UPDATE")
                IF USED("cursor_4c_Update")
                    USE IN cursor_4c_Update
                ENDIF
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loException
            MsgErro(loException.Message, "Erro em sigmvitsBO.Atualizar")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

ENDDEFINE

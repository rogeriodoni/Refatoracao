*============================================================================
* sigopfisBO.prg - Business Object para Dados Fiscais da Nota Fiscal
*
* Tabela principal : SigMvNfi  (PK: cidchaves char(20))
* Ligacao mestre    : SigMvCab (FK composta: EmpDopNums char(29) = Emps+Dopes+Str(Numes,6))
* Lookup transporte  : SigPrTrp (PK: Itras,  desc: Razaos)
* Lookup CFO         : SigCdCfo (PK: Codigos)
* Lookup UF/Municipio : SigCdUfs (PK: Estados), SigCdMun (PK: Codigos/Munici)
* Lookup beneficio    : SigCdBfj / crBeneficioRJ (PK: codigos, desc: descrs)
* Lookup servico mun. : crSrvMuns (PK: codigos, desc: descrs)
*
* Este BO representa a aba "Dados Fiscais"/"Servicos" de uma Nota Fiscal,
* embutida como sub-pagina de um form de movimentacao maior (SigOpMvi e
* similares). O registro de SigMvNfi e gravado pelo form PAI (TableUpdate do
* cursor principal); este BO fornece as propriedades e as regras de calculo
* fiscal (impostos, servicos) referentes ao mesmo registro.
*
* Herda de: BusinessBase
* Criado em: Fase 1 - Propriedades e Init
*============================================================================

DEFINE CLASS sigopfisBO AS BusinessBase

    *==========================================================================
    * Chave e ligacao com o movimento (SigMvCab) - cidchaves eh a PK de SigMvNfi;
    * EmpDopNums (Emps+Dopes+Str(Numes,6)) e a chave composta que liga ao
    * cabecalho do movimento (regra #42: NUNCA ALLTRIM nas partes internas).
    *==========================================================================
    this_cCidchaves  = ""   && char(20) - PK
    this_cEmpDopNums = ""   && char(29) - Emps(3) + Dopes(20) + Str(Numes,6)
    this_cEmps       = ""   && char(3)  - Empresa do movimento
    this_cDopes      = ""   && char(20) - Documento de operacao
    this_nNumes      = 0    && numeric(6,0) - Numero sequencial do movimento

    *==========================================================================
    * Cabecalho da Nota (Pagina Impostos - topo do form)
    *==========================================================================
    this_cNFis       = ""   && char(6)  - Numero da nota fiscal
    this_cSeries     = ""   && char(8)  - Serie da nota
    this_cEspecieNFs = ""   && char(6)  - Especie da nota
    this_dEmis       = {}   && datetime NULL - Data de emissao
    this_nSelos      = 0    && numeric(10,0) - Numero do selo fiscal
    this_dDtSaidas   = {}   && datetime NULL - Data de saida
    this_cCFis       = ""   && char(10) - CFOP de movimentacao
    this_cCfoSubs    = ""   && char(10) - CFOP de substituicao

    *==========================================================================
    * Impostos - IPI / ICMS (bases e valores)
    *==========================================================================
    this_nBasecIpis   = 0   && numeric(14,2) - Base de calculo do IPI
    this_nValIpis     = 0   && numeric(14,2) - Valor do IPI
    this_nBasecIcms   = 0   && numeric(14,2) - Base de calculo do ICMS
    this_nValIcms     = 0   && numeric(14,2) - Valor do ICMS
    this_nTotProds    = 0   && numeric(14,2) - Total dos produtos
    this_nTotNotas    = 0   && numeric(14,2) - Total da nota fiscal

    *==========================================================================
    * Impostos - Substituicao / Isento / Outras bases (ICMS e IPI)
    *==========================================================================
    this_nBcicmss      = 0  && numeric(15,2) - Base substituicao ICMS
    this_nIcmss        = 0  && numeric(15,2) - Valor substituicao ICMS
    this_nBasecic2s    = 0  && numeric(14,2) - Base ICMS isento
    this_nBasecic3s    = 0  && numeric(14,2) - Base ICMS outras
    this_nBasecIp2s    = 0  && numeric(14,2) - Base IPI isento
    this_nBasecip3s    = 0  && numeric(14,2) - Base IPI outras
    this_nIpiNCreds    = 0  && numeric(14,2) - IPI nao creditado

    *==========================================================================
    * Frete / Seguro / Despesas acessorias (valores e percentuais/bases ICMS/IPI)
    *==========================================================================
    this_nVlFretes   = 0    && numeric(14,2) - Valor do frete
    this_nVlSeguros  = 0    && numeric(14,2) - Valor do seguro
    this_nDespAces   = 0    && numeric(14,2) - Despesas acessorias
    this_nFrtIcms    = 0    && numeric(15,2) - ICMS sobre frete
    this_nFrtIpis    = 0    && numeric(15,2) - IPI sobre frete
    this_nSegIcms    = 0    && numeric(15,2) - ICMS sobre seguro
    this_nSegIpis    = 0    && numeric(15,2) - IPI sobre seguro
    this_nDesIcms    = 0    && numeric(15,2) - ICMS sobre despesas
    this_nDesIpis    = 0    && numeric(15,2) - IPI sobre despesas
    this_cObsFretes  = ""   && char(10) - Observacao do frete (preenchida quando % = 0)
    this_cObspliqs   = ""   && char(10) - Observacao peso liquido
    this_cObspbrus   = ""   && char(10) - Observacao peso bruto

    *==========================================================================
    * Transporte / Volumes
    *==========================================================================
    this_cCodTrans = ""     && char(10) - Codigo do transportador (SigPrTrp.Itras)
    this_nFretes   = 0      && numeric(1,0) - Modo de frete (ComboBox - indice 1-based)
    this_cPlacas   = ""     && char(8)  - Placa do veiculo
    this_cUfPlacas = ""     && char(2)  - UF da placa
    this_nQtdes    = 0      && numeric(6,0) - Quantidade de volumes
    this_cEspes    = ""     && char(10) - Especie dos volumes
    this_cMarcas   = ""     && char(10) - Marca dos volumes
    this_cNumeros  = ""     && char(10) - Numeracao dos volumes
    this_nPLiqs    = 0      && numeric(10,3) NULL - Peso liquido
    this_nPBrus    = 0      && numeric(10,3) NULL - Peso bruto
    this_cObss     = ""     && char(40) - Observacoes gerais

    *==========================================================================
    * NFe - Chave de acesso / DI (Declaracao de Importacao)
    *==========================================================================
    this_cNfechv  = ""      && char(44) - Chave de acesso da NFe
    this_cNfechvc = ""      && char(44) - Chave de acesso da NFe referenciada (NFe complementar)
    this_cNdis    = ""      && char(10) - Numero da DI
    this_dDregdis = {}      && datetime NULL - Data de registro da DI
    this_dDdesembs = {}     && datetime NULL - Data de desembaraco da DI

    *==========================================================================
    * Servicos (ISS/Simples Nacional - Pagina Servicos)
    *==========================================================================
    this_nTptribsers  = 0   && numeric(2,0) - Tipo de tributacao de servicos (RECNO de crTpTrib)
    this_cCodbenefs   = ""  && char(3)  - Codigo do beneficio fiscal
    this_cCodsrvfis   = ""  && char(6)  - Codigo do servico municipal
    this_nVdeducoes   = 0   && numeric(15,2) - Deducoes
    this_nVdscconds   = 0   && numeric(15,2) - Desconto condicionado
    this_nVdsciconds  = 0   && numeric(15,2) - Desconto incondicionado
    this_nOutretens   = 0   && numeric(15,2) - Outras retencoes
    this_nIssretidos  = 0   && numeric(1,0) - ISS retido (OptionGroup - indice 1-based)
    this_cTiponfs     = ""  && char(2)  - Tipo de nota (convencional/NFCe)
    this_nVtotiss     = 0   && numeric(14,2) - Total ISS (campo Fwget1)
    this_nVirf        = 0   && numeric(14,2) - Total IRRF (campo Fwget2)
    this_nVinss       = 0   && numeric(14,2) - Total INSS (campo Fwget3)
    this_nVpis        = 0   && numeric(14,2) - Total PIS (campo Fwget4)
    this_nVcsll       = 0   && numeric(14,2) - Total CSLL (campo Fwget5)
    this_nVcofins     = 0   && numeric(14,2) - Total COFINS (campo Fwget6)

    *==========================================================================
    * Propriedades de exibicao - nao armazenadas diretamente no banco
    * (resultado de lookup, usados so para preencher a descricao na tela)
    *==========================================================================
    this_cDClFiscal  = ""   && Descricao do CFOP de movimentacao (SigCdCfo)
    this_cDCfoSubs   = ""   && Descricao do CFOP de substituicao (SigCdCfo)
    this_cDTransp    = ""   && Razao social do transportador (SigPrTrp.Razaos)
    this_cEndTransp  = ""   && Endereco do transportador
    this_cCidTransp  = ""   && Cidade do transportador
    this_cUfTransp   = ""   && UF do transportador
    this_cUfServ     = ""   && UF do local da prestacao de servico (Servicos)
    this_cMunServ    = ""   && Municipio da prestacao de servico (Servicos)
    this_cDCodbenefs = ""   && Descricao do beneficio fiscal
    this_cDCodsrvfis = ""   && Descricao do servico municipal

    *==========================================================================
    * Colunas NOT NULL de SigMvNfi sem controle correspondente na tela (nao
    * citadas em layout.json/comportamento.json) - mantidas como propriedades,
    * e nao como literal fixo no SQL, para o valor gravado por outra rotina
    * (ex.: Cancela Nota / Carta de Correcao) nao ser PERDIDO no proximo
    * Atualizar() desta aba (regra CLAUDE.md #22 - INSERT/UPDATE tem de cobrir
    * toda coluna NOT NULL do schema, nunca so as citadas no dump do legado).
    *==========================================================================
    this_lCancelas     = .F.  && cancelas bit - nota cancelada
    this_cClfis        = ""   && clfis char(12)
    this_cClifors      = ""   && clifors char(20)
    this_cCodcons      = ""   && codcons char(9)
    this_cConds        = ""   && conds char(12)
    this_nIcms         = 0    && icms numeric(4,2) - aliquota ICMS
    this_nImpress      = 0    && impress numeric(6,0)
    this_nIpis         = 0    && ipis numeric(4,2) - aliquota IPI
    this_cObs2s        = ""   && obs2s char(40)
    this_cOperas       = ""   && operas char(1) - E/S
    this_nPerciss      = 0    && perciss numeric(5,2)
    this_nPesos        = 0    && pesos numeric(7,2)
    this_lRegs         = .F.  && regs bit
    this_nVals         = 0    && vals numeric(14,2)
    this_nVtotsers     = 0    && vtotsers numeric(14,2)
    this_cCgcs         = ""   && cgcs char(21)
    this_lCorrecs      = .F.  && correcs bit - carta de correcao emitida
    this_cLocals       = ""   && locals char(10)
    this_nNtrans       = 0    && ntrans numeric(6,0)
    this_cCodservs     = ""   && codservs char(10)
    this_cDescservs    = ""   && descservs char(40)
    this_nChkenvias    = 0    && chkenvias numeric(1,0)
    this_nLoterps      = 0    && loterps numeric(6,0)
    this_nNumrps       = 0    && numrps numeric(12,0)
    this_nPcofins      = 0    && pcofins numeric(5,2)
    this_nPcsll        = 0    && pcsll numeric(5,2)
    this_nPinss        = 0    && pinss numeric(5,2)
    this_nPirf         = 0    && pirf numeric(5,2)
    this_nPpis         = 0    && ppis numeric(5,2)
    this_cSerierps     = ""   && serierps char(5)
    this_cTiporps      = ""   && tiporps char(5)
    this_nValiis       = 0    && valiis numeric(14,2)
    this_cNfeprt       = ""   && nfeprt char(15)
    this_cChnfes       = ""   && chnfes char(44)
    this_cPrestservs   = ""   && prestservs char(7)
    this_nVfcpst       = 0    && vfcpst numeric(14,2)
    this_cNumeroNota   = ""   && NumeroNota char(10)
    this_nChkrastreio  = 0    && chkrastreio numeric(1,0)
    this_cChaveExterna = ""   && chaveexterna char(33)

    *==========================================================================
    * Init - Inicializa o Business Object configurando tabela e chave primaria
    *==========================================================================
    PROCEDURE Init()
        LOCAL loc_lResultado
        loc_lResultado = .F.

        TRY
            DODEFAULT()
            THIS.this_cTabela     = "SigMvNfi"
            THIS.this_cCampoChave = "cidchaves"
            loc_lResultado = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * ObterChavePrimaria - Retorna valor da PK para RegistrarAuditoria
    *==========================================================================
    PROTECTED PROCEDURE ObterChavePrimaria()
        RETURN ALLTRIM(NVL(THIS.this_cCidchaves, ""))
    ENDPROC

    *==========================================================================
    * CarregarDoCursor - Mapeia TODAS as colunas do cursor SQL (SigMvNfi) para
    * as propriedades do BO. SEMPRE SELECT (par_cAliasCursor) antes de acessar
    * os campos (regra #8/CLAUDE.md) - nunca campo.
    *==========================================================================
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF USED(par_cAliasCursor)
                SELECT (par_cAliasCursor)

                THIS.this_cCidchaves  = TratarNulo(cidchaves, "")
                THIS.this_cEmpDopNums = TratarNulo(empdopnums, "")
                THIS.this_cEmps       = TratarNulo(emps, "")
                THIS.this_cDopes      = TratarNulo(dopes, "")
                THIS.this_nNumes      = TratarNulo(numes, 0)

                THIS.this_cNFis       = TratarNulo(nfis, "")
                THIS.this_cSeries     = TratarNulo(series, "")
                THIS.this_cEspecieNFs = TratarNulo(especienfs, "")
                THIS.this_dEmis       = TratarNulo(emis, {})
                THIS.this_nSelos      = TratarNulo(selos, 0)
                THIS.this_dDtSaidas   = TratarNulo(dtsaidas, {})
                THIS.this_cCFis       = TratarNulo(cfis, "")
                THIS.this_cCfoSubs    = TratarNulo(cfosubs, "")

                THIS.this_nBasecIpis  = TratarNulo(basecipis, 0)
                THIS.this_nValIpis    = TratarNulo(valipis, 0)
                THIS.this_nBasecIcms  = TratarNulo(basecicms, 0)
                THIS.this_nValIcms    = TratarNulo(valicms, 0)
                THIS.this_nTotProds   = TratarNulo(totprods, 0)
                THIS.this_nTotNotas   = TratarNulo(totnotas, 0)

                THIS.this_nBcicmss    = TratarNulo(bcicmss, 0)
                THIS.this_nIcmss      = TratarNulo(icmss, 0)
                THIS.this_nBasecic2s  = TratarNulo(basecic2s, 0)
                THIS.this_nBasecic3s  = TratarNulo(basecic3s, 0)
                THIS.this_nBasecIp2s  = TratarNulo(basecip2s, 0)
                THIS.this_nBasecip3s  = TratarNulo(basecip3s, 0)
                THIS.this_nIpiNCreds  = TratarNulo(ipincreds, 0)

                THIS.this_nVlFretes   = TratarNulo(vlfretes, 0)
                THIS.this_nVlSeguros  = TratarNulo(vlseguros, 0)
                THIS.this_nDespAces   = TratarNulo(despaces, 0)
                THIS.this_nFrtIcms    = TratarNulo(frticms, 0)
                THIS.this_nFrtIpis    = TratarNulo(frtipis, 0)
                THIS.this_nSegIcms    = TratarNulo(segicms, 0)
                THIS.this_nSegIpis    = TratarNulo(segipis, 0)
                THIS.this_nDesIcms    = TratarNulo(desicms, 0)
                THIS.this_nDesIpis    = TratarNulo(desipis, 0)
                THIS.this_cObsFretes  = TratarNulo(obsfretes, "")
                THIS.this_cObspliqs   = TratarNulo(obspliqs, "")
                THIS.this_cObspbrus   = TratarNulo(obspbrus, "")

                THIS.this_cCodTrans   = TratarNulo(codtrans, "")
                THIS.this_nFretes     = TratarNulo(fretes, 0)
                THIS.this_cPlacas     = TratarNulo(placas, "")
                THIS.this_cUfPlacas   = TratarNulo(ufplacas, "")
                THIS.this_nQtdes      = TratarNulo(qtdes, 0)
                THIS.this_cEspes      = TratarNulo(espes, "")
                THIS.this_cMarcas     = TratarNulo(marcas, "")
                THIS.this_cNumeros    = TratarNulo(numeros, "")
                THIS.this_nPLiqs      = TratarNulo(pliqs, 0)
                THIS.this_nPBrus      = TratarNulo(pbrus, 0)
                THIS.this_cObss       = TratarNulo(obss, "")

                THIS.this_cNfechv     = TratarNulo(nfechv, "")
                THIS.this_cNfechvc    = TratarNulo(nfechvc, "")
                THIS.this_cNdis       = TratarNulo(ndis, "")
                THIS.this_dDregdis    = TratarNulo(dregdis, {})
                THIS.this_dDdesembs   = TratarNulo(ddesembs, {})

                THIS.this_nTptribsers  = TratarNulo(tptribsers, 0)
                THIS.this_cCodbenefs   = TratarNulo(codbenefs, "")
                THIS.this_cCodsrvfis   = TratarNulo(codsrvfis, "")
                THIS.this_nVdeducoes   = TratarNulo(vdeducoes, 0)
                THIS.this_nVdscconds   = TratarNulo(vdscconds, 0)
                THIS.this_nVdsciconds  = TratarNulo(vdsciconds, 0)
                THIS.this_nOutretens   = TratarNulo(outretens, 0)
                THIS.this_nIssretidos  = TratarNulo(issretidos, 0)
                THIS.this_cTiponfs     = TratarNulo(tiponfs, "")
                THIS.this_nVtotiss     = TratarNulo(vtotiss, 0)
                THIS.this_nVirf        = TratarNulo(virf, 0)
                THIS.this_nVinss       = TratarNulo(vinss, 0)
                THIS.this_nVpis        = TratarNulo(vpis, 0)
                THIS.this_nVcsll       = TratarNulo(vcsll, 0)
                THIS.this_nVcofins     = TratarNulo(vcofins, 0)

                *-- Colunas NOT NULL sem controle na tela (regra #22)
                IF VARTYPE(cancelas) = "L"
                    THIS.this_lCancelas = cancelas
                ELSE
                    THIS.this_lCancelas = (NVL(cancelas, 0) = 1)
                ENDIF
                THIS.this_cClfis      = TratarNulo(clfis, "")
                THIS.this_cClifors    = TratarNulo(clifors, "")
                THIS.this_cCodcons    = TratarNulo(codcons, "")
                THIS.this_cConds      = TratarNulo(conds, "")
                THIS.this_nIcms       = TratarNulo(icms, 0)
                THIS.this_nImpress    = TratarNulo(impress, 0)
                THIS.this_nIpis       = TratarNulo(ipis, 0)
                THIS.this_cObs2s      = TratarNulo(obs2s, "")
                THIS.this_cOperas     = TratarNulo(operas, "")
                THIS.this_nPerciss    = TratarNulo(perciss, 0)
                THIS.this_nPesos      = TratarNulo(pesos, 0)
                IF VARTYPE(regs) = "L"
                    THIS.this_lRegs = regs
                ELSE
                    THIS.this_lRegs = (NVL(regs, 0) = 1)
                ENDIF
                THIS.this_nVals       = TratarNulo(vals, 0)
                THIS.this_nVtotsers   = TratarNulo(vtotsers, 0)
                THIS.this_cCgcs       = TratarNulo(cgcs, "")
                IF VARTYPE(correcs) = "L"
                    THIS.this_lCorrecs = correcs
                ELSE
                    THIS.this_lCorrecs = (NVL(correcs, 0) = 1)
                ENDIF
                THIS.this_cLocals     = TratarNulo(locals, "")
                THIS.this_nNtrans     = TratarNulo(ntrans, 0)
                THIS.this_cCodservs   = TratarNulo(codservs, "")
                THIS.this_cDescservs  = TratarNulo(descservs, "")
                THIS.this_nChkenvias  = TratarNulo(chkenvias, 0)
                THIS.this_nLoterps    = TratarNulo(loterps, 0)
                THIS.this_nNumrps     = TratarNulo(numrps, 0)
                THIS.this_nPcofins    = TratarNulo(pcofins, 0)
                THIS.this_nPcsll      = TratarNulo(pcsll, 0)
                THIS.this_nPinss      = TratarNulo(pinss, 0)
                THIS.this_nPirf       = TratarNulo(pirf, 0)
                THIS.this_nPpis       = TratarNulo(ppis, 0)
                THIS.this_cSerierps   = TratarNulo(serierps, "")
                THIS.this_cTiporps    = TratarNulo(tiporps, "")
                THIS.this_nValiis     = TratarNulo(valiis, 0)
                THIS.this_cNfeprt     = TratarNulo(nfeprt, "")
                THIS.this_cChnfes     = TratarNulo(chnfes, "")
                THIS.this_cPrestservs = TratarNulo(prestservs, "")
                THIS.this_nVfcpst     = TratarNulo(vfcpst, 0)
                IF TYPE("numeronota") != "U"
                    THIS.this_cNumeroNota = TratarNulo(numeronota, "")
                ENDIF
                THIS.this_nChkrastreio = TratarNulo(chkrastreio, 0)
                IF TYPE("chaveexterna") != "U"
                    THIS.this_cChaveExterna = TratarNulo(chaveexterna, "")
                ENDIF

                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro em sigopfisBO.CarregarDoCursor")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * CarregarPorCidchaves - carrega o registro de SigMvNfi cuja PK bate com
    * this_cCidchaves (equivalente ao form PAI ja ter posicionado o cursor
    * global crSigMvNfi no legado). SELECT em cursor TEMPORARIO + CarregarDoCursor
    * (regra CLAUDE.md #8 - SEMPRE SELECT (alias) antes de ler campo, nunca
    * campo). Chamado pelo Form ao abrir em modo ALTERAR/VISUALIZAR.
    *==========================================================================
    PROCEDURE CarregarPorCidchaves()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso, loc_lProsseguir, loc_oErro
        loc_lSucesso    = .F.
        loc_lProsseguir = !EMPTY(ALLTRIM(NVL(THIS.this_cCidchaves, "")))

        TRY
            IF loc_lProsseguir
                IF USED("cursor_4c_CargaNfi")
                    USE IN cursor_4c_CargaNfi
                ENDIF

                loc_cSQL = "SELECT * FROM SigMvNfi WHERE cidchaves = " + ;
                    EscaparSQL(LEFT(ALLTRIM(THIS.this_cCidchaves), 20))

                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_CargaNfi")

                IF loc_nResultado < 0
                    MsgErro("Erro ao carregar dados fiscais da nota:" + CHR(13) + ;
                        CapturarErroSQL(), "Erro SQL")
                ELSE
                    IF USED("cursor_4c_CargaNfi") AND RECCOUNT("cursor_4c_CargaNfi") > 0
                        loc_lSucesso = THIS.CarregarDoCursor("cursor_4c_CargaNfi")
                    ENDIF
                ENDIF

                IF USED("cursor_4c_CargaNfi")
                    USE IN cursor_4c_CargaNfi
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro em sigopfisBO.CarregarPorCidchaves")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * Inserir - Insere novo registro em SigMvNfi
    * PK (cidchaves) gerada via fUniqueIds() se ainda nao preenchida (regra #22
    * - NUNCA string vazia, senao o 2o registro colide no indice unico)
    *==========================================================================
    PROTECTED PROCEDURE Inserir()
        LOCAL loc_cSQL, loc_nResult, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF EMPTY(ALLTRIM(NVL(THIS.this_cCidchaves, "")))
                THIS.this_cCidchaves = LEFT(fUniqueIds(), 20)
            ENDIF

            *-- Campo computado: Emps + Dopes + Numes (chave de movimentacao,
            *-- regra #42 - NUNCA ALLTRIM nas partes internas)
            THIS.this_cEmpDopNums = PADR(THIS.this_cEmps, 3) + PADR(THIS.this_cDopes, 20) + STR(THIS.this_nNumes, 6)

            *-- Quebrado em multiplas atribuicoes (nao um unico "+;" continuado):
            *-- VFP9 junta linhas continuadas por ";" numa unica LINHA LOGICA
            *-- com limite de 8192 caracteres ("Line is too long" em runtime).
            loc_cSQL = "INSERT INTO SigMvNfi ("
            loc_cSQL = loc_cSQL + "cidchaves, empdopnums, emps, dopes, numes,"
            loc_cSQL = loc_cSQL + "nfis, series, especienfs, emis, selos, dtsaidas, cfis, cfosubs,"
            loc_cSQL = loc_cSQL + "basecipis, valipis, basecicms, valicms, totprods, totnotas,"
            loc_cSQL = loc_cSQL + "bcicmss, icmss, basecic2s, basecic3s, basecip2s, basecip3s, ipincreds,"
            loc_cSQL = loc_cSQL + "vlfretes, vlseguros, despaces, frticms, frtipis, segicms, segipis, desicms, desipis,"
            loc_cSQL = loc_cSQL + "obsfretes, obspliqs, obspbrus,"
            loc_cSQL = loc_cSQL + "codtrans, fretes, placas, ufplacas, qtdes, espes, marcas, numeros, pliqs, pbrus, obss,"
            loc_cSQL = loc_cSQL + "nfechv, nfechvc, ndis, dregdis, ddesembs,"
            loc_cSQL = loc_cSQL + "tptribsers, codbenefs, codsrvfis, vdeducoes, vdscconds, vdsciconds, outretens,"
            loc_cSQL = loc_cSQL + "issretidos, tiponfs, vtotiss, virf, vinss, vpis, vcsll, vcofins,"
            loc_cSQL = loc_cSQL + "cancelas, clfis, clifors, codcons, conds, icms, impress, ipis, obs2s, operas,"
            loc_cSQL = loc_cSQL + "perciss, pesos, regs, vals, vtotsers, cgcs, correcs, locals, ntrans,"
            loc_cSQL = loc_cSQL + "codservs, descservs, chkenvias, loterps, numrps, pcofins, pcsll, pinss, pirf, ppis,"
            loc_cSQL = loc_cSQL + "serierps, tiporps, valiis, nfeprt, chnfes, prestservs, vfcpst,"
            loc_cSQL = loc_cSQL + "NumeroNota, chkrastreio, chaveexterna"
            loc_cSQL = loc_cSQL + ") VALUES ("
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cCidchaves, 20)) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cEmpDopNums, 29)) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cEmps, 3)) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cDopes, 20)) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nNumes, 0) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cNFis, 6)) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cSeries, 8)) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cEspecieNFs, 6)) + ","
            loc_cSQL = loc_cSQL + FormatarDataSQL(THIS.this_dEmis) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nSelos, 0) + ","
            loc_cSQL = loc_cSQL + FormatarDataSQL(THIS.this_dDtSaidas) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cCFis, 10)) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cCfoSubs, 10)) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nBasecIpis, 2) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nValIpis, 2) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nBasecIcms, 2) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nValIcms, 2) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nTotProds, 2) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nTotNotas, 2) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nBcicmss, 2) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nIcmss, 2) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nBasecic2s, 2) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nBasecic3s, 2) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nBasecIp2s, 2) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nBasecip3s, 2) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nIpiNCreds, 2) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nVlFretes, 2) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nVlSeguros, 2) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nDespAces, 2) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nFrtIcms, 2) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nFrtIpis, 2) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nSegIcms, 2) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nSegIpis, 2) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nDesIcms, 2) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nDesIpis, 2) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cObsFretes, 10)) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cObspliqs, 10)) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cObspbrus, 10)) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cCodTrans, 10)) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nFretes, 0) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cPlacas, 8)) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cUfPlacas, 2)) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nQtdes, 0) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cEspes, 10)) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cMarcas, 10)) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cNumeros, 10)) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nPLiqs, 3) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nPBrus, 3) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cObss, 40)) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cNfechv, 44)) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cNfechvc, 44)) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cNdis, 10)) + ","
            loc_cSQL = loc_cSQL + FormatarDataSQL(THIS.this_dDregdis) + ","
            loc_cSQL = loc_cSQL + FormatarDataSQL(THIS.this_dDdesembs) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nTptribsers, 0) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cCodbenefs, 3)) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cCodsrvfis, 6)) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nVdeducoes, 2) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nVdscconds, 2) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nVdsciconds, 2) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nOutretens, 2) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nIssretidos, 0) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cTiponfs, 2)) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nVtotiss, 2) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nVirf, 2) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nVinss, 2) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nVpis, 2) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nVcsll, 2) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nVcofins, 2) + ","
            loc_cSQL = loc_cSQL + IIF(THIS.this_lCancelas, 1, 0) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cClfis, 12)) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cClifors, 20)) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cCodcons, 9)) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cConds, 12)) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nIcms, 2) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nImpress, 0) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nIpis, 2) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cObs2s, 40)) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cOperas, 1)) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nPerciss, 2) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nPesos, 2) + ","
            loc_cSQL = loc_cSQL + IIF(THIS.this_lRegs, 1, 0) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nVals, 2) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nVtotsers, 2) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cCgcs, 21)) + ","
            loc_cSQL = loc_cSQL + IIF(THIS.this_lCorrecs, 1, 0) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cLocals, 10)) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nNtrans, 0) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cCodservs, 10)) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cDescservs, 40)) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nChkenvias, 0) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nLoterps, 0) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nNumrps, 0) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nPcofins, 2) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nPcsll, 2) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nPinss, 2) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nPirf, 2) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nPpis, 2) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cSerierps, 5)) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cTiporps, 5)) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nValiis, 2) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cNfeprt, 15)) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cChnfes, 44)) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cPrestservs, 7)) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nVfcpst, 2) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cNumeroNota, 10)) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nChkrastreio, 0) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cChaveExterna, 33)) + ")"

            IF USED("cursor_4c_Insert")
                USE IN cursor_4c_Insert
            ENDIF

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Insert")

            IF loc_nResult < 0
                MsgErro("Erro ao inserir dados fiscais da nota:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ELSE
                THIS.RegistrarAuditoria("INSERT")
                IF USED("cursor_4c_Insert")
                    USE IN cursor_4c_Insert
                ENDIF
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro em sigopfisBO.Inserir")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * Atualizar - Atualiza registro existente em SigMvNfi (por cidchaves)
    *==========================================================================
    PROTECTED PROCEDURE Atualizar()
        LOCAL loc_cSQL, loc_nResult, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            *-- Campo computado: Emps + Dopes + Numes (chave de movimentacao,
            *-- regra #42 - NUNCA ALLTRIM nas partes internas)
            THIS.this_cEmpDopNums = PADR(THIS.this_cEmps, 3) + PADR(THIS.this_cDopes, 20) + STR(THIS.this_nNumes, 6)

            *-- Quebrado em multiplas atribuicoes (nao um unico "+;" continuado):
            *-- VFP9 junta linhas continuadas por ";" numa unica LINHA LOGICA
            *-- com limite de 8192 caracteres ("Line is too long" em runtime).
            loc_cSQL = "UPDATE SigMvNfi SET"
            loc_cSQL = loc_cSQL + " empdopnums = " + EscaparSQL(LEFT(THIS.this_cEmpDopNums, 29)) + ","
            loc_cSQL = loc_cSQL + " emps = " + EscaparSQL(LEFT(THIS.this_cEmps, 3)) + ","
            loc_cSQL = loc_cSQL + " dopes = " + EscaparSQL(LEFT(THIS.this_cDopes, 20)) + ","
            loc_cSQL = loc_cSQL + " numes = " + FormatarNumeroSQL(THIS.this_nNumes, 0) + ","
            loc_cSQL = loc_cSQL + " nfis = " + EscaparSQL(LEFT(THIS.this_cNFis, 6)) + ","
            loc_cSQL = loc_cSQL + " series = " + EscaparSQL(LEFT(THIS.this_cSeries, 8)) + ","
            loc_cSQL = loc_cSQL + " especienfs = " + EscaparSQL(LEFT(THIS.this_cEspecieNFs, 6)) + ","
            loc_cSQL = loc_cSQL + " emis = " + FormatarDataSQL(THIS.this_dEmis) + ","
            loc_cSQL = loc_cSQL + " selos = " + FormatarNumeroSQL(THIS.this_nSelos, 0) + ","
            loc_cSQL = loc_cSQL + " dtsaidas = " + FormatarDataSQL(THIS.this_dDtSaidas) + ","
            loc_cSQL = loc_cSQL + " cfis = " + EscaparSQL(LEFT(THIS.this_cCFis, 10)) + ","
            loc_cSQL = loc_cSQL + " cfosubs = " + EscaparSQL(LEFT(THIS.this_cCfoSubs, 10)) + ","
            loc_cSQL = loc_cSQL + " basecipis = " + FormatarNumeroSQL(THIS.this_nBasecIpis, 2) + ","
            loc_cSQL = loc_cSQL + " valipis = " + FormatarNumeroSQL(THIS.this_nValIpis, 2) + ","
            loc_cSQL = loc_cSQL + " basecicms = " + FormatarNumeroSQL(THIS.this_nBasecIcms, 2) + ","
            loc_cSQL = loc_cSQL + " valicms = " + FormatarNumeroSQL(THIS.this_nValIcms, 2) + ","
            loc_cSQL = loc_cSQL + " totprods = " + FormatarNumeroSQL(THIS.this_nTotProds, 2) + ","
            loc_cSQL = loc_cSQL + " totnotas = " + FormatarNumeroSQL(THIS.this_nTotNotas, 2) + ","
            loc_cSQL = loc_cSQL + " bcicmss = " + FormatarNumeroSQL(THIS.this_nBcicmss, 2) + ","
            loc_cSQL = loc_cSQL + " icmss = " + FormatarNumeroSQL(THIS.this_nIcmss, 2) + ","
            loc_cSQL = loc_cSQL + " basecic2s = " + FormatarNumeroSQL(THIS.this_nBasecic2s, 2) + ","
            loc_cSQL = loc_cSQL + " basecic3s = " + FormatarNumeroSQL(THIS.this_nBasecic3s, 2) + ","
            loc_cSQL = loc_cSQL + " basecip2s = " + FormatarNumeroSQL(THIS.this_nBasecIp2s, 2) + ","
            loc_cSQL = loc_cSQL + " basecip3s = " + FormatarNumeroSQL(THIS.this_nBasecip3s, 2) + ","
            loc_cSQL = loc_cSQL + " ipincreds = " + FormatarNumeroSQL(THIS.this_nIpiNCreds, 2) + ","
            loc_cSQL = loc_cSQL + " vlfretes = " + FormatarNumeroSQL(THIS.this_nVlFretes, 2) + ","
            loc_cSQL = loc_cSQL + " vlseguros = " + FormatarNumeroSQL(THIS.this_nVlSeguros, 2) + ","
            loc_cSQL = loc_cSQL + " despaces = " + FormatarNumeroSQL(THIS.this_nDespAces, 2) + ","
            loc_cSQL = loc_cSQL + " frticms = " + FormatarNumeroSQL(THIS.this_nFrtIcms, 2) + ","
            loc_cSQL = loc_cSQL + " frtipis = " + FormatarNumeroSQL(THIS.this_nFrtIpis, 2) + ","
            loc_cSQL = loc_cSQL + " segicms = " + FormatarNumeroSQL(THIS.this_nSegIcms, 2) + ","
            loc_cSQL = loc_cSQL + " segipis = " + FormatarNumeroSQL(THIS.this_nSegIpis, 2) + ","
            loc_cSQL = loc_cSQL + " desicms = " + FormatarNumeroSQL(THIS.this_nDesIcms, 2) + ","
            loc_cSQL = loc_cSQL + " desipis = " + FormatarNumeroSQL(THIS.this_nDesIpis, 2) + ","
            loc_cSQL = loc_cSQL + " obsfretes = " + EscaparSQL(LEFT(THIS.this_cObsFretes, 10)) + ","
            loc_cSQL = loc_cSQL + " obspliqs = " + EscaparSQL(LEFT(THIS.this_cObspliqs, 10)) + ","
            loc_cSQL = loc_cSQL + " obspbrus = " + EscaparSQL(LEFT(THIS.this_cObspbrus, 10)) + ","
            loc_cSQL = loc_cSQL + " codtrans = " + EscaparSQL(LEFT(THIS.this_cCodTrans, 10)) + ","
            loc_cSQL = loc_cSQL + " fretes = " + FormatarNumeroSQL(THIS.this_nFretes, 0) + ","
            loc_cSQL = loc_cSQL + " placas = " + EscaparSQL(LEFT(THIS.this_cPlacas, 8)) + ","
            loc_cSQL = loc_cSQL + " ufplacas = " + EscaparSQL(LEFT(THIS.this_cUfPlacas, 2)) + ","
            loc_cSQL = loc_cSQL + " qtdes = " + FormatarNumeroSQL(THIS.this_nQtdes, 0) + ","
            loc_cSQL = loc_cSQL + " espes = " + EscaparSQL(LEFT(THIS.this_cEspes, 10)) + ","
            loc_cSQL = loc_cSQL + " marcas = " + EscaparSQL(LEFT(THIS.this_cMarcas, 10)) + ","
            loc_cSQL = loc_cSQL + " numeros = " + EscaparSQL(LEFT(THIS.this_cNumeros, 10)) + ","
            loc_cSQL = loc_cSQL + " pliqs = " + FormatarNumeroSQL(THIS.this_nPLiqs, 3) + ","
            loc_cSQL = loc_cSQL + " pbrus = " + FormatarNumeroSQL(THIS.this_nPBrus, 3) + ","
            loc_cSQL = loc_cSQL + " obss = " + EscaparSQL(LEFT(THIS.this_cObss, 40)) + ","
            loc_cSQL = loc_cSQL + " nfechv = " + EscaparSQL(LEFT(THIS.this_cNfechv, 44)) + ","
            loc_cSQL = loc_cSQL + " nfechvc = " + EscaparSQL(LEFT(THIS.this_cNfechvc, 44)) + ","
            loc_cSQL = loc_cSQL + " ndis = " + EscaparSQL(LEFT(THIS.this_cNdis, 10)) + ","
            loc_cSQL = loc_cSQL + " dregdis = " + FormatarDataSQL(THIS.this_dDregdis) + ","
            loc_cSQL = loc_cSQL + " ddesembs = " + FormatarDataSQL(THIS.this_dDdesembs) + ","
            loc_cSQL = loc_cSQL + " tptribsers = " + FormatarNumeroSQL(THIS.this_nTptribsers, 0) + ","
            loc_cSQL = loc_cSQL + " codbenefs = " + EscaparSQL(LEFT(THIS.this_cCodbenefs, 3)) + ","
            loc_cSQL = loc_cSQL + " codsrvfis = " + EscaparSQL(LEFT(THIS.this_cCodsrvfis, 6)) + ","
            loc_cSQL = loc_cSQL + " vdeducoes = " + FormatarNumeroSQL(THIS.this_nVdeducoes, 2) + ","
            loc_cSQL = loc_cSQL + " vdscconds = " + FormatarNumeroSQL(THIS.this_nVdscconds, 2) + ","
            loc_cSQL = loc_cSQL + " vdsciconds = " + FormatarNumeroSQL(THIS.this_nVdsciconds, 2) + ","
            loc_cSQL = loc_cSQL + " outretens = " + FormatarNumeroSQL(THIS.this_nOutretens, 2) + ","
            loc_cSQL = loc_cSQL + " issretidos = " + FormatarNumeroSQL(THIS.this_nIssretidos, 0) + ","
            loc_cSQL = loc_cSQL + " tiponfs = " + EscaparSQL(LEFT(THIS.this_cTiponfs, 2)) + ","
            loc_cSQL = loc_cSQL + " vtotiss = " + FormatarNumeroSQL(THIS.this_nVtotiss, 2) + ","
            loc_cSQL = loc_cSQL + " virf = " + FormatarNumeroSQL(THIS.this_nVirf, 2) + ","
            loc_cSQL = loc_cSQL + " vinss = " + FormatarNumeroSQL(THIS.this_nVinss, 2) + ","
            loc_cSQL = loc_cSQL + " vpis = " + FormatarNumeroSQL(THIS.this_nVpis, 2) + ","
            loc_cSQL = loc_cSQL + " vcsll = " + FormatarNumeroSQL(THIS.this_nVcsll, 2) + ","
            loc_cSQL = loc_cSQL + " vcofins = " + FormatarNumeroSQL(THIS.this_nVcofins, 2) + ","
            loc_cSQL = loc_cSQL + " cancelas = " + IIF(THIS.this_lCancelas, 1, 0) + ","
            loc_cSQL = loc_cSQL + " clfis = " + EscaparSQL(LEFT(THIS.this_cClfis, 12)) + ","
            loc_cSQL = loc_cSQL + " clifors = " + EscaparSQL(LEFT(THIS.this_cClifors, 20)) + ","
            loc_cSQL = loc_cSQL + " codcons = " + EscaparSQL(LEFT(THIS.this_cCodcons, 9)) + ","
            loc_cSQL = loc_cSQL + " conds = " + EscaparSQL(LEFT(THIS.this_cConds, 12)) + ","
            loc_cSQL = loc_cSQL + " icms = " + FormatarNumeroSQL(THIS.this_nIcms, 2) + ","
            loc_cSQL = loc_cSQL + " impress = " + FormatarNumeroSQL(THIS.this_nImpress, 0) + ","
            loc_cSQL = loc_cSQL + " ipis = " + FormatarNumeroSQL(THIS.this_nIpis, 2) + ","
            loc_cSQL = loc_cSQL + " obs2s = " + EscaparSQL(LEFT(THIS.this_cObs2s, 40)) + ","
            loc_cSQL = loc_cSQL + " operas = " + EscaparSQL(LEFT(THIS.this_cOperas, 1)) + ","
            loc_cSQL = loc_cSQL + " perciss = " + FormatarNumeroSQL(THIS.this_nPerciss, 2) + ","
            loc_cSQL = loc_cSQL + " pesos = " + FormatarNumeroSQL(THIS.this_nPesos, 2) + ","
            loc_cSQL = loc_cSQL + " regs = " + IIF(THIS.this_lRegs, 1, 0) + ","
            loc_cSQL = loc_cSQL + " vals = " + FormatarNumeroSQL(THIS.this_nVals, 2) + ","
            loc_cSQL = loc_cSQL + " vtotsers = " + FormatarNumeroSQL(THIS.this_nVtotsers, 2) + ","
            loc_cSQL = loc_cSQL + " cgcs = " + EscaparSQL(LEFT(THIS.this_cCgcs, 21)) + ","
            loc_cSQL = loc_cSQL + " correcs = " + IIF(THIS.this_lCorrecs, 1, 0) + ","
            loc_cSQL = loc_cSQL + " locals = " + EscaparSQL(LEFT(THIS.this_cLocals, 10)) + ","
            loc_cSQL = loc_cSQL + " ntrans = " + FormatarNumeroSQL(THIS.this_nNtrans, 0) + ","
            loc_cSQL = loc_cSQL + " codservs = " + EscaparSQL(LEFT(THIS.this_cCodservs, 10)) + ","
            loc_cSQL = loc_cSQL + " descservs = " + EscaparSQL(LEFT(THIS.this_cDescservs, 40)) + ","
            loc_cSQL = loc_cSQL + " chkenvias = " + FormatarNumeroSQL(THIS.this_nChkenvias, 0) + ","
            loc_cSQL = loc_cSQL + " loterps = " + FormatarNumeroSQL(THIS.this_nLoterps, 0) + ","
            loc_cSQL = loc_cSQL + " numrps = " + FormatarNumeroSQL(THIS.this_nNumrps, 0) + ","
            loc_cSQL = loc_cSQL + " pcofins = " + FormatarNumeroSQL(THIS.this_nPcofins, 2) + ","
            loc_cSQL = loc_cSQL + " pcsll = " + FormatarNumeroSQL(THIS.this_nPcsll, 2) + ","
            loc_cSQL = loc_cSQL + " pinss = " + FormatarNumeroSQL(THIS.this_nPinss, 2) + ","
            loc_cSQL = loc_cSQL + " pirf = " + FormatarNumeroSQL(THIS.this_nPirf, 2) + ","
            loc_cSQL = loc_cSQL + " ppis = " + FormatarNumeroSQL(THIS.this_nPpis, 2) + ","
            loc_cSQL = loc_cSQL + " serierps = " + EscaparSQL(LEFT(THIS.this_cSerierps, 5)) + ","
            loc_cSQL = loc_cSQL + " tiporps = " + EscaparSQL(LEFT(THIS.this_cTiporps, 5)) + ","
            loc_cSQL = loc_cSQL + " valiis = " + FormatarNumeroSQL(THIS.this_nValiis, 2) + ","
            loc_cSQL = loc_cSQL + " nfeprt = " + EscaparSQL(LEFT(THIS.this_cNfeprt, 15)) + ","
            loc_cSQL = loc_cSQL + " chnfes = " + EscaparSQL(LEFT(THIS.this_cChnfes, 44)) + ","
            loc_cSQL = loc_cSQL + " prestservs = " + EscaparSQL(LEFT(THIS.this_cPrestservs, 7)) + ","
            loc_cSQL = loc_cSQL + " vfcpst = " + FormatarNumeroSQL(THIS.this_nVfcpst, 2) + ","
            loc_cSQL = loc_cSQL + " NumeroNota = " + EscaparSQL(LEFT(THIS.this_cNumeroNota, 10)) + ","
            loc_cSQL = loc_cSQL + " chkrastreio = " + FormatarNumeroSQL(THIS.this_nChkrastreio, 0) + ","
            loc_cSQL = loc_cSQL + " chaveexterna = " + EscaparSQL(LEFT(THIS.this_cChaveExterna, 33))
            loc_cSQL = loc_cSQL + " WHERE cidchaves = " + EscaparSQL(LEFT(THIS.this_cCidchaves, 20))

            IF USED("cursor_4c_Update")
                USE IN cursor_4c_Update
            ENDIF

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Update")

            IF loc_nResult < 0
                MsgErro("Erro ao atualizar dados fiscais da nota:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ELSE
                THIS.RegistrarAuditoria("UPDATE")
                IF USED("cursor_4c_Update")
                    USE IN cursor_4c_Update
                ENDIF
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro em sigopfisBO.Atualizar")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

ENDDEFINE

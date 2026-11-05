*==============================================================================
* sigopftcBO.prg
*
* Business Object para sigopftc (Ficha de Complementos da Movimentacao)
* Dialogo filho MODAL, aberto por um form de movimentacao/pedido para
* coletar as respostas da "ficha tecnica" (caracteristicas) associadas a
* uma Operacao (SigCdOpe.Dopes), para o cliente corrente (crSigCdCli).
*
* O legado monta dinamicamente um campo por caracteristica cadastrada em
* SigCdFtc para a Operacao informada (join com SigOpFtc para a resposta
* padrao da operacao e com SigPrCpP para a descricao da pergunta), exibe
* esses campos num container com scroll (frmbarcta) e, ao confirmar, grava
* a resposta de cada caracteristica em SIGCDCET (chave: cidchaves; chave de
* negocio: IClis+CCars+CTits) num SCAN com Locate + Insert condicional -
* nao ha Update nem Delete no fluxo legado (MontaFichaTecnica/
* GravarFichaTecnica no Formsigopftc.prg).
*
* Nao ha, portanto, um unico registro "principal" no sentido de
* BusinessBase.Inserir()/Atualizar(): a persistencia real percorre o
* cursor de caracteristicas linha a linha. this_cTabela/this_cCampoChave
* abaixo documentam o alvo efetivo da gravacao (SIGCDCET/cidchaves), que
* e usado pelo metodo de gravacao em lote Formsigopftc.GravarFichaTecnica,
* que para cada linha chama NovoRegistro() + FormParaBO() + Salvar().
*==============================================================================

DEFINE CLASS sigopftcBO AS BusinessBase

    *-- Contexto recebido do form pai (Init legado: Lparameters pCnx, pcTipo,
    *-- pcDopes). pCnx (poDataMgr) nao e replicado aqui - o BO usa o handle
    *-- global gnConnHandle, como toda a nova arquitetura.
    this_cTipoAcao      = ""    && char - pcEscolha herdado do form pai (INSERIR/ALTERAR/CONSULTAR/PROCURAR)
    this_cOperacao      = ""    && char(20) - Dopes: codigo da Operacao (SigCdOpe.Dopes) cujas caracteristicas sao exibidas

    *-- Cliente ao qual a ficha pertence (equivalente a crSigCdCli no legado,
    *-- cursor global do form pai - aqui replicado como property porque o BO
    *-- precisa dele para montar a chave de SIGCDCET)
    this_cIclis         = ""    && char(10) - codigo do cliente (SigCdCli.IClis)

    *-- Linha corrente da caracteristica sendo exibida/respondida, espelhando
    *-- o cursor crTmpFicha (SigCdFtc + SigOpFtc + SigPrCpP) montado em
    *-- MontaFichaTecnica no legado
    this_cCcars         = ""    && char(20) - codigo da caracteristica (SigCdFtc.CCars)
    this_cCtits         = ""    && char(20) - codigo do titulo/pergunta (SigCdFtc.CTits)
    this_nClins         = 0     && numeric(2,0) - numero de linhas do campo de resposta (SigCdFtc.CLins)
    this_nCords         = 0     && numeric(3,0) - ordem de exibicao da caracteristica (SigCdFtc.COrds)
    this_nMaxs          = 0     && numeric(3,0) - tamanho maximo aceito na resposta (SigCdFtc.Maxs)
    this_nMins          = 0     && numeric(3,0) - tamanho minimo obrigatorio da resposta (SigCdFtc.Mins)
    this_cSgrus         = ""    && char(6)  - subgrupo da caracteristica (SigCdFtc.SGrus)
    this_cSelecaos      = ""    && char(1)  - "S" = pergunta com opcoes fixas de selecao (SigCdFtc.cSelecaos)
    this_nChkCxas       = 0     && numeric(1,0) - tipo de caixa de selecao da pergunta (SigCdFtc.nChkCxas)
    this_cTpDados       = ""    && char(1)  - tipo de dado da resposta: "D" = data, outro = texto (SigCdFtc.cTpDados)
    this_cDescrs        = ""    && char(40) - descricao da pergunta (SigPrCpP.Descrs, quando cadastrada)

    *-- Resposta da caracteristica corrente: SIGCDCET guarda a resposta do
    *-- cliente (gravada por GravaFichaTecnica), SigOpFtc guarda a resposta
    *-- padrao/ja existente da Operacao (lida no Join de MontaFichaTecnica)
    this_cResps         = ""    && memo/char - resposta digitada pelo usuario (SIGCDCET.Resps / SigOpFtc.Resps)
    this_cClicartits    = ""    && char(50) - chave concatenada IClis+CCars+CTits (SIGCDCET.CliCarTits)
    this_cCidchaves     = ""    && char(20) - chave unica do registro de resposta (SIGCDCET.cIdChaves), gerada por fUniqueIds() na gravacao

    *--------------------------------------------------------------------------
    * Init - Inicializa Business Object.
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        DODEFAULT()

        *-- Alvo real da gravacao em lote (Formsigopftc.GravarFichaTecnica).
        *-- Nao existe Inserir()/Atualizar() de registro unico neste BO: a
        *-- gravacao percorre o cursor de caracteristicas e insere em
        *-- SIGCDCET apenas as respostas nao vazias ainda nao cadastradas
        *-- para o cliente (mesmo criterio do legado Gravafichatecnica()).
        THIS.this_cTabela     = "SigCdCet"
        THIS.this_cCampoChave = "cidchaves"

        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Chave primaria da resposta corrente (SIGCDCET.cidchaves)
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION ObterChavePrimaria()
        RETURN ALLTRIM(THIS.this_cCidchaves)
    ENDFUNC

    *--------------------------------------------------------------------------
    * MontarClicartits - Monta a chave POSICIONAL CliCarTits (IClis+CCars+CTits)
    *
    * SIGCDCET.clicartits char(50) = iclis char(10) + ccars char(20) +
    * ctits char(20). O legado concatena os valores das COLUNAS da tabela
    * (ja padded pelo SQL Server), nunca ALLTRIM das partes - regra da chave
    * posicional: ALLTRIM no meio da concatenacao quebra o casamento contra
    * o que esta gravado (ver CLAUDE.md regra #42 / MontarChaveEmpDopNums).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE MontarClicartits()
        THIS.this_cClicartits = PADR(ALLTRIM(THIS.this_cIclis), 10) + ;
                                 PADR(ALLTRIM(THIS.this_cCcars), 20) + ;
                                 PADR(ALLTRIM(THIS.this_cCtits), 20)
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Carrega as propriedades da resposta a partir de um
    * cursor SELECT * FROM SigCdCet (uma resposta JA gravada do cliente).
    * NAO serve para cursor_4c_Ficha, que nao tem cidchaves/clicartits - a
    * leitura daquele cursor eh Formsigopftc.CarregarLinhaFichaNoBO.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF USED(par_cAliasCursor)
                SELECT (par_cAliasCursor)
                THIS.this_cCidchaves  = TratarNulo(cidchaves,  "")
                THIS.this_cIclis      = TratarNulo(iclis,      "")
                THIS.this_cCcars      = TratarNulo(ccars,      "")
                THIS.this_cCtits      = TratarNulo(ctits,      "")
                THIS.this_cClicartits = TratarNulo(clicartits, "")
                THIS.this_cResps      = TratarNulo(resps,      "")
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao carregar resposta da ficha t" + CHR(233) + "cnica:" + CHR(13) + loc_oErro.Message, "sigopftcBO.CarregarDoCursor")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir - INSERT de uma resposta de caracteristica em SIGCDCET
    *
    * Equivalente ao "Insert Into crSigCdCeT (...)" de GravaFichaTecnica no
    * legado (Formsigopftc.GravarFichaTecnica chama via Salvar(), uma vez por caracteristica
    * respondida, so quando a LOCATE por IClis+CCars+CTits nao achou linha -
    * o legado NUNCA sobrescreve uma resposta ja gravada, so inclui a que
    * falta). cidchaves gerado por fUniqueIds() (regra #22 - chave Fortyus,
    * nunca string vazia) no lugar do NewIdChave() legado.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Inserir()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            THIS.this_cCidchaves = LEFT(fUniqueIds(), 20)
            THIS.MontarClicartits()

            TEXT TO loc_cSQL TEXTMERGE NOSHOW
                INSERT INTO SigCdCet (iclis, ccars, ctits, resps, clicartits, cidchaves)
                VALUES (
                    <<EscaparSQL(LEFT(ALLTRIM(THIS.this_cIclis), 10))>>,
                    <<EscaparSQL(LEFT(ALLTRIM(THIS.this_cCcars), 20))>>,
                    <<EscaparSQL(LEFT(ALLTRIM(THIS.this_cCtits), 20))>>,
                    <<EscaparSQL(THIS.this_cResps)>>,
                    <<EscaparSQL(THIS.this_cClicartits)>>,
                    <<EscaparSQL(THIS.this_cCidchaves)>>
                )
            ENDTEXT

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("INSERT")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao inserir resposta da ficha t" + CHR(233) + "cnica:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao inserir resposta da ficha t" + CHR(233) + "cnica:" + CHR(13) + loc_oErro.Message, "sigopftcBO.Inserir")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - UPDATE da resposta em SIGCDCET, identificada por cidchaves
    *
    * O fluxo legado (GravaFichaTecnica) NUNCA atualiza uma resposta ja
    * gravada - a LOCATE por IClis+CCars+CTits so insere quando nao acha.
    * Este metodo existe pela convencao de BusinessBase (toda subclasse
    * expoe Inserir/Atualizar) e fica disponivel para uma correcao pontual
    * de resposta via cidchaves, sem alterar a chave de negocio.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Atualizar()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            TEXT TO loc_cSQL TEXTMERGE NOSHOW
                UPDATE SigCdCet
                SET resps      = <<EscaparSQL(THIS.this_cResps)>>,
                    iclis      = <<EscaparSQL(LEFT(ALLTRIM(THIS.this_cIclis), 10))>>,
                    ccars      = <<EscaparSQL(LEFT(ALLTRIM(THIS.this_cCcars), 20))>>,
                    ctits      = <<EscaparSQL(LEFT(ALLTRIM(THIS.this_cCtits), 20))>>,
                    clicartits = <<EscaparSQL(THIS.this_cClicartits)>>
                WHERE cidchaves = <<EscaparSQL(THIS.this_cCidchaves)>>
            ENDTEXT

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("UPDATE")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao atualizar resposta da ficha t" + CHR(233) + "cnica:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao atualizar resposta da ficha t" + CHR(233) + "cnica:" + CHR(13) + loc_oErro.Message, "sigopftcBO.Atualizar")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

ENDDEFINE

*============================================================================
* SigPrMluBO.prg - Business Object para Unificacao de Mala Direta (SIGPRMLU)
*
* Form OPERACIONAL (SIGPRMLU / FormSigPrMlu): lista as malas diretas
* cadastradas (SigMlItn, grid com checkbox de selecao), permite ao usuario
* marcar duas ou mais e "Processar" a unificacao delas numa mala NOVA:
*   - gera um codigo novo (equivalente a Substr(Sys(2015),3,10) do legado)
*   - duplica, deduplicando por chave logica (Desti+Ceps+Endes+Nums+Compls),
*     os registros de SigMlCab (Where Codigos = <malaSelecionada>) na mala
*     nova
*   - insere o cabecalho da mala nova em SigMlItn (Codigos/Descs/Ativos/
*     UsuIns/DatIns/NRegis/Espelhos/Unificas)
*
* this_cTabela/this_cCampoChave apontam para SigMlItn (cabecalho da mala,
* entidade listada na grade principal do form - equivalente ao
* AddCursor('SigMlItn', 'Codigos', 'crSigMlItn', ...) do Init legado).
* SigMlCab (registros/clientes dentro de cada mala, PK cidchaves) e
* manipulada em bloco durante o Processamento (Fase 2+), sem mapeamento
* propriedade-a-propriedade, pois o legado faz Select * / Scatter Memvar /
* Gather Memvar (copia integral do registro, nao campo a campo).
*
* Herda de: BusinessBase
* Criado em: Fase 1 - Propriedades e Init
*============================================================================

DEFINE CLASS SigPrMluBO AS BusinessBase

    *==========================================================================
    * Propriedades de registro - espelham as colunas de SigMlItn (docs/
    * schema.sql) efetivamente usadas pelo SIGPRMLU.scx (cabecalho da mala
    * direta exibido na grade e gravado ao final da unificacao). As demais
    * colunas de SigMlItn (filtros de geracao da mala: anivfs/cepfs/faixafs/
    * opsexs/etc.) pertencem ao cadastro de Mala Direta (outro form) e NAO
    * sao tocadas por SIGPRMLU - nao sao declaradas aqui.
    *==========================================================================
    this_cCodigos    = SPACE(10)  && SigMlItn.codigos  - char(10) NOT NULL (PK) - grdselecoes.Column2
    this_cDescs      = SPACE(30)  && SigMlItn.descs    - char(30) NOT NULL - grdselecoes.Column3 / nome da unificacao
    this_lAtivos     = .F.        && SigMlItn.ativos   - bit NOT NULL - sempre .T. na mala resultante da unificacao
    this_cUsuIns     = SPACE(10)  && SigMlItn.usuins   - char(10) NOT NULL - grdselecoes.Column4 (Usuar do legado)
    this_dDatIns     = {}         && SigMlItn.datins   - datetime NULL - grdselecoes.Column5 (DateTime() na gravacao)
    this_dDatAlts    = {}         && SigMlItn.datalts  - datetime NULL - nao gravado por este form (.NULL. no Insert legado)
    this_dUlts       = {}         && SigMlItn.ults     - datetime NULL - nao gravado por este form (.NULL. no Insert legado)
    this_dDtEnts     = {}         && SigMlItn.dtents   - datetime NULL - nao gravado por este form (.NULL. no Insert legado)
    this_nNRegis     = 0          && SigMlItn.nregis   - numeric(8,0) NOT NULL - grdselecoes.Column6 (Reccount da mala unificada)
    this_cEspelhos   = SPACE(8)   && SigMlItn.espelhos - char(8) NOT NULL - origem fixa 'SigPrMlu' (Insert legado)
    this_cUnificas   = ""         && SigMlItn.unificas - text NULL - lista "codigo1; codigo2; " das malas de origem

    *==========================================================================
    * Estado de processamento - nao sao colunas persistidas isoladamente;
    * controlam a unificacao (Processamento() legado) e espelham o estado da
    * tela (txt_4c_Nova/getNova e os resultados intermediarios do calculo)
    *==========================================================================
    this_cNomeUnificacao        = SPACE(20)  && cntNova.getNova.Value - MaxLength=20 no SCX legado
    this_cCodigoGerado          = SPACE(10)  && lcNew  - Substr(Sys(2015),3,10), codigo da mala resultante
    this_nTotalRegistrosOrigem  = 0          && lnTot  - soma de Reccount('crTmp') de cada mala selecionada
    this_cCodigosSelecionados   = ""         && lcUni  - "codigo1; codigo2; " das malas marcadas (SelImp = 1)
    this_nTotalMalasSelecionadas = 0         && Reccount('csMalasSelecionadas') - quantidade de malas marcadas

    *==========================================================================
    * Init - Inicializa o Business Object configurando a tabela/chave
    * primaria de referencia (SigMlItn/codigos - equivalente ao AddCursor(
    * 'SigMlItn', 'Codigos', 'crSigMlItn', ...) do Init legado, que define
    * qual entidade a grade principal do form lista e processa)
    *==========================================================================
    PROCEDURE Init()
        LOCAL loc_lResultado, loc_oErro
        loc_lResultado = .F.

        TRY
            DODEFAULT()
            THIS.this_cTabela     = "SigMlItn"
            THIS.this_cCampoChave = "codigos"

            loc_lResultado = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * CarregarDoCursor - Mapeia as colunas do cursor (crSigMlItn, populado via
    * SQLEXEC/AddCursor equivalente) para as propriedades this_* deste BO.
    *==========================================================================
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        IF USED(par_cAliasCursor)
            SELECT (par_cAliasCursor)

            THIS.this_cCodigos  = TratarNulo(codigos, "")
            THIS.this_cDescs    = TratarNulo(descs, "")
            IF VARTYPE(ativos) = "L"
                THIS.this_lAtivos = TratarNulo(ativos, .F.)
            ELSE
                THIS.this_lAtivos = (TratarNulo(ativos, 0) = 1)
            ENDIF
            THIS.this_cUsuIns   = TratarNulo(usuins, "")
            THIS.this_dDatIns   = TratarNulo(datins, {})
            THIS.this_dDatAlts  = TratarNulo(datalts, {})
            THIS.this_dUlts     = TratarNulo(ults, {})
            THIS.this_dDtEnts   = TratarNulo(dtents, {})
            THIS.this_nNRegis   = TratarNulo(nregis, 0)
            THIS.this_cEspelhos = TratarNulo(espelhos, "")
            THIS.this_cUnificas = TratarNulo(unificas, "")

            loc_lSucesso = .T.
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * Inserir - INSERT do cabecalho da mala direta unificada em SigMlItn
    * (equivalente ao "Insert Into crSigMlItn (Codigos, Descs, Ativos, UsuIns,
    * DatIns, DatAlts, Ults, DtEnts, NRegis, Espelhos, Unificas) Values (...)"
    * do Processamento legado).
    *
    * SigMlItn tem dezenas de colunas NOT NULL sem DEFAULT que pertencem aos
    * FILTROS de geracao de mala direta (cadastro de Mala Direta - outro form)
    * e NUNCA sao tocadas pelo SIGPRMLU. O legado grava o registro INTEIRO
    * (AddCursor sem query = Select * + Gather Memvar/TableUpdate), entao essas
    * colunas vao em branco/zero junto das que a tela de fato edita. A lista
    * abaixo vem do docs/schema.sql (regra #22 do CLAUDE.md - a lista de
    * colunas NOT NULL vem do SCHEMA, nunca do dump do legado).
    *==========================================================================
    PROCEDURE Inserir()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso, loc_oErro, loc_cIdChaves
        loc_lSucesso = .F.

        TRY
            IF EMPTY(ALLTRIM(THIS.this_cCodigos))
                THIS.this_cCodigoGerado = PADR(SUBSTR(SYS(2015), 3, 10), 10)
                THIS.this_cCodigos      = THIS.this_cCodigoGerado
            ENDIF

            IF EMPTY(ALLTRIM(THIS.this_cUsuIns))
                THIS.this_cUsuIns = gc_4c_UsuarioLogado
            ENDIF

            IF EMPTY(ALLTRIM(THIS.this_cEspelhos))
                THIS.this_cEspelhos = "SigPrMlu"
            ENDIF

            * Legado grava Ativos = .t. incondicionalmente na mala resultante
            THIS.this_lAtivos = .T.

            loc_cIdChaves = fUniqueIds()

            loc_cSQL = "INSERT INTO SigMlItn (" + ;
                "anivfs, anivis, ativos, cadas, cemps, cepfs, cepis, cidades, " + ;
                "ckanis, ckcads, ckceps, ckcids, ckemps, ckests, ckfnoms, cknomes, " + ;
                "ckprofs, ckrsocs, cksexs, ckults, codigos, datins, demps, descs, " + ;
                "destis, espelhos, ests, faixafs, faixais, nomes, nregis, opsexs, " + ;
                "optceps, optnrs, optults, profs, rsocs, usualts, usuins, ckclass, " + ;
                "cksituas, classifis, classifss, situas, ckregis, cksitua, opsitua, regifs, " + ;
                "regiis, situa, linhas, ckcivils, opanis, ckdtents, cklinhas, tabufs, " + ;
                "opcivis, bairs, ckbairs, estados, unificas, ckvends, vends, cidchaves, " + ;
                "ckidade, idadefs, idadeis, opidade, cparents, ckdtatus, opendes, cktlmk, " + ;
                "optlmk, ckncomp, ckultcom, ckpais, paises, ckmov, dopes, endigual, " + ;
                "valosf, valosi, ckconjuge, conjuge, ckpubls, cksegs, fpubls, codsegs" + ;
                ") VALUES (" + ;
                EscaparSQL("") + ", " + EscaparSQL("") + ", " + IIF(THIS.this_lAtivos, "1", "0") + ", " + ;
                    EscaparSQL("") + ", " + EscaparSQL("") + ", " + EscaparSQL("") + ", " + ;
                    EscaparSQL("") + ", " + EscaparSQL("") + ", " + ;
                "0, 0, 0, 0, 0, 0, 0, 0, " + ;
                "0, 0, 0, 0, " + ;
                    EscaparSQL(PADR(ALLTRIM(THIS.this_cCodigos), 10)) + ", " + ;
                    FormatarDataSQL(IIF(EMPTY(THIS.this_dDatIns), DATETIME(), THIS.this_dDatIns)) + ", " + ;
                    EscaparSQL("") + ", " + ;
                    EscaparSQL(PADR(ALLTRIM(THIS.this_cDescs), 30)) + ", " + ;
                "0, " + EscaparSQL(PADR(ALLTRIM(THIS.this_cEspelhos), 8)) + ", " + ;
                    EscaparSQL("") + ", " + EscaparSQL("") + ", " + EscaparSQL("") + ", " + EscaparSQL("") + ", " + ;
                    FormatarNumeroSQL(THIS.this_nNRegis, 0) + ", 0, " + ;
                "0, 0, 0, " + EscaparSQL("") + ", " + EscaparSQL("") + ", " + ;
                    EscaparSQL(PADR(ALLTRIM(gc_4c_UsuarioLogado), 10)) + ", " + ;
                    EscaparSQL(PADR(ALLTRIM(THIS.this_cUsuIns), 10)) + ", 0, " + ;
                "0, " + EscaparSQL("") + ", " + EscaparSQL("") + ", 0, 0, 0, 0, " + EscaparSQL("") + ", " + ;
                EscaparSQL("") + ", " + EscaparSQL("") + ", " + EscaparSQL("") + ", 0, 0, 0, 0, " + EscaparSQL("") + ", " + ;
                "0, " + EscaparSQL("") + ", 0, " + EscaparSQL("") + ", " + ;
                    EscaparSQL(NVL(THIS.this_cUnificas, "")) + ", 0, " + EscaparSQL("") + ", " + ;
                    EscaparSQL(LEFT(loc_cIdChaves, 20)) + ", " + ;
                "0, 0, 0, 0, " + EscaparSQL("") + ", 0, 0, 0, " + ;
                "0, 0, 0, 0, " + EscaparSQL("") + ", 0, " + EscaparSQL("") + ", 0, " + ;
                FormatarNumeroSQL(0, 2) + ", " + FormatarNumeroSQL(0, 2) + ", 0, " + EscaparSQL("") + ", 0, 0, " + ;
                    EscaparSQL("") + ", " + EscaparSQL("") + ;
                ")"

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("INSERT")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao inserir mala direta unificada:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao inserir mala direta unificada:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * Atualizar - UPDATE do cabecalho da mala direta em SigMlItn (apenas as
    * colunas que este form mantem - as demais colunas NOT NULL de SigMlItn
    * pertencem ao cadastro de Mala Direta e nao sao alteradas aqui)
    *==========================================================================
    PROCEDURE Atualizar()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        TRY
            IF EMPTY(ALLTRIM(THIS.this_cCodigos))
                MsgAviso("C" + CHR(243) + "digo n" + CHR(227) + "o definido para atualiza" + ;
                    CHR(231) + CHR(227) + "o", "SigPrMluBO.Atualizar")
            ELSE
                loc_cSQL = "UPDATE SigMlItn SET " + ;
                    "descs = "    + EscaparSQL(PADR(ALLTRIM(THIS.this_cDescs), 30)) + ", " + ;
                    "ativos = "   + IIF(THIS.this_lAtivos, "1", "0") + ", " + ;
                    "nregis = "   + FormatarNumeroSQL(THIS.this_nNRegis, 0) + ", " + ;
                    "unificas = " + EscaparSQL(NVL(THIS.this_cUnificas, "")) + ", " + ;
                    "usualts = "  + EscaparSQL(PADR(ALLTRIM(gc_4c_UsuarioLogado), 10)) + ", " + ;
                    "datalts = GETDATE() " + ;
                    "WHERE codigos = " + EscaparSQL(PADR(ALLTRIM(THIS.this_cCodigos), 10))

                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
                IF loc_nResultado >= 0
                    THIS.RegistrarAuditoria("UPDATE")
                    loc_lSucesso = .T.
                ELSE
                    MsgErro("Erro ao atualizar mala direta:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao atualizar mala direta:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * LimparDados - Zera as properties deste BO. Sobrescreve o stub da
    * BusinessBase (que limpa apenas this_cMensagemErro) porque este form NAO
    * eh modal-por-registro como o legado: ele fica aberto e o usuario pode
    * fazer uma unificacao depois da outra. Sem o reset, o estado da anterior
    * (nome, codigo gerado, totais e a lista de malas de origem) sobrevive na
    * instancia e qualquer caminho que deixe de reatribuir uma dessas
    * properties gravaria o valor da unificacao PASSADA - o mesmo risco de
    * ciclo de vida da regra #32 do CLAUDE.md.
    *
    * PUBLIC (sem modificador) obrigatoriamente: LimparDados eh PUBLIC na
    * BusinessBase, o Form a chama de fora em LimparCampos, e VFP9 nao permite
    * REDUZIR o escopo sem quebrar o chamador (regra #51).
    *==========================================================================
    PROCEDURE LimparDados()
        DODEFAULT()

        *-- Colunas de SigMlItn mantidas por este form
        THIS.this_cCodigos  = SPACE(10)
        THIS.this_cDescs    = SPACE(30)
        THIS.this_lAtivos   = .F.
        THIS.this_cUsuIns   = SPACE(10)
        THIS.this_dDatIns   = {}
        THIS.this_dDatAlts  = {}
        THIS.this_dUlts     = {}
        THIS.this_dDtEnts   = {}
        THIS.this_nNRegis   = 0
        THIS.this_cEspelhos = SPACE(8)
        THIS.this_cUnificas = ""

        *-- Estado de processamento (espelho da tela e resultados do calculo)
        THIS.this_cNomeUnificacao          = SPACE(20)
        THIS.this_cCodigoGerado            = SPACE(10)
        THIS.this_nTotalRegistrosOrigem    = 0
        THIS.this_cCodigosSelecionados     = ""
        THIS.this_nTotalMalasSelecionadas  = 0

        RETURN .T.
    ENDPROC

    *==========================================================================
    * ObterChavePrimaria - Retorna o codigo (char(10), PK de SigMlItn) do
    * registro atual
    *==========================================================================
    PROTECTED PROCEDURE ObterChavePrimaria()
        RETURN ALLTRIM(THIS.this_cCodigos)
    ENDPROC

ENDDEFINE

*==============================================================================
* SigOpIpEBO.PRG
* Business Object para Impressao/Reimpressao de Etiquetas (SIGOPIPE)
*
* Tabela Principal: SigMvIts (itens de movimento com codigo de barras/cor/tamanho)
*                    char(3) emps, char(20) dopes, numeric(6,0) numes,
*                    char(14) cpros, char(4) codtams/codcors, numeric(14,0) codbarras
*                    PK: cidchaves char(20)
*
* Origem: form legado SIGOPIPE monta um cursor local de etiquetas selecionadas
* (DbEtiqueta, a partir de SigOpEtq) e, ao confirmar a opcao "Impressao Imediata"
* com geracao de operacao, grava um movimento em SigMvCab/SigMvItn/SigMvIts.
* Este BO cobre a persistencia em SigMvIts (o item de movimento com o codigo
* de barras/cor/tamanho da etiqueta impressa).
*==============================================================================

DEFINE CLASS SigOpIpEBO AS BusinessBase

    *-- Propriedades da entidade (SigMvIts)
    this_nCitens       = 0    && citens       numeric(4,0)  - Numero sequencial do item
    this_cEmps         = ""   && emps         char(3)       - Codigo da empresa
    this_cDopes        = ""   && dopes        char(20)      - Codigo da operacao
    this_nNumes        = 0    && numes        numeric(6,0)  - Numero do movimento
    this_cCpros        = ""   && cpros        char(14)      - Codigo do produto
    this_cCodembs      = ""   && codembs      char(3)       - Codigo da embalagem
    this_cCodtams      = ""   && codtams      char(4)       - Codigo do tamanho
    this_cCodcors      = ""   && codcors      char(4)       - Codigo da cor
    this_nQtds         = 0    && qtds         numeric(9,3)  - Quantidade
    this_nAqtds        = 0    && aqtds        numeric(9,3)  - Quantidade anterior
    this_nQtdembs      = 0    && qtdembs      numeric(5,1)  - Quantidade por embalagem
    this_nAqtdembs     = 0    && aqtdembs     numeric(5,1)  - Quantidade por embalagem anterior
    this_nQtbaixas     = 0    && qtbaixas     numeric(9,3)  - Quantidade baixada
    this_nPrembs       = 0    && prembs       numeric(9,3)  - Peso da embalagem
    this_cCodembents   = ""   && codembents   char(3)       - Codigo da embalagem de entrada
    this_nQtdents      = 0    && qtdents      numeric(9,3)  - Quantidade de entrada
    this_nCodbarras    = 0    && codbarras    numeric(14,0) - Codigo de barras da etiqueta
    this_nPesos        = 0    && pesos        numeric(9,3)  - Peso
    this_nQtbxprods    = 0    && qtbxprods    numeric(9,3)  - Quantidade baixada do produto
    this_nQtprods      = 0    && qtprods      numeric(9,3)  - Quantidade do produto
    this_dDatatrans    = {}   && datatrans    datetime NULL - Data da transferencia
    this_cLocals       = ""   && locals       char(10)      - Local
    this_nNtrans       = 0    && ntrans       numeric(6,0)  - Numero da transferencia
    this_nQtreservas   = 0    && qtreservas   numeric(9,3)  - Quantidade reservada
    this_cCidchaves    = ""   && cidchaves    char(20)      - Chave unica (PK)
    this_cEmpdopnums   = ""   && empdopnums   char(29)      - Chave composta emps+dopes+numes
    this_lChksubn      = .F.  && chksubn      bit           - Checksum/flag de substituicao
    this_nCompris      = 0    && compris      numeric(6,2)  - Comprimento
    this_dDtalts       = {}   && dtalts       datetime NULL - Data da ultima alteracao
    this_cChaveexterna = ""   && chaveexterna char(33)      - Chave externa de integracao

    *====================================================================
    * Init - Inicializa Business Object
    *====================================================================
    PROCEDURE Init()
        DODEFAULT()

        THIS.this_cTabela     = "SigMvIts"
        THIS.this_cCampoChave = "cidchaves"

        RETURN .T.
    ENDPROC

    *====================================================================
    * CarregarDoCursor - Mapeia TODAS as colunas de SigMvIts a partir do
    * registro corrente do cursor informado (cursor_4c_Dados ou outro
    * alias com a mesma estrutura, ex. retorno de CarregarPorCodigo)
    *====================================================================
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lResultado
        loc_lResultado = .F.

        TRY
            IF USED(par_cAliasCursor)
                SELECT (par_cAliasCursor)
                IF !EOF()
                    THIS.this_nCitens       = TratarNulo(citens,       0)
                    THIS.this_cEmps         = TratarNulo(emps,         "")
                    THIS.this_cDopes        = TratarNulo(dopes,        "")
                    THIS.this_nNumes        = TratarNulo(numes,        0)
                    THIS.this_cCpros        = TratarNulo(cpros,        "")
                    THIS.this_cCodembs      = TratarNulo(codembs,      "")
                    THIS.this_cCodtams      = TratarNulo(codtams,      "")
                    THIS.this_cCodcors      = TratarNulo(codcors,      "")
                    THIS.this_nQtds         = TratarNulo(qtds,         0)
                    THIS.this_nAqtds        = TratarNulo(aqtds,        0)
                    THIS.this_nQtdembs      = TratarNulo(qtdembs,      0)
                    THIS.this_nAqtdembs     = TratarNulo(aqtdembs,     0)
                    THIS.this_nQtbaixas     = TratarNulo(qtbaixas,     0)
                    THIS.this_nPrembs       = TratarNulo(prembs,       0)
                    THIS.this_cCodembents   = TratarNulo(codembents,   "")
                    THIS.this_nQtdents      = TratarNulo(qtdents,      0)
                    THIS.this_nCodbarras    = TratarNulo(codbarras,    0)
                    THIS.this_nPesos        = TratarNulo(pesos,        0)
                    THIS.this_nQtbxprods    = TratarNulo(qtbxprods,    0)
                    THIS.this_nQtprods      = TratarNulo(qtprods,      0)
                    THIS.this_dDatatrans    = ConverterParaData(TratarNulo(datatrans, {}))
                    THIS.this_cLocals       = TratarNulo(locals,       "")
                    THIS.this_nNtrans       = TratarNulo(ntrans,       0)
                    THIS.this_nQtreservas   = TratarNulo(qtreservas,   0)
                    THIS.this_cCidchaves    = TratarNulo(cidchaves,    "")
                    THIS.this_cEmpdopnums   = TratarNulo(empdopnums,   "")
                    THIS.this_lChksubn      = ConverterParaLogico(chksubn)
                    THIS.this_nCompris      = TratarNulo(compris,      0)
                    THIS.this_dDtalts       = ConverterParaData(TratarNulo(dtalts, {}))
                    THIS.this_cChaveexterna = TratarNulo(chaveexterna, "")

                    loc_lResultado = .T.
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *====================================================================
    * MontarChaveEmpDopNums - Chave POSICIONAL Emps+Dopes+Str(Numes,6)
    * (char(3) + char(20) + str(6) = char(29), igual a coluna EmpDopNums).
    * PADR explicito em cada parte - o padding FAZ PARTE da chave (NUNCA
    * ALLTRIM nas partes internas, so na chave inteira se preciso).
    *====================================================================
    FUNCTION MontarChaveEmpDopNums(par_cEmps, par_cDopes, par_nNumes)
        RETURN PADR(TratarNulo(par_cEmps, ""), 3) + ;
               PADR(TratarNulo(par_cDopes, ""), 20) + ;
               STR(TratarNulo(par_nNumes, 0), 6)
    ENDPROC

    *====================================================================
    * ObterChavePrimaria - Chave primaria real da tabela (cidchaves)
    *====================================================================
    PROTECTED PROCEDURE ObterChavePrimaria()
        RETURN ALLTRIM(THIS.this_cCidchaves)
    ENDPROC

    *====================================================================
    * Inserir - INSERT INTO SigMvIts (PROTECTED, chamado por Salvar())
    * Gera cidchaves via fUniqueIds() quando ainda nao preenchida (chave
    * unica Fortyus, regra CLAUDE.md #22 - NUNCA deixar em branco, senao
    * o 2o registro colide no indice unico) e recalcula empdopnums a
    * partir de Emps+Dopes+Numes (regra CLAUDE.md #42).
    *====================================================================
    PROTECTED PROCEDURE Inserir()
        LOCAL loc_cSQL, loc_nResultado, loc_lResultado
        loc_lResultado = .F.

        TRY
            IF EMPTY(ALLTRIM(THIS.this_cCidchaves))
                THIS.this_cCidchaves = LEFT(fUniqueIds(), 20)
            ENDIF

            THIS.this_cEmpdopnums = THIS.MontarChaveEmpDopNums(THIS.this_cEmps, THIS.this_cDopes, THIS.this_nNumes)

            loc_cSQL = "INSERT INTO SigMvIts (citens, emps, dopes, numes, cpros, codembs, " + ;
                       "codtams, codcors, qtds, aqtds, qtdembs, aqtdembs, qtbaixas, prembs, " + ;
                       "codembents, qtdents, codbarras, pesos, qtbxprods, qtprods, datatrans, " + ;
                       "locals, ntrans, qtreservas, cidchaves, empdopnums, chksubn, compris, " + ;
                       "dtalts, chaveexterna) VALUES (" + ;
                       FormatarNumeroSQL(THIS.this_nCitens, 0) + ", " + ;
                       EscaparSQL(PADR(THIS.this_cEmps, 3)) + ", " + ;
                       EscaparSQL(PADR(THIS.this_cDopes, 20)) + ", " + ;
                       FormatarNumeroSQL(THIS.this_nNumes, 0) + ", " + ;
                       EscaparSQL(LEFT(THIS.this_cCpros, 14)) + ", " + ;
                       EscaparSQL(LEFT(THIS.this_cCodembs, 3)) + ", " + ;
                       EscaparSQL(LEFT(THIS.this_cCodtams, 4)) + ", " + ;
                       EscaparSQL(LEFT(THIS.this_cCodcors, 4)) + ", " + ;
                       FormatarNumeroSQL(THIS.this_nQtds, 3) + ", " + ;
                       FormatarNumeroSQL(THIS.this_nAqtds, 3) + ", " + ;
                       FormatarNumeroSQL(THIS.this_nQtdembs, 1) + ", " + ;
                       FormatarNumeroSQL(THIS.this_nAqtdembs, 1) + ", " + ;
                       FormatarNumeroSQL(THIS.this_nQtbaixas, 3) + ", " + ;
                       FormatarNumeroSQL(THIS.this_nPrembs, 3) + ", " + ;
                       EscaparSQL(LEFT(THIS.this_cCodembents, 3)) + ", " + ;
                       FormatarNumeroSQL(THIS.this_nQtdents, 3) + ", " + ;
                       FormatarNumeroSQL(THIS.this_nCodbarras, 0) + ", " + ;
                       FormatarNumeroSQL(THIS.this_nPesos, 3) + ", " + ;
                       FormatarNumeroSQL(THIS.this_nQtbxprods, 3) + ", " + ;
                       FormatarNumeroSQL(THIS.this_nQtprods, 3) + ", " + ;
                       FormatarDataSQL(THIS.this_dDatatrans) + ", " + ;
                       EscaparSQL(LEFT(THIS.this_cLocals, 10)) + ", " + ;
                       FormatarNumeroSQL(THIS.this_nNtrans, 0) + ", " + ;
                       FormatarNumeroSQL(THIS.this_nQtreservas, 3) + ", " + ;
                       EscaparSQL(LEFT(THIS.this_cCidchaves, 20)) + ", " + ;
                       EscaparSQL(LEFT(THIS.this_cEmpdopnums, 29)) + ", " + ;
                       FormatarNumeroSQL(IIF(THIS.this_lChksubn, 1, 0), 0) + ", " + ;
                       FormatarNumeroSQL(THIS.this_nCompris, 2) + ", " + ;
                       FormatarDataSQL(THIS.this_dDtalts) + ", " + ;
                       EscaparSQL(LEFT(THIS.this_cChaveexterna, 33)) + ")"

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_InsIts")
            IF USED("cursor_4c_InsIts")
                USE IN cursor_4c_InsIts
            ENDIF

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("INSERT")
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao inserir item de movimento:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *====================================================================
    * Atualizar - UPDATE SigMvIts (PROTECTED, chamado por Salvar())
    *====================================================================
    PROTECTED PROCEDURE Atualizar()
        LOCAL loc_cSQL, loc_nResultado, loc_lResultado
        loc_lResultado = .F.

        TRY
            IF EMPTY(ALLTRIM(THIS.this_cCidchaves))
                MsgErro("Chave prim" + CHR(225) + "ria n" + CHR(227) + "o informada para altera" + CHR(231) + CHR(227) + "o", "Erro")
            ELSE
                THIS.this_cEmpdopnums = THIS.MontarChaveEmpDopNums(THIS.this_cEmps, THIS.this_cDopes, THIS.this_nNumes)

                loc_cSQL = "UPDATE SigMvIts SET " + ;
                           "citens = "       + FormatarNumeroSQL(THIS.this_nCitens, 0) + ", " + ;
                           "emps = "         + EscaparSQL(PADR(THIS.this_cEmps, 3)) + ", " + ;
                           "dopes = "        + EscaparSQL(PADR(THIS.this_cDopes, 20)) + ", " + ;
                           "numes = "        + FormatarNumeroSQL(THIS.this_nNumes, 0) + ", " + ;
                           "cpros = "        + EscaparSQL(LEFT(THIS.this_cCpros, 14)) + ", " + ;
                           "codembs = "      + EscaparSQL(LEFT(THIS.this_cCodembs, 3)) + ", " + ;
                           "codtams = "      + EscaparSQL(LEFT(THIS.this_cCodtams, 4)) + ", " + ;
                           "codcors = "      + EscaparSQL(LEFT(THIS.this_cCodcors, 4)) + ", " + ;
                           "qtds = "         + FormatarNumeroSQL(THIS.this_nQtds, 3) + ", " + ;
                           "aqtds = "        + FormatarNumeroSQL(THIS.this_nAqtds, 3) + ", " + ;
                           "qtdembs = "      + FormatarNumeroSQL(THIS.this_nQtdembs, 1) + ", " + ;
                           "aqtdembs = "     + FormatarNumeroSQL(THIS.this_nAqtdembs, 1) + ", " + ;
                           "qtbaixas = "     + FormatarNumeroSQL(THIS.this_nQtbaixas, 3) + ", " + ;
                           "prembs = "       + FormatarNumeroSQL(THIS.this_nPrembs, 3) + ", " + ;
                           "codembents = "   + EscaparSQL(LEFT(THIS.this_cCodembents, 3)) + ", " + ;
                           "qtdents = "      + FormatarNumeroSQL(THIS.this_nQtdents, 3) + ", " + ;
                           "codbarras = "    + FormatarNumeroSQL(THIS.this_nCodbarras, 0) + ", " + ;
                           "pesos = "        + FormatarNumeroSQL(THIS.this_nPesos, 3) + ", " + ;
                           "qtbxprods = "    + FormatarNumeroSQL(THIS.this_nQtbxprods, 3) + ", " + ;
                           "qtprods = "      + FormatarNumeroSQL(THIS.this_nQtprods, 3) + ", " + ;
                           "datatrans = "    + FormatarDataSQL(THIS.this_dDatatrans) + ", " + ;
                           "locals = "       + EscaparSQL(LEFT(THIS.this_cLocals, 10)) + ", " + ;
                           "ntrans = "       + FormatarNumeroSQL(THIS.this_nNtrans, 0) + ", " + ;
                           "qtreservas = "   + FormatarNumeroSQL(THIS.this_nQtreservas, 3) + ", " + ;
                           "empdopnums = "   + EscaparSQL(LEFT(THIS.this_cEmpdopnums, 29)) + ", " + ;
                           "chksubn = "      + FormatarNumeroSQL(IIF(THIS.this_lChksubn, 1, 0), 0) + ", " + ;
                           "compris = "      + FormatarNumeroSQL(THIS.this_nCompris, 2) + ", " + ;
                           "dtalts = "       + FormatarDataSQL(THIS.this_dDtalts) + ", " + ;
                           "chaveexterna = " + EscaparSQL(LEFT(THIS.this_cChaveexterna, 33)) + ;
                           " WHERE cidchaves = " + EscaparSQL(ALLTRIM(THIS.this_cCidchaves))

                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_AltIts")
                IF USED("cursor_4c_AltIts")
                    USE IN cursor_4c_AltIts
                ENDIF

                IF loc_nResultado >= 0
                    THIS.RegistrarAuditoria("UPDATE")
                    loc_lResultado = .T.
                ELSE
                    MsgErro("Erro ao alterar item de movimento:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *====================================================================
    * Ajustes de impressora (Fase 7) - Opt_Impressora/Get_Printer.
    * InteractiveChange do legado chamam a funcao global fCarregarImps()
    * (SIGFUNCS.PRG), que NAO veio no acervo extraido para esta task (ver
    * comportamento.json, "funcoesExternas"). Mesma decisao arquitetural
    * do BO irmao sigopetsBO (Formsigopets, tambem um dialogo de
    * impressao de etiquetas): reproduzir o efeito observavel lendo
    * SigCdmp pelas colunas que ela de fato tem, em vez de inventar o
    * corpo da funcao ausente.
    *====================================================================
    this_nTipoImpressora   = 0   && impetis (1=Allegro, 2=Zebra ZPL, 3=Zebra EPL)
    this_nAjusteVertical   = 0   && ajverts
    this_nAjusteHorizontal = 0   && ajhorzs
    this_nAjusteDensidade  = 0   && ajdens  (piso 10)
    this_nAjusteVelocidade = 0   && ajvelos (piso 1)

    *====================================================================
    * CarregarAjustesImpressora - Recarrega tipo/ajustes de impressao
    * quando o usuario troca a impressora no combobox (Get_Printer).
    * Legado: Get_Printer.InteractiveChange ->
    *   fCarregarImps(ALLTRIM(crImpreV.impresS), loImp.Opcao_Imp,
    *                 loImp.Spn_AjVerts, loImp.Spn_AjHorzs,
    *                 loImp.Spn_AjDenss, loImp.Spn_AjVelos, poDataMgr)
    *
    * par_cNomeImpressora eh o nome CADASTRADO no sistema (SigCdmp.impres,
    * "crImpreV.impresS" no legado) - NAO o nome do Windows.
    *
    * Nome sem registro casando em SigCdmp eh caminho LEGITIMO (regra
    * CLAUDE.md #50 - universo vazio de lookup nao eh erro): devolve .T.
    * e this_n* ficam com o que ja estava.
    *====================================================================
    FUNCTION CarregarAjustesImpressora(par_cNomeImpressora)
        LOCAL loc_lSucesso, loc_nResultado, loc_nValor

        loc_lSucesso = .T.

        IF VARTYPE(par_cNomeImpressora) != "C" OR EMPTY(par_cNomeImpressora)
            RETURN .T.
        ENDIF

        TRY
            IF USED("cursor_4c_AjusteImpIpE")
                USE IN cursor_4c_AjusteImpIpE
            ENDIF

            loc_nResultado = SQLEXEC(gnConnHandle, ;
                "SELECT impetis, ajdens, ajhorzs, ajvelos, ajverts FROM SigCdmp " + ;
                "WHERE impres = " + EscaparSQL(ALLTRIM(par_cNomeImpressora)), ;
                "cursor_4c_AjusteImpIpE")

            IF loc_nResultado >= 1 AND RECCOUNT("cursor_4c_AjusteImpIpE") > 0
                SELECT cursor_4c_AjusteImpIpE
                GO TOP

                *-- impetis = 0 "nao configurado" - NAO troca o tipo (mesma
                *-- regra do BO irmao sigopetsBO.CarregarDoCursor)
                loc_nValor = NVL(impetis, 0)
                IF loc_nValor <> 0
                    THIS.this_nTipoImpressora = loc_nValor
                ENDIF

                THIS.this_nAjusteVertical   = NVL(ajverts, 0)
                THIS.this_nAjusteHorizontal = NVL(ajhorzs, 0)

                loc_nValor = NVL(ajdens, 0)
                THIS.this_nAjusteDensidade  = IIF(loc_nValor < 10, 10, loc_nValor)

                loc_nValor = NVL(ajvelos, 0)
                THIS.this_nAjusteVelocidade = IIF(loc_nValor < 1, 1, loc_nValor)
            ENDIF

            IF USED("cursor_4c_AjusteImpIpE")
                USE IN cursor_4c_AjusteImpIpE
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

ENDDEFINE

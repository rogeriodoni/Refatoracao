*==============================================================================
* pafBO.prg - Business Object para Configuracao PAF-ECF
* Tabela principal: SigCdPaf
* Chave primaria: Dopes char(20) - armazenado CODIFICADO no banco
*
* PAF-ECF = Programa Aplicativo Fiscal - Emissor de Cupom Fiscal
* Convencao de nomes do legado (invertida, mas preservada aqui):
*   fCriptografar(encoded) = decoded/legivel (para exibicao)
*   fDecriptografar(decoded) = encoded (para armazenamento no banco)
* Apenas ALTERAR e suportado via UI; insercao/exclusao e automatica (SincronizarDados)
*==============================================================================

DEFINE CLASS pafBO AS BusinessBase

    *-- Chave primaria (armazenada CODIFICADA no banco em SigCdPaf.Dopes)
    this_cDopes         = ""    && char(20)  Dopes      - Dopes codificado (PK no banco)

    *-- Campos de SigCdPaf (todos armazenados codificados no banco)
    this_cInativas      = ""    && char(1)   Inativas   - Flag inativo codificado
    this_cDocs          = ""    && char(1)   Docs       - Tipo documento codificado
    this_cMd5s          = ""    && char(32)  cMd5s      - Hash MD5 de integridade
    this_cCnCaixas      = ""    && char(3)   cnCaixas   - NSEQ caixa codificado
    this_cTrNfis        = ""    && char(2)   TrNfis     - Finalizadora nao fiscal codificada

    *-- Versoes DECODIFICADAS para exibicao no form e uso nas queries FK
    this_cDopePafEcfs   = ""    && Dopes decodificado - exibido como "Funcao" no grid
    this_cCx            = ""    && cnCaixas decodificado - exibido como "N do caixa"
    this_cTrNf          = ""    && TrNfis decodificado - exibido como "Finalizadora Nao Fiscal"

    *-- Valores para os campos editaveis do formulario (ja decodificados)
    this_nOpDoc         = 0     && Valor OptionGroup op_doc (1-5 decodificado)
    this_lInativa       = .F.   && Flag inativo (checkbox Chk_Inativar)
    this_cNcaixa        = ""    && Numero do caixa decodificado (campo Get_ncaixa)
    this_cCupomNfis     = ""    && Finalizadora nao fiscal decodificada (campo Get_cupomnfis)

    *-- Dados da operacao em SigCdOpe (para sincronizacao)
    this_nCupFis        = 0     && numeric(1,0) CupFis     - Tipo cupom fiscal
    this_nNFiscals      = 0     && numeric(1,0) nFiscals   - Nao fiscal
    this_nAgrupas       = 0     && numeric(1,0) Agrupas    - Agrupa
    this_nDocus         = 0     && numeric(1,0) Docus      - Tipo documento operacao
    this_nTrNfisOpe     = 0     && numeric(2,0) TrNfis     - Finalizadora em SigCdOpe
    this_nOpeInatvs     = 0     && numeric(1,0) OpeInatvs  - Flag inativo em SigOpCdc
    this_nCnCaixasOpe   = 0     && numeric(3,0) cnCaixas   - Numero caixa em SigOpCdc
    this_cSeries        = ""    && Series da operacao em SigCdOpe (usado para CNF)

    *--------------------------------------------------------------------------
    PROCEDURE Init()
        DODEFAULT()
        THIS.this_cTabela     = "SigCdPaf"
        THIS.this_cCampoChave = "Dopes"
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    FUNCTION ObterChavePrimaria()
        RETURN ALLTRIM(THIS.this_cDopes)
    ENDFUNC

    *--------------------------------------------------------------------------
    * Buscar - Carrega todos os registros PAF para o grid
    * Popula cursor_4c_Dados com Dopes/cnCaixas/TrNfis DECODIFICADOS nas colunas alias
    *--------------------------------------------------------------------------
    FUNCTION Buscar(par_cFiltro)
        LOCAL loc_cSQL, loc_nResult, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "SELECT Dopes, Inativas, Docs, cMd5s, cnCaixas, TrNfis," + ;
                       " Dopes AS DopePafEcfs, cnCaixas AS Cx, TrNfis AS TrNf" + ;
                       " FROM SigCdPaf"
            IF !EMPTY(ALLTRIM(par_cFiltro))
                loc_cSQL = loc_cSQL + " WHERE " + par_cFiltro
            ENDIF
            *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
            IF USED("cursor_4c_Dados")
                TABLEREVERT(.T., "cursor_4c_Dados")
                USE IN cursor_4c_Dados
            ENDIF

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")
            IF loc_nResult >= 0
                IF USED("cursor_4c_Dados") AND RECCOUNT("cursor_4c_Dados") > 0
                    SELECT cursor_4c_Dados
                    SCAN
                        REPLACE cursor_4c_Dados.DopePafEcfs WITH THIS.Cript(ALLTRIM(cursor_4c_Dados.Dopes)), ;
                                cursor_4c_Dados.Cx WITH THIS.Cript(ALLTRIM(cursor_4c_Dados.cnCaixas)), ;
                                cursor_4c_Dados.TrNf WITH THIS.Cript(ALLTRIM(cursor_4c_Dados.TrNfis))
                    ENDSCAN
                    GO TOP IN cursor_4c_Dados
                ENDIF
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao carregar configura" + CHR(231) + CHR(245) + "es PAF-ECF: " + ;
                        CapturarErroSQL(), "Erro SQL")
                IF !USED("cursor_4c_Dados")
                    CREATE CURSOR cursor_4c_Dados ( ;
                        Dopes       C(20), ;
                        Inativas    C(1), ;
                        Docs        C(1), ;
                        cMd5s       C(32), ;
                        cnCaixas    C(3), ;
                        TrNfis      C(2), ;
                        DopePafEcfs C(50), ;
                        Cx          C(3), ;
                        TrNf        C(2))
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em pafBO.Buscar: " + loc_oErro.Message, "Erro")
            IF !USED("cursor_4c_Dados")
                CREATE CURSOR cursor_4c_Dados ( ;
                    Dopes       C(20), ;
                    Inativas    C(1), ;
                    Docs        C(1), ;
                    cMd5s       C(32), ;
                    cnCaixas    C(3), ;
                    TrNfis      C(2), ;
                    DopePafEcfs C(50), ;
                    Cx          C(3), ;
                    TrNf        C(2))
            ENDIF
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * CarregarPorCodigo - Carrega um registro pelo Dopes codificado (valor bruto do banco)
    * par_cDopes: valor de cursor_4c_Dados.Dopes (codificado, como armazenado em SigCdPaf)
    *--------------------------------------------------------------------------
    FUNCTION CarregarPorCodigo(par_cDopes)
        LOCAL loc_cSQL, loc_nResult, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "SELECT Dopes, Inativas, Docs, cMd5s, cnCaixas, TrNfis" + ;
                       " FROM SigCdPaf" + ;
                       " WHERE Dopes = " + EscaparSQL(ALLTRIM(par_cDopes))
            *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
            IF USED("cursor_4c_Carrega")
                TABLEREVERT(.T., "cursor_4c_Carrega")
                USE IN cursor_4c_Carrega
            ENDIF

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")
            IF loc_nResult >= 0 AND RECCOUNT("cursor_4c_Carrega") > 0
                IF THIS.CarregarDoCursor("cursor_4c_Carrega")
                    THIS.this_lNovoRegistro = .F.
                    loc_lSucesso = .T.
                ENDIF
            ELSE
                MsgErro("Registro PAF-ECF n" + CHR(227) + "o encontrado: " + ;
                        ALLTRIM(par_cDopes), "Aviso")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em pafBO.CarregarPorCodigo: " + loc_oErro.Message, "Erro")
        ENDTRY

        IF USED("cursor_4c_Carrega")
            USE IN cursor_4c_Carrega
        ENDIF

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Mapeia cursor para propriedades do BO
    * Armazena valores CODIFICADOS (brutos do banco) E DECODIFICADOS (para o form)
    *--------------------------------------------------------------------------
    FUNCTION CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        IF USED(par_cAliasCursor)
            SELECT (par_cAliasCursor)
            *-- Valores codificados (brutos do banco)
            THIS.this_cDopes      = TratarNulo(Dopes,    "C")
            THIS.this_cInativas   = TratarNulo(Inativas, "C")
            THIS.this_cDocs       = TratarNulo(Docs,     "C")
            THIS.this_cMd5s       = TratarNulo(cMd5s,   "C")
            THIS.this_cCnCaixas   = TratarNulo(cnCaixas, "C")
            THIS.this_cTrNfis     = TratarNulo(TrNfis,   "C")
            *-- Valores decodificados para exibicao no form
            THIS.this_cDopePafEcfs = THIS.Cript(ALLTRIM(THIS.this_cDopes))
            THIS.this_cCx          = THIS.Cript(ALLTRIM(THIS.this_cCnCaixas))
            THIS.this_cTrNf        = THIS.Cript(ALLTRIM(THIS.this_cTrNfis))
            THIS.this_nOpDoc       = VAL(THIS.Cript(ALLTRIM(THIS.this_cDocs)))
            THIS.this_lInativa     = (VAL(THIS.Cript(ALLTRIM(THIS.this_cInativas))) = 1)
            THIS.this_cNcaixa      = THIS.Cript(ALLTRIM(THIS.this_cCnCaixas))
            THIS.this_cCupomNfis   = THIS.Cript(ALLTRIM(THIS.this_cTrNfis))
            loc_lSucesso = .T.
        ENDIF

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * Atualizar - Salva as alteracoes do PAF-ECF no banco de dados
    * Equivale ao Salva.Click do legado: atualiza SigCdPaf, SigCdOpe e SigOpCdc
    * Requer this_cDopes (codificado), this_cDopePafEcfs (decodificado),
    *         this_nOpDoc, this_lInativa, this_cNcaixa, this_cCupomNfis
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION Atualizar()
        LOCAL loc_cDopPaf, loc_cDoc, loc_cInt
        LOCAL loc_cCaixa, loc_cTrfNf
        LOCAL loc_cInativaEnc, loc_cDocEnc, loc_cCaixaEnc, loc_cTrfNfEnc
        LOCAL loc_cMd5, loc_cUpdate, loc_nResult, loc_lSucesso, loc_lOk
        loc_lSucesso = .F.

        *-- Validacao antes do TRY (RETURN permitido aqui)
        IF !INLIST(IIF(THIS.this_lInativa, "1", "0"), "0", "1")
            MsgErro("Configura" + CHR(231) + CHR(227) + "o Inv" + CHR(225) + "lida. " + ;
                    "Acerte a Op" + CHR(231) + CHR(227) + "o Inativar!!!", ;
                    "Valida" + CHR(231) + CHR(227) + "o")
            RETURN .F.
        ENDIF

        TRY
            loc_cDopPaf = ALLTRIM(THIS.this_cDopePafEcfs)  && decodificado = chave nas FK tables
            loc_cDoc    = ALLTRIM(STR(THIS.this_nOpDoc, 1))
            loc_cInt    = IIF(THIS.this_lInativa, "1", "0")
            loc_cCaixa  = ALLTRIM(THIS.this_cNcaixa)
            loc_cTrfNf  = ALLTRIM(THIS.this_cCupomNfis)

            *-- Codifica valores para armazenamento no banco
            loc_cInativaEnc = THIS.Dcript(loc_cInt)
            loc_cDocEnc     = THIS.Dcript(loc_cDoc)
            loc_cCaixaEnc   = THIS.Dcript(loc_cCaixa)
            loc_cTrfNfEnc   = THIS.Dcript(loc_cTrfNf)

            *-- Calcula hash MD5 dos valores a serem armazenados
            loc_cMd5 = THIS.ComputarMD5PafEcf(ALLTRIM(THIS.this_cDopes), ;
                           loc_cInativaEnc, loc_cDocEnc, loc_cCaixaEnc, loc_cTrfNfEnc, ;
                           loc_cDopPaf, loc_cCaixa, loc_cTrfNf)

            *-- Atualiza SigCdPaf com valores codificados + MD5
            loc_cUpdate = "UPDATE SigCdPaf SET" + ;
                          " Inativas = " + EscaparSQL(loc_cInativaEnc) + "," + ;
                          " Docs = " + EscaparSQL(loc_cDocEnc) + "," + ;
                          " cMd5s = " + EscaparSQL(loc_cMd5) + "," + ;
                          " cnCaixas = " + EscaparSQL(loc_cCaixaEnc) + "," + ;
                          " TrNfis = " + EscaparSQL(loc_cTrfNfEnc) + ;
                          " WHERE Dopes = " + EscaparSQL(ALLTRIM(THIS.this_cDopes))
            *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
            IF USED("cursor_4c_UpdPaf")
                TABLEREVERT(.T., "cursor_4c_UpdPaf")
                USE IN cursor_4c_UpdPaf
            ENDIF

            loc_nResult = SQLEXEC(gnConnHandle, loc_cUpdate, "cursor_4c_UpdPaf")
            IF USED("cursor_4c_UpdPaf")
                USE IN cursor_4c_UpdPaf
            ENDIF

            IF loc_nResult >= 0
                *-- Atualiza tabelas FK conforme tipo de documento
                loc_lOk = THIS.AtualizarTabelasFK(loc_cDopPaf, loc_cDoc, loc_cInt, loc_cCaixa, loc_cTrfNf)
                IF loc_lOk
                    THIS.RegistrarAuditoria("UPDATE")
                    loc_lSucesso = .T.
                ENDIF
            ELSE
                MsgErro("Erro ao atualizar SigCdPaf: " + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em pafBO.Atualizar: " + loc_oErro.Message + ;
                    " (Linha " + TRANSFORM(loc_oErro.LineNo) + ")", "Erro PAF-ECF")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * AtualizarTabelasFK - Atualiza SigCdOpe e SigOpCdc conforme tipo documento
    * par_cDopPaf : Dopes DECODIFICADO (plain text - chave em SigCdOpe/SigOpCdc)
    * par_cDoc    : '1'=CF, '2'=CNF, '3'=DAV RG, '4'=DAV A4, '5'=PRE VENDA, '6'=Nao Fiscal
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION AtualizarTabelasFK(par_cDopPaf, par_cDoc, par_cInt, par_cCaixa, par_cTrfNf)
        LOCAL loc_cUpdate1, loc_cUpdate2, loc_nRes1, loc_nRes2
        LOCAL loc_cSeries, loc_lSucesso, loc_lTipoValido
        loc_lSucesso  = .F.
        loc_lTipoValido = .T.

        TRY
            loc_cUpdate1 = ""
            loc_cUpdate2 = ""
            loc_cSeries  = ""

            DO CASE
                CASE par_cDoc = "1"
                    *-- CF - Cupom Fiscal
                    loc_cUpdate1 = "UPDATE SigCdOpe SET CupFis = 1, estoqs = 1, docus = 2" + ;
                                   " WHERE Dopes = " + EscaparSQL(par_cDopPaf)
                    loc_cUpdate2 = "UPDATE SigOpCdc SET verests = 1, opeinatvs = " + par_cInt + ;
                                   ", cncaixas = " + EscaparSQL(par_cCaixa) + ;
                                   " WHERE Dopes = " + EscaparSQL(par_cDopPaf)

                CASE par_cDoc = "2"
                    *-- CNF - Cupom Nao Fiscal: obtem ou cria serie PED
                    loc_cSeries  = THIS.BuscarOuCriarSerie(par_cDopPaf)
                    loc_cUpdate1 = "UPDATE SigCdOpe SET CupFis=3, estoqs=2, docus=2, TipoNfs=1," + ;
                                   " Series=" + EscaparSQL(loc_cSeries) + "," + ;
                                   " TrNfis=" + FormatarNumeroSQL(VAL(par_cTrfNf)) + ;
                                   " WHERE Dopes = " + EscaparSQL(par_cDopPaf)
                    loc_cUpdate2 = "UPDATE SigOpCdc SET verests = 2, opeinatvs = " + par_cInt + ;
                                   ", cncaixas = " + EscaparSQL(par_cCaixa) + ;
                                   " WHERE Dopes = " + EscaparSQL(par_cDopPaf)

                CASE par_cDoc = "3"
                    *-- DAV RG
                    loc_cUpdate1 = "UPDATE SigCdOpe SET CupFis = 2, estoqs = 2, Docus = 3" + ;
                                   " WHERE Dopes = " + EscaparSQL(par_cDopPaf)
                    loc_cUpdate2 = "UPDATE SigOpCdc SET verests = 3, opeinatvs = " + par_cInt + ;
                                   ", cncaixas = " + EscaparSQL(par_cCaixa) + ;
                                   " WHERE Dopes = " + EscaparSQL(par_cDopPaf)

                CASE par_cDoc = "4"
                    *-- DAV A4
                    loc_cUpdate1 = "UPDATE SigCdOpe SET CupFis = 2, estoqs = 2, Docus = 2" + ;
                                   " WHERE Dopes = " + EscaparSQL(par_cDopPaf)
                    loc_cUpdate2 = "UPDATE SigOpCdc SET verests = 2, opeinatvs = " + par_cInt + ;
                                   ", cncaixas = " + EscaparSQL(par_cCaixa) + ;
                                   " WHERE Dopes = " + EscaparSQL(par_cDopPaf)

                CASE par_cDoc = "5"
                    *-- PRE VENDA
                    loc_cUpdate1 = "UPDATE SigCdOpe SET CupFis = 2, estoqs = 1, nfiscals = 2," + ;
                                   " Agrupas = 1, Docus = 2 WHERE Dopes = " + EscaparSQL(par_cDopPaf)
                    loc_cUpdate2 = "UPDATE SigOpCdc SET verests = 1, opeinatvs = " + par_cInt + ;
                                   ", cncaixas = " + EscaparSQL(par_cCaixa) + ;
                                   " WHERE Dopes = " + EscaparSQL(par_cDopPaf)

                CASE par_cDoc = "6"
                    *-- Nao Fiscal
                    loc_cUpdate1 = "UPDATE SigCdOpe SET CupFis = 2, estoqs = 1, nfiscals = 2," + ;
                                   " Agrupas = 2, Docus = 2 WHERE Dopes = " + EscaparSQL(par_cDopPaf)
                    loc_cUpdate2 = "UPDATE SigOpCdc SET verests = 1, opeinatvs = " + par_cInt + ;
                                   ", cncaixas = " + EscaparSQL(par_cCaixa) + ;
                                   " WHERE Dopes = " + EscaparSQL(par_cDopPaf)

                OTHERWISE
                    MsgErro("Configura" + CHR(231) + CHR(227) + "o Inv" + CHR(225) + ;
                            "lida de Documento!!! Tipo: " + par_cDoc, ;
                            "Valida" + CHR(231) + CHR(227) + "o")
                    loc_lTipoValido = .F.
            ENDCASE

            IF loc_lTipoValido AND !EMPTY(ALLTRIM(loc_cUpdate1))
                *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
                IF USED("cursor_4c_FkA")
                    TABLEREVERT(.T., "cursor_4c_FkA")
                    USE IN cursor_4c_FkA
                ENDIF

                loc_nRes1 = SQLEXEC(gnConnHandle, loc_cUpdate1, "cursor_4c_FkA")
                IF USED("cursor_4c_FkA")
                    USE IN cursor_4c_FkA
                ENDIF
                IF loc_nRes1 >= 0
                    *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
                    IF USED("cursor_4c_FkB")
                        TABLEREVERT(.T., "cursor_4c_FkB")
                        USE IN cursor_4c_FkB
                    ENDIF

                    loc_nRes2 = SQLEXEC(gnConnHandle, loc_cUpdate2, "cursor_4c_FkB")
                    IF USED("cursor_4c_FkB")
                        USE IN cursor_4c_FkB
                    ENDIF
                    IF loc_nRes2 >= 0
                        loc_lSucesso = .T.
                    ELSE
                        MsgErro("Erro ao atualizar SigOpCdc: " + CapturarErroSQL(), "Erro SQL")
                    ENDIF
                ELSE
                    MsgErro("Erro ao atualizar SigCdOpe: " + CapturarErroSQL(), "Erro SQL")
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em pafBO.AtualizarTabelasFK: " + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * BuscarOuCriarSerie - Obtem serie da operacao ou cria serie PED para CNF
    * Retorna o codigo da serie (ex: "PED")
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION BuscarOuCriarSerie(par_cDopPaf)
        LOCAL loc_cSQL, loc_nResult, loc_cSeries, loc_nQtd
        loc_cSeries = ""

        TRY
            *-- Tenta obter a serie existente em SigCdOpe
            loc_cSQL = "SELECT Series FROM SigCdOpe WHERE Dopes = " + EscaparSQL(par_cDopPaf)
            *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
            IF USED("cursor_4c_OpeS")
                TABLEREVERT(.T., "cursor_4c_OpeS")
                USE IN cursor_4c_OpeS
            ENDIF

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_OpeS")
            IF loc_nResult >= 0 AND RECCOUNT("cursor_4c_OpeS") > 0
                SELECT cursor_4c_OpeS
                loc_cSeries = ALLTRIM(cursor_4c_OpeS.Series)
            ENDIF
            IF USED("cursor_4c_OpeS")
                USE IN cursor_4c_OpeS
            ENDIF

            IF EMPTY(ALLTRIM(loc_cSeries))
                loc_cSeries = "PED"
                *-- Verifica se serie PED ja existe em SIGCDSER
                loc_cSQL = "SELECT COUNT(*) AS Qtd FROM SIGCDSER WHERE EmpCods = " + ;
                           EscaparSQL(ALLTRIM(go_4c_Sistema.cCodEmpresa) + loc_cSeries)
                *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
                IF USED("cursor_4c_SerieEx")
                    TABLEREVERT(.T., "cursor_4c_SerieEx")
                    USE IN cursor_4c_SerieEx
                ENDIF

                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_SerieEx")
                loc_nQtd = 0
                IF loc_nResult >= 0 AND RECCOUNT("cursor_4c_SerieEx") > 0
                    SELECT cursor_4c_SerieEx
                    loc_nQtd = cursor_4c_SerieEx.Qtd
                ENDIF
                IF USED("cursor_4c_SerieEx")
                    USE IN cursor_4c_SerieEx
                ENDIF

                IF loc_nQtd = 0
                    *-- Cria nova serie PED
                    loc_cSQL = "INSERT INTO SIGCDSER" + ;
                               " (Emps, Cods, Descs, cTipoNfs, ImpNfs, TipoNfs, EmpCods)" + ;
                               " VALUES (" + ;
                               EscaparSQL(ALLTRIM(go_4c_Sistema.cCodEmpresa)) + "," + ;
                               EscaparSQL(loc_cSeries) + "," + ;
                               EscaparSQL(loc_cSeries) + ",'ECF',2,1," + ;
                               EscaparSQL(ALLTRIM(go_4c_Sistema.cCodEmpresa) + loc_cSeries) + ")"
                    *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
                    IF USED("cursor_4c_InsS")
                        TABLEREVERT(.T., "cursor_4c_InsS")
                        USE IN cursor_4c_InsS
                    ENDIF

                    loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_InsS")
                    IF USED("cursor_4c_InsS")
                        USE IN cursor_4c_InsS
                    ENDIF
                    IF loc_nResult < 0
                        MsgErro("Erro ao criar s" + CHR(233) + "rie PED: " + ;
                                CapturarErroSQL(), "Erro SQL")
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em pafBO.BuscarOuCriarSerie: " + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_cSeries
    ENDFUNC

    *--------------------------------------------------------------------------
    * SincronizarDados - Sincroniza SigCdPaf com operacoes PAF da empresa
    * Equivale ao Init() do legado:
    *   1. Insere em SigCdPaf as ops que faltam (pafEcfs=1 em SigOpCdd)
    *   2. Remove de SigCdPaf as ops que nao existem mais em SigOpCdd
    *   3. Valida integridade MD5 e redefine registros corrompidos
    * Deve ser chamado ao abrir o formulario (antes de Buscar)
    *--------------------------------------------------------------------------
    FUNCTION SincronizarDados()
        LOCAL loc_cSQL, loc_nResult, loc_lSucesso, loc_lFaseOk
        LOCAL loc_cDoc, loc_cDopes, loc_cDopesDecod
        LOCAL loc_cInativaEnc, loc_cDocEnc, loc_cCaixaEnc, loc_cTrfNfEnc, loc_cMd5
        loc_lSucesso = .F.
        loc_lFaseOk  = .T.

        TRY
            *-- FASE 1: Carrega operacoes PAF ativas (SigOpCdd + SigOpCdc + SigCdOpe)
            loc_cSQL = "SELECT a.Dopes, b.OpeInatvs, b.cnCaixas," + ;
                       " c.CupFis, c.nFiscals, c.Agrupas, c.Docus, c.TrNfis" + ;
                       " FROM SigOpCdd a" + ;
                       " INNER JOIN SigOpCdc b ON b.dopes = a.Dopes" + ;
                       " INNER JOIN SigCdOpe c ON c.Dopes = a.Dopes" + ;
                       " WHERE a.pafEcfs = 1"
            *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
            IF USED("cursor_4c_LocalOpe2")
                TABLEREVERT(.T., "cursor_4c_LocalOpe2")
                USE IN cursor_4c_LocalOpe2
            ENDIF

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_LocalOpe2")
            IF loc_nResult < 0
                MsgErro("Erro ao carregar opera" + CHR(231) + CHR(245) + "es PAF: " + ;
                        CapturarErroSQL(), "Erro SQL")
                loc_lFaseOk = .F.
            ENDIF

            *-- FASE 2: Carrega registros PAF existentes para comparacao
            IF loc_lFaseOk
                loc_cSQL = "SELECT Dopes, Inativas, Docs, cMd5s, cnCaixas, TrNfis FROM SigCdPaf"
                *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
                IF USED("cursor_4c_PafExist")
                    TABLEREVERT(.T., "cursor_4c_PafExist")
                    USE IN cursor_4c_PafExist
                ENDIF

                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_PafExist")
                IF loc_nResult < 0
                    MsgErro("Erro ao carregar SigCdPaf: " + CapturarErroSQL(), "Erro SQL")
                    loc_lFaseOk = .F.
                ENDIF
            ENDIF

            *-- FASE 3: Insere operacoes faltantes em SigCdPaf
            IF loc_lFaseOk AND USED("cursor_4c_LocalOpe2") AND ;
               RECCOUNT("cursor_4c_LocalOpe2") > 0
                SELECT cursor_4c_LocalOpe2
                GO TOP
                SCAN
                    loc_cDopes = ALLTRIM(cursor_4c_LocalOpe2.Dopes)  && plain text
                    IF !THIS.ExisteDopesNoPaf(loc_cDopes)
                        MsgAviso("Aten" + CHR(231) + CHR(227) + "o!!! Opera" + ;
                                 CHR(231) + CHR(227) + "o: " + loc_cDopes + ;
                                 " Esta Inconsistente. O sistema ir" + CHR(225) + ;
                                 " assumir as Configura" + CHR(231) + CHR(245) + ;
                                 "es Padr" + CHR(245) + "es!!!!", ;
                                 "Aten" + CHR(231) + CHR(227) + "o")

                        loc_cDoc = "0"
                        DO CASE
                            CASE cursor_4c_LocalOpe2.CupFis = 1
                                loc_cDoc = "1"
                            CASE cursor_4c_LocalOpe2.CupFis = 3
                                loc_cDoc = "2"
                            CASE cursor_4c_LocalOpe2.CupFis = 2 AND cursor_4c_LocalOpe2.Docus = 3
                                loc_cDoc = "3"
                            CASE cursor_4c_LocalOpe2.CupFis = 2 AND cursor_4c_LocalOpe2.Docus = 2
                                loc_cDoc = "4"
                        ENDCASE

                        loc_cInativaEnc = THIS.Dcript(ALLTRIM(STR(cursor_4c_LocalOpe2.OpeInatvs, 1)))
                        loc_cDocEnc     = THIS.Dcript(loc_cDoc)
                        loc_cCaixaEnc   = THIS.Dcript(PADL(ALLTRIM(STR(cursor_4c_LocalOpe2.cnCaixas, 3)), 3, "0"))
                        loc_cTrfNfEnc   = THIS.Dcript(PADL(ALLTRIM(STR(cursor_4c_LocalOpe2.TrNfis, 2)), 2, "0"))

                        loc_cSQL = "INSERT INTO SigCdPaf" + ;
                                   " (Dopes, Inativas, Docs, cMd5s, cnCaixas, TrNfis)" + ;
                                   " VALUES (" + ;
                                   EscaparSQL(THIS.Dcript(loc_cDopes)) + "," + ;
                                   EscaparSQL(loc_cInativaEnc) + "," + ;
                                   EscaparSQL(loc_cDocEnc) + ",''," + ;
                                   EscaparSQL(loc_cCaixaEnc) + "," + ;
                                   EscaparSQL(loc_cTrfNfEnc) + ")"
                        *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
                        IF USED("cursor_4c_InsP")
                            TABLEREVERT(.T., "cursor_4c_InsP")
                            USE IN cursor_4c_InsP
                        ENDIF

                        loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_InsP")
                        IF USED("cursor_4c_InsP")
                            USE IN cursor_4c_InsP
                        ENDIF
                        IF loc_nResult < 0
                            MsgErro("Erro ao inserir PAF para " + loc_cDopes + ": " + ;
                                    CapturarErroSQL(), "Erro SQL")
                        ENDIF
                    ENDIF
                ENDSCAN
            ENDIF

            *-- FASE 4: Remove registros PAF orfaos (sem operacao em SigOpCdd)
            IF loc_lFaseOk AND USED("cursor_4c_PafExist") AND ;
               RECCOUNT("cursor_4c_PafExist") > 0
                SELECT cursor_4c_PafExist
                GO TOP
                SCAN
                    *-- Decodifica o Dopes codificado do banco para comparar com SigOpCdd (plain)
                    loc_cDopesDecod = THIS.Cript(ALLTRIM(cursor_4c_PafExist.Dopes))
                    IF !THIS.ExisteDopesNaOperacao(loc_cDopesDecod)
                        loc_cSQL = "DELETE FROM SigCdPaf WHERE Dopes = " + ;
                                   EscaparSQL(ALLTRIM(cursor_4c_PafExist.Dopes))
                        *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
                        IF USED("cursor_4c_DelP")
                            TABLEREVERT(.T., "cursor_4c_DelP")
                            USE IN cursor_4c_DelP
                        ENDIF

                        loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_DelP")
                        IF USED("cursor_4c_DelP")
                            USE IN cursor_4c_DelP
                        ENDIF
                        IF loc_nResult < 0
                            MsgErro("Erro ao remover PAF orf" + CHR(227) + "o " + ;
                                    loc_cDopesDecod + ": " + CapturarErroSQL(), "Erro SQL")
                        ENDIF
                    ENDIF
                ENDSCAN
            ENDIF

            *-- FASE 5: Valida integridade MD5; redefine registros corrompidos
            IF loc_lFaseOk
                IF USED("cursor_4c_PafExist")
                    USE IN cursor_4c_PafExist
                ENDIF
                loc_cSQL = "SELECT Dopes, Inativas, Docs, cMd5s, cnCaixas, TrNfis FROM SigCdPaf"
                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_PafExist")
                IF loc_nResult >= 0 AND RECCOUNT("cursor_4c_PafExist") > 0
                    SELECT cursor_4c_PafExist
                    GO TOP
                    SCAN
                        loc_cDopesDecod = THIS.Cript(ALLTRIM(cursor_4c_PafExist.Dopes))
                        IF !THIS.ValidarIntegridade(loc_cDopesDecod) AND ;
                           THIS.ExisteDopesNaOperacao(loc_cDopesDecod)
                            MsgAviso("Aten" + CHR(231) + CHR(227) + "o!!! Opera" + ;
                                     CHR(231) + CHR(227) + "o: " + loc_cDopesDecod + ;
                                     " Esta Inconsistente. O sistema ir" + CHR(225) + ;
                                     " assumir as Configura" + CHR(231) + CHR(245) + ;
                                     "es Padr" + CHR(245) + "es!!!!", ;
                                     "Aten" + CHR(231) + CHR(227) + "o")
                            THIS.RedefinirPadroesOperacao(loc_cDopesDecod)
                        ENDIF
                    ENDSCAN
                ENDIF
            ENDIF

            IF loc_lFaseOk
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em pafBO.SincronizarDados: " + loc_oErro.Message + ;
                    " (Linha " + TRANSFORM(loc_oErro.LineNo) + ")", "Erro PAF-ECF")
        ENDTRY

        IF USED("cursor_4c_LocalOpe2")
            USE IN cursor_4c_LocalOpe2
        ENDIF
        IF USED("cursor_4c_PafExist")
            USE IN cursor_4c_PafExist
        ENDIF

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * ValidarIntegridade - Valida hash MD5 de um registro PAF
    * par_cDopesDecod: Dopes DECODIFICADO (plain text, como exibido no grid)
    *--------------------------------------------------------------------------
    FUNCTION ValidarIntegridade(par_cDopesDecod)
        LOCAL loc_cSQL, loc_nResult, loc_cMd5Calc, loc_cMd5Armazd, loc_lValido
        loc_lValido = .F.

        TRY
            *-- Codifica para localizar o registro no banco
            loc_cSQL = "SELECT * FROM SigCdPaf WHERE Dopes = " + ;
                       EscaparSQL(THIS.Dcript(ALLTRIM(par_cDopesDecod)))
            *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
            IF USED("cursor_4c_Md5Val")
                TABLEREVERT(.T., "cursor_4c_Md5Val")
                USE IN cursor_4c_Md5Val
            ENDIF

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Md5Val")
            IF loc_nResult < 0 OR RECCOUNT("cursor_4c_Md5Val") = 0
                MsgErro("Favor Reinicializar o Processo!!! " + ;
                        "Falha na Conex" + CHR(227) + "o (Md5Val)", "Erro!!!")
            ELSE
                loc_cMd5Calc   = THIS.GerarMD5("cursor_4c_Md5Val", "cMd5s")
                SELECT cursor_4c_Md5Val
                loc_cMd5Armazd = ALLTRIM(cursor_4c_Md5Val.cMd5s)
                loc_lValido    = (loc_cMd5Armazd == loc_cMd5Calc)
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em pafBO.ValidarIntegridade: " + loc_oErro.Message, "Erro")
        ENDTRY

        IF USED("cursor_4c_Md5Val")
            USE IN cursor_4c_Md5Val
        ENDIF

        RETURN loc_lValido
    ENDFUNC

    *--------------------------------------------------------------------------
    * ComputarMD5PafEcf - Cria cursor temporario e calcula MD5 para o PAF-ECF
    * Espelha a estrutura de CrSigCdPaf usada em fGerarMD52016 no legado
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION ComputarMD5PafEcf(par_cDopes, par_cInativas, par_cDocs, ;
                                          par_cCnCaixas, par_cTrNfis, ;
                                          par_cDopePafEcfs, par_cCx, par_cTrNf)
        LOCAL loc_cMd5
        loc_cMd5 = ""

        TRY
            IF USED("cursor_4c_Md5Tmp")
                USE IN cursor_4c_Md5Tmp
            ENDIF

            CREATE CURSOR cursor_4c_Md5Tmp ( ;
                Dopes       C(20), ;
                Inativas    C(1), ;
                Docs        C(1), ;
                cMd5s       C(32), ;
                cnCaixas    C(3), ;
                TrNfis      C(2), ;
                DopePafEcfs C(50), ;
                Cx          C(3), ;
                TrNf        C(2))

            INSERT INTO cursor_4c_Md5Tmp VALUES ( ;
                par_cDopes, par_cInativas, par_cDocs, ;
                "", par_cCnCaixas, par_cTrNfis, ;
                par_cDopePafEcfs, par_cCx, par_cTrNf)

            loc_cMd5 = THIS.GerarMD5("cursor_4c_Md5Tmp", "cMd5s,DopePafEcfs,Cx,TrNf")
        CATCH TO loc_oErro
            MsgErro("Erro ao computar MD5 PAF-ECF: " + loc_oErro.Message, "Erro")
        ENDTRY

        IF USED("cursor_4c_Md5Tmp")
            USE IN cursor_4c_Md5Tmp
        ENDIF

        RETURN loc_cMd5
    ENDFUNC

    *--------------------------------------------------------------------------
    * RedefinirPadroesOperacao - Redefine SigCdPaf com valores padrao de SigCdOpe
    * Chamado quando MD5 invalido mas operacao ainda existe em SigOpCdd
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION RedefinirPadroesOperacao(par_cDopesDecod)
        LOCAL loc_cSQL, loc_nResult, loc_cDoc, loc_cMd5, loc_lSucesso
        LOCAL loc_cInativaEnc, loc_cDocEnc, loc_cCaixaEnc, loc_cTrfNfEnc, loc_cDopesEnc
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "SELECT a.Dopes, b.OpeInatvs, b.cnCaixas," + ;
                       " c.CupFis, c.nFiscals, c.Agrupas, c.Docus, c.TrNfis" + ;
                       " FROM SigOpCdd a" + ;
                       " INNER JOIN SigOpCdc b ON b.dopes = a.Dopes" + ;
                       " INNER JOIN SigCdOpe c ON c.Dopes = a.Dopes" + ;
                       " WHERE a.pafEcfs = 1 AND a.Dopes = " + EscaparSQL(par_cDopesDecod)
            *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
            IF USED("cursor_4c_OpeRed")
                TABLEREVERT(.T., "cursor_4c_OpeRed")
                USE IN cursor_4c_OpeRed
            ENDIF

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_OpeRed")
            IF loc_nResult >= 0 AND RECCOUNT("cursor_4c_OpeRed") > 0
                SELECT cursor_4c_OpeRed
                loc_cDoc = "0"
                DO CASE
                    CASE cursor_4c_OpeRed.CupFis = 1
                        loc_cDoc = "1"
                    CASE cursor_4c_OpeRed.CupFis = 3
                        loc_cDoc = "2"
                    CASE cursor_4c_OpeRed.CupFis = 2 AND cursor_4c_OpeRed.Docus = 3
                        loc_cDoc = "3"
                    CASE cursor_4c_OpeRed.CupFis = 2 AND cursor_4c_OpeRed.Docus = 2
                        loc_cDoc = "4"
                ENDCASE

                loc_cDopesEnc   = THIS.Dcript(par_cDopesDecod)
                loc_cInativaEnc = THIS.Dcript(ALLTRIM(STR(cursor_4c_OpeRed.OpeInatvs, 1)))
                loc_cDocEnc     = THIS.Dcript(loc_cDoc)
                loc_cCaixaEnc   = THIS.Dcript(PADL(ALLTRIM(STR(cursor_4c_OpeRed.cnCaixas, 3)), 3, "0"))
                loc_cTrfNfEnc   = THIS.Dcript(PADL(ALLTRIM(STR(cursor_4c_OpeRed.TrNfis, 2)), 2, "0"))

                loc_cMd5 = THIS.ComputarMD5PafEcf( ;
                               loc_cDopesEnc, loc_cInativaEnc, loc_cDocEnc, ;
                               loc_cCaixaEnc, loc_cTrfNfEnc, ;
                               par_cDopesDecod, ;
                               THIS.Cript(loc_cCaixaEnc), THIS.Cript(loc_cTrfNfEnc))

                loc_cSQL = "UPDATE SigCdPaf SET" + ;
                           " Inativas = " + EscaparSQL(loc_cInativaEnc) + "," + ;
                           " Docs = " + EscaparSQL(loc_cDocEnc) + "," + ;
                           " cMd5s = " + EscaparSQL(loc_cMd5) + "," + ;
                           " cnCaixas = " + EscaparSQL(loc_cCaixaEnc) + "," + ;
                           " TrNfis = " + EscaparSQL(loc_cTrfNfEnc) + ;
                           " WHERE Dopes = " + EscaparSQL(loc_cDopesEnc)
                *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
                IF USED("cursor_4c_UpdRed")
                    TABLEREVERT(.T., "cursor_4c_UpdRed")
                    USE IN cursor_4c_UpdRed
                ENDIF

                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_UpdRed")
                IF USED("cursor_4c_UpdRed")
                    USE IN cursor_4c_UpdRed
                ENDIF
                IF loc_nResult >= 0
                    loc_lSucesso = .T.
                ELSE
                    MsgErro("Erro ao redefinir SigCdPaf para " + par_cDopesDecod + ": " + ;
                            CapturarErroSQL(), "Erro SQL")
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em pafBO.RedefinirPadroesOperacao: " + loc_oErro.Message, "Erro")
        ENDTRY

        IF USED("cursor_4c_OpeRed")
            USE IN cursor_4c_OpeRed
        ENDIF

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * ExisteDopesNoPaf - Verifica se um Dopes (plain text) tem registro em SigCdPaf
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION ExisteDopesNoPaf(par_cDopesPlain)
        LOCAL loc_cSQL, loc_nResult, loc_lExiste
        loc_lExiste = .F.

        TRY
            *-- SigCdPaf.Dopes e codificado; codificamos o plain para buscar
            loc_cSQL = "SELECT COUNT(*) AS Qtd FROM SigCdPaf WHERE Dopes = " + ;
                       EscaparSQL(THIS.Dcript(ALLTRIM(par_cDopesPlain)))
            *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
            IF USED("cursor_4c_ExPaf")
                TABLEREVERT(.T., "cursor_4c_ExPaf")
                USE IN cursor_4c_ExPaf
            ENDIF

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ExPaf")
            IF loc_nResult >= 0 AND RECCOUNT("cursor_4c_ExPaf") > 0
                SELECT cursor_4c_ExPaf
                loc_lExiste = (cursor_4c_ExPaf.Qtd > 0)
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em pafBO.ExisteDopesNoPaf: " + loc_oErro.Message, "Erro")
        ENDTRY

        IF USED("cursor_4c_ExPaf")
            USE IN cursor_4c_ExPaf
        ENDIF

        RETURN loc_lExiste
    ENDFUNC

    *--------------------------------------------------------------------------
    * ExisteDopesNaOperacao - Verifica se um Dopes decodificado existe em SigOpCdd
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION ExisteDopesNaOperacao(par_cDopesPlain)
        LOCAL loc_cSQL, loc_nResult, loc_lExiste
        loc_lExiste = .F.

        TRY
            *-- SigOpCdd.Dopes e plain text
            loc_cSQL = "SELECT COUNT(*) AS Qtd FROM SigOpCdd WHERE pafEcfs = 1 AND Dopes = " + ;
                       EscaparSQL(ALLTRIM(par_cDopesPlain))
            *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
            IF USED("cursor_4c_ExOpe")
                TABLEREVERT(.T., "cursor_4c_ExOpe")
                USE IN cursor_4c_ExOpe
            ENDIF

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ExOpe")
            IF loc_nResult >= 0 AND RECCOUNT("cursor_4c_ExOpe") > 0
                SELECT cursor_4c_ExOpe
                loc_lExiste = (cursor_4c_ExOpe.Qtd > 0)
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em pafBO.ExisteDopesNaOperacao: " + loc_oErro.Message, "Erro")
        ENDTRY

        IF USED("cursor_4c_ExOpe")
            USE IN cursor_4c_ExOpe
        ENDIF

        RETURN loc_lExiste
    ENDFUNC

    *--------------------------------------------------------------------------
    * Cript - Wrapper para fCriptografar (decodifica valor do banco para exibicao)
    * ATENCAO: a funcao legada chama-se fCriptografar mas DECODIFICA para exibir
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION Cript(par_cValor)
        LOCAL loc_cResultado
        loc_cResultado = ALLTRIM(par_cValor)

        TRY
            loc_cResultado = fCriptografar(ALLTRIM(par_cValor))
        CATCH TO loc_oErro
            MsgErro("fCriptografar n" + CHR(227) + "o dispon" + CHR(237) + "vel: " + ;
                    loc_oErro.Message + CHR(13) + ;
                    "Verifique se o Framework Fortyus est" + CHR(225) + ;
                    " carregado (sigfuncs.prg).", "Erro PAF-ECF")
        ENDTRY

        RETURN loc_cResultado
    ENDFUNC

    *--------------------------------------------------------------------------
    * Dcript - Wrapper para fDecriptografar (codifica valor para armazenamento)
    * ATENCAO: a funcao legada chama-se fDecriptografar mas CODIFICA para gravar
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION Dcript(par_cValor)
        LOCAL loc_cResultado
        loc_cResultado = ALLTRIM(par_cValor)

        TRY
            loc_cResultado = fDecriptografar(ALLTRIM(par_cValor))
        CATCH TO loc_oErro
            MsgErro("fDecriptografar n" + CHR(227) + "o dispon" + CHR(237) + "vel: " + ;
                    loc_oErro.Message + CHR(13) + ;
                    "Verifique se o Framework Fortyus est" + CHR(225) + ;
                    " carregado (sigfuncs.prg).", "Erro PAF-ECF")
        ENDTRY

        RETURN loc_cResultado
    ENDFUNC

    *--------------------------------------------------------------------------
    * GerarMD5 - Wrapper para fGerarMD52016
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION GerarMD5(par_cCursor, par_cCampos)
        LOCAL loc_cResultado
        loc_cResultado = ""

        TRY
            loc_cResultado = fGerarMD52016(par_cCursor, par_cCampos)
        CATCH TO loc_oErro
            MsgErro("fGerarMD52016 n" + CHR(227) + "o dispon" + CHR(237) + "vel: " + ;
                    loc_oErro.Message + CHR(13) + ;
                    "Verifique se o Framework Fortyus est" + CHR(225) + " carregado.", ;
                    "Erro PAF-ECF")
        ENDTRY

        RETURN loc_cResultado
    ENDFUNC

ENDDEFINE

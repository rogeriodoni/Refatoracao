*==============================================================================
* SIGREGDPBO.PRG
* Business Object - Emissao Global de Duplicatas/Boletos (SIGREGDP)
* Herda de: RelatorioBase
*
* Funcionalidade:
*   - Filtros: Serie NF, NF Inicial/Final, tipo (Duplicatas ou Boletos)
*   - Carrega SigMvNfi join SigMvPar no cursor de dados (equivalente TmpNFis)
*   - Impressao: chama SigIpDup (Duplicatas) ou SigPrIbl/SigPrIbb (Boletos)
*==============================================================================

DEFINE CLASS SIGREGDPBO AS RelatorioBase

    *-- Identificacao (sem tabela CRUD - form operacional)
    this_cTabela        = ""
    this_cCampoChave    = ""

    *-- Filtros do formulario
    this_cSerieNf       = ""    && Serie da NF (Get_Serie, C(3))
    this_cNFIni         = ""    && NF Inicial (Get_NFIni, C(6))
    this_cNFFim         = ""    && NF Final (Get_NFFim, C(6))
    this_nSelecao       = 0     && 1=Duplicatas, 2=Boletos Bancarios

    *-- Nomes dos cursores de trabalho
    this_cCursorDados   = "cursor_4c_Dados"     && Equivalente a TmpNFis (grid)
    this_cCursorOpFp    = "cursor_4c_OpFp"      && SigOpFp (FPags, ImpDups, ImpBols, ImpNotas)
    this_cCursorPam     = "cursor_4c_Pam"       && SigCdPam (MascNums)
    this_cCursorNfi     = "cursor_4c_NfiFiltro" && SigMvNfi JOIN SigMvPar filtrado
    this_cCursorCli     = "cursor_4c_Cli"       && SigCdCli (RClis - nome do cliente)

    *-- Estado interno
    this_lProcessado    = .F.   && .T. apos PrepararDados() executado com sucesso

    *--------------------------------------------------------------------------
    * Init - Inicializa o BO e cursores auxiliares
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            THIS.this_cTabela     = ""
            THIS.this_cCampoChave = ""

            IF DODEFAULT()
                IF THIS.InicializarCursores()
                    loc_lSucesso = .T.
                ENDIF
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "SIGREGDPBO.Init")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * InicializarCursores - Cria cursor local de dados e carrega auxiliares
    *--------------------------------------------------------------------------
    PROCEDURE InicializarCursores()
        LOCAL loc_lSucesso, loc_cSQL, loc_nResult
        loc_lSucesso = .F.

        TRY
            *-- Criar cursor local equivalente ao TmpNFis do legado
            IF USED(THIS.this_cCursorDados)
                USE IN (THIS.this_cCursorDados)
            ENDIF
            SET NULL ON
            CREATE CURSOR cursor_4c_Dados ( ;
                flag     L, ;
                datas    D NULL, ;
                nfis     C(6), ;
                valor    N(12,2), ;
                conta    C(40), ;
                digito   N(1), ;
                vecto    C(12), ;
                totnotas N(12,2), ;
                emps     C(3), ;
                dopes    C(20), ;
                numes    N(6), ;
                obs      M NULL, ;
                parcs    N(2) ;
            )
            SET NULL OFF

            *-- Em modo validacao UI, nao executar SQLs (sem conexao)
            IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
                loc_lSucesso = .T.
            ELSE
                *-- Carregar SigOpFp (formas de pagamento com flags de impressao)
                loc_cSQL = "SELECT fpags, impdups, impbols, impnotas FROM SigOpFp"
                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, THIS.this_cCursorOpFp)
                IF loc_nResult > 0
                    loc_lSucesso = .T.
                ELSE
                    THIS.this_cMensagemErro = "Erro ao carregar formas de pagamento (SigOpFp)"
                ENDIF

                *-- Carregar SigCdPam (mascara de numeros) - nao critico para funcionamento
                loc_cSQL = "SELECT mascnums FROM SigCdPam"
                SQLEXEC(gnConnHandle, loc_cSQL, THIS.this_cCursorPam)
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "SIGREGDPBO.InicializarCursores")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * PrepararDados - Processa NFs conforme filtros (equivalente Processar.Click)
    * Popula cursor_4c_Dados com os registros filtrados e validados
    *--------------------------------------------------------------------------
    PROCEDURE PrepararDados()
        LOCAL loc_lSucesso, loc_cSQL, loc_nResult
        LOCAL loc_cFPags, loc_cCliFors, loc_cNfis, loc_cConta, loc_cVecto
        LOCAL loc_nValos, loc_dDatas, loc_nParcs, loc_nNumes, loc_nTotNot
        LOCAL loc_cEmps, loc_cDopes, loc_cObs, loc_dVencs
        LOCAL loc_nImpDups, loc_nImpBols, loc_nImpNot, loc_nConta
        loc_lSucesso = .F.

        TRY
            *-- ZAP cursor de dados e resetar estado
            IF USED(THIS.this_cCursorDados)
                ZAP IN (THIS.this_cCursorDados)
            ENDIF
            THIS.this_lProcessado = .F.

            *-- Consultar SigMvNfi JOIN SigMvPar com filtros informados
            loc_cSQL = "SELECT a.nfis, a.clifors, a.totnotas, a.emps, a.dopes, a.numes, " + ;
                       "b.fpags, b.parcs, b.valos, b.datas, b.vencs, b.obs " + ;
                       "FROM SigMvNfi a " + ;
                       "INNER JOIN SigMvPar b ON a.empdopnums = b.empdopnums " + ;
                       "WHERE a.nfis BETWEEN " + EscaparSQL(THIS.this_cNFIni) + ;
                       " AND " + EscaparSQL(THIS.this_cNFFim) + ;
                       " AND a.series = " + EscaparSQL(THIS.this_cSerieNf) + ;
                       " ORDER BY a.emps, a.dopes, a.numes, b.fpags, b.parcs"

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, THIS.this_cCursorNfi)
            IF loc_nResult < 1
                THIS.this_cMensagemErro = "Erro ao consultar notas fiscais. Verifique a conex" + ;
                                          CHR(227) + "o."
            ELSE
                WAIT WINDOW "Aguarde!!! Selecionando Notas Fiscais..." NOWAIT

                *-- Iterar sobre registros e popular cursor_4c_Dados
                SELECT (THIS.this_cCursorNfi)
                SCAN
                    *-- Capturar todos os valores necessarios antes de trocar de area
                    loc_cFPags   = ALLTRIM(cursor_4c_NfiFiltro.fpags)
                    loc_cCliFors = ALLTRIM(cursor_4c_NfiFiltro.clifors)
                    loc_cNfis    = ALLTRIM(cursor_4c_NfiFiltro.nfis)
                    loc_nValos   = cursor_4c_NfiFiltro.valos
                    loc_dDatas   = TTOD(NVL(cursor_4c_NfiFiltro.datas, CTOT("")))
                    loc_nParcs   = cursor_4c_NfiFiltro.parcs
                    loc_cEmps    = ALLTRIM(cursor_4c_NfiFiltro.emps)
                    loc_cDopes   = ALLTRIM(cursor_4c_NfiFiltro.dopes)
                    loc_nNumes   = cursor_4c_NfiFiltro.numes
                    loc_cObs     = NVL(cursor_4c_NfiFiltro.obs, "")
                    loc_nTotNot  = cursor_4c_NfiFiltro.totnotas
                    loc_dVencs   = cursor_4c_NfiFiltro.vencs

                    *-- Verificar forma de pagamento habilitada em SigOpFp
                    SELECT (THIS.this_cCursorOpFp)
                    LOCATE FOR ALLTRIM(fpags) = loc_cFPags

                    IF !FOUND()
                        SELECT (THIS.this_cCursorNfi)
                        LOOP
                    ENDIF

                    *-- Capturar flags de impressao da forma de pagamento
                    loc_nImpDups = cursor_4c_OpFp.impdups
                    loc_nImpBols = cursor_4c_OpFp.impbols
                    loc_nImpNot  = cursor_4c_OpFp.impnotas

                    *-- Filtrar por tipo de selecao (Duplicatas ou Boletos)
                    IF ((THIS.this_nSelecao = 1) AND (loc_nImpDups <> 1)) OR ;
                       ((THIS.this_nSelecao = 2) AND (loc_nImpBols <> 1))
                        SELECT (THIS.this_cCursorNfi)
                        LOOP
                    ENDIF

                    *-- Numero da parcela (digito)
                    loc_nConta = loc_nParcs

                    loc_cConta = loc_cCliFors

                    *-- Calcular campo Vecto: data de vencimento ou forma de pagamento
                    IF loc_nImpNot = 1
                        loc_cVecto = DTOC(TTOD(NVL(loc_dVencs, CTOT(""))))
                    ELSE
                        loc_cVecto = loc_cFPags
                    ENDIF

                    *-- Inserir registro processado no cursor de dados
                    SELECT (THIS.this_cCursorDados)
                    INSERT INTO cursor_4c_Dados ( ;
                        flag, nfis, valor, datas, conta, digito, parcs, ;
                        vecto, totnotas, obs, emps, dopes, numes) ;
                    VALUES ( ;
                        .T., ;
                        loc_cNfis, ;
                        loc_nValos, ;
                        loc_dDatas, ;
                        loc_cConta, ;
                        loc_nConta, ;
                        loc_nParcs, ;
                        loc_cVecto, ;
                        loc_nTotNot, ;
                        loc_cObs, ;
                        loc_cEmps, ;
                        loc_cDopes, ;
                        loc_nNumes ;
                    )

                    SELECT (THIS.this_cCursorNfi)
                ENDSCAN

                WAIT CLEAR

                *-- Verificar resultado e alertar se vazio
                SELECT (THIS.this_cCursorDados)
                GO TOP
                IF EOF()
                    IF THIS.this_nSelecao = 1
                        MsgAviso("Nenhuma Duplicata Selecionada...")
                    ELSE
                        MsgAviso("Nenhum Boleto Banc" + CHR(225) + "rio Selecionado...")
                    ENDIF
                ENDIF

                THIS.this_lProcessado = .T.
                loc_lSucesso = .T.
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "SIGREGDPBO.PrepararDados")
            WAIT CLEAR
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Imprimir - Emite duplicatas ou boletos para os registros selecionados
    * Equivalente ao procedure "impressao" do legado
    *--------------------------------------------------------------------------
    PROCEDURE Imprimir()
        LOCAL loc_lSucesso, loc_cSQL, loc_nResult, loc_nQt, loc_cChave
        loc_lSucesso = .F.

        TRY
            IF !THIS.this_lProcessado
                MsgAviso("Execute o Processamento antes de Imprimir.")
            ELSE
                IF THIS.this_nSelecao = 1
                    *-- Emissao de Duplicatas via funcao legada SigIpDup
                    =SigIpDup("", THIS.this_cSerieNf, .T., .NULL.)
                    loc_lSucesso = .T.
                ELSE
                    *-- Emissao de Boletos Bancarios
                    *-- Montar cursor cabecalho agrupado por NF
                    IF USED("cursor_4c_MvCab")
                        USE IN cursor_4c_MvCab
                    ENDIF
                    SELECT emps, dopes, numes, parcs ;
                        FROM (THIS.this_cCursorDados) ;
                        WHERE flag ;
                        GROUP BY emps, dopes, numes, parcs ;
                        INTO CURSOR cursor_4c_MvCab READWRITE

                    *-- Verificar configuracao de boleto bancario em SigCnFBl
                    loc_cSQL = "SELECT COUNT(*) AS qt FROM SigCnFBl WHERE fpags <> ' '"
                    loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_CfgBol")
                    IF loc_nResult < 1
                        MsgErro("Favor Reinicializar o Processo!!!", ;
                                "Falha na Conex" + CHR(227) + "o (SigCnFBl)")
                    ELSE
                        SELECT cursor_4c_CfgBol
                        loc_nQt = NVL(qt, 0)
                        USE IN cursor_4c_CfgBol

                        IF loc_nQt = 0
                            *-- Sem boleto bancario configurado: imprimir simples
                            DO FORM SigPrIbl WITH "", .NULL.
                        ELSE
                            *-- Com boleto bancario: imprimir por NF individualmente
                            SELECT cursor_4c_MvCab
                            SCAN
                                loc_cChave = cursor_4c_MvCab.emps + ;
                                             cursor_4c_MvCab.dopes + ;
                                             STR(cursor_4c_MvCab.numes, 6)
                                DO FORM SigPrIbb WITH loc_cChave, .NULL.
                            ENDSCAN
                        ENDIF

                        loc_lSucesso = .T.
                    ENDIF

                    IF USED("cursor_4c_MvCab")
                        USE IN cursor_4c_MvCab
                    ENDIF
                ENDIF

                *-- Reposicionar cursor de dados no final (comportamento original)
                IF USED(THIS.this_cCursorDados)
                    SELECT (THIS.this_cCursorDados)
                    GO BOTTOM
                ENDIF
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "SIGREGDPBO.Imprimir")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * SelecionarTodos - Marca Flag=.T. em todos os registros do cursor de dados
    * Equivalente ao botao SelTudo do legado
    *--------------------------------------------------------------------------
    PROCEDURE SelecionarTodos()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF USED(THIS.this_cCursorDados)
                UPDATE (THIS.this_cCursorDados) SET flag = .T.
                loc_lSucesso = .T.
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "SIGREGDPBO.SelecionarTodos")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * DesmarcarTodos - Marca Flag=.F. em todos os registros do cursor de dados
    * Equivalente ao botao apaga do legado
    *--------------------------------------------------------------------------
    PROCEDURE DesmarcarTodos()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF USED(THIS.this_cCursorDados)
                UPDATE (THIS.this_cCursorDados) SET flag = .F.
                loc_lSucesso = .T.
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "SIGREGDPBO.DesmarcarTodos")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Visualizar - Exibe relatorio em modo impressao (original: Visualiza oculto)
    * No legado btnReport.Visualiza.Visible = .F. - nao havia preview separado.
    * Delega para Imprimir() para compatibilidade com qualquer chamada residual.
    *--------------------------------------------------------------------------
    PROCEDURE Visualizar()
        RETURN THIS.Imprimir()
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Stub (relatorio nao possui chave primaria)
    *--------------------------------------------------------------------------
    PROCEDURE ObterChavePrimaria()
        RETURN ""
    ENDPROC

    *--------------------------------------------------------------------------
    * Destroy - Fecha todos os cursores abertos
    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
        IF USED(THIS.this_cCursorDados)
            USE IN (THIS.this_cCursorDados)
        ENDIF
        IF USED(THIS.this_cCursorOpFp)
            USE IN (THIS.this_cCursorOpFp)
        ENDIF
        IF USED(THIS.this_cCursorPam)
            USE IN (THIS.this_cCursorPam)
        ENDIF
        IF USED(THIS.this_cCursorNfi)
            USE IN (THIS.this_cCursorNfi)
        ENDIF
        IF USED(THIS.this_cCursorCli)
            USE IN (THIS.this_cCursorCli)
        ENDIF
        DODEFAULT()
    ENDPROC

ENDDEFINE

*==============================================================================
* SIGRECRPBO.PRG
* Business Object para SIGRECRP - Debitos e Creditos em Aberto
* Herda de RelatorioBase
*==============================================================================

DEFINE CLASS sigrecrpBO AS RelatorioBase

    this_cArquivoFRX    = ""
    this_cTitulo        = ""
    this_cCursorDados   = "Resultado"
    this_lMensagemAviso = .F.

    *-- Opcao: 1=Debito (D), 2=Credito (C)
    this_nOper          = 1

    *-- Grupo conta contabil principal
    this_cGrupo         = ""
    this_cDsGrupo       = ""

    *-- Conta contabil principal
    this_cConta         = ""
    this_cDConta        = ""

    *-- Subgrupo contra partida
    this_cSgrupo        = ""
    this_cDsgrupo       = ""

    *-- Subconta contra partida
    this_cSconta        = ""
    this_cDsConta       = ""

    *-- Empresa
    this_cCdEmpresa     = ""
    this_cDsEmpresa     = ""

    *-- Periodo de vencimento
    this_dDtInicial     = {}
    this_dDtFinal       = {}

    *-- Moeda
    this_cCdMoeda       = ""
    this_cDsMoeda       = ""

    *--------------------------------------------------------------------------
    PROCEDURE Init()
        THIS.this_cArquivoFRX = gc_4c_CaminhoReports + "RelSigrecrp.frx"
        THIS.this_cTitulo     = "Relat" + CHR(243) + "rio de D" + CHR(233) + "bitos/Cr" + CHR(233) + "ditos Pendentes"
        THIS.this_dDtInicial  = DATE()
        THIS.this_dDtFinal    = DATE()
        RETURN DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    * PrepararDados - Executa processamento e popula Resultado e CsCabecalho
    * Replica logica completa do procedimento "processamento" do SIGRECRP.SCX
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE PrepararDados()
        LOCAL loc_nResult, loc_cSQL
        LOCAL loc_nOper, loc_cOperacao
        LOCAL loc_cGrupo, loc_cConta, loc_cSgrupo, loc_cSconta
        LOCAL loc_cCdEmpresa, loc_cMoeda
        LOCAL loc_cCbEmpresa, loc_cCbTitulo, loc_cCbPeriodo
        LOCAL loc_nX, loc_cCampoGrupo, loc_cCampoConta
        LOCAL loc_cCodigoGrupo
        LOCAL loc_cContasCab, loc_cNomeCab, loc_dDataCab, loc_cEmpdopnums
        LOCAL loc_cEmps, loc_cDopes, loc_cNumes, loc_cHist
        LOCAL loc_nValor, loc_nTipo, loc_cOpers
        LOCAL ldInicial, ldFinal

        THIS.this_cMensagemErro  = ""
        THIS.this_lMensagemAviso = .F.

        *-- Mapear filtros das propriedades
        loc_nOper      = THIS.this_nOper
        loc_cGrupo     = ALLTRIM(THIS.this_cGrupo)
        loc_cConta     = ALLTRIM(THIS.this_cConta)
        loc_cSgrupo    = ALLTRIM(THIS.this_cSgrupo)
        loc_cSconta    = ALLTRIM(THIS.this_cSconta)
        loc_cCdEmpresa = ALLTRIM(THIS.this_cCdEmpresa)
        loc_cMoeda     = ALLTRIM(THIS.this_cCdMoeda)
        ldInicial      = THIS.this_dDtInicial
        ldFinal        = THIS.this_dDtFinal

        *-- Busca dados da empresa para cabecalho
        loc_cSQL = "SELECT CEmps, Razas FROM SigCdEmp" + ;
                   " WHERE CEmps = " + EscaparSQL(go_4c_Sistema.cCodEmpresa)
        loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_SigrecrpEmp")
        IF loc_nResult < 1
            THIS.this_cMensagemErro = "Favor Reinicializar o Processo!!!" + CHR(13) + ;
                                      "Falha na Conex" + CHR(227) + "o (SigCdEmp)"
            RETURN .F.
        ENDIF
        loc_cCbEmpresa = ""
        SELECT cursor_4c_SigrecrpEmp
        IF !EOF()
            loc_cCbEmpresa = ALLTRIM(cursor_4c_SigrecrpEmp.Razas)
        ENDIF
        USE IN cursor_4c_SigrecrpEmp

        *-- Monta strings de cabecalho
        loc_cOperacao  = IIF(loc_nOper = 1, "D", "C")
        loc_cCbTitulo  = "Relat" + CHR(243) + "rio de " + ;
                         IIF(loc_nOper = 1, "D" + CHR(233) + "bitos", "Cr" + CHR(233) + "ditos") + ;
                         " Pendentes"
        loc_cCbPeriodo = " de " + DTOC(ldInicial) + " " + CHR(224) + " " + DTOC(ldFinal)
        loc_cCbTitulo  = loc_cCbTitulo + loc_cCbPeriodo

        *-- Cursor de cabecalho para o relatorio
        IF USED("CsCabecalho")
            USE IN CsCabecalho
        ENDIF
        SET NULL ON
        CREATE CURSOR CsCabecalho (cb_empresa C(80), cb_titulo C(80), cb_periodo C(80))
        SET NULL OFF
        INSERT INTO CsCabecalho (cb_empresa, cb_titulo, cb_periodo) ;
            VALUES (loc_cCbEmpresa, loc_cCbTitulo, loc_cCbPeriodo)

        *-- Cursor principal de resultado
        IF USED("Resultado")
            USE IN Resultado
        ENDIF
        SET NULL ON
        CREATE CURSOR Resultado ( ;
            Tipo      N(1), ;
            Grupo     C(10), ;
            Conta     C(10), ;
            Nome      C(40), ;
            Empresa   C(3), ;
            Data      D, ;
            Vecto     D, ;
            Historico C(40), ;
            Integral  N(12,2), ;
            Pendente  N(12,2), ;
            Moeda     C(3))
        SET NULL OFF

        *-- Busca grupos contabeis conforme filtro
        loc_cSQL = "SELECT * FROM SigCdGcr" + ;
                   IIF(!EMPTY(loc_cGrupo), " WHERE Codigos = " + EscaparSQL(loc_cGrupo), "") + ;
                   " ORDER BY Codigos"
        loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_SigrecrpGcr")
        IF loc_nResult < 1
            THIS.this_cMensagemErro = "Favor Reinicializar o Processo!!!" + CHR(13) + ;
                                      "Falha na Conex" + CHR(227) + "o (SigCdGcr)"
            RETURN .F.
        ENDIF

        *-- Itera grupos contabeis
        SELECT cursor_4c_SigrecrpGcr
        SCAN
            loc_cCodigoGrupo = ALLTRIM(cursor_4c_SigrecrpGcr.Codigos)

            IF USED("cursor_4c_SigrecrpMvCcr")
                SELECT cursor_4c_SigrecrpMvCcr
                ZAP
                USE IN cursor_4c_SigrecrpMvCcr
            ENDIF

            *-- Busca movimentos conta corrente (SigMvCcr)
            loc_cSQL = "SELECT a.contas, a.grupos, a.Nopers, a.Tipos," + ;
                       " a.Emps, a.Dopes, a.Numes, a.opers, a.Datas," + ;
                       " a.Valors, a.ValPags, a.Moedas, a.Vencs, a.Hists," + ;
                       " b.iclis, b.rclis" + ;
                       " FROM SigMvCcr a, SigCdCli b" + ;
                       " WHERE b.iclis = a.contas" + ;
                       IIF(!EMPTY(loc_cConta),     " AND a.Contas = "  + EscaparSQL(loc_cConta), " ") + ;
                       IIF(!EMPTY(loc_cCdEmpresa), " AND a.Emps = "    + EscaparSQL(loc_cCdEmpresa), "") + ;
                       IIF(!EMPTY(loc_cSgrupo),    " AND a.Sgrupos = " + EscaparSQL(loc_cSgrupo), " ") + ;
                       IIF(!EMPTY(loc_cSconta),    " AND a.SContas = " + EscaparSQL(loc_cSconta), " ") + ;
                       IIF(!EMPTY(loc_cMoeda),     " AND a.Moedas = "  + EscaparSQL(loc_cMoeda), " ") + ;
                       " AND a.Nopers <> 0 AND (a.Tipos = ' ' OR a.Tipos = 'X')" + ;
                       " AND a.Opers = " + EscaparSQL(loc_cOperacao) + ;
                       " AND a.grupos = " + EscaparSQL(loc_cCodigoGrupo) + ;
                       " AND a.Vencs BETWEEN ?ldInicial AND ?ldFinal" + ;
                       " ORDER BY GruConMoes"
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_SigrecrpMvCcr")
            IF loc_nResult < 1
                THIS.this_cMensagemErro = "Favor Reinicializar o Processo!!!" + CHR(13) + ;
                                          "Falha na Conex" + CHR(227) + "o (SigMvCcr)"
                RETURN .F.
            ENDIF

            *-- Processa movimentos conta corrente
            SELECT cursor_4c_SigrecrpMvCcr
            SCAN
                IF !EMPTY(cursor_4c_SigrecrpMvCcr.Dopes) AND ;
                   !EMPTY(cursor_4c_SigrecrpMvCcr.Numes) AND ;
                   ALLTRIM(cursor_4c_SigrecrpMvCcr.Tipos) <> "X"
                    LOOP
                ENDIF
                loc_nValor = cursor_4c_SigrecrpMvCcr.Valors - cursor_4c_SigrecrpMvCcr.ValPags
                IF loc_nValor <> 0
                    INSERT INTO Resultado (Tipo, Grupo, Conta, Nome, Empresa, ;
                        Data, Vecto, Historico, Integral, Pendente, Moeda) ;
                        VALUES (1, loc_cCodigoGrupo, ;
                            ALLTRIM(cursor_4c_SigrecrpMvCcr.Contas), ;
                            ALLTRIM(cursor_4c_SigrecrpMvCcr.RClis), ;
                            ALLTRIM(cursor_4c_SigrecrpMvCcr.Emps), ;
                            NVL(cursor_4c_SigrecrpMvCcr.Datas, CTOD(SPACE(8))), ;
                            NVL(cursor_4c_SigrecrpMvCcr.Vencs, CTOD(SPACE(8))), ;
                            ALLTRIM(cursor_4c_SigrecrpMvCcr.Hists), ;
                            cursor_4c_SigrecrpMvCcr.Valors, ;
                            loc_nValor, ;
                            ALLTRIM(cursor_4c_SigrecrpMvCcr.Moedas))
                ENDIF
            ENDSCAN

            *-- Loop x=1 (Grupods/Contads) e x=2 (Grupoos/Contaos) - SigMvCab
            FOR loc_nX = 1 TO 2
                IF loc_nX = 1
                    loc_cCampoGrupo = "Grupods"
                    loc_cCampoConta = "Contads"
                ELSE
                    loc_cCampoGrupo = "Grupoos"
                    loc_cCampoConta = "Contaos"
                ENDIF

                loc_cSQL = "SELECT a.empdopnums, a." + loc_cCampoGrupo + ;
                           ", a." + loc_cCampoConta + ", a.Datas," + ;
                           " b.Dopes, b.ValPends, b.parcs, b.Copers, c.iclis, c.rclis" + ;
                           " FROM SigMvCab a, SigCdOpe b, SigCdCli c" + ;
                           " WHERE a." + loc_cCampoGrupo + " = " + EscaparSQL(loc_cCodigoGrupo) + ;
                           IIF(!EMPTY(loc_cConta), " AND a." + loc_cCampoConta + " = " + EscaparSQL(loc_cConta), "") + ;
                           " AND (b.Dopes = a.Dopes AND b.ValPends = 1 AND b.parcs = 1)" + ;
                           IIF(!EMPTY(loc_cCdEmpresa), " AND a.Emps = " + EscaparSQL(loc_cCdEmpresa), "") + ;
                           IIF(!EMPTY(loc_cSgrupo), " AND 0 = 1", "") + ;
                           IIF(!EMPTY(loc_cSconta), " AND 0 = 1", "") + ;
                           " AND c.iclis = a." + loc_cCampoConta + ;
                           " ORDER BY " + loc_cCampoGrupo + ", " + loc_cCampoConta
                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_SigrecrpMvCab")
                IF loc_nResult < 1
                    THIS.this_cMensagemErro = "Favor Reinicializar o Processo!!!" + CHR(13) + ;
                                              "Falha na Conex" + CHR(227) + "o (SigMvCab)"
                    RETURN .F.
                ENDIF

                SELECT cursor_4c_SigrecrpMvCab
                GO TOP
                SCAN
                    *-- Captura valores da linha atual de MvCab antes de entrar no SCAN interno
                    loc_cContasCab  = EVALUATE("cursor_4c_SigrecrpMvCab." + loc_cCampoConta)
                    loc_cNomeCab    = ALLTRIM(cursor_4c_SigrecrpMvCab.rclis)
                    loc_dDataCab    = cursor_4c_SigrecrpMvCab.Datas
                    loc_cEmpdopnums = ALLTRIM(cursor_4c_SigrecrpMvCab.empdopnums)

                    loc_cSQL = "SELECT a.empdopnums, a.VPags, a.Valos, a.FPags, a.Moefpgs," + ;
                               " a.Bancos, a.Agencias, a.Contas, a.Numeros, a.Nopers, a.Vencs" + ;
                               " FROM SigMvPar a" + ;
                               " WHERE a.Vencs BETWEEN ?ldInicial AND ?ldFinal" + ;
                               " AND a.empdopnums = " + EscaparSQL(loc_cEmpdopnums) + ;
                               IIF(EMPTY(loc_cMoeda), "", " AND a.Moefpgs = " + EscaparSQL(loc_cMoeda))
                    loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_SigrecrpMvPar")
                    IF loc_nResult < 1
                        THIS.this_cMensagemErro = "Favor Reinicializar o Processo!!!" + CHR(13) + ;
                                                  "Falha na Conex" + CHR(227) + "o (SigMvPar)"
                        RETURN .F.
                    ENDIF

                    SELECT cursor_4c_SigrecrpMvPar
                    SCAN
                        loc_cSQL = "SELECT a.FPags, a.ValPends, a.Infos, a.Grupods, a.contads" + ;
                                   " FROM SigOpFp a" + ;
                                   " WHERE a.FPags = " + EscaparSQL(ALLTRIM(cursor_4c_SigrecrpMvPar.FPags))
                        loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_SigrecrpOpFp")
                        IF loc_nResult < 1
                            THIS.this_cMensagemErro = "Favor Reinicializar o Processo!!!" + CHR(13) + ;
                                                      "Falha na Conex" + CHR(227) + "o (SigOpFps)"
                            RETURN .F.
                        ENDIF

                        IF (cursor_4c_SigrecrpOpFp.Valpends <> 1 OR ;
                            cursor_4c_SigrecrpMvPar.Nopers = 0) AND ;
                           cursor_4c_SigrecrpMvPar.VPags = cursor_4c_SigrecrpMvPar.Valos
                            LOOP
                        ENDIF
                        IF !EMPTY(cursor_4c_SigrecrpOpFp.Grupods) AND ;
                           !EMPTY(cursor_4c_SigrecrpOpFp.Contads) AND ;
                           cursor_4c_SigrecrpMvPar.VPags = cursor_4c_SigrecrpMvPar.Valos
                            LOOP
                        ENDIF

                        *-- Verifica cheque se forma de pagamento = "C"
                        IF ALLTRIM(cursor_4c_SigrecrpOpFp.Infos) = "C"
                            loc_cSQL = "SELECT a.UMovs FROM SigChe a" + ;
                                       " WHERE a.Bancos = "   + EscaparSQL(ALLTRIM(cursor_4c_SigrecrpMvPar.Bancos)) + ;
                                       " AND a.Agencias = "   + EscaparSQL(ALLTRIM(cursor_4c_SigrecrpMvPar.Agencias)) + ;
                                       " AND a.Contas = "     + EscaparSQL(ALLTRIM(cursor_4c_SigrecrpMvPar.Contas)) + ;
                                       " AND a.ncheques = "   + EscaparSQL(ALLTRIM(cursor_4c_SigrecrpMvPar.Numeros))
                            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_SigrecrpChe")
                            IF loc_nResult < 1
                                THIS.this_cMensagemErro = "Favor Reinicializar o Processo!!!" + CHR(13) + ;
                                                          "Falha na Conex" + CHR(227) + "o (SigChe)"
                                RETURN .F.
                            ENDIF

                            loc_cSQL = "SELECT a.operacaos FROM SigCdOpt a" + ;
                                       " WHERE a.Operacaos = " + EscaparSQL(ALLTRIM(cursor_4c_SigrecrpChe.UMovs)) + ;
                                       " AND a.Tipos = 'DB'"
                            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_SigrecrpOpt")
                            IF loc_nResult < 1
                                THIS.this_cMensagemErro = "Favor Reinicializar o Processo!!!" + CHR(13) + ;
                                                          "Falha na Conex" + CHR(227) + "o (SigCdOpt)"
                                RETURN .F.
                            ENDIF

                            SELECT cursor_4c_SigrecrpOpt
                            GO TOP
                            IF EOF()
                                SELECT cursor_4c_SigrecrpMvPar
                                LOOP
                            ENDIF
                        ENDIF

                        *-- Determina direcao da operacao (D=debito, C=credito)
                        IF cursor_4c_SigrecrpOpFp.Valpends <> 1 AND ;
                           cursor_4c_SigrecrpMvPar.VPags <> cursor_4c_SigrecrpMvPar.Valos
                            loc_cOpers = IIF(cursor_4c_SigrecrpMvCab.Copers = 1, "C", "D")
                        ELSE
                            loc_cOpers = IIF(cursor_4c_SigrecrpMvCab.Copers = 1, "D", "C")
                        ENDIF

                        *-- Filtra por tipo de operacao solicitado
                        IF (loc_nOper = 1 AND loc_cOpers = "C") OR ;
                           (loc_nOper = 2 AND loc_cOpers = "D")
                            SELECT cursor_4c_SigrecrpMvPar
                            LOOP
                        ENDIF

                        loc_cEmps  = SUBSTR(ALLTRIM(cursor_4c_SigrecrpMvPar.empdopnums), 1, 3)
                        loc_cDopes = SUBSTR(ALLTRIM(cursor_4c_SigrecrpMvPar.empdopnums), 4, 20)
                        loc_cNumes = SUBSTR(ALLTRIM(cursor_4c_SigrecrpMvPar.empdopnums), 24, 6)
                        loc_cHist  = ALLTRIM(cursor_4c_SigrecrpMvPar.FPags) + " " + ;
                                     loc_cEmps + ALLTRIM(loc_cDopes) + " " + ALLTRIM(loc_cNumes)
                        loc_nValor = cursor_4c_SigrecrpMvPar.Valos - cursor_4c_SigrecrpMvPar.VPags

                        IF loc_nValor = 0
                            SELECT cursor_4c_SigrecrpMvPar
                            LOOP
                        ENDIF

                        INSERT INTO Resultado (Tipo, Grupo, Conta, Nome, Empresa, ;
                            Data, Vecto, Historico, Integral, Pendente, Moeda) ;
                            VALUES (1, loc_cCodigoGrupo, ALLTRIM(loc_cContasCab), ;
                                ALLTRIM(loc_cNomeCab), ALLTRIM(loc_cEmps), ;
                                loc_dDataCab, cursor_4c_SigrecrpMvPar.Vencs, ;
                                ALLTRIM(loc_cHist), cursor_4c_SigrecrpMvPar.Valos, ;
                                loc_nValor, ALLTRIM(cursor_4c_SigrecrpMvPar.Moefpgs))

                        SELECT cursor_4c_SigrecrpMvPar
                    ENDSCAN

                    IF USED("cursor_4c_SigrecrpMvPar")
                        USE IN cursor_4c_SigrecrpMvPar
                    ENDIF

                    SELECT cursor_4c_SigrecrpMvCab
                ENDSCAN

                IF USED("cursor_4c_SigrecrpMvCab")
                    USE IN cursor_4c_SigrecrpMvCab
                ENDIF
            ENDFOR

            SELECT cursor_4c_SigrecrpGcr
        ENDSCAN

        IF USED("cursor_4c_SigrecrpGcr")
            USE IN cursor_4c_SigrecrpGcr
        ENDIF
        IF USED("cursor_4c_SigrecrpMvCcr")
            USE IN cursor_4c_SigrecrpMvCcr
        ENDIF

        *-- Verifica se ha dados no resultado
        SELECT Resultado
        INDEX ON STR(Tipo, 1) + Empresa + Grupo + Conta + DTOS(Vecto) TAG GruConVec
        GO TOP
        IF EOF()
            THIS.this_cMensagemErro  = "N" + CHR(227) + "o h" + CHR(225) + " " + ;
                IIF(loc_nOper = 1, "D" + CHR(233) + "bitos", "Cr" + CHR(233) + "ditos") + ;
                " pendente nesta conta!"
            THIS.this_lMensagemAviso = .T.
            RETURN .F.
        ENDIF

        *-- Totaliza por moeda e insere linhas de totalizacao
        IF USED("cursor_4c_SigrecrpTotaliza")
            USE IN cursor_4c_SigrecrpTotaliza
        ENDIF
        SELECT Moeda, SUM(Integral) AS Integral, SUM(Pendente) AS Pendente ;
            FROM Resultado ;
            GROUP BY Moeda ;
            ORDER BY Moeda ;
            INTO CURSOR cursor_4c_SigrecrpTotaliza

        loc_nTipo = 2
        SELECT cursor_4c_SigrecrpTotaliza
        SCAN
            SELECT Resultado
            INSERT INTO Resultado (Tipo, Moeda, Pendente, Integral) ;
                VALUES (loc_nTipo, ALLTRIM(cursor_4c_SigrecrpTotaliza.Moeda), ;
                    cursor_4c_SigrecrpTotaliza.Pendente, ;
                    cursor_4c_SigrecrpTotaliza.Integral)
            IF loc_nTipo = 2
                loc_nTipo = 3
            ENDIF
            SELECT cursor_4c_SigrecrpTotaliza
        ENDSCAN

        IF USED("cursor_4c_SigrecrpTotaliza")
            USE IN cursor_4c_SigrecrpTotaliza
        ENDIF

        SELECT Resultado
        GO TOP

        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * Visualizar - Exibe relatorio em tela (preview)
    *--------------------------------------------------------------------------
    PROCEDURE Visualizar()
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.
        TRY
            IF THIS.PrepararDados()
                REPORT FORM (THIS.this_cArquivoFRX) PREVIEW NOCONSOLE
                loc_lSucesso = .T.
            ELSE
                IF !EMPTY(THIS.this_cMensagemErro)
                    IF THIS.this_lMensagemAviso
                        MsgAviso(THIS.this_cMensagemErro, "Aten" + CHR(231) + CHR(227) + "o")
                    ELSE
                        MsgErro(THIS.this_cMensagemErro, "Erro")
                    ENDIF
                    THIS.this_cMensagemErro = ""
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Visualizar")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Imprimir - Imprime relatorio na impressora com dialogo de escolha
    *--------------------------------------------------------------------------
    PROCEDURE Imprimir()
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.
        TRY
            IF THIS.PrepararDados()
                REPORT FORM (THIS.this_cArquivoFRX) TO PRINTER PROMPT NOCONSOLE
                loc_lSucesso = .T.
            ELSE
                IF !EMPTY(THIS.this_cMensagemErro)
                    IF THIS.this_lMensagemAviso
                        MsgAviso(THIS.this_cMensagemErro, "Aten" + CHR(231) + CHR(227) + "o")
                    ELSE
                        MsgErro(THIS.this_cMensagemErro, "Erro")
                    ENDIF
                    THIS.this_cMensagemErro = ""
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Imprimir")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterMensagemErro - Retorna ultima mensagem de erro
    *--------------------------------------------------------------------------
    PROCEDURE ObterMensagemErro()
        RETURN THIS.this_cMensagemErro
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Retorna chave logica do relatorio (filtros aplicados)
    * Relatorios nao tem PK fisica - chave eh composta pelos filtros.
    *--------------------------------------------------------------------------
    PROCEDURE ObterChavePrimaria()
        LOCAL loc_cChave
        loc_cChave = "SIGRECRP|" + ;
                     STR(THIS.this_nOper, 1) + "|" + ;
                     DTOS(THIS.this_dDtInicial) + "|" + ;
                     DTOS(THIS.this_dDtFinal) + "|" + ;
                     ALLTRIM(THIS.this_cCdEmpresa) + "|" + ;
                     ALLTRIM(THIS.this_cGrupo) + "|" + ;
                     ALLTRIM(THIS.this_cConta) + "|" + ;
                     ALLTRIM(THIS.this_cSgrupo) + "|" + ;
                     ALLTRIM(THIS.this_cSconta) + "|" + ;
                     ALLTRIM(THIS.this_cCdMoeda)
        RETURN loc_cChave
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Carrega filtros do relatorio a partir de cursor
    * Permite restaurar configuracao de filtros previamente salva.
    * par_cAliasCursor: alias do cursor com colunas Oper, DtInicial, DtFinal,
    *   CdEmpresa, DsEmpresa, Grupo, DsGrupo, Conta, DConta, Sgrupo, Dsgrupo,
    *   Sconta, DsConta, CdMoeda, DsMoeda
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso, loc_oErr, loc_cAlias
        loc_lSucesso = .F.

        IF EMPTY(par_cAliasCursor) OR !USED(par_cAliasCursor)
            THIS.this_cMensagemErro = "Cursor de par" + CHR(226) + "metros n" + ;
                                      CHR(227) + "o dispon" + CHR(237) + "vel: " + ;
                                      TRANSFORM(par_cAliasCursor)
            RETURN .F.
        ENDIF

        loc_cAlias = par_cAliasCursor

        TRY
            SELECT (loc_cAlias)
            IF !EOF()
                IF TYPE(loc_cAlias + ".Oper") = "N"
                    THIS.this_nOper = EVALUATE(loc_cAlias + ".Oper")
                ENDIF
                IF TYPE(loc_cAlias + ".DtInicial") = "D"
                    THIS.this_dDtInicial = EVALUATE(loc_cAlias + ".DtInicial")
                ENDIF
                IF TYPE(loc_cAlias + ".DtFinal") = "D"
                    THIS.this_dDtFinal = EVALUATE(loc_cAlias + ".DtFinal")
                ENDIF
                IF TYPE(loc_cAlias + ".CdEmpresa") = "C"
                    THIS.this_cCdEmpresa = EVALUATE(loc_cAlias + ".CdEmpresa")
                ENDIF
                IF TYPE(loc_cAlias + ".DsEmpresa") = "C"
                    THIS.this_cDsEmpresa = EVALUATE(loc_cAlias + ".DsEmpresa")
                ENDIF
                IF TYPE(loc_cAlias + ".Grupo") = "C"
                    THIS.this_cGrupo = EVALUATE(loc_cAlias + ".Grupo")
                ENDIF
                IF TYPE(loc_cAlias + ".DsGrupo") = "C"
                    THIS.this_cDsGrupo = EVALUATE(loc_cAlias + ".DsGrupo")
                ENDIF
                IF TYPE(loc_cAlias + ".Conta") = "C"
                    THIS.this_cConta = EVALUATE(loc_cAlias + ".Conta")
                ENDIF
                IF TYPE(loc_cAlias + ".DConta") = "C"
                    THIS.this_cDConta = EVALUATE(loc_cAlias + ".DConta")
                ENDIF
                IF TYPE(loc_cAlias + ".Sgrupo") = "C"
                    THIS.this_cSgrupo = EVALUATE(loc_cAlias + ".Sgrupo")
                ENDIF
                IF TYPE(loc_cAlias + ".Dsgrupo") = "C"
                    THIS.this_cDsgrupo = EVALUATE(loc_cAlias + ".Dsgrupo")
                ENDIF
                IF TYPE(loc_cAlias + ".Sconta") = "C"
                    THIS.this_cSconta = EVALUATE(loc_cAlias + ".Sconta")
                ENDIF
                IF TYPE(loc_cAlias + ".DsConta") = "C"
                    THIS.this_cDsConta = EVALUATE(loc_cAlias + ".DsConta")
                ENDIF
                IF TYPE(loc_cAlias + ".CdMoeda") = "C"
                    THIS.this_cCdMoeda = EVALUATE(loc_cAlias + ".CdMoeda")
                ENDIF
                IF TYPE(loc_cAlias + ".DsMoeda") = "C"
                    THIS.this_cDsMoeda = EVALUATE(loc_cAlias + ".DsMoeda")
                ENDIF
                loc_lSucesso = .T.
            ELSE
                THIS.this_cMensagemErro = "Cursor de par" + CHR(226) + ;
                                          "metros vazio"
            ENDIF
        CATCH TO loc_oErr
            THIS.this_cMensagemErro = loc_oErr.Message
            MsgErro(loc_oErr.Message, "CarregarDoCursor")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir - Registra execucao do relatorio em LogAuditoria
    * Para relatorios, "Inserir" significa registrar nova execucao,
    * permitindo rastrear quem rodou qual relatorio e quando.
    *--------------------------------------------------------------------------
    FUNCTION Inserir()
        LOCAL loc_lSucesso, loc_oErr
        loc_lSucesso = .F.

        TRY
            loc_lSucesso = THIS.RegistrarAuditoria("REPORT_RUN")
            IF !loc_lSucesso
                THIS.this_cMensagemErro = "Falha ao registrar execu" + ;
                                          CHR(231) + CHR(227) + "o do relat" + ;
                                          CHR(243) + "rio em LogAuditoria"
            ENDIF
        CATCH TO loc_oErr
            THIS.this_cMensagemErro = loc_oErr.Message
            MsgErro(loc_oErr.Message, "Inserir")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * Atualizar - Registra reexecucao do relatorio em LogAuditoria
    * Para relatorios, "Atualizar" significa registrar uma reexecucao
    * (usuario alterou filtros e gerou o relatorio novamente).
    *--------------------------------------------------------------------------
    FUNCTION Atualizar()
        LOCAL loc_lSucesso, loc_oErr
        loc_lSucesso = .F.

        TRY
            loc_lSucesso = THIS.RegistrarAuditoria("REPORT_RERUN")
            IF !loc_lSucesso
                THIS.this_cMensagemErro = "Falha ao registrar reexecu" + ;
                                          CHR(231) + CHR(227) + "o do relat" + ;
                                          CHR(243) + "rio em LogAuditoria"
            ENDIF
        CATCH TO loc_oErr
            THIS.this_cMensagemErro = loc_oErr.Message
            MsgErro(loc_oErr.Message, "Atualizar")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * Destroy - Limpeza de todos os cursors abertos pelo BO
    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
        IF USED("Resultado")
            USE IN Resultado
        ENDIF
        IF USED("CsCabecalho")
            USE IN CsCabecalho
        ENDIF
        IF USED("cursor_4c_SigrecrpEmp")
            USE IN cursor_4c_SigrecrpEmp
        ENDIF
        IF USED("cursor_4c_SigrecrpGcr")
            USE IN cursor_4c_SigrecrpGcr
        ENDIF
        IF USED("cursor_4c_SigrecrpMvCcr")
            USE IN cursor_4c_SigrecrpMvCcr
        ENDIF
        IF USED("cursor_4c_SigrecrpMvCab")
            USE IN cursor_4c_SigrecrpMvCab
        ENDIF
        IF USED("cursor_4c_SigrecrpMvPar")
            USE IN cursor_4c_SigrecrpMvPar
        ENDIF
        IF USED("cursor_4c_SigrecrpOpFp")
            USE IN cursor_4c_SigrecrpOpFp
        ENDIF
        IF USED("cursor_4c_SigrecrpChe")
            USE IN cursor_4c_SigrecrpChe
        ENDIF
        IF USED("cursor_4c_SigrecrpOpt")
            USE IN cursor_4c_SigrecrpOpt
        ENDIF
        IF USED("cursor_4c_SigrecrpTotaliza")
            USE IN cursor_4c_SigrecrpTotaliza
        ENDIF
        DODEFAULT()
    ENDPROC

ENDDEFINE

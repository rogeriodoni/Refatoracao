*==============================================================================
* sigregliBO.prg - Business Object para Impressao de Relacoes e Etiquetas de OP/OS
* Data: 2026-06-05
* Tabela: (nenhuma - form operacional, sem tabela principal)
* Legado: SIGREGLI.SCX (form operacional)
*==============================================================================

DEFINE CLASS sigregliBO AS BusinessBase

    *--------------------------------------------------------------------------
    *-- Parametros principais da OP/OS
    *--------------------------------------------------------------------------
    this_nOrdem      = 0       && Get_Ordem: numero da OP/OS principal
    this_nOrdem2     = 0       && Get_Ordem2: numero da segunda OP/OS (opcional)
    this_nSeqIni     = 0       && Get_SeqIni: sequencia inicial
    this_nSeqFim     = 9999    && Get_SeqFim: sequencia final (0 = todos)
    this_nTipo       = 0       && Get_Tipo: 0=nenhum,1=Relacao,2=Etiquetas,3=Tiras,4=Tiras c/Imagem,5=Boleto Relacao,6=Etiq c/Imagem
    this_nTpOrdem    = 1       && TpOrdem: 1=Ordem de Producao, 2=Ordem de Servico

    *--------------------------------------------------------------------------
    *-- Filtros extras
    *--------------------------------------------------------------------------
    this_cClass      = ""      && Get_Class: codigo de classificacao
    this_cLin        = ""      && GetLin: codigo de linha
    this_cDLin       = ""      && GetDLin: descricao de linha
    this_cCor        = ""      && getCor: codigo de cor
    this_cFase       = ""      && getFase: codigo de fase/grupo de balance
    this_cDfase      = ""      && getDfase: descricao da fase/grupo de balance
    this_cObsOper    = ""      && ObsOper: observacao do operador

    *--------------------------------------------------------------------------
    *-- Parametros do painel Etiquetas
    *--------------------------------------------------------------------------
    this_nDivididas  = 2       && Get_Divididas: 1=Somente Divididas, 2=Nao
    this_nImprimir   = 1       && Get_Imprimir: 1=Geral, 2=Nao Impressas
    this_nLinha      = 1       && Get_Linha: posicao linha etiqueta
    this_nColuna     = 1       && Get_Coluna: posicao coluna etiqueta
    this_nCompo      = 1       && Get_Compo: 1=Imprime Composicao, 2=Nao
    this_nCera       = 2       && Get_Cera: 1=Cravacao em Cera, 2=Nao
    this_nEtqPedido  = 2       && Etiquetas.Get_Pedido: 1=Imprimir Pedidos, 2=Nao
    this_nBoleto     = 2       && Get_Boleto: 1=Boleto, 2=Laser, 3=Allegro, 4=Colunas
    this_nProcesso   = 2       && get_processo: 1=Sim, 2=Nao
    this_nComplemto  = 2       && Get_Complemto: 1=Sim, 2=Nao
    this_lNome       = 0       && chknome: 1=marcado, 0=desmarcado
    this_l2Linhas    = 0       && chk2Linhas: 1=marcado, 0=desmarcado
    this_nOptDescs   = 1       && Etiquetas.optDescs: 1=Normal, 2=Descritivo
    this_lDatager    = 1       && chkDatager: 1=marcado, 0=desmarcado

    *--------------------------------------------------------------------------
    *-- Parametros do painel Relacao
    *--------------------------------------------------------------------------
    this_nRelPedido  = 1       && Relacao.Get_Pedido: 1=Sim, 2=Com Barras
    this_nResumo     = 2       && Get_Resumo: 1=Resumido, 2=Nao
    this_nBarra      = 2       && Get_Barra: 1=Codigo de Barras, 2=Nao
    this_nOptOrdem   = 3       && Opt_ordem: 1=Destino,2=Cor,3=Sequencia,4=Referencia
    this_nRelOptDescs = 1      && Relacao.optDescs: 1=Normal, 2=Descritivo
    this_nOptImagem  = 2       && optImagem: 1=Cod.Barras e Imagem, 2=Nao

    *--------------------------------------------------------------------------
    *-- Estado operacional
    *--------------------------------------------------------------------------
    this_lRastreab      = .F.  && se ha operacoes com controle de lote
    this_cPcPrinterBol  = ""   && impressora configurada para boleto

    *--------------------------------------------------------------------------
    PROCEDURE Init()
        DODEFAULT()
        THIS.this_cTabela     = ""
        THIS.this_cCampoChave = ""
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    PROCEDURE ObterChavePrimaria()
        RETURN ""
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarParametrosIniciais - Equivalente ao Init do form legado
    *--------------------------------------------------------------------------
    PROCEDURE CarregarParametrosIniciais(par_nNop, par_nTpOrdem, par_oParentForm)
        LOCAL loc_cQuery, loc_nResult, loc_lSucesso

        loc_lSucesso = .F.

        THIS.CursorQuery('SigCdPam', 'crSigCdPam', .F., .F.)
        THIS.CursorQuery('SigCdPac', 'crSigCdPac', .F., .F.)

        IF VARTYPE(par_nNop) = "N" AND par_nNop <> 0
            THIS.this_nOrdem = par_nNop
        ENDIF

        IF VARTYPE(par_nTpOrdem) = "N"
            THIS.this_nTpOrdem = par_nTpOrdem
        ENDIF

        IF VARTYPE(par_oParentForm) = "O"
            IF UPPER(par_oParentForm.Name) = 'SIGPRGLP' OR UPPER(par_oParentForm.Name) = 'SIGPRGLX'
                THIS.this_nTpOrdem = 1
            ELSE
                THIS.this_nTpOrdem = 2
            ENDIF
        ENDIF

        THIS.this_lRastreab = .F.

        loc_cQuery = "SELECT Dopes FROM SigCdOpe WHERE Ctrllotes IN (1, 2)"
        loc_nResult = SQLEXEC(gnConnHandle, loc_cQuery, "TmpOpe")
        IF loc_nResult < 1
            MsgErro("Favor Reinicializar o Processo!!!", "Falha na Conex" + CHR(227) + "o (TmpOpe)")
            RETURN .F.
        ENDIF

        SELECT TmpOpe
        IF RECCOUNT() > 0
            THIS.this_lRastreab = .T.
        ENDIF
        IF USED("TmpOpe")
            USE IN TmpOpe
        ENDIF

        loc_cQuery = "SELECT Codigos, Descrs, OsAlfuns FROM SigCdGcr WHERE GerBals = 1"
        loc_nResult = SQLEXEC(gnConnHandle, loc_cQuery, "crGruposBal")
        IF loc_nResult < 1
            MsgErro("Favor Reinicializar o Processo!!!", "Falha na Conex" + CHR(227) + "o (crGruposBal)")
            RETURN .F.
        ENDIF

        IF USED("crGruposBal")
            SELECT crGruposBal
            INDEX ON Codigos TAG Codigos
            INDEX ON Descrs TAG Descrs
        ENDIF

        THIS.CarregarPrinterBoleto()

        THIS.this_l2Linhas = 0

        loc_lSucesso = .T.
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarPrinterBoleto - Detecta impressora configurada para boleto
    *--------------------------------------------------------------------------
    PROCEDURE CarregarPrinterBoleto()
        LOCAL loc_nResult, loc_laPrinters, loc_nPrinters, loc_nPos

        loc_nResult = SQLEXEC(gnConnHandle, "SELECT impres FROM SigCdmp WHERE nTpImpres <> 2", "crTmpBolI")

        DECLARE loc_laPrinters[1]
        loc_nPrinters = APRINTERS(loc_laPrinters)

        THIS.this_cPcPrinterBol = ""

        IF USED("crTmpBolI") AND loc_nPrinters > 0
            SELECT crTmpBolI
            FOR loc_nPos = 1 TO loc_nPrinters
                LOCATE FOR UPPER(ALLTRIM(Impres)) = UPPER(ALLTRIM(loc_laPrinters[loc_nPos, 1]))
                IF !EOF()
                    THIS.this_cPcPrinterBol = loc_laPrinters[loc_nPos, 1]
                    EXIT
                ENDIF
            ENDFOR
        ENDIF

        IF USED("crTmpBolI")
            USE IN crTmpBolI
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Nao aplicavel para form operacional sem tabela principal
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        RETURN .F.
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarDados - Validacao dos parametros antes da impressao
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ValidarDados()
        IF THIS.this_nTipo = 0
            MsgAviso("Selecione um Tipo de Impress" + CHR(227) + "o antes de continuar.", "Valida" + CHR(231) + CHR(227) + "o")
            RETURN .F.
        ENDIF
        IF THIS.this_nOrdem = 0 AND THIS.this_nDivididas <> 1
            MsgAviso("Informe o n" + CHR(250) + "mero da Ordem.", "Valida" + CHR(231) + CHR(227) + "o")
            RETURN .F.
        ENDIF
        IF THIS.this_nSeqFim > 0 AND THIS.this_nSeqFim < THIS.this_nSeqIni
            MsgAviso("A Sequ" + CHR(234) + "ncia Final n" + CHR(227) + "o pode ser menor que a Inicial.", "Valida" + CHR(231) + CHR(227) + "o")
            RETURN .F.
        ENDIF
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir - Nao aplicavel para form operacional
    *--------------------------------------------------------------------------
    PROCEDURE Inserir()
        RETURN .F.
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - Nao aplicavel para form operacional
    *--------------------------------------------------------------------------
    PROCEDURE Atualizar()
        RETURN .F.
    ENDPROC

    *--------------------------------------------------------------------------
    * RegistrarAuditoria - Nao aplicavel para form operacional
    *--------------------------------------------------------------------------
    PROCEDURE RegistrarAuditoria(par_cOperacao)
        RETURN
    ENDPROC

    *--------------------------------------------------------------------------
    * CursorQuery - Helper: carrega tabela SQL Server em cursor local
    * Equivalente ao poDataMgr.CursorQuery() do legado
    * par_cTabela     : nome da tabela SQL Server
    * par_cCursor     : alias do cursor destino
    * par_xFiltroNome : campo do filtro (ou .F. para carregar todos)
    * par_xFiltroValor: valor do filtro
    * par_cOrdem      : campo de ordenacao (opcional, 5o param)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE CursorQuery(par_cTabela, par_cCursor, par_xFiltroNome, par_xFiltroValor, par_cOrdem)
        LOCAL loc_cSQL, loc_nResult, loc_cFiltro, loc_cOrder

        loc_cFiltro = ""
        loc_cOrder  = ""

        IF VARTYPE(par_xFiltroNome) <> "L"
            IF VARTYPE(par_xFiltroValor) = "N"
                loc_cFiltro = " WHERE " + par_xFiltroNome + " = " + ALLTRIM(TRANSFORM(par_xFiltroValor))
            ELSE
                IF VARTYPE(par_xFiltroValor) = "D"
                loc_cFiltro = " WHERE " + par_xFiltroNome + " = " + FormatarDataSQL(par_xFiltroValor)
            ELSE
                loc_cFiltro = " WHERE " + par_xFiltroNome + " = '" + ALLTRIM(par_xFiltroValor) + "'"
                ENDIF
            ENDIF
        ENDIF

        IF PCOUNT() >= 5 AND VARTYPE(par_cOrdem) = "C" AND !EMPTY(par_cOrdem)
            loc_cOrder = " ORDER BY " + par_cOrdem
        ENDIF

        loc_cSQL = "SELECT * FROM " + par_cTabela + loc_cFiltro + loc_cOrder

        IF USED(par_cCursor)
            USE IN (par_cCursor)
        ENDIF

        loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, par_cCursor)

        IF loc_nResult > 0 AND USED(par_cCursor)
            SELECT (par_cCursor)
            IF RECCOUNT() > 0
                GO TOP
            ENDIF
        ENDIF

        RETURN (loc_nResult > 0)
    ENDPROC

    *--------------------------------------------------------------------------
    * ProcRelacao - Relacao de OP/OS (Tipo=1 Ordem2=0, ou Tipo=5)
    *--------------------------------------------------------------------------
    PROCEDURE ProcRelacao(par_cSaida)
        LOCAL pSqi, pSqf
        LOCAL loc_Nop, loc_Pedido, loc_Resumo, loc_Barra, loc_cPedido, loc_Seq
        LOCAL loc_Seqi, loc_Seqf, loc_llCera, loc_lcclass, loc_lcOperacao
        LOCAL loc_lcQuery, loc_nResult, loc_DtGera
        LOCAL loc_lcEdp, loc_lcGru, loc_lcCompo, loc_lcDpro, loc_lcDp2
        LOCAL loc_lcSub, loc_llNumOpe, loc_llDp2, loc_lcCodlin, loc_lcCodcor
        LOCAL loc_lcFase, loc_llImagem, loc_lnQtdTb, loc_lcCodigo, loc_lcDirectory, loc_lcFoto
        LOCAL loc_ImpCodBar

        loc_Nop      = THIS.this_nOrdem
        loc_Pedido   = (THIS.this_nRelPedido = 1)
        loc_Resumo   = (THIS.this_nResumo = 1)
        loc_Barra    = (THIS.this_nRelPedido = 2 AND THIS.this_nBarra = 1)
        loc_Seqi     = THIS.this_nSeqIni
        loc_Seqf     = IIF(THIS.this_nSeqFim = 0, 9999, THIS.this_nSeqFim)
        loc_llCera   = (THIS.this_nCera = 1)
        loc_lcclass  = ALLTRIM(THIS.this_cClass)
        loc_llDp2    = (THIS.this_nRelOptDescs = 2)
        loc_lcCodlin = ALLTRIM(THIS.this_cLin)
        loc_lcCodcor = ALLTRIM(THIS.this_cCor)
        loc_lcFase   = ALLTRIM(THIS.this_cFase)
        loc_llImagem = (THIS.this_nOptImagem = 1)

        IF THIS.this_nTpOrdem = 1
            loc_lcOperacao = crSigCdPam.DoppPads
        ELSE
            loc_lcOperacao = crSigCdPam.DoppServs
        ENDIF

        loc_llNumOpe = .F.
        THIS.CursorQuery('SigCdOpd', 'crTmpCdOpd', 'Dopps', ALLTRIM(loc_lcOperacao), 'Numeras')
        IF USED("crTmpCdOpd")
            SELECT crTmpCdOpd
            IF RECCOUNT() > 0
                loc_llNumOpe = (crTmpCdOpd.Numeras = 4)
            ENDIF
        ENDIF

        CREATE CURSOR TmpImp (Ordem n(6), Seqs n(4), CPros c(14), DPros c(40), DPro2s c(45), Qtde n(10,3), Obs m, ImpCodBar c(20), ;
                              Pedido c(30), ImpPeds L, CodCors c(4), CodTams c(4), Linhas c(10), Pesos n(9,2), ;
                              Qtdep n(10,3), Usuars c(10), Ordimg c(17))
        INDEX ON Linhas + STR(Seqs,4) TAG Impressao

        CREATE CURSOR TmpRes (Tps c(1), Cgrus c(3), Compos c(30), Mats c(14), Descs c(40), Qtds n(12,3), ;
                              Cunis c(3), Ordem n(6), Pesos n(10,3), QtPcs n(10,3))
        INDEX ON Tps + Cgrus + Compos + Mats TAG Mats

        pSqi = INT(VAL(STR(loc_Nop, 6) + PADL(ALLTRIM(STR(loc_Seqi)), 4, '0')))
        pSqf = INT(VAL(STR(loc_Nop, 6) + PADL(ALLTRIM(STR(loc_Seqf)), 4, '0')))

        loc_lcQuery = "SELECT * FROM SigOpPic " + ;
                      "WHERE EmpDNps = '" + go_4c_Sistema.cCodEmpresa + ALLTRIM(loc_lcOperacao) + STR(loc_Nop, 10) + "'" + ;
                      " AND " + IIF(loc_llNumOpe, "0=0", "Nops BETWEEN ?pSqi AND ?pSqf")

        loc_nResult = SQLEXEC(gnConnHandle, loc_lcQuery, "TempOpi")
        IF loc_nResult < 1
            MsgErro("Favor Reinicializar o Processo!!!", "Falha na Conex" + CHR(227) + "o (TempOpi)")
            IF USED("TmpImp")
                USE IN TmpImp
            ENDIF
            RETURN .F.
        ENDIF

        SELECT TempOpi
        GO TOP
        loc_DtGera = NVL(TTOD(DtGeras), CTOD(''))

        SCAN
            loc_Seq = VAL(RIGHT(STR(TempOpi.Nops, 10), 4))

            loc_lcEdp = ALLTRIM(Emps) + ALLTRIM(Dopps) + STR(Nops, 10)
            THIS.CursorQuery('SigPdMvf', 'TempMfas', 'EmpDNps', loc_lcEdp)
            THIS.CursorQuery('SigCdPro', 'crSigCdPro', 'CPros', ALLTRIM(TempMfas.CodPds))
            THIS.CursorQuery('SigCdGrp', 'CrSigCdGrp', 'CGrus', ALLTRIM(CrSigCdPro.Cgrus), 'GeraTubs')
            THIS.CursorQuery('SigCdOpe', 'crSigCdOpe', 'Dopes', ALLTRIM(TempOpi.Dopes))

            IF loc_llCera AND CrSigCdPro.CravCers <> 1
                LOOP
            ENDIF

            IF !EMPTY(loc_lcclass) AND ALLTRIM(loc_lcclass) <> ALLTRIM(crSigCdPro.Cclass)
                LOOP
            ENDIF

            IF !EMPTY(loc_lcCodlin) AND ALLTRIM(loc_lcCodlin) <> ALLTRIM(crSigCdPro.Linhas)
                LOOP
            ENDIF

            IF !EMPTY(loc_lcCodcor) AND ALLTRIM(loc_lcCodcor) <> ALLTRIM(TempOpi.CodCors)
                LOOP
            ENDIF

            IF !EMPTY(loc_lcFase)
                loc_nResult = SQLEXEC(gnConnHandle, ;
                    "SELECT Grupos FROM SigCdLnf WHERE Linhas = '" + ALLTRIM(crSigCdPro.Linhas) + "' AND Grupos = '" + ALLTRIM(loc_lcFase) + "'", ;
                    "crSigCdLnf")
                IF USED("crSigCdLnf")
                    SELECT crSigCdLnf
                    IF EOF()
                        LOOP
                    ENDIF
                ENDIF
            ENDIF

            loc_lcGru      = crSigCdPro.Cgrus
            loc_lcCompo    = crSigCdPro.Compos
            loc_cPedido    = IIF(!EMPTY(TempOpi.EmpDs), ALLTRIM(TempOpi.EmpDs), ALLTRIM(TempOpi.Emps)) + ;
                             ALLTRIM(crSigCdOpe.Abrevs) + ' ' + ALLTRIM(fGerMascara(TempOpi.Numes))
            loc_ImpCodBar  = fAltBar2de5(TRANSFORM(TempOpi.Nops, '@L 9999999999'))

            loc_lcDpro = IIF(THIS.this_nTpOrdem = 2 AND !EMPTY(TempOpi.Dpros), TempOpi.Dpros, CrSigCdPro.Dpros)
            loc_lcDp2  = IIF(loc_llDp2, ALLTRIM(crSigCdPro.DPro2s), "")

            IF CrSigCdGrp.GeraTubs <> 2
                loc_lnQtdTb = crSigCdPro.QtdCpnts
            ELSE
                loc_lcQuery = "SELECT SUM(qtds) AS total FROM SigPrMtz WHERE Cpros = '" + ALLTRIM(TempMfas.CodPds) + "'"
                loc_nResult = SQLEXEC(gnConnHandle, loc_lcQuery, "crSigPrMtz")
                IF loc_nResult < 1
                    MsgErro("Favor Reinicializar o Processo!!!", "Falha na Conex" + CHR(227) + "o (crSigPrMtz)")
                    IF USED("TmpImp")
                        USE IN TmpImp
                    ENDIF
                    RETURN .F.
                ENDIF
                SELECT crSigPrMtz
                loc_lnQtdTb = NVL(crSigPrMtz.total, 0)
            ENDIF

            INSERT INTO TmpImp (Ordem, Seqs, Cpros, Dpros, Dpro2s, Qtde, Obs, Pedido, ImpPeds, ;
                                CodCors, CodTams, Linhas, Pesos, ImpCodBar, Qtdep, Usuars) ;
                         VALUES (loc_Nop, loc_Seq, TempMFas.CodPds, loc_lcDpro, loc_lcDp2, ;
                                (TempOpi.Qtds * IIF(loc_Barra, loc_lnQtdTb, 1)), ;
                                NVL(TempOpi.Obss, ''), loc_cPedido, loc_Pedido, TempOpi.CodCors, ;
                                TempOpi.CodTams, crSigCdPro.Linhas, TempOpi.Pesos, ;
                                IIF(loc_Barra OR loc_llImagem, loc_ImpCodBar, ''), TempOpi.Qtds, TempMFas.Usuars)

            IF EMPTY(crSigCdPro.FigJpgs) OR ISNULL(crSigCdPro.FigJpgs) OR (!loc_llImagem)
                REPLACE OrdImg WITH 'FBRANCOS' IN TmpImp
            ELSE
                loc_lcCodigo    = STRTRAN(STRTRAN(STRTRAN(ALLTRIM(TempOpi.Cpros), '/', ''), '*', ''), ' ', '')
                loc_lcDirectory = SYS(2023) + '\F' + ALLTRIM(loc_lcCodigo) + '.Jpg'
                REPLACE OrdImg WITH 'F' + ALLTRIM(loc_lcCodigo) IN TmpImp
                loc_lcFoto = STRCONV(STRTRAN(STRTRAN(STRTRAN(crSigCdPro.FigJpgs, ;
                    'data:image/png;base64,', ''), 'data:image/jpeg;base64,', ''), 'data:image/jpg;base64,', ''), 14)
                =STRTOFILE(loc_lcFoto, loc_lcDirectory)
            ENDIF

            THIS.CursorQuery('SigPrCpo', 'crSigPrCpo', 'CPros', ALLTRIM(TempMFas.CodPds))
            SELECT crSigPrCpo
            SCAN
                THIS.CursorQuery('SigCdPro', 'crSigCdPro', 'CPros', ALLTRIM(crSigPrCpo.Mats))
                IF crSigCdPro.Varias = 1
                    LOOP
                ENDIF

                SELECT TmpRes
                SET ORDER TO Mats
                SEEK '1' + ALLTRIM(loc_lcGru) + ALLTRIM(loc_lcCompo) + ALLTRIM(crSigPrCpo.Mats)
                IF EOF()
                    APPEND BLANK
                    REPLACE Mats   WITH crSigPrCpo.Mats, ;
                            Descs  WITH crSigCdPro.Dpros, ;
                            Cunis  WITH crSigCdPro.Cunis, ;
                            Ordem  WITH loc_Nop, ;
                            Cgrus  WITH loc_lcGru, ;
                            Compos WITH loc_lcCompo, ;
                            Tps    WITH '1'
                ENDIF
                REPLACE Qtds WITH Qtds + (crSigPrCpo.Qtds * TempOpi.Qtds)
            ENDSCAN

            SELECT TmpRes
            IF !SEEK('1' + ALLTRIM(loc_lcGru) + ALLTRIM(loc_lcCompo))
                APPEND BLANK
                REPLACE Cgrus  WITH loc_lcGru, ;
                        Compos WITH loc_lcCompo, ;
                        Ordem  WITH loc_Nop, ;
                        Tps    WITH '1'
            ENDIF
            REPLACE QtPcs WITH QtPcs + TempOpi.Qtds, ;
                    Pesos WITH Pesos + TempOpi.Pesos
        ENDSCAN

        SELECT TmpImp
        GO TOP
        IF EOF()
            MsgAviso("Nenhuma Sequ" + CHR(234) + "ncia Foi Selecionada Para Impress" + CHR(227) + "o!!!", "")
        ELSE
            DO CASE
                CASE THIS.this_nOptOrdem = 1
                    loc_lcSub = "Ordenado por Destino"
                CASE THIS.this_nOptOrdem = 2
                    loc_lcSub = "Ordenado por Cor"
                CASE THIS.this_nOptOrdem = 3
                    loc_lcSub = "Ordenado por Sequ" + CHR(234) + "ncia"
                OTHERWISE
                    loc_lcSub = "Ordenado por Refer" + CHR(234) + "ncia"
            ENDCASE
            loc_lcSub = loc_lcSub + IIF(EMPTY(loc_lcFase), "", " - Fase : " + ALLTRIM(loc_lcFase))

            CREATE CURSOR dbCabec (Operacao c(20), Ordem c(15), DtGeras d, Subtitulo c(100))
            INSERT INTO dbCabec (Operacao, Ordem, DtGeras, Subtitulo) ;
                VALUES (IIF(THIS.this_nTpOrdem = 1, ALLTRIM(crSigCdPam.DoppPads), ALLTRIM(crSigCdPam.DoppServs)), ;
                        TRANSFORM(loc_Nop, "@L 999999"), loc_DtGera, loc_lcSub)

            SELECT Mats, Descs, Cunis, SUM(Qtds) AS Qtds, SUM(Pesos) AS Pesos, SUM(QtPcs) AS QtPcs ;
              FROM TmpRes ;
             GROUP BY Mats, Descs, Cunis ;
             INTO CURSOR csRes

            SELECT csRes
            SCAN
                SELECT TmpRes
                APPEND BLANK
                REPLACE Tps    WITH '2', ;
                        Compos WITH 'Geral', ;
                        Mats   WITH csRes.Mats, ;
                        Descs  WITH csRes.Descs, ;
                        Cunis  WITH csRes.Cunis, ;
                        Qtds   WITH csRes.Qtds, ;
                        QtPcs  WITH csRes.QtPcs, ;
                        Pesos  WITH csRes.Pesos, ;
                        Ordem  WITH loc_Nop
            ENDSCAN

            SELECT TmpImp
            IF !loc_Pedido
                SELECT Ordem, Seqs, CPros, CodCors, CodTams, DPros, Dpro2s, '' AS Obs, ImpCodBar, ;
                       Pedido, ImpPeds, Linhas, SUM(Pesos) AS Pesos, SUM(Qtde) AS Qtde, SUM(Qtdep) AS Qtdep ;
                  FROM TmpImp ;
                 GROUP BY 1,2,3,4,5,6,7,8,9,10,11,12 ;
                 ORDER BY Linhas ;
                  INTO CURSOR TmpImp2
            ENDIF

            DO CASE
                CASE THIS.this_nOptOrdem = 1
                    INDEX ON Pedido + STR(Seqs,4) TAG Pedido
                CASE THIS.this_nOptOrdem = 2
                    INDEX ON Codcors + STR(Seqs,4) TAG Codcor
                CASE THIS.this_nOptOrdem = 4
                    INDEX ON CPros + STR(Seqs,4) TAG CPros
            ENDCASE

            IF THIS.this_nTipo = 5
                SELECT Ordem, Pedido, Usuars FROM TmpImp INTO CURSOR crImpBoleto
                DO FORM SigOpIbo WITH .NULL., 12, , go_4c_Sistema.cCodEmpresa, loc_lcOperacao, loc_Nop, 0, 1, 1
            ELSE
                IF par_cSaida = 'V'
                    IF loc_Barra
                        REPORT FORM SigReGlb PREVIEW NOCONSOLE
                    ELSE
                        REPORT FORM SigReGlr PREVIEW NOCONSOLE
                    ENDIF
                ELSE
                    IF loc_Barra
                        REPORT FORM SigReGlb TO PRINT PROMPT NOCONSOLE
                    ELSE
                        REPORT FORM SigReGlr TO PRINT PROMPT NOCONSOLE
                    ENDIF
                ENDIF

                IF loc_Resumo
                    SELECT TmpRes
                    GO TOP
                    IF par_cSaida = 'V'
                        REPORT FORM SigPrGlp PREVIEW NOCONSOLE
                    ELSE
                        REPORT FORM SigPrGlp TO PRINT PROMPT NOCONSOLE
                    ENDIF
                ENDIF
            ENDIF
        ENDIF

        IF USED("TmpImp")
            USE IN TmpImp
        ENDIF
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * ProcRelacao2 - Relacao combinando duas OPs (Tipo=1 com Ordem2>0)
    *--------------------------------------------------------------------------
    PROCEDURE ProcRelacao2(par_cSaida)
        LOCAL pSqi, pSqf, pSqi2, pSqf2
        LOCAL loc_Nop, loc_Nop2, loc_Pedido, loc_Resumo, loc_Barra, loc_cPedido
        LOCAL loc_Seq, loc_NopX, loc_Seqi, loc_Seqf, loc_llCera
        LOCAL loc_lcclass, loc_lcOperacao, loc_lcQuery, loc_nResult, loc_DtGera
        LOCAL loc_lcEdp, loc_lcGru, loc_lcCompo, loc_lcDpro, loc_lnQtdTb
        LOCAL loc_llNumOpe, loc_ImpCodBar

        loc_Nop     = THIS.this_nOrdem
        loc_Nop2    = THIS.this_nOrdem2
        loc_Pedido  = (THIS.this_nRelPedido = 1)
        loc_Resumo  = (THIS.this_nResumo = 1)
        loc_Barra   = (THIS.this_nRelPedido = 2 AND THIS.this_nBarra = 1)
        loc_Seqi    = THIS.this_nSeqIni
        loc_Seqf    = IIF(THIS.this_nSeqFim = 0, 9999, THIS.this_nSeqFim)
        loc_llCera  = (THIS.this_nCera = 1)
        loc_lcclass = ALLTRIM(THIS.this_cClass)

        IF THIS.this_nTpOrdem = 1
            loc_lcOperacao = crSigCdPam.DoppPads
        ELSE
            loc_lcOperacao = crSigCdPam.DoppServs
        ENDIF

        loc_llNumOpe = .F.
        THIS.CursorQuery('SigCdOpd', 'crTmpCdOpd', 'Dopps', ALLTRIM(loc_lcOperacao), 'Numeras')
        IF USED("crTmpCdOpd")
            SELECT crTmpCdOpd
            IF RECCOUNT() > 0
                loc_llNumOpe = (crTmpCdOpd.Numeras = 4)
            ENDIF
        ENDIF

        CREATE CURSOR TmpImp (Nops n(10), Seqs n(10), CPros c(14), DPros c(40), Qtde n(10,3), Obs m, ImpCodBar c(20), ;
                              Pedido c(30), ImpPeds L, CodCors c(4), CodTams c(4), Linhas c(10), Pesos n(9,2), ;
                              Qtdep n(10,3), Usuars c(10), dtGeras d)
        INDEX ON Linhas + CPros TAG Impressao

        CREATE CURSOR TmpRes (Tps c(1), Cgrus c(3), Compos c(30), Mats c(14), Descs c(40), Qtds n(12,3), ;
                              Cunis c(3), Ordem n(6), Pesos n(10,3), QtPcs n(10,3))
        INDEX ON Tps + Cgrus + Compos + Mats TAG Mats

        pSqi  = INT(VAL(STR(loc_Nop,  6) + PADL(ALLTRIM(STR(loc_Seqi)), 4, '0')))
        pSqf  = INT(VAL(STR(loc_Nop,  6) + PADL(ALLTRIM(STR(loc_Seqf)), 4, '0')))
        pSqi2 = INT(VAL(STR(loc_Nop2, 6) + PADL(ALLTRIM(STR(loc_Seqi)), 4, '0')))
        pSqf2 = INT(VAL(STR(loc_Nop2, 6) + PADL(ALLTRIM(STR(loc_Seqf)), 4, '0')))

        loc_lcQuery = "SELECT * FROM SigOpPic " + ;
                      "WHERE " + IIF(loc_llNumOpe, "0=0 AND ", "Nops BETWEEN ?pSqi AND ?pSqf AND ") + ;
                      "NOT Qtds = 0 AND Dopps = '" + ALLTRIM(loc_lcOperacao) + "' " + ;
                      "UNION ALL " + ;
                      "SELECT * FROM SigOpPic " + ;
                      "WHERE " + IIF(loc_llNumOpe, "0=0 AND ", "Nops BETWEEN ?pSqi2 AND ?pSqf2 AND ") + ;
                      "NOT Qtds = 0 AND Dopps = '" + ALLTRIM(loc_lcOperacao) + "'"

        loc_nResult = SQLEXEC(gnConnHandle, loc_lcQuery, "TempOpi")
        IF loc_nResult < 1
            MsgErro("Favor Reinicializar o Processo!!!", "Falha na Conex" + CHR(227) + "o (TempOpi)")
            IF USED("TmpImp")
                USE IN TmpImp
            ENDIF
            RETURN .F.
        ENDIF

        SELECT TempOpi
        GO TOP
        loc_DtGera = NVL(TTOD(DtGeras), CTOD(''))

        SCAN
            loc_Seq  = VAL(RIGHT(STR(TempOpi.Nops, 10), 4))
            loc_NopX = VAL(LEFT(STR(TempOpi.Nops, 10), 6))

            loc_lcEdp = ALLTRIM(Emps) + ALLTRIM(Dopps) + STR(Nops, 10)
            THIS.CursorQuery('SigPdMvf', 'TempMfas', 'EmpDNps', loc_lcEdp)
            THIS.CursorQuery('SigCdPro', 'crSigCdPro', 'CPros', ALLTRIM(TempMfas.CodPds))
            THIS.CursorQuery('SigCdGrp', 'CrSigCdGrp', 'CGrus', ALLTRIM(CrSigCdPro.Cgrus), 'GeraTubs')
            THIS.CursorQuery('SigCdOpe', 'crSigCdOpe', 'Dopes', ALLTRIM(TempOpi.Dopes))

            IF loc_llCera AND CrSigCdPro.CravCers <> 1
                LOOP
            ENDIF

            IF !EMPTY(loc_lcclass) AND ALLTRIM(loc_lcclass) <> ALLTRIM(crSigCdPro.Cclass)
                LOOP
            ENDIF

            loc_lcGru   = crSigCdPro.Cgrus
            loc_lcCompo = crSigCdPro.Compos
            loc_cPedido = IIF(!EMPTY(TempOpi.EmpDs), ALLTRIM(TempOpi.EmpDs), ALLTRIM(TempOpi.Emps)) + ;
                          ALLTRIM(crSigCdOpe.Abrevs) + ' ' + ALLTRIM(fGerMascara(TempOpi.Numes))
            loc_ImpCodBar = fAltBar2de5(TRANSFORM(TempOpi.Nops, '@L 9999999999'))

            loc_lcDpro = IIF(THIS.this_nTpOrdem = 2 AND !EMPTY(TempOpi.Dpros), TempOpi.Dpros, CrSigCdPro.Dpros)

            IF CrSigCdGrp.GeraTubs <> 2
                loc_lnQtdTb = crSigCdPro.QtdCpnts
            ELSE
                loc_lcQuery = "SELECT SUM(qtds) AS total FROM SigPrMtz WHERE Cpros = '" + ALLTRIM(TempMfas.CodPds) + "'"
                loc_nResult = SQLEXEC(gnConnHandle, loc_lcQuery, "crSigPrMtz")
                IF loc_nResult < 1
                    MsgErro("Favor Reinicializar o Processo!!!", "Falha na Conex" + CHR(227) + "o (crSigPrMtz)")
                    IF USED("TmpImp")
                        USE IN TmpImp
                    ENDIF
                    RETURN .F.
                ENDIF
                SELECT crSigPrMtz
                loc_lnQtdTb = NVL(crSigPrMtz.total, 0)
            ENDIF

            INSERT INTO TmpImp (Nops, Seqs, Cpros, Dpros, Qtde, Obs, Pedido, ImpPeds, ;
                                CodCors, CodTams, Linhas, Pesos, ImpCodBar, Qtdep, Usuars) ;
                         VALUES (TempOpi.Nops, TempOpi.Nops, TempMFas.CodPds, loc_lcDpro, ;
                                (TempOpi.Qtds * IIF(loc_Barra, loc_lnQtdTb, 1)), ;
                                NVL(TempOpi.Obss, ''), loc_cPedido, loc_Pedido, TempOpi.CodCors, ;
                                TempOpi.CodTams, crSigCdPro.Linhas, TempOpi.Pesos, ;
                                loc_ImpCodBar, TempOpi.Qtds, TempMFas.Usuars)

            THIS.CursorQuery('SigPrCpo', 'crSigPrCpo', 'CPros', ALLTRIM(TempMFas.CodPds))
            SELECT crSigPrCpo
            SCAN
                THIS.CursorQuery('SigCdPro', 'crSigCdPro', 'CPros', ALLTRIM(crSigPrCpo.Mats))
                IF crSigCdPro.Varias = 1
                    LOOP
                ENDIF

                SELECT TmpRes
                SET ORDER TO Mats
                SEEK '1' + ALLTRIM(loc_lcGru) + ALLTRIM(loc_lcCompo) + ALLTRIM(crSigPrCpo.Mats)
                IF EOF()
                    APPEND BLANK
                    REPLACE Mats   WITH crSigPrCpo.Mats, ;
                            Descs  WITH crSigCdPro.Dpros, ;
                            Cunis  WITH crSigCdPro.Cunis, ;
                            Cgrus  WITH loc_lcGru, ;
                            Compos WITH loc_lcCompo, ;
                            Tps    WITH '1'
                ENDIF
                REPLACE Qtds WITH Qtds + (crSigPrCpo.Qtds * TempOpi.Qtds)
            ENDSCAN

            SELECT TmpRes
            IF !SEEK('1' + ALLTRIM(loc_lcGru) + ALLTRIM(loc_lcCompo))
                APPEND BLANK
                REPLACE Cgrus  WITH loc_lcGru, ;
                        Compos WITH loc_lcCompo, ;
                        Tps    WITH '1'
            ENDIF
            REPLACE QtPcs WITH QtPcs + TempOpi.Qtds, ;
                    Pesos WITH Pesos + TempOpi.Pesos
        ENDSCAN

        SELECT TmpImp
        GO TOP
        IF EOF()
            MsgAviso("Nenhuma Sequ" + CHR(234) + "ncia Foi Selecionada Para Impress" + CHR(227) + "o!!!", "")
        ELSE
            SELECT Mats, Descs, Cunis, SUM(Qtds) AS Qtds, SUM(Pesos) AS Pesos, SUM(QtPcs) AS QtPcs ;
              FROM TmpRes ;
             GROUP BY Mats, Descs, Cunis ;
             INTO CURSOR csRes

            SELECT csRes
            SCAN
                SELECT TmpRes
                APPEND BLANK
                REPLACE Tps    WITH '2', ;
                        Compos WITH 'Geral', ;
                        Mats   WITH csRes.Mats, ;
                        Descs  WITH csRes.Descs, ;
                        Cunis  WITH csRes.Cunis, ;
                        Qtds   WITH csRes.Qtds, ;
                        QtPcs  WITH csRes.QtPcs, ;
                        Pesos  WITH csRes.Pesos
            ENDSCAN

            CREATE CURSOR dbCabec (Operacao c(20), Ordem c(15), DtGeras d, Subtitulo c(100))
            INSERT INTO dbCabec (Operacao, Ordem, DtGeras, Subtitulo) ;
                VALUES (IIF(THIS.this_nTpOrdem = 1, ALLTRIM(crSigCdPam.DoppPads), ALLTRIM(crSigCdPam.DoppServs)), ;
                        TRANSFORM(loc_Nop, "@L 999999") + '-' + TRANSFORM(loc_Nop2, "@L 999999"), loc_DtGera, "")

            SELECT TmpImp
            IF !loc_Pedido
                SELECT Nops, Seqs, CPros, CodCors, CodTams, DPros, '' AS Obs, Pedido, ImpPeds, ;
                       Linhas, ImpCodBar, dtGeras, SUM(Pesos) AS Pesos, SUM(Qtde) AS Qtde, SUM(Qtdep) AS Qtdep ;
                  FROM TmpImp ;
                 GROUP BY 1,2,3,4,5,6,7,8,9,10,11,12 ;
                 ORDER BY Linhas, CPros, Seqs ;
                  INTO CURSOR TmpImp2
            ENDIF

            IF par_cSaida = 'V'
                IF loc_Barra
                    REPORT FORM SigReGlb PREVIEW NOCONSOLE
                ELSE
                    REPORT FORM SigReGlr PREVIEW NOCONSOLE
                ENDIF
            ELSE
                IF loc_Barra
                    REPORT FORM SigReGlb TO PRINT PROMPT NOCONSOLE
                ELSE
                    REPORT FORM SigReGlr TO PRINT PROMPT NOCONSOLE
                ENDIF
            ENDIF

            IF loc_Resumo
                SELECT TmpRes
                GO TOP
                IF par_cSaida = 'V'
                    REPORT FORM SigPrGlp PREVIEW NOCONSOLE
                ELSE
                    REPORT FORM SigPrGlp TO PRINT PROMPT NOCONSOLE
                ENDIF
            ENDIF
        ENDIF

        IF USED("TmpImp")
            USE IN TmpImp
        ENDIF
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * ProcEtiquetas - Impressao de etiquetas (Tipo=2)
    *--------------------------------------------------------------------------
    PROCEDURE ProcEtiquetas(par_cSaida)
        LOCAL pSqi, pSqf
        LOCAL loc_Nop, loc_Seqi, loc_Seqf, loc_Seq
        LOCAL loc_Divid, loc_Geral, loc_Lini, loc_Coli, loc_Pula, loc_xPula
        LOCAL loc_ImpCmp, loc_llCera, loc_llBoleto, loc_lcOperacao
        LOCAL loc_lcQuery, loc_nResult, loc_lcEdp, loc_cPedido
        LOCAL loc_llNumOpe, loc_NopObs, loc_ObsPed, loc_ObsPed2, loc_CntLnhO
        LOCAL loc_lnOpAnt, loc_Obs, loc_obsP, loc_lnNop, loc_ImpCodBar
        LOCAL loc_Linhas, loc_QtdSemF, loc_Ok, loc_nOldMemoWidth
        LOCAL loc_lcPrinterBol, loc_lcTub, loc_lctub, loc_Obsx
        LOCAL loc_nQt, loc_xLine, loc_lnQt2, loc_CntLnh, loc_xObs
        LOCAL loc_Obs2, loc_qtd, loc_pes
        LOCAL loc_llProcs, loc_llObs, loc_llDp2

        loc_Nop     = THIS.this_nOrdem
        loc_Seqi    = THIS.this_nSeqIni
        loc_Seqf    = IIF(THIS.this_nSeqFim = 0, 9999, THIS.this_nSeqFim)
        loc_Divid   = (THIS.this_nDivididas = 1)
        loc_Geral   = (THIS.this_nImprimir = 1)
        loc_Lini    = THIS.this_nLinha
        loc_Coli    = THIS.this_nColuna
        loc_ImpCmp  = (THIS.this_nCompo = 1)
        loc_llCera  = (THIS.this_nCera = 1)
        loc_llBoleto = (THIS.this_nBoleto = 1)
        *-- Filtros da secao Etiquetas marcados em campos_faltantes.PNG (2026-07-01)
        loc_llProcs = (THIS.this_nProcesso = 1)     && Processos: incluir processos relacionados
        loc_llObs   = (THIS.this_nComplemto = 1)    && Observacao do Pedido: incluir obs
        loc_llDp2   = (THIS.this_nOptDescs = 2)     && Descricao do Produto: Descritivo em vez de Normal

        CREATE CURSOR TmpImp (QtdEtiqs c(1), Nops n(10), Ordem n(6), Seqs n(4), CPros c(14), Qtde n(10,3), Obs m, ;
                              Peso n(9,2), CodBar l, ImpCodBar c(10), nFunds n(6), DtFunds d, ChkFunds l, Nop2s n(12), ;
                              Dataes d, Idnfs c(40), Ceras l, codAcbs c(3), cClass c(3), tubos n(2), ObsPeds m, ctubos c(8), TipoOps c(2))
        INDEX ON STR(Nops, 10) + QtdEtiqs TAG Nops
        SET ORDER TO Nops DESCENDING

        loc_Pula = ((loc_Lini - 1) + ((loc_Coli - 1) * 10))

        IF !loc_llBoleto
            FOR loc_xPula = 1 TO loc_Pula
                APPEND BLANK
            ENDFOR
        ENDIF

        IF THIS.this_nTpOrdem = 1
            loc_lcOperacao = crSigCdPam.DoppPads
        ELSE
            loc_lcOperacao = crSigCdPam.DoppServs
        ENDIF

        loc_llNumOpe = .F.
        THIS.CursorQuery('SigCdOpd', 'crTmpCdOpd', 'Dopps', ALLTRIM(loc_lcOperacao), 'Numeras')
        IF USED("crTmpCdOpd")
            SELECT crTmpCdOpd
            IF RECCOUNT() > 0
                loc_llNumOpe = (crTmpCdOpd.Numeras = 4)
            ENDIF
        ENDIF

        pSqi = INT(VAL(STR(loc_Nop, 6) + PADL(ALLTRIM(STR(loc_Seqi)), 4, '0')))
        pSqf = INT(VAL(STR(loc_Nop, 6) + PADL(ALLTRIM(STR(loc_Seqf)), 4, '0')))

        loc_lcQuery = "SELECT * FROM SigOpPic " + ;
                      "WHERE EmpDNps = '" + go_4c_Sistema.cCodEmpresa + ALLTRIM(loc_lcOperacao) + STR(loc_Nop, 10) + "'" + ;
                      " AND " + IIF(loc_llNumOpe, "0=0", "Nops BETWEEN ?pSqi AND ?pSqf") + ;
                      " AND NOT Qtds = 0 ORDER BY Nops"

        loc_nResult = SQLEXEC(gnConnHandle, loc_lcQuery, "TempOpi")
        IF loc_nResult < 1
            MsgErro("Favor Reinicializar o Processo!!!", "Falha na Conex" + CHR(227) + "o (TempOpi)")
            IF USED("TmpImp")
                USE IN TmpImp
            ENDIF
            RETURN .F.
        ENDIF

        CREATE CURSOR DbImpressao (Nops c(12), idNfs c(30), Ceras l, Cpros c(14), cclass c(3), Pesos n(9,3), ;
                                   Qtds n(1), cfunds c(30), Obs m, ObsE m, CodBar L, QtdEtiqs c(1), QtdeEtiq n(12,3))
        INDEX ON Nops + QtdEtiqs TAG Nops

        loc_nOldMemoWidth = SET('MemoWidth')
        SET MEMOWIDTH TO 90

        loc_NopObs    = 0
        loc_ObsPed    = ''
        loc_ObsPed2   = ''
        loc_CntLnhO   = 0
        loc_lnOpAnt   = TRANSFORM(0, "@L 999999999999")

        SELECT TempOpi
        SCAN
            loc_Seq = VAL(RIGHT(STR(TempOpi.Nops, 10), 4))
            IF (!loc_Geral AND TempOpi.Imprs) OR (loc_Divid AND !TempOpi.Divs)
                LOOP
            ENDIF

            loc_lcEdp = ALLTRIM(TempOpi.Emps) + ALLTRIM(TempOpi.Dopps) + STR(TempOpi.Nops, 10)
            THIS.CursorQuery('SigPdMvf', 'TempMfas', 'EmpDNps', loc_lcEdp)
            THIS.CursorQuery('SigCdPro', 'crSigCdPro', 'CPros', ALLTRIM(TempMfas.CodPds))
            THIS.CursorQuery('SigCdOpd', 'crSigCdOpd', 'Dopps', ALLTRIM(TempOpi.Dopps))
            THIS.CursorQuery('SigCdOpe', 'crSigCdOpe', 'Dopes', ALLTRIM(TempOpi.Dopes))
            THIS.CursorQuery('SigCdAca', 'crSigCdAca', 'Cods', ALLTRIM(CrSigCdPro.CodAcbs))

            IF loc_llCera AND CrSigCdPro.CravCers <> 1
                LOOP
            ENDIF

            loc_nResult = SQLEXEC(gnConnHandle, ;
                "SELECT Tubos FROM SigCdFud WHERE nops = " + ALLTRIM(STR(TempOpi.Nops, 10)), "TmpIfund")
            SELECT TmpIfund
            loc_lctub = ''
            SCAN
                loc_lctub = loc_lctub + IIF(EMPTY(loc_lctub), '', '/') + ALLTRIM(STR(tubos, 2))
            ENDSCAN

            IF TempOpi.Nops <> loc_NopObs
                loc_NopObs  = TempOpi.Nops
                loc_ObsPed  = ''
                loc_CntLnhO = 0
            ENDIF

            loc_cPedido = ALLTRIM(TempOpi.Emps) + ALLTRIM(crSigCdOpe.Abrevs) + ' ' + ALLTRIM(fGerMascara(TempOpi.Numes))

            loc_Obs  = ''
            loc_obsP = ''
            loc_lnNop = TRANSFORM(crSigCdOpd.NDopps, '@L 99') + TRANSFORM(TempOpi.Nops, '@L 9999999999')

            SELECT TmpImp
            SET ORDER TO Nops
            IF !SEEK(STR(TempOpi.Nops, 10) + '1')
                loc_ImpCodBar = fAltBar2de5(TRANSFORM(crSigCdOpd.NDopps, '@L 99') + TRANSFORM(TempOpi.Nops, '@L 9999999999'))
                INSERT INTO TmpImp (Nops, Ordem, Seqs, Cpros, CodBar, ImpCodBar, qtdetiqs, nFunds, DtFunds, Dataes, ;
                                    Idnfs, ceras, CodAcbs, cClass, Tubos, ctubos, TipoOps) ;
                         VALUES (TempOpi.Nops, loc_Nop, loc_Seq, TempMFas.CodPds, .T., loc_ImpCodBar, '1', TempOpi.nFunds, ;
                                 NVL(TempOpi.DtFunds, CTOD('')), NVL(TempOpi.Dataes, CTOD('')), ;
                                 ALLTRIM(CrSigCdAca.cods) + ' ' + ALLTRIM(CrSigCdAca.Descrs), (CrSigCdPro.CravCers = 1), ;
                                 CrSigCdPro.CodAcbs, CrSigCdPro.cClass, TmpIfund.tubos, loc_lctub, ;
                                 IIF(THIS.this_nTpOrdem = 1, 'OP', 'OS'))

                IF THIS.this_nBoleto = 3
                    INSERT INTO DbImpressao (Nops, idNfs, Ceras, Cpros, cclass, cfunds, CodBar, QtdEtiqs, Qtds) VALUES ;
                        (loc_lnNop, ALLTRIM(CrSigCdAca.cods)+' '+ALLTRIM(CrSigCdAca.Descrs), CrSigCdPro.CravCers = 1, ;
                         TempMfas.CodPds, CrSigCdPro.cClass, ;
                         IIF(TempOpi.nfunds <> 0, ALLTRIM(STR(TempOpi.nFunds,6)) + '  -T:' + ;
                             ALLTRIM(loc_lctub), ' ') + '  ' + DTOC(TmpImp.Dataes), .T., '1', 1)
                ENDIF

                loc_ObsPed2 = ''

                IF loc_ImpCmp
                    loc_nResult = SQLEXEC(gnConnHandle, ;
                        "SELECT a.Mats, a.Qtscons, b.Sgrus FROM SigPrCpo a, SigCdPro b " + ;
                        "WHERE a.Cpros = '" + ALLTRIM(CrSigCdPro.Cpros) + "' AND a.mats = b.Cpros", ;
                        "CrSigPrCpo")
                    loc_CntLnh = 0
                    SELECT crSigPrCpo
                    SCAN
                        IF ALLTRIM(CrSigPrCpo.sgrus) <> ALLTRIM(CrSigCdPac.sgrus) OR EMPTY(CrSigCdPac.sgrus)
                            LOOP
                        ENDIF
                        loc_CntLnh = loc_CntLnh + 1
                        IF loc_CntLnh = 4
                            loc_Obs = loc_Obs + CHR(13) + CHR(10)
                            loc_CntLnh = 1
                        ENDIF
                        loc_xObs = ALLTRIM(Mats) + '(' + ALLTRIM(STR(Qtscons)) + ') - '
                        loc_Obs  = loc_Obs + loc_xObs
                    ENDSCAN
                    IF !EMPTY(loc_Obs) AND loc_CntLnh > 1
                        loc_Obs = loc_Obs + CHR(13) + CHR(10)
                    ENDIF
                ENDIF
            ENDIF

            loc_ObsPed  = loc_ObsPed + loc_cPedido + '/'
            loc_CntLnhO = loc_CntLnhO + 1
            IF loc_CntLnhO > 3
                loc_CntLnhO = 0
                loc_ObsPed = loc_ObsPed + CHR(13) + CHR(10)
            ENDIF

            SELECT TmpImp
            REPLACE Qtde    WITH Qtde + TempOpi.Qtds, ;
                    Peso    WITH Peso + ROUND(TempOpi.Qtds * TempOpi.pesos, 2), ;
                    ChkFunds WITH IIF(crSigCdOpe.ChkFunds OR crSigCdPro.ChkFunds, .F., .T.), ;
                    ObsPeds WITH IIF(loc_llObs, loc_ObsPed, '')  && Filtro Obs.Pedido

            FOR loc_xLine = 1 TO MEMLINES(TempOpi.Obss)
                IF !EMPTY(MLINE(TempOpi.Obss, loc_xLine))
                    loc_Obs = loc_Obs + MLINE(TempOpi.Obss, loc_xLine) + ' '
                ENDIF
            ENDFOR

            loc_Linhas = IIF(TmpImp.CodBar, 4, 6)
            IF MEMLINES(STR(TempOpi.Qtds, 6, 2) + ' : ' + loc_Obs) + MEMLINES(TmpImp.Obs) > loc_Linhas AND ;
               !EMPTY(loc_Obs) AND !loc_llBoleto
                INSERT INTO TmpImp (Nops, Ordem, Seqs, Cpros, CodBar, qtdetiqs, nFunds, DtFunds, Idnfs, Ceras, CodAcbs, cClass, Tubos, ctubos, TipoOps) ;
                         VALUES (TempOpi.Nops, loc_Nop, loc_Seq, TempMFas.CodPds, .F., '2', TempOpi.nFunds, ;
                                 NVL(TempOpi.DtFunds, CTOD('')), ALLTRIM(CrSigCdAca.cods)+' '+ALLTRIM(CrSigCdAca.Descrs), ;
                                 (CrSigCdPro.CravCers = 1), CrSigCdPro.CodAcbs, CrSigCdPro.cClass, TmpIfund.tubos, loc_lctub, ;
                                 IIF(THIS.this_nTpOrdem = 1, 'OP', 'OS'))
            ENDIF

            IF !EMPTY(loc_Obs)
                loc_Obs = STR(TempOpi.Qtds, 6, 2) + ' : ' + loc_Obs
                REPLACE Obs WITH TmpImp.Obs + loc_Obs + CHR(13) + CHR(10) IN TmpImp
            ENDIF

            loc_lnOpAnt = loc_lnNop
        ENDSCAN

        SET MEMOWIDTH TO loc_nOldMemoWidth

        SELECT TmpImp
        loc_QtdSemF = 0
        IF THIS.this_lRastreab
            COUNT TO loc_QtdSemF FOR nFunds = 0 AND ChkFunds
        ENDIF

        GO TOP
        loc_Ok = .T.
        IF EOF() OR (loc_QtdSemF > 0)
            IF loc_QtdSemF > 0
                MsgAviso("Existem Sequ" + CHR(234) + "ncias Que Ainda N" + CHR(227) + "o Foram Fundidas!!!", "Erro")
                loc_Ok = .F.
            ELSE
                MsgAviso("Nenhuma Sequ" + CHR(234) + "ncia Foi Selecionada Para Impress" + CHR(227) + "o!!!", "")
                loc_Ok = .F.
            ENDIF
        ENDIF

        IF loc_Ok
            SET ORDER TO Nops ASCENDING
            IF par_cSaida = 'V'
                IF THIS.this_nBoleto = 1
                    REPORT FORM SigReGlg PREVIEW NOCONSOLE
                ELSE
                    IF THIS.this_nBoleto = 2
                    REPORT FORM SigReGle PREVIEW NOCONSOLE
                    ENDIF
                ENDIF
            ELSE
                IF THIS.this_nBoleto = 1
                    IF EMPTY(THIS.this_cPcPrinterBol)
                        REPORT FORM SigReGlg TO PRINT PROMPT NOCONSOLE
                    ELSE
                        loc_lcPrinterBol = THIS.this_cPcPrinterBol
                        SET PRINTER TO NAME (loc_lcPrinterBol)
                        REPORT FORM SigReGlg TO PRINT NOCONSOLE
                        SET PRINTER TO
                    ENDIF
                ELSE
                    IF THIS.this_nBoleto = 2
                    REPORT FORM SigReGle TO PRINT PROMPT NOCONSOLE
                ELSE
                    IF THIS.this_nBoleto = 3
                    SELECT DbImpressao
                    GO TOP
                    DO FORM SigOpEtS WITH .NULL., 0
                    ENDIF
                    ENDIF
                ENDIF
            ENDIF
        ENDIF

        IF par_cSaida <> 'V' AND THIS.this_nBoleto = 2
            SELECT TmpImp
            SCAN
                loc_Lini = loc_Lini + 1
                IF loc_Lini > 10
                    loc_Lini = 1
                    loc_Coli = loc_Coli + 1
                ENDIF
                IF loc_Coli > 3
                    loc_Coli = 1
                ENDIF
            ENDSCAN
            THIS.this_nLinha  = loc_Lini
            THIS.this_nColuna = loc_Coli
        ENDIF

        IF USED("TmpImp")
            USE IN TmpImp
        ENDIF
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * ProcTiraf - Tira padrao: Tipo=3 (Ordem2=0) ou Tipo=4 (Ordem2=0)
    *--------------------------------------------------------------------------
    PROCEDURE ProcTiraf(par_cSaida)
        LOCAL pSqi, pSqf
        LOCAL pTru, pIds
        LOCAL loc_Nop, loc_Pedido, loc_Seqi, loc_Seqf, loc_Seq, loc_cPedido
        LOCAL loc_Divid, loc_Geral, loc_ImpCmp, loc_llCera, loc_llProcs, loc_llObs
        LOCAL loc_llNome, loc_lcclass, loc_lcObsOper, loc_lcCodlin, loc_lcCodcor
        LOCAL loc_llDp2, loc_lcFase, loc_lcOperacao, loc_lcQuery, loc_nResult
        LOCAL loc_lcEdp, loc_lcEdn, loc_llImpEnv, loc_llNumOpe
        LOCAL loc_Nops, loc_Primeiro, loc_ImpCodBar, loc_Peso, loc_Emp
        LOCAL loc_Codcli, loc_lcDimen, loc_lcObs, loc_lcOb2, loc_lcDpros, loc_lcDp2
        LOCAL loc_ncont, loc_ncont2, loc_lcSql, loc_lcPrinterBol, loc_lcFoto
        LOCAL loc_lcCodigo, loc_lcDirectory, loc_lcBrancos, loc_lcConq

        loc_Nop       = THIS.this_nOrdem
        loc_Pedido    = (THIS.this_nRelPedido = 1)
        loc_Seqi      = THIS.this_nSeqIni
        loc_Seqf      = IIF(THIS.this_nSeqFim = 0, 9999, THIS.this_nSeqFim)
        loc_Divid     = (THIS.this_nDivididas = 1)
        loc_Geral     = (THIS.this_nImprimir = 1)
        loc_ImpCmp    = (THIS.this_nCompo = 1)
        loc_llCera    = (THIS.this_nCera = 1)
        loc_llProcs   = (THIS.this_nProcesso = 1)
        loc_llObs     = (THIS.this_nComplemto = 1)
        loc_llNome    = (THIS.this_lNome = 1)
        loc_lcclass   = ALLTRIM(THIS.this_cClass)
        loc_lcObsOper = ALLTRIM(THIS.this_cObsOper)
        loc_lcCodlin  = ALLTRIM(THIS.this_cLin)
        loc_lcCodcor  = ALLTRIM(THIS.this_cCor)
        loc_llDp2     = (THIS.this_nOptDescs = 2) OR INLIST(THIS.this_nBoleto, 1, 4)
        loc_lcFase    = ALLTRIM(THIS.this_cFase)

        CREATE CURSOR TmpImp (Ordem n(6), Seqs n(4), Nops n(10), CPros c(14), DPros c(40), DPro2s c(45), CUnis c(3), Qtde n(10,3), ;
                              Peso n(9,2), CUniPs c(3), Obs m, Pedido c(13), Datas d, ImpCodBar c(20), CMats c(14), DMats c(50), ;
                              QPedras n(12,3), QConsumo n(12,2), OrdImp n(1), Detalhe1 L, Detalhe2 L, Detalhe3 L, ;
                              CodTgOps c(10), Detalhe4 L, Detalhe5 L, Dividida L, Ultimo L, Primeiro L, Quebra L, ;
                              Ordimg c(17), Vends c(10), CodCli c(10), DtEnt d, Linhas c(40), dGrupos c(20), CodCors c(4), ;
                              CodTams c(4), DesCors c(30), Numps n(10), Usuars c(10), Reffs c(40), TpInstals c(1), ;
                              CorPads c(25), Rclis c(40), cMat2s c(14), Notas c(6), Processos L, Obses M, Obses2 M, ;
                              ncompo n(3), empdopnums c(29), citens n(10), lNome L, Matriz c(14), ObsOFs c(120), ObsMtz m, ;
                              cClass c(3), Cgrus c(3), CodFinP c(3), codAcbs c(3), Sgrus c(6), Dimens c(30), Colecoes c(10), ;
                              Prod2Linhas l(1), TipoOps c(2), lDtGer L)
        INDEX ON STR(Nops, 10) + STR(OrdImp,1) TAG NopOrdem
        INDEX ON Nops TAG Nops
        SET ORDER TO Nops

        loc_lcBrancos = ADDBS(ADDBS(JUSTPATH(JUSTPATH(ADDBS(ALLTRIM(gc_4c_CaminhoBase)))))) + "Framework\BrJpg.JPG"
        CREATE CURSOR crBranco (Branco M)
        SELECT crBranco
        APPEND BLANK
        IF FILE(loc_lcBrancos)
            APPEND MEMO Branco FROM (loc_lcBrancos) OVERWRITE
            loc_lcFoto = STRCONV(STRTRAN(STRTRAN(STRTRAN(crBranco.Branco, ;
                'data:image/png;base64,', ''), 'data:image/jpeg;base64,', ''), 'data:image/jpg;base64,', ''), 14)
            IF !EMPTY(loc_lcFoto)
                =STRTOFILE(loc_lcFoto, SYS(2023) + '\FBRANCOS.JPG')
            ENDIF
        ENDIF

        loc_llImpEnv = .F.
        IF THIS.this_nTpOrdem = 1
            loc_lcOperacao = crSigCdPam.DoppPads
        ELSE
            loc_lcOperacao = crSigCdPam.DoppServs
            IF !EMPTY(CrSigCdPam.DopEnvels) AND USED("crSigCdPac") AND crSigCdPac.iTiras = 2
                loc_llImpEnv = .T.
            ENDIF
        ENDIF

        loc_llNumOpe = .F.
        THIS.CursorQuery('SigCdOpd', 'crTmpCdOpd', 'Dopps', ALLTRIM(loc_lcOperacao), 'Numeras')
        IF USED("crTmpCdOpd")
            SELECT crTmpCdOpd
            IF RECCOUNT() > 0
                loc_llNumOpe = (crTmpCdOpd.Numeras = 4)
            ENDIF
        ENDIF

        pSqi = INT(VAL(STR(loc_Nop, 6) + PADL(ALLTRIM(STR(loc_Seqi)), 4, '0')))
        pSqf = INT(VAL(STR(loc_Nop, 6) + PADL(ALLTRIM(STR(loc_Seqf)), 4, '0')))

        LOCAL loc_Compara
        loc_Compara = "EmpDNps = '" + go_4c_Sistema.cCodEmpresa + ALLTRIM(loc_lcOperacao) + STR(loc_Nop, 10) + "'"
        IF loc_Divid AND loc_Nop = 0
            loc_Compara = "EmpDNps BETWEEN '" + go_4c_Sistema.cCodEmpresa + ALLTRIM(loc_lcOperacao) + STR(0, 10) + "'" + ;
                          " AND '" + go_4c_Sistema.cCodEmpresa + ALLTRIM(loc_lcOperacao) + "9999999999'"
        ENDIF
        loc_Nops = 0

        loc_lcQuery = "SELECT * FROM SigOpPic " + ;
                      "WHERE " + loc_Compara + " AND " + ;
                      IIF(loc_llNumOpe, "0=0 AND ", "Nops BETWEEN ?pSqi AND ?pSqf AND ") + ;
                      "NOT Qtds = 0 ORDER BY Nops, empdopnums, citens"

        loc_nResult = SQLEXEC(gnConnHandle, loc_lcQuery, "TempOpi")
        IF loc_nResult < 1
            MsgErro("Favor Reinicializar o Processo!!!", "Falha na Conex" + CHR(227) + "o (TempOpi)")
            IF USED("TmpImp")
                USE IN TmpImp
            ENDIF
            RETURN .F.
        ENDIF

        loc_ncont = 1
        SELECT TempOpi
        SCAN
            loc_Seq = VAL(RIGHT(STR(TempOpi.Nops, 10), 4))
            loc_Emp = IIF(EMPTY(Empds), ALLTRIM(Emps), ALLTRIM(Empds))

            IF (!loc_Geral AND Imprs) OR (loc_Divid AND !Divs)
                LOOP
            ENDIF

            loc_lcEdp = ALLTRIM(Emps) + ALLTRIM(Dopps) + STR(Nops, 10)
            loc_lcEdn = loc_Emp + ALLTRIM(TempOpi.Dopes) + STR(TempOpi.Numes, 6)
            THIS.CursorQuery('SigCdPro', 'crSigCdPro', 'CPros', ALLTRIM(TempOpi.cpros))
            THIS.CursorQuery('SigCdOpd', 'crSigCdOpd', 'Dopps', ALLTRIM(TempOpi.Dopps))
            THIS.CursorQuery('SigCdOpe', 'crSigCdOpe', 'Dopes', ALLTRIM(TempOpi.Dopes))
            THIS.CursorQuery('SigCdCor', 'crSigCdCor', 'Cods', ALLTRIM(TempOpi.CodCors))
            THIS.CursorQuery('SigCdCor', 'crTmpCor',   'Cods', ALLTRIM(CrSigCdPro.CodCors))
            THIS.CursorQuery('SigMvCab', 'crSigMvCab', 'EmpDopNums', loc_lcEdn)
            THIS.CursorQuery('SigCdLin', 'crSigCdLin', 'Linhas', ALLTRIM(CrSigCdPro.Linhas))

            IF loc_llCera AND CrSigCdPro.CravCers <> 1
                LOOP
            ENDIF

            IF !EMPTY(loc_lcclass) AND ALLTRIM(loc_lcclass) <> ALLTRIM(crSigCdPro.Cclass)
                LOOP
            ENDIF

            IF !EMPTY(loc_lcCodlin) AND ALLTRIM(loc_lcCodlin) <> ALLTRIM(crSigCdPro.Linhas)
                LOOP
            ENDIF

            IF !EMPTY(loc_lcCodcor) AND ALLTRIM(loc_lcCodcor) <> ALLTRIM(TempOpi.CodCors)
                LOOP
            ENDIF

            IF !EMPTY(loc_lcFase)
                loc_nResult = SQLEXEC(gnConnHandle, ;
                    "SELECT Grupos FROM SigCdLnf WHERE Linhas = '" + ALLTRIM(crSigCdPro.Linhas) + "' AND Grupos = '" + ALLTRIM(loc_lcFase) + "'", ;
                    "crSigCdLnf")
                IF USED("crSigCdLnf")
                    SELECT crSigCdLnf
                    IF EOF()
                        LOOP
                    ENDIF
                ENDIF
            ENDIF

            loc_lcSql = "SELECT Numps FROM SigPdMvf WHERE Nops = " + ALLTRIM(STR(TempOpi.Nops)) + ;
                        " AND Dopps = '" + ALLTRIM(CrSigCdPam.DopEnvels) + "'"
            loc_nResult = SQLEXEC(gnConnHandle, loc_lcSql, "TempMfas")

            SELECT TempOpi
            loc_cPedido = ALLTRIM(TempOpi.Emps) + ALLTRIM(crSigCdOpe.Abrevs) + ' ' + ALLTRIM(fGerMascara(TempOpi.Numes))
            loc_Peso = TempOpi.pesos

            IF loc_Nops <> Nops
                IF loc_llImpEnv AND USED("TempMfas") AND RECCOUNT("TempMfas") > 0
                    SELECT TempMfas
                    loc_ImpCodBar = fAltBar2de5(TRANSFORM(TempMfas.Numps, '@L 9999999999'))
                    SELECT TempOpi
                ELSE
                    loc_ImpCodBar = fAltBar2de5(TRANSFORM(crSigCdOpd.NDopps, '@L 99') + TRANSFORM(TempOpi.Nops, '@L 9999999999'))
                ENDIF

                loc_Nops = Nops
                SELECT TmpImp
                IF !EOF()
                    REPLACE Ultimo WITH .T.
                ENDIF

                INSERT INTO TmpImp (Nops, Detalhe2, OrdImp, TpInstals, Processos) VALUES (loc_Nops, loc_llProcs, 2, '', loc_llProcs)
                loc_Primeiro = .T.
            ELSE
                loc_ImpCodBar = ' '
                loc_Primeiro  = .F.
            ENDIF

            THIS.CursorQuery('SigCdPro', 'LocalPro', 'CPros', ALLTRIM(TempOpi.Cpros))
            loc_nResult = SQLEXEC(gnConnHandle, ;
                "SELECT *, qtds AS QtsCons FROM SigSubMv WHERE empdopnums = ?TempOpi.empdopnums AND cpros = ?TempOpi.CPros AND citem2 = ?TempOpi.citens", ;
                "crSigPrCpo")
            IF RECCOUNT("crSigPrCpo") = 0
                THIS.CursorQuery('SigPrCpo', 'crSigPrCpo', 'CPros', ALLTRIM(TempOpi.CPros))
                loc_ncont2 = 1
            ELSE
                loc_ncont  = loc_ncont + 1
                loc_ncont2 = loc_ncont
            ENDIF

            loc_lcConq = ''
            loc_nResult = SQLEXEC(gnConnHandle, "SELECT * FROM SigCdCnq", "crLocal")
            IF loc_nResult > 0
                SELECT crLocal
                INDEX ON codtams + conquilhas TAG CON
                IF SEEK(ALLTRIM(TempOpi.CodTams) + ALLTRIM(LocalPro.conquilhas), "crLocal", "CON")
                    SET DECIMALS TO 3
                    loc_lcConq = IIF(!EMPTY(LocalPro.conquilhas), ;
                        'C:' + ALLTRIM(LocalPro.conquilhas) + ' - ' + ;
                        ALLTRIM(TRANSFORM(crLocal.valors, '@R 999.999')) + ' - ', '')
                    SET DECIMALS TO 2
                ENDIF
            ENDIF

            loc_Codcli = IIF((THIS.this_nTpOrdem = 1 AND crSigcdOpe.globalizas = 1) OR ;
                             (THIS.this_nTpOrdem = 2 AND crSigcdOpe.Servicos = 1), ;
                             CrSigMvCab.ContaOs, CrSigMvCab.ContaDs)
            THIS.CursorQuery('SigCdCli', 'LocalCli', 'Iclis', ALLTRIM(loc_Codcli), 'Rclis')

            loc_lcDimen = ''
            THIS.CursorQuery('SigCdGrp', 'crSigCdGrp', 'CGrus', ALLTRIM(crSigCdPro.CGrus), 'TitulosPro')
            IF !EMPTY(SUBSTR(crSigCdGrp.TitulosPro, 61, 60))
                loc_lcDimen = ALLTRIM(STR(crSigCdPro.tamps, 5, 2)) + IIF(EMPTY(SUBSTR(crSigCdGrp.TitulosPro, 61, 20)), 'p', ALLTRIM(SUBSTR(crSigCdGrp.TitulosPro, 61, 20)))
                loc_lcDimen = loc_lcDimen + ' x ' + ALLTRIM(STR(crSigCdPro.tamhs, 5, 2)) + IIF(EMPTY(SUBSTR(crSigCdGrp.TitulosPro, 81, 20)), 'a', ALLTRIM(SUBSTR(crSigCdGrp.TitulosPro, 81, 20)))
                loc_lcDimen = loc_lcDimen + ' x ' + ALLTRIM(STR(crSigCdPro.tamls, 5, 2)) + IIF(EMPTY(SUBSTR(crSigCdGrp.TitulosPro, 101, 20)), 'c', ALLTRIM(SUBSTR(crSigCdGrp.TitulosPro, 101, 20)))
            ENDIF

            loc_lcObs  = IIF(loc_llObs, NVL(CrSigMvCab.ObsEs, ''), '')
            loc_lcOb2  = ALLTRIM(NVL(loc_lcObsOper, ''))
            loc_lcDpros = IIF(!EMPTY(TempOpi.DPros), ALLTRIM(TempOpi.DPros), ALLTRIM(crSigCdPro.DPros))
            loc_lcDp2   = IIF(loc_llDp2, ALLTRIM(crSigCdPro.DPro2s), '')

            INSERT INTO TmpImp (Ordem, Seqs, Cpros, Dpros, DPro2s, CUnis, Qtde, Obs, Pedido, ImpCodBar, Detalhe1, Nops, Datas, Peso, ;
                                Dividida, OrdImp, Primeiro, CodCli, DtEnt, Linhas, CodCors, CodTams, DesCors, Numps, Usuars, ;
                                Reffs, TpInstals, CorPads, Rclis, Vends, CodTgOps, Notas, ObsEs, Obses2, ncompo, ;
                                empdopnums, citens, lNome, Cclass, Cgrus, CodFinP, CodAcbs, Sgrus, Dimens, Colecoes, TipoOps, lDtGer) ;
                     VALUES (loc_Nop, loc_Seq, TempOpi.Cpros, loc_lcDpros, loc_lcDp2, crSigCdPro.CUnis, TempOpi.Qtds, ;
                             loc_lcConq + NVL(TempOpi.Obss, ''), loc_cPedido, loc_ImpCodBar, .T., TempOpi.Nops, ;
                             NVL(TempOpi.Dataes, CTOD('')), loc_Peso, TempOpi.Divs, 1, loc_Primeiro, ;
                             loc_Codcli, NVL(crSigMvCab.PrazoEnts, CTOD('')), ;
                             ALLTRIM(crSigCdPro.Linhas) + '-' + ALLTRIM(CrSigCdLin.descs), ;
                             TempOpi.CodCors, TempOpi.CodTams, crSigCdCor.Descs, TempOpi.Numps, TempOpi.Usuars, ;
                             CrSigCdPro.Reffs, '', ALLTRIM(CrSigCdPro.CodCors) + '-' + ALLTRIM(CrTmpCor.Descs), ;
                             IIF(USED("LocalCli") AND RECCOUNT("LocalCli") > 0, LocalCli.Rclis, ''), ;
                             CrSigMvCab.Vends, TempOpi.CodTgOps, TempOpi.Notas, ;
                             loc_lcObs, loc_lcOb2, loc_ncont2, TempOpi.Empdopnums, TempOpi.Citens, loc_llNome, ;
                             crSigCdPro.Cclass, crSigCdPro.Cgrus, crSigCdPro.CodFinP, crSigCdPro.codAcbs, ;
                             crSigCdPro.Sgrus, loc_lcDimen, ALLTRIM(CrSigCdPro.Colecoes), ;
                             IIF(THIS.this_nTpOrdem = 1, 'OP', 'OS'), (THIS.this_lDatager = 1))

            IF EMPTY(crSigCdPro.FigJpgs) OR ISNULL(crSigCdPro.FigJpgs) OR (THIS.this_nTipo = 3)
                REPLACE OrdImg WITH 'FBRANCOS' IN TmpImp
            ELSE
                loc_lcCodigo    = STRTRAN(STRTRAN(STRTRAN(ALLTRIM(TempOpi.Cpros), '/', ''), '*', ''), ' ', '')
                loc_lcDirectory = SYS(2023) + '\F' + ALLTRIM(loc_lcCodigo) + '.Jpg'
                REPLACE OrdImg WITH 'F' + ALLTRIM(loc_lcCodigo) IN TmpImp
                loc_lcFoto = STRCONV(STRTRAN(STRTRAN(STRTRAN(crSigCdPro.FigJpgs, ;
                    'data:image/png;base64,', ''), 'data:image/jpeg;base64,', ''), 'data:image/jpg;base64,', ''), 14)
                =STRTOFILE(loc_lcFoto, loc_lcDirectory)
            ENDIF

            IF par_cSaida = 'I'
                pTru = .T.
                pIds = TempOpi.cIdChaves
                loc_lcQuery = "UPDATE SigOpPic SET Imprs = ?pTru WHERE cIdChaves = ?pIds"
                loc_nResult = SQLEXEC(gnConnHandle, loc_lcQuery, "")
                IF loc_nResult < 1
                    MsgErro("Favor Reinicializar o Processo!!!", "Falha na Conex" + CHR(227) + "o (Update ProcTiraf)")
                    IF USED("TmpImp")
                        USE IN TmpImp
                    ENDIF
                    RETURN .F.
                ENDIF
            ENDIF
        ENDSCAN

        SELECT TmpImp
        REPLACE Ultimo WITH .T.

        GO TOP
        SELECT Nops, CPros, SUM(Qtde) AS Qtde ;
          FROM TmpImp WHERE !EMPTY(cpros) ;
         GROUP BY 1, 2 ORDER BY Nops ;
          INTO CURSOR TmpCompo

        SELECT TmpCompo
        SCAN
            LOCAL lcMtz
            lcMtz = ''
            loc_lcQuery = "SELECT a.*, b.Locals FROM SigPrMtz a, SigCdPro b " + ;
                          "WHERE a.CPros = '" + ALLTRIM(TmpCompo.Cpros) + "' AND a.CMats = b.CPros"
            loc_nResult = SQLEXEC(gnConnHandle, loc_lcQuery, "LocalMtz")
            IF loc_nResult > 0
                SELECT LocalMtz
                SCAN
                    IF RECNO("LocalMtz") = 1
                        lcMtz = 'Borrachas -> '
                    ELSE
                        lcMtz = lcMtz + ' / '
                    ENDIF
                    lcMtz = lcMtz + ALLTRIM(STR(TmpCompo.Qtde * LocalMtz.Qtds, 4)) + ': ' + ALLTRIM(LocalMtz.CMats) + ' (' + ALLTRIM(LocalMtz.Locals) + ')'
                ENDSCAN
            ENDIF
            IF !EMPTY(lcMtz)
                SELECT TmpImp
                GO TOP
                LOCATE FOR Nops = TmpCompo.Nops AND CPros = TmpCompo.CPros AND ultimo
                IF !EOF()
                    REPLACE ObsMtz WITH lcMtz
                ENDIF
            ENDIF
        ENDSCAN

        SELECT TmpImp
        SET ORDER TO Nops
        SCAN
            LOCAL loc_NopLoop, loc_nPeso
            loc_NopLoop = Nops
            loc_nPeso = 0
            SUM Peso TO loc_nPeso WHILE Nops = loc_NopLoop
            SEEK loc_NopLoop
            REPLACE Peso WITH loc_nPeso WHILE Nops = loc_NopLoop
            SKIP -1
        ENDSCAN

        GO TOP
        SELECT Nops, CPros, SUM(Qtde) AS Qtde, empdopnums, citens, numps, CodTams, CodCors ;
          FROM TmpImp WHERE !EMPTY(cpros) ;
         GROUP BY 1, 2, 4, 5, 6, 7, 8 ORDER BY Nops, empdopnums, citens ;
          INTO CURSOR TmpCompo

        loc_ncont = 1
        SELECT TmpCompo
        SCAN
            loc_Primeiro = .T.

            THIS.CursorQuery('SigCdPro', 'LocalPro', 'CPros', ALLTRIM(TmpCompo.Cpros))
            loc_nResult = SQLEXEC(gnConnHandle, ;
                "SELECT *, qtds AS QtsCons FROM SigSubMv WHERE empdopnums = ?TmpCompo.empdopnums AND cpros = ?TmpCompo.CPros AND citem2 = ?TmpCompo.citens", ;
                "crSigPrCpo")
            IF RECCOUNT("crSigPrCpo") = 0
                loc_lcSql = "SELECT a.Mats, b.cunis, b.CuniPs, b.dpros, a.Matriz, a.ObsOFs, " + ;
                            "CASE WHEN e.Qtds IS NULL THEN a.Qtds ELSE e.Qtds END AS Qtds, " + ;
                            "CASE WHEN e.QtsCons IS NULL THEN a.QtsCons ELSE e.QtsCons END AS QtsCons, " + ;
                            "CASE WHEN e.Pesos IS NULL THEN a.Pesos ELSE e.Pesos END AS Pesos " + ;
                            "FROM SigPrCpo a INNER JOIN SigCdPro b ON a.mats = b.Cpros " + ;
                            "INNER JOIN SigCdUni c ON b.Cunis = c.Cunis " + ;
                            "INNER JOIN SigCdGrp d ON b.Cgrus = d.Cgrus " + ;
                            "LEFT JOIN SigSubCp e ON a.Cpros = e.Cpros AND a.mats = e.Mats AND e.CodTams = '" + ALLTRIM(TmpCompo.CodTams) + "' " + ;
                            "WHERE a.Cpros = '" + ALLTRIM(TmpCompo.Cpros) + "'"
                loc_nResult = SQLEXEC(gnConnHandle, loc_lcSql, "crSigPrCpo")
                loc_ncont2 = 1
            ELSE
                loc_ncont  = loc_ncont + 1
                loc_ncont2 = loc_ncont
            ENDIF

            SELECT crSigPrCpo
            SCAN
                THIS.CursorQuery('SigCdPro', 'crSigCdPro', 'CPros', ALLTRIM(crSigPrCpo.Mats))
                THIS.CursorQuery('SigCdGrp', 'crSigCdGrp', 'CGrus', ALLTRIM(crSigCdPro.CGrus))

                IF (crSigCdGrp.CEstoqs # 1 AND CrSigCdGrp.ImpOps <> 3) OR ;
                   !INLIST(CrSigCdGrp.ImpOps, 1, 3) OR !loc_ImpCmp
                    LOOP
                ENDIF

                SELECT TmpImp
                GO TOP
                LOCATE FOR Nops = TmpCompo.Nops AND ALLTRIM(cmats) = ALLTRIM(crSigPrCpo.mats) AND ncompo = loc_ncont2 AND OrdImp = 3
                IF EOF()
                    INSERT INTO TmpImp (Nops, CMats, DMats, QPedras, Detalhe3, OrdImp, Primeiro, QConsumo, Numps, TpInstals, ;
                                        cunis, ncompo, Matriz, ObsOFs, Peso, CUniPs) ;
                                 VALUES (TmpCompo.Nops, crSigPrCpo.Mats, crSigCdPro.DPros, crSigPrCpo.Qtds * TmpCompo.Qtde, ;
                                         .T., 3, loc_Primeiro, crSigPrCpo.QtsCons * TmpCompo.Qtde, TmpCompo.Numps, '', ;
                                         crSigCdPro.Cunis, loc_ncont2, CrSigPrCpo.Matriz, crSigPrCpo.ObsOFs, ;
                                         crSigPrCpo.Pesos * TmpCompo.Qtde, crSigPrCpo.CUniPs)
                    loc_Primeiro = .F.
                ELSE
                    REPLACE QConsumo WITH QConsumo + (crSigPrCpo.QtsCons * TmpCompo.Qtde) IN TmpImp
                    REPLACE QPedras  WITH QPedras  + (crSigPrCpo.Qtds * TmpCompo.Qtde) IN TmpImp
                    REPLACE Peso     WITH Peso     + (crSigPrCpo.Pesos * TmpCompo.Qtde) IN TmpImp
                ENDIF

                IF USED("LocalPro") AND ALLTRIM(LocalPro.CodGarras) = ALLTRIM(CrSigCdPro.Cpros)
                    THIS.CursorQuery('SigPrCpo', 'crSigPrCpo2', 'CPros', ALLTRIM(CrSigPrCpo.Mats))
                    SELECT crSigPrCpo2
                    SCAN
                        THIS.CursorQuery('SigCdPro', 'crSigCdPro', 'CPros', ALLTRIM(crSigPrCpo2.Mats))
                        THIS.CursorQuery('SigCdGrp', 'crSigCdGrp', 'CGrus', ALLTRIM(crSigCdPro.CGrus))

                        IF (crSigCdGrp.CEstoqs # 1 AND CrSigCdGrp.ImpOps <> 3) OR ;
                           !INLIST(CrSigCdGrp.ImpOps, 1, 3)
                            LOOP
                        ENDIF

                        INSERT INTO TmpImp (Nops, CMats, cMat2s, DMats, QPedras, Detalhe3, OrdImp, Primeiro, QConsumo, Numps, ;
                                            TpInstals, cunis, ncompo, Matriz, ObsOFs, Peso, CUniPs) ;
                                     VALUES (TmpCompo.Nops, CrSigPrCpo.Mats, crSigPrCpo2.Mats, crSigCdPro.DPros, ;
                                             crSigPrCpo2.Qtds * TmpCompo.Qtde, .T., 3, .F., ;
                                             crSigPrCpo2.QtsCons * TmpCompo.Qtde, TmpCompo.Numps, '', crSigCdPro.Cunis, ;
                                             loc_ncont2, CrSigPrCpo.Matriz, crSigPrCpo.ObsOFs, ;
                                             crSigPrCpo.Pesos * TmpCompo.Qtde, crSigPrCpo.CUniPs)
                    ENDSCAN
                ENDIF
            ENDSCAN
        ENDSCAN

        IF loc_llProcs
            SELECT TmpImp
            GO TOP
            SELECT Nops, CPros, SUM(Qtde) AS Qtde ;
              FROM TmpImp WHERE !EMPTY(cpros) ;
             GROUP BY 1, 2 ORDER BY Nops ;
              INTO CURSOR TmpCompo

            SELECT TmpCompo
            SCAN
                THIS.CursorQuery('SigCdPrf', 'crSigCdPrf', 'Produtos', ALLTRIM(TmpCompo.CPros), 'Ordems')
                SELECT crSigCdPrf
                SCAN
                    IF EMPTY(Obs)
                        LOOP
                    ENDIF
                    THIS.CursorQuery('SigCdGcr', 'crSigCdGcr', 'Codigos', ALLTRIM(crSigCdPrf.Grupos))
                    INSERT INTO TmpImp (Nops, DGrupos, Detalhe4, OrdImp, Obs, TpInstals) ;
                         VALUES (TmpCompo.Nops, crSigCdGcr.Descrs, .T., 4, NVL(crSigCdPrf.Obs, ''), '')

                    IF EMPTY(crSigCdPrf.FigProcs) OR ISNULL(crSigCdPrf.FigProcs) OR (THIS.this_nTipo = 3)
                        REPLACE OrdImg WITH 'FBRANCOS' IN TmpImp
                    ELSE
                        loc_lcCodigo    = ALLTRIM(crSigCdPrf.Produtos) + ALLTRIM(STR(crSigCdPrf.ordems, 2, 0))
                        loc_lcDirectory = SYS(2023) + '\F' + ALLTRIM(loc_lcCodigo) + '.Jpg'
                        REPLACE OrdImg WITH 'F' + ALLTRIM(loc_lcCodigo) IN TmpImp
                        COPY MEMO crSigCdPrf.FigProcs TO &loc_lcDirectory.
                    ENDIF
                ENDSCAN
            ENDSCAN
        ENDIF

        SELECT TmpImp
        SET ORDER TO NopOrdem
        GO TOP
        LOCAL loc_NopsAnt
        loc_NopsAnt = Nops
        SCAN
            IF Nops <> loc_NopsAnt
                SKIP -1
                REPLACE Quebra WITH .T.
                SKIP +1
                loc_NopsAnt = Nops
            ENDIF
        ENDSCAN

        GO BOTTOM
        REPLACE Quebra WITH .T.
        GO TOP
        IF EOF()
            MsgAviso("Nenhuma Sequ" + CHR(234) + "ncia Foi Selecionada Para Impress" + CHR(227) + "o!!!", "")
        ELSE
            IF par_cSaida = 'V'
                DO CASE
                    CASE THIS.this_nBoleto = 1
                        REPORT FORM SigReGlh PREVIEW NOCONSOLE
                    CASE THIS.this_nBoleto = 4
                        REPLACE ALL Prod2Linhas WITH (THIS.this_l2Linhas = 1)
                        GO TOP
                        REPORT FORM SigReGln PREVIEW NOCONSOLE
                    OTHERWISE
                        REPORT FORM SigReGlu PREVIEW NOCONSOLE
                ENDCASE
            ELSE
                DO CASE
                    CASE THIS.this_nBoleto = 1
                        IF EMPTY(THIS.this_cPcPrinterBol)
                            REPORT FORM SigReGlh TO PRINT PROMPT NOCONSOLE
                        ELSE
                            loc_lcPrinterBol = THIS.this_cPcPrinterBol
                            SET PRINTER TO NAME (loc_lcPrinterBol)
                            REPORT FORM SigReGlh TO PRINT NOCONSOLE
                            SET PRINTER TO
                        ENDIF
                    CASE THIS.this_nBoleto = 4
                        REPORT FORM SigReGln TO PRINT PROMPT NOCONSOLE
                    OTHERWISE
                        REPORT FORM SigReGlu TO PRINT PROMPT NOCONSOLE
                ENDCASE
            ENDIF
        ENDIF

        LOCAL loc_lcApagar
        loc_lcApagar = SYS(2023) + '\F*.Jpg'
        DELETE FILE &loc_lcApagar.

        IF USED("TmpImp")
            USE IN TmpImp
        ENDIF
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * ProcTiraa - Tira dupla (Tipo=3 com Ordem2>0)
    *--------------------------------------------------------------------------
    PROCEDURE ProcTiraa(par_cSaida)
        LOCAL pSqi, pSqf, pSqi2, pSqf2
        LOCAL pTru, pIds
        LOCAL loc_Nop, loc_Nop2, loc_Seqi, loc_Seqf, loc_Seq, loc_cPedido
        LOCAL loc_Divid, loc_Geral, loc_ImpCmp, loc_llCera, loc_lcOperacao
        LOCAL loc_lcQuery, loc_nResult, loc_lcEdp, loc_llNumOpe
        LOCAL loc_Nops, loc_Cpro, loc_Primeiro, loc_ImpCodBar, loc_ImpCodBar2
        LOCAL loc_Peso, loc_Emp, loc_ncont, loc_ncont2, loc_lcSql
        LOCAL loc_llProcs, loc_llObs, loc_llDp2

        loc_Nop     = THIS.this_nOrdem
        loc_Nop2    = THIS.this_nOrdem2
        loc_Seqi    = THIS.this_nSeqIni
        loc_Seqf    = IIF(THIS.this_nSeqFim = 0, 9999, THIS.this_nSeqFim)
        loc_Divid   = (THIS.this_nDivididas = 1)
        loc_Geral   = (THIS.this_nImprimir = 1)
        loc_ImpCmp  = (THIS.this_nCompo = 1)
        loc_llCera  = (THIS.this_nCera = 1)
        *-- Filtros da secao Etiquetas marcados em campos_faltantes.PNG (2026-07-01)
        loc_llProcs = (THIS.this_nProcesso = 1)
        loc_llObs   = (THIS.this_nComplemto = 1)
        loc_llDp2   = (THIS.this_nOptDescs = 2)

        CREATE CURSOR TmpImp (Ordem n(6), Seqs n(4), Nops n(10), CPros c(14), DPros c(40), CUnis c(3), Qtde n(10,3), ;
                              Peso n(9,2), Obs m, Pedido c(30), Datas d, ImpCodBar c(20), CMats c(14), DMats c(50), ;
                              QPedras n(12,3), QConsumo n(12,2), OrdImp n(1), Detalhe1 L, Detalhe2 L, Detalhe3 L, ;
                              Dividida L, Ultimo L, Primeiro L, Quebra L, CodCors c(4), CodTams c(4), DesCors c(30), ;
                              Notas c(06), Reffs c(40), ImpCodBar2 c(20), Data2s d, ncompo n(3), empdopnums c(29), citens n(10))
        INDEX ON CPros + STR(OrdImp, 1) TAG Cpros

        IF THIS.this_nTpOrdem = 1
            loc_lcOperacao = crSigCdPam.DoppPads
        ELSE
            loc_lcOperacao = crSigCdPam.DoppServs
        ENDIF

        loc_llNumOpe = .F.
        THIS.CursorQuery('SigCdOpd', 'crTmpCdOpd', 'Dopps', ALLTRIM(loc_lcOperacao), 'Numeras')
        IF USED("crTmpCdOpd")
            SELECT crTmpCdOpd
            IF RECCOUNT() > 0
                loc_llNumOpe = (crTmpCdOpd.Numeras = 4)
            ENDIF
        ENDIF

        pSqi  = INT(VAL(STR(loc_Nop,  6) + PADL(ALLTRIM(STR(loc_Seqi)), 4, '0')))
        pSqf  = INT(VAL(STR(loc_Nop,  6) + PADL(ALLTRIM(STR(loc_Seqf)), 4, '0')))
        pSqi2 = INT(VAL(STR(loc_Nop2, 6) + PADL(ALLTRIM(STR(loc_Seqi)), 4, '0')))
        pSqf2 = INT(VAL(STR(loc_Nop2, 6) + PADL(ALLTRIM(STR(loc_Seqf)), 4, '0')))
        loc_Nops = 0
        loc_Cpro = SPACE(10)

        loc_lcQuery = "SELECT * FROM SigOpPic " + ;
                      "WHERE " + IIF(loc_llNumOpe, "0=0 AND ", "Nops BETWEEN ?pSqi AND ?pSqf AND") + ;
                      " NOT Qtds = 0 AND Dopps = '" + ALLTRIM(loc_lcOperacao) + "' " + ;
                      "UNION ALL " + ;
                      "SELECT * FROM SigOpPic " + ;
                      "WHERE " + IIF(loc_llNumOpe, "0=0 AND ", "Nops BETWEEN ?pSqi2 AND ?pSqf2 AND") + ;
                      " NOT Qtds = 0 AND Dopps = '" + ALLTRIM(loc_lcOperacao) + "'"

        loc_nResult = SQLEXEC(gnConnHandle, loc_lcQuery, "TempOpi")
        IF loc_nResult < 1
            MsgErro("Favor Reinicializar o Processo!!!", "Falha na Conex" + CHR(227) + "o (TempOpi)")
            IF USED("TmpImp")
                USE IN TmpImp
            ENDIF
            RETURN .F.
        ENDIF

        loc_ncont = 1
        SELECT TempOpi
        INDEX ON CPros + STR(Nops, 10) TAG Nops
        SCAN
            IF Divs
                LOOP
            ENDIF

            loc_Seq = VAL(RIGHT(STR(TempOpi.Nops, 10), 4))
            loc_Emp = IIF(EMPTY(Empds), ALLTRIM(Emps), ALLTRIM(Empds))

            loc_lcEdp = ALLTRIM(Emps) + ALLTRIM(Dopps) + STR(Nops, 10)
            THIS.CursorQuery('SigPdMvf', 'TempMfas', 'EmpDNps', loc_lcEdp)
            THIS.CursorQuery('SigCdPro', 'crSigCdPro', 'CPros', ALLTRIM(TempMfas.CodPds))
            THIS.CursorQuery('SigCdOpd', 'crSigCdOpd', 'Dopps', ALLTRIM(TempOpi.Dopps))
            THIS.CursorQuery('SigCdCor', 'crSigCdCor', 'Cods',  ALLTRIM(TempOpi.CodCors))

            IF loc_llCera AND CrSigCdPro.CravCers <> 1
                LOOP
            ENDIF

            loc_cPedido = ALLTRIM(TempOpi.Emps) + ALLTRIM(TempOpi.Dopes) + ' ' + ALLTRIM(fGerMascara(TempOpi.Numes))
            loc_Peso    = ROUND(TempOpi.Qtds * TempOpi.Pesos, 2)

            IF loc_Nops <> Nops
                IF ALLTRIM(CPros) <> ALLTRIM(loc_Cpro)
                    loc_ImpCodBar  = fAltBar2de5(TRANSFORM(crSigCdOpd.NDopps, '@L 99') + TRANSFORM(TempOpi.Nops, '@L 9999999999'))
                    loc_ImpCodBar2 = ' '
                    loc_Nops = Nops
                    loc_Cpro = ALLTRIM(CPros)
                    SELECT TmpImp
                    IF !EOF()
                        REPLACE Ultimo WITH .T.
                    ENDIF
                    INSERT INTO TmpImp (Cpros, Nops, Detalhe2, OrdImp) VALUES (loc_Cpro, loc_Nops, .T., 2)
                    loc_Primeiro = .T.
                ELSE
                    loc_Nops = Nops
                    loc_ImpCodBar2 = fAltBar2de5(TRANSFORM(crSigCdOpd.NDopps, '@L 99') + TRANSFORM(TempOpi.Nops, '@L 9999999999'))
                    loc_ImpCodBar  = ' '
                    SELECT TmpImp
                    SEEK(loc_Cpro)
                    REPLACE ImpCodBar2 WITH loc_ImpCodBar2, ;
                            Data2s     WITH NVL(TempOpi.Dataes, CTOD('')) IN TmpImp
                ENDIF
            ELSE
                loc_ImpCodBar  = ' '
                loc_ImpCodBar2 = ' '
                loc_Primeiro   = .F.
            ENDIF

            THIS.CursorQuery('SigCdPro', 'LocalPro', 'CPros', ALLTRIM(TempOpi.Cpros))
            loc_nResult = SQLEXEC(gnConnHandle, ;
                "SELECT *, qtds AS QtsCons FROM SigSubMv WHERE empdopnums = ?TempOpi.empdopnums AND cpros = ?TempOpi.CPros AND citem2 = ?TempOpi.citens", ;
                "crSigPrCpo")
            IF RECCOUNT("crSigPrCpo") = 0
                THIS.CursorQuery('SigPrCpo', 'crSigPrCpo', 'CPros', ALLTRIM(TempOpi.CPros))
                loc_ncont2 = 1
            ELSE
                loc_ncont  = loc_ncont + 1
                loc_ncont2 = loc_ncont
            ENDIF

            INSERT INTO TmpImp (Ordem, Seqs, Cpros, Dpros, CUnis, Qtde, Obs, Pedido, ImpCodBar, Detalhe1, Nops, ;
                                Datas, Peso, Dividida, OrdImp, Primeiro, CodCors, CodTams, DesCors, Notas, Reffs, ;
                                ncompo, empdopnums, citens) ;
                         VALUES (loc_Nop, loc_Seq, TempMFas.CodPds, crSigCdPro.DPros, crSigCdPro.CUnis, TempOpi.Qtds, ;
                                 NVL(TempOpi.Obss, ''), loc_cPedido, loc_ImpCodBar, .T., TempOpi.Nops, ;
                                 NVL(TempOpi.Dataes, CTOD('')), loc_Peso, TempOpi.Divs, 1, loc_Primeiro, ;
                                 TempOpi.CodCors, TempOpi.CodTams, crSigCdCor.Descs, TempOpi.Notas, CrSigCdPro.Reffs, ;
                                 loc_ncont2, TempOpi.Empdopnums, TempOpi.Citens)

            IF par_cSaida = 'I'
                pTru = .T.
                pIds = TempOpi.cIdChaves
                loc_lcQuery = "UPDATE SigOpPic SET Imprs = ?pTru WHERE cIdChaves = ?pIds"
                loc_nResult = SQLEXEC(gnConnHandle, loc_lcQuery, "")
                IF loc_nResult < 1
                    MsgErro("Favor Reinicializar o Processo!!!", "Falha na Conex" + CHR(227) + "o (Update ProcTiraa)")
                    IF USED("TmpImp")
                        USE IN TmpImp
                    ENDIF
                    RETURN .F.
                ENDIF
            ENDIF
        ENDSCAN

        SELECT TmpImp
        SET ORDER TO

        SELECT CPros, SUM(Qtde) AS Qtde, Nops, empdopnums, citens, CodTams, CodCors ;
          FROM TmpImp WHERE !EMPTY(cpros) AND OrdImp = 1 ;
         GROUP BY 1, 3, 4, 5, 6, 7 ORDER BY CPros, Nops, empdopnums, citens ;
          INTO CURSOR TmpCompo

        loc_ncont = 1
        SELECT TmpCompo
        SCAN
            loc_Primeiro = .T.

            THIS.CursorQuery('SigCdPro', 'LocalPro', 'CPros', ALLTRIM(TmpCompo.Cpros))
            loc_nResult = SQLEXEC(gnConnHandle, ;
                "SELECT *, qtds AS QtsCons FROM SigSubMv WHERE empdopnums = ?TmpCompo.empdopnums AND cpros = ?TmpCompo.CPros AND citem2 = ?TmpCompo.citens", ;
                "crSigPrCpo")
            IF RECCOUNT("crSigPrCpo") = 0
                loc_lcSql = "SELECT a.Mats, b.cunis, b.dpros, a.Matriz, " + ;
                            "CASE WHEN e.Qtds IS NULL THEN a.Qtds ELSE e.Qtds END AS Qtds, " + ;
                            "CASE WHEN e.QtsCons IS NULL THEN a.QtsCons ELSE e.QtsCons END AS QtsCons " + ;
                            "FROM SigPrCpo a INNER JOIN SigCdPro b ON a.mats = b.Cpros " + ;
                            "INNER JOIN SigCdUni c ON b.Cunis = c.Cunis " + ;
                            "INNER JOIN SigCdGrp d ON b.Cgrus = d.Cgrus " + ;
                            "LEFT JOIN SigSubCp e ON a.mats = e.Mats AND e.CodTams = '" + ALLTRIM(TmpCompo.CodTams) + "' " + ;
                            "WHERE a.Cpros = '" + ALLTRIM(TmpCompo.Cpros) + "' AND a.mats = b.Cpros AND b.Cunis = c.Cunis AND b.Cgrus = d.Cgrus"
                loc_nResult = SQLEXEC(gnConnHandle, loc_lcSql, "crSigPrCpo")
                loc_ncont2 = 1
            ELSE
                loc_ncont  = loc_ncont + 1
                loc_ncont2 = loc_ncont
            ENDIF

            SELECT crSigPrCpo
            SCAN
                THIS.CursorQuery('SigCdPro', 'crSigCdPro', 'CPros', ALLTRIM(crSigPrCpo.Mats))
                THIS.CursorQuery('SigCdGrp', 'crSigCdGrp', 'CGrus', ALLTRIM(crSigCdPro.CGrus))

                IF (crSigCdGrp.CEstoqs # 1 AND CrSigCdGrp.ImpOps <> 3) OR ;
                   !INLIST(CrSigCdGrp.ImpOps, 1, 3) OR !loc_ImpCmp
                    LOOP
                ENDIF

                SELECT TmpImp
                GO TOP
                LOCATE FOR ALLTRIM(cpros) = ALLTRIM(TmpCompo.cpros) AND ALLTRIM(cmats) = ALLTRIM(crSigPrCpo.mats) AND ncompo = loc_ncont2 AND OrdImp = 3
                IF EOF()
                    INSERT INTO TmpImp (cpros, Nops, CMats, DMats, QPedras, Detalhe3, OrdImp, Primeiro, QConsumo, cunis, ncompo) ;
                                 VALUES (TmpCompo.Cpros, TmpCompo.Nops, crSigPrCpo.Mats, crSigCdPro.DPros, ;
                                         crSigPrCpo.Qtds * TmpCompo.Qtde, .T., 3, loc_Primeiro, ;
                                         crSigPrCpo.QtsCons * TmpCompo.Qtde, CrSigCdPro.Cunis, loc_ncont2)
                    loc_Primeiro = .F.
                ELSE
                    REPLACE QConsumo WITH QConsumo + (crSigPrCpo.QtsCons * TmpCompo.Qtde) IN TmpImp
                    REPLACE QPedras  WITH QPedras  + (crSigPrCpo.Qtds * TmpCompo.Qtde) IN TmpImp
                ENDIF

                IF USED("LocalPro") AND ALLTRIM(LocalPro.CodGarras) = ALLTRIM(CrSigCdPro.Cpros)
                    THIS.CursorQuery('SigPrCpo', 'crSigPrCpo2', 'CPros', ALLTRIM(CrSigPrCpo.Mats))
                    SELECT crSigPrCpo2
                    SCAN
                        THIS.CursorQuery('SigCdPro', 'crSigCdPro', 'CPros', ALLTRIM(crSigPrCpo2.Mats))
                        THIS.CursorQuery('SigCdGrp', 'crSigCdGrp', 'CGrus', ALLTRIM(crSigCdPro.CGrus))

                        IF (crSigCdGrp.CEstoqs # 1 AND CrSigCdGrp.ImpOps <> 3) OR ;
                           !INLIST(CrSigCdGrp.ImpOps, 1, 3)
                            LOOP
                        ENDIF

                        INSERT INTO TmpImp (Nops, CMats, cMat2s, DMats, QPedras, Detalhe3, OrdImp, Primeiro, QConsumo, Numps, TpInstals, cunis, ncompo) ;
                                     VALUES (TmpCompo.Nops, CrSigPrCpo.Mats, crSigPrCpo2.Mats, crSigCdPro.DPros, ;
                                             crSigPrCpo2.Qtds * TmpCompo.Qtde, .T., 3, .F., ;
                                             crSigPrCpo2.QtsCons * TmpCompo.Qtde, TmpCompo.Numps, '', crSigCdPro.Cunis, loc_ncont2)
                    ENDSCAN
                ENDIF
            ENDSCAN
        ENDSCAN

        SELECT TmpImp
        SET ORDER TO Cpros
        GO TOP
        LOCAL loc_CprosAnt
        loc_CprosAnt = CPros
        SCAN
            IF ALLTRIM(CPros) <> ALLTRIM(loc_CprosAnt)
                SKIP -1
                REPLACE Quebra WITH .T.
                SKIP +1
                loc_CprosAnt = ALLTRIM(CPros)
            ENDIF
        ENDSCAN
        GO BOTTOM
        REPLACE Quebra WITH .T.
        GO TOP
        IF EOF()
            MsgAviso("Nenhuma Sequ" + CHR(234) + "ncia Foi Selecionada Para Impress" + CHR(227) + "o!!!", "")
        ELSE
            IF par_cSaida = 'V'
                REPORT FORM SigReGla PREVIEW NOCONSOLE
            ELSE
                REPORT FORM SigReGla TO PRINT PROMPT NOCONSOLE
            ENDIF
        ENDIF

        IF USED("TmpImp")
            USE IN TmpImp
        ENDIF
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * ProcTirad - Tira dupla com imagem (Tipo=4 com Ordem2>0)
    *--------------------------------------------------------------------------
    PROCEDURE ProcTirad(par_cSaida)
        LOCAL pSqi, pSqf, pSqi2, pSqf2
        LOCAL pTru, pIds
        LOCAL loc_Nop, loc_Nop2, loc_Seqi, loc_Seqf, loc_Seq, loc_cPedido
        LOCAL loc_llCera, loc_llNome, loc_ImpCmp, loc_llProcs, loc_lcOperacao
        LOCAL loc_lcQuery, loc_nResult, loc_lcEdp, loc_llNumOpe
        LOCAL loc_Nops, loc_Cpro, loc_Primeiro, loc_ImpCodBar, loc_ImpCodBar2
        LOCAL loc_Peso, loc_Emp, loc_ncont, loc_ncont2, loc_lcSql
        LOCAL loc_lcFoto, loc_lcCodigo, loc_lcDirectory, loc_lcBrancos, loc_lcPrinterBol
        LOCAL loc_lcApagar
        LOCAL loc_llObs, loc_llDp2

        loc_Nop     = THIS.this_nOrdem
        loc_Nop2    = THIS.this_nOrdem2
        loc_Seqi    = THIS.this_nSeqIni
        loc_Seqf    = IIF(THIS.this_nSeqFim = 0, 9999, THIS.this_nSeqFim)
        loc_llCera  = (THIS.this_nCera = 1)
        loc_llNome  = (THIS.this_lNome = 1)
        loc_ImpCmp  = (THIS.this_nCompo = 1)
        loc_llProcs = (THIS.this_nProcesso = 1)
        *-- Filtros da secao Etiquetas marcados em campos_faltantes.PNG (2026-07-01)
        loc_llObs   = (THIS.this_nComplemto = 1)
        loc_llDp2   = (THIS.this_nOptDescs = 2)

        CREATE CURSOR TmpImp (Ordem n(6), Seqs n(4), Nops n(10), CPros c(14), DPros c(40), CUnis c(3), Qtde n(10,3), ;
                              Peso n(9,2), Obs m, Pedido c(13), Datas d, ImpCodBar c(20), CMats c(14), DMats c(50), ;
                              QPedras n(12,3), QConsumo n(12,2), OrdImp n(1), Detalhe1 L, Detalhe2 L, Detalhe3 L, ;
                              Detalhe4 L, Dividida L, Ultimo L, Primeiro L, Quebra L, Ordimg c(17), CodCli c(10), ;
                              DtEnt d, Linhas c(40), dGrupos c(20), CodCors c(4), CodTams c(4), DesCors c(30), ;
                              Numps n(10), Usuars c(10), Reffs c(20), TpInstals c(1), CorPads c(25), ImpCodBar2 c(20), Data2s d, ;
                              ncompo n(3), empdopnums c(29), citens n(10), Rclis c(40), lNome L)
        INDEX ON CPros + STR(OrdImp, 1) TAG Cpros

        loc_lcBrancos = ADDBS(ADDBS(JUSTPATH(JUSTPATH(ADDBS(ALLTRIM(gc_4c_CaminhoBase)))))) + "Framework\BrJpg.JPG"
        CREATE CURSOR crBranco (Branco M)
        SELECT crBranco
        APPEND BLANK
        IF FILE(loc_lcBrancos)
            APPEND MEMO Branco FROM (loc_lcBrancos) OVERWRITE
            loc_lcFoto = STRCONV(STRTRAN(STRTRAN(STRTRAN(crBranco.Branco, ;
                'data:image/png;base64,', ''), 'data:image/jpeg;base64,', ''), 'data:image/jpg;base64,', ''), 14)
            IF !EMPTY(loc_lcFoto)
                =STRTOFILE(loc_lcFoto, SYS(2023) + '\FBRANCOS.JPG')
            ENDIF
        ENDIF

        IF THIS.this_nTpOrdem = 1
            loc_lcOperacao = crSigCdPam.DoppPads
        ELSE
            loc_lcOperacao = crSigCdPam.DoppServs
        ENDIF

        loc_llNumOpe = .F.
        THIS.CursorQuery('SigCdOpd', 'crTmpCdOpd', 'Dopps', ALLTRIM(loc_lcOperacao), 'Numeras')
        IF USED("crTmpCdOpd")
            SELECT crTmpCdOpd
            IF RECCOUNT() > 0
                loc_llNumOpe = (crTmpCdOpd.Numeras = 4)
            ENDIF
        ENDIF

        pSqi  = INT(VAL(STR(loc_Nop,  6) + PADL(ALLTRIM(STR(loc_Seqi)), 4, '0')))
        pSqf  = INT(VAL(STR(loc_Nop,  6) + PADL(ALLTRIM(STR(loc_Seqf)), 4, '0')))
        pSqi2 = INT(VAL(STR(loc_Nop2, 6) + PADL(ALLTRIM(STR(loc_Seqi)), 4, '0')))
        pSqf2 = INT(VAL(STR(loc_Nop2, 6) + PADL(ALLTRIM(STR(loc_Seqf)), 4, '0')))
        loc_Nops = 0
        loc_Cpro = SPACE(10)

        loc_lcQuery = "SELECT * FROM SigOpPic " + ;
                      "WHERE " + IIF(loc_llNumOpe, "0=0 AND ", "Nops BETWEEN ?pSqi AND ?pSqf AND") + ;
                      " NOT Qtds = 0 AND Dopps = '" + ALLTRIM(loc_lcOperacao) + "' " + ;
                      "UNION ALL " + ;
                      "SELECT * FROM SigOpPic " + ;
                      "WHERE " + IIF(loc_llNumOpe, "0=0 AND ", "Nops BETWEEN ?pSqi2 AND ?pSqf2 AND") + ;
                      " NOT Qtds = 0 AND Dopps = '" + ALLTRIM(loc_lcOperacao) + "'"

        loc_nResult = SQLEXEC(gnConnHandle, loc_lcQuery, "TempOpi")
        IF loc_nResult < 1
            MsgErro("Favor Reinicializar o Processo!!!", "Falha na Conex" + CHR(227) + "o (TempOpi)")
            IF USED("TmpImp")
                USE IN TmpImp
            ENDIF
            RETURN .F.
        ENDIF

        loc_ncont = 1
        SELECT TempOpi
        SCAN
            loc_Seq = VAL(RIGHT(STR(TempOpi.Nops, 10), 4))
            loc_Emp = IIF(EMPTY(Empds), ALLTRIM(Emps), ALLTRIM(Empds))

            loc_lcEdp = ALLTRIM(Emps) + ALLTRIM(Dopps) + STR(Nops, 10)
            THIS.CursorQuery('SigPdMvf', 'TempMfas', 'EmpDNps', loc_lcEdp)
            THIS.CursorQuery('SigCdPro', 'crSigCdPro', 'CPros', ALLTRIM(TempMfas.CodPds))
            THIS.CursorQuery('SigCdOpd', 'crSigCdOpd', 'Dopps', ALLTRIM(TempOpi.Dopps))
            THIS.CursorQuery('SigCdCor', 'crSigCdCor', 'Cods',  ALLTRIM(TempOpi.CodCors))

            IF loc_llCera AND CrSigCdPro.CravCers <> 1
                LOOP
            ENDIF

            loc_cPedido = ALLTRIM(TempOpi.Emps) + ALLTRIM(TempOpi.Dopes) + ' ' + ALLTRIM(fGerMascara(TempOpi.Numes))
            loc_Peso    = ROUND(TempOpi.Qtds * TempOpi.Pesos, 2)

            IF loc_Nops <> Nops
                IF ALLTRIM(CPros) <> ALLTRIM(loc_Cpro)
                    loc_ImpCodBar  = fAltBar2de5(TRANSFORM(crSigCdOpd.NDopps, '@L 99') + TRANSFORM(TempOpi.Nops, '@L 9999999999'))
                    loc_ImpCodBar2 = ' '
                    loc_Nops = Nops
                    loc_Cpro = ALLTRIM(CPros)
                    SELECT TmpImp
                    IF !EOF()
                        REPLACE Ultimo WITH .T.
                    ENDIF
                    INSERT INTO TmpImp (Cpros, Nops, Detalhe2, OrdImp) VALUES (loc_Cpro, loc_Nops, .T., 2)
                    loc_Primeiro = .T.
                ELSE
                    loc_Nops = Nops
                    loc_ImpCodBar2 = fAltBar2de5(TRANSFORM(crSigCdOpd.NDopps, '@L 99') + TRANSFORM(TempOpi.Nops, '@L 9999999999'))
                    loc_ImpCodBar  = ' '
                    SELECT TmpImp
                    SEEK(loc_Cpro)
                    REPLACE ImpCodBar2 WITH loc_ImpCodBar2, ;
                            Data2s     WITH NVL(TempOpi.Dataes, CTOD('')) IN TmpImp
                ENDIF
            ELSE
                loc_ImpCodBar  = ' '
                loc_ImpCodBar2 = ' '
                loc_Primeiro   = .F.
            ENDIF

            THIS.CursorQuery('SigCdPro', 'LocalPro', 'CPros', ALLTRIM(TempOpi.Cpros))
            loc_nResult = SQLEXEC(gnConnHandle, ;
                "SELECT *, qtds AS QtsCons FROM SigSubMv WHERE empdopnums = ?TempOpi.empdopnums AND cpros = ?TempOpi.CPros AND citem2 = ?TempOpi.citens", ;
                "crSigPrCpo")
            IF RECCOUNT("crSigPrCpo") = 0
                THIS.CursorQuery('SigPrCpo', 'crSigPrCpo', 'CPros', ALLTRIM(TempOpi.CPros))
                loc_ncont2 = 1
            ELSE
                loc_ncont  = loc_ncont + 1
                loc_ncont2 = loc_ncont
            ENDIF

            INSERT INTO TmpImp (Ordem, Seqs, Cpros, Dpros, CUnis, Qtde, Obs, Pedido, ImpCodBar, Detalhe1, Nops, ;
                                Datas, Peso, Dividida, OrdImp, Primeiro, CodCors, CodTams, DesCors, ;
                                Notas, Reffs, ncompo, empdopnums, citens, lNome) ;
                         VALUES (loc_Nop, loc_Seq, TempMFas.CodPds, crSigCdPro.DPros, crSigCdPro.CUnis, TempOpi.Qtds, ;
                                 NVL(TempOpi.Obss, ''), loc_cPedido, loc_ImpCodBar, .T., TempOpi.Nops, ;
                                 NVL(TempOpi.Dataes, CTOD('')), loc_Peso, TempOpi.Divs, 1, loc_Primeiro, ;
                                 TempOpi.CodCors, TempOpi.CodTams, crSigCdCor.Descs, TempOpi.Notas, CrSigCdPro.Reffs, ;
                                 loc_ncont2, TempOpi.Empdopnums, TempOpi.Citens, loc_llNome)

            IF EMPTY(crSigCdPro.FigJpgs) OR ISNULL(crSigCdPro.FigJpgs)
                REPLACE OrdImg WITH 'FBRANCOS' IN TmpImp
            ELSE
                loc_lcCodigo    = STRTRAN(STRTRAN(STRTRAN(ALLTRIM(TempOpi.Cpros), '/', ''), '*', ''), ' ', '')
                loc_lcDirectory = SYS(2023) + '\F' + ALLTRIM(loc_lcCodigo) + '.Jpg'
                REPLACE OrdImg WITH 'F' + ALLTRIM(loc_lcCodigo) IN TmpImp
                loc_lcFoto = STRCONV(STRTRAN(STRTRAN(STRTRAN(crSigCdPro.FigJpgs, ;
                    'data:image/png;base64,', ''), 'data:image/jpeg;base64,', ''), 'data:image/jpg;base64,', ''), 14)
                =STRTOFILE(loc_lcFoto, loc_lcDirectory)
            ENDIF

            IF par_cSaida = 'I'
                pTru = .T.
                pIds = TempOpi.cIdChaves
                loc_lcQuery = "UPDATE SigOpPic SET Imprs = ?pTru WHERE cIdChaves = ?pIds"
                loc_nResult = SQLEXEC(gnConnHandle, loc_lcQuery, "")
                IF loc_nResult < 1
                    MsgErro("Favor Reinicializar o Processo!!!", "Falha na Conex" + CHR(227) + "o (Update ProcTirad)")
                    IF USED("TmpImp")
                        USE IN TmpImp
                    ENDIF
                    RETURN .F.
                ENDIF
            ENDIF
        ENDSCAN

        SELECT TmpImp
        GO TOP
        SELECT Nops, CPros, SUM(Qtde) AS Qtde, empdopnums, citens, numps, CodTams, CodCors ;
          FROM TmpImp WHERE !EMPTY(cpros) ;
         GROUP BY 1, 2, 4, 5, 6, 7, 8 ORDER BY Nops, empdopnums, citens ;
          INTO CURSOR TmpCompo

        loc_ncont = 1
        SELECT TmpCompo
        SCAN
            loc_Primeiro = .T.

            THIS.CursorQuery('SigCdPro', 'LocalPro', 'CPros', ALLTRIM(TmpCompo.Cpros))
            loc_nResult = SQLEXEC(gnConnHandle, ;
                "SELECT *, qtds AS QtsCons FROM SigSubMv WHERE empdopnums = ?TmpCompo.empdopnums AND cpros = ?TmpCompo.CPros AND citem2 = ?TmpCompo.citens", ;
                "crSigPrCpo")
            IF RECCOUNT("crSigPrCpo") = 0
                loc_lcSql = "SELECT a.Mats, b.cunis, b.CuniPs, b.dpros, a.Matriz, a.ObsOFs, " + ;
                            "CASE WHEN e.Qtds IS NULL THEN a.Qtds ELSE e.Qtds END AS Qtds, " + ;
                            "CASE WHEN e.QtsCons IS NULL THEN a.QtsCons ELSE e.QtsCons END AS QtsCons, " + ;
                            "CASE WHEN e.Pesos IS NULL THEN a.Pesos ELSE e.Pesos END AS Pesos " + ;
                            "FROM SigPrCpo a INNER JOIN SigCdPro b ON a.mats = b.Cpros " + ;
                            "INNER JOIN SigCdUni c ON b.Cunis = c.Cunis " + ;
                            "INNER JOIN SigCdGrp d ON b.Cgrus = d.Cgrus " + ;
                            "LEFT JOIN SigSubCp e ON a.Cpros = e.Cpros AND a.mats = e.Mats AND e.CodTams = '" + ALLTRIM(TmpCompo.CodTams) + "' " + ;
                            "WHERE a.Cpros = '" + ALLTRIM(TmpCompo.Cpros) + "'"
                loc_nResult = SQLEXEC(gnConnHandle, loc_lcSql, "crSigPrCpo")
                loc_ncont2 = 1
            ELSE
                loc_ncont  = loc_ncont + 1
                loc_ncont2 = loc_ncont
            ENDIF

            SELECT crSigPrCpo
            SCAN
                THIS.CursorQuery('SigCdPro', 'crSigCdPro', 'CPros', ALLTRIM(crSigPrCpo.Mats))
                THIS.CursorQuery('SigCdGrp', 'crSigCdGrp', 'CGrus', ALLTRIM(crSigCdPro.CGrus))

                IF (crSigCdGrp.CEstoqs # 1 AND CrSigCdGrp.ImpOps <> 3) OR ;
                   !INLIST(CrSigCdGrp.ImpOps, 1, 3) OR !loc_ImpCmp
                    LOOP
                ENDIF

                SELECT TmpImp
                GO TOP
                LOCATE FOR Nops = TmpCompo.Nops AND ALLTRIM(cmats) = ALLTRIM(crSigPrCpo.mats) AND ncompo = loc_ncont2 AND OrdImp = 3
                IF EOF()
                    INSERT INTO TmpImp (Nops, CMats, DMats, QPedras, Detalhe3, OrdImp, Primeiro, QConsumo, Numps, TpInstals, ;
                                        cunis, ncompo, Matriz, ObsOFs, Peso, CUniPs) ;
                                 VALUES (TmpCompo.Nops, crSigPrCpo.Mats, crSigCdPro.DPros, crSigPrCpo.Qtds * TmpCompo.Qtde, ;
                                         .T., 3, loc_Primeiro, crSigPrCpo.QtsCons * TmpCompo.Qtde, TmpCompo.Numps, '', ;
                                         crSigCdPro.Cunis, loc_ncont2, CrSigPrCpo.Matriz, crSigPrCpo.ObsOFs, ;
                                         crSigPrCpo.Pesos * TmpCompo.Qtde, crSigPrCpo.CUniPs)
                    loc_Primeiro = .F.
                ELSE
                    REPLACE QConsumo WITH QConsumo + (crSigPrCpo.QtsCons * TmpCompo.Qtde) IN TmpImp
                    REPLACE QPedras  WITH QPedras  + (crSigPrCpo.Qtds * TmpCompo.Qtde) IN TmpImp
                    REPLACE Peso     WITH Peso     + (crSigPrCpo.Pesos * TmpCompo.Qtde) IN TmpImp
                ENDIF

                IF USED("LocalPro") AND ALLTRIM(LocalPro.CodGarras) = ALLTRIM(CrSigCdPro.Cpros)
                    THIS.CursorQuery('SigPrCpo', 'crSigPrCpo2', 'CPros', ALLTRIM(CrSigPrCpo.Mats))
                    SELECT crSigPrCpo2
                    SCAN
                        THIS.CursorQuery('SigCdPro', 'crSigCdPro', 'CPros', ALLTRIM(crSigPrCpo2.Mats))
                        THIS.CursorQuery('SigCdGrp', 'crSigCdGrp', 'CGrus', ALLTRIM(crSigCdPro.CGrus))

                        IF (crSigCdGrp.CEstoqs # 1 AND CrSigCdGrp.ImpOps <> 3) OR ;
                           !INLIST(CrSigCdGrp.ImpOps, 1, 3)
                            LOOP
                        ENDIF

                        INSERT INTO TmpImp (Nops, CMats, cMat2s, DMats, QPedras, Detalhe3, OrdImp, Primeiro, QConsumo, Numps, ;
                                            TpInstals, cunis, ncompo, Matriz, ObsOFs, Peso, CUniPs) ;
                                     VALUES (TmpCompo.Nops, CrSigPrCpo.Mats, crSigPrCpo2.Mats, crSigCdPro.DPros, ;
                                             crSigPrCpo2.Qtds * TmpCompo.Qtde, .T., 3, .F., ;
                                             crSigPrCpo2.QtsCons * TmpCompo.Qtde, TmpCompo.Numps, '', crSigCdPro.Cunis, ;
                                             loc_ncont2, CrSigPrCpo.Matriz, crSigPrCpo.ObsOFs, ;
                                             crSigPrCpo.Pesos * TmpCompo.Qtde, crSigPrCpo.CUniPs)
                    ENDSCAN
                ENDIF
            ENDSCAN
        ENDSCAN

        IF loc_llProcs
            SELECT TmpImp
            GO TOP
            SELECT Nops, CPros, SUM(Qtde) AS Qtde ;
              FROM TmpImp WHERE !EMPTY(cpros) ;
             GROUP BY 1, 2 ORDER BY Nops ;
              INTO CURSOR TmpCompo

            SELECT TmpCompo
            SCAN
                THIS.CursorQuery('SigCdPrf', 'crSigCdPrf', 'Produtos', ALLTRIM(TmpCompo.CPros), 'Ordems')
                SELECT crSigCdPrf
                SCAN
                    IF EMPTY(Obs)
                        LOOP
                    ENDIF
                    THIS.CursorQuery('SigCdGcr', 'crSigCdGcr', 'Codigos', ALLTRIM(crSigCdPrf.Grupos))
                    INSERT INTO TmpImp (Nops, DGrupos, Detalhe4, OrdImp, Obs, TpInstals) ;
                         VALUES (TmpCompo.Nops, crSigCdGcr.Descrs, .T., 4, NVL(crSigCdPrf.Obs, ''), '')
                ENDSCAN
            ENDSCAN
        ENDIF

        SELECT TmpImp
        SET ORDER TO NopOrdem
        GO TOP
        LOCAL loc_NopsAnt2
        loc_NopsAnt2 = Nops
        SCAN
            IF Nops <> loc_NopsAnt2
                SKIP -1
                REPLACE Quebra WITH .T.
                SKIP +1
                loc_NopsAnt2 = Nops
            ENDIF
        ENDSCAN
        GO BOTTOM
        REPLACE Quebra WITH .T.
        GO TOP
        IF EOF()
            MsgAviso("Nenhuma Sequ" + CHR(234) + "ncia Foi Selecionada Para Impress" + CHR(227) + "o!!!", "")
        ELSE
            IF par_cSaida = 'V'
                DO CASE
                    CASE THIS.this_nBoleto = 1
                        REPORT FORM SigReGlh PREVIEW NOCONSOLE
                    CASE THIS.this_nBoleto = 4
                        REPLACE ALL Prod2Linhas WITH (THIS.this_l2Linhas = 1)
                        GO TOP
                        REPORT FORM SigReGln PREVIEW NOCONSOLE
                    OTHERWISE
                        REPORT FORM SigReGlu PREVIEW NOCONSOLE
                ENDCASE
            ELSE
                DO CASE
                    CASE THIS.this_nBoleto = 1
                        IF EMPTY(THIS.this_cPcPrinterBol)
                            REPORT FORM SigReGlh TO PRINT PROMPT NOCONSOLE
                        ELSE
                            loc_lcPrinterBol = THIS.this_cPcPrinterBol
                            SET PRINTER TO NAME (loc_lcPrinterBol)
                            REPORT FORM SigReGlh TO PRINT NOCONSOLE
                            SET PRINTER TO
                        ENDIF
                    CASE THIS.this_nBoleto = 4
                        REPORT FORM SigReGln TO PRINT PROMPT NOCONSOLE
                    OTHERWISE
                        REPORT FORM SigReGlu TO PRINT PROMPT NOCONSOLE
                ENDCASE
            ENDIF
        ENDIF

        loc_lcApagar = SYS(2023) + '\F*.Jpg'
        DELETE FILE &loc_lcApagar.

        IF USED("TmpImp")
            USE IN TmpImp
        ENDIF
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * ProcEtiqf - Etiquetas com imagem (Tipo=6)
    *--------------------------------------------------------------------------
    PROCEDURE ProcEtiqf(par_cSaida)
        LOCAL pSqi, pSqf
        LOCAL pTru, pIds
        LOCAL loc_Nop, loc_Pedido, loc_Seqi, loc_Seqf, loc_Seq, loc_cPedido
        LOCAL loc_Divid, loc_Geral, loc_ImpCmp, loc_llCera, loc_lcOperacao
        LOCAL loc_lcQuery, loc_nResult, loc_lcEdp, loc_lcEdn, loc_llNumOpe
        LOCAL loc_Nops, loc_Primeiro, loc_ImpCodBar, loc_Peso, loc_Emp
        LOCAL loc_lcFoto, loc_lcCodigo, loc_lcDirectory, loc_lcBrancos
        LOCAL loc_lcApagar, loc_lcPeso, loc_nPeso
        LOCAL loc_llProcs, loc_llObs, loc_llDp2

        loc_Nop    = THIS.this_nOrdem
        loc_Pedido = (THIS.this_nRelPedido = 1)
        loc_Seqi   = THIS.this_nSeqIni
        loc_Seqf   = IIF(THIS.this_nSeqFim = 0, 9999, THIS.this_nSeqFim)
        loc_Divid  = (THIS.this_nDivididas = 1)
        loc_Geral  = (THIS.this_nImprimir = 1)
        loc_ImpCmp = (THIS.this_nCompo = 1)
        loc_llCera = (THIS.this_nCera = 1)
        *-- Filtros da secao Etiquetas marcados em campos_faltantes.PNG (2026-07-01)
        loc_llProcs = (THIS.this_nProcesso = 1)
        loc_llObs   = (THIS.this_nComplemto = 1)
        loc_llDp2   = (THIS.this_nOptDescs = 2)

        CREATE CURSOR TmpImp (Ordem n(6), Seqs n(4), Nops n(10), CPros c(14), DPros c(40), CUnis c(3), Qtde n(10,3), ;
                              Peso n(9,2), Obs m, Pedido c(13), Datas d, CodBar l, ImpCodBar c(20), CMats c(14), DMats c(50), ;
                              QPedras n(12,3), QConsumo n(12,2), OrdImp n(1), Detalhe1 L, Detalhe2 L, Detalhe3 L, ;
                              Detalhe4 L, Dividida L, Ultimo L, Primeiro L, Quebra L, Ordimg c(17), CodCli c(10), ;
                              DtEnt d, Linhas c(40), dGrupos c(20), CodCors c(4), CodTams c(4), DesCors c(30), ;
                              Numps n(10), Usuars c(10), Reffs c(40), TpInstals c(1), CorPads c(25), Ceras l, ;
                              nFunds n(6), DtFunds d, DataEs d, Idnfs c(40))
        INDEX ON STR(Nops, 10) + STR(OrdImp, 1) TAG NopOrdem
        INDEX ON Nops TAG Nops
        SET ORDER TO Nops

        loc_lcBrancos = ADDBS(ADDBS(JUSTPATH(JUSTPATH(ADDBS(ALLTRIM(gc_4c_CaminhoBase)))))) + "Framework\BrJpg.JPG"
        CREATE CURSOR crBranco (Branco M)
        SELECT crBranco
        APPEND BLANK
        IF FILE(loc_lcBrancos)
            APPEND MEMO Branco FROM (loc_lcBrancos) OVERWRITE
            loc_lcFoto = STRCONV(STRTRAN(STRTRAN(STRTRAN(crBranco.Branco, ;
                'data:image/png;base64,', ''), 'data:image/jpeg;base64,', ''), 'data:image/jpg;base64,', ''), 14)
            IF !EMPTY(loc_lcFoto)
                =STRTOFILE(loc_lcFoto, SYS(2023) + '\FBRANCOS.JPG')
            ENDIF
        ENDIF

        IF THIS.this_nTpOrdem = 1
            loc_lcOperacao = crSigCdPam.DoppPads
        ELSE
            loc_lcOperacao = crSigCdPam.DoppServs
        ENDIF

        loc_llNumOpe = .F.
        THIS.CursorQuery('SigCdOpd', 'crTmpCdOpd', 'Dopps', ALLTRIM(loc_lcOperacao), 'Numeras')
        IF USED("crTmpCdOpd")
            SELECT crTmpCdOpd
            IF RECCOUNT() > 0
                loc_llNumOpe = (crTmpCdOpd.Numeras = 4)
            ENDIF
        ENDIF

        pSqi = INT(VAL(STR(loc_Nop, 6) + PADL(ALLTRIM(STR(loc_Seqi)), 4, '0')))
        pSqf = INT(VAL(STR(loc_Nop, 6) + PADL(ALLTRIM(STR(loc_Seqf)), 4, '0')))

        LOCAL loc_Compara2
        loc_Compara2 = "EmpDNps = '" + go_4c_Sistema.cCodEmpresa + ALLTRIM(loc_lcOperacao) + STR(loc_Nop, 10) + "'"
        IF loc_Divid AND loc_Nop = 0
            loc_Compara2 = "EmpDNps BETWEEN '" + go_4c_Sistema.cCodEmpresa + ALLTRIM(loc_lcOperacao) + STR(0, 10) + "'" + ;
                           " AND '" + go_4c_Sistema.cCodEmpresa + ALLTRIM(loc_lcOperacao) + "9999999999'"
        ENDIF
        loc_Nops = 0

        loc_lcQuery = "SELECT * FROM SigOpPic " + ;
                      "WHERE " + loc_Compara2 + " AND " + ;
                      IIF(loc_llNumOpe, "0=0 AND ", "Nops BETWEEN ?pSqi AND ?pSqf AND ") + ;
                      "NOT Qtds = 0 ORDER BY Nops"

        loc_nResult = SQLEXEC(gnConnHandle, loc_lcQuery, "TempOpi")
        IF loc_nResult < 1
            MsgErro("Favor Reinicializar o Processo!!!", "Falha na Conex" + CHR(227) + "o (TempOpi)")
            IF USED("TmpImp")
                USE IN TmpImp
            ENDIF
            RETURN .F.
        ENDIF

        SELECT TempOpi
        SCAN
            loc_Seq = VAL(RIGHT(STR(TempOpi.Nops, 10), 4))
            loc_Emp = IIF(EMPTY(Empds), ALLTRIM(Emps), ALLTRIM(Empds))

            IF (!loc_Geral AND Imprs) OR (loc_Divid AND !Divs)
                LOOP
            ENDIF

            loc_lcEdp = ALLTRIM(Emps) + ALLTRIM(Dopps) + STR(Nops, 10)
            loc_lcEdn = loc_Emp + ALLTRIM(TempOpi.Dopes) + STR(TempOpi.Numes, 6)
            THIS.CursorQuery('SigPdMvf', 'TempMfas', 'EmpDNps', loc_lcEdp)
            THIS.CursorQuery('SigCdPro', 'crSigCdPro', 'CPros', ALLTRIM(TempMfas.CodPds))
            THIS.CursorQuery('SigCdOpd', 'crSigCdOpd', 'Dopps', ALLTRIM(TempOpi.Dopps))
            THIS.CursorQuery('SigCdOpe', 'crSigCdOpe', 'Dopes', ALLTRIM(TempOpi.Dopes))
            THIS.CursorQuery('SigCdCor', 'crSigCdCor', 'Cods',  ALLTRIM(TempOpi.CodCors))
            THIS.CursorQuery('SigCdCor', 'crTmpCor',   'Cods',  ALLTRIM(CrSigCdPro.CodCors))
            THIS.CursorQuery('SigMvCab', 'crSigMvCab', 'EmpDopNums', loc_lcEdn)
            THIS.CursorQuery('SigCdLin', 'crSigCdLin', 'Linhas', ALLTRIM(CrSigCdPro.Linhas))

            IF loc_llCera AND CrSigCdPro.CravCers <> 1
                LOOP
            ENDIF

            loc_cPedido = ALLTRIM(TempOpi.Emps) + ALLTRIM(crSigCdOpe.Abrevs) + ' ' + ALLTRIM(fGerMascara(TempOpi.Numes))
            loc_Peso = ROUND(TempOpi.Qtds * TempOpi.Pesos, 2)

            IF loc_Nops <> Nops
                loc_ImpCodBar = fAltBar2de5(TRANSFORM(crSigCdOpd.NDopps, '@L 99') + TRANSFORM(TempOpi.Nops, '@L 9999999999'))
                loc_Nops = Nops
                SELECT TmpImp
                IF !EOF()
                    REPLACE Ultimo WITH .T.
                ENDIF

                INSERT INTO TmpImp (Nops, Detalhe2, OrdImp, TpInstals) VALUES (loc_Nops, .T., 2, '')
                loc_Primeiro = .T.
            ELSE
                loc_ImpCodBar = ' '
                loc_Primeiro  = .F.
            ENDIF

            INSERT INTO TmpImp (Ordem, Seqs, Cpros, Dpros, CUnis, Qtde, Obs, Pedido, ImpCodBar, Detalhe1, Nops, Datas, Peso, ;
                                Dividida, OrdImp, Primeiro, CodCli, DtEnt, Linhas, CodCors, CodTams, DesCors, Numps, Usuars, ;
                                Reffs, TpInstals, CorPads, Ceras, nFunds, DtFunds, DataEs, Idnfs) ;
                     VALUES (loc_Nop, loc_Seq, TempMFas.CodPds, crSigCdPro.DPros, crSigCdPro.CUnis, TempOpi.Qtds, ;
                             NVL(TempOpi.Obss, ''), loc_cPedido, loc_ImpCodBar, .T., TempOpi.Nops, ;
                             NVL(TempOpi.Dataes, CTOD('')), loc_Peso, TempOpi.Divs, 1, loc_Primeiro, ;
                             crSigMvCab.ContaDs, NVL(crSigMvCab.PrazoEnts, CTOD('')), ;
                             ALLTRIM(crSigCdPro.Linhas) + '-' + ALLTRIM(CrSigCdLin.descs), ;
                             TempOpi.CodCors, TempOpi.CodTams, crSigCdCor.Descs, TempOpi.Numps, TempOpi.Usuars, ;
                             CrSigCdPro.Reffs, '', ALLTRIM(CrSigCdPro.CodCors) + '-' + ALLTRIM(CrTmpCor.Descs), ;
                             (CrSigCdPro.CravCers = 1), TempOpi.nFunds, NVL(TempOpi.DtFunds, CTOD('')), ;
                             NVL(TempOpi.Dataes, CTOD('')), .T.)

            IF EMPTY(crSigCdPro.FigJpgs) OR ISNULL(crSigCdPro.FigJpgs)
                REPLACE OrdImg WITH 'FBRANCOS' IN TmpImp
            ELSE
                loc_lcCodigo    = STRTRAN(STRTRAN(STRTRAN(ALLTRIM(TempMfas.CodPds), '/', ''), '*', ''), ' ', '')
                loc_lcDirectory = SYS(2023) + '\F' + ALLTRIM(loc_lcCodigo) + '.Jpg'
                REPLACE OrdImg WITH 'F' + ALLTRIM(loc_lcCodigo) IN TmpImp
                loc_lcFoto = STRCONV(STRTRAN(STRTRAN(STRTRAN(crSigCdPro.FigJpgs, ;
                    'data:image/png;base64,', ''), 'data:image/jpeg;base64,', ''), 'data:image/jpg;base64,', ''), 14)
                =STRTOFILE(loc_lcFoto, loc_lcDirectory)
            ENDIF

            IF par_cSaida = 'I'
                pTru = .T.
                pIds = TempOpi.cIdChaves
                loc_lcQuery = "UPDATE SigOpPic SET Imprs = ?pTru WHERE cIdChaves = ?pIds"
                loc_nResult = SQLEXEC(gnConnHandle, loc_lcQuery, "")
                IF loc_nResult < 1
                    MsgErro("Favor Reinicializar o Processo!!!", "Falha na Conex" + CHR(227) + "o (Update ProcEtiqf)")
                    IF USED("TmpImp")
                        USE IN TmpImp
                    ENDIF
                    RETURN .F.
                ENDIF
            ENDIF
        ENDSCAN

        SELECT TmpImp
        REPLACE Ultimo WITH .T.
        SET ORDER TO Nops
        SCAN
            LOCAL loc_NopLoop2, loc_nPeso2
            loc_NopLoop2 = Nops
            loc_nPeso2   = 0
            SUM Peso TO loc_nPeso2 WHILE Nops = loc_NopLoop2
            SEEK loc_NopLoop2
            REPLACE Peso WITH loc_nPeso2 WHILE Nops = loc_NopLoop2
            SKIP -1
        ENDSCAN

        SELECT Nops, CPros, SUM(Qtde) AS Qtde, Numps ;
          FROM TmpImp ;
         GROUP BY 1, 2, 4 ;
          INTO CURSOR TmpCompo

        SELECT TmpCompo
        SCAN
            loc_Primeiro = .T.
            THIS.CursorQuery('SigPrCpo', 'crSigPrCpo', 'CPros', ALLTRIM(TmpCompo.CPros))
            SELECT crSigPrCpo
            SCAN
                THIS.CursorQuery('SigCdPro', 'crSigCdPro', 'CPros', ALLTRIM(crSigPrCpo.Mats))
                THIS.CursorQuery('SigCdGrp', 'crSigCdGrp', 'CGrus', ALLTRIM(crSigCdPro.CGrus))

                IF (crSigCdGrp.CEstoqs # 1 AND CrSigCdGrp.ImpOps <> 3) OR ;
                   !INLIST(CrSigCdGrp.ImpOps, 1, 3) OR !loc_ImpCmp
                    LOOP
                ENDIF

                INSERT INTO TmpImp (Nops, CMats, DMats, QPedras, Detalhe3, OrdImp, Primeiro, QConsumo, Numps, TpInstals, cunis) ;
                             VALUES (TmpCompo.Nops, crSigPrCpo.Mats, crSigCdPro.DPros, crSigPrCpo.Qtds * TmpCompo.Qtde, ;
                                     .T., 3, loc_Primeiro, crSigPrCpo.QtsCons * TmpCompo.Qtde, TmpCompo.Numps, '', crSigCdPro.Cunis)
                loc_Primeiro = .F.
            ENDSCAN
        ENDSCAN

        SELECT TmpImp
        GO TOP
        SELECT Nops, CPros, SUM(Qtde) AS Qtde ;
          FROM TmpImp WHERE !EMPTY(cpros) ;
         GROUP BY 1, 2 ORDER BY Nops ;
          INTO CURSOR TmpCompo

        SELECT TmpCompo
        SCAN
            THIS.CursorQuery('SigCdPrf', 'crSigCdPrf', 'Produtos', ALLTRIM(TmpCompo.CPros), 'Ordems')
            SELECT crSigCdPrf
            SCAN
                IF EMPTY(Obs)
                    LOOP
                ENDIF
                THIS.CursorQuery('SigCdGcr', 'crSigCdGcr', 'Codigos', ALLTRIM(crSigCdPrf.Grupos))
                INSERT INTO TmpImp (Nops, DGrupos, Detalhe4, OrdImp, Obs, TpInstals) ;
                     VALUES (TmpCompo.Nops, crSigCdGcr.Descrs, .T., 4, NVL(crSigCdPrf.Obs, ''), '')
            ENDSCAN
        ENDSCAN

        SELECT TmpImp
        SET ORDER TO NopOrdem
        GO TOP
        LOCAL loc_NopsAnt3
        loc_NopsAnt3 = Nops
        SCAN
            IF Nops <> loc_NopsAnt3
                SKIP -1
                REPLACE Quebra WITH .T.
                SKIP +1
                loc_NopsAnt3 = Nops
            ENDIF
        ENDSCAN
        GO BOTTOM
        REPLACE Quebra WITH .T.
        GO TOP
        IF EOF()
            MsgAviso("Nenhuma Sequ" + CHR(234) + "ncia Foi Selecionada Para Impress" + CHR(227) + "o!!!", "")
        ELSE
            IF par_cSaida = 'V'
                REPORT FORM SigReGlL PREVIEW NOCONSOLE
            ELSE
                REPORT FORM SigReGlL TO PRINT PROMPT NOCONSOLE
            ENDIF
        ENDIF

        loc_lcApagar = SYS(2023) + '\F*.Jpg'
        DELETE FILE &loc_lcApagar.

        IF USED("TmpImp")
            USE IN TmpImp
        ENDIF
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * ProcTiras - Tira simples (variante legada, substituta: ProcTiraf)
    *--------------------------------------------------------------------------
    PROCEDURE ProcTiras(par_cSaida)
        LOCAL pSqi, pSqf
        LOCAL pTru, pIds
        LOCAL loc_Nop, loc_Pedido, loc_Seqi, loc_Seqf, loc_Seq, loc_cPedido
        LOCAL loc_Divid, loc_Geral, loc_ImpCmp, loc_llCera, loc_lcOperacao
        LOCAL loc_lcQuery, loc_nResult, loc_lcEdp, loc_llNumOpe
        LOCAL loc_Nops, loc_Primeiro, loc_ImpCodBar, loc_Peso, loc_Emp
        LOCAL loc_ncont, loc_ncont2, loc_lcSql, loc_lcApagar
        LOCAL loc_lcclass, loc_lcCodlin, loc_lcCodcor
        LOCAL loc_llProcs, loc_llObs, loc_llDp2

        loc_Nop      = THIS.this_nOrdem
        loc_Pedido   = (THIS.this_nRelPedido = 1)
        loc_Seqi     = THIS.this_nSeqIni
        loc_Seqf     = IIF(THIS.this_nSeqFim = 0, 9999, THIS.this_nSeqFim)
        loc_Divid    = (THIS.this_nDivididas = 1)
        loc_Geral    = (THIS.this_nImprimir = 1)
        loc_ImpCmp   = (THIS.this_nCompo = 1)
        loc_llCera   = (THIS.this_nCera = 1)
        loc_lcclass  = ALLTRIM(THIS.this_cClass)
        loc_lcCodlin = ALLTRIM(THIS.this_cLin)
        loc_lcCodcor = ALLTRIM(THIS.this_cCor)
        *-- Filtros da secao Etiquetas marcados em campos_faltantes.PNG (2026-07-01)
        loc_llProcs = (THIS.this_nProcesso = 1)
        loc_llObs   = (THIS.this_nComplemto = 1)
        loc_llDp2   = (THIS.this_nOptDescs = 2)

        CREATE CURSOR TmpImp (Ordem n(6), Seqs n(4), Nops n(10), CPros c(14), DPros c(40), CUnis c(3), Qtde n(10,3), ;
                              Peso n(9,2), Obs m, Pedido c(30), Datas d, ImpCodBar c(20), CMats c(14), DMats c(50), ;
                              QPedras n(12,3), QConsumo n(12,2), OrdImp n(1), Detalhe1 L, Detalhe2 L, Detalhe3 L, ;
                              Dividida L, Ultimo L, Primeiro L, Quebra L, CodCors c(4), CodTams c(4), DesCors c(30), ;
                              Notas c(06), Reffs c(40), ncompo n(3), empdopnums c(29), citens n(10), Ordimg c(17), TipoOps c(2), lDtGer L)
        INDEX ON STR(Nops, 10) + STR(OrdImp, 1) TAG NopOrdem
        INDEX ON Nops TAG Nops
        SET ORDER TO Nops

        IF THIS.this_nTpOrdem = 1
            loc_lcOperacao = crSigCdPam.DoppPads
        ELSE
            loc_lcOperacao = crSigCdPam.DoppServs
        ENDIF

        loc_llNumOpe = .F.
        THIS.CursorQuery('SigCdOpd', 'crTmpCdOpd', 'Dopps', ALLTRIM(loc_lcOperacao), 'Numeras')
        IF USED("crTmpCdOpd")
            SELECT crTmpCdOpd
            IF RECCOUNT() > 0
                loc_llNumOpe = (crTmpCdOpd.Numeras = 4)
            ENDIF
        ENDIF

        pSqi = INT(VAL(STR(loc_Nop, 6) + PADL(ALLTRIM(STR(loc_Seqi)), 4, '0')))
        pSqf = INT(VAL(STR(loc_Nop, 6) + PADL(ALLTRIM(STR(loc_Seqf)), 4, '0')))

        LOCAL loc_Compara3
        loc_Compara3 = "EmpDNps = '" + go_4c_Sistema.cCodEmpresa + ALLTRIM(loc_lcOperacao) + STR(loc_Nop, 10) + "'"
        IF loc_Divid AND loc_Nop = 0
            loc_Compara3 = "EmpDNps BETWEEN '" + go_4c_Sistema.cCodEmpresa + ALLTRIM(loc_lcOperacao) + STR(0, 10) + "'" + ;
                           " AND '" + go_4c_Sistema.cCodEmpresa + ALLTRIM(loc_lcOperacao) + "9999999999'"
        ENDIF
        loc_Nops = 0

        loc_lcQuery = "SELECT * FROM SigOpPic " + ;
                      "WHERE " + loc_Compara3 + " AND " + ;
                      IIF(loc_llNumOpe, "0=0 AND ", "Nops BETWEEN ?pSqi AND ?pSqf AND ") + ;
                      "NOT Qtds = 0 ORDER BY Nops"

        loc_nResult = SQLEXEC(gnConnHandle, loc_lcQuery, "TempOpi")
        IF loc_nResult < 1
            MsgErro("Favor Reinicializar o Processo!!!", "Falha na Conex" + CHR(227) + "o (TempOpi)")
            IF USED("TmpImp")
                USE IN TmpImp
            ENDIF
            RETURN .F.
        ENDIF

        loc_ncont = 1
        SELECT TempOpi
        SCAN
            loc_Seq = VAL(RIGHT(STR(TempOpi.Nops, 10), 4))
            loc_Emp = IIF(EMPTY(Empds), ALLTRIM(Emps), ALLTRIM(Empds))

            IF (!loc_Geral AND Imprs) OR (loc_Divid AND !Divs)
                LOOP
            ENDIF

            loc_lcEdp = ALLTRIM(Emps) + ALLTRIM(Dopps) + STR(Nops, 10)
            THIS.CursorQuery('SigPdMvf', 'TempMfas', 'EmpDNps', loc_lcEdp)
            THIS.CursorQuery('SigCdPro', 'crSigCdPro', 'CPros', ALLTRIM(TempMfas.CodPds))
            THIS.CursorQuery('SigCdOpd', 'crSigCdOpd', 'Dopps', ALLTRIM(TempOpi.Dopps))
            THIS.CursorQuery('SigCdCor', 'crSigCdCor', 'Cods',  ALLTRIM(TempOpi.CodCors))

            IF loc_llCera AND CrSigCdPro.CravCers <> 1
                LOOP
            ENDIF

            IF !EMPTY(loc_lcclass) AND ALLTRIM(loc_lcclass) <> ALLTRIM(crSigCdPro.Cclass)
                LOOP
            ENDIF

            IF !EMPTY(loc_lcCodlin) AND ALLTRIM(loc_lcCodlin) <> ALLTRIM(crSigCdPro.Colecoes)
                LOOP
            ENDIF

            IF !EMPTY(loc_lcCodcor) AND ALLTRIM(loc_lcCodcor) <> ALLTRIM(TempOpi.CodCors)
                LOOP
            ENDIF

            loc_cPedido = ALLTRIM(TempOpi.Emps) + ALLTRIM(TempOpi.Dopes) + ' ' + ALLTRIM(fGerMascara(TempOpi.Numes))
            loc_Peso    = ROUND(TempOpi.Qtds * TempOpi.Pesos, 2)

            IF loc_Nops <> Nops
                loc_ImpCodBar = fAltBar2de5(TRANSFORM(crSigCdOpd.NDopps, '@L 99') + TRANSFORM(TempOpi.Nops, '@L 9999999999'))
                loc_Nops = Nops
                SELECT TmpImp
                IF !EOF()
                    REPLACE Ultimo WITH .T.
                ENDIF
                INSERT INTO TmpImp (Nops, Detalhe2, OrdImp) VALUES (loc_Nops, .T., 2)
                loc_Primeiro = .T.
            ELSE
                loc_ImpCodBar = ' '
                loc_Primeiro  = .F.
            ENDIF

            THIS.CursorQuery('SigCdPro', 'LocalPro', 'CPros', ALLTRIM(TempOpi.Cpros))
            loc_nResult = SQLEXEC(gnConnHandle, ;
                "SELECT *, qtds AS QtsCons FROM SigSubMv WHERE empdopnums = ?TempOpi.empdopnums AND cpros = ?TempOpi.CPros AND citem2 = ?TempOpi.citens", ;
                "crSigPrCpo")
            IF RECCOUNT("crSigPrCpo") = 0
                THIS.CursorQuery('SigPrCpo', 'crSigPrCpo', 'CPros', ALLTRIM(TempOpi.CPros))
                loc_ncont2 = 1
            ELSE
                loc_ncont  = loc_ncont + 1
                loc_ncont2 = loc_ncont
            ENDIF

            INSERT INTO TmpImp (Ordem, Seqs, Cpros, Dpros, CUnis, Qtde, Obs, Pedido, ImpCodBar, Detalhe1, Nops, ;
                                Datas, Peso, Dividida, OrdImp, Primeiro, CodCors, CodTams, DesCors, Notas, Reffs, ;
                                ncompo, empdopnums, citens, TipoOps, lDtGer) ;
                     VALUES (loc_Nop, loc_Seq, TempMFas.CodPds, crSigCdPro.DPros, crSigCdPro.CUnis, TempOpi.Qtds, ;
                             NVL(TempOpi.Obss, ''), loc_cPedido, loc_ImpCodBar, .T., TempOpi.Nops, ;
                             NVL(TempOpi.Dataes, CTOD('')), loc_Peso, TempOpi.Divs, 1, loc_Primeiro, ;
                             TempOpi.CodCors, TempOpi.CodTams, crSigCdCor.Descs, TempOpi.Notas, CrSigCdPro.Reffs, ;
                             loc_ncont2, TempOpi.Empdopnums, TempOpi.Citens, ;
                             IIF(THIS.this_nTpOrdem = 1, 'OP', 'OS'), (THIS.this_lDatager = 1))

            IF par_cSaida = 'I'
                pTru = .T.
                pIds = TempOpi.cIdChaves
                loc_lcQuery = "UPDATE SigOpPic SET Imprs = ?pTru WHERE cIdChaves = ?pIds"
                loc_nResult = SQLEXEC(gnConnHandle, loc_lcQuery, "")
                IF loc_nResult < 1
                    MsgErro("Favor Reinicializar o Processo!!!", "Falha na Conex" + CHR(227) + "o (Update ProcTiras)")
                    IF USED("TmpImp")
                        USE IN TmpImp
                    ENDIF
                    RETURN .F.
                ENDIF
            ENDIF
        ENDSCAN

        SELECT TmpImp
        GO TOP
        SELECT Nops, CPros, SUM(Qtde) AS Qtde, empdopnums, citens, CodTams, CodCors ;
          FROM TmpImp WHERE !EMPTY(cpros) ;
         GROUP BY 1, 2, 4, 5, 6, 7 ORDER BY CPros, Nops, empdopnums, citens ;
          INTO CURSOR TmpCompo

        loc_ncont = 1
        SELECT TmpCompo
        SCAN
            loc_Primeiro = .T.
            THIS.CursorQuery('SigCdPro', 'LocalPro', 'CPros', ALLTRIM(TmpCompo.Cpros))
            loc_nResult = SQLEXEC(gnConnHandle, ;
                "SELECT *, qtds AS QtsCons FROM SigSubMv WHERE empdopnums = ?TmpCompo.empdopnums AND cpros = ?TmpCompo.CPros AND citem2 = ?TmpCompo.citens", ;
                "crSigPrCpo")
            IF RECCOUNT("crSigPrCpo") = 0
                THIS.CursorQuery('SigPrCpo', 'crSigPrCpo', 'CPros', ALLTRIM(TmpCompo.CPros))
                loc_ncont2 = 1
            ELSE
                loc_ncont  = loc_ncont + 1
                loc_ncont2 = loc_ncont
            ENDIF

            SELECT crSigPrCpo
            SCAN
                THIS.CursorQuery('SigCdPro', 'crSigCdPro', 'CPros', ALLTRIM(crSigPrCpo.Mats))
                THIS.CursorQuery('SigCdGrp', 'crSigCdGrp', 'CGrus', ALLTRIM(crSigCdPro.CGrus))

                IF (crSigCdGrp.CEstoqs # 1 AND CrSigCdGrp.ImpOps <> 3) OR ;
                   !INLIST(CrSigCdGrp.ImpOps, 1, 3) OR !loc_ImpCmp
                    LOOP
                ENDIF

                SELECT TmpImp
                GO TOP
                LOCATE FOR ALLTRIM(cpros) = ALLTRIM(TmpCompo.cpros) AND ALLTRIM(cmats) = ALLTRIM(crSigPrCpo.mats) AND ncompo = loc_ncont2 AND OrdImp = 3
                IF EOF()
                    INSERT INTO TmpImp (cpros, Nops, CMats, DMats, QPedras, Detalhe3, OrdImp, Primeiro, QConsumo, cunis, ncompo) ;
                                 VALUES (TmpCompo.Cpros, TmpCompo.Nops, crSigPrCpo.Mats, crSigCdPro.DPros, ;
                                         crSigPrCpo.Qtds * TmpCompo.Qtde, .T., 3, loc_Primeiro, ;
                                         crSigPrCpo.QtsCons * TmpCompo.Qtde, CrSigCdPro.Cunis, loc_ncont2)
                    loc_Primeiro = .F.
                ELSE
                    REPLACE QConsumo WITH QConsumo + (crSigPrCpo.QtsCons * TmpCompo.Qtde) IN TmpImp
                    REPLACE QPedras  WITH QPedras  + (crSigPrCpo.Qtds * TmpCompo.Qtde) IN TmpImp
                ENDIF
            ENDSCAN
        ENDSCAN

        SELECT TmpImp
        SET ORDER TO NopOrdem
        GO TOP
        LOCAL loc_NopsAnt4
        loc_NopsAnt4 = Nops
        SCAN
            IF Nops <> loc_NopsAnt4
                SKIP -1
                REPLACE Quebra WITH .T.
                SKIP +1
                loc_NopsAnt4 = Nops
            ENDIF
            REPLACE OrdImg WITH 'FBRANCOS' IN TmpImp
        ENDSCAN

        GO BOTTOM
        REPLACE Quebra WITH .T.
        GO TOP
        IF EOF()
            MsgAviso("Nenhuma Sequ" + CHR(234) + "ncia Foi Selecionada Para Impress" + CHR(227) + "o!!!", "")
        ELSE
            IF par_cSaida = 'V'
                REPORT FORM SigReGlu PREVIEW NOCONSOLE
            ELSE
                REPORT FORM SigReGlu TO PRINT PROMPT NOCONSOLE
            ENDIF
        ENDIF

        IF USED("TmpImp")
            USE IN TmpImp
        ENDIF
        RETURN .T.
    ENDPROC

ENDDEFINE

*==============================================================================
* SIGREDCTBO.PRG
* Business Object para Relatorio Documento de Corte (SigReDct / SigReDc3)
*
* Herda de: RelatorioBase
* Tipo: REPORT
* Uso: Impressao/Visualizacao de documentos de corte com etiquetas de codigo
*      de barras. Recebe parametros de identificacao do documento via
*      FormParaRelatorio(). Gera dois estilos de relatorio conforme opcao:
*        - SigReDct.frx : com totalizacao
*        - SigReDc3.frx : sem totalizacao (somente etiquetas)
*==============================================================================

DEFINE CLASS SigReDctBO AS RelatorioBase

    *-- Parametros de identificacao do documento (recebidos via FormParaRelatorio)
    this_cEmps          = ""    && Codigo da empresa (pEmp)
    this_cDopes         = ""    && Tipo de documento / operacao (pDop)
    this_nNumes         = 0     && Numero do documento (pNum)

    *-- Opcoes de impressao (mapeadas dos checkboxes do form)
    this_nImpTotal      = 0     && 1=Imprimir com totalizacao, 0=sem totalizacao
    this_nImpCodBarra   = 0     && 1=Imprimir somente cod. de barras, 0=normal

    *-- Cursor de saida do relatorio (populado por PrepararDados)
    this_cCursorDados   = "cursor_4c_Relatorio"

    *--------------------------------------------------------------------------
    * Init - Construtor
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        RETURN DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterMensagemErro - Retorna mensagem de erro do ultimo processamento
    *--------------------------------------------------------------------------
    PROCEDURE ObterMensagemErro()
        RETURN THIS.this_cMensagemErro
    ENDPROC

    *--------------------------------------------------------------------------
    * PrepararDados - Monta cursor_4c_Relatorio e cursor_4c_Cabecalho
    * Logica fiel ao PROCEDURE processamento do formulario original SIGREDCT
    *--------------------------------------------------------------------------
    PROCEDURE PrepararDados()
        LOCAL loc_lSucesso
        LOCAL loc_cEdn, loc_cEdn2, loc_cSql, loc_nResult
        LOCAL loc_nOp, loc_nOrdem, loc_nQtdB
        LOCAL loc_cImpCodBarItem, loc_cImpCodBarDoc
        LOCAL loc_cEmp, loc_cCab, loc_cSub

        loc_lSucesso = .F.

        TRY
            *-- Chaves compostas do documento (empresa + tipo + numero)
            loc_cEdn  = THIS.this_cEmps + THIS.this_cDopes + STR(THIS.this_nNumes, 10)
            loc_cEdn2 = THIS.this_cEmps + THIS.this_cDopes + STR(THIS.this_nNumes, 6)

            *-- Cursor principal do relatorio
            SET NULL ON
            CREATE CURSOR cursor_4c_Relatorio (;
                cBars n(14), Cpros c(14), Dpros c(40), Nops n(10), cmats c(14), dMats c(40),;
                qtd1s n(12,3), cUni1s c(3), Peso1s n(12,3), cUnip1s c(3),;
                qtd2s n(12,3), cUni2s c(3), Qtds n(6), Quebras n(10),;
                peso2s n(12,3), cunip2s c(3), PesoFs n(12,3), Ordem n(10),;
                cestos c(1), GrupoOs c(10), ContaOs c(10), Rclis c(40),;
                Qtdb n(6), ImpCodBar c(20))
            SET NULL OFF

            INDEX ON STR(Nops,10) + cMats TAG NopMat
            INDEX ON STR(Quebras,10) + STR(Nops,10) + STR(Ordem,10) + STR(Cbars,14) TAG Nops

            *-- SigCdNei: etiquetas agrupadas por NOP e material
            loc_cSql = "SELECT Nops, cmats, SUM(qtds) AS Qtds, SUM(Pesos) AS Pesos, SUM(Peso2s) AS Peso2s " +;
                       "FROM SigCdNei WHERE EmpDnPs = " + EscaparSQL(loc_cEdn) + " GROUP BY nops, cmats"
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSql, "cursor_4c_TmpNensi")
            IF loc_nResult < 0
                THIS.this_cMensagemErro = "Erro ao consultar SigCdNei"
                loc_lSucesso = .F.
            ENDIF
            SELECT cursor_4c_TmpNensi
            INDEX ON STR(Nops,10) + cmats TAG Nops

            *-- SigOpEtq: etiquetas da operacao
            loc_cSql = "SELECT Nops, cbars, Cpros, Qtds FROM SigOpEtq " +;
                       "WHERE EmpDopNums = " + EscaparSQL(loc_cEdn2)
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSql, "cursor_4c_TmpEti")
            IF loc_nResult < 0
                THIS.this_cMensagemErro = "Erro ao consultar SigOpEtq"
                loc_lSucesso = .F.
            ENDIF
            SELECT cursor_4c_TmpEti
            INDEX ON STR(Nops,10) + STR(Cbars,14) TAG Nops

            *-- Processar cada etiqueta (scan externo)
            SELECT cursor_4c_TmpEti
            SCAN
                loc_nOp    = cursor_4c_TmpEti.Nops
                loc_nOrdem = 0

                *-- Dados do produto da etiqueta atual
                loc_cSql = "SELECT Dpros, cUnis, cUniPs FROM SigCdPro " +;
                           "WHERE Cpros = '" + ALLTRIM(cursor_4c_TmpEti.Cpros) + "'"
                loc_nResult = SQLEXEC(gnConnHandle, loc_cSql, "cursor_4c_TmpProPrd")

                *-- Dados do cliente/pedido para este NOP
                loc_cSql = "SELECT a.Nops, b.GrupoOs, b.ContaOs, c.Rclis " +;
                           "FROM SigOpPic a, SigMvCab b, SigCdCli c " +;
                           "WHERE a.Nops = " + STR(loc_nOp) +;
                           " AND a.EmpDopNums = b.EmpDopNums AND b.ContaOs = c.Iclis"
                loc_nResult = SQLEXEC(gnConnHandle, loc_cSql, "cursor_4c_TmpCli")

                *-- Codigo de barras desta etiqueta
                loc_cImpCodBarItem = fAltBar2de5(TRANSFORM(cursor_4c_TmpEti.Cbars, "@L 99999999999999"))

                *-- Posicionar TmpNensi no NOP atual
                SELECT cursor_4c_TmpNensi
                SET ORDER TO Nops
                =SEEK(STR(loc_nOp, 10))

                *-- Composicao do produto
                loc_cSql = "SELECT * FROM SigPrCpo " +;
                           "WHERE Cpros = '" + ALLTRIM(cursor_4c_TmpEti.Cpros) + "' ORDER BY Mats"
                loc_nResult = SQLEXEC(gnConnHandle, loc_cSql, "cursor_4c_TmpCompo")

                loc_nQtdB = 0

                *-- Loop 1: processa todas as etiquetas do NOP atual (TmpEti x TmpNensi sincronizado)
                SELECT cursor_4c_TmpEti
                SCAN WHILE Nops = loc_nOp
                    loc_nQtdB  = loc_nQtdB + cursor_4c_TmpEti.Qtds
                    loc_nOrdem = loc_nOrdem + 1

                    INSERT INTO cursor_4c_Relatorio ;
                        (Nops, cbars, Cpros, Dpros, Ordem, Qtds, GrupoOs, ContaOs, Rclis, Quebras, QtdB, ImpCodBar) VALUES ;
                        (cursor_4c_TmpEti.Nops, cursor_4c_TmpEti.Cbars, cursor_4c_TmpEti.Cpros,;
                         cursor_4c_TmpProPrd.Dpros, loc_nOrdem, 1,;
                         cursor_4c_TmpCli.GrupoOs, cursor_4c_TmpCli.ContaOs, cursor_4c_TmpCli.Rclis,;
                         IIF(THIS.this_nImpTotal <> 1, cursor_4c_TmpEti.Nops, 0),;
                         cursor_4c_TmpEti.Qtds, loc_cImpCodBarItem)

                    SELECT cursor_4c_TmpNensi
                    IF Nops = loc_nOp
                        loc_cSql = "SELECT a.Dpros, a.cUnis, a.cUnips, b.cestos " +;
                                   "FROM SigCdPro a, SigCdUni b " +;
                                   "WHERE a.Cpros = '" + ALLTRIM(cursor_4c_TmpNensi.Cmats) + "'" +;
                                   " AND a.Cunis = b.Cunis"
                        loc_nResult = SQLEXEC(gnConnHandle, loc_cSql, "cursor_4c_TmpProMat")

                        REPLACE cmats   WITH cursor_4c_TmpNensi.Cmats,;
                                Dmats   WITH cursor_4c_TmpProMat.Dpros,;
                                qtd1s   WITH cursor_4c_TmpNensi.Qtds,;
                                cuni1s  WITH cursor_4c_TmpProMat.Cunis,;
                                cUnip1s WITH cursor_4c_TmpProMat.Cunips,;
                                Peso1s  WITH cursor_4c_TmpNensi.Peso2s,;
                                PesoFs  WITH cursor_4c_TmpNensi.Pesos,;
                                Cestos  WITH cursor_4c_TmpProMat.Cestos ;
                                IN cursor_4c_Relatorio

                        SELECT cursor_4c_TmpNensi
                        SKIP
                    ENDIF
                ENDSCAN
                SKIP -1

                *-- Loop 2: materiais adicionais do TmpNensi nao consumidos no loop 1
                SELECT cursor_4c_TmpNensi
                SCAN WHILE Nops = loc_nOp
                    loc_nOrdem = loc_nOrdem + 1

                    INSERT INTO cursor_4c_Relatorio ;
                        (Nops, cbars, Cpros, Dpros, Ordem, GrupoOs, ContaOs, Rclis, Quebras, ImpCodBar) VALUES ;
                        (cursor_4c_TmpEti.Nops, 0, cursor_4c_TmpEti.Cpros, cursor_4c_TmpProPrd.Dpros,;
                         loc_nOrdem, cursor_4c_TmpCli.GrupoOs, cursor_4c_TmpCli.ContaOs,;
                         cursor_4c_TmpCli.Rclis,;
                         IIF(THIS.this_nImpTotal <> 1, cursor_4c_TmpEti.Nops, 0), loc_cImpCodBarItem)

                    loc_cSql = "SELECT a.Dpros, a.cUnis, a.cUnips, b.Cestos " +;
                               "FROM SigCdPro a, SigCdUni b " +;
                               "WHERE a.Cpros = '" + ALLTRIM(cursor_4c_TmpNensi.Cmats) + "'" +;
                               " AND a.Cunis = b.Cunis"
                    loc_nResult = SQLEXEC(gnConnHandle, loc_cSql, "cursor_4c_TmpProMat")

                    REPLACE cmats   WITH cursor_4c_TmpNensi.Cmats,;
                            Dmats   WITH cursor_4c_TmpProMat.Dpros,;
                            qtd1s   WITH cursor_4c_TmpNensi.Qtds,;
                            cuni1s  WITH cursor_4c_TmpProMat.Cunis,;
                            cUnip1s WITH cursor_4c_TmpProMat.Cunips,;
                            Peso1s  WITH cursor_4c_TmpNensi.Peso2s,;
                            cestos  WITH cursor_4c_TmpProMat.Cestos,;
                            PesoFs  WITH cursor_4c_TmpNensi.Pesos ;
                            IN cursor_4c_Relatorio

                ENDSCAN

                *-- Loop 3: composicao do produto (itens da grade de composicao)
                SELECT cursor_4c_TmpCompo
                SCAN
                    SELECT cursor_4c_Relatorio
                    SET ORDER TO NopMat
                    IF NOT SEEK(STR(loc_nOp, 10) + cursor_4c_TmpCompo.mats)
                        loc_cSql = "SELECT Dpros, cUnis, cUnips FROM SigCdPro " +;
                                   "WHERE Cpros = '" + ALLTRIM(cursor_4c_TmpCompo.mats) + "'"
                        loc_nResult = SQLEXEC(gnConnHandle, loc_cSql, "cursor_4c_TmpProMat")
                        loc_nOrdem = loc_nOrdem + 1

                        INSERT INTO cursor_4c_Relatorio ;
                            (Nops, cbars, Cpros, Dpros, Ordem, CMats, dMats, Grupoos, ContaOs, Rclis, Quebras) VALUES ;
                            (cursor_4c_TmpEti.Nops, 0, cursor_4c_TmpEti.Cpros, cursor_4c_TmpProPrd.Dpros,;
                             loc_nOrdem, cursor_4c_TmpCompo.Mats, cursor_4c_TmpProMat.Dpros,;
                             cursor_4c_TmpCli.GrupoOs, cursor_4c_TmpCli.ContaOs, cursor_4c_TmpCli.Rclis,;
                             IIF(THIS.this_nImpTotal <> 1, cursor_4c_TmpEti.Nops, 0))
                    ENDIF

                    SELECT cursor_4c_Relatorio
                    SET ORDER TO NopMat
                    =SEEK(STR(loc_nOp, 10) + cursor_4c_TmpCompo.mats)
                    REPLACE qtd2s   WITH cursor_4c_TmpCompo.Qtds * loc_nQtdB,;
                            cuni2s  WITH cursor_4c_TmpCompo.UniCompos,;
                            cUnip2s WITH cursor_4c_TmpCompo.Cunips,;
                            Peso2s  WITH cursor_4c_TmpCompo.Pesos * loc_nQtdB ;
                            IN cursor_4c_Relatorio

                    SELECT cursor_4c_TmpCompo
                ENDSCAN
            ENDSCAN

            *-- Linha de totalizacao (quando ImpTotal = 1)
            IF THIS.this_nImpTotal = 1
                SELECT 9999999999 AS Nops, SUM(Qtds) AS Qtds, SUM(QtdB) AS Qtdb, SUM(Pesofs) AS PesoFs ;
                    FROM cursor_4c_Relatorio ;
                    INTO CURSOR cursor_4c_Selecao GROUP BY 1

                SELECT cursor_4c_Relatorio
                APPEND BLANK
                REPLACE Nops   WITH cursor_4c_Selecao.Nops,;
                        Qtds   WITH cursor_4c_Selecao.Qtds,;
                        QtdB   WITH cursor_4c_Selecao.Qtdb,;
                        PesoFs WITH cursor_4c_Selecao.Pesofs ;
                        IN cursor_4c_Relatorio
            ENDIF

            *-- Codigo de barras do documento (numero da operacao + numero do doc)
            loc_cSql = "SELECT Ndopps FROM SigCdOpd WHERE Dopps = " + EscaparSQL(THIS.this_cDopes)
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSql, "cursor_4c_TmpOpp")
            IF loc_nResult > 0 AND !EOF("cursor_4c_TmpOpp")
                loc_cImpCodBarDoc = fAltBar2de5(;
                    TRANSFORM(cursor_4c_TmpOpp.NDopps, "@L 99") +;
                    TRANSFORM(THIS.this_nNumes, "@L 9999999999"))
            ELSE
                loc_cImpCodBarDoc = ""
            ENDIF

            *-- Nome da empresa
            loc_cEmp = go_4c_Sistema.cCodEmpresa + " - " + ALLTRIM(go_4c_Sistema.cEmpresa)

            loc_cCab = ALLTRIM(THIS.this_cDopes) + " - " + STR(THIS.this_nNumes, 10)
            loc_cSub = ""

            *-- Cursor de cabecalho para o relatorio
            SET NULL ON
            CREATE CURSOR cursor_4c_Cabecalho (;
                Titulo c(100), SubTitulo m, NomeEmpresa c(100), ImpCodBar c(20))
            SET NULL OFF
            INSERT INTO cursor_4c_Cabecalho (Titulo, SubTitulo, NomeEmpresa, ImpCodBar) ;
                VALUES (loc_cCab, loc_cSub, loc_cEmp, loc_cImpCodBarDoc)

            *-- Posicionar cursor principal para o relatorio
            SELECT cursor_4c_Relatorio
            SET ORDER TO Nops
            GO TOP

            loc_lSucesso = .T.

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
            THIS.this_cMensagemErro = loc_oErro.Message
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Visualizar - Preview do relatorio na tela
    *--------------------------------------------------------------------------
    PROCEDURE Visualizar()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            IF !THIS.PrepararDados()
                loc_lSucesso = .F.
            ENDIF
            IF THIS.this_nImpTotal = 1
                REPORT FORM (gc_4c_CaminhoReports + "SigReDct") PREVIEW NOCONSOLE
            ELSE
                REPORT FORM (gc_4c_CaminhoReports + "SigReDc3") PREVIEW NOCONSOLE
            ENDIF
            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
            THIS.this_cMensagemErro = loc_oErro.Message
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Imprimir - Impressao do relatorio na impressora
    *--------------------------------------------------------------------------
    PROCEDURE Imprimir()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            IF !THIS.PrepararDados()
                loc_lSucesso = .F.
            ENDIF
            IF THIS.this_nImpTotal = 1
                REPORT FORM (gc_4c_CaminhoReports + "SigReDct") TO PRINTER PROMPT NOCONSOLE
            ELSE
                REPORT FORM (gc_4c_CaminhoReports + "SigReDc3") TO PRINTER PROMPT NOCONSOLE
            ENDIF
            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
            THIS.this_cMensagemErro = loc_oErro.Message
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * PrepararEmail - Posiciona cursor para envio por email
    *--------------------------------------------------------------------------
    PROCEDURE PrepararEmail()
        IF USED("cursor_4c_Relatorio")
            SELECT cursor_4c_Relatorio
            GO TOP
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Carrega parametros do documento a partir de um cursor
    * Para relatorios, o cursor pode conter as chaves do documento
    * (Emps, Dopes, Numes) e as opcoes de impressao (ImpTotal, ImpCodBarra).
    * Util quando o relatorio eh invocado a partir de outro form que ja tem
    * o registro selecionado.
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        TRY
            IF EMPTY(par_cAliasCursor) OR !USED(par_cAliasCursor)
                THIS.this_cMensagemErro = "Cursor de origem inv" + CHR(225) + "lido"
                EXIT
            ENDIF

            SELECT (par_cAliasCursor)

            *-- Chaves do documento (obrigatorias)
            THIS.this_cEmps  = TratarNulo(Emps,  "C")
            THIS.this_cDopes = TratarNulo(Dopes, "C")
            THIS.this_nNumes = TratarNulo(Numes, "N")

            *-- Opcoes de impressao (opcionais - se nao existirem no cursor,
            *-- o CATCH abaixo mantem os valores atuais)
            TRY
                THIS.this_nImpTotal    = TratarNulo(ImpTotal,    "N")
                THIS.this_nImpCodBarra = TratarNulo(ImpCodBarra, "N")
            CATCH
                *-- Cursor nao possui colunas de opcoes - usa valores atuais
            ENDTRY

            loc_lSucesso = .T.

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = "Erro ao carregar par" + CHR(226) + ;
                "metros do cursor: " + loc_oErro.Message
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Retorna chave do documento (Emps + Dopes + Numes)
    * Usada para identificacao em logs e mensagens.
    *--------------------------------------------------------------------------
    PROCEDURE ObterChavePrimaria()
        RETURN ALLTRIM(THIS.this_cEmps) + "|" + ;
               ALLTRIM(THIS.this_cDopes) + "|" + ;
               ALLTRIM(STR(THIS.this_nNumes, 10))
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir - Nao aplicavel a relatorios
    * Relatorios sao operacoes read-only; nao gravam registros no banco.
    * Implementado para satisfazer a interface BO esperada pelo pipeline.
    *--------------------------------------------------------------------------
    PROCEDURE Inserir()
        THIS.this_cMensagemErro = "Opera" + CHR(231) + CHR(227) + ;
            "o n" + CHR(227) + "o aplic" + CHR(225) + "vel: " + ;
            "relat" + CHR(243) + "rio de documento de corte n" + CHR(227) + ;
            "o realiza inclus" + CHR(227) + "o de registros."
        RETURN .F.
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - Nao aplicavel a relatorios
    * Relatorios sao operacoes read-only; nao gravam registros no banco.
    * Implementado para satisfazer a interface BO esperada pelo pipeline.
    *--------------------------------------------------------------------------
    PROCEDURE Atualizar()
        THIS.this_cMensagemErro = "Opera" + CHR(231) + CHR(227) + ;
            "o n" + CHR(227) + "o aplic" + CHR(225) + "vel: " + ;
            "relat" + CHR(243) + "rio de documento de corte n" + CHR(227) + ;
            "o realiza atualiza" + CHR(231) + CHR(227) + "o de registros."
        RETURN .F.
    ENDPROC

ENDDEFINE

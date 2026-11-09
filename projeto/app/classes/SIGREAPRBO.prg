*==============================================================================
* SIGREAPRBO.PRG
* Business Object para Relatorio de Alteracoes de Produtos
*
* Herda de RelatorioBase
* Formulario original: SIGREAPR.SCX (frmrelatorio)
* Regra de negocio   : classe cnSigReApr (sigreapr.prg legado)
* Relatorio          : SigReApr.frx (legado, copiado sem alteracao)
*
* Erro316: a 1a migracao nao tinha o sigreapr.prg (cnSigReApr) e INVENTOU a
* regra (SigCdPro x bkp_sigcdpro, FRX inexistente RelSIGREAPR.frx). Reescrito
* transcrevendo a cnSigReApr de C:\4install\FortyusMC\Fortyus\sigreapr.prg:
*   - historico de alteracoes = SigCdPrc (DataAlts >= Data Inicial)
*     UNION ALL situacao atual = SigCdPro (DataAlts = agora)
*   - PctVendas/PctCustos = variacao em relacao a linha ANTERIOR do mesmo
*     produto (1a linha do produto = 0)
*   - Diferenca minima: corta pelo SINAL (positivo = acima, negativo = abaixo)
*==============================================================================

DEFINE CLASS SIGREAPRBO AS RelatorioBase

    *-- Filtros do relatorio
    this_dDtInicial     = {}    && Data Inicial (obrigatorio)
    this_cGrupo         = ""    && Codigo do Grupo (SigCdGrp.CGrus, max 3)
    this_cDGrupo        = ""    && Descricao do Grupo (SigCdGrp.DGrus, max 20)
    this_cCPros         = ""    && Codigo do Produto (SigCdPro.CPros, max 14)
    this_cDPros         = ""    && Descricao do Produto (SigCdPro.DPros, max 40)
    this_cLin           = ""    && Codigo da Linha (SigCdLin.Linhas, max 10)
    this_cDLin          = ""    && Descricao da Linha (SigCdLin.Descs, max 40)
    this_cFornecedor    = ""    && Codigo do Fornecedor (max 10)
    this_cDFornecedor   = ""    && Descricao do Fornecedor (max 40)
    this_nMinVendas     = 0     && Diferenca minima vendas em %
    this_nMinCustos     = 0     && Diferenca minima custos em %

    *-- Controle interno do relatorio
    this_cArquivoFRX    = ""    && Caminho completo do FRX
    this_cTitulo        = ""    && Titulo exibido no relatorio
    *-- Nomes do FRX legado: crImpressao (detalhe) e crCabecalho (cabecalho)
    this_cCursorDados   = "crImpressao"

    *--------------------------------------------------------------------------
    * Init - Configura caminhos e valores iniciais dos filtros
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.
        TRY
            THIS.this_cArquivoFRX = gc_4c_CaminhoReports + "SigReApr.frx"
            THIS.this_cTitulo     = "Relat" + CHR(243) + "rio de Altera" + CHR(231) + CHR(245) + "es de Produtos"
            THIS.this_dDtInicial  = DATE()
            THIS.this_nMinVendas  = 0
            THIS.this_nMinCustos  = 0
            loc_lSucesso = DODEFAULT()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * PrepararDados - cnSigReApr.Processamento (CriarCabecalho + CriarCursores
    *                 + SelecDados)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE PrepararDados()
        LOCAL loc_lResultado, loc_oErro
        loc_lResultado = .F.
        TRY
            THIS.this_cMensagemErro = ""
            IF EMPTY(THIS.this_dDtInicial)
                *-- cnSigReApr.ValidaBotoes
                THIS.this_cMensagemErro = "Data Inicial Inv" + CHR(225) + "lida!!!"
            ELSE
                THIS.CriarCabecalho()
                IF THIS.SelecionarDados()
                    SELECT crImpressao
                    GO TOP
                    IF EOF()
                        THIS.this_cMensagemErro = "Nenhum registro encontrado com os filtros informados."
                    ELSE
                        loc_lResultado = .T.
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            WAIT CLEAR
            THIS.this_cMensagemErro = "Erro: " + loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * CriarCabecalho - cnSigReApr.CriarCabecalho
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE CriarCabecalho()
        LOCAL loc_cTit, loc_cSub, loc_cDep, loc_cEmp

        loc_cTit = THIS.this_cTitulo
        loc_cSub = "Data Inicial : " + DTOC(THIS.this_dDtInicial) + " " + ;
                   IIF(EMPTY(THIS.this_cGrupo),      "", " - Grupo : "      + ALLTRIM(THIS.this_cGrupo)) + ;
                   IIF(EMPTY(THIS.this_cCPros),      "", " - Produto : "    + ALLTRIM(THIS.this_cCPros)) + ;
                   IIF(EMPTY(THIS.this_cLin),        "", " - Linha : "      + ALLTRIM(THIS.this_cLin)) + ;
                   IIF(EMPTY(THIS.this_cFornecedor), "", " - Fornecedor : " + ALLTRIM(THIS.this_cFornecedor)) + ;
                   IIF(EMPTY(THIS.this_nMinVendas),  "", " - Venda : " + ALLTRIM(STR(THIS.this_nMinVendas, 6, 2)) + "%") + ;
                   IIF(EMPTY(THIS.this_nMinCustos),  "", " - Custo : " + ALLTRIM(STR(THIS.this_nMinCustos, 6, 2)) + "%")

        loc_cEmp = go_4c_Sistema.cCodEmpresa
        loc_cDep = ""
        IF SQLEXEC(gnConnHandle, "SELECT Razas FROM SigCdEmp WHERE Cemps = " + EscaparSQL(loc_cEmp), ;
                   "cursor_4c_AprEmp") > 0
            IF !EOF("cursor_4c_AprEmp")
                loc_cDep = loc_cEmp + " - " + ALLTRIM(cursor_4c_AprEmp.Razas)
            ENDIF
        ENDIF
        IF USED("cursor_4c_AprEmp")
            USE IN cursor_4c_AprEmp
        ENDIF

        IF USED("crCabecalho")
            USE IN crCabecalho
        ENDIF
        CREATE CURSOR crCabecalho (Titulo C(200), SubTit C(200), Empresa C(80), ;
                                   MoeCusFs M(4), CustoFs M(4), CustoPends M(4))
        INSERT INTO crCabecalho (Titulo, SubTit, Empresa) VALUES (loc_cTit, loc_cSub, loc_cDep)
        GO TOP IN crCabecalho
    ENDPROC

    *--------------------------------------------------------------------------
    * SelecionarDados - cnSigReApr.CriarCursores + SelecDados
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE SelecionarDados()
        LOCAL loc_lOk, loc_cSQL, loc_cFiltroA, loc_cFiltroB, loc_tAgora, loc_cAgora, loc_cHr
        LOCAL loc_cPro, loc_nPvs, loc_nPcs, loc_nCotV, loc_nCotC, loc_nRegs, loc_nAtual
        loc_lOk = .F.

        *-- Cursor de trabalho com a estrutura do crImpressao legado
        IF USED("cursor_4c_AprImp")
            USE IN cursor_4c_AprImp
        ENDIF
        CREATE CURSOR cursor_4c_AprImp (CPros C(14), DPros C(40), Reffs C(40), CGrus C(3), ;
                                        Linhas C(10), IFors C(10), DataAlts D(8), HoraAlts C(8), ;
                                        UsuaAlts C(10), CustoFs N(12,2), MoeCusFs C(3), ;
                                        PVens N(12,2), Moevs C(3), CfTios C(2), PctCustos N(12,2), ;
                                        PctVendas N(12,2), Margems N(10,6), MarkupR N(10,2), DtIncs D(8))

        *-- Linha "atual" (SigCdPro) entra com a data/hora do processamento
        loc_tAgora = DATETIME()
        loc_cAgora = TTOC(loc_tAgora, 1)                       && yyyymmddhhmmss
        loc_cHr    = SUBSTR(loc_cAgora, 9, 2) + ":" + SUBSTR(loc_cAgora, 11, 2) + ":" + SUBSTR(loc_cAgora, 13, 2)

        loc_cFiltroA = THIS.MontarFiltro("a")
        loc_cFiltroB = THIS.MontarFiltro("b")

        loc_cSQL = "SELECT a.CPros, a.DPros, a.Reffs, a.CGrus, a.Linhas, a.IFors, a.DataAlts, a.HoraAlts," + ;
                   " a.UsuaAlts, a.CustoFs, a.MoeCusFs, a.PVens, a.Moevs, a.CfTios, a.Margems, a.DtIncs" + ;
                   " FROM SigCdPrc a" + ;
                   " WHERE a.DataAlts >= " + FormatarDataSQL(THIS.this_dDtInicial) + loc_cFiltroA + ;
                   " UNION ALL" + ;
                   " SELECT b.CPros, b.DPros, b.Reffs, b.CGrus, b.Linhas, b.IFors," + ;
                   " CAST('" + LEFT(loc_cAgora, 8) + " " + loc_cHr + "' AS datetime) AS DataAlts," + ;
                   " '" + loc_cHr + "' AS HoraAlts, SPACE(10) AS UsuaAlts, b.CustoFs, b.MoeCusFs," + ;
                   " b.PVens, b.Moevs, b.CfTios, b.Margems, b.DtIncs" + ;
                   " FROM SigCdPro b" + ;
                   " WHERE 0 = 0" + loc_cFiltroB

        IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_AprAlt") < 1
            THIS.this_cMensagemErro = "Favor Reinicializar o Processo!!!" + CHR(13) + ;
                                      "Falha na Conex" + CHR(227) + "o (SelecDados)"
            RETURN .F.
        ENDIF

        SELECT cursor_4c_AprAlt
        INDEX ON CPros + DTOS(DataAlts) + HoraAlts TAG Ordem
        loc_nRegs  = RECCOUNT("cursor_4c_AprAlt")
        loc_nAtual = 0
        loc_cPro   = REPLICATE(CHR(254), 10)
        loc_nPvs   = 0
        loc_nPcs   = 0

        GO TOP
        SCAN
            loc_nAtual = loc_nAtual + 1
            WAIT WINDOW "Processando Produtos... " + ALLTRIM(cursor_4c_AprAlt.CPros) + ;
                        " (" + TRANSFORM(loc_nAtual) + "/" + TRANSFORM(loc_nRegs) + ")" NOWAIT

            SCATTER MEMVAR
            m.DataAlts = ConverterParaData(NVL(m.DataAlts, {}))
            m.DtIncs   = ConverterParaData(NVL(m.DtIncs, {}))

            *-- Cotacao consulta o banco (muda a area corrente): calcular antes do INSERT
            loc_nCotV = fBuscarCotacao(m.Moevs, DATE())
            loc_nCotC = fBuscarCotacao(m.MoeCusFs, DATE())
            m.MarkupR = (m.PVens * loc_nCotV) / (IIF(m.CustoFs = 0, 1, m.CustoFs) * loc_nCotC)
            INSERT INTO cursor_4c_AprImp FROM MEMVAR

            *-- Variacao em relacao a linha ANTERIOR do mesmo produto
            IF (loc_cPro <> cursor_4c_AprAlt.CPros)
                loc_cPro = cursor_4c_AprAlt.CPros
                loc_nPvs = cursor_4c_AprAlt.PVens
                loc_nPcs = cursor_4c_AprAlt.CustoFs
            ENDIF

            REPLACE PctVendas WITH IIF(EMPTY(loc_nPvs), 0, ((cursor_4c_AprAlt.PVens   / loc_nPvs) - 1) * 100), ;
                    PctCustos WITH IIF(EMPTY(loc_nPcs), 0, ((cursor_4c_AprAlt.CustoFs / loc_nPcs) - 1) * 100) ;
                    IN cursor_4c_AprImp

            loc_nPvs = cursor_4c_AprAlt.PVens
            loc_nPcs = cursor_4c_AprAlt.CustoFs
            SELECT cursor_4c_AprAlt
        ENDSCAN
        WAIT CLEAR

        *-- Diferenca minima (transcrito: positivo corta abaixo, negativo corta acima)
        IF (THIS.this_nMinCustos > 0)
            DELETE FROM cursor_4c_AprImp WHERE PctCustos < THIS.this_nMinCustos
        ENDIF
        IF (THIS.this_nMinCustos < 0)
            DELETE FROM cursor_4c_AprImp WHERE PctCustos > THIS.this_nMinCustos
        ENDIF
        IF (THIS.this_nMinVendas > 0)
            DELETE FROM cursor_4c_AprImp WHERE PctVendas < THIS.this_nMinVendas
        ENDIF
        IF (THIS.this_nMinVendas < 0)
            DELETE FROM cursor_4c_AprImp WHERE PctVendas > THIS.this_nMinVendas
        ENDIF

        *-- crImpressao so com as linhas NAO apagadas: o form usa DataSession = 2
        *-- (SET DELETED OFF) e o REPORT FORM imprimiria as linhas excluidas.
        *-- ORDER BY = o "Index On CPros + Dtos(DataAlts) + HoraAlts" do legado.
        IF USED("crImpressao")
            USE IN crImpressao
        ENDIF
        SELECT * FROM cursor_4c_AprImp ;
            WHERE !DELETED() ;
            ORDER BY CPros, DataAlts, HoraAlts ;
            INTO CURSOR crImpressao READWRITE

        USE IN cursor_4c_AprImp
        USE IN cursor_4c_AprAlt
        loc_lOk = .T.
        RETURN loc_lOk
    ENDPROC

    *--------------------------------------------------------------------------
    * MontarFiltro - filtros opcionais do SelecDados legado, por alias
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE MontarFiltro(par_cAlias)
        LOCAL loc_cF
        loc_cF = ""
        IF !EMPTY(THIS.this_cCPros)
            loc_cF = loc_cF + " AND " + par_cAlias + ".CPros = " + EscaparSQL(ALLTRIM(THIS.this_cCPros))
        ENDIF
        IF !EMPTY(THIS.this_cGrupo)
            loc_cF = loc_cF + " AND " + par_cAlias + ".CGrus = " + EscaparSQL(ALLTRIM(THIS.this_cGrupo))
        ENDIF
        IF !EMPTY(THIS.this_cLin)
            loc_cF = loc_cF + " AND " + par_cAlias + ".Linhas = " + EscaparSQL(ALLTRIM(THIS.this_cLin))
        ENDIF
        IF !EMPTY(THIS.this_cFornecedor)
            loc_cF = loc_cF + " AND " + par_cAlias + ".IFors = " + EscaparSQL(ALLTRIM(THIS.this_cFornecedor))
        ENDIF
        RETURN loc_cF
    ENDPROC

    *--------------------------------------------------------------------------
    * ExecutarRelatorio - REPORT FORM SigReApr no modo pedido
    *   par_cModo: "PREVIEW" | "PRINTER_PROMPT" | "PRINTER"
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ExecutarRelatorio(par_cModo)
        LOCAL loc_nBehaviorOrig

        IF !FILE(THIS.this_cArquivoFRX)
            THIS.this_cMensagemErro = "Arquivo de relat" + CHR(243) + "rio n" + CHR(227) + ;
                                      "o encontrado:" + CHR(13) + THIS.this_cArquivoFRX
            RETURN .F.
        ENDIF

        *-- FRX legado (VFP6/7/8) desenhado no modo 80 (Erro102)
        loc_nBehaviorOrig = SET("REPORTBEHAVIOR")
        SET REPORTBEHAVIOR 80
        SELECT crImpressao
        GO TOP

        DO CASE
            CASE par_cModo == "PREVIEW"
                REPORT FORM (THIS.this_cArquivoFRX) PREVIEW NOCONSOLE
            CASE par_cModo == "PRINTER_PROMPT"
                REPORT FORM (THIS.this_cArquivoFRX) TO PRINTER PROMPT NOCONSOLE
            CASE par_cModo == "PRINTER"
                REPORT FORM (THIS.this_cArquivoFRX) TO PRINTER NOCONSOLE
        ENDCASE

        SET REPORTBEHAVIOR (loc_nBehaviorOrig)

        IF par_cModo == "PREVIEW"
            *-- Restaurar menu apos PREVIEW (Erro63)
            TRY
                SET SYSMENU TO DEFAULT
                RELEASE POPUP popArquivo, popCadastros, popMovimentos, popRelatorios, popFerramentas, popAjuda
                CriarMenuPrincipal()
            CATCH
                *-- CriarMenuPrincipal fora do escopo (teste automatizado) - silencioso
            ENDTRY
        ENDIF
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * Imprimir - legado "impressao": Report Form SigReApr To Print Prompt NoConsole
    *--------------------------------------------------------------------------
    PROCEDURE Imprimir()
        LOCAL loc_lResultado, loc_oErro
        loc_lResultado = .F.
        TRY
            IF THIS.PrepararDados()
                IF THIS.ExecutarRelatorio("PRINTER_PROMPT")
                    THIS.RegistrarAuditoria("IMPRIMIR")
                    loc_lResultado = .T.
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = "Erro ao imprimir: " + loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * Visualizar - legado "visualizacao": Report Form SigReApr Preview NoConsole
    *--------------------------------------------------------------------------
    PROCEDURE Visualizar()
        LOCAL loc_lResultado, loc_oErro
        loc_lResultado = .F.
        TRY
            IF THIS.PrepararDados()
                IF THIS.ExecutarRelatorio("PREVIEW")
                    THIS.RegistrarAuditoria("VISUALIZAR")
                    loc_lResultado = .T.
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = "Erro ao visualizar: " + loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * ExportarExcel - botao 3 ("Arquivos Email"). Legado "documento":
    *   Report Form SigReApr To Printer
    *--------------------------------------------------------------------------
    PROCEDURE ExportarExcel()
        LOCAL loc_lResultado, loc_oErro
        loc_lResultado = .F.
        TRY
            IF THIS.PrepararDados()
                IF THIS.ExecutarRelatorio("PRINTER")
                    THIS.RegistrarAuditoria("DOCUMENTO")
                    loc_lResultado = .T.
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = "Erro ao gerar documento: " + loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * GerarExcel - mesmo comportamento do botao 3 (mantido por contrato)
    *--------------------------------------------------------------------------
    PROCEDURE GerarExcel()
        RETURN THIS.ExportarExcel()
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Retorna chave de auditoria da execucao do relatorio
    *--------------------------------------------------------------------------
    PROCEDURE ObterChavePrimaria()
        LOCAL loc_cChave, loc_cEmpresa

        loc_cEmpresa = IIF(TYPE("go_4c_Sistema.cCodEmpresa") = "C", ;
                           ALLTRIM(go_4c_Sistema.cCodEmpresa), "TODAS")

        loc_cChave = loc_cEmpresa + "/SIGREAPR/" + DTOC(THIS.this_dDtInicial)

        IF !EMPTY(ALLTRIM(THIS.this_cGrupo))
            loc_cChave = loc_cChave + "/G:" + ALLTRIM(THIS.this_cGrupo)
        ENDIF
        IF !EMPTY(ALLTRIM(THIS.this_cCPros))
            loc_cChave = loc_cChave + "/P:" + ALLTRIM(THIS.this_cCPros)
        ENDIF
        IF !EMPTY(ALLTRIM(THIS.this_cLin))
            loc_cChave = loc_cChave + "/L:" + ALLTRIM(THIS.this_cLin)
        ENDIF
        IF !EMPTY(ALLTRIM(THIS.this_cFornecedor))
            loc_cChave = loc_cChave + "/F:" + ALLTRIM(THIS.this_cFornecedor)
        ENDIF

        loc_cChave = loc_cChave + ;
                     "/MV:" + ALLTRIM(STR(THIS.this_nMinVendas, 6, 2)) + ;
                     "/MC:" + ALLTRIM(STR(THIS.this_nMinCustos, 6, 2))

        RETURN loc_cChave
    ENDPROC

    *--------------------------------------------------------------------------
    * RegistrarAuditoria - Registra execucao do relatorio na tabela LogAuditoria
    *--------------------------------------------------------------------------
    PROCEDURE RegistrarAuditoria(par_cOperacao)
        LOCAL loc_cSQL, loc_cChave, loc_cUsuario, loc_lSucesso, loc_oErro
        loc_lSucesso = .F.
        TRY
            loc_cChave   = THIS.ObterChavePrimaria()
            loc_cUsuario = IIF(TYPE("gc_4c_UsuarioLogado") = "C", ;
                               gc_4c_UsuarioLogado, "SISTEMA")

            loc_cSQL = "INSERT INTO LogAuditoria " + ;
                       "(Tabela, Operacao, ChaveRegistro, Usuario, DataHora) " + ;
                       "VALUES (" + ;
                       EscaparSQL("SIGREAPR") + ", " + ;
                       EscaparSQL(par_cOperacao) + ", " + ;
                       EscaparSQL(loc_cChave) + ", " + ;
                       EscaparSQL(loc_cUsuario) + ", GETDATE())"

            SQLEXEC(gnConnHandle, loc_cSQL)
            loc_lSucesso = .T.
        CATCH TO loc_oErro
            *-- Falha em audit nao deve impedir geracao do relatorio
            THIS.this_cMensagemErro = "Aviso: falha ao registrar auditoria - " + ;
                                       loc_oErro.Message
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir / Atualizar / CarregarDoCursor - nao aplicaveis a BO de relatorio
    *--------------------------------------------------------------------------
    PROCEDURE Inserir()
        THIS.this_cMensagemErro = "Opera" + CHR(231) + CHR(227) + "o n" + CHR(227) + ;
            "o suportada: BO de relat" + CHR(243) + "rio n" + CHR(227) + ;
            "o insere registros. Use Imprimir()/Visualizar()."
        RETURN .F.
    ENDPROC

    PROCEDURE Atualizar()
        THIS.this_cMensagemErro = "Opera" + CHR(231) + CHR(227) + "o n" + CHR(227) + ;
            "o suportada: BO de relat" + CHR(243) + "rio n" + CHR(227) + ;
            "o atualiza registros. Use Imprimir()/Visualizar()."
        RETURN .F.
    ENDPROC

    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        THIS.this_cMensagemErro = "Opera" + CHR(231) + CHR(227) + "o n" + CHR(227) + ;
            "o suportada: BO de relat" + CHR(243) + "rio processa o per" + ;
            CHR(237) + "odo inteiro em PrepararDados()."
        RETURN .F.
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterMensagemErro - Retorna mensagem de erro da ultima operacao
    *--------------------------------------------------------------------------
    PROCEDURE ObterMensagemErro()
        RETURN THIS.this_cMensagemErro
    ENDPROC

    *--------------------------------------------------------------------------
    * Destroy - Libera cursores ao destruir objeto
    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
        IF USED("crImpressao")
            USE IN crImpressao
        ENDIF
        IF USED("crCabecalho")
            USE IN crCabecalho
        ENDIF
        DODEFAULT()
    ENDPROC

ENDDEFINE

*==============================================================================
* SIGREBCTBO.PRG
* BO do Relatorio Balancete de Conta Corrente (SIGREBCT)
* Herda de RelatorioBase
*==============================================================================

DEFINE CLASS sigrebctBO AS RelatorioBase

    *-- Filtros de periodo
    this_dDtInicial   = {}
    this_dDtSaldo     = {}

    *-- Filtros de moeda
    this_cCdMoeda     = ""
    this_cDsMoeda     = ""

    *-- Filtros de empresa
    this_cCdEmpresa   = ""
    this_cDsEmpresa   = ""

    *-- Opcoes de geracao (optiongroups - valores default identicos ao original)
    *   this_nContaz:  1=Sim (exibe conta zerada), 2=Nao
    this_nContaz      = 1
    *   this_nTipoRel: 1=Analitico, 2=Sintetico
    this_nTipoRel     = 1
    *   this_nOptCli:  1=Analitico, 2=Sintetico
    this_nOptCli      = 1
    *   this_nOptCot:  1=Fechamento, 2=Movimentacao
    this_nOptCot      = 1
    *   this_nOptConc: 1=Sim (usar saldo conciliado), 2=Nao
    this_nOptConc     = 2
    *   this_nNrOpcao: 1=Sim (com NF), 2=Nao (sem NF), 3=Ambos
    this_nNrOpcao     = 3

    *-- Configuracao do relatorio
    this_cTitulo      = ""
    this_cCaminhoFRX  = ""
    this_cCursorDados = "cPlconta"    && Nome bate com FRX legado (Create Cursor cPlconta)

    *--------------------------------------------------------------------------
    * Init - Configura titulo e caminho do FRX
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            THIS.this_cTitulo    = "Balancete"
            THIS.this_cCaminhoFRX = gc_4c_CaminhoReports + "RelSigrebct.frx"
            loc_lSucesso = DODEFAULT()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC


    *--------------------------------------------------------------------------
    * Visualizar - Exibe relatorio em preview na tela (Pattern #167 auto)
    *--------------------------------------------------------------------------
    PROCEDURE Visualizar()
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.
        TRY
            IF THIS.PrepararDados()
                IF USED(THIS.this_cCursorDados) AND RECCOUNT(THIS.this_cCursorDados) > 0
                    SELECT (THIS.this_cCursorDados)
                    GO TOP
                    REPORT FORM (gc_4c_CaminhoReports + THIS.this_cArquivoRelatorio) ;
                        PREVIEW NOCONSOLE
                    loc_lSucesso = .T.
                ELSE
                    THIS.this_cMensagemErro = "Nenhum registro encontrado com os filtros informados."
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Visualizar")
            THIS.this_cMensagemErro = loc_oErro.Message
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Imprimir - Imprime relatorio com dialogo de impressora (Pattern #167 auto)
    *--------------------------------------------------------------------------
    PROCEDURE Imprimir()
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.
        TRY
            IF THIS.PrepararDados()
                IF USED(THIS.this_cCursorDados) AND RECCOUNT(THIS.this_cCursorDados) > 0
                    SELECT (THIS.this_cCursorDados)
                    GO TOP
                    REPORT FORM (gc_4c_CaminhoReports + THIS.this_cArquivoRelatorio) ;
                        TO PRINTER PROMPT NOCONSOLE
                    loc_lSucesso = .T.
                ELSE
                    THIS.this_cMensagemErro = "Nenhum registro encontrado com os filtros informados."
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Imprimir")
            THIS.this_cMensagemErro = loc_oErro.Message
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * GerarExcel - Exporta relatorio para arquivo ASCII (Excel) (Pattern #167 auto)
    *--------------------------------------------------------------------------
    PROCEDURE GerarExcel()
        LOCAL loc_lSucesso, loc_cArquivo, loc_oErro
        loc_lSucesso = .F.
        TRY
            IF THIS.PrepararDados()
                IF USED(THIS.this_cCursorDados) AND RECCOUNT(THIS.this_cCursorDados) > 0
                    SELECT (THIS.this_cCursorDados)
                    GO TOP
                    loc_cArquivo = SYS(5) + CURDIR() + "sigrebct_" + ;
                                   STRTRAN(DTOC(DATE()), "/", "") + ".xls"
                    REPORT FORM (gc_4c_CaminhoReports + THIS.this_cArquivoRelatorio) ;
                        TO FILE (loc_cArquivo) NOCONSOLE ASCII
                    IF FILE(loc_cArquivo)
                        MsgInfo("Arquivo gerado:" + CHR(13) + loc_cArquivo, "Excel")
                    ENDIF
                    loc_lSucesso = .T.
                ELSE
                    THIS.this_cMensagemErro = "Nenhum registro encontrado com os filtros informados."
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "GerarExcel")
            THIS.this_cMensagemErro = loc_oErro.Message
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

ENDDEFINE

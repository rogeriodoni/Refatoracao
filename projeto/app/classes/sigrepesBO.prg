*==============================================================================
* SIGREPESBO.PRG
* Business Object para Relatorio de Posicao de Estoque
* Herda de: RelatorioBase
*==============================================================================

DEFINE CLASS SigrepesBO AS RelatorioBase

    this_cTabela       = "SigCdPro"
    this_cCampoChave   = "CPros"
    this_cMensagemErro = ""

    *-- Pattern #142: injetado pelo CorretorAutomatico (default vazio) - REVISAR e substituir pelo alias do cursor binding do FRX
    this_cCursorDados = ""     && FIXME Pattern #142 pos-Erro51

    PROCEDURE Init()
        DODEFAULT()
        RETURN .T.
    ENDPROC

    PROCEDURE ObterChavePrimaria()
        LOCAL loc_cChave
        loc_cChave = ""
        IF USED(THIS.this_cTabela)
            loc_cChave = EVALUATE(THIS.this_cTabela + "." + THIS.this_cCampoChave)
        ENDIF
        RETURN loc_cChave
    ENDPROC

    PROCEDURE PrepararDados()
        RETURN .T.
    ENDPROC

    PROCEDURE Destroy()
        DODEFAULT()
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
                    loc_cArquivo = SYS(5) + CURDIR() + "Sigrepes_" + ;
                                   STRTRAN(DTOC(DATE()), "/", "") + ".xls"
                    REPORT FORM (gc_4c_CaminhoReports + THIS.this_cArquivoRelatorio) ;
                        TO FILE (loc_cArquivo) NOPREVIEW NOCONSOLE ASCII
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

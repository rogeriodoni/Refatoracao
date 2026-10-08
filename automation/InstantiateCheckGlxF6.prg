*==============================================================================
* InstantiateCheckGlxF6.prg - valida a Fase 6 de FormSigPrGlx/SigPrGlxBO
*
* Prova, MEDINDO no VFP9 (nao por leitura de codigo):
*   1. o form INSTANCIA de verdade - InicializarForm cria as 6 paginas,
*      incluindo as 4 acrescentadas nesta fase (Page3..Page6)
*   2. os controles novos existem, com a geometria do legado
*   3. as grades novas estao LIGADAS ao cursor certo (RecordSource +
*      ControlSource + ColumnCount) - grade sem binding fica um retangulo
*      branco, sem erro nenhum
*   4. os metodos de lookup sao PUBLIC e chamaveis de FORA (BINDEVENT so
*      enxerga metodo publico - regra #3)
*   5. os BINDEVENT dos dois lookups estao de fato registrados (AEVENTS)
*   6. Destroy() roda sem erro
*==============================================================================
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF

PUBLIC gb_4c_ModoTeste, gc_4c_ArquivoErroTeste, gc_4c_LogGlxF6
gb_4c_ModoTeste        = .T.
gc_4c_ArquivoErroTeste = "C:\4c\automation\vfp_error_glxf6.txt"
gc_4c_LogGlxF6         = "C:\4c\automation\logs\instantiate_glxf6.txt"

IF FILE(gc_4c_ArquivoErroTeste)
    DELETE FILE (gc_4c_ArquivoErroTeste)
ENDIF
IF FILE(gc_4c_LogGlxF6)
    DELETE FILE (gc_4c_LogGlxF6)
ENDIF

LOCAL loc_oForm, loc_oErro, loc_oPag, loc_nQtd
LOCAL ARRAY loc_aEv[1]

LogGlx("GLX FASE6 CHECK - inicio " + TTOC(DATETIME()))

TRY
    CD C:\4c\projeto\app\start
    DO config.prg
    SET PATH TO (gcCaminhoBase + "," + gcCaminhoClasses + "," + gcCaminhoUtils + ;
                 "," + gcCaminhoForms + "," + gcCaminhoIcones)
    SET PROCEDURE TO (gcCaminhoClasses + "dataaccess.prg")        ADDITIVE
    SET PROCEDURE TO (gcCaminhoClasses + "businessbase.prg")      ADDITIVE
    SET PROCEDURE TO (gcCaminhoClasses + "formbase.prg")          ADDITIVE
    SET PROCEDURE TO (gcCaminhoClasses + "gridbase.prg")          ADDITIVE
    SET PROCEDURE TO (gcCaminhoClasses + "FormErro.prg")          ADDITIVE
    SET PROCEDURE TO (gcCaminhoClasses + "formbuscaauxiliar.prg") ADDITIVE
    SET PROCEDURE TO (gcCaminhoUtils   + "functions.prg")         ADDITIVE
    SET PROCEDURE TO (gcCaminhoUtils   + "messages.prg")          ADDITIVE
    SET PROCEDURE TO (gcCaminhoUtils   + "validators.prg")        ADDITIVE
    SET PROCEDURE TO (gcCaminhoClasses + "SigPrGlxBO.prg")        ADDITIVE
    SET PROCEDURE TO (gcCaminhoForms + "operacionais\FormSigPrGlx.prg") ADDITIVE
    LogGlx("0 SETUP: OK")
CATCH TO loc_oErro
    LogGlx("0 SETUP FALHOU: " + loc_oErro.Message)
ENDTRY

*-- 1. Instancia o form
TRY
    loc_oForm = CREATEOBJECT("FormSigPrGlx")
    LogGlx("1 INSTANCIA: VARTYPE=" + VARTYPE(loc_oForm) + ;
        IIF(VARTYPE(loc_oForm) = "O", ;
            " W=" + TRANSFORM(loc_oForm.Width) + " H=" + TRANSFORM(loc_oForm.Height) + ;
            " PageCount=" + TRANSFORM(loc_oForm.pgf_4c_1.PageCount), ""))
CATCH TO loc_oErro
    LogGlx("1 INSTANCIA FALHOU: " + loc_oErro.Message + ;
        " LN=" + TRANSFORM(loc_oErro.LineNo) + " PROC=" + loc_oErro.Procedure)
ENDTRY

IF VARTYPE(loc_oForm) = "O"

    *-- 2. Page3 (Totais por Linha)
    TRY
        loc_oPag = loc_oForm.pgf_4c_1.Page3
        LogGlx("2a Page3 Caption=[" + loc_oPag.Caption + "] Enabled=" + TRANSFORM(loc_oPag.Enabled) + ;
            " ControlCount=" + TRANSFORM(loc_oPag.ControlCount))
        LogGlx("2b grd_4c_Linhas RecordSource=[" + loc_oPag.grd_4c_Linhas.RecordSource + ;
            "] Cols=" + TRANSFORM(loc_oPag.grd_4c_Linhas.ColumnCount) + ;
            " ReadOnly=" + TRANSFORM(loc_oPag.grd_4c_Linhas.ReadOnly) + ;
            " C1=[" + loc_oPag.grd_4c_Linhas.Column1.ControlSource + "]" + ;
            " C5=[" + loc_oPag.grd_4c_Linhas.Column5.ControlSource + "]" + ;
            " W1=" + TRANSFORM(loc_oPag.grd_4c_Linhas.Column1.Width))
        LogGlx("2c cmd_4c_CancelaLin Left=" + TRANSFORM(loc_oPag.cmd_4c_CancelaLin.Left) + ;
            " Top=" + TRANSFORM(loc_oPag.cmd_4c_CancelaLin.Top) + ;
            " Caption=[" + loc_oPag.cmd_4c_CancelaLin.Caption + "]")
    CATCH TO loc_oErro
        LogGlx("2 PAGE3 FALHOU: " + loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo))
    ENDTRY

    *-- 3. Page4 (Selecionar Estoque)
    TRY
        loc_oPag = loc_oForm.pgf_4c_1.Page4
        LogGlx("3a Page4 Caption=[" + loc_oPag.Caption + "] Enabled=" + TRANSFORM(loc_oPag.Enabled) + ;
            " ControlCount=" + TRANSFORM(loc_oPag.ControlCount))
        LogGlx("3b grd_4c_DispEstoque RecordSource=[" + loc_oPag.grd_4c_DispEstoque.RecordSource + ;
            "] Cols=" + TRANSFORM(loc_oPag.grd_4c_DispEstoque.ColumnCount) + ;
            " C1=[" + loc_oPag.grd_4c_DispEstoque.Column1.ControlSource + "]" + ;
            " C5=[" + loc_oPag.grd_4c_DispEstoque.Column5.ControlSource + "]" + ;
            " C5.ReadOnly=" + TRANSFORM(loc_oPag.grd_4c_DispEstoque.Column5.ReadOnly))
        LogGlx("3c txt_4c_Cpros CS=[" + loc_oPag.txt_4c_Cpros.ControlSource + "]" + ;
            " txt_4c_Qt_Selec Top=" + TRANSFORM(loc_oPag.txt_4c_Qt_Selec.Top))
    CATCH TO loc_oErro
        LogGlx("3 PAGE4 FALHOU: " + loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo))
    ENDTRY

    *-- 4. Page5 (Disponivel/Tamanho)
    TRY
        loc_oPag = loc_oForm.pgf_4c_1.Page5
        LogGlx("4a Page5 Caption=[" + loc_oPag.Caption + "] Enabled=" + TRANSFORM(loc_oPag.Enabled) + ;
            " ControlCount=" + TRANSFORM(loc_oPag.ControlCount))
        LogGlx("4b grd_4c_DispTamanho RecordSource=[" + loc_oPag.grd_4c_DispTamanho.RecordSource + ;
            "] Cols=" + TRANSFORM(loc_oPag.grd_4c_DispTamanho.ColumnCount) + ;
            " C1=[" + loc_oPag.grd_4c_DispTamanho.Column1.ControlSource + "]" + ;
            " C5=[" + loc_oPag.grd_4c_DispTamanho.Column5.ControlSource + "]")
    CATCH TO loc_oErro
        LogGlx("4 PAGE5 FALHOU: " + loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo))
    ENDTRY

    *-- 5. Page6 (Requisicao) - a pagina dos lookups
    TRY
        loc_oPag = loc_oForm.pgf_4c_1.Page6
        LogGlx("5a Page6 Caption=[" + loc_oPag.Caption + "] Enabled=" + TRANSFORM(loc_oPag.Enabled) + ;
            " ControlCount=" + TRANSFORM(loc_oPag.ControlCount))
        LogGlx("5b grd_4c_Pedra RecordSource=[" + loc_oPag.grd_4c_Pedra.RecordSource + ;
            "] Cols=" + TRANSFORM(loc_oPag.grd_4c_Pedra.ColumnCount) + ;
            " C1=[" + loc_oPag.grd_4c_Pedra.Column1.ControlSource + "]" + ;
            " C2=[" + loc_oPag.grd_4c_Pedra.Column2.ControlSource + "]" + ;
            " C5=[" + loc_oPag.grd_4c_Pedra.Column5.ControlSource + "]")
        LogGlx("5c grd_4c_Pedra ReadOnly=" + TRANSFORM(loc_oPag.grd_4c_Pedra.ReadOnly) + ;
            " C1.RO=" + TRANSFORM(loc_oPag.grd_4c_Pedra.Column1.ReadOnly) + ;
            " C2.RO=" + TRANSFORM(loc_oPag.grd_4c_Pedra.Column2.ReadOnly) + ;
            " C4.RO=" + TRANSFORM(loc_oPag.grd_4c_Pedra.Column4.ReadOnly) + ;
            " C5.RO=" + TRANSFORM(loc_oPag.grd_4c_Pedra.Column5.ReadOnly))
        LogGlx("5d cursor_4c_Requisicao USED=" + TRANSFORM(USED("cursor_4c_Requisicao")) + ;
            " RECCOUNT=" + TRANSFORM(RECCOUNT("cursor_4c_Requisicao")))
    CATCH TO loc_oErro
        LogGlx("5 PAGE6 FALHOU: " + loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo))
    ENDTRY

    *-- 6. Metodos de lookup PUBLIC (BINDEVENT so enxerga metodo publico)
    TRY
        LogGlx("6a PEMSTATUS AbrirLookupProdutoRequisicao: " + ;
            TRANSFORM(PEMSTATUS(loc_oForm, "AbrirLookupProdutoRequisicao", 5)))
        LogGlx("6b PEMSTATUS AbrirLookupProdutoSubstituto: " + ;
            TRANSFORM(PEMSTATUS(loc_oForm, "AbrirLookupProdutoSubstituto", 5)))
        LogGlx("6c PEMSTATUS GrdPedraProdutoKeyPress: " + ;
            TRANSFORM(PEMSTATUS(loc_oForm, "GrdPedraProdutoKeyPress", 5)))
        LogGlx("6d PEMSTATUS GrdPedraSubstitutoKeyPress: " + ;
            TRANSFORM(PEMSTATUS(loc_oForm, "GrdPedraSubstitutoKeyPress", 5)))
        LogGlx("6e this_lLookupEmCurso: " + TRANSFORM(loc_oForm.this_lLookupEmCurso))
    CATCH TO loc_oErro
        LogGlx("6 PEMSTATUS FALHOU: " + loc_oErro.Message)
    ENDTRY

    *-- 7. BINDEVENT efetivamente registrados (AEVENTS = 2 argumentos)
    TRY
        loc_nQtd = AEVENTS(loc_aEv, loc_oForm.pgf_4c_1.Page6.grd_4c_Pedra.Column1.Text1)
        LogGlx("7a AEVENTS Column1.Text1: " + TRANSFORM(loc_nQtd) + " binding(s)")
        IF loc_nQtd > 0
            LogGlx("7b    evento=[" + loc_aEv[1, 3] + "] delegate=[" + loc_aEv[1, 4] + "]")
        ENDIF
        loc_nQtd = AEVENTS(loc_aEv, loc_oForm.pgf_4c_1.Page6.grd_4c_Pedra.Column5.Text1)
        LogGlx("7c AEVENTS Column5.Text1: " + TRANSFORM(loc_nQtd) + " binding(s)")
        IF loc_nQtd > 0
            LogGlx("7d    evento=[" + loc_aEv[1, 3] + "] delegate=[" + loc_aEv[1, 4] + "]")
        ENDIF
    CATCH TO loc_oErro
        LogGlx("7 AEVENTS FALHOU: " + loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo))
    ENDTRY

    *-- 8. Guarda do lookup de substituto: sem produto principal, NAO abre
    *--    o picker (Show() modal travaria o script ate o timeout)
    TRY
        loc_oForm.pgf_4c_1.Page6.grd_4c_Pedra.Column5.Text1.Value = "ZZZZ"
        loc_oForm.AbrirLookupProdutoSubstituto()
        LogGlx("8a AbrirLookupProdutoSubstituto sem Column1: RETORNOU (guarda pegou)")
    CATCH TO loc_oErro
        LogGlx("8 LOOKUP SUBSTITUTO FALHOU: " + loc_oErro.Message + ;
            " LN=" + TRANSFORM(loc_oErro.LineNo) + " PROC=" + loc_oErro.Procedure)
    ENDTRY

    *-- 9. Lookup de produto com campo VAZIO: legado nao consulta nada
    TRY
        loc_oForm.pgf_4c_1.Page6.grd_4c_Pedra.Column1.Text1.Value = ""
        loc_oForm.AbrirLookupProdutoRequisicao()
        LogGlx("9a AbrirLookupProdutoRequisicao com campo vazio: RETORNOU (guarda pegou)")
    CATCH TO loc_oErro
        LogGlx("9 LOOKUP PRODUTO FALHOU: " + loc_oErro.Message + ;
            " LN=" + TRANSFORM(loc_oErro.LineNo) + " PROC=" + loc_oErro.Procedure)
    ENDTRY

    *-- 10. AlternarPagina para cada sub-pagina nova
    TRY
        loc_oForm.AlternarPagina(6)
        LogGlx("10a AlternarPagina(6): ActivePage=" + TRANSFORM(loc_oForm.pgf_4c_1.ActivePage))
        loc_oForm.AlternarPagina(1)
        LogGlx("10b AlternarPagina(1): ActivePage=" + TRANSFORM(loc_oForm.pgf_4c_1.ActivePage))
    CATCH TO loc_oErro
        LogGlx("10 ALTERNARPAGINA FALHOU: " + loc_oErro.Message)
    ENDTRY

    *-- 11. Destroy
    TRY
        loc_oForm.Release()
        LogGlx("11 RELEASE: OK (VARTYPE pos=" + VARTYPE(loc_oForm) + ")")
    CATCH TO loc_oErro
        LogGlx("11 RELEASE FALHOU: " + loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo))
    ENDTRY
ENDIF

IF FILE(gc_4c_ArquivoErroTeste)
    LogGlx("DIALOGOS SUPRIMIDOS:" + CHR(13) + CHR(10) + FILETOSTR(gc_4c_ArquivoErroTeste))
ELSE
    LogGlx("DIALOGOS: nenhum")
ENDIF

LogGlx("FIM " + TTOC(DATETIME()))
QUIT

PROCEDURE LogGlx(par_cTexto)
    STRTOFILE(par_cTexto + CHR(13) + CHR(10), gc_4c_LogGlxF6, 1)
ENDPROC

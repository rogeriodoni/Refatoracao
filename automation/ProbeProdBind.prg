*-- Erro183: exercita FormParaBO/BOParaForm com os campos novos.
*-- NAO grava no banco: so prova que todo nome de property existe e que o
*-- valor faz a volta BO -> Form -> BO sem perder nada.
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
PUBLIC gb_4c_ModoTeste, gc_4c_ArquivoErroTeste, gnConnHandle, gc_4c_UsuarioLogado
gb_4c_ModoTeste = .T.
gc_4c_ArquivoErroTeste = "C:\4c\automation\vfp_err_prodbind.txt"
IF FILE(gc_4c_ArquivoErroTeste)
    DELETE FILE (gc_4c_ArquivoErroTeste)
ENDIF
#DEFINE OUT "C:\4c\automation\probe_prodbind.txt"
LOCAL loc_oE, loc_oF, loc_oBO, loc_cPro, loc_n
STRTOFILE("A: inicio" + CHR(13)+CHR(10), OUT)
TRY
    CD C:\4c\projeto\app\start
    DO config.prg
    gc_4c_UsuarioLogado = "TESTE"
    gb_4c_ValidandoUI = .F.
    SET PATH TO (gcCaminhoBase + "," + gcCaminhoClasses + "," + gcCaminhoUtils + "," + gcCaminhoForms + "," + gcCaminhoIcones)
    SET PROCEDURE TO (gcCaminhoClasses + "dataaccess.prg")   ADDITIVE
    SET PROCEDURE TO (gcCaminhoClasses + "businessbase.prg") ADDITIVE
    SET PROCEDURE TO (gcCaminhoClasses + "formbase.prg")     ADDITIVE
    SET PROCEDURE TO (gcCaminhoClasses + "gridbase.prg")     ADDITIVE
    SET PROCEDURE TO (gcCaminhoClasses + "FormErro.prg")     ADDITIVE
    SET PROCEDURE TO (gcCaminhoUtils   + "functions.prg")    ADDITIVE
    SET PROCEDURE TO (gcCaminhoUtils   + "messages.prg")     ADDITIVE
    SET PROCEDURE TO (gcCaminhoUtils   + "validators.prg")   ADDITIVE
    SET PROCEDURE TO (gcCaminhoClasses + "ProdutoBO.prg")    ADDITIVE
    SET PROCEDURE TO (gcCaminhoClasses + "FormBuscaAuxiliar.prg") ADDITIVE
    SET PROCEDURE TO (gcCaminhoForms + "cadastros\FormProduto.prg") ADDITIVE
    gnConnHandle = SQLSTRINGCONNECT(ObterStringConexao())
    STRTOFILE("B: conn=" + TRANSFORM(gnConnHandle) + CHR(13)+CHR(10), OUT, 1)

    loc_oF = CREATEOBJECT("TesteProduto")
    STRTOFILE("C: form OK" + CHR(13)+CHR(10), OUT, 1)
    SET DATASESSION TO loc_oF.DataSessionId

    *-- um produto REAL que tenha os campos novos preenchidos
    loc_n = SQLEXEC(gnConnHandle, "SELECT TOP 1 cpros FROM SigCdPro WHERE prodnovo <> 0 ORDER BY cpros", "crP")
    loc_cPro = ""
    IF loc_n > 0 AND RECCOUNT("crP") > 0
        loc_cPro = ALLTRIM(crP.cpros)
    ENDIF
    STRTOFILE("D0: SQLEXEC=" + TRANSFORM(loc_n) + " used=" + TRANSFORM(USED("crP")) + " rec=" + TRANSFORM(IIF(USED("crP"), RECCOUNT("crP"), -1)) + CHR(13)+CHR(10), OUT, 1)
    STRTOFILE("D: produto de teste = [" + loc_cPro + "]" + CHR(13)+CHR(10), OUT, 1)

    loc_oBO = loc_oF.ExporBO()
    IF !loc_oBO.CarregarPorCodigo(loc_cPro)
        STRTOFILE("E: CarregarPorCodigo FALHOU" + CHR(13)+CHR(10), OUT, 1)
    ELSE
        STRTOFILE("E: CarregarPorCodigo OK" + CHR(13)+CHR(10), OUT, 1)
        STRTOFILE("   BO ANTES : qmins=" + TRANSFORM(loc_oBO.this_nQmins) + ;
            " pesobs=" + TRANSFORM(loc_oBO.this_nPesobs) + ;
            " lancamento=[" + ALLTRIM(loc_oBO.this_cLancamento) + "]" + ;
            " categoria=[" + ALLTRIM(loc_oBO.this_cCategoria) + "]" + ;
            " prodwebs=" + TRANSFORM(loc_oBO.this_nProdwebs) + ;
            " encoms=" + TRANSFORM(loc_oBO.this_nEncoms) + ;
            " segmasc=" + TRANSFORM(loc_oBO.this_nSegmasc) + " prodnovo=" + TRANSFORM(loc_oBO.this_nProtnovo) + ;
            " obsmkt=[" + ALLTRIM(loc_oBO.this_cObsmkt) + "]" + CHR(13)+CHR(10), OUT, 1)

        IF !loc_oF.ExporBOParaForm()
            STRTOFILE("F: BOParaForm FALHOU" + CHR(13)+CHR(10), OUT, 1)
        ELSE
            STRTOFILE("F: BOParaForm OK" + CHR(13)+CHR(10), OUT, 1)
            IF !loc_oF.ExporFormParaBO()
                STRTOFILE("G: FormParaBO FALHOU" + CHR(13)+CHR(10), OUT, 1)
            ELSE
                STRTOFILE("G: FormParaBO OK" + CHR(13)+CHR(10), OUT, 1)
                STRTOFILE("   BO DEPOIS: qmins=" + TRANSFORM(loc_oBO.this_nQmins) + ;
                    " pesobs=" + TRANSFORM(loc_oBO.this_nPesobs) + ;
                    " lancamento=[" + ALLTRIM(loc_oBO.this_cLancamento) + "]" + ;
                    " categoria=[" + ALLTRIM(loc_oBO.this_cCategoria) + "]" + ;
                    " prodwebs=" + TRANSFORM(loc_oBO.this_nProdwebs) + ;
                    " encoms=" + TRANSFORM(loc_oBO.this_nEncoms) + ;
                    " segmasc=" + TRANSFORM(loc_oBO.this_nSegmasc) + " prodnovo=" + TRANSFORM(loc_oBO.this_nProtnovo) + ;
                    " obsmkt=[" + ALLTRIM(loc_oBO.this_cObsmkt) + "]" + CHR(13)+CHR(10), OUT, 1)
            ENDIF
        ENDIF
    ENDIF
CATCH TO loc_oE
    STRTOFILE("EXCEPTION: " + loc_oE.Message + " Linha:" + TRANSFORM(loc_oE.LineNo) + ;
        " Proc:" + loc_oE.Procedure + CHR(13)+CHR(10), OUT, 1)
ENDTRY
IF FILE(gc_4c_ArquivoErroTeste)
    STRTOFILE("DIALOGOS: " + FILETOSTR(gc_4c_ArquivoErroTeste) + CHR(13)+CHR(10), OUT, 1)
ENDIF
STRTOFILE("Z: fim" + CHR(13)+CHR(10), OUT, 1)
QUIT

*-- subclasse so do teste: PROTECTED eh acessivel dentro da hierarquia
DEFINE CLASS TesteProduto AS FormProduto
    PROCEDURE ExporBO()
        RETURN THIS.this_oBusinessObject
    ENDPROC
    PROCEDURE ExporBOParaForm()
        RETURN THIS.BOParaForm()
    ENDPROC
    PROCEDURE ExporFormParaBO()
        RETURN THIS.FormParaBO()
    ENDPROC
ENDDEFINE

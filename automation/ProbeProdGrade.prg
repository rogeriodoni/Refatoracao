*-- Erro182: grade da Lista do Cadastro de Produtos (FormProduto.VincularGradeLista)
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
PUBLIC gb_4c_ModoTeste, gc_4c_ArquivoErroTeste, gnConnHandle, gc_4c_UsuarioLogado, gb_4c_ValidandoUI
gb_4c_ModoTeste = .T.
gb_4c_ValidandoUI = .F.
gc_4c_ArquivoErroTeste = "C:\4c\automation\vfp_err_prod.txt"
IF FILE(gc_4c_ArquivoErroTeste)
    DELETE FILE (gc_4c_ArquivoErroTeste)
ENDIF
#DEFINE OUT "C:\4c\automation\probe_prod.txt"
LOCAL loc_oE, loc_oForm, loc_oGrid
STRTOFILE("A: inicio" + CHR(13)+CHR(10), OUT)
TRY
    CD C:\4c\projeto\app\start
    DO config.prg
    gb_4c_ValidandoUI = .F.
    gc_4c_UsuarioLogado = "TESTE"
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

    loc_oForm = CREATEOBJECT("FormProduto")
    IF VARTYPE(loc_oForm) != "O"
        STRTOFILE("C: NAO INSTANCIOU" + CHR(13)+CHR(10), OUT, 1)
    ELSE
        SET DATASESSION TO loc_oForm.DataSessionId
        loc_oGrid = loc_oForm.pgf_4c_Paginas.Page1.grd_4c_Dados
        STRTOFILE(Dump(loc_oGrid, "01-apos-Init"), OUT, 1)

        *-- o caminho que o usuario percorre: recarregar a Lista
        loc_oForm.CarregarLista()
        STRTOFILE(Dump(loc_oGrid, "02-apos-CarregarLista"), OUT, 1)

        *-- e de novo (idempotencia do AddObject recriado)
        loc_oForm.CarregarLista()
        STRTOFILE(Dump(loc_oGrid, "03-apos-2a-CarregarLista"), OUT, 1)

        IF USED("cursor_4c_Dados")
            STRTOFILE("   RECCOUNT cursor_4c_Dados = " + ;
                TRANSFORM(RECCOUNT("cursor_4c_Dados")) + CHR(13)+CHR(10), OUT, 1)
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

FUNCTION Dump(par_oG, par_cTag)
    LOCAL loc_c, loc_nI, loc_oE3
    loc_c = CHR(13)+CHR(10) + "=== " + par_cTag + CHR(13)+CHR(10)
    TRY
        loc_c = loc_c + "  ColumnCount=" + TRANSFORM(par_oG.ColumnCount) + ;
            "  RecordSource=[" + par_oG.RecordSource + "]" + CHR(13)+CHR(10)
        FOR loc_nI = 1 TO par_oG.ColumnCount
            loc_c = loc_c + "  Col" + TRANSFORM(loc_nI) + ;
                " CS=[" + EVALUATE("par_oG.Column" + TRANSFORM(loc_nI) + ".ControlSource") + "]" + ;
                " W=" + TRANSFORM(EVALUATE("par_oG.Column" + TRANSFORM(loc_nI) + ".Width")) + ;
                " Cap=[" + EVALUATE("par_oG.Column" + TRANSFORM(loc_nI) + ".Header1.Caption") + "]" + ;
                " CC=[" + EVALUATE("par_oG.Column" + TRANSFORM(loc_nI) + ".CurrentControl") + "]" + ;
                CHR(13)+CHR(10)
        ENDFOR
        IF par_oG.ColumnCount >= 7
            loc_c = loc_c + "  Column7 tem chk_4c_Inativo? " + ;
                TRANSFORM(PEMSTATUS(par_oG.Column7, "chk_4c_Inativo", 5)) + CHR(13)+CHR(10)
        ENDIF
    CATCH TO loc_oE3
        loc_c = loc_c + "  DUMP-ERRO: " + loc_oE3.Message + CHR(13)+CHR(10)
    ENDTRY
    RETURN loc_c
ENDFUNC

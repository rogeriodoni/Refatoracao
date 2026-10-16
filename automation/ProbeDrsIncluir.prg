SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
PUBLIC gb_4c_ModoTeste, gc_4c_ArquivoErroTeste, gnConnHandle, gc_4c_UsuarioLogado
gb_4c_ModoTeste = .T.
gc_4c_ArquivoErroTeste = "C:\4c\automation\vfp_err_drs.txt"
#DEFINE OUT "C:\4c\automation\probe_drs.txt"

LOCAL loc_oForm, loc_oPg2, loc_nI, loc_oObj, loc_cL

STRTOFILE("=== PROBE FormDrs / BtnIncluirClick ===" + CHR(13) + CHR(10), OUT)

TRY
    CD C:\4c\projeto\app\start
    DO config.prg
    gc_4c_UsuarioLogado = "4control"
    SET PATH TO (gcCaminhoBase + "," + gcCaminhoClasses + "," + gcCaminhoUtils + "," + gcCaminhoForms + "," + gcCaminhoIcones)
    SET PROCEDURE TO (gcCaminhoClasses + "dataaccess.prg")   ADDITIVE
    SET PROCEDURE TO (gcCaminhoClasses + "businessbase.prg") ADDITIVE
    SET PROCEDURE TO (gcCaminhoClasses + "formbase.prg")     ADDITIVE
    SET PROCEDURE TO (gcCaminhoClasses + "gridbase.prg")     ADDITIVE
    SET PROCEDURE TO (gcCaminhoClasses + "FormErro.prg")     ADDITIVE
    SET PROCEDURE TO (gcCaminhoUtils   + "functions.prg")    ADDITIVE
    SET PROCEDURE TO (gcCaminhoUtils   + "messages.prg")     ADDITIVE
    SET PROCEDURE TO (gcCaminhoUtils   + "validators.prg")   ADDITIVE
    SET PROCEDURE TO (gcCaminhoClasses + "FormBuscaAuxiliar.prg") ADDITIVE
    SET PROCEDURE TO (gcCaminhoClasses + "DrsBO.prg")        ADDITIVE
    SET PROCEDURE TO (gcCaminhoForms + "cadastros\FormDrs.prg") ADDITIVE

    loc_oForm = CREATEOBJECT("FormDrs")
    STRTOFILE("1) CREATEOBJECT -> VARTYPE=" + VARTYPE(loc_oForm) + ;
        IIF(VARTYPE(loc_oForm) = "O", " Caption=[" + loc_oForm.Caption + "]", " *** NAO ABRIU ***") + ;
        CHR(13) + CHR(10), OUT, 1)

    IF VARTYPE(loc_oForm) != "O"
        QUIT
    ENDIF

    STRTOFILE("2) PageCount=" + TRANSFORM(loc_oForm.pgf_4c_Paginas.PageCount) + ;
        " ActivePage(antes)=" + TRANSFORM(loc_oForm.pgf_4c_Paginas.ActivePage) + CHR(13) + CHR(10), OUT, 1)

    *-- Botoes CRUD existentes na Page1
    STRTOFILE(CHR(13) + CHR(10) + "3) BOTOES da Page1 (cnt_4c_Botoes):" + CHR(13) + CHR(10), OUT, 1)
    WITH loc_oForm.pgf_4c_Paginas.Page1.cnt_4c_Botoes
        FOR loc_nI = 1 TO .ControlCount
            loc_oObj = .Controls(loc_nI)
            STRTOFILE("   " + PADR(loc_oObj.Name, 22) + " Left=" + PADL(TRANSFORM(loc_oObj.Left), 4) + ;
                " Vis=" + TRANSFORM(loc_oObj.Visible) + " Ena=" + TRANSFORM(loc_oObj.Enabled) + CHR(13) + CHR(10), OUT, 1)
        ENDFOR
    ENDWITH

    *-- Chama o Incluir
    STRTOFILE(CHR(13) + CHR(10) + "4) BtnIncluirClick()..." + CHR(13) + CHR(10), OUT, 1)
    loc_oForm.BtnIncluirClick()
    STRTOFILE("   ActivePage(depois)=" + TRANSFORM(loc_oForm.pgf_4c_Paginas.ActivePage) + CHR(13) + CHR(10), OUT, 1)

    loc_oPg2 = loc_oForm.pgf_4c_Paginas.Page2
    STRTOFILE(CHR(13) + CHR(10) + "5) CONTROLES da Page2:" + CHR(13) + CHR(10), OUT, 1)
    FOR loc_nI = 1 TO loc_oPg2.ControlCount
        loc_oObj = loc_oPg2.Controls(loc_nI)
        STRTOFILE("   " + PADR(loc_oObj.Name, 24) + " " + PADR(loc_oObj.BaseClass, 14) + ;
            " Top=" + PADL(TRANSFORM(loc_oObj.Top), 4) + ;
            " Left=" + PADL(TRANSFORM(loc_oObj.Left), 5) + ;
            " W=" + PADL(TRANSFORM(loc_oObj.Width), 5) + ;
            " H=" + PADL(TRANSFORM(loc_oObj.Height), 4) + ;
            " Vis=" + TRANSFORM(loc_oObj.Visible) + ;
            " Ena=" + TRANSFORM(loc_oObj.Enabled) + CHR(13) + CHR(10), OUT, 1)
    ENDFOR

    *-- Dentro do cnt_4c_Campos (campos dinamicos)
    IF PEMSTATUS(loc_oPg2, "cnt_4c_Campos", 5)
        STRTOFILE(CHR(13) + CHR(10) + "6) cnt_4c_Campos.ControlCount=" + ;
            TRANSFORM(loc_oPg2.cnt_4c_Campos.ControlCount) + CHR(13) + CHR(10), OUT, 1)
        FOR loc_nI = 1 TO loc_oPg2.cnt_4c_Campos.ControlCount
            loc_oObj = loc_oPg2.cnt_4c_Campos.Controls(loc_nI)
            STRTOFILE("   " + PADR(loc_oObj.Name, 24) + " " + PADR(loc_oObj.BaseClass, 12) + ;
                " Vis=" + TRANSFORM(loc_oObj.Visible) + CHR(13) + CHR(10), OUT, 1)
        ENDFOR
    ENDIF

    *-- Cursores relevantes
    STRTOFILE(CHR(13) + CHR(10) + "7) CURSORES: crSigSyCit USED=" + TRANSFORM(USED("crSigSyCit")) + ;
        IIF(USED("crSigSyCit"), " RECCOUNT=" + TRANSFORM(RECCOUNT("crSigSyCit")), "") + ;
        " | crSigSyCrs USED=" + TRANSFORM(USED("crSigSyCrs")) + ;
        IIF(USED("crSigSyCrs"), " RECCOUNT=" + TRANSFORM(RECCOUNT("crSigSyCrs")), "") + ;
        CHR(13) + CHR(10), OUT, 1)

    STRTOFILE("8) this_cTits=[" + loc_oForm.this_cTits + "]" + CHR(13) + CHR(10), OUT, 1)
    STRTOFILE("FIM" + CHR(13) + CHR(10), OUT, 1)

CATCH TO loc_oE
    STRTOFILE("*** EXCECAO: " + loc_oE.Message + " | Linha " + TRANSFORM(loc_oE.LineNo) + ;
        " | " + loc_oE.Procedure + CHR(13) + CHR(10), OUT, 1)
ENDTRY

QUIT

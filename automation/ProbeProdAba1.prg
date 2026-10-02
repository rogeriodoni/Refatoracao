*-- Erro183: aba "Principal" do Cadastro de Produtos apos a reconstrucao.
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
PUBLIC gb_4c_ModoTeste, gc_4c_ArquivoErroTeste, gnConnHandle, gc_4c_UsuarioLogado
gb_4c_ModoTeste = .T.
gc_4c_ArquivoErroTeste = "C:\4c\automation\vfp_err_prodaba1.txt"
IF FILE(gc_4c_ArquivoErroTeste)
    DELETE FILE (gc_4c_ArquivoErroTeste)
ENDIF
#DEFINE OUT "C:\4c\automation\probe_prodaba1.txt"
LOCAL loc_oE, loc_oForm, loc_oPg, loc_nI, loc_nVis, loc_nOcu, loc_cNomes, loc_o
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

    loc_oForm = CREATEOBJECT("FormProduto")
    IF VARTYPE(loc_oForm) != "O"
        STRTOFILE("C: NAO INSTANCIOU (Init devolveu .F.)" + CHR(13)+CHR(10), OUT, 1)
    ELSE
        STRTOFILE("C: Init OK - Form.Width=" + TRANSFORM(loc_oForm.Width) + ;
            " Height=" + TRANSFORM(loc_oForm.Height) + CHR(13)+CHR(10), OUT, 1)
        SET DATASESSION TO loc_oForm.DataSessionId
        loc_oPg = loc_oForm.pgf_4c_Paginas.Page2.pgf_4c_Divisoes.Page1
        STRTOFILE("D: aba Principal ControlCount=" + TRANSFORM(loc_oPg.ControlCount) + ;
            CHR(13)+CHR(10), OUT, 1)
        loc_nVis = 0
        loc_nOcu = 0
        loc_cNomes = ""
        FOR loc_nI = 1 TO loc_oPg.ControlCount
            loc_o = loc_oPg.Controls(loc_nI)
            IF loc_o.Visible
                loc_nVis = loc_nVis + 1
            ELSE
                loc_nOcu = loc_nOcu + 1
                loc_cNomes = loc_cNomes + "      " + loc_o.Name + " (" + ;
                    loc_o.BaseClass + ")" + CHR(13)+CHR(10)
            ENDIF
        ENDFOR
        STRTOFILE("E: visiveis=" + TRANSFORM(loc_nVis) + "  ocultos=" + ;
            TRANSFORM(loc_nOcu) + CHR(13)+CHR(10), OUT, 1)
        STRTOFILE("   ocultos (devem ser exatamente os 5 do legado):" + CHR(13)+CHR(10) + ;
            loc_cNomes, OUT, 1)

        *-- amostra dos controles novos: existem e estao onde o legado manda?
        STRTOFILE(Chk(loc_oPg, "txt_4c_DtSituas", 115, 918), OUT, 1)
        STRTOFILE(Chk(loc_oPg, "txt_4c_Qmin", 187, 633), OUT, 1)
        STRTOFILE(Chk(loc_oPg, "lbl_4c_Label13", 191, 558), OUT, 1)
        STRTOFILE(Chk(loc_oPg, "txt_4c_Peso", 347, 390), OUT, 1)
        STRTOFILE(Chk(loc_oPg, "obj_4c_Fwoption1", 330, 899), OUT, 1)
        STRTOFILE(Chk(loc_oPg, "obj_4c_Getdsccompras", 445, 102), OUT, 1)
        STRTOFILE(Chk(loc_oPg, "obj_4c_CmdArquivos", 38, 679), OUT, 1)
        STRTOFILE(Chk(loc_oPg, "chk_4c_Fwcheckbox5", 409, 906), OUT, 1)
        STRTOFILE(Chk(loc_oPg, "lbl_4c_Label31", 445, 12), OUT, 1)

        *-- Option3/Option4 do Fwoption1 tem de continuar ocultos
        STRTOFILE("   Fwoption1.Buttons: 1.Vis=" + TRANSFORM(loc_oPg.obj_4c_Fwoption1.Buttons(1).Visible) + ;
            " 2.Vis=" + TRANSFORM(loc_oPg.obj_4c_Fwoption1.Buttons(2).Visible) + ;
            " 3.Vis=" + TRANSFORM(loc_oPg.obj_4c_Fwoption1.Buttons(3).Visible) + ;
            " 4.Vis=" + TRANSFORM(loc_oPg.obj_4c_Fwoption1.Buttons(4).Visible) + ;
            CHR(13)+CHR(10), OUT, 1)

        *-- o label de 2 linhas nao pode ter colapsado para 1 (regra #23)
        STRTOFILE("   lbl_4c_Label31 H=" + TRANSFORM(loc_oPg.lbl_4c_Label31.Height) + ;
            " (legado 28)  lbl_4c_Label44 H=" + TRANSFORM(loc_oPg.lbl_4c_Label44.Height) + ;
            " (legado 29)" + CHR(13)+CHR(10), OUT, 1)
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

FUNCTION Chk(par_oPg, par_cNome, par_nTop, par_nLeft)
    LOCAL loc_c, loc_o, loc_oEx
    TRY
        IF !PEMSTATUS(par_oPg, par_cNome, 5)
            RETURN "   " + PADR(par_cNome, 24) + " *** NAO EXISTE" + CHR(13)+CHR(10)
        ENDIF
        loc_o = EVALUATE("par_oPg." + par_cNome)
        loc_c = "   " + PADR(par_cNome, 24) + " Top=" + PADL(TRANSFORM(loc_o.Top), 4) + ;
            "/" + TRANSFORM(par_nTop) + " Left=" + PADL(TRANSFORM(loc_o.Left), 4) + ;
            "/" + TRANSFORM(par_nLeft) + ;
            IIF(loc_o.Top = par_nTop AND loc_o.Left = par_nLeft, "  OK", "  *** DIVERGE") + ;
            CHR(13)+CHR(10)
    CATCH TO loc_oEx
        loc_c = "   " + PADR(par_cNome, 24) + " *** ERRO: " + loc_oEx.Message + CHR(13)+CHR(10)
    ENDTRY
    RETURN loc_c
ENDFUNC

SET SAFETY OFF
SET RESOURCE OFF
LOCAL loc_oF, loc_oE, loc_cR, loc_nI
loc_cR = ""
PUBLIC gc_4c_CaminhoIcones, gnConnHandle, gb_4c_ValidandoUI
gc_4c_CaminhoIcones = "C:\4c\vbmp\"
gnConnHandle        = -1
gb_4c_ValidandoUI   = .T.
TRY
    SET PROCEDURE TO "C:\4c\projeto\app\utils\functions.prg"  ADDITIVE
    SET PROCEDURE TO "C:\4c\projeto\app\utils\messages.prg"   ADDITIVE
    SET PROCEDURE TO "C:\4c\projeto\app\classes\businessbase.prg" ADDITIVE
    SET PROCEDURE TO "C:\4c\projeto\app\classes\formbase.prg"  ADDITIVE
    SET PROCEDURE TO "C:\4c\projeto\app\classes\sigopdenBO.prg" ADDITIVE
    SET PROCEDURE TO "C:\4c\projeto\app\forms\operacionais\Formsigopden.prg" ADDITIVE

    loc_oF = CREATEOBJECT("Formsigopden", "001", "PEDIDO", 1)
    IF VARTYPE(loc_oF) = "O"
        loc_cR = "INSTANCIOU OK | ControlCount=" + TRANSFORM(loc_oF.ControlCount) + CHR(13)
        loc_cR = loc_cR + "LockScreen=" + TRANSFORM(loc_oF.LockScreen) + CHR(13) + CHR(13)
        loc_cR = loc_cR + "-- TabIndex efetivo (lido de volta) --" + CHR(13)
        loc_cR = loc_cR + "cnt_4c_Sombra        = " + TRANSFORM(loc_oF.cnt_4c_Sombra.TabIndex) + CHR(13)
        loc_cR = loc_cR + "lbl_4c_LblTitFornec  = " + TRANSFORM(loc_oF.lbl_4c_LblTitFornec.TabIndex) + CHR(13)
        loc_cR = loc_cR + "txt_4c_01            = " + TRANSFORM(loc_oF.txt_4c_01.TabIndex) + CHR(13)
        loc_cR = loc_cR + "txt_4c_12            = " + TRANSFORM(loc_oF.txt_4c_12.TabIndex) + CHR(13)
        loc_cR = loc_cR + "obj_4c_Get13         = " + TRANSFORM(loc_oF.obj_4c_Get13.TabIndex) + CHR(13)
        loc_cR = loc_cR + "cmd_4c_Ok            = " + TRANSFORM(loc_oF.cmd_4c_Ok.TabIndex) + ;
                 "   <- deve ser o MAIOR (22)" + CHR(13) + CHR(13)
        loc_cR = loc_cR + "-- valores em modo ValidandoUI (devem estar VAZIOS) --" + CHR(13)
        loc_cR = loc_cR + "txt_4c_01.Value      = [" + loc_oF.txt_4c_01.Value + "]" + CHR(13)
        loc_cR = loc_cR + "lblTitFornec.Caption = [" + loc_oF.lbl_4c_LblTitFornec.Caption + "]" + CHR(13)
        loc_oF.Release()
    ELSE
        loc_cR = "FALHOU - VARTYPE = " + VARTYPE(loc_oF)
    ENDIF
CATCH TO loc_oE
    loc_cR = loc_cR + "EXCECAO: " + loc_oE.Message + CHR(13) + ;
        "Linha: " + TRANSFORM(loc_oE.LineNo) + CHR(13) + "Proc: " + loc_oE.Procedure
ENDTRY
STRTOFILE(loc_cR, "C:\4c\tasks\task718\probe_tab.out")
QUIT

SET SAFETY OFF
SET RESOURCE OFF
LOCAL loc_oF, loc_oE, loc_cR
loc_cR = ""
CD "C:\4c\projeto\app\start"
TRY
    DO config.prg
    ConfigurarAmbiente()
    *-- gb_4c_ValidandoUI SO DEPOIS do config.prg (ele reseta a flag)
    PUBLIC gb_4c_ValidandoUI
    gb_4c_ValidandoUI = .T.
    GarantirClasse("Formsigopden")
    loc_oF = CREATEOBJECT("Formsigopden", "001", "PEDIDO", 1)
    IF VARTYPE(loc_oF) = "O"
        loc_cR = "INSTANCIOU OK" + CHR(13) + ;
            "BaseClass = " + loc_oF.BaseClass + CHR(13) + ;
            "Caption   = " + loc_oF.Caption + CHR(13) + ;
            "LockScreen= " + TRANSFORM(loc_oF.LockScreen) + CHR(13) + ;
            "Controles = " + TRANSFORM(loc_oF.ControlCount) + CHR(13) + ;
            "BOParaForm existe = " + TRANSFORM(PEMSTATUS(loc_oF, "BOParaForm", 5)) + CHR(13) + ;
            "BOParaForm PROTECTED = " + TRANSFORM(PEMSTATUS(loc_oF, "BOParaForm", 2)) + CHR(13) + ;
            "txt_4c_01.TabIndex = " + TRANSFORM(loc_oF.txt_4c_01.TabIndex) + CHR(13) + ;
            "txt_4c_01.Value    = [" + TRANSFORM(loc_oF.txt_4c_01.Value) + "]" + CHR(13) + ;
            "lblTitFornec.Caption = [" + loc_oF.lbl_4c_LblTitFornec.Caption + "]" + CHR(13) + ;
            "get13.TabIndex     = " + TRANSFORM(loc_oF.obj_4c_Get13.TabIndex) + CHR(13) + ;
            "cmd_4c_Ok.TabIndex = " + TRANSFORM(loc_oF.cmd_4c_Ok.TabIndex)
        loc_oF.Release()
    ELSE
        loc_cR = "FALHOU - VARTYPE = " + VARTYPE(loc_oF)
    ENDIF
CATCH TO loc_oE
    loc_cR = "EXCECAO: " + loc_oE.Message + CHR(13) + ;
        "Linha: " + TRANSFORM(loc_oE.LineNo) + CHR(13) + "Proc: " + loc_oE.Procedure
ENDTRY
STRTOFILE(loc_cR, "C:\4c\tasks\task718\probe_fase8.out")
QUIT

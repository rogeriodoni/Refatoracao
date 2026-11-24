SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
PUBLIC gcOut, gb_4c_ModoTeste, gc_4c_ArquivoErroTeste
gcOut = "C:\4c\automation\probe382layout.txt"
gb_4c_ModoTeste = .T.
gc_4c_ArquivoErroTeste = "C:" + CHR(92) + "4c" + CHR(92) + "automation" + CHR(92) + "probe382lay_dialogs.txt"
STRTOFILE("LAYOUT FormSigReInv" + CHR(13)+CHR(10), gcOut)
DO ("C:\4c\projeto\app\start\config.prg")
ConfigurarAmbiente()
PUBLIC gnConnHandle
gnConnHandle = SQLSTRINGCONNECT(ObterStringConexao())
IF gnConnHandle > 0
    SQLSETPROP(gnConnHandle, "QueryTimeOut", 180)
    SQLSETPROP(gnConnHandle, "DispWarnings", .F.)
    IF TYPE("go_4c_Sistema") = "O"
        go_4c_Sistema.cCodEmpresa = "001"
    ENDIF
ENDIF
GarantirClasse("FormSigReInv")
LOCAL loForm
loForm = CREATEOBJECT("FormSigReInv")
LogL("CREATEOBJECT VARTYPE=" + VARTYPE(loForm))
IF VARTYPE(loForm) = "O"
    LogL("FORM Width=" + TRANSFORM(loForm.Width) + " Height=" + TRANSFORM(loForm.Height))
    DumpC(loForm, "FORM", 0, 0)
ENDIF
LogL("FIM")
QUIT

PROCEDURE DumpC(par_oPai, par_cTag, par_nOffT, par_nOffL)
    LOCAL lnI, loC, lnJ
    LogL("--- " + par_cTag + " (" + TRANSFORM(par_oPai.ControlCount) + ") ---")
    FOR lnI = 1 TO par_oPai.ControlCount
        loC = par_oPai.Controls(lnI)
        IF PEMSTATUS(loC, "Top", 5) AND PEMSTATUS(loC, "Left", 5)
            LogL(PADR(loC.Name, 24) + PADR(loC.BaseClass, 14) + ;
                 " T=" + PADL(TRANSFORM(loC.Top + par_nOffT), 5) + ;
                 " L=" + PADL(TRANSFORM(loC.Left + par_nOffL), 5) + ;
                 " W=" + PADL(TRANSFORM(loC.Width), 5) + ;
                 " H=" + PADL(TRANSFORM(loC.Height), 5) + ;
                 " Vis=" + TRANSFORM(loC.Visible) + ;
                 IIF(PEMSTATUS(loC, "Caption", 5), " [" + ALLTRIM(loC.Caption) + "]", ""))
            IF INLIST(UPPER(loC.BaseClass), "CONTAINER", "PAGEFRAME")
                IF UPPER(loC.BaseClass) == "CONTAINER"
                    DumpC(loC, par_cTag + "." + loC.Name, loC.Top + par_nOffT, loC.Left + par_nOffL)
                ENDIF
            ENDIF
        ENDIF
    ENDFOR
ENDPROC

PROCEDURE LogL(par_c)
    STRTOFILE(par_c + CHR(13)+CHR(10), gcOut, 1)
ENDPROC

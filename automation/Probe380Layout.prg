SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF

PUBLIC gcOut, gb_4c_ModoTeste, gc_4c_ArquivoErroTeste
gcOut = "C:\4c\automation\probe380layout.txt"
gb_4c_ModoTeste = .T.
gc_4c_ArquivoErroTeste = "C:" + CHR(92) + "4c" + CHR(92) + "automation" + CHR(92) + "probe380_dialogs.txt"
STRTOFILE("PROBE 380 INICIO" + CHR(13) + CHR(10), gcOut)

DO ("C:\4c\projeto\app\start\config.prg")
ConfigurarAmbiente()
Log380("ambiente OK")
GarantirClasse("Formsigreinr")
Log380("GarantirClasse OK")

LOCAL loForm
loForm = CREATEOBJECT("Formsigreinr", 3)
Log380("CREATEOBJECT -> VARTYPE=" + VARTYPE(loForm))

IF VARTYPE(loForm) = "O"
    Log380("FORM Width=" + TRANSFORM(loForm.Width) + " Height=" + TRANSFORM(loForm.Height))
    Log380("PGF Top=" + TRANSFORM(loForm.pgf_4c_Paginas.Top) + ;
           " Left=" + TRANSFORM(loForm.pgf_4c_Paginas.Left) + ;
           " Width=" + TRANSFORM(loForm.pgf_4c_Paginas.Width) + ;
           " Height=" + TRANSFORM(loForm.pgf_4c_Paginas.Height))
    DumpCont(loForm.pgf_4c_Paginas.Page1, "PAGE1", loForm.pgf_4c_Paginas.Top, loForm.pgf_4c_Paginas.Left)
    DumpCont(loForm, "FORM", 0, 0)
    loForm.Release()
ENDIF
Log380("FIM")
QUIT

PROCEDURE Log380(par_c)
    STRTOFILE(par_c + CHR(13) + CHR(10), gcOut, 1)
ENDPROC

PROCEDURE DumpCont(par_oPai, par_cTag, par_nOffT, par_nOffL)
    LOCAL lnI, loC, lnJ
    Log380("--- " + par_cTag + " (" + TRANSFORM(par_oPai.ControlCount) + " controles) ---")
    FOR lnI = 1 TO par_oPai.ControlCount
        loC = par_oPai.Controls(lnI)
        IF PEMSTATUS(loC, "Top", 5) AND PEMSTATUS(loC, "Left", 5)
            Log380(PADR(loC.Name, 24) + PADR(loC.BaseClass, 14) + ;
                   " absTop=" + PADL(TRANSFORM(loC.Top + par_nOffT), 5) + ;
                   " absLeft=" + PADL(TRANSFORM(loC.Left + par_nOffL), 5) + ;
                   " W=" + PADL(TRANSFORM(loC.Width), 5) + ;
                   " H=" + PADL(TRANSFORM(loC.Height), 5) + ;
                   " Vis=" + TRANSFORM(loC.Visible) + ;
                   IIF(PEMSTATUS(loC, "Alignment", 5), " Alig=" + TRANSFORM(loC.Alignment), "") + ;
                   IIF(PEMSTATUS(loC, "AutoSize", 5), " Auto=" + TRANSFORM(loC.AutoSize), "") + ;
                   IIF(PEMSTATUS(loC, "Caption", 5), " [" + ALLTRIM(loC.Caption) + "]", ""))
            IF UPPER(loC.BaseClass) == "OPTIONGROUP" OR UPPER(loC.BaseClass) == "COMMANDGROUP"
                FOR lnJ = 1 TO loC.ButtonCount
                    Log380("      btn" + TRANSFORM(lnJ) + " " + ;
                           " absTop=" + PADL(TRANSFORM(loC.Buttons(lnJ).Top + loC.Top + par_nOffT), 5) + ;
                           " absLeft=" + PADL(TRANSFORM(loC.Buttons(lnJ).Left + loC.Left + par_nOffL), 5) + ;
                           " W=" + PADL(TRANSFORM(loC.Buttons(lnJ).Width), 5) + ;
                           " H=" + PADL(TRANSFORM(loC.Buttons(lnJ).Height), 5) + ;
                           " [" + ALLTRIM(loC.Buttons(lnJ).Caption) + "]")
                ENDFOR
            ENDIF
        ENDIF
    ENDFOR
ENDPROC

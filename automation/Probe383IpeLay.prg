SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
PUBLIC gcL, gb_4c_ModoTeste, gc_4c_ArquivoErroTeste
gcL = "C:\4c\automation\probe383ipelay.txt"
gb_4c_ModoTeste = .T.
gc_4c_ArquivoErroTeste = "C:" + CHR(92) + "4c" + CHR(92) + "automation" + CHR(92) + "probe383ipelay_d.txt"
STRTOFILE("", gcL)
DO ("C:\4c\projeto\app\start\config.prg")
ConfigurarAmbiente()
PUBLIC gnConnHandle
gnConnHandle = SQLSTRINGCONNECT(ObterStringConexao())
IF gnConnHandle > 0
    SQLSETPROP(gnConnHandle, "DispWarnings", .F.)
    IF TYPE("go_4c_Sistema") = "O"
        go_4c_Sistema.cCodEmpresa = "001"
    ENDIF
ENDIF
GarantirClasse("Formsigreipe")
LOCAL loF
loF = CREATEOBJECT("Formsigreipe")
IF VARTYPE(loF) = "O"
    LL("FORM W=" + TRANSFORM(loF.Width) + " H=" + TRANSFORM(loF.Height))
    LL("PGF Top=" + TRANSFORM(loF.pgf_4c_Paginas.Top) + " Left=" + TRANSFORM(loF.pgf_4c_Paginas.Left))
    Dump(loF.pgf_4c_Paginas.Page1, loF.pgf_4c_Paginas.Top, loF.pgf_4c_Paginas.Left)
ENDIF
LL("FIM")
QUIT
PROCEDURE Dump(par_oP, par_nT, par_nL)
    LOCAL lnI, loC
    FOR lnI = 1 TO par_oP.ControlCount
        loC = par_oP.Controls(lnI)
        IF PEMSTATUS(loC, "Top", 5)
            LL(PADR(loC.Name, 26) + PADR(loC.BaseClass, 13) + ;
               " T=" + PADL(TRANSFORM(loC.Top + par_nT), 4) + ;
               " L=" + PADL(TRANSFORM(loC.Left + par_nL), 4) + ;
               " W=" + PADL(TRANSFORM(loC.Width), 4) + ;
               " H=" + PADL(TRANSFORM(loC.Height), 4) + ;
               IIF(PEMSTATUS(loC, "ButtonCount", 5), " BC=" + TRANSFORM(loC.ButtonCount), "") + ;
               IIF(PEMSTATUS(loC, "Caption", 5), " [" + ALLTRIM(loC.Caption) + "]", ""))
        ENDIF
    ENDFOR
ENDPROC
PROCEDURE LL(par_c)
    STRTOFILE(par_c + CHR(13)+CHR(10), gcL, 1)
ENDPROC

*==============================================================================
* Probe3.prg - Erro312: os 3 forms que nao reportaram no sweep.
* Reporta o VARTYPE do retorno de CREATEOBJECT (um Init que devolve .F. faz
* o CREATEOBJECT devolver .F. SEM lancar excecao).
*==============================================================================
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF

LOCAL loc_cTag
loc_cTag = IIF(PCOUNT() > 0, "", "")
loc_cTag = SYS(5) && placeholder

LOCAL loc_cOut, loc_nI, loc_cForm, loForm, loc_oErr
LOCAL ARRAY loc_aF[3]
loc_aF[1] = "FormCOM"
loc_aF[2] = "FormCVE"
loc_aF[3] = "FormObs"

PUBLIC gb_4c_ModoTeste, gb_4c_ValidandoUI, gc_4c_ArquivoErroTeste
gb_4c_ModoTeste        = .T.
gb_4c_ValidandoUI      = .F.
gc_4c_ArquivoErroTeste = "C:\4c\automation\erro312\probe3_erro.txt"

CD "C:\4c\projeto\app\start"
DO config.prg
ConfigurarAmbiente()

loc_cOut = ""
FOR loc_nI = 1 TO 3
    loc_cForm = loc_aF[loc_nI]
    loForm = .NULL.
    TRY
        GarantirClasse(loc_cForm)
        loForm = CREATEOBJECT(loc_cForm)
    CATCH TO loc_oErr
        loc_cOut = loc_cOut + PADR(loc_cForm, 12) + "EXCECAO: " + loc_oErr.Message + CHR(13) + CHR(10)
        loForm = .NULL.
    ENDTRY
    IF VARTYPE(loForm) = "O"
        loc_cOut = loc_cOut + PADR(loc_cForm, 12) + "OBJETO ok"
        IF PEMSTATUS(loForm.pgf_4c_Paginas.Page1, "cnt_4c_Botoes", 5)
            loc_cOut = loc_cOut + "  BackStyle=" + ;
                TRANSFORM(loForm.pgf_4c_Paginas.Page1.cnt_4c_Botoes.BackStyle)
        ELSE
            loc_cOut = loc_cOut + "  (sem cnt_4c_Botoes na Page1)"
        ENDIF
        loc_cOut = loc_cOut + CHR(13) + CHR(10)
        loForm.Release()
    ELSE
        loc_cOut = loc_cOut + PADR(loc_cForm, 12) + "CREATEOBJECT devolveu " + ;
                   VARTYPE(loForm) + " = " + TRANSFORM(loForm) + ;
                   "  (Init recusou)" + CHR(13) + CHR(10)
    ENDIF
ENDFOR

STRTOFILE(loc_cOut, FULLPATH("C:\4c\automation\erro312\probe3_out.txt"))
QUIT

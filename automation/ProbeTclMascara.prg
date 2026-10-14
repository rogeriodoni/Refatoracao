*==============================================================================
* ProbeTclMascara.prg - ERRO205b: Classe nao aceita mais de 1 digito.
* Mede o InputMask REAL do txt_4c_Classe ao longo do fluxo de INCLUIR.
*==============================================================================
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF

PUBLIC gb_4c_ModoTeste, gc_4c_ArquivoErroTeste
gb_4c_ModoTeste = .T.
gc_4c_ArquivoErroTeste = "C:\4c\automation\vfp_error_tclmask.txt"
IF FILE(gc_4c_ArquivoErroTeste)
    DELETE FILE (gc_4c_ArquivoErroTeste)
ENDIF

LOCAL loc_cRes, loc_oForm, loc_oC, loc_oN, loc_oErro
loc_cRes = ""

TRY
    CD C:\4c\projeto\app\start
    DO config.prg
    ConfigurarAmbiente()

    loc_oForm = CREATEOBJECT("FormTCL")

    IF VARTYPE(loc_oForm) != "O"
        loc_cRes = "FALHA: CREATEOBJECT devolveu nao-objeto"
    ELSE
        loc_oC = loc_oForm.pgf_4c_Paginas.Page2.txt_4c_Classe
        loc_oN = loc_oForm.pgf_4c_Paginas.Page2.txt_4c_Nivel

        loc_cRes = loc_cRes + "APOS Init          Classe.InputMask=[" + loc_oC.InputMask + "]" + ;
            " MaxLength=" + TRANSFORM(loc_oC.MaxLength) + ;
            " VARTYPE(Value)=" + VARTYPE(loc_oC.Value) + ;
            " LEN(Value)=" + TRANSFORM(LEN(TRANSFORM(loc_oC.Value))) + ;
            " | Nivel VARTYPE=" + VARTYPE(loc_oN.Value) + " Mask=[" + loc_oN.InputMask + "]" + CHR(13)+CHR(10)

        loc_oForm.BtnIncluirClick()
        loc_cRes = loc_cRes + "APOS BtnIncluir    Classe.InputMask=[" + loc_oC.InputMask + "]" + ;
            " LEN(Value)=" + TRANSFORM(LEN(TRANSFORM(loc_oC.Value))) + ;
            " Nivel.Value=" + TRANSFORM(loc_oN.Value) + CHR(13)+CHR(10)

        *-- Simula o usuario digitando o nivel e entrando no campo Classe
        LOCAL i
        FOR i = 0 TO 3
            loc_oN.Value = i
            loc_oForm.AjustarMascaraClasse()
            loc_cRes = loc_cRes + "Nivel=" + TRANSFORM(i) + " -> GotFocus Classe: InputMask=[" + ;
                loc_oC.InputMask + "] (digitos permitidos = " + TRANSFORM(LEN(loc_oC.InputMask)) + ")" + CHR(13)+CHR(10)
        ENDFOR

        loc_oForm.Release()
    ENDIF

CATCH TO loc_oErro
    loc_cRes = loc_cRes + "EXCECAO: " + loc_oErro.Message + " (linha " + TRANSFORM(loc_oErro.LineNo) + ;
        ", proc " + loc_oErro.Procedure + ")" + CHR(13)+CHR(10)
ENDTRY

STRTOFILE(loc_cRes, "C:\4c\automation\probe_tcl_mascara.txt")
QUIT

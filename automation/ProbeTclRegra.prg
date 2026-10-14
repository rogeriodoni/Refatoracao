*==============================================================================
* ProbeTclRegra.prg - ERRO205b: confere a regra '123' contra os dados reais
* e contra a mascara que o FormTCL aplica.
*==============================================================================
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF

PUBLIC gb_4c_ModoTeste, gc_4c_ArquivoErroTeste
gb_4c_ModoTeste = .T.
gc_4c_ArquivoErroTeste = "C:\4c\automation\vfp_error_tclregra.txt"
IF FILE(gc_4c_ArquivoErroTeste)
    DELETE FILE (gc_4c_ArquivoErroTeste)
ENDIF

LOCAL loc_cRes, loc_oForm, loc_oC, loc_oN, loc_nH, loc_nR, loc_nOk, loc_nFalha, i, loc_oErro
loc_cRes = ""

TRY
    CD C:\4c\projeto\app\start
    DO config.prg
    ConfigurarAmbiente()

    *-- 1) mascara do form por nivel
    loc_oForm = CREATEOBJECT("FormTCL")
    loc_oC = loc_oForm.pgf_4c_Paginas.Page2.txt_4c_Classe
    loc_oN = loc_oForm.pgf_4c_Paginas.Page2.txt_4c_Nivel
    loc_cRes = loc_cRes + "MASCARA DO FORM (apos a correcao):" + CHR(13)+CHR(10)
    FOR i = 1 TO 3
        loc_oN.Value = i
        loc_oForm.AjustarMascaraClasse()
        loc_cRes = loc_cRes + "  nivel " + TRANSFORM(i) + " -> InputMask=[" + loc_oC.InputMask + ;
            "] = " + TRANSFORM(LEN(loc_oC.InputMask)) + " digito(s)" + CHR(13)+CHR(10)
    ENDFOR
    loc_oForm.Release()

    *-- 2) a regra '123' aceita TODOS os registros existentes?
    loc_nH = SQLSTRINGCONNECT("Driver={SQL Server};Server=192.168.200.10;Database=DB_MBAHIA;Uid=4control;Pwd=f2016jstcr%@;")
    IF loc_nH <= 0
        loc_cRes = loc_cRes + CHR(13)+CHR(10) + "SEM CONEXAO para conferir os dados" + CHR(13)+CHR(10)
    ELSE
        loc_nR = SQLEXEC(loc_nH, "SELECT classes, nivels FROM SigCdCss ORDER BY classes", "cR")
        IF loc_nR > 0
            loc_nOk = 0
            loc_nFalha = 0
            loc_cRes = loc_cRes + CHR(13)+CHR(10) + "VALIDACAO DOS 24 REGISTROS REAIS:" + CHR(13)+CHR(10)
            SELECT cR
            SCAN
                LOCAL lcC, lnEsp
                lcC  = STRTRAN(ALLTRIM(cR.classes), " ", "")
                lnEsp = VAL(SUBSTR("123", INT(cR.nivels), 1))
                IF LEN(lcC) = lnEsp
                    loc_nOk = loc_nOk + 1
                ELSE
                    loc_nFalha = loc_nFalha + 1
                    loc_cRes = loc_cRes + "  RECUSADO: [" + lcC + "] nivel=" + TRANSFORM(cR.nivels) + ;
                        " len=" + TRANSFORM(LEN(lcC)) + " esperado=" + TRANSFORM(lnEsp) + CHR(13)+CHR(10)
                ENDIF
            ENDSCAN
            loc_cRes = loc_cRes + "  regra '123': aceitos=" + TRANSFORM(loc_nOk) + ;
                "  recusados=" + TRANSFORM(loc_nFalha) + CHR(13)+CHR(10)

            *-- comparativo com a regra antiga
            loc_nOk = 0
            loc_nFalha = 0
            SELECT cR
            SCAN
                lcC  = STRTRAN(ALLTRIM(cR.classes), " ", "")
                lnEsp = VAL(SUBSTR("124", INT(cR.nivels), 1))
                IF LEN(lcC) = lnEsp
                    loc_nOk = loc_nOk + 1
                ELSE
                    loc_nFalha = loc_nFalha + 1
                ENDIF
            ENDSCAN
            loc_cRes = loc_cRes + "  regra '124' (antes): aceitos=" + TRANSFORM(loc_nOk) + ;
                "  recusados=" + TRANSFORM(loc_nFalha) + CHR(13)+CHR(10)
        ENDIF
        =SQLDISCONNECT(loc_nH)
    ENDIF

CATCH TO loc_oErro
    loc_cRes = loc_cRes + "EXCECAO: " + loc_oErro.Message + " (linha " + TRANSFORM(loc_oErro.LineNo) + ")" + CHR(13)+CHR(10)
ENDTRY

STRTOFILE(loc_cRes, "C:\4c\automation\probe_tcl_regra.txt")
QUIT

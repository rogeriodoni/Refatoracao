SET SAFETY OFF
SET RESOURCE OFF
LOCAL loc_cRes
loc_cRes = ""

*-- Forma A: LOCAL com subscrito, misturado com escalares (como esta hoje
*-- em FormSIGPRIMP.CarregarListaArquivos / BtnMovEstClick)
TRY
    loc_cRes = loc_cRes + "A) LOCAL loc_aArq[1], escalares -> "
    loc_cRes = loc_cRes + TesteA() + CHR(13) + CHR(10)
CATCH TO loc_oE
    loc_cRes = loc_cRes + "ERRO: " + loc_oE.Message + CHR(13) + CHR(10)
ENDTRY

*-- Forma B: LOCAL ARRAY explicito (forma da licao de memoria)
TRY
    loc_cRes = loc_cRes + "B) LOCAL ARRAY loc_aArq[1]          -> "
    loc_cRes = loc_cRes + TesteB() + CHR(13) + CHR(10)
CATCH TO loc_oE
    loc_cRes = loc_cRes + "ERRO: " + loc_oE.Message + CHR(13) + CHR(10)
ENDTRY

*-- Forma C: LOCAL simples (sabidamente errada - controle da medicao)
TRY
    loc_cRes = loc_cRes + "C) LOCAL loc_aArq (sem subscrito)   -> "
    loc_cRes = loc_cRes + TesteC() + CHR(13) + CHR(10)
CATCH TO loc_oE
    loc_cRes = loc_cRes + "ERRO: " + loc_oE.Message + CHR(13) + CHR(10)
ENDTRY

STRTOFILE(loc_cRes, "C:\4c\automation\medir_fase8_localarray_result.txt")
QUIT

FUNCTION TesteA()
    LOCAL loc_aArq[1], loc_nArq, loc_nPrc
    loc_nArq = ADIR(loc_aArq, "C:\4c\automation\*.ps1")
    RETURN "OK ADIR=" + TRANSFORM(loc_nArq) + " TYPE=" + TYPE("loc_aArq") + ;
        " ALEN=" + TRANSFORM(ALEN(loc_aArq, 1))
ENDFUNC

FUNCTION TesteB()
    LOCAL ARRAY loc_aArq[1]
    LOCAL loc_nArq
    loc_nArq = ADIR(loc_aArq, "C:\4c\automation\*.ps1")
    RETURN "OK ADIR=" + TRANSFORM(loc_nArq) + " TYPE=" + TYPE("loc_aArq") + ;
        " ALEN=" + TRANSFORM(ALEN(loc_aArq, 1))
ENDFUNC

FUNCTION TesteC()
    LOCAL loc_aArq, loc_nArq
    loc_nArq = ADIR(loc_aArq, "C:\4c\automation\*.ps1")
    RETURN "OK ADIR=" + TRANSFORM(loc_nArq)
ENDFUNC

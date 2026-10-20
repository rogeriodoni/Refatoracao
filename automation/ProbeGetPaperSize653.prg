SET SAFETY OFF
SET RESOURCE OFF
CLOSE ALL
CLEAR ALL
LOCAL lcOut, loErr
lcOut = ""

*-- 1) GETPAPERSIZE existe como funcao nativa do VFP9?
TRY
    LOCAL lcTam
    lcTam = GETPAPERSIZE()
    lcOut = lcOut + "GETPAPERSIZE: OK tipo=" + VARTYPE(lcTam) + " val=[" + TRANSFORM(lcTam) + "]" + CHR(13) + CHR(10)
CATCH TO loErr
    lcOut = lcOut + "GETPAPERSIZE: ERRO " + TRANSFORM(loErr.ErrorNo) + " - " + loErr.Message + CHR(13) + CHR(10)
ENDTRY

*-- 2) APRINTERS/AFONT com destino LOCAL simples (bug suspeito) x LOCAL ARRAY
LOCAL lnQtd, laSimples
TRY
    lnQtd = APRINTERS(laSimples)
    lcOut = lcOut + "APRINTERS(LOCAL simples): OK qtd=" + TRANSFORM(lnQtd) + CHR(13) + CHR(10)
CATCH TO loErr
    lcOut = lcOut + "APRINTERS(LOCAL simples): ERRO " + TRANSFORM(loErr.ErrorNo) + " - " + loErr.Message + CHR(13) + CHR(10)
ENDTRY

LOCAL ARRAY laArr[1]
TRY
    lnQtd = APRINTERS(laArr)
    lcOut = lcOut + "APRINTERS(LOCAL ARRAY): OK qtd=" + TRANSFORM(lnQtd) + CHR(13) + CHR(10)
CATCH TO loErr
    lcOut = lcOut + "APRINTERS(LOCAL ARRAY): ERRO " + TRANSFORM(loErr.ErrorNo) + " - " + loErr.Message + CHR(13) + CHR(10)
ENDTRY

LOCAL laFontSimples
TRY
    lnQtd = AFONT(laFontSimples)
    lcOut = lcOut + "AFONT(LOCAL simples): OK qtd=" + TRANSFORM(lnQtd) + CHR(13) + CHR(10)
CATCH TO loErr
    lcOut = lcOut + "AFONT(LOCAL simples): ERRO " + TRANSFORM(loErr.ErrorNo) + " - " + loErr.Message + CHR(13) + CHR(10)
ENDTRY

LOCAL ARRAY laFontArr[1]
TRY
    lnQtd = AFONT(laFontArr)
    lcOut = lcOut + "AFONT(LOCAL ARRAY): OK qtd=" + TRANSFORM(lnQtd) + CHR(13) + CHR(10)
CATCH TO loErr
    lcOut = lcOut + "AFONT(LOCAL ARRAY): ERRO " + TRANSFORM(loErr.ErrorNo) + " - " + loErr.Message + CHR(13) + CHR(10)
ENDTRY

*-- 3) STR(256,10) - formato do fallback 'Personalizado' do legado
lcOut = lcOut + "STR(256,10)=[" + STR(256,10) + "] len=" + TRANSFORM(LEN(STR(256,10))) + CHR(13) + CHR(10)
lcOut = lcOut + "SUBSTR(STR(256,10)+'Personalizado',11)=[" + SUBSTR(STR(256,10)+"Personalizado",11) + "]" + CHR(13) + CHR(10)

STRTOFILE(lcOut, "C:\4c\automation\probe_getpapersize653.txt")
QUIT

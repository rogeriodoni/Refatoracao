*==============================================================================
* CompilarErro304Lote.prg - Compila todos os forms alterados no sweep do
* Erro304 e reporta QUALQUER .ERR gerado. Apaga o .FXP antes e CONFERE o
* timestamp depois (o COMPILE pode nao reescrever um .fxp existente).
*==============================================================================
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF

LOCAL lcLista, lnQtd, lnI, lcPrg, lcFxp, lcErr, lcOut, lnOk, lnErro, ltAntes
lcOut = "=== COMPILACAO EM LOTE - Erro304 ===" + CHR(13) + CHR(10)
lnOk = 0
lnErro = 0

lcLista = FILETOSTR("C:\4c\automation\_erro304_alterados.txt")
lnQtd = ALINES(laArq, lcLista)
lcOut = lcOut + "arquivos na lista: " + TRANSFORM(lnQtd) + CHR(13) + CHR(10)

FOR lnI = 1 TO lnQtd
    lcPrg = ALLTRIM(STRTRAN(laArq[lnI], "/", "\"))
    IF EMPTY(lcPrg)
        LOOP
    ENDIF
    lcPrg = "C:\4c\" + lcPrg
    IF !FILE(lcPrg)
        lcOut = lcOut + "  AUSENTE: " + lcPrg + CHR(13) + CHR(10)
        lnErro = lnErro + 1
        LOOP
    ENDIF
    lcFxp = STRTRAN(LOWER(lcPrg), ".prg", ".fxp")
    lcErr = STRTRAN(LOWER(lcPrg), ".prg", ".err")
    IF FILE(lcFxp)
        DELETE FILE (lcFxp)
    ENDIF
    IF FILE(lcErr)
        DELETE FILE (lcErr)
    ENDIF

    COMPILE (lcPrg)

    IF FILE(lcErr)
        lnErro = lnErro + 1
        lcOut = lcOut + "  ERRO em " + JUSTFNAME(lcPrg) + ":" + CHR(13) + CHR(10) + ;
                FILETOSTR(lcErr) + CHR(13) + CHR(10)
    ELSE
        IF FILE(lcFxp)
            lnOk = lnOk + 1
        ELSE
            lnErro = lnErro + 1
            lcOut = lcOut + "  SEM .FXP: " + JUSTFNAME(lcPrg) + CHR(13) + CHR(10)
        ENDIF
    ENDIF
ENDFOR

lcOut = lcOut + CHR(13) + CHR(10) + "compilados OK : " + TRANSFORM(lnOk) + CHR(13) + CHR(10)
lcOut = lcOut + "com problema  : " + TRANSFORM(lnErro) + CHR(13) + CHR(10)
STRTOFILE(lcOut, "C:\4c\automation\compilar_erro304_lote.txt")
QUIT

*==============================================================================
* compilar_sigregli.prg - Compila os arquivos da migracao task108
* Chamado por VFPExecutor.ps1
*==============================================================================

SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
SET NOTIFY OFF
SYS(2335, 0)

LOCAL loc_cLogFile, loc_cLog, loc_lErro
loc_cLogFile = "C:\4c\tasks\task108\logs\05c_validarCompilacao.log"
loc_cLog = ""
loc_lErro = .F.

PROCEDURE AppendLog(par_cMsg)
    ? par_cMsg
    loc_cLog = loc_cLog + TTOC(DATETIME()) + " " + par_cMsg + CHR(13) + CHR(10)
ENDPROC

AppendLog("=== VALIDACAO DE COMPILACAO - task108 ===")
AppendLog("")

*-- Lista de arquivos a compilar
LOCAL loc_aArquivos[2]
loc_aArquivos[1] = "C:\4c\projeto\app\classes\sigregliBO.prg"
loc_aArquivos[2] = "C:\4c\projeto\app\forms\operacionais\Formsigregli.prg"

LOCAL loc_i, loc_cArquivo, loc_cFxp, loc_cErr

FOR loc_i = 1 TO ALEN(loc_aArquivos)
    loc_cArquivo = loc_aArquivos[loc_i]
    loc_cFxp = FORCEEXT(loc_cArquivo, "fxp")
    loc_cErr = FORCEEXT(loc_cArquivo, "err")

    AppendLog("[" + TRANSFORM(loc_i) + "] " + JUSTFNAME(loc_cArquivo))

    IF !FILE(loc_cArquivo)
        AppendLog("    ERRO: Arquivo nao encontrado!")
        loc_lErro = .T.
        LOOP
    ENDIF

    *-- Remove FXP e ERR anteriores
    IF FILE(loc_cFxp)
        DELETE FILE (loc_cFxp)
    ENDIF
    IF FILE(loc_cErr)
        DELETE FILE (loc_cErr)
    ENDIF

    TRY
        COMPILE (loc_cArquivo)

        IF FILE(loc_cErr)
            LOCAL loc_cErroTxt
            loc_cErroTxt = FILETOSTR(loc_cErr)
            AppendLog("    ERRO DE COMPILACAO:")
            AppendLog("    " + LEFT(STRTRAN(loc_cErroTxt, CHR(13)+CHR(10), " | "), 300))
            loc_lErro = .T.
        ELSE
            AppendLog("    OK - Compilado com sucesso")
        ENDIF

    CATCH TO loEx
        AppendLog("    EXCECAO: " + loEx.Message)
        loc_lErro = .T.
    ENDTRY

    AppendLog("")
ENDFOR

AppendLog("=== RESULTADO ===")
IF loc_lErro
    AppendLog("STATUS: FALHOU - Erros de compilacao encontrados")
ELSE
    AppendLog("STATUS: SUCESSO - Todos os arquivos compilaram")
ENDIF

STRTOFILE(loc_cLog, loc_cLogFile)

QUIT

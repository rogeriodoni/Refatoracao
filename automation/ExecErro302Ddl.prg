*==============================================================================
* ExecErro302Ddl.prg - EXECUTA erro302_tabelas_ausentes.sql no DB_MBAHIA.
* Autorizado pelo usuario em 2026-11-04 ("pode rodar o script das 5 tabelas").
* O separador GO eh do SSMS, NAO eh T-SQL: o ODBC recebe um batch por vez.
* Depois confere as 5 no INFORMATION_SCHEMA e roda o SELECT que a tela faz.
* PROCEDURE no FIM; rotina de log nao se chama Log (colide com a nativa).
*==============================================================================
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF

PUBLIC gcL302X
gcL302X = "C:\4c\automation\exec_erro302.txt"
STRTOFILE("A: inicio " + TRANSFORM(DATETIME()) + CHR(13) + CHR(10), gcL302X)

LOCAL loc_cConn, loc_nH, loc_oE, loc_cSql, loc_nI, loc_nLin, loc_cLinha
LOCAL loc_cBatch, loc_nOk, loc_nErr, loc_cTab, loc_nR

=SQLSETPROP(0, "ConnectTimeOut", 15)
=SQLSETPROP(0, "DispLogin", 3)
=SQLSETPROP(0, "DispWarnings", .F.)

loc_cConn = "DRIVER={SQL Server};SERVER=192.168.200.10;DATABASE=DB_MBAHIA;" + ;
            "UID=4control;PWD=f2016jstcr%@;"

DIMENSION laTab[5]
laTab[1] = "SigCdOcs"
laTab[2] = "SigCdCcp"
laTab[3] = "SigCdCmp"
laTab[4] = "SigCdCrf"
laTab[5] = "SigCdCri"

TRY
    loc_cSql = FILETOSTR("C:\4c\automation\erro302_tabelas_ausentes.sql")
    LogP302X("B: script lido, " + TRANSFORM(LEN(loc_cSql)) + " bytes")

    loc_nH = SQLSTRINGCONNECT(loc_cConn)
    LogP302X("C: handle = " + TRANSFORM(loc_nH))

    IF loc_nH <= 0
        LogP302X("   SEM CONEXAO - nada executado")
    ELSE
        *-- estado ANTES
        LogP302X("D: --- ANTES ---")
        FOR loc_nI = 1 TO 5
            LogP302X("   " + PADR(laTab[loc_nI], 10) + " existe=" + ;
                     TRANSFORM(ExisteTab(loc_nH, laTab[loc_nI])))
        ENDFOR

        *-- quebra por GO e executa batch a batch
        loc_nOk    = 0
        loc_nErr   = 0
        loc_cBatch = ""
        loc_nLin   = ALINES(laLinha, loc_cSql)
        LogP302X("E: --- EXECUTANDO (" + TRANSFORM(loc_nLin) + " linhas) ---")

        FOR loc_nI = 1 TO loc_nLin
            loc_cLinha = laLinha[loc_nI]
            IF UPPER(ALLTRIM(loc_cLinha)) == "GO"
                IF !EMPTY(ALLTRIM(CHRTRAN(loc_cBatch, CHR(13) + CHR(10) + CHR(9), "")))
                    loc_nR = SQLEXEC(loc_nH, loc_cBatch)
                    IF loc_nR < 0
                        loc_nErr = loc_nErr + 1
                        LogP302X("   BATCH ERRO: " + ErroSQL())
                        LogP302X("     inicio do batch: " + LEFT(ALLTRIM(STRTRAN(loc_cBatch, CHR(13), " ")), 70))
                    ELSE
                        loc_nOk = loc_nOk + 1
                        LogP302X("   batch OK (" + TRANSFORM(loc_nR) + "): " + ;
                                 LEFT(ALLTRIM(STRTRAN(STRTRAN(loc_cBatch, CHR(13), " "), CHR(10), "")), 60))
                    ENDIF
                ENDIF
                loc_cBatch = ""
            ELSE
                loc_cBatch = loc_cBatch + loc_cLinha + CHR(13) + CHR(10)
            ENDIF
        ENDFOR
        *-- sobra sem GO final
        IF !EMPTY(ALLTRIM(CHRTRAN(loc_cBatch, CHR(13) + CHR(10) + CHR(9), "")))
            loc_nR = SQLEXEC(loc_nH, loc_cBatch)
            IF loc_nR < 0
                loc_nErr = loc_nErr + 1
                LogP302X("   BATCH FINAL ERRO: " + ErroSQL())
            ELSE
                loc_nOk = loc_nOk + 1
            ENDIF
        ENDIF
        LogP302X("F: batches OK=" + TRANSFORM(loc_nOk) + "  ERRO=" + TRANSFORM(loc_nErr))

        *-- estado DEPOIS
        LogP302X("G: --- DEPOIS ---")
        FOR loc_nI = 1 TO 5
            LogP302X("   " + PADR(laTab[loc_nI], 10) + " existe=" + ;
                     TRANSFORM(ExisteTab(loc_nH, laTab[loc_nI])))
        ENDFOR

        *-- o SELECT exato que a tela do Erro302 faz
        loc_nR = SQLEXEC(loc_nH, "SELECT cods, descs FROM SigCdOcs ORDER BY cods", "cur_tela")
        LogP302X("H: SELECT da tela -> resultado=" + TRANSFORM(loc_nR) + ;
                 IIF(loc_nR < 0, "  ERRO: " + ErroSQL(), ;
                     "  OK, linhas=" + TRANSFORM(IIF(USED("cur_tela"), RECCOUNT("cur_tela"), -1))))

        *-- e as outras 4, cada uma com o SELECT do seu BO
        loc_nR = SQLEXEC(loc_nH, "SELECT cods, descs FROM SigCdCmp", "cur_t2")
        LogP302X("I: SigCdCmp -> " + TRANSFORM(loc_nR) + IIF(loc_nR < 0, " ERRO: " + ErroSQL(), " OK"))
        loc_nR = SQLEXEC(loc_nH, "SELECT cidchaves, codigo FROM SigCdCcp", "cur_t3")
        LogP302X("   SigCdCcp -> " + TRANSFORM(loc_nR) + IIF(loc_nR < 0, " ERRO: " + ErroSQL(), " OK"))
        loc_nR = SQLEXEC(loc_nH, "SELECT cidchaves, cods FROM SigCdCrf", "cur_t4")
        LogP302X("   SigCdCrf -> " + TRANSFORM(loc_nR) + IIF(loc_nR < 0, " ERRO: " + ErroSQL(), " OK"))
        loc_nR = SQLEXEC(loc_nH, "SELECT cidchaves, cods FROM SigCdCri", "cur_t5")
        LogP302X("   SigCdCri -> " + TRANSFORM(loc_nR) + IIF(loc_nR < 0, " ERRO: " + ErroSQL(), " OK"))

        =SQLDISCONNECT(loc_nH)
        LogP302X("J: desconectado")
    ENDIF

CATCH TO loc_oE
    STRTOFILE("EXCEPTION: " + loc_oE.Message + " | Linha:" + TRANSFORM(loc_oE.LineNo) + ;
              CHR(13) + CHR(10), gcL302X, 1)
ENDTRY

STRTOFILE("Z: fim" + CHR(13) + CHR(10), gcL302X, 1)
QUIT

PROCEDURE LogP302X(par_cTexto)
    STRTOFILE(par_cTexto + CHR(13) + CHR(10), gcL302X, 1)
ENDPROC

FUNCTION ExisteTab(par_nH, par_cTab)
    LOCAL lnR, llEx
    llEx = .F.
    lnR = SQLEXEC(par_nH, "SELECT COUNT(*) AS n FROM INFORMATION_SCHEMA.TABLES" + ;
                  " WHERE TABLE_NAME = '" + par_cTab + "'", "cur_ex")
    IF lnR > 0 AND USED("cur_ex") AND RECCOUNT("cur_ex") > 0
        llEx = (cur_ex.n > 0)
    ENDIF
    IF USED("cur_ex")
        USE IN cur_ex
    ENDIF
    RETURN llEx
ENDFUNC

FUNCTION ErroSQL()
    LOCAL ARRAY laE[1]
    LOCAL lcR
    lcR = ""
    IF AERROR(laE) > 0
        lcR = TRANSFORM(laE[1]) + " - " + ALLTRIM(TRANSFORM(laE[2]))
    ENDIF
    RETURN lcR
ENDFUNC

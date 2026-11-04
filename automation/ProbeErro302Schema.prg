*==============================================================================
* ProbeErro302Schema.prg - Pergunta ao BANCO (nao ao schema.sql) se a tabela
* SigCdOcs existe. Regra #14 passo 3: se existe no schema canonico E o legado
* usa o mesmo nome, a divergencia eh de BANCO/ambiente - e so o banco responde.
* As PROCEDURE ficam no FIM (em .prg o main termina na primeira delas) e a
* rotina de log NAO se chama Log (colide com a funcao nativa LOG do VFP).
*==============================================================================
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF

PUBLIC gcL302
gcL302 = "C:\4c\automation\probe_erro302_schema.txt"
STRTOFILE("A: inicio" + CHR(13) + CHR(10), gcL302)

LOCAL loc_cConn, loc_nH, loc_nR, loc_cSQL, loc_oE, loc_nI

=SQLSETPROP(0, "ConnectTimeOut", 15)
=SQLSETPROP(0, "DispLogin", 3)
=SQLSETPROP(0, "DispWarnings", .F.)

loc_cConn = "DRIVER={SQL Server};SERVER=192.168.200.10;DATABASE=DB_MBAHIA;" + ;
            "UID=4control;PWD=f2016jstcr%@;"

TRY
    LogP302("B: conectando...")
    loc_nH = SQLSTRINGCONNECT(loc_cConn)
    LogP302("C: handle = " + TRANSFORM(loc_nH))

    IF loc_nH <= 0
        LogP302("   SEM CONEXAO - nao da para consultar o banco desta maquina")
    ELSE
        *-- 1) a tabela existe?
        loc_cSQL = "SELECT TABLE_SCHEMA, TABLE_NAME FROM INFORMATION_SCHEMA.TABLES" + ;
                   " WHERE TABLE_NAME = 'SigCdOcs'"
        loc_nR = SQLEXEC(loc_nH, loc_cSQL, "cur_t")
        LogP302("D: INFORMATION_SCHEMA.TABLES TABLE_NAME='SigCdOcs' -> resultado=" + ;
                TRANSFORM(loc_nR) + " linhas=" + ;
                TRANSFORM(IIF(USED("cur_t"), RECCOUNT("cur_t"), -1)))
        IF USED("cur_t") AND RECCOUNT("cur_t") > 0
            SELECT cur_t
            SCAN
                LogP302("   achou: [" + ALLTRIM(cur_t.TABLE_SCHEMA) + "].[" + ;
                        ALLTRIM(cur_t.TABLE_NAME) + "]")
            ENDSCAN
        ENDIF

        *-- 2) existe algo parecido? (LIKE)
        loc_cSQL = "SELECT TABLE_NAME FROM INFORMATION_SCHEMA.TABLES" + ;
                   " WHERE TABLE_NAME LIKE 'SigCdO%' ORDER BY TABLE_NAME"
        loc_nR = SQLEXEC(loc_nH, loc_cSQL, "cur_p")
        LogP302("E: tabelas LIKE 'SigCdO%' -> " + ;
                TRANSFORM(IIF(USED("cur_p"), RECCOUNT("cur_p"), -1)) + " linhas")
        IF USED("cur_p")
            SELECT cur_p
            SCAN
                LogP302("   " + ALLTRIM(cur_p.TABLE_NAME))
            ENDSCAN
        ENDIF

        *-- 3) collation do banco (identificador case-sensitive?)
        loc_nR = SQLEXEC(loc_nH, "SELECT DATABASEPROPERTYEX('DB_MBAHIA','Collation') AS col", "cur_c")
        IF USED("cur_c") AND RECCOUNT("cur_c") > 0
            SELECT cur_c
            LogP302("F: collation do banco = [" + ALLTRIM(TRANSFORM(cur_c.col)) + "]")
        ENDIF

        *-- 4) o SELECT que a tela faz
        loc_nR = SQLEXEC(loc_nH, "SELECT cods, descs FROM SigCdOcs ORDER BY cods", "cur_d")
        LogP302("G: o SELECT da tela -> resultado=" + TRANSFORM(loc_nR) + ;
                IIF(loc_nR < 0, "  erro: " + CapturarErroSimples(), ;
                    "  linhas=" + TRANSFORM(IIF(USED("cur_d"), RECCOUNT("cur_d"), -1))))

        =SQLDISCONNECT(loc_nH)
        LogP302("H: desconectado")
    ENDIF

CATCH TO loc_oE
    STRTOFILE("EXCEPTION: " + loc_oE.Message + " | Linha:" + TRANSFORM(loc_oE.LineNo) + ;
              CHR(13) + CHR(10), gcL302, 1)
ENDTRY

STRTOFILE("Z: fim" + CHR(13) + CHR(10), gcL302, 1)
QUIT

PROCEDURE LogP302(par_cTexto)
    STRTOFILE(par_cTexto + CHR(13) + CHR(10), gcL302, 1)
ENDPROC

FUNCTION CapturarErroSimples()
    LOCAL ARRAY laErr[1]
    LOCAL lcR
    lcR = ""
    IF AERROR(laErr) > 0
        lcR = TRANSFORM(laErr[1]) + " - " + TRANSFORM(laErr[2])
    ENDIF
    RETURN lcR
ENDFUNC

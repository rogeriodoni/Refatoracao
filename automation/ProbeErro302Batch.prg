*==============================================================================
* ProbeErro302Batch.prg - Dumpa o batch que o ExecErro302Ddl monta, para
* comparar com o bloco que funcionou no teste isolado.
*==============================================================================
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF

LOCAL lcSql, lnLin, lnI, lcLinha, lcBatch, lnB, lcOut
lcOut = ""
lcSql = FILETOSTR("C:\4c\automation\erro302_tabelas_ausentes.sql")
lcOut = lcOut + "tamanho do arquivo: " + TRANSFORM(LEN(lcSql)) + CHR(13) + CHR(10)
lcOut = lcOut + "primeiros 8 bytes (hex): "
FOR lnI = 1 TO 8
    lcOut = lcOut + RIGHT("0" + TRANSFORM(ASC(SUBSTR(lcSql, lnI, 1)), "@0"), 2) + " "
ENDFOR
lcOut = lcOut + CHR(13) + CHR(10)

lnLin = ALINES(laLinha, lcSql)
lcOut = lcOut + "ALINES devolveu " + TRANSFORM(lnLin) + " linhas" + CHR(13) + CHR(10)

lcBatch = ""
lnB = 0
FOR lnI = 1 TO lnLin
    lcLinha = laLinha[lnI]
    IF UPPER(ALLTRIM(lcLinha)) == "GO"
        lnB = lnB + 1
        IF lnB = 2
            lcOut = lcOut + CHR(13) + CHR(10) + ">>> BATCH 2, " + ;
                    TRANSFORM(LEN(lcBatch)) + " bytes <<<" + CHR(13) + CHR(10) + ;
                    lcBatch + CHR(13) + CHR(10) + ">>> FIM BATCH 2 <<<" + CHR(13) + CHR(10)
            *-- bytes nao-ASCII?
            LOCAL lnJ, lnNao
            lnNao = 0
            FOR lnJ = 1 TO LEN(lcBatch)
                IF ASC(SUBSTR(lcBatch, lnJ, 1)) > 126 OR ;
                   (ASC(SUBSTR(lcBatch, lnJ, 1)) < 32 AND ;
                    !INLIST(ASC(SUBSTR(lcBatch, lnJ, 1)), 9, 10, 13))
                    lnNao = lnNao + 1
                    IF lnNao <= 5
                        lcOut = lcOut + "  byte estranho pos " + TRANSFORM(lnJ) + " = " + ;
                                TRANSFORM(ASC(SUBSTR(lcBatch, lnJ, 1))) + CHR(13) + CHR(10)
                    ENDIF
                ENDIF
            ENDFOR
            lcOut = lcOut + "  bytes fora de ASCII imprimivel: " + TRANSFORM(lnNao) + CHR(13) + CHR(10)
        ENDIF
        lcBatch = ""
    ELSE
        lcBatch = lcBatch + lcLinha + CHR(13) + CHR(10)
    ENDIF
ENDFOR

STRTOFILE(lcOut, "C:\4c\automation\probe_erro302_batch.txt")
QUIT

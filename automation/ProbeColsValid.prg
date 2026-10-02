SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
PUBLIC gnConnHandle
#DEFINE OUT "C:\4c\automation\probe_colsvalid.txt"
LOCAL loc_oE, loc_n, loc_i
LOCAL ARRAY laT[6], laC[6]
laT[1]="SIGCDGRP"
laC[1]="grctobccs,obrpesoms,obrservico,obrconjuts,localobrig,vldconjuts,nchkpess,fornecs,omoecs,omoecusfs,omoedas,omoevs,pcuss,fcustos,custofs,pmargems,pvideals,markupa,pvens,servprds,chkforcomp,obrigfiscs,cfggergprs"
laT[2]="SIGCDPAM"
laC[2]="prvendas,codprods,gesind"
laT[3]="SIGCDCLS"
laC[3]="cods,situas"
laT[4]="SIGCDCLF"
laC[4]="codigos,aipis,ipiprods"
laT[5]="SIGCDMOE"
laC[5]="cmoes"
laT[6]="SIGCDPRO"
laC[6]="ean13,conjunts,locals,gruccus,contaccus,pesoms,pmedio,cunis,cunips,ifors,pvens,moevs,fvendas,moepvs,valors,moedas,aliqipis,extipi,clfiscals,cclass,situas,prodwebs,obscompras,obsmkt,dpro3s,codcors,colecoes,categoria,pcuss,fcustos,custofs,margems,pvideals,markupa"
STRTOFILE("inicio" + CHR(13) + CHR(10), OUT)
TRY
    CD C:\4c\projeto\app\start
    DO config.prg
    SET PROCEDURE TO (gcCaminhoUtils + "functions.prg") ADDITIVE
    gnConnHandle = SQLSTRINGCONNECT(ObterStringConexao())
    FOR loc_i = 1 TO ALEN(laT)
        STRTOFILE(CHR(13) + CHR(10) + "=== " + laT[loc_i] + " ===" + CHR(13) + CHR(10), OUT, 1)
        loc_n = SQLEXEC(gnConnHandle, ;
            "SELECT COLUMN_NAME, DATA_TYPE, CHARACTER_MAXIMUM_LENGTH AS CLEN" + ;
            " FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = '" + laT[loc_i] + "'" + ;
            " AND COLUMN_NAME IN ('" + STRTRAN(laC[loc_i], ",", "','") + "')" + ;
            " ORDER BY COLUMN_NAME", "crX")
        IF loc_n > 0 AND USED("crX")
            SELECT crX
            SCAN
                STRTOFILE("  " + PADR(ALLTRIM(crX.COLUMN_NAME), 14) + " " + ;
                    PADR(ALLTRIM(crX.DATA_TYPE), 10) + " len=" + ;
                    TRANSFORM(NVL(crX.CLEN, -1)) + CHR(13) + CHR(10), OUT, 1)
            ENDSCAN
            *-- as que NAO existem
            FOR loc_j = 1 TO OCCURS(",", laC[loc_i]) + 1
                loc_cCol = ALLTRIM(GETWORDNUM(STRTRAN(laC[loc_i], ",", " "), loc_j))
                IF !EMPTY(loc_cCol)
                    SELECT crX
                    LOCATE FOR UPPER(ALLTRIM(COLUMN_NAME)) == UPPER(loc_cCol)
                    IF !FOUND()
                        STRTOFILE("  *** NAO EXISTE: " + loc_cCol + CHR(13) + CHR(10), OUT, 1)
                    ENDIF
                ENDIF
            ENDFOR
        ELSE
            STRTOFILE("  ERRO na consulta" + CHR(13) + CHR(10), OUT, 1)
        ENDIF
    ENDFOR
    *-- tabelas de movimentacao usadas na EXCLUSAO
    FOR loc_i = 1 TO 3
        loc_cT = IIF(loc_i = 1, "SIGMVITN", IIF(loc_i = 2, "SIGMVHST", "SIGPRCPO"))
        loc_n = SQLEXEC(gnConnHandle, ;
            "SELECT COUNT(*) AS qtd FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = '" + ;
            loc_cT + "'", "crT")
        STRTOFILE("tabela " + PADR(loc_cT, 10) + " existe=" + ;
            TRANSFORM(IIF(USED("crT"), crT.qtd, -1)) + CHR(13) + CHR(10), OUT, 1)
    ENDFOR
CATCH TO loc_oE
    STRTOFILE("EXCEPTION: " + loc_oE.Message + CHR(13) + CHR(10), OUT, 1)
ENDTRY
STRTOFILE("fim" + CHR(13) + CHR(10), OUT, 1)
QUIT

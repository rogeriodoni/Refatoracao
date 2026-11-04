SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
PUBLIC gcL
gcL = "C:\4c\automation\probe_erro307_tipo.txt"
STRTOFILE("A: inicio" + CHR(13) + CHR(10), gcL)
LOCAL loc_nH, loc_oE
=SQLSETPROP(0, "ConnectTimeOut", 15)
=SQLSETPROP(0, "DispLogin", 3)
=SQLSETPROP(0, "DispWarnings", .F.)
TRY
    loc_nH = SQLSTRINGCONNECT("DRIVER={SQL Server};SERVER=192.168.200.10;DATABASE=DB_MBAHIA;UID=4control;PWD=f2016jstcr%@;")
    LG("B: handle = " + TRANSFORM(loc_nH))
    IF loc_nH > 0
        IF SQLEXEC(loc_nH, "SELECT COLUMN_NAME, DATA_TYPE," + ;
            " ISNULL(CAST(CHARACTER_MAXIMUM_LENGTH AS int),-1) AS tam," + ;
            " ISNULL(CAST(NUMERIC_PRECISION AS int),-1) AS prec" + ;
            " FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME='SigCdTom'" + ;
            " ORDER BY ORDINAL_POSITION", "cur_d") > 0
            LG("C: colunas de SigCdTom:")
            SELECT cur_d
            SCAN
                LG("   " + PADR(ALLTRIM(cur_d.COLUMN_NAME), 14) + ;
                   PADR(ALLTRIM(cur_d.DATA_TYPE), 10) + ;
                   " tam=" + TRANSFORM(cur_d.tam) + " prec=" + TRANSFORM(cur_d.prec))
            ENDSCAN
            USE IN cur_d
        ENDIF
        *-- como o VFP recebe essas colunas
        IF SQLEXEC(loc_nH, "SELECT TOP 3 Codigos, Descrs FROM SigCdTom ORDER BY Codigos", "cur_v") > 0
            SELECT cur_v
            LG("D: no cursor VFP -> VARTYPE(Codigos)=" + VARTYPE(cur_v.Codigos) + ;
               "  VARTYPE(Descrs)=" + VARTYPE(cur_v.Descrs))
            LG("   valor bruto de Codigos = [" + TRANSFORM(cur_v.Codigos) + "]")
            *-- PADL funciona com esse tipo?
            TRY
                LG("   PADL(Codigos,2,'0') = [" + PADL(cur_v.Codigos, 2, "0") + "]")
            CATCH TO loc_oE
                LG("   PADL direto -> ERRO: " + loc_oE.Message)
            ENDTRY
            TRY
                LG("   PADL(TRANSFORM(Codigos),2,'0') = [" + PADL(TRANSFORM(cur_v.Codigos), 2, "0") + "]")
            CATCH TO loc_oE
                LG("   PADL(TRANSFORM) -> ERRO: " + loc_oE.Message)
            ENDTRY
            *-- comparar numeric com Codigos estoura?
            TRY
                LG("   (0 = Codigos) -> " + TRANSFORM(0 = cur_v.Codigos))
            CATCH TO loc_oE
                LG("   (0 = Codigos) -> ERRO: " + loc_oE.Message)
            ENDTRY
            USE IN cur_v
        ENDIF
        =SQLDISCONNECT(loc_nH)
    ENDIF
CATCH TO loc_oE
    LG("EXCEPTION: " + loc_oE.Message)
ENDTRY
STRTOFILE("Z: fim" + CHR(13) + CHR(10), gcL, 1)
QUIT
PROCEDURE LG(par_c)
    STRTOFILE(par_c + CHR(13) + CHR(10), gcL, 1)
ENDPROC

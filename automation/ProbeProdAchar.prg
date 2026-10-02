SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
PUBLIC gnConnHandle
#DEFINE OUT "C:\4c\automation\probe_prodachar.txt"
LOCAL loc_oE, loc_n
STRTOFILE("inicio" + CHR(13)+CHR(10), OUT)
TRY
    CD C:\4c\projeto\app\start
    DO config.prg
    SET PROCEDURE TO (gcCaminhoUtils + "functions.prg") ADDITIVE
    gnConnHandle = SQLSTRINGCONNECT(ObterStringConexao())
    loc_n = SQLEXEC(gnConnHandle, ;
        "SELECT TOP 5 cpros, qmins, pesobs, pesoms, categoria, codcors, codtams," + ;
        " prodwebs, encoms, segmasc, prodnovo, LTRIM(RTRIM(lancamento)) AS lanc," + ;
        " LTRIM(RTRIM(obsmkt)) AS mkt, dtsituas" + ;
        " FROM SigCdPro" + ;
        " WHERE qmins <> 0 OR pesobs <> 0 OR pesoms <> 0 OR prodwebs <> 0" + ;
        "    OR encoms <> 0 OR segmasc <> 0 OR prodnovo <> 0" + ;
        "    OR LTRIM(RTRIM(lancamento)) <> '' OR LTRIM(RTRIM(categoria)) <> ''" + ;
        " ORDER BY cpros", "crA")
    STRTOFILE("SQLEXEC=" + TRANSFORM(loc_n) + " linhas=" + ;
        TRANSFORM(IIF(USED("crA"), RECCOUNT("crA"), -1)) + CHR(13)+CHR(10), OUT, 1)
    IF USED("crA")
        SELECT crA
        SCAN
            STRTOFILE("cpros=[" + ALLTRIM(crA.cpros) + "] qmins=" + TRANSFORM(crA.qmins) + ;
                " pesobs=" + TRANSFORM(crA.pesobs) + " pesoms=" + TRANSFORM(crA.pesoms) + ;
                " cat=[" + ALLTRIM(NVL(crA.categoria,"")) + "] cor=[" + ALLTRIM(NVL(crA.codcors,"")) + ;
                "] tam=[" + ALLTRIM(NVL(crA.codtams,"")) + "] web=" + TRANSFORM(crA.prodwebs) + ;
                " enc=" + TRANSFORM(crA.encoms) + " masc=" + TRANSFORM(crA.segmasc) + ;
                " novo=" + TRANSFORM(crA.prodnovo) + " lanc=[" + ALLTRIM(NVL(crA.lanc,"")) + ;
                "] mkt=[" + ALLTRIM(NVL(crA.mkt,"")) + "]" + CHR(13)+CHR(10), OUT, 1)
        ENDSCAN
    ENDIF
CATCH TO loc_oE
    STRTOFILE("EXCEPTION: " + loc_oE.Message + CHR(13)+CHR(10), OUT, 1)
ENDTRY
STRTOFILE("fim" + CHR(13)+CHR(10), OUT, 1)
QUIT

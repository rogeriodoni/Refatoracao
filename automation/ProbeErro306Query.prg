*==============================================================================
* ProbeErro306Query.prg - Roda contra o BANCO as queries do OpsBO.Buscar
* ANTES (NVL) e DEPOIS (ISNULL) do conserto. So leitura.
*==============================================================================
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
PUBLIC gcL306Q
gcL306Q = "C:\4c\automation\probe_erro306_query.txt"
STRTOFILE("A: inicio" + CHR(13) + CHR(10), gcL306Q)
LOCAL loc_cConn, loc_nH, loc_oE, lcBase, lcAntes, lcDepois
=SQLSETPROP(0, "ConnectTimeOut", 15)
=SQLSETPROP(0, "DispLogin", 3)
=SQLSETPROP(0, "DispWarnings", .F.)
loc_cConn = "DRIVER={SQL Server};SERVER=192.168.200.10;DATABASE=DB_MBAHIA;UID=4control;PWD=f2016jstcr%@;"

lcBase = "SELECT a.Dopes, a.NDopes, a.Abrevs, a.CMoes," + ;
    " a.Nivels, a.Menus, a.SubMenus, a.Ordes, a.TipoOps," + ;
    " LEFT(RIGHT(d.ConfigGers, 89), 30) AS DopMenus," + ;
    " @FN@(b.OpeInatvs, 0) AS Inativas" + ;
    " FROM SigCdOpe a" + ;
    " LEFT JOIN SigOpCdc b ON b.Dopes = a.Dopes" + ;
    " LEFT JOIN SigOpCdd d ON d.Dopes = a.Dopes" + ;
    " ORDER BY a.Dopes"

TRY
    loc_nH = SQLSTRINGCONNECT(loc_cConn)
    L306Q("B: handle = " + TRANSFORM(loc_nH))
    IF loc_nH > 0
        lcAntes  = STRTRAN(lcBase, "@FN@", "NVL")
        lcDepois = STRTRAN(lcBase, "@FN@", "ISNULL")

        Q306(loc_nH, "ANTES  (NVL)   ", lcAntes)
        Q306(loc_nH, "DEPOIS (ISNULL)", lcDepois)

        *-- e os dois filtros do DO CASE
        Q306(loc_nH, "filtro ATIVO   ", ;
             STRTRAN(STRTRAN(lcBase, "@FN@", "ISNULL"), " ORDER BY a.Dopes", ;
                     " WHERE ISNULL(b.OpeInatvs, 0) = 0 ORDER BY a.Dopes"))
        Q306(loc_nH, "filtro INATIVO ", ;
             STRTRAN(STRTRAN(lcBase, "@FN@", "ISNULL"), " ORDER BY a.Dopes", ;
                     " WHERE ISNULL(b.OpeInatvs, 0) = 1 ORDER BY a.Dopes"))

        *-- e o CarregarPorCodigo
        Q306(loc_nH, "CarregarPorCod ", ;
             "SELECT a.Dopes, a.NDopes, a.TitOpes, a.Menus, a.SubMenus," + ;
             " a.Ordes, a.CMoes, a.Copers, a.ObsOpes, a.TipoOps," + ;
             " a.Abrevs, a.Nivels, a.NFiscals," + ;
             " ISNULL(b.OpeInatvs, 0) AS OpeInatvs" + ;
             " FROM SigCdOpe a" + ;
             " LEFT JOIN SigOpCdc b ON b.Dopes = a.Dopes" + ;
             " WHERE a.Dopes = '001'")

        =SQLDISCONNECT(loc_nH)
    ENDIF
CATCH TO loc_oE
    L306Q("EXCEPTION: " + loc_oE.Message)
ENDTRY
STRTOFILE("Z: fim" + CHR(13) + CHR(10), gcL306Q, 1)
QUIT

PROCEDURE L306Q(par_c)
    STRTOFILE(par_c + CHR(13) + CHR(10), gcL306Q, 1)
ENDPROC

PROCEDURE Q306(par_nH, par_cNome, par_cSql)
    LOCAL lnR, lcM
    lnR = SQLEXEC(par_nH, par_cSql, "cur_q")
    IF lnR < 0
        LOCAL ARRAY laE[1]
        lcM = "ERRO: "
        IF AERROR(laE) > 0
            lcM = lcM + ALLTRIM(TRANSFORM(laE[2]))
        ENDIF
    ELSE
        lcM = "OK   linhas=" + TRANSFORM(IIF(USED("cur_q"), RECCOUNT("cur_q"), -1))
    ENDIF
    L306Q("   " + par_cNome + " -> " + lcM)
    IF USED("cur_q")
        USE IN cur_q
    ENDIF
ENDPROC

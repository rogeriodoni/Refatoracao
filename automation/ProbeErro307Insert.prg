*==============================================================================
* ProbeErro307Insert.prg - Testa o INSERT completo de SigCdOpe contra o BANCO,
* dentro de BEGIN TRANSACTION / ROLLBACK: valida que as 248 colunas obrigatorias
* sao aceitas SEM gravar nada de verdade.
* Tambem roda o INSERT ANTIGO (13 colunas) para reproduzir o erro reportado.
*==============================================================================
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
PUBLIC gcL307I
gcL307I = "C:\4c\automation\probe_erro307_insert.txt"
STRTOFILE("A: inicio" + CHR(13) + CHR(10), gcL307I)
LOCAL loc_cConn, loc_nH, loc_oE, lcSql, lnAntes, lnDepois
=SQLSETPROP(0, "ConnectTimeOut", 15)
=SQLSETPROP(0, "DispLogin", 3)
=SQLSETPROP(0, "DispWarnings", .F.)
loc_cConn = "DRIVER={SQL Server};SERVER=192.168.200.10;DATABASE=DB_MBAHIA;UID=4control;PWD=f2016jstcr%@;"
TRY
    loc_nH = SQLSTRINGCONNECT(loc_cConn)
    L307I("B: handle = " + TRANSFORM(loc_nH))
    IF loc_nH > 0
        *-- quantas linhas tem a tabela ANTES (prova de que nada foi gravado)
        lnAntes = Conta(loc_nH)
        L307I("C: SigCdOpe tem " + TRANSFORM(lnAntes) + " linhas ANTES")

        *-- 1) o INSERT ANTIGO (13 colunas) - tem de FALHAR como na tela
        lcSql = "BEGIN TRANSACTION;" + ;
            " INSERT INTO SigCdOpe (Dopes, NDopes, TitOpes, Menus, SubMenus," + ;
            " Ordes, CMoes, Copers, ObsOpes, TipoOps, Abrevs, Nivels, NFiscals)" + ;
            " VALUES ('ZZTESTE', 0, 'TESTE', '', '', 0, '', 0, '', 0, '', '', 0);" + ;
            " ROLLBACK TRANSACTION;"
        T307I(loc_nH, "INSERT ANTIGO (13 col)", lcSql)

        *-- 2) o INSERT NOVO (248 colunas) - tem de PASSAR
        lcSql = FILETOSTR("C:\4c\automation\_erro307_teste.sql")
        T307I(loc_nH, "INSERT NOVO (248 col)", lcSql)

        lnDepois = Conta(loc_nH)
        L307I("D: SigCdOpe tem " + TRANSFORM(lnDepois) + " linhas DEPOIS" + ;
              "   -> nada gravado? " + TRANSFORM(lnAntes = lnDepois))

        *-- 3) a linha de teste nao ficou no banco?
        IF SQLEXEC(loc_nH, "SELECT COUNT(*) AS n FROM SigCdOpe WHERE Dopes = 'ZZTESTE'", "cur_z") > 0
            SELECT cur_z
            L307I("E: linhas com Dopes='ZZTESTE' no banco = " + TRANSFORM(cur_z.n) + ;
                  "  (tem de ser 0)")
            USE IN cur_z
        ENDIF
        =SQLDISCONNECT(loc_nH)
    ENDIF
CATCH TO loc_oE
    L307I("EXCEPTION: " + loc_oE.Message)
ENDTRY
STRTOFILE("Z: fim" + CHR(13) + CHR(10), gcL307I, 1)
QUIT

PROCEDURE L307I(par_c)
    STRTOFILE(par_c + CHR(13) + CHR(10), gcL307I, 1)
ENDPROC

FUNCTION Conta(par_nH)
    LOCAL lnN
    lnN = -1
    IF SQLEXEC(par_nH, "SELECT COUNT(*) AS n FROM SigCdOpe", "cur_c") > 0
        lnN = cur_c.n
        USE IN cur_c
    ENDIF
    RETURN lnN
ENDFUNC

PROCEDURE T307I(par_nH, par_cNome, par_cSql)
    LOCAL lnR, lcM
    lnR = SQLEXEC(par_nH, par_cSql)
    IF lnR < 0
        LOCAL ARRAY laE[1]
        lcM = "ERRO: "
        IF AERROR(laE) > 0
            lcM = lcM + ALLTRIM(TRANSFORM(laE[2]))
        ENDIF
    ELSE
        lcM = "ACEITO (resultado=" + TRANSFORM(lnR) + ")"
    ENDIF
    L307I("   " + PADR(par_cNome, 24) + " -> " + lcM)
ENDPROC

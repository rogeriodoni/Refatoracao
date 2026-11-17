SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
PUBLIC gb_4c_ModoTeste, gc_4c_ArquivoErroTeste
gb_4c_ModoTeste        = .T.
gc_4c_ArquivoErroTeste = "C:\4c\tasks\task797\logs\probe_sql2_f8_dialogs.txt"
STRTOFILE("", gc_4c_ArquivoErroTeste)

LOCAL loc_cOut, loc_oBO, loc_oErro, loc_n
loc_cOut = ""
CD C:\4c\projeto\app\start
DO config.prg
ConfigurarAmbiente()
gb_4c_ValidandoUI = .F.

TRY
    gnConnHandle = SQLSTRINGCONNECT(ObterStringConexao())
    loc_cOut = loc_cOut + "handle=" + TRANSFORM(gnConnHandle) + CHR(13) + CHR(10)
    IF gnConnHandle > 0
        SQLSETPROP(gnConnHandle, "QueryTimeOut", 120)

        loc_n = SQLEXEC(gnConnHandle, "SELECT COUNT(*) AS n FROM SigCdFrp", "cCnt")
        loc_cOut = loc_cOut + "SigCdFrp COUNT(*)=" + ;
            TRANSFORM(IIF(USED("cCnt") AND RECCOUNT("cCnt") > 0, cCnt.n, -1)) + ;
            " (ret=" + TRANSFORM(loc_n) + ")" + CHR(13) + CHR(10)

        *-- SQL EXATO do BO, com parametros ficticios: prova que TODAS as
        *-- colunas do SELECT/WHERE/ORDER BY existem no servidor (regra #48).
        GarantirClasse("SIGOPRPSBO")
        loc_oBO = CREATEOBJECT("SIGOPRPSBO", "001", "RPS", "1", 1, "MALOTE", 1)
        loc_cOut = loc_cOut + "BuscarHistorico(ficticio)=" + ;
            TRANSFORM(loc_oBO.BuscarHistorico()) + CHR(13) + CHR(10)
        loc_cOut = loc_cOut + "msgErro=[" + loc_oBO.this_cMensagemErro + "]" + CHR(13) + CHR(10)
        loc_cOut = loc_cOut + "cursor: usado=" + TRANSFORM(USED("cursor_4c_Historico")) + ;
            " RECCOUNT=" + TRANSFORM(IIF(USED("cursor_4c_Historico"), RECCOUNT("cursor_4c_Historico"), -1)) + ;
            " FCOUNT=" + TRANSFORM(IIF(USED("cursor_4c_Historico"), FCOUNT("cursor_4c_Historico"), -1)) + CHR(13) + CHR(10)
        IF USED("cursor_4c_Historico")
            LOCAL ARRAY loc_aF[1]
            AFIELDS(loc_aF, "cursor_4c_Historico")
            LOCAL loc_i, loc_cF
            loc_cF = ""
            FOR loc_i = 1 TO ALEN(loc_aF, 1)
                loc_cF = loc_cF + loc_aF[loc_i, 1] + " " + loc_aF[loc_i, 2] + ;
                    "(" + TRANSFORM(loc_aF[loc_i, 3]) + ") | "
            ENDFOR
            loc_cOut = loc_cOut + "colunas do cursor: " + loc_cF + CHR(13) + CHR(10)
        ENDIF

        *-- Controle NEGATIVO: coluna inexistente DEVE falhar (prova que o
        *-- "ret>=0" acima nao e um falso OK do driver).
        loc_n = SQLEXEC(gnConnHandle, "SELECT Cemps FROM SigCdFrp", "cNeg")
        loc_cOut = loc_cOut + "controle negativo (SELECT Cemps): ret=" + TRANSFORM(loc_n) + CHR(13) + CHR(10)

        SQLDISCONNECT(gnConnHandle)
    ENDIF
CATCH TO loc_oErro
    loc_cOut = loc_cOut + "EXCECAO: " + loc_oErro.Message + " | Linha " + ;
        TRANSFORM(loc_oErro.LineNo) + " | Proc " + loc_oErro.Procedure + CHR(13) + CHR(10)
ENDTRY
STRTOFILE(loc_cOut, "C:\4c\tasks\task797\logs\probe_sql2_f8_resultado.txt")
QUIT

*-- Probe de DADOS da Fase 8: conecta de verdade e prova que BuscarHistorico
*-- devolve LINHA (nao basta devolver .T. - regra CLAUDE.md #42).
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF

PUBLIC gb_4c_ModoTeste, gc_4c_ArquivoErroTeste
gb_4c_ModoTeste        = .T.
gc_4c_ArquivoErroTeste = "C:\4c\tasks\task797\logs\probe_sql_f8_dialogs.txt"
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

        *-- 1) achar um RPS que exista de verdade
        loc_n = SQLEXEC(gnConnHandle, ;
            "SELECT TOP 1 Emps, Tipos, Series, NumRps, Dopes, Numes FROM SigCdFrp", "cAmostra")
        loc_cOut = loc_cOut + "amostra: ret=" + TRANSFORM(loc_n) + ;
            " linhas=" + TRANSFORM(IIF(USED("cAmostra"), RECCOUNT("cAmostra"), -1)) + CHR(13) + CHR(10)

        IF USED("cAmostra") AND RECCOUNT("cAmostra") > 0
            SELECT cAmostra
            GO TOP
            loc_cOut = loc_cOut + "chave: Emps=[" + ALLTRIM(cAmostra.Emps) + "] Tipos=[" + ;
                ALLTRIM(cAmostra.Tipos) + "] Series=[" + ALLTRIM(cAmostra.Series) + ;
                "] NumRps=" + TRANSFORM(cAmostra.NumRps) + CHR(13) + CHR(10)

            GarantirClasse("SIGOPRPSBO")
            loc_oBO = CREATEOBJECT("SIGOPRPSBO", ALLTRIM(cAmostra.Emps), ;
                ALLTRIM(cAmostra.Tipos), ALLTRIM(cAmostra.Series), ;
                cAmostra.NumRps, ALLTRIM(cAmostra.Dopes), cAmostra.Numes)

            loc_cOut = loc_cOut + "BO VARTYPE=" + VARTYPE(loc_oBO) + CHR(13) + CHR(10)
            loc_cOut = loc_cOut + "BuscarHistorico=" + TRANSFORM(loc_oBO.BuscarHistorico()) + CHR(13) + CHR(10)
            loc_cOut = loc_cOut + "msgErro=[" + loc_oBO.this_cMensagemErro + "]" + CHR(13) + CHR(10)
            loc_cOut = loc_cOut + "cursor usado=" + TRANSFORM(USED("cursor_4c_Historico")) + ;
                " RECCOUNT=" + TRANSFORM(IIF(USED("cursor_4c_Historico"), RECCOUNT("cursor_4c_Historico"), -1)) + ;
                " FCOUNT=" + TRANSFORM(IIF(USED("cursor_4c_Historico"), FCOUNT("cursor_4c_Historico"), -1)) + CHR(13) + CHR(10)

            IF USED("cursor_4c_Historico") AND RECCOUNT("cursor_4c_Historico") > 0
                SELECT cursor_4c_Historico
                GO TOP
                loc_cOut = loc_cOut + "1a linha: Datas=[" + TRANSFORM(cursor_4c_Historico.Datas) + ;
                    "] Transacaos=[" + ALLTRIM(NVL(cursor_4c_Historico.Transacaos, "")) + ;
                    "] Usuars=[" + ALLTRIM(NVL(cursor_4c_Historico.Usuars, "")) + ;
                    "] Nfis=[" + ALLTRIM(NVL(cursor_4c_Historico.Nfis, "")) + "]" + CHR(13) + CHR(10)
                *-- CarregarDoCursor le as 11 colunas: aqui o cursor so tem 4,
                *-- entao prova-se com SELECT * da MESMA chave
                loc_n = SQLEXEC(gnConnHandle, "SELECT TOP 1 * FROM SigCdFrp", "cFull")
                IF USED("cFull") AND RECCOUNT("cFull") > 0
                    loc_cOut = loc_cOut + "CarregarDoCursor(SELECT *)=" + ;
                        TRANSFORM(loc_oBO.CarregarDoCursor("cFull")) + ;
                        " cid=[" + ALLTRIM(loc_oBO.this_cCidChaves) + "]" + ;
                        " transacao=[" + ALLTRIM(loc_oBO.this_cTransacaos) + "]" + CHR(13) + CHR(10)
                ENDIF
            ENDIF
        ENDIF
        SQLDISCONNECT(gnConnHandle)
    ENDIF
CATCH TO loc_oErro
    loc_cOut = loc_cOut + "EXCECAO: " + loc_oErro.Message + " | Linha " + ;
        TRANSFORM(loc_oErro.LineNo) + " | Proc " + loc_oErro.Procedure + CHR(13) + CHR(10)
ENDTRY

STRTOFILE(loc_cOut, "C:\4c\tasks\task797\logs\probe_sql_f8_resultado.txt")
QUIT

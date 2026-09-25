*-- Prova POSITIVA do conserto de MontarChaveEmpDopNums: monta a chave pelo
*-- BO para um movimento que TEM itens em SigMvItn (CONSERTO) e confere que
*-- BuscarItensSubnivel devolve LINHA. Sem isto, "OK" com 0 itens nao
*-- distingue conserto certo de chave ainda errada.
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
SET NOTIFY OFF

LOCAL loc_cOut, loc_oBO, loc_oErro, loc_cChave, loc_cEsperada
loc_cOut = ""

TRY
    CD C:\4c\projeto\app\start
    DO config.prg
    ConfigurarAmbiente()

    PUBLIC gnConnHandle
    gnConnHandle = SQLSTRINGCONNECT(ObterStringConexao())
    SQLSETPROP(gnConnHandle, "QueryTimeOut", 120)
    loc_cOut = loc_cOut + "conexao OK" + CHR(13) + CHR(10)

    loc_oBO = CREATEOBJECT("SigMvSbnBO")

    *-- 1) a chave montada bate BYTE A BYTE com o formato gravado?
    loc_cChave    = loc_oBO.MontarChaveEmpDopNums("001", "CONSERTO", 1)
    loc_cEsperada = "001CONSERTO                 1"
    loc_cOut = loc_cOut + "chave montada : [" + loc_cChave + "] len=" + ;
        ALLTRIM(STR(LEN(loc_cChave))) + CHR(13) + CHR(10)
    loc_cOut = loc_cOut + "chave gravada : [" + loc_cEsperada + "] len=" + ;
        ALLTRIM(STR(LEN(loc_cEsperada))) + CHR(13) + CHR(10)
    loc_cOut = loc_cOut + "IDENTICAS?    : " + IIF(loc_cChave == loc_cEsperada, "SIM", "NAO") + CHR(13) + CHR(10)

    *-- 2) e o BO acha os itens com ela?
    IF loc_oBO.BuscarItensSubnivel(loc_cChave)
        loc_cOut = loc_cOut + "BuscarItensSubnivel : OK - " + ;
            ALLTRIM(STR(RECCOUNT(loc_oBO.this_cCursorItens))) + " item(ns)" + CHR(13) + CHR(10)
        SELECT (loc_oBO.this_cCursorItens)
        GO TOP
        IF !EOF()
            loc_cOut = loc_cOut + "  1o item cpros=[" + ;
                ALLTRIM(TratarNulo(EVALUATE(loc_oBO.this_cCursorItens + ".cpros"), "")) + "]" + CHR(13) + CHR(10)
        ENDIF
    ELSE
        loc_cOut = loc_cOut + "BuscarItensSubnivel : FALHOU - " + loc_oBO.this_cMensagemErro + CHR(13) + CHR(10)
    ENDIF

    *-- 3) contraprova: a chave ANTIGA (com ALLTRIM) acharia algo?
    IF loc_oBO.BuscarItensSubnivel("001CONSERTO1")
        loc_cOut = loc_cOut + "chave ALLTRIM (antiga) : " + ;
            ALLTRIM(STR(RECCOUNT(loc_oBO.this_cCursorItens))) + " item(ns) <- deve ser 0" + CHR(13) + CHR(10)
    ENDIF

    SQLDISCONNECT(gnConnHandle)
CATCH TO loc_oErro
    loc_cOut = loc_cOut + "EXCECAO: " + loc_oErro.Message + " linha " + ;
        TRANSFORM(loc_oErro.LineNo) + " " + loc_oErro.Procedure + CHR(13) + CHR(10)
ENDTRY

STRTOFILE(loc_cOut, "C:\4c\tasks\task577\probe_itens_ok.txt")
QUIT

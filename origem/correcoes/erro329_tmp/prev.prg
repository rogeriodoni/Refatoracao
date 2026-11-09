LPARAMETERS par_cRodada
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
SYS(2335, 0)
PUBLIC gcDir, gcOut
gcDir = "C:\4c\refatoracao\origem\correcoes\erro329_tmp\"
gcOut = gcDir + "prev.txt"
STRTOFILE("", gcOut)
LOCAL loE, loT, lnI
TRY
    _SCREEN.Visible = .T.
    _SCREEN.WindowState = 2
    DO ("C:\4c\refatoracao\projeto\app\start\config.prg")
    ConfigurarAmbiente()
    PUBLIC gnConnHandle
    gnConnHandle = SQLSTRINGCONNECT(ObterStringConexao())
    go_4c_Sistema.cCodEmpresa = "001"
    SET PROCEDURE TO (gcDir + "relatoriobase.prg"), (gcDir + "sigrectcBO.prg") ADDITIVE
    SET DATE TO BRITISH
    SET CENTURY ON
    SET POINT TO ","
    SET SEPARATOR TO "."
    SET REPORTBEHAVIOR 90
    *-- larguras de teste nos 6 totais (Valor Bruto cresce p/ esquerda, Liquido idem)
    SELECT 0
    USE (gcDir + "TstCtc.frx") EXCLUSIVE ALIAS frxt
    REPLACE hpos WITH 89270 - 10708 - 1000, width WITH 10708 + 1000 FOR objtype = 8 AND UPPER(ALLTRIM(expr)) == "TOTAL_CARTAO"
    REPLACE hpos WITH 89270 - 10708 - 2000, width WITH 10708 + 2000 FOR objtype = 8 AND UPPER(ALLTRIM(expr)) == "TOTAL_EMPRESA"
    REPLACE hpos WITH 89583 - 10708 - 3000, width WITH 10708 + 3000 FOR objtype = 8 AND UPPER(ALLTRIM(expr)) == "TOTAL_GERAL"
    REPLACE hpos WITH 100304 - 10708 - 4000, width WITH 10708 + 4000 FOR objtype = 8 AND UPPER(ALLTRIM(expr)) == "TOTLIQ_CARTAO"
    REPLACE fontstyle WITH 0 FOR objtype = 8 AND UPPER(ALLTRIM(expr)) == "TOTLIQ_EMPRESA"
    USE IN frxt
    loT = CREATEOBJECT("T329")
    loT.this_dDtInicial = DATE(2000,1,1)
    loT.this_dDtFinal   = DATE(2026,11,9)
    STORE .T. TO loT.this_lEntrada, loT.this_lReceber, loT.this_lDepositar, loT.this_lBaixa
    loT.Mostrar()
CATCH TO loE
    STRTOFILE("ERRO " + loE.Message + " " + TRANSFORM(loE.LineNo) + CHR(13) + CHR(10), gcOut, .T.)
ENDTRY
STRTOFILE("FIM" + CHR(13) + CHR(10), gcOut, .T.)

DEFINE CLASS T329 AS sigrectcBO
    PROCEDURE Mostrar()
        LOCAL lnT
        PRIVATE dDtInicial, dDtFinal
        dDtInicial = THIS.this_dDtInicial
        dDtFinal   = THIS.this_dDtFinal
        IF THIS.PrepararDados()
            SELECT (THIS.this_cCursorDados)
            GO TOP
            SET POINT TO "."
            SET SEPARATOR TO ","
            SET REPORTBEHAVIOR 80
            REPORT FORM (gcDir + "TstCtc") PREVIEW NOWAIT NOCONSOLE
            STRTOFILE("PRONTO" + CHR(13) + CHR(10), gcOut, .T.)
            lnT = SECONDS()
            DO WHILE SECONDS() - lnT < 25
                DOEVENTS
            ENDDO
        ENDIF
    ENDPROC
ENDDEFINE

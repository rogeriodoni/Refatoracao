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
            REPORT FORM (gc_4c_CaminhoReports + "SigReCtc") PREVIEW NOWAIT NOCONSOLE
            STRTOFILE("PRONTO" + CHR(13) + CHR(10), gcOut, .T.)
            lnT = SECONDS()
            DO WHILE SECONDS() - lnT < 25
                DOEVENTS
            ENDDO
        ENDIF
    ENDPROC
ENDDEFINE

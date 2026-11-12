SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
SYS(2335, 0)
PUBLIC gcOut, gcDir, gb_4c_ModoTeste, gc_4c_ArquivoErroTeste
gcDir = "C:\4c\origem\correcoes\erro348_tmp\"
gcOut = gcDir + "probe3.txt"
STRTOFILE("", gcOut)
LOCAL loE, loF, loB, lnI, lcP, lnNec, lnCx, lnFolga, lnF, lcFonte, lnTam
TRY
    DO ("C:\4c\projeto\app\start\config.prg")
    ConfigurarAmbiente()
    gb_4c_ModoTeste        = .T.
    gc_4c_ArquivoErroTeste = gcDir + "erros3.txt"
    STRTOFILE("", gc_4c_ArquivoErroTeste)
    PUBLIC gnConnHandle
    gnConnHandle = SQLSTRINGCONNECT(ObterStringConexao())
    go_4c_Sistema.cCodEmpresa = "001"

    L("=== folga dos campos numericos (limiar 11%, erro345) ===")
    FOR lnI = 1 TO 7
        USE (gc_4c_CaminhoReports + "SigReEt" + TRANSFORM(lnI) + ".frx") IN 0 ALIAS frx SHARED
        SELECT frx
        SCAN FOR OBJTYPE = 8 AND ATC("9", PICTURE) > 0
            lcFonte = ALLTRIM(frx.FONTFACE)
            lnTam   = frx.FONTSIZE
            IF EMPTY(lcFonte)
                lcFonte = "Verdana"
            ENDIF
            IF lnTam = 0
                lnTam = 8
            ENDIF
            lnF   = FONTMETRIC(6, lcFonte, lnTam)
            lcP   = ALLTRIM(STRTRAN(STRTRAN(STRTRAN(ALLTRIM(PICTURE), '"', ''), "@Z ", ""), "@R ", ""))
            lnNec = TXTWIDTH(lcP, lcFonte, lnTam) * lnF / 96
            lnCx  = frx.WIDTH / 10000
            lnFolga = IIF(lnNec = 0, 999, (lnCx - lnNec) / lnNec * 100)
            IF lnFolga < 11
                L("   SigReEt" + TRANSFORM(lnI) + " " + PADR(LEFT(ALLTRIM(frx.EXPR),18),19) + ;
                  " caixa=" + TRANSFORM(ROUND(lnCx,4)) + " pict=" + PADR(lcP,16) + ;
                  " texto=" + TRANSFORM(ROUND(lnNec,4)) + " folga=" + TRANSFORM(ROUND(lnFolga,1)) + "%  <<< RISCO")
            ENDIF
        ENDSCAN
        USE IN frx
    ENDFOR
    L("   (nada listado acima = todos acima de 11%)")

    GarantirClasse("FormSigReEtl")
    loF = CREATEOBJECT("FormSigReEtl")
    SET DATASESSION TO loF.DataSessionId
    loB = loF.this_oRelatorio
    loB.this_nTipoRelatorio = 1
    loB.this_nSubTotais     = 0
    L("")
    L("=== render do Tipo 1 ===")
    L("PrepararDados = " + TRANSFORM(loB.PrepararDados()))
    IF USED("CsImpressao") AND RECCOUNT("CsImpressao") > 0
        SELECT CsImpressao
        GO TOP
        loB.ReportFormIsolado(gc_4c_CaminhoReports + "SigReEt1.frx", "ASCII", gcDir + "render_et1.txt")
        L("render gerado = " + TRANSFORM(FILE(gcDir + "render_et1.txt")))
    ENDIF
    L("")
    L("erros: [" + FILETOSTR(gc_4c_ArquivoErroTeste) + "]")
CATCH TO loE
    L("ERRO " + TRANSFORM(loE.ErrorNo) + " linha " + TRANSFORM(loE.LineNo) + " " + loE.Message + " | " + loE.Procedure)
ENDTRY
L("FIM")
QUIT
PROCEDURE L(par_c)
    STRTOFILE(par_c + CHR(13) + CHR(10), gcOut, 1)
ENDPROC

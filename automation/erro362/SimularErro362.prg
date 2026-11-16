SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
SYS(2335, 0)
SET DATE TO BRITISH
SET CENTURY ON
LOCAL loc_cOut, loForm, loE, loBO, loc_oPg, loc_nI, loc_oA, loc_nCen
PUBLIC gb_4c_ModoTeste, gb_4c_ValidandoUI, gc_4c_ArquivoErroTeste, gnConnHandle
gb_4c_ModoTeste = .T.
gb_4c_ValidandoUI = .F.
gc_4c_ArquivoErroTeste = "C:\4c\refatoracao\automation\erro362\erro.txt"
loc_cOut = ""
TRY
    CD "C:\4c\refatoracao\projeto\app\start"
    DO config.prg
    ConfigurarAmbiente()
    gnConnHandle = SQLSTRINGCONNECT(ObterStringConexao())
    GarantirClasse("FormSIGREFXV")
    loForm = CREATEOBJECT("FormSIGREFXV")
    loc_cOut = loc_cOut + "form=" + VARTYPE(loForm) + CHR(13)+CHR(10)
    loc_oPg = loForm.pgf_4c_Paginas.Page1
    FOR loc_nI = 1 TO loc_oPg.ControlCount
        loc_oA = loc_oPg.Controls(loc_nI)
        loc_cOut = loc_cOut + PADR(loc_oA.Name, 28) + " T=" + PADL(loc_oA.Top,4) + " L=" + PADL(loc_oA.Left,4) + " W=" + PADL(loc_oA.Width,4) + " H=" + PADL(loc_oA.Height,4) + CHR(13)+CHR(10)
    ENDFOR
    loc_cOut = loc_cOut + "grid col widths=" + TRANSFORM(loc_oPg.grd_4c_Dados.Column1.Width) + "/" + TRANSFORM(loc_oPg.grd_4c_Dados.Column2.Width) + ;
        " HeaderHeight=" + TRANSFORM(loc_oPg.grd_4c_Dados.HeaderHeight) + CHR(13)+CHR(10)
    SET DATASESSION TO loForm.DataSessionId
    loBO = loForm.this_oRelatorio
    SELECT CsEstoque
    ZAP
    INSERT INTO CsEstoque (Emps, Grupos) VALUES ("001", "11210")
    APPEND BLANK
    FOR loc_nCen = 1 TO 3
        loBO.this_nNrPeriodo = IIF(loc_nCen = 3, 2, 1)
        loBO.this_dDataSaldo = IIF(loc_nCen = 3, DATE(), {})
        loBO.this_cCdMoeda = "R"
        loBO.this_cGGrus   = "JOO"
        loBO.this_cFichaT  = IIF(loc_nCen = 2, "TEOR", "")
        loBO.this_cCdGrupo = IIF(loc_nCen = 2, "ANO", "")
        loBO.this_cDsGrupo = IIF(loc_nCen = 2, "ANEL OURO", "")
        loc_cOut = loc_cOut + "===== CENARIO " + TRANSFORM(loc_nCen) + " PrepararDados=" + TRANSFORM(loBO.PrepararDados()) + " msg=" + loBO.ObterMensagemErro() + CHR(13)+CHR(10)
        IF USED("CsRelatorio")
            SELECT CsRelatorio
            SET ORDER TO Quebra
            SCAN
                loc_cOut = loc_cOut + PADR(ALLTRIM(LEFT(cResps,10)),10) + " " + Cgrus + " ps=" + STR(ps,1) + " " + PADR(Descrs,14) + ;
                    " Faixa=" + TRANSFORM(FaixaIs) + "-" + TRANSFORM(FaixaFs) + " PV=" + TRANSFORM(Pvens) + " " + cUnis + ;
                    " Qtd=" + TRANSFORM(Qtds) + " Tot=" + TRANSFORM(TotQtds) + CHR(13)+CHR(10)
            ENDSCAN
            SELECT csCabecalho
            loc_cOut = loc_cOut + "Cab: " + ALLTRIM(nm_titulo) + " | " + ALLTRIM(nm_periodo) + CHR(13)+CHR(10)
        ENDIF
    ENDFOR
    SET DATASESSION TO 1
    loForm.Release()
CATCH TO loE
    loc_cOut = loc_cOut + "ERRO: " + loE.Message + " linha " + TRANSFORM(loE.LineNo) + " " + loE.Procedure + CHR(13)+CHR(10)
ENDTRY
STRTOFILE(loc_cOut, "C:\4c\refatoracao\automation\erro362\simulacao_out.txt")
QUIT

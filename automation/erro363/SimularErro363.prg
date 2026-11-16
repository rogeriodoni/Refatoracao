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
gc_4c_ArquivoErroTeste = "C:\4c\refatoracao\automation\erro363\erro.txt"
loc_cOut = ""
TRY
    COMPILE "C:\4c\refatoracao\projeto\app\utils\sigipdup.prg"
    loc_cOut = loc_cOut + "sigipdup.err=" + TRANSFORM(FILE("C:\4c\refatoracao\projeto\app\utils\sigipdup.err")) + CHR(13)+CHR(10)
    CD "C:\4c\refatoracao\projeto\app\start"
    DO config.prg
    ConfigurarAmbiente()
    gnConnHandle = SQLSTRINGCONNECT(ObterStringConexao())
    GarantirClasse("FormSIGREGDP")
    loForm = CREATEOBJECT("FormSIGREGDP")
    loc_cOut = loc_cOut + "form=" + VARTYPE(loForm) + CHR(13)+CHR(10)
    FOR loc_nI = 1 TO 4
        loc_oA = loForm.cmg_4c_Botoes.Buttons(loc_nI)
        loc_cOut = loc_cOut + "btn" + TRANSFORM(loc_nI) + " " + PADR(loc_oA.Caption,16) + " Visible=" + TRANSFORM(loc_oA.Visible) + " Enabled=" + TRANSFORM(loc_oA.Enabled) + CHR(13)+CHR(10)
    ENDFOR
    loc_oPg = loForm.pgf_4c_Paginas.Page1
    FOR loc_nI = 1 TO loc_oPg.ControlCount
        loc_oA = loc_oPg.Controls(loc_nI)
        loc_cOut = loc_cOut + PADR(loc_oA.Name, 22) + " T=" + PADL(loc_oA.Top,4) + " L=" + PADL(loc_oA.Left,4) + " W=" + PADL(loc_oA.Width,4) + " H=" + PADL(loc_oA.Height,4) + ;
            IIF(PEMSTATUS(loc_oA, "Enabled", 5), " En=" + TRANSFORM(loc_oA.Enabled), "") + CHR(13)+CHR(10)
    ENDFOR
    SET DATASESSION TO loForm.DataSessionId
    FOR loc_nCen = 1 TO 3
        loc_oPg.txt_4c_Serie.Value  = "1"
        loc_oPg.txt_4c_NFIni.Value  = IIF(loc_nCen = 3, "1", "000001")
        loc_oPg.txt_4c_NFFim.Value  = IIF(loc_nCen = 3, "9999", "000031")
        loc_oPg.opt_4c_Selecao.Value = IIF(loc_nCen = 2, 2, 1)
        loForm.BtnProcessarClick()
        SELECT TmpNFis
        loc_cOut = loc_cOut + "===== CENARIO " + TRANSFORM(loc_nCen) + " regs=" + TRANSFORM(RECCOUNT("TmpNFis")) + CHR(13)+CHR(10)
        SCAN
            loc_cOut = loc_cOut + TRANSFORM(Flag) + " " + NFis + "-" + STR(Digito,1) + " " + Conta + " " + DTOC(Datas) + " " + TRANSFORM(Valor, "999,999.99") + " " + Vecto + " " + Emps + ALLTRIM(Dopes) + STR(Numes,6) + CHR(13)+CHR(10)
        ENDSCAN
    ENDFOR
    SET DATASESSION TO 1
    loForm.Release()
CATCH TO loE
    loc_cOut = loc_cOut + "ERRO: " + loE.Message + " linha " + TRANSFORM(loE.LineNo) + " " + loE.Procedure + CHR(13)+CHR(10)
ENDTRY
STRTOFILE(loc_cOut, "C:\4c\refatoracao\automation\erro363\simulacao_out.txt")
QUIT

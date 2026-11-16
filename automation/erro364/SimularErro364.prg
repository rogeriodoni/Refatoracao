SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
SYS(2335, 0)
SET DATE TO BRITISH
SET CENTURY ON
LOCAL loc_cOut, loForm, loE, loc_oCp, loc_nI, loc_oA, loc_nCen
PUBLIC gb_4c_ModoTeste, gb_4c_ValidandoUI, gc_4c_ArquivoErroTeste, gnConnHandle
gb_4c_ModoTeste = .T.
gb_4c_ValidandoUI = .F.
gc_4c_ArquivoErroTeste = "C:\4c\refatoracao\automation\erro364\erro.txt"
loc_cOut = ""
TRY
    COMPILE "C:\4c\refatoracao\projeto\app\utils\sigprnfs.prg"
    loc_cOut = loc_cOut + "sigprnfs.err=" + TRANSFORM(FILE("C:\4c\refatoracao\projeto\app\utils\sigprnfs.err")) + CHR(13)+CHR(10)
    CD "C:\4c\refatoracao\projeto\app\start"
    DO config.prg
    ConfigurarAmbiente()
    gnConnHandle = SQLSTRINGCONNECT(ObterStringConexao())
    go_4c_Sistema.cCodEmpresa = "001"
    GarantirClasse("Formsigregnf")
    loForm = CREATEOBJECT("Formsigregnf")
    loc_cOut = loc_cOut + "form=" + VARTYPE(loForm) + CHR(13)+CHR(10)
    loc_oCp = loForm.cnt_4c_Corpo
    FOR loc_nI = 1 TO loc_oCp.ControlCount
        loc_oA = loc_oCp.Controls(loc_nI)
        loc_cOut = loc_cOut + PADR(loc_oA.Name, 20) + " T=" + PADL(loc_oA.Top,4) + " L=" + PADL(loc_oA.Left,4) + " W=" + PADL(loc_oA.Width,4) + " H=" + PADL(loc_oA.Height,4) + CHR(13)+CHR(10)
    ENDFOR
    loc_cOut = loc_cOut + "SelTudo T=" + TRANSFORM(loForm.cmd_4c_SelTudo.Top) + " pic=" + JUSTFNAME(loForm.cmd_4c_SelTudo.Picture) + " | Apaga pic=" + JUSTFNAME(loForm.cmd_4c_Apaga.Picture) + CHR(13)+CHR(10)
    FOR loc_nCen = 1 TO 2
        loc_oCp.txt_4c_Serie.Value  = "1"
        loc_oCp.txt_4c_Usuars.Value = IIF(loc_nCen = 2, "LOJA", "")
        loForm.BtnProcessarClick()
        SELECT cursor_4c_TmpNFis
        loc_cOut = loc_cOut + "===== CENARIO " + TRANSFORM(loc_nCen) + " (usuario=" + IIF(loc_nCen = 2, "LOJA", "todos") + ") regs=" + TRANSFORM(RECCOUNT()) + CHR(13)+CHR(10)
        SCAN
            loc_cOut = loc_cOut + TRANSFORM(Flag) + " " + NFis + " " + Series + " " + DTOC(Emis) + " " + Operas + " " + PADR(CFis,6) + TRANSFORM(TotNotas, "999,999.99") + " " + Operacao + " | " + Conta + CHR(13)+CHR(10)
        ENDSCAN
    ENDFOR
    *-- Visualizar / Imprimir pelo wrapper (mensagens vao para o log em modo teste)
    loc_oCp.txt_4c_Usuars.Value = ""
    loForm.BtnProcessarClick()
    GO TOP IN cursor_4c_TmpNFis
    loForm.BtnVisualizarClick()
    loForm.BtnImprimirClick()
    loc_cOut = loc_cOut + "apos Imprimir regs=" + TRANSFORM(RECCOUNT("cursor_4c_TmpNFis")) + " (nada removido)" + CHR(13)+CHR(10)
    loForm.Release()
CATCH TO loE
    loc_cOut = loc_cOut + "ERRO: " + loE.Message + " linha " + TRANSFORM(loE.LineNo) + " " + loE.Procedure + CHR(13)+CHR(10)
ENDTRY
STRTOFILE(loc_cOut, "C:\4c\refatoracao\automation\erro364\simulacao_out.txt")
QUIT

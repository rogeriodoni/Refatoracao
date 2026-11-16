SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
SYS(2335, 0)
SET DATE TO BRITISH
SET CENTURY ON
LOCAL loc_cOut, loForm, loE, loc_oCp
PUBLIC gb_4c_ModoTeste, gb_4c_ValidandoUI, gc_4c_ArquivoErroTeste, gnConnHandle, gc_4c_PrbDir, gn_4c_PrbPag
gb_4c_ModoTeste = .T.
gb_4c_ValidandoUI = .F.
gc_4c_PrbDir = "C:\4c\refatoracao\automation\erro365\probe\"
gn_4c_PrbPag = 0
gc_4c_ArquivoErroTeste = gc_4c_PrbDir + "mensagens.txt"
loc_cOut = ""
TRY
    COMPILE (gc_4c_PrbDir + "sigprnfx.prg")
    CD "C:\4c\refatoracao\projeto\app\start"
    DO config.prg
    ConfigurarAmbiente()
    gnConnHandle = SQLSTRINGCONNECT(ObterStringConexao())
    go_4c_Sistema.cCodEmpresa = "001"
    GarantirClasse("Formsigregnf")
    CD (gc_4c_PrbDir)
    loc_cOut = loc_cOut + "sigprnfx resolvido em: " + FULLPATH("sigprnfx.prg") + CHR(13)+CHR(10)
    loForm = CREATEOBJECT("Formsigregnf")
    SET DATASESSION TO loForm.DataSessionId
    loc_oCp = loForm.cnt_4c_Corpo
    loc_oCp.txt_4c_Serie.Value = "1"
    loForm.BtnProcessarClick()
    loc_cOut = loc_cOut + "processadas=" + TRANSFORM(RECCOUNT("cursor_4c_TmpNFis")) + CHR(13)+CHR(10)
    *-- VISUALIZAR: NF 000032 (cliente com endereco)
    SELECT cursor_4c_TmpNFis
    LOCATE FOR NFis = "000032"
    loForm.BtnVisualizarClick()
    loc_cOut = loc_cOut + "visualizar 000032 -> paginas png=" + TRANSFORM(gn_4c_PrbPag) + CHR(13)+CHR(10)
    *-- VISUALIZAR: NF 000029 (cliente SEM endereco -> legado cancela)
    SELECT cursor_4c_TmpNFis
    LOCATE FOR NFis = "000029"
    loForm.BtnVisualizarClick()
    loc_cOut = loc_cOut + "visualizar 000029 -> paginas png=" + TRANSFORM(gn_4c_PrbPag) + CHR(13)+CHR(10)
    *-- IMPRIMIR so a 000034
    UPDATE cursor_4c_TmpNFis SET Flag = (NFis = "000034")
    GO TOP IN cursor_4c_TmpNFis
    loForm.BtnImprimirClick()
    =SQLEXEC(gnConnHandle, "SELECT nfis, impress FROM SigMvNfi WHERE nfis IN ('000032','000034') AND series = '1'", "cursor_4c_Chk")
    SELECT cursor_4c_Chk
    SCAN
        loc_cOut = loc_cOut + "banco: NF " + nfis + " impress=" + TRANSFORM(impress) + CHR(13)+CHR(10)
    ENDSCAN
    loc_cOut = loc_cOut + "transactions apos=" + TRANSFORM(SQLGETPROP(gnConnHandle, "Transactions")) + " conexao viva=" + TRANSFORM(SQLEXEC(gnConnHandle, "SELECT 1 AS x", "cursor_4c_Viva") = 1) + CHR(13)+CHR(10)
    loc_cOut = loc_cOut + "grade apos imprimir=" + TRANSFORM(RECCOUNT("cursor_4c_TmpNFis")) + " regs" + CHR(13)+CHR(10)
    SET DATASESSION TO 1
    loForm.Release()
CATCH TO loE
    loc_cOut = loc_cOut + "ERRO: " + loE.Message + " linha " + TRANSFORM(loE.LineNo) + " " + loE.Procedure + " | " + loE.LineContents + CHR(13)+CHR(10)
ENDTRY
STRTOFILE(loc_cOut, gc_4c_PrbDir + "simulacao_out.txt")
QUIT

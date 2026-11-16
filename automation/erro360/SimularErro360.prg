SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
SYS(2335, 0)
SET DATE TO BRITISH
SET CENTURY ON
LOCAL loc_cOut, loForm, loE, loBO, loc_oPag, loc_nI, loc_oA
PUBLIC gb_4c_ModoTeste, gb_4c_ValidandoUI, gc_4c_ArquivoErroTeste, gnConnHandle
gb_4c_ModoTeste = .T.
gb_4c_ValidandoUI = .F.
gc_4c_ArquivoErroTeste = "C:\4c\refatoracao\automation\erro360\erro.txt"
loc_cOut = ""
TRY
    CD "C:\4c\refatoracao\projeto\app\start"
    DO config.prg
    ConfigurarAmbiente()
    gnConnHandle = SQLSTRINGCONNECT(ObterStringConexao())
    GarantirClasse("FormSIGREFUN")
    loForm = CREATEOBJECT("FormSIGREFUN")
    loc_cOut = loc_cOut + "form=" + VARTYPE(loForm) + CHR(13)+CHR(10)
    loc_oPag = loForm.pgf_4c_Paginas.Page1
    FOR loc_nI = 1 TO loc_oPag.ControlCount
        loc_oA = loc_oPag.Controls(loc_nI)
        loc_cOut = loc_cOut + PADR(loc_oA.Name, 16) + " T=" + PADL(loc_oA.Top,4) + " L=" + PADL(loc_oA.Left,4) + " W=" + PADL(loc_oA.Width,4) + CHR(13)+CHR(10)
    ENDFOR
    loBO = loForm.this_oRelatorio
    loBO.this_nFundI = 900001
    loBO.this_nFundF = 900003
    loBO.this_lImpObs = .T.
    loc_cOut = loc_cOut + "PrepararDados=" + TRANSFORM(loBO.PrepararDados()) + " msg=" + loBO.ObterMensagemErro() + CHR(13)+CHR(10)
    SELECT Relatorio
    SET ORDER TO Impressao
    SCAN
        loc_cOut = loc_cOut + STR(Codigos,6) + " T" + STR(Tubos,2) + " Cor=" + CodCors + " bCera=" + TRANSFORM(bCeras) + ;
            " Base=" + TRANSFORM(Bases) + " Cera=" + TRANSFORM(Ceras) + " Metal=" + TRANSFORM(Metals) + ;
            " QtdOs=" + TRANSFORM(QtdOs) + " Data=" + DTOC(Datas) + " Obs=" + ALLTRIM(LEFT(Obss,30)) + " ObsG=" + ALLTRIM(LEFT(ObsG,30)) + CHR(13)+CHR(10)
    ENDSCAN
    SELECT csCabecalho
    loc_cOut = loc_cOut + "Cab: " + ALLTRIM(NomeEmpresa) + " | " + ALLTRIM(Titulo2) + CHR(13)+CHR(10)
    SELECT Relatorio
    GO TOP
    REPORT FORM (gc_4c_CaminhoReports + "sigrefun.frx") TO FILE "C:\4c\refatoracao\automation\erro360\relatorio.txt" ASCII NOCONSOLE
    loc_cOut = loc_cOut + "REPORT FORM ok" + CHR(13)+CHR(10)
    loForm.Release()
CATCH TO loE
    loc_cOut = loc_cOut + "ERRO: " + loE.Message + " linha " + TRANSFORM(loE.LineNo) + " " + loE.Procedure + CHR(13)+CHR(10)
ENDTRY
STRTOFILE(loc_cOut, "C:\4c\refatoracao\automation\erro360\simulacao_out.txt")
QUIT

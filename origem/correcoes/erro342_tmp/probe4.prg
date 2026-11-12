SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
SYS(2335, 0)
PUBLIC gcOut, gcDir, gb_4c_ModoTeste, gc_4c_ArquivoErroTeste
gcDir = "C:\4c\origem\correcoes\erro342_tmp\"
gcOut = gcDir + "probe4.txt"
STRTOFILE("", gcOut)
LOCAL loE, loForm, loPag, loG
TRY
    DO ("C:\4c\projeto\app\start\config.prg")
    ConfigurarAmbiente()
    gb_4c_ModoTeste        = .T.
    gc_4c_ArquivoErroTeste = gcDir + "erros4.txt"
    STRTOFILE("", gc_4c_ArquivoErroTeste)
    PUBLIC gnConnHandle
    gnConnHandle = SQLSTRINGCONNECT(ObterStringConexao())
    go_4c_Sistema.cCodEmpresa = "001"

    GarantirClasse("FormSIGREEQR")
    loForm = CREATEOBJECT("FormSIGREEQR")
    L("form = " + VARTYPE(loForm))
    SET DATASESSION TO loForm.DataSessionId
    loPag = loForm.pgf_4c_Paginas.Page1
    loG   = loPag.grd_4c_Grade

    L("")
    L("=== PROPRIEDADES DA GRADE (legado: RO=.F. / Sparse=.F. / 15,100,96) ===")
    L("Grid.ReadOnly        = " + TRANSFORM(loG.ReadOnly))
    L("Column1.Sparse       = " + TRANSFORM(loG.Column1.Sparse) + "   <<< tem de ser .F.")
    L("Column1.CurrentControl=[" + loG.Column1.CurrentControl + "]")
    L("Column1.ReadOnly     = " + TRANSFORM(loG.Column1.ReadOnly))
    L("Column1/2/3.Width    = " + TRANSFORM(loG.Column1.Width) + " / " + ;
      TRANSFORM(loG.Column2.Width) + " / " + TRANSFORM(loG.Column3.Width))
    L("Column1.Check1 existe= " + TRANSFORM(PEMSTATUS(loG.Column1, "Check1", 5)))

    L("")
    L("=== BOTAO SELECIONAR (v) ===")
    L("Selecao antes : " + TRANSFORM(IIF(USED("Selecao"), RECCOUNT("Selecao"), -1)) + " linhas")
    loForm.CmdSelTudoClick()
    SELECT Selecao
    GO TOP
    LOCAL lnM
    lnM = 0
    SCAN
        lnM = lnM + IIF(Selecao.marcas = 1, 1, 0)
    ENDSCAN
    L("marcadas apos (v) : " + TRANSFORM(lnM) + " de " + TRANSFORM(RECCOUNT("Selecao")))
    SELECT Selecao
    GO TOP
    SCAN
        L("   marcas=" + TRANSFORM(Selecao.marcas) + " gru=[" + Selecao.grupos + "] cta=[" + Selecao.contas + "]")
    ENDSCAN

    L("")
    L("=== BOTAO DESMARCAR (x) ===")
    loForm.CmdApagaClick()
    SELECT Selecao
    GO TOP
    lnM = 0
    SCAN
        lnM = lnM + IIF(Selecao.marcas = 1, 1, 0)
    ENDSCAN
    L("marcadas apos (x) : " + TRANSFORM(lnM))

    L("")
    L("=== CASCATA: marcar a linha PAI do grupo 11210 ===")
    SELECT Selecao
    GO TOP
    LOCATE FOR ALLTRIM(Selecao.grupos) = "11210" AND EMPTY(ALLTRIM(Selecao.contas))
    L("achou linha pai = " + TRANSFORM(!EOF("Selecao")))
    REPLACE Selecao.marcas WITH 1
    loForm.TgGrade1Click()
    SELECT Selecao
    GO TOP
    SCAN
        L("   marcas=" + TRANSFORM(Selecao.marcas) + " gru=[" + Selecao.grupos + "] cta=[" + Selecao.contas + "]")
    ENDSCAN

    L("")
    L("=== RELATORIO com o que a cascata marcou ===")
    loPag.txt_4c_CdEmpresa.Value = "001"
    loForm.BtnVisualizarClick()
    L("csTempoGr = " + TRANSFORM(IIF(USED("csTempoGr"), RECCOUNT("csTempoGr"), -1)) + " linhas")
    L("CsTempoCp = " + TRANSFORM(IIF(USED("CsTempoCp"), RECCOUNT("CsTempoCp"), -1)) + " linhas")
    L("")
    L("erros capturados: [" + FILETOSTR(gc_4c_ArquivoErroTeste) + "]")
CATCH TO loE
    L("ERRO " + TRANSFORM(loE.ErrorNo) + " linha " + TRANSFORM(loE.LineNo) + " " + loE.Message + " | " + loE.Procedure)
ENDTRY
L("FIM")
QUIT
PROCEDURE L(par_c)
    STRTOFILE(par_c + CHR(13) + CHR(10), gcOut, 1)
ENDPROC

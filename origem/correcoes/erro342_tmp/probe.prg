SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
SYS(2335, 0)
PUBLIC gcOut, gcDir
gcDir = "C:\4c\origem\correcoes\erro342_tmp\"
gcOut = gcDir + "probe.txt"
STRTOFILE("", gcOut)
LOCAL loE, loForm, loPag, loO, lnI
TRY
    DO ("C:\4c\projeto\app\start\config.prg")
    ConfigurarAmbiente()
    PUBLIC gnConnHandle
    gnConnHandle = SQLSTRINGCONNECT(ObterStringConexao())
    go_4c_Sistema.cCodEmpresa = "001"
    GarantirClasse("FormSIGREEQR")
    loForm = CREATEOBJECT("FormSIGREEQR")
    L("form = " + VARTYPE(loForm))
    IF VARTYPE(loForm) # "O"
        L("FORM NAO ABRIU")
    ELSE
        SET DATASESSION TO loForm.DataSessionId
        loPag = loForm.pgf_4c_Paginas.Page1
        L("Caption = [" + loForm.Caption + "]")
        L("")
        L("=== GEOMETRIA DOS CONTROLES DA PAGINA ===")
        L(PADR("objeto",26) + PADL("top",5) + PADL("left",6) + PADL("w",6) + PADL("h",6) + "  caption")
        FOR lnI = 1 TO loPag.ControlCount
            loO = loPag.Controls(lnI)
            L(PADR(loO.Name, 26) + PADL(loO.Top,5) + PADL(loO.Left,6) + ;
              PADL(loO.Width,6) + PADL(loO.Height,6) + "  " + ;
              IIF(PEMSTATUS(loO, "Caption", 5), loO.Caption, ""))
        ENDFOR
        L("")
        L("=== OPTIONGROUPS: legendas e larguras ===")
        FOR lnI = 1 TO 2
            L("optRfestoque.Buttons(" + TRANSFORM(lnI) + ") [" + ;
              loPag.obj_4c_OptRfestoque.Buttons(lnI).Caption + "] top=" + ;
              TRANSFORM(loPag.obj_4c_OptRfestoque.Buttons(lnI).Top) + " left=" + ;
              TRANSFORM(loPag.obj_4c_OptRfestoque.Buttons(lnI).Left) + " w=" + ;
              TRANSFORM(loPag.obj_4c_OptRfestoque.Buttons(lnI).Width))
        ENDFOR
        FOR lnI = 1 TO 2
            L("optCalcusto.Buttons(" + TRANSFORM(lnI) + ")  [" + ;
              loPag.obj_4c_OptCalcusto.Buttons(lnI).Caption + "] top=" + ;
              TRANSFORM(loPag.obj_4c_OptCalcusto.Buttons(lnI).Top) + " left=" + ;
              TRANSFORM(loPag.obj_4c_OptCalcusto.Buttons(lnI).Left) + " w=" + ;
              TRANSFORM(loPag.obj_4c_OptCalcusto.Buttons(lnI).Width))
        ENDFOR
        L("")
        L("=== ICONES DOS BOTOES DA GRADE ===")
        L("SelTudo.Picture = [" + loPag.cmd_4c_SelTudo.Picture + "] existe=" + ;
          TRANSFORM(FILE(loPag.cmd_4c_SelTudo.Picture)))
        L("Apaga.Picture   = [" + loPag.cmd_4c_Apaga.Picture + "] existe=" + ;
          TRANSFORM(FILE(loPag.cmd_4c_Apaga.Picture)))
        L("")
        L("=== GRADE DE SELECAO ===")
        L("Selecao = " + TRANSFORM(IIF(USED("Selecao"), RECCOUNT("Selecao"), -1)) + " linhas")
    ENDIF
CATCH TO loE
    L("ERRO " + TRANSFORM(loE.ErrorNo) + " linha " + TRANSFORM(loE.LineNo) + " " + loE.Message + " | " + loE.Procedure)
ENDTRY
L("FIM")
QUIT
PROCEDURE L(par_c)
    STRTOFILE(par_c + CHR(13) + CHR(10), gcOut, 1)
ENDPROC

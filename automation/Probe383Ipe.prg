SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
PUBLIC gcL, gb_4c_ModoTeste, gc_4c_ArquivoErroTeste
gcL = "C:\4c\automation\probe383ipe.txt"
gb_4c_ModoTeste = .T.
gc_4c_ArquivoErroTeste = "C:" + CHR(92) + "4c" + CHR(92) + "automation" + CHR(92) + "probe383ipe_dialogs.txt"
STRTOFILE("Formsigreipe - Erro383" + CHR(13)+CHR(10), gcL)

DO ("C:\4c\projeto\app\start\config.prg")
ConfigurarAmbiente()
PUBLIC gnConnHandle
gnConnHandle = SQLSTRINGCONNECT(ObterStringConexao())
LIpe("gnConnHandle=" + TRANSFORM(gnConnHandle))
IF gnConnHandle > 0
    SQLSETPROP(gnConnHandle, "QueryTimeOut", 180)
    SQLSETPROP(gnConnHandle, "DispWarnings", .F.)
    IF TYPE("go_4c_Sistema") = "O"
        go_4c_Sistema.cCodEmpresa = "001"
    ENDIF
ENDIF
GarantirClasse("Formsigreipe")

LOCAL loF, loPg, loG, loE, lnI
loF = CREATEOBJECT("Formsigreipe")
LIpe("form VARTYPE=" + VARTYPE(loF))
IF VARTYPE(loF) = "O"
    SET DATASESSION TO (loF.DataSessionId)
    loPg = loF.pgf_4c_Paginas.Page1
    loG  = loPg.grd_4c_GrdOper

    LIpe("")
    LIpe("--- grade ANTES da busca ---")
    DumpG(loG)

    *-- preenche como o usuario faria e dispara o LostFocus da data final
    loPg.txt_4c__nm_operacao.Value = "VENDA"
    loPg.txt_4c__dt_inicial.Value  = DATE(2023, 1, 1)
    loPg.txt_4c__dt_final.Value    = DATE(2026, 12, 31)
    loPg.obj_4c_Opt_conta.Value    = 2
    LIpe("")
    LIpe("chamando TxtDtFinalLostFocus() ...")
    TRY
        loF.TxtDtFinalLostFocus()
    CATCH TO loE
        LIpe(">>> EXCECAO: " + loE.Message + " linha " + TRANSFORM(loE.LineNo))
    ENDTRY
    IF USED("cursor_4c_Operacoes")
        SELECT cursor_4c_Operacoes
        LIpe("cursor_4c_Operacoes RECCOUNT=" + TRANSFORM(RECCOUNT()))
    ELSE
        LIpe("cursor_4c_Operacoes NAO EXISTE")
    ENDIF
    LIpe("")
    LIpe("--- grade DEPOIS da busca ---")
    DumpG(loG)

    *-- marca todas as linhas e chama o Visualizar real
    IF USED("cursor_4c_Operacoes")
        SELECT cursor_4c_Operacoes
        SCAN
            REPLACE Marcas WITH 1
        ENDSCAN
        GO TOP
    ENDIF
    LIpe("")
    LIpe("chamando BtnVisualizarClick() ...")
    TRY
        loF.BtnVisualizarClick()
        LIpe("BtnVisualizarClick retornou")
    CATCH TO loE
        LIpe(">>> EXCECAO: " + loE.Message + " linha " + TRANSFORM(loE.LineNo))
    ENDTRY
    LIpe("BO msg=[" + loF.this_oRelatorio.ObterMensagemErro() + "]")
    IF USED("Relacao")
        SELECT Relacao
        LIpe("Relacao RECCOUNT=" + TRANSFORM(RECCOUNT()))
    ELSE
        LIpe("Relacao NAO EXISTE")
    ENDIF

    *-- layout do form
    LIpe("")
    LIpe("FORM Width=" + TRANSFORM(loF.Width) + " Height=" + TRANSFORM(loF.Height))
    SET DATASESSION TO 1
ENDIF
LIpe("FIM")
QUIT

PROCEDURE DumpG(par_oG)
    LOCAL lnI, lcLin
    LIpe("ColumnCount=" + TRANSFORM(par_oG.ColumnCount) + ;
         " RecordSource=[" + par_oG.RecordSource + "]" + ;
         " Width=" + TRANSFORM(par_oG.Width))
    FOR lnI = 1 TO par_oG.ColumnCount
        lcLin = "   Column" + TRANSFORM(lnI) + ;
                " W=" + PADL(TRANSFORM(par_oG.Columns(lnI).Width), 4) + ;
                " CS=[" + par_oG.Columns(lnI).ControlSource + "]" + ;
                " Hdr=[" + ALLTRIM(par_oG.Columns(lnI).Header1.Caption) + "]" + ;
                " Curr=[" + par_oG.Columns(lnI).CurrentControl + "]"
        LIpe(lcLin)
    ENDFOR
ENDPROC

PROCEDURE LIpe(par_c)
    STRTOFILE(par_c + CHR(13)+CHR(10), gcL, 1)
ENDPROC

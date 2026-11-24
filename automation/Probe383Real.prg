SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
PUBLIC gcL, gb_4c_ModoTeste, gc_4c_ArquivoErroTeste
gcL = "C:\4c\automation\probe383real.txt"
gb_4c_ModoTeste = .T.
gc_4c_ArquivoErroTeste = "C:" + CHR(92) + "4c" + CHR(92) + "automation" + CHR(92) + "probe383_dialogs.txt"
STRTOFILE("CAMINHO REAL: BtnVisualizarClick()" + CHR(13)+CHR(10), gcL)

DO ("C:\4c\projeto\app\start\config.prg")
ConfigurarAmbiente()
PUBLIC gnConnHandle
gnConnHandle = SQLSTRINGCONNECT(ObterStringConexao())
L383("gnConnHandle=" + TRANSFORM(gnConnHandle))
IF gnConnHandle > 0
    SQLSETPROP(gnConnHandle, "QueryTimeOut", 180)
    SQLSETPROP(gnConnHandle, "DispWarnings", .F.)
    IF TYPE("go_4c_Sistema") = "O"
        go_4c_Sistema.cCodEmpresa = "001"
    ENDIF
ENDIF
GarantirClasse("Formsigreinr")

LOCAL loF, loPg, loE
loF = CREATEOBJECT("Formsigreinr", 3)
L383("form VARTYPE=" + VARTYPE(loF))
IF VARTYPE(loF) = "O"
    loPg = loF.pgf_4c_Paginas.Page1
    *-- parametros do screenshot do Erro381 (tudo "Sim")
    loPg.optg_4c_TipoRel.Value     = 1
    loPg.optg_4c_TipoDif.Value     = 2
    loPg.optg_4c_TipoLeitura.Value = 1
    loPg.optg_4c_TipoAnal.Value    = 1
    loPg.optg_4c_TpCusto.Value     = 1
    loPg.optg_4c_TpVenda.Value     = 1
    loPg.optg_4c_Foto.Value        = 1
    loPg.optg_4c_Etiq.Value        = 1
    loPg.optg_4c_Obs.Value         = 1
    loPg.optg_4c_Ctg.Value         = 1
    loPg.optg_4c_Col.Value         = 1
    L383("controles setados; chamando BtnVisualizarClick() ...")
    TRY
        loF.BtnVisualizarClick()
        L383("BtnVisualizarClick RETORNOU sem bloquear")
    CATCH TO loE
        L383(">>> EXCECAO em BtnVisualizarClick: " + loE.Message + ;
             " | linha " + TRANSFORM(loE.LineNo) + " | proc " + loE.Procedure)
    ENDTRY
    L383("BO msg=[" + loF.this_oRelatorio.ObterMensagemErro() + "]")
ENDIF
L383("FIM")
QUIT

PROCEDURE L383(par_c)
    STRTOFILE(par_c + CHR(13)+CHR(10), gcL, 1)
ENDPROC

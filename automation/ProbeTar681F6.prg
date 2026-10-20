*==============================================================================
* ProbeTar681F6.prg - Instancia FormSigPrTar headless (Fase 6 / task681) e
* MEDE as propriedades que a Fase 6 alterou: as Width do cabecalho (que agora
* derivam de THIS.Width em vez do literal 800/769 do SCX) e o Closable (que
* deve voltar a .T., o default, por nao ser declarado no SCX legado).
* NAO chama ConfigurarAmbiente() (nao retorna nesta maquina).
*==============================================================================
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF

PUBLIC gb_4c_ModoTeste, gb_4c_ValidandoUI, gc_4c_ArquivoErroTeste
gb_4c_ModoTeste        = .T.
gb_4c_ValidandoUI      = .T.
gc_4c_ArquivoErroTeste = "C:\4c\automation\vfp_error_tar681.txt"
IF FILE(gc_4c_ArquivoErroTeste)
    DELETE FILE (gc_4c_ArquivoErroTeste)
ENDIF

LOCAL loc_cOut, loc_oForm, loc_oErro
loc_cOut = "C:\4c\automation\probe_tar681_result.txt"
STRTOFILE("INICIO", loc_cOut)

TRY
    CD C:\4c\projeto\app\start
    DO config.prg
    gb_4c_ModoTeste   = .T.
    gb_4c_ValidandoUI = .T.

    SET PATH TO (gcCaminhoBase + "," + gcCaminhoClasses + "," + gcCaminhoUtils + ;
                 "," + gcCaminhoForms + "," + gcCaminhoIcones)
    SET PROCEDURE TO (gcCaminhoClasses + "dataaccess.prg")   ADDITIVE
    SET PROCEDURE TO (gcCaminhoClasses + "businessbase.prg") ADDITIVE
    SET PROCEDURE TO (gcCaminhoClasses + "formbase.prg")     ADDITIVE
    SET PROCEDURE TO (gcCaminhoClasses + "gridbase.prg")     ADDITIVE
    SET PROCEDURE TO (gcCaminhoClasses + "FormErro.prg")     ADDITIVE
    SET PROCEDURE TO (gcCaminhoUtils   + "functions.prg")    ADDITIVE
    SET PROCEDURE TO (gcCaminhoUtils   + "messages.prg")     ADDITIVE
    SET PROCEDURE TO (gcCaminhoUtils   + "validators.prg")   ADDITIVE
    SET PROCEDURE TO (gcCaminhoClasses + "SigPrTarBO.prg")   ADDITIVE
    SET PROCEDURE TO (gcCaminhoForms + "operacionais\FormSigPrTar.prg") ADDITIVE
    STRTOFILE(CHR(13)+CHR(10)+"deps OK", loc_cOut, 1)

    loc_oForm = CREATEOBJECT("FormSigPrTar")
    STRTOFILE(CHR(13)+CHR(10)+"CREATEOBJECT=" + VARTYPE(loc_oForm), loc_cOut, 1)

    IF VARTYPE(loc_oForm) = "O"
        STRTOFILE(CHR(13)+CHR(10)+"Form.Width ......... " + TRANSFORM(loc_oForm.Width), loc_cOut, 1)
        STRTOFILE(CHR(13)+CHR(10)+"Form.Height ........ " + TRANSFORM(loc_oForm.Height), loc_cOut, 1)
        STRTOFILE(CHR(13)+CHR(10)+"Form.Closable ...... " + TRANSFORM(loc_oForm.Closable) + "  (legado NAO declara -> esperado .T.)", loc_cOut, 1)
        STRTOFILE(CHR(13)+CHR(10)+"Form.MaxButton ..... " + TRANSFORM(loc_oForm.MaxButton) + "  (legado declara .F.)", loc_cOut, 1)
        STRTOFILE(CHR(13)+CHR(10)+"Form.MinButton ..... " + TRANSFORM(loc_oForm.MinButton) + "  (legado declara .F.)", loc_cOut, 1)
        STRTOFILE(CHR(13)+CHR(10)+"Form.TitleBar ...... " + TRANSFORM(loc_oForm.TitleBar), loc_cOut, 1)

        STRTOFILE(CHR(13)+CHR(10)+"cnt_4c_Sombra.Width ............ " + TRANSFORM(loc_oForm.cnt_4c_Sombra.Width), loc_cOut, 1)
        STRTOFILE(CHR(13)+CHR(10)+"cnt_4c_Sombra.Left+Width ....... " + TRANSFORM(loc_oForm.cnt_4c_Sombra.Left + loc_oForm.cnt_4c_Sombra.Width) + "  (<= Form.Width ?)", loc_cOut, 1)
        STRTOFILE(CHR(13)+CHR(10)+"lbl_4c_LblSombra.Width ......... " + TRANSFORM(loc_oForm.cnt_4c_Sombra.lbl_4c_LblSombra.Width), loc_cOut, 1)
        STRTOFILE(CHR(13)+CHR(10)+"lbl_4c_LblSombra.Left+Width .... " + TRANSFORM(loc_oForm.cnt_4c_Sombra.lbl_4c_LblSombra.Left + loc_oForm.cnt_4c_Sombra.lbl_4c_LblSombra.Width) + "  (<= cnt.Width ?)", loc_cOut, 1)
        STRTOFILE(CHR(13)+CHR(10)+"lbl_4c_LblTitulo.Width ......... " + TRANSFORM(loc_oForm.cnt_4c_Sombra.lbl_4c_LblTitulo.Width), loc_cOut, 1)
        STRTOFILE(CHR(13)+CHR(10)+"lbl_4c_LblTitulo.Caption ....... [" + loc_oForm.cnt_4c_Sombra.lbl_4c_LblTitulo.Caption + "]", loc_cOut, 1)
        STRTOFILE(CHR(13)+CHR(10)+"lbl_4c_LblTitulo.ForeColor ..... " + TRANSFORM(loc_oForm.cnt_4c_Sombra.lbl_4c_LblTitulo.ForeColor), loc_cOut, 1)

        STRTOFILE(CHR(13)+CHR(10)+"cmd_4c_CmdSair.Left+Width ...... " + TRANSFORM(loc_oForm.cmd_4c_CmdSair.Left + loc_oForm.cmd_4c_CmdSair.Width), loc_cOut, 1)
        STRTOFILE(CHR(13)+CHR(10)+"cmd_4c_CmdSair.Cancel .......... " + TRANSFORM(loc_oForm.cmd_4c_CmdSair.Cancel), loc_cOut, 1)
        STRTOFILE(CHR(13)+CHR(10)+"obj_4c_GetObsInsp.ReadOnly ..... " + TRANSFORM(loc_oForm.obj_4c_GetObsInsp.ReadOnly), loc_cOut, 1)
        STRTOFILE(CHR(13)+CHR(10)+"obj_4c_GetObsInsp.Format ....... [" + loc_oForm.obj_4c_GetObsInsp.Format + "]", loc_cOut, 1)
        STRTOFILE(CHR(13)+CHR(10)+"obj_4c_GetObsInsp.Left+Width ... " + TRANSFORM(loc_oForm.obj_4c_GetObsInsp.Left + loc_oForm.obj_4c_GetObsInsp.Width), loc_cOut, 1)
        STRTOFILE(CHR(13)+CHR(10)+"lbl_4c_Label1.Alignment ........ " + TRANSFORM(loc_oForm.lbl_4c_Label1.Alignment), loc_cOut, 1)

        *-- Fase 6: confirma que NAO foi inventado lookup nem botao de acao CRUD
        STRTOFILE(CHR(13)+CHR(10)+"PEM AbrirLookup* ............... " + TRANSFORM(PEMSTATUS(loc_oForm,"AbrirLookupGrupo",5)), loc_cOut, 1)
        STRTOFILE(CHR(13)+CHR(10)+"PEM cnt_4c_BotoesAcao .......... " + TRANSFORM(PEMSTATUS(loc_oForm,"cnt_4c_BotoesAcao",5)) + "  (esperado .F.)", loc_cOut, 1)
        STRTOFILE(CHR(13)+CHR(10)+"PEM CarregarLista (PUBLIC) ..... " + TRANSFORM(PEMSTATUS(loc_oForm,"CarregarLista",5)), loc_cOut, 1)
        STRTOFILE(CHR(13)+CHR(10)+"CarregarLista() .............. " + TRANSFORM(loc_oForm.CarregarLista()), loc_cOut, 1)
        STRTOFILE(CHR(13)+CHR(10)+"ControlCount ................... " + TRANSFORM(loc_oForm.ControlCount), loc_cOut, 1)

        loc_oForm.Release()
    ENDIF

    STRTOFILE(CHR(13)+CHR(10)+"FIM OK", loc_cOut, 1)
CATCH TO loc_oErro
    STRTOFILE(CHR(13)+CHR(10)+"ERRO: " + loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + " PROC=" + loc_oErro.Procedure, loc_cOut, 1)
ENDTRY

QUIT

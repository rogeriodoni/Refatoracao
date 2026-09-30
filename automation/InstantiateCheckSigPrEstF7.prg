SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF

PUBLIC gb_4c_ModoTeste, gc_4c_ArquivoErroTeste
LOCAL loc_cRes, loc_oForm, loc_oErro, loc_cArq, loc_nAntes, loc_nDepois
loc_cRes = "FAIL"
loc_cArq = "C:\4c\automation\vfp_error_sigprest_f7.txt"

TRY
    CD C:\4c\projeto\app\start
    DO config.prg
    SET PROCEDURE TO (gcCaminhoClasses + "businessbase.prg") ADDITIVE
    SET PROCEDURE TO (gcCaminhoClasses + "formbase.prg") ADDITIVE
    SET PROCEDURE TO (gcCaminhoClasses + "dataaccess.prg") ADDITIVE
    SET PROCEDURE TO (gcCaminhoClasses + "fwprogressbar.prg") ADDITIVE
    SET PROCEDURE TO (gcCaminhoClasses + "FormErro.prg") ADDITIVE
    SET PROCEDURE TO (gcCaminhoUtils + "functions.prg") ADDITIVE
    SET PROCEDURE TO (gcCaminhoUtils + "messages.prg") ADDITIVE
    SET PROCEDURE TO (gcCaminhoClasses + "SIGPRESTBO.prg") ADDITIVE
    SET PROCEDURE TO (gcCaminhoForms + "operacionais\FormSIGPREST.prg") ADDITIVE

    *-- Setado DEPOIS de config.prg (config.prg repoe as flags de teste)
    gb_4c_ModoTeste = .T.
    gc_4c_ArquivoErroTeste = loc_cArq
    IF FILE(loc_cArq)
        DELETE FILE (loc_cArq)
    ENDIF

    loc_oForm = CREATEOBJECT("FormSIGPREST")

    IF VARTYPE(loc_oForm) = "O"
        loc_cRes = "OK W=" + TRANSFORM(loc_oForm.Width) + " H=" + TRANSFORM(loc_oForm.Height) + ;
            " | Gerar.Ena=" + TRANSFORM(loc_oForm.cmd_4c_OK.Enabled) + ;
            " Encerrar.Ena=" + TRANSFORM(loc_oForm.cmd_4c_Cancela.Enabled) + ;
            " chkEstrut=" + TRANSFORM(loc_oForm.chk_4c_GeraArquivos.Value) + ;
            " chkIndice=" + TRANSFORM(loc_oForm.chk_4c_GeraIndices.Value) + ;
            " BO=" + VARTYPE(loc_oForm.this_oBusinessObject)

        *-- CENARIO A: indices SEM estrutura, ArqDBF.DBF inexistente.
        *-- Legado: UM Messagebox + "Processamento Interrompido." + reabilita.
        loc_oForm.chk_4c_GeraArquivos.Value = 0
        loc_oForm.chk_4c_GeraIndices.Value  = 1
        loc_oForm.BtnOKClick()
        loc_cRes = loc_cRes + CHR(13) + CHR(10) + "CENARIO-A(IndSemEstrut): Msg=[" + ;
            ALLTRIM(loc_oForm.lbl_4c_Mensagem.Caption) + "]" + ;
            " Gerar.Ena=" + TRANSFORM(loc_oForm.cmd_4c_OK.Enabled) + ;
            " Encerrar.Ena=" + TRANSFORM(loc_oForm.cmd_4c_Cancela.Enabled) + ;
            " DialogosAteAqui=" + TRANSFORM(OCCURS("[", IIF(FILE(loc_cArq), FILETOSTR(loc_cArq), "")))

        *-- CENARIO B: repetir o clique - prova que a flag this_lErroExibido
        *-- foi reposta e o aviso NAO eh engolido na 2a vez.
        loc_oForm.BtnOKClick()
        loc_cRes = loc_cRes + CHR(13) + CHR(10) + "CENARIO-B(2oClique): Msg=[" + ;
            ALLTRIM(loc_oForm.lbl_4c_Mensagem.Caption) + "]" + ;
            " Gerar.Ena=" + TRANSFORM(loc_oForm.cmd_4c_OK.Enabled) + ;
            " DialogosAteAqui=" + TRANSFORM(OCCURS("[", IIF(FILE(loc_cArq), FILETOSTR(loc_cArq), "")))

        *-- CENARIO D: forca EXCECAO (SET DEFAULT para pasta inexistente) com
        *-- APENAS Estrutura marcada. O CATCH do BO exibe MsgErro e marca
        *-- this_lErroExibido; o BtnOKClick NAO pode repetir o texto num
        *-- MsgAviso. Antes da correcao este clique produzia DOIS dialogos.
        loc_oForm.chk_4c_GeraArquivos.Value = 1
        loc_oForm.chk_4c_GeraIndices.Value  = 0
        loc_oForm.this_oBusinessObject.this_cCaminhoBaseDados = "C:\4c\__nao_existe__\"
        loc_nAntes = OCCURS("[", IIF(FILE(loc_cArq), FILETOSTR(loc_cArq), ""))
        loc_oForm.BtnOKClick()
        loc_nDepois = OCCURS("[", IIF(FILE(loc_cArq), FILETOSTR(loc_cArq), ""))
        loc_cRes = loc_cRes + CHR(13) + CHR(10) + "CENARIO-D(Excecao): Msg=[" + ;
            ALLTRIM(loc_oForm.lbl_4c_Mensagem.Caption) + "]" + ;
            " DialogosNesteClique=" + TRANSFORM(loc_nDepois - loc_nAntes) + ;
            " ErroExibido=" + TRANSFORM(loc_oForm.this_oBusinessObject.this_lErroExibido) + ;
            " Gerar.Ena=" + TRANSFORM(loc_oForm.cmd_4c_OK.Enabled)

        *-- CENARIO C: Encerrar (BtnCancelaClick) - Release do form
        loc_oForm.BtnCancelaClick()
        loc_cRes = loc_cRes + CHR(13) + CHR(10) + "CENARIO-C(Encerrar): VARTYPE pos-Release=" + VARTYPE(loc_oForm)
    ELSE
        loc_cRes = "FAIL VARTYPE=" + VARTYPE(loc_oForm)
    ENDIF
CATCH TO loc_oErro
    loc_cRes = loc_cRes + CHR(13) + CHR(10) + "EXCEPTION: " + loc_oErro.Message + ;
               " Linha:" + TRANSFORM(loc_oErro.LineNo) + " Proc:" + loc_oErro.Procedure
ENDTRY

IF FILE(loc_cArq)
    loc_cRes = loc_cRes + CHR(13) + CHR(10) + "--- DIALOGOS REGISTRADOS ---" + CHR(13) + CHR(10) + FILETOSTR(loc_cArq)
ELSE
    loc_cRes = loc_cRes + CHR(13) + CHR(10) + "--- NENHUM DIALOGO REGISTRADO ---"
ENDIF

STRTOFILE(loc_cRes, "C:\4c\automation\instantiate_sigprest_f7_result.txt")
QUIT

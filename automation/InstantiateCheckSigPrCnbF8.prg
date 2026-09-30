*==============================================================================
* InstantiateCheckSigPrCnbF8.prg - Verificacao da Fase 8 de FormSIGPRCNB
*
* Instancia o form e exercita os aditivos da Fase 8: obj_4c_Comandos (Gerar
* CNAB/Relatorio/Boleto), BtnGerarCnabClick/BtnRelatorioCnabClick/
* BtnBoletoClick com o grid de titulos vazio (deve avisar e nao estourar) e
* ExecutarReportForm com FRX ausente (deve avisar "arquivo nao encontrado").
*
* gnConnHandle eh forjado como handle NAO CONECTADO (>0 mas invalido) porque
* os testes de InstantiateCheck deste projeto so fazem DO config.prg +
* ConfigurarAmbiente() (que so monta o PATH/carrega classes) - quem realmente
* declara gnConnHandle eh main.prg, que abre READ EVENTS e nao serve para
* teste headless. Handle forjado permite passar do gate "gnConnHandle <= 0"
* do InicializarForm e exercitar toda a construcao de Page1/Page2 (incluindo
* os aditivos desta fase); os SQLEXEC subsequentes falham com excecao
* (handle invalido - regra CLAUDE.md sobre SQLEXEC com handle invalido
* disparar excecao), capturada pelos proprios TRY/CATCH de cada metodo.
*
* Execucao unattended: SET SAFETY OFF + SET RESOURCE OFF (pipeline noturno).
*==============================================================================
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF

PUBLIC gb_4c_ModoTeste, gc_4c_ArquivoErroTeste, gnConnHandle
gb_4c_ModoTeste = .T.
gc_4c_ArquivoErroTeste = "C:\4c\automation\vfp_error_sigprcnb_f8.txt"
IF FILE(gc_4c_ArquivoErroTeste)
    DELETE FILE (gc_4c_ArquivoErroTeste)
ENDIF
gnConnHandle = 1

LOCAL loc_cRes, loc_oForm, loc_oErro, loc_oCmds, loc_oPag2
loc_cRes = "FAIL"

TRY
    CD C:\4c\projeto\app\start
    DO config.prg
    ConfigurarAmbiente()

    loc_oForm = CREATEOBJECT("FormSIGPRCNB")

    IF VARTYPE(loc_oForm) = "O"
        loc_cRes = "OK W=" + TRANSFORM(loc_oForm.Width) + " H=" + TRANSFORM(loc_oForm.Height)

        loc_oPag2 = loc_oForm.pgf_4c_Paginas.Page2
        loc_oCmds = loc_oPag2.cnt_4c_BotoesAcao.obj_4c_Comandos

        loc_cRes = loc_cRes + CHR(13) + CHR(10) + ;
            "[1] obj_4c_Comandos: ButtonCount=" + TRANSFORM(loc_oCmds.ButtonCount) + ;
            " B1Cap=[" + loc_oCmds.Buttons(1).Caption + "]" + ;
            " B2Cap=[" + loc_oCmds.Buttons(2).Caption + "]" + ;
            " B3Cap=[" + loc_oCmds.Buttons(3).Caption + "]" + ;
            " B3Enabled(inicial)=" + TRANSFORM(loc_oCmds.Buttons(3).Enabled)

        *-- Grid de titulos vazio (nunca chamou Processar) - os 3 botoes tem
        *-- de avisar e devolver o form vivo, sem estourar exception.
        loc_oForm.BtnGerarCnabClick()
        loc_cRes = loc_cRes + CHR(13) + CHR(10) + ;
            "[2] BtnGerarCnabClick(grid vazio): form vivo=" + TRANSFORM(VARTYPE(loc_oForm) = "O")

        loc_oForm.BtnRelatorioCnabClick()
        loc_cRes = loc_cRes + CHR(13) + CHR(10) + ;
            "[3] BtnRelatorioCnabClick(grid vazio): form vivo=" + TRANSFORM(VARTYPE(loc_oForm) = "O")

        loc_oForm.BtnBoletoClick()
        loc_cRes = loc_cRes + CHR(13) + CHR(10) + ;
            "[4] BtnBoletoClick(grid vazio, handle invalido): form vivo=" + TRANSFORM(VARTYPE(loc_oForm) = "O")

        *-- ExecutarReportForm com FRX que nao existe no acervo - tem que
        *-- avisar e devolver .F., nunca abrir preview vazio.
        loc_cRes = loc_cRes + CHR(13) + CHR(10) + ;
            "[5] ExecutarReportForm(FRX ausente)=" + TRANSFORM(loc_oForm.ExecutarReportForm("SigReCnbNaoExiste", "PREVIEW"))

        *-- Marca 1 titulo "na unha" direto no cursor e testa de novo, para
        *-- passar da guarda de "nenhum registro selecionado" e chegar no
        *-- SQLEXEC (handle invalido) dentro de GerarArquivoCnab.
        IF USED("cursor_4c_Titulos")
            SELECT cursor_4c_Titulos
            APPEND BLANK
            REPLACE Marca WITH .T., Titulos WITH "12345678", Dopes WITH "TESTE", EmpDopNums WITH "001TESTE0000000000000000000", Nopers WITH 1
        ENDIF
        loc_oForm.pgf_4c_Paginas.Page1.txt_4c_CodEmpresa.Value = "001"
        loc_oForm.pgf_4c_Paginas.Page1.txt_4c_CodConta.Value   = "0000000001"
        loc_oForm.BtnGerarCnabClick()
        loc_cRes = loc_cRes + CHR(13) + CHR(10) + ;
            "[6] BtnGerarCnabClick(1 marcado, handle invalido): form vivo=" + TRANSFORM(VARTYPE(loc_oForm) = "O")

        loc_oForm.Release()
    ELSE
        loc_cRes = "FAIL VARTYPE=" + VARTYPE(loc_oForm)
    ENDIF
CATCH TO loc_oErro
    loc_cRes = loc_cRes + CHR(13) + CHR(10) + "EXCEPTION: " + loc_oErro.Message + ;
               " Linha:" + TRANSFORM(loc_oErro.LineNo) + " Proc:" + loc_oErro.Procedure
ENDTRY

IF FILE("C:\4c\automation\vfp_error_sigprcnb_f8.txt")
    loc_cRes = loc_cRes + CHR(13) + CHR(10) + "DIALOGOS: " + FILETOSTR("C:\4c\automation\vfp_error_sigprcnb_f8.txt")
ENDIF

STRTOFILE(loc_cRes, "C:\4c\automation\instantiate_sigprcnb_f8_result.txt")
QUIT

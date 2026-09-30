*==============================================================================
* InstantiateCheckSigPrCpdF8.prg - Verificacao final (Fase 8) de Formsigprcpd
*
* Instancia o form em modo teste (gb_4c_ModoTeste=.T.) e confere se a
* estrutura de controles (ConfigurarPageFrame) foi montada mesmo sem
* conexao SQL disponivel - mesmo padrao dos demais forms do projeto
* (FORMCOR_LICOES_APRENDIDAS.md Problema 4: sempre monta estrutura, so
* pula o metodo que depende de SQL).
*==============================================================================
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF

PUBLIC gb_4c_ModoTeste, gc_4c_ArquivoErroTeste, gnConnHandle
gb_4c_ModoTeste = .T.
gc_4c_ArquivoErroTeste = "C:\4c\automation\vfp_error_sigprcpd_f8.txt"
IF FILE(gc_4c_ArquivoErroTeste)
    DELETE FILE (gc_4c_ArquivoErroTeste)
ENDIF
gnConnHandle = 1

LOCAL loc_cRes, loc_oForm, loc_oErro
loc_cRes = "FAIL"

TRY
    CD C:\4c\projeto\app\start
    DO config.prg
    ConfigurarAmbiente()

    loc_oForm = CREATEOBJECT("Formsigprcpd", "", "", DATE(), 0)

    IF VARTYPE(loc_oForm) = "O"
        loc_cRes = "OK W=" + TRANSFORM(loc_oForm.Width) + " H=" + TRANSFORM(loc_oForm.Height)
        loc_cRes = loc_cRes + CHR(13) + CHR(10) + ;
            "PEMSTATUS(grd_4c_Dados)=" + TRANSFORM(PEMSTATUS(loc_oForm, "grd_4c_Dados", 5)) + CHR(13) + CHR(10) + ;
            "PEMSTATUS(cmd_4c_Sair)=" + TRANSFORM(PEMSTATUS(loc_oForm, "cmd_4c_Sair", 5)) + CHR(13) + CHR(10) + ;
            "PEMSTATUS(cnt_4c_Cabecalho)=" + TRANSFORM(PEMSTATUS(loc_oForm, "cnt_4c_Cabecalho", 5))
        loc_oForm.Release()
    ELSE
        loc_cRes = "FAIL VARTYPE=" + VARTYPE(loc_oForm)
    ENDIF

CATCH TO loc_oErro
    loc_cRes = "EXCEPTION: " + loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + " PROC=" + loc_oErro.Procedure
ENDTRY

STRTOFILE(loc_cRes, "C:\4c\automation\instantiate_sigprcpd_f8_result.txt")
QUIT

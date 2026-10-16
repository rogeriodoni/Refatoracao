*==============================================================================
* TesteSigPrIns_fase3.prg
* Teste pontual (sem SQL Server): compila e instancia FormSigPrIns
* para validar a estrutura basica criada na Fase 3 (task630).
*==============================================================================
SET SAFETY OFF
SET RESOURCE OFF

PUBLIC gb_4c_ModoTeste, gc_4c_ArquivoErroTeste
gb_4c_ModoTeste = .T.
gc_4c_ArquivoErroTeste = "C:\4c\automation\teste_sigprins_erro.txt"
IF FILE(gc_4c_ArquivoErroTeste)
    DELETE FILE (gc_4c_ArquivoErroTeste)
ENDIF

LOCAL loc_cResultado, loc_oForm, loc_oErro
loc_cResultado = "C:\4c\automation\teste_sigprins_resultado.txt"
IF FILE(loc_cResultado)
    DELETE FILE (loc_cResultado)
ENDIF

TRY
    CD C:\4c\projeto\app\start
    DO config.prg
    ConfigurarAmbiente()

    loc_oForm = CREATEOBJECT("FormSigPrIns")

    IF VARTYPE(loc_oForm) = "O"
        STRTOFILE("OK - CREATEOBJECT retornou objeto" + CHR(13) + ;
                  "Class: " + loc_oForm.Class + CHR(13) + ;
                  "Width/Height: " + TRANSFORM(loc_oForm.Width) + "/" + TRANSFORM(loc_oForm.Height) + CHR(13) + ;
                  "Caption: " + loc_oForm.Caption + CHR(13) + ;
                  "this_oBusinessObject: " + TYPE("loc_oForm.this_oBusinessObject") + CHR(13) + ;
                  "cnt_4c_Sombra existe: " + TRANSFORM(PEMSTATUS(loc_oForm, "cnt_4c_Sombra", 5)) + CHR(13) + ;
                  "lbl_4c_LblSombra.Caption: " + loc_oForm.cnt_4c_Sombra.lbl_4c_LblSombra.Caption + CHR(13) + ;
                  "lbl_4c_LblTitulo.Caption: " + loc_oForm.cnt_4c_Sombra.lbl_4c_LblTitulo.Caption, loc_cResultado)
        loc_oForm.Release()
    ELSE
        STRTOFILE("FALHOU - CREATEOBJECT retornou: " + TRANSFORM(loc_oForm), loc_cResultado)
    ENDIF
CATCH TO loc_oErro
    STRTOFILE("EXCECAO: " + loc_oErro.Message + CHR(13) + ;
              "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
              "Procedure: " + loc_oErro.Procedure, loc_cResultado)
ENDTRY

QUIT

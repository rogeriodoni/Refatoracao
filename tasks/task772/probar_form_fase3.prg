*==============================================================================
* probar_form_fase3.prg - Prova que FormSIGOPNOP (Fase 3) INSTANCIA de verdade
* e que os dois containers de topo do legado existem com a geometria do SCX.
*==============================================================================
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF

LOCAL lcSaida, loForm, loErro, lcArqSaida
lcArqSaida = "C:\4c\tasks\task772\probar_form_fase3_resultado.txt"
lcSaida    = "M1 inicio" + CHR(13) + CHR(10)
STRTOFILE(lcSaida, lcArqSaida)

PUBLIC gb_4c_ModoTeste, gb_4c_ValidandoUI, gc_4c_ArquivoErroTeste
gb_4c_ModoTeste         = .T.
gb_4c_ValidandoUI       = .T.
gc_4c_ArquivoErroTeste  = "C:\4c\tasks\task772\probar_form_fase3_erros.txt"

CD C:\4c\projeto\app\start
DO config.prg
ConfigurarAmbiente()

lcSaida = lcSaida + "M2 ambiente configurado" + CHR(13) + CHR(10)
STRTOFILE(lcSaida, lcArqSaida)

GarantirClasse("FormSIGOPNOP")
lcSaida = lcSaida + "M3 GarantirClasse ok" + CHR(13) + CHR(10)
STRTOFILE(lcSaida, lcArqSaida)

loForm = .NULL.
TRY
    loForm = CREATEOBJECT("FormSIGOPNOP")
    lcSaida = lcSaida + "CREATEOBJECT VARTYPE=" + VARTYPE(loForm) + CHR(13) + CHR(10)
CATCH TO loErro
    lcSaida = lcSaida + "EXCECAO: " + loErro.Message + ;
              " | Linha: " + TRANSFORM(loErro.LineNo) + ;
              " | Procedure: " + loErro.Procedure + CHR(13) + CHR(10)
ENDTRY
STRTOFILE(lcSaida, lcArqSaida)

IF VARTYPE(loForm) = "O"
    lcSaida = lcSaida + "Caption=[" + loForm.Caption + "]" + CHR(13) + CHR(10)
    lcSaida = lcSaida + "BaseClass=[" + loForm.BaseClass + "] Width=" + ;
              TRANSFORM(loForm.Width) + " Height=" + TRANSFORM(loForm.Height) + CHR(13) + CHR(10)
    lcSaida = lcSaida + "ControlCount=" + TRANSFORM(loForm.ControlCount) + CHR(13) + CHR(10)

    IF PEMSTATUS(loForm, "cnt_4c_Container1", 5)
        lcSaida = lcSaida + "cnt_4c_Container1: BaseClass=" + loForm.cnt_4c_Container1.BaseClass + ;
                  " Top=" + TRANSFORM(loForm.cnt_4c_Container1.Top) + ;
                  " Left=" + TRANSFORM(loForm.cnt_4c_Container1.Left) + ;
                  " Width=" + TRANSFORM(loForm.cnt_4c_Container1.Width) + ;
                  " Height=" + TRANSFORM(loForm.cnt_4c_Container1.Height) + ;
                  " BackStyle=" + TRANSFORM(loForm.cnt_4c_Container1.BackStyle) + ;
                  " Visible=" + TRANSFORM(loForm.cnt_4c_Container1.Visible) + CHR(13) + CHR(10)
    ELSE
        lcSaida = lcSaida + "cnt_4c_Container1: AUSENTE" + CHR(13) + CHR(10)
    ENDIF

    IF PEMSTATUS(loForm, "cnt_4c_Container2", 5)
        lcSaida = lcSaida + "cnt_4c_Container2: BaseClass=" + loForm.cnt_4c_Container2.BaseClass + ;
                  " Top=" + TRANSFORM(loForm.cnt_4c_Container2.Top) + ;
                  " Left=" + TRANSFORM(loForm.cnt_4c_Container2.Left) + ;
                  " Width=" + TRANSFORM(loForm.cnt_4c_Container2.Width) + ;
                  " Height=" + TRANSFORM(loForm.cnt_4c_Container2.Height) + ;
                  " Visible=" + TRANSFORM(loForm.cnt_4c_Container2.Visible) + CHR(13) + CHR(10)
    ELSE
        lcSaida = lcSaida + "cnt_4c_Container2: AUSENTE" + CHR(13) + CHR(10)
    ENDIF

    lcSaida = lcSaida + "BO VARTYPE=" + VARTYPE(loForm.this_oBusinessObject) + CHR(13) + CHR(10)
    lcSaida = lcSaida + "RESULTADO=INSTANCIOU" + CHR(13) + CHR(10)
    loForm.Release()
ELSE
    lcSaida = lcSaida + "RESULTADO=NAO INSTANCIOU" + CHR(13) + CHR(10)
ENDIF

STRTOFILE(lcSaida, lcArqSaida)
QUIT

SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
SET NOTIFY OFF
=SYS(2335, 0)

*-- Modo UI: pula queries SQL nos form handlers
PUBLIC gb_4c_ValidandoUI
gb_4c_ValidandoUI = .T.

CD C:\4c\projeto\app\start
DO config.prg
ConfigurarAmbiente()

LOCAL loc_lResultado
loc_lResultado = .F.

TRY
    DO ValidarUIFidelity WITH ;
        "C:\4c\tasks\task035\sigreato_form_codigo_fonte.txt", ;
        "Formsigreato"
    loc_lResultado = .T.
CATCH TO loc_oErro
    ? "ERRO: " + loc_oErro.Message
ENDTRY

QUIT

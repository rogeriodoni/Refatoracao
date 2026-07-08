SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
SET NOTIFY OFF
=SYS(2335, 0)

*-- Modo UI: pula queries SQL nos form handlers
PUBLIC gb_4c_ValidandoUI, gnConnHandle
gb_4c_ValidandoUI = .T.
gnConnHandle      = -1   && Conexao invalida (sem banco)

CD C:\4c\projeto\app\start
DO config.prg
ConfigurarAmbiente()

? "=== TESTE UI Formsigreato ==="

LOCAL loc_oForm
loc_lOK = .F.

TRY
    *-- CRITICO: WindowType=0 (modeless) antes de Show() para nao travar em batch mode
    *-- Form usa WindowType=1 em producao; revertemos apenas para o teste
    loc_oForm = CREATEOBJECT("Formsigreato")
    IF VARTYPE(loc_oForm) = "O"
        loc_oForm.WindowType = 0   && Modeless para nao bloquear
        ? "CREATEOBJECT: OK"
        ? "Classe:  " + loc_oForm.Class
        ? "Width:   " + TRANSFORM(loc_oForm.Width)
        ? "Height:  " + TRANSFORM(loc_oForm.Height)
        ? "Visible: " + IIF(loc_oForm.Visible = .T., "Sim", "Nao")
        loc_oForm.Release()
        loc_lOK = .T.
    ELSE
        ? "CREATEOBJECT: FALHOU - tipo: " + VARTYPE(loc_oForm)
    ENDIF
CATCH TO loc_oErro
    ? "ERRO: " + loc_oErro.Message
    ? "Linha: " + TRANSFORM(loc_oErro.LineNo)
    ? "Proc:  " + loc_oErro.Procedure
ENDTRY

IF loc_lOK
    ? "RESULTADO: SUCESSO"
ELSE
    ? "RESULTADO: FALHA"
ENDIF

QUIT

SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF

PUBLIC gcOut
gcOut = "C:\4c\automation\probe784f6.txt"
STRTOFILE("PROBE F6 task784 (FormSigOpPdt) INICIO" + CHR(13) + CHR(10), gcOut)

DO ("C:\4c\projeto\app\start\config.prg")
ConfigurarAmbiente()
GarantirClasse("FormSigOpPdt")

PUBLIC gb_4c_ModoTeste, gc_4c_ArquivoErroTeste, gb_4c_ValidandoUI
gb_4c_ModoTeste        = .T.
gb_4c_ValidandoUI      = .T.
gc_4c_ArquivoErroTeste = "C:\4c\automation\probe784f6_erros.txt"
STRTOFILE("", gc_4c_ArquivoErroTeste)

Log784("ambiente OK")

LOCAL loForm
loForm = CREATEOBJECT("FormSigOpPdt")
Log784("CREATEOBJECT -> VARTYPE=" + VARTYPE(loForm))

IF VARTYPE(loForm) = "O"
    Log784("Form: W=" + TRANSFORM(loForm.Width) + " H=" + TRANSFORM(loForm.Height) + ;
        " Caption=[" + loForm.Caption + "]" + ;
        " OpEscolha=[" + loForm.this_cOpEscolha + "]")

    Log784("Controles no form (raiz): " + TRANSFORM(loForm.ControlCount))

    *-- confirma que nenhum lookup/property nova foi inventada - a
    *-- superficie continua EXATAMENTE a mesma da Fase 5 (9 controles).
    Log784("txt_4c_Procura existe: " + TRANSFORM(PEMSTATUS(loForm, "txt_4c_Procura", 5)))
    Log784("lbl_4c__Procura existe: " + TRANSFORM(PEMSTATUS(loForm, "lbl_4c__Procura", 5)))
    Log784("grd_4c_Dados.ColumnCount: " + TRANSFORM(loForm.grd_4c_Dados.ColumnCount))

    loForm.Release()
    Log784("Release OK")
ELSE
    Log784("FALHA: CREATEOBJECT nao devolveu objeto")
ENDIF

Log784("PROBE F6 FIM")
QUIT

PROCEDURE Log784(par_cTexto)
    STRTOFILE(par_cTexto + CHR(13) + CHR(10), gcOut, 1)
ENDPROC

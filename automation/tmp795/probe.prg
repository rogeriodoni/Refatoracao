SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF

#DEFINE LOGF "C:\4c\automation\tmp795\probe_out.txt"

ON ERROR DO RegLog WITH "ERRO: " + MESSAGE() + " | LINHA " + TRANSFORM(LINENO()) + " | " + PROGRAM()

STRTOFILE("P0 inicio" + CHR(13) + CHR(10), LOGF)

PUBLIC gb_4c_ModoTeste, gc_4c_ArquivoErroTeste, gb_4c_ValidandoUI
gb_4c_ModoTeste        = .T.
gc_4c_ArquivoErroTeste = "C:\4c\automation\tmp795\probe_dialogs.txt"
gb_4c_ValidandoUI      = .F.
STRTOFILE("", gc_4c_ArquivoErroTeste)

CD "C:\4c\projeto\app\start"
DO config.prg
DO RegLog WITH "P1 config.prg carregado"

ConfigurarAmbiente()
DO RegLog WITH "P2 ConfigurarAmbiente OK"

GarantirClasse("FormSIGOPRES")
DO RegLog WITH "P3 GarantirClasse OK"

PUBLIC gnConnHandle
gnConnHandle = 0

LOCAL loForm
loForm = CREATEOBJECT("FormSIGOPRES")
DO RegLog WITH "P4 CREATEOBJECT VARTYPE=" + VARTYPE(loForm)

IF VARTYPE(loForm) = "O"
    DO RegLog WITH "P5 Caption=[" + TRANSFORM(loForm.Caption) + "] W=" + TRANSFORM(loForm.Width) + " H=" + TRANSFORM(loForm.Height)
    DO RegLog WITH "P6 ControlCount=" + TRANSFORM(loForm.ControlCount)
    LOCAL lnI
    FOR lnI = 1 TO loForm.ControlCount
        DO RegLog WITH "    ctrl " + TRANSFORM(lnI) + " = " + loForm.Controls(lnI).Name + ;
            " [" + loForm.Controls(lnI).BaseClass + "] Vis=" + TRANSFORM(loForm.Controls(lnI).Visible)
    ENDFOR
    DO RegLog WITH "P7 Grid.ColumnCount=" + TRANSFORM(loForm.grd_4c_Dados.ColumnCount) + ;
        " RecSrc=[" + loForm.grd_4c_Dados.RecordSource + "]" + ;
        " C1=[" + loForm.grd_4c_Dados.Column1.Header1.Caption + "/" + TRANSFORM(loForm.grd_4c_Dados.Column1.Width) + "]" + ;
        " C2=[" + loForm.grd_4c_Dados.Column2.Header1.Caption + "/" + TRANSFORM(loForm.grd_4c_Dados.Column2.Width) + "]"
    DO RegLog WITH "P8 BO VARTYPE=" + VARTYPE(loForm.this_oBusinessObject) + " this_nSaldo=" + TRANSFORM(loForm.this_nSaldo)
    *-- AEVENTS prova que o BINDEVENT do botao esta registrado
    LOCAL ARRAY laEv[1,1]
    LOCAL lnEv
    lnEv = AEVENTS(laEv, loForm.cmd_4c_Fwbtng1, "Click")
    DO RegLog WITH "P9 AEVENTS Click do botao = " + TRANSFORM(lnEv) + ;
        IIF(lnEv > 0, " -> " + TRANSFORM(laEv[1,4]), "")
    *-- dispara o Click: deve copiar o saldo do BO e esconder a tela
    loForm.cmd_4c_Fwbtng1.Click()
    DO RegLog WITH "P10 apos Click: this_nSaldo=" + TRANSFORM(loForm.this_nSaldo) + ;
        " Visible=" + TRANSFORM(loForm.Visible) + " ainda objeto=" + VARTYPE(loForm)
    loForm.Release()
    DO RegLog WITH "P11 Release OK"
ENDIF

DO RegLog WITH "FIM"
QUIT

PROCEDURE RegLog
    LPARAMETERS pcMsg
    STRTOFILE(pcMsg + CHR(13) + CHR(10), LOGF, 1)
ENDPROC

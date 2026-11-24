*==============================================================================
* _p813b.prg - Probe de BINDEVENT do Click de cmg_4c_OK (FormSigOpTot, task813).
* AEVENTS por objeto de ORIGEM: col 3 = nome do evento, col 4 = metodo delegate
* (col 2 e OBJETO - concatenar dispara erro 11). Tudo em TRY/CATCH: erro solto
* abre dialogo modal e pendura o vfp9 headless.
*==============================================================================
SET SAFETY OFF
SET RESOURCE OFF

PUBLIC gb_4c_ModoTeste, gc_4c_ArquivoErroTeste, gb_4c_ValidandoUI, gnConnHandle
gb_4c_ModoTeste        = .T.
gc_4c_ArquivoErroTeste = "C:\4c\automation\_p813b_dialogs.txt"
gb_4c_ValidandoUI      = .T.
gnConnHandle           = 0

LOCAL lcOut, loForm, loErro, loBtn, lnEv, lnI
LOCAL ARRAY laEv[1, 5]

lcOut = "C:\4c\automation\_p813b_resultado.txt"
STRTOFILE("PROBE-B INICIADO " + TTOC(DATETIME()) + CHR(13) + CHR(10), lcOut, 0)
STRTOFILE("", gc_4c_ArquivoErroTeste, 0)

DO ("C:\4c\projeto\app\start\config.prg")

SET PATH TO (gc_4c_CaminhoBase + "," + gc_4c_CaminhoClasses + "," + ;
             gc_4c_CaminhoUtils + "," + gc_4c_CaminhoForms + "," + ;
             gc_4c_CaminhoIcones)

SET PROCEDURE TO (gc_4c_CaminhoUtils   + "functions.prg")  ADDITIVE
SET PROCEDURE TO (gc_4c_CaminhoUtils   + "messages.prg")   ADDITIVE
SET PROCEDURE TO (gc_4c_CaminhoUtils   + "validators.prg") ADDITIVE
SET PROCEDURE TO (gc_4c_CaminhoClasses + "dataaccess.prg")   ADDITIVE
SET PROCEDURE TO (gc_4c_CaminhoClasses + "businessbase.prg") ADDITIVE
SET PROCEDURE TO (gc_4c_CaminhoClasses + "formbase.prg")     ADDITIVE
SET PROCEDURE TO (gc_4c_CaminhoClasses + "gridbase.prg")     ADDITIVE
SET PROCEDURE TO (gc_4c_CaminhoClasses + "FormErro.prg")     ADDITIVE
SET PROCEDURE TO (gc_4c_CaminhoClasses + "SigOpTotBO.prg")   ADDITIVE
SET PROCEDURE TO (gc_4c_CaminhoForms + "operacionais\FormSigOpTot.prg") ADDITIVE

loForm = .NULL.
TRY
    loForm = CREATEOBJECT("FormSigOpTot")
CATCH TO loErro
    STRTOFILE("EXCECAO CREATEOBJECT: " + loErro.Message + CHR(13) + CHR(10), lcOut, 1)
ENDTRY

IF VARTYPE(loForm) = "O"
    TRY
        loBtn = loForm.cmg_4c_OK.Buttons(1)
        lnEv  = AEVENTS(laEv, loBtn)
        STRTOFILE("AEVENTS=" + TRANSFORM(lnEv) + CHR(13) + CHR(10), lcOut, 1)
        FOR lnI = 1 TO lnEv
            STRTOFILE("  evento=[" + laEv[lnI, 3] + "] metodo=[" + ;
                laEv[lnI, 4] + "]" + CHR(13) + CHR(10), lcOut, 1)
        ENDFOR
    CATCH TO loErro
        STRTOFILE("ERRO AEVENTS: " + loErro.Message + " LN=" + ;
            TRANSFORM(loErro.LineNo) + CHR(13) + CHR(10), lcOut, 1)
    ENDTRY

    TRY
        STRTOFILE("CarregarLista() de fora = " + ;
            TRANSFORM(loForm.CarregarLista()) + CHR(13) + CHR(10), lcOut, 1)
    CATCH TO loErro
        STRTOFILE("ERRO CarregarLista: " + loErro.Message + CHR(13) + CHR(10), lcOut, 1)
    ENDTRY

    TRY
        STRTOFILE("CmdRetornarClick existe=" + ;
            TRANSFORM(PEMSTATUS(loForm, "CmdRetornarClick", 5)) + ;
            " protected=" + TRANSFORM(PEMSTATUS(loForm, "CmdRetornarClick", 2)) + ;
            " | CarregarLista protected=" + ;
            TRANSFORM(PEMSTATUS(loForm, "CarregarLista", 2)) + ;
            " | ConfigurarBotoes protected=" + ;
            TRANSFORM(PEMSTATUS(loForm, "ConfigurarBotoes", 2)) + ;
            CHR(13) + CHR(10), lcOut, 1)
    CATCH TO loErro
        STRTOFILE("ERRO PEMSTATUS: " + loErro.Message + CHR(13) + CHR(10), lcOut, 1)
    ENDTRY

    TRY
        STRTOFILE("CABECALHO Titulo=[" + ;
            loForm.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption + "] Width=" + ;
            TRANSFORM(loForm.cnt_4c_Cabecalho.Width) + CHR(13) + CHR(10), lcOut, 1)
    CATCH TO loErro
        STRTOFILE("ERRO CABECALHO: " + loErro.Message + CHR(13) + CHR(10), lcOut, 1)
    ENDTRY

    loForm = .NULL.
ELSE
    STRTOFILE("VARTYPE(loForm)=" + VARTYPE(loForm) + CHR(13) + CHR(10), lcOut, 1)
ENDIF

STRTOFILE("PROBE-B FIM" + CHR(13) + CHR(10), lcOut, 1)

QUIT

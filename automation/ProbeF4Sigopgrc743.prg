* ProbeF4Sigopgrc743.prg
* Prova a Fase 4 do FormSIGOPGRC: instancia o form (sem pai, sem Show - a tela
* eh WindowType = 1 e o Show BLOQUEIA) e le os observaveis dos dois botoes.
* NAO chama ConfigurarAmbiente() - ela nao retorna nesta maquina.
SET SAFETY OFF
SET RESOURCE OFF

LOCAL loc_cOut, loc_oForm, loc_oErro, loc_nI
loc_cOut = "C:\4c\automation\probe_f4_sigopgrc743_resultado.txt"
STRTOFILE("[1] inicio" + CHR(13) + CHR(10), loc_cOut)

DO LOCFILE("C:\4c\projeto\app\start\config.prg")
STRTOFILE("[2] config.prg OK" + CHR(13) + CHR(10), loc_cOut, 1)

PUBLIC gnConnHandle, gb_4c_ModoTeste, gc_4c_ArquivoErroTeste, gb_4c_ValidandoUI
gnConnHandle           = 0
gb_4c_ModoTeste        = .T.
gc_4c_ArquivoErroTeste = "C:\4c\automation\probe_f4_sigopgrc743_dialogs.txt"
gb_4c_ValidandoUI      = .T.
STRTOFILE("", gc_4c_ArquivoErroTeste)

SET PATH TO (gcCaminhoBase + "," + gcCaminhoClasses + "," + gcCaminhoUtils + ;
             "," + gcCaminhoForms + "," + gcCaminhoIcones)
SET PROCEDURE TO (gcCaminhoUtils   + "functions.prg")    ADDITIVE
SET PROCEDURE TO (gcCaminhoUtils   + "messages.prg")     ADDITIVE
SET PROCEDURE TO (gcCaminhoUtils   + "validators.prg")   ADDITIVE
SET PROCEDURE TO (gcCaminhoClasses + "dataaccess.prg")   ADDITIVE
SET PROCEDURE TO (gcCaminhoClasses + "businessbase.prg") ADDITIVE
SET PROCEDURE TO (gcCaminhoClasses + "formbase.prg")     ADDITIVE
SET PROCEDURE TO (gcCaminhoClasses + "FormErro.prg")     ADDITIVE
SET PROCEDURE TO (gcCaminhoClasses + "SIGOPGRCBO.prg")   ADDITIVE
SET PROCEDURE TO (gcCaminhoForms + "operacionais\FormSIGOPGRC.prg") ADDITIVE
STRTOFILE("[3] SET PROCEDURE OK" + CHR(13) + CHR(10), loc_cOut, 1)

loc_oForm = .NULL.
TRY
    loc_oForm = CREATEOBJECT("FormSIGOPGRC")
CATCH TO loc_oErro
    STRTOFILE("[X] CREATEOBJECT estourou: " + loc_oErro.Message + ;
        " LN=" + TRANSFORM(loc_oErro.LineNo) + CHR(13) + CHR(10), loc_cOut, 1)
ENDTRY

STRTOFILE("[4] VARTYPE(form) = " + VARTYPE(loc_oForm) + CHR(13) + CHR(10), loc_cOut, 1)

IF VARTYPE(loc_oForm) = "O"
    STRTOFILE("BaseClass=" + loc_oForm.BaseClass + ;
        " Caption=[" + loc_oForm.Caption + "]" + ;
        " W=" + TRANSFORM(loc_oForm.Width) + " H=" + TRANSFORM(loc_oForm.Height) + ;
        " ControlCount=" + TRANSFORM(loc_oForm.ControlCount) + CHR(13) + CHR(10), loc_cOut, 1)

    FOR loc_nI = 1 TO loc_oForm.ControlCount
        STRTOFILE("  filho " + TRANSFORM(loc_nI) + ": " + ;
            loc_oForm.Controls(loc_nI).Name + " (" + ;
            loc_oForm.Controls(loc_nI).BaseClass + ")" + CHR(13) + CHR(10), loc_cOut, 1)
    ENDFOR

    *-- cmd_4c_Sair
    IF PEMSTATUS(loc_oForm, "cmd_4c_Sair", 5)
        WITH loc_oForm.cmd_4c_Sair
            STRTOFILE("SAIR     Top=" + TRANSFORM(.Top) + " Left=" + TRANSFORM(.Left) + ;
                " W=" + TRANSFORM(.Width) + " H=" + TRANSFORM(.Height) + ;
                " Caption=[" + .Caption + "]" + ;
                " Cancel=" + TRANSFORM(.Cancel) + ;
                " Themes=" + TRANSFORM(.Themes) + ;
                " Visible=" + TRANSFORM(.Visible) + ;
                " PicOK=" + TRANSFORM(FILE(.Picture)) + ;
                " dir=" + TRANSFORM(.Left + .Width) + CHR(13) + CHR(10), loc_cOut, 1)
        ENDWITH
    ELSE
        STRTOFILE("[X] cmd_4c_Sair AUSENTE" + CHR(13) + CHR(10), loc_cOut, 1)
    ENDIF

    *-- cmd_4c_Imprimir
    IF PEMSTATUS(loc_oForm, "cmd_4c_Imprimir", 5)
        WITH loc_oForm.cmd_4c_Imprimir
            STRTOFILE("IMPRIMIR Top=" + TRANSFORM(.Top) + " Left=" + TRANSFORM(.Left) + ;
                " W=" + TRANSFORM(.Width) + " H=" + TRANSFORM(.Height) + ;
                " Caption=[" + .Caption + "]" + ;
                " Themes=" + TRANSFORM(.Themes) + ;
                " Visible=" + TRANSFORM(.Visible) + ;
                " PicOK=" + TRANSFORM(FILE(.Picture)) + ;
                " dir=" + TRANSFORM(.Left + .Width) + CHR(13) + CHR(10), loc_cOut, 1)
        ENDWITH
    ELSE
        STRTOFILE("[X] cmd_4c_Imprimir AUSENTE" + CHR(13) + CHR(10), loc_cOut, 1)
    ENDIF

    *-- Handlers tem de ser PUBLIC (atributo 2 = Protected -> .F.)
    STRTOFILE("PROTECTED? CmdSairClick=" + TRANSFORM(PEMSTATUS(loc_oForm, "CmdSairClick", 2)) + ;
        " CmdImprimirClick=" + TRANSFORM(PEMSTATUS(loc_oForm, "CmdImprimirClick", 2)) + ;
        " ExecutarReportForm=" + TRANSFORM(PEMSTATUS(loc_oForm, "ExecutarReportForm", 2)) + ;
        CHR(13) + CHR(10), loc_cOut, 1)

    *-- BINDEVENT efetivo
    LOCAL ARRAY laEvS[1,1], laEvI[1,1]
    STRTOFILE("BINDEVENT Sair=" + TRANSFORM(AEVENTS(laEvS, loc_oForm.cmd_4c_Sair)) + ;
        " Imprimir=" + TRANSFORM(AEVENTS(laEvI, loc_oForm.cmd_4c_Imprimir)) + ;
        CHR(13) + CHR(10), loc_cOut, 1)

    *-- Clicar Imprimir SEM grafico gerado: o guard tem de avisar e NAO
    *-- chamar REPORT FORM nenhum (this_lGraficoGerado = .F. nesta fase).
    TRY
        loc_oForm.CmdImprimirClick()
        STRTOFILE("[5] CmdImprimirClick voltou sem estourar" + CHR(13) + CHR(10), loc_cOut, 1)
    CATCH TO loc_oErro
        STRTOFILE("[X] CmdImprimirClick estourou: " + loc_oErro.Message + ;
            " LN=" + TRANSFORM(loc_oErro.LineNo) + CHR(13) + CHR(10), loc_cOut, 1)
    ENDTRY

    loc_oForm.Release()
    loc_oForm = .NULL.
ENDIF

STRTOFILE("[6] FIM" + CHR(13) + CHR(10), loc_cOut, 1)
QUIT

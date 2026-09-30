*==============================================================================
* ProbeCprF7.prg - Instancia FormSIGPRCPR headless (Fase 7 / task596) e exercita
* os handlers de evento do campo de leitura acrescentados nesta fase.
*
* NAO chama ConfigurarAmbiente() - ela nao retorna nesta maquina; carrega a mao
* so as dependencias do form (licao do probe de instanciacao).
*==============================================================================
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF

PUBLIC gb_4c_ModoTeste, gb_4c_ValidandoUI, gc_4c_ArquivoErroTeste
gb_4c_ModoTeste        = .T.
gb_4c_ValidandoUI      = .T.
gc_4c_ArquivoErroTeste = "C:\4c\automation\vfp_error_cpr_f7.txt"
IF FILE(gc_4c_ArquivoErroTeste)
    DELETE FILE (gc_4c_ArquivoErroTeste)
ENDIF

LOCAL loc_cRes, loc_oForm, loc_oErro
loc_cRes = "INICIO"
STRTOFILE(loc_cRes, "C:\4c\automation\probe_cpr_f7_result.txt")

TRY
    CD C:\4c\projeto\app\start
    DO config.prg
    STRTOFILE(CHR(13)+CHR(10)+"config OK", "C:\4c\automation\probe_cpr_f7_result.txt", 1)

    SET PATH TO (gcCaminhoBase + "," + gcCaminhoClasses + "," + gcCaminhoUtils + ;
                 "," + gcCaminhoForms + "," + gcCaminhoIcones)
    SET PROCEDURE TO (gcCaminhoClasses + "dataaccess.prg")   ADDITIVE
    SET PROCEDURE TO (gcCaminhoClasses + "businessbase.prg") ADDITIVE
    SET PROCEDURE TO (gcCaminhoClasses + "formbase.prg")     ADDITIVE
    SET PROCEDURE TO (gcCaminhoClasses + "gridbase.prg")     ADDITIVE
    SET PROCEDURE TO (gcCaminhoClasses + "FormErro.prg")     ADDITIVE
    SET PROCEDURE TO (gcCaminhoUtils   + "functions.prg")    ADDITIVE
    SET PROCEDURE TO (gcCaminhoUtils   + "messages.prg")     ADDITIVE
    SET PROCEDURE TO (gcCaminhoUtils   + "validators.prg")   ADDITIVE
    SET PROCEDURE TO (gcCaminhoClasses + "SIGPRCPRBO.prg")   ADDITIVE
    SET PROCEDURE TO (gcCaminhoForms + "operacionais\FormSIGPRCPR.prg") ADDITIVE
    STRTOFILE(CHR(13)+CHR(10)+"deps OK", "C:\4c\automation\probe_cpr_f7_result.txt", 1)

    loc_oForm = CREATEOBJECT("FormSIGPRCPR")
    STRTOFILE(CHR(13)+CHR(10)+"createobject retornou " + VARTYPE(loc_oForm), ;
              "C:\4c\automation\probe_cpr_f7_result.txt", 1)

    IF VARTYPE(loc_oForm) = "O"
        loc_cRes = CHR(13) + CHR(10) + "OK W=" + TRANSFORM(loc_oForm.Width) + ;
            " H=" + TRANSFORM(loc_oForm.Height) + ;
            " | Confirm(inicial)=" + SET("CONFIRM") + ;
            " | Leitura.InputMask=" + loc_oForm.txt_4c_Leitura.InputMask + ;
            " Leitura.Value=" + TRANSFORM(loc_oForm.txt_4c_Leitura.Value) + ;
            " | Handlers: When=" + TRANSFORM(PEMSTATUS(loc_oForm, "LeituraWhen", 5)) + ;
            " LostFocus=" + TRANSFORM(PEMSTATUS(loc_oForm, "LeituraLostFocus", 5)) + ;
            " KeyPress=" + TRANSFORM(PEMSTATUS(loc_oForm, "LeituraKeyPress", 5)) + ;
            " FlagReentr=" + TRANSFORM(PEMSTATUS(loc_oForm, "this_lProcessandoLeitura", 5))

        *-- BINDEVENT realmente registrou os 3 eventos do TextBox de leitura?
        LOCAL ARRAY loc_aEv[1, 5]
        LOCAL loc_nEv, loc_nI, loc_cEventos
        loc_cEventos = ""
        loc_nEv = AEVENTS(loc_aEv, loc_oForm.txt_4c_Leitura)
        FOR loc_nI = 1 TO loc_nEv
            loc_cEventos = loc_cEventos + IIF(EMPTY(loc_cEventos), "", "/") + ALLTRIM(loc_aEv[loc_nI, 3])
        ENDFOR
        loc_cRes = loc_cRes + CHR(13) + CHR(10) + "BINDEVENTs txt_4c_Leitura (" + ;
                   TRANSFORM(loc_nEv) + "): " + loc_cEventos

        *-- Exercita LeituraWhen: tem de ligar SET CONFIRM
        loc_oForm.LeituraWhen()
        loc_cRes = loc_cRes + CHR(13) + CHR(10) + "PosLeituraWhen: Confirm=" + SET("CONFIRM")

        *-- Exercita LeituraLostFocus com campo VAZIO (Value = 0): tem de
        *-- desligar o CONFIRM e NAO processar leitura nenhuma
        loc_oForm.txt_4c_Leitura.Value = 0
        loc_oForm.LeituraLostFocus()
        loc_cRes = loc_cRes + CHR(13) + CHR(10) + "PosLostFocus(vazio): Confirm=" + SET("CONFIRM") + ;
                   " Flag=" + TRANSFORM(loc_oForm.this_lProcessandoLeitura)

        *-- Guarda de reentrancia: com a flag JA ligada o handler tem de sair
        *-- sem processar (nao pode empilhar)
        loc_oForm.this_lProcessandoLeitura = .T.
        loc_oForm.txt_4c_Leitura.Value = 99999999999999
        loc_oForm.LeituraLostFocus()
        loc_cRes = loc_cRes + CHR(13) + CHR(10) + "PosLostFocus(reentrante): Value=" + ;
                   TRANSFORM(loc_oForm.txt_4c_Leitura.Value) + " (deve continuar 99999999999999)"
        loc_oForm.this_lProcessandoLeitura = .F.

        *-- Agora sem reentrancia: o codigo nao existe no cursor vazio, entao o
        *-- caminho NAO_CADASTRADO roda, zera o campo e LIMPA a flag
        loc_oForm.LeituraLostFocus()
        loc_cRes = loc_cRes + CHR(13) + CHR(10) + "PosLostFocus(real): Value=" + ;
                   TRANSFORM(loc_oForm.txt_4c_Leitura.Value) + ;
                   " Flag=" + TRANSFORM(loc_oForm.this_lProcessandoLeitura) + ;
                   " (Value deve ser 0 e Flag .F.)"

        *-- Destroy tem de deixar CONFIRM OFF mesmo se ficou ligado
        SET CONFIRM ON
        loc_oForm.Release()
        loc_cRes = loc_cRes + CHR(13) + CHR(10) + "PosRelease: Confirm=" + SET("CONFIRM") + " (deve ser OFF)"
    ELSE
        loc_cRes = CHR(13) + CHR(10) + "FAIL VARTYPE=" + VARTYPE(loc_oForm)
    ENDIF
CATCH TO loc_oErro
    loc_cRes = CHR(13) + CHR(10) + "EXCEPTION: " + loc_oErro.Message + ;
               " Linha:" + TRANSFORM(loc_oErro.LineNo) + " Proc:" + loc_oErro.Procedure
ENDTRY

STRTOFILE(loc_cRes, "C:\4c\automation\probe_cpr_f7_result.txt", 1)

IF FILE("C:\4c\automation\vfp_error_cpr_f7.txt")
    STRTOFILE(CHR(13) + CHR(10) + "DIALOGOS: " + FILETOSTR("C:\4c\automation\vfp_error_cpr_f7.txt"), ;
              "C:\4c\automation\probe_cpr_f7_result.txt", 1)
ENDIF
QUIT

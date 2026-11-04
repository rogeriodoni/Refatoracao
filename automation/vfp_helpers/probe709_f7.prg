*-- Probe da Fase 7 do task709 (FormSIGOPCPE) - compilacao, controle negativo
*-- e runtime dos dois handlers de botao entregues nesta fase.
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF

LOCAL lcRes, lcOut, lcBO, lcForm, lcNeg, loForm, loErr, llVivo
lcOut = "C:\4c\automation\vfp_helpers\probe709_f7_resultado.txt"
lcRes = ""

PUBLIC gb_4c_ModoTeste, gc_4c_ArquivoErroTeste
gb_4c_ModoTeste        = .T.
gc_4c_ArquivoErroTeste = "C:\4c\automation\vfp_helpers\probe709_f7_dialogs.txt"

PUBLIC gnConnHandle
gnConnHandle = 0

CD C:\4c\projeto\app\start
DO config.prg

SET PATH TO (gc_4c_CaminhoBase + "," + gc_4c_CaminhoClasses + "," + ;
             gc_4c_CaminhoUtils + "," + gc_4c_CaminhoForms + "," + ;
             gc_4c_CaminhoIcones)

SET PROCEDURE TO (gc_4c_CaminhoClasses + "dataaccess.prg")   ADDITIVE
SET PROCEDURE TO (gc_4c_CaminhoClasses + "businessbase.prg") ADDITIVE
SET PROCEDURE TO (gc_4c_CaminhoClasses + "formbase.prg")     ADDITIVE
SET PROCEDURE TO (gc_4c_CaminhoClasses + "gridbase.prg")     ADDITIVE
SET PROCEDURE TO (gc_4c_CaminhoClasses + "FormErro.prg")     ADDITIVE
SET PROCEDURE TO (gc_4c_CaminhoUtils   + "functions.prg")    ADDITIVE
SET PROCEDURE TO (gc_4c_CaminhoUtils   + "messages.prg")     ADDITIVE
SET PROCEDURE TO (gc_4c_CaminhoUtils   + "validators.prg")   ADDITIVE

lcBO   = gc_4c_CaminhoClasses + "SIGOPCPEBO.prg"
lcForm = gc_4c_CaminhoForms + "operacionais\FormSIGOPCPE.prg"
lcNeg  = "C:\Users\roger\AppData\Local\Temp\neg709.prg"

STRTOFILE(lcRes, lcOut)

*======================================================================
* 1. COMPILACAO
*======================================================================
lcRes = lcRes + "=== 1. COMPILACAO ===" + CHR(13) + CHR(10)

IF FILE(STRTRAN(UPPER(lcBO),   ".PRG", ".FXP"))
    ERASE (STRTRAN(UPPER(lcBO),   ".PRG", ".FXP"))
ENDIF
IF FILE(STRTRAN(UPPER(lcBO),   ".PRG", ".ERR"))
    ERASE (STRTRAN(UPPER(lcBO),   ".PRG", ".ERR"))
ENDIF
IF FILE(STRTRAN(UPPER(lcForm), ".PRG", ".FXP"))
    ERASE (STRTRAN(UPPER(lcForm), ".PRG", ".FXP"))
ENDIF
IF FILE(STRTRAN(UPPER(lcForm), ".PRG", ".ERR"))
    ERASE (STRTRAN(UPPER(lcForm), ".PRG", ".ERR"))
ENDIF

COMPILE (lcBO)
COMPILE (lcForm)

STRTOFILE(lcRes, lcOut)
lcRes = lcRes + "BO.FXP   = " + TRANSFORM(FILE(STRTRAN(UPPER(lcBO),   ".PRG", ".FXP"))) + CHR(13) + CHR(10)
lcRes = lcRes + "BO.ERR   = " + TRANSFORM(FILE(STRTRAN(UPPER(lcBO),   ".PRG", ".ERR"))) + CHR(13) + CHR(10)
lcRes = lcRes + "FORM.FXP = " + TRANSFORM(FILE(STRTRAN(UPPER(lcForm), ".PRG", ".FXP"))) + CHR(13) + CHR(10)
lcRes = lcRes + "FORM.ERR = " + TRANSFORM(FILE(STRTRAN(UPPER(lcForm), ".PRG", ".ERR"))) + CHR(13) + CHR(10)

IF FILE(STRTRAN(UPPER(lcForm), ".PRG", ".ERR"))
    lcRes = lcRes + "--- FORM.ERR ---" + CHR(13) + CHR(10)
    lcRes = lcRes + FILETOSTR(STRTRAN(UPPER(lcForm), ".PRG", ".ERR")) + CHR(13) + CHR(10)
ENDIF

STRTOFILE(lcRes, lcOut)

*======================================================================
* 2. CONTROLE NEGATIVO - copia do form com erro de sintaxe proposital
*    (PUBLIC PROCEDURE dentro de DEFINE CLASS - regra #9.1). Prova que
*    o .ERR apareceria se houvesse erro, logo a ausencia dele acima
*    significa algo.
*======================================================================
STRTOFILE(lcRes, lcOut)
    lcRes = lcRes + CHR(13) + CHR(10) + "=== 2. CONTROLE NEGATIVO ===" + CHR(13) + CHR(10)

IF FILE(lcNeg)
    ERASE (lcNeg)
ENDIF
IF FILE(STRTRAN(UPPER(lcNeg), ".PRG", ".FXP"))
    ERASE (STRTRAN(UPPER(lcNeg), ".PRG", ".FXP"))
ENDIF
IF FILE(STRTRAN(UPPER(lcNeg), ".PRG", ".ERR"))
    ERASE (STRTRAN(UPPER(lcNeg), ".PRG", ".ERR"))
ENDIF

STRTOFILE(FILETOSTR(lcForm), lcNeg)
STRTOFILE("DEFINE CLASS ZZProbe709 AS Custom" + CHR(13) + CHR(10) + ;
          "    PUBLIC PROCEDURE Falha()" + CHR(13) + CHR(10) + ;
          "    ENDPROC" + CHR(13) + CHR(10) + ;
          "ENDDEFINE" + CHR(13) + CHR(10), lcNeg, 1)

COMPILE (lcNeg)

lcRes = lcRes + "NEG.FXP = " + TRANSFORM(FILE(STRTRAN(UPPER(lcNeg), ".PRG", ".FXP"))) + CHR(13) + CHR(10)
lcRes = lcRes + "NEG.ERR = " + TRANSFORM(FILE(STRTRAN(UPPER(lcNeg), ".PRG", ".ERR"))) + CHR(13) + CHR(10)
IF FILE(STRTRAN(UPPER(lcNeg), ".PRG", ".ERR"))
    lcRes = lcRes + "--- NEG.ERR (so as linhas acrescentadas devem aparecer) ---" + CHR(13) + CHR(10)
    lcRes = lcRes + FILETOSTR(STRTRAN(UPPER(lcNeg), ".PRG", ".ERR")) + CHR(13) + CHR(10)
ENDIF

STRTOFILE(lcRes, lcOut)

*======================================================================
* 3. INSTANCIACAO
*======================================================================
STRTOFILE(lcRes, lcOut)
    lcRes = lcRes + CHR(13) + CHR(10) + "=== 3. INSTANCIACAO ===" + CHR(13) + CHR(10)

SET PROCEDURE TO (lcBO)   ADDITIVE
SET PROCEDURE TO (lcForm) ADDITIVE

loForm = .NULL.
TRY
    loForm = CREATEOBJECT("FormSIGOPCPE")
CATCH TO loErr
    lcRes = lcRes + "EXCECAO no CREATEOBJECT: " + loErr.Message + ;
            " LN=" + TRANSFORM(loErr.LineNo) + " PROC=" + loErr.Procedure + CHR(13) + CHR(10)
ENDTRY

lcRes = lcRes + "VARTYPE(loForm) = " + VARTYPE(loForm) + CHR(13) + CHR(10)

IF VARTYPE(loForm) = "O"
    lcRes = lcRes + "Caption = [" + loForm.Caption + "]" + CHR(13) + CHR(10)
    lcRes = lcRes + "RECCOUNT(cursor_4c_Dados) = " + ;
            TRANSFORM(IIF(USED("cursor_4c_Dados"), RECCOUNT("cursor_4c_Dados"), -1)) + CHR(13) + CHR(10)

    *==================================================================
    * 4. VISIBILIDADE DOS HANDLERS (regra #3/#51 - PROTECTED falha em
    *    silencio no BINDEVENT). PEMSTATUS(...,2) = .T. significa
    *    PROTECTED, logo o esperado aqui eh .F. nos dois.
    *==================================================================
    STRTOFILE(lcRes, lcOut)
    lcRes = lcRes + CHR(13) + CHR(10) + "=== 4. VISIBILIDADE ===" + CHR(13) + CHR(10)
    lcRes = lcRes + "existe BtnConfirmarClick  = " + TRANSFORM(PEMSTATUS(loForm, "BtnConfirmarClick", 5)) + CHR(13) + CHR(10)
    lcRes = lcRes + "PROTECTED BtnConfirmarClick = " + TRANSFORM(PEMSTATUS(loForm, "BtnConfirmarClick", 2)) + CHR(13) + CHR(10)
    lcRes = lcRes + "existe BtnEncerrarClick   = " + TRANSFORM(PEMSTATUS(loForm, "BtnEncerrarClick", 5)) + CHR(13) + CHR(10)
    lcRes = lcRes + "PROTECTED BtnEncerrarClick  = " + TRANSFORM(PEMSTATUS(loForm, "BtnEncerrarClick", 2)) + CHR(13) + CHR(10)

    *==================================================================
    * 5. BINDEVENT efetivamente ligado nos dois botoes
    *==================================================================
    STRTOFILE(lcRes, lcOut)
    lcRes = lcRes + CHR(13) + CHR(10) + "=== 5. BINDEVENT ===" + CHR(13) + CHR(10)
    LOCAL ARRAY laEvC[1, 5]
    LOCAL ARRAY laEvE[1, 5]
    LOCAL lnC, lnE
    lnC = AEVENTS(laEvC, loForm.cnt_4c_Botoes.cmd_4c_Confirmar)
    lnE = AEVENTS(laEvE, loForm.cnt_4c_Botoes.cmd_4c_Encerrar)
    lcRes = lcRes + "cmd_4c_Confirmar: n=" + TRANSFORM(lnC) + ;
            IIF(lnC > 0, " evento=[" + laEvC[1, 2] + "] delegate=[" + laEvC[1, 4] + "]", "") + CHR(13) + CHR(10)
    lcRes = lcRes + "cmd_4c_Encerrar : n=" + TRANSFORM(lnE) + ;
            IIF(lnE > 0, " evento=[" + laEvE[1, 2] + "] delegate=[" + laEvE[1, 4] + "]", "") + CHR(13) + CHR(10)

    *==================================================================
    * 6. BtnConfirmarClick SEM conexao: tem de RECUSAR (mensagem no
    *    _dialogs.txt) e NAO fechar a tela - fechar daria a gravacao
    *    por feita sem ter gravado nada.
    *==================================================================
    STRTOFILE(lcRes, lcOut)
    lcRes = lcRes + CHR(13) + CHR(10) + "=== 6. CONFIRMAR SEM CONEXAO ===" + CHR(13) + CHR(10)
    TRY
        loForm.BtnConfirmarClick()
        lcRes = lcRes + "BtnConfirmarClick retornou sem excecao" + CHR(13) + CHR(10)
    CATCH TO loErr
        lcRes = lcRes + "EXCECAO: " + loErr.Message + " LN=" + TRANSFORM(loErr.LineNo) + ;
                " PROC=" + loErr.Procedure + CHR(13) + CHR(10)
    ENDTRY

    llVivo = .F.
    TRY
        llVivo = (VARTYPE(loForm) = "O" AND !EMPTY(loForm.Caption))
    CATCH
        llVivo = .F.
    ENDTRY
    lcRes = lcRes + "form continua ABERTO depois do Confirmar recusado = " + TRANSFORM(llVivo) + CHR(13) + CHR(10)

    *==================================================================
    * 7. BtnEncerrarClick: tem de FECHAR a tela
    *==================================================================
    STRTOFILE(lcRes, lcOut)
    lcRes = lcRes + CHR(13) + CHR(10) + "=== 7. ENCERRAR ===" + CHR(13) + CHR(10)
    TRY
        loForm.BtnEncerrarClick()
        lcRes = lcRes + "BtnEncerrarClick retornou sem excecao" + CHR(13) + CHR(10)
    CATCH TO loErr
        lcRes = lcRes + "EXCECAO: " + loErr.Message + " LN=" + TRANSFORM(loErr.LineNo) + ;
                " PROC=" + loErr.Procedure + CHR(13) + CHR(10)
    ENDTRY

    lcRes = lcRes + "VARTYPE(loForm) pos-Encerrar = " + VARTYPE(loForm) + CHR(13) + CHR(10)
    lcRes = lcRes + "cursor_4c_Dados aberto pos-Encerrar = " + TRANSFORM(USED("cursor_4c_Dados")) + CHR(13) + CHR(10)
ENDIF

lcRes = lcRes + CHR(13) + CHR(10) + "FIM" + CHR(13) + CHR(10)
STRTOFILE(lcRes, lcOut)
QUIT

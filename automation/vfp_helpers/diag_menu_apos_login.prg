*-- Diagnostico: simula o fluxo completo do login + open/close de forms
*-- para reproduzir o bug reportado (menu encolhe apos abrir/fechar qualquer form)
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
SET NOTIFY OFF
SYS(2335, 0)

PUBLIC gb_4c_ModoTeste
gb_4c_ModoTeste = .T.

LOCAL loc_cLog
loc_cLog = "C:\4c\automation\vfp_helpers\diag_menu_apos_login.log"
IF FILE(loc_cLog)
    DELETE FILE (loc_cLog)
ENDIF

STRTOFILE("=== DIAG MENU APOS LOGIN " + TTOC(DATETIME()) + " ===" + CHR(13)+CHR(10), loc_cLog)

CD "C:\4c\projeto\app\start"
DO config.prg
ConfigurarAmbiente()
STRTOFILE("[1] ConfigurarAmbiente ok" + CHR(13)+CHR(10), loc_cLog, 1)

*-- Sistema mock
PUBLIC go_4c_Sistema, gc_4c_UsuarioLogado, gnConnHandle
gc_4c_UsuarioLogado = "TESTE"
gnConnHandle = 0

*-- FASE 1: Estado inicial + CriarMenuPrincipal (equivalente ao main.prg)
SET SYSMENU TO DEFAULT
STRTOFILE("[2] Apos SET SYSMENU TO DEFAULT (main.prg): CNTPAD=" + TRANSFORM(CNTPAD("_MSYSMENU")) + CHR(13)+CHR(10), loc_cLog, 1)

DO CriarMenuPrincipal
STRTOFILE("[3] SNAPSHOT STARTUP (apos CriarMenuPrincipal): CNTPAD=" + TRANSFORM(CNTPAD("_MSYSMENU")) + CHR(13)+CHR(10), loc_cLog, 1)
LOCAL loc_i
FOR loc_i = 1 TO CNTPAD("_MSYSMENU")
    STRTOFILE("      pad " + TRANSFORM(loc_i) + ": " + PRMPAD("_MSYSMENU", loc_i) + CHR(13)+CHR(10), loc_cLog, 1)
ENDFOR

*-- FASE 2: Simular Formsigtosen.Init linha 57-58
SET SYSMENU TO
SET SYSMENU OFF
STRTOFILE("[4] SNAPSHOT APOS SET SYSMENU TO + OFF (Formsigtosen.Init 57-58): CNTPAD=" + TRANSFORM(CNTPAD("_MSYSMENU")) + CHR(13)+CHR(10), loc_cLog, 1)

*-- FASE 3: Simular meu FIX pos-login (SET SYSMENU TO DEFAULT + CriarMenuPrincipal)
SET SYSMENU TO DEFAULT
DO CriarMenuPrincipal
STRTOFILE("[5] SNAPSHOT POS-LOGIN (SET SYSMENU TO DEFAULT + CriarMenuPrincipal): CNTPAD=" + TRANSFORM(CNTPAD("_MSYSMENU")) + CHR(13)+CHR(10), loc_cLog, 1)
FOR loc_i = 1 TO CNTPAD("_MSYSMENU")
    STRTOFILE("      pad " + TRANSFORM(loc_i) + ": " + PRMPAD("_MSYSMENU", loc_i) + CHR(13)+CHR(10), loc_cLog, 1)
ENDFOR

*-- FASE 4: Simular abrir + fechar um form qualquer (FormCor CADASTRO)
STRTOFILE("[6] Criando FormCor..." + CHR(13)+CHR(10), loc_cLog, 1)
LOCAL loc_oForm
TRY
    loc_oForm = CREATEOBJECT("FormCor")
    STRTOFILE("    FormCor criado, VARTYPE=" + VARTYPE(loc_oForm) + CHR(13)+CHR(10), loc_cLog, 1)
CATCH TO loc_oErr
    STRTOFILE("    EXCEPTION create FormCor: " + loc_oErr.Message + " LN=" + TRANSFORM(loc_oErr.LineNo) + CHR(13)+CHR(10), loc_cLog, 1)
ENDTRY

STRTOFILE("[7] SNAPSHOT APOS CREATEOBJECT FormCor: CNTPAD=" + TRANSFORM(CNTPAD("_MSYSMENU")) + CHR(13)+CHR(10), loc_cLog, 1)
FOR loc_i = 1 TO CNTPAD("_MSYSMENU")
    STRTOFILE("      pad " + TRANSFORM(loc_i) + ": " + PRMPAD("_MSYSMENU", loc_i) + CHR(13)+CHR(10), loc_cLog, 1)
ENDFOR

IF VARTYPE(loc_oForm) = "O"
    loc_oForm.Release()
    loc_oForm = .NULL.
    STRTOFILE("[8] FormCor released" + CHR(13)+CHR(10), loc_cLog, 1)
ENDIF

STRTOFILE("[9] SNAPSHOT APOS Release FormCor: CNTPAD=" + TRANSFORM(CNTPAD("_MSYSMENU")) + CHR(13)+CHR(10), loc_cLog, 1)
FOR loc_i = 1 TO CNTPAD("_MSYSMENU")
    STRTOFILE("      pad " + TRANSFORM(loc_i) + ": " + PRMPAD("_MSYSMENU", loc_i) + CHR(13)+CHR(10), loc_cLog, 1)
ENDFOR

STRTOFILE("=== DONE ===" + CHR(13)+CHR(10), loc_cLog, 1)
QUIT

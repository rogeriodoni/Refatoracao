SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
SET NOTIFY OFF
SYS(2335, 0)

PUBLIC gb_4c_ModoTeste, gc_4c_ArquivoErroTeste
gb_4c_ModoTeste = .T.
gc_4c_ArquivoErroTeste = "C:\4c\automation\vfp_helpers\diag_menu_form_erros.log"

LOCAL loc_cLog
loc_cLog = "C:\4c\automation\vfp_helpers\diag_menu_form.log"
IF FILE(loc_cLog)
    DELETE FILE (loc_cLog)
ENDIF
IF FILE(gc_4c_ArquivoErroTeste)
    DELETE FILE (gc_4c_ArquivoErroTeste)
ENDIF

STRTOFILE("=== DIAG MENU+FORM " + TTOC(DATETIME()) + " ===" + CHR(13)+CHR(10), loc_cLog)

CD "C:\4c\projeto\app\start"
DO config.prg
ConfigurarAmbiente()
STRTOFILE("[1] ConfigurarAmbiente ok" + CHR(13)+CHR(10), loc_cLog, 1)

*-- Conectar SQL (necessario para form Init nao dar erro fatal)
LOCAL loc_cConn
loc_cConn = ObterStringConexao()
PUBLIC gnConnHandle
gnConnHandle = SQLSTRINGCONNECT(loc_cConn)
STRTOFILE("[2] SQL handle = " + TRANSFORM(gnConnHandle) + CHR(13)+CHR(10), loc_cLog, 1)

*-- Sistema mock
PUBLIC go_4c_Sistema, gc_4c_UsuarioLogado
go_4c_Sistema = CREATEOBJECT("Empty")
ADDPROPERTY(go_4c_Sistema, "cCodEmpresa", "001")
ADDPROPERTY(go_4c_Sistema, "cEmpresa", "MARCELLA BAHIA")
ADDPROPERTY(go_4c_Sistema, "cCNPJ", "")
ADDPROPERTY(go_4c_Sistema, "BuscaP", "")
ADDPROPERTY(go_4c_Sistema, "BuscaNome", "")
ADDPROPERTY(go_4c_Sistema, "Matrizes", "")
ADDPROPERTY(go_4c_Sistema, "Transitorio", "")
gc_4c_UsuarioLogado = "TESTE"

*-- SNAPSHOT 1: BEFORE CriarMenuPrincipal
STRTOFILE("[3] SNAPSHOT 1 (antes CriarMenuPrincipal):" + CHR(13)+CHR(10), loc_cLog, 1)
STRTOFILE("    CNTPAD(_MSYSMENU)     = " + TRANSFORM(CNTPAD("_MSYSMENU"))     + CHR(13)+CHR(10), loc_cLog, 1)

DO CriarMenuPrincipal

*-- SNAPSHOT 2: AFTER CriarMenuPrincipal (equivalente ao "recem-carregado")
STRTOFILE("[4] SNAPSHOT 2 (apos CriarMenuPrincipal - FRESH):" + CHR(13)+CHR(10), loc_cLog, 1)
STRTOFILE("    CNTPAD(_MSYSMENU)     = " + TRANSFORM(CNTPAD("_MSYSMENU"))     + CHR(13)+CHR(10), loc_cLog, 1)
STRTOFILE("    CNTBAR(popRelatorios) = " + TRANSFORM(CNTBAR("popRelatorios")) + CHR(13)+CHR(10), loc_cLog, 1)
STRTOFILE("    CNTBAR(popFerramentas) = " + TRANSFORM(CNTBAR("popFerramentas")) + CHR(13)+CHR(10), loc_cLog, 1)
STRTOFILE("    CNTBAR(popAjuda)       = " + TRANSFORM(CNTBAR("popAjuda"))       + CHR(13)+CHR(10), loc_cLog, 1)
LOCAL loc_i
FOR loc_i = 1 TO CNTPAD("_MSYSMENU")
    STRTOFILE("      pad " + TRANSFORM(loc_i) + ": " + PRMPAD("_MSYSMENU", loc_i) + CHR(13)+CHR(10), loc_cLog, 1)
ENDFOR

*-- Simular abrir SIGREADS
STRTOFILE("[5] Criando FormSIGREADS..." + CHR(13)+CHR(10), loc_cLog, 1)
LOCAL loc_oForm
TRY
    loc_oForm = CREATEOBJECT("FormSIGREADS")
    STRTOFILE("    Form criado, VARTYPE=" + VARTYPE(loc_oForm) + CHR(13)+CHR(10), loc_cLog, 1)
CATCH TO loc_oErr
    STRTOFILE("    EXCEPTION create form: " + loc_oErr.Message + " LN=" + TRANSFORM(loc_oErr.LineNo) + CHR(13)+CHR(10), loc_cLog, 1)
ENDTRY

*-- SNAPSHOT 3: apos CREATEOBJECT (form.Init rodou)
STRTOFILE("[6] SNAPSHOT 3 (apos CREATEOBJECT FormSIGREADS):" + CHR(13)+CHR(10), loc_cLog, 1)
STRTOFILE("    CNTPAD(_MSYSMENU)     = " + TRANSFORM(CNTPAD("_MSYSMENU"))     + CHR(13)+CHR(10), loc_cLog, 1)
STRTOFILE("    CNTBAR(popRelatorios) = " + TRANSFORM(CNTBAR("popRelatorios")) + CHR(13)+CHR(10), loc_cLog, 1)
FOR loc_i = 1 TO CNTPAD("_MSYSMENU")
    STRTOFILE("      pad " + TRANSFORM(loc_i) + ": " + PRMPAD("_MSYSMENU", loc_i) + CHR(13)+CHR(10), loc_cLog, 1)
ENDFOR

*-- Simular fechar (Release triggers Destroy)
IF VARTYPE(loc_oForm) = "O"
    loc_oForm.Release()
    loc_oForm = .NULL.
    STRTOFILE("[7] Form released" + CHR(13)+CHR(10), loc_cLog, 1)
ENDIF

*-- SNAPSHOT 4: apos Release (equivale a "ALTERED")
STRTOFILE("[8] SNAPSHOT 4 (apos Release - ALTERED):" + CHR(13)+CHR(10), loc_cLog, 1)
STRTOFILE("    CNTPAD(_MSYSMENU)     = " + TRANSFORM(CNTPAD("_MSYSMENU"))     + CHR(13)+CHR(10), loc_cLog, 1)
STRTOFILE("    CNTBAR(popRelatorios) = " + TRANSFORM(CNTBAR("popRelatorios")) + CHR(13)+CHR(10), loc_cLog, 1)
FOR loc_i = 1 TO CNTPAD("_MSYSMENU")
    STRTOFILE("      pad " + TRANSFORM(loc_i) + ": " + PRMPAD("_MSYSMENU", loc_i) + CHR(13)+CHR(10), loc_cLog, 1)
ENDFOR

IF gnConnHandle > 0
    SQLDISCONNECT(gnConnHandle)
ENDIF

STRTOFILE("=== DONE ===" + CHR(13)+CHR(10), loc_cLog, 1)
QUIT

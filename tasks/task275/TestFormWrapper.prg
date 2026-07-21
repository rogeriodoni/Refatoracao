*-- TestFormWrapper.prg - Testa Formsigprdis sem abrir UI
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
SET ECHO OFF

LOCAL loc_cErroFile, loc_cSucessoFile, loc_oForm, loc_cErro

loc_cErroFile   = "C:\4c\tasks\task275\vfp_error_details.txt"
loc_cSucessoFile = "C:\4c\tasks\task275\vfp_teste_sucesso.txt"

*-- Carrega dependencias
SET PATH TO "C:\4c\projeto\app\start;C:\4c\projeto\app\classes;C:\4c\projeto\app\utils;C:\4c\projeto\app\forms\operacionais;C:\4c\projeto\app\forms\cadastros;C:\4c\projeto\app\forms" ADDITIVE

SET PROCEDURE TO "C:\4c\projeto\app\start\config.prg" ADDITIVE
IF FILE("C:\4c\projeto\app\start\config.prg")
    DO "C:\4c\projeto\app\start\config.prg"
ENDIF

*-- Inicializa variaveis globais minimas
IF TYPE("gnConnHandle") = "L"
    gnConnHandle = 0
ENDIF
IF TYPE("gc_4c_UsuarioLogado") = "L"
    gc_4c_UsuarioLogado = "TESTE"
ENDIF
IF TYPE("go_4c_Sistema") = "L"
    go_4c_Sistema = CREATEOBJECT("Empty")
    ADDPROPERTY(go_4c_Sistema, "cEmpresa", "TESTE")
    ADDPROPERTY(go_4c_Sistema, "cCodEmpresa", "01")
    ADDPROPERTY(go_4c_Sistema, "cCNPJ", "")
ENDIF

*-- Caminhos
IF TYPE("gc_4c_CaminhoBase") = "L"
    gc_4c_CaminhoBase    = "C:\4c\projeto\app\"
    gc_4c_CaminhoClasses = "C:\4c\projeto\app\classes\"
    gc_4c_CaminhoUtils   = "C:\4c\projeto\app\utils\"
    gc_4c_CaminhoForms   = "C:\4c\projeto\app\forms\"
    gc_4c_CaminhoIcones  = "C:\4c\vbmp\"
    gc_4c_CaminhoReports = "C:\4c\projeto\app\reports\"
ENDIF

*-- Tenta instanciar o form
TRY
    loc_oForm = CREATEOBJECT("Formsigprdis")
    IF VARTYPE(loc_oForm) = "O"
        STRTOFILE("[" + DTOC(DATE()) + " " + TIME() + "] Sucesso: Formsigprdis instanciado com sucesso" + CHR(13)+CHR(10), loc_cSucessoFile, .F.)
    ELSE
        STRTOFILE("[" + DTOC(DATE()) + " " + TIME() + "] Falha: CREATEOBJECT retornou " + VARTYPE(loc_oForm) + CHR(13)+CHR(10), loc_cErroFile, .F.)
    ENDIF
    loc_oForm = .NULL.
CATCH TO loc_oErro
    STRTOFILE("[" + DTOC(DATE()) + " " + TIME() + "] Erro InicializarForm Formsigprdis: " + loc_oErro.Message + ". LN=" + TRANSFORM(loc_oErro.LineNo) + " PROC=" + LOWER(loc_oErro.Procedure) + CHR(13)+CHR(10), loc_cErroFile, .F.)
ENDTRY

QUIT

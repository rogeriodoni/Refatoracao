*==============================================================================
* InstantiateCheckSigPrCpdF8b.prg - Fase 8: confere que CarregarLista eh
* alcancavel de FORA da classe, exatamente como TesteAutomatico.prg faz
* (PEMSTATUS + THIS.oForm.CarregarLista()). Com o metodo PROTECTED o
* PEMSTATUS devolve .T. e a chamada estoura - regra #3 do CLAUDE.md.
*
* NAO chama ConfigurarAmbiente(): ela carrega ~320 forms via SET PROCEDURE
* mais o menu.prg e nao termina dentro do timeout do probe. Carrega-se aqui
* so a cadeia de dependencia deste form.
*==============================================================================
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF

PUBLIC gb_4c_ModoTeste, gc_4c_ArquivoErroTeste, gnConnHandle
PUBLIC gc_4c_CaminhoIcones, gc_4c_UsuarioLogado, go_4c_Sistema

gb_4c_ModoTeste = .T.
gc_4c_ArquivoErroTeste = "C:\4c\automation\vfp_error_sigprcpd_f8b.txt"
IF FILE(gc_4c_ArquivoErroTeste)
    DELETE FILE (gc_4c_ArquivoErroTeste)
ENDIF
*-- handle invalido de proposito: CarregarDados tem guard e devolve .F.
gnConnHandle = 0
gc_4c_CaminhoIcones = "C:\4c\vbmp\"
gc_4c_UsuarioLogado = "TESTE"

LOCAL loc_cRes, loc_oForm, loc_oErro, loc_lPem, loc_xRet
loc_cRes = ""

TRY
    SET PROCEDURE TO "C:\4c\projeto\app\utils\functions.prg"  ADDITIVE
    SET PROCEDURE TO "C:\4c\projeto\app\utils\messages.prg"   ADDITIVE
    SET PROCEDURE TO "C:\4c\projeto\app\utils\validators.prg" ADDITIVE
    SET PROCEDURE TO "C:\4c\projeto\app\classes\dataaccess.prg"   ADDITIVE
    SET PROCEDURE TO "C:\4c\projeto\app\classes\businessbase.prg" ADDITIVE
    SET PROCEDURE TO "C:\4c\projeto\app\classes\formbase.prg"     ADDITIVE
    SET PROCEDURE TO "C:\4c\projeto\app\classes\gridbase.prg"     ADDITIVE
    SET PROCEDURE TO "C:\4c\projeto\app\classes\sigprcpdBO.prg"   ADDITIVE
    SET PROCEDURE TO "C:\4c\projeto\app\forms\operacionais\Formsigprcpd.prg" ADDITIVE

    loc_oForm = CREATEOBJECT("Formsigprcpd", "", "", DATE(), 0)

    IF VARTYPE(loc_oForm) = "O"
        loc_cRes = "INSTANCIOU=OK" + CHR(13) + CHR(10) + ;
            "PEMSTATUS(grd_4c_Dados)=" + TRANSFORM(PEMSTATUS(loc_oForm, "grd_4c_Dados", 5)) + CHR(13) + CHR(10) + ;
            "PEMSTATUS(cmd_4c_Sair)=" + TRANSFORM(PEMSTATUS(loc_oForm, "cmd_4c_Sair", 5)) + CHR(13) + CHR(10) + ;
            "PEMSTATUS(cnt_4c_Cabecalho)=" + TRANSFORM(PEMSTATUS(loc_oForm, "cnt_4c_Cabecalho", 5))

        *-- Espelha TesteAutomatico.TesteCarregarLista: guard + chamada externa
        loc_lPem = PEMSTATUS(loc_oForm, "CarregarLista", 5)
        loc_cRes = loc_cRes + CHR(13) + CHR(10) + "PEMSTATUS(CarregarLista)=" + TRANSFORM(loc_lPem)

        IF loc_lPem
            *-- Se CarregarLista fosse PROTECTED, esta linha estoura com
            *-- "Property CARREGARLISTA is not found"
            loc_xRet = loc_oForm.CarregarLista()
            loc_cRes = loc_cRes + CHR(13) + CHR(10) + ;
                "CHAMADA_EXTERNA=OK retorno=" + TRANSFORM(loc_xRet)
        ENDIF

        loc_oForm.Release()
    ELSE
        loc_cRes = "FAIL VARTYPE=" + VARTYPE(loc_oForm)
    ENDIF

CATCH TO loc_oErro
    loc_cRes = loc_cRes + CHR(13) + CHR(10) + "EXCEPTION: " + loc_oErro.Message + ;
        " LN=" + TRANSFORM(loc_oErro.LineNo) + " PROC=" + loc_oErro.Procedure
ENDTRY

STRTOFILE(loc_cRes, "C:\4c\automation\instantiate_sigprcpd_f8b_result.txt")
QUIT

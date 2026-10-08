SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
PUBLIC gb_4c_ModoTeste, gc_4c_ArquivoErroTeste, gnConnHandle, gc_4c_UsuarioLogado
gb_4c_ModoTeste = .T.
gc_4c_ArquivoErroTeste = "C:\4c\automation\vfp_err_ilaform.txt"
#DEFINE OUT "C:\4c\automation\probe_ilaform.txt"

LOCAL loc_oE, loc_oForm, loc_cL, loc_nI, loc_lAll, loc_cRot, loc_cMet
LOCAL ARRAY loc_aRot[7]

STRTOFILE("=== PROBE Formsigprila + despacho para o BO ===" + CHR(13) + CHR(10), OUT)

TRY
    CD C:\4c\projeto\app\start
    DO config.prg
    gc_4c_UsuarioLogado = "TESTE"
    SET PATH TO (gcCaminhoBase + "," + gcCaminhoClasses + "," + gcCaminhoUtils + "," + gcCaminhoForms + "," + gcCaminhoIcones)
    SET PROCEDURE TO (gcCaminhoClasses + "dataaccess.prg")   ADDITIVE
    SET PROCEDURE TO (gcCaminhoClasses + "businessbase.prg") ADDITIVE
    SET PROCEDURE TO (gcCaminhoClasses + "formbase.prg")     ADDITIVE
    SET PROCEDURE TO (gcCaminhoClasses + "gridbase.prg")     ADDITIVE
    SET PROCEDURE TO (gcCaminhoClasses + "FormErro.prg")     ADDITIVE
    SET PROCEDURE TO (gcCaminhoUtils   + "functions.prg")    ADDITIVE
    SET PROCEDURE TO (gcCaminhoUtils   + "messages.prg")     ADDITIVE
    SET PROCEDURE TO (gcCaminhoUtils   + "validators.prg")   ADDITIVE
    SET PROCEDURE TO (gcCaminhoClasses + "fwprogressbar.prg") ADDITIVE
    SET PROCEDURE TO (gcCaminhoClasses + "FormBuscaAuxiliar.prg") ADDITIVE
    SET PROCEDURE TO (gcCaminhoClasses + "sigprilaBO.prg")   ADDITIVE
    SET PROCEDURE TO (gcCaminhoForms + "operacionais\Formsigprila.prg") ADDITIVE
    SET PROCEDURE TO "C:\4c\automation\ProbeIlaFormF8.prg"   ADDITIVE

    gnConnHandle = -1

    *-- ===================================== 1) o form ABRE?
    loc_oForm = CREATEOBJECT("ProbeIlaForm")
    STRTOFILE("1) CREATEOBJECT Formsigprila -> VARTYPE=" + VARTYPE(loc_oForm) + ;
              IIF(VARTYPE(loc_oForm) = "O", " Caption=[" + loc_oForm.Caption + "]", ;
                  " *** O FORM NAO ABRIU ***") + CHR(13) + CHR(10), OUT, 1)

    IF VARTYPE(loc_oForm) != "O"
        STRTOFILE("ABORTADO: form nao instanciou" + CHR(13) + CHR(10), OUT, 1)
        QUIT
    ENDIF

    *-- ===================================== 2) BO ligado?
    STRTOFILE("2) this_oBusinessObject = " + VARTYPE(loc_oForm.this_oBusinessObject) + ;
              IIF(VARTYPE(loc_oForm.this_oBusinessObject) = "O", ;
                  " classe=" + loc_oForm.this_oBusinessObject.Class, "") + ;
              CHR(13) + CHR(10), OUT, 1)

    *-- ===================================== 3) despacho rotina -> metodo do BO
    *-- Este eh o caminho real do botao Processar:
    *--   Processamento -> ValidaCols(BO, rotina) -> ObterMetodoRotina
    loc_aRot[1] = "ListaPreco"
    loc_aRot[2] = "GeraTransf"
    loc_aRot[3] = "AtuaPreco"
    loc_aRot[4] = "GeraPedido"
    loc_aRot[5] = "Pedidocons"
    loc_aRot[6] = "PedidoFab"
    loc_aRot[7] = "PedAcesso"

    loc_cL = "3) despacho ComboTipo.Rotina -> metodo do BO (ValidaCols):" + CHR(13) + CHR(10)
    loc_lAll = .T.
    FOR loc_nI = 1 TO 7
        loc_cRot = loc_aRot[loc_nI]
        loc_cMet = loc_oForm.TesteObterMetodo(loc_cRot)
        loc_cL = loc_cL + "   " + PADR(loc_cRot, 12) + " -> " + PADR(loc_cMet, 26) + ;
                 " ValidaCols=" + TRANSFORM(loc_oForm.TesteValidaCols(loc_cRot)) + CHR(13) + CHR(10)
        IF EMPTY(loc_cMet) OR !loc_oForm.TesteValidaCols(loc_cRot)
            loc_lAll = .F.
        ENDIF
    ENDFOR
    loc_cL = loc_cL + "   TODAS AS 7 ROTINAS DESPACHAM: " + TRANSFORM(loc_lAll) + CHR(13) + CHR(10)
    STRTOFILE(loc_cL, OUT, 1)

    *-- ===================================== 4) rotina desconhecida ainda avisa?
    STRTOFILE("4) rotina inexistente -> ValidaCols=" + ;
              TRANSFORM(loc_oForm.TesteValidaCols("ROTINAQUENAOEXISTE")) + ;
              " (esperado .F., para exibir a mensagem do legado)" + CHR(13) + CHR(10), OUT, 1)

    *-- ===================================== 5) ComboTipo montado
    STRTOFILE("5b) ComboTipo DENTRO da datasession do form: " + loc_oForm.TesteComboTipo() + CHR(13) + CHR(10), OUT, 1)

    STRTOFILE("5) ComboTipo: USED=" + TRANSFORM(USED("ComboTipo")) + ;
              " linhas=" + TRANSFORM(IIF(USED("ComboTipo"), RECCOUNT("ComboTipo"), 0)) + ;
              CHR(13) + CHR(10), OUT, 1)

    loc_oForm.Release()
    STRTOFILE("=== FIM OK ===" + CHR(13) + CHR(10), OUT, 1)

CATCH TO loc_oE
    STRTOFILE("EXCECAO: " + loc_oE.Message + CHR(13) + CHR(10) + ;
              "  Linha: " + TRANSFORM(loc_oE.LineNo) + CHR(13) + CHR(10) + ;
              "  Proc : " + loc_oE.Procedure + CHR(13) + CHR(10), OUT, 1)
ENDTRY

QUIT


*==============================================================================
* ProbeIlaForm - subclasse do form so para alcancar ObterMetodoRotina e
* ValidaCols, que sao PROTECTED (e devem continuar sendo)
*==============================================================================
DEFINE CLASS ProbeIlaForm AS Formsigprila

    FUNCTION TesteObterMetodo(p1)
        RETURN THIS.ObterMetodoRotina(p1)
    ENDFUNC

    FUNCTION TesteComboTipo()
        LOCAL loc_c
        loc_c = "USED=" + TRANSFORM(USED("ComboTipo")) + " DataSessionId=" + TRANSFORM(THIS.DataSessionId)
        IF USED("ComboTipo")
            SELECT ComboTipo
            GO TOP
            loc_c = loc_c + " linhas=" + TRANSFORM(RECCOUNT("ComboTipo")) + " 1a=[" + ALLTRIM(ComboTipo.Rotina) + "]"
        ENDIF
        RETURN loc_c
    ENDFUNC

    FUNCTION TesteValidaCols(p1)
        RETURN THIS.ValidaCols(THIS.this_oBusinessObject, p1)
    ENDFUNC

ENDDEFINE

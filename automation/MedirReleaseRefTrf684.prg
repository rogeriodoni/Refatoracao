*==============================================================================
* MedirReleaseRefTrf684.prg - Mede se a referencia do CHAMADOR sobrevive ao
* THIS.Release() do dialogo (padrao "CREATEOBJECT + Show()" do sistema novo).
*
* O legado SIGPRTRF faz "Thisform.release" e entrega o resultado pelo RETURN do
* Unload, que so chega a quem abre com "DO FORM ... TO <var>". Se a referencia
* NAO sobrevive ao Release, o chamador do sistema novo nao tem como ler
* ObterRetorno()/ObterListaProdutos() - e o dialogo fica sem como devolver nada.
* FormBuscaAuxiliar resolve isso usando Hide() e deixando o Release para o
* chamador; esta medicao confere se o mesmo vale aqui.
*==============================================================================
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF

PUBLIC gb_4c_ModoTeste, gb_4c_ValidandoUI, gc_4c_ArquivoErroTeste
gb_4c_ModoTeste        = .T.
gb_4c_ValidandoUI      = .T.
gc_4c_ArquivoErroTeste = "C:\4c\automation\vfp_error_medir_release.txt"

LOCAL loc_cOut, loc_oForm, loc_oErro
loc_cOut = "C:\4c\automation\medir_release_ref_trf684.txt"
STRTOFILE("INICIO", loc_cOut)

TRY
    CD C:\4c\projeto\app\start
    DO config.prg
    gb_4c_ModoTeste   = .T.
    gb_4c_ValidandoUI = .T.

    SET PATH TO (gcCaminhoBase + "," + gcCaminhoClasses + "," + gcCaminhoUtils + ;
                 "," + gcCaminhoForms + "," + gcCaminhoIcones)
    SET PROCEDURE TO (gcCaminhoClasses + "dataaccess.prg")   ADDITIVE
    SET PROCEDURE TO (gcCaminhoClasses + "businessbase.prg") ADDITIVE
    SET PROCEDURE TO (gcCaminhoClasses + "formbase.prg")     ADDITIVE
    SET PROCEDURE TO (gcCaminhoClasses + "gridbase.prg")     ADDITIVE
    SET PROCEDURE TO (gcCaminhoClasses + "FormErro.prg")     ADDITIVE
    SET PROCEDURE TO (gcCaminhoClasses + "TextBoxGridLookup.prg") ADDITIVE
    SET PROCEDURE TO (gcCaminhoUtils   + "functions.prg")    ADDITIVE
    SET PROCEDURE TO (gcCaminhoUtils   + "messages.prg")     ADDITIVE
    SET PROCEDURE TO (gcCaminhoUtils   + "validators.prg")   ADDITIVE
    SET PROCEDURE TO (gcCaminhoClasses + "SIGPRTRFBO.prg")   ADDITIVE
    SET PROCEDURE TO (gcCaminhoForms + "operacionais\FormSIGPRTRF.prg") ADDITIVE

    *-- CASO A: THIS.Release() com o chamador segurando a referencia
    loc_oForm = CREATEOBJECT("FormSIGPRTRF")
    STRTOFILE(CHR(13) + CHR(10) + "A) antes Release VARTYPE=" + VARTYPE(loc_oForm), loc_cOut, 1)
    loc_oForm.this_cRetorno = "Ok"
    loc_oForm.Release()
    STRTOFILE(CHR(13) + CHR(10) + "A) depois Release VARTYPE=" + VARTYPE(loc_oForm), loc_cOut, 1)
    TRY
        STRTOFILE(CHR(13) + CHR(10) + "A) leitura pos-Release=[" + loc_oForm.this_cRetorno + "]", loc_cOut, 1)
    CATCH TO loc_oErro
        STRTOFILE(CHR(13) + CHR(10) + "A) leitura pos-Release FALHOU: " + loc_oErro.Message, loc_cOut, 1)
    ENDTRY

    *-- CASO B: THIS.Hide() e o chamador lendo depois (padrao FormBuscaAuxiliar)
    loc_oForm = CREATEOBJECT("FormSIGPRTRF")
    loc_oForm.this_cRetorno = "Ok"
    loc_oForm.Hide()
    STRTOFILE(CHR(13) + CHR(10) + "B) depois Hide VARTYPE=" + VARTYPE(loc_oForm), loc_cOut, 1)
    TRY
        STRTOFILE(CHR(13) + CHR(10) + "B) leitura pos-Hide=[" + loc_oForm.ObterRetorno() + "]" + ;
                  " lista=[" + loc_oForm.ObterListaProdutos() + "]", loc_cOut, 1)
    CATCH TO loc_oErro
        STRTOFILE(CHR(13) + CHR(10) + "B) leitura pos-Hide FALHOU: " + loc_oErro.Message, loc_cOut, 1)
    ENDTRY
    loc_oForm.Release()
    STRTOFILE(CHR(13) + CHR(10) + "B) apos Release do chamador VARTYPE=" + VARTYPE(loc_oForm), loc_cOut, 1)

    STRTOFILE(CHR(13) + CHR(10) + "FIM_OK", loc_cOut, 1)
CATCH TO loc_oErro
    STRTOFILE(CHR(13) + CHR(10) + "ERRO=" + loc_oErro.Message + ;
              " LN=" + TRANSFORM(loc_oErro.LineNo) + " PROC=" + loc_oErro.Procedure, loc_cOut, 1)
ENDTRY

QUIT

*==============================================================================
* ProbeArq642F8.prg - Instancia FormSigOpArq headless (Fase 8 / task642) e
* exercita o que a fase acrescentou: BOParaForm (no Init), BtnConfirmarClick
* e BtnCancelarClick. NAO chama ConfigurarAmbiente() (nao retorna nesta maquina).
*==============================================================================
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF

PUBLIC gb_4c_ModoTeste, gb_4c_ValidandoUI, gc_4c_ArquivoErroTeste
gb_4c_ModoTeste        = .T.
gb_4c_ValidandoUI      = .T.
gc_4c_ArquivoErroTeste = "C:\4c\automation\vfp_error_arq642_f8.txt"
IF FILE(gc_4c_ArquivoErroTeste)
    DELETE FILE (gc_4c_ArquivoErroTeste)
ENDIF

LOCAL loc_cOut, loc_oForm, loc_oErro, loc_lRet
loc_cOut = "C:\4c\automation\probe_arq642_f8_result.txt"
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
    SET PROCEDURE TO (gcCaminhoUtils   + "functions.prg")    ADDITIVE
    SET PROCEDURE TO (gcCaminhoUtils   + "messages.prg")     ADDITIVE
    SET PROCEDURE TO (gcCaminhoUtils   + "validators.prg")   ADDITIVE
    SET PROCEDURE TO (gcCaminhoClasses + "SigOpArqBO.prg")   ADDITIVE
    SET PROCEDURE TO (gcCaminhoForms + "operacionais\FormSigOpArq.prg") ADDITIVE
    STRTOFILE(CHR(13)+CHR(10)+"deps OK", loc_cOut, 1)

    loc_oForm = CREATEOBJECT("FormSigOpArq")
    STRTOFILE(CHR(13)+CHR(10)+"CREATEOBJECT=" + VARTYPE(loc_oForm), loc_cOut, 1)

    IF VARTYPE(loc_oForm) = "O"
        *-- 1) BOParaForm rodou no Init: OptionGroup espelha BO.this_nTipos = 1
        STRTOFILE(CHR(13)+CHR(10)+"OptValue=" + TRANSFORM(loc_oForm.obj_4c_Optiongroup1.Value) + ;
                  " BO.this_nTipos=" + TRANSFORM(loc_oForm.this_oBusinessObject.this_nTipos) + ;
                  " BO.this_cTabela=[" + ALLTRIM(loc_oForm.this_oBusinessObject.this_cTabela) + "]", loc_cOut, 1)

        *-- 2) Escopo dos 4 metodos exigidos pela fase (2 = PROTECTED)
        STRTOFILE(CHR(13)+CHR(10)+"ESCOPO FormParaBO prot=" + TRANSFORM(PEMSTATUS(loc_oForm,"FormParaBO",2)) + ;
                  " BOParaForm prot=" + TRANSFORM(PEMSTATUS(loc_oForm,"BOParaForm",2)) + ;
                  " BtnConfirmarClick prot=" + TRANSFORM(PEMSTATUS(loc_oForm,"BtnConfirmarClick",2)) + ;
                  " BtnCancelarClick prot=" + TRANSFORM(PEMSTATUS(loc_oForm,"BtnCancelarClick",2)), loc_cOut, 1)

        *-- 3) SEM item marcado: Confirmar recusa (avisa), Cancelar aceita
        loc_lRet = loc_oForm.BtnConfirmarClick()
        STRTOFILE(CHR(13)+CHR(10)+"SEM MARCA BtnConfirmarClick=" + TRANSFORM(loc_lRet), loc_cOut, 1)
        loc_lRet = loc_oForm.BtnCancelarClick()
        STRTOFILE(CHR(13)+CHR(10)+"SEM MARCA BtnCancelarClick=" + TRANSFORM(loc_lRet), loc_cOut, 1)

        *-- 4) COM item marcado: em ModoTeste MsgConfirma devolve .F. (nao
        *--    confirma), entao os dois tem de recusar E nao limpar a marca
        SELECT cursor_4c_Dados
        APPEND BLANK
        REPLACE Codigos WITH "001", Descricao WITH "TESTE", Marcas WITH 1, NomArqs WITH "C:\temp\x.txt"
        STRTOFILE(CHR(13)+CHR(10)+"RECCOUNT=" + TRANSFORM(RECCOUNT("cursor_4c_Dados")) + ;
                  " ExisteItemSelecionado=" + TRANSFORM(loc_oForm.this_oBusinessObject.ExisteItemSelecionado()), loc_cOut, 1)

        loc_lRet = loc_oForm.BtnConfirmarClick()
        STRTOFILE(CHR(13)+CHR(10)+"COM MARCA BtnConfirmarClick=" + TRANSFORM(loc_lRet), loc_cOut, 1)
        loc_lRet = loc_oForm.BtnCancelarClick()
        STRTOFILE(CHR(13)+CHR(10)+"COM MARCA BtnCancelarClick=" + TRANSFORM(loc_lRet) + ;
                  " MarcaPreservada=" + TRANSFORM(loc_oForm.this_oBusinessObject.ExisteItemSelecionado()), loc_cOut, 1)

        loc_oForm.Release()
        STRTOFILE(CHR(13)+CHR(10)+"RESULTADO=OK", loc_cOut, 1)
    ELSE
        STRTOFILE(CHR(13)+CHR(10)+"RESULTADO=FALHA_CREATEOBJECT", loc_cOut, 1)
    ENDIF

CATCH TO loc_oErro
    STRTOFILE(CHR(13)+CHR(10)+"EXCECAO: " + loc_oErro.Message + ;
              " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
              " PROC=" + loc_oErro.Procedure, loc_cOut, 1)
ENDTRY

QUIT

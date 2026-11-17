*==============================================================================
* ProbeRef794F7.prg - Instancia FormSigOpRef headless (Fase 7 / task794) e
* exercita o que a Fase 7 acrescentou:
*   (1) o form continua instanciavel depois das mudancas da fase;
*   (2) ESCOPO: BtnConfirmarClick/BtnSairClick/FecharDialogo/ObterRetorno/
*       Unload tem de ser PUBLIC (BINDEVENT e o chamador os alcancam de
*       fora); CachearRetorno tem de ser PROTECTED;
*   (3) BINDEVENT: Buttons(1).Click -> BtnConfirmarClick e
*       Buttons(2).Click -> BtnSairClick (provado por AEVENTS);
*   (4) BtnConfirmarClick com o codigo de destino VAZIO RECUSA (legado:
*       "Codigo de Produto Invalido!!!") - nao fecha a tela e NAO grava;
*   (5) a guarda de reentrancia this_lEmGravacao eh liberada no fim;
*   (6) BtnSairClick fecha com Hide(): o objeto SOBREVIVE e o retorno
*       continua legivel pelo chamador (ObterRetorno/Unload).
* NAO chama ConfigurarAmbiente() (nao retorna nesta maquina).
* Nao depende de SQL Server: gb_4c_ModoTeste/gb_4c_ValidandoUI pulam as
* consultas, e as que escaparem caem no CATCH do proprio BO.
*==============================================================================
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF

PUBLIC gb_4c_ModoTeste, gb_4c_ValidandoUI, gc_4c_ArquivoErroTeste, gnConnHandle
gb_4c_ModoTeste        = .T.
gb_4c_ValidandoUI      = .T.
gnConnHandle           = -1
gc_4c_ArquivoErroTeste = "C:\4c\automation\vfp_error_ref794_f7.txt"
IF FILE(gc_4c_ArquivoErroTeste)
    DELETE FILE (gc_4c_ArquivoErroTeste)
ENDIF

LOCAL loc_cOut, loc_oForm, loc_oErro, loc_nEv
LOCAL ARRAY loc_aEv[1]
loc_cOut = "C:\4c\automation\probe_ref794_f7_result.txt"
STRTOFILE("INICIO", loc_cOut)

TRY
    CD C:\4c\projeto\app\start
    DO config.prg
    gb_4c_ModoTeste   = .T.
    gb_4c_ValidandoUI = .T.
    gnConnHandle      = -1

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
    SET PROCEDURE TO (gcCaminhoClasses + "SigOpRefBO.prg")   ADDITIVE
    SET PROCEDURE TO (gcCaminhoForms + "operacionais\FormSigOpRef.prg") ADDITIVE
    STRTOFILE(CHR(13) + CHR(10) + "deps OK", loc_cOut, 1)

    *-- (1) Instanciacao
    loc_oForm = CREATEOBJECT("FormSigOpRef", "0000000000ABCD", 0, .F.)
    STRTOFILE(CHR(13) + CHR(10) + "CREATEOBJECT=" + VARTYPE(loc_oForm), loc_cOut, 1)

    IF VARTYPE(loc_oForm) = "O"
        *-- (2) escopo: PEMSTATUS(...,2) = .T. significa PROTECTED
        STRTOFILE(CHR(13) + CHR(10) + "PROT_BtnConfirmarClick=" + TRANSFORM(PEMSTATUS(loc_oForm, "BtnConfirmarClick", 2)) + ;
                  CHR(13) + CHR(10) + "PROT_BtnSairClick="      + TRANSFORM(PEMSTATUS(loc_oForm, "BtnSairClick", 2)) + ;
                  CHR(13) + CHR(10) + "PROT_FecharDialogo="     + TRANSFORM(PEMSTATUS(loc_oForm, "FecharDialogo", 2)) + ;
                  CHR(13) + CHR(10) + "PROT_ObterRetorno="      + TRANSFORM(PEMSTATUS(loc_oForm, "ObterRetorno", 2)) + ;
                  CHR(13) + CHR(10) + "PROT_Unload="            + TRANSFORM(PEMSTATUS(loc_oForm, "Unload", 2)) + ;
                  CHR(13) + CHR(10) + "PROT_CachearRetorno="    + TRANSFORM(PEMSTATUS(loc_oForm, "CachearRetorno", 2)), loc_cOut, 1)

        *-- (3) BINDEVENT dos dois botoes do CommandGroup
        loc_nEv = AEVENTS(loc_aEv, loc_oForm.cmg_4c_Botoes.Buttons(1))
        STRTOFILE(CHR(13) + CHR(10) + "BIND_Buttons1_n=" + TRANSFORM(loc_nEv) + ;
                  " evento=" + IIF(loc_nEv > 0, loc_aEv[1, 3], "-") + " delegate=" + IIF(loc_nEv > 0, loc_aEv[1, 4], "-"), loc_cOut, 1)

        loc_nEv = AEVENTS(loc_aEv, loc_oForm.cmg_4c_Botoes.Buttons(2))
        STRTOFILE(CHR(13) + CHR(10) + "BIND_Buttons2_n=" + TRANSFORM(loc_nEv) + ;
                  " evento=" + IIF(loc_nEv > 0, loc_aEv[1, 3], "-") + " delegate=" + IIF(loc_nEv > 0, loc_aEv[1, 4], "-"), loc_cOut, 1)

        *-- (4) Confirmar com o codigo de destino VAZIO: tem de RECUSAR
        loc_oForm.txt_4c_CodProdDestino.Value = ""
        STRTOFILE(CHR(13) + CHR(10) + "antes_Confirmar Visible=" + TRANSFORM(loc_oForm.Visible), loc_cOut, 1)

        loc_oForm.BtnConfirmarClick()

        STRTOFILE(CHR(13) + CHR(10) + "pos_Confirmar VARTYPE=" + VARTYPE(loc_oForm) + ;
                  " EmGravacao=" + TRANSFORM(loc_oForm.this_lEmGravacao) + ;
                  " Retorno=[" + loc_oForm.ObterRetorno() + "]", loc_cOut, 1)

        *-- (6) Sair: Hide, nao Release - o objeto tem de sobreviver
        loc_oForm.BtnSairClick()

        STRTOFILE(CHR(13) + CHR(10) + "pos_Sair VARTYPE=" + VARTYPE(loc_oForm) + ;
                  " Visible=" + TRANSFORM(loc_oForm.Visible) + ;
                  " Retorno=[" + loc_oForm.ObterRetorno() + "]" + ;
                  " Unload=[" + loc_oForm.Unload() + "]", loc_cOut, 1)

        loc_oForm.Release()
        STRTOFILE(CHR(13) + CHR(10) + "pos_Release VARTYPE=" + VARTYPE(loc_oForm), loc_cOut, 1)
    ENDIF

    STRTOFILE(CHR(13) + CHR(10) + "FIM", loc_cOut, 1)
CATCH TO loc_oErro
    STRTOFILE(CHR(13) + CHR(10) + "ERRO: " + loc_oErro.Message + ;
              " | Linha " + TRANSFORM(loc_oErro.LineNo) + ;
              " | Proc " + loc_oErro.Procedure, loc_cOut, 1)
ENDTRY

QUIT

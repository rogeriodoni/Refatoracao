*==============================================================================
* ProbeRef794F8.prg - Instancia FormSigOpRef headless (Fase 8 / task794) e
* exercita o que a Fase 8 acrescentou:
*   (1) o form continua instanciavel depois das mudancas da fase;
*   (2) ESCOPO: BtnConfirmarClick/BtnCancelarClick/FecharDialogo/ObterRetorno/
*       Unload/AjustarCamposPorEstado/AplicarEstadoGrupoDestino/
*       ValidarGrupoDestino/GrupoDestinoGotFocus tem de ser PUBLIC (BINDEVENT
*       e o chamador os alcancam de fora); CachearRetorno/FormParaBO/
*       BOParaForm/TornarControlesVisiveis/CarregarProdutoOrigem tem de ser
*       PROTECTED (so o proprio form os chama);
*   (3) BINDEVENT: Buttons(1).Click -> BtnConfirmarClick e
*       Buttons(2).Click -> BtnCancelarClick (provado por AEVENTS);
*   (4) BtnConfirmarClick com o codigo de destino VAZIO RECUSA (legado:
*       "Codigo de Produto Invalido!!!") - nao fecha a tela e NAO grava;
*   (5) a guarda de reentrancia this_lEmGravacao eh liberada no fim;
*   (6) BtnCancelarClick fecha com Hide(): o objeto SOBREVIVE e o retorno
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
gc_4c_ArquivoErroTeste = "C:\4c\automation\vfp_error_ref794_f8.txt"
IF FILE(gc_4c_ArquivoErroTeste)
    DELETE FILE (gc_4c_ArquivoErroTeste)
ENDIF

LOCAL loc_cOut, loc_oForm, loc_oErro, loc_nEv
LOCAL ARRAY loc_aEv[1]
loc_cOut = "C:\4c\automation\probe_ref794_f8_result.txt"
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

        *-- (1b) prova que BOParaForm rodou no Init (em modo de teste ele eh
        *-- chamado mesmo sem SQL): os defaults do BO tem de ter chegado aos
        *-- controles - Quantidade = 1 e Situacao = 1, nunca 0/vazio
        STRTOFILE(CHR(13) + CHR(10) + "CTRL_Quantidade=" + TRANSFORM(loc_oForm.txt_4c_Quantidade.Value) + ;
                  CHR(13) + CHR(10) + "CTRL_Situacao=" + TRANSFORM(loc_oForm.opt_4c_Situacao.Value) + ;
                  CHR(13) + CHR(10) + "CTRL_SituacaoEnabled=" + TRANSFORM(loc_oForm.opt_4c_Situacao.Enabled), loc_cOut, 1)

        *-- (2) escopo: PEMSTATUS(...,2) = .T. significa PROTECTED
        STRTOFILE(CHR(13) + CHR(10) + "PROT_BtnConfirmarClick=" + TRANSFORM(PEMSTATUS(loc_oForm, "BtnConfirmarClick", 2)) + ;
                  CHR(13) + CHR(10) + "PROT_BtnCancelarClick=" + TRANSFORM(PEMSTATUS(loc_oForm, "BtnCancelarClick", 2)) + ;
                  CHR(13) + CHR(10) + "PROT_FecharDialogo=" + TRANSFORM(PEMSTATUS(loc_oForm, "FecharDialogo", 2)) + ;
                  CHR(13) + CHR(10) + "PROT_ObterRetorno=" + TRANSFORM(PEMSTATUS(loc_oForm, "ObterRetorno", 2)) + ;
                  CHR(13) + CHR(10) + "PROT_Unload=" + TRANSFORM(PEMSTATUS(loc_oForm, "Unload", 2)) + ;
                  CHR(13) + CHR(10) + "PROT_AjustarCamposPorEstado=" + TRANSFORM(PEMSTATUS(loc_oForm, "AjustarCamposPorEstado", 2)) + ;
                  CHR(13) + CHR(10) + "PROT_AplicarEstadoGrupoDestino=" + TRANSFORM(PEMSTATUS(loc_oForm, "AplicarEstadoGrupoDestino", 2)) + ;
                  CHR(13) + CHR(10) + "PROT_ValidarGrupoDestino=" + TRANSFORM(PEMSTATUS(loc_oForm, "ValidarGrupoDestino", 2)) + ;
                  CHR(13) + CHR(10) + "PROT_GrupoDestinoGotFocus=" + TRANSFORM(PEMSTATUS(loc_oForm, "GrupoDestinoGotFocus", 2)) + ;
                  CHR(13) + CHR(10) + "PROT_CachearRetorno=" + TRANSFORM(PEMSTATUS(loc_oForm, "CachearRetorno", 2)) + ;
                  CHR(13) + CHR(10) + "PROT_FormParaBO=" + TRANSFORM(PEMSTATUS(loc_oForm, "FormParaBO", 2)) + ;
                  CHR(13) + CHR(10) + "PROT_BOParaForm=" + TRANSFORM(PEMSTATUS(loc_oForm, "BOParaForm", 2)) + ;
                  CHR(13) + CHR(10) + "PROT_CarregarProdutoOrigem=" + TRANSFORM(PEMSTATUS(loc_oForm, "CarregarProdutoOrigem", 2)) + ;
                  CHR(13) + CHR(10) + "PROT_TornarControlesVisiveis=" + TRANSFORM(PEMSTATUS(loc_oForm, "TornarControlesVisiveis", 2)), loc_cOut, 1)

        *-- (2b) os nomes canonicos de CRUD NAO existem nesta tela (dialogo de
        *-- fluxo unico, sem Lista/Page2/modo) - provado, nao presumido
        STRTOFILE(CHR(13) + CHR(10) + "EXISTE_CarregarLista=" + TRANSFORM(PEMSTATUS(loc_oForm, "CarregarLista", 5)) + ;
                  CHR(13) + CHR(10) + "EXISTE_AjustarBotoesPorModo=" + TRANSFORM(PEMSTATUS(loc_oForm, "AjustarBotoesPorModo", 5)) + ;
                  CHR(13) + CHR(10) + "EXISTE_pgf_4c_Paginas=" + TRANSFORM(PEMSTATUS(loc_oForm, "pgf_4c_Paginas", 5)), loc_cOut, 1)

        *-- (3) BINDEVENT dos dois botoes do CommandGroup
        loc_nEv = AEVENTS(loc_aEv, loc_oForm.cmg_4c_Botoes.Buttons(1))
        STRTOFILE(CHR(13) + CHR(10) + "BIND_Buttons1_n=" + TRANSFORM(loc_nEv) + ;
                  " evento=" + IIF(loc_nEv > 0, loc_aEv[1, 3], "-") + " delegate=" + IIF(loc_nEv > 0, loc_aEv[1, 4], "-"), loc_cOut, 1)

        loc_nEv = AEVENTS(loc_aEv, loc_oForm.cmg_4c_Botoes.Buttons(2))
        STRTOFILE(CHR(13) + CHR(10) + "BIND_Buttons2_n=" + TRANSFORM(loc_nEv) + ;
                  " evento=" + IIF(loc_nEv > 0, loc_aEv[1, 3], "-") + " delegate=" + IIF(loc_nEv > 0, loc_aEv[1, 4], "-"), loc_cOut, 1)

        *-- (3b) round-trip FormParaBO -> BO -> BOParaForm nos 5 campos
        *-- editaveis. Chamados por BtnConfirmarClick/InicializarForm (sao
        *-- PROTECTED), entao o teste exercita pelo caminho publico: escreve
        *-- nos controles, le o BO depois do Confirmar (que chama FormParaBO
        *-- antes de validar) e confere que os valores atravessaram.
        loc_oForm.txt_4c_CodProdDestino.Value  = "ABC0000000001"
        loc_oForm.txt_4c_GrupoDestino.Value    = "ZZ9"
        loc_oForm.txt_4c_DescProdDestino.Value = "PRODUTO DE TESTE F8"
        loc_oForm.txt_4c_Quantidade.Value      = 3
        loc_oForm.opt_4c_Situacao.Value        = 2

        *-- (4) Confirmar com o codigo de destino VAZIO: tem de RECUSAR
        loc_oForm.txt_4c_CodProdDestino.Value = ""
        STRTOFILE(CHR(13) + CHR(10) + "antes_Confirmar Visible=" + TRANSFORM(loc_oForm.Visible), loc_cOut, 1)

        loc_oForm.BtnConfirmarClick()

        STRTOFILE(CHR(13) + CHR(10) + "pos_Confirmar VARTYPE=" + VARTYPE(loc_oForm) + ;
                  " EmGravacao=" + TRANSFORM(loc_oForm.this_lEmGravacao) + ;
                  " Retorno=[" + loc_oForm.ObterRetorno() + "]", loc_cOut, 1)


        *-- (4b) prova que FormParaBO atravessou os 5 campos editaveis:
        *-- os valores escritos em (3b) tem de estar no BO (o codigo foi
        *-- zerado de proposito em (4), e eh por isso que ele volta vazio)
        STRTOFILE(CHR(13) + CHR(10) + "BO_CodProdDestino=[" + ALLTRIM(loc_oForm.this_oBusinessObject.this_cCodProdDestino) + "]" + ;
                  CHR(13) + CHR(10) + "BO_GrupoDestino=[" + ALLTRIM(loc_oForm.this_oBusinessObject.this_cGrupoDestino) + "]" + ;
                  CHR(13) + CHR(10) + "BO_DescProdDestino=[" + ALLTRIM(loc_oForm.this_oBusinessObject.this_cDescProdDestino) + "]" + ;
                  CHR(13) + CHR(10) + "BO_Quantidade=" + TRANSFORM(loc_oForm.this_oBusinessObject.this_nQuantidade) + ;
                  CHR(13) + CHR(10) + "BO_Situacao=" + TRANSFORM(loc_oForm.this_oBusinessObject.this_nSituacao), loc_cOut, 1)

        *-- (6) Sair: Hide, nao Release - o objeto tem de sobreviver
        loc_oForm.BtnCancelarClick()

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

*==============================================================================
* ProbeRss672F8.prg - task672 / Fase 8
* Mede os funis consolidados na Fase 8:
*   (A) a tela ABRE (instanciacao real, nao "compilou")
*   (B) AjustarBotoesPorModo deriva o Enabled dos dois botoes das flags
*   (C) HabilitarCampos(.F./.T.) nunca deixa o Encerrar cinza no fim
*   (D) BOParaForm pinta o Caption a partir de BO.this_cStatusMsg
*   (E) zerar a FONTE apaga o Caption no BOParaForm seguinte
*   (F) escopo dos metodos que o harness chama de FORA (regra #3/#51)
*   (G) BtnEncerrarClick NAO fecha a janela durante uma passada
*==============================================================================
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF

PUBLIC gb_4c_ModoTeste, gb_4c_ValidandoUI, gc_4c_ArquivoErroTeste
gb_4c_ModoTeste        = .T.
gb_4c_ValidandoUI      = .T.
gc_4c_ArquivoErroTeste = "C:\4c\automation\vfp_error_rss672f8.txt"
IF FILE(gc_4c_ArquivoErroTeste)
    DELETE FILE (gc_4c_ArquivoErroTeste)
ENDIF

LOCAL loc_cOut, loc_oForm, loc_oErro
loc_cOut = "C:\4c\automation\probe_rss672f8_result.txt"
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
    SET PROCEDURE TO (gcCaminhoClasses + "FormErro.prg")     ADDITIVE
    SET PROCEDURE TO (gcCaminhoUtils   + "functions.prg")    ADDITIVE
    SET PROCEDURE TO (gcCaminhoUtils   + "messages.prg")     ADDITIVE
    SET PROCEDURE TO (gcCaminhoUtils   + "validators.prg")   ADDITIVE
    SET PROCEDURE TO (gcCaminhoClasses + "SigPrRssBO.prg")   ADDITIVE
    SET PROCEDURE TO (gcCaminhoForms + "operacionais\FormSigPrRss.prg") ADDITIVE
    STRTOFILE(CHR(13)+CHR(10)+"deps OK", loc_cOut, 1)

    loc_oForm = CREATEOBJECT("FormSigPrRss")
    STRTOFILE(CHR(13)+CHR(10)+"A VARTYPE=[" + VARTYPE(loc_oForm) + "]", loc_cOut, 1)

    IF VARTYPE(loc_oForm) != "O"
        STRTOFILE(CHR(13)+CHR(10)+"FALHA: form nao instanciou", loc_cOut, 1)
    ELSE
        STRTOFILE(CHR(13)+CHR(10)+"A objetos OK=" + ;
            TRANSFORM(PEMSTATUS(loc_oForm, "cmd_4c_OK", 5)) + ;
            " Sair=" + TRANSFORM(PEMSTATUS(loc_oForm, "cmd_4c_Sair", 5)) + ;
            " Label1=" + TRANSFORM(PEMSTATUS(loc_oForm, "lbl_4c_Label1", 5)) + ;
            " Shape=" + TRANSFORM(PEMSTATUS(loc_oForm, "shp_4c_Shape1", 5)) + ;
            " Cab=" + TRANSFORM(PEMSTATUS(loc_oForm, "cnt_4c_Cabecalho", 5)), loc_cOut, 1)

        STRTOFILE(CHR(13)+CHR(10)+"B inicial OK.Enabled=" + ;
            TRANSFORM(loc_oForm.cmd_4c_OK.Enabled) + " Sair.Enabled=" + ;
            TRANSFORM(loc_oForm.cmd_4c_Sair.Enabled), loc_cOut, 1)

        loc_oForm.HabilitarCampos(.F.)
        STRTOFILE(CHR(13)+CHR(10)+"C Habilitar(.F.) OK=" + ;
            TRANSFORM(loc_oForm.cmd_4c_OK.Enabled) + " Sair=" + ;
            TRANSFORM(loc_oForm.cmd_4c_Sair.Enabled) + ;
            " EmProc=" + TRANSFORM(loc_oForm.this_lEmProcessamento), loc_cOut, 1)

        loc_oForm.BtnEncerrarClick()
        STRTOFILE(CHR(13)+CHR(10)+"G Encerrar em passada: Parar=" + ;
            TRANSFORM(loc_oForm.this_lParar) + ;
            " form vivo=" + TRANSFORM(VARTYPE(loc_oForm) = "O"), loc_cOut, 1)

        loc_oForm.this_lEmPassada = .F.
        loc_oForm.AjustarBotoesPorModo()
        STRTOFILE(CHR(13)+CHR(10)+"B entre passadas OK=" + ;
            TRANSFORM(loc_oForm.cmd_4c_OK.Enabled) + " Sair=" + ;
            TRANSFORM(loc_oForm.cmd_4c_Sair.Enabled), loc_cOut, 1)

        loc_oForm.HabilitarCampos(.T.)
        STRTOFILE(CHR(13)+CHR(10)+"C Habilitar(.T.) OK=" + ;
            TRANSFORM(loc_oForm.cmd_4c_OK.Enabled) + " Sair=" + ;
            TRANSFORM(loc_oForm.cmd_4c_Sair.Enabled), loc_cOut, 1)

        loc_oForm.this_oBusinessObject.this_cStatusMsg = "Aguardando Contas Para Processar.."
        loc_oForm.CarregarLista()
        STRTOFILE(CHR(13)+CHR(10)+"D Caption=[" + ;
            loc_oForm.lbl_4c_Label1.Caption + "]", loc_cOut, 1)

        loc_oForm.this_cUsuario = "TESTEUSR  "
        loc_oForm.this_lOnline  = .T.
        loc_oForm.CarregarLista()
        STRTOFILE(CHR(13)+CHR(10)+"F BO.Usuario=[" + ;
            loc_oForm.this_oBusinessObject.this_cUsuario + "] BO.Online=" + ;
            TRANSFORM(loc_oForm.this_oBusinessObject.this_lOnline), loc_cOut, 1)

        loc_oForm.this_oBusinessObject.this_cStatusMsg = ""
        loc_oForm.CarregarLista()
        STRTOFILE(CHR(13)+CHR(10)+"E Caption pos-limpar len=" + ;
            TRANSFORM(LEN(loc_oForm.lbl_4c_Label1.Caption)), loc_cOut, 1)

        STRTOFILE(CHR(13)+CHR(10)+"F escopo FORM PROTECTED(2): " + ;
            "CarregarLista=" + TRANSFORM(PEMSTATUS(loc_oForm, "CarregarLista", 2)) + ;
            " Ajustar=" + TRANSFORM(PEMSTATUS(loc_oForm, "AjustarBotoesPorModo", 2)) + ;
            " Habilitar=" + TRANSFORM(PEMSTATUS(loc_oForm, "HabilitarCampos", 2)) + ;
            " Alternar=" + TRANSFORM(PEMSTATUS(loc_oForm, "AlternarPagina", 2)) + ;
            " BtnIncluir=" + TRANSFORM(PEMSTATUS(loc_oForm, "BtnIncluirClick", 2)) + ;
            " FormParaBO=" + TRANSFORM(PEMSTATUS(loc_oForm, "FormParaBO", 2)) + ;
            " BOParaForm=" + TRANSFORM(PEMSTATUS(loc_oForm, "BOParaForm", 2)) + ;
            " Limpar=" + TRANSFORM(PEMSTATUS(loc_oForm, "LimparCampos", 2)), loc_cOut, 1)

        loc_oForm.AlternarPagina(1)
        loc_oForm.BtnIncluirClick()
        loc_oForm.BtnCancelarClick()
        loc_oForm.BtnBuscarClick()
        loc_oForm.BtnSalvarClick()
        loc_oForm.BtnAlterarClick()
        loc_oForm.BtnVisualizarClick()
        loc_oForm.BtnExcluirClick()
        STRTOFILE(CHR(13)+CHR(10)+"F harness: chamadas externas OK", loc_cOut, 1)

        STRTOFILE(CHR(13)+CHR(10)+"F escopo BO PROTECTED(2): " + ;
            "BuscarFila=" + TRANSFORM(PEMSTATUS(loc_oForm.this_oBusinessObject, "BuscarFila", 2)) + ;
            " CarregarDoCursor=" + TRANSFORM(PEMSTATUS(loc_oForm.this_oBusinessObject, "CarregarDoCursor", 2)) + ;
            " Marcar=" + TRANSFORM(PEMSTATUS(loc_oForm.this_oBusinessObject, "MarcarEmProcessamento", 2)) + ;
            " Processar=" + TRANSFORM(PEMSTATUS(loc_oForm.this_oBusinessObject, "ProcessarItem", 2)) + ;
            " Verificar=" + TRANSFORM(PEMSTATUS(loc_oForm.this_oBusinessObject, "VerificarMovimento", 2)) + ;
            " Excluir=" + TRANSFORM(PEMSTATUS(loc_oForm.this_oBusinessObject, "Excluir", 2)) + ;
            " Desfazer=" + TRANSFORM(PEMSTATUS(loc_oForm.this_oBusinessObject, "DesfazerTransacao", 2)) + ;
            " GravarLog=" + TRANSFORM(PEMSTATUS(loc_oForm.this_oBusinessObject, "GravarLog", 2)) + ;
            " IniciarLog=" + TRANSFORM(PEMSTATUS(loc_oForm.this_oBusinessObject, "IniciarLog", 2)) + ;
            " RegistrarFalha=" + TRANSFORM(PEMSTATUS(loc_oForm.this_oBusinessObject, "RegistrarFalha", 2)), loc_cOut, 1)

        STRTOFILE(CHR(13)+CHR(10)+"F contadores TotalFila=" + ;
            TRANSFORM(loc_oForm.this_oBusinessObject.this_nTotalFila) + ;
            " Processados=" + TRANSFORM(loc_oForm.this_oBusinessObject.this_nProcessados), loc_cOut, 1)

        loc_oForm.Release()
        loc_oForm = .NULL.
    ENDIF

    STRTOFILE(CHR(13)+CHR(10)+"FIM OK", loc_cOut, 1)
CATCH TO loc_oErro
    STRTOFILE(CHR(13)+CHR(10)+"EXCECAO: " + loc_oErro.Message + ;
        " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
        " PROC=" + loc_oErro.Procedure, loc_cOut, 1)
ENDTRY

QUIT

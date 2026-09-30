*-- Instanciacao + exercicio dos metodos da Fase 8 da task593 (Formsigprcom).
*-- SET SAFETY/RESOURCE OFF obrigatorios: pipeline sem supervisao (CLAUDE.md #6).
SET SAFETY OFF
SET RESOURCE OFF
CLOSE ALL
CLEAR ALL
PUBLIC gb_4c_ModoTeste, gb_4c_ValidandoUI, gc_4c_ArquivoErroTeste
gb_4c_ModoTeste        = .T.
gb_4c_ValidandoUI      = .T.
gc_4c_ArquivoErroTeste = "C:\4c\automation\vfp_error_sigprcomf8.txt"
IF FILE(gc_4c_ArquivoErroTeste)
    DELETE FILE (gc_4c_ArquivoErroTeste)
ENDIF

*-- Rede de seguranca: erro NAO tratado num .prg de topo abre o "Program Error"
*-- MODAL e o pipeline fica pendurado ate o timeout. Grava e sai.
ON ERROR DO ErroFatalSigPrCom WITH MESSAGE(), LINENO(), PROGRAM()

CD C:\4c\projeto\app\start
DO config.prg
ConfigurarAmbiente()
PUBLIC gnConnHandle
gnConnHandle = -1

LOCAL loForm, loErr, lcOut, loPg1, loPg2
lcOut = ""
TRY
    loForm = CREATEOBJECT("Formsigprcom")
CATCH TO loErr
    lcOut = lcOut + "EXCECAO: " + loErr.Message + " Ln=" + TRANSFORM(loErr.LineNo) + ;
            " Proc=" + loErr.Procedure + CHR(13) + CHR(10)
ENDTRY

IF VARTYPE(loForm) = "O"
    loPg1 = loForm.pgf_4c_Paginas.Page1
    loPg2 = loForm.pgf_4c_Paginas.Page2

    lcOut = lcOut + "INSTANCIA: OK  BaseClass=" + loForm.BaseClass + ;
        "  Caption=[" + loForm.Caption + "]" + CHR(13) + CHR(10)
    lcOut = lcOut + "Modo inicial=[" + loForm.this_cModoAtual + "]" + CHR(13) + CHR(10)

    *-- cursor_4c_Itens tem de ter a coluna cidchaves (decide INSERT x UPDATE)
    *-- TYPE() e nao FIELD(): FIELD recebe o INDICE da coluna, nao o nome
    lcOut = lcOut + "cursor_4c_Itens USED=" + TRANSFORM(USED("cursor_4c_Itens")) + ;
        "  FCOUNT=" + IIF(USED("cursor_4c_Itens"), TRANSFORM(FCOUNT("cursor_4c_Itens")), "-") + ;
        "  tipo_cidchaves=[" + TYPE("cursor_4c_Itens.cidchaves") + "]" + CHR(13) + CHR(10)

    *-- AjustarBotoesPorModo: LISTA liga, modo de edicao desliga
    TRY
        loForm.this_cModoAtual = "LISTA"
        loForm.AjustarBotoesPorModo()
        lcOut = lcOut + "LISTA     -> Incluir=" + TRANSFORM(loPg1.cnt_4c_Botoes.cmd_4c_Incluir.Enabled) + ;
            " Alterar=" + TRANSFORM(loPg1.cnt_4c_Botoes.cmd_4c_Alterar.Enabled) + ;
            " Buscar="  + TRANSFORM(loPg1.cnt_4c_Botoes.cmd_4c_Buscar.Enabled) + ;
            " Cancelar=" + TRANSFORM(loPg2.cnt_4c_BotoesAcao.cmd_4c_Cancelar.Enabled) + CHR(13) + CHR(10)

        loForm.this_cModoAtual = "INCLUIR"
        loForm.AjustarBotoesPorModo()
        lcOut = lcOut + "INCLUIR   -> Incluir=" + TRANSFORM(loPg1.cnt_4c_Botoes.cmd_4c_Incluir.Enabled) + ;
            " Alterar=" + TRANSFORM(loPg1.cnt_4c_Botoes.cmd_4c_Alterar.Enabled) + ;
            " Cancelar=" + TRANSFORM(loPg2.cnt_4c_BotoesAcao.cmd_4c_Cancelar.Enabled) + CHR(13) + CHR(10)

        *-- Funil de volta (CLAUDE.md #40): AlternarPagina(1) tem de RELIGAR
        loForm.AlternarPagina(1)
        lcOut = lcOut + "AlternarPagina(1) -> Modo=[" + loForm.this_cModoAtual + "]" + ;
            " Incluir=" + TRANSFORM(loPg1.cnt_4c_Botoes.cmd_4c_Incluir.Enabled) + ;
            " Excluir=" + TRANSFORM(loPg1.cnt_4c_Botoes.cmd_4c_Excluir.Enabled) + ;
            " Buscar="  + TRANSFORM(loPg1.cnt_4c_Botoes.cmd_4c_Buscar.Enabled) + CHR(13) + CHR(10)
    CATCH TO loErr
        lcOut = lcOut + "ERRO AjustarBotoesPorModo: " + loErr.Message + " Ln=" + ;
            TRANSFORM(loErr.LineNo) + " Proc=" + loErr.Procedure + CHR(13) + CHR(10)
    ENDTRY

    *-- HabilitarCampos governa Confirmar; AjustarBotoesPorModo nao o toca
    TRY
        loForm.HabilitarCampos(.F.)
        lcOut = lcOut + "HabilitarCampos(.F.) -> Grade.ReadOnly=" + ;
            TRANSFORM(loPg2.grd_4c_Itens.ReadOnly) + ;
            " Confirmar=" + TRANSFORM(loPg2.cnt_4c_BotoesAcao.cmd_4c_Confirmar.Enabled) + CHR(13) + CHR(10)
        loForm.HabilitarCampos(.T.)
        lcOut = lcOut + "HabilitarCampos(.T.) -> Grade.ReadOnly=" + ;
            TRANSFORM(loPg2.grd_4c_Itens.ReadOnly) + ;
            " Confirmar=" + TRANSFORM(loPg2.cnt_4c_BotoesAcao.cmd_4c_Confirmar.Enabled) + CHR(13) + CHR(10)
    CATCH TO loErr
        lcOut = lcOut + "ERRO HabilitarCampos: " + loErr.Message + " Ln=" + ;
            TRANSFORM(loErr.LineNo) + " Proc=" + loErr.Procedure + CHR(13) + CHR(10)
    ENDTRY

    *-- BtnBuscarClick: modo BUSCAR deixa o Confirmar LIGADO (eh ele que busca)
    TRY
        loForm.BtnBuscarClick()
        lcOut = lcOut + "BtnBuscarClick -> Modo=[" + loForm.this_cModoAtual + "]" + ;
            " Confirmar=" + TRANSFORM(loPg2.cnt_4c_BotoesAcao.cmd_4c_Confirmar.Enabled) + ;
            " Ifor.ReadOnly=" + TRANSFORM(loPg2.txt_4c_Ifor.ReadOnly) + ;
            " Refs.ReadOnly=" + TRANSFORM(loPg2.txt_4c_Refs.ReadOnly) + CHR(13) + CHR(10)
    CATCH TO loErr
        lcOut = lcOut + "ERRO BtnBuscarClick: " + loErr.Message + " Ln=" + ;
            TRANSFORM(loErr.LineNo) + " Proc=" + loErr.Procedure + CHR(13) + CHR(10)
    ENDTRY

    *-- VISUALIZAR: Confirmar nao grava (guarda para chamada por teclado)
    TRY
        loForm.this_cModoAtual = "VISUALIZAR"
        loForm.BtnConfirmarClick()
        lcOut = lcOut + "BtnConfirmarClick(VISUALIZAR): retornou sem gravar" + CHR(13) + CHR(10)
    CATCH TO loErr
        lcOut = lcOut + "ERRO Confirmar VISUALIZAR: " + loErr.Message + " Ln=" + ;
            TRANSFORM(loErr.LineNo) + " Proc=" + loErr.Procedure + CHR(13) + CHR(10)
    ENDTRY

    *-- Produto vazio: Confirmar recusa (legado cmdConfirma)
    TRY
        loForm.this_cModoAtual = "INCLUIR"
        loPg2.txt_4c__Produto.Value = ""
        loForm.BtnConfirmarClick()
        lcOut = lcOut + "BtnConfirmarClick(Produto vazio): recusou" + CHR(13) + CHR(10)
    CATCH TO loErr
        lcOut = lcOut + "ERRO Confirmar produto vazio: " + loErr.Message + " Ln=" + ;
            TRANSFORM(loErr.LineNo) + " Proc=" + loErr.Procedure + CHR(13) + CHR(10)
    ENDTRY

    *-- FormParaBO: com UMA linha na grade, o Confirmar mapeia a linha para o BO
    *-- ANTES do Salvar (que falha aqui de proposito - gnConnHandle = -1)
    TRY
        loForm.this_cModoAtual = "INCLUIR"
        loPg2.txt_4c__Produto.Value = "PROD000001"
        loForm.this_lTemTam = .F.
        loForm.this_lTemCor = .F.
        SELECT cursor_4c_Itens
        ZAP
        INSERT INTO cursor_4c_Itens (cidchaves, cpros, emps, qmaxs, codtams, codcores, deptos) ;
            VALUES ("", "PROD000001", "001", 12.5, "M", "AZ", "DEP01")
        GO TOP IN cursor_4c_Itens
        loForm.BtnConfirmarClick()
        lcOut = lcOut + "FormParaBO -> CPros=[" + ALLTRIM(loForm.this_oBusinessObject.this_cCPros) + "]" + ;
            " Emps=[" + ALLTRIM(loForm.this_oBusinessObject.this_cEmps) + "]" + ;
            " QMaxs=" + TRANSFORM(loForm.this_oBusinessObject.this_nQMaxs) + ;
            " CodTams=[" + ALLTRIM(loForm.this_oBusinessObject.this_cCodTams) + "]" + ;
            " CodCores=[" + ALLTRIM(loForm.this_oBusinessObject.this_cCodCores) + "]" + ;
            " Deptos=[" + ALLTRIM(loForm.this_oBusinessObject.this_cDeptos) + "]" + ;
            " Ordems=[" + ALLTRIM(loForm.this_oBusinessObject.this_cOrdems) + "]" + ;
            " PKgerada=" + TRANSFORM(!EMPTY(loForm.this_oBusinessObject.this_cCidChaves)) + CHR(13) + CHR(10)
    CATCH TO loErr
        lcOut = lcOut + "ERRO FormParaBO via Confirmar: " + loErr.Message + " Ln=" + ;
            TRANSFORM(loErr.LineNo) + " Proc=" + loErr.Procedure + CHR(13) + CHR(10)
    ENDTRY

    *-- LimparCampos (PROTECTED) exercitado via BtnCancelarClick
    TRY
        loForm.BtnCancelarClick()
        lcOut = lcOut + "BtnCancelarClick -> Modo=[" + loForm.this_cModoAtual + "]" + ;
            " Produto=[" + ALLTRIM(loPg2.txt_4c__Produto.Value) + "]" + ;
            " BO.EmEdicao=" + TRANSFORM(loForm.this_oBusinessObject.this_lEmEdicao) + ;
            " Incluir=" + TRANSFORM(loPg1.cnt_4c_Botoes.cmd_4c_Incluir.Enabled) + CHR(13) + CHR(10)
    CATCH TO loErr
        lcOut = lcOut + "ERRO BtnCancelarClick: " + loErr.Message + " Ln=" + ;
            TRANSFORM(loErr.LineNo) + " Proc=" + loErr.Procedure + CHR(13) + CHR(10)
    ENDTRY

    *-- ExcluirItensRemovidos: monta o SQL sem estourar (sem conexao devolve .F.)
    TRY
        lcOut = lcOut + "ExcluirItensRemovidos(2 chaves)=" + ;
            TRANSFORM(loForm.this_oBusinessObject.ExcluirItensRemovidos("PROD000001", "K1,K2")) + ;
            "  (lista vazia)=" + ;
            TRANSFORM(loForm.this_oBusinessObject.ExcluirItensRemovidos("PROD000001", "")) + CHR(13) + CHR(10)
    CATCH TO loErr
        lcOut = lcOut + "ERRO ExcluirItensRemovidos: " + loErr.Message + " Ln=" + ;
            TRANSFORM(loErr.LineNo) + " Proc=" + loErr.Procedure + CHR(13) + CHR(10)
    ENDTRY
ELSE
    lcOut = lcOut + "INSTANCIA: FALHOU  VARTYPE=" + VARTYPE(loForm) + CHR(13) + CHR(10)
ENDIF

IF FILE(gc_4c_ArquivoErroTeste)
    lcOut = lcOut + "--- ERROS CAPTURADOS ---" + CHR(13) + CHR(10) + FILETOSTR(gc_4c_ArquivoErroTeste)
ENDIF

STRTOFILE(lcOut, "C:\4c\automation\instantiate_sigprcom_f8_result.txt")
QUIT

PROCEDURE ErroFatalSigPrCom(par_cMsg, par_nLinha, par_cPrograma)
    STRTOFILE("ERRO FATAL NAO TRATADO: " + par_cMsg + ;
        "  Linha=" + TRANSFORM(par_nLinha) + ;
        "  Programa=" + par_cPrograma + CHR(13) + CHR(10), ;
        "C:\4c\automation\instantiate_sigprcom_f8_result.txt")
    QUIT
ENDPROC

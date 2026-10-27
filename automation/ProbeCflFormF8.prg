*==============================================================================
* ProbeCflFormF8.prg - Prova a Fase 8/8 (consolidacao final) do FormSigOpCfl
* (task687), cobrindo os caminhos que a Fase 6 (ProbeCflFormF6.prg) nao
* exercitou:
*   1) instanciacao completa (Init -> InicializarForm -> ConfigurarPageFrame
*      inteiro, com CarregarLista/CarregarCabecalhoCheque em modo teste)
*   2) AjustarAcoesPorAcesso: os 4 botoes ficam visiveis e reempilhados
*      (fChecaAcesso sempre .T.)
*   3) BtnIncluirClick abre o painel com defaults (DATETIME/SPACE(50))
*   4) BtnAlterarClick: guarda contra grade vazia + carga da linha corrente
*   5) BtnExcluirClick: guarda contra grade vazia (sem conexao SQL real,
*      so prova que nao estoura e que CarregarLista roda no fim)
*   6) BtnEncerrarClick: Release() fecha o form sem excecao
*   7) Destroy: libera os 3 cursores placeholder sem erro
*
* Script auxiliar de pipeline: SET SAFETY OFF + SET RESOURCE OFF
* obrigatorios (regra #6 - execucao unattended).
*==============================================================================
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF

PUBLIC gb_4c_ModoTeste, gc_4c_ArquivoErroTeste, gnConnHandle, gc_4c_UsuarioLogado
gb_4c_ModoTeste        = .T.
gc_4c_ArquivoErroTeste = "C:\4c\automation\vfp_err_cflform_f8.txt"

#DEFINE OUT "C:\4c\automation\probe_cflform_f8.txt"

LOCAL loc_oE, loc_oForm, loc_cL

STRTOFILE("=== PROBE FormSigOpCfl - Fase 8/8 (task687) ===" + CHR(13) + CHR(10), OUT)
IF FILE(gc_4c_ArquivoErroTeste)
    DELETE FILE (gc_4c_ArquivoErroTeste)
ENDIF

TRY
    CD C:\4c\projeto\app\start
    DO config.prg
    gc_4c_UsuarioLogado = "TESTE"
    gnConnHandle = -1

    SET PATH TO (gcCaminhoBase + "," + gcCaminhoClasses + "," + gcCaminhoUtils + "," + gcCaminhoForms + "," + gcCaminhoIcones)
    SET PROCEDURE TO (gcCaminhoClasses + "dataaccess.prg")              ADDITIVE
    SET PROCEDURE TO (gcCaminhoClasses + "businessbase.prg")            ADDITIVE
    SET PROCEDURE TO (gcCaminhoClasses + "formbase.prg")                ADDITIVE
    SET PROCEDURE TO (gcCaminhoClasses + "gridbase.prg")                ADDITIVE
    SET PROCEDURE TO (gcCaminhoClasses + "FormErro.prg")                ADDITIVE
    SET PROCEDURE TO (gcCaminhoUtils   + "functions.prg")               ADDITIVE
    SET PROCEDURE TO (gcCaminhoUtils   + "messages.prg")                ADDITIVE
    SET PROCEDURE TO (gcCaminhoUtils   + "validators.prg")              ADDITIVE
    SET PROCEDURE TO (gcCaminhoClasses + "FormBuscaAuxiliar.prg")       ADDITIVE
    SET PROCEDURE TO (gcCaminhoClasses + "TextBoxGridLookup.prg")       ADDITIVE
    SET PROCEDURE TO (gcCaminhoClasses + "SigOpCflBO.prg")              ADDITIVE
    SET PROCEDURE TO (gcCaminhoForms + "operacionais\FormSigOpCfl.prg") ADDITIVE

    *-- =============================================== 1) instanciacao completa
    loc_oForm = CREATEOBJECT("FormSigOpCfl", "00001234")
    STRTOFILE("1) CREATEOBJECT FormSigOpCfl('00001234') -> VARTYPE=" + VARTYPE(loc_oForm) + ;
              IIF(VARTYPE(loc_oForm) = "O", ;
                  " Caption=[" + loc_oForm.Caption + "] this_cConta=[" + loc_oForm.this_cConta + "]", ;
                  " *** O FORM NAO ABRIU ***") + CHR(13) + CHR(10), OUT, 1)

    IF VARTYPE(loc_oForm) != "O"
        STRTOFILE("ABORTADO: form nao instanciou" + CHR(13) + CHR(10), OUT, 1)
        QUIT
    ENDIF

    *-- =============================================== 2) AjustarAcoesPorAcesso
    loc_cL = "2) AjustarAcoesPorAcesso (fChecaAcesso sempre .T. -> 4 visiveis):" + CHR(13) + CHR(10)
    WITH loc_oForm.cmg_4c_CmdApagaitem
        loc_cL = loc_cL + "   Buttons(1) Apagar  Visible=" + TRANSFORM(.Buttons(1).Visible) + " Left=" + TRANSFORM(.Buttons(1).Left) + CHR(13) + CHR(10)
        loc_cL = loc_cL + "   Buttons(2) Listar  Visible=" + TRANSFORM(.Buttons(2).Visible) + " Left=" + TRANSFORM(.Buttons(2).Left) + CHR(13) + CHR(10)
        loc_cL = loc_cL + "   Buttons(3) Incluir Visible=" + TRANSFORM(.Buttons(3).Visible) + " Left=" + TRANSFORM(.Buttons(3).Left) + CHR(13) + CHR(10)
        loc_cL = loc_cL + "   Buttons(4) Alterar Visible=" + TRANSFORM(.Buttons(4).Visible) + " Left=" + TRANSFORM(.Buttons(4).Left) + CHR(13) + CHR(10)
        loc_cL = loc_cL + "   Grupo Visible=" + TRANSFORM(.Visible) + " Width=" + TRANSFORM(.Width) + "  (esperado .T. / 330)" + CHR(13) + CHR(10)
    ENDWITH
    STRTOFILE(loc_cL, OUT, 1)

    *-- =============================================== 3) BtnIncluirClick
    loc_oForm.cnt_4c__inserir.Visible = .F.
    loc_oForm.this_cModoAtual = ""
    loc_oForm.BtnIncluirClick()
    loc_cL = "3) BtnIncluirClick:" + CHR(13) + CHR(10)
    loc_cL = loc_cL + "   this_cModoAtual=[" + loc_oForm.this_cModoAtual + "]  (esperado INSERIR)" + CHR(13) + CHR(10)
    loc_cL = loc_cL + "   cnt_4c__inserir.Visible=" + TRANSFORM(loc_oForm.cnt_4c__inserir.Visible) + "  (esperado .T.)" + CHR(13) + CHR(10)
    loc_cL = loc_cL + "   txt_4c_Data.Value tipo=" + VARTYPE(loc_oForm.cnt_4c__inserir.txt_4c_Data.Value) + "  (esperado T)" + CHR(13) + CHR(10)
    loc_cL = loc_cL + "   txt_4c_Hist.Value=[" + loc_oForm.cnt_4c__inserir.txt_4c_Hist.Value + "] Len=" + TRANSFORM(LEN(loc_oForm.cnt_4c__inserir.txt_4c_Hist.Value)) + "  (esperado 50 espacos)" + CHR(13) + CHR(10)
    STRTOFILE(loc_cL, OUT, 1)

    *-- =============================================== 4) BtnAlterarClick
    loc_oForm.cnt_4c__inserir.Visible = .F.
    loc_oForm.this_cModoAtual = ""
    IF USED("cursor_4c_Dados")
        SELECT cursor_4c_Dados
        ZAP
    ENDIF
    loc_oForm.BtnAlterarClick()
    loc_cL = "4a) BtnAlterarClick com grade VAZIA:" + CHR(13) + CHR(10)
    loc_cL = loc_cL + "   this_cModoAtual=[" + loc_oForm.this_cModoAtual + "]  (esperado vazio - guarda impediu)" + CHR(13) + CHR(10)
    loc_cL = loc_cL + "   cnt_4c__inserir.Visible=" + TRANSFORM(loc_oForm.cnt_4c__inserir.Visible) + "  (esperado .F.)" + CHR(13) + CHR(10)
    STRTOFILE(loc_cL, OUT, 1)

    SELECT cursor_4c_Dados
    APPEND BLANK
    REPLACE cidchaves WITH "CHAVE0000000000002", ;
            nums      WITH "00001234", ;
            datas     WITH DATETIME(), ;
            hists     WITH "HISTORICO PARA ALTERAR", ;
            emps      WITH "001", ;
            autos     WITH .F.
    GO TOP IN cursor_4c_Dados
    loc_oForm.BtnAlterarClick()
    loc_cL = "4b) BtnAlterarClick com 1 linha selecionada:" + CHR(13) + CHR(10)
    loc_cL = loc_cL + "   this_cModoAtual=[" + loc_oForm.this_cModoAtual + "]  (esperado ALTERAR)" + CHR(13) + CHR(10)
    loc_cL = loc_cL + "   cnt_4c__inserir.Visible=" + TRANSFORM(loc_oForm.cnt_4c__inserir.Visible) + "  (esperado .T.)" + CHR(13) + CHR(10)
    loc_cL = loc_cL + "   txt_4c_Hist.Value=[" + ALLTRIM(loc_oForm.cnt_4c__inserir.txt_4c_Hist.Value) + "]  (esperado HISTORICO PARA ALTERAR)" + CHR(13) + CHR(10)
    STRTOFILE(loc_cL, OUT, 1)

    *-- =============================================== 5) BtnExcluirClick
    loc_oForm.cnt_4c__inserir.Visible = .F.
    IF USED("cursor_4c_Dados")
        SELECT cursor_4c_Dados
        ZAP
    ENDIF
    loc_oForm.BtnExcluirClick()
    loc_cL = "5a) BtnExcluirClick com grade VAZIA -> sem excecao (guarda RETURN):" + CHR(13) + CHR(10) + "   OK" + CHR(13) + CHR(10)
    STRTOFILE(loc_cL, OUT, 1)

    SELECT cursor_4c_Dados
    APPEND BLANK
    REPLACE cidchaves WITH "CHAVE0000000000003", ;
            nums      WITH "00001234", ;
            datas     WITH DATETIME(), ;
            hists     WITH "HISTORICO AUTOMATICO", ;
            emps      WITH "001", ;
            autos     WITH .T.
    GO TOP IN cursor_4c_Dados
    loc_oForm.BtnExcluirClick()
    loc_cL = "5b) BtnExcluirClick com 1 linha (sem gnConnHandle real) -> sem excecao:" + CHR(13) + CHR(10) + "   OK" + CHR(13) + CHR(10)
    STRTOFILE(loc_cL, OUT, 1)

    *-- =============================================== 6) BtnEncerrarClick
    loc_oForm.BtnEncerrarClick()
    STRTOFILE("6) BtnEncerrarClick -> sem excecao (Release() chamado)" + CHR(13) + CHR(10), OUT, 1)

    STRTOFILE("=== FIM OK ===" + CHR(13) + CHR(10), OUT, 1)

CATCH TO loc_oE
    STRTOFILE("EXCECAO: " + loc_oE.Message + CHR(13) + CHR(10) + ;
              "  Linha: " + TRANSFORM(loc_oE.LineNo) + CHR(13) + CHR(10) + ;
              "  Proc : " + loc_oE.Procedure + CHR(13) + CHR(10), OUT, 1)
ENDTRY

IF FILE(gc_4c_ArquivoErroTeste)
    STRTOFILE("--- MENSAGENS CAPTURADAS EM MODO TESTE ---" + CHR(13) + CHR(10) + ;
              FILETOSTR(gc_4c_ArquivoErroTeste) + CHR(13) + CHR(10), OUT, 1)
ELSE
    STRTOFILE("--- nenhuma mensagem capturada ---" + CHR(13) + CHR(10), OUT, 1)
ENDIF

QUIT

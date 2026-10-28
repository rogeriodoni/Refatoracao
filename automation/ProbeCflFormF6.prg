*==============================================================================
* ProbeCflFormF6.prg - Prova a Fase 6 do FormSigOpCfl (task687) EXECUTANDO:
*   1) o form INSTANCIA (o Init inteiro roda, inclusive o Column1.AddObject +
*      CurrentControl da celula de data)
*   2) a celula TextBoxCelulaFollowupCfl_4c esta instalada e VISIVEL em todas
*      as linhas (CurrentControl + Sparse = .F. - regra #18)
*   3) o BINDEVENT de txt_4c_Hist esta em "LostFocus" (nao em "KeyPress")
*   4) o When da celula devolve a visibilidade do Apaga Item (legado)
*   5) o Valid da celula recusa data vazia com RETURN 0 e aceita data valida
*   6) FormParaBO transfere o painel para o BO em INSERIR e exige a linha da
*      grade em ALTERAR
*   7) a guarda de reentrancia impede a 2a gravacao do mesmo LostFocus
*
* Script auxiliar de pipeline: SET SAFETY OFF + SET RESOURCE OFF obrigatorios
* (regra #6 - execucao unattended).
*==============================================================================
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF

PUBLIC gb_4c_ModoTeste, gc_4c_ArquivoErroTeste, gnConnHandle, gc_4c_UsuarioLogado
gb_4c_ModoTeste        = .T.
gc_4c_ArquivoErroTeste = "C:\4c\automation\vfp_err_cflform.txt"

#DEFINE OUT "C:\4c\automation\probe_cflform.txt"

LOCAL loc_oE, loc_oForm, loc_cL, loc_nI, loc_nQtd, loc_uRet, loc_oBO
LOCAL ARRAY loc_aEv[1, 1]

STRTOFILE("=== PROBE FormSigOpCfl - Fase 6 (task687) ===" + CHR(13) + CHR(10), OUT)
IF FILE(gc_4c_ArquivoErroTeste)
    DELETE FILE (gc_4c_ArquivoErroTeste)
ENDIF

TRY
    CD C:\4c\projeto\app\start
    DO config.prg
    gc_4c_UsuarioLogado = "TESTE"
    gnConnHandle = -1

    *-- ConfigurarAmbiente() do config.prg BLOQUEIA nesta maquina (nunca
    *-- retorna) e eh ELE que carrega classes/forms - carregar a mao so o
    *-- que este form usa.
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
    SET PROCEDURE TO "C:\4c\automation\ProbeCflFormF6.prg" ADDITIVE

    *-- =============================================== 1) o form ABRE?
    loc_oForm = CREATEOBJECT("ProbeCflForm")
    STRTOFILE("1) CREATEOBJECT FormSigOpCfl -> VARTYPE=" + VARTYPE(loc_oForm) + ;
              IIF(VARTYPE(loc_oForm) = "O", ;
                  " Caption=[" + loc_oForm.Caption + "]", ;
                  " *** O FORM NAO ABRIU ***") + CHR(13) + CHR(10), OUT, 1)

    IF VARTYPE(loc_oForm) != "O"
        STRTOFILE("ABORTADO: form nao instanciou" + CHR(13) + CHR(10), OUT, 1)
        QUIT
    ENDIF

    *-- =============================================== 2) celula instalada?
    loc_cL = "2) celula da Column1 (regra #18):" + CHR(13) + CHR(10)
    loc_cL = loc_cL + "   CurrentControl = [" + ;
             loc_oForm.grd_4c_Dados.Column1.CurrentControl + "]" + CHR(13) + CHR(10)
    loc_cL = loc_cL + "   Sparse         = " + ;
             TRANSFORM(loc_oForm.grd_4c_Dados.Column1.Sparse) + ;
             "  (esperado .F.)" + CHR(13) + CHR(10)
    loc_cL = loc_cL + "   membro existe  = " + ;
             TRANSFORM(PEMSTATUS(loc_oForm.grd_4c_Dados.Column1, "txt_4c_CelulaData", 5)) + CHR(13) + CHR(10)
    loc_cL = loc_cL + "   Class da celula= [" + ;
             loc_oForm.grd_4c_Dados.Column1.txt_4c_CelulaData.Class + "]" + CHR(13) + CHR(10)
    loc_cL = loc_cL + "   Column1.ReadOnly = " + ;
             TRANSFORM(loc_oForm.grd_4c_Dados.Column1.ReadOnly) + ;
             "  (legado: .T.)" + CHR(13) + CHR(10)
    STRTOFILE(loc_cL, OUT, 1)

    *-- =============================================== 3) BINDEVENT em LostFocus?
    *-- AEVENTS tem DOIS argumentos e consulta pelo objeto de ORIGEM;
    *-- col 3 = nome do EVENTO, col 4 = nome do METODO delegate.
    loc_nQtd = AEVENTS(loc_aEv, loc_oForm.cnt_4c__inserir.txt_4c_Hist)
    loc_cL = "3) BINDEVENT em txt_4c_Hist: " + TRANSFORM(loc_nQtd) + " binding(s)" + CHR(13) + CHR(10)
    FOR loc_nI = 1 TO loc_nQtd
        loc_cL = loc_cL + "   evento=[" + ALLTRIM(loc_aEv[loc_nI, 3]) + "]" + ;
                 " metodo=[" + ALLTRIM(loc_aEv[loc_nI, 4]) + "]" + ;
                 "  (esperado LOSTFOCUS / HISTORICOLOSTFOCUS)" + CHR(13) + CHR(10)
    ENDFOR
    IF loc_nQtd = 0
        loc_cL = loc_cL + "   *** NENHUM BINDING - o gate da Fase 6 exige BINDEVENT ***" + CHR(13) + CHR(10)
    ENDIF
    STRTOFILE(loc_cL, OUT, 1)

    *-- =============================================== 4) When da celula
    loc_cL = "4) When da celula (legado: Return cmdApagar.Visible):" + CHR(13) + CHR(10)
    loc_oForm.cmg_4c_CmdApagaitem.Buttons(1).Visible = .T.
    loc_cL = loc_cL + "   Apagar.Visible=.T. -> CelulaDataFollowupEditavel=" + ;
             TRANSFORM(loc_oForm.CelulaDataFollowupEditavel(.NULL.)) + CHR(13) + CHR(10)
    loc_oForm.cmg_4c_CmdApagaitem.Buttons(1).Visible = .F.
    loc_cL = loc_cL + "   Apagar.Visible=.F. -> CelulaDataFollowupEditavel=" + ;
             TRANSFORM(loc_oForm.CelulaDataFollowupEditavel(.NULL.)) + CHR(13) + CHR(10)
    loc_oForm.cmg_4c_CmdApagaitem.Buttons(1).Visible = .T.
    STRTOFILE(loc_cL, OUT, 1)

    *-- =============================================== 5) Valid da celula
    loc_cL = "5) Valid da celula (legado: Empty -> msg + Return 0):" + CHR(13) + CHR(10)
    loc_oForm.cnt_4c__inserir.txt_4c_Data.Value = {}
    loc_uRet = loc_oForm.ValidarCelulaDataFollowupExec(loc_oForm.cnt_4c__inserir.txt_4c_Data)
    loc_cL = loc_cL + "   data VAZIA  -> retorno=" + TRANSFORM(loc_uRet) + ;
             " tipo=" + VARTYPE(loc_uRet) + "  (esperado 0 / N)" + CHR(13) + CHR(10)
    loc_oForm.cnt_4c__inserir.txt_4c_Data.Value = DATETIME()
    loc_uRet = loc_oForm.ValidarCelulaDataFollowupExec(loc_oForm.cnt_4c__inserir.txt_4c_Data)
    loc_cL = loc_cL + "   data VALIDA -> retorno=" + TRANSFORM(loc_uRet) + ;
             " tipo=" + VARTYPE(loc_uRet) + "  (esperado .T. / L)" + CHR(13) + CHR(10)
    STRTOFILE(loc_cL, OUT, 1)

    *-- =============================================== 6) FormParaBO
    loc_oBO = loc_oForm.this_oBusinessObject
    loc_cL = "6) FormParaBO:" + CHR(13) + CHR(10)
    loc_cL = loc_cL + "   this_oBusinessObject=" + VARTYPE(loc_oBO) + ;
             IIF(VARTYPE(loc_oBO) = "O", " classe=" + loc_oBO.Class, "") + CHR(13) + CHR(10)

    loc_oForm.this_cConta    = "00001234"
    loc_oForm.this_cModoAtual = "INSERIR"
    loc_oForm.cnt_4c__inserir.txt_4c_Data.Value = DATETIME()
    loc_oForm.cnt_4c__inserir.txt_4c_Hist.Value = "TESTE DE FOLLOWUP"
    loc_uRet = loc_oForm.TesteFormParaBO()
    loc_cL = loc_cL + "   INSERIR -> retorno=" + TRANSFORM(loc_uRet) + ;
             " Nums=[" + ALLTRIM(loc_oBO.this_cNums) + "]" + ;
             " Hists=[" + ALLTRIM(loc_oBO.this_cHists) + "]" + ;
             " Datas tipo=" + VARTYPE(loc_oBO.this_dDatas) + ;
             " Emps=[" + ALLTRIM(loc_oBO.this_cEmps) + "]" + ;
             " CidChaves=[" + ALLTRIM(loc_oBO.this_cCidChaves) + "]" + CHR(13) + CHR(10)

    *-- Datas com DATE puro (o TextBox nasce com .Value = {}) tem de virar T
    loc_oForm.cnt_4c__inserir.txt_4c_Data.Value = DATE()
    loc_uRet = loc_oForm.TesteFormParaBO()
    loc_cL = loc_cL + "   INSERIR com DATE -> this_dDatas tipo=" + ;
             VARTYPE(loc_oBO.this_dDatas) + "  (esperado T - regra #16)" + CHR(13) + CHR(10)

    loc_oForm.this_cModoAtual = "ALTERAR"
    loc_uRet = loc_oForm.TesteFormParaBO()
    loc_cL = loc_cL + "   ALTERAR com grade VAZIA -> retorno=" + TRANSFORM(loc_uRet) + ;
             "  (esperado .F. - sem chave nao faz UPDATE)" + CHR(13) + CHR(10)

    *-- ALTERAR com uma linha na grade: a chave vem do cursor
    SELECT cursor_4c_Dados
    APPEND BLANK
    REPLACE cidchaves WITH "CHAVE0000000000001", ;
            nums      WITH "00001234", ;
            datas     WITH DATETIME(), ;
            hists     WITH "HISTORICO ORIGINAL", ;
            emps      WITH "001", ;
            autos     WITH .F.
    GO TOP IN cursor_4c_Dados
    loc_uRet = loc_oForm.TesteFormParaBO()
    loc_cL = loc_cL + "   ALTERAR com 1 linha   -> retorno=" + TRANSFORM(loc_uRet) + ;
             " CidChaves=[" + ALLTRIM(loc_oBO.this_cCidChaves) + "]" + CHR(13) + CHR(10)
    STRTOFILE(loc_cL, OUT, 1)

    *-- =============================================== 7) guarda de reentrancia
    loc_cL = "7) guarda de reentrancia (regra #47):" + CHR(13) + CHR(10)
    loc_oForm.this_lEmGravacao = .T.
    loc_oForm.ZerarContador()
    loc_oForm.HistoricoLostFocus()
    loc_cL = loc_cL + "   flag LIGADA   -> Exec chamado " + ;
             TRANSFORM(loc_oForm.ContarExec()) + "x  (esperado 0)" + CHR(13) + CHR(10)

    loc_oForm.this_lEmGravacao = .F.
    loc_oForm.ZerarContador()
    loc_oForm.cnt_4c__inserir.Visible           = .T.
    loc_oForm.this_cModoAtual                   = ""
    loc_oForm.cnt_4c__inserir.txt_4c_Hist.Value = ""
    loc_oForm.HistoricoLostFocus()
    loc_cL = loc_cL + "   flag SOLTA    -> Exec chamado " + ;
             TRANSFORM(loc_oForm.ContarExec()) + "x  (esperado 1)" + CHR(13) + CHR(10)
    loc_cL = loc_cL + "   painel fechou -> cnt_4c__inserir.Visible=" + ;
             TRANSFORM(loc_oForm.cnt_4c__inserir.Visible) + ;
             "  (legado fecha SEMPRE)" + CHR(13) + CHR(10)
    loc_cL = loc_cL + "   flag liberada -> this_lEmGravacao=" + ;
             TRANSFORM(loc_oForm.this_lEmGravacao) + "  (esperado .F.)" + CHR(13) + CHR(10)
    STRTOFILE(loc_cL, OUT, 1)

    loc_oForm.Release()
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


*==============================================================================
* ProbeCflForm - subclasse do form so para CONTAR as chamadas de
* HistoricoLostFocusExec (prova da guarda de reentrancia) sem mudar o form
*==============================================================================
DEFINE CLASS ProbeCflForm AS FormSigOpCfl

    this_nExec = 0

    PROCEDURE ZerarContador()
        THIS.this_nExec = 0
    ENDPROC

    FUNCTION ContarExec()
        RETURN THIS.this_nExec
    ENDFUNC

    PROCEDURE HistoricoLostFocusExec()
        THIS.this_nExec = THIS.this_nExec + 1
        DODEFAULT()
    ENDPROC

    *-- FormParaBO eh PROTECTED em FormBase e o VFP9 nao deixa a subclasse
    *-- ALARGAR o escopo herdado: script solto nao alcanca, subclasse sim.
    FUNCTION TesteFormParaBO()
        RETURN THIS.FormParaBO()
    ENDFUNC

ENDDEFINE

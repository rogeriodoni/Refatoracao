*==============================================================================
* ProbePpc665F6.prg - Probe da Fase 6 de FormSigPrPpc (task665)
*
* Prova, MEDINDO em VFP9 (nao lendo o codigo):
*   1) o form INSTANCIA (CREATEOBJECT devolve objeto, nao .F.)
*   2) os 9 campos de filtro + 6 labels do legado existem
*   3) os 7 metodos AbrirBusca* existem e sao PUBLIC (alvos de chamada externa)
*   4) AtualizarDependenciaCampos existe, eh PUBLIC e reproduz os 3 When do
*      legado (ReadOnly/TabStop da descricao x codigo irmao preenchido/vazio)
*   5) a guarda this_lEmLookup realmente BLOQUEIA reentrancia no KeyPress
*   6) o caminho de volta (BtnCancelarClick) reabre as descricoes
*   7) TabIndex e MaxLength transcritos do SCX continuam de pe
*
* NAO chama Show(): o form eh modal (WindowType = 1) e Show() BLOQUEARIA o
* harness headless. NAO exercita lookup com valor preenchido: o SQL Server
* 192.168.200.10 nao tem rota desta maquina (gnConnHandle = -1 aqui).
*==============================================================================
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
PUBLIC gb_4c_ModoTeste, gc_4c_ArquivoErroTeste, gnConnHandle, gc_4c_UsuarioLogado
gb_4c_ModoTeste = .T.
gc_4c_ArquivoErroTeste = "C:\4c\automation\vfp_err_ppc665.txt"
#DEFINE OUT "C:\4c\automation\probe_ppc665_f6.txt"

LOCAL loc_oForm, loc_cL, loc_nFalhas, loc_oE, loc_i, loc_cN, loc_lTodos
loc_nFalhas = 0

STRTOFILE("=== PROBE Fase 6 - FormSigPrPpc ===" + CHR(13) + CHR(10), OUT)

TRY
    CD C:\4c\projeto\app\start
    DO config.prg
    gc_4c_UsuarioLogado = "TESTE"
    SET PATH TO (gcCaminhoBase + "," + gcCaminhoClasses + "," + gcCaminhoUtils + "," + gcCaminhoForms + "," + gcCaminhoIcones)
    SET PROCEDURE TO (gcCaminhoClasses + "dataaccess.prg")        ADDITIVE
    SET PROCEDURE TO (gcCaminhoClasses + "businessbase.prg")      ADDITIVE
    SET PROCEDURE TO (gcCaminhoClasses + "formbase.prg")          ADDITIVE
    SET PROCEDURE TO (gcCaminhoClasses + "FormErro.prg")          ADDITIVE
    SET PROCEDURE TO (gcCaminhoClasses + "formbuscaauxiliar.prg") ADDITIVE
    SET PROCEDURE TO (gcCaminhoUtils   + "functions.prg")         ADDITIVE
    SET PROCEDURE TO (gcCaminhoUtils   + "messages.prg")          ADDITIVE
    SET PROCEDURE TO (gcCaminhoUtils   + "validators.prg")        ADDITIVE
    SET PROCEDURE TO (gcCaminhoClasses + "SigPrPpcBO.prg")        ADDITIVE
    SET PROCEDURE TO (gcCaminhoForms + "operacionais\FormSigPrPpc.prg") ADDITIVE

    gnConnHandle = -1

    *-- 1) instanciacao
    loc_oForm = CREATEOBJECT("FormSigPrPpc")
    STRTOFILE("1) CREATEOBJECT -> VARTYPE=" + VARTYPE(loc_oForm) + ;
              IIF(VARTYPE(loc_oForm) = "O", ;
                  " Width=" + TRANSFORM(loc_oForm.Width) + ;
                  " Height=" + TRANSFORM(loc_oForm.Height) + ;
                  " Caption=[" + loc_oForm.Caption + "]", ;
                  " *** NAO ABRIU ***") + CHR(13) + CHR(10), OUT, 1)
    IF VARTYPE(loc_oForm) != "O"
        STRTOFILE("PROBE_FALHAS=NAO_ABRIU" + CHR(13) + CHR(10), OUT, 1)
        QUIT
    ENDIF

    *-- 2) controles do legado (9 campos + 6 labels + commandgroup)
    LOCAL ARRAY loc_aCtrl[16]
    loc_aCtrl[1]  = "txt_4c_Grupo"
    loc_aCtrl[2]  = "txt_4c_DGrupo"
    loc_aCtrl[3]  = "txt_4c_Conta"
    loc_aCtrl[4]  = "txt_4c_ContaDesc"
    loc_aCtrl[5]  = "txt_4c_Operacao"
    loc_aCtrl[6]  = "txt_4c_DtIni"
    loc_aCtrl[7]  = "txt_4c_DtFin"
    loc_aCtrl[8]  = "txt_4c_Empresa"
    loc_aCtrl[9]  = "txt_4c_EmpresaDesc"
    loc_aCtrl[10] = "lbl_4c_LblGrupo"
    loc_aCtrl[11] = "lbl_4c_LblConta"
    loc_aCtrl[12] = "lbl_4c_LblOperacao"
    loc_aCtrl[13] = "lbl_4c_LblPeriodo"
    loc_aCtrl[14] = "lbl_4c_LblA"
    loc_aCtrl[15] = "lbl_4c_LblEmpresa"
    loc_aCtrl[16] = "cmg_4c_Operacao"
    loc_cL = "2) controles do legado:" + CHR(13) + CHR(10)
    loc_lTodos = .T.
    FOR loc_i = 1 TO 16
        loc_cN = loc_aCtrl[loc_i]
        loc_cL = loc_cL + "   " + PADR(loc_cN, 22) + "= " + TRANSFORM(PEMSTATUS(loc_oForm, loc_cN, 5)) + CHR(13) + CHR(10)
        IF !PEMSTATUS(loc_oForm, loc_cN, 5)
            loc_lTodos = .F.
        ENDIF
    ENDFOR
    IF !loc_lTodos
        loc_cL = loc_cL + "   *** FALHA: controle do legado ausente" + CHR(13) + CHR(10)
        loc_nFalhas = loc_nFalhas + 1
    ENDIF
    STRTOFILE(loc_cL, OUT, 1)

    *-- 3) os 7 lookups existem e sao PUBLIC (atributo 2 = Protected)
    LOCAL ARRAY loc_aLk[7]
    loc_aLk[1] = "AbrirBuscaGrupo"
    loc_aLk[2] = "AbrirBuscaGrupoPorDesc"
    loc_aLk[3] = "AbrirBuscaConta"
    loc_aLk[4] = "AbrirBuscaContaPorDesc"
    loc_aLk[5] = "AbrirBuscaOperacao"
    loc_aLk[6] = "AbrirBuscaEmpresa"
    loc_aLk[7] = "AbrirBuscaEmpresaPorDesc"
    loc_cL = "3) lookups (existe / Protected esperado .F.):" + CHR(13) + CHR(10)
    loc_lTodos = .T.
    FOR loc_i = 1 TO 7
        loc_cN = loc_aLk[loc_i]
        loc_cL = loc_cL + "   " + PADR(loc_cN, 26) + "existe=" + TRANSFORM(PEMSTATUS(loc_oForm, loc_cN, 5)) + ;
                 " Protected=" + TRANSFORM(PEMSTATUS(loc_oForm, loc_cN, 2)) + CHR(13) + CHR(10)
        IF !PEMSTATUS(loc_oForm, loc_cN, 5) OR PEMSTATUS(loc_oForm, loc_cN, 2)
            loc_lTodos = .F.
        ENDIF
    ENDFOR
    IF !loc_lTodos
        loc_cL = loc_cL + "   *** FALHA: lookup ausente ou PROTECTED" + CHR(13) + CHR(10)
        loc_nFalhas = loc_nFalhas + 1
    ENDIF
    STRTOFILE(loc_cL, OUT, 1)

    *-- 4) AtualizarDependenciaCampos reproduz os 3 PROCEDURE When do legado
    loc_cL = "4) gate dos When (AtualizarDependenciaCampos):" + CHR(13) + CHR(10) + ;
             "   existe=" + TRANSFORM(PEMSTATUS(loc_oForm, "AtualizarDependenciaCampos", 5)) + ;
             " Protected=" + TRANSFORM(PEMSTATUS(loc_oForm, "AtualizarDependenciaCampos", 2)) + ;
             " (esperado .T. / .F.)" + CHR(13) + CHR(10)
    IF !PEMSTATUS(loc_oForm, "AtualizarDependenciaCampos", 5) OR PEMSTATUS(loc_oForm, "AtualizarDependenciaCampos", 2)
        loc_cL = loc_cL + "   *** FALHA: metodo ausente ou PROTECTED" + CHR(13) + CHR(10)
        loc_nFalhas = loc_nFalhas + 1
    ENDIF

    *-- 4a) codigos VAZIOS -> When devolve .T. -> descricao ABERTA
    loc_oForm.txt_4c_Grupo.Value   = SPACE(10)
    loc_oForm.txt_4c_Conta.Value   = SPACE(10)
    loc_oForm.txt_4c_Empresa.Value = SPACE(3)
    loc_oForm.AtualizarDependenciaCampos()
    loc_cL = loc_cL + "   4a) codigo VAZIO (When=.T. -> descricao editavel):" + CHR(13) + CHR(10) + ;
        "       DGrupo      ReadOnly=" + TRANSFORM(loc_oForm.txt_4c_DGrupo.ReadOnly) + ;
                        " TabStop=" + TRANSFORM(loc_oForm.txt_4c_DGrupo.TabStop) + CHR(13) + CHR(10) + ;
        "       ContaDesc   ReadOnly=" + TRANSFORM(loc_oForm.txt_4c_ContaDesc.ReadOnly) + ;
                        " TabStop=" + TRANSFORM(loc_oForm.txt_4c_ContaDesc.TabStop) + CHR(13) + CHR(10) + ;
        "       EmpresaDesc ReadOnly=" + TRANSFORM(loc_oForm.txt_4c_EmpresaDesc.ReadOnly) + ;
                        " TabStop=" + TRANSFORM(loc_oForm.txt_4c_EmpresaDesc.TabStop) + CHR(13) + CHR(10)
    IF loc_oForm.txt_4c_DGrupo.ReadOnly OR loc_oForm.txt_4c_ContaDesc.ReadOnly ;
       OR loc_oForm.txt_4c_EmpresaDesc.ReadOnly ;
       OR !loc_oForm.txt_4c_DGrupo.TabStop OR !loc_oForm.txt_4c_ContaDesc.TabStop ;
       OR !loc_oForm.txt_4c_EmpresaDesc.TabStop
        loc_cL = loc_cL + "       *** FALHA: descricao travada com codigo vazio" + CHR(13) + CHR(10)
        loc_nFalhas = loc_nFalhas + 1
    ENDIF

    *-- 4b) codigos PREENCHIDOS -> When devolve .F. -> descricao FECHADA
    loc_oForm.txt_4c_Grupo.Value   = "0001"
    loc_oForm.txt_4c_Conta.Value   = "1101"
    loc_oForm.txt_4c_Empresa.Value = "001"
    loc_oForm.AtualizarDependenciaCampos()
    loc_cL = loc_cL + "   4b) codigo PREENCHIDO (When=.F. -> descricao recusa foco):" + CHR(13) + CHR(10) + ;
        "       DGrupo      ReadOnly=" + TRANSFORM(loc_oForm.txt_4c_DGrupo.ReadOnly) + ;
                        " TabStop=" + TRANSFORM(loc_oForm.txt_4c_DGrupo.TabStop) + CHR(13) + CHR(10) + ;
        "       ContaDesc   ReadOnly=" + TRANSFORM(loc_oForm.txt_4c_ContaDesc.ReadOnly) + ;
                        " TabStop=" + TRANSFORM(loc_oForm.txt_4c_ContaDesc.TabStop) + CHR(13) + CHR(10) + ;
        "       EmpresaDesc ReadOnly=" + TRANSFORM(loc_oForm.txt_4c_EmpresaDesc.ReadOnly) + ;
                        " TabStop=" + TRANSFORM(loc_oForm.txt_4c_EmpresaDesc.TabStop) + CHR(13) + CHR(10)
    IF !loc_oForm.txt_4c_DGrupo.ReadOnly OR !loc_oForm.txt_4c_ContaDesc.ReadOnly ;
       OR !loc_oForm.txt_4c_EmpresaDesc.ReadOnly ;
       OR loc_oForm.txt_4c_DGrupo.TabStop OR loc_oForm.txt_4c_ContaDesc.TabStop ;
       OR loc_oForm.txt_4c_EmpresaDesc.TabStop
        loc_cL = loc_cL + "       *** FALHA: descricao aberta com codigo preenchido" + CHR(13) + CHR(10)
        loc_nFalhas = loc_nFalhas + 1
    ENDIF
    STRTOFILE(loc_cL, OUT, 1)

    *-- 5) a guarda this_lEmLookup BLOQUEIA reentrancia
    *    Medicao: campo de codigo VAZIO faz o lookup zerar o par codigo+descricao.
    *    Com a guarda LIGADA o handler tem de devolver ANTES disso, deixando a
    *    sentinela intacta na descricao.
    loc_cL = "5) guarda de reentrancia this_lEmLookup:" + CHR(13) + CHR(10) + ;
             "   existe=" + TRANSFORM(PEMSTATUS(loc_oForm, "this_lEmLookup", 5)) + CHR(13) + CHR(10)
    IF !PEMSTATUS(loc_oForm, "this_lEmLookup", 5)
        loc_cL = loc_cL + "   *** FALHA: property ausente" + CHR(13) + CHR(10)
        loc_nFalhas = loc_nFalhas + 1
    ENDIF
    loc_oForm.txt_4c_Grupo.Value  = ""
    loc_oForm.txt_4c_DGrupo.Value = "SENTINELA"
    loc_oForm.this_lEmLookup      = .T.
    loc_oForm.TxtGrupoKeyPress(13, 0)
    loc_cL = loc_cL + "   guarda LIGADA  -> DGrupo=[" + ALLTRIM(loc_oForm.txt_4c_DGrupo.Value) + ;
             "] esperado [SENTINELA] (handler devolveu sem agir)" + CHR(13) + CHR(10)
    IF ALLTRIM(loc_oForm.txt_4c_DGrupo.Value) != "SENTINELA"
        loc_cL = loc_cL + "   *** FALHA: guarda nao bloqueou" + CHR(13) + CHR(10)
        loc_nFalhas = loc_nFalhas + 1
    ENDIF
    loc_oForm.this_lEmLookup = .F.
    loc_oForm.TxtGrupoKeyPress(13, 0)
    loc_cL = loc_cL + "   guarda SOLTA   -> DGrupo=[" + ALLTRIM(loc_oForm.txt_4c_DGrupo.Value) + ;
             "] esperado [] (ramo vazio do legado zera o par)" + CHR(13) + CHR(10) + ;
             "   this_lEmLookup apos a chamada=" + TRANSFORM(loc_oForm.this_lEmLookup) + ;
             " esperado .F. (nao travou ligada)" + CHR(13) + CHR(10)
    IF !EMPTY(ALLTRIM(loc_oForm.txt_4c_DGrupo.Value)) OR loc_oForm.this_lEmLookup
        loc_cL = loc_cL + "   *** FALHA: lookup nao agiu ou flag travou ligada" + CHR(13) + CHR(10)
        loc_nFalhas = loc_nFalhas + 1
    ENDIF
    STRTOFILE(loc_cL, OUT, 1)

    *-- 6) o caminho de VOLTA reabre as descricoes
    *    Entrada EXTERNA real: BtnCancelarClick (LimparCampos eh PROTECTED na
    *    FormBase e o harness nunca o chama de fora - regra #51).
    loc_oForm.txt_4c_Conta.Value = "1101"
    loc_oForm.AtualizarDependenciaCampos()
    loc_oForm.BtnCancelarClick()
    loc_cL = "6) BtnCancelarClick reabre a descricao:" + CHR(13) + CHR(10) + ;
             "   ContaDesc ReadOnly=" + TRANSFORM(loc_oForm.txt_4c_ContaDesc.ReadOnly) + ;
             " TabStop=" + TRANSFORM(loc_oForm.txt_4c_ContaDesc.TabStop) + ;
             " esperado .F./.T." + CHR(13) + CHR(10)
    IF loc_oForm.txt_4c_ContaDesc.ReadOnly OR !loc_oForm.txt_4c_ContaDesc.TabStop
        loc_cL = loc_cL + "   *** FALHA: descricao ficou travada apos limpar" + CHR(13) + CHR(10)
        loc_nFalhas = loc_nFalhas + 1
    ENDIF
    STRTOFILE(loc_cL, OUT, 1)

    *-- 7) TabIndex e MaxLength transcritos do SCX
    *    O VFP9 COMPACTA o TabIndex para uma sequencia contigua entre os
    *    controles focalizaveis - os valores do SCX (3/4/6/7/9/11/13/15/16/17,
    *    com lacunas que pertencem aos Labels) saem renumerados. O invariante
    *    que importa, e que o proprio AplicarTabIndex documenta, eh a ordem
    *    RELATIVA: Grupo < DGrupo < Conta < ContaDesc < Operacao < DtIni <
    *    DtFin < Empresa < EmpresaDesc < CommandGroup.
    LOCAL ARRAY loc_aTab[10]
    loc_aTab[1]  = loc_oForm.txt_4c_Grupo.TabIndex
    loc_aTab[2]  = loc_oForm.txt_4c_DGrupo.TabIndex
    loc_aTab[3]  = loc_oForm.txt_4c_Conta.TabIndex
    loc_aTab[4]  = loc_oForm.txt_4c_ContaDesc.TabIndex
    loc_aTab[5]  = loc_oForm.txt_4c_Operacao.TabIndex
    loc_aTab[6]  = loc_oForm.txt_4c_DtIni.TabIndex
    loc_aTab[7]  = loc_oForm.txt_4c_DtFin.TabIndex
    loc_aTab[8]  = loc_oForm.txt_4c_Empresa.TabIndex
    loc_aTab[9]  = loc_oForm.txt_4c_EmpresaDesc.TabIndex
    loc_aTab[10] = loc_oForm.cmg_4c_Operacao.TabIndex
    loc_cL = "7) transcricao do SCX:" + CHR(13) + CHR(10) + ;
             "   TabIndex na ordem do legado = "
    loc_lTodos = .T.
    FOR loc_i = 1 TO 10
        loc_cL = loc_cL + TRANSFORM(loc_aTab[loc_i]) + IIF(loc_i < 10, "/", "")
        IF loc_i > 1 AND loc_aTab[loc_i] <= loc_aTab[loc_i - 1]
            loc_lTodos = .F.
        ENDIF
    ENDFOR
    loc_cL = loc_cL + CHR(13) + CHR(10) + ;
             "   estritamente CRESCENTE (ordem do SCX preservada) = " + TRANSFORM(loc_lTodos) + CHR(13) + CHR(10) + ;
             "   MaxLength DGrupo=" + TRANSFORM(loc_oForm.txt_4c_DGrupo.MaxLength) + " esperado 20 (SCX)" + CHR(13) + CHR(10) + ;
             "   MaxLength Empresa=" + TRANSFORM(loc_oForm.txt_4c_Empresa.MaxLength) + " esperado 3 (SigCdEmp.cemps char(3))" + CHR(13) + CHR(10)
    IF !loc_lTodos OR loc_oForm.txt_4c_DGrupo.MaxLength != 20 OR loc_oForm.txt_4c_Empresa.MaxLength != 3
        loc_cL = loc_cL + "   *** FALHA: transcricao do SCX divergiu" + CHR(13) + CHR(10)
        loc_nFalhas = loc_nFalhas + 1
    ENDIF
    STRTOFILE(loc_cL, OUT, 1)

    *-- 8) contrato do TesteAutomatico.prg: o harness chama estes membros de
    *    FORA da classe, entao nenhum deles pode ser PROTECTED (CLAUDE.md #3)
    LOCAL ARRAY loc_aHar[6]
    loc_aHar[1] = "CarregarLista"
    loc_aHar[2] = "AlternarPagina"
    loc_aHar[3] = "AjustarBotoesPorModo"
    loc_aHar[4] = "BtnIncluirClick"
    loc_aHar[5] = "BtnCancelarClick"
    loc_aHar[6] = "this_cModoAtual"
    loc_cL = "8) contrato do harness (existe / Protected esperado .F.):" + CHR(13) + CHR(10)
    loc_lTodos = .T.
    FOR loc_i = 1 TO 6
        loc_cN = loc_aHar[loc_i]
        loc_cL = loc_cL + "   " + PADR(loc_cN, 22) + "existe=" + TRANSFORM(PEMSTATUS(loc_oForm, loc_cN, 5)) + ;
                 " Protected=" + TRANSFORM(PEMSTATUS(loc_oForm, loc_cN, 2)) + CHR(13) + CHR(10)
        IF !PEMSTATUS(loc_oForm, loc_cN, 5) OR PEMSTATUS(loc_oForm, loc_cN, 2)
            loc_lTodos = .F.
        ENDIF
    ENDFOR
    IF !loc_lTodos
        loc_cL = loc_cL + "   *** FALHA: membro do harness ausente ou PROTECTED" + CHR(13) + CHR(10)
        loc_nFalhas = loc_nFalhas + 1
    ENDIF
    STRTOFILE(loc_cL, OUT, 1)

    STRTOFILE(CHR(13) + CHR(10) + IIF(loc_nFalhas = 0, "PROBE_OK", ;
        "PROBE_FALHAS=" + TRANSFORM(loc_nFalhas)) + CHR(13) + CHR(10), OUT, 1)
CATCH TO loc_oE
    STRTOFILE("*** EXCECAO: " + loc_oE.Message + " | Linha " + TRANSFORM(loc_oE.LineNo) + ;
              " | Proc " + loc_oE.Procedure + CHR(13) + CHR(10) + "PROBE_FALHAS=EXCECAO" + ;
              CHR(13) + CHR(10), OUT, 1)
ENDTRY

QUIT

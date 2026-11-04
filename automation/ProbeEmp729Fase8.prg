*==============================================================================
* ProbeEmp729Fase8.prg - Probe da Fase 8 de FormSigOpEmp (task729)
*
* Prova, MEDINDO em VFP9 (nao lendo o codigo):
*   1) o form INSTANCIA com gb_4c_ValidandoUI = .T. E a visual EH montada
*      (defeito B: o bypass antigo tinha RETURN no TOPO de InicializarForm e
*      pulava THIS.Picture e todos os AddObject)
*   2) a ORDEM DE TABULACAO reproduz a ordem EFETIVA do legado
*      (defeito C: sem o passe, Encerrar vinha ANTES da grade)
*   3) a grade existe com as 7 colunas/headers/larguras do dump
*   4) os dois visores sao somente-leitura e FORA do ciclo do Tab
*   5) escopo dos metodos chamados de FORA da classe (CLAUDE.md #3/#51)
*   6) o form instancia tambem com ValidandoUI = .F. (caminho do CarregarLista
*      sem conexao, gnConnHandle = -1)
*
* NAO chama Show(): em producao o form eh modal e Show() BLOQUEARIA o harness.
*==============================================================================
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
PUBLIC gb_4c_ModoTeste, gc_4c_ArquivoErroTeste, gnConnHandle, gc_4c_UsuarioLogado, gb_4c_ValidandoUI
gb_4c_ModoTeste = .T.
gc_4c_ArquivoErroTeste = "C:\4c\automation\vfp_err_emp729.txt"
#DEFINE OUT "C:\4c\automation\probe_emp729_f8.txt"

LOCAL loc_oForm, loc_nFalhas, loc_oE, loc_oG, loc_i, loc_cM, loc_lProt
LOCAL loc_cNome, loc_nTab, loc_nEsp
LOCAL ARRAY loc_aNome[5], loc_aTab[5]
loc_nFalhas = 0

STRTOFILE("=== PROBE Fase 8 - FormSigOpEmp (Empenho) ===" + CHR(13) + CHR(10), OUT)

TRY
    CD C:\4c\projeto\app\start
    DO config.prg
    gc_4c_UsuarioLogado = "TESTE"
    gb_4c_ModoTeste     = .T.
    gb_4c_ValidandoUI   = .T.
    SET PATH TO (gcCaminhoBase + "," + gcCaminhoClasses + "," + gcCaminhoUtils + "," + gcCaminhoForms + "," + gcCaminhoIcones)
    SET PROCEDURE TO (gcCaminhoClasses + "dataaccess.prg")   ADDITIVE
    SET PROCEDURE TO (gcCaminhoClasses + "businessbase.prg") ADDITIVE
    SET PROCEDURE TO (gcCaminhoClasses + "formbase.prg")     ADDITIVE
    SET PROCEDURE TO (gcCaminhoClasses + "FormErro.prg")     ADDITIVE
    SET PROCEDURE TO (gcCaminhoUtils   + "functions.prg")    ADDITIVE
    SET PROCEDURE TO (gcCaminhoUtils   + "messages.prg")     ADDITIVE
    SET PROCEDURE TO (gcCaminhoUtils   + "validators.prg")   ADDITIVE
    SET PROCEDURE TO (gcCaminhoClasses + "SigOpEmpBO.prg")   ADDITIVE
    SET PROCEDURE TO (gcCaminhoForms + "operacionais\FormSigOpEmp.prg") ADDITIVE

    gnConnHandle = -1

    *-- Ordem de tabulacao EFETIVA do legado (medida em medir_tabindex_729.prg)
    loc_aNome[1] = "cnt_4c_Sombra"
    loc_aNome[2] = "grd_4c_Dados"
    loc_aNome[3] = "cmd_4c_Ok"
    loc_aNome[4] = "txt_4c__NGrupo"
    loc_aNome[5] = "txt_4c_NConta"
    loc_aTab[1] = 1
    loc_aTab[2] = 2
    loc_aTab[3] = 3
    loc_aTab[4] = 4
    loc_aTab[5] = 5

    *-- 1) instanciacao com ValidandoUI = .T. (etapa de UI Fidelity)
    loc_oForm = CREATEOBJECT("FormSigOpEmp")
    STRTOFILE("1) CREATEOBJECT (ValidandoUI=.T.) -> VARTYPE=" + VARTYPE(loc_oForm) + CHR(13) + CHR(10), OUT, 1)
    IF VARTYPE(loc_oForm) != "O"
        loc_nFalhas = loc_nFalhas + 1
        STRTOFILE("   FALHA: form nao instanciou" + CHR(13) + CHR(10), OUT, 1)
    ELSE
        STRTOFILE("   ControlCount=" + TRANSFORM(loc_oForm.ControlCount) + ;
            "  Picture=[" + loc_oForm.Picture + "]" + ;
            "  Caption=[" + loc_oForm.Caption + "]" + CHR(13) + CHR(10), OUT, 1)
        IF loc_oForm.ControlCount = 0
            loc_nFalhas = loc_nFalhas + 1
            STRTOFILE("   FALHA(defeito B): visual NAO montada sob ValidandoUI" + CHR(13) + CHR(10), OUT, 1)
        ENDIF
        IF EMPTY(loc_oForm.Picture)
            loc_nFalhas = loc_nFalhas + 1
            STRTOFILE("   FALHA(defeito B): THIS.Picture vazio sob ValidandoUI" + CHR(13) + CHR(10), OUT, 1)
        ENDIF

        *-- 2) ordem de tabulacao: ordinais EFETIVOS do legado
        STRTOFILE("2) TabIndex lido de volta:" + CHR(13) + CHR(10), OUT, 1)
        FOR loc_i = 1 TO 5
            loc_cNome = loc_aNome[loc_i]
            loc_nEsp  = loc_aTab[loc_i]
            IF !PEMSTATUS(loc_oForm, loc_cNome, 5)
                loc_nFalhas = loc_nFalhas + 1
                STRTOFILE("   FALHA: controle ausente " + loc_cNome + CHR(13) + CHR(10), OUT, 1)
                LOOP
            ENDIF
            loc_nTab = EVALUATE("loc_oForm." + loc_cNome + ".TabIndex")
            STRTOFILE("   " + PADR(loc_cNome, 16) + " = " + TRANSFORM(loc_nTab) + ;
                "  (esperado " + TRANSFORM(loc_nEsp) + ")" + ;
                IIF(loc_nTab = loc_nEsp, " OK", " *** DIVERGE ***") + CHR(13) + CHR(10), OUT, 1)
            IF loc_nTab != loc_nEsp
                loc_nFalhas = loc_nFalhas + 1
            ENDIF
        ENDFOR
        STRTOFILE("   Shape tem TabIndex? " + ;
            IIF(PEMSTATUS(loc_oForm.shp_4c_Shape1, "TabIndex", 5), "SIM", "NAO (fora do passe)") + CHR(13) + CHR(10), OUT, 1)

        *-- 3) grade
        loc_oG = loc_oForm.grd_4c_Dados
        STRTOFILE("3) grade: ColumnCount=" + TRANSFORM(loc_oG.ColumnCount) + ;
            " RecordSource=[" + loc_oG.RecordSource + "]" + ;
            " USED(cursor_4c_Empenhado)=" + TRANSFORM(USED("cursor_4c_Empenhado")) + ;
            " ReadOnly=" + TRANSFORM(loc_oG.ReadOnly) + ;
            " RecordMark=" + TRANSFORM(loc_oG.RecordMark) + ;
            " DeleteMark=" + TRANSFORM(loc_oG.DeleteMark) + CHR(13) + CHR(10), OUT, 1)
        IF loc_oG.ColumnCount != 7
            loc_nFalhas = loc_nFalhas + 1
            STRTOFILE("   FALHA: ColumnCount != 7" + CHR(13) + CHR(10), OUT, 1)
        ENDIF
        FOR loc_i = 1 TO loc_oG.ColumnCount
            STRTOFILE("   Col" + TRANSFORM(loc_i) + ;
                " hdr=[" + EVALUATE("loc_oG.Column" + TRANSFORM(loc_i) + ".Header1.Caption") + "]" + ;
                " W=" + TRANSFORM(EVALUATE("loc_oG.Column" + TRANSFORM(loc_i) + ".Width")) + ;
                " CS=[" + EVALUATE("loc_oG.Column" + TRANSFORM(loc_i) + ".ControlSource") + "]" + ;
                " RO=" + TRANSFORM(EVALUATE("loc_oG.Column" + TRANSFORM(loc_i) + ".ReadOnly")) + ;
                " Font=[" + EVALUATE("loc_oG.Column" + TRANSFORM(loc_i) + ".FontName") + "]" + CHR(13) + CHR(10), OUT, 1)
        ENDFOR

        *-- 4) visores somente-leitura e fora do ciclo do Tab
        STRTOFILE("4) visores: NGrupo ReadOnly=" + TRANSFORM(loc_oForm.txt_4c__NGrupo.ReadOnly) + ;
            " TabStop=" + TRANSFORM(loc_oForm.txt_4c__NGrupo.TabStop) + ;
            " | NConta ReadOnly=" + TRANSFORM(loc_oForm.txt_4c_NConta.ReadOnly) + ;
            " TabStop=" + TRANSFORM(loc_oForm.txt_4c_NConta.TabStop) + CHR(13) + CHR(10), OUT, 1)
        IF !loc_oForm.txt_4c__NGrupo.ReadOnly OR loc_oForm.txt_4c__NGrupo.TabStop ;
                OR !loc_oForm.txt_4c_NConta.ReadOnly OR loc_oForm.txt_4c_NConta.TabStop
            loc_nFalhas = loc_nFalhas + 1
            STRTOFILE("   FALHA: visor editavel ou dentro do ciclo do Tab" + CHR(13) + CHR(10), OUT, 1)
        ENDIF

        *-- 5) escopos: o que o harness/BINDEVENT chama de FORA tem de ser PUBLIC
        STRTOFILE("5) escopos (2 = PROTECTED):" + CHR(13) + CHR(10), OUT, 1)
        FOR loc_i = 1 TO 4
            loc_cM = ICASE(loc_i = 1, "CarregarLista", loc_i = 2, "CmdOkClick", ;
                           loc_i = 3, "GradeAfterRowColChange", "ConfigurarOrdemTabulacao")
            loc_lProt = PEMSTATUS(loc_oForm, loc_cM, 2)
            STRTOFILE("   " + PADR(loc_cM, 26) + " PROTECTED=" + TRANSFORM(loc_lProt) + CHR(13) + CHR(10), OUT, 1)
            IF loc_i <= 3 AND loc_lProt
                loc_nFalhas = loc_nFalhas + 1
                STRTOFILE("      FALHA: deveria ser PUBLIC" + CHR(13) + CHR(10), OUT, 1)
            ENDIF
        ENDFOR

        *-- 6) o handler da grade roda sem conexao (nao deve estourar)
        loc_oForm.GradeAfterRowColChange(1)
        STRTOFILE("6) GradeAfterRowColChange(1) executou; NGrupo=[" + ;
            loc_oForm.txt_4c__NGrupo.Value + "] NConta=[" + ;
            loc_oForm.txt_4c_NConta.Value + "]" + CHR(13) + CHR(10), OUT, 1)

        loc_oForm.Release()
        loc_oForm = .NULL.
    ENDIF

    *-- 7) instanciacao com ValidandoUI = .F. (caminho do CarregarLista)
    gb_4c_ValidandoUI = .F.
    loc_oForm = CREATEOBJECT("FormSigOpEmp")
    STRTOFILE("7) CREATEOBJECT (ValidandoUI=.F.) -> VARTYPE=" + VARTYPE(loc_oForm) + CHR(13) + CHR(10), OUT, 1)
    IF VARTYPE(loc_oForm) != "O"
        loc_nFalhas = loc_nFalhas + 1
        STRTOFILE("   FALHA: form nao instanciou sem ValidandoUI" + CHR(13) + CHR(10), OUT, 1)
    ELSE
        STRTOFILE("   ControlCount=" + TRANSFORM(loc_oForm.ControlCount) + ;
            "  grade TabIndex=" + TRANSFORM(loc_oForm.grd_4c_Dados.TabIndex) + ;
            "  Ok TabIndex=" + TRANSFORM(loc_oForm.cmd_4c_Ok.TabIndex) + CHR(13) + CHR(10), OUT, 1)
        loc_oForm.Release()
        loc_oForm = .NULL.
    ENDIF

CATCH TO loc_oE
    loc_nFalhas = loc_nFalhas + 1
    STRTOFILE("EXCECAO: " + loc_oE.Message + ;
        " | Linha " + TRANSFORM(loc_oE.LineNo) + ;
        " | Proc " + loc_oE.Procedure + CHR(13) + CHR(10), OUT, 1)
ENDTRY

STRTOFILE(CHR(13) + CHR(10) + "RESULTADO: " + ;
    IIF(loc_nFalhas = 0, "PROBE_OK (0 falhas)", "FALHAS=" + TRANSFORM(loc_nFalhas)) + ;
    CHR(13) + CHR(10), OUT, 1)
QUIT

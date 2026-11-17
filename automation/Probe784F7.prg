SET SAFETY OFF
SET RESOURCE OFF
PUBLIC gcOut, gcRes
gcOut = "C:\4c\automation\probe784f7.txt"
gcRes = ""

PUBLIC gnConnHandle, gb_4c_ModoTeste, gc_4c_ArquivoErroTeste
gnConnHandle           = 0
gb_4c_ModoTeste        = .T.
gc_4c_ArquivoErroTeste = "C:\4c\automation\probe784f7_dialogs.txt"

DO L WITH "0 - inicio"

CD C:\4c\projeto\app\start
DO config.prg
DO L WITH "1 - config.prg OK"

SET PATH TO (gcCaminhoBase + "," + gcCaminhoClasses + "," + gcCaminhoUtils + "," + gcCaminhoForms + "," + gcCaminhoIcones)
SET PROCEDURE TO (gcCaminhoClasses + "dataaccess.prg")   ADDITIVE
SET PROCEDURE TO (gcCaminhoClasses + "businessbase.prg") ADDITIVE
SET PROCEDURE TO (gcCaminhoClasses + "formbase.prg")     ADDITIVE
SET PROCEDURE TO (gcCaminhoClasses + "gridbase.prg")     ADDITIVE
SET PROCEDURE TO (gcCaminhoClasses + "FormErro.prg")     ADDITIVE
SET PROCEDURE TO (gcCaminhoUtils   + "functions.prg")    ADDITIVE
SET PROCEDURE TO (gcCaminhoUtils   + "messages.prg")     ADDITIVE
SET PROCEDURE TO (gcCaminhoUtils   + "validators.prg")   ADDITIVE
SET PROCEDURE TO (gcCaminhoClasses + "SigOpPdtBO.prg")   ADDITIVE
SET PROCEDURE TO (gcCaminhoForms + "operacionais\FormSigOpPdt.prg") ADDITIVE
DO L WITH "2 - dependencias carregadas"

LOCAL loc_oForm
loc_oForm = CREATEOBJECT("FormSigOpPdt")
DO L WITH "3 - CREATEOBJECT VARTYPE=[" + VARTYPE(loc_oForm) + "]"

IF VARTYPE(loc_oForm) != "O"
    DO L WITH "ABORT: form nao instanciou"
    QUIT
ENDIF

DO L WITH "4 - Caption=[" + loc_oForm.Caption + "] DataSessionId=[" + TRANSFORM(loc_oForm.DataSessionId) + "]"

*-- entrar na sessao privada do form para ver os cursores dele
SET DATASESSION TO loc_oForm.DataSessionId
DO L WITH "5 - datasession do form"

DO Dump WITH loc_oForm, "APOS INIT"

*-- ===== simular a RECARGA DESTRUTIVA que o BO faz (USE IN + CREATE CURSOR)
LOCAL loc_cAlias
loc_cAlias = ALLTRIM(loc_oForm.this_oBusinessObject.this_cCursorPendentes)
DO L WITH "6 - alias da grade=[" + loc_cAlias + "] USED=[" + TRANSFORM(USED(loc_cAlias)) + "]"

IF USED(loc_cAlias)
    USE IN (loc_cAlias)
ENDIF
DO L WITH "7 - alias FECHADO (simula CarregarPendencias)"
DO Dump WITH loc_oForm, "APOS FECHAR O ALIAS (antes de recarregar)"

loc_oForm.CarregarLista()
DO L WITH "8 - CarregarLista() executado"
DO Dump WITH loc_oForm, "APOS CarregarLista (rebind)"

*-- ===== gate de modo: o When do checkbox
loc_oForm.this_cOpEscolha = "ALTERAR"
loc_oForm.AjustarBotoesPorModo()
DO L WITH "9 - modo ALTERAR: Column1.ReadOnly=[" + TRANSFORM(loc_oForm.grd_4c_Dados.Column1.ReadOnly) + "] Check1.ReadOnly=[" + TRANSFORM(loc_oForm.grd_4c_Dados.Column1.Check1.ReadOnly) + "]"

loc_oForm.this_cOpEscolha = "INSERIR"
loc_oForm.AjustarBotoesPorModo()
DO L WITH "10 - modo INSERIR: Column1.ReadOnly=[" + TRANSFORM(loc_oForm.grd_4c_Dados.Column1.ReadOnly) + "] Check1.ReadOnly=[" + TRANSFORM(loc_oForm.grd_4c_Dados.Column1.Check1.ReadOnly) + "]"

*-- ===== handlers chamaveis de fora (BINDEVENT exige PUBLIC)
DO L WITH "11 - PEMSTATUS handlers: GradeSelecaoInteractiveChange=[" + ;
    TRANSFORM(PEMSTATUS(loc_oForm, "GradeSelecaoInteractiveChange", 5)) + "] GradeColunaGotFocus=[" + ;
    TRANSFORM(PEMSTATUS(loc_oForm, "GradeColunaGotFocus", 5)) + "]"
DO L WITH "11b - PROTECTED? GradeSelecaoInteractiveChange=[" + ;
    TRANSFORM(PEMSTATUS(loc_oForm, "GradeSelecaoInteractiveChange", 2)) + "] GradeColunaGotFocus=[" + ;
    TRANSFORM(PEMSTATUS(loc_oForm, "GradeColunaGotFocus", 2)) + "]"

*-- ===== toggle: cursor vazio nao deve estourar nem travar
loc_oForm.GradeSelecaoInteractiveChange()
DO L WITH "12 - GradeSelecaoInteractiveChange com grade VAZIA: nao estourou; flag=[" + TRANSFORM(loc_oForm.this_lEmToggleSelecao) + "]"

*-- ===== toggle com UMA linha, modo INSERIR, sem crSigMvCab (BO recusa)
INSERT INTO (loc_cAlias) (Flag, Emps, Dopes, Numes, MascNum, Datas, TpFats, Origem, Destino, Valos) ;
    VALUES (.F., "001", "MALOTE", 3, "000003", DATETIME(), "001", "ORIG", "DEST", 100.00)
SELECT (loc_cAlias)
GO TOP
DO L WITH "13 - 1 linha inserida; RECCOUNT=[" + TRANSFORM(RECCOUNT(loc_cAlias)) + "]"

*-- simula o toggle NATIVO (usuario marcou) e dispara o handler
REPLACE Flag WITH .T. IN (loc_cAlias)
loc_oForm.grd_4c_Dados.Column1.Check1.Value = .T.
loc_oForm.GradeSelecaoInteractiveChange()
SELECT (loc_cAlias)
GO TOP
DO L WITH "14 - apos toggle MARCAR (sem crSigMvCab, BO deve RECUSAR): Flag=[" + TRANSFORM(EVALUATE(loc_cAlias + ".Flag")) + "] (esperado .F. = revertido) flag reentr=[" + TRANSFORM(loc_oForm.this_lEmToggleSelecao) + "]"

*-- toggle DESMARCAR
REPLACE Flag WITH .F. IN (loc_cAlias)
loc_oForm.grd_4c_Dados.Column1.Check1.Value = .F.
loc_oForm.GradeSelecaoInteractiveChange()
DO L WITH "15 - apos toggle DESMARCAR: nao estourou; flag reentr=[" + TRANSFORM(loc_oForm.this_lEmToggleSelecao) + "]"

*-- ===== gate de modo bloqueia a gravacao?
loc_oForm.this_cOpEscolha = "ALTERAR"
SELECT (loc_cAlias)
GO TOP
REPLACE Flag WITH .T. IN (loc_cAlias)
loc_oForm.grd_4c_Dados.Column1.Check1.Value = .T.
loc_oForm.GradeSelecaoInteractiveChange()
SELECT (loc_cAlias)
GO TOP
DO L WITH "16 - modo ALTERAR: Flag=[" + TRANSFORM(EVALUATE(loc_cAlias + ".Flag")) + "] (esperado .T. = handler NAO mexeu, gate recusou)"
loc_oForm.this_cOpEscolha = "INSERIR"

*-- ===== GotFocus redirect nao estoura nem entra em cascata
loc_oForm.GradeColunaGotFocus()
DO L WITH "17 - GradeColunaGotFocus: nao estourou; flag foco=[" + TRANSFORM(loc_oForm.this_lEmFocoGrade) + "]"

*-- ===== botoes do legado continuam funcionando
loc_oForm.BtnSelTudoClick()
DO L WITH "18 - BtnSelTudoClick: nao estourou"
loc_oForm.BtnApagaClick()
DO L WITH "19 - BtnApagaClick: nao estourou"

SET DATASESSION TO 1
DO L WITH "FIM OK"
QUIT

PROCEDURE Dump
    LPARAMETERS par_oForm, par_cTag
    LOCAL loc_oG, loc_n, loc_i, loc_c
    LOCAL ARRAY laE[1,5]
    loc_oG = par_oForm.grd_4c_Dados
    loc_c = "   >> " + par_cTag + CHR(13) + CHR(10)
    loc_c = loc_c + "      ColumnCount=[" + TRANSFORM(loc_oG.ColumnCount) + "]" + CHR(13) + CHR(10)
    IF loc_oG.ColumnCount >= 1
        loc_c = loc_c + "      Col1.CurrentControl=[" + loc_oG.Column1.CurrentControl + "]" + CHR(13) + CHR(10)
        loc_c = loc_c + "      Col1.Check1 existe=[" + TRANSFORM(PEMSTATUS(loc_oG.Column1, "Check1", 5)) + "]" + CHR(13) + CHR(10)
        IF PEMSTATUS(loc_oG.Column1, "Check1", 5)
            loc_n = AEVENTS(laE, loc_oG.Column1.Check1)
            loc_c = loc_c + "      AEVENTS Col1.Check1=[" + TRANSFORM(loc_n) + "]"
            FOR loc_i = 1 TO loc_n
                loc_c = loc_c + " {" + TRANSFORM(laE[loc_i,3]) + "->" + TRANSFORM(laE[loc_i,4]) + "}"
            ENDFOR
            loc_c = loc_c + CHR(13) + CHR(10)
        ENDIF
    ENDIF
    IF loc_oG.ColumnCount >= 8
        loc_c = loc_c + "      Header1 capts: "
        FOR loc_i = 1 TO 8
            loc_c = loc_c + "[" + EVALUATE("loc_oG.Column" + TRANSFORM(loc_i) + ".Header1.Caption") + "]"
        ENDFOR
        loc_c = loc_c + CHR(13) + CHR(10)
        loc_c = loc_c + "      GotFocus bind por coluna: "
        FOR loc_i = 2 TO 8
            loc_n = AEVENTS(laE, EVALUATE("loc_oG.Column" + TRANSFORM(loc_i) + ".Text1"))
            loc_c = loc_c + "C" + TRANSFORM(loc_i) + "=" + TRANSFORM(loc_n) + " "
        ENDFOR
        loc_c = loc_c + CHR(13) + CHR(10)
    ENDIF
    gcRes = gcRes + loc_c
    STRTOFILE(gcRes, gcOut)
ENDPROC

PROCEDURE L
    LPARAMETERS par_c
    gcRes = gcRes + par_c + CHR(13) + CHR(10)
    STRTOFILE(gcRes, gcOut)
ENDPROC

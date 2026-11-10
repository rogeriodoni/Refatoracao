*-- ProbeF4SigOpLop764.prg
*-- Instancia FormSigOpLop (Fase 4) carregando SO as dependencias dele, sem o
*-- ConfigurarAmbiente() completo (que BLOQUEIA nesta maquina).
*-- Prova:
*--   (1) o caminho do harness (CREATEOBJECT sem argumento nenhum);
*--   (2) o caminho real (form PAI + cursor LocalSacOp aberto na sessao
*--       corrente, que eh o contrato DataSession = 1), conferindo a grade
*--       (ColumnCount/RecordSource/ControlSource/CurrentControl/Sparse/Width/
*--       Header), o botao Ok, a ALTERNANCIA de fato gravando no cursor, o
*--       escopo PUBLIC dos handlers de BINDEVENT e o Ok devolvendo o Enabled
*--       ao pai;
*--   (3) que o CheckBox da Column1 VOLTA depois de o alias da grade ser
*--       fechado - o defeito medido em 2026-11-08 (perda PARCIAL).
*-- Regra #1 do CLAUDE.md vale para este script: nenhum RETURN dentro de
*-- TRY/CATCH - as funcoes acumulam o texto em loc_cOut e devolvem no fim.
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF

PUBLIC gb_4c_ModoTeste, gc_4c_ArquivoErroTeste, gnConnHandle
gb_4c_ModoTeste        = .T.
gnConnHandle           = 0
gc_4c_ArquivoErroTeste = "C:\4c\automation\vfp_err_f4lop.txt"
IF FILE(gc_4c_ArquivoErroTeste)
    DELETE FILE (gc_4c_ArquivoErroTeste)
ENDIF

#DEFINE SAIDA "C:\4c\automation\probe_f4lop.txt"

LOCAL loc_oE
STRTOFILE("A: inicio" + CHR(13) + CHR(10), SAIDA)

TRY
    CD C:\4c\projeto\app\start
    DO config.prg
    STRTOFILE("B: config.prg OK" + CHR(13) + CHR(10), SAIDA, 1)

    SET PATH TO (gcCaminhoBase + "," + gcCaminhoClasses + "," + gcCaminhoUtils + "," + ;
                 gcCaminhoForms + "," + gcCaminhoIcones)
    SET PROCEDURE TO (gcCaminhoClasses + "dataaccess.prg")   ADDITIVE
    SET PROCEDURE TO (gcCaminhoClasses + "businessbase.prg") ADDITIVE
    SET PROCEDURE TO (gcCaminhoClasses + "formbase.prg")     ADDITIVE
    SET PROCEDURE TO (gcCaminhoClasses + "gridbase.prg")     ADDITIVE
    SET PROCEDURE TO (gcCaminhoClasses + "FormErro.prg")     ADDITIVE
    SET PROCEDURE TO (gcCaminhoUtils   + "functions.prg")    ADDITIVE
    SET PROCEDURE TO (gcCaminhoUtils   + "messages.prg")     ADDITIVE
    SET PROCEDURE TO (gcCaminhoUtils   + "validators.prg")   ADDITIVE
    SET PROCEDURE TO (gcCaminhoClasses + "SigOpLopBO.prg")   ADDITIVE
    SET PROCEDURE TO (gcCaminhoForms + "operacionais\FormSigOpLop.prg") ADDITIVE
    STRTOFILE("C: deps carregadas" + CHR(13) + CHR(10), SAIDA, 1)

    STRTOFILE(ExercitarSemArgs() + CHR(13) + CHR(10), SAIDA, 1)
    STRTOFILE(ExercitarComPai() + CHR(13) + CHR(10), SAIDA, 1)

CATCH TO loc_oE
    STRTOFILE("EXCEPTION: " + loc_oE.Message + " Linha:" + TRANSFORM(loc_oE.LineNo) + ;
              " Proc:" + loc_oE.Procedure + CHR(13) + CHR(10), SAIDA, 1)
ENDTRY

IF FILE(gc_4c_ArquivoErroTeste)
    STRTOFILE("DIALOGOS: " + FILETOSTR(gc_4c_ArquivoErroTeste) + CHR(13) + CHR(10), SAIDA, 1)
ENDIF
STRTOFILE("Z: fim" + CHR(13) + CHR(10), SAIDA, 1)
QUIT


*-- (1) Caminho que o TestFormWrapper exercita: CREATEOBJECT sem argumento e
*-- SEM o cursor do PAI. Nenhuma das duas ausencias pode derrubar o Init - se
*-- derrubar, CREATEOBJECT devolve o logico .F. e a tela nao abre.
FUNCTION ExercitarSemArgs()
    LOCAL loc_oForm, loc_cOut, loc_oE2, loc_oGrid
    loc_cOut = "(1) sem args: "

    TRY
        IF USED("LocalSacOp")
            USE IN LocalSacOp
        ENDIF

        loc_oForm = CREATEOBJECT("FormSigOpLop")

        IF VARTYPE(loc_oForm) != "O"
            loc_cOut = loc_cOut + "NAO INSTANCIOU (VARTYPE=" + VARTYPE(loc_oForm) + ")"
        ELSE
            loc_oGrid = loc_oForm.grd_4c_Dados

            loc_cOut = loc_cOut + "Init OK" + ;
                " | W=" + TRANSFORM(loc_oForm.Width) + " H=" + TRANSFORM(loc_oForm.Height) + ;
                " DS=" + TRANSFORM(loc_oForm.DataSession) + ;
                " | BO=" + VARTYPE(loc_oForm.this_oBusinessObject) + ;
                " | alias=[" + ALLTRIM(loc_oForm.this_cAliasGrade) + "]" + ;
                " editavel=" + TRANSFORM(loc_oForm.this_lGradeEditavel) + ;
                " | grade ColCount=" + TRANSFORM(loc_oGrid.ColumnCount) + ;
                " RecSrc=[" + ALLTRIM(loc_oGrid.RecordSource) + "]" + ;
                " CurCtrl=[" + ALLTRIM(loc_oGrid.Column1.CurrentControl) + "]" + ;
                " | CarregarLista=" + TRANSFORM(loc_oForm.CarregarLista()) + ;
                " | msgErro=[" + ALLTRIM(loc_oForm.this_cMensagemErro) + "]"

            loc_oGrid = .NULL.
            loc_oForm.Release()
            loc_oForm = .NULL.
        ENDIF
    CATCH TO loc_oE2
        loc_cOut = loc_cOut + "EXCEPTION: " + loc_oE2.Message + ;
            " Linha:" + TRANSFORM(loc_oE2.LineNo) + " Proc:" + loc_oE2.Procedure
    ENDTRY

    RETURN loc_cOut
ENDFUNC


*-- (2) Caminho real: o form PAI deixa LocalSacOp aberto NESTA sessao
*-- (contrato DataSession = 1) e passa a propria referencia ao Init. Confere a
*-- grade ligada ao cursor do PAI, a geometria transcrita do SCX, a
*-- ALTERNANCIA gravando de fato, o escopo PUBLIC dos handlers e o Ok.
FUNCTION ExercitarComPai()
    LOCAL loc_oForm, loc_oPai, loc_cOut, loc_oE2, loc_oGrid, loc_oBtn
    LOCAL loc_nAntes, loc_nDepois, loc_nVolta, loc_nEnter, loc_lChkVolta

    loc_cOut = "(2) com pai: "

    TRY
        IF USED("LocalSacOp")
            USE IN LocalSacOp
        ENDIF

        *-- Cursor que o legado monta no form PAI (sigatsac.gerarope):
        *-- "Select 0 as Selecionada, Dopes, ... Into Cursor LocalSacOp"
        CREATE CURSOR LocalSacOp ( ;
            Selecionada N(1), ;
            Dopes       C(20), ;
            GerOpServs  N(1), ;
            cCodServs   C(10), ;
            nVlServs    N(11,2), ;
            nAliIss     N(4,2), ;
            fPags       C(12))
        INSERT INTO LocalSacOp (Selecionada, Dopes) VALUES (0, "LIMPEZA")
        INSERT INTO LocalSacOp (Selecionada, Dopes) VALUES (0, "POLIMENTO")
        INSERT INTO LocalSacOp (Selecionada, Dopes) VALUES (1, "BANHO")

        loc_oPai = CREATEOBJECT("Form")

        loc_oForm = CREATEOBJECT("FormSigOpLop", loc_oPai)

        IF VARTYPE(loc_oForm) != "O"
            loc_cOut = loc_cOut + "NAO INSTANCIOU (VARTYPE=" + VARTYPE(loc_oForm) + ")"
        ELSE
            loc_oGrid = loc_oForm.grd_4c_Dados
            loc_oBtn  = loc_oForm.cmd_4c_CmdSair

            loc_cOut = loc_cOut + "Init OK" + ;
                " | paiEnabled=" + TRANSFORM(loc_oPai.Enabled) + ;
                " | alias=[" + ALLTRIM(loc_oForm.this_cAliasGrade) + "]" + ;
                " editavel=" + TRANSFORM(loc_oForm.this_lGradeEditavel) + ;
                " reccount=" + TRANSFORM(RECCOUNT("LocalSacOp"))

            *-- grade: geometria e bind
            loc_cOut = loc_cOut + CHR(13) + CHR(10) + ;
                "    grade T/L/W/H=" + TRANSFORM(loc_oGrid.Top) + "/" + ;
                    TRANSFORM(loc_oGrid.Left) + "/" + TRANSFORM(loc_oGrid.Width) + "/" + ;
                    TRANSFORM(loc_oGrid.Height) + ;
                " vis=" + TRANSFORM(loc_oGrid.Visible) + ;
                " ColCount=" + TRANSFORM(loc_oGrid.ColumnCount) + ;
                " HdrH=" + TRANSFORM(loc_oGrid.HeaderHeight) + ;
                " RO=" + TRANSFORM(loc_oGrid.ReadOnly) + ;
                " RecSrc=[" + ALLTRIM(loc_oGrid.RecordSource) + "]"

            loc_cOut = loc_cOut + CHR(13) + CHR(10) + ;
                "    col1 CtrlSrc=[" + ALLTRIM(loc_oGrid.Column1.ControlSource) + "]" + ;
                " W=" + TRANSFORM(loc_oGrid.Column1.Width) + ;
                " Sparse=" + TRANSFORM(loc_oGrid.Column1.Sparse) + ;
                " RO=" + TRANSFORM(loc_oGrid.Column1.ReadOnly) + ;
                " CurCtrl=[" + ALLTRIM(loc_oGrid.Column1.CurrentControl) + "]" + ;
                " chk=" + TRANSFORM(PEMSTATUS(loc_oGrid.Column1, "chk_4c_Check1", 5)) + ;
                " chkVal=" + VARTYPE(loc_oGrid.Column1.chk_4c_Check1.Value) + ;
                " hdr=[" + ALLTRIM(loc_oGrid.Column1.Header1.Caption) + "]"

            loc_cOut = loc_cOut + CHR(13) + CHR(10) + ;
                "    col2 CtrlSrc=[" + ALLTRIM(loc_oGrid.Column2.ControlSource) + "]" + ;
                " W=" + TRANSFORM(loc_oGrid.Column2.Width) + ;
                " RO=" + TRANSFORM(loc_oGrid.Column2.ReadOnly) + ;
                " font=[" + ALLTRIM(loc_oGrid.Column2.FontName) + "]" + ;
                " hdr=[" + ALLTRIM(loc_oGrid.Column2.Header1.Caption) + "]"

            *-- botao Ok
            loc_cOut = loc_cOut + CHR(13) + CHR(10) + ;
                "    btn T/L/W/H=" + TRANSFORM(loc_oBtn.Top) + "/" + ;
                    TRANSFORM(loc_oBtn.Left) + "/" + TRANSFORM(loc_oBtn.Width) + "/" + ;
                    TRANSFORM(loc_oBtn.Height) + ;
                " cap=[" + ALLTRIM(loc_oBtn.Caption) + "]" + ;
                " cancel=" + TRANSFORM(loc_oBtn.Cancel) + ;
                " themes=" + TRANSFORM(loc_oBtn.Themes) + ;
                " vis=" + TRANSFORM(loc_oBtn.Visible) + ;
                " picOK=" + TRANSFORM(FILE(loc_oBtn.Picture))

            *-- ALTERNANCIA: tem de GRAVAR no cursor, nao so nao dar erro
            GO TOP IN LocalSacOp
            loc_nAntes = LocalSacOp.Selecionada
            loc_oForm.ChkSelecionadaMouseDown(1, 0, 0, 0)
            loc_nDepois = LocalSacOp.Selecionada
            loc_oForm.ChkSelecionadaMouseDown(1, 0, 0, 0)
            loc_nVolta = LocalSacOp.Selecionada
            loc_oForm.ChkSelecionadaKeyPress(13, 0)
            loc_nEnter = LocalSacOp.Selecionada

            loc_cOut = loc_cOut + CHR(13) + CHR(10) + ;
                "    toggle antes=" + TRANSFORM(loc_nAntes) + ;
                " mouseDown=" + TRANSFORM(loc_nDepois) + ;
                " mouseDown2=" + TRANSFORM(loc_nVolta) + ;
                " enter=" + TRANSFORM(loc_nEnter) + ;
                " | totSel=" + TRANSFORM(loc_oForm.this_oBusinessObject.this_nTotalSelecionadas) + ;
                " marcadas=[" + ALLTRIM(loc_oForm.this_oBusinessObject.this_cOperacoesMarcadas) + "]"

            *-- (3) CheckBox tem de VOLTAR depois de o alias ser derrubado
            USE IN LocalSacOp
            loc_oForm.CarregarLista()
            loc_lChkVolta = PEMSTATUS(loc_oGrid.Column1, "chk_4c_Check1", 5)

            loc_cOut = loc_cOut + CHR(13) + CHR(10) + ;
                "    pos-fechar-alias: alias=[" + ALLTRIM(loc_oForm.this_cAliasGrade) + "]" + ;
                " RecSrc=[" + ALLTRIM(loc_oGrid.RecordSource) + "]" + ;
                " chk=" + TRANSFORM(loc_lChkVolta) + ;
                " CurCtrl=[" + ALLTRIM(loc_oGrid.Column1.CurrentControl) + "]" + ;
                " W1=" + TRANSFORM(loc_oGrid.Column1.Width) + ;
                " hdr2=[" + ALLTRIM(loc_oGrid.Column2.Header1.Caption) + "]"

            *-- ESCOPO: handlers de BINDEVENT tem de ser PUBLIC (regra #3).
            *-- PEMSTATUS(...,2) = .T. significaria PROTECTED.
            loc_cOut = loc_cOut + CHR(13) + CHR(10) + ;
                "    protegidos? MontaGrade=" + TRANSFORM(PEMSTATUS(loc_oForm, "MontaGrade", 2)) + ;
                " CarregarLista=" + TRANSFORM(PEMSTATUS(loc_oForm, "CarregarLista", 2)) + ;
                " CmdSairClick=" + TRANSFORM(PEMSTATUS(loc_oForm, "CmdSairClick", 2)) + ;
                " ChkClick=" + TRANSFORM(PEMSTATUS(loc_oForm, "ChkSelecionadaClick", 2)) + ;
                " ChkMouseDown=" + TRANSFORM(PEMSTATUS(loc_oForm, "ChkSelecionadaMouseDown", 2)) + ;
                " ChkMouseUp=" + TRANSFORM(PEMSTATUS(loc_oForm, "ChkSelecionadaMouseUp", 2)) + ;
                " ChkKeyPress=" + TRANSFORM(PEMSTATUS(loc_oForm, "ChkSelecionadaKeyPress", 2)) + ;
                " AlternarSelecaoLinha=" + TRANSFORM(PEMSTATUS(loc_oForm, "AlternarSelecaoLinha", 2))

            *-- Ok: devolve o Enabled ao pai e fecha
            loc_oGrid = .NULL.
            loc_oBtn  = .NULL.
            loc_oForm.CmdSairClick()

            loc_cOut = loc_cOut + CHR(13) + CHR(10) + ;
                "    pos-Ok: paiEnabled=" + TRANSFORM(loc_oPai.Enabled) + ;
                " formVivo=" + VARTYPE(loc_oForm)

            loc_oForm = .NULL.
        ENDIF

        IF USED("LocalSacOp")
            USE IN LocalSacOp
        ENDIF

        loc_oPai = .NULL.
    CATCH TO loc_oE2
        loc_cOut = loc_cOut + "EXCEPTION: " + loc_oE2.Message + ;
            " Linha:" + TRANSFORM(loc_oE2.LineNo) + " Proc:" + loc_oE2.Procedure
    ENDTRY

    RETURN loc_cOut
ENDFUNC

*==============================================================================
* test_fase4_sigmvcth.prg - Harness da Fase 4 do FormSIGMVCTH
* Bootstrap MINIMO (sem ConfigurarAmbiente, que abre conexao SQL e trava
* em execucao desatendida). Carrega so as dependencias do form.
*==============================================================================
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
SET DATE TO BRITISH
SET CENTURY ON

LOCAL lcLog, loForm, loErr, lcCls, lcUtl
lcLog = "C:\4c\tasks\task566\teste_fase4.txt"
lcCls = "C:\4c\projeto\app\classes\"
lcUtl = "C:\4c\projeto\app\utils\"

STRTOFILE("=== TESTE FASE 4 FormSIGMVCTH ===" + CHR(13) + CHR(10), lcLog, 0)

PUBLIC gb_4c_ModoTeste, gb_4c_ValidandoUI, gnConnHandle
PUBLIC gc_4c_CaminhoIcones, gc_4c_CaminhoReports, gc_4c_UsuarioLogado, go_4c_Sistema
gb_4c_ModoTeste      = .T.
gb_4c_ValidandoUI    = .F.
gnConnHandle         = -1
gc_4c_CaminhoIcones  = "C:\4c\vbmp\"
gc_4c_CaminhoReports = "C:\4c\projeto\app\reports\"
gc_4c_UsuarioLogado  = "TESTE"

SET PATH TO ("C:\4c\projeto\app\classes,C:\4c\projeto\app\utils,C:\4c\projeto\app\forms\operacionais")

*-- 1) Compilacao
TRY
    COMPILE (lcCls + "SIGMVCTHBO.prg")
    COMPILE "C:\4c\projeto\app\forms\operacionais\FormSIGMVCTH.prg"
    STRTOFILE("COMPILE           : OK" + CHR(13) + CHR(10), lcLog, 1)
CATCH TO loErr
    STRTOFILE("COMPILE           : FALHA - " + loErr.Message + CHR(13) + CHR(10), lcLog, 1)
ENDTRY

*-- 2) Dependencias
TRY
    SET PROCEDURE TO (lcUtl + "functions.prg") ADDITIVE
    SET PROCEDURE TO (lcUtl + "messages.prg") ADDITIVE
    SET PROCEDURE TO (lcUtl + "validators.prg") ADDITIVE
    SET PROCEDURE TO (lcCls + "dataaccess.prg") ADDITIVE
    SET PROCEDURE TO (lcCls + "businessbase.prg") ADDITIVE
    SET PROCEDURE TO (lcCls + "formbase.prg") ADDITIVE
    SET PROCEDURE TO (lcCls + "FormErro.prg") ADDITIVE
    SET PROCEDURE TO (lcCls + "SIGMVCTHBO.prg") ADDITIVE
    SET PROCEDURE TO "C:\4c\projeto\app\forms\operacionais\FormSIGMVCTH.prg" ADDITIVE
    STRTOFILE("SET PROCEDURE     : OK" + CHR(13) + CHR(10), lcLog, 1)
CATCH TO loErr
    STRTOFILE("SET PROCEDURE     : FALHA - " + loErr.Message + CHR(13) + CHR(10), lcLog, 1)
ENDTRY

*-- 3) Instanciacao real
loForm = .NULL.
TRY
    loForm = CREATEOBJECT("FormSIGMVCTH", "PROP0001", 0)
CATCH TO loErr
    STRTOFILE("CREATEOBJECT      : EXCECAO - " + loErr.Message + ;
        " | Linha " + TRANSFORM(loErr.LineNo) + " | Proc " + loErr.Procedure + CHR(13) + CHR(10), lcLog, 1)
ENDTRY

IF VARTYPE(loForm) = "O"
    STRTOFILE("CREATEOBJECT      : OK (form instanciado)" + CHR(13) + CHR(10), lcLog, 1)
    STRTOFILE("grd_4c_Dados      : " + TRANSFORM(PEMSTATUS(loForm, "grd_4c_Dados", 5)) + CHR(13) + CHR(10), lcLog, 1)
    STRTOFILE("cmg_4c_Botoes     : " + TRANSFORM(PEMSTATUS(loForm, "cmg_4c_Botoes", 5)) + CHR(13) + CHR(10), lcLog, 1)

    IF PEMSTATUS(loForm, "grd_4c_Dados", 5)
        STRTOFILE("Grid.ColumnCount  : " + TRANSFORM(loForm.grd_4c_Dados.ColumnCount) + CHR(13) + CHR(10), lcLog, 1)
        STRTOFILE("Grid.RecordSource : [" + loForm.grd_4c_Dados.RecordSource + "]" + CHR(13) + CHR(10), lcLog, 1)
        STRTOFILE("Grid.Visible      : " + TRANSFORM(loForm.grd_4c_Dados.Visible) + CHR(13) + CHR(10), lcLog, 1)
        STRTOFILE("Col1 [" + ALLTRIM(loForm.grd_4c_Dados.Column1.Header1.Caption) + "] W=" + TRANSFORM(loForm.grd_4c_Dados.Column1.Width) + ;
            " src=" + loForm.grd_4c_Dados.Column1.ControlSource + CHR(13) + CHR(10), lcLog, 1)
        STRTOFILE("Col8 [" + ALLTRIM(loForm.grd_4c_Dados.Column8.Header1.Caption) + "] W=" + TRANSFORM(loForm.grd_4c_Dados.Column8.Width) + ;
            " src=" + loForm.grd_4c_Dados.Column8.ControlSource + CHR(13) + CHR(10), lcLog, 1)
    ENDIF

    IF PEMSTATUS(loForm, "cmg_4c_Botoes", 5)
        STRTOFILE("Botao Caption     : [" + ALLTRIM(loForm.cmg_4c_Botoes.Buttons(1).Caption) + "]" + CHR(13) + CHR(10), lcLog, 1)
        STRTOFILE("Botao Picture FILE: " + TRANSFORM(FILE(loForm.cmg_4c_Botoes.Buttons(1).Picture)) + CHR(13) + CHR(10), lcLog, 1)
        STRTOFILE("Botao Visible     : " + TRANSFORM(loForm.cmg_4c_Botoes.Visible) + CHR(13) + CHR(10), lcLog, 1)
    ENDIF

    *-- CarregarLista chamada de FORA da classe (como o harness do pipeline faz)
    TRY
        STRTOFILE("CarregarLista()   : retorno " + TRANSFORM(loForm.CarregarLista()) + CHR(13) + CHR(10), lcLog, 1)
        STRTOFILE("  pos RecordSource: [" + loForm.grd_4c_Dados.RecordSource + "]" + CHR(13) + CHR(10), lcLog, 1)
        STRTOFILE("  pos Col1        : [" + ALLTRIM(loForm.grd_4c_Dados.Column1.Header1.Caption) + "] W=" + ;
            TRANSFORM(loForm.grd_4c_Dados.Column1.Width) + CHR(13) + CHR(10), lcLog, 1)
        STRTOFILE("  pos Col8        : [" + ALLTRIM(loForm.grd_4c_Dados.Column8.Header1.Caption) + "] W=" + ;
            TRANSFORM(loForm.grd_4c_Dados.Column8.Width) + CHR(13) + CHR(10), lcLog, 1)
        STRTOFILE("  pos ColumnCount : " + TRANSFORM(loForm.grd_4c_Dados.ColumnCount) + CHR(13) + CHR(10), lcLog, 1)
    CATCH TO loErr
        STRTOFILE("CarregarLista()   : EXCECAO - " + loErr.Message + ;
            " | Linha " + TRANSFORM(loErr.LineNo) + " | Proc " + loErr.Procedure + CHR(13) + CHR(10), lcLog, 1)
    ENDTRY

    *-- Handler do BINDEVENT chamado de fora
    TRY
        loForm.GrdDadosAfterRowColChange(1)
        STRTOFILE("AfterRowColChange : OK" + CHR(13) + CHR(10), lcLog, 1)
    CATCH TO loErr
        STRTOFILE("AfterRowColChange : EXCECAO - " + loErr.Message + " | Proc " + loErr.Procedure + CHR(13) + CHR(10), lcLog, 1)
    ENDTRY

    *-- Botao Retornar
    TRY
        loForm.CmdRetornarClick()
        STRTOFILE("CmdRetornarClick  : OK" + CHR(13) + CHR(10), lcLog, 1)
    CATCH TO loErr
        STRTOFILE("CmdRetornarClick  : EXCECAO - " + loErr.Message + CHR(13) + CHR(10), lcLog, 1)
    ENDTRY

    loForm = .NULL.
ELSE
    STRTOFILE("CREATEOBJECT      : FALHOU - VARTYPE=" + VARTYPE(loForm) + CHR(13) + CHR(10), lcLog, 1)
ENDIF

STRTOFILE("=== FIM ===" + CHR(13) + CHR(10), lcLog, 1)
QUIT

*==============================================================================
* test_fase4_sigprchr.prg - Harness da Fase 4 do FormSigPrChr
* Bootstrap MINIMO (sem ConfigurarAmbiente, que abre conexao SQL e trava
* em execucao desatendida). Carrega so as dependencias do form.
*==============================================================================
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
SET DATE TO BRITISH
SET CENTURY ON

LOCAL lcLog, loForm, loErr, lcCls, lcUtl
lcLog = "C:\4c\tasks\task590\teste_fase4.txt"
lcCls = "C:\4c\projeto\app\classes\"
lcUtl = "C:\4c\projeto\app\utils\"

STRTOFILE("=== TESTE FASE 4 FormSigPrChr ===" + CHR(13) + CHR(10), lcLog, 0)

PUBLIC gb_4c_ModoTeste, gb_4c_ValidandoUI, gnConnHandle, gc_4c_ArquivoErroTeste
PUBLIC gc_4c_CaminhoIcones, gc_4c_CaminhoReports, gc_4c_UsuarioLogado, go_4c_Sistema
gb_4c_ModoTeste        = .T.
gb_4c_ValidandoUI      = .F.
gnConnHandle           = -1
gc_4c_ArquivoErroTeste = "C:\4c\tasks\task590\erros_fase4.txt"
gc_4c_CaminhoIcones    = "C:\4c\vbmp\"
gc_4c_CaminhoReports   = "C:\4c\projeto\app\reports\"
gc_4c_UsuarioLogado    = "TESTE"

IF FILE(gc_4c_ArquivoErroTeste)
    DELETE FILE (gc_4c_ArquivoErroTeste)
ENDIF

SET PATH TO ("C:\4c\projeto\app\classes,C:\4c\projeto\app\utils,C:\4c\projeto\app\forms\operacionais")

*-- 1) Compilacao
TRY
    COMPILE (lcCls + "SigPrChrBO.prg")
    COMPILE "C:\4c\projeto\app\forms\operacionais\FormSigPrChr.prg"
    STRTOFILE("COMPILE           : OK" + CHR(13) + CHR(10), lcLog, 1)
CATCH TO loErr
    STRTOFILE("COMPILE           : FALHA - " + loErr.Message + CHR(13) + CHR(10), lcLog, 1)
ENDTRY

*-- 2) Dependencias
TRY
    SET PROCEDURE TO (lcUtl + "functions.prg") ADDITIVE
    SET PROCEDURE TO (lcUtl + "messages.prg") ADDITIVE
    SET PROCEDURE TO (lcUtl + "validators.prg") ADDITIVE
    SET PROCEDURE TO (lcUtl + "isempty.prg") ADDITIVE
    SET PROCEDURE TO (lcCls + "dataaccess.prg") ADDITIVE
    SET PROCEDURE TO (lcCls + "businessbase.prg") ADDITIVE
    SET PROCEDURE TO (lcCls + "formbase.prg") ADDITIVE
    SET PROCEDURE TO (lcCls + "FormErro.prg") ADDITIVE
    SET PROCEDURE TO (lcCls + "SigPrChrBO.prg") ADDITIVE
    SET PROCEDURE TO "C:\4c\projeto\app\forms\operacionais\FormSigPrChr.prg" ADDITIVE
    STRTOFILE("SET PROCEDURE     : OK" + CHR(13) + CHR(10), lcLog, 1)
CATCH TO loErr
    STRTOFILE("SET PROCEDURE     : FALHA - " + loErr.Message + CHR(13) + CHR(10), lcLog, 1)
ENDTRY

*-- 3) Instanciacao real
loForm = .NULL.
TRY
    loForm = CREATEOBJECT("FormSigPrChr")
CATCH TO loErr
    STRTOFILE("CREATEOBJECT      : EXCECAO - " + loErr.Message + ;
        " | Linha " + TRANSFORM(loErr.LineNo) + " | Proc " + loErr.Procedure + CHR(13) + CHR(10), lcLog, 1)
ENDTRY

IF VARTYPE(loForm) = "O"
    STRTOFILE("CREATEOBJECT      : OK (form instanciado)" + CHR(13) + CHR(10), lcLog, 1)
    STRTOFILE("grd_4c_Dados      : " + TRANSFORM(PEMSTATUS(loForm, "grd_4c_Dados", 5)) + CHR(13) + CHR(10), lcLog, 1)
    STRTOFILE("obj_4c_CmdGok     : " + TRANSFORM(PEMSTATUS(loForm, "obj_4c_CmdGok", 5)) + CHR(13) + CHR(10), lcLog, 1)
    STRTOFILE("cmd_4c_CmdTudo1   : " + TRANSFORM(PEMSTATUS(loForm, "cmd_4c_CmdTudo1", 5)) + CHR(13) + CHR(10), lcLog, 1)
    STRTOFILE("cmd_4c_CmdApaga1  : " + TRANSFORM(PEMSTATUS(loForm, "cmd_4c_CmdApaga1", 5)) + CHR(13) + CHR(10), lcLog, 1)
    STRTOFILE("cursor_4c_Cheques : " + TRANSFORM(USED("cursor_4c_Cheques")) + CHR(13) + CHR(10), lcLog, 1)

    IF PEMSTATUS(loForm, "grd_4c_Dados", 5)
        STRTOFILE("Grid.ColumnCount  : " + TRANSFORM(loForm.grd_4c_Dados.ColumnCount) + CHR(13) + CHR(10), lcLog, 1)
        STRTOFILE("Grid.RecordSource : [" + loForm.grd_4c_Dados.RecordSource + "]" + CHR(13) + CHR(10), lcLog, 1)
        STRTOFILE("Grid.Visible      : " + TRANSFORM(loForm.grd_4c_Dados.Visible) + CHR(13) + CHR(10), lcLog, 1)
        STRTOFILE("Col1  [" + ALLTRIM(loForm.grd_4c_Dados.Column1.Header1.Caption)  + "] W=" + TRANSFORM(loForm.grd_4c_Dados.Column1.Width) + ;
            " ord=" + TRANSFORM(loForm.grd_4c_Dados.Column1.ColumnOrder) + " src=" + loForm.grd_4c_Dados.Column1.ControlSource + CHR(13) + CHR(10), lcLog, 1)
        STRTOFILE("Col8  [" + ALLTRIM(loForm.grd_4c_Dados.Column8.Header1.Caption)  + "] W=" + TRANSFORM(loForm.grd_4c_Dados.Column8.Width) + CHR(13) + CHR(10), lcLog, 1)
        STRTOFILE("Col10 [" + ALLTRIM(loForm.grd_4c_Dados.Column10.Header1.Caption) + "] W=" + TRANSFORM(loForm.grd_4c_Dados.Column10.Width) + ;
            " ord=" + TRANSFORM(loForm.grd_4c_Dados.Column10.ColumnOrder) + ;
            " CurrentControl=" + loForm.grd_4c_Dados.Column10.CurrentControl + ;
            " Sparse=" + TRANSFORM(loForm.grd_4c_Dados.Column10.Sparse) + CHR(13) + CHR(10), lcLog, 1)
        STRTOFILE("chk_4c_Check1     : " + TRANSFORM(PEMSTATUS(loForm.grd_4c_Dados.Column10, "chk_4c_Check1", 5)) + CHR(13) + CHR(10), lcLog, 1)
    ENDIF

    IF PEMSTATUS(loForm, "obj_4c_CmdGok", 5)
        STRTOFILE("CmdGok.ButtonCount: " + TRANSFORM(loForm.obj_4c_CmdGok.ButtonCount) + CHR(13) + CHR(10), lcLog, 1)
        STRTOFILE("Botao1 Caption    : [" + ALLTRIM(loForm.obj_4c_CmdGok.Buttons(1).Caption) + "] Picture FILE=" + ;
            TRANSFORM(FILE(loForm.obj_4c_CmdGok.Buttons(1).Picture)) + CHR(13) + CHR(10), lcLog, 1)
        STRTOFILE("Botao2 Caption    : [" + ALLTRIM(loForm.obj_4c_CmdGok.Buttons(2).Caption) + "] Picture FILE=" + ;
            TRANSFORM(FILE(loForm.obj_4c_CmdGok.Buttons(2).Picture)) + CHR(13) + CHR(10), lcLog, 1)
        STRTOFILE("Botao7 Caption    : [" + ALLTRIM(loForm.obj_4c_CmdGok.Buttons(7).Caption) + "] Picture FILE=" + ;
            TRANSFORM(FILE(loForm.obj_4c_CmdGok.Buttons(7).Picture)) + CHR(13) + CHR(10), lcLog, 1)
        STRTOFILE("Botao8 Caption    : [" + ALLTRIM(loForm.obj_4c_CmdGok.Buttons(8).Caption) + "] Picture FILE=" + ;
            TRANSFORM(FILE(loForm.obj_4c_CmdGok.Buttons(8).Picture)) + CHR(13) + CHR(10), lcLog, 1)
        STRTOFILE("Botao9 Caption    : [" + ALLTRIM(loForm.obj_4c_CmdGok.Buttons(9).Caption) + "] Picture FILE=" + ;
            TRANSFORM(FILE(loForm.obj_4c_CmdGok.Buttons(9).Picture)) + CHR(13) + CHR(10), lcLog, 1)
    ENDIF

    *-- Botoes de marcacao em massa (sem SQL, sem dialogo)
    TRY
        loForm.BtnMarcarTudoClick()
        loForm.BtnDesmarcarTudoClick()
        STRTOFILE("Marcar/DesmarcarTudo: OK" + CHR(13) + CHR(10), lcLog, 1)
    CATCH TO loErr
        STRTOFILE("Marcar/DesmarcarTudo: EXCECAO - " + loErr.Message + " | Linha " + TRANSFORM(loErr.LineNo) + " | Proc " + loErr.Procedure + CHR(13) + CHR(10), lcLog, 1)
    ENDTRY

    *-- Checkbox da coluna Imprime (cursor vazio - so exercita o codigo)
    TRY
        loForm.ChkImprimeKeyPress(32, 0)
        loForm.ChkImprimeMouseUp(1, 0, 0, 0)
        loForm.ChkImprimeMouseDown(1, 0, 0, 0)
        loForm.ChkImprimeClick()
        STRTOFILE("ChkImprime*       : OK" + CHR(13) + CHR(10), lcLog, 1)
    CATCH TO loErr
        STRTOFILE("ChkImprime*       : EXCECAO - " + loErr.Message + " | Linha " + TRANSFORM(loErr.LineNo) + " | Proc " + loErr.Procedure + CHR(13) + CHR(10), lcLog, 1)
    ENDTRY

    *-- Botoes que dependem de containers da Fase 6/7 (devem ser no-op seguro)
    TRY
        loForm.BtnProcurarClick()
        loForm.BtnExcluiDocClick()
        STRTOFILE("Procurar/ExcluiDoc: OK (no-op esperado)" + CHR(13) + CHR(10), lcLog, 1)
    CATCH TO loErr
        STRTOFILE("Procurar/ExcluiDoc: EXCECAO - " + loErr.Message + " | Linha " + TRANSFORM(loErr.LineNo) + " | Proc " + loErr.Procedure + CHR(13) + CHR(10), lcLog, 1)
    ENDTRY

    *-- Botoes de acao com grade vazia (devem cair no guard "Nenhum Cheque Selecionado" sem SQL)
    TRY
        loForm.BtnDocumentoClick()
        loForm.BtnImprimirClick()
        loForm.BtnReciboClick()
        loForm.BtnImpChqClick()
        loForm.BtnChMatClick()
        loForm.BtnExcluirChqClick()
        STRTOFILE("Botoes com grade vazia: OK (guards)" + CHR(13) + CHR(10), lcLog, 1)
    CATCH TO loErr
        STRTOFILE("Botoes com grade vazia: EXCECAO - " + loErr.Message + " | Linha " + TRANSFORM(loErr.LineNo) + " | Proc " + loErr.Procedure + CHR(13) + CHR(10), lcLog, 1)
    ENDTRY

    *-- Dispatcher CmdGokClick, disparado via Value (Botao Sair fecha o form -
    *-- testar por ULTIMO; Release() ja acontece dentro do proprio clique)
    TRY
        loForm.obj_4c_CmdGok.Value = 2
        STRTOFILE("obj_4c_CmdGok.Value=2 (Sair): OK (form liberado)" + CHR(13) + CHR(10), lcLog, 1)
    CATCH TO loErr
        STRTOFILE("obj_4c_CmdGok.Value=2 (Sair): EXCECAO - " + loErr.Message + " | Linha " + TRANSFORM(loErr.LineNo) + " | Proc " + loErr.Procedure + CHR(13) + CHR(10), lcLog, 1)
    ENDTRY

    loForm = .NULL.
ELSE
    STRTOFILE("CREATEOBJECT      : FALHOU - VARTYPE=" + VARTYPE(loForm) + CHR(13) + CHR(10), lcLog, 1)
ENDIF

IF FILE(gc_4c_ArquivoErroTeste)
    STRTOFILE("--- CONTEUDO gc_4c_ArquivoErroTeste ---" + CHR(13) + CHR(10), lcLog, 1)
    STRTOFILE(FILETOSTR(gc_4c_ArquivoErroTeste), lcLog, 1)
ENDIF

STRTOFILE("=== FIM ===" + CHR(13) + CHR(10), lcLog, 1)
QUIT

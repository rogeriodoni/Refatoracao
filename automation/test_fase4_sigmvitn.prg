*==============================================================================
* test_fase4_sigmvitn.prg - Harness da Fase 4 do Formsigmvitn (Caixa)
* Bootstrap MINIMO (sem ConfigurarAmbiente, que abre conexao SQL e trava em
* execucao desatendida). Carrega so as dependencias do form.
*==============================================================================
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
SET DATE TO BRITISH
SET CENTURY ON

LOCAL lcLog, loForm, loErr, lcCls, lcUtl, lcCRLF
lcCRLF = CHR(13) + CHR(10)
lcLog  = "C:\4c\tasks\task571\teste_fase4.txt"
lcCls  = "C:\4c\projeto\app\classes\"
lcUtl  = "C:\4c\projeto\app\utils\"

STRTOFILE("=== TESTE FASE 4 Formsigmvitn ===" + lcCRLF, lcLog, 0)

PUBLIC gb_4c_ModoTeste, gb_4c_ValidandoUI, gnConnHandle
PUBLIC gc_4c_CaminhoIcones, gc_4c_CaminhoReports, gc_4c_UsuarioLogado, go_4c_Sistema
gb_4c_ModoTeste      = .T.
gb_4c_ValidandoUI    = .F.
gnConnHandle         = -1
gc_4c_CaminhoIcones  = "C:\4c\vbmp\"
gc_4c_CaminhoReports = "C:\4c\projeto\app\reports\"
gc_4c_UsuarioLogado  = "TESTE"

go_4c_Sistema = CREATEOBJECT("Empty")
ADDPROPERTY(go_4c_Sistema, "cCodEmpresa", "001")
ADDPROPERTY(go_4c_Sistema, "cEmpresa", "TESTE")

SET PATH TO ("C:\4c\projeto\app\classes,C:\4c\projeto\app\utils,C:\4c\projeto\app\forms\operacionais")

*-- 1) Compilacao
TRY
    COMPILE (lcCls + "sigmvitnBO.prg")
    COMPILE "C:\4c\projeto\app\forms\operacionais\Formsigmvitn.prg"
    STRTOFILE("COMPILE           : OK" + lcCRLF, lcLog, 1)
CATCH TO loErr
    STRTOFILE("COMPILE           : FALHA - " + loErr.Message + lcCRLF, lcLog, 1)
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
    SET PROCEDURE TO (lcCls + "sigmvitnBO.prg") ADDITIVE
    SET PROCEDURE TO "C:\4c\projeto\app\forms\operacionais\Formsigmvitn.prg" ADDITIVE
    STRTOFILE("SET PROCEDURE     : OK" + lcCRLF, lcLog, 1)
CATCH TO loErr
    STRTOFILE("SET PROCEDURE     : FALHA - " + loErr.Message + lcCRLF, lcLog, 1)
ENDTRY

*-- 3) Instanciacao real - prova que o Init inteiro roda
loForm = .NULL.
TRY
    loForm = CREATEOBJECT("Formsigmvitn", .NULL., 0)
CATCH TO loErr
    STRTOFILE("CREATEOBJECT      : EXCECAO - " + loErr.Message + ;
        " | Linha " + TRANSFORM(loErr.LineNo) + " | Proc " + loErr.Procedure + lcCRLF, lcLog, 1)
ENDTRY

IF VARTYPE(loForm) = "O"
    STRTOFILE("CREATEOBJECT      : OK (form instanciado)" + lcCRLF, lcLog, 1)

    *-- As CINCO grades e seus binds
    STRTOFILE("--- GRADES ---" + lcCRLF, lcLog, 1)

    STRTOFILE("grd_4c_Cupom      : " + TRANSFORM(PEMSTATUS(loForm, "grd_4c_Cupom", 5)) + ;
        " | cols=" + TRANSFORM(loForm.grd_4c_Cupom.ColumnCount) + ;
        " | src=[" + loForm.grd_4c_Cupom.RecordSource + "]" + ;
        " | C1=" + TRANSFORM(loForm.grd_4c_Cupom.Column1.Width) + ;
        " [" + loForm.grd_4c_Cupom.Column1.ControlSource + "]" + lcCRLF, lcLog, 1)

    STRTOFILE("grd_4c_Barras     : " + ;
        TRANSFORM(PEMSTATUS(loForm.cnt_4c_Financ.cnt_4c__GrdBarra, "grd_4c_Barras", 5)) + ;
        " | cols=" + TRANSFORM(loForm.cnt_4c_Financ.cnt_4c__GrdBarra.grd_4c_Barras.ColumnCount) + ;
        " | src=[" + loForm.cnt_4c_Financ.cnt_4c__GrdBarra.grd_4c_Barras.RecordSource + "]" + ;
        " | C1=" + TRANSFORM(loForm.cnt_4c_Financ.cnt_4c__GrdBarra.grd_4c_Barras.Column1.Width) + ;
        " [" + ALLTRIM(loForm.cnt_4c_Financ.cnt_4c__GrdBarra.grd_4c_Barras.Column1.Header1.Caption) + "]" + lcCRLF, lcLog, 1)

    STRTOFILE("grd_4c_Devolucao  : " + ;
        TRANSFORM(PEMSTATUS(loForm.cnt_4c__Credito, "grd_4c_Devolucao", 5)) + ;
        " | cols=" + TRANSFORM(loForm.cnt_4c__Credito.grd_4c_Devolucao.ColumnCount) + ;
        " | src=[" + loForm.cnt_4c__Credito.grd_4c_Devolucao.RecordSource + "]" + ;
        " | CurrCtl=[" + loForm.cnt_4c__Credito.grd_4c_Devolucao.Column1.CurrentControl + "]" + ;
        " | Sparse=" + TRANSFORM(loForm.cnt_4c__Credito.grd_4c_Devolucao.Column1.Sparse) + ;
        " | C2=" + TRANSFORM(loForm.cnt_4c__Credito.grd_4c_Devolucao.Column2.Width) + lcCRLF, lcLog, 1)

    STRTOFILE("grd_4c_SubNiveis  : " + ;
        TRANSFORM(PEMSTATUS(loForm.cnt_4c__Pendencia, "grd_4c_SubNiveis", 5)) + ;
        " | cols=" + TRANSFORM(loForm.cnt_4c__Pendencia.grd_4c_SubNiveis.ColumnCount) + ;
        " | src=[" + loForm.cnt_4c__Pendencia.grd_4c_SubNiveis.RecordSource + "]" + ;
        " | C1=" + TRANSFORM(loForm.cnt_4c__Pendencia.grd_4c_SubNiveis.Column1.Width) + ;
        " [" + ALLTRIM(loForm.cnt_4c__Pendencia.grd_4c_SubNiveis.Column1.Header1.Caption) + "]" + lcCRLF, lcLog, 1)

    STRTOFILE("grd_4c_Parcelas   : " + ;
        TRANSFORM(PEMSTATUS(loForm.cnt_4c__Fpagto.cnt_4c__ChequepreTef, "grd_4c_Parcelas", 5)) + ;
        " | cols=" + TRANSFORM(loForm.cnt_4c__Fpagto.cnt_4c__ChequepreTef.grd_4c_Parcelas.ColumnCount) + ;
        " | src=[" + loForm.cnt_4c__Fpagto.cnt_4c__ChequepreTef.grd_4c_Parcelas.RecordSource + "]" + ;
        " | C3=" + TRANSFORM(loForm.cnt_4c__Fpagto.cnt_4c__ChequepreTef.grd_4c_Parcelas.Column3.Width) + ;
        " [" + ALLTRIM(loForm.cnt_4c__Fpagto.cnt_4c__ChequepreTef.grd_4c_Parcelas.Column3.Header1.Caption) + "]" + lcCRLF, lcLog, 1)

    *-- Cursores criados pelo CriarCursoresGrades. O form tem DataSession = 2
    *-- (sessao PRIVADA), entao os alias NAO sao visiveis na sessao do harness:
    *-- e preciso entrar na datasession do form para enxerga-los.
    STRTOFILE("--- CURSORES (dentro da DataSession do form) ---" + lcCRLF, lcLog, 1)
    LOCAL lnSesAnt
    lnSesAnt = SET("DATASESSION")
    SET DATASESSION TO loForm.DataSessionId
    STRTOFILE("crTpmMvItn        : " + TRANSFORM(USED("crTpmMvItn")) + " | FCOUNT=" + ;
        TRANSFORM(IIF(USED("crTpmMvItn"), FCOUNT("crTpmMvItn"), -1)) + lcCRLF, lcLog, 1)
    STRTOFILE("crTpmMvItnC       : " + TRANSFORM(USED("crTpmMvItnC")) + " | FCOUNT=" + ;
        TRANSFORM(IIF(USED("crTpmMvItnC"), FCOUNT("crTpmMvItnC"), -1)) + lcCRLF, lcLog, 1)
    STRTOFILE("TmpOperacao       : " + TRANSFORM(USED("TmpOperacao")) + " | FCOUNT=" + ;
        TRANSFORM(IIF(USED("TmpOperacao"), FCOUNT("TmpOperacao"), -1)) + lcCRLF, lcLog, 1)
    STRTOFILE("TmpDevol          : " + TRANSFORM(USED("TmpDevol")) + " | FCOUNT=" + ;
        TRANSFORM(IIF(USED("TmpDevol"), FCOUNT("TmpDevol"), -1)) + lcCRLF, lcLog, 1)
    STRTOFILE("TmpBarFin         : " + TRANSFORM(USED("TmpBarFin")) + " | FCOUNT=" + ;
        TRANSFORM(IIF(USED("TmpBarFin"), FCOUNT("TmpBarFin"), -1)) + lcCRLF, lcLog, 1)
    STRTOFILE("xPar              : " + TRANSFORM(USED("xPar")) + " | FCOUNT=" + ;
        TRANSFORM(IIF(USED("xPar"), FCOUNT("xPar"), -1)) + lcCRLF, lcLog, 1)
    SET DATASESSION TO (lnSesAnt)

    *-- Botoes de acao das grades
    STRTOFILE("--- BOTOES DAS GRADES ---" + lcCRLF, lcLog, 1)
    STRTOFILE("cmd_4c_Inserir    : [" + ALLTRIM(loForm.cnt_4c_Financ.cnt_4c__GrdBarra.cmd_4c_Inserir.Caption) + "] pic=" + ;
        TRANSFORM(FILE(loForm.cnt_4c_Financ.cnt_4c__GrdBarra.cmd_4c_Inserir.Picture)) + lcCRLF, lcLog, 1)
    STRTOFILE("cmd_4c_Excluir    : [" + ALLTRIM(loForm.cnt_4c_Financ.cnt_4c__GrdBarra.cmd_4c_Excluir.Caption) + "] pic=" + ;
        TRANSFORM(FILE(loForm.cnt_4c_Financ.cnt_4c__GrdBarra.cmd_4c_Excluir.Picture)) + lcCRLF, lcLog, 1)
    STRTOFILE("cmd_4c_OkBarra    : [" + ALLTRIM(loForm.cnt_4c_Financ.cnt_4c__GrdBarra.cmd_4c_OkBarra.Caption) + "] pic=" + ;
        TRANSFORM(FILE(loForm.cnt_4c_Financ.cnt_4c__GrdBarra.cmd_4c_OkBarra.Picture)) + lcCRLF, lcLog, 1)
    STRTOFILE("cmd_4c_BotPendent : [" + ALLTRIM(loForm.cnt_4c__Pendencia.cmd_4c_BotPendentes.Caption) + "] pic=" + ;
        TRANSFORM(FILE(loForm.cnt_4c__Pendencia.cmd_4c_BotPendentes.Picture)) + lcCRLF, lcLog, 1)

    *-- Metodos chamados de FORA da classe (como o harness do pipeline faz)
    STRTOFILE("--- METODOS PUBLICOS ---" + lcCRLF, lcLog, 1)
    TRY
        STRTOFILE("CarregarDados()   : retorno " + TRANSFORM(loForm.CarregarDados()) + lcCRLF, lcLog, 1)
        STRTOFILE("  pos src Cupom   : [" + loForm.grd_4c_Cupom.RecordSource + "] C1 W=" + ;
            TRANSFORM(loForm.grd_4c_Cupom.Column1.Width) + lcCRLF, lcLog, 1)
        STRTOFILE("  pos src Parcelas: [" + loForm.cnt_4c__Fpagto.cnt_4c__ChequepreTef.grd_4c_Parcelas.RecordSource + ;
            "] C1 W=" + TRANSFORM(loForm.cnt_4c__Fpagto.cnt_4c__ChequepreTef.grd_4c_Parcelas.Column1.Width) + lcCRLF, lcLog, 1)
    CATCH TO loErr
        STRTOFILE("CarregarDados()   : EXCECAO - " + loErr.Message + ;
            " | Linha " + TRANSFORM(loErr.LineNo) + " | Proc " + loErr.Procedure + lcCRLF, lcLog, 1)
    ENDTRY

    TRY
        loForm.AtualizarGrades()
        STRTOFILE("AtualizarGrades() : OK | CaixaLivre.Visible=" + ;
            TRANSFORM(loForm.cnt_4c_CaixaLivre.Visible) + lcCRLF, lcLog, 1)
    CATCH TO loErr
        STRTOFILE("AtualizarGrades() : EXCECAO - " + loErr.Message + ;
            " | Linha " + TRANSFORM(loErr.LineNo) + " | Proc " + loErr.Procedure + lcCRLF, lcLog, 1)
    ENDTRY

    *-- Destroy fecha os cursores locais
    TRY
        loForm.Release()
        loForm = .NULL.
        STRTOFILE("Release()         : OK (Destroy fechou os cursores da sessao privada)" + lcCRLF, lcLog, 1)
    CATCH TO loErr
        STRTOFILE("Release()         : EXCECAO - " + loErr.Message + lcCRLF, lcLog, 1)
    ENDTRY
ELSE
    STRTOFILE("CREATEOBJECT      : FALHOU - VARTYPE=" + VARTYPE(loForm) + lcCRLF, lcLog, 1)
ENDIF

STRTOFILE("=== FIM ===" + lcCRLF, lcLog, 1)
QUIT

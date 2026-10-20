SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
SET EXCLUSIVE OFF
SET CONSOLE OFF

LOCAL lcLog, lcBase, loForm, loErr, lnI, lnQtd, loBO, lcChave
lcBase = "C:\4c\projeto\app\"
lcLog  = "C:\4c\automation\TestSigPrPcpF6_saida.txt"
STRTOFILE("=== TESTE FASE 6 FormSigPrPcp ===" + CHR(13) + CHR(10), lcLog)

PUBLIC gnConnHandle, gb_4c_ModoTeste, gb_4c_ValidandoUI
PUBLIC gc_4c_CaminhoIcones, gc_4c_CaminhoFramework, gc_4c_CaminhoReports
PUBLIC gc_4c_UsuarioLogado, gc_4c_ArquivoErroTeste
gnConnHandle           = -1
gb_4c_ModoTeste        = .T.
gb_4c_ValidandoUI      = .T.
gc_4c_CaminhoIcones    = "C:\4c\vbmp\"
gc_4c_CaminhoFramework = "C:\4c\Framework\"
gc_4c_CaminhoReports   = "C:\4c\projeto\app\reports\"
gc_4c_UsuarioLogado    = "TESTE"
gc_4c_ArquivoErroTeste = "C:\4c\automation\TestSigPrPcpF6_erros.txt"

PUBLIC go_4c_Sistema
go_4c_Sistema = CREATEOBJECT("Custom")
go_4c_Sistema.AddProperty("cCodEmpresa", "001")
go_4c_Sistema.AddProperty("cEmpresa", "TESTE")
go_4c_Sistema.AddProperty("cCNPJ", "")

SET PATH TO (lcBase + "utils," + lcBase + "classes," + lcBase + "forms\operacionais," + lcBase + "start")

*-- Apagar FXP antigos dos alvos (senao o harness roda codigo velho)
IF FILE(lcBase + "classes\SigPrPcpBO.fxp")
    ERASE (lcBase + "classes\SigPrPcpBO.fxp")
ENDIF
IF FILE(lcBase + "forms\operacionais\FormSigPrPcp.fxp")
    ERASE (lcBase + "forms\operacionais\FormSigPrPcp.fxp")
ENDIF

COMPILE (lcBase + "classes\SigPrPcpBO.prg")
COMPILE (lcBase + "forms\operacionais\FormSigPrPcp.prg")

STRTOFILE("BO  .fxp recriado  : " + TRANSFORM(FILE(lcBase + "classes\SigPrPcpBO.fxp")) + CHR(13) + CHR(10), lcLog, 1)
STRTOFILE("FORM.fxp recriado  : " + TRANSFORM(FILE(lcBase + "forms\operacionais\FormSigPrPcp.fxp")) + CHR(13) + CHR(10), lcLog, 1)

SET PROCEDURE TO (lcBase + "utils\functions.prg") ADDITIVE
SET PROCEDURE TO (lcBase + "utils\messages.prg") ADDITIVE
SET PROCEDURE TO (lcBase + "utils\validators.prg") ADDITIVE
SET PROCEDURE TO (lcBase + "classes\dataaccess.prg") ADDITIVE
SET PROCEDURE TO (lcBase + "classes\businessbase.prg") ADDITIVE
SET PROCEDURE TO (lcBase + "classes\formbase.prg") ADDITIVE
SET PROCEDURE TO (lcBase + "classes\gridbase.prg") ADDITIVE
SET PROCEDURE TO (lcBase + "classes\SigPrPcpBO.prg") ADDITIVE
SET PROCEDURE TO (lcBase + "forms\operacionais\FormSigPrPcp.prg") ADDITIVE

*-- 1) Chave posicional EmpDopNums char(29)
TRY
    loBO    = CREATEOBJECT("SigPrPcpBO")
    lcChave = loBO.MontarEmpDopNums("001", "MALOTE", 3)
    STRTOFILE("CHAVE len=" + TRANSFORM(LEN(lcChave)) + " [" + lcChave + "]" + CHR(13) + CHR(10), lcLog, 1)
    STRTOFILE("CHAVE ok (29 chars): " + TRANSFORM(LEN(lcChave) = 29) + CHR(13) + CHR(10), lcLog, 1)
CATCH TO loErr
    STRTOFILE("ERRO BO: " + loErr.Message + " LN=" + TRANSFORM(loErr.LineNo) + CHR(13) + CHR(10), lcLog, 1)
ENDTRY

*-- 2) Instanciar o form e inspecionar
TRY
    loForm = CREATEOBJECT("FormSigPrPcp")
    STRTOFILE("FORM VARTYPE       : " + VARTYPE(loForm) + CHR(13) + CHR(10), lcLog, 1)
    IF VARTYPE(loForm) = "O"
        STRTOFILE("BaseClass          : " + loForm.BaseClass + CHR(13) + CHR(10), lcLog, 1)
        STRTOFILE("ValidarPrioridades existe   : " + TRANSFORM(PEMSTATUS(loForm, "ValidarPrioridades", 5)) + CHR(13) + CHR(10), lcLog, 1)
        STRTOFILE("ValidarPrioridades PROTECTED: " + TRANSFORM(PEMSTATUS(loForm, "ValidarPrioridades", 2)) + CHR(13) + CHR(10), lcLog, 1)
        STRTOFILE("this_lTrocandoGrade: " + TRANSFORM(loForm.this_lTrocandoGrade) + CHR(13) + CHR(10), lcLog, 1)
        STRTOFILE("grd Col1 Width     : " + TRANSFORM(loForm.grd_4c_Dados.Column1.Width) + CHR(13) + CHR(10), lcLog, 1)
        STRTOFILE("grd Col1 ReadOnly  : " + TRANSFORM(loForm.grd_4c_Dados.Column1.ReadOnly) + CHR(13) + CHR(10), lcLog, 1)
        STRTOFILE("grd Col1 InputMask : [" + loForm.grd_4c_Dados.Column1.Text1.InputMask + "]" + CHR(13) + CHR(10), lcLog, 1)

        LOCAL ARRAY laEv[1,5]
        lnQtd = AEVENTS(laEv, loForm.grd_4c_Dados.Column1.Text1)
        STRTOFILE("BIND Grade.Col1.Text1 = " + TRANSFORM(lnQtd) + CHR(13) + CHR(10), lcLog, 1)
        FOR lnI = 1 TO lnQtd
            STRTOFILE("   [" + laEv[lnI,3] + " -> " + laEv[lnI,4] + "]" + CHR(13) + CHR(10), lcLog, 1)
        ENDFOR
        lnQtd = AEVENTS(laEv, loForm.grd_4c_Itens.Column1.Text1)
        STRTOFILE("BIND Item.Col1.Text1  = " + TRANSFORM(lnQtd) + CHR(13) + CHR(10), lcLog, 1)
        FOR lnI = 1 TO lnQtd
            STRTOFILE("   [" + laEv[lnI,3] + " -> " + laEv[lnI,4] + "]" + CHR(13) + CHR(10), lcLog, 1)
        ENDFOR

        STRTOFILE("VALIDA sem cursor      : " + TRANSFORM(loForm.ValidarPrioridades()) + "  (esperado .F.)" + CHR(13) + CHR(10), lcLog, 1)
        *-- O form tem DataSession = 2: para exercitar o cursor dele eh preciso
        *-- entrar na datasession privada, senao o teste mexe noutro cursor.
        LOCAL lnDsAnterior
        lnDsAnterior = SET("DATASESSION")
        SET DATASESSION TO loForm.DataSessionID
        STRTOFILE("DataSessionID      : " + TRANSFORM(loForm.DataSessionID) + CHR(13) + CHR(10), lcLog, 1)
        STRTOFILE("cursor_4c_Selecao  : " + TRANSFORM(USED("cursor_4c_Selecao")) + ;
                  "  reccount=" + TRANSFORM(RECCOUNT("cursor_4c_Selecao")) + CHR(13) + CHR(10), lcLog, 1)

        SELECT cursor_4c_Selecao
        INSERT INTO cursor_4c_Selecao (Emps, Dopes, Numes, Priors, aPriors) VALUES ("001", "MALOTE", 3, 0, 0)
        INSERT INTO cursor_4c_Selecao (Emps, Dopes, Numes, Priors, aPriors) VALUES ("001", "MALOTE", 4, 0, 0)
        STRTOFILE("VALIDA todos zero      : " + TRANSFORM(loForm.ValidarPrioridades()) + "  (esperado .F.)" + CHR(13) + CHR(10), lcLog, 1)

        GO TOP IN cursor_4c_Selecao
        REPLACE Priors WITH 5 IN cursor_4c_Selecao
        GO BOTTOM IN cursor_4c_Selecao
        STRTOFILE("VALIDA Priors=5        : " + TRANSFORM(loForm.ValidarPrioridades()) + "  (esperado .T.)" + CHR(13) + CHR(10), lcLog, 1)
        STRTOFILE("Ponteiro preservado(2) : " + TRANSFORM(RECNO("cursor_4c_Selecao") = 2) + CHR(13) + CHR(10), lcLog, 1)

        GO BOTTOM IN cursor_4c_Selecao
        REPLACE Priors WITH 100 IN cursor_4c_Selecao
        GO TOP IN cursor_4c_Selecao
        STRTOFILE("VALIDA Priors=100      : " + TRANSFORM(loForm.ValidarPrioridades()) + "  (esperado .F.)" + CHR(13) + CHR(10), lcLog, 1)
        STRTOFILE("Posicionou na ofensora : " + TRANSFORM(RECNO("cursor_4c_Selecao") = 2) + CHR(13) + CHR(10), lcLog, 1)

        GO BOTTOM IN cursor_4c_Selecao
        REPLACE Priors WITH 99 IN cursor_4c_Selecao
        STRTOFILE("VALIDA Priors=99       : " + TRANSFORM(loForm.ValidarPrioridades()) + "  (esperado .T.)" + CHR(13) + CHR(10), lcLog, 1)

        GO TOP IN cursor_4c_Selecao
        REPLACE Priors WITH 0, aPriors WITH 7 IN cursor_4c_Selecao
        GO BOTTOM IN cursor_4c_Selecao
        REPLACE Priors WITH 0, aPriors WITH 0 IN cursor_4c_Selecao
        STRTOFILE("VALIDA so aPriors<>0   : " + TRANSFORM(loForm.ValidarPrioridades()) + "  (esperado .T.)" + CHR(13) + CHR(10), lcLog, 1)

        SET DATASESSION TO lnDsAnterior

        loForm.Release()
    ENDIF
CATCH TO loErr
    STRTOFILE("ERRO FORM: " + loErr.Message + " LN=" + TRANSFORM(loErr.LineNo) + ;
              " PROC=" + loErr.Procedure + CHR(13) + CHR(10), lcLog, 1)
ENDTRY

STRTOFILE("=== FIM ===" + CHR(13) + CHR(10), lcLog, 1)
QUIT

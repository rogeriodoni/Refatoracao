* _ProbeF5SigOpPcu777.prg - Fase 5: instancia FormSigOpPcu e MEDE os controles
* acrescentados (lbl_4c_Label1 / txt_4c_Adicional), os titulos, o TabIndex lido
* de volta e o comportamento sem o cursor do chamador.
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
SET DATE TO BRITISH
SET CENTURY ON

PUBLIC gnConnHandle, gb_4c_ModoTeste, gb_4c_ValidandoUI
PUBLIC gc_4c_CaminhoBase, gc_4c_CaminhoIcones, gc_4c_CaminhoFramework
PUBLIC gc_4c_UsuarioLogado, gc_4c_CaminhoReports
gnConnHandle           = -1
gb_4c_ModoTeste        = .T.
gb_4c_ValidandoUI      = .F.
gc_4c_CaminhoBase      = "C:\4c\projeto\app\start"
gc_4c_CaminhoIcones    = "C:\4c\vbmp\"
gc_4c_CaminhoFramework = "C:\4c\Framework\"
gc_4c_CaminhoReports   = "C:\4c\projeto\app\reports\"
gc_4c_UsuarioLogado    = "TESTE"

LOCAL loc_cTxt, loc_oErro
loc_cTxt = ""

TRY
    SET PATH TO ("C:\4c\projeto\app\utils,C:\4c\projeto\app\classes,C:\4c\projeto\app\forms\operacionais")
    SET PROCEDURE TO ("C:\4c\projeto\app\utils\functions.prg")   ADDITIVE
    SET PROCEDURE TO ("C:\4c\projeto\app\utils\messages.prg")    ADDITIVE
    SET PROCEDURE TO ("C:\4c\projeto\app\utils\validators.prg")  ADDITIVE
    SET PROCEDURE TO ("C:\4c\projeto\app\classes\dataaccess.prg")   ADDITIVE
    SET PROCEDURE TO ("C:\4c\projeto\app\classes\businessbase.prg") ADDITIVE
    SET PROCEDURE TO ("C:\4c\projeto\app\classes\formbase.prg")     ADDITIVE
    SET PROCEDURE TO ("C:\4c\projeto\app\classes\formerro.prg")     ADDITIVE
    SET PROCEDURE TO ("C:\4c\projeto\app\classes\SigOpPcuBO.prg")   ADDITIVE
    SET PROCEDURE TO ("C:\4c\projeto\app\forms\operacionais\FormSigOpPcu.prg") ADDITIVE

    *---------------------------------------------------------------- cenario A
    DO CriarCursores
    loc_cTxt = loc_cTxt + "=== A) com csGrade + CrSigCdPro, tipo C ===" + CHR(13) + CHR(10)
    loc_cTxt = loc_cTxt + Medir("C")

    *---------------------------------------------------------------- cenario B
    DO CriarCursores
    loc_cTxt = loc_cTxt + "=== B) tipo V ===" + CHR(13) + CHR(10)
    loc_cTxt = loc_cTxt + Medir("V")

    *---------------------------------------------------------------- cenario C
    IF USED("csGrade")
        USE IN csGrade
    ENDIF
    IF USED("CrSigCdPro")
        USE IN CrSigCdPro
    ENDIF
    loc_cTxt = loc_cTxt + "=== C) SEM cursor do chamador (harness) ===" + CHR(13) + CHR(10)
    loc_cTxt = loc_cTxt + Medir("C")

    loc_cTxt = loc_cTxt + "FIM"
CATCH TO loc_oErro
    loc_cTxt = loc_cTxt + "ERRO=" + loc_oErro.Message + ;
               " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
               " PROC=" + loc_oErro.Procedure
ENDTRY

STRTOFILE(loc_cTxt, "C:\4c\automation\_ProbeF5SigOpPcu777.txt")
QUIT

*==========================================================================
PROCEDURE CriarCursores
    IF USED("csGrade")
        USE IN csGrade
    ENDIF
    CREATE CURSOR csGrade (Tipos C(1), Ordem N(3,0), Cpros C(14), Dpros C(30), ;
        Totas N(12,3), Coefs N(8,4), Valos N(12,3), TotalG N(12,3), ;
        Acumulas N(12,3), cGrus C(3), cods C(2), CidChaves C(20), AltCoef N(1,0))
    INSERT INTO csGrade (Tipos, Ordem, Cpros, Dpros, Totas, Coefs, Valos, TotalG, Acumulas, AltCoef) ;
        VALUES ("C", 1, "PRD001", "PRODUTO UM", 100, 1.5, 50, 150, 150, 1)
    INSERT INTO csGrade (Tipos, Ordem, Cpros, Dpros, Totas, Coefs, Valos, TotalG, Acumulas, AltCoef) ;
        VALUES ("C", 2, "PRD002", "PRODUTO DOIS", 200, 1.2, 40, 240, 390, 0)
    INSERT INTO csGrade (Tipos, Ordem, Cpros, Dpros, Totas, Coefs, Valos, TotalG, Acumulas, AltCoef) ;
        VALUES ("V", 1, "PRD003", "PRODUTO TRES", 300, 2, 300, 600, 600, 0)
    SELECT csGrade
    INDEX ON Tipos + STR(Ordem, 3) + Cpros TAG Ordem
    GO TOP

    IF USED("CrSigCdPro")
        USE IN CrSigCdPro
    ENDIF
    CREATE CURSOR CrSigCdPro (Cpros C(14), Dpros C(30))
    INSERT INTO CrSigCdPro (Cpros, Dpros) VALUES ("PRD001", "CAMISA POLO AZUL")
    GO TOP IN CrSigCdPro
ENDPROC

*==========================================================================
FUNCTION Medir(par_cTipo)
    LOCAL loc_o, loc_c, loc_oCnt, loc_oLbl, loc_oTxt, loc_oErro
    loc_c = ""

    TRY
        loc_o = CREATEOBJECT("FormSigOpPcu", .NULL., 0, par_cTipo)
        loc_c = loc_c + "VARTYPE=" + VARTYPE(loc_o) + CHR(13) + CHR(10)

        IF VARTYPE(loc_o) = "O"
            loc_c = loc_c + "Form.Caption=[" + loc_o.Caption + "]" + CHR(13) + CHR(10)
            loc_oCnt = loc_o.cnt_4c__Planilha
            loc_c = loc_c + "Cnt.Picture=[" + loc_oCnt.Picture + "] FILE=" + ;
                    IIF(FILE(loc_oCnt.Picture), "SIM", "NAO") + ;
                    " BackStyle=" + TRANSFORM(loc_oCnt.BackStyle) + CHR(13) + CHR(10)
            loc_c = loc_c + "Faixa.lblTitulo.Caption=[" + ;
                    loc_oCnt.cnt_4c_Sombra.lbl_4c_LblTitulo.Caption + "] ToolTip=[" + ;
                    loc_oCnt.cnt_4c_Sombra.lbl_4c_LblTitulo.ToolTipText + "]" + CHR(13) + CHR(10)

            *-- lbl_4c_Label1
            loc_c = loc_c + "lbl_4c_Label1 existe=" + ;
                    IIF(PEMSTATUS(loc_oCnt, "lbl_4c_Label1", 5), "SIM", "NAO") + CHR(13) + CHR(10)
            loc_oLbl = loc_oCnt.lbl_4c_Label1
            loc_c = loc_c + "  Caption=[" + loc_oLbl.Caption + "]" + CHR(13) + CHR(10)
            loc_c = loc_c + "  Top=" + TRANSFORM(loc_oLbl.Top) + " Left=" + TRANSFORM(loc_oLbl.Left) + ;
                    " W=" + TRANSFORM(loc_oLbl.Width) + " H=" + TRANSFORM(loc_oLbl.Height) + CHR(13) + CHR(10)
            loc_c = loc_c + "  Align=" + TRANSFORM(loc_oLbl.Alignment) + ;
                    " BackStyle=" + TRANSFORM(loc_oLbl.BackStyle) + ;
                    " AutoSize=" + TRANSFORM(loc_oLbl.AutoSize) + ;
                    " Font=" + loc_oLbl.FontName + "/" + TRANSFORM(loc_oLbl.FontSize) + ;
                    "/B" + TRANSFORM(loc_oLbl.FontBold) + ;
                    " ForeColor=" + TRANSFORM(loc_oLbl.ForeColor) + ;
                    " Visible=" + TRANSFORM(loc_oLbl.Visible) + CHR(13) + CHR(10)

            *-- txt_4c_Adicional
            loc_c = loc_c + "txt_4c_Adicional existe=" + ;
                    IIF(PEMSTATUS(loc_oCnt, "txt_4c_Adicional", 5), "SIM", "NAO") + CHR(13) + CHR(10)
            loc_oTxt = loc_oCnt.txt_4c_Adicional
            loc_c = loc_c + "  Value=" + TRANSFORM(loc_oTxt.Value) + ;
                    " VARTYPE=" + VARTYPE(loc_oTxt.Value) + ;
                    " BO.TotalAdic=" + TRANSFORM(loc_o.this_oBusinessObject.this_nTotalAdicional) + CHR(13) + CHR(10)
            loc_c = loc_c + "  Top=" + TRANSFORM(loc_oTxt.Top) + " Left=" + TRANSFORM(loc_oTxt.Left) + ;
                    " W=" + TRANSFORM(loc_oTxt.Width) + " H=" + TRANSFORM(loc_oTxt.Height) + CHR(13) + CHR(10)
            loc_c = loc_c + "  InputMask=[" + loc_oTxt.InputMask + "] Align=" + TRANSFORM(loc_oTxt.Alignment) + ;
                    " ReadOnly=" + TRANSFORM(loc_oTxt.ReadOnly) + ;
                    " SpecialEffect=" + TRANSFORM(loc_oTxt.SpecialEffect) + ;
                    " Back=" + TRANSFORM(loc_oTxt.BackColor) + ;
                    " DisBack=" + TRANSFORM(loc_oTxt.DisabledBackColor) + ;
                    " DisFore=" + TRANSFORM(loc_oTxt.DisabledForeColor) + ;
                    " TabStop=" + TRANSFORM(loc_oTxt.TabStop) + ;
                    " Visible=" + TRANSFORM(loc_oTxt.Visible) + CHR(13) + CHR(10)

            *-- TabIndex lido de volta
            loc_c = loc_c + "TabIndex: Cnt=" + TRANSFORM(loc_oCnt.TabIndex) + ;
                    " Sombra=" + TRANSFORM(loc_oCnt.cnt_4c_Sombra.TabIndex) + ;
                    " Grade=" + TRANSFORM(loc_oCnt.grd_4c_Dados.TabIndex) + ;
                    " Label1=" + TRANSFORM(loc_oLbl.TabIndex) + ;
                    " Adicional=" + TRANSFORM(loc_oTxt.TabIndex) + ;
                    " Encerrar=" + TRANSFORM(loc_oCnt.cmd_4c_Encerrar.TabIndex) + CHR(13) + CHR(10)

            *-- metodos novos chamados de FORA da classe (regra #3)
            loc_c = loc_c + "PROTECTED? AtualizarTitulos=" + ;
                    TRANSFORM(PEMSTATUS(loc_o, "AtualizarTitulos", 2)) + ;
                    " AtualizarTotalAdicional=" + ;
                    TRANSFORM(PEMSTATUS(loc_o, "AtualizarTotalAdicional", 2)) + CHR(13) + CHR(10)
            loc_o.AtualizarTotalAdicional()
            loc_o.AtualizarTitulos()
            loc_c = loc_c + "apos chamada externa: Value=" + TRANSFORM(loc_oTxt.Value) + ;
                    " Label1=[" + loc_oLbl.Caption + "]" + CHR(13) + CHR(10)

            loc_o.Release()
        ENDIF
    CATCH TO loc_oErro
        loc_c = loc_c + "ERRO=" + loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
                " PROC=" + loc_oErro.Procedure + CHR(13) + CHR(10)
    ENDTRY

    RETURN loc_c + CHR(13) + CHR(10)
ENDFUNC

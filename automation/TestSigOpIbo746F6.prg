*==============================================================================
* TestSigOpIbo746F6.prg - Probe da FASE 6 de FormSigOpIbo (task746)
* Compila BO + Form, instancia e mede o que a fase entregou.
*==============================================================================
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
SET EXCLUSIVE OFF
SET CONSOLE OFF

LOCAL lcLog, lcBase, loForm, loErr, lnI, lnJ
PRIVATE laEv
DIMENSION laEv(1, 5)
lcBase = "C:\4c\projeto\app\"
lcLog  = "C:\4c\automation\TestSigOpIbo746F6_saida.txt"
STRTOFILE("=== PROBE FASE 6 FormSigOpIbo (task746) ===" + CHR(13) + CHR(10), lcLog)

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
gc_4c_ArquivoErroTeste = "C:\4c\automation\TestSigOpIbo746F6_erros.txt"

PUBLIC go_4c_Sistema
go_4c_Sistema = CREATEOBJECT("Custom")
go_4c_Sistema.AddProperty("cCodEmpresa", "001")
go_4c_Sistema.AddProperty("cEmpresa", "TESTE")
go_4c_Sistema.AddProperty("cCNPJ", "")

SET PATH TO (lcBase + "utils," + lcBase + "classes," + lcBase + "forms\operacionais," + lcBase + "start")

*-- 1) COMPILACAO (apagar o FXP antes, senao roda codigo velho)
IF FILE(lcBase + "classes\SigOpIboBO.fxp")
    ERASE (lcBase + "classes\SigOpIboBO.fxp")
ENDIF
IF FILE(lcBase + "forms\operacionais\FormSigOpIbo.fxp")
    ERASE (lcBase + "forms\operacionais\FormSigOpIbo.fxp")
ENDIF
IF FILE(lcBase + "classes\SigOpIboBO.err")
    ERASE (lcBase + "classes\SigOpIboBO.err")
ENDIF
IF FILE(lcBase + "forms\operacionais\FormSigOpIbo.err")
    ERASE (lcBase + "forms\operacionais\FormSigOpIbo.err")
ENDIF

COMPILE (lcBase + "classes\SigOpIboBO.prg")
COMPILE (lcBase + "forms\operacionais\FormSigOpIbo.prg")

STRTOFILE("-- 1) COMPILACAO" + CHR(13) + CHR(10), lcLog, 1)
STRTOFILE("   BO   FXP=" + TRANSFORM(FILE(lcBase + "classes\SigOpIboBO.fxp")) + ;
    "  ERR=" + TRANSFORM(FILE(lcBase + "classes\SigOpIboBO.err")) + CHR(13) + CHR(10), lcLog, 1)
STRTOFILE("   FORM FXP=" + TRANSFORM(FILE(lcBase + "forms\operacionais\FormSigOpIbo.fxp")) + ;
    "  ERR=" + TRANSFORM(FILE(lcBase + "forms\operacionais\FormSigOpIbo.err")) + CHR(13) + CHR(10), lcLog, 1)
IF FILE(lcBase + "forms\operacionais\FormSigOpIbo.err")
    STRTOFILE("   CONTEUDO DO .ERR:" + CHR(13) + CHR(10) + ;
        FILETOSTR(lcBase + "forms\operacionais\FormSigOpIbo.err") + CHR(13) + CHR(10), lcLog, 1)
ENDIF

SET PROCEDURE TO (lcBase + "utils\functions.prg") ADDITIVE
SET PROCEDURE TO (lcBase + "utils\messages.prg") ADDITIVE
SET PROCEDURE TO (lcBase + "utils\validators.prg") ADDITIVE
SET PROCEDURE TO (lcBase + "classes\dataaccess.prg") ADDITIVE
SET PROCEDURE TO (lcBase + "classes\businessbase.prg") ADDITIVE
SET PROCEDURE TO (lcBase + "classes\formbase.prg") ADDITIVE
SET PROCEDURE TO (lcBase + "classes\gridbase.prg") ADDITIVE
SET PROCEDURE TO (lcBase + "classes\SigOpIboBO.prg") ADDITIVE
SET PROCEDURE TO (lcBase + "forms\operacionais\FormSigOpIbo.prg") ADDITIVE

*-- 2) INSTANCIACAO (TpBol = 2 -> chkObss visivel, chkCarne e chkAgrupa nao)
STRTOFILE(CHR(13) + CHR(10) + "-- 2) INSTANCIACAO TpBol=2" + CHR(13) + CHR(10), lcLog, 1)
loForm = .NULL.
TRY
    loForm = CREATEOBJECT("FormSigOpIbo", .NULL., 2, "", "001", "MALOTE", 7, 0, 1, 2, "crTeste")
CATCH TO loErr
    STRTOFILE("   EXCECAO: " + loErr.Message + " LN=" + TRANSFORM(loErr.LineNo) + ;
        " PROC=" + loErr.Procedure + CHR(13) + CHR(10), lcLog, 1)
ENDTRY
STRTOFILE("   VARTYPE(loForm)=" + VARTYPE(loForm) + CHR(13) + CHR(10), lcLog, 1)

IF VARTYPE(loForm) = "O"
    *-- 3) EXISTENCIA E GEOMETRIA DOS 5 CONTROLES NOVOS
    STRTOFILE(CHR(13) + CHR(10) + "-- 3) CONTROLES NOVOS" + CHR(13) + CHR(10), lcLog, 1)
    STRTOFILE("   chk_4c_ChkCarne  existe=" + TRANSFORM(PEMSTATUS(loForm, "chk_4c_ChkCarne", 5)) + CHR(13) + CHR(10), lcLog, 1)
    STRTOFILE("   chk_4c_ChkObss   existe=" + TRANSFORM(PEMSTATUS(loForm, "chk_4c_ChkObss", 5)) + CHR(13) + CHR(10), lcLog, 1)
    STRTOFILE("   chk_4c_ChkAgrupa existe=" + TRANSFORM(PEMSTATUS(loForm, "chk_4c_ChkAgrupa", 5)) + CHR(13) + CHR(10), lcLog, 1)
    STRTOFILE("   lbl_4c_Lbl_Erro  existe=" + TRANSFORM(PEMSTATUS(loForm, "lbl_4c_Lbl_Erro", 5)) + CHR(13) + CHR(10), lcLog, 1)
    STRTOFILE("   obj_4c_Edit1     existe=" + TRANSFORM(PEMSTATUS(loForm.cnt_4c_Container1, "obj_4c_Edit1", 5)) + CHR(13) + CHR(10), lcLog, 1)

    WITH loForm.chk_4c_ChkCarne
        STRTOFILE("   chkCarne  L=" + TRANSFORM(.Left) + " T=" + TRANSFORM(.Top) + ;
            " W=" + TRANSFORM(.Width) + " H=" + TRANSFORM(.Height) + ;
            " Val=" + TRANSFORM(.Value) + " Tipo=" + VARTYPE(.Value) + ;
            " AutoSize=" + TRANSFORM(.AutoSize) + " BackStyle=" + TRANSFORM(.BackStyle) + ;
            " FC=" + TRANSFORM(.ForeColor) + " Cap=[" + .Caption + "]" + CHR(13) + CHR(10), lcLog, 1)
    ENDWITH
    WITH loForm.chk_4c_ChkObss
        STRTOFILE("   chkObss   L=" + TRANSFORM(.Left) + " T=" + TRANSFORM(.Top) + ;
            " W=" + TRANSFORM(.Width) + " H=" + TRANSFORM(.Height) + ;
            " Val=" + TRANSFORM(.Value) + " Tipo=" + VARTYPE(.Value) + ;
            " Cap=[" + .Caption + "]" + CHR(13) + CHR(10), lcLog, 1)
    ENDWITH
    WITH loForm.chk_4c_ChkAgrupa
        STRTOFILE("   chkAgrupa L=" + TRANSFORM(.Left) + " T=" + TRANSFORM(.Top) + ;
            " W=" + TRANSFORM(.Width) + " H=" + TRANSFORM(.Height) + ;
            " Val=" + TRANSFORM(.Value) + " Tipo=" + VARTYPE(.Value) + ;
            " Cap=[" + .Caption + "]" + CHR(13) + CHR(10), lcLog, 1)
    ENDWITH
    WITH loForm.lbl_4c_Lbl_Erro
        STRTOFILE("   Lbl_Erro  L=" + TRANSFORM(.Left) + " T=" + TRANSFORM(.Top) + ;
            " W=" + TRANSFORM(.Width) + " H=" + TRANSFORM(.Height) + ;
            " Align=" + TRANSFORM(.Alignment) + " WordWrap=" + TRANSFORM(.WordWrap) + ;
            " AutoSize=" + TRANSFORM(.AutoSize) + " Font=" + .FontName + "/" + TRANSFORM(.FontSize) + ;
            " FC=" + TRANSFORM(.ForeColor) + " Visible=" + TRANSFORM(.Visible) + CHR(13) + CHR(10), lcLog, 1)
        STRTOFILE("   Lbl_Erro  Cap=[" + .Caption + "]" + CHR(13) + CHR(10), lcLog, 1)
    ENDWITH
    WITH loForm.cnt_4c_Container1.obj_4c_Edit1
        STRTOFILE("   Edit1     L=" + TRANSFORM(.Left) + " T=" + TRANSFORM(.Top) + ;
            " W=" + TRANSFORM(.Width) + " H=" + TRANSFORM(.Height) + ;
            " ReadOnly=" + TRANSFORM(.ReadOnly) + " Tipo=" + VARTYPE(.Value) + ;
            " Visible=" + TRANSFORM(.Visible) + " DisBack=" + TRANSFORM(.DisabledBackColor) + CHR(13) + CHR(10), lcLog, 1)
    ENDWITH
    STRTOFILE("   cnt_4c_Container1.Visible=" + TRANSFORM(loForm.cnt_4c_Container1.Visible) + CHR(13) + CHR(10), lcLog, 1)
    STRTOFILE("   obj_4c_Opt_Impressora.Visible=" + TRANSFORM(loForm.obj_4c_Opt_Impressora.Visible) + CHR(13) + CHR(10), lcLog, 1)

    *-- 4) SOBREPOSICAO LATERAL NA LINHA Top=89 (regra #28)
    STRTOFILE(CHR(13) + CHR(10) + "-- 4) LINHA Top=89 (Left..Left+Width)" + CHR(13) + CHR(10), lcLog, 1)
    STRTOFILE("   Lbl_Impressora " + TRANSFORM(loForm.lbl_4c_Lbl_Impressora.Left) + ".." + ;
        TRANSFORM(loForm.lbl_4c_Lbl_Impressora.Left + loForm.lbl_4c_Lbl_Impressora.Width) + CHR(13) + CHR(10), lcLog, 1)
    STRTOFILE("   chkCarne       " + TRANSFORM(loForm.chk_4c_ChkCarne.Left) + ".." + ;
        TRANSFORM(loForm.chk_4c_ChkCarne.Left + loForm.chk_4c_ChkCarne.Width) + CHR(13) + CHR(10), lcLog, 1)
    STRTOFILE("   chkAgrupa      " + TRANSFORM(loForm.chk_4c_ChkAgrupa.Left) + ".." + ;
        TRANSFORM(loForm.chk_4c_ChkAgrupa.Left + loForm.chk_4c_ChkAgrupa.Width) + CHR(13) + CHR(10), lcLog, 1)
    STRTOFILE("   Form.Width=" + TRANSFORM(loForm.Width) + " Height=" + TRANSFORM(loForm.Height) + CHR(13) + CHR(10), lcLog, 1)

    *-- 5) VISIBILIDADE POR TIPO (TpBol=2: nem carne nem agrupa)
    STRTOFILE(CHR(13) + CHR(10) + "-- 5) VISIBILIDADE TpBol=2" + CHR(13) + CHR(10), lcLog, 1)
    STRTOFILE("   chkObss.Visible   =" + TRANSFORM(loForm.chk_4c_ChkObss.Visible) + "  (esperado .T.)" + CHR(13) + CHR(10), lcLog, 1)
    STRTOFILE("   chkCarne.Visible  =" + TRANSFORM(loForm.chk_4c_ChkCarne.Visible) + "  (esperado .F.)" + CHR(13) + CHR(10), lcLog, 1)
    STRTOFILE("   chkAgrupa.Visible =" + TRANSFORM(loForm.chk_4c_ChkAgrupa.Visible) + "  (esperado .F.)" + CHR(13) + CHR(10), lcLog, 1)

    *-- 6) TABINDEX
    STRTOFILE(CHR(13) + CHR(10) + "-- 6) TABINDEX (ordem legado: Printer,Qtde,Opt,Carne,btnReport,Obss,Agrupa)" + CHR(13) + CHR(10), lcLog, 1)
    STRTOFILE("   cbo_4c_Get_Printer    =" + TRANSFORM(loForm.cbo_4c_Get_Printer.TabIndex) + CHR(13) + CHR(10), lcLog, 1)
    STRTOFILE("   txt_4c_Qtde           =" + TRANSFORM(loForm.txt_4c_Qtde.TabIndex) + CHR(13) + CHR(10), lcLog, 1)
    STRTOFILE("   obj_4c_Opt_Impressora =" + TRANSFORM(loForm.obj_4c_Opt_Impressora.TabIndex) + CHR(13) + CHR(10), lcLog, 1)
    STRTOFILE("   chk_4c_ChkCarne       =" + TRANSFORM(loForm.chk_4c_ChkCarne.TabIndex) + CHR(13) + CHR(10), lcLog, 1)
    STRTOFILE("   obj_4c_BtnReport      =" + TRANSFORM(loForm.obj_4c_BtnReport.TabIndex) + CHR(13) + CHR(10), lcLog, 1)
    STRTOFILE("   chk_4c_ChkObss        =" + TRANSFORM(loForm.chk_4c_ChkObss.TabIndex) + CHR(13) + CHR(10), lcLog, 1)
    STRTOFILE("   chk_4c_ChkAgrupa      =" + TRANSFORM(loForm.chk_4c_ChkAgrupa.TabIndex) + CHR(13) + CHR(10), lcLog, 1)
    STRTOFILE("   (labels/containers) Lbl_Impressora=" + TRANSFORM(loForm.lbl_4c_Lbl_Impressora.TabIndex) + ;
        " Label1=" + TRANSFORM(loForm.lbl_4c_Label1.TabIndex) + ;
        " Label9=" + TRANSFORM(loForm.lbl_4c_Label9.TabIndex) + ;
        " Container1=" + TRANSFORM(loForm.cnt_4c_Container1.TabIndex) + CHR(13) + CHR(10), lcLog, 1)

    *-- 7) BINDEVENT (DataSession=2: AEVENTS(a,0) devolve 0 - usar o objeto)
    STRTOFILE(CHR(13) + CHR(10) + "-- 7) BINDEVENT em txt_4c_Qtde" + CHR(13) + CHR(10), lcLog, 1)
    lnI = AEVENTS(laEv, loForm.txt_4c_Qtde)
    STRTOFILE("   AEVENTS=" + TRANSFORM(lnI) + CHR(13) + CHR(10), lcLog, 1)
    IF lnI > 0
        FOR lnJ = 1 TO lnI
            STRTOFILE("     " + TRANSFORM(laEv(lnJ, 3)) + " -> " + TRANSFORM(laEv(lnJ, 4)) + CHR(13) + CHR(10), lcLog, 1)
        ENDFOR
    ENDIF
    lnI = AEVENTS(laEv, loForm.obj_4c_BtnReport.Buttons(1))
    STRTOFILE("   btnReport.Buttons(1) AEVENTS=" + TRANSFORM(lnI) + CHR(13) + CHR(10), lcLog, 1)
    IF lnI > 0
        FOR lnJ = 1 TO lnI
            STRTOFILE("     " + TRANSFORM(laEv(lnJ, 3)) + " -> " + TRANSFORM(laEv(lnJ, 4)) + CHR(13) + CHR(10), lcLog, 1)
        ENDFOR
    ENDIF

    *-- 8) VISIBILIDADE DOS HANDLERS (2 = Protected; .F. significa PUBLIC)
    STRTOFILE(CHR(13) + CHR(10) + "-- 8) HANDLERS PUBLIC? (PEMSTATUS attr 2 = Protected)" + CHR(13) + CHR(10), lcLog, 1)
    STRTOFILE("   ValidarQtde         Protected=" + TRANSFORM(PEMSTATUS(loForm, "ValidarQtde", 2)) + CHR(13) + CHR(10), lcLog, 1)
    STRTOFILE("   ValidarQtdeKeyPress Protected=" + TRANSFORM(PEMSTATUS(loForm, "ValidarQtdeKeyPress", 2)) + CHR(13) + CHR(10), lcLog, 1)

    *-- 9) REGRA DO VALID: >0 grava, 0 NAO grava, CHAR nao estoura
    STRTOFILE(CHR(13) + CHR(10) + "-- 9) ValidarQtde (Valid do legado)" + CHR(13) + CHR(10), lcLog, 1)
    STRTOFILE("   inicio: txt.Value=" + TRANSFORM(loForm.txt_4c_Qtde.Value) + ;
        " form.this_nQBols=" + TRANSFORM(loForm.this_nQBols) + ;
        " BO.this_nQBols=" + TRANSFORM(loForm.this_oBusinessObject.this_nQBols) + CHR(13) + CHR(10), lcLog, 1)

    loForm.txt_4c_Qtde.Value = 4
    loForm.ValidarQtde()
    STRTOFILE("   Value=4  -> form=" + TRANSFORM(loForm.this_nQBols) + ;
        " BO=" + TRANSFORM(loForm.this_oBusinessObject.this_nQBols) + "  (esperado 4/4)" + CHR(13) + CHR(10), lcLog, 1)

    loForm.txt_4c_Qtde.Value = 0
    loForm.ValidarQtde()
    STRTOFILE("   Value=0  -> form=" + TRANSFORM(loForm.this_nQBols) + ;
        " BO=" + TRANSFORM(loForm.this_oBusinessObject.this_nQBols) + "  (esperado 4/4 - zero NAO sobrescreve)" + CHR(13) + CHR(10), lcLog, 1)

    loForm.txt_4c_Qtde.Value = "7"
    loForm.ValidarQtde()
    STRTOFILE("   Value='7' -> form=" + TRANSFORM(loForm.this_nQBols) + ;
        " BO=" + TRANSFORM(loForm.this_oBusinessObject.this_nQBols) + "  (esperado 7/7 - CHAR nao estoura)" + CHR(13) + CHR(10), lcLog, 1)

    *-- 10) KeyPress: so ENTER(13)/TAB(9)
    STRTOFILE(CHR(13) + CHR(10) + "-- 10) ValidarQtdeKeyPress" + CHR(13) + CHR(10), lcLog, 1)
    loForm.txt_4c_Qtde.Value = 2
    loForm.ValidarQtdeKeyPress(65, 0)
    STRTOFILE("   tecla 'A'(65) -> BO=" + TRANSFORM(loForm.this_oBusinessObject.this_nQBols) + "  (esperado 7 - nao muda)" + CHR(13) + CHR(10), lcLog, 1)
    loForm.ValidarQtdeKeyPress(13, 0)
    STRTOFILE("   ENTER(13)     -> BO=" + TRANSFORM(loForm.this_oBusinessObject.this_nQBols) + "  (esperado 2)" + CHR(13) + CHR(10), lcLog, 1)
    loForm.txt_4c_Qtde.Value = 5
    loForm.ValidarQtdeKeyPress(9, 0)
    STRTOFILE("   TAB(9)        -> BO=" + TRANSFORM(loForm.this_oBusinessObject.this_nQBols) + "  (esperado 5)" + CHR(13) + CHR(10), lcLog, 1)
    *-- caminho do MOUSE: LostFocus nao passa parametro - o evento nativo
    loForm.txt_4c_Qtde.Value = 6
    loForm.txt_4c_Qtde.LostFocus()
    STRTOFILE("   LostFocus()   -> BO=" + TRANSFORM(loForm.this_oBusinessObject.this_nQBols) + "  (esperado 6 - caminho do mouse)" + CHR(13) + CHR(10), lcLog, 1)

    *-- 11) SincronizarOpcoesParaBO le os 3 checkboxes
    STRTOFILE(CHR(13) + CHR(10) + "-- 11) SincronizarOpcoesParaBO le os checkboxes" + CHR(13) + CHR(10), lcLog, 1)
    loForm.chk_4c_ChkCarne.Value  = 0
    loForm.chk_4c_ChkObss.Value   = 0
    loForm.chk_4c_ChkAgrupa.Value = 1
    loForm.SincronizarOpcoesParaBO()
    STRTOFILE("   BO.Carne=" + TRANSFORM(loForm.this_oBusinessObject.this_lImprimirCarne) + ;
        " BO.Obss=" + TRANSFORM(loForm.this_oBusinessObject.this_lImprimirObservacoes) + ;
        " BO.Agrupa=" + TRANSFORM(loForm.this_oBusinessObject.this_lAgruparInformacoes) + ;
        "  (esperado .F./.F./.T.)" + CHR(13) + CHR(10), lcLog, 1)

    *-- 12) ExibirConteudoBoleto liga o painel e enche o EditBox
    STRTOFILE(CHR(13) + CHR(10) + "-- 12) painel do BOLETO.txt" + CHR(13) + CHR(10), lcLog, 1)
    STRTOFILE("   antes: Container1.Visible=" + TRANSFORM(loForm.cnt_4c_Container1.Visible) + ;
        " Edit1.Value=[" + loForm.cnt_4c_Container1.obj_4c_Edit1.Value + "]" + CHR(13) + CHR(10), lcLog, 1)

    loForm.Release()
    loForm = .NULL.
ENDIF

*-- 13) VISIBILIDADE POR TIPO: TpBol=18 (Duplicata/Carne) e TpBol=3 (Agrupa)
STRTOFILE(CHR(13) + CHR(10) + "-- 13) VISIBILIDADE TpBol=18" + CHR(13) + CHR(10), lcLog, 1)
TRY
    loForm = CREATEOBJECT("FormSigOpIbo", .NULL., 18, "", "001", "MALOTE", 7, 0, 1, 1, "crTeste")
    STRTOFILE("   chkObss=" + TRANSFORM(loForm.chk_4c_ChkObss.Visible) + " (esp .F.)" + ;
        "  chkCarne=" + TRANSFORM(loForm.chk_4c_ChkCarne.Visible) + " (esp .T.)" + ;
        "  chkAgrupa=" + TRANSFORM(loForm.chk_4c_ChkAgrupa.Visible) + " (esp .F.)" + CHR(13) + CHR(10), lcLog, 1)
    STRTOFILE("   Caption=[" + loForm.Caption + "]" + CHR(13) + CHR(10), lcLog, 1)
    loForm.Release()
    loForm = .NULL.
CATCH TO loErr
    STRTOFILE("   EXCECAO: " + loErr.Message + " LN=" + TRANSFORM(loErr.LineNo) + ;
        " PROC=" + loErr.Procedure + CHR(13) + CHR(10), lcLog, 1)
ENDTRY

STRTOFILE(CHR(13) + CHR(10) + "-- 14) VISIBILIDADE TpBol=3" + CHR(13) + CHR(10), lcLog, 1)
TRY
    loForm = CREATEOBJECT("FormSigOpIbo", .NULL., 3, "", "001", "MALOTE", 7, 0, 2, 1, "crTeste")
    STRTOFILE("   chkObss=" + TRANSFORM(loForm.chk_4c_ChkObss.Visible) + " (esp .T.)" + ;
        "  chkCarne=" + TRANSFORM(loForm.chk_4c_ChkCarne.Visible) + " (esp .F.)" + ;
        "  chkAgrupa=" + TRANSFORM(loForm.chk_4c_ChkAgrupa.Visible) + " (esp .T.)" + CHR(13) + CHR(10), lcLog, 1)
    loForm.Release()
    loForm = .NULL.
CATCH TO loErr
    STRTOFILE("   EXCECAO: " + loErr.Message + " LN=" + TRANSFORM(loErr.LineNo) + ;
        " PROC=" + loErr.Procedure + CHR(13) + CHR(10), lcLog, 1)
ENDTRY

*-- 15) SEM PARAMETRO NENHUM (o que o TestFormWrapper faz)
STRTOFILE(CHR(13) + CHR(10) + "-- 15) CREATEOBJECT SEM PARAMETRO" + CHR(13) + CHR(10), lcLog, 1)
TRY
    loForm = CREATEOBJECT("FormSigOpIbo")
    STRTOFILE("   VARTYPE=" + VARTYPE(loForm) + "  Caption=[" + loForm.Caption + "]" + ;
        "  chkObss=" + TRANSFORM(loForm.chk_4c_ChkObss.Visible) + ;
        "  chkCarne=" + TRANSFORM(loForm.chk_4c_ChkCarne.Visible) + CHR(13) + CHR(10), lcLog, 1)
    loForm.Release()
    loForm = .NULL.
CATCH TO loErr
    STRTOFILE("   EXCECAO: " + loErr.Message + " LN=" + TRANSFORM(loErr.LineNo) + ;
        " PROC=" + loErr.Procedure + CHR(13) + CHR(10), lcLog, 1)
ENDTRY

STRTOFILE(CHR(13) + CHR(10) + "=== FIM ===" + CHR(13) + CHR(10), lcLog, 1)
QUIT

*==============================================================================
* _probe780f5.prg - Probe de instanciacao da Fase 5 do Formsigoppei (task780)
*
* Prova que a tela ABRE com os 4 objetos novos do bloco de produto e confere,
* objeto a objeto, as propriedades transcritas do SCX.
*
* Aberto SEM form pai de proposito: sem xBaixa2 o CarregarLista devolve .F.
* ANTES de qualquer SQLEXEC (a guarda eh USED(xBaixa2)), entao o probe nao
* toca no SQL Server - que eh inalcancavel nesta maquina.
*==============================================================================
SET SAFETY OFF
SET RESOURCE OFF

PUBLIC gb_4c_ModoTeste, gc_4c_ArquivoErroTeste, gb_4c_ValidandoUI, gnConnHandle
gb_4c_ModoTeste        = .T.
gc_4c_ArquivoErroTeste = "C:\4c\automation\_probe780f5_dialogs.txt"
gb_4c_ValidandoUI      = .F.
gnConnHandle           = 0

LOCAL lcOut, lcCk, loForm, lnI, lcR, loTx
lcCk  = "C:\4c\automation\_probe780f5_ck.txt"
lcOut = "C:\4c\automation\_probe780f5_out.txt"

ON ERROR STRTOFILE("ON ERROR: " + MESSAGE() + " / LINENO=" + TRANSFORM(LINENO()) + ;
    " / PROG=" + PROGRAM() + CHR(13) + CHR(10), lcCk, .T.)

STRTOFILE("CK1 inicio" + CHR(13) + CHR(10), lcCk)
CD C:\4c\projeto\app\start
DO config.prg
STRTOFILE("CK2 config.prg ok" + CHR(13) + CHR(10), lcCk, .T.)
ConfigurarAmbiente()
STRTOFILE("CK3 ConfigurarAmbiente ok" + CHR(13) + CHR(10), lcCk, .T.)
GarantirClasse("Formsigoppei")
STRTOFILE("CK4 GarantirClasse ok" + CHR(13) + CHR(10), lcCk, .T.)

loForm = CREATEOBJECT("Formsigoppei")
STRTOFILE("CK5 CREATEOBJECT VARTYPE=" + VARTYPE(loForm) + CHR(13) + CHR(10), lcCk, .T.)

lcR = "VARTYPE(loForm)=" + VARTYPE(loForm) + CHR(13) + CHR(10)

IF VARTYPE(loForm) = "O"
    lcR = lcR + "Caption=[" + loForm.Caption + "]" + CHR(13) + CHR(10)
    lcR = lcR + "Form WxH=" + TRANSFORM(loForm.Width) + "x" + TRANSFORM(loForm.Height) + CHR(13) + CHR(10)
    lcR = lcR + "ControlCount=" + TRANSFORM(loForm.ControlCount) + CHR(13) + CHR(10)

    lcR = lcR + CHR(13) + CHR(10) + "--- controles do form (ordem de AddObject = z-order) ---" + CHR(13) + CHR(10)
    FOR lnI = 1 TO loForm.ControlCount
        lcR = lcR + PADR(TRANSFORM(lnI), 3) + PADR(loForm.Controls(lnI).Name, 20) + ;
              PADR(loForm.Controls(lnI).BaseClass, 15) + ;
              "T=" + PADL(TRANSFORM(loForm.Controls(lnI).Top), 4) + ;
              " L=" + PADL(TRANSFORM(loForm.Controls(lnI).Left), 4) + ;
              " W=" + PADL(TRANSFORM(loForm.Controls(lnI).Width), 4) + ;
              " H=" + PADL(TRANSFORM(loForm.Controls(lnI).Height), 4) + ;
              " Vis=" + IIF(loForm.Controls(lnI).Visible, "T", "F") + CHR(13) + CHR(10)
    ENDFOR

    lcR = lcR + CHR(13) + CHR(10) + "--- metodos da Fase 5 ---" + CHR(13) + CHR(10)
    lcR = lcR + "ConfigurarPaginaDados  exists=" + IIF(PEMSTATUS(loForm, "ConfigurarPaginaDados", 5), "T", "F") + ;
          " protected=" + IIF(PEMSTATUS(loForm, "ConfigurarPaginaDados", 2), "T", "F") + CHR(13) + CHR(10)
    lcR = lcR + "VincularCamposProduto  exists=" + IIF(PEMSTATUS(loForm, "VincularCamposProduto", 5), "T", "F") + ;
          " protected=" + IIF(PEMSTATUS(loForm, "VincularCamposProduto", 2), "T", "F") + CHR(13) + CHR(10)

    lcR = lcR + CHR(13) + CHR(10) + "--- lbl_4c_Label5 (Say5 Produto) ---" + CHR(13) + CHR(10)
    loTx = loForm.lbl_4c_Label5
    lcR = lcR + "Caption=[" + loTx.Caption + "] T=" + TRANSFORM(loTx.Top) + " L=" + TRANSFORM(loTx.Left) + ;
          " W=" + TRANSFORM(loTx.Width) + " H=" + TRANSFORM(loTx.Height) + CHR(13) + CHR(10)
    lcR = lcR + "AutoSize=" + IIF(loTx.AutoSize, "T", "F") + " Alignment=" + TRANSFORM(loTx.Alignment) + ;
          " BackStyle=" + TRANSFORM(loTx.BackStyle) + " ForeColor=" + TRANSFORM(loTx.ForeColor) + ;
          " Font=" + loTx.FontName + "/" + TRANSFORM(loTx.FontSize) + ;
          " TabIndex=" + TRANSFORM(loTx.TabIndex) + " Vis=" + IIF(loTx.Visible, "T", "F") + CHR(13) + CHR(10)

    lcR = lcR + CHR(13) + CHR(10) + "--- lbl_4c_Label2 (Say2 Descricao) ---" + CHR(13) + CHR(10)
    loTx = loForm.lbl_4c_Label2
    lcR = lcR + "Caption=[" + loTx.Caption + "] T=" + TRANSFORM(loTx.Top) + " L=" + TRANSFORM(loTx.Left) + ;
          " W=" + TRANSFORM(loTx.Width) + " H=" + TRANSFORM(loTx.Height) + CHR(13) + CHR(10)
    lcR = lcR + "AutoSize=" + IIF(loTx.AutoSize, "T", "F") + " Alignment=" + TRANSFORM(loTx.Alignment) + ;
          " BackStyle=" + TRANSFORM(loTx.BackStyle) + " ForeColor=" + TRANSFORM(loTx.ForeColor) + ;
          " Font=" + loTx.FontName + "/" + TRANSFORM(loTx.FontSize) + ;
          " TabIndex=" + TRANSFORM(loTx.TabIndex) + " Vis=" + IIF(loTx.Visible, "T", "F") + CHR(13) + CHR(10)

    lcR = lcR + CHR(13) + CHR(10) + "--- txt_4c_CProd (getCProd) ---" + CHR(13) + CHR(10)
    loTx = loForm.txt_4c_CProd
    lcR = lcR + "T=" + TRANSFORM(loTx.Top) + " L=" + TRANSFORM(loTx.Left) + ;
          " W=" + TRANSFORM(loTx.Width) + " H=" + TRANSFORM(loTx.Height) + ;
          " Vis=" + IIF(loTx.Visible, "T", "F") + CHR(13) + CHR(10)
    lcR = lcR + "ControlSource=[" + loTx.ControlSource + "] VARTYPE(Value)=" + VARTYPE(loTx.Value) + ;
          " Value=[" + TRANSFORM(loTx.Value) + "]" + CHR(13) + CHR(10)
    lcR = lcR + "MaxLength=" + TRANSFORM(loTx.MaxLength) + " ReadOnly=" + IIF(loTx.ReadOnly, "T", "F") + ;
          " TabStop=" + IIF(loTx.TabStop, "T", "F") + " TabIndex=" + TRANSFORM(loTx.TabIndex) + ;
          " Alignment=" + TRANSFORM(loTx.Alignment) + " SpecialEffect=" + TRANSFORM(loTx.SpecialEffect) + CHR(13) + CHR(10)
    lcR = lcR + "Format=[" + loTx.Format + "] InputMask=[" + loTx.InputMask + "]" + ;
          " BorderColor=" + TRANSFORM(loTx.BorderColor) + ;
          " DisabledBackColor=" + TRANSFORM(loTx.DisabledBackColor) + ;
          " ToolTipText=[" + loTx.ToolTipText + "]" + CHR(13) + CHR(10)

    lcR = lcR + CHR(13) + CHR(10) + "--- txt_4c_DProd (getDProd) ---" + CHR(13) + CHR(10)
    loTx = loForm.txt_4c_DProd
    lcR = lcR + "T=" + TRANSFORM(loTx.Top) + " L=" + TRANSFORM(loTx.Left) + ;
          " W=" + TRANSFORM(loTx.Width) + " H=" + TRANSFORM(loTx.Height) + ;
          " Vis=" + IIF(loTx.Visible, "T", "F") + CHR(13) + CHR(10)
    lcR = lcR + "ControlSource=[" + loTx.ControlSource + "] VARTYPE(Value)=" + VARTYPE(loTx.Value) + ;
          " Value=[" + TRANSFORM(loTx.Value) + "]" + CHR(13) + CHR(10)
    lcR = lcR + "MaxLength=" + TRANSFORM(loTx.MaxLength) + " ReadOnly=" + IIF(loTx.ReadOnly, "T", "F") + ;
          " TabStop=" + IIF(loTx.TabStop, "T", "F") + " TabIndex=" + TRANSFORM(loTx.TabIndex) + ;
          " Font=" + loTx.FontName + "/" + TRANSFORM(loTx.FontSize) + CHR(13) + CHR(10)
    lcR = lcR + "Format=[" + loTx.Format + "] BackColor=" + TRANSFORM(loTx.BackColor) + ;
          " DisabledForeColor=" + TRANSFORM(loTx.DisabledForeColor) + ;
          " ToolTipText=[" + loTx.ToolTipText + "]" + CHR(13) + CHR(10)

    *-- O cursor da grade e o espelho de CarregarLista (sem pai = sem xBaixa2)
    lcR = lcR + CHR(13) + CHR(10) + "--- cursor / recarga ---" + CHR(13) + CHR(10)
    lcR = lcR + "cursor itens=[" + loForm.this_oBusinessObject.this_cCursorItens + "] USED=" + ;
          IIF(USED(loForm.this_oBusinessObject.this_cCursorItens), "T", "F") + CHR(13) + CHR(10)
    lcR = lcR + "CarregarLista() 2a vez=" + IIF(loForm.CarregarLista(), "T", "F") + ;
          " (esperado F: sem form pai nao existe xBaixa2)" + CHR(13) + CHR(10)
    lcR = lcR + "ControlSource pos-recarga CProd=[" + loForm.txt_4c_CProd.ControlSource + ;
          "] DProd=[" + loForm.txt_4c_DProd.ControlSource + "]" + CHR(13) + CHR(10)
    lcR = lcR + "Vis pos-recarga CProd=" + IIF(loForm.txt_4c_CProd.Visible, "T", "F") + ;
          " DProd=" + IIF(loForm.txt_4c_DProd.Visible, "T", "F") + ;
          " Label5=" + IIF(loForm.lbl_4c_Label5.Visible, "T", "F") + ;
          " Label2=" + IIF(loForm.lbl_4c_Label2.Visible, "T", "F") + CHR(13) + CHR(10)

    loForm.Release()
ENDIF

STRTOFILE(lcR, lcOut)
STRTOFILE("CK6 fim" + CHR(13) + CHR(10), lcCk, .T.)
QUIT

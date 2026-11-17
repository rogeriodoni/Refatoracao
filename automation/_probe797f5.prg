*==============================================================================
* _probe797f5.prg - Probe de instanciacao da Fase 5 do FormSIGOPRPS (task797)
*
* Prova (a) que a tela ABRE com os 6 objetos novos (3 pares label/campo),
* (b) que cada propriedade transcrita do SCX chegou ao objeto e (c) que
* BOParaForm de fato leva os parametros de abertura para dentro dos campos.
*
* gb_4c_ModoTeste = .T. faz o InicializarForm PULAR o CarregarDados, entao o
* probe nao toca no SQL Server - que eh inalcancavel nesta maquina.
*==============================================================================
SET SAFETY OFF
SET RESOURCE OFF

PUBLIC gb_4c_ModoTeste, gc_4c_ArquivoErroTeste, gb_4c_ValidandoUI, gnConnHandle
gb_4c_ModoTeste        = .T.
gc_4c_ArquivoErroTeste = "C:\4c\automation\_probe797f5_dialogs.txt"
gb_4c_ValidandoUI      = .F.
gnConnHandle           = 0

LOCAL lcOut, lcCk, loForm, lnI, lcR, loTx

lcCk  = "C:\4c\automation\_probe797f5_ck.txt"
lcOut = "C:\4c\automation\_probe797f5_out.txt"

ON ERROR STRTOFILE("ON ERROR: " + MESSAGE() + " / LINENO=" + TRANSFORM(LINENO()) + ;
    " / PROG=" + PROGRAM() + CHR(13) + CHR(10), lcCk, .T.)

STRTOFILE("CK1 inicio" + CHR(13) + CHR(10), lcCk)
CD C:\4c\projeto\app\start
DO config.prg
STRTOFILE("CK2 config.prg ok" + CHR(13) + CHR(10), lcCk, .T.)
ConfigurarAmbiente()
STRTOFILE("CK3 ConfigurarAmbiente ok" + CHR(13) + CHR(10), lcCk, .T.)
GarantirClasse("FormSIGOPRPS")
STRTOFILE("CK4 GarantirClasse ok" + CHR(13) + CHR(10), lcCk, .T.)

*-- Parametros reais de abertura, iguais aos que o form chamador passa
loForm = CREATEOBJECT("FormSIGOPRPS", "001", "RPS", "A1", 4567, "MALOTE", 33)
STRTOFILE("CK5 CREATEOBJECT VARTYPE=" + VARTYPE(loForm) + CHR(13) + CHR(10), lcCk, .T.)

lcR = "VARTYPE(loForm)=" + VARTYPE(loForm) + CHR(13) + CHR(10)

IF VARTYPE(loForm) = "O"
    lcR = lcR + "Caption=[" + loForm.Caption + "]" + CHR(13) + CHR(10)
    lcR = lcR + "Form WxH=" + TRANSFORM(loForm.Width) + "x" + TRANSFORM(loForm.Height) + CHR(13) + CHR(10)
    lcR = lcR + "ControlCount=" + TRANSFORM(loForm.ControlCount) + CHR(13) + CHR(10)

    lcR = lcR + CHR(13) + CHR(10) + "--- controles do form (ordem de AddObject = z-order) ---" + CHR(13) + CHR(10)
    FOR lnI = 1 TO loForm.ControlCount
        lcR = lcR + PADR(TRANSFORM(lnI), 3) + PADR(loForm.Controls(lnI).Name, 20) + ;
              PADR(loForm.Controls(lnI).BaseClass, 14) + ;
              "T=" + PADL(TRANSFORM(loForm.Controls(lnI).Top), 4) + ;
              " L=" + PADL(TRANSFORM(loForm.Controls(lnI).Left), 4) + ;
              " W=" + PADL(TRANSFORM(loForm.Controls(lnI).Width), 4) + ;
              " H=" + PADL(TRANSFORM(loForm.Controls(lnI).Height), 4) + ;
              " Vis=" + IIF(loForm.Controls(lnI).Visible, "T", "F") + CHR(13) + CHR(10)
    ENDFOR

    lcR = lcR + CHR(13) + CHR(10) + "--- metodos da Fase 5 ---" + CHR(13) + CHR(10)
    lcR = lcR + "ConfigurarCamposIdentificacao exists=" + ;
          IIF(PEMSTATUS(loForm, "ConfigurarCamposIdentificacao", 5), "T", "F") + ;
          " protected=" + IIF(PEMSTATUS(loForm, "ConfigurarCamposIdentificacao", 2), "T", "F") + CHR(13) + CHR(10)
    lcR = lcR + "BOParaForm                    exists=" + ;
          IIF(PEMSTATUS(loForm, "BOParaForm", 5), "T", "F") + ;
          " protected=" + IIF(PEMSTATUS(loForm, "BOParaForm", 2), "T", "F") + CHR(13) + CHR(10)

    *-- Os 3 labels (Say6/Say3/Say4) - geometria, cor e fonte
    FOR lnI = 1 TO 3
        loTx = EVALUATE("loForm.lbl_4c_Label" + GETWORDNUM("6 3 4", lnI))
        lcR = lcR + CHR(13) + CHR(10) + "--- " + loTx.Name + " ---" + CHR(13) + CHR(10)
        lcR = lcR + "Caption=[" + loTx.Caption + "] T=" + TRANSFORM(loTx.Top) + ;
              " L=" + TRANSFORM(loTx.Left) + " W=" + TRANSFORM(loTx.Width) + ;
              " H=" + TRANSFORM(loTx.Height) + " fim do texto em " + ;
              TRANSFORM(loTx.Left + loTx.Width) + CHR(13) + CHR(10)
        lcR = lcR + "AutoSize=" + IIF(loTx.AutoSize, "T", "F") + ;
              " Alignment=" + TRANSFORM(loTx.Alignment) + ;
              " BackStyle=" + TRANSFORM(loTx.BackStyle) + ;
              " WordWrap=" + IIF(loTx.WordWrap, "T", "F") + ;
              " ForeColor=" + TRANSFORM(loTx.ForeColor) + ;
              " Font=" + loTx.FontName + "/" + TRANSFORM(loTx.FontSize) + ;
              " TabIndex=" + TRANSFORM(loTx.TabIndex) + ;
              " Vis=" + IIF(loTx.Visible, "T", "F") + CHR(13) + CHR(10)
    ENDFOR

    *-- Os 3 TextBox (get_Emps/get_Tipos/get_Series)
    FOR lnI = 1 TO 3
        loTx = EVALUATE("loForm.txt_4c__" + GETWORDNUM("Emps Tipos Series", lnI))
        lcR = lcR + CHR(13) + CHR(10) + "--- " + loTx.Name + " ---" + CHR(13) + CHR(10)
        lcR = lcR + "T=" + TRANSFORM(loTx.Top) + " L=" + TRANSFORM(loTx.Left) + ;
              " W=" + TRANSFORM(loTx.Width) + " H=" + TRANSFORM(loTx.Height) + ;
              " Vis=" + IIF(loTx.Visible, "T", "F") + CHR(13) + CHR(10)
        lcR = lcR + "VARTYPE(Value)=" + VARTYPE(loTx.Value) + ;
              " Value=[" + TRANSFORM(loTx.Value) + "]" + CHR(13) + CHR(10)
        lcR = lcR + "MaxLength=" + TRANSFORM(loTx.MaxLength) + ;
              " ReadOnly=" + IIF(loTx.ReadOnly, "T", "F") + ;
              " TabStop=" + IIF(loTx.TabStop, "T", "F") + ;
              " Enabled=" + IIF(loTx.Enabled, "T", "F") + ;
              " TabIndex=" + TRANSFORM(loTx.TabIndex) + ;
              " Alignment=" + TRANSFORM(loTx.Alignment) + ;
              " ForeColor=" + TRANSFORM(loTx.ForeColor) + ;
              " Font=" + loTx.FontName + "/" + TRANSFORM(loTx.FontSize) + CHR(13) + CHR(10)
        lcR = lcR + "Format=[" + loTx.Format + "] InputMask=[" + loTx.InputMask + "]" + CHR(13) + CHR(10)
    ENDFOR

    *-- BOParaForm: o valor na tela tem de ser o parametro de abertura
    lcR = lcR + CHR(13) + CHR(10) + "--- BOParaForm: parametro -> BO -> tela ---" + CHR(13) + CHR(10)
    lcR = lcR + "BO   Emps=[" + loForm.this_oBusinessObject.this_cEmps + "]" + ;
          " Tipos=[" + loForm.this_oBusinessObject.this_cTipos + "]" + ;
          " Series=[" + loForm.this_oBusinessObject.this_cSeries + "]" + CHR(13) + CHR(10)
    lcR = lcR + "TELA Emps=[" + loForm.txt_4c__Emps.Value + "]" + ;
          " Tipos=[" + loForm.txt_4c__Tipos.Value + "]" + ;
          " Series=[" + loForm.txt_4c__Series.Value + "]" + CHR(13) + CHR(10)
    lcR = lcR + "esperado: 001 / RPS / A1" + CHR(13) + CHR(10)

    *-- Sobreposicao label x campo DENTRO do form (todos tem o mesmo pai)
    lcR = lcR + CHR(13) + CHR(10) + "--- sobreposicao label x campo (regra #23/#28) ---" + CHR(13) + CHR(10)
    lcR = lcR + "Label6 fim=" + TRANSFORM(loForm.lbl_4c_Label6.Left + loForm.lbl_4c_Label6.Width) + ;
          " < Emps Left=" + TRANSFORM(loForm.txt_4c__Emps.Left) + " ? " + ;
          IIF(loForm.lbl_4c_Label6.Left + loForm.lbl_4c_Label6.Width <= loForm.txt_4c__Emps.Left, "OK", "SOBREPOE") + CHR(13) + CHR(10)
    lcR = lcR + "Emps fim=" + TRANSFORM(loForm.txt_4c__Emps.Left + loForm.txt_4c__Emps.Width) + ;
          " < Label3 Left=" + TRANSFORM(loForm.lbl_4c_Label3.Left) + " ? " + ;
          IIF(loForm.txt_4c__Emps.Left + loForm.txt_4c__Emps.Width <= loForm.lbl_4c_Label3.Left, "OK", "SOBREPOE") + CHR(13) + CHR(10)
    lcR = lcR + "Label3 fim=" + TRANSFORM(loForm.lbl_4c_Label3.Left + loForm.lbl_4c_Label3.Width) + ;
          " < Tipos Left=" + TRANSFORM(loForm.txt_4c__Tipos.Left) + " ? " + ;
          IIF(loForm.lbl_4c_Label3.Left + loForm.lbl_4c_Label3.Width <= loForm.txt_4c__Tipos.Left, "OK", "SOBREPOE") + CHR(13) + CHR(10)
    lcR = lcR + "Tipos fim=" + TRANSFORM(loForm.txt_4c__Tipos.Left + loForm.txt_4c__Tipos.Width) + ;
          " < Label4 Left=" + TRANSFORM(loForm.lbl_4c_Label4.Left) + " ? " + ;
          IIF(loForm.txt_4c__Tipos.Left + loForm.txt_4c__Tipos.Width <= loForm.lbl_4c_Label4.Left, "OK", "SOBREPOE") + CHR(13) + CHR(10)
    lcR = lcR + "Label4 fim=" + TRANSFORM(loForm.lbl_4c_Label4.Left + loForm.lbl_4c_Label4.Width) + ;
          " < Series Left=" + TRANSFORM(loForm.txt_4c__Series.Left) + " ? " + ;
          IIF(loForm.lbl_4c_Label4.Left + loForm.lbl_4c_Label4.Width <= loForm.txt_4c__Series.Left, "OK", "SOBREPOE") + CHR(13) + CHR(10)

    *-- Campos DENTRO da moldura Shape1 (T=94..159, L=65..585) e do form
    lcR = lcR + CHR(13) + CHR(10) + "--- campos dentro da moldura e do form (regra #30) ---" + CHR(13) + CHR(10)
    lcR = lcR + "Shape1 T=" + TRANSFORM(loForm.shp_4c_Shape1.Top) + ".." + ;
          TRANSFORM(loForm.shp_4c_Shape1.Top + loForm.shp_4c_Shape1.Height) + ;
          " L=" + TRANSFORM(loForm.shp_4c_Shape1.Left) + ".." + ;
          TRANSFORM(loForm.shp_4c_Shape1.Left + loForm.shp_4c_Shape1.Width) + CHR(13) + CHR(10)
    lcR = lcR + "Series fim L=" + TRANSFORM(loForm.txt_4c__Series.Left + loForm.txt_4c__Series.Width) + ;
          " <= Form.Width=" + TRANSFORM(loForm.Width) + " ? " + ;
          IIF(loForm.txt_4c__Series.Left + loForm.txt_4c__Series.Width <= loForm.Width, "OK", "FORA") + CHR(13) + CHR(10)
    lcR = lcR + "Label6 Top=" + TRANSFORM(loForm.lbl_4c_Label6.Top) + ;
          " > cabecalho fim=" + TRANSFORM(loForm.cnt_4c_Cabecalho.Top + loForm.cnt_4c_Cabecalho.Height) + " ? " + ;
          IIF(loForm.lbl_4c_Label6.Top >= loForm.cnt_4c_Cabecalho.Top + loForm.cnt_4c_Cabecalho.Height, "OK", "SOB A FAIXA") + CHR(13) + CHR(10)

    loForm.Release()
    STRTOFILE("CK6 Release ok" + CHR(13) + CHR(10), lcCk, .T.)
ENDIF

*-- 2a instancia SEM parametro nenhum: o form tem de abrir igual (os guards
*-- de VARTYPE do Init) e os campos ficam vazios, nao estouram
loForm = CREATEOBJECT("FormSIGOPRPS")
lcR = lcR + CHR(13) + CHR(10) + "--- 2a instancia SEM parametros ---" + CHR(13) + CHR(10)
lcR = lcR + "VARTYPE=" + VARTYPE(loForm) + CHR(13) + CHR(10)
IF VARTYPE(loForm) = "O"
    lcR = lcR + "ControlCount=" + TRANSFORM(loForm.ControlCount) + ;
          " Emps=[" + loForm.txt_4c__Emps.Value + "]" + ;
          " Tipos=[" + loForm.txt_4c__Tipos.Value + "]" + ;
          " Series=[" + loForm.txt_4c__Series.Value + "]" + CHR(13) + CHR(10)
    loForm.Release()
ENDIF

STRTOFILE(lcR, lcOut)
STRTOFILE("CK7 fim" + CHR(13) + CHR(10), lcCk, .T.)
QUIT

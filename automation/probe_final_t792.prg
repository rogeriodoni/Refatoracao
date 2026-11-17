SET SAFETY OFF
SET RESOURCE OFF
#DEFINE SAIDA "C:\4c\automation\probe_final_t792.txt"
LOCAL loF, loc_oErro
CD C:\4c\projeto\app\start
DO config.prg
= ConfigurarAmbiente()
PUBLIC gb_4c_ModoTeste, gb_4c_ValidandoUI, gc_4c_ArquivoErroTeste
gb_4c_ModoTeste   = .T.
gb_4c_ValidandoUI = .T.
gc_4c_ArquivoErroTeste = "C:\4c\automation\erro_final_t792.txt"
= GarantirClasse("FormSigOpQtE")
STRTOFILE("F0 ambiente+classe ok" + CHR(13) + CHR(10), SAIDA)

loF = CREATEOBJECT("FormSigOpQtE", "0000000001")
STRTOFILE("F1 VARTYPE=" + VARTYPE(loF) + CHR(13) + CHR(10), SAIDA, 1)

STRTOFILE("F2 Caption=[" + loF.Caption + "]" + CHR(13) + CHR(10), SAIDA, 1)
STRTOFILE("F3 cmg_4c_Saida=" + TRANSFORM(PEMSTATUS(loF, "cmg_4c_Saida", 5)) + ;
    "  BtnSairClick=" + TRANSFORM(PEMSTATUS(loF, "BtnSairClick", 5)) + ;
    "  protegido=" + TRANSFORM(PEMSTATUS(loF, "BtnSairClick", 2)) + CHR(13) + CHR(10), SAIDA, 1)
STRTOFILE("F4 grupo L=" + TRANSFORM(loF.cmg_4c_Saida.Left) + ;
    " T=" + TRANSFORM(loF.cmg_4c_Saida.Top) + ;
    " W=" + TRANSFORM(loF.cmg_4c_Saida.Width) + ;
    " H=" + TRANSFORM(loF.cmg_4c_Saida.Height) + ;
    " Vis=" + TRANSFORM(loF.cmg_4c_Saida.Visible) + CHR(13) + CHR(10), SAIDA, 1)
STRTOFILE("F5 botao " + loF.cmg_4c_Saida.Buttons(1).Name + ;
    " [" + loF.cmg_4c_Saida.Buttons(1).Caption + "]" + ;
    " Cancel=" + TRANSFORM(loF.cmg_4c_Saida.Buttons(1).Cancel) + ;
    " Vis=" + TRANSFORM(loF.cmg_4c_Saida.Buttons(1).Visible) + ;
    " dir=" + TRANSFORM(loF.cmg_4c_Saida.Left + loF.cmg_4c_Saida.Buttons(1).Left + loF.cmg_4c_Saida.Buttons(1).Width) + CHR(13) + CHR(10), SAIDA, 1)
STRTOFILE("F6 pict existe=" + TRANSFORM(FILE(loF.cmg_4c_Saida.Buttons(1).Picture)) + ;
    " [" + loF.cmg_4c_Saida.Buttons(1).Picture + "]" + CHR(13) + CHR(10), SAIDA, 1)
STRTOFILE("F7 tab cmg=" + TRANSFORM(loF.cmg_4c_Saida.TabIndex) + ;
    " txt=" + TRANSFORM(loF.txt_4c_Text1.TabIndex) + ;
    " cnt=" + TRANSFORM(loF.cnt_4c_Sombra.TabIndex) + ;
    " lbl=" + TRANSFORM(loF.lbl_4c_Label1.TabIndex) + CHR(13) + CHR(10), SAIDA, 1)

*-- fio do valor: campo -> BO -> PUBLIC (o que o BtnSairClick garante na saida por ESC)
loF.txt_4c_Text1.Value = 250
STRTOFILE("F8 antes: BO=" + TRANSFORM(loF.this_oBusinessObject.this_nQtEtiq) + ;
    " _QtEtiq=" + TRANSFORM(_QtEtiq) + CHR(13) + CHR(10), SAIDA, 1)
loF.QuantidadeInteractiveChange()
STRTOFILE("F9 apos handler: BO=" + TRANSFORM(loF.this_oBusinessObject.this_nQtEtiq) + ;
    " _QtEtiq=" + TRANSFORM(_QtEtiq) + CHR(13) + CHR(10), SAIDA, 1)

*-- BtnSairClick por ULTIMO: ele chama Release(), que em headless pode nao retornar
loF.BtnSairClick()
STRTOFILE("F10 apos BtnSairClick: _QtEtiq=" + TRANSFORM(_QtEtiq) + CHR(13) + CHR(10), SAIDA, 1)
QUIT

*-- medir_tabindex_sigprdft.prg
*-- Mede no VFP9: (a) TabIndex eh gravavel em runtime nos controles do
*-- Formsigprdft; (b) atribuir em ordem ASCENDENTE produz a sequencia
*-- pretendida; (c) CommandGroup aceita BackStyle = 0.
SET SAFETY OFF
SET RESOURCE OFF

LOCAL loc_cSaida, loc_oF, loc_nI, loc_cNome
loc_cSaida = ""

loc_oF = CREATEOBJECT("Form")
loc_oF.Width  = 500
loc_oF.Height = 370

*-- mesma ORDEM DE CRIACAO do Formsigprdft atual
loc_oF.AddObject("cnt_4c_Cabecalho",     "Container")
loc_oF.AddObject("shp_4c_Shape2",        "Shape")
loc_oF.AddObject("lbl_4c_Label5",        "Label")
loc_oF.AddObject("txt_4c_Valor",         "TextBox")
loc_oF.AddObject("lbl_4c_Label2",        "Label")
loc_oF.AddObject("txt_4c_Digitos",       "TextBox")
loc_oF.AddObject("lbl_4c_Label8",        "Label")
loc_oF.AddObject("txt_4c_Cartao",        "TextBox")
loc_oF.AddObject("cnt_4c_Container1",    "Container")
loc_oF.AddObject("lbl_4c_Label11",       "Label")
loc_oF.AddObject("txt_4c_Datas",         "TextBox")
loc_oF.AddObject("lbl_4c_Label4",        "Label")
loc_oF.AddObject("obj_4c_Optiongroup1",  "OptionGroup")
loc_oF.AddObject("lbl_4c_Label6",        "Label")
loc_oF.AddObject("txt_4c_Text1",         "TextBox")
loc_oF.AddObject("obj_4c_SAIDA",         "CommandGroup")

loc_cSaida = loc_cSaida + "=== ANTES (TabIndex pela ordem de criacao) ===" + CHR(13) + CHR(10)
FOR loc_nI = 1 TO loc_oF.ControlCount
    loc_cNome = loc_oF.Controls(loc_nI).Name
    IF PEMSTATUS(loc_oF.Controls(loc_nI), "TabIndex", 5)
        loc_cSaida = loc_cSaida + PADR(loc_cNome, 26) + ;
            " TabIndex=" + TRANSFORM(loc_oF.Controls(loc_nI).TabIndex) + CHR(13) + CHR(10)
    ELSE
        loc_cSaida = loc_cSaida + PADR(loc_cNome, 26) + " <SEM TabIndex>" + CHR(13) + CHR(10)
    ENDIF
ENDFOR

*-- (a)+(b) atribuir em ordem ASCENDENTE na sequencia do legado
LOCAL loc_lOk, loc_oErro
loc_lOk = .T.
TRY
    loc_oF.txt_4c_Valor.TabIndex        = 1
    loc_oF.txt_4c_Cartao.TabIndex       = 2
    loc_oF.txt_4c_Digitos.TabIndex      = 3
    loc_oF.obj_4c_Optiongroup1.TabIndex = 4
    loc_oF.txt_4c_Text1.TabIndex        = 5
    loc_oF.txt_4c_Datas.TabIndex        = 6
    loc_oF.obj_4c_SAIDA.TabIndex        = 7
CATCH TO loc_oErro
    loc_lOk = .F.
    loc_cSaida = loc_cSaida + "ERRO ao gravar TabIndex: " + loc_oErro.Message + CHR(13) + CHR(10)
ENDTRY

loc_cSaida = loc_cSaida + CHR(13) + CHR(10) + ;
    "=== DEPOIS (gravavel em runtime? " + IIF(loc_lOk, "SIM", "NAO") + ") ===" + CHR(13) + CHR(10)
FOR loc_nI = 1 TO loc_oF.ControlCount
    IF PEMSTATUS(loc_oF.Controls(loc_nI), "TabIndex", 5)
        loc_cSaida = loc_cSaida + PADR(loc_oF.Controls(loc_nI).Name, 26) + ;
            " TabIndex=" + TRANSFORM(loc_oF.Controls(loc_nI).TabIndex) + CHR(13) + CHR(10)
    ENDIF
ENDFOR

*-- (c) CommandGroup aceita BackStyle = 0 ?
LOCAL loc_cBs
TRY
    loc_oF.obj_4c_SAIDA.BackStyle = 0
    loc_cBs = "OK - CommandGroup.BackStyle = " + TRANSFORM(loc_oF.obj_4c_SAIDA.BackStyle)
CATCH TO loc_oErro
    loc_cBs = "ERRO: " + loc_oErro.Message
ENDTRY
loc_cSaida = loc_cSaida + CHR(13) + CHR(10) + "=== CommandGroup.BackStyle ===" + CHR(13) + CHR(10) + ;
    loc_cBs + CHR(13) + CHR(10)

*-- CommandButton tem BackStyle? (para confirmar a assimetria)
loc_oF.obj_4c_SAIDA.ButtonCount = 1
loc_cSaida = loc_cSaida + "CommandButton tem BackStyle: " + ;
    TRANSFORM(PEMSTATUS(loc_oF.obj_4c_SAIDA.Buttons(1), "BackStyle", 5)) + CHR(13) + CHR(10)
loc_cSaida = loc_cSaida + "Label tem TabStop: " + ;
    TRANSFORM(PEMSTATUS(loc_oF.lbl_4c_Label5, "TabStop", 5)) + CHR(13) + CHR(10)

STRTOFILE(loc_cSaida, "C:\4c\automation\medir_tabindex_sigprdft.txt")
loc_oF = .NULL.
QUIT

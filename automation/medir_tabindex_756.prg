SET SAFETY OFF
SET RESOURCE OFF
LOCAL loc_cOut, loF, i
loc_cOut = ""

*-- ============ PARTE A: simular o LOAD do SCX legado ============
*-- Ordem dos REGISTROS do SCX (SECAO 1), filhos DIRETOS do form.
*-- O TabIndex gravado eh aplicado LOGO APOS o AddObject do objeto,
*-- que eh o que o VFP faz ao carregar o .scx.
loF = CREATEOBJECT("Form")
loF.AddObject("cntSombra", "Container")
loF.AddObject("Grade", "Grid")
loF.Grade.TabIndex = 4                && <<< o unico TabIndex do dump
loc_cOut = loc_cOut + "A1 Grade.TabIndex logo apos AddObject (2 filhos) = " + ;
           TRANSFORM(loF.Grade.TabIndex) + CHR(13) + CHR(10)
loF.AddObject("Say1", "Label")
loF.AddObject("Shape4", "Shape")
loF.AddObject("Say2", "Label")
loF.AddObject("Say3", "Label")
loF.AddObject("Say4", "Label")
loF.AddObject("Say5", "Label")
loF.AddObject("get_limcred", "TextBox")
loF.AddObject("get_pendente", "TextBox")
loF.AddObject("get_contac", "TextBox")
loF.AddObject("get_cheque", "TextBox")
loF.AddObject("get_disponivel", "TextBox")
loF.AddObject("Say6", "Label")
loF.AddObject("get_moeda", "TextBox")
loF.AddObject("Say7", "Label")
loF.AddObject("get_chqpend", "TextBox")
loF.AddObject("get_nconta", "Label")
loF.AddObject("Say8", "Label")
loF.AddObject("get_cotacao", "TextBox")
loF.AddObject("Say9", "Label")
loF.AddObject("get_PendOutr", "TextBox")
loF.AddObject("ok", "CommandButton")
loc_cOut = loc_cOut + "A2 Grade.TabIndex no FIM do load          = " + ;
           TRANSFORM(loF.Grade.TabIndex) + CHR(13) + CHR(10)
loc_cOut = loc_cOut + "A3 cntSombra / ok                         = " + ;
           TRANSFORM(loF.cntSombra.TabIndex) + " / " + TRANSFORM(loF.ok.TabIndex) + ;
           CHR(13) + CHR(10)
loc_cOut = loc_cOut + "A4 Shape4 tem TabIndex?                   = " + ;
           TRANSFORM(PEMSTATUS(loF.Shape4, "TabIndex", 5)) + CHR(13) + CHR(10)
loc_cOut = loc_cOut + "A5 Shape4 tem TabStop?                    = " + ;
           TRANSFORM(PEMSTATUS(loF.Shape4, "TabStop", 5)) + CHR(13) + CHR(10)
loc_cOut = loc_cOut + "A6 ControlCount                           = " + ;
           TRANSFORM(loF.ControlCount) + CHR(13) + CHR(10)
loF = .NULL.

*-- ============ PARTE B: ordem de criacao do MIGRADO ============
*-- cnt_4c_Sombra, grd_4c_Dados, depois campos, botao por ULTIMO.
loF = CREATEOBJECT("Form")
loF.AddObject("cnt_4c_Sombra", "Container")
loF.AddObject("grd_4c_Dados", "Grid")
loF.AddObject("lbl_4c_Get_nconta", "Label")
loF.AddObject("shp_4c_Shape4", "Shape")
FOR i = 1 TO 9
    loF.AddObject("lbl_4c_L" + TRANSFORM(i), "Label")
    loF.AddObject("txt_4c_T" + TRANSFORM(i), "TextBox")
    STORE .F. TO ("loF.txt_4c_T" + TRANSFORM(i) + ".TabStop")
ENDFOR
loF.AddObject("cmd_4c_Ok", "CommandButton")
loc_cOut = loc_cOut + CHR(13) + CHR(10)
loc_cOut = loc_cOut + "B1 SEM atribuicao: grd / cmd              = " + ;
           TRANSFORM(loF.grd_4c_Dados.TabIndex) + " / " + ;
           TRANSFORM(loF.cmd_4c_Ok.TabIndex) + CHR(13) + CHR(10)
loc_cOut = loc_cOut + "B2 cnt_4c_Sombra                          = " + ;
           TRANSFORM(loF.cnt_4c_Sombra.TabIndex) + CHR(13) + CHR(10)
loc_cOut = loc_cOut + "B3 ControlCount                           = " + ;
           TRANSFORM(loF.ControlCount) + CHR(13) + CHR(10)

*-- Transcrever o literal 4 DEPOIS de todos os AddObject (faixa 1..N ja larga)
loF.grd_4c_Dados.TabIndex = 4
loc_cOut = loc_cOut + "B4 APOS grd.TabIndex = 4: grd / cmd / cnt = " + ;
           TRANSFORM(loF.grd_4c_Dados.TabIndex) + " / " + ;
           TRANSFORM(loF.cmd_4c_Ok.TabIndex) + " / " + ;
           TRANSFORM(loF.cnt_4c_Sombra.TabIndex) + CHR(13) + CHR(10)
loF = .NULL.

STRTOFILE(loc_cOut, "C:\4c\automation\medir_tabindex_756.txt")
QUIT

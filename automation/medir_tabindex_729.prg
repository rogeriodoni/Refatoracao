SET SAFETY OFF
SET RESOURCE OFF
LOCAL loc_cOut, loc_oF
loc_cOut = ""

*== 0) Shape tem TabIndex? ==
loc_oF = CREATEOBJECT("Form")
loc_oF.AddObject("s1", "Shape")
loc_cOut = loc_cOut + "Shape.TabIndex existe? " + ;
    IIF(PEMSTATUS(loc_oF.s1, "TabIndex", 5), "SIM", "NAO") + CHR(13) + CHR(10)
loc_oF.AddObject("c1", "Container")
loc_cOut = loc_cOut + "Container.TabIndex existe? " + ;
    IIF(PEMSTATUS(loc_oF.c1, "TabIndex", 5), "SIM", "NAO") + CHR(13) + CHR(10)
loc_oF = .NULL.

*== 1) SIMULACAO DO LOAD LEGADO: ordem de REGISTROS do SCX, aplicando o
*==    TabIndex do dump IMEDIATAMENTE apos cada AddObject ==
loc_oF = CREATEOBJECT("Form")
loc_oF.Width = 800
loc_oF.Height = 600
loc_oF.AddObject("cntSombra", "Container")          && dump: sem TabIndex
loc_oF.AddObject("Shape1", "Shape")                 && dump: sem TabIndex (Shape nao tem)
loc_oF.AddObject("ok", "CommandButton")
loc_oF.ok.TabIndex = 11                             && dump: TabIndex = 11
loc_oF.AddObject("get_NGrupo", "TextBox")
loc_oF.get_NGrupo.TabIndex = 81                     && dump: TabIndex = 81
loc_oF.AddObject("Get_NConta", "TextBox")
loc_oF.Get_NConta.TabIndex = 84                     && dump: TabIndex = 84
loc_oF.AddObject("grdItens", "Grid")
loc_oF.grdItens.TabIndex = 2                        && dump: TabIndex = 2

loc_cOut = loc_cOut + CHR(13) + CHR(10) + "== 1) LEGADO (load simulado) ==" + CHR(13) + CHR(10)
loc_cOut = loc_cOut + "cntSombra  = " + TRANSFORM(loc_oF.cntSombra.TabIndex)  + CHR(13) + CHR(10)
loc_cOut = loc_cOut + "ok         = " + TRANSFORM(loc_oF.ok.TabIndex)         + CHR(13) + CHR(10)
loc_cOut = loc_cOut + "get_NGrupo = " + TRANSFORM(loc_oF.get_NGrupo.TabIndex) + CHR(13) + CHR(10)
loc_cOut = loc_cOut + "Get_NConta = " + TRANSFORM(loc_oF.Get_NConta.TabIndex) + CHR(13) + CHR(10)
loc_cOut = loc_cOut + "grdItens   = " + TRANSFORM(loc_oF.grdItens.TabIndex)   + CHR(13) + CHR(10)
loc_oF = .NULL.

*== 2) MIGRADO, ordem de criacao atual, SEM passe de TabIndex ==
loc_oF = CREATEOBJECT("Form")
loc_oF.AddObject("cnt_4c_Sombra", "Container")
loc_oF.AddObject("shp_4c_Shape1", "Shape")
loc_oF.AddObject("txt_4c__NGrupo", "TextBox")
loc_oF.AddObject("txt_4c_NConta", "TextBox")
loc_oF.AddObject("cmd_4c_Ok", "CommandButton")
loc_oF.AddObject("grd_4c_Dados", "Grid")

loc_cOut = loc_cOut + CHR(13) + CHR(10) + "== 2) MIGRADO SEM passe ==" + CHR(13) + CHR(10)
loc_cOut = loc_cOut + "cnt_4c_Sombra  = " + TRANSFORM(loc_oF.cnt_4c_Sombra.TabIndex)  + CHR(13) + CHR(10)
loc_cOut = loc_cOut + "txt_4c__NGrupo = " + TRANSFORM(loc_oF.txt_4c__NGrupo.TabIndex) + CHR(13) + CHR(10)
loc_cOut = loc_cOut + "txt_4c_NConta  = " + TRANSFORM(loc_oF.txt_4c_NConta.TabIndex)  + CHR(13) + CHR(10)
loc_cOut = loc_cOut + "cmd_4c_Ok      = " + TRANSFORM(loc_oF.cmd_4c_Ok.TabIndex)      + CHR(13) + CHR(10)
loc_cOut = loc_cOut + "grd_4c_Dados   = " + TRANSFORM(loc_oF.grd_4c_Dados.TabIndex)   + CHR(13) + CHR(10)
loc_oF = .NULL.

*== 3) MIGRADO COM passe ascendente (ordinais efetivos do legado) ==
loc_oF = CREATEOBJECT("Form")
loc_oF.AddObject("cnt_4c_Sombra", "Container")
loc_oF.AddObject("shp_4c_Shape1", "Shape")
loc_oF.AddObject("txt_4c__NGrupo", "TextBox")
loc_oF.AddObject("txt_4c_NConta", "TextBox")
loc_oF.AddObject("cmd_4c_Ok", "CommandButton")
loc_oF.AddObject("grd_4c_Dados", "Grid")

loc_oF.cnt_4c_Sombra.TabIndex  = 1
loc_oF.grd_4c_Dados.TabIndex   = 2
loc_oF.cmd_4c_Ok.TabIndex      = 3
loc_oF.txt_4c__NGrupo.TabIndex = 4
loc_oF.txt_4c_NConta.TabIndex  = 5

loc_cOut = loc_cOut + CHR(13) + CHR(10) + "== 3) MIGRADO COM passe ==" + CHR(13) + CHR(10)
loc_cOut = loc_cOut + "cnt_4c_Sombra  = " + TRANSFORM(loc_oF.cnt_4c_Sombra.TabIndex)  + CHR(13) + CHR(10)
loc_cOut = loc_cOut + "grd_4c_Dados   = " + TRANSFORM(loc_oF.grd_4c_Dados.TabIndex)   + CHR(13) + CHR(10)
loc_cOut = loc_cOut + "cmd_4c_Ok      = " + TRANSFORM(loc_oF.cmd_4c_Ok.TabIndex)      + CHR(13) + CHR(10)
loc_cOut = loc_cOut + "txt_4c__NGrupo = " + TRANSFORM(loc_oF.txt_4c__NGrupo.TabIndex) + CHR(13) + CHR(10)
loc_cOut = loc_cOut + "txt_4c_NConta  = " + TRANSFORM(loc_oF.txt_4c_NConta.TabIndex)  + CHR(13) + CHR(10)
loc_oF = .NULL.

STRTOFILE(loc_cOut, "C:\4c\automation\medir_tabindex_729.txt")
QUIT

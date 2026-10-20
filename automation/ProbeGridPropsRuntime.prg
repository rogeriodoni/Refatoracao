*==============================================================================
* ProbeGridPropsRuntime.prg - Mede QUAIS propriedades de Grid aceitam
* atribuicao em RUNTIME (Grid criado por AddObject). Motivo: a Fase 4 do
* task644 transcreveu ".SplitBar = .F." do dump do SCX e isso estourou
* "Property SPLITBAR is read-only" dentro do TRY de ConfigurarGrid, abortando
* o resto do WITH em silencio. Em vez de chutar a lista, perguntar ao VFP.
*==============================================================================
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF

LOCAL loc_cOut, loc_oFrm, loc_oGrd, loc_nI, loc_cProp, loc_cRes, loc_oErro
loc_cOut = "C:\4c\automation\probe_grid_props_runtime.txt"

LOCAL ARRAY loc_aProp[13, 2]
loc_aProp[ 1, 1] = "SplitBar"          && .F.
loc_aProp[ 1, 2] = ".F."
loc_aProp[ 2, 1] = "Panel"
loc_aProp[ 2, 2] = "1"
loc_aProp[ 3, 1] = "PanelLink"
loc_aProp[ 3, 2] = ".T."
loc_aProp[ 4, 1] = "AllowHeaderSizing"
loc_aProp[ 4, 2] = ".F."
loc_aProp[ 5, 1] = "AllowRowSizing"
loc_aProp[ 5, 2] = ".F."
loc_aProp[ 6, 1] = "DeleteMark"
loc_aProp[ 6, 2] = ".F."
loc_aProp[ 7, 1] = "RecordMark"
loc_aProp[ 7, 2] = ".F."
loc_aProp[ 8, 1] = "RowHeight"
loc_aProp[ 8, 2] = "16"
loc_aProp[ 9, 1] = "ScrollBars"
loc_aProp[ 9, 2] = "2"
loc_aProp[10, 1] = "GridLineColor"
loc_aProp[10, 2] = "RGB(238,238,238)"
loc_aProp[11, 1] = "ReadOnly"
loc_aProp[11, 2] = ".F."
loc_aProp[12, 1] = "TabIndex"
loc_aProp[12, 2] = "1"
loc_aProp[13, 1] = "ColumnCount"
loc_aProp[13, 2] = "3"

loc_oFrm = CREATEOBJECT("Form")
loc_oFrm.AddObject("grd_teste", "Grid")
loc_oGrd = loc_oFrm.grd_teste

loc_cRes = "Grid props em RUNTIME (AddObject):" + CHR(13) + CHR(10)

FOR loc_nI = 1 TO ALEN(loc_aProp, 1)
    loc_cProp = loc_aProp[loc_nI, 1]
    TRY
        STORE EVALUATE(loc_aProp[loc_nI, 2]) TO ("loc_oGrd." + loc_cProp)
        loc_cRes = loc_cRes + PADR(loc_cProp, 22) + "GRAVAVEL   valor=" + ;
                   TRANSFORM(EVALUATE("loc_oGrd." + loc_cProp)) + CHR(13) + CHR(10)
    CATCH TO loc_oErro
        loc_cRes = loc_cRes + PADR(loc_cProp, 22) + "READ-ONLY  " + loc_oErro.Message + CHR(13) + CHR(10)
    ENDTRY
ENDFOR

STRTOFILE(loc_cRes, loc_cOut)
QUIT

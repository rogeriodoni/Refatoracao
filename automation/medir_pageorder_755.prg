* medir_pageorder_755.prg - mede o efeito de atribuir Page6.PageOrder = 3
* num PageFrame criado em runtime com PageCount = 6.
SET SAFETY OFF
SET RESOURCE OFF

LOCAL loc_oFrm, loc_nI, loc_cOut
loc_cOut = ""

loc_oFrm = CREATEOBJECT("Form")
loc_oFrm.AddObject("pgf", "PageFrame")
loc_oFrm.pgf.PageCount = 6

FOR loc_nI = 1 TO 6
    loc_oFrm.pgf.Pages(loc_nI).Caption = "C" + TRANSFORM(loc_nI)
ENDFOR

loc_cOut = loc_cOut + "ANTES (Pages(n).Name / PageOrder):" + CHR(13) + CHR(10)
FOR loc_nI = 1 TO 6
    loc_cOut = loc_cOut + "  Pages(" + TRANSFORM(loc_nI) + ") = " + ;
        loc_oFrm.pgf.Pages(loc_nI).Name + " PageOrder=" + ;
        TRANSFORM(loc_oFrm.pgf.Pages(loc_nI).PageOrder) + CHR(13) + CHR(10)
ENDFOR

loc_oFrm.pgf.Page6.PageOrder = 3

loc_cOut = loc_cOut + "DEPOIS de Page6.PageOrder = 3:" + CHR(13) + CHR(10)
FOR loc_nI = 1 TO 6
    loc_cOut = loc_cOut + "  Pages(" + TRANSFORM(loc_nI) + ") = " + ;
        loc_oFrm.pgf.Pages(loc_nI).Name + " PageOrder=" + ;
        TRANSFORM(loc_oFrm.pgf.Pages(loc_nI).PageOrder) + CHR(13) + CHR(10)
ENDFOR

loc_cOut = loc_cOut + "Acesso por NOME continua valido?" + CHR(13) + CHR(10)
loc_cOut = loc_cOut + "  Page3.Name=" + loc_oFrm.pgf.Page3.Name + ;
    " PageOrder=" + TRANSFORM(loc_oFrm.pgf.Page3.PageOrder) + CHR(13) + CHR(10)
loc_cOut = loc_cOut + "  Page6.Name=" + loc_oFrm.pgf.Page6.Name + ;
    " PageOrder=" + TRANSFORM(loc_oFrm.pgf.Page6.PageOrder) + CHR(13) + CHR(10)

STRTOFILE(loc_cOut, "C:\4c\automation\medir_pageorder_755.txt")
QUIT

SET SAFETY OFF
LOCAL loc_oForm, loc_cMsg
loc_oForm = CREATEOBJECT("Form")
loc_cMsg = ""

*-- Teste A: Height ANTES de PageCount (ordem do .prg real)
loc_oForm.AddObject("pgfA", "PageFrame")
WITH loc_oForm.pgfA
    .Width     = 1003
    .Height    = 476
    .PageCount = 10
ENDWITH
loc_cMsg = loc_cMsg + "A (Height antes PageCount) = " + TRANSFORM(loc_oForm.pgfA.Height) + CHR(13)

*-- Teste B: PageCount ANTES de Height
loc_oForm.AddObject("pgfB", "PageFrame")
WITH loc_oForm.pgfB
    .Width     = 1003
    .PageCount = 10
    .Height    = 476
ENDWITH
loc_cMsg = loc_cMsg + "B (PageCount antes Height) = " + TRANSFORM(loc_oForm.pgfB.Height) + CHR(13)

*-- Teste C: so Height, PageCount default (1)
loc_oForm.AddObject("pgfC", "PageFrame")
WITH loc_oForm.pgfC
    .Width     = 1003
    .Height    = 476
ENDWITH
loc_cMsg = loc_cMsg + "C (sem PageCount) = " + TRANSFORM(loc_oForm.pgfC.Height) + CHR(13)

*-- Teste D: Height, depois seta Height de novo
loc_oForm.AddObject("pgfD", "PageFrame")
WITH loc_oForm.pgfD
    .Width     = 1003
    .PageCount = 10
    .Height    = 476
    .Height    = 476
ENDWITH
loc_cMsg = loc_cMsg + "D (Height dobrado apos PageCount) = " + TRANSFORM(loc_oForm.pgfD.Height) + CHR(13)

STRTOFILE(loc_cMsg, "C:\4c\probe_pf_result.txt")
QUIT

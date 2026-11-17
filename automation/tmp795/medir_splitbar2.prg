*-- SplitBar eh read-only em RUNTIME. Mede se a declaracao em DEFINE CLASS
*-- (tempo de PROJETO) pega - eh o que decide se GridBase mantem o .F. do legado.
SET SAFETY OFF
SET RESOURCE OFF
LOCAL lcOut, loF
lcOut = ""

loF = CREATEOBJECT("Form")

loF.AddObject("gSub", "GridSemSplit795")
lcOut = lcOut + "SUBCLASSE  SplitBar=" + TRANSFORM(loF.gSub.SplitBar) + ;
        "  (declarado .F. no DEFINE CLASS)" + CHR(13) + CHR(10)

loF.AddObject("gCru", "Grid")
lcOut = lcOut + "GRID CRU   SplitBar=" + TRANSFORM(loF.gCru.SplitBar) + CHR(13) + CHR(10)

*-- Fonte: a subclasse nao pode atropelar o Tahoma do legado
loF.gSub.FontName = "Tahoma"
loF.gSub.FontSize = 8
lcOut = lcOut + "SUBCLASSE  FontName=[" + loF.gSub.FontName + "] FontSize=" + ;
        TRANSFORM(loF.gSub.FontSize) + CHR(13) + CHR(10)

STRTOFILE(lcOut, "C:\4c\automation\tmp795\medir_splitbar2_r1.txt")
QUIT

DEFINE CLASS GridSemSplit795 AS Grid
    SplitBar = .F.
ENDDEFINE

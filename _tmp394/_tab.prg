SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
_SCREEN.WindowState = 1

#DEFINE SAIDA "C:\4c\_tmp394\_tab.txt"

LOCAL lcO, oF
lcO = ""

*-- Caso A: Tabs = .T. (default do legado) com Top = -24
oF = CREATEOBJECT("Form")
oF.Width = 1003
oF.Height = 600
oF.AddObject("pgfA", "PageFrame")
WITH oF.pgfA
    .PageCount = 2
    .Top    = -24
    .Left   = 0
    .Width  = 1003
    .Height = 635
    .Tabs   = .T.
    .Page1.AddObject("cnt", "Container")
    .Page1.cnt.Top    = 0
    .Page1.cnt.Left   = 0
    .Page1.cnt.Height = 80
ENDWITH
lcO = lcO + "=== Tabs = .T. (legado), PageFrame.Top = -24 ===" + CHR(13)+CHR(10)
lcO = lcO + "  PageFrame.Top       = " + TRANSFORM(oF.pgfA.Top) + CHR(13)+CHR(10)
lcO = lcO + "  PageHeight          = " + TRANSFORM(oF.pgfA.PageHeight) + CHR(13)+CHR(10)
lcO = lcO + "  altura da faixa de abas = Height - PageHeight = " + ;
      TRANSFORM(oF.pgfA.Height - oF.pgfA.PageHeight) + CHR(13)+CHR(10)
lcO = lcO + "  container em Page.Top 0 -> y no FORM = Top + faixa = " + ;
      TRANSFORM(oF.pgfA.Top + (oF.pgfA.Height - oF.pgfA.PageHeight)) + CHR(13)+CHR(10)

*-- Caso B: Tabs = .F. (o que o migrado fez) com Top = -24
oF.AddObject("pgfB", "PageFrame")
WITH oF.pgfB
    .PageCount = 2
    .Top    = -24
    .Left   = 0
    .Width  = 1003
    .Height = 635
    .Tabs   = .F.
ENDWITH
lcO = lcO + CHR(13)+CHR(10) + "=== Tabs = .F. (migrado), PageFrame.Top = -24 ===" + CHR(13)+CHR(10)
lcO = lcO + "  PageHeight          = " + TRANSFORM(oF.pgfB.PageHeight) + CHR(13)+CHR(10)
lcO = lcO + "  altura da faixa de abas = " + ;
      TRANSFORM(oF.pgfB.Height - oF.pgfB.PageHeight) + CHR(13)+CHR(10)
lcO = lcO + "  container em Page.Top 0 -> y no FORM = " + ;
      TRANSFORM(oF.pgfB.Top + (oF.pgfB.Height - oF.pgfB.PageHeight)) + CHR(13)+CHR(10)

*-- Caso C: Tabs = .F. com Top = 0 (correcao proposta)
oF.AddObject("pgfC", "PageFrame")
WITH oF.pgfC
    .PageCount = 2
    .Top    = 0
    .Left   = 0
    .Width  = 1003
    .Height = 611
    .Tabs   = .F.
ENDWITH
lcO = lcO + CHR(13)+CHR(10) + "=== Tabs = .F., PageFrame.Top = 0 (proposta) ===" + CHR(13)+CHR(10)
lcO = lcO + "  PageHeight          = " + TRANSFORM(oF.pgfC.PageHeight) + CHR(13)+CHR(10)
lcO = lcO + "  container em Page.Top 0 -> y no FORM = " + ;
      TRANSFORM(oF.pgfC.Top + (oF.pgfC.Height - oF.pgfC.PageHeight)) + CHR(13)+CHR(10)

STRTOFILE(lcO, SAIDA)
QUIT

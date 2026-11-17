*-- Mede, no VFP9, se Grid.SplitBar aceita escrita em runtime e qual eh o default.
SET SAFETY OFF
SET RESOURCE OFF
LOCAL lcOut, loF, loErro
lcOut = ""

loF = CREATEOBJECT("Form")
loF.AddObject("g1", "Grid")

lcOut = lcOut + "DEFAULT SplitBar=" + TRANSFORM(loF.g1.SplitBar) + CHR(13) + CHR(10)
lcOut = lcOut + "PEMSTATUS existe=" + IIF(PEMSTATUS(loF.g1, "SplitBar", 5), "SIM", "NAO") + ;
        "  ReadOnly(attr 1)=" + IIF(PEMSTATUS(loF.g1, "SplitBar", 1), "SIM", "NAO") + ;
        CHR(13) + CHR(10)

*-- Escrita com o MESMO valor do default
TRY
    loF.g1.SplitBar = .F.
    lcOut = lcOut + "ESCREVER .F. => OK (valor=" + TRANSFORM(loF.g1.SplitBar) + ")" + CHR(13) + CHR(10)
CATCH TO loErro
    lcOut = lcOut + "ESCREVER .F. => ERRO [" + loErro.Message + "]" + CHR(13) + CHR(10)
ENDTRY

TRY
    loF.g1.SplitBar = .T.
    lcOut = lcOut + "ESCREVER .T. => OK (valor=" + TRANSFORM(loF.g1.SplitBar) + ")" + CHR(13) + CHR(10)
CATCH TO loErro
    lcOut = lcOut + "ESCREVER .T. => ERRO [" + loErro.Message + "]" + CHR(13) + CHR(10)
ENDTRY

*-- Controle positivo: propriedade vizinha do MESMO WITH que o form escreve
TRY
    loF.g1.DeleteMark = .F.
    lcOut = lcOut + "CTRL+ DeleteMark .F. => OK" + CHR(13) + CHR(10)
CATCH TO loErro
    lcOut = lcOut + "CTRL+ DeleteMark .F. => ERRO [" + loErro.Message + "]" + CHR(13) + CHR(10)
ENDTRY

STRTOFILE(lcOut, "C:\4c\automation\tmp795\medir_splitbar_r1.txt")
QUIT

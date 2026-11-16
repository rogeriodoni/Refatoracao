SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
SYS(2335, 0)
LOCAL c, loE, lnR
PUBLIC gnConnHandle
c = ""
CD "C:\4c\refatoracao\projeto\app\start"
DO config.prg
ConfigurarAmbiente()
gnConnHandle = SQLSTRINGCONNECT(ObterStringConexao())
lnR = SQLEXEC(gnConnHandle, "SELECT Iclis, Grupos, Figuras, FigJpgs FROM SigCdCli WHERE GerBals = 1", "x")
CREATE CURSOR cIde (cContas C(10), gFotos G(4) NULL, cArqJpgs C(254))
SELECT x
SCAN
    c = c + Iclis + " grp=" + Grupos + " isnullFig=" + TRANSFORM(ISNULL(x.Figuras)) + " emptyFig=" + TRANSFORM(EMPTY(x.Figuras)) + " isnullJpg=" + TRANSFORM(ISNULL(x.FigJpgs)) + " emptyJpg=" + TRANSFORM(EMPTY(x.FigJpgs))
    INSERT INTO cIde (cContas) VALUES (x.Iclis)
    TRY
        SELECT cIde
        REPLACE gFotos WITH x.Figuras
        c = c + " replace OK"
    CATCH TO loE
        c = c + " replace ERRO: " + loE.Message
    ENDTRY
    c = c + CHR(13)+CHR(10)
    SELECT x
ENDSCAN
STRTOFILE(c, "C:\4c\refatoracao\automation\erro373\probe_out.txt")
QUIT

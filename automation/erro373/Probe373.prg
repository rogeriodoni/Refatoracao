SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
SYS(2335, 0)
LOCAL c, loE, lnR
PUBLIC gnConnHandle
c = ""
TRY
    CD "C:\4c\refatoracao\projeto\app\start"
    DO config.prg
    ConfigurarAmbiente()
    gnConnHandle = SQLSTRINGCONNECT(ObterStringConexao())
    lnR = SQLEXEC(gnConnHandle, "SELECT TOP 5 Iclis, Grupos, Figuras, FigJpgs FROM SigCdCli WHERE GerBals = 1 AND (Figuras IS NOT NULL OR FigJpgs IS NOT NULL)", "x")
    c = c + "r=" + TRANSFORM(lnR) + " n=" + TRANSFORM(RECCOUNT("x")) + " Figuras=" + TYPE("x.Figuras") + " FigJpgs=" + TYPE("x.FigJpgs") + CHR(13)+CHR(10)
    SELECT x
    SCAN
        c = c + Iclis + " fignull=" + TRANSFORM(ISNULL(Figuras)) + " jpgnull=" + TRANSFORM(ISNULL(FigJpgs)) + " jpglen=" + TRANSFORM(IIF(ISNULL(FigJpgs),0,LEN(FigJpgs))) + CHR(13)+CHR(10)
    ENDSCAN
    lnR = SQLEXEC(gnConnHandle, "SELECT COUNT(*) n, SUM(CASE WHEN Figuras IS NULL THEN 0 ELSE 1 END) f, SUM(CASE WHEN FigJpgs IS NULL THEN 0 ELSE 1 END) j FROM SigCdCli WHERE GerBals = 1", "y")
    c = c + "gerbals=1: n=" + TRANSFORM(y.n) + " figuras=" + TRANSFORM(y.f) + " figjpgs=" + TRANSFORM(y.j) + CHR(13)+CHR(10)
    lnR = SQLEXEC(gnConnHandle, "SELECT Logos FROM SigCdPam", "z")
    c = c + "Logos=" + TYPE("z.Logos") + " null=" + TRANSFORM(ISNULL(z.Logos)) + CHR(13)+CHR(10)
CATCH TO loE
    c = c + "ERRO: " + loE.Message + " | " + loE.LineContents
ENDTRY
STRTOFILE(c, "C:\4c\refatoracao\automation\erro373\probe_out.txt")
QUIT

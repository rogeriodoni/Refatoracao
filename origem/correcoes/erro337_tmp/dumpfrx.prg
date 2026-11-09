SET SAFETY OFF
SET RESOURCE OFF
USE ("C:\4c\refatoracao\projeto\app\reports\SigReDp6.frx") SHARED NOUPDATE
lc = ""
SCAN
  IF "THIS" $ UPPER(Expr + Supexpr + Tag + Tag2 + User) OR "THIS" $ UPPER(Name)
    lc = lc + TRANSFORM(RECNO()) + " " + TRANSFORM(ObjType) + " expr=[" + Expr + "] sup=[" + Supexpr + "] tag=[" + LEFT(Tag,200) + "]" + CHR(13)+CHR(10)
  ENDIF
ENDSCAN
STRTOFILE(lc, "C:\4c\refatoracao\origem\correcoes\erro337_tmp\dump.txt")
QUIT

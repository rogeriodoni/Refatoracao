* Probe809F6b.prg - mede POR QUE INLIST("", "1","2"," ") devolve .T.
* Hipotese: SET EXACT ON (posto por config.prg) ignora brancos a direita,
* logo "" = " " eh .T. e a entrada " " da lista do legado eh justamente o
* que deixa o campo em branco passar. Medido, nao deduzido.
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF

#DEFINE OUT2 "C:\4c\automation\probe_809f6b.txt"

LOCAL loc_cRel

loc_cRel = ""

SET EXACT OFF
loc_cRel = loc_cRel + "EXACT OFF: SET(EXACT)=" + SET("EXACT") + CHR(13) + CHR(10)
loc_cRel = loc_cRel + '   ""  =  " "          -> ' + TRANSFORM("" = " ") + CHR(13) + CHR(10)
loc_cRel = loc_cRel + '   ""  =  "1"          -> ' + TRANSFORM("" = "1") + CHR(13) + CHR(10)
loc_cRel = loc_cRel + '   INLIST("","1","2"," ") -> ' + TRANSFORM(INLIST("", "1", "2", " ")) + CHR(13) + CHR(10)
loc_cRel = loc_cRel + '   INLIST("","1","2")     -> ' + TRANSFORM(INLIST("", "1", "2")) + CHR(13) + CHR(10)
loc_cRel = loc_cRel + '   INLIST("3","1","2"," ") -> ' + TRANSFORM(INLIST("3", "1", "2", " ")) + CHR(13) + CHR(10)

SET EXACT ON
loc_cRel = loc_cRel + "EXACT ON : SET(EXACT)=" + SET("EXACT") + CHR(13) + CHR(10)
loc_cRel = loc_cRel + '   ""  =  " "          -> ' + TRANSFORM("" = " ") + CHR(13) + CHR(10)
loc_cRel = loc_cRel + '   ""  =  "1"          -> ' + TRANSFORM("" = "1") + CHR(13) + CHR(10)
loc_cRel = loc_cRel + '   INLIST("","1","2"," ") -> ' + TRANSFORM(INLIST("", "1", "2", " ")) + CHR(13) + CHR(10)
loc_cRel = loc_cRel + '   INLIST("","1","2")     -> ' + TRANSFORM(INLIST("", "1", "2")) + CHR(13) + CHR(10)
loc_cRel = loc_cRel + '   INLIST("3","1","2"," ") -> ' + TRANSFORM(INLIST("3", "1", "2", " ")) + CHR(13) + CHR(10)

STRTOFILE(loc_cRel, OUT2)
QUIT

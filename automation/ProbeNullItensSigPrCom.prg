*-- Mede o comportamento REAL de NULL no cursor da grade de itens (task593).
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
CLOSE ALL
CLEAR ALL

LOCAL lcOut
lcOut = ""

SET NULL ON
CREATE CURSOR cur_probe ;
    (cidchaves C(20), cpros C(14), emps C(3), qmaxs N(7,2), codtams C(4), codcores C(4), deptos C(10))
SET NULL OFF

*-- Exatamente o que AdicionarNovaLinhaItem faz: INSERT so com cpros
INSERT INTO cur_probe (cpros) VALUES ("PROD1")

lcOut = lcOut + "ISNULL(emps)      = " + TRANSFORM(ISNULL(cur_probe.emps)) + CHR(13) + CHR(10)
lcOut = lcOut + "ISNULL(cidchaves) = " + TRANSFORM(ISNULL(cur_probe.cidchaves)) + CHR(13) + CHR(10)
lcOut = lcOut + "ISNULL(qmaxs)     = " + TRANSFORM(ISNULL(cur_probe.qmaxs)) + CHR(13) + CHR(10)
lcOut = lcOut + "EMPTY(.NULL.)     = " + TRANSFORM(EMPTY(.NULL.)) + CHR(13) + CHR(10)
lcOut = lcOut + "EMPTY(emps)       = " + TRANSFORM(EMPTY(cur_probe.emps)) + CHR(13) + CHR(10)
lcOut = lcOut + "EMPTY(NVL(emps,'')) = " + TRANSFORM(EMPTY(NVL(cur_probe.emps, ""))) + CHR(13) + CHR(10)

*-- O SCAN FOR !EMPTY(emps) enxergaria essa linha em branco?
LOCAL lnVistas
lnVistas = 0
SELECT cur_probe
SCAN FOR !EMPTY(emps)
    lnVistas = lnVistas + 1
ENDSCAN
lcOut = lcOut + "SCAN FOR !EMPTY(emps) viu " + TRANSFORM(lnVistas) + " linha(s) (esperado 0)" + CHR(13) + CHR(10)

lnVistas = 0
SELECT cur_probe
SCAN FOR !EMPTY(NVL(emps, ""))
    lnVistas = lnVistas + 1
ENDSCAN
lcOut = lcOut + "SCAN FOR !EMPTY(NVL(emps,'')) viu " + TRANSFORM(lnVistas) + " linha(s) (esperado 0)" + CHR(13) + CHR(10)

*-- E o LOCATE FOR EMPTY(emps) de AdicionarNovaLinhaItem acha a linha em branco?
SELECT cur_probe
LOCATE FOR EMPTY(emps)
lcOut = lcOut + "LOCATE FOR EMPTY(emps) FOUND = " + TRANSFORM(FOUND()) + CHR(13) + CHR(10)
SELECT cur_probe
LOCATE FOR EMPTY(NVL(emps, ""))
lcOut = lcOut + "LOCATE FOR EMPTY(NVL(emps,'')) FOUND = " + TRANSFORM(FOUND()) + CHR(13) + CHR(10)

STRTOFILE(lcOut, "C:\4c\automation\probe_null_itens_sigprcom.txt")
QUIT

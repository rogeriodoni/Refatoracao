SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
LOCAL loc_cOut
loc_cOut = ""

*-- campos EXPLICITAMENTE nullable (eh o que um cursor de SQLEXEC sobre
*-- coluna nullable produz) + INSERT omitindo colunas
CREATE CURSOR cIns3 (cdopes C(20) NULL, cidchaves C(20) NULL, cnivels C(20) NULL, seqs N(2,0) NULL)
INSERT INTO cIns3 (cdopes, cidchaves) VALUES ("OP", "K1")
loc_cOut = loc_cOut + "E) NULL explicito: cnivels ISNULL=" + TRANSFORM(ISNULL(cIns3.cnivels)) + ;
    " EMPTY=" + TRANSFORM(EMPTY(cIns3.cnivels)) + ;
    " | seqs ISNULL=" + TRANSFORM(ISNULL(cIns3.seqs)) + CHR(13) + CHR(10)

*-- LOCATE FOR EMPTY(campo) quando o campo esta NULL
LOCATE FOR EMPTY(cIns3.cnivels)
loc_cOut = loc_cOut + "F) LOCATE FOR EMPTY(cnivels NULL) FOUND=" + TRANSFORM(FOUND()) + CHR(13) + CHR(10)

*-- APPEND BLANK em campo nullable
APPEND BLANK
loc_cOut = loc_cOut + "G) APPEND BLANK em nullable: cnivels ISNULL=" + TRANSFORM(ISNULL(cIns3.cnivels)) + CHR(13) + CHR(10)

*-- SELECT * INTO CURSOR READWRITE preserva nullability?
SELECT * FROM cIns3 INTO CURSOR cIns4 READWRITE
INSERT INTO cIns4 (cdopes, cidchaves) VALUES ("OP", "K2")
GO BOTTOM IN cIns4
loc_cOut = loc_cOut + "H) apos SELECT INTO CURSOR RW: cnivels ISNULL=" + TRANSFORM(ISNULL(cIns4.cnivels)) + ;
    " EMPTY=" + TRANSFORM(EMPTY(cIns4.cnivels)) + CHR(13) + CHR(10)

*-- comparacao numerica com NULL dentro de IF
LOCAL loc_nAnt
loc_nAnt = 0
SELECT cIns3
LOCATE FOR ISNULL(cIns3.seqs)
IF FOUND()
    IF cIns3.seqs != loc_nAnt
        loc_cOut = loc_cOut + "I) IF (NULL != 0) -> ENTROU" + CHR(13) + CHR(10)
    ELSE
        loc_cOut = loc_cOut + "I) IF (NULL != 0) -> NAO entrou" + CHR(13) + CHR(10)
    ENDIF
ELSE
    loc_cOut = loc_cOut + "I) nenhuma linha com seqs NULL" + CHR(13) + CHR(10)
ENDIF

STRTOFILE(loc_cOut, "C:\4c\automation\_probe_scan_sqn2.txt")
QUIT

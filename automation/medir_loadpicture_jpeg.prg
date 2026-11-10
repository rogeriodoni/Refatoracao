SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF

LOCAL lcOut, loErro, lnI, loP, lcA
lcOut = ""

DIMENSION laArq[6]
laArq[1] = "C:\4c\Framework\imagens\geral_documento_26.jpg"
laArq[2] = "C:\4c\Framework\imagens\geral_caixa_16.jpg"
laArq[3] = "C:\4c\Framework\imagens\geral_pendencia_26.jpg"
laArq[4] = "C:\4c\Framework\imagens\geral_palete_26.jpg"
laArq[5] = "C:\4c\vbmp\EnvMail.Bmp"
laArq[6] = "C:\4c\Framework\imagens\geral_subnivel_26.jpg"

FOR lnI = 1 TO 6
	lcA = laArq[lnI]
	loP = .NULL.
	TRY
		loP = LOADPICTURE(lcA)
		lcOut = lcOut + "LOADPICTURE " + JUSTFNAME(lcA) + " = " + VARTYPE(loP) + ;
			" FILE=" + TRANSFORM(FILE(lcA)) + CHR(13) + CHR(10)
	CATCH TO loErro
		lcOut = lcOut + "LOADPICTURE " + JUSTFNAME(lcA) + " FALHOU: " + loErro.Message + ;
			" FILE=" + TRANSFORM(FILE(lcA)) + CHR(13) + CHR(10)
	ENDTRY
ENDFOR

*-- Chamada de metodo SEM parenteses dentro de WITH (forma do legado)
LOCAL loS
loS = CREATEOBJECT("StubCN")
WITH loS
	.ClearNodes
	.ExpandOnDClick
ENDWITH
lcOut = lcOut + "bare_dentro_de_WITH: nClear=" + TRANSFORM(loS.nClear) + ;
	" nExp=" + TRANSFORM(loS.nExp) + CHR(13) + CHR(10)

loS2 = CREATEOBJECT("StubCN")
loS2.ClearNodes
lcOut = lcOut + "bare_qualificado: nClear=" + TRANSFORM(loS2.nClear) + CHR(13) + CHR(10)

STRTOFILE(lcOut, "C:\4c\automation\_probe_img_out.txt")
QUIT

DEFINE CLASS StubCN AS Custom
	nClear = 0
	nExp   = 0
	PROCEDURE ClearNodes
		THIS.nClear = THIS.nClear + 1
	ENDPROC
	PROCEDURE ExpandOnDClick
		THIS.nExp = THIS.nExp + 1
	ENDPROC
ENDDEFINE

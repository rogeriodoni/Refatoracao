*-- Mede o comportamento do SET KEY TO <expr> do Init legado do SIGPRGL2:
*-- a expressao e avaliada UMA vez (no momento do comando) ou reavaliada
*-- a cada movimento de TmpCabec?
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF

LOCAL loc_cRes
loc_cRes = ""

CREATE CURSOR TmpCabec (Emps C(3), Dopes C(20), Numes N(6))
INDEX ON Emps + Dopes + STR(Numes, 6) TAG EmpDopNum
SET ORDER TO EmpDopNum
INSERT INTO TmpCabec VALUES ("001", "PEDIDO", 7)
INSERT INTO TmpCabec VALUES ("001", "PEDIDO", 9)

CREATE CURSOR TmpItens (Emps C(3), Dopes C(20), Numes N(6), CPros C(14))
INDEX ON Emps + Dopes + STR(Numes, 6) TAG EmpDopNum
SET ORDER TO EmpDopNum
INSERT INTO TmpItens VALUES ("001", "PEDIDO", 7, "PROD-7")
INSERT INTO TmpItens VALUES ("001", "PEDIDO", 9, "PROD-9")

*-- Cenario A: reproduz a ORDEM DO LEGADO - TmpCabec parado na 2a linha
*-- quando o SET KEY roda, e so DEPOIS vai para o topo
SELECT TmpCabec
GO BOTTOM
SELECT TmpItens
SET ORDER TO EmpDopNum
SET KEY TO TmpCabec.Emps + TmpCabec.Dopes + STR(TmpCabec.Numes, 6)
GO TOP
SELECT TmpCabec
GO TOP
loc_cRes = loc_cRes + "A) ordem do legado (SET KEY com TmpCabec na linha 2, depois GO TOP)" + CHR(13)+CHR(10) + ;
    "   TmpCabec.Numes=" + TRANSFORM(TmpCabec.Numes) + ;
    "  TmpItens.CPros=[" + ALLTRIM(TmpItens.CPros) + "]" + CHR(13)+CHR(10)

*-- Cenario B: TmpCabec JA no topo quando o SET KEY roda
SELECT TmpItens
SET KEY TO
SELECT TmpCabec
GO TOP
SELECT TmpItens
SET KEY TO TmpCabec.Emps + TmpCabec.Dopes + STR(TmpCabec.Numes, 6)
GO TOP
loc_cRes = loc_cRes + "B) SET KEY com TmpCabec ja no topo" + CHR(13)+CHR(10) + ;
    "   TmpCabec.Numes=" + TRANSFORM(TmpCabec.Numes) + ;
    "  TmpItens.CPros=[" + ALLTRIM(TmpItens.CPros) + "]" + CHR(13)+CHR(10)

*-- Cenario C: com o SET KEY de B ainda ativo, mover TmpCabec reavalia?
SELECT TmpCabec
GO BOTTOM
SELECT TmpItens
GO TOP
loc_cRes = loc_cRes + "C) move TmpCabec p/ linha 2 SEM refazer o SET KEY" + CHR(13)+CHR(10) + ;
    "   TmpCabec.Numes=" + TRANSFORM(TmpCabec.Numes) + ;
    "  TmpItens.CPros=[" + ALLTRIM(TmpItens.CPros) + "]" + CHR(13)+CHR(10) + ;
    "   => se continuar PROD-7, a chave foi CONGELADA no momento do comando" + CHR(13)+CHR(10)

STRTOFILE(loc_cRes, "C:\4c\automation\probe_gl2_setkey.txt")
QUIT

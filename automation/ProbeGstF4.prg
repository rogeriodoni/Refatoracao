SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
PUBLIC gb_4c_ModoTeste, gc_4c_ArquivoErroTeste, gb_4c_ValidandoUI
gb_4c_ModoTeste        = .T.
gc_4c_ArquivoErroTeste = "C:\4c\automation\probe_gstf4_dialogos.txt"

LOCAL lcOut, loc_oForm, lcS, lnI, loc_oErro
lcOut = "C:\4c\automation\probe_gstf4.txt"
STRTOFILE("CP1" + CHR(13) + CHR(10), lcOut)

CD C:\4c\projeto\app\start
DO config.prg
SET PATH TO (gc_4c_CaminhoBase + "," + gc_4c_CaminhoClasses + "," + ;
             gc_4c_CaminhoUtils + "," + gc_4c_CaminhoForms + "," + gc_4c_CaminhoIcones)
SET PROCEDURE TO (gc_4c_CaminhoClasses + "dataaccess.prg")   ADDITIVE
SET PROCEDURE TO (gc_4c_CaminhoClasses + "businessbase.prg") ADDITIVE
SET PROCEDURE TO (gc_4c_CaminhoClasses + "formbase.prg")     ADDITIVE
SET PROCEDURE TO (gc_4c_CaminhoClasses + "gridbase.prg")     ADDITIVE
SET PROCEDURE TO (gc_4c_CaminhoClasses + "FormErro.prg")     ADDITIVE
SET PROCEDURE TO (gc_4c_CaminhoUtils   + "functions.prg")    ADDITIVE
SET PROCEDURE TO (gc_4c_CaminhoUtils   + "messages.prg")     ADDITIVE
SET PROCEDURE TO (gc_4c_CaminhoUtils   + "validators.prg")   ADDITIVE
SET PROCEDURE TO (gc_4c_CaminhoClasses + "SigPrGstBO.prg")   ADDITIVE
SET PROCEDURE TO (gc_4c_CaminhoForms + "operacionais\FormSigPrGst.prg") ADDITIVE
gb_4c_ValidandoUI = .T.

lcS = ""

*==========================================================================
* CENARIO A - sem form pai e SEM os cursores (ValidarUIFidelity / harness)
*==========================================================================
lcS = lcS + "=== CENARIO A: sem cursores ===" + CHR(13) + CHR(10)
loc_oForm = CREATEOBJECT("FormSigPrGst")
lcS = lcS + "form=" + VARTYPE(loc_oForm) + CHR(13) + CHR(10)

IF VARTYPE(loc_oForm) = "O"
    lcS = lcS + "grdCab existe=" + TRANSFORM(PEMSTATUS(loc_oForm, "grd_4c_GrdCab", 5)) + ;
        "  grdIte existe=" + TRANSFORM(PEMSTATUS(loc_oForm, "grd_4c_GrdIte", 5)) + CHR(13) + CHR(10)
    lcS = lcS + "cab.ColumnCount=" + TRANSFORM(loc_oForm.grd_4c_GrdCab.ColumnCount) + ;
        "  cab.RecordSource=[" + loc_oForm.grd_4c_GrdCab.RecordSource + "]" + CHR(13) + CHR(10)
    lcS = lcS + "ite.ColumnCount=" + TRANSFORM(loc_oForm.grd_4c_GrdIte.ColumnCount) + ;
        "  ite.RecordSource=[" + loc_oForm.grd_4c_GrdIte.RecordSource + "]" + CHR(13) + CHR(10)

    FOR lnI = 1 TO 7
        lcS = lcS + "  cab col" + TRANSFORM(lnI) + ;
            " W=" + PADL(TRANSFORM(loc_oForm.grd_4c_GrdCab.Columns(lnI).Width), 4) + ;
            " H=[" + loc_oForm.grd_4c_GrdCab.Columns(lnI).Header1.Caption + "]" + CHR(13) + CHR(10)
    ENDFOR
    FOR lnI = 1 TO 7
        lcS = lcS + "  ite col" + TRANSFORM(lnI) + ;
            " W=" + PADL(TRANSFORM(loc_oForm.grd_4c_GrdIte.Columns(lnI).Width), 4) + ;
            " H=[" + loc_oForm.grd_4c_GrdIte.Columns(lnI).Header1.Caption + "]" + CHR(13) + CHR(10)
    ENDFOR

    lcS = lcS + "botoes: grava=" + TRANSFORM(PEMSTATUS(loc_oForm, "cmd_4c_CmdGrava", 5)) + ;
        " cancela=" + TRANSFORM(PEMSTATUS(loc_oForm, "cmd_4c_CmdCancela", 5)) + CHR(13) + CHR(10)

    *-- CarregarLista() chamada de FORA da classe (como o TesteAutomatico faz)
    lcS = lcS + "CarregarLista() sem cursores=" + TRANSFORM(loc_oForm.CarregarLista()) + CHR(13) + CHR(10)

    loc_oForm.Release()
    loc_oForm = .NULL.
ENDIF

*==========================================================================
* CENARIO B - com csCabec/csItens populados (como o form pai entrega)
*==========================================================================
lcS = lcS + CHR(13) + CHR(10) + "=== CENARIO B: com cursores do form pai ===" + CHR(13) + CHR(10)

CREATE CURSOR csCabec (Emps C(3), Dopes C(20), Numes N(6), EmpDs C(3), ;
    GrupoOs C(10), ContaOs C(10), GrupoDs C(10), ContaDs C(10), ;
    Gerado C(2), EmpDopNums C(29), GerEmps C(3), GerDopes C(20), GerNumes N(6))

INSERT INTO csCabec (Emps, Dopes, Numes, EmpDs, GrupoOs, ContaOs, GrupoDs, ContaDs, Gerado, EmpDopNums) ;
    VALUES ("001", "MALOTE", 3, "001", "G01", "C01", "G02", "C02", "", ;
            PADR("001", 3) + PADR("MALOTE", 20) + STR(3, 6))
INSERT INTO csCabec (Emps, Dopes, Numes, EmpDs, GrupoOs, ContaOs, GrupoDs, ContaDs, Gerado, EmpDopNums) ;
    VALUES ("001", "TRANSFERENCIA", 4, "001", "G03", "C03", "G04", "C04", "OK", ;
            PADR("001", 3) + PADR("TRANSFERENCIA", 20) + STR(4, 6))

CREATE CURSOR csItens (Emps C(3), Dopes C(20), Numes N(6), CItens N(4), ;
    CPros C(20), DPros C(60), Moedas C(3), Units N(14, 2), Qtds N(14, 2), ;
    Totas N(14, 2), EmpDopNums C(29))

INSERT INTO csItens (Emps, Dopes, Numes, CItens, CPros, DPros, Moedas, Units, Qtds, Totas, EmpDopNums) ;
    VALUES ("001", "MALOTE", 3, 1, "PRO-A", "PRODUTO A", "R$", 10, 2, 20, ;
            PADR("001", 3) + PADR("MALOTE", 20) + STR(3, 6))
INSERT INTO csItens (Emps, Dopes, Numes, CItens, CPros, DPros, Moedas, Units, Qtds, Totas, EmpDopNums) ;
    VALUES ("001", "MALOTE", 3, 2, "PRO-B", "PRODUTO B", "R$", 5, 3, 15, ;
            PADR("001", 3) + PADR("MALOTE", 20) + STR(3, 6))
INSERT INTO csItens (Emps, Dopes, Numes, CItens, CPros, DPros, Moedas, Units, Qtds, Totas, EmpDopNums) ;
    VALUES ("001", "TRANSFERENCIA", 4, 1, "PRO-C", "PRODUTO C", "R$", 7, 1, 7, ;
            PADR("001", 3) + PADR("TRANSFERENCIA", 20) + STR(4, 6))

SELECT csItens
INDEX ON EmpDopNums TAG EmpDopNums
SET ORDER TO TAG EmpDopNums
GO TOP
SELECT csCabec
GO TOP

loc_oForm = CREATEOBJECT("FormSigPrGst")
lcS = lcS + "form=" + VARTYPE(loc_oForm) + CHR(13) + CHR(10)

IF VARTYPE(loc_oForm) = "O"
    lcS = lcS + "cab.RecordSource=[" + loc_oForm.grd_4c_GrdCab.RecordSource + "]" + CHR(13) + CHR(10)
    lcS = lcS + "ite.RecordSource=[" + loc_oForm.grd_4c_GrdIte.RecordSource + "]" + CHR(13) + CHR(10)

    FOR lnI = 1 TO 7
        lcS = lcS + "  cab col" + TRANSFORM(lnI) + ;
            " W=" + PADL(TRANSFORM(loc_oForm.grd_4c_GrdCab.Columns(lnI).Width), 4) + ;
            " RO=" + TRANSFORM(loc_oForm.grd_4c_GrdCab.Columns(lnI).ReadOnly) + ;
            " CS=[" + loc_oForm.grd_4c_GrdCab.Columns(lnI).ControlSource + "]" + ;
            " H=[" + loc_oForm.grd_4c_GrdCab.Columns(lnI).Header1.Caption + "]" + CHR(13) + CHR(10)
    ENDFOR
    FOR lnI = 1 TO 7
        lcS = lcS + "  ite col" + TRANSFORM(lnI) + ;
            " W=" + PADL(TRANSFORM(loc_oForm.grd_4c_GrdIte.Columns(lnI).Width), 4) + ;
            " RO=" + TRANSFORM(loc_oForm.grd_4c_GrdIte.Columns(lnI).ReadOnly) + ;
            " CS=[" + loc_oForm.grd_4c_GrdIte.Columns(lnI).ControlSource + "]" + ;
            " H=[" + loc_oForm.grd_4c_GrdIte.Columns(lnI).Header1.Caption + "]" + CHR(13) + CHR(10)
    ENDFOR

    lcS = lcS + "DynamicBackColor col7=[" + loc_oForm.grd_4c_GrdCab.Column7.DynamicBackColor + "]" + CHR(13) + CHR(10)

    *-- Escopo dos itens no pedido CORRENTE (1a linha: MALOTE/3 -> 2 itens)
    lcS = lcS + "csCabec corrente=[" + ALLTRIM(csCabec.Dopes) + "] " + ;
        "itens visiveis=" + TRANSFORM(RECCOUNT("csItens")) + ;
        " / contados=" + CHR(13) + CHR(10)
    SELECT csItens
    GO TOP
    lnI = 0
    SCAN
        lnI = lnI + 1
    ENDSCAN
    lcS = lcS + "  SCAN em csItens com SET KEY = " + TRANSFORM(lnI) + " linha(s) (esperado 2)" + CHR(13) + CHR(10)

    *-- Troca de pedido: vai para a 2a linha e dispara o funil do evento
    SELECT csCabec
    GO BOTTOM
    loc_oForm.GrdCabAfterRowColChange(1)
    lcS = lcS + "csCabec corrente=[" + ALLTRIM(csCabec.Dopes) + "]" + CHR(13) + CHR(10)
    SELECT csItens
    GO TOP
    lnI = 0
    SCAN
        lnI = lnI + 1
    ENDSCAN
    lcS = lcS + "  SCAN em csItens apos troca = " + TRANSFORM(lnI) + " linha(s) (esperado 1)" + CHR(13) + CHR(10)
    lcS = lcS + "  ite col3 W=" + TRANSFORM(loc_oForm.grd_4c_GrdIte.Column3.Width) + ;
        " H=[" + loc_oForm.grd_4c_GrdIte.Column3.Header1.Caption + "] (apos re-bind)" + CHR(13) + CHR(10)

    loc_oForm.Release()
    loc_oForm = .NULL.
ENDIF

STRTOFILE(lcS, lcOut, 1)
STRTOFILE("CPFIM" + CHR(13) + CHR(10), lcOut, 1)
QUIT

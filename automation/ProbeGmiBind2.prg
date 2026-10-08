SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
PUBLIC gb_4c_ModoTeste, gc_4c_ArquivoErroTeste, gb_4c_ValidandoUI
gb_4c_ModoTeste        = .T.
gc_4c_ArquivoErroTeste = "C:\4c\automation\probe_gmi_dialogos2.txt"
LOCAL lcOut, loc_oForm, loc_oErro, lnI, lnN, lcS
LOCAL ARRAY laA[1, 5]
lcOut = "C:\4c\automation\probe_gmi_bind2.txt"
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
SET PROCEDURE TO (gc_4c_CaminhoClasses + "SigPrGmiBO.prg")   ADDITIVE
SET PROCEDURE TO (gc_4c_CaminhoForms + "operacionais\FormSigPrGmi.prg") ADDITIVE
gb_4c_ValidandoUI = .T.
loc_oForm = CREATEOBJECT("FormSigPrGmi")
lcS = "form=" + VARTYPE(loc_oForm) + CHR(13) + CHR(10)

*-- CONTROLE DO EXPERIMENTO: ligo um delegate que SEI que existe, agora.
*-- Se nem ESTE aparecer no AEVENTS, a consulta esta errada (nao o form).
LOCAL llBind
llBind = BINDEVENT(loc_oForm.cmd_4c_Processa, "Click", loc_oForm, "BtnProcessaClick")
lcS = lcS + "BINDEVENT feito agora (retorno)=" + TRANSFORM(llBind) + CHR(13) + CHR(10)

lnN = AEVENTS(laA, 0)
lcS = lcS + "AEVENTS(a,0) = " + TRANSFORM(lnN) + CHR(13) + CHR(10)
FOR lnI = 1 TO lnN
    lcS = lcS + "  0:[" + TRANSFORM(lnI) + "] " + ;
        "c1=" + IIF(VARTYPE(laA[lnI,1])="O", ALLTRIM(laA[lnI,1].Name), TRANSFORM(laA[lnI,1])) + ;
        " c2=" + TRANSFORM(laA[lnI,2]) + ;
        " c3=" + IIF(VARTYPE(laA[lnI,3])="O", ALLTRIM(laA[lnI,3].Name), TRANSFORM(laA[lnI,3])) + ;
        " c4=" + TRANSFORM(laA[lnI,4]) + CHR(13) + CHR(10)
ENDFOR

lnN = AEVENTS(laA, 1)
lcS = lcS + "AEVENTS(a,1) = " + TRANSFORM(lnN) + CHR(13) + CHR(10)
FOR lnI = 1 TO lnN
    lcS = lcS + "  1:[" + TRANSFORM(lnI) + "] " + ;
        "c1=" + IIF(VARTYPE(laA[lnI,1])="O", ALLTRIM(laA[lnI,1].Name), TRANSFORM(laA[lnI,1])) + ;
        " c2=" + TRANSFORM(laA[lnI,2]) + ;
        " c3=" + IIF(VARTYPE(laA[lnI,3])="O", ALLTRIM(laA[lnI,3].Name), TRANSFORM(laA[lnI,3])) + ;
        " c4=" + TRANSFORM(laA[lnI,4]) + CHR(13) + CHR(10)
ENDFOR
STRTOFILE(lcS, lcOut, 1)
STRTOFILE("CPFIM" + CHR(13) + CHR(10), lcOut, 1)
QUIT

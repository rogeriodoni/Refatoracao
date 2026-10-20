SET SAFETY OFF
SET RESOURCE OFF
LOCAL loc_cOut, loc_oFrm, loc_oErro
loc_cOut = ""

CREATE CURSOR cur_t (Priors N(6), Emps C(3))
INSERT INTO cur_t VALUES (1, "001")

loc_oFrm = CREATEOBJECT("Form")
loc_oFrm.AddObject("grd", "Grid")
loc_oFrm.grd.ColumnCount  = 2
loc_oFrm.grd.RecordSource = "cur_t"
loc_oFrm.grd.Visible = .T.

*-- SetFocus com o form AINDA NAO exibido (equivale a chamada dentro do Init)
TRY
    loc_oFrm.grd.SetFocus()
    loc_cOut = loc_cOut + "SetFocus form NAO exibido: OK (sem erro)" + CHR(13)+CHR(10)
CATCH TO loc_oErro
    loc_cOut = loc_cOut + "SetFocus form NAO exibido: ERRO " + ;
        TRANSFORM(loc_oErro.ErrorNo) + " [" + loc_oErro.Message + "]" + CHR(13)+CHR(10)
ENDTRY

*-- mesma chamada depois do Show
loc_oFrm.Visible = .T.
TRY
    loc_oFrm.grd.SetFocus()
    loc_cOut = loc_cOut + "SetFocus form Visible=.T.: OK (sem erro)" + CHR(13)+CHR(10)
CATCH TO loc_oErro
    loc_cOut = loc_cOut + "SetFocus form Visible=.T.: ERRO " + ;
        TRANSFORM(loc_oErro.ErrorNo) + " [" + loc_oErro.Message + "]" + CHR(13)+CHR(10)
ENDTRY

STRTOFILE(loc_cOut, "C:\4c\automation\medir_setfocus.txt")
QUIT

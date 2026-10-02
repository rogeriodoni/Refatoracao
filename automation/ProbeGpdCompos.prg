SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
PUBLIC gb_4c_ModoTeste, gc_4c_ArquivoErroTeste, gnConnHandle, gc_4c_UsuarioLogado
gb_4c_ModoTeste = .T.
gc_4c_ArquivoErroTeste = "C:\4c\automation\vfp_err_gpdcompos.txt"
#DEFINE OUT "C:\4c\automation\probe_gpdcompos.txt"
LOCAL loc_oE, loc_oForm, loc_oPg9
STRTOFILE("A: inicio" + CHR(13)+CHR(10), OUT)
TRY
    CD C:\4c\projeto\app\start
    DO config.prg
    gc_4c_UsuarioLogado = "TESTE"
    SET PATH TO (gcCaminhoBase + "," + gcCaminhoClasses + "," + gcCaminhoUtils + "," + gcCaminhoForms + "," + gcCaminhoIcones)
    SET PROCEDURE TO (gcCaminhoClasses + "dataaccess.prg")   ADDITIVE
    SET PROCEDURE TO (gcCaminhoClasses + "businessbase.prg") ADDITIVE
    SET PROCEDURE TO (gcCaminhoClasses + "formbase.prg")     ADDITIVE
    SET PROCEDURE TO (gcCaminhoClasses + "gridbase.prg")     ADDITIVE
    SET PROCEDURE TO (gcCaminhoClasses + "FormErro.prg")     ADDITIVE
    SET PROCEDURE TO (gcCaminhoUtils   + "functions.prg")    ADDITIVE
    SET PROCEDURE TO (gcCaminhoUtils   + "messages.prg")     ADDITIVE
    SET PROCEDURE TO (gcCaminhoUtils   + "validators.prg")   ADDITIVE
    SET PROCEDURE TO (gcCaminhoClasses + "gpdbo.prg")        ADDITIVE
    SET PROCEDURE TO (gcCaminhoClasses + "FormBuscaAuxiliar.prg") ADDITIVE
    SET PROCEDURE TO (gcCaminhoForms + "cadastros\Formgpd.prg") ADDITIVE
    gnConnHandle = SQLSTRINGCONNECT(ObterStringConexao())
    loc_oForm = CREATEOBJECT("Formgpd")
    SET DATASESSION TO loc_oForm.DataSessionId
    loc_oPg9 = loc_oForm.pgf_4c_Paginas.Page2.pgf_4c_Divisoes.Page9
    STRTOFILE("ANTES : ColumnCount=" + TRANSFORM(loc_oPg9.grd_4c_Compos.ColumnCount) + ;
        "  RecordSource=[" + loc_oPg9.grd_4c_Compos.RecordSource + "]" + CHR(13)+CHR(10), OUT, 1)
    loc_oForm.CarregarSigcdcpo("997")
    STRTOFILE("DEPOIS: ColumnCount=" + TRANSFORM(loc_oPg9.grd_4c_Compos.ColumnCount) + ;
        "  RecordSource=[" + loc_oPg9.grd_4c_Compos.RecordSource + "]" + CHR(13)+CHR(10), OUT, 1)
CATCH TO loc_oE
    STRTOFILE("EXCEPTION: " + loc_oE.Message + " Linha:" + TRANSFORM(loc_oE.LineNo) + ;
        " Proc:" + loc_oE.Procedure + CHR(13)+CHR(10), OUT, 1)
ENDTRY
STRTOFILE("Z: fim" + CHR(13)+CHR(10), OUT, 1)
QUIT

*==============================================================================
* ProbeTrf684Rebind.prg - Mede QUAIS propriedades de Column sobrevivem a:
*   (A) uma reatribuicao simples de Grid.RecordSource (alias ainda aberto);
*   (B) a queda do alias (ColumnCount cai a 0) + revinculo por CarregarLista.
* Serve para decidir o que CarregarLista tem de REAPLICAR depois do vinculo.
*==============================================================================
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF

PUBLIC gb_4c_ModoTeste, gb_4c_ValidandoUI, gc_4c_ArquivoErroTeste
gb_4c_ModoTeste        = .T.
gb_4c_ValidandoUI      = .T.
gc_4c_ArquivoErroTeste = "C:\4c\automation\vfp_error_trf684_rebind.txt"

LOCAL loc_cOut, loc_oForm, loc_oErro, loc_oGrd
loc_cOut = "C:\4c\automation\probe_trf684_rebind.txt"
STRTOFILE("INICIO", loc_cOut)

TRY
    CD C:\4c\projeto\app\start
    DO config.prg
    gb_4c_ModoTeste   = .T.
    gb_4c_ValidandoUI = .T.

    SET PATH TO (gcCaminhoBase + "," + gcCaminhoClasses + "," + gcCaminhoUtils + ;
                 "," + gcCaminhoForms + "," + gcCaminhoIcones)
    SET PROCEDURE TO (gcCaminhoClasses + "dataaccess.prg")   ADDITIVE
    SET PROCEDURE TO (gcCaminhoClasses + "businessbase.prg") ADDITIVE
    SET PROCEDURE TO (gcCaminhoClasses + "formbase.prg")     ADDITIVE
    SET PROCEDURE TO (gcCaminhoClasses + "gridbase.prg")     ADDITIVE
    SET PROCEDURE TO (gcCaminhoClasses + "FormErro.prg")     ADDITIVE
    SET PROCEDURE TO (gcCaminhoUtils   + "functions.prg")    ADDITIVE
    SET PROCEDURE TO (gcCaminhoUtils   + "messages.prg")     ADDITIVE
    SET PROCEDURE TO (gcCaminhoUtils   + "validators.prg")   ADDITIVE
    SET PROCEDURE TO (gcCaminhoClasses + "SIGPRTRFBO.prg")   ADDITIVE
    SET PROCEDURE TO (gcCaminhoForms + "operacionais\FormSIGPRTRF.prg") ADDITIVE

    loc_oForm = CREATEOBJECT("FormSIGPRTRF")
    loc_oGrd  = loc_oForm.cnt_4c__Referencia.grd_4c_Dados
    SET DATASESSION TO loc_oForm.DataSessionID

    STRTOFILE(CHR(13)+CHR(10)+"-- APOS Init --" + CHR(13)+CHR(10) + ;
        "C1 Fmt=[" + ALLTRIM(loc_oGrd.Column1.Format) + "] Font=" + loc_oGrd.Column1.FontName + ;
        " Mov=" + TRANSFORM(loc_oGrd.Column1.Movable) + " Res=" + TRANSFORM(loc_oGrd.Column1.Resizable) + ;
        " RO=" + TRANSFORM(loc_oGrd.Column1.ReadOnly) + " W=" + TRANSFORM(loc_oGrd.Column1.Width) + ;
        " Mask=[" + ALLTRIM(loc_oGrd.Column1.Text1.InputMask) + "]" + ;
        " T1Font=" + loc_oGrd.Column1.Text1.FontName + ;
        " T1Border=" + TRANSFORM(loc_oGrd.Column1.Text1.BorderStyle) + ;
        " HdrFont=" + loc_oGrd.Column1.Header1.FontName + ;
        " HdrAlign=" + TRANSFORM(loc_oGrd.Column1.Header1.Alignment) + ;
        CHR(13)+CHR(10) + "C2 RO=" + TRANSFORM(loc_oGrd.Column2.ReadOnly) + ;
        " W=" + TRANSFORM(loc_oGrd.Column2.Width) + " Font=" + loc_oGrd.Column2.FontName + ;
        " Mov=" + TRANSFORM(loc_oGrd.Column2.Movable), loc_cOut, 1)

    *-- (A) reatribuicao simples do RecordSource, alias ainda aberto
    loc_oGrd.RecordSource = "cursor_4c_Produtos"
    STRTOFILE(CHR(13)+CHR(10)+"-- APOS RecordSource simples --" + CHR(13)+CHR(10) + ;
        "ColumnCount=" + TRANSFORM(loc_oGrd.ColumnCount) + ;
        " C1 Fmt=[" + ALLTRIM(loc_oGrd.Column1.Format) + "] Font=" + loc_oGrd.Column1.FontName + ;
        " Mov=" + TRANSFORM(loc_oGrd.Column1.Movable) + " RO=" + TRANSFORM(loc_oGrd.Column1.ReadOnly) + ;
        " W=" + TRANSFORM(loc_oGrd.Column1.Width) + ;
        " Mask=[" + ALLTRIM(loc_oGrd.Column1.Text1.InputMask) + "]" + ;
        " Hdr=[" + ALLTRIM(loc_oGrd.Column1.Header1.Caption) + "]" + ;
        " CS=[" + ALLTRIM(loc_oGrd.Column1.ControlSource) + "]" + ;
        CHR(13)+CHR(10) + "C2 RO=" + TRANSFORM(loc_oGrd.Column2.ReadOnly) + ;
        " W=" + TRANSFORM(loc_oGrd.Column2.Width) + ;
        " Hdr=[" + ALLTRIM(loc_oGrd.Column2.Header1.Caption) + "]", loc_cOut, 1)

    *-- (B) queda do alias + revinculo por CarregarLista
    USE IN cursor_4c_Produtos
    STRTOFILE(CHR(13)+CHR(10)+"-- ALIAS DERRUBADO ColumnCount=" + TRANSFORM(loc_oGrd.ColumnCount), loc_cOut, 1)
    SET DATASESSION TO 1
    loc_oForm.CarregarLista()
    SET DATASESSION TO loc_oForm.DataSessionID
    STRTOFILE(CHR(13)+CHR(10)+"-- APOS CarregarLista --" + CHR(13)+CHR(10) + ;
        "ColumnCount=" + TRANSFORM(loc_oGrd.ColumnCount) + ;
        " C1 Fmt=[" + ALLTRIM(loc_oGrd.Column1.Format) + "] Font=" + loc_oGrd.Column1.FontName + ;
        " Mov=" + TRANSFORM(loc_oGrd.Column1.Movable) + " Res=" + TRANSFORM(loc_oGrd.Column1.Resizable) + ;
        " RO=" + TRANSFORM(loc_oGrd.Column1.ReadOnly) + " W=" + TRANSFORM(loc_oGrd.Column1.Width) + ;
        " Mask=[" + ALLTRIM(loc_oGrd.Column1.Text1.InputMask) + "]" + ;
        " T1Font=" + loc_oGrd.Column1.Text1.FontName + ;
        " T1Border=" + TRANSFORM(loc_oGrd.Column1.Text1.BorderStyle) + ;
        " HdrFont=" + loc_oGrd.Column1.Header1.FontName + ;
        " HdrAlign=" + TRANSFORM(loc_oGrd.Column1.Header1.Alignment) + ;
        CHR(13)+CHR(10) + "C2 RO=" + TRANSFORM(loc_oGrd.Column2.ReadOnly) + ;
        " W=" + TRANSFORM(loc_oGrd.Column2.Width) + " Font=" + loc_oGrd.Column2.FontName + ;
        " Mov=" + TRANSFORM(loc_oGrd.Column2.Movable), loc_cOut, 1)

    SET DATASESSION TO 1
    STRTOFILE(CHR(13)+CHR(10)+"RESULTADO=OK", loc_cOut, 1)
CATCH TO loc_oErro
    STRTOFILE(CHR(13)+CHR(10)+"EXCECAO: " + loc_oErro.Message + ;
              " LN=" + TRANSFORM(loc_oErro.LineNo) + " PROC=" + loc_oErro.Procedure, loc_cOut, 1)
ENDTRY

QUIT

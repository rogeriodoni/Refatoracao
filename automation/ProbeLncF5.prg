*==============================================================================
* ProbeLncF5.prg - prova que FormSIGPRLNC INSTANCIA depois da Fase 5 e le de
* volta as propriedades da Page2 (Format/MaxLength/TabIndex/Alignment,
* container de botoes, caption do Cancelar) + o BINDEVENT em LostFocus.
*==============================================================================
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF

PUBLIC gb_4c_ModoTeste, gc_4c_ArquivoErroTeste, gb_4c_ValidandoUI
gb_4c_ModoTeste        = .T.
gc_4c_ArquivoErroTeste = "C:\4c\automation\probe_lnc_f5_dialogos.txt"

LOCAL lcOut, loc_oForm, loc_oErro, loc_oPg, loc_nI
lcOut = "C:\4c\automation\probe_lnc_f5.txt"
STRTOFILE("CP1 inicio" + CHR(13) + CHR(10), lcOut)

CD C:\4c\projeto\app\start
DO config.prg
STRTOFILE("CP2 config ok" + CHR(13) + CHR(10), lcOut, 1)

SET PATH TO (gc_4c_CaminhoBase + "," + gc_4c_CaminhoClasses + "," + ;
             gc_4c_CaminhoUtils + "," + gc_4c_CaminhoForms + "," + ;
             gc_4c_CaminhoIcones)
SET PROCEDURE TO (gc_4c_CaminhoClasses + "dataaccess.prg")   ADDITIVE
SET PROCEDURE TO (gc_4c_CaminhoClasses + "businessbase.prg") ADDITIVE
SET PROCEDURE TO (gc_4c_CaminhoClasses + "formbase.prg")     ADDITIVE
SET PROCEDURE TO (gc_4c_CaminhoClasses + "gridbase.prg")     ADDITIVE
SET PROCEDURE TO (gc_4c_CaminhoClasses + "FormErro.prg")     ADDITIVE
SET PROCEDURE TO (gc_4c_CaminhoUtils   + "functions.prg")    ADDITIVE
SET PROCEDURE TO (gc_4c_CaminhoUtils   + "messages.prg")     ADDITIVE
SET PROCEDURE TO (gc_4c_CaminhoUtils   + "validators.prg")   ADDITIVE
SET PROCEDURE TO (gc_4c_CaminhoClasses + "SIGPRLNCBO.prg")   ADDITIVE
SET PROCEDURE TO (gc_4c_CaminhoForms + "cadastros\FormSIGPRLNC.prg") ADDITIVE
gb_4c_ValidandoUI = .T.
STRTOFILE("CP3 procedures ok" + CHR(13) + CHR(10), lcOut, 1)

TRY
    loc_oForm = CREATEOBJECT("FormSIGPRLNC")
    STRTOFILE("CP4 CREATEOBJECT VARTYPE=" + VARTYPE(loc_oForm) + CHR(13) + CHR(10), lcOut, 1)

    IF VARTYPE(loc_oForm) = "O"
        loc_oPg = loc_oForm.pgf_4c_Paginas.Page2
        STRTOFILE("CP5 Page2 ControlCount=" + TRANSFORM(loc_oPg.ControlCount) + CHR(13) + CHR(10), lcOut, 1)

        *-- Os 4 fwget: Format / MaxLength / TabIndex / Top / Left / Width
        FOR loc_nI = 1 TO 4
            LOCAL lcN
            lcN = ICASE(loc_nI=1, "txt_4c_Grupo", loc_nI=2, "txt_4c_Desc_Gru", ;
                        loc_nI=3, "txt_4c_Contas", "txt_4c_Desc_Con")
            STRTOFILE(lcN + ": Format=[" + EVALUATE("loc_oPg." + lcN + ".Format") + "]" + ;
                " MaxLength=" + TRANSFORM(EVALUATE("loc_oPg." + lcN + ".MaxLength")) + ;
                " TabIndex="  + TRANSFORM(EVALUATE("loc_oPg." + lcN + ".TabIndex")) + ;
                " Top="       + TRANSFORM(EVALUATE("loc_oPg." + lcN + ".Top")) + ;
                " Left="      + TRANSFORM(EVALUATE("loc_oPg." + lcN + ".Left")) + ;
                " Width="     + TRANSFORM(EVALUATE("loc_oPg." + lcN + ".Width")) + ;
                " Visible="   + TRANSFORM(EVALUATE("loc_oPg." + lcN + ".Visible")) + ;
                CHR(13) + CHR(10), lcOut, 1)
        ENDFOR

        *-- Labels: Alignment / TabIndex / Caption
        STRTOFILE("lbl_4c_Label2: Caption=[" + loc_oPg.lbl_4c_Label2.Caption + "]" + ;
            " Alignment=" + TRANSFORM(loc_oPg.lbl_4c_Label2.Alignment) + ;
            " TabIndex="  + TRANSFORM(loc_oPg.lbl_4c_Label2.TabIndex) + ;
            " Top="       + TRANSFORM(loc_oPg.lbl_4c_Label2.Top) + ;
            " ForeColor=" + TRANSFORM(loc_oPg.lbl_4c_Label2.ForeColor) + CHR(13) + CHR(10), lcOut, 1)
        STRTOFILE("lbl_4c_Label3: Caption=[" + loc_oPg.lbl_4c_Label3.Caption + "]" + ;
            " Alignment=" + TRANSFORM(loc_oPg.lbl_4c_Label3.Alignment) + ;
            " TabIndex="  + TRANSFORM(loc_oPg.lbl_4c_Label3.TabIndex) + CHR(13) + CHR(10), lcOut, 1)

        *-- Container de botoes + captions
        STRTOFILE("cnt_4c_BotoesAcao: Top=" + TRANSFORM(loc_oPg.cnt_4c_BotoesAcao.Top) + ;
            " Left="     + TRANSFORM(loc_oPg.cnt_4c_BotoesAcao.Left) + ;
            " Width="    + TRANSFORM(loc_oPg.cnt_4c_BotoesAcao.Width) + ;
            " TabIndex=" + TRANSFORM(loc_oPg.cnt_4c_BotoesAcao.TabIndex) + CHR(13) + CHR(10), lcOut, 1)
        STRTOFILE("cmd_4c_Salvar.Caption=["   + loc_oPg.cnt_4c_BotoesAcao.cmd_4c_Salvar.Caption + "]" + ;
            " cmd_4c_Cancelar.Caption=[" + loc_oPg.cnt_4c_BotoesAcao.cmd_4c_Cancelar.Caption + "]" + ;
            CHR(13) + CHR(10), lcOut, 1)

        *-- Faixa do cabecalho (regra #11) e o 1o controle de dados abaixo dela
        STRTOFILE("cnt_4c_Cabecalho: Top=" + TRANSFORM(loc_oPg.cnt_4c_Cabecalho.Top) + ;
            " Height="    + TRANSFORM(loc_oPg.cnt_4c_Cabecalho.Height) + ;
            " BackColor=" + TRANSFORM(loc_oPg.cnt_4c_Cabecalho.BackColor) + ;
            " TituloCaption=[" + loc_oPg.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption + "]" + ;
            CHR(13) + CHR(10), lcOut, 1)

        *-- BINDEVENT: o lookup tem de estar em LostFocus, nao em KeyPress
        LOCAL ARRAY laEv[1,5]
        LOCAL lnQ
        lnQ = AEVENTS(laEv, loc_oPg.txt_4c_Grupo)
        STRTOFILE("AEVENTS txt_4c_Grupo n=" + TRANSFORM(lnQ) + CHR(13) + CHR(10), lcOut, 1)
        FOR loc_nI = 1 TO lnQ
            STRTOFILE("   evento=[" + laEv[loc_nI, 3] + "] -> metodo=[" + laEv[loc_nI, 4] + "]" + ;
                CHR(13) + CHR(10), lcOut, 1)
        ENDFOR
        lnQ = AEVENTS(laEv, loc_oPg.txt_4c_Contas)
        STRTOFILE("AEVENTS txt_4c_Contas n=" + TRANSFORM(lnQ) + CHR(13) + CHR(10), lcOut, 1)
        FOR loc_nI = 1 TO lnQ
            STRTOFILE("   evento=[" + laEv[loc_nI, 3] + "] -> metodo=[" + laEv[loc_nI, 4] + "]" + ;
                CHR(13) + CHR(10), lcOut, 1)
        ENDFOR

        *-- Flag de reentrancia tem de nascer .F.
        STRTOFILE("this_lEmLookup=" + TRANSFORM(loc_oForm.this_lEmLookup) + CHR(13) + CHR(10), lcOut, 1)

        loc_oForm.Release()
        STRTOFILE("CP6 Release ok" + CHR(13) + CHR(10), lcOut, 1)
    ENDIF
CATCH TO loc_oErro
    STRTOFILE("ERRO: " + loc_oErro.Message + " Linha=" + TRANSFORM(loc_oErro.LineNo) + ;
              " Proc=" + loc_oErro.Procedure + CHR(13) + CHR(10), lcOut, 1)
ENDTRY

STRTOFILE("CP7 fim" + CHR(13) + CHR(10), lcOut, 1)
QUIT

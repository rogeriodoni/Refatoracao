SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF

PUBLIC gb_4c_ModoTeste, gb_4c_ValidandoUI, gc_4c_ArquivoErroTeste
gb_4c_ModoTeste        = .T.
gb_4c_ValidandoUI      = .T.
gc_4c_ArquivoErroTeste = "C:\4c\automation\vfp_error_gl2_f8.txt"
IF FILE(gc_4c_ArquivoErroTeste)
    DELETE FILE (gc_4c_ArquivoErroTeste)
ENDIF

LOCAL loc_cRes, loc_oForm, loc_oErro, loc_nSessaoAnt, loc_oG
loc_cRes = "FAIL"

TRY
    CD C:\4c\projeto\app\start
    DO config.prg

    SET PATH TO (gcCaminhoBase + "," + gcCaminhoClasses + "," + gcCaminhoUtils + "," + gcCaminhoForms + "," + gcCaminhoIcones)
    SET PROCEDURE TO (gcCaminhoClasses + "dataaccess.prg")   ADDITIVE
    SET PROCEDURE TO (gcCaminhoClasses + "businessbase.prg") ADDITIVE
    SET PROCEDURE TO (gcCaminhoClasses + "formbase.prg")     ADDITIVE
    SET PROCEDURE TO (gcCaminhoUtils   + "functions.prg")    ADDITIVE
    SET PROCEDURE TO (gcCaminhoUtils   + "messages.prg")     ADDITIVE
    SET PROCEDURE TO (gcCaminhoClasses + "SigPrGl2BO.prg")   ADDITIVE
    SET PROCEDURE TO (gcCaminhoForms + "operacionais\FormSigPrGl2.prg") ADDITIVE

    loc_oForm = CREATEOBJECT("FormSigPrGl2", .NULL., 1, .F., 0, .F., "", "")

    IF VARTYPE(loc_oForm) != "O"
        loc_cRes = "FAIL VARTYPE=" + VARTYPE(loc_oForm)
    ELSE
        loc_cRes = "FORM OK"

        *-- 1) Metodos novos da Fase 8 existem e sao PUBLIC (chamaveis de fora)
        loc_cRes = loc_cRes + CHR(13)+CHR(10) + "--- FASE 8: metodos ---" + CHR(13)+CHR(10) + ;
            "CarregarDados="                  + TRANSFORM(PEMSTATUS(loc_oForm, "CarregarDados", 5)) + ;
            " SincronizarBOComLinhaCorrente=" + TRANSFORM(PEMSTATUS(loc_oForm, "SincronizarBOComLinhaCorrente", 5))

        *-- 2) ControlSource transcritos do Init legado
        loc_oG = loc_oForm.grd_4c_Operacoes
        loc_cRes = loc_cRes + CHR(13)+CHR(10) + "--- GradeOperacao ControlSource ---" + CHR(13)+CHR(10) + ;
            "C5=[" + loc_oG.Column5.ControlSource + "]" + CHR(13)+CHR(10) + ;
            "C8=[" + loc_oG.Column8.ControlSource + "]" + CHR(13)+CHR(10) + ;
            "C9=[" + loc_oG.Column9.ControlSource + "]"
        loc_cRes = loc_cRes + CHR(13)+CHR(10) + "Widths=" + ;
            TRANSFORM(loc_oG.Column1.Width) + "/" + TRANSFORM(loc_oG.Column2.Width) + "/" + ;
            TRANSFORM(loc_oG.Column5.Width) + "/" + TRANSFORM(loc_oG.Column8.Width) + "/" + ;
            TRANSFORM(loc_oG.Column9.Width) + "/" + TRANSFORM(loc_oG.Column10.Width) + ;
            " RowHeight=" + TRANSFORM(loc_oG.RowHeight) + ;
            " HdrFore=" + TRANSFORM(loc_oG.Column2.Header1.ForeColor) + ;
            " C9Text1Size=" + TRANSFORM(loc_oG.Column9.Text1.FontSize)

        loc_oG = loc_oForm.grd_4c_Itens
        loc_cRes = loc_cRes + CHR(13)+CHR(10) + "--- GradeItens ---" + CHR(13)+CHR(10) + ;
            "C1=[" + loc_oG.Column1.ControlSource + "] C5=[" + loc_oG.Column5.ControlSource + "]" + CHR(13)+CHR(10) + ;
            "ColumnOrder 1/8/6/7/2/3/4/5 = " + ;
            TRANSFORM(loc_oG.Column1.ColumnOrder) + "/" + TRANSFORM(loc_oG.Column8.ColumnOrder) + "/" + ;
            TRANSFORM(loc_oG.Column6.ColumnOrder) + "/" + TRANSFORM(loc_oG.Column7.ColumnOrder) + "/" + ;
            TRANSFORM(loc_oG.Column2.ColumnOrder) + "/" + TRANSFORM(loc_oG.Column3.ColumnOrder) + "/" + ;
            TRANSFORM(loc_oG.Column4.ColumnOrder) + "/" + TRANSFORM(loc_oG.Column5.ColumnOrder)

        *-- 3) Props do SCX recuperadas na Fase 8
        loc_cRes = loc_cRes + CHR(13)+CHR(10) + "--- props SCX ---" + CHR(13)+CHR(10) + ;
            "ObsOper.NullDisplay=["   + loc_oForm.edt_4c_ObsOperacao.NullDisplay + "]" + ;
            " ObsItens.NullDisplay=[" + loc_oForm.edt_4c_ObsItens.NullDisplay + "]" + ;
            " getCliente.SpecialEffect=" + TRANSFORM(loc_oForm.txt_4c_Cliente.SpecialEffect) + ;
            " Cancelar.Cancel=" + TRANSFORM(loc_oForm.cmd_4c_Cancelar.Cancel) + CHR(13)+CHR(10) + ;
            "SelTudo.Picture=[" + JUSTFNAME(loc_oForm.cmd_4c_SelTudo.Picture) + "]" + ;
            " tip=[" + loc_oForm.cmd_4c_SelTudo.ToolTipText + "]" + ;
            " Apaga.tip=[" + loc_oForm.cmd_4c_Apaga.ToolTipText + "]" + ;
            " Shape.BackStyle=" + TRANSFORM(loc_oForm.shp_4c_Shape3.BackStyle)

        *-- 4) CarregarDados + sincronizacao do BO com a linha corrente
        loc_nSessaoAnt = SET("DATASESSION")
        SET DATASESSION TO loc_oForm.DataSessionId

        SELECT TmpCabec
        APPEND BLANK
        REPLACE Flag WITH .T., Emps WITH "001", Dopes WITH "PEDIDO", Numes WITH 7, ;
                Jobs WITH "JOB-A", Conta WITH "C0001", DConta WITH "CLIENTE UM"
        APPEND BLANK
        REPLACE Flag WITH .T., Emps WITH "001", Dopes WITH "PEDIDO", Numes WITH 9, ;
                Jobs WITH "JOB-A", Conta WITH "C0002", DConta WITH "CLIENTE DOIS"

        SELECT TmpItens
        APPEND BLANK
        REPLACE Emps WITH "001", Dopes WITH "PEDIDO", Numes WITH 7, CPros WITH "PROD-7", Qtds WITH 10
        APPEND BLANK
        REPLACE Emps WITH "001", Dopes WITH "PEDIDO", Numes WITH 9, CPros WITH "PROD-9", Qtds WITH 20

        SET DATASESSION TO loc_nSessaoAnt

        loc_cRes = loc_cRes + CHR(13)+CHR(10) + "--- CarregarDados ---" + CHR(13)+CHR(10) + ;
            "retorno=" + TRANSFORM(loc_oForm.CarregarDados())

        SET DATASESSION TO loc_oForm.DataSessionId
        loc_cRes = loc_cRes + CHR(13)+CHR(10) + ;
            "TmpCabec: ordem=" + ORDER("TmpCabec") + " recno=" + TRANSFORM(RECNO("TmpCabec")) + ;
            " Numes=" + TRANSFORM(TmpCabec.Numes) + CHR(13)+CHR(10) + ;
            "TmpItens: ordem=" + ORDER("TmpItens") + " visiveis=" + TRANSFORM(RECCOUNT("TmpItens")) + ;
            " CPros=[" + TmpItens.CPros + "]"
        SET DATASESSION TO loc_nSessaoAnt

        *-- BO deve ter recebido a linha corrente (equivalente BOParaForm)
        loc_cRes = loc_cRes + CHR(13)+CHR(10) + "--- BO sincronizado ---" + CHR(13)+CHR(10) + ;
            "Emps=["    + loc_oForm.this_oBusinessObject.this_cEmps + "]" + ;
            " Dopes=["  + ALLTRIM(loc_oForm.this_oBusinessObject.this_cDopes) + "]" + ;
            " Numes="   + TRANSFORM(loc_oForm.this_oBusinessObject.this_nNumes) + ;
            " Conta=["  + ALLTRIM(loc_oForm.this_oBusinessObject.this_cConta) + "]" + ;
            " Jobs=["   + ALLTRIM(loc_oForm.this_oBusinessObject.this_cJobs) + "]"

        *-- 5) AfterRowColChange move o filtro E re-sincroniza o BO
        SET DATASESSION TO loc_oForm.DataSessionId
        SELECT TmpCabec
        GO BOTTOM
        SET DATASESSION TO loc_nSessaoAnt
        loc_oForm.GradeOperacoesAfterRowColChange(1)
        loc_cRes = loc_cRes + CHR(13)+CHR(10) + "--- apos AfterRowColChange (linha 2) ---" + CHR(13)+CHR(10) + ;
            "BO.Numes="  + TRANSFORM(loc_oForm.this_oBusinessObject.this_nNumes) + ;
            " BO.Conta=[" + ALLTRIM(loc_oForm.this_oBusinessObject.this_cConta) + "]"
        SET DATASESSION TO loc_oForm.DataSessionId
        loc_cRes = loc_cRes + CHR(13)+CHR(10) + ;
            "alias corrente=[" + ALIAS() + "] TmpItens.CPros=[" + TmpItens.CPros + "]" + ;
            " itens visiveis=" + TRANSFORM(RECCOUNT("TmpItens"))
        SET DATASESSION TO loc_nSessaoAnt

        loc_oForm.Release()
    ENDIF
CATCH TO loc_oErro
    loc_cRes = loc_cRes + CHR(13)+CHR(10) + "EXCECAO: " + loc_oErro.Message + ;
               " | Linha:" + TRANSFORM(loc_oErro.LineNo) + " | Proc:" + loc_oErro.Procedure
ENDTRY

IF FILE(gc_4c_ArquivoErroTeste)
    loc_cRes = loc_cRes + CHR(13)+CHR(10) + "--- DIALOGOS CAPTURADOS ---" + CHR(13)+CHR(10) + ;
               FILETOSTR(gc_4c_ArquivoErroTeste)
ENDIF

STRTOFILE(loc_cRes, "C:\4c\automation\instantiate_gl2_f8.txt")
QUIT

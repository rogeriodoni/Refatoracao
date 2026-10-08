*==============================================================================
* InstantiateCheckGlxFase8Final.prg - exercita a superficie ENTREGUE na Fase 8
* do FormSigPrGlx: CarregarLista (publico), BOParaForm/FormParaBO (PROTECTED -
* alcancados por subclasse Probe), GradeItensPage1Column10Valid e o rebind da
* grade principal (Header/Width/ReadOnly preservados).
*==============================================================================
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF

PUBLIC gb_4c_ModoTeste, gc_4c_ArquivoErroTeste, gc_4c_LogGlxF8
gb_4c_ModoTeste        = .T.
gc_4c_ArquivoErroTeste = "C:\4c\automation\vfp_error_glxf8final.txt"
gc_4c_LogGlxF8         = "C:\4c\automation\logs\instantiate_glxfase8_final.txt"

IF FILE(gc_4c_ArquivoErroTeste)
    DELETE FILE (gc_4c_ArquivoErroTeste)
ENDIF
IF FILE(gc_4c_LogGlxF8)
    DELETE FILE (gc_4c_LogGlxF8)
ENDIF

LOCAL loc_oForm, loc_oErro, loc_oGrd, lnVis, lnEv, i

LogF("GLX FASE8 FINAL - inicio " + TTOC(DATETIME()))

TRY
    CD C:\4c\projeto\app\start
    DO config.prg
    SET PATH TO (gcCaminhoBase + "," + gcCaminhoClasses + "," + gcCaminhoUtils + ;
                 "," + gcCaminhoForms + "," + gcCaminhoIcones)
    SET PROCEDURE TO (gcCaminhoClasses + "dataaccess.prg")        ADDITIVE
    SET PROCEDURE TO (gcCaminhoClasses + "businessbase.prg")      ADDITIVE
    SET PROCEDURE TO (gcCaminhoClasses + "formbase.prg")          ADDITIVE
    SET PROCEDURE TO (gcCaminhoClasses + "gridbase.prg")          ADDITIVE
    SET PROCEDURE TO (gcCaminhoClasses + "FormErro.prg")          ADDITIVE
    SET PROCEDURE TO (gcCaminhoClasses + "formbuscaauxiliar.prg") ADDITIVE
    SET PROCEDURE TO (gcCaminhoUtils   + "functions.prg")         ADDITIVE
    SET PROCEDURE TO (gcCaminhoUtils   + "messages.prg")          ADDITIVE
    SET PROCEDURE TO (gcCaminhoUtils   + "validators.prg")        ADDITIVE
    SET PROCEDURE TO (gcCaminhoClasses + "SigPrGlxBO.prg")        ADDITIVE
    SET PROCEDURE TO (gcCaminhoForms + "operacionais\FormSigPrGlx.prg") ADDITIVE
    LogF("0 SETUP: OK")
CATCH TO loc_oErro
    LogF("0 SETUP FALHOU: " + loc_oErro.Message)
ENDTRY

TRY
    loc_oForm = CREATEOBJECT("ProbeGlxF8")
    LogF("1 INSTANCIA Probe: VARTYPE=" + VARTYPE(loc_oForm))
CATCH TO loc_oErro
    LogF("1 INSTANCIA FALHOU: " + loc_oErro.Message + ;
        " LN=" + TRANSFORM(loc_oErro.LineNo) + " PROC=" + loc_oErro.Procedure)
ENDTRY

IF VARTYPE(loc_oForm) = "O"
    SET DATASESSION TO loc_oForm.DataSessionId

    *-- Popula TmpFinalg (2 itens) e os dois cursores de resumo com linhas
    *-- de AMBOS os itens - so assim da para provar que a grade de resumo
    *-- fica FILTRADA no item corrente (SET KEY) e nao so posicionada.
    TRY
        SELECT TmpFinalg
        ZAP
        APPEND BLANK
        REPLACE CPros WITH "PROD001", CodCors WITH "01", CodTams WITH "M", ;
            Linhas WITH "LINHA1", Qtds WITH 1, Saldo WITH 100, Estoque WITH 0, ;
            Produzir WITH 100, Fabrs WITH 0, Produzir2 WITH 0, TotVenda WITH 10, ;
            QtdMins WITH 5 IN TmpFinalg
        APPEND BLANK
        REPLACE CPros WITH "PROD002", CodCors WITH "02", CodTams WITH "G", ;
            Linhas WITH "LINHA2", Qtds WITH 1, Saldo WITH 80, Estoque WITH 20, ;
            Produzir WITH 50, Fabrs WITH 10, Produzir2 WITH 0, TotVenda WITH 5, ;
            QtdMins WITH 2 IN TmpFinalg
        GO TOP IN TmpFinalg

        SELECT cursor_4c_TmpSaldg
        ZAP
        APPEND BLANK
        REPLACE Emps WITH "001", Grupos WITH "GRP01", Estos WITH "CTA01", ;
            CPros WITH "PROD001", CodCors WITH "01", CodTams WITH "M", ;
            Saldo WITH 100, Disps WITH 60, Priors WITH 1 IN cursor_4c_TmpSaldg
        APPEND BLANK
        REPLACE Emps WITH "001", Grupos WITH "GRP02", Estos WITH "CTA02", ;
            CPros WITH "PROD002", CodCors WITH "02", CodTams WITH "G", ;
            Saldo WITH 80, Disps WITH 30, Priors WITH 1 IN cursor_4c_TmpSaldg
        APPEND BLANK
        REPLACE Emps WITH "001", Grupos WITH "GRP03", Estos WITH "CTA03", ;
            CPros WITH "PROD002", CodCors WITH "02", CodTams WITH "G", ;
            Saldo WITH 10, Disps WITH 10, Priors WITH 2 IN cursor_4c_TmpSaldg

        SELECT cursor_4c_TmpSaldo
        ZAP
        APPEND BLANK
        REPLACE CPros WITH "PROD001", CodCors WITH "01", CodTams WITH "M", ;
            Saldo WITH 100, Disps WITH 60, Fabrs WITH 0, DispFs WITH 0 IN cursor_4c_TmpSaldo
        APPEND BLANK
        REPLACE CPros WITH "PROD002", CodCors WITH "02", CodTams WITH "G", ;
            Saldo WITH 80, Disps WITH 30, Fabrs WITH 10, DispFs WITH 5 IN cursor_4c_TmpSaldo

        SELECT TmpSaldU
        ZAP

        SELECT TmpFinal
        ZAP
        APPEND BLANK
        REPLACE CPros WITH "PROD001", CodCors WITH "01", CodTams WITH "M", ;
            Saldo WITH 100, Estoque WITH 0, Produzir WITH 100, Fabrs WITH 0 IN TmpFinal

        GO TOP IN TmpFinalg
        LogF("2 CURSORES populados: TmpFinalg=" + TRANSFORM(RECCOUNT("TmpFinalg")) + ;
            " TmpSaldg=" + TRANSFORM(RECCOUNT("cursor_4c_TmpSaldg")) + ;
            " TmpSaldo=" + TRANSFORM(RECCOUNT("cursor_4c_TmpSaldo")))
    CATCH TO loc_oErro
        LogF("2 POPULAR FALHOU: " + loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo))
    ENDTRY

    *-- (A) CarregarLista - metodo exigido pela Fase 8
    TRY
        LogF("3 CarregarLista retorno=" + TRANSFORM(loc_oForm.CarregarLista()))
        loc_oGrd = loc_oForm.pgf_4c_1.Page1.grd_4c_Dados
        LogF("3a grade principal: RS=[" + loc_oGrd.RecordSource + "] ColCount=" + ;
            TRANSFORM(loc_oGrd.ColumnCount) + ;
            " H1=[" + loc_oGrd.Column1.Header1.Caption + "]" + ;
            " H10=[" + loc_oGrd.Column10.Header1.Caption + "]" + ;
            " W1=" + TRANSFORM(loc_oGrd.Column1.Width) + ;
            " W10=" + TRANSFORM(loc_oGrd.Column10.Width) + ;
            " C1.RO=" + TRANSFORM(loc_oGrd.Column1.ReadOnly) + ;
            " C7.RO=" + TRANSFORM(loc_oGrd.Column7.ReadOnly) + ;
            " C10.RO=" + TRANSFORM(loc_oGrd.Column10.ReadOnly))
        LogF("3b totais Page1: Qtd=" + TRANSFORM(loc_oForm.pgf_4c_1.Page1.txt_4c_Tot_Qtd.Value) + ;
            " Est=" + TRANSFORM(loc_oForm.pgf_4c_1.Page1.txt_4c_Tot_Est.Value) + ;
            " (esperado Qtd=180 Est=20)")
    CATCH TO loc_oErro
        LogF("3 CarregarLista FALHOU: " + loc_oErro.Message + ;
            " LN=" + TRANSFORM(loc_oErro.LineNo) + " PROC=" + loc_oErro.Procedure)
    ENDTRY

    *-- (B) SET KEY filtrou a grade de resumo no item corrente?
    TRY
        SELECT cursor_4c_TmpSaldg
        GO TOP
        COUNT TO lnVis
        LogF("4 item1 (PROD001): linhas VISIVEIS em TmpSaldg=" + TRANSFORM(lnVis) + ;
            " (esperado 1 de 3 - SET FILTER por item ativo)")

        SELECT TmpFinalg
        GO BOTTOM
        loc_oForm.GradeItensPage1AfterRowColChange(1)
        SELECT cursor_4c_TmpSaldg
        GO TOP
        COUNT TO lnVis
        LogF("4b item2 (PROD002): linhas VISIVEIS em TmpSaldg=" + TRANSFORM(lnVis) + ;
            " (esperado 2 - SET FILTER reemitido na troca de linha)")
        SELECT TmpFinalg
        GO TOP
        loc_oForm.GradeItensPage1AfterRowColChange(1)
    CATCH TO loc_oErro
        LogF("4 FILTRO FALHOU: " + loc_oErro.Message + ;
            " LN=" + TRANSFORM(loc_oErro.LineNo) + " PROC=" + loc_oErro.Procedure)
    ENDTRY

    *-- (C) BOParaForm / FormParaBO - PROTECTED, so alcancaveis pela subclasse
    TRY
        LogF("5 BOParaForm: " + loc_oForm.ProbeBOParaForm())
    CATCH TO loc_oErro
        LogF("5 BOParaForm FALHOU: " + loc_oErro.Message + ;
            " LN=" + TRANSFORM(loc_oErro.LineNo) + " PROC=" + loc_oErro.Procedure)
    ENDTRY
    TRY
        LogF("6 FormParaBO retorno=" + TRANSFORM(loc_oForm.ProbeFormParaBO()))
    CATCH TO loc_oErro
        LogF("6 FormParaBO FALHOU: " + loc_oErro.Message + ;
            " LN=" + TRANSFORM(loc_oErro.LineNo) + " PROC=" + loc_oErro.Procedure)
    ENDTRY

    *-- (D) Column10 Valid - a coluna "Qtd Estoque" que a migracao tinha perdido
    TRY
        SELECT TmpFinalg
        GO TOP
        *-- simula o GotFocus (captura do "ThisForm.OldValue" do legado)
        loc_oForm.this_nOldValue = 0
        loc_oForm.pgf_4c_1.Page1.grd_4c_Dados.Column10.Text1.Value = -5
        loc_oForm.GradeItensPage1Column10Valid()
        LogF("7a Column10Valid com -5 (negativo): nao estourou - Value restaurado=" + ;
            TRANSFORM(loc_oForm.pgf_4c_1.Page1.grd_4c_Dados.Column10.Text1.Value) + " (esperado 0)")

        SELECT TmpFinalg
        GO TOP
        loc_oForm.this_nOldValue = 0
        loc_oForm.pgf_4c_1.Page1.grd_4c_Dados.Column10.Text1.Value = 40
        loc_oForm.GradeItensPage1Column10Valid()
        LogF("7b Column10Valid com 40 (valido): TmpSaldo.Disps=" + ;
            TRANSFORM(cursor_4c_TmpSaldo.Disps) + " (esperado 60) " + ;
            "TmpFinalg.Produzir=" + TRANSFORM(TmpFinalg.Produzir) + " (esperado 60)")
    CATCH TO loc_oErro
        LogF("7 Column10Valid FALHOU: " + loc_oErro.Message + ;
            " LN=" + TRANSFORM(loc_oErro.LineNo) + " PROC=" + loc_oErro.Procedure)
    ENDTRY

    *-- (E) GotFocus NAO pode estar ligado nas colunas digitaveis (7/8/10)
    TRY
        LOCAL ARRAY laEv[1]
        lnEv = AEVENTS(laEv, loc_oForm.pgf_4c_1.Page1.grd_4c_Dados.Column10.Text1)
        LogF("8 AEVENTS Column10.Text1=" + TRANSFORM(lnEv) + ;
            " (Valid+LostFocus esperados; GotFocus NAO pode aparecer)")
        FOR i = 1 TO lnEv
            LogF("   evento[" + TRANSFORM(i) + "]=" + laEv[i, 3])
        ENDFOR
    CATCH TO loc_oErro
        LogF("8 AEVENTS FALHOU: " + loc_oErro.Message)
    ENDTRY

    SET DATASESSION TO 1
    TRY
        loc_oForm.Release()
        LogF("9 RELEASE: OK")
    CATCH TO loc_oErro
        LogF("9 RELEASE FALHOU: " + loc_oErro.Message)
    ENDTRY
ENDIF

IF FILE(gc_4c_ArquivoErroTeste)
    LogF("DIALOGOS SUPRIMIDOS:" + CHR(13) + CHR(10) + FILETOSTR(gc_4c_ArquivoErroTeste))
ELSE
    LogF("DIALOGOS: nenhum")
ENDIF

LogF("FIM " + TTOC(DATETIME()))
QUIT

PROCEDURE LogF(par_cTexto)
    STRTOFILE(par_cTexto + CHR(13) + CHR(10), gc_4c_LogGlxF8, 1)
ENDPROC

*-- Subclasse de sondagem: metodo PROTECTED so eh alcancavel de dentro da
*-- hierarquia (regra medida em task585) - script solto recebe
*-- "Property BOPARAFORM is not found".
DEFINE CLASS ProbeGlxF8 AS FormSigPrGlx
    PROCEDURE ProbeBOParaForm()
        THIS.BOParaForm()
        RETURN "Periodo=[" + THIS.pgf_4c_1.Page1.cnt_4c_Container5.lbl_4c_LabPeriodo.Caption + "]" + ;
            " Pedras.Visible=" + TRANSFORM(THIS.pgf_4c_1.Page1.cmd_4c_Pedras.Visible) + ;
            " SelEstoque.Visible=" + TRANSFORM(THIS.pgf_4c_1.Page1.cmd_4c_SelEstoque.Visible) + ;
            " Caption=[" + THIS.Caption + "]"
    ENDPROC
    PROCEDURE ProbeFormParaBO()
        RETURN THIS.FormParaBO()
    ENDPROC
ENDDEFINE

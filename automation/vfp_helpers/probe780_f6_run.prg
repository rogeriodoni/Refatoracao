*-- Probe Fase 6 (task780): instancia o Formsigoppei e confere os 3 totais
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
SET EXCLUSIVE OFF

PUBLIC gb_4c_ModoTeste, gc_4c_ArquivoErroTeste
gb_4c_ModoTeste        = .T.
gc_4c_ArquivoErroTeste = "C:\4c\automation\vfp_helpers\probe780_f6_erro.txt"

LOCAL lcSaida, lcArq, loForm, loErr, lnTot
lcSaida = ""
lcArq   = "C:\4c\automation\vfp_helpers\probe780_f6_run_out.txt"

CD "C:\4c\projeto\app\start"

TRY
    DO config.prg
    ConfigurarAmbiente()
    GarantirClasse("Formsigoppei")
    lcSaida = lcSaida + "AMBIENTE_OK" + CHR(13) + CHR(10)
CATCH TO loErr
    lcSaida = lcSaida + "ERRO_AMBIENTE: " + loErr.Message + CHR(13) + CHR(10)
ENDTRY

*===========================================================================
* CASO 1 - SEM os cursores do form pai (xBaixa/xBaixa2 ausentes).
* Esperado: a tela ABRE (bypass de gb_4c_ModoTeste) com grade e os 3 totais
* OCULTOS e em zero - o estado em que o Init legado os deixa antes do If.
*===========================================================================
TRY
    loForm = CREATEOBJECT("Formsigoppei")
    lcSaida = lcSaida + "CASO1 VARTYPE(loForm) = " + VARTYPE(loForm) + CHR(13) + CHR(10)
    IF VARTYPE(loForm) = "O"
        lcSaida = lcSaida + "CASO1 totitens existe=" + ;
            TRANSFORM(PEMSTATUS(loForm, "txt_4c_Totitens", 5)) + ;
            " totbaixa existe=" + TRANSFORM(PEMSTATUS(loForm, "txt_4c_Totbaixa", 5)) + ;
            " totdisp existe="  + TRANSFORM(PEMSTATUS(loForm, "txt_4c_Totdisp", 5)) + CHR(13) + CHR(10)
        WITH loForm.txt_4c_Totitens
            lcSaida = lcSaida + "CASO1 totitens Top=" + TRANSFORM(.Top) + ;
                " Left=" + TRANSFORM(.Left) + " W=" + TRANSFORM(.Width) + ;
                " H=" + TRANSFORM(.Height) + " Align=" + TRANSFORM(.Alignment) + ;
                " Fmt=[" + .Format + "] Font=" + .FontName + "/" + TRANSFORM(.FontSize) + ;
                " SpecEff=" + TRANSFORM(.SpecialEffect) + ;
                " BackColor=" + TRANSFORM(.BackColor) + ;
                " RO=" + TRANSFORM(.ReadOnly) + " TabStop=" + TRANSFORM(.TabStop) + ;
                " Vis=" + TRANSFORM(.Visible) + " Val=" + TRANSFORM(.Value) + ;
                " Mask=[" + .InputMask + "]" + CHR(13) + CHR(10)
        ENDWITH
        WITH loForm.txt_4c_Totbaixa
            lcSaida = lcSaida + "CASO1 totbaixa Left=" + TRANSFORM(.Left) + ;
                " Vis=" + TRANSFORM(.Visible) + " Val=" + TRANSFORM(.Value) + CHR(13) + CHR(10)
        ENDWITH
        WITH loForm.txt_4c_Totdisp
            lcSaida = lcSaida + "CASO1 totdisp Left=" + TRANSFORM(.Left) + ;
                " Vis=" + TRANSFORM(.Visible) + " Val=" + TRANSFORM(.Value) + CHR(13) + CHR(10)
        ENDWITH
        lcSaida = lcSaida + "CASO1 grade Vis=" + TRANSFORM(loForm.grd_4c_Dados.Visible) + ;
            " ColumnCount=" + TRANSFORM(loForm.grd_4c_Dados.ColumnCount) + CHR(13) + CHR(10)
        lcSaida = lcSaida + "CASO1 cprod Vis=" + TRANSFORM(loForm.txt_4c_CProd.Visible) + ;
            " dprod Vis=" + TRANSFORM(loForm.txt_4c_DProd.Visible) + ;
            " lbl2 Vis=" + TRANSFORM(loForm.lbl_4c_Label2.Visible) + CHR(13) + CHR(10)
        loForm.Release()
    ENDIF
CATCH TO loErr
    lcSaida = lcSaida + "ERRO_CASO1: " + loErr.Message + " LN=" + TRANSFORM(loErr.LineNo) + ;
        " PROC=" + loErr.Procedure + CHR(13) + CHR(10)
ENDTRY
loForm = .NULL.

*===========================================================================
* CASO 2 - COM os cursores do form pai, ramo xBaixa2 VAZIO (exibicao vem de
* xBaixa). Esperado: grade e totais VISIVEIS, com Sum qtds = 30,
* Sum qtbaixas = 12 e disponivel = 18.
*===========================================================================
TRY
    CREATE CURSOR xBaixa2 (CPros C(14), CodCors C(4), CodTams C(4), ;
                           Qtds N(12,3), QtBaixas N(12,3), QtProds N(12,3))
    CREATE CURSOR xBaixa  (CPros C(14), Qtds N(12,3), QtBaixas N(12,3), QtProds N(12,3))
    INSERT INTO xBaixa (CPros, Qtds, QtBaixas, QtProds) VALUES ("0001", 10, 4, 10)
    INSERT INTO xBaixa (CPros, Qtds, QtBaixas, QtProds) VALUES ("0002", 20, 8, 20)

    loForm = CREATEOBJECT("Formsigoppei")
    lcSaida = lcSaida + "CASO2 VARTYPE(loForm) = " + VARTYPE(loForm) + CHR(13) + CHR(10)
    IF VARTYPE(loForm) = "O"
        lcSaida = lcSaida + "CASO2 totitens Val=" + TRANSFORM(loForm.txt_4c_Totitens.Value) + ;
            " Vis=" + TRANSFORM(loForm.txt_4c_Totitens.Visible) + CHR(13) + CHR(10)
        lcSaida = lcSaida + "CASO2 totbaixa Val=" + TRANSFORM(loForm.txt_4c_Totbaixa.Value) + ;
            " Vis=" + TRANSFORM(loForm.txt_4c_Totbaixa.Visible) + CHR(13) + CHR(10)
        lcSaida = lcSaida + "CASO2 totdisp Val=" + TRANSFORM(loForm.txt_4c_Totdisp.Value) + ;
            " Vis=" + TRANSFORM(loForm.txt_4c_Totdisp.Visible) + CHR(13) + CHR(10)
        lcSaida = lcSaida + "CASO2 grade Vis=" + TRANSFORM(loForm.grd_4c_Dados.Visible) + ;
            " RecSrc=[" + loForm.grd_4c_Dados.RecordSource + "]" + CHR(13) + CHR(10)
        lcSaida = lcSaida + "CASO2 BO tot=" + ;
            TRANSFORM(loForm.this_oBusinessObject.this_nTotItens) + "/" + ;
            TRANSFORM(loForm.this_oBusinessObject.this_nTotBaixa) + "/" + ;
            TRANSFORM(loForm.this_oBusinessObject.this_nTotDisp) + ;
            " regs=" + TRANSFORM(loForm.this_oBusinessObject.this_nTotalRegistros) + CHR(13) + CHR(10)
        lcSaida = lcSaida + "CASO2 cprod Vis=" + TRANSFORM(loForm.txt_4c_CProd.Visible) + ;
            " dprod Vis=" + TRANSFORM(loForm.txt_4c_DProd.Visible) + CHR(13) + CHR(10)

        *-- Recarga: o funil tem de manter tudo coerente ao rodar 2 vezes
        lnTot = loForm.CarregarLista()
        lcSaida = lcSaida + "CASO2 recarga CarregarLista=" + TRANSFORM(lnTot) + ;
            " totitens=" + TRANSFORM(loForm.txt_4c_Totitens.Value) + ;
            " Vis=" + TRANSFORM(loForm.txt_4c_Totitens.Visible) + CHR(13) + CHR(10)
        loForm.Release()
    ENDIF
CATCH TO loErr
    lcSaida = lcSaida + "ERRO_CASO2: " + loErr.Message + " LN=" + TRANSFORM(loErr.LineNo) + ;
        " PROC=" + loErr.Procedure + CHR(13) + CHR(10)
ENDTRY

lcSaida = lcSaida + "FIM" + CHR(13) + CHR(10)
STRTOFILE(lcSaida, lcArq)
QUIT

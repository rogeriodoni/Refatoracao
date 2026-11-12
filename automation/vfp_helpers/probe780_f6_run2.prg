*-- Probe Fase 6 (task780) - CASO 2/3: com os cursores do form PAI na MESMA
*-- data session (o form entra na sessao do pai, como o legado faz com
*-- "Set DataSession to pnDatSes"). Sem pai, DataSession = 2 isola a sessao e
*-- xBaixa/xBaixa2 criados no probe ficam invisiveis para o dialogo.
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
SET EXCLUSIVE OFF

PUBLIC gb_4c_ModoTeste, gc_4c_ArquivoErroTeste
gb_4c_ModoTeste        = .T.
gc_4c_ArquivoErroTeste = "C:\4c\automation\vfp_helpers\probe780_f6_erro2.txt"

LOCAL lcSaida, lcArq, loForm, loPai, loErr, llRec
lcSaida = ""
lcArq   = "C:\4c\automation\vfp_helpers\probe780_f6_run2_out.txt"

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
* CASO 2 - ramo xBaixa2 VAZIO: a exibicao vem toda de xBaixa.
* Sum qtds = 30, Sum qtbaixas = 12, disponivel = 18, 2 linhas.
*===========================================================================
TRY
    loPai = CREATEOBJECT("Form")

    CREATE CURSOR xBaixa2 (CPros C(14), CodCors C(4), CodTams C(4), ;
                           Qtds N(12,3), QtBaixas N(12,3), QtProds N(12,3))
    CREATE CURSOR xBaixa  (CPros C(14), Qtds N(12,3), QtBaixas N(12,3), QtProds N(12,3))
    INSERT INTO xBaixa (CPros, Qtds, QtBaixas, QtProds) VALUES ("0001", 10, 4, 10)
    INSERT INTO xBaixa (CPros, Qtds, QtBaixas, QtProds) VALUES ("0002", 20, 8, 20)

    loForm = CREATEOBJECT("Formsigoppei", loPai, loPai.DataSessionId)
    lcSaida = lcSaida + "CASO2 VARTYPE=" + VARTYPE(loForm) + CHR(13) + CHR(10)
    IF VARTYPE(loForm) = "O"
        lcSaida = lcSaida + "CASO2 totitens=" + TRANSFORM(loForm.txt_4c_Totitens.Value) + ;
            " Vis=" + TRANSFORM(loForm.txt_4c_Totitens.Visible) + ;
            " | totbaixa=" + TRANSFORM(loForm.txt_4c_Totbaixa.Value) + ;
            " Vis=" + TRANSFORM(loForm.txt_4c_Totbaixa.Visible) + ;
            " | totdisp=" + TRANSFORM(loForm.txt_4c_Totdisp.Value) + ;
            " Vis=" + TRANSFORM(loForm.txt_4c_Totdisp.Visible) + CHR(13) + CHR(10)
        lcSaida = lcSaida + "CASO2 grade Vis=" + TRANSFORM(loForm.grd_4c_Dados.Visible) + ;
            " RecSrc=[" + loForm.grd_4c_Dados.RecordSource + "]" + ;
            " regs=" + TRANSFORM(loForm.this_oBusinessObject.this_nTotalRegistros) + CHR(13) + CHR(10)
        lcSaida = lcSaida + "CASO2 BO=" + ;
            TRANSFORM(loForm.this_oBusinessObject.this_nTotItens) + "/" + ;
            TRANSFORM(loForm.this_oBusinessObject.this_nTotBaixa) + "/" + ;
            TRANSFORM(loForm.this_oBusinessObject.this_nTotDisp) + CHR(13) + CHR(10)
        lcSaida = lcSaida + "CASO2 cprod Vis=" + TRANSFORM(loForm.txt_4c_CProd.Visible) + ;
            " dprod Vis=" + TRANSFORM(loForm.txt_4c_DProd.Visible) + CHR(13) + CHR(10)

        *-- Recarga pelo funil: tem de dar o MESMO resultado
        llRec = loForm.CarregarLista()
        lcSaida = lcSaida + "CASO2 recarga=" + TRANSFORM(llRec) + ;
            " totitens=" + TRANSFORM(loForm.txt_4c_Totitens.Value) + ;
            " totdisp=" + TRANSFORM(loForm.txt_4c_Totdisp.Value) + ;
            " Vis=" + TRANSFORM(loForm.txt_4c_Totitens.Visible) + CHR(13) + CHR(10)
        loForm.Release()
    ENDIF
CATCH TO loErr
    lcSaida = lcSaida + "ERRO_CASO2: " + loErr.Message + " LN=" + TRANSFORM(loErr.LineNo) + ;
        " PROC=" + loErr.Procedure + CHR(13) + CHR(10)
ENDTRY
loForm = .NULL.

*===========================================================================
* CASO 3 - ramo xBaixa2 COM linhas (UNION ALL): xBaixa2 traz 1 item e xBaixa
* traz outro que NAO esta em xBaixa2. Sum qtds = 10+20 = 30,
* Sum qtbaixas = 4+8 = 12, disponivel = 18, 2 linhas.
*===========================================================================
TRY
    IF USED("xBaixa2")
        USE IN xBaixa2
    ENDIF
    IF USED("xBaixa")
        USE IN xBaixa
    ENDIF
    CREATE CURSOR xBaixa2 (CPros C(14), CodCors C(4), CodTams C(4), ;
                           Qtds N(12,3), QtBaixas N(12,3), QtProds N(12,3))
    INSERT INTO xBaixa2 (CPros, CodCors, CodTams, Qtds, QtBaixas, QtProds) ;
        VALUES ("0001", "VM", "M", 10, 4, 10)
    CREATE CURSOR xBaixa  (CPros C(14), Qtds N(12,3), QtBaixas N(12,3), QtProds N(12,3))
    INSERT INTO xBaixa (CPros, Qtds, QtBaixas, QtProds) VALUES ("0001", 10, 4, 10)
    INSERT INTO xBaixa (CPros, Qtds, QtBaixas, QtProds) VALUES ("0002", 20, 8, 20)

    loForm = CREATEOBJECT("Formsigoppei", loPai, loPai.DataSessionId)
    lcSaida = lcSaida + "CASO3 VARTYPE=" + VARTYPE(loForm) + CHR(13) + CHR(10)
    IF VARTYPE(loForm) = "O"
        lcSaida = lcSaida + "CASO3 totitens=" + TRANSFORM(loForm.txt_4c_Totitens.Value) + ;
            " totbaixa=" + TRANSFORM(loForm.txt_4c_Totbaixa.Value) + ;
            " totdisp="  + TRANSFORM(loForm.txt_4c_Totdisp.Value) + ;
            " Vis=" + TRANSFORM(loForm.txt_4c_Totdisp.Visible) + ;
            " regs=" + TRANSFORM(loForm.this_oBusinessObject.this_nTotalRegistros) + ;
            " gradeVis=" + TRANSFORM(loForm.grd_4c_Dados.Visible) + CHR(13) + CHR(10)
        loForm.Release()
    ENDIF
CATCH TO loErr
    lcSaida = lcSaida + "ERRO_CASO3: " + loErr.Message + " LN=" + TRANSFORM(loErr.LineNo) + ;
        " PROC=" + loErr.Procedure + CHR(13) + CHR(10)
ENDTRY

lcSaida = lcSaida + "FIM" + CHR(13) + CHR(10)
STRTOFILE(lcSaida, lcArq)
QUIT

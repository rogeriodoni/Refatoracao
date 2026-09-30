*==============================================================================
* InstantiateCheckPrCfn.prg - valida a Fase 7 de FormSigPrCfn (Calculo de Juros)
*
* Prova MEDINDO no VFP9 (nao por leitura de codigo):
*   1. o form ainda INSTANCIA depois das mudancas da fase;
*   2. o Init semeia os parametros do legado e roda o calculo inicial;
*   3. o Enabled inicial reproduz o "llEnable = .f." do Init legado;
*   4. TxtDiasGotFocus (NOVO na Fase 7) existe, eh PUBLIC e nao estoura nos
*      tres estados do When de getDias;
*   5. a cadeia de eventos principais funciona chamada de FORA da classe
*      (ValorBase -> habilita; JurosMes -> deriva JurosDia; vencimentos ->
*      parcela; optCalculo -> recalculo);
*   6. BtnSairClick (o unico botao do legado, btnOK) libera o form.
*
* Cada passo eh GRAVADO EM DISCO na hora (LogPasso -> STRTOFILE ADDITIVE): se
* o processo travar, o log mostra exatamente onde parou.
*==============================================================================
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF

PUBLIC gb_4c_ModoTeste, gc_4c_ArquivoErroTeste, gc_4c_LogPassoF7
gb_4c_ModoTeste        = .T.
gc_4c_ArquivoErroTeste = "C:\4c\automation\vfp_error_prcfn.txt"
gc_4c_LogPassoF7       = "C:\4c\automation\instantiate_prcfn_result.txt"

IF FILE(gc_4c_ArquivoErroTeste)
    DELETE FILE (gc_4c_ArquivoErroTeste)
ENDIF
IF FILE(gc_4c_LogPassoF7)
    DELETE FILE (gc_4c_LogPassoF7)
ENDIF

LOCAL loc_oForm, loc_oErro
LogPasso("FASE7 CHECK FormSigPrCfn - inicio " + TTOC(DATETIME()))

TRY
    CD C:\4c\projeto\app\start
    DO config.prg
    ConfigurarAmbiente()
    LogPasso("0 AMBIENTE: OK (gnConnHandle=" + TRANSFORM(gnConnHandle) + ")")
CATCH TO loc_oErro
    LogPasso("0 AMBIENTE FALHOU: " + loc_oErro.Message)
ENDTRY

TRY
    *-- Init do legado: pVal, pTip, pJMe, pJDi, pDtB, pDtF
    loc_oForm = CREATEOBJECT("FormSigPrCfn", 1000, 1, 3, 0, DATE() - 30, DATE())
    LogPasso("1 INSTANCIA: VARTYPE=" + VARTYPE(loc_oForm) + ;
        IIF(VARTYPE(loc_oForm) = "O", " W=" + TRANSFORM(loc_oForm.Width) + ;
        " H=" + TRANSFORM(loc_oForm.Height) + " Cap=[" + loc_oForm.Caption + "]", ""))
CATCH TO loc_oErro
    LogPasso("1 INSTANCIA FALHOU: " + loc_oErro.Message + ;
        " LN=" + TRANSFORM(loc_oErro.LineNo) + " PROC=" + loc_oErro.Procedure)
ENDTRY

IF VARTYPE(loc_oForm) = "O"

    TRY
        LogPasso("2 Init semeou: VB=" + TRANSFORM(loc_oForm.txt_4c_ValorBase.Value) + ;
            " JMes=" + TRANSFORM(loc_oForm.txt_4c_JurosMes.Value) + ;
            " JDia=" + TRANSFORM(loc_oForm.txt_4c_JurosDia.Value) + ;
            " Dias=" + TRANSFORM(loc_oForm.txt_4c_Dias.Value) + ;
            " Juros=" + TRANSFORM(loc_oForm.txt_4c_ValorJuros.Value) + ;
            " Total=" + TRANSFORM(loc_oForm.txt_4c_ValorTotal.Value) + ;
            " Parc=" + TRANSFORM(loc_oForm.txt_4c_Valorpar.Value))
    CATCH TO loc_oErro
        LogPasso("2 FALHOU: " + loc_oErro.Message)
    ENDTRY

    TRY
        LogPasso("3 EnaInicial (legado llEnable=.f.): JMes=" + TRANSFORM(loc_oForm.txt_4c_JurosMes.Enabled) + ;
            " JDia=" + TRANSFORM(loc_oForm.txt_4c_JurosDia.Enabled) + ;
            " DtB=" + TRANSFORM(loc_oForm.txt_4c_DataBase.Enabled) + ;
            " DtF=" + TRANSFORM(loc_oForm.txt_4c_DataFinal.Enabled) + ;
            " Dias=" + TRANSFORM(loc_oForm.txt_4c_Dias.Enabled) + ;
            " OptCalc1=" + TRANSFORM(loc_oForm.obj_4c_OptCalculo.Buttons(1).Enabled) + ;
            " OptDias1=" + TRANSFORM(loc_oForm.obj_4c_OptDias.Buttons(1).Enabled))
    CATCH TO loc_oErro
        LogPasso("3 FALHOU: " + loc_oErro.Message)
    ENDTRY

    *-- 4. TxtDiasGotFocus - NOVO na Fase 7. Num form nunca mostrado (modal,
    *--    sem Show) o SetFocus pode nao ter para onde ir; o que se mede aqui
    *--    eh que o handler EXISTE, eh alcancavel de fora e nao estoura.
    TRY
        LogPasso("4 TxtDiasGotFocus PUBLIC/existe=" + ;
            TRANSFORM(PEMSTATUS(loc_oForm, "TxtDiasGotFocus", 5)))
    CATCH TO loc_oErro
        LogPasso("4 FALHOU: " + loc_oErro.Message)
    ENDTRY

    TRY
        loc_oForm.txt_4c_ValorBase.Value = 1000
        loc_oForm.txt_4c_DataBase.Value  = {}
        loc_oForm.txt_4c_DataFinal.Value = {}
        loc_oForm.TxtDiasGotFocus()
        LogPasso("4a duas datas vazias: chamada OK (When do legado recusa)")
    CATCH TO loc_oErro
        LogPasso("4a duas datas vazias: ERRO[" + loc_oErro.Message + "] PROC=" + loc_oErro.Procedure)
    ENDTRY

    TRY
        loc_oForm.txt_4c_DataBase.Value = DATE() - 30
        loc_oForm.TxtDiasGotFocus()
        LogPasso("4b DataBase preenchida: chamada OK (When do legado libera)")
    CATCH TO loc_oErro
        LogPasso("4b DataBase preenchida: ERRO[" + loc_oErro.Message + "] PROC=" + loc_oErro.Procedure)
    ENDTRY

    TRY
        loc_oForm.txt_4c_ValorBase.Value = 0
        loc_oForm.TxtDiasGotFocus()
        LogPasso("4c ValorBase vazio: chamada OK (When recusa pela 1a metade)")
        loc_oForm.txt_4c_ValorBase.Value = 1000
    CATCH TO loc_oErro
        LogPasso("4c ValorBase vazio: ERRO[" + loc_oErro.Message + "] PROC=" + loc_oErro.Procedure)
    ENDTRY

    *-- 5. cadeia de eventos principais, chamada de FORA (todos PUBLIC)
    TRY
        loc_oForm.txt_4c_ValorBase.Value = 1000
        loc_oForm.TxtValorBaseKeyPress(13, 0)
        LogPasso("5 posValorBase: JMesEna=" + TRANSFORM(loc_oForm.txt_4c_JurosMes.Enabled) + ;
            " DiasEna=" + TRANSFORM(loc_oForm.txt_4c_Dias.Enabled) + ;
            " OptCalc1Ena=" + TRANSFORM(loc_oForm.obj_4c_OptCalculo.Buttons(1).Enabled))
    CATCH TO loc_oErro
        LogPasso("5 FALHOU: " + loc_oErro.Message + " PROC=" + loc_oErro.Procedure)
    ENDTRY

    TRY
        loc_oForm.txt_4c_DataBase.Value  = DATE() - 30
        loc_oForm.txt_4c_DataFinal.Value = DATE()
        loc_oForm.txt_4c_Dias.Value      = 30
        loc_oForm.txt_4c_JurosMes.Value  = 3
        loc_oForm.TxtJurosMesKeyPress(13, 0)
        LogPasso("6 posJurosMes(3%): JDia=" + TRANSFORM(loc_oForm.txt_4c_JurosDia.Value) + ;
            " Juros=" + TRANSFORM(loc_oForm.txt_4c_ValorJuros.Value) + ;
            " Total=" + TRANSFORM(loc_oForm.txt_4c_ValorTotal.Value) + ;
            " [esperado simples: 1000*0.03*30/30=30, total 1030]")
    CATCH TO loc_oErro
        LogPasso("6 FALHOU: " + loc_oErro.Message + " PROC=" + loc_oErro.Procedure)
    ENDTRY

    TRY
        loc_oForm.txt_4c_ValorBase.Value = -5
        loc_oForm.TxtValorBaseKeyPress(13, 0)
        LogPasso("7 ValorBase negativo (legado getValorBase.Valid recusa): VB=" + ;
            TRANSFORM(loc_oForm.txt_4c_ValorBase.Value))
        loc_oForm.txt_4c_ValorBase.Value = 1000
        loc_oForm.TxtValorBaseKeyPress(13, 0)
    CATCH TO loc_oErro
        LogPasso("7 FALHOU: " + loc_oErro.Message + " PROC=" + loc_oErro.Procedure)
    ENDTRY

    TRY
        loc_oForm.txt_4c_Venc1.Value = DATE() + 30
        loc_oForm.TxtVenc1KeyPress(13, 0)
        loc_oForm.txt_4c_Venc2.Value = DATE() + 60
        loc_oForm.TxtVenc2KeyPress(13, 0)
        LogPasso("8 dois vencimentos: Dias=" + TRANSFORM(loc_oForm.txt_4c_Dias.Value) + ;
            " Juros=" + TRANSFORM(loc_oForm.txt_4c_ValorJuros.Value) + ;
            " Total=" + TRANSFORM(loc_oForm.txt_4c_ValorTotal.Value) + ;
            " Parc=" + TRANSFORM(loc_oForm.txt_4c_Valorpar.Value) + " [Parc = Total/2]")
    CATCH TO loc_oErro
        LogPasso("8 FALHOU: " + loc_oErro.Message + " PROC=" + loc_oErro.Procedure)
    ENDTRY

    TRY
        loc_oForm.obj_4c_OptCalculo.Value = 2
        loc_oForm.OptCalculoInteractiveChange()
        LogPasso("9 Composto: Juros=" + TRANSFORM(loc_oForm.txt_4c_ValorJuros.Value))
    CATCH TO loc_oErro
        LogPasso("9 FALHOU: " + loc_oErro.Message + " PROC=" + loc_oErro.Procedure)
    ENDTRY

    TRY
        LogPasso("10 BtnSairClick existe=" + TRANSFORM(PEMSTATUS(loc_oForm, "BtnSairClick", 5)) + ;
            " SairVis=" + TRANSFORM(loc_oForm.cnt_4c_Saida.cmd_4c_Sair.Visible) + ;
            " SairCancel=" + TRANSFORM(loc_oForm.cnt_4c_Saida.cmd_4c_Sair.Cancel))
        loc_oForm.BtnSairClick()
        LogPasso("11 posBtnSairClick: VARTYPE=" + VARTYPE(loc_oForm) + " [X = liberado]")
    CATCH TO loc_oErro
        LogPasso("10/11 FALHOU: " + loc_oErro.Message + " PROC=" + loc_oErro.Procedure)
    ENDTRY
ENDIF

IF FILE("C:\4c\automation\vfp_error_prcfn.txt")
    LogPasso("DIALOGOS SUPRIMIDOS: " + FILETOSTR("C:\4c\automation\vfp_error_prcfn.txt"))
ELSE
    LogPasso("DIALOGOS SUPRIMIDOS: nenhum")
ENDIF

LogPasso("FIM " + TTOC(DATETIME()))
QUIT

PROCEDURE LogPasso(par_cTexto)
    STRTOFILE(par_cTexto + CHR(13) + CHR(10), gc_4c_LogPassoF7, .T.)
ENDPROC

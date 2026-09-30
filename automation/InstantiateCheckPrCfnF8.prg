*==============================================================================
* InstantiateCheckPrCfnF8.prg - valida a Fase 8 de FormSigPrCfn (Calculo de Juros)
*
* Prova MEDINDO no VFP9 (nao por leitura de codigo) que a consolidacao da
* Fase 8 nao regrediu nada e que os quatro metodos novos estao em caminho VIVO:
*   1. o form ainda INSTANCIA;
*   2. BOParaForm carregou a tela a partir do BO (valores do Init legado);
*   3. HabilitarCampos(.F.) rodou no Init (llEnable = .f. do legado);
*   4. HabilitarCampos(.T.) roda por getValorBase.Valid;
*   5. FormParaBO continua alimentando o calculo (cadeia de eventos);
*   6. os quatro sao PROTECTED (chamada de FORA da classe tem de FALHAR) -
*      hooks de FormBase sao PROTECTED e subclasse nao alarga escopo;
*   7. LimparCampos zera BO + tela e re-trava os campos (hook FormBase.Novo);
*   8. BtnSairClick continua liberando o form.
*
* Cada passo eh GRAVADO EM DISCO na hora (LogPasso -> STRTOFILE ADDITIVE): se
* o processo travar, o log mostra exatamente onde parou.
*==============================================================================
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF

PUBLIC gb_4c_ModoTeste, gc_4c_ArquivoErroTeste, gc_4c_LogPassoF8
gb_4c_ModoTeste        = .T.
gc_4c_ArquivoErroTeste = "C:\4c\automation\vfp_error_prcfn_f8.txt"
gc_4c_LogPassoF8       = "C:\4c\automation\instantiate_prcfn_f8_result.txt"

IF FILE(gc_4c_ArquivoErroTeste)
    DELETE FILE (gc_4c_ArquivoErroTeste)
ENDIF
IF FILE(gc_4c_LogPassoF8)
    DELETE FILE (gc_4c_LogPassoF8)
ENDIF

LOCAL loc_oForm, loc_oErro
LogPasso("FASE8 CHECK FormSigPrCfn - inicio " + TTOC(DATETIME()))

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

    *-- 2. BOParaForm rodou no fim do InicializarForm: a tela tem de refletir
    *--    os parametros do Init (VB=1000, JMes=3, Dias=30) e o calculo.
    TRY
        LogPasso("2 BOParaForm carregou: VB=" + TRANSFORM(loc_oForm.txt_4c_ValorBase.Value) + ;
            " JMes=" + TRANSFORM(loc_oForm.txt_4c_JurosMes.Value) + ;
            " JDia=" + TRANSFORM(loc_oForm.txt_4c_JurosDia.Value) + ;
            " DtB=" + DTOC(loc_oForm.txt_4c_DataBase.Value) + ;
            " DtF=" + DTOC(loc_oForm.txt_4c_DataFinal.Value) + ;
            " Dias=" + TRANSFORM(loc_oForm.txt_4c_Dias.Value) + ;
            " OptCalc=" + TRANSFORM(loc_oForm.obj_4c_OptCalculo.Value) + ;
            " OptDias=" + TRANSFORM(loc_oForm.obj_4c_OptDias.Value) + ;
            " Juros=" + TRANSFORM(loc_oForm.txt_4c_ValorJuros.Value) + ;
            " Total=" + TRANSFORM(loc_oForm.txt_4c_ValorTotal.Value) + ;
            " Parc=" + TRANSFORM(loc_oForm.txt_4c_Valorpar.Value))
    CATCH TO loc_oErro
        LogPasso("2 FALHOU: " + loc_oErro.Message + " PROC=" + loc_oErro.Procedure)
    ENDTRY

    *-- 3. HabilitarCampos(.F.) do InicializarForm = "llEnable = .f." do Init
    *--    legado. Os SETE alvos do bloco legado tem de estar .F.; ValorBase,
    *--    optDias e os vencimentos NAO entram no bloco e seguem .T.
    TRY
        LogPasso("3 HabilitarCampos(.F.) no Init: JMes=" + TRANSFORM(loc_oForm.txt_4c_JurosMes.Enabled) + ;
            " JDia=" + TRANSFORM(loc_oForm.txt_4c_JurosDia.Enabled) + ;
            " DtB=" + TRANSFORM(loc_oForm.txt_4c_DataBase.Enabled) + ;
            " DtF=" + TRANSFORM(loc_oForm.txt_4c_DataFinal.Enabled) + ;
            " Dias=" + TRANSFORM(loc_oForm.txt_4c_Dias.Enabled) + ;
            " OptCalc1=" + TRANSFORM(loc_oForm.obj_4c_OptCalculo.Buttons(1).Enabled) + ;
            " OptCalc2=" + TRANSFORM(loc_oForm.obj_4c_OptCalculo.Buttons(2).Enabled) + ;
            " | fora do bloco: VB=" + TRANSFORM(loc_oForm.txt_4c_ValorBase.Enabled) + ;
            " OptDias1=" + TRANSFORM(loc_oForm.obj_4c_OptDias.Buttons(1).Enabled) + ;
            " Venc1=" + TRANSFORM(loc_oForm.txt_4c_Venc1.Enabled))
    CATCH TO loc_oErro
        LogPasso("3 FALHOU: " + loc_oErro.Message + " PROC=" + loc_oErro.Procedure)
    ENDTRY

    *-- 4/5. HabilitarCampos(.T.) + FormParaBO pela cadeia de eventos
    TRY
        loc_oForm.txt_4c_ValorBase.Value = 1000
        loc_oForm.TxtValorBaseKeyPress(13, 0)
        LogPasso("4 HabilitarCampos(.T.) por getValorBase.Valid: JMes=" + ;
            TRANSFORM(loc_oForm.txt_4c_JurosMes.Enabled) + ;
            " DtB=" + TRANSFORM(loc_oForm.txt_4c_DataBase.Enabled) + ;
            " Dias=" + TRANSFORM(loc_oForm.txt_4c_Dias.Enabled) + ;
            " OptCalc1=" + TRANSFORM(loc_oForm.obj_4c_OptCalculo.Buttons(1).Enabled))
    CATCH TO loc_oErro
        LogPasso("4 FALHOU: " + loc_oErro.Message + " PROC=" + loc_oErro.Procedure)
    ENDTRY

    TRY
        loc_oForm.txt_4c_DataBase.Value  = DATE() - 30
        loc_oForm.txt_4c_DataFinal.Value = DATE()
        loc_oForm.txt_4c_Dias.Value      = 30
        loc_oForm.txt_4c_JurosMes.Value  = 3
        loc_oForm.TxtJurosMesKeyPress(13, 0)
        LogPasso("5 FormParaBO alimentou o calculo: JDia=" + TRANSFORM(loc_oForm.txt_4c_JurosDia.Value) + ;
            " Juros=" + TRANSFORM(loc_oForm.txt_4c_ValorJuros.Value) + ;
            " Total=" + TRANSFORM(loc_oForm.txt_4c_ValorTotal.Value) + ;
            " [esperado simples: 1000*0.03*30/30=30, total 1030]")
    CATCH TO loc_oErro
        LogPasso("5 FALHOU: " + loc_oErro.Message + " PROC=" + loc_oErro.Procedure)
    ENDTRY

    TRY
        loc_oForm.txt_4c_Venc1.Value = DATE() + 30
        loc_oForm.TxtVenc1KeyPress(13, 0)
        loc_oForm.txt_4c_Venc2.Value = DATE() + 60
        loc_oForm.TxtVenc2KeyPress(13, 0)
        LogPasso("6 dois vencimentos: Dias=" + TRANSFORM(loc_oForm.txt_4c_Dias.Value) + ;
            " Juros=" + TRANSFORM(loc_oForm.txt_4c_ValorJuros.Value) + ;
            " Total=" + TRANSFORM(loc_oForm.txt_4c_ValorTotal.Value) + ;
            " Parc=" + TRANSFORM(loc_oForm.txt_4c_Valorpar.Value) + " [Parc = Total/2]")
    CATCH TO loc_oErro
        LogPasso("6 FALHOU: " + loc_oErro.Message + " PROC=" + loc_oErro.Procedure)
    ENDTRY

    *-- 7. Os quatro metodos sao PROTECTED: chamada de FORA tem de FALHAR.
    *--    PEMSTATUS(...,5) devolve .T. mesmo para PROTECTED (so verifica
    *--    existencia, nao escopo - CLAUDE.md #3), entao o teste de escopo eh
    *--    a CHAMADA, nao o PEMSTATUS.
    TRY
        loc_oForm.FormParaBO()
        LogPasso("7a FormParaBO: chamada externa PASSOU - NAO eh PROTECTED (ERRO)")
    CATCH TO loc_oErro
        LogPasso("7a FormParaBO PROTECTED OK (externa recusada): " + loc_oErro.Message)
    ENDTRY

    TRY
        loc_oForm.BOParaForm()
        LogPasso("7b BOParaForm: chamada externa PASSOU - NAO eh PROTECTED (ERRO)")
    CATCH TO loc_oErro
        LogPasso("7b BOParaForm PROTECTED OK (externa recusada): " + loc_oErro.Message)
    ENDTRY

    TRY
        loc_oForm.HabilitarCampos(.T.)
        LogPasso("7c HabilitarCampos: chamada externa PASSOU (ver nota - nao eh hook de FormBase)")
    CATCH TO loc_oErro
        LogPasso("7c HabilitarCampos PROTECTED OK (externa recusada): " + loc_oErro.Message)
    ENDTRY

    TRY
        loc_oForm.LimparCampos()
        LogPasso("7d LimparCampos: chamada externa PASSOU - NAO eh PROTECTED (ERRO)")
    CATCH TO loc_oErro
        LogPasso("7d LimparCampos PROTECTED OK (externa recusada): " + loc_oErro.Message)
    ENDTRY

    *-- 8. LimparCampos pelo caminho REAL: o hook que FormBase.Novo invoca.
    *--    Depois dele a tela tem de estar zerada E re-travada.
    TRY
        loc_oForm.Novo()
        LogPasso("8 pos FormBase.Novo -> LimparCampos: VB=" + TRANSFORM(loc_oForm.txt_4c_ValorBase.Value) + ;
            " JMes=" + TRANSFORM(loc_oForm.txt_4c_JurosMes.Value) + ;
            " JDia=" + TRANSFORM(loc_oForm.txt_4c_JurosDia.Value) + ;
            " Dias=" + TRANSFORM(loc_oForm.txt_4c_Dias.Value) + ;
            " DtB=[" + DTOC(loc_oForm.txt_4c_DataBase.Value) + "]" + ;
            " DtF=[" + DTOC(loc_oForm.txt_4c_DataFinal.Value) + "]" + ;
            " Juros=" + TRANSFORM(loc_oForm.txt_4c_ValorJuros.Value) + ;
            " Total=" + TRANSFORM(loc_oForm.txt_4c_ValorTotal.Value) + ;
            " Parc=" + TRANSFORM(loc_oForm.txt_4c_Valorpar.Value) + ;
            " Venc1=[" + DTOC(loc_oForm.txt_4c_Venc1.Value) + "]" + ;
            " Venc10=[" + DTOC(loc_oForm.txt_4c_Venc10.Value) + "]" + ;
            " OptCalc=" + TRANSFORM(loc_oForm.obj_4c_OptCalculo.Value) + ;
            " | retravou: JMesEna=" + TRANSFORM(loc_oForm.txt_4c_JurosMes.Enabled) + ;
            " DiasEna=" + TRANSFORM(loc_oForm.txt_4c_Dias.Enabled))
    CATCH TO loc_oErro
        LogPasso("8 FALHOU: " + loc_oErro.Message + ;
            " LN=" + TRANSFORM(loc_oErro.LineNo) + " PROC=" + loc_oErro.Procedure)
    ENDTRY

    *-- 9. depois de zerar, a tela volta a funcionar (nada ficou inconsistente)
    TRY
        loc_oForm.txt_4c_ValorBase.Value = 500
        loc_oForm.TxtValorBaseKeyPress(13, 0)
        loc_oForm.txt_4c_DataBase.Value  = DATE() - 60
        loc_oForm.txt_4c_DataFinal.Value = DATE()
        loc_oForm.txt_4c_Dias.Value      = 60
        loc_oForm.txt_4c_JurosMes.Value  = 2
        loc_oForm.TxtJurosMesKeyPress(13, 0)
        LogPasso("9 recalculo pos-limpeza: Juros=" + TRANSFORM(loc_oForm.txt_4c_ValorJuros.Value) + ;
            " Total=" + TRANSFORM(loc_oForm.txt_4c_ValorTotal.Value) + ;
            " [esperado simples: 500*0.02*60/30=20, total 520]")
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

IF FILE("C:\4c\automation\vfp_error_prcfn_f8.txt")
    LogPasso("DIALOGOS SUPRIMIDOS: " + FILETOSTR("C:\4c\automation\vfp_error_prcfn_f8.txt"))
ELSE
    LogPasso("DIALOGOS SUPRIMIDOS: nenhum")
ENDIF

LogPasso("FIM " + TTOC(DATETIME()))
QUIT

PROCEDURE LogPasso(par_cTexto)
    STRTOFILE(par_cTexto + CHR(13) + CHR(10), gc_4c_LogPassoF8, .T.)
ENDPROC

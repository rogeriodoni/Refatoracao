*==============================================================================
* VerifF8CfnLean.prg - verificacao INDEPENDENTE da Fase 8 de FormSigPrCfn.
*
* NAO chama config.prg de proposito: o ConfigurarAmbiente() carrega os VCX
* legado Fortyus + sigclcnx.PRG, e nesta maquina isso TRAVA (a rota para o
* SQL Server 192.168.200.10 nao existe, e o OCX legado abre modal de licenca).
* Esta calculadora nao consulta banco nenhum - as duas UNICAS globais que o
* form e o BO referenciam sao gnConnHandle e gc_4c_CaminhoIcones -, entao
* carregar so a cadeia de classes base basta e isola o que se quer medir.
*
* Os valores esperados foram calculados A MAO a partir do PROCEDURE calculos
* do dump legado (linhas 895-965), NAO lidos do codigo migrado:
*   Simples   : Juros = Round(Valor * (JurosMes/100) * (Dias/30), 2)
*   Loop venc : a 1a parcela ZERA o acumulador (If lnParc = 0 -> lnJuros = 0)
*               lnTotDia = dias do ULTIMO venc (a soma esta comentada no legado)
*   ValorPar  = Total / IIF(lnParc <> 0, lnParc, 1)
*==============================================================================
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF

PUBLIC gb_4c_ModoTeste, gc_4c_ArquivoErroTeste, gc_cLogLean
PUBLIC gnConnHandle, gc_4c_CaminhoIcones
gb_4c_ModoTeste        = .T.
gc_4c_ArquivoErroTeste = "C:\4c\automation\verif_lean_dialogos.txt"
gc_cLogLean            = "C:\4c\automation\verif_lean_result.txt"
gnConnHandle           = -1
gc_4c_CaminhoIcones    = "C:\4c\vbmp\"

IF FILE(gc_4c_ArquivoErroTeste)
    DELETE FILE (gc_4c_ArquivoErroTeste)
ENDIF
IF FILE(gc_cLogLean)
    DELETE FILE (gc_cLogLean)
ENDIF

LOCAL loc_oForm, loc_oErro, loc_dBase, loc_cEnab
LogLean("=== VERIF LEAN FASE 8 FormSigPrCfn === " + TTOC(DATETIME()))

*-- Cadeia minima de classes + utilitarios (sem VCX legado, sem SQL)
TRY
    SET PATH TO ("C:\4c\projeto\app\classes\,C:\4c\projeto\app\utils\,C:\4c\projeto\app\forms\operacionais\")
    SET PROCEDURE TO "C:\4c\projeto\app\utils\functions.prg"  ADDITIVE
    SET PROCEDURE TO "C:\4c\projeto\app\utils\messages.prg"   ADDITIVE
    SET PROCEDURE TO "C:\4c\projeto\app\classes\dataaccess.prg"   ADDITIVE
    SET PROCEDURE TO "C:\4c\projeto\app\classes\businessbase.prg" ADDITIVE
    SET PROCEDURE TO "C:\4c\projeto\app\classes\formbase.prg"     ADDITIVE
    SET PROCEDURE TO "C:\4c\projeto\app\classes\SigPrCfnBO.prg"   ADDITIVE
    SET PROCEDURE TO "C:\4c\projeto\app\forms\operacionais\FormSigPrCfn.prg" ADDITIVE
    LogLean("0 carga das classes: OK")
CATCH TO loc_oErro
    LogLean("0 carga FALHOU: " + loc_oErro.Message)
ENDTRY

*-- 1. Instancia com os parametros do Init legado (pVal,pTip,pJMe,pJDi,pDtB,pDtF)
loc_dBase = DATE() - 30
TRY
    loc_oForm = CREATEOBJECT("FormSigPrCfn", 1000, 1, 3, 0, loc_dBase, DATE())
    LogLean("1 INSTANCIA VARTYPE=" + VARTYPE(loc_oForm) + ;
        IIF(VARTYPE(loc_oForm) = "O", " W=" + TRANSFORM(loc_oForm.Width) + ;
        " H=" + TRANSFORM(loc_oForm.Height), ""))
CATCH TO loc_oErro
    LogLean("1 INSTANCIA FALHOU: " + loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
        " PROC=" + loc_oErro.Procedure)
ENDTRY

IF VARTYPE(loc_oForm) = "O"
    *-- 2. os SETE alvos do llEnable nascem .F. (Init legado, incondicional).
    *--    Le Buttons(N) por CAMINHO COMPLETO de proposito: se a licao do
    *--    Erro42 valesse aqui, esta linha estouraria "BUTTONS is not an object".
    TRY
        loc_cEnab = TRANSFORM(loc_oForm.obj_4c_OptCalculo.Buttons(1).Enabled) + ;
                    TRANSFORM(loc_oForm.obj_4c_OptCalculo.Buttons(2).Enabled) + ;
                    TRANSFORM(loc_oForm.txt_4c_JurosMes.Enabled) + ;
                    TRANSFORM(loc_oForm.txt_4c_JurosDia.Enabled) + ;
                    TRANSFORM(loc_oForm.txt_4c_DataBase.Enabled) + ;
                    TRANSFORM(loc_oForm.txt_4c_DataFinal.Enabled) + ;
                    TRANSFORM(loc_oForm.txt_4c_Dias.Enabled)
        LogLean("2 llEnable pos-Init (7 alvos, esperado 7x F): " + loc_cEnab)
        LogLean("2b fora do bloco (esperado T): ValorBase=" + ;
            TRANSFORM(loc_oForm.txt_4c_ValorBase.Enabled) + ;
            " optDiasB1=" + TRANSFORM(loc_oForm.obj_4c_OptDias.Buttons(1).Enabled) + ;
            " Venc1=" + TRANSFORM(loc_oForm.txt_4c_Venc1.Enabled))
        LogLean("2c BOParaForm carregou a tela: VB=" + TRANSFORM(loc_oForm.txt_4c_ValorBase.Value) + ;
            " JMes=" + TRANSFORM(loc_oForm.txt_4c_JurosMes.Value) + ;
            " Dias=" + TRANSFORM(loc_oForm.txt_4c_Dias.Value) + ;
            " Juros=" + TRANSFORM(loc_oForm.txt_4c_ValorJuros.Value) + ;
            " Total=" + TRANSFORM(loc_oForm.txt_4c_ValorTotal.Value))
    CATCH TO loc_oErro
        LogLean("2 FALHOU: " + loc_oErro.Message)
    ENDTRY

    *-- 3. cadeia VIVA: KeyPress(13) -> ValidarValorBase -> HabilitarCampos(.T.)
    *--    e FormParaBO -> BO.Calcular -> mostradores
    TRY
        loc_oForm.txt_4c_ValorBase.Value = 1000
        loc_oForm.txt_4c_JurosMes.Value  = 3
        loc_oForm.txt_4c_JurosDia.Value  = 0.1
        loc_oForm.txt_4c_DataBase.Value  = loc_dBase
        loc_oForm.txt_4c_DataFinal.Value = loc_dBase + 30
        loc_oForm.txt_4c_Dias.Value      = 30
        loc_oForm.TxtValorBaseKeyPress(13, 0)

        loc_cEnab = TRANSFORM(loc_oForm.obj_4c_OptCalculo.Buttons(1).Enabled) + ;
                    TRANSFORM(loc_oForm.obj_4c_OptCalculo.Buttons(2).Enabled) + ;
                    TRANSFORM(loc_oForm.txt_4c_JurosMes.Enabled) + ;
                    TRANSFORM(loc_oForm.txt_4c_JurosDia.Enabled) + ;
                    TRANSFORM(loc_oForm.txt_4c_DataBase.Enabled) + ;
                    TRANSFORM(loc_oForm.txt_4c_DataFinal.Enabled) + ;
                    TRANSFORM(loc_oForm.txt_4c_Dias.Enabled)
        LogLean("3 llEnable pos-Valid (esperado 7x T): " + loc_cEnab)
        LogLean("3b SEM venc: ESPERADO Juros=30 Total=1030 Parc=1030 Dias=30 / OBTIDO " + ;
            "Juros=" + TRANSFORM(loc_oForm.txt_4c_ValorJuros.Value) + ;
            " Total=" + TRANSFORM(loc_oForm.txt_4c_ValorTotal.Value) + ;
            " Parc="  + TRANSFORM(loc_oForm.txt_4c_Valorpar.Value) + ;
            " Dias="  + TRANSFORM(loc_oForm.txt_4c_Dias.Value))
    CATCH TO loc_oErro
        LogLean("3 FALHOU: " + loc_oErro.Message + " PROC=" + loc_oErro.Procedure)
    ENDTRY

    *-- 4. DOIS vencimentos: a 1a parcela ZERA o acumulador; Dias vira o do ULTIMO
    *--    Juros = 30 (venc1 a 30d) + 60 (venc2 a 60d) = 90 -> Total 1090, Parc 545, Dias 60
    TRY
        loc_oForm.txt_4c_Venc1.Value = loc_dBase + 30
        loc_oForm.txt_4c_Venc2.Value = loc_dBase + 60
        loc_oForm.TxtValorBaseKeyPress(13, 0)
        LogLean("4 COM 2 venc: ESPERADO Juros=90 Total=1090 Parc=545 Dias=60 / OBTIDO " + ;
            "Juros=" + TRANSFORM(loc_oForm.txt_4c_ValorJuros.Value) + ;
            " Total=" + TRANSFORM(loc_oForm.txt_4c_ValorTotal.Value) + ;
            " Parc="  + TRANSFORM(loc_oForm.txt_4c_Valorpar.Value) + ;
            " Dias="  + TRANSFORM(loc_oForm.txt_4c_Dias.Value))
    CATCH TO loc_oErro
        LogLean("4 FALHOU: " + loc_oErro.Message + " PROC=" + loc_oErro.Procedure)
    ENDTRY

    *-- 5. Juros COMPOSTO: Round(1000*(((1+0.1/100)^30)-1),2)
    *--    1.001^30 = 1.0304390875... -> 1000*0.0304390875 = 30,4390875 -> 30,44
    TRY
        loc_oForm.txt_4c_Venc1.Value = {}
        loc_oForm.txt_4c_Venc2.Value = {}
        loc_oForm.txt_4c_Dias.Value  = 30
        loc_oForm.obj_4c_OptCalculo.Value = 2
        loc_oForm.TxtValorBaseKeyPress(13, 0)
        LogLean("5 COMPOSTO sem venc: ESPERADO Juros=30,44 Total=1030,44 / OBTIDO " + ;
            "Juros=" + TRANSFORM(loc_oForm.txt_4c_ValorJuros.Value) + ;
            " Total=" + TRANSFORM(loc_oForm.txt_4c_ValorTotal.Value))
        loc_oForm.obj_4c_OptCalculo.Value = 1
    CATCH TO loc_oErro
        LogLean("5 FALHOU: " + loc_oErro.Message + " PROC=" + loc_oErro.Procedure)
    ENDTRY

    *-- 6. guarda do Valor Base negativo (getValorBase.Valid do legado): avisa e
    *--    ABORTA. Atencao ao que o legado faz de verdade - o "Return .f." vem
    *--    ANTES do bloco With, entao ele NAO desabilita nada: os campos ficam
    *--    como estavam. Como os passos 3-5 ja os habilitaram, o esperado aqui eh
    *--    .T. (nao .F.). O que se mede eh que o AVISO saiu e nada foi calculado.
    TRY
        loc_oForm.txt_4c_ValorBase.Value = -5
        loc_oForm.TxtValorBaseKeyPress(13, 0)
        LogLean("6 ValorBase negativo: JurosMes.Enabled=" + ;
            TRANSFORM(loc_oForm.txt_4c_JurosMes.Enabled) + ;
            " (esperado T - o legado retorna ANTES do With e nao mexe no Enabled)")
        loc_oForm.txt_4c_ValorBase.Value = 1000
        loc_oForm.TxtValorBaseKeyPress(13, 0)
    CATCH TO loc_oErro
        LogLean("6 FALHOU: " + loc_oErro.Message + " PROC=" + loc_oErro.Procedure)
    ENDTRY

    *-- 7. os quatro hooks sao PROTECTED (chamada de FORA tem de FALHAR)
    LogLean("7 escopo: FormParaBO=" + TestaProtegido(loc_oForm, "FormParaBO") + ;
        " BOParaForm=" + TestaProtegido(loc_oForm, "BOParaForm") + ;
        " HabilitarCampos=" + TestaProtegido(loc_oForm, "HabilitarCampos") + ;
        " LimparCampos=" + TestaProtegido(loc_oForm, "LimparCampos"))

    *-- 8. LimparCampos pelo hook PUBLIC de FormBase (Novo) - zera e re-trava
    TRY
        loc_oForm.Novo()
        loc_cEnab = TRANSFORM(loc_oForm.obj_4c_OptCalculo.Buttons(1).Enabled) + ;
                    TRANSFORM(loc_oForm.txt_4c_JurosMes.Enabled) + ;
                    TRANSFORM(loc_oForm.txt_4c_Dias.Enabled)
        LogLean("8 pos-Novo (LimparCampos): VB=" + TRANSFORM(loc_oForm.txt_4c_ValorBase.Value) + ;
            " JMes=" + TRANSFORM(loc_oForm.txt_4c_JurosMes.Value) + ;
            " Total=" + TRANSFORM(loc_oForm.txt_4c_ValorTotal.Value) + ;
            " Parc=" + TRANSFORM(loc_oForm.txt_4c_Valorpar.Value) + ;
            " Venc1=[" + TRANSFORM(loc_oForm.txt_4c_Venc1.Value) + "]" + ;
            " Venc10=[" + TRANSFORM(loc_oForm.txt_4c_Venc10.Value) + "]" + ;
            " OptCalc=" + TRANSFORM(loc_oForm.obj_4c_OptCalculo.Value) + ;
            " reTravado(3, esperado FFF)=" + loc_cEnab)
    CATCH TO loc_oErro
        LogLean("8 FALHOU: " + loc_oErro.Message + " PROC=" + loc_oErro.Procedure)
    ENDTRY

    *-- 9. recalculo APOS a limpeza (prova que a cadeia segue viva)
    *--    500 * 2% * 60/30 = 20 -> Total 520
    TRY
        loc_oForm.txt_4c_ValorBase.Value = 500
        loc_oForm.txt_4c_JurosMes.Value  = 2
        loc_oForm.txt_4c_JurosDia.Value  = 0.1
        loc_oForm.txt_4c_DataBase.Value  = loc_dBase
        loc_oForm.txt_4c_DataFinal.Value = loc_dBase + 60
        loc_oForm.txt_4c_Dias.Value      = 60
        loc_oForm.TxtValorBaseKeyPress(13, 0)
        LogLean("9 recalculo pos-limpeza: ESPERADO Juros=20 Total=520 / OBTIDO " + ;
            "Juros=" + TRANSFORM(loc_oForm.txt_4c_ValorJuros.Value) + ;
            " Total=" + TRANSFORM(loc_oForm.txt_4c_ValorTotal.Value))
    CATCH TO loc_oErro
        LogLean("9 FALHOU: " + loc_oErro.Message + " PROC=" + loc_oErro.Procedure)
    ENDTRY

    *-- 10. botao Sair do legado (Click = ThisForm.Release)
    TRY
        loc_oForm.BtnSairClick()
        LogLean("10 pos-BtnSairClick VARTYPE=" + VARTYPE(loc_oForm) + " [X = liberado]")
    CATCH TO loc_oErro
        LogLean("10 FALHOU: " + loc_oErro.Message)
    ENDTRY
ENDIF

IF FILE(gc_4c_ArquivoErroTeste)
    LogLean("DIALOGOS SUPRIMIDOS: " + FILETOSTR(gc_4c_ArquivoErroTeste))
ELSE
    LogLean("DIALOGOS SUPRIMIDOS: nenhum")
ENDIF
LogLean("=== FIM ===")
QUIT

PROCEDURE LogLean(par_cTexto)
    STRTOFILE(par_cTexto + CHR(13) + CHR(10), gc_cLogLean, .T.)
ENDPROC

FUNCTION TestaProtegido(par_oForm, par_cMetodo)
    LOCAL loc_cRes, loc_oE
    TRY
        DO CASE
            CASE par_cMetodo == "FormParaBO"
                par_oForm.FormParaBO()
            CASE par_cMetodo == "BOParaForm"
                par_oForm.BOParaForm()
            CASE par_cMetodo == "HabilitarCampos"
                par_oForm.HabilitarCampos(.T.)
            OTHERWISE
                par_oForm.LimparCampos()
        ENDCASE
        loc_cRes = "ACESSIVEL(!)"
    CATCH TO loc_oE
        loc_cRes = "protegido"
    ENDTRY
    RETURN loc_cRes
ENDFUNC

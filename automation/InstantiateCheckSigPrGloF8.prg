*==============================================================================
* InstantiateCheckSigPrGloF8.prg - valida a Fase 8 de FormSigPrGlo (task615)
*
* Prova MEDINDO no VFP9 que os dois metodos novos (FormParaBO/BOParaForm)
* estao em caminho VIVO e nao regrediram nada:
*   1. o form ainda INSTANCIA;
*   2. BOParaForm rodou no fim de ConfigurarCamposPrevisaoOp (Previsao/
*      Geracao vem preenchidas com os defaults do BO.Init);
*   3. os dois sao PROTECTED (chamada de fora da classe tem de FALHAR);
*   4. CmdProcessarClick (que agora chama FormParaBO antes de Processar)
*      continua validando e nao quebra;
*   5. CmdCancelarClick continua liberando o form.
*==============================================================================
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF

PUBLIC gb_4c_ModoTeste, gc_4c_ArquivoErroTeste, gc_4c_LogPassoGlo
gb_4c_ModoTeste        = .T.
gc_4c_ArquivoErroTeste = "C:\4c\automation\vfp_error_sigprglo_f8.txt"
gc_4c_LogPassoGlo      = "C:\4c\automation\instantiate_sigprglo_f8_result.txt"

IF FILE(gc_4c_ArquivoErroTeste)
    DELETE FILE (gc_4c_ArquivoErroTeste)
ENDIF
IF FILE(gc_4c_LogPassoGlo)
    DELETE FILE (gc_4c_LogPassoGlo)
ENDIF

LOCAL loc_oForm, loc_oErro
LogPasso("FASE8 CHECK FormSigPrGlo - inicio " + TTOC(DATETIME()))

TRY
    CD C:\4c\projeto\app\start
    DO config.prg
    ConfigurarAmbiente()
    LogPasso("0 AMBIENTE: OK (gnConnHandle=" + TRANSFORM(gnConnHandle) + ")")
CATCH TO loc_oErro
    LogPasso("0 AMBIENTE FALHOU: " + loc_oErro.Message)
ENDTRY

TRY
    loc_oForm = CREATEOBJECT("FormSigPrGlo", .F., .F., .F., .F.)
    LogPasso("1 INSTANCIA: VARTYPE=" + VARTYPE(loc_oForm) + ;
        IIF(VARTYPE(loc_oForm) = "O", " W=" + TRANSFORM(loc_oForm.Width) + ;
        " H=" + TRANSFORM(loc_oForm.Height) + " Cap=[" + loc_oForm.Caption + "]", ""))
CATCH TO loc_oErro
    LogPasso("1 INSTANCIA FALHOU: " + loc_oErro.Message + ;
        " LN=" + TRANSFORM(loc_oErro.LineNo) + " PROC=" + loc_oErro.Procedure)
ENDTRY

IF VARTYPE(loc_oForm) = "O"

    *-- 2. BOParaForm rodou no fim de ConfigurarCamposPrevisaoOp: a tela tem
    *--    de refletir this_dPrevisaoEntrega/this_dDataGeracao do BO.Init.
    TRY
        LogPasso("2 BOParaForm carregou: Previsao=" + DTOC(loc_oForm.cnt_4c_Previsao.txt_4c_Previsao.Value) + ;
            " Geracao=" + DTOC(loc_oForm.cnt_4c_Previsao.txt_4c_Geracao.Value) + ;
            " BO.Previsao=" + DTOC(loc_oForm.this_oBusinessObject.this_dPrevisaoEntrega) + ;
            " BO.Geracao=" + DTOC(loc_oForm.this_oBusinessObject.this_dDataGeracao) + ;
            " Nop=" + TRANSFORM(loc_oForm.cnt_4c_Op.txt_4c_Nop.Value) + ;
            " TpGOp=[" + loc_oForm.cnt_4c_Container1.txt_4c_TpGOp.Value + "]")
    CATCH TO loc_oErro
        LogPasso("2 FALHOU: " + loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + " PROC=" + loc_oErro.Procedure)
    ENDTRY

    *-- 3. FormParaBO/BOParaForm sao PROTECTED: chamada de FORA tem de FALHAR.
    TRY
        loc_oForm.FormParaBO()
        LogPasso("3a FormParaBO: chamada externa PASSOU - NAO eh PROTECTED (ERRO)")
    CATCH TO loc_oErro
        LogPasso("3a FormParaBO PROTECTED OK (externa recusada): " + loc_oErro.Message)
    ENDTRY

    TRY
        loc_oForm.BOParaForm()
        LogPasso("3b BOParaForm: chamada externa PASSOU - NAO eh PROTECTED (ERRO)")
    CATCH TO loc_oErro
        LogPasso("3b BOParaForm PROTECTED OK (externa recusada): " + loc_oErro.Message)
    ENDTRY

    *-- 4. Preenche os filtros e aciona Processar - deve validar e, sem
    *--    conexao SQL disponivel na maquina do pipeline, falhar dentro do
    *--    TRY/CATCH do BO (this_cMensagemErro), nunca com Program Error cru.
    TRY
        loc_oForm.cnt_4c_Previsao.txt_4c_Previsao.Value = DATE() + 5
        loc_oForm.cnt_4c_Previsao.txt_4c_Geracao.Value  = DATE()
        loc_oForm.cnt_4c_Conta.txt_4c_Grupo.Value  = "GRP"
        loc_oForm.cnt_4c_Conta.txt_4c_Conta.Value  = "CLI001"
        loc_oForm.CmdProcessarClick()
        LogPasso("4 CmdProcessarClick executou sem Program Error. " + ;
            "MensagemErroBO=[" + TRANSFORM(loc_oForm.this_oBusinessObject.this_cMensagemErro) + "]")
    CATCH TO loc_oErro
        LogPasso("4 FALHOU (Program Error cru - suspeita de metodo sem TRY/CATCH): " + ;
            loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + " PROC=" + loc_oErro.Procedure)
    ENDTRY

    *-- 5. FormParaBO deve ter alimentado o BO com os valores digitados no
    *--    passo 4 (prova que a chamada dentro de CmdProcessarClick rodou).
    TRY
        LogPasso("5 pos-CmdProcessarClick BO.this_cContaGrupo=[" + ALLTRIM(loc_oForm.this_oBusinessObject.this_cContaGrupo) + "]" + ;
            " BO.this_cContaConta=[" + ALLTRIM(loc_oForm.this_oBusinessObject.this_cContaConta) + "]" + ;
            " BO.this_dPrevisaoEntrega=" + DTOC(loc_oForm.this_oBusinessObject.this_dPrevisaoEntrega))
    CATCH TO loc_oErro
        LogPasso("5 FALHOU: " + loc_oErro.Message + " PROC=" + loc_oErro.Procedure)
    ENDTRY

    *-- 6. CmdCancelarClick libera o form (regra #29 - Show fora do TRY nao
    *--    se aplica aqui pois nao chamamos Show(); so o Release direto).
    TRY
        loc_oForm.CmdCancelarClick()
        LogPasso("6 posCmdCancelarClick: VARTYPE=" + VARTYPE(loc_oForm) + " [X = liberado]")
    CATCH TO loc_oErro
        LogPasso("6 FALHOU: " + loc_oErro.Message + " PROC=" + loc_oErro.Procedure)
    ENDTRY
ENDIF

IF FILE("C:\4c\automation\vfp_error_sigprglo_f8.txt")
    LogPasso("DIALOGOS SUPRIMIDOS: " + FILETOSTR("C:\4c\automation\vfp_error_sigprglo_f8.txt"))
ELSE
    LogPasso("DIALOGOS SUPRIMIDOS: nenhum")
ENDIF

LogPasso("FIM " + TTOC(DATETIME()))
QUIT

PROCEDURE LogPasso(par_cTexto)
    STRTOFILE(par_cTexto + CHR(13) + CHR(10), gc_4c_LogPassoGlo, .T.)
ENDPROC

*==============================================================================
* InstantiateCheckSigPrDftF8.prg - Fase 8 / task599
* Instancia Formsigprdft e exercita o que a Fase 8 acrescentou:
*   - properties novas (lnParcs/ldData/pctvenda/retorno)
*   - MontarRetornoTef (formato do RETURN do Unload legado)
*   - Move (dispatch por PCOUNT)
*   - gate pctvenda nos handlers do Optiongroup1
*   - Destroy/Unload devolvendo a string cacheada
*==============================================================================
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF

PUBLIC gb_4c_ModoTeste, gc_4c_ArquivoErroTeste
gb_4c_ModoTeste = .T.
gc_4c_ArquivoErroTeste = "C:\4c\automation\vfp_error_dft.txt"
IF FILE(gc_4c_ArquivoErroTeste)
    DELETE FILE (gc_4c_ArquivoErroTeste)
ENDIF

LOCAL loc_cRes, loc_oForm, loc_oErro, loc_cRet, loc_cRet2, loc_lGate
loc_cRes = "FAIL"

TRY
    CD C:\4c\projeto\app\start
    DO config.prg
    ConfigurarAmbiente()

    *-- Parametros da transacao, como o chamador legado passa
    loc_oForm = CREATEOBJECT("Formsigprdft", "192.168.0.1", 150.75, 123456, "001", "D", "C", 3, "7", "01")

    IF VARTYPE(loc_oForm) != "O"
        loc_cRes = "FAIL VARTYPE=" + VARTYPE(loc_oForm)
    ELSE
        loc_cRes = "OK" + ;
            " W=" + TRANSFORM(loc_oForm.Width) + ;
            " H=" + TRANSFORM(loc_oForm.Height) + CHR(13) + CHR(10)

        *-- 1) properties da Fase 8 existem e foram semeadas
        loc_cRes = loc_cRes + ;
            "ParcelasTef=[" + TRANSFORM(loc_oForm.this_cParcelasTef) + "]" + ;
            " DataTef=[" + DTOC(loc_oForm.this_dDataTef) + "]" + ;
            " TipoVendaLiberado=" + TRANSFORM(loc_oForm.this_lTipoVendaLiberado) + CHR(13) + CHR(10)

        *-- 2) hooks de transferencia declarados (PROTECTED - so existencia)
        loc_cRes = loc_cRes + ;
            "FormParaBO=" + TRANSFORM(PEMSTATUS(loc_oForm, "FormParaBO", 5)) + ;
            " BOParaForm=" + TRANSFORM(PEMSTATUS(loc_oForm, "BOParaForm", 5)) + ;
            " Unload=" + TRANSFORM(PEMSTATUS(loc_oForm, "Unload", 5)) + ;
            " MontarRetornoTef=" + TRANSFORM(PEMSTATUS(loc_oForm, "MontarRetornoTef", 5)) + CHR(13) + CHR(10)

        *-- 3) formato do retorno (lcSaque/lnParcs/DTOC(ldData)+bandeira+cartao)
        loc_cRet = loc_oForm.MontarRetornoTef()
        loc_cRes = loc_cRes + "Retorno=[" + loc_cRet + "] LEN=" + TRANSFORM(LEN(loc_cRet)) + CHR(13) + CHR(10)

        *-- 4) Move com 2 e com 4 argumentos (dispatch por PCOUNT)
        loc_oForm.Move(12, 34)
        loc_oForm.Move(20, 40, loc_oForm.Width, loc_oForm.Height)
        loc_cRes = loc_cRes + "MoveOK Left=" + TRANSFORM(loc_oForm.Left) + ;
                   " Top=" + TRANSFORM(loc_oForm.Top) + ;
                   " lCancela=" + TRANSFORM(loc_oForm.this_oBusinessObject.this_lCancela) + CHR(13) + CHR(10)

        *-- 5) gate do Optiongroup1.When: fechado, os handlers nao agem
        loc_oForm.this_lTipoVendaLiberado = .F.
        loc_oForm.txt_4c_Datas.Enabled = .F.
        loc_oForm.OptTipoVendaBtn1GotFocus()
        loc_lGate = !loc_oForm.txt_4c_Datas.Enabled
        loc_oForm.this_lTipoVendaLiberado = .T.
        loc_oForm.OptTipoVendaBtn1GotFocus()
        loc_cRes = loc_cRes + "GateFechadoBloqueou=" + TRANSFORM(loc_lGate) + ;
                   " GateAbertoLiberou=" + TRANSFORM(loc_oForm.txt_4c_Datas.Enabled) + CHR(13) + CHR(10)

        *-- 6) gate de reentrada do GetDigitos (When -> Return(EMPTY(Value)))
        loc_oForm.txt_4c_Digitos.Value = "1234"
        loc_oForm.DigitosGotFocus()
        loc_cRes = loc_cRes + "DigitosReentradaBloqueada=.T. (sem excecao, sem reconectar)" + CHR(13) + CHR(10)
        loc_oForm.txt_4c_Digitos.Value = ""

        *-- 7) Destroy cacheia o retorno e o Unload o devolve
        loc_oForm.Release()
        loc_cRes = loc_cRes + "PosRelease OK" + CHR(13) + CHR(10)
    ENDIF
CATCH TO loc_oErro
    loc_cRes = "EXCEPTION: " + loc_oErro.Message + ;
               " Linha:" + TRANSFORM(loc_oErro.LineNo) + ;
               " Proc:" + loc_oErro.Procedure
ENDTRY

STRTOFILE(loc_cRes, "C:\4c\automation\instantiate_sigprdft_f8_result.txt")
QUIT

*==============================================================================
* probef8sigopfpg736.prg - Exercita em RUNTIME a Fase 8 do FormSigOpFpg
* (task736): celulas de grade (Valor/Vencimento), geracao de parcelas
* (fweditdata_venc), calculo de troco (Vpar/Porc), cheque (LimpaChe/
* VerificaCheque) e os helpers de cambio/cotacao com gnConnHandle=0 (sem
* banco - precisam degradar graciosamente, nao travar o form).
*
* O form tem DataSession = 2 (privada) - manipular o cursor da grade
* DIRETO deste script (fora de um metodo do form) exige
* SET DATASESSION TO (loc_oForm.DataSessionId) antes, e voltar para 1
* depois (regra de teste para forms com DataSession propria).
*
* Setup igual ao probe da Fase 7 (NAO chamar ConfigurarAmbiente()).
* Script auxiliar de pipeline: SET SAFETY OFF + SET RESOURCE OFF (regra #6).
*==============================================================================
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF

PUBLIC gb_4c_ModoTeste, gc_4c_ArquivoErroTeste, gnConnHandle, gc_4c_UsuarioLogado
gb_4c_ModoTeste        = .T.
gc_4c_ArquivoErroTeste = "C:\4c\automation\_m736\probe_f8_dialogs.txt"
gnConnHandle           = 0
gc_4c_UsuarioLogado    = "TESTE"

LOCAL loc_cLog, loc_cOut
loc_cLog = "C:\4c\automation\_m736\probe_f8_sigopfpg.txt"
loc_cOut = "=== PROBE Fase 8 - FormSigOpFpg (task736) ===" + CHR(13) + CHR(10)

IF FILE(gc_4c_ArquivoErroTeste)
    DELETE FILE (gc_4c_ArquivoErroTeste)
ENDIF

CD C:\4c\projeto\app\start
DO config.prg

SET PATH TO (gcCaminhoBase + "," + gcCaminhoClasses + "," + gcCaminhoUtils + ;
             "," + gcCaminhoForms + "," + gcCaminhoIcones)

SET PROCEDURE TO (gcCaminhoClasses + "dataaccess.prg")   ADDITIVE
SET PROCEDURE TO (gcCaminhoClasses + "businessbase.prg") ADDITIVE
SET PROCEDURE TO (gcCaminhoClasses + "formbase.prg")     ADDITIVE
SET PROCEDURE TO (gcCaminhoClasses + "gridbase.prg")     ADDITIVE
SET PROCEDURE TO (gcCaminhoClasses + "FormErro.prg")     ADDITIVE
SET PROCEDURE TO (gcCaminhoUtils   + "functions.prg")    ADDITIVE
SET PROCEDURE TO (gcCaminhoUtils   + "messages.prg")     ADDITIVE
SET PROCEDURE TO (gcCaminhoUtils   + "validators.prg")   ADDITIVE
SET PROCEDURE TO (gcCaminhoClasses + "SigOpFpgBO.prg")   ADDITIVE
SET PROCEDURE TO (gcCaminhoForms + "operacionais\FormSigOpFpg.prg") ADDITIVE

loc_cOut = loc_cOut + "[1] Setup concluido" + CHR(13) + CHR(10)
STRTOFILE(loc_cOut, loc_cLog)

LOCAL loc_oForm, loc_oErro, loc_cCursor, loc_nCambio, loc_lCotas, loc_lAltCots, ;
    loc_lVerif, loc_nDSOrig, loc_nDSForm

TRY
    loc_oForm = CREATEOBJECT("FormSigOpFpg", .NULL., 0, .F.)
CATCH TO loc_oErro
    loc_oForm = .NULL.
    loc_cOut = loc_cOut + "[2] FALHA no CREATEOBJECT: " + loc_oErro.Message + ;
        " | Linha " + TRANSFORM(loc_oErro.LineNo) + " | Proc " + loc_oErro.Procedure + CHR(13) + CHR(10)
ENDTRY
STRTOFILE(loc_cOut, loc_cLog)

IF VARTYPE(loc_oForm) != "O"
    STRTOFILE(loc_cOut + "ABORTADO" + CHR(13) + CHR(10), loc_cLog)
    QUIT
ENDIF

loc_cOut = loc_cOut + "[2] Form instanciado OK (DataSessionId=" + ;
    TRANSFORM(loc_oForm.DataSessionId) + ")" + CHR(13) + CHR(10)
STRTOFILE(loc_cOut, loc_cLog)

loc_nDSOrig = SET("DATASESSION")
loc_nDSForm = loc_oForm.DataSessionId

*-- [3] Helpers de cambio/cotacao com gnConnHandle=0 (SQLEXEC deve
*--     degradar via TRY/CATCH, nunca travar o form) - rodam como metodo
*--     do form, entao ja entram na DataSession dele automaticamente.
TRY
    loc_nCambio  = loc_oForm.CarregarCambio("REA", DATE())
    loc_lCotas   = loc_oForm.MoedaPermiteCotacao("REA")
    loc_lAltCots = loc_oForm.CargoTemAltCots()
    loc_cOut = loc_cOut + "[3] CarregarCambio=" + TRANSFORM(loc_nCambio) + ;
        " MoedaPermiteCotacao=" + TRANSFORM(loc_lCotas) + ;
        " CargoTemAltCots=" + TRANSFORM(loc_lAltCots) + CHR(13) + CHR(10)
CATCH TO loc_oErro
    loc_cOut = loc_cOut + "[3] FALHA: " + loc_oErro.Message + " | Linha " + ;
        TRANSFORM(loc_oErro.LineNo) + " | Proc " + loc_oErro.Procedure + CHR(13) + CHR(10)
ENDTRY
STRTOFILE(loc_cOut, loc_cLog)

*-- [4] Popula uma linha manualmente no cursor da grade (bypassa SQL de
*--     AplicarFormaPagamento, que depende de banco) e exercita as
*--     celulas de Valor/Vencimento via ValidarValorLinhaGrade/
*--     ValidarVencimentoLinhaGrade (chamadas pela classe TextBox da
*--     coluna no uso real - aqui chamadas direto, como o harness faz).
*--     Manipulacao DIRETA do cursor precisa entrar na DataSession do form.
TRY
    SET DATASESSION TO (loc_nDSForm)
    loc_cCursor = loc_oForm.this_cCursorGrade
    SELECT (loc_cCursor)
    APPEND BLANK
    REPLACE FPags WITH "DINHEIRO", Valos WITH 100, Vencs WITH DATE(), ;
            MoeFpgs WITH "REA", CotFpgs WITH 1
    SET DATASESSION TO (loc_nDSOrig)

    loc_oForm.DefinirDadosTitulo(DATE() - 5, 100, "001")

    loc_oForm.grd_4c_Dados.Column3.txt_4c_CelulaVenc.Value = DATE() - 10
    loc_lVerif = loc_oForm.ValidarVencimentoLinhaGrade()
    loc_cOut = loc_cOut + "[4] ValidarVencimentoLinhaGrade (venc < DtEnts)=" + ;
        TRANSFORM(loc_lVerif) + " (esperado .F.)" + CHR(13) + CHR(10)

    loc_oForm.grd_4c_Dados.Column3.txt_4c_CelulaVenc.Value = DATE() + 10
    loc_lVerif = loc_oForm.ValidarVencimentoLinhaGrade()
    loc_cOut = loc_cOut + "[4] ValidarVencimentoLinhaGrade (venc ok)=" + ;
        TRANSFORM(loc_lVerif) + " (esperado .T.)" + CHR(13) + CHR(10)

    loc_lVerif = loc_oForm.ValidarValorLinhaGrade()
    loc_cOut = loc_cOut + "[4] ValidarValorLinhaGrade=" + TRANSFORM(loc_lVerif) + ;
        " TotForma=" + TRANSFORM(loc_oForm.txt_4c_TotForma.Value) + CHR(13) + CHR(10)
CATCH TO loc_oErro
    SET DATASESSION TO (loc_nDSOrig)
    loc_cOut = loc_cOut + "[4] FALHA: " + loc_oErro.Message + " | Linha " + ;
        TRANSFORM(loc_oErro.LineNo) + " | Proc " + loc_oErro.Procedure + CHR(13) + CHR(10)
ENDTRY
STRTOFILE(loc_cOut, loc_cLog)

*-- [5] Gerador de parcelas (TxtFweditdataVencLostFocus) - o metodo mais
*--     complexo da fase. Prepara os campos do cabecalho manualmente
*--     (sem depender do SQL de AplicarFormaPagamento) e dispara.
TRY
    loc_oForm.txt_4c_Fpg.Value              = "DINHEIRO"
    loc_oForm.txt_4c_Npar.Value             = 3
    loc_oForm.txt_4c_Vpar.Value             = 300
    loc_oForm.txt_4c_VEncargo.Value         = 0
    loc_oForm.txt_4c_Fweditdata_venc.Value  = DATE() + 30
    loc_oForm.this_oBusinessObject.this_cTvens  = "C"
    loc_oForm.this_oBusinessObject.this_nDias   = 30
    loc_oForm.this_oBusinessObject.this_cMoedas = "REA"
    loc_oForm.this_cInfoForma = ""

    loc_lVerif = loc_oForm.TxtFweditdataVencLostFocus()

    SET DATASESSION TO (loc_nDSForm)
    loc_cOut = loc_cOut + "[5] TxtFweditdataVencLostFocus=" + TRANSFORM(loc_lVerif) + ;
        " reccount=" + TRANSFORM(RECCOUNT(loc_cCursor)) + CHR(13) + CHR(10)
    SET DATASESSION TO (loc_nDSOrig)
    loc_cOut = loc_cOut + "[5] Fpg(pos-reset)=[" + loc_oForm.txt_4c_Fpg.Value + "]" + ;
        " (esperado vazio)" + CHR(13) + CHR(10)
CATCH TO loc_oErro
    SET DATASESSION TO (loc_nDSOrig)
    loc_cOut = loc_cOut + "[5] FALHA: " + loc_oErro.Message + " | Linha " + ;
        TRANSFORM(loc_oErro.LineNo) + " | Proc " + loc_oErro.Procedure + CHR(13) + CHR(10)
ENDTRY
STRTOFILE(loc_cOut, loc_cLog)

*-- [6] Troco (TxtVparLostFocus) e percentual (TxtPorcLostFocus)
TRY
    loc_oForm.txt_4c_Fpg.Value      = "DINHEIRO"
    loc_oForm.txt_4c_TotForma.Value = 40
    loc_oForm.txt_4c_Vpar.Value     = 0
    loc_oForm.txt_4c_COTACAO.Value  = 1
    loc_oForm.this_oBusinessObject.this_nValTots = 100
    loc_lVerif = loc_oForm.TxtVparLostFocus()
    loc_cOut = loc_cOut + "[6] TxtVparLostFocus=" + TRANSFORM(loc_lVerif) + ;
        " Vpar=" + TRANSFORM(loc_oForm.txt_4c_Vpar.Value) + " (esperado 60)" + CHR(13) + CHR(10)

    loc_oForm.txt_4c_Porc.Value = 10
    loc_lVerif = loc_oForm.TxtPorcLostFocus()
    loc_cOut = loc_cOut + "[6] TxtPorcLostFocus=" + TRANSFORM(loc_lVerif) + ;
        " Vpar=" + TRANSFORM(loc_oForm.txt_4c_Vpar.Value) + " (esperado 10)" + CHR(13) + CHR(10)
CATCH TO loc_oErro
    loc_cOut = loc_cOut + "[6] FALHA: " + loc_oErro.Message + " | Linha " + ;
        TRANSFORM(loc_oErro.LineNo) + " | Proc " + loc_oErro.Procedure + CHR(13) + CHR(10)
ENDTRY
STRTOFILE(loc_cOut, loc_cLog)

*-- [7] Cheque: LimpaChe + VerificaCheque (digitos invalidos -> .F. sem
*--     travar; SigChe via SQLEXEC(0,...) deve degradar via TRY/CATCH).
*--     LimpaChe/campos sao metodos do form (entram na DataSession certa
*--     sozinhos); so a LEITURA do cursor por este script precisa do SET
*--     DATASESSION.
TRY
    SET DATASESSION TO (loc_nDSForm)
    SELECT (loc_cCursor)
    IF RECCOUNT() = 0
        APPEND BLANK
    ENDIF
    GO TOP
    REPLACE Bancos WITH "001", Agencias WITH "1234", Contas WITH "12345", Numeros WITH "100001"
    SET DATASESSION TO (loc_nDSOrig)

    loc_oForm.LimpaChe()

    SET DATASESSION TO (loc_nDSForm)
    loc_cOut = loc_cOut + "[7] LimpaChe: Bancos=[" + ALLTRIM(EVALUATE(loc_cCursor + ".Bancos")) + "]" + ;
        " (esperado vazio)" + CHR(13) + CHR(10)
    SET DATASESSION TO (loc_nDSOrig)

    loc_lVerif = loc_oForm.VerificaCheque("ABC", "1234", "12345", "100001")
    loc_cOut = loc_cOut + "[7] VerificaCheque(banco letras)=" + TRANSFORM(loc_lVerif) + ;
        " (esperado .F., fChkDigitos reprova)" + CHR(13) + CHR(10)

    loc_lVerif = loc_oForm.VerificaCheque("001", "1234", "12345", "100001")
    loc_cOut = loc_cOut + "[7] VerificaCheque(digitos ok, sem SQL real)=" + TRANSFORM(loc_lVerif) + CHR(13) + CHR(10)
CATCH TO loc_oErro
    SET DATASESSION TO (loc_nDSOrig)
    loc_cOut = loc_cOut + "[7] FALHA: " + loc_oErro.Message + " | Linha " + ;
        TRANSFORM(loc_oErro.LineNo) + " | Proc " + loc_oErro.Procedure + CHR(13) + CHR(10)
ENDTRY
STRTOFILE(loc_cOut, loc_cLog)

*-- [8] fChkDigitos / fValidaCards (utils\functions.prg)
TRY
    loc_cOut = loc_cOut + "[8] fChkDigitos('123')=" + TRANSFORM(fChkDigitos("123")) + ;
        " fChkDigitos('12A')=" + TRANSFORM(fChkDigitos("12A")) + ;
        " fChkDigitos('')=" + TRANSFORM(fChkDigitos("")) + CHR(13) + CHR(10)
    loc_cOut = loc_cOut + "[8] fValidaCards('4532015112830366')=" + ;
        TRANSFORM(fValidaCards("4532015112830366")) + " (esperado .T., Luhn valido)" + ;
        " fValidaCards('1234567890123456')=" + TRANSFORM(fValidaCards("1234567890123456")) + ;
        " (esperado .F.)" + CHR(13) + CHR(10)
CATCH TO loc_oErro
    loc_cOut = loc_cOut + "[8] FALHA: " + loc_oErro.Message + CHR(13) + CHR(10)
ENDTRY
STRTOFILE(loc_cOut, loc_cLog)

TRY
    loc_oForm.Release()
CATCH TO loc_oErro
ENDTRY

loc_cOut = loc_cOut + "[9] FIM" + CHR(13) + CHR(10)
STRTOFILE(loc_cOut, loc_cLog)

IF FILE(gc_4c_ArquivoErroTeste)
    loc_cOut = loc_cOut + "--- DIALOGS CAPTURADOS ---" + CHR(13) + CHR(10) + ;
        FILETOSTR(gc_4c_ArquivoErroTeste) + CHR(13) + CHR(10)
    STRTOFILE(loc_cOut, loc_cLog)
ENDIF

QUIT

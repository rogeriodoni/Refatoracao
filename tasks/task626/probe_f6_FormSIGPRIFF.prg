*-- Probe FASE 6: prova que os BINDEVENT dos campos estao LIGADOS e que a
*-- captura da resposta reproduz o legado (Text1/Combo1.KeyPress com nKeyCode=13).
*-- Os eventos sao disparados pelo evento NATIVO do controle (oForm.ctrl.KeyPress)
*-- porque AEVENTS devolve 0 em form com DataSession proprio.
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
SET EXACT ON

PUBLIC gb_4c_ModoTeste, gb_4c_ValidandoUI, gnConnHandle
PUBLIC gc_4c_ArquivoErroTeste, gc_4c_CaminhoIcones, gc_4c_UsuarioLogado
gb_4c_ModoTeste        = .T.
gb_4c_ValidandoUI      = .T.
gnConnHandle           = -1
gc_4c_ArquivoErroTeste = "C:\4c\automation\_tmp\probe_f6_sigpriff_erro.txt"
gc_4c_CaminhoIcones    = "C:\4c\vbmp\"
gc_4c_UsuarioLogado    = "TESTE"

SET PATH TO ("C:\4c\projeto\app\utils,C:\4c\projeto\app\classes,C:\4c\projeto\app\forms\operacionais")

SET PROCEDURE TO ("C:\4c\projeto\app\utils\functions.prg")  ADDITIVE
SET PROCEDURE TO ("C:\4c\projeto\app\utils\messages.prg")   ADDITIVE
SET PROCEDURE TO ("C:\4c\projeto\app\utils\validators.prg") ADDITIVE
SET PROCEDURE TO ("C:\4c\projeto\app\classes\dataaccess.prg")   ADDITIVE
SET PROCEDURE TO ("C:\4c\projeto\app\classes\businessbase.prg") ADDITIVE
SET PROCEDURE TO ("C:\4c\projeto\app\classes\formbase.prg")     ADDITIVE
SET PROCEDURE TO ("C:\4c\projeto\app\classes\FormErro.prg")     ADDITIVE
SET PROCEDURE TO ("C:\4c\projeto\app\classes\SIGPRIFFBO.prg")   ADDITIVE
SET PROCEDURE TO ("C:\4c\projeto\app\forms\operacionais\FormSIGPRIFF.prg") ADDITIVE

LOCAL loc_cOut
loc_cOut = "PROBE FASE 6 FormSIGPRIFF - " + TTOC(DATETIME()) + CHR(13) + CHR(10) + ;
           REPLICATE("=", 72) + CHR(13) + CHR(10)

*-- (A) modo caractere: ENTER captura o .Value inteiro, tipo C
loc_cOut = loc_cOut + CasoTexto("A CARACTERE  ENTER(13)", "", "L", "Digite o CPF", 3, 11, "C", ;
                                "12345678901", 13)

*-- (B) modo caractere: tecla que NAO eh ENTER nao captura nada
loc_cOut = loc_cOut + CasoTexto("B CARACTERE  tecla 65", "", "L", "Digite o CPF", 3, 11, "C", ;
                                "12345678901", 65)

*-- (C) modo "D": captura preservando DATE (chamador faz DTOC)
loc_cOut = loc_cOut + CasoTexto("C MODO D     ENTER(13)", "", "L", "Data de Emissao", 0, 0, "D", ;
                                DATE(), 13)

*-- (D) modo "V": captura preservando NUMERIC (chamador faz TRANSFORM)
loc_cOut = loc_cOut + CasoTexto("D MODO V     ENTER(13)", "", "L", "Valor do Documento", 0, 0, "V", ;
                                1234.56, 13)

*-- (E) modo "M": ENTER captura SUBSTR(Value,1,1) = o CODIGO da opcao
loc_cOut = loc_cOut + CasoCombo("E MODO M     ENTER(13) opcao 2", "0:Sim;1:Nao;", "Confirma?", 2, 13)

*-- (F) modo "M": tecla que NAO eh ENTER nao captura nada
loc_cOut = loc_cOut + CasoCombo("F MODO M     tecla 65", "0:Sim;1:Nao;", "Confirma?", 2, 65)

*-- (G) modo "M": nada escolhido + ENTER = resposta vazia (cancelamento, igual ao legado)
loc_cOut = loc_cOut + CasoCombo("G MODO M     ENTER(13) sem escolha", "0:Sim;1:Nao;", "Confirma?", 0, 13)

STRTOFILE(loc_cOut, "C:\4c\automation\_tmp\probe_f6_sigpriff.txt")
QUIT

*------------------------------------------------------------------------------
PROCEDURE CasoTexto(par_cRotulo, par_cCab, par_cTipo, par_cTit, par_nMax, par_nMin, ;
        par_cDado, par_uDigitado, par_nKey)

    LOCAL loc_oF, loc_oE, loc_c, loc_uResp, loc_lValida
    loc_c = CHR(13) + CHR(10) + "[" + par_cRotulo + "]" + CHR(13) + CHR(10)

    TRY
        loc_oF = CREATEOBJECT("FormSIGPRIFF", par_cCab, par_cTipo, par_cTit, ;
                              par_nMax, par_nMin, par_cDado)

        IF VARTYPE(loc_oF) != "O"
            loc_c = loc_c + "  FALHOU: CREATEOBJECT devolveu VARTYPE=" + VARTYPE(loc_oF) + CHR(13) + CHR(10)
        ELSE
            loc_oF.txt_4c_Resposta.Value = par_uDigitado
            loc_lValida = loc_oF.ValidarRespostaDigitada(par_uDigitado)

            *-- Evento NATIVO do controle: se o BINDEVENT estiver ligado, o
            *-- handler do form roda e grava a resposta no BO.
            loc_oF.txt_4c_Resposta.KeyPress(par_nKey, 0)

            loc_uResp = loc_oF.this_oBusinessObject.ObterResposta()

            loc_c = loc_c + "  digitado=[" + TRANSFORM(par_uDigitado) + "] VARTYPE=[" + ;
                    VARTYPE(par_uDigitado) + "] ValidarRespostaDigitada=" + ;
                    TRANSFORM(loc_lValida) + CHR(13) + CHR(10) + ;
                    "  tecla=" + TRANSFORM(par_nKey) + ;
                    " -> Resposta=[" + TRANSFORM(loc_uResp) + "] VARTYPE=[" + ;
                    VARTYPE(loc_uResp) + "] EMPTY=" + TRANSFORM(EMPTY(loc_uResp)) + ;
                    CHR(13) + CHR(10)

            loc_oF = .NULL.
        ENDIF
    CATCH TO loc_oE
        loc_c = loc_c + "  EXCECAO: " + loc_oE.Message + ;
                " | Linha " + TRANSFORM(loc_oE.LineNo) + ;
                " | Proc " + loc_oE.Procedure + CHR(13) + CHR(10)
    ENDTRY

    RETURN loc_c
ENDPROC

*------------------------------------------------------------------------------
PROCEDURE CasoCombo(par_cRotulo, par_cCab, par_cTit, par_nIndice, par_nKey)
    LOCAL loc_oF, loc_oE, loc_c, loc_uResp
    loc_c = CHR(13) + CHR(10) + "[" + par_cRotulo + "]" + CHR(13) + CHR(10)

    TRY
        loc_oF = CREATEOBJECT("FormSIGPRIFF", par_cCab, "M", par_cTit, 0, 0, "")

        IF VARTYPE(loc_oF) != "O"
            loc_c = loc_c + "  FALHOU: CREATEOBJECT devolveu VARTYPE=" + VARTYPE(loc_oF) + CHR(13) + CHR(10)
        ELSE
            IF par_nIndice > 0
                loc_oF.cbo_4c_Opcoes.ListIndex = par_nIndice
            ENDIF

            loc_c = loc_c + "  ListCount=" + TRANSFORM(loc_oF.cbo_4c_Opcoes.ListCount) + ;
                    " ListIndex=" + TRANSFORM(loc_oF.cbo_4c_Opcoes.ListIndex) + ;
                    " .Value=[" + TRANSFORM(loc_oF.cbo_4c_Opcoes.Value) + "]" + CHR(13) + CHR(10)

            loc_oF.cbo_4c_Opcoes.KeyPress(par_nKey, 0)

            loc_uResp = loc_oF.this_oBusinessObject.ObterResposta()

            loc_c = loc_c + "  tecla=" + TRANSFORM(par_nKey) + ;
                    " -> Resposta=[" + TRANSFORM(loc_uResp) + "] VARTYPE=[" + ;
                    VARTYPE(loc_uResp) + "] LEN=" + TRANSFORM(LEN(TRANSFORM(loc_uResp))) + ;
                    " EMPTY=" + TRANSFORM(EMPTY(loc_uResp)) + CHR(13) + CHR(10)

            loc_oF = .NULL.
        ENDIF
    CATCH TO loc_oE
        loc_c = loc_c + "  EXCECAO: " + loc_oE.Message + ;
                " | Linha " + TRANSFORM(loc_oE.LineNo) + ;
                " | Proc " + loc_oE.Procedure + CHR(13) + CHR(10)
    ENDTRY

    RETURN loc_c
ENDPROC

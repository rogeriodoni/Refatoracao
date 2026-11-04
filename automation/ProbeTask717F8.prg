*-- ProbeTask717F8.prg - Fase 8 da task717: prova que os dois espelhos
*-- (BOParaForm e FormParaBO) estao no caminho VIVO do FormSigOpCts.
SET SAFETY OFF
SET RESOURCE OFF

LOCAL loc_cOut, loc_cLog, loc_cCR
loc_cOut = "C:\4c\automation\probe717f8.txt"
loc_cCR  = CHR(13) + CHR(10)
loc_cLog = ""

PUBLIC gb_4c_ModoTeste, gc_4c_ArquivoErroTeste, gb_4c_ValidandoUI, gnConnHandle
gb_4c_ModoTeste        = .T.
gc_4c_ArquivoErroTeste = "C:\4c\automation\probe717f8_dialogs.txt"
gb_4c_ValidandoUI      = .T.
gnConnHandle           = 0

DO ("C:\4c\projeto\app\start\config.prg")

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
SET PROCEDURE TO (gcCaminhoClasses + "SigOpCtsBO.prg")   ADDITIVE
SET PROCEDURE TO (gcCaminhoForms + "operacionais\FormSigOpCts.prg") ADDITIVE

loc_cLog = loc_cLog + "=== PROBE F8 - espelhos BOParaForm / FormParaBO ===" + loc_cCR

*-- Cursor do CHAMADOR, com a coluna Senhas (DataSession = 1: o dialogo o ve)
IF USED("crTesteSenha")
    USE IN crTesteSenha
ENDIF
CREATE CURSOR crTesteSenha (Senhas C(10))
APPEND BLANK
REPLACE Senhas WITH "SEGREDO"
GO TOP IN crTesteSenha

*----------------------------------------------------------------------
* C1 - modo CONSULTA: BOParaForm aplica a frase do ramo Else e NAO mexe
*      na altura (211 do SCX); PermitirSenhaNova tranca a nova senha.
*----------------------------------------------------------------------
LOCAL loc_oF1, loc_oE
loc_oF1 = .NULL.
TRY
    loc_oF1 = CREATEOBJECT("FormSigOpCts", "11101", .F., "crTesteSenha")
CATCH TO loc_oE
    loc_cLog = loc_cLog + "[C1] EXCECAO: " + loc_oE.Message + " LN=" + ;
        TRANSFORM(loc_oE.LineNo) + " PROC=" + loc_oE.Procedure + loc_cCR
ENDTRY

loc_cLog = loc_cLog + "[C1] VARTYPE             = " + VARTYPE(loc_oF1) + "   (esperado O)" + loc_cCR
IF VARTYPE(loc_oF1) = "O"
    loc_cLog = loc_cLog + "[C1] Height              = " + TRANSFORM(loc_oF1.Height) + "   (esperado 211)" + loc_cCR
    loc_cLog = loc_cLog + "[C1] this_lAltera        = " + TRANSFORM(loc_oF1.this_lAltera) + "   (esperado .F.)" + loc_cCR
    loc_cLog = loc_cLog + "[C1] BO.this_lAltera     = " + TRANSFORM(loc_oF1.this_oBusinessObject.this_lAltera) + loc_cCR
    loc_cLog = loc_cLog + "[C1] this_cTitulo        = [" + loc_oF1.this_cTitulo + "]" + loc_cCR
    loc_cLog = loc_cLog + "[C1] BO.this_cTitulo     = [" + loc_oF1.this_oBusinessObject.this_cTitulo + "]" + loc_cCR
    loc_cLog = loc_cLog + "[C1] Frase.Caption       = [" + STRTRAN(loc_oF1.lbl_4c_Frase.Caption, CHR(13), "<CR>") + "]" + loc_cCR
    loc_cLog = loc_cLog + "[C1] Frase ESPERADA      = [" + ;
        STRTRAN("A Conta 11101" + CHR(13) + " Possui Senha : ", CHR(13), "<CR>") + "]" + loc_cCR
    loc_cLog = loc_cLog + "[C1] Frase CONFERE       = " + ;
        TRANSFORM(loc_oF1.lbl_4c_Frase.Caption == ("A Conta 11101" + CHR(13) + " Possui Senha : ")) + loc_cCR
    loc_cLog = loc_cLog + "[C1] PermitirSenhaNova   = " + TRANSFORM(loc_oF1.PermitirSenhaNova()) + "   (esperado .F.)" + loc_cCR

    *-- FormParaBO no caminho vivo do senha.Valid: digita, dispara o Valid e
    *-- confere que o valor DIGITADO chegou a propriedade do BO.
    loc_oF1.txt_4c_Senha.Value = "ABC123"
    loc_cLog = loc_cLog + "[C1] BO.SenhaDigitada ANTES do Valid  = [" + ;
        loc_oF1.this_oBusinessObject.this_cSenhaDigitada + "]   (esperado vazio)" + loc_cCR
    TRY
        loc_oF1.ValidarSenhaAtual(loc_oF1.txt_4c_Senha)
    CATCH TO loc_oE
        loc_cLog = loc_cLog + "[C1] EXCECAO no Valid: " + loc_oE.Message + loc_cCR
    ENDTRY
    loc_cLog = loc_cLog + "[C1] BO.SenhaDigitada DEPOIS do Valid = [" + ;
        loc_oF1.this_oBusinessObject.this_cSenhaDigitada + "]   (esperado ABC123)" + loc_cCR
    loc_cLog = loc_cLog + "[C1] ObterResultado      = " + TRANSFORM(loc_oF1.ObterResultado()) + loc_cCR
    loc_oF1.Release()
ENDIF
loc_cLog = loc_cLog + loc_cCR

*----------------------------------------------------------------------
* C2 - modo ALTERAR: BOParaForm aplica a frase do ramo If E a altura 250;
*      PermitirSenhaNova libera a nova senha.
*----------------------------------------------------------------------
LOCAL loc_oF2
loc_oF2 = .NULL.
TRY
    loc_oF2 = CREATEOBJECT("FormSigOpCts", "11101", .T., "crTesteSenha")
CATCH TO loc_oE
    loc_cLog = loc_cLog + "[C2] EXCECAO: " + loc_oE.Message + " LN=" + ;
        TRANSFORM(loc_oE.LineNo) + " PROC=" + loc_oE.Procedure + loc_cCR
ENDTRY

loc_cLog = loc_cLog + "[C2] VARTYPE             = " + VARTYPE(loc_oF2) + "   (esperado O)" + loc_cCR
IF VARTYPE(loc_oF2) = "O"
    loc_cLog = loc_cLog + "[C2] Height              = " + TRANSFORM(loc_oF2.Height) + "   (esperado 250)" + loc_cCR
    loc_cLog = loc_cLog + "[C2] this_lAltera        = " + TRANSFORM(loc_oF2.this_lAltera) + "   (esperado .T.)" + loc_cCR
    loc_cLog = loc_cLog + "[C2] Frase.Caption       = [" + STRTRAN(loc_oF2.lbl_4c_Frase.Caption, CHR(13), "<CR>") + "]" + loc_cCR
    loc_cLog = loc_cLog + "[C2] Frase CONFERE       = " + ;
        TRANSFORM(loc_oF2.lbl_4c_Frase.Caption == ("Conta 11101" + CHR(13) + "Digite a Senha Atual : ")) + loc_cCR
    loc_cLog = loc_cLog + "[C2] PermitirSenhaNova   = " + TRANSFORM(loc_oF2.PermitirSenhaNova()) + "   (esperado .T.)" + loc_cCR

    *-- FormParaBO no caminho vivo do GetNova2.Valid, com o par DIVERGENTE.
    *-- Este eh o teste DISCRIMINANTE: se FormParaBO nao rodasse, o BO
    *-- compararia duas strings vazias (iguais) e tentaria GRAVAR; com ele, o
    *-- par chega divergente e a mensagem eh a do legado.
    loc_oF2.txt_4c_Nova1.Value = "AAA"
    loc_oF2.txt_4c_Nova2.Value = "BBB"
    loc_cLog = loc_cLog + "[C2] BO.Nova1/Nova2 ANTES  = [" + ;
        loc_oF2.this_oBusinessObject.this_cSenhaNova1 + "]/[" + ;
        loc_oF2.this_oBusinessObject.this_cSenhaNova2 + "]   (esperado vazio/vazio)" + loc_cCR
    TRY
        loc_oF2.ValidarSenhaNova(loc_oF2.txt_4c_Nova2)
    CATCH TO loc_oE
        loc_cLog = loc_cLog + "[C2] EXCECAO no Valid: " + loc_oE.Message + loc_cCR
    ENDTRY
    loc_cLog = loc_cLog + "[C2] BO.Nova1/Nova2 DEPOIS = [" + ;
        loc_oF2.this_oBusinessObject.this_cSenhaNova1 + "]/[" + ;
        loc_oF2.this_oBusinessObject.this_cSenhaNova2 + "]   (esperado AAA/BBB)" + loc_cCR
    loc_cLog = loc_cLog + "[C2] BO.MensagemErro      = [" + ;
        ALLTRIM(NVL(loc_oF2.this_oBusinessObject.this_cMensagemErro, "")) + "]" + loc_cCR
    loc_cLog = loc_cLog + "[C2] Senhas do cursor     = [" + ALLTRIM(crTesteSenha.Senhas) + ;
        "]   (esperado SEGREDO - par divergente NAO grava)" + loc_cCR
    loc_cLog = loc_cLog + "[C2] ObterResultado       = " + TRANSFORM(loc_oF2.ObterResultado()) + "   (esperado .F.)" + loc_cCR
    loc_oF2.Release()
ENDIF

loc_cLog = loc_cLog + loc_cCR + "=== FIM ===" + loc_cCR
STRTOFILE(loc_cLog, loc_cOut)
QUIT

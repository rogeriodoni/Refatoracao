*-- Probe FASE 8: prova o FLUXO DE SAIDA que a Fase 8 entregou -
*--   (1) form1.KeyPress ESC(27)  -> dialogo sai com this_uResposta VAZIO (cancelamento)
*--   (2) espelho this_uResposta no FORM (equivalente ao PUBLIC Resposta do legado)
*--       preenchido pelos dois handlers de captura, com o TIPO que o chamador espera
*--   (3) tecla que nao eh ESC/ENTER nao encerra nem responde nada
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
SET EXACT ON

PUBLIC gb_4c_ModoTeste, gb_4c_ValidandoUI, gnConnHandle
PUBLIC gc_4c_ArquivoErroTeste, gc_4c_CaminhoIcones, gc_4c_UsuarioLogado
gb_4c_ModoTeste        = .T.
gb_4c_ValidandoUI      = .T.
gnConnHandle           = -1
gc_4c_ArquivoErroTeste = "C:\4c\automation\_tmp\probe_f8_sigpriff_erro.txt"
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
loc_cOut = "PROBE FASE 8 FormSIGPRIFF - " + TTOC(DATETIME()) + CHR(13) + CHR(10) + ;
           REPLICATE("=", 72) + CHR(13) + CHR(10)

*-- (A) ESC no FORM: cancelamento. Resposta fica vazia nos DOIS lugares.
loc_cOut = loc_cOut + CasoEsc("A ESC(27) modo caractere", "", "L", "Digite o CPF", 3, 11, "C", "12345678901", 27)

*-- (B) tecla qualquer no FORM: nao encerra e nao responde
loc_cOut = loc_cOut + CasoEsc("B tecla 65 no FORM", "", "L", "Digite o CPF", 3, 11, "C", "12345678901", 65)

*-- (C) ESC no modo "M": idem, com o combo visivel
loc_cOut = loc_cOut + CasoEscCombo("C ESC(27) modo M", "0:Sim;1:Nao;", "Confirma?", 2, 27)

*-- (D..G) espelho this_uResposta do FORM apos ENTER, um por modo
loc_cOut = loc_cOut + CasoEspelho("D espelho CARACTERE", "", "L", "Digite o CPF",       3, 11, "C", "12345678901")
loc_cOut = loc_cOut + CasoEspelho("E espelho MODO D", "", "L", "Data de Emissao",       0,  0, "D", DATE())
loc_cOut = loc_cOut + CasoEspelho("F espelho MODO V", "", "L", "Valor do Documento",    0,  0, "V", 1234.56)
loc_cOut = loc_cOut + CasoEspelhoCombo("G espelho MODO M", "0:Sim;1:Nao;", "Confirma?", 2)

*-- (H) Release/Destroy explicito: prova que o DODEFAULT() do destrutor nao estoura
loc_cOut = loc_cOut + CasoDestroy("H Release/Destroy")

STRTOFILE(loc_cOut, "C:\4c\automation\_tmp\probe_f8_sigpriff.txt")
QUIT


FUNCTION NovoForm(par_cCab, par_cTipo, par_cTitulo, par_nMax, par_nMin, par_cDado)
    LOCAL loc_oF
    loc_oF = .NULL.
    TRY
        loc_oF = CREATEOBJECT("FormSIGPRIFF", par_cCab, par_cTipo, par_cTitulo, par_nMax, par_nMin, par_cDado)
    CATCH
        loc_oF = .NULL.
    ENDTRY
    RETURN loc_oF
ENDFUNC

FUNCTION Mostra(par_u)
    DO CASE
    CASE VARTYPE(par_u) = "D"
        RETURN DTOC(par_u)
    CASE VARTYPE(par_u) = "N"
        RETURN ALLTRIM(STR(par_u, 14, 2))
    CASE VARTYPE(par_u) = "C"
        RETURN par_u
    OTHERWISE
        RETURN TRANSFORM(par_u)
    ENDCASE
ENDFUNC

FUNCTION CasoEsc(par_cRot, par_cCab, par_cTipo, par_cTitulo, par_nMax, par_nMin, par_cDado, par_uDigitado, par_nTecla)
    LOCAL loc_oF, loc_c
    loc_oF = NovoForm(par_cCab, par_cTipo, par_cTitulo, par_nMax, par_nMin, par_cDado)
    IF VARTYPE(loc_oF) != "O"
        RETURN CHR(13) + CHR(10) + "[" + par_cRot + "] FALHOU AO INSTANCIAR" + CHR(13) + CHR(10)
    ENDIF
    loc_oF.txt_4c_Resposta.Value = par_uDigitado
    loc_oF.KeyPress(par_nTecla, 0)
    loc_c = CHR(13) + CHR(10) + "[" + par_cRot + "]" + CHR(13) + CHR(10) + ;
        "  tecla=" + ALLTRIM(STR(par_nTecla)) + ;
        " -> Form.this_uResposta=[" + Mostra(loc_oF.this_uResposta) + "]" + ;
        " VARTYPE=[" + VARTYPE(loc_oF.this_uResposta) + "]" + ;
        " EMPTY=" + IIF(EMPTY(loc_oF.this_uResposta), ".T.", ".F.") + ;
        " BO.this_uResposta=[" + Mostra(loc_oF.this_oBusinessObject.this_uResposta) + "]" + ;
        " Visible=" + IIF(loc_oF.Visible, ".T.", ".F.") + CHR(13) + CHR(10)
    loc_oF.Release()
    RETURN loc_c
ENDFUNC

FUNCTION CasoEscCombo(par_cRot, par_cCab, par_cTitulo, par_nIndice, par_nTecla)
    LOCAL loc_oF, loc_c
    loc_oF = NovoForm(par_cCab, "M", par_cTitulo, 0, 0, "")
    IF VARTYPE(loc_oF) != "O"
        RETURN CHR(13) + CHR(10) + "[" + par_cRot + "] FALHOU AO INSTANCIAR" + CHR(13) + CHR(10)
    ENDIF
    loc_oF.cbo_4c_Opcoes.ListIndex = par_nIndice
    loc_oF.KeyPress(par_nTecla, 0)
    loc_c = CHR(13) + CHR(10) + "[" + par_cRot + "]" + CHR(13) + CHR(10) + ;
        "  ListIndex=" + ALLTRIM(STR(loc_oF.cbo_4c_Opcoes.ListIndex)) + ;
        " .Value=[" + TRANSFORM(loc_oF.cbo_4c_Opcoes.Value) + "]" + ;
        " tecla=" + ALLTRIM(STR(par_nTecla)) + ;
        " -> Form.this_uResposta=[" + Mostra(loc_oF.this_uResposta) + "]" + ;
        " VARTYPE=[" + VARTYPE(loc_oF.this_uResposta) + "]" + ;
        " EMPTY=" + IIF(EMPTY(loc_oF.this_uResposta), ".T.", ".F.") + CHR(13) + CHR(10)
    loc_oF.Release()
    RETURN loc_c
ENDFUNC

FUNCTION CasoEspelho(par_cRot, par_cCab, par_cTipo, par_cTitulo, par_nMax, par_nMin, par_cDado, par_uDigitado)
    LOCAL loc_oF, loc_c
    loc_oF = NovoForm(par_cCab, par_cTipo, par_cTitulo, par_nMax, par_nMin, par_cDado)
    IF VARTYPE(loc_oF) != "O"
        RETURN CHR(13) + CHR(10) + "[" + par_cRot + "] FALHOU AO INSTANCIAR" + CHR(13) + CHR(10)
    ENDIF
    loc_oF.txt_4c_Resposta.Value = par_uDigitado
    loc_oF.txt_4c_Resposta.KeyPress(13, 0)
    loc_c = CHR(13) + CHR(10) + "[" + par_cRot + "]" + CHR(13) + CHR(10) + ;
        "  digitado=[" + Mostra(par_uDigitado) + "] VARTYPE=[" + VARTYPE(par_uDigitado) + "]" + ;
        " -> Form.this_uResposta=[" + Mostra(loc_oF.this_uResposta) + "]" + ;
        " VARTYPE=[" + VARTYPE(loc_oF.this_uResposta) + "]" + ;
        " BO=[" + Mostra(loc_oF.this_oBusinessObject.this_uResposta) + "]" + ;
        " iguais=" + IIF(Mostra(loc_oF.this_uResposta) == Mostra(loc_oF.this_oBusinessObject.this_uResposta), ".T.", ".F.") + ;
        " Visible=" + IIF(loc_oF.Visible, ".T.", ".F.") + CHR(13) + CHR(10)
    loc_oF.Release()
    RETURN loc_c
ENDFUNC

FUNCTION CasoEspelhoCombo(par_cRot, par_cCab, par_cTitulo, par_nIndice)
    LOCAL loc_oF, loc_c
    loc_oF = NovoForm(par_cCab, "M", par_cTitulo, 0, 0, "")
    IF VARTYPE(loc_oF) != "O"
        RETURN CHR(13) + CHR(10) + "[" + par_cRot + "] FALHOU AO INSTANCIAR" + CHR(13) + CHR(10)
    ENDIF
    loc_oF.cbo_4c_Opcoes.ListIndex = par_nIndice
    loc_oF.cbo_4c_Opcoes.KeyPress(13, 0)
    loc_c = CHR(13) + CHR(10) + "[" + par_cRot + "]" + CHR(13) + CHR(10) + ;
        "  ListIndex=" + ALLTRIM(STR(loc_oF.cbo_4c_Opcoes.ListIndex)) + ;
        " .Value=[" + TRANSFORM(loc_oF.cbo_4c_Opcoes.Value) + "]" + ;
        " -> Form.this_uResposta=[" + Mostra(loc_oF.this_uResposta) + "]" + ;
        " VARTYPE=[" + VARTYPE(loc_oF.this_uResposta) + "]" + ;
        " LEN=" + ALLTRIM(STR(LEN(loc_oF.this_uResposta))) + ;
        " BO=[" + Mostra(loc_oF.this_oBusinessObject.this_uResposta) + "]" + CHR(13) + CHR(10)
    loc_oF.Release()
    RETURN loc_c
ENDFUNC

FUNCTION CasoDestroy(par_cRot)
    LOCAL loc_oF, loc_c, loc_oErro
    loc_oF = NovoForm("", "L", "Digite o CPF", 3, 11, "C")
    IF VARTYPE(loc_oF) != "O"
        RETURN CHR(13) + CHR(10) + "[" + par_cRot + "] FALHOU AO INSTANCIAR" + CHR(13) + CHR(10)
    ENDIF
    loc_c = ""
    TRY
        loc_oF.Release()
        loc_c = "Release/Destroy OK (sem excecao)"
    CATCH TO loc_oErro
        loc_c = "ESTOUROU: " + loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo)
    ENDTRY
    RETURN CHR(13) + CHR(10) + "[" + par_cRot + "]" + CHR(13) + CHR(10) + "  " + loc_c + CHR(13) + CHR(10)
ENDFUNC

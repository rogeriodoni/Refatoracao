* ProbeF8TefEvaluate809.prg
* Mede DUAS coisas no VFP9 real, sem tocar no banco:
*   (1) se EVALUATE("THIS." + <nome> + ".Value") resolve DENTRO de um metodo
*       PROTECTED - eh o que LerCampoDaTela de Formsigoptef usa para alcancar
*       o TextBox por NOME (Controls(<nome>) seria o erro da regra #34);
*   (2) se PCOUNT() distingue argumento OMITIDO de argumento presente, que eh
*       o guard de AplicarCamposDigitados no sigoptefBO.
* A PROVA eh o arquivo de saida, nao o exit code.
SET SAFETY OFF
SET RESOURCE OFF

LOCAL loc_oTeste, loc_cRel

loc_cRel = ""

loc_oTeste = CREATEOBJECT("ProbeTefForm")

loc_cRel = loc_cRel + "EVAL_TXT_EXISTENTE = [" + loc_oTeste.Ler("txt_4c_Digitos") + "]" + CHR(13) + CHR(10)
loc_cRel = loc_cRel + "EVAL_TXT_AUSENTE   = [" + loc_oTeste.Ler("txt_4c_NaoExiste") + "]" + CHR(13) + CHR(10)
loc_cRel = loc_cRel + "EVAL_TXT_NUMERICO  = [" + TRANSFORM(loc_oTeste.Ler("txt_4c_Text1")) + "] VARTYPE=" + ;
           VARTYPE(loc_oTeste.Ler("txt_4c_Text1")) + CHR(13) + CHR(10)

*-- PCOUNT: 2 argumentos passados, 4 omitidos
loc_oTeste.oBO.AplicarCamposDigitados("123,45", "9876")
loc_cRel = loc_cRel + "PCOUNT2_VALOR      = [" + loc_oTeste.oBO.this_cValorPago + "]" + CHR(13) + CHR(10)
loc_cRel = loc_cRel + "PCOUNT2_DIGITOS    = [" + loc_oTeste.oBO.this_cDigitosCartao + "]" + CHR(13) + CHR(10)
loc_cRel = loc_cRel + "PCOUNT2_CARTAO     = [" + loc_oTeste.oBO.this_cNumeroCartao + "] (deve ficar VAZIO)" + CHR(13) + CHR(10)

*-- Numerico e NULL pelo mesmo caminho
loc_oTeste.oBO.AplicarCamposDigitados("", "", "", "", "", 12)
loc_cRel = loc_cRel + "NUM_QTDPARCELAS    = [" + loc_oTeste.oBO.this_cQtdParcelas + "] VARTYPE=" + ;
           VARTYPE(loc_oTeste.oBO.this_cQtdParcelas) + CHR(13) + CHR(10)
loc_oTeste.oBO.AplicarCamposDigitados(.NULL.)
loc_cRel = loc_cRel + "NULL_VALOR         = [" + loc_oTeste.oBO.this_cValorPago + "] VARTYPE=" + ;
           VARTYPE(loc_oTeste.oBO.this_cValorPago) + CHR(13) + CHR(10)

STRTOFILE(loc_cRel, "C:\4c\automation\_f8tef_probe.txt")

QUIT

*-- Replica a FORMA do codigo medido: Form com TextBox adicionado por
*-- AddObject e metodo PROTECTED que alcanca o membro por NOME via EVALUATE.
DEFINE CLASS ProbeTefForm AS Form
    oBO = .NULL.

    PROCEDURE Init()
        THIS.AddObject("txt_4c_Digitos", "TextBox")
        THIS.txt_4c_Digitos.Value = "  1234  "
        THIS.AddObject("txt_4c_Text1", "TextBox")
        THIS.txt_4c_Text1.Value = 7
        THIS.oBO = CREATEOBJECT("ProbeTefBO")
        RETURN .T.
    ENDPROC

    *-- PUBLIC so para o probe poder chamar; o corpo eh identico ao
    *-- PROTECTED FUNCTION LerCampoDaTela do form migrado.
    FUNCTION Ler(par_cControle)
        RETURN THIS.LerCampoDaTela(par_cControle)
    ENDFUNC

    PROTECTED FUNCTION LerCampoDaTela(par_cControle)
        IF VARTYPE(par_cControle) != "C" OR EMPTY(par_cControle)
            RETURN ""
        ENDIF

        IF !PEMSTATUS(THIS, par_cControle, 5)
            RETURN ""
        ENDIF

        IF EVALUATE("VARTYPE(THIS." + par_cControle + ")") != "O"
            RETURN ""
        ENDIF

        RETURN EVALUATE("THIS." + par_cControle + ".Value")
    ENDFUNC
ENDDEFINE

*-- Replica AplicarCamposDigitados/NormalizarTexto do sigoptefBO, sem herdar
*-- BusinessBase (que exigiria conexao).
DEFINE CLASS ProbeTefBO AS Custom
    this_cValorPago        = ""
    this_cDigitosCartao    = ""
    this_cRespParcelamento = ""
    this_cNumeroCartao     = ""
    this_cCodSeguranca     = ""
    this_cQtdParcelas      = ""

    PROCEDURE AplicarCamposDigitados(par_cValorPago, par_cDigitos, ;
            par_cRespParcelamento, par_cNumeroCartao, ;
            par_cCodSeguranca, par_cQtdParcelas)

        IF PCOUNT() >= 1
            THIS.this_cValorPago = THIS.NormalizarTexto(par_cValorPago)
        ENDIF
        IF PCOUNT() >= 2
            THIS.this_cDigitosCartao = THIS.NormalizarTexto(par_cDigitos)
        ENDIF
        IF PCOUNT() >= 3
            THIS.this_cRespParcelamento = THIS.NormalizarTexto(par_cRespParcelamento)
        ENDIF
        IF PCOUNT() >= 4
            THIS.this_cNumeroCartao = THIS.NormalizarTexto(par_cNumeroCartao)
        ENDIF
        IF PCOUNT() >= 5
            THIS.this_cCodSeguranca = THIS.NormalizarTexto(par_cCodSeguranca)
        ENDIF
        IF PCOUNT() >= 6
            THIS.this_cQtdParcelas = THIS.NormalizarTexto(par_cQtdParcelas)
        ENDIF

        RETURN .T.
    ENDPROC

    PROTECTED FUNCTION NormalizarTexto(par_uValor)
        LOCAL loc_cTexto

        IF ISNULL(par_uValor)
            RETURN ""
        ENDIF

        DO CASE
            CASE VARTYPE(par_uValor) = "C"
                loc_cTexto = ALLTRIM(par_uValor)
            CASE VARTYPE(par_uValor) = "N"
                loc_cTexto = ALLTRIM(TRANSFORM(par_uValor))
            CASE VARTYPE(par_uValor) = "L"
                loc_cTexto = IIF(par_uValor, "S", "N")
            OTHERWISE
                loc_cTexto = ""
        ENDCASE

        RETURN loc_cTexto
    ENDFUNC
ENDDEFINE

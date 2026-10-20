*==============================================================================
* ProbeSnd678F6.prg - Instancia FormSigPrSnd headless (Fase 6 / task678) e
* exercita a superficie acrescentada nesta fase: ConfigurarEventos (BINDEVENT),
* ObterQtdeSenhas, ValidarQtdeSenhas e TxtQtdsenLostFocus.
* NAO chama ConfigurarAmbiente() (nao retorna nesta maquina).
*==============================================================================
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF

PUBLIC gb_4c_ModoTeste, gb_4c_ValidandoUI, gc_4c_ArquivoErroTeste
gb_4c_ModoTeste        = .T.
gb_4c_ValidandoUI      = .T.
gc_4c_ArquivoErroTeste = "C:\4c\automation\vfp_error_snd678.txt"
IF FILE(gc_4c_ArquivoErroTeste)
    DELETE FILE (gc_4c_ArquivoErroTeste)
ENDIF

LOCAL loc_cOut, loc_oForm, loc_oErro, loc_nEv
loc_cOut = "C:\4c\automation\probe_snd678_result.txt"
STRTOFILE("INICIO", loc_cOut)

TRY
    CD C:\4c\projeto\app\start
    DO config.prg
    gb_4c_ModoTeste   = .T.
    gb_4c_ValidandoUI = .T.

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
    SET PROCEDURE TO (gcCaminhoClasses + "SigPrSndBO.prg")   ADDITIVE
    SET PROCEDURE TO (gcCaminhoForms + "operacionais\FormSigPrSnd.prg") ADDITIVE
    STRTOFILE(CHR(13)+CHR(10)+"deps OK", loc_cOut, 1)

    loc_oForm = CREATEOBJECT("FormSigPrSnd")
    STRTOFILE(CHR(13)+CHR(10)+"CREATEOBJECT=" + VARTYPE(loc_oForm), loc_cOut, 1)

    IF VARTYPE(loc_oForm) = "O"
        STRTOFILE(CHR(13)+CHR(10)+"Caption=[" + loc_oForm.Caption + "]" + ;
            "  BaseClass=[" + loc_oForm.BaseClass + "]", loc_cOut, 1)

        *-- 1) Metodos da fase existem e sao PUBLIC (PEMSTATUS attr 2 = Protected)
        STRTOFILE(CHR(13)+CHR(10)+"ConfigurarEventos   ex=" + TRANSFORM(PEMSTATUS(loc_oForm,"ConfigurarEventos",5)) + ;
            " prot=" + TRANSFORM(PEMSTATUS(loc_oForm,"ConfigurarEventos",2)), loc_cOut, 1)
        STRTOFILE(CHR(13)+CHR(10)+"TxtQtdsenLostFocus  ex=" + TRANSFORM(PEMSTATUS(loc_oForm,"TxtQtdsenLostFocus",5)) + ;
            " prot=" + TRANSFORM(PEMSTATUS(loc_oForm,"TxtQtdsenLostFocus",2)), loc_cOut, 1)
        STRTOFILE(CHR(13)+CHR(10)+"ObterQtdeSenhas     ex=" + TRANSFORM(PEMSTATUS(loc_oForm,"ObterQtdeSenhas",5)) + ;
            " prot=" + TRANSFORM(PEMSTATUS(loc_oForm,"ObterQtdeSenhas",2)), loc_cOut, 1)
        STRTOFILE(CHR(13)+CHR(10)+"ValidarQtdeSenhas   ex=" + TRANSFORM(PEMSTATUS(loc_oForm,"ValidarQtdeSenhas",5)) + ;
            " prot=" + TRANSFORM(PEMSTATUS(loc_oForm,"ValidarQtdeSenhas",2)), loc_cOut, 1)

        *-- 2) BINDEVENT efetivamente registrado no TextBox
        LOCAL ARRAY loc_aEv[1,5]
        loc_nEv = AEVENTS(loc_aEv, loc_oForm.txt_4c_Qtdsen)
        STRTOFILE(CHR(13)+CHR(10)+"AEVENTS no txt_4c_Qtdsen = " + TRANSFORM(loc_nEv), loc_cOut, 1)
        IF loc_nEv > 0
            STRTOFILE(CHR(13)+CHR(10)+"  evento=[" + TRANSFORM(loc_aEv[1,2]) + "] delegate=[" + ;
                TRANSFORM(loc_aEv[1,4]) + "]", loc_cOut, 1)
        ENDIF

        *-- 3) Campo zerado (default do legado) -> ValidarQtdeSenhas DEVE reprovar
        loc_oForm.txt_4c_Qtdsen.Value = 0
        STRTOFILE(CHR(13)+CHR(10)+"CASO1 Value=0  Obter=" + TRANSFORM(loc_oForm.ObterQtdeSenhas()) + ;
            " Validar=" + TRANSFORM(loc_oForm.ValidarQtdeSenhas()) + " (esperado .F.)", loc_cOut, 1)

        *-- 4) Campo preenchido -> aprova
        loc_oForm.txt_4c_Qtdsen.Value = 5
        STRTOFILE(CHR(13)+CHR(10)+"CASO2 Value=5  Obter=" + TRANSFORM(loc_oForm.ObterQtdeSenhas()) + ;
            " Validar=" + TRANSFORM(loc_oForm.ValidarQtdeSenhas()) + " (esperado .T.)", loc_cOut, 1)

        *-- 5) Valor CARACTERE (TextBox sem ControlSource) -> normaliza sem estourar
        loc_oForm.txt_4c_Qtdsen.Value = "12"
        STRTOFILE(CHR(13)+CHR(10)+"CASO3 Value='12' VARTYPE antes=" + VARTYPE(loc_oForm.txt_4c_Qtdsen.Value) + ;
            " Obter=" + TRANSFORM(loc_oForm.ObterQtdeSenhas()) + ;
            " Validar=" + TRANSFORM(loc_oForm.ValidarQtdeSenhas()), loc_cOut, 1)
        loc_oForm.TxtQtdsenLostFocus()
        STRTOFILE(CHR(13)+CHR(10)+"CASO3 pos-LostFocus VARTYPE=" + VARTYPE(loc_oForm.txt_4c_Qtdsen.Value) + ;
            " Value=" + TRANSFORM(loc_oForm.txt_4c_Qtdsen.Value) + " (esperado N / 12)", loc_cOut, 1)

        *-- 6) LostFocus NAO deve mexer em valor que ja esta numerico
        loc_oForm.txt_4c_Qtdsen.Value = 7
        loc_oForm.TxtQtdsenLostFocus()
        STRTOFILE(CHR(13)+CHR(10)+"CASO4 numerico intocado Value=" + ;
            TRANSFORM(loc_oForm.txt_4c_Qtdsen.Value) + " (esperado 7)", loc_cOut, 1)

        *-- 7) Grade continua nao-digitavel (equivalente ao When -> .F. do legado)
        STRTOFILE(CHR(13)+CHR(10)+"Grid Column1.ReadOnly=" + TRANSFORM(loc_oForm.grd_4c_Dados.Column1.ReadOnly) + ;
            " Text1.ReadOnly=" + TRANSFORM(loc_oForm.grd_4c_Dados.Column1.Text1.ReadOnly) + ;
            " Header=[" + loc_oForm.grd_4c_Dados.Column1.Header1.Caption + "]", loc_cOut, 1)

        loc_oForm.Release()
        STRTOFILE(CHR(13)+CHR(10)+"RESULTADO=OK", loc_cOut, 1)
    ELSE
        STRTOFILE(CHR(13)+CHR(10)+"RESULTADO=FALHA_CREATEOBJECT", loc_cOut, 1)
    ENDIF

CATCH TO loc_oErro
    STRTOFILE(CHR(13)+CHR(10)+"EXCECAO: " + loc_oErro.Message + ;
              " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
              " PROC=" + loc_oErro.Procedure, loc_cOut, 1)
ENDTRY

QUIT

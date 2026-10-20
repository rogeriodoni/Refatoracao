*==============================================================================
* ProbeArq642F6.prg - Instancia FormSigOpArq headless (Fase 6 / task642) e
* exercita ValidarArquivoDestino(), o metodo de validacao acrescentado nesta
* fase. NAO chama ConfigurarAmbiente() (nao retorna nesta maquina).
*==============================================================================
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF

PUBLIC gb_4c_ModoTeste, gb_4c_ValidandoUI, gc_4c_ArquivoErroTeste
gb_4c_ModoTeste        = .T.
gb_4c_ValidandoUI      = .T.
gc_4c_ArquivoErroTeste = "C:\4c\automation\vfp_error_arq642.txt"
IF FILE(gc_4c_ArquivoErroTeste)
    DELETE FILE (gc_4c_ArquivoErroTeste)
ENDIF

LOCAL loc_cOut, loc_oForm, loc_oErro, loc_lR1, loc_cM1, loc_lR2
loc_cOut = "C:\4c\automation\probe_arq642_result.txt"
STRTOFILE("INICIO", loc_cOut)

TRY
    CD C:\4c\projeto\app\start
    DO config.prg
    gb_4c_ModoTeste   = .T.
    gb_4c_ValidandoUI = .T.
    STRTOFILE(CHR(13)+CHR(10)+"config OK", loc_cOut, 1)

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
    SET PROCEDURE TO (gcCaminhoClasses + "SigOpArqBO.prg")   ADDITIVE
    SET PROCEDURE TO (gcCaminhoForms + "operacionais\FormSigOpArq.prg") ADDITIVE
    STRTOFILE(CHR(13)+CHR(10)+"deps OK", loc_cOut, 1)

    loc_oForm = CREATEOBJECT("FormSigOpArq")
    STRTOFILE(CHR(13)+CHR(10)+"CREATEOBJECT=" + VARTYPE(loc_oForm), loc_cOut, 1)

    IF VARTYPE(loc_oForm) = "O"
        STRTOFILE(CHR(13)+CHR(10)+"Caption=[" + loc_oForm.Caption + "]", loc_cOut, 1)
        STRTOFILE(CHR(13)+CHR(10)+"ValidarArquivoDestino existe=" + ;
                  TRANSFORM(PEMSTATUS(loc_oForm, "ValidarArquivoDestino", 5)) + ;
                  "  PROTECTED=" + TRANSFORM(PEMSTATUS(loc_oForm, "ValidarArquivoDestino", 2)), loc_cOut, 1)

        *-- Caso 1: destino VAZIO (usuario cancelou o PutFile)
        loc_lR1 = loc_oForm.ValidarArquivoDestino("")
        loc_cM1 = loc_oForm.this_cMensagemErro
        STRTOFILE(CHR(13)+CHR(10)+"CASO1 vazio -> ret=" + TRANSFORM(loc_lR1) + ;
                  " msg=[" + loc_cM1 + "]", loc_cOut, 1)

        *-- Caso 2: argumento de TIPO errado (nao-caractere)
        loc_lR2 = loc_oForm.ValidarArquivoDestino(0)
        STRTOFILE(CHR(13)+CHR(10)+"CASO2 numerico -> ret=" + TRANSFORM(loc_lR2) + ;
                  " msg=[" + loc_oForm.this_cMensagemErro + "]", loc_cOut, 1)

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

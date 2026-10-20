*==============================================================================
* ProbeProef661F6.prg - Instancia Formsigproef headless (Fase 6 / task661) e
* exercita os handlers acrescentados nesta fase: ValidarDataInicial,
* ValidarDataFinal e AtualizarPeriodoNoBO.
* NAO chama ConfigurarAmbiente() (nao retorna nesta maquina).
*==============================================================================
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF

PUBLIC gb_4c_ModoTeste, gb_4c_ValidandoUI, gc_4c_ArquivoErroTeste
gb_4c_ModoTeste        = .T.
gb_4c_ValidandoUI      = .T.
gc_4c_ArquivoErroTeste = "C:\4c\automation\vfp_error_proef661.txt"
IF FILE(gc_4c_ArquivoErroTeste)
    DELETE FILE (gc_4c_ArquivoErroTeste)
ENDIF

LOCAL loc_cOut, loc_oForm, loc_oErro, loc_oCnt
loc_cOut = "C:\4c\automation\probe_proef661_result.txt"
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
    SET PROCEDURE TO (gcCaminhoClasses + "sigproefBO.prg")   ADDITIVE
    SET PROCEDURE TO (gcCaminhoForms + "operacionais\Formsigproef.prg") ADDITIVE
    STRTOFILE(CHR(13)+CHR(10)+"deps OK", loc_cOut, 1)

    loc_oForm = CREATEOBJECT("Formsigproef")
    STRTOFILE(CHR(13)+CHR(10)+"CREATEOBJECT=" + VARTYPE(loc_oForm), loc_cOut, 1)

    IF VARTYPE(loc_oForm) = "O"
        STRTOFILE(CHR(13)+CHR(10)+"Caption=[" + loc_oForm.Caption + "]", loc_cOut, 1)

        *-- Os controles da Fase 6 existem?
        loc_oCnt = loc_oForm.cnt_4c_Transa.cnt_4c_Periodo
        STRTOFILE(CHR(13)+CHR(10)+"Separador=" + ;
                  TRANSFORM(PEMSTATUS(loc_oCnt, "lbl_4c_Separador", 5)) + ;
                  " cap=[" + loc_oCnt.lbl_4c_Separador.Caption + "]" + ;
                  " DataFinal=" + TRANSFORM(PEMSTATUS(loc_oCnt, "txt_4c_DataFinal", 5)), loc_cOut, 1)

        *-- Handlers PUBLIC (regra #3/#51: PROTECTED quebraria o BINDEVENT)
        STRTOFILE(CHR(13)+CHR(10)+"ValidarDataInicial prot=" + ;
                  TRANSFORM(PEMSTATUS(loc_oForm, "ValidarDataInicial", 2)) + ;
                  " ValidarDataFinal prot=" + ;
                  TRANSFORM(PEMSTATUS(loc_oForm, "ValidarDataFinal", 2)) + ;
                  " AtualizarPeriodoNoBO prot=" + ;
                  TRANSFORM(PEMSTATUS(loc_oForm, "AtualizarPeriodoNoBO", 2)), loc_cOut, 1)

        *-- Default do Init do legado: DATE() nos dois campos + no BO
        STRTOFILE(CHR(13)+CHR(10)+"Ini=[" + DTOC(loc_oCnt.txt_4c_DataInicial.Value) + ;
                  "] Fim=[" + DTOC(loc_oCnt.txt_4c_DataFinal.Value) + ;
                  "] BOini=[" + DTOC(loc_oForm.this_oBusinessObject.this_dDataInicial) + ;
                  "] BOfim=[" + DTOC(loc_oForm.this_oBusinessObject.this_dDataFinal) + "]", loc_cOut, 1)

        *-- CASO 1: final ANTERIOR a inicial -> o legado puxa a INICIAL
        loc_oCnt.txt_4c_DataInicial.Value = DATE()
        loc_oCnt.txt_4c_DataFinal.Value   = DATE() - 10
        loc_oForm.ValidarDataFinal()
        STRTOFILE(CHR(13)+CHR(10)+"CASO1 swap -> Ini=[" + DTOC(loc_oCnt.txt_4c_DataInicial.Value) + ;
                  "] Fim=[" + DTOC(loc_oCnt.txt_4c_DataFinal.Value) + ;
                  "] BOini=[" + DTOC(loc_oForm.this_oBusinessObject.this_dDataInicial) + "]", loc_cOut, 1)

        *-- CASO 2: intervalo valido -> nada muda, BO recebe os dois
        loc_oCnt.txt_4c_DataInicial.Value = DATE() - 5
        loc_oCnt.txt_4c_DataFinal.Value   = DATE()
        loc_oForm.ValidarDataFinal()
        STRTOFILE(CHR(13)+CHR(10)+"CASO2 ok -> Ini=[" + DTOC(loc_oCnt.txt_4c_DataInicial.Value) + ;
                  "] Fim=[" + DTOC(loc_oCnt.txt_4c_DataFinal.Value) + ;
                  "] BOini=[" + DTOC(loc_oForm.this_oBusinessObject.this_dDataInicial) + ;
                  "] BOfim=[" + DTOC(loc_oForm.this_oBusinessObject.this_dDataFinal) + "]", loc_cOut, 1)

        *-- CASO 3: ValidarDataInicial (no-op do legado) nao pode estourar
        loc_oForm.ValidarDataInicial()
        STRTOFILE(CHR(13)+CHR(10)+"CASO3 inicial -> Ini=[" + DTOC(loc_oCnt.txt_4c_DataInicial.Value) + ;
                  "] guarda=" + TRANSFORM(loc_oForm.this_lEmValidacao), loc_cOut, 1)

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

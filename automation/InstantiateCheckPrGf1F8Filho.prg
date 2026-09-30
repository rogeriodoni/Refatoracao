*==============================================================================
* InstantiateCheckPrGf1F8Filho.prg - prova o defeito central da Fase 8 com o
* FormSigPrGf2 REAL (nao com um par pai/filho de mentira).
*
* Mede lado a lado:
*   A) CREATEOBJECT("FormSigPrGf2", oPai) com o retorno DESCARTADO
*      (como estava antes da Fase 8) -> o filho morre na propria linha;
*   B) o mesmo CREATEOBJECT com a referencia guardada numa property
*      (como ficou) -> o filho sobrevive.
*
* Em script separado de proposito: FormSigPrGf2 usa OLEBoundControl para o
* grafico e, mesmo criando o OLE de forma lazy, um dialogo COM travaria o
* processo - assim os resultados da checagem principal (F8) ficam preservados.
*
* crRel1 eh montado a mao com a estrutura que SigPrGf1BO.Processar produz,
* porque nesta maquina nao ha conexao SQL no harness.
*==============================================================================
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF

PUBLIC gb_4c_ModoTeste, gc_4c_ArquivoErroTeste, gc_4c_LogFilho
gb_4c_ModoTeste        = .T.
gc_4c_ArquivoErroTeste = "C:\4c\automation\vfp_error_prgf1_f8_filho.txt"
gc_4c_LogFilho         = "C:\4c\automation\instantiate_prgf1_f8_filho_result.txt"

IF FILE(gc_4c_ArquivoErroTeste)
    DELETE FILE (gc_4c_ArquivoErroTeste)
ENDIF
IF FILE(gc_4c_LogFilho)
    DELETE FILE (gc_4c_LogFilho)
ENDIF

LOCAL loc_oPai, loc_oErro, loc_nAntes
LogF("FASE8 CHECK referencia do filho - inicio " + TTOC(DATETIME()))

TRY
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
    SET PROCEDURE TO (gcCaminhoClasses + "SigPrGf1BO.prg")   ADDITIVE
    SET PROCEDURE TO (gcCaminhoClasses + "SigPrGf2BO.prg")   ADDITIVE
    SET PROCEDURE TO (gcCaminhoForms + "operacionais\FormSigPrGf1.prg") ADDITIVE
    SET PROCEDURE TO (gcCaminhoForms + "operacionais\FormSigPrGf2.prg") ADDITIVE
    LogF("0 SETUP: OK")
CATCH TO loc_oErro
    LogF("0 SETUP FALHOU: " + loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo))
ENDTRY

TRY
    loc_oPai = CREATEOBJECT("FormSigPrGf1")
    LogF("1 pai instanciado: VARTYPE=" + VARTYPE(loc_oPai) + ;
        " DataSessionId=" + TRANSFORM(loc_oPai.DataSessionId))
CATCH TO loc_oErro
    LogF("1 pai FALHOU: " + loc_oErro.Message + " PROC=" + loc_oErro.Procedure)
ENDTRY

IF VARTYPE(loc_oPai) = "O"

    *-- crRel1 na datasession do PAI, com a estrutura que Processar() produz
    TRY
        SET DATASESSION TO loc_oPai.DataSessionId
        IF USED("crRel1")
            USE IN crRel1
        ENDIF
        CREATE CURSOR crRel1 (Cemps C(3), cAnomess C(6), csTraNomes C(9), ;
                              cTitulo1s C(100), ctitulo2s C(40), cEmpresas C(100), ;
                              nFalhas N(16,2), nPesoccbs N(16,2))
        INSERT INTO crRel1 VALUES ("001", "202609", "Set./2026", ;
            "Falha X Recuperacao por Mes da Empresa 001 - TESTE", " [De 01/09/2026 a 30/09/2026]", ;
            "001 - TESTE", 10.00, 4.00)
        INSERT INTO crRel1 VALUES ("001", "202608", "Ago./2026", ;
            "Falha X Recuperacao por Mes da Empresa 001 - TESTE", " [De 01/09/2026 a 30/09/2026]", ;
            "001 - TESTE", 7.00, 3.00)
        GO TOP IN crRel1
        LogF("2 crRel1 montado na sessao do pai: RECCOUNT=" + TRANSFORM(RECCOUNT("crRel1")))
    CATCH TO loc_oErro
        LogF("2 FALHOU: " + loc_oErro.Message + " PROC=" + loc_oErro.Procedure)
    ENDTRY

    *-- CASO A: retorno DESCARTADO (o defeito que a Fase 8 corrigiu)
    TRY
        loc_nAntes = _SCREEN.FormCount
        CREATEOBJECT("FormSigPrGf2", loc_oPai)
        LogF("3 CASO A (retorno descartado): FormCount antes=" + TRANSFORM(loc_nAntes) + ;
            " depois=" + TRANSFORM(_SCREEN.FormCount) + ;
            "  [igual = o filho morreu na propria linha]")
    CATCH TO loc_oErro
        LogF("3 CASO A estourou: " + loc_oErro.Message + " PROC=" + loc_oErro.Procedure)
    ENDTRY

    *-- CASO B: referencia guardada na property (como ficou na Fase 8)
    TRY
        loc_nAntes = _SCREEN.FormCount
        loc_oPai.this_oFormGrafico = CREATEOBJECT("FormSigPrGf2", loc_oPai)
        LogF("4 CASO B (guardada em property): FormCount antes=" + TRANSFORM(loc_nAntes) + ;
            " depois=" + TRANSFORM(_SCREEN.FormCount) + ;
            "  VARTYPE(prop)=" + VARTYPE(loc_oPai.this_oFormGrafico) + ;
            "  [+1 e VARTYPE=O = o filho sobreviveu]")
        IF VARTYPE(loc_oPai.this_oFormGrafico) = "O"
            LogF("4a filho: Visible=" + TRANSFORM(loc_oPai.this_oFormGrafico.Visible) + ;
                " Enabled=" + TRANSFORM(loc_oPai.this_oFormGrafico.Enabled) + ;
                " DataSessionId=" + TRANSFORM(loc_oPai.this_oFormGrafico.DataSessionId) + ;
                " [DataSessionId tem de ser igual a do pai: " + ;
                TRANSFORM(loc_oPai.DataSessionId) + "]")
        ENDIF
    CATCH TO loc_oErro
        LogF("4 CASO B estourou: " + loc_oErro.Message + " PROC=" + loc_oErro.Procedure)
    ENDTRY

    *-- O filho reabilita o pai no Destroy: simula o Sair do filho
    TRY
        loc_oPai.Enabled = .F.
        LogF("5 antes do Release do filho: pai.Enabled=" + TRANSFORM(loc_oPai.Enabled))
        IF VARTYPE(loc_oPai.this_oFormGrafico) = "O"
            loc_oPai.this_oFormGrafico.Release()
        ENDIF
        LogF("5a depois do Release do filho: pai.Enabled=" + TRANSFORM(loc_oPai.Enabled) + ;
            " [tem de voltar a .T. - quem reabilita eh o Destroy do filho]" + ;
            "  VARTYPE(prop)=" + VARTYPE(loc_oPai.this_oFormGrafico) + " [X = pendurada]")
    CATCH TO loc_oErro
        LogF("5 FALHOU: " + loc_oErro.Message + " PROC=" + loc_oErro.Procedure)
    ENDTRY

    *-- LiberarFormGrafico tem de aguentar a referencia pendurada
    TRY
        loc_oPai.LiberarFormGrafico()
        LogF("6 LiberarFormGrafico sobre referencia pendurada: OK, VARTYPE=" + ;
            VARTYPE(loc_oPai.this_oFormGrafico))
    CATCH TO loc_oErro
        LogF("6 FALHOU: " + loc_oErro.Message + " PROC=" + loc_oErro.Procedure)
    ENDTRY

    TRY
        loc_oPai.Release()
        LogF("7 Release do pai: VARTYPE=" + VARTYPE(loc_oPai))
    CATCH TO loc_oErro
        LogF("7 FALHOU: " + loc_oErro.Message + " PROC=" + loc_oErro.Procedure)
    ENDTRY
ENDIF

IF FILE(gc_4c_ArquivoErroTeste)
    LogF("DIALOGOS SUPRIMIDOS: " + FILETOSTR(gc_4c_ArquivoErroTeste))
ELSE
    LogF("DIALOGOS SUPRIMIDOS: nenhum")
ENDIF

LogF("FIM " + TTOC(DATETIME()))
QUIT

PROCEDURE LogF(par_cTexto)
    STRTOFILE(par_cTexto + CHR(13) + CHR(10), gc_4c_LogFilho, .T.)
ENDPROC

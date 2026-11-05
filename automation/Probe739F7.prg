*==============================================================================
* Probe739F7.prg - Probe da Fase 7 de FormSigOpGco (task739)
*
* Mede em VFP9 (nao le o codigo):
*   1) o form INSTANCIA com GerarGrafico rodando dentro do InicializarForm
*   2) escopo REAL dos metodos (PEMSTATUS ...,2 = Protected)
*   3) o modo Comparativo foi LIDO do form pai
*   4) o BO agregou: TotalMeses/TotalGrupos e a matriz TAB/CRLF
*   5) a matriz de percentuais foi preenchida e ObterPercentual a le
*   6) o cursor do campo General foi criado
*   7) o APPEND GENERAL falhando (MsGraph ausente nesta maquina) NAO deixa
*      this_lGraficoGerado = .T. nem registro VIVO no cursor
*   8) o painel Aguarde do pai foi apagado
*   9) ramo SEM pai e SEM cursores: a tela ainda ABRE
*==============================================================================
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
PUBLIC gb_4c_ModoTeste, gc_4c_ArquivoErroTeste, gnConnHandle, gc_4c_UsuarioLogado

#DEFINE OUT "C:\4c\automation\probe_739f7.txt"

LOCAL loc_oE, loc_oPai, loc_oForm, loc_oBO, loc_cTxt, loc_nViv
loc_cTxt = ""

STRTOFILE("=== PROBE Fase 7 - FormSigOpGco (task739) ===" + CHR(13) + CHR(10), OUT)

TRY
    CD C:\4c\projeto\app\start
    DO config.prg
    gb_4c_ModoTeste        = .T.
    gc_4c_ArquivoErroTeste = "C:\4c\automation\vfp_err_739f7.txt"
    gc_4c_UsuarioLogado    = "TESTE"
    SET PATH TO (gcCaminhoBase + "," + gcCaminhoClasses + "," + gcCaminhoUtils + "," + gcCaminhoForms + "," + gcCaminhoIcones)
    SET PROCEDURE TO (gcCaminhoClasses + "dataaccess.prg")        ADDITIVE
    SET PROCEDURE TO (gcCaminhoClasses + "businessbase.prg")      ADDITIVE
    SET PROCEDURE TO (gcCaminhoClasses + "formbase.prg")          ADDITIVE
    SET PROCEDURE TO (gcCaminhoClasses + "gridbase.prg")          ADDITIVE
    SET PROCEDURE TO (gcCaminhoClasses + "FormErro.prg")          ADDITIVE
    SET PROCEDURE TO (gcCaminhoUtils   + "functions.prg")         ADDITIVE
    SET PROCEDURE TO (gcCaminhoUtils   + "messages.prg")          ADDITIVE
    SET PROCEDURE TO (gcCaminhoUtils   + "validators.prg")        ADDITIVE
    SET PROCEDURE TO (gcCaminhoClasses + "FormBuscaAuxiliar.prg") ADDITIVE
    SET PROCEDURE TO (gcCaminhoClasses + "SigOpGcoBO.prg")        ADDITIVE
    SET PROCEDURE TO (gcCaminhoForms + "operacionais\FormSigOpGco.prg") ADDITIVE
    gnConnHandle = -1
    STRTOFILE("[SETUP] ambiente OK" + CHR(13) + CHR(10), OUT, 1)
CATCH TO loc_oE
    STRTOFILE("[SETUP] FALHOU: " + loc_oE.Message + CHR(13) + CHR(10), OUT, 1)
ENDTRY

TRY
    IF USED("crFinal")
        USE IN crFinal
    ENDIF
    CREATE CURSOR crFinal (Mes N(2,0), Ordem N(1,0), Ano N(4,0), ;
        Grupos C(20), Total N(14,2), npercs N(6,2))
    INSERT INTO crFinal VALUES (1, 1, 2025, "LOJA A", 1000.00, 10.00)
    INSERT INTO crFinal VALUES (2, 1, 2025, "LOJA A", 2000.00, 20.00)
    INSERT INTO crFinal VALUES (1, 2, 2026, "LOJA A", 1500.00, 50.00)
    INSERT INTO crFinal VALUES (2, 2, 2026, "LOJA A", 2400.00, 20.00)
    INDEX ON STR(Mes, 2)          TAG Grupom
    INDEX ON Grupos + STR(Ano, 4) TAG Imp
    SET ORDER TO TAG Grupom

    IF USED("Cabecalho")
        USE IN Cabecalho
    ENDIF
    CREATE CURSOR Cabecalho (pRelTitulo C(60), pPeriodo C(40))
    INSERT INTO Cabecalho VALUES ("Faturamento por Loja", "01/2025 a 02/2026")

    STRTOFILE("[CURSORES] crFinal=" + TRANSFORM(RECCOUNT("crFinal")) + ;
        "  Cabecalho=" + TRANSFORM(RECCOUNT("Cabecalho")) + CHR(13) + CHR(10), OUT, 1)
CATCH TO loc_oE
    STRTOFILE("[CURSORES] FALHOU: " + loc_oE.Message + CHR(13) + CHR(10), OUT, 1)
ENDTRY

TRY
    loc_oPai = CREATEOBJECT("Form")
    loc_oPai.AddObject("Comparativo", "CheckBox")
    loc_oPai.Comparativo.Value = 1
    loc_oPai.AddObject("Aguarde", "Container")
    loc_oPai.Aguarde.Visible = .T.
    STRTOFILE("[PAI] Comparativo.Value=" + TRANSFORM(loc_oPai.Comparativo.Value) + ;
        "  Aguarde.Visible=" + TRANSFORM(loc_oPai.Aguarde.Visible) + CHR(13) + CHR(10), OUT, 1)
CATCH TO loc_oE
    STRTOFILE("[PAI] FALHOU: " + loc_oE.Message + CHR(13) + CHR(10), OUT, 1)
ENDTRY

TRY
    loc_oForm = CREATEOBJECT("FormSigOpGco", loc_oPai, loc_oPai.DataSessionId)
    STRTOFILE("[1] CREATEOBJECT -> VARTYPE=" + VARTYPE(loc_oForm) + CHR(13) + CHR(10), OUT, 1)
CATCH TO loc_oE
    STRTOFILE("[1] FALHOU: " + loc_oE.Message + " LN=" + TRANSFORM(loc_oE.LineNo) + ;
        " PROC=" + loc_oE.Procedure + CHR(13) + CHR(10), OUT, 1)
ENDTRY

IF VARTYPE(loc_oForm) = "O"
    TRY
        loc_cTxt = "[2] escopo (prot=.T. significa PROTECTED):" + CHR(13) + CHR(10)
        loc_cTxt = loc_cTxt + "    GerarGrafico              ex=" + TRANSFORM(PEMSTATUS(loc_oForm, "GerarGrafico", 5)) + " prot=" + TRANSFORM(PEMSTATUS(loc_oForm, "GerarGrafico", 2)) + CHR(13) + CHR(10)
        loc_cTxt = loc_cTxt + "    MostrarGrafico            ex=" + TRANSFORM(PEMSTATUS(loc_oForm, "MostrarGrafico", 5)) + " prot=" + TRANSFORM(PEMSTATUS(loc_oForm, "MostrarGrafico", 2)) + CHR(13) + CHR(10)
        loc_cTxt = loc_cTxt + "    ObterComparativoDoPai     ex=" + TRANSFORM(PEMSTATUS(loc_oForm, "ObterComparativoDoPai", 5)) + " prot=" + TRANSFORM(PEMSTATUS(loc_oForm, "ObterComparativoDoPai", 2)) + CHR(13) + CHR(10)
        loc_cTxt = loc_cTxt + "    OcultarAguardeDoPai       ex=" + TRANSFORM(PEMSTATUS(loc_oForm, "OcultarAguardeDoPai", 5)) + " prot=" + TRANSFORM(PEMSTATUS(loc_oForm, "OcultarAguardeDoPai", 2)) + CHR(13) + CHR(10)
        loc_cTxt = loc_cTxt + "    AplicarFormatoGrafico     ex=" + TRANSFORM(PEMSTATUS(loc_oForm, "AplicarFormatoGrafico", 5)) + " prot=" + TRANSFORM(PEMSTATUS(loc_oForm, "AplicarFormatoGrafico", 2)) + CHR(13) + CHR(10)
        loc_cTxt = loc_cTxt + "    AplicarEixosColuna        ex=" + TRANSFORM(PEMSTATUS(loc_oForm, "AplicarEixosColuna", 5)) + " prot=" + TRANSFORM(PEMSTATUS(loc_oForm, "AplicarEixosColuna", 2)) + CHR(13) + CHR(10)
        loc_cTxt = loc_cTxt + "    AplicarRotulosPercentuais ex=" + TRANSFORM(PEMSTATUS(loc_oForm, "AplicarRotulosPercentuais", 5)) + " prot=" + TRANSFORM(PEMSTATUS(loc_oForm, "AplicarRotulosPercentuais", 2)) + CHR(13) + CHR(10)
        loc_cTxt = loc_cTxt + "    AplicarAreaPizza          ex=" + TRANSFORM(PEMSTATUS(loc_oForm, "AplicarAreaPizza", 5)) + " prot=" + TRANSFORM(PEMSTATUS(loc_oForm, "AplicarAreaPizza", 2)) + CHR(13) + CHR(10)
        loc_cTxt = loc_cTxt + "    AnexarGraficoAoCursor     ex=" + TRANSFORM(PEMSTATUS(loc_oForm, "AnexarGraficoAoCursor", 5)) + " prot=" + TRANSFORM(PEMSTATUS(loc_oForm, "AnexarGraficoAoCursor", 2)) + CHR(13) + CHR(10)
        STRTOFILE(loc_cTxt, OUT, 1)
    CATCH TO loc_oE
        STRTOFILE("[2] FALHOU: " + loc_oE.Message + CHR(13) + CHR(10), OUT, 1)
    ENDTRY

    loc_oBO = loc_oForm.this_oBusinessObject

    TRY
        loc_cTxt = "[3] BO.this_nComparativo = " + TRANSFORM(loc_oBO.this_nComparativo) + "  (esperado 1)" + CHR(13) + CHR(10)
        loc_cTxt = loc_cTxt + "[4] TotalMeses=" + TRANSFORM(loc_oBO.this_nTotalMeses) + ;
            "  TotalGrupos=" + TRANSFORM(loc_oBO.this_nTotalGrupos) + ;
            "  DadosValidos=" + TRANSFORM(loc_oBO.this_lDadosValidos) + ;
            "  LEN(Dados)=" + TRANSFORM(LEN(loc_oBO.this_cDadosGrafico)) + CHR(13) + CHR(10)
        loc_cTxt = loc_cTxt + "    SubTitulo1=[" + ALLTRIM(loc_oBO.this_cSubTitulo1) + "]" + ;
            "  SubTitulo2=[" + ALLTRIM(loc_oBO.this_cSubTitulo2) + "]" + CHR(13) + CHR(10)
        loc_cTxt = loc_cTxt + "    MATRIZ (TAB->| , CRLF->/):" + CHR(13) + CHR(10) + "    " + ;
            STRTRAN(STRTRAN(STRTRAN(loc_oBO.this_cDadosGrafico, CHR(9), "|"), CHR(13), "/"), CHR(10), "") + CHR(13) + CHR(10)
        STRTOFILE(loc_cTxt, OUT, 1)
    CATCH TO loc_oE
        STRTOFILE("[3/4] FALHOU: " + loc_oE.Message + CHR(13) + CHR(10), OUT, 1)
    ENDTRY

    TRY
        loc_cTxt = "[5] percentuais cursor=" + loc_oBO.this_cCursorPercentuais + ;
            "  usado=" + TRANSFORM(USED(loc_oBO.this_cCursorPercentuais)) + ;
            "  linhas=" + TRANSFORM(IIF(USED(loc_oBO.this_cCursorPercentuais), RECCOUNT(loc_oBO.this_cCursorPercentuais), -1)) + CHR(13) + CHR(10)
        loc_cTxt = loc_cTxt + "    ObterPercentual (1,1)=" + TRANSFORM(loc_oBO.ObterPercentual(1, 1)) + ;
            "  (1,2)=" + TRANSFORM(loc_oBO.ObterPercentual(1, 2)) + ;
            "  (2,1)=" + TRANSFORM(loc_oBO.ObterPercentual(2, 1)) + ;
            "  (2,2)=" + TRANSFORM(loc_oBO.ObterPercentual(2, 2)) + ;
            "  (9,9)=" + TRANSFORM(loc_oBO.ObterPercentual(9, 9)) + CHR(13) + CHR(10)
        loc_cTxt = loc_cTxt + "    ObterPercentual prot=" + TRANSFORM(PEMSTATUS(loc_oBO, "ObterPercentual", 2)) + CHR(13) + CHR(10)
        STRTOFILE(loc_cTxt, OUT, 1)
    CATCH TO loc_oE
        STRTOFILE("[5] FALHOU: " + loc_oE.Message + CHR(13) + CHR(10), OUT, 1)
    ENDTRY

    TRY
        loc_nViv = -1
        IF USED(loc_oBO.this_cCursorGrafico)
            SELECT (loc_oBO.this_cCursorGrafico)
            COUNT TO loc_nViv FOR !DELETED()
        ENDIF
        loc_cTxt = "[6] cursor grafico=" + loc_oBO.this_cCursorGrafico + ;
            "  usado=" + TRANSFORM(USED(loc_oBO.this_cCursorGrafico)) + ;
            "  RECCOUNT=" + TRANSFORM(IIF(USED(loc_oBO.this_cCursorGrafico), RECCOUNT(loc_oBO.this_cCursorGrafico), -1)) + ;
            "  VIVOS=" + TRANSFORM(loc_nViv) + CHR(13) + CHR(10)
        loc_cTxt = loc_cTxt + "[7] this_lGraficoGerado=" + TRANSFORM(loc_oBO.this_lGraficoGerado) + ;
            "  this_lGraficoPronto=" + TRANSFORM(loc_oForm.this_lGraficoPronto) + CHR(13) + CHR(10)
        loc_cTxt = loc_cTxt + "    FalhaGrafico=[" + ALLTRIM(loc_oForm.this_cFalhaGrafico) + "]" + CHR(13) + CHR(10)
        loc_cTxt = loc_cTxt + "    OLE.ControlSource=[" + loc_oForm.obj_4c_OleGrafico.ControlSource + "]" + CHR(13) + CHR(10)
        loc_cTxt = loc_cTxt + "    LockScreen=" + TRANSFORM(loc_oForm.LockScreen) + "  (tem de ser .F.)" + CHR(13) + CHR(10)
        STRTOFILE(loc_cTxt, OUT, 1)
    CATCH TO loc_oE
        STRTOFILE("[6/7] FALHOU: " + loc_oE.Message + CHR(13) + CHR(10), OUT, 1)
    ENDTRY

    TRY
        STRTOFILE("[8] Pai.Aguarde.Visible=" + TRANSFORM(loc_oPai.Aguarde.Visible) + ;
            "  (tem de ser .F.)" + CHR(13) + CHR(10), OUT, 1)
    CATCH TO loc_oE
        STRTOFILE("[8] FALHOU: " + loc_oE.Message + CHR(13) + CHR(10), OUT, 1)
    ENDTRY

    TRY
        loc_oForm.Release()
    CATCH TO loc_oE
        STRTOFILE("[REL] " + loc_oE.Message + CHR(13) + CHR(10), OUT, 1)
    ENDTRY
    loc_oForm = .NULL.
ENDIF

TRY
    IF USED("crFinal")
        USE IN crFinal
    ENDIF
    IF USED("Cabecalho")
        USE IN Cabecalho
    ENDIF
    loc_oForm = CREATEOBJECT("FormSigOpGco")
    STRTOFILE("[9] sem pai/sem cursores -> VARTYPE=" + VARTYPE(loc_oForm) + ;
        IIF(VARTYPE(loc_oForm) = "O", ;
            "  Comparativo=" + TRANSFORM(loc_oForm.this_oBusinessObject.this_nComparativo) + ;
            "  GraficoPronto=" + TRANSFORM(loc_oForm.this_lGraficoPronto) + ;
            "  LockScreen=" + TRANSFORM(loc_oForm.LockScreen), "") + CHR(13) + CHR(10), OUT, 1)
    IF VARTYPE(loc_oForm) = "O"
        loc_oForm.Release()
    ENDIF
CATCH TO loc_oE
    STRTOFILE("[9] FALHOU: " + loc_oE.Message + " LN=" + TRANSFORM(loc_oE.LineNo) + ;
        " PROC=" + loc_oE.Procedure + CHR(13) + CHR(10), OUT, 1)
ENDTRY

STRTOFILE("=== FIM ===" + CHR(13) + CHR(10), OUT, 1)
QUIT

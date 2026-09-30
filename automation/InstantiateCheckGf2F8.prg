*==============================================================================
* InstantiateCheckGf2F8.prg - valida a Fase 7/8 de FormSigPrGf2
*
* Prova MEDINDO no VFP9 (nao por leitura de codigo):
*   1. o form ainda instancia sozinho (sem pai, sem crRel1) sem estourar -
*      ExecutarCargaInicial/PopularComboChaves/MGeraGrafico tem de no-opar
*      em silencio quando o cursor de origem nao existe;
*   2. os 2 botoes do CommandGroup (Grafico/Encerrar) estao BINDEVENT'ados;
*   3. o fluxo REAL fim-a-fim: abre o pai (FormSigPrGf1, ja completo),
*      popula crRel1 na sessao PRIVADA dele, abre o filho com
*      CREATEOBJECT("FormSigPrGf2", <pai>) - o MESMO contrato do
*      BtnProcessarClick do pai - e mede se o combo foi populado, o
*      grafico foi desenhado (cursor_4c_OleGrafico1 com 1 linha, gGrafico1s
*      preenchido) e BtnEncerrarClick reabilita o pai.
*
* NAO chama ConfigurarAmbiente() (pendura nesta maquina). Cada passo eh
* gravado em disco na hora: se travar, o log mostra onde parou.
*==============================================================================
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF

PUBLIC gb_4c_ModoTeste, gb_4c_ValidandoUI, gc_4c_ArquivoErroTeste, gc_4c_LogPassoGf2F8
gb_4c_ModoTeste        = .T.
gb_4c_ValidandoUI      = .T.
gc_4c_ArquivoErroTeste = "C:\4c\automation\vfp_error_gf2_f8.txt"
gc_4c_LogPassoGf2F8    = "C:\4c\automation\instantiate_gf2_f8_result.txt"

IF FILE(gc_4c_ArquivoErroTeste)
    DELETE FILE (gc_4c_ArquivoErroTeste)
ENDIF
IF FILE(gc_4c_LogPassoGf2F8)
    DELETE FILE (gc_4c_LogPassoGf2F8)
ENDIF

LOCAL loc_oErro, loc_oForm, loc_oPai, loc_nEv, loc_nSes, loc_lOk
LOCAL ARRAY gaEv[1]

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
    SET PROCEDURE TO (gcCaminhoUtils   + "functions.prg")    ADDITIVE
    SET PROCEDURE TO (gcCaminhoUtils   + "messages.prg")     ADDITIVE
    SET PROCEDURE TO (gcCaminhoClasses + "FormErro.prg")     ADDITIVE
    SET PROCEDURE TO (gcCaminhoClasses + "SigPrGf1BO.prg")   ADDITIVE
    SET PROCEDURE TO (gcCaminhoClasses + "SigPrGf2BO.prg")   ADDITIVE
    SET PROCEDURE TO (gcCaminhoForms + "operacionais\FormSigPrGf1.prg") ADDITIVE
    SET PROCEDURE TO (gcCaminhoForms + "operacionais\FormSigPrGf2.prg") ADDITIVE
    LogPasso("0 SETUP: OK")
CATCH TO loc_oErro
    LogPasso("0 SETUP FALHOU: " + loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo))
ENDTRY

*-- 1. Instancia SOZINHO (sem pai, sem crRel1) - nao pode estourar.
TRY
    loc_oForm = CREATEOBJECT("FormSigPrGf2")
    LogPasso("1 INSTANCIA SOZINHO: VARTYPE=" + VARTYPE(loc_oForm) + ;
        IIF(VARTYPE(loc_oForm) = "O", " W=" + TRANSFORM(loc_oForm.Width) + ;
        " H=" + TRANSFORM(loc_oForm.Height), ""))
CATCH TO loc_oErro
    LogPasso("1 INSTANCIA SOZINHO FALHOU: " + loc_oErro.Message + ;
        " LN=" + TRANSFORM(loc_oErro.LineNo) + " PROC=" + loc_oErro.Procedure)
ENDTRY

IF VARTYPE(loc_oForm) = "O"
    TRY
        LogPasso("1a estados pos-carga sem dados: Grf1.Vis=" + TRANSFORM(loc_oForm.cnt_4c_Grf1.Visible) + ;
            " [.T.] Grf2.Vis=" + TRANSFORM(loc_oForm.cnt_4c_Grf2.Visible) + " [.F.]" + ;
            " Aguarde.Vis=" + TRANSFORM(loc_oForm.cnt_4c_Aguarde.Visible) + " [.F.]" + ;
            " Cmdg.Vis=" + TRANSFORM(loc_oForm.obj_4c_CmdgGrafico.Visible) + " [.T.]" + ;
            " ListCount=" + TRANSFORM(loc_oForm.cnt_4c_Grf2.cbo_4c_CmbChave1.ListCount) + " [0]")
    CATCH TO loc_oErro
        LogPasso("1a FALHOU: " + loc_oErro.Message + " PROC=" + loc_oErro.Procedure)
    ENDTRY

    *-- 2. BINDEVENT dos 2 botoes (AEVENTS: 2 args, evento na coluna 3)
    TRY
        loc_nEv = AEVENTS(gaEv, loc_oForm.obj_4c_CmdgGrafico.Buttons(1))
        LogPasso("2a Buttons(1) [Grafico] binds=" + TRANSFORM(loc_nEv) + ;
            IIF(loc_nEv > 0, " [" + gaEv[1, 3] + "->" + gaEv[1, 4] + "]", ""))
    CATCH TO loc_oErro
        LogPasso("2a FALHOU: " + loc_oErro.Message + " PROC=" + loc_oErro.Procedure)
    ENDTRY

    TRY
        loc_nEv = AEVENTS(gaEv, loc_oForm.obj_4c_CmdgGrafico.Buttons(2))
        LogPasso("2b Buttons(2) [Encerrar] binds=" + TRANSFORM(loc_nEv) + ;
            IIF(loc_nEv > 0, " [" + gaEv[1, 3] + "->" + gaEv[1, 4] + "]", ""))
    CATCH TO loc_oErro
        LogPasso("2b FALHOU: " + loc_oErro.Message + " PROC=" + loc_oErro.Procedure)
    ENDTRY

    TRY
        LogPasso("2c metodos existem: MGeraGrafico=" + TRANSFORM(PEMSTATUS(loc_oForm, "MGeraGrafico", 5)) + ;
            " PopularComboChaves=" + TRANSFORM(PEMSTATUS(loc_oForm, "PopularComboChaves", 5)) + ;
            " DesenharGrafico=" + TRANSFORM(PEMSTATUS(loc_oForm, "DesenharGrafico", 5)) + ;
            " ExecutarCargaInicial=" + TRANSFORM(PEMSTATUS(loc_oForm, "ExecutarCargaInicial", 5)) + ;
            " BtnGraficoClick=" + TRANSFORM(PEMSTATUS(loc_oForm, "BtnGraficoClick", 5)) + ;
            " BtnEncerrarClick=" + TRANSFORM(PEMSTATUS(loc_oForm, "BtnEncerrarClick", 5)))
    CATCH TO loc_oErro
        LogPasso("2c FALHOU: " + loc_oErro.Message + " PROC=" + loc_oErro.Procedure)
    ENDTRY

    TRY
        loc_oForm.Release()
        LogPasso("2d Release do form sozinho: VARTYPE=" + VARTYPE(loc_oForm) + " [X = liberado]")
    CATCH TO loc_oErro
        LogPasso("2d FALHOU: " + loc_oErro.Message + " PROC=" + loc_oErro.Procedure)
    ENDTRY
ENDIF

*-- 3. Fluxo REAL fim-a-fim: pai (FormSigPrGf1) populando crRel1 na PROPRIA
*      sessao privada, depois abrindo o filho com o mesmo contrato do
*      BtnProcessarClick (CREATEOBJECT("FormSigPrGf2", <pai>)).
loc_oPai  = .NULL.
loc_oForm = .NULL.

TRY
    loc_oPai = CREATEOBJECT("FormSigPrGf1")
    LogPasso("3 INSTANCIA PAI: VARTYPE=" + VARTYPE(loc_oPai) + ;
        IIF(VARTYPE(loc_oPai) = "O", " DataSessionId=" + TRANSFORM(loc_oPai.DataSessionId), ""))
CATCH TO loc_oErro
    LogPasso("3 INSTANCIA PAI FALHOU: " + loc_oErro.Message + ;
        " LN=" + TRANSFORM(loc_oErro.LineNo) + " PROC=" + loc_oErro.Procedure)
ENDTRY

IF VARTYPE(loc_oPai) = "O"
    TRY
        loc_nSes = SET("DATASESSION")
        SET DATASESSION TO loc_oPai.DataSessionId
        IF USED("crRel1")
            USE IN crRel1
        ENDIF
        CREATE CURSOR crRel1 (cEmps C(3), cTitulo1s C(40), cTitulo2s C(40), ;
                              cEmpresas C(50), cStranomes C(10), nFalhas N(12,2), nPesoccbs N(12,2))
        INSERT INTO crRel1 VALUES ("001", "Falha X Recup Mensal", "2026", "MARCELLA BAHIA", "JAN", 10.50, 20.25)
        INSERT INTO crRel1 VALUES ("001", "Falha X Recup Mensal", "2026", "MARCELLA BAHIA", "FEV", 30.75, 40.00)
        INSERT INTO crRel1 VALUES ("002", "Falha X Recup Mensal", "2026", "OUTRA FILIAL",   "JAN", 5.00,  15.00)
        LogPasso("3a crRel1 populado na sessao do pai: RECCOUNT=" + ;
            TRANSFORM(RECCOUNT("crRel1")))
        SET DATASESSION TO loc_nSes
    CATCH TO loc_oErro
        LogPasso("3a FALHOU: " + loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo))
    ENDTRY

    TRY
        loc_oForm = CREATEOBJECT("FormSigPrGf2", loc_oPai)
        LogPasso("3b INSTANCIA FILHO com pai: VARTYPE=" + VARTYPE(loc_oForm) + ;
            IIF(VARTYPE(loc_oForm) = "O", " DataSessionId=" + TRANSFORM(loc_oForm.DataSessionId) + ;
            " [igual ao pai=" + TRANSFORM(loc_oForm.DataSessionId = loc_oPai.DataSessionId) + "]", ""))
    CATCH TO loc_oErro
        LogPasso("3b FALHOU: " + loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
            " PROC=" + loc_oErro.Procedure)
    ENDTRY

    IF VARTYPE(loc_oForm) = "O"
        TRY
            LogPasso("3c combo populado por ExecutarCargaInicial: ListCount=" + ;
                TRANSFORM(loc_oForm.cnt_4c_Grf2.cbo_4c_CmbChave1.ListCount) + " [2]" + ;
                " Item1=[" + ALLTRIM(loc_oForm.cnt_4c_Grf2.cbo_4c_CmbChave1.List(1)) + "]" + ;
                " Item2=[" + ALLTRIM(loc_oForm.cnt_4c_Grf2.cbo_4c_CmbChave1.List(2)) + "]" + ;
                " ListIndex=" + TRANSFORM(loc_oForm.cnt_4c_Grf2.cbo_4c_CmbChave1.ListIndex) + " [1]")
        CATCH TO loc_oErro
            LogPasso("3c FALHOU: " + loc_oErro.Message + " PROC=" + loc_oErro.Procedure)
        ENDTRY

        TRY
            LogPasso("3d BO apos carga inicial: GraficoGerado=" + ;
                TRANSFORM(loc_oForm.this_oBusinessObject.this_lGraficoGerado) + " [.T.]" + ;
                " Chave=[" + ALLTRIM(loc_oForm.this_oBusinessObject.this_cChaveAtual) + "] [001]" + ;
                " Meses=" + TRANSFORM(loc_oForm.this_oBusinessObject.this_nTotalMeses) + " [2]" + ;
                " Falha=[" + STRTRAN(ALLTRIM(loc_oForm.this_oBusinessObject.this_cSerieFalha), CHR(9), "|") + "]")
        CATCH TO loc_oErro
            LogPasso("3d FALHOU: " + loc_oErro.Message + " PROC=" + loc_oErro.Procedure)
        ENDTRY

        TRY
            loc_nSes = SET("DATASESSION")
            SET DATASESSION TO loc_oForm.DataSessionId
            LogPasso("3e cursor_4c_OleGrafico1 (cache do OLE): USED=" + ;
                TRANSFORM(USED(loc_oForm.this_cCursorOleGrafico)) + " RECCOUNT=" + ;
                TRANSFORM(RECCOUNT(loc_oForm.this_cCursorOleGrafico)) + ;
                " ControlSource=[" + loc_oForm.cnt_4c_Grf1.obj_4c_OleGrafico1.ControlSource + "]")
            SET DATASESSION TO loc_nSes
        CATCH TO loc_oErro
            SET DATASESSION TO loc_nSes
            LogPasso("3e FALHOU: " + loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
                " PROC=" + loc_oErro.Procedure)
        ENDTRY

        *-- 3f. Troca de chave via combo (Click legado -> MGeraGrafico)
        TRY
            loc_oForm.cnt_4c_Grf2.cbo_4c_CmbChave1.ListIndex = 2
            loc_oForm.CboChave1Click()

            loc_nSes = SET("DATASESSION")
            SET DATASESSION TO loc_oForm.DataSessionId
            LogPasso("3f CboChave1Click apos trocar p/ item 2: Chave=[" + ;
                ALLTRIM(loc_oForm.this_oBusinessObject.this_cChaveAtual) + "] [002]" + ;
                " cursor_4c_OleGrafico1 RECCOUNT=" + TRANSFORM(RECCOUNT(loc_oForm.this_cCursorOleGrafico)) + ;
                " LockScreen=" + TRANSFORM(loc_oForm.LockScreen) + " [.F.]")
            SET DATASESSION TO loc_nSes
        CATCH TO loc_oErro
            SET DATASESSION TO loc_nSes
            LogPasso("3f FALHOU: " + loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
                " PROC=" + loc_oErro.Procedure)
        ENDTRY

        *-- 3g. BtnGraficoClick com FRX ausente do acervo - tem de avisar, nao estourar
        TRY
            loc_oForm.BtnGraficoClick()
            LogPasso("3g BtnGraficoClick (FRX ausente esperado) rodou sem excecao")
        CATCH TO loc_oErro
            LogPasso("3g FALHOU (nao deveria estourar): " + loc_oErro.Message + ;
                " LN=" + TRANSFORM(loc_oErro.LineNo) + " PROC=" + loc_oErro.Procedure)
        ENDTRY

        *-- 3h. BtnEncerrarClick fecha o filho e reabilita o pai
        TRY
            loc_oPai.Enabled = .F.
            loc_oForm.BtnEncerrarClick()
            LogPasso("3h BtnEncerrarClick: filho VARTYPE=" + VARTYPE(loc_oForm) + " [X]" + ;
                " pai.Enabled=" + TRANSFORM(loc_oPai.Enabled) + " [.T.]" + ;
                " OleCursorUsed=" + TRANSFORM(USED("cursor_4c_OleGrafico1")) + " [.F. - fechado pelo Encerrar]")
        CATCH TO loc_oErro
            LogPasso("3h FALHOU: " + loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
                " PROC=" + loc_oErro.Procedure)
        ENDTRY
    ENDIF

    TRY
        IF VARTYPE(loc_oPai) = "O"
            loc_oPai.Release()
        ENDIF
        LogPasso("4 Release do pai: OK")
    CATCH TO loc_oErro
        LogPasso("4 FALHOU: " + loc_oErro.Message + " PROC=" + loc_oErro.Procedure)
    ENDTRY
ENDIF

IF FILE(gc_4c_ArquivoErroTeste)
    LogPasso("DIALOGOS SUPRIMIDOS: " + FILETOSTR(gc_4c_ArquivoErroTeste))
ELSE
    LogPasso("DIALOGOS SUPRIMIDOS: nenhum")
ENDIF

LogPasso("FIM " + TTOC(DATETIME()))
QUIT

PROCEDURE LogPasso(par_cTexto)
    STRTOFILE(par_cTexto + CHR(13) + CHR(10), gc_4c_LogPassoGf2F8, .T.)
ENDPROC

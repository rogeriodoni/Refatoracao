*==============================================================================
* ProbeSigPrPro668F7.prg - Probe funcional da FASE 7 de FormSIGPRPRO (task668)
*
* A Fase 7 cobre os "eventos principais dos botoes". MEDE em VFP9 (nao le codigo):
*   1) os 4 handlers do gate existem e sao PUBLIC (PEMSTATUS attr 2 = Protected)
*   2) o funil RecarregarConsulta existe e eh PUBLIC
*   3) chamada EXTERNA dos 6 Btn*Click nao-destrutivos nao estoura
*   4) Visualizar/Buscar SEM produto caem no aviso e NAO derrubam o form
*   5) Visualizar/Buscar COM produto chamam BuscarProduto UMA VEZ (nao duas)
*      - medido por subclasse-contador do BO injetada no form
*   6) o funil repinta/rebinda a grade e sincroniza Comples/Infos com a linha
*   7) Release() dos handlers de saida funciona em instancia descartavel
*
* NAO chama Show(): o form eh modal e travaria o harness.
* SET SAFETY/RESOURCE OFF obrigatorios: pipeline sem supervisao (CLAUDE.md #6).
*==============================================================================
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
PUBLIC gb_4c_ModoTeste, gc_4c_ArquivoErroTeste, gnConnHandle, gc_4c_UsuarioLogado
gb_4c_ModoTeste = .T.
gc_4c_ArquivoErroTeste = "C:\4c\automation\vfp_err_sigprpro668_f7.txt"
#DEFINE OUT "C:\4c\automation\probe_sigprpro668_f7.txt"

LOCAL loc_oForm, loc_oBO, loc_cL, loc_nFalhas, loc_oE, loc_i, loc_cM, loc_nSessaoAnt
LOCAL ARRAY loc_aBtn[8]
loc_nFalhas = 0
loc_cL = ""

STRTOFILE("=== PROBE Fase 7 - FormSIGPRPRO (task668) ===" + CHR(13) + CHR(10), OUT)
IF FILE(gc_4c_ArquivoErroTeste)
    DELETE FILE (gc_4c_ArquivoErroTeste)
ENDIF

loc_aBtn[1] = "BtnIncluirClick"
loc_aBtn[2] = "BtnAlterarClick"
loc_aBtn[3] = "BtnVisualizarClick"
loc_aBtn[4] = "BtnExcluirClick"
loc_aBtn[5] = "BtnBuscarClick"
loc_aBtn[6] = "BtnSalvarClick"
loc_aBtn[7] = "BtnEncerrarClick"
loc_aBtn[8] = "BtnCancelarClick"

TRY
    CD C:\4c\projeto\app\start
    DO config.prg
    gc_4c_UsuarioLogado = "TESTE"
    SET PATH TO (gcCaminhoBase + "," + gcCaminhoClasses + "," + gcCaminhoUtils + "," + gcCaminhoForms + "," + gcCaminhoIcones)
    SET PROCEDURE TO (gcCaminhoClasses + "dataaccess.prg")   ADDITIVE
    SET PROCEDURE TO (gcCaminhoClasses + "businessbase.prg") ADDITIVE
    SET PROCEDURE TO (gcCaminhoClasses + "formbase.prg")     ADDITIVE
    SET PROCEDURE TO (gcCaminhoClasses + "FormErro.prg")     ADDITIVE
    SET PROCEDURE TO (gcCaminhoUtils   + "functions.prg")    ADDITIVE
    SET PROCEDURE TO (gcCaminhoUtils   + "messages.prg")     ADDITIVE
    SET PROCEDURE TO (gcCaminhoUtils   + "validators.prg")   ADDITIVE
    SET PROCEDURE TO (gcCaminhoClasses + "SIGPRPROBO.prg")   ADDITIVE
    SET PROCEDURE TO (gcCaminhoForms + "operacionais\FormSIGPRPRO.prg") ADDITIVE

    gnConnHandle = -1
    gb_4c_ModoTeste = .T.

    loc_oForm = CREATEOBJECT("FormSIGPRPRO", .NULL., "")
    IF VARTYPE(loc_oForm) != "O"
        loc_cL = loc_cL + "[FALHA] 0) form nao instanciou (VARTYPE=" + VARTYPE(loc_oForm) + ")" + CHR(13) + CHR(10)
        loc_nFalhas = loc_nFalhas + 1
    ELSE
        loc_cL = loc_cL + "[OK]    0) form instanciou" + CHR(13) + CHR(10)

        *-- 1) existencia + ESCOPO dos handlers (attr 2 = Protected) ----------
        FOR loc_i = 1 TO 8
            IF !PEMSTATUS(loc_oForm, loc_aBtn[loc_i], 5)
                loc_cL = loc_cL + "[FALHA] 1) " + loc_aBtn[loc_i] + " NAO existe" + CHR(13) + CHR(10)
                loc_nFalhas = loc_nFalhas + 1
            ELSE
                IF PEMSTATUS(loc_oForm, loc_aBtn[loc_i], 2)
                    loc_cL = loc_cL + "[FALHA] 1) " + loc_aBtn[loc_i] + " eh PROTECTED (harness chama de fora)" + CHR(13) + CHR(10)
                    loc_nFalhas = loc_nFalhas + 1
                ELSE
                    loc_cL = loc_cL + "[OK]    1) " + loc_aBtn[loc_i] + " existe e eh PUBLIC" + CHR(13) + CHR(10)
                ENDIF
            ENDIF
        ENDFOR

        *-- 2) funil ----------------------------------------------------------
        IF PEMSTATUS(loc_oForm, "RecarregarConsulta", 5) AND !PEMSTATUS(loc_oForm, "RecarregarConsulta", 2)
            loc_cL = loc_cL + "[OK]    2) funil RecarregarConsulta existe e eh PUBLIC" + CHR(13) + CHR(10)
        ELSE
            loc_cL = loc_cL + "[FALHA] 2) funil RecarregarConsulta ausente ou PROTECTED" + CHR(13) + CHR(10)
            loc_nFalhas = loc_nFalhas + 1
        ENDIF

        *-- 3) chamada EXTERNA dos 6 handlers nao-destrutivos, SEM produto -----
        FOR loc_i = 1 TO 6
            loc_cM = loc_aBtn[loc_i]
            TRY
                loc_oForm.&loc_cM.()
                loc_cL = loc_cL + "[OK]    3) " + loc_cM + " chamado de fora, sem erro" + CHR(13) + CHR(10)
            CATCH TO loc_oE
                loc_cL = loc_cL + "[FALHA] 3) " + loc_cM + " -> " + loc_oE.Message + CHR(13) + CHR(10)
                loc_nFalhas = loc_nFalhas + 1
            ENDTRY
        ENDFOR

        *-- 4) form sobreviveu ------------------------------------------------
        IF VARTYPE(loc_oForm) = "O" AND loc_oForm.BaseClass = "Form"
            loc_cL = loc_cL + "[OK]    4) form SOBREVIVEU aos 6 handlers (sem produto)" + CHR(13) + CHR(10)
        ELSE
            loc_cL = loc_cL + "[FALHA] 4) form morreu durante os handlers" + CHR(13) + CHR(10)
            loc_nFalhas = loc_nFalhas + 1
        ENDIF

        *-- 5) CONTAGEM de BuscarProduto por clique ---------------------------
        loc_oBO = CREATEOBJECT("SIGPRPROBOContador")
        *-- O form eh DataSession = 2: o cursor da grade vive na sessao
        *-- PRIVADA dele. O BO-contador foi criado NESTA sessao, entao sem
        *-- receber o DataSessionID ele nao enxerga cursor_4c_Carac e o probe
        *-- mediria campo vazio por artefato proprio, nao por defeito do form.
        loc_oBO.nSessao = loc_oForm.DataSessionID
        loc_oForm.this_oBusinessObject = loc_oBO
        loc_oForm.this_cCPros = "PROD001"

        loc_oBO.nChamadasProduto = 0
        loc_oBO.nChamadasCarac   = 0
        loc_oForm.BtnVisualizarClick()
        loc_cL = loc_cL + "        5) Visualizar -> BuscarProduto=" + TRANSFORM(loc_oBO.nChamadasProduto) + ;
                 " BuscarCaracteristicas=" + TRANSFORM(loc_oBO.nChamadasCarac) + CHR(13) + CHR(10)
        IF loc_oBO.nChamadasProduto = 1
            loc_cL = loc_cL + "[OK]    5) Visualizar chama BuscarProduto UMA vez" + CHR(13) + CHR(10)
        ELSE
            loc_cL = loc_cL + "[FALHA] 5) Visualizar chama BuscarProduto " + TRANSFORM(loc_oBO.nChamadasProduto) + "x (esperado 1)" + CHR(13) + CHR(10)
            loc_nFalhas = loc_nFalhas + 1
        ENDIF

        loc_oBO.nChamadasProduto = 0
        loc_oBO.nChamadasCarac   = 0
        loc_oForm.BtnBuscarClick()
        loc_cL = loc_cL + "        5) Buscar     -> BuscarProduto=" + TRANSFORM(loc_oBO.nChamadasProduto) + ;
                 " BuscarCaracteristicas=" + TRANSFORM(loc_oBO.nChamadasCarac) + CHR(13) + CHR(10)
        IF loc_oBO.nChamadasProduto = 1
            loc_cL = loc_cL + "[OK]    5) Buscar chama BuscarProduto UMA vez" + CHR(13) + CHR(10)
        ELSE
            loc_cL = loc_cL + "[FALHA] 5) Buscar chama BuscarProduto " + TRANSFORM(loc_oBO.nChamadasProduto) + "x (esperado 1)" + CHR(13) + CHR(10)
            loc_nFalhas = loc_nFalhas + 1
        ENDIF

        *-- 6) grade rebindada pelo funil + sincronia dos campos --------------
        loc_cL = loc_cL + "        6) grade: ColumnCount=" + TRANSFORM(loc_oForm.grd_4c_Dados.ColumnCount) + ;
                 " RecordSource=[" + loc_oForm.grd_4c_Dados.RecordSource + "]" + ;
                 " ControlSource=[" + loc_oForm.grd_4c_Dados.Column1.ControlSource + "]" + ;
                 " Width=" + TRANSFORM(loc_oForm.grd_4c_Dados.Column1.Width) + ;
                 " Header=[" + loc_oForm.grd_4c_Dados.Column1.Header1.Caption + "]" + CHR(13) + CHR(10)
        IF loc_oForm.grd_4c_Dados.ColumnCount = 1 ;
           AND UPPER(ALLTRIM(loc_oForm.grd_4c_Dados.RecordSource)) == "CURSOR_4C_CARAC" ;
           AND loc_oForm.grd_4c_Dados.Column1.Width = 363
            loc_cL = loc_cL + "[OK]    6) funil repintou/rebindou a grade" + CHR(13) + CHR(10)
        ELSE
            loc_cL = loc_cL + "[FALHA] 6) grade nao ficou rebindada apos o funil" + CHR(13) + CHR(10)
            loc_nFalhas = loc_nFalhas + 1
        ENDIF

        loc_cL = loc_cL + "        6) DPros=[" + ALLTRIM(loc_oForm.txt_4c_DPros.Value) + "]" + ;
                 " Comples=[" + ALLTRIM(loc_oForm.txt_4c_Comples.Value) + "]" + ;
                 " Infos=[" + ALLTRIM(loc_oForm.edt_4c_Infos.Value) + "]" + CHR(13) + CHR(10)
        IF ALLTRIM(loc_oForm.txt_4c_Comples.Value) == "COMPL-1" AND ALLTRIM(loc_oForm.edt_4c_Infos.Value) == "INFO-1"
            loc_cL = loc_cL + "[OK]    6) Comples/Infos sincronizados com a LINHA 1" + CHR(13) + CHR(10)
        ELSE
            loc_cL = loc_cL + "[FALHA] 6) Comples/Infos NAO refletem a linha corrente" + CHR(13) + CHR(10)
            loc_nFalhas = loc_nFalhas + 1
        ENDIF

        *-- navegacao real: o AfterRowColChange da Fase 7 segue a LINHA
        loc_nSessaoAnt = SET("Datasession")
        SET DATASESSION TO loc_oForm.DataSessionID
        SELECT cursor_4c_Carac
        GO 2
        SET DATASESSION TO loc_nSessaoAnt
        loc_oForm.GrdDadosAfterRowColChange(1)
        IF ALLTRIM(loc_oForm.txt_4c_Comples.Value) == "COMPL-2"
            loc_cL = loc_cL + "[OK]    6) AfterRowColChange segue a linha 2 (COMPL-2)" + CHR(13) + CHR(10)
        ELSE
            loc_cL = loc_cL + "[FALHA] 6) AfterRowColChange nao seguiu a linha 2 (leu [" + ;
                     ALLTRIM(loc_oForm.txt_4c_Comples.Value) + "])" + CHR(13) + CHR(10)
            loc_nFalhas = loc_nFalhas + 1
        ENDIF

        loc_oForm = .NULL.
    ENDIF

    *-- 7) handlers de SAIDA, cada um em instancia descartavel ---------------
    FOR loc_i = 7 TO 8
        loc_cM = loc_aBtn[loc_i]
        TRY
            loc_oForm = CREATEOBJECT("FormSIGPRPRO", .NULL., "")
            loc_oForm.&loc_cM.()
            loc_cL = loc_cL + "[OK]    7) " + loc_cM + " executou Release sem erro" + CHR(13) + CHR(10)
            loc_oForm = .NULL.
        CATCH TO loc_oE
            loc_cL = loc_cL + "[FALHA] 7) " + loc_cM + " -> " + loc_oE.Message + CHR(13) + CHR(10)
            loc_nFalhas = loc_nFalhas + 1
        ENDTRY
    ENDFOR

    TRY
        loc_oForm = CREATEOBJECT("FormSIGPRPRO", .NULL., "")
        loc_oForm.CmdOkClick()
        loc_cL = loc_cL + "[OK]    7) CmdOkClick executou Release sem erro" + CHR(13) + CHR(10)
        loc_oForm = .NULL.
    CATCH TO loc_oE
        loc_cL = loc_cL + "[FALHA] 7) CmdOkClick -> " + loc_oE.Message + CHR(13) + CHR(10)
        loc_nFalhas = loc_nFalhas + 1
    ENDTRY

CATCH TO loc_oE
    loc_cL = loc_cL + "[FATAL] " + loc_oE.Message + " | LN=" + TRANSFORM(loc_oE.LineNo) + ;
             " | PROC=" + loc_oE.Procedure + CHR(13) + CHR(10)
    loc_nFalhas = loc_nFalhas + 1
ENDTRY

loc_cL = loc_cL + CHR(13) + CHR(10) + "FALHAS=" + TRANSFORM(loc_nFalhas) + CHR(13) + CHR(10)
STRTOFILE(loc_cL, OUT, 1)
QUIT

*==============================================================================
* Subclasse-CONTADOR do BO: nao toca no banco, so conta as chamadas e popula o
* cursor da grade. Serve para medir quantas vezes cada clique consulta o
* produto - era 2 antes da consolidacao da Fase 7, tem de ser 1 agora.
*==============================================================================
DEFINE CLASS SIGPRPROBOContador AS SIGPRPROBO
    nChamadasProduto = 0
    nChamadasCarac   = 0
    nSessao          = 0

    PROCEDURE Init()
        RETURN .T.
    ENDPROC

    PROCEDURE BuscarProduto(par_cCPros)
        THIS.nChamadasProduto = THIS.nChamadasProduto + 1
        THIS.this_cDPros = "PRODUTO DE TESTE"
        RETURN .T.
    ENDPROC

    PROCEDURE BuscarCaracteristicas(par_cCPros)
        LOCAL loc_nAnt
        THIS.nChamadasCarac = THIS.nChamadasCarac + 1
        loc_nAnt = SET("Datasession")
        IF THIS.nSessao > 0
            SET DATASESSION TO THIS.nSessao
        ENDIF
        *-- NAO usar ZAP: ZAP em DataSession PRIVADA trava o VFP9 (licao
        *-- registrada). O cursor nasce vazio, e so o topo eh conferido.
        IF USED("cursor_4c_Carac") AND RECCOUNT("cursor_4c_Carac") = 0
            INSERT INTO cursor_4c_Carac (cidchaves, caracteris, compls, cpros, infos) ;
                VALUES ("K1", "CARAC-1", "COMPL-1", "PROD001", "INFO-1")
            INSERT INTO cursor_4c_Carac (cidchaves, caracteris, compls, cpros, infos) ;
                VALUES ("K2", "CARAC-2", "COMPL-2", "PROD001", "INFO-2")
        ENDIF
        IF USED("cursor_4c_Carac")
            SELECT cursor_4c_Carac
            GO TOP
        ENDIF
        SET DATASESSION TO loc_nAnt
        RETURN .T.
    ENDPROC
ENDDEFINE

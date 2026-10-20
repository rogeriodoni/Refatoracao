*==============================================================================
* ProbeSigPrPro668F6.prg - Probe funcional da Fase 6 de FormSIGPRPRO (task668)
*
* A Fase 6 cobre "campos restantes + lookups + botoes de acao". O SIGPRPRO.SCX
* legado tem ZERO lookup (getCPros/getDPros sao Enabled=.F.; getComples/GetMemo
* e o Text1 da coluna tem When() retornando falso) e UM unico botao ("Ok"),
* entao o que ha para medir eh a superficie de DADOS e os EVENTOS.
*
* MEDE em VFP9 (nao le o codigo):
*   1) o form instancia com os 2 parametros do legado (pFrm, pPro)
*   2) BINDEVENT realmente registrado em AfterRowColChange e Click (AEVENTS)
*   3) ZERO metodo de lookup no form - coerente com ZERO lookup no SCX
*   4) os 3 controles que o legado trava estao inacessiveis no migrado
*   5) VincularGrade RESTAURA tudo depois do cursor ser DESTRUIDO e recriado
*      (eh o que BuscarCaracteristicas faz: USE IN + SQLEXEC sobre o alias da
*      grade, que ZERA ColumnCount)
*   6) navegacao real na grade: Comples/Infos seguem a LINHA CORRENTE
*   7) BOParaForm / FormParaBO / LimparCampos / HabilitarCampos sem estourar
*   8) os Btn*Click do harness (regra #3) respondem sem Property not found
*
* NAO chama Show(): o form eh modal e travaria o harness.
*==============================================================================
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
PUBLIC gb_4c_ModoTeste, gc_4c_ArquivoErroTeste, gnConnHandle, gc_4c_UsuarioLogado
gb_4c_ModoTeste = .T.
gc_4c_ArquivoErroTeste = "C:\4c\automation\vfp_err_sigprpro668_f6.txt"
#DEFINE OUT "C:\4c\automation\probe_sigprpro668_f6.txt"

LOCAL loc_oForm, loc_oBO, loc_cL, loc_nFalhas, loc_oE, loc_i, loc_nEv
LOCAL ARRAY loc_aEv[1, 5]
loc_nFalhas = 0
loc_cL = ""

STRTOFILE("=== PROBE Fase 6 - FormSIGPRPRO (task668) ===" + CHR(13) + CHR(10), OUT)
IF FILE(gc_4c_ArquivoErroTeste)
    DELETE FILE (gc_4c_ArquivoErroTeste)
ENDIF

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

    *-- 1) instanciacao -------------------------------------------------------
    loc_oForm = CREATEOBJECT("FormSIGPRPRO", .NULL., "")
    loc_cL = loc_cL + "1) VARTYPE(form) = [" + VARTYPE(loc_oForm) + "] (esperado O)" + CHR(13) + CHR(10)
    IF VARTYPE(loc_oForm) != "O"
        STRTOFILE(loc_cL + "ABORTADO: form nao instanciou" + CHR(13) + CHR(10), OUT, 1)
        QUIT
    ENDIF
    loc_oBO = loc_oForm.this_oBusinessObject

    *-- 2) BINDEVENT efetivamente registrado ---------------------------------
    loc_cL = loc_cL + CHR(13) + CHR(10) + "2) BINDEVENT REGISTRADO (AEVENTS):" + CHR(13) + CHR(10)
    loc_nEv = AEVENTS(loc_aEv, loc_oForm.grd_4c_Dados)
    loc_cL = loc_cL + "   grd_4c_Dados -> " + TRANSFORM(loc_nEv) + " binding(s)" + CHR(13) + CHR(10)
    FOR loc_i = 1 TO loc_nEv
        loc_cL = loc_cL + "     evento=[" + loc_aEv[loc_i, 3] + "] delegate=[" + loc_aEv[loc_i, 4] + "]" + CHR(13) + CHR(10)
    ENDFOR
    IF loc_nEv < 1
        loc_cL = loc_cL + "   *** FALHA: AfterRowColChange nao vinculado" + CHR(13) + CHR(10)
        loc_nFalhas = loc_nFalhas + 1
    ENDIF
    loc_nEv = AEVENTS(loc_aEv, loc_oForm.cmd_4c_Ok)
    loc_cL = loc_cL + "   cmd_4c_Ok    -> " + TRANSFORM(loc_nEv) + " binding(s)" + CHR(13) + CHR(10)
    FOR loc_i = 1 TO loc_nEv
        loc_cL = loc_cL + "     evento=[" + loc_aEv[loc_i, 3] + "] delegate=[" + loc_aEv[loc_i, 4] + "]" + CHR(13) + CHR(10)
    ENDFOR
    IF loc_nEv < 1
        loc_cL = loc_cL + "   *** FALHA: Click do OK nao vinculado" + CHR(13) + CHR(10)
        loc_nFalhas = loc_nFalhas + 1
    ENDIF

    *-- 3) zero lookup (o SCX legado tambem tem zero) -------------------------
    loc_cL = loc_cL + CHR(13) + CHR(10) + "3) LOOKUPS (legado tem ZERO):" + CHR(13) + CHR(10)
    loc_cL = loc_cL + "   AbrirLookupProduto existe = " + TRANSFORM(PEMSTATUS(loc_oForm, "AbrirLookupProduto", 5)) + CHR(13) + CHR(10)
    loc_cL = loc_cL + "   AbrirBuscaProduto  existe = " + TRANSFORM(PEMSTATUS(loc_oForm, "AbrirBuscaProduto", 5)) + CHR(13) + CHR(10)
    loc_cL = loc_cL + "   (ambos falso = fiel ao legado; verdadeiro seria lookup INVENTADO)" + CHR(13) + CHR(10)

    *-- 4) controles que o legado trava ---------------------------------------
    loc_cL = loc_cL + CHR(13) + CHR(10) + "4) CONTROLES TRAVADOS NO LEGADO:" + CHR(13) + CHR(10)
    loc_cL = loc_cL + "   txt_4c_CPros.Enabled    = " + TRANSFORM(loc_oForm.txt_4c_CPros.Enabled)   + " (SCX getCPros.Enabled falso)" + CHR(13) + CHR(10)
    loc_cL = loc_cL + "   txt_4c_DPros.Enabled    = " + TRANSFORM(loc_oForm.txt_4c_DPros.Enabled)   + " (SCX getDPros.Enabled falso)" + CHR(13) + CHR(10)
    loc_cL = loc_cL + "   txt_4c_Comples.ReadOnly = " + TRANSFORM(loc_oForm.txt_4c_Comples.ReadOnly) + " (SCX getComples.When falso)" + CHR(13) + CHR(10)
    loc_cL = loc_cL + "   edt_4c_Infos.ReadOnly   = " + TRANSFORM(loc_oForm.edt_4c_Infos.ReadOnly)   + " (SCX GetMemo.When falso)" + CHR(13) + CHR(10)
    loc_cL = loc_cL + "   grd.Column1.ReadOnly    = " + TRANSFORM(loc_oForm.grd_4c_Dados.Column1.ReadOnly) + " (SCX Text1.When falso)" + CHR(13) + CHR(10)
    loc_cL = loc_cL + "   txt_4c_DPros.Format     = [" + loc_oForm.txt_4c_DPros.Format + "] (SCX: K!)" + CHR(13) + CHR(10)
    IF loc_oForm.txt_4c_CPros.Enabled OR loc_oForm.txt_4c_DPros.Enabled ;
       OR !loc_oForm.txt_4c_Comples.ReadOnly OR !loc_oForm.edt_4c_Infos.ReadOnly ;
       OR !loc_oForm.grd_4c_Dados.Column1.ReadOnly
        loc_nFalhas = loc_nFalhas + 1
    ENDIF
    IF loc_oForm.txt_4c_DPros.Format != "K!"
        loc_nFalhas = loc_nFalhas + 1
    ENDIF

    *-- 5) VincularGrade apos o cursor ser DESTRUIDO e recriado ---------------
    SET DATASESSION TO loc_oForm.DataSessionID
    loc_cL = loc_cL + CHR(13) + CHR(10) + "5) REBIND APOS CURSOR DESTRUIDO/RECRIADO:" + CHR(13) + CHR(10)
    IF USED("cursor_4c_Carac")
        USE IN cursor_4c_Carac
    ENDIF
    SET NULL ON
    CREATE CURSOR cursor_4c_Carac ;
        (cidchaves C(20), caracteris C(40), compls C(40), cpros C(14), infos M)
    SET NULL OFF
    INSERT INTO cursor_4c_Carac (cidchaves, caracteris, compls, cpros, infos) ;
        VALUES ("CHV001", "COR", "AZUL METALICO", "PRD0001", "Info da COR")
    INSERT INTO cursor_4c_Carac (cidchaves, caracteris, compls, cpros, infos) ;
        VALUES ("CHV002", "TAMANHO", "44 BR", "PRD0001", "Info do TAMANHO")
    INSERT INTO cursor_4c_Carac (cidchaves, caracteris, compls, cpros, infos) ;
        VALUES ("CHV003", "MATERIAL", "COURO", "PRD0001", "Info do MATERIAL")
    loc_cL = loc_cL + "   ANTES do rebind: ColumnCount=" + ;
             TRANSFORM(loc_oForm.grd_4c_Dados.ColumnCount) + " RecordSource=[" + ;
             loc_oForm.grd_4c_Dados.RecordSource + "]" + CHR(13) + CHR(10)
    loc_oForm.VincularGrade()
    loc_cL = loc_cL + "   DEPOIS do rebind:" + CHR(13) + CHR(10)
    loc_cL = loc_cL + "     ColumnCount            = " + TRANSFORM(loc_oForm.grd_4c_Dados.ColumnCount) + " (esperado 1)" + CHR(13) + CHR(10)
    loc_cL = loc_cL + "     RecordSource           = [" + loc_oForm.grd_4c_Dados.RecordSource + "]" + CHR(13) + CHR(10)
    loc_cL = loc_cL + "     Column1.ControlSource  = [" + loc_oForm.grd_4c_Dados.Column1.ControlSource + "]" + CHR(13) + CHR(10)
    loc_cL = loc_cL + "     Column1.Width          = " + TRANSFORM(loc_oForm.grd_4c_Dados.Column1.Width) + " (esperado 363, NAO 90)" + CHR(13) + CHR(10)
    loc_cL = loc_cL + "     Column1.Header1.Cap    = [" + loc_oForm.grd_4c_Dados.Column1.Header1.Caption + "]" + CHR(13) + CHR(10)
    loc_cL = loc_cL + "     Column1.Text1.FontName = [" + loc_oForm.grd_4c_Dados.Column1.Text1.FontName + "] (dump: Tahoma)" + CHR(13) + CHR(10)
    loc_cL = loc_cL + "     Column1.ReadOnly       = " + TRANSFORM(loc_oForm.grd_4c_Dados.Column1.ReadOnly) + CHR(13) + CHR(10)
    loc_cL = loc_cL + "     RECNO apos GO TOP      = " + TRANSFORM(RECNO("cursor_4c_Carac")) + " (esperado 1)" + CHR(13) + CHR(10)
    IF loc_oForm.grd_4c_Dados.ColumnCount != 1 ;
       OR UPPER(ALLTRIM(loc_oForm.grd_4c_Dados.Column1.ControlSource)) != UPPER("cursor_4c_Carac.caracteris") ;
       OR loc_oForm.grd_4c_Dados.Column1.Width != 363 ;
       OR UPPER(ALLTRIM(loc_oForm.grd_4c_Dados.Column1.Text1.FontName)) != "TAHOMA" ;
       OR !loc_oForm.grd_4c_Dados.Column1.ReadOnly
        loc_cL = loc_cL + "   *** FALHA no rebind" + CHR(13) + CHR(10)
        loc_nFalhas = loc_nFalhas + 1
    ENDIF

    *-- 6) navegacao real: detalhe segue a linha corrente ---------------------
    loc_cL = loc_cL + CHR(13) + CHR(10) + "6) NAVEGACAO NA GRADE (AfterRowColChange):" + CHR(13) + CHR(10)
    FOR loc_i = 1 TO 3
        GO (loc_i) IN cursor_4c_Carac
        loc_oForm.GrdDadosAfterRowColChange(1)
        loc_cL = loc_cL + "   linha " + TRANSFORM(loc_i) + ": carac=[" + ;
                 ALLTRIM(cursor_4c_Carac.caracteris) + "] -> Comples=[" + ;
                 ALLTRIM(loc_oForm.txt_4c_Comples.Value) + "] Infos=[" + ;
                 ALLTRIM(loc_oForm.edt_4c_Infos.Value) + "]" + CHR(13) + CHR(10)
        IF ALLTRIM(loc_oForm.txt_4c_Comples.Value) != ALLTRIM(cursor_4c_Carac.compls)
            loc_cL = loc_cL + "   *** FALHA: Comples nao seguiu a linha" + CHR(13) + CHR(10)
            loc_nFalhas = loc_nFalhas + 1
        ENDIF
        IF ALLTRIM(loc_oForm.edt_4c_Infos.Value) != ALLTRIM(cursor_4c_Carac.infos)
            loc_cL = loc_cL + "   *** FALHA: Infos nao seguiu a linha" + CHR(13) + CHR(10)
            loc_nFalhas = loc_nFalhas + 1
        ENDIF
    ENDFOR

    *-- 7) superficie de dados do form ----------------------------------------
    *-- FormParaBO/BOParaForm/LimparCampos/HabilitarCampos sao hooks PROTECTED
    *-- em FormBase (linhas 276-285) e so podem ser chamados pelo proprio form
    *-- ou por FormBase - chama-los daqui estoura "Property X is not found"
    *-- (regra #51 ao contrario: o PROTECTED da base prevalece). Entao o que se
    *-- mede aqui eh o ESCOPO (atributo 2 = Protected), que tem de bater com o
    *-- da base e com o da referencia canonica FormCor; e a carga de dados vai
    *-- pelo caminho PUBLIC de verdade, CarregarDados().
    loc_cL = loc_cL + CHR(13) + CHR(10) + "7) HOOKS DE DADOS - ESCOPO (esperado .T. = Protected, igual FormBase/FormCor):" + CHR(13) + CHR(10)
    loc_cL = loc_cL + "   FormParaBO      Protected = " + TRANSFORM(PEMSTATUS(loc_oForm, "FormParaBO", 2)) + CHR(13) + CHR(10)
    loc_cL = loc_cL + "   BOParaForm      Protected = " + TRANSFORM(PEMSTATUS(loc_oForm, "BOParaForm", 2)) + CHR(13) + CHR(10)
    loc_cL = loc_cL + "   HabilitarCampos Protected = " + TRANSFORM(PEMSTATUS(loc_oForm, "HabilitarCampos", 2)) + CHR(13) + CHR(10)
    loc_cL = loc_cL + "   LimparCampos    Protected = " + TRANSFORM(PEMSTATUS(loc_oForm, "LimparCampos", 2)) + CHR(13) + CHR(10)
    IF !PEMSTATUS(loc_oForm, "FormParaBO", 2) OR !PEMSTATUS(loc_oForm, "BOParaForm", 2)
        loc_cL = loc_cL + "   *** divergencia de escopo em relacao a FormBase" + CHR(13) + CHR(10)
        loc_nFalhas = loc_nFalhas + 1
    ENDIF
    loc_cL = loc_cL + "   carga pelo caminho PUBLIC (CarregarDados):" + CHR(13) + CHR(10)
    TRY
        loc_oBO.this_cDPros   = "SAPATO SOCIAL PRETO"
        loc_oForm.this_cCPros = "PRD0001"
        loc_oForm.CarregarDados()
        loc_cL = loc_cL + "     CarregarDados() OK | DPros=[" + ALLTRIM(loc_oForm.txt_4c_DPros.Value) + ;
                 "] Comples=[" + ALLTRIM(loc_oForm.txt_4c_Comples.Value) + ;
                 "] Infos=[" + ALLTRIM(loc_oForm.edt_4c_Infos.Value) + "]" + CHR(13) + CHR(10)
        loc_cL = loc_cL + "     CPros.Enabled = " + TRANSFORM(loc_oForm.txt_4c_CPros.Enabled) + ;
                 " (segue falso - tela somente leitura)" + CHR(13) + CHR(10)
        IF loc_oForm.txt_4c_CPros.Enabled
            loc_nFalhas = loc_nFalhas + 1
        ENDIF
    CATCH TO loc_oE
        loc_cL = loc_cL + "     *** ERRO: " + loc_oE.Message + " | PROC=" + loc_oE.Procedure + CHR(13) + CHR(10)
        loc_nFalhas = loc_nFalhas + 1
    ENDTRY

    *-- 8) handlers chamados de FORA pelo harness (regra #3) ------------------
    loc_cL = loc_cL + CHR(13) + CHR(10) + "8) HANDLERS DO HARNESS (chamada externa):" + CHR(13) + CHR(10)
    TRY
        loc_oForm.AjustarBotoesPorModo()
        loc_cL = loc_cL + "   AjustarBotoesPorModo() OK" + CHR(13) + CHR(10)
        loc_oForm.AlternarPagina(1)
        loc_cL = loc_cL + "   AlternarPagina(1)      OK" + CHR(13) + CHR(10)
        loc_oForm.CarregarLista()
        loc_cL = loc_cL + "   CarregarLista()        OK" + CHR(13) + CHR(10)
        loc_oForm.BtnVisualizarClick()
        loc_cL = loc_cL + "   BtnVisualizarClick()   OK" + CHR(13) + CHR(10)
        loc_oForm.BtnBuscarClick()
        loc_cL = loc_cL + "   BtnBuscarClick()       OK" + CHR(13) + CHR(10)
    CATCH TO loc_oE
        loc_cL = loc_cL + "   *** ERRO: " + loc_oE.Message + " | PROC=" + loc_oE.Procedure + CHR(13) + CHR(10)
        loc_nFalhas = loc_nFalhas + 1
    ENDTRY

    SET DATASESSION TO 1
    loc_oForm.Release()
    loc_oForm = .NULL.

CATCH TO loc_oE
    loc_cL = loc_cL + CHR(13) + CHR(10) + "EXCECAO: " + loc_oE.Message + ;
             " | LN=" + TRANSFORM(loc_oE.LineNo) + " | PROC=" + loc_oE.Procedure + CHR(13) + CHR(10)
    loc_nFalhas = loc_nFalhas + 1
ENDTRY

loc_cL = loc_cL + CHR(13) + CHR(10) + "=== FALHAS = " + TRANSFORM(loc_nFalhas) + " ===" + CHR(13) + CHR(10)
IF FILE(gc_4c_ArquivoErroTeste)
    loc_cL = loc_cL + "--- ERROS CAPTURADOS EM MODO TESTE ---" + CHR(13) + CHR(10) + FILETOSTR(gc_4c_ArquivoErroTeste)
ENDIF
STRTOFILE(loc_cL, OUT, 1)
QUIT

*==============================================================================
* ProbeCgfFormF8.prg - Prova a Fase 8/8 (eventos auxiliares e consolidacao)
* do FormSIGOPCGF (task691). Cobre o que as fases anteriores nao exercitavam:
*   1) instanciacao completa (Init -> InicializarForm, agora passando por
*      HabilitarCampos) - prova que os ~59 nomes de controle referenciados
*      pelos funis novos existem de fato
*   2) os 9 metodos da Fase 8 existem e tem o escopo esperado
*   3) contrato de digitacao: campos de detalhe da Page2 ReadOnly (When .f.
*      do legado) e getContEms focavel (unico sem When no SCX)
*   4) AlternarPagina(2)/(1) - modo, ActivePage e o estado dos filtros
*   5) LimparCampos zera os campos de detalhe (via AfterRowColChange)
*   6) AjustarBotoesPorModo desabilita as acoes sem linha corrente
*   7) FormParaBO/BOParaForm - round-trip dos filtros pelo BO
*   8) CarregarLista sem cursor de resultado (nao estoura, devolve .F.)
*   9) BtnCancelarClick na Page1 fecha o form sem excecao
*
* Script auxiliar de pipeline: SET SAFETY OFF + SET RESOURCE OFF
* obrigatorios (regra #6 - execucao unattended).
*==============================================================================
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF

PUBLIC gb_4c_ModoTeste, gc_4c_ArquivoErroTeste, gnConnHandle, gc_4c_UsuarioLogado
gb_4c_ModoTeste        = .T.
gc_4c_ArquivoErroTeste = "C:\4c\automation\vfp_err_cgfform_f8.txt"

#DEFINE OUT "C:\4c\automation\probe_cgfform_f8.txt"

LOCAL loc_oE, loc_oForm, loc_oP1, loc_oP2, loc_oBO, loc_nI, loc_cL
LOCAL ARRAY loc_aMet[9]

STRTOFILE("=== PROBE FormSIGOPCGF - Fase 8/8 (task691) ===" + CHR(13) + CHR(10), OUT)
IF FILE(gc_4c_ArquivoErroTeste)
    DELETE FILE (gc_4c_ArquivoErroTeste)
ENDIF

TRY
    CD C:\4c\projeto\app\start
    DO config.prg
    gc_4c_UsuarioLogado = "TESTE"
    gnConnHandle = -1

    SET PATH TO (gcCaminhoBase + "," + gcCaminhoClasses + "," + gcCaminhoUtils + "," + gcCaminhoForms + "," + gcCaminhoIcones)
    SET PROCEDURE TO (gcCaminhoClasses + "dataaccess.prg")                 ADDITIVE
    SET PROCEDURE TO (gcCaminhoClasses + "businessbase.prg")               ADDITIVE
    SET PROCEDURE TO (gcCaminhoClasses + "formbase.prg")                   ADDITIVE
    SET PROCEDURE TO (gcCaminhoClasses + "gridbase.prg")                   ADDITIVE
    SET PROCEDURE TO (gcCaminhoClasses + "FormErro.prg")                   ADDITIVE
    SET PROCEDURE TO (gcCaminhoUtils   + "functions.prg")                  ADDITIVE
    SET PROCEDURE TO (gcCaminhoUtils   + "messages.prg")                   ADDITIVE
    SET PROCEDURE TO (gcCaminhoUtils   + "validators.prg")                 ADDITIVE
    SET PROCEDURE TO (gcCaminhoClasses + "FormBuscaAuxiliar.prg")          ADDITIVE
    SET PROCEDURE TO (gcCaminhoClasses + "SIGOPCGFBO.prg")                 ADDITIVE
    SET PROCEDURE TO (gcCaminhoForms + "operacionais\FormSIGOPCGF.prg")    ADDITIVE

    *-- ================================================= 1) instanciacao
    loc_oForm = CREATEOBJECT("FormSIGOPCGF")
    STRTOFILE("1) CREATEOBJECT FormSIGOPCGF -> VARTYPE=" + VARTYPE(loc_oForm) + ;
        IIF(VARTYPE(loc_oForm) = "O", " Caption=[" + loc_oForm.Caption + "]", "") + ;
        CHR(13) + CHR(10), OUT, 1)

    IF VARTYPE(loc_oForm) != "O"
        IF FILE(gc_4c_ArquivoErroTeste)
            STRTOFILE("   ERRO REGISTRADO: " + FILETOSTR(gc_4c_ArquivoErroTeste) + ;
                CHR(13) + CHR(10), OUT, 1)
        ENDIF
        STRTOFILE("ABORTADO - form nao instanciou" + CHR(13) + CHR(10), OUT, 1)
        QUIT
    ENDIF

    *-- O form tem DataSession = 2 (sessao PRIVADA): cursores criados aqui
    *-- na sessao default NAO sao vistos pelos metodos dele. Entrar na
    *-- sessao do form antes de mexer em cursor.
    SET DATASESSION TO loc_oForm.DataSessionId

    loc_oP1 = loc_oForm.pgf_4c_Paginas.Page1
    loc_oP2 = loc_oForm.pgf_4c_Paginas.Page2
    loc_oBO = loc_oForm.this_oBusinessObject

    *-- ====================================== 2) metodos da Fase 8 existem
    loc_aMet[1] = "BtnBuscarClick"
    loc_aMet[2] = "BtnCancelarClick"
    loc_aMet[3] = "BtnEncerrarClick"
    loc_aMet[4] = "CarregarLista"
    loc_aMet[5] = "AjustarBotoesPorModo"
    loc_aMet[6] = "HabilitarCampos"
    loc_aMet[7] = "LimparCampos"
    loc_aMet[8] = "FormParaBO"
    loc_aMet[9] = "BOParaForm"

    loc_cL = "2) metodos Fase 8 (existe / protected):" + CHR(13) + CHR(10)
    FOR loc_nI = 1 TO 9
        loc_cL = loc_cL + "   " + PADR(loc_aMet[loc_nI], 24) + ;
            " existe=" + IIF(PEMSTATUS(loc_oForm, loc_aMet[loc_nI], 5), "SIM", "NAO") + ;
            " protected=" + IIF(PEMSTATUS(loc_oForm, loc_aMet[loc_nI], 2), "SIM", "NAO") + ;
            CHR(13) + CHR(10)
    ENDFOR
    STRTOFILE(loc_cL, OUT, 1)

    *-- ============================== 3) contrato de digitacao da Page2
    STRTOFILE("3) Page2 ReadOnly (When .f. do legado):" + CHR(13) + CHR(10) + ;
        "   NFs=" + TRANSFORM(loc_oP2.txt_4c_NFs.ReadOnly) + ;
        " EspecieNfs=" + TRANSFORM(loc_oP2.txt_4c_EspecieNfs.ReadOnly) + ;
        " Emps=" + TRANSFORM(loc_oP2.txt_4c_Emps.ReadOnly) + ;
        " Contas=" + TRANSFORM(loc_oP2.txt_4c_Contas.ReadOnly) + ;
        " DContEms=" + TRANSFORM(loc_oP2.txt_4c_DContEms.ReadOnly) + ;
        " DContas=" + TRANSFORM(loc_oP2.txt_4c_DContas.ReadOnly) + CHR(13) + CHR(10) + ;
        "   ContEms (SEM When no SCX, deve ficar .F.)=" + ;
        TRANSFORM(loc_oP2.txt_4c_ContEms.ReadOnly) + CHR(13) + CHR(10), OUT, 1)

    *-- ====================================== 4) AlternarPagina + filtros
    loc_oForm.AlternarPagina(2)
    STRTOFILE("4) AlternarPagina(2) -> ActivePage=" + TRANSFORM(loc_oForm.pgf_4c_Paginas.ActivePage) + ;
        " Modo=[" + loc_oForm.this_cModoAtual + "]" + ;
        " DtEmiI.ReadOnly=" + TRANSFORM(loc_oP1.txt_4c_DtEmiI.ReadOnly) + CHR(13) + CHR(10), OUT, 1)

    loc_oForm.AlternarPagina(1)
    STRTOFILE("   AlternarPagina(1) -> ActivePage=" + TRANSFORM(loc_oForm.pgf_4c_Paginas.ActivePage) + ;
        " Modo=[" + loc_oForm.this_cModoAtual + "]" + ;
        " DtEmiI.ReadOnly=" + TRANSFORM(loc_oP1.txt_4c_DtEmiI.ReadOnly) + CHR(13) + CHR(10), OUT, 1)

    *-- ===================== 5) LimparCampos via CarregarLista (cursor vazio)
    *-- LimparCampos eh PROTECTED (herdado de FormBase - regra #51), entao a
    *-- prova vai pelo caminho PUBLICO que o usa: CarregarLista com o cursor
    *-- de resultado VAZIO limpa o detalhe e desabilita as acoes.
    loc_oP2.txt_4c_DContEms.Value = "LIXO"
    loc_oP2.txt_4c_Hist2s.Value   = "LIXO"
    loc_oP2.txt_4c_ValOcurs.Value = 123

    IF USED(loc_oBO.this_cCursorDados)
        USE IN (loc_oBO.this_cCursorDados)
    ENDIF
    CREATE CURSOR (loc_oBO.this_cCursorDados) (Nopers N(10,0), SInis N(1,0))

    STRTOFILE("5) CarregarLista com cursor VAZIO -> retorno=" + ;
        TRANSFORM(loc_oForm.CarregarLista()) + ;
        " DContEms=[" + ALLTRIM(loc_oP2.txt_4c_DContEms.Value) + "]" + ;
        " Hist2s=[" + ALLTRIM(loc_oP2.txt_4c_Hist2s.Value) + "]" + ;
        " ValOcurs=" + TRANSFORM(loc_oP2.txt_4c_ValOcurs.Value) + CHR(13) + CHR(10), OUT, 1)

    *-- ================================= 6) AjustarBotoesPorModo sem linha
    loc_oP2.cmd_4c_BtnMovimento.Enabled = .T.
    loc_oP2.cmd_4c_BtnRecebe.Enabled    = .T.
    loc_oForm.AjustarBotoesPorModo()
    STRTOFILE("6) AjustarBotoesPorModo sem linha corrente -> " + ;
        "Movimento=" + TRANSFORM(loc_oP2.cmd_4c_BtnMovimento.Enabled) + ;
        " Recebe=" + TRANSFORM(loc_oP2.cmd_4c_BtnRecebe.Enabled) + ;
        " FollowUpC=" + TRANSFORM(loc_oP2.cmd_4c_BtnFollowUpC.Enabled) + ;
        " Imprimir=" + TRANSFORM(loc_oP2.cmd_4c_BtnImprimir.Enabled) + CHR(13) + CHR(10), OUT, 1)

    *-- ============ 7) FormParaBO / BOParaForm pelo caminho PUBLICO real
    *-- Os dois sao PROTECTED (herdados de FormBase - regra #51). O caminho
    *-- publico que os exercita eh GetFiltrosLostFocus -> RestaurarFiltros,
    *-- que faz FormParaBO (captura a tela) -> sobrescreve as 27 posicoes do
    *-- blob salvo -> BOParaForm (repinta a tela).
    loc_oForm.AlternarPagina(1)

    *-- Estado inicial na tela: sera CAPTURADO por FormParaBO e tem de
    *-- sobreviver ao round-trip no que NAO esta no blob (ex.: a descricao).
    loc_oP1.txt_4c_DMoes.Value   = "DESCRICAO-PRESERVADA"
    loc_oP1.txt_4c_Titulos.Value = "SERA-SOBRESCRITO"
    loc_oP1.opt_4c_Pagos.Value   = 1
    loc_oP1.opt_4c_CotEm.Value   = 1
    loc_oP1.opt_4c_FilGrd2.Value = 1
    loc_oP1.chk_4c_Brancos.Value = 0
    loc_oP1.txt_4c_Saldo.Value   = 0

    *-- Blob com as 27 posicoes (CHR(9) como separador), na ordem de
    *-- SerializarFiltros: 8 datas, 4 textos, 3 moedas, saldo, publicidade,
    *-- empresa, 2 flags, 7 indices de OptionGroup.
    loc_cL = DTOC(DATE(2026, 1, 15)) + CHR(9) + DTOC(DATE(2026, 3, 31)) + CHR(9) + ;
             CHR(9) + CHR(9) + CHR(9) + CHR(9) + CHR(9) + CHR(9) + ;
             "TIT123" + CHR(9) + CHR(9) + CHR(9) + CHR(9) + ;
             "RS" + CHR(9) + CHR(9) + CHR(9) + ;
             "1234.56" + CHR(9) + CHR(9) + "001" + CHR(9) + ;
             "1" + CHR(9) + "0" + CHR(9) + ;
             "3" + CHR(9) + "1" + CHR(9) + "4" + CHR(9) + "1" + CHR(9) + ;
             "1" + CHR(9) + "1" + CHR(9) + "2"

    IF USED(loc_oBO.this_cCursorFiltros)
        SELECT (loc_oBO.this_cCursorFiltros)
        ZAP
        APPEND BLANK
        REPLACE Descrs WITH "FILTRO TESTE", Mxmls WITH loc_cL
        GO TOP
    ENDIF

    loc_oP1.txt_4c_Filtros.Value = "FILTRO TESTE"
    loc_oForm.GetFiltrosLostFocus()

    STRTOFILE("7) GetFiltrosLostFocus -> RestaurarFiltros (FormParaBO + BOParaForm)" + CHR(13) + CHR(10) + ;
        "   BO : dDtEmiI=" + TRANSFORM(loc_oBO.this_dDtEmiI) + ;
        " dDtEmiF=" + TRANSFORM(loc_oBO.this_dDtEmiF) + ;
        " cTitulos=[" + ALLTRIM(loc_oBO.this_cTitulos) + "]" + ;
        " cCMoes=[" + ALLTRIM(loc_oBO.this_cCMoes) + "]" + ;
        " nSaldo=" + TRANSFORM(loc_oBO.this_nSaldo) + ;
        " cEmpresa=[" + ALLTRIM(loc_oBO.this_cEmpresa) + "]" + CHR(13) + CHR(10) + ;
        "        lBrancos=" + TRANSFORM(loc_oBO.this_lBrancos) + ;
        " nPagos=" + TRANSFORM(loc_oBO.this_nPagos) + ;
        " nCotEm=" + TRANSFORM(loc_oBO.this_nCotEm) + ;
        " nFilGrd2=" + TRANSFORM(loc_oBO.this_nFilGrd2) + CHR(13) + CHR(10) + ;
        "   TELA: DtEmiI=" + TRANSFORM(loc_oP1.txt_4c_DtEmiI.Value) + ;
        " DtEmiF=" + TRANSFORM(loc_oP1.txt_4c_DtEmiF.Value) + ;
        " Titulos=[" + ALLTRIM(loc_oP1.txt_4c_Titulos.Value) + "]" + ;
        " CMoes=[" + ALLTRIM(loc_oP1.txt_4c_CMoes.Value) + "]" + ;
        " Saldo=" + TRANSFORM(loc_oP1.txt_4c_Saldo.Value) + ;
        " Empresa=[" + ALLTRIM(loc_oP1.txt_4c_Empresa.Value) + "]" + CHR(13) + CHR(10) + ;
        "        chkBrancos=" + TRANSFORM(loc_oP1.chk_4c_Brancos.Value) + ;
        " optPagos=" + TRANSFORM(loc_oP1.opt_4c_Pagos.Value) + ;
        " optCotEm=" + TRANSFORM(loc_oP1.opt_4c_CotEm.Value) + ;
        " optFilGrd2=" + TRANSFORM(loc_oP1.opt_4c_FilGrd2.Value) + CHR(13) + CHR(10) + ;
        "        DMoes (fora do blob, deve ser PRESERVADA)=[" + ;
        ALLTRIM(loc_oP1.txt_4c_DMoes.Value) + "]" + CHR(13) + CHR(10) + ;
        "        DMoes.ReadOnly (When Empty(CMoes), CMoes preenchido)=" + ;
        TRANSFORM(loc_oP1.txt_4c_DMoes.ReadOnly) + CHR(13) + CHR(10), OUT, 1)

    *-- ======================== 8) CarregarLista sem cursor de resultado
    IF USED(loc_oBO.this_cCursorDados)
        USE IN (loc_oBO.this_cCursorDados)
    ENDIF
    STRTOFILE("8) CarregarLista sem cursor_4c_Dados -> retorno=" + ;
        TRANSFORM(loc_oForm.CarregarLista()) + CHR(13) + CHR(10), OUT, 1)

    *-- ====================================== 9) BtnCancelarClick na Page1
    loc_oForm.AlternarPagina(1)
    loc_oForm.BtnCancelarClick()
    STRTOFILE("9) BtnCancelarClick na Page1 -> VARTYPE do handle=" + ;
        VARTYPE(loc_oForm) + CHR(13) + CHR(10), OUT, 1)

    STRTOFILE("=== FIM SEM EXCECAO ===" + CHR(13) + CHR(10), OUT, 1)

CATCH TO loc_oE
    STRTOFILE("EXCECAO: " + loc_oE.Message + ;
        " LN=" + TRANSFORM(loc_oE.LineNo) + ;
        " PROC=" + loc_oE.Procedure + CHR(13) + CHR(10), OUT, 1)
ENDTRY

IF FILE(gc_4c_ArquivoErroTeste)
    STRTOFILE("ERROS REGISTRADOS NO HARNESS:" + CHR(13) + CHR(10) + ;
        FILETOSTR(gc_4c_ArquivoErroTeste) + CHR(13) + CHR(10), OUT, 1)
ENDIF

QUIT

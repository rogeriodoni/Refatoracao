*==============================================================================
* FormCliente.prg
* Form Cadastro de Cliente (OPERACIONAL - wrapper clsconta / ClassResp.vcx)
* Migrado de SIGCDCLI.SCX
*
* Pilares:
*   UX   -> layout PIXEL-PERFECT identico ao legado (852x600)
*   BD   -> SIGCDCLI via clsconta.mGravaDados/mValidaObj
*   CODE -> arquitetura em camadas (FormBase / ClienteBO)
*
* Parametros Init: pCpf, pGrupo, pCep, pVal, pCli, pcTpBloqCar, pcMudaCpfCgc
* Retorno (Unload): RetCodCliente (IClis ou CPF/CNPJ gravado)
*==============================================================================

DEFINE CLASS FormCliente AS FormBase

    *-- Propriedades visuais (aumentado para 1000x600 p/ acomodar layout
    *-- Lista+Dados como no legado SIGCDCTA. Wrapper clsconta interno usa
    *-- 768 de largura fixa; sobra 232 na direita para botoes CRUD topo.)
    Height       = 600
    Width        = 1000
    AutoCenter   = .T.
    Caption      = "Cadastro de Cliente"
    ShowWindow = 1
    ControlBox   = .F.
    MaxButton    = .F.
    MinButton    = .F.
    KeyPreview   = .T.
    TitleBar     = 0
    WindowType   = 1
    DataSession  = 2
    ClipControls = .F.
    Themes       = .F.
    BorderStyle  = 2

    *-- Propriedades customizadas (conforme RESERVED3/ClassInfo do original)
    this_cMensagemErro = ""
    mudavend           = .F.
    plaltcd            = .F.
    RetCodCliente      = " "
    pcEscolha          = ""

    *-- Integracao com BusinessObject (cliBO)
    this_oBusinessObject = .NULL.
    this_cModoAtual      = ""

    *-- Properties requeridas pelos VCXs legado Fortyus (Erro122).
    *-- ClassResp.vcx/Framework.vcx referenciam ThisForm.poDataMgr em 186 pontos;
    *-- sem essa property, AddObject("clsconta") falha em GET_GRUPOVEN.Init
    *-- ("Error instantiating the object GET_GRUPOVEN"). Instanciacao ocorre
    *-- em InicializarForm antes de ConfigurarContaCls.
    poDataMgr     = .NULL.
    Inicio        = .T.       && flag legado (uso em wrapper Refresh)
    ValidaIE      = .F.       && flag DLL de valida??o de Insc. Estadual (Sintegra)
    plAltCpf      = .F.       && permite alterar CPF/CNPJ apos INSERIR
    CodClis       = ""        && codigo do cliente corrente (usado pelo wrapper)
    tipopais      = .F.       && flag pais estrangeiro

    *-- Parametros recebidos em Init (armazenados para uso em InicializarForm)
    this_cCpf         = ""
    this_cGrupo       = ""
    this_nCep         = 0
    this_lVal         = .F.
    this_cCli         = ""
    this_cTpBloqCar   = "0"
    this_cMudaCpfCgc  = "0"

    *============================================================
    PROCEDURE Init
    *============================================================
        LPARAMETERS par_cCpf, par_cGrupo, par_nCep, par_lVal, par_cCli, par_cTpBloqCar, par_cMudaCpfCgc

        *-- Normalizar e armazenar parametros antes de DODEFAULT (que chama InicializarForm)
        THIS.this_cCpf        = IIF(TYPE("par_cCpf")        = "C", PADR(par_cCpf, 20),        SPACE(20))
        THIS.this_cGrupo      = IIF(TYPE("par_cGrupo")      = "C", PADR(par_cGrupo, 10),      SPACE(10))
        THIS.this_nCep        = IIF(TYPE("par_nCep")        = "N", par_nCep,                  0)
        THIS.this_lVal        = IIF(TYPE("par_lVal")        = "L", par_lVal,                  .F.)
        THIS.this_cCli        = IIF(TYPE("par_cCli")        = "C", PADR(par_cCli, 10),        SPACE(10))
        THIS.this_cTpBloqCar  = IIF(TYPE("par_cTpBloqCar")  = "C", par_cTpBloqCar,            "0")
        THIS.this_cMudaCpfCgc = IIF(TYPE("par_cMudaCpfCgc") = "C", par_cMudaCpfCgc,           "0")

        RETURN DODEFAULT()
    ENDPROC

    *============================================================
    PROTECTED PROCEDURE InicializarForm
    *============================================================
        LOCAL loc_lSucesso, loc_oErro, loc_cCpf, loc_cGrupo, loc_lRetLeDados
        loc_lSucesso = .F.

        TRY
            *-- Instanciar Business Object (cliBO)
            THIS.this_oBusinessObject = CREATEOBJECT("cliBO")

            *-- Instanciar poDataMgr (fSqlConector legado Fortyus, sigclcnx.PRG).
            *-- Passa gnConnHandle NUMERICO -> Init pula caminho goSistema.ObjectConn.
            *-- pOpnRelease=.T. logo apos -> Release() nao chama SQLDisConnect na
            *-- conexao global (senao fecha a conexao inteira ao fechar o form).
            IF ISNULL(THIS.poDataMgr) OR VARTYPE(THIS.poDataMgr) <> "O"
                THIS.poDataMgr = CREATEOBJECT("fSqlConector", gnConnHandle)
                IF !ISNULL(THIS.poDataMgr) AND VARTYPE(THIS.poDataMgr) = "O"
                    THIS.poDataMgr.pOpnRelease = .T.
                ENDIF
            ENDIF

            *-- Pre-criar cursores stub que os controles do clsconta usam como
            *-- ControlSource (crSigCdCli.grupovens, crSigCdCeb.bancos, etc.).
            *-- Sem esses cursores existirem no momento do AddObject("clsconta"),
            *-- VFP9 falha ao validar ControlSource -> "Error instantiating GET_GRUPOVEN".
            *-- O mIniConta() do wrapper substitui pelos dados reais depois.
            THIS.CriarCursoresControlSource()

            *-- Fundo de tela (imagem legado Fortyus em Framework\imagens\)
            THIS.Picture = gc_4c_CaminhoFramework + "imagens\new_background.jpg"

            *-- Normalizar CPF (remover pontuacao para verificacao)
            loc_cCpf = STRTRAN(STRTRAN(STRTRAN(ALLTRIM(THIS.this_cCpf), ".", ""), "-", ""), "/", "")

            *-- Determinar grupo padrao se nao informado
            loc_cGrupo = ALLTRIM(THIS.this_cGrupo)
            IF EMPTY(loc_cGrupo) AND USED("crSigCdPam") AND RECCOUNT("crSigCdPam") > 0
                SELECT crSigCdPam
                LOCATE
                IF !EOF("crSigCdPam")
                    loc_cGrupo = PADR(crSigCdPam.GrPadClis, 10)
                    THIS.this_cGrupo = loc_cGrupo
                ENDIF
            ENDIF

            *-- Verificar grupo configurado
            IF EMPTY(ALLTRIM(THIS.this_cGrupo))
                MsgAviso("Grupo Padr" + CHR(227) + "o N" + CHR(227) + "o Configurado.")
                loc_lSucesso = .T.
            ELSE
                *-- Definir plAltCd (usado por wrapper depois de mIniConta).
                *-- IMPORTANTE: pcEscolha NAO pode ser setado aqui — miniconta
                *-- resetaria para '' via `With ThisForm / .pcEscolha = ''`.
                *-- Legado SIGCDCLI seta pcEscolha APOS mIniConta (tasks/task372).
                THIS.mudavend = .T.
                IF EMPTY(ALLTRIM(THIS.this_cCli))
                    THIS.this_cModoAtual = "INCLUIR"
                    THIS.plaltcd         = .F.
                ELSE
                    THIS.plaltcd         = .T.
                    THIS.this_cModoAtual = "ALTERAR"
                ENDIF

                *-- Estrutura 2-estados via containers separados (Lista / Dados).
                *-- Preserva as 77 refs a THIS.cnt_4c_Sombra/cnt_4c_Conta/cmg_4c_Sair
                *-- (Dados) e adiciona container Lista lado a lado. Toggle Visible.
                *-- Phase 2 populara ViewLista (grid+6 botoes+filtro).
                *-- Phase 3 implementara IrParaLista()/IrParaDados() state machine.
                THIS.ConfigurarViewLista()

                *-- Popular Dados: cabecalho + clsconta + Ok/Cancelar (comportamento atual)
                THIS.ConfigurarCabecalho()
                THIS.ConfigurarContaCls()
                THIS.ConfigurarBotoesSair()
                THIS.TornarControlesVisiveis()

                *-- Inicializar clsconta (log diagnostico Erro126/127)
                LOCAL loc_nHDiag, loc_oDiagErr, loc_cDiagPath
                loc_cDiagPath = ADDBS(gc_4c_CaminhoBase) + "FormCliente_DiagInit.log"
                loc_nHDiag = FCREATE(loc_cDiagPath)
                IF loc_nHDiag > 0
                    FPUTS(loc_nHDiag, "=== " + TTOC(DATETIME()) + " ===")
                    FPUTS(loc_nHDiag, "pcEscolha=" + THIS.pcEscolha + " grupo=[" + ALLTRIM(THIS.this_cGrupo) + "] cli=[" + ALLTRIM(THIS.this_cCli) + "]")
                ENDIF

                TRY
                    THIS.cnt_4c_Conta.mIniConta()
                    IF loc_nHDiag > 0
                        FPUTS(loc_nHDiag, "mIniConta: OK")
                        FPUTS(loc_nHDiag, "  Used(crSigCdCli)=" + TRANSFORM(USED("crSigCdCli")) + " reccount=" + TRANSFORM(IIF(USED("crSigCdCli"), RECCOUNT("crSigCdCli"), -1)))
                        FPUTS(loc_nHDiag, "  Used(crSigCdGcr)=" + TRANSFORM(USED("crSigCdGcr")) + " reccount=" + TRANSFORM(IIF(USED("crSigCdGcr"), RECCOUNT("crSigCdGcr"), -1)))
                        FPUTS(loc_nHDiag, "  Used(crSigCdPam)=" + TRANSFORM(USED("crSigCdPam")) + " reccount=" + TRANSFORM(IIF(USED("crSigCdPam"), RECCOUNT("crSigCdPam"), -1)))
                        FPUTS(loc_nHDiag, "  Used(crSigCdPac)=" + TRANSFORM(USED("crSigCdPac")) + " reccount=" + TRANSFORM(IIF(USED("crSigCdPac"), RECCOUNT("crSigCdPac"), -1)))
                        FPUTS(loc_nHDiag, "  Used(crSigCdEmp)=" + TRANSFORM(USED("crSigCdEmp")) + " reccount=" + TRANSFORM(IIF(USED("crSigCdEmp"), RECCOUNT("crSigCdEmp"), -1)))

                        *-- Diagnostico: pfSqlTabela + tentativa manual de Insert
                        IF !ISNULL(THIS.poDataMgr) AND VARTYPE(THIS.poDataMgr) = "O"
                            LOCAL loc_nTab, loc_k
                            loc_nTab = ALEN(THIS.poDataMgr.pfSqlTabela, 1)
                            FPUTS(loc_nHDiag, "  pfSqlTabela.count=" + TRANSFORM(loc_nTab))
                            FOR loc_k = 1 TO loc_nTab
                                IF !ISNULL(THIS.poDataMgr.pfSqlTabela(loc_k, 1))
                                    FPUTS(loc_nHDiag, "    [" + TRANSFORM(loc_k) + "] cursor=" + THIS.poDataMgr.pfSqlTabela(loc_k, 1).pcNomeCursor)
                                ELSE
                                    FPUTS(loc_nHDiag, "    [" + TRANSFORM(loc_k) + "] NULL")
                                ENDIF
                            ENDFOR
                        ENDIF

                        *-- Teste manual: Insert Into crSigCdCli via Scatter Blank
                        *-- NAO limpar depois — se funcionar, mLeDados NewReg fara Zap+Insert
                        *-- de qualquer forma (o registro extra e transparente).
                        LOCAL loc_oTestErr
                        TRY
                            SELECT crSigCdCli
                            SCATTER MEMVAR BLANK
                            INSERT INTO crSigCdCli FROM MEMVAR
                            FPUTS(loc_nHDiag, "  Manual Insert crSigCdCli: OK reccount=" + TRANSFORM(RECCOUNT("crSigCdCli")))
                        CATCH TO loc_oTestErr
                            FPUTS(loc_nHDiag, "  Manual Insert crSigCdCli: EXCEPTION " + loc_oTestErr.Message + " linha=" + TRANSFORM(loc_oTestErr.LineNo))
                        ENDTRY
                    ENDIF
                CATCH TO loc_oDiagErr
                    IF loc_nHDiag > 0
                        FPUTS(loc_nHDiag, "mIniConta: EXCEPTION " + loc_oDiagErr.Message + " linha=" + TRANSFORM(loc_oDiagErr.LineNo) + " proc=" + loc_oDiagErr.Procedure)
                    ENDIF
                ENDTRY

                THIS.cnt_4c_Conta.pgframeDados.Top = 0
                THIS.cnt_4c_Conta.cmdgPessoal.cmdPessoal.ToolTipText = "F5 - Dados Pessoais/Comerciais"

                *-- Ajustar navegacao inicial do PageFrame interno (pgframeDados)
                THIS.ConfigurarPaginaLista()
                THIS.ConfigurarPaginaDados()
                THIS.ConfigurarPaginaDados2()

                *-- Determinar estado inicial: LISTA (default) ou DADOS (se cli pre-selecionado).
                LOCAL loc_lIniciarEmDados
                loc_lIniciarEmDados = !EMPTY(ALLTRIM(THIS.this_cCli))
                IF loc_lIniciarEmDados
                    THIS.pcEscolha = "ALTERAR"
                ELSE
                    THIS.pcEscolha = "INSERIR"
                ENDIF
                IF loc_nHDiag > 0
                    FPUTS(loc_nHDiag, "pcEscolha=" + THIS.pcEscolha + " iniciarEmDados=" + TRANSFORM(loc_lIniciarEmDados))
                ENDIF

                *-- mLeDados apenas se indo para DADOS. Se LISTA, cursores stub
                *-- ja bastam (Requery real acontece no RefreshGridClientes).
                loc_lRetLeDados = .T.  && default sucesso se pulando mLeDados
                IF loc_lIniciarEmDados
                    TRY
                        loc_lRetLeDados = THIS.ChamarMLeDadosSeguro(THIS.this_cGrupo, THIS.this_cCli, "1", ;
                            THIS.this_cTpBloqCar, THIS.this_cMudaCpfCgc)
                        IF loc_nHDiag > 0
                            FPUTS(loc_nHDiag, "mLeDados: retornou=" + TRANSFORM(loc_lRetLeDados))
                        ENDIF
                    CATCH TO loc_oDiagErr
                        loc_lRetLeDados = USED("crSigCdCli") AND RECCOUNT("crSigCdCli") > 0
                        IF loc_nHDiag > 0
                            FPUTS(loc_nHDiag, "mLeDados: EXCEPTION " + loc_oDiagErr.Message + " tratado nao-fatal")
                        ENDIF
                    ENDTRY

                    IF loc_lRetLeDados
                        THIS.cnt_4c_Conta.cmdgftec.Visible = .F.
                        IF THIS.pcEscolha = "INSERIR" AND !EMPTY(loc_cCpf)
                            WITH THIS.cnt_4c_Conta.pgframeDados.pgframeDados1
                                .OpcaoCPFCGC.Value = IIF(LEN(loc_cCpf) <> 14, 1, 2)
                                .GetCPFCGC.Value   = THIS.this_cCpf
                            ENDWITH
                            THIS.cnt_4c_Conta.mAtuGetCpf()
                        ENDIF
                        THIS.cnt_4c_Conta.Refresh()
                    ELSE
                        MsgErro("Erro Na Leitura dos Dados", "Erro")
                    ENDIF
                ENDIF

                IF loc_nHDiag > 0
                    FPUTS(loc_nHDiag, "=== FIM ===")
                    FCLOSE(loc_nHDiag)
                ENDIF

                *-- Estado inicial: aplica visibility conforme decidido acima.
                IF loc_lIniciarEmDados AND loc_lRetLeDados
                    THIS.IrParaDados()
                ELSE
                    THIS.IrParaLista()
                ENDIF
                loc_lSucesso = .T.
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, ;
                "Erro em InicializarForm")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *============================================================
    PROTECTED PROCEDURE CriarCursoresControlSource
    *============================================================
    *-- Cria cursores stub vazios (WHERE 1=0) para os aliases usados como
    *-- ControlSource pelos controles do clsconta legado. VFP9 valida
    *-- ControlSource no instante do AddObject; se o alias nao existir,
    *-- lanca "Error instantiating the object <nome>". Depois o mIniConta()
    *-- via poDataMgr.CursorQuery repopula com dados reais.
    *-- Tabelas requeridas (dump ClassResp.VCX filtrado por Parent LIKE 'clsconta%'):
    *--   SigCdCli, SigCdCe, SigCdCeb, SigClCrc, SigClInf
    *============================================================
        LOCAL loc_nResult, loc_oErro, loc_aTabelas, loc_i, loc_cItem, loc_cTabela, ;
              loc_cCursor, loc_nH, loc_cLog, loc_cLogPath, loc_nErr, loc_aErr
        loc_aTabelas = "SigCdCli,crSigCdCli;" + ;
                       "SigCdCe,crSigCdCe;" + ;
                       "SigCdCeb,crSigCdCeb;" + ;
                       "SigClCrc,crSigClCrc;" + ;
                       "SigClInf,crSigClInf"

        *-- Log de diagnostico Erro122 (remover apos fix confirmado)
        loc_cLogPath = ADDBS(gc_4c_CaminhoBase) + "FormCliente_DiagCursores.log"
        loc_nH = FCREATE(loc_cLogPath)
        IF loc_nH > 0
            FPUTS(loc_nH, "=== CriarCursoresControlSource " + TTOC(DATETIME()) + " ===")
            FPUTS(loc_nH, "gnConnHandle=" + TRANSFORM(IIF(TYPE("gnConnHandle")="N", gnConnHandle, -999)))
        ENDIF

        FOR loc_i = 1 TO GETWORDCOUNT(loc_aTabelas, ";")
            loc_cItem = GETWORDNUM(loc_aTabelas, loc_i, ";")
            loc_cTabela = GETWORDNUM(loc_cItem, 1, ",")
            loc_cCursor = GETWORDNUM(loc_cItem, 2, ",")

            IF USED(loc_cCursor)
                USE IN (loc_cCursor)
            ENDIF

            TRY
                IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
                    CREATE CURSOR (loc_cCursor) (dummy C(1))
                    IF loc_nH > 0
                        FPUTS(loc_nH, loc_cCursor + ": FALLBACK dummy (sem conexao)")
                    ENDIF
                ELSE
                    *-- Passo 1: SQLEXEC para tabela temp (schema completo, mas read-only)
                    LOCAL loc_cTemp
                    loc_cTemp = "__stub_" + SYS(2015)
                    loc_nResult = SQLEXEC(gnConnHandle, ;
                        "SELECT * FROM " + loc_cTabela + " WHERE 1=0", ;
                        loc_cTemp)
                    IF loc_nResult < 0
                        DIMENSION loc_aErr[1]
                        AERROR(loc_aErr)
                        IF loc_nH > 0
                            FPUTS(loc_nH, loc_cCursor + ": SQLEXEC FALHOU (result=" + TRANSFORM(loc_nResult) + ") ERR=" + TRANSFORM(loc_aErr[2]))
                        ENDIF
                    ENDIF
                    IF loc_nResult < 0 OR !USED(loc_cTemp)
                        CREATE CURSOR (loc_cCursor) (dummy C(1))
                        IF loc_nH > 0
                            FPUTS(loc_nH, loc_cCursor + ": FALLBACK dummy pos-falha")
                        ENDIF
                    ELSE
                        *-- Passo 2: SELECT INTO CURSOR READWRITE para cursor local writable
                        *-- Sem isso o wrapper NewReg('crSigCdCli',.T.) faz Scatter+Insert
                        *-- em cursor SQL read-only e silenciosamente falha (reccount=0).
                        SELECT * FROM (loc_cTemp) WHERE .F. ;
                            INTO CURSOR (loc_cCursor) READWRITE NOFILTER
                        USE IN (loc_cTemp)
                        IF loc_nH > 0
                            LOCAL loc_j, loc_cFields
                            loc_cFields = ""
                            FOR loc_j = 1 TO FCOUNT(loc_cCursor)
                                loc_cFields = loc_cFields + FIELD(loc_j, loc_cCursor) + ","
                            ENDFOR
                            FPUTS(loc_nH, loc_cCursor + ": OK RW (fields=" + TRANSFORM(FCOUNT(loc_cCursor)) + " buffering=" + TRANSFORM(CURSORGETPROP("Buffering", loc_cCursor)) + ")")
                            FPUTS(loc_nH, "  campos: " + LEFT(loc_cFields, 500))
                        ENDIF
                    ENDIF
                ENDIF
            CATCH TO loc_oErro
                IF loc_nH > 0
                    FPUTS(loc_nH, loc_cCursor + ": EXCEPTION " + loc_oErro.Message + " (linha " + TRANSFORM(loc_oErro.LineNo) + ")")
                ENDIF
                IF !USED(loc_cCursor)
                    CREATE CURSOR (loc_cCursor) (dummy C(1))
                ENDIF
            ENDTRY
        ENDFOR

        IF loc_nH > 0
            FPUTS(loc_nH, "=== FIM ===")
            FCLOSE(loc_nH)
        ENDIF
    ENDPROC

    *============================================================
    PROTECTED PROCEDURE ConfigurarViewLista
    *============================================================
    *-- Container `cnt_4c_ViewLista` ocupa toda a area do form. Contem:
    *--   1. Cabecalho cinza com titulo "Cadastro de Clientes"
    *--   2. 6 botoes CRUD topo-direita: Incluir/Visualizar/Alterar/Excluir/Buscar/Encerrar
    *--   3. Filtro: Grupo de Contas (cod+desc) + Alterados entre (data ini/fim)
    *--   4. Grid bound a crSigCdCli com colunas Codigo/Nome/CPF-CNPJ/Sit/Ult.Compra/Alterado/Usuar/DDD/Tel
    *-- Baseado em contas_grid.png (legado SIGCDCTA lista state).
    *============================================================
        LOCAL loc_oCnt
        THIS.AddObject("cnt_4c_ViewLista", "Container")
        loc_oCnt = THIS.cnt_4c_ViewLista
        WITH loc_oCnt
            .Top         = 0
            .Left        = 0
            .Width       = THIS.Width
            .Height      = THIS.Height
            .BackColor   = RGB(240, 240, 240)
            .BorderWidth = 0
            .Visible     = .F.
        ENDWITH

        THIS.ConfigurarListaCabecalho(loc_oCnt)
        THIS.ConfigurarListaBotoesTopo(loc_oCnt)
        THIS.ConfigurarListaFiltros(loc_oCnt)
        THIS.ConfigurarListaGrid(loc_oCnt)
    ENDPROC

    *============================================================
    PROTECTED PROCEDURE ConfigurarListaCabecalho
    *============================================================
        LPARAMETERS par_oPai
        par_oPai.AddObject("cnt_4c_ListaCab", "Container")
        WITH par_oPai.cnt_4c_ListaCab
            .Top         = 0
            .Left        = 0
            .Width       = THIS.Width - 400
            .Height      = 80
            .BackColor   = RGB(100, 100, 100)
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH
        par_oPai.cnt_4c_ListaCab.AddObject("lbl_4c_ListaSombra", "Label")
        WITH par_oPai.cnt_4c_ListaCab.lbl_4c_ListaSombra
            .FontBold      = .T.
            .FontName      = "Tahoma"
            .FontSize      = 18
            .WordWrap      = .T.
            .Alignment     = 0
            .BackStyle     = 0
            .AutoSize      = .F.
            .Caption       = "Cadastro de Clientes"
            .Height        = 40
            .Left          = 10
            .Top           = 18
            .Width         = 569
            .ForeColor     = RGB(0, 0, 0)
            .Visible       = .T.
        ENDWITH
        par_oPai.cnt_4c_ListaCab.AddObject("lbl_4c_ListaTitulo", "Label")
        WITH par_oPai.cnt_4c_ListaCab.lbl_4c_ListaTitulo
            .FontBold      = .T.
            .FontName      = "Tahoma"
            .FontSize      = 18
            .WordWrap      = .T.
            .Alignment     = 0
            .BackStyle     = 0
            .AutoSize      = .F.
            .Caption       = "Cadastro de Clientes"
            .Height        = 46
            .Left          = 10
            .Top           = 17
            .Width         = 569
            .ForeColor     = RGB(255, 255, 255)
            .Visible       = .T.
        ENDWITH
    ENDPROC

    *============================================================
    PROTECTED PROCEDURE ConfigurarListaBotoesTopo
    *============================================================
    *-- 6 botoes CRUD alinhados topo-direita, mesma altura do cabecalho.
    *-- Nomes/imagens espelham contas_grid.png: Incluir/Visualizar/Alterar/Excluir/Buscar/Encerrar
    *============================================================
        LPARAMETERS par_oPai
        LOCAL loc_aBotoes, loc_i, loc_cNome, loc_cCaption, loc_cImg, loc_cHandler, loc_nLeft
        LOCAL loc_cItem

        *-- Array: nome_prop|caption|imagem|handler
        loc_aBotoes = "cmd_4c_Incluir|Incluir|cadastro_inserir_26.jpg|BtnIncluirClick;" + ;
                      "cmd_4c_Visualizar|Visualizar|cadastro_visualizar_26.jpg|BtnVisualizarClick;" + ;
                      "cmd_4c_Alterar|Alterar|cadastro_alterar_26.jpg|BtnAlterarClick;" + ;
                      "cmd_4c_Excluir|Excluir|cadastro_excluir_26.jpg|BtnExcluirClick;" + ;
                      "cmd_4c_Buscar|Buscar|cadastro_procurar_26.jpg|BtnBuscarClick;" + ;
                      "cmd_4c_EncerrarLst|Encerrar|cadastro_sair_60.jpg|BtnEncerrarClick"

        par_oPai.AddObject("cnt_4c_ListaBotoes", "Container")
        WITH par_oPai.cnt_4c_ListaBotoes
            .Top         = 0
            .Left        = THIS.Width - 400
            .Width       = 400
            .Height      = 80
            .BackStyle   = 0
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH

        loc_nLeft = 5
        FOR loc_i = 1 TO 6
            loc_cItem = GETWORDNUM(loc_aBotoes, loc_i, ";")
            loc_cNome = GETWORDNUM(loc_cItem, 1, "|")
            loc_cCaption = GETWORDNUM(loc_cItem, 2, "|")
            loc_cImg = GETWORDNUM(loc_cItem, 3, "|")
            loc_cHandler = GETWORDNUM(loc_cItem, 4, "|")

            par_oPai.cnt_4c_ListaBotoes.AddObject(loc_cNome, "CommandButton")
            WITH par_oPai.cnt_4c_ListaBotoes.&loc_cNome.
                .Caption         = loc_cCaption
                .Picture         = gc_4c_CaminhoIcones + loc_cImg
                .PicturePosition = 13
                .Top             = 5
                .Left            = loc_nLeft
                .Width           = 60
                .Height          = 70
                .FontName        = "Tahoma"
                .FontBold        = .T.
                .FontItalic      = .T.
                .FontSize        = 8
                .ForeColor       = RGB(90, 90, 90)
                .BackColor       = RGB(255, 255, 255)
                .Themes          = .F.
                .SpecialEffect   = 0
                .MousePointer    = 15
                .WordWrap        = .T.
                .AutoSize        = .F.
                .Visible         = .T.
            ENDWITH
            BINDEVENT(par_oPai.cnt_4c_ListaBotoes.&loc_cNome., "Click", THIS, loc_cHandler)
            loc_nLeft = loc_nLeft + 65
        ENDFOR
    ENDPROC

    *============================================================
    PROTECTED PROCEDURE ConfigurarListaFiltros
    *============================================================
        LPARAMETERS par_oPai
        par_oPai.AddObject("cnt_4c_ListaFiltros", "Container")
        WITH par_oPai.cnt_4c_ListaFiltros
            .Top         = 90
            .Left        = 15
            .Width       = 620
            .Height      = 55
            .BackStyle   = 0
            .BorderWidth = 1
            .Visible     = .T.
        ENDWITH

        *-- Label Grupo de Contas
        par_oPai.cnt_4c_ListaFiltros.AddObject("lbl_4c_LblGrupo", "Label")
        WITH par_oPai.cnt_4c_ListaFiltros.lbl_4c_LblGrupo
            .Caption   = "\<Grupo de Contas"
            .Top       = 4
            .Left      = 10
            .Width     = 100
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        *-- TxtBox grupo (codigo)
        par_oPai.cnt_4c_ListaFiltros.AddObject("txt_4c_FiltroGrupo", "TextBox")
        WITH par_oPai.cnt_4c_ListaFiltros.txt_4c_FiltroGrupo
            .Top           = 22
            .Left          = 10
            .Width         = 100
            .Height        = 24
            .FontName      = "Tahoma"
            .FontSize      = 8
            .SpecialEffect = 1
            .Value         = ""
            .Visible       = .T.
        ENDWITH
        BINDEVENT(par_oPai.cnt_4c_ListaFiltros.txt_4c_FiltroGrupo, "KeyPress", THIS, "TxtFiltroGrupoKeyPress")

        *-- TxtBox descricao grupo
        par_oPai.cnt_4c_ListaFiltros.AddObject("txt_4c_FiltroGrupoDesc", "TextBox")
        WITH par_oPai.cnt_4c_ListaFiltros.txt_4c_FiltroGrupoDesc
            .Top           = 22
            .Left          = 115
            .Width         = 280
            .Height        = 24
            .FontName      = "Tahoma"
            .FontSize      = 8
            .SpecialEffect = 1
            .ReadOnly      = .F.
            .Value         = ""
            .Visible       = .T.
        ENDWITH
        BINDEVENT(par_oPai.cnt_4c_ListaFiltros.txt_4c_FiltroGrupoDesc, "KeyPress", THIS, "TxtFiltroGrupoDescKeyPress")

        *-- Label Alterados entre
        par_oPai.cnt_4c_ListaFiltros.AddObject("lbl_4c_LblAlt", "Label")
        WITH par_oPai.cnt_4c_ListaFiltros.lbl_4c_LblAlt
            .Caption   = "Alterados entre"
            .Top       = 4
            .Left      = 410
            .Width     = 100
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        *-- Data inicial
        par_oPai.cnt_4c_ListaFiltros.AddObject("txt_4c_FiltroDtIni", "TextBox")
        WITH par_oPai.cnt_4c_ListaFiltros.txt_4c_FiltroDtIni
            .Top           = 22
            .Left          = 410
            .Width         = 80
            .Height        = 24
            .FontName      = "Tahoma"
            .FontSize      = 8
            .SpecialEffect = 1
            .Value         = DATE()
            .InputMask     = "99/99/9999"
            .Visible       = .T.
        ENDWITH

        par_oPai.cnt_4c_ListaFiltros.AddObject("lbl_4c_LblAte", "Label")
        WITH par_oPai.cnt_4c_ListaFiltros.lbl_4c_LblAte
            .Caption   = "at" + CHR(233)
            .Top       = 25
            .Left      = 495
            .Width     = 18
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        par_oPai.cnt_4c_ListaFiltros.AddObject("txt_4c_FiltroDtFim", "TextBox")
        WITH par_oPai.cnt_4c_ListaFiltros.txt_4c_FiltroDtFim
            .Top           = 22
            .Left          = 515
            .Width         = 80
            .Height        = 24
            .FontName      = "Tahoma"
            .FontSize      = 8
            .SpecialEffect = 1
            .Value         = DATE()
            .InputMask     = "99/99/9999"
            .Visible       = .T.
        ENDWITH
    ENDPROC

    *============================================================
    PROTECTED PROCEDURE ConfigurarListaGrid
    *============================================================
    *-- Grid bound a crSigCdCli (populado por miniconta do wrapper).
    *-- Colunas: Codigo/Nome/CPF-CNPJ/Sit/Ult.Compra/Alterado em/Usuar.Alt/DDD/Telefone
    *============================================================
        LPARAMETERS par_oPai
        par_oPai.AddObject("grd_4c_Clientes", "Grid")
        par_oPai.grd_4c_Clientes.ColumnCount = 9
        WITH par_oPai.grd_4c_Clientes
            .Top                = 155
            .Left               = 15
            .Width              = THIS.Width - 30
            .Height             = THIS.Height - 170
            .FontName           = "Tahoma"
            .FontSize           = 8
            .ForeColor          = RGB(90, 90, 90)
            .BackColor          = RGB(255, 255, 255)
            .GridLineColor      = RGB(238, 238, 238)
            .HighlightBackColor = RGB(15, 41, 104)
            .HighlightForeColor = RGB(255, 255, 255)
            .HighlightStyle     = 2
            .DeleteMark         = .F.
            .RecordMark         = .F.
            .RowHeight          = 18
            .HeaderHeight       = 22
            .ScrollBars         = 2
            .GridLines          = 3
            .Visible            = .T.

            .Column1.Width = 80
            .Column1.Header1.Caption = "C" + CHR(243) + "digo"
            .Column1.Header1.Alignment = 2
            .Column1.ReadOnly = .T.

            .Column2.Width = 380
            .Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
            .Column2.Header1.Alignment = 2
            .Column2.ReadOnly = .T.

            .Column3.Width = 140
            .Column3.Header1.Caption = "CPF/CNPJ"
            .Column3.Header1.Alignment = 2
            .Column3.ReadOnly = .T.

            .Column4.Width = 35
            .Column4.Header1.Caption = "Sit"
            .Column4.Header1.Alignment = 2
            .Column4.ReadOnly = .T.

            .Column5.Width = 80
            .Column5.Header1.Caption = CHR(218) + "lt.Compra"
            .Column5.Header1.Alignment = 2
            .Column5.ReadOnly = .T.

            .Column6.Width = 80
            .Column6.Header1.Caption = "Alterado em"
            .Column6.Header1.Alignment = 2
            .Column6.ReadOnly = .T.

            .Column7.Width = 80
            .Column7.Header1.Caption = "Usuar.Alt"
            .Column7.Header1.Alignment = 2
            .Column7.ReadOnly = .T.

            .Column8.Width = 35
            .Column8.Header1.Caption = "DDD"
            .Column8.Header1.Alignment = 2
            .Column8.ReadOnly = .T.

            .Column9.Width = 100
            .Column9.Header1.Caption = "Telefone"
            .Column9.Header1.Alignment = 2
            .Column9.ReadOnly = .T.
        ENDWITH

        *-- BindGrid: RecordSource + ControlSources somente APOS crSigCdCli existir
        *-- Fase 3 aplicara em IrParaLista() (chamado apos mIniConta populate cursores).
    ENDPROC

    *============================================================
    PROTECTED PROCEDURE ConfigurarCabecalho
    *============================================================
        LOCAL loc_oCnt
        THIS.AddObject("cnt_4c_Sombra", "Container")
        loc_oCnt = THIS.cnt_4c_Sombra
        WITH loc_oCnt
            .Top        = -1
            .Left       = -1
            .Width      = THIS.Width
            .Height     = 80
            .BorderWidth = 0
            .BackColor  = RGB(100,100,100)
        ENDWITH
        loc_oCnt.AddObject("lbl_4c_LblSombra", "Label")
        WITH loc_oCnt.lbl_4c_LblSombra
            .FontBold      = .T.
            .FontName      = "Tahoma"
            .FontSize      = 18
            .FontUnderline = .F.
            .WordWrap      = .T.
            .Alignment     = 0
            .BackStyle     = 0
            .AutoSize      = .F.
            .Caption       = "Cadastro de Cliente"
            .Height        = 40
            .Left          = 10
            .Top           = 18
            .Width         = 769
            .ForeColor     = RGB(0,0,0)
            .Visible       = .T.
        ENDWITH
        loc_oCnt.AddObject("lbl_4c_LblTitulo", "Label")
        WITH loc_oCnt.lbl_4c_LblTitulo
            .FontBold   = .T.
            .FontName   = "Tahoma"
            .FontSize   = 18
            .WordWrap   = .T.
            .Alignment  = 0
            .BackStyle  = 0
            .AutoSize   = .F.
            .Caption    = "Cadastro de Cliente"
            .Height     = 46
            .Left       = 10
            .Top        = 17
            .Width      = 769
            .ForeColor  = RGB(255,255,255)
            .Visible    = .T.
        ENDWITH
        THIS.cnt_4c_Sombra.Visible = .T.
    ENDPROC

    *============================================================
    PROTECTED PROCEDURE ConfigurarContaCls
    *============================================================
        LOCAL loc_oErro, loc_cVcx1, loc_cVcx2, loc_cVcx3
        *-- gc_4c_CaminhoFramework aponta para C:\4c\Framework\ (config.prg:67)
        *-- Path anterior (gc_4c_CaminhoBase + "Framework\...") resolvia incorretamente
        *-- para C:\4c\projeto\app\start\Framework\ (inexistente).
        loc_cVcx1 = gc_4c_CaminhoFramework + "framework.vcx"
        loc_cVcx2 = gc_4c_CaminhoFramework + "classobj.vcx"
        loc_cVcx3 = gc_4c_CaminhoFramework + "classresp.vcx"

        TRY
            IF FILE(loc_cVcx1)
                SET CLASSLIB TO (loc_cVcx1) ADDITIVE
            ENDIF
            IF FILE(loc_cVcx2)
                SET CLASSLIB TO (loc_cVcx2) ADDITIVE
            ENDIF
            IF FILE(loc_cVcx3)
                SET CLASSLIB TO (loc_cVcx3) ADDITIVE
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao carregar biblioteca de classes: " + loc_oErro.Message, "Erro")
        ENDTRY

        THIS.AddObject("cnt_4c_Conta", "clsconta")
        WITH THIS.cnt_4c_Conta
            .Top    = 132
            .Left   = 12
            .Width  = 768
            .Height = 450
            .Visible     = .T.
        ENDWITH
        *-- cnt_4c_Conta permanece oculto ate mLeDados retornar .T. em InicializarForm
    ENDPROC

    *============================================================
    PROTECTED PROCEDURE ConfigurarBotoesSair
    *============================================================
        LOCAL loc_oCmg
        THIS.AddObject("cmg_4c_Sair", "CommandGroup")
        loc_oCmg = THIS.cmg_4c_Sair
        WITH loc_oCmg
            .ButtonCount   = 2
            .BackStyle     = 0
            .BorderStyle   = 0
            .Value         = 1
            .Height        = 85
            .Left          = THIS.Width - 165   && ancorar a direita (was 688 para Width=852)
            .SpecialEffect = 1
            .Top           = -2
            .Width         = 161
        ENDWITH
        WITH loc_oCmg.Buttons(1)
            .Top        = 5
            .Left       = 5
            .Height     = 75
            .Width      = 75
            .FontBold   = .T.
            .FontItalic = .T.
            .FontName   = "Tahoma"
            .FontSize   = 8
            .WordWrap   = .T.
            .Picture    = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
            .Caption    = "\<Salvar"
            .ForeColor  = RGB(90,90,90)
            .BackColor  = RGB(255,255,255)
            .Themes     = .F.
            .Visible    = .T.
        ENDWITH
        WITH loc_oCmg.Buttons(2)
            .Top        = 5
            .Left       = 81
            .Height     = 75
            .Width      = 75
            .FontBold   = .T.
            .FontItalic = .T.
            .FontName   = "Tahoma"
            .FontSize   = 8
            .WordWrap   = .T.
            .Picture    = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
            .Cancel     = .T.
            .Caption    = "\<Cancelar"
            .ForeColor  = RGB(90,90,90)
            .BackColor  = RGB(255,255,255)
            .Themes     = .F.
            .Visible    = .T.
        ENDWITH
        THIS.cmg_4c_Sair.Visible = .T.

        *-- Bind eventos dos botoes (metodos PUBLIC por padrao VFP9)
        BINDEVENT(THIS.cmg_4c_Sair.Buttons(1), "Click", THIS, "BtnOkClick")
        BINDEVENT(THIS.cmg_4c_Sair.Buttons(2), "Click", THIS, "BtnCancelarClick")
    ENDPROC

    *============================================================
    PROTECTED PROCEDURE TornarControlesVisiveis
    *============================================================
        LOCAL loc_i, loc_oCtrl
        FOR loc_i = 1 TO THIS.ControlCount
            loc_oCtrl = THIS.Controls[loc_i]
            *-- cnt_4c_Conta permanece oculto ate mLeDados ter sucesso
            IF UPPER(loc_oCtrl.Name) = "CNT_4C_CONTA"
                LOOP
            ENDIF
            loc_oCtrl.Visible = .T.
        ENDFOR
    ENDPROC

    *============================================================
    * Botao Ok / Gravar
    *============================================================
    PROCEDURE BtnOkClick
        LOCAL loc_nRetorno, loc_cCpfCgc

        loc_nRetorno = THIS.cnt_4c_Conta.mValidaObj()

        IF loc_nRetorno >= 0
            IF loc_nRetorno > 0
                IF THIS.cnt_4c_Conta.mGravaDados() > 0
                    loc_cCpfCgc = ALLTRIM(STRTRAN(STRTRAN(STRTRAN( ;
                        THIS.cnt_4c_Conta.pgframeDados.pgframeDados1.GetCPFCGC.Value, ;
                        ".", ""), "-", ""), "/", ""))

                    IF EMPTY(loc_cCpfCgc)
                        THIS.RetCodCliente = THIS.cnt_4c_Conta.pgframeDados.pgframeDados1.getcodigo.Value
                    ELSE
                        THIS.RetCodCliente = THIS.cnt_4c_Conta.pgframeDados.pgframeDados1.GetCPFCGC.Value
                    ENDIF
                    *-- Retorno a Lista + refresh grid (nao fechar form)
                    THIS.IrParaLista()
                ELSE
                    MsgErro("Erro na Grava" + CHR(231) + CHR(227) + "o dos Dados, " + ;
                        "Favor Clicar no Bot" + CHR(227) + "o [OK] Novamente.", "Erro")
                ENDIF
            ENDIF
        ENDIF
    ENDPROC

    *============================================================
    * Botao Cancelar
    *============================================================
    PROCEDURE BtnCancelarClick
        LOCAL loc_nCodigo, loc_nIdConta, loc_oErro

        *-- Liberar sequencial automatico se estava inserindo
        IF THIS.pcEscolha = "INSERIR"
            TRY
                IF USED("crSigCdCli")
                    SELECT crSigCdCli
                    loc_nCodigo  = crSigCdCli.NClis
                    loc_nIdConta = crSigCdCli.IdConta
                ELSE
                    loc_nCodigo  = 0
                    loc_nIdConta = 0
                ENDIF

                IF USED("crSigCdGcr")
                    SELECT crSigCdGcr
                    IF crSigCdGcr.TpCods = 1
                        IF crSigCdGcr.TpEmps = 1
                            = fCanUniqueKey(loc_nCodigo, ALLTRIM(crSigCdGcr.Codigos) + go_4c_Sistema.cCodEmpresa)
                        ELSE
                            = fCanUniqueKey(loc_nCodigo, ALLTRIM(crSigCdGcr.Codigos))
                        ENDIF
                    ENDIF
                ENDIF
            CATCH TO loc_oErro
                *-- fCanUniqueKey pode nao estar portada; nao bloquear o cancelamento
            ENDTRY
        ENDIF

        THIS.RetCodCliente = " "
        *-- Voltar para Lista em vez de fechar form
        THIS.IrParaLista()
    ENDPROC

    *============================================================
    * ConfigurarPaginaLista - configura o estado inicial da pagina
    * principal (pgframeDados1) do PageFrame interno de clsconta.
    *
    * Forms OPERACIONAIS deste tipo (wrapper de clsconta) NAO usam
    * o padrao CRUD Page1=Lista/Page2=Dados. A "pagina de listagem"
    * corresponde a pgframeDados1 (Cadastro principal) do clsconta,
    * que exibe os campos primarios do cliente. O paginado interno
    * eh alternado via cmdgPessoal (F5) ou via THIS.AlternarPagina().
    *============================================================
    PROTECTED PROCEDURE ConfigurarPaginaLista
        LOCAL loc_oPgf

        IF !PEMSTATUS(THIS, "cnt_4c_Conta", 5) OR ISNULL(THIS.cnt_4c_Conta)
            RETURN
        ENDIF

        IF !PEMSTATUS(THIS.cnt_4c_Conta, "pgframeDados", 5)
            RETURN
        ENDIF

        loc_oPgf = THIS.cnt_4c_Conta.pgframeDados

        loc_oPgf.Top        = 0
        loc_oPgf.ActivePage = 1
        loc_oPgf.Visible    = .T.

        *-- Realcar botao da pagina ativa (cmdgCadastro se existir)
        IF PEMSTATUS(THIS.cnt_4c_Conta, "cmdgCadastro", 5) AND ;
           PEMSTATUS(THIS.cnt_4c_Conta.cmdgCadastro, "cmdCadastro", 5)
            THIS.cnt_4c_Conta.cmdgCadastro.cmdCadastro.SetFocus()
        ENDIF
    ENDPROC

    *============================================================
    * AlternarPagina - alterna entre as paginas do pgframeDados
    * interno de clsconta (1 = Cadastro, 2 = Dados Pessoais/Comerciais).
    *
    * Chamada por KeyPress (F5) ou por logica interna do form.
    * par_nPagina: se informada e valida (1..PageCount), navega
    * diretamente; caso contrario, alterna entre 1 e 2.
    *============================================================
    PROCEDURE AlternarPagina
        LPARAMETERS par_nPagina
        LOCAL loc_oPgf, loc_nDestino

        IF !PEMSTATUS(THIS, "cnt_4c_Conta", 5) OR ISNULL(THIS.cnt_4c_Conta)
            RETURN
        ENDIF

        IF !PEMSTATUS(THIS.cnt_4c_Conta, "pgframeDados", 5)
            RETURN
        ENDIF

        loc_oPgf = THIS.cnt_4c_Conta.pgframeDados

        IF TYPE("par_nPagina") = "N" AND par_nPagina >= 1 AND par_nPagina <= loc_oPgf.PageCount
            loc_nDestino = par_nPagina
        ELSE
            loc_nDestino = IIF(loc_oPgf.ActivePage = 1, 2, 1)
        ENDIF

        loc_oPgf.ActivePage = loc_nDestino

        *-- Delegar ao botao de comando correspondente do clsconta
        *-- para preservar comportamento original (highlight, refresh, etc.)
        DO CASE
        CASE loc_nDestino = 2 AND PEMSTATUS(THIS.cnt_4c_Conta, "cmdgPessoal", 5) ;
             AND PEMSTATUS(THIS.cnt_4c_Conta.cmdgPessoal, "cmdPessoal", 5)
            THIS.cnt_4c_Conta.cmdgPessoal.cmdPessoal.Click()
        CASE loc_nDestino = 1 AND PEMSTATUS(THIS.cnt_4c_Conta, "cmdgCadastro", 5) ;
             AND PEMSTATUS(THIS.cnt_4c_Conta.cmdgCadastro, "cmdCadastro", 5)
            THIS.cnt_4c_Conta.cmdgCadastro.cmdCadastro.Click()
        ENDCASE
    ENDPROC

    *============================================================
    PROCEDURE KeyPress
    *============================================================
        LPARAMETERS par_nKeyCode, par_nShiftAltCtrl
        IF par_nKeyCode = -4  && F5 = Aba Dados Pessoais/Comerciais
            NODEFAULT
            THIS.AlternarPagina(2)
        ENDIF
    ENDPROC

    *============================================================
    PROCEDURE Unload
    *============================================================
        RETURN THIS.RetCodCliente
    ENDPROC

    *============================================================
    * ConfigurarPaginaDados - Aplica overrides visuais do SCX
    * legado nos controles internos de cnt_4c_Conta.pgframeDados1
    * (primeira metade: Shapes + primeiros Labels e TextBoxes).
    *============================================================
    PROTECTED PROCEDURE ConfigurarPaginaDados
        LOCAL loc_oPgf, loc_oPg1, loc_oErro, loc_cNomeEndCtrl, loc_oEndCtrl, loc_cNomeRazCtrl, loc_oRazCtrl, loc_lContinuar

        IF !PEMSTATUS(THIS, "cnt_4c_Conta", 5) OR ISNULL(THIS.cnt_4c_Conta)
            RETURN
        ENDIF
        IF !PEMSTATUS(THIS.cnt_4c_Conta, "pgframeDados", 5)
            RETURN
        ENDIF

        loc_oPgf = THIS.cnt_4c_Conta.pgframeDados

        loc_lContinuar = .T.
        TRY
            IF PEMSTATUS(loc_oPgf, "ErasePage", 5)
                loc_oPgf.ErasePage = .T.
            ENDIF

            IF !PEMSTATUS(loc_oPgf, "pgframeDados1", 5)
                loc_lContinuar = .F.
            ENDIF
            IF loc_lContinuar
            loc_oPg1 = loc_oPgf.pgframeDados1

            *-- Propriedades da pagina
            IF PEMSTATUS(loc_oPg1, "FontName", 5)
                loc_oPg1.FontName = "Tahoma"
            ENDIF
            IF PEMSTATUS(loc_oPg1, "BackColor", 5)
                loc_oPg1.BackColor = RGB(255,255,255)
            ENDIF
            IF PEMSTATUS(loc_oPg1, "ForeColor", 5)
                loc_oPg1.ForeColor = RGB(90,90,90)
            ENDIF

            *-- Shape1 (borda secao principal)
            IF PEMSTATUS(loc_oPg1, "Shape1", 5)
                WITH loc_oPg1.Shape1
                    .Top           = 2
                    .Left          = 6
                    .Height        = 195
                    .Width         = 751
                    .SpecialEffect = 1
                    .BorderColor   = RGB(136,188,189)
                ENDWITH
            ENDIF

            *-- Shape2 (borda secao dados pessoais)
            IF PEMSTATUS(loc_oPg1, "Shape2", 5)
                WITH loc_oPg1.Shape2
                    .Top           = 196
                    .Left          = 6
                    .Width         = 751
                    .SpecialEffect = 1
                    .BorderColor   = RGB(136,188,189)
                ENDWITH
            ENDIF

            *-- Shape4 (borda secao observacoes)
            IF PEMSTATUS(loc_oPg1, "Shape4", 5)
                WITH loc_oPg1.Shape4
                    .Top           = 344
                    .Left          = 6
                    .SpecialEffect = 1
                    .BorderColor   = RGB(136,188,189)
                ENDWITH
            ENDIF

            *-- Shape3 (area foto)
            IF PEMSTATUS(loc_oPg1, "Shape3", 5)
                WITH loc_oPg1.Shape3
                    .Top    = 71
                    .Left   = 573
                    .Height = 77
                    .Width  = 182
                ENDWITH
            ENDIF

            *-- Shape5 (borda cabecalho foto)
            IF PEMSTATUS(loc_oPg1, "Shape5", 5)
                WITH loc_oPg1.Shape5
                    .Top         = 8
                    .Left        = 573
                    .Width       = 182
                    .BorderColor = RGB(100,100,100)
                ENDWITH
            ENDIF

            *-- Say2 (label nome/razao)
            IF PEMSTATUS(loc_oPg1, "Say2", 5)
                WITH loc_oPg1.Say2
                    .FontName  = "Tahoma"
                    .Left      = 31
                    .Top       = 58
                    .ForeColor = RGB(90,90,90)
                ENDWITH
            ENDIF

            *-- Say12 (label empresa)
            IF PEMSTATUS(loc_oPg1, "Say12", 5)
                WITH loc_oPg1.Say12
                    .AutoSize  = .T.
                    .FontName  = "Tahoma"
                    .Left      = 17
                    .Top       = 81
                    .ForeColor = RGB(90,90,90)
                ENDWITH
            ENDIF

            *-- Say16 (label codigo)
            IF PEMSTATUS(loc_oPg1, "Say16", 5)
                WITH loc_oPg1.Say16
                    .FontName  = "Tahoma"
                    .Left      = 67
                    .Top       = 15
                    .ForeColor = RGB(90,90,90)
                ENDWITH
            ENDIF

            *-- Say22 (label inscr. estadual)
            IF PEMSTATUS(loc_oPg1, "Say22", 5)
                WITH loc_oPg1.Say22
                    .FontName  = "Tahoma"
                    .Left      = 17
                    .Top       = 104
                    .ForeColor = RGB(90,90,90)
                ENDWITH
            ENDIF

            *-- sayConjuges (label conjuge)
            IF PEMSTATUS(loc_oPg1, "sayConjuges", 5)
                WITH loc_oPg1.sayConjuges
                    .AutoSize  = .T.
                    .FontName  = "Tahoma"
                    .Left      = 19
                    .Top       = 150
                    .ForeColor = RGB(90,90,90)
                ENDWITH
            ENDIF

            *-- sayDtncons (label aniversario)
            IF PEMSTATUS(loc_oPg1, "sayDtncons", 5)
                WITH loc_oPg1.sayDtncons
                    .FontName  = "Tahoma"
                    .Caption   = "Aniv : "
                    .Left      = 362
                    .Top       = 150
                    .ForeColor = RGB(90,90,90)
                ENDWITH
            ENDIF

            *-- sayDtcasas (label data casamento)
            IF PEMSTATUS(loc_oPg1, "sayDtcasas", 5)
                WITH loc_oPg1.sayDtcasas
                    .FontName  = "Tahoma"
                    .Left      = 330
                    .Top       = 173
                    .ForeColor = RGB(90,90,90)
                ENDWITH
            ENDIF

            *-- Say29 (label usuario alt.)
            IF PEMSTATUS(loc_oPg1, "Say29", 5)
                WITH loc_oPg1.Say29
                    .FontName  = "Tahoma"
                    .Left      = 575
                    .Top       = 45
                    .ForeColor = RGB(90,90,90)
                ENDWITH
            ENDIF

            *-- Say30 (label usuario cadastro)
            IF PEMSTATUS(loc_oPg1, "Say30", 5)
                WITH loc_oPg1.Say30
                    .FontName  = "Tahoma"
                    .Left      = 578
                    .Top       = 17
                    .ForeColor = RGB(90,90,90)
                ENDWITH
            ENDIF

            *-- Say3 (label)
            IF PEMSTATUS(loc_oPg1, "Say3", 5)
                WITH loc_oPg1.Say3
                    .FontName  = "Tahoma"
                    .ForeColor = RGB(90,90,90)
                ENDWITH
            ENDIF

            *-- SayIm (label inscr. municipal)
            IF PEMSTATUS(loc_oPg1, "SayIm", 5)
                WITH loc_oPg1.SayIm
                    .FontName  = "Tahoma"
                    .Left      = 390
                    .Top       = 105
                    .ForeColor = RGB(90,90,90)
                ENDWITH
            ENDIF

            *-- lblCpf2 (label CPF/CNPJ socio)
            IF PEMSTATUS(loc_oPg1, "lblCpf2", 5)
                WITH loc_oPg1.lblCpf2
                    .FontName  = "Tahoma"
                    .Left      = 39
                    .Top       = 173
                    .ForeColor = RGB(90,90,90)
                ENDWITH
            ENDIF

            *-- Say31 (label foto)
            IF PEMSTATUS(loc_oPg1, "Say31", 5)
                WITH loc_oPg1.Say31
                    .FontName  = "Tahoma"
                    .Left      = 619
                    .Top       = 77
                    .ForeColor = RGB(90,90,90)
                ENDWITH
            ENDIF

            *-- lblRg2 (label RG socio)
            IF PEMSTATUS(loc_oPg1, "lblRg2", 5)
                WITH loc_oPg1.lblRg2
                    .FontName  = "Tahoma"
                    .Left      = 181
                    .Top       = 173
                    .ForeColor = RGB(90,90,90)
                ENDWITH
            ENDIF

            *-- SayRgIe (label RG/IE)
            IF PEMSTATUS(loc_oPg1, "SayRgIe", 5)
                WITH loc_oPg1.SayRgIe
                    .FontName  = "Tahoma"
                    .Left      = 263
                    .Top       = 35
                    .ForeColor = RGB(90,90,90)
                ENDWITH
            ENDIF

            *-- sayDatNas (label data nascimento)
            IF PEMSTATUS(loc_oPg1, "sayDatNas", 5)
                WITH loc_oPg1.sayDatNas
                    .FontName  = "Tahoma"
                    .Left      = 444
                    .Top       = 58
                    .ForeColor = RGB(90,90,90)
                ENDWITH
            ENDIF

            *-- SayResp (label responsavel)
            IF PEMSTATUS(loc_oPg1, "SayResp", 5)
                WITH loc_oPg1.SayResp
                    .FontName  = "Tahoma"
                    .Left      = 29
                    .Top       = 128
                    .ForeColor = RGB(90,90,90)
                ENDWITH
            ENDIF

            *-- Say1 (label)
            IF PEMSTATUS(loc_oPg1, "Say1", 5)
                WITH loc_oPg1.Say1
                    .FontName  = "Tahoma"
                    .ForeColor = RGB(90,90,90)
                ENDWITH
            ENDIF

            *-- SaySexo (label sexo)
            IF PEMSTATUS(loc_oPg1, "SaySexo", 5)
                WITH loc_oPg1.SaySexo
                    .FontName  = "Tahoma"
                    .Left      = 443
                    .Top       = 35
                    .ForeColor = RGB(90,90,90)
                ENDWITH
            ENDIF

            *-- Say21 (label)
            IF PEMSTATUS(loc_oPg1, "Say21", 5)
                WITH loc_oPg1.Say21
                    .FontName  = "Tahoma"
                    .ForeColor = RGB(90,90,90)
                ENDWITH
            ENDIF

            *-- Say25 (label)
            IF PEMSTATUS(loc_oPg1, "Say25", 5)
                WITH loc_oPg1.Say25
                    .FontName  = "Tahoma"
                    .Left      = 581
                    .Top       = 139
                    .ForeColor = RGB(90,90,90)
                ENDWITH
            ENDIF

            *-- Say32 (label)
            IF PEMSTATUS(loc_oPg1, "Say32", 5)
                WITH loc_oPg1.Say32
                    .FontName  = "Tahoma"
                    .Left      = 244
                    .Top       = 10
                    .ForeColor = RGB(90,90,90)
                ENDWITH
            ENDIF

            *-- Say23 (label)
            IF PEMSTATUS(loc_oPg1, "Say23", 5)
                WITH loc_oPg1.Say23
                    .FontName  = "Tahoma"
                    .Left      = 600
                    .Top       = 123
                    .ForeColor = RGB(90,90,90)
                ENDWITH
            ENDIF

            *-- Say33 (label)
            IF PEMSTATUS(loc_oPg1, "Say33", 5)
                WITH loc_oPg1.Say33
                    .FontName  = "Tahoma"
                    .Left      = 594
                    .Top       = 100
                    .ForeColor = RGB(90,90,90)
                ENDWITH
            ENDIF

            *-- lblEstCivil (label estado civil)
            IF PEMSTATUS(loc_oPg1, "lblEstCivil", 5)
                WITH loc_oPg1.lblEstCivil
                    .FontName  = "Tahoma"
                    .Left      = 503
                    .Top       = 174
                    .ForeColor = RGB(90,90,90)
                ENDWITH
            ENDIF

            *-- Get_usualt (TextBox usuario alteracao)
            IF PEMSTATUS(loc_oPg1, "Get_usualt", 5)
                WITH loc_oPg1.Get_usualt
                    .Left      = 590
                    .Top       = 42
                    .ForeColor = RGB(90,90,90)
                ENDWITH
            ENDIF

            *-- Get_usuar (TextBox usuario cadastro)
            IF PEMSTATUS(loc_oPg1, "Get_usuar", 5)
                WITH loc_oPg1.Get_usuar
                    .Left      = 590
                    .Top       = 14
                    .ForeColor = RGB(90,90,90)
                ENDWITH
            ENDIF

            *-- Data_ent (TextBox data entrada)
            IF PEMSTATUS(loc_oPg1, "Data_ent", 5)
                WITH loc_oPg1.Data_ent
                    .Left      = 670
                    .Top       = 14
                    .ForeColor = RGB(90,90,90)
                ENDWITH
            ENDIF

            *-- Data_alt (TextBox data alteracao)
            IF PEMSTATUS(loc_oPg1, "Data_alt", 5)
                WITH loc_oPg1.Data_alt
                    .Left      = 670
                    .Top       = 42
                    .ForeColor = RGB(90,90,90)
                ENDWITH
            ENDIF

            *-- GetCodigo (TextBox codigo)
            IF PEMSTATUS(loc_oPg1, "GetCodigo", 5)
                WITH loc_oPg1.GetCodigo
                    .Left = 290
                    .Top  = 8
                ENDWITH
            ENDIF

            *-- Get_Grupo (TextBox grupo)
            IF PEMSTATUS(loc_oPg1, "Get_Grupo", 5)
                WITH loc_oPg1.Get_Grupo
                    .Left = 108
                    .Top  = 8
                ENDWITH
            ENDIF

            *-- GetNome (TextBox nome)
            IF PEMSTATUS(loc_oPg1, "GetNome", 5)
                WITH loc_oPg1.GetNome
                    .Left = 70
                    .Top  = 55
                ENDWITH
            ENDIF

            *-- GetCPFCGC (TextBox CPF/CNPJ)
            IF PEMSTATUS(loc_oPg1, "GetCPFCGC", 5)
                WITH loc_oPg1.GetCPFCGC
                    .Left = 108
                    .Top  = 32
                ENDWITH
            ENDIF

            *-- GetRG (TextBox RG/IE)
            IF PEMSTATUS(loc_oPg1, "GetRG", 5)
                WITH loc_oPg1.GetRG
                    .Height = 23
                    .Left   = 290
                    .Top    = 32
                    .Width  = 149
                ENDWITH
            ENDIF

            *-- getSexo (ComboBox sexo)
            IF PEMSTATUS(loc_oPg1, "getSexo", 5)
                WITH loc_oPg1.getSexo
                    .Left = 483
                    .Top  = 32
                ENDWITH
            ENDIF

            *-- GetDatNas (TextBox data nascimento)
            IF PEMSTATUS(loc_oPg1, "GetDatNas", 5)
                WITH loc_oPg1.GetDatNas
                    .Left = 483
                    .Top  = 55
                ENDWITH
            ENDIF

            *-- getResp (TextBox codigo responsavel)
            IF PEMSTATUS(loc_oPg1, "getResp", 5)
                WITH loc_oPg1.getResp
                    .Left = 151
                    .Top  = 124
                ENDWITH
            ENDIF

            *-- Get_grupoven (TextBox grupo de vendas)
            IF PEMSTATUS(loc_oPg1, "Get_grupoven", 5)
                WITH loc_oPg1.Get_grupoven
                    .Left = 70
                    .Top  = 124
                ENDWITH
            ENDIF

            *-- getNresp (TextBox numero do responsavel)
            IF PEMSTATUS(loc_oPg1, "getNresp", 5)
                WITH loc_oPg1.getNresp
                    .Left = 232
                    .Top  = 124
                ENDWITH
            ENDIF

            *-- Get_Emps (TextBox codigo empresa)
            IF PEMSTATUS(loc_oPg1, "Get_Emps", 5)
                WITH loc_oPg1.Get_Emps
                    .Left = 70
                    .Top  = 101
                ENDWITH
            ENDIF

            *-- Get_DEmps (TextBox descricao empresa)
            IF PEMSTATUS(loc_oPg1, "Get_DEmps", 5)
                WITH loc_oPg1.Get_DEmps
                    .Left = 100
                    .Top  = 101
                ENDWITH
            ENDIF

            *-- Get_InsMuns (TextBox inscricao municipal)
            IF PEMSTATUS(loc_oPg1, "Get_InsMuns", 5)
                WITH loc_oPg1.Get_InsMuns
                    .Height = 23
                    .Left   = 431
                    .Top    = 101
                    .Width  = 141
                ENDWITH
            ENDIF

            *-- Get_Situa (TextBox situacao do cliente)
            IF PEMSTATUS(loc_oPg1, "Get_Situa", 5)
                WITH loc_oPg1.Get_Situa
                    .Left = 673
                    .Top  = 74
                ENDWITH
            ENDIF

            *-- getTelem (TextBox telefone celular)
            IF PEMSTATUS(loc_oPg1, "getTelem", 5)
                WITH loc_oPg1.getTelem
                    .Left = 673
                    .Top  = 97
                ENDWITH
            ENDIF

            *-- getClacod (TextBox classe do codigo)
            IF PEMSTATUS(loc_oPg1, "getClacod", 5)
                WITH loc_oPg1.getClacod
                    .Left = 673
                    .Top  = 120
                ENDWITH
            ENDIF

            *-- getConjuges (TextBox conjuge)
            IF PEMSTATUS(loc_oPg1, "getConjuges", 5)
                WITH loc_oPg1.getConjuges
                    .Left = 70
                    .Top  = 147
                ENDWITH
            ENDIF

            *-- getDtncons (TextBox aniversario conjuge)
            IF PEMSTATUS(loc_oPg1, "getDtncons", 5)
                WITH loc_oPg1.getDtncons
                    .Left = 396
                    .Top  = 147
                ENDWITH
            ENDIF

            *-- getDtcasas (TextBox data casamento)
            IF PEMSTATUS(loc_oPg1, "getDtcasas", 5)
                WITH loc_oPg1.getDtcasas
                    .Left = 396
                    .Top  = 170
                ENDWITH
            ENDIF

            IF PEMSTATUS(loc_oPg1, "getCpf2", 5)
                WITH loc_oPg1.getCpf2
                    .Left = 70
                    .Top  = 170
                ENDWITH
            ENDIF

            IF PEMSTATUS(loc_oPg1, "getRG2", 5)
                WITH loc_oPg1.getRG2
                    .Left = 211
                    .Top  = 170
                ENDWITH
            ENDIF

            *-- cmbEstcivils (ComboBox estado civil)
            IF PEMSTATUS(loc_oPg1, "cmbEstcivils", 5)
                WITH loc_oPg1.cmbEstcivils
                    .Left = 572
                    .Top  = 170
                ENDWITH
            ENDIF

            *-- chkInativa (CheckBox cliente inativado)
            IF PEMSTATUS(loc_oPg1, "chkInativa", 5)
                WITH loc_oPg1.chkInativa
                    .FontName  = "Tahoma"
                    .Alignment = 0
                    .ForeColor = RGB(90,90,90)
                ENDWITH
            ENDIF

            *-- OpcaoCPFCGC (OptionGroup tipo documento - posicao)
            IF PEMSTATUS(loc_oPg1, "OpcaoCPFCGC", 5)
                WITH loc_oPg1.OpcaoCPFCGC
                    .Left = 14
                    .Top  = 33
                ENDWITH
            ENDIF

            *-- GetCEP (TextBox CEP)
            IF PEMSTATUS(loc_oPg1, "GetCEP", 5)
                WITH loc_oPg1.GetCEP
                    .Left = 102
                    .Top  = 200
                ENDWITH
            ENDIF

            *-- GetPais (TextBox pais)
            IF PEMSTATUS(loc_oPg1, "GetPais", 5)
                WITH loc_oPg1.GetPais
                    .Left = 230
                    .Top  = 200
                ENDWITH
            ENDIF

            *-- GetEndere?o (TextBox endereco - nome com cedilha CHR(231))
            loc_cNomeEndCtrl = "GetEndere" + CHR(231) + "o"
            IF PEMSTATUS(loc_oPg1, loc_cNomeEndCtrl, 5)
                loc_oEndCtrl = EVALUATE("loc_oPg1." + loc_cNomeEndCtrl)
                WITH loc_oEndCtrl
                    .Left = 102
                    .Top  = 223
                ENDWITH
                loc_oEndCtrl = .NULL.
            ENDIF

            *-- Get_num (TextBox numero do endereco)
            IF PEMSTATUS(loc_oPg1, "Get_num", 5)
                WITH loc_oPg1.Get_num
                    .Left = 561
                    .Top  = 223
                ENDWITH
            ENDIF

            *-- Get_comp (TextBox complemento)
            IF PEMSTATUS(loc_oPg1, "Get_comp", 5)
                WITH loc_oPg1.Get_comp
                    .Left = 102
                    .Top  = 246
                ENDWITH
            ENDIF

            *-- GetBairro (TextBox bairro)
            IF PEMSTATUS(loc_oPg1, "GetBairro", 5)
                WITH loc_oPg1.GetBairro
                    .Left = 334
                    .Top  = 246
                ENDWITH
            ENDIF

            *-- GetCidade (TextBox cidade)
            IF PEMSTATUS(loc_oPg1, "GetCidade", 5)
                WITH loc_oPg1.GetCidade
                    .Height = 23
                    .Left   = 102
                    .Top    = 269
                    .Width  = 230
                ENDWITH
            ENDIF

            *-- getCidasIBGE (TextBox codigo IBGE da cidade)
            IF PEMSTATUS(loc_oPg1, "getCidasIBGE", 5)
                WITH loc_oPg1.getCidasIBGE
                    .Left = 334
                    .Top  = 269
                ENDWITH
            ENDIF

            *-- GetEstado (TextBox UF/Estado)
            IF PEMSTATUS(loc_oPg1, "GetEstado", 5)
                WITH loc_oPg1.GetEstado
                    .Left = 483
                    .Top  = 269
                ENDWITH
            ENDIF

            *-- getUFIBGE (TextBox codigo IBGE da UF)
            IF PEMSTATUS(loc_oPg1, "getUFIBGE", 5)
                WITH loc_oPg1.getUFIBGE
                    .Left = 508
                    .Top  = 269
                ENDWITH
            ENDIF

            *-- Get_Regiao (TextBox regiao)
            IF PEMSTATUS(loc_oPg1, "Get_Regiao", 5)
                WITH loc_oPg1.Get_Regiao
                    .Left = 596
                    .Top  = 269
                ENDWITH
            ENDIF

            *-- getDdds (TextBox DDD)
            IF PEMSTATUS(loc_oPg1, "getDdds", 5)
                WITH loc_oPg1.getDdds
                    .Left = 102
                    .Top  = 292
                ENDWITH
            ENDIF

            *-- GetTel1 (TextBox telefone 1)
            IF PEMSTATUS(loc_oPg1, "GetTel1", 5)
                WITH loc_oPg1.GetTel1
                    .Left = 179
                    .Top  = 292
                ENDWITH
            ENDIF

            *-- GetTel2 (TextBox telefone 2)
            IF PEMSTATUS(loc_oPg1, "GetTel2", 5)
                WITH loc_oPg1.GetTel2
                    .Left = 385
                    .Top  = 292
                ENDWITH
            ENDIF

            *-- GetFax (TextBox fax)
            IF PEMSTATUS(loc_oPg1, "GetFax", 5)
                WITH loc_oPg1.GetFax
                    .Left = 596
                    .Top  = 292
                ENDWITH
            ENDIF

            *-- Say13 (label secao dados comerciais/endereco)
            IF PEMSTATUS(loc_oPg1, "Say13", 5)
                WITH loc_oPg1.Say13
                    .Left = 61
                    .Top  = 295
                ENDWITH
            ENDIF

            *-- GetEmail (TextBox e-mail)
            IF PEMSTATUS(loc_oPg1, "GetEmail", 5)
                WITH loc_oPg1.GetEmail
                    .Left = 102
                    .Top  = 315
                ENDWITH
            ENDIF

            *-- Say19 (label e-mail)
            IF PEMSTATUS(loc_oPg1, "Say19", 5)
                WITH loc_oPg1.Say19
                    .Left = 55
                    .Top  = 318
                ENDWITH
            ENDIF

            *-- GetCodFun (TextBox codigo funcao)
            IF PEMSTATUS(loc_oPg1, "GetCodFun", 5)
                WITH loc_oPg1.GetCodFun
                    .Left = 97
                    .Top  = 349
                ENDWITH
            ENDIF

            *-- GetDesFun (TextBox descricao funcao)
            IF PEMSTATUS(loc_oPg1, "GetDesFun", 5)
                WITH loc_oPg1.GetDesFun
                    .Left = 130
                    .Top  = 349
                ENDWITH
            ENDIF

            *-- Say17 (label funcao/cargo do cliente)
            IF PEMSTATUS(loc_oPg1, "Say17", 5)
                WITH loc_oPg1.Say17
                    .Left = 13
                    .Top  = 352
                ENDWITH
            ENDIF

            *-- cmdEnderecos (CommandGroup multiplos enderecos)
            IF PEMSTATUS(loc_oPg1, "cmdEnderecos", 5)
                WITH loc_oPg1.cmdEnderecos
                    .Left = 444
                    .Top  = 360
                ENDWITH
            ENDIF

            *-- lblObs (label area de observacoes)
            IF PEMSTATUS(loc_oPg1, "lblObs", 5)
                WITH loc_oPg1.lblObs
                    .Left = 62
                    .Top  = 371
                ENDWITH
            ENDIF

            *-- chkObservas (CheckBox filtrar por observacao)
            IF PEMSTATUS(loc_oPg1, "chkObservas", 5)
                WITH loc_oPg1.chkObservas
                    .Top       = 387
                    .Left      = 59
                    .Alignment = 0
                ENDWITH
            ENDIF

            *-- MemoFun (EditBox observacoes/memo)
            IF PEMSTATUS(loc_oPg1, "MemoFun", 5)
                WITH loc_oPg1.MemoFun
                    .Left = 97
                    .Top  = 373
                ENDWITH
            ENDIF

            *-- GetRaz?o (TextBox razao social - nome com til CHR(227))
            loc_cNomeRazCtrl = "GetRaz" + CHR(227) + "o"
            IF PEMSTATUS(loc_oPg1, loc_cNomeRazCtrl, 5)
                loc_oRazCtrl = EVALUATE("loc_oPg1." + loc_cNomeRazCtrl)
                WITH loc_oRazCtrl
                    .Left = 70
                    .Top  = 78
                ENDWITH
                loc_oRazCtrl = .NULL.
            ENDIF

            *-- Say9 (label)
            IF PEMSTATUS(loc_oPg1, "Say9", 5)
                WITH loc_oPg1.Say9
                    .FontName  = "Tahoma"
                    .ForeColor = RGB(90,90,90)
                ENDWITH
            ENDIF

            *-- Say14 (label)
            IF PEMSTATUS(loc_oPg1, "Say14", 5)
                WITH loc_oPg1.Say14
                    .FontName  = "Tahoma"
                    .ForeColor = RGB(90,90,90)
                ENDWITH
            ENDIF

            *-- Say24 (label)
            IF PEMSTATUS(loc_oPg1, "Say24", 5)
                WITH loc_oPg1.Say24
                    .FontName  = "Tahoma"
                    .ForeColor = RGB(90,90,90)
                ENDWITH
            ENDIF

            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, ;
                "Erro em ConfigurarPaginaDados")
        ENDTRY
    ENDPROC

    *============================================================
    * checaibge - Validacao de codigo IBGE de municipio/UF.
    * Metodo PUBLIC chamado internamente pelo clsconta via
    * ThisForm.checaibge(pMun, pUFs, obCidade, obUF).
    *============================================================
    PROCEDURE checaibge
        LPARAMETERS par_cMun, par_cUFs, par_oObC, par_oObU
        LOCAL loc_nRtC, loc_nRtU, loc_cQuery, loc_oErro

        loc_nRtC = 9999999
        loc_nRtU = 99

        TRY
            *-- Buscar codigo IBGE do municipio
            loc_cQuery = "SELECT a.Codigos " + ;
                        "FROM SigCdMun a, SigCdUfs b " + ;
                        "WHERE RTRIM(a.Descs) = '" + ;
                            PADR(UPPER(ALLTRIM(par_cMun)), 40) + "'" + ;
                        " AND a.UFIBGEs = b.UFIBGEs" + ;
                        " AND b.Estados = '" + PADR(par_cUFs, 2) + "'"

            IF SQLEXEC(gnConnHandle, loc_cQuery, "cursor_4c_LocalMunic") > 0
                IF USED("cursor_4c_LocalMunic")
                    SELECT cursor_4c_LocalMunic
                    GO TOP IN cursor_4c_LocalMunic
                    IF !EOF("cursor_4c_LocalMunic")
                        loc_nRtC = INT(VAL(ALLTRIM(TRANSFORM(cursor_4c_LocalMunic.Codigos))))
                    ENDIF
                ENDIF
            ENDIF

            IF USED("cursor_4c_LocalMunic")
                USE IN cursor_4c_LocalMunic
            ENDIF

            par_oObC.Value    = loc_nRtC
            par_oObC.Refresh()
            par_oObC.ForeColor = IIF(loc_nRtC = 9999999, RGB(255,0,0), RGB(0,0,0))

            *-- Buscar codigo IBGE da UF
            loc_cQuery = "SELECT UFIBGEs FROM SigCdUfs " + ;
                        "WHERE Estados = '" + PADR(par_cUFs, 2) + "'"

            IF SQLEXEC(gnConnHandle, loc_cQuery, "cursor_4c_LocalUF") > 0
                IF USED("cursor_4c_LocalUF")
                    SELECT cursor_4c_LocalUF
                    GO TOP IN cursor_4c_LocalUF
                    IF !EOF("cursor_4c_LocalUF")
                        loc_nRtU = cursor_4c_LocalUF.UFIBGEs
                    ENDIF
                ENDIF
            ENDIF

            IF USED("cursor_4c_LocalUF")
                USE IN cursor_4c_LocalUF
            ENDIF

            par_oObU.Value    = loc_nRtU
            par_oObU.Refresh()
            par_oObU.ForeColor = IIF(loc_nRtU = 99, RGB(255,0,0), RGB(0,0,0))

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, ;
                "Erro em checaibge")
        ENDTRY
    ENDPROC

    *============================================================
    * IrParaLista - Estado Lista: mostra grid, esconde dados
    *============================================================
    PROCEDURE IrParaLista
        LOCAL loc_oErro
        TRY
            IF PEMSTATUS(THIS, "cnt_4c_ViewLista", 5)
                THIS.cnt_4c_ViewLista.Visible = .T.
            ENDIF
            IF PEMSTATUS(THIS, "cnt_4c_Sombra", 5)
                THIS.cnt_4c_Sombra.Visible = .F.
            ENDIF
            IF PEMSTATUS(THIS, "cnt_4c_Conta", 5) AND !ISNULL(THIS.cnt_4c_Conta)
                THIS.cnt_4c_Conta.Visible = .F.
            ENDIF
            IF PEMSTATUS(THIS, "cmg_4c_Sair", 5)
                THIS.cmg_4c_Sair.Visible = .F.
            ENDIF
            THIS.this_cModoAtual = "LISTA"
            THIS.RefreshGridClientes()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + "Linha: " + TRANSFORM(loc_oErro.LineNo), "IrParaLista")
        ENDTRY
    ENDPROC

    *============================================================
    * IrParaDados - Estado Dados: mostra clsconta+cabecalho+Ok/Cancelar
    *============================================================
    PROCEDURE IrParaDados
        LOCAL loc_oErro
        TRY
            IF PEMSTATUS(THIS, "cnt_4c_ViewLista", 5)
                THIS.cnt_4c_ViewLista.Visible = .F.
            ENDIF
            IF PEMSTATUS(THIS, "cnt_4c_Sombra", 5)
                THIS.cnt_4c_Sombra.Visible = .T.
            ENDIF
            IF PEMSTATUS(THIS, "cnt_4c_Conta", 5) AND !ISNULL(THIS.cnt_4c_Conta)
                THIS.cnt_4c_Conta.Visible = .T.
            ENDIF
            IF PEMSTATUS(THIS, "cmg_4c_Sair", 5)
                THIS.cmg_4c_Sair.Visible = .T.
            ENDIF
            THIS.this_cModoAtual = "DADOS"
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + "Linha: " + TRANSFORM(loc_oErro.LineNo), "IrParaDados")
        ENDTRY
    ENDPROC

    *============================================================
    * ValidarPreAcao - Validacoes pre-acao portadas do SIGCDCLI.Init legado
    * (sigcdcli_form_codigo_fonte.txt linhas 2103-2166).
    * Retorna .T. se OK, .F. se qualquer check falhar (ja exibiu MsgAviso).
    * Efeito colateral: atualiza THIS.this_cGrupo com o grupo resolvido.
    * par_cAcao: "INCLUIR" | "ALTERAR" | "EXCLUIR" | "VISUALIZAR"
    *  - INCLUIR/ALTERAR/EXCLUIR checam fChecaAcesso("SIGCDCTA","ALTERAR")
    *  - VISUALIZAR nao exige acesso de alteracao
    *============================================================
    PROTECTED FUNCTION ValidarPreAcao(par_cAcao)
        LOCAL loc_cGrupo, loc_cAcao, loc_oFiltros, loc_lTemTxt
        loc_cAcao = UPPER(IIF(TYPE("par_cAcao") = "C", ALLTRIM(par_cAcao), ""))
        loc_cGrupo = ""
        loc_lTemTxt = .F.
        loc_oFiltros = .NULL.

        *-- Fonte UNICA: textbox de filtro do usuario (sem fallback silencioso para
        *-- this_cGrupo, que mascarava a intencao do usuario ao esvaziar o campo).
        IF PEMSTATUS(THIS, "cnt_4c_ViewLista", 5) AND ;
           PEMSTATUS(THIS.cnt_4c_ViewLista, "cnt_4c_ListaFiltros", 5) AND ;
           PEMSTATUS(THIS.cnt_4c_ViewLista.cnt_4c_ListaFiltros, "txt_4c_FiltroGrupo", 5)
            loc_oFiltros = THIS.cnt_4c_ViewLista.cnt_4c_ListaFiltros
            loc_lTemTxt  = .T.
            loc_cGrupo   = ALLTRIM(NVL(loc_oFiltros.txt_4c_FiltroGrupo.Value, ""))
        ENDIF

        *-- Textbox vazio: msg de obrigatoriedade + foco no campo, bloqueia acao
        IF loc_lTemTxt AND EMPTY(loc_cGrupo)
            MsgAviso("Grupo Obrigat" + CHR(243) + "rio. Preencha o Grupo de Contas antes de prosseguir.", ;
                "Aten" + CHR(231) + CHR(227) + "o")
            loc_oFiltros.txt_4c_FiltroGrupo.SetFocus()
            RETURN .F.
        ENDIF

        *-- Sem textbox visivel (form aberto por programa via par_cGrupo): usa
        *-- this_cGrupo como fonte, com fallback para GrPadClis do sistema.
        IF !loc_lTemTxt
            loc_cGrupo = ALLTRIM(THIS.this_cGrupo)
            IF EMPTY(loc_cGrupo) AND USED("crSigCdPam") AND RECCOUNT("crSigCdPam") > 0
                SELECT crSigCdPam
                LOCATE
                IF !EOF("crSigCdPam")
                    loc_cGrupo = ALLTRIM(NVL(crSigCdPam.GrPadClis, ""))
                ENDIF
            ENDIF
        ENDIF

        IF !USED("crSigCdPam") OR RECCOUNT("crSigCdPam") = 0
            MsgAviso("Configura" + CHR(231) + CHR(227) + "o de Parametros do Sistema N" + CHR(227) + "o Encontrada.")
            RETURN .F.
        ENDIF
        IF !USED("crSigCdGcr") OR RECCOUNT("crSigCdGcr") = 0
            MsgAviso("Nenhum Grupo de Conta Cadastrado.")
            RETURN .F.
        ENDIF
        IF EMPTY(loc_cGrupo)
            MsgAviso("Grupo Obrigat" + CHR(243) + "rio. Preencha o Grupo de Contas antes de prosseguir.", ;
                "Aten" + CHR(231) + CHR(227) + "o")
            RETURN .F.
        ENDIF
        SELECT crSigCdGcr
        LOCATE FOR ALLTRIM(Codigos) == ALLTRIM(loc_cGrupo)
        IF EOF("crSigCdGcr")
            MsgAviso("Grupo Inv" + CHR(225) + "lido: [" + loc_cGrupo + "] n" + CHR(227) + "o cadastrado.", ;
                "Aten" + CHR(231) + CHR(227) + "o")
            IF loc_lTemTxt
                loc_oFiltros.txt_4c_FiltroGrupo.SetFocus()
            ENDIF
            RETURN .F.
        ENDIF
        IF loc_cAcao <> "VISUALIZAR"
            IF !fChecaAcesso("SIGCDCTA", "ALTERAR")
                MsgAviso("Usu" + CHR(225) + "rio N" + CHR(227) + "o Possui Acesso p/ Incluir / Alterar Dados de Clientes.")
                RETURN .F.
            ENDIF
        ENDIF
        THIS.this_cGrupo = PADR(loc_cGrupo, 10)
        RETURN .T.
    ENDFUNC

    *============================================================
    * ChamarMLeDadosSeguro - Wrapper canonico para clsconta.mLeDados
    * Legacy clsconta.mLeDados (classresp.vcx linha 895):
    *   If Empty(lcGrupo) And (ThisForm.pcEscolha <> 'PROCURAR')
    *       = MessageBox('Grupo Invalido.', 0+48, 'Atencao!!!')
    *       Return (.f.)
    *   EndIf
    * Este helper garante que a msg NAO dispare:
    *  1. Resolve par_cGrupo do crSigCdPam.GrPadClis se vazio
    *  2. Se AINDA vazio E cli tambem vazio, seta pcEscolha=PROCURAR
    *     temporariamente para ativar o gate silencioso do clsconta
    *  3. Chama mLeDados, restaura pcEscolha
    *============================================================
    PROTECTED FUNCTION ChamarMLeDadosSeguro(par_cGrupo, par_cCli, par_cTpCadCli, par_cTpBloqCar, par_cMudaCpfCgc)
        LOCAL loc_cGrupo, loc_cCli, loc_cEscolhaSalva, loc_lRet, loc_lRestaurar
        loc_cGrupo = ALLTRIM(IIF(TYPE("par_cGrupo") = "C", par_cGrupo, ""))
        loc_cCli   = ALLTRIM(IIF(TYPE("par_cCli")   = "C", par_cCli,   ""))

        *-- Fallback #1: resolver grupo do parametro sistema (crSigCdPam.GrPadClis)
        IF EMPTY(loc_cGrupo) AND USED("crSigCdPam") AND RECCOUNT("crSigCdPam") > 0
            SELECT crSigCdPam
            LOCATE
            IF !EOF("crSigCdPam")
                loc_cGrupo = ALLTRIM(NVL(crSigCdPam.GrPadClis, ""))
            ENDIF
        ENDIF

        *-- Fallback #2: se grupo E cli vazios, gate silencioso via pcEscolha=PROCURAR
        loc_lRestaurar    = .F.
        loc_cEscolhaSalva = ""
        IF EMPTY(loc_cGrupo) AND EMPTY(loc_cCli)
            loc_cEscolhaSalva = THIS.pcEscolha
            THIS.pcEscolha    = "PROCURAR"
            loc_lRestaurar    = .T.
        ENDIF

        loc_lRet = THIS.cnt_4c_Conta.mLeDados( ;
            IIF(EMPTY(loc_cGrupo), par_cGrupo, PADR(loc_cGrupo, 10)), ;
            par_cCli, par_cTpCadCli, par_cTpBloqCar, par_cMudaCpfCgc)

        IF loc_lRestaurar
            THIS.pcEscolha = loc_cEscolhaSalva
        ENDIF

        RETURN loc_lRet
    ENDFUNC

    *============================================================
    * TxtFiltroGrupoKeyPress - Enter/Tab/F4 no textbox codigo Grupo
    * abre picker SigCdGcr (por codigo). Se selecao, atualiza codigo+desc
    * e re-popula grid via RefreshGridClientes.
    *============================================================
    PROCEDURE TxtFiltroGrupoKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 13 OR par_nKeyCode = 9 OR par_nKeyCode = 115
            THIS.AbrirLookupGrupoFiltro(.F.)
            RETURN
        ENDIF
    ENDPROC

    *============================================================
    * TxtFiltroGrupoDescKeyPress - Enter/Tab/F4 no textbox descricao Grupo
    * abre picker SigCdGcr (por descricao). Selecao atualiza cod+desc + grid.
    *============================================================
    PROCEDURE TxtFiltroGrupoDescKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 13 OR par_nKeyCode = 9 OR par_nKeyCode = 115
            THIS.AbrirLookupGrupoFiltro(.T.)
            RETURN
        ENDIF
    ENDPROC

    *============================================================
    * AbrirLookupGrupoFiltro - Abre picker SigCdGcr para filtros
    * (codigo ou descricao). Se usuario selecionar grupo, atualiza os
    * dois textboxes e re-popula grid via RefreshGridClientes.
    * par_lPorDescr: .T. = busca por descricao, .F. = busca por codigo
    *============================================================
    PROCEDURE AbrirLookupGrupoFiltro(par_lPorDescr)
        LOCAL loc_oFiltros, loc_oLookup, loc_cValorAtual
        TRY
            IF !PEMSTATUS(THIS, "cnt_4c_ViewLista", 5) OR ;
               !PEMSTATUS(THIS.cnt_4c_ViewLista, "cnt_4c_ListaFiltros", 5)
                RETURN
            ENDIF
            loc_oFiltros = THIS.cnt_4c_ViewLista.cnt_4c_ListaFiltros

            IF par_lPorDescr
                loc_cValorAtual = ALLTRIM(NVL(loc_oFiltros.txt_4c_FiltroGrupoDesc.Value, ""))
                loc_oLookup = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                    "SigCdGcr", "cursor_4c_GrupoFiltro", "Descrs", loc_cValorAtual, ;
                    "Grupo de Contas", .F., .T., "")
            ELSE
                loc_cValorAtual = ALLTRIM(NVL(loc_oFiltros.txt_4c_FiltroGrupo.Value, ""))
                loc_oLookup = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                    "SigCdGcr", "cursor_4c_GrupoFiltro", "Codigos", loc_cValorAtual, ;
                    "Grupo de Contas", .F., .T., "")
            ENDIF

            IF VARTYPE(loc_oLookup) = "O"
                loc_oLookup.mAddColuna("Codigos", "", "C" + CHR(243) + "digo")
                loc_oLookup.mAddColuna("Descrs", "", "Descri" + CHR(231) + CHR(227) + "o")
                loc_oLookup.Show()

                IF loc_oLookup.this_lSelecionou AND USED("cursor_4c_GrupoFiltro")
                    SELECT cursor_4c_GrupoFiltro
                    loc_oFiltros.txt_4c_FiltroGrupo.Value     = ALLTRIM(NVL(cursor_4c_GrupoFiltro.Codigos, ""))
                    loc_oFiltros.txt_4c_FiltroGrupoDesc.Value = ALLTRIM(NVL(cursor_4c_GrupoFiltro.Descrs, ""))
                    THIS.this_cGrupo = PADR(ALLTRIM(cursor_4c_GrupoFiltro.Codigos), 10)
                    USE IN cursor_4c_GrupoFiltro
                    THIS.RefreshGridClientes()
                ELSE
                    IF USED("cursor_4c_GrupoFiltro")
                        USE IN cursor_4c_GrupoFiltro
                    ENDIF
                ENDIF
                loc_oLookup.Release()
                loc_oLookup = .NULL.
            ENDIF

        CATCH TO loc_oErr
            IF USED("cursor_4c_GrupoFiltro")
                USE IN cursor_4c_GrupoFiltro
            ENDIF
            MsgErro("Erro no lookup de Grupo:" + CHR(13) + loc_oErr.Message, "Erro")
        ENDTRY
    ENDPROC

    *============================================================
    * RefreshGridClientes - Popula crSigCdCli via poDataMgr.Requery
    * e bind grid columns. Chamado toda vez que entra em Lista.
    *============================================================
    PROCEDURE RefreshGridClientes
        LOCAL loc_oErro, loc_oGrd, loc_cGrupo
        TRY
            IF !PEMSTATUS(THIS, "cnt_4c_ViewLista", 5) OR ;
               !PEMSTATUS(THIS.cnt_4c_ViewLista, "grd_4c_Clientes", 5)
                RETURN
            ENDIF

            *-- Requery com filtro grupo (pega do textbox ou padrao)
            loc_cGrupo = ALLTRIM(THIS.cnt_4c_ViewLista.cnt_4c_ListaFiltros.txt_4c_FiltroGrupo.Value)
            IF EMPTY(loc_cGrupo) AND USED("crSigCdPam") AND RECCOUNT("crSigCdPam") > 0
                loc_cGrupo = ALLTRIM(crSigCdPam.GrPadClis)
                THIS.cnt_4c_ViewLista.cnt_4c_ListaFiltros.txt_4c_FiltroGrupo.Value = loc_cGrupo
                THIS.this_cGrupo = PADR(loc_cGrupo, 10)
            ENDIF

            IF !ISNULL(THIS.poDataMgr) AND VARTYPE(THIS.poDataMgr) = "O" AND !EMPTY(loc_cGrupo)
                THIS.poDataMgr.ReQuery("crSigCdCli", "Grupos", PADR(loc_cGrupo, 10))
            ENDIF

            *-- Bind grid a crSigCdCli (uma vez ou toda vez, VFP aceita)
            loc_oGrd = THIS.cnt_4c_ViewLista.grd_4c_Clientes
            IF USED("crSigCdCli")
                loc_oGrd.RecordSource = "crSigCdCli"
                loc_oGrd.Column1.ControlSource = "crSigCdCli.iclis"
                loc_oGrd.Column2.ControlSource = "crSigCdCli.rclis"
                loc_oGrd.Column3.ControlSource = "crSigCdCli.cpfs"
                loc_oGrd.Column4.ControlSource = "crSigCdCli.situas"
                loc_oGrd.Column5.ControlSource = "crSigCdCli.ultcomps"
                loc_oGrd.Column6.ControlSource = "crSigCdCli.dtalts"
                loc_oGrd.Column7.ControlSource = "crSigCdCli.usualts"
                loc_oGrd.Column8.ControlSource = "crSigCdCli.ddds"
                loc_oGrd.Column9.ControlSource = "crSigCdCli.tel1s"
            ENDIF
            loc_oGrd.Refresh()
        CATCH TO loc_oErro
            *-- Silent: se cursor/wrapper ainda nao pronto, apenas nao popula
        ENDTRY
    ENDPROC

    *============================================================
    * ConfigurarPaginaDados2 - Aplica overrides visuais do SCX
    * legado nos controles internos de cnt_4c_Conta.pgframeDados2
    * (aba de Dados Pessoais/Comerciais do cliente).
    *============================================================
    PROTECTED PROCEDURE ConfigurarPaginaDados2
        LOCAL loc_oPgf, loc_oPg2, loc_oErro

        IF !PEMSTATUS(THIS, "cnt_4c_Conta", 5) OR ISNULL(THIS.cnt_4c_Conta)
            RETURN
        ENDIF
        IF !PEMSTATUS(THIS.cnt_4c_Conta, "pgframeDados", 5)
            RETURN
        ENDIF

        loc_oPgf = THIS.cnt_4c_Conta.pgframeDados

        IF !PEMSTATUS(loc_oPgf, "pgframeDados2", 5)
            RETURN
        ENDIF
        loc_oPg2 = loc_oPgf.pgframeDados2

        TRY
            IF PEMSTATUS(loc_oPg2, "FontName", 5)
                loc_oPg2.FontName = "Tahoma"
            ENDIF
            IF PEMSTATUS(loc_oPg2, "ForeColor", 5)
                loc_oPg2.ForeColor = RGB(90,90,90)
            ENDIF

            *-- Say4 (label)
            IF PEMSTATUS(loc_oPg2, "Say4", 5)
                WITH loc_oPg2.Say4
                    .FontName  = "Tahoma"
                    .Left      = 72
                    .ForeColor = RGB(90,90,90)
                ENDWITH
            ENDIF

            *-- Say5 (label)
            IF PEMSTATUS(loc_oPg2, "Say5", 5)
                WITH loc_oPg2.Say5
                    .FontName  = "Tahoma"
                    .Left      = 76
                    .ForeColor = RGB(90,90,90)
                ENDWITH
            ENDIF

            *-- sayDtcasas (label data casamento - pg2)
            IF PEMSTATUS(loc_oPg2, "sayDtcasas", 5)
                WITH loc_oPg2.sayDtcasas
                    .FontName  = "Tahoma"
                    .Left      = 296
                    .ForeColor = RGB(90,90,90)
                ENDWITH
            ENDIF

            *-- Say6 (label)
            IF PEMSTATUS(loc_oPg2, "Say6", 5)
                WITH loc_oPg2.Say6
                    .FontName  = "Tahoma"
                    .Left      = 316
                    .Top       = 231
                    .ForeColor = RGB(90,90,90)
                ENDWITH
            ENDIF

            *-- Say7 (label)
            IF PEMSTATUS(loc_oPg2, "Say7", 5)
                WITH loc_oPg2.Say7
                    .FontName  = "Tahoma"
                    .Left      = 52
                    .ForeColor = RGB(90,90,90)
                ENDWITH
            ENDIF

            *-- Say8 (label)
            IF PEMSTATUS(loc_oPg2, "Say8", 5)
                WITH loc_oPg2.Say8
                    .FontName  = "Tahoma"
                    .Left      = 98
                    .ForeColor = RGB(90,90,90)
                ENDWITH
            ENDIF

            *-- Say9 (label - pg2)
            IF PEMSTATUS(loc_oPg2, "Say9", 5)
                WITH loc_oPg2.Say9
                    .FontName  = "Tahoma"
                    .Left      = 84
                    .ForeColor = RGB(90,90,90)
                ENDWITH
            ENDIF

            *-- Say10 (label)
            IF PEMSTATUS(loc_oPg2, "Say10", 5)
                WITH loc_oPg2.Say10
                    .FontName  = "Tahoma"
                    .Left      = 537
                    .ForeColor = RGB(90,90,90)
                ENDWITH
            ENDIF

            *-- Say11 (label - pg2)
            IF PEMSTATUS(loc_oPg2, "Say11", 5)
                WITH loc_oPg2.Say11
                    .FontName  = "Tahoma"
                    .ForeColor = RGB(90,90,90)
                ENDWITH
            ENDIF

            *-- Say12 (label - pg2)
            IF PEMSTATUS(loc_oPg2, "Say12", 5)
                WITH loc_oPg2.Say12
                    .FontName  = "Tahoma"
                    .Left      = 92
                    .Top       = 279
                    .ForeColor = RGB(90,90,90)
                ENDWITH
            ENDIF

            *-- Say14 (label - pg2)
            IF PEMSTATUS(loc_oPg2, "Say14", 5)
                WITH loc_oPg2.Say14
                    .FontName  = "Tahoma"
                    .Left      = 47
                    .Top       = 302
                    .ForeColor = RGB(90,90,90)
                ENDWITH
            ENDIF

            *-- Say15 (label)
            IF PEMSTATUS(loc_oPg2, "Say15", 5)
                WITH loc_oPg2.Say15
                    .FontName  = "Tahoma"
                    .ForeColor = RGB(90,90,90)
                ENDWITH
            ENDIF

            *-- Say16 (label - pg2)
            IF PEMSTATUS(loc_oPg2, "Say16", 5)
                WITH loc_oPg2.Say16
                    .FontName  = "Tahoma"
                    .Left      = 25
                    .Top       = 333
                    .ForeColor = RGB(90,90,90)
                ENDWITH
            ENDIF

            *-- Say17 (label - pg2)
            IF PEMSTATUS(loc_oPg2, "Say17", 5)
                WITH loc_oPg2.Say17
                    .FontName  = "Tahoma"
                    .Left      = 504
                    .ForeColor = RGB(90,90,90)
                ENDWITH
            ENDIF

            *-- Say18 (label)
            IF PEMSTATUS(loc_oPg2, "Say18", 5)
                WITH loc_oPg2.Say18
                    .FontName  = "Tahoma"
                    .Left      = 294
                    .ForeColor = RGB(90,90,90)
                ENDWITH
            ENDIF

            *-- Say19 (label - pg2)
            IF PEMSTATUS(loc_oPg2, "Say19", 5)
                WITH loc_oPg2.Say19
                    .FontName  = "Tahoma"
                    .Left      = 536
                    .ForeColor = RGB(90,90,90)
                ENDWITH
            ENDIF

            *-- Say20 (label)
            IF PEMSTATUS(loc_oPg2, "Say20", 5)
                WITH loc_oPg2.Say20
                    .FontName  = "Tahoma"
                    .ForeColor = RGB(90,90,90)
                ENDWITH
            ENDIF

            *-- Say21 (label - pg2)
            IF PEMSTATUS(loc_oPg2, "Say21", 5)
                WITH loc_oPg2.Say21
                    .FontName  = "Tahoma"
                    .ForeColor = RGB(90,90,90)
                ENDWITH
            ENDIF

            *-- Say22 (label - pg2)
            IF PEMSTATUS(loc_oPg2, "Say22", 5)
                WITH loc_oPg2.Say22
                    .FontName  = "Tahoma"
                    .Left      = 85
                    .ForeColor = RGB(90,90,90)
                ENDWITH
            ENDIF

            *-- Say23 (label - pg2)
            IF PEMSTATUS(loc_oPg2, "Say23", 5)
                WITH loc_oPg2.Say23
                    .FontName  = "Tahoma"
                    .ForeColor = RGB(90,90,90)
                ENDWITH
            ENDIF

            *-- Say24 (label - pg2)
            IF PEMSTATUS(loc_oPg2, "Say24", 5)
                WITH loc_oPg2.Say24
                    .FontName  = "Tahoma"
                    .ForeColor = RGB(90,90,90)
                ENDWITH
            ENDIF

            *-- Say25 (label - pg2)
            IF PEMSTATUS(loc_oPg2, "Say25", 5)
                WITH loc_oPg2.Say25
                    .FontName  = "Tahoma"
                    .ForeColor = RGB(90,90,90)
                ENDWITH
            ENDIF

            *-- Say3 (label - pg2)
            IF PEMSTATUS(loc_oPg2, "Say3", 5)
                WITH loc_oPg2.Say3
                    .FontName  = "Tahoma"
                    .ForeColor = RGB(90,90,90)
                ENDWITH
            ENDIF

            *-- SayTel1 (label telefone comercial)
            IF PEMSTATUS(loc_oPg2, "SayTel1", 5)
                WITH loc_oPg2.SayTel1
                    .FontName  = "Tahoma"
                    .Left      = 91
                    .ForeColor = RGB(90,90,90)
                ENDWITH
            ENDIF

            *-- say_Limite (label limite de credito)
            IF PEMSTATUS(loc_oPg2, "say_Limite", 5)
                WITH loc_oPg2.say_Limite
                    .FontName  = "Tahoma"
                    .ForeColor = RGB(90,90,90)
                ENDWITH
            ENDIF

            *-- getGrauParens (TextBox grau de parentesco)
            IF PEMSTATUS(loc_oPg2, "getGrauParens", 5)
                WITH loc_oPg2.getGrauParens
                    .Left = 376
                    .Top  = 299
                ENDWITH
            ENDIF

            *-- Cnt_Limite.Say1 (label dentro do container de limite)
            IF PEMSTATUS(loc_oPg2, "Cnt_Limite", 5)
                IF PEMSTATUS(loc_oPg2.Cnt_Limite, "Say1", 5)
                    WITH loc_oPg2.Cnt_Limite.Say1
                        .FontName  = "Tahoma"
                        .ForeColor = RGB(90,90,90)
                    ENDWITH
                ENDIF
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, ;
                "Erro em ConfigurarPaginaDados2")
        ENDTRY
    ENDPROC

    *============================================================
    * BtnIncluirClick - Limpar clsconta para inclusao de novo cliente
    *============================================================
    PROCEDURE BtnIncluirClick
        LOCAL loc_lRet, loc_oErro
        IF !THIS.ValidarPreAcao("INCLUIR")
            RETURN
        ENDIF
        TRY
            THIS.pcEscolha       = "INSERIR"
            THIS.this_cModoAtual = "INCLUIR"
            THIS.plaltcd         = .F.
            THIS.this_cCli       = SPACE(10)
            THIS.RetCodCliente   = " "
            THIS.IrParaDados()
            IF PEMSTATUS(THIS, "cnt_4c_Conta", 5) AND !ISNULL(THIS.cnt_4c_Conta)
                TRY
                    loc_lRet = THIS.ChamarMLeDadosSeguro(THIS.this_cGrupo, SPACE(10), "1", ;
                        THIS.this_cTpBloqCar, THIS.this_cMudaCpfCgc)
                CATCH
                    *-- exception nao-fatal (fwcombo1 etc.) — form usavel
                    loc_lRet = USED("crSigCdCli") AND RECCOUNT("crSigCdCli") > 0
                ENDTRY
                IF loc_lRet
                    THIS.cnt_4c_Conta.Refresh()
                    IF PEMSTATUS(THIS, "cmg_4c_Sair", 5)
                        THIS.cmg_4c_Sair.Buttons(1).Enabled = .T.
                    ENDIF
                ELSE
                    MsgErro("Erro ao inicializar formul" + CHR(225) + "rio para inclus" + CHR(227) + "o.", "Erro")
                    THIS.IrParaLista()
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, ;
                "Erro em BtnIncluirClick")
        ENDTRY
    ENDPROC

    *============================================================
    * BtnAlterarClick - Recarregar cliente em modo de alteracao
    *============================================================
    PROCEDURE BtnAlterarClick
        LOCAL loc_cCodigoCli, loc_lRet, loc_oErro
        IF !THIS.ValidarPreAcao("ALTERAR")
            RETURN
        ENDIF
        TRY
            *-- Ler codigo do cliente da linha corrente do grid
            loc_cCodigoCli = ""
            IF USED("crSigCdCli") AND !EOF("crSigCdCli")
                loc_cCodigoCli = ALLTRIM(crSigCdCli.iclis)
            ENDIF

            IF EMPTY(loc_cCodigoCli)
                MsgAviso("Nenhum cliente selecionado para altera" + CHR(231) + CHR(227) + "o.")
                RETURN
            ENDIF

            THIS.pcEscolha       = "ALTERAR"
            THIS.this_cModoAtual = "ALTERAR"
            THIS.plaltcd         = .T.
            THIS.this_cCli       = PADR(loc_cCodigoCli, 10)
            THIS.IrParaDados()

            IF PEMSTATUS(THIS, "cnt_4c_Conta", 5) AND !ISNULL(THIS.cnt_4c_Conta)
                TRY
                    loc_lRet = THIS.ChamarMLeDadosSeguro(THIS.this_cGrupo, THIS.this_cCli, "1", ;
                        THIS.this_cTpBloqCar, THIS.this_cMudaCpfCgc)
                CATCH
                    loc_lRet = USED("crSigCdCli") AND RECCOUNT("crSigCdCli") > 0
                ENDTRY
                IF loc_lRet
                    THIS.cnt_4c_Conta.Refresh()
                    IF PEMSTATUS(THIS, "cmg_4c_Sair", 5)
                        THIS.cmg_4c_Sair.Buttons(1).Enabled = .T.
                    ENDIF
                ELSE
                    MsgErro("Erro ao carregar dados para altera" + CHR(231) + CHR(227) + "o.", "Erro")
                    THIS.IrParaLista()
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, ;
                "Erro em BtnAlterarClick")
        ENDTRY
    ENDPROC

    *============================================================
    * BtnVisualizarClick - Modo somente leitura (desabilita gravacao)
    *============================================================
    PROCEDURE BtnVisualizarClick
        LOCAL loc_cCodigoCli, loc_lRet, loc_oErro
        IF !THIS.ValidarPreAcao("VISUALIZAR")
            RETURN
        ENDIF
        TRY
            loc_cCodigoCli = ""
            IF PEMSTATUS(THIS, "cnt_4c_Conta", 5) AND !ISNULL(THIS.cnt_4c_Conta)
                IF PEMSTATUS(THIS.cnt_4c_Conta, "pgframeDados", 5) AND ;
                   PEMSTATUS(THIS.cnt_4c_Conta.pgframeDados, "pgframeDados1", 5) AND ;
                   PEMSTATUS(THIS.cnt_4c_Conta.pgframeDados.pgframeDados1, "getcodigo", 5)
                    loc_cCodigoCli = ALLTRIM(THIS.cnt_4c_Conta.pgframeDados.pgframeDados1.getcodigo.Value)
                ENDIF
            ENDIF
            IF EMPTY(loc_cCodigoCli)
                loc_cCodigoCli = ALLTRIM(THIS.this_cCli)
            ENDIF

            IF EMPTY(loc_cCodigoCli)
                MsgAviso("Nenhum cliente selecionado para visualiza" + CHR(231) + CHR(227) + "o.")
                RETURN
            ENDIF

            THIS.this_cModoAtual = "VISUALIZAR"
            THIS.pcEscolha       = "VISUALIZAR"

            IF PEMSTATUS(THIS, "cnt_4c_Conta", 5) AND !ISNULL(THIS.cnt_4c_Conta)
                loc_lRet = THIS.ChamarMLeDadosSeguro(THIS.this_cGrupo, PADR(loc_cCodigoCli, 10), "1", ;
                    THIS.this_cTpBloqCar, THIS.this_cMudaCpfCgc)
                IF loc_lRet
                    THIS.cnt_4c_Conta.Visible = .T.
                    THIS.cnt_4c_Conta.Refresh()
                ENDIF
            ENDIF

            *-- Desabilitar botao OK em modo de visualizacao (impede gravacao acidental)
            IF PEMSTATUS(THIS, "cmg_4c_Sair", 5)
                THIS.cmg_4c_Sair.Buttons(1).Enabled = .F.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, ;
                "Erro em BtnVisualizarClick")
        ENDTRY
    ENDPROC

    *============================================================
    * BtnExcluirClick - Confirmar e excluir cliente atual
    *============================================================
    PROCEDURE BtnExcluirClick
        LOCAL loc_cCodigoCli, loc_lConfirma, loc_lSucesso, loc_cSQL, loc_oErro
        IF !THIS.ValidarPreAcao("EXCLUIR")
            RETURN
        ENDIF
        TRY
            loc_cCodigoCli = ""
            IF PEMSTATUS(THIS, "cnt_4c_Conta", 5) AND !ISNULL(THIS.cnt_4c_Conta)
                IF PEMSTATUS(THIS.cnt_4c_Conta, "pgframeDados", 5) AND ;
                   PEMSTATUS(THIS.cnt_4c_Conta.pgframeDados, "pgframeDados1", 5) AND ;
                   PEMSTATUS(THIS.cnt_4c_Conta.pgframeDados.pgframeDados1, "getcodigo", 5)
                    loc_cCodigoCli = ALLTRIM(THIS.cnt_4c_Conta.pgframeDados.pgframeDados1.getcodigo.Value)
                ENDIF
            ENDIF
            IF EMPTY(loc_cCodigoCli)
                loc_cCodigoCli = ALLTRIM(THIS.this_cCli)
            ENDIF

            IF EMPTY(loc_cCodigoCli)
                MsgAviso("Nenhum cliente selecionado para exclus" + CHR(227) + "o.")
                RETURN
            ENDIF

            loc_lConfirma = MsgConfirma("Confirma a exclus" + CHR(227) + "o do cliente " + ;
                loc_cCodigoCli + "?" + CHR(13) + ;
                "Esta opera" + CHR(231) + CHR(227) + "o n" + CHR(227) + "o pode ser desfeita.", ;
                "Exclus" + CHR(227) + "o de Cliente")

            IF !loc_lConfirma
                RETURN
            ENDIF

            *-- Executar exclusao via BO
            THIS.this_oBusinessObject.this_cIclis = loc_cCodigoCli
            loc_lSucesso = THIS.this_oBusinessObject.Excluir()

            IF loc_lSucesso
                THIS.RetCodCliente = " "
                THIS.Release()
            ELSE
                MsgErro("Erro ao excluir o cliente." + CHR(13) + ;
                    THIS.this_oBusinessObject.this_cMensagemErro, ;
                    "Erro na Exclus" + CHR(227) + "o")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, ;
                "Erro em BtnExcluirClick")
        ENDTRY
    ENDPROC

    *============================================================
    * CarregarLista - Recarregar dados do cliente atual via clsconta.mLeDados
    * (este form nao possui grade de listagem - "lista" = estado atual do cliente)
    *============================================================
    PROCEDURE CarregarLista
        LOCAL loc_lRet, loc_oErro
        TRY
            IF PEMSTATUS(THIS, "cnt_4c_Conta", 5) AND !ISNULL(THIS.cnt_4c_Conta)
                loc_lRet = THIS.ChamarMLeDadosSeguro(THIS.this_cGrupo, THIS.this_cCli, "1", ;
                    THIS.this_cTpBloqCar, THIS.this_cMudaCpfCgc)
                IF loc_lRet
                    THIS.cnt_4c_Conta.Visible = .T.
                    THIS.cnt_4c_Conta.Refresh()
                ELSE
                    MsgErro("Erro ao recarregar dados do cliente.", "Erro")
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, ;
                "Erro em CarregarLista")
        ENDTRY
    ENDPROC

    *============================================================
    * AjustarBotoesPorModo - Habilitar/desabilitar botoes conforme modo
    *============================================================
    PROCEDURE AjustarBotoesPorModo
        LOCAL loc_lHabilitaOk
        loc_lHabilitaOk = (THIS.this_cModoAtual = "INCLUIR" OR THIS.this_cModoAtual = "ALTERAR")
        IF PEMSTATUS(THIS, "cmg_4c_Sair", 5)
            THIS.cmg_4c_Sair.Buttons(1).Enabled = loc_lHabilitaOk
        ENDIF
    ENDPROC

    *============================================================
    * HabilitarCampos - Habilitar ou desabilitar campos conforme modo
    * O clsconta gerencia seus campos internamente; aqui so se controla
    * o botao de confirmacao.
    *============================================================
    PROCEDURE HabilitarCampos
        LPARAMETERS par_lHabilitar
        IF PEMSTATUS(THIS, "cmg_4c_Sair", 5)
            THIS.cmg_4c_Sair.Buttons(1).Enabled = IIF(TYPE("par_lHabilitar") = "L", par_lHabilitar, .T.)
        ENDIF
    ENDPROC

    *============================================================
    * LimparCampos - Limpar e reinicializar para novo cliente
    *============================================================
    PROCEDURE LimparCampos
        THIS.this_cCli       = SPACE(10)
        THIS.RetCodCliente   = " "
        THIS.pcEscolha       = "INSERIR"
        THIS.this_cModoAtual = "INCLUIR"
        THIS.plaltcd         = .F.
        THIS.CarregarLista()
    ENDPROC

    *============================================================
    * FormParaBO - Transferencia form -> BO
    * O clsconta (mGravaDados) gerencia transferencia internamente.
    *============================================================
    PROCEDURE FormParaBO
        RETURN .T.
    ENDPROC

    *============================================================
    * BOParaForm - Transferencia BO -> form
    * O clsconta (mLeDados) gerencia transferencia internamente.
    *============================================================
    PROCEDURE BOParaForm
        RETURN .T.
    ENDPROC

    *============================================================
    * BtnSalvarClick - Alias de BtnOkClick (validar e gravar)
    *============================================================
    PROCEDURE BtnSalvarClick
        THIS.BtnOkClick()
    ENDPROC

    *============================================================
    * BtnEncerrarClick - Fechar sem gravar (alias de BtnCancelarClick)
    *============================================================
    PROCEDURE BtnEncerrarClick
        *-- Estado LISTA: fecha form
        *-- Estado DADOS: volta para LISTA (cancela edicao corrente)
        IF THIS.this_cModoAtual == "LISTA"
            THIS.Release()
        ELSE
            THIS.BtnCancelarClick()
            THIS.IrParaLista()
        ENDIF
    ENDPROC

    *============================================================
    * BtnBuscarClick - Abrir busca de cliente para carregar em edicao
    *============================================================
    PROCEDURE BtnBuscarClick
        LOCAL loc_oBusca, loc_cCodigoCli, loc_lSelecionou, loc_oErro
        TRY
            loc_cCodigoCli = ""
            loc_lSelecionou = .F.

            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigCdCli", "cursor_4c_BuscaCli", "IClis", "", ;
                "Sele" + CHR(231) + CHR(227) + "o de Cliente", .T., .T., "")

            IF VARTYPE(loc_oBusca) = "O"
                loc_oBusca.mAddColuna("IClis", "XXXXXXXXXX", "C" + CHR(243) + "digo")
                loc_oBusca.mAddColuna("RClis", "",           "Nome")
                loc_oBusca.Show()

                IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaCli")
                    SELECT cursor_4c_BuscaCli
                    GO TOP IN cursor_4c_BuscaCli
                    IF !EOF("cursor_4c_BuscaCli")
                        loc_cCodigoCli = ALLTRIM(cursor_4c_BuscaCli.IClis)
                    ENDIF
                    USE IN cursor_4c_BuscaCli
                    loc_lSelecionou = !EMPTY(loc_cCodigoCli)
                ENDIF
                loc_oBusca = .NULL.
            ENDIF

            IF loc_lSelecionou
                THIS.this_cCli       = PADR(loc_cCodigoCli, 10)
                THIS.pcEscolha       = "ALTERAR"
                THIS.this_cModoAtual = "ALTERAR"
                THIS.plaltcd         = .T.
                THIS.CarregarLista()
                THIS.AjustarBotoesPorModo()
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, ;
                "Erro em BtnBuscarClick")
        ENDTRY
    ENDPROC

    *============================================================
    PROCEDURE Destroy
    *============================================================
        IF !ISNULL(THIS.this_oBusinessObject)
            THIS.this_oBusinessObject = .NULL.
        ENDIF
        *-- Liberar poDataMgr (fSqlConector) — sem isso conex??o ODBC fica presa
        IF !ISNULL(THIS.poDataMgr) AND VARTYPE(THIS.poDataMgr) = "O"
            TRY
                THIS.poDataMgr.Release()
            CATCH
            ENDTRY
            THIS.poDataMgr = .NULL.
        ENDIF
        DODEFAULT()
    ENDPROC

ENDDEFINE

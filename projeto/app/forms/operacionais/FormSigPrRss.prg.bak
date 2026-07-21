*==============================================================================
* FormSigPrRss.prg - Rec" + CHR(225) + "lculo de Saldos (SIGPRRSS)
* Tipo: OPERACIONAL - processamento de fila SigOpCls (recalculo de saldos)
* Migrado de: SigPrRss.SCX
* Gerado: 2026-07-18
*==============================================================================

DEFINE CLASS FormSigPrRss AS FormBase

    *-- Dimensoes (baseadas no original SIGPRRSS)
    Height       = 120
    Width        = 580
    Caption      = "Rec" + CHR(225) + "lculo de Saldos"
    AutoCenter   = .T.
    TitleBar     = 0
    ShowWindow = 1
    ControlBox   = .F.
    MaxButton    = .F.
    MinButton    = .F.
    BorderStyle  = 2
    DataSession  = 2
    WindowType   = 1
    ShowTips     = .T.
    Themes       = .F.

    *-- Business Object e estado
    this_oBusinessObject = .NULL.
    this_cMensagemErro   = ""

    *-- Parametros de execucao (mapeados do legado)
    this_lParametrizado = .F.       && .T. se iniciado via linha de comando (batch)
    this_cUsuario       = "          "  && Filtro de usuario (10 espacos = todos)
    this_lOnline        = .F.       && Modo online (processa apenas Onlines=1)
    this_lProcessando   = .F.       && .T. durante o loop de processamento
    this_lErroConexao   = .F.       && .T. se houve queda de conexao com BD

    *==========================================================================
    PROCEDURE Init(par_pParam, par_pUsuario, par_pOnLine)
    *==========================================================================
        *-- DataSession=2 reseta SET DATE/CENTURY (regra 9.4)
        SET DATE TO BRITISH
        SET CENTURY ON

        *-- Capturar parametros antes de DODEFAULT
        THIS.this_lParametrizado = (TYPE("par_pParam")   = "C")
        THIS.this_cUsuario       = IIF(TYPE("par_pUsuario") = "C", par_pUsuario, SPACE(10))
        THIS.this_lOnline        = (TYPE("par_pOnLine")   = "L" AND par_pOnLine)

        *-- DODEFAULT() chama FormBase.Init() -> InicializarForm()
        RETURN DODEFAULT()
    ENDPROC

    *==========================================================================
    PROTECTED PROCEDURE InicializarForm
    *==========================================================================
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        TRY
            THIS.this_oBusinessObject = CREATEOBJECT("SigPrRssBO")
            IF VARTYPE(THIS.this_oBusinessObject) # "O"
                MsgErro("Erro ao criar objeto de neg" + CHR(243) + "cio SigPrRssBO.", "Erro")
            ELSE
                *-- Background do form (como no original)
                THIS.Picture = gc_4c_CaminhoBase + "..\..\..\Framework\imagens\new_background.jpg"

                *-- Montar interface visual (form OPERACIONAL: layout direto no form, sem PageFrame)
                THIS.ConfigurarPageFrame()
                THIS.TornarControlesVisiveis()

                *-- Sincronizar caption das labels com o titulo do form
                THIS.cnt_4c_Sombra.lbl_4c_Sombra.Caption = THIS.Caption
                THIS.cnt_4c_Sombra.lbl_4c_Titulo.Caption = THIS.Caption

                IF THIS.this_lParametrizado
                    THIS.IniciarLogProcessamento()
                ENDIF

                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
                " PROC=" + loc_oErro.Procedure, "Erro FormSigPrRss.InicializarForm")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * ConfigurarPageFrame - Entry point de layout do form OPERACIONAL
    * Form OPERACIONAL nao usa PageFrame (dialog 580x120 com controles diretos)
    * Metodo mantido para consistencia com pipeline de migracao e centraliza
    * chamadas de setup visual do form.
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPageFrame
        THIS.ConfigurarCabecalho()
        THIS.ConfigurarBotoes()
        THIS.ConfigurarStatusLabel()
    ENDPROC

    *==========================================================================
    * ConfigurarCabecalho - Container escuro com titulo (cntSombra original)
    * Padrao correto: AddObject fora do WITH para evitar WITH aninhado (Erro47)
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarCabecalho
        THIS.AddObject("cnt_4c_Sombra", "Container")
        WITH THIS.cnt_4c_Sombra
            .Visible     = .T.
            .Top         = 0
            .Left        = 0
            .Width       = THIS.Width
            .Height      = 80
            .BorderWidth = 0
            .BackColor   = RGB(100,100,100)
        ENDWITH

        THIS.cnt_4c_Sombra.AddObject("lbl_4c_Sombra", "Label")
        WITH THIS.cnt_4c_Sombra.lbl_4c_Sombra
            .Visible       = .T.
            .Top           = 18
            .Left          = 10
            .Width         = THIS.Width
            .Height        = 40
            .Caption       = THIS.Caption
            .FontBold      = .T.
            .FontName      = "Tahoma"
            .FontSize      = 18
            .FontUnderline = .F.
            .WordWrap      = .T.
            .Alignment     = 0
            .AutoSize      = .F.
            .BackStyle     = 0
            .ForeColor     = RGB(0,0,0)
        ENDWITH

        THIS.cnt_4c_Sombra.AddObject("lbl_4c_Titulo", "Label")
        WITH THIS.cnt_4c_Sombra.lbl_4c_Titulo
            .Visible    = .T.
            .Top        = 17
            .Left       = 10
            .Width      = THIS.Width
            .Height     = 46
            .Caption    = THIS.Caption
            .FontBold   = .T.
            .FontName   = "Tahoma"
            .FontSize   = 18
            .WordWrap   = .T.
            .Alignment  = 0
            .AutoSize   = .F.
            .BackStyle  = 0
            .ForeColor  = RGB(255,255,255)
        ENDWITH
    ENDPROC

    *==========================================================================
    * ConfigurarBotoes - Botoes Processar (OK) e Encerrar (SAIR) + Shape decorativo
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarBotoes
        *-- Shape decorativo (Shape1: Top=7, Left=478, Width=90, Height=27)
        THIS.AddObject("shp_4c_Shape1", "Shape")
        WITH THIS.shp_4c_Shape1
            .Top         = 7
            .Left        = 478
            .Height      = 27
            .Width       = 90
            .BackStyle   = 0
            .BorderStyle = 0
            .BorderColor = RGB(136,189,188)
        ENDWITH

        *-- Botao Processar (OK no legado: Left=430, Top=3, 75x75)
        *-- Themes=.T. + DisabledPicture: necessario para standalone com Enabled=.F. (regra #99)
        THIS.AddObject("cmd_4c_Processar", "CommandButton")
        WITH THIS.cmd_4c_Processar
            .Top             = 3
            .Left            = 430
            .Width           = 75
            .Height          = 75
            .Caption         = "Processar"
            .FontName        = "Tahoma"
            .FontSize        = 8
            .FontBold        = .T.
            .FontItalic      = .T.
            .ForeColor       = RGB(90,90,90)
            .BackColor       = RGB(255,255,255)
            .Themes          = .T.
            .SpecialEffect   = 0
            .PicturePosition = 13
            .WordWrap        = .T.
            .AutoSize        = .F.
            .MousePointer    = 15
            .Picture         = gc_4c_CaminhoIcones + "geral_processar_60.jpg"
            .DisabledPicture = gc_4c_CaminhoIcones + "geral_processar_60.jpg"
            .ToolTipText     = ""
        ENDWITH
        BINDEVENT(THIS.cmd_4c_Processar, "Click", THIS, "BtnProcessarClick")

        *-- Botao Encerrar (SAIR no legado: Left=505, Top=3, 75x75)
        THIS.AddObject("cmd_4c_Encerrar", "CommandButton")
        WITH THIS.cmd_4c_Encerrar
            .Top             = 3
            .Left            = 505
            .Width           = 75
            .Height          = 75
            .Caption         = "Encerrar"
            .FontName        = "Tahoma"
            .FontSize        = 8
            .FontBold        = .T.
            .FontItalic      = .T.
            .ForeColor       = RGB(90,90,90)
            .BackColor       = RGB(255,255,255)
            .Themes           = .T.
            .SpecialEffect   = 0
            .PicturePosition = 13
            .WordWrap        = .T.
            .AutoSize        = .F.
            .MousePointer    = 15
            .Cancel          = .T.
            .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
            .ToolTipText     = "[ESC] Sair"
        ENDWITH
        BINDEVENT(THIS.cmd_4c_Encerrar, "Click", THIS, "BtnEncerrarClick")
    ENDPROC

    *==========================================================================
    * ConfigurarStatusLabel - Label de progresso (Label1 original: Top=94, Left=135)
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarStatusLabel
        THIS.AddObject("lbl_4c_Status", "Label")
        WITH THIS.lbl_4c_Status
            .Visible   = .T.
            .Top       = 94
            .Left      = 135
            .Width     = 309
            .Height    = 20
            .Caption   = ""
            .FontBold  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90,90,90)
        ENDWITH
    ENDPROC

    *==========================================================================
    * TornarControlesVisiveis - Torna todos controles do form e sub-containers visiveis
    *==========================================================================
    PROTECTED PROCEDURE TornarControlesVisiveis
        LOCAL loc_i, loc_j, loc_oControl, loc_oSub
        LOCAL loc_nCount, loc_nSubCount
        loc_nCount = THIS.ControlCount
        FOR loc_i = 1 TO loc_nCount
            loc_oControl = THIS.Controls(loc_i)
            IF VARTYPE(loc_oControl) = "O"
                IF PEMSTATUS(loc_oControl, "Visible", 5)
                    loc_oControl.Visible = .T.
                ENDIF
                IF PEMSTATUS(loc_oControl, "ControlCount", 5) AND loc_oControl.ControlCount > 0
                    loc_nSubCount = loc_oControl.ControlCount
                    FOR loc_j = 1 TO loc_nSubCount
                        loc_oSub = loc_oControl.Controls(loc_j)
                        IF VARTYPE(loc_oSub) = "O" AND PEMSTATUS(loc_oSub, "Visible", 5)
                            loc_oSub.Visible = .T.
                        ENDIF
                    ENDFOR
                ENDIF
            ENDIF
        ENDFOR
    ENDPROC

    *==========================================================================
    * Activate - Se modo batch, inicia processamento automaticamente
    *==========================================================================
    PROCEDURE Activate
        DODEFAULT()
        IF THIS.this_lParametrizado
            THIS.BtnProcessarClick()
        ENDIF
    ENDPROC

    *==========================================================================
    * BtnProcessarClick - Loop principal de recalculo de saldos
    * Migrado de: SIGPRRSS.OK.Click (157 linhas)
    *==========================================================================
    PROCEDURE BtnProcessarClick
        LOCAL loc_lOk, loc_lErroCnx, loc_nMov, loc_oBO
        LOCAL loc_nKey, loc_nErr, loc_cOldErr, loc_lQuit
        loc_oBO      = THIS.this_oBusinessObject
        loc_lErroCnx = .F.
        loc_nMov     = 1

        THIS.cmd_4c_Processar.Enabled = .F.
        THIS.this_lProcessando = .T.

        DO WHILE .T.
            THIS.cmd_4c_Encerrar.Enabled = .F.

            THIS.lbl_4c_Status.Caption = "Aguardando Contas Para Processar" + ;
                REPLICATE(".", loc_nMov)
            loc_nMov = IIF(loc_nMov < 5, loc_nMov + 1, 1)
            THIS.lbl_4c_Status.Refresh()

            *-- Buscar registros em fila SigOpCls
            loc_lOk = loc_oBO.BuscarNaFila(ALLTRIM(THIS.this_cUsuario), THIS.this_lOnline)

            IF !loc_lOk
                loc_lErroCnx = .T.
            ELSE
                SELECT CrSigOpCls
                SCAN
                    *-- Marcar registro em processamento (lock otimista)
                    IF !loc_oBO.MarcarProcessando(CrSigOpCls.CidChaves)
                        *-- Verificar se e queda de conexao
                        IF SQLEXEC(gnConnHandle, "SELECT 1 AS Chk") < 0
                            EXIT
                        ENDIF
                        LOOP
                    ENDIF

                    IF USED("crRecalculaS")
                        USE IN crRecalculaS
                    ENDIF

                    *-- Recalcular saldo do lancamento
                    loc_lOk = loc_oBO.RecalcularSaldo(CrSigOpCls.Grupos, ;
                        CrSigOpCls.Contas, CrSigOpCls.Datas, CrSigOpCls.Moedas)
                    IF !loc_lOk
                        LOOP
                    ENDIF

                    *-- Finalizar recalculo (segunda chamada fRecalculaS)
                    loc_lOk = loc_oBO.FinalizarRecalculo()
                    IF !loc_lOk
                        LOOP
                    ENDIF

                    *-- Verificar impeditivos de movimento (SigMvSlc/SigMvCcr)
                    IF !loc_oBO.VerificarMovimentos(CrSigOpCls.GruConMoes)
                        LOOP
                    ENDIF

                    *-- Gravar historico em SigPrSlS e remover da fila SigOpCls
                    loc_lOk = loc_oBO.GravarHistorico(CrSigOpCls.CidChaves, ;
                        CrSigOpCls.Grupos, CrSigOpCls.Contas, CrSigOpCls.Datas, ;
                        CrSigOpCls.Moedas, CrSigOpCls.GruConMoes, ;
                        CrSigOpCls.Onlines, CrSigOpCls.Usuars)

                    IF loc_lOk
                        loc_lOk = loc_oBO.DeletarDaFila(CrSigOpCls.CidChaves)
                    ENDIF

                    SELECT CrSigOpCls
                ENDSCAN
            ENDIF

            THIS.cmd_4c_Encerrar.Enabled = .T.

            *-- Aguardar 0.5s e capturar tecla pressionada
            loc_nErr    = 0
            loc_cOldErr = ON("ERROR")
            ON ERROR loc_nErr = 1
            loc_nKey = INKEY(0.5, "M")
            IF loc_nErr != 0
                loc_nKey = 0
            ENDIF
            ON ERROR &loc_cOldErr.

            *-- Verificar condicoes de saida do loop
            IF !THIS.this_lParametrizado OR loc_nKey = 27 OR loc_lErroCnx OR THIS.this_lOnline
                EXIT
            ENDIF
        ENDDO

        THIS.lbl_4c_Status.Caption = ""
        THIS.cmd_4c_Processar.Enabled = .T.
        THIS.this_lProcessando = .F.

        *-- Finalizacao em modo batch
        IF THIS.this_lParametrizado
            THIS.FinalizarLogProcessamento()
            loc_lQuit = EMPTY(ALLTRIM(THIS.this_cUsuario)) AND !THIS.this_lOnline
            THIS.Release()
            IF loc_lQuit
                QUIT
            ENDIF
        ENDIF
    ENDPROC

    *==========================================================================
    * BtnEncerrarClick - Fecha o formulario
    *==========================================================================
    PROCEDURE BtnEncerrarClick
        THIS.Release()
    ENDPROC

    *==========================================================================
    * IniciarLogProcessamento - Cabecalho do log Fortyus.Log (modo batch)
    *==========================================================================
    PROTECTED PROCEDURE IniciarLogProcessamento
        LOCAL loc_cArq, loc_cLinha
        loc_cArq = "Fortyus.Log"
        STRTOFILE("", loc_cArq, .T.)
        loc_cLinha = REPLICATE("=", 80)
        STRTOFILE(loc_cLinha + CHR(10), loc_cArq, .T.)
        loc_cLinha = "Iniciando o Processamento : Fortyus.Exe (SigOpClS) - Rec" + ;
            CHR(225) + "lculo de Saldos"
        STRTOFILE(loc_cLinha + CHR(10), loc_cArq, .T.)
        loc_cLinha = "Data : " + DTOC(DATE()) + " - Hora : " + TIME()
        STRTOFILE(loc_cLinha + CHR(10), loc_cArq, .T.)
        loc_cLinha = REPLICATE("=", 80)
        STRTOFILE(loc_cLinha + CHR(10), loc_cArq, .T.)
    ENDPROC

    *==========================================================================
    * FinalizarLogProcessamento - Rodape do log Fortyus.Log (modo batch)
    *==========================================================================
    PROTECTED PROCEDURE FinalizarLogProcessamento
        LOCAL loc_cArq, loc_cLinha
        loc_cArq = "Fortyus.Log"
        STRTOFILE("", loc_cArq, .T.)
        loc_cLinha = REPLICATE("=", 80)
        STRTOFILE(loc_cLinha + CHR(10), loc_cArq, .T.)
        loc_cLinha = "Concluindo o Processamento : Fortyus.Exe (SigOpClS) - Rec" + ;
            CHR(225) + "lculo de Saldos"
        STRTOFILE(loc_cLinha + CHR(10), loc_cArq, .T.)
        loc_cLinha = "Data : " + DTOC(DATE()) + " - Hora : " + TIME()
        STRTOFILE(loc_cLinha + CHR(10), loc_cArq, .T.)
        loc_cLinha = REPLICATE("=", 80)
        STRTOFILE(loc_cLinha + CHR(10), loc_cArq, .T.)
    ENDPROC

    *==========================================================================
    * ConfigurarPaginaLista - No-op semantico para form OPERACIONAL
    * Este dialog (580x120) nao tem PageFrame/Grid/CRUD. O layout eh direto no
    * form (cabecalho + botao Processar + botao Encerrar + label status), ja
    * montado por ConfigurarPageFrame(). Metodo mantido para compatibilidade
    * com a validacao do pipeline (fase 4 checa presenca do simbolo).
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPaginaLista
        *-- Form OPERACIONAL: sem Page1/Lista. Setup ja feito em ConfigurarPageFrame().
        RETURN .T.
    ENDPROC

    *==========================================================================
    * ConfigurarPaginaDados - No-op semantico para form OPERACIONAL
    * Este dialog (580x120) nao tem Page2/Dados. Nao ha campos de entrada
    * a adicionar - todos os controles (cabecalho, botoes, label de status)
    * ja foram montados em ConfigurarPageFrame() nas fases anteriores.
    * Metodo mantido para compatibilidade com a validacao do pipeline (fase 5).
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPaginaDados
        *-- Form OPERACIONAL: sem Page2/Dados. Setup ja feito em ConfigurarPageFrame().
        RETURN .T.
    ENDPROC

    *==========================================================================
    * AlternarPagina - No-op semantico para form OPERACIONAL
    * Este dialog tem estado unico (nao alterna entre LISTA/DADOS). A logica
    * de fluxo eh controlada por this_lProcessando (habilitando/desabilitando
    * cmd_4c_Processar e cmd_4c_Encerrar dentro de BtnProcessarClick).
    *==========================================================================
    PROTECTED PROCEDURE AlternarPagina(par_nPagina)
        *-- Form OPERACIONAL: pagina unica, nenhuma alternancia necessaria.
        RETURN .T.
    ENDPROC

    *==========================================================================
    * BtnIncluirClick - No-op semantico para form OPERACIONAL
    * Este dialog de processamento em fila nao tem operacao de inclusao de
    * registros pelo usuario. Registros em SigOpCls sao inseridos pelo
    * sistema automaticamente. Metodo presente para compatibilidade com o
    * pipeline de validacao de fases.
    *==========================================================================
    PROCEDURE BtnIncluirClick
        *-- Form OPERACIONAL: inclusao gerenciada pelo sistema (fila SigOpCls).
        RETURN .T.
    ENDPROC

    *==========================================================================
    * BtnAlterarClick - No-op semantico para form OPERACIONAL
    * Este dialog executa processamento de fila; nao ha edicao manual de
    * registros. Metodo presente para compatibilidade com o pipeline de
    * validacao de fases.
    *==========================================================================
    PROCEDURE BtnAlterarClick
        *-- Form OPERACIONAL: sem edicao manual de registros.
        RETURN .T.
    ENDPROC

    *==========================================================================
    * BtnVisualizarClick - No-op semantico para form OPERACIONAL
    * Este dialog nao tem modo de visualizacao individual de registro.
    * O status do processamento e exibido em lbl_4c_Status em tempo real.
    * Metodo presente para compatibilidade com o pipeline de validacao de fases.
    *==========================================================================
    PROCEDURE BtnVisualizarClick
        *-- Form OPERACIONAL: status de processamento exibido via lbl_4c_Status.
        RETURN .T.
    ENDPROC

    *==========================================================================
    * BtnExcluirClick - No-op semantico para form OPERACIONAL
    * Registros sao removidos de SigOpCls automaticamente pelo
    * BtnProcessarClick apos processamento bem-sucedido (via DeletarDaFila).
    * Nao ha exclusao manual pelo usuario. Metodo presente para compatibilidade
    * com o pipeline de validacao de fases.
    *==========================================================================
    PROCEDURE BtnExcluirClick
        *-- Form OPERACIONAL: exclusao de fila feita automaticamente em BtnProcessarClick.
        RETURN .T.
    ENDPROC

    *==========================================================================
    * CarregarLista - Sem-op semantico para form OPERACIONAL
    * Este dialog nao tem grid/lista de registros. O estado da fila e
    * consultado em tempo real durante BtnProcessarClick via BuscarNaFila.
    *==========================================================================
    PROCEDURE CarregarLista
        RETURN .T.
    ENDPROC

    *==========================================================================
    * FormParaBO - Propaga parametros de execucao do form para o BO
    * Este dialog nao tem campos de entrada CRUD. Os parametros de execucao
    * (usuario, online, parametrizado) sao propagados para o BO.
    *==========================================================================
    PROTECTED PROCEDURE FormParaBO
        IF VARTYPE(THIS.this_oBusinessObject) # "O"
            RETURN .F.
        ENDIF
        WITH THIS.this_oBusinessObject
            .this_lParametrizado = THIS.this_lParametrizado
            .this_cUsuario       = THIS.this_cUsuario
            .this_lOnline        = THIS.this_lOnline
            .this_lProcessando   = THIS.this_lProcessando
        ENDWITH
        RETURN .T.
    ENDPROC

    *==========================================================================
    * BOParaForm - Sincroniza estado do BO de volta para o form
    * Atualiza estado de processamento exibido no form conforme BO.
    *==========================================================================
    PROTECTED PROCEDURE BOParaForm
        IF VARTYPE(THIS.this_oBusinessObject) # "O"
            RETURN .F.
        ENDIF
        THIS.this_lProcessando = THIS.this_oBusinessObject.this_lProcessando
        THIS.this_lErroConexao = THIS.this_oBusinessObject.this_lErroConexao
        RETURN .T.
    ENDPROC

    *==========================================================================
    * HabilitarCampos - Habilita/desabilita controles conforme estado
    * par_lHabilitar: .T. = habilitado (aguardando), .F. = processando
    *==========================================================================
    PROTECTED PROCEDURE HabilitarCampos(par_lHabilitar)
        IF PEMSTATUS(THIS, "cmd_4c_Processar", 5)
            THIS.cmd_4c_Processar.Enabled = par_lHabilitar
        ENDIF
        IF PEMSTATUS(THIS, "cmd_4c_Encerrar", 5)
            THIS.cmd_4c_Encerrar.Enabled  = par_lHabilitar
        ENDIF
    ENDPROC

    *==========================================================================
    * LimparCampos - Limpa o label de status
    *==========================================================================
    PROTECTED PROCEDURE LimparCampos
        IF PEMSTATUS(THIS, "lbl_4c_Status", 5)
            THIS.lbl_4c_Status.Caption = ""
        ENDIF
    ENDPROC

    *==========================================================================
    * AjustarBotoesPorModo - Ajusta botoes conforme estado de processamento
    * Chamado antes de iniciar e apos concluir BtnProcessarClick.
    *==========================================================================
    PROTECTED PROCEDURE AjustarBotoesPorModo
        LOCAL loc_lHabilitar
        loc_lHabilitar = !THIS.this_lProcessando
        THIS.HabilitarCampos(loc_lHabilitar)
    ENDPROC

    *==========================================================================
    * BtnBuscarClick - Sem-op semantico para form OPERACIONAL
    * Busca/consulta de fila feita internamente por BtnProcessarClick.
    *==========================================================================
    PROCEDURE BtnBuscarClick
        RETURN .T.
    ENDPROC

    *==========================================================================
    * BtnSalvarClick - Sem-op semantico para form OPERACIONAL
    * Nao ha operacao de salvar manual; gravacao e feita por GravarHistorico.
    *==========================================================================
    PROCEDURE BtnSalvarClick
        RETURN .T.
    ENDPROC

    *==========================================================================
    * BtnCancelarClick - Sem-op semantico para form OPERACIONAL
    * Nao ha edicao de campos a cancelar; o botao Encerrar fecha o dialog.
    *==========================================================================
    PROCEDURE BtnCancelarClick
        RETURN .T.
    ENDPROC

    *==========================================================================
    PROCEDURE Destroy
    *==========================================================================
        IF VARTYPE(THIS.this_oBusinessObject) = "O"
            THIS.this_oBusinessObject = .NULL.
        ENDIF
        IF USED("CrSigOpCls")
            USE IN CrSigOpCls
        ENDIF
        IF USED("crRecalculaS")
            USE IN crRecalculaS
        ENDIF
        IF USED("TmpSccr")
            USE IN TmpSccr
        ENDIF
        IF USED("TmpMccr")
            USE IN TmpMccr
        ENDIF
        IF USED("CrSigPrSlS")
            USE IN CrSigPrSlS
        ENDIF
        DODEFAULT()
    ENDPROC

ENDDEFINE

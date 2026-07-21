# CORRIGIR ERRO DE RUNTIME VFP9

## TAREFA OBRIGATORIA
O formulario VFP9 apresentou erro de runtime durante teste automatizado.
Voce DEVE corrigir o erro e salvar os arquivos corrigidos usando Write tool.

## ERRO DETECTADO
- Etapa: 05d_validarCompletude
- Tentativa: 1/10
- Mensagem: Validacao de completude falhou. Procedures vazias/TODOs encontrados:
[SigPrRsaBO.prg] Indicador de pendencia: *            para cada produto pendente
[SigPrRsaBO.prg] Indicador de pendencia: *-- Segunda chamada: consolida saldos pendente
[FormSigPrRsa.prg] Procedure vazia (sem codigo): BtnBuscarClick
[FormSigPrRsa.prg] Procedure vazia (sem codigo): BtnSalvarClick
[FormSigPrRsa.prg] Procedure vazia (sem codigo): BtnCancelarClick
[FormSigPrRsa.prg] Procedure vazia (sem codigo): AjustarBotoesPorModo
[FormSigPrRsa.prg] Indicador de pendencia: * Modo parametrizado: campo bloqueado independente

IMPORTANTE: Preencha TODAS as procedures vazias com codigo funcional REAL. NAO use TODO, FIXME, PLACEHOLDER ou comentarios de pendencia. Cada procedure deve ter implementacao completa.

## CONTEXTO DO ERRO


## ERROS COMUNS E SOLUCOES (Consultar CLAUDE.md)
- "Property PAGE1 is not found" -> Definir .PageCount ANTES de acessar .Page1
- "Property BACKCOLOR is not found" em PageFrame -> Remover BackColor do PageFrame, usar Page1.BackColor
- "RETURN/RETRY not allowed in TRY/CATCH" -> Usar variavel loc_lResultado e RETURN fora do TRY
- "Property ALLOWDELETE is not found" -> Grid VFP9 nao tem AllowDelete/AllowEdit/AllowAddNew
- "Property VISIBLE is not found" em Page -> Pages NAO tem .Visible, apenas PageFrame tem
- "Property ERASEPAGE is not found" -> PageFrame NAO tem ErasePage
- "Unknown member BUTTON1" -> OptionGroup: usar .Buttons(1) ao inves de .Button1
- "Property FONTNAME is not found" em OptionGroup -> OptionGroup NAO tem FontName/FontSize, definir nas Buttons(N)
- "Property FONTNAME is not found" em Grid -> SetAll("FontName",...,"Column") invalido, usar Grid.FontName diretamente
- "Alias XXX is not found" -> Criar cursor ANTES de definir ControlSource
- "Property THIS_CNOMETABELA is not found" -> Usar this_cTabela (nao this_cNomeTabela)
- "Property OBTERTODOS is not found" -> Usar Buscar("") (nao ObterTodos)
- "Property RELEASE is not found" -> Custom/BO NAO tem Release(), usar = .NULL.
- "Function argument value, type, or count is invalid" em FormParaBO -> Se TextBox.Value ja eh numerico, NAO usar VAL()
- "Unknown member PAGE1" apos WITH PageFrame -> Mover config das Pages para FORA do WITH block
- "PAGE1" ou "COLUMN1" apos .Name -> NUNCA usar .Name em Pages ou Columns (rename quebra TODAS as referencias .Page1/.Column1 no resto do codigo)
- BINDEVENT nao funciona -> Metodo deve ser PUBLIC (sem PROTECTED)
- "Incorrect syntax near" em SQL com EscaparSQL/FormatarDataSQL -> Estas funcoes JA INCLUEM aspas. NUNCA adicionar aspas extras: usar campo = " + EscaparSQL(val), NAO campo = '" + EscaparSQL(val) + "'"
- TIMEOUT sem mensagem de erro visivel -> Provavelmente dialog modal de erro travando VFP

## REGRAS OBRIGATORIAS
- Corrigir APENAS o erro indicado, NAO alterar logica de negocio
- NAO remover campos, funcionalidades ou lookups
- NAO alterar nomes de tabelas/colunas do banco (PILAR 2)
- Manter nomenclatura padronizada _4c_ (PILAR 3)
- Strings SQL longas DEVEM ser quebradas com `+;` (continuation) a cada 3-4 campos - NUNCA numa unica linha
- Usar Write tool para salvar os arquivos corrigidos nos mesmos caminhos

## CODIGO ATUAL DOS ARQUIVOS

### FORM (C:\4c\projeto\app\forms\operacionais\FormSigPrRsa.prg):
*==============================================================================
* FormSigPrRsa.prg - Rec CHR(225) lculo de Saldos de Produto
* Form OPERACIONAL - layout plano sem PageFrame (SIGPRRSA.SCX do legado)
* Uso interativo  : CREATEOBJECT("FormSigPrRsa").Show()
* Uso parametrizado: CREATEOBJECT("FormSigPrRsa", cParam, nPrior).Show()
*==============================================================================

DEFINE CLASS FormSigPrRsa AS FormBase

    *-- Parametros de execucao (populados em Init antes de DODEFAULT)
    this_cMensagemErro = ""
    this_lParametrizado = .F.    && .T. = chamado por Fortyus.Exe (batch)
    this_nPrioridade    = 0      && Filtro de prioridade: 0 ou 1
    this_lParar         = .F.    && Flag para interromper o loop de processamento

    *-- Propriedades visuais (PILAR 1 - identico ao legado SIGPRRSA)
    Width        = 580
    Height       = 200
    AutoCenter   = .T.
    BorderStyle  = 2
    Caption      = "Recalculo de Saldos de Produto"
    ShowTips     = .T.
    ShowWindow = 1
    ControlBox   = .F.
    MaxButton    = .F.
    MinButton    = .F.
    TitleBar     = 0
    WindowType   = 1
    DataSession  = 2

    *--------------------------------------------------------------------------
    * Init - Armazena parametros ANTES de DODEFAULT (que chama InicializarForm)
    *--------------------------------------------------------------------------
    PROCEDURE Init(par_cParam, par_nPrior)
        THIS.Caption             = "Rec" + CHR(225) + "lculo de Saldos de Produto"
        THIS.this_lParametrizado = (TYPE("par_cParam") = "C")
        THIS.this_nPrioridade    = IIF(TYPE("par_nPrior") = "N", par_nPrior, 0)
        RETURN DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    * Activate - Modo parametrizado: dispara processamento automaticamente
    *--------------------------------------------------------------------------
    PROCEDURE Activate()
        IF THIS.this_lParametrizado
            THIS.BtnProcessarClick()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPageFrame - Aparencia base do form OPERACIONAL (sem PageFrame)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPageFrame()
        THIS.BackColor  = RGB(212, 208, 200)
        THIS.ScrollBars = 0
        THIS.Picture    = gc_4c_CaminhoIcones + "new_background.jpg"
    ENDPROC

    *--------------------------------------------------------------------------
    * InicializarForm - Cria BO e constroi estrutura base do form
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            THIS.this_oBusinessObject = CREATEOBJECT("SigPrRsaBO")

            IF VARTYPE(THIS.this_oBusinessObject) = "O"
                THIS.this_oBusinessObject.this_nPrioridade    = THIS.this_nPrioridade
                THIS.this_oBusinessObject.this_lParametrizado = THIS.this_lParametrizado

                THIS.ConfigurarPageFrame()
                THIS.ConfigurarCabecalho()
                THIS.ConfigurarPaginaLista()
                THIS.ConfigurarPaginaDados()

                IF THIS.this_lParametrizado
                    THIS.this_oBusinessObject.IniciarLog( ;
                        "Iniciando o Processamento : Fortyus.Exe (SigOpClS) - Recalculo de Saldos")
                ENDIF

                loc_lSucesso = .T.
            ELSE
                THIS.this_cMensagemErro = "Erro ao criar SigPrRsaBO."
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarCabecalho - Container de titulo superior (cntSombra do legado)
    * AddObject FORA de WITH, depois WITH caminho explicito (anti-ghost props)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarCabecalho()
        THIS.AddObject("cnt_4c_Cabecalho", "Container")
        WITH THIS.cnt_4c_Cabecalho
            .Top         = 0
            .Left        = 0
            .Width       = THIS.Width
            .Height      = 80
            .BackColor   = RGB(100, 100, 100)
            .BackStyle   = 1
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH

        THIS.cnt_4c_Cabecalho.AddObject("lbl_4c_Sombra", "Label")
        WITH THIS.cnt_4c_Cabecalho.lbl_4c_Sombra
            .AutoSize  = .F.
            .BackStyle = 0
            .Caption   = THIS.Caption
            .FontBold  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 18
            .ForeColor = RGB(0, 0, 0)
            .Height    = 40
            .Left      = 10
            .Top       = 18
            .Width     = THIS.cnt_4c_Cabecalho.Width
            .WordWrap  = .T.
            .Visible   = .T.
        ENDWITH

        THIS.cnt_4c_Cabecalho.AddObject("lbl_4c_Titulo", "Label")
        WITH THIS.cnt_4c_Cabecalho.lbl_4c_Titulo
            .AutoSize    = .F.
            .BackStyle   = 0
            .Caption     = THIS.Caption
            .FontBold    = .T.
            .FontName    = "Tahoma"
            .FontSize    = 18
            .ForeColor   = RGB(255, 255, 255)
            .Height      = 46
            .Left        = 10
            .Top         = 17
            .Width       = THIS.cnt_4c_Cabecalho.Width
            .WordWrap    = .T.
            .ToolTipText = "T" + CHR(237) + "tulo do Relat" + CHR(243) + "rio"
            .Visible     = .T.
        ENDWITH

        THIS.cnt_4c_Cabecalho.Visible = .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPaginaLista - Agrupa controles da area operacional (fase 4)
    * Form OPERACIONAL SIGPRRSA nao tem PageFrame/Grid/CRUD; aqui montamos
    * botoes Processar/Encerrar + label de progresso + campo de prioridade
    * (equivalente estrutural a "Page1" dos forms CRUD).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPaginaLista()
        THIS.ConfigurarBotoes()
        THIS.ConfigurarLabelProgresso()
        THIS.ConfigurarCampoPrioridade()
    ENDPROC

    *--------------------------------------------------------------------------
    * AlternarPagina - Compatibilidade com contrato dos forms CRUD.
    * Form OPERACIONAL nao tem PageFrame, entao nao ha alternancia de paginas:
    * ao ser invocada, garante foco no campo de prioridade (unico input).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE AlternarPagina(par_nPagina)
        IF TYPE("THIS.txt_4c_Prioridade") = "O" AND !THIS.this_lParametrizado
            THIS.txt_4c_Prioridade.SetFocus()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarBotoes - Botoes Processar e Encerrar sobrepostos ao cabecalho
    * Standalone com Picture: Themes=.T. + DisabledPicture obrigatorio
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarBotoes()
        THIS.AddObject("cmd_4c_Processar", "CommandButton")
        WITH THIS.cmd_4c_Processar
            .Top             = 3
            .Left            = 430
            .Height          = 75
            .Width           = 75
            .Caption         = "Processar"
            .FontBold        = .T.
            .FontItalic      = .T.
            .FontName        = "Comic Sans MS"
            .FontSize        = 8
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .Picture         = gc_4c_CaminhoIcones + "geral_processar_60.jpg"
            .Themes          = .T.
            .DisabledPicture = gc_4c_CaminhoIcones + "geral_processar_60.jpg"
            .ToolTipText     = "Processar"
            .TabIndex        = 2
            .Cancel          = .F.
            .Visible         = .T.
        ENDWITH

        THIS.AddObject("cmd_4c_Encerrar", "CommandButton")
        WITH THIS.cmd_4c_Encerrar
            .Top             = 3
            .Left            = 505
            .Height          = 75
            .Width           = 75
            .Caption         = "Encerrar"
            .FontBold        = .T.
            .FontItalic      = .T.
            .FontName        = "Comic Sans MS"
            .FontSize        = 8
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
            .Themes          = .T.
            .DisabledPicture = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
            .ToolTipText     = "[ESC] Sair"
            .TabIndex        = 3
            .Cancel          = .T.
            .Visible         = .T.
        ENDWITH

        BINDEVENT(THIS.cmd_4c_Processar, "Click", THIS, "BtnProcessarClick")
        BINDEVENT(THIS.cmd_4c_Encerrar,  "Click", THIS, "BtnEncerrarClick")
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarLabelProgresso - Label1 do legado: status do processamento
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarLabelProgresso()
        THIS.AddObject("lbl_4c_Progresso", "Label")
        WITH THIS.lbl_4c_Progresso
            .AutoSize    = .F.
            .BackStyle   = 0
            .BackColor   = RGB(255, 255, 234)
            .BorderStyle = 0
            .Caption     = ""
            .FontBold    = .T.
            .FontName    = "Tahoma"
            .FontSize    = 8
            .ForeColor   = RGB(90, 90, 90)
            .Height      = 20
            .Left        = 136
            .Top         = 99
            .Width       = 309
            .TabIndex    = 4
            .Visible     = .T.
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarCampoPrioridade - Label2 + txt_4c_Prioridade (Get_Prioridade)
    * Modo parametrizado: TextBox ReadOnly (simula PROCEDURE When Return .F.)
    * BINDEVENT "Valid" nao funciona em TextBox - usar KeyPress
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarCampoPrioridade()
        THIS.AddObject("lbl_4c_LblPrioridade", "Label")
        WITH THIS.lbl_4c_LblPrioridade
            .AutoSize    = .T.
            .BackStyle   = 0
            .BorderStyle = 0
            .Caption     = "Prioridade (0/1) : "
            .FontBold    = .T.
            .FontName    = "Tahoma"
            .FontSize    = 8
            .ForeColor   = RGB(90, 90, 90)
            .Height      = 15
            .Left        = 134
            .Top         = 154
            .Width       = 102
            .TabIndex    = 5
            .Visible     = .T.
        ENDWITH

        THIS.AddObject("txt_4c_Prioridade", "TextBox")
        WITH THIS.txt_4c_Prioridade
            .FontBold  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Height    = 23
            .InputMask = "9"
            .Left      = 238
            .MaxLength = 1
            .TabIndex  = 1
            .Top       = 150
            .Width     = 17
            .Value     = THIS.this_nPrioridade
            .ReadOnly  = THIS.this_lParametrizado
            .Visible   = .T.
        ENDWITH

        *-- KeyPress simula Valid: valida ao ENTER(13) ou TAB(9)
        BINDEVENT(THIS.txt_4c_Prioridade, "KeyPress", THIS, "TxtPrioridadeKeyPress")
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPaginaDados - Elementos visuais complementares do form plano
    * Form OPERACIONAL (sem Page2 CRUD). Migra Shape1 do legado: elemento
    * decorativo de fundo atras dos botoes Processar/Encerrar.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPaginaDados()
        THIS.AddObject("shp_4c_Shape1", "Shape")
        WITH THIS.shp_4c_Shape1
            .Top         = 7
            .Left        = 480
            .Height      = 29
            .Width       = 48
            .BackStyle   = 0
            .BorderStyle = 0
            .BorderColor = RGB(136, 189, 188)
            .Visible     = .T.
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnProcessarClick - Loop principal de processamento da fila SigOpClP
    *--------------------------------------------------------------------------
    PROCEDURE BtnProcessarClick()
        LOCAL loc_lOk, loc_nMov, loc_lErroCnx, loc_lProcessando
        LOCAL loc_cSQL, loc_nResult, loc_nTotal, loc_nProcessado
        LOCAL loc_nKey, loc_nError, loc_cErro, loc_cCidChaves

        THIS.cmd_4c_Processar.Enabled = .F.
        THIS.this_lParar = .F.
        SET CURSOR OFF

        loc_nMov        = 1
        loc_lErroCnx    = .F.
        loc_lProcessando = .T.

        DO WHILE loc_lProcessando AND !THIS.this_lParar

            THIS.cmd_4c_Encerrar.Enabled = .F.

            THIS.lbl_4c_Progresso.Caption = "Aguardando Produtos Para Processar" + ;
                                             REPLICATE(".", loc_nMov)
            loc_nMov = IIF(loc_nMov < 5, loc_nMov + 1, 1)

            loc_lOk = THIS.this_oBusinessObject.BuscarFila(THIS.this_nPrioridade)

            IF !loc_lOk
                loc_lErroCnx = .T.
            ELSE
                SELECT CrSigOpClP
                loc_nTotal      = RECCOUNT("CrSigOpClP")
                loc_nProcessado = 0

                SCAN
                    loc_nProcessado = loc_nProcessado + 1
                    THIS.lbl_4c_Progresso.Caption = "Aguarde. Processando Produtos (" + ;
                        ALLTRIM(STR(loc_nProcessado)) + "/" + ALLTRIM(STR(loc_nTotal)) + ")"

                    loc_cCidChaves = ALLTRIM(CrSigOpClP.CidChaves)

                    *-- Marcar item como em processamento (lock otimista)
                    loc_cSQL = "UPDATE SigOpClP SET Usuars = Usuars " + ;
                               "WHERE CidChaves = " + EscaparSQL(loc_cCidChaves)
                    loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)

                    IF loc_nResult <= 0
                        SQLEXEC(gnConnHandle, "ROLLBACK")
                        IF loc_nResult = -3
                            loc_lErroCnx = .T.
                            EXIT
                        ENDIF
                        LOOP
                    ENDIF

                    THIS.this_oBusinessObject.CarregarDoCursor("CrSigOpClP")

                    IF !THIS.this_oBusinessObject.ProcessarItem()
                        SQLEXEC(gnConnHandle, "ROLLBACK")
                        LOOP
                    ENDIF

                    loc_nResult = SQLEXEC(gnConnHandle, "COMMIT")
                    IF loc_nResult <= 0
                        SQLEXEC(gnConnHandle, "ROLLBACK")
                        LOOP
                    ENDIF

                    *-- Verificar se pode remover da fila (sem pendencias em SigMvEst)
                    IF !THIS.this_oBusinessObject.VerificarMovimento()
                        IF THIS.this_oBusinessObject.Excluir()
                            SQLEXEC(gnConnHandle, "COMMIT")
                        ELSE
                            SQLEXEC(gnConnHandle, "ROLLBACK")
                            LOOP
                        ENDIF
                    ENDIF

                ENDSCAN
            ENDIF

            SQLEXEC(gnConnHandle, "ROLLBACK")
            THIS.cmd_4c_Encerrar.Enabled = .T.

            *-- Aguardar breve intervalo: permite que ESC seja detectado
            loc_nError = 0
            loc_cErro  = ON("Error")
            ON ERROR loc_nError = 1
            loc_nKey = INKEY(0.5, "M")
            IF loc_nError <> 0
                loc_nKey = 0
            ENDIF
            ON ERROR &loc_cErro.

            IF !THIS.this_lParametrizado OR loc_nKey = 27 OR loc_lErroCnx OR THIS.this_lParar
                loc_lProcessando = .F.
            ENDIF

        ENDDO

        SET CURSOR ON
        THIS.lbl_4c_Progresso.Caption = ""
        THIS.cmd_4c_Processar.Enabled = .T.
        THIS.cmd_4c_Encerrar.Enabled  = .T.

        IF THIS.this_lParametrizado
            THIS.this_oBusinessObject.GravarLog( ;
                "Concluindo o Processamento : Fortyus.Exe (SigOpClS) - Recalculo de Saldos")
            THIS.Release()
            QUIT
        ENDIF

        *-- Encerrar foi clicado durante o loop: agora e seguro fechar
        IF THIS.this_lParar
            THIS.Release()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnEncerrarClick - Fecha form ou sinaliza parada do loop
    * Se Processar Enabled = nao estamos no loop -> Release imediato
    * Se Processar Disabled = estamos no loop    -> apenas seta flag; loop sai e Release
    *--------------------------------------------------------------------------
    PROCEDURE BtnEncerrarClick()
        THIS.this_lParar = .T.
        IF THIS.cmd_4c_Processar.Enabled
            THIS.Release()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * TxtPrioridadeKeyPress - Valida prioridade ao ENTER(13) ou TAB(9)
    *--------------------------------------------------------------------------
    PROCEDURE TxtPrioridadeKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode != 13 AND par_nKeyCode != 9
            RETURN
        ENDIF
        IF !INLIST(THIS.txt_4c_Prioridade.Value, 0, 1)
            MsgAviso("Prioridade Inv" + CHR(225) + "lida!!!", "Valida" + CHR(231) + CHR(227) + "o")
            THIS.txt_4c_Prioridade.Value = THIS.this_nPrioridade
        ELSE
            THIS.this_nPrioridade = THIS.txt_4c_Prioridade.Value
            THIS.this_oBusinessObject.this_nPrioridade = THIS.this_nPrioridade
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * Destroy - Libera Business Object e encerra SET CURSOR normal
    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
        SET CURSOR ON
        IF VARTYPE(THIS.this_oBusinessObject) = "O"
            THIS.this_oBusinessObject = .NULL.
        ENDIF
        DODEFAULT()
    ENDPROC

    *==========================================================================
    * Eventos CRUD - contrato do pipeline (form OPERACIONAL sem CRUD)
    *
    * SIGPRRSA (legado) e um form de PROCESSAMENTO em lote, sem grid, sem
    * lista de registros e sem opercoes Incluir/Alterar/Visualizar/Excluir.
    * A unica acao operacional e Processar (loop sobre SigOpClP), tratada em
    * BtnProcessarClick. Os stubs abaixo existem apenas para manter o
    * contrato de metodos esperado pelo OrquestradorMigracao (Fase 7) e sao
    * seguros como no-op: os botoes CRUD nao sao renderizados neste form.
    *==========================================================================

    *--------------------------------------------------------------------------
    * BtnIncluirClick - Sem-operacao (form OPERACIONAL de processamento)
    *--------------------------------------------------------------------------
    PROCEDURE BtnIncluirClick()
        MsgAviso("Este formul" + CHR(225) + "rio n" + CHR(227) + "o possui inclus" + CHR(227) + "o de registros." + CHR(13) + ;
                 "Utilize o bot" + CHR(227) + "o Processar para executar o rec" + CHR(225) + "lculo de saldos.", ;
                 "Rec" + CHR(225) + "lculo de Saldos")
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnAlterarClick - Sem-operacao (form OPERACIONAL de processamento)
    *--------------------------------------------------------------------------
    PROCEDURE BtnAlterarClick()
        MsgAviso("Este formul" + CHR(225) + "rio n" + CHR(227) + "o possui altera" + CHR(231) + CHR(227) + "o de registros." + CHR(13) + ;
                 "Utilize o bot" + CHR(227) + "o Processar para executar o rec" + CHR(225) + "lculo de saldos.", ;
                 "Rec" + CHR(225) + "lculo de Saldos")
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnVisualizarClick - Sem-operacao (form OPERACIONAL de processamento)
    *--------------------------------------------------------------------------
    PROCEDURE BtnVisualizarClick()
        MsgAviso("Este formul" + CHR(225) + "rio n" + CHR(227) + "o possui visualiza" + CHR(231) + CHR(227) + "o de registros." + CHR(13) + ;
                 "Utilize o bot" + CHR(227) + "o Processar para executar o rec" + CHR(225) + "lculo de saldos.", ;
                 "Rec" + CHR(225) + "lculo de Saldos")
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnExcluirClick - Sem-operacao (form OPERACIONAL de processamento)
    *--------------------------------------------------------------------------
    PROCEDURE BtnExcluirClick()
        MsgAviso("Este formul" + CHR(225) + "rio n" + CHR(227) + "o possui exclus" + CHR(227) + "o de registros." + CHR(13) + ;
                 "Utilize o bot" + CHR(227) + "o Processar para executar o rec" + CHR(225) + "lculo de saldos.", ;
                 "Rec" + CHR(225) + "lculo de Saldos")
    ENDPROC

    *==========================================================================
    * Metodos de contrato Fase 8 - form OPERACIONAL sem CRUD
    * Os metodos abaixo existem para satisfazer o contrato do OrquestradorMigracao.
    * SIGPRRSA e um form de processamento em lote; nao tem lista, dados CRUD
    * nem modos Incluir/Alterar/Visualizar. Apenas Processar e Encerrar.
    *==========================================================================

    *--------------------------------------------------------------------------
    * BtnBuscarClick - Sem-operacao (form OPERACIONAL sem lista de registros)
    *--------------------------------------------------------------------------
    PROCEDURE BtnBuscarClick()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnSalvarClick - Sem-operacao (form OPERACIONAL sem modo de edicao CRUD)
    *--------------------------------------------------------------------------
    PROCEDURE BtnSalvarClick()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnCancelarClick - Sem-operacao (form OPERACIONAL sem modo de edicao)
    *--------------------------------------------------------------------------
    PROCEDURE BtnCancelarClick()
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarLista - Sem-operacao (form OPERACIONAL sem grade de registros)
    *--------------------------------------------------------------------------
    PROCEDURE CarregarLista()
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * AjustarBotoesPorModo - Sem-operacao (form OPERACIONAL sem modos CRUD)
    *--------------------------------------------------------------------------
    PROCEDURE AjustarBotoesPorModo()
    ENDPROC

    *--------------------------------------------------------------------------
    * FormParaBO - Sincroniza prioridade do campo visual para o BO
    *--------------------------------------------------------------------------
    PROCEDURE FormParaBO()
        IF VARTYPE(THIS.txt_4c_Prioridade) = "O" AND ;
           VARTYPE(THIS.this_oBusinessObject) = "O"
            THIS.this_nPrioridade = THIS.txt_4c_Prioridade.Value
            THIS.this_oBusinessObject.this_nPrioridade = THIS.this_nPrioridade
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * BOParaForm - Sincroniza prioridade do BO para o campo visual
    *--------------------------------------------------------------------------
    PROCEDURE BOParaForm()
        IF VARTYPE(THIS.txt_4c_Prioridade) = "O" AND ;
           VARTYPE(THIS.this_oBusinessObject) = "O"
            THIS.this_nPrioridade = THIS.this_oBusinessObject.this_nPrioridade
            THIS.txt_4c_Prioridade.Value = THIS.this_nPrioridade
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * HabilitarCampos - Gerencia estado editavel do campo de prioridade
    * Modo parametrizado: campo bloqueado independente de par_lHabilitar
    *--------------------------------------------------------------------------
    PROCEDURE HabilitarCampos(par_lHabilitar)
        IF VARTYPE(THIS.txt_4c_Prioridade) = "O"
            THIS.txt_4c_Prioridade.ReadOnly = THIS.this_lParametrizado OR !par_lHabilitar
        ENDIF
        IF VARTYPE(THIS.cmd_4c_Processar) = "O"
            THIS.cmd_4c_Processar.Enabled = par_lHabilitar AND !THIS.this_lParametrizado
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * LimparCampos - Restaura prioridade ao valor padrao (0)
    *--------------------------------------------------------------------------
    PROCEDURE LimparCampos()
        THIS.this_nPrioridade = 0
        IF VARTYPE(THIS.txt_4c_Prioridade) = "O"
            THIS.txt_4c_Prioridade.Value = 0
        ENDIF
        IF VARTYPE(THIS.this_oBusinessObject) = "O"
            THIS.this_oBusinessObject.this_nPrioridade = 0
        ENDIF
    ENDPROC

ENDDEFINE


### BO (C:\4c\projeto\app\classes\SigPrRsaBO.prg):
*==============================================================================
* Classe  : SigPrRsaBO
* Herda de: BusinessBase
* Descricao: BO para recalculo de saldos de produto (SIGPRRSA)
*            Form OPERACIONAL - processa fila SigOpClP chamando fRecalculaP
*            para cada produto pendente, fazendo commit/rollback por item.
*            Suporta modo parametrizado (batch) e modo interativo (loop continuo).
*==============================================================================
DEFINE CLASS SigPrRsaBO AS BusinessBase

    *-- Parametros de execucao
    this_nPrioridade    = 0     && Filtro de prioridade: 0 ou 1
    this_lParametrizado = .F.   && .T. = chamado de batch (Fortyus.Exe), quit apos processar

    *-- Estado do processamento (lido pelo Form para atualizar Label1)
    this_cStatusMsg     = ""    && Mensagem de progresso para o form exibir
    this_nTotalFila     = 0     && Total de registros na fila antes de processar
    this_nProcessados   = 0     && Quantidade processada na iteracao corrente

    *-- Campos do registro corrente de SigOpClP
    this_cCidChaves = ""        && cidchaves char(20) - PK da fila
    this_nPriors    = 0         && priors numeric(1,0) - prioridade (0 ou 1)
    this_cEmps      = ""        && emps char(3) - empresa
    this_cGrupos    = ""        && grupos char(10) - grupo de estoque
    this_cEstos     = ""        && estos char(10) - estoque/localizacao
    this_cCpros     = ""        && cpros char(14) - codigo do produto
    this_dDatas     = {}        && datas datetime - data do movimento
    this_cCodCors   = ""        && codcors char(4) - codigo da cor
    this_cCodTams   = ""        && codtams char(4) - codigo do tamanho
    this_cUsuars    = ""        && usuars char(20) - usuario processador
    this_nTipoestos = 0         && tipoestos numeric(1,0) - tipo de estoque
    this_cEmpestpros = ""       && empestpros char(37) - composite emps+estos+cpros

    *--------------------------------------------------------------------------
    * Init
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        THIS.this_cTabela     = ""
        THIS.this_cCampoChave = ""
        DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - identificador para auditoria operacional
    *--------------------------------------------------------------------------
    FUNCTION ObterChavePrimaria()
        RETURN "RECALCPRSLP"
    ENDFUNC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - popula propriedades do BO a partir do cursor CrSigOpClP
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            IF USED(par_cAliasCursor)
                SELECT (par_cAliasCursor)
                THIS.this_cCidChaves = NVL(cidchaves, "")
                THIS.this_nPriors    = NVL(priors, 0)
                THIS.this_cEmps      = NVL(emps, "")
                THIS.this_cGrupos    = NVL(grupos, "")
                THIS.this_cEstos     = NVL(estos, "")
                THIS.this_cCpros     = NVL(cpros, "")
                THIS.this_dDatas     = IIF(VARTYPE(datas) = "T", datas, {})
                THIS.this_cCodCors   = NVL(codcors, "")
                THIS.this_cCodTams   = NVL(codtams, "")
                THIS.this_cUsuars    = NVL(usuars, "")
                IF TYPE("tipoestos") != "U"
                    THIS.this_nTipoestos = NVL(tipoestos, 0)
                ENDIF
                IF TYPE("empestpros") != "U"
                    THIS.this_cEmpestpros = NVL(empestpros, "")
                ELSE
                    THIS.this_cEmpestpros = ALLTRIM(THIS.this_cEmps) + ;
                                            ALLTRIM(THIS.this_cEstos) + ;
                                            ALLTRIM(THIS.this_cCpros)
                ENDIF
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * BuscarFila - SELECT de SigOpClP filtrado por prioridade em CrSigOpClP
    *--------------------------------------------------------------------------
    FUNCTION BuscarFila(par_nPrioridade)
        LOCAL loc_lSucesso, loc_cSQL
        loc_lSucesso = .F.
        TRY
            IF USED("CrSigOpClP")
                USE IN CrSigOpClP
            ENDIF
            loc_cSQL = "SELECT cidchaves, codcors, codtams, cpros, datas, emps, " + ;
                       "estos, grupos, tipoestos, usuars, priors " + ;
                       "FROM SigOpClP " + ;
                       "WHERE priors = " + FormatarNumeroSQL(par_nPrioridade, 0) + " " + ;
                       "ORDER BY emps, grupos, estos"
            loc_lSucesso = (SQLEXEC(gnConnHandle, loc_cSQL, "CrSigOpClP") > 0)
            IF loc_lSucesso
                THIS.this_nTotalFila = RECCOUNT("CrSigOpClP")
            ELSE
                THIS.this_nTotalFila = 0
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * Inserir - INSERT INTO SigOpClP (enfileira item para recalculo de saldo)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Inserir()
        LOCAL loc_lSucesso, loc_cSQL, loc_nResult, loc_cEmpEstPro
        loc_lSucesso = .F.
        TRY
            IF EMPTY(ALLTRIM(THIS.this_cCidChaves))
                THIS.this_cCidChaves = SYS(2015)
            ENDIF
            IF EMPTY(ALLTRIM(THIS.this_cUsuars))
                THIS.this_cUsuars = gc_4c_UsuarioLogado
            ENDIF
            IF EMPTY(THIS.this_dDatas)
                THIS.this_dDatas = DATETIME()
            ENDIF
            loc_cEmpEstPro = PADR(ALLTRIM(THIS.this_cEmps), 3) + ;
                             PADR(ALLTRIM(THIS.this_cEstos), 10) + ;
                             PADR(ALLTRIM(THIS.this_cCpros), 14)
            THIS.this_cEmpestpros = loc_cEmpEstPro
            loc_cSQL = "INSERT INTO SigOpClP " + ;
                       "(cidchaves, codcors, codtams, cpros, datas, empestpros, " + ;
                       "emps, estos, grupos, tipoestos, usuars, priors) VALUES (" + ;
                       EscaparSQL(ALLTRIM(THIS.this_cCidChaves)) + ", " + ;
                       EscaparSQL(ALLTRIM(THIS.this_cCodCors)) + ", " + ;
                       EscaparSQL(ALLTRIM(THIS.this_cCodTams)) + ", " + ;
                       EscaparSQL(ALLTRIM(THIS.this_cCpros)) + ", " + ;
                       FormatarDataSQL(THIS.this_dDatas) + ", " + ;
                       EscaparSQL(loc_cEmpEstPro) + ", " + ;
                       EscaparSQL(ALLTRIM(THIS.this_cEmps)) + ", " + ;
                       EscaparSQL(ALLTRIM(THIS.this_cEstos)) + ", " + ;
                       EscaparSQL(ALLTRIM(THIS.this_cGrupos)) + ", " + ;
                       FormatarNumeroSQL(THIS.this_nTipoestos, 0) + ", " + ;
                       EscaparSQL(ALLTRIM(THIS.this_cUsuars)) + ", " + ;
                       FormatarNumeroSQL(THIS.this_nPriors, 0) + ")"
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nResult > 0
                loc_lSucesso = .T.
                THIS.RegistrarAuditoria("INSERT")
            ELSE
                THIS.this_cMensagemErro = "Erro ao inserir item na fila de recalculo (SigOpClP)."
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - UPDATE SigOpClP com todos os campos do item corrente
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Atualizar()
        LOCAL loc_lSucesso, loc_cSQL, loc_nResult, loc_cEmpEstPro
        loc_lSucesso = .F.
        TRY
            IF EMPTY(ALLTRIM(THIS.this_cCidChaves))
                THIS.this_cMensagemErro = "CidChaves n" + CHR(227) + "o informado."
            ELSE
                loc_cEmpEstPro = PADR(ALLTRIM(THIS.this_cEmps), 3) + ;
                                 PADR(ALLTRIM(THIS.this_cEstos), 10) + ;
                                 PADR(ALLTRIM(THIS.this_cCpros), 14)
                THIS.this_cEmpestpros = loc_cEmpEstPro
                loc_cSQL = "UPDATE SigOpClP SET " + ;
                           "codcors = " + EscaparSQL(ALLTRIM(THIS.this_cCodCors)) + ", " + ;
                           "codtams = " + EscaparSQL(ALLTRIM(THIS.this_cCodTams)) + ", " + ;
                           "cpros = " + EscaparSQL(ALLTRIM(THIS.this_cCpros)) + ", " + ;
                           "datas = " + FormatarDataSQL(THIS.this_dDatas) + ", " + ;
                           "empestpros = " + EscaparSQL(loc_cEmpEstPro) + ", " + ;
                           "emps = " + EscaparSQL(ALLTRIM(THIS.this_cEmps)) + ", " + ;
                           "estos = " + EscaparSQL(ALLTRIM(THIS.this_cEstos)) + ", " + ;
                           "grupos = " + EscaparSQL(ALLTRIM(THIS.this_cGrupos)) + ", " + ;
                           "tipoestos = " + FormatarNumeroSQL(THIS.this_nTipoestos, 0) + ", " + ;
                           "usuars = " + EscaparSQL(ALLTRIM(THIS.this_cUsuars)) + ", " + ;
                           "priors = " + FormatarNumeroSQL(THIS.this_nPriors, 0) + " " + ;
                           "WHERE cidchaves = " + EscaparSQL(ALLTRIM(THIS.this_cCidChaves))
                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)
                IF loc_nResult > 0
                    loc_lSucesso = .T.
                    THIS.RegistrarAuditoria("UPDATE")
                ELSE
                    IF loc_nResult = -3
                    THIS.this_cMensagemErro = "Conex" + CHR(227) + "o perdida com o banco de dados."
                ELSE
                    THIS.this_cMensagemErro = "Erro ao atualizar item da fila de recalculo (SigOpClP)."
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ExecutarAtualizacao - UPDATE SigOpClP marcando item como sendo processado
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION ExecutarAtualizacao()
        LOCAL loc_lSucesso, loc_cSQL, loc_nResult
        loc_lSucesso = .F.
        TRY
            IF EMPTY(ALLTRIM(THIS.this_cCidChaves))
                THIS.this_cMensagemErro = "CidChaves n" + CHR(227) + "o informado."
            ELSE
                loc_cSQL = "UPDATE SigOpClP SET usuars = usuars " + ;
                           "WHERE cidchaves = " + EscaparSQL(ALLTRIM(THIS.this_cCidChaves))
                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)
                IF loc_nResult > 0
                    loc_lSucesso = .T.
                ELSE
                    IF loc_nResult = -3
                    THIS.this_cMensagemErro = "Conex" + CHR(227) + "o perdida com o banco de dados."
                ELSE
                    THIS.this_cMensagemErro = "Erro ao marcar item como processando."
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
        ENDTRY
        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * ExecutarExclusao - DELETE FROM SigOpClP apos processamento bem sucedido
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION ExecutarExclusao()
        LOCAL loc_lSucesso, loc_cSQL, loc_nResult
        loc_lSucesso = .F.
        TRY
            IF EMPTY(ALLTRIM(THIS.this_cCidChaves))
                THIS.this_cMensagemErro = "CidChaves n" + CHR(227) + "o informado."
            ELSE
                loc_cSQL = "DELETE FROM SigOpClP " + ;
                           "WHERE cidchaves = " + EscaparSQL(ALLTRIM(THIS.this_cCidChaves))
                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)
                IF loc_nResult > 0
                    loc_lSucesso = .T.
                ELSE
                    THIS.this_cMensagemErro = "Erro ao remover item da fila de processamento."
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
        ENDTRY
        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * ProcessarItem - chama fRecalculaP para o item carregado em this_c*
    *--------------------------------------------------------------------------
    FUNCTION ProcessarItem()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            IF USED("crRecalculaP")
                USE IN crRecalculaP
            ENDIF
            *-- Primeira chamada: calcula saldo do produto especifico
            loc_lSucesso = fRecalculaP( ;
                THIS.this_cEmps, ;
                THIS.this_cGrupos, ;
                THIS.this_cEstos, ;
                THIS.this_cCpros, ;
                THIS.this_dDatas, ;
                THIS.this_cCodCors, ;
                THIS.this_cCodTams )
            IF loc_lSucesso
                *-- Segunda chamada: consolida saldos pendentes na fila
                loc_lSucesso = fRecalculaP(.T.)
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
            loc_lSucesso = .F.
        ENDTRY
        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * VerificarMovimento - retorna .T. se deve pular exclusao da fila
    *   .T. = nao tem movimento em SigMvEst E tem historico em SigMvHst (loop)
    *   .F. = tem movimento em SigMvEst OU nao tem historico -> pode excluir da fila
    *--------------------------------------------------------------------------
    FUNCTION VerificarMovimento()
        LOCAL loc_lDeveLoop, loc_cChave, loc_cSQL, loc_nResult
        loc_lDeveLoop = .F.
        TRY
            loc_cChave = ALLTRIM(THIS.this_cEmps) + ;
                         ALLTRIM(THIS.this_cGrupos) + ;
                         ALLTRIM(THIS.this_cEstos)
            loc_cSQL = "SELECT cidchaves FROM SigMvEst " + ;
                       "WHERE empgruests = " + EscaparSQL(loc_cChave) + " " + ;
                       "AND cpros = " + EscaparSQL(ALLTRIM(THIS.this_cCpros))
            IF USED("TmpEst")
                USE IN TmpEst
            ENDIF
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "TmpEst")
            IF loc_nResult < 1 OR RECCOUNT("TmpEst") = 0
                *-- Sem registro em SigMvEst: verificar SigMvHst
                IF USED("TmpHis")
                    USE IN TmpHis
                ENDIF
                loc_cSQL = "SELECT empgruests, SUM(1) AS TT FROM SigMvHst " + ;
                           "WHERE empgruests = " + EscaparSQL(loc_cChave) + " " + ;
                           "AND cpros = " + EscaparSQL(ALLTRIM(THIS.this_cCpros)) + " " + ;
                           "GROUP BY empgruests"
                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "TmpHis")
                IF loc_nResult < 1
                    loc_lDeveLoop = .T.
                ELSE
                    IF USED("TmpHis") AND RECCOUNT("TmpHis") > 0
                    SELECT TmpHis
                    IF NVL(TT, 0) > 0
                        loc_lDeveLoop = .T.
                    ENDIF
                    ENDIF
                ENDIF
            ENDIF
            IF USED("TmpEst")
                USE IN TmpEst
            ENDIF
            IF USED("TmpHis")
                USE IN TmpHis
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
            loc_lDeveLoop = .T.
        ENDTRY
        RETURN loc_lDeveLoop
    ENDFUNC

    *--------------------------------------------------------------------------
    * GravarLog - escreve linha no Fortyus.Log (modo parametrizado)
    *--------------------------------------------------------------------------
    PROCEDURE GravarLog(par_cMensagem)
        LOCAL loc_cArquivo
        loc_cArquivo = "Fortyus.Log"
        TRY
            IF !EMPTY(par_cMensagem)
                STRTOFILE(par_cMensagem + CHR(10), loc_cArquivo, .T.)
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * IniciarLog - cria/limpa Fortyus.Log e grava cabecalho de inicio
    *--------------------------------------------------------------------------
    PROCEDURE IniciarLog(par_cMensagem)
        TRY
            STRTOFILE("", "Fortyus.Log", .T.)
            THIS.GravarLog(REPLICATE("=", 80))
            THIS.GravarLog(par_cMensagem)
            THIS.GravarLog("Data : " + DTOC(DATE()) + " - Hora : " + TIME())
            THIS.GravarLog(REPLICATE("=", 80))
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * RegistrarAuditoria - override para log operacional de recalculo de saldos
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE RegistrarAuditoria(par_cOperacao)
        LOCAL loc_cSQL
        TRY
            loc_cSQL = "INSERT INTO LogAuditoria " + ;
                       "(Usuario, Tabela, Operacao, ChaveRegistro, DataHora) VALUES (" + ;
                       EscaparSQL(gc_4c_UsuarioLogado) + ", " + ;
                       EscaparSQL("SigOpClP") + ", " + ;
                       EscaparSQL(par_cOperacao) + ", " + ;
                       EscaparSQL(THIS.ObterChavePrimaria()) + ", " + ;
                       "GETDATE())"
            SQLEXEC(gnConnHandle, loc_cSQL)
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

ENDDEFINE


*------------------------------------------------------------------------------
* FormTBI.prg - Form Operacional: Relatorio de Tabelas de Referencia (Cambio)
* Herda de FormBase
* Migrado de SIGCDTBI.SCX
*
* Form utilitario de IMPRESSAO (sem Lista/Grid, sem CRUD): permite informar
* uma moeda de referencia (com lookup em SigCdMoe) e a quantidade de copias,
* e imprime a tabela de cambio das tabelas de referencia (SigOpTdz) cadastradas
* com desconto, convertidas para a moeda informada.
*------------------------------------------------------------------------------
DEFINE CLASS FormTBI AS FormBase

    *-- Propriedades visuais (original: Width=284, Height=197, TitleBar=0, DataSession=2)
    Top          = 0
    Left         = 0
    Height       = 197
    Width        = 284
    BorderStyle  = 2
    AutoCenter   = .T.
    TitleBar     = 0
    ShowWindow   = 1
    WindowType   = 1
    ControlBox   = .F.
    Closable     = .F.
    MaxButton    = .F.
    MinButton    = .F.
    Movable      = .F.
    ClipControls = .F.
    Caption      = "Relat" + CHR(243) + "rio de Tabelas de Refer" + CHR(234) + "ncia"
    FontName     = "Verdana"
    FontSize     = 8
    ForeColor    = RGB(36, 84, 155)

    *-- Business Object
    this_oBusinessObject = .NULL.

    *-- Estado atual do painel de parametros (ver AlternarPagina)
    *-- 1 = ENTRADA (usuario informa moeda / copias)
    *-- 2 = IMPRESSAO (geracao e envio para a impressora em andamento)
    this_nPaginaAtual = 1

    *==========================================================================
    PROCEDURE Init()
    *==========================================================================
        *-- DODEFAULT() ja chama InicializarForm() atraves do FormBase.Init()
        RETURN DODEFAULT()
    ENDPROC

    *==========================================================================
    * InicializarForm - Chamado por FormBase.Init via DODEFAULT
    *==========================================================================
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lSucesso, loc_lConexaoOk, loc_oErro
        loc_lSucesso   = .F.
        loc_lConexaoOk = .T.

        TRY
            THIS.this_oBusinessObject = CREATEOBJECT("TBIBO")
            THIS.Picture = gc_4c_CaminhoIcones + "new_background.jpg"

            IF TYPE("gb_4c_ValidandoUI") != "L" OR !gb_4c_ValidandoUI
                IF gnConnHandle <= 0
                    loc_lConexaoOk = .F.
                ENDIF
            ENDIF

            IF loc_lConexaoOk
                THIS.ConfigurarPageFrame()
                THIS.ConfigurarPaginaLista()
                THIS.LimparCampos()
                THIS.TornarControlesVisiveis()
                THIS.AlternarPagina(1)
                loc_lSucesso = .T.
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, ;
                "Erro InicializarForm")
        ENDTRY

        IF !loc_lConexaoOk
            MsgErro("Imposs" + CHR(237) + "vel Efetuar Conex" + CHR(227) + ;
                    "o Com o Servidor de Banco de Dados...", ;
                    "Conex" + CHR(227) + "o")
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * ConfigurarPageFrame - Constroi o cabecalho cinza superior do form
    * Forms OPERACIONAIS deste tipo (dialogo utilitario, sem Lista/Dados) nao
    * usam PageFrame CRUD - o cabecalho e um container direto no form,
    * equivalente ao cntSombra do framework legado (ver mapeamento.json)
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPageFrame()
        LOCAL loc_oErro

        TRY
            THIS.AddObject("cnt_4c_Sombra", "Container")
            WITH THIS.cnt_4c_Sombra
                .Top         = 0
                .Left        = 0
                .Width       = THIS.Width
                .Height      = 80
                .BackColor   = RGB(100, 100, 100)
                .BackStyle   = 1
                .BorderWidth = 0

                .AddObject("lbl_4c_LblSombra", "Label")
                WITH .lbl_4c_LblSombra
                    .Top       = 18
                    .Left      = 10
                    .Width     = THIS.Width
                    .Height    = 40
                    .FontBold  = .T.
                    .FontName  = "Tahoma"
                    .FontSize  = 18
                    .AutoSize  = .F.
                    .BackStyle = 0
                    .WordWrap  = .T.
                    .Alignment = 0
                    .ForeColor = RGB(0, 0, 0)
                    .Caption   = "Tabelas de Refer" + CHR(234) + "ncia"
                ENDWITH

                .AddObject("lbl_4c_LblTitulo", "Label")
                WITH .lbl_4c_LblTitulo
                    .Top       = 17
                    .Left      = 10
                    .Width     = THIS.Width
                    .Height    = 46
                    .FontBold  = .T.
                    .FontName  = "Tahoma"
                    .FontSize  = 18
                    .AutoSize  = .F.
                    .BackStyle = 0
                    .WordWrap  = .T.
                    .Alignment = 0
                    .ForeColor = RGB(255, 255, 255)
                    .Caption   = "Tabelas de Refer" + CHR(234) + "ncia"
                ENDWITH

                .Visible = .T.
            ENDWITH

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, ;
                "Erro ConfigurarPageFrame")
        ENDTRY
    ENDPROC

    *==========================================================================
    * ConfigurarPaginaLista - Constroi a UNICA pagina util do formulario
    * (painel de parametros de impressao) e fixa a ordem de tabulacao.
    *
    * NOTA DE ARQUITETURA (por que nao ha Grid nem botoes CRUD aqui):
    * SIGCDTBI e um dialogo utilitario de IMPRESSAO (284 x 197), nao um
    * cadastro. O SCX original tem exatamente 10 objetos (cntSombra +
    * 2 labels de titulo, shp_relatorio, lbl_moeda, get_moeda_desc,
    * get_moeda, lbl_copias, get_copias e o commandgroup cmd_grupo com
    * cmd_ok / cmd_cancela) - NAO existe Grid, NAO existe lista de
    * registros e NAO existem os botoes Incluir/Alterar/Excluir/Buscar.
    * Acrescentar um grid ou uma barra CRUD aqui violaria o PILAR 1
    * (UX identica ao legado) e nao teria origem no formulario original.
    * Este metodo concentra, portanto, a montagem da unica pagina existente.
    *
    * ORDEM DE TABULACAO: o SCX original declara os TabIndex
    *       get_moeda = 2  ->  get_moeda_desc = 3  ->  get_copias = 5
    *       ->  cmd_grupo = 28
    * (lbl_moeda = 4 e lbl_copias = 6 sao Labels e nao recebem foco).
    * Ou seja, o foco inicial cai no CODIGO da moeda; a DESCRICAO vem em
    * seguida e so aceita digitacao enquanto o codigo estiver vazio - ver o
    * When de get_moeda_desc, reproduzido em AlternarPagina. Como o
    * AddObject desta migracao nao garante essa sequencia, o TabIndex e
    * fixado explicitamente, preservando a ordem RELATIVA do original.
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPaginaLista()
        LOCAL loc_oErro

        TRY
            *-- 1. Moldura + campos de entrada (moeda, descricao, copias)
            THIS.ConfigurarPaginaDados()

            *-- 2. CommandGroup com Confirma / Encerrar (cmd_grupo)
            THIS.ConfigurarBotoes()

            *-- 3. Ordem de tabulacao IDENTICA a do SCX original
            THIS.txt_4c__moeda.TabIndex      = 1
            THIS.txt_4c__moeda_desc.TabIndex = 2
            THIS.txt_4c__copias.TabIndex     = 3
            THIS.obj_4c_Cmd_grupo.TabIndex   = 4

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, ;
                "Erro ConfigurarPaginaLista")
        ENDTRY
    ENDPROC

    *==========================================================================
    * AlternarPagina - Aplica as regras de estado dos controles do painel.
    *
    * Como o formulario tem uma unica pagina fisica, "pagina" aqui e o
    * ESTADO do dialogo, exatamente como no legado:
    *   1 = ENTRADA    - usuario informa moeda / copias (estado normal)
    *   2 = IMPRESSAO  - cmd_ok.Click em execucao (monta os cursores,
    *                    envia para a impressora); enquanto isso os campos
    *                    ficam bloqueados para nao serem alterados no meio
    *                    da geracao.
    *
    * Alem do bloqueio por estado, este metodo reproduz o When de
    * get_moeda_desc do original:
    *       Return Empty(ThisForm.get_moeda.Value)
    * ou seja, a descricao so aceita digitacao enquanto o CODIGO da moeda
    * estiver vazio. Usa-se ReadOnly (e nao Enabled) para nao alterar a
    * aparencia do controle - o When do legado tambem nao o deixa cinza.
    * Por isso AlternarPagina(1) e re-executado sempre que o par
    * codigo/descricao muda (ValidarMoeda / ValidarMoedaDesc).
    *==========================================================================
    PROCEDURE AlternarPagina(par_nPagina)
        LOCAL loc_nPagina

        loc_nPagina = IIF(VARTYPE(par_nPagina) = "N" AND INLIST(par_nPagina, 1, 2), ;
                          par_nPagina, 1)

        THIS.this_nPaginaAtual = loc_nPagina

        *-- Sincroniza o estado dos campos com a pagina/modo atual
        THIS.AjustarBotoesPorModo()

        *-- O foco inicial e dado pelo TabIndex fixado em ConfigurarPaginaLista
        *-- (codigo da moeda = 1). Nenhum SetFocus e emitido aqui: como este metodo e
        *-- reexecutado dentro dos KeyPress de validacao, um SetFocus prenderia
        *-- o cursor no campo recem-validado e impediria o Tab para Copias.
    ENDPROC

    *==========================================================================
    * AjustarBotoesPorModo - Sincroniza o estado (habilitado/bloqueado) dos
    * campos de entrada com THIS.this_nPaginaAtual.
    *
    * Este dialogo NAO tem botoes CRUD (apenas Confirma/Encerrar, que ficam
    * SEMPRE habilitados - o CommandGroup nao e afetado pelo estado da
    * pagina) - o nome do metodo e mantido pelo padrao arquitetural do
    * FormBase (contrato chamado por AlternarPagina), mas aqui ele apenas
    * delega para HabilitarCampos().
    *==========================================================================
    PROCEDURE AjustarBotoesPorModo()
        THIS.HabilitarCampos(THIS.this_nPaginaAtual = 1)
    ENDPROC

    *==========================================================================
    * HabilitarCampos - Aplica o bloqueio/desbloqueio dos campos de entrada
    * (codigo da moeda, descricao da moeda, copias) conforme par_lHabilitar.
    *
    * Reproduz, alem do bloqueio geral, o When original de get_moeda_desc:
    *       Return Empty(ThisForm.get_moeda.Value)
    * ou seja, mesmo com par_lHabilitar = .T., a descricao so aceita
    * digitacao enquanto o CODIGO da moeda estiver vazio.
    *==========================================================================
    PROTECTED PROCEDURE HabilitarCampos(par_lHabilitar)
        LOCAL loc_lHabilitar, loc_lCodigoVazio

        loc_lHabilitar   = (VARTYPE(par_lHabilitar) = "L" AND par_lHabilitar)
        loc_lCodigoVazio = EMPTY(ALLTRIM(THIS.txt_4c__moeda.Value))

        *-- Codigo da moeda e quantidade de copias: editaveis apenas quando habilitado
        THIS.txt_4c__moeda.ReadOnly  = !loc_lHabilitar
        THIS.txt_4c__copias.ReadOnly = !loc_lHabilitar

        *-- Descricao da moeda: When original = Empty(get_moeda.Value)
        THIS.txt_4c__moeda_desc.ReadOnly = !(loc_lHabilitar AND loc_lCodigoVazio)
    ENDPROC

    *==========================================================================
    * ConfigurarPaginaDados - Cria os campos de ENTRADA DE DADOS do dialogo
    * (moeda de referencia + descricao + quantidade de copias) dentro da
    * moldura shp_relatorio, diretamente sobre o form.
    *
    * NOTA DE ARQUITETURA: forms OPERACIONAIS deste tipo nao tem PageFrame
    * e portanto nao seguem o padrao Page1=Lista/Page2=Dados do CRUD - nao
    * existe uma "Page2" fisica a configurar. Este metodo concentra o que,
    * num form CRUD, seria a pagina de Dados: TODOS os campos editaveis do
    * formulario. Layout e posicoes EXATOS do original (ver layout.json /
    * SIGCDTBI_form_codigo_fonte.txt).
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPaginaDados()
        LOCAL loc_oErro

        TRY
            *-- Moldura ao redor dos campos (shp_relatorio no original)
            THIS.AddObject("shp_4c_Shp_relatorio", "Shape")
            WITH THIS.shp_4c_Shp_relatorio
                .Top          = 85
                .Left         = 32
                .Width        = 219
                .Height       = 63
                .BackStyle    = 0
                .BorderStyle  = 6
                .FillStyle    = 1
                .SpecialEffect = 0
                .ColorScheme  = 1
                .BackColor    = RGB(192, 192, 192)
                .Visible      = .T.
            ENDWITH

            *-- Label "Moeda  :"
            THIS.AddObject("lbl_4c_Lbl_moeda", "Label")
            WITH THIS.lbl_4c_Lbl_moeda
                .Top      = 99
                .Left     = 39
                .AutoSize = .T.
                .BackStyle = 0
                .FontName = "Verdana"
                .FontSize = 8
                .Caption  = "Moeda  :"
                .Visible  = .T.
            ENDWITH

            *-- TextBox do codigo da moeda de referencia (get_moeda)
            THIS.AddObject("txt_4c__moeda", "TextBox")
            WITH THIS.txt_4c__moeda
                .Top           = 94
                .Left          = 91
                .Width         = 31
                .Height        = 23
                .FontName      = "Courier New"
                .FontSize      = 9
                .FontBold      = .F.
                .FontItalic    = .F.
                .Alignment     = 0
                .BackStyle     = 1
                .BorderStyle   = 1
                .SpecialEffect = 0
                .Format        = "!"
                .MaxLength     = 3
                .ForeColor     = RGB(0, 0, 0)
                .BackColor     = RGB(255, 255, 255)
                .Value         = ""
                .Visible       = .T.
            ENDWITH

            *-- TextBox da descricao da moeda de referencia (get_moeda_desc)
            THIS.AddObject("txt_4c__moeda_desc", "TextBox")
            WITH THIS.txt_4c__moeda_desc
                .Top       = 94
                .Left      = 122
                .Width     = 115
                .Height    = 23
                .FontName  = "Courier New"
                .Format    = "!"
                .MaxLength = 15
                .Value     = ""
                .Visible   = .T.
            ENDWITH

            *-- Label "Copias :"
            THIS.AddObject("lbl_4c_Lbl_copias", "Label")
            WITH THIS.lbl_4c_Lbl_copias
                .Top      = 122
                .Left     = 41
                .AutoSize = .T.
                .BackStyle = 0
                .FontName = "Verdana"
                .FontSize = 8
                .Caption  = "C" + CHR(243) + "pias :"
                .Visible  = .T.
            ENDWITH

            *-- TextBox da quantidade de copias (get_copias)
            THIS.AddObject("txt_4c__copias", "TextBox")
            WITH THIS.txt_4c__copias
                .Top           = 117
                .Left          = 91
                .Width         = 45
                .Height        = 23
                .FontName      = "Courier New"
                .FontSize      = 9
                .FontBold      = .F.
                .FontItalic    = .F.
                .Alignment     = 3
                .BackStyle     = 1
                .BorderStyle   = 1
                .SpecialEffect = 0
                .Format        = "99999"
                .InputMask     = "99999"
                .MaxLength     = 5
                .ForeColor     = RGB(0, 0, 0)
                .BackColor     = RGB(255, 255, 255)
                .Value         = 1
                .Visible       = .T.
            ENDWITH

            *-- Lookup de moeda: dispara em ENTER(13)/TAB(9)/F4(115)
            BINDEVENT(THIS.txt_4c__moeda, "KeyPress", THIS, "ValidarMoeda")
            BINDEVENT(THIS.txt_4c__moeda_desc, "KeyPress", THIS, "ValidarMoedaDesc")

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, ;
                "Erro ConfigurarPaginaDados")
        ENDTRY
    ENDPROC

    *==========================================================================
    * FormParaBO - Transfere os campos do dialogo (moeda, descricao, copias)
    * para o Business Object. Chamado antes de gerar/pre-visualizar a tabela
    * de referencia (BtnConfirmarClick/BtnVisualizarClick).
    *==========================================================================
    PROTECTED PROCEDURE FormParaBO()
        THIS.this_oBusinessObject.this_cMoeda          = ALLTRIM(THIS.txt_4c__moeda.Value)
        THIS.this_oBusinessObject.this_cMoedaDescricao = ALLTRIM(THIS.txt_4c__moeda_desc.Value)
        THIS.this_oBusinessObject.this_nCopias         = THIS.txt_4c__copias.Value
    ENDPROC

    *==========================================================================
    * BOParaForm - Transfere os campos do Business Object para o dialogo
    * (sentido inverso de FormParaBO). Usado por LimparCampos() para refletir
    * o estado inicial/limpo do BO nos controles do form.
    *==========================================================================
    PROTECTED PROCEDURE BOParaForm()
        THIS.txt_4c__moeda.Value      = ALLTRIM(NVL(THIS.this_oBusinessObject.this_cMoeda, ""))
        THIS.txt_4c__moeda_desc.Value = ALLTRIM(NVL(THIS.this_oBusinessObject.this_cMoedaDescricao, ""))
        THIS.txt_4c__copias.Value     = IIF(NVL(THIS.this_oBusinessObject.this_nCopias, 0) > 0, ;
                                             THIS.this_oBusinessObject.this_nCopias, 1)
    ENDPROC

    *==========================================================================
    * LimparCampos - Restaura o BO e os campos do dialogo ao estado inicial
    * (moeda/descricao vazias, 1 copia), espelhando o Init original
    * (.get_moeda.Value = '' / .get_moeda_desc.Value = '' / .get_copias.Value = 1).
    *==========================================================================
    PROTECTED PROCEDURE LimparCampos()
        THIS.this_oBusinessObject.this_cMoeda          = ""
        THIS.this_oBusinessObject.this_cMoedaDescricao = ""
        THIS.this_oBusinessObject.this_nCopias         = 1

        THIS.BOParaForm()
    ENDPROC

    *==========================================================================
    * CarregarLista - Este dialogo NAO tem Grid/lista de registros (ver nota
    * de arquitetura em ConfigurarPaginaLista) - metodo mantido apenas para
    * cumprir o contrato de nomenclatura do FormBase; nunca e chamado
    * internamente. Nao ha nada a carregar.
    *==========================================================================
    PROCEDURE CarregarLista()
        RETURN .T.
    ENDPROC

    *==========================================================================
    * ValidarMoeda - KeyPress do txt_4c__moeda (get_moeda). Valida o codigo
    * digitado contra SigCdMoe; se nao achar, abre o lookup (AbrirBuscaMoeda)
    * - espelha o Valid original de get_moeda (fwBuscaExt por CMoes).
    *==========================================================================
    PROCEDURE ValidarMoeda(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_cValor, loc_cSQL, loc_nResultado

        IF !INLIST(par_nKeyCode, 13, 9, 115)
            RETURN
        ENDIF

        loc_cValor = ALLTRIM(UPPER(THIS.txt_4c__moeda.Value))

        IF EMPTY(loc_cValor)
            THIS.txt_4c__moeda.Value      = ""
            THIS.txt_4c__moeda_desc.Value = ""
            RETURN
        ENDIF

        IF USED("cursor_4c_TbiLkpMoeda")
            USE IN cursor_4c_TbiLkpMoeda
        ENDIF

        loc_cSQL = "SELECT cmoes, dmoes FROM SigCdMoe WHERE cmoes = " + EscaparSQL(loc_cValor)
        loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_TbiLkpMoeda")

        IF loc_nResultado > 0 AND USED("cursor_4c_TbiLkpMoeda") AND ;
           RECCOUNT("cursor_4c_TbiLkpMoeda") > 0
            THIS.txt_4c__moeda.Value      = ALLTRIM(cursor_4c_TbiLkpMoeda.cmoes)
            THIS.txt_4c__moeda_desc.Value = ALLTRIM(cursor_4c_TbiLkpMoeda.dmoes)
            USE IN cursor_4c_TbiLkpMoeda
        ELSE
            IF USED("cursor_4c_TbiLkpMoeda")
                USE IN cursor_4c_TbiLkpMoeda
            ENDIF
            THIS.AbrirBuscaMoeda(loc_cValor)
        ENDIF

        *-- Reaplica a regra do When original (descricao editavel so com codigo vazio)
        THIS.AlternarPagina(1)

        THIS.txt_4c__moeda.Refresh()
        THIS.txt_4c__moeda_desc.Refresh()
    ENDPROC

    *==========================================================================
    * ValidarMoedaDesc - KeyPress do txt_4c__moeda_desc (get_moeda_desc).
    * Valida a descricao digitada contra SigCdMoe; se nao achar, abre o
    * lookup - espelha o Valid original de get_moeda_desc (fwBuscaExt por
    * DMoes).
    *==========================================================================
    PROCEDURE ValidarMoedaDesc(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_cValor, loc_cSQL, loc_nResultado

        IF !INLIST(par_nKeyCode, 13, 9, 115)
            RETURN
        ENDIF

        loc_cValor = ALLTRIM(UPPER(THIS.txt_4c__moeda_desc.Value))

        IF EMPTY(loc_cValor)
            THIS.txt_4c__moeda.Value      = ""
            THIS.txt_4c__moeda_desc.Value = ""
            RETURN
        ENDIF

        IF USED("cursor_4c_TbiLkpMoeda")
            USE IN cursor_4c_TbiLkpMoeda
        ENDIF

        loc_cSQL = "SELECT cmoes, dmoes FROM SigCdMoe"
        loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_TbiLkpMoeda")

        IF loc_nResultado > 0 AND USED("cursor_4c_TbiLkpMoeda")
            SELECT cursor_4c_TbiLkpMoeda
            LOCATE FOR ALLTRIM(UPPER(dmoes)) == loc_cValor
        ENDIF

        IF loc_nResultado > 0 AND USED("cursor_4c_TbiLkpMoeda") AND ;
           FOUND("cursor_4c_TbiLkpMoeda")
            THIS.txt_4c__moeda.Value      = ALLTRIM(cursor_4c_TbiLkpMoeda.cmoes)
            THIS.txt_4c__moeda_desc.Value = ALLTRIM(cursor_4c_TbiLkpMoeda.dmoes)
            USE IN cursor_4c_TbiLkpMoeda
        ELSE
            IF USED("cursor_4c_TbiLkpMoeda")
                USE IN cursor_4c_TbiLkpMoeda
            ENDIF
            THIS.AbrirBuscaMoeda(loc_cValor)
        ENDIF

        *-- Reaplica a regra do When original (descricao editavel so com codigo vazio)
        THIS.AlternarPagina(1)

        THIS.txt_4c__moeda.Refresh()
        THIS.txt_4c__moeda_desc.Refresh()
    ENDPROC

    *==========================================================================
    * AbrirBuscaMoeda - Abre o picker canonico (FormBuscaAuxiliar Pattern A)
    * filtrado pelo valor digitado (codigo OU descricao), preenchendo
    * txt_4c__moeda/txt_4c__moeda_desc com a selecao do usuario.
    *==========================================================================
    PROTECTED PROCEDURE AbrirBuscaMoeda(par_cValorDigitado)
        LOCAL loc_lSelecionou

        loc_lSelecionou = THIS.AbrirLookupCanonico("SigCdMoe", "cmoes", "dmoes", ;
            "Sele" + CHR(231) + CHR(227) + "o de Moeda", par_cValorDigitado, ;
            THIS.txt_4c__moeda, THIS.txt_4c__moeda_desc)

        IF !loc_lSelecionou
            THIS.txt_4c__moeda.Value      = ""
            THIS.txt_4c__moeda_desc.Value = ""
        ENDIF
    ENDPROC

    *==========================================================================
    * ConfigurarBotoes - Cria o CommandGroup com os 2 botoes do dialogo
    * (Confirma / Encerrar), espelhando cmd_grupo do original.
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarBotoes()
        LOCAL loc_oErro

        TRY
            THIS.AddObject("obj_4c_Cmd_grupo", "CommandGroup")
            WITH THIS.obj_4c_Cmd_grupo
                .Top          = -2
                .Left         = 123
                .Width        = 172
                .Height       = 110
                .ButtonCount  = 2
                .BackStyle    = 0
                .BorderStyle  = 0
                .SpecialEffect = 1
                .BorderColor  = RGB(100, 100, 100)
                .Themes       = .F.
                .Value        = 1

                WITH .Buttons(1)
                    .Top        = 5
                    .Left       = 11
                    .Width      = 75
                    .Height     = 75
                    .FontBold   = .T.
                    .FontItalic = .T.
                    .Picture    = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
                    .Caption    = "Confirma"
                    .ForeColor  = RGB(90, 90, 90)
                    .BackColor  = RGB(255, 255, 255)
                    .Themes     = .F.
                ENDWITH

                WITH .Buttons(2)
                    .Top          = 5
                    .Left         = 86
                    .Width        = 75
                    .Height       = 75
                    .Cancel       = .T.
                    .FontBold     = .T.
                    .FontItalic   = .T.
                    .FontName     = "Tahoma"
                    .FontSize     = 8
                    .Picture      = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
                    .Caption      = "Encerrar"
                    .ToolTipText  = "Encerrar"
                    .ForeColor    = RGB(90, 90, 90)
                    .BackColor    = RGB(255, 255, 255)
                    .Themes       = .F.
                ENDWITH

                .Visible = .T.
            ENDWITH

            BINDEVENT(THIS.obj_4c_Cmd_grupo.Buttons(1), "Click", THIS, "BtnConfirmarClick")
            BINDEVENT(THIS.obj_4c_Cmd_grupo.Buttons(2), "Click", THIS, "BtnEncerrarClick")

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, ;
                "Erro ConfigurarBotoes")
        ENDTRY
    ENDPROC

    *==========================================================================
    * BtnConfirmarClick - Valida moeda/copias, monta e imprime a tabela de
    * cambio (THIS.this_oBusinessObject.GerarTabelaReferencia), espelhando
    * cmd_ok.Click do original (sem a selecao de impressora de etiqueta
    * legada - imprime na impressora padrao do Windows).
    *==========================================================================
    PROCEDURE BtnConfirmarClick()
        LOCAL loc_cMoeda, loc_nCopias, loc_lSucesso, loc_nCopiaAtual, loc_oErro

        loc_cMoeda  = ALLTRIM(THIS.txt_4c__moeda.Value)
        loc_nCopias = THIS.txt_4c__copias.Value
        loc_lSucesso = .F.

        IF EMPTY(loc_cMoeda)
            MsgAviso("Moeda inv" + CHR(225) + "lida !", "Aten" + CHR(231) + CHR(227) + "o")
            THIS.txt_4c__moeda.SetFocus()
            RETURN
        ENDIF

        IF loc_nCopias < 1
            MsgAviso("Quantidade de c" + CHR(243) + "pias inv" + CHR(225) + "lida !", ;
                "Aten" + CHR(231) + CHR(227) + "o")
            THIS.txt_4c__copias.SetFocus()
            RETURN
        ENDIF

        IF !MsgConfirma("Confirma impress" + CHR(227) + "o das tabelas de " + ;
                "refer" + CHR(234) + "ncia ?", "Confirma" + CHR(231) + CHR(227) + "o")
            RETURN
        ENDIF

        THIS.FormParaBO()

        *-- Bloqueia os parametros enquanto os cursores sao montados e o
        *-- conteudo e enviado para a impressora
        THIS.AlternarPagina(2)

        TRY
            IF THIS.this_oBusinessObject.GerarTabelaReferencia(loc_cMoeda)
                SET PRINTER TO DEFAULT
                SET DEVICE TO PRINTER
                FOR loc_nCopiaAtual = 1 TO loc_nCopias
                    ?? THIS.this_oBusinessObject.this_cConteudoRelatorio
                    ?? CHR(12)
                ENDFOR
                SET DEVICE TO SCREEN
                SET PRINTER TO DEFAULT
                loc_lSucesso = .T.
            ELSE
                MsgAviso(THIS.this_oBusinessObject.this_cMensagemErro, ;
                    "Tabelas de Refer" + CHR(234) + "ncia")
            ENDIF
        CATCH TO loc_oErro
            SET DEVICE TO SCREEN
            SET PRINTER TO DEFAULT
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro ao Imprimir")
        ENDTRY

        IF loc_lSucesso
            *-- Como no cmd_ok.Click original, o dialogo se encerra apos imprimir
            THIS.Release()
        ELSE
            *-- Falhou: devolve o painel ao estado de entrada para nova tentativa
            THIS.AlternarPagina(1)
        ENDIF
    ENDPROC

    *==========================================================================
    * BtnEncerrarClick - Fecha o dialogo sem imprimir (cmd_cancela.Click).
    *==========================================================================
    PROCEDURE BtnEncerrarClick()
        THIS.Release()
    ENDPROC

    *==========================================================================
    * BtnSalvarClick / BtnCancelarClick - Aliases pelo contrato de nomenclatura
    * do FormBase. Neste dialogo, "Salvar" e "Cancelar" SAO, respectivamente,
    * o Confirma (cmd_ok - gera e imprime a tabela) e o Encerrar (cmd_cancela)
    * ja implementados acima - por isso apenas delegam, sem duplicar logica.
    *==========================================================================
    PROCEDURE BtnSalvarClick()
        THIS.BtnConfirmarClick()
    ENDPROC

    PROCEDURE BtnCancelarClick()
        THIS.BtnEncerrarClick()
    ENDPROC

    *==========================================================================
    * EVENTOS PRINCIPAIS (contrato de eventos do FormBase)
    *
    * NOTA DE ARQUITETURA - por que Incluir/Alterar/Excluir sao BLOQUEIOS e
    * nao operacoes de gravacao:
    *
    * SIGCDTBI ("Relatorio de Tabelas de Referencia") e um dialogo utilitario
    * de IMPRESSAO (284 x 197). O SCX original tem 10 objetos e UM UNICO
    * CommandGroup (cmd_grupo) com apenas cmd_ok (Confirma) e cmd_cancela
    * (Encerrar) - nao ha Grid, nao ha lista de registros e nao existem os
    * botoes Incluir/Alterar/Excluir/Buscar. Em nenhum ponto do codigo fonte
    * legado (Load, Init, os dois Valid, cmd_ok.Click, cmd_cancela.Click) ha
    * INSERT, UPDATE ou DELETE: o formulario apenas LE e VALIDA um codigo de
    * moeda ja existente em SigCdMoe para montar a tabela de cambio impressa.
    * A manutencao de SigCdMoe pertence exclusivamente ao Cadastro de Moedas
    * (FormMoe / MoeBO).
    *
    * Portanto NAO se acrescenta aqui nenhum botao CRUD: isso inventaria
    * funcionalidade inexistente no legado e violaria o PILAR 1 (UX identica
    * ao original). Os handlers abaixo existem para cumprir o contrato de
    * eventos do FormBase e para GARANTIR, com mensagem clara e estado
    * consistente, que uma chamada externa (menu, tecla de atalho herdada ou
    * codigo futuro) nao tente gravar por este formulario. Sao o espelho, na
    * camada de UI, dos overrides TBIBO.Inserir() / TBIBO.Atualizar(), que ja
    * bloqueiam a gravacao na camada de negocio retornando .F. com
    * this_cMensagemErro preenchido.
    *==========================================================================

    *==========================================================================
    * BtnIncluirClick - Bloqueia inclusao de moeda por este formulario.
    * Espelha o override TBIBO.Inserir() (que retorna .F.).
    *==========================================================================
    PROCEDURE BtnIncluirClick()
        THIS.this_cModoAtual = "LISTA"

        MsgAviso("Este formul" + CHR(225) + "rio n" + CHR(227) + "o cadastra moedas." + ;
            CHR(13) + "Utilize o Cadastro de Moedas para incluir novos registros.", ;
            "Tabelas de Refer" + CHR(234) + "ncia")

        *-- Devolve o dialogo ao estado de entrada e o foco ao codigo da moeda
        THIS.AlternarPagina(1)
        THIS.txt_4c__moeda.SetFocus()
    ENDPROC

    *==========================================================================
    * BtnAlterarClick - Bloqueia alteracao de moeda por este formulario.
    * Espelha o override TBIBO.Atualizar() (que retorna .F.).
    *==========================================================================
    PROCEDURE BtnAlterarClick()
        THIS.this_cModoAtual = "LISTA"

        MsgAviso("Este formul" + CHR(225) + "rio n" + CHR(227) + "o cadastra moedas." + ;
            CHR(13) + "Utilize o Cadastro de Moedas para alterar registros existentes.", ;
            "Tabelas de Refer" + CHR(234) + "ncia")

        THIS.AlternarPagina(1)
        THIS.txt_4c__moeda.SetFocus()
    ENDPROC

    *==========================================================================
    * BtnExcluirClick - Bloqueia exclusao de moeda por este formulario.
    * O legado nunca apaga SigCdMoe a partir de SIGCDTBI; excluir a moeda
    * usada como referencia aqui quebraria as cotacoes (SigCdCot) e as
    * tabelas de desconto (SigOpTdz) de todo o sistema.
    *==========================================================================
    PROCEDURE BtnExcluirClick()
        THIS.this_cModoAtual = "LISTA"

        MsgAviso("Este formul" + CHR(225) + "rio n" + CHR(227) + "o exclui moedas." + ;
            CHR(13) + "Utilize o Cadastro de Moedas para excluir registros.", ;
            "Tabelas de Refer" + CHR(234) + "ncia")

        THIS.AlternarPagina(1)
        THIS.txt_4c__moeda.SetFocus()
    ENDPROC

    *==========================================================================
    * BtnBuscarClick - Bloqueia busca/consulta de moeda por este formulario.
    * O SCX original nao tem Grid nem lista de registros (ver nota de
    * arquitetura em ConfigurarPaginaLista) - a consulta de moedas
    * cadastradas pertence ao Cadastro de Moedas.
    *==========================================================================
    PROCEDURE BtnBuscarClick()
        THIS.this_cModoAtual = "LISTA"

        MsgAviso("Este formul" + CHR(225) + "rio n" + CHR(227) + "o consulta moedas." + ;
            CHR(13) + "Utilize o Cadastro de Moedas para consultar registros existentes.", ;
            "Tabelas de Refer" + CHR(234) + "ncia")

        THIS.AlternarPagina(1)
        THIS.txt_4c__moeda.SetFocus()
    ENDPROC

    *==========================================================================
    * BtnVisualizarClick - Pre-visualiza, na tela, EXATAMENTE o conteudo que
    * BtnConfirmarClick enviaria para a impressora.
    *
    * Reaproveita integralmente a regra de negocio ja migrada do cmd_ok.Click
    * original (TBIBO.GerarTabelaReferencia): mesmas validacoes de moeda,
    * mesmas cotacoes (SigCdCot), mesmas tabelas de desconto (SigOpTdz com
    * rel_descs = 1) e mesmo layout de 40 colunas. A UNICA diferenca em
    * relacao a Confirma e o destino - tela em vez de impressora - e por isso
    * NAO ha aqui confirmacao de impressao, laco de copias, SET DEVICE TO
    * PRINTER nem THIS.Release(): o dialogo permanece aberto para o usuario
    * corrigir a moeda e imprimir em seguida.
    *
    * Nenhum botao novo e criado no formulario (o SCX legado tem apenas
    * Confirma / Encerrar) - este handler serve o contrato de eventos do
    * FormBase e chamadas externas.
    *==========================================================================
    PROCEDURE BtnVisualizarClick()
        LOCAL loc_cMoeda, loc_cConteudo, loc_oErro

        loc_cMoeda = ALLTRIM(THIS.txt_4c__moeda.Value)

        IF EMPTY(loc_cMoeda)
            MsgAviso("Moeda inv" + CHR(225) + "lida !", "Aten" + CHR(231) + CHR(227) + "o")
            THIS.txt_4c__moeda.SetFocus()
            RETURN
        ENDIF

        THIS.this_cModoAtual = "VISUALIZAR"
        THIS.FormParaBO()

        *-- Bloqueia os parametros enquanto os cursores sao montados
        THIS.AlternarPagina(2)

        TRY
            IF THIS.this_oBusinessObject.GerarTabelaReferencia(loc_cMoeda)
                loc_cConteudo = THIS.this_oBusinessObject.this_cConteudoRelatorio
                MsgInfo(loc_cConteudo, "Tabelas de Refer" + CHR(234) + "ncia - " + ;
                    "Pr" + CHR(233) + "-visualiza" + CHR(231) + CHR(227) + "o")
            ELSE
                MsgAviso(THIS.this_oBusinessObject.this_cMensagemErro, ;
                    "Tabelas de Refer" + CHR(234) + "ncia")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, ;
                "Erro ao Pr" + CHR(233) + "-visualizar")
        ENDTRY

        THIS.this_cModoAtual = "LISTA"
        THIS.AlternarPagina(1)
        THIS.txt_4c__moeda.SetFocus()
    ENDPROC

    *==========================================================================
    * TornarControlesVisiveis - Torna visiveis os controles de nivel raiz do form
    * cnt_4c_Sombra ja tem Visible=.T. definido em ConfigurarPageFrame
    *==========================================================================
    PROTECTED PROCEDURE TornarControlesVisiveis()
        LOCAL loc_oErro

        TRY
            THIS.TornarVisivelRecursivo(THIS)

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, ;
                "Erro TornarControlesVisiveis")
        ENDTRY
    ENDPROC

    *==========================================================================
    * TornarVisivelRecursivo - Percorre container recursivamente tornando visiveis
    *==========================================================================
    PROTECTED PROCEDURE TornarVisivelRecursivo(par_oContainer)
        LOCAL loc_i, loc_oCtrl
        FOR loc_i = 1 TO par_oContainer.ControlCount
            loc_oCtrl = par_oContainer.Controls(loc_i)
            IF VARTYPE(loc_oCtrl) = "O"
                IF PEMSTATUS(loc_oCtrl, "Visible", 5)
                    loc_oCtrl.Visible = .T.
                ENDIF
                IF PEMSTATUS(loc_oCtrl, "ControlCount", 5) AND ;
                   loc_oCtrl.ControlCount > 0
                    THIS.TornarVisivelRecursivo(loc_oCtrl)
                ENDIF
            ENDIF
        ENDFOR
    ENDPROC

    *==========================================================================
    PROCEDURE Destroy()
    *==========================================================================
        IF VARTYPE(THIS.this_oBusinessObject) = "O"
            THIS.this_oBusinessObject = .NULL.
        ENDIF
        DODEFAULT()
    ENDPROC

ENDDEFINE

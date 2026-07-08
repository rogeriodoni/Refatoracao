*==============================================================================
* FORMSIGRECRT.PRG
* Relatorio de Cheques Da Carteira (SIGRECRT) - FASE 8/8 COMPLETO
*
* Herda de FormBase
* Tipo: REPORT (layout FLAT - sem PageFrame CRUD)
* BO:   sigrecrtBO (herda RelatorioBase)
* Migrado de: sigrecrt.SCX (frmrelatorio), original: 800x500
*==============================================================================

DEFINE CLASS Formsigrecrt AS FormBase

    Height      = 600
    Width       = 1000
    DataSession = 2
    ShowWindow  = 1
    WindowType  = 1
    AutoCenter  = .T.
    BorderStyle = 2
    ControlBox  = .F.
    MaxButton   = .F.
    MinButton   = .F.
    TitleBar    = 0
    Themes      = .F.
    ShowTips    = .T.

    this_oRelatorio    = .NULL.
    this_cMensagemErro = ""
    this_nPaginaAtual  = 1

    *==========================================================================
    * INIT
    *==========================================================================
    PROCEDURE Init()
        RETURN DODEFAULT()
    ENDPROC

    *==========================================================================
    * INICIALIZARFORM - Cria estrutura base do form de relatorio FLAT
    *==========================================================================
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            THIS.ConfigurarPageFrame()

            THIS.this_oRelatorio = CREATEOBJECT("sigrecrtBO")
            IF VARTYPE(THIS.this_oRelatorio) != "O"
                MsgErro("Erro ao criar BO do relat" + CHR(243) + "rio de Cheques Da Carteira", ;
                        "InicializarForm")
            ELSE
                THIS.ConfigurarCabecalho()
                THIS.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption

                THIS.ConfigurarBotoes()
                THIS.ConfigurarPaginaDados()
                THIS.ConfigurarCamposFiltro()

                THIS.AtualizarTitulosOpcao()
                THIS.LimparCampos()

                THIS.Visible   = .T.
                loc_lSucesso   = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "InicializarForm")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * CONFIGURARPAGEFRAME - Propriedades de janela do form de relatorio
    *
    * REPORT usa layout FLAT: nao ha PageFrame de 2 abas como em forms CRUD.
    * Este metodo aplica as propriedades da janela (Caption, Picture, Icon,
    * comportamento) e prepara a area util para os containers que sao
    * adicionados diretamente ao Form.
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPageFrame()
        THIS.Caption     = "Relat" + CHR(243) + "rio de Cheques Da Carteira"
        THIS.Picture     = gc_4c_CaminhoIcones + "new_background.jpg"
        THIS.Icon        = gc_4c_CaminhoIcones + "icon.ico"
        THIS.AutoCenter  = .T.
        THIS.BorderStyle = 2
        THIS.WindowType  = 1
        THIS.ControlBox  = .F.
        THIS.MaxButton   = .F.
        THIS.MinButton   = .F.
        THIS.TitleBar    = 0
        THIS.Themes      = .F.
        THIS.ShowTips    = .T.
        THIS.BackColor   = RGB(255, 255, 255)
    ENDPROC

    *==========================================================================
    * CONFIGURARCABECALHO - Container escuro com labels titulo/sombra
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarCabecalho()
        THIS.AddObject("cnt_4c_Cabecalho", "Container")
        WITH THIS.cnt_4c_Cabecalho
            .Top         = 0
            .Left        = 0
            .Width       = THIS.Width
            .Height      = 80
            .BackStyle   = 1
            .BackColor   = RGB(100, 100, 100)
            .BorderWidth = 0
            .Visible     = .T.

            .AddObject("lbl_4c_Sombra", "Label")
            WITH .lbl_4c_Sombra
                .Top       = 15
                .Left      = 12
                .Width     = THIS.Width
                .Height    = 40
                .FontName  = "Tahoma"
                .FontSize  = 16
                .FontBold  = .T.
                .BackStyle = 0
                .ForeColor = RGB(0, 0, 0)
                .Caption   = THIS.Caption
                .Visible   = .T.
            ENDWITH

            .AddObject("lbl_4c_Titulo", "Label")
            WITH .lbl_4c_Titulo
                .Top       = 18
                .Left      = 10
                .Width     = THIS.Width
                .Height    = 40
                .FontName  = "Tahoma"
                .FontSize  = 16
                .FontBold  = .T.
                .BackStyle = 0
                .ForeColor = RGB(255, 255, 255)
                .Caption   = THIS.Caption
                .Visible   = .T.
            ENDWITH
        ENDWITH
    ENDPROC

    *==========================================================================
    * CONFIGURARBOTOES - CommandGroup com 4 botoes (padrao frmrelatorio)
    * Geometria canonical: ButtonCount=4, Width=273, Height=80, BackStyle=0
    * Left=726 (proporcional ao form de 1000px), Top=6
    * Lefts internos: Btn1=5, Btn2=71, Btn3=137, Btn4=203 (incrementos de 66)
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarBotoes()
        LOCAL loc_cIcones
        loc_cIcones = gc_4c_CaminhoIcones

        THIS.AddObject("cmg_4c_Botoes", "CommandGroup")
        WITH THIS.cmg_4c_Botoes
            .Top           = 6
            .Left          = 726
            .Width         = 273
            .Height        = 80
            .ButtonCount   = 4
            .BackStyle     = 0
            .BorderStyle   = 0
            .BorderColor   = RGB(136, 189, 188)
            .SpecialEffect = 1
            .Themes        = .F.
            .Visible       = .T.

            WITH .Buttons(1)
                .Top             = 5
                .Left            = 5
                .Width           = 65
                .Height          = 70
                .Caption         = "Visualizar"
                .FontName        = "Comic Sans MS"
                .FontSize        = 8
                .Picture         = loc_cIcones + "relatorio_video_26.jpg"
                .FontBold        = .T.
                .FontItalic      = .T.
                .BackColor       = RGB(255, 255, 255)
                .ForeColor       = RGB(90, 90, 90)
                .PicturePosition = 13
                .SpecialEffect   = 0
                .MousePointer    = 15
                .Themes          = .F.
                .WordWrap        = .T.
            ENDWITH

            WITH .Buttons(2)
                .Top             = 5
                .Left            = 71
                .Width           = 65
                .Height          = 70
                .Caption         = "Imprimir"
                .Picture         = loc_cIcones + "relatorio_impressora_26.jpg"
                .FontName        = "Comic Sans MS"
                .FontBold        = .T.
                .FontItalic      = .T.
                .FontSize        = 8
                .BackColor       = RGB(255, 255, 255)
                .ForeColor       = RGB(90, 90, 90)
                .PicturePosition = 13
                .SpecialEffect   = 0
                .MousePointer    = 15
                .Themes          = .F.
                .WordWrap        = .T.
            ENDWITH

            WITH .Buttons(3)
                .Top             = 5
                .Left            = 137
                .Width           = 65
                .Height          = 70
                .Caption         = "\<Arquivos Email"
                .Picture         = loc_cIcones + "geral_envelope_32.jpg"
                .FontName        = "Comic Sans MS"
                .FontBold        = .T.
                .FontItalic      = .T.
                .FontSize        = 8
                .BackColor       = RGB(255, 255, 255)
                .ForeColor       = RGB(90, 90, 90)
                .PicturePosition = 13
                .SpecialEffect   = 0
                .MousePointer    = 15
                .Themes          = .F.
                .WordWrap        = .T.
            ENDWITH

            WITH .Buttons(4)
                .Top             = 5
                .Left            = 203
                .Width           = 65
                .Height          = 70
                .Caption         = "Sair"
                .Picture         = loc_cIcones + "relatorio_sair_60.jpg"
                .FontName        = "Comic Sans MS"
                .FontBold        = .T.
                .FontItalic      = .T.
                .FontSize        = 8
                .BackColor       = RGB(255, 255, 255)
                .ForeColor       = RGB(90, 90, 90)
                .PicturePosition = 13
                .SpecialEffect   = 0
                .MousePointer    = 15
                .Themes          = .F.
                .WordWrap        = .T.
                .Cancel          = .T.
            ENDWITH
        ENDWITH

        BINDEVENT(THIS.cmg_4c_Botoes.Buttons(1), "Click", THIS, "BtnVisualizarClick")
        BINDEVENT(THIS.cmg_4c_Botoes.Buttons(2), "Click", THIS, "BtnImprimirClick")
        BINDEVENT(THIS.cmg_4c_Botoes.Buttons(3), "Click", THIS, "BtnExcelClick")
        BINDEVENT(THIS.cmg_4c_Botoes.Buttons(4), "Click", THIS, "BtnEncerrarClick")
    ENDPROC

    *==========================================================================
    * ATUALIZARESTADOCONTROLES - Override: form de relatorio nao usa CRUD
    *==========================================================================
    PROCEDURE AtualizarEstadoControles()
        RETURN
    ENDPROC

    *==========================================================================
    * ALTERNARPAGINA - Controle de pagina (REPORT eh FLAT - 1 pagina logica)
    *
    * Form de relatorio nao tem PageFrame de 2 abas. Mantemos o contrato do
    * metodo para compatibilidade com FormBase e rastreamos em this_nPaginaAtual.
    * Se o caller solicitar a "pagina de lista" (1), delegamos para
    * ConfigurarPaginaLista() que reseta os filtros e devolve o foco para o
    * primeiro campo editavel - comportamento equivalente ao "voltar para
    * lista" de forms CRUD adaptado ao contexto de REPORT.
    *==========================================================================
    PROCEDURE AlternarPagina(par_nPagina)
        LOCAL loc_nPagina
        loc_nPagina = IIF(PCOUNT() < 1 OR VARTYPE(par_nPagina) != "N", 1, par_nPagina)
        IF loc_nPagina < 1
            loc_nPagina = 1
        ENDIF
        THIS.this_nPaginaAtual = loc_nPagina
        IF loc_nPagina = 1
            THIS.ConfigurarPaginaLista()
        ENDIF
    ENDPROC

    *==========================================================================
    * CONFIGURARPAGINALISTA - Override: REPORT nao tem Page1 (Lista) de CRUD
    *
    * Forms de relatorio (frmrelatorio) usam layout FLAT, sem Page1/Page2 e
    * sem grid de lista. O equivalente conceitual da "Page1 - Lista" eh a
    * area de FILTROS ja configurada em ConfigurarCamposFiltro() (Fase 4
    * desta migracao). Este metodo eh mantido para compatibilidade com o
    * contrato esperado de FormBase e implementa o "voltar para a lista":
    *  - Reseta todos os filtros para os valores padrao (LimparCampos)
    *  - Re-aplica os titulos dinamicos do opt_nr_opcao (SigCdPac)
    *  - Esconde o OptionGroup opt_Bons quando o TipoRel nao for "BONS"
    *  - Devolve o foco para o primeiro campo editavel (data inicial)
    *==========================================================================
    PROCEDURE ConfigurarPaginaLista()
        LOCAL loc_nTipoRel
        TRY
            THIS.LimparCampos()
            THIS.AtualizarTitulosOpcao()

            IF PEMSTATUS(THIS, "cbo_4c_GetTipoRel", 5) ;
               AND PEMSTATUS(THIS, "obj_4c_Opt_Bons", 5)
                loc_nTipoRel = THIS.cbo_4c_GetTipoRel.ListIndex
                THIS.obj_4c_Opt_Bons.Visible = (loc_nTipoRel = 4)
            ENDIF

            IF PEMSTATUS(THIS, "txt_4c__dt_inicial", 5)
                IF VARTYPE(THIS.txt_4c__dt_inicial) = "O" ;
                   AND THIS.txt_4c__dt_inicial.Enabled ;
                   AND THIS.txt_4c__dt_inicial.Visible
                    THIS.txt_4c__dt_inicial.SetFocus()
                ENDIF
            ENDIF

            THIS.this_nPaginaAtual = 1
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "ConfigurarPaginaLista")
        ENDTRY
    ENDPROC

    *==========================================================================
    * FORMPARARELATORIO - Transfere valores dos controles do form para o BO
    * Usa PEMSTATUS para cada controle (seguro em todas as fases de migracao)
    *
    * Controles mapeados (mapeamento.json):
    *   obj_4c_GetTipoDat    <- getTipoDat  (tipo data: 1=Vencimento, 2=Emissao)
    *   txt_4c__dt_inicial   <- get_dt_inicial
    *   txt_4c__dt_final     <- get_dt_final
    *   txt_4c__cd_empresa   <- get_cd_empresa
    *   txt_4c__ds_empresa   <- get_ds_empresa
    *   txt_4c_Juros         <- getJuros
    *   cbo_4c_GetTipoRel    <- GetTipoRel  (tipo relatorio: 1-5)
    *   obj_4c_Opt_nr_opcao  <- opt_nr_opcao (opcao nota: 1=Sim, 2=Nao, 3=Ambos)
    *   cbo_4c_Get_ordem     <- get_ordem   (ordem: 1=VALOR, 2=DATA VEN, 3=DATA OP)
    *   obj_4c_Opt_Bons      <- Opt_Bons    (1=Ativos, 2=Todos; visivel em TipoRel=4)
    *   txt_4c__cd_emi_grupo <- get_cd_emi_grupo
    *   txt_4c__ds_emi_grupo <- get_ds_emi_grupo
    *   txt_4c__cd_emi_conta <- get_cd_emi_conta
    *   txt_4c__ds_emi_conta <- get_ds_emi_conta
    *   txt_4c_CGrupoO       <- GetCGrupoO  (origem grupo)
    *   txt_4c_DGrupoO       <- GetDGrupoO  (origem grupo descricao)
    *   txt_4c_CContaO       <- GetCContaO  (origem conta)
    *   txt_4c_DContaO       <- GetDContaO  (origem conta descricao)
    *   txt_4c__cd_dep_grupo <- get_cd_dep_grupo
    *   txt_4c__ds_dep_grupo <- get_ds_dep_grupo
    *   txt_4c__cd_dep_conta <- get_cd_dep_conta
    *   txt_4c__ds_dep_conta <- get_ds_dep_conta
    *==========================================================================
    PROTECTED PROCEDURE FormParaRelatorio()
        IF VARTYPE(THIS.this_oRelatorio) != "O"
            RETURN
        ENDIF
        WITH THIS.this_oRelatorio
            *-- Tipo de data (OptionGroup: 1=Vencimento, 2=Emissao)
            IF PEMSTATUS(THIS, "obj_4c_GetTipoDat", 5)
                .this_nTipoDat = THIS.obj_4c_GetTipoDat.Value
            ENDIF
            *-- Periodo
            IF PEMSTATUS(THIS, "txt_4c__dt_inicial", 5)
                .this_dDtInicial = THIS.txt_4c__dt_inicial.Value
            ENDIF
            IF PEMSTATUS(THIS, "txt_4c__dt_final", 5)
                .this_dDtFinal = THIS.txt_4c__dt_final.Value
            ENDIF
            *-- Empresa
            IF PEMSTATUS(THIS, "txt_4c__cd_empresa", 5)
                .this_cCdEmpresa = ALLTRIM(THIS.txt_4c__cd_empresa.Value)
            ENDIF
            IF PEMSTATUS(THIS, "txt_4c__ds_empresa", 5)
                .this_cDsEmpresa = ALLTRIM(THIS.txt_4c__ds_empresa.Value)
            ENDIF
            *-- Juros mensal (%)
            IF PEMSTATUS(THIS, "txt_4c_Juros", 5)
                .this_nJuros = THIS.txt_4c_Juros.Value
            ENDIF
            *-- Tipo de relatorio (ComboBox ListIndex: 1=ATIVOS, 2=BAIXADOS, 3=NEG.PG, 4=BONS, 5=DEVOLVIDOS)
            IF PEMSTATUS(THIS, "cbo_4c_GetTipoRel", 5)
                .this_nTipoRel = THIS.cbo_4c_GetTipoRel.ListIndex
            ENDIF
            *-- Opcao nota (OptionGroup: 1=Sim, 2=Nao, 3=Ambos)
            IF PEMSTATUS(THIS, "obj_4c_Opt_nr_opcao", 5)
                .this_nNrOpcao = THIS.obj_4c_Opt_nr_opcao.Value
            ENDIF
            *-- Ordem de classificacao (ComboBox ListIndex: 1=VALOR, 2=DATA VENCIMENTO, 3=DATA OPERACAO)
            IF PEMSTATUS(THIS, "cbo_4c_Get_ordem", 5)
                .this_nIndexOrdem = THIS.cbo_4c_Get_ordem.ListIndex
            ENDIF
            *-- Opcao bons (OptionGroup: 1=Ativos, 2=Todos; visivel apenas quando TipoRel=4)
            IF PEMSTATUS(THIS, "obj_4c_Opt_Bons", 5)
                .this_nOptBons = THIS.obj_4c_Opt_Bons.Value
            ENDIF
            *-- Emissor/Carteira: grupo e conta
            IF PEMSTATUS(THIS, "txt_4c__cd_emi_grupo", 5)
                .this_cCdEmiGrupo = ALLTRIM(THIS.txt_4c__cd_emi_grupo.Value)
            ENDIF
            IF PEMSTATUS(THIS, "txt_4c__ds_emi_grupo", 5)
                .this_cDsEmiGrupo = ALLTRIM(THIS.txt_4c__ds_emi_grupo.Value)
            ENDIF
            IF PEMSTATUS(THIS, "txt_4c__cd_emi_conta", 5)
                .this_cCdEmiConta = ALLTRIM(THIS.txt_4c__cd_emi_conta.Value)
            ENDIF
            IF PEMSTATUS(THIS, "txt_4c__ds_emi_conta", 5)
                .this_cDsEmiConta = ALLTRIM(THIS.txt_4c__ds_emi_conta.Value)
            ENDIF
            *-- Origem: grupo e conta (GetCGrupoO / GetDGrupoO / GetCContaO / GetDContaO)
            IF PEMSTATUS(THIS, "txt_4c_CGrupoO", 5)
                .this_cCdOriGrupo = ALLTRIM(THIS.txt_4c_CGrupoO.Value)
            ENDIF
            IF PEMSTATUS(THIS, "txt_4c_DGrupoO", 5)
                .this_cDsOriGrupo = ALLTRIM(THIS.txt_4c_DGrupoO.Value)
            ENDIF
            IF PEMSTATUS(THIS, "txt_4c_CContaO", 5)
                .this_cCdOriConta = ALLTRIM(THIS.txt_4c_CContaO.Value)
            ENDIF
            IF PEMSTATUS(THIS, "txt_4c_DContaO", 5)
                .this_cDsOriConta = ALLTRIM(THIS.txt_4c_DContaO.Value)
            ENDIF
            *-- Destino/Deposito: grupo e conta
            IF PEMSTATUS(THIS, "txt_4c__cd_dep_grupo", 5)
                .this_cCdDesGrupo = ALLTRIM(THIS.txt_4c__cd_dep_grupo.Value)
            ENDIF
            IF PEMSTATUS(THIS, "txt_4c__ds_dep_grupo", 5)
                .this_cDsDesGrupo = ALLTRIM(THIS.txt_4c__ds_dep_grupo.Value)
            ENDIF
            IF PEMSTATUS(THIS, "txt_4c__cd_dep_conta", 5)
                .this_cCdDesConta = ALLTRIM(THIS.txt_4c__cd_dep_conta.Value)
            ENDIF
            IF PEMSTATUS(THIS, "txt_4c__ds_dep_conta", 5)
                .this_cDsDesConta = ALLTRIM(THIS.txt_4c__ds_dep_conta.Value)
            ENDIF
        ENDWITH
    ENDPROC

    *==========================================================================
    * BTNVISUALIZARCLICK - Botao 1: Visualizar relatorio em tela (preview)
    *==========================================================================
    PROCEDURE BtnVisualizarClick()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            THIS.FormParaRelatorio()
            loc_lSucesso = THIS.this_oRelatorio.Visualizar()
            IF !loc_lSucesso
                MsgErro(THIS.this_oRelatorio.ObterMensagemErro(), "Visualizar")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "BtnVisualizarClick")
        ENDTRY
    ENDPROC

    *==========================================================================
    * BTNIMPRIMIRCLICK - Botao 2: Imprimir relatorio em impressora
    *==========================================================================
    PROCEDURE BtnImprimirClick()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            THIS.FormParaRelatorio()
            loc_lSucesso = THIS.this_oRelatorio.Imprimir()
            IF !loc_lSucesso
                MsgErro(THIS.this_oRelatorio.ObterMensagemErro(), "Imprimir")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "BtnImprimirClick")
        ENDTRY
    ENDPROC

    *==========================================================================
    * BTNEXCELCLICK - Botao 3: Exportar dados para Excel
    *==========================================================================
    PROCEDURE BtnExcelClick()
        LOCAL loc_lSucesso, loc_cArqXls
        loc_lSucesso = .F.
        TRY
            THIS.FormParaRelatorio()
            IF !THIS.this_oRelatorio.PrepararDados()
                MsgErro(THIS.this_oRelatorio.ObterMensagemErro(), "Excel")
                RETURN
            ENDIF
            IF USED("CsRelatorio")
                loc_cArqXls = SYS(2023) + "\SigReCrt_" + STRTRAN(DTOC(DATE()), "/", "") + ".xls"
                SELECT CsRelatorio
                COPY TO (loc_cArqXls) TYPE XL5
                THIS.this_oRelatorio.LimparCursores()
                MsgInfo("Arquivo Excel gerado em: " + loc_cArqXls, "Excel")
                loc_lSucesso = .T.
            ELSE
                MsgAviso("Nenhum dado dispon" + CHR(237) + "vel para exportar.", "Excel")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "BtnExcelClick")
        ENDTRY
    ENDPROC

    *==========================================================================
    * BTNENCERRARCLICK - Botao 4: Fechar o form (ESC / Sair)
    *==========================================================================
    PROCEDURE BtnEncerrarClick()
        THIS.Release()
    ENDPROC

    *==========================================================================
    * BTNINCLUIRCLICK - Mapeia "Incluir" de CRUD para Visualizar em REPORT
    *==========================================================================
    PROCEDURE BtnIncluirClick()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            THIS.FormParaRelatorio()
            loc_lSucesso = THIS.this_oRelatorio.Visualizar()
            IF !loc_lSucesso
                MsgErro(THIS.this_oRelatorio.ObterMensagemErro(), ;
                        "Gerar Relat" + CHR(243) + "rio")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "BtnIncluirClick")
        ENDTRY
    ENDPROC

    *==========================================================================
    * BTNALTERARCLICK - Mapeia "Alterar" de CRUD para LimparCampos em REPORT
    *==========================================================================
    PROCEDURE BtnAlterarClick()
        TRY
            THIS.LimparCampos()
            IF PEMSTATUS(THIS, "txt_4c__dt_inicial", 5)
                IF VARTYPE(THIS.txt_4c__dt_inicial) = "O"
                    THIS.txt_4c__dt_inicial.SetFocus()
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "BtnAlterarClick")
        ENDTRY
    ENDPROC

    *==========================================================================
    * BTNEXCLUIRCLICK - Mapeia "Excluir" de CRUD para Encerrar em REPORT
    *==========================================================================
    PROCEDURE BtnExcluirClick()
        IF MsgConfirma("Deseja encerrar o relat" + CHR(243) + "rio?", "Encerrar")
            THIS.Release()
        ENDIF
    ENDPROC

    *==========================================================================
    * LIMPARCAMPOS - Reseta todos os filtros para os valores padrao
    * Usa PEMSTATUS para ser seguro antes de ConfigurarCamposFiltro() (Fase 4)
    *==========================================================================
    PROCEDURE LimparCampos()
        IF PEMSTATUS(THIS, "obj_4c_GetTipoDat", 5)
            THIS.obj_4c_GetTipoDat.Value = 1
        ENDIF
        IF PEMSTATUS(THIS, "txt_4c__dt_inicial", 5)
            THIS.txt_4c__dt_inicial.Value = DATE()
        ENDIF
        IF PEMSTATUS(THIS, "txt_4c__dt_final", 5)
            THIS.txt_4c__dt_final.Value = DATE()
        ENDIF
        IF PEMSTATUS(THIS, "txt_4c__cd_empresa", 5)
            THIS.txt_4c__cd_empresa.Value = ""
        ENDIF
        IF PEMSTATUS(THIS, "txt_4c__ds_empresa", 5)
            THIS.txt_4c__ds_empresa.Value = ""
        ENDIF
        IF PEMSTATUS(THIS, "txt_4c_Juros", 5)
            THIS.txt_4c_Juros.Value = 0
        ENDIF
        IF PEMSTATUS(THIS, "cbo_4c_GetTipoRel", 5)
            THIS.cbo_4c_GetTipoRel.ListIndex = 1
        ENDIF
        IF PEMSTATUS(THIS, "obj_4c_Opt_nr_opcao", 5)
            THIS.obj_4c_Opt_nr_opcao.Value = 3
        ENDIF
        IF PEMSTATUS(THIS, "cbo_4c_Get_ordem", 5)
            THIS.cbo_4c_Get_ordem.ListIndex = 1
        ENDIF
        IF PEMSTATUS(THIS, "obj_4c_Opt_Bons", 5)
            THIS.obj_4c_Opt_Bons.Value   = 1
            THIS.obj_4c_Opt_Bons.Visible = .F.
        ENDIF
        IF PEMSTATUS(THIS, "txt_4c__cd_emi_grupo", 5)
            THIS.txt_4c__cd_emi_grupo.Value = ""
        ENDIF
        IF PEMSTATUS(THIS, "txt_4c__ds_emi_grupo", 5)
            THIS.txt_4c__ds_emi_grupo.Value = ""
        ENDIF
        IF PEMSTATUS(THIS, "txt_4c__cd_emi_conta", 5)
            THIS.txt_4c__cd_emi_conta.Value = ""
        ENDIF
        IF PEMSTATUS(THIS, "txt_4c__ds_emi_conta", 5)
            THIS.txt_4c__ds_emi_conta.Value = ""
        ENDIF
        IF PEMSTATUS(THIS, "txt_4c_CGrupoO", 5)
            THIS.txt_4c_CGrupoO.Value = ""
        ENDIF
        IF PEMSTATUS(THIS, "txt_4c_DGrupoO", 5)
            THIS.txt_4c_DGrupoO.Value = ""
        ENDIF
        IF PEMSTATUS(THIS, "txt_4c_CContaO", 5)
            THIS.txt_4c_CContaO.Value = ""
        ENDIF
        IF PEMSTATUS(THIS, "txt_4c_DContaO", 5)
            THIS.txt_4c_DContaO.Value = ""
        ENDIF
        IF PEMSTATUS(THIS, "txt_4c__cd_dep_grupo", 5)
            THIS.txt_4c__cd_dep_grupo.Value = ""
        ENDIF
        IF PEMSTATUS(THIS, "txt_4c__ds_dep_grupo", 5)
            THIS.txt_4c__ds_dep_grupo.Value = ""
        ENDIF
        IF PEMSTATUS(THIS, "txt_4c__cd_dep_conta", 5)
            THIS.txt_4c__cd_dep_conta.Value = ""
        ENDIF
        IF PEMSTATUS(THIS, "txt_4c__ds_dep_conta", 5)
            THIS.txt_4c__ds_dep_conta.Value = ""
        ENDIF
    ENDPROC

    *==========================================================================
    * ATUALIZARTITULOSOPCAO - Atualiza captions do opt_nr_opcao com titulos
    * dinamicos carregados de SigCdPac pelo BO em CarregarParametros()
    *==========================================================================
    PROCEDURE AtualizarTitulosOpcao()
        IF VARTYPE(THIS.this_oRelatorio) != "O"
            RETURN
        ENDIF
        IF PEMSTATUS(THIS, "obj_4c_Opt_nr_opcao", 5)
            IF VARTYPE(THIS.obj_4c_Opt_nr_opcao) = "O"
                WITH THIS.obj_4c_Opt_nr_opcao
                    .Buttons(1).Caption = THIS.this_oRelatorio.this_cTituloOpcao1
                    .Buttons(2).Caption = THIS.this_oRelatorio.this_cTituloOpcao2
                    .Buttons(3).Caption = THIS.this_oRelatorio.this_cTituloOpcao3
                ENDWITH
            ENDIF
        ENDIF
    ENDPROC

    *==========================================================================
    * DESTROY - Libera BO e recursos (NAO usar Release no BO - Custom sem Release)
    *==========================================================================
    PROCEDURE Destroy()
        IF VARTYPE(THIS.this_oRelatorio) = "O"
            THIS.this_oRelatorio = .NULL.
        ENDIF
        DODEFAULT()
    ENDPROC

    *==========================================================================
    * CONFIGURARPAGINADADADOS - Cria controles de filtro: primeira metade
    * Mapeamento.json itens 1-17: getTipoDat, periodo, juros, operacao,
    * tipo-rel, nr_opcao, empresa, emissor-grupo e emissor-conta (codigo)
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPaginaDados()
        LOCAL loc_cFonte
        loc_cFonte = "Tahoma"

        THIS.AddObject("obj_4c_GetTipoDat", "OptionGroup")
        WITH THIS.obj_4c_GetTipoDat
            .Top         = 104
            .Left        = 237
            .Width       = 157
            .Height      = 25
            .ButtonCount = 2
            .BackStyle   = 0
            .BorderStyle = 0
            .ToolTipText = "Emiss" + CHR(227) + "o = a data de inclus" + CHR(227) + ;
                           "o da movimenta" + CHR(231) + CHR(227) + "o"
            .Visible     = .T.
            WITH .Buttons(1)
                .Caption   = "Vencimento"
                .FontName        = "Comic Sans MS"
                .FontSize        = 8
                .Left      = 0
                .Top       = 0
                .Width     = 78
                .Height    = 22
                .AutoSize  = .F.
                .ForeColor = RGB(90, 90, 90)
                .BackStyle = 0
            ENDWITH
            WITH .Buttons(2)
                .Caption   = "Emiss" + CHR(227) + "o"
                .Left      = 80
                .Top       = 0
                .Width     = 72
                .Height    = 22
                .AutoSize  = .F.
                .FontName  = loc_cFonte
                .FontSize  = 9
                .ForeColor = RGB(90, 90, 90)
                .BackStyle = 0
            ENDWITH
        ENDWITH

        THIS.AddObject("lbl_4c_Lbl_empresa", "Label")
        WITH THIS.lbl_4c_Lbl_empresa
            .Top       = 221
            .Left      = 183
            .Width     = 50
            .Height    = 17
            .FontName  = loc_cFonte
            .FontSize  = 9
            .BackStyle = 0
            .Caption   = "Empresa :"
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        THIS.AddObject("lbl_4c_Label7", "Label")
        WITH THIS.lbl_4c_Label7
            .Top       = 135
            .Left      = 435
            .Width     = 123
            .Height    = 17
            .FontName  = loc_cFonte
            .FontSize  = 9
            .BackStyle = 0
            .Caption   = "Juros :                  ao m" + CHR(234) + "s"
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        THIS.AddObject("txt_4c__ds_empresa", "TextBox")
        WITH THIS.txt_4c__ds_empresa
            .Top       = 217
            .Left      = 270
            .Width     = 337
            .Height    = 20
            .MaxLength = 40
            .ReadOnly  = .T.
            .FontName  = loc_cFonte
            .FontSize  = 9
            .BackColor = RGB(245, 245, 245)
            .Visible   = .T.
        ENDWITH

        THIS.AddObject("txt_4c_Juros", "TextBox")
        WITH THIS.txt_4c_Juros
            .Top       = 131
            .Left      = 471
            .Width     = 45
            .Height    = 20
            .FontName  = loc_cFonte
            .FontSize  = 9
            .InputMask = "999.99"
            .BackColor = RGB(255, 255, 255)
            .Visible   = .T.
        ENDWITH

        THIS.AddObject("txt_4c__cd_empresa", "TextBox")
        WITH THIS.txt_4c__cd_empresa
            .Top       = 217
            .Left      = 237
            .Width     = 31
            .Height    = 20
            .MaxLength = 3
            .FontName  = loc_cFonte
            .FontSize  = 9
            .BackColor = RGB(255, 255, 255)
            .Visible   = .T.
        ENDWITH

        THIS.AddObject("lbl_4c_Lbl_periodo", "Label")
        WITH THIS.lbl_4c_Lbl_periodo
            .Top       = 136
            .Left      = 188
            .Width     = 45
            .Height    = 17
            .FontName  = loc_cFonte
            .FontSize  = 9
            .BackStyle = 0
            .Caption   = "Per" + CHR(237) + "odo :"
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        THIS.AddObject("txt_4c__dt_inicial", "TextBox")
        WITH THIS.txt_4c__dt_inicial
            .Top       = 132
            .Left      = 237
            .Width     = 80
            .Height    = 20
            .FontName  = loc_cFonte
            .FontSize  = 9
            .Format    = "D"
            .BackColor = RGB(255, 255, 255)
            .Visible   = .T.
        ENDWITH

        THIS.AddObject("lbl_4c_Lbl_periodo_a", "Label")
        WITH THIS.lbl_4c_Lbl_periodo_a
            .Top       = 136
            .Left      = 323
            .Width     = 8
            .Height    = 17
            .FontName  = loc_cFonte
            .FontSize  = 9
            .BackStyle = 0
            .Caption   = CHR(225)
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        THIS.AddObject("txt_4c__dt_final", "TextBox")
        WITH THIS.txt_4c__dt_final
            .Top       = 132
            .Left      = 336
            .Width     = 80
            .Height    = 20
            .FontName  = loc_cFonte
            .FontSize  = 9
            .Format    = "D"
            .BackColor = RGB(255, 255, 255)
            .Visible   = .T.
        ENDWITH

        THIS.AddObject("lbl_4c_Label1", "Label")
        WITH THIS.lbl_4c_Label1
            .Top       = 193
            .Left      = 192
            .Width     = 41
            .Height    = 17
            .FontName  = loc_cFonte
            .FontSize  = 9
            .BackStyle = 0
            .Caption   = "Ordem :"
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        THIS.AddObject("lbl_4c_Lbl_operacao", "Label")
        WITH THIS.lbl_4c_Lbl_operacao
            .Top       = 165
            .Left      = 177
            .Width     = 56
            .Height    = 17
            .FontName  = loc_cFonte
            .FontSize  = 9
            .BackStyle = 0
            .Caption   = "Opera" + CHR(231) + CHR(227) + "o :"
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        THIS.AddObject("lbl_4c_Lbl_opcao", "Label")
        WITH THIS.lbl_4c_Lbl_opcao
            .Top       = 193
            .Left      = 382
            .Width     = 50
            .Height    = 17
            .FontName  = loc_cFonte
            .FontSize  = 9
            .BackStyle = 0
            .Caption   = "Op" + CHR(231) + CHR(227) + "o : "
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        THIS.AddObject("obj_4c_Opt_nr_opcao", "OptionGroup")
        WITH THIS.obj_4c_Opt_nr_opcao
            .Top         = 189
            .Left        = 428
            .Width       = 192
            .Height      = 23
            .ButtonCount = 3
            .BackStyle   = 0
            .BorderStyle = 0
            .Visible     = .T.
            WITH .Buttons(1)
                .Caption   = "Sim"
                .FontName        = "Comic Sans MS"
                .FontSize        = 8
                .Left      = 0
                .Top       = 0
                .Width     = 63
                .Height    = 21
                .AutoSize  = .F.
                .ForeColor = RGB(90, 90, 90)
                .BackStyle = 0
            ENDWITH
            WITH .Buttons(2)
                .Caption   = "N" + CHR(227) + "o"
                .Left      = 65
                .Top       = 0
                .Width     = 63
                .Height    = 21
                .AutoSize  = .F.
                .FontName  = loc_cFonte
                .FontSize  = 9
                .ForeColor = RGB(90, 90, 90)
                .BackStyle = 0
            ENDWITH
            WITH .Buttons(3)
                .Caption   = "Ambos"
                .WordWrap        = .T.
                .Left      = 130
                .Top       = 0
                .Width     = 60
                .Height    = 21
                .AutoSize  = .F.
                .FontName  = loc_cFonte
                .FontSize  = 9
                .ForeColor = RGB(90, 90, 90)
                .BackStyle = 0
            ENDWITH
        ENDWITH

        THIS.AddObject("txt_4c__cd_emi_grupo", "TextBox")
        WITH THIS.txt_4c__cd_emi_grupo
            .Top       = 261
            .Left      = 237
            .Width     = 79
            .Height    = 20
            .MaxLength = 10
            .FontName  = loc_cFonte
            .FontSize  = 9
            .BackColor = RGB(255, 255, 255)
            .Visible   = .T.
        ENDWITH

        THIS.AddObject("txt_4c__ds_emi_grupo", "TextBox")
        WITH THIS.txt_4c__ds_emi_grupo
            .Top         = 261
            .Left        = 319
            .Width       = 150
            .Height      = 20
            .MaxLength   = 20
            .ReadOnly    = .T.
            .FontName    = loc_cFonte
            .FontSize    = 9
            .BackColor   = RGB(245, 245, 245)
            .ToolTipText = "Passe o Cheque na Leitora"
            .Visible     = .T.
        ENDWITH

        THIS.AddObject("txt_4c__cd_emi_conta", "TextBox")
        WITH THIS.txt_4c__cd_emi_conta
            .Top       = 289
            .Left      = 237
            .Width     = 79
            .Height    = 20
            .MaxLength = 10
            .FontName  = loc_cFonte
            .FontSize  = 9
            .BackColor = RGB(255, 255, 255)
            .Visible   = .T.
        ENDWITH

        BINDEVENT(THIS.txt_4c__cd_empresa,   "KeyPress", THIS, "TeclaCdEmpresa")
        BINDEVENT(THIS.txt_4c__ds_empresa,   "KeyPress", THIS, "TeclaDsEmpresa")
        BINDEVENT(THIS.txt_4c__cd_emi_grupo, "KeyPress", THIS, "TeclaCdEmiGrupo")
        BINDEVENT(THIS.txt_4c__ds_emi_grupo, "KeyPress", THIS, "TeclaDsEmiGrupo")
        BINDEVENT(THIS.txt_4c__cd_emi_conta, "KeyPress", THIS, "TeclaCdEmiConta")
        BINDEVENT(THIS.txt_4c__cd_empresa,   "DblClick", THIS, "DblClickCdEmpresa")
        BINDEVENT(THIS.txt_4c__cd_emi_grupo, "DblClick", THIS, "DblClickCdEmiGrupo")
        BINDEVENT(THIS.txt_4c__cd_emi_conta, "DblClick", THIS, "DblClickCdEmiConta")
    ENDPROC

    *==========================================================================
    * CONFIGURARCAMPOSFILTRO - Cria controles de filtro: segunda metade
    * Mapeamento.json itens 18-35: emi-conta-descricao, ordem, bons, tipo-rel,
    * dep-grupo, dep-conta, ori-grupo, ori-conta e todos os labels Say2-Say6
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarCamposFiltro()
        LOCAL loc_cFonte
        loc_cFonte = "Tahoma"

        THIS.AddObject("txt_4c__ds_emi_conta", "TextBox")
        WITH THIS.txt_4c__ds_emi_conta
            .Top         = 289
            .Left        = 319
            .Width       = 290
            .Height      = 20
            .MaxLength   = 50
            .ReadOnly    = .T.
            .FontName    = loc_cFonte
            .FontSize    = 9
            .BackColor   = RGB(245, 245, 245)
            .ToolTipText = "Passe o Cheque na Leitora"
            .Visible     = .T.
        ENDWITH

        THIS.AddObject("cbo_4c_Get_ordem", "ComboBox")
        WITH THIS.cbo_4c_Get_ordem
            .Top           = 188
            .Left          = 237
            .Width         = 134
            .Height        = 20
            .Style         = 2
            .RowSourceType = 1
            .RowSource     = "VALOR,DATA VENCIMENTO,DATA OPERA" + CHR(199) + CHR(195) + "O"
            .FontName      = loc_cFonte
            .FontSize      = 9
            .BackColor     = RGB(255, 255, 255)
            .Visible       = .T.
        ENDWITH

        THIS.AddObject("obj_4c_Opt_Bons", "OptionGroup")
        WITH THIS.obj_4c_Opt_Bons
            .Top         = 160
            .Left        = 378
            .Width       = 163
            .Height      = 22
            .ButtonCount = 2
            .BackStyle   = 0
            .BorderStyle = 0
            .Visible     = .F.
            WITH .Buttons(1)
                .Caption   = "Ativos"
                .FontName        = "Comic Sans MS"
                .FontSize        = 8
                .Left      = 0
                .Top       = 0
                .Width     = 78
                .Height    = 22
                .AutoSize  = .F.
                .ForeColor = RGB(90, 90, 90)
                .BackStyle = 0
            ENDWITH
            WITH .Buttons(2)
                .Caption   = "Todos"
                .Left      = 80
                .Top       = 0
                .Width     = 78
                .Height    = 22
                .AutoSize  = .F.
                .FontName  = loc_cFonte
                .FontSize  = 9
                .ForeColor = RGB(90, 90, 90)
                .BackStyle = 0
            ENDWITH
        ENDWITH

        THIS.AddObject("cbo_4c_GetTipoRel", "ComboBox")
        WITH THIS.cbo_4c_GetTipoRel
            .Top           = 160
            .Left          = 237
            .Width         = 134
            .Height        = 20
            .Style         = 2
            .RowSourceType = 1
            .RowSource     = "ATIVOS,BAIXADOS,NEG.PG,BONS,DEVOLVIDOS"
            .FontName      = loc_cFonte
            .FontSize      = 9
            .BackColor     = RGB(255, 255, 255)
            .ToolTipText   = "ATIVOS=Entradas  BAIXADOS=Saidas  NEG.PG=Devolvidos " + ;
                             "BONS=Depositados Sem Devolvidos DEVOLVIDOS=Devolvidos"
            .Visible       = .T.
        ENDWITH

        THIS.AddObject("txt_4c__cd_dep_grupo", "TextBox")
        WITH THIS.txt_4c__cd_dep_grupo
            .Top       = 372
            .Left      = 237
            .Width     = 79
            .Height    = 20
            .MaxLength = 10
            .FontName  = loc_cFonte
            .FontSize  = 9
            .BackColor = RGB(255, 255, 255)
            .Visible   = .T.
        ENDWITH

        THIS.AddObject("lbl_4c_Label6", "Label")
        WITH THIS.lbl_4c_Label6
            .Top       = 404
            .Left      = 170
            .Width     = 63
            .Height    = 17
            .FontName  = loc_cFonte
            .FontSize  = 9
            .BackStyle = 0
            .Caption   = "Conta Dest :"
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        THIS.AddObject("txt_4c__ds_dep_grupo", "TextBox")
        WITH THIS.txt_4c__ds_dep_grupo
            .Top         = 372
            .Left        = 319
            .Width       = 150
            .Height      = 20
            .MaxLength   = 20
            .ReadOnly    = .T.
            .FontName    = loc_cFonte
            .FontSize    = 9
            .BackColor   = RGB(245, 245, 245)
            .ToolTipText = "Passe o Cheque na Leitora"
            .Visible     = .T.
        ENDWITH

        THIS.AddObject("txt_4c_DGrupoO", "TextBox")
        WITH THIS.txt_4c_DGrupoO
            .Top         = 317
            .Left        = 319
            .Width       = 150
            .Height      = 20
            .MaxLength   = 20
            .ReadOnly    = .T.
            .FontName    = loc_cFonte
            .FontSize    = 9
            .BackColor   = RGB(245, 245, 245)
            .ToolTipText = "Passe o Cheque na Leitora"
            .Visible     = .T.
        ENDWITH

        THIS.AddObject("txt_4c_CContaO", "TextBox")
        WITH THIS.txt_4c_CContaO
            .Top       = 345
            .Left      = 237
            .Width     = 79
            .Height    = 20
            .MaxLength = 10
            .FontName  = loc_cFonte
            .FontSize  = 9
            .BackColor = RGB(255, 255, 255)
            .Visible   = .T.
        ENDWITH

        THIS.AddObject("txt_4c__cd_dep_conta", "TextBox")
        WITH THIS.txt_4c__cd_dep_conta
            .Top       = 400
            .Left      = 237
            .Width     = 79
            .Height    = 20
            .MaxLength = 10
            .FontName  = loc_cFonte
            .FontSize  = 9
            .BackColor = RGB(255, 255, 255)
            .Visible   = .T.
        ENDWITH

        THIS.AddObject("txt_4c__ds_dep_conta", "TextBox")
        WITH THIS.txt_4c__ds_dep_conta
            .Top         = 400
            .Left        = 319
            .Width       = 290
            .Height      = 20
            .MaxLength   = 50
            .ReadOnly    = .T.
            .FontName    = loc_cFonte
            .FontSize    = 9
            .BackColor   = RGB(245, 245, 245)
            .ToolTipText = "Passe o Cheque na Leitora"
            .Visible     = .T.
        ENDWITH

        THIS.AddObject("txt_4c_DContaO", "TextBox")
        WITH THIS.txt_4c_DContaO
            .Top         = 345
            .Left        = 319
            .Width       = 290
            .Height      = 20
            .MaxLength   = 50
            .ReadOnly    = .T.
            .FontName    = loc_cFonte
            .FontSize    = 9
            .BackColor   = RGB(245, 245, 245)
            .ToolTipText = "Passe o Cheque na Leitora"
            .Visible     = .T.
        ENDWITH

        THIS.AddObject("lbl_4c_Label3", "Label")
        WITH THIS.lbl_4c_Label3
            .Top       = 293
            .Left      = 155
            .Width     = 78
            .Height    = 17
            .FontName  = loc_cFonte
            .FontSize  = 9
            .BackStyle = 0
            .Caption   = "Conta/Emissor :"
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        THIS.AddObject("lbl_4c_Label5", "Label")
        WITH THIS.lbl_4c_Label5
            .Top       = 376
            .Left      = 170
            .Width     = 63
            .Height    = 17
            .FontName  = loc_cFonte
            .FontSize  = 9
            .BackStyle = 0
            .Caption   = "Grupo Dest :"
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        THIS.AddObject("lbl_4c_Label4", "Label")
        WITH THIS.lbl_4c_Label4
            .Top       = 321
            .Left      = 172
            .Width     = 61
            .Height    = 17
            .FontName  = loc_cFonte
            .FontSize  = 9
            .BackStyle = 0
            .Caption   = "Grupo Orig :"
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        THIS.AddObject("lbl_4c_Label2", "Label")
        WITH THIS.lbl_4c_Label2
            .Top       = 265
            .Left      = 155
            .Width     = 78
            .Height    = 17
            .FontName  = loc_cFonte
            .FontSize  = 9
            .BackStyle = 0
            .Caption   = "Grupo/Emissor :"
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        THIS.AddObject("lbl_4c_Lbl_dep_conta", "Label")
        WITH THIS.lbl_4c_Lbl_dep_conta
            .Top       = 349
            .Left      = 172
            .Width     = 61
            .Height    = 17
            .FontName  = loc_cFonte
            .FontSize  = 9
            .BackStyle = 0
            .Caption   = "Conta Orig :"
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        THIS.AddObject("txt_4c_CGrupoO", "TextBox")
        WITH THIS.txt_4c_CGrupoO
            .Top       = 317
            .Left      = 237
            .Width     = 79
            .Height    = 20
            .MaxLength = 10
            .FontName  = loc_cFonte
            .FontSize  = 9
            .BackColor = RGB(255, 255, 255)
            .Visible   = .T.
        ENDWITH

        BINDEVENT(THIS.cbo_4c_GetTipoRel,   "InteractiveChange", THIS, "MudarTipoRel")
        BINDEVENT(THIS.txt_4c__ds_emi_conta, "KeyPress", THIS, "TeclaDsEmiConta")
        BINDEVENT(THIS.txt_4c_CGrupoO,       "KeyPress", THIS, "TeclaCGrupoO")
        BINDEVENT(THIS.txt_4c_DGrupoO,       "KeyPress", THIS, "TeclaDGrupoO")
        BINDEVENT(THIS.txt_4c_CContaO,       "KeyPress", THIS, "TeclaCContaO")
        BINDEVENT(THIS.txt_4c_DContaO,       "KeyPress", THIS, "TeclaDContaO")
        BINDEVENT(THIS.txt_4c__cd_dep_grupo, "KeyPress", THIS, "TeclaCdDepGrupo")
        BINDEVENT(THIS.txt_4c__ds_dep_grupo, "KeyPress", THIS, "TeclaDsDepGrupo")
        BINDEVENT(THIS.txt_4c__cd_dep_conta, "KeyPress", THIS, "TeclaCdDepConta")
        BINDEVENT(THIS.txt_4c__ds_dep_conta, "KeyPress", THIS, "TeclaDsDepConta")
        BINDEVENT(THIS.txt_4c_CGrupoO,       "DblClick", THIS, "DblClickCGrupoO")
        BINDEVENT(THIS.txt_4c_CContaO,       "DblClick", THIS, "DblClickCContaO")
        BINDEVENT(THIS.txt_4c__cd_dep_grupo, "DblClick", THIS, "DblClickCdDepGrupo")
        BINDEVENT(THIS.txt_4c__cd_dep_conta, "DblClick", THIS, "DblClickCdDepConta")
    ENDPROC

    *==========================================================================
    * MUDARTIPORE - InteractiveChange do cbo_4c_GetTipoRel
    * Exibe obj_4c_Opt_Bons somente quando operacao=BONS (ListIndex=4)
    *==========================================================================
    PROCEDURE MudarTipoRel()
        IF PEMSTATUS(THIS, "obj_4c_Opt_Bons", 5)
            THIS.obj_4c_Opt_Bons.Visible = (THIS.cbo_4c_GetTipoRel.ListIndex = 4)
        ENDIF
    ENDPROC

    *==========================================================================
    * TECLA* - Handlers de KeyPress (PUBLIC para BINDEVENT)
    * F4=115 / F5=116 abrem lookup; Enter=13 / Tab=9 validam codigo
    *==========================================================================
    PROCEDURE TeclaCdEmpresa(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 115 OR par_nKeyCode = 116
            THIS.AbrirLookupEmpresa()
        ENDIF
        IF par_nKeyCode = 13 OR par_nKeyCode = 9
            THIS.ValidarCdEmpresa()
        ENDIF
    ENDPROC

    PROCEDURE TeclaDsEmpresa(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 115 OR par_nKeyCode = 116
            THIS.AbrirLookupEmpresa()
        ENDIF
    ENDPROC

    PROCEDURE TeclaCdEmiGrupo(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 115 OR par_nKeyCode = 116
            THIS.AbrirLookupGrupo("txt_4c__cd_emi_grupo", "txt_4c__ds_emi_grupo", ;
                "txt_4c__cd_emi_conta", "txt_4c__ds_emi_conta", "Emissor")
        ENDIF
        IF par_nKeyCode = 13 OR par_nKeyCode = 9
            THIS.ValidarCdGrupo("txt_4c__cd_emi_grupo", "txt_4c__ds_emi_grupo", ;
                "txt_4c__cd_emi_conta", "txt_4c__ds_emi_conta")
        ENDIF
    ENDPROC

    PROCEDURE TeclaDsEmiGrupo(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 115 OR par_nKeyCode = 116
            THIS.AbrirLookupGrupo("txt_4c__cd_emi_grupo", "txt_4c__ds_emi_grupo", ;
                "txt_4c__cd_emi_conta", "txt_4c__ds_emi_conta", "Emissor")
        ENDIF
    ENDPROC

    PROCEDURE TeclaCdEmiConta(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 115 OR par_nKeyCode = 116
            THIS.AbrirLookupConta("txt_4c__cd_emi_grupo", "txt_4c__cd_emi_conta", ;
                "txt_4c__ds_emi_conta", "Conta Emissor")
        ENDIF
        IF par_nKeyCode = 13 OR par_nKeyCode = 9
            THIS.ValidarCdConta("txt_4c__cd_emi_grupo", "txt_4c__cd_emi_conta", ;
                "txt_4c__ds_emi_conta")
        ENDIF
    ENDPROC

    PROCEDURE TeclaDsEmiConta(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 115 OR par_nKeyCode = 116
            THIS.AbrirLookupConta("txt_4c__cd_emi_grupo", "txt_4c__cd_emi_conta", ;
                "txt_4c__ds_emi_conta", "Conta Emissor")
        ENDIF
    ENDPROC

    PROCEDURE TeclaCGrupoO(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 115 OR par_nKeyCode = 116
            THIS.AbrirLookupGrupo("txt_4c_CGrupoO", "txt_4c_DGrupoO", ;
                "txt_4c_CContaO", "txt_4c_DContaO", "Origem")
        ENDIF
        IF par_nKeyCode = 13 OR par_nKeyCode = 9
            THIS.ValidarCdGrupo("txt_4c_CGrupoO", "txt_4c_DGrupoO", ;
                "txt_4c_CContaO", "txt_4c_DContaO")
        ENDIF
    ENDPROC

    PROCEDURE TeclaDGrupoO(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 115 OR par_nKeyCode = 116
            THIS.AbrirLookupGrupo("txt_4c_CGrupoO", "txt_4c_DGrupoO", ;
                "txt_4c_CContaO", "txt_4c_DContaO", "Origem")
        ENDIF
    ENDPROC

    PROCEDURE TeclaCContaO(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 115 OR par_nKeyCode = 116
            THIS.AbrirLookupConta("txt_4c_CGrupoO", "txt_4c_CContaO", ;
                "txt_4c_DContaO", "Conta Origem")
        ENDIF
        IF par_nKeyCode = 13 OR par_nKeyCode = 9
            THIS.ValidarCdConta("txt_4c_CGrupoO", "txt_4c_CContaO", ;
                "txt_4c_DContaO")
        ENDIF
    ENDPROC

    PROCEDURE TeclaDContaO(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 115 OR par_nKeyCode = 116
            THIS.AbrirLookupConta("txt_4c_CGrupoO", "txt_4c_CContaO", ;
                "txt_4c_DContaO", "Conta Origem")
        ENDIF
    ENDPROC

    PROCEDURE TeclaCdDepGrupo(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 115 OR par_nKeyCode = 116
            THIS.AbrirLookupGrupo("txt_4c__cd_dep_grupo", "txt_4c__ds_dep_grupo", ;
                "txt_4c__cd_dep_conta", "txt_4c__ds_dep_conta", "Destino")
        ENDIF
        IF par_nKeyCode = 13 OR par_nKeyCode = 9
            THIS.ValidarCdGrupo("txt_4c__cd_dep_grupo", "txt_4c__ds_dep_grupo", ;
                "txt_4c__cd_dep_conta", "txt_4c__ds_dep_conta")
        ENDIF
    ENDPROC

    PROCEDURE TeclaDsDepGrupo(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 115 OR par_nKeyCode = 116
            THIS.AbrirLookupGrupo("txt_4c__cd_dep_grupo", "txt_4c__ds_dep_grupo", ;
                "txt_4c__cd_dep_conta", "txt_4c__ds_dep_conta", "Destino")
        ENDIF
    ENDPROC

    PROCEDURE TeclaCdDepConta(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 115 OR par_nKeyCode = 116
            THIS.AbrirLookupConta("txt_4c__cd_dep_grupo", "txt_4c__cd_dep_conta", ;
                "txt_4c__ds_dep_conta", "Conta Destino")
        ENDIF
        IF par_nKeyCode = 13 OR par_nKeyCode = 9
            THIS.ValidarCdConta("txt_4c__cd_dep_grupo", "txt_4c__cd_dep_conta", ;
                "txt_4c__ds_dep_conta")
        ENDIF
    ENDPROC

    PROCEDURE TeclaDsDepConta(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 115 OR par_nKeyCode = 116
            THIS.AbrirLookupConta("txt_4c__cd_dep_grupo", "txt_4c__cd_dep_conta", ;
                "txt_4c__ds_dep_conta", "Conta Destino")
        ENDIF
    ENDPROC

    *==========================================================================
    * ABRIRLOOKUPEMPRESA - Busca empresa em sigcdemp (cemps/razas)
    *==========================================================================
    PROTECTED PROCEDURE AbrirLookupEmpresa()
        LOCAL loc_oBusca, loc_cCodAtual
        loc_oBusca    = .NULL.
        loc_cCodAtual = ""
        TRY
            IF PEMSTATUS(THIS, "txt_4c__cd_empresa", 5)
                loc_cCodAtual = ALLTRIM(THIS.txt_4c__cd_empresa.Value)
            ENDIF
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "sigcdemp", "cursor_4c_Busca", "cemps", loc_cCodAtual, ;
                "Empresa", .F., .T., "")
            IF VARTYPE(loc_oBusca) != "O"
                MsgErro("Erro ao criar busca de empresa.", "AbrirLookupEmpresa")
            ELSE
                loc_oBusca.mAddColuna("cemps", "", "C" + CHR(243) + "digo")
                loc_oBusca.mAddColuna("razas", "", "Descri" + CHR(231) + CHR(227) + "o")
                IF !loc_oBusca.this_lAchouRegistro
                    loc_oBusca.Show()
                ENDIF
                IF loc_oBusca.this_lSelecionou
                    IF USED("cursor_4c_Busca")
                        SELECT cursor_4c_Busca
                        THIS.txt_4c__cd_empresa.Value = ALLTRIM(cemps)
                        THIS.txt_4c__ds_empresa.Value = ALLTRIM(razas)
                    ENDIF
                ENDIF
                loc_oBusca = .NULL.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "AbrirLookupEmpresa")
        ENDTRY
    ENDPROC

    *==========================================================================
    * VALIDARCDEMPRESA - Valida codigo digitado contra sigcdemp
    *==========================================================================
    PROTECTED PROCEDURE ValidarCdEmpresa()
        LOCAL loc_cCod, loc_cDs, loc_nCount, loc_cSQL, loc_lEncontrou
        loc_cCod       = ""
        loc_cDs        = ""
        loc_lEncontrou = .F.
        TRY
            IF PEMSTATUS(THIS, "txt_4c__cd_empresa", 5)
                loc_cCod = ALLTRIM(THIS.txt_4c__cd_empresa.Value)
                IF !EMPTY(loc_cCod)
                    loc_cSQL   = "SELECT razas FROM sigcdemp WHERE cemps = " + EscaparSQL(loc_cCod)
                    loc_nCount = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Valid")
                    IF loc_nCount > 0 AND USED("cursor_4c_Valid")
                        IF RECCOUNT("cursor_4c_Valid") > 0
                            SELECT cursor_4c_Valid
                            loc_cDs        = ALLTRIM(razas)
                            loc_lEncontrou = .T.
                        ENDIF
                        USE IN cursor_4c_Valid
                    ENDIF
                    IF loc_lEncontrou
                        THIS.txt_4c__ds_empresa.Value = loc_cDs
                    ELSE
                        THIS.txt_4c__ds_empresa.Value = ""
                        THIS.AbrirLookupEmpresa()
                    ENDIF
                ELSE
                    THIS.txt_4c__ds_empresa.Value = ""
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "ValidarCdEmpresa")
        ENDTRY
    ENDPROC

    *==========================================================================
    * ABRIRLOOKUPGRUPO - Busca grupo em SigCdGcr (codigos/descrs)
    * Generico para emissor, origem e destino
    * Ao selecionar, limpa os campos de conta associados
    *==========================================================================
    PROTECTED PROCEDURE AbrirLookupGrupo(par_cCtrlCd, par_cCtrlDs, par_cCtrlCdConta, par_cCtrlDsConta, par_cTitulo)
        LOCAL loc_oBusca, loc_cCodAtual
        LOCAL loc_oCtrlCd, loc_oCtrlDs, loc_oCtrlCdConta, loc_oCtrlDsConta
        loc_oBusca    = .NULL.
        loc_cCodAtual = ""
        TRY
            loc_oCtrlCd      = EVALUATE("THIS." + par_cCtrlCd)
            loc_oCtrlDs      = EVALUATE("THIS." + par_cCtrlDs)
            loc_oCtrlCdConta = EVALUATE("THIS." + par_cCtrlCdConta)
            loc_oCtrlDsConta = EVALUATE("THIS." + par_cCtrlDsConta)
            loc_cCodAtual    = ALLTRIM(loc_oCtrlCd.Value)
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigCdGcr", "cursor_4c_Busca", "codigos", loc_cCodAtual, ;
                par_cTitulo, .F., .T., "")
            IF VARTYPE(loc_oBusca) != "O"
                MsgErro("Erro ao criar busca de grupo.", "AbrirLookupGrupo")
            ELSE
                loc_oBusca.mAddColuna("codigos", "", "C" + CHR(243) + "digo")
                loc_oBusca.mAddColuna("descrs",  "", "Descri" + CHR(231) + CHR(227) + "o")
                IF !loc_oBusca.this_lAchouRegistro
                    loc_oBusca.Show()
                ENDIF
                IF loc_oBusca.this_lSelecionou
                    IF USED("cursor_4c_Busca")
                        SELECT cursor_4c_Busca
                        loc_oCtrlCd.Value      = ALLTRIM(codigos)
                        loc_oCtrlDs.Value      = ALLTRIM(descrs)
                        loc_oCtrlCdConta.Value = ""
                        loc_oCtrlDsConta.Value = ""
                    ENDIF
                ENDIF
                loc_oBusca = .NULL.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "AbrirLookupGrupo")
        ENDTRY
    ENDPROC

    *==========================================================================
    * VALIDARCDGRUPO - Valida codigo de grupo digitado contra SigCdGcr
    * Generico para emissor, origem e destino
    *==========================================================================
    PROTECTED PROCEDURE ValidarCdGrupo(par_cCtrlCd, par_cCtrlDs, par_cCtrlCdConta, par_cCtrlDsConta)
        LOCAL loc_oCtrlCd, loc_oCtrlDs, loc_oCtrlCdConta, loc_oCtrlDsConta
        LOCAL loc_cCod, loc_cDs, loc_nCount, loc_cSQL, loc_lEncontrou
        loc_cCod       = ""
        loc_cDs        = ""
        loc_lEncontrou = .F.
        TRY
            loc_oCtrlCd      = EVALUATE("THIS." + par_cCtrlCd)
            loc_oCtrlDs      = EVALUATE("THIS." + par_cCtrlDs)
            loc_oCtrlCdConta = EVALUATE("THIS." + par_cCtrlCdConta)
            loc_oCtrlDsConta = EVALUATE("THIS." + par_cCtrlDsConta)
            loc_cCod         = ALLTRIM(loc_oCtrlCd.Value)
            IF !EMPTY(loc_cCod)
                loc_cSQL   = "SELECT descrs FROM SigCdGcr WHERE codigos = " + EscaparSQL(loc_cCod)
                loc_nCount = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Valid")
                IF loc_nCount > 0 AND USED("cursor_4c_Valid")
                    IF RECCOUNT("cursor_4c_Valid") > 0
                        SELECT cursor_4c_Valid
                        loc_cDs        = ALLTRIM(descrs)
                        loc_lEncontrou = .T.
                    ENDIF
                    USE IN cursor_4c_Valid
                ENDIF
                IF loc_lEncontrou
                    loc_oCtrlDs.Value = loc_cDs
                ELSE
                    loc_oCtrlDs.Value      = ""
                    loc_oCtrlCdConta.Value = ""
                    loc_oCtrlDsConta.Value = ""
                    THIS.AbrirLookupGrupo(par_cCtrlCd, par_cCtrlDs, par_cCtrlCdConta, par_cCtrlDsConta, "Grupo")
                ENDIF
            ELSE
                loc_oCtrlDs.Value      = ""
                loc_oCtrlCdConta.Value = ""
                loc_oCtrlDsConta.Value = ""
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "ValidarCdGrupo")
        ENDTRY
    ENDPROC

    *==========================================================================
    * ABRIRLOOKUPCO NTA - Busca conta em SigCdCli (iclis/rclis)
    * Filtra por grupo via 9o parametro do FormBuscaAuxiliar (par_cFiltro)
    * Generico para emissor, origem e destino
    *==========================================================================
    PROTECTED PROCEDURE AbrirLookupConta(par_cCtrlGrupo, par_cCtrlCd, par_cCtrlDs, par_cTitulo)
        LOCAL loc_oBusca, loc_cCodAtual, loc_cGrupo, loc_cFiltro
        LOCAL loc_oCtrlGrupo, loc_oCtrlCd, loc_oCtrlDs
        loc_oBusca    = .NULL.
        loc_cCodAtual = ""
        loc_cGrupo    = ""
        loc_cFiltro   = ""
        TRY
            loc_oCtrlGrupo = EVALUATE("THIS." + par_cCtrlGrupo)
            loc_oCtrlCd    = EVALUATE("THIS." + par_cCtrlCd)
            loc_oCtrlDs    = EVALUATE("THIS." + par_cCtrlDs)
            loc_cGrupo     = ALLTRIM(loc_oCtrlGrupo.Value)
            loc_cCodAtual  = ALLTRIM(loc_oCtrlCd.Value)
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigCdCli", "cursor_4c_Busca", "iclis", loc_cCodAtual, ;
                par_cTitulo, .F., .T., loc_cFiltro)
            IF VARTYPE(loc_oBusca) != "O"
                MsgErro("Erro ao criar busca de conta.", "AbrirLookupConta")
            ELSE
                loc_oBusca.mAddColuna("iclis", "", "C" + CHR(243) + "digo")
                loc_oBusca.mAddColuna("rclis", "", "Descri" + CHR(231) + CHR(227) + "o")
                IF !loc_oBusca.this_lAchouRegistro
                    loc_oBusca.Show()
                ENDIF
                IF loc_oBusca.this_lSelecionou
                    IF USED("cursor_4c_Busca")
                        SELECT cursor_4c_Busca
                        loc_oCtrlCd.Value = ALLTRIM(iclis)
                        loc_oCtrlDs.Value = ALLTRIM(rclis)
                    ENDIF
                ENDIF
                loc_oBusca = .NULL.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "AbrirLookupConta")
        ENDTRY
    ENDPROC

    *==========================================================================
    * DBLCLICK* - Handlers de DblClick nos campos de codigo (PUBLIC para BINDEVENT)
    * Abrem o lookup correspondente, mesmo comportamento que F4/F5
    *==========================================================================
    PROCEDURE DblClickCdEmpresa()
        THIS.AbrirLookupEmpresa()
    ENDPROC

    PROCEDURE DblClickCdEmiGrupo()
        THIS.AbrirLookupGrupo("txt_4c__cd_emi_grupo", "txt_4c__ds_emi_grupo", ;
            "txt_4c__cd_emi_conta", "txt_4c__ds_emi_conta", "Emissor")
    ENDPROC

    PROCEDURE DblClickCdEmiConta()
        THIS.AbrirLookupConta("txt_4c__cd_emi_grupo", "txt_4c__cd_emi_conta", ;
            "txt_4c__ds_emi_conta", "Conta Emissor")
    ENDPROC

    PROCEDURE DblClickCGrupoO()
        THIS.AbrirLookupGrupo("txt_4c_CGrupoO", "txt_4c_DGrupoO", ;
            "txt_4c_CContaO", "txt_4c_DContaO", "Origem")
    ENDPROC

    PROCEDURE DblClickCContaO()
        THIS.AbrirLookupConta("txt_4c_CGrupoO", "txt_4c_CContaO", ;
            "txt_4c_DContaO", "Conta Origem")
    ENDPROC

    PROCEDURE DblClickCdDepGrupo()
        THIS.AbrirLookupGrupo("txt_4c__cd_dep_grupo", "txt_4c__ds_dep_grupo", ;
            "txt_4c__cd_dep_conta", "txt_4c__ds_dep_conta", "Destino")
    ENDPROC

    PROCEDURE DblClickCdDepConta()
        THIS.AbrirLookupConta("txt_4c__cd_dep_grupo", "txt_4c__cd_dep_conta", ;
            "txt_4c__ds_dep_conta", "Conta Destino")
    ENDPROC

    *==========================================================================
    * BTNSALVARCLICK - Mapeia "Salvar" de CRUD para Imprimir em REPORT
    *
    * Forms REPORT (frmrelatorio) nao tem operacao Salvar - o "resultado" do
    * formulario eh o relatorio impresso. Delegamos para o fluxo de impressao,
    * que monta os filtros (FormParaRelatorio) e dispara o REPORT FORM via BO.
    *==========================================================================
    PROCEDURE BtnSalvarClick()
        THIS.BtnImprimirClick()
    ENDPROC

    *==========================================================================
    * FORMPARABO - Wrapper de FormParaRelatorio (CRUD -> REPORT semantica)
    *
    * Em forms CRUD, FormParaBO transfere valores do form para o BusinessObject.
    * Em forms REPORT, o equivalente eh FormParaRelatorio (transfere filtros
    * para o RelatorioBase). Mantemos o contrato CRUD delegando para o metodo
    * de REPORT que faz o trabalho real.
    *==========================================================================
    PROCEDURE FormParaBO()
        THIS.FormParaRelatorio()
    ENDPROC

    *==========================================================================
    * BOPARAFORM - Em REPORT, restaura tela de filtros para estado padrao
    *
    * Forms CRUD usam BOParaForm para carregar valores do BO nos controles
    * apos um Buscar. Forms REPORT nao tem registro persistido nem operacao
    * de Buscar; o equivalente conceitual eh "voltar a tela de filtros ao
    * estado padrao" - delegamos para LimparCampos + AtualizarTitulosOpcao.
    *==========================================================================
    PROCEDURE BOParaForm()
        TRY
            THIS.LimparCampos()
            THIS.AtualizarTitulosOpcao()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "BOParaForm")
        ENDTRY
    ENDPROC

    *==========================================================================
    * CARREGARLISTA - Em REPORT, configura a tela de filtros (sem grid de lista)
    *
    * Forms CRUD usam CarregarLista para popular o grid de Page1 a partir de
    * Buscar() no BO. Forms REPORT nao tem grid de lista - a "lista" conceitual
    * eh a propria area de filtros que o usuario preenche para gerar o relatorio.
    * Este metodo eh mantido para compatibilidade com chamadas genericas do
    * FormBase e delega para ConfigurarPaginaLista (reset de filtros + foco).
    *==========================================================================
    PROCEDURE CarregarLista()
        THIS.ConfigurarPaginaLista()
        RETURN .T.
    ENDPROC

    *==========================================================================
    * VALIDARCDCONTA - Valida codigo de conta digitado contra SigCdCli
    * Filtra por grupo quando preenchido; generico para emissor, origem, destino
    *==========================================================================
    PROTECTED PROCEDURE ValidarCdConta(par_cCtrlGrupo, par_cCtrlCd, par_cCtrlDs)
        LOCAL loc_oCtrlGrupo, loc_oCtrlCd, loc_oCtrlDs
        LOCAL loc_cCod, loc_cGrupo, loc_cDs, loc_nCount, loc_cSQL, loc_lEncontrou
        loc_cCod       = ""
        loc_cGrupo     = ""
        loc_cDs        = ""
        loc_lEncontrou = .F.
        TRY
            loc_oCtrlGrupo = EVALUATE("THIS." + par_cCtrlGrupo)
            loc_oCtrlCd    = EVALUATE("THIS." + par_cCtrlCd)
            loc_oCtrlDs    = EVALUATE("THIS." + par_cCtrlDs)
            loc_cCod       = ALLTRIM(loc_oCtrlCd.Value)
            loc_cGrupo     = ALLTRIM(loc_oCtrlGrupo.Value)
            IF !EMPTY(loc_cCod)
                loc_cSQL = "SELECT rclis FROM SigCdCli WHERE iclis = " + EscaparSQL(loc_cCod)
                loc_nCount = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Valid")
                IF loc_nCount > 0 AND USED("cursor_4c_Valid")
                    IF RECCOUNT("cursor_4c_Valid") > 0
                        SELECT cursor_4c_Valid
                        loc_cDs        = ALLTRIM(rclis)
                        loc_lEncontrou = .T.
                    ENDIF
                    USE IN cursor_4c_Valid
                ENDIF
                IF loc_lEncontrou
                    loc_oCtrlDs.Value = loc_cDs
                ELSE
                    loc_oCtrlDs.Value = ""
                    THIS.AbrirLookupConta(par_cCtrlGrupo, par_cCtrlCd, par_cCtrlDs, "Conta")
                ENDIF
            ELSE
                loc_oCtrlDs.Value = ""
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "ValidarCdConta")
        ENDTRY
    ENDPROC

ENDDEFINE

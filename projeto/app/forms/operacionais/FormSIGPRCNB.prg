*==============================================================================
* FormSIGPRCNB.prg - Form Operacional: Geracao de Arquivos CNAB - Recebimentos
* Migrado de SIGPRCNB.SCX
* Herda de FormBase
* Tabela principal: SigPcOol (log de processamento CNAB)
*
* Pilares:
*   UX   -> layout PIXEL-PERFECT identico ao legado
*   BD   -> Schema IDENTICO (SigPcOol, SigCdOpe, SigCdCli, SigCdEmp, SigCdCeb, etc.)
*   CODE -> arquitetura em camadas (FormBase / SIGPRCNBBO)
*
* Form OPERACIONAL: NAO segue padrao Page1=Lista/Page2=Dados de cadastro CRUD.
* Page1 = Filtro (criterios de selecao + grade de operacoes a processar)
* Page2 = Dados  (grade dos titulos processados + acoes de geracao de CNAB/boleto)
*
* FASE 4/8: Grid de operacoes (grdope) + botoes reais da Page1 (Processar/
* Encerrar/Marcar Tudo/Desmarcar Tudo) e AlternarPagina(). Campos de filtro
* (Empresa/Periodo/Conta/Titulo Banco) ficam para as Fases 5-6; BINDEVENTs e
* logica de negocio (validacoes do Processar, geracao do CNAB) para as
* Fases 7-8.
*
* FASE 5/8: Page2 (Dados) - faixa do cabecalho (regra #11, nas duas
* paginas) + primeiro grupo de campos "principais" de pgdados (Say12/
* spndias/Say1 - "Protestar apos <N> dias", ja com property no BO
* this_nDiasProtesto). O aviso de endereco longo (Say2/Botao1), a grade de
* titulos (grdope 8 colunas) e os botoes de acao de Page2 (cmdTestaPos/
* Commandgroup1/Commandgroup2) ficam para a Fase 6.
*
* FASE 6/8: Campos restantes da Page1 (Empresa/Periodo/Banco-Conta/Titulo
* Banco) + lookups completos via FormBuscaAuxiliar (fAcessoEmpresa/
* fAcessoContas nao portadas). BINDEVENTs registrados em
* ConfigurarBindEventsFiltro(). Wiring dos botoes Processar/Marcar/
* Desmarcar/Encerrar e geracao do CNAB ficou para as Fases 7-8.
*
* FASE 7/8: Eventos principais dos botoes ja construidos - Processar
* (THIS.ProcessarTitulos(), transcrito de PROCEDURE processamento do
* legado), Encerrar, Marcar/Desmarcar Tudo (Page1), e o "round-trip" da
* Page2: grade de titulos (grd_4c_Titulos, 8 colunas + DynamicForeColor
* para EndErro), Marcar/Desmarcar Tudo dos titulos, checkbox individual
* (guard EndErro=1, equivalente ao Column1.Check1.When do legado) e Voltar
* (cmd_4c_Encerrar de Page2, que reaproveita o Caption/Picture "Encerrar"
* do legado mas volta para o filtro, nao fecha o form). O aviso de
* endereco longo (Say2/Botao1) foi reposicionado para LOGO ABAIXO do grupo
* "Protestar apos" (regra #11/#39 - a faixa do cabecalho ocupa o lugar que
* ele tinha no legado).
*
* FASE 8/8: obj_4c_Comandos (Commandgroup1 no legado - Gerar CNAB/
* Relatorio/Boleto) adicionado em cnt_4c_BotoesAcao da Page2, com os 3
* Click handlers (BtnGerarCnabClick/BtnRelatorioCnabClick/BtnBoletoClick)
* e ExecutarReportForm (Pattern #117). A geracao do arquivo CNAB (dispatch
* por banco do convenio - Brasil/Itau/Bradesco/Santander240 - layouts
* Brasil6/Itau240/Santander eram DEAD CODE no legado, nunca chamados por
* nenhum botao nem pelo dispatcher, e por isso nao foram portados) e o
* calculo do boleto (nosso numero/codigo de barras/linha digitavel, Mod10/
* Mod11 padrao FEBRABAN - fCalcMod10/fCalcMod11BB/fCalcMod11B7/fGerBar2de5
* em utils/functions.prg, fontes legados ausentes do acervo, regra
* CLAUDE.md #27) ficam no SIGPRCNBBO (GerarArquivoCnab/GerarCnabBrasil/
* GerarCnabItau/GerarCnabBradesco/GerarCnabSantander240/ImprimirBoleto).
* Os relatorios de preview (SigReCnb/SigReBlqBB/SigReBlqSt/SigReBlqBra)
* NAO tem FRX no acervo (sigrecnb/BloquetoBB2/BloquetoSt/BloquetoBra do
* legado nunca foram extraidos) - ExecutarReportForm mostra o aviso
* padrao "arquivo de relatorio nao encontrado" em vez de preview vazio;
* toda a preparacao de dados (cursor_4c_Titulos/cursor_4c_Boletos, calculo
* de barra/DV) fica pronta para quando o FRX for portado.
*==============================================================================

DEFINE CLASS FormSIGPRCNB AS FormBase

    *-- Dimensoes e propriedades visuais (padrao canonico de form OPERACIONAL)
    Height      = 600
    Width       = 1000
    BorderStyle = 2
    AutoCenter  = .T.
    ShowTips    = .T.
    Caption     = "Gera" + CHR(231) + CHR(227) + "o de Arquivos CNAB"
    ControlBox  = .F.
    MaxButton   = .F.
    MinButton   = .F.
    TitleBar    = 0
    WindowState = 0
    ShowWindow  = 1
    WindowType  = 1
    DataSession = 2
    Themes      = .F.

    *-- Business Object
    this_oBusinessObject = .NULL.

    *==========================================================================
    PROCEDURE Init()
    *==========================================================================
        RETURN DODEFAULT()
    ENDPROC

    *==========================================================================
    * InicializarForm - Chamado por FormBase.Init via DODEFAULT
    *==========================================================================
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        TRY
            THIS.this_oBusinessObject = CREATEOBJECT("SIGPRCNBBO")

            IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
                loc_lSucesso = .T.
            ELSE
                IF gnConnHandle <= 0
                    MsgErro("Imposs" + CHR(237) + "vel Efetuar Conex" + CHR(227) + "o " + ;
                            "Com o Servidor de Banco de Dados...", "Conex" + CHR(227) + "o")
                ELSE
                    THIS.ConfigurarPageFrame()
                    THIS.ConfigurarPaginaLista()
                    THIS.ConfigurarPaginaDados()
                    THIS.ConfigurarBindEventsFiltro()
                    THIS.ConfigurarBindEventsPrincipais()
                    THIS.CarregarOperacoes()
                    THIS.TornarControlesVisiveis()
                    loc_lSucesso = .T.
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, "Erro InicializarForm")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * ConfigurarPageFrame - Constroi o PageFrame com 2 paginas (Filtro/Dados)
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPageFrame()
        LOCAL loc_oPgf

        THIS.AddObject("pgf_4c_Paginas", "PageFrame")
        loc_oPgf = THIS.pgf_4c_Paginas

        loc_oPgf.PageCount = 2
        loc_oPgf.Top       = -29
        loc_oPgf.Left      = 0
        loc_oPgf.Width     = THIS.Width
        loc_oPgf.Height    = THIS.Height + 29
        loc_oPgf.TabIndex  = 1
        loc_oPgf.Tabs      = .F.

        loc_oPgf.Page1.Caption = "Filtro"
        loc_oPgf.Page1.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"

        loc_oPgf.Page2.Caption = "Dados"
        loc_oPgf.Page2.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"

        loc_oPgf.Visible    = .T.
        loc_oPgf.ActivePage = 1
    ENDPROC

    *==========================================================================
    * ConfigurarPaginaLista - Estrutura da Page1 (Filtro)
    * Fase 4/8: faixa do cabecalho + botoes reais (Processar/Encerrar/Marcar
    * Tudo/Desmarcar Tudo) + grade de selecao de operacoes (grdope no
    * legado). Campos de filtro (empresa, periodo, banco/conta, titulo
    * banco) vem nas Fases 5-6.
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPaginaLista()
        LOCAL loc_oPag, loc_oCab, loc_oGrid

        loc_oPag = THIS.pgf_4c_Paginas.Page1

        *-- Faixa do cabecalho - PRIMEIRO AddObject da pagina (regra #11/#39):
        *-- containers de botao ficam em Top=29..33 (dentro da faixa) e tem
        *-- de ser criados DEPOIS para desenhar por cima.
        loc_oPag.AddObject("cnt_4c_Cabecalho", "Container")
        loc_oCab = loc_oPag.cnt_4c_Cabecalho
        WITH loc_oCab
            .Top           = 29
            .Left          = 0
            .Width         = THIS.Width
            .Height        = 80
            .BorderWidth   = 0
            .SpecialEffect = 0
            .BackColor     = RGB(100,100,100)

            .AddObject("lbl_4c_Sombra", "Label")
            WITH .lbl_4c_Sombra
                .Top       = 15
                .Left      = 10
                .Width     = THIS.Width
                .Height    = 40
                .FontName  = "Tahoma"
                .FontSize  = 16
                .FontBold  = .T.
                .WordWrap  = .T.
                .Alignment = 0
                .BackStyle = 0
                .ForeColor = RGB(0,0,0)
                .Caption   = "Gera" + CHR(231) + CHR(227) + "o de Arquivos CNAB - Recebimentos"
            ENDWITH

            .AddObject("lbl_4c_Titulo", "Label")
            WITH .lbl_4c_Titulo
                .Top       = 18
                .Left      = 10
                .Width     = THIS.Width
                .Height    = 46
                .FontName  = "Tahoma"
                .FontSize  = 16
                .FontBold  = .T.
                .WordWrap  = .T.
                .Alignment = 0
                .BackStyle = 0
                .ForeColor = RGB(255,255,255)
                .Caption   = "Gera" + CHR(231) + CHR(227) + "o de Arquivos CNAB - Recebimentos"
            ENDWITH
        ENDWITH

        *-- Container de botoes (Processar/Encerrar - cmdTestaPos no legado)
        loc_oPag.AddObject("cnt_4c_Botoes", "Container")
        WITH loc_oPag.cnt_4c_Botoes
            .Top         = 27
            .Left        =  542
            .Width       = 160
            .Height      = 85
            .BackStyle   = 0
            .BorderWidth = 0

            *-- cmd_4c_Processar (Command1/btnProcessar no legado)
            .AddObject("cmd_4c_Processar", "CommandButton")
            WITH .cmd_4c_Processar
                .Top             = 5
                .Left            = 5
                .Width           = 75
                .Height          = 75
                .FontName        = "Comic Sans MS"
                .FontSize        = 8
                .FontBold        = .T.
                .FontItalic      = .T.
                .WordWrap        = .T.
                .Alignment       = 2
                .PicturePosition = 13
                .Picture         = gc_4c_CaminhoIcones + "geral_processar_60.jpg"
                .Caption         = "Processar"
                .ToolTipText     = "Processar"
                .MousePointer    = 15
                .SpecialEffect   = 0
                .ForeColor       = RGB(90,90,90)
                .BackColor       = RGB(255,255,255)
            ENDWITH

            *-- cmd_4c_Encerrar (Command2/btnsair no legado)
            .AddObject("cmd_4c_Encerrar", "CommandButton")
            WITH .cmd_4c_Encerrar
                .Top             = 5
                .Left = 5
                .Width           = 75
                .Height          = 75
                .FontName        = "Comic Sans MS"
                .FontSize        = 8
                .FontBold        = .T.
                .FontItalic      = .T.
                .WordWrap        = .T.
                .Alignment       = 2
                .PicturePosition = 13
                .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
                .Cancel          = .T.
                .Caption         = "Encerrar"
                .ToolTipText     = "[ESC] Encerrar"
                .MousePointer    = 15
                .SpecialEffect   = 0
                .ForeColor       = RGB(90,90,90)
                .BackColor       = RGB(255,255,255)
                .Themes          = .F.
            ENDWITH
        ENDWITH

        *-- Container Marcar/Desmarcar Tudo (Commandgroup2/btnmarca+btndesmarca no legado)
        loc_oPag.AddObject("cnt_4c_Marca", "Container")
        WITH loc_oPag.cnt_4c_Marca
            .Top         = 344
            .Left        = 563
            .Width       = 50
            .Height      = 91
            .BackStyle   = 0
            .BorderWidth = 0

            .AddObject("cmd_4c_MarcarTudo", "CommandButton")
            WITH .cmd_4c_MarcarTudo
                .Top           = 5
                .Left          = 5
                .Width         = 40
                .Height        = 40
                .FontName      = "Verdana"
                .FontSize      = 7
                .Picture       = gc_4c_CaminhoIcones + "geral_adicao_26.jpg"
                .Caption       = ""
                .ToolTipText   = "Marcar tudo"
                .ForeColor     = RGB(36,84,155)
                .BackColor     = RGB(255,255,255)
            ENDWITH

            .AddObject("cmd_4c_DesmarcarTudo", "CommandButton")
            WITH .cmd_4c_DesmarcarTudo
                .Top           = 46
                .Left          = 5
                .Width         = 40
                .Height        = 40
                .FontName      = "Verdana"
                .FontSize      = 8
                .Picture       = gc_4c_CaminhoIcones + "cadastro_excluir_26.jpg"
                .Caption       = ""
                .ToolTipText   = "Desmarcar tudo"
                .ForeColor     = RGB(36,84,155)
                .BackColor     = RGB(255,255,255)
                .Themes        = .F.
            ENDWITH
        ENDWITH

        *-- Grupo "Operacoes :" (Label1) + filtro Processados/Ja Processadas
        *-- (optProcessados no legado, Top=95 -> 124 com compensacao +29).
        loc_oPag.AddObject("lbl_4c_Operacoes", "Label")
        WITH loc_oPag.lbl_4c_Operacoes
            .Top       = 125
            .Left      = 279
            .Width     = 68
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .T.
            .AutoSize  = .F.
            .Alignment = 0
            .BackStyle = 0
            .ForeColor = RGB(90,90,90)
            .Caption   = "Opera" + CHR(231) + CHR(245) + "es :"
        ENDWITH

        loc_oPag.AddObject("obj_4c_Processados", "OptionGroup")
        WITH loc_oPag.obj_4c_Processados
            .Top         = 124
            .Left        = 344
            .Width       = 235
            .Height      = 19
            .BackStyle   = 0
            .BorderStyle = 0
            .ButtonCount = 2
            .Value       = 1

            WITH .Buttons(1)
                .FontName  = "Tahoma"
                .FontSize  = 8
                .BackStyle = 0
                .Caption   = "N" + CHR(227) + "o Processadas"
                .ForeColor = RGB(90,90,90)
                .Left      = 5
                .Top       = 2
                .AutoSize  = .T.
                .Themes    = .F.
            ENDWITH

            WITH .Buttons(2)
                .FontName  = "Tahoma"
                .FontSize  = 8
                .BackStyle = 0
                .Caption   = "J" + CHR(225) + " Processadas"
                .ForeColor = RGB(90,90,90)
                .Left      = 126
                .Top       = 2
                .AutoSize  = .T.
                .Themes    = .F.
            ENDWITH
        ENDWITH

        *-- Empresa (Say4 + get_cd_empresa + get_ds_empresa no legado)
        loc_oPag.AddObject("lbl_4c_Empresa", "Label")
        WITH loc_oPag.lbl_4c_Empresa
            .Top       = 152
            .Left      = 297
            .Width     = 50
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .AutoSize  = .F.
            .Alignment = 0
            .BackStyle = 0
            .ForeColor = RGB(90,90,90)
            .Caption   = "Empresa :"
        ENDWITH

        loc_oPag.AddObject("txt_4c_CodEmpresa", "TextBox")
        WITH loc_oPag.txt_4c_CodEmpresa
            .Top           = 149
            .Left          = 349
            .Width         = 31
            .Height        = 23
            .FontName      = "Tahoma"
            .FontSize      = 8
            .Format        = "K"
            .MaxLength     = 3
            .SpecialEffect = 1
            .Value         = ""
        ENDWITH

        loc_oPag.AddObject("txt_4c_NomeEmpresa", "TextBox")
        WITH loc_oPag.txt_4c_NomeEmpresa
            .Top           = 149
            .Left          = 383
            .Width         = 290
            .Height        = 23
            .FontName      = "Tahoma"
            .FontSize      = 8
            .Format        = "K"
            .MaxLength     = 40
            .SpecialEffect = 1
            .Value         = ""
        ENDWITH

        *-- Periodo (Say3 + Get_Datai + Say6 "ate" + Get_Dataf + optPeriodo)
        loc_oPag.AddObject("lbl_4c_Periodo", "Label")
        WITH loc_oPag.lbl_4c_Periodo
            .Top       = 180
            .Left      = 302
            .Width     = 45
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .AutoSize  = .F.
            .Alignment = 0
            .BackStyle = 0
            .ForeColor = RGB(90,90,90)
            .Caption   = "Per" + CHR(237) + "odo :"
        ENDWITH

        loc_oPag.AddObject("txt_4c_DataInicial", "TextBox")
        WITH loc_oPag.txt_4c_DataInicial
            .Top           = 177
            .Left          = 349
            .Width         = 80
            .Height        = 23
            .FontName      = "Tahoma"
            .FontSize      = 8
            .Alignment     = 3
            .SpecialEffect = 1
            .Value         = {}
        ENDWITH

        loc_oPag.AddObject("lbl_4c_Ate", "Label")
        WITH loc_oPag.lbl_4c_Ate
            .Top       = 180
            .Left      = 434
            .Width     = 20
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .AutoSize  = .F.
            .Alignment = 0
            .BackStyle = 0
            .ForeColor = RGB(90,90,90)
            .Caption   = "at" + CHR(233)
        ENDWITH

        loc_oPag.AddObject("txt_4c_DataFinal", "TextBox")
        WITH loc_oPag.txt_4c_DataFinal
            .Top           = 177
            .Left          = 457
            .Width         = 80
            .Height        = 23
            .FontName      = "Tahoma"
            .FontSize      = 8
            .Alignment     = 3
            .SpecialEffect = 1
            .Value         = {}
        ENDWITH

        loc_oPag.AddObject("obj_4c_Periodo", "OptionGroup")
        WITH loc_oPag.obj_4c_Periodo
            .Top         = 175
            .Left        = 544
            .Width       = 168
            .Height      = 25
            .BackStyle   = 0
            .BorderStyle = 0
            .ButtonCount = 2
            .Value       = 1

            WITH .Buttons(1)
                .FontName  = "Tahoma"
                .FontSize  = 8
                .BackStyle = 0
                .Caption   = "Vencimento"
                .ForeColor = RGB(90,90,90)
                .Left      = 5
                .Top       = 5
                .Width     = 73
                .Height    = 15
                .AutoSize  = .T.
                .Themes    = .F.
            ENDWITH

            WITH .Buttons(2)
                .FontName  = "Tahoma"
                .FontSize  = 8
                .BackStyle = 0
                .Caption   = "Emiss" + CHR(227) + "o"
                .ForeColor = RGB(90,90,90)
                .Left      = 96
                .Top       = 5
                .AutoSize  = .T.
                .Themes    = .F.
            ENDWITH
        ENDWITH

        *-- Banco/Conta (Say2 + get_cd_car_conta + get_ds_car_conta)
        loc_oPag.AddObject("lbl_4c_Banco", "Label")
        WITH loc_oPag.lbl_4c_Banco
            .Top       = 209
            .Left      = 309
            .Width     = 38
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .AutoSize  = .F.
            .Alignment = 0
            .BackStyle = 0
            .ForeColor = RGB(90,90,90)
            .Caption   = "Banco :"
        ENDWITH

        loc_oPag.AddObject("txt_4c_CodConta", "TextBox")
        WITH loc_oPag.txt_4c_CodConta
            .Top           = 205
            .Left          = 349
            .Width         = 79
            .Height        = 23
            .FontName      = "Tahoma"
            .FontSize      = 8
            .Format        = "K"
            .MaxLength     = 10
            .SpecialEffect = 1
            .Value         = ""
        ENDWITH

        loc_oPag.AddObject("txt_4c_NomeConta", "TextBox")
        WITH loc_oPag.txt_4c_NomeConta
            .Top           = 205
            .Left          = 430
            .Width         = 290
            .Height        = 23
            .FontName      = "Tahoma"
            .FontSize      = 8
            .Format        = "K"
            .MaxLength     = 40
            .SpecialEffect = 1
            .Value         = ""
        ENDWITH

        *-- Titulo Banco (Say12 + Get_titban -> lookup em SigOpFp.Fpags)
        loc_oPag.AddObject("lbl_4c_TituloBanco", "Label")
        WITH loc_oPag.lbl_4c_TituloBanco
            .Top       = 235
            .Left      = 280
            .Width     = 70
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .AutoSize  = .F.
            .Alignment = 0
            .BackStyle = 0
            .ForeColor = RGB(90,90,90)
            .Caption   = "T" + CHR(237) + "tulo Banco : "
        ENDWITH

        loc_oPag.AddObject("txt_4c_TituloBanco", "TextBox")
        WITH loc_oPag.txt_4c_TituloBanco
            .Top           = 232
            .Left          = 348
            .Width         = 94
            .Height        = 23
            .FontName      = "Tahoma"
            .FontSize      = 8
            .MaxLength     = 12
            .SpecialEffect = 1
            .Value         = ""
        ENDWITH

        *-- Label "Operacao :" (Say1), ao lado esquerdo da grade
        loc_oPag.AddObject("lbl_4c_Operacao", "Label")
        WITH loc_oPag.lbl_4c_Operacao
            .Top       = 263
            .Left      = 291
            .Width     = 55
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .AutoSize  = .F.
            .Alignment = 0
            .BackStyle = 0
            .ForeColor = RGB(90,90,90)
            .Caption   = "Opera" + CHR(231) + CHR(227) + "o :"
        ENDWITH

        *-- Cursor placeholder da grade de operacoes (regra #41: o ControlSource
        *-- das colunas nao pode apontar para cursor que ainda nao existe).
        *-- Estrutura identica a THIS.CarregarOperacoes(), que substitui o
        *-- conteudo pelo resultado real do SQLEXEC.
        IF USED("cursor_4c_Operacoes")
            USE IN cursor_4c_Operacoes
        ENDIF
        SET NULL ON
        CREATE CURSOR cursor_4c_Operacoes (Dopes C(20) NULL, Marca L NULL)
        SET NULL OFF

        *-- Grade de selecao de operacoes (grdope no legado, Pagina Filtro)
        loc_oPag.AddObject("grd_4c_Operacoes", "Grid")
        loc_oGrid = loc_oPag.grd_4c_Operacoes

        *-- ColumnCount/RecordSource FORA do WITH (regra GRID-WITH): dentro do
        *-- mesmo WITH que acessa .Column, o Grid pode nao ter as colunas
        *-- prontas ainda, e o acesso a .Column1 logo abaixo estouraria
        *-- 'Unknown member COLUMN1'.
        loc_oGrid.ColumnCount  = 2
        loc_oGrid.RecordSource = "cursor_4c_Operacoes"

        WITH loc_oGrid
            .Top               = 261
            .Left              = 350
            .Width             = 202
            .Height            = 344
            .FontName          = "Tahoma"
            .AllowHeaderSizing = .F.
            .AllowRowSizing    = .F.
            .DeleteMark        = .F.
            .RecordMark        = .F.
            .GridLines         = 3
            .GridLineColor     = RGB(238,238,238)
            .ScrollBars        = 2
            .Themes            = .F.

            *-- Limpa o ControlSource auto-atribuido pelo Grid (por default ele
            *-- liga Column1 ao 1o campo do cursor - Dopes, Character) ANTES de
            *-- adicionar o CheckBox, senao o VFP tenta sincronizar o .Value do
            *-- controle novo com um campo Character e estoura "Data type
            *-- mismatch" (regra #18: AddObject/CurrentControl SEMPRE antes do
            *-- ControlSource definitivo).
            .Column1.ControlSource = ""
            .Column1.AddObject("chk_4c_Marca", "CheckBox")
            .Column1.CurrentControl = "chk_4c_Marca"
            WITH .Column1.chk_4c_Marca
                .Caption   = ""
                .BackColor = RGB(255,255,255)
            ENDWITH

            .Column1.ControlSource  = "cursor_4c_Operacoes.Marca"
            .Column2.ControlSource  = "cursor_4c_Operacoes.Dopes"

            *-- Largura/legenda reaplicadas DEPOIS do RecordSource/ControlSource
            *-- (ambos resetam Column.Width e Header1.Caption - Problema 48)
            .Column1.Width          = 18
            .Column1.Movable        = .F.
            .Column1.Resizable      = .F.
            .Column1.Sparse         = .F.
            .Column1.ReadOnly       = .F.
            .Column1.Header1.Caption = ""

            .Column2.Width          = 150
            .Column2.Movable        = .F.
            .Column2.Resizable      = .F.
            .Column2.ReadOnly       = .T.
            .Column2.Header1.Alignment = 2
            .Column2.Header1.Caption   = "Opera" + CHR(231) + CHR(227) + "o"
        ENDWITH
    ENDPROC

    *==========================================================================
    * ConfigurarPaginaDados - Estrutura base da Page2 (Dados)
    * Fase 5/8: faixa do cabecalho (regra #11 - nas DUAS paginas, PRIMEIRO
    * AddObject da pagina) + primeiros 50% dos campos "principais" de
    * pgdados (Say12/spndias/Say1 - "Protestar apos <N> dias", que ja tem
    * property no BO: this_nDiasProtesto). O aviso de endereco longo
    * (Say2/Botao1), a grade de titulos (grdope, 8 colunas) e os botoes de
    * acao (cmdTestaPos/Commandgroup1/Commandgroup2) ficam para a Fase 6.
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPaginaDados()
        LOCAL loc_oPag, loc_oCab, loc_oGridTit

        loc_oPag = THIS.pgf_4c_Paginas.Page2

        *-- Faixa do cabecalho - PRIMEIRO AddObject da pagina (regra #11/#39):
        *-- containers de botao (cnt_4c_BotoesAcao, Top=27..112) ficam DENTRO
        *-- da area da faixa (Top=29..109) e tem de ser criados DEPOIS para
        *-- desenhar por cima (excecao da regra: barra de acao do topo com
        *-- Top 20..55 e Height 60..100 fica POR CIMA, sem ser deslocada).
        loc_oPag.AddObject("cnt_4c_Cabecalho", "Container")
        loc_oCab = loc_oPag.cnt_4c_Cabecalho
        WITH loc_oCab
            .Top           = 29
            .Left          = 0
            .Width         = THIS.Width
            .Height        = 80
            .BorderWidth   = 0
            .SpecialEffect = 0
            .BackColor     = RGB(100,100,100)

            .AddObject("lbl_4c_Sombra", "Label")
            WITH .lbl_4c_Sombra
                .Top       = 15
                .Left      = 10
                .Width     = THIS.Width
                .Height    = 40
                .FontName  = "Tahoma"
                .FontSize  = 16
                .FontBold  = .T.
                .WordWrap  = .T.
                .Alignment = 0
                .BackStyle = 0
                .ForeColor = RGB(0,0,0)
                .Caption   = "Gera" + CHR(231) + CHR(227) + "o de Arquivos CNAB - Recebimentos"
            ENDWITH

            .AddObject("lbl_4c_Titulo", "Label")
            WITH .lbl_4c_Titulo
                .Top       = 18
                .Left      = 10
                .Width     = THIS.Width
                .Height    = 46
                .FontName  = "Tahoma"
                .FontSize  = 16
                .FontBold  = .T.
                .WordWrap  = .T.
                .Alignment = 0
                .BackStyle = 0
                .ForeColor = RGB(255,255,255)
                .Caption   = "Gera" + CHR(231) + CHR(227) + "o de Arquivos CNAB - Recebimentos"
            ENDWITH
        ENDWITH

        *-- Container de botoes de acao (Encerrar / Gerar CNAB / Relatorio / Boleto)
        loc_oPag.AddObject("cnt_4c_BotoesAcao", "Container")
        WITH loc_oPag.cnt_4c_BotoesAcao
            .Top         = 27
            .Left        = 692
            .Width       = 310
            .Height      = 85
            .BackStyle   = 0
            .BorderWidth = 0

            *-- cmd_4c_Encerrar (btnsair/cmdTestaPos no legado) - Caption e
            *-- Picture IDENTICOS ao Encerrar da Pagina Lista (mesmo icone
            *-- "sair"), mas a acao real eh VOLTAR para o filtro
            *-- (thisform.pgfprincipal.ActivePage=1) - o legado usa essa
            *-- legenda mesmo a acao nao fechando o form; PILAR 1 manda
            *-- preservar, nao "corrigir" para "Voltar".
            .AddObject("cmd_4c_Encerrar", "CommandButton")
            WITH .cmd_4c_Encerrar
                .Top             = 5
                .Left = 5
                .Width           = 75
                .Height          = 75
                .FontName        = "Comic Sans MS"
                .FontSize        = 8
                .FontBold        = .T.
                .FontItalic      = .T.
                .WordWrap        = .T.
                .Alignment       = 2
                .PicturePosition = 13
                .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
                .Cancel          = .T.
                .Caption         = "Encerrar"
                .ToolTipText     = "[ESC] Encerrar"
                .MousePointer    = 15
                .SpecialEffect   = 0
                .ForeColor       = RGB(90,90,90)
                .BackColor       = RGB(255,255,255)
            ENDWITH

            *-- obj_4c_Comandos (Commandgroup1 no legado: Gerar CNAB/Relatorio/
            *-- Boleto). Fica a esquerda do Encerrar (Left relativo 0..225),
            *-- igual ao legado (Commandgroup1.Left=692 < cmdTestaPos.Left=917).
            .AddObject("obj_4c_Comandos", "CommandGroup")
            WITH .obj_4c_Comandos
                .Top          = 5
                .Left         = 0
                .Width        = 225
                .Height       = 75
                .BackStyle    = 0
                .ButtonCount  = 3

                WITH .Buttons(1)
                    .Top             = 5
                    .Left            = 5
                    .Width           = 75
                    .Height          = 75
                    .FontName        = "Comic Sans MS"
                    .FontSize        = 8
                    .FontBold        = .T.
                    .FontItalic      = .T.
                    .WordWrap        = .T.
                    .Alignment       = 2
                    .PicturePosition = 13
                    .Picture         = gc_4c_CaminhoIcones + "geral_disco2_60.jpg"
                    .Caption         = "Gerar CNAB"
                    .ToolTipText     = "Gerar CNAB"
                    .ForeColor       = RGB(90,90,90)
                    .BackColor       = RGB(255,255,255)
                    .Themes          = .F.
                ENDWITH

                WITH .Buttons(2)
                    .Top             = 5
                    .Left            = 80
                    .Width           = 75
                    .Height          = 75
                    .FontName        = "Comic Sans MS"
                    .FontSize        = 8
                    .FontBold        = .T.
                    .FontItalic      = .T.
                    .WordWrap        = .T.
                    .Alignment       = 2
                    .PicturePosition = 13
                    .Picture         = gc_4c_CaminhoIcones + "geral_video_60.jpg"
                    .Caption         = "Relat" + CHR(243) + "rio"
                    .ToolTipText     = "Relat" + CHR(243) + "rio"
                    .ForeColor       = RGB(90,90,90)
                    .BackColor       = RGB(255,255,255)
                    .Themes          = .F.
                ENDWITH

                WITH .Buttons(3)
                    .Top             = 5
                    .Left            = 155
                    .Width           = 75
                    .Height          = 75
                    .FontName        = "Comic Sans MS"
                    .FontSize        = 8
                    .FontBold        = .T.
                    .FontItalic      = .T.
                    .WordWrap        = .T.
                    .Alignment       = 2
                    .PicturePosition = 13
                    .Picture         = gc_4c_CaminhoIcones + "geral_impressora_60.jpg"
                    .Caption         = "Boleto"
                    .ToolTipText     = "Boleto"
                    .Enabled         = .F.
                    .ForeColor       = RGB(90,90,90)
                    .BackColor       = RGB(255,255,255)
                    .Themes          = .F.
                ENDWITH
            ENDWITH
        ENDWITH

        *-- "Protestar apos <N> dias" (Say12 + spndias + Say1 no legado,
        *-- Top=98..103 original - reposicionado para Top=120, abaixo da
        *-- faixa de cabecalho recem-adicionada, regra #11 re-layout).
        *-- this_nDiasProtesto (BO) ja existe com default 5, igual ao
        *-- spndias.Value implicito do legado.
        loc_oPag.AddObject("lbl_4c_Label12", "Label")
        WITH loc_oPag.lbl_4c_Label12
            .Top       = 124
            .Left      = 370
            .Width     = 80
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .AutoSize  = .F.
            .Alignment = 0
            .BackStyle = 0
            .ForeColor = RGB(90,90,90)
            .Caption   = "Protestar ap" + CHR(243) + "s :"
        ENDWITH

        loc_oPag.AddObject("spn_4c_DiasProtesto", "Spinner")
        WITH loc_oPag.spn_4c_DiasProtesto
            .Top          = 120
            .Left         = 451
            .Width        = 45
            .Height       = 24
            .FontName     = "Tahoma"
            .FontSize     = 8
            .SpinnerLowValue  = 0
            .SpinnerHighValue = 999
            .Increment    = 1
            .Value        = 5
        ENDWITH

        loc_oPag.AddObject("lbl_4c_Label1", "Label")
        WITH loc_oPag.lbl_4c_Label1
            .Top       = 124
            .Left      = 501
            .Width     = 21
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .AutoSize  = .F.
            .Alignment = 0
            .BackStyle = 0
            .ForeColor = RGB(90,90,90)
            .Caption   = "dias"
        ENDWITH

        *-- Aviso de endereco longo (Say2/Botao1 no legado, raw Top=14/15 -
        *-- ficava ACIMA do grupo "Protestar apos" no SCX original). Com a
        *-- faixa do cabecalho ocupando Top 29..109 (regra #11), o aviso foi
        *-- reposicionado para LOGO ABAIXO do grupo de dias (que fecha em
        *-- Top=139), preservando os dois controles sem sobrepor nada -
        *-- re-layout de pagina cheia (regra #11/#39), nao invencao de novo
        *-- elemento.
        loc_oPag.AddObject("lbl_4c_AvisoEndereco", "Label")
        WITH loc_oPag.lbl_4c_AvisoEndereco
            .Top       = 154
            .Left      = 390
            .Width     = 238
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .AutoSize  = .F.
            .Alignment = 0
            .BackStyle = 0
            .ForeColor = RGB(255,0,0)
            .Caption   = "Endere" + CHR(231) + "os com tamanho maior que 40 caracteres"
        ENDWITH

        *-- Botao1 no legado eh so uma caixinha vermelha decorativa (When
        *-- sempre .F. - nunca recebe foco/clique), legenda de cor ao lado
        *-- do aviso acima.
        loc_oPag.AddObject("txt_4c_AvisoCor", "TextBox")
        WITH loc_oPag.txt_4c_AvisoCor
            .Top           = 153
            .Left          = 370
            .Width         = 17
            .Height        = 16
            .SpecialEffect = 1
            .BackColor     = RGB(255,0,0)
            .BorderColor   = RGB(255,0,0)
            .ReadOnly      = .T.
            .TabStop       = .F.
            .Themes        = .F.
            .Value         = ""
        ENDWITH

        *-- Cursor placeholder da grade de titulos (regra #41 - ControlSource
        *-- nao pode apontar para cursor que ainda nao existe). Estrutura
        *-- identica ao resultado do SQLEXEC de THIS.ProcessarTitulos()
        *-- (mesmos nomes/tipos do "crFiltro" do legado).
        IF USED("cursor_4c_Titulos")
            USE IN cursor_4c_Titulos
        ENDIF
        SET NULL ON
        CREATE CURSOR cursor_4c_Titulos (Marca L NULL, Titulos C(10) NULL, Dopes C(20) NULL, ;
            Numes N(6,0) NULL, RClis C(50) NULL, Vencs T NULL, Fpags C(12) NULL, Valos N(11,2) NULL, ;
            Datas T NULL, Vpags N(11,2) NULL, IClis C(10) NULL, Endes C(60) NULL, Cidas C(30) NULL, ;
            Estas C(2) NULL, Nums C(10) NULL, Compls C(50) NULL, Bairs C(40) NULL, Ceps C(9) NULL, ;
            Cpfs C(20) NULL, Emps C(3) NULL, EmpDopNums C(29) NULL, Nopers N(7,0) NULL, Razaos C(50) NULL, ;
            EndCobs C(80) NULL, CepCobs C(9) NULL, EstCobs C(2) NULL, BaiCobs C(20) NULL, CidCobs C(20) NULL, ;
            EndErro N(1,0) NULL)
        SET NULL OFF

        *-- Grade de titulos em aberto (grdope no legado, Pagina Dados) - 8
        *-- colunas. ColumnOrder visual segue o legado (Column8 "Titulo"
        *-- aparece logo apos o checkbox - regra #35b: a grade espelha a
        *-- estrutura do legado, nao a ordem de criacao das colunas).
        loc_oPag.AddObject("grd_4c_Titulos", "Grid")
        loc_oGridTit = loc_oPag.grd_4c_Titulos

        *-- ColumnCount/RecordSource FORA do WITH (regra GRID-WITH): dentro do
        *-- mesmo WITH que acessa .Column, o Grid pode nao ter as colunas
        *-- prontas ainda, e o acesso a .Column1 logo abaixo estouraria
        *-- 'Unknown member COLUMN1'.
        loc_oGridTit.ColumnCount  = 8
        loc_oGridTit.RecordSource = "cursor_4c_Titulos"

        WITH loc_oGridTit
            .Top               = 180
            .Left              = 7
            .Width             = 981
            .Height            = 382
            .FontName          = "Tahoma"
            .AllowHeaderSizing = .F.
            .AllowRowSizing    = .F.
            .DeleteMark        = .F.
            .RecordMark        = .F.
            .GridLineColor     = RGB(238,238,238)
            .ScrollBars        = 2
            .Themes            = .F.

            *-- Limpa o ControlSource auto-atribuido pelo Grid ANTES de
            *-- adicionar o CheckBox (regra #18).
            .Column1.ControlSource = ""
            .Column1.AddObject("chk_4c_Marca", "CheckBox")
            .Column1.CurrentControl = "chk_4c_Marca"
            WITH .Column1.chk_4c_Marca
                .Caption   = ""
                .BackColor = RGB(255,255,255)
            ENDWITH

            .Column1.ControlSource = "cursor_4c_Titulos.Marca"
            .Column2.ControlSource = "cursor_4c_Titulos.Dopes"
            .Column3.ControlSource = "cursor_4c_Titulos.Numes"
            .Column4.ControlSource = "cursor_4c_Titulos.RClis"
            .Column5.ControlSource = "cursor_4c_Titulos.Vencs"
            .Column6.ControlSource = "cursor_4c_Titulos.Fpags"
            .Column7.ControlSource = "cursor_4c_Titulos.Valos"
            .Column8.ControlSource = "cursor_4c_Titulos.Titulos"

            .Column1.Width           = 16
            .Column1.Movable         = .F.
            .Column1.Resizable       = .F.
            .Column1.Sparse         = .F.
            .Column1.ReadOnly        = .F.
            .Column1.Header1.Caption = ""
        ENDWITH

        *-- Largura/legenda/ordem reaplicadas DEPOIS do RecordSource/
        *-- ControlSource (Problema 48 - ambos resetam Column.Width e
        *-- Header1.Caption).
        THIS.FormatarGridTitulos(loc_oGridTit)

        *-- Container Marcar/Desmarcar Tudo dos titulos (Commandgroup2 no
        *-- legado, pgdados) - mesmo padrao visual do cnt_4c_Marca da
        *-- Pagina Filtro.
        loc_oPag.AddObject("cnt_4c_Marca", "Container")
        WITH loc_oPag.cnt_4c_Marca
            .Top         = 570
            .Left        = 7
            .Width       = 92
            .Height      = 50
            .BackStyle   = 0
            .BorderWidth = 0

            .AddObject("cmd_4c_MarcarTudo", "CommandButton")
            WITH .cmd_4c_MarcarTudo
                .Top           = 5
                .Left          = 5
                .Width         = 40
                .Height        = 40
                .FontName      = "Verdana"
                .FontSize      = 7
                .Picture       = gc_4c_CaminhoIcones + "geral_adicao_26.jpg"
                .Caption       = ""
                .ToolTipText   = "Marcar tudo"
                .ForeColor     = RGB(36,84,155)
                .BackColor     = RGB(255,255,255)
            ENDWITH

            .AddObject("cmd_4c_DesmarcarTudo", "CommandButton")
            WITH .cmd_4c_DesmarcarTudo
                .Top           = 5
                .Left          = 45
                .Width         = 40
                .Height        = 40
                .FontName      = "Verdana"
                .FontSize      = 8
                .Picture       = gc_4c_CaminhoIcones + "cadastro_excluir_26.jpg"
                .Caption       = ""
                .ToolTipText   = "Desmarcar tudo"
                .ForeColor     = RGB(36,84,155)
                .BackColor     = RGB(255,255,255)
                .Themes        = .F.
            ENDWITH
        ENDWITH
    ENDPROC

    *==========================================================================
    * FormatarGridTitulos - Reaplica largura/legenda/ordem/cor dinamica das
    * colunas da grade de titulos. Chamado apos QUALQUER atribuicao de
    * RecordSource/ControlSource (Problema 48 - ambos resetam Column.Width e
    * Header1.Caption): uma vez na estrutura inicial (ConfigurarPaginaDados)
    * e de novo apos o SQLEXEC real (THIS.ProcessarTitulos).
    *==========================================================================
    PROTECTED PROCEDURE FormatarGridTitulos(par_oGrid)
        WITH par_oGrid
            .Column1.Width           = 16
            .Column1.Movable         = .F.
            .Column1.Resizable       = .F.
            .Column1.Sparse          = .F.
            .Column1.ReadOnly        = .F.
            .Column1.ColumnOrder     = 1
            .Column1.Header1.Caption = ""

            .Column2.Width             = 150
            .Column2.Movable           = .F.
            .Column2.Resizable         = .F.
            .Column2.ReadOnly          = .T.
            .Column2.ColumnOrder       = 3
            .Column2.Header1.Alignment = 2
            .Column2.Header1.Caption   = "Opera" + CHR(231) + CHR(227) + "o"

            .Column3.Width             = 52
            .Column3.Movable           = .F.
            .Column3.Resizable         = .F.
            .Column3.ReadOnly          = .T.
            .Column3.ColumnOrder       = 4
            .Column3.Header1.Alignment = 2
            .Column3.Header1.Caption   = "C" + CHR(243) + "digo"

            .Column4.Width             = 400
            .Column4.Movable           = .F.
            .Column4.Resizable         = .F.
            .Column4.ReadOnly          = .T.
            .Column4.ColumnOrder       = 5
            .Column4.Header1.Alignment = 2
            .Column4.Header1.Caption   = "Cliente"

            .Column5.Width             = 72
            .Column5.Movable           = .F.
            .Column5.Resizable         = .F.
            .Column5.ReadOnly          = .T.
            .Column5.ColumnOrder       = 6
            .Column5.Header1.Alignment = 2
            .Column5.Header1.Caption   = "Vencimento"

            .Column6.Width             = 87
            .Column6.Movable           = .F.
            .Column6.Resizable         = .F.
            .Column6.ReadOnly          = .T.
            .Column6.ColumnOrder       = 7
            .Column6.Header1.Alignment = 2
            .Column6.Header1.Caption   = "Forma Pagto"

            .Column7.Width             = 100
            .Column7.Movable           = .F.
            .Column7.Resizable         = .F.
            .Column7.ReadOnly          = .T.
            .Column7.ColumnOrder       = 8
            .Column7.Header1.Alignment = 2
            .Column7.Header1.Caption   = "Valor"

            .Column8.Movable           = .F.
            .Column8.Resizable         = .F.
            .Column8.ReadOnly          = .T.
            .Column8.ColumnOrder       = 2
            .Column8.Header1.Alignment = 2
            .Column8.Header1.Caption   = "T" + CHR(237) + "tulo"

            .SetAll("DynamicForeColor", "IIF(cursor_4c_Titulos.EndErro = 1, RGB(255,0,0), RGB(0,0,0))", "Column")
        ENDWITH
    ENDPROC

    *==========================================================================
    * CarregarOperacoes - Popula cursor_4c_Operacoes com as operacoes (SigCdOpe)
    * elegiveis para o processo de CNAB (Parcontas=1 e ValPends=1), igual ao
    * legado (Init: "select dopes, ?lltru as marca from SigCdOpe where
    * Parcontas = 1 And ValPends = 1 order by dopes", com lltru=.F.).
    * Cursor eh READWRITE porque a Coluna1 do grid eh um CheckBox editavel
    * (marca/desmarca operacao) - SQLEXEC devolve cursor somente-leitura.
    *==========================================================================
    PROTECTED PROCEDURE CarregarOperacoes()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "SELECT Dopes, CAST(0 AS BIT) AS Marca" + CHR(13) + ;
                       "FROM SigCdOpe" + CHR(13) + ;
                       "WHERE Parcontas = 1 AND ValPends = 1" + CHR(13) + ;
                       "ORDER BY Dopes"

            IF USED("cursor_4c_OperacoesTmp")
                USE IN cursor_4c_OperacoesTmp
            ENDIF

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_OperacoesTmp")

            IF loc_nResultado >= 0
                IF USED("cursor_4c_Operacoes")
                    USE IN cursor_4c_Operacoes
                ENDIF

                SELECT * FROM cursor_4c_OperacoesTmp INTO CURSOR cursor_4c_Operacoes READWRITE

                IF USED("cursor_4c_OperacoesTmp")
                    USE IN cursor_4c_OperacoesTmp
                ENDIF

                IF RECCOUNT("cursor_4c_Operacoes") > 0
                    SELECT cursor_4c_Operacoes
                    GO TOP
                ENDIF

                THIS.pgf_4c_Paginas.Page1.grd_4c_Operacoes.ColumnCount = 3
                THIS.pgf_4c_Paginas.Page1.grd_4c_Operacoes.RecordSource = "cursor_4c_Operacoes"

                *-- RecordSource reatribuido faz o Grid auto-bindar as colunas
                *-- pela ordem dos campos do cursor, ignorando o ControlSource
                *-- anterior - redefinir explicitamente (regra GRID-RECORDSOURCE-AUTOBIND).
                THIS.pgf_4c_Paginas.Page1.grd_4c_Operacoes.Column1.ControlSource = "cursor_4c_Operacoes.Marca"
                THIS.pgf_4c_Paginas.Page1.grd_4c_Operacoes.Column2.ControlSource = "cursor_4c_Operacoes.Dopes"

                THIS.pgf_4c_Paginas.Page1.grd_4c_Operacoes.Refresh()

                loc_lSucesso = .T.
            ELSE
                MostrarErro("Erro ao carregar as opera" + CHR(231) + CHR(245) + "es:" + CHR(13) + ;
                            CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MostrarErro(loc_oErro.Message + CHR(13) + ;
                        "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                        "Procedure: " + loc_oErro.Procedure, "Erro CarregarOperacoes")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * ConfigurarBindEventsFiltro - Registra os BINDEVENTs dos campos de filtro
    * da Page1 (Empresa/Periodo/Banco-Conta/Titulo Banco). Handlers PUBLIC
    * (regra #3 - BINDEVENT falha silenciosamente em metodo PROTECTED).
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarBindEventsFiltro()
        LOCAL loc_oPag
        loc_oPag = THIS.pgf_4c_Paginas.Page1

        *-- Empresa
        BINDEVENT(loc_oPag.txt_4c_CodEmpresa,  "KeyPress", THIS, "ValidarCodEmpresa")
        BINDEVENT(loc_oPag.txt_4c_NomeEmpresa, "KeyPress", THIS, "ValidarNomEmpresa")

        *-- Periodo (validacao de intervalo de datas)
        BINDEVENT(loc_oPag.txt_4c_DataFinal,   "KeyPress", THIS, "ValidarDataFinal")

        *-- Banco/Conta
        BINDEVENT(loc_oPag.txt_4c_CodConta,    "KeyPress", THIS, "ValidarCodConta")
        BINDEVENT(loc_oPag.txt_4c_NomeConta,   "KeyPress", THIS, "ValidarNomConta")

        *-- Titulo Banco (SigOpFp.Fpags)
        BINDEVENT(loc_oPag.txt_4c_TituloBanco, "KeyPress", THIS, "ValidarTituloBanco")
    ENDPROC

    *==========================================================================
    * ConfigurarBindEventsPrincipais - Registra os BINDEVENTs dos botoes
    * principais (Processar/Encerrar/Marcar/Desmarcar da Pagina Filtro e
    * Voltar/Marcar/Desmarcar da Pagina Dados). Handlers PUBLIC (regra #3).
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarBindEventsPrincipais()
        LOCAL loc_oPag1, loc_oPag2

        loc_oPag1 = THIS.pgf_4c_Paginas.Page1
        BINDEVENT(loc_oPag1.cnt_4c_Botoes.cmd_4c_Processar,    "Click", THIS, "BtnProcessarClick")
        BINDEVENT(loc_oPag1.cnt_4c_Botoes.cmd_4c_Encerrar,     "Click", THIS, "BtnEncerrarClick")
        BINDEVENT(loc_oPag1.cnt_4c_Marca.cmd_4c_MarcarTudo,    "Click", THIS, "BtnMarcarTudoClick")
        BINDEVENT(loc_oPag1.cnt_4c_Marca.cmd_4c_DesmarcarTudo, "Click", THIS, "BtnDesmarcarTudoClick")

        loc_oPag2 = THIS.pgf_4c_Paginas.Page2
        BINDEVENT(loc_oPag2.cnt_4c_BotoesAcao.cmd_4c_Encerrar,   "Click", THIS, "BtnVoltarClick")
        BINDEVENT(loc_oPag2.cnt_4c_Marca.cmd_4c_MarcarTudo,      "Click", THIS, "BtnMarcarTudoTitulosClick")
        BINDEVENT(loc_oPag2.cnt_4c_Marca.cmd_4c_DesmarcarTudo,   "Click", THIS, "BtnDesmarcarTudoTitulosClick")
        BINDEVENT(loc_oPag2.grd_4c_Titulos.Column1.chk_4c_Marca, "Click", THIS, "ChkTituloMarcaClick")

        *-- obj_4c_Comandos (Commandgroup1 no legado: btncnab/btnrelatorio/btnBoleto)
        BINDEVENT(loc_oPag2.cnt_4c_BotoesAcao.obj_4c_Comandos.Buttons(1), "Click", THIS, "BtnGerarCnabClick")
        BINDEVENT(loc_oPag2.cnt_4c_BotoesAcao.obj_4c_Comandos.Buttons(2), "Click", THIS, "BtnRelatorioCnabClick")
        BINDEVENT(loc_oPag2.cnt_4c_BotoesAcao.obj_4c_Comandos.Buttons(3), "Click", THIS, "BtnBoletoClick")
    ENDPROC

    *==========================================================================
    * BtnProcessarClick - cmdTestaPos.btnProcessar.Click no legado. Valida
    * Empresa/Periodo/Conta obrigatorios e exige ao menos 1 operacao marcada
    * antes de consultar os titulos em aberto.
    *==========================================================================
    PROCEDURE BtnProcessarClick()
        LOCAL loc_oPag, loc_nCont

        loc_oPag = THIS.pgf_4c_Paginas.Page1

        IF EMPTY(ALLTRIM(loc_oPag.txt_4c_CodEmpresa.Value))
            MsgAviso("Empresa inv" + CHR(225) + "lida", "Aviso")
            loc_oPag.txt_4c_CodEmpresa.SetFocus()
            RETURN
        ENDIF

        IF EMPTY(loc_oPag.txt_4c_DataInicial.Value) OR EMPTY(loc_oPag.txt_4c_DataFinal.Value)
            MsgAviso("Per" + CHR(237) + "odo inv" + CHR(225) + "lido", "Aviso")
            loc_oPag.txt_4c_DataInicial.SetFocus()
            RETURN
        ENDIF

        IF EMPTY(ALLTRIM(loc_oPag.txt_4c_CodConta.Value))
            MsgAviso("Banco inv" + CHR(225) + "lido", "Aviso")
            loc_oPag.txt_4c_CodConta.SetFocus()
            RETURN
        ENDIF

        loc_nCont = 0
        IF USED("cursor_4c_Operacoes")
            SELECT cursor_4c_Operacoes
            COUNT FOR Marca TO loc_nCont
        ENDIF
        IF loc_nCont = 0
            MsgAviso("Nenhuma opera" + CHR(231) + CHR(227) + "o foi selecionada", "Aviso")
            RETURN
        ENDIF

        THIS.ProcessarTitulos()
    ENDPROC

    *==========================================================================
    * BtnEncerrarClick - cmdTestaPos.btnsair.Click (Pagina Filtro) no legado.
    *==========================================================================
    PROCEDURE BtnEncerrarClick()
        THIS.Release()
    ENDPROC

    *==========================================================================
    * BtnMarcarTudoClick/BtnDesmarcarTudoClick - Commandgroup2.btnmarca/
    * btndesmarca.Click (Pagina Filtro) no legado - marca/desmarca TODAS as
    * operacoes do grid de filtro, sem excecao (igual ao legado).
    *==========================================================================
    PROCEDURE BtnMarcarTudoClick()
        IF USED("cursor_4c_Operacoes")
            SELECT cursor_4c_Operacoes
            REPLACE ALL Marca WITH .T.
            LOCATE
            GO TOP
        ENDIF
        THIS.pgf_4c_Paginas.Page1.grd_4c_Operacoes.Refresh()
    ENDPROC

    PROCEDURE BtnDesmarcarTudoClick()
        IF USED("cursor_4c_Operacoes")
            SELECT cursor_4c_Operacoes
            REPLACE ALL Marca WITH .F.
            LOCATE
            GO TOP
        ENDIF
        THIS.pgf_4c_Paginas.Page1.grd_4c_Operacoes.Refresh()
    ENDPROC

    *==========================================================================
    * ProcessarTitulos - PROCEDURE processamento no legado. Monta a lista de
    * operacoes marcadas + consulta os titulos em aberto (SigMvPar/SigOpFp/
    * SigMvCab/SigCdCli/SigMvCcr), populando cursor_4c_Titulos (READWRITE -
    * a coluna Marca eh CheckBox editavel no grid). Formula/filtros
    * TRANSCRITOS literalmente do legado (regra CLAUDE.md #17) - inclusive a
    * ausencia de filtro pela conta/carteira na consulta (o legado le
    * get_cd_car_conta so para validar preenchimento, e aplica a conta
    * apenas na geracao do CNAB, fase 8).
    *==========================================================================
    PROTECTED PROCEDURE ProcessarTitulos()
        LOCAL loc_oPag, loc_cListaOperacoes, loc_cEmpresa, loc_dIni, loc_dFim, loc_nPeriodo, ;
              loc_lNaoProcessados, loc_cCampoData, loc_cNotIn, loc_cSQL, loc_nResultado, ;
              loc_lSucesso, loc_oGrid, loc_oErro
        loc_lSucesso = .F.

        loc_oPag             = THIS.pgf_4c_Paginas.Page1
        loc_cEmpresa         = ALLTRIM(loc_oPag.txt_4c_CodEmpresa.Value)
        loc_dIni             = loc_oPag.txt_4c_DataInicial.Value
        loc_dFim             = loc_oPag.txt_4c_DataFinal.Value
        loc_nPeriodo         = loc_oPag.obj_4c_Periodo.Value          && 1=Vencimento, 2=Emissao
        loc_lNaoProcessados  = (loc_oPag.obj_4c_Processados.Value = 1) && 1=Nao Processadas, 2=Ja Processadas

        *-- Lista das operacoes marcadas - IN-list de coluna CHAR unica
        *-- (compara com blank-padding ANSI no SQL Server); NAO eh a chave
        *-- POSICIONAL concatenada da regra #42, ALLTRIM por item eh seguro.
        loc_cListaOperacoes = "("
        IF USED("cursor_4c_Operacoes")
            SELECT cursor_4c_Operacoes
            SCAN FOR Marca
                loc_cListaOperacoes = loc_cListaOperacoes + ;
                    IIF(loc_cListaOperacoes == "(", "", ",") + EscaparSQL(ALLTRIM(Dopes))
            ENDSCAN
        ENDIF
        loc_cListaOperacoes = loc_cListaOperacoes + ")"

        loc_cCampoData = IIF(loc_nPeriodo = 1, "a.vencs", "e.dtemis")
        loc_cNotIn     = IIF(loc_lNaoProcessados, "NOT ", "")

        TRY
            loc_cSQL = ;
                "SELECT CAST(1 AS BIT) AS Marca, e.titulos AS Titulos, a.dopes AS Dopes, a.numes AS Numes," + CHR(13) + ;
                "       d.rclis AS RClis, a.vencs AS Vencs, b.fpags AS Fpags, a.valos AS Valos, a.datas AS Datas," + CHR(13) + ;
                "       a.vpags AS Vpags, d.iclis AS IClis, d.endes AS Endes, d.cidas AS Cidas, d.estas AS Estas," + CHR(13) + ;
                "       d.nums AS Nums, d.compls AS Compls, d.bairs AS Bairs, d.ceps AS Ceps, d.cpfs AS Cpfs," + CHR(13) + ;
                "       a.emps AS Emps, a.empdopnums AS EmpDopNums, a.nopers AS Nopers, d.razaos AS Razaos," + CHR(13) + ;
                "       d.endcobs AS EndCobs, d.cepcobs AS CepCobs, d.estcobs AS EstCobs, d.baicobs AS BaiCobs, d.cidcobs AS CidCobs," + CHR(13) + ;
                "       CASE WHEN d.endcobs <> '' AND LEN(RTRIM(d.endcobs)) > 40 THEN 1" + CHR(13) + ;
                "            WHEN d.endes <> '' AND LEN(RTRIM(d.endes) + ' ' + RTRIM(d.nums) + ' ' + RTRIM(d.compls)) > 40 THEN 1" + CHR(13) + ;
                "            ELSE 0 END AS EndErro" + CHR(13) + ;
                "FROM SigMvPar a" + CHR(13) + ;
                "INNER JOIN SigOpFp b ON a.fpags = b.fpags" + CHR(13) + ;
                "LEFT JOIN SigMvCab c ON a.empdopnums = c.empdopnums" + CHR(13) + ;
                "LEFT JOIN SigCdCli d ON c.contads = d.iclis" + CHR(13) + ;
                "LEFT JOIN SigMvCcr e ON a.empdopnums = e.empdopnums AND a.nopers = e.nopers" + CHR(13) + ;
                "WHERE b.infos = 'B' AND a.vpags = 0" + CHR(13) + ;
                "  AND " + loc_cCampoData + " BETWEEN " + FormatarDataSQL(loc_dIni) + " AND " + FormatarDataSQL(loc_dFim) + CHR(13) + ;
                "  AND e.opers = 'C'" + CHR(13) + ;
                "  AND c.emps = " + EscaparSQL(loc_cEmpresa) + CHR(13) + ;
                "  AND a.dopes IN " + loc_cListaOperacoes + CHR(13) + ;
                "  AND a.empdopnums + e.titulos " + loc_cNotIn + "IN (" + CHR(13) + ;
                "      SELECT f.empdopnums + SUBSTRING(f.dopeds, 1, 10)" + CHR(13) + ;
                "      FROM SigPcOoL f" + CHR(13) + ;
                "      WHERE f.tipos = 'SIGPRCNB')" + CHR(13) + ;
                "ORDER BY a.dopes, a.numes, a.parcs"

            IF USED("cursor_4c_TitulosTmp")
                USE IN cursor_4c_TitulosTmp
            ENDIF

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_TitulosTmp")

            IF loc_nResultado >= 0
                IF USED("cursor_4c_Titulos")
                    USE IN cursor_4c_Titulos
                ENDIF

                SELECT * FROM cursor_4c_TitulosTmp INTO CURSOR cursor_4c_Titulos READWRITE

                IF USED("cursor_4c_TitulosTmp")
                    USE IN cursor_4c_TitulosTmp
                ENDIF

                IF RECCOUNT("cursor_4c_Titulos") = 0
                    MsgAviso("Nenhum dado foi encontrado", "Aviso")
                ELSE
                    SELECT cursor_4c_Titulos
                    REPLACE ALL Marca WITH .F. FOR EndErro = 1
                    GO TOP

                    loc_oGrid = THIS.pgf_4c_Paginas.Page2.grd_4c_Titulos
                    loc_oGrid.ColumnCount = 8
                    loc_oGrid.RecordSource         = "cursor_4c_Titulos"
                    loc_oGrid.Column1.ControlSource = "cursor_4c_Titulos.Marca"
                    loc_oGrid.Column2.ControlSource = "cursor_4c_Titulos.Dopes"
                    loc_oGrid.Column3.ControlSource = "cursor_4c_Titulos.Numes"
                    loc_oGrid.Column4.ControlSource = "cursor_4c_Titulos.RClis"
                    loc_oGrid.Column5.ControlSource = "cursor_4c_Titulos.Vencs"
                    loc_oGrid.Column6.ControlSource = "cursor_4c_Titulos.Fpags"
                    loc_oGrid.Column7.ControlSource = "cursor_4c_Titulos.Valos"
                    loc_oGrid.Column8.ControlSource = "cursor_4c_Titulos.Titulos"
                    THIS.FormatarGridTitulos(loc_oGrid)
                    loc_oGrid.Refresh()

                    THIS.pgf_4c_Paginas.Page1.Enabled = .F.
                    THIS.pgf_4c_Paginas.Page2.Enabled = .T.

                    *-- cmdTestaPos.btnBoleto.Enabled = !llNPr no legado (linha
                    *-- 1468): Boleto so comeca habilitado quando o filtro eh
                    *-- "Ja Processadas" (reimpressao); ProcessadoBrasil/
                    *-- Santander240 forcam .T. depois de gerar com sucesso.
                    THIS.pgf_4c_Paginas.Page2.cnt_4c_BotoesAcao.obj_4c_Comandos.Buttons(3).Enabled = ;
                        (loc_oPag.obj_4c_Processados.Value = 2)

                    THIS.AlternarPagina(2)
                    loc_lSucesso = .T.
                ENDIF
            ELSE
                MostrarErro("Erro ao processar os t" + CHR(237) + "tulos:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MostrarErro(loc_oErro.Message + CHR(13) + ;
                        "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                        "Procedure: " + loc_oErro.Procedure, "Erro ProcessarTitulos")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * BtnVoltarClick - cmdTestaPos.btnsair.Click (Pagina Dados) no legado:
    * limpa o RecordSource do grid, reabilita o filtro e volta para a Lista.
    *==========================================================================
    PROCEDURE BtnVoltarClick()
        LOCAL loc_oGrid
        loc_oGrid = THIS.pgf_4c_Paginas.Page2.grd_4c_Titulos
        loc_oGrid.RecordSource = ""
        loc_oGrid.Refresh()

        THIS.pgf_4c_Paginas.Page1.Enabled = .T.
        THIS.pgf_4c_Paginas.Page2.Enabled = .F.
        THIS.AlternarPagina(1)
    ENDPROC

    *==========================================================================
    * BtnMarcarTudoTitulosClick/BtnDesmarcarTudoTitulosClick - Commandgroup2.
    * btnmarca/btndesmarca.Click (Pagina Dados) no legado - marca/desmarca
    * TODOS os titulos, sem excecao pelo EndErro (igual ao legado - o
    * "Marcar Tudo" bypassa o guard do checkbox individual).
    *==========================================================================
    PROCEDURE BtnMarcarTudoTitulosClick()
        IF USED("cursor_4c_Titulos")
            SELECT cursor_4c_Titulos
            REPLACE ALL Marca WITH .T.
            LOCATE
            GO TOP
        ENDIF
        THIS.pgf_4c_Paginas.Page2.grd_4c_Titulos.Refresh()
    ENDPROC

    PROCEDURE BtnDesmarcarTudoTitulosClick()
        IF USED("cursor_4c_Titulos")
            SELECT cursor_4c_Titulos
            REPLACE ALL Marca WITH .F.
            LOCATE
            GO TOP
        ENDIF
        THIS.pgf_4c_Paginas.Page2.grd_4c_Titulos.Refresh()
    ENDPROC

    *==========================================================================
    * ChkTituloMarcaClick - Column1.Check1.When no legado (Return
    * crFiltro.EndErro = 0): titulo com endereco muito longo nao pode ser
    * selecionado. O nativo do CheckBox ja alterna Marca no clique; aqui so
    * revertemos quando a linha estiver marcada como EndErro=1.
    *==========================================================================
    PROCEDURE ChkTituloMarcaClick()
        IF USED("cursor_4c_Titulos") AND !EOF("cursor_4c_Titulos")
            IF cursor_4c_Titulos.EndErro = 1 AND cursor_4c_Titulos.Marca
                REPLACE cursor_4c_Titulos.Marca WITH .F.
                MsgAviso("Este t" + CHR(237) + "tulo tem endere" + CHR(231) + "o com mais de 40 caracteres e n" + CHR(227) + "o pode ser selecionado.", ;
                         "Aten" + CHR(231) + CHR(227) + "o")
                THIS.pgf_4c_Paginas.Page2.grd_4c_Titulos.Refresh()
            ENDIF
        ENDIF
    ENDPROC

    *==========================================================================
    * ExecutarReportForm (Pattern #117) - executa REPORT FORM com guard
    * IF FILE() + isolamento de locale (SET POINT/SEPARATOR) + REPORTBEHAVIOR
    * 80 durante o REPORT FORM. par_cModo: "PREVIEW" | "PRINTER_PROMPT".
    * par_cCursorDados: opcional - se informado e cursor estiver vazio/
    * inexistente, mostra MsgAviso e retorna .F. sem abrir preview vazio.
    *==========================================================================
    PROTECTED PROCEDURE ExecutarReportForm(par_cRelatorioBase, par_cModo, par_cCursorDados)
        LOCAL loc_cFRX, loc_cPointOrig, loc_cSepOrig, loc_nBehaviorOrig

        loc_cFRX = FULLPATH(gc_4c_CaminhoReports + par_cRelatorioBase + ".frx")

        IF NOT FILE(loc_cFRX)
            MsgErro("Arquivo de relat" + CHR(243) + "rio n" + CHR(227) + "o encontrado:" + CHR(13) + ;
                loc_cFRX + CHR(13) + CHR(13) + ;
                "O layout deste relat" + CHR(243) + "rio n" + CHR(227) + "o veio no acervo do sistema legado.", "Erro")
            RETURN .F.
        ENDIF

        IF VARTYPE(par_cCursorDados) == "C" AND !EMPTY(par_cCursorDados)
            IF !USED(par_cCursorDados) OR RECCOUNT(par_cCursorDados) = 0
                MsgAviso("Nenhum registro encontrado com os filtros informados.", ;
                    "Aten" + CHR(231) + CHR(227) + "o")
                RETURN .F.
            ENDIF
        ENDIF

        loc_cPointOrig    = SET("POINT")
        loc_cSepOrig      = SET("SEPARATOR")
        loc_nBehaviorOrig = SET("REPORTBEHAVIOR")
        SET POINT TO "."
        SET SEPARATOR TO ","
        SET REPORTBEHAVIOR 80

        DO CASE
            CASE par_cModo == "PREVIEW"
                REPORT FORM (loc_cFRX) PREVIEW NOCONSOLE
            CASE par_cModo == "PRINTER_PROMPT"
                REPORT FORM (loc_cFRX) TO PRINTER PROMPT NOCONSOLE
        ENDCASE

        SET POINT TO (loc_cPointOrig)
        SET SEPARATOR TO (loc_cSepOrig)
        SET REPORTBEHAVIOR (loc_nBehaviorOrig)

        RETURN .T.
    ENDPROC

    *==========================================================================
    * BtnGerarCnabClick - Commandgroup1.btncnab.Click no legado ("thisform.
    * geracnab([A])"). Gera o arquivo de remessa bancaria com os titulos
    * marcados. Quando o banco eh Brasil (001), o BO ja dispara a impressao
    * automatica do boleto (regra fiel ao legado - o BO chama sua propria
    * rotina ImprimirBoleto dentro de GerarCnabBrasil); aqui so falta exibir
    * o preview se o BO deixou um cursor pronto.
    *==========================================================================
    PROCEDURE BtnGerarCnabClick()
        LOCAL loc_oPag, loc_lSucesso

        loc_oPag = THIS.pgf_4c_Paginas.Page2

        loc_lSucesso = THIS.this_oBusinessObject.GerarArquivoCnab( ;
            "cursor_4c_Titulos", ;
            ALLTRIM(THIS.pgf_4c_Paginas.Page1.txt_4c_CodEmpresa.Value), ;
            ALLTRIM(THIS.pgf_4c_Paginas.Page1.txt_4c_CodConta.Value), ;
            ALLTRIM(THIS.pgf_4c_Paginas.Page1.txt_4c_TituloBanco.Value))

        IF loc_lSucesso AND INLIST(THIS.this_oBusinessObject.this_cBancoConvenio, "001", "033", "353")
            loc_oPag.cnt_4c_BotoesAcao.obj_4c_Comandos.Buttons(3).Enabled = .T.
        ENDIF

        *-- GerarCnabBrasil (no BO) ja chamou sua propria rotina interna
        *-- ImprimirBoleto(.F.) - se deixou cursor pronto, exibe o preview
        *-- aqui (camada de UI).
        IF !EMPTY(THIS.this_oBusinessObject.this_cCursorBoleto)
            THIS.ExibirPreviewBoleto()
        ENDIF
    ENDPROC

    *==========================================================================
    * BtnRelatorioCnabClick - Commandgroup1.btnrelatorio.Click no legado
    * ("thisform.geracnab([V])"): preview do relatorio com os titulos
    * marcados (Report Form sigrecnb no legado -> SigReCnb no novo sistema).
    *==========================================================================
    PROCEDURE BtnRelatorioCnabClick()
        LOCAL loc_nMarcados

        IF USED("cursor_4c_Titulos")
            SELECT cursor_4c_Titulos
            COUNT FOR Marca TO loc_nMarcados
        ELSE
            loc_nMarcados = 0
        ENDIF

        IF loc_nMarcados = 0
            MsgAviso("Nenhum registro foi selecionado", "Aviso")
            RETURN
        ENDIF

        THIS.ExecutarReportForm("SigReCnb", "PREVIEW", "cursor_4c_Titulos")
    ENDPROC

    *==========================================================================
    * BtnBoletoClick - Commandgroup1.btnBoleto.Click no legado ("thisform.
    * geracnab([I])" + "thisform.impboleto(.T.)"): reimpressao do boleto dos
    * titulos marcados, reaproveitando o Nosso Numero da ultima geracao
    * gravada em SigPcOol (par_lReimpressao = .T.).
    *==========================================================================
    PROCEDURE BtnBoletoClick()
        LOCAL loc_lSucesso

        loc_lSucesso = THIS.this_oBusinessObject.ImprimirBoleto( ;
            "cursor_4c_Titulos", .T., ;
            ALLTRIM(THIS.pgf_4c_Paginas.Page1.txt_4c_CodEmpresa.Value), ;
            ALLTRIM(THIS.pgf_4c_Paginas.Page1.txt_4c_CodConta.Value))

        IF loc_lSucesso AND !EMPTY(THIS.this_oBusinessObject.this_cCursorBoleto)
            THIS.ExibirPreviewBoleto()
        ENDIF
    ENDPROC

    *==========================================================================
    * ExibirPreviewBoleto - escolhe o layout de boleto pelo banco do
    * convenio (BloquetoBB2/BloquetoSt/BloquetoBra no legado -> SigReBlqBB/
    * SigReBlqSt/SigReBlqBra no novo sistema) e limpa as imagens de barra
    * temporarias apos a impressao (igual ao legado).
    *==========================================================================
    PROTECTED PROCEDURE ExibirPreviewBoleto()
        LOCAL loc_cRelatorio, loc_cCursor

        loc_cCursor = THIS.this_oBusinessObject.this_cCursorBoleto

        DO CASE
            CASE THIS.this_oBusinessObject.this_cBancoConvenio == "001"
                loc_cRelatorio = "SigReBlqBB"
            CASE INLIST(THIS.this_oBusinessObject.this_cBancoConvenio, "033", "353")
                loc_cRelatorio = "SigReBlqSt"
            CASE THIS.this_oBusinessObject.this_cBancoConvenio == "237"
                loc_cRelatorio = "SigReBlqBra"
            OTHERWISE
                loc_cRelatorio = ""
        ENDCASE

        IF !EMPTY(loc_cRelatorio)
            THIS.ExecutarReportForm(loc_cRelatorio, "PREVIEW", loc_cCursor)
        ENDIF

        THIS.this_oBusinessObject.LimparImagensBarras(loc_cCursor)

        IF USED(loc_cCursor)
            USE IN (loc_cCursor)
        ENDIF
        THIS.this_oBusinessObject.this_cCursorBoleto = ""
    ENDPROC

    *==========================================================================
    * ValidarCodEmpresa - KeyPress em txt_4c_CodEmpresa (get_cd_empresa no
    * legado). Enter/Tab/F4 -> SELECT exato em SigCdEmp.Cemps; hit preenche a
    * razao social, miss abre o picker (fAcessoEmpresa modo 'C' nao portada -
    * regra CLAUDE.md sobre fAcessoEmpresa, substituicao canonica FormBuscaAuxiliar
    * em SigCdEmp).
    *==========================================================================
    PROCEDURE ValidarCodEmpresa(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oPag, loc_cVal, loc_nResult

        IF par_nKeyCode = 115
            THIS.AbrirBuscaEmpresa()
            RETURN
        ENDIF

        IF par_nKeyCode != 13 AND par_nKeyCode != 9
            RETURN
        ENDIF

        loc_oPag = THIS.pgf_4c_Paginas.Page1
        loc_cVal = ALLTRIM(loc_oPag.txt_4c_CodEmpresa.Value)

        IF EMPTY(loc_cVal)
            loc_oPag.txt_4c_NomeEmpresa.Value = ""
            loc_oPag.txt_4c_NomeEmpresa.Refresh
            RETURN
        ENDIF

        TRY
            loc_nResult = SQLEXEC(gnConnHandle, ;
                "SELECT TOP 1 Cemps, Razas FROM SigCdEmp WHERE Cemps = " + EscaparSQL(loc_cVal), ;
                "cursor_4c_EmpresaVal")
            IF loc_nResult > 0 AND USED("cursor_4c_EmpresaVal") AND !EOF("cursor_4c_EmpresaVal")
                SELECT cursor_4c_EmpresaVal
                loc_oPag.txt_4c_CodEmpresa.Value  = ALLTRIM(cursor_4c_EmpresaVal.Cemps)
                loc_oPag.txt_4c_NomeEmpresa.Value = ALLTRIM(cursor_4c_EmpresaVal.Razas)
            ELSE
                THIS.AbrirBuscaEmpresa()
            ENDIF
            IF USED("cursor_4c_EmpresaVal")
                USE IN cursor_4c_EmpresaVal
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        loc_oPag.txt_4c_CodEmpresa.Refresh
        loc_oPag.txt_4c_NomeEmpresa.Refresh
    ENDPROC

    *==========================================================================
    * ValidarNomEmpresa - KeyPress em txt_4c_NomeEmpresa (get_ds_empresa no
    * legado). So age quando o codigo esta vazio (When: Empty(get_cd_empresa)).
    *==========================================================================
    PROCEDURE ValidarNomEmpresa(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oPag, loc_cVal, loc_nResult

        IF par_nKeyCode = 115
            THIS.AbrirBuscaEmpresa()
            RETURN
        ENDIF

        IF par_nKeyCode != 13 AND par_nKeyCode != 9
            RETURN
        ENDIF

        loc_oPag = THIS.pgf_4c_Paginas.Page1

        IF !EMPTY(ALLTRIM(loc_oPag.txt_4c_CodEmpresa.Value))
            RETURN
        ENDIF

        loc_cVal = ALLTRIM(loc_oPag.txt_4c_NomeEmpresa.Value)
        IF EMPTY(loc_cVal)
            loc_oPag.txt_4c_CodEmpresa.Value = ""
            loc_oPag.txt_4c_CodEmpresa.Refresh
            RETURN
        ENDIF

        TRY
            loc_nResult = SQLEXEC(gnConnHandle, ;
                "SELECT TOP 1 Cemps, Razas FROM SigCdEmp WHERE RTRIM(Razas) = " + EscaparSQL(loc_cVal), ;
                "cursor_4c_EmpresaVal")
            IF loc_nResult > 0 AND USED("cursor_4c_EmpresaVal") AND !EOF("cursor_4c_EmpresaVal")
                SELECT cursor_4c_EmpresaVal
                loc_oPag.txt_4c_CodEmpresa.Value  = ALLTRIM(cursor_4c_EmpresaVal.Cemps)
                loc_oPag.txt_4c_NomeEmpresa.Value = ALLTRIM(cursor_4c_EmpresaVal.Razas)
            ELSE
                THIS.AbrirBuscaEmpresa()
            ENDIF
            IF USED("cursor_4c_EmpresaVal")
                USE IN cursor_4c_EmpresaVal
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        loc_oPag.txt_4c_CodEmpresa.Refresh
        loc_oPag.txt_4c_NomeEmpresa.Refresh
    ENDPROC

    *==========================================================================
    * AbrirBuscaEmpresa - picker por Cemps/Razas em SigCdEmp (substitui
    * fAcessoEmpresa modo lookup - funcao NAO portada, ver CLAUDE.md).
    *==========================================================================
    PROCEDURE AbrirBuscaEmpresa()
        LOCAL loc_oPag, loc_oBusca, loc_cValor, loc_cSQL, loc_nResult, loc_cTitulo, loc_lProsseguir

        loc_oPag    = THIS.pgf_4c_Paginas.Page1
        loc_cValor  = ALLTRIM(loc_oPag.txt_4c_CodEmpresa.Value)
        IF EMPTY(loc_cValor)
            loc_cValor = ALLTRIM(loc_oPag.txt_4c_NomeEmpresa.Value)
        ENDIF
        loc_cTitulo = "Sele" + CHR(231) + CHR(227) + "o de Empresa"

        IF USED("cursor_4c_BuscaEmpresa")
            USE IN cursor_4c_BuscaEmpresa
        ENDIF

        loc_lProsseguir = .T.
        TRY
            IF EMPTY(loc_cValor)
                loc_cSQL = "SELECT Cemps, Razas FROM SigCdEmp ORDER BY Cemps"
            ELSE
                loc_cSQL = "SELECT Cemps, Razas FROM SigCdEmp " + ;
                           "WHERE Cemps LIKE " + EscaparSQL(loc_cValor + "%") + ;
                           " OR RTRIM(Razas) LIKE " + EscaparSQL(loc_cValor + "%") + ;
                           " ORDER BY Cemps"
            ENDIF
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaEmpresa")

            IF (loc_nResult < 1 OR !USED("cursor_4c_BuscaEmpresa") OR RECCOUNT("cursor_4c_BuscaEmpresa") = 0) ;
                    AND !EMPTY(loc_cValor)
                IF USED("cursor_4c_BuscaEmpresa")
                    USE IN cursor_4c_BuscaEmpresa
                ENDIF
                loc_nResult = SQLEXEC(gnConnHandle, ;
                    "SELECT Cemps, Razas FROM SigCdEmp ORDER BY Cemps", ;
                    "cursor_4c_BuscaEmpresa")
            ENDIF

            IF loc_nResult < 1 OR !USED("cursor_4c_BuscaEmpresa") OR RECCOUNT("cursor_4c_BuscaEmpresa") = 0
                MsgAviso("Nenhuma empresa encontrada.", "Empresa")
                loc_lProsseguir = .F.
            ENDIF

            IF loc_lProsseguir
                loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
                IF VARTYPE(loc_oBusca) = "O"
                    loc_oBusca.this_cCursorDestino = "cursor_4c_BuscaEmpresa"
                    loc_oBusca.this_cTitulo        = loc_cTitulo
                    loc_oBusca.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = loc_cTitulo
                    loc_oBusca.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = loc_cTitulo
                    loc_oBusca.mAddColuna("Cemps", "", "C" + CHR(243) + "digo")
                    loc_oBusca.mAddColuna("Razas", "", "Raz" + CHR(227) + "o Social")
                    loc_oBusca.Show()
                    IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaEmpresa")
                        SELECT cursor_4c_BuscaEmpresa
                        loc_oPag.txt_4c_CodEmpresa.Value  = ALLTRIM(cursor_4c_BuscaEmpresa.Cemps)
                        loc_oPag.txt_4c_NomeEmpresa.Value = ALLTRIM(cursor_4c_BuscaEmpresa.Razas)
                    ENDIF
                    loc_oBusca.Release()
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        IF USED("cursor_4c_BuscaEmpresa")
            USE IN cursor_4c_BuscaEmpresa
        ENDIF
        loc_oPag.txt_4c_CodEmpresa.Refresh
        loc_oPag.txt_4c_NomeEmpresa.Refresh
    ENDPROC

    *==========================================================================
    * ValidarDataFinal - KeyPress em txt_4c_DataFinal (Get_Dataf.Valid no
    * legado): data final nao pode ser menor que a inicial.
    *==========================================================================
    PROCEDURE ValidarDataFinal(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oPag

        IF par_nKeyCode != 13 AND par_nKeyCode != 9
            RETURN
        ENDIF

        loc_oPag = THIS.pgf_4c_Paginas.Page1

        IF !EMPTY(loc_oPag.txt_4c_DataInicial.Value) ;
                AND !EMPTY(loc_oPag.txt_4c_DataFinal.Value) ;
                AND loc_oPag.txt_4c_DataFinal.Value < loc_oPag.txt_4c_DataInicial.Value
            MsgAviso("Data Final Deve Ser Maior Que a Inicial!!!", "Aten" + CHR(231) + CHR(227) + "o")
            loc_oPag.txt_4c_DataFinal.SetFocus()
        ENDIF
    ENDPROC

    *==========================================================================
    * ValidarCodConta - KeyPress em txt_4c_CodConta (get_cd_car_conta no
    * legado). Enter/Tab/F4 -> SELECT exato em SigCdCli.IClis; hit preenche a
    * razao social, miss abre o picker (fAcessoContas NAO USAR para lookup UX -
    * regra CLAUDE.md, substituicao canonica SigCdCli.IClis/RClis).
    *==========================================================================
    PROCEDURE ValidarCodConta(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oPag, loc_cVal, loc_nResult

        IF par_nKeyCode = 115
            THIS.AbrirBuscaConta()
            RETURN
        ENDIF

        IF par_nKeyCode != 13 AND par_nKeyCode != 9
            RETURN
        ENDIF

        loc_oPag = THIS.pgf_4c_Paginas.Page1
        loc_cVal = ALLTRIM(loc_oPag.txt_4c_CodConta.Value)

        IF EMPTY(loc_cVal)
            loc_oPag.txt_4c_NomeConta.Value = ""
            loc_oPag.txt_4c_NomeConta.Refresh
            RETURN
        ENDIF

        TRY
            loc_nResult = SQLEXEC(gnConnHandle, ;
                "SELECT TOP 1 IClis, RClis FROM SigCdCli WHERE IClis = " + EscaparSQL(loc_cVal), ;
                "cursor_4c_ContaVal")
            IF loc_nResult > 0 AND USED("cursor_4c_ContaVal") AND !EOF("cursor_4c_ContaVal")
                SELECT cursor_4c_ContaVal
                loc_oPag.txt_4c_CodConta.Value  = ALLTRIM(cursor_4c_ContaVal.IClis)
                loc_oPag.txt_4c_NomeConta.Value = ALLTRIM(cursor_4c_ContaVal.RClis)
            ELSE
                MsgAviso("Conta Inv" + CHR(225) + "lida, Acesso Negado.", "Aviso")
                loc_oPag.txt_4c_CodConta.Value  = ""
                loc_oPag.txt_4c_NomeConta.Value = ""
            ENDIF
            IF USED("cursor_4c_ContaVal")
                USE IN cursor_4c_ContaVal
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        loc_oPag.txt_4c_CodConta.Refresh
        loc_oPag.txt_4c_NomeConta.Refresh
    ENDPROC

    *==========================================================================
    * ValidarNomConta - KeyPress em txt_4c_NomeConta (get_ds_car_conta no
    * legado). So age quando o codigo esta vazio (When: IsEmpty(get_cd_car_conta)).
    *==========================================================================
    PROCEDURE ValidarNomConta(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oPag, loc_cVal, loc_nResult

        IF par_nKeyCode = 115
            THIS.AbrirBuscaConta()
            RETURN
        ENDIF

        IF par_nKeyCode != 13 AND par_nKeyCode != 9
            RETURN
        ENDIF

        loc_oPag = THIS.pgf_4c_Paginas.Page1

        IF !EMPTY(ALLTRIM(loc_oPag.txt_4c_CodConta.Value))
            RETURN
        ENDIF

        loc_cVal = ALLTRIM(loc_oPag.txt_4c_NomeConta.Value)
        IF EMPTY(loc_cVal)
            loc_oPag.txt_4c_CodConta.Value = ""
            loc_oPag.txt_4c_CodConta.Refresh
            RETURN
        ENDIF

        TRY
            loc_nResult = SQLEXEC(gnConnHandle, ;
                "SELECT TOP 1 IClis, RClis FROM SigCdCli WHERE RTRIM(RClis) = " + EscaparSQL(loc_cVal), ;
                "cursor_4c_ContaVal")
            IF loc_nResult > 0 AND USED("cursor_4c_ContaVal") AND !EOF("cursor_4c_ContaVal")
                SELECT cursor_4c_ContaVal
                loc_oPag.txt_4c_CodConta.Value  = ALLTRIM(cursor_4c_ContaVal.IClis)
                loc_oPag.txt_4c_NomeConta.Value = ALLTRIM(cursor_4c_ContaVal.RClis)
            ELSE
                THIS.AbrirBuscaConta()
            ENDIF
            IF USED("cursor_4c_ContaVal")
                USE IN cursor_4c_ContaVal
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        loc_oPag.txt_4c_CodConta.Refresh
        loc_oPag.txt_4c_NomeConta.Refresh
    ENDPROC

    *==========================================================================
    * AbrirBuscaConta - picker por IClis/RClis em SigCdCli (conta/carteira do
    * banco - substitui fAcessoContas, que NAO deve ser usada para lookup UX).
    *==========================================================================
    PROCEDURE AbrirBuscaConta()
        LOCAL loc_oPag, loc_oBusca, loc_cValor, loc_cSQL, loc_nResult, loc_cTitulo, loc_lProsseguir

        loc_oPag    = THIS.pgf_4c_Paginas.Page1
        loc_cValor  = ALLTRIM(loc_oPag.txt_4c_CodConta.Value)
        IF EMPTY(loc_cValor)
            loc_cValor = ALLTRIM(loc_oPag.txt_4c_NomeConta.Value)
        ENDIF
        loc_cTitulo = "Sele" + CHR(231) + CHR(227) + "o de Conta"

        IF USED("cursor_4c_BuscaConta")
            USE IN cursor_4c_BuscaConta
        ENDIF

        loc_lProsseguir = .T.
        TRY
            IF EMPTY(loc_cValor)
                loc_cSQL = "SELECT IClis, RClis FROM SigCdCli ORDER BY IClis"
            ELSE
                loc_cSQL = "SELECT IClis, RClis FROM SigCdCli " + ;
                           "WHERE IClis LIKE " + EscaparSQL(loc_cValor + "%") + ;
                           " OR RTRIM(RClis) LIKE " + EscaparSQL(loc_cValor + "%") + ;
                           " ORDER BY IClis"
            ENDIF
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaConta")

            IF (loc_nResult < 1 OR !USED("cursor_4c_BuscaConta") OR RECCOUNT("cursor_4c_BuscaConta") = 0) ;
                    AND !EMPTY(loc_cValor)
                IF USED("cursor_4c_BuscaConta")
                    USE IN cursor_4c_BuscaConta
                ENDIF
                loc_nResult = SQLEXEC(gnConnHandle, ;
                    "SELECT IClis, RClis FROM SigCdCli ORDER BY IClis", ;
                    "cursor_4c_BuscaConta")
            ENDIF

            IF loc_nResult < 1 OR !USED("cursor_4c_BuscaConta") OR RECCOUNT("cursor_4c_BuscaConta") = 0
                MsgAviso("Nenhuma conta encontrada.", "Conta")
                loc_lProsseguir = .F.
            ENDIF

            IF loc_lProsseguir
                loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
                IF VARTYPE(loc_oBusca) = "O"
                    loc_oBusca.this_cCursorDestino = "cursor_4c_BuscaConta"
                    loc_oBusca.this_cTitulo        = loc_cTitulo
                    loc_oBusca.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = loc_cTitulo
                    loc_oBusca.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = loc_cTitulo
                    loc_oBusca.mAddColuna("IClis", "", "C" + CHR(243) + "digo")
                    loc_oBusca.mAddColuna("RClis", "", "Nome")
                    loc_oBusca.Show()
                    IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaConta")
                        SELECT cursor_4c_BuscaConta
                        loc_oPag.txt_4c_CodConta.Value  = ALLTRIM(cursor_4c_BuscaConta.IClis)
                        loc_oPag.txt_4c_NomeConta.Value = ALLTRIM(cursor_4c_BuscaConta.RClis)
                    ENDIF
                    loc_oBusca.Release()
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        IF USED("cursor_4c_BuscaConta")
            USE IN cursor_4c_BuscaConta
        ENDIF
        loc_oPag.txt_4c_CodConta.Refresh
        loc_oPag.txt_4c_NomeConta.Refresh
    ENDPROC

    *==========================================================================
    * ValidarTituloBanco - KeyPress em txt_4c_TituloBanco (Get_titban no
    * legado). Enter/Tab/F4 -> SEEK exato em SigOpFp.Fpags (mesmo filtro do
    * legado: Situas in ('R','A') And Infos = 'K'); miss abre o picker
    * (fwBuscaSel legado -> FormBuscaAuxiliar canonico, tabela single-column
    * como SigCdOpe - so existe o campo Fpags, sem descricao textual).
    *==========================================================================
    PROCEDURE ValidarTituloBanco(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oPag, loc_cVal, loc_nResult

        IF par_nKeyCode = 115
            THIS.AbrirBuscaTituloBanco()
            RETURN
        ENDIF

        IF par_nKeyCode != 13 AND par_nKeyCode != 9
            RETURN
        ENDIF

        loc_oPag = THIS.pgf_4c_Paginas.Page1
        loc_cVal = ALLTRIM(loc_oPag.txt_4c_TituloBanco.Value)

        IF EMPTY(loc_cVal)
            RETURN
        ENDIF

        TRY
            loc_nResult = SQLEXEC(gnConnHandle, ;
                "SELECT TOP 1 Fpags FROM SigOpFp WHERE Fpags = " + EscaparSQL(loc_cVal) + ;
                " AND Situas IN ('R','A') AND Infos = 'K'", ;
                "cursor_4c_TituloBancoVal")
            IF loc_nResult > 0 AND USED("cursor_4c_TituloBancoVal") AND !EOF("cursor_4c_TituloBancoVal")
                SELECT cursor_4c_TituloBancoVal
                loc_oPag.txt_4c_TituloBanco.Value = ALLTRIM(cursor_4c_TituloBancoVal.Fpags)
            ELSE
                THIS.AbrirBuscaTituloBanco()
            ENDIF
            IF USED("cursor_4c_TituloBancoVal")
                USE IN cursor_4c_TituloBancoVal
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        loc_oPag.txt_4c_TituloBanco.Refresh
    ENDPROC

    *==========================================================================
    * AbrirBuscaTituloBanco - picker por Fpags em SigOpFp (Formas de
    * Pagamento), mesmo filtro do legado (Situas in ('R','A') And Infos='K').
    * Single-column, igual SigCdOpe (regra CLAUDE.md) - o legado so exibe o
    * codigo (AddColuna('FPags', ...)), sem coluna de descricao.
    *==========================================================================
    PROCEDURE AbrirBuscaTituloBanco()
        LOCAL loc_oPag, loc_oBusca, loc_cValor, loc_cSQL, loc_nResult, loc_cTitulo, loc_lProsseguir

        loc_oPag    = THIS.pgf_4c_Paginas.Page1
        loc_cValor  = ALLTRIM(loc_oPag.txt_4c_TituloBanco.Value)
        loc_cTitulo = "Formas de Pagamento"

        IF USED("cursor_4c_BuscaTituloBanco")
            USE IN cursor_4c_BuscaTituloBanco
        ENDIF

        loc_lProsseguir = .T.
        TRY
            IF EMPTY(loc_cValor)
                loc_cSQL = "SELECT Fpags FROM SigOpFp WHERE Situas IN ('R','A') AND Infos = 'K' ORDER BY Fpags"
            ELSE
                loc_cSQL = "SELECT Fpags FROM SigOpFp " + ;
                           "WHERE Situas IN ('R','A') AND Infos = 'K' " + ;
                           "AND Fpags LIKE " + EscaparSQL(loc_cValor + "%") + ;
                           " ORDER BY Fpags"
            ENDIF
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaTituloBanco")

            IF (loc_nResult < 1 OR !USED("cursor_4c_BuscaTituloBanco") OR RECCOUNT("cursor_4c_BuscaTituloBanco") = 0) ;
                    AND !EMPTY(loc_cValor)
                IF USED("cursor_4c_BuscaTituloBanco")
                    USE IN cursor_4c_BuscaTituloBanco
                ENDIF
                loc_nResult = SQLEXEC(gnConnHandle, ;
                    "SELECT Fpags FROM SigOpFp WHERE Situas IN ('R','A') AND Infos = 'K' ORDER BY Fpags", ;
                    "cursor_4c_BuscaTituloBanco")
            ENDIF

            IF loc_nResult < 1 OR !USED("cursor_4c_BuscaTituloBanco") OR RECCOUNT("cursor_4c_BuscaTituloBanco") = 0
                MsgAviso("Nenhuma forma de pagamento encontrada.", "Formas de Pagamento")
                loc_lProsseguir = .F.
            ENDIF

            IF loc_lProsseguir
                loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
                IF VARTYPE(loc_oBusca) = "O"
                    loc_oBusca.this_cCursorDestino = "cursor_4c_BuscaTituloBanco"
                    loc_oBusca.this_cTitulo        = loc_cTitulo
                    loc_oBusca.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = loc_cTitulo
                    loc_oBusca.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = loc_cTitulo
                    loc_oBusca.mAddColuna("Fpags", "", "C" + CHR(243) + "digo")
                    loc_oBusca.Show()
                    IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaTituloBanco")
                        SELECT cursor_4c_BuscaTituloBanco
                        loc_oPag.txt_4c_TituloBanco.Value = ALLTRIM(cursor_4c_BuscaTituloBanco.Fpags)
                    ENDIF
                    loc_oBusca.Release()
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        IF USED("cursor_4c_BuscaTituloBanco")
            USE IN cursor_4c_BuscaTituloBanco
        ENDIF
        loc_oPag.txt_4c_TituloBanco.Refresh
    ENDPROC

    *==========================================================================
    * AlternarPagina - Alterna entre a pagina de Filtro (1) e a de Dados (2).
    * Usado pelo fluxo Processar->Dados e pelo retorno Dados->Filtro (regra de
    * negocio de quando alternar fica para as Fases 7-8).
    *==========================================================================
    PROCEDURE AlternarPagina(par_nPagina)
        THIS.pgf_4c_Paginas.ActivePage = par_nPagina
    ENDPROC

    *==========================================================================
    * TornarControlesVisiveis - Torna visiveis os controles ja criados
    *==========================================================================
    PROTECTED PROCEDURE TornarControlesVisiveis()
        LOCAL loc_oP1, loc_oP2

        THIS.pgf_4c_Paginas.Visible = .T.

        loc_oP1 = THIS.pgf_4c_Paginas.Page1
        loc_oP1.cnt_4c_Cabecalho.Visible                       = .T.
        loc_oP1.cnt_4c_Cabecalho.lbl_4c_Sombra.Visible         = .T.
        loc_oP1.cnt_4c_Cabecalho.lbl_4c_Titulo.Visible         = .T.
        loc_oP1.cnt_4c_Botoes.Visible                          = .T.
        loc_oP1.cnt_4c_Botoes.cmd_4c_Processar.Visible         = .T.
        loc_oP1.cnt_4c_Botoes.cmd_4c_Encerrar.Visible          = .T.
        loc_oP1.cnt_4c_Marca.Visible                           = .T.
        loc_oP1.cnt_4c_Marca.cmd_4c_MarcarTudo.Visible         = .T.
        loc_oP1.cnt_4c_Marca.cmd_4c_DesmarcarTudo.Visible      = .T.
        loc_oP1.lbl_4c_Operacoes.Visible                       = .T.
        loc_oP1.obj_4c_Processados.Visible                     = .T.
        loc_oP1.lbl_4c_Empresa.Visible                         = .T.
        loc_oP1.txt_4c_CodEmpresa.Visible                      = .T.
        loc_oP1.txt_4c_NomeEmpresa.Visible                     = .T.
        loc_oP1.lbl_4c_Periodo.Visible                         = .T.
        loc_oP1.txt_4c_DataInicial.Visible                     = .T.
        loc_oP1.lbl_4c_Ate.Visible                             = .T.
        loc_oP1.txt_4c_DataFinal.Visible                       = .T.
        loc_oP1.obj_4c_Periodo.Visible                         = .T.
        loc_oP1.lbl_4c_Banco.Visible                           = .T.
        loc_oP1.txt_4c_CodConta.Visible                        = .T.
        loc_oP1.txt_4c_NomeConta.Visible                       = .T.
        loc_oP1.lbl_4c_TituloBanco.Visible                     = .T.
        loc_oP1.txt_4c_TituloBanco.Visible                     = .T.
        loc_oP1.lbl_4c_Operacao.Visible                        = .T.
        loc_oP1.grd_4c_Operacoes.Visible                       = .T.

        loc_oP2 = THIS.pgf_4c_Paginas.Page2
        loc_oP2.cnt_4c_Cabecalho.Visible                       = .T.
        loc_oP2.cnt_4c_Cabecalho.lbl_4c_Sombra.Visible         = .T.
        loc_oP2.cnt_4c_Cabecalho.lbl_4c_Titulo.Visible         = .T.
        loc_oP2.cnt_4c_BotoesAcao.Visible                      = .T.
        loc_oP2.cnt_4c_BotoesAcao.cmd_4c_Encerrar.Visible      = .T.
        loc_oP2.cnt_4c_BotoesAcao.obj_4c_Comandos.Visible      = .T.
        loc_oP2.lbl_4c_Label12.Visible                         = .T.
        loc_oP2.spn_4c_DiasProtesto.Visible                    = .T.
        loc_oP2.lbl_4c_Label1.Visible                          = .T.
        loc_oP2.lbl_4c_AvisoEndereco.Visible                   = .T.
        loc_oP2.txt_4c_AvisoCor.Visible                        = .T.
        loc_oP2.grd_4c_Titulos.Visible                         = .T.
        loc_oP2.cnt_4c_Marca.Visible                           = .T.
        loc_oP2.cnt_4c_Marca.cmd_4c_MarcarTudo.Visible         = .T.
        loc_oP2.cnt_4c_Marca.cmd_4c_DesmarcarTudo.Visible      = .T.
    ENDPROC

    *==========================================================================
    * DESTROY - delega para FormBase.Destroy (restaura menu apos fechamento)
    *==========================================================================
    PROCEDURE Destroy()
        RETURN DODEFAULT()
    ENDPROC

ENDDEFINE

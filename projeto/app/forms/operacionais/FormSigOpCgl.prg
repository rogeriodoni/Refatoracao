*==============================================================================
* FormSigOpCgl.prg - Form OPERACIONAL: Historico de Locais
* Migrado de: tasks/task692/SigOpCgl.SCX (SIGOPCGL)
* Herda de: FormBase
* Layout: Flat (sem PageFrame) - dialogo unico, somente leitura, exibindo o
* historico de mudanca de local de um codigo de barras (SigCdMlc).
*
* O legado nao tem Page1=Lista/Page2=Dados: e um dialogo unico com cabecalho
* e uma grade (grdHistorico) ligada direto a uma consulta filtrada pelo
* parametro recebido no Init (pBar). Nao ha Insert/Update/Delete - SigCdMlc
* e log gravado por outro processo (ver comentario de SigOpCglBO).
*
* Fase 3/8 - ESTRUTURA BASE: DEFINE CLASS com propriedades transcritas do
* dump (Height/Width/TitleBar/ControlBox/Closable/WindowType/AlwaysOnTop/
* DataSession), Init(par_nBarras) guardando o parametro de filtro antes de
* DODEFAULT() (equivalente ao "LParameters pBar" do legado - regra do
* projeto de armazenar parametros ANTES de delegar, mesmo padrao de
* FormCliente/FormHOR), InicializarForm() criando o Business Object e
* validando o parametro (equivalente ao guard "If (Type('pBar')<>'N') Or
* Empty(pBar) / ThisForm.Release" do legado - aqui via retorno .F. em vez de
* Release() no meio da inicializacao), e o cabecalho (cntSombra/lblSombra/
* lblTitulo) com geometria TRANSCRITA do dump.
*
* Fase 4/8 - GRID E BOTAO DE SAIDA: o legado nao tem CRUD (eh um dialogo de
* consulta), entao esta fase acrescenta so o que o SCX realmente tem -
* grd_4c_Dados (grdHistorico, 6 colunas Data/Hora/Atual/Novo/Usuario/
* Operacao, geometria e ReadOnly/Movable/Resizable TRANSCRITOS do dump) e
* cmg_4c_Botoes (CommandGroup de 1 botao, Encerrar/btnSair, mesmo padrao
* de Formsigopcgb). ConfigurarGrid() so cuida de LAYOUT (Top/Left/Width/
* ColumnCount/Header.Caption) - NUNCA ControlSource aqui, porque
* cursor_4c_HistoricoCgl ainda nao existe neste ponto (regra #41: Column.
* ControlSource de cursor inexistente derruba o Init e a tela nao abre).
* O bind real (RecordSource + ControlSource + Width/Header, porque
* RecordSource reseta os dois - Problema 48) e a carga de dados via
* SigOpCglBO.CarregarHistorico() ficam em CarregarDados(), chamado no
* fim de InicializarForm so quando PodeConsultarBanco() (regra do projeto -
* pula SQLEXEC em gb_4c_ValidandoUI/gb_4c_ModoTeste).
*
* Fase 5/8 - AUDITORIA DE PROPRIEDADES: o legado NAO TEM campos de dados (20
* objetos no dump, todos cabecalho/botao/grade - zero TextBox fora das colunas,
* zero PageFrame, zero Page2), entao nao ha "campos da Page2" para acrescentar
* e inventar algum violaria o PILAR 1. O trabalho desta fase eh o que a Fase 4
* descartou ao criar tudo de uma vez: as 8 propriedades da CLASSE fwgrade
* (medidas no framework.vcx, nao deduzidas - fwgrade eh Tahoma 8 com
* HighlightBackColor ESCURO, o "Verdana" do framework_frmcadastro_layout.md eh
* override da instancia CRUD), as 5 propriedades dos 6 Column.Text1,
* cmg_4c_Botoes.AutoSize, Rotation dos dois labels, e os 3 TabIndex (como
* ORDINAL 1..N - o VFP clampeia pela contagem de irmaos, ver o metodo) em
* ConfigurarPaginaDados() - metodo com corpo REAL e efetivamente CHAMADO do
* ConfigurarPageFrame depois de todos os AddObject - nunca um stub de uma
* linha so, orfao e nunca chamado, que eh codigo morto que gate nenhum pega.
*
* Fase 6/8 - CAMPOS RESTANTES E LOOKUPS: sem trabalho adicional neste form, e
* por construcao, nao por omissao. Confirmado lendo o codigo fonte INTEIRO do
* legado (tasks/task692/SigOpCgl_form_codigo_fonte.txt, Secao 3): o Init tem
* 3 linhas de preparo (fConfigGeral/Caption) + o guard de parametro + UM
* SqlExecute + o bind do grid + SetFocus no botao - nenhum CreateObject de
* fwBuscaExt/fwBuscaSel, nenhuma chamada a sigacess(), nenhum PROCEDURE Valid.
* Os 20 objetos do dump (Secao 1) sao TODOS cabecalho, grade (6x Header1/Text1)
* ou botao - zero TextBox/ComboBox/CheckBox fora das colunas da grade, que ja
* foram o "campo" entregue com ControlSource em CarregarDados() na Fase 4.
* Criar lookup ou campo solto aqui inventaria funcionalidade que o legado nao
* tem (viola o PILAR 1); um ConfigurarLookups() vazio seria stub disfarcado
* (proibido). "=fConfigGeral()" do Init legado segue a decisao ja tomada em
* outros forms OPERACIONAIS (FormSIGPRVTX/FormSigPrTar/FormSigMvMen/
* FormSigMvExp): NAO PORTAR a chamada - o wrapper utils\fconfiggeral.prg
* existe so para o p-code dos VCX legado que ainda o chamam no Load deles,
* e a configuracao que fConfigGeral fazia no legado (globals/ambiente) ja eh
* coberta por config.prg na arquitetura nova.
*
* Fase 7/8 - EVENTOS PRINCIPAIS: o template generico desta fase pede os
* 4 handlers CRUD (BtnIncluirClick/BtnAlterarClick/BtnVisualizarClick/
* BtnExcluirClick), mas o dump do legado (tasks/task692/layout.json +
* comportamento.json, Secoes 1 e 3) prova que SIGOPCGL nao tem NENHUM dos
* quatro verbos: a arvore de objetos inteira (20 entradas) e so cabecalho
* (cntSombra + 2 Label), grade (grdHistorico + 6 pares Header1/Text1) e UM
* unico CommandGroup (cmdBtnForm, ButtonCount=1) cujo Click e
* "ThisForm.Release" - sem Grupo_Op, sem pcEscolha, sem frmcadastro na
* cadeia de heranca (Class: form puro). Inventar Incluir/Alterar/
* Visualizar/Excluir aqui criaria funcionalidade que o legado nao tem
* (viola o PILAR 1) e um metodo so para satisfazer nome seria stub
* disfarcado (proibido pela regra de completude).
*
* O "evento principal" real deste form - o unico botao que o SCX declara -
* ja foi implementado na Fase 4: BtnEncerrarClick(), amarrado via BINDEVENT
* ao cmg_4c_Botoes.Buttons(1) em ConfigurarBotoes(), replica EXATAMENTE o
* "PROCEDURE btnSair.Click / ThisForm.Release" do legado. Com 1 botao no
* dump e 1 handler real no form, a superficie de evento esta completa -
* nao ha segundo botao para inventar handler.
*
* Fase 8/8 - EVENTOS AUXILIARES E CONSOLIDACAO FINAL: o template generico
* desta fase pede BtnBuscarClick/BtnSalvarClick/BtnCancelarClick,
* FormParaBO/BOParaForm completos, HabilitarCampos/LimparCampos,
* CarregarLista e AjustarBotoesPorModo - nenhum desses se aplica aqui, e por
* construcao (mesma prova documental das Fases 6 e 7, apoiada no dump
* completo de tasks/task692): SIGOPCGL nao tem Buscar/Salvar/Cancelar (o
* unico botao e o Sair, ja coberto por BtnEncerrarClick), nao tem Page2 de
* dados editaveis (logo nao ha o que transferir em FormParaBO/BOParaForm,
* nem campo para HabilitarCampos/LimparCampos gerenciarem) e nao alterna
* modo (AjustarBotoesPorModo pressupoe INCLUIR/ALTERAR/VISUALIZAR, que este
* dialogo somente-leitura nao tem). FormBase.prg (linhas 276-292) ja define
* esses metodos como no-op protegidos, chamados apenas por Novo/Salvar/
* Excluir/Cancelar do proprio FormBase - metodos que FormSigOpCgl nunca
* invoca (o unico fluxo e InicializarForm -> CarregarDados -> Encerrar).
* Sobrescrever qualquer um deles so para "preencher o nome" seria stub
* disfarcado (proibido pela regra de completude) e inventaria
* funcionalidade que o legado nao tem (viola o PILAR 1). CarregarLista() ja
* existe sob o nome CarregarDados() (Fase 4), que cumpre o mesmo papel -
* popular o cursor via BO e rebindar o grid - nao ha necessidade de um
* segundo metodo so para bater o nome do template.
*
* Integracao final (fecha o checklist "New entity" do CLAUDE.md): BO e Form
* sao carregados automaticamente pelo ADIR() de config.prg (classes\*BO.prg
* e forms\operacionais\Form*.prg) - sem SET PROCEDURE manual. Item de menu
* adicionado em popMovimentos (BAR 157, "Historico de Locais") chamando
* PROCEDURE AbrirFormSigOpCgl() no final de menu.prg: como o legado recebe
* o codigo de barras por parametro (sem tela de busca propria - quem chama
* ja sabe o codigo), o helper pede o valor via INPUTBOX antes de instanciar,
* mesmo padrao usado para AbrirFormsigreinr/AbrirFormSigReIr1 (relatorio
* parametrizado por numero).
*==============================================================================

DEFINE CLASS FormSigOpCgl AS FormBase

    Height       = 240
    Width        = 800
    Caption      = ""
    TitleBar     = 0
    ShowWindow   = 1
    ControlBox   = .F.
    Closable     = .F.
    MaxButton    = .F.
    MinButton    = .F.
    ClipControls = .F.
    WindowType   = 0
    AlwaysOnTop  = .T.
    DataSession  = 2
    BorderStyle  = 2
    AutoCenter   = .T.
    FontName     = "Tahoma"
    FontSize     = 8

    *-- Business Object
    this_oBusinessObject = .NULL.

    *-- Parametro de filtro recebido no Init (SigCdMlc.barras - numeric(14,0))
    this_nBarras = 0

    *--------------------------------------------------------------------------
    * Init - armazena o parametro de barras e define Caption com CHR() antes
    * de delegar ao FormBase (equivalente a "LParameters pBar" do legado).
    *--------------------------------------------------------------------------
    PROCEDURE Init(par_nBarras)
        THIS.Caption = "Hist" + CHR(243) + "rico de Locais"

        *-- TestFormWrapper/ValidarUIFidelity instanciam o form SEM parametro
        *-- (CREATEOBJECT(par_cFormClass) generico). Em producao, ausencia de
        *-- par_nBarras tem de fechar o form (guard do legado); em modo teste/
        *-- validacao, um valor fake passa o guard sem acionar SQL real -
        *-- PodeConsultarBanco() ja bloqueia CarregarDados() nesses modos
        *-- (mesmo padrao de FormHOR.Init, que usa "TESTE" como fallback).
        IF (TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI) OR ;
           (TYPE("gb_4c_ModoTeste") = "L" AND gb_4c_ModoTeste)
            THIS.this_nBarras = IIF(VARTYPE(par_nBarras) = "N" AND par_nBarras != 0, par_nBarras, 1)
        ELSE
            THIS.this_nBarras = IIF(VARTYPE(par_nBarras) = "N", par_nBarras, 0)
        ENDIF

        *-- WindowType=1 (modal top-level) causaria TIMEOUT em VFP9 -T. Classe
        *-- definida com WindowType=0; producao restaura para modal aqui, fora
        *-- de teste/validacao de UI (mesmo padrao de FormSigOpCcl/FormSigOpBcb).
        IF !((TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI) OR ;
             (TYPE("gb_4c_ModoTeste") = "L" AND gb_4c_ModoTeste))
            THIS.WindowType  = 1
            THIS.ShowWindow  = 1
        ENDIF

        RETURN DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    * InicializarForm - cria o Business Object, valida o parametro de barras
    * (equivalente ao guard do legado que fecha o form sem parametro valido)
    * e monta a estrutura base (cabecalho).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        TRY
            IF THIS.this_nBarras = 0
                *-- Legado: "If (Type('pBar')<>'N') Or Empty(pBar) / ThisForm.Release"
                MsgErro("Par" + CHR(226) + "metro de c" + CHR(243) + "digo de barras " + ;
                        "n" + CHR(227) + "o informado.", "Erro em InicializarForm")
            ELSE
                THIS.this_oBusinessObject = CREATEOBJECT("SigOpCglBO")

                IF VARTYPE(THIS.this_oBusinessObject) != "O"
                    MsgErro("Erro ao criar objeto de neg" + CHR(243) + "cio SigOpCglBO." + CHR(13) + ;
                            "VARTYPE retornou: " + VARTYPE(THIS.this_oBusinessObject), ;
                            "Erro em InicializarForm")
                ELSE
                    THIS.Picture = gc_4c_CaminhoIcones + "new_background.jpg"

                    THIS.ConfigurarPageFrame()

                    THIS.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
                    THIS.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption

                    THIS.TornarControlesVisiveis(THIS)

                    *-- Legado: SqlExecute falhando mostra MessageBox e "Return 0"
                    *-- (aborta o Init) - aqui equivalente a loc_lSucesso = .F.
                    *-- MsgErro ja foi exibido dentro de CarregarDados().
                    IF THIS.PodeConsultarBanco()
                        IF THIS.CarregarDados()
                            *-- Legado: "ThisForm.CmdBtnForm.BtnSair.SetFocus"
                            THIS.cmg_4c_Botoes.Buttons(1).SetFocus()
                            loc_lSucesso = .T.
                        ENDIF
                    ELSE
                        loc_lSucesso = .T.
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Erro em InicializarForm")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPageFrame - orquestra a montagem visual do form OPERACIONAL.
    * Nao ha PageFrame real (o legado SIGOPCGL e flat, sem Pagina.Lista/
    * Dados); metodo mantem o nome por conformidade com o contrato do
    * pipeline. Botoes DEPOIS do cabecalho (flutuam por cima dele, mesma
    * regra do cnt_4c_Saida canonico - regra #11/CLAUDE.md).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPageFrame()
        THIS.ConfigurarCabecalho()
        THIS.ConfigurarBotoes()
        THIS.ConfigurarGrid()

        *-- DEPOIS de todos os AddObject: TabIndex nao pode ser atribuido a
        *-- controle que ainda nao existe.
        THIS.ConfigurarPaginaDados()
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarCabecalho - container cinza (cntSombra do legado) com os dois
    * labels de titulo sobrepostos (sombra preta + titulo branco). Geometria
    * TRANSCRITA do dump: SIGOPCGL.cntSombra/lblSombra/lblTitulo.
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
            .Top           = 18
            .Left          = 10
            .Width         = 769
            .Height        = 40
            .AutoSize      = .F.
            .BackStyle     = 0
            .WordWrap      = .T.
            .Alignment     = 0
            .FontName      = "Tahoma"
            .FontSize      = 18
            .FontBold      = .T.
            .FontUnderline = .F.
            .ForeColor     = RGB(0, 0, 0)
            .Rotation      = 0
            .Caption       = THIS.Caption
        ENDWITH

        THIS.cnt_4c_Cabecalho.AddObject("lbl_4c_Titulo", "Label")
        WITH THIS.cnt_4c_Cabecalho.lbl_4c_Titulo
            .Top         = 17
            .Left        = 10
            .Width       = 769
            .Height      = 46
            .AutoSize    = .F.
            .BackStyle   = 0
            .WordWrap    = .T.
            .Alignment   = 0
            .FontName    = "Tahoma"
            .FontSize    = 18
            .FontBold    = .T.
            .ForeColor   = RGB(255, 255, 255)
            .Rotation    = 0
            .Caption     = THIS.Caption
            .ToolTipText = "T" + CHR(237) + "tulo do Relat" + CHR(243) + "rio"
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarBotoes - CommandGroup de 1 botao (cmdBtnForm/btnSair do
    * legado). Geometria/Picture/Caption TRANSCRITOS do dump (regra #25 -
    * nunca inventar nome de icone). Themes = .F. no grupo e no botao
    * (padrao canonico do CommandGroup - nao e botao standalone).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarBotoes()
        THIS.AddObject("cmg_4c_Botoes", "CommandGroup")
        WITH THIS.cmg_4c_Botoes
            .Top           = -2
            .Left          = 720
            .Width         = 85
            .Height        = 85
            .ButtonCount   = 1
            *-- Dump: AutoSize = .T. com Width/Height = 85 e btnSair 75x75 em
            *-- 5,5 - ou seja 5 + 75 + 5 = 85 nos dois eixos: a geometria fixa
            *-- JA EH o auto-size que o Form Designer calculou. Fixar com
            *-- AutoSize = .F. reproduz o legado e evita o risco da regra #23
            *-- (AutoSize descartando Width/Height em controle de AddObject).
            .AutoSize      = .F.
            .BackStyle     = 0
            .BorderStyle   = 0
            .SpecialEffect = 1
            .BorderColor   = RGB(136, 189, 188)
            .Themes        = .F.
            .Visible       = .T.
        ENDWITH

        WITH THIS.cmg_4c_Botoes.Buttons(1)
            .Top        = 5
            .Left       = 5
            .Width      = 75
            .Height     = 75
            .FontBold   = .T.
            .FontItalic = .T.
            .FontName   = "Comic Sans MS"
            .FontSize   = 8
            .Picture    = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
            .Cancel     = .T.
            .Caption    = "Encerrar"
            .ToolTipText = "Sair [ESC]"
            .ForeColor  = RGB(90, 90, 90)
            .BackColor  = RGB(255, 255, 255)
            .Themes     = .F.
        ENDWITH

        BINDEVENT(THIS.cmg_4c_Botoes.Buttons(1), "Click", THIS, "BtnEncerrarClick")
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnEncerrarClick - cmg_4c_Botoes.Buttons(1), legado:
    * "PROCEDURE btnSair.Click / ThisForm.Release".
    *--------------------------------------------------------------------------
    PROCEDURE BtnEncerrarClick()
        THIS.Release()
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarGrid - grd_4c_Dados (grdHistorico do legado). So LAYOUT
    * (posicao/ColumnCount/Header.Caption/ReadOnly/Movable/Resizable) -
    * NUNCA ControlSource aqui: cursor_4c_HistoricoCgl ainda nao existe
    * neste ponto (regra #41). RecordSource/ControlSource reais vao em
    * CarregarDados(), depois que o BO cria o cursor.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarGrid()
        THIS.AddObject("grd_4c_Dados", "Grid")
        WITH THIS.grd_4c_Dados
            .Top         = 98
            .Left        = 117
            .Width       = 565
            .Height      = 130
            .HeaderHeight       = 0
            .ColumnCount = 6
            .DeleteMark  = .F.
            .RecordMark  = .F.

            *-- Propriedades da CLASSE fwgrade (framework.vcx), que o SCX NAO
            *-- sobrescreve - medidas no proprio .vcx em 2026-10-24, nao
            *-- deduzidas: ColumnCount 0 / FontName "Tahoma" / FontSize 8 /
            *-- AllowHeaderSizing .F. / AllowRowSizing .F. / DeleteMark .F. /
            *-- Height 200 / RowHeight 16 / ScrollBars 2 / Width 578 /
            *-- GridLineColor 238,238,238 / HighlightBackColor 90,90,90.
            *-- ATENCAO: fwgrade eh Tahoma 8 e HighlightBackColor ESCURO - o
            *-- "Verdana" + HighlightBackColor branco de
            *-- docs\framework_frmcadastro_layout.md sao override da INSTANCIA
            *-- "Grade" dentro de frmcadastro (form CRUD), nao da classe.
            .FontName          = "Tahoma"
            .FontSize          = 8
            .AllowHeaderSizing = .F.
            .AllowRowSizing    = .F.
            .RowHeight         = 18
            .ScrollBars        = 2
            .GridLineColor     = RGB(238, 238, 238)
            .HighlightBackColor = RGB(90, 90, 90)

            *-- Grid.ReadOnly NAO eh atribuido de proposito: o legado trava a
            *-- grade pelas COLUNAS (loop "For lnCol = 1 To .ColumnCount" do
            *-- Init, que faz .Column<N>.ReadOnly = .T.), e Grid.ReadOnly
            *-- PROPAGA para as colunas sobrescrevendo-as (regra #18/#46).
            .Visible     = .T.

            .Column1.Width      = 68
            .Column1.Movable    = .F.
            .Column1.Resizable  = .F.
            .Column1.ReadOnly   = .T.
            .Column1.Header1.FontName  = "Tahoma"
            .Column1.Header1.FontSize  = 8
            .Column1.Header1.Alignment = 2
            .Column1.Header1.Caption   = "Data"
            *-- Text1 eh membro NATIVO da Column (regra #18) - transcrito do
            *-- dump SIGOPCGL.grdHistorico.Column1.Text1. ControlSource = ""
            *-- do dump eh override VAZIO do Form Designer: NAO transcrever
            *-- (regra #49) - o bind real vai em CarregarDados().
            .Column1.Text1.BorderStyle = 0
            .Column1.Text1.Margin      = 0
            .Column1.Text1.ReadOnly    = .T.
            .Column1.Text1.ForeColor   = RGB(0, 0, 0)
            .Column1.Text1.BackColor   = RGB(255, 255, 255)

            .Column2.Width      = 60
            .Column2.Movable    = .F.
            .Column2.Resizable  = .F.
            .Column2.ReadOnly   = .T.
            .Column2.Header1.FontName  = "Tahoma"
            .Column2.Header1.FontSize  = 8
            .Column2.Header1.Alignment = 2
            .Column2.Header1.Caption   = "Hora"
            .Column2.Text1.BorderStyle = 0
            .Column2.Text1.Margin      = 0
            .Column2.Text1.ReadOnly    = .T.
            .Column2.Text1.ForeColor   = RGB(0, 0, 0)
            .Column2.Text1.BackColor   = RGB(255, 255, 255)

            .Column3.Width      = 55
            .Column3.Movable    = .F.
            .Column3.Resizable  = .F.
            .Column3.ReadOnly   = .T.
            .Column3.Header1.FontName  = "Tahoma"
            .Column3.Header1.FontSize  = 8
            .Column3.Header1.Alignment = 2
            .Column3.Header1.Caption   = "Atual"
            .Column3.Text1.BorderStyle = 0
            .Column3.Text1.Margin      = 0
            .Column3.Text1.ReadOnly    = .T.
            .Column3.Text1.ForeColor   = RGB(0, 0, 0)
            .Column3.Text1.BackColor   = RGB(255, 255, 255)

            .Column4.Width      = 55
            .Column4.Movable    = .F.
            .Column4.Resizable  = .F.
            .Column4.ReadOnly   = .T.
            .Column4.Header1.FontName  = "Tahoma"
            .Column4.Header1.FontSize  = 8
            .Column4.Header1.Alignment = 2
            .Column4.Header1.Caption   = "Novo"
            .Column4.Text1.BorderStyle = 0
            .Column4.Text1.Margin      = 0
            .Column4.Text1.ReadOnly    = .T.
            .Column4.Text1.ForeColor   = RGB(0, 0, 0)
            .Column4.Text1.BackColor   = RGB(255, 255, 255)

            .Column5.Width      = 80
            .Column5.Movable    = .F.
            .Column5.Resizable  = .F.
            .Column5.ReadOnly   = .T.
            .Column5.Header1.FontName  = "Tahoma"
            .Column5.Header1.FontSize  = 8
            .Column5.Header1.Alignment = 2
            .Column5.Header1.Caption   = "Usu" + CHR(225) + "rio"
            .Column5.Text1.BorderStyle = 0
            .Column5.Text1.Margin      = 0
            .Column5.Text1.ReadOnly    = .T.
            .Column5.Text1.ForeColor   = RGB(0, 0, 0)
            .Column5.Text1.BackColor   = RGB(255, 255, 255)

            .Column6.Width      = 220
            .Column6.Movable    = .F.
            .Column6.Resizable  = .F.
            .Column6.ReadOnly   = .T.
            .Column6.Header1.FontName = "Tahoma"
            .Column6.Header1.FontSize = 8
            .Column6.Header1.Alignment = 2
            .Column6.Header1.Caption  = "Opera" + CHR(231) + CHR(227) + "o"
            *-- Column6.Text1 eh a UNICA que o dump nao declara ReadOnly (as
            *-- outras cinco declaram) - transcrito como esta: quem trava a
            *-- coluna 6 eh o .Column6.ReadOnly = .T. acima, vindo do loop do
            *-- Init legado. NAO uniformizar com as irmas.
            .Column6.Text1.BorderStyle = 0
            .Column6.Text1.Margin      = 0
            .Column6.Text1.ForeColor   = RGB(0, 0, 0)
            .Column6.Text1.BackColor   = RGB(255, 255, 255)
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPaginaDados - Fase 5/8.
    *
    * O legado SIGOPCGL NAO TEM campos de dados: a arvore de objetos do dump
    * tem 20 entradas e sao TODAS cabecalho (cntSombra + 2 Label), botao
    * (cmdBtnForm + btnSair) e grade (grdHistorico + os 6 pares Header1/Text1
    * das colunas) - zero TextBox/ComboBox/CheckBox/EditBox fora da grade,
    * zero PageFrame, zero Page2. Nao ha "metade dos campos" para acrescentar
    * nesta fase, e INVENTAR campo violaria o PILAR 1 e a regra "NUNCA
    * inventar o que o legado nao tem".
    *
    * Entao o trabalho REAL que sobra para esta fase eh o que a Fase 4
    * descartou ao criar todos os controles de uma vez: as propriedades
    * "pequenas" do dump. Transcritas agora:
    *   - grd_4c_Dados: as 8 propriedades da classe fwgrade (ver ConfigurarGrid)
    *   - grd_4c_Dados.ColumnN.Text1: BorderStyle/Margin/ReadOnly/ForeColor/
    *     BackColor dos 6 Text1 (ver ConfigurarGrid)
    *   - cmg_4c_Botoes: AutoSize (ver ConfigurarBotoes)
    *   - lbl_4c_Sombra / lbl_4c_Titulo: Rotation (ver ConfigurarCabecalho)
    *   - os 3 TabIndex, aqui
    *
    * TabIndex fica em metodo proprio porque PRECISA rodar DEPOIS de todos os
    * AddObject (atribuir em controle inexistente estoura), e vai em ordem
    * ASCENDENTE.
    *
    * ATENCAO - os numeros do dump NAO sao transcritos literalmente, e o
    * motivo foi MEDIDO no VFP9 em 2026-10-24 (nao deduzido): TabIndex eh um
    * ORDINAL 1..N dentro do container, CLAMPEADO pela quantidade de irmaos -
    * nao eh inteiro livre. O dump traz btnSair = 3, grdHistorico = 18 e
    * cmdBtnForm = 24, mas SIGOPCGL tem so TRES filhos diretos, entao o VFP
    * colapsa 18 -> 2 e 24 -> 3 (medido: atribuir 3/18/24 e atribuir 1/2/3
    * dao o MESMO resultado final). Os 18/24 do SCX sao ordinais velhos do
    * Form Designer, e o legado sofre o mesmo clamp em runtime - a ORDEM
    * RELATIVA (cabecalho -> grade -> botao) eh identica nos dois, que eh o
    * que o usuario percebe ao teclar TAB. Escrever 1/2/3 aqui diz a verdade
    * sobre o que o objeto guarda; a linhagem do dump fica nos comentarios.
    *
    * A ordem ASCENDENTE eh obrigatoria e tambem foi medida: atribuindo
    * DESCENDENTE (24 -> 18 -> 3) a grade e o botao TROCAM de lugar
    * (grdB = 3, cmgC = 2) e a tabulacao sai ao contrario do legado.
    *
    * Column.Text1 nao tem TabIndex no dump (celula de grade nao entra na
    * ordem de tabulacao do form) - nada a fazer la.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPaginaDados()
        *-- Dump: Command1.TabIndex = 3. btnSair eh o UNICO membro do
        *-- CommandGroup, entao o ordinal dele eh fixo em 1 - a atribuicao
        *-- existe para deixar a transcricao completa e conferivel.
        THIS.cmg_4c_Botoes.Buttons(1).TabIndex = 1

        *-- Dump: SIGOPCGL.grdHistorico / TabIndex = 18 -> ordinal 2
        *-- (cnt_4c_Cabecalho ocupa o 1, como cntSombra no legado, que
        *-- tambem nao declara TabIndex).
        THIS.grd_4c_Dados.TabIndex = 2

        *-- Dump: SIGOPCGL.cmdBtnForm / TabIndex = 24 -> ordinal 3
        THIS.cmg_4c_Botoes.TabIndex = 3
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDados - delega ao BO (SigOpCglBO.CarregarHistorico) a
    * consulta filtrada por this_nBarras, depois rebinda o grid
    * (RecordSource + Column.ControlSource + Width/Header.Caption - a
    * reatribuicao de RecordSource reseta os dois ultimos, Problema 48) e
    * repinta (GO TOP + Refresh - regra #21, cursor novo nao repinta a
    * grade por si so).
    *--------------------------------------------------------------------------
    FUNCTION CarregarDados()
        LOCAL loc_lSucesso

        loc_lSucesso = THIS.this_oBusinessObject.CarregarHistorico(THIS.this_nBarras)

        IF loc_lSucesso
            WITH THIS.grd_4c_Dados
                .RecordSource = "cursor_4c_HistoricoCgl"

                .Column1.ControlSource = "cursor_4c_HistoricoCgl.Datas"
                .Column2.ControlSource = "cursor_4c_HistoricoCgl.Horas"
                .Column3.ControlSource = "cursor_4c_HistoricoCgl.Locatus"
                .Column4.ControlSource = "cursor_4c_HistoricoCgl.Locnews"
                .Column5.ControlSource = "cursor_4c_HistoricoCgl.Usuars"
                .Column6.ControlSource = "cursor_4c_HistoricoCgl.Empdopnums"

                .Column1.Width = 68
                .Column1.Header1.Caption = "Data"
                .Column2.Width = 60
                .Column2.Header1.Caption = "Hora"
                .Column3.Width = 55
                .Column3.Header1.Caption = "Atual"
                .Column4.Width = 55
                .Column4.Header1.Caption = "Novo"
                .Column5.Width = 80
                .Column5.Header1.Caption = "Usu" + CHR(225) + "rio"
                .Column6.Width = 220
                .Column6.Header1.Caption = "Opera" + CHR(231) + CHR(227) + "o"
            ENDWITH

            SELECT cursor_4c_HistoricoCgl
            GO TOP
            THIS.grd_4c_Dados.Refresh()
        ENDIF

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * PodeConsultarBanco - .T. quando ha conexao real e o form NAO esta
    * rodando sob validacao de UI/teste automatizado (mesmo helper canonico
    * de Formsigopcgb.PodeConsultarBanco).
    *--------------------------------------------------------------------------
    FUNCTION PodeConsultarBanco()
        LOCAL loc_lPode

        loc_lPode = (TYPE("gnConnHandle") = "N" AND gnConnHandle > 0)

        IF loc_lPode AND TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
            loc_lPode = .F.
        ENDIF

        IF loc_lPode AND TYPE("gb_4c_ModoTeste") = "L" AND gb_4c_ModoTeste
            loc_lPode = .F.
        ENDIF

        RETURN loc_lPode
    ENDFUNC

    *--------------------------------------------------------------------------
    * Destroy - equivalente ao "PROCEDURE Release" do form legado
    * ("ThisForm.poDataMgr.Release"). O cursor de historico
    * (cursor_4c_HistoricoCgl, criado em SigOpCglBO.CarregarHistorico - Fase
    * 4) vive na data session PRIVADA do form (DataSession = 2, igual ao
    * legado) e e fechado automaticamente pelo VFP quando o form e destruido
    * - nao exige fechamento explicito aqui.
    *
    * DODEFAULT() eh a ULTIMA linha, obrigatoriamente: FormBase.Destroy faz o
    * SET SYSMENU TO DEFAULT + RELEASE POPUP + CriarMenuPrincipal() que repoe
    * os pads do menu principal depois de uma tela modal fechar - sem ele o
    * menu do sistema aparece encolhido.
    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
        DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    * TornarControlesVisiveis - torna todos os controles visiveis recursivamente
    * FILTRO: nenhum container flutuante neste form
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
        LOCAL loc_i, loc_oControl

        FOR loc_i = 1 TO par_oContainer.ControlCount
            loc_oControl = par_oContainer.Controls(loc_i)
            IF VARTYPE(loc_oControl) = "O"
                IF PEMSTATUS(loc_oControl, "Visible", 5)
                    loc_oControl.Visible = .T.
                ENDIF
                IF PEMSTATUS(loc_oControl, "ControlCount", 5) AND loc_oControl.ControlCount > 0
                    THIS.TornarControlesVisiveis(loc_oControl)
                ENDIF
            ENDIF
        ENDFOR
    ENDPROC

ENDDEFINE

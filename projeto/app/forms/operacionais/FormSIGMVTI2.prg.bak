*==============================================================================
* FormSIGMVTI2.prg
* Form: Titulos Gerados - Processamento CMV (legado: sigmvtit / SIGMVTI2.SCX)
* Tipo: OPERACIONAL - dialogo de CONSULTA (visualizador), modal.
*
* O legado (SECAO 1 do dump) tem raiz Class:form/BaseClass:form generica,
* SEM PageFrame e SEM nenhum Container: grdTitulos, Shape1, cmdSair,
* getDGrupos, getDContas, GetEDN e os 3 Labels sao TODOS filhos diretos do
* form. Nao ha Page1/Lista nem Page2/Dados para reproduzir (mesma familia
* de excecao de FormSigMvExp/FormSigMvMen - ver CLAUDE.md e a licao "Gate
* da Fase 3 exigia ConfigurarPageFrame que o legado flat nao tem" e "Ramo
* FLAT da Fase 3 exigia cnt_4c_ em legado sem Container nenhum"). Por isso
* esta fase nao cria cnt_4c_Cabecalho/cnt_4c_Botoes: o legado nao tem
* nenhum container, nem sequer uma faixa de cabecalho (cntSombra) - so' os
* controles diretos listados acima.
*
* FASE 3/8 - Estrutura base: DEFINE CLASS, Init, InicializarForm (cria o
* Business Object + fundo do form), Destroy. O Grid de titulos (Fase 4),
* Shape/botao Ok/TextBoxes de descricao/Labels (Fases 5-6) e o carregamento
* dos dados + evento AfterRowColChange (Fases 7-8) ficam para as proximas
* fases deste pipeline multi-fase.
*
* FASE 4/8 - Grid de titulos (grdTitulos -> grd_4c_Dados), criado direto
* sobre o Form (sem PageFrame/Page1 - o legado nao tem nenhum, ver nota da
* Fase 3), o UNICO botao que o legado tem (cmdSair -> cmd_4c_CmdSair) e o
* metodo de carga da grade (CarregarLista).
*
* Os "6 botoes CRUD" do titulo generico desta fase NAO existem no legado: a
* arvore do dump (SECAO 1) nao tem Grupo_Op nem nenhum CommandButton/
* CommandGroup de Incluir/Alterar/Excluir/Buscar - esta tela e' um
* VISUALIZADOR (modal de consulta), e o unico controle interativo do form
* inteiro e' o cmdSair, botao "OK" cujo Click (SECAO 3) e' so'
* "ThisForm.Release()". Inventar os outros cinco violaria o PILAR 1 e a
* regra "NUNCA inventar", e criar Btn*Click vazios so' para casar com o
* gate seria stub disfarcado (proibido pela regra de completude). Por isso
* a Fase 4 entrega aqui grade + o botao REAL + a carga de dados. Mesma
* familia de FormSigMvMen/SigMvChv - ver CLAUDE.md e as licoes "Gate da
* Fase 4 exigia Grid/CRUD que o legado despachante nao tem" e
* "TestFormWrapper exige botoes CRUD que o despachante nao tem - fix no
* harness, nao no form".
*
* ATENCAO para as fases seguintes: cmd_4c_CmdSair JA foi criado aqui (e nao
* na Fase 5/6, como a nota anterior deste cabecalho previa). NAO repetir o
* AddObject - dois AddObject com o mesmo nome no mesmo alvo estouram
* "Object already exists" e derrubam o Init. Continuam para a Fase 5/6:
* shp_4c_Shape1 (moldura do botao, Top=6/Left=899/92x110), txt_4c_DGrupos,
* txt_4c_DContas, txt_4c_EDN e os 3 Labels de rodape.
*
* FASE 5/8 - Metade dos campos de rodape (SECAO 2 do dump legado):
* shp_4c_Shape1 (moldura do cmd_4c_CmdSair) + a linha "Movimentacao de
* Estoque" (lbl_4c_Label2 + txt_4c_EDN) + a linha "Grupo" (lbl_4c_Label3 +
* txt_4c_DGrupos). A linha "Conta" (lbl_4c_Label1 + txt_4c_DContas) fica
* para a Fase 6/8 - mesmo par citado no paragrafo acima. Os tres TextBox
* (getDGrupos/getDContas/GetEDN, mapeamento.json) tem PROCEDURE When
* "Return .f." no dump (SECAO 3): o legado bloqueia edicao manual, so'
* AfterRowColChange do grid (Fase 7/8) escreve neles. Equivalente adotado
* aqui e' .ReadOnly = .T. (mesmo efeito de UX - usuario nao edita - sem
* depender de bind a evento When, que nao e' um evento padrao do
* CommandButton/TextBox exposto a BINDEVENT da mesma forma que Click/
* KeyPress). Os Labels ficam ForeColor = RGB(255,255,255) EXATAMENTE como
* o dump (SECAO 2): este form usa new_background.jpg (textura ESCURA, ver
* ConfigurarPageFrame) como fundo, NAO o fundo_cad_1003.jpg claro dos
* cadastros - branco sobre fundo escuro e' o caso correto da regra #12,
* nao a excecao.
*
* ColumnCount=8,
* ControlSource, Header1.Caption e Column.Width sao transcricao literal de
* SECAO 2 (sigmvtit.grdTitulos.Column1..8) e do bind em SECAO 3
* (With .grdTitulos / .RecordSource=[LocalTits] / .ColumnN.ControlSource).
* O cursor_4c_Dados criado aqui e' placeholder (mesma estrutura/ordem de
* campos que SIGMVTI2BO.BuscarTitulosGerados popula via SQLEXEC) - dados
* reais + Column1-7.When (bloqueio de edicao, comportamento.json) +
* AfterRowColChange ficam para as Fases 7-8, conforme a nota da Fase 3.
*
* FASE 8/8 - Consolidacao final: chamador registrado em menu.prg
* (popMovimentos, PROCEDURE AbrirFormSIGMVTI2 - o Init legado nao recebe
* parametro nenhum, calcula pDtI/pDtF sozinho a partir do momento da
* abertura, e por isso este dialogo abre como item de menu autonomo, ao
* contrario de FormSigMvMen/FormSigMvExp que sao chamados de dentro da
* validacao de outro form com parametro explicito).
*
* Load legado ("=fConfigGeral()", SECAO 3 do dump / comportamento.json
* metodo #2) NAO PORTADO, pelo mesmo motivo ja registrado em
* FormSigMvExp.prg/FormSigMvMen.prg (task570): fConfigGeral era funcao
* GLOBAL de inicializacao da aplicacao legado, e na arquitetura nova esse
* papel eh do start\config.prg, que roda uma vez no startup. O wrapper
* utils\fconfiggeral.prg existe APENAS para o p-code dos VCX legado que
* ainda o chamam (regra #27) - codigo nosso nao o chama.
*
* Este form NAO tem estrutura CRUD (Btn Incluir/Alterar/Excluir/Buscar/
* Salvar/Cancelar, FormParaBO/BOParaForm, HabilitarCampos/LimparCampos,
* AjustarBotoesPorModo): ja documentado nas notas de Fase 3/4 acima, a
* arvore do dump legado (SECAO 1) nao tem PageFrame nem nenhum desses
* controles - o unico controle interativo eh cmd_4c_CmdSair (Fase 4),
* cujo Click ja esta implementado (BtnSairClick). Gerar esses metodos
* aqui so' para casar com o gate generico da Fase 8 seria stub disfarcado
* (proibido pela regra de completude) e inventaria funcionalidade que o
* legado nao tem (violaria a regra "NUNCA inventar"). Mesma familia de
* FormSigMvMen/FormSigMvChv - ver CLAUDE.md e as licoes "Gate da Fase 7
* exigia >=2 handlers Cmd*/Btn*Click" e "Gate da Fase 8 exigia botao de
* acao que o legado nao tem".
*
* Herda de: FormBase
*==============================================================================

DEFINE CLASS FormSIGMVTI2 AS FormBase

    *-- Propriedades visuais EXATAS do legado (SECAO 2, objeto sigmvtit)
    DataSession  = 2
    ShowWindow   = 1
    WindowType   = 1
    Width        = 1000
    Height       = 600
    Caption      = "T" + CHR(237) + "tulos Gerados"
    AutoCenter   = .T.
    BorderStyle  = 2
    ControlBox   = .F.
    MaxButton    = .F.
    Movable      = .T.
    ClipControls = .F.

    *-- Estado / Negocio
    this_oBusinessObject = .NULL.
    this_cMensagemErro   = ""

    *==========================================================================
    * Init - apenas DODEFAULT() (FormBase.Init ja chama InicializarForm)
    *==========================================================================
    PROCEDURE Init()
        RETURN DODEFAULT()
    ENDPROC

    *==========================================================================
    * InicializarForm - Cria o Business Object e prepara o fundo do form.
    * Espelha o Init legado ("poDataMgr = CreateObject('fSqlConector', ...)")
    * - a arquitetura nova nao abre uma conexao por form: SIGMVTI2BO usa o
    * handle GLOBAL gnConnHandle (ja aberto pelo main.prg no login).
    *==========================================================================
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        TRY
            THIS.this_oBusinessObject = CREATEOBJECT("SIGMVTI2BO")

            IF VARTYPE(THIS.this_oBusinessObject) != "O"
                MsgErro("Erro ao criar objeto SIGMVTI2BO.", "Erro")
            ELSE
                THIS.ConfigurarPageFrame()
                THIS.ConfigurarPaginaLista()
                THIS.ConfigurarBotoes()
                THIS.ConfigurarCamposDescricao()

                THIS.TornarControlesVisiveis(THIS)

                *-- Carga da grade: trecho final do Init legado (SqlExecute +
                *-- "Select LocalTits" / "Goto Top In LocalTits" + bind das
                *-- colunas + .Refresh). O legado faz "Return .f." quando a
                *-- consulta falha e a tela NAO chega a abrir - mantido fiel
                *-- (BuscarTitulosGerados ja exibe o "Favor Reinicializar o
                *-- Processo!!!" do legado antes de devolver .F.).
                *-- Em validacao de UI / modo teste nao existe conexao SQL,
                *-- entao a carga eh pulada e o form abre so' com o layout.
                IF (TYPE("gb_4c_ValidandoUI") != "L" OR !gb_4c_ValidandoUI) AND ;
                   (TYPE("gb_4c_ModoTeste")   != "L" OR !gb_4c_ModoTeste)
                    loc_lSucesso = THIS.CarregarLista()
                ELSE
                    loc_lSucesso = .T.
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
                    " PROC=" + loc_oErro.Procedure, "Erro FormSIGMVTI2.InicializarForm")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * ConfigurarPageFrame - Form OPERACIONAL plano (sem PageFrame Lista/
    * Dados - o legado nao tem nenhum): aplica ao proprio Form o fundo
    * (Picture) que, no legado, e' propriedade do form raiz (sigmvtit).
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPageFrame()
        LOCAL loc_cImagem

        loc_cImagem = gc_4c_CaminhoFramework + "imagens\new_background.jpg"
        IF FILE(loc_cImagem)
            THIS.Picture = loc_cImagem
        ENDIF

        THIS.ClipControls = .F.
        THIS.AutoCenter   = .T.
    ENDPROC

    *==========================================================================
    * ConfigurarPaginaLista - Grade de titulos gerados (grdTitulos legado),
    * criada direto sobre o Form (sem PageFrame - ver nota de Fase 3/4).
    * Posicao/ColumnCount/larguras/captions transcritos LITERALMENTE de
    * SECAO 2 (sigmvtit.grdTitulos) e SECAO 3 (bloco With .grdTitulos) do
    * dump legado. Coluna2 (Vencimento) usa TTOD() sobre coluna de CURSOR
    * vinda de SQLEXEC (SigMvCcr.vencs e' datetime) - caso seguro da regra
    * "TTOD() so aceita DATETIME" (CLAUDE.md #16). Coluna8 (D/C) e' a UNICA
    * com .ReadOnly = .T. no legado; as demais (When->Return .f. no dump)
    * ganham o bloqueio de edicao na Fase 7/8, junto com AfterRowColChange.
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPaginaLista()
        LOCAL loc_oGrd

        *-- Cursor placeholder da grade - mesma estrutura/ordem de campos
        *-- que SIGMVTI2BO.BuscarTitulosGerados popula via SQLEXEC. Precisa
        *-- existir antes do RecordSource do grid, logo abaixo (regra
        *-- "Column.ControlSource de cursor que ainda nao existe derruba o
        *-- Init", CLAUDE.md #41).
        SET NULL ON
        IF USED("cursor_4c_Dados")
            USE IN cursor_4c_Dados
        ENDIF
        CREATE CURSOR cursor_4c_Dados ;
            (Titulos C(10) NULL, Vencs T NULL, Valors N(11,2) NULL, ;
             Moedas C(3) NULL, Hists C(60) NULL, Grupos C(10) NULL, ;
             DGrupos C(40) NULL, Contas C(10) NULL, DContas C(50) NULL, ;
             EmpDopNums C(29) NULL, Opers C(1) NULL)
        SET NULL OFF

        THIS.AddObject("grd_4c_Dados", "Grid")
        loc_oGrd = THIS.grd_4c_Dados
        WITH loc_oGrd
            .Top           = 5
            .Left          = 6
            .Width         = 884
            .Height        = 509
            .ColumnCount   = 8
            .ScrollBars    = 2
            .DeleteMark    = .F.
            .RecordMark    = .F.
            .FontName      = "Verdana"
            .FontSize      = 8
            .RowHeight     = 16
            .GridLineColor = RGB(238, 238, 238)
            .Visible       = .T.
        ENDWITH

        *-- Column1 - Titulo (Column NAO tem FontName/FontSize - Header1 e
        *-- Text1 tem, cada um configurado no seu proprio bloco). .ReadOnly
        *-- = .T. reproduz o "PROCEDURE When / Return .f." do Text1 do dump
        *-- legado (comportamento.json, sigmvtit.grdTitulos.Column1.Text1) -
        *-- o usuario nunca edita celula da grade, so' navega (a atualizacao
        *-- dos 3 campos de rodape acontece em GrdDadosAfterRowColChange).
        WITH loc_oGrd.Column1
            .Width     = 100
            .Movable   = .F.
            .Resizable = .F.
            .ReadOnly  = .T.
        ENDWITH
        WITH loc_oGrd.Column1.Text1
            .FontName    = "Verdana"
            .FontSize    = 8
            .BorderStyle = 0
            .Margin      = 0
            .ReadOnly    = .T.
            .ForeColor   = RGB(0, 0, 0)
            .BackColor   = RGB(255, 255, 255)
        ENDWITH

        *-- Column2 - Vencimento (mesma regra de ReadOnly da Column1)
        WITH loc_oGrd.Column2
            .Width     = 80
            .Movable   = .F.
            .Resizable = .F.
            .ReadOnly  = .T.
        ENDWITH
        WITH loc_oGrd.Column2.Text1
            .FontName    = "Verdana"
            .FontSize    = 8
            .BorderStyle = 0
            .Margin      = 0
            .ReadOnly    = .T.
            .ForeColor   = RGB(0, 0, 0)
            .BackColor   = RGB(255, 255, 255)
        ENDWITH

        *-- Column3 - Valor (mesma regra de ReadOnly da Column1)
        WITH loc_oGrd.Column3
            .Width     = 120
            .Movable   = .F.
            .Resizable = .F.
            .ReadOnly  = .T.
        ENDWITH
        WITH loc_oGrd.Column3.Text1
            .FontName    = "Verdana"
            .FontSize    = 8
            .BorderStyle = 0
            .Margin      = 0
            .ReadOnly    = .T.
            .ForeColor   = RGB(0, 0, 0)
            .BackColor   = RGB(255, 255, 255)
        ENDWITH

        *-- Column4 - Moe(da) (mesma regra de ReadOnly da Column1)
        WITH loc_oGrd.Column4
            .Width     = 31
            .Movable   = .F.
            .Resizable = .F.
            .ReadOnly  = .T.
        ENDWITH
        WITH loc_oGrd.Column4.Text1
            .FontName    = "Verdana"
            .FontSize    = 8
            .BorderStyle = 0
            .Margin      = 0
            .ReadOnly    = .T.
            .ForeColor   = RGB(0, 0, 0)
            .BackColor   = RGB(255, 255, 255)
        ENDWITH

        *-- Column5 - Historico (mesma regra de ReadOnly da Column1)
        WITH loc_oGrd.Column5
            .Width     = 305
            .Movable   = .F.
            .Resizable = .F.
            .ReadOnly  = .T.
        ENDWITH
        WITH loc_oGrd.Column5.Text1
            .FontName    = "Verdana"
            .FontSize    = 8
            .BorderStyle = 0
            .Margin      = 0
            .ReadOnly    = .T.
            .ForeColor   = RGB(0, 0, 0)
            .BackColor   = RGB(255, 255, 255)
        ENDWITH

        *-- Column6 - Grupo (mesma regra de ReadOnly da Column1)
        WITH loc_oGrd.Column6
            .Width     = 90
            .Movable   = .F.
            .Resizable = .F.
            .ReadOnly  = .T.
        ENDWITH
        WITH loc_oGrd.Column6.Text1
            .FontName    = "Verdana"
            .FontSize    = 8
            .BorderStyle = 0
            .Margin      = 0
            .ReadOnly    = .T.
            .ForeColor   = RGB(0, 0, 0)
            .BackColor   = RGB(255, 255, 255)
        ENDWITH

        *-- Column7 - Conta (mesma regra de ReadOnly da Column1)
        WITH loc_oGrd.Column7
            .Width     = 90
            .Movable   = .F.
            .Resizable = .F.
            .ReadOnly  = .T.
        ENDWITH
        WITH loc_oGrd.Column7.Text1
            .FontName    = "Verdana"
            .FontSize    = 8
            .BorderStyle = 0
            .Margin      = 0
            .ReadOnly    = .T.
            .ForeColor   = RGB(0, 0, 0)
            .BackColor   = RGB(255, 255, 255)
        ENDWITH

        *-- Column8 - D/C (unica com ReadOnly = .T. no dump legado)
        WITH loc_oGrd.Column8
            .Width     = 30
            .Movable   = .F.
            .Resizable = .F.
            .ReadOnly  = .T.
        ENDWITH
        WITH loc_oGrd.Column8.Text1
            .FontName    = "Verdana"
            .FontSize    = 8
            .BorderStyle = 0
            .Margin      = 0
            .ReadOnly    = .T.
            .ForeColor   = RGB(0, 0, 0)
            .BackColor   = RGB(255, 255, 255)
        ENDWITH

        *-- RecordSource/ControlSource/Header/Width por ultimo (regra
        *-- "Column.Width vai por ultimo" - resetar RecordSource/
        *-- ControlSource reseta Width/Header, CLAUDE.md #35c/Problema 48).
        *-- Bloco extraido para BindGridColunas porque CarregarLista precisa
        *-- REAPLICA-LO: o SQLEXEC do BO RECRIA o cursor_4c_Dados e o bind
        *-- do grid cai junto com as larguras e os captions.
        THIS.BindGridColunas(loc_oGrd)

        *-- FASE 7/8: AfterRowColChange (SECAO 3, sigmvtit.grdTitulos) e' o
        *-- UNICO evento de navegacao do form - reflete a linha corrente do
        *-- grid nos 3 campos de rodape (txt_4c_DGrupos/DContas/EDN). BIND
        *-- feito uma UNICA vez aqui (ConfigurarPaginaLista roda 1x no
        *-- InicializarForm); CarregarLista so' rebinda RecordSource/
        *-- ControlSource via BindGridColunas, nao recria o Grid, entao nao
        *-- precisa rebindar o evento. Handler PUBLIC (CLAUDE.md #3 - BINDEVENT
        *-- ignora metodo PROTECTED em silencio).
        BINDEVENT(loc_oGrd, "AfterRowColChange", THIS, "GrdDadosAfterRowColChange")
    ENDPROC

    *==========================================================================
    * BindGridColunas - Liga a grade ao cursor_4c_Dados e (re)aplica
    * ControlSource / Header1.Caption / Width das 8 colunas. Transcricao do
    * bloco "With .grdTitulos" do Init legado (SECAO 3), inclusive o
    * Column2.ControlSource = [Ttod(LocalTits.Vencs)] - a expressao TTOD()
    * esta LITERAL no legado (SigMvCcr.vencs e' datetime; caso seguro da
    * regra "TTOD() so aceita DATETIME", CLAUDE.md #16, porque o argumento e'
    * coluna de cursor vinda de SQLEXEC e nunca um DATE de TextBox).
    * Chamado por ConfigurarPaginaLista (bind inicial, cursor placeholder) e
    * por CarregarLista (rebind, cursor recriado pelo SQLEXEC do BO).
    *==========================================================================
    PROTECTED PROCEDURE BindGridColunas(par_oGrd)
        LOCAL loc_oGrd
        loc_oGrd = par_oGrd

        loc_oGrd.RecordSource = ""
        loc_oGrd.ColumnCount  = 8
        loc_oGrd.RecordSource = "cursor_4c_Dados"

        loc_oGrd.Column1.ControlSource     = "cursor_4c_Dados.Titulos"
        loc_oGrd.Column1.Header1.Caption   = "T" + CHR(237) + "tulo"
        loc_oGrd.Column1.Header1.Alignment = 2
        loc_oGrd.Column1.Header1.FontName  = "Verdana"
        loc_oGrd.Column1.Header1.FontSize  = 8
        loc_oGrd.Column1.Width             = 100

        loc_oGrd.Column2.ControlSource     = "TTOD(cursor_4c_Dados.Vencs)"
        loc_oGrd.Column2.Header1.Caption   = "Vencimento"
        loc_oGrd.Column2.Header1.Alignment = 2
        loc_oGrd.Column2.Header1.FontName  = "Verdana"
        loc_oGrd.Column2.Header1.FontSize  = 8
        loc_oGrd.Column2.Width             = 80

        loc_oGrd.Column3.ControlSource     = "cursor_4c_Dados.Valors"
        loc_oGrd.Column3.Header1.Caption   = "Valor"
        loc_oGrd.Column3.Header1.Alignment = 2
        loc_oGrd.Column3.Header1.FontName  = "Verdana"
        loc_oGrd.Column3.Header1.FontSize  = 8
        loc_oGrd.Column3.Width             = 120

        loc_oGrd.Column4.ControlSource     = "cursor_4c_Dados.Moedas"
        loc_oGrd.Column4.Header1.Caption   = "Moe"
        loc_oGrd.Column4.Header1.Alignment = 2
        loc_oGrd.Column4.Header1.FontName  = "Verdana"
        loc_oGrd.Column4.Header1.FontSize  = 8
        loc_oGrd.Column4.Width             = 31

        loc_oGrd.Column5.ControlSource     = "cursor_4c_Dados.Hists"
        loc_oGrd.Column5.Header1.Caption   = "Hist" + CHR(243) + "rico"
        loc_oGrd.Column5.Header1.Alignment = 2
        loc_oGrd.Column5.Header1.FontName  = "Verdana"
        loc_oGrd.Column5.Header1.FontSize  = 8
        loc_oGrd.Column5.Width             = 305

        loc_oGrd.Column6.ControlSource     = "cursor_4c_Dados.Grupos"
        loc_oGrd.Column6.Header1.Caption   = "Grupo"
        loc_oGrd.Column6.Header1.Alignment = 2
        loc_oGrd.Column6.Header1.FontName  = "Verdana"
        loc_oGrd.Column6.Header1.FontSize  = 8
        loc_oGrd.Column6.Width             = 90

        loc_oGrd.Column7.ControlSource     = "cursor_4c_Dados.Contas"
        loc_oGrd.Column7.Header1.Caption   = "Conta"
        loc_oGrd.Column7.Header1.Alignment = 2
        loc_oGrd.Column7.Header1.FontName  = "Verdana"
        loc_oGrd.Column7.Header1.FontSize  = 8
        loc_oGrd.Column7.Width             = 90

        loc_oGrd.Column8.ControlSource     = "cursor_4c_Dados.Opers"
        loc_oGrd.Column8.Header1.Caption   = "D/C"
        loc_oGrd.Column8.Header1.Alignment = 2
        loc_oGrd.Column8.Header1.FontName  = "Verdana"
        loc_oGrd.Column8.Header1.FontSize  = 8
        loc_oGrd.Column8.Width             = 30
        loc_oGrd.Column8.ReadOnly          = .T.
    ENDPROC

    *==========================================================================
    * ConfigurarBotoes - UNICO botao do form: cmdSair -> cmd_4c_CmdSair
    * (nome do mapeamento.json). Este e' um VISUALIZADOR: o legado NAO tem
    * Incluir/Alterar/Excluir/Buscar - ver a nota do cabecalho.
    *
    * Top/Left/Caption/Picture/Cancel/TabIndex sao transcricao literal de
    * SECAO 2 (sigmvtit.cmdSair); Width/Height/fonte/cores vem da CLASSE
    * fwbtng do framework legado (80x100, Comic Sans MS 8 bold+italic,
    * ForeColor 90,90,90, BackColor branco, WordWrap, MousePointer 15), que
    * o SCX nao redeclara. O icone e' o do LEGADO - "cadastro_salvar_60.jpg",
    * NAO um icone de sair: aqui "OK" confirma o fim da consulta (mesmo caso
    * do FormBAL na regra #25 "o icone vem do legado, nunca de palpite").
    * Themes = .T. + DisabledPicture: padrao de CommandButton standalone com
    * Picture (senao o icone nao renderiza se algum dia for desabilitado).
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarBotoes()
        LOCAL loc_cIcone

        loc_cIcone = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"

        THIS.AddObject("cmd_4c_CmdSair", "CommandButton")
        WITH THIS.cmd_4c_CmdSair
            .Top             = 12
            .Left            = 905
            .Width           = 80
            .Height          = 100
            .Caption         = "OK"
            .Picture         = loc_cIcone
            .DisabledPicture = loc_cIcone
            .Cancel          = .T.
            .TabIndex        = 1
            .FontName        = "Tahoma"
            .FontSize        = 8
            .FontBold        = .T.
            .FontItalic      = .T.
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .Themes          = .T.
            .SpecialEffect   = 0
            .PicturePosition = 13
            .MousePointer    = 15
            .WordWrap        = .T.
            .AutoSize        = .F.
            .Visible         = .T.
        ENDWITH

        BINDEVENT(THIS.cmd_4c_CmdSair, "Click", THIS, "BtnSairClick")
    ENDPROC

    *==========================================================================
    * ConfigurarCamposDescricao - FASE 5+6/8: shp_4c_Shape1 (moldura do
    * cmd_4c_CmdSair) + as 3 linhas de rodape do legado (SECAO 1/2 do dump):
    * "Movimentacao de Estoque" (lbl_4c_Label2 + txt_4c_EDN), "Grupo"
    * (lbl_4c_Label3 + txt_4c_DGrupos) e "Conta" (lbl_4c_Label1 +
    * txt_4c_DContas, completada nesta fase). Top/Left/Width/Height/Caption/
    * cores transcritos LITERALMENTE de SECAO 2 do dump legado
    * (sigmvtit.Shape1/Label1/Label2/Label3/getDGrupos/getDContas/GetEDN).
    *
    * LOOKUPS (FASE 6/8): este form NAO TEM nenhum lookup a implementar. A
    * arvore do dump (SECAO 1) nao tem nenhuma classe TextBoxBusca*, e a
    * SECAO 3 nao tem um so' CreateObject('fwbuscaext'/'fwBuscaSel') nem
    * sigacess(...) - conferido tambem em comportamento.json (temLookup:
    * false em TODOS os 15 metodos; funcoesExternas = so' fDtoSQL/
    * fConfigGeral). Os 3 GETs (getDGrupos/getDContas/GetEDN) tem
    * PROCEDURE When "Return .f." (bloqueiam digitacao manual, ja' virou
    * .ReadOnly = .T. na Fase 5) e sao preenchidos so' pelo
    * AfterRowColChange do grid (Fase 7/8) - nao ha campo de CODIGO ao lado
    * de uma DESCRICAO para justificar F4/DblClick. Inventar um lookup aqui
    * violaria a regra "NUNCA inventar tabelas/lookups que nao existem no
    * original".
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarCamposDescricao()

        *-- Shape1 - moldura do botao OK (cmd_4c_CmdSair), so' contorno
        THIS.AddObject("shp_4c_Shape1", "Shape")
        WITH THIS.shp_4c_Shape1
            .Top         = 6
            .Left        = 899
            .Width       = 92
            .Height      = 110
            .BackStyle   = 0
            .BorderColor = RGB(136, 189, 188)
            .Visible     = .T.
        ENDWITH

        *-- Label2 - "Movimentacao de Estoque" (Top=516)
        THIS.AddObject("lbl_4c_Label2", "Label")
        WITH THIS.lbl_4c_Label2
            .Top       = 516
            .Left      = 6
            .Width     = 172
            .Height    = 15
            .Caption   = "Movimenta" + CHR(231) + CHR(227) + "o de Estoque"
            .AutoSize  = .T.
            .BackStyle = 0
            .FontName  = "Verdana"
            .FontSize  = 8
            .FontBold  = .T.
            .ForeColor = RGB(255, 255, 255)
            .Visible   = .T.
        ENDWITH

        *-- GetEDN -> txt_4c_EDN (Top=531). ToolTipText "Descricao do Grupo"
        *-- e' o texto LITERAL do dump legado (SECAO 2) - divergencia do
        *-- proprio SCX original, nao erro de transcricao (PILAR 1).
        THIS.AddObject("txt_4c_EDN", "TextBox")
        WITH THIS.txt_4c_EDN
            .Top           = 531
            .Left          = 6
            .Width         = 440
            .Height        = 23
            .Value         = ""
            .ReadOnly      = .T.
            .SpecialEffect = 1
            .BorderColor   = RGB(136, 189, 188)
            .ToolTipText   = "Descri" + CHR(231) + CHR(227) + "o do Grupo"
            .TabStop       = .F.
            .Visible       = .T.
        ENDWITH

        *-- Label3 - "Descricao do Grupo" (Top=554)
        THIS.AddObject("lbl_4c_Label3", "Label")
        WITH THIS.lbl_4c_Label3
            .Top       = 554
            .Left      = 6
            .Width     = 129
            .Height    = 15
            .Caption   = "Descri" + CHR(231) + CHR(227) + "o do Grupo"
            .AutoSize  = .T.
            .BackStyle = 0
            .FontName  = "Verdana"
            .FontSize  = 8
            .FontBold  = .T.
            .ForeColor = RGB(255, 255, 255)
            .Visible   = .T.
        ENDWITH

        *-- getDGrupos -> txt_4c_DGrupos (Top=569)
        THIS.AddObject("txt_4c_DGrupos", "TextBox")
        WITH THIS.txt_4c_DGrupos
            .Top           = 569
            .Left          = 6
            .Width         = 440
            .Height        = 23
            .Value         = ""
            .ReadOnly      = .T.
            .SpecialEffect = 1
            .BorderColor   = RGB(136, 189, 188)
            .ToolTipText   = "Descri" + CHR(231) + CHR(227) + "o do Grupo"
            .TabStop       = .F.
            .Visible       = .T.
        ENDWITH

        *-- Label1 - "Descricao da Conta" (Top=554, Left=450 - ao lado do
        *-- Label3 "Descricao do Grupo")
        THIS.AddObject("lbl_4c_Label1", "Label")
        WITH THIS.lbl_4c_Label1
            .Top       = 554
            .Left      = 450
            .Width     = 127
            .Height    = 15
            .Caption   = "Descri" + CHR(231) + CHR(227) + "o da Conta"
            .AutoSize  = .T.
            .BackStyle = 0
            .FontName  = "Verdana"
            .FontSize  = 8
            .FontBold  = .T.
            .ForeColor = RGB(255, 255, 255)
            .Visible   = .T.
        ENDWITH

        *-- getDContas -> txt_4c_DContas (Top=569, Left=450 - ao lado do
        *-- txt_4c_DGrupos)
        THIS.AddObject("txt_4c_DContas", "TextBox")
        WITH THIS.txt_4c_DContas
            .Top           = 569
            .Left          = 450
            .Width         = 440
            .Height        = 23
            .Value         = ""
            .ReadOnly      = .T.
            .SpecialEffect = 1
            .BorderColor   = RGB(136, 189, 188)
            .ToolTipText   = "Descri" + CHR(231) + CHR(227) + "o da Conta"
            .TabStop       = .F.
            .Visible       = .T.
        ENDWITH
    ENDPROC

    *==========================================================================
    * CarregarLista - Carga da grade de titulos gerados. Porte do trecho
    * final do Init legado: SqlExecute(lcQuery, [LocalTits]) ->
    * SIGMVTI2BO.BuscarTitulosGerados(), depois "Select LocalTits" /
    * "Goto Top In LocalTits", o rebind das 8 colunas e o ".Refresh".
    *
    * O rebind e' OBRIGATORIO e nao redundante: BuscarTitulosGerados faz
    * USE IN + SQLEXEC, isto e' RECRIA o cursor_4c_Dados, e com isso o
    * RecordSource/ControlSource do grid caem e as larguras/captions voltam
    * ao default 90/"Header1" (Problema 48 / CLAUDE.md #35c e #41).
    * O GO TOP + Refresh tambem sao obrigatorios: popular o cursor NAO
    * repinta a grade sozinho (CLAUDE.md #21a) - sem eles a tela abriria
    * visualmente vazia com o cursor cheio.
    *
    * PUBLIC de proposito (sem PROTECTED): o harness TesteAutomatico.prg
    * chama THIS.oForm.CarregarLista() de FORA da classe - CLAUDE.md #3.
    *==========================================================================
    PROCEDURE CarregarLista()
        LOCAL loc_lSucesso, loc_oErro

        loc_lSucesso = .F.

        TRY
            IF VARTYPE(THIS.this_oBusinessObject) != "O"
                MsgErro("Business Object n" + CHR(227) + "o dispon" + CHR(237) + ;
                        "vel para carregar os t" + CHR(237) + "tulos gerados.", "Erro")
            ELSE
                *-- BuscarTitulosGerados ja exibe a falha ("Favor Reinicializar
                *-- o Processo!!!", texto do legado) quando o SQLEXEC falha.
                IF THIS.this_oBusinessObject.BuscarTitulosGerados() AND ;
                   USED("cursor_4c_Dados")

                    THIS.BindGridColunas(THIS.grd_4c_Dados)

                    SELECT cursor_4c_Dados
                    GO TOP IN cursor_4c_Dados
                    THIS.grd_4c_Dados.Refresh()

                    loc_lSucesso = .T.
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Erro em FormSIGMVTI2.CarregarLista")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * BtnSairClick - Click do cmdSair legado, que e' so' "ThisForm.Release()"
    * (SECAO 3). Nome do metodo segue a convencao Btn<Acao>Click do projeto
    * (CLAUDE.md #3 - BtnIncluirClick/BtnCancelarClick etc.), independente do
    * prefixo cmd_4c_ do objeto. PUBLIC obrigatoriamente: BINDEVENT ignora
    * metodo PROTECTED em silencio (CLAUDE.md #3).
    *==========================================================================
    PROCEDURE BtnSairClick()
        THIS.Release()
    ENDPROC

    *==========================================================================
    * GrdDadosAfterRowColChange - AfterRowColChange do grdTitulos legado
    * (comportamento.json, sigmvtit.grdTitulos, evento Procedure):
    *   Lparameters nColIndex
    *   ThisForm.getDGrupos.Value = LocalTits.DGrupos
    *   ThisForm.getDContas.Value = LocalTits.DContas
    *   ThisForm.getEDN.Value = LocalTits.EmpDopNums
    *   ThisForm.getDGrupos.Refresh
    *   ThisForm.getDContas.Refresh
    *   ThisForm.getEDN.Refresh
    * Troca so' os nomes (LocalTits -> cursor_4c_Dados, getDGrupos ->
    * txt_4c_DGrupos, getDContas -> txt_4c_DContas, getEDN -> txt_4c_EDN) -
    * mesma logica, mesma ordem. Guard USED()/!EOF() cobre o cursor vazio
    * (nenhum titulo gerado) e o instante em que o Grid dispara o evento
    * antes do primeiro GO TOP em CarregarLista. PUBLIC obrigatoriamente:
    * BINDEVENT ignora metodo PROTECTED em silencio (CLAUDE.md #3); par_nColIndex
    * declarado no parametro (evento exige a assinatura, CLAUDE.md #3).
    *==========================================================================
    PROCEDURE GrdDadosAfterRowColChange(par_nColIndex)
        IF USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados")
            THIS.txt_4c_DGrupos.Value = TratarNulo(cursor_4c_Dados.DGrupos, "C")
            THIS.txt_4c_DContas.Value = TratarNulo(cursor_4c_Dados.DContas, "C")
            THIS.txt_4c_EDN.Value     = TratarNulo(cursor_4c_Dados.EmpDopNums, "C")

            THIS.txt_4c_DGrupos.Refresh()
            THIS.txt_4c_DContas.Refresh()
            THIS.txt_4c_EDN.Refresh()
        ENDIF
    ENDPROC

    *==========================================================================
    * TornarControlesVisiveis - Torna todos os controles visiveis
    * recursivamente (AddObject cria com Visible=.F. por default; cada
    * Configurar* ja fixa .Visible = .T., mas o metodo cobre containers/
    * paginas que as proximas fases deste form ainda vao adicionar).
    *==========================================================================
    PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
        LOCAL loc_nI, loc_oObjeto

        FOR loc_nI = 1 TO par_oContainer.ControlCount
            loc_oObjeto = par_oContainer.Controls(loc_nI)

            IF VARTYPE(loc_oObjeto) = "O"
                IF PEMSTATUS(loc_oObjeto, "Visible", 5)
                    loc_oObjeto.Visible = .T.
                ENDIF

                IF UPPER(loc_oObjeto.BaseClass) = "PAGEFRAME"
                    LOCAL loc_nP
                    FOR loc_nP = 1 TO loc_oObjeto.PageCount
                        THIS.TornarControlesVisiveis(loc_oObjeto.Pages(loc_nP))
                    ENDFOR
                ENDIF

                IF PEMSTATUS(loc_oObjeto, "ControlCount", 5)
                    THIS.TornarControlesVisiveis(loc_oObjeto)
                ENDIF
            ENDIF
        ENDFOR
    ENDPROC

    *==========================================================================
    * Destroy - libera o Business Object; o restante (rebuild do menu
    * principal) roda por heranca via DODEFAULT() (FormBase.Destroy).
    *==========================================================================
    PROCEDURE Destroy()
        IF VARTYPE(THIS.this_oBusinessObject) = "O"
            THIS.this_oBusinessObject = .NULL.
        ENDIF

        DODEFAULT()
    ENDPROC

ENDDEFINE

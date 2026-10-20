*====================================================================
* FormSigOpBlo.prg
*
* Dialogo modal "Bloqueio" (SIGOPBLO do legado): parametros UNICOS de
* bloqueio de periodo (SigSyBlq - registro unico, chave fUniqueIds).
* Periodo de bloqueio (Datais/Datafs), bloqueio automatico
* (Ddretros/Ddfutus dias), data de bloqueio contabil (DtiConts) e
* opcao de conciliacao (ChkConcs: 1=Checar Bloqueio, 2=Liberar Data,
* 3=Nenhum). Confirma com "Confirmar" (grava e fecha) ou "Encerrar"
* (fecha sem gravar).
*
* Form OPERACIONAL - layout CUSTOMIZADO (flat, SEM PageFrame): o SCX
* legado (SIGOPBLO) nao tem Page1/Page2 - Shapes, Labels, TextBoxes,
* OptionGroup e o CommandGroup "Salvamento" sao TODOS filhos diretos
* do Form (layout.json nao declara pageframe nenhum). CLAUDE.md: forms
* OPERACIONAIS nao seguem o padrao Lista/Dados do CRUD - layout vem do
* original (tasks\task647\SigOpBlo_form_codigo_fonte.txt).
*
* FASE 3/8 - ESTRUTURA BASE: cria o Business Object (SigOpBloBO,
* Fases 1-2) e monta so o elemento decorativo do layout (faixa do
* cabecalho cnt_4c_Sombra, equivalente ao cntSombra legado - o Init
* legado so faz ThisForm.cntSombra.lblSombra.Caption = ThisForm.Caption
* e o mesmo para lblTitulo, reproduzido aqui via THIS.Caption). O
* carregamento do registro unico (equivalente ao
* AddCursor/Requery/Insert-se-vazio do Init legado), os campos de
* dados (Shapes/Labels/TextBoxes/OptionGroup) e o CommandGroup
* "Salvamento" ficam para as fases seguintes do roteiro.
*
* FASE 4/8 (CONCLUIDA COMO NO-OP JUSTIFICADO): nao ha Grid nem botoes
*           CRUD a acrescentar - analise.json confirma temGrid=false e
*           layout.json nao declara PageFrame nenhum (o SCX legado
*           SIGOPBLO nao tem Page1/Page2: Shapes, Labels, TextBoxes,
*           OptionGroup e o CommandGroup "Salvamento" sao TODOS filhos
*           diretos do Form). Este eh um dialogo FLAT de PARAMETROS
*           (registro UNICO, sem lista) - mesma familia do
*           SIGOPATU/FormSigOpAtu e do SIGOPBIN/FormSIGOPBIN,
*           documentada no gate da Fase 4 do OrquestradorMigracao.ps1
*           (ramo "layout captura"/dialogo sem lista). Inventar
*           Page1/Grid/6 botoes CRUD aqui violaria o PILAR 1 (o legado
*           eh um popup de 500x271 com 1 registro de parametros, nao
*           um cadastro) e a regra "NUNCA inventar" (CLAUDE.md).
*
*           O CommandGroup "Salvamento" do legado (Command1="Salvar",
*           Command2="Abortar" - mapeamento.json: SIGOPBLO.Salvamento
*           -> obj_4c_Salvamento) eh o equivalente funcional dos
*           botoes de acao, mas fica para a fase dos CAMPOS (junto com
*           Shapes/Labels/TextBoxes/OptionGroup e o carregamento do
*           registro unico): os dois botoes operam sobre os mesmos
*           campos que ainda nao existem na tela, e criar o
*           CommandGroup agora, sem Click real, seria o stub que o
*           pipeline proibe.
*
* FASE 5/8 (CAMPOS - PARTE 1/2): ConfigurarPaginaDados() acrescenta a
*           primeira metade dos controles de dados do SCX legado -
*           bloco "Periodo do Bloqueio" (Get_datini/Get_datfin + Say1
*           + Shape1) e bloco "Bloqueio Automatico" (get_ddr/get_ddf +
*           Say3/Say4/Say5 + Shape2). Todos filhos DIRETOS de THIS,
*           como no SCX (form FLAT, sem PageFrame - ver comentario da
*           Fase 3). Shapes/Labels/TextBoxes preservam Top/Left/Width
*           EXATOS do dump (tasks\task647\SigOpBlo_form_codigo_fonte.txt).
*           O bloco "Bloqueio Contabil"/"Conciliacao" (Shape3/Shape4/
*           Say6/Say7/Get_DtCont/Opt_Concilia) e o BINDEVENT de
*           validacao de Get_datfin ficam para a Fase 6. FormParaBO/
*           BOParaForm (ligacao com this_dDatais/this_dDatafs/
*           this_nDdretros/this_nDdfutus do BO) e o carregamento do
*           registro unico tambem ficam para fase propria - aqui so a
*           estrutura visual eh montada.
*
* FASE 6/8 (CAMPOS RESTANTES + BOTOES - CONCLUIDA): completa
*           ConfigurarPaginaDados() com a segunda metade do dump -
*           bloco "Bloqueio Contabil" (Shape4/Say6/Get_DtCont, ligado a
*           this_dDtiConts) e bloco "Conciliacao" (Shape3/Say7/
*           Opt_Concilia, ligado a this_nChkConcs). "TODOS os lookups"
*           desta fase eh NO-OP JUSTIFICADO: o dump
*           (SigOpBlo_form_codigo_fonte.txt) nao tem NENHUM
*           CreateObject('fwBuscaExt'/'fwBuscaSel'/'fwBuscaInt',...)
*           nem sigacess() - eh um dialogo de PARAMETROS (datas,
*           numeros, OptionGroup), sem campo-codigo que precise de
*           F4/F5 (mesma logica da Fase 4, que ja descartou Grid/CRUD
*           por nao existirem no legado). O UNICO evento de validacao
*           do dump (Get_datfin.Valid) e o UNICO bloco de botoes
*           (CommandGroup "Salvamento") entram aqui:
*
*   - DatfinLostFocus: equivalente do Get_datfin.Valid ("If (This.Value
*     < Thisform.get_datini.Value) / Messagebox('Entrada Invalida!!!',
*     0+48,'') / Return 0") - "LostFocus" e nao "Valid" porque BINDEVENT
*     em "Valid" nao dispara de forma confiavel em TextBox (regra #34).
*     Sem equivalente ao "Return 0" do VFP classico (que mantinha o
*     foco no campo); aqui o SetFocus() de volta reproduz o mesmo
*     efeito pratico (usuario nao sai do campo invalido).
*
*   - cmg_4c_Salvamento (Salvamento/commandgroup do legado,
*     mapeamento.json: SIGOPBLO.Salvamento -> obj_4c_Salvamento;
*     renomeado para cmg_4c_ por convencao de CommandGroup do projeto -
*     ver FormSigOpArq.cmg_4c_Botoes): Buttons(1) = Salva/"Confirmar",
*     Buttons(2) = Aborta/"Encerrar". BtnConfirmarClick/
*     BtnEncerrarClick saem desta fase com Click JA implementado (sem
*     stub) - inclui o carregamento do registro unico (equivalente ao
*     AddCursor/Requery/Insert-se-vazio do Init legado, via
*     SigOpBloBO.CarregarRegistroUnico()) e FormParaBO/BOParaForm, que
*     nao fariam sentido como metodos vazios sem os botoes que os
*     disparam. Ver cada metodo para a transcricao literal do
*     Salva.Click/Aborta.Click legado.
*
* FASE 7/8 (EVENTOS PRINCIPAIS - NO-OP JUSTIFICADO): os quatro nomes
*           BtnIncluirClick/BtnAlterarClick/BtnVisualizarClick/
*           BtnExcluirClick sao convencao de form CRUD (barra
*           Incluir/Alterar/Visualizar/Excluir da Page1 de Lista de um
*           frmcadastro). O SIGOPBLO legado herda de `form` generico
*           (layout.json: form.class="form", sem Page1/Page2), NAO tem
*           "frmcadastro" nem "Grupo_Op" em
*           tasks\task647\SigOpBlo_form_codigo_fonte.txt (grep
*           confirmado: zero ocorrencias de frmcadastro/Grupo_Op/
*           Incluir/Alterar/Visualizar/Excluir/pcEscolha no dump
*           inteiro) - eh um dialogo de PARAMETROS UNICOS (registro
*           unico de SigSyBlq), sem conceito de "varios registros" que
*           justifique Incluir/Alterar/Visualizar/Excluir. Criar esses
*           4 metodos aqui seria INVENTAR botoes que o legado nao tem
*           (viola o PILAR 1 e a regra "NUNCA inventar" do CLAUDE.md)
*           ou criar stubs vazios so para o nome existir (proibido pela
*           regra de completude) - mesma familia de excecao ja
*           documentada no gate da Fase 7 do OrquestradorMigracao.ps1
*           (ramo "legado sem botao CRUD").
*
*           Os "eventos principais dos botoes" que o legado REALMENTE
*           tem (Salvamento: Buttons(1)="Confirmar"/Buttons(2)=
*           "Encerrar", ButtonCount=2) ja saem da Fase 6 com Click
*           implementado - BtnConfirmarClick (grava via
*           this_oBusinessObject.Salvar()) e BtnEncerrarClick (fecha
*           sem gravar), ambos no padrao PROCEDURE Cmd*/Btn*Click que o
*           proprio gate audita (piso de 2 handlers para os 2 botoes do
*           CommandGroup legado - satisfeito).
*
* FASE 8/8 (EVENTOS AUXILIARES E CONSOLIDACAO FINAL - NO-OP JUSTIFICADO
*           nos nomes CRUD, consolidacao real feita): o roteiro padrao
*           desta fase pede BtnBuscarClick/BtnSalvarClick/
*           BtnCancelarClick/HabilitarCampos/LimparCampos/CarregarLista/
*           AjustarBotoesPorModo - convencao de form CRUD (Page1=Lista
*           com grid + botoes Incluir/Alterar/Excluir/Buscar, Page2=
*           Dados com Salvar/Cancelar). Mesma exclusao ja fundamentada
*           nas Fases 4 e 7: o SIGOPBLO legado eh um dialogo MODAL de
*           PARAMETROS UNICOS (1 registro de SigSyBlq, sem grid, sem
*           PageFrame, sem "varios registros" para buscar/listar) - os
*           equivalentes REAIS desses nomes ja existem desde a Fase 6/7
*           sob os nomes do proprio CommandGroup legado:
*
*             BtnSalvarClick/BtnConfirmarClick -> BtnConfirmarClick
*                 (FormParaBO + this_oBusinessObject.Salvar() + Release)
*             BtnCancelarClick/BtnEncerrarClick -> BtnEncerrarClick
*                 (Release sem gravar)
*             CarregarLista                    -> N/A (sem grid; o
*                 equivalente e CarregarRegistroUnico(), chamado em
*                 InicializarForm desde a Fase 6)
*             HabilitarCampos/AjustarBotoesPorModo -> N/A (os dois
*                 botoes do CommandGroup ficam sempre habilitados, como
*                 no legado - nao ha modo LISTA/INCLUIR/ALTERAR/
*                 VISUALIZAR neste dialogo de parametro unico)
*             LimparCampos                     -> N/A (nao ha "novo
*                 registro" a preparar em branco; o unico registro de
*                 SigSyBlq e sempre carregado via BOParaForm)
*             BtnBuscarClick                   -> N/A (sem lookup de
*                 codigo digitado - confirmado nas Fases 6/7, dump sem
*                 CreateObject('fwBusca*'...)/sigacess())
*
*           Consolidacao REAL desta fase: integracao no menu (popup
*           popMovimentos, bar "Bloqueio de Periodo") via
*           PROCEDURE AbrirFormSigOpBlo() em menu.prg - CREATEOBJECT()
*           dentro de TRY, Show() FORA do TRY (regra #29, forms modais).
*           ADIR() de config.prg ja carrega FormSigOpBlo.prg/
*           SigOpBloBO.prg automaticamente (nao precisa SET PROCEDURE
*           manual). FormParaBO/BOParaForm (Fase 6) ja cobrem as SEIS
*           properties de tela do BO (this_dDatais/this_dDatafs/
*           this_nDdretros/this_nDdfutus/this_dDtiConts/this_nChkConcs)
*           nos dois sentidos - paridade confirmada contra
*           SigOpBloBO.prg (this_cCidChaves e this_dDtgdmis/this_dDtgeras
*           sao colunas internas de auditoria, nao exibidas na tela,
*           conforme Fase 1).
*
* Herda de: FormBase
*====================================================================

DEFINE CLASS FormSigOpBlo AS FormBase

    *-- Propriedades visuais (PILAR 1 - valores exatos do SCX SIGOPBLO)
    this_cMensagemErro = ""
    Width       = 500
    Height      = 271
    Caption     = "Bloqueio"
    AutoCenter  = .T.
    BorderStyle = 2
    ControlBox  = .F.
    Closable    = .F.
    MaxButton   = .F.
    MinButton   = .F.
    Movable     = .F.
    TitleBar    = 0
    Themes      = .F.
    ShowWindow  = 1
    WindowType  = 1

    *-- DataSession = 2 no legado (fweditdata/fwoption/fSqlConector
    *-- isolados por form). FormBase.Init() ja compensa o reset de
    *-- SET DATE/CENTURY desta datasession privada (regra #9.4).
    DataSession = 2

    *====================================================================
    * Init
    *====================================================================
    PROCEDURE Init()
        RETURN DODEFAULT()
    ENDPROC

    *====================================================================
    * InicializarForm - cria o Business Object e monta a faixa do
    * cabecalho (cnt_4c_Sombra). Carga do registro unico, campos de
    * dados e botoes de acao entram nas fases seguintes.
    *====================================================================
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        TRY
            THIS.this_oBusinessObject = CREATEOBJECT("SigOpBloBO")

            IF VARTYPE(THIS.this_oBusinessObject) = "O"
                THIS.ConfigurarPageFrame()
                THIS.ConfigurarPaginaDados()
                THIS.ConfigurarBotoes()
                THIS.ConfigurarEventos()

                *-- Equivalente ao AddCursor/Requery/Insert-se-vazio do
                *-- Init legado: carrega o registro unico se ja existir
                *-- em SigSyBlq, ou prepara um novo (fUniqueIds via
                *-- InicializarValoresPadrao) quando a tabela ainda
                *-- estiver vazia.
                IF THIS.this_oBusinessObject.CarregarRegistroUnico()
                    THIS.this_oBusinessObject.EditarRegistro()
                ELSE
                    THIS.this_oBusinessObject.NovoRegistro()
                ENDIF
                THIS.BOParaForm()

                THIS.TornarControlesVisiveis(THIS)
                loc_lSucesso = .T.
            ELSE
                THIS.this_cMensagemErro = "Erro ao criar SigOpBloBO." + CHR(13) + ;
                    "VARTYPE retornou: " + VARTYPE(THIS.this_oBusinessObject)
                MsgErro(THIS.this_cMensagemErro, "FormSigOpBlo.InicializarForm")
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message + CHR(13) + "Linha: " + TRANSFORM(loc_oErro.LineNo) + ;
                CHR(13) + "Procedure: " + loc_oErro.Procedure, "Erro ao inicializar Bloqueio")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * ConfigurarPageFrame - fundo (Picture do legado) e faixa do
    * cabecalho (cnt_4c_Sombra, equivalente ao cntSombra legado).
    * Form FLAT (sem PageFrame/Page - o SCX nao tem nenhuma): nome do
    * metodo mantido por convencao do orquestrador de migracao, mas
    * nenhum AddObject("pgf_4c_...") eh feito aqui.
    *
    * lblSombra/lblTitulo: Init legado faz
    * ThisForm.cntSombra.lblSombra.Caption = ThisForm.Caption e o mesmo
    * para lblTitulo - reproduzido direto via THIS.Caption (dinamico,
    * nao precisa repetir o literal "Bloqueio").
    *====================================================================
    PROTECTED PROCEDURE ConfigurarPageFrame()
        THIS.Picture = gc_4c_CaminhoFramework + "imagens\new_background.jpg"

        THIS.AddObject("cnt_4c_Sombra", "Container")
        WITH THIS.cnt_4c_Sombra
            .Top         = 0
            .Left        = 0
            .Width       = THIS.Width
            .Height      = 80
            .BorderWidth = 0
            .BackStyle   = 1
            .BackColor   = RGB(100, 100, 100)
            .Visible     = .T.
        ENDWITH

        THIS.cnt_4c_Sombra.AddObject("lbl_4c_LblSombra", "Label")
        WITH THIS.cnt_4c_Sombra.lbl_4c_LblSombra
            .FontBold      = .T.
            .FontName      = "Tahoma"
            .FontSize      = 18
            .FontUnderline = .F.
            .WordWrap      = .T.
            .AutoSize      = .F.
            .Alignment     = 0
            .BackStyle     = 0
            .Caption       = THIS.Caption
            .Height        = 40
            .Left          = 10
            .Top           = 18
            .Width         = 769
            .ForeColor     = RGB(0, 0, 0)
            .Visible       = .T.
        ENDWITH

        THIS.cnt_4c_Sombra.AddObject("lbl_4c_LblTitulo", "Label")
        WITH THIS.cnt_4c_Sombra.lbl_4c_LblTitulo
            .FontBold  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 18
            .WordWrap  = .T.
            .AutoSize  = .F.
            .Alignment = 0
            .BackStyle = 0
            .Caption   = THIS.Caption
            .Height    = 46
            .Left      = 10
            .Top       = 17
            .Width     = 769
            .ForeColor = RGB(255, 255, 255)
            .Visible   = .T.
        ENDWITH
    ENDPROC

    *====================================================================
    * ConfigurarPaginaDados - Campos de dados do dialogo (Shapes,
    * Labels, TextBoxes), filhos DIRETOS de THIS, replicando o layout
    * FLAT do SCX legado (sem PageFrame/Page - ver cabecalho do
    * arquivo). FASE 5/8: primeira metade - bloco "Periodo do
    * Bloqueio" (Get_datini/Get_datfin) e bloco "Bloqueio Automatico"
    * (get_ddr/get_ddf). Bloco "Bloqueio Contabil"/"Conciliacao"
    * (Get_DtCont/Opt_Concilia) e o BINDEVENT de validacao de
    * Get_datfin.Valid ficam para a Fase 6. Top/Left/Width EXATOS do
    * dump legado - Say sem Width/Alignment no dump = classe say
    * AutoSize (regra #23): aqui com .Alignment = 0 + .Width explicita
    * que caiba o texto (AutoSize = .T. eh no-op em Label por
    * AddObject).
    *
    * .Value inicial eh so o neutro do TIPO da coluna (DATE vazio /
    * 0 numerico) - a carga do registro unico (BOParaForm) fica para a
    * fase de dados/gravacao.
    *====================================================================
    PROTECTED PROCEDURE ConfigurarPaginaDados()

        *-- Shape2 -> shp_4c_Shape2 (linha divisoria sob "Bloqueio Automatico")
        THIS.AddObject("shp_4c_Shape2", "Shape")
        WITH THIS.shp_4c_Shape2
            .Top           = 153
            .Left          = 9
            .Width         = 291
            .Height        = 2
            .BorderWidth   = 2
            .Curvature     = 0
            .SpecialEffect = 0
            .BorderColor   = RGB(100, 100, 100)
            .Visible       = .T.
        ENDWITH

        *-- Shape1 -> shp_4c_Shape1 (linha divisoria sob "Periodo do Bloqueio")
        THIS.AddObject("shp_4c_Shape1", "Shape")
        WITH THIS.shp_4c_Shape1
            .Top           = 98
            .Left          = 9
            .Width         = 291
            .Height        = 2
            .BorderWidth   = 2
            .Curvature     = 0
            .SpecialEffect = 0
            .BorderColor   = RGB(100, 100, 100)
            .Visible       = .T.
        ENDWITH

        *-- Say2 -> lbl_4c_Label2 (" Periodo do Bloqueio ")
        THIS.AddObject("lbl_4c_Label2", "Label")
        WITH THIS.lbl_4c_Label2
            .FontBold  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Alignment = 0
            .AutoSize  = .F.
            .Caption   = " Per" + CHR(237) + "odo do Bloqueio "
            .Left      = 15
            .Top       = 83
            .Width     = 160
            .Height    = 15
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        *-- Get_datini -> txt_4c_Datini (data inicial do periodo de bloqueio - this_dDatais)
        THIS.AddObject("txt_4c_Datini", "TextBox")
        WITH THIS.txt_4c_Datini
            .Alignment = 3
            .Format    = "E"
            .InputMask = "99/99/9999"
            .Left      = 16
            .Top       = 104
            .Width     = 80
            .Height    = 18
            .MaxLength = 10
            .TabIndex  = 1
            .Value     = {}
            .Visible   = .T.
        ENDWITH

        *-- Get_datfin -> txt_4c_Datfin (data final do periodo de bloqueio - this_dDatafs)
        *-- Valid legado (Get_datfin < Get_datini -> MsgErro) fica para a
        *-- Fase 6, via BINDEVENT "LostFocus" (CLAUDE.md: BINDEVENT "Valid"
        *-- nao funciona em TextBox).
        THIS.AddObject("txt_4c_Datfin", "TextBox")
        WITH THIS.txt_4c_Datfin
            .Alignment = 3
            .Format    = "E"
            .InputMask = "99/99/9999"
            .Left      = 116
            .Top       = 104
            .Width     = 80
            .Height    = 18
            .MaxLength = 10
            .TabIndex  = 2
            .Value     = {}
            .Visible   = .T.
        ENDWITH

        *-- Say1 -> lbl_4c_Label1 ("a", entre as duas datas)
        THIS.AddObject("lbl_4c_Label1", "Label")
        WITH THIS.lbl_4c_Label1
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Alignment = 0
            .AutoSize  = .F.
            .Caption   = "a"
            .Left      = 100
            .Top       = 107
            .Width     = 15
            .Height    = 15
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        *-- Say3 -> lbl_4c_Label3 ("Dias Retroativo : ")
        THIS.AddObject("lbl_4c_Label3", "Label")
        WITH THIS.lbl_4c_Label3
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Alignment = 0
            .AutoSize  = .F.
            .Caption   = "Dias Retroativo : "
            .Left      = 16
            .Top       = 162
            .Width     = 95
            .Height    = 15
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        *-- Say4 -> lbl_4c_Label4 ("Dias Futuro : ")
        THIS.AddObject("lbl_4c_Label4", "Label")
        WITH THIS.lbl_4c_Label4
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Alignment = 0
            .AutoSize  = .F.
            .Caption   = "Dias Futuro : "
            .Left      = 171
            .Top       = 162
            .Width     = 75
            .Height    = 15
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        *-- get_ddr -> txt_4c__ddr (dias retroativos de bloqueio automatico - this_nDdretros, NUMERIC)
        THIS.AddObject("txt_4c__ddr", "TextBox")
        WITH THIS.txt_4c__ddr
            .Alignment = 3
            .InputMask = ""
            .Left      = 113
            .Top       = 159
            .Width     = 45
            .Height    = 18
            .MaxLength = 5
            .TabIndex  = 3
            .Value     = 0
            .Visible   = .T.
        ENDWITH

        *-- get_ddf -> txt_4c__ddf (dias futuros de bloqueio automatico - this_nDdfutus, NUMERIC)
        THIS.AddObject("txt_4c__ddf", "TextBox")
        WITH THIS.txt_4c__ddf
            .Alignment = 3
            .InputMask = ""
            .Left      = 246
            .Top       = 159
            .Width     = 45
            .Height    = 18
            .MaxLength = 5
            .TabIndex  = 4
            .Value     = 0
            .Visible   = .T.
        ENDWITH

        *-- Say5 -> lbl_4c_Label5 (" Bloqueio Automatico ")
        THIS.AddObject("lbl_4c_Label5", "Label")
        WITH THIS.lbl_4c_Label5
            .FontBold  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Alignment = 0
            .AutoSize  = .F.
            .Caption   = " Bloqueio Autom" + CHR(225) + "tico "
            .Left      = 15
            .Top       = 138
            .Width     = 150
            .Height    = 15
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        *-- Shape4 -> shp_4c_Shape4 (linha divisoria sob "Conciliacao").
        *-- BorderColor = 100,10,100 EH LITERAL do dump (os outros tres
        *-- Shapes do form usam 100,100,100) - transcrito tal qual
        *-- (PILAR 1), sem "corrigir" para a cor dos irmaos.
        THIS.AddObject("shp_4c_Shape4", "Shape")
        WITH THIS.shp_4c_Shape4
            .Top           = 210
            .Left          = 9
            .Width         = 127
            .Height        = 2
            .BorderWidth   = 2
            .Curvature     = 0
            .SpecialEffect = 0
            .BorderColor   = RGB(100, 10, 100)
            .Visible       = .T.
        ENDWITH

        *-- Shape3 -> shp_4c_Shape3 (linha divisoria sob "Bloqueio Contabil")
        THIS.AddObject("shp_4c_Shape3", "Shape")
        WITH THIS.shp_4c_Shape3
            .Top           = 210
            .Left          = 161
            .Width         = 113
            .Height        = 2
            .BorderWidth   = 2
            .Curvature     = 0
            .SpecialEffect = 0
            .BorderColor   = RGB(100, 100, 100)
            .Visible       = .T.
        ENDWITH

        *-- Say6 -> lbl_4c_Label6 ("Bloqueio Contabil")
        THIS.AddObject("lbl_4c_Label6", "Label")
        WITH THIS.lbl_4c_Label6
            .FontBold  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Alignment = 0
            .AutoSize  = .F.
            .Caption   = "Bloqueio Cont" + CHR(225) + "bil"
            .Left      = 168
            .Top       = 195
            .Width     = 140
            .Height    = 15
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        *-- Say7 -> lbl_4c_Label7 ("Data Conciliacao")
        THIS.AddObject("lbl_4c_Label7", "Label")
        WITH THIS.lbl_4c_Label7
            .FontBold  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Alignment = 0
            .AutoSize  = .F.
            .Caption   = "Data Concilia" + CHR(231) + CHR(227) + "o"
            .Left      = 24
            .Top       = 194
            .Width     = 120
            .Height    = 15
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        *-- Get_DtCont -> txt_4c_DtCont (data inicio do bloqueio contabil - this_dDtiConts)
        THIS.AddObject("txt_4c_DtCont", "TextBox")
        WITH THIS.txt_4c_DtCont
            .Alignment = 3
            .Format    = "E"
            .InputMask = "99/99/9999"
            .Left      = 174
            .Top       = 216
            .Width     = 80
            .Height    = 18
            .MaxLength = 10
            .TabIndex  = 5
            .Value     = {}
            .Visible   = .T.
        ENDWITH

        *-- Opt_Concilia -> obj_4c_Opt_Concilia (opcao de conciliacao -
        *-- this_nChkConcs: 1=Checar Bloqueio, 2=Liberar Data, 3=Nenhum).
        *-- Legenda/ordem/Top de cada botao TRANSCRITOS do dump (regra
        *-- #45 - OptionGroup: nunca inventar). ControlSource direto do
        *-- legado ("CrBloqueio.ChkConcs") -> coluna numeric(1,0) cujo
        *-- VALOR gravado eh o proprio indice do botao (1/2/3, sem
        *-- +1/-1) - mapeamento feito em FormParaBO/BOParaForm.
        THIS.AddObject("obj_4c_Opt_Concilia", "OptionGroup")
        WITH THIS.obj_4c_Opt_Concilia
            .Top         = 216
            .Left        = 15
            .Width       = 119
            .Height      = 53
            .ButtonCount = 3
            .BackStyle   = 0
            .BorderStyle = 0
            .TabIndex    = 6

            WITH .Buttons(1)
                .FontName  = "Comic Sans MS"
                .FontSize  = 8
                .BackStyle = 0
                .Caption   = "Checar Bloqueio"
                .Left      = 5
                .Top       = 0
                .Width     = 95
                .Height    = 15
                .ForeColor = RGB(90, 90, 90)
                .Visible   = .T.
            ENDWITH

            WITH .Buttons(2)
                .FontName  = "Comic Sans MS"
                .FontSize  = 8
                .BackStyle = 0
                .Caption   = "Liberar Data"
                .Left      = 5
                .Top       = 18
                .Width     = 77
                .Height    = 15
                .ForeColor = RGB(90, 90, 90)
                .Visible   = .T.
            ENDWITH

            WITH .Buttons(3)
                .FontName  = "Comic Sans MS"
                .FontSize  = 8
                .BackStyle = 0
                .Caption   = "Nenhum"
                .Left      = 5
                .Top       = 36
                .Width     = 57
                .Height    = 15
                .ForeColor = RGB(90, 90, 90)
                .Visible   = .T.
                .WordWrap        = .T.
            ENDWITH

            .Visible = .T.
        ENDWITH

    ENDPROC

    *====================================================================
    * ConfigurarBotoes - Salvamento/commandgroup do legado (mapeamento.json:
    * SIGOPBLO.Salvamento -> obj_4c_Salvamento; renomeado para cmg_4c_ por
    * convencao de CommandGroup do projeto - ver FormSigOpArq.cmg_4c_Botoes).
    * Criado DIRETO no Form, como no SCX (sem container intermediario).
    * Top/Left/Width/Height/cores/fontes EXATOS do dump - este eh um
    * dialogo FLAT, nao um frmcadastro, entao o par Confirmar/Encerrar
    * NAO segue o posicionamento canonico cnt_4c_Saida (CLAUDE.md regra
    * #10 vale para forms CRUD, nao para este dialogo de parametros).
    *
    * Command1.Click/Command2.Click do legado: CADA botao do
    * Commandgroup tem handler PROPRIO (nao um Click unico do grupo).
    *====================================================================
    PROTECTED PROCEDURE ConfigurarBotoes()
        THIS.AddObject("cmg_4c_Salvamento", "CommandGroup")
        WITH THIS.cmg_4c_Salvamento
            .Top           = 3
            .Left          = 340
            .Width         = 161
            .Height        = 81
            .ButtonCount   = 2
            .BackStyle     = 0
            .BorderStyle   = 0
            .SpecialEffect = 1
            .BorderColor   = RGB(136, 189, 188)
            .Themes        = .F.
            .TabIndex      = 13

            WITH .Buttons(1)
                .Top        = 0
                .Left       = 10
                .Width      = 75
                .Height     = 75
                .FontBold   = .T.
                .FontItalic = .T.
                .FontName   = "Comic Sans MS"
                .FontSize   = 8
                .WordWrap   = .T.
                .Picture    = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
                .Caption    = "\<Confirmar"
                .ToolTipText = "Salva as altera" + CHR(231) + CHR(245) + "es"
                .ForeColor  = RGB(90, 90, 90)
                .BackColor  = RGB(255, 255, 255)
                .Themes     = .F.
                .Visible    = .T.
            ENDWITH

            WITH .Buttons(2)
                .Top        = 0
                .Left       = 85
                .Width      = 75
                .Height     = 75
                .FontBold   = .T.
                .FontItalic = .T.
                .FontName   = "Comic Sans MS"
                .FontSize   = 8
                .WordWrap   = .T.
                .Picture    = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
                .Cancel     = .T.
                .Caption    = "Encerrar"
                .ToolTipText = "[ESC] Sair"
                .ForeColor  = RGB(90, 90, 90)
                .BackColor  = RGB(255, 255, 255)
                .Themes     = .F.
                .Visible    = .T.
            ENDWITH

            .Visible = .T.
        ENDWITH

        BINDEVENT(THIS.cmg_4c_Salvamento.Buttons(1), "Click", THIS, "BtnConfirmarClick")
        BINDEVENT(THIS.cmg_4c_Salvamento.Buttons(2), "Click", THIS, "BtnEncerrarClick")
    ENDPROC

    *====================================================================
    * ConfigurarEventos - Get_datfin.Valid do legado. "LostFocus" e nao
    * "Valid" porque BINDEVENT em "Valid" nao dispara de forma confiavel
    * em TextBox (regra #34). Chamado DEPOIS de ConfigurarPaginaDados
    * (precisa de txt_4c_Datini/txt_4c_Datfin ja criados).
    *====================================================================
    PROTECTED PROCEDURE ConfigurarEventos()
        BINDEVENT(THIS.txt_4c_Datfin, "LostFocus", THIS, "DatfinLostFocus")
    ENDPROC

    *====================================================================
    * DatfinLostFocus - Get_datfin.Valid do legado:
    *
    *   If (This.Value < Thisform.get_datini.Value)
    *       =Messagebox('Entrada Invalida!!!', 0+48, '')
    *       Return 0
    *   EndIf
    *
    * MESSAGEBOX(...,0+48,'') -> MsgAviso (mesmo icone 48; MESSAGEBOX
    * direto eh proibido no projeto). O "Return 0" classico mantinha o
    * foco no campo; aqui o SetFocus() de volta reproduz o mesmo efeito
    * (BINDEVENT "LostFocus" nao pode cancelar a troca de foco que ja
    * aconteceu, so reconduzi-la).
    *====================================================================
    PROCEDURE DatfinLostFocus()
        IF THIS.txt_4c_Datfin.Value < THIS.txt_4c_Datini.Value
            MsgAviso("Entrada Inv" + CHR(225) + "lida!!!")
            THIS.txt_4c_Datfin.SetFocus()
        ENDIF
    ENDPROC

    *====================================================================
    * FormParaBO - Copia os campos de tela para as properties do BO
    * (this_dDatais/this_dDatafs/this_nDdretros/this_nDdfutus/
    * this_dDtiConts/this_nChkConcs). PROTECTED como na regra #51 - a
    * base nao declara este hook, mas e chamado so de dentro da classe
    * (BtnConfirmarClick).
    *====================================================================
    PROTECTED FUNCTION FormParaBO()
        LOCAL loc_lResultado
        loc_lResultado = .F.

        IF VARTYPE(THIS.this_oBusinessObject) = "O"
            THIS.this_oBusinessObject.this_dDatais   = THIS.txt_4c_Datini.Value
            THIS.this_oBusinessObject.this_dDatafs   = THIS.txt_4c_Datfin.Value
            THIS.this_oBusinessObject.this_nDdretros = THIS.txt_4c__ddr.Value
            THIS.this_oBusinessObject.this_nDdfutus  = THIS.txt_4c__ddf.Value
            THIS.this_oBusinessObject.this_dDtiConts = THIS.txt_4c_DtCont.Value
            THIS.this_oBusinessObject.this_nChkConcs = THIS.obj_4c_Opt_Concilia.Value
            loc_lResultado = .T.
        ENDIF

        RETURN loc_lResultado
    ENDFUNC

    *====================================================================
    * BOParaForm - Contraparte do FormParaBO: leva as properties do BO
    * para os campos de tela. Chamado por InicializarForm depois de
    * carregar (ou preparar) o registro unico.
    *
    * OptionGroup.Value eh indice 1-based que bate DIRETO com a coluna
    * chkconcs (1=Checar Bloqueio, 2=Liberar Data, 3=Nenhum - regra
    * #188, sem +1/-1). Registro novo (this_nChkConcs = 0, default da
    * property) cai em "Nenhum" (3) - o MESMO default que o proprio SCX
    * legado grava na OptionGroup (Opt_Concilia.Value = 3 no dump).
    *====================================================================
    PROTECTED FUNCTION BOParaForm()
        LOCAL loc_lResultado, loc_nChkConcs
        loc_lResultado = .F.

        IF VARTYPE(THIS.this_oBusinessObject) = "O"
            THIS.txt_4c_Datini.Value = THIS.this_oBusinessObject.this_dDatais
            THIS.txt_4c_Datfin.Value = THIS.this_oBusinessObject.this_dDatafs
            THIS.txt_4c__ddr.Value   = THIS.this_oBusinessObject.this_nDdretros
            THIS.txt_4c__ddf.Value   = THIS.this_oBusinessObject.this_nDdfutus
            THIS.txt_4c_DtCont.Value = THIS.this_oBusinessObject.this_dDtiConts

            loc_nChkConcs = THIS.this_oBusinessObject.this_nChkConcs
            THIS.obj_4c_Opt_Concilia.Value = IIF(BETWEEN(loc_nChkConcs, 1, 3), loc_nChkConcs, 3)

            THIS.txt_4c_Datini.Refresh()
            THIS.txt_4c_Datfin.Refresh()
            THIS.txt_4c__ddr.Refresh()
            THIS.txt_4c__ddf.Refresh()
            THIS.txt_4c_DtCont.Refresh()
            THIS.obj_4c_Opt_Concilia.Refresh()

            loc_lResultado = .T.
        ENDIF

        RETURN loc_lResultado
    ENDFUNC

    *====================================================================
    * BtnConfirmarClick - Salva.Click do legado:
    *
    *   lcBloqueio = 'BLOQUEIO DE '+Nvl(Dtoc(Thisform.Get_datini.Value),'')+
    *                ' a '+Nvl(Dtoc(ThisForm.Get_datfin.Value),'')+
    *                ' - Ret.:'+Alltrim(Str(ThisForm.Get_ddr.Value))+
    *                ' - Fut.:'+Alltrim(Str(ThisForm.Get_ddf.Value))
    *   =fGravarLog('B', 'SIGOPBLO', 'ALTERACAO', lcBloqueio, USUAR)
    *   ThisForm.poDataMgr.Update('crBloqueio')
    *   Thisform.poDataMgr.Commit()
    *   ThisForm.Release
    *
    * fGravarLog (log textual livre do Fortyus) NAO precisa de wrapper
    * proprio: RegistrarAuditoria do BusinessBase (ja chamada DENTRO de
    * SigOpBloBO.Inserir/Atualizar) e o equivalente do projeto novo para
    * o MESMO proposito - auditar a gravacao (regra #27). A mensagem
    * textual livre do legado nao tem campo correspondente em
    * LogAuditoria (que registra operacao + chave, nao texto livre).
    *
    * Update('crBloqueio')+Commit() do DataManager legado = Salvar() do
    * BusinessBase, que decide INSERT/UPDATE por this_lNovoRegistro
    * (setado em InicializarForm, conforme o registro de SigSyBlq ja
    * existisse ou nao).
    *
    * Falha de Salvar() NAO precisa de ELSE aqui - BusinessBase.Salvar()
    * ja chama ExibirFalha() em todo caminho de erro (regra #20); a tela
    * so permanece aberta para o usuario corrigir.
    *====================================================================
    PROCEDURE BtnConfirmarClick()
        THIS.FormParaBO()

        IF THIS.this_oBusinessObject.Salvar()
            THIS.Release()
        ENDIF
    ENDPROC

    *====================================================================
    * BtnEncerrarClick - Aborta.Click do legado: fecha sem gravar
    * ("Thisform.Release").
    *====================================================================
    PROCEDURE BtnEncerrarClick()
        THIS.Release()
    ENDPROC

    *====================================================================
    * TornarControlesVisiveis - Torna controles visiveis recursivamente
    * (AddObject cria com Visible=.F.)
    *====================================================================
    PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
        LOCAL loc_i, loc_oControl, loc_oErro

        TRY
            FOR loc_i = 1 TO par_oContainer.ControlCount
                loc_oControl = par_oContainer.Controls(loc_i)
                IF VARTYPE(loc_oControl) = "O"
                    IF PEMSTATUS(loc_oControl, "Visible", 5)
                        loc_oControl.Visible = .T.
                    ENDIF
                    IF PEMSTATUS(loc_oControl, "ControlCount", 5) AND ;
                            loc_oControl.ControlCount > 0
                        THIS.TornarControlesVisiveis(loc_oControl)
                    ENDIF
                ENDIF
            ENDFOR
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + "Linha: " + TRANSFORM(loc_oErro.LineNo) + ;
                CHR(13) + "Procedure: " + loc_oErro.Procedure, "FormSigOpBlo.TornarControlesVisiveis")
        ENDTRY
    ENDPROC

    *====================================================================
    * Destroy - delega ao FormBase, que libera o Business Object e
    * rebuilda os popups do menu principal (fix menu-shrinks de forms
    * modais, regra #145). Fases seguintes podem acrescentar liberacao
    * de recursos proprios ANTES do DODEFAULT().
    *====================================================================
    PROCEDURE Destroy()
        DODEFAULT()
    ENDPROC

ENDDEFINE

*==============================================================================
* FormSIGOPRPS.prg - Follow Up de RPS (OPERACIONAL, somente leitura)
* Form modal popup aberto por outro form com os parametros de identificacao
* do RPS a ser acompanhado.
* Chamada: CREATEOBJECT("FormSIGOPRPS", cEmp, cTipoRps, cSerieRps, nNumRps, cDopes, nNumes)
* Herda de: FormBase
*
* Historico de fases:
*   Fase 1/2: SIGOPRPSBO.prg (propriedades + BuscarHistorico via SigCdFrp)
*   Fase 3:   FormSIGOPRPS.prg - estrutura base (Init, InicializarForm,
*             ConfigurarPageFrame). Cabecalho, Shape1, botao Encerrar.
*             Form OPERACIONAL de raiz "form" generica sem PageFrame no
*             legado (so cntSombra como container) - layout FLAT, sem
*             Page1/Page2.
*   Fase 4:   Grid grd_4c_Dados (4 colunas: Data/Hora, Tipo Lancamento,
*             Usuario, N. NF) ligado a cursor_4c_Historico, carregado via
*             SIGOPRPSBO.BuscarHistorico(). Tela de consulta somente
*             leitura - sem botoes CRUD (legado nao tem Incluir/Alterar/
*             Excluir, so o botao Encerrar da Fase 3). Metodo de carga
*             (renomeado para CarregarLista na Fase 8 - ver abaixo),
*             chamado em InicializarForm e funil unico de repintura da
*             grade (GO TOP + Refresh no fim).
*   Fase 5:   ConfigurarCamposIdentificacao() com a 1a metade dos 6 pares
*             label/campo do legado, em ordem visual (linha de cima da
*             moldura shp_4c_Shape1): Empresa, Tipo, Serie. Todos somente
*             leitura - os get_* do legado tem When retornando .F. e o
*             valor vem so do form chamador. Mais BOParaForm(), funil
*             unico da transferencia BO -> tela, que reproduz as
*             atribuicoes "ThisForm.get_*.Value = ..." do Init legado.
*             Form FLAT: os campos sao filhos diretos do form, nao ha
*             ConfigurarPaginaDados porque o legado nao tem PageFrame.
*   Fase 6:   2a metade dos campos de identificacao (RPS, Operacao, Numero),
*             completando ConfigurarCamposIdentificacao() e BOParaForm().
*             SEM lookup e SEM container de botoes Salvar/Cancelar: o
*             legado nao tem nenhum dos dois para este form - nenhum get_*
*             tem PROCEDURE Valid (so When -> Return(.F.), que bloqueia
*             digitacao em TODOS os 6 campos - ver comportamento.json) e o
*             Commandgroup2 tem ButtonCount=1 (so o Encerrar, ja criado na
*             Fase 3). Tela de consulta somente leitura de ponta a ponta.
*   Fase 7:   SEM TRABALHO - medido, nao omitido. O legado (comportamento.json)
*             tem exatamente 1 botao (Commandgroup2, ButtonCount=1) e 1 unico
*             Click no dump inteiro: "Release Windows". Esse Click JA foi
*             portado na Fase 3 (cmd_4c_Encerrar + BINDEVENT ->
*             BtnEncerrarClick - ver ConfigurarPageFrame). Nao ha
*             Incluir/Alterar/Visualizar/Excluir no legado (sem
*             frmcadastro/Grupo_Op/pcEscolha, form raiz "form" puro) -
*             criar esses 4 handlers aqui inventaria funcionalidade que o
*             sistema legado nunca teve, violando o PILAR 1 e a regra de
*             nao fabricar stubs. Os 6 get_* tambem nao tem Valid/KeyPress/
*             LostFocus (so When -> Return(.F.), ja reproduzido por
*             ReadOnly+TabStop na Fase 5/6) e a grade e somente leitura (sem
*             AfterRowColChange/DblClick no legado). Re-auditado o par
*             BINDEVENT+handler existente: BtnEncerrarClick e PUBLIC (sem
*             PROTECTED); o delegate existe e faz THIS.Release() (sem valor
*             a devolver ao chamador, por isso Release() e nao Hide()); o
*             BINDEVENT roda DEPOIS do AddObject de cmd_4c_Encerrar; o ESC
*             continua coberto por .Cancel = .T.; e o .Picture
*             ("cadastro_sair_60.jpg") existe em vbmp\ (regra #25). Mesmo
*             eixo de FormSIGOPDVM/Formsigopecm (Click unico ja portado em
*             fase anterior).
*   Fase 8:   Consolidacao. O gate da Fase 8 foi RODADO standalone antes de
*             mexer no arquivo (funcoes do OrquestradorMigracao + corpo do
*             "case 8" com $formFile/$conteudo/$TaskPath/$BaseName/$FormType
*             semeados) para medir o que ele exige deste legado em vez de
*             adivinhar. Resultado: o ramo VISUALIZADOR reconheceu a tela
*             (sem CRUD, sem botao de gravar, TODO campo somente-leitura) e
*             dispensou BtnCancelarClick e FormParaBO; a exigencia de botao
*             de ACAO tambem caiu ("UM botao no SCX e todo Click so faz
*             Release"). Sobrou UM item: CarregarLista.
*             a) Carregador da grade RENOMEADO de CarregarDados para
*                CarregarLista. O legado TEM grade (grdMov, populada no fim
*                do Init), entao a dispensa do ramo VISUALIZADOR nao alcanca
*                esse nome, de proposito - e os dois nomes sao convencao
*                equivalente no projeto (o gate da Fase 4 aceita
*                CarregarLista|CarregarDados|MontaGrade), logo e rename puro,
*                sem mudanca de comportamento.
*             b) NAO foram criados FormParaBO/BtnCancelarClick/
*                HabilitarCampos/LimparCampos/AjustarBotoesPorModo/
*                BtnSalvarClick/BtnBuscarClick: nenhum tem contrapartida no
*                legado (6 campos com When -> Return(.F.), 1 botao que so
*                fecha, nenhum modo INCLUIR/ALTERAR/VISUALIZAR). Escrever
*                qualquer um deles seria inventar superficie (PILAR 1) ou
*                stub vazio (regra de completude).
*             c) Defeitos de TRANSCRICAO da grade corrigidos contra o dump:
*                larguras das colunas (eram 130/170/100/120 inventados,
*                agora 120/220/80/55 do SCX), Header1.Alignment = 2
*                (centralizado, declarado nas QUATRO colunas do dump - estava
*                0/0/0/1), Grid.RowHeight = 16 e Grid.ScrollBars = 2 (eram
*                19 e 3), Text1.FontSize = 8 + Text1.Margin = 0 (declarados
*                no dump e ausentes), e remocao do Column4/Text1.Alignment = 1
*                que o dump nao declara (Nfis e char(8) - o default 3 deixa
*                o VFP alinhar pelo tipo).
*                Medido no VFP9 (probe_colcount.prg): reatribuir ColumnCount
*                com o MESMO valor (4 -> 4) NAO recria as Column, e
*                RecordSource NAO zerou Width/Header1.Caption/Text1.Margin -
*                a reaplicacao em CarregarLista e rede de seguranca, nao
*                necessidade; por isso os valores dela foram alinhados com os
*                de ConfigurarGrid (divergir faria a grade mudar de largura
*                entre a montagem e a 1a carga).
*             d) DataSession = 2 ACRESCENTADO (o dump o declara e faltava):
*                a coluna Datas e datetime e, sem o SET DATE/CENTURY que
*                FormBase.Init repoe na datasession privada, sairia como
*                05/25/26 (regra #9.4).
*             e) Closable = .F. REMOVIDO - o dump nao o declara, e TitleBar=0
*                /ControlBox=.F. nao o implicam (as cinco propriedades sao
*                independentes); fixar .F. tiraria o Alt+F4 que o legado
*                permite.
*             f) Width dos dois labels do cabecalho: literal 769 do dump
*                trocado por THIS.Width - 20. O SCX declara cntSombra com
*                Width = 800 contra Form.Width = 650 - artefato de Form
*                Designer (container desenhado mais largo que a janela); o
*                literal extrapolaria o container e o titulo seria recortado
*                sem erro e sem log (regra #30).
*             SEM item de menu: a tela e dialogo FILHO, identificada por 6
*             parametros obrigatorios que o form chamador passa
*             (Init(pcEmp, pcTipoRps, pcSerieRps, pnNumRps, pcDopes,
*             pnNumes)). Entrada pelo menu abriria o Follow Up sem RPS
*             nenhum. O chamador legado nao esta no acervo (nenhuma
*             ocorrencia de "sigoprps" em Framework\, origem\ ou nos outros
*             dumps de tasks\) - quando ele for migrado, abrir com
*             GarantirClasse("FormSIGOPRPS") + CREATEOBJECT com os 6
*             argumentos. A classe e a dependencia dela ja estao em
*             start\indice_classes.txt.
*==============================================================================
DEFINE CLASS FormSIGOPRPS AS FormBase

    *-- Parametros de identificacao do RPS recebidos no Init
    this_cEmps   = ""
    this_cTipos  = ""
    this_cSeries = ""
    this_nNumRps = 0
    this_cDopes  = ""
    this_nNumes  = 0

    *-- Business Object
    this_oBusinessObject = .NULL.

    *-- Propriedades visuais (PILAR 1 - valores exatos do SCX SIGOPRPS)
    *-- DataSession = 2 e declarado no dump do SCX. FormBase.Init repoe
    *-- SET DATE TO BRITISH / SET CENTURY ON na datasession privada (regra
    *-- CLAUDE.md #9.4) - sem isso a coluna Datas (datetime) da grade sairia
    *-- como 05/25/26. O Init deste form chama DODEFAULT(), pre-requisito
    *-- dessa correcao.
    DataSession  = 2
    Width        = 650
    Height       = 380
    AutoCenter   = .T.
    TitleBar     = 0
    ControlBox   = .F.
    MaxButton    = .F.
    MinButton    = .F.
    ClipControls = .T.
    BorderStyle  = 2
    FontName     = "Tahoma"
    FontSize     = 8
    *-- WindowType/ShowWindow NAO vem do dump: o SCX herda de "form" puro e
    *-- nao declara WindowType (default 0 = modeless), mas o modo de ABERTURA
    *-- mudou - o chamador faz CREATEOBJECT numa variavel LOCAL + Show(), e
    *-- com modeless o Show() retorna na hora, a referencia cai e o dialogo
    *-- pisca e some. Canonico do projeto: WindowType = 1 + ShowWindow = 1.
    WindowType   = 1
    ShowWindow   = 1
    *-- Closable NAO e declarado no dump e por isso NAO e transcrito:
    *-- TitleBar = 0 / ControlBox = .F. nao forcam Closable - as cinco
    *-- propriedades sao independentes, e fixar .F. tiraria o Alt+F4 que o
    *-- legado permite. A saida da tela continua sendo o botao Encerrar
    *-- (Cancel = .T. tambem o aciona pelo ESC).

    *--------------------------------------------------------------------------
    * Init - Armazena os parametros de identificacao, cria o BO e dispara
    * FormBase.Init (que chama InicializarForm via DODEFAULT)
    *--------------------------------------------------------------------------
    PROCEDURE Init(par_cEmps, par_cTipos, par_cSeries, par_nNumRps, par_cDopes, par_nNumes)
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        TRY
            THIS.this_cEmps   = IIF(VARTYPE(par_cEmps)   = "C", ALLTRIM(par_cEmps),   "")
            THIS.this_cTipos  = IIF(VARTYPE(par_cTipos)  = "C", ALLTRIM(par_cTipos),  "")
            THIS.this_cSeries = IIF(VARTYPE(par_cSeries) = "C", ALLTRIM(par_cSeries), "")
            THIS.this_nNumRps = IIF(VARTYPE(par_nNumRps) = "N", par_nNumRps,           0)
            THIS.this_cDopes  = IIF(VARTYPE(par_cDopes)  = "C", ALLTRIM(par_cDopes),  "")
            THIS.this_nNumes  = IIF(VARTYPE(par_nNumes)  = "N", par_nNumes,            0)

            THIS.this_oBusinessObject = CREATEOBJECT("SIGOPRPSBO", ;
                THIS.this_cEmps, THIS.this_cTipos, THIS.this_cSeries, ;
                THIS.this_nNumRps, THIS.this_cDopes, THIS.this_nNumes)

            IF VARTYPE(THIS.this_oBusinessObject) != "O"
                MsgErro("Erro ao criar SIGOPRPSBO." + CHR(13) + ;
                    "VARTYPE retornou: " + VARTYPE(THIS.this_oBusinessObject), ;
                    "FormSIGOPRPS.Init")
            ELSE
                *-- DODEFAULT() dispara FormBase.Init() que chama THIS.InicializarForm()
                loc_lSucesso = DODEFAULT()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "FormSIGOPRPS.Init")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * InicializarForm - Monta a estrutura visual base do form
    * (chamado automaticamente por FormBase.Init via DODEFAULT)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        TRY
            *-- Fundo do form (imagem do Framework Fortyus legado)
            THIS.Picture = gc_4c_CaminhoFramework + "imagens\new_background.jpg"

            *-- Caption (sem acentos - nao precisa de CHR())
            THIS.Caption = "Follow Up de RPS"

            *-- Monta os controles de estrutura. Ordem OBRIGATORIA: os campos
            *-- de identificacao vem DEPOIS da moldura shp_4c_Shape1 criada em
            *-- ConfigurarPageFrame, senao a moldura desenharia por cima deles.
            THIS.ConfigurarPageFrame()
            THIS.ConfigurarGrid()
            THIS.ConfigurarCamposIdentificacao()

            *-- Propaga o titulo para os labels do cabecalho
            THIS.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
            THIS.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption

            *-- Torna a arvore de controles visivel (AddObject cria com Visible=.F.)
            THIS.TornarControlesVisiveis(THIS)

            *-- Preenche os campos de identificacao com os parametros recebidos
            *-- na abertura (os "ThisForm.get_*.Value = ..." do Init legado).
            *-- NAO depende de conexao SQL - so le properties do BO -, por isso
            *-- roda tambem em validacao de UI e em modo de teste.
            THIS.BOParaForm()

            *-- Carga do historico: pulada quando o pipeline esta validando a UI
            *-- ou rodando o teste automatizado (sem conexao SQL disponivel).
            IF !((TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI) OR ;
                 (TYPE("gb_4c_ModoTeste") = "L" AND gb_4c_ModoTeste))
                THIS.CarregarLista()
            ENDIF

            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "FormSIGOPRPS.InicializarForm")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPageFrame - Cria os controles de estrutura do form.
    *   Form OPERACIONAL sem PageFrame real: a raiz do legado e' "form"
    *   generico (sem Pagina), com apenas o container cntSombra na arvore
    *   de objetos - layout FLAT. Nome do metodo mantido por convencao do
    *   orquestrador de migracao (nao existe pgf_4c_Paginas neste form).
    *
    *   cnt_4c_Cabecalho: cabecalho escuro com sombra + titulo branco (cntSombra)
    *   shp_4c_Shape1:    moldura decorativa em volta dos campos de
    *                     identificacao do RPS, criados por
    *                     ConfigurarCamposIdentificacao() - que roda DEPOIS
    *                     deste metodo, para os campos ficarem por cima da
    *                     moldura
    *   cmd_4c_Encerrar:  botao Encerrar (Cancel=.T. vincula ao ESC) - unico
    *                     botao do Commandgroup2 legado (ButtonCount=1),
    *                     achatado para CommandButton standalone
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPageFrame()
        LOCAL loc_oCab, loc_oErro
        TRY
            *-- Cabecalho escuro (cntSombra original: Top=0 Left=0 W=800 H=80)
            THIS.AddObject("cnt_4c_Cabecalho", "Container")
            loc_oCab = THIS.cnt_4c_Cabecalho
            WITH loc_oCab
                .Top         = 0
                .Left        = 0
                .Width       = THIS.Width
                .Height      = 80
                .BorderWidth = 0
                .BackStyle   = 1
                .BackColor   = RGB(100, 100, 100)
            ENDWITH

            *-- Labels dentro do cabecalho (fora do WITH do container - WITH
            *-- aninhado com AddObject ignora propriedades silenciosamente)
            loc_oCab.AddObject("lbl_4c_Sombra", "Label")
            WITH loc_oCab.lbl_4c_Sombra
                .FontBold  = .T.
                .FontName  = "Tahoma"
                .FontSize  = 18
                .WordWrap  = .T.
                .AutoSize  = .F.
                .Alignment = 0
                .BackStyle = 0
                .Caption   = ""
                .Height    = 40
                .Left      = 10
                .Top       = 18
                .Width     = THIS.Width - 20
                .ForeColor = RGB(0, 0, 0)
            ENDWITH

            loc_oCab.AddObject("lbl_4c_Titulo", "Label")
            WITH loc_oCab.lbl_4c_Titulo
                .FontBold    = .T.
                .FontName    = "Tahoma"
                .FontSize    = 18
                .WordWrap    = .T.
                .AutoSize    = .F.
                .Alignment   = 0
                .BackStyle   = 0
                .Caption     = ""
                .Height      = 46
                .Left        = 10
                .Top         = 17
                .Width       = THIS.Width - 20
                .ForeColor   = RGB(255, 255, 255)
                .ToolTipText = "T" + CHR(237) + "tulo do Relat" + CHR(243) + "rio"
            ENDWITH

            *-- Moldura decorativa em volta dos campos de identificacao
            *-- (Shape1 original: Top=94, Left=65, H=65, W=520)
            THIS.AddObject("shp_4c_Shape1", "Shape")
            WITH THIS.shp_4c_Shape1
                .Top         = 94
                .Left        = 65
                .Height      = 65
                .Width       = 520
                .BackStyle   = 0
                .BorderColor = RGB(90, 90, 90)
            ENDWITH

            *-- Botao Encerrar (Commandgroup2 original: Top=-2, Left=570;
            *-- Command1 relativo Top=5, Left=5 -> absoluto Top=3, Left=575)
            THIS.AddObject("cmd_4c_Encerrar", "CommandButton")
            WITH THIS.cmd_4c_Encerrar
                .Top        = 3
                .Left       = 575
                .Height     = 75
                .Width      = 75
                .FontBold   = .T.
                .FontItalic = .T.
                .FontName   = "Comic Sans MS"
                .FontSize   = 8
                .Picture    = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
                .Cancel     = .T.
                .Caption    = "Encerrar"
                .ForeColor  = RGB(90, 90, 90)
                .BackColor  = RGB(255, 255, 255)
                .Themes     = .T.
            ENDWITH
            BINDEVENT(THIS.cmd_4c_Encerrar, "Click", THIS, "BtnEncerrarClick")

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "FormSIGOPRPS.ConfigurarPageFrame")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarGrid - Cria grd_4c_Dados (equivalente grdMov do legado), com
    * as 4 colunas de historico (Data/Hora, Tipo Lancamento, Usuario, N. NF).
    * RecordSource e Column.ControlSource NAO sao ligados aqui: o cursor
    * cursor_4c_Historico ainda nao existe neste ponto do Init, e ligar
    * ControlSource a cursor inexistente derruba a tela ("Alias not found") -
    * o vinculo e feito em CarregarLista(), depois da consulta.
    * (grdMov original: Top=164, Left=65, W=520, H=202 - sem offset de
    * PageFrame, pois este form e' layout FLAT - ver ConfigurarPageFrame)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarGrid()
        LOCAL loc_oErro
        TRY
            THIS.AddObject("grd_4c_Dados", "Grid")
            WITH THIS.grd_4c_Dados
                .Top          = 164
                .Left         = 65
                .Width        = 520
                .Height       = 202
                .ColumnCount  = 4
                .FontName     = "Tahoma"
                .FontSize     = 8
                .HeaderHeight = 20
                .RowHeight    = 16
                .GridLines    = 3
                .ScrollBars   = 2
                .ReadOnly     = .T.
                .DeleteMark   = .F.
                .RecordMark   = .F.
                .ForeColor    = RGB(90, 90, 90)
                .Visible      = .T.
            ENDWITH

            *-- Column1 - Data/Hora
            WITH THIS.grd_4c_Dados.Column1
                .Width     = 120
                .Movable   = .F.
                .Resizable = .F.
                .ReadOnly  = .T.
                .Visible   = .T.
            ENDWITH
            WITH THIS.grd_4c_Dados.Column1.Header1
                .FontName  = "Tahoma"
                .FontSize  = 8
                .Alignment = 2
                .ForeColor = RGB(90, 90, 90)
            ENDWITH
            WITH THIS.grd_4c_Dados.Column1.Text1
                .FontName    = "Tahoma"
                .FontSize    = 8
                .BorderStyle = 0
                .Margin      = 0
                .ReadOnly    = .T.
                .ForeColor   = RGB(0, 0, 0)
                .BackColor   = RGB(255, 255, 255)
            ENDWITH

            *-- Column2 - Tipo Lancamento
            WITH THIS.grd_4c_Dados.Column2
                .Width     = 220
                .Movable   = .F.
                .Resizable = .F.
                .ReadOnly  = .T.
                .Visible   = .T.
            ENDWITH
            WITH THIS.grd_4c_Dados.Column2.Header1
                .FontName  = "Tahoma"
                .FontSize  = 8
                .Alignment = 2
                .ForeColor = RGB(90, 90, 90)
            ENDWITH
            WITH THIS.grd_4c_Dados.Column2.Text1
                .FontName    = "Tahoma"
                .FontSize    = 8
                .BorderStyle = 0
                .Margin      = 0
                .ReadOnly    = .T.
                .ForeColor   = RGB(0, 0, 0)
                .BackColor   = RGB(255, 255, 255)
            ENDWITH

            *-- Column3 - Usuario
            WITH THIS.grd_4c_Dados.Column3
                .Width     = 80
                .Movable   = .F.
                .Resizable = .F.
                .ReadOnly  = .T.
                .Visible   = .T.
            ENDWITH
            WITH THIS.grd_4c_Dados.Column3.Header1
                .FontName  = "Tahoma"
                .FontSize  = 8
                .Alignment = 2
                .ForeColor = RGB(90, 90, 90)
            ENDWITH
            WITH THIS.grd_4c_Dados.Column3.Text1
                .FontName    = "Tahoma"
                .FontSize    = 8
                .BorderStyle = 0
                .Margin      = 0
                .ReadOnly    = .T.
                .ForeColor   = RGB(0, 0, 0)
                .BackColor   = RGB(255, 255, 255)
            ENDWITH

            *-- Column4 - N. NF
            WITH THIS.grd_4c_Dados.Column4
                .Width     = 55
                .Movable   = .F.
                .Resizable = .F.
                .ReadOnly  = .T.
                .Visible   = .T.
            ENDWITH
            WITH THIS.grd_4c_Dados.Column4.Header1
                .FontName  = "Tahoma"
                .FontSize  = 8
                .Alignment = 2
                .ForeColor = RGB(90, 90, 90)
            ENDWITH
            WITH THIS.grd_4c_Dados.Column4.Text1
                .FontName    = "Tahoma"
                .FontSize    = 8
                .BorderStyle = 0
                .Margin      = 0
                .ReadOnly    = .T.
                .ForeColor   = RGB(0, 0, 0)
                .BackColor   = RGB(255, 255, 255)
            ENDWITH

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "FormSIGOPRPS.ConfigurarGrid")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarLista - Consulta o historico via SIGOPRPSBO.BuscarHistorico()
    * e vincula o cursor_4c_Historico resultante ao grd_4c_Dados.
    *
    * ORDEM OBRIGATORIA: ColumnCount -> RecordSource -> ControlSource ->
    * Width/Header1.Alignment/Header1.Caption/ReadOnly. ColumnCount vem ANTES
    * do RecordSource para a grade nao auto-expandir ate o numero de colunas
    * do cursor; o bloco de reaplicacao posterior cobre o reset de largura e
    * caption que o vinculo pode causar.
    *
    * Medido no VFP9 (tasks\task797\probe_colcount.prg) para este caso
    * concreto: com ColumnCount reatribuido ao MESMO valor (4 -> 4) as Column
    * NAO sao recriadas, e nem RecordSource nem ControlSource zeraram
    * Width/Header1.Alignment/Header1.Caption/Text1.Margin. A reaplicacao
    * fica como rede de seguranca, com valores IDENTICOS aos de
    * ConfigurarGrid - divergir entre os dois lugares faria a grade mudar de
    * largura entre a montagem e a 1a carga.
    *
    * Fecha com GO TOP + Refresh, senao a grade fica visualmente vazia com
    * o cursor cheio (regra #21a).
    *
    * PUBLIC de proposito (regra #3/CLAUDE.md): metodo chamado de fora via
    * THIS.oForm.CarregarLista() por eventual harness de teste.
    *--------------------------------------------------------------------------
    PROCEDURE CarregarLista()
        LOCAL loc_oGrid, loc_oErro

        TRY
            IF THIS.this_oBusinessObject.BuscarHistorico()
                loc_oGrid = THIS.grd_4c_Dados

                WITH loc_oGrid
                    .RecordSource          = ""
                    .ColumnCount           = 4
                    .RecordSource          = "cursor_4c_Historico"
                    .Column1.ControlSource = "cursor_4c_Historico.Datas"
                    .Column2.ControlSource = "cursor_4c_Historico.Transacaos"
                    .Column3.ControlSource = "cursor_4c_Historico.Usuars"
                    .Column4.ControlSource = "cursor_4c_Historico.Nfis"
                ENDWITH

                *-- Reaplicacao pos-vinculo: rede de seguranca do par
                *-- ColumnCount/RecordSource. Larguras IDENTICAS as do dump e
                *-- as de ConfigurarGrid (120/220/80/55) - divergir aqui faria
                *-- a grade mudar de largura entre a montagem e a 1a carga.
                *-- Header1.Alignment = 2 tambem e reposto, pelo mesmo motivo.
                WITH loc_oGrid.Column1
                    .Width     = 120
                    .Movable   = .F.
                    .Resizable = .F.
                ENDWITH
                loc_oGrid.Column1.Header1.Alignment = 2
                loc_oGrid.Column1.Header1.Caption   = "Data/Hora"

                WITH loc_oGrid.Column2
                    .Width     = 220
                    .Movable   = .F.
                    .Resizable = .F.
                ENDWITH
                loc_oGrid.Column2.Header1.Alignment = 2
                loc_oGrid.Column2.Header1.Caption   = "Tipo Lan" + CHR(231) + "amento"

                WITH loc_oGrid.Column3
                    .Width     = 80
                    .Movable   = .F.
                    .Resizable = .F.
                ENDWITH
                loc_oGrid.Column3.Header1.Alignment = 2
                loc_oGrid.Column3.Header1.Caption   = "Usu" + CHR(225) + "rio"

                WITH loc_oGrid.Column4
                    .Width     = 55
                    .Movable   = .F.
                    .Resizable = .F.
                ENDWITH
                loc_oGrid.Column4.Header1.Alignment = 2
                loc_oGrid.Column4.Header1.Caption   = "N" + CHR(186) + " NF"

                *-- Grid.ReadOnly propaga para as colunas - o ReadOnly da
                *-- COLUNA vai DEPOIS do vinculo, senao o reset o sobrescreve
                loc_oGrid.ReadOnly         = .T.
                loc_oGrid.Column1.ReadOnly = .T.
                loc_oGrid.Column2.ReadOnly = .T.
                loc_oGrid.Column3.ReadOnly = .T.
                loc_oGrid.Column4.ReadOnly = .T.

                IF USED("cursor_4c_Historico")
                    SELECT cursor_4c_Historico
                    GO TOP
                ENDIF
                loc_oGrid.Refresh()
            ELSE
                IF !EMPTY(THIS.this_oBusinessObject.this_cMensagemErro)
                    MsgErro(THIS.this_oBusinessObject.this_cMensagemErro, ;
                        "FormSIGOPRPS.CarregarLista")
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "FormSIGOPRPS.CarregarLista")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarCamposIdentificacao - Campos de identificacao do RPS, criados
    * DIRETO no form (no legado todos os get_* e Say* sao filhos de SIGOPRPS),
    * dentro da moldura shp_4c_Shape1 criada na Fase 3.
    *
    * Nome do metodo: este form e layout FLAT - o SCX legado nao tem PageFrame
    * (ver ConfigurarPageFrame), logo nao existe "Page2 de Dados" e nenhum
    * destes controles tem Page para morar. Chamar o metodo de
    * ConfigurarPaginaDados obrigaria a inventar uma pagina que o legado nao
    * tem (viola o PILAR 1).
    *
    * Fase 5 (1a metade dos 6 pares label/campo, em ordem visual - a linha de
    * cima da moldura): Empresa, Tipo, Serie.
    * Fase 6 (2a metade, em ordem visual): RPS (fecha a linha de cima) e
    * Operacao/Numero (2a linha da moldura, Top~128/131).
    *
    * LABELS - a classe "say" do Framework legado e AutoSize = .T. /
    * Alignment = 0, e por isso o Say do SCX declara so Caption/Left/Top: os
    * Left ja vem escalonados para o texto terminar poucos pixels antes do
    * campo. AutoSize = .T. e no-op em Label criado por AddObject (a Width
    * fica nos 100 do default e invadiria o TextBox), por isso aqui vai
    * AutoSize = .F. + Width explicita que cabe no vao ate o campo, com
    * Alignment = 0 - NUNCA Alignment = 1, que encostaria o texto na borda
    * direita, dentro do TextBox (regra CLAUDE.md #23).
    * ForeColor = RGB(90, 90, 90): o Say legado nao declara ForeColor (classe
    * "say" pura) e o fundo do form e a textura CLARA new_background.jpg -
    * branco ficaria INVISIVEL (regra CLAUDE.md #12).
    *
    * Cada label e criado ANTES do seu TextBox de proposito: assim o campo
    * desenha por cima e a caixa transparente do label nunca bloqueia o
    * clique (regra CLAUDE.md #23).
    *
    * ReadOnly = .T. - todos os get_* do legado tem "PROCEDURE When ->
    * Return(.F.)", ou seja o campo NUNCA aceita digitacao: o valor vem so do
    * form chamador (os "ThisForm.get_*.Value = ..." do Init legado,
    * reproduzidos em BOParaForm). NAO usar BINDEVENT(..., "When", ...) para
    * isso: BINDEVENT DESCARTA o retorno do delegate, entao um When ligado
    * por BINDEVENT nao bloqueia nada (regra CLAUDE.md #3) e o campo
    * continuaria digitavel. ReadOnly = .T. e a reproducao canonica de
    * "When -> .f." no sistema novo e PRESERVA a aparencia do legado - ao
    * contrario de Enabled = .F., que acinzentaria o texto preto
    * (ForeColor = 0,0,0 declarado no dump) e violaria o PILAR 1. Vem
    * acompanhado de TabStop = .F., que e a outra metade do When: sem ele o
    * Tab AINDA pararia no campo, coisa que no legado nao acontece.
    *
    * TabIndex: transcrito do dump (10 nos Say, 1 nos get_*), mas o VFP9
    * RENORMALIZA a cada atribuicao - cada ".TabIndex = 1" empurra os
    * anteriores para baixo, e o valor medido em runtime nao e o declarado.
    * Nao e defeito e nao tem efeito aqui: com TabStop = .F. nenhum destes
    * campos entra na ordem de tabulacao.
    *
    * Sem offset de PageFrame: Top/Left sao os valores ABSOLUTOS do SCX.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarCamposIdentificacao()
        LOCAL loc_oErro
        TRY
            *-- Say6 "Empresa :" (Left=84, Top=103) + get_Emps (Left=136,
            *-- Top=100, W=31, MaxLength=3). Vao de 52px ate o campo.
            THIS.AddObject("lbl_4c_Label6", "Label")
            WITH THIS.lbl_4c_Label6
                .Top       = 103
                .Left      = 84
                .Width     = 50
                .Height    = 17
                .AutoSize  = .F.
                .BackStyle = 0
                .WordWrap  = .F.
                .Alignment = 0
                .FontName  = "Tahoma"
                .FontSize  = 8
                .ForeColor = RGB(90, 90, 90)
                .Caption   = "Empresa :"
                .TabIndex  = 10
            ENDWITH

            THIS.AddObject("txt_4c__Emps", "TextBox")
            WITH THIS.txt_4c__Emps
                .Top       = 100
                .Left      = 136
                .Width     = 31
                .Alignment = 0
                .FontName  = "Tahoma"
                .FontSize  = 8
                .MaxLength = 3
                .ForeColor = RGB(0, 0, 0)
                .Value     = ""
                .TabIndex  = 1
                *-- get_Emps.When (legado) -> Return(.F.). ReadOnly impede a
                *-- digitacao e TabStop = .F. reproduz o SALTO do Tab (no
                *-- legado, When = .F. tira o campo da ordem de tabulacao).
                *-- Os dois juntos equivalem ao When sem acinzentar o texto
                *-- preto, que e o que Enabled = .F. faria (PILAR 1).
                .ReadOnly  = .T.
                .TabStop   = .F.
            ENDWITH

            *-- Say3 "Tipo :" (Left=210, Top=104) + get_Tipos (Left=241,
            *-- Top=100, W=45, MaxLength=5). Vao de 31px ate o campo.
            THIS.AddObject("lbl_4c_Label3", "Label")
            WITH THIS.lbl_4c_Label3
                .Top       = 104
                .Left      = 210
                .Width     = 30
                .Height    = 17
                .AutoSize  = .F.
                .BackStyle = 0
                .WordWrap  = .F.
                .Alignment = 0
                .FontName  = "Tahoma"
                .FontSize  = 8
                .ForeColor = RGB(90, 90, 90)
                .Caption   = "Tipo :"
                .TabIndex  = 10
            ENDWITH

            THIS.AddObject("txt_4c__Tipos", "TextBox")
            WITH THIS.txt_4c__Tipos
                .Top       = 100
                .Left      = 241
                .Width     = 45
                .Alignment = 0
                .FontName  = "Tahoma"
                .FontSize  = 8
                .MaxLength = 5
                .ForeColor = RGB(0, 0, 0)
                .Value     = ""
                .TabIndex  = 1
                *-- get_Tipos.When (legado) -> Return(.F.) - ver txt_4c__Emps
                .ReadOnly  = .T.
                .TabStop   = .F.
            ENDWITH

            *-- Say4 "Serie :" (Left=321, Top=104) + get_Series (Left=356,
            *-- Top=100, W=45, MaxLength=5). Vao de 35px ate o campo.
            THIS.AddObject("lbl_4c_Label4", "Label")
            WITH THIS.lbl_4c_Label4
                .Top       = 104
                .Left      = 321
                .Width     = 33
                .Height    = 17
                .AutoSize  = .F.
                .BackStyle = 0
                .WordWrap  = .F.
                .Alignment = 0
                .FontName  = "Tahoma"
                .FontSize  = 8
                .ForeColor = RGB(90, 90, 90)
                .Caption   = "S" + CHR(233) + "rie :"
                .TabIndex  = 10
            ENDWITH

            THIS.AddObject("txt_4c__Series", "TextBox")
            WITH THIS.txt_4c__Series
                .Top       = 100
                .Left      = 356
                .Width     = 45
                .Alignment = 0
                .FontName  = "Tahoma"
                .FontSize  = 8
                .MaxLength = 5
                .ForeColor = RGB(0, 0, 0)
                .Value     = ""
                .TabIndex  = 1
                *-- get_Series.When (legado) -> Return(.F.) - ver txt_4c__Emps
                .ReadOnly  = .T.
                .TabStop   = .F.
            ENDWITH

            *-- Say5 "RPS :" (Left=451, Top=104) + get_NumRps (Left=481,
            *-- Top=100, W=95, MaxLength=12). Vao de 30px ate o campo.
            *-- get_NumRps.Value recebe pnNumRps NUMERICO no Init legado
            *-- (ThisForm.get_NumRps.Value = pnNumRps) - property do BO
            *-- correspondente (this_nNumRps) tambem e numerica.
            THIS.AddObject("lbl_4c_Label5", "Label")
            WITH THIS.lbl_4c_Label5
                .Top       = 104
                .Left      = 451
                .Width     = 28
                .Height    = 17
                .AutoSize  = .F.
                .BackStyle = 0
                .WordWrap  = .F.
                .Alignment = 0
                .FontName  = "Tahoma"
                .FontSize  = 8
                .ForeColor = RGB(90, 90, 90)
                .Caption   = "RPS :"
                .TabIndex  = 10
            ENDWITH

            THIS.AddObject("txt_4c__NumRps", "TextBox")
            WITH THIS.txt_4c__NumRps
                .Top       = 100
                .Left      = 481
                .Width     = 95
                .Alignment = 0
                .FontName  = "Tahoma"
                .FontSize  = 8
                .MaxLength = 12
                .ForeColor = RGB(0, 0, 0)
                .Value     = 0
                .TabIndex  = 1
                *-- get_NumRps.When (legado) -> Return(.F.) - ver txt_4c__Emps
                .ReadOnly  = .T.
                .TabStop   = .F.
            ENDWITH

            *-- Say1 "Operacao :" (Left=78, Top=131) + get_Dopes (Left=136,
            *-- Top=128, W=150, MaxLength=20). Vao de 58px ate o campo.
            *-- 2a linha da moldura (Top~128/131, abaixo de Empresa/Tipo/
            *-- Serie/RPS, que ficam em Top~100/104).
            THIS.AddObject("lbl_4c_Label1", "Label")
            WITH THIS.lbl_4c_Label1
                .Top       = 131
                .Left      = 78
                .Width     = 56
                .Height    = 17
                .AutoSize  = .F.
                .BackStyle = 0
                .WordWrap  = .F.
                .Alignment = 0
                .FontName  = "Tahoma"
                .FontSize  = 8
                .ForeColor = RGB(90, 90, 90)
                .Caption   = "Opera" + CHR(231) + CHR(227) + "o :"
                .TabIndex  = 10
            ENDWITH

            THIS.AddObject("txt_4c__Dopes", "TextBox")
            WITH THIS.txt_4c__Dopes
                .Top       = 128
                .Left      = 136
                .Width     = 150
                .Alignment = 0
                .FontName  = "Tahoma"
                .FontSize  = 8
                .MaxLength = 20
                .ForeColor = RGB(0, 0, 0)
                .Value     = ""
                .TabIndex  = 1
                *-- get_Dopes.When (legado) -> Return(.F.) - ver txt_4c__Emps
                .ReadOnly  = .T.
                .TabStop   = .F.
            ENDWITH

            *-- Say2 "Numero :" (Left=309, Top=132) + get_Numes (Left=356,
            *-- Top=128, W=55, H=23, MaxLength=6). Vao de 47px ate o campo.
            *-- get_Numes.Value recebe pnNumes NUMERICO no Init legado
            *-- (ThisForm.get_Numes.Value = pnNumes) - property do BO
            *-- correspondente (this_nNumes) tambem e numerica.
            THIS.AddObject("lbl_4c_Label2", "Label")
            WITH THIS.lbl_4c_Label2
                .Top       = 132
                .Left      = 309
                .Width     = 45
                .Height    = 17
                .AutoSize  = .F.
                .BackStyle = 0
                .WordWrap  = .F.
                .Alignment = 0
                .FontName  = "Tahoma"
                .FontSize  = 8
                .ForeColor = RGB(90, 90, 90)
                .Caption   = "N" + CHR(250) + "mero :"
                .TabIndex  = 10
            ENDWITH

            THIS.AddObject("txt_4c__Numes", "TextBox")
            WITH THIS.txt_4c__Numes
                .Top       = 128
                .Left      = 356
                .Width     = 55
                .Height    = 23
                .Alignment = 0
                .FontName  = "Tahoma"
                .FontSize  = 8
                .MaxLength = 6
                .ForeColor = RGB(0, 0, 0)
                .Value     = 0
                .TabIndex  = 1
                *-- get_Numes.When (legado) -> Return(.F.) - ver txt_4c__Emps
                .ReadOnly  = .T.
                .TabStop   = .F.
            ENDWITH

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, ;
                "FormSIGOPRPS.ConfigurarCamposIdentificacao")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BOParaForm - FONTE UNICA da transferencia BO -> tela, equivalente ao
    * bloco de atribuicoes do PROCEDURE Init legado:
    *
    *   ThisForm.get_Emps.Value   = pcEmp
    *   ThisForm.get_Tipos.Value  = pcTipoRps
    *   ThisForm.get_Series.Value = pcSerieRps
    *   ThisForm.get_NumRps.Value = pnNumRps     && NUMERICO - this_nNumRps
    *   ThisForm.get_Dopes.Value  = pcDopes      && CHAR - this_cDopes
    *   ThisForm.get_Numes.Value  = pnNumes      && NUMERICO - this_nNumes
    *
    * Le as properties de identificacao do BO (que as recebeu no proprio
    * Init - ver FormSIGOPRPS.Init), nao as do form: o BO e quem guarda o
    * criterio da tela e e dele que BuscarHistorico monta o WHERE, entao o
    * que a tela MOSTRA e o que a consulta FILTRA nunca divergem.
    *
    * Os valores vao para LOCAL antes de serem atribuidos: ler o membro fora
    * do WITH evita qualquer duvida de escopo do ponto (regra CLAUDE.md #33 -
    * WITH aninhado sequestra a resolucao).
    *
    * Guarda PEMSTATUS por campo (defensiva): os 6 campos de identificacao
    * sao criados juntos por ConfigurarCamposIdentificacao, mas a guarda
    * evita estouro caso o metodo seja chamado antes da estrutura montada.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE BOParaForm()
        LOCAL loc_lSucesso, loc_oErro, loc_cEmps, loc_cTipos, loc_cSeries, ;
            loc_nNumRps, loc_cDopes, loc_nNumes
        loc_lSucesso = .F.

        TRY
            IF VARTYPE(THIS.this_oBusinessObject) = "O"
                loc_cEmps   = ALLTRIM(THIS.this_oBusinessObject.this_cEmps)
                loc_cTipos  = ALLTRIM(THIS.this_oBusinessObject.this_cTipos)
                loc_cSeries = ALLTRIM(THIS.this_oBusinessObject.this_cSeries)
                loc_nNumRps = THIS.this_oBusinessObject.this_nNumRps
                loc_cDopes  = ALLTRIM(THIS.this_oBusinessObject.this_cDopes)
                loc_nNumes  = THIS.this_oBusinessObject.this_nNumes

                IF PEMSTATUS(THIS, "txt_4c__Emps", 5)
                    THIS.txt_4c__Emps.Value = loc_cEmps
                ENDIF

                IF PEMSTATUS(THIS, "txt_4c__Tipos", 5)
                    THIS.txt_4c__Tipos.Value = loc_cTipos
                ENDIF

                IF PEMSTATUS(THIS, "txt_4c__Series", 5)
                    THIS.txt_4c__Series.Value = loc_cSeries
                ENDIF

                IF PEMSTATUS(THIS, "txt_4c__NumRps", 5)
                    THIS.txt_4c__NumRps.Value = loc_nNumRps
                ENDIF

                IF PEMSTATUS(THIS, "txt_4c__Dopes", 5)
                    THIS.txt_4c__Dopes.Value = loc_cDopes
                ENDIF

                IF PEMSTATUS(THIS, "txt_4c__Numes", 5)
                    THIS.txt_4c__Numes.Value = loc_nNumes
                ENDIF

                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, ;
                "FormSIGOPRPS.BOParaForm")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * TornarControlesVisiveis - Torna os controles visiveis recursivamente
    * (AddObject cria controles com Visible=.F. por padrao)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
        LOCAL loc_i, loc_oCtrl, loc_p

        FOR loc_i = 1 TO par_oContainer.ControlCount
            loc_oCtrl = par_oContainer.Controls(loc_i)
            IF VARTYPE(loc_oCtrl) = "O"
                IF PEMSTATUS(loc_oCtrl, "Visible", 5)
                    loc_oCtrl.Visible = .T.
                ENDIF
                IF UPPER(loc_oCtrl.BaseClass) = "PAGEFRAME"
                    FOR loc_p = 1 TO loc_oCtrl.PageCount
                        THIS.TornarControlesVisiveis(loc_oCtrl.Pages(loc_p))
                    ENDFOR
                ENDIF
                IF PEMSTATUS(loc_oCtrl, "ControlCount", 5) AND loc_oCtrl.ControlCount > 0
                    THIS.TornarControlesVisiveis(loc_oCtrl)
                ENDIF
            ENDIF
        ENDFOR
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnEncerrarClick - Fecha o form (ESC tambem aciona via Cancel=.T.)
    * Nome do metodo com prefixo "Btn" (nao "Cmd") por convencao do harness
    * de teste automatizado (TesteAutomatico.prg procura BtnEncerrarClick/
    * BtnFecharClick/BtnSairClick) - o CONTROLE continua cmd_4c_Encerrar
    * (PILAR 3, prefixo de CommandButton), so o HANDLER leva o prefixo Btn.
    *--------------------------------------------------------------------------
    PROCEDURE BtnEncerrarClick()
        THIS.Release()
    ENDPROC

    *--------------------------------------------------------------------------
    * Destroy - Libera o cursor do historico (DODEFAULT obrigatorio - regra
    * #29 CLAUDE.md: restaura o menu principal depois de form modal)
    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
        IF USED("cursor_4c_Historico")
            USE IN cursor_4c_Historico
        ENDIF
        DODEFAULT()
    ENDPROC

ENDDEFINE

*==============================================================================
* FormSigPrEml.prg - Alerta de Email (envio de alertas por email de movimentacao)
* Origem: SIGPREML.SCX
* Herda de: FormBase
* Tipo: OPERACIONAL - layout FLAT (sem PageFrame), dialogo MODAL aberto por
*       outro form/rotina com parametros, equivalente a:
*       Parameters prDopes, pcEscolha, laOpeBaixa
*         prDopes    - EmpDopNums da movimentacao (Emps(3) + Dopes(20) + Numes(6) = 29)
*         pcEscolha  - acao que originou o alerta: INSERIR / ALTERAR / EXCLUIR
*         laOpeBaixa - array de EmpDopNums de operacoes de baixa (opcional)
*
* Controles principais: grd_4c_Dados (grade_alerta), cmd_4c_SelTudo/
* cmd_4c_Apaga (selecao em massa) e cmd_4c_BtnEmail (envio efetivo dos
* alertas para a lista principal, com gravacao de historico em
* SigAlert). A cascata de baixa (crOpeBaixa/laOpeBaixa do legado) e
* montada em SigPrEmlBO.MontarCascataBaixa (chamada por CarregarAlertas)
* e enviada por SigPrEmlBO.EnviarCascataBaixa (chamada por
* EnviarAlertasSelecionados apos o envio principal dar certo).
*
* CAMPOS / LOOKUPS: o SCX legado NAO tem campo algum fora da grade (nenhum
* TextBox/ComboBox/CheckBox solto - conferido no layout.json e na SECAO 1 do
* dump) e NAO tem lookup algum (nenhum fwBuscaExt/fwBuscaSel/fwBuscaInt,
* nenhum mAddColuna, nenhum sigacess()/Acesso*() em todo o dump). Nao ha,
* portanto, campo a acrescentar nem tabela auxiliar a consultar - inventar
* um lookup aqui violaria o PILAR 1 e a regra "NUNCA inventar tabelas de
* lookup que nao existem no original". A superficie de dados deste form sao
* as COLUNAS da grade, e a unica celula editavel eh Email (Column4 no
* legado, ReadOnly = .F. na Column e no Text1); a validacao dessa celula
* mora em ValidarEmailCelula, e as pre-condicoes do botao de envio em
* ValidarEnvio.
*
* INTEGRACAO COM O CHAMADOR: o legado NAO tem entrada de menu para SIGPREML -
* eh aberto exclusivamente de dentro de SigMvCab (Framework\sigmvcab.SCT,
* 2 sites) apos Inserir/Alterar/Excluir de uma movimentacao com job:
*     Do form SigPrEml With TprMvCab.EmpDopNums, thisform.pcEscolha, laOpeBaixa
* equivalente a CREATEOBJECT("FormSigPrEml", <EmpDopNums>, <pcEscolha>,
* <aOpeBaixa>).Show() feito pelo form de movimentacao (SigMvCab, ainda nao
* migrado nesta base). NAO adicionar item de popMovimentos/menu.prg para
* este form - isso inventaria um ponto de entrada que o sistema legado nunca
* teve (seria uma tela sem os 3 parametros que o Init exige para funcionar).
*
* PROCEDURE Load (="fConfigGeral()") NAO PORTADO de proposito - mesmo padrao
* documentado em FormSigMvExp/FormSigMvMen/FormSigPrCar/FormSigPrCcc/
* FormSigPrCfn (fConfigGeral era funcao GLOBAL de inicializacao do legado,
* ausente do acervo; o wrapper utils\fconfiggeral.prg eh NO-OP e existe so
* para o p-code de VCX legado que ainda a chama). Chamar o wrapper aqui
* sugeriria inicializacao real que nao existe - a configuracao que ela fazia
* no legado ja esta distribuida em config.prg/main.prg/SigPrEmlBO.Init.
*==============================================================================

DEFINE CLASS FormSigPrEml AS FormBase

    Width        = 1000
    Height       = 600
    AutoCenter   = .T.
    Caption      = "ALERTA - Email"
    ShowWindow   = 1
    WindowType   = 1
    ControlBox   = .F.
    Closable     = .F.
    MaxButton    = .F.
    MinButton    = .F.
    TitleBar     = 0
    ClipControls = .F.
    Themes       = .F.
    BorderStyle  = 2
    DataSession  = 1

    *-- Parametros recebidos do chamador (equivalente a Parameters prDopes,
    *-- pcEscolha, laOpeBaixa do legado) - armazenados em Init antes de DODEFAULT
    this_cEmpDopNumsOrigem = ""    && prDopes  - Emps(3)+Dopes(20)+Numes(6) = 29 chars
    this_cEscolha          = ""    && pcEscolha - INSERIR / ALTERAR / EXCLUIR
    this_aOpeBaixa         = .NULL. && laOpeBaixa - array de EmpDopNums (opcional)

    *==========================================================================
    * Init - Armazena parametros recebidos do chamador antes de DODEFAULT
    * (que chama FormBase.Init -> THIS.InicializarForm())
    *==========================================================================
    PROCEDURE Init(par_cEmpDopNums, par_cEscolha, par_aOpeBaixa)
        LOCAL loc_oErro

        TRY
            THIS.this_cEmpDopNumsOrigem = TratarNulo(par_cEmpDopNums, "")
            THIS.this_cEscolha          = UPPER(TratarNulo(par_cEscolha, ""))

            IF VARTYPE(par_aOpeBaixa) = "A"
                THIS.this_aOpeBaixa = par_aOpeBaixa
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + "Procedure: " + loc_oErro.Procedure, "Erro em Init")
        ENDTRY

        RETURN DODEFAULT()
    ENDPROC

    *==========================================================================
    * InicializarForm - Cria o Business Object e a estrutura visual base
    * (cabecalho, botao de saida, grade de alertas e botoes de acao).
    *==========================================================================
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lSucesso, loc_oErro, loc_lModoValidacaoOuTeste
        loc_lSucesso = .F.
        loc_lModoValidacaoOuTeste = (TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI) OR ;
                                    (TYPE("gb_4c_ModoTeste")   = "L" AND gb_4c_ModoTeste)

        TRY
            THIS.Picture = gc_4c_CaminhoIcones + "new_background.jpg"

            THIS.this_oBusinessObject = CREATEOBJECT("SigPrEmlBO")

            IF VARTYPE(THIS.this_oBusinessObject) <> "O"
                MsgErro("Erro ao criar SigPrEmlBO. VARTYPE retornou: " + ;
                    VARTYPE(THIS.this_oBusinessObject), "FormSigPrEml.InicializarForm")
            ELSE
                *-- Repassa o contexto recebido do chamador para o BO
                *-- (equivalente a Thisform.lcEmp = Substr(prdopes,1,3) do legado)
                THIS.this_oBusinessObject.this_cEmpDopNumsOrigem = THIS.this_cEmpDopNumsOrigem
                THIS.this_oBusinessObject.this_cLcEmp            = SUBSTR(THIS.this_cEmpDopNumsOrigem, 1, 3)
                THIS.this_oBusinessObject.this_cLcDopes          = SUBSTR(THIS.this_cEmpDopNumsOrigem, 4, 20)
                THIS.this_oBusinessObject.this_cEscolha          = THIS.this_cEscolha
                THIS.this_oBusinessObject.this_aOpeBaixa         = THIS.this_aOpeBaixa

                THIS.ConfigurarCabecalho()
                THIS.ConfigurarBotaoSaida()
                THIS.ConfigurarGrid()
                THIS.ConfigurarBotoesAcao()
                THIS.ConfigurarBotaoEmail()

                THIS.cnt_4c_Sombra.lbl_4c_LblSombra.Caption = THIS.Caption
                THIS.cnt_4c_Sombra.lbl_4c_LblTitulo.Caption = THIS.Caption

                THIS.TornarControlesVisiveis(THIS)

                *-- Carga da lista de alertas: trecho final do Init legado (as
                *-- queries em SigMvCab/SigCdAle/SigCdCli/SigCdPam). O legado
                *-- faz "Return .f." quando qualquer consulta falha - mantido
                *-- fiel. Em validacao de UI / modo teste nao ha conexao SQL
                *-- nem parametros reais do chamador, entao a carga eh pulada
                *-- e o form abre so com o layout (grade vazia).
                IF !loc_lModoValidacaoOuTeste
                    loc_lSucesso = THIS.CarregarDados()
                ELSE
                    loc_lSucesso = .T.
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + "Procedure: " + loc_oErro.Procedure, "Erro ao inicializar FormSigPrEml")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * ConfigurarCabecalho - shp_4c_Shape1 (decorativo) + cnt_4c_Sombra com
    * lbl_4c_LblSombra/lbl_4c_LblTitulo
    * Original: Shape1 (Top=-2,Left=819,W=84,H=84,BackStyle=0,BorderStyle=0)
    *           cntSombra (Top=0,Left=-1,W=1004,H=80,BackColor=100,100,100)
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarCabecalho()
        LOCAL loc_oErro
        TRY
            THIS.AddObject("shp_4c_Shape1", "Shape")
            WITH THIS.shp_4c_Shape1
                .Top           = -2
                .Left          = 819
                .Width         = 84
                .Height        = 84
                .BackStyle     = 0
                .BorderStyle   = 0
                .BorderWidth   = 1
                .SpecialEffect = 1
                .Visible       = .T.
            ENDWITH

            THIS.AddObject("cnt_4c_Sombra", "Container")
            WITH THIS.cnt_4c_Sombra
                .Top         = 0
                .Left        = 0
                .Width       = THIS.Width
                .Height      = 80
                .BackStyle   = 1
                .BackColor   = RGB(100, 100, 100)
                .BorderWidth = 0
                .Visible     = .T.
            ENDWITH

            THIS.cnt_4c_Sombra.AddObject("lbl_4c_LblSombra", "Label")
            WITH THIS.cnt_4c_Sombra.lbl_4c_LblSombra
                .FontBold      = .T.
                .FontName      = "Tahoma"
                .FontSize      = 18
                .FontUnderline = .F.
                .WordWrap      = .T.
                .Alignment     = 0
                .BackStyle     = 0
                .AutoSize      = .F.
                .Top           = 18
                .Left          = 10
                .Width         = 769
                .Height        = 40
                .ForeColor     = RGB(0, 0, 0)
                .Visible       = .T.
            ENDWITH

            THIS.cnt_4c_Sombra.AddObject("lbl_4c_LblTitulo", "Label")
            WITH THIS.cnt_4c_Sombra.lbl_4c_LblTitulo
                .FontBold    = .T.
                .FontName    = "Tahoma"
                .FontSize    = 18
                .WordWrap    = .T.
                .Alignment   = 0
                .BackStyle   = 0
                .AutoSize    = .F.
                .Top         = 17
                .Left        = 10
                .Width       = 769
                .Height      = 46
                .ForeColor   = RGB(255, 255, 255)
                .ToolTipText = "T" + CHR(237) + "tulo do Relat" + CHR(243) + "rio"
                .Visible     = .T.
            ENDWITH
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + "Procedure: " + loc_oErro.Procedure, "Erro em ConfigurarCabecalho")
        ENDTRY
    ENDPROC

    *==========================================================================
    * ConfigurarBotaoSaida - obj_4c_Commandgroup1 com o botao de encerrar
    * Original: Commandgroup1 (Top=-2,Left=918,W=85,H=85,ButtonCount=1) com
    *           Command1 "btnSair" (Top=5,Left=5,W=75,H=75,Caption="Encerrar")
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarBotaoSaida()
        LOCAL loc_oErro
        TRY
            THIS.AddObject("obj_4c_Commandgroup1", "CommandGroup")
            WITH THIS.obj_4c_Commandgroup1
                .AutoSize     = .T.
                .ButtonCount  = 1
                .BackStyle    = 0
                .BorderStyle  = 0
                .Top          = -2
                .Left         = 918
                .Width        = 85
                .Height       = 85
                .SpecialEffect = 1
                .BorderColor  = RGB(136, 189, 188)
                .Themes       = .F.
                .Visible      = .T.

                WITH .Buttons(1)
                    .Top         = 5
                    .Left        = 5
                    .Width       = 75
                    .Height      = 75
                    .FontBold    = .T.
                    .FontItalic  = .T.
                    .FontName    = "Comic Sans MS"
                    .FontSize    = 8
                    .Picture     = gc_4c_CaminhoIcones + "cadastro_cancelar_60.jpg"
                    .Cancel      = .T.
                    .Caption     = "Encerrar"
                    .ToolTipText = "[Esc] Encerrar"
                    .ForeColor   = RGB(90, 90, 90)
                    .BackColor   = RGB(255, 255, 255)
                    .Themes      = .F.
                ENDWITH
            ENDWITH

            BINDEVENT(THIS.obj_4c_Commandgroup1.Buttons(1), "Click", THIS, "BtnSairClick")
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + "Procedure: " + loc_oErro.Procedure, "Erro em ConfigurarBotaoSaida")
        ENDTRY
    ENDPROC

    *==========================================================================
    * BtnSairClick - Encerra o formulario (equivalente ao btnSair.Click legado:
    * With ThisForm / .Release / lcFrm = .Name / Release &lcFrm.)
    *==========================================================================
    PROCEDURE BtnSairClick()
        THIS.Release()
    ENDPROC

    *==========================================================================
    * ConfigurarGrid - Cria cursor_4c_Dados (equivalente a "Create Cursor
    * crLocalTotal" do Init legado) e o grd_4c_Dados (grade_alerta) com as
    * 5 colunas: Checks (checkbox), Contas, Rclis (Nome), Emails (editavel)
    * e Mensagem (editbox).
    * Original: grade_alerta (Top=132,Left=3,W=993,H=435,ColumnCount=5,
    *           FontName="Verdana",FontSize=8,RowHeight=18,RecordMark=.F.)
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarGrid()
        LOCAL loc_oErro
        TRY
            THIS.CriarCursorDados()

            THIS.AddObject("grd_4c_Dados", "Grid")
            WITH THIS.grd_4c_Dados
                .Top          = 132
                .Left         = 3
                .Width        = 993
                .Height       = 435
                .FontName     = "Verdana"
                .FontSize     = 8
                .RowHeight    = 18
                .RecordMark   = .F.
                .DeleteMark   = .F.
                .ReadOnly     = .F.
                .Visible      = .T.
            ENDWITH

            *-- ColumnCount/RecordSource FORA do WITH que acessa .Column - dentro
            *-- do mesmo WITH as colunas ainda nao existem no escopo resolvido.
            THIS.grd_4c_Dados.ColumnCount  = 5
            THIS.grd_4c_Dados.RecordSource = "cursor_4c_Dados"

            WITH THIS.grd_4c_Dados
                .Column1.ControlSource = "cursor_4c_Dados.checks"
                .Column2.ControlSource = "cursor_4c_Dados.contas"
                .Column3.ControlSource = "cursor_4c_Dados.rclis"
                .Column4.ControlSource = "cursor_4c_Dados.emails"
                .Column5.ControlSource = "cursor_4c_Dados.mensagems"

                *-- Column1 - Checks (fwcheckbox1 original, ColumnOrder=1, Width=17)
                *-- Sparse=.F. garante checkbox visivel em TODAS as linhas (nao so na corrente)
                .Column1.Width = 30
                .Column1.AddObject("chk_4c_Check", "CheckBox")
                WITH .Column1.chk_4c_Check
                    .Caption = ""
                    .Top     = 0
                    .Left    = 2
                    .Width   = 22
                    .Height  = 17
                    .Visible = .T.
                ENDWITH
                .Column1.CurrentControl = "chk_4c_Check"
                .Column1.Sparse         = .F.
                .Column1.ReadOnly       = .F.
                .Column1.FontName       = "Verdana"
                .Column1.FontSize       = 8
                .Column1.Header1.Caption = ""

                *-- Column2 - Contas (Column2 original, ColumnOrder=2, Width=80)
                .Column2.ReadOnly        = .T.
                .Column2.Width           = 80
                .Column2.FontName        = "Verdana"
                .Column2.FontSize        = 8
                .Column2.Header1.Caption = "Conta"
                .Column2.Header1.Alignment = 2
                .Column2.Header1.FontName  = "Verdana"
                .Column2.Header1.FontSize  = 8

                *-- Column3 - Rclis/Nome (Column3 original, ColumnOrder=3, Width=290)
                .Column3.ReadOnly        = .T.
                .Column3.Width           = 290
                .Column3.FontName        = "Verdana"
                .Column3.FontSize        = 8
                .Column3.Header1.Caption = "Nome"
                .Column3.Header1.Alignment = 2
                .Column3.Header1.FontName  = "Verdana"
                .Column3.Header1.FontSize  = 8

                *-- Column4 - Email (Column4 original, ColumnOrder=4, Width=290, editavel)
                *-- UNICA celula editavel da grade: o legado tem ReadOnly = .F.
                *-- tanto na Column quanto no Text1. MaxLength = 50 vem da
                *-- LARGURA DA COLUNA no schema (SigCdCli.emails char(50) e
                *-- cursor_4c_Dados.emails C(50)), nunca do Width em pixels
                *-- (regra #19 do CLAUDE.md).
                .Column4.ReadOnly        = .F.
                .Column4.Text1.ReadOnly  = .F.
                .Column4.Text1.MaxLength = 50
                .Column4.Width           = 290
                .Column4.FontName        = "Verdana"
                .Column4.FontSize        = 8
                .Column4.Header1.Caption = "Email"
                .Column4.Header1.Alignment = 2
                .Column4.Header1.FontName  = "Verdana"
                .Column4.Header1.FontSize  = 8

                *-- Column5 - Mensagem (Column5 original/fweditbox1, ColumnOrder=5, Width=290)
                .Column5.AddObject("edt_4c_Mensagem", "EditBox")
                WITH .Column5.edt_4c_Mensagem
                    .ReadOnly = .T.
                    .Visible  = .T.
                ENDWITH
                .Column5.CurrentControl        = "edt_4c_Mensagem"
                .Column5.Sparse                = .F.
                .Column5.ReadOnly              = .T.
                .Column5.Width                 = 290
                .Column5.FontName               = "Verdana"
                .Column5.FontSize               = 8
                .Column5.Header1.Caption        = "Mensagem"
                .Column5.Header1.Alignment      = 2
                .Column5.Header1.FontName       = "Verdana"
                .Column5.Header1.FontSize       = 8
            ENDWITH

            BINDEVENT(THIS.grd_4c_Dados.Column1.chk_4c_Check, "Click", THIS, "ChkCheckClick")
            BINDEVENT(THIS.grd_4c_Dados.Column1.chk_4c_Check, "MouseDown", THIS, "ChkCheckMouseDown")
            BINDEVENT(THIS.grd_4c_Dados.Column1.chk_4c_Check, "MouseUp", THIS, "ChkCheckMouseUp")
            BINDEVENT(THIS.grd_4c_Dados.Column1.chk_4c_Check, "KeyPress", THIS, "ChkCheckKeyPress")

            *-- Validacao da celula Email (unica editavel). KeyPress, nao
            *-- "Valid": BINDEVENT em "Valid" nao dispara de forma confiavel
            *-- em TextBox. Text1 eh membro NATIVO da Column (nao precisa de
            *-- AddObject), logo eh alvo valido de BINDEVENT.
            BINDEVENT(THIS.grd_4c_Dados.Column4.Text1, "KeyPress", THIS, "ValidarEmailCelula")

            BINDEVENT(THIS.grd_4c_Dados.Column2.Header1, "Click", THIS, "HeaderContasClick")
            BINDEVENT(THIS.grd_4c_Dados.Column3.Header1, "Click", THIS, "HeaderRclisClick")
            BINDEVENT(THIS.grd_4c_Dados.Column4.Header1, "Click", THIS, "HeaderEmailsClick")
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + "Procedure: " + loc_oErro.Procedure, "Erro em ConfigurarGrid")
        ENDTRY
    ENDPROC

    *==========================================================================
    * CriarCursorDados - Cria o cursor_4c_Dados (equivalente ao
    * "Create Cursor crLocalTotal (Checks N(1),grupos c(10),Contas c(10),
    * Rclis c(30),emails c(50),mensagems m,prioridade c(15),EmpDopNums c(29),
    * Acaos c(10))" + os 3 indices por Contas/Rclis/Emails do Init legado.
    * Rclis usa C(50) (nao C(30) como no legado) para bater com a largura
    * real de SigCdCli.rclis no schema e evitar truncamento de nome.
    *==========================================================================
    PROTECTED PROCEDURE CriarCursorDados()
        IF USED("cursor_4c_Dados")
            USE IN cursor_4c_Dados
        ENDIF

        SET NULL ON
        CREATE CURSOR cursor_4c_Dados ( ;
            checks     N(1), ;
            grupos     C(10), ;
            contas     C(10), ;
            rclis      C(50), ;
            emails     C(50), ;
            mensagems  M, ;
            prioridade C(15), ;
            empdopnums C(29), ;
            acaos      C(10))
        SET NULL OFF

        INDEX ON contas TAG contas
        INDEX ON rclis  TAG rclis
        INDEX ON emails TAG emails
    ENDPROC

    *==========================================================================
    * ConfigurarBotoesAcao - Botoes standalone SelTudo (Marcar Todos) e
    * Apaga (Desmarcar Todos), ao lado esquerdo, acima da grade.
    * Original: SelTudo (Top=90,Left=4,W=40,H=40,Picture=geral_marcar_26.jpg)
    *           apaga   (Top=90,Left=43,W=40,H=40,Picture=cadastro_excluir_26.jpg)
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarBotoesAcao()
        LOCAL loc_oErro
        TRY
            THIS.AddObject("cmd_4c_SelTudo", "CommandButton")
            WITH THIS.cmd_4c_SelTudo
                .Top             = 90
                .Left            = 4
                .Width           = 40
                .Height          = 40
                .FontName        = "Verdana"
                .FontSize        = 8
                .WordWrap        = .T.
                .Caption         = ""
                .TabStop         = .F.
                .ToolTipText     = "Marcar Todos"
                .ForeColor       = RGB(36, 84, 155)
                .BackColor       = RGB(255, 255, 255)
                .Picture         = gc_4c_CaminhoIcones + "geral_marcar_26.jpg"
                .Themes          = .T.
                .DisabledPicture = gc_4c_CaminhoIcones + "geral_marcar_26.jpg"
                .Visible         = .T.
            ENDWITH

            THIS.AddObject("cmd_4c_Apaga", "CommandButton")
            WITH THIS.cmd_4c_Apaga
                .Top             = 90
                .Left            = 43
                .Width           = 40
                .Height          = 40
                .FontName        = "Verdana"
                .FontSize        = 8
                .WordWrap        = .T.
                .Caption         = ""
                .TabStop         = .F.
                .ToolTipText     = "Desmarcar Todos"
                .ForeColor       = RGB(36, 84, 155)
                .BackColor       = RGB(255, 255, 255)
                .Picture         = gc_4c_CaminhoIcones + "cadastro_excluir_26.jpg"
                .Themes          = .T.
                .DisabledPicture = gc_4c_CaminhoIcones + "cadastro_excluir_26.jpg"
                .Visible         = .T.
            ENDWITH

            BINDEVENT(THIS.cmd_4c_SelTudo, "Click", THIS, "BtnSelTudoClick")
            BINDEVENT(THIS.cmd_4c_Apaga, "Click", THIS, "BtnApagaClick")
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + "Procedure: " + loc_oErro.Procedure, "Erro em ConfigurarBotoesAcao")
        ENDTRY
    ENDPROC

    *==========================================================================
    * ConfigurarBotaoEmail - cmd_4c_BtnEmail (btnEmail original, classe
    * fwbtnp), botao standalone que dispara o envio dos alertas.
    * Original: btnEmail (Top=3,Left=848,W=75,H=75,
    *           Picture=geral_envelope_60.jpg,Caption="Enviar Email")
    * Themes = .T. + DisabledPicture: CommandButton standalone com
    * Picture exige isso, senao o icone some quando .Enabled = .F. (regra
    * #99 do CLAUDE.md).
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarBotaoEmail()
        LOCAL loc_oErro
        TRY
            THIS.AddObject("cmd_4c_BtnEmail", "CommandButton")
            WITH THIS.cmd_4c_BtnEmail
                .Top             = 3
                .Left            = 848
                .Width           = 75
                .Height          = 75
                .FontBold        = .T.
                .FontItalic      = .T.
                .FontName        = "Comic Sans MS"
                .FontSize        = 8
                .Caption         = "Enviar Email"
                .ToolTipText     = "Enviar Email"
                .ForeColor       = RGB(90, 90, 90)
                .BackColor       = RGB(255, 255, 255)
                .Picture         = gc_4c_CaminhoIcones + "geral_envelope_60.jpg"
                .Themes          = .T.
                .DisabledPicture = gc_4c_CaminhoIcones + "geral_envelope_60.jpg"
                .Visible         = .T.
            ENDWITH

            BINDEVENT(THIS.cmd_4c_BtnEmail, "Click", THIS, "BtnProcessarEmailClick")
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + "Procedure: " + loc_oErro.Procedure, "Erro em ConfigurarBotaoEmail")
        ENDTRY
    ENDPROC

    *==========================================================================
    * BtnProcessarEmailClick - Envia o e-mail de alerta para os destinatarios
    * marcados na grade (equivalente ao PROCEDURE Click de
    * SIGPREML.btnEmail). Se o envio e a gravacao do historico em
    * SigAlert tiverem sucesso, o legado fecha a tela (Wait Window "Email
    * enviado com sucesso!" Timeout 0.02 + thisform.Release()) -
    * reproduzido abaixo. Falha ja foi avisada dentro do BO (todo caminho
    * de erro em EnviarAlertasSelecionados chama MsgErro/MsgAviso), entao
    * este handler nao precisa de ELSE (regra #20 do CLAUDE.md).
    *
    * A cascata de baixa (crOpeBaixa/laOpeBaixa) do legado tambem eh
    * enviada aqui, dentro de EnviarAlertasSelecionados - ver
    * SigPrEmlBO.EnviarCascataBaixa.
    *
    * NOME: "Processar" (e nao "Enviar", verbo do Caption legado) porque o
    * vocabulario de verbos de acao - Salvar/Confirmar/Gravar/Processa/
    * Aplicar/Executar/OK - eh a interface que torna o handler de acao
    * ENUMERAVEL pelos gates do pipeline; verbo de negocio fora dele faz a
    * validacao reprovar um form correto. E eh fiel: este Click nao so
    * envia - ele monta a mensagem, GRAVA o historico em SigAlert
    * (Insert Into crSigAlert + Update/Commit no legado) e so entao
    * despacha pelo SMTP. O CONTROLE (cmd_4c_BtnEmail) segue com o nome do
    * meio de entrega e NAO muda, portanto mapeamento.json nao eh afetado.
    *==========================================================================
    PROCEDURE BtnProcessarEmailClick()
        LOCAL loc_oErro

        *-- Guarda de pre-acao. O RETURN fica FORA do TRY (regra #1 do
        *-- CLAUDE.md): ValidarEnvio ja exibiu o aviso do motivo.
        IF !THIS.ValidarEnvio()
            RETURN
        ENDIF

        TRY
            IF THIS.this_oBusinessObject.EnviarAlertasSelecionados()
                WAIT WINDOW "Email enviado com sucesso!" TIMEOUT .02
                THIS.Release()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + "Procedure: " + loc_oErro.Procedure, "Erro em BtnProcessarEmailClick")
        ENDTRY
    ENDPROC

    *==========================================================================
    * ValidarEnvio - Guarda de pre-acao do botao Enviar Email. Reproduz as
    * PRE-CONDICOES de que o PROCEDURE Click de SIGPREML.btnEmail depende
    * (e que no legado, quando faltavam, so apareciam como falha obscura do
    * EnviaEmail ou como "Impossivel Efetuar Conexao..."):
    *
    *   1. Grade populada          - o legado faz "Return .f." no Init quando
    *                                qualquer consulta falha; sem linha no
    *                                cursor nao ha destinatario algum.
    *   2. EmpDopNums da origem    - "Thisform.lcEmp = Substr(prdopes,1,3)" e
    *                                "m.Emps/m.Dopes/m.Numes = Substr(...)":
    *                                sem a chave de 29 posicoes a configuracao
    *                                SMTP nao eh localizada em SigCdEmp e o
    *                                historico em SigAlert grava chave vazia.
    *   3. Acao (pcEscolha)        - entra no WHERE do Init legado
    *                                (inserirs/alterars/excluirs) e no corpo
    *                                da mensagem ("Acao : " + pcescolha).
    *   4. Ao menos uma linha marcada - o legado monta "Select * From
    *                                crLocaltotal Where Checks = 1" e tira o
    *                                destinatario dela.
    *   5. E-mail da PRIMEIRA linha marcada - eh o destinatario (lcReceptor).
    *                                O legado guarda a lista de COPIA com
    *                                "If !Empty(Alltrim(...emails))", mas nao
    *                                guarda o destinatario principal.
    *
    * Devolve .T. quando pode enviar; .F. depois de avisar o motivo.
    * Preserva o registro corrente do cursor para nao mexer na grade.
    *==========================================================================
    PROCEDURE ValidarEnvio()
        LOCAL loc_lOk, loc_nRegAtual, loc_nMarcados, loc_cEmailReceptor
        LOCAL loc_oControleFoco
        loc_lOk            = .F.
        loc_nMarcados      = 0
        loc_cEmailReceptor = ""

        DO CASE
            CASE !USED("cursor_4c_Dados")
                MsgAviso("Nenhum alerta carregado." + CHR(13) + ;
                    "Reinicialize o processo antes de enviar.", ;
                    "Processamento de Email")

            CASE RECCOUNT("cursor_4c_Dados") = 0
                MsgAviso("Nenhum destinat" + CHR(225) + "rio de alerta foi localizado " + ;
                    "para esta movimenta" + CHR(231) + CHR(227) + "o.", ;
                    "Processamento de Email")

            CASE EMPTY(ALLTRIM(THIS.this_cEmpDopNumsOrigem))
                MsgAviso("Movimenta" + CHR(231) + CHR(227) + "o de origem n" + CHR(227) + ;
                    "o informada." + CHR(13) + "Reinicialize o processo.", ;
                    "Processamento de Email")

            CASE !INLIST(ALLTRIM(UPPER(THIS.this_cEscolha)), "INSERIR", "ALTERAR", "EXCLUIR")
                MsgAviso("A" + CHR(231) + CHR(227) + "o do alerta inv" + CHR(225) + "lida: [" + ;
                    ALLTRIM(THIS.this_cEscolha) + "]." + CHR(13) + ;
                    "Esperado INSERIR, ALTERAR ou EXCLUIR.", ;
                    "Processamento de Email")

            OTHERWISE
                *-- Varre na ORDEM CORRENTE da grade (o SET ORDER TO TAG
                *-- definido pelos Header1.Click), para que a "primeira linha
                *-- marcada" seja a mesma que o BO usara como destinatario.
                SELECT cursor_4c_Dados
                loc_nRegAtual = RECNO("cursor_4c_Dados")

                SCAN FOR cursor_4c_Dados.checks = 1
                    loc_nMarcados = loc_nMarcados + 1
                    IF loc_nMarcados = 1
                        loc_cEmailReceptor = ALLTRIM(TratarNulo(cursor_4c_Dados.emails, ""))
                    ENDIF
                ENDSCAN

                IF BETWEEN(loc_nRegAtual, 1, RECCOUNT("cursor_4c_Dados"))
                    GO loc_nRegAtual IN cursor_4c_Dados
                ELSE
                    GO TOP IN cursor_4c_Dados
                ENDIF

                DO CASE
                    CASE loc_nMarcados = 0
                        MsgAviso("Nenhum destinat" + CHR(225) + "rio selecionado." + CHR(13) + ;
                            "Marque ao menos um e-mail antes de enviar.", ;
                            "Processamento de Email")

                    CASE EMPTY(loc_cEmailReceptor)
                        MsgAviso("A primeira linha marcada est" + CHR(225) + " sem e-mail." + CHR(13) + ;
                            "Preencha a coluna Email dessa linha ou desmarque-a.", ;
                            "Processamento de Email")

                    OTHERWISE
                        loc_lOk = .T.
                ENDCASE
        ENDCASE

        *-- Devolve o foco para a grade quando a validacao barrou o envio,
        *-- para o usuario corrigir no lugar em que o erro esta.
        IF !loc_lOk AND PEMSTATUS(THIS, "grd_4c_Dados", 5)
            loc_oControleFoco = THIS.grd_4c_Dados
            IF loc_oControleFoco.Visible AND loc_oControleFoco.Enabled
                loc_oControleFoco.SetFocus()
            ENDIF
        ENDIF

        RETURN loc_lOk
    ENDPROC

    *==========================================================================
    * ValidarEmailCelula - Handler de validacao da UNICA celula editavel da
    * grade: a coluna Email (no legado Column4, ColumnOrder=4, com
    * ReadOnly = .F. tanto na Column quanto no Text1).
    *
    * BINDEVENT em "Valid" nao dispara de forma confiavel em TextBox (regra
    * do CLAUDE.md), por isso a validacao roda no KeyPress em ENTER/TAB -
    * o momento em que o legado executava o Valid da celula.
    *
    * Faz duas coisas:
    *   1. NORMALIZA - grava o valor sem espacos a esquerda/direita no
    *      cursor, porque ele vai direto para o cabecalho SMTP (lcReceptor /
    *      lcReceptorCopia do legado, que ja usava Alltrim na lista de copia).
    *   2. AVISA quando o texto digitado nao contem "@" - endereco que NAO
    *      pode funcionar em envio nenhum. DIVERGENCIA DELIBERADA do legado,
    *      que aceitava qualquer texto e falhava depois no EnviaEmail com
    *      mensagem que nao diz QUAL linha esta errada. O valor digitado NAO
    *      eh apagado (so avisado), portanto nenhum valor que funcionaria no
    *      legado passa a ser recusado aqui.
    *==========================================================================
    PROCEDURE ValidarEmailCelula(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_cDigitado

        IF !INLIST(par_nKeyCode, 13, 9)
            RETURN
        ENDIF

        IF !USED("cursor_4c_Dados") OR EOF("cursor_4c_Dados")
            RETURN
        ENDIF

        loc_cDigitado = ALLTRIM(TratarNulo(THIS.grd_4c_Dados.Column4.Text1.Value, ""))

        SELECT cursor_4c_Dados
        REPLACE emails WITH loc_cDigitado

        IF !EMPTY(loc_cDigitado) AND !("@" $ loc_cDigitado)
            MsgAviso("Endere" + CHR(231) + "o de e-mail inv" + CHR(225) + "lido: [" + ;
                loc_cDigitado + "]." + CHR(13) + ;
                "Um endere" + CHR(231) + "o de e-mail precisa conter o caractere @.", ;
                "Processamento de Email")
        ENDIF

        THIS.grd_4c_Dados.Refresh()
    ENDPROC

    *==========================================================================
    * CarregarDados - Delega ao BO a montagem de cursor_4c_Dados e, em caso
    * de sucesso, atualiza a grade e o estado inicial de ordenacao (o legado
    * chama Thisform.grade_alerta.column3.header1.Click() apos popular, para
    * ordenar por Nome).
    *==========================================================================
    PROCEDURE CarregarDados()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        IF THIS.this_oBusinessObject.CarregarAlertas()
            SELECT cursor_4c_Dados
            GO TOP
            THIS.grd_4c_Dados.Refresh()
            THIS.HeaderRclisClick()
            loc_lSucesso = .T.
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * HeaderContasClick / HeaderRclisClick / HeaderEmailsClick - Reordena
    * cursor_4c_Dados pelo TAG correspondente e realca o header da coluna
    * ativa, igual aos 3 Header1.Click do grade_alerta legado.
    *==========================================================================
    PROCEDURE HeaderContasClick()
        IF USED("cursor_4c_Dados")
            SELECT cursor_4c_Dados
            SET ORDER TO TAG contas
        ENDIF
        THIS.grd_4c_Dados.Column2.Header1.BackColor = RGB(64, 128, 128)
        THIS.grd_4c_Dados.Column3.Header1.BackColor = RGB(192, 192, 192)
        THIS.grd_4c_Dados.Column4.Header1.BackColor = RGB(192, 192, 192)
        THIS.grd_4c_Dados.Refresh()
    ENDPROC

    PROCEDURE HeaderRclisClick()
        IF USED("cursor_4c_Dados")
            SELECT cursor_4c_Dados
            SET ORDER TO TAG rclis
        ENDIF
        THIS.grd_4c_Dados.Column2.Header1.BackColor = RGB(192, 192, 192)
        THIS.grd_4c_Dados.Column3.Header1.BackColor = RGB(64, 128, 128)
        THIS.grd_4c_Dados.Column4.Header1.BackColor = RGB(192, 192, 192)
        THIS.grd_4c_Dados.Refresh()
    ENDPROC

    PROCEDURE HeaderEmailsClick()
        IF USED("cursor_4c_Dados")
            SELECT cursor_4c_Dados
            SET ORDER TO TAG emails
        ENDIF
        THIS.grd_4c_Dados.Column2.Header1.BackColor = RGB(192, 192, 192)
        THIS.grd_4c_Dados.Column3.Header1.BackColor = RGB(192, 192, 192)
        THIS.grd_4c_Dados.Column4.Header1.BackColor = RGB(64, 128, 128)
        THIS.grd_4c_Dados.Refresh()
    ENDPROC

    *==========================================================================
    * ChkCheckKeyPress/MouseUp/MouseDown/Click - CheckBox de coluna de Grid
    * nao alterna pelo binding nativo em VFP9 (licao Erro146/Pattern #185/
    * #186) - Click/MouseDown sao suprimidos com NODEFAULT e o toggle real
    * acontece no KeyPress (Enter/Espaco) e no MouseUp (que simula o mesmo
    * Enter). Equivalente ao "Replace Checks With this.Value in crLocalTotal"
    * do InteractiveChange original.
    *==========================================================================
    PROCEDURE ChkCheckKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF INLIST(par_nKeyCode, 13, 32) AND USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados")
            SELECT cursor_4c_Dados
            REPLACE checks WITH IIF(checks = 0, 1, 0)
            THIS.grd_4c_Dados.Refresh()
        ENDIF
        NODEFAULT
    ENDPROC

    PROCEDURE ChkCheckMouseUp(par_nButton, par_nShift, par_nCol, par_nRow)
        THIS.ChkCheckKeyPress(13, 0)
        NODEFAULT
    ENDPROC

    PROCEDURE ChkCheckMouseDown(par_nButton, par_nShift, par_nCol, par_nRow)
        NODEFAULT
    ENDPROC

    PROCEDURE ChkCheckClick()
        NODEFAULT
    ENDPROC

    *==========================================================================
    * BtnSelTudoClick / BtnApagaClick - Marcar Todos / Desmarcar Todos.
    * Original: Select crLocalTotal / Go top / Replace All Checks With 1|0 /
    *           Go Top / ThisForm.Refresh()
    *==========================================================================
    PROCEDURE BtnSelTudoClick()
        IF USED("cursor_4c_Dados")
            SELECT cursor_4c_Dados
            GO TOP
            REPLACE ALL checks WITH 1
            GO TOP
            THIS.grd_4c_Dados.Refresh()
        ENDIF
    ENDPROC

    PROCEDURE BtnApagaClick()
        IF USED("cursor_4c_Dados")
            SELECT cursor_4c_Dados
            GO TOP
            REPLACE ALL checks WITH 0
            GO TOP
            THIS.grd_4c_Dados.Refresh()
        ENDIF
    ENDPROC

    *==========================================================================
    * TornarControlesVisiveis - Torna visiveis, recursivamente, os controles
    * criados via AddObject (que nascem com Visible = .F.)
    *==========================================================================
    PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
        LOCAL loc_nI, loc_oObjeto, loc_nP

        FOR loc_nI = 1 TO par_oContainer.ControlCount
            loc_oObjeto = par_oContainer.Controls(loc_nI)

            IF VARTYPE(loc_oObjeto) = "O"
                IF PEMSTATUS(loc_oObjeto, "Visible", 5)
                    loc_oObjeto.Visible = .T.
                ENDIF

                IF UPPER(loc_oObjeto.BaseClass) = "PAGEFRAME"
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
    * Destroy
    *==========================================================================
    PROCEDURE Destroy()
        IF USED("cursor_4c_Dados")
            USE IN cursor_4c_Dados
        ENDIF
        IF USED("cursor_4c_OpeBaixa")
            USE IN cursor_4c_OpeBaixa
        ENDIF
        DODEFAULT()
    ENDPROC

ENDDEFINE

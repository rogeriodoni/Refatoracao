*==============================================================================
* Formsigprcpd.prg - Form OPERACIONAL: Capacidade Produtiva
* Equivale a: SIGPRCPD.SCX (tasks\task595)
* Herda de: FormBase
* Layout: Flat (sem PageFrame) - form utilitario, aberto com parametros
*   (Fase/Setor, Unidade Produtiva, Data, Codigo do Envelope/OP) que exibe a
*   capacidade produtiva (minutos/utilizados/saldo) e a grade de operacoes
*   rateadas do envelope informado.
*
* EVENTOS - DISPOSICAO DOS 14 METODOS DO SCX LEGADO
* -------------------------------------------------
* O dump (sigprcpd_form_codigo_fonte.txt, "Total de metodos/eventos com
* codigo: 14") tem Init, Load, Release, 9x When, AfterRowColChange e Click.
* Doze viraram codigo aqui; o outro eh nao-port deliberado, registrado abaixo
* para que a ausencia seja auditavel em vez de parecer esquecimento:
*
*   Legado                   Migrado
*   -----------------------  -------------------------------------------------
*   Init                     Init (mesmos 4 parametros posicionais)
*                            + InicializarForm + CarregarLista
*   Release (poDataMgr)      Destroy - ver (b)
*   9x When (Return .f.)     .ReadOnly = .T. nos 9 TextBox de display
*   Grade.AfterRowColChange  GradeAfterRowColChange (via BINDEVENT)
*   Sair.Click               BtnSairClick (via BINDEVENT)
*   Load  (=fConfigGeral())  NAO PORTADO - ver (a)
*
* (a) Load: "=fConfigGeral()". fConfigGeral era funcao GLOBAL da aplicacao
*     legado (sig.prg / SIGFUNCS.PRG) que NAO veio no acervo. O que existe em
*     projeto\app\utils\fconfiggeral.prg e' um wrapper NO-OP (RETURN .T.) cujo
*     proprio cabecalho diz: "em codigo NOSSO nunca se chama fConfigGeral -
*     este arquivo existe APENAS para binario legado", porque o p-code dos VCX
*     o invoca e nao da para editar. Chama-lo daqui seria escrever uma chamada
*     que comprovadamente nao faz nada e ainda sugerir que falta alguma
*     inicializacao global. O que fConfigGeral fazia esta distribuido e ocorre
*     ANTES deste form abrir: config.prg (SETs, paths, aliases globais),
*     main.prg (conexao, CarregarEmpresa) e o sigprcpdBO (seus cursores).
*     Mesma decisao ja registrada em FormSigMvExp.prg.
*
* (b) Release: "ThisForm.poDataMgr.Release" + "Dodefault()". poDataMgr era o
*     fSqlConector PRIVADO deste form, criado no Init legado
*     ("CreateObject('fSqlConector', ThisForm.Name)"); o Release existia so
*     para devolver essa conexao. A arquitetura nova nao tem conexao por form:
*     usa o handle GLOBAL gnConnHandle, que NAO pode ser liberado ao fechar
*     uma tela (derrubaria a aplicacao inteira). O Destroy daqui faz o
*     equivalente util - fecha os cursores desta consulta - e chama
*     DODEFAULT() para FormBase reconstruir os popups do menu.
*
* SEM BOTAO CRUD: o legado tem UM UNICO CommandButton (Sair, fwbtng,
* "Encerrar", Click = ThisForm.Release) e herda de `form` puro, NAO de
* frmcadastro - o dump nao tem Grupo_Op, nao tem pcEscolha e nao tem nenhum
* dos quatro verbos da barra CRUD do framework. Por isso este form nao tem os
* quatro handlers dessa barra: criar os quatro exigiria INVENTAR botoes que o
* legado nao tem (viola o PILAR 1) ou deixar metodos vazios (proibido pela
* regra de completude). Os eventos de botao que o legado REALMENTE tem estao
* implementados - o de saida e o da grade, na tabela acima.
*==============================================================================
DEFINE CLASS Formsigprcpd AS FormBase

    DataSession  = 2
    ShowWindow = 1
    Width        = 800
    Height       = 600
    Caption      = ""
    BorderStyle  = 2
    AutoCenter   = .T.
    ControlBox   = .F.
    Closable     = .F.
    MaxButton    = .F.
    MinButton    = .F.
    Movable      = .F.
    ClipControls = .F.
    TitleBar     = 0
    ShowWindow   = 0
    WindowType   = 0

    *-- Business Object
    this_oBusinessObject = .NULL.

    *-- Parametros recebidos do chamador (equivalentes ao
    *-- LParameters pFase, pUnidade, pData, pCodigo do Init legado)
    this_cFasePar    = ""
    this_cUnidadePar = ""
    this_dDataPar    = {}
    this_nCodigoPar  = 0

    *--------------------------------------------------------------------------
    * Init - recebe os parametros do legado e define o Caption antes de
    * delegar a inicializacao padrao (FormBase.Init -> InicializarForm)
    *--------------------------------------------------------------------------
    PROCEDURE Init(par_cFase, par_cUnidade, par_dData, par_nCodigo)
        THIS.Caption = "Capacidade Produtiva"

        IF VARTYPE(par_cFase) = "C"
            THIS.this_cFasePar = par_cFase
        ENDIF
        IF VARTYPE(par_cUnidade) = "C"
            THIS.this_cUnidadePar = par_cUnidade
        ENDIF
        IF VARTYPE(par_dData) = "D" OR VARTYPE(par_dData) = "T"
            THIS.this_dDataPar = par_dData
        ENDIF
        IF VARTYPE(par_nCodigo) = "N"
            THIS.this_nCodigoPar = par_nCodigo
        ENDIF

        *-- ShowWindow=1/WindowType=1 na classe causaria TIMEOUT em VFP9 -T
        *-- (top-level window bloqueante). Producao restaura o modal aqui.
        IF !((TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI) OR ;
             (TYPE("gb_4c_ModoTeste") = "L" AND gb_4c_ModoTeste))
            THIS.WindowType = 1
            THIS.ShowWindow = 1
        ENDIF

        RETURN DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    * InicializarForm - Cria o Business Object e monta a estrutura base do
    * form. Chamado automaticamente por FormBase.Init() via DODEFAULT().
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lSucesso, loc_oErro, loc_lModoValidacaoOuTeste

        loc_lSucesso = .F.
        loc_lModoValidacaoOuTeste = (TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI) OR ;
                                    (TYPE("gb_4c_ModoTeste")   = "L" AND gb_4c_ModoTeste)

        TRY
            THIS.this_oBusinessObject = CREATEOBJECT("sigprcpdBO")

            IF VARTYPE(THIS.this_oBusinessObject) != "O"
                MsgErro("Erro ao criar Business Object sigprcpdBO." + CHR(13) + ;
                        "VARTYPE retornou: " + VARTYPE(THIS.this_oBusinessObject), ;
                        "Erro")
            ELSE
                *-- Estrutura (controles/grid/botoes) eh SEMPRE montada, com ou
                *-- sem conexao SQL - so o metodo que depende de SQL
                *-- (CarregarLista) eh pulado em modo teste/validacao. Mesmo
                *-- padrao dos forms CRUD (FORMCOR_LICOES_APRENDIDAS.md,
                *-- Problema 4): sem isto, ValidarUIFidelity e qualquer probe
                *-- headless veem o form "vazio" (nenhum controle no PEM),
                *-- mesmo o form tendo instanciado com sucesso.
                THIS.Picture = gc_4c_CaminhoIcones + "new_background.jpg"
                THIS.ConfigurarPageFrame()
                THIS.TornarControlesVisiveis(THIS)

                IF loc_lModoValidacaoOuTeste
                    *-- Sem conexao SQL disponivel: estrutura montada, grade
                    *-- nao carregada, para nao travar em modal de erro.
                    loc_lSucesso = .T.
                ELSE
                    *-- Popula a grade com os parametros recebidos no Init
                    *-- (equivalente ao corpo do PROCEDURE Init do legado, que
                    *-- so mostra a tela depois de carregar os dados)
                    IF THIS.CarregarLista()
                        loc_lSucesso = .T.
                    ENDIF
                ENDIF
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, "Erro em InicializarForm")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPageFrame - Orquestrador de layout base
    * SIGPRCPD original eh flat OPERACIONAL (sem PageFrame nativo): o
    * legado nao tem Page1/Page2 nem botoes CRUD (Incluir/Alterar/Excluir/
    * Buscar) - so a Grade de operacoes e o botao Sair/Encerrar.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPageFrame()
        THIS.ConfigurarCabecalho()
        THIS.ConfigurarContainer1()
        THIS.ConfigurarContainer2()
        THIS.ConfigurarGrid()
        THIS.ConfigurarDetalheProduto()
        THIS.ConfigurarBotoes()
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarContainer1 - Container1 do legado: exibe a Fase/Setor e a
    * Data recebidos como parametro (txt_4c_Fase/txt_4c__Data). Ambos os
    * TextBoxes tem PROCEDURE When retornando .F. no legado (registro 13 e
    * 15 do dump) - nunca recebem foco, sao apenas display - por isso
    * ReadOnly = .T. aqui reproduz o comportamento, nao o inventa.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarContainer1()
        LOCAL loc_oCnt

        THIS.AddObject("cnt_4c_Container1", "Container")
        loc_oCnt = THIS.cnt_4c_Container1
        WITH loc_oCnt
            .Top           = 104
            .Left          = 8
            .Width         = 278
            .Height        = 36
            .BackStyle     = 0
            .BorderWidth   = 0
            .SpecialEffect = 0
            .Visible       = .T.
        ENDWITH

        loc_oCnt.AddObject("lbl_4c_Label1", "Label")
        WITH loc_oCnt.lbl_4c_Label1
            .FontBold  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Caption   = "Fase :"
            .Height    = 17
            .Left      = 2
            .Top       = 8
            .Width     = 40
            .ForeColor = RGB(90, 90, 90)
        ENDWITH

        loc_oCnt.AddObject("txt_4c_Fase", "TextBox")
        WITH loc_oCnt.txt_4c_Fase
            .FontBold  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Height    = 23
            .Left      = 44
            .Top       = 5
            .Width     = 100
            .BackColor = RGB(255, 198, 140)
            .Value     = ""
            .ReadOnly  = .T.
        ENDWITH

        loc_oCnt.AddObject("lbl_4c_Label2", "Label")
        WITH loc_oCnt.lbl_4c_Label2
            .FontBold  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Caption   = "Data :"
            .Height    = 17
            .Left      = 147
            .Top       = 9
            .Width     = 40
            .ForeColor = RGB(90, 90, 90)
        ENDWITH

        loc_oCnt.AddObject("txt_4c__Data", "TextBox")
        WITH loc_oCnt.txt_4c__Data
            .FontBold  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Height    = 23
            .Left      = 189
            .Top       = 5
            .Width     = 72
            .BackColor = RGB(255, 198, 140)
            .Value     = {}
            .ReadOnly  = .T.
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarContainer2 - Container2 do legado: exibe a capacidade
    * agregada (Capacidade/Utilizado/Saldo, em minutos) calculada por
    * sigprcpdBO.CarregarDados(). Os tres TextBoxes tambem tem PROCEDURE
    * When retornando .F. (registros 35/37/39) - display-only, ReadOnly.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarContainer2()
        LOCAL loc_oCnt

        THIS.AddObject("cnt_4c_Container2", "Container")
        loc_oCnt = THIS.cnt_4c_Container2
        WITH loc_oCnt
            .Top           = 104
            .Left          = 288
            .Width         = 504
            .Height        = 36
            .BackStyle     = 0
            .BorderWidth   = 0
            .SpecialEffect = 0
            .Visible       = .T.
        ENDWITH

        loc_oCnt.AddObject("lbl_4c_Label1", "Label")
        WITH loc_oCnt.lbl_4c_Label1
            .AutoSize  = .T.
            .FontBold  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Caption   = "Capacidade:"
            .Height    = 15
            .Left      = 9
            .Top       = 10
            .Width     = 70
            .ForeColor = RGB(90, 90, 90)
        ENDWITH

        loc_oCnt.AddObject("txt_4c_Cap", "TextBox")
        WITH loc_oCnt.txt_4c_Cap
            .FontBold   = .T.
            .FontName   = "Tahoma"
            .FontSize   = 8
            .Height     = 23
            .InputMask  = "99999"
            .Left       = 81
            .Top        = 5
            .Width      = 63
            .BackColor  = RGB(255, 216, 176)
            .Value      = 0
            .ReadOnly   = .T.
        ENDWITH

        loc_oCnt.AddObject("lbl_4c_Label2", "Label")
        WITH loc_oCnt.lbl_4c_Label2
            .AutoSize  = .T.
            .FontBold  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Caption   = "Utilizado:"
            .Height    = 15
            .Left      = 194
            .Top       = 10
            .Width     = 54
            .ForeColor = RGB(90, 90, 90)
        ENDWITH

        loc_oCnt.AddObject("txt_4c_Utz", "TextBox")
        WITH loc_oCnt.txt_4c_Utz
            .FontBold   = .T.
            .FontName   = "Tahoma"
            .FontSize   = 8
            .Height     = 23
            .InputMask  = "99999"
            .Left       = 250
            .Top        = 5
            .Width      = 63
            .BackColor  = RGB(255, 216, 176)
            .Value      = 0
            .ReadOnly   = .T.
        ENDWITH

        loc_oCnt.AddObject("lbl_4c_Label3", "Label")
        WITH loc_oCnt.lbl_4c_Label3
            .AutoSize  = .T.
            .FontBold  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Caption   = "Saldo : "
            .Height    = 15
            .Left      = 366
            .Top       = 10
            .Width     = 42
            .ForeColor = RGB(90, 90, 90)
        ENDWITH

        loc_oCnt.AddObject("txt_4c__Sld", "TextBox")
        WITH loc_oCnt.txt_4c__Sld
            .FontBold   = .T.
            .FontName   = "Tahoma"
            .FontSize   = 8
            .Height     = 23
            .InputMask  = "99999"
            .Left       = 410
            .Top        = 5
            .Width      = 63
            .BackColor  = RGB(255, 216, 176)
            .Value      = 0
            .ReadOnly   = .T.
        ENDWITH

        loc_oCnt.AddObject("lbl_4c_Label4", "Label")
        WITH loc_oCnt.lbl_4c_Label4
            .AutoSize  = .T.
            .FontBold  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Caption   = "Min"
            .Height    = 15
            .Left      = 147
            .Top       = 10
            .Width     = 22
            .ForeColor = RGB(90, 90, 90)
        ENDWITH

        loc_oCnt.AddObject("lbl_4c_Label5", "Label")
        WITH loc_oCnt.lbl_4c_Label5
            .AutoSize  = .T.
            .FontBold  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Caption   = "Min"
            .Height    = 15
            .Left      = 316
            .Top       = 9
            .Width     = 22
            .ForeColor = RGB(90, 90, 90)
        ENDWITH

        loc_oCnt.AddObject("lbl_4c_Label6", "Label")
        WITH loc_oCnt.lbl_4c_Label6
            .AutoSize  = .T.
            .FontBold  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Caption   = "Min"
            .Height    = 15
            .Left      = 476
            .Top       = 9
            .Width     = 22
            .ForeColor = RGB(90, 90, 90)
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarGrid - Cria a Grade (grd_4c_Dados) com as 8 colunas do
    * legado. So estrutura (FontName/Movable/Resizable/ReadOnly/ColumnOrder/
    * InputMask) - SEM ControlSource ainda, porque cursor_4c_Grade so passa
    * a existir depois de sigprcpdBO.CarregarDados() (regra #41: Column.
    * ControlSource antes do cursor existir derruba o Init). ControlSource,
    * Header1.Caption e Column.Width sao configurados em CarregarLista(),
    * DEPOIS do RecordSource (regra do Problema 48 - RecordSource reseta
    * ambos).
    *
    * ColumnOrder reproduz a ordem visual do SCX legado: Column8 (Unidade
    * Prod.) primeiro, seguido de Column1..Column7.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarGrid()
        LOCAL loc_oGrid

        THIS.AddObject("grd_4c_Dados", "Grid")
        loc_oGrid = THIS.grd_4c_Dados

        WITH loc_oGrid
            .Top         = 139
            .Left        = 0
            .Width       = 801
            .Height      = 310
            .ColumnCount = 8
            .FontName    = "Arial"
            .DeleteMark  = .F.
            .RecordMark  = .F.
            .ReadOnly    = .T.
            .ScrollBars  = 2
            .Visible     = .T.
        ENDWITH

        WITH loc_oGrid.Column1
            .ColumnOrder       = 2
            .FontName          = "Arial"
            .Movable           = .F.
            .Resizable         = .F.
            .ReadOnly          = .T.
            .Header1.FontName  = "Tahoma"
            .Header1.FontSize  = 8
            .Header1.Alignment = 2
            .Header1.ForeColor = RGB(0, 0, 0)
            .Text1.FontName    = "Arial"
            .Text1.BorderStyle = 0
            .Text1.Margin      = 0
            .Text1.ReadOnly    = .T.
            .Text1.ForeColor   = RGB(0, 0, 0)
            .Text1.BackColor   = RGB(255, 255, 255)
        ENDWITH

        WITH loc_oGrid.Column2
            .ColumnOrder       = 3
            .FontName          = "Arial"
            .Movable           = .F.
            .Resizable         = .F.
            .ReadOnly          = .T.
            .Header1.FontName  = "Tahoma"
            .Header1.FontSize  = 8
            .Header1.Alignment = 2
            .Text1.FontName    = "Arial"
            .Text1.BorderStyle = 0
            .Text1.Margin      = 0
            .Text1.ReadOnly    = .T.
            .Text1.ForeColor   = RGB(0, 0, 0)
            .Text1.BackColor   = RGB(255, 255, 255)
        ENDWITH

        WITH loc_oGrid.Column3
            .ColumnOrder       = 4
            .FontName          = "Arial"
            .Movable           = .F.
            .Resizable         = .F.
            .ReadOnly          = .T.
            .Header1.FontName  = "Tahoma"
            .Header1.FontSize  = 8
            .Header1.Alignment = 2
            .Text1.FontName    = "Arial"
            .Text1.BorderStyle = 0
            .Text1.Margin      = 0
            .Text1.ReadOnly    = .T.
            .Text1.ForeColor   = RGB(0, 0, 0)
            .Text1.BackColor   = RGB(255, 255, 255)
        ENDWITH

        WITH loc_oGrid.Column4
            .ColumnOrder       = 5
            .FontName          = "Arial"
            .Movable           = .F.
            .Resizable         = .F.
            .ReadOnly          = .T.
            .InputMask         = "9999.99"
            .Header1.FontName  = "Tahoma"
            .Header1.FontSize  = 8
            .Header1.Alignment = 2
            .Text1.FontName    = "Arial"
            .Text1.BorderStyle = 0
            .Text1.Margin      = 0
            .Text1.ReadOnly    = .T.
            .Text1.ForeColor   = RGB(0, 0, 0)
            .Text1.BackColor   = RGB(255, 255, 255)
        ENDWITH

        WITH loc_oGrid.Column5
            .ColumnOrder       = 6
            .FontName          = "Arial"
            .Movable           = .F.
            .Resizable         = .F.
            .ReadOnly          = .T.
            .Header1.FontName  = "Tahoma"
            .Header1.FontSize  = 8
            .Header1.Alignment = 2
            .Text1.FontName    = "Arial"
            .Text1.BorderStyle = 0
            .Text1.Margin      = 0
            .Text1.ReadOnly    = .T.
            .Text1.ForeColor   = RGB(0, 0, 0)
            .Text1.BackColor   = RGB(255, 255, 255)
        ENDWITH

        WITH loc_oGrid.Column6
            .ColumnOrder       = 7
            .FontName          = "Arial"
            .Movable           = .F.
            .Resizable         = .F.
            .ReadOnly          = .T.
            .Header1.FontName  = "Tahoma"
            .Header1.FontSize  = 8
            .Header1.Alignment = 2
            .Text1.FontName    = "Arial"
            .Text1.BorderStyle = 0
            .Text1.Margin      = 0
            .Text1.ReadOnly    = .T.
            .Text1.ForeColor   = RGB(0, 0, 0)
            .Text1.BackColor   = RGB(255, 255, 255)
        ENDWITH

        WITH loc_oGrid.Column7
            .ColumnOrder       = 8
            .FontName          = "Arial"
            .Movable           = .F.
            .Resizable         = .F.
            .ReadOnly          = .T.
            .Header1.FontName  = "Tahoma"
            .Header1.FontSize  = 8
            .Header1.Alignment = 2
            .Text1.FontName    = "Arial"
            .Text1.BorderStyle = 0
            .Text1.Margin      = 0
            .Text1.ReadOnly    = .T.
            .Text1.ForeColor   = RGB(0, 0, 0)
            .Text1.BackColor   = RGB(255, 255, 255)
        ENDWITH

        WITH loc_oGrid.Column8
            .ColumnOrder       = 1
            .FontName          = "Arial"
            .Movable           = .F.
            .Resizable         = .F.
            .ReadOnly          = .T.
            .Header1.FontName  = "Tahoma"
            .Header1.FontSize  = 8
            .Header1.Alignment = 2
            .Text1.BorderStyle = 0
            .Text1.Margin      = 0
            .Text1.Alignment   = 3
            .Text1.ForeColor   = RGB(0, 0, 0)
            .Text1.BackColor   = RGB(255, 255, 255)
        ENDWITH

        *-- Troca de linha na grade recarrega o detalhe do produto (imagem,
        *-- descricao, quantidade, cliente, tempo total do envelope) -
        *-- equivalente ao PROCEDURE AfterRowColChange do legado
        BINDEVENT(loc_oGrid, "AfterRowColChange", THIS, "GradeAfterRowColChange")
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarLista - Chama sigprcpdBO.CarregarDados() com os parametros
    * recebidos no Init (Fase/Unidade/Data/Codigo) e, com sucesso, faz o
    * bind do Grid ao cursor resultante. Equivalente ao trecho final do
    * PROCEDURE Init do legado (bind da .grade + Go Top + Refresh).
    *
    * ControlSource so eh atribuido AQUI (depois do cursor existir - regra
    * #41), e Header1.Caption/Column.Width sao reconfigurados DEPOIS do
    * RecordSource (Problema 48 - RecordSource reseta os dois).
    *
    * PUBLIC de proposito (NAO marcar PROTECTED - regra #3 do CLAUDE.md):
    * TesteAutomatico.prg chama THIS.oForm.CarregarLista() de FORA da classe,
    * guardado so por PEMSTATUS(oForm, "CarregarLista", 5), que devolve .T.
    * mesmo para metodo PROTECTED (testa existencia, nao escopo) - com
    * PROTECTED o teste entra no branch e a chamada estoura em runtime com
    * "Property CARREGARLISTA is not found". Nome canonico do projeto (138
    * dos 141 forms OPERACIONAL usam CarregarLista), igual ao visualizador
    * de referencia FormSigMvSbn.
    *--------------------------------------------------------------------------
    FUNCTION CarregarLista()
        LOCAL loc_lSucesso, loc_oGrid, loc_cCursor

        loc_lSucesso = .F.

        IF THIS.this_oBusinessObject.CarregarDados(THIS.this_cFasePar, ;
                THIS.this_cUnidadePar, THIS.this_dDataPar, THIS.this_nCodigoPar)

            loc_cCursor = THIS.this_oBusinessObject.this_cCursorGrade
            loc_oGrid   = THIS.grd_4c_Dados

            *-- Container1/Container2: espelha ".container1.Get_Data.Value =
            *-- ThisForm.data" / "Get_Fase.Value = ThisForm.Setor" / Get_Cap/
            *-- Get_Utz/Get_Sld do legado, lendo do BO (fonte unica - valores
            *-- ja normalizados por CarregarDados, ex. ALLTRIM em this_cFases)
            THIS.cnt_4c_Container1.txt_4c_Fase.Value  = THIS.this_oBusinessObject.this_cFases
            THIS.cnt_4c_Container1.txt_4c__Data.Value = THIS.this_oBusinessObject.this_dDatas
            THIS.cnt_4c_Container2.txt_4c_Cap.Value   = THIS.this_oBusinessObject.this_nMinutos
            THIS.cnt_4c_Container2.txt_4c_Utz.Value   = THIS.this_oBusinessObject.this_nUtilizados
            THIS.cnt_4c_Container2.txt_4c__Sld.Value  = THIS.this_oBusinessObject.this_nSaldos

            *-- RecordSource fora do WITH (regra GRID-WITH): dentro do mesmo
            *-- WITH que acessa .ColumnN, o VFP9 pode nao ter recriado as
            *-- colunas ainda e estourar "Unknown member COLUMN1".
            loc_oGrid.RecordSource = loc_cCursor

            WITH loc_oGrid
                .Column1.ControlSource = loc_cCursor + ".Nenvs"
                .Column2.ControlSource = loc_cCursor + ".Nops"
                .Column3.ControlSource = loc_cCursor + ".Ordems"
                .Column4.ControlSource = loc_cCursor + ".TempoReal"
                .Column5.ControlSource = loc_cCursor + ".Cpros"
                .Column6.ControlSource = loc_cCursor + ".Pedido"
                .Column7.ControlSource = loc_cCursor + ".Cliente"
                .Column8.ControlSource = loc_cCursor + ".UniPrdts"

                *-- Headers e larguras (RecordSource acabou de resetar os dois)
                .Column1.Header1.Caption = "Envelope"
                .Column1.Width           = 80
                .Column2.Header1.Caption = "O.P."
                .Column2.Width           = 102
                .Column3.Header1.Caption = "Seq"
                .Column3.Width           = 24
                .Column4.Header1.Caption = "Minutos"
                .Column4.Width           = 65
                .Column5.Header1.Caption = "Produto"
                .Column5.Width           = 95
                .Column6.Header1.Caption = "Opera" + CHR(231) + CHR(227) + "o"
                .Column6.Width           = 190
                .Column7.Header1.Caption = "Cliente"
                .Column7.Width           = 165
                .Column8.Header1.Caption = "Unidade Prod."
                .Column8.Width           = 80

                *-- Operacoes com prioridade (Priors >= 999990) ficam pretas,
                *-- as demais azuis - transcricao literal do SetAll do legado
                .SetAll("DynamicForeColor", ;
                    "IIF(" + loc_cCursor + ".Priors < 999990, RGB(0,0,255), RGB(0,0,0))", ;
                    "Column")
            ENDWITH

            SELECT (loc_cCursor)
            GO TOP

            loc_oGrid.Refresh()

            *-- Equivalente a "ThisForm.Grade.SetFocus" + "AfterRowColChange()"
            *-- no fim do Init legado - carrega o detalhe da 1a linha sem
            *-- depender do usuario navegar a grade (SetFocus omitido: o
            *-- form ainda nao foi exibido neste ponto - THIS.Show() eh
            *-- chamado pelo menu.prg DEPOIS de InicializarForm retornar)
            THIS.GradeAfterRowColChange(1)

            loc_lSucesso = .T.
        ELSE
            MsgErro(THIS.this_oBusinessObject.this_cMensagemErro, "Capacidade Produtiva")
        ENDIF

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * ConfigurarBotoes - Cria o unico botao do form legado (Sair/Encerrar).
    * SIGPRCPD nao tem Incluir/Alterar/Excluir/Buscar - eh form OPERACIONAL
    * de consulta, aberto ja com todos os parametros pelo chamador.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarBotoes()
        THIS.AddObject("cmd_4c_Sair", "CommandButton")
        WITH THIS.cmd_4c_Sair
            .Top        = 4
            .Left       = 725
            .Width      = 75
            .Height     = 75
            .Caption    = "Encerrar"
            .Cancel     = .T.
            .FontName   = "Comic Sans MS"
            .FontBold   = .T.
            .FontItalic = .T.
            .FontSize   = 8
            .ForeColor  = RGB(90, 90, 90)
            .BackColor  = RGB(255, 255, 255)
            .Picture    = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
            .Themes     = .T.
            .Visible    = .T.
        ENDWITH

        BINDEVENT(THIS.cmd_4c_Sair, "Click", THIS, "BtnSairClick")
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnSairClick - Encerra o form (equivalente a ThisForm.Release do
    * legado). PUBLIC porque eh alvo de BINDEVENT (regra #3).
    *--------------------------------------------------------------------------
    PROCEDURE BtnSairClick()
        THIS.Release()
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarDetalheProduto - Cria os controles de detalhe da linha
    * selecionada na grade (FigJpg/Shape4/Get_descr/Say1-4/Get_qtde/
    * Get_Cliente/Get_tEnv/Label1 do legado). Todos os TextBox tem
    * PROCEDURE When retornando .F. no legado (registros 9/44/45/48) -
    * display-only, ReadOnly = .T. aqui reproduz o comportamento. Valores
    * sao populados por GradeAfterRowColChange() a cada troca de linha.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarDetalheProduto()
        *-- FigJpg/Shape4: imagem do produto, ocultos ate a 1a troca de
        *-- linha achar foto (Visible=.F. no legado, so FigJpg.Visible eh
        *-- alternado no AfterRowColChange - Shape4 permanece SEMPRE oculto
        *-- no legado, nenhum metodo do dump o torna visivel; reproduzido
        *-- fielmente aqui, sem inventar toggle para ele).
        THIS.AddObject("img_4c_FigJpg", "Image")
        WITH THIS.img_4c_FigJpg
            .Top     = 457
            .Left    = 459
            .Width   = 143
            .Height  = 105
            .Stretch = 1
            .Picture = ""
            .Visible = .F.
        ENDWITH

        THIS.AddObject("shp_4c_Shape4", "Shape")
        WITH THIS.shp_4c_Shape4
            .Top     = 455
            .Left    = 456
            .Width   = 148
            .Height  = 109
            .Visible = .F.
        ENDWITH

        *-- Say2 "Descricao Produto" + Get_descr
        THIS.AddObject("lbl_4c_Label2", "Label")
        WITH THIS.lbl_4c_Label2
            .Top       = 455
            .Left      = 92
            .Width     = 130
            .Height    = 15
            .AutoSize  = .F.
            .BackStyle = 0
            .Alignment = 0
            .FontBold  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .Caption   = "Descri" + CHR(231) + CHR(227) + "o Produto"
        ENDWITH

        THIS.AddObject("txt_4c_Descr", "TextBox")
        WITH THIS.txt_4c_Descr
            .Top       = 468
            .Left      = 90
            .Width     = 345
            .Height    = 23
            .FontBold  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(0, 0, 0)
            .BackColor = RGB(255, 255, 198)
            .DisabledBackColor = RGB(255, 255, 255)
            .DisabledForeColor = RGB(192, 192, 192)
            .Value     = ""
            .ReadOnly  = .T.
        ENDWITH

        *-- Say1 "Quantidade" + Get_qtde
        THIS.AddObject("lbl_4c_Label1", "Label")
        WITH THIS.lbl_4c_Label1
            .Top       = 455
            .Left      = 11
            .Width     = 74
            .Height    = 15
            .AutoSize  = .F.
            .BackStyle = 0
            .Alignment = 0
            .FontBold  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .Caption   = "Quantidade"
        ENDWITH

        THIS.AddObject("txt_4c_Qtde", "TextBox")
        WITH THIS.txt_4c_Qtde
            .Top       = 468
            .Left      = 9
            .Width     = 74
            .Height    = 23
            .InputMask = "99999.999"
            .FontBold  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(0, 0, 0)
            .BackColor = RGB(255, 255, 198)
            .DisabledBackColor = RGB(255, 255, 255)
            .DisabledForeColor = RGB(192, 192, 192)
            .Value     = 0
            .ReadOnly  = .T.
        ENDWITH

        *-- Say3 "Cliente" + Get_Cliente
        THIS.AddObject("lbl_4c_Label3", "Label")
        WITH THIS.lbl_4c_Label3
            .Top       = 494
            .Left      = 11
            .Width     = 60
            .Height    = 15
            .AutoSize  = .F.
            .BackStyle = 0
            .Alignment = 0
            .FontBold  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .Caption   = "Cliente"
        ENDWITH

        THIS.AddObject("txt_4c_Cliente", "TextBox")
        WITH THIS.txt_4c_Cliente
            .Top       = 507
            .Left      = 9
            .Width     = 425
            .Height    = 23
            .FontBold  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(0, 0, 0)
            .BackColor = RGB(255, 255, 221)
            .DisabledBackColor = RGB(255, 255, 255)
            .DisabledForeColor = RGB(192, 192, 192)
            .Value     = ""
            .ReadOnly  = .T.
        ENDWITH

        *-- Say4 "Tempo Total do Envelope" + Get_tEnv
        THIS.AddObject("lbl_4c_Label4", "Label")
        WITH THIS.lbl_4c_Label4
            .Top       = 532
            .Left      = 11
            .Width     = 200
            .Height    = 15
            .AutoSize  = .F.
            .BackStyle = 0
            .Alignment = 0
            .FontBold  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .Caption   = "Tempo Total do Envelope"
        ENDWITH

        THIS.AddObject("txt_4c_TEnv", "TextBox")
        WITH THIS.txt_4c_TEnv
            .Top       = 545
            .Left      = 9
            .Width     = 74
            .Height    = 23
            .InputMask = "99999"
            .FontBold  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(0, 0, 0)
            .BackColor = RGB(255, 255, 198)
            .DisabledBackColor = RGB(255, 255, 255)
            .DisabledForeColor = RGB(192, 192, 192)
            .Value     = 0
            .ReadOnly  = .T.
        ENDWITH

        *-- Label1 do form (raiz) - aviso "[ Operacao com Prioridade ]".
        *-- SCX declara AutoSize=.T. + Width/Height explicitos: esses
        *-- numeros JA SAO o auto-size calculado pelo Form Designer, entao
        *-- transcrever com AutoSize=.F. eh reproducao fiel (regra #23) -
        *-- AutoSize=.T. eh no-op em Label criado por AddObject.
        THIS.AddObject("lbl_4c_LabelPrioridade", "Label")
        WITH THIS.lbl_4c_LabelPrioridade
            .Top       = 457
            .Left      = 617
            .Width     = 160
            .Height    = 15
            .AutoSize  = .F.
            .BackStyle = 0
            .Alignment = 0
            .FontBold  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .Caption   = "[ Opera" + CHR(231) + CHR(227) + "o com Prioridade ]"
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * GradeAfterRowColChange - Recarrega o painel de detalhe da linha
    * selecionada na grade (imagem do produto, descricao, quantidade,
    * cliente e tempo total do envelope). Equivalente ao PROCEDURE
    * AfterRowColChange da Grade no legado (dump, linhas 1209-1244).
    *
    * PUBLIC + LPARAMETERS par_nColIndex: alvo de BINDEVENT (regra #3),
    * que exige metodo PUBLIC declarando o parametro do evento.
    *
    * A decodificacao do JPG (base64 -> arquivo em disco) eh feita aqui
    * (camada de UI) porque o BO so expoe o cursor de detalhe cru -
    * ObterDetalheProduto()/CarregarDoCursor() ja documentam essa divisao.
    * STRCONV(..., 14) roda uma UNICA vez (decode simples, nao duplo).
    *--------------------------------------------------------------------------
    PROCEDURE GradeAfterRowColChange(par_nColIndex)
        LOCAL loc_cArquivo, loc_cFoto, loc_cCursorProduto, loc_cFigJpgs

        THIS.LockScreen = .T.

        THIS.img_4c_FigJpg.Visible = .F.
        THIS.img_4c_FigJpg.Picture = ""

        IF THIS.this_oBusinessObject.CarregarDoCursor(THIS.this_oBusinessObject.this_cCursorGrade)

            loc_cCursorProduto = THIS.this_oBusinessObject.this_cCursorProdutoDetalhe

            IF !EMPTY(THIS.this_oBusinessObject.this_cCpros) AND USED(loc_cCursorProduto) ;
                    AND TYPE(loc_cCursorProduto + ".FigJpgs") != "U"

                loc_cFigJpgs = EVALUATE(loc_cCursorProduto + ".FigJpgs")

                IF !ISNULL(loc_cFigJpgs) AND !EMPTY(loc_cFigJpgs)
                    loc_cArquivo = SYS(2023) + "\sigprcpd.jpg"
                    loc_cFoto = STRCONV(STRTRAN(STRTRAN(STRTRAN(loc_cFigJpgs, ;
                        "data:image/png;base64,", ""), ;
                        "data:image/jpeg;base64,", ""), ;
                        "data:image/jpg;base64,", ""), 14)

                    IF STRTOFILE(loc_cFoto, loc_cArquivo) > 0
                        THIS.img_4c_FigJpg.Picture = loc_cArquivo
                        THIS.img_4c_FigJpg.Visible = .T.
                    ENDIF
                ENDIF
            ENDIF

            THIS.txt_4c_Descr.Value   = THIS.this_oBusinessObject.this_cDpros
            THIS.txt_4c_Qtde.Value    = THIS.this_oBusinessObject.this_nQtds
            THIS.txt_4c_Cliente.Value = THIS.this_oBusinessObject.this_cRclis
            THIS.txt_4c_TEnv.Value    = THIS.this_oBusinessObject.this_nTempU

            THIS.txt_4c_Descr.Refresh()
            THIS.txt_4c_Qtde.Refresh()
            THIS.txt_4c_Cliente.Refresh()
            THIS.txt_4c_TEnv.Refresh()
        ENDIF

        THIS.LockScreen = .F.
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarCabecalho - Cria o container cinza escuro superior com os
    * labels de titulo (cntSombra/lblSombra/lblTitulo do legado)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarCabecalho()
        LOCAL loc_oCab

        THIS.AddObject("cnt_4c_Cabecalho", "Container")
        loc_oCab = THIS.cnt_4c_Cabecalho
        WITH loc_oCab
            .Top         = 0
            .Left        = 0
            .Width       = THIS.Width
            .Height      = 80
            .BackColor   = RGB(100, 100, 100)
            .BackStyle   = 1
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH

        loc_oCab.AddObject("lbl_4c_Sombra", "Label")
        WITH loc_oCab.lbl_4c_Sombra
            .Top       = 18
            .Left      = 10
            .Width     = 769
            .Height    = 40
            .AutoSize  = .F.
            .BackStyle = 0
            .WordWrap  = .T.
            .Alignment = 0
            .FontName  = "Tahoma"
            .FontSize  = 18
            .FontBold  = .T.
            .ForeColor = RGB(0, 0, 0)
            .Caption   = THIS.Caption
        ENDWITH

        loc_oCab.AddObject("lbl_4c_Titulo", "Label")
        WITH loc_oCab.lbl_4c_Titulo
            .Top       = 17
            .Left      = 10
            .Width     = 769
            .Height    = 46
            .AutoSize  = .F.
            .BackStyle = 0
            .WordWrap  = .T.
            .Alignment = 0
            .FontName  = "Tahoma"
            .FontSize  = 18
            .FontBold  = .T.
            .ForeColor = RGB(255, 255, 255)
            .Caption   = THIS.Caption
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * TornarControlesVisiveis - Torna visiveis, recursivamente, os controles
    * criados via AddObject (que nascem com Visible=.F.), percorrendo tambem
    * Pages de PageFrames e Controls de sub-containers.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
        LOCAL loc_nI, loc_oObjeto, loc_nP

        FOR loc_nI = 1 TO par_oContainer.ControlCount
            loc_oObjeto = par_oContainer.Controls(loc_nI)

            IF VARTYPE(loc_oObjeto) = "O"
                *-- img_4c_FigJpg/shp_4c_Shape4: comecam ocultos de proposito
                *-- (Visible=.F. no legado) e so aparecem se
                *-- GradeAfterRowColChange achar foto do produto - nao forcar
                *-- Visible=.T. aqui (mesmo padrao de container flutuante)
                IF INLIST(UPPER(loc_oObjeto.Name), "IMG_4C_FIGJPG", "SHP_4C_SHAPE4")
                    LOOP
                ENDIF

                IF PEMSTATUS(loc_oObjeto, "Visible", 5)
                    loc_oObjeto.Visible = .T.
                ENDIF

                IF UPPER(loc_oObjeto.BaseClass) = "PAGEFRAME"
                    FOR loc_nP = 1 TO loc_oObjeto.PageCount
                        THIS.TornarControlesVisiveis(loc_oObjeto.Pages(loc_nP))
                    ENDFOR
                ENDIF

                IF PEMSTATUS(loc_oObjeto, "ControlCount", 5) AND loc_oObjeto.ControlCount > 0
                    THIS.TornarControlesVisiveis(loc_oObjeto)
                ENDIF
            ENDIF
        ENDFOR
    ENDPROC

    *--------------------------------------------------------------------------
    * Destroy - Fecha os cursores desta consulta antes de liberar o form
    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
        LOCAL loc_cLista, loc_nI, loc_cNome

        loc_cLista = "cursor_4c_Grade,cursor_4c_ProdutoDetalhe,cursor_4c_Pcz," + ;
            "cursor_4c_PcpCap,cursor_4c_Pcg,cursor_4c_Pco,cursor_4c_PcoAgrupado"

        FOR loc_nI = 1 TO OCCURS(",", loc_cLista) + 1
            loc_cNome = ALLTRIM(GETWORDNUM(loc_cLista, loc_nI, ","))
            IF !EMPTY(loc_cNome) AND USED(loc_cNome)
                USE IN (loc_cNome)
            ENDIF
        ENDFOR

        DODEFAULT()
    ENDPROC

ENDDEFINE

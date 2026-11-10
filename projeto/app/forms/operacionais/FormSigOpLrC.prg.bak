*==============================================================================
* FormSigOpLrC.prg - Liberacao de Credito
* Origem: tasks/task765/SigOpLrC.SCX (SIGOPLRC)
* Herda de: FormBase
* Tipo: OPERACIONAL (dialogo MODAL, aberto por outro form - ex.: Caixa - para
*       validar limite de credito/saldo em C/C/cheques/pendencias de uma
*       Conta antes de autorizar a gravacao de um movimento). NAO segue o
*       padrao Page1=Lista/Page2=Dados do CRUD - layout customizado com tres
*       containers flutuantes (legado: Container1/2/3) que o BO mostra ou
*       esconde conforme a operacao e o lado da conta em analise.
*       Aberto com: CREATEOBJECT("FormSigOpLrC", oFormPai, cOperacao, nOriDes, oFormCaixa)
*       DataSession=1: acessa cursores do form pai (TprMvCab) diretamente
*==============================================================================

DEFINE CLASS FormSigOpLrC AS FormBase

    Height       = 600
    Width        = 1000
    AutoCenter   = .T.
    ShowTips     = .T.
    ShowWindow   = 1
    WindowType   = 1
    ControlBox   = .F.
    Closable     = .F.
    MaxButton    = .F.
    MinButton    = .F.
    ClipControls = .F.
    TitleBar     = 0
    AlwaysOnTop  = .T.
    BorderStyle  = 2
    DataSession  = 1

    *-- Parametros recebidos do form pai (legado: lparameters loForm, pOperacao, pOriDes, loForm2)
    this_oParentForm  = .NULL.   && ThisForm.ParentForm / loForm
    this_oFormCaixa   = .NULL.   && ThisForm.PoFormCaixa / loForm2 - reabilitado ao fechar
    this_cOperacao    = ""       && ThisForm.Operacao / pOperacao - SigCdOpe.Dopes
    this_nOriDes      = 0        && ThisForm.OriDes / pOriDes - 0=indefinido, 1=Origem, 2=Destino
    this_nClickOriDes = 0        && ThisForm.ClickOriDes - lado escolhido pelo clique do usuario
    this_lRetorno     = .T.      && ThisForm.Retorno - lido pelo form pai apos o Show() modal

    *-- Alias do cursor do form PAI com o cabecalho do movimento em lancamento
    *-- (legado: TprMvCab, alcancado por "set datasession to loForm.DataSessionId").
    *-- Default = o nome do legado; o chamador pode troca-lo antes do Show() se
    *-- usar outro alias. DataSession=1 (ver cabecalho) eh o que torna o cursor
    *-- do pai visivel aqui.
    this_cAliasMovCab = "TprMvCab"

    *-- Guardas da troca de lado (CheckBox Sit_Origem/Sit_Destino). No legado os
    *-- dois Click chamam UM AO OUTRO quando Processa() nao acende container
    *-- nenhum ("If Not ThisForm.Processa() / ThisForm.Sit_Destino.Click()") -
    *-- ping-pong que so termina quando algum dos lados acende algo; nao
    *-- terminando, o VFP estoura o limite de aninhamento. Aqui a ida-e-volta eh
    *-- limitada a UM salto por clique do usuario, que eh exatamente o unico
    *-- caso em que o legado para: this_lEmTrocaDeLado barra a reentrancia pelo
    *-- proprio evento (o Value/Refresh do handler redispara Click) e
    *-- this_lLadoOpostoTentado barra a segunda volta.
    this_lEmTrocaDeLado     = .F.
    this_lLadoOpostoTentado = .F.

    *-- .T. quando NENHUM dos dois lados acendeu container algum: nao ha nada
    *-- para o usuario ver, e o legado fechava a tela no proprio Init
    *-- (ThisForm.Release). Lido por Activate() - ver a nota la.
    this_lDialogoVazio = .F.

    *-- Alias que alimenta a grade (legado: DbOpera). MESMO nome que
    *-- SigOpLrCBO.this_cCursorOperacoes - os dois lados compartilham o cursor.
    this_cCursorGrade = "cursor_4c_Operacoes"

    *==========================================================================
    * Init - recebe os parametros do form pai (legado: lparameters loForm,
    * pOperacao, pOriDes, loForm2) antes de delegar a FormBase.Init()
    *==========================================================================
    PROCEDURE Init()
        LPARAMETERS par_oParentForm, par_cOperacao, par_nOriDes, par_oFormCaixa

        LOCAL loc_oErro
        TRY
            THIS.Caption = "Libera" + CHR(231) + CHR(227) + "o de Cr" + CHR(233) + "dito"

            IF VARTYPE(par_oParentForm) = "O"
                THIS.this_oParentForm = par_oParentForm
            ENDIF
            IF VARTYPE(par_oFormCaixa) = "O"
                THIS.this_oFormCaixa = par_oFormCaixa
            ENDIF

            THIS.this_cOperacao    = TratarNulo(par_cOperacao, "")
            THIS.this_nOriDes      = TratarNulo(par_nOriDes, 0)
            THIS.this_nClickOriDes = 0
            THIS.this_lRetorno     = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + "Linha: " + TRANSFORM(loc_oErro.LineNo) + ;
                CHR(13) + "Procedure: " + loc_oErro.Procedure, "Erro em Init")
        ENDTRY

        RETURN DODEFAULT()
    ENDPROC

    *==========================================================================
    * InicializarForm - cria o Business Object e monta a estrutura visual base
    *==========================================================================
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lSucesso, loc_lBypassTeste, loc_oErro
        loc_lSucesso = .F.

        TRY
            THIS.Picture = gc_4c_CaminhoIcones + "new_background.jpg"

            THIS.this_oBusinessObject = CREATEOBJECT("SigOpLrCBO")
            IF VARTYPE(THIS.this_oBusinessObject) = "O"
                THIS.ConfigurarPageFrame()

                THIS.cnt_4c_Sombra.lbl_4c_LblSombra.Caption = THIS.Caption
                THIS.cnt_4c_Sombra.lbl_4c_LblTitulo.Caption = THIS.Caption

                THIS.TornarControlesVisiveis(THIS)

                *-- Vincula a grade ao cursor, que neste ponto existe e esta
                *-- vazio (a carga real vem do BO). Feito DEPOIS de
                *-- TornarControlesVisiveis para que a grade ja esteja com
                *-- Visible=.T. dentro do painel.
                THIS.CarregarDados()

                *-- Estado INICIAL dos dois paineis de conta, pelo MESMO funil
                *-- que os mantem depois: o legado abre Processa() escondendo
                *-- Container2/Container3 e so os acende quando a conta tem
                *-- observacao cadastrada / situacao que exiba bloqueio. Como o
                *-- BO ainda nao processou nada, os dois metodos aqui apenas
                *-- recolhem os paineis e apagam a linha de bloqueio - evitando
                *-- que o estado inicial seja definido num lugar e mantido em
                *-- outro, que eh como a mensagem de um lado sobrevive ao outro.
                THIS.AtualizarContainer2()
                THIS.AtualizarContainer3()

                *-- Processamento de ABERTURA (legado: fecho do Init, que chama
                *-- Processa() e, nao acendendo painel, tenta o lado oposto).
                *-- Vem DEPOIS da montagem visual porque pinta a tela, e sob
                *-- guarda porque o harness de teste instancia o form SEM
                *-- parametro algum e sem conexao - sem a guarda o SQLEXEC do
                *-- BO abriria dialogo e travaria o teste. A guarda NUNCA
                *-- derruba o InicializarForm: parametro ausente nao eh falha
                *-- de inicializacao, so significa que nao ha o que processar.
                loc_lBypassTeste = (TYPE("gb_4c_ModoTeste") = "L" AND gb_4c_ModoTeste) OR ;
                    (TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI)

                IF !loc_lBypassTeste AND !EMPTY(THIS.this_cOperacao) AND ;
                        TYPE("gnConnHandle") = "N" AND gnConnHandle > 0
                    THIS.ProcessarAberturaDialogo()
                ENDIF

                loc_lSucesso = .T.
            ELSE
                MsgErro("Falha ao criar SigOpLrCBO.", "Erro em InicializarForm")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + "Linha: " + TRANSFORM(loc_oErro.LineNo) + ;
                CHR(13) + "Procedure: " + loc_oErro.Procedure, "Erro em InicializarForm")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * ConfigurarPageFrame - orquestra a montagem visual do form OPERACIONAL.
    * NAO ha PageFrame real (nao segue Page1=Lista/Page2=Dados do CRUD): o
    * metodo delega para o cabecalho e para os tres containers flutuantes
    * (Limite/Saldo/Pendencias, Observacao da Conta, Situacao da Conta) que o
    * legado mostra ou esconde em Processa() conforme a operacao e o lado da
    * conta em analise.
    *
    * ORDEM DE CRIACAO - o legado cria os objetos nesta sequencia (SECAO 1 do
    * dump): cntSombra, Container1, Container2, Container3, Sit_Origem,
    * Sit_Destino, ok. AddObject empilha o ultimo no TOPO do z-order, entao a
    * sequencia abaixo tem de ser preservada: o botao Encerrar (Top 3..78) fica
    * SOBRE a faixa do cabecalho (Top 0..80) e so aparece porque eh criado
    * depois dela. Quem acrescentar os CheckBox Sit_Origem/Sit_Destino (Top
    * 143/179, Left 754 - sobre a area do Container1) deve inseri-los ENTRE
    * ConfigurarContainer3() e ConfigurarBotoes(), nunca no fim.
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPageFrame()
        THIS.ConfigurarCabecalho()
        THIS.ConfigurarContainer1()
        THIS.ConfigurarContainer2()
        THIS.ConfigurarContainer3()
        THIS.ConfigurarCheckBoxesLado()
        THIS.ConfigurarBotoes()
        THIS.ConfigurarEventos()
    ENDPROC

    *==========================================================================
    * ConfigurarCabecalho - container escuro superior com labels de titulo
    * Legado: cntSombra Top=0, Left=0, Width=1005, Height=80, BackColor=100,100,100
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarCabecalho()
        LOCAL loc_oCab

        THIS.AddObject("cnt_4c_Sombra", "Container")
        loc_oCab = THIS.cnt_4c_Sombra
        WITH loc_oCab
            .Top         = 0
            .Left        = 0
            .Width       = THIS.Width
            .Height      = 80
            .BackColor   = RGB(100, 100, 100)
            .BackStyle   = 1
            .BorderWidth = 0
        ENDWITH

        loc_oCab.AddObject("lbl_4c_LblSombra", "Label")
        WITH loc_oCab.lbl_4c_LblSombra
            .AutoSize      = .F.
            .Width         = loc_oCab.Width - 20
            .Height        = 40
            .Top           = 18
            .Left          = 10
            .FontName      = "Tahoma"
            .FontSize      = 18
            .FontBold      = .T.
            .FontUnderline = .F.
            .Alignment     = 0
            .BackStyle     = 0
            .WordWrap      = .T.
            .ForeColor     = RGB(0, 0, 0)
            .Caption       = THIS.Caption
        ENDWITH

        loc_oCab.AddObject("lbl_4c_LblTitulo", "Label")
        WITH loc_oCab.lbl_4c_LblTitulo
            .AutoSize  = .F.
            .Width     = loc_oCab.Width - 20
            .Height    = 46
            .Top       = 17
            .Left      = 10
            .FontName  = "Tahoma"
            .FontSize  = 18
            .FontBold  = .T.
            .Alignment = 0
            .BackStyle = 0
            .WordWrap  = .T.
            .ForeColor = RGB(255, 255, 255)
            .Caption   = THIS.Caption
        ENDWITH
    ENDPROC

    *==========================================================================
    * ConfigurarContainer1 - casca do bloco "Limite de Credito / Movimentos em
    * Aberto / Saldo C/C / Cheques / Disponivel" (legado: Container1).
    * Comeca OCULTO (AddObject nasce Visible=.F.) - o legado zera a
    * visibilidade no inicio de Processa() e so reexibe quando a conta
    * analisada esta sujeita a limite de credito (SigCdOpe.LimCres). A grade de
    * movimentos em aberto deste bloco eh criada por ConfigurarGrade().
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarContainer1()
        THIS.AddObject("cnt_4c_Container1", "Container")
        WITH THIS.cnt_4c_Container1
            .Top           = 81
            .Left          = 9
            .Width         = 890
            .Height        = 253
            .BackStyle     = 0
            .BorderWidth   = 2
            .SpecialEffect = 2
            .BackColor     = RGB(188, 201, 254)
            .Visible     = .T.
        ENDWITH

        *-- Grade dos movimentos em aberto (legado: Container1.Grade)
        THIS.ConfigurarGrade(THIS.cnt_4c_Container1)

        *-- Labels/TextBoxes de leitura (legado: Label1, get_nconta, Say1..Say9
        *-- e os nove get_*) - todos em ConfigurarCamposContainer1
        THIS.ConfigurarCamposContainer1(THIS.cnt_4c_Container1)
    ENDPROC

    *==========================================================================
    * ConfigurarCamposContainer1 - PRIMEIRA METADE dos campos de leitura do
    * bloco "Limite de Credito" (legado: Container1). Todos os TextBoxes deste
    * bloco tem Procedure When retornando .f. no legado (comportamento.json) -
    * sao SOMENTE LEITURA, preenchidos pelo BO/Processa(), nunca digitados pelo
    * usuario. Por isso .ReadOnly = .T. aqui NAO viola a regra de "nao inventar
    * ReadOnly": o legado ja nega a entrada em TODOS eles.
    *
    * Labels "say" sem Width/Alignment no dump (AutoSize=.T./Alignment=0 da
    * classe) - AutoSize eh no-op em Label por AddObject, entao a Width eh
    * calculada para terminar poucos pixels antes do TextBox (Left=159),
    * igual ao padrao medido em Say9 (unico que declara Width=120 ~ termina em
    * 156, 3px antes do get_PendOutr em 159).
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarCamposContainer1(par_oContainer)
        *-- Label1 (legado: Container1.Label1) - subtitulo do bloco
        par_oContainer.AddObject("lbl_4c_Label1", "Label")
        WITH par_oContainer.lbl_4c_Label1
            .AutoSize  = .F.
            .Top       = 0
            .Left      = 5
            .Width     = 157
            .Height    = 20
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .T.
            .Alignment = 0
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Caption   = "Libera" + CHR(231) + CHR(227) + "o de Cr" + CHR(233) + "dito"
        ENDWITH

        *-- get_nconta (legado: Container1.get_nconta) - rotulo "Cliente",
        *-- a Caption real (codigo + nome da conta) e atribuida por Processa()
        par_oContainer.AddObject("lbl_4c_GetNConta", "Label")
        WITH par_oContainer.lbl_4c_GetNConta
            .AutoSize  = .F.
            .Top       = 25
            .Left      = 30
            .Width     = 41
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Alignment = 0
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Caption   = "Cliente"
        ENDWITH

        *-- Say6 / get_moeda (legado: top=30/26, left=115/159, width get=31)
        par_oContainer.AddObject("lbl_4c_Say6", "Label")
        WITH par_oContainer.lbl_4c_Say6
            .AutoSize  = .F.
            .Top       = 30
            .Left      = 115
            .Width     = 41
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Alignment = 0
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Caption   = "Moeda :"
        ENDWITH

        par_oContainer.AddObject("txt_4c_Moeda", "TextBox")
        WITH par_oContainer.txt_4c_Moeda
            .Top       = 26
            .Left      = 159
            .Width     = 31
            .Height    = 23
            .FontName  = "Courier New"
            .FontSize  = 8
            .Value     = ""
            .Enabled   = .T.
            .ReadOnly  = .T.
            .TabStop   = .F.
        ENDWITH

        *-- Say8 / get_cotacao (legado: top=55/51, left=112/159)
        par_oContainer.AddObject("lbl_4c_Say8", "Label")
        WITH par_oContainer.lbl_4c_Say8
            .AutoSize  = .F.
            .Top       = 55
            .Left      = 112
            .Width     = 44
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Alignment = 0
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Caption   = "C" + CHR(226) + "mbio :"
        ENDWITH

        par_oContainer.AddObject("txt_4c_Cotacao", "TextBox")
        WITH par_oContainer.txt_4c_Cotacao
            .Top       = 51
            .Left      = 159
            .Width     = 119
            .Height    = 23
            .FontName  = "Courier New"
            .FontSize  = 8
            .InputMask = "99,999.9999"
            .Value     = 0
            .Enabled   = .T.
            .ReadOnly  = .T.
            .TabStop   = .F.
        ENDWITH

        *-- Say1 / get_limcred (legado: top=80/76, left=82/159)
        par_oContainer.AddObject("lbl_4c_Say1", "Label")
        WITH par_oContainer.lbl_4c_Say1
            .AutoSize  = .F.
            .Top       = 80
            .Left      = 82
            .Width     = 74
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Alignment = 0
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Caption   = "Limite Cr" + CHR(233) + "dito :"
        ENDWITH

        par_oContainer.AddObject("txt_4c_LimCred", "TextBox")
        WITH par_oContainer.txt_4c_LimCred
            .Top       = 76
            .Left      = 159
            .Width     = 119
            .Height    = 23
            .FontName  = "Courier New"
            .FontSize  = 8
            .InputMask = "999,999,999.99"
            .Value     = 0
            .Enabled   = .T.
            .ReadOnly  = .T.
            .TabStop   = .F.
        ENDWITH

        *-- Say9 / get_PendOutr (legado: top=105/101, left=36/159, width say=120)
        par_oContainer.AddObject("lbl_4c_Say9", "Label")
        WITH par_oContainer.lbl_4c_Say9
            .AutoSize  = .F.
            .Top       = 105
            .Left      = 36
            .Width     = 120
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Alignment = 0
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Caption   = "Total da Movimenta" + CHR(231) + CHR(227) + "o :"
        ENDWITH

        par_oContainer.AddObject("txt_4c_PendOutr", "TextBox")
        WITH par_oContainer.txt_4c_PendOutr
            .Top       = 101
            .Left      = 159
            .Width     = 119
            .Height    = 23
            .FontName  = "Courier New"
            .FontSize  = 8
            .InputMask = "999,999,999.99"
            .Value     = 0
            .Enabled   = .T.
            .ReadOnly  = .T.
            .TabStop   = .F.
        ENDWITH

        *-- Say2 / get_pendente (legado: top=130/126, left=74/159)
        par_oContainer.AddObject("lbl_4c_Say2", "Label")
        WITH par_oContainer.lbl_4c_Say2
            .AutoSize  = .F.
            .Top       = 130
            .Left      = 74
            .Width     = 82
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Alignment = 0
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Caption   = "Total Pendente :"
        ENDWITH

        par_oContainer.AddObject("txt_4c_Pendente", "TextBox")
        WITH par_oContainer.txt_4c_Pendente
            .Top       = 126
            .Left      = 159
            .Width     = 119
            .Height    = 23
            .FontName  = "Courier New"
            .FontSize  = 8
            .InputMask = "999,999,999.99"
            .Value     = 0
            .Enabled   = .T.
            .ReadOnly  = .T.
            .TabStop   = .F.
        ENDWITH

        *-- Say3 / get_contac (legado: top=180/176, left=102/159) - Saldo em C/C
        par_oContainer.AddObject("lbl_4c_Say3", "Label")
        WITH par_oContainer.lbl_4c_Say3
            .AutoSize  = .F.
            .Top       = 180
            .Left      = 102
            .Width     = 54
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Alignment = 0
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Caption   = "Total C/C :"
        ENDWITH

        par_oContainer.AddObject("txt_4c_Contac", "TextBox")
        WITH par_oContainer.txt_4c_Contac
            .Top       = 176
            .Left      = 159
            .Width     = 119
            .Height    = 23
            .FontName  = "Courier New"
            .FontSize  = 8
            .InputMask = "999,999,999.99"
            .Value     = 0
            .Enabled   = .T.
            .ReadOnly  = .T.
            .TabStop   = .F.
        ENDWITH

        *-- Say4 / get_cheque (legado: top=205/201, left=78/159) - total de
        *-- cheques a debito que ja compensaram
        par_oContainer.AddObject("lbl_4c_Say4", "Label")
        WITH par_oContainer.lbl_4c_Say4
            .AutoSize  = .F.
            .Top       = 205
            .Left      = 78
            .Width     = 78
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Alignment = 0
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Caption   = "Total Cheques :"
        ENDWITH

        par_oContainer.AddObject("txt_4c_Cheque", "TextBox")
        WITH par_oContainer.txt_4c_Cheque
            .Top       = 201
            .Left      = 159
            .Width     = 119
            .Height    = 23
            .FontName  = "Courier New"
            .FontSize  = 8
            .InputMask = "999,999,999.99"
            .Value     = 0
            .Enabled   = .T.
            .ReadOnly  = .T.
            .TabStop   = .F.
        ENDWITH

        *-- Say7 / get_chqpend (legado: top=155/151, left=101/159) - total de
        *-- cheques que ainda aguardam compensacao
        par_oContainer.AddObject("lbl_4c_Say7", "Label")
        WITH par_oContainer.lbl_4c_Say7
            .AutoSize  = .F.
            .Top       = 155
            .Left      = 101
            .Width     = 55
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Alignment = 0
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Caption   = "Pendente :"
        ENDWITH

        par_oContainer.AddObject("txt_4c_ChqPend", "TextBox")
        WITH par_oContainer.txt_4c_ChqPend
            .Top       = 151
            .Left      = 159
            .Width     = 119
            .Height    = 23
            .FontName  = "Courier New"
            .FontSize  = 8
            .InputMask = "999,999,999.99"
            .Value     = 0
            .Enabled   = .T.
            .ReadOnly  = .T.
            .TabStop   = .F.
        ENDWITH

        *-- Say5 / get_disponivel (legado: top=229/226, left=90/159) - saldo
        *-- final disponivel. So o LABEL eh negrito no dump (Say5 declara
        *-- FontBold = .T.); o get_disponivel NAO declara FontBold - a lista de
        *-- propriedades dele no dump eh detalhada (traz ate ForeColor e
        *-- DisabledBackColor), entao a ausencia eh significativa.
        *-- O legado troca o ForeColor do CAMPO em runtime (vermelho se
        *-- negativo, azul se positivo) dentro de Processa() - a cor aqui eh so
        *-- o default de design-time (192,46,20); a troca dinamica mora em
        *-- AtualizarContainer1(), que eh quem leva o saldo calculado pelo BO
        *-- para a tela.
        par_oContainer.AddObject("lbl_4c_Say5", "Label")
        WITH par_oContainer.lbl_4c_Say5
            .AutoSize  = .F.
            .Top       = 229
            .Left      = 90
            .Width     = 66
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .T.
            .Alignment = 0
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Caption   = "Dispon" + CHR(237) + "vel :"
        ENDWITH

        par_oContainer.AddObject("txt_4c_Disponivel", "TextBox")
        WITH par_oContainer.txt_4c_Disponivel
            .Top       = 226
            .Left      = 159
            .Width     = 119
            .Height    = 23
            .FontName  = "Courier New"
            .FontSize  = 8
            .InputMask = "999,999,999.99"
            .Value     = 0
            .ForeColor = RGB(192, 46, 20)
            .Enabled   = .T.
            .ReadOnly  = .T.
            .TabStop   = .F.
        ENDWITH
    ENDPROC

    *==========================================================================
    * ConfigurarContainer2 - bloco "Observacao da Conta" (legado: Container2).
    * Comeca OCULTO - so reaparece quando a conta analisada tem observacao
    * cadastrada (SigCdCli.Obs), conforme AtualizarContainer2().
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarContainer2()
        THIS.AddObject("cnt_4c_Container2", "Container")
        WITH THIS.cnt_4c_Container2
            .Top           = 336
            .Left          = 9
            .Width         = 890
            .Height        = 114
            .BackStyle     = 0
            .BorderWidth   = 2
            .SpecialEffect = 2
            .BackColor     = RGB(188, 201, 254)
            .Visible     = .T.
        ENDWITH

        THIS.ConfigurarCamposContainer2(THIS.cnt_4c_Container2)
    ENDPROC

    *==========================================================================
    * ConfigurarCamposContainer2 - campos do bloco "Observacao da Conta".
    * Legado: Container2.Label1 (titulo), Container2.fwmemo1 (EditBox com a
    * observacao cadastrada da conta) e Container2.get_nconta (rotulo que
    * recebe o codigo da conta em runtime).
    *
    * O dump declara AutoSize = .T. nos dois Labels, mas AutoSize eh no-op em
    * Label criado por AddObject e, com WordWrap, DESCARTA a Height - por isso
    * .AutoSize = .F. com Width/Height transcritos do SCX (os numeros do dump
    * JA SAO o auto-size que o Form Designer calculou).
    *
    * O EditBox eh SOMENTE LEITURA no legado (fwmemo1.ReadOnly = .T. no dump) -
    * a observacao vem do cadastro da conta e esta tela so a exibe.
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarCamposContainer2(par_oContainer)
        *-- Label1 (legado: Container2.Label1, Tahoma 11 bold, ForeColor 90,90,90)
        par_oContainer.AddObject("lbl_4c_Label1", "Label")
        WITH par_oContainer.lbl_4c_Label1
            .AutoSize  = .F.
            .Top       = 3
            .Left      = 5
            .Width     = 160
            .Height    = 20
            .FontName  = "Tahoma"
            .FontSize  = 11
            .FontBold  = .T.
            .Alignment = 0
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Caption   = "Observa" + CHR(231) + CHR(227) + "o da Conta"
        ENDWITH

        *-- get_nconta (legado: Container2.get_nconta) - rotulo "Cliente"; a
        *-- Caption real (codigo da conta) eh atribuida em AtualizarContainer2
        par_oContainer.AddObject("lbl_4c_GetNConta", "Label")
        WITH par_oContainer.lbl_4c_GetNConta
            .AutoSize  = .F.
            .Top       = 25
            .Left      = 30
            .Width     = 160
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .T.
            .Alignment = 0
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Caption   = "Cliente"
        ENDWITH

        *-- fwmemo1 (legado: Container2.fwmemo1, EditBox ReadOnly com
        *-- BackColor/DisabledBackColor 231,242,254 e NullDisplay " ")
        par_oContainer.AddObject("edt_4c_Observacao", "EditBox")
        WITH par_oContainer.edt_4c_Observacao
            .Top               = 39
            .Left              = 9
            .Width             = 871
            .Height            = 70
            .FontName          = "Tahoma"
            .FontSize          = 8
            .Value             = ""
            .ReadOnly          = .T.
            .TabStop           = .F.
            .ScrollBars        = 2
            .BackColor         = RGB(231, 242, 254)
            .DisabledBackColor = RGB(231, 242, 254)
            .ForeColor         = RGB(90, 90, 90)
            .NullDisplay       = " "
        ENDWITH
    ENDPROC

    *==========================================================================
    * ConfigurarContainer3 - bloco "Situacao da Conta" (legado: Container3).
    * Comeca OCULTO - so reaparece quando SigCdCst.DispMovs = 1 para a situacao
    * cadastral da conta, conforme AtualizarContainer3().
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarContainer3()
        THIS.AddObject("cnt_4c_Container3", "Container")
        WITH THIS.cnt_4c_Container3
            .Top           = 452
            .Left          = 9
            .Width         = 890
            .Height        = 138
            .BackStyle     = 0
            .BorderWidth   = 2
            .SpecialEffect = 2
            .BackColor     = RGB(188, 201, 254)
            .Visible     = .T.
        ENDWITH

        THIS.ConfigurarCamposContainer3(THIS.cnt_4c_Container3)
    ENDPROC

    *==========================================================================
    * ConfigurarCamposContainer3 - campos do bloco "Situacao da Conta".
    * Legado: Container3.Label1 (titulo), Container3.get_nconta (rotulo que
    * recebe o codigo da conta), Lb_msg1..Lb_msg4 (as quatro linhas de
    * informacao cadastral) e lb_msg5 (a linha de BLOQUEIO, que o legado
    * mantem oculta e so acende quando a situacao da conta recusa o
    * movimento - ver ValidarSituacaoConta).
    *
    * As Captions "Mensagem1".."Mensagem4"/"status" do dump sao placeholders de
    * design-time do legado; o texto real vem de AtualizarContainer3(). Por
    * isso os Labels nascem com Caption VAZIA - exibir "Mensagem1" na tela
    * seria pior que a cadeia vazia.
    *
    * Lb_msg1..Lb_msg4 NAO declaram AutoSize no dump (Width = 839 fixa, a
    * largura util do container); lb_msg5 declara AutoSize = .T., trocado por
    * .AutoSize = .F. com a geometria do dump pelo mesmo motivo do Container2.
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarCamposContainer3(par_oContainer)
        *-- Label1 (legado: Container3.Label1, Tahoma 11 bold)
        par_oContainer.AddObject("lbl_4c_Label1", "Label")
        WITH par_oContainer.lbl_4c_Label1
            .AutoSize  = .F.
            .Top       = 5
            .Left      = 5
            .Width     = 136
            .Height    = 20
            .FontName  = "Tahoma"
            .FontSize  = 11
            .FontBold  = .T.
            .Alignment = 0
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Caption   = "Situa" + CHR(231) + CHR(227) + "o da Conta"
        ENDWITH

        *-- get_nconta (legado: Container3.get_nconta) - rotulo "Cliente"
        par_oContainer.AddObject("lbl_4c_GetNConta", "Label")
        WITH par_oContainer.lbl_4c_GetNConta
            .AutoSize  = .F.
            .Top       = 28
            .Left      = 30
            .Width     = 160
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .T.
            .Alignment = 0
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Caption   = "Cliente"
        ENDWITH

        *-- Lb_msg1 (legado: Container3.Lb_msg1, top=46) - situacao cadastral
        par_oContainer.AddObject("lbl_4c_Msg1", "Label")
        WITH par_oContainer.lbl_4c_Msg1
            .AutoSize  = .F.
            .Top       = 46
            .Left      = 31
            .Width     = 839
            .Height    = 17
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .T.
            .Alignment = 0
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Caption   = ""
        ENDWITH

        *-- Lb_msg2 (legado: Container3.Lb_msg2, top=64) - valor/data da
        *-- ultima compra
        par_oContainer.AddObject("lbl_4c_Msg2", "Label")
        WITH par_oContainer.lbl_4c_Msg2
            .AutoSize  = .F.
            .Top       = 64
            .Left      = 31
            .Width     = 839
            .Height    = 17
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .T.
            .Alignment = 0
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Caption   = ""
        ENDWITH

        *-- Lb_msg3 (legado: Container3.Lb_msg3, top=80) - data de nascimento
        par_oContainer.AddObject("lbl_4c_Msg3", "Label")
        WITH par_oContainer.lbl_4c_Msg3
            .AutoSize  = .F.
            .Top       = 80
            .Left      = 31
            .Width     = 839
            .Height    = 17
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .T.
            .Alignment = 0
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Caption   = ""
        ENDWITH

        *-- Lb_msg4 (legado: Container3.Lb_msg4, top=96) - codigo auxiliar do
        *-- cliente + datas de consorcio (j) e casamento (c)
        par_oContainer.AddObject("lbl_4c_Msg4", "Label")
        WITH par_oContainer.lbl_4c_Msg4
            .AutoSize  = .F.
            .Top       = 96
            .Left      = 31
            .Width     = 839
            .Height    = 17
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .T.
            .Alignment = 0
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Caption   = ""
        ENDWITH

        *-- lb_msg5 (legado: Container3.lb_msg5, Tahoma 10 bold, nasce OCULTA)
        par_oContainer.AddObject("lbl_4c_Msg5", "Label")
        WITH par_oContainer.lbl_4c_Msg5
            .AutoSize  = .F.
            .Top       = 115
            .Left      = 92
            .Width     = 500
            .Height    = 18
            .FontName  = "Tahoma"
            .FontSize  = 10
            .FontBold  = .T.
            .Alignment = 0
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .BackColor = RGB(255, 255, 217)
            .Caption   = ""
            .Visible   = .F.
        ENDWITH
    ENDPROC

    *==========================================================================
    * ConfigurarCheckBoxesLado - os dois CheckBox que escolhem QUAL lado da
    * movimentacao esta sendo analisado (legado: SIGOPLRC.Sit_Origem e
    * SIGOPLRC.Sit_Destino, filhos DIRETOS do form, Top 143/179, Left 754).
    *
    * Ficam SOBRE a area do Container1 e por isso sao criados DEPOIS dele
    * (AddObject empilha o ultimo no topo do z-order) e ANTES do botao
    * Encerrar, exatamente na ordem da SECAO 1 do dump.
    *
    * .Value NUMERICO (0/1): o SCX declara Value = .F., mas o proprio
    * Sit_Destino.Click do legado faz "This.Value = 0" - e CheckBox do projeto
    * eh sempre numerico, para nao estourar "type mismatch" ao comparar.
    *
    * Picture transcrita do dump (..\framework\imagens\geral_usuarios_26.jpg),
    * so com o caminho trocado para gc_4c_CaminhoIcones. Themes = .F. eh do
    * dump; CheckBox com Picture nao sofre do problema de icone invisivel que
    * atinge CommandButton solto.
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarCheckBoxesLado()
        THIS.AddObject("chk_4c_Sit_Origem", "CheckBox")
        WITH THIS.chk_4c_Sit_Origem
            .Top             = 143
            .Left            = 754
            .Width           = 120
            .Height          = 35
            .FontName        = "Comic Sans MS"
            .FontSize        = 8
            .FontBold        = .T.
            .FontItalic      = .T.
            .Alignment       = 0
            .Caption         = "Conta Origem"
            .Value           = 0
            .Style           = 1
            .MousePointer    = 15
            .PicturePosition = 1
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .Themes          = .F.
            .TabIndex        = 3
            .ToolTipText     = "Origem"
            .Picture         = gc_4c_CaminhoIcones + "geral_usuarios_26.jpg"
        ENDWITH

        THIS.AddObject("chk_4c_Sit_Destino", "CheckBox")
        WITH THIS.chk_4c_Sit_Destino
            .Top             = 179
            .Left            = 754
            .Width           = 120
            .Height          = 35
            .FontName        = "Comic Sans MS"
            .FontSize        = 8
            .FontBold        = .T.
            .FontItalic      = .T.
            .Alignment       = 0
            .Caption         = "Conta Destino"
            .Value           = 0
            .Style           = 1
            .MousePointer    = 15
            .PicturePosition = 1
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .Themes          = .F.
            .TabIndex        = 4
            .ToolTipText     = "Destino"
            .Picture         = gc_4c_CaminhoIcones + "geral_usuarios_26.jpg"
        ENDWITH
    ENDPROC

    *==========================================================================
    * CriarCursorGrade - cria o cursor que alimenta a grade, com a MESMA
    * estrutura e NA MESMA ORDEM de campos que SigOpLrCBO usa em
    * CarregarMovimentosPendentes (dopes C(20), totas N(12,2)) - divergir a
    * ordem faz o INSERT casar coluna errada em silencio.
    * Legado: PROCEDURE Load -> Create Cursor DbOpera (dopes c(20), totas n(12,2))
    * O BO reaproveita este mesmo alias (IF !USED() ... ELSE ZAP), por isso o
    * vinculo da grade sobrevive a recarga.
    *==========================================================================
    PROTECTED PROCEDURE CriarCursorGrade()
        LOCAL loc_oErro

        TRY
            IF !USED(THIS.this_cCursorGrade)
                CREATE CURSOR (THIS.this_cCursorGrade) (dopes C(20), totas N(12,2))
                SELECT (THIS.this_cCursorGrade)
                INDEX ON dopes TAG dopes
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + "Linha: " + TRANSFORM(loc_oErro.LineNo) + ;
                CHR(13) + "Procedure: " + loc_oErro.Procedure, "Erro em CriarCursorGrade")
        ENDTRY
    ENDPROC

    *==========================================================================
    * ConfigurarGrade - grade dos movimentos em aberto da conta analisada.
    * Legado: SIGOPLRC.Container1.Grade (Top=53, Left=295, Width=434,
    * Height=195, ColumnCount=2, Verdana 8, ReadOnly, RowHeight=16,
    * ScrollBars=2, DeleteMark=.F.). Somente leitura - o usuario apenas
    * consulta o que ja esta em aberto; nao ha coluna editavel.
    * NAO liga RecordSource/ControlSource aqui: o vinculo (e a largura das
    * colunas, que o RecordSource reseta para o default) fica em CarregarDados.
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarGrade(par_oContainer)
        par_oContainer.AddObject("grd_4c_Dados", "Grid")

        WITH par_oContainer.grd_4c_Dados
            .Top         = 53
            .Left        = 295
            .Width       = 434
            .Height      = 195
            .ColumnCount = 2
            .FontName    = "Verdana"
            .FontSize    = 8
            .RowHeight   = 16
            .ScrollBars  = 2
            .Enabled     = .T.
            .DeleteMark  = .F.
            .RecordMark  = .F.
            *-- Grid.ReadOnly propaga para as colunas, por isso vem ANTES delas
            .ReadOnly    = .T.
        ENDWITH

        WITH par_oContainer.grd_4c_Dados.Column1
            .FontName = "Verdana"
            .FontSize = 8
            .Enabled  = .T.
            .ReadOnly = .T.
        ENDWITH

        WITH par_oContainer.grd_4c_Dados.Column1.Header1
            .FontName  = "Verdana"
            .FontSize  = 8
            .Alignment = 2
        ENDWITH

        WITH par_oContainer.grd_4c_Dados.Column1.Text1
            .FontName    = "Verdana"
            .FontSize    = 8
            .BorderStyle = 0
            .Margin      = 0
            .ForeColor   = RGB(0, 0, 0)
            .BackColor   = RGB(255, 255, 255)
        ENDWITH

        WITH par_oContainer.grd_4c_Dados.Column2
            .FontName  = "Verdana"
            .FontSize  = 8
            .Enabled   = .T.
            .InputMask = "999,999,999.99"
            .ReadOnly  = .T.
        ENDWITH

        WITH par_oContainer.grd_4c_Dados.Column2.Header1
            .FontName  = "Verdana"
            .FontSize  = 8
            .Alignment = 2
        ENDWITH

        WITH par_oContainer.grd_4c_Dados.Column2.Text1
            .FontName    = "Verdana"
            .FontSize    = 8
            .BorderStyle = 0
            .Margin      = 0
            .ForeColor   = RGB(0, 0, 0)
            .BackColor   = RGB(255, 255, 255)
        ENDWITH
    ENDPROC

    *==========================================================================
    * CarregarDados - FUNIL UNICO de vinculo e repintura da grade. Legado:
    * bloco final de Processa() -> Select DbOpera / Go Top / With Grade
    * .RecordSource / .Column1.ControlSource / .Column2.ControlSource / .Refresh
    *
    * Tem de ser chamado em TODO caminho que popula o cursor (carga inicial e
    * cada reprocessamento por troca do lado da conta): popular o cursor NAO
    * repinta a grade sozinho - sem GO TOP + Refresh a grade fica visualmente
    * vazia com o cursor cheio, e o sintoma ("a tela nao traz dados") manda o
    * diagnostico para o SQL.
    *
    * E tem de ser chamado DEPOIS de acender cnt_4c_Container1: Refresh em
    * controle dentro de container oculto nao pinta. Quem reprocessa o lado da
    * conta acende o painel primeiro e so entao chama este funil.
    *
    * A ordem eh obrigatoria: ColumnCount -> RecordSource -> ControlSource ->
    * Width -> Header1.Caption. RecordSource recalcula a largura das colunas
    * para o default e zera os captions, entao largura e titulo tem de ser
    * reaplicados DEPOIS dele.
    *==========================================================================
    PROCEDURE CarregarDados()
        LOCAL loc_lSucesso, loc_oGrade, loc_oErro
        loc_lSucesso = .F.

        TRY
            THIS.CriarCursorGrade()

            IF USED(THIS.this_cCursorGrade) AND ;
               PEMSTATUS(THIS.cnt_4c_Container1, "grd_4c_Dados", 5)

                loc_oGrade = THIS.cnt_4c_Container1.grd_4c_Dados

                loc_oGrade.ColumnCount = 2
                loc_oGrade.RecordSource = THIS.this_cCursorGrade
                loc_oGrade.Column1.ControlSource = THIS.this_cCursorGrade + ".dopes"
                loc_oGrade.Column2.ControlSource = THIS.this_cCursorGrade + ".totas"

                *-- Larguras e titulos DEPOIS do RecordSource (ele reseta ambos)
                loc_oGrade.Column1.Width = 290
                loc_oGrade.Column2.Width = 112
                loc_oGrade.Column1.Header1.Caption = "Movimenta" + CHR(231) + CHR(245) + ;
                    "es Pendentes"
                loc_oGrade.Column2.Header1.Caption = "Valor"

                SELECT (THIS.this_cCursorGrade)
                GO TOP
                loc_oGrade.Refresh()

                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + "Linha: " + TRANSFORM(loc_oErro.LineNo) + ;
                CHR(13) + "Procedure: " + loc_oErro.Procedure, "Erro em CarregarDados")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * AtualizarContainer2 - exibe (ou esconde) o bloco "Observacao da Conta"
    * com o texto que o BO leu de SigCdCli.Obs. Legado, trecho de Processa():
    *     If Not IsEmpty( CrTmpCli.Obs )
    *         llAtvCnt = .t.
    *         ThisForm.Container2.Visible = .t.
    *         ThisForm.container2.fwmemo1.Value = CrTmpCli.Obs
    *         ThisForm.container2.fwmemo1.Refresh
    *         ThisForm.Container2.Get_nconta.Caption = _Conta
    *     Endif
    *
    * O legado NUNCA reexibe o bloco quando a observacao esta vazia, e cada
    * clique nos CheckBox de lado roda Processa() de novo - por isso este
    * metodo tambem ESCONDE o bloco, senao a observacao da conta Origem
    * ficaria na tela depois de o usuario trocar para a conta Destino.
    *
    * PUBLIC de proposito: eh chamado de fora da classe pelo funil que
    * reprocessa o lado da conta.
    *==========================================================================
    PROCEDURE AtualizarContainer2()
        LOCAL loc_lVisivel, loc_oBO, loc_oErro

        loc_lVisivel = .F.

        TRY
            loc_oBO = THIS.this_oBusinessObject

            IF VARTYPE(loc_oBO) = "O"
                loc_lVisivel = loc_oBO.this_lContainer2Visivel

                IF loc_lVisivel
                    THIS.cnt_4c_Container2.edt_4c_Observacao.Value = ;
                        TratarNulo(loc_oBO.this_cObsCliente, "")
                    THIS.cnt_4c_Container2.lbl_4c_GetNConta.Caption = ;
                        ALLTRIM(TratarNulo(loc_oBO.this_cConta, ""))
                ENDIF
            ENDIF

            THIS.cnt_4c_Container2.Visible = loc_lVisivel

            IF loc_lVisivel
                THIS.cnt_4c_Container2.edt_4c_Observacao.Refresh()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + "Linha: " + TRANSFORM(loc_oErro.LineNo) + ;
                CHR(13) + "Procedure: " + loc_oErro.Procedure, "Erro em AtualizarContainer2")
        ENDTRY

        RETURN loc_lVisivel
    ENDPROC

    *==========================================================================
    * AtualizarContainer3 - exibe (ou esconde) o bloco "Situacao da Conta" com
    * as quatro linhas de informacao cadastral. Legado, trecho de Processa():
    *     ThisForm.Container3.Get_nconta.Caption = _Conta
    *     lb_msg1 = CrtmpCli.Situas + ' - ' + Alltrim(lcdSit)
    *     lb_msg2 = Alltrim(Transform(CrTmpCli.VultComps,"@Z 999,999,999.99"))
    *               + ' / ' + Iif(!IsEmpty(CrTmpCli.UltComps),Dtoc(CrTmpCli.UltComps),'')
    *     lb_msg3 = Iif(!IsEmpty(CrTmpCli.Nascs),Dtoc(CrTmpCli.Nascs),'')
    *     lb_msg4 = CrTmpCli.Codigos + ' ' + Iif(!IsEmpty(CrTmpCli.DtnCons),'j - '+Dtoc(...),'')
    *               + ' ' + Iif(!IsEmpty(CrTmpCli.DtCasas),'c - '+Dtoc(...),'')
    *
    * As datas passam por ConverterParaData(): a MESMA coluna chega como DATE
    * (property do BO ainda no valor inicial {}) ou como DATETIME (lida do SQL
    * Server), e DTOC de um DATETIME nao erra, mas TTOD de um DATE erra - o
    * normalizador cobre os dois caminhos.
    *==========================================================================
    PROCEDURE AtualizarContainer3()
        LOCAL loc_lVisivel, loc_oBO, loc_oCnt, loc_dUltima, loc_dNasc
        LOCAL loc_dConsorcio, loc_dCasamento, loc_oErro

        loc_lVisivel = .F.

        TRY
            loc_oBO = THIS.this_oBusinessObject

            IF VARTYPE(loc_oBO) = "O"
                loc_lVisivel = loc_oBO.this_lContainer3Visivel

                IF loc_lVisivel
                    loc_oCnt       = THIS.cnt_4c_Container3
                    loc_dUltima    = ConverterParaData(loc_oBO.this_dUltimaCompra)
                    loc_dNasc      = ConverterParaData(loc_oBO.this_dNascimento)
                    loc_dConsorcio = ConverterParaData(loc_oBO.this_dDtnCons)
                    loc_dCasamento = ConverterParaData(loc_oBO.this_dDtCasas)

                    loc_oCnt.lbl_4c_GetNConta.Caption = ;
                        ALLTRIM(TratarNulo(loc_oBO.this_cConta, ""))

                    loc_oCnt.lbl_4c_Msg1.Caption = ;
                        ALLTRIM(TratarNulo(loc_oBO.this_cSituacaoCod, "")) + " - " + ;
                        ALLTRIM(TratarNulo(loc_oBO.this_cDescrSituacao, ""))

                    loc_oCnt.lbl_4c_Msg2.Caption = ;
                        ALLTRIM(TRANSFORM(TratarNulo(loc_oBO.this_nValorUltimaCompra, 0), ;
                            "@Z 999,999,999.99")) + " / " + ;
                        IIF(!EMPTY(loc_dUltima), DTOC(loc_dUltima), "")

                    loc_oCnt.lbl_4c_Msg3.Caption = ;
                        IIF(!EMPTY(loc_dNasc), DTOC(loc_dNasc), "")

                    loc_oCnt.lbl_4c_Msg4.Caption = ;
                        ALLTRIM(TratarNulo(loc_oBO.this_cCodigoCliente, "")) + " " + ;
                        IIF(!EMPTY(loc_dConsorcio), "j - " + DTOC(loc_dConsorcio), "") + ;
                        " " + IIF(!EMPTY(loc_dCasamento), "c - " + DTOC(loc_dCasamento), "")
                ENDIF
            ENDIF

            THIS.cnt_4c_Container3.Visible = loc_lVisivel

            *-- A linha de bloqueio eh decidida pela validacao da situacao, que
            *-- roda SEMPRE: ela precisa apagar a mensagem do lado anterior
            *-- mesmo quando este bloco nao aparece.
            THIS.ValidarSituacaoConta()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + "Linha: " + TRANSFORM(loc_oErro.LineNo) + ;
                CHR(13) + "Procedure: " + loc_oErro.Procedure, "Erro em AtualizarContainer3")
        ENDTRY

        RETURN loc_lVisivel
    ENDPROC

    *==========================================================================
    * ValidarSituacaoConta - transcreve a validacao que fecha o Processa() do
    * legado: quando o lado da conta eh FIXO (OriDes > 0, isto eh, o form pai
    * pediu a analise de um lado especifico), a situacao cadastral pode RECUSAR
    * a movimentacao, e o legado comunica isso de duas formas ao mesmo tempo -
    * acende lb_msg5 com o motivo e zera ThisForm.Retorno, que eh o valor lido
    * pelo form pai para abortar a gravacao.
    *
    *     If Thisform.OriDes > 0
    *         If CrTmpScli.BlqMovs = 1
    *             lb_MSG5.Visible = .t.
    *             lb_msg5.Caption = 'Movimentacao Bloqueada pela Situacao da Conta'
    *             ThisForm.Retorno = .f.
    *         Else
    *             If TprMvCab.ValVars < 0 And CrTmpScli.BlqDescs = 1
    *                 lb_MSG5.Visible = .t.
    *                 lb_msg5.Caption = 'Desconto Bloqueado Pela Situacao da Conta'
    *                 ThisForm.Retorno = .f.
    *             EndIf
    *         EndIf
    *     EndIf
    *
    * A decisao (qual dos dois motivos, e se ha motivo) eh regra de negocio e
    * mora no BO; aqui ela eh ESPELHADA na tela e no this_lRetorno do form. O
    * retorno eh .T. quando a movimentacao esta liberada e .F. quando recusada,
    * para quem chamar poder desviar o fluxo sem reler a tela.
    *
    * Reproduz tambem o lb_MSG5.Visible = .f. que o legado executa ANTES dos
    * dois IFs: sem apagar, a mensagem do lado anterior sobrevive ao clique que
    * troca Origem/Destino e a tela acusa bloqueio que nao existe mais.
    *==========================================================================
    PROCEDURE ValidarSituacaoConta()
        LOCAL loc_lLiberado, loc_oBO, loc_oMsg, loc_oErro

        loc_lLiberado = .T.

        TRY
            loc_oMsg = THIS.cnt_4c_Container3.lbl_4c_Msg5
            loc_oBO  = THIS.this_oBusinessObject

            loc_oMsg.Visible = .F.
            loc_oMsg.Caption = ""

            IF VARTYPE(loc_oBO) = "O"
                IF loc_oBO.this_lMsgBloqueioVisivel
                    loc_oMsg.Caption = TratarNulo(loc_oBO.this_cMsgBloqueio, "")
                    loc_oMsg.Visible = .T.
                ENDIF

                loc_lLiberado      = loc_oBO.this_lRetorno
                THIS.this_lRetorno = loc_lLiberado
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + "Linha: " + TRANSFORM(loc_oErro.LineNo) + ;
                CHR(13) + "Procedure: " + loc_oErro.Procedure, "Erro em ValidarSituacaoConta")
        ENDTRY

        RETURN loc_lLiberado
    ENDPROC

    *==========================================================================
    * AtualizarCheckBoxesLado - espelha na tela a habilitacao dos dois CheckBox
    * de escolha de lado, que eh decidida pelo BO (regra de negocio).
    *
    * Legado, inicio de Processa():
    *     If ThisForm.OriDes > 0
    *         ThisForm.Sit_Destino.Enabled = .f.
    *         ThisForm.Sit_Origem.Enabled = .f.
    *     EndIf
    * e, no DO CASE que escolhe o lado, o reenable do lado em foco
    * (Sit_Origem.Enabled = .t. / Sit_Destino.Enabled = .t.).
    *
    * As duas coisas ja estao no BO (Processar + DeterminarLadoConta), em
    * this_lSitOrigemHabilitado/this_lSitDestinoHabilitado - aqui elas apenas
    * chegam a tela. Lado FIXO (OriDes > 0, o form pai pediu um lado
    * especifico) deixa os dois desabilitados: o usuario nao pode trocar.
    *
    * PUBLIC de proposito: faz parte do funil chamado de fora da classe.
    *==========================================================================
    PROCEDURE AtualizarCheckBoxesLado()
        LOCAL loc_oBO, loc_oErro

        TRY
            loc_oBO = THIS.this_oBusinessObject

            IF VARTYPE(loc_oBO) = "O"
                THIS.chk_4c_Sit_Origem.Enabled  = loc_oBO.this_lSitOrigemHabilitado
                THIS.chk_4c_Sit_Destino.Enabled = loc_oBO.this_lSitDestinoHabilitado
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + "Linha: " + TRANSFORM(loc_oErro.LineNo) + ;
                CHR(13) + "Procedure: " + loc_oErro.Procedure, "Erro em AtualizarCheckBoxesLado")
        ENDTRY
    ENDPROC

    *==========================================================================
    * AtualizarContainer1 - exibe (ou esconde) o bloco de limite de credito e
    * leva para a tela os valores que o BO calculou. Legado, fecho do bloco
    * Container1 de Processa():
    *     ThisForm.Container1.get_nconta.Caption   = _Conta + " " + Alltrim(lcRazao)
    *     ThisForm.Container1.get_contac.Value     = _Saldocc
    *     ThisForm.Container1.get_cheque.Value     = _chequec
    *     ThisForm.Container1.get_chqpend.Value    = _chequep
    *     ThisForm.Container1.get_limcred.Value    = crSigClLcr.limcres
    *     ThisForm.Container1.get_moeda.Value      = crSigClLcr.moedas
    *     ThisForm.Container1.get_cotacao.Value    = fBuscarCotacao(crSigClLcr.moedas, date())
    *     ThisForm.Container1.get_pendente.Value   = _Pendoutr
    *     ThisForm.Container1.get_pendoutr.Value   = _Pendente
    *     ThisForm.Container1.get_disponivel.forecolor = Iif(_SaldoFinal < 0, RGB(255,0,0), RGB(0,0,255))
    *     ThisForm.Container1.get_disponivel.Value = _SaldoFinal
    *
    * ATENCAO - as duas linhas de pendencia NAO estao trocadas: no legado o
    * nome da variavel engana e o rotulo da tela eh que manda. get_pendente
    * esta sob o rotulo Say2 (total em aberto) e recebe _PendOutr, que eh o
    * que esta em aberto em OUTRAS operacoes; get_PendOutr esta sob o rotulo
    * Say9 (total da movimentacao) e recebe _Pendente, que eh o valor do
    * PROPRIO movimento em lancamento. Transcrito como esta - inverter os dois
    * exibe numero errado em dois campos ao mesmo tempo, sem erro na tela.
    *
    * A cor do saldo disponivel eh dinamica (vermelho se negativo, azul se
    * positivo); o default de design-time posto em ConfigurarCamposContainer1
    * vale so ate a primeira passagem por aqui.
    *
    * CarregarDados() fica no FIM e so quando o painel esta VISIVEL: Refresh de
    * grade dentro de container oculto nao pinta, e a grade ficaria visualmente
    * vazia com o cursor cheio.
    *
    * Como todo valor eh reatribuido sempre que o painel aparece, esconder
    * basta - nao ha dado de um lado sobrevivendo visivel no outro.
    *
    * PUBLIC de proposito: faz parte do funil chamado de fora da classe.
    *==========================================================================
    PROCEDURE AtualizarContainer1()
        LOCAL loc_lVisivel, loc_oBO, loc_oCnt, loc_nDisponivel, loc_oErro

        loc_lVisivel = .F.

        TRY
            loc_oBO = THIS.this_oBusinessObject

            IF VARTYPE(loc_oBO) = "O"
                loc_lVisivel = loc_oBO.this_lContainer1Visivel

                IF loc_lVisivel
                    loc_oCnt        = THIS.cnt_4c_Container1
                    loc_nDisponivel = TratarNulo(loc_oBO.this_nSaldoDisponivel, 0)

                    loc_oCnt.lbl_4c_GetNConta.Caption = ;
                        TratarNulo(loc_oBO.this_cDescricaoConta, "")

                    loc_oCnt.txt_4c_Moeda.Value   = ALLTRIM(TratarNulo(loc_oBO.this_cMoeda, ""))
                    loc_oCnt.txt_4c_Cotacao.Value = TratarNulo(loc_oBO.this_nCotacao, 0)
                    loc_oCnt.txt_4c_LimCred.Value = TratarNulo(loc_oBO.this_nLimiteCredito, 0)
                    loc_oCnt.txt_4c_Contac.Value  = TratarNulo(loc_oBO.this_nSaldoCC, 0)
                    loc_oCnt.txt_4c_Cheque.Value  = TratarNulo(loc_oBO.this_nTotalCheques, 0)
                    loc_oCnt.txt_4c_ChqPend.Value = TratarNulo(loc_oBO.this_nChequesPendentes, 0)

                    *-- Ver a nota do cabecalho: o campo sob o Say2 recebe o
                    *-- que esta em aberto em OUTRAS operacoes, e o campo sob
                    *-- o Say9 recebe o valor do PROPRIO movimento.
                    loc_oCnt.txt_4c_Pendente.Value = TratarNulo(loc_oBO.this_nPendenteOutros, 0)
                    loc_oCnt.txt_4c_PendOutr.Value = TratarNulo(loc_oBO.this_nPendente, 0)

                    loc_oCnt.txt_4c_Disponivel.ForeColor = ;
                        IIF(loc_nDisponivel < 0, RGB(255, 0, 0), RGB(0, 0, 255))
                    loc_oCnt.txt_4c_Disponivel.Value = loc_nDisponivel
                ENDIF
            ENDIF

            THIS.cnt_4c_Container1.Visible = loc_lVisivel

            IF loc_lVisivel
                THIS.CarregarDados()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + "Linha: " + TRANSFORM(loc_oErro.LineNo) + ;
                CHR(13) + "Procedure: " + loc_oErro.Procedure, "Erro em AtualizarContainer1")
        ENDTRY

        RETURN loc_lVisivel
    ENDPROC

    *==========================================================================
    * ProcessarLado - FUNIL UNICO de reprocessamento da tela: o equivalente do
    * PROCEDURE processa do form legado, na parte que cabe a VISAO. Manda o BO
    * recalcular para o lado da conta em foco e espelha o resultado nos tres
    * paineis, nos dois CheckBox e na grade.
    *
    * Roda na abertura do dialogo (ProcessarAberturaDialogo) e a CADA clique
    * nos CheckBox Sit_Origem/Sit_Destino - exatamente como o legado, que
    * reexecuta Processa() inteiro nesses mesmos pontos. Por isso toda
    * atualizacao de tela mora aqui, e nao espalhada pelos handlers: eh o que
    * impede o estado de um lado sobreviver ao outro.
    *
    * Devolve o llAtvCnt do legado (.T. = algum painel acendeu). Quem chama usa
    * esse retorno para decidir se tenta o lado oposto, igual ao legado.
    *
    * ORDEM obrigatoria: FormParaBO (entrega ao BO o lado em foco) -> o BO
    * calcula (ele decide visibilidade e valores) -> BOParaForm (espelha o
    * resultado na tela, com a ordem interna que a grade exige). O Refresh
    * final eh o Thisform.Refresh que encerra o Processa() legado.
    *
    * PUBLIC de proposito: eh o funil, chamado de fora da classe.
    *==========================================================================
    PROCEDURE ProcessarLado()
        LOCAL loc_lAtivouPainel, loc_oBO, loc_oErro

        loc_lAtivouPainel = .F.

        TRY
            loc_oBO = THIS.this_oBusinessObject

            IF VARTYPE(loc_oBO) = "O"
                THIS.FormParaBO()

                loc_lAtivouPainel = loc_oBO.Processar()

                THIS.BOParaForm()

                THIS.Refresh()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + "Linha: " + TRANSFORM(loc_oErro.LineNo) + ;
                CHR(13) + "Procedure: " + loc_oErro.Procedure, "Erro em ProcessarLado")
        ENDTRY

        RETURN loc_lAtivouPainel
    ENDPROC

    *==========================================================================
    * FormParaBO - transferencia TELA -> BO. Hook canonico do FormBase (lah ele
    * eh PROTECTED e vazio); PROTECTED aqui pela mesma razao: quem o chama eh o
    * proprio funil (ProcessarLado), nunca codigo de fora.
    *
    * Esta tela eh de EXIBICAO: os nove TextBox e o EditBox sao somente-leitura
    * (no legado todos tem "PROCEDURE When / Return .f.") e o que eles mostram
    * eh o RESULTADO do calculo do BO. Transferir esses campos de volta - o
    * "FormParaBO com TODOS os campos" do padrao CRUD - sobrescreveria com o
    * valor exibido justamente as properties que o BO acabou de calcular, e o
    * reprocessamento seguinte partiria do numero velho. Por isso o unico dado
    * que ESTA tela possui - e o unico que desce para o BO - eh a escolha do
    * LADO da conta em analise:
    *
    *   this_nOriDes      o lado FIXO que o form pai pediu (parametro pOriDes
    *                     do Init legado); ProcessarAberturaDialogo pode
    *                     forca-lo para 2 na segunda tentativa, como o legado
    *   this_nClickOriDes o lado escolhido pelo CLIQUE do usuario nos CheckBox
    *                     Sit_Origem/Sit_Destino (legado: ThisForm.ClickOriDes)
    *
    * Sao exatamente as duas variaveis que o DO CASE do Processa() legado le
    * para decidir qual conta analisar.
    *==========================================================================
    PROTECTED PROCEDURE FormParaBO()
        LOCAL loc_oBO

        loc_oBO = THIS.this_oBusinessObject

        IF VARTYPE(loc_oBO) = "O"
            loc_oBO.this_nOriDes      = THIS.this_nOriDes
            loc_oBO.this_nClickOriDes = THIS.this_nClickOriDes
        ENDIF
    ENDPROC

    *==========================================================================
    * BOParaForm - transferencia BO -> TELA. Hook canonico do FormBase (lah ele
    * eh PROTECTED e vazio); PROTECTED aqui pela mesma razao do FormParaBO.
    *
    * Nao repete mapeamento de campo: delega aos quatro espelhos que ja
    * transcrevem cada trecho do Processa() legado. A ORDEM eh obrigatoria:
    *   1. os CheckBox (habilitacao do lado, inicio do Processa legado);
    *   2. Container1 - acende o painel e so ENTAO repinta a grade, porque
    *      Refresh de grade dentro de container oculto nao pinta (regra #21);
    *   3. Container2 (observacao da conta);
    *   4. Container3, que fecha chamando ValidarSituacaoConta - eh ela que
    *      espelha a linha de bloqueio e o this_lRetorno lido pelo form pai.
    *
    * Os quatro rodam SEMPRE, inclusive quando o painel correspondente nao
    * aparece: eh o que ESCONDE o painel e APAGA a mensagem do lado anterior
    * quando o usuario troca Origem/Destino.
    *==========================================================================
    PROTECTED PROCEDURE BOParaForm()
        THIS.AtualizarCheckBoxesLado()
        THIS.AtualizarContainer1()
        THIS.AtualizarContainer2()
        THIS.AtualizarContainer3()
    ENDPROC

    *==========================================================================
    * TrocarLadoConta - corpo COMUM dos dois CheckBox de escolha de lado.
    * par_nLado: 1 = Conta Origem, 2 = Conta Destino.
    *
    * Legado - SIGOPLRC.Sit_Origem.Click:
    *     If ThisForm.OriDes = 0
    *         ThisForm.Sit_Origem.Enabled = .f.
    *         ThisForm.Sit_Destino.Enabled = .t.
    *     Endif
    *     ThisForm.ClickOriDes = 1
    *     If Not ThisForm.Processa()
    *         ThisForm.Sit_Destino.Click()
    *     EndIf
    *
    * Legado - SIGOPLRC.Sit_Destino.Click: identico, com o Enabled invertido,
    * ClickOriDes = 2 e DUAS linhas a mais no inicio (This.Value = 0 +
    * This.Refresh). A assimetria eh do legado - so o Destino desmarca o
    * proprio CheckBox - e esta transcrita como esta.
    *
    * O Enabled atribuido aqui eh depois RECALCULADO por
    * AtualizarCheckBoxesLado (dentro de ProcessarLado), igual ao legado, cujo
    * DO CASE em Processa() torna a habilitar o lado em foco - de modo que, com
    * lado livre (OriDes = 0), os dois CheckBox terminam habilitados.
    *
    * A volta ao lado oposto eh limitada a UM salto - ver a nota de
    * this_lLadoOpostoTentado na declaracao das propriedades.
    *==========================================================================
    PROTECTED PROCEDURE TrocarLadoConta(par_nLado)
        LOCAL loc_nLadoOposto

        IF THIS.this_nOriDes = 0
            IF par_nLado = 1
                THIS.chk_4c_Sit_Origem.Enabled  = .F.
                THIS.chk_4c_Sit_Destino.Enabled = .T.
            ELSE
                THIS.chk_4c_Sit_Destino.Enabled = .F.
                THIS.chk_4c_Sit_Origem.Enabled  = .T.
            ENDIF
        ENDIF

        *-- So o Destino zera o proprio Value (assimetria do legado)
        IF par_nLado = 2
            THIS.chk_4c_Sit_Destino.Value = 0
            THIS.chk_4c_Sit_Destino.Refresh()
        ENDIF

        THIS.this_nClickOriDes = par_nLado

        IF !THIS.ProcessarLado()
            IF !THIS.this_lLadoOpostoTentado
                THIS.this_lLadoOpostoTentado = .T.
                loc_nLadoOposto = IIF(par_nLado = 1, 2, 1)
                THIS.TrocarLadoConta(loc_nLadoOposto)
            ENDIF
        ENDIF
    ENDPROC

    *==========================================================================
    * ProcessarAberturaDialogo - fluxo de abertura do dialogo. Legado, fecho do
    * PROCEDURE Init:
    *     If Not Thisform.Processa()
    *         If ThisForm.OriDes > 0
    *             <reabilita o form Caixa> / ThisForm.Release
    *         Else
    *             ThisForm.OriDes = 2
    *             If Not ThisForm.Processa()
    *                 <reabilita o form Caixa> / ThisForm.Release
    *             EndIf
    *         Endif
    *     EndIf
    *
    * Com lado LIVRE (OriDes = 0) o legado tenta a conta Origem e, nao
    * acendendo painel nenhum, tenta a Destino forcando OriDes = 2; com lado
    * FIXO nao ha segunda tentativa. Transcrito como esta.
    *
    * O Release() do legado NAO eh reproduzido aqui: Release dentro do Init
    * cancela a instanciacao, e com isso o form pai perde a referencia de onde
    * leria this_lRetorno (e o harness de teste nunca consegue instanciar a
    * tela). No lugar dele fica this_lDialogoVazio, que Activate() consome para
    * fechar de verdade - ver a nota la.
    *
    * PUBLIC de proposito: eh o ponto de entrada do processamento, chamado de
    * fora da classe.
    *==========================================================================
    PROCEDURE ProcessarAberturaDialogo()
        LOCAL loc_lAtivouPainel, loc_oBO, loc_oErro

        loc_lAtivouPainel = .F.

        TRY
            loc_oBO = THIS.this_oBusinessObject

            IF VARTYPE(loc_oBO) = "O"
                IF loc_oBO.IniciarOperacao(THIS.this_cOperacao, THIS.this_nOriDes, ;
                        THIS.this_cAliasMovCab)

                    THIS.this_nClickOriDes       = 0
                    THIS.this_lLadoOpostoTentado = .F.

                    loc_lAtivouPainel = THIS.ProcessarLado()

                    *-- Segunda tentativa SO com lado livre (legado: OriDes = 2)
                    IF !loc_lAtivouPainel AND THIS.this_nOriDes = 0
                        THIS.this_nOriDes = 2
                        loc_lAtivouPainel = THIS.ProcessarLado()
                    ENDIF
                ENDIF

                THIS.this_lRetorno = loc_oBO.this_lRetorno
            ENDIF

            THIS.this_lDialogoVazio = !loc_lAtivouPainel

            *-- O legado reabilita o form Caixa no caminho em que desiste de
            *-- abrir, logo antes do Release
            IF THIS.this_lDialogoVazio AND VARTYPE(THIS.this_oFormCaixa) = "O"
                THIS.this_oFormCaixa.Enabled = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + "Linha: " + TRANSFORM(loc_oErro.LineNo) + ;
                CHR(13) + "Procedure: " + loc_oErro.Procedure, "Erro em ProcessarAberturaDialogo")
        ENDTRY

        RETURN loc_lAtivouPainel
    ENDPROC

    *==========================================================================
    * ConfigurarBotoes - unico botao de acao do form (legado: SIGOPLRC.ok,
    * classe fwbtng, Top=3, Left=923, Caption="Encerrar", Cancel=.T.,
    * Picture=cadastro_salvar_60.jpg, ToolTipText="[ESC] Encerrar").
    *
    * Geometria 75x75 (o canonico de botao do projeto) no lugar dos 80x100 da
    * classe fwbtng: com 80 de largura o botao terminaria em 1003, fora do form
    * de 1000, e com 100 de altura passaria da faixa do cabecalho. 923+75=998 e
    * 3+75=78 cabem exatamente. O canonico cnt_4c_Saida (Left=917, Encerrar no
    * rodape) NAO se aplica - eh dos CRUD paginados, e aqui o legado poe o
    * botao no topo direito, sobre a faixa.
    *
    * Themes=.T. + DisabledPicture: CommandButton SOLTO (fora de CommandGroup)
    * com Picture nao desenha o icone com Themes=.F.
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarBotoes()
        THIS.AddObject("cmd_4c_Ok", "CommandButton")

        WITH THIS.cmd_4c_Ok
            .Top             = 3
            .Left            = 923
            .Width           = 75
            .Height          = 75
            .Caption         = "Encerrar"
            .FontName        = "Comic Sans MS"
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
            .Cancel          = .T.
            .TabIndex        = 1
            .ToolTipText     = "[ESC] Encerrar"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
            .DisabledPicture = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
        ENDWITH
    ENDPROC

    *==========================================================================
    * ConfigurarEventos - BINDEVENT dos controles de acao. Os handlers alvo
    * sao PUBLIC de proposito: BINDEVENT falha EM SILENCIO com metodo
    * PROTECTED.
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarEventos()
        BINDEVENT(THIS.cmd_4c_Ok, "Click", THIS, "CmdOkClick")

        *-- Legado: Sit_Origem.Click / Sit_Destino.Click. "Click" (e nao
        *-- InteractiveChange) eh o evento do legado, e eh o que tambem serve
        *-- ao caminho em que um lado salta para o outro.
        BINDEVENT(THIS.chk_4c_Sit_Origem,  "Click", THIS, "ChkSitOrigemClick")
        BINDEVENT(THIS.chk_4c_Sit_Destino, "Click", THIS, "ChkSitDestinoClick")
    ENDPROC

    *==========================================================================
    * CmdOkClick - legado: SIGOPLRC.ok.Click
    *     If Type('ThisForm.poFormCaixa') = "O"
    *         ThisForm.PoFormCaixa.Enabled = .t.
    *     Endif
    *     Thisform.release
    *==========================================================================
    PROCEDURE CmdOkClick()
        LOCAL loc_oErro

        TRY
            THIS.FecharDialogo()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + "Linha: " + TRANSFORM(loc_oErro.LineNo) + ;
                CHR(13) + "Procedure: " + loc_oErro.Procedure, "Erro em CmdOkClick")
        ENDTRY
    ENDPROC

    *==========================================================================
    * ChkSitOrigemClick - legado: SIGOPLRC.Sit_Origem.Click (ver a transcricao
    * linha a linha em TrocarLadoConta, que eh o corpo comum dos dois).
    *
    * Este wrapper existe por causa da guarda de reentrancia: o corpo mexe em
    * Value/Enabled/Refresh dos proprios CheckBox e pode redisparar Click, e o
    * caminho de falha salta para o lado oposto. Zerar this_lEmTrocaDeLado
    * DEPOIS do ENDTRY (e tambem no CATCH) eh obrigatorio - flag que trava
    * ligada mata a troca de lado pelo resto da vida do form.
    *
    * PUBLIC de proposito: BINDEVENT falha EM SILENCIO com metodo PROTECTED.
    *==========================================================================
    PROCEDURE ChkSitOrigemClick()
        LOCAL loc_oErro

        TRY
            IF !THIS.this_lEmTrocaDeLado
                THIS.this_lEmTrocaDeLado     = .T.
                THIS.this_lLadoOpostoTentado = .F.

                THIS.TrocarLadoConta(1)
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + "Linha: " + TRANSFORM(loc_oErro.LineNo) + ;
                CHR(13) + "Procedure: " + loc_oErro.Procedure, "Erro em ChkSitOrigemClick")
        ENDTRY

        THIS.this_lEmTrocaDeLado = .F.
    ENDPROC

    *==========================================================================
    * ChkSitDestinoClick - legado: SIGOPLRC.Sit_Destino.Click. Ver a nota de
    * ChkSitOrigemClick (guarda de reentrancia) e TrocarLadoConta (corpo).
    *
    * PUBLIC de proposito: BINDEVENT falha EM SILENCIO com metodo PROTECTED.
    *==========================================================================
    PROCEDURE ChkSitDestinoClick()
        LOCAL loc_oErro

        TRY
            IF !THIS.this_lEmTrocaDeLado
                THIS.this_lEmTrocaDeLado     = .T.
                THIS.this_lLadoOpostoTentado = .F.

                THIS.TrocarLadoConta(2)
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + "Linha: " + TRANSFORM(loc_oErro.LineNo) + ;
                CHR(13) + "Procedure: " + loc_oErro.Procedure, "Erro em ChkSitDestinoClick")
        ENDTRY

        THIS.this_lEmTrocaDeLado = .F.
    ENDPROC

    *==========================================================================
    * FecharDialogo - ponto UNICO de fechamento da tela.
    *
    * Fecha com Hide(), NAO com Release(): este form eh um dialogo que devolve
    * resultado - quem o abre le THIS.this_lRetorno depois do Show() modal
    * retornar (o legado devolvia pelo RETURN do evento Unload, inalcancavel em
    * CREATEOBJECT + Show). Release() destroi o objeto mesmo com o chamador
    * segurando a referencia, e a leitura seguinte estoura "is not an object".
    * Cabe ao CHAMADOR dar Release() depois de ler. Hide() em form modal tambem
    * devolve o Show(), entao para o usuario a tela fecha igual.
    *
    * Por isso o efeito EXTERNO que o legado fazia no ok.Click (reabilitar o
    * form Caixa) mora aqui, antes do Hide, e nao so no Destroy: com Hide() o
    * Destroy so roda quando o chamador liberar o objeto - tarde demais.
    * O Destroy mantem a mesma reabilitacao como rede de seguranca (repetir eh
    * inocuo) para o caminho em que a tela eh fechada sem passar por aqui.
    *==========================================================================
    PROCEDURE FecharDialogo()
        IF VARTYPE(THIS.this_oFormCaixa) = "O"
            THIS.this_oFormCaixa.Enabled = .T.
        ENDIF

        THIS.Hide()
    ENDPROC

    *==========================================================================
    * Activate - fecha o dialogo quando nao ha nada para mostrar.
    *
    * O legado resolvia isso com ThisForm.Release DENTRO do Init, o que em VFP9
    * CANCELA a instanciacao: CREATEOBJECT devolve .F. logico e o form pai
    * perde a referencia de onde leria this_lRetorno (e o harness de teste
    * nunca consegue instanciar a tela). Por isso ProcessarAberturaDialogo
    * apenas MARCA this_lDialogoVazio e o fechamento acontece aqui - Activate
    * roda DEPOIS do Show(), onde o Hide() de FecharDialogo devolve de fato o
    * controle a quem abriu, com a referencia do form viva para a leitura do
    * resultado.
    *==========================================================================
    PROCEDURE Activate()
        IF THIS.this_lDialogoVazio
            THIS.FecharDialogo()
        ENDIF

        RETURN DODEFAULT()
    ENDPROC

    *==========================================================================
    * Unload - legado: PROCEDURE Unload / Return (ThisForm.Retorno).
    * Mantido para atender quem abra a tela com DO FORM ... TO <var>; o
    * consumo canonico no sistema novo eh ler THIS.this_lRetorno direto da
    * referencia do form, que Hide() mantem viva.
    *==========================================================================
    PROCEDURE Unload()
        RETURN THIS.this_lRetorno
    ENDPROC

    *==========================================================================
    * TornarControlesVisiveis - torna visiveis os controles do cabecalho.
    * FILTRO OBRIGATORIO: cnt_4c_Container1/2/3 sao paineis FLUTUANTES que o
    * BO mostra ou esconde conforme a operacao e o lado da conta em analise
    * (regra de negocio, nao defeito de layout) - permanecem ocultos aqui.
    *
    * O filtro RECURSA no painel antes de pular: AddObject cria todo filho com
    * Visible=.F., entao pular o container inteiro deixaria os FILHOS dele
    * invisiveis para sempre - quando o BO acendesse cnt_4c_Container1 o painel
    * apareceria VAZIO, sem a grade. Pula-se apenas o Visible do PROPRIO
    * container.
    *==========================================================================
    PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
        LOCAL loc_nI, loc_oObjeto

        FOR loc_nI = 1 TO par_oContainer.ControlCount
            loc_oObjeto = par_oContainer.Controls(loc_nI)

            IF VARTYPE(loc_oObjeto) = "O"
                IF INLIST(UPPER(loc_oObjeto.Name), "CNT_4C_CONTAINER1", "CNT_4C_CONTAINER2", "CNT_4C_CONTAINER3")
                    IF PEMSTATUS(loc_oObjeto, "ControlCount", 5) AND loc_oObjeto.ControlCount > 0
                        THIS.TornarControlesVisiveis(loc_oObjeto)
                    ENDIF
                    LOOP
                ENDIF

                *-- lbl_4c_Msg5 (legado: lb_msg5) eh a linha de BLOQUEIO: o
                *-- legado a mantem oculta e so a acende quando a situacao da
                *-- conta recusa o movimento (ValidarSituacaoConta). Forcar
                *-- Visible = .T. aqui APAGARIA esse Visible = .F. e deixaria
                *-- uma faixa amarela vazia no bloco de situacao.
                IF UPPER(loc_oObjeto.Name) == "LBL_4C_MSG5"
                    LOOP
                ENDIF

                IF PEMSTATUS(loc_oObjeto, "Visible", 5)
                    loc_oObjeto.Visible = .T.
                ENDIF

                IF PEMSTATUS(loc_oObjeto, "ControlCount", 5) AND loc_oObjeto.ControlCount > 0
                    THIS.TornarControlesVisiveis(loc_oObjeto)
                ENDIF
            ENDIF
        ENDFOR
    ENDPROC

    *==========================================================================
    * Destroy - reabilita o form Caixa (quando informado) e libera recursos
    *==========================================================================
    PROCEDURE Destroy()
        IF VARTYPE(THIS.this_oFormCaixa) = "O"
            THIS.this_oFormCaixa.Enabled = .T.
        ENDIF

        IF VARTYPE(THIS.this_oBusinessObject) = "O"
            THIS.this_oBusinessObject = .NULL.
        ENDIF

        IF USED("cursor_4c_Operacoes")
            USE IN cursor_4c_Operacoes
        ENDIF

        DODEFAULT()
    ENDPROC

ENDDEFINE

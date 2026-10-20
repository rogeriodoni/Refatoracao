*====================================================================
* FormSIGPRTRF.prg
*
* Dialogo de selecao de Produtos para a Relacao de Transferencia.
* Equivalente ao SIGPRTRF.SCX do legado: form MODAL pequeno (436x450),
* SEM barra de titulo/menu de controle, sem PageFrame Lista/Dados -
* layout customizado com um unico container de grade e dois botoes
* (Ok/Cancelar).
*
* Herda de: FormBase
*====================================================================

DEFINE CLASS FormSIGPRTRF AS FormBase

    *-- Propriedades visuais (copiadas do SCX legado - dialogo modal
    *-- pequeno, NAO segue o padrao canonico 1000x600 de form CRUD)
    Height      = 450
    Width       = 436
    AutoCenter  = .T.
    BorderStyle = 2
    ControlBox  = .F.
    WindowType  = 1
    ShowWindow  = 1
    DataSession = 2

    *-- Propriedades de controle (equivalentes as do legado)
    this_cCodigoAnterior = ""      && ThisForm.AntCPro - valor anterior da coluna Codigo (Column1.When/Valid)
    this_cRetorno        = " "     && ThisForm.Retorno - "Ok" (confirmado) ou " " (cancelado)
    this_cCursorGrade    = "cursor_4c_Produtos"    && equivalente ao CrProduto do legado
    this_lFocoAplicado   = .F.     && foco inicial na grade ja aplicado (ver Activate)

    *-- Guarda de reentrancia do lookup de produto (regra #37/#47): o
    *-- FormBuscaAuxiliar eh MODAL, tira o foco da celula e redispara o
    *-- Valid/LostFocus que o chamou; as tres portas de entrada (Valid da
    *-- celula, F4 e duplo clique) desaguam no MESMO funil, entao sem esta
    *-- flag o usuario leva dois pickers empilhados.
    this_lEmLookupProduto = .F.

    *-- Guarda de reentrancia da confirmacao (botao Ok). O laco de espera do
    *-- legado (altera.Click) eh um "DO While ... Enddo" SEM DOEVENTS, que em
    *-- VFP9 bloqueia todo o processamento de eventos - o usuario nao
    *-- consegue clicar nem digitar enquanto a contagem roda. A versao
    *-- migrada CHAMA DOEVENTS de proposito (para o container de "Aguarde"
    *-- repintar os 13 blocos da animacao), e isso reabre a porta que o
    *-- legado mantinha fechada: sem esta flag, um segundo clique no Ok
    *-- entra de novo em BtnOkClick e inicia uma animacao ANINHADA.
    this_lEmConfirmacao = .F.

    *-- Espelho da lista de codigos montada pelo BO (this_cListaProdutos),
    *-- cacheado no Destroy ANTES de o BO ser liberado. Existe porque o
    *-- evento Unload dispara DEPOIS do Destroy e ja nao alcanca o BO
    *-- (mesma armadilha documentada no Formsigprdft, migrado do
    *-- SIGPRDFT.Unload) e porque o chamador que abre esta tela por
    *-- CREATEOBJECT + Show() nao tem acesso ao valor devolvido pelo Unload.
    this_cListaProdutosSelecionados = ""

    *====================================================================
    * Init - APENAS DODEFAULT (FormBase chama InicializarForm)
    *====================================================================
    PROCEDURE Init()
        *-- DODEFAULT() ja chama InicializarForm() atraves do FormBase.Init()
        RETURN DODEFAULT()
    ENDPROC

    *====================================================================
    * InicializarForm - Cria Business Object, o cursor da grade, o
    * container principal (label + grade) e os botoes Ok/Cancelar.
    * Eventos de clique/validacao ficam para a fase de comportamento.
    *====================================================================
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lResultado
        loc_lResultado = .F.

        *-- Guarda de conexao do Init legado (ramo Else do
        *-- "If (.poDataMgr.pnIdconn > 0)"): sem banco a tela NAO abre.
        *-- Fica ANTES de tudo e com o RETURN aqui fora de qualquer
        *-- TRY/CATCH (regra #1).
        IF !THIS.ValidarParametros()
            RETURN .F.
        ENDIF

        THIS.Caption = "Rela" + CHR(231) + CHR(227) + "o de Produtos"

        THIS.this_oBusinessObject = CREATEOBJECT("SIGPRTRFBO")

        IF VARTYPE(THIS.this_oBusinessObject) != "O"
            RETURN .F.
        ENDIF

        *-- Equivalente ao SQLEXEC de LocalParac no Init do legado (parametro
        *-- de tempo de espera usado na animacao de confirmacao do botao Ok)
        IF TYPE("gb_4c_ValidandoUI") != "L" OR !gb_4c_ValidandoUI
            THIS.this_oBusinessObject.CarregarParametroTempoEspera()
        ENDIF

        *-- Equivalente ao "Create Cursor CrProduto" do Load legado - tem
        *-- de existir ANTES do Grid ser ligado a ele (regra do ControlSource
        *-- de cursor ainda inexistente derrubando o Init)
        THIS.CriarCursorProdutos()

        THIS.ConfigurarContainerReferencia()

        *-- Vincula a grade ao cursor e a repinta - equivalente ao bloco
        *-- "With Thisform.Cnt_Referencia.Grade / .RecordSource /
        *-- .ControlSource / .Refresh / EndWith" do Init legado. Fica em
        *-- metodo proprio para poder ser rechamado em TODO caminho que
        *-- recria ou repopula o cursor da grade.
        THIS.CarregarLista()

        *-- sigprtrf.oModem (OLE 100x100, Secao 1 do dump) nao tem nenhum
        *-- metodo/evento no dump (Secao 3) nem referencia em Secao 4 alem
        *-- do proprio form - objeto decorativo sem comportamento algum,
        *-- por isso omitido aqui; nenhuma funcionalidade do dialogo
        *-- depende dele (Ok/Cancelar e a grade nao o referenciam).
        THIS.ConfigurarBotoesPrincipais()

        THIS.ConfigurarContainerMensagem()

        THIS.TornarControlesVisiveis(THIS)

        loc_lResultado = .T.
        RETURN loc_lResultado
    ENDPROC

    *====================================================================
    * ValidarParametros - Transcricao da guarda de conexao do Init legado,
    * que RECUSA abrir a tela quando o banco nao esta utilizavel:
    *
    *   .poDataMgr = CreateObject('fSqlConector')
    *   If (.poDataMgr.pnIdconn > 0)
    *       ... monta a tela ...
    *   Else
    *       =Messagebox('Impossivel Efetuar Conexao com Servidor de Banco
    *                    de Dados...', 0+48, 'CreateObject')
    *       Return .f.
    *   EndIf
    *
    * Na nova arquitetura nao existe fSqlConector por tela: a conexao eh o
    * handle global gnConnHandle. O "pnIdconn > 0" do legado colapsa nas
    * duas checagens abaixo - handle ausente/nao-numerico e handle <= 0 -
    * preservando a mensagem e o titulo "CreateObject" do legado.
    *
    * O BYPASS de modo de teste eh obrigatorio: o harness de
    * 06b_testeAutomatico define gnConnHandle = 0 DE PROPOSITO (sentinela,
    * porque SQLSTRINGCONNECT bloqueia 300s no timeout TCP quando o
    * servidor esta inacessivel) e espera que os forms pulem as queries por
    * gb_4c_ModoTeste/gb_4c_ValidandoUI, nunca por checagem de handle. Sem
    * o bypass, esta guarda devolveria .F. -> InicializarForm devolve .F.
    * -> CREATEOBJECT devolve logico e o teste "Instanciacao" reprova
    * SEMPRE, sem nenhum erro de SQL no log.
    *
    * PUBLIC (sem PROTECTED): alem de ser chamado por THIS. no
    * InicializarForm, eh alcancavel pelo harness, que chama metodos do
    * form de FORA da classe (regra #3).
    *====================================================================
    PROCEDURE ValidarParametros()
        LOCAL loc_lValido
        loc_lValido = .T.

        IF TYPE("gb_4c_ModoTeste") = "L" AND gb_4c_ModoTeste
            RETURN .T.
        ENDIF

        IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
            RETURN .T.
        ENDIF

        DO CASE
            CASE TYPE("gnConnHandle") != "N"
                MsgErro("Imposs" + CHR(237) + "vel Efetuar Conex" + CHR(227) + ;
                        "o com Servidor de Banco de Dados...", "CreateObject")
                loc_lValido = .F.

            CASE gnConnHandle <= 0
                MsgErro("Imposs" + CHR(237) + "vel Efetuar Conex" + CHR(227) + ;
                        "o com Servidor de Banco de Dados...", "CreateObject")
                loc_lValido = .F.
        ENDCASE

        RETURN loc_lValido
    ENDPROC

    *====================================================================
    * CriarCursorProdutos - Cria o cursor local que alimenta a grade de
    * selecao de produtos (equivalente ao "Create Cursor CrProduto" do
    * Load legado) e inicia com uma linha vazia, pronta para digitacao
    * (equivalente ao "Select CrProduto / Append Blank" do Init legado).
    *====================================================================
    PROTECTED PROCEDURE CriarCursorProdutos()
        IF USED("cursor_4c_Produtos")
            USE IN cursor_4c_Produtos
        ENDIF

        CREATE CURSOR cursor_4c_Produtos (Cpros C(14), Dpros C(40))

        SELECT (THIS.this_cCursorGrade)
        APPEND BLANK
    ENDPROC

    *====================================================================
    * ConfigurarContainerReferencia - Cria o container principal (ja
    * existente desde a Fase 3) e adiciona seus filhos visuais: label de
    * identificacao e grade de produtos (Fase 4).
    *====================================================================
    PROTECTED PROCEDURE ConfigurarContainerReferencia()
        THIS.AddObject("cnt_4c__Referencia", "Container")
        WITH THIS.cnt_4c__Referencia
            .Top         = 1
            .Left        = 2
            .Width       = 433
            .Height      = 392
            .BackStyle   = 1
            .BackColor   = RGB(255, 255, 255)
            .BorderColor = RGB(128, 128, 128)
            .TabStop     = .F.
            .Visible     = .T.
        ENDWITH

        THIS.ConfigurarLabelIdentificacao()
        THIS.ConfigurarGradeProdutos()
    ENDPROC

    *====================================================================
    * ConfigurarLabelIdentificacao - Label "Informe os Produtos"
    * (sigprtrf.Cnt_Referencia.lblident no legado).
    *====================================================================
    PROTECTED PROCEDURE ConfigurarLabelIdentificacao()
        WITH THIS.cnt_4c__Referencia
            .AddObject("lbl_4c_Lblident", "Label")
            WITH .lbl_4c_Lblident
                .Top       = 57
                .Left      = 8
                .Width     = 146
                .Height    = 20
                .AutoSize  = .F.
                .Alignment = 2
                .BackStyle = 0
                .FontBold  = .T.
                .FontSize  = 11
                .ForeColor = RGB(0, 0, 255)
                .Caption   = "Informe os Produtos"
            ENDWITH
        ENDWITH
    ENDPROC

    *====================================================================
    * ConfigurarGradeProdutos - Cria a grade de produtos (grd_4c_Dados),
    * 2 colunas (Codigo/Descricao). Equivalente a
    * sigprtrf.Cnt_Referencia.Grade (fwgrade) do legado.
    *
    * Aqui ficam SO as propriedades do GRID. O vinculo ao cursor mora em
    * CarregarLista() e o formato das COLUNAS em AplicarFormatoColunas(),
    * chamado de la - ver a explicacao nos dois metodos.
    *
    * Valid/When/LostFocus de Column1.Text1 (lookup de produto) e os
    * eventos dos botoes ficam para a fase de comportamento (Fase 7/8).
    *====================================================================
    PROTECTED PROCEDURE ConfigurarGradeProdutos()
        WITH THIS.cnt_4c__Referencia
            .AddObject("grd_4c_Dados", "Grid")
            WITH .grd_4c_Dados
                .Top        = 78
                .Left       = 3
                .Width      = 429
                .Height     = 309
                .FontName   = "Arial"
                .FontSize   = 8
                .ScrollBars = 2
                .RowHeight  = 17

                *-- ColumnCount ANTES de qualquer referencia a .ColumnN:
                *-- a Grid criada por AddObject nasce sem colunas
                .ColumnCount = 2
            ENDWITH
        ENDWITH

        *-- Duplo clique na grade abre o picker de produto (mesmo funil do
        *-- F4 e do Valid da celula). O VFP entrega o DblClick ao controle
        *-- que estiver SOB o ponteiro: dentro da celula quem recebe eh o
        *-- TextBox da Column1 (tratado em TextBoxProdutoTrf_4c.DblClick);
        *-- fora dela - area vazia da grade, abaixo da ultima linha -
        *-- quem recebe eh o proprio Grid, e eh esse caminho que o
        *-- BINDEVENT cobre. As duas rotas chamam AbrirBuscaProdutoGrade,
        *-- que eh guardado por this_lEmLookupProduto, entao nao ha risco
        *-- de abrir dois pickers. Handler PUBLIC (regra #3).
        BINDEVENT(THIS.cnt_4c__Referencia.grd_4c_Dados, "DblClick", THIS, "GradeProdutosDblClick")
    ENDPROC

    *====================================================================
    * AplicarFormatoColunas - Formato das 2 colunas da grade de produtos
    * (fontes, mascaras, cabecalhos, larguras e a trava da coluna da
    * Descricao). Metodo PROPRIO porque tem de ser REAPLICADO depois de
    * cada vinculo: medido no VFP9 (2026-10-20), quando o alias da grade
    * eh derrubado o Grid cai para ColumnCount = 0 e, ao repor o
    * ColumnCount, os objetos Column nascem de novo com o DEFAULT -
    * Format "K!" volta a "", InputMask "!!!!!!!!!!" volta a "",
    * Courier New volta a Arial, Movable/Resizable voltam a .T.,
    * Header1.Alignment volta a 6 e Column2.ReadOnly volta a .F.
    * (isto eh, a coluna da Descricao volta a aceitar digitacao).
    *
    * Reatribuir RecordSource com o alias ABERTO nao reseta nada (tambem
    * medido), mas reaplicar eh idempotente e cobre os dois casos.
    *====================================================================
    PROTECTED PROCEDURE AplicarFormatoColunas()
        LOCAL loc_oGrade

        loc_oGrade = THIS.cnt_4c__Referencia.grd_4c_Dados

        WITH loc_oGrade
            *-- Grid.ReadOnly propaga para as colunas, por isso vem ANTES
            *-- do ReadOnly de coluna, la embaixo
            .ReadOnly = .F.

            .Column1.Width     = 108
            .Column1.FontName  = "Courier New"
            .Column1.FontSize  = 8
            .Column1.Movable   = .F.
            .Column1.Resizable = .F.
            .Column1.Format    = "K!"
            .Column1.ReadOnly  = .F.
            .Column1.Header1.FontName  = "Arial"
            .Column1.Header1.FontSize  = 8
            .Column1.Header1.Alignment = 2
            .Column1.Header1.Caption   = "C" + CHR(243) + "d. Produto"
            *-- Lookup de produto (legado: Grade.Column1.Text1.Valid, fwBuscaExt
            *-- contra SigCdPro) + avanco automatico de linha (legado:
            *-- Grade.Column1.Text1.LostFocus) + snapshot do valor anterior
            *-- (legado: Grade.Column1.Text1.When). Column.AddObject sozinho
            *-- NAO exibe o controle - precisa de CurrentControl + Sparse
            *-- (regra #18); a validacao mora no Valid do TextBox da coluna
            *-- (regra #46), NUNCA em AfterRowColChange. Guarda defensiva
            *-- porque este metodo eh REAPLICADO sempre que o ColumnCount eh
            *-- reposto (ver cabecalho do metodo) - sem ela, o 2o AddObject
            *-- estoura "Object txt_4c_CelCodigo is already defined".
            IF !PEMSTATUS(.Column1, "txt_4c_CelCodigo", 5)
                .Column1.AddObject("txt_4c_CelCodigo", "TextBoxProdutoTrf_4c")
            ENDIF
            .Column1.CurrentControl = "txt_4c_CelCodigo"
            .Column1.Sparse         = .F.

            .Column2.Width     = 290
            .Column2.FontName  = "Courier New"
            .Column2.FontSize  = 8
            .Column2.Movable   = .F.
            .Column2.Resizable = .F.
            .Column2.Header1.FontName  = "Arial"
            .Column2.Header1.FontSize  = 8
            .Column2.Header1.Alignment = 2
            .Column2.Header1.Caption   = "Descri" + CHR(231) + CHR(227) + "o do Produto"
            .Column2.Text1.FontName    = "Courier New"
            .Column2.Text1.FontSize    = 8
            .Column2.Text1.BorderStyle = 0
            .Column2.Text1.Margin      = 0
            .Column2.Text1.ForeColor   = RGB(0, 0, 0)
            .Column2.Text1.BackColor   = RGB(255, 255, 255)
            .Column2.Text1.Visible     = .T.

            *-- A coluna da Descricao nao aceita digitacao: no legado
            *-- sigprtrf...Grade.Column2.Text1.When faz "Return .f.".
            *-- O equivalente eh Column.ReadOnly, e ele tem de vir DEPOIS
            *-- do Grid.ReadOnly acima, que propaga para as colunas.
            .Column2.ReadOnly = .T.
        ENDWITH
    ENDPROC

    *====================================================================
    * GuardarCodigoAnteriorProduto - snapshot do valor da celula ANTES da
    * edicao (legado: Grade.Column1.Text1.When -> ThisForm.AntCPro =
    * This.Value). Usado por ValidarCodigoProdutoGridExec para saber se o
    * usuario realmente alterou o codigo digitado. PUBLIC porque eh
    * chamado de fora da classe (THISFORM) pelo TextBox da coluna
    * (TextBoxProdutoTrf_4c.When, em classes\TextBoxGridLookup.prg).
    *====================================================================
    PROCEDURE GuardarCodigoAnteriorProduto(par_oTxt)
        IF VARTYPE(par_oTxt) = "O"
            THIS.this_cCodigoAnterior = par_oTxt.Value
        ENDIF
    ENDPROC

    *====================================================================
    * ValidarCodigoProdutoGridExec - Valid da celula "Codigo" (Column1) da
    * grade de produtos. par_oTxt eh o TextBox da coluna (regra #46):
    * dentro do Valid, o valor digitado esta em par_oTxt.Value e AINDA NAO
    * chegou ao cursor.
    *
    * Equivalente ao legado (Grade.Column1.Text1.Valid):
    *   If This.Value = ThisForm.AntCPro / Return / EndIf
    *   If Not Empty(This.Value)
    *       fwBuscaExt(poDataMgr.pnIdConn,'SigCdPro','CrProds','cpros',
    *                   This.Value,'Produtos',1000)
    *       Se nao achou exato, mAddColuna + Show() (picker)
    *       Se Used('CrProds'): This.Value = Cpros,
    *           Replace CrProduto.Dpros With CrProds.dpros,
    *           Column2.Text1.Value = Dpros
    *   EndIf
    *====================================================================
    FUNCTION ValidarCodigoProdutoGridExec(par_oTxt)

        IF VARTYPE(par_oTxt) != "O"
            RETURN .T.
        ENDIF

        *-- "If This.Value = ThisForm.AntCPro / Return" - nao mudou, nao
        *-- reabre o lookup
        IF par_oTxt.Value = THIS.this_cCodigoAnterior
            RETURN .T.
        ENDIF

        *-- "If Not Empty(This.Value)" - campo vazio NAO abre lookup pelo
        *-- Valid (o legado so consulta com valor digitado). O F4 e o duplo
        *-- clique, ao contrario, abrem com o campo vazio de proposito -
        *-- por isso esta guarda mora AQUI e nao dentro do funil.
        IF EMPTY(ALLTRIM(par_oTxt.Value))
            RETURN .T.
        ENDIF

        THIS.AbrirBuscaProdutoGrade(par_oTxt)

        RETURN .T.
    ENDFUNC

    *====================================================================
    * AbrirBuscaProdutoGrade - FUNIL do lookup de produto da grade
    * (legado: fwBuscaExt do Grade.Column1.Text1.Valid). Tres portas de
    * entrada desaguam aqui: o Valid da celula
    * (ValidarCodigoProdutoGridExec), o F4/F5 e o duplo clique
    * (TextBoxProdutoTrf_4c.KeyPress/DblClick e GradeProdutosDblClick).
    *
    * Este wrapper existe SO para a guarda de reentrancia (regra #47): o
    * picker eh MODAL, tira o foco da celula e redispara o Valid/LostFocus
    * que o chamou. O corpo vive em AbrirBuscaProdutoGradeExec porque ele
    * tem RETURN antecipado - set no topo / clear no fim do MESMO metodo
    * deixaria a flag presa ligada e MATARIA o lookup pelo resto da vida
    * do dialogo.
    *
    * PUBLIC: chamado de fora da classe (THISFORM) pelo TextBox da coluna.
    *====================================================================
    PROCEDURE AbrirBuscaProdutoGrade(par_oTxt)
        IF THIS.this_lEmLookupProduto
            RETURN
        ENDIF

        THIS.this_lEmLookupProduto = .T.
        THIS.AbrirBuscaProdutoGradeExec(par_oTxt)
        THIS.this_lEmLookupProduto = .F.
    ENDPROC

    *====================================================================
    * AbrirBuscaProdutoGradeExec - corpo do lookup de produto. Transcricao
    * do legado (Grade.Column1.Text1.Valid):
    *
    *   m.loLista = CreateObject('fwBuscaExt', poDataMgr.pnIdConn,
    *                 'SigCdPro','CrProds','cpros',This.Value,'Produtos',1000)
    *   If !(m.loLista.plAchouRegistro)
    *       m.loLista.mAddColuna('cpros','','Codigo')
    *       m.loLista.mAddColuna('dpros','','Descricao')
    *       m.loLista.Show()
    *   EndIf
    *   If Used('CrProds')
    *       This.Value = Evaluate('CrProds.Cpros')
    *       Replace CrProduto.Dpros With CrProds.dpros in CrProduto
    *       This.Parent.Parent.Column2.Text1.Value = Evaluate('CrProds.Dpros')
    *   EndIf
    *====================================================================
    PROTECTED PROCEDURE AbrirBuscaProdutoGradeExec(par_oTxt)
        LOCAL loc_cCodigo, loc_oBusca, loc_oErro

        IF VARTYPE(par_oTxt) != "O"
            RETURN
        ENDIF

        IF !USED(THIS.this_cCursorGrade)
            RETURN
        ENDIF

        loc_cCodigo = ALLTRIM(par_oTxt.Value)

        TRY
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigCdPro", "cursor_4c_BuscaProdutoTrf", "cpros", loc_cCodigo, ;
                "Produtos")

            IF VARTYPE(loc_oBusca) = "O"
                *-- Init ja tentou o match exato (regra #37) - so abre o
                *-- picker se nao achou, sem MsgAviso nem clear do digitado
                *-- (regra #50)
                IF !loc_oBusca.this_lAchouRegistro
                    loc_oBusca.mAddColuna("cpros", "", "C" + CHR(243) + "digo")
                    loc_oBusca.mAddColuna("dpros", "", "Descri" + CHR(231) + CHR(227) + "o")
                    loc_oBusca.Show()
                ENDIF

                IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaProdutoTrf") AND RECCOUNT("cursor_4c_BuscaProdutoTrf") > 0
                    SELECT cursor_4c_BuscaProdutoTrf

                    *-- Produto escolhido entra no BO e sai dele para a linha
                    *-- da grade por BOParaForm(), que concentra as TRES
                    *-- atribuicoes do legado (cursor.Dpros, This.Value da
                    *-- celula do Codigo e Column2.Text1.Value). Fonte unica:
                    *-- este caminho e o do Valid gravam pelo MESMO metodo.
                    THIS.this_oBusinessObject.this_cCodigoProduto    = ALLTRIM(NVL(cpros, ""))
                    THIS.this_oBusinessObject.this_cDescricaoProduto = ALLTRIM(NVL(dpros, ""))

                    THIS.BOParaForm()
                ENDIF

                loc_oBusca.Release()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "FormSIGPRTRF.AbrirBuscaProdutoGradeExec")
        ENDTRY

        IF USED("cursor_4c_BuscaProdutoTrf")
            USE IN cursor_4c_BuscaProdutoTrf
        ENDIF
    ENDPROC

    *====================================================================
    * GradeProdutosDblClick - duplo clique na grade (ligado por BINDEVENT
    * em ConfigurarGradeProdutos). Cobre o clique FORA da area da celula -
    * dentro dela o DblClick eh consumido pelo TextBox da Column1
    * (TextBoxProdutoTrf_4c.DblClick), que chama o mesmo funil.
    *
    * PUBLIC: BINDEVENT nao enxerga metodo PROTECTED (regra #3).
    *====================================================================
    PROCEDURE GradeProdutosDblClick()
        LOCAL loc_oGrade, loc_oCelula

        loc_oGrade = THIS.cnt_4c__Referencia.grd_4c_Dados

        *-- O lookup eh da coluna do Codigo; nas outras colunas o duplo
        *-- clique nao faz nada (a Descricao eh somente-leitura no legado)
        IF loc_oGrade.ActiveColumn != 1
            RETURN
        ENDIF

        loc_oCelula = THIS.ObterCelulaCodigo()

        IF VARTYPE(loc_oCelula) != "O"
            RETURN
        ENDIF

        THIS.AbrirBuscaProdutoGrade(loc_oCelula)
    ENDPROC

    *====================================================================
    * AvancarLinhaProdutoGridExec - equivalente ao legado
    * (Grade.Column1.Text1.LostFocus): ao SAIR da celula do Codigo com
    * ENTER, garante uma linha vazia abaixo para continuar digitando e
    * avanca a grade para ela (ou foca o botao Ok, se a linha corrente
    * ainda estiver vazia).
    *
    *   If Lastkey() = 13
    *       If Empty(cpros)
    *           ThisForm.Altera.SetFocus
    *       Else
    *           _lnRecno = Recno()
    *           Locate For Empty(Cpros)
    *           If Eof()
    *               Append Blank
    *           EndIf
    *           Locate For Recno() = _lnRecno
    *           Keyboard '{DNARROW}'
    *       EndIf
    *   EndIf
    *====================================================================
    PROCEDURE AvancarLinhaProdutoGridExec()
        LOCAL loc_nRecnoAtual

        IF LASTKEY() != 13
            RETURN
        ENDIF

        IF !USED(THIS.this_cCursorGrade)
            RETURN
        ENDIF

        SELECT (THIS.this_cCursorGrade)

        IF EMPTY(cpros)
            THIS.cmd_4c_Altera.SetFocus()
        ELSE
            loc_nRecnoAtual = RECNO()

            LOCATE FOR EMPTY(cpros)
            IF EOF()
                APPEND BLANK
            ENDIF

            LOCATE FOR RECNO() = loc_nRecnoAtual
            KEYBOARD "{DNARROW}"
        ENDIF
    ENDPROC

    *====================================================================
    * ConfigurarBotoesPrincipais - Shape decorativo (sigprtrf.Shape1, por
    * baixo dos dois botoes) + botoes Ok (altera) e Cancelar (sair) do
    * dialogo. Click (validacao + animacao de confirmacao / encerramento)
    * fica para a fase de comportamento (Fase 7/8).
    *====================================================================
    PROTECTED PROCEDURE ConfigurarBotoesPrincipais()
        THIS.AddObject("shp_4c_Shape1", "Shape")
        WITH THIS.shp_4c_Shape1
            .Top           = 396
            .Left          = 311
            .Width         = 121
            .Height        = 52
            .SpecialEffect = 0
        ENDWITH

        THIS.AddObject("cmd_4c_Altera", "CommandButton")
        WITH THIS.cmd_4c_Altera
            .Top             = 399
            .Left            = 314
            .Width           = 58
            .Height          = 47
            .FontName        = "Arial"
            .FontSize        = 7
            .FontBold        = .T.
            .ForeColor       = RGB(0, 128, 0)
            .Caption         = "\<Ok"
            .Cancel          = .F.
            .Picture         = gc_4c_CaminhoIcones + "a_save1.bmp"
            .Themes          = .T.
            .DisabledPicture = gc_4c_CaminhoIcones + "a_save1.bmp"
        ENDWITH

        THIS.AddObject("cmd_4c_Sair", "CommandButton")
        WITH THIS.cmd_4c_Sair
            .Top             = 399
            .Left            = 372
            .Width           = 75
            .Height          = 75
            .FontName        = "Arial"
            .FontSize        = 7
            .FontBold        = .T.
            .ForeColor       = RGB(0, 0, 0)
            .Caption         = "Encerrar"
            .Cancel          = .T.
            .Picture         = gc_4c_CaminhoIcones + "cancelar.bmp"
            .Themes          = .T.
            .DisabledPicture = gc_4c_CaminhoIcones + "cancelar.bmp"
        ENDWITH

        *-- Handlers PUBLIC (regra #3 - BINDEVENT nao alcanca PROTECTED)
        BINDEVENT(THIS.cmd_4c_Altera, "Click", THIS, "BtnOkClick")
        BINDEVENT(THIS.cmd_4c_Sair,   "Click", THIS, "BtnCancelarClick")
    ENDPROC

    *====================================================================
    * ConfigurarContainerMensagem - Container flutuante de "Aguarde"
    * (animacao de confirmacao do botao Ok, legado Cnt_Mensagem).
    * Comeca OCULTO - so aparece durante a contagem de tempo do botao
    * Ok (ver BtnOkClick, Fase 7/8). O CONTAINER fica fora do filtro
    * recursivo de TornarControlesVisiveis (permanece oculto), por isso os
    * filhos dele precisam ser criados aqui JA com .Visible = .T. (o
    * default de AddObject eh .F.) - equivalente ao Visible = .T. que o
    * dump declara em Mensagem1 e em cada Botao.
    *====================================================================
    PROTECTED PROCEDURE ConfigurarContainerMensagem()
        THIS.AddObject("cnt_4c__Mensagem", "Container")
        WITH THIS.cnt_4c__Mensagem
            .Top           = 395
            .Left          = 3
            .Width         = 302
            .Height        = 55
            .SpecialEffect = 0
            .Visible       = .F.
        ENDWITH

        THIS.ConfigurarMensagemAguarde()
        THIS.ConfigurarBarraAnimacao()
    ENDPROC

    *====================================================================
    * ConfigurarMensagemAguarde - Label "Aguarde. Verificando Dados!!!"
    * (sigprtrf.Cnt_Mensagem.Mensagem1 no legado).
    *====================================================================
    PROTECTED PROCEDURE ConfigurarMensagemAguarde()
        WITH THIS.cnt_4c__Mensagem
            .AddObject("lbl_4c_Mensagem1", "Label")
            WITH .lbl_4c_Mensagem1
                .Top       = 2
                .Left      = 16
                .Width     = 277
                .Height    = 25
                .AutoSize  = .F.
                .FontBold  = .T.
                .FontSize  = 14
                .ForeColor = RGB(255, 0, 0)
                .Visible   = .T.
                .Caption   = "Aguarde. Verificando Dados!!!"
            ENDWITH
        ENDWITH
    ENDPROC

    *====================================================================
    * ConfigurarBarraAnimacao - Os 13 blocos coloridos do "termometro" de
    * espera (sigprtrf.Cnt_Mensagem.Botao1 / botao2..botao13 no legado).
    * BtnOkClick (Fase 7/8) alterna BackColor/Visible deles durante a
    * contagem de THIS.this_oBusinessObject.this_nTempoEspera, igual ao
    * "lcMacro = 'ThisForm.Cnt_Mensagem.botao'+Alltrim(Str(lnBot,2))" do
    * Click legado. Decorativos - nunca recebem foco nem clique (legado:
    * PROCEDURE When / Return .f. em todos os 13 -> aqui .TabStop = .F.).
    * Nomes txt_4c_Botao1..txt_4c_Botao13 para o handler de Fase 7/8
    * conseguir alcanca-los por STORE/EVALUATE com o mesmo indice do
    * legado (regra do projeto: nunca usar Controls("nome") nem macro
    * para atribuir propriedade).
    *====================================================================
    PROTECTED PROCEDURE ConfigurarBarraAnimacao()
        LOCAL loc_nI, loc_nLeft, loc_cNome

        FOR loc_nI = 1 TO 13
            loc_cNome = "txt_4c_Botao" + TRANSFORM(loc_nI)
            loc_nLeft = 55 + ((loc_nI - 1) * 16)

            THIS.cnt_4c__Mensagem.AddObject(loc_cNome, "TextBox")

            STORE 34             TO ("THIS.cnt_4c__Mensagem." + loc_cNome + ".Top")
            STORE loc_nLeft      TO ("THIS.cnt_4c__Mensagem." + loc_cNome + ".Left")
            STORE 13             TO ("THIS.cnt_4c__Mensagem." + loc_cNome + ".Width")
            STORE 11             TO ("THIS.cnt_4c__Mensagem." + loc_cNome + ".Height")
            STORE 0              TO ("THIS.cnt_4c__Mensagem." + loc_cNome + ".BorderStyle")
            STORE RGB(255, 0, 0) TO ("THIS.cnt_4c__Mensagem." + loc_cNome + ".BackColor")
            STORE .F.            TO ("THIS.cnt_4c__Mensagem." + loc_cNome + ".TabStop")
            STORE .T.            TO ("THIS.cnt_4c__Mensagem." + loc_cNome + ".Visible")
        ENDFOR
    ENDPROC

    *====================================================================
    * BtnOkClick - Click do botao Ok (legado: sigprtrf.altera.Click).
    * Confere se ao menos um produto foi informado na grade (mesma conta
    * do legado: "Count to x for Not Empty(Cpros) / If x=0"), exibe a
    * animacao de confirmacao e fecha o dialogo com this_cRetorno = "Ok".
    *
    *   Select CrProduto
    *   Count to x for Not Empty(Cpros)
    *   If x=0
    *       MessageBox('Nenhum Produto Informado!!!',0+16,'')
    *       Return .f.
    *   Endif
    *   ... animacao ...
    *   ThisForm.Retorno = 'Ok'
    *   ThisForm.Release
    *
    * PUBLIC: ligado por BINDEVENT em ConfigurarBotoesPrincipais.
    *====================================================================
    PROCEDURE BtnOkClick()
        LOCAL loc_nQtde

        *-- Reentrancia: a animacao chama DOEVENTS, entao um segundo clique
        *-- no Ok chegaria aqui e iniciaria uma contagem ANINHADA
        IF THIS.this_lEmConfirmacao
            RETURN
        ENDIF

        IF !USED(THIS.this_cCursorGrade)
            RETURN
        ENDIF

        *-- Linha corrente para o BO antes de contar: enquanto o foco esta
        *-- na celula, o ultimo codigo digitado ainda nao chegou ao cursor
        THIS.FormParaBO()

        loc_nQtde = THIS.this_oBusinessObject.MontarListaProdutos(THIS.this_cCursorGrade)

        IF loc_nQtde = 0
            MsgAviso("Nenhum Produto Informado!!!", "Aten" + CHR(231) + CHR(227) + "o")
            RETURN
        ENDIF

        THIS.this_lEmConfirmacao = .T.

        *-- Grade e botoes desligados durante a contagem, reproduzindo o
        *-- laco bloqueante do legado (ver HabilitarCampos)
        THIS.HabilitarCampos(.F.)

        THIS.ExibirAnimacaoConfirmacao()

        THIS.HabilitarCampos(.T.)
        THIS.this_lEmConfirmacao = .F.

        THIS.this_cRetorno = "Ok"

        *-- Hide(), e NAO Release(): ver a nota de FecharDialogo()
        THIS.FecharDialogo()
    ENDPROC

    *====================================================================
    * FecharDialogo - Encerra o dialogo devolvendo o controle ao chamador,
    * mas PRESERVANDO o objeto para que ele possa ler o resultado.
    *
    * O legado faz "Thisform.release" e entrega o resultado pelo RETURN do
    * Unload, que so chega a quem abre a tela com "DO FORM ... TO <var>".
    * O sistema novo abre por CREATEOBJECT + Show(), e ai esse retorno eh
    * inalcancavel - o resultado tem de vir de property/metodo do form.
    *
    * Medido no VFP9 (2026-10-20) com o chamador segurando a referencia:
    *
    *   THIS.Release()  -> loForm passa a VARTYPE "X" e qualquer leitura
    *                      estoura "LOC_OFORM is not an object"
    *   THIS.Hide()     -> loForm segue "O", ObterRetorno() e
    *                      ObterListaProdutos() continuam legiveis, e o
    *                      Release do CHAMADOR encerra o objeto
    *
    * Ou seja: com Release() o dialogo nao teria como devolver a relacao de
    * produtos que eh a razao de ele existir. Hide() em form modal tambem
    * devolve o Show(), entao para o usuario a tela fecha igual (PILAR 1
    * preservado); muda so o tempo de vida do objeto, que eh decisao de
    * arquitetura (PILAR 3). Eh o mesmo desenho que o FormBuscaAuxiliar do
    * projeto ja adota - "Usa Hide() em vez de Release() para permitir
    * leitura de propriedades / Caller deve chamar Release() apos ler
    * valores" - e por isso os chamadores do projeto ja esperam liberar o
    * dialogo eles mesmos.
    *====================================================================
    PROCEDURE FecharDialogo()
        THIS.Hide()
    ENDPROC

    *====================================================================
    * ExibirAnimacaoConfirmacao - Reproduz a animacao de "Aguarde" do
    * legado (sigprtrf.altera.Click) durante
    * THIS.this_oBusinessObject.this_nTempoEspera segundos (ClockEcfs),
    * alternando BackColor/Visible dos 13 blocos de
    * cnt_4c__Mensagem.txt_4c_Botao1..13:
    *
    *   ThisForm.Cnt_Mensagem.Visible = .t.
    *   ldDataI = Datetime()
    *   _w = LocalParac.ClockEcfs / 3
    *   _x = 13
    *   DO While Datetime() - ldDataI < LocalParac.ClockEcfs
    *       _Tempo = Datetime() - ldDataI
    *       _x = Iif(_x >= 13, 1, _x + 1)
    *       <terco 1: vermelho (255) / terco 2: amarelo (65535) /
    *        terco 3: verde (4227072)>
    *       <botao1..13 .Visible = (botao <= _x)>
    *   Enddo
    *
    * As cores 65535/4227072/255 do legado sao RGB(255,255,0) [amarelo],
    * RGB(0,128,64) [verde] e RGB(255,0,0) [vermelho] - decompostas pela
    * formula VFP cor = R + G*256 + B*65536. Acesso aos 13 TextBox por
    * INDICE via STORE (regra do projeto: Controls() e indexado por
    * numero, nome de controle so com STORE/EVALUATE - nunca direto).
    *====================================================================
    PROTECTED PROCEDURE ExibirAnimacaoConfirmacao()
        LOCAL loc_dHoraInicio, loc_nTerco, loc_nQtdeVisivel, loc_nTempo, ;
              loc_nBotao, loc_cCaminho, loc_oErro

        IF THIS.this_oBusinessObject.this_nTempoEspera <= 0
            RETURN
        ENDIF

        *-- TRY/CATCH em volta do laco: sem ele, um erro no meio da
        *-- contagem sairia por cima de BtnOkClick (que tambem nao tem
        *-- TRY) e deixaria a tela TRAVADA - o painel de "Aguarde" visivel,
        *-- a grade e os dois botoes desligados por HabilitarCampos(.F.) e
        *-- this_lEmConfirmacao preso em .T., que bloqueia Ok e Cancelar.
        *-- Nao haveria como fechar o dialogo. O CATCH repoe o painel e
        *-- REPORTA (CATCH nunca silencioso - regra #9); quem religa grade
        *-- e botoes eh o BtnOkClick, que retoma o fluxo normal depois
        *-- desta chamada justamente porque o erro nao escapa daqui.
        THIS.cnt_4c__Mensagem.Visible = .T.

        loc_dHoraInicio  = DATETIME()
        loc_nTerco       = THIS.this_oBusinessObject.this_nTempoEspera / 3
        loc_nQtdeVisivel = 13

        TRY
            DO WHILE DATETIME() - loc_dHoraInicio < THIS.this_oBusinessObject.this_nTempoEspera
                loc_nTempo = DATETIME() - loc_dHoraInicio

                IF loc_nQtdeVisivel >= 13
                    loc_nQtdeVisivel = 1
                ELSE
                    loc_nQtdeVisivel = loc_nQtdeVisivel + 1
                ENDIF

                FOR loc_nBotao = 1 TO 13
                    loc_cCaminho = "THIS.cnt_4c__Mensagem.txt_4c_Botao" + TRANSFORM(loc_nBotao)

                    IF loc_nTempo > loc_nTerco
                        IF loc_nTempo < loc_nTerco * 2
                            STORE RGB(255, 255, 0) TO (loc_cCaminho + ".BackColor")
                        ELSE
                            STORE RGB(0, 128, 64) TO (loc_cCaminho + ".BackColor")
                        ENDIF
                    ELSE
                        STORE RGB(255, 0, 0) TO (loc_cCaminho + ".BackColor")
                    ENDIF

                    STORE (loc_nBotao <= loc_nQtdeVisivel) TO (loc_cCaminho + ".Visible")
                ENDFOR

                THIS.cnt_4c__Mensagem.Refresh()
                DOEVENTS
            ENDDO
        CATCH TO loc_oErro
            MsgErro("Erro durante a confirma" + CHR(231) + CHR(227) + "o:" + CHR(13) + ;
                    loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, "Erro")
        ENDTRY

        THIS.cnt_4c__Mensagem.Visible = .F.
    ENDPROC

    *====================================================================
    * BtnCancelarClick - Click do botao Cancelar (legado:
    * sigprtrf.sair.Click):
    *   ThisForm.Retorno = ' '
    *   Thisform.release
    *
    * PUBLIC: ligado por BINDEVENT em ConfigurarBotoesPrincipais.
    *====================================================================
    PROCEDURE BtnCancelarClick()
        *-- Durante a contagem do Ok a tela esta "verificando dados" e os
        *-- dois botoes estao desligados; o Cancelar tem .Cancel = .T.
        *-- (atalho ESC), por isso a guarda tambem aqui
        IF THIS.this_lEmConfirmacao
            RETURN
        ENDIF

        THIS.this_cRetorno = " "

        *-- Hide(), e NAO Release(): ver a nota de FecharDialogo()
        THIS.FecharDialogo()
    ENDPROC

    *====================================================================
    * FormParaBO - Leva a LINHA CORRENTE da grade para o BO.
    *
    * Este dialogo nao tem campos soltos: a unica superficie de dados eh a
    * grade, e as duas colunas dela (Cpros/Dpros) sao exatamente as duas
    * propriedades do BO (this_cCodigoProduto/this_cDescricaoProduto). O
    * equivalente do legado eh o par de ControlSource que o Init declara
    * ('CrProduto.Cpros' / 'CrProduto.Dpros') - com ControlSource o VFP
    * transfere sozinho, e sem ele a transferencia tem de ser escrita.
    *
    * O valor digitado na celula do Codigo so chega ao CURSOR depois do
    * Valid (regra #46), entao a celula ativa tem precedencia sobre o
    * cursor enquanto o usuario ainda esta dentro dela - do contrario o
    * BO receberia o valor ANTERIOR da linha.
    *
    * A lista final de codigos (this_cListaProdutos) continua sendo
    * montada pelo BO varrendo o cursor INTEIRO em MontarListaProdutos(),
    * porque ela nao eh dado de uma linha e sim o resultado do dialogo.
    *====================================================================
    PROCEDURE FormParaBO()
        LOCAL loc_oCelula

        IF VARTYPE(THIS.this_oBusinessObject) != "O"
            RETURN .F.
        ENDIF

        IF !USED(THIS.this_cCursorGrade)
            RETURN .F.
        ENDIF

        SELECT (THIS.this_cCursorGrade)

        IF EOF() OR BOF()
            RETURN .F.
        ENDIF

        THIS.this_oBusinessObject.this_cCodigoProduto    = ALLTRIM(NVL(Cpros, ""))
        THIS.this_oBusinessObject.this_cDescricaoProduto = ALLTRIM(NVL(Dpros, ""))

        *-- Celula ativa do Codigo tem precedencia: dentro do Valid o
        *-- digitado esta nela e ainda nao foi gravado no cursor
        loc_oCelula = THIS.ObterCelulaCodigo()

        IF VARTYPE(loc_oCelula) = "O" AND !EMPTY(ALLTRIM(loc_oCelula.Value))
            THIS.this_oBusinessObject.this_cCodigoProduto = ALLTRIM(loc_oCelula.Value)
        ENDIF

        RETURN .T.
    ENDPROC

    *====================================================================
    * BOParaForm - Leva o produto resolvido pelo BO para a LINHA CORRENTE
    * da grade (cursor + as duas celulas) e repinta.
    *
    * Transcricao do bloco que o legado executa no Valid da celula depois
    * de o lookup achar o produto:
    *
    *   This.Value = Evaluate('CrProds.Cpros')
    *   Replace CrProduto.Dpros With CrProds.dpros in CrProduto
    *   This.Parent.Parent.Column2.Text1.Value = Evaluate('CrProds.Dpros')
    *
    * Aqui a origem eh o BO (ja carregado pelo picker ou por
    * ValidarProduto), e nao o cursor CrProds do fwBuscaExt - por isso as
    * tres atribuicoes moram neste metodo unico, chamado por TODO caminho
    * que resolve um produto.
    *====================================================================
    PROCEDURE BOParaForm()
        LOCAL loc_oGrade, loc_oCelula

        IF VARTYPE(THIS.this_oBusinessObject) != "O"
            RETURN .F.
        ENDIF

        IF !USED(THIS.this_cCursorGrade)
            RETURN .F.
        ENDIF

        SELECT (THIS.this_cCursorGrade)

        IF EOF() OR BOF()
            RETURN .F.
        ENDIF

        REPLACE Cpros WITH THIS.this_oBusinessObject.this_cCodigoProduto, ;
                Dpros WITH THIS.this_oBusinessObject.this_cDescricaoProduto ;
                IN (THIS.this_cCursorGrade)

        loc_oGrade = THIS.cnt_4c__Referencia.grd_4c_Dados

        *-- "This.Value = ..." do legado: o codigo escolhido tem de voltar
        *-- para a CELULA tambem, senao o texto digitado sobrescreve o
        *-- cursor quando o foco sair dela (regra #46)
        loc_oCelula = THIS.ObterCelulaCodigo()

        IF VARTYPE(loc_oCelula) = "O"
            loc_oCelula.Value = THIS.this_oBusinessObject.this_cCodigoProduto
        ENDIF

        *-- "This.Parent.Parent.Column2.Text1.Value = ..." do legado
        loc_oGrade.Column2.Text1.Value = THIS.this_oBusinessObject.this_cDescricaoProduto

        loc_oGrade.Refresh()

        RETURN .T.
    ENDPROC

    *====================================================================
    * ObterCelulaCodigo - Devolve o TextBox da coluna do Codigo
    * (Column1.txt_4c_CelCodigo) ou .NULL. quando ele ainda nao existe.
    *
    * Metodo proprio porque AplicarFormatoColunas recria esse controle
    * sempre que o ColumnCount eh reposto: alcancar
    * .Column1.txt_4c_CelCodigo sem o PEMSTATUS estoura "Unknown member"
    * se a coluna ainda estiver com o Text1 default, e sao TRES os
    * chamadores (FormParaBO, BOParaForm e GradeProdutosDblClick).
    *====================================================================
    PROCEDURE ObterCelulaCodigo()
        LOCAL loc_oGrade

        loc_oGrade = THIS.cnt_4c__Referencia.grd_4c_Dados

        IF VARTYPE(loc_oGrade) != "O"
            RETURN .NULL.
        ENDIF

        IF loc_oGrade.ColumnCount < 1
            RETURN .NULL.
        ENDIF

        IF !PEMSTATUS(loc_oGrade.Column1, "txt_4c_CelCodigo", 5)
            RETURN .NULL.
        ENDIF

        RETURN loc_oGrade.Column1.txt_4c_CelCodigo
    ENDPROC

    *====================================================================
    * HabilitarCampos - Liga/desliga a grade e os dois botoes do dialogo.
    *
    * Existe para fechar a porta que a migracao abriu: o laco de espera do
    * legado (altera.Click) eh um "DO While ... Enddo" SEM DOEVENTS e, em
    * VFP9, isso bloqueia o processamento de eventos - durante a contagem o
    * usuario nao consegue clicar nem digitar. ExibirAnimacaoConfirmacao
    * CHAMA DOEVENTS de proposito, para o container de "Aguarde" repintar
    * os 13 blocos, e com isso a tela volta a aceitar entrada enquanto
    * "verifica os dados". Desligar a grade e os botoes durante a animacao
    * reproduz o efeito do laco bloqueante do legado.
    *
    * PUBLIC: chamado por THIS. em BtnOkClick e alcancavel pelo harness de
    * teste automatizado, que chama metodos do form de fora da classe
    * (regra #3).
    *====================================================================
    PROCEDURE HabilitarCampos(par_lHabilitar)
        LOCAL loc_lHabilitar

        loc_lHabilitar = IIF(VARTYPE(par_lHabilitar) = "L", par_lHabilitar, .T.)

        THIS.cnt_4c__Referencia.grd_4c_Dados.Enabled = loc_lHabilitar

        *-- Os dois botoes sao icone-only quando desabilitados? Nao: ambos
        *-- tem Caption ("Ok"/"Cancelar") e .DisabledPicture igual a
        *-- .Picture, entao o icone continua desenhado com Enabled = .F.
        *-- (regra do CommandButton standalone com Picture)
        THIS.cmd_4c_Altera.Enabled = loc_lHabilitar
        THIS.cmd_4c_Sair.Enabled   = loc_lHabilitar

        RETURN .T.
    ENDPROC

    *====================================================================
    * LimparCampos - Devolve a grade ao estado inicial do dialogo: uma
    * unica linha em branco, pronta para digitacao.
    *
    * Equivale ao par que o legado executa ao abrir a tela - o
    * "Create Cursor CrProduto (Cpros c(14), dpros c(40))" do Load mais o
    * "Select CrProduto / Append Blank" do Init - e eh o override do hook
    * de mesmo nome do FormBase, que o chama em Novo()/Excluir()/
    * Cancelar(). Zera tambem o snapshot do codigo anterior, senao o
    * Valid da primeira celula compararia o valor novo com o da sessao
    * descartada e nao abriria o lookup.
    *
    * ZAP (e nao USE IN + CREATE CURSOR) de proposito: ele preserva a
    * estrutura do cursor e, com ela, o RecordSource do Grid e os
    * ControlSource das duas colunas. Derrubar o alias deixaria a grade
    * permanentemente vazia com o cursor cheio.
    *
    * SET SAFETY eh escopado por DATA SESSION, e este form eh
    * DataSession = 2: o "SET SAFETY OFF" do main.prg NAO alcanca a sessao
    * privada, onde SAFETY vale ON. Sem o par salvar/restaurar abaixo o ZAP
    * abre o dialogo modal "Zap ... Are you sure?" e CONGELA a tela,
    * esperando um clique que ninguem ve.
    *====================================================================
    PROCEDURE LimparCampos()
        LOCAL loc_cSafety

        IF !USED(THIS.this_cCursorGrade)
            THIS.CriarCursorProdutos()
        ELSE
            loc_cSafety = SET("SAFETY")
            SET SAFETY OFF

            SELECT (THIS.this_cCursorGrade)
            ZAP
            APPEND BLANK

            IF loc_cSafety = "ON"
                SET SAFETY ON
            ENDIF
        ENDIF

        THIS.this_cCodigoAnterior = ""

        IF VARTYPE(THIS.this_oBusinessObject) = "O"
            THIS.this_oBusinessObject.this_cCodigoProduto    = ""
            THIS.this_oBusinessObject.this_cDescricaoProduto = ""
            THIS.this_oBusinessObject.this_cListaProdutos    = ""
        ENDIF

        *-- Metodo UNICO de vinculo/repintura: popular ou recriar o cursor
        *-- NAO repinta a grade por si so (regra #21)
        THIS.CarregarLista()

        RETURN .T.
    ENDPROC

    *====================================================================
    * TornarControlesVisiveis - Torna visiveis os controles do container
    * informado, recursivamente, EXCETO cnt_4c__Mensagem (container
    * flutuante - permanece oculto at? o botao Ok iniciar a animacao).
    *====================================================================
    PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
        LOCAL loc_nI, loc_oControl

        IF VARTYPE(par_oContainer) != "O"
            RETURN
        ENDIF

        FOR loc_nI = 1 TO par_oContainer.ControlCount
            loc_oControl = par_oContainer.Controls(loc_nI)

            *-- FILTRO: container flutuante permanece oculto (toggled
            *-- pelo botao Ok durante a animacao de confirmacao)
            IF UPPER(loc_oControl.Name) = "CNT_4C__MENSAGEM"
                LOOP
            ENDIF

            IF PEMSTATUS(loc_oControl, "Visible", 5)
                loc_oControl.Visible = .T.
            ENDIF

            IF PEMSTATUS(loc_oControl, "ControlCount", 5) AND loc_oControl.ControlCount > 0
                THIS.TornarControlesVisiveis(loc_oControl)
            ENDIF
        ENDFOR
    ENDPROC

    *====================================================================
    * Destroy - Encerramento do dialogo. Migrado de SIGPRTRF.Release
    * ("ThisForm.poDataMgr.Release / dodefault()"), que eh onde o legado
    * solta o gerenciador de dados da tela.
    *
    * A lista de codigos eh CACHEADA no form ANTES de o BO ser liberado: o
    * evento Unload dispara DEPOIS do Destroy e ja nao alcancaria
    * this_oBusinessObject.this_cListaProdutos.
    *====================================================================
    PROCEDURE Destroy()
        IF VARTYPE(THIS.this_oBusinessObject) = "O"
            THIS.this_cListaProdutosSelecionados = ;
                THIS.this_oBusinessObject.this_cListaProdutos

            *-- Equivalente ao "ThisForm.poDataMgr.Release" do legado
            THIS.this_oBusinessObject = .NULL.
        ENDIF

        IF !EMPTY(THIS.this_cCursorGrade) AND USED(THIS.this_cCursorGrade)
            USE IN (THIS.this_cCursorGrade)
        ENDIF

        IF USED("cursor_4c_BuscaProdutoTrf")
            USE IN cursor_4c_BuscaProdutoTrf
        ENDIF

        DODEFAULT()
    ENDPROC

    *====================================================================
    * Unload - Migrado de SIGPRTRF.Unload ("Return ThisForm.Retorno").
    *
    * Em VFP9 o valor devolvido pelo Unload eh o que chega ao chamador que
    * abre a tela com "DO FORM <form> TO <var>" - eh assim que o legado
    * entrega "Ok" (confirmado) ou " " (cancelado).
    *
    * O chamador que usa o padrao do sistema novo (CREATEOBJECT + Show())
    * nao alcanca esse retorno; para ele existem ObterRetorno() e
    * ObterListaProdutos(), que leem properties do form - e properties
    * sobrevivem ao fechamento, porque o chamador ainda tem a referencia.
    * Os dois modos de abertura ficam atendidos.
    *====================================================================
    PROCEDURE Unload()
        RETURN THIS.this_cRetorno
    ENDPROC

    *====================================================================
    * ObterRetorno - "Ok" quando o usuario confirmou a relacao, " " quando
    * cancelou (mesmos dois valores do ThisForm.Retorno legado). Espelho
    * do Unload para o chamador que abre a tela por CREATEOBJECT + Show().
    *====================================================================
    PROCEDURE ObterRetorno()
        RETURN THIS.this_cRetorno
    ENDPROC

    *====================================================================
    * ObterListaProdutos - Codigos dos produtos informados na grade,
    * separados por virgula, na ordem em que o usuario os digitou. Eh o
    * RESULTADO util do dialogo: o legado devolvia so "Ok"/" " e deixava o
    * cursor CrProduto aberto para o form chamador varrer, o que nao se
    * aplica aqui porque o cursor vive na datasession PRIVADA desta tela
    * (DataSession = 2) e eh fechado no Destroy.
    *
    * Le o valor cacheado no Destroy quando o form ja fechou e, com a tela
    * ainda aberta, consulta o BO direto.
    *====================================================================
    PROCEDURE ObterListaProdutos()
        IF VARTYPE(THIS.this_oBusinessObject) = "O"
            RETURN THIS.this_oBusinessObject.this_cListaProdutos
        ENDIF

        RETURN THIS.this_cListaProdutosSelecionados
    ENDPROC

    *====================================================================
    * CarregarLista - Vincula a grade de produtos ao cursor e a repinta.
    *
    * Transcricao do bloco do Init legado:
    *     With Thisform.Cnt_Referencia.Grade
    *         .RecordSource          = 'CrProduto'
    *         .Column1.ControlSource = 'CrProduto.Cpros'
    *         .Column2.ControlSource = 'CrProduto.Dpros'
    *         .Refresh
    *     EndWith
    *     Select CrProduto
    *     Append Blank
    *
    * Metodo UNICO de vinculo/repintura: tem de ser chamado em todo
    * caminho que recria ou repopula cursor_4c_Produtos, porque popular o
    * cursor NAO repinta a grade por si so - ela fica visualmente vazia
    * com o cursor cheio. PUBLIC de proposito: o harness de teste
    * automatizado chama THIS.oForm.CarregarLista() de fora da classe.
    *====================================================================
    PROCEDURE CarregarLista()
        LOCAL loc_oGrade, loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        TRY
            *-- O cursor tem de existir ANTES do ControlSource: atribuir
            *-- ControlSource de alias inexistente derruba o Init.
            IF !USED(THIS.this_cCursorGrade)
                THIS.CriarCursorProdutos()
            ENDIF

            *-- Linha em branco para digitar, como o "Append Blank" do Init
            *-- legado: sem ela a grade abre sem nenhuma celula editavel.
            IF RECCOUNT(THIS.this_cCursorGrade) = 0
                SELECT (THIS.this_cCursorGrade)
                APPEND BLANK
            ENDIF

            loc_oGrade = THIS.cnt_4c__Referencia.grd_4c_Dados

            WITH loc_oGrade
                *-- O ColumnCount cai a 0 quando o alias da grade eh
                *-- derrubado (medido no VFP9): sem repor, .ColumnN nao
                *-- existe e o vinculo logo abaixo estoura.
                IF .ColumnCount != 2
                    .ColumnCount = 2
                ENDIF

                .RecordSource          = THIS.this_cCursorGrade
                .Column1.ControlSource = THIS.this_cCursorGrade + ".Cpros"
                .Column2.ControlSource = THIS.this_cCursorGrade + ".Dpros"
            ENDWITH

            *-- Formato das colunas DEPOIS do vinculo: se o ColumnCount
            *-- teve de ser reposto, os objetos Column nasceram de novo
            *-- com o default do VFP9 e perderam Format, InputMask,
            *-- fontes, Movable/Resizable, largura, Caption do cabecalho e
            *-- o ReadOnly da coluna da Descricao
            THIS.AplicarFormatoColunas()

            *-- "Go Top" + Refresh do legado: sem isso a grade fica
            *-- visualmente vazia mesmo com o cursor populado
            SELECT (THIS.this_cCursorGrade)
            GO TOP
            loc_oGrade.Refresh()

            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro("Erro ao carregar a grade de produtos:" + CHR(13) + ;
                    loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * Activate - Posiciona o cursor de digitacao na primeira celula da
    * grade na PRIMEIRA ativacao do dialogo, equivalente ao
    * "ThisForm.Cnt_Referencia.Grade.column1.SetFocus" do Init legado.
    * O SetFocus mora aqui, e nao no Init, porque durante o Init o form
    * ainda nao esta visivel e dar foco a controle invisivel dispara erro.
    *====================================================================
    PROCEDURE Activate()
        IF !THIS.this_lFocoAplicado
            THIS.this_lFocoAplicado = .T.
            THIS.FocarPrimeiraCelula()
        ENDIF

        DODEFAULT()
    ENDPROC

    *====================================================================
    * FocarPrimeiraCelula - Da foco a coluna do Codigo do Produto, que eh
    * por onde o usuario comeca a preencher a relacao de produtos.
    *====================================================================
    PROCEDURE FocarPrimeiraCelula()
        LOCAL loc_oGrade, loc_oErro

        loc_oGrade = THIS.cnt_4c__Referencia.grd_4c_Dados

        IF VARTYPE(loc_oGrade) != "O" OR !loc_oGrade.Visible OR !loc_oGrade.Enabled
            RETURN
        ENDIF

        TRY
            loc_oGrade.SetFocus()
            loc_oGrade.Column1.SetFocus()
        CATCH TO loc_oErro
            MsgAviso("N" + CHR(227) + "o foi poss" + CHR(237) + "vel posicionar o cursor na " + ;
                     "grade de produtos:" + CHR(13) + loc_oErro.Message, ;
                     "Aten" + CHR(231) + CHR(227) + "o")
        ENDTRY
    ENDPROC

ENDDEFINE

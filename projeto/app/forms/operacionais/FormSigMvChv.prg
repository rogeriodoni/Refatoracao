*==============================================================================
* FormSigMvChv.prg - Chaves de Nota (dialogo auxiliar)
* Origem: SIGMVCHV.SCX (task562)
* Herda de: FormBase
* Tipo: OPERACIONAL (form modal filho - gerencia crChaves de um documento pai)
*       Aberto pelo form pai com: CREATEOBJECT("FormSigMvChv", cEscolha, cEmpDopNums)
*       Legado: Lparameters pCnx, pcEscolha, pcEDN - pCnx descartado (gnConnHandle
*       global na nova arquitetura). DataSession=1 (sessao compartilhada, igual
*       ao legado - sem o fix de DataSession=2 da regra #9.4).
*
* NAO segue o padrao Page1=Lista/Page2=Dados do CRUD: o SCX legado eh um form
* PLANO sem PageFrame (cntSombra + cntBotoes + grid direto na raiz do form,
* ver layout.json/analise.json formType=OPERACIONAL). ConfigurarPageFrame()
* aqui e apenas o orquestrador de montagem visual (mesmo papel arquitetural
* usado em FormFop.prg), nao cria PageFrame de verdade.
*==============================================================================

DEFINE CLASS FormSigMvChv AS FormBase

    Width        = 500
    Height       = 350
    AutoCenter   = .T.
    TitleBar     = 0
    ShowWindow   = 1
    WindowType   = 1
    ControlBox   = .F.
    Closable     = .F.
    MaxButton    = .F.
    MinButton    = .F.
    Movable      = .F.
    BorderStyle  = 2
    ClipControls = .F.
    ShowTips     = .T.
    KeyPreview   = .T.
    Themes       = .F.
    DataSession  = 1
    Caption      = "Chaves"
    FontName     = "Verdana"
    FontSize     = 8
    AlwaysOnTop  = .T.

    *-- Parametros recebidos do form pai (legado: pcEscolha, pcEDN)
    this_cPcEscolha   = ""   && "INSERIR", "ALTERAR" ou "PROCURAR"
    this_cEmpDopNums  = ""   && Empresa + numero do documento pai (filtro de crChaves)
    this_lModoEdicao  = .F.  && INLIST(pcEscolha, "INSERIR", "ALTERAR")

    *==========================================================================
    * Init - Recebe parametros do form pai e prepara estado inicial
    * par_cEscolha    : modo de operacao ("INSERIR", "ALTERAR", "PROCURAR")
    * par_cEmpDopNums : codigo do documento pai (SigMvCab.EmpDopNums ou equiv.)
    *==========================================================================
    PROCEDURE Init()
        LPARAMETERS par_cEscolha, par_cEmpDopNums

        LOCAL loc_oErro
        TRY
            THIS.this_cPcEscolha  = IIF(TYPE("par_cEscolha") = "C", UPPER(ALLTRIM(par_cEscolha)), "PROCURAR")
            THIS.this_cEmpDopNums = IIF(TYPE("par_cEmpDopNums") = "C", ALLTRIM(par_cEmpDopNums), "")
            THIS.this_lModoEdicao = INLIST(THIS.this_cPcEscolha, "INSERIR", "ALTERAR")
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, "Erro em FormSigMvChv.Init")
        ENDTRY

        RETURN DODEFAULT()
    ENDPROC

    *==========================================================================
    * InicializarForm - Cria estrutura visual base, instancia BO
    *==========================================================================
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        TRY
            THIS.Picture = gc_4c_CaminhoIcones + "new_background.jpg"
            SET DATE TO BRITISH
            SET CENTURY ON

            THIS.this_oBusinessObject = CREATEOBJECT("SigMvChvBO")
            IF VARTYPE(THIS.this_oBusinessObject) = "O"

                THIS.ConfigurarPageFrame()

                *-- Propaga o Caption do form para os labels do cabecalho (form
                *-- OPERACIONAL flat: cnt_4c_Cabecalho fica direto em THIS, sem
                *-- pgf_4c_Paginas/Page1 - a estrutura CRUD nao se aplica aqui)
                THIS.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
                THIS.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption

                *-- Sem conexao em modo de teste de UI (ValidarUIFidelity)
                IF TYPE("gb_4c_ValidandoUI") != "L" OR !gb_4c_ValidandoUI
                    THIS.CarregarLista()
                ENDIF

                THIS.TornarControlesVisiveis(THIS)
                THIS.Visible = .T.
                loc_lSucesso = .T.
            ELSE
                MsgErro("Falha ao criar SigMvChvBO.", "Erro em InicializarForm")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, "Erro em InicializarForm")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * ConfigurarPageFrame - Orquestrador de montagem visual (papel arquitetural,
    * NAO cria PageFrame de verdade - form plano igual ao legado). Cabecalho +
    * grade de chaves + CommandGroup Confirmar/Cancelar + botoes standalone
    * Incluir/Excluir, direto sobre o form.
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPageFrame()
        THIS.ConfigurarCabecalho()
        THIS.ConfigurarPaginaLista()
    ENDPROC

    *==========================================================================
    * ConfigurarCabecalho - Cria cnt_4c_Cabecalho com labels de titulo
    * Original: cntSombra Top=0, Left=0, Height=80, BackColor=100,100,100
    * (legado declara Width=800 - default de classe do framework.vcx maior que
    * o proprio form de 500px; usar THIS.Width, regra #11/#88)
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarCabecalho()
        LOCAL loc_oErro
        TRY
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
            ENDWITH

            THIS.cnt_4c_Cabecalho.AddObject("lbl_4c_Sombra", "Label")
            WITH THIS.cnt_4c_Cabecalho.lbl_4c_Sombra
                .FontBold      = .T.
                .FontName      = "Tahoma"
                .FontSize      = 18
                .FontUnderline = .F.
                .WordWrap      = .T.
                .Alignment     = 0
                .BackStyle     = 0
                .AutoSize      = .F.
                .Caption       = THIS.Caption
                .Height        = 40
                .Left          = 10
                .Top           = 18
                .Width         = THIS.Width - 40
                .ForeColor     = RGB(0, 0, 0)
                .Visible       = .T.
            ENDWITH

            THIS.cnt_4c_Cabecalho.AddObject("lbl_4c_Titulo", "Label")
            WITH THIS.cnt_4c_Cabecalho.lbl_4c_Titulo
                .FontBold      = .T.
                .FontName      = "Tahoma"
                .FontSize      = 18
                .WordWrap      = .T.
                .Alignment     = 0
                .BackStyle     = 0
                .AutoSize      = .F.
                .Caption       = THIS.Caption
                .Height        = 46
                .Left          = 10
                .Top           = 17
                .Width         = THIS.Width - 40
                .ForeColor     = RGB(255, 255, 255)
                .ToolTipText   = "T" + CHR(237) + "tulo do Relat" + CHR(243) + "rio"
                .Visible       = .T.
            ENDWITH
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, "Erro em ConfigurarCabecalho")
        ENDTRY
    ENDPROC

    *==========================================================================
    * ConfigurarPaginaLista - Cria a grade de chaves (grade do legado), o
    * CommandGroup Confirmar/Cancelar (cntBotoes) e os botoes standalone
    * Incluir/Excluir (inserir/excluir), diretamente sobre o form.
    * Original: cntBotoes Top=-2 Left=344 160x85 (Buttons: 1=Cancelar,
    * 2=Confirmar) | inserir Top=171 Left=401 45x45 | excluir Top=216
    * Left=401 45x45 | grade Top=86 Left=56 342x259 ColumnCount=1
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPaginaLista()
        LOCAL loc_oCmg, loc_oGrd, loc_oErro

        TRY
            *-- Cursor placeholder da grade - mesma estrutura (e mesma ordem
            *-- de campos) que SigMvChvBO.Buscar/CarregarDoCursor usam.
            *-- Precisa existir antes do RecordSource do grid, logo abaixo.
            SET NULL ON
            IF USED("cursor_4c_Dados")
                USE IN cursor_4c_Dados
            ENDIF
            CREATE CURSOR cursor_4c_Dados ;
                (ChaveNota C(44) NULL, EmpDopNums C(29) NULL, pkChaves C(20) NULL)
            SET NULL OFF

            *-- CommandGroup Confirmar/Cancelar (cntBotoes do legado)
            *-- Buttons(1)=Cancelar (Left=80, equivale a Command1/btnSair),
            *-- Buttons(2)=Confirmar (Left=5, equivale a Command2/btnConfirmar)
            THIS.AddObject("cmg_4c_Botoes", "CommandGroup")
            loc_oCmg = THIS.cmg_4c_Botoes
            WITH loc_oCmg
                .Top           = -2
                .Left          = 344
                .Width         = 160
                .Height        = 85
                .ButtonCount   = 2
                .AutoSize      = .T.
                .BackStyle     = 0
                .BorderStyle   = 0
                .SpecialEffect = 1
                .BorderColor   = RGB(136, 189, 188)
                .Themes        = .F.
                .Value         = 0

                WITH .Buttons(1)
                    .Top           = 5
                    .Left          = 80
                    .Width         = 75
                    .Height        = 75
                    .FontName      = "Comic Sans MS"
                    .FontSize      = 8
                    .FontBold      = .T.
                    .FontItalic    = .T.
                    .WordWrap      = .T.
                    .Picture       = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
                    *-- "\<" = tecla de acesso Alt+C do legado (Command1.Caption
                    *-- = "\<Cancelar"). PILAR 1: atalhos de teclado identicos.
                    .Caption       = "\<Cancelar"
                    .Cancel        = .T.
                    .MousePointer  = 15
                    .ToolTipText   = "[Esc] Encerrar"
                    .SpecialEffect = 0
                    .ForeColor     = RGB(90, 90, 90)
                    .BackColor     = RGB(255, 255, 255)
                    .Themes        = .F.
                ENDWITH

                WITH .Buttons(2)
                    .Top          = 5
                    .Left         = 5
                    .Width        = 75
                    .Height       = 75
                    .FontName     = "Comic Sans MS"
                    .FontSize     = 8
                    .FontBold     = .T.
                    .FontItalic   = .T.
                    .WordWrap     = .T.
                    .Picture      = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
                    *-- "\<" = tecla de acesso Alt+C do legado (Command2.Caption
                    *-- = "\<Confirmar"). PILAR 1: atalhos de teclado identicos.
                    .Caption      = "\<Confirmar"
                    .MousePointer = 15
                    .ToolTipText  = "Confirmar a Sele" + CHR(231) + CHR(227) + "o"
                    .ForeColor    = RGB(90, 90, 90)
                    .BackColor    = RGB(255, 255, 255)
                    .Themes       = .F.
                ENDWITH
            ENDWITH
            BINDEVENT(loc_oCmg.Buttons(1), "Click", THIS, "BtnCancelarClick")
            BINDEVENT(loc_oCmg.Buttons(2), "Click", THIS, "BtnConfirmarClick")

            *-- Grade de chaves (grade do legado) - cursor_4c_Dados
            THIS.AddObject("grd_4c_Dados", "Grid")
            loc_oGrd = THIS.grd_4c_Dados
            WITH loc_oGrd
                .Top           = 86
                .Left          = 56
                .Width         = 342
                .Height        = 259
                .ColumnCount   = 1
                .FontName      = "Tahoma"
                .FontSize      = 8
                .RowHeight     = 16
                .ScrollBars    = 2
                .ReadOnly      = .F.
                .DeleteMark    = .F.
                .RecordMark    = .F.
                .GridLineColor = RGB(238, 238, 238)
            ENDWITH

            WITH loc_oGrd.Column1
                .FontName  = "Tahoma"
                .FontSize  = 8
                .Width     = 310
                .Movable   = .F.
                .Resizable = .F.
                .ReadOnly  = !THIS.this_lModoEdicao
            ENDWITH
            loc_oGrd.Column1.Header1.Caption   = "Chave"
            loc_oGrd.Column1.Header1.Alignment = 2
            WITH loc_oGrd.Column1.Text1
                .FontName    = "Tahoma"
                .FontSize    = 8
                .Alignment   = 3
                .BorderStyle = 0
                .Margin      = 0
                .MaxLength   = 44
                .ForeColor   = RGB(0, 0, 0)
                .BackColor   = RGB(255, 255, 255)
            ENDWITH

            *-- RecordSource por ultimo (regra "Column.Width vai por ultimo" -
            *-- resetar RecordSource/ControlSource reseta Width/Header)
            loc_oGrd.ColumnCount = 1
            loc_oGrd.RecordSource            = "cursor_4c_Dados"
            loc_oGrd.Column1.ControlSource   = "cursor_4c_Dados.ChaveNota"
            loc_oGrd.Column1.Header1.Caption = "Chave"
            loc_oGrd.Column1.Width           = 310
            loc_oGrd.Column1.ReadOnly        = !THIS.this_lModoEdicao

            IF THIS.this_lModoEdicao
                BINDEVENT(loc_oGrd.Column1.Text1, "KeyPress", THIS, "ValidarChaveGrade")
            ENDIF

            *-- Botoes standalone Incluir/Excluir - habilitados so em
            *-- INSERIR/ALTERAR (equivalente ao When legado
            *-- "Return(INLIST(Thisform.pcEscolha,'INSERIR','ALTERAR'))")
            THIS.AddObject("cmd_4c_Incluir", "CommandButton")
            WITH THIS.cmd_4c_Incluir
                .Top             = 171
                .Left = 5
                .Width           = 45
                .Height          = 45
                .FontBold        = .T.
                .FontName        = "Verdana"
                .FontSize        = 8
                .Picture         = gc_4c_CaminhoIcones + "cadastro_inserir_26.jpg"
                .DisabledPicture = gc_4c_CaminhoIcones + "cadastro_inserir_26.jpg"
                .Caption         = ""
                .ToolTipText     = "Inserir"
                .ForeColor       = RGB(36, 84, 155)
                .BackColor       = RGB(255, 255, 255)
                .Themes          = .T.
                .Enabled         = THIS.this_lModoEdicao
            ENDWITH
            BINDEVENT(THIS.cmd_4c_Incluir, "Click", THIS, "BtnIncluirClick")

            THIS.AddObject("cmd_4c_Excluir", "CommandButton")
            WITH THIS.cmd_4c_Excluir
                .Top             = 216
                .Left = 230
                .Width           = 45
                .Height          = 45
                .FontBold        = .T.
                .FontName        = "Verdana"
                .FontSize        = 8
                .Picture         = gc_4c_CaminhoIcones + "cadastro_excluir_26.jpg"
                .DisabledPicture = gc_4c_CaminhoIcones + "cadastro_excluir_26.jpg"
                .Caption         = ""
                .ToolTipText     = "Excluir"
                .ForeColor       = RGB(36, 84, 155)
                .BackColor       = RGB(255, 255, 255)
                .Themes          = .T.
                .Enabled         = THIS.this_lModoEdicao
            ENDWITH
            BINDEVENT(THIS.cmd_4c_Excluir, "Click", THIS, "BtnExcluirClick")
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, "Erro em ConfigurarPaginaLista")
        ENDTRY
    ENDPROC

    *==========================================================================
    * CarregarLista - (Re)carrega as chaves do documento no cursor_4c_Dados
    * via BO e rebinda a grade (o BO fecha/recria o cursor a cada chamada,
    * entao RecordSource/ControlSource/Header/Width precisam ser reaplicados).
    *==========================================================================
    PROCEDURE CarregarLista()
        LOCAL loc_lOk, loc_oErro
        loc_lOk = .F.

        TRY
            loc_lOk = THIS.this_oBusinessObject.Buscar(THIS.this_cEmpDopNums)

            IF loc_lOk AND USED("cursor_4c_Dados") AND PEMSTATUS(THIS, "grd_4c_Dados", 5)
                THIS.grd_4c_Dados.RecordSource           = "cursor_4c_Dados"
                THIS.grd_4c_Dados.Column1.ControlSource  = "cursor_4c_Dados.ChaveNota"
                THIS.grd_4c_Dados.Column1.Header1.Caption = "Chave"
                THIS.grd_4c_Dados.Column1.Width          = 310
                THIS.grd_4c_Dados.Column1.ReadOnly       = !THIS.this_lModoEdicao

                SELECT cursor_4c_Dados
                GO TOP
                THIS.grd_4c_Dados.Refresh()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, "Erro em CarregarLista")
        ENDTRY

        RETURN loc_lOk
    ENDPROC

    *==========================================================================
    * ValidarChaveGrade - KeyPress (ENTER/TAB) na coluna Chave (Column1) da
    * grade. Verifica duplicidade no cursor local (equivale ao "Select
    * ChaveNota, Count(*) ... Group By" do Valid legado, rodado sobre o
    * mesmo cursor crChaves que esta sendo editado) e persiste a linha
    * imediatamente via BO (arquitetura em camadas - PILAR 3, a tabela real
    * SigMvChv existe e o BO ja implementa Inserir/Atualizar via Salvar()).
    *==========================================================================
    PROCEDURE ValidarChaveGrade(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_cVal, loc_cPkAtual, loc_lNovo, loc_oErro, loc_lProsseguir

        *-- Teclas que ENCERRAM a edicao da celula. O Valid do legado dispara
        *-- ao SAIR do campo por qualquer meio; num Grid a saida mais comum
        *-- nem eh ENTER/TAB, sao as SETAS (que trocam de linha). Sem 5/24 o
        *-- usuario digita a chave, aperta seta e a linha nunca eh gravada -
        *-- perda silenciosa. Codigos VFP9 de KeyPress: ENTER=13, TAB=9,
        *-- SETA-ACIMA=5, SETA-ABAIXO=24. (BINDEVENT em "Valid" nao dispara
        *-- de forma confiavel em TextBox e LostFocus recursaria - regra #3.)
        IF !INLIST(par_nKeyCode, 13, 9, 5, 24)
            RETURN
        ENDIF

        IF !USED("cursor_4c_Dados")
            RETURN
        ENDIF

        loc_cVal = ALLTRIM(THIS.grd_4c_Dados.Column1.Text1.Value)

        IF EMPTY(loc_cVal)
            RETURN
        ENDIF

        SELECT cursor_4c_Dados

        *-- Valor inalterado numa linha JA gravada: nada a fazer. Sem este
        *-- guard, cada ENTER/TAB/seta sobre uma linha existente repetiria o
        *-- UPDATE e o BusinessBase gravaria um registro de auditoria a cada
        *-- navegacao (RegistrarAuditoria roda dentro de Atualizar()).
        IF ALLTRIM(NVL(ChaveNota, "")) == loc_cVal ;
                AND !EMPTY(ALLTRIM(NVL(pkChaves, "")))
            RETURN
        ENDIF

        REPLACE ChaveNota WITH loc_cVal

        IF THIS.VerificarChaveDuplicada()
            MsgAviso("Registro j" + CHR(225) + " informado.", "Aviso")
            SELECT cursor_4c_Dados
            REPLACE ChaveNota WITH ""
            THIS.grd_4c_Dados.Refresh()
            RETURN
        ENDIF

        loc_lProsseguir = .T.

        TRY
            loc_cPkAtual = ALLTRIM(NVL(cursor_4c_Dados.pkChaves, ""))
            loc_lNovo    = EMPTY(loc_cPkAtual)

            *-- VerificarChaveDuplicada acima so enxerga o cursor local (igual
            *-- ao Valid legado, que agrupa so sobre crChaves). Como esta
            *-- arquitetura grava cada linha na tabela real SigMvChv na hora
            *-- (PILAR 3 - o legado deixava isso tudo comentado), confirmar
            *-- tambem contra o banco evita duplicar a chave quando outra
            *-- sessao gravou a mesma ChaveNota para o mesmo documento entre a
            *-- carga da lista e este Salvar.
            IF THIS.this_oBusinessObject.ExisteChaveDuplicada(loc_cVal, loc_cPkAtual)
                MsgAviso("Registro j" + CHR(225) + " informado.", "Aviso")
                SELECT cursor_4c_Dados
                REPLACE ChaveNota WITH ""
                THIS.grd_4c_Dados.Refresh()
                loc_lProsseguir = .F.
            ENDIF

            IF loc_lProsseguir
                IF loc_lNovo
                    THIS.this_oBusinessObject.NovoRegistro()
                ELSE
                    THIS.this_oBusinessObject.CarregarDoCursor("cursor_4c_Dados")

                    *-- EditarRegistro() recusa (retorna .F.) enquanto
                    *-- this_lNovoRegistro estiver ligado. Salvar() so desliga
                    *-- essa flag quando a gravacao DA CERTO, entao uma inclusao
                    *-- que falhou deixa o BO marcado como "novo": a linha
                    *-- seguinte, que JA EXISTE, seria roteada para Inserir() e
                    *-- duplicaria o registro em vez de atualiza-lo - sem erro
                    *-- na tela. Desligar a flag antes de reabrir a edicao.
                    IF !THIS.this_oBusinessObject.EditarRegistro()
                        THIS.this_oBusinessObject.this_lNovoRegistro = .F.
                        THIS.this_oBusinessObject.EditarRegistro()
                    ENDIF
                ENDIF

                IF THIS.FormParaBO(loc_cVal)
                    IF THIS.this_oBusinessObject.Salvar()
                        THIS.BOParaForm()
                    ENDIF
                ENDIF

                THIS.grd_4c_Dados.Refresh()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, "Erro em ValidarChaveGrade")
        ENDTRY
    ENDPROC

    *==========================================================================
    * VerificarChaveDuplicada - Verifica se a ChaveNota da linha corrente do
    * cursor_4c_Dados ja foi informada em outra linha da grade (equivale ao
    * "Select ChaveNota, Count(*) as qt ... Group by ChaveNota" do Valid
    * legado, rodado sobre o cursor local).
    *==========================================================================
    PROCEDURE VerificarChaveDuplicada()
        LOCAL loc_nRecAtual, loc_cChave, loc_lDuplicado

        loc_lDuplicado = .F.

        IF !USED("cursor_4c_Dados")
            RETURN loc_lDuplicado
        ENDIF

        SELECT cursor_4c_Dados
        loc_nRecAtual = RECNO()
        loc_cChave    = ALLTRIM(ChaveNota)

        IF !EMPTY(loc_cChave)
            LOCATE FOR ALLTRIM(ChaveNota) == loc_cChave AND RECNO() != loc_nRecAtual
            loc_lDuplicado = FOUND()
        ENDIF

        IF BETWEEN(loc_nRecAtual, 1, RECCOUNT("cursor_4c_Dados"))
            GO loc_nRecAtual IN cursor_4c_Dados
        ENDIF

        RETURN loc_lDuplicado
    ENDPROC

    *==========================================================================
    * FormParaBO - Transfere a superficie de dados do form para as
    * propriedades do BO.
    *
    * Neste form a superficie de dados NAO eh uma pagina de campos: SIGMVCHV eh
    * um dialogo modal de UMA coluna, aberto pelo form do documento pai, e o
    * que se grava eh a LINHA CORRENTE da grade. As tres colunas do cursor
    * crChaves no legado (ChaveNota / EmpDopNums / pkChaves) sao exatamente as
    * tres propriedades declaradas em SigMvChvBO - o mapeamento eh 1-para-1.
    *
    * par_cChaveNota (opcional): valor recem-digitado na celula, que o Grid
    * ainda pode nao ter commitado no cursor. Omitido, usa o valor do cursor.
    *==========================================================================
    PROTECTED PROCEDURE FormParaBO(par_cChaveNota)
        LOCAL loc_lOk, loc_cChave

        loc_lOk = .F.

        IF !USED("cursor_4c_Dados") OR VARTYPE(THIS.this_oBusinessObject) != "O"
            RETURN loc_lOk
        ENDIF

        SELECT cursor_4c_Dados

        IF EOF("cursor_4c_Dados") OR BOF("cursor_4c_Dados")
            RETURN loc_lOk
        ENDIF

        loc_cChave = IIF(VARTYPE(par_cChaveNota) = "C", ;
                         ALLTRIM(par_cChaveNota), ;
                         ALLTRIM(NVL(cursor_4c_Dados.ChaveNota, "")))

        WITH THIS.this_oBusinessObject
            .this_cChaveNota  = loc_cChave
            .this_cEmpDopNums = THIS.this_cEmpDopNums

            *-- Linha nova tem pkChaves vazia no cursor; Inserir() gera a chave
            *-- via fUniqueIds(). Linha existente ja veio de CarregarDoCursor,
            *-- entao reatribuir o MESMO valor eh inocuo e mantem o mapeamento
            *-- completo num unico lugar.
            .this_cPkChaves   = ALLTRIM(NVL(cursor_4c_Dados.pkChaves, ""))
        ENDWITH

        loc_lOk = .T.

        RETURN loc_lOk
    ENDPROC

    *==========================================================================
    * BOParaForm - Transfere as propriedades do BO de volta para a linha
    * corrente da grade (inverso de FormParaBO).
    *
    * Chamado depois de Salvar() para trazer a pkChaves que o Inserir() acabou
    * de gerar: sem isso a linha fica sem chave primaria no cursor e o proximo
    * ENTER/TAB sobre ela seria tratado como INCLUSAO, duplicando o registro.
    *==========================================================================
    PROTECTED PROCEDURE BOParaForm()
        LOCAL loc_lOk

        loc_lOk = .F.

        IF !USED("cursor_4c_Dados") OR VARTYPE(THIS.this_oBusinessObject) != "O"
            RETURN loc_lOk
        ENDIF

        SELECT cursor_4c_Dados

        IF EOF("cursor_4c_Dados") OR BOF("cursor_4c_Dados")
            RETURN loc_lOk
        ENDIF

        REPLACE ChaveNota  WITH ALLTRIM(THIS.this_oBusinessObject.this_cChaveNota), ;
                EmpDopNums WITH ALLTRIM(THIS.this_oBusinessObject.this_cEmpDopNums), ;
                pkChaves   WITH ALLTRIM(THIS.this_oBusinessObject.this_cPkChaves)

        loc_lOk = .T.

        RETURN loc_lOk
    ENDPROC

    *==========================================================================
    * BtnIncluirClick - Adiciona uma linha vazia na grade e posiciona o foco
    * na coluna Chave (equivale ao PROCEDURE Click de SIGMVCHV.inserir)
    *==========================================================================
    PROCEDURE BtnIncluirClick()
        LOCAL loc_oErro

        IF !USED("cursor_4c_Dados")
            RETURN
        ENDIF

        *-- Mesmo gate do When de SIGMVCHV.inserir. O botao ja nasce
        *-- desabilitado fora de INSERIR/ALTERAR; a checagem aqui protege as
        *-- chamadas por codigo (BINDEVENT/harness).
        IF !THIS.this_lModoEdicao
            MsgAviso("Modo de consulta - n" + CHR(227) + "o " + CHR(233) + ;
                " poss" + CHR(237) + "vel incluir chaves.", "Chaves")
            RETURN
        ENDIF

        TRY
            THIS.LockScreen = .T.

            SELECT cursor_4c_Dados
            LOCATE FOR EMPTY(ALLTRIM(ChaveNota))
            IF !FOUND()
                APPEND BLANK
                REPLACE EmpDopNums WITH THIS.this_cEmpDopNums
            ENDIF

            THIS.grd_4c_Dados.Refresh()

            *-- Entra em edicao na linha recem-criada. BtnAlterarClick devolve
            *-- o foco a coluna Chave - o mesmo par "Thisform.grade.Refresh +
            *-- thisform.grade.column1.SetFocus" que o Click legado executa.
            THIS.BtnAlterarClick()

            THIS.LockScreen = .F.
        CATCH TO loc_oErro
            THIS.LockScreen = .F.
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, "Erro em BtnIncluirClick")
        ENDTRY
    ENDPROC

    *==========================================================================
    * BtnExcluirClick - Remove a linha corrente da grade (equivale ao
    * PROCEDURE Click de SIGMVCHV.excluir). Se a linha ja foi persistida
    * (pkChaves preenchida), exclui de verdade na tabela SigMvChv via BO
    * antes de retirar a linha do cursor local.
    *==========================================================================
    PROCEDURE BtnExcluirClick()
        LOCAL loc_cPk, loc_oErro, loc_lProsseguir

        IF !USED("cursor_4c_Dados")
            RETURN
        ENDIF

        *-- Mesmo gate do When de SIGMVCHV.excluir (ver BtnIncluirClick)
        IF !THIS.this_lModoEdicao
            MsgAviso("Modo de consulta - n" + CHR(227) + "o " + CHR(233) + ;
                " poss" + CHR(237) + "vel excluir chaves.", "Chaves")
            RETURN
        ENDIF

        SELECT cursor_4c_Dados
        IF RECCOUNT("cursor_4c_Dados") = 0 OR EOF() OR BOF()
            RETURN
        ENDIF

        loc_lProsseguir = .T.

        TRY
            loc_cPk = ALLTRIM(NVL(cursor_4c_Dados.pkChaves, ""))

            IF !EMPTY(loc_cPk)
                IF !MsgConfirmaExclusao()
                    loc_lProsseguir = .F.
                ENDIF

                IF loc_lProsseguir
                    THIS.this_oBusinessObject.CarregarDoCursor("cursor_4c_Dados")
                    THIS.this_oBusinessObject.EditarRegistro()

                    IF !THIS.this_oBusinessObject.Excluir()
                        loc_lProsseguir = .F.
                    ENDIF
                ENDIF
            ENDIF

            IF loc_lProsseguir
                THIS.LockScreen = .T.
                SELECT cursor_4c_Dados
                DELETE
                THIS.grd_4c_Dados.Refresh()
                THIS.LockScreen = .F.
            ENDIF
        CATCH TO loc_oErro
            THIS.LockScreen = .F.
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, "Erro em BtnExcluirClick")
        ENDTRY
    ENDPROC

    *==========================================================================
    * LinhaCorrenteValida - Garante que ha uma linha posicionada no
    * cursor_4c_Dados (equivale ao "If Eof() Or Bof() / Return" que o legado
    * repete no Click de SIGMVCHV.excluir).
    *==========================================================================
    PROCEDURE LinhaCorrenteValida()
        LOCAL loc_lOk

        loc_lOk = .F.

        IF USED("cursor_4c_Dados")
            SELECT cursor_4c_Dados
            loc_lOk = (RECCOUNT("cursor_4c_Dados") > 0 AND !EOF() AND !BOF())
        ENDIF

        RETURN loc_lOk
    ENDPROC

    *==========================================================================
    * BtnAlterarClick - Entra em edicao na linha corrente da grade.
    *
    * SIGMVCHV nao tem botao "Alterar": a alteracao acontece digitando direto
    * na grade, e quem autoriza eh o When da coluna Chave do legado
    * ("Return(INLIST(Thisform.pcEscolha,'INSERIR','ALTERAR'))", igual ao When
    * de inserir/excluir). Este metodo concentra essa regra: valida que ha
    * linha posicionada, aplica o mesmo gate de modo e devolve o foco a unica
    * celula que o legado deixa editavel (Column1 = Chave), reproduzindo o
    * "thisform.grade.column1.SetFocus" do Click de SIGMVCHV.inserir.
    *
    * NAO cria botao proprio na tela (PILAR 1 - o legado nao tem): eh o ponto
    * de entrada programatico de alteracao do form, usado por BtnIncluirClick
    * logo apos criar a linha em branco.
    *==========================================================================
    PROCEDURE BtnAlterarClick()
        LOCAL loc_lOk, loc_oErro

        loc_lOk = .F.

        IF !THIS.LinhaCorrenteValida()
            MsgAviso("Selecione uma linha da grade antes de alterar.", "Chaves")
            RETURN loc_lOk
        ENDIF

        *-- Mesmo gate do When da coluna Chave / dos botoes inserir e excluir.
        *-- A grade ja nasce ReadOnly fora de INSERIR/ALTERAR; a checagem aqui
        *-- protege as chamadas por codigo (BINDEVENT/harness).
        IF !THIS.this_lModoEdicao
            MsgAviso("Modo de consulta - n" + CHR(227) + "o " + CHR(233) + ;
                " poss" + CHR(237) + "vel alterar chaves.", "Chaves")
            RETURN loc_lOk
        ENDIF

        TRY
            THIS.grd_4c_Dados.SetFocus()
            THIS.grd_4c_Dados.Column1.SetFocus()

            loc_lOk = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, "Erro em BtnAlterarClick")
        ENDTRY

        RETURN loc_lOk
    ENDPROC

    *==========================================================================
    * BtnVisualizarClick - Exibe as chaves como estao GRAVADAS para o documento
    * (somente leitura): recarrega cursor_4c_Dados a partir de SigMvChv via BO,
    * filtrando pelo EmpDopNums do documento pai - exatamente o conjunto que o
    * Init do legado ja encontra montado em crChaves ("Select crChaves / Go
    * Top" ligado a grade).
    *
    * Nao grava nada e nao depende do modo do documento (serve em PROCURAR,
    * que eh justamente o modo de consulta do legado). Como recarregar descarta
    * a linha em branco que o usuario tenha acabado de inserir e ainda nao
    * digitado, pede confirmacao quando o documento esta editavel e a grade ja
    * tem linhas - em SIGMVCHV a gravacao acontece linha a linha
    * (ValidarChaveGrade/BtnExcluirClick), entao o que se perde eh so o que
    * ainda nao foi gravado.
    *
    * NAO cria botao proprio na tela (PILAR 1 - o legado nao tem): eh o ponto
    * de entrada programatico de consulta do form.
    *==========================================================================
    PROCEDURE BtnVisualizarClick()
        LOCAL loc_lOk, loc_lProsseguir, loc_oErro

        loc_lOk         = .F.
        loc_lProsseguir = .T.

        IF THIS.this_lModoEdicao AND USED("cursor_4c_Dados") ;
                AND RECCOUNT("cursor_4c_Dados") > 0
            loc_lProsseguir = MsgConfirma("Exibir as chaves como est" + CHR(227) + "o gravadas?" + ;
                CHR(13) + "As linhas ainda n" + CHR(227) + "o gravadas ser" + CHR(227) + ;
                "o descartadas.", "Chaves")
        ENDIF

        IF !loc_lProsseguir
            RETURN loc_lOk
        ENDIF

        TRY
            loc_lOk = THIS.CarregarLista()

            IF loc_lOk
                IF USED("cursor_4c_Dados") AND RECCOUNT("cursor_4c_Dados") = 0
                    MsgInfo("Nenhuma chave gravada para este documento.", "Chaves")
                ENDIF
            ELSE
                MsgAviso("N" + CHR(227) + "o foi poss" + CHR(237) + "vel carregar as chaves " + ;
                    "gravadas deste documento.", "Chaves")
            ENDIF
        CATCH TO loc_oErro
            loc_lOk = .F.
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, "Erro em BtnVisualizarClick")
        ENDTRY

        RETURN loc_lOk
    ENDPROC

    *==========================================================================
    * BtnConfirmarClick - Alvo do BINDEVENT do botao Confirmar
    * (cmg_4c_Botoes.Buttons(2), equivalente a cntBotoes.btnConfirmar do
    * legado: Refresh + GoTop + Refresh + Release - a gravacao ja aconteceu
    * linha a linha em ValidarChaveGrade/BtnExcluirClick, entao Confirmar so
    * fecha o dialogo).
    *==========================================================================
    PROCEDURE BtnConfirmarClick()
        IF USED("cursor_4c_Dados")
            THIS.grd_4c_Dados.Refresh()
            SELECT cursor_4c_Dados
            GO TOP
            THIS.grd_4c_Dados.Refresh()
        ENDIF

        THIS.Release()
    ENDPROC

    *==========================================================================
    * BtnCancelarClick - Encerra sem gravar mais nada (equivale ao PROCEDURE
    * Click de SIGMVCHV.cntBotoes.btnSair: ThisForm.Release)
    *==========================================================================
    PROCEDURE BtnCancelarClick()
        THIS.Release()
    ENDPROC

    *==========================================================================
    * BtnEncerrarClick - Alias de BtnCancelarClick. SIGMVCHV nao tem botao
    * "Encerrar" separado - cmg_4c_Botoes.Buttons(1) (Cancelar) EH o encerrar
    * do legado (cntBotoes.btnSair). Metodo existe por compatibilidade com o
    * contrato comum de forms do pipeline (nome generico de fechamento
    * verificado pelo TesteAutomatico).
    *==========================================================================
    PROCEDURE BtnEncerrarClick()
        THIS.BtnCancelarClick()
    ENDPROC

    *==========================================================================
    * AlternarPagina - No-op deliberado (form OPERACIONAL sem PageFrame nem
    * paginas alternaveis - SIGMVCHV eh popup modal flat). Metodo existe por
    * compatibilidade com o contrato comum de forms do pipeline.
    *==========================================================================
    PROCEDURE AlternarPagina(par_nPagina)
        RETURN
    ENDPROC

    *==========================================================================
    * AjustarBotoesPorModo - No-op deliberado. SIGMVCHV nao alterna modos em
    * runtime: this_cPcEscolha eh fixado uma unica vez no Init (parametro
    * vindo do form pai) e ja habilita/desabilita Incluir/Excluir na criacao
    * (ConfigurarPaginaLista). Metodo existe por compatibilidade com o
    * contrato comum de forms do pipeline.
    *==========================================================================
    PROCEDURE AjustarBotoesPorModo(par_cModo)
        RETURN
    ENDPROC

    *==========================================================================
    * TornarControlesVisiveis - Recursivamente torna controles visiveis
    * (AddObject cria com Visible=.F. por padrao)
    *==========================================================================
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

    *==========================================================================
    * Destroy - Libera cursores abertos
    *==========================================================================
    PROCEDURE Destroy()
        IF USED("cursor_4c_Dados")
            USE IN cursor_4c_Dados
        ENDIF
        IF USED("cursor_4c_DupChv")
            USE IN cursor_4c_DupChv
        ENDIF

        DODEFAULT()
    ENDPROC

ENDDEFINE

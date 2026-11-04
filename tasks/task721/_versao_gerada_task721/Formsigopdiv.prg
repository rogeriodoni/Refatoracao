*==============================================================================
* Formsigopdiv.prg - Separa Industrializacao (SIGOPDIV)
* Origem: SIGOPDIV.SCX (task721)
* Herda de: FormBase
* Tipo: OPERACIONAL - form FLAT (sem PageFrame/Page1-Page2), aberto direto pelo
*       menu (popMovimentos). Suporta tambem o modo "automatico" do legado
*       (chamada com parametros, usada por outras telas para disparar a
*       separacao/reinicio em lote sem interacao do usuario).
*
* Parametros de Init (espelham "Lparameters lcTipo, laNop, lcCnx" do legado):
*   par_cTipo     : "D" = Separa Industrializacao (default), "R" = Reinicia
*   par_aNop      : array com divisoes pre-definidas para processamento em lote
*   par_cConexao  : presenca indica chamada automatica (modo lAutomatico)
*
* Eventos do legado NAO portados (documentados aqui para nao parecer omissao):
*   Load "=fConfigGeral()"       - fConfigGeral e funcao GLOBAL do legado (sig.prg/
*       SIGFUNCS.PRG) que nao veio no acervo. O wrapper NO-OP em
*       projeto\app\utils\fconfiggeral.prg existe so para o p-code dos VCX
*       legado - em codigo NOSSO nunca se chama. A inicializacao que ela fazia
*       (SETs, paths, conexao, empresa) ja ocorre em config.prg/main.prg antes
*       deste form abrir.
*   Release "Thisform.Podatamgr.Release" - poDataMgr era o fSqlConector do
*       legado. O novo sistema usa gnConnHandle direto (conexao compartilhada,
*       sem Release por form).
*
* Fase 4/8: Form - Grid e Botoes (alem da Fase 3: DEFINE CLASS, Init,
*           InicializarForm, ConfigurarPageFrame, Destroy). Nesta fase:
*           - grd_4c_Dados/grd_4c_Historico (Grade/Grade2 do legado), com os
*             cursores cursor_4c_Divisoes/cursor_4c_Historico/cursor_4c_Insumos
*             (Temp_DivOp/Temporario/xNensi do Init() legado).
*           - Botoes reais dos dois grupos (Grupo_Salva/Grupo_Conf): Gerar
*             O.P./Reinicia + Encerrar, e Confirmar + Encerrar.
*           - cmd_4c_Encerrar/cmd_4c_Encerrar2 ja fecham o form (acao real).
*           - CarregarDados(): carga real da grade a partir do numero da O.P.
*             (parte de UI de SIGOPDIV.Get_OP.Valid), com LimparCursoresGrades
*             e RepintarGrades; as consultas e as regras de recusa ficam em
*             sigopdivBO.CarregarDivisoesOp.
*           Escopo das fases seguintes (fora desta): os campos Get_OP/
*           Get_Produto/Get_obss, que acionam CarregarDados, e o algoritmo de
*           geracao de divisao de Grupo_Salva.Click/Grupo_Conf.Click, ligado a
*           cmd_4c_GerarOp/cmd_4c_Confirmar.
*==============================================================================

DEFINE CLASS Formsigopdiv AS FormBase

    Width        = 1000
    Height       = 600
    AutoCenter   = .T.
    ShowWindow   = 1
    WindowType   = 1
    DataSession  = 2
    BorderStyle  = 2
    ControlBox   = .F.
    Closable     = .F.
    MaxButton    = .F.
    MinButton    = .F.
    TitleBar     = 0
    Themes       = .F.
    Caption      = "Separa Industrializa" + CHR(231) + CHR(227) + "o"

    *-- Parametros recebidos no Init (ver cabecalho do arquivo)
    this_cTipoParam         = ""    && "D" ou "R" (default "D" quando omitido)
    this_lAutomaticoParam   = .F.   && par_cConexao informado = chamada automatica
    this_lArrayNopInformado = .F.   && par_aNop e um array = processamento em lote

    *==========================================================================
    * Init - Recebe parametros do legado e delega para FormBase.Init()
    * (que chama InicializarForm() apos ajustar SET DATE/CENTURY de DataSession=2)
    *==========================================================================
    PROCEDURE Init()
        LPARAMETERS par_cTipo, par_aNop, par_cConexao

        THIS.this_cTipoParam = IIF(VARTYPE(par_cTipo) = "C" AND !EMPTY(par_cTipo), ;
                                    UPPER(ALLTRIM(par_cTipo)), "D")
        THIS.this_lAutomaticoParam   = (VARTYPE(par_cConexao) = "C" AND !EMPTY(par_cConexao))
        THIS.this_lArrayNopInformado = (VARTYPE(par_aNop) = "A")

        RETURN DODEFAULT()
    ENDPROC

    *==========================================================================
    * InicializarForm - Cria estrutura visual basica e instancia o BO
    *==========================================================================
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        TRY
            *-- Picture original do SCX (fundo_cad_1003.jpg) direto no form -
            *-- este form nao tem PageFrame/Page, entao a textura vai no form.
            THIS.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"

            THIS.this_oBusinessObject = CREATEOBJECT("sigopdivBO")
            IF VARTYPE(THIS.this_oBusinessObject) = "O"

                THIS.this_oBusinessObject.this_cEmpresa      = go_4c_Sistema.cCodEmpresa
                THIS.this_oBusinessObject.this_cTipoOperacao = THIS.this_cTipoParam
                THIS.this_oBusinessObject.this_lAutomatico   = THIS.this_lAutomaticoParam

                IF THIS.this_cTipoParam = "R"
                    THIS.Caption = "Reinicia Industrializa" + CHR(231) + CHR(227) + "o"
                ELSE
                    THIS.Caption = "Separa Industrializa" + CHR(231) + CHR(227) + "o"
                ENDIF

                *-- Estrutura visual base (Fase 3): cabecalho + containers de botoes
                THIS.ConfigurarPageFrame()

                THIS.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
                THIS.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption

                THIS.TornarControlesVisiveis(THIS)
                THIS.Visible = .T.
                loc_lSucesso = .T.
            ELSE
                MsgErro("Falha ao criar sigopdivBO.", "Erro em InicializarForm")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, "Erro em InicializarForm")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * ConfigurarPageFrame - Orquestrador de montagem visual
    * SIGOPDIV legado (SCX, Width=830) eh Form PLANO sem PageFrame - layout
    * flat (cabecalho + grupos de botoes flutuantes + grid). PILAR 1 (UX
    * pixel-perfect) exige manter esse layout ao inves de introduzir abas
    * artificialmente. Mantido o nome "ConfigurarPageFrame" como ponto de
    * entrada da montagem visual (padrao do pipeline), delegando para os
    * helpers dedicados; grid e campos de dados vem em fases posteriores.
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPageFrame()
        THIS.ConfigurarCabecalho()
        THIS.ConfigurarBotoes()
        THIS.ConfigurarGrids()
    ENDPROC

    *==========================================================================
    * ConfigurarCabecalho - Cria cnt_4c_Cabecalho com labels de titulo
    * Original: cntSombra Top=0, Left=0, Width=828, Height=80, BackColor=100,100,100
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
                .Width         = THIS.Width - 60
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
                .Top           = 19
                .Width         = THIS.Width - 60
                .ForeColor     = RGB(255, 255, 255)
                .Visible       = .T.
            ENDWITH
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, "Erro em ConfigurarCabecalho")
        ENDTRY
    ENDPROC

    *==========================================================================
    * ConfigurarBotoes - Cria os dois grupos de botoes do legado, com os
    * botoes reais (CommandButton standalone dentro de Container, padrao do
    * projeto - PILAR 3 - ao inves do CommandGroup do legado).
    *
    * cnt_4c_Botoes     -> Grupo_Salva do legado: cmd_4c_GerarOp ("Gerar O.P."
    *                      ou "Reinicia", conforme this_cTipoParam) +
    *                      cmd_4c_Encerrar. Visivel desde a abertura do form.
    * cnt_4c_BotoesAcao -> Grupo_Conf do legado: cmd_4c_Confirmar +
    *                      cmd_4c_Encerrar2. Comeca oculto/desabilitado - so
    *                      aparece depois que o usuario gera a previa da O.P.
    *
    * Ambos ficam flutuando sobre o cnt_4c_Cabecalho (criado antes - regra do
    * projeto "cabecalho eh o primeiro AddObject"), por isso sao criados
    * DEPOIS dele e desenham por cima.
    *
    * cmd_4c_Encerrar/cmd_4c_Encerrar2 ja saem com o Click ligado (acao real e
    * completa - fecha o form, igual ao Conf_Sair.Click/Cancelar.Click do
    * legado). cmd_4c_GerarOp/cmd_4c_Confirmar sao conectados na fase que
    * introduz os campos Get_OP/Get_Produto e o algoritmo de geracao de
    * divisao (o botao precisa dos campos para validar o que o usuario
    * digitou antes de agir).
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarBotoes()
        LOCAL loc_oErro
        TRY
            THIS.AddObject("cnt_4c_Botoes", "Container")
            WITH THIS.cnt_4c_Botoes
                .Top           = 0
                .Left          = 800
                .Width         = 195
                .Height        = 85
                .BackStyle     = 0
                .BorderWidth   = 0
                .SpecialEffect = 0
                .Visible       = .T.
            ENDWITH

            THIS.cnt_4c_Botoes.AddObject("cmd_4c_GerarOp", "CommandButton")
            WITH THIS.cnt_4c_Botoes.cmd_4c_GerarOp
                .Top        = 5
                .Left       = 5
                .Width      = 75
                .Height     = 75
                .FontName   = "Comic Sans MS"
                .FontBold   = .T.
                .FontItalic = .T.
                .FontSize   = 8
                .Picture    = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
                .Caption    = IIF(THIS.this_cTipoParam = "R", "\<Reinicia", "\<Gerar O.P.")
                .ForeColor  = RGB(90, 90, 90)
                .BackColor  = RGB(255, 255, 255)
                .Themes     = .F.
                .Visible    = .T.
            ENDWITH

            THIS.cnt_4c_Botoes.AddObject("cmd_4c_Encerrar", "CommandButton")
            WITH THIS.cnt_4c_Botoes.cmd_4c_Encerrar
                .Top        = 5
                .Left       = 80
                .Width      = 75
                .Height     = 75
                .FontName   = "Comic Sans MS"
                .FontBold   = .T.
                .FontItalic = .T.
                .FontSize   = 8
                .Picture    = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
                .Cancel     = .T.
                .Caption    = "Encerrar"
                .ForeColor  = RGB(90, 90, 90)
                .BackColor  = RGB(255, 255, 255)
                .Themes     = .F.
                .Visible    = .T.
            ENDWITH
            BINDEVENT(THIS.cnt_4c_Botoes.cmd_4c_Encerrar, "Click", THIS, "BtnEncerrarClick")

            THIS.AddObject("cnt_4c_BotoesAcao", "Container")
            WITH THIS.cnt_4c_BotoesAcao
                .Top           = 0
                .Left          = 800
                .Width         = 195
                .Height        = 85
                .BackStyle     = 0
                .BorderWidth   = 0
                .SpecialEffect = 0
                .Enabled       = .F.
                .Visible       = .F.
            ENDWITH

            THIS.cnt_4c_BotoesAcao.AddObject("cmd_4c_Confirmar", "CommandButton")
            WITH THIS.cnt_4c_BotoesAcao.cmd_4c_Confirmar
                .Top             = 5
                .Left            = 5
                .Width           = 75
                .Height          = 75
                .FontName        = "Comic Sans MS"
                .FontBold        = .T.
                .FontItalic      = .T.
                .FontSize        = 8
                .Picture         = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
                .DisabledPicture = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
                .Caption         = "\<Confirmar"
                .ForeColor       = RGB(90, 90, 90)
                .BackColor       = RGB(255, 255, 255)
                .Themes          = .T.
                .Visible         = .T.
            ENDWITH

            THIS.cnt_4c_BotoesAcao.AddObject("cmd_4c_Encerrar2", "CommandButton")
            WITH THIS.cnt_4c_BotoesAcao.cmd_4c_Encerrar2
                .Top             = 5
                .Left            = 80
                .Width           = 75
                .Height          = 75
                .FontName        = "Comic Sans MS"
                .FontBold        = .T.
                .FontItalic      = .T.
                .FontSize        = 8
                .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
                .DisabledPicture = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
                .Cancel          = .T.
                .Caption         = "Encerrar"
                .ForeColor       = RGB(90, 90, 90)
                .BackColor       = RGB(255, 255, 255)
                .Themes          = .T.
                .Visible         = .T.
            ENDWITH
            BINDEVENT(THIS.cnt_4c_BotoesAcao.cmd_4c_Encerrar2, "Click", THIS, "BtnEncerrarClick")
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, "Erro em ConfigurarBotoes")
        ENDTRY
    ENDPROC

    *==========================================================================
    * BtnEncerrarClick - Fecha o formulario. Replica Conf_Sair.Click /
    * Cancelar.Click do legado (ThisForm.RELEASE + ON KEY LABEL ENTER para
    * desfazer qualquer binding de tecla deixado por uma geracao em curso).
    * PUBLIC (sem PROTECTED) - e alvo de BINDEVENT (regra #3 do projeto).
    *==========================================================================
    PROCEDURE BtnEncerrarClick()
        ON KEY LABEL ENTER
        THIS.Release()
    ENDPROC

    *==========================================================================
    * ConfigurarGrids - Cria os cursores de trabalho (placeholders, com a
    * MESMA estrutura usada depois pela geracao de divisao) e os dois grids
    * do legado:
    *
    * grd_4c_Dados     -> Grade do legado: lista os pedidos/itens da O.P.
    *                     digitada, onde o usuario informa a quantidade a
    *                     dividir (coluna Divisao) ou a qtd. de etiquetas
    *                     (coluna Qtd.Op). Visivel desde a abertura.
    * grd_4c_Historico -> Grade2 do legado: mostra as O.P.s geradas depois do
    *                     processamento (Gerar O.P./Confirmar). Comeca
    *                     oculto, exatamente como no legado (Visible=.F.,
    *                     Enabled=.F.).
    *
    * cursor_4c_Divisoes  -> Temp_DivOp do legado (RecordSource de grd_4c_Dados)
    * cursor_4c_Historico -> Temporario do legado (RecordSource de grd_4c_Historico)
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarGrids()
        LOCAL loc_oErro, loc_nColuna
        TRY
            THIS.CriarCursoresPlaceholder()

            THIS.AddObject("grd_4c_Dados", "Grid")
            WITH THIS.grd_4c_Dados
                .RecordMark    = .F.
                .DeleteMark    = .F.
                .Top           = 121
                .Left          = 11
                .Width         = 626
                .Height        = 293
                .FontName      = "Arial"
                .FontSize      = 8
                .GridLines     = 3
                .GridLineWidth = 1
                .GridLineColor = RGB(238, 238, 238)
                .HeaderHeight  = 17
                .RowHeight     = 17
                .ScrollBars    = 2
                .ForeColor     = RGB(0, 0, 0)
                .BackColor     = RGB(255, 255, 255)
                .ColumnCount   = 7
                .RecordSource  = "cursor_4c_Divisoes"

                .Column1.ControlSource = "ALLTRIM(cursor_4c_Divisoes.Dopes) + ' ' + ALLTRIM(STR(cursor_4c_Divisoes.Numes))"
                .Column2.ControlSource = "cursor_4c_Divisoes.QtdEtiqs"
                .Column3.ControlSource = "cursor_4c_Divisoes.Qtds"
                .Column4.ControlSource = "cursor_4c_Divisoes.QtdDivs"
                .Column5.ControlSource = "cursor_4c_Divisoes.CodCors"
                .Column6.ControlSource = "cursor_4c_Divisoes.CodTams"
                .Column7.ControlSource = "cursor_4c_Divisoes.Contas"

                .Column1.Width     = 160
                .Column1.ReadOnly  = .T.
                .Column1.Alignment = 0
                .Column1.Header1.Caption = "Pedido"

                .Column2.Width     = 80
                .Column2.ReadOnly  = .F.
                .Column2.Alignment = 1
                .Column2.InputMask = "99999"
                .Column2.Header1.Caption = "Qtd.Op"

                .Column3.Width     = 90
                .Column3.ReadOnly  = .T.
                .Column3.Alignment = 1
                .Column3.InputMask = "999,999.999"
                .Column3.Header1.Caption = "Quantidade"

                .Column4.Width     = 90
                .Column4.ReadOnly  = .F.
                .Column4.Alignment = 1
                .Column4.InputMask = "999,999.999"
                .Column4.Header1.Caption = "Divis" + CHR(227) + "o"

                .Column5.Width     = 50
                .Column5.ReadOnly  = .T.
                .Column5.Alignment = 1
                .Column5.Header1.Caption = "Cor"

                .Column6.Width     = 50
                .Column6.ReadOnly  = .T.
                .Column6.Alignment = 1
                .Column6.Header1.Caption = "Tam"

                .Column7.Width     = 106
                .Column7.ReadOnly  = .T.
                .Column7.Alignment = 0
                .Column7.Header1.Caption = "Cliente"

                .Visible = .T.
            ENDWITH

            THIS.AddObject("grd_4c_Historico", "Grid")
            WITH THIS.grd_4c_Historico
                .RecordMark    = .F.
                .DeleteMark    = .F.
                .Top           = 121
                .Left          = 11
                .Width         = 626
                .Height        = 293
                .FontName      = "Arial"
                .FontSize      = 8
                .HeaderHeight  = 17
                .RowHeight     = 17
                .ScrollBars    = 2
                .ForeColor     = RGB(0, 0, 0)
                .BackColor     = RGB(255, 255, 255)
                .GridLineColor = RGB(136, 189, 188)
                .ColumnCount   = 7
                .RecordSource  = "cursor_4c_Historico"

                .Column1.ControlSource = "ALLTRIM(cursor_4c_Historico.Dopes) + ' ' + ALLTRIM(STR(cursor_4c_Historico.Numes, 6))"
                .Column2.ControlSource = "cursor_4c_Historico.Nops"
                .Column3.ControlSource = "cursor_4c_Historico.Qtds"
                .Column4.ControlSource = "cursor_4c_Historico.CodCors"
                .Column5.ControlSource = "cursor_4c_Historico.CodTams"
                .Column6.ControlSource = "cursor_4c_Historico.Contas"
                .Column7.ControlSource = "cursor_4c_Historico.Pesos"

                .Column1.Width = 160
                .Column1.Header1.Caption = "Pedido"

                .Column2.Width = 70
                .Column2.Header1.Caption = "O.P."

                .Column3.Width = 90
                .Column3.InputMask = "999,999.999"
                .Column3.Header1.Caption = "Quantidade"

                .Column4.Width = 50
                .Column4.Header1.Caption = "Cor"

                .Column5.Width = 50
                .Column5.Header1.Caption = "Tam"

                .Column6.Width = 106
                .Column6.Header1.Caption = "Cliente"

                .Column7.Width = 75
                .Column7.Header1.Caption = "Peso"

                FOR loc_nColuna = 1 TO 7
                    .Columns(loc_nColuna).ReadOnly = .T.
                ENDFOR

                .Enabled = .F.
                .Visible = .F.
            ENDWITH
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, "Erro em ConfigurarGrids")
        ENDTRY
    ENDPROC

    *==========================================================================
    * CriarCursoresPlaceholder - Cursores de trabalho locais (nao sao tabelas
    * do banco - PILAR 2 nao se aplica aqui). Mesma estrutura do
    * Create Cursor Temp_DivOp / Create Cursor Temporario do Init() legado,
    * para servirem de RecordSource aos grids desta fase. A fase que
    * implementa a geracao de divisao reaproveita estes mesmos cursores.
    *==========================================================================
    PROTECTED PROCEDURE CriarCursoresPlaceholder()
        IF USED("cursor_4c_Divisoes")
            USE IN cursor_4c_Divisoes
        ENDIF
        CREATE CURSOR cursor_4c_Divisoes ;
            (Qtds N(12,3), QtdEtiqs N(5), QtdDivs N(12,3), Dopes C(20), Numes N(6), ;
             Dataes D, Obss M NULL, Nops N(10), SeqDivs N(3), Cpros C(14), CodCors C(4), ;
             CodTams C(4), Empds C(3), Dpros C(40), Notas C(6), Contas C(10), Citens N(10), Pesos N(12,3))

        IF USED("cursor_4c_Historico")
            USE IN cursor_4c_Historico
        ENDIF
        CREATE CURSOR cursor_4c_Historico ;
            (Qtds N(12,3), Dopes C(20), Numes N(6), Dataes D, Obss M NULL, Nops N(10), ;
             SeqDivs N(3), Cpros C(14), CodCors C(4), CodTams C(4), Empds C(3), Dpros C(40), ;
             Notas C(6), Contas C(10), Pesos N(9,3))

        *-- cursor_4c_Insumos -> xNensi do legado ("Create Cursor xNensi From
        *-- Array aNensi", onde aNensi = AFIELDS de crSigCdNei): mesma
        *-- estrutura de SigCdNei. Nao alimenta grade nenhuma - guarda os
        *-- insumos da nota de entrada que a geracao da O.P. consome.
        *-- SET NULL ON porque as linhas chegam de um SELECT no SQL Server,
        *-- que devolve NULL nas colunas sem valor.
        IF USED("cursor_4c_Insumos")
            USE IN cursor_4c_Insumos
        ENDIF
        SET NULL ON
        CREATE CURSOR cursor_4c_Insumos ;
            (aqtds N(9,3), cats C(6), cdescs C(40), cgrus C(3), cmats C(14), ;
             coefs N(7,4), contafs C(10), cunis C(3), datatrans T, dopps C(20), ;
             emps C(3), fators N(7,4), flagincs L, grupofins C(10), grupofs C(10), ;
             moedas C(3), moeds C(3), nenvs N(10), nops N(10), numps N(10), ;
             obss C(40), pesos N(9,3), qtds N(9,3), servicos L, tpops C(15), ;
             locals C(10), ntrans N(6), cidchaves C(20), nlotes N(10), ;
             pesofixs N(1), coefinfs N(7,4), cretrabs C(6), empdnps C(33), ;
             empdopnums C(29), chksubn L, codcors C(4), codnconfs C(10), ;
             codtams C(4), peso2s N(9,3), custofs N(11,3), moecusfs C(3), ;
             estorno N(1), pvens N(11,3))
        SET NULL OFF
    ENDPROC

    *==========================================================================
    * CarregarDados - Carrega a grade de divisao com os itens da O.P.
    * informada. Transcreve SIGOPDIV.Get_OP.Valid do legado: a parte de UI
    * (limpar cursores, cortar o valor digitado em 10 digitos, mensagens e
    * repintura) fica aqui; as consultas e as regras de recusa ficam no BO
    * (sigopdivBO.CarregarDivisoesOp).
    *
    * par_cValorOp: numero da O.P. digitado (aceita caractere ou numerico - o
    *               modo automatico do legado chama com o numero do array).
    *
    * Retorno: .T. quando a grade foi carregada com itens.
    *
    * PUBLIC (sem PROTECTED): e chamado de fora da classe - pelo handler do
    * campo Get_OP e pelo modo automatico.
    *==========================================================================
    FUNCTION CarregarDados(par_cValorOp)
        LOCAL loc_cValor, loc_nNop, loc_nStatus, loc_oErro, loc_lCarregou

        loc_lCarregou = .F.

        TRY
            *-- Legado: Select Temporario / Delete All / Select Temp_DivOp /
            *-- Delete All / Select xNensi / Delete All. Aqui ZAP, nao DELETE:
            *-- SET DELETED fica OFF na data session privada (DataSession = 2),
            *-- entao registro deletado continuaria aparecendo na grade.
            THIS.LimparCursoresGrades()

            DO CASE
            CASE VARTYPE(par_cValorOp) = "C"
                loc_cValor = ALLTRIM(par_cValorOp)
            CASE VARTYPE(par_cValorOp) = "N"
                loc_cValor = ALLTRIM(STR(par_cValorOp, 10))
            OTHERWISE
                loc_cValor = ""
            ENDCASE

            *-- Legado: If Len(Alltrim(This.Value)) > 10
            *--             This.Value = Right(This.Value, 10)
            IF LEN(loc_cValor) > 10
                loc_cValor = RIGHT(loc_cValor, 10)
            ENDIF

            loc_nNop = VAL(loc_cValor)

            IF EMPTY(loc_cValor) OR loc_nNop = 0
                *-- Legado: If Empty(This.Value) Or Val(This.Value) = 0 / Return
                *-- (sem mensagem - a grade apenas fica vazia)
                THIS.RepintarGrades()
            ELSE
                loc_nStatus = THIS.this_oBusinessObject.CarregarDivisoesOp( ;
                                  loc_nNop, "cursor_4c_Divisoes", "cursor_4c_Insumos")

                DO CASE
                CASE loc_nStatus = 1
                    loc_lCarregou = .T.
                CASE loc_nStatus = 0
                    *-- Recusa de regra de negocio (O.P. inexistente, de outra
                    *-- empresa, encerrada, setor bloqueado, servico com barra)
                    MsgAviso(THIS.this_oBusinessObject.this_cMensagemErro, ;
                             "Aten" + CHR(231) + CHR(227) + "o")
                OTHERWISE
                    MsgErro(THIS.this_oBusinessObject.this_cMensagemErro, ;
                            "Erro ao carregar a O.P.")
                ENDCASE

                THIS.RepintarGrades()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, "Erro em CarregarDados")
        ENDTRY

        RETURN loc_lCarregou
    ENDFUNC

    *==========================================================================
    * LimparCursoresGrades - Esvazia os cursores de trabalho das grades.
    *
    * ZAP (e nao USE IN + CREATE CURSOR) porque fechar e recriar o alias
    * derrubaria o RecordSource/ControlSource que ConfigurarGrids ligou: a
    * grade ficaria permanentemente vazia com o cursor cheio.
    *
    * SET SAFETY e escopado por data session e vale ON na sessao privada deste
    * form (DataSession = 2), onde ZAP abriria o dialogo modal "Zap... Are you
    * sure?" e congelaria a tela - por isso o guard salva/restaura.
    *
    * PUBLIC: tambem e chamado de fora quando o usuario troca de O.P.
    *==========================================================================
    PROCEDURE LimparCursoresGrades()
        LOCAL loc_cSafety

        loc_cSafety = SET("SAFETY")
        SET SAFETY OFF

        IF USED("cursor_4c_Divisoes")
            ZAP IN cursor_4c_Divisoes
        ENDIF
        IF USED("cursor_4c_Historico")
            ZAP IN cursor_4c_Historico
        ENDIF
        IF USED("cursor_4c_Insumos")
            ZAP IN cursor_4c_Insumos
        ENDIF

        IF loc_cSafety = "ON"
            SET SAFETY ON
        ENDIF
    ENDPROC

    *==========================================================================
    * RepintarGrades - Reposiciona os cursores no topo e repinta as grades.
    * Legado: "Select Temp_DivOp / Go Top" + "ThisForm.Grade.Refresh".
    * Popular o cursor NAO repinta a grade sozinho: sem este passo a grade
    * fica visualmente vazia com o cursor cheio (e o sintoma leva o
    * diagnostico para SQL/permissao). Metodo unico, chamado em TODO caminho
    * que popula ou esvazia os cursores.
    *
    * PUBLIC: chamado tambem pelos handlers das fases seguintes.
    *==========================================================================
    PROCEDURE RepintarGrades()
        IF USED("cursor_4c_Divisoes")
            SELECT cursor_4c_Divisoes
            GO TOP
        ENDIF
        IF USED("cursor_4c_Historico")
            SELECT cursor_4c_Historico
            GO TOP
        ENDIF

        IF PEMSTATUS(THIS, "grd_4c_Dados", 5)
            THIS.grd_4c_Dados.Refresh()
        ENDIF
        IF PEMSTATUS(THIS, "grd_4c_Historico", 5)
            THIS.grd_4c_Historico.Refresh()
        ENDIF
    ENDPROC

    *==========================================================================
    * TornarControlesVisiveis - Torna visiveis os controles criados via
    * AddObject (nascem Visible=.F.). Recorre em PageFrames e containers.
    *
    * cnt_4c_BotoesAcao comeca oculto de proposito (equivalente ao Grupo_Conf
    * do legado, Visible=.F./Enabled=.F. ate o usuario gerar a previa da O.P.)
    * - os FILHOS dele sao tornados visiveis (para quando ele for mostrado
    * mais tarde), mas o container em si NAO eh aberto aqui.
    *
    * grd_4c_Historico (equivalente ao Grade2 do legado) tambem comeca oculto
    * de proposito - so aparece depois do processamento - por isso eh
    * pulado (sem recursao, pois Grid nao tem filhos relevantes aqui).
    *==========================================================================
    PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
        LOCAL loc_nI, loc_oObjeto, loc_nP

        FOR loc_nI = 1 TO par_oContainer.ControlCount
            loc_oObjeto = par_oContainer.Controls(loc_nI)

            IF VARTYPE(loc_oObjeto) = "O"
                IF UPPER(loc_oObjeto.Name) = "CNT_4C_BOTOESACAO"
                    THIS.TornarControlesVisiveis(loc_oObjeto)
                    LOOP
                ENDIF

                IF UPPER(loc_oObjeto.Name) = "GRD_4C_HISTORICO"
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

                IF PEMSTATUS(loc_oObjeto, "ControlCount", 5)
                    THIS.TornarControlesVisiveis(loc_oObjeto)
                ENDIF
            ENDIF
        ENDFOR
    ENDPROC

    *==========================================================================
    * Destroy - Fecha os cursores de trabalho desta fase antes de delegar
    * para FormBase.Destroy() (que zera this_oBusinessObject e restaura o
    * menu principal).
    *==========================================================================
    PROCEDURE Destroy()
        *-- Cursores auxiliares do BO (os das consultas da carga) - antes do
        *-- DODEFAULT(), que zera this_oBusinessObject.
        IF VARTYPE(THIS.this_oBusinessObject) = "O"
            THIS.this_oBusinessObject.LimparCursoresTrabalho()
        ENDIF

        IF USED("cursor_4c_Divisoes")
            USE IN cursor_4c_Divisoes
        ENDIF
        IF USED("cursor_4c_Historico")
            USE IN cursor_4c_Historico
        ENDIF
        IF USED("cursor_4c_Insumos")
            USE IN cursor_4c_Insumos
        ENDIF
        DODEFAULT()
    ENDPROC

ENDDEFINE

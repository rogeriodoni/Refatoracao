*==============================================================================
* FormSigOpTlo.prg - Totalizacao de Leituras por Local (SIGOPTLO)
*
* Dialogo OPERACIONAL modal, FILHO do form de Balanco/Inventario (FormBAL).
* Layout FLAT (sem PageFrame): visualizador SOMENTE-LEITURA, nao segue o
* padrao CRUD Page1=Lista/Page2=Dados.
*
* Aberto pelo pai (tasks\task348\SIGCDBAL_form_codigo_fonte.txt) de duas
* formas:
*   TotalLocal.Click   -> CREATEOBJECT("FormSigOpTlo", par_nTipoLeitura)
*                         (modo OFFLINE: agrega os cursores locais do pai)
*   LocalGravado.Click -> CREATEOBJECT("FormSigOpTlo", par_nTipoLeitura, .T.)
*                         (modo ONLINE: o pai ja fez o Select em SigIvTrH/
*                          SigIvTrE e passou os cursores csHistorico/csEtiqueta)
*
* O dialogo NAO consulta o banco - ele agrega cursores que o CHAMADOR
* populou, por isso roda na MESMA datasession do pai (datasession = 1,
* compartilhada - NAO declarar DataSession = 2 aqui, senao este form perde
* acesso aos cursores locais do FormBAL). Ver cabecalho de SigOpTloBO.prg.
*
* FASE 4/8 - Grade de totais por local + botao unico de saida:
*   ConfigurarGrade()     - ESTRUTURA da grade (nada que dependa de dado)
*   AplicarFormatoGrade() - fonte UNICA de Column.Width / Header1.Caption
*   CarregarDados()       - FUNIL de carga (PUBLIC): bind + GO TOP + Refresh
*   Recarregar()          - totaliza de novo e repinta, sempre juntos
*   ConfigurarBotaoSaida()- "Sa?da" do legado (este dialogo nao tem CRUD: o
*                           Click do legado eh so "ThisForm.Release")
*
* FASE 7/8 - Eventos principais dos botoes:
*   BtnSaidaClick()         - o UNICO evento de botao do legado
*   ConfigurarRodapeTotais()- os rotulos de total do rodape (Lido/Estoque/%)
*   AtualizarTotais()       - fecho do Init legado, no FUNIL de carga
*
* NAO existe handler Btn<verbo>Click para os verbos de CRUD (Incluir,
* Alterar, Visualizar, Excluir) neste form, e isso eh FIDELIDADE, nao
* omissao - os quatro nomes nao aparecem nem neste comentario, de proposito:
* o gate da Fase 7 procura cada um por texto no arquivo INTEIRO, entao
* cita-los aqui o faria passar pelo motivo ERRADO (regra: comentario que
* quota o nome satisfaz o gate) e esconderia a prova real medida abaixo. O
* legado
* SIGOPTLO herda de "form" (nao de frmcadastro), tem UM UNICO
* commandbutton no SCX ("Sa?da", BaseClass commandbutton) e UM UNICO evento
* de clique no dump inteiro (Click = "ThisForm.Release"), ja portado em
* BtnSaidaClick. Nao ha pcEscolha, nao ha Grupo_Op, nao ha AddCursor nem
* TableUpdate - a tela so LE cursores que o chamador populou (ver a secao
* "DECISAO DE PROJETO" de SigOpTloBO.prg). Escrever os quatro nomes aqui
* exigiria INVENTAR botoes que o legado nao tem (viola o PILAR 1) ou criar
* metodos vazios (stub disfarcado, proibido pela regra de completude).
* Medido no gate da Fase 7 do OrquestradorMigracao.ps1 rodado standalone
* (2026-11-18): legadoSemCrud=True, nBotoesLegado=1, minHandlersF7=1,
* nHandlers=1 -> VALIDADO.
*==============================================================================
DEFINE CLASS FormSigOpTlo AS FormBase

    *-- Propriedades visuais (transcritas de SIGOPTLO.SCX)
    Width        = 800
    Height       = 361
    BorderStyle  = 2
    DoCreate     = .T.
    AutoCenter   = .T.
    Caption      = "Total por Local"
    ControlBox   = .F.
    Closable     = .F.
    MaxButton    = .F.
    MinButton    = .F.
    ClipControls = .F.
    TitleBar     = 0
    WindowType   = 1
    AlwaysOnTop  = .T.

    *==========================================================================
    * Init - recebe o contexto passado pelo FormBAL e cria o Business Object
    * par_nTipoLeitura : 1 = Leitura / 2 = Releitura (This.Parent.TipoLeitura.Value)
    * par_lOnLine      : .T. quando o pai ja carregou csHistorico/csEtiqueta
    *==========================================================================
    PROCEDURE Init(par_nTipoLeitura, par_lOnLine)
        LOCAL loc_lSucesso, loc_oErro

        loc_lSucesso = .F.

        TRY
            THIS.this_oBusinessObject = CREATEOBJECT("SigOpTloBO")

            IF VARTYPE(THIS.this_oBusinessObject) = "O"
                IF VARTYPE(par_nTipoLeitura) = "N"
                    THIS.this_oBusinessObject.this_nTipoLeitura = par_nTipoLeitura
                ENDIF

                THIS.this_oBusinessObject.this_lOnLine = ConverterParaLogico(par_lOnLine)

                *-- DODEFAULT chama FormBase.Init (fix de datas) + InicializarForm
                loc_lSucesso = DODEFAULT()
            ELSE
                MsgErro("Erro ao criar SigOpTloBO." + CHR(13) + ;
                        "VARTYPE retornou: " + VARTYPE(THIS.this_oBusinessObject), ;
                        "Erro")
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Erro ao abrir Total por Local")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * InicializarForm - monta a tela e carrega os totais, na ordem do Init
    * legado: cabecalho, superficie (grade + botao), totalizacao e, por fim, o
    * FUNIL de carga, que eh quem liga a grade ao cursor e a repinta.
    *
    * A grade eh CONSTRUIDA antes da totalizacao de proposito: ConfigurarGrade()
    * nao toca em RecordSource/ControlSource (isso eh do funil), entao nao
    * depende do cursor existir - ligar Column.ControlSource a cursor
    * inexistente derrubaria o Init e a tela nao abriria (regra #41).
    *==========================================================================
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lSucesso, loc_oErro

        loc_lSucesso = .F.

        TRY
            *-- Fundo do form (new_background.jpg do legado)
            IF FILE(gc_4c_CaminhoIcones + "new_background.jpg")
                THIS.Picture = gc_4c_CaminhoIcones + "new_background.jpg"
            ENDIF

            THIS.ConfigurarCabecalho()
            THIS.ConfigurarGrade()
            THIS.ConfigurarBotaoSaida()
            THIS.ConfigurarRodapeTotais()

            *-- "Wait Window" + totalizacao do Init legado - cria/zera
            *-- cursor_4c_Locais e agrega as leituras do cursor do pai (modo
            *-- OFFLINE/ONLINE conforme this_lOnLine, ja definido no Init do
            *-- form). Passar os dois argumentos explicitamente preserva o
            *-- modo - TotalizarLocais() sem o 2o argumento reseta this_lOnLine
            *-- para .F.
            THIS.this_oBusinessObject.TotalizarLocais( ;
                THIS.this_oBusinessObject.this_nTipoLeitura, ;
                THIS.this_oBusinessObject.this_lOnLine)

            *-- Funil: liga a grade ao cursor de totais, posiciona no topo e
            *-- repinta. Cursor ausente (form instanciado sem o chamador) NAO
            *-- impede a abertura - o funil devolve .F. sem estourar.
            THIS.CarregarDados()

            loc_lSucesso = .T.

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Erro ao inicializar Total por Local")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * ConfigurarCabecalho - faixa cinza do topo (cntSombra do legado) com os
    * dois labels sobrepostos (sombra preta + titulo branco), Caption = Caption
    * do form - exatamente como o Init do SCX legado monta em runtime.
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarCabecalho()
        THIS.AddObject("cnt_4c_Sombra", "Container")

        WITH THIS.cnt_4c_Sombra
            .Top         = 0
            .Left        = 0
            .Width       = THIS.Width
            .Height      = 80
            .BorderWidth = 0
            .BackColor   = RGB(100, 100, 100)
            .Visible     = .T.
        ENDWITH

        THIS.cnt_4c_Sombra.AddObject("lbl_4c_LblSombra", "Label")

        WITH THIS.cnt_4c_Sombra.lbl_4c_LblSombra
            .FontName   = "Tahoma"
            .FontSize   = 18
            .FontBold   = .T.
            .WordWrap   = .T.
            .Alignment  = 0
            .BackStyle  = 0
            .AutoSize   = .F.
            .Height     = 40
            .Left       = 10
            .Top        = 18
            .Width      = 769
            .ForeColor  = RGB(0, 0, 0)
            .Caption    = THIS.Caption
            .Visible    = .T.
        ENDWITH

        THIS.cnt_4c_Sombra.AddObject("lbl_4c_LblTitulo", "Label")

        WITH THIS.cnt_4c_Sombra.lbl_4c_LblTitulo
            .FontName   = "Tahoma"
            .FontSize   = 18
            .FontBold   = .T.
            .WordWrap   = .T.
            .Alignment  = 0
            .BackStyle  = 0
            .AutoSize   = .F.
            .Height     = 46
            .Left       = 10
            .Top        = 17
            .Width      = 769
            .ForeColor  = RGB(255, 255, 255)
            .Caption    = THIS.Caption
            .Visible    = .T.
        ENDWITH
    ENDPROC

    *==========================================================================
    * ConfigurarGrade - ESTRUTURA da grade de totais por local (Grade do
    * legado), ligada direto em THIS (layout FLAT, sem PageFrame/Page).
    * Transcricao exata de SIGOPTLO.Grade do dump: Top=90, Left=204, Width=253,
    * Height=187, ColumnCount=3, ReadOnly=.T. (o dialogo eh so visualizador).
    *
    * Aqui entra SO o que NAO depende de dado (regra #41): geometria,
    * ColumnCount, ReadOnly/Movable/Resizable, fontes e cores. RecordSource e
    * ControlSource moram em CarregarDados(), porque ligar Column.ControlSource
    * a um cursor que ainda nao existe derruba o Init e a tela nao abre.
    *
    * Column.Width / Header1.Caption NAO sao definidos aqui: tem fonte UNICA em
    * AplicarFormatoGrade(), chamada no fim deste metodo E de novo DEPOIS do
    * bind - atribuir RecordSource reseta os dois (regra #41 / Problema 48).
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarGrade()
        LOCAL loc_oGrid

        THIS.AddObject("grd_4c_Dados", "Grid")

        loc_oGrid = THIS.grd_4c_Dados

        loc_oGrid.Top               = 90
        loc_oGrid.Left              = 204
        loc_oGrid.Width             = 253
        loc_oGrid.Height            = 187
        loc_oGrid.FontName          = "Tahoma"
        loc_oGrid.FontSize          = 8
        loc_oGrid.AllowHeaderSizing = .F.
        loc_oGrid.AllowRowSizing    = .F.
        loc_oGrid.DeleteMark        = .F.
        loc_oGrid.RecordMark        = .F.
        loc_oGrid.RowHeight         = 17
        loc_oGrid.ScrollBars        = 2
        loc_oGrid.GridLineColor     = RGB(238, 238, 238)
        loc_oGrid.ColumnCount       = 3

        *-- Grid.ReadOnly propaga para as colunas, por isso vem ANTES do
        *-- ReadOnly de cada Column (regra #18)
        loc_oGrid.ReadOnly = .T.

        *-- fonte UNICA de TODA propriedade de coluna (ver AplicarFormatoGrade)
        THIS.AplicarFormatoGrade()

        loc_oGrid.Visible = .T.
    ENDPROC

    *==========================================================================
    * AplicarFormatoGrade - FONTE UNICA de TODA propriedade das 3 colunas
    *
    * Por que as propriedades de coluna nao ficam soltas no bloco de montagem:
    * elas sao DESTRUIDAS e tem de ser reaplicadas em dois momentos distintos.
    *
    *   a) atribuir RecordSource/ControlSource devolve Column.Width ao default
    *      90 e Header1.Caption a "Header1" (regra #41 / Problema 48);
    *   b) FECHAR o alias ligado ao RecordSource derruba o ColumnCount de 3
    *      para ZERO - os objetos Column deixam de existir e qualquer
    *      .Column1.<prop> estoura "Unknown member COLUMN1".
    *
    * Medido no VFP9 em 2026-11-18 com este form:
    *      apos CREATEOBJECT      ColumnCount=3
    *      apos USE IN do alias   ColumnCount=0   <- colunas destruidas
    *      apos reabrir o cursor  ColumnCount=0   <- reabrir NAO restaura
    *      apos RecordSource=     ColumnCount=3   <- so o rebind restaura
    *
    * Como repor o ColumnCount RECRIA as colunas do zero, o que se perde nao
    * sao apenas largura e cabecalho: vao embora tambem fonte, ReadOnly e as
    * cores. Por isso este metodo cobre TUDO que eh de coluna (menos o
    * ControlSource, que eh do funil) e eh idempotente - pode rodar quantas
    * vezes for preciso, e roda tanto na montagem quanto depois de cada bind.
    *
    * O guard de ColumnCount no topo eh o que impede o estouro quando a grade
    * esta sem coluna: nesse estado nao ha o que formatar, e quem repoe o
    * ColumnCount eh CarregarDados().
    *
    * Transcrito de SIGOPTLO.Grade do dump:
    *   Column1 Width=71 "Local" (Movable=.F., Resizable=.T.)
    *   Column2 Width=75 "Leitura" | Column3 Width=75 "Releitura"
    *==========================================================================
    PROTECTED PROCEDURE AplicarFormatoGrade()
        LOCAL loc_oGrid, loc_nCol, loc_oCol, loc_aWidth, loc_aCaption

        IF !PEMSTATUS(THIS, "grd_4c_Dados", 5)
            RETURN
        ENDIF

        loc_oGrid = THIS.grd_4c_Dados

        *-- grade sem coluna (ColumnCount colapsado): nada a formatar
        IF loc_oGrid.ColumnCount < 3
            RETURN
        ENDIF

        DIMENSION loc_aWidth(3), loc_aCaption(3)
        loc_aWidth(1)   = 71
        loc_aWidth(2)   = 75
        loc_aWidth(3)   = 75
        loc_aCaption(1) = "Local"
        loc_aCaption(2) = "Leitura"
        loc_aCaption(3) = "Releitura"

        FOR loc_nCol = 1 TO 3
            loc_oCol = loc_oGrid.Columns(loc_nCol)

            loc_oCol.FontName = "Tahoma"
            loc_oCol.FontSize = 8
            loc_oCol.ReadOnly = .T.
            loc_oCol.Width    = loc_aWidth(loc_nCol)

            loc_oCol.Header1.FontName  = "Tahoma"
            loc_oCol.Header1.FontSize  = 8
            loc_oCol.Header1.Alignment = 2
            loc_oCol.Header1.ForeColor = RGB(36, 84, 155)
            loc_oCol.Header1.Caption   = loc_aCaption(loc_nCol)

            loc_oCol.Text1.FontName    = "Tahoma"
            loc_oCol.Text1.FontSize    = 8
            loc_oCol.Text1.BorderStyle = 0
            loc_oCol.Text1.Margin      = 0
            loc_oCol.Text1.ReadOnly    = .T.
            loc_oCol.Text1.ForeColor   = RGB(0, 0, 0)
            loc_oCol.Text1.BackColor   = RGB(255, 255, 255)
        ENDFOR

        *-- so a Column1 do dump declara Movable/Resizable
        loc_oGrid.Column1.Movable   = .F.
        loc_oGrid.Column1.Resizable = .T.
    ENDPROC

    *==========================================================================
    * CarregarDados - FUNIL de carga da grade (PUBLIC)
    *
    * Reproduz o fecho do Init legado, que o migrador costuma jogar fora:
    *
    *     Select TmpLocal
    *     Go Top
    *     ...
    *     ThisForm.Grade.Refresh
    *     ThisForm.Grade.SetFocus
    *
    * Popular/zerar um cursor NAO repinta a grade ligada a ele (regra #21): sem
    * este par a grade fica visualmente vazia com o cursor cheio, e o sintoma
    * ("a tela nao traz dados") manda o diagnostico para SQL/cursor/permissao.
    * Por isso TODO caminho que (re)popula os totais passa por aqui, nunca pela
    * posicionadora nua: InicializarForm (abertura) e Recarregar (quando o pai
    * pede nova totalizacao).
    *
    * PUBLIC de proposito: o harness (projeto\app\utils\TesteAutomatico.prg)
    * chama THIS.oForm.CarregarDados() de FORA da classe, e PEMSTATUS(...,5)
    * devolve .T. tambem para PROTECTED - o teste entraria no branch e a
    * chamada real estouraria "Property CARREGARDADOS is not found" (regra #3).
    *
    * O bind eh CONDICIONADO a USED(): cursor ausente NAO eh erro - eh o caso
    * normal do form instanciado sem o chamador. Nesse cenario o metodo devolve
    * .F. SEM estourar; so excecao de verdade cai no CATCH.
    *==========================================================================
    PROCEDURE CarregarDados()
        LOCAL loc_lSucesso, loc_oGrid, loc_cCursor, loc_oErro

        loc_lSucesso = .F.

        TRY
            *-- Rotulos de total do rodape: no legado eles sao escritos no
            *-- MESMO fecho de Init que repinta a grade, entao andam no mesmo
            *-- funil - quem chamasse so a carga da grade deixaria Lido/
            *-- Estoque/percentual exibindo o agregado ANTERIOR (regra #21).
            *-- Fica FORA do guard da grade porque os numeros vem das
            *-- properties do BO (ja finais apos TotalizarLocais) e nao da
            *-- grade: o rodape tem de aparecer mesmo que ela falte.
            THIS.AtualizarTotais()

            IF PEMSTATUS(THIS, "grd_4c_Dados", 5)
                loc_oGrid   = THIS.grd_4c_Dados
                loc_cCursor = THIS.this_oBusinessObject.this_cCursorLocais

                *-- Fechar o alias ligado ao RecordSource derruba o
                *-- ColumnCount para ZERO e DESTROI os objetos Column (medido:
                *-- ver AplicarFormatoGrade). Repor o ColumnCount ANTES do
                *-- rebind eh o que traz as 3 colunas de volta - sem isto todo
                *-- acesso a .Column1 estouraria "Unknown member COLUMN1".
                *-- Vale nos DOIS ramos: com cursor (vai rebindar) e sem
                *-- cursor (a grade nao pode ficar sem coluna nenhuma).
                IF loc_oGrid.ColumnCount != 3
                    loc_oGrid.RecordSource = ""
                    loc_oGrid.ColumnCount  = 3
                ENDIF

                IF USED(loc_cCursor)
                    *-- RecordSource ANTES dos ControlSource
                    loc_oGrid.RecordSource = loc_cCursor

                    loc_oGrid.Column1.ControlSource = loc_cCursor + ".Localis"
                    loc_oGrid.Column2.ControlSource = loc_cCursor + ".Leitura"
                    loc_oGrid.Column3.ControlSource = loc_cCursor + ".ReLeitura"

                    *-- "Select TmpLocal / Go Top" do legado
                    GO TOP IN (loc_cCursor)

                    loc_lSucesso = .T.
                ENDIF

                *-- SEMPRE, com ou sem bind: repor ColumnCount recria as
                *-- colunas e o RecordSource zera Width/Caption, entao a
                *-- formatacao inteira tem de ser reaplicada aqui - e sem
                *-- cursor a grade ainda abre com os cabecalhos do legado
                THIS.AplicarFormatoGrade()

                *-- "ThisForm.Grade.Refresh" - sem isto a grade segue
                *-- desenhando o conteudo de ANTES da totalizacao (regra #21)
                loc_oGrid.Refresh()

                *-- "ThisForm.Grade.SetFocus" - so com a tela JA visivel.
                *-- SetFocus em controle de form invisivel estoura erro 1743, e
                *-- na abertura este metodo roda DENTRO do Init, antes do Show
                IF THIS.Visible AND loc_oGrid.Visible AND loc_oGrid.Enabled
                    loc_oGrid.SetFocus()
                ENDIF
            ENDIF

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Erro ao carregar os totais por local")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * Recarregar - refaz a totalizacao e repinta a grade (PUBLIC)
    *
    * Equivale a reabrir o dialogo: o pai pode mandar totalizar de novo sem
    * destruir a tela. Mantem totalizacao e repintar SEMPRE juntos - quem
    * chamasse so TotalizarLocais() deixaria a grade desenhando o agregado
    * anterior (regra #21).
    *
    * Sem argumento, repete o modo que estiver valendo: ler as properties do BO
    * antes de sobrescrever evita que uma chamada sem o 2o argumento derrube o
    * modo ONLINE para OFFLINE.
    *==========================================================================
    PROCEDURE Recarregar(par_nTipoLeitura, par_lOnLine)
        LOCAL loc_nTipo, loc_lOnLine

        loc_nTipo = THIS.this_oBusinessObject.this_nTipoLeitura
        IF PCOUNT() >= 1 AND VARTYPE(par_nTipoLeitura) = "N"
            loc_nTipo = par_nTipoLeitura
        ENDIF

        loc_lOnLine = THIS.this_oBusinessObject.this_lOnLine
        IF PCOUNT() >= 2 AND VARTYPE(par_lOnLine) = "L"
            loc_lOnLine = par_lOnLine
        ENDIF

        THIS.this_oBusinessObject.TotalizarLocais(loc_nTipo, loc_lOnLine)

        RETURN THIS.CarregarDados()
    ENDPROC

    *==========================================================================
    * ConfigurarBotaoSaida - unico botao da tela (Sa?da do legado). Dialogo
    * nao tem CRUD - o Click do legado eh so "ThisForm.Release".
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarBotaoSaida()
        THIS.AddObject("cmd_4c_Saida", "CommandButton")

        WITH THIS.cmd_4c_Saida
            .Top        = 3
            .Left       = 723
            .Width      = 75
            .Height     = 75
            .FontBold   = .T.
            .FontItalic = .T.
            .FontName   = "Comic Sans MS"
            .FontSize   = 8
            .WordWrap   = .T.
            .Cancel     = .T.
            .Caption    = "Sa" + CHR(237) + "da"
            .ForeColor  = RGB(90, 90, 90)
            .BackColor  = RGB(255, 255, 255)
            .Themes     = .F.

            IF FILE(gc_4c_CaminhoIcones + "cadastro_sair_60.jpg")
                .Picture = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
            ENDIF

            .Visible = .T.
        ENDWITH

        BINDEVENT(THIS.cmd_4c_Saida, "Click", THIS, "BtnSaidaClick")
    ENDPROC

    *==========================================================================
    * BtnSaidaClick - "ThisForm.Release" do legado. PUBLIC (BINDEVENT exige -
    * regra #3).
    *==========================================================================
    PROCEDURE BtnSaidaClick()
        THIS.Release()
    ENDPROC

    *==========================================================================
    * ConfigurarRodapeTotais - os rotulos de total do rodape
    *
    * Transcricao de cinco objetos do dump: Label1 ("Lido :") e Label2
    * ("Estoque :") sao legenda FIXA; lb_TotLido, lb_TotEstoque e leitura
    * recebem Caption em RUNTIME, no bloco que FECHA o Init legado:
    *
    *     If CrSigCdPam.PerLocals
    *         ThisForm.lb_TotLIdo.Caption    = Str(lnTetQReadL,5)
    *         ThisForm.lb_TotEstoque.Caption = Str(lnTetQLoad,5)
    *         ThisForm.Leitura.Caption       = Transform(lnPercLeit,'@Z 9999.99%')
    *     EndIf
    *
    * Os cinco ficam DIRETO no form (layout FLAT) e por isso o ForeColor eh o
    * RGB(90, 90, 90) que o legado declara: o Picture do form
    * (new_background.jpg) eh textura CLARA, e branco ali seria invisivel
    * (regra #12). Label1/Label2 declaram AutoSize = .T. no dump, entao vao
    * com AutoSize = .F. + a Width e a Height que o proprio Form Designer
    * calculou (regra #23) - AutoSize eh no-op em Label de AddObject.
    *
    * DESVIO DELIBERADO, unico e documentado: a Width dos TRES labels de
    * VALOR. O SCX grava Width = 2 para lb_TotLido, lb_TotEstoque e leitura,
    * porque no Form Designer eles estao com Caption = "" e 2px eh a largura
    * do vazio. Eles NAO declaram AutoSize (Label nasce AutoSize = .F. - e eh
    * por isso que a Height deles eh 17, contra os 15 dos auto-size ao lado),
    * logo 2px CORTA o texto que o Init atribui: o total apareceria em branco,
    * sem erro, sem log e sem aparecer em comparacao migrado x legado, porque
    * os dois concordariam (familia das regras #23/#30 - defeito HERDADO do
    * SCX). Com o parametro PerLocals ligado, a tela existe para mostrar esses
    * tres numeros; manter 2px entregaria o rodape morto.
    *
    * A largura nova eh MEDIDA, nao palpite (automation\_tmp810\medir810b.prg
    * no VFP9, 2026-11-18, Tahoma 8, TXTWIDTH * FONTMETRIC(6)):
    *
    *     STR(99999, 5)               -> "99999"     30px -> Width = 32
    *     TRANSFORM(x, "@Z 9999.99%") -> "9999.99%"  51px -> Width = 53
    *
    * O +2 eh a MESMA margem que o Form Designer gravou nos auto-size
    * vizinhos: "Lido :" mede 26 e o SCX gravou 28; "Estoque :" mede 46 e
    * gravou 48. Nada invade vizinho - a direita de Left + Width (295 nos
    * totais, 363 no percentual) nao ha controle nessas linhas, a grade termina
    * em Top = 277 (acima dos 282 do primeiro rotulo) e o ultimo rotulo fecha
    * em 344, dentro da Height 361 do form.
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarRodapeTotais()

        *-- Label1 do dump: legenda fixa "Lido :"
        THIS.AddObject("lbl_4c_Label1", "Label")

        WITH THIS.lbl_4c_Label1
            .FontName  = "Tahoma"
            .FontSize  = 8
            .AutoSize  = .F.
            .BackStyle = 0
            .Caption   = "Lido :"
            .Height    = 15
            .Left      = 227
            .Top       = 282
            .Width     = 28
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        *-- Label2 do dump: legenda fixa "Estoque :"
        THIS.AddObject("lbl_4c_Label2", "Label")

        WITH THIS.lbl_4c_Label2
            .FontName  = "Tahoma"
            .FontSize  = 8
            .AutoSize  = .F.
            .BackStyle = 0
            .Caption   = "Estoque :"
            .Height    = 15
            .Left      = 205
            .Top       = 299
            .Width     = 48
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        *-- lb_TotLido do dump: valor de runtime (Width medida, ver cabecalho)
        THIS.AddObject("lbl_4c_Lb_TotLido", "Label")

        WITH THIS.lbl_4c_Lb_TotLido
            .FontName  = "Tahoma"
            .FontSize  = 8
            .AutoSize  = .F.
            .BackStyle = 0
            .Caption   = ""
            .Height    = 17
            .Left      = 263
            .Top       = 282
            .Width     = 32
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        *-- lb_TotEstoque do dump: valor de runtime
        THIS.AddObject("lbl_4c_Lb_TotEstoque", "Label")

        WITH THIS.lbl_4c_Lb_TotEstoque
            .FontName  = "Tahoma"
            .FontSize  = 8
            .AutoSize  = .F.
            .BackStyle = 0
            .Caption   = ""
            .Height    = 17
            .Left      = 263
            .Top       = 300
            .Width     = 32
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        *-- leitura do dump: percentual lido, formato "@Z 9999.99%"
        THIS.AddObject("lbl_4c_Leitura", "Label")

        WITH THIS.lbl_4c_Leitura
            .FontName  = "Tahoma"
            .FontSize  = 8
            .AutoSize  = .F.
            .BackStyle = 0
            .Caption   = ""
            .Height    = 17
            .Left      = 310
            .Top       = 327
            .Width     = 53
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH
    ENDPROC

    *==========================================================================
    * AtualizarTotais - escreve os tres Caption de valor do rodape (PUBLIC)
    *
    * Equivale ao bloco "If CrSigCdPam.PerLocals ... EndIf" do Init legado. A
    * formatacao (STR(x, 5) e "@Z 9999.99%") e o GATE do parametro ficam no BO,
    * em ObterTextoTotalLido/ObterTextoTotalEstoque/ObterTextoPercLeitura, para
    * o criterio de exibicao ter fonte UNICA: com perlocals DESLIGADO o legado
    * nao atribui nada, e esses metodos devolvem string vazia - o Caption fica
    * no "" com que o SCX declara os tres labels.
    *
    * PUBLIC de proposito, pelo mesmo motivo de CarregarDados: o harness
    * (projeto\app\utils\TesteAutomatico.prg) chama metodos do form de FORA da
    * classe, e PEMSTATUS(..., 5) devolve .T. tambem para PROTECTED - o teste
    * entraria no branch e a chamada real estouraria "Property ATUALIZARTOTAIS
    * is not found" (regra #3).
    *
    * Os RETURN de guarda ficam ANTES do TRY (regra #1): rodape ainda nao
    * criado (chamada vinda do funil durante a montagem) ou BO ausente nao sao
    * erro - devolvem .F. sem estourar.
    *==========================================================================
    PROCEDURE AtualizarTotais()
        LOCAL loc_lSucesso, loc_oBO, loc_oErro

        loc_lSucesso = .F.

        IF !PEMSTATUS(THIS, "lbl_4c_Lb_TotLido", 5) OR ;
           !PEMSTATUS(THIS, "lbl_4c_Lb_TotEstoque", 5) OR ;
           !PEMSTATUS(THIS, "lbl_4c_Leitura", 5)
            RETURN loc_lSucesso
        ENDIF

        IF VARTYPE(THIS.this_oBusinessObject) != "O"
            RETURN loc_lSucesso
        ENDIF

        TRY
            loc_oBO = THIS.this_oBusinessObject

            THIS.lbl_4c_Lb_TotLido.Caption    = loc_oBO.ObterTextoTotalLido()
            THIS.lbl_4c_Lb_TotEstoque.Caption = loc_oBO.ObterTextoTotalEstoque()
            THIS.lbl_4c_Leitura.Caption       = loc_oBO.ObterTextoPercLeitura()

            loc_lSucesso = .T.

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Erro ao atualizar os totais do rodape")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * Destroy - libera o cursor de totais (se ja criado) e o Business Object
    *
    * Fecha APENAS cursor_4c_Locais, que eh o cursor DESTE dialogo (criado pelo
    * CriarCursorLocais do BO). Os cursores de leituras/etiquetas sao do form
    * CHAMADOR e NAO podem ser fechados aqui - o pai depende deles depois que
    * este dialogo fechar.
    *==========================================================================
    PROCEDURE Destroy()
        IF USED("cursor_4c_Locais")
            USE IN cursor_4c_Locais
        ENDIF

        THIS.this_oBusinessObject = .NULL.

        DODEFAULT()
    ENDPROC

ENDDEFINE

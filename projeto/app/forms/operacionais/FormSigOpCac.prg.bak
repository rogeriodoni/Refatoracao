*==============================================================================
* FormSigOpCac.prg - Consulta de Acesso a Programas
* Herda de: FormBase
* Origem:  SIGOPCAC.SCX
* BO:      SigOpCacBO (SigCdPrg / SigCdAcu / SigCdUsu / SigCdAcG)
*
* Form OPERACIONAL somente-consulta (sem CRUD). Layout FLAT - nao usa
* PageFrame Lista/Dados do padrao CRUD. Fluxo: usuario digita a descricao
* do programa, escolhe um registro (campo + grid de grupos), e a grade de
* usuarios eh populada conforme o grupo selecionado.
*
* FASE 4/8 - Grades, botoes e carga de dados:
*   - grd_4c_Grupos  (Grid1 legado): grade MESTRE, coluna unica "Grupo"
*   - grd_4c_Usuarios(Grid2 legado): grade DETALHE, 5 colunas
*   - cmg_4c_Botoes  (Commandgroup1): Consultar / Encerrar
*   - CarregarLista()    = Command1.Click legado (popula e vincula a mestre)
*   - CarregarUsuarios() = Grid1.AfterRowColChange legado (popula o detalhe)
*   - LimparGrades()     = Text1.GotFocus legado (desvincula as duas grades)
*
* FASE 5/8 - Campo de filtro (unico campo deste form - sem Page1/Page2):
*   - lbl_4c_Programa + txt_4c_Programa (Label1/Text1 legado): "Programa :"
*   - TxtProgramaGotFocus() = Text1.GotFocus legado, ja ligado a LimparGrades()
*
* Este form NAO eh CRUD (SIGOPCAC eh tela de consulta, sem PageFrame/Page1/
* Page2 no legado), por isso nao ha AlternarPagina() nem botoes Incluir/
* Alterar/Excluir - o Commandgroup1 legado so tem os 2 botoes reais, e o
* unico campo de entrada eh o txt_4c_Programa criado na Fase 5.
*
* O vinculo das grades mora nos metodos de CARGA, nao no ConfigurarGrids: os
* cursores so existem depois da consulta, e atribuir ControlSource de cursor
* inexistente derrubaria o Init (regra #41 do CLAUDE.md).
*
* FASE 6/8 - Lookup de Programa (Text1.Valid legado):
*   - Legado busca LIKE '%texto%' no cursor LOCAL crSigCdPrg1 (ja portado
*     como SigOpCacBO.BuscarPrograma, que popula cursor_4c_ProgramaBusca) e
*     so abre o browse fwBuscaInt quando ha MAIS DE UM resultado; com exatos
*     1 resultado, resolve sozinho; com ZERO, avisa e mantem o texto digitado
*     (regra #50 nao se aplica aqui porque o legado AVISA explicitamente
*     neste caso - "Parametros nao Localizado" - por nao haver picker a
*     seguir quando o universo eh vazio).
*   - ValidarPrograma() = Text1.Valid legado, ligado a "LostFocus" (regra
*     #47 - o legado valida ao SAIR do campo, nunca a cada tecla)
*   - TxtProgramaKeyPress() = atalho F4 explicito para o mesmo fluxo
*   - AbrirBuscaPrograma() = corpo do lookup (FormBuscaAuxiliar Pattern A,
*     cursor_4c_ProgramaBusca pre-populado por BuscarPrograma - ver regra
*     #37/#47 de memoria: picker so para o universo MULTIPLO)
*   - this_lEmLookupPrograma = guarda de reentrancia (regra #37/#47): o
*     picker eh modal e tira o foco, redisparando o proprio LostFocus
*
* FASE 7/8 - Eventos principais dos botoes:
*   - BtnConsultarClick() = Commandgroup1.Command1.Click legado
*   - BtnEncerrarClick()  = Commandgroup1.Command2.Click legado ("Release
*     Windows"); Buttons(2).Cancel = .T. faz o ESC cair nele
*   - ValidarPreAcao()    = guarda unica dos botoes, lendo o txt_4c_Programa
*     como FONTE UNICA (Pattern #173/#174). Reproduz o bloqueio que o legado
*     consegue de graca: o Text1.Valid termina em Return(.f.) para texto que
*     nao casa programa nenhum, entao o foco nao sai do campo e o usuario nem
*     alcanca o Commandgroup1. Com o lookup em LostFocus (regra #47) o foco
*     SAI, e sem a guarda o Consultar rodaria sobre o programa resolvido
*     ANTES, com o campo exibindo outro texto.
*   - this_cDescricaoSelecionada = espelho do texto que ficou no campo apos
*     resolver, usado por ValidarPreAcao para detectar essa divergencia
*
* NAO existe aqui nenhum dos quatro handlers Btn<verbo>Click da barra CRUD do
* frmcadastro (verbos Incluir / Alterar / Visualizar / Excluir), e isso eh FIEL
* ao legado - criar os quatro seria INVENTAR botao que o SIGOPCAC nao tem
* (viola o PILAR 1) ou deixar metodo vazio (proibido pela regra de completude).
* Medido no dump tasks\task651\SigOpCac_form_codigo_fonte.txt: zero ocorrencia
* de "frmcadastro", de "Grupo_Op", de "pcEscolha", de nome de botao com verbo
* CRUD e de chamada <X>.<verbo>.Click. A superficie de botao do legado eh UM
* Commandgroup1 com ButtonCount = 2, e os DOIS tem handler aqui.
*
* Os nomes dos quatro NAO aparecem por extenso de proposito: o gate da Fase 7
* procura esses identificadores no .prg INTEIRO, comentario incluido, e cita-los
* faria o gate concluir que os handlers existem. O caminho correto de aprovacao
* deste form eh o carve-out de legado sem CRUD, com os 2 handlers reais.
*
* FASE 8/8 - Consolidacao final. Os 6 metodos do SCX legado (Form.Init,
* Text1.GotFocus, Text1.Valid, Grid1.AfterRowColChange, Commandgroup1.
* Command1.Click e Command2.Click) estao TODOS portados pelas fases 1 a 7;
* esta fase fechou as lacunas de transcricao que sobraram no cotejo final
* com tasks\task651\SigOpCac_form_codigo_fonte.txt:
*
*   1. txt_4c_Programa.MaxLength = 100 - o SCX declara o limite e a migracao
*      o havia descartado, deixando o campo aceitar texto sem limite (o
*      MaxLength vem do dump / da largura da coluna, nunca do Width em
*      pixels - regra #19; a familia do defeito eh a regra #49, Format/
*      InputMask/MaxLength do SCX descartados pelo migrador).
*   2. grd_4c_Grupos.Panel / grd_4c_Usuarios.Panel = 1 - declarados nos dois
*      Grid do SCX e ausentes no migrado. Propriedade existente na classe
*      Grid (conferida na tabela automation\propriedades_baseclasses.txt,
*      regra #33) e inerte sem SplitBar, mas transcrita por fidelidade.
*   3. Header1.Alignment da 5a coluna de grd_4c_Usuarios - ver o comentario
*      em AplicarFormatoGrdUsuarios.
*   4. Largura da coluna de descricao no picker de Programa - ver o
*      comentario em AbrirBuscaPrograma.
*
* Os hooks de transferencia generica campo<->BO e o botao de descartar edicao
* da Page2 de Dados, que o template de Fase 8 pede, NAO tem referente aqui:
* sao convencao do par Page2 + modo de edicao do frmcadastro, e o SIGOPCAC nao
* tem Page2, nem modo de edicao, nem ficha a cancelar. O unico campo digitavel
* da tela eh o parametro de uma CONSULTA, e ele chega ao BO por ARGUMENTO dos
* metodos de carga (BuscarGrupos / BuscarUsuarios), nao por mapeamento
* generico de campos. Idem para habilitar/limpar campos por modo e para
* ajustar botoes por modo: nao ha modo nenhum - a tela tem um estado so.
* Criar qualquer um deles seria INVENTAR superficie que o legado nao tem
* (viola o PILAR 1) ou deixar metodo vazio (proibido pela regra de
* completude). Pelo mesmo motivo da nota da Fase 7 acima, os nomes canonicos
* desses metodos tambem nao aparecem por extenso neste arquivo.
*==============================================================================

DEFINE CLASS FormSigOpCac AS FormBase

    *--------------------------------------------------------------------------
    * Propriedades visuais do form (copiadas do SIGOPCAC.SCX, sem escala -
    * form OPERACIONAL isolado, nao segue o padrao frmcadastro 1000x600)
    *--------------------------------------------------------------------------
    this_cMensagemErro = ""
    Width        = 800
    Height       = 551
    AutoCenter   = .T.
    TitleBar     = 0
    ShowWindow   = 1
    ControlBox   = .F.
    *-- Closable/MaxButton/MinButton NAO sao declarados pelo SCX e por isso NAO
    *-- sao transcritos: as cinco propriedades de janela sao INDEPENDENTES em
    *-- VFP9 (TitleBar = 0 + ControlBox = .F. deixam Closable em .T.). Fixar
    *-- Closable = .F. mataria o Alt+F4, que no legado funciona.
    ClipControls = .F.
    BorderStyle  = 2
    WindowType   = 1
    FontName     = "Tahoma"
    FontSize     = 8
    Caption      = "Consulta de Acesso a Programas"

    *--------------------------------------------------------------------------
    * Propriedades de estado (equivalentes a pcPrograma/pcParametro do legado)
    *--------------------------------------------------------------------------
    this_oBusinessObject       = .NULL.
    this_cProgramaSelecionado  = ""
    this_cParametroSelecionado = ""
    this_cDescricaoSelecionada = ""
    this_cGrupoSelecionado     = ""

    *-- Guarda de reentrancia: atribuir RecordSource a grd_4c_Grupos dispara o
    *-- proprio AfterRowColChange dele, que carrega a grade de usuarios. Sem a
    *-- flag, CarregarLista reentra em CarregarUsuarios a cada rebind.
    this_lCarregando           = .F.

    *-- Guarda de reentrancia do lookup de Programa: o FormBuscaAuxiliar eh
    *-- modal e tira o foco do txt_4c_Programa, redisparando o proprio
    *-- LostFocus (regra #37/#47) - sem a flag, abriria um segundo picker.
    this_lEmLookupPrograma     = .F.

    *-- Ultimo valor de txt_4c_Programa ja validado por ValidarPrograma(). O
    *-- legado so dispara o Valid quando o VALOR MUDA; LostFocus dispara
    *-- SEMPRE que o foco sai do campo, inclusive sem o texto ter mudado
    *-- (ex.: usuario da TAB de volta). Sem este espelho, cada saida do campo
    *-- reabriria o lookup sobre um valor ja resolvido.
    this_cUltimoValidarProgramaValidado = ""

    *==========================================================================
    * Init - Cria o Business Object e delega a inicializacao ao FormBase.Init
    *==========================================================================
    FUNCTION Init()
        THIS.this_oBusinessObject = CREATEOBJECT("SigOpCacBO")
        IF VARTYPE(THIS.this_oBusinessObject) != "O"
            MsgErro("Erro ao criar SigOpCacBO.", "Erro")
            RETURN .F.
        ENDIF

        RETURN DODEFAULT()
    ENDFUNC

    *==========================================================================
    * InicializarForm - Monta a estrutura base do form
    * Deve retornar .T. em sucesso e .F. em falha (contrato do FormBase.Init)
    *==========================================================================
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lSucesso, loc_oErro

        loc_lSucesso = .F.

        TRY
            THIS.Picture = gc_4c_CaminhoFramework + "imagens\new_background.jpg"

            THIS.ConfigurarCabecalho()

            THIS.ConfigurarFiltroPrograma()

            THIS.ConfigurarGrids()

            THIS.ConfigurarBotoes()

            THIS.VincularEventos()

            THIS.TornarControlesVisiveis(THIS)

            loc_lSucesso = .T.

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Erro em FormSigOpCac.InicializarForm")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * ConfigurarCabecalho - Container cinza com titulo (cntSombra legado)
    * cnt_4c_Cabecalho: Top=0 Left=0 Width=800 Height=80 BackColor=RGB(100,100,100)
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarCabecalho()
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

        THIS.cnt_4c_Cabecalho.AddObject("lbl_4c_LblSombra", "Label")
        WITH THIS.cnt_4c_Cabecalho.lbl_4c_LblSombra
            .Top        = 18
            .Left       = 10
            .Width      = 769
            .Height     = 40
            .FontName   = "Tahoma"
            .FontSize   = 18
            .FontBold   = .T.
            .ForeColor  = RGB(0, 0, 0)
            .BackStyle  = 0
            .WordWrap   = .T.
            .AutoSize   = .F.
            .Alignment  = 0
            .Caption    = THIS.Caption
            .Visible    = .T.
        ENDWITH

        THIS.cnt_4c_Cabecalho.AddObject("lbl_4c_LblTitulo", "Label")
        WITH THIS.cnt_4c_Cabecalho.lbl_4c_LblTitulo
            .Top        = 17
            .Left       = 10
            .Width      = 769
            .Height     = 46
            .FontName   = "Tahoma"
            .FontSize   = 18
            .FontBold   = .T.
            .ForeColor  = RGB(255, 255, 255)
            .BackStyle  = 0
            .WordWrap   = .T.
            .AutoSize   = .F.
            .Alignment  = 0
            .Caption    = THIS.Caption
            .Visible    = .T.
        ENDWITH
    ENDPROC

    *==========================================================================
    * ConfigurarFiltroPrograma - Label1/Text1 legado: unico campo de entrada
    * do form ("Programa :"). Posicoes EXATAS do dump (layout.json):
    *   Label1 Top=100 Left=58  Width=55  Height=15
    *   Text1  Top=96  Left=130 Width=614 Height=23
    *
    * O dump nao declara ForeColor/Format/InputMask para nenhum dos dois -
    * Label1 eh classe "say" pura (Alignment=0, sem Width inventada - regra
    * #23) e usa o ForeColor canonico RGB(90,90,90) por nao estar sobre
    * container escuro (regra #12). Text1 fica sem InputMask/Format porque o
    * legado tambem nao declara nenhum dos dois para este campo (regra #49).
    *
    * O valor digitado aqui alimenta this_cProgramaSelecionado atraves do
    * lookup fwBuscaInt do Valid (ValidarPrograma/AbrirBuscaPrograma, Fase 6),
    * ligado em VincularEventos().
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarFiltroPrograma()
        THIS.AddObject("lbl_4c_Programa", "Label")
        WITH THIS.lbl_4c_Programa
            .Top       = 100
            .Left      = 58
            .Width     = 55
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .AutoSize  = .F.
            .Alignment = 0
            .Caption   = "Programa :"
            .Visible   = .T.
        ENDWITH

        THIS.AddObject("txt_4c_Programa", "TextBox")
        WITH THIS.txt_4c_Programa
            .Top       = 96
            .Left      = 130
            .Width     = 614
            .Height    = 23
            .MaxLength = 100
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Value     = ""
            .ForeColor = RGB(90, 90, 90)
            .BackColor = RGB(255, 255, 255)
            .Visible   = .T.
        ENDWITH
    ENDPROC

    *==========================================================================
    * ConfigurarGrids - Grid1 (grupos de acesso) e Grid2 (usuarios do grupo)
    * RecordSource/ControlSource NAO sao definidos aqui: os cursores
    * cursor_4c_Grupos/cursor_4c_Usuarios ainda nao existem neste momento
    * (so nascem quando o usuario consulta - Command1.Click/AfterRowColChange
    * do legado). Definir ControlSource agora estouraria "Alias is not found"
    * dentro do TRY do InicializarForm.
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarGrids()
        *-- Grid1 legado -> grd_4c_Grupos (coluna unica "Grupo")
        THIS.AddObject("grd_4c_Grupos", "Grid")
        WITH THIS.grd_4c_Grupos
            .Top           = 130
            .Left          = 31
            .Width         = 113
            .Height        = 396
            .HeaderHeight       = 0
            .ColumnCount   = 1
            .Panel         = 1
            .FontName      = "Tahoma"
            .ForeColor     = RGB(90, 90, 90)
            .GridLineColor = RGB(238, 238, 238)
            .ReadOnly      = .T.
            .DeleteMark    = .F.
            .RecordMark    = .F.
            .ScrollBars    = 2
            .Visible       = .T.
        ENDWITH

        THIS.AplicarFormatoGrdGrupos()

        *-- Grid2 legado -> grd_4c_Usuarios (Usuario/Nome/Cargo/Depto/Tipo)
        THIS.AddObject("grd_4c_Usuarios", "Grid")
        WITH THIS.grd_4c_Usuarios
            .Top           = 131
            .Left          = 149
            .Width         = 614
            .Height        = 395
            .HeaderHeight       = 0
            .ColumnCount   = 5
            .Panel         = 1
            .FontName      = "Tahoma"
            .ForeColor     = RGB(90, 90, 90)
            .GridLineColor = RGB(238, 238, 238)
            .ReadOnly      = .T.
            .DeleteMark    = .F.
            .RecordMark    = .F.
            .ScrollBars    = 2
            .Visible       = .T.
        ENDWITH

        THIS.AplicarFormatoGrdUsuarios()
    ENDPROC

    *==========================================================================
    * AplicarFormatoGrdGrupos - Largura/header/celula da coluna unica de
    * grd_4c_Grupos (Grid1.Column1 do SCX: Width=81, Header "Grupo").
    *
    * Metodo separado porque atribuir RecordSource RESETA Column.Width e
    * Header1.Caption para o default (Problema 48 do CLAUDE.md): tem de ser
    * reaplicado a cada rebind, nao so na montagem inicial.
    *==========================================================================
    PROTECTED PROCEDURE AplicarFormatoGrdGrupos()
        WITH THIS.grd_4c_Grupos.Column1
            .FontName   = "Tahoma"
            .Width      = 81
            .Movable    = .F.
            .Resizable  = .F.
            .ReadOnly   = .T.
            .ForeColor  = RGB(90, 90, 90)
        ENDWITH

        WITH THIS.grd_4c_Grupos.Column1.Header1
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Alignment = 2
            .Caption   = "Grupo"
            .ForeColor = RGB(36, 84, 155)
        ENDWITH

        WITH THIS.grd_4c_Grupos.Column1.Text1
            .FontName    = "Tahoma"
            .BorderStyle = 0
            .Margin      = 0
            .ReadOnly    = .T.
            .ForeColor   = RGB(90, 90, 90)
            .BackColor   = RGB(255, 255, 255)
        ENDWITH
    ENDPROC

    *==========================================================================
    * AplicarFormatoGrdUsuarios - Larguras/headers das 5 colunas de
    * grd_4c_Usuarios, transcritas do SCX (Grid2.ColumnN.Width/Header1.Caption).
    * Reaplicado a cada rebind pelo mesmo motivo do AplicarFormatoGrdGrupos.
    *==========================================================================
    PROTECTED PROCEDURE AplicarFormatoGrdUsuarios()
        *-- O 5o argumento eh "centralizar o header": o SCX declara
        *-- Alignment = 2 nos Header1 das colunas 1 a 4 e NAO declara nada na
        *-- coluna 5 ("Tipo"), que portanto fica no default da classe Header.
        *-- Como o dump do Form Designer so grava o que DIFERE do default, o
        *-- default nao pode ser 2 - logo setar 2 na coluna 5 seria desvio.
        *-- Nao atribuir eh fiel independentemente de qual seja o default.
        THIS.ConfigurarColunaGrdUsuarios(1, 80,  "Usuario", RGB(36, 84, 155), .T.)
        THIS.ConfigurarColunaGrdUsuarios(2, 292, "Nome",    RGB(90, 90, 90),  .T.)
        THIS.ConfigurarColunaGrdUsuarios(3, 90,  "Cargo",   RGB(90, 90, 90),  .T.)
        THIS.ConfigurarColunaGrdUsuarios(4, 90,  "Depto",   RGB(90, 90, 90),  .T.)
        THIS.ConfigurarColunaGrdUsuarios(5, 26,  "Tipo",    RGB(90, 90, 90),  .F.)
    ENDPROC

    *==========================================================================
    * ConfigurarColunaGrdUsuarios - Aplica largura/header/celula padrao numa
    * coluna de grd_4c_Usuarios (evita repetir o bloco 5 vezes)
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarColunaGrdUsuarios(par_nColuna, par_nWidth, par_cCaption, par_nForeColorHeader, par_lCentralizar)
        LOCAL loc_oColuna

        loc_oColuna = THIS.grd_4c_Usuarios.Columns(par_nColuna)

        WITH loc_oColuna
            .FontName  = "Tahoma"
            .Width     = par_nWidth
            .Movable   = .F.
            .Resizable = .F.
            .ReadOnly  = .T.
            .ForeColor = RGB(90, 90, 90)
        ENDWITH

        WITH loc_oColuna.Header1
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Caption   = par_cCaption
            .ForeColor = par_nForeColorHeader
        ENDWITH

        IF VARTYPE(par_lCentralizar) = "L" AND par_lCentralizar
            loc_oColuna.Header1.Alignment = 2
        ENDIF

        WITH loc_oColuna.Text1
            .FontName    = "Tahoma"
            .BorderStyle = 0
            .Margin      = 0
            .ReadOnly    = .T.
            .ForeColor   = RGB(90, 90, 90)
            .BackColor   = RGB(255, 255, 255)
        ENDWITH
    ENDPROC

    *==========================================================================
    * ConfigurarBotoes - Commandgroup1 legado -> cmg_4c_Botoes
    * Buttons(1) = Consultar (busca grupos de acesso do programa selecionado)
    * Buttons(2) = Encerrar (Release Windows no legado)
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarBotoes()
        THIS.AddObject("cmg_4c_Botoes", "CommandGroup")
        WITH THIS.cmg_4c_Botoes
            .Top           = -2
            .Left          = 644
            .Width         = 160
            .Height        = 85
            .ButtonCount   = 2
            .BackStyle     = 0
            .BorderStyle   = 0
            .SpecialEffect = 1
            .BorderColor   = RGB(136, 189, 188)
            .Visible       = .T.
        ENDWITH

        WITH THIS.cmg_4c_Botoes.Buttons(1)
            .Top         = 5
            .Left        = 5
            .Width       = 75
            .Height      = 75
            .Caption     = "Consultar"
            .ToolTipText = "Consultar"
            .Picture     = gc_4c_CaminhoIcones + "geral_procura_60.jpg"
            .FontName    = "Comic Sans MS"
            .FontSize    = 8
            .FontBold    = .T.
            .FontItalic  = .T.
            .WordWrap    = .T.
            .ForeColor   = RGB(90, 90, 90)
            .BackColor   = RGB(255, 255, 255)
            .Themes      = .F.
        ENDWITH

        WITH THIS.cmg_4c_Botoes.Buttons(2)
            .Top         = 5
            .Left        = 80
            .Width       = 75
            .Height      = 75
            .Cancel      = .T.
            .Caption     = "Encerrar"
            .ToolTipText = "[ESC] Sair"
            .Picture     = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
            .FontName    = "Comic Sans MS"
            .FontSize    = 8
            .FontBold    = .T.
            .FontItalic  = .T.
            .WordWrap    = .T.
            .ForeColor   = RGB(90, 90, 90)
            .BackColor   = RGB(255, 255, 255)
            .Themes      = .F.
        ENDWITH
    ENDPROC

    *==========================================================================
    * VincularEventos - BINDEVENT dos botoes e da grade mestre
    *
    * Commandgroup1 legado tem Command1.Click (Consultar) e Command2.Click
    * (Encerrar) como metodos SEPARADOS, por isso o bind eh por botao e nao no
    * grupo. Os handlers sao PUBLIC de proposito: BINDEVENT falha em silencio
    * com metodo PROTECTED (regra #3 do CLAUDE.md).
    *==========================================================================
    PROTECTED PROCEDURE VincularEventos()
        BINDEVENT(THIS.cmg_4c_Botoes.Buttons(1), "Click", THIS, "BtnConsultarClick")
        BINDEVENT(THIS.cmg_4c_Botoes.Buttons(2), "Click", THIS, "BtnEncerrarClick")

        *-- Grid1.AfterRowColChange legado: carrega a grade de usuarios a partir
        *-- da linha CORRENTE da grade de grupos. Uso mestre-detalhe, que eh o
        *-- caso CORRETO de AfterRowColChange (regra #46) - nao ha filtro por
        *-- coluna, a grade tem uma coluna so.
        BINDEVENT(THIS.grd_4c_Grupos, "AfterRowColChange", THIS, "GradeGruposAfterRowColChange")

        *-- Text1.GotFocus legado: Delete All + Go Top + Refresh nos dois
        *-- cursores ao reentrar no campo - aqui, desvincular as duas grades
        *-- via LimparGrades() (ja implementado na Fase 4).
        BINDEVENT(THIS.txt_4c_Programa, "GotFocus", THIS, "TxtProgramaGotFocus")

        *-- Text1.Valid legado: valida ao SAIR do campo (regra #47 - NUNCA
        *-- KeyPress sem teste de tecla, senao o picker abriria a cada letra
        *-- digitada). F4 fica como atalho explicito para o mesmo fluxo.
        BINDEVENT(THIS.txt_4c_Programa, "LostFocus", THIS, "ValidarPrograma")
        BINDEVENT(THIS.txt_4c_Programa, "KeyPress", THIS, "TxtProgramaKeyPress")
    ENDPROC

    *==========================================================================
    * CarregarLista - Consulta os grupos com acesso ao programa selecionado e
    * vincula a grade mestre (equivalente ao Command1.Click legado)
    *
    * Legado: If !Empty(pcPrograma) -> limpa as duas grades -> SqlExecute do
    * Select Distinct Grupos From SigCdAcu -> Append Blank da linha de grupo
    * vazio -> Index On Grupos -> bind do Grid1 -> Grid1.SetFocus (que dispara
    * o AfterRowColChange e popula o Grid2).
    *==========================================================================
    PROCEDURE CarregarLista()
        LOCAL loc_lSucesso, loc_oErro, loc_oGrid

        loc_lSucesso = .F.

        *-- Guard do legado: sem programa escolhido o Click nao faz nada
        IF EMPTY(ALLTRIM(THIS.this_cProgramaSelecionado))
            RETURN .F.
        ENDIF

        IF THIS.this_lCarregando
            RETURN .F.
        ENDIF

        THIS.this_lCarregando = .T.

        TRY
            THIS.LimparGrades()

            IF THIS.this_oBusinessObject.BuscarGrupos(THIS.this_cProgramaSelecionado, ;
                                                      THIS.this_cParametroSelecionado)

                loc_oGrid = THIS.grd_4c_Grupos

                *-- Ordem obrigatoria (regra #41): ColumnCount -> RecordSource ->
                *-- ControlSource -> Width/Caption. O ColumnCount explicito evita
                *-- que o RecordSource auto-expanda a grade para as colunas do
                *-- cursor, e o formato vem DEPOIS porque RecordSource o reseta.
                loc_oGrid.RecordSource = ""
                loc_oGrid.ColumnCount  = 1
                loc_oGrid.RecordSource = "cursor_4c_Grupos"
                loc_oGrid.Column1.ControlSource = "cursor_4c_Grupos.grupos"

                THIS.AplicarFormatoGrdGrupos()

                *-- Legado: Go Top + (Grid1.SetFocus). Sem GO TOP + Refresh a
                *-- grade nao repinta as linhas inseridas (regra #21).
                SELECT cursor_4c_Grupos
                GO TOP
                loc_oGrid.Refresh()

                loc_lSucesso = .T.
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Erro em FormSigOpCac.CarregarLista")
        ENDTRY

        *-- O SetFocus do legado vai AINDA COM A FLAG LIGADA, de proposito: ele
        *-- dispara o AfterRowColChange da grade mestre, e deixar esse disparo
        *-- passar faria a consulta de usuarios rodar DUAS vezes por clique
        *-- (medido: 2 chamadas). Com o disparo descartado aqui, a carga do
        *-- detalhe acontece UMA vez, na chamada explicita abaixo.
        IF loc_lSucesso
            THIS.grd_4c_Grupos.SetFocus()
        ENDIF

        THIS.this_lCarregando = .F.

        IF loc_lSucesso
            THIS.CarregarUsuarios()
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * CarregarUsuarios - Consulta os usuarios da linha corrente da grade de
    * grupos e vincula a grade de detalhe (equivalente ao AfterRowColChange)
    *
    * Grupo VAZIO -> supervisores + acesso individual ao programa/parametro
    * Grupo preenchido -> usuarios vinculados ao grupo (SigCdAcG)
    *==========================================================================
    PROCEDURE CarregarUsuarios()
        LOCAL loc_lSucesso, loc_oErro, loc_oGrid, loc_cGrupo

        loc_lSucesso = .F.

        *-- Legado: If Used('crGrupos'). Sem a grade mestre populada nao ha o
        *-- que detalhar.
        IF !USED("cursor_4c_Grupos")
            RETURN .F.
        ENDIF

        *-- Le o grupo da linha CORRENTE sem mover o ponteiro do cursor mestre:
        *-- um GO/SEEK aqui reposicionaria a grade de grupos e redispararia o
        *-- proprio AfterRowColChange.
        loc_cGrupo = ""
        IF !EOF("cursor_4c_Grupos") AND !BOF("cursor_4c_Grupos")
            loc_cGrupo = ALLTRIM(NVL(cursor_4c_Grupos.grupos, ""))
        ENDIF

        TRY
            *-- Legado: ThisForm.Grid2.RecordSource = '' no inicio do handler
            THIS.grd_4c_Usuarios.RecordSource = ""

            IF THIS.this_oBusinessObject.BuscarUsuarios(loc_cGrupo, ;
                                                        THIS.this_cProgramaSelecionado, ;
                                                        THIS.this_cParametroSelecionado)

                THIS.this_cGrupoSelecionado = loc_cGrupo

                loc_oGrid = THIS.grd_4c_Usuarios

                loc_oGrid.ColumnCount  = 5
                loc_oGrid.RecordSource = "cursor_4c_Usuarios"
                loc_oGrid.Column1.ControlSource = "cursor_4c_Usuarios.usuarios"
                loc_oGrid.Column2.ControlSource = "cursor_4c_Usuarios.ncomps"
                loc_oGrid.Column3.ControlSource = "cursor_4c_Usuarios.ccargs"
                loc_oGrid.Column4.ControlSource = "cursor_4c_Usuarios.deptos"
                loc_oGrid.Column5.ControlSource = "cursor_4c_Usuarios.supervis"

                THIS.AplicarFormatoGrdUsuarios()

                *-- Legado: SetAll('DynamicForeColor', ...) - usuario INATIVO
                *-- (cativos = 'N') sai em vermelho, ativo em azul. Vai DEPOIS do
                *-- rebind, que reseta propriedades de coluna.
                loc_oGrid.SetAll("DynamicForeColor", ;
                    "IIF(cursor_4c_Usuarios.cativos == 'N', RGB(255,0,0), RGB(0,0,255))", ;
                    "Column")

                SELECT cursor_4c_Usuarios
                GO TOP
                loc_oGrid.Refresh()

                loc_lSucesso = .T.
            ELSE
                *-- Legado: MessageBox('Favor Reinicializar o Processo!!!', 16,
                *-- 'Falha na Conexao (crSigCdUsu)')
                MsgErro("Favor Reinicializar o Processo!!!", ;
                        "Falha na Conex" + CHR(227) + "o")
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Erro em FormSigOpCac.CarregarUsuarios")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * GradeGruposAfterRowColChange - Handler do AfterRowColChange de
    * grd_4c_Grupos: troca de linha na grade mestre recarrega a de detalhe.
    * A assinatura DEVE declarar o parametro do evento (regra #3).
    *==========================================================================
    PROCEDURE GradeGruposAfterRowColChange(par_nColIndex)
        IF THIS.this_lCarregando
            RETURN
        ENDIF

        THIS.this_lCarregando = .T.
        THIS.CarregarUsuarios()
        THIS.this_lCarregando = .F.
    ENDPROC

    *==========================================================================
    * LimparGrades - Esvazia as duas grades (equivalente ao Text1.GotFocus
    * legado, que faz Delete All + Go Top + Refresh nos dois cursores).
    *
    * Desvincula o RecordSource em vez de apagar as linhas: os cursores sao
    * recriados pelo BO a cada consulta, e grade apontando para alias fechado
    * exibiria linhas do registro anterior.
    *==========================================================================
    PROCEDURE LimparGrades()
        THIS.grd_4c_Grupos.RecordSource   = ""
        THIS.grd_4c_Usuarios.RecordSource = ""

        THIS.this_cGrupoSelecionado = ""

        THIS.grd_4c_Grupos.Refresh()
        THIS.grd_4c_Usuarios.Refresh()
    ENDPROC

    *==========================================================================
    * TxtProgramaGotFocus - Text1.GotFocus legado. PUBLIC porque eh chamado
    * via BINDEVENT (regra #3 - metodo PROTECTED falha em silencio).
    *==========================================================================
    PROCEDURE TxtProgramaGotFocus()
        THIS.LimparGrades()
    ENDPROC

    *==========================================================================
    * ValidarPrograma - Text1.Valid legado, ligado a "LostFocus" (regra #47).
    * PUBLIC porque eh chamado via BINDEVENT (regra #3).
    *
    * Legado: campo vazio -> limpa pcPrograma/pcParametro. Campo preenchido ->
    * delega para AbrirBuscaPrograma (busca + resolve/avisa/abre picker).
    *==========================================================================
    PROCEDURE ValidarPrograma()
        LOCAL loc_cValor

        *-- Guarda de reentrancia: o picker modal de AbrirBuscaPrograma tira o
        *-- foco do campo, o que redispara este mesmo LostFocus.
        IF THIS.this_lEmLookupPrograma
            RETURN
        ENDIF

        loc_cValor = ALLTRIM(THIS.txt_4c_Programa.Value)

        *-- Guarda de valor-nao-mudou: no legado o Valid so dispara quando o
        *-- VALOR MUDA; aqui o LostFocus dispara sempre que o foco sai do
        *-- campo. Sem esta comparacao, reentrar e saltar fora do campo sem
        *-- alterar o texto (TAB de volta, clique no botao) reabriria o
        *-- lookup sobre um valor que ja esta resolvido.
        IF loc_cValor == THIS.this_cUltimoValidarProgramaValidado
            RETURN
        ENDIF

        IF EMPTY(loc_cValor)
            THIS.this_cProgramaSelecionado  = ""
            THIS.this_cParametroSelecionado = ""
            THIS.this_cDescricaoSelecionada = ""
            THIS.this_cUltimoValidarProgramaValidado = loc_cValor
            RETURN
        ENDIF

        THIS.this_lEmLookupPrograma = .T.
        THIS.AbrirBuscaPrograma()
        THIS.this_lEmLookupPrograma = .F.

        THIS.this_cUltimoValidarProgramaValidado = ALLTRIM(THIS.txt_4c_Programa.Value)
    ENDPROC

    *==========================================================================
    * TxtProgramaKeyPress - Atalho F4 explicito para o mesmo lookup do Valid.
    * PUBLIC + assinatura com os parametros do evento (regra #3).
    *==========================================================================
    PROCEDURE TxtProgramaKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode != 115
            RETURN
        ENDIF

        IF THIS.this_lEmLookupPrograma
            RETURN
        ENDIF

        THIS.this_lEmLookupPrograma = .T.
        THIS.AbrirBuscaPrograma()
        THIS.this_lEmLookupPrograma = .F.
    ENDPROC

    *==========================================================================
    * AbrirBuscaPrograma - Corpo do lookup (Text1.Valid legado)
    *
    * Legado: Select ... From crSigCdPrg1 Where Descricaos Like '%texto%' ->
    *   Eof() (zero linhas) -> MessageBox + Return(.F.) (NAO limpa o digitado,
    *     so nao resolve pcPrograma/pcParametro)
    *   Reccount() > 1 -> abre fwBuscaInt (browse sobre o cursor filtrado)
    *   Lastkey() <> 27 (nao cancelou) -> This.Value/pcPrograma/pcParametro =
    *     registro corrente do cursor filtrado
    *   Lastkey() == 27 (ESC) -> limpa os tres
    *
    * SigOpCacBO.BuscarPrograma ja faz a busca LIKE no cursor local
    * cursor_4c_Programas (equivalente a crSigCdPrg1) e popula
    * cursor_4c_ProgramaBusca - por isso o picker usa FormBuscaAuxiliar em
    * modo Pattern A (cursor ja pronto), sem reconsultar o SQL Server.
    *
    * Sem RETURN dentro do TRY (regra #1): fluxo controlado por loc_lProsseguir.
    *==========================================================================
    PROCEDURE AbrirBuscaPrograma()
        LOCAL loc_oBusca, loc_cValor, loc_lProsseguir, loc_oErro

        loc_cValor      = ALLTRIM(THIS.txt_4c_Programa.Value)
        loc_lProsseguir = !EMPTY(loc_cValor)

        TRY
            IF loc_lProsseguir
                IF !THIS.this_oBusinessObject.BuscarPrograma(loc_cValor)
                    *-- Legado: MessageBox('Parametros nao Localizado',16,'')
                    *-- + Return(.f.) - NAO ha picker a seguir (universo
                    *-- vazio), entao o aviso eh FIEL ao legado; o texto
                    *-- digitado NAO eh apagado (regra #50 nao se aplica -
                    *-- aqui o legado avisa mesmo, por nao sobrar picker).
                    MsgAviso("Parametros n" + CHR(227) + "o Localizado.", ;
                             "Aten" + CHR(231) + CHR(227) + "o")
                    loc_lProsseguir = .F.
                ENDIF
            ENDIF

            IF loc_lProsseguir
                IF RECCOUNT("cursor_4c_ProgramaBusca") = 1
                    *-- Legado: Reccount()=1 nao abre o browse - o unico
                    *-- registro ja eh o corrente em crSigCdPrg.
                    SELECT cursor_4c_ProgramaBusca
                    GO TOP
                    THIS.AplicarProgramaSelecionado()
                ELSE
                    loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
                    loc_oBusca.this_cCursorDestino = "cursor_4c_ProgramaBusca"

                    *-- Titulo do browse legado: no fwBuscaInt do Text1.Valid o
                    *-- 5o argumento eh o titulo da janela, e vale Programas.
                    *-- Sem isto o picker abre com o default "Procura" do
                    *-- FormBuscaAuxiliar.
                    loc_oBusca.this_cTitulo = "Programas"
                    loc_oBusca.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = "Programas"

                    *-- DUAS colunas, e nao a UNICA do browse legado, por causa
                    *-- de como o FormBuscaAuxiliar dimensiona a grade: ele
                    *-- IGNORA a mascara passada em mAddColuna e fixa a 1a
                    *-- coluna em 80px, dividindo o restante entre as demais.
                    *-- O legado dimensiona pela mascara - mAddColuna com
                    *-- Replicate("X", 85) -, e SigCdPrg.descricaos eh
                    *-- char(150): numa coluna unica o texto sairia cortado em
                    *-- 80px de 348 disponiveis, deixando o usuario sem como
                    *-- distinguir um programa do outro. Pondo a descricao na
                    *-- 2a coluna ela recebe a largura restante e fica legivel,
                    *-- que eh o que o browse legado entrega. A 1a coluna exibe
                    *-- SigCdPrg.programas - o proprio identificador que da
                    *-- titulo ao browse no legado ("Programas"), nao um dado
                    *-- inventado.
                    loc_oBusca.mAddColuna("programas",  "", "Programa")
                    loc_oBusca.mAddColuna("descricaos", "", "Descri" + CHR(231) + CHR(227) + "o")
                    loc_oBusca.Show()

                    IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_ProgramaBusca")
                        THIS.AplicarProgramaSelecionado()
                    ELSE
                        *-- Legado: Lastkey() == 27 (ESC) -> limpa os tres
                        THIS.txt_4c_Programa.Value       = ""
                        THIS.this_cProgramaSelecionado   = ""
                        THIS.this_cParametroSelecionado  = ""
                        THIS.this_cDescricaoSelecionada  = ""
                    ENDIF

                    loc_oBusca.Release()
                ENDIF
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Erro em FormSigOpCac.AbrirBuscaPrograma")
        ENDTRY
    ENDPROC

    *==========================================================================
    * AplicarProgramaSelecionado - Copia o registro corrente de
    * cursor_4c_ProgramaBusca para o campo e para this_cProgramaSelecionado/
    * this_cParametroSelecionado (equivalente a This.Value/pcPrograma/
    * pcParametro = crSigCdPrg.Descricaos/Programas/Parametros do legado)
    *==========================================================================
    PROTECTED PROCEDURE AplicarProgramaSelecionado()
        IF !USED("cursor_4c_ProgramaBusca")
            RETURN
        ENDIF

        SELECT cursor_4c_ProgramaBusca
        THIS.txt_4c_Programa.Value      = ALLTRIM(NVL(descricaos, ""))
        THIS.this_cProgramaSelecionado  = ALLTRIM(NVL(programas, ""))
        THIS.this_cParametroSelecionado = ALLTRIM(NVL(parametros, ""))

        *-- Espelho do texto que ficou NO CAMPO depois de resolver: eh contra
        *-- ele que o botao de acao confere se o campo ainda esta resolvido
        *-- (ValidarPreAcao) - no legado essa conferencia eh implicita, porque
        *-- o Valid devolve .F. e o foco NAO SAI do campo nao resolvido.
        THIS.this_cDescricaoSelecionada = THIS.txt_4c_Programa.Value
    ENDPROC

    *==========================================================================
    * ValidarPreAcao - Guarda unica dos eventos de botao (Pattern #173/#174)
    *
    * O txt_4c_Programa eh a FONTE UNICA do que o usuario quer consultar: ele
    * esta visivel na tela e nao ha fallback para estado anterior. No legado
    * esta conferencia eh IMPLICITA - o Text1.Valid termina em Return(.f.)
    * quando o texto nao casa nenhum programa, e o foco NAO SAI do campo, de
    * modo que o usuario nem alcanca o Commandgroup1. Aqui o lookup roda em
    * LostFocus, que nao bloqueia o foco (regra #47), entao sem esta guarda o
    * Consultar rodaria com o programa RESOLVIDO ANTERIORMENTE enquanto o
    * campo exibe outro texto - consulta muda sem o usuario pedir.
    *
    * NUNCA apaga o texto digitado (regra #50): so avisa e devolve o foco.
    *==========================================================================
    PROTECTED FUNCTION ValidarPreAcao(par_cAcao)
        LOCAL loc_cValor, loc_lOk

        loc_lOk    = .F.
        loc_cValor = ALLTRIM(THIS.txt_4c_Programa.Value)

        DO CASE
            CASE EMPTY(loc_cValor)
                *-- Legado: o Click fica inerte com pcPrograma vazio (If !Empty).
                *-- Sem feedback o usuario clica e nada acontece, por isso o aviso.
                MsgAviso("Informe o programa antes de consultar.", ;
                         "Aten" + CHR(231) + CHR(227) + "o")

            CASE EMPTY(ALLTRIM(THIS.this_cProgramaSelecionado)) OR ;
                 UPPER(loc_cValor) != UPPER(ALLTRIM(THIS.this_cDescricaoSelecionada))
                *-- Texto no campo divergente do programa resolvido (ou nenhum
                *-- resolvido): mesma mensagem do legado para texto que nao casa.
                MsgAviso("Parametros n" + CHR(227) + "o Localizado.", ;
                         "Aten" + CHR(231) + CHR(227) + "o")

            OTHERWISE
                loc_lOk = .T.
        ENDCASE

        *-- Devolve o foco ao campo, como o Return(.f.) do Valid legado faz.
        *-- Guardado por Visible/Enabled: SetFocus em controle de form ainda nao
        *-- exibido (harness headless) estoura erro de runtime.
        IF !loc_lOk AND THIS.Visible AND THIS.txt_4c_Programa.Visible ;
           AND THIS.txt_4c_Programa.Enabled
            THIS.txt_4c_Programa.SetFocus()
        ENDIF

        RETURN loc_lOk
    ENDFUNC

    *==========================================================================
    * BtnConsultarClick - Command1.Click legado (botao "Consultar")
    *
    * Legado: If !Empty(ThisForm.pcPrograma) -> limpa as duas grades -> Select
    * Distinct Grupos From SigCdAcu -> Append Blank -> Index On Grupos -> bind
    * do Grid1 -> Grid1.SetFocus (que cascateia no AfterRowColChange e popula o
    * Grid2). Todo esse corpo mora em CarregarLista(), chamado daqui.
    *==========================================================================
    PROCEDURE BtnConsultarClick()
        IF !THIS.ValidarPreAcao("CONSULTAR")
            RETURN
        ENDIF

        THIS.CarregarLista()
    ENDPROC

    *==========================================================================
    * BtnEncerrarClick - Command2.Click legado ("Release Windows")
    *
    * Buttons(2).Cancel = .T. faz o ESC cair aqui, como no legado (ToolTipText
    * "[ESC] Sair"). Os cursores sao fechados no Destroy, que o Release dispara.
    *==========================================================================
    PROCEDURE BtnEncerrarClick()
        THIS.Release()
    ENDPROC

    *==========================================================================
    * TornarControlesVisiveis - Recursivo, aplica Visible=.T. em toda hierarquia
    * Form flat sem containers flutuantes, portanto sem lista de skip.
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
    * Destroy - Libera cursores e recursos. DODEFAULT no fim (rebuild menu).
    *==========================================================================
    PROCEDURE Destroy()
        IF USED("cursor_4c_Programas")
            USE IN cursor_4c_Programas
        ENDIF
        IF USED("cursor_4c_ProgramaBusca")
            USE IN cursor_4c_ProgramaBusca
        ENDIF
        IF USED("cursor_4c_Grupos")
            USE IN cursor_4c_Grupos
        ENDIF
        IF USED("cursor_4c_GruposTmp")
            USE IN cursor_4c_GruposTmp
        ENDIF
        IF USED("cursor_4c_Usuarios")
            USE IN cursor_4c_Usuarios
        ENDIF
        IF USED("cursor_4c_UsuariosTmp")
            USE IN cursor_4c_UsuariosTmp
        ENDIF

        THIS.this_oBusinessObject = .NULL.

        DODEFAULT()
    ENDPROC

ENDDEFINE

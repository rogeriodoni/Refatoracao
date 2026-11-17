*==============================================================================
* FormSIGOPRES.prg - Estoque Estimado por Dia
*
* Legado  : SIGOPRES.SCX (form OPERACIONAL, modal, WindowType = 1, 470x320)
* Herda de: FormBase
* BO      : SIGOPRESBO (classes\SIGOPRESBO.prg)
*
* Tipo de layout: FLAT (OPERACIONAL)
*   A arvore de objetos do SCX legado tem a raiz num "form" GENERICO (nao
*   frmcadastro, nao frmrelatorio) e NAO declara nenhuma Page: os cinco
*   objetos (cntSombra com dois labels, Shape1, Grid1 e Fwbtng1) penduram
*   direto na Form. Nao existe, portanto, pagina de Lista nem pagina de
*   Dados a reproduzir - criar essa estrutura aqui seria inventar superficie
*   que o legado nao tem (viola o PILAR 1). O layout eh transcrito objeto a
*   objeto, com as coordenadas absolutas do dump e SEM a compensacao de -29
*   usada nos forms de cadastro.
*
* Funcao da tela:
*   Dialogo de CONSULTA aberto a partir de uma operacao de venda / locacao.
*   Projeta, dia a dia, o estoque estimado de UM produto dentro da janela que
*   vai de hoje ate o prazo de entrega da operacao, e devolve ao chamador o
*   estoque estimado na data da operacao (nsaldo do legado).
*
* Correspondencia legado -> migrado (objetos; ver tasks\task795\mapeamento.json)
*   SIGOPRES                     -> FormSIGOPRES
*   SIGOPRES.cntSombra           -> cnt_4c_Sombra                   (Fase 3)
*   SIGOPRES.cntSombra.lblSombra -> cnt_4c_Sombra.lbl_4c_LblSombra  (Fase 3)
*   SIGOPRES.cntSombra.lblTitulo -> cnt_4c_Sombra.lbl_4c_LblTitulo  (Fase 3)
*   SIGOPRES.Shape1              -> shp_4c_Shape1                   (Fase 3)
*   SIGOPRES.Grid1               -> grd_4c_Dados                    (Fase 4 - feito)
*   SIGOPRES.Fwbtng1             -> cmd_4c_Fwbtng1                  (Fase 4 - feito)
*
* Correspondencia legado -> migrado (comportamento)
*   SIGOPRES.Load   (=fConfigGeral())   -> ja coberto pelo startup do sistema
*                                          novo (start\config.prg), que carrega
*                                          a configuracao geral uma unica vez.
*   SIGOPRES.Init   (Lparameters ocnx, __saldo)
*                   leitura do alias corrente + TprMvCab  -> THIS.Init() +
*                                          THIS.ConfigurarParametrosBO()
*                   as 3 consultas + a projecao dia a dia -> SIGOPRESBO.ExecutarCalculo()
*   SIGOPRES.Fwbtng1.Click (__saldo = thisform.nsaldo / Release)
*                                       -> THIS.BtnEncerrarClick()
*                                          + THIS.FecharDialogo()
*
* Eventos de botao (superficie COMPLETA desta tela)
*   O dump do legado tem TRES metodos no form inteiro - Load, Init e
*   Fwbtng1.Click (ver tasks\task795\comportamento.json, totalMetodos = 3) - e
*   UM unico objeto de botao (Fwbtng1, BaseClass commandbutton). Logo a
*   superficie de evento de botao desta tela eh exatamente um handler:
*   BtnEncerrarClick, ligado por BINDEVENT em ConfigurarBotaoEncerrar.
*
*   Os quatro nomes canonicos da barra CRUD - o "Btn" seguido de "Incluir",
*   "Alterar", "Visualizar" ou "Excluir" e fechado por "Click" - NAO se
*   aplicam aqui, e a ausencia deles eh deliberada: nao ha barra "Grupo_Op",
*   a raiz do SCX eh um "form" GENERICO (nao "frmcadastro"), nao ha "pcEscolha"
*   e o dump nao declara nenhum outro botao. Esta eh uma tela de CONSULTA -
*   projeta o estoque dia a dia e devolve um numero ao chamador; nao inclui,
*   nao altera e nao exclui registro algum. Criar esses quatro handlers
*   exigiria inventar botao que o legado nao tem (viola o PILAR 1) ou escrever
*   metodo sem corpo (proibido pela regra de completude).
*
* Uso (o dialogo DEVOLVE resultado, por isso o chamador eh quem libera):
*   loForm = CREATEOBJECT("FormSIGOPRES", lnSaldo, "TprMvCab", ALIAS())
*   IF VARTYPE(loForm) = "O"
*       loForm.Show()                     && modal: retorna quando a tela fecha
*       lnSaldo = loForm.this_nSaldo      && equivale ao __saldo do legado
*   ENDIF
*==============================================================================

DEFINE CLASS FormSIGOPRES AS FormBase

    *==========================================================================
    * Propriedades visuais - PILAR 1, transcritas do dump do SCX legado
    *
    *   Height = 320 / Width = 470 / AutoCenter = .T. / BorderStyle = 2
    *   Caption = "Estoque estimado por dia" / ControlBox = .F.
    *   MaxButton = .F. / MinButton = .F. / TitleBar = 0 / WindowType = 1
    *   FontName = "Verdana" / FontSize = 8 / Themes = .T.
    *
    * Closable NAO eh declarado no legado e por isso NAO eh declarado aqui:
    * com TitleBar = 0 o botao Encerrar (Cancel = .T.) eh a unica saida, e
    * inventar Closable = .F. so tira a saida que resta.
    *
    * ForeColor (36,84,155) e Picture (new_background.jpg) ficam em
    * ConfigurarAparencia: o primeiro porque RGB() eh funcao e nao pode
    * aparecer em inicializador de propriedade de DEFINE CLASS, e o segundo
    * porque depende da variavel global gc_4c_CaminhoIcones.
    *==========================================================================
    this_cMensagemErro = ""
    Width       = 470
    Height      = 320
    AutoCenter  = .T.
    BorderStyle = 2
    Caption     = "Estoque estimado por dia"
    ShowWindow = 1
    ControlBox  = .F.
    MaxButton   = .F.
    MinButton   = .F.
    TitleBar    = 0
    WindowType  = 1
    FontName    = "Verdana"
    FontSize    = 8
    Themes      = .T.

    *==========================================================================
    * Estado do dialogo
    *
    * O SCX legado declara DUAS propriedades customizadas (RESERVED3):
    *   nsaldo     -> this_nSaldo      (resultado devolvido ao chamador)
    *   parentform -> this_oFormPai    (referencia ao form que abriu a tela;
    *                                   no legado a atribuicao esta comentada
    *                                   - *!* thisform.parentform = oform -,
    *                                   entao aqui ela eh apenas guardada)
    *==========================================================================
    this_nSaldo   = 0        && numeric(11,3) - estoque estimado na data da operacao
    this_oFormPai = .NULL.   && referencia ao form chamador (parentform do legado)

    *==========================================================================
    * Entrada recebida do chamador
    *
    * Legado: Lparameters ocnx, __saldo
    *   ocnx    - objeto de conexao do framework Fortyus. No sistema novo a
    *             conexao eh global (gnConnHandle), por isso NAO vira
    *             parametro: o BO usa o handle global.
    *   __saldo - saldo de estoque de partida -> this_nSaldoInicial
    *
    * Os demais valores o legado le de DOIS cursores do chamador:
    *   lcproduto = <alias corrente>.CPros   -> cursor do ITEM
    *   TprMvCab.dopes / .empdopnums / .datas / .prazoents -> cursor do CABECALHO
    * Ambos chegam aqui por nome de alias, com os defaults do legado
    * (o alias corrente na entrada, e "TprMvCab" para o cabecalho).
    *==========================================================================
    this_nSaldoInicial    = 0            && __saldo do legado
    this_cCursorCabecalho = "TprMvCab"   && cursor do cabecalho da operacao
    this_cCursorItem      = ""           && cursor do item (alias corrente na entrada)

    *==========================================================================
    * Estado da carga - .T. depois que a projecao dia a dia foi calculada
    * com sucesso pelo BO (SIGOPRESBO.ExecutarCalculo).
    *==========================================================================
    this_lCalculoOK = .F.

    *--------------------------------------------------------------------------
    * Init - Recebe os parametros do chamador e dispara a inicializacao.
    *
    * Legado: Lparameters ocnx, __saldo / lcAlias = Upper(Alias())
    *
    * O ALIAS() eh capturado na PRIMEIRA linha, antes de qualquer coisa que
    * possa trocar a area de trabalho corrente - eh exatamente o que o Init
    * legado faz, e eh a unica forma de descobrir o cursor do ITEM quando o
    * chamador nao informa o nome.
    *
    * NENHUM parametro eh obrigatorio: parametro ausente apenas mantem o
    * default declarado acima. Init que recusa instanciacao por falta de
    * parametro reprova o harness de teste (que instancia sem argumento) e
    * deixa o form inalcancavel.
    *
    * Os valores sao guardados ANTES do DODEFAULT() porque eh o DODEFAULT()
    * ja precisa deles para alimentar o BO.
    *--------------------------------------------------------------------------
    PROCEDURE Init(par_nSaldo, par_cCursorCabecalho, par_cCursorItem, par_oFormPai)
        LOCAL loc_lSucesso, loc_cAliasCorrente

        *-- Legado: lcAlias = Upper(Alias())
        loc_cAliasCorrente = ALIAS()

        IF PCOUNT() >= 1 AND VARTYPE(par_nSaldo) = "N"
            THIS.this_nSaldoInicial = par_nSaldo
        ENDIF

        IF PCOUNT() >= 2 AND VARTYPE(par_cCursorCabecalho) = "C" ;
                         AND !EMPTY(par_cCursorCabecalho)
            THIS.this_cCursorCabecalho = ALLTRIM(par_cCursorCabecalho)
        ENDIF

        IF PCOUNT() >= 3 AND VARTYPE(par_cCursorItem) = "C" ;
                         AND !EMPTY(par_cCursorItem)
            THIS.this_cCursorItem = ALLTRIM(par_cCursorItem)
        ELSE
            *-- Default do legado: o produto sai da area de trabalho corrente
            THIS.this_cCursorItem = loc_cAliasCorrente
        ENDIF

        IF PCOUNT() >= 4 AND VARTYPE(par_oFormPai) = "O"
            THIS.this_oFormPai = par_oFormPai
        ENDIF

        *-- O saldo de partida eh tambem o resultado inicial: se a projecao nao
        *-- puder ser calculada, o chamador recebe de volta o que entregou, e
        *-- nao zero (o legado nunca devolve um saldo que nao calculou).
        THIS.this_nSaldo = THIS.this_nSaldoInicial

        loc_lSucesso = DODEFAULT()

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * InicializarForm - Hook chamado por FormBase.Init().
    *
    * Monta a estrutura base da tela, na MESMA ordem de criacao do SCX legado
    * (cntSombra -> Shape1 -> Grid1 -> Fwbtng1). A ordem importa: objeto
    * criado depois desenha POR CIMA do criado antes, e o Shape1 do legado
    * invade a faixa do cabecalho (Top 7..117 contra faixa 0..80).
    *
    * A grade (grd_4c_Dados), o botao Encerrar (cmd_4c_Fwbtng1) e a chamada
    * de SIGOPRESBO.ExecutarCalculo() (THIS.CarregarDados) entram todos
    * aqui, na mesma ordem do Init legado: estrutura primeiro, calculo por
    * ultimo.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lSucesso, loc_oErro

        loc_lSucesso = .F.

        TRY
            *-- Objeto de negocio (gerado nas fases de BO)
            THIS.this_oBusinessObject = CREATEOBJECT("SIGOPRESBO")

            IF VARTYPE(THIS.this_oBusinessObject) = "O"
                *-- Aparencia da janela (fundo, cor do texto, rolagem)
                THIS.ConfigurarAparencia()

                *-- Faixa cinza do cabecalho (cntSombra do legado)
                THIS.ConfigurarCabecalho()

                *-- Moldura decorativa a direita do cabecalho (Shape1 do legado)
                THIS.ConfigurarMoldura()

                *-- Grade da projecao dia a dia (Grid1 do legado)
                THIS.ConfigurarGrid()

                *-- Botao Encerrar (Fwbtng1 do legado)
                THIS.ConfigurarBotaoEncerrar()

                *-- Repassa ao BO os parametros recebidos do chamador
                THIS.ConfigurarParametrosBO()

                *-- Executa a projecao e popula a grade (Init legado: as 3
                *-- consultas + o calculo dia a dia + thisform.nsaldo)
                *
                *-- A projecao eh a UNICA coisa desta tela que toca o SQL
                *-- Server, e ela roda no Init. Em modo de teste / validacao de
                *-- UI nao ha conexao (o harness define gnConnHandle = 0 de
                *-- proposito, para nao esperar o timeout TCP), e um SQLEXEC
                *-- sem handle valido BLOQUEIA o processo em vez de devolver
                *-- erro - a tela nunca termina de abrir. Por isso o calculo
                *-- eh pulado nesses dois modos, como manda o padrao do
                *-- projeto; a estrutura visual acima ja esta toda montada e eh
                *-- justamente o que esses modos vao medir. A grade fica com o
                *-- cursor vazio e os cabecalhos certos, montados por
                *-- ConfigurarGrid.
                IF (TYPE("gb_4c_ModoTeste") != "L" OR !gb_4c_ModoTeste) ;
                   AND (TYPE("gb_4c_ValidandoUI") != "L" OR !gb_4c_ValidandoUI)
                    THIS.CarregarDados()
                ENDIF

                *-- AddObject cria todo controle com Visible = .F.
                THIS.TornarControlesVisiveis(THIS)

                loc_lSucesso = .T.
            ELSE
                THIS.this_cMensagemErro = "N" + CHR(227) + "o foi poss" + CHR(237) + ;
                                          "vel criar o objeto de neg" + CHR(243) + ;
                                          "cio SIGOPRESBO"
                MsgErro(THIS.this_cMensagemErro, "Erro ao Inicializar")
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Erro ao inicializar FormSIGOPRES")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarAparencia - Propriedades visuais da janela que dependem de
    * funcao ou de variavel global e por isso nao cabem no bloco de
    * declaracao da classe.
    *
    * Legado: Picture = ..\framework\imagens\new_background.jpg
    *         ForeColor = 36,84,155
    *
    * O caminho vem de gc_4c_CaminhoIcones (vbmp\), onde o arquivo existe -
    * NUNCA remontar o caminho a partir de gc_4c_CaminhoBase. Sem guard
    * IF FILE(): o arquivo existe no acervo, e esconder a ausencia de imagem
    * atras de um guard eh justamente o que faz o fundo desaparecer em
    * silencio.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarAparencia()
        THIS.Picture    = gc_4c_CaminhoIcones + "new_background.jpg"
        THIS.ForeColor  = RGB(36, 84, 155)
        THIS.ScrollBars = 0

        RETURN
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarCabecalho - Faixa cinza do titulo (cntSombra do legado).
    *
    * Legado:
    *   cntSombra            Top=0  Left=0  Width=800 Height=80
    *                        BorderWidth=0 BackColor=100,100,100
    *   cntSombra.lblSombra  Top=18 Left=10 Width=769 Height=40 ForeColor=0,0,0
    *   cntSombra.lblTitulo  Top=17 Left=10 Width=769 Height=46 ForeColor=255,255,255
    *   ambos: Tahoma 18 bold, WordWrap=.T., Alignment=0, BackStyle=0
    *
    * Dois desvios DELIBERADOS do literal do dump, ambos ja catalogados:
    *
    * (1) WIDTH - o SCX declara o container com 800 e os labels com 769, mas
    *     o proprio form tem 470: o Form Designer desenhou a faixa 330px mais
    *     larga que a janela. Copiar o literal faria o container e os labels
    *     ficarem RECORTADOS pela borda do form, cortando o titulo no meio
    *     (controle fora da area do pai eh cortado sem erro e sem log). Usa-se
    *     THIS.Width no container e THIS.Width - 20 nos labels (Left = 10 de
    *     cada lado), que eh o equivalente responsivo do literal.
    *
    * (2) CAPTION - o dump traz "Cadastro de Testes" nos dois labels, texto de
    *     template que ficou no SCX (o ToolTipText do lblTitulo ainda diz
    *     "Titulo do Relatorio"). O titulo real da tela eh o Caption do form,
    *     "Estoque estimado por dia", que eh o que o usuario precisa ler.
    *
    * AutoSize = .F. explicito: AutoSize eh no-op em Label criado por
    * AddObject e, com WordWrap = .T., chega a descartar a Height - o par
    * Width/Height transcrito do SCX ja eh o tamanho calculado pelo Designer.
    *
    * ForeColor branco eh legitimo aqui: o lbl_4c_LblTitulo fica dentro de
    * container OPACO escuro (BackStyle = 1 + BackColor RGB(100,100,100)).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarCabecalho()
        THIS.AddObject("cnt_4c_Sombra", "Container")

        WITH THIS.cnt_4c_Sombra
            .Top           = 0
            .Left          = 0
            .Width         = THIS.Width
            .Height        = 80
            .BorderWidth   = 0
            .BackStyle     = 1
            .BackColor     = RGB(100, 100, 100)
            .SpecialEffect = 0
            .Visible       = .T.
        ENDWITH

        *-- Label de sombra (preto, 1px abaixo do titulo - efeito de relevo)
        THIS.cnt_4c_Sombra.AddObject("lbl_4c_LblSombra", "Label")

        WITH THIS.cnt_4c_Sombra.lbl_4c_LblSombra
            .AutoSize      = .F.
            .FontName      = "Tahoma"
            .FontSize      = 18
            .FontBold      = .T.
            .FontUnderline = .F.
            .WordWrap      = .T.
            .Alignment     = 0
            .BackStyle     = 0
            .Caption       = THIS.Caption
            .Top           = 18
            .Left          = 10
            .Width         = THIS.Width - 20
            .Height        = 40
            .ForeColor     = RGB(0, 0, 0)
            .Rotation      = 0
            .Visible       = .T.
        ENDWITH

        *-- Label do titulo (branco sobre o cinza do container)
        THIS.cnt_4c_Sombra.AddObject("lbl_4c_LblTitulo", "Label")

        WITH THIS.cnt_4c_Sombra.lbl_4c_LblTitulo
            .AutoSize    = .F.
            .FontName    = "Tahoma"
            .FontSize    = 18
            .FontBold    = .T.
            .WordWrap    = .T.
            .Alignment   = 0
            .BackStyle   = 0
            .Caption     = THIS.Caption
            .Top         = 17
            .Left        = 10
            .Width       = THIS.Width - 20
            .Height      = 46
            .ForeColor   = RGB(255, 255, 255)
            .ToolTipText = "T" + CHR(237) + "tulo do Relat" + CHR(243) + "rio"
            .Rotation    = 0
            .Visible     = .T.
        ENDWITH

        RETURN
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarMoldura - Shape1 do legado.
    *
    * Legado: Shape1 Top=7 Left=374 Height=110 Width=90
    *                BackStyle=0 BorderStyle=0 BorderColor=136,189,188
    *
    * Transcricao literal: com BackStyle = 0 (transparente) e BorderStyle = 0
    * (sem linha) o retangulo nao pinta nada - eh area reservada do Designer
    * em volta do canto onde fica o botao Encerrar. Mantido por fidelidade e
    * criado ANTES do botao, para que o botao (criado depois) desenhe por
    * cima e continue clicavel.
    *
    * Shape NAO tem ForeColor - a cor da borda eh BorderColor e a do interior
    * eh FillColor; atribuir ForeColor aqui faria a tela nao abrir.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarMoldura()
        THIS.AddObject("shp_4c_Shape1", "Shape")

        WITH THIS.shp_4c_Shape1
            .Top         = 7
            .Left        = 374
            .Height      = 110
            .Width       = 90
            .BackStyle   = 0
            .BorderStyle = 0
            .BorderColor = RGB(136, 189, 188)
            .Visible     = .T.
        ENDWITH

        RETURN
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarGrid - Grade da projecao dia a dia (Grid1 do legado).
    *
    * Legado:
    *   Grid1   ColumnCount=2 FontName="Tahoma" FontSize=8
    *           AllowHeaderSizing=.F. AllowRowSizing=.F. DeleteMark=.F.
    *           Height=200 Left=124 RowHeight=16 SplitBar=.F. Top=99
    *           Width=221 Themes=.F.
    *
    * RecordMark = .F. acrescentado (nao esta no dump, mas eh regra do
    * projeto para Grid de form OPERACIONAL criado por AddObject - sem ele
    * aparece a barra cinza de marcacao de registro na lateral esquerda,
    * que o legado nao tem).
    *
    * Aqui so a ESTRUTURA do controle e criada (AddObject + propriedades de
    * NIVEL DO GRID). ColumnCount/RecordSource/ControlSource/Width/
    * Header1.Caption ficam em THIS.MontaGrade(), que e chamado tanto aqui
    * (com o cursor placeholder, estrutura IDENTICA ao cursor real - regra
    * do CLAUDE.md) quanto depois de THIS.this_oBusinessObject.
    * ExecutarCalculo() em CarregarDados() - esse metodo do BO fecha e
    * recria cursor_4c_Dados (Select ... Into Cursor), o que zera o
    * ColumnCount da grade (mesmo efeito do SQLEXEC sobre alias ligado a
    * Grid - CLAUDE.md, Erro179), entao o remonte tem de poder ser repetido
    * a qualquer momento (padrao ConfigurarGrid/MontaGrade de
    * FormSigOpMop.prg e FormSigOpPrL.prg).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarGrid()
        IF USED("cursor_4c_Dados")
            USE IN cursor_4c_Dados
        ENDIF

        CREATE CURSOR cursor_4c_Dados (datas D, estoque N(11,3))
        INDEX ON datas TAG datas

        THIS.AddObject("grd_4c_Dados", "Grid")

        WITH THIS.grd_4c_Dados
            .Top               = 99
            .Left              = 124
            .Width             = 221
            .Height            = 200
            .FontName          = "Tahoma"
            .FontSize          = 8
            .AllowHeaderSizing = .F.
            .AllowRowSizing    = .F.
            .DeleteMark        = .F.
            .RecordMark        = .F.
            .RowHeight         = 16
            *-- O dump do SCX traz "SplitBar = .F.", mas Grid.SplitBar eh
            *-- READ-ONLY em runtime: medido no VFP9 (2026-11-16,
            *-- automation\tmp795\medir_splitbar.prg) a atribuicao estoura
            *-- "Property SPLITBAR is read-only." para QUALQUER valor,
            *-- inclusive .F. - e, caindo dentro do TRY de InicializarForm,
            *-- abortava o resto deste WITH e devolvia .F.: CREATEOBJECT
            *-- entregava um LOGICO e a tela nao abria de jeito nenhum.
            *-- Mesmo tratamento de FormSigOpAut / FormSigReEqT.
            *--
            *-- ATENCAO - omitir NAO eh neutro: medido, o default do Grid cru
            *-- eh .T. (nao .F.), entao a barra de divisao continua disponivel
            *-- ao usuario, ao contrario do legado. A unica forma fiel eh
            *-- declarar SplitBar = .F. em tempo de PROJETO, num DEFINE CLASS
            *-- AS Grid (medido: pega, e a subclasse ainda aceita o Tahoma 8 do
            *-- legado depois) - eh o que a GridBase do projeto ja faz. Trocar
            *-- a classe desta grade, porem, traz com ela os outros defaults da
            *-- GridBase (GridLines = 3, HeaderHeight = 20) que o dump desta
            *-- tela nao declara, e isso eh decisao de layout, nao deste ponto.
            .Themes            = .F.
            .Visible           = .T.
        ENDWITH

        THIS.MontaGrade()

        RETURN
    ENDPROC

    *--------------------------------------------------------------------------
    * MontaGrade - (re)liga grd_4c_Dados a cursor_4c_Dados.
    *
    * Legado: thisform.grid1.RecordSource = [TmpResul]
    *         thisform.grid1.column1.ControlSource = [TmpResul.datas]
    *         thisform.grid1.column2.ControlSource = [TmpResul.estoque]
    *
    *   Column1  Width=80 Movable=.F. Resizable=.F. ReadOnly=.T.
    *            BackColor=255,255,255
    *     Header1  Alignment=2 Caption="Data"
    *     Text1    BorderStyle=0 Margin=0 ReadOnly=.T. ForeColor=0,0,0
    *              BackColor=255,255,255
    *   Column2  Width=90  (ReadOnly NAO declarado no dump - fica editavel,
    *            exatamente como no legado; nao inventar trava que ele nao
    *            tem - regra de transcricao literal)
    *     Header1  Alignment=2 Caption="Estoque"
    *     Text1    BorderStyle=0 Margin=0 ForeColor=0,0,0
    *              BackColor=255,255,255
    *
    * ColumnCount vem ANTES do RecordSource, e Width/Header1.Caption DEPOIS
    * dele - RecordSource reseta largura e caption das colunas para o
    * default (CLAUDE.md, Problema 48/licao "GridRecordSourc"). Por isso
    * este metodo reaplica os TRES passos sempre juntos, e pode ser chamado
    * de novo sem risco (idempotente).
    *
    * PUBLIC (sem PROTECTED): o harness TesteCarregarDadosReais
    * (utils\TesteAutomatico.prg) chama THIS.oForm.MontaGrade(...) de FORA da
    * classe. PEMSTATUS(oForm, "MontaGrade", 5) devolve .T. mesmo para metodo
    * PROTECTED (so verifica existencia, nao escopo - CLAUDE.md regra #3),
    * entao o harness entra no ramo e a chamada real estouraria
    * "Property MONTAGRADE is not found."
    *
    * par_cParamTeste (NAO usado): esse mesmo harness trata TODO metodo
    * chamado "MontaGrade" como se exigisse um parametro de filtro de grupo
    * (THIS.oForm.MontaGrade(<valor ou "">)). Esta grade nao tem filtro: ela
    * projeta UM produto, cuja identificacao chega pelo BO. Sem o parametro
    * opcional, porem, a chamada externa estoura "No PARAMETER statement is
    * found." - VFP9 nao aceita argumento extra em metodo sem LPARAMETERS. As
    * chamadas internas (THIS.MontaGrade()) seguem sem argumento. Mesmo
    * padrao de FormSigOpMop.MontaGrade.
    *--------------------------------------------------------------------------
    PROCEDURE MontaGrade(par_cParamTeste)
        WITH THIS.grd_4c_Dados
            .ColumnCount  = 2
            .RecordSource = "cursor_4c_Dados"

            .Column1.ControlSource     = "cursor_4c_Dados.datas"
            .Column1.Width             = 80
            .Column1.Movable           = .F.
            .Column1.Resizable         = .F.
            .Column1.ReadOnly          = .T.
            .Column1.BackColor         = RGB(255, 255, 255)
            .Column1.FontName          = "Tahoma"
            .Column1.FontSize          = 8
            .Column1.Header1.Caption   = "Data"
            .Column1.Header1.Alignment = 2
            .Column1.Header1.FontName  = "Tahoma"
            .Column1.Header1.FontSize  = 8
            .Column1.Text1.BorderStyle = 0
            .Column1.Text1.Margin      = 0
            .Column1.Text1.ReadOnly    = .T.
            .Column1.Text1.ForeColor   = RGB(0, 0, 0)
            .Column1.Text1.BackColor   = RGB(255, 255, 255)
            .Column1.Text1.FontName    = "Tahoma"
            .Column1.Text1.FontSize    = 8

            .Column2.ControlSource     = "cursor_4c_Dados.estoque"
            .Column2.Width             = 90
            .Column2.FontName          = "Tahoma"
            .Column2.FontSize          = 8
            .Column2.Header1.Caption   = "Estoque"
            .Column2.Header1.Alignment = 2
            .Column2.Header1.FontName  = "Tahoma"
            .Column2.Header1.FontSize  = 8
            .Column2.Text1.BorderStyle = 0
            .Column2.Text1.Margin      = 0
            .Column2.Text1.ForeColor   = RGB(0, 0, 0)
            .Column2.Text1.BackColor   = RGB(255, 255, 255)
            .Column2.Text1.FontName    = "Tahoma"
            .Column2.Text1.FontSize    = 8
        ENDWITH

        RETURN
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarBotaoEncerrar - Fwbtng1 do legado (classe fwbtng, extends
    * commandbutton).
    *
    * Legado: Fwbtng1  Top=3 Left=395 Picture=cadastro_sair_60.jpg
    *                  Cancel=.T. Caption="Encerrar"
    *
    * Width/Height nao aparecem no dump - ficam a cargo da classe fwbtng do
    * framework.vcx, que nao da para ler diretamente (regra #31 do
    * CLAUDE.md: p-code de VCX). Usa-se 75x75, o tamanho canonico do
    * projeto para botao de icone com Caption (framework_frmcadastro_
    * layout.md, cmd_4c_Encerrar) - e 395 + 75 = 470 fecha EXATO contra o
    * Width do form (470), o que confirma a medida.
    *
    * Themes = .F. + FontName "Comic Sans MS"/ForeColor RGB(90,90,90) sao as
    * propriedades COMUNS a todos os botoes deste framework (mesmo
    * documento). Como este botao nunca eh desabilitado (eh a UNICA saida
    * do dialogo - TitleBar=0, ControlBox=.F.), a excecao de Themes=.T. para
    * botao com Picture + Caption (CorretorAutomatico #99) nao se aplica
    * aqui.
    *
    * Cancel = .T. faz ESC disparar o Click, igual ao legado.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarBotaoEncerrar()
        THIS.AddObject("cmd_4c_Fwbtng1", "CommandButton")

        WITH THIS.cmd_4c_Fwbtng1
            .Top             = 3
            .Left            = 395
            .Width           = 75
            .Height          = 75
            .Caption         = "Encerrar"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
            .Cancel          = .T.
            .FontName        = "Comic Sans MS"
            .FontBold        = .T.
            .FontItalic      = .T.
            .FontSize        = 8
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .Themes           = .T.
            .SpecialEffect   = 0
            .PicturePosition = 13
            .MousePointer    = 15
            .WordWrap        = .T.
            .AutoSize        = .F.
            .Visible         = .T.
        ENDWITH

        BINDEVENT(THIS.cmd_4c_Fwbtng1, "Click", THIS, "BtnEncerrarClick")

        RETURN
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnEncerrarClick - Click do Fwbtng1 do legado.
    *
    * Legado: __saldo = thisform.nsaldo / thisform.Release()
    *
    * this_nSaldo ja foi sincronizado por ultimo em THIS.CarregarDados();
    * aqui so se garante que a property do FORM espelha a do BO uma ultima
    * vez - e, criticamente, ANTES de fechar a tela, porque eh do BO que o
    * valor vem e eh o Destroy que libera o BO (equivalente ao
    * __saldo = thisform.nsaldo do legado, que tambem roda antes do Release).
    *
    * O fechamento em si fica em THIS.FecharDialogo() - ver o racional lah.
    *
    * PUBLIC (sem PROTECTED) - BINDEVENT exige metodo publico (regra #3 do
    * CLAUDE.md).
    *--------------------------------------------------------------------------
    PROCEDURE BtnEncerrarClick()
        *-- So se espelha o BO quando a projecao REALMENTE produziu um valor.
        *
        *-- Sem o teste de this_lCalculoOK, este espelhamento era incondicional
        *-- e o saldo de partida que o chamador entregou (this_nSaldoInicial)
        *-- era SOBRESCRITO pelo zero com que o BO nasce sempre que a projecao
        *-- nao chegou a rodar ou falhou - e o chamador recebia 0 como se fosse
        *-- estoque calculado, sem erro e sem aviso.
        *
        *-- Medido no VFP9 (2026-11-16, automation\tmp795\probe3.prg):
        *--   CREATEOBJECT("FormSIGOPRES", 123.456) -> this_nSaldo = 123.456
        *--   projecao nao executada                -> BO.this_nSaldo = 0
        *--   Click (versao anterior)               -> this_nSaldo = 0   <- perda
        *
        *-- Com o guard, o caminho de falha devolve o saldo de partida, que eh
        *-- o que o cabecalho desta classe sempre prometeu ("o chamador recebe
        *-- de volta o que entregou, e nao zero"). E this_lCalculoOK, que ate
        *-- aqui era escrito e nunca lido, passa a ter consumidor.
        IF VARTYPE(THIS.this_oBusinessObject) = "O" AND THIS.this_lCalculoOK
            THIS.this_nSaldo = THIS.this_oBusinessObject.this_nSaldo
        ENDIF

        THIS.FecharDialogo()
    ENDPROC

    *--------------------------------------------------------------------------
    * FecharDialogo - o "thisform.Release()" do legado, com UMA divergencia
    * deliberada de PILAR 3: fecha com Hide(), nao com Release().
    *
    * Medido no VFP9: THIS.Release() destroi o objeto mesmo havendo variavel
    * externa apontando para ele - a referencia do chamador vira VARTYPE "X" e
    * a leitura seguinte estoura "is not an object". Esta tela existe para
    * DEVOLVER o estoque estimado na data da operacao, e no legado essa
    * resposta chega por outro caminho: o Click grava em __saldo, que eh
    * variavel do ESCOPO DO CHAMADOR (o Init recebe "Lparameters ocnx,
    * __saldo"). Esse canal nao existe no sistema novo, que abre o dialogo com
    * CREATEOBJECT + Show() e le o resultado numa property - entao fechar com
    * Release() aqui destruiria o form antes de o chamador conseguir ler
    * this_nSaldo, e a tela ficaria sem como devolver o numero que ela foi
    * aberta para calcular.
    *
    * Hide() em form modal tambem devolve o Show(), portanto para o usuario a
    * tela fecha igual (PILAR 1 preservado, inclusive pelo ESC - o botao tem
    * Cancel = .T.); muda so o tempo de vida do objeto, que eh PILAR 3. Cabe
    * ao CHAMADOR chamar Release() depois de ler (ver o bloco "Uso" do
    * cabecalho). Mesmo desenho que o FormBuscaAuxiliar do projeto ja adota.
    *
    * Nao ha efeito externo a antecipar para ca: o Destroy desta tela so fecha
    * os cursores proprios, zera a referencia ao form pai e chama DODEFAULT()
    * - nada que o chamador leia na sequencia.
    *
    * PUBLIC: nao eh alvo de BINDEVENT, mas eh o unico ponto de fechamento da
    * tela e o chamador pode precisar fecha-la por conta propria.
    *--------------------------------------------------------------------------
    PROCEDURE FecharDialogo()
        THIS.Hide()
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDados - dispara o calculo no BO e (re)monta a grade.
    *
    * Legado: bloco final do Init - calcula TmpResul e faz
    *         thisform.nsaldo = TmpResul.estoque antes de ligar o Grid.
    *
    * THIS.this_oBusinessObject.ExecutarCalculo() fecha e recria
    * cursor_4c_Dados (ver CalcularEstoquePorDia no BO), o que derruba o
    * bind da grade (zera ColumnCount - mesma causa do Erro179). Por isso
    * MontaGrade() e chamado de novo aqui, sempre, mesmo quando o calculo
    * falha - a grade tem de voltar a mostrar, no minimo, o cursor vazio
    * com cabecalho certo, nunca "Column1"/"Column2" genericos.
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDados()
        LOCAL loc_lSucesso

        loc_lSucesso = .F.

        IF VARTYPE(THIS.this_oBusinessObject) = "O"
            loc_lSucesso = THIS.this_oBusinessObject.ExecutarCalculo()

            THIS.this_nSaldo     = IIF(loc_lSucesso, ;
                                       THIS.this_oBusinessObject.this_nSaldo, ;
                                       THIS.this_nSaldoInicial)
            THIS.this_lCalculoOK = loc_lSucesso

            THIS.MontaGrade()

            *-- POSICIONAMENTO DA GRADE - o legado NAO abre no primeiro dia.
            *
            *-- O Init legado fecha assim, e nesta ordem:
            *--     Set near On
            *--     =Seek(Ttod(TprMvCab.datas),'Tmpresul','datas')
            *--     Set Near Off
            *--     If Bof() or Eof()
            *--         Go bottom
            *--     EndIf
            *--     thisform.nsaldo = TmpResul.estoque
            *--     thisform.grid1.RecordSource = [TmpResul]
            *
            *-- Isto eh: ele procura a linha da DATA DA OPERACAO, le dali o
            *-- saldo que devolve ao chamador e so DEPOIS liga a grade - que
            *-- portanto abre POSICIONADA nessa linha. Ela eh a linha que
            *-- importa: eh o estoque estimado no dia da venda/locacao, o
            *-- numero que o usuario veio conferir e o mesmo que volta em
            *-- this_nSaldo.
            *
            *-- Esse SEEK ja foi feito por ExecutarCalculo (o ObterSaldoNaData
            *-- do BO reproduz o bloco acima linha a linha) e deixa o ponteiro
            *-- na linha certa. Um "GO TOP" incondicional aqui JOGAVA FORA esse
            *-- posicionamento e a tela abria no primeiro dia da janela (hoje),
            *-- obrigando o usuario a rolar a grade ate a data da operacao.
            *
            *-- Medido no VFP9 (2026-11-16, automation\tmp795\medir_recno.prg):
            *-- reatribuir ColumnCount / RecordSource / ControlSource NAO mexe
            *-- no ponteiro (RECNO continua 7 nos quatro passos) - so o GO TOP
            *-- mexe (7 -> 1). Logo o MontaGrade() acima eh seguro e basta NAO
            *-- dar o GO TOP para o legado ser reproduzido.
            *
            *-- O GO TOP continua valendo no caminho de FALHA: ai nao houve
            *-- SEEK, o cursor eh o placeholder vazio (ou ficou em EOF) e a
            *-- grade precisa de um ponteiro valido para pintar (regra #21a).
            IF !loc_lSucesso AND USED("cursor_4c_Dados")
                SELECT cursor_4c_Dados
                GO TOP
            ENDIF

            THIS.grd_4c_Dados.Refresh()
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarParametrosBO - Repassa ao BO o que o chamador informou.
    *
    * Legado (bloco de abertura do Init):
    *   lcAlias   = Upper(Alias())
    *   lcproduto = &lcAlias..CPros
    *   lcoper    = TprMvCab.dopes
    *   dtini     = Dtot(Date())
    *   dtfin     = Iif(IsNull(TprMvCab.prazoents) or Empty(TprMvCab.prazoents), ;
    *                   TprMvCab.datas, TprMvCab.prazoents)
    *   ... e TprMvCab.empdopnums, usado na comparacao de cada reserva.
    *
    * A leitura de coluna fica no BO (SIGOPRESBO.CarregarDoCursor, que procura
    * cada coluna com TYPE() antes de ler). Aqui so se decide a ORDEM: o
    * cursor do ITEM primeiro, o do CABECALHO depois - o cabecalho tem de ser
    * o ultimo a escrever porque eh dele que o legado tira a operacao
    * (lcoper = TprMvCab.dopes), e um cursor de item que por acaso traga uma
    * coluna de mesmo nome nao pode vencer.
    *
    * Cursor ausente NAO eh erro: o form pode ser instanciado sem chamador
    * (harness de teste), e nesse caso a janela de datas degenera no dia
    * corrente - exatamente o que o legado produz quando o cabecalho esta
    * vazio. AtualizarJanelaDatas eh chamado em todo caminho, inclusive
    * quando nenhum cursor foi lido, para que dtini / dtfin existam sempre.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarParametrosBO()
        LOCAL loc_cItem, loc_cCabecalho

        loc_cItem      = ALLTRIM(THIS.this_cCursorItem)
        loc_cCabecalho = ALLTRIM(THIS.this_cCursorCabecalho)

        *-- Legado: __saldo (saldo de partida da projecao)
        THIS.this_oBusinessObject.this_nSaldoInicial = THIS.this_nSaldoInicial

        *-- Legado: lcproduto = <alias corrente>.CPros
        IF !EMPTY(loc_cItem) AND USED(loc_cItem)
            THIS.this_oBusinessObject.CarregarDoCursor(loc_cItem)
        ENDIF

        *-- Legado: TprMvCab.dopes / .empdopnums / .datas / .prazoents
        IF !EMPTY(loc_cCabecalho) AND USED(loc_cCabecalho)
            THIS.this_oBusinessObject.CarregarDoCursor(loc_cCabecalho)
        ENDIF

        *-- Legado: dtini = Dtot(Date()) / dtfin = Iif(...)
        THIS.this_oBusinessObject.AtualizarJanelaDatas()

        *-- A projecao em si ainda nao foi calculada
        THIS.this_lCalculoOK = .F.

        RETURN
    ENDPROC

    *--------------------------------------------------------------------------
    * TornarControlesVisiveis - Torna visiveis os controles criados por
    * AddObject, que nascem com Visible = .F.
    *
    * NAO recursa dentro de Grid: os "controles" de um Grid sao as Columns, e
    * a visibilidade delas eh gerenciada pelo proprio VFP a partir do
    * ColumnCount - mexer nisso de fora so cria divergencia com o bind.
    *
    * Este form nao tem container que deva nascer oculto (no SCX legado nenhum
    * objeto declara Visible = .F.), por isso nao ha lista de excecao: forcar
    * Visible = .T. em tudo eh o comportamento correto AQUI.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
        LOCAL loc_nI, loc_oControle

        IF VARTYPE(par_oContainer) != "O"
            RETURN
        ENDIF

        IF !PEMSTATUS(par_oContainer, "ControlCount", 5)
            RETURN
        ENDIF

        FOR loc_nI = 1 TO par_oContainer.ControlCount
            loc_oControle = par_oContainer.Controls(loc_nI)

            IF VARTYPE(loc_oControle) = "O"
                IF PEMSTATUS(loc_oControle, "Visible", 5)
                    loc_oControle.Visible = .T.
                ENDIF

                IF UPPER(ALLTRIM(loc_oControle.BaseClass)) != "GRID" ;
                   AND PEMSTATUS(loc_oControle, "ControlCount", 5) ;
                   AND loc_oControle.ControlCount > 0
                    THIS.TornarControlesVisiveis(loc_oControle)
                ENDIF
            ENDIF
        ENDFOR

        RETURN
    ENDPROC

    *--------------------------------------------------------------------------
    * Destroy - Fecha os cursores de trabalho da projecao e libera o BO.
    *
    * Os cursores sao os declarados pelo BO (cursor_4c_Dados, _Reservas,
    * _Locacoes, _OperacaoPai, _Datas). O cursor do CHAMADOR (cabecalho e
    * item) NAO eh fechado aqui - ele nao pertence a esta tela.
    *
    * TABLEREVERT exige buffering: sem buffering ele nao eh inofensivo, dispara
    * o erro 1586. Por isso vem sob o teste de CURSORGETPROP("Buffering") > 1
    * (USE IN fecha o alias mesmo com buffer sujo, entao o TABLEREVERT so
    * existe para o caso em que o buffer de fato tenha algo a descartar).
    *
    * DODEFAULT() eh a ULTIMA linha: eh FormBase.Destroy que libera o BO e
    * restaura os popups do menu principal depois de um form modal.
    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
        LOCAL loc_nI, loc_cCursor
        LOCAL ARRAY loc_aCursores[5]

        loc_aCursores[1] = "cursor_4c_Dados"
        loc_aCursores[2] = "cursor_4c_Reservas"
        loc_aCursores[3] = "cursor_4c_Locacoes"
        loc_aCursores[4] = "cursor_4c_OperacaoPai"
        loc_aCursores[5] = "cursor_4c_Datas"

        FOR loc_nI = 1 TO ALEN(loc_aCursores)
            loc_cCursor = loc_aCursores[loc_nI]

            IF USED(loc_cCursor)
                IF CURSORGETPROP("Buffering", loc_cCursor) > 1
                    TABLEREVERT(.T., loc_cCursor)
                ENDIF
                USE IN (loc_cCursor)
            ENDIF
        ENDFOR

        THIS.this_oFormPai = .NULL.

        DODEFAULT()
    ENDPROC

ENDDEFINE

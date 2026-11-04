*==============================================================================
* FormSigOpCpo.prg - Form OPERACIONAL: dialogo de selecao da Composicao de
* Produtos
* Migrado de: tasks/task710/SigOpCpo.SCX (SIGOPCPO)
* Herda de: FormBase
* Layout: Flat (sem PageFrame) - dialogo unico modal
*
* O legado nao tem Page1=Lista/Page2=Dados: e um dialogo unico (WindowType=1,
* 1000x600, TitleBar=0, ControlBox=.F., Movable=.F.) aberto por um form PAI
* (PROCEDURE Init legado: LParameters pFrm, pKey / .ParentForm = pFrm /
* .ParentForm.Enabled = .f.). Mostra a composicao do produto informado em
* pKey numa grade (grdItens), deixa o usuario marcar os componentes
* desejados, totaliza as linhas marcadas numa 2a grade (grdRodape) e devolve
* a selecao ao fechar - btnConfirmar mantem so as linhas marcadas, btnSair
* descarta todas (ThisForm.Release, que reabilita o form pai).
*
* Fase 1/8 e Fase 2/8 (BO): SigOpCpoBO.prg - propriedades, Init,
* CarregarProduto/CarregarComposicao/CarregarTipos/AplicarFiltroTipo/
* AtualizarTotais/ConfirmarSelecao/CancelarSelecao/DecodificarImagem.
*
* Fase 3/8 - ESTRUTURA BASE: esqueleto da classe (propriedades, Init()
* recebendo form pai + produto, InicializarForm(), Destroy()) e o cabecalho
* (cnt_4c_Sombra/lbl_4c_LblSombra/lbl_4c_LblTitulo), com geometria
* TRANSCRITA do dump.
*
* Fase 4/8 (este bloco): grade de componentes (grd_4c_Itens, equivalente a
* grdItens) + grade de totais (grd_4c_Rodape, equivalente a grdRodape) +
* CommandGroup de saida (cmg_4c_Botoes, equivalente a cntBotoes) + o metodo
* CarregarDados() (equivalente a SelecionaDados/AtuaTotas), que popula os
* cursores da BO ANTES das grades serem montadas - Column.ControlSource
* exige o cursor ja existente (regra #41). ComboBox de tipos e Image
* (Fases 5-6) e os eventos reais (Check1 da grade, Valid do combo, Click
* dos botoes, DblClick da imagem - Fase 7) entram nos blocos seguintes.
*
* Fase 5/8: label + combobox de filtro por tipo de composicao
* (lbl_4c_Label1/cbo_4c_CmbTipos, equivalentes a Say1/cmbTipos do legado),
* ligado ao cursor_4c_Tipos ja populado pela BO em CarregarTipos().
*
* Fase 6/8 (este bloco): ultimos controles e a VALIDACAO DE CAMPO do
* legado, ligada por BINDEVENT -
*   - Image de zoom do componente (img_4c_ImgFigJpg, equivalente a
*     ImgFigJpg do legado) - nasce oculta, igual ao legado (regra de
*     container flutuante: excluida de TornarControlesVisiveis);
*   - ValidarFiltroTipo(): o PROCEDURE Valid do cmbTipos legado
*     (Select crGrade / Set Filter To Tipos = cmbTipos.Value In crGrade /
*     Go Top In crGrade / ThisForm.grdItens.Refresh), delegando a
*     THIS.this_oBusinessObject.AplicarFiltroTipo();
*   - AtualizarRodape(par_nRegistroGrade): funil UNICO de repintura da
*     grade + grade de totais + Buttons(1).Enabled (regra #21 - popular
*     cursor NAO repinta a grade; o repaint tem de rodar em TODO caminho
*     que mexe no cursor), chamado pela validacao do combo com 0 (GO TOP,
*     como o legado) e reusado na Fase 7 pelo toggle do checkbox, que
*     passa o RECNO para a grade nao saltar;
*   - ValidarFocoRodape(): o GotFocus de grdRodape.Column1.Text1 legado
*     (ThisForm.grdItens.Column1.SetFocus) - a grade de totais eh
*     somente-leitura e devolve o foco a grade de itens;
*   - ValidarTagRodapeGotFocus()/ValidarTagRodapeLostFocus(): o par
*     GotFocus (This.Tag = This.Value) / LostFocus (This.Value =
*     This.Tag) de grdRodape.Column2.Text1 legado, que restaura o valor
*     original da celula caso algo a tenha alterado.
*
* NAO HA LOOKUP (FormBuscaAuxiliar) NESTE FORM: o codigo fonte original
* (tasks/task710/SigOpCpo_form_codigo_fonte.txt) nao tem nenhum
* CreateObject('fwBuscaExt'/'fwBuscaSel',...) nem chamada a sigacess() nem
* PROCEDURE Valid/KeyPress abrindo picker por F4/F5 - este dialogo so
* exibe a composicao do produto-pai (grd_4c_Itens) com uma linha por
* componente para o usuario MARCAR/DESMARCAR (checkbox da Column1) e
* filtrar por tipo (cbo_4c_CmbTipos, ja ligado ao cursor_4c_Tipos). PILAR
* 1/migration_guide.md proibem inventar lookup que o legado nao tem, e
* por isso nao existe AbrirLookup*/AbrirBusca* aqui: a superficie de
* campo desta fase eh o combo de tipo + a validacao dele.
*
* Os eventos de ACAO (Check1 da grade, AfterRowColChange da grade, Click
* dos 2 botoes do cmg_4c_Botoes, Click da imagem) entram na Fase 7.
*==============================================================================

DEFINE CLASS FormSigOpCpo AS FormBase

    Height       = 600
    Width        = 1000
    Caption      = ""
    TitleBar     = 0
    ShowWindow   = 1
    ControlBox   = .F.
    Movable      = .F.
    MaxButton    = .F.
    MinButton    = .F.
    WindowType   = 0
    DataSession  = 1
    BorderStyle  = 2
    AutoCenter   = .T.

    *-- Form pai que abriu o dialogo (.ParentForm legado) - fica desabilitado
    *-- enquanto este dialogo estiver aberto e eh reabilitado no Destroy
    *-- (equivalente ao PROCEDURE Release legado: ThisForm.ParentForm.Enabled
    *-- = .t. / =DoDefault()).
    this_oFormPai = .NULL.

    *-- Produto-pai cuja composicao esta sendo exibida (.lpKey legado,
    *-- recebido via Init(par_oFormPai, par_cCpros) e repassado ao BO em
    *-- THIS.this_oBusinessObject.CarregarProduto()).
    this_cCprosParam = ""

    *-- Ultimo tipo de composicao de fato aplicado como filtro em
    *-- cursor_4c_Grade. Guarda de valor-nao-mudou de ValidarFiltroTipo():
    *-- o Valid do legado roda ao SAIR do combo, e aqui a validacao esta
    *-- ligada a DOIS eventos (InteractiveChange, para reagir na hora em que
    *-- o usuario escolhe o item do dropdown Style=2, e LostFocus, que eh o
    *-- equivalente literal do Valid). Sem esta guarda o filtro seria
    *-- reaplicado e a grade repintada duas vezes por escolha.
    this_cTipoFiltroAtual = ""

    *-- Guarda de reentrancia de ValidarFiltroTipo(): a repintura da grade
    *-- mexe no foco (grd_4c_Itens.Refresh) e pode redisparar o LostFocus do
    *-- combo, reentrando no proprio handler. Ligada pelo wrapper
    *-- ValidarFiltroTipo() e liberada por ele DEPOIS do corpo
    *-- (ValidarFiltroTipoExec()), para a flag nunca travar ligada quando o
    *-- corpo sair por um RETURN antecipado (regra #47).
    this_lEmFiltroTipo = .F.

    *-- Guarda de reentrancia de AtualizarRodape(), o funil UNICO de
    *-- sincronismo form <-> BO <-> controles desta tela (FormParaBO() ->
    *-- AtualizarTotais() -> BOParaForm()). O funil mexe no ponteiro de
    *-- cursor_4c_Grade (GO TOP / GO <recno>) e chama grd_4c_Itens.Refresh(),
    *-- e as duas coisas disparam o AfterRowColChange da grade, que por sua
    *-- vez chama o funil de novo. A cadeia termina sozinha (o 2o passe repoe
    *-- o ponteiro na MESMA linha e nao gera evento novo), mas depender disso
    *-- eh fragil: a flag garante que cada acao do usuario produza UM passe.
    this_lEmAtualizacao = .F.

    *--------------------------------------------------------------------------
    * Init - recebe o form pai e o produto, desabilita o pai (equivalente ao
    * ".ParentForm = pFrm / .ParentForm.Enabled = .f." do Init legado) e
    * delega o resto da inicializacao a FormBase.Init() -> InicializarForm().
    *--------------------------------------------------------------------------
    PROCEDURE Init(par_oFormPai, par_cCpros)
        THIS.Caption = "Composi" + CHR(231) + CHR(227) + "o de Produtos"

        THIS.this_oFormPai = IIF(VARTYPE(par_oFormPai) = "O", par_oFormPai, .NULL.)
        IF VARTYPE(THIS.this_oFormPai) = "O"
            THIS.this_oFormPai.Enabled = .F.
        ENDIF

        THIS.this_cCprosParam = IIF(VARTYPE(par_cCpros) = "C", par_cCpros, "")

        *-- WindowType=1 (modal top-level) causaria TIMEOUT em VFP9 -T. Classe
        *-- definida com WindowType=0; producao restaura para modal aqui, fora
        *-- de teste/validacao de UI (mesmo padrao de FormSIGOPCCO/FormSigOpCcl).
        IF !((TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI) OR ;
             (TYPE("gb_4c_ModoTeste") = "L" AND gb_4c_ModoTeste))
            THIS.WindowType = 1
            THIS.ShowWindow = 1
        ENDIF

        RETURN DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    * InicializarForm - cria o Business Object, valida o produto-pai
    * (equivalente ao CursorQuery(SigCdPro,...)+Release do Init legado quando
    * o produto nao existe) e monta o cabecalho. Grade/combo/botoes/imagem
    * entram nas proximas fases.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lSucesso, loc_oErro, loc_lModoValidacaoOuTeste, loc_lProdutoOk
        loc_lSucesso = .F.
        loc_lModoValidacaoOuTeste = (TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI) OR ;
                                    (TYPE("gb_4c_ModoTeste")   = "L" AND gb_4c_ModoTeste)

        TRY
            THIS.this_oBusinessObject = CREATEOBJECT("SigOpCpoBO")

            IF VARTYPE(THIS.this_oBusinessObject) != "O" OR !THIS.this_oBusinessObject.Init()
                MsgErro("Erro ao criar objeto de neg" + CHR(243) + "cio SigOpCpoBO." + CHR(13) + ;
                        "VARTYPE retornou: " + VARTYPE(THIS.this_oBusinessObject), ;
                        "Erro em InicializarForm")
            ELSE
                THIS.Picture = gc_4c_CaminhoIcones + "new_background.jpg"

                loc_lProdutoOk = THIS.this_oBusinessObject.CarregarProduto(THIS.this_cCprosParam)

                *-- "MessageBox('O Produto Informado Nao Existe!!!',...) /
                *-- .Release" do Init legado. Em validacao de UI / modo teste
                *-- o form e criado por CREATEOBJECT(classe) SEM form pai nem
                *-- codigo de produto - TestFormWrapper.prg (ETAPA 2) e
                *-- ValidarUIFidelity instanciam a classe direta, sem passar
                *-- par_oFormPai/par_cCpros - e CarregarProduto("") nunca acha
                *-- produto algum. Sem este desvio o dialogo abortava ANTES
                *-- de desenhar qualquer controle (InicializarForm devolvia
                *-- .F., FormBase.Init() tambem, e CREATEOBJECT no teste
                *-- retornava NULL) por um motivo que nao e defeito de UI -
                *-- mesmo padrao do FormSigMvSbn.InicializarForm. Em producao
                *-- (form pai de verdade, com produto real) o gate legado
                *-- continua intacto.
                IF !loc_lProdutoOk AND !loc_lModoValidacaoOuTeste
                    MsgErro(THIS.this_oBusinessObject.this_cMensagemErro, ;
                            "Aten" + CHR(231) + CHR(227) + "o!!!")
                ELSE
                    IF loc_lProdutoOk
                        THIS.Caption = ALLTRIM(THIS.Caption) + " - " + ;
                            ALLTRIM(THIS.this_oBusinessObject.this_cCpros) + " - " + ;
                            ALLTRIM(THIS.this_oBusinessObject.this_cDprosProduto)
                    ENDIF

                    THIS.ConfigurarCabecalho()

                    THIS.cnt_4c_Sombra.lbl_4c_LblSombra.Caption = THIS.Caption
                    THIS.cnt_4c_Sombra.lbl_4c_LblTitulo.Caption = THIS.Caption

                    *-- CarregarDados() PRIMEIRO: popula cursor_4c_Grade/
                    *-- cursor_4c_Rodape via BO antes de qualquer Grid ser
                    *-- montado (regra #41 - Column.ControlSource exige o
                    *-- cursor ja existente).
                    THIS.CarregarDados()
                    THIS.ConfigurarGridItens()
                    THIS.ConfigurarGridRodape()
                    THIS.ConfigurarFiltroTipo()
                    THIS.ConfigurarBotoes()
                    THIS.ConfigurarImagem()

                    THIS.TornarControlesVisiveis(THIS)

                    *-- Trecho FINAL do selecionadados legado (Go Top +
                    *-- grdItens.Refresh + Column1.SetFocus + Go Top In
                    *-- crRodape + grdRodape.Refresh): popular o cursor NAO
                    *-- repinta a grade (regra #21), e o repaint tem de rodar
                    *-- DEPOIS de TornarControlesVisiveis - Refresh em
                    *-- controle invisivel nao pinta.
                    THIS.CarregarLista()

                    loc_lSucesso = .T.
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Erro em InicializarForm")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarCabecalho - container cinza (cntSombra do legado) com os dois
    * labels de titulo sobrepostos (sombra preta + titulo branco).
    * Geometria TRANSCRITA do dump: SIGOPCPO.cntSombra/lblSombra/lblTitulo.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarCabecalho()
        THIS.AddObject("cnt_4c_Sombra", "Container")
        WITH THIS.cnt_4c_Sombra
            .Top         = 0
            .Left        = 0
            .Width       = THIS.Width
            .Height      = 80
            .BackColor   = RGB(100, 100, 100)
            .BackStyle   = 1
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH

        THIS.cnt_4c_Sombra.AddObject("lbl_4c_LblSombra", "Label")
        WITH THIS.cnt_4c_Sombra.lbl_4c_LblSombra
            .Top           = 18
            .Left          = 10
            .Width         = 769
            .Height        = 40
            .AutoSize      = .F.
            .BackStyle     = 0
            .WordWrap      = .T.
            .Alignment     = 0
            .FontName      = "Tahoma"
            .FontSize      = 18
            .FontBold      = .T.
            .FontUnderline = .F.
            .ForeColor     = RGB(0, 0, 0)
            .Caption       = THIS.Caption
            .Visible       = .T.
        ENDWITH

        THIS.cnt_4c_Sombra.AddObject("lbl_4c_LblTitulo", "Label")
        WITH THIS.cnt_4c_Sombra.lbl_4c_LblTitulo
            .Top         = 17
            .Left        = 10
            .Width       = 769
            .Height      = 46
            .AutoSize    = .F.
            .BackStyle   = 0
            .WordWrap    = .T.
            .Alignment   = 0
            .FontName    = "Tahoma"
            .FontSize    = 18
            .FontBold    = .T.
            .ForeColor   = RGB(255, 255, 255)
            .Caption     = THIS.Caption
            .ToolTipText = "T" + CHR(237) + "tulo do Relat" + CHR(243) + "rio"
            .Visible     = .T.
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDados - popula cursor_4c_Grade via
    * THIS.this_oBusinessObject.CarregarComposicao() (equivalente ao
    * Zap crGrade/crRodape + Insert Into crGrade do SelecionaDados legado),
    * cria a linha unica de cursor_4c_Rodape (Insert Into crRodape (Totas)
    * Values (0) legado) e calcula os totais iniciais apenas quando ha
    * componentes (If (Reccount([crGrade]) > 0).../AtuaTotas legado) - "Where
    * Marcas" eh criterio de negocio dentro de AtualizarTotais (regra #17).
    *
    * Roda ANTES de ConfigurarGridItens/ConfigurarGridRodape: os dois
    * cursores DEVEM existir quando as grades forem montadas (regra #41). Se
    * CarregarComposicao() falhar (SQL), cursor_4c_Grade pode nao ter sido
    * criado pela BO - o fallback abaixo garante a estrutura vazia com as
    * MESMAS colunas de SigOpCpoBO.CarregarComposicao(), para a grade montar
    * sem erro mesmo com a composicao vazia.
    *
    * PUBLIC: TesteAutomatico.prg chama THIS.oForm.CarregarDados() de FORA da
    * classe (teste CarregarDadosReais) - PEMSTATUS nao distingue escopo, e
    * metodo PROTECTED entraria no branch do teste e estouraria "Property
    * CARREGARDADOS is not found" (regra #3, mesmo motivo de CarregarLista).
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDados()
        LOCAL loc_lSucesso, loc_cCursorGrade, loc_cCursorRodape, loc_cCursorTipos
        loc_lSucesso      = .F.
        loc_cCursorGrade  = THIS.this_oBusinessObject.this_cCursorGrade
        loc_cCursorRodape = THIS.this_oBusinessObject.this_cCursorRodape
        loc_cCursorTipos  = THIS.this_oBusinessObject.this_cCursorTipos

        IF THIS.this_oBusinessObject.CarregarComposicao()
            loc_lSucesso = .T.
        ELSE
            MsgErro(THIS.this_oBusinessObject.this_cMensagemErro, ;
                    "Erro ao Carregar Composi" + CHR(231) + CHR(227) + "o")
        ENDIF

        IF !USED(loc_cCursorGrade)
            SET NULL ON
            CREATE CURSOR (loc_cCursorGrade) ;
                (Marcas L, Cidchaves C(20), Mats C(14), Dpros C(65), ;
                 Qtds N(8,3), UniCompos C(3), PCompos N(11,5), ;
                 Moeds C(3), Totas N(11,3), Etiqs C(1), Reffs C(40), ;
                 FigJpgs M, Tipos C(20))
            SET NULL OFF
        ENDIF

        *-- Fallback irmao do bloco acima: BO.CarregarComposicao() so chama
        *-- CarregarTipos() (que cria cursor_4c_Tipos) dentro do ramo de
        *-- SUCESSO do SQLEXEC da composicao. Com a conexao invalida,
        *-- SQLEXEC DISPARA EXCECAO (nao so devolve -1) e o metodo cai
        *-- direto no CATCH, pulando CarregarTipos() por completo - cursor_
        *-- 4c_Tipos nunca chega a existir. Sem este fallback,
        *-- ConfigurarFiltroTipo() liga cbo_4c_CmbTipos.RowSource a um alias
        *-- inexistente e o VFP estoura "'field' phrase is not found." ao
        *-- resolver o BoundColumn, derrubando InicializarForm.
        IF !USED(loc_cCursorTipos)
            CREATE CURSOR (loc_cCursorTipos) (Tipos C(20))
        ENDIF

        IF USED(loc_cCursorRodape)
            USE IN (loc_cCursorRodape)
        ENDIF

        SET NULL ON
        CREATE CURSOR (loc_cCursorRodape) (Descrs C(100), Usuars C(10), Totas N(12,2))
        SET NULL OFF

        *-- "Insert Into crRodape (Totas) Values (0)" do selecionadados legado.
        *-- O REPLACE vai com "IN (<alias>)" EXPLICITO: AtualizarTotais() do
        *-- BO faz "SELECT ... INTO CURSOR <tmp>" seguido de "USE IN <tmp>", e
        *-- fechar o cursor CORRENTE deixa a work area VAZIA - um REPLACE sem
        *-- alias logo depois estoura "No table is open in the current work
        *-- area." e derruba o InicializarForm (o form nao abre).
        SELECT (loc_cCursorRodape)
        APPEND BLANK
        REPLACE Totas WITH 0 IN (loc_cCursorRodape)

        IF loc_lSucesso AND THIS.this_oBusinessObject.this_nQtdeComponentes > 0
            THIS.this_oBusinessObject.AtualizarTotais()
            REPLACE Totas WITH THIS.this_oBusinessObject.this_nTotalTotas ;
                IN (loc_cCursorRodape)
        ENDIF

        IF USED(loc_cCursorGrade)
            SELECT (loc_cCursorGrade)
            GO TOP
        ENDIF

        SELECT (loc_cCursorRodape)
        GO TOP

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarGridItens - grade de componentes da composicao (grdItens do
    * legado), ligada a cursor_4c_Grade (ja populado por CarregarDados()).
    * Geometria e colunas TRANSCRITAS do dump (SIGOPCPO.grdItens +
    * PROCEDURE montagrades): 8 colunas, Column.InputMask/ControlSource
    * sao propriedades que a Column repassa ao CurrentControl - igual ao
    * legado. Ordem de configuracao segue o padrao canonico (ColumnCount ->
    * RecordSource -> ControlSource -> Header1.Caption -> Width por ultimo -
    * Problema 48/regra #41): mexer em Width ANTES de RecordSource/
    * ControlSource estabilizarem reseta tudo para o default 90.
    *
    * Column1 recebe CheckBox via AddObject + CurrentControl + Sparse = .F.
    * (regra #18 - AddObject sozinho NAO faz o controle aparecer). O For
    * Movable/Resizable/ReadOnly do legado (.Column&lcCol..ReadOnly =
    * (I > 1)) foi transcrito coluna a coluna: Column1 fica EDITAVEL (o
    * checkbox), Column2-8 continuam ReadOnly - e o ReadOnly de Column vem
    * DEPOIS do ReadOnly do Grid (regra #18).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarGridItens()
        THIS.AddObject("grd_4c_Itens", "Grid")
        WITH THIS.grd_4c_Itens
            .Top               = 198
            .Left              = 10
            .Width             = 980
            .Height            = 371
            .FontName          = "Tahoma"
            .FontSize          = 8
            .AllowHeaderSizing = .F.
            .AllowRowSizing    = .F.
            .DeleteMark        = .F.
            .RecordMark        = .F.
            .HeaderHeight      = 16
            .RowHeight         = 18
            .ScrollBars        = 2
            .GridLineColor     = RGB(238, 238, 238)
            .ToolTipText       = "Grade de Produtos"
            .ReadOnly          = .T.
        ENDWITH

        *-- Vinculo ao cursor + colunas: extraido para VincularGradeItens()
        *-- porque CarregarLista() tem de poder REFAZE-LO (Problema 48 -
        *-- re-atribuir RecordSource reseta Column.Width/Header1.Caption e
        *-- destroi o CurrentControl do CheckBox). Chamado DEPOIS do
        *-- .ReadOnly = .T. do Grid, porque o ReadOnly do grid propaga para
        *-- as colunas e sobrescreveria o Column1.ReadOnly = .F. (regra #18).
        THIS.VincularGradeItens()

        WITH THIS.grd_4c_Itens
            .Visible = .T.
        ENDWITH

        *-- AfterRowColChange de SIGOPCPO.grdItens: decodifica a imagem do
        *-- componente corrente (equivalente a ImgFigJpg.Picture/Visible do
        *-- legado) e recalcula os totais (ThisForm.AtuaTotas). Nao filtra
        *-- par_nColIndex - carrega o detalhe da linha corrente, uso correto
        *-- deste evento (regra #46). Ligado AQUI, e nao em
        *-- VincularGradeItens(), porque o objeto Grid nunca eh recriado: um
        *-- 2o BINDEVENT do mesmo par (objeto, evento) somaria uma segunda
        *-- chamada ao mesmo handler a cada re-vinculo.
        BINDEVENT(THIS.grd_4c_Itens, "AfterRowColChange", THIS, "GradeItensAfterRowColChange")
    ENDPROC

    *--------------------------------------------------------------------------
    * VincularGradeItens - liga grd_4c_Itens a cursor_4c_Grade e configura as
    * 8 colunas. Extraido de ConfigurarGridItens() para ser REUSADO por
    * CarregarLista(): a ordem canonica eh ColumnCount -> RecordSource ->
    * ControlSource -> Header1.Caption -> Width por ULTIMO (Problema 48 /
    * regra #41), porque re-atribuir RecordSource reseta Width e Caption para
    * o default 90/"Header1" e DESTROI o CurrentControl do CheckBox da
    * Column1 (regra #18) - quem re-vincula tem de repetir o bloco INTEIRO.
    *
    * ColumnCount so eh tocado quando esta diferente de 8: atribuir
    * ColumnCount RECRIA os objetos Column, matando o CheckBox e os
    * BINDEVENT dele. Por isso os 4 handlers do CheckBox sao ligados APENAS
    * no passe em que o controle de fato nasce (AddObject) - religar sem o
    * AddObject somaria uma 2a chamada do mesmo handler por evento, e o
    * toggle da marcacao se anularia.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE VincularGradeItens()
        LOCAL loc_cCursor, loc_lCriouCheck
        loc_cCursor    = THIS.this_oBusinessObject.this_cCursorGrade
        loc_lCriouCheck = .F.

        WITH THIS.grd_4c_Itens
            IF .ColumnCount != 8
                .ColumnCount = 8
            ENDIF

            .RecordSource = loc_cCursor

            .Column1.ControlSource = loc_cCursor + ".Marcas"
            .Column2.ControlSource = loc_cCursor + ".Mats"
            .Column3.ControlSource = loc_cCursor + ".Dpros"
            .Column4.ControlSource = loc_cCursor + ".Qtds"
            .Column5.ControlSource = loc_cCursor + ".UniCompos"
            .Column6.ControlSource = loc_cCursor + ".PCompos"
            .Column7.ControlSource = loc_cCursor + ".Moeds"
            .Column8.ControlSource = loc_cCursor + ".Totas"

            .Column1.Header1.Caption = ""
            .Column2.Header1.Caption = "Item"
            .Column3.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
            .Column4.Header1.Caption = "Qtde."
            .Column5.Header1.Caption = "Uni"
            .Column6.Header1.Caption = "Valor Unit" + CHR(225) + "rio"
            .Column7.Header1.Caption = "Moe"
            .Column8.Header1.Caption = "Valor Total"

            .Column4.InputMask = "99999.999"
            .Column6.InputMask = "99999999.999"
            .Column8.InputMask = "99999999.99"

            .Column1.Width = 15
            .Column2.Width = 120
            .Column3.Width = 394
            .Column4.Width = 120
            .Column5.Width = 31
            .Column6.Width = 120
            .Column7.Width = 31
            .Column8.Width = 120

            .Column1.FontName  = "Verdana"
            .Column1.FontSize  = 8
            .Column2.FontName  = "Verdana"
            .Column2.FontSize  = 8
            .Column3.FontName  = "Verdana"
            .Column3.FontSize  = 8
            .Column4.FontName  = "Verdana"
            .Column4.FontSize  = 8
            .Column5.FontName  = "Verdana"
            .Column5.FontSize  = 8
            .Column6.FontName  = "Verdana"
            .Column6.FontSize  = 8
            .Column7.FontName  = "Verdana"
            .Column7.FontSize  = 8
            .Column8.FontBold  = .T.
            .Column8.FontName  = "Verdana"
            .Column8.FontSize  = 8
            .Column8.BackColor = RGB(245, 251, 136)

            .Column1.Movable   = .F.
            .Column1.Resizable = .F.
            .Column1.ReadOnly  = .F.
            .Column2.Movable   = .F.
            .Column2.Resizable = .F.
            .Column2.ReadOnly  = .T.
            .Column3.Movable   = .F.
            .Column3.Resizable = .F.
            .Column3.ReadOnly  = .T.
            .Column4.Movable   = .F.
            .Column4.Resizable = .F.
            .Column4.ReadOnly  = .T.
            .Column5.Movable   = .F.
            .Column5.Resizable = .F.
            .Column5.ReadOnly  = .T.
            .Column6.Movable   = .F.
            .Column6.Resizable = .F.
            .Column6.ReadOnly  = .T.
            .Column7.Movable   = .F.
            .Column7.Resizable = .F.
            .Column7.ReadOnly  = .T.
            .Column8.Movable   = .F.
            .Column8.Resizable = .F.
            .Column8.ReadOnly  = .T.

        ENDWITH

        *-- CheckBox da coluna de marcacao. Criado e configurado por CAMINHO
        *-- COMPLETO, FORA de qualquer WITH: dentro de um WITH, um
        *-- ".filho.AddObject(...)" seguido de "WITH .filho.neto" eh o padrao
        *-- de WITH aninhado que o VFP9 resolve mal - as propriedades do neto
        *-- sao ignoradas em SILENCIO, e o checkbox sairia com a geometria
        *-- default sem nenhum erro na tela.
        IF !PEMSTATUS(THIS.grd_4c_Itens.Column1, "chk_4c_Marca", 5)
            THIS.grd_4c_Itens.Column1.AddObject("chk_4c_Marca", "CheckBox")

            WITH THIS.grd_4c_Itens.Column1.chk_4c_Marca
                .Top       = 2
                .Left      = 2
                .Caption   = ""
                .FontName  = "Verdana"
                .FontSize  = 8
                .Alignment = 0
            ENDWITH

            loc_lCriouCheck = .T.
        ENDIF

        *-- AddObject sozinho NAO faz o controle aparecer: sem CurrentControl
        *-- a Column continua desenhando o Text1 dela, e sem Sparse = .F. o
        *-- CheckBox so apareceria na linha ativa (regra #18).
        THIS.grd_4c_Itens.Column1.CurrentControl = "chk_4c_Marca"
        THIS.grd_4c_Itens.Column1.Sparse         = .F.

        *-- Toggle da marcacao do componente (Column1.Check1 do legado): o
        *-- binding nativo do CheckBox na Column NAO alterna o valor (regra
        *-- do CheckBox em Grid - exige os 4 handlers). MouseDown e Click
        *-- apenas suprimem o toggle padrao (NoDefault); MouseUp e
        *-- KeyPress(13/32) fazem o toggle de fato, delegando ambos a
        *-- AlternarMarcaLinhaAtual() (mesmo corpo do Procedure/MouseUp e do
        *-- KeyPress legado: Replace Marcas With Not Marcas + refresh +
        *-- AtuaTotas). Ligados SOMENTE no passe em que o CheckBox nasceu -
        *-- ver comentario do metodo.
        IF loc_lCriouCheck
            BINDEVENT(THIS.grd_4c_Itens.Column1.chk_4c_Marca, "MouseDown", THIS, "ChkMarcaMouseDown")
            BINDEVENT(THIS.grd_4c_Itens.Column1.chk_4c_Marca, "MouseUp", THIS, "ChkMarcaMouseUp")
            BINDEVENT(THIS.grd_4c_Itens.Column1.chk_4c_Marca, "KeyPress", THIS, "ChkMarcaKeyPress")
            BINDEVENT(THIS.grd_4c_Itens.Column1.chk_4c_Marca, "Click", THIS, "ChkMarcaClick")
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarGridRodape - grade de totais (grdRodape do legado), ligada a
    * cursor_4c_Rodape (1 linha, ja populada por CarregarDados()). Geometria
    * e colunas TRANSCRITAS do dump (SIGOPCPO.grdRodape + PROCEDURE
    * montagrades): 3 colunas, todas ReadOnly - mesmo ordem canonica
    * (ControlSource -> Header1.Caption -> Width por ultimo).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarGridRodape()
        LOCAL loc_cCursor
        loc_cCursor = THIS.this_oBusinessObject.this_cCursorRodape

        THIS.AddObject("grd_4c_Rodape", "Grid")
        WITH THIS.grd_4c_Rodape
            .Top               = 566
            .Left              = 542
            .Width             = 447
            .Height            = 23
            .FontName          = "Arial"
            .AllowHeaderSizing = .F.
            .AllowRowSizing    = .F.
            .DeleteMark        = .F.
            .RecordMark        = .F.
            .HeaderHeight      = 4
            .ScrollBars        = 2
            .BackColor         = RGB(224, 253, 254)
            .ToolTipText       = "Totais"
            .ColumnCount       = 3
            .ReadOnly          = .T.
            .RecordSource      = loc_cCursor

            .Column1.ControlSource = loc_cCursor + ".Descrs"
            .Column2.ControlSource = loc_cCursor + ".Usuars"
            .Column3.ControlSource = loc_cCursor + ".Totas"

            .Column1.Header1.Caption = ""
            .Column2.Header1.Caption = ""
            .Column3.Header1.Caption = ""

            .Column3.InputMask = "999999999.99"

            .Column1.Width = 152
            .Column2.Width = 152
            .Column3.Width = 120

            .Column1.FontName  = "Arial"
            .Column1.BackColor = RGB(245, 251, 136)
            .Column2.FontName  = "Arial"
            .Column2.FontBold  = .T.
            .Column2.BackColor = RGB(245, 251, 136)
            .Column3.FontName  = "Arial"
            .Column3.FontBold  = .T.
            .Column3.BackColor = RGB(245, 251, 136)

            .Column1.Header1.BackColor = RGB(188, 201, 254)
            .Column2.Header1.BackColor = RGB(162, 214, 242)
            .Column3.Header1.BackColor = RGB(162, 214, 242)

            .Column1.Movable   = .F.
            .Column1.Resizable = .F.
            .Column1.ReadOnly  = .T.
            .Column2.Movable   = .F.
            .Column2.Resizable = .F.
            .Column2.ReadOnly  = .T.
            .Column3.Movable   = .F.
            .Column3.Resizable = .F.
            .Column3.ReadOnly  = .T.

            .Visible = .T.
        ENDWITH

        *-- Eventos de CELULA da grade de totais, transcritos do legado.
        *-- Text1 eh membro NATIVO de Column (nao precisa de AddObject) e
        *-- por isso pode ser alvo direto de BINDEVENT; os handlers sao
        *-- PUBLIC (regra #3) e GotFocus/LostFocus nao passam parametro.
        *--
        *-- SIGOPCPO.grdRodape.Column1.Text1.GotFocus:
        *--     ThisForm.grdItens.Column1.SetFocus
        *-- SIGOPCPO.grdRodape.Column2.Text1.GotFocus:  This.Tag = This.Value
        *-- SIGOPCPO.grdRodape.Column2.Text1.LostFocus: This.Value = This.Tag
        BINDEVENT(THIS.grd_4c_Rodape.Column1.Text1, "GotFocus", ;
                  THIS, "ValidarFocoRodape")
        BINDEVENT(THIS.grd_4c_Rodape.Column2.Text1, "GotFocus", ;
                  THIS, "ValidarTagRodapeGotFocus")
        BINDEVENT(THIS.grd_4c_Rodape.Column2.Text1, "LostFocus", ;
                  THIS, "ValidarTagRodapeLostFocus")
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarFiltroTipo - Label + ComboBox de filtro por tipo de
    * composicao (Say1/cmbTipos do legado). Geometria TRANSCRITA do dump
    * (SIGOPCPO.Say1/cmbTipos): o label nao declara Width/Alignment no SCX
    * (classe say, regra #23), mas aqui o legado JA declara Width=32 - entao
    * NAO eh o caso da regra (nada a corrigir).
    *
    * cmbTipos eh fwcombo Style=2 (dropdown list) SEM ControlSource: o
    * legado o popula via Clear/AddItem a partir de LocalTpCom (SigCdTpc),
    * ja feito pela BO em CarregarTipos() -> cursor_4c_Tipos. Aqui o combo
    * liga via RowSourceType=2 (Alias) nesse MESMO cursor (ja existe quando
    * este metodo roda - chamado DEPOIS de CarregarDados() em
    * InicializarForm), o que reproduz a lista sem reimplementar o
    * Clear/AddItem. .Value recebe this_cTipoSelecionado (equivalente a
    * ThisForm.cmbTipos.Value = Iif(llBrc, Space(20), LocalTpCom.Tipos) do
    * SelecionaDados legado), DEPOIS do RowSource estar definido. O Valid
    * do legado (Set Filter To Tipos = cmbTipos.Value In crGrade + Refresh)
    * eh ligado no fim deste metodo e implementado em ValidarFiltroTipo(),
    * delegando a THIS.this_oBusinessObject.AplicarFiltroTipo().
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarFiltroTipo()
        LOCAL loc_cCursorTipos
        loc_cCursorTipos = THIS.this_oBusinessObject.this_cCursorTipos

        THIS.AddObject("lbl_4c_Label1", "Label")
        WITH THIS.lbl_4c_Label1
            .Top       = 169
            .Left      = 296
            .Width     = 32
            .Height    = 15
            .AutoSize  = .F.
            .BackStyle = 0
            .Alignment = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .T.
            .ForeColor = RGB(90, 90, 90)
            .Caption   = "Tipo :"
            .Visible   = .T.
        ENDWITH

        THIS.AddObject("cbo_4c_CmbTipos", "ComboBox")
        WITH THIS.cbo_4c_CmbTipos
            .Top          = 165
            .Left         = 335
            .Width        = 325
            .Height       = 23
            .FontName     = "Courier New"
            .Style        = 2
            .ToolTipText  = "Sele" + CHR(231) + CHR(227) + "o de Tipos"
            .ColumnCount  = 1
            .BoundColumn  = 1
            .RowSourceType = 2
            .RowSource    = loc_cCursorTipos
            .Visible      = .T.
        ENDWITH

        IF USED(loc_cCursorTipos) AND RECCOUNT(loc_cCursorTipos) > 0
            THIS.cbo_4c_CmbTipos.Value = THIS.this_oBusinessObject.this_cTipoSelecionado
        ENDIF

        *-- Guarda de valor-nao-mudou inicializada com o tipo que o
        *-- SelecionaDados legado ja deixou aplicado em cursor_4c_Grade
        *-- (CarregarComposicao -> CarregarTipos -> AplicarFiltroTipo da BO),
        *-- ANTES de ligar os eventos: assim a primeira interacao real do
        *-- usuario eh a primeira reaplicacao do filtro.
        THIS.this_cTipoFiltroAtual = THIS.this_oBusinessObject.this_cTipoSelecionado

        *-- Valid do cmbTipos legado. BINDEVENT exige metodo PUBLIC (regra
        *-- #3) - ValidarFiltroTipo nao leva PROTECTED. Dois eventos: o
        *-- InteractiveChange reage na hora em que o usuario escolhe o item
        *-- do dropdown (Style=2) e o LostFocus eh o equivalente literal do
        *-- Valid (que no legado roda ao SAIR do campo); a guarda
        *-- this_cTipoFiltroAtual impede o trabalho duplicado. Nenhum dos
        *-- dois eventos passa parametro, por isso o handler nao declara
        *-- nenhum.
        BINDEVENT(THIS.cbo_4c_CmbTipos, "InteractiveChange", THIS, "ValidarFiltroTipo")
        BINDEVENT(THIS.cbo_4c_CmbTipos, "LostFocus", THIS, "ValidarFiltroTipo")
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarBotoes - CommandGroup de saida (cntBotoes do legado), com os
    * 2 botoes OK/Cancelar. Geometria TRANSCRITA do dump
    * (SIGOPCPO.cntBotoes). CommandGroup NAO tem FontName/ForeColor (regra
    * #33) - essas propriedades vao nos Buttons(N), que tem as duas. Criado
    * DEPOIS de ConfigurarCabecalho() (chamado antes em InicializarForm),
    * para desenhar por cima da faixa cinza (Top = -2 sobrepoe o cabecalho,
    * igual ao legado). Buttons(1).Enabled reflete
    * this_oBusinessObject.this_lPermiteConfirmar - fonte UNICA do estado do
    * botao (equivalente a btnConfirmar.Enabled = (LocalTot.Qtds > 0) do
    * AtuaTotas legado, ja calculado em CarregarDados()). Os Click dos
    * botoes entram na Fase 7.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarBotoes()
        THIS.AddObject("cmg_4c_Botoes", "CommandGroup")
        WITH THIS.cmg_4c_Botoes
            .Top           = -2
            .Left          = 842
            .Width         = 160
            .Height        = 85
            .ButtonCount   = 2
            .BackStyle     = 0
            .BorderStyle   = 0
            .SpecialEffect = 1
            .BorderColor   = RGB(136, 189, 188)
            .Themes        = .F.

            WITH .Buttons(1)
                .Top             = 5
                .Left            = 5
                .Height          = 75
                .Width           = 75
                .FontBold        = .T.
                .FontItalic      = .T.
                .FontName        = "Comic Sans MS"
                .FontSize        = 8
                .WordWrap        = .T.
                .Picture         = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
                .Caption         = "\<OK"
                .MousePointer    = 15
                .ToolTipText     = "Gravar os Dados Informados"
                .SpecialEffect   = 0
                .PicturePosition = 13
                .ForeColor       = RGB(90, 90, 90)
                .BackColor       = RGB(255, 255, 255)
                .Themes          = .F.
                .Enabled         = THIS.this_oBusinessObject.this_lPermiteConfirmar
            ENDWITH

            WITH .Buttons(2)
                .Top           = 5
                .Left          = 80
                .Height        = 75
                .Width         = 75
                .FontBold      = .T.
                .FontItalic    = .T.
                .FontName      = "Comic Sans MS"
                .FontSize      = 8
                .WordWrap      = .T.
                .Picture       = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
                .Cancel        = .T.
                .Caption       = "Cancelar"
                .MousePointer  = 15
                .ToolTipText   = "[Esc] Sair Sem Gravar os Dados"
                .SpecialEffect = 0
                .ForeColor     = RGB(90, 90, 90)
                .BackColor     = RGB(255, 255, 255)
                .Themes        = .F.
            ENDWITH

            .Visible = .T.
        ENDWITH

        *-- Click de cada botao do CommandGroup (cntBotoes do legado - cada
        *-- Buttons(N) tem o proprio Click, nao um Click unico do grupo).
        BINDEVENT(THIS.cmg_4c_Botoes.Buttons(1), "Click", THIS, "BtnConfirmarClick")
        BINDEVENT(THIS.cmg_4c_Botoes.Buttons(2), "Click", THIS, "BtnSairClick")
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarImagem - Image de zoom do componente (ImgFigJpg do legado).
    * Geometria TRANSCRITA do dump (SIGOPCPO.ImgFigJpg): nasce OCULTA
    * (Visible = .F.), igual ao legado - so fica visivel quando a linha
    * corrente da grade tem FigJpgs preenchido (AfterRowColChange legado:
    * ThisForm.ImgFigJpg.Visible = .f. seguido de .Visible = .t. condicional
    * ao StrToFile ter sucesso). Por isso ela eh EXCLUIDA de
    * TornarControlesVisiveis (regra de containers que nascem ocultos de
    * proposito), e o Picture so eh atribuido pelo AfterRowColChange real
    * (Fase 7), nunca aqui.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarImagem()
        THIS.AddObject("img_4c_ImgFigJpg", "Image")
        WITH THIS.img_4c_ImgFigJpg
            .Top         = 84
            .Left        = 12
            .Width       = 252
            .Height      = 106
            .Anchor      = 0
            .Stretch     = 1
            .Enabled     = .T.
            .ToolTipText = "Imagem do Produto (Clique Duplo Para Zoom)"
            .Picture     = ""
            .Visible     = .F.
        ENDWITH

        *-- Click de SIGOPCPO.ImgFigJpg: zoom da imagem do componente
        *-- corrente (Do Form SigOpZom do legado).
        BINDEVENT(THIS.img_4c_ImgFigJpg, "Click", THIS, "ImgFigJpgClick")
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarFiltroTipo - Valid do cmbTipos legado. Wrapper FINO: so cuida da
    * guarda de reentrancia e delega o corpo a ValidarFiltroTipoExec(), para
    * a flag ser liberada mesmo quando o corpo sai por um RETURN antecipado
    * (regra #47 - set/clear no proprio corpo trava a flag ligada e mata o
    * handler pelo resto da vida do form).
    *
    * PUBLIC (sem PROTECTED): eh alvo de BINDEVENT, e metodo PROTECTED falha
    * em silencio no bind (regra #3). Nem InteractiveChange nem LostFocus
    * passam parametro, por isso a assinatura eh vazia.
    *--------------------------------------------------------------------------
    PROCEDURE ValidarFiltroTipo()
        IF THIS.this_lEmFiltroTipo
            RETURN
        ENDIF

        THIS.this_lEmFiltroTipo = .T.
        THIS.ValidarFiltroTipoExec()
        THIS.this_lEmFiltroTipo = .F.
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarFiltroTipoExec - corpo da validacao do campo Tipo. Transcricao
    * do PROCEDURE Valid de SIGOPCPO.cmbTipos:
    *     Select crGrade
    *     Set Filter To Tipos = ThisForm.cmbTipos.Value In crGrade
    *     Go Top In crGrade
    *     ThisForm.grdItens.Refresh
    * O Set Filter/Go Top moram em
    * THIS.this_oBusinessObject.AplicarFiltroTipo() (fonte unica do filtro,
    * Fase 2) e a repintura em THIS.AtualizarRodape() (funil unico, regra
    * #21) - aqui fica apenas a leitura do campo e a guarda de
    * valor-nao-mudou.
    *
    * A comparacao da guarda usa ALLTRIM nos DOIS lados: o .Value vem de uma
    * coluna char(20) (padded) e this_cTipoFiltroAtual pode ter sido gravado
    * sem o padding, e com SET EXACT ON (config.prg) "X" == "X   " eh .F. -
    * sem o ALLTRIM a guarda nunca casaria e o filtro seria reaplicado duas
    * vezes por escolha. ALLTRIM aqui eh seguro porque a guarda so decide
    * REAPLICAR ou nao; quem compara contra o cursor eh a BO, com o valor
    * cru.
    *--------------------------------------------------------------------------
    PROCEDURE ValidarFiltroTipoExec()
        LOCAL loc_cTipo, loc_oErro

        TRY
            IF VARTYPE(THIS.this_oBusinessObject) != "O"
                MsgErro("Objeto de neg" + CHR(243) + "cio indispon" + CHR(237) + "vel.", ;
                        "Erro ao Filtrar por Tipo")
            ELSE
                loc_cTipo = THIS.cbo_4c_CmbTipos.Value
                IF VARTYPE(loc_cTipo) != "C"
                    loc_cTipo = THIS.this_oBusinessObject.this_cTipoEmBranco
                ENDIF

                IF ALLTRIM(loc_cTipo) == ALLTRIM(THIS.this_cTipoFiltroAtual)
                    *-- Tipo nao mudou: o filtro ja esta aplicado em
                    *-- cursor_4c_Grade e a grade ja reflete este tipo.
                    *-- Reaplicar so repintaria a grade de novo e perderia a
                    *-- linha corrente.
                ELSE
                    IF THIS.this_oBusinessObject.AplicarFiltroTipo(loc_cTipo)
                        THIS.this_cTipoFiltroAtual = THIS.this_oBusinessObject.this_cTipoSelecionado
                        *-- 0 = GO TOP: o Valid legado termina com
                        *-- "Go Top In crGrade" - trocou o filtro, a grade
                        *-- volta para a primeira linha do novo conjunto.
                        THIS.AtualizarRodape(0)
                    ELSE
                        MsgErro("N" + CHR(227) + "o foi poss" + CHR(237) + "vel aplicar o " + ;
                                "filtro de tipo de composi" + CHR(231) + CHR(227) + "o.", ;
                                "Erro ao Filtrar por Tipo")
                    ENDIF
                ENDIF
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Erro ao Filtrar por Tipo")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * AtualizarRodape - FUNIL UNICO de repintura: recalcula os totais pela
    * BO (fonte unica - AtuaTotas legado), espelha o total geral na linha de
    * cursor_4c_Rodape, repinta as DUAS grades e reflete o estado do botao
    * Confirmar. Equivalente ao PROCEDURE atuatotas legado:
    *     ThisForm.grdRodape.Column3.Text1.Value = LocalTot.Totas
    *     ThisForm.grdRodape.Column3.Refresh
    *     ThisForm.cntBotoes.btnConfirmar.Enabled = (LocalTot.Qtds > 0)
    * (no migrado o total vai para a COLUNA do cursor via REPLACE, igual ao
    * que CarregarDados() ja faz, em vez de escrever no .Value da celula -
    * assim o valor sobrevive a qualquer repintura do Grid).
    *
    * Popular/filtrar cursor NAO repinta a grade (regra #21): o Refresh tem
    * de rodar em TODO caminho que mexe no cursor, por isso ele mora aqui, e
    * nao dentro de cada handler.
    *
    * par_nRegistroGrade diz onde DEIXAR o ponteiro de cursor_4c_Grade, e eh
    * o chamador que decide - este metodo nao adivinha:
    *   - 0 / ausente -> GO TOP, que eh o que o legado faz no caminho do
    *     FILTRO (Go Top In crGrade no proprio Valid do cmbTipos);
    *   - RECNO() capturado ANTES pelo chamador -> volta para aquela linha,
    *     que eh o que o caminho do CHECKBOX precisa (Fase 7): a linha
    *     corrente eh o que o AfterRowColChange usa para escolher a imagem,
    *     e um GO TOP faria a grade saltar a cada marcacao.
    * Repor o ponteiro eh OBRIGATORIO nos dois casos: o SELECT ... SUM() de
    * AtualizarTotais() percorre o cursor e pode deixa-lo em EOF.
    *
    * O metodo eh o FUNIL de sincronismo desta tela, nos tres passos:
    *   1. THIS.FormParaBO()  - o que esta nos controles e na linha corrente
    *                           da grade vai para as properties do BO;
    *   2. BO.AtualizarTotais() - o BO recalcula o que eh dele (totais e
    *                           this_lPermiteConfirmar);
    *   3. THIS.BOParaForm()  - o estado do BO volta para os controles
    *                           (total do rodape, botao Confirmar, imagem do
    *                           componente, combo de tipo).
    * Nenhum handler escreve direto nesses controles: fonte unica.
    *
    * Reentrancia: os passos 1 e 3 mexem no ponteiro do cursor e repintam a
    * grade, o que redispara o AfterRowColChange dela - que chama este
    * mesmo metodo. this_lEmAtualizacao garante UM passe por acao do
    * usuario (ver comentario da property).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE AtualizarRodape(par_nRegistroGrade)
        LOCAL loc_cCursorGrade, loc_nRegGrade, loc_oErro

        IF THIS.this_lEmAtualizacao
            RETURN
        ENDIF

        loc_nRegGrade = IIF(VARTYPE(par_nRegistroGrade) = "N", par_nRegistroGrade, 0)

        THIS.this_lEmAtualizacao = .T.

        TRY
            IF VARTYPE(THIS.this_oBusinessObject) != "O"
                MsgErro("Objeto de neg" + CHR(243) + "cio indispon" + CHR(237) + "vel.", ;
                        "Erro ao Atualizar Totais")
            ELSE
                loc_cCursorGrade = THIS.this_oBusinessObject.this_cCursorGrade

                *-- Ponteiro ANTES de FormParaBO(): eh a linha corrente que
                *-- CarregarDoCursor() le para alimentar o BO.
                IF USED(loc_cCursorGrade)
                    SELECT (loc_cCursorGrade)
                    IF loc_nRegGrade > 0 AND loc_nRegGrade <= RECCOUNT()
                        GO loc_nRegGrade
                    ELSE
                        GO TOP
                    ENDIF
                ENDIF

                THIS.FormParaBO()
                THIS.this_oBusinessObject.AtualizarTotais()

                IF PEMSTATUS(THIS, "grd_4c_Itens", 5)
                    THIS.grd_4c_Itens.Refresh()
                ENDIF

                THIS.BOParaForm()
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Erro ao Atualizar Totais")
        ENDTRY

        *-- Liberada FORA do TRY/CATCH para nunca travar ligada quando o
        *-- corpo estourar (mesmo motivo da guarda do lookup, regra #47).
        THIS.this_lEmAtualizacao = .F.
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarFocoRodape - GotFocus de SIGOPCPO.grdRodape.Column1.Text1
    * legado, que eh uma unica linha: ThisForm.grdItens.Column1.SetFocus.
    * A grade de totais eh somente-leitura (Grid.ReadOnly = .T. + as 3
    * Column.ReadOnly = .T.), entao o legado DEVOLVE o foco a grade de
    * itens assim que ela o recebe por Tab.
    *
    * PUBLIC (alvo de BINDEVENT, regra #3) e sem parametro (GotFocus nao
    * passa nenhum). Sem TRY/CATCH de proposito: um dialogo modal de erro
    * disparado por uma troca de foco seria pior que o proprio problema -
    * as pre-condicoes do SetFocus (grade existente, visivel, habilitada e
    * com registro) sao conferidas por guarda explicita. A devolucao de
    * foco nao reentra: o SetFocus leva o foco PARA FORA da grade de
    * totais, logo o GotFocus dela nao dispara de novo.
    *--------------------------------------------------------------------------
    PROCEDURE ValidarFocoRodape()
        LOCAL loc_cCursorGrade

        IF VARTYPE(THIS.this_oBusinessObject) != "O"
            RETURN
        ENDIF

        IF !PEMSTATUS(THIS, "grd_4c_Itens", 5)
            RETURN
        ENDIF

        loc_cCursorGrade = THIS.this_oBusinessObject.this_cCursorGrade
        IF !USED(loc_cCursorGrade) OR RECCOUNT(loc_cCursorGrade) = 0
            RETURN
        ENDIF

        IF THIS.grd_4c_Itens.Visible AND THIS.grd_4c_Itens.Enabled
            THIS.grd_4c_Itens.Column1.SetFocus()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarTagRodapeGotFocus - GotFocus de SIGOPCPO.grdRodape.Column2.Text1
    * legado (This.Tag = This.Value): guarda o valor original da celula ao
    * entrar nela. Tag de TextBox aceita SOMENTE caractere, e Column2 esta
    * ligada a cursor_4c_Rodape.Usuars (char(10)), entao o valor ja chega
    * como caractere - o VARTYPE abaixo cobre o caso de a celula ainda nao
    * ter valor ligado.
    *
    * PUBLIC (alvo de BINDEVENT) e sem parametro (GotFocus nao passa
    * nenhum).
    *--------------------------------------------------------------------------
    PROCEDURE ValidarTagRodapeGotFocus()
        LOCAL loc_oCelula

        IF !PEMSTATUS(THIS, "grd_4c_Rodape", 5)
            RETURN
        ENDIF

        loc_oCelula = THIS.grd_4c_Rodape.Column2.Text1
        IF VARTYPE(loc_oCelula.Value) = "C"
            loc_oCelula.Tag = loc_oCelula.Value
        ELSE
            loc_oCelula.Tag = TRANSFORM(loc_oCelula.Value)
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarTagRodapeLostFocus - LostFocus de
    * SIGOPCPO.grdRodape.Column2.Text1 legado (This.Value = This.Tag):
    * restaura o valor guardado no GotFocus ao sair da celula, desfazendo
    * qualquer alteracao. Eh a trava de edicao do legado para essa celula,
    * complementar ao Column2.ReadOnly = .T. - sem ela a trava ficaria
    * apenas na propriedade, e a propriedade eh resetada por qualquer
    * re-bind de RecordSource (Problema 48).
    *
    * So restaura quando o valor REALMENTE mudou e quando o tipo do Tag
    * (sempre caractere) bate com o tipo da celula: atribuir caractere a
    * celula numerica dispararia "Data type mismatch", e a celula so eh
    * numerica se o RecordSource tiver sido re-vinculado a outra coluna.
    *
    * PUBLIC (alvo de BINDEVENT) e sem parametro (LostFocus nao passa
    * nenhum).
    *--------------------------------------------------------------------------
    PROCEDURE ValidarTagRodapeLostFocus()
        LOCAL loc_oCelula

        IF !PEMSTATUS(THIS, "grd_4c_Rodape", 5)
            RETURN
        ENDIF

        loc_oCelula = THIS.grd_4c_Rodape.Column2.Text1
        IF VARTYPE(loc_oCelula.Value) != "C" OR VARTYPE(loc_oCelula.Tag) != "C"
            RETURN
        ENDIF

        IF !(loc_oCelula.Value == loc_oCelula.Tag)
            loc_oCelula.Value = loc_oCelula.Tag
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * AlternarMarcaLinhaAtual - corpo comum do MouseUp e do KeyPress(13/32) de
    * SIGOPCPO.grdItens.Column1.Check1:
    *     Replace Marcas With Not Marcas In crGrade
    *     ThisForm.grdItens.Column1.Refresh
    *     ThisForm.grdItens.Refresh
    *     ThisForm.AtuaTotas
    * O refresh da grade de itens e a repintura do rodape (AtuaTotas) moram
    * no funil AtualizarRodape() (regra #21). RECNO() eh capturado ANTES de
    * chamar AtualizarRodape() e repassado a ela, para a grade permanecer na
    * MESMA linha que o usuario acabou de marcar (AtualizarRodape so faz
    * GO TOP quando recebe 0 - ver comentario do metodo).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE AlternarMarcaLinhaAtual()
        LOCAL loc_cCursor, loc_nRecno, loc_oErro

        TRY
            IF VARTYPE(THIS.this_oBusinessObject) != "O"
                MsgErro("Objeto de neg" + CHR(243) + "cio indispon" + CHR(237) + "vel.", ;
                        "Erro ao Marcar Componente")
            ELSE
                loc_cCursor = THIS.this_oBusinessObject.this_cCursorGrade

                IF USED(loc_cCursor) AND !EOF(loc_cCursor)
                    SELECT (loc_cCursor)
                    REPLACE Marcas WITH !Marcas
                    loc_nRecno = RECNO()

                    IF PEMSTATUS(THIS, "grd_4c_Itens", 5)
                        THIS.grd_4c_Itens.Column1.Refresh()
                    ENDIF

                    THIS.AtualizarRodape(loc_nRecno)
                ENDIF
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Erro ao Marcar Componente")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * ChkMarcaMouseDown - Procedure (MouseDown) de Check1 legado: so suprime
    * o toggle padrao do CheckBox (NoDefault). PUBLIC (alvo de BINDEVENT,
    * regra #3); assinatura completa de MouseDown, mesmo sem uso.
    *--------------------------------------------------------------------------
    PROCEDURE ChkMarcaMouseDown(par_nButton, par_nShift, par_nXCoord, par_nYCoord)
        NODEFAULT
    ENDPROC

    *--------------------------------------------------------------------------
    * ChkMarcaMouseUp - Procedure (MouseUp) de Check1 legado: alterna a
    * marcacao da linha corrente, sem checar qual botao do mouse (o legado
    * tambem nao checa). PUBLIC (alvo de BINDEVENT, regra #3).
    *--------------------------------------------------------------------------
    PROCEDURE ChkMarcaMouseUp(par_nButton, par_nShift, par_nXCoord, par_nYCoord)
        THIS.AlternarMarcaLinhaAtual()
        NODEFAULT
    ENDPROC

    *--------------------------------------------------------------------------
    * ChkMarcaKeyPress - KeyPress de Check1 legado: alterna a marcacao so em
    * Enter(13)/Espaco(32), exatamente como o "If InList(nKeyCode, 13, 32)"
    * do legado - fora dessas teclas, nao chama NoDefault e o KeyPress segue
    * o processamento padrao. PUBLIC (alvo de BINDEVENT, regra #3).
    *--------------------------------------------------------------------------
    PROCEDURE ChkMarcaKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF INLIST(par_nKeyCode, 13, 32)
            THIS.AlternarMarcaLinhaAtual()
            NODEFAULT
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * ChkMarcaClick - Click de Check1 legado (so "NoDefault" - suprime o
    * toggle padrao, que fica a cargo do MouseUp/KeyPress). PUBLIC (alvo de
    * BINDEVENT, regra #3).
    *--------------------------------------------------------------------------
    PROCEDURE ChkMarcaClick()
        NODEFAULT
    ENDPROC

    *--------------------------------------------------------------------------
    * GradeItensAfterRowColChange - AfterRowColChange de SIGOPCPO.grdItens:
    *     Clear Resources
    *     ThisForm.ImgFigJpg.Picture = []
    *     ThisForm.ImgFigJpg.Visible = .f.
    *     If Not Empty(crGrade.FigJpgs) And Not IsNull(crGrade.FigJpgs) ;
    *         And (StrToFile(Strconv(Strtran(...),14), lcArq) > 0)
    *         ThisForm.ImgFigJpg.Picture = (lcArq)
    *         ThisForm.ImgFigJpg.Visible = .t.
    *     EndIf
    *     ThisForm.AtuaTotas
    * O corpo inteiro eh o funil THIS.AtualizarRodape(), que faz
    * FormParaBO() -> AtualizarTotais() -> BOParaForm(): eh o BOParaForm()
    * que troca a imagem (Picture/Visible), a partir do this_cFigjpgs que o
    * FormParaBO() acabou de ler da linha corrente, e a decodificacao do
    * base64 mora em THIS.this_oBusinessObject.DecodificarImagem() (fonte
    * unica, Fase 2). O unico trabalho deste handler eh dizer ao funil QUAL
    * linha eh a corrente - o funil nao adivinha (ver AtualizarRodape).
    *
    * PUBLIC (alvo de BINDEVENT, regra #3); par_nColIndex nao eh usado -
    * este handler carrega o detalhe da linha corrente, independente da
    * coluna de destino, que eh o uso CORRETO deste evento (regra #46).
    *--------------------------------------------------------------------------
    PROCEDURE GradeItensAfterRowColChange(par_nColIndex)
        LOCAL loc_cCursor, loc_oErro

        TRY
            IF VARTYPE(THIS.this_oBusinessObject) = "O"
                loc_cCursor = THIS.this_oBusinessObject.this_cCursorGrade

                IF USED(loc_cCursor) AND !EOF(loc_cCursor)
                    THIS.AtualizarRodape(RECNO(loc_cCursor))
                ELSE
                    THIS.AtualizarRodape(0)
                ENDIF
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Erro ao Carregar Imagem do Componente")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnConfirmarClick - Click de Buttons(1) do cntBotoes legado (OK):
    *     Select crGrade
    *     Set Filter To
    *     Go Top In crGrade
    *     Select crGrade
    *     Scan
    *         If Not Marcas
    *             Delete In crGrade
    *         EndIf
    *     EndScan
    *     ThisForm.Release
    * O descarte das linhas nao marcadas mora em
    * THIS.this_oBusinessObject.ConfirmarSelecao() (fonte unica, Fase 2). O
    * Release so acontece com sucesso - sem RETURN dentro do TRY (regra #1),
    * flag loc_lSucesso decide a saida DEPOIS do ENDTRY. PUBLIC (alvo de
    * BINDEVENT, regra #3).
    *--------------------------------------------------------------------------
    PROCEDURE BtnConfirmarClick()
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        TRY
            IF VARTYPE(THIS.this_oBusinessObject) != "O"
                MsgErro("Objeto de neg" + CHR(243) + "cio indispon" + CHR(237) + "vel.", ;
                        "Erro ao Confirmar Sele" + CHR(231) + CHR(227) + "o")
            ELSE
                IF THIS.this_oBusinessObject.ConfirmarSelecao()
                    loc_lSucesso = .T.
                ELSE
                    MsgErro(THIS.this_oBusinessObject.this_cMensagemErro, ;
                            "Erro ao Confirmar Sele" + CHR(231) + CHR(227) + "o")
                ENDIF
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Erro ao Confirmar Sele" + CHR(231) + CHR(227) + "o")
        ENDTRY

        IF loc_lSucesso
            THIS.Release()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnSairClick - Click de Buttons(2) do cntBotoes legado: o controle
    * legado se chama btnSair (Caption = "Cancelar" - ver comentario do
    * cabecalho do form: "btnSair descarta todas"):
    *     Select crGrade
    *     Set Filter To
    *     Go Top In crGrade
    *     Select crGrade
    *     Scan
    *         Delete In crGrade
    *     EndScan
    *     ThisForm.Release
    * O descarte INCONDICIONAL de todas as linhas mora em
    * THIS.this_oBusinessObject.CancelarSelecao() (fonte unica, Fase 2). O
    * Release acontece sempre - cancelar nunca falha de um jeito que impeca
    * sair do dialogo. PUBLIC (alvo de BINDEVENT, regra #3) e nomeado pelo
    * objeto do legado (btnSair) - e tambem o nome que o
    * TestFormWrapper/TesteAutomatico reconhece como metodo de encerramento
    * (BtnEncerrarClick/BtnFecharClick/BtnSairClick).
    *--------------------------------------------------------------------------
    PROCEDURE BtnSairClick()
        LOCAL loc_oErro

        TRY
            IF VARTYPE(THIS.this_oBusinessObject) = "O"
                THIS.this_oBusinessObject.CancelarSelecao()
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Erro ao Cancelar Sele" + CHR(231) + CHR(227) + "o")
        ENDTRY

        THIS.Release()
    ENDPROC

    *--------------------------------------------------------------------------
    * ImgFigJpgClick - Click de SIGOPCPO.ImgFigJpg legado:
    *     Select crGrade
    *     If Not Empty(crGrade.FigJpgs) And Not IsNull(crGrade.FigJpgs)
    *         lcFoto = Strconv(Strtran(...), 14)
    *         =StrToFile(lcFoto, lcArq)
    *     EndIf
    *     If File(lcArq)
    *         Do Form SigOpZom With lcArq, [Produto : ]+Mats+[ - ]+DPros, ;
    *                  [Ref. Fornecedor : ]+Reffs
    *     EndIf
    * A decodificacao mora em THIS.this_oBusinessObject.DecodificarImagem()
    * (fonte unica, Fase 2); a abertura do zoom em
    * THIS.AbrirFormZoomImagem() - SigOpZom esta FORA do escopo desta task
    * (ProximasMigracoes\SigOpZom.SCX ainda nao migrado), mesmo padrao do
    * FormSigMvSbn.ImgFigJpgDblClick: CREATEOBJECT guardado, ausencia
    * AVISADA via MsgAviso em vez de estourar "Class definition ... is not
    * found". Quando SigOpZom for migrado, esta chamada passa a funcionar
    * sem nenhuma alteracao aqui. PUBLIC (alvo de BINDEVENT, regra #3).
    *--------------------------------------------------------------------------
    PROCEDURE ImgFigJpgClick()
        LOCAL loc_cCursor, loc_cFigJpgs, loc_cArquivo, loc_cProduto, ;
              loc_cDescricao, loc_cReferencia, loc_oErro
        loc_cArquivo = ""

        TRY
            IF VARTYPE(THIS.this_oBusinessObject) = "O"
                loc_cCursor = THIS.this_oBusinessObject.this_cCursorGrade

                IF USED(loc_cCursor) AND !EOF(loc_cCursor)
                    loc_cFigJpgs    = TratarNulo(EVALUATE(loc_cCursor + ".FigJpgs"), "")
                    loc_cProduto    = TratarNulo(EVALUATE(loc_cCursor + ".Mats"), "")
                    loc_cDescricao  = TratarNulo(EVALUATE(loc_cCursor + ".Dpros"), "")
                    loc_cReferencia = TratarNulo(EVALUATE(loc_cCursor + ".Reffs"), "")

                    IF !EMPTY(loc_cFigJpgs) AND THIS.this_oBusinessObject.DecodificarImagem(loc_cFigJpgs)
                        loc_cArquivo = THIS.this_oBusinessObject.this_cArquivoImagem
                    ENDIF
                ENDIF
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Erro ao Abrir Zoom da Imagem")
            loc_cArquivo = ""
        ENDTRY

        *-- Legado: If File(lcArq) / Do Form SigOpZom With ... Show() de form
        *-- fica FORA de qualquer TRY (regra #29).
        IF !EMPTY(loc_cArquivo) AND FILE(loc_cArquivo)
            THIS.AbrirFormZoomImagem(loc_cArquivo, loc_cProduto, loc_cDescricao, loc_cReferencia)
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * AbrirFormZoomImagem - "Do Form SigOpZom With lcArq, 'Produto : '+...,
    * 'Ref. Fornecedor : '+..." do legado. SigOpZom ainda nao foi migrado
    * (ProximasMigracoes\SigOpZom.SCX) - mesma situacao documentada em
    * FormSigMvSbn.AbrirFormZoomImagem: CREATEOBJECT guardado em TRY/CATCH,
    * ausencia avisada via MsgAviso em vez de estourar "Class definition
    * FORMSIGOPZOM is not found". Show() fica FORA do TRY (regra #29).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE AbrirFormZoomImagem(par_cArquivo, par_cProduto, par_cDescricao, par_cReferencia)
        LOCAL loc_oForm, loc_oErro, loc_cLinha2, loc_cLinha3

        loc_cLinha2 = "Produto : " + ALLTRIM(par_cProduto) + " - " + ALLTRIM(par_cDescricao)
        loc_cLinha3 = "Ref. Fornecedor : " + ALLTRIM(par_cReferencia)

        TRY
            loc_oForm = CREATEOBJECT("FormSigOpZom", par_cArquivo, loc_cLinha2, loc_cLinha3)
        CATCH TO loc_oErro
            loc_oForm = .NULL.
        ENDTRY

        IF VARTYPE(loc_oForm) = "O"
            loc_oForm.Show()
        ELSE
            MsgAviso("M" + CHR(243) + "dulo de Zoom de Imagem (SigOpZom) ainda n" + CHR(227) + ;
                "o est" + CHR(225) + " dispon" + CHR(237) + "vel nesta vers" + CHR(227) + "o.", ;
                "Aviso")
        ENDIF
    ENDPROC

    *==========================================================================
    * Fase 8/8 - CONSOLIDACAO: o trio de sincronismo da tela
    *
    * CarregarLista() / FormParaBO() / BOParaForm() sao os tres metodos que
    * fecham a migracao. Nao ha HabilitarCampos/LimparCampos/
    * AjustarBotoesPorModo/BtnBuscarClick/BtnEncerrarClick aqui, e a ausencia
    * eh deliberada: sao convencao de form CRUD (Page1=Lista/Page2=Dados com
    * os modos INCLUIR/ALTERAR/VISUALIZAR). O SCX legado deste dialogo
    * (tasks/task710/SigOpCpo_form_codigo_fonte.txt) NAO tem modo de edicao,
    * NAO tem campo que se limpe (os unicos dados editaveis sao a marcacao
    * da Column1 e o combo de tipo, ambos sempre habilitados), e tem
    * exatamente DOIS botoes - OK (btnConfirmar) e Cancelar (btnSair), ja
    * entregues na Fase 7. Criar os cinco metodos aqui obrigaria a INVENTAR
    * modos e botoes que o legado nao tem (viola o PILAR 1 e a regra "NUNCA
    * inventar") ou a entregar metodos vazios (proibido pela regra de
    * completude).
    *==========================================================================

    *--------------------------------------------------------------------------
    * CarregarLista - liga a grade de componentes ao cursor JA populado e
    * repinta a tela. Eh o trecho FINAL do PROCEDURE selecionadados legado,
    * que o migrado nao executava:
    *     Go Top In crGrade
    *     ThisForm.grdItens.Refresh
    *     ThisForm.grdItens.Column1.SetFocus
    *     Go Top In crRodape
    *     ThisForm.grdRodape.Refresh
    * Popular cursor NAO repinta a grade (regra #21): sem este metodo, o
    * cursor abre cheio e a grade aparece VAZIA - o sintoma ("a tela nao traz
    * dados") manda o diagnostico para SQL/cursor/permissao.
    *
    * NAO re-consulta o banco: a carga eh de CarregarDados() (-> BO.
    * CarregarComposicao()), que roda ANTES das grades existirem porque
    * Column.ControlSource exige o cursor ja criado (regra #41). Este metodo
    * eh o passo seguinte - re-vincular e repintar - e por isso pode ser
    * chamado quantas vezes for preciso sem custo de SQL.
    *
    * O re-vinculo (VincularGradeItens) eh condicional: so refaz quando a
    * grade NAO esta mais apontando para o cursor certo (RecordSource vazio
    * ou trocado), porque re-atribuir RecordSource reseta Width/Caption das
    * colunas e destroi o CurrentControl do CheckBox (Problema 48/regra #18).
    *
    * PUBLIC: TesteAutomatico.prg chama THIS.oForm.CarregarLista() de FORA da
    * classe, e PEMSTATUS nao distingue escopo - metodo PROTECTED entraria no
    * branch do teste e estouraria "Property CARREGARLISTA is not found"
    * (regra #3).
    *--------------------------------------------------------------------------
    FUNCTION CarregarLista()
        LOCAL loc_lSucesso, loc_cCursorGrade, loc_cCursorRodape, loc_oErro
        loc_lSucesso = .F.

        TRY
            IF VARTYPE(THIS.this_oBusinessObject) != "O"
                MsgErro("Objeto de neg" + CHR(243) + "cio indispon" + CHR(237) + "vel.", ;
                        "Erro ao Carregar a Grade")
            ELSE
                loc_cCursorGrade  = THIS.this_oBusinessObject.this_cCursorGrade
                loc_cCursorRodape = THIS.this_oBusinessObject.this_cCursorRodape

                IF !USED(loc_cCursorGrade)
                    MsgErro("Cursor da composi" + CHR(231) + CHR(227) + "o (" + ;
                            loc_cCursorGrade + ") indispon" + CHR(237) + "vel.", ;
                            "Erro ao Carregar a Grade")
                ELSE
                    IF PEMSTATUS(THIS, "grd_4c_Itens", 5)
                        IF !(UPPER(ALLTRIM(THIS.grd_4c_Itens.RecordSource)) == ;
                             UPPER(ALLTRIM(loc_cCursorGrade)))
                            THIS.VincularGradeItens()
                        ENDIF
                    ENDIF

                    *-- "Go Top In crRodape" do legado: a linha unica de
                    *-- totais sempre repousa no topo.
                    IF USED(loc_cCursorRodape)
                        SELECT (loc_cCursorRodape)
                        GO TOP
                    ENDIF

                    *-- Totais + rodape + botao Confirmar + imagem pelo funil
                    *-- (fonte unica). 0 = GO TOP em cursor_4c_Grade, que eh
                    *-- o que o legado faz neste ponto.
                    THIS.AtualizarRodape(0)

                    *-- "ThisForm.grdItens.Column1.SetFocus" do legado: o
                    *-- dialogo abre com o foco na coluna de marcacao, para o
                    *-- usuario poder marcar com Espaco/Enter sem usar o mouse
                    *-- (os handlers de teclado do CheckBox dependem disso).
                    IF PEMSTATUS(THIS, "grd_4c_Itens", 5)
                        IF THIS.grd_4c_Itens.Visible AND THIS.grd_4c_Itens.Enabled ;
                           AND RECCOUNT(loc_cCursorGrade) > 0
                            THIS.grd_4c_Itens.Column1.SetFocus()
                        ENDIF
                    ENDIF

                    loc_lSucesso = .T.
                ENDIF
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Erro ao Carregar a Grade")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * FormParaBO - transfere para o BO TUDO o que o usuario pode alterar
    * nesta tela. A superficie editavel do dialogo legado sao apenas tres
    * coisas, e as tres estao cobertas:
    *   1. cbo_4c_CmbTipos.Value  -> this_cTipoSelecionado  (o cmbTipos do
    *      legado, cujo Valid aplica "Set Filter To Tipos = ..." em crGrade);
    *   2. a LINHA CORRENTE de cursor_4c_Grade -> as properties de linha do
    *      BO, via THIS.this_oBusinessObject.CarregarDoCursor() - inclui
    *      this_lMarcas (o CheckBox da Column1, unica coluna editavel) e
    *      this_cFigjpgs, que eh o que BOParaForm() usa para a imagem;
    *   3. a linha de cursor_4c_Rodape -> this_cDescrsRodape/
    *      this_cUsuarsRodape/this_nTotasRodape (as 3 celulas do grdRodape).
    * NAO ha mais nada: os outros 7 controles da grade sao Column.ReadOnly =
    * .T. e os dois labels do cabecalho sao somente-exibicao.
    *
    * CarregarDoCursor() eh PUBLIC na BusinessBase - chama-lo daqui eh
    * legitimo; o que nunca se chama de fora eh metodo PROTECTED (regra #51).
    *
    * O alias originalmente selecionado eh restaurado no fim: o metodo roda
    * dentro do funil AtualizarRodape(), que repos o ponteiro da grade ANTES
    * de chamar este metodo e conta com ele intacto depois.
    *
    * PROTECTED EXPLICITO: FormBase declara "PROTECTED PROCEDURE FormParaBO",
    * e em VFP9 a subclasse NAO pode ALARGAR o escopo herdado - escrever
    * "FUNCTION FormParaBO" sem o modificador nao torna o metodo publico, so
    * esconde de quem le que ele continua protegido. Medido nesta tela
    * (2026-10-30): chamado de um script solto devolve .F. sem executar o
    * corpo; chamado por THIS. de dentro da classe roda normalmente. Para
    * exercitar num harness, usar "DEFINE CLASS Probe AS FormSigOpCpo" com um
    * metodo publico que chame THIS.FormParaBO().
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION FormParaBO()
        LOCAL loc_lSucesso, loc_cCursorGrade, loc_cCursorRodape, ;
              loc_cAliasAnterior, loc_cTipo, loc_oErro
        loc_lSucesso = .F.

        TRY
            IF VARTYPE(THIS.this_oBusinessObject) != "O"
                MsgErro("Objeto de neg" + CHR(243) + "cio indispon" + CHR(237) + "vel.", ;
                        "Erro ao Transferir Dados da Tela")
            ELSE
                loc_cAliasAnterior = ALIAS()
                loc_cCursorGrade   = THIS.this_oBusinessObject.this_cCursorGrade
                loc_cCursorRodape  = THIS.this_oBusinessObject.this_cCursorRodape

                *-- 1. Tipo escolhido no combo. Style = 2 (dropdown list)
                *-- devolve CARACTERE; o PADR para 20 reproduz a largura de
                *-- SigCdTpc.Tipos char(20), que eh com o que o SET FILTER
                *-- compara (chave posicional - regra #42).
                IF PEMSTATUS(THIS, "cbo_4c_CmbTipos", 5)
                    loc_cTipo = THIS.cbo_4c_CmbTipos.Value
                    IF VARTYPE(loc_cTipo) != "C"
                        loc_cTipo = TRANSFORM(loc_cTipo)
                    ENDIF
                    THIS.this_oBusinessObject.this_cTipoSelecionado = PADR(loc_cTipo, 20)
                ENDIF

                *-- 2. Linha corrente da grade de componentes.
                IF USED(loc_cCursorGrade) AND !EOF(loc_cCursorGrade)
                    THIS.this_oBusinessObject.CarregarDoCursor(loc_cCursorGrade)
                ENDIF

                *-- 3. Celulas da grade de totais.
                IF USED(loc_cCursorRodape)
                    SELECT (loc_cCursorRodape)
                    IF !EOF()
                        THIS.this_oBusinessObject.this_cDescrsRodape = TratarNulo(Descrs, "")
                        THIS.this_oBusinessObject.this_cUsuarsRodape = TratarNulo(Usuars, "")
                        THIS.this_oBusinessObject.this_nTotasRodape  = TratarNulo(Totas, 0)
                    ENDIF
                ENDIF

                IF !EMPTY(loc_cAliasAnterior) AND USED(loc_cAliasAnterior)
                    SELECT (loc_cAliasAnterior)
                ENDIF

                loc_lSucesso = .T.
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Erro ao Transferir Dados da Tela")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * BOParaForm - caminho inverso: o estado do BO vai para os controles.
    * Reune, num lugar so, tudo o que o legado escreve na tela:
    *   - this_nTotalTotas       -> cursor_4c_Rodape.Totas + grdRodape
    *     ("ThisForm.grdRodape.Column3.Text1.Value = LocalTot.Totas /
    *     Column3.Refresh" do AtuaTotas legado - no migrado o valor vai para
    *     a COLUNA do cursor via REPLACE, e nao para o .Value da celula,
    *     assim sobrevive a qualquer repintura do Grid);
    *   - this_lPermiteConfirmar -> Buttons(1).Enabled
    *     ("ThisForm.cntBotoes.btnConfirmar.Enabled = (LocalTot.Qtds > 0)");
    *   - this_cFigjpgs          -> img_4c_ImgFigJpg.Picture/.Visible
    *     (o AfterRowColChange legado: limpa a imagem e so a mostra quando o
    *     base64 do componente corrente decodifica);
    *   - this_cCpros/this_cDprosProduto -> Caption e os dois labels da faixa
    *     (o "... - <Cpros> - <Dpros>" montado no Init legado);
    *   - this_cTipoSelecionado  -> cbo_4c_CmbTipos.Value
    *     ("ThisForm.cmbTipos.Value = Iif(llBrc, Space(20), LocalTpCom.Tipos)
    *     / cmbTipos.Refresh" do selecionadados legado).
    *
    * O combo so eh escrito quando o valor REALMENTE difere: atribuir .Value
    * dispara o InteractiveChange, que esta ligado a ValidarFiltroTipo() -
    * reescrever o mesmo valor reaplicaria o filtro e repintaria a grade de
    * novo (as guardas this_cTipoFiltroAtual/this_lEmFiltroTipo tambem
    * cortam isso, mas nao se deve depender de guarda para nao gerar
    * trabalho que nao existe).
    *
    * PROTECTED EXPLICITO pelo mesmo motivo de FormParaBO(): FormBase declara
    * "PROTECTED PROCEDURE BOParaForm" e o escopo vem da HERANCA - omitir o
    * modificador nao alarga nada. CarregarLista(), ao contrario, NAO existe
    * em FormBase e por isso fica publico de verdade.
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION BOParaForm()
        LOCAL loc_lSucesso, loc_cCursorRodape, loc_cAliasAnterior, ;
              loc_cTipoBO, loc_cCaption, loc_oErro
        loc_lSucesso = .F.

        TRY
            IF VARTYPE(THIS.this_oBusinessObject) != "O"
                MsgErro("Objeto de neg" + CHR(243) + "cio indispon" + CHR(237) + "vel.", ;
                        "Erro ao Exibir Dados na Tela")
            ELSE
                loc_cAliasAnterior = ALIAS()
                loc_cCursorRodape  = THIS.this_oBusinessObject.this_cCursorRodape

                *-- Total geral na linha unica do rodape. "IN (<alias>)"
                *-- EXPLICITO: este metodo roda logo depois de
                *-- AtualizarTotais(), que fecha o cursor temporario da soma e
                *-- com isso pode deixar a work area corrente VAZIA - REPLACE
                *-- sem alias ali estoura "No table is open in the current
                *-- work area.".
                IF USED(loc_cCursorRodape)
                    SELECT (loc_cCursorRodape)
                    GO TOP
                    IF !EOF()
                        REPLACE Totas WITH THIS.this_oBusinessObject.this_nTotalTotas ;
                            IN (loc_cCursorRodape)
                    ENDIF
                ENDIF

                IF PEMSTATUS(THIS, "grd_4c_Rodape", 5)
                    THIS.grd_4c_Rodape.Column3.Refresh()
                    THIS.grd_4c_Rodape.Refresh()
                ENDIF

                *-- Botao OK: habilitado so com quantidade marcada > 0.
                IF PEMSTATUS(THIS, "cmg_4c_Botoes", 5)
                    THIS.cmg_4c_Botoes.Buttons(1).Enabled = ;
                        THIS.this_oBusinessObject.this_lPermiteConfirmar
                ENDIF

                *-- Imagem do componente corrente: limpa primeiro (igual ao
                *-- legado) e so reaparece se o base64 decodificar.
                IF PEMSTATUS(THIS, "img_4c_ImgFigJpg", 5)
                    THIS.img_4c_ImgFigJpg.Picture = ""
                    THIS.img_4c_ImgFigJpg.Visible = .F.

                    IF !EMPTY(THIS.this_oBusinessObject.this_cFigjpgs)
                        IF THIS.this_oBusinessObject.DecodificarImagem( ;
                               THIS.this_oBusinessObject.this_cFigjpgs)
                            THIS.img_4c_ImgFigJpg.Picture = ;
                                THIS.this_oBusinessObject.this_cArquivoImagem
                            THIS.img_4c_ImgFigJpg.Visible = .T.
                        ENDIF
                    ENDIF
                ENDIF

                *-- Titulo da faixa: produto-pai cuja composicao esta na tela.
                IF !EMPTY(THIS.this_oBusinessObject.this_cCpros)
                    loc_cCaption = "Composi" + CHR(231) + CHR(227) + "o de Produtos - " + ;
                        ALLTRIM(THIS.this_oBusinessObject.this_cCpros) + " - " + ;
                        ALLTRIM(THIS.this_oBusinessObject.this_cDprosProduto)

                    THIS.Caption = loc_cCaption

                    IF PEMSTATUS(THIS, "cnt_4c_Sombra", 5)
                        THIS.cnt_4c_Sombra.lbl_4c_LblSombra.Caption = loc_cCaption
                        THIS.cnt_4c_Sombra.lbl_4c_LblTitulo.Caption = loc_cCaption
                    ENDIF
                ENDIF

                *-- Tipo filtrado: so escreve quando difere (ver comentario).
                IF PEMSTATUS(THIS, "cbo_4c_CmbTipos", 5)
                    loc_cTipoBO = THIS.this_oBusinessObject.this_cTipoSelecionado
                    IF VARTYPE(THIS.cbo_4c_CmbTipos.Value) = "C" ;
                       AND !(PADR(THIS.cbo_4c_CmbTipos.Value, 20) == PADR(loc_cTipoBO, 20))
                        THIS.cbo_4c_CmbTipos.Value = loc_cTipoBO
                        THIS.cbo_4c_CmbTipos.Refresh()
                    ENDIF
                ENDIF

                IF !EMPTY(loc_cAliasAnterior) AND USED(loc_cAliasAnterior)
                    SELECT (loc_cAliasAnterior)
                ENDIF

                loc_lSucesso = .T.
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Erro ao Exibir Dados na Tela")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * TornarControlesVisiveis - torna todos os controles visiveis
    * recursivamente. FILTRO: img_4c_ImgFigJpg eh o UNICO controle flutuante
    * deste form - nasce Visible = .F. de proposito (igual ao ImgFigJpg
    * legado) e so aparece quando a grade tem imagem para exibir.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
        LOCAL loc_i, loc_oControl

        FOR loc_i = 1 TO par_oContainer.ControlCount
            loc_oControl = par_oContainer.Controls(loc_i)
            IF VARTYPE(loc_oControl) = "O"
                IF UPPER(loc_oControl.Name) == "IMG_4C_IMGFIGJPG"
                    LOOP
                ENDIF
                IF PEMSTATUS(loc_oControl, "Visible", 5)
                    loc_oControl.Visible = .T.
                ENDIF
                IF PEMSTATUS(loc_oControl, "ControlCount", 5) AND loc_oControl.ControlCount > 0
                    THIS.TornarControlesVisiveis(loc_oControl)
                ENDIF
            ENDIF
        ENDFOR
    ENDPROC

    *--------------------------------------------------------------------------
    * Destroy - equivalente ao PROCEDURE Release legado
    * (ThisForm.ParentForm.Enabled = .t. / =DoDefault()): reabilita o form
    * pai e fecha o cursor do produto antes de delegar a FormBase.Destroy()
    * (libera o BO, restaura o menu).
    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
        IF VARTYPE(THIS.this_oFormPai) = "O"
            THIS.this_oFormPai.Enabled = .T.
        ENDIF

        IF USED("cursor_4c_Produto")
            USE IN cursor_4c_Produto
        ENDIF

        DODEFAULT()
    ENDPROC

ENDDEFINE

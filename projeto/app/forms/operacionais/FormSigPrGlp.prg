*==============================================================================
* FormSigPrGlp.prg - Previa da Globalizacao
*==============================================================================
* Herda de: FormBase
* BO: SigPrGlpBO
* Legado: SIGPRGLP.SCX
* Tipo: OPERACIONAL (filho - form PLANO sem PageFrame: todos os 128 objetos
*       do dump sao filhos diretos de SIGPRGLP, sem Pagina.Lista/Dados)
*
* Tela de PREVIA/CONFIRMACAO do processamento disparado por FormSigPrGlo
* (Processamento de O.P./Reserva Automatica), chamada por FormSigPrGl2
* (Operacoes Selecionadas) quando o job selecionado NAO tem fabricacao
* propria (this_lPossuiFabricacao = .F. - com fabricacao, quem abre eh a
* irma FormSigPrGlx). Recebe do chamador os cursores temporarios ja
* calculados na MESMA DataSession privada (TmpFinal/TmpDisp/TmpSaldo/
* TmpSaldG/TmpLinha/SelPedra/CrSigCdPac/CrSigCdPam) e, ao confirmar (botao
* Processar), efetiva a geracao das Ordens de Producao em SigOpPic
* (SigPrGlpBO.Inserir/Atualizar).
*
* CONTRATO DE CHAMADA (ja implementado do lado do chamador - NAO alterar a
* ordem/tipo dos parametros sem atualizar FormSigPrGl2.BtnProcessarClick):
*   CREATEOBJECT("FormSigPrGlp", par_oParentForm, par_nDataSessionId,
*       par_lReservaAuto, par_nGerEmphPdr, par_lAutom, par_nNumeroOp)
*   equivalente ao legado "Do Form SigPrGlp With ThisForm,
*       ThisForm.Datasessionid, Reserva, poDataMgr, Emphpdr, automatico,
*       Numerodaop" - pCnx (poDataMgr) SAI da lista: a conexao migrada eh o
*       gnConnHandle global. par_nDataSessionId eh vestigial (equivale ao
*       "_Data" do LParameters legado, que o proprio Init original nunca
*       lia - a sessao privada eh assumida de par_oParentForm.DataSessionId,
*       igual ao "_ParentForm.DataSessionId" do legado e ao mesmo padrao
*       ja usado em FormSigPrGlx/FormSigPrGf2).
*
* Criado em: Fase 3 - Estrutura Base (DEFINE CLASS, Init/Destroy/
* InicializarForm, cabecalho cnt_4c_Sombra). Roteiro das proximas fases em
* ConfigurarPageFrame().
*==============================================================================

DEFINE CLASS FormSigPrGlp AS FormBase

    *--------------------------------------------------------------------------
    * Propriedades do form (SIGPRGLP.SCX: Width=1000, Height=600,
    * DataSession=2, BorderStyle=2, ControlBox=.F., Closable=.F.,
    * MaxButton=.F., MinButton=.F., ClipControls=.F., TitleBar=0,
    * WindowState=0, FontName="Tahoma" - PILAR 1)
    *--------------------------------------------------------------------------
    Width        = 1000
    Height       = 600
    AutoCenter   = .T.
    TitleBar     = 0
    ShowWindow   = 1
    ControlBox   = .F.
    Closable     = .F.
    MaxButton    = .F.
    MinButton    = .F.
    ClipControls = .F.
    BorderStyle  = 2
    WindowState  = 0
    FontName     = "Tahoma"

    *-- WindowType = 1 eh canonico do projeto (mesmo padrao de FormSigPrGlx/
    *-- FormSigPrGf1/FormSigPrGf2): FormSigPrGl2.BtnProcessarClick abre este
    *-- form com CREATEOBJECT + variavel LOCAL + .Show() - com modeless o
    *-- Show() retornaria na hora e a LOCAL sairia de escopo, destruindo o
    *-- form (pisca e some).
    WindowType   = 1

    *-- DataSession = 2 transcrito do SCX. So vale quando este form eh
    *-- aberto SEM form pai (ganha sessao privada propria nesse caso); com
    *-- form pai, Init() troca THIS.DataSessionId pela sessao dele ANTES do
    *-- DODEFAULT(), para enxergar TmpFinal/TmpDisp/TmpSaldo/TmpSaldG/
    *-- TmpLinha/SelPedra/CrSigCdPac/CrSigCdPam que o pai ja populou.
    DataSession  = 2

    Caption = "Pr" + CHR(233) + "via da Globaliza" + CHR(231) + CHR(227) + "o"

    *-- Referencia do form pai (ParentForm do legado). Reabilitado no
    *-- Destroy (o pai se desabilita antes de abrir este form filho).
    this_oParentForm = .NULL.

    *-- Guarda de reentrancia dos lookups de SigCdPro (colunas Produto e
    *-- Produto substituto do grd_4c_Pedras). FormBuscaAuxiliar eh MODAL:
    *-- o Show() bloqueia, o foco sai da celula e volta, e o proprio
    *-- KeyPress/DblClick pode disparar de novo empilhando um segundo
    *-- picker. Setada na entrada e limpa DEPOIS do ENDTRY, para valer
    *-- tambem quando o CATCH dispara.
    this_lLookupAberto = .F.

    *-- ThisForm.AntValue do legado (When da Column5.Text1 do GradePedra:
    *-- "ThisForm.AntValue = This.Value"), usado pelo LostFocus da mesma
    *-- coluna para decidir a insercao da linha em branco em SelPedra.
    this_cAntValue = ""

    *-- ThisForm.OldValue do legado (When da Column6.Text1 do GradeItens -
    *-- coluna Produzir), guardado no GotFocus e comparado no Valid para
    *-- decidir se o valor mudou e se precisa confirmar com o usuario a
    *-- perda da selecao manual de estoque (TmpSaldU.KeySelm).
    this_nProduzirValorAnterior = 0

    *--------------------------------------------------------------------------
    * Init - Recebe a referencia do form pai e os parametros de modo
    * (equivalente a "LParameters _ParentForm, _Data, _ReservaAuto, pCnx,
    * _nGerEmphPdr, _autom, _numeroOp" do legado - ver contrato de chamada
    * no cabecalho do arquivo). Assume a DataSessionId do pai e repassa os
    * parametros de modo ao BusinessObject ANTES do DODEFAULT(), para que
    * InicializarForm() ja os encontre prontos.
    *--------------------------------------------------------------------------
    PROCEDURE Init(par_oParentForm, par_nDataSessionId, par_lReservaAuto, ;
                   par_nGerEmphPdr, par_lAutom, par_nNumeroOp)

        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        TRY
            IF VARTYPE(par_oParentForm) = "O"
                THIS.DataSessionId    = par_oParentForm.DataSessionId
                THIS.this_oParentForm = par_oParentForm
            ENDIF

            THIS.this_oBusinessObject = CREATEOBJECT("SigPrGlpBO")

            IF VARTYPE(THIS.this_oBusinessObject) = "O"
                THIS.this_oBusinessObject.this_lReserva    = IIF(VARTYPE(par_lReservaAuto) = "L", par_lReservaAuto, .F.)
                THIS.this_oBusinessObject.this_nEmphPdr    = IIF(VARTYPE(par_nGerEmphPdr)  = "N", par_nGerEmphPdr,  0)
                THIS.this_oBusinessObject.this_lAutomatico = IIF(VARTYPE(par_lAutom)       = "L", par_lAutom,       .F.)
                THIS.this_oBusinessObject.this_nNumeroDaOp = IIF(VARTYPE(par_nNumeroOp)    = "N", par_nNumeroOp,    0)

                DODEFAULT()
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao inicializar Pr" + CHR(233) + "via da Globaliza" + ;
                CHR(231) + CHR(227) + "o: " + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Destroy - os cursores de trabalho (TmpFinal/TmpDisp/TmpSaldo/TmpSaldG/
    * TmpLinha/SelPedra/TmpSaldU) vivem na DataSession PRIVADA compartilhada
    * com o pai - nao ha o que fechar aqui (o pai, dono da sessao, fecha os
    * dele quando for a vez dele). So reabilita o form pai (desabilitado por
    * FormSigPrGl2.BtnProcessarClick antes de abrir este form filho) e
    * encadeia para FormBase.Destroy() (libera this_oBusinessObject e
    * restaura o menu principal). DODEFAULT() SEMPRE por ultimo.
    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
        LOCAL loc_oErro

        TRY
            IF VARTYPE(THIS.this_oParentForm) = "O"
                THIS.this_oParentForm.Enabled = .T.
            ENDIF
            THIS.this_oParentForm = .NULL.
        CATCH TO loc_oErro
            MsgErro("Erro ao encerrar FormSigPrGlp: " + loc_oErro.Message, "Erro")
        ENDTRY

        DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    * InicializarForm - Business Object ja foi criado e configurado em
    * Init(); aqui so falta resolver o Caption dinamico (Globalizacao x
    * Reserva Automatica), o SigKey (cursor global CrSigCdPac, que o form
    * pai ja populou na sessao compartilhada) e montar a moldura visual
    * (fundo + cabecalho). Os containers flutuantes, grids, botoes de acao
    * e eventos entram nas proximas fases.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lSucesso, loc_oErro, loc_cCaption
        loc_lSucesso = .F.

        TRY
            IF VARTYPE(THIS.this_oBusinessObject) != "O"
                MsgErro("Falha ao criar SigPrGlpBO.", "Erro")
            ELSE
                *-- Caption dinamico (equivalente ao "If ThisForm.Reserva ...
                *-- Else ... EndIf" do Init legado)
                loc_cCaption = "Pr" + CHR(233) + "via da Globaliza" + CHR(231) + CHR(227) + "o"
                IF THIS.this_oBusinessObject.this_lReserva
                    loc_cCaption = "Pr" + CHR(233) + "via da Reserva Autom" + CHR(225) + "tica"
                ENDIF
                THIS.Caption = loc_cCaption

                *-- SigKey (Thisform.SigKey = CrSigCdPac.sigKeys do Init
                *-- legado) - CrSigCdPac eh cursor global que o form pai ja
                *-- populou, visivel aqui porque a DataSessionId eh
                *-- compartilhada (ver Init acima)
                IF USED("CrSigCdPac") AND RECCOUNT("CrSigCdPac") > 0 AND !EOF("CrSigCdPac")
                    THIS.this_oBusinessObject.this_cSigKey = ALLTRIM(CrSigCdPac.sigKeys)
                ENDIF

                THIS.Picture = gc_4c_CaminhoIcones + "new_background.jpg"

                THIS.ConfigurarPageFrame()

                THIS.cnt_4c_Sombra.lbl_4c_LblSombra.Caption = THIS.Caption
                THIS.cnt_4c_Sombra.lbl_4c_LblTitulo.Caption = THIS.Caption

                *-- Carga inicial da grade principal - o bind + "Go Top" +
                *-- ".Refresh" com que o Init legado termina. Passa pelo funil
                *-- CarregarLista porque ConfigurarGradeItens so consegue ligar
                *-- o RecordSource se TmpFinal JA existia quando o grid foi
                *-- criado; recebido depois (ou recriado pelo form pai), o
                *-- grid ficaria permanentemente em branco.
                *-- Pulada em validacao de UI, que instancia o form sem
                *-- conexao e sem os cursores do chamador.
                IF TYPE("gb_4c_ValidandoUI") != "L" OR !gb_4c_ValidandoUI
                    THIS.CarregarLista()
                ENDIF

                THIS.TornarControlesVisiveis(THIS)

                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro em FormSigPrGlp.InicializarForm")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPageFrame - Orquestrador de montagem visual. SIGPRGLP nao
    * tem PageFrame no legado (layout flat) - o nome do metodo eh mantido
    * apenas como ponto de entrada arquitetural padrao (mesmo papel em
    * FormSigPrGlo/FormSigPrGf1).
    *
    * Roteiro das proximas fases:
    *   Fase 3 (feita) - ConfigurarCabecalho() (cnt_4c_Sombra)
    *   Fase 4 (esta)  - shp_4c_Shape2/shp_4c_Shape3 decorativos, os 7
    *                     botoes de acao standalone (Disponivel/TotLinha/
    *                     Pedras/SelEstoque/Cancelar/Processar/
    *                     btnRelatorio) e o grid principal grd_4c_Itens
    *                     (GradeItens, 9 colunas, RecordSource='TmpFinal')
    *   Fase 5 (esta)  - 3 dos 5 containers flutuantes (estrutura visual
    *                     apenas - RecordSource/ControlSource dos grids fica
    *                     para a Fase 7-8, igual ao legado, que so liga isso
    *                     dentro do Click de cada botao): cnt_4c_Container1
    *                     (Pecas a Produzir por Linha - botao TotLinha),
    *                     cnt_4c_Container2 (Estoque Disponivel por
    *                     Produto/Cor/Tam - botao Disponivel) e
    *                     cnt_4c_Container5 (Estoque Disponivel por
    *                     Grupo/Conta - botao SelEstoque)
    *   Fase 6 (esta)  - cnt_4c_Container4 (Requisicao de Componentes
    *                     Adicionais - botao Pedras; grid ligado a SelPedra
    *                     em runtime pelo Pedras.Click, mesmo padrao dos
    *                     containers da Fase 5), cnt_4c_Container3
    *                     (Estoque Disponivel por Conta, rodape SEMPRE
    *                     visivel - nao entra no filtro de
    *                     TornarControlesVisiveis), os campos totais da
    *                     grade principal (txt_4c_TotQtd/TotEst/TotPrz),
    *                     img_4c_ImgFigJpg (foto do item selecionado),
    *                     lbl_4c_TxtObsItens/obj_4c_ObsItens e os LOOKUPS
    *                     de SigCdPro das colunas Produto/Produto
    *                     substituto do grd_4c_Pedras (Valid legado ->
    *                     ValidarPedraProduto/ValidarPedraSubstituto +
    *                     AbrirLookupPedraProduto/AbrirLookupPedraSubstituto
    *                     via FormBuscaAuxiliar), o gate do When das
    *                     Column4/Column5 (AjustarColunasPedra, ligado ao
    *                     AfterRowColChange) e o LostFocus da Column5
    *                     (linha em branco no SelPedra)
    *   Fase 7 (esta)  - PrepararCursoresDeTrabalho() (o resto do Init
    *                     legado: linha em branco do SelPedra, cursores
    *                     TmpSaldU/crSigCdCom, bind do grid do Container3 e
    *                     totais do rodape) e ConfigurarEventos()
    *                     (BINDEVENT dos 6 botoes de acao + dos 4 botoes de
    *                     OK/Sair dos containers flutuantes), com os
    *                     handlers correspondentes: BtnDisponivelClick,
    *                     BtnSelEstoqueClick, BtnTotLinhaClick,
    *                     BtnPedrasClick, BtnRelatorioClick,
    *                     BtnSairClick, BtnConfirmarDispProdutoClick,
    *                     BtnConfirmarDispGrupoClick, BtnFecharPedrasClick
    *                     e BtnFecharLinhasClick
    *   Fase 8 (esta)  - BtnProcessarClick + o AfterRowColChange de
    *                     grd_4c_Itens (alimenta Container3/totais/imagem/
    *                     observacao), o When/Valid/LostFocus da coluna
    *                     Produzir e da coluna Utilizar dos dois paineis de
    *                     estoque, SigPrGlpBO.Processar/AtualizaPeso/
    *                     GravaHis e os funis de consolidacao no fim do
    *                     arquivo (CarregarLista/LigarGradeItens/
    *                     FormParaBO/BOParaForm/HabilitarCampos/
    *                     AjustarBotoesPorModo/LimparCampos)
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPageFrame()
        THIS.ConfigurarCabecalho()
        THIS.ConfigurarFormasDecorativas()
        THIS.ConfigurarBotoesAcao()
        THIS.ConfigurarGradeItens()
        THIS.ConfigurarContainer1()
        THIS.ConfigurarContainer2()
        THIS.ConfigurarContainer5()
        THIS.ConfigurarContainer4()
        THIS.ConfigurarContainer3()
        THIS.ConfigurarCamposTotais()

        *-- Fase 7: os cursores de trabalho que o Init legado prepara DEPOIS
        *-- de montar a tela, e o BINDEVENT dos botoes de acao. Os dois vem
        *-- por ULTIMO porque dependem de todos os controles ja criados.
        THIS.PrepararCursoresDeTrabalho()
        THIS.ConfigurarEventos()
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarCabecalho - Container cinza escuro com titulo do form.
    * Original: cntSombra Top=0, Left=0, Width=1004, Height=80,
    * BackColor=RGB(100,100,100) (layout.json/dump) - Width usa THIS.Width
    * (canonico do projeto) em vez do literal 1004 do SCX, que ja excedia
    * em 4px o proprio Width do form (1000).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarCabecalho()
        LOCAL loc_oCnt, loc_oErro

        TRY
            THIS.AddObject("cnt_4c_Sombra", "Container")
            loc_oCnt = THIS.cnt_4c_Sombra
            WITH loc_oCnt
                .Top         = 0
                .Left        = 0
                .Width       = THIS.Width
                .Height      = 80
                .BorderWidth = 0
                .BackColor   = RGB(100, 100, 100)
                .Visible     = .T.
            ENDWITH

            loc_oCnt.AddObject("lbl_4c_LblSombra", "Label")
            WITH loc_oCnt.lbl_4c_LblSombra
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
                .Width         = 769
                .ForeColor     = RGB(0, 0, 0)
                .Visible       = .T.
            ENDWITH

            loc_oCnt.AddObject("lbl_4c_LblTitulo", "Label")
            WITH loc_oCnt.lbl_4c_LblTitulo
                .FontBold  = .T.
                .FontName  = "Tahoma"
                .FontSize  = 18
                .WordWrap  = .T.
                .Alignment = 0
                .BackStyle = 0
                .AutoSize  = .F.
                .Caption   = THIS.Caption
                .Height    = 46
                .Left      = 10
                .Top       = 17
                .Width     = 769
                .ForeColor = RGB(255, 255, 255)
                .Visible   = .T.
            ENDWITH
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro em ConfigurarCabecalho")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarFormasDecorativas - Os dois Shape do dump (Shape2/Shape3) sao
    * meramente decorativos: BackStyle=0 (sem preenchimento) e BorderStyle=0
    * (sem borda desenhada) - BorderColor fica sem efeito visivel com
    * BorderStyle=0, mas eh transcrito do SCX mesmo assim (regra de
    * transcricao literal - nao inventar, nao omitir).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarFormasDecorativas()
        LOCAL loc_oErro

        TRY
            THIS.AddObject("shp_4c_Shape2", "Shape")
            WITH THIS.shp_4c_Shape2
                .Top         = 9
                .Left        = 9
                .Width       = 279
                .Height      = 51
                .BackStyle   = 0
                .BorderStyle = 0
                .BorderColor = RGB(136, 189, 188)
                .Visible     = .T.
            ENDWITH

            THIS.AddObject("shp_4c_Shape3", "Shape")
            WITH THIS.shp_4c_Shape3
                .Top         = 10
                .Left        = 820
                .Width       = 116
                .Height      = 38
                .BackStyle   = 0
                .BorderStyle = 0
                .BorderColor = RGB(136, 189, 188)
                .Visible     = .T.
            ENDWITH
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro em ConfigurarFormasDecorativas")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarBotoesAcao - Os 7 botoes de acao ficam soltos, filhos diretos
    * do form (o SCX nao os agrupa em CommandGroup/Container), desenhados
    * POR CIMA de cnt_4c_Sombra (Top=3..78 cabe dentro da faixa Top=0..80) -
    * por isso este metodo roda DEPOIS de ConfigurarCabecalho() em
    * ConfigurarPageFrame(). Propriedades comuns (FontBold/FontItalic/
    * FontName "Comic Sans MS"/FontSize/ForeColor RGB(90,90,90)/BackColor
    * branco/Themes=.F.) sao as mesmas do padrao canonico de botoes CRUD
    * (docs/framework_frmcadastro_layout.md), confirmadas 1-a-1 no dump.
    * Icones e Captions (com o "\<" de atalho Alt) transcritos literalmente
    * do SCX - nunca inventados (regra de icone: CLAUDE.md #25). BINDEVENT
    * dos Click entra na Fase 7-8 (roteiro do cabecalho de
    * ConfigurarPageFrame).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarBotoesAcao()
        LOCAL loc_oErro

        TRY
            THIS.AddObject("cmd_4c_Disponivel", "CommandButton")
            WITH THIS.cmd_4c_Disponivel
                .Top        = 3
                .Left       = 622
                .Width      = 75
                .Height     = 75
                .FontBold   = .T.
                .FontItalic = .T.
                .FontName   = "Comic Sans MS"
                .FontSize   = 8
                .WordWrap   = .T.
                .Picture    = gc_4c_CaminhoIcones + "geral_palete_60.jpg"
                .Caption    = "\<Disponiveis"
                .ForeColor  = RGB(90, 90, 90)
                .BackColor  = RGB(255, 255, 255)
                .Themes           = .T.
                .Visible    = .T.
            ENDWITH

            THIS.AddObject("cmd_4c_Pedras", "CommandButton")
            WITH THIS.cmd_4c_Pedras
                .Top             = 3
                .Left            = 472
                .Width           = 75
                .Height          = 75
                .FontBold        = .T.
                .FontItalic      = .T.
                .FontName        = "Comic Sans MS"
                .FontSize        = 8
                .WordWrap        = .T.
                .Picture         = gc_4c_CaminhoIcones + "geral_datas_60.jpg"
                *-- Themes=.T. + DisabledPicture (diverge do Themes=.F. do
                *-- SCX de proposito): este botao PODE nascer .Enabled=.F.
                *-- (ver abaixo) e botao standalone com Picture+Enabled=.F.
                *-- +Themes=.F. perde o icone em VFP9 (CorretorAutomatico #99)
                .Themes          = .T.
                .DisabledPicture = gc_4c_CaminhoIcones + "geral_datas_60.jpg"
                .Caption         = "\<Requisi" + CHR(231) + CHR(245) + "es"
                .ForeColor       = RGB(90, 90, 90)
                .BackColor       = RGB(255, 255, 255)
                .Visible         = .T.
                *-- Habilitado so quando o SigCdPam tem as 4 colunas de
                *-- transferencia preenchidas e NAO eh Reserva Automatica
                *-- (equivalente ao "If Not Empty(crSigCdPam.DopEmphs) ...
                *-- And Not ThisForm.Reserva" do Init legado)
                .Enabled         = !EMPTY(THIS.this_oBusinessObject.this_cPamDopEmphs)   AND ;
                                    !EMPTY(THIS.this_oBusinessObject.this_cPamDopReqcs)   AND ;
                                    !EMPTY(THIS.this_oBusinessObject.this_cPamDopPedcs)   AND ;
                                    !EMPTY(THIS.this_oBusinessObject.this_cPamDopComps)   AND ;
                                    !THIS.this_oBusinessObject.this_lReserva
            ENDWITH

            THIS.AddObject("cmd_4c_SelEstoque", "CommandButton")
            WITH THIS.cmd_4c_SelEstoque
                .Top             = 3
                .Left            = 547
                .Width           = 75
                .Height          = 75
                .FontBold        = .T.
                .FontItalic      = .T.
                .FontName        = "Comic Sans MS"
                .FontSize        = 8
                .WordWrap        = .T.
                .Picture         = gc_4c_CaminhoIcones + "geral_marcar_60.jpg"
                .Caption         = "\<Estoques"
                .PicturePosition = 13
                .ForeColor       = RGB(90, 90, 90)
                .BackColor       = RGB(255, 255, 255)
                .Themes           = .T.
                .Visible         = .T.
            ENDWITH

            THIS.AddObject("cmd_4c_TotLinha", "CommandButton")
            WITH THIS.cmd_4c_TotLinha
                .Top        = 3
                .Left       = 697
                .Width      = 75
                .Height     = 75
                .FontBold   = .T.
                .FontItalic = .T.
                .FontName   = "Comic Sans MS"
                .FontSize   = 8
                .WordWrap   = .T.
                .Picture    = gc_4c_CaminhoIcones + "geral_grafico_pizza_60.jpg"
                .Caption    = "\<Total/Linhas"
                .ForeColor  = RGB(90, 90, 90)
                .BackColor  = RGB(255, 255, 255)
                .Themes           = .T.
                .Visible    = .T.
            ENDWITH

            THIS.AddObject("cmd_4c_BtnRelatorio", "CommandButton")
            WITH THIS.cmd_4c_BtnRelatorio
                .Top        = 3
                .Left       = 772
                .Width      = 75
                .Height     = 75
                .FontBold   = .T.
                .FontItalic = .T.
                .FontName   = "Comic Sans MS"
                .FontSize   = 8
                .WordWrap   = .T.
                .Picture    = gc_4c_CaminhoIcones + "geral_impressora_60.jpg"
                .Caption    = "\<Relat" + CHR(243) + "rio"
                .ForeColor  = RGB(90, 90, 90)
                .BackColor  = RGB(255, 255, 255)
                .Themes           = .T.
                .Visible    = .T.
            ENDWITH

            THIS.AddObject("cmd_4c_Processar", "CommandButton")
            WITH THIS.cmd_4c_Processar
                .Top        = 3
                .Left       = 847
                .Width      = 75
                .Height     = 75
                .FontBold   = .T.
                .FontItalic = .T.
                .FontName   = "Comic Sans MS"
                .FontSize   = 8
                .WordWrap   = .T.
                .Picture    = gc_4c_CaminhoIcones + "geral_processar_60.jpg"
                .Caption    = "\<Processar"
                .ForeColor  = RGB(90, 90, 90)
                .BackColor  = RGB(255, 255, 255)
                .Themes           = .T.
                .Visible    = .T.
            ENDWITH

            THIS.AddObject("cmd_4c_Cancelar", "CommandButton")
            WITH THIS.cmd_4c_Cancelar
                .Top        = 3
                .Left       = 922
                .Width      = 75
                .Height     = 75
                .FontBold   = .T.
                .FontItalic = .T.
                .FontName   = "Comic Sans MS"
                .FontSize   = 8
                .WordWrap   = .T.
                .Picture    = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
                .Cancel     = .T.
                .Caption    = "Encerrar"
                .ForeColor  = RGB(90, 90, 90)
                .BackColor  = RGB(255, 255, 255)
                .Themes           = .T.
                .Visible    = .T.
            ENDWITH
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro em ConfigurarBotoesAcao")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarGradeItens - Grid principal (GradeItens no legado), 9
    * colunas ligadas ao cursor TmpFinal (ja populado pelo form pai, na
    * DataSession privada compartilhada). O RecordSource eh atribuido aqui
    * SOB GUARDA de IF USED("TmpFinal") - o cursor so existe quando o form
    * eh aberto pelo fluxo real (FormSigPrGl2.BtnProcessarClick), e em modo
    * de teste de UI (gb_4c_ValidandoUI) nao existe. Quando ele chega
    * DEPOIS, quem liga a grade eh CarregarLista() (chamado no fim do
    * InicializarForm), que refaz o bind por LigarGradeItens() repondo
    * ControlSource/Width/Header na ordem canonica.
    *
    * IMPORTANTE - Correspondencia ControlSource x Header (conferida com o
    * dump linha a linha, incluindo cruzamento com os handlers de
    * GotFocus/Valid do legado, que confirmam qual coluna eh a UNICA
    * editavel): a ordem de DECLARACAO das colunas (Column1..Column9, a
    * mesma usada no ".ColumnN.ControlSource=" do Init legado) NAO anda em
    * paralelo com a ordem em que os Header1/Text1 aparecem no dump do SCX
    * - os Header1/Text1 sao indexados pelo .Name HISTORICO de cada coluna
    * (ex.: a coluna fisica 2, ligada a CodCors, tem .Name="Column5" e por
    * isso seu Header1.Caption fica na secao "Column5" do dump = "Quantidade").
    * Coluna 3 (fisica), ligada a Dopes, tem .Name="Column6", Header
    * "Produzir" e eh a UNICA com ReadOnly=.F. (BackColor 221,252,255) - os
    * handlers GotFocus de TODAS as outras colunas (comportamento.json)
    * fazem SetFocus justamente para "GradeItens.Column6.Text1", confirmando
    * que esta (fisica 3/Dopes/"Produzir") eh a coluna editavel do grid.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarGradeItens()
        LOCAL loc_oErro

        TRY
            THIS.AddObject("grd_4c_Itens", "Grid")
            WITH THIS.grd_4c_Itens
                .Top               = 125
                .Left              = 11
                .Width             = 708
                .Height            = 224
                .FontName          = "Verdana"
                .FontSize          = 8
                .AllowHeaderSizing = .F.
                .AllowRowSizing    = .F.
                .DeleteMark        = .F.
                .RecordMark        = .F.
                .RowHeight         = 17
                .ScrollBars        = 2
                .GridLineColor     = RGB(238, 238, 238)
                .Visible           = .T.

                .ColumnCount = 9

                IF USED("TmpFinal")
                    .RecordSource = "TmpFinal"
                ENDIF

                *-- Coluna 1 - Produto (Cpros)
                IF USED("TmpFinal")
                    .Column1.ControlSource = "TmpFinal.Cpros"
                ENDIF
                .Column1.Width         = 115
                .Column1.Movable       = .F.
                .Column1.Resizable     = .F.
                .Column1.ReadOnly      = .T.
                .Column1.Header1.FontName  = "Verdana"
                .Column1.Header1.FontSize  = 8
                .Column1.Header1.Alignment = 2
                .Column1.Header1.ForeColor = RGB(36, 84, 155)
                .Column1.Header1.Caption   = "Produto"
                .Column1.Text1.FontSize    = 8
                .Column1.Text1.BorderStyle = 0
                .Column1.Text1.Margin      = 0
                .Column1.Text1.ReadOnly    = .T.
                .Column1.Text1.ForeColor   = RGB(0, 0, 0)
                .Column1.Text1.BackColor   = RGB(255, 255, 255)

                *-- Coluna 2 - Cor (CodCors)
                IF USED("TmpFinal")
                    .Column2.ControlSource = "TmpFinal.CodCors"
                ENDIF
                .Column2.FontBold      = .T.
                .Column2.ColumnOrder   = 6
                .Column2.Width         = 80
                .Column2.Movable       = .F.
                .Column2.Resizable     = .F.
                .Column2.ReadOnly      = .T.
                .Column2.Header1.FontName  = "Verdana"
                .Column2.Header1.FontSize  = 8
                .Column2.Header1.Alignment = 2
                .Column2.Header1.ForeColor = RGB(36, 84, 155)
                .Column2.Header1.Caption   = "Cor"
                .Column2.Text1.FontSize    = 8
                .Column2.Text1.BorderStyle = 0
                .Column2.Text1.Margin      = 0
                .Column2.Text1.ReadOnly    = .T.
                .Column2.Text1.ForeColor   = RGB(0, 0, 0)
                .Column2.Text1.BackColor   = RGB(255, 255, 255)

                *-- Coluna 3 - Movimentacao (Dopes) - SEMPRE ReadOnly (o dump
                *-- legado declara Column3.Text1.ReadOnly=.T., BackColor
                *-- 255,255,255, sem FontBold - a UNICA editavel do grid eh a
                *-- Column6/Produzir, corrigido abaixo)
                IF USED("TmpFinal")
                    .Column3.ControlSource = "TmpFinal.Dopes"
                ENDIF
                .Column3.ColumnOrder   = 8
                .Column3.Width         = 80
                .Column3.Movable       = .F.
                .Column3.Resizable     = .F.
                .Column3.ReadOnly      = .T.
                .Column3.Header1.FontName  = "Verdana"
                .Column3.Header1.FontSize  = 8
                .Column3.Header1.Alignment = 2
                .Column3.Header1.ForeColor = RGB(36, 84, 155)
                .Column3.Header1.Caption   = "Movimenta" + CHR(231) + CHR(227) + "o"
                .Column3.Text1.FontSize    = 8
                .Column3.Text1.BorderStyle = 0
                .Column3.Text1.Margin      = 0
                .Column3.Text1.ReadOnly    = .T.
                .Column3.Text1.ForeColor   = RGB(0, 0, 0)
                .Column3.Text1.BackColor   = RGB(255, 255, 255)

                *-- Coluna 4 - Codigo (Numes)
                IF USED("TmpFinal")
                    .Column4.ControlSource = "TmpFinal.Numes"
                ENDIF
                .Column4.FontBold      = .T.
                .Column4.Alignment     = 2
                .Column4.ColumnOrder   = 9
                .Column4.Width         = 38
                .Column4.Movable       = .F.
                .Column4.Resizable     = .F.
                .Column4.ReadOnly      = .T.
                .Column4.Header1.FontName  = "Verdana"
                .Column4.Header1.FontSize  = 8
                .Column4.Header1.Alignment = 2
                .Column4.Header1.ForeColor = RGB(36, 84, 155)
                .Column4.Header1.Caption   = "C" + CHR(243) + "digo"
                .Column4.Text1.FontBold    = .T.
                .Column4.Text1.FontSize    = 8
                .Column4.Text1.Alignment   = 2
                .Column4.Text1.BorderStyle = 0
                .Column4.Text1.Margin      = 0
                .Column4.Text1.ReadOnly    = .T.
                .Column4.Text1.ForeColor   = RGB(0, 0, 0)
                .Column4.Text1.BackColor   = RGB(255, 255, 255)

                *-- Coluna 5 - Quantidade (Saldo)
                IF USED("TmpFinal")
                    .Column5.ControlSource = "TmpFinal.Saldo"
                ENDIF
                .Column5.FontBold      = .T.
                .Column5.ColumnOrder   = 7
                .Column5.Width         = 80
                .Column5.Movable       = .F.
                .Column5.Resizable     = .F.
                .Column5.ReadOnly      = .T.
                .Column5.BackColor     = RGB(255, 253, 179)
                .Column5.Header1.FontName  = "Verdana"
                .Column5.Header1.FontSize  = 8
                .Column5.Header1.Alignment = 2
                .Column5.Header1.ForeColor = RGB(36, 84, 155)
                .Column5.Header1.Caption   = "Quantidade"
                .Column5.Text1.FontBold    = .T.
                .Column5.Text1.FontSize    = 8
                .Column5.Text1.BorderStyle = 0
                .Column5.Text1.Margin      = 0
                .Column5.Text1.ReadOnly    = .T.
                .Column5.Text1.ForeColor   = RGB(0, 0, 0)
                .Column5.Text1.BackColor   = RGB(255, 253, 179)

                *-- Coluna 6 - Produzir - UNICA editavel do grid (dump legado:
                *-- Column6.Text1.ReadOnly=.F., FontBold=.T., BackColor
                *-- 221,252,255 - trocado com a Column3 por engano na Fase 4)
                IF USED("TmpFinal")
                    .Column6.ControlSource = "TmpFinal.Produzir"
                ENDIF
                .Column6.FontBold      = .T.
                .Column6.FontSize      = 8
                .Column6.ColumnOrder   = 4
                .Column6.Width         = 150
                .Column6.Movable       = .F.
                .Column6.Resizable     = .F.
                .Column6.ReadOnly      = .F.
                .Column6.BackColor     = RGB(221, 252, 255)
                .Column6.Header1.FontName  = "Verdana"
                .Column6.Header1.FontSize  = 8
                .Column6.Header1.Alignment = 2
                .Column6.Header1.ForeColor = RGB(36, 84, 155)
                .Column6.Header1.Caption   = "Produzir"
                .Column6.Text1.FontBold    = .T.
                .Column6.Text1.FontSize    = 8
                .Column6.Text1.BorderStyle = 0
                .Column6.Text1.Margin      = 0
                .Column6.Text1.ReadOnly    = .F.
                .Column6.Text1.ForeColor   = RGB(0, 0, 0)
                .Column6.Text1.BackColor   = RGB(221, 252, 255)

                *-- Coluna 7 - Estoque
                IF USED("TmpFinal")
                    .Column7.ControlSource = "TmpFinal.Estoque"
                ENDIF
                .Column7.FontSize      = 8
                .Column7.ColumnOrder   = 5
                .Column7.Width         = 50
                .Column7.Movable       = .F.
                .Column7.Resizable     = .F.
                .Column7.ReadOnly      = .T.
                .Column7.Header1.FontName  = "Verdana"
                .Column7.Header1.FontSize  = 8
                .Column7.Header1.Alignment = 2
                .Column7.Header1.ForeColor = RGB(36, 84, 155)
                .Column7.Header1.Caption   = "Estoque"
                .Column7.Text1.FontSize    = 8
                .Column7.Text1.BorderStyle = 0
                .Column7.Text1.Margin      = 0
                .Column7.Text1.ReadOnly    = .T.
                .Column7.Text1.ForeColor   = RGB(0, 0, 0)
                .Column7.Text1.BackColor   = RGB(255, 255, 255)

                *-- Coluna 8 - Obs (marcador "*" quando ha observacao)
                IF USED("TmpFinal")
                    .Column8.ControlSource = [IIF(ISNULL(TmpFinal.Obsps) OR EMPTY(TmpFinal.Obsps), "", "*")]
                ENDIF
                .Column8.FontSize      = 8
                .Column8.ColumnOrder   = 2
                .Column8.Width         = 38
                .Column8.Movable       = .F.
                .Column8.Resizable     = .F.
                .Column8.ReadOnly      = .T.
                .Column8.Header1.FontName  = "Verdana"
                .Column8.Header1.FontSize  = 8
                .Column8.Header1.Alignment = 2
                .Column8.Header1.ForeColor = RGB(36, 84, 155)
                .Column8.Header1.Caption   = "Obs"
                .Column8.Text1.FontSize    = 8
                .Column8.Text1.BorderStyle = 0
                .Column8.Text1.Margin      = 0
                .Column8.Text1.ReadOnly    = .T.
                .Column8.Text1.ForeColor   = RGB(0, 0, 0)
                .Column8.Text1.BackColor   = RGB(255, 255, 255)

                *-- Coluna 9 - Tam (CodTams)
                IF USED("TmpFinal")
                    .Column9.ControlSource = "TmpFinal.CodTams"
                ENDIF
                .Column9.FontSize      = 8
                .Column9.ColumnOrder   = 3
                .Column9.Width         = 38
                .Column9.Movable       = .F.
                .Column9.Resizable     = .F.
                .Column9.ReadOnly      = .T.
                .Column9.Header1.FontName  = "Verdana"
                .Column9.Header1.FontSize  = 8
                .Column9.Header1.Alignment = 2
                .Column9.Header1.ForeColor = RGB(36, 84, 155)
                .Column9.Header1.Caption   = "Tam"
                .Column9.Text1.FontSize    = 8
                .Column9.Text1.BorderStyle = 0
                .Column9.Text1.Margin      = 0
                .Column9.Text1.ReadOnly    = .T.
                .Column9.Text1.ForeColor   = RGB(0, 0, 0)
                .Column9.Text1.BackColor   = RGB(255, 255, 255)
            ENDWITH
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro em ConfigurarGradeItens")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarContainer1 - "Pecas a produzir por linha" (Container1 no
    * legado), alternado pelo botao cmd_4c_TotLinha (Fase 7-8). Grid
    * grd_4c_Linhas 100% somente-leitura (o proprio Grid tem .ReadOnly=.T.
    * no dump, alem de cada Column) - Column1..4.ControlSource ficam vazios
    * de proposito (assim declarado no SCX): TotLinha.Click monta o cursor
    * TmpLinha e liga RecordSource/ControlSource em runtime (Fase 7-8),
    * igual ao legado.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarContainer1()
        LOCAL loc_oCnt, loc_oErro

        TRY
            THIS.AddObject("cnt_4c_Container1", "Container")
            loc_oCnt = THIS.cnt_4c_Container1
            WITH loc_oCnt
                .Top           = 125
                .Left          = 12
                .Width         = 708
                .Height        = 465
                .SpecialEffect = 0
                .BackColor     = RGB(255, 255, 255)
                .Visible       = .F.
            ENDWITH

            loc_oCnt.AddObject("lbl_4c_Label1", "Label")
            WITH loc_oCnt.lbl_4c_Label1
                .FontBold  = .T.
                .FontName  = "Tahoma"
                .FontSize  = 10
                .Alignment = 0
                .BackStyle = 0
                .AutoSize  = .F.
                .Caption   = "Pe" + CHR(231) + "as a produzir por linha"
                .Height    = 18
                .Left      = 259
                .Top       = 10
                .Width     = 170
                .ForeColor = RGB(90, 90, 90)
                .Visible   = .T.
            ENDWITH

            loc_oCnt.AddObject("cmd_4c_CancelaLin", "CommandButton")
            WITH loc_oCnt.cmd_4c_CancelaLin
                .Top         = 10
                .Left        = 620
                .Height      = 75
                .Width       = 75
                .FontBold    = .T.
                .FontItalic  = .T.
                .FontName    = "Comic Sans MS"
                .FontSize    = 8
                .WordWrap    = .T.
                .Picture     = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
                .Cancel      = .T.
                .Caption     = "OK"
                .ToolTipText = "[ESC] - Encerrar"
                .ForeColor   = RGB(90, 90, 90)
                .BackColor   = RGB(255, 255, 255)
                .Themes      = .F.
                .Visible     = .T.
            ENDWITH

            loc_oCnt.AddObject("grd_4c_Linhas", "Grid")
            WITH loc_oCnt.grd_4c_Linhas
                .Top               = 32
                .Left              = 174
                .Width             = 359
                .Height            = 420
                .FontSize          = 8
                .AllowHeaderSizing = .F.
                .AllowRowSizing    = .F.
                .DeleteMark        = .F.
                .RecordMark        = .T.
                .RowHeight         = 16
                .ScrollBars        = 2
                .GridLineColor     = RGB(238, 238, 238)
                .ReadOnly          = .T.
                .Visible           = .T.

                .ColumnCount = 4

                *-- Coluna 1 - Linha (futuro TmpLinha.Linhas)
                .Column1.ControlSource     = ""
                .Column1.Width             = 84
                .Column1.Movable           = .F.
                .Column1.Resizable         = .F.
                .Column1.ReadOnly          = .T.
                .Column1.Sparse            = .F.
                .Column1.Header1.FontName  = "Verdana"
                .Column1.Header1.FontSize  = 8
                .Column1.Header1.Alignment = 2
                .Column1.Header1.ForeColor = RGB(36, 84, 155)
                .Column1.Header1.Caption   = "Linha"
                .Column1.Text1.FontName    = "Arial"
                .Column1.Text1.FontSize    = 8
                .Column1.Text1.BorderStyle = 0
                .Column1.Text1.Margin      = 0
                .Column1.Text1.ReadOnly    = .T.
                .Column1.Text1.ForeColor   = RGB(0, 0, 0)
                .Column1.Text1.BackColor   = RGB(255, 255, 255)

                *-- Coluna 2 - Quantidade (futuro TmpLinha.Saldo)
                .Column2.ControlSource     = ""
                .Column2.Width             = 80
                .Column2.Movable           = .F.
                .Column2.Resizable         = .F.
                .Column2.ReadOnly          = .T.
                .Column2.Sparse            = .F.
                .Column2.Header1.FontName  = "Verdana"
                .Column2.Header1.FontSize  = 8
                .Column2.Header1.Alignment = 2
                .Column2.Header1.ForeColor = RGB(36, 84, 155)
                .Column2.Header1.Caption   = "Quantidade"
                .Column2.Text1.FontSize    = 8
                .Column2.Text1.BorderStyle = 0
                .Column2.Text1.InputMask   = "999,999.99"
                .Column2.Text1.Margin      = 0
                .Column2.Text1.MaxLength   = 10
                .Column2.Text1.ReadOnly    = .T.
                .Column2.Text1.ForeColor   = RGB(0, 0, 0)
                .Column2.Text1.BackColor   = RGB(255, 255, 255)

                *-- Coluna 3 - Estoque (futuro TmpLinha.Estoque)
                .Column3.ControlSource     = ""
                .Column3.Width             = 80
                .Column3.Movable           = .F.
                .Column3.Resizable         = .F.
                .Column3.ReadOnly          = .T.
                .Column3.Sparse            = .F.
                .Column3.Header1.FontName  = "Verdana"
                .Column3.Header1.FontSize  = 8
                .Column3.Header1.Alignment = 2
                .Column3.Header1.ForeColor = RGB(36, 84, 155)
                .Column3.Header1.Caption   = "Estoque"
                .Column3.Text1.FontName    = "Arial"
                .Column3.Text1.FontSize    = 8
                .Column3.Text1.BorderStyle = 0
                .Column3.Text1.InputMask   = "999,999.99"
                .Column3.Text1.Margin      = 0
                .Column3.Text1.MaxLength   = 10
                .Column3.Text1.ReadOnly    = .T.
                .Column3.Text1.ForeColor   = RGB(0, 0, 0)
                .Column3.Text1.BackColor   = RGB(255, 255, 255)

                *-- Coluna 4 - Produzir (futuro TmpLinha.Produzir)
                .Column4.ControlSource     = ""
                .Column4.Width             = 80
                .Column4.Movable           = .F.
                .Column4.Resizable         = .F.
                .Column4.ReadOnly          = .T.
                .Column4.Sparse            = .F.
                .Column4.Header1.FontName  = "Verdana"
                .Column4.Header1.FontSize  = 8
                .Column4.Header1.Alignment = 2
                .Column4.Header1.ForeColor = RGB(36, 84, 155)
                .Column4.Header1.Caption   = "Produzir"
                .Column4.Text1.FontName    = "Arial"
                .Column4.Text1.FontSize    = 8
                .Column4.Text1.BorderStyle = 0
                .Column4.Text1.InputMask   = "999,999.99"
                .Column4.Text1.Margin      = 0
                .Column4.Text1.MaxLength   = 10
                .Column4.Text1.ReadOnly    = .T.
                .Column4.Text1.ForeColor   = RGB(0, 0, 0)
                .Column4.Text1.BackColor   = RGB(255, 255, 255)
            ENDWITH
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro em ConfigurarContainer1")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarContainer2 - "Estoque Disponivel" por PRODUTO/COR/TAM,
    * alternado pelo botao cmd_4c_Disponivel (Fase 7-8). RecordSource/
    * ControlSource ficam de fora aqui (o SCX nao declara ControlSource
    * estatico para estas colunas - o Click do legado monta TmpDisp e liga
    * tudo em runtime, mesmo padrao do Container5).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarContainer2()
        LOCAL loc_oCnt, loc_oErro

        TRY
            THIS.AddObject("cnt_4c_Container2", "Container")
            loc_oCnt = THIS.cnt_4c_Container2
            WITH loc_oCnt
                .Top           = 125
                .Left          = 12
                .Width         = 708
                .Height        = 465
                .SpecialEffect = 0
                .BackColor     = RGB(255, 255, 255)
                .Visible       = .F.
            ENDWITH

            loc_oCnt.AddObject("lbl_4c_Label1", "Label")
            WITH loc_oCnt.lbl_4c_Label1
                .FontBold  = .T.
                .FontName  = "Tahoma"
                .FontSize  = 10
                .BackStyle = 0
                .AutoSize  = .F.
                .Caption   = "Estoque Dispon" + CHR(237) + "vel"
                .Height    = 18
                .Left      = 284
                .Top       = 10
                .Width     = 123
                .ForeColor = RGB(90, 90, 90)
                .Visible   = .T.
            ENDWITH

            loc_oCnt.AddObject("cmd_4c_CancelaDisp", "CommandButton")
            WITH loc_oCnt.cmd_4c_CancelaDisp
                .Top       = 10
                .Left      = 620
                .Height    = 75
                .Width     = 75
                .FontName  = "Comic Sans MS"
                .FontSize  = 8
                .Picture   = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
                .Cancel    = .T.
                .Caption   = "Sair"
                .ForeColor = RGB(90, 90, 90)
                .BackColor = RGB(255, 255, 255)
                .Themes    = .F.
                .Visible   = .T.
            ENDWITH

            loc_oCnt.AddObject("grd_4c_DispProduto", "Grid")
            WITH loc_oCnt.grd_4c_DispProduto
                .Top               = 32
                .Left              = 169
                .Width             = 370
                .Height            = 388
                .FontSize          = 8
                .AllowHeaderSizing = .F.
                .AllowRowSizing    = .F.
                .DeleteMark        = .F.
                .RecordMark        = .T.
                .Panel             = 1
                .RowHeight         = 16
                .ScrollBars        = 2
                .GridLineColor     = RGB(238, 238, 238)
                .Visible           = .T.

                .ColumnCount = 5

                *-- Coluna 1 - Produto (futuro TmpDisp.Cpros)
                .Column1.Width             = 108
                .Column1.Movable           = .F.
                .Column1.Resizable         = .F.
                .Column1.ReadOnly          = .T.
                .Column1.Header1.FontName  = "Verdana"
                .Column1.Header1.FontSize  = 8
                .Column1.Header1.Alignment = 2
                .Column1.Header1.ForeColor = RGB(36, 84, 155)
                .Column1.Header1.Caption   = "Produto"
                .Column1.Text1.FontSize    = 8
                .Column1.Text1.BorderStyle = 0
                .Column1.Text1.Margin      = 0
                .Column1.Text1.ReadOnly    = .T.
                .Column1.Text1.ForeColor   = RGB(0, 0, 0)
                .Column1.Text1.BackColor   = RGB(255, 255, 255)

                *-- Coluna 2 - Cor (futuro TmpDisp.CodCors)
                .Column2.FontBold          = .T.
                .Column2.ColumnOrder       = 2
                .Column2.Width             = 38
                .Column2.Movable           = .F.
                .Column2.Resizable         = .F.
                .Column2.ReadOnly          = .T.
                .Column2.Header1.FontName  = "Verdana"
                .Column2.Header1.FontSize  = 8
                .Column2.Header1.Alignment = 2
                .Column2.Header1.ForeColor = RGB(36, 84, 155)
                .Column2.Header1.Caption   = "Cor"
                .Column2.Text1.FontBold    = .T.
                .Column2.Text1.FontSize    = 8
                .Column2.Text1.BorderStyle = 0
                .Column2.Text1.Margin      = 0
                .Column2.Text1.ReadOnly    = .T.
                .Column2.Text1.ForeColor   = RGB(0, 0, 0)
                .Column2.Text1.BackColor   = RGB(255, 255, 255)

                *-- Coluna 3 - Tam (futuro TmpDisp.CodTams)
                .Column3.FontBold          = .T.
                .Column3.ColumnOrder       = 3
                .Column3.Width             = 38
                .Column3.Movable           = .F.
                .Column3.Resizable         = .F.
                .Column3.ReadOnly          = .T.
                .Column3.Header1.FontName  = "Verdana"
                .Column3.Header1.FontSize  = 8
                .Column3.Header1.Alignment = 2
                .Column3.Header1.ForeColor = RGB(36, 84, 155)
                .Column3.Header1.Caption   = "Tam"
                .Column3.Text1.FontBold    = .T.
                .Column3.Text1.FontSize    = 8
                .Column3.Text1.BorderStyle = 0
                .Column3.Text1.Margin      = 0
                .Column3.Text1.ReadOnly    = .T.
                .Column3.Text1.ForeColor   = RGB(0, 0, 0)
                .Column3.Text1.BackColor   = RGB(255, 255, 255)

                *-- Coluna 4 - Disponivel (futuro TmpDisp.Disps)
                .Column4.ColumnOrder       = 4
                .Column4.Width             = 75
                .Column4.Movable           = .F.
                .Column4.Resizable         = .F.
                .Column4.ReadOnly          = .T.
                .Column4.Header1.FontName  = "Verdana"
                .Column4.Header1.FontSize  = 8
                .Column4.Header1.Alignment = 2
                .Column4.Header1.ForeColor = RGB(36, 84, 155)
                .Column4.Header1.Caption   = "Disponivel"
                .Column4.Text1.FontSize    = 8
                .Column4.Text1.BorderStyle = 0
                .Column4.Text1.Margin      = 0
                .Column4.Text1.ReadOnly    = .T.
                .Column4.Text1.ForeColor   = RGB(0, 0, 0)
                .Column4.Text1.BackColor   = RGB(255, 255, 255)

                *-- Coluna 5 - Utilizar (futuro TmpDisp.Utilizar) - UNICA editavel
                .Column5.FontBold          = .T.
                .Column5.ColumnOrder       = 5
                .Column5.Width             = 75
                .Column5.Movable           = .F.
                .Column5.Resizable         = .F.
                .Column5.ReadOnly          = .F.
                .Column5.Header1.FontName  = "Verdana"
                .Column5.Header1.FontSize  = 8
                .Column5.Header1.Alignment = 2
                .Column5.Header1.ForeColor = RGB(36, 84, 155)
                .Column5.Header1.Caption   = "Utilizar"
                .Column5.Text1.FontBold    = .T.
                .Column5.Text1.FontSize    = 8
                .Column5.Text1.BorderStyle = 0
                .Column5.Text1.Margin      = 0
                .Column5.Text1.ReadOnly    = .F.
                .Column5.Text1.ForeColor   = RGB(0, 0, 0)
                .Column5.Text1.BackColor   = RGB(255, 255, 255)
            ENDWITH

            loc_oCnt.AddObject("lbl_4c_Label2", "Label")
            WITH loc_oCnt.lbl_4c_Label2
                .FontName  = "Tahoma"
                .FontSize  = 8
                .BackStyle = 0
                .AutoSize  = .F.
                .Caption   = "Qtde " + CHR(224) + " Produzir :"
                .Height    = 15
                .Left      = 168
                .Top       = 432
                .Width     = 84
                .ForeColor = RGB(90, 90, 90)
                .Visible   = .T.
            ENDWITH

            loc_oCnt.AddObject("lbl_4c_Label3", "Label")
            WITH loc_oCnt.lbl_4c_Label3
                .FontName  = "Tahoma"
                .FontSize  = 8
                .BackStyle = 0
                .AutoSize  = .F.
                .Caption   = "Qtde " + CHR(224) + " Utilizar :"
                .Height    = 17
                .Left      = 365
                .Top       = 431
                .Width     = 109
                .ForeColor = RGB(90, 90, 90)
                .Visible   = .T.
            ENDWITH

            loc_oCnt.AddObject("txt_4c_QtSelec", "TextBox")
            WITH loc_oCnt.txt_4c_QtSelec
                .Height        = 23
                .Width         = 80
                .Left          = 458
                .Top           = 428
                .InputMask     = "9,999.99"
                .SpecialEffect = 1
                .Value         = 0
                .ReadOnly      = .T.
                .Visible       = .T.
            ENDWITH

            loc_oCnt.AddObject("txt_4c_QtPedida", "TextBox")
            WITH loc_oCnt.txt_4c_QtPedida
                .Height        = 23
                .Width         = 80
                .Left          = 268
                .Top           = 428
                .InputMask     = "9,999.99"
                .SpecialEffect = 1
                .Value         = 0
                .ReadOnly      = .T.
                .Visible       = .T.
            ENDWITH
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro em ConfigurarContainer2")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarContainer5 - "Estoque Disponivel" por GRUPO/CONTA, alternado
    * pelo botao cmd_4c_SelEstoque ("Estoques" - Fase 7-8). O ColumnOrder do
    * grid NAO acompanha a ordem de declaracao das colunas (Column3/
    * Prioridade eh a PRIMEIRA visualmente - ColumnOrder=1) - transcrito
    * literal do dump, nao "corrigido".
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarContainer5()
        LOCAL loc_oCnt, loc_oErro

        TRY
            THIS.AddObject("cnt_4c_Container5", "Container")
            loc_oCnt = THIS.cnt_4c_Container5
            WITH loc_oCnt
                .Top           = 125
                .Left          = 12
                .Width         = 708
                .Height        = 465
                .SpecialEffect = 0
                .BackColor     = RGB(255, 255, 255)
                .Visible       = .F.
            ENDWITH

            loc_oCnt.AddObject("lbl_4c_Label1", "Label")
            WITH loc_oCnt.lbl_4c_Label1
                .FontBold  = .T.
                .FontName  = "Tahoma"
                .FontSize  = 10
                .BackStyle = 0
                .AutoSize  = .F.
                .Caption   = "Estoque Dispon" + CHR(237) + "vel"
                .Height    = 18
                .Left      = 284
                .Top       = 10
                .Width     = 123
                .ForeColor = RGB(90, 90, 90)
                .Visible   = .T.
            ENDWITH

            loc_oCnt.AddObject("cmd_4c_CancelaDisp", "CommandButton")
            WITH loc_oCnt.cmd_4c_CancelaDisp
                .Top         = 10
                .Left        = 620
                .Height      = 75
                .Width       = 75
                .FontBold    = .T.
                .FontItalic  = .T.
                .FontName    = "Comic Sans MS"
                .FontSize    = 8
                .WordWrap    = .T.
                .Picture     = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
                .Cancel      = .T.
                .Caption     = "OK"
                .ToolTipText = "[ESC] - Encerrar"
                .ForeColor   = RGB(90, 90, 90)
                .BackColor   = RGB(255, 255, 255)
                .Themes      = .F.
                .Visible     = .T.
            ENDWITH

            loc_oCnt.AddObject("grd_4c_DispGrupo", "Grid")
            WITH loc_oCnt.grd_4c_DispGrupo
                .Top               = 32
                .Left              = 141
                .Width             = 425
                .Height            = 372
                .FontSize          = 8
                .AllowHeaderSizing = .F.
                .AllowRowSizing    = .F.
                .DeleteMark        = .F.
                .RecordMark        = .T.
                .RowHeight         = 16
                .ScrollBars        = 2
                .GridLineColor     = RGB(238, 238, 238)
                .Visible           = .T.

                .ColumnCount = 5

                *-- Coluna 1 - Grupo (futuro TmpDisp.Grupos) - ColumnOrder 2
                .Column1.ColumnOrder       = 2
                .Column1.Width             = 80
                .Column1.Movable           = .F.
                .Column1.Resizable         = .F.
                .Column1.ReadOnly          = .T.
                .Column1.Header1.FontName  = "Verdana"
                .Column1.Header1.FontSize  = 8
                .Column1.Header1.Alignment = 2
                .Column1.Header1.ForeColor = RGB(36, 84, 155)
                .Column1.Header1.Caption   = "Grupo"
                .Column1.Text1.FontSize    = 8
                .Column1.Text1.BorderStyle = 0
                .Column1.Text1.Margin      = 0
                .Column1.Text1.ReadOnly    = .T.
                .Column1.Text1.ForeColor   = RGB(0, 0, 0)
                .Column1.Text1.BackColor   = RGB(255, 255, 255)

                *-- Coluna 2 - Conta (futuro TmpDisp.Estos) - ColumnOrder 3
                .Column2.ColumnOrder       = 3
                .Column2.Width             = 80
                .Column2.Movable           = .F.
                .Column2.Resizable         = .F.
                .Column2.ReadOnly          = .T.
                .Column2.Header1.FontName  = "Verdana"
                .Column2.Header1.FontSize  = 8
                .Column2.Header1.Alignment = 2
                .Column2.Header1.ForeColor = RGB(36, 84, 155)
                .Column2.Header1.Caption   = "Conta"
                .Column2.Text1.FontBold    = .F.
                .Column2.Text1.FontSize    = 8
                .Column2.Text1.BorderStyle = 0
                .Column2.Text1.Margin      = 0
                .Column2.Text1.ReadOnly    = .T.
                .Column2.Text1.ForeColor   = RGB(0, 0, 0)
                .Column2.Text1.BackColor   = RGB(255, 255, 255)

                *-- Coluna 3 - Prioridade (futuro TmpDisp.Priors) - ColumnOrder 1 (1a visual)
                .Column3.ColumnOrder       = 1
                .Column3.Width             = 80
                .Column3.Movable           = .F.
                .Column3.Resizable         = .F.
                .Column3.ReadOnly          = .T.
                .Column3.Header1.FontName  = "Verdana"
                .Column3.Header1.FontSize  = 8
                .Column3.Header1.Alignment = 2
                .Column3.Header1.ForeColor = RGB(36, 84, 155)
                .Column3.Header1.Caption   = "Prioridade"
                .Column3.Text1.FontBold    = .F.
                .Column3.Text1.FontSize    = 8
                .Column3.Text1.BorderStyle = 0
                .Column3.Text1.Margin      = 0
                .Column3.Text1.ReadOnly    = .T.
                .Column3.Text1.ForeColor   = RGB(0, 0, 0)
                .Column3.Text1.BackColor   = RGB(255, 255, 255)

                *-- Coluna 4 - Disponivel (futuro TmpDisp.Disps) - ColumnOrder 4
                .Column4.ColumnOrder       = 4
                .Column4.Width             = 75
                .Column4.Movable           = .F.
                .Column4.Resizable         = .F.
                .Column4.ReadOnly          = .T.
                .Column4.Header1.FontName  = "Verdana"
                .Column4.Header1.FontSize  = 8
                .Column4.Header1.Alignment = 2
                .Column4.Header1.ForeColor = RGB(36, 84, 155)
                .Column4.Header1.Caption   = "Dispon" + CHR(237) + "vel"
                .Column4.Text1.FontSize    = 8
                .Column4.Text1.BorderStyle = 0
                .Column4.Text1.Margin      = 0
                .Column4.Text1.ReadOnly    = .T.
                .Column4.Text1.ForeColor   = RGB(0, 0, 0)
                .Column4.Text1.BackColor   = RGB(255, 255, 255)

                *-- Coluna 5 - Utilizar (futuro TmpDisp.Utilizar) - ColumnOrder 5, UNICA editavel
                .Column5.FontBold          = .T.
                .Column5.ColumnOrder       = 5
                .Column5.Width             = 75
                .Column5.Movable           = .F.
                .Column5.Resizable         = .F.
                .Column5.ReadOnly          = .F.
                .Column5.Header1.FontName  = "Verdana"
                .Column5.Header1.FontSize  = 8
                .Column5.Header1.Alignment = 2
                .Column5.Header1.ForeColor = RGB(36, 84, 155)
                .Column5.Header1.Caption   = "Utilizar"
                .Column5.Text1.FontBold    = .T.
                .Column5.Text1.FontSize    = 8
                .Column5.Text1.Alignment   = 3
                .Column5.Text1.BorderStyle = 0
                .Column5.Text1.Value       = 0
                .Column5.Text1.Margin      = 0
                .Column5.Text1.ReadOnly    = .F.
                .Column5.Text1.ForeColor   = RGB(0, 0, 0)
                .Column5.Text1.BackColor   = RGB(255, 255, 255)
            ENDWITH

            loc_oCnt.AddObject("lbl_4c_Label2", "Label")
            WITH loc_oCnt.lbl_4c_Label2
                .FontName  = "Tahoma"
                .FontSize  = 8
                .BackStyle = 0
                .AutoSize  = .F.
                .Caption   = "Produzir :"
                .Height    = 15
                .Left      = 428
                .Top       = 413
                .Width     = 48
                .ForeColor = RGB(90, 90, 90)
                .Visible   = .T.
            ENDWITH

            loc_oCnt.AddObject("lbl_4c_Label3", "Label")
            WITH loc_oCnt.lbl_4c_Label3
                .FontName  = "Tahoma"
                .FontSize  = 8
                .BackStyle = 0
                .AutoSize  = .F.
                .Caption   = "Utilizar :"
                .Height    = 15
                .Left      = 435
                .Top       = 438
                .Width     = 41
                .ForeColor = RGB(90, 90, 90)
                .Visible   = .T.
            ENDWITH

            loc_oCnt.AddObject("lbl_4c_Label4", "Label")
            WITH loc_oCnt.lbl_4c_Label4
                .FontName  = "Tahoma"
                .FontSize  = 8
                .BackStyle = 0
                .AutoSize  = .F.
                .Caption   = "Grupo :"
                .Height    = 15
                .Left      = 93
                .Top       = 413
                .Width     = 38
                .ForeColor = RGB(90, 90, 90)
                .Visible   = .T.
            ENDWITH

            loc_oCnt.AddObject("lbl_4c_Label5", "Label")
            WITH loc_oCnt.lbl_4c_Label5
                .FontName  = "Tahoma"
                .FontSize  = 8
                .BackStyle = 0
                .AutoSize  = .F.
                .Caption   = "Conta :"
                .Height    = 15
                .Left      = 93
                .Top       = 438
                .Width     = 38
                .ForeColor = RGB(90, 90, 90)
                .Visible   = .T.
            ENDWITH

            loc_oCnt.AddObject("txt_4c_GetDGrupo", "TextBox")
            WITH loc_oCnt.txt_4c_GetDGrupo
                .Height        = 23
                .Width         = 277
                .Left          = 141
                .Top           = 409
                .SpecialEffect = 1
                .ReadOnly      = .T.
                .Visible       = .T.
            ENDWITH

            loc_oCnt.AddObject("txt_4c_GetDConta", "TextBox")
            WITH loc_oCnt.txt_4c_GetDConta
                .Height        = 23
                .Width         = 277
                .Left          = 141
                .Top           = 434
                .SpecialEffect = 1
                .ReadOnly      = .T.
                .Visible       = .T.
            ENDWITH

            loc_oCnt.AddObject("txt_4c_QtPedida", "TextBox")
            WITH loc_oCnt.txt_4c_QtPedida
                .Height        = 23
                .Width         = 80
                .Left          = 486
                .Top           = 409
                .InputMask     = "9,999.99"
                .SpecialEffect = 1
                .Value         = 0
                .ReadOnly      = .T.
                .Visible       = .T.
            ENDWITH

            loc_oCnt.AddObject("txt_4c_QtSelec", "TextBox")
            WITH loc_oCnt.txt_4c_QtSelec
                .Height        = 23
                .Width         = 80
                .Left          = 486
                .Top           = 434
                .InputMask     = "9,999.99"
                .SpecialEffect = 1
                .Value         = 0
                .ReadOnly      = .T.
                .Visible       = .T.
            ENDWITH
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro em ConfigurarContainer5")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarContainer4 - "Requisicao de componentes adicionais"
    * (Container4 no legado), alternado pelo botao cmd_4c_Pedras (Fase 7-8).
    * Grid grd_4c_Pedras liga em runtime ao cursor SelPedra montado pelo
    * Click (mesmo padrao de RecordSource/ControlSource vazio ja usado nos
    * Containers 1/2/5) - Pedras.Click faz .RecordSource='SelPedra' e liga
    * Column1..5 a Cpros/Dpros/Cunis/Qtds/Cpro2s.
    *
    * ReadOnly por coluna transcrito do When de cada Text1 no legado:
    * Coluna1 (Produto) eh a UNICA de entrada livre - o Valid dela dispara
    * o lookup fwBuscaExt em SigCdPro (Fase 7-8) e preenche Descricao/Uni
    * (Colunas 2/3, sempre ReadOnly, "Return .f." no When). Colunas 4
    * (Qtde) e 5 (Produto substituto, com o proprio lookup fwBuscaExt) so
    * habilitam quando a Coluna1 estiver preenchida (When = "Return (Not
    * Empty(...Column1.Text1.Value))"); a Coluna5 tambem tem um LostFocus
    * que insere linha em branco no SelPedra (Fase 7-8).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarContainer4()
        LOCAL loc_oCnt, loc_oErro

        TRY
            THIS.AddObject("cnt_4c_Container4", "Container")
            loc_oCnt = THIS.cnt_4c_Container4
            WITH loc_oCnt
                .Top           = 125
                .Left          = 12
                .Width         = 708
                .Height        = 465
                .SpecialEffect = 0
                .BackColor     = RGB(255, 255, 255)
                .Visible       = .F.
            ENDWITH

            loc_oCnt.AddObject("lbl_4c_Label1", "Label")
            WITH loc_oCnt.lbl_4c_Label1
                .FontBold  = .T.
                .FontName  = "Tahoma"
                .FontSize  = 10
                .BackStyle = 0
                .AutoSize  = .F.
                .Caption   = "Requisi" + CHR(231) + CHR(227) + "o de componentes adicionais"
                .Height    = 18
                .Left      = 229
                .Top       = 8
                .Width     = 249
                .ForeColor = RGB(90, 90, 90)
                .Visible   = .T.
            ENDWITH

            loc_oCnt.AddObject("cmd_4c_CancelaDisp", "CommandButton")
            WITH loc_oCnt.cmd_4c_CancelaDisp
                .Top        = 10
                .Left       = 620
                .Height     = 75
                .Width      = 75
                .FontBold   = .T.
                .FontItalic = .T.
                .FontName   = "Comic Sans MS"
                .FontSize   = 8
                .Picture    = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
                .Cancel     = .T.
                .Caption    = "Sair"
                .ForeColor  = RGB(90, 90, 90)
                .BackColor  = RGB(255, 255, 255)
                .Themes     = .F.
                .Visible    = .T.
            ENDWITH

            loc_oCnt.AddObject("grd_4c_Pedras", "Grid")
            WITH loc_oCnt.grd_4c_Pedras
                .Top               = 32
                .Left              = 9
                .Width             = 605
                .Height            = 420
                .FontSize          = 8
                .AllowHeaderSizing = .F.
                .AllowRowSizing    = .F.
                .DeleteMark        = .F.
                .RecordMark        = .T.
                .RowHeight         = 16
                .ScrollBars        = 2
                .GridLineColor     = RGB(238, 238, 238)
                .Visible           = .T.

                .ColumnCount = 5

                *-- Coluna 1 - Produto (futuro SelPedra.Cpros) - entrada
                *-- livre com lookup em SigCdPro (ValidarPedraProduto /
                *-- AbrirLookupPedraProduto, ligados por BINDEVENT abaixo)
                .Column1.ControlSource     = ""
                .Column1.Width             = 110
                .Column1.Movable           = .F.
                .Column1.Resizable         = .F.
                .Column1.ReadOnly          = .F.
                .Column1.Header1.FontName  = "Verdana"
                .Column1.Header1.FontSize  = 8
                .Column1.Header1.Alignment = 2
                .Column1.Header1.ForeColor = RGB(36, 84, 155)
                .Column1.Header1.Caption   = "Produto"
                .Column1.Text1.FontSize    = 8
                .Column1.Text1.BorderStyle = 0
                .Column1.Text1.Margin      = 0
                .Column1.Text1.ReadOnly    = .F.
                .Column1.Text1.ForeColor   = RGB(0, 0, 0)
                .Column1.Text1.BackColor   = RGB(255, 255, 255)

                *-- Coluna 2 - Descricao (futuro SelPedra.Dpros) - sempre
                *-- ReadOnly, preenchida pelo lookup da Coluna1
                .Column2.ControlSource     = ""
                .Column2.Width             = 215
                .Column2.Movable           = .F.
                .Column2.Resizable         = .F.
                .Column2.ReadOnly          = .T.
                .Column2.Header1.FontName  = "Verdana"
                .Column2.Header1.FontSize  = 8
                .Column2.Header1.Alignment = 2
                .Column2.Header1.ForeColor = RGB(36, 84, 155)
                .Column2.Header1.Caption   = "Descri" + CHR(231) + CHR(227) + "o"
                .Column2.Text1.FontSize    = 8
                .Column2.Text1.BorderStyle = 0
                .Column2.Text1.Margin      = 0
                .Column2.Text1.ReadOnly    = .T.
                .Column2.Text1.ForeColor   = RGB(0, 0, 0)
                .Column2.Text1.BackColor   = RGB(255, 255, 255)

                *-- Coluna 3 - Uni (futuro SelPedra.Cunis) - sempre ReadOnly,
                *-- preenchida pelo lookup da Coluna1
                .Column3.ControlSource     = ""
                .Column3.Width             = 50
                .Column3.Movable           = .F.
                .Column3.Resizable         = .F.
                .Column3.ReadOnly          = .T.
                .Column3.Header1.FontName  = "Verdana"
                .Column3.Header1.FontSize  = 8
                .Column3.Header1.Alignment = 2
                .Column3.Header1.ForeColor = RGB(36, 84, 155)
                .Column3.Header1.Caption   = "Uni"
                .Column3.Text1.FontSize    = 8
                .Column3.Text1.BorderStyle = 0
                .Column3.Text1.Margin      = 0
                .Column3.Text1.ReadOnly    = .T.
                .Column3.Text1.ForeColor   = RGB(0, 0, 0)
                .Column3.Text1.BackColor   = RGB(255, 255, 255)

                *-- Coluna 4 - Qtde (futuro SelPedra.Qtds) - habilita so
                *-- quando a Coluna1 estiver preenchida (gate do When
                *-- legado, reproduzido em PedrasAfterRowColChange)
                .Column4.ControlSource     = ""
                .Column4.Width             = 100
                .Column4.Movable           = .F.
                .Column4.Resizable         = .F.
                .Column4.ReadOnly          = .F.
                .Column4.Header1.FontName  = "Verdana"
                .Column4.Header1.FontSize  = 8
                .Column4.Header1.Alignment = 2
                .Column4.Header1.ForeColor = RGB(36, 84, 155)
                .Column4.Header1.Caption   = "Qtde"
                .Column4.Text1.FontSize    = 8
                .Column4.Text1.BorderStyle = 0
                .Column4.Text1.InputMask   = "999,999.99"
                .Column4.Text1.Margin      = 0
                .Column4.Text1.ReadOnly    = .F.
                .Column4.Text1.ForeColor   = RGB(0, 0, 0)
                .Column4.Text1.BackColor   = RGB(255, 255, 255)

                *-- Coluna 5 - Produto substituto (futuro SelPedra.Cpro2s) -
                *-- lookup proprio em SigCdPro (ValidarPedraSubstituto /
                *-- AbrirLookupPedraSubstituto), habilita so com a Coluna1
                *-- preenchida; LostFocus do legado insere linha em branco
                *-- no SelPedra (PedraSubstitutoLostFocus)
                .Column5.ControlSource     = ""
                .Column5.Width             = 125
                .Column5.Movable           = .F.
                .Column5.Resizable         = .F.
                .Column5.ReadOnly          = .F.
                .Column5.Header1.FontName  = "Verdana"
                .Column5.Header1.FontSize  = 8
                .Column5.Header1.Alignment = 2
                .Column5.Header1.ForeColor = RGB(36, 84, 155)
                .Column5.Header1.Caption   = "Produto"
                .Column5.Text1.FontSize    = 8
                .Column5.Text1.BorderStyle = 0
                .Column5.Text1.Margin      = 0
                .Column5.Text1.ReadOnly    = .F.
                .Column5.Text1.ForeColor   = RGB(0, 0, 0)
                .Column5.Text1.BackColor   = RGB(255, 255, 255)
            ENDWITH

            *-- LOOKUPS fwBuscaExt em SigCdPro (legado: Valid das
            *-- Column1.Text1 e Column5.Text1 do GradePedra). BINDEVENT em
            *-- "Valid" NAO dispara de forma confiavel em TextBox: o gatilho
            *-- equivalente eh KeyPress com ENTER(13)/TAB(9)/F4(115), mais o
            *-- DblClick (CLAUDE.md regra BINDEVENT/KeyPress). Todos os
            *-- handlers sao PUBLIC - BINDEVENT falha em silencio com
            *-- PROTECTED (CLAUDE.md regra #3).
            BINDEVENT(loc_oCnt.grd_4c_Pedras.Column1.Text1, "KeyPress", ;
                      THIS, "PedraProdutoKeyPress")
            BINDEVENT(loc_oCnt.grd_4c_Pedras.Column1.Text1, "DblClick", ;
                      THIS, "PedraProdutoDblClick")
            BINDEVENT(loc_oCnt.grd_4c_Pedras.Column5.Text1, "KeyPress", ;
                      THIS, "PedraSubstitutoKeyPress")
            BINDEVENT(loc_oCnt.grd_4c_Pedras.Column5.Text1, "DblClick", ;
                      THIS, "PedraSubstitutoDblClick")
            BINDEVENT(loc_oCnt.grd_4c_Pedras.Column5.Text1, "LostFocus", ;
                      THIS, "PedraSubstitutoLostFocus")

            *-- Gate das colunas Qtde/Produto-substituto: o legado usa
            *-- "When -> Return (Not Empty(Column1.Text1.Value))" nas
            *-- Column4/Column5. BINDEVENT descarta o retorno do delegate,
            *-- entao o When nao bloqueia edicao por essa via - o
            *-- equivalente fiel eh reavaliar o gate a cada troca de
            *-- linha/coluna (AfterRowColChange) e ligar/desligar as duas
            *-- colunas.
            BINDEVENT(loc_oCnt.grd_4c_Pedras, "AfterRowColChange", ;
                      THIS, "PedrasAfterRowColChange")
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro em ConfigurarContainer4")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarContainer3 - "Estoque Disponivel" por CONTA (Container3 no
    * legado), rodape SEMPRE VISIVEL (o dump nao declara Visible=.F. para
    * ele, ao contrario de Container1/2/4/5) - fica abaixo de grd_4c_Itens
    * (Top=125+224=349) e mostra o detalhe de estoque por Grupo/Conta do
    * ITEM SELECIONADO na grade principal. Distinto de cnt_4c_Container5
    * (mesmo titulo "Estoque Disponivel", mas alternado pelo botao Estoques
    * e mostrando outro produto/cor/tam escolhido pelo usuario).
    *
    * GradeDisp e os campos txt_4c_GetDGrupo/GetDConta/TotQtd/TotEst/TotPrz
    * ficam sem ControlSource/Value dinamico aqui - GradeItens.
    * AfterRowColChange (Fase 7-8) religa TmpSaldG com "Set Key To" filtrado
    * pelo Cpros+CodCors+CodTams do item corrente e atualiza estes campos,
    * igual ao legado.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarContainer3()
        LOCAL loc_oCnt, loc_oErro

        TRY
            THIS.AddObject("cnt_4c_Container3", "Container")
            loc_oCnt = THIS.cnt_4c_Container3
            WITH loc_oCnt
                .Top           = 373
                .Left          = 12
                .Width         = 708
                .Height        = 205
                .SpecialEffect = 0
                .BackColor     = RGB(255, 255, 255)
                .Visible       = .T.
            ENDWITH

            loc_oCnt.AddObject("lbl_4c_Label1", "Label")
            WITH loc_oCnt.lbl_4c_Label1
                .FontBold  = .T.
                .FontName  = "Tahoma"
                .FontSize  = 9
                .BackStyle = 0
                .AutoSize  = .F.
                .Caption   = "Estoque Dispon" + CHR(237) + "vel"
                .Height    = 16
                .Left      = 6
                .Top       = 5
                .Width     = 118
                .ForeColor = RGB(90, 90, 90)
                .Visible   = .T.
            ENDWITH

            loc_oCnt.AddObject("grd_4c_DispConta", "Grid")
            WITH loc_oCnt.grd_4c_DispConta
                .Top               = 24
                .Left              = 6
                .Width             = 444
                .Height            = 148
                .FontSize          = 8
                .AllowHeaderSizing = .F.
                .AllowRowSizing    = .F.
                .DeleteMark        = .F.
                .RecordMark        = .F.
                .RowHeight         = 16
                .ScrollBars        = 2
                .GridLineColor     = RGB(238, 238, 238)
                .ReadOnly          = .T.
                .Visible           = .T.

                .ColumnCount = 6

                *-- Coluna 1 - Grupo (futuro TmpSaldG.Grupos)
                .Column1.ControlSource     = ""
                .Column1.Width             = 75
                .Column1.Movable           = .F.
                .Column1.Resizable         = .F.
                .Column1.ReadOnly          = .T.
                .Column1.Header1.FontName  = "Verdana"
                .Column1.Header1.FontSize  = 8
                .Column1.Header1.Alignment = 2
                .Column1.Header1.ForeColor = RGB(36, 84, 155)
                .Column1.Header1.Caption   = "Grupo"
                .Column1.Text1.FontSize    = 8
                .Column1.Text1.BorderStyle = 0
                .Column1.Text1.Margin      = 0
                .Column1.Text1.ReadOnly    = .T.
                .Column1.Text1.ForeColor   = RGB(0, 0, 0)
                .Column1.Text1.BackColor   = RGB(255, 255, 255)

                *-- Coluna 2 - Conta (futuro TmpSaldG.Estos)
                .Column2.ControlSource     = ""
                .Column2.Width             = 75
                .Column2.Movable           = .F.
                .Column2.Resizable         = .F.
                .Column2.ReadOnly          = .T.
                .Column2.Header1.FontName  = "Verdana"
                .Column2.Header1.FontSize  = 8
                .Column2.Header1.Alignment = 2
                .Column2.Header1.ForeColor = RGB(36, 84, 155)
                .Column2.Header1.Caption   = "Conta"
                .Column2.Text1.FontSize    = 8
                .Column2.Text1.BorderStyle = 0
                .Column2.Text1.Margin      = 0
                .Column2.Text1.ReadOnly    = .T.
                .Column2.Text1.ForeColor   = RGB(0, 0, 0)
                .Column2.Text1.BackColor   = RGB(255, 255, 255)

                *-- Coluna 3 - Atual
                .Column3.ControlSource     = ""
                .Column3.Width             = 70
                .Column3.Movable           = .F.
                .Column3.Resizable         = .F.
                .Column3.ReadOnly          = .T.
                .Column3.Header1.FontName  = "Verdana"
                .Column3.Header1.FontSize  = 8
                .Column3.Header1.Alignment = 2
                .Column3.Header1.ForeColor = RGB(36, 84, 155)
                .Column3.Header1.Caption   = "Atual"
                .Column3.Text1.FontSize    = 8
                .Column3.Text1.BorderStyle = 0
                .Column3.Text1.Margin      = 0
                .Column3.Text1.ReadOnly    = .T.
                .Column3.Text1.ForeColor   = RGB(0, 0, 0)
                .Column3.Text1.BackColor   = RGB(255, 255, 255)

                *-- Coluna 4 - Utilizado (futuro TmpSaldG.Utilizar)
                .Column4.ControlSource     = ""
                .Column4.Width             = 70
                .Column4.Movable           = .F.
                .Column4.Resizable         = .F.
                .Column4.ReadOnly          = .T.
                .Column4.Header1.FontName  = "Verdana"
                .Column4.Header1.FontSize  = 8
                .Column4.Header1.Alignment = 2
                .Column4.Header1.ForeColor = RGB(36, 84, 155)
                .Column4.Header1.Caption   = "Utilizado"
                .Column4.Text1.FontSize    = 8
                .Column4.Text1.BorderStyle = 0
                .Column4.Text1.Margin      = 0
                .Column4.Text1.ReadOnly    = .T.
                .Column4.Text1.ForeColor   = RGB(0, 0, 0)
                .Column4.Text1.BackColor   = RGB(255, 255, 255)

                *-- Coluna 5 - Disponivel (futuro TmpSaldG.Disps)
                .Column5.ControlSource     = ""
                .Column5.Width             = 80
                .Column5.Movable           = .F.
                .Column5.Resizable         = .F.
                .Column5.ReadOnly          = .T.
                .Column5.Header1.FontName  = "Verdana"
                .Column5.Header1.FontSize  = 8
                .Column5.Header1.Alignment = 2
                .Column5.Header1.ForeColor = RGB(36, 84, 155)
                .Column5.Header1.Caption   = "Dispon" + CHR(237) + "vel"
                .Column5.Text1.FontSize    = 8
                .Column5.Text1.BorderStyle = 0
                .Column5.Text1.Margin      = 0
                .Column5.Text1.ReadOnly    = .T.
                .Column5.Text1.ForeColor   = RGB(0, 0, 0)
                .Column5.Text1.BackColor   = RGB(255, 255, 255)

                *-- Coluna 6 - Emp (futuro TmpSaldG.Estos - empresa/filial)
                .Column6.ControlSource     = ""
                .Column6.Width             = 64
                .Column6.Movable           = .F.
                .Column6.Resizable         = .F.
                .Column6.ReadOnly          = .T.
                .Column6.Header1.FontName  = "Verdana"
                .Column6.Header1.FontSize  = 8
                .Column6.Header1.Alignment = 2
                .Column6.Header1.ForeColor = RGB(36, 84, 155)
                .Column6.Header1.Caption   = "Emp"
                .Column6.Text1.FontSize    = 8
                .Column6.Text1.BorderStyle = 0
                .Column6.Text1.Margin      = 0
                .Column6.Text1.ReadOnly    = .T.
                .Column6.Text1.ForeColor   = RGB(0, 0, 0)
                .Column6.Text1.BackColor   = RGB(255, 255, 255)
            ENDWITH

            loc_oCnt.AddObject("lbl_4c_Label2", "Label")
            WITH loc_oCnt.lbl_4c_Label2
                .FontBold  = .T.
                .FontName  = "Tahoma"
                .FontSize  = 8
                .BackStyle = 0
                .AutoSize  = .F.
                .Caption   = "Grupo"
                .Height    = 15
                .Left      = 454
                .Top       = 90
                .Width     = 36
                .ForeColor = RGB(90, 90, 90)
                .Visible   = .T.
            ENDWITH

            loc_oCnt.AddObject("txt_4c_GetDGrupo", "TextBox")
            WITH loc_oCnt.txt_4c_GetDGrupo
                .Height        = 23
                .Width         = 247
                .Left          = 454
                .Top           = 106
                .SpecialEffect = 1
                .ReadOnly      = .T.
                .Visible       = .T.
            ENDWITH

            loc_oCnt.AddObject("lbl_4c_Label3", "Label")
            WITH loc_oCnt.lbl_4c_Label3
                .FontBold  = .T.
                .FontName  = "Tahoma"
                .FontSize  = 8
                .BackStyle = 0
                .AutoSize  = .F.
                .Caption   = "Conta"
                .Height    = 15
                .Left      = 454
                .Top       = 131
                .Width     = 35
                .ForeColor = RGB(90, 90, 90)
                .Visible   = .T.
            ENDWITH

            loc_oCnt.AddObject("txt_4c_GetDConta", "TextBox")
            WITH loc_oCnt.txt_4c_GetDConta
                .Height        = 23
                .Width         = 247
                .Left          = 454
                .Top           = 147
                .SpecialEffect = 1
                .ReadOnly      = .T.
                .Visible       = .T.
            ENDWITH

            loc_oCnt.AddObject("txt_4c_TotQtd", "TextBox")
            WITH loc_oCnt.txt_4c_TotQtd
                .Height        = 23
                .Width         = 80
                .Left          = 188
                .Top           = 173
                .InputMask     = "99,999.99"
                .SpecialEffect = 1
                .Value         = 0
                .ReadOnly      = .T.
                .Visible       = .T.
            ENDWITH

            loc_oCnt.AddObject("txt_4c_TotEst", "TextBox")
            WITH loc_oCnt.txt_4c_TotEst
                .Height        = 23
                .Width         = 80
                .Left          = 269
                .Top           = 173
                .InputMask     = "99,999.99"
                .SpecialEffect = 1
                .Value         = 0
                .ReadOnly      = .T.
                .Visible       = .T.
            ENDWITH

            loc_oCnt.AddObject("txt_4c_TotPrz", "TextBox")
            WITH loc_oCnt.txt_4c_TotPrz
                .Height        = 23
                .Width         = 80
                .Left          = 350
                .Top           = 173
                .InputMask     = "99,999.99"
                .SpecialEffect = 1
                .Value         = 0
                .ReadOnly      = .T.
                .Visible       = .T.
            ENDWITH
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro em ConfigurarContainer3")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarCamposTotais - Ultimos controles filhos diretos do form:
    * totais da grade principal (txt_4c_TotQtd/TotEst/TotPrz, Top=349,
    * logo abaixo de grd_4c_Itens - distintos dos hom?nimos dentro de
    * cnt_4c_Container3, que mostram o detalhe da LINHA selecionada, nao o
    * somatorio geral), a foto do item (img_4c_ImgFigJpg, nasce oculta) e a
    * observacao do item (lbl_4c_TxtObsItens/obj_4c_ObsItens). Todos
    * alimentados por GradeItens.AfterRowColChange/Column6.Text1.LostFocus
    * na Fase 7-8 - aqui e so a moldura visual.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarCamposTotais()
        LOCAL loc_oErro

        TRY
            THIS.AddObject("txt_4c_TotQtd", "TextBox")
            WITH THIS.txt_4c_TotQtd
                .Height        = 23
                .Width         = 80
                .Left          = 417
                .Top           = 349
                .InputMask     = "999,999.99"
                .SpecialEffect = 1
                .Value         = 0
                .ReadOnly      = .T.
                .Visible       = .T.
            ENDWITH

            THIS.AddObject("txt_4c_TotEst", "TextBox")
            WITH THIS.txt_4c_TotEst
                .Height        = 23
                .Width         = 81
                .Left          = 498
                .Top           = 349
                .InputMask     = "999,999.99"
                .SpecialEffect = 1
                .Value         = 0
                .ReadOnly      = .T.
                .Visible       = .T.
            ENDWITH

            THIS.AddObject("txt_4c_TotPrz", "TextBox")
            WITH THIS.txt_4c_TotPrz
                .Height        = 23
                .Width         = 82
                .Left          = 580
                .Top           = 349
                .InputMask     = "999,999.99"
                .SpecialEffect = 1
                .Value         = 0
                .ReadOnly      = .T.
                .Visible       = .T.
            ENDWITH

            *-- Foto do item selecionado na grade principal - nasce oculta,
            *-- igual ao legado (Visible=.F. no dump); GradeItens.
            *-- AfterRowColChange decide quando mostrar (Fase 7-8).
            THIS.AddObject("img_4c_ImgFigJpg", "Image")
            WITH THIS.img_4c_ImgFigJpg
                .Top     = 125
                .Left    = 726
                .Width   = 266
                .Height  = 204
                .Stretch = 2
                .Visible = .F.
            ENDWITH

            THIS.AddObject("lbl_4c_TxtObsItens", "Label")
            WITH THIS.lbl_4c_TxtObsItens
                .FontBold  = .T.
                .FontName  = "Verdana"
                .FontSize  = 8
                .BackStyle = 0
                .AutoSize  = .F.
                .Caption   = "Observa" + CHR(231) + CHR(227) + "o do Item"
                .Height    = 15
                .Left      = 726
                .Top       = 369
                .Width     = 134
                *-- ForeColor diverge do SCX de proposito: o legado declara
                *-- 255,255,255 (branco), mas o label fica ABAIXO de
                *-- img_4c_ImgFigJpg (Top 125..329), sobre o fundo CLARO do
                *-- form (new_background.jpg) - branco ficaria invisivel
                *-- (CLAUDE.md #12/#23). RGB(90,90,90) eh o canonico do
                *-- projeto para label de dados.
                .ForeColor = RGB(90, 90, 90)
                .Visible   = .T.
            ENDWITH

            THIS.AddObject("obj_4c_ObsItens", "EditBox")
            WITH THIS.obj_4c_ObsItens
                .Top           = 361
                .Left          = 732
                .Width         = 266
                .Height        = 205
                .FontName      = "Tahoma"
                .FontSize      = 8
                .ScrollBars    = 2
                .SpecialEffect = 1
                .ReadOnly      = .F.
                .Value         = ""
                .Visible       = .T.
            ENDWITH
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro em ConfigurarCamposTotais")
        ENDTRY
    ENDPROC

    *==========================================================================
    * LOOKUPS DO grd_4c_Pedras (Container4 - "Requisicao de componentes
    * adicionais")
    *
    * Legado (SIGPRGLP.Container4.GradePedra):
    *   Column1.Text1.Valid -> CreateObject('fwBuscaExt', <conn>, 'SigCdPro',
    *       'crListaRemota', 'CPros', This.Value, 'Selecao', 1000);
    *       se Not plAchouRegistro -> mAddColuna('CPros'), mAddColuna('DPros'),
    *       Show(); This.Value = CrListaRemota.Cpros;
    *       Replace SelPedra.Dpros WITH CrListaRemota.Dpros,
    *               SelPedra.Cunis WITH CrListaRemota.Cunis IN SelPedra;
    *       Use In crListaRemota; GradePedra.Refresh
    *   Column5.Text1.Valid -> mesmo lookup, sem o Replace (so o codigo do
    *       produto substituto)
    *   Column4/Column5.When -> Return (Not Empty(Column1.Text1.Value))
    *   Column5.Text1.LostFocus -> garante uma linha em branco no fim do
    *       SelPedra (Locate For Empty(Cpros) / Append Blank) e desce o cursor
    *
    * Migrado: o picker canonico do projeto eh FormBuscaAuxiliar (substitui
    * fwBuscaExt). Contrato obrigatorio (CLAUDE.md regra #37): 1o argumento eh
    * o HANDLE da conexao (regra #36); Show() SO quando this_lAchouRegistro
    * for .F.; atribuicao SO sob this_lSelecionou - fora da guarda, uma
    * desistencia do usuario ZERARIA o codigo ja digitado.
    *==========================================================================

    *--------------------------------------------------------------------------
    * PedraProdutoKeyPress - Gatilho do lookup da coluna Produto. PUBLIC
    * (BINDEVENT falha em silencio com PROTECTED). LPARAMETERS obrigatorio,
    * senao o VFP9 estoura "No PARAMETER statement is found".
    *--------------------------------------------------------------------------
    PROCEDURE PedraProdutoKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        *-- ENTER(13)/TAB(9) reproduzem o Valid do legado (que rodava ao sair
        *-- da celula); F4(115) eh o atalho de lookup do projeto.
        IF par_nKeyCode = 13 OR par_nKeyCode = 9 OR par_nKeyCode = 115
            THIS.ValidarPedraProduto()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * PedraProdutoDblClick - Duplo clique na celula Produto abre o picker
    * direto (equivalente ao F4).
    *--------------------------------------------------------------------------
    PROCEDURE PedraProdutoDblClick()
        THIS.AbrirLookupPedraProduto()
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarPedraProduto - Valid da Column1.Text1 do GradePedra. Com a
    * celula vazia o legado nao faz nada ("If Not Empty(This.Value)"); com
    * valor digitado tenta o casamento EXATO em SigCdPro e, achando, ja
    * preenche Descricao/Unidade no SelPedra sem exibir dialogo. Nao achando,
    * cai no picker (AbrirLookupPedraProduto), que repete o padrao do legado
    * (o fwBuscaExt tambem so mostrava a lista quando plAchouRegistro = .F.).
    *--------------------------------------------------------------------------
    PROCEDURE ValidarPedraProduto()
        LOCAL loc_oTxt, loc_cValor, loc_nResultado, loc_lAchou, loc_oErro

        loc_lAchou = .F.

        TRY
            loc_oTxt   = THIS.cnt_4c_Container4.grd_4c_Pedras.Column1.Text1
            loc_cValor = ALLTRIM(TRANSFORM(loc_oTxt.Value))

            IF !EMPTY(loc_cValor)
                IF USED("cursor_4c_BuscaPedra")
                    USE IN cursor_4c_BuscaPedra
                ENDIF

                IF TYPE("gnConnHandle") = "N" AND gnConnHandle > 0
                    loc_nResultado = SQLEXEC(gnConnHandle, ;
                        "SELECT cpros, dpros, cunis FROM SigCdPro " + ;
                        "WHERE cpros = " + EscaparSQL(loc_cValor), ;
                        "cursor_4c_BuscaPedra")

                    IF loc_nResultado > 0 AND USED("cursor_4c_BuscaPedra") ;
                       AND RECCOUNT("cursor_4c_BuscaPedra") = 1
                        SELECT cursor_4c_BuscaPedra
                        GO TOP
                        THIS.AplicarPedraProduto(ALLTRIM(cursor_4c_BuscaPedra.cpros), ;
                                                 ALLTRIM(cursor_4c_BuscaPedra.dpros), ;
                                                 ALLTRIM(cursor_4c_BuscaPedra.cunis))
                        loc_lAchou = .T.
                    ENDIF
                ENDIF

                IF USED("cursor_4c_BuscaPedra")
                    USE IN cursor_4c_BuscaPedra
                ENDIF

                *-- Sem casamento exato o legado abria a lista - NUNCA
                *-- MsgAviso("nao encontrado") + limpar o campo antes do
                *-- picker (anti-padrao ja registrado no CLAUDE.md).
                IF !loc_lAchou
                    THIS.AbrirLookupPedraProduto()
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro em ValidarPedraProduto")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * AbrirLookupPedraProduto - Picker de SigCdPro para a coluna Produto.
    * Substitui o "CreateObject('fwBuscaExt', ..., 'SigCdPro', 'crListaRemota',
    * 'CPros', This.Value, 'Selecao', 1000)" do legado.
    *--------------------------------------------------------------------------
    PROCEDURE AbrirLookupPedraProduto()
        LOCAL loc_oBusca, loc_oTxt, loc_cValor, loc_oErro

        *-- Guarda de reentrancia: o picker eh MODAL e o foco sai/volta da
        *-- celula, podendo redisparar o proprio gatilho.
        IF THIS.this_lLookupAberto
            RETURN
        ENDIF
        THIS.this_lLookupAberto = .T.

        TRY
            loc_oTxt   = THIS.cnt_4c_Container4.grd_4c_Pedras.Column1.Text1
            loc_cValor = ALLTRIM(TRANSFORM(loc_oTxt.Value))

            IF USED("cursor_4c_BuscaPedra")
                USE IN cursor_4c_BuscaPedra
            ENDIF

            *-- 1o argumento = HANDLE da conexao (CLAUDE.md regra #36)
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigCdPro", ;
                "cursor_4c_BuscaPedra", ;
                "cpros", ;
                loc_cValor, ;
                "Sele" + CHR(231) + CHR(227) + "o de Produto")

            IF VARTYPE(loc_oBusca) = "O"
                *-- Show() SO quando o Init nao resolveu sozinho o valor
                IF !loc_oBusca.this_lAchouRegistro
                    loc_oBusca.mAddColuna("cpros", "", "C" + CHR(243) + "digo")
                    loc_oBusca.mAddColuna("dpros", "", "Descri" + CHR(231) + CHR(227) + "o")
                    loc_oBusca.Show()
                ENDIF

                *-- Atribuicao SO sob a guarda de selecao
                IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaPedra")
                    SELECT cursor_4c_BuscaPedra
                    THIS.AplicarPedraProduto(ALLTRIM(cursor_4c_BuscaPedra.cpros), ;
                                             ALLTRIM(cursor_4c_BuscaPedra.dpros), ;
                                             ALLTRIM(cursor_4c_BuscaPedra.cunis))
                ENDIF

                loc_oBusca.Release()
            ENDIF

            IF USED("cursor_4c_BuscaPedra")
                USE IN cursor_4c_BuscaPedra
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro em AbrirLookupPedraProduto")
        ENDTRY

        *-- Limpar DEPOIS do ENDTRY, para valer tambem quando o CATCH dispara
        THIS.this_lLookupAberto = .F.
    ENDPROC

    *--------------------------------------------------------------------------
    * AplicarPedraProduto - Efetiva a escolha do produto na linha corrente do
    * SelPedra. Transcreve o trecho final do Valid legado:
    *   This.Value = CrListaRemota.Cpros
    *   Replace SelPedra.Dpros WITH CrListaRemota.Dpros,
    *           SelPedra.Cunis WITH CrListaRemota.Cunis IN SelPedra
    *   ThisForm.Container4.GradePedra.Refresh
    * O SelPedra eh cursor de trabalho criado pelo form PAI (mesma
    * DataSession) - por isso o USED() antes do REPLACE.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE AplicarPedraProduto(par_cCodigo, par_cDescricao, par_cUnidade)
        LOCAL loc_oGrid

        loc_oGrid = THIS.cnt_4c_Container4.grd_4c_Pedras
        loc_oGrid.Column1.Text1.Value = par_cCodigo

        IF USED("SelPedra") AND !EOF("SelPedra")
            REPLACE SelPedra.Dpros WITH par_cDescricao, ;
                    SelPedra.Cunis WITH par_cUnidade IN SelPedra
        ENDIF

        *-- Com o Produto preenchido, o gate do When legado passa a liberar
        *-- as colunas Qtde e Produto substituto.
        THIS.AjustarColunasPedra()
        loc_oGrid.Refresh()
    ENDPROC

    *--------------------------------------------------------------------------
    * PedraSubstitutoKeyPress - Gatilho do lookup da coluna Produto
    * substituto (Column5). PUBLIC + LPARAMETERS, mesmas razoes da Column1.
    *--------------------------------------------------------------------------
    PROCEDURE PedraSubstitutoKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 13 OR par_nKeyCode = 9 OR par_nKeyCode = 115
            THIS.ValidarPedraSubstituto()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * PedraSubstitutoDblClick - Duplo clique abre o picker direto.
    *--------------------------------------------------------------------------
    PROCEDURE PedraSubstitutoDblClick()
        THIS.AbrirLookupPedraSubstituto()
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarPedraSubstituto - Valid da Column5.Text1 do GradePedra. Igual ao
    * da Column1, SEM o Replace de Descricao/Unidade (o legado so atribui o
    * codigo nesta coluna).
    *--------------------------------------------------------------------------
    PROCEDURE ValidarPedraSubstituto()
        LOCAL loc_oTxt, loc_cValor, loc_nResultado, loc_lAchou, loc_oErro

        loc_lAchou = .F.

        TRY
            loc_oTxt   = THIS.cnt_4c_Container4.grd_4c_Pedras.Column5.Text1
            loc_cValor = ALLTRIM(TRANSFORM(loc_oTxt.Value))

            IF !EMPTY(loc_cValor)
                IF USED("cursor_4c_BuscaPedra2")
                    USE IN cursor_4c_BuscaPedra2
                ENDIF

                IF TYPE("gnConnHandle") = "N" AND gnConnHandle > 0
                    loc_nResultado = SQLEXEC(gnConnHandle, ;
                        "SELECT cpros, dpros FROM SigCdPro " + ;
                        "WHERE cpros = " + EscaparSQL(loc_cValor), ;
                        "cursor_4c_BuscaPedra2")

                    IF loc_nResultado > 0 AND USED("cursor_4c_BuscaPedra2") ;
                       AND RECCOUNT("cursor_4c_BuscaPedra2") = 1
                        SELECT cursor_4c_BuscaPedra2
                        GO TOP
                        THIS.AplicarPedraSubstituto(ALLTRIM(cursor_4c_BuscaPedra2.cpros))
                        loc_lAchou = .T.
                    ENDIF
                ENDIF

                IF USED("cursor_4c_BuscaPedra2")
                    USE IN cursor_4c_BuscaPedra2
                ENDIF

                IF !loc_lAchou
                    THIS.AbrirLookupPedraSubstituto()
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro em ValidarPedraSubstituto")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * AbrirLookupPedraSubstituto - Picker de SigCdPro para a coluna Produto
    * substituto (Column5.Text1 do GradePedra).
    *--------------------------------------------------------------------------
    PROCEDURE AbrirLookupPedraSubstituto()
        LOCAL loc_oBusca, loc_oTxt, loc_cValor, loc_oErro

        IF THIS.this_lLookupAberto
            RETURN
        ENDIF
        THIS.this_lLookupAberto = .T.

        TRY
            loc_oTxt   = THIS.cnt_4c_Container4.grd_4c_Pedras.Column5.Text1
            loc_cValor = ALLTRIM(TRANSFORM(loc_oTxt.Value))

            IF USED("cursor_4c_BuscaPedra2")
                USE IN cursor_4c_BuscaPedra2
            ENDIF

            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigCdPro", ;
                "cursor_4c_BuscaPedra2", ;
                "cpros", ;
                loc_cValor, ;
                "Sele" + CHR(231) + CHR(227) + "o de Produto")

            IF VARTYPE(loc_oBusca) = "O"
                IF !loc_oBusca.this_lAchouRegistro
                    loc_oBusca.mAddColuna("cpros", "", "C" + CHR(243) + "digo")
                    loc_oBusca.mAddColuna("dpros", "", "Descri" + CHR(231) + CHR(227) + "o")
                    loc_oBusca.Show()
                ENDIF

                IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaPedra2")
                    SELECT cursor_4c_BuscaPedra2
                    THIS.AplicarPedraSubstituto(ALLTRIM(cursor_4c_BuscaPedra2.cpros))
                ENDIF

                loc_oBusca.Release()
            ENDIF

            IF USED("cursor_4c_BuscaPedra2")
                USE IN cursor_4c_BuscaPedra2
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro em AbrirLookupPedraSubstituto")
        ENDTRY

        THIS.this_lLookupAberto = .F.
    ENDPROC

    *--------------------------------------------------------------------------
    * AplicarPedraSubstituto - "This.Value = CrListaRemota.Cpros" +
    * "ThisForm.Container4.GradePedra.Refresh" do Valid legado da Column5.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE AplicarPedraSubstituto(par_cCodigo)
        LOCAL loc_oGrid

        loc_oGrid = THIS.cnt_4c_Container4.grd_4c_Pedras
        loc_oGrid.Column5.Text1.Value = par_cCodigo
        loc_oGrid.Refresh()
    ENDPROC

    *--------------------------------------------------------------------------
    * PedraSubstitutoLostFocus - LostFocus da Column5.Text1 do GradePedra.
    * Transcricao do legado:
    *   SELECT SelPedra / xPosicao = RECNO() / Locate For Empty(Cpros)
    *   If Eof() / Append Blank / EndIf
    *   Locate for Recno() = xPosicao / KEYBOARD '{DNARROW}'
    * Ou seja: garante que exista sempre UMA linha em branco no fim do
    * cursor (para o usuario continuar digitando), volta para a linha em que
    * estava e desce uma linha. PUBLIC (BINDEVENT).
    *--------------------------------------------------------------------------
    PROCEDURE PedraSubstitutoLostFocus()
        LOCAL loc_nPosicao, loc_cAliasAnterior, loc_oErro

        TRY
            IF USED("SelPedra")
                loc_cAliasAnterior = ALIAS()

                SELECT SelPedra
                loc_nPosicao = RECNO("SelPedra")

                LOCATE FOR EMPTY(SelPedra.Cpros)
                IF EOF("SelPedra")
                    APPEND BLANK IN SelPedra
                ENDIF

                *-- "Locate for Recno() = xPosicao" do legado: volta para o
                *-- registro em que o usuario estava
                IF loc_nPosicao > 0 AND loc_nPosicao <= RECCOUNT("SelPedra")
                    GO loc_nPosicao IN SelPedra
                ENDIF

                IF !EMPTY(loc_cAliasAnterior) AND USED(loc_cAliasAnterior)
                    SELECT (loc_cAliasAnterior)
                ENDIF

                KEYBOARD "{DNARROW}"
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro em PedraSubstitutoLostFocus")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * PedrasAfterRowColChange - Reavalia, a cada troca de linha/coluna do
    * grd_4c_Pedras, o gate que o legado escrevia no When das Column4/Column5:
    *   "RETURN (Not EMPTY(ThisForm.Container4.GradePedra.Column1.Text1.Value))"
    * Guarda tambem o ThisForm.AntValue que o When da Column5 registrava.
    * PUBLIC e com o parametro do evento declarado (AfterRowColChange recebe
    * nColIndex) - CLAUDE.md regra #3.
    *--------------------------------------------------------------------------
    PROCEDURE PedrasAfterRowColChange(par_nColIndex)
        THIS.AjustarColunasPedra()
    ENDPROC

    *--------------------------------------------------------------------------
    * AjustarColunasPedra - Aplica o gate do When legado: Qtde (Column4) e
    * Produto substituto (Column5) so aceitam digitacao com o Produto
    * (Column1) preenchido. Column.ReadOnly eh definido DEPOIS do
    * Grid.ReadOnly (o do grid propaga para as colunas e sobrescreveria).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE AjustarColunasPedra()
        LOCAL loc_oGrid, loc_lLiberado, loc_oErro

        TRY
            loc_oGrid = THIS.cnt_4c_Container4.grd_4c_Pedras

            loc_lLiberado = !EMPTY(ALLTRIM(TRANSFORM(loc_oGrid.Column1.Text1.Value)))

            loc_oGrid.Column4.ReadOnly       = !loc_lLiberado
            loc_oGrid.Column4.Text1.ReadOnly = !loc_lLiberado
            loc_oGrid.Column5.ReadOnly       = !loc_lLiberado
            loc_oGrid.Column5.Text1.ReadOnly = !loc_lLiberado

            *-- "ThisForm.AntValue = This.Value" do When da Column5
            THIS.this_cAntValue = ALLTRIM(TRANSFORM(loc_oGrid.Column5.Text1.Value))
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro em AjustarColunasPedra")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * PrepararCursoresDeTrabalho - Completa a preparacao de dados que o Init
    * legado faz DEPOIS de montar a tela e da qual os eventos desta fase
    * dependem (transcrito de SIGPRGLP.Init, dump linhas 2891-2959):
    *
    *   SELECT SelPedra / IF RECCOUNT() = 0 / APPEND BLANK    -> a grade de
    *       Requisicoes (cmd_4c_Pedras) abre com UMA linha em branco pronta
    *       para digitacao; sem isso o Click liga o grid a um cursor vazio.
    *   Create Cursor TmpSaldU (Cpros c(14), KeySelm L)       -> marca os
    *       produtos cujo estoque foi escolhido MANUALMENTE (consumido por
    *       BtnConfirmarDispGrupoClick).
    *   crSigCdCom (SigCdTpc + SigCdCom)                      -> tipos de
    *       componente que entram no custo (consumido pelo AtualizaPeso).
    *   Bind do grid do Container3 + Set Order/Set Key de TmpSaldG.
    *   SetAll('ReadOnly', .t.) da grade principal quando SigCdPam.TransfRes
    *       esta vazio (sem operacao de transferencia nao se edita Produzir).
    *   Totais Tot_Qtd/Tot_Est/Tot_Prz somados de TmpFinal.
    *
    * Todos os cursores de trabalho chegam prontos do form pai, na
    * DataSession privada compartilhada - por isso cada bloco eh guardado
    * por USED(): em modo de teste de UI nenhum deles existe e o metodo
    * simplesmente nao faz nada, sem erro.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE PrepararCursoresDeTrabalho()
        LOCAL loc_oErro, loc_nResultado, loc_cSQL

        TRY
            *-- Linha em branco no SelPedra (Init legado)
            IF USED("SelPedra")
                SELECT SelPedra
                IF RECCOUNT("SelPedra") = 0
                    APPEND BLANK
                ENDIF
            ENDIF

            *-- TmpSaldU - produtos com selecao MANUAL de estoque
            IF !USED("TmpSaldU")
                CREATE CURSOR TmpSaldU (Cpros C(14), KeySelm L)
                INDEX ON Cpros TAG Cpros
            ENDIF

            *-- crSigCdCom: "Select a.Tipos, a.Custos, b.CGrus From SigCdTpc a,
            *-- SigCdCom b Where a.Tipos = b.Tipos" + "Index On Tipos + CGrus
            *-- Tag Tipos" do Init legado. Vai para cursor temporario e dai
            *-- para cursor READWRITE porque cursor de SQLEXEC nasce
            *-- somente-leitura e nao aceita INDEX ON.
            IF TYPE("gnConnHandle") = "N" AND gnConnHandle > 0 AND !USED("crSigCdCom")
                loc_cSQL = "SELECT a.Tipos, a.Custos, b.CGrus" + ;
                           "  FROM SigCdTpc a, SigCdCom b" + ;
                           " WHERE a.Tipos = b.Tipos"

                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ComTmp")

                IF loc_nResultado >= 0 AND USED("cursor_4c_ComTmp")
                    SELECT * FROM cursor_4c_ComTmp INTO CURSOR crSigCdCom READWRITE
                    USE IN cursor_4c_ComTmp
                    SELECT crSigCdCom
                    INDEX ON Tipos + CGrus TAG Tipos
                ELSE
                    MsgErro("Falha ao carregar os tipos de componente (crSigCdCom)." + ;
                        CHR(13) + CapturarErroSQL(), "Erro")
                ENDIF
            ENDIF

            *-- TmpSaldG na ordem/faixa do item corrente + bind do Container3
            IF USED("TmpSaldG")
                SELECT TmpSaldG
                SET ORDER TO Cpros
                THIS.AplicarFaixaSaldoContas()
                THIS.LigarGradeContas()
            ENDIF

            *-- "Select TmpFinal / Sum Saldo, Estoque, Produzir / Go Top" +
            *-- os tres Tot_*.Value do Init legado. O GO TOP vem ANTES: o
            *-- legado deixa o ponteiro no primeiro item, e BOParaForm
            *-- preserva o RECNO corrente ao somar.
            IF USED("TmpFinal")
                SELECT TmpFinal
                GO TOP
            ENDIF
            THIS.BOParaForm()

            *-- Estado inicial dos botoes de acao + o "If
            *-- Empty(crSigCdPam.TransfRes) / .SetAll('ReadOnly', .t.)" do
            *-- Init legado (a grade inteira vira somente-leitura sem a
            *-- operacao de transferencia de reserva configurada)
            THIS.AjustarBotoesPorModo()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro em PrepararCursoresDeTrabalho")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * AplicarFaixaSaldoContas - Restringe TmpSaldG ao item corrente de
    * TmpFinal (Produto + Cor + Tamanho), que eh o "Set Key To TmpFinal.Cpros
    * + TmpFinal.CodCors + TmpFinal.CodTams" do Init legado - reemitido la
    * pelo AfterRowColChange a cada troca de linha da grade principal.
    *
    * NAO da para usar SET KEY aqui. O indice de TmpSaldG eh COMPOSTO
    * (Cpros + CodCors + CodTams + Str(Priors,2) + Grupos + Estos) e a
    * chave acima cobre so os 22 primeiros caracteres; o legado roda com o
    * SET EXACT OFF default do VFP, mas o config.prg deste projeto liga
    * SET EXACT ON (linha 231), e com ele faixa/SEEK parciais sobre indice
    * composto NUNCA casam. Medido no VFP9 em 2026-09-29:
    *
    *     EXACT ON  -> SET KEY parcial: eof=.T. | SEEK parcial: .F.
    *     EXACT OFF -> SET KEY parcial: eof=.F. | SEEK parcial: .T.
    *
    * e a faixa eh avaliada na NAVEGACAO, nao no comando - setar SET KEY sob
    * EXACT OFF e restaurar EXACT ON em seguida tambem devolve eof=.T.
    * O efeito seria invisivel: com a faixa vazia o grid do Container3 fica
    * sempre em branco e, pior, "REPLACE TmpSaldG.Disps" em EOF NAO da erro
    * (medido) - a baixa de estoque por conta simplesmente nao aconteceria.
    *
    * A saida eh SET FILTER com "==" (comparacao exata, alheia ao SET
    * EXACT), com o valor da chave EMBUTIDO por macro para o filtro
    * ficar CONGELADO no item corrente, como o SET KEY do legado - um
    * filtro que referenciasse TmpFinal seria reavaliado a cada navegacao e
    * quebraria se TmpFinal fosse fechado ou chegasse a EOF.
    *--------------------------------------------------------------------------
    PROCEDURE AplicarFaixaSaldoContas()
        LOCAL loc_cChave, loc_cFiltro, loc_oErro

        TRY
            IF USED("TmpSaldG")
                SELECT TmpSaldG

                IF USED("TmpFinal") AND !EOF("TmpFinal")
                    loc_cChave = TmpFinal.Cpros + TmpFinal.CodCors + TmpFinal.CodTams
                    *-- "]" quebraria o delimitador do literal montado abaixo;
                    *-- nenhum codigo de produto/cor/tamanho o usa
                    loc_cChave = STRTRAN(loc_cChave, "]", " ")

                    loc_cFiltro = "Cpros + CodCors + CodTams == [" + loc_cChave + "]"
                    SET FILTER TO &loc_cFiltro
                ELSE
                    SET FILTER TO
                ENDIF

                GO TOP
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro em AplicarFaixaSaldoContas")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * LigarGradeContas - Liga o grid do Container3 (rodape SEMPRE visivel,
    * "Estoque Disponivel" por Grupo/Conta) ao cursor TmpSaldG, transcrito
    * de "With ThisForm.Container3.GradeDisp ... EndWith" do Init legado.
    *
    * Column4 exibe uma EXPRESSAO ("TmpSaldG.Saldo - TmpSaldG.Disps" = o
    * que ja foi utilizado), nao uma coluna - igual ao legado.
    *
    * .SetAll("ReadOnly", .T.) vem ANTES de .Column6.ReadOnly = .F. porque o
    * ReadOnly do Grid propaga para as colunas e sobrescreveria (regra #18).
    * Column6 (Emp) so libera quando o usuario tem o acesso PRIORIDADE.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE LigarGradeContas()
        LOCAL loc_oErro

        TRY
            WITH THIS.cnt_4c_Container3.grd_4c_DispConta
                .RecordSource          = "TmpSaldG"
                .Column1.ControlSource = "TmpSaldG.Grupos"
                .Column2.ControlSource = "TmpSaldG.Estos"
                .Column3.ControlSource = "TmpSaldG.Saldo"
                .Column4.ControlSource = "TmpSaldG.Saldo - TmpSaldG.Disps"
                .Column5.ControlSource = "TmpSaldG.Disps"
                .Column6.ControlSource = "TmpSaldG.Emps"

                .SetAll("ReadOnly", .T.)

                IF fChecaAcesso("SIGPRGLO", "PRIORIDADE")
                    .Column6.ReadOnly              = .F.
                    THIS.cmd_4c_SelEstoque.Enabled = .T.
                ENDIF

                .Refresh()
            ENDWITH
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro em LigarGradeContas")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarEventos - Liga cada botao de acao ao seu handler.
    *
    * Os handlers sao PUBLIC (sem PROTECTED): BINDEVENT falha em SILENCIO
    * com metodo PROTECTED (CLAUDE.md regra #3).
    *
    * Os nomes seguem a ACAO e nao o nome do objeto legado, que eh misnomer
    * em dois casos: o "CancelaDisp" do Container2 e do Container5 nao
    * cancela nada - eh o OK que aplica a quantidade digitada na coluna
    * Utilizar e baixa o estoque (o SCX do Container5 ate rotula o botao
    * como "OK"). Nos Containers 1 e 4 o mesmo nome de classe so fecha o
    * painel, e ai o nome Fechar* eh o correto.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarEventos()
        LOCAL loc_oErro

        TRY
            BINDEVENT(THIS.cmd_4c_Disponivel,   "Click", THIS, "BtnDisponivelClick")
            BINDEVENT(THIS.cmd_4c_SelEstoque,   "Click", THIS, "BtnSelEstoqueClick")
            BINDEVENT(THIS.cmd_4c_TotLinha,     "Click", THIS, "BtnTotLinhaClick")
            BINDEVENT(THIS.cmd_4c_Pedras,       "Click", THIS, "BtnPedrasClick")
            BINDEVENT(THIS.cmd_4c_BtnRelatorio, "Click", THIS, "BtnRelatorioClick")
            BINDEVENT(THIS.cmd_4c_Cancelar,     "Click", THIS, "BtnSairClick")

            BINDEVENT(THIS.cnt_4c_Container2.cmd_4c_CancelaDisp, "Click", ;
                THIS, "BtnConfirmarDispProdutoClick")
            BINDEVENT(THIS.cnt_4c_Container5.cmd_4c_CancelaDisp, "Click", ;
                THIS, "BtnConfirmarDispGrupoClick")
            BINDEVENT(THIS.cnt_4c_Container4.cmd_4c_CancelaDisp, "Click", ;
                THIS, "BtnFecharPedrasClick")
            BINDEVENT(THIS.cnt_4c_Container1.cmd_4c_CancelaLin,  "Click", ;
                THIS, "BtnFecharLinhasClick")

            BINDEVENT(THIS.cmd_4c_Processar, "Click", THIS, "BtnProcessarClick")

            *-- Grade principal (GradeItens) - troca de linha/coluna alimenta
            *-- Container3/totais/imagem/observacao (legado: AfterRowColChange)
            BINDEVENT(THIS.grd_4c_Itens, "AfterRowColChange", ;
                THIS, "GradeItensAfterRowColChange")

            *-- Coluna Produzir (Column6, fisica e por .Name - fix do bug de
            *-- troca com a Column3, ver ConfigurarGradeItens) - When/Valid/
            *-- LostFocus do legado
            BINDEVENT(THIS.grd_4c_Itens.Column6.Text1, "GotFocus",  THIS, "ItemProduzirGotFocus")
            BINDEVENT(THIS.grd_4c_Itens.Column6.Text1, "KeyPress",  THIS, "ItemProduzirKeyPress")
            BINDEVENT(THIS.grd_4c_Itens.Column6.Text1, "LostFocus", THIS, "ItemProduzirLostFocus")

            *-- Demais colunas da grade principal - GotFocus redireciona para
            *-- a coluna Produzir (legado: "ThisForm.GradeItens.Column6.
            *-- Text1.SetFocus" nas Column1/3/4/5/7/8; Column2 e Column9 nao
            *-- tem esse redirecionamento no dump)
            BINDEVENT(THIS.grd_4c_Itens.Column1.Text1, "GotFocus", THIS, "ItemFocoColunaProduzir")
            BINDEVENT(THIS.grd_4c_Itens.Column3.Text1, "GotFocus", THIS, "ItemFocoColunaProduzir")
            BINDEVENT(THIS.grd_4c_Itens.Column4.Text1, "GotFocus", THIS, "ItemFocoColunaProduzir")
            BINDEVENT(THIS.grd_4c_Itens.Column5.Text1, "GotFocus", THIS, "ItemFocoColunaProduzir")
            BINDEVENT(THIS.grd_4c_Itens.Column7.Text1, "GotFocus", THIS, "ItemFocoColunaProduzir")
            BINDEVENT(THIS.grd_4c_Itens.Column8.Text1, "GotFocus", THIS, "ItemFocoColunaProduzir")

            *-- Coluna Utilizar dos dois paineis de estoque (Container2 =
            *-- Produto/Cor/Tam, Container5 = Grupo/Conta) - Valid do legado,
            *-- emulado por KeyPress (BINDEVENT "Valid" nao dispara de forma
            *-- confiavel em TextBox). Reatribuir o MESMO ColumnCount nos
            *-- Click dos botoes Disponivel/Estoques NAO derruba este
            *-- BINDEVENT - mesmo comportamento ja medido e documentado em
            *-- ConfigurarContainer4/BtnPedrasClick.
            BINDEVENT(THIS.cnt_4c_Container2.grd_4c_DispProduto.Column5.Text1, ;
                "KeyPress", THIS, "DispProdutoUtilizarKeyPress")
            BINDEVENT(THIS.cnt_4c_Container5.grd_4c_DispGrupo.Column5.Text1, ;
                "KeyPress", THIS, "DispGrupoUtilizarKeyPress")
            BINDEVENT(THIS.cnt_4c_Container5.grd_4c_DispGrupo.Column5.Text1, ;
                "LostFocus", THIS, "DispGrupoUtilizarLostFocus")
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro em ConfigurarEventos")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnDisponivelClick - botao "Disponiveis" (SIGPRGLP.Disponivel.Click).
    * Abre o Container2 com o estoque disponivel do item corrente em TODOS
    * os tamanhos (TmpSaldo filtrado por Produto+Cor), para o usuario
    * escolher de qual tamanho tirar a quantidade.
    *
    * Os Width/Header1.Caption sao reaplicados DEPOIS do RecordSource
    * porque eh isso que o legado faz - e os valores dele divergem de
    * proposito do SCX (Column1 = 80 e nao 108; Column3 = 24 e nao 38).
    *
    * "m." nos nomes das variaveis LOCAIS dentro do SELECT VFP local eh
    * obrigatorio: sem ele o VFP resolve o identificador como COLUNA.
    *
    * _TALLY eh capturado na linha seguinte ao SELECT - no legado ele eh
    * lido varias linhas adiante, o que so funciona por nao haver comando
    * de dados no meio.
    *--------------------------------------------------------------------------
    PROCEDURE BtnDisponivelClick()
        LOCAL loc_cCpro, loc_cCor, loc_nTally, loc_oErro

        TRY
            IF !USED("TmpFinal") OR EOF("TmpFinal") OR !USED("TmpSaldo")
                MsgAviso("Nenhum item selecionado na grade.", ;
                    "Aten" + CHR(231) + CHR(227) + "o")
            ELSE
                loc_cCpro = TmpFinal.Cpros
                loc_cCor  = TmpFinal.CodCors

                IF USED("TmpDisp")
                    THIS.cnt_4c_Container2.grd_4c_DispProduto.RecordSource = ""
                    USE IN TmpDisp
                ENDIF

                SELECT Cpros, CodCors, CodTams, Disps, 000000000.000 AS Utilizar ;
                  FROM TmpSaldo ;
                 WHERE Cpros   = m.loc_cCpro ;
                   AND CodCors = m.loc_cCor ;
                   AND Disps   > 0 ;
                 ORDER BY Cpros, CodCors, CodTams ;
                  INTO CURSOR TmpDisp READWRITE

                loc_nTally = _TALLY

                THIS.grd_4c_Itens.Enabled = .F.

                IF loc_nTally = 0
                    MsgAviso("N" + CHR(227) + "o Existe Estoque Dispon" + CHR(237) + ;
                        "vel Em Nenhum Tamanho!!!", "Aten" + CHR(231) + CHR(227) + "o")
                    THIS.BtnConfirmarDispProdutoClick()
                ELSE
                    WITH THIS.cnt_4c_Container2.grd_4c_DispProduto
                        .RecordSource = "TmpDisp"
                        .ColumnCount  = 5

                        .Column1.ControlSource = "TmpDisp.Cpros"
                        .Column2.ControlSource = "TmpDisp.CodCors"
                        .Column3.ControlSource = "TmpDisp.CodTams"
                        .Column4.ControlSource = "TmpDisp.Disps"
                        .Column5.ControlSource = "TmpDisp.Utilizar"

                        .Column1.Width = 80
                        .Column2.Width = 38
                        .Column3.Width = 24
                        .Column4.Width = 75
                        .Column5.Width = 75

                        .Column1.Header1.Caption = "Produto"
                        .Column2.Header1.Caption = "Cor"
                        .Column3.Header1.Caption = "Tam"
                        .Column4.Header1.Caption = "Disponivel"
                        .Column5.Header1.Caption = "Utilizar"
                    ENDWITH

                    THIS.cmd_4c_Processar.Enabled  = .F.
                    THIS.cmd_4c_Cancelar.Enabled   = .F.
                    THIS.cmd_4c_TotLinha.Enabled   = .F.
                    THIS.cmd_4c_Disponivel.Enabled = .F.
                    THIS.cnt_4c_Container3.Enabled = .F.
                    THIS.cnt_4c_Container2.Visible = .T.

                    THIS.cnt_4c_Container2.ZOrder(0)
                    THIS.cnt_4c_Container2.grd_4c_DispProduto.Refresh()
                    THIS.cnt_4c_Container2.grd_4c_DispProduto.Column5.SetFocus()
                    THIS.cnt_4c_Container2.grd_4c_DispProduto.Refresh()
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro em BtnDisponivelClick")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnSelEstoqueClick - botao "Estoques" (SIGPRGLP.SelEstoque.Click).
    * Abre o Container5 com o estoque disponivel do item corrente quebrado
    * por Prioridade/Grupo/Conta (TmpSaldG filtrado por Produto+Cor+Tam).
    *
    * O legado consulta para o cursor "Resultado" e reabre o DBF dele sob o
    * alias TmpDisp ("Use Dbf('Resultado') Alias TmpDisp Again") justamente
    * para obter um alias GRAVAVEL - a coluna Utilizar eh digitada pelo
    * usuario. Transcrito literalmente.
    *
    * Os Header/Width tambem divergem do SCX de proposito (Column3 = "Prior"
    * com 24px, contra "Prioridade" com 80px desenhado na tela).
    *--------------------------------------------------------------------------
    PROCEDURE BtnSelEstoqueClick()
        LOCAL loc_cCpro, loc_cCor, loc_cTam, loc_nTally, loc_oErro

        TRY
            IF !USED("TmpFinal") OR EOF("TmpFinal") OR !USED("TmpSaldG")
                MsgAviso("Nenhum item selecionado na grade.", ;
                    "Aten" + CHR(231) + CHR(227) + "o")
            ELSE
                loc_cCpro = TmpFinal.Cpros
                loc_cCor  = TmpFinal.CodCors
                loc_cTam  = TmpFinal.CodTams

                IF USED("TmpDisp")
                    THIS.cnt_4c_Container5.grd_4c_DispGrupo.RecordSource = ""
                    USE IN TmpDisp
                ENDIF

                SELECT Priors, Grupos, Estos, Cpros, CodCors, CodTams, Disps, ;
                       000000000.000 AS Utilizar ;
                  FROM TmpSaldG ;
                 WHERE Cpros   = m.loc_cCpro ;
                   AND CodCors = m.loc_cCor ;
                   AND CodTams = m.loc_cTam ;
                   AND Disps   > 0 ;
                  INTO CURSOR Resultado ;
                 ORDER BY 1, 2, 3, 4

                loc_nTally = _TALLY

                SELECT 0
                USE DBF("Resultado") ALIAS TmpDisp AGAIN
                USE IN Resultado

                THIS.grd_4c_Itens.Enabled = .F.

                IF loc_nTally = 0
                    MsgAviso("N" + CHR(227) + "o existe Estoque Dispon" + CHR(237) + ;
                        "vel !!!", "Aten" + CHR(231) + CHR(227) + "o")
                    THIS.BtnConfirmarDispGrupoClick()
                ELSE
                    WITH THIS.cnt_4c_Container5.grd_4c_DispGrupo
                        .RecordSource = "TmpDisp"
                        .ColumnCount  = 5

                        .Column1.ControlSource = "TmpDisp.Grupos"
                        .Column2.ControlSource = "TmpDisp.Estos"
                        .Column3.ControlSource = "TmpDisp.Priors"
                        .Column4.ControlSource = "TmpDisp.Disps"
                        .Column5.ControlSource = "TmpDisp.Utilizar"

                        .Column1.Width = 80
                        .Column2.Width = 80
                        .Column3.Width = 24
                        .Column4.Width = 75
                        .Column5.Width = 75

                        .Column1.Header1.Caption = "Grupo"
                        .Column2.Header1.Caption = "Conta"
                        .Column3.Header1.Caption = "Prior"
                        .Column4.Header1.Caption = "Disponivel"
                        .Column5.Header1.Caption = "Utilizar"
                    ENDWITH

                    *-- Bloco do legado com o "Estoques" INCLUSO (eh o unico
                    *-- painel que desabilita o proprio botao que o abriu)
                    THIS.HabilitarCampos(.F., .T.)
                    THIS.cnt_4c_Container5.Visible = .T.

                    WITH THIS.cnt_4c_Container5
                        .ZOrder(0)
                        .lbl_4c_Label1.Caption = "Estoque Dispon" + CHR(237) + "vel (" + ;
                            loc_cCpro + " " + loc_cCor + "/" + loc_cTam + ")"
                        .txt_4c_QtPedida.Value = TmpFinal.Saldo - TmpFinal.Estoque
                        .txt_4c_QtSelec.Value  = 0
                        .grd_4c_DispGrupo.Refresh()
                        .grd_4c_DispGrupo.Column5.SetFocus()
                        .grd_4c_DispGrupo.Refresh()
                        .Visible     = .T.
                    ENDWITH
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro em BtnSelEstoqueClick")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnTotLinhaClick - botao "Total/Linhas" (SIGPRGLP.TotLinha.Click).
    * Abre o Container1 com o resumo por linha de producao (soma de
    * Saldo/Estoque/Produzir agrupada por TmpFinal.Linhas) e uma linha
    * "TOTAIS" acrescentada por UNION ALL, destacada em azul e negrito
    * pelas expressoes Dynamic* - transcritas do legado.
    *
    * A coluna "Ordem" existe so para ordenar (Order By 2, 1) e deixar
    * "TOTAIS" por ultimo - nao eh exibida (o grid tem 4 colunas).
    *--------------------------------------------------------------------------
    PROCEDURE BtnTotLinhaClick()
        LOCAL loc_oErro

        TRY
            IF !USED("TmpFinal")
                MsgAviso("N" + CHR(227) + "o h" + CHR(225) + " itens para totalizar.", ;
                    "Aten" + CHR(231) + CHR(227) + "o")
            ELSE
                IF USED("TmpLinha")
                    THIS.cnt_4c_Container1.grd_4c_Linhas.RecordSource = ""
                ENDIF

                SELECT Linhas, 0 AS Ordem, SUM(Saldo) AS Saldo, ;
                       SUM(Estoque) AS Estoque, SUM(Produzir) AS Produzir ;
                  FROM TmpFinal ;
                 GROUP BY 1 ;
                 UNION ALL ;
                SELECT PADR("TOTAIS", 10) AS Linhas, 1 AS Ordem, SUM(Saldo) AS Saldo, ;
                       SUM(Estoque) AS Estoque, SUM(Produzir) AS Produzir ;
                  FROM TmpFinal ;
                 GROUP BY 1 ;
                  INTO CURSOR TmpLinha ;
                 ORDER BY 2, 1

                WITH THIS.cnt_4c_Container1.grd_4c_Linhas
                    .RecordSource = "TmpLinha"
                    .ColumnCount  = 4

                    .Column1.ControlSource = "TmpLinha.Linhas"
                    .Column2.ControlSource = "TmpLinha.Saldo"
                    .Column3.ControlSource = "TmpLinha.Estoque"
                    .Column4.ControlSource = "TmpLinha.Produzir"

                    .SetAll("DynamicFontBold",  "TmpLinha.Linhas = [TOTAIS]", "Column")
                    .SetAll("DynamicForeColor", ;
                        "IIF(TmpLinha.Linhas = [TOTAIS], RGB(0,0,255), RGB(0,0,0))", "Column")
                ENDWITH

                *-- "Estoques" FORA do bloco (o legado nao o toca aqui)
                THIS.HabilitarCampos(.F., .F.)
                THIS.cnt_4c_Container1.Visible = .T.

                THIS.cnt_4c_Container1.ZOrder(0)
                THIS.cnt_4c_Container1.grd_4c_Linhas.Refresh()
                THIS.cnt_4c_Container1.grd_4c_Linhas.Column1.SetFocus()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro em BtnTotLinhaClick")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnPedrasClick - botao "Requisicoes" (SIGPRGLP.Pedras.Click).
    * Abre o Container4 (Requisicao de Componentes Adicionais) ligando a
    * grade ao cursor SelPedra, que o form pai criou e cuja unica linha em
    * branco foi garantida por PrepararCursoresDeTrabalho().
    *
    * Os lookups de SigCdPro das colunas Produto/Produto substituto ja estao
    * ligados por BINDEVENT desde ConfigurarContainer4() - reatribuir o
    * MESMO ColumnCount nao os derruba (medido no VFP9 em 2026-09-29:
    * AEVENTS continua 1 e Width/Header1.Caption ficam intactos).
    *--------------------------------------------------------------------------
    PROCEDURE BtnPedrasClick()
        LOCAL loc_oErro

        TRY
            IF !USED("SelPedra")
                MsgAviso("Cursor de requisi" + CHR(231) + CHR(245) + "es n" + CHR(227) + ;
                    "o dispon" + CHR(237) + "vel.", "Aten" + CHR(231) + CHR(227) + "o")
            ELSE
                THIS.cnt_4c_Container4.grd_4c_Pedras.RecordSource = ""

                WITH THIS.cnt_4c_Container4.grd_4c_Pedras
                    .RecordSource = "SelPedra"
                    .ColumnCount  = 5

                    .Column1.ControlSource = "SelPedra.Cpros"
                    .Column2.ControlSource = "SelPedra.Dpros"
                    .Column3.ControlSource = "SelPedra.Cunis"
                    .Column4.ControlSource = "SelPedra.Qtds"
                    .Column5.ControlSource = "SelPedra.Cpro2s"
                ENDWITH

                *-- "Estoques" FORA do bloco (o legado nao o toca aqui)
                THIS.HabilitarCampos(.F., .F.)
                THIS.cnt_4c_Container4.Visible = .T.

                THIS.cnt_4c_Container4.ZOrder(0)
                THIS.cnt_4c_Container4.grd_4c_Pedras.Refresh()
                THIS.cnt_4c_Container4.grd_4c_Pedras.Column1.SetFocus()

                *-- Reaplica o gate do When legado (Qtde e Produto substituto
                *-- so liberam com o Produto preenchido) na linha em que o
                *-- grid acabou de pousar
                THIS.AjustarColunasPedra()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro em BtnPedrasClick")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnRelatorioClick - botao "Relatorio" (SIGPRGLP.btnRelatorio.Click).
    * Monta o cursor crImpressao a partir de TmpFinal, completa a descricao
    * de cada produto consultando SigCdPro e manda para o SigReGlp.frx.
    *
    * O legado usa IsEmpty(TmpFinal.Obsps) na coluna ObsPs; aqui vai
    * ISNULL(...) OR EMPTY(...) - mesma semantica do IsEmpty do Fortyus
    * (que trata NULL como vazio), sem depender da resolucao do wrapper
    * pelo PATH. Mesma forma ja usada no Column8 da grade principal.
    *
    * A descricao eh buscada produto a produto, como no legado ("Select
    * Distinct Cpros ... Scan ... SqlExecute"): a consulta unica por IN
    * seria mais rapida, mas mudaria a forma do acesso ao banco sem que o
    * legado peca isso.
    *--------------------------------------------------------------------------
    PROCEDURE BtnRelatorioClick()
        LOCAL loc_cSQL, loc_nResultado, loc_lProsseguir, loc_oErro

        TRY
            loc_lProsseguir = .T.

            IF !USED("TmpFinal")
                MsgAviso("N" + CHR(227) + "o Existem Dados Para Impress" + CHR(227) + ;
                    "o do Relat" + CHR(243) + "rio!!!", "Aten" + CHR(231) + CHR(227) + "o")
                loc_lProsseguir = .F.
            ENDIF

            IF loc_lProsseguir
                SELECT Cpros, SPACE(50) AS DPros, CodCors, CodTams, Dopes, Numes, ;
                       Saldo, Estoque, Produzir, ;
                       IIF(ISNULL(TmpFinal.Obsps) OR EMPTY(TmpFinal.Obsps), " ", "*") AS ObsPs ;
                  FROM TmpFinal ;
                 ORDER BY Cpros, CodCors, CodTams, Dopes, Numes ;
                  INTO CURSOR crImpressao READWRITE

                GO TOP IN crImpressao

                IF EOF("crImpressao")
                    MsgAviso("N" + CHR(227) + "o Existem Dados Para Impress" + CHR(227) + ;
                        "o do Relat" + CHR(243) + "rio!!!", ;
                        "Aten" + CHR(231) + CHR(227) + "o")
                    loc_lProsseguir = .F.
                ENDIF
            ENDIF

            *-- Sem conexao o relatorio sairia com a coluna Descricao em
            *-- branco, sem nenhum aviso - o legado nem chega a testar isso
            IF loc_lProsseguir AND !(TYPE("gnConnHandle") = "N" AND gnConnHandle > 0)
                MsgErro("Sem conex" + CHR(227) + "o com o banco de dados - n" + CHR(227) + ;
                    "o " + CHR(233) + " poss" + CHR(237) + "vel obter a descri" + CHR(231) + ;
                    CHR(227) + "o dos produtos.", "Falha na Conex" + CHR(227) + "o")
                loc_lProsseguir = .F.
            ENDIF

            IF loc_lProsseguir
                SELECT DISTINCT Cpros FROM crImpressao INTO CURSOR LocalProds

                SELECT LocalProds
                SCAN
                    loc_cSQL = "SELECT CPros, DPros" + ;
                               "  FROM SigCdPro" + ;
                               " WHERE CPros = " + EscaparSQL(LocalProds.CPros)

                    loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "LocalBus")

                    IF loc_nResultado < 0
                        MsgErro("Favor Reinicializar o Processo!!!" + CHR(13) + ;
                            CapturarErroSQL(), ;
                            "Falha na Conex" + CHR(227) + "o (LocalBus)")
                        loc_lProsseguir = .F.
                        EXIT
                    ENDIF

                    SELECT LocalBus
                    GO TOP IN LocalBus
                    IF !EOF("LocalBus")
                        UPDATE crImpressao SET DPros = LocalBus.DPros ;
                         WHERE CPros = LocalBus.CPros
                    ENDIF

                    SELECT LocalProds
                ENDSCAN

                IF USED("LocalBus")
                    USE IN LocalBus
                ENDIF
                IF USED("LocalProds")
                    USE IN LocalProds
                ENDIF
            ENDIF

            IF loc_lProsseguir
                SELECT crImpressao
                GO TOP IN crImpressao
                THIS.ExecutarReportForm("SigReGlp", "PREVIEW", "crImpressao")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro em BtnRelatorioClick")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnSairClick - botao "Sair" (SIGPRGLP.Cancelar.Click). Nomeado pela
    * ACAO (encerrar a tela), nao pelo objeto legado "Cancelar" - o
    * TesteAutomatico.prg exige um dos tres nomes canonicos de encerramento
    * (BtnEncerrarClick/BtnFecharClick/BtnSairClick).
    * Descarta a transacao em aberto e fecha a tela SEM efetivar nada.
    *
    * "ThisForm.poDataMgr.RollBack()" do legado vira SQLROLLBACK no handle
    * global: a conexao deste ambiente nasce com Transactions = 2 (manual),
    * entao o que o Processar tiver gravado e ainda nao confirmado precisa
    * ser revertido explicitamente aqui.
    *
    * O Release() fica FORA do TRY: liberar o form de dentro do bloco
    * derrubaria a propria pilha de execucao dentro dele (regra #1).
    *--------------------------------------------------------------------------
    PROCEDURE BtnSairClick()
        LOCAL loc_lFechar, loc_oErro
        loc_lFechar = .F.

        TRY
            IF TYPE("gnConnHandle") = "N" AND gnConnHandle > 0
                SQLROLLBACK(gnConnHandle)
            ENDIF

            IF VARTYPE(THIS.this_oParentForm) = "O"
                THIS.this_oParentForm.Enabled = .T.
            ENDIF

            loc_lFechar = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro em BtnSairClick")
        ENDTRY

        IF loc_lFechar
            THIS.Release()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnConfirmarDispProdutoClick - botao OK do Container2
    * (SIGPRGLP.Container2.CancelaDisp.Click). Apesar do nome legado, ele
    * CONFIRMA a escolha: para cada tamanho com Utilizar > 0 ele QUEBRA a
    * linha corrente de TmpFinal em duas - uma com o tamanho escolhido e a
    * quantidade retirada do estoque (Produzir = 0), e o restante segue na
    * linha original - e propaga a baixa em TmpSaldo/TmpSaldG e no item da
    * O.P. (SigMvIts) que ainda estava sem tamanho definido.
    *
    * Substituicoes de sintaxe (mesma semantica, forma valida em VFP9):
    *   "=Afiel(Tfinal)"  -> AFIELDS() com LOCAL ARRAY (a funcao EXIGE
    *       array declarado; LOCAL simples estoura em runtime)
    *   "Scatter To Memvar / Append From Array Memvar" -> SCATTER MEMVAR
    *       MEMO + APPEND BLANK + GATHER MEMVAR MEMO (copia do registro
    *       inteiro; o MEMO preserva a observacao do item na linha
    *       desmembrada, que continua sendo o MESMO item)
    *   "?pQtd / ?pAqt / ?pIds" -> EscaparSQL/FormatarNumeroSQL conforme o
    *       TIPO de cada coluna em SigMvIts (qtds/aqtds numeric(9,3),
    *       codtams char(4), cidchaves char(20))
    *
    * EmpDopNums eh chave POSICIONAL char(29) = Emps char(3) + Dopes
    * char(20) + Str(Numes, 6): o padding FAZ PARTE da chave, por isso
    * PADR explicito e NUNCA ALLTRIM nas partes (regra #42).
    *--------------------------------------------------------------------------
    PROCEDURE BtnConfirmarDispProdutoClick()
        LOCAL loc_nRegFinal, loc_nQtdUti, loc_nQtUtil, loc_nBaixa
        LOCAL loc_cEdn, loc_cSQL, loc_nResultado, loc_lProsseguir
        LOCAL loc_nQtd, loc_nAQtd, loc_cIds, loc_cExactOrig, loc_oErro
        LOCAL ARRAY loc_aTFinal[1]

        TRY
            loc_lProsseguir = .T.

            IF USED("TmpFinal") AND USED("TmpDisp")
                SELECT TmpFinal
                loc_nRegFinal = RECNO()

                SELECT TmpDisp
                loc_nQtdUti = 0
                SUM Utilizar TO loc_nQtdUti

                *-- Sem conexao nao da para acertar o item da O.P. em
                *-- SigMvIts, e o legado so descobre isso NO MEIO do laco -
                *-- quando TmpFinal/TmpSaldo/TmpSaldG ja foram alterados e o
                *-- "Return 0" deixa a divisao pela metade. Conferir ANTES de
                *-- mexer em qualquer cursor evita esse estado parcial.
                IF loc_nQtdUti > 0 AND !(TYPE("gnConnHandle") = "N" AND gnConnHandle > 0)
                    MsgErro("Sem conex" + CHR(227) + "o com o banco de dados - n" + CHR(227) + ;
                        "o " + CHR(233) + " poss" + CHR(237) + "vel confirmar a sele" + ;
                        CHR(231) + CHR(227) + "o de estoque.", ;
                        "Falha na Conex" + CHR(227) + "o")
                    loc_lProsseguir = .F.
                ENDIF

                IF loc_lProsseguir AND loc_nQtdUti > 0
                    SELECT TmpFinal
                    =AFIELDS(loc_aTFinal)
                    CREATE CURSOR Temporario FROM ARRAY loc_aTFinal

                    SELECT TmpDisp
                    SCAN
                        IF TmpDisp.Utilizar = 0
                            LOOP
                        ENDIF

                        loc_nQtUtil = TmpDisp.Utilizar

                        =SEEK(TmpDisp.CPros + TmpDisp.CodCors + TmpDisp.CodTams, "TmpSaldo")

                        *-- Desmembra a linha corrente de TmpFinal: o tamanho
                        *-- escolhido vira uma linha nova ja coberta por
                        *-- estoque, e o restante fica na linha original
                        SELECT TmpFinal
                        SCATTER MEMVAR MEMO

                        SELECT Temporario
                        APPEND BLANK
                        GATHER MEMVAR MEMO
                        REPLACE Saldo    WITH loc_nQtUtil, ;
                                CodTams  WITH TmpDisp.CodTams, ;
                                Estoque  WITH loc_nQtUtil, ;
                                Produzir WITH 0 IN Temporario

                        REPLACE Saldo    WITH TmpFinal.Saldo    - loc_nQtUtil IN TmpFinal
                        REPLACE Produzir WITH TmpFinal.Produzir - loc_nQtUtil IN TmpFinal
                        REPLACE Disps    WITH TmpSaldo.Disps    - loc_nQtUtil IN TmpSaldo

                        *-- Redistribui a baixa entre as contas de TmpSaldG,
                        *-- da primeira com saldo em diante.
                        *--
                        *-- Os dois SEEK abaixo usam chave PARCIAL (22 dos 44
                        *-- caracteres do indice composto de TmpSaldG) e por
                        *-- isso exigem SET EXACT OFF: com o SET EXACT ON do
                        *-- config.prg eles devolvem .F. e, como o retorno eh
                        *-- descartado, o REPLACE seguinte cairia em EOF - que
                        *-- em VFP9 NAO da erro (medido em 2026-09-29). A
                        *-- redistribuicao inteira sumiria em silencio.
                        loc_nBaixa = TmpSaldo.Saldo - TmpSaldo.Disps

                        loc_cExactOrig = SET("EXACT")
                        SET EXACT OFF

                        SELECT TmpSaldG
                        SET ORDER TO Cpros
                        =SEEK(TmpSaldo.Cpros + TmpSaldo.CodCors + TmpSaldo.CodTams)
                        REPLACE Disps WITH Saldo ;
                          WHILE Cpros   = TmpSaldo.Cpros ;
                            AND CodCors = TmpSaldo.CodCors ;
                            AND CodTams = TmpSaldo.CodTams

                        =SEEK(TmpSaldo.Cpros + TmpSaldo.CodCors + TmpSaldo.CodTams)
                        SCAN WHILE Cpros   = TmpSaldo.Cpros ;
                               AND CodCors = TmpSaldo.CodCors ;
                               AND CodTams = TmpSaldo.CodTams ;
                               AND loc_nBaixa > 0
                            IF TmpSaldG.Disps >= loc_nBaixa
                                REPLACE TmpSaldG.Disps WITH TmpSaldG.Disps - loc_nBaixa
                                loc_nBaixa = 0
                            ELSE
                                loc_nBaixa = loc_nBaixa - TmpSaldG.Disps
                                REPLACE TmpSaldG.Disps WITH 0
                            ENDIF
                        ENDSCAN

                        SET EXACT &loc_cExactOrig

                        *-- Acerta o item da O.P. que ainda estava sem tamanho
                        loc_cEdn = PADR(TmpFinal.Emps, 3) + PADR(TmpFinal.Dopes, 20) + ;
                                   STR(TmpFinal.Numes, 6)

                        loc_cSQL = "SELECT *" + ;
                                   "  FROM SigMvIts" + ;
                                   " WHERE empdopnums = " + EscaparSQL(loc_cEdn) + ;
                                   "   AND cpros = " + EscaparSQL(TmpFinal.Cpros)

                        loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "TempEsti2")

                        IF loc_nResultado < 0
                            MsgErro("Favor Reinicializar o Processo!!!" + CHR(13) + ;
                                CapturarErroSQL(), ;
                                "Falha na Conex" + CHR(227) + "o (TempEsti2 - 3)")
                            loc_lProsseguir = .F.
                            EXIT
                        ENDIF

                        SELECT TempEsti2
                        SCAN
                            IF TempEsti2.Citens <> TmpFinal.Citens
                                LOOP
                            ENDIF

                            IF TempEsti2.CodCors = TmpFinal.CodCors ;
                                    AND TempEsti2.CodTams = SPACE(4)

                                SCATTER MEMVAR

                                loc_nQtd  = loc_nQtUtil
                                loc_nAQtd = TempEsti2.Qtds
                                loc_cIds  = TempEsti2.cIdChaves

                                loc_cSQL = "UPDATE SigMvIts" + ;
                                           "   SET codtams = " + EscaparSQL(LEFT(TmpDisp.CodTams, 4)) + ;
                                           "     , qtds    = " + FormatarNumeroSQL(loc_nQtd,  3) + ;
                                           "     , aqtds   = " + FormatarNumeroSQL(loc_nAQtd, 3) + ;
                                           " WHERE cidchaves = " + EscaparSQL(loc_cIds)

                                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

                                IF loc_nResultado < 0
                                    MsgErro("Favor Reinicializar o Processo!!!" + CHR(13) + ;
                                        CapturarErroSQL(), ;
                                        "Falha na Conex" + CHR(227) + "o (Update - 9)")
                                    loc_lProsseguir = .F.
                                    EXIT
                                ENDIF

                                *-- Sobra do item original entra no cursor de
                                *-- itens que o Processar grava depois
                                IF USED("crSigMvIts")
                                    SELECT crSigMvIts
                                    APPEND BLANK
                                    GATHER MEMVAR
                                    REPLACE Qtds      WITH Qtds - loc_nQtUtil
                                    REPLACE AQtds     WITH Qtds
                                    REPLACE cIdChaves WITH fUniqueIds()
                                    IF crSigMvIts.Qtds = 0
                                        DELETE
                                    ENDIF
                                ENDIF

                                SELECT TempEsti2
                                EXIT
                            ENDIF
                        ENDSCAN

                        IF !loc_lProsseguir
                            EXIT
                        ENDIF

                        SELECT TmpDisp
                    ENDSCAN

                    IF loc_lProsseguir
                        SELECT TmpFinal
                        IF TmpFinal.Saldo = 0
                            DELETE
                        ENDIF
                        SELECT TmpFinal
                        APPEND FROM DBF("Temporario")
                        GO loc_nRegFinal

                        =SEEK(TmpFinal.CPros + TmpFinal.CodCors + TmpFinal.CodTams, "TmpSaldo")
                    ENDIF

                    IF USED("Temporario")
                        USE IN Temporario
                    ENDIF
                    IF USED("TempEsti2")
                        USE IN TempEsti2
                    ENDIF
                ENDIF
            ENDIF

            THIS.RestaurarGradePrincipal(THIS.cnt_4c_Container2, .F.)
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, ;
                "Erro em BtnConfirmarDispProdutoClick")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnConfirmarDispGrupoClick - botao OK do Container5
    * (SIGPRGLP.Container5.CancelaDisp.Click). Confirma de QUAIS contas sai
    * a quantidade: para cada linha com Utilizar > 0, abate o total a
    * produzir do item, baixa TmpSaldo e a conta correspondente em TmpSaldG
    * (chave Produto+Cor+Tam+Prioridade+Grupo+Conta) e marca o produto em
    * TmpSaldU.KeySelm, que sinaliza "estoque escolhido manualmente" para o
    * restante do processamento.
    *
    * A chave do SEEK em TmpSaldG eh POSICIONAL - Str(Priors, 2) entre o
    * tamanho e o grupo - e por isso nenhuma parte leva ALLTRIM (regra #42).
    *--------------------------------------------------------------------------
    PROCEDURE BtnConfirmarDispGrupoClick()
        LOCAL loc_nRegFinal, loc_nQtdUti, loc_nQtUtil, loc_oErro

        TRY
            IF USED("TmpFinal") AND USED("TmpDisp")
                SELECT TmpFinal
                loc_nRegFinal = RECNO()

                SELECT TmpDisp
                loc_nQtdUti = 0
                SUM Utilizar TO loc_nQtdUti

                IF loc_nQtdUti > 0
                    SELECT TmpDisp
                    SCAN
                        IF TmpDisp.Utilizar = 0
                            LOOP
                        ENDIF

                        loc_nQtUtil = TmpDisp.Utilizar

                        =SEEK(TmpDisp.CPros + TmpDisp.CodCors + TmpDisp.CodTams, "TmpSaldo")

                        SELECT TmpFinal
                        REPLACE Produzir WITH Produzir - loc_nQtUtil IN TmpFinal
                        REPLACE Estoque  WITH TmpFinal.Saldo - TmpFinal.Produzir IN TmpFinal

                        SELECT TmpSaldo
                        REPLACE TmpSaldo.Disps WITH TmpSaldo.Disps - loc_nQtUtil

                        IF USED("TmpSaldU")
                            IF !SEEK(TmpFinal.Cpros, "TmpSaldU", "Cpros")
                                INSERT INTO TmpSaldU (Cpros) VALUES (TmpFinal.Cpros)
                            ENDIF
                            REPLACE KeySelm WITH .T. IN TmpSaldU
                        ENDIF

                        SELECT TmpSaldG
                        SET ORDER TO Cpros
                        =SEEK(TmpSaldo.Cpros + TmpSaldo.CodCors + TmpSaldo.CodTams + ;
                              STR(TmpDisp.Priors, 2) + TmpDisp.Grupos + TmpDisp.Estos)
                        REPLACE TmpSaldG.Disps WITH TmpSaldG.Disps - loc_nQtUtil

                        SELECT TmpDisp
                    ENDSCAN

                    =SEEK(TmpFinal.CPros + TmpFinal.CodCors + TmpFinal.CodTams, "TmpSaldo")
                ENDIF
            ENDIF

            THIS.RestaurarGradePrincipal(THIS.cnt_4c_Container5, .T.)
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, ;
                "Erro em BtnConfirmarDispGrupoClick")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnFecharPedrasClick - botao "Sair" do Container4
    * (SIGPRGLP.Container4.CancelaDisp.Click). Aqui o nome legado eh
    * literal: nao ha nada a confirmar, o que foi digitado ja esta no
    * cursor SelPedra e sera lido pelo Processar.
    *--------------------------------------------------------------------------
    PROCEDURE BtnFecharPedrasClick()
        THIS.RestaurarGradePrincipal(THIS.cnt_4c_Container4, .F.)
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnFecharLinhasClick - botao "OK" do Container1
    * (SIGPRGLP.Container1.CancelaLin.Click). O painel de totais por linha
    * eh somente-leitura: fechar eh a unica acao.
    *--------------------------------------------------------------------------
    PROCEDURE BtnFecharLinhasClick()
        THIS.RestaurarGradePrincipal(THIS.cnt_4c_Container1, .F.)
    ENDPROC

    *--------------------------------------------------------------------------
    * RestaurarGradePrincipal - Bloco "With ThisForm ... EndWith" que
    * encerra os QUATRO handlers de fechamento de painel no legado
    * (Container1.CancelaLin e Container2/4/5.CancelaDisp): reabilita os
    * botoes de acao, esconde o painel, devolve o foco a coluna Produzir da
    * grade principal e traz a grade para frente.
    *
    * A UNICA diferenca entre os quatro no legado eh o SelEstoque: so o
    * Container5 o reabilita, porque so o BtnSelEstoqueClick o desabilita.
    * Dai o parametro par_lReabilitarSelEstoque.
    *
    * NOTA DE FIDELIDADE: o legado reabilita cmd_4c_Pedras
    * INCONDICIONALMENTE aqui, mesmo quando o Init o havia desabilitado por
    * falta das colunas de transferencia em SigCdPam. O comportamento eh
    * transcrito como esta - abrir o painel de Requisicoes nao depende
    * desses parametros (quem depende deles eh o Processar).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE RestaurarGradePrincipal(par_oContainer, par_lReabilitarSelEstoque)
        LOCAL loc_oErro

        TRY
            *-- Bloco "With ThisForm / .Processar.Enabled = .t. / ... /
            *-- EndWith" que o legado repete no fechamento de cada painel
            THIS.HabilitarCampos(.T., par_lReabilitarSelEstoque)

            IF VARTYPE(par_oContainer) = "O"
                par_oContainer.Visible = .F.
            ENDIF

            THIS.grd_4c_Itens.Enabled = .T.
            THIS.grd_4c_Itens.ZOrder(0)
            THIS.grd_4c_Itens.Refresh()
            THIS.grd_4c_Itens.Column6.SetFocus()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro em RestaurarGradePrincipal")
        ENDTRY
    ENDPROC

    *==========================================================================
    * GRADE PRINCIPAL (grd_4c_Itens) - troca de linha/coluna e coluna
    * "Produzir" (Column6, fisica e por .Name - ver fix em ConfigurarGradeItens)
    *==========================================================================

    *--------------------------------------------------------------------------
    * GradeItensAfterRowColChange - Transcricao de SIGPRGLP.GradeItens.
    * AfterRowColChange. A cada troca de linha/coluna da grade principal:
    * atualiza a observacao do item (memo TmpFinal.Obsps, ligado direto por
    * ControlSource em PrepararCursoresDeTrabalho), refaz a faixa/bind do
    * Container3 (Estoque Disponivel por Conta) para o item corrente e
    * recarrega a foto do produto (SigCdPro.FigJpgs, base64).
    *
    * "ThisForm.poDataMgr.CursorQuery" do legado (helper do Fortyus que nao
    * foi portado) vira SQLEXEC direto em cursor descartavel.
    *--------------------------------------------------------------------------
    PROCEDURE GradeItensAfterRowColChange(par_nColIndex)
        LOCAL loc_cArquivo, loc_cFoto, loc_oErro

        TRY
            IF USED("TmpFinal") AND !EOF("TmpFinal")
                THIS.obj_4c_ObsItens.Refresh()
                THIS.lbl_4c_TxtObsItens.Caption = "Observa" + CHR(231) + CHR(227) + "o do Item " + ;
                    ALLTRIM(TmpFinal.Cpros)

                IF USED("TmpSaldo")
                    =SEEK(TmpFinal.Cpros + TmpFinal.CodCors + TmpFinal.CodTams, "TmpSaldo")
                ENDIF

                *-- "Select TmpSaldG / Set Order To Cpros / Set Key To ... /
                *-- Go Top" do legado - a faixa via SET KEY parcial nao
                *-- funciona sob o SET EXACT ON deste projeto (ver comentario
                *-- de AplicarFaixaSaldoContas); reusa o mesmo metodo que ja
                *-- resolve isso com SET FILTER congelado
                THIS.AplicarFaixaSaldoContas()

                WITH THIS.cnt_4c_Container3
                    IF USED("TmpSaldo") AND !EOF("TmpSaldo")
                        .txt_4c_TotQtd.Value = TmpSaldo.Saldo
                        .txt_4c_TotEst.Value = TmpSaldo.Saldo - TmpSaldo.Disps
                        .txt_4c_TotPrz.Value = TmpSaldo.Disps
                    ENDIF

                    .lbl_4c_Label1.Caption = ALLTRIM(TmpFinal.Cpros) + ;
                        IIF(!EMPTY(TmpFinal.CodCors), "Cor:" + ALLTRIM(TmpFinal.CodCors), "") + ;
                        IIF(!EMPTY(TmpFinal.CodTams), " Tam:" + ALLTRIM(TmpFinal.CodTams), "")

                    .txt_4c_GetDGrupo.Value = ""
                    .txt_4c_GetDConta.Value = ""

                    IF USED("TmpSaldG") AND !EOF("TmpSaldG")
                        IF USED("TmpConta")
                            USE IN TmpConta
                        ENDIF
                        IF USED("TmpGrupo")
                            USE IN TmpGrupo
                        ENDIF

                        IF TYPE("gnConnHandle") = "N" AND gnConnHandle > 0
                            SQLEXEC(gnConnHandle, ;
                                "SELECT Rclis FROM SigCdCli WHERE Iclis = " + ;
                                EscaparSQL(ALLTRIM(TmpSaldG.Estos)), "TmpConta")
                            SQLEXEC(gnConnHandle, ;
                                "SELECT Descrs FROM SigCdGcr WHERE Codigos = " + ;
                                EscaparSQL(ALLTRIM(TmpSaldG.Grupos)), "TmpGrupo")
                        ENDIF

                        IF USED("TmpGrupo") AND !EOF("TmpGrupo")
                            .txt_4c_GetDGrupo.Value = ALLTRIM(TratarNulo(TmpGrupo.Descrs, ""))
                        ENDIF
                        IF USED("TmpConta") AND !EOF("TmpConta")
                            .txt_4c_GetDConta.Value = ALLTRIM(TratarNulo(TmpConta.Rclis, ""))
                        ENDIF

                        IF USED("TmpConta")
                            USE IN TmpConta
                        ENDIF
                        IF USED("TmpGrupo")
                            USE IN TmpGrupo
                        ENDIF
                    ENDIF

                    .grd_4c_DispConta.Refresh()
                ENDWITH

                *-- Foto do item (Clear Resources + StrToFile do legado)
                IF USED("crSigCdPro_4c_Foto")
                    USE IN crSigCdPro_4c_Foto
                ENDIF
                IF TYPE("gnConnHandle") = "N" AND gnConnHandle > 0
                    SQLEXEC(gnConnHandle, ;
                        "SELECT FigJpgs FROM SigCdPro WHERE Cpros = " + ;
                        EscaparSQL(ALLTRIM(TmpFinal.Cpros)), "crSigCdPro_4c_Foto")
                ENDIF

                loc_cArquivo = ADDBS(SYS(2023)) + "TempGlb.jpg"

                CLEAR RESOURCES
                THIS.img_4c_ImgFigJpg.Picture = ""
                THIS.img_4c_ImgFigJpg.Visible = .F.

                IF USED("crSigCdPro_4c_Foto") AND !EOF("crSigCdPro_4c_Foto") AND ;
                        !ISNULL(crSigCdPro_4c_Foto.FigJpgs) AND !EMPTY(crSigCdPro_4c_Foto.FigJpgs)
                    loc_cFoto = STRCONV(STRTRAN(STRTRAN(STRTRAN(crSigCdPro_4c_Foto.FigJpgs, ;
                        "data:image/png;base64,", ""), "data:image/jpeg;base64,", ""), ;
                        "data:image/jpg;base64,", ""), 14)

                    IF STRTOFILE(loc_cFoto, loc_cArquivo) > 0
                        THIS.img_4c_ImgFigJpg.Picture = loc_cArquivo
                        THIS.img_4c_ImgFigJpg.Visible = .T.
                    ENDIF
                ENDIF

                IF USED("crSigCdPro_4c_Foto")
                    USE IN crSigCdPro_4c_Foto
                ENDIF

                SELECT TmpFinal
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro em GradeItensAfterRowColChange")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * ItemFocoColunaProduzir - GotFocus das demais colunas da grade principal
    * (Column1/3/4/5/7/8 - legado: "ThisForm.GradeItens.Column6.Text1.
    * SetFocus"). Column2 e Column9 nao tem esse redirecionamento no dump.
    *--------------------------------------------------------------------------
    PROCEDURE ItemFocoColunaProduzir()
        THIS.grd_4c_Itens.Column6.SetFocus()
    ENDPROC

    *--------------------------------------------------------------------------
    * ItemProduzirGotFocus - When da Column6.Text1 do GradeItens (coluna
    * Produzir). Guarda o valor anterior (ThisForm.OldValue do legado) e, em
    * modo Reserva Automatica com o item ainda sem estoque baixado, libera o
    * botao Disponiveis quando o grupo do produto tem TipoEstos 3 ou 4.
    *--------------------------------------------------------------------------
    PROCEDURE ItemProduzirGotFocus()
        LOCAL loc_oErro

        TRY
            IF USED("TmpFinal") AND !EOF("TmpFinal")
                THIS.this_nProduzirValorAnterior = THIS.grd_4c_Itens.Column6.Text1.Value

                IF THIS.this_oBusinessObject.this_lReserva AND TmpFinal.Estoque = 0
                    IF USED("TempPro")
                        USE IN TempPro
                    ENDIF
                    IF USED("TempGru")
                        USE IN TempGru
                    ENDIF

                    IF TYPE("gnConnHandle") = "N" AND gnConnHandle > 0
                        SQLEXEC(gnConnHandle, ;
                            "SELECT CGrus FROM SigCdPro WHERE Cpros = " + ;
                            EscaparSQL(ALLTRIM(TmpFinal.Cpros)), "TempPro")

                        IF USED("TempPro") AND !EOF("TempPro")
                            SQLEXEC(gnConnHandle, ;
                                "SELECT TipoEstos FROM SigCdGrp WHERE CGrus = " + ;
                                EscaparSQL(ALLTRIM(TempPro.CGrus)), "TempGru")

                            IF USED("TempGru") AND !EOF("TempGru") AND ;
                                    INLIST(TempGru.TipoEstos, 3, 4)
                                THIS.cmd_4c_Disponivel.Enabled = .T.
                            ENDIF
                        ENDIF
                    ENDIF

                    IF USED("TempGru")
                        USE IN TempGru
                    ENDIF
                    IF USED("TempPro")
                        USE IN TempPro
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro em ItemProduzirGotFocus")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * ItemProduzirKeyPress - Gatilho do Valid da Column6.Text1 (coluna
    * Produzir), emulado por ENTER(13)/TAB(9) - BINDEVENT "Valid" nao
    * dispara de forma confiavel em TextBox (CLAUDE.md).
    *--------------------------------------------------------------------------
    PROCEDURE ItemProduzirKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 13 OR par_nKeyCode = 9
            THIS.ValidarItemProduzir()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarItemProduzir - Transcricao de SIGPRGLP.GradeItens.Column6.Text1.
    * Valid. Impede quantidade negativa ou maior que o saldo do item, confirma
    * com o usuario a perda de selecao manual de estoque (TmpSaldU.KeySelm) e,
    * aceitando a nova quantidade, redistribui a baixa de estoque entre
    * TmpSaldo/TmpSaldG.
    *
    * Os dois SEEK sobre TmpSaldG usam chave PARCIAL (Cpros+CodCors+CodTams,
    * sem a Prioridade/Grupo/Conta que completam o indice composto) - por
    * isso o bloco roda sob SET EXACT OFF, restaurado logo em seguida (mesma
    * tecnica ja usada em BtnConfirmarDispProdutoClick).
    *--------------------------------------------------------------------------
    PROCEDURE ValidarItemProduzir()
        LOCAL loc_oTxt, loc_nBaixa, loc_cExactOrig, loc_lConfirma, loc_oErro

        TRY
            IF !USED("TmpFinal") OR !USED("TmpSaldo") OR !USED("TmpSaldG") OR EOF("TmpFinal")
                RETURN
            ENDIF

            loc_oTxt = THIS.grd_4c_Itens.Column6.Text1

            IF !USED("TmpSaldU")
                CREATE CURSOR TmpSaldU (Cpros C(14), KeySelm L)
                INDEX ON Cpros TAG Cpros
            ENDIF

            IF !SEEK(TmpFinal.Cpros, "TmpSaldU", "Cpros")
                INSERT INTO TmpSaldU (Cpros) VALUES (TmpFinal.Cpros)
            ENDIF

            IF loc_oTxt.Value <> THIS.this_nProduzirValorAnterior AND TmpSaldU.KeySelm
                loc_lConfirma = MsgConfirma("Produto com Sele" + CHR(231) + CHR(227) + "o Manual de estoque." + ;
                    CHR(13) + "O sistema ir" + CHR(225) + " acionar o modo autom" + CHR(225) + "tico. " + ;
                    "Deseja Continuar?", "Aten" + CHR(231) + CHR(227) + "o")
                IF !loc_lConfirma
                    loc_oTxt.Value = THIS.this_nProduzirValorAnterior
                    loc_oTxt.Refresh()
                    RETURN
                ENDIF
            ENDIF

            DO CASE
                CASE loc_oTxt.Value = THIS.this_nProduzirValorAnterior
                    * nada a fazer - mesmo valor

                CASE loc_oTxt.Value < 0
                    MsgAviso("A Quantidade a Produzir N" + CHR(227) + "o Pode Ser Um Valor Negativo!!!", ;
                        "Aten" + CHR(231) + CHR(227) + "o")
                    loc_oTxt.Value = THIS.this_nProduzirValorAnterior

                CASE loc_oTxt.Value > TmpFinal.Saldo
                    MsgAviso("A Quantidade a Produzir N" + CHR(227) + "o Pode Ser Maior Que a Quantidade Da " + ;
                        "Opera" + CHR(231) + CHR(227) + "o!!!", "Aten" + CHR(231) + CHR(227) + "o")
                    loc_oTxt.Value = TmpFinal.Saldo - TmpFinal.Estoque

                CASE !SEEK(TmpFinal.Cpros + TmpFinal.CodCors + TmpFinal.CodTams, "TmpSaldo") ;
                        AND TmpFinal.Produzir <> TmpFinal.Saldo
                    MsgAviso("N" + CHR(227) + "o H" + CHR(225) + " Saldo Dispon" + CHR(237) + ;
                        "vel Deste Produto No Estoque Para Reservar!!!", "Aten" + CHR(231) + CHR(227) + "o")
                    loc_oTxt.Value = TmpFinal.Saldo

                OTHERWISE
                    IF TmpSaldo.Disps + TmpFinal.Estoque >= TmpFinal.Saldo - loc_oTxt.Value
                        REPLACE TmpSaldo.Disps WITH ;
                            TmpSaldo.Disps + TmpFinal.Estoque - (TmpFinal.Saldo - TmpFinal.Produzir) IN TmpSaldo
                        REPLACE TmpFinal.Estoque WITH TmpFinal.Saldo - loc_oTxt.Value IN TmpFinal
                        REPLACE KeySelm WITH .F. IN TmpSaldU

                        loc_nBaixa = TmpSaldo.Saldo - TmpSaldo.Disps

                        loc_cExactOrig = SET("EXACT")
                        SET EXACT OFF

                        SELECT TmpSaldG
                        SET ORDER TO Cpros
                        =SEEK(TmpSaldo.Cpros + TmpSaldo.CodCors + TmpSaldo.CodTams)
                        REPLACE Disps WITH Saldo ;
                          WHILE Cpros   = TmpSaldo.Cpros ;
                            AND CodCors = TmpSaldo.CodCors ;
                            AND CodTams = TmpSaldo.CodTams
                        =SEEK(TmpSaldo.Cpros + TmpSaldo.CodCors + TmpSaldo.CodTams)
                        SCAN WHILE Cpros   = TmpSaldo.Cpros ;
                               AND CodCors = TmpSaldo.CodCors ;
                               AND CodTams = TmpSaldo.CodTams ;
                               AND loc_nBaixa > 0
                            IF TmpSaldG.Disps >= loc_nBaixa
                                REPLACE TmpSaldG.Disps WITH TmpSaldG.Disps - loc_nBaixa
                                loc_nBaixa = 0
                            ELSE
                                loc_nBaixa = loc_nBaixa - TmpSaldG.Disps
                                REPLACE TmpSaldG.Disps WITH 0
                            ENDIF
                        ENDSCAN

                        SET EXACT &loc_cExactOrig
                    ELSE
                        MsgAviso("N" + CHR(227) + "o H" + CHR(225) + " Saldo Dispon" + CHR(237) + ;
                            "vel Deste Produto No Estoque Para Reservar!!!", "Aten" + CHR(231) + CHR(227) + "o")
                        loc_oTxt.Value = THIS.this_nProduzirValorAnterior
                    ENDIF
            ENDCASE

            loc_oTxt.Refresh()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro em ValidarItemProduzir")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * ItemProduzirLostFocus - Transcricao de SIGPRGLP.GradeItens.Column6.
    * Text1.LostFocus. Reflete o Saldo/Estoque/Produzir agregados de todo o
    * TmpFinal nos totais do rodape da grade principal.
    *
    * O "Sum Saldo, Estoque, Produzir" com guarda de RECNO() eh exatamente o
    * que BOParaForm faz - o legado repete esse mesmo bloco aqui, no Init e
    * no retorno dos paineis de estoque, e aqui ele passa pelo funil unico.
    *--------------------------------------------------------------------------
    PROCEDURE ItemProduzirLostFocus()
        LOCAL loc_oErro

        TRY
            IF USED("TmpFinal")
                THIS.BOParaForm()
                THIS.Refresh()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro em ItemProduzirLostFocus")
        ENDTRY
    ENDPROC

    *==========================================================================
    * COLUNA "UTILIZAR" DOS PAINEIS DE ESTOQUE (Container2 = Produto/Cor/Tam,
    * Container5 = Grupo/Conta)
    *==========================================================================

    *--------------------------------------------------------------------------
    * DispProdutoUtilizarKeyPress - Gatilho do Valid da Column5.Text1 do
    * grd_4c_DispProduto (Container2), emulado por ENTER/TAB.
    *--------------------------------------------------------------------------
    PROCEDURE DispProdutoUtilizarKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 13 OR par_nKeyCode = 9
            THIS.ValidarDispProdutoUtilizar()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarDispProdutoUtilizar - Transcricao de SIGPRGLP.Container2.
    * GradeDisp.Column5.Text1.Valid. Impede utilizar mais do que o disponivel
    * na linha OU mais do que o total pedido, e espelha o somatorio em
    * txt_4c_QtSelec (This.Parent.Parent.Parent.Qt_Selec do legado - Text1 ->
    * Column -> Grid -> Container2).
    *--------------------------------------------------------------------------
    PROCEDURE ValidarDispProdutoUtilizar()
        LOCAL loc_oTxt, loc_nRegDisp, loc_nQtdUti, loc_oErro

        TRY
            IF !USED("TmpDisp") OR !USED("TmpFinal") OR EOF("TmpDisp")
                RETURN
            ENDIF

            loc_oTxt = THIS.cnt_4c_Container2.grd_4c_DispProduto.Column5.Text1

            IF loc_oTxt.Value > TmpDisp.Disps
                MsgAviso("A Qtde. a Utilizar N" + CHR(227) + "o Pode Ser Maior Que a Qtde. " + ;
                    "Dispon" + CHR(237) + "vel!!!", "Aten" + CHR(231) + CHR(227) + "o")
                loc_oTxt.Value = 0
                loc_oTxt.Refresh()
            ELSE
                SELECT TmpDisp
                loc_nRegDisp = RECNO()
                loc_nQtdUti  = 0
                SUM Utilizar TO loc_nQtdUti
                IF loc_nRegDisp > 0 AND loc_nRegDisp <= RECCOUNT("TmpDisp")
                    GO loc_nRegDisp IN TmpDisp
                ENDIF

                IF loc_nQtdUti > TmpFinal.Saldo
                    MsgAviso("A Qtde. Selecionada N" + CHR(227) + "o Pode Ser Maior Que a Qtde. " + ;
                        "Pedida!!!", "Aten" + CHR(231) + CHR(227) + "o")
                    loc_oTxt.Value = 0
                    loc_oTxt.Refresh()
                ELSE
                    THIS.cnt_4c_Container2.txt_4c_QtSelec.Value = loc_nQtdUti
                    THIS.cnt_4c_Container2.txt_4c_QtSelec.Refresh()
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro em ValidarDispProdutoUtilizar")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * DispGrupoUtilizarKeyPress - Gatilho do Valid da Column5.Text1 do
    * grd_4c_DispGrupo (Container5), emulado por ENTER/TAB.
    *--------------------------------------------------------------------------
    PROCEDURE DispGrupoUtilizarKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 13 OR par_nKeyCode = 9
            THIS.ValidarDispGrupoUtilizar()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarDispGrupoUtilizar - Transcricao de SIGPRGLP.Container5.
    * GradeDisp.Column5.Text1.Valid. Mesma regra do Container2 (Disponivel na
    * linha + total pedido), mas o total pedido eh TmpFinal.Saldo -
    * TmpFinal.Estoque (o Container5 ja mostra so o saldo AINDA nao coberto
    * por estoque - ver BtnSelEstoqueClick).
    *--------------------------------------------------------------------------
    PROCEDURE ValidarDispGrupoUtilizar()
        LOCAL loc_oTxt, loc_nRegDisp, loc_nQtdUti, loc_oErro

        TRY
            IF !USED("TmpDisp") OR !USED("TmpFinal") OR EOF("TmpDisp")
                RETURN
            ENDIF

            loc_oTxt = THIS.cnt_4c_Container5.grd_4c_DispGrupo.Column5.Text1

            IF loc_oTxt.Value > TmpDisp.Disps
                MsgAviso("A quantidade a utilizar n" + CHR(227) + "o pode ser maior que Qtde " + ;
                    "Disponivel...", "Aten" + CHR(231) + CHR(227) + "o")
                loc_oTxt.Value = 0
                loc_oTxt.Refresh()
            ELSE
                IF loc_oTxt.Value < 0
                    MsgAviso("A quantidade a utilizar n" + CHR(227) + "o pode ser menor que zero ...", ;
                        "Aten" + CHR(231) + CHR(227) + "o")
                    loc_oTxt.Value = 0
                    loc_oTxt.Refresh()
                ELSE
                    SELECT TmpDisp
                    loc_nRegDisp = RECNO()
                    loc_nQtdUti  = 0
                    SUM Utilizar TO loc_nQtdUti
                    IF loc_nRegDisp > 0 AND loc_nRegDisp <= RECCOUNT("TmpDisp")
                        GO loc_nRegDisp IN TmpDisp
                    ENDIF

                    IF loc_nQtdUti > TmpFinal.Saldo - TmpFinal.Estoque
                        MsgAviso("Qtde Selecionada n" + CHR(227) + "o pode ser maior que Qtde " + ;
                            "Solicitada...", "Aten" + CHR(231) + CHR(227) + "o")
                        loc_oTxt.Value = 0
                        loc_oTxt.Refresh()
                    ELSE
                        THIS.cnt_4c_Container5.txt_4c_QtSelec.Value = loc_nQtdUti
                        THIS.cnt_4c_Container5.txt_4c_QtSelec.Refresh()
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro em ValidarDispGrupoUtilizar")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * DispGrupoUtilizarLostFocus - Transcricao de SIGPRGLP.Container5.
    * GradeDisp.Column5.Text1.LostFocus: com Enter, desce uma linha na grade
    * (mesmo padrao do "{DNARROW}" ja usado em PedraSubstitutoLostFocus).
    *--------------------------------------------------------------------------
    PROCEDURE DispGrupoUtilizarLostFocus()
        IF LASTKEY() = 13
            KEYBOARD "{DNARROW}"
        ENDIF
        THIS.cnt_4c_Container5.grd_4c_DispGrupo.Column5.Text1.Refresh()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnProcessarClick - botao "Processar" (SIGPRGLP.Processar.Click).
    * Efetiva a geracao das Ordens de Producao/Reserva Automatica a partir
    * dos cursores de trabalho (TmpFinal/TmpDisp/TmpSaldo/TmpSaldG/TmpLinha/
    * SelPedra) ja preparados pelo form pai (FormSigPrGl2) e avo
    * (FormSigPrGlo). Este metodo so ORQUESTRA: repassa ao BO os dois
    * campos que o Init legado lia direto do avo ("_Prev"/"_DtGera" =
    * ThisForm.ParentForm.ParentForm.Cnt_Previsao.GetPrevisao/GetGeracao) e
    * o tipo de geracao de OP (Container1 do avo), e delega toda a gravacao
    * a SigPrGlpBO.Processar(), que transcreve o Click legado (1637 linhas
    * no dump original).
    *
    * THIS.this_oParentForm eh o FormSigPrGl2 (pai direto - "Operacoes
    * Selecionadas"); THIS.this_oParentForm.this_oParentForm eh o
    * FormSigPrGlo (avo - "Processamento de O.P."), que tem o
    * cnt_4c_Previsao e o cnt_4c_Container1.txt_4c_TpGOp.
    *
    * Release() fica FORA do TRY (regra #1 - liberar o proprio form de
    * dentro do bloco derrubaria a pilha de execucao dentro dele), mesmo
    * padrao ja usado em BtnSairClick.
    *--------------------------------------------------------------------------
    PROCEDURE BtnProcessarClick()
        LOCAL loc_lSucesso, loc_lFechar, loc_oErro
        loc_lFechar = .F.

        TRY
            IF !USED("TmpFinal") OR RECCOUNT("TmpFinal") = 0
                MsgAviso("N" + CHR(227) + "o h" + CHR(225) + " itens para processar.", ;
                    "Aten" + CHR(231) + CHR(227) + "o")
            ELSE
                *-- FormParaBO sobe os parametros de modo que o Init legado le
                *-- do form avo (_Prev/_DtGera/_lcTpGOp/GerPorTp) + o SigKey.
                *-- Devolvendo .F. ele JA exibiu a causa - processar sem data
                *-- de previsao/geracao gravaria O.P. com data em branco.
                IF THIS.FormParaBO()
                    loc_lSucesso = THIS.this_oBusinessObject.Processar()

                    IF loc_lSucesso
                        MsgInfo("Processamento efetuado com sucesso!" + CHR(13) + ;
                            "O.P. " + TRANSFORM(THIS.this_oBusinessObject.this_nNumeroOpGerada) + ;
                            " gerada.", "Confirmar")
                        loc_lFechar = .T.
                    ELSE
                        IF !EMPTY(THIS.this_oBusinessObject.this_cMensagemErro)
                            MsgErro(THIS.this_oBusinessObject.this_cMensagemErro, "Erro")
                        ENDIF
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro em BtnProcessarClick")
        ENDTRY

        IF loc_lFechar
            IF VARTYPE(THIS.this_oParentForm) = "O"
                THIS.this_oParentForm.Enabled = .T.
            ENDIF
            THIS.Release()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * ExecutarReportForm - Helper canonico de REPORT FORM (CorretorAutomatico
    * #117/#147). O legado escreve "Report Form SigReGlp Preview NoConsole"
    * na forma BARE, que faz o VFP9 procurar o FRX no diretorio CORRENTE em
    * vez de gc_4c_CaminhoReports.
    *
    * O helper resolve o caminho, recusa com mensagem clara quando o FRX
    * nao existe, evita preview vazio, e isola SET POINT/SEPARATOR/
    * REPORTBEHAVIOR - os FRX legado Fortyus foram desenhados com
    * POINT="." e REPORTBEHAVIOR 80; no modo 90 os campos numericos saem
    * como asteriscos. No fim restaura o menu principal, que o preview
    * corrompe.
    *
    * par_cModo: "PREVIEW" | "PRINTER_PROMPT" | "PRINTER"
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ExecutarReportForm(par_cRelatorioBase, par_cModo, par_cCursorDados)
        LOCAL loc_cFRX, loc_lProsseguir, loc_oErroMenu
        LOCAL loc_cPointOrig, loc_cSepOrig, loc_nBehaviorOrig

        loc_lProsseguir = .T.
        loc_cFRX = FULLPATH(gc_4c_CaminhoReports + par_cRelatorioBase + ".frx")

        IF NOT FILE(loc_cFRX)
            MostrarErro("Arquivo de relat" + CHR(243) + "rio n" + CHR(227) + "o encontrado:" + ;
                CHR(13) + loc_cFRX + CHR(13) + CHR(13) + ;
                "O FRX legado ainda n" + CHR(227) + "o foi portado para o novo sistema.", "Erro")
            loc_lProsseguir = .F.
        ENDIF

        IF loc_lProsseguir AND VARTYPE(par_cCursorDados) = "C" AND !EMPTY(par_cCursorDados)
            IF !USED(par_cCursorDados) OR RECCOUNT(par_cCursorDados) = 0
                MsgAviso("Nenhum registro encontrado com os filtros informados.", ;
                    "Aten" + CHR(231) + CHR(227) + "o")
                loc_lProsseguir = .F.
            ENDIF
        ENDIF

        IF loc_lProsseguir
            loc_cPointOrig    = SET("POINT")
            loc_cSepOrig      = SET("SEPARATOR")
            loc_nBehaviorOrig = SET("REPORTBEHAVIOR")

            SET POINT TO "."
            SET SEPARATOR TO ","
            SET REPORTBEHAVIOR 80

            DO CASE
                CASE par_cModo = "PREVIEW"
                    REPORT FORM (loc_cFRX) PREVIEW NOCONSOLE
                CASE par_cModo = "PRINTER_PROMPT"
                    REPORT FORM (loc_cFRX) TO PRINTER PROMPT NOCONSOLE
                CASE par_cModo = "PRINTER"
                    REPORT FORM (loc_cFRX) TO PRINTER NOCONSOLE
            ENDCASE

            SET POINT TO (loc_cPointOrig)
            SET SEPARATOR TO (loc_cSepOrig)
            SET REPORTBEHAVIOR (loc_nBehaviorOrig)

            *-- O preview abre toolbar propria e corrompe o cache visual do
            *-- _MSYSMENU: sem este bloco os popups do menu principal voltam
            *-- encolhidos depois de fechar o preview (mesmo fix do
            *-- FormBase.Destroy)
            TRY
                SET SYSMENU TO DEFAULT
                RELEASE POPUP popArquivo, popCadastros, popMovimentos, ;
                    popRelatorios, popFerramentas, popAjuda
                CriarMenuPrincipal()
            CATCH TO loc_oErroMenu
                *-- CriarMenuPrincipal fora de escopo (harness de teste roda o
                *-- form sem menu.prg carregado). O relatorio ja foi entregue
                *-- e nao ha menu para restaurar - nada a reportar ao usuario.
            ENDTRY
        ENDIF

        RETURN loc_lProsseguir
    ENDPROC

    *==========================================================================
    * CONSOLIDACAO FINAL - funis de carga, de mapeamento Form <-> BO e de
    * habilitacao da superficie editavel.
    *
    * SIGPRGLP eh form OPERACIONAL FLAT: o SCX legado nao tem PageFrame
    * Lista/Dados, nao tem frmcadastro nem a barra CRUD (Grupo_Op), e por
    * isso nao existem aqui os botoes Salvar/Buscar/Encerrar do padrao de
    * cadastro - o dump inteiro nao cita btnSalvar/btnGravar/mGravaDados.
    * O botao de acao eh "Processar" (SIGPRGLP.Processar.Click ->
    * BtnProcessarClick) e o de saida eh "Sair" (SIGPRGLP.Cancelar.Click ->
    * BtnSairClick). Criar Salvar/Buscar/Encerrar aqui seria INVENTAR
    * superficie que o legado nao tem (viola o PILAR 1).
    *
    * O que esta tela tem de verdade - e eh o que os metodos abaixo
    * consolidam num ponto unico - eh:
    *   (a) a grade principal ligada a TmpFinal            -> CarregarLista
    *   (b) os parametros de modo que o Init legado le do
    *       form AVO (FormSigPrGlo) e entrega ao
    *       processamento (_Prev/_DtGera/_lcTpGOp/GerPorTp) -> FormParaBO
    *   (c) Caption + totais do rodape + rotulo da
    *       observacao, derivados do BO e de TmpFinal       -> BOParaForm
    *   (d) o liga/desliga em bloco da tela enquanto um
    *       painel flutuante esta aberto                    -> HabilitarCampos
    *   (e) o estado inicial dos botoes de acao             -> AjustarBotoesPorModo
    *   (f) a limpeza dos campos de exibicao quando nao ha
    *       item corrente                                   -> LimparCampos
    *
    * ESCOPO: CarregarLista, HabilitarCampos e AjustarBotoesPorModo sao
    * PUBLIC (chamados de fora da classe pelo harness de teste e por
    * BINDEVENT, onde metodo PROTECTED falha em SILENCIO - CLAUDE.md regra
    * #3). Ja FormParaBO, BOParaForm e LimparCampos sao PROTECTED porque o
    * FormBase os declara assim (formbase.prg:276-285) e VFP9 NAO permite
    * ALARGAR escopo herdado: medido em 2026-09-29, omitir o PROTECTED aqui
    * faz PEMSTATUS devolver .T. e a chamada externa estourar mesmo assim
    * com "Property BOPARAFORM is not found". Sao chamados por THIS. de
    * dentro da classe (BtnProcessarClick -> FormParaBO; CarregarLista e
    * ItemProduzirLostFocus -> BOParaForm), que eh o contrato do FormBase.
    *==========================================================================

    *--------------------------------------------------------------------------
    * CarregarLista - Funil UNICO de (re)carga da grade principal
    * (grd_4c_Itens / GradeItens do legado, RecordSource = TmpFinal).
    *
    * Popular/alterar o cursor NAO repinta a grade (CLAUDE.md regra #21a): o
    * legado sempre fecha com "Go Top" + ".Refresh" e eh isso que este metodo
    * reproduz, em TODO caminho que mexe em TmpFinal (baixa de estoque por
    * produto, por conta, e o retorno dos paineis flutuantes).
    *
    * O rebind so acontece quando o RecordSource NAO esta mais em TmpFinal -
    * reatribuir RecordSource faz o VFP recalcular Column.Width para o default
    * 90 e zerar Header1.Caption (Problema 48), por isso o rebind passa por
    * LigarGradeItens(), que repoe as tres coisas na ordem canonica
    * (RecordSource -> ControlSource -> ColumnOrder -> Width -> Header).
    *--------------------------------------------------------------------------
    PROCEDURE CarregarLista()
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        TRY
            IF !USED("TmpFinal")
                *-- Os cursores de trabalho sao recebidos prontos do form pai
                *-- na DataSession compartilhada; sem eles nao ha o que exibir
                THIS.LimparCampos()
                MsgAviso("Os itens da pr" + CHR(233) + "via n" + CHR(227) + "o foram recebidos " + ;
                    "da tela de Processamento de O.P.", ;
                    "Aten" + CHR(231) + CHR(227) + "o")
            ELSE
                IF UPPER(ALLTRIM(THIS.grd_4c_Itens.RecordSource)) != "TMPFINAL"
                    THIS.LigarGradeItens()
                ENDIF

                SELECT TmpFinal
                GO TOP IN TmpFinal
                THIS.grd_4c_Itens.Refresh()

                *-- Totais do rodape + Caption + rotulo da observacao
                THIS.BOParaForm()

                *-- Faixa do painel "Estoque Disponivel por Conta" (Container3)
                *-- no item que ficou corrente
                THIS.AplicarFaixaSaldoContas()
                THIS.cnt_4c_Container3.grd_4c_DispConta.Refresh()

                IF RECCOUNT("TmpFinal") = 0
                    THIS.LimparCampos()
                ENDIF

                loc_lSucesso = (RECCOUNT("TmpFinal") > 0)
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro em CarregarLista")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * LigarGradeItens - (Re)ligacao da grade principal a TmpFinal, transcrita
    * de "With .GradeItens ... EndWith" do Init legado.
    *
    * ORDEM OBRIGATORIA: RecordSource -> ControlSource -> ColumnOrder ->
    * Width -> Header1.Caption. RecordSource reseta Width e Caption, por isso
    * os dois vem por ULTIMO (Problema 48 / CLAUDE.md regra #35c). Os valores
    * sao os mesmos declarados em ConfigurarGradeItens (SCX legado).
    *
    * Column8 exibe uma EXPRESSAO (marcador "*" quando o item tem observacao),
    * nao uma coluna - igual ao legado.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE LigarGradeItens()
        LOCAL loc_oErro

        TRY
            WITH THIS.grd_4c_Itens
                .ColumnCount  = 9
                .RecordSource = "TmpFinal"

                .Column1.ControlSource = "TmpFinal.Cpros"
                .Column2.ControlSource = "TmpFinal.CodCors"
                .Column3.ControlSource = "TmpFinal.Dopes"
                .Column4.ControlSource = "TmpFinal.Numes"
                .Column5.ControlSource = "TmpFinal.Saldo"
                .Column6.ControlSource = "TmpFinal.Produzir"
                .Column7.ControlSource = "TmpFinal.Estoque"
                .Column8.ControlSource = [IIF(ISNULL(TmpFinal.Obsps) OR EMPTY(TmpFinal.Obsps), "", "*")]
                .Column9.ControlSource = "TmpFinal.CodTams"

                .Column2.ColumnOrder = 6
                .Column3.ColumnOrder = 8
                .Column4.ColumnOrder = 9
                .Column5.ColumnOrder = 7
                .Column6.ColumnOrder = 4
                .Column7.ColumnOrder = 5
                .Column8.ColumnOrder = 2
                .Column9.ColumnOrder = 3

                .Column1.Width = 115
                .Column2.Width = 80
                .Column3.Width = 80
                .Column4.Width = 38
                .Column5.Width = 80
                .Column6.Width = 150
                .Column7.Width = 50
                .Column8.Width = 38
                .Column9.Width = 38

                .Column1.Header1.Caption = "Produto"
                .Column2.Header1.Caption = "Cor"
                .Column3.Header1.Caption = "Movimenta" + CHR(231) + CHR(227) + "o"
                .Column4.Header1.Caption = "C" + CHR(243) + "digo"
                .Column5.Header1.Caption = "Quantidade"
                .Column6.Header1.Caption = "Produzir"
                .Column7.Header1.Caption = "Estoque"
                .Column8.Header1.Caption = "Obs"
                .Column9.Header1.Caption = "Tam"
            ENDWITH
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro em LigarGradeItens")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * FormParaBO - Transfere para o Business Object tudo o que o
    * processamento le da TELA antes de efetivar as Ordens de Producao.
    *
    * Os campos editaveis desta tela vivem em CURSOR, nao em TextBox: a
    * coluna "Produzir" (TmpFinal.Produzir) e as colunas "Utilizar" dos dois
    * paineis de estoque estao ligadas por ControlSource e o BO le os
    * cursores diretamente - por isso o que sobe aqui sao os parametros de
    * MODO, que o Init legado le do form AVO (FormSigPrGlo, a tela de
    * Processamento de O.P.) e guarda em variaveis do proprio form:
    *
    *   _Prev    = Thisform.ParentForm.ParentForm.Container1.Get_Previsao.Value
    *   _DtGera  = ... Get_Geracao.Value
    *   _lcTpGOp = ... Get_TpGOp.Value
    *   GerPorTp = Not Empty(_lcTpGOp)
    *
    * mais o SigKey (CrSigCdPac.sigKeys), relido aqui porque o form pai pode
    * ter repopulado CrSigCdPac entre a abertura desta tela e o Processar.
    *
    * Retorna .F. (com mensagem) quando o avo nao esta acessivel - o
    * chamador ABORTA a gravacao nesse caso, em vez de processar com data de
    * previsao/geracao vazias.
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION FormParaBO()
        LOCAL loc_lSucesso, loc_oGlo, loc_cTpGOp, loc_oErro
        loc_lSucesso = .F.

        TRY
            IF VARTYPE(THIS.this_oBusinessObject) != "O"
                MsgErro("Business Object n" + CHR(227) + "o dispon" + CHR(237) + "vel.", "Erro")
            ELSE
                *-- "Thisform.SigKey = CrSigCdPac.sigKeys" do Init legado
                IF USED("CrSigCdPac") AND RECCOUNT("CrSigCdPac") > 0 AND !EOF("CrSigCdPac")
                    THIS.this_oBusinessObject.this_cSigKey = ALLTRIM(CrSigCdPac.sigKeys)
                ENDIF

                *-- Avo = FormSigPrGlo (pai deste form = FormSigPrGl2)
                loc_oGlo = .NULL.
                IF VARTYPE(THIS.this_oParentForm) = "O" AND ;
                        PEMSTATUS(THIS.this_oParentForm, "this_oParentForm", 5)
                    IF VARTYPE(THIS.this_oParentForm.this_oParentForm) = "O"
                        loc_oGlo = THIS.this_oParentForm.this_oParentForm
                    ENDIF
                ENDIF

                IF VARTYPE(loc_oGlo) != "O"
                    MsgErro("N" + CHR(227) + "o foi poss" + CHR(237) + "vel localizar a tela de " + ;
                        "Processamento de O.P. (form av" + CHR(244) + ").", "Erro")
                ELSE
                    loc_cTpGOp = ALLTRIM(loc_oGlo.cnt_4c_Container1.txt_4c_TpGOp.Value)

                    THIS.this_oBusinessObject.this_dPrevisao      = ;
                        ConverterParaData(loc_oGlo.cnt_4c_Previsao.txt_4c_Previsao.Value)
                    THIS.this_oBusinessObject.this_dDataGeracao   = ;
                        ConverterParaData(loc_oGlo.cnt_4c_Previsao.txt_4c_Geracao.Value)
                    THIS.this_oBusinessObject.this_cTipoGeracaoOP = PADR(loc_cTpGOp, 10)
                    THIS.this_oBusinessObject.this_lGerPorTp      = !EMPTY(loc_cTpGOp)

                    loc_lSucesso = .T.
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro em FormParaBO")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * BOParaForm - Reflete na tela o estado do Business Object e dos cursores
    * de trabalho. Funil UNICO dos totais do rodape da grade principal, que o
    * legado recalcula em tres pontos diferentes com o MESMO codigo (Init,
    * Column6.LostFocus e o retorno dos paineis de estoque):
    *
    *   Select TmpFinal / Sum Saldo, Estoque, Produzir To lnSal, lnEst, lnPrz
    *   .Tot_Qtd.Value = lnSal / .Tot_Est.Value = lnEst / .Tot_Prz.Value = lnPrz
    *
    * SUM percorre o cursor inteiro e deixa o ponteiro em EOF - o RECNO() eh
    * guardado antes e restaurado depois, senao a linha corrente da grade
    * (e a faixa do Container3, que depende dela) se perde a cada total.
    *
    * Tambem repoe o Caption (Globalizacao x Reserva Automatica, do Init
    * legado) e o rotulo da observacao do item corrente.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE BOParaForm()
        LOCAL loc_nRecno, loc_nSal, loc_nEst, loc_nPrz, loc_cCaption, loc_oErro

        TRY
            IF VARTYPE(THIS.this_oBusinessObject) = "O"
                loc_cCaption = "Pr" + CHR(233) + "via da Globaliza" + CHR(231) + CHR(227) + "o"
                IF THIS.this_oBusinessObject.this_lReserva
                    loc_cCaption = "Pr" + CHR(233) + "via da Reserva Autom" + CHR(225) + "tica"
                ENDIF
                THIS.Caption = loc_cCaption
                THIS.cnt_4c_Sombra.lbl_4c_LblSombra.Caption = loc_cCaption
                THIS.cnt_4c_Sombra.lbl_4c_LblTitulo.Caption = loc_cCaption
            ENDIF

            IF USED("TmpFinal")
                SELECT TmpFinal
                loc_nRecno = RECNO()
                loc_nSal   = 0
                loc_nEst   = 0
                loc_nPrz   = 0

                SUM Saldo, Estoque, Produzir TO loc_nSal, loc_nEst, loc_nPrz

                IF loc_nRecno > 0 AND loc_nRecno <= RECCOUNT("TmpFinal")
                    GO loc_nRecno IN TmpFinal
                ENDIF

                THIS.txt_4c_TotQtd.Value = loc_nSal
                THIS.txt_4c_TotEst.Value = loc_nEst
                THIS.txt_4c_TotPrz.Value = loc_nPrz

                IF !EOF("TmpFinal")
                    THIS.lbl_4c_TxtObsItens.Caption = "Observa" + CHR(231) + CHR(227) + ;
                        "o do Item " + ALLTRIM(TmpFinal.Cpros)
                ENDIF
            ELSE
                THIS.txt_4c_TotQtd.Value = 0
                THIS.txt_4c_TotEst.Value = 0
                THIS.txt_4c_TotPrz.Value = 0
            ENDIF

            THIS.txt_4c_TotQtd.Refresh()
            THIS.txt_4c_TotEst.Refresh()
            THIS.txt_4c_TotPrz.Refresh()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro em BOParaForm")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * HabilitarCampos - Liga/desliga em bloco a superficie de trabalho da
    * tela (os 5 botoes de acao, a grade principal e o painel de estoque por
    * conta do rodape), transcrito dos blocos "With ThisForm / .Processar.
    * Enabled = .f. / ... / EndWith" que o legado repete no Click de cada
    * botao que abre um painel flutuante, e do bloco espelhado (.t.) no
    * fechamento de cada painel.
    *
    * par_lIncluirSelEstoque controla se o botao "Estoques" entra no bloco:
    * ele so existe para quem tem o acesso PRIORIDADE (ver
    * AjustarBotoesPorModo), entao religa-lo sem criterio devolveria um
    * botao que o usuario nao deveria ter - o legado, pelo mesmo motivo, o
    * inclui no bloco do painel de estoque por conta e o omite nos demais.
    *
    * "Sair" (cmd_4c_Cancelar) entra no bloco porque o legado o desabilita
    * junto: com um painel aberto, a saida se da pelo OK/Sair do painel.
    *--------------------------------------------------------------------------
    PROCEDURE HabilitarCampos(par_lHabilitar, par_lIncluirSelEstoque)
        LOCAL loc_lLigar, loc_oErro
        loc_lLigar = IIF(VARTYPE(par_lHabilitar) = "L", par_lHabilitar, .T.)

        TRY
            THIS.cmd_4c_Processar.Enabled  = loc_lLigar
            THIS.cmd_4c_Cancelar.Enabled   = loc_lLigar
            THIS.cmd_4c_TotLinha.Enabled   = loc_lLigar
            THIS.cmd_4c_Pedras.Enabled     = loc_lLigar
            THIS.cmd_4c_Disponivel.Enabled = loc_lLigar

            IF VARTYPE(par_lIncluirSelEstoque) = "L" AND par_lIncluirSelEstoque
                THIS.cmd_4c_SelEstoque.Enabled = loc_lLigar
            ENDIF

            THIS.cnt_4c_Container3.Enabled = loc_lLigar
            THIS.grd_4c_Itens.Enabled      = loc_lLigar
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro em HabilitarCampos")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * AjustarBotoesPorModo - Estado inicial dos botoes de acao, conforme as
    * regras que o Init legado aplica uma a uma:
    *
    *   Requisicoes  - "ThisForm.Pedras.Enabled = .F." e so volta a .T. com
    *                  as QUATRO operacoes de transferencia preenchidas em
    *                  SigCdPam (DopEmphs/DopReqcs/DopPedcs/DopComps) E fora
    *                  da Reserva Automatica;
    *   Estoques     - nasce desligado no SCX e so liga com
    *                  fChecaAcesso('SIGPRGLO','PRIORIDADE');
    *   coluna
    *   Produzir     - "If Empty(crSigCdPam.TransfRes) / .SetAll('ReadOnly',
    *                  .t.)" - sem operacao de transferencia de reserva
    *                  configurada a grade inteira fica somente-leitura.
    *
    * As demais acoes (Processar/Total-Linhas/Disponiveis/Relatorio) e a
    * propria grade dependem de haver item em TmpFinal - processar ou
    * imprimir previa vazia nao faz sentido. "Sair" fica SEMPRE disponivel:
    * eh a unica saida da tela (o form legado tem TitleBar=0 e
    * ControlBox=.F.).
    *--------------------------------------------------------------------------
    PROCEDURE AjustarBotoesPorModo()
        LOCAL loc_lTemItens, loc_lPedras, loc_oErro

        TRY
            loc_lTemItens = USED("TmpFinal") AND RECCOUNT("TmpFinal") > 0

            loc_lPedras = .F.
            IF VARTYPE(THIS.this_oBusinessObject) = "O"
                loc_lPedras = !EMPTY(THIS.this_oBusinessObject.this_cPamDopEmphs) AND ;
                              !EMPTY(THIS.this_oBusinessObject.this_cPamDopReqcs) AND ;
                              !EMPTY(THIS.this_oBusinessObject.this_cPamDopPedcs) AND ;
                              !EMPTY(THIS.this_oBusinessObject.this_cPamDopComps) AND ;
                              !THIS.this_oBusinessObject.this_lReserva
            ENDIF

            THIS.cmd_4c_Pedras.Enabled       = loc_lPedras AND loc_lTemItens
            THIS.cmd_4c_SelEstoque.Enabled   = loc_lTemItens AND fChecaAcesso("SIGPRGLO", "PRIORIDADE")
            THIS.cmd_4c_Processar.Enabled    = loc_lTemItens
            THIS.cmd_4c_TotLinha.Enabled     = loc_lTemItens
            THIS.cmd_4c_Disponivel.Enabled   = loc_lTemItens
            THIS.cmd_4c_BtnRelatorio.Enabled = loc_lTemItens
            THIS.grd_4c_Itens.Enabled        = loc_lTemItens
            THIS.cnt_4c_Container3.Enabled   = loc_lTemItens

            THIS.cmd_4c_Cancelar.Enabled     = .T.

            *-- "If Empty(crSigCdPam.TransfRes) / .SetAll('ReadOnly', .t.)".
            *-- O ReadOnly do Grid propaga para as colunas, entao este bloco
            *-- fica DEPOIS de qualquer ajuste de coluna (regra #18).
            IF VARTYPE(THIS.this_oBusinessObject) = "O" AND ;
                    EMPTY(THIS.this_oBusinessObject.this_cPamTransfRes)
                THIS.grd_4c_Itens.SetAll("ReadOnly", .T.)
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro em AjustarBotoesPorModo")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * LimparCampos - Zera os campos de EXIBICAO da tela (totais do rodape,
    * totais e descricoes do painel de estoque por conta, quantidades dos
    * paineis flutuantes, rotulo da observacao e a foto do produto).
    *
    * Nao toca nos CURSORES: TmpFinal/TmpSaldo/TmpSaldG pertencem a
    * DataSession compartilhada com o form pai, que os calculou - apagar o
    * conteudo deles aqui destruiria o trabalho do chamador. Chamado quando
    * nao ha item corrente (previa vazia ou cursores nao recebidos), para a
    * tela nao exibir numeros e a foto do ultimo item consultado.
    *
    * CLEAR RESOURCES antes de soltar a Picture: o arquivo TempGlb.jpg eh
    * reescrito a cada troca de linha e fica travado enquanto o VFP mantem a
    * imagem em cache (mesmo motivo do CLEAR RESOURCES do
    * GradeItensAfterRowColChange).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE LimparCampos()
        LOCAL loc_oErro

        TRY
            THIS.txt_4c_TotQtd.Value = 0
            THIS.txt_4c_TotEst.Value = 0
            THIS.txt_4c_TotPrz.Value = 0
            THIS.txt_4c_TotQtd.Refresh()
            THIS.txt_4c_TotEst.Refresh()
            THIS.txt_4c_TotPrz.Refresh()

            THIS.lbl_4c_TxtObsItens.Caption = "Observa" + CHR(231) + CHR(227) + "o do Item"

            CLEAR RESOURCES
            THIS.img_4c_ImgFigJpg.Picture = ""
            THIS.img_4c_ImgFigJpg.Visible = .F.

            WITH THIS.cnt_4c_Container3
                .txt_4c_TotQtd.Value    = 0
                .txt_4c_TotEst.Value    = 0
                .txt_4c_TotPrz.Value    = 0
                .txt_4c_GetDGrupo.Value = ""
                .txt_4c_GetDConta.Value = ""
                .lbl_4c_Label1.Caption  = "Estoque Dispon" + CHR(237) + "vel"
                .Visible     = .T.
            ENDWITH

            WITH THIS.cnt_4c_Container2
                .txt_4c_QtPedida.Value = 0
                .txt_4c_QtSelec.Value  = 0
                .Visible     = .T.
            ENDWITH

            WITH THIS.cnt_4c_Container5
                .txt_4c_QtPedida.Value  = 0
                .txt_4c_QtSelec.Value   = 0
                .txt_4c_GetDGrupo.Value = ""
                .txt_4c_GetDConta.Value = ""
                .Visible     = .T.
            ENDWITH

            THIS.Refresh()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro em LimparCampos")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * TornarControlesVisiveis - Torna visiveis os controles criados via
    * AddObject (nascem Visible=.F.). Os containers flutuantes do legado
    * (Container1/Container2/Container4/Container5 - cada um declara
    * "Visible = .F." no dump e eh alternado pelos botoes de acao Pedras/
    * SelEstoque/TotLinha/Disponivel, adicionados na Fase 4) sao FILTRADOS
    * aqui: tornar visivel incondicionalmente destruiria esse comportamento
    * (CLAUDE.md - regra de Containers Flutuantes em forms OPERACIONAL).
    * Container3 (Estoque Disponivel por conta, rodape) NAO entra no
    * filtro - o dump nao declara Visible para ele, ou seja permanece
    * visivel por padrao, igual ao legado.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
        LOCAL loc_nI, loc_oObjeto

        FOR loc_nI = 1 TO par_oContainer.ControlCount
            loc_oObjeto = par_oContainer.Controls(loc_nI)

            IF VARTYPE(loc_oObjeto) = "O"
                IF INLIST(UPPER(loc_oObjeto.Name), "CNT_4C_CONTAINER1", ;
                        "CNT_4C_CONTAINER2", "CNT_4C_CONTAINER4", "CNT_4C_CONTAINER5")
                    THIS.TornarControlesVisiveis(loc_oObjeto)
                    LOOP
                ENDIF

                IF PEMSTATUS(loc_oObjeto, "Visible", 5)
                    loc_oObjeto.Visible = .T.
                ENDIF

                IF PEMSTATUS(loc_oObjeto, "ControlCount", 5)
                    THIS.TornarControlesVisiveis(loc_oObjeto)
                ENDIF
            ENDIF
        ENDFOR
    ENDPROC

ENDDEFINE

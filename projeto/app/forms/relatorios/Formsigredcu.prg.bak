*==============================================================================
* FORMSIGREDCU.PRG
* Form de Impressao de Documento (dialogo modal parametrizado)
* Tipo: DIALOGO - chamado por forms operacionais apos preparar TmpRelat/TmpRel
* Migrado de: SIGREDCU.SCX (frmrelatorio legado)
*
* Parametros Init():
*   par_nQbols     - Quantidade de vias para impressao
*   par_oCnx       - Conexao legada (ignorada - usa gnConnHandle global)
*   par_cEmail     - Email de destino para envio do documento
*   par_cEmp       - Codigo da empresa (3 chars)
*   par_cDop       - Tipo de operacao (20 chars)
*   par_nNum       - Numero do documento
*   par_nImpress   - Tipo impressao pre-selecionado (0=nenhum,1=video,2=impr,3=xls,4=enc)
*   par_oForm      - Referencia ao form chamador (reativado ao fechar)
*   par_lChkImpDoc - Flag controle de impressao do documento
*
* FASE 3/8 - Estrutura base do form
*   - Propriedades visuais (EXATAS do original SIGREDCU: Width=798, Height=250)
*   - Init() com recepcao de 9 parametros e criacao do BO antes de InicializarForm
*   - InicializarForm() - carrega dados da operacao e monta cabecalho
*   - ConfigurarCabecalho() - container escuro com titulo (equivale ao cntSombra)
*   - Destroy() - reativa form pai e libera recursos
*==============================================================================

DEFINE CLASS Formsigredcu AS FormBase

    *-- Dimensoes e aparencia (EXATAS do original SIGREDCU)
    this_cMensagemErro = ""
    Height          = 250
    Width           = 798
    DataSession     = 1
    ShowWindow = 1
    BorderStyle     = 2
    ControlBox      = .F.
    WindowType      = 1
    AlwaysOnTop     = .T.
    AutoCenter      = .T.
    MaxButton       = .F.
    MinButton       = .F.
    Themes          = .F.
    ShowTips        = .T.

    *-- BO de impressao (criado em Init() antes de DODEFAULT/InicializarForm)
    this_oRelatorio         = .NULL.

    *-- Parametros do dialogo (mapeados das propriedades do SIGREDCU legado)
    this_oFormPai           = .NULL.    && oForm: referencia ao form chamador
    this_nQbols             = 1         && Qbols: quantidade de vias
    this_nTpImpressao       = 0         && TpImpressao: 0=nenhum 1=video 2=impressora 3=excel 4=encerrar
    this_lAcImprimir        = .T.       && lAcImprimir: acesso ao botao imprimir
    this_lAcExcel           = .T.       && lAcExcel: acesso ao botao excel
    this_lChkImpDoc         = .F.       && ChkImpDoc: flag controle de impressao do documento
    this_lChkImpDocAcess    = .F.       && ChkImpDocAcess: flag acesso para reimpressao

    *--------------------------------------------------------------------------
    * Init - Recebe parametros do form chamador, prepara BO e inicia interface
    *   O BO e criado ANTES de DODEFAULT() porque InicializarForm() precisa
    *   de this_oRelatorio para carregar dados da operacao via PrepararDados().
    *   Desabilita o form pai enquanto este dialogo estiver aberto.
    *--------------------------------------------------------------------------
    PROCEDURE Init(par_nQbols, par_oCnx, par_cEmail, par_cEmp, par_cDop, par_nNum, par_nImpress, par_oForm, par_lChkImpDoc)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            *-- Cria o BO antes de DODEFAULT (InicializarForm precisa dele)
            THIS.this_oRelatorio = CREATEOBJECT("sigredcuBO")
            IF VARTYPE(THIS.this_oRelatorio) = "O"

                *-- Armazena referencia ao form pai (para reativar em Destroy)
                THIS.this_oFormPai                 = par_oForm
                THIS.this_oRelatorio.this_oFormPai = par_oForm

                *-- Transfere parametros para o BO
                THIS.this_oRelatorio.this_cEmail  = IIF(VARTYPE(par_cEmail)   = "C", ALLTRIM(par_cEmail),   "")
                THIS.this_oRelatorio.this_cEmps   = IIF(VARTYPE(par_cEmp)     = "C", ALLTRIM(par_cEmp),     "")
                THIS.this_oRelatorio.this_cDopes  = IIF(VARTYPE(par_cDop)     = "C", ALLTRIM(par_cDop),     "")
                THIS.this_oRelatorio.this_nNumes  = IIF(VARTYPE(par_nNum)     = "N", par_nNum,               0)
                THIS.this_oRelatorio.this_nQbols  = IIF(VARTYPE(par_nQbols)   = "N" AND par_nQbols >= 1, par_nQbols, 1)
                THIS.this_nQbols                  = THIS.this_oRelatorio.this_nQbols

                *-- Tipo de impressao pre-selecionado (pImpress do legado)
                THIS.this_nTpImpressao                     = IIF(VARTYPE(par_nImpress) = "N", par_nImpress, 0)
                THIS.this_oRelatorio.this_nTpImpressao     = THIS.this_nTpImpressao

                *-- Flag controle de impressao (pChkImpDoc do legado)
                THIS.this_lChkImpDoc = IIF(VARTYPE(par_lChkImpDoc) = "L", par_lChkImpDoc, .F.)

                *-- Desabilita form pai enquanto este dialogo estiver aberto
                IF VARTYPE(par_oForm) = "O" AND !ISNULL(par_oForm)
                    par_oForm.Enabled = .F.
                ENDIF

                *-- Inicializa interface (FormBase.Init -> THIS.InicializarForm)
                loc_lSucesso = DODEFAULT()

            ELSE
                MsgErro("Falha ao criar sigredcuBO" + CHR(13) + ;
                    "VARTYPE retornou: " + VARTYPE(THIS.this_oRelatorio), "Formsigredcu.Init")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Formsigredcu.Init")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * InicializarForm - Configura fundo, caption, carrega dados da operacao
    *                   e monta estrutura visual base (fase 3: cabecalho)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lSucesso, loc_lContinuar
        loc_lSucesso   = .F.
        loc_lContinuar = .T.
        TRY
            *-- Valida que o BO foi criado pelo Init() antes de DODEFAULT()
            IF VARTYPE(THIS.this_oRelatorio) != "O"
                MsgErro("BO n" + CHR(227) + "o inicializado em InicializarForm", ;
                    "Formsigredcu.InicializarForm")
                loc_lContinuar = .F.
            ENDIF

            IF loc_lContinuar
                *-- Imagem de fundo e caption do dialogo
                IF TYPE("gc_4c_CaminhoIcones") = "U"
                    gc_4c_CaminhoIcones = ""
                ENDIF
                THIS.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
                THIS.Caption = "Impress" + CHR(227) + "o de Documento"

                *-- Carrega dados da operacao do banco (pula em modo validacao UI)
                IF TYPE("gb_4c_ValidandoUI") != "L" OR !gb_4c_ValidandoUI
                    THIS.Caption = THIS.Caption + " (" + ;
                                   ALLTRIM(THIS.this_oRelatorio.this_cDopes) + "/" + ;
                                   ALLTRIM(STR(THIS.this_oRelatorio.this_nNumes)) + ")"
                    IF !THIS.this_oRelatorio.PrepararDados()
                        IF !EMPTY(THIS.this_oRelatorio.ObterMensagemErro())
                        MsgErro(THIS.this_oRelatorio.ObterMensagemErro(), ;
                            "Formsigredcu.InicializarForm")
                        ENDIF
                        loc_lContinuar = .F.
                    ENDIF
                ENDIF
            ENDIF

            IF loc_lContinuar
                *-- Monta layout (FLAT - orquestrado por ConfigurarPageFrame)
                THIS.ConfigurarPageFrame()

                *-- Propaga caption para os labels do cabecalho
                THIS.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
                THIS.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption

                THIS.Visible = .T.
                THIS.AplicarTipoImpressaoInicial()
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Formsigredcu.InicializarForm")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPageFrame - Orquestra a montagem do layout do form de relatorio
    *
    * Form REPORT (frmrelatorio): layout FLAT sem PageFrame CRUD de duas Pages.
    * Mesmo assim mantemos o nome ConfigurarPageFrame para padronizacao com o
    * pipeline de migracao (orquestrador valida presenca do metodo) e para
    * concentrar em um unico ponto a montagem visual do dialogo de impressao.
    *
    * Na Fase 3 monta apenas a estrutura base (cabecalho escuro com titulo).
    * Fases posteriores incrementam este orquestrador adicionando chamadas a
    * ConfigurarBotoesRelatorio (Fase 4), ConfigurarControles (Fase 5/6) e
    * AplicarValoresIniciais (Fase 7/8).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPageFrame()
        THIS.ConfigurarCabecalho()
        THIS.ConfigurarBotoesRelatorio()
        THIS.ConfigurarPaginaDados()
        THIS.ConfigurarPaginaLista()
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPaginaLista - Aplica valores iniciais aos controles do dialogo
    *
    * Em forms REPORT (frmrelatorio) nao ha Page1/Page2 - este metodo eh o
    * equivalente funcional do ConfigurarPaginaLista CRUD: sincroniza estado
    * inicial dos controles de opcao (CheckBoxes e OptionGroup) com os dados
    * carregados pelo BO em PrepararDados() e com os parametros recebidos
    * do form chamador.
    *
    * Logica espelhada do SIGREDCU.Init() legado:
    *   chkImagem.Value = crSigCdOpeD.chkIFoto  (1=imprime imagem padrao)
    *   chkCompo.Value  = Int(Val(Substr(lbltxidCs, 21, 1)))  (configuracao composicao)
    *   chkCompo.Visible = fChecaAcesso(nDopes, "INIBCOMPO")
    *   OptAgrupa.Value = 2  (default "Nenhum")
    *   chkImpPag/ChkItensP/chkDescIng marcam ImpTodasPaginas no BO
    *
    * Os controles sao criados em fases posteriores (5/6) - usa VARTYPE para
    * evitar erro quando este metodo for chamado antes da criacao dos checkboxes.
    * Sempre sincroniza o BO no final (mesmo sem os controles instanciados).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPaginaLista()
        LOCAL loc_nValComp, loc_cConfig, loc_oBO

        loc_oBO = THIS.this_oRelatorio
        IF VARTYPE(loc_oBO) != "O"
            RETURN
        ENDIF

        *-- chkImagem: marca conforme flag chkIFoto da operacao
        IF VARTYPE(THIS.chk_4c_ChkImagem) = "O"
            THIS.chk_4c_ChkImagem.Value = IIF(loc_oBO.this_nChkIFoto = 1, 1, 0)
        ENDIF
        loc_oBO.this_nChkImagem = IIF(loc_oBO.this_nChkIFoto = 1, 1, 0)

        *-- chkCompo: valor extraido do char 21 da string de configuracao
        loc_cConfig = loc_oBO.this_cLblTxIdCs
        loc_nValComp = 0
        IF LEN(loc_cConfig) >= 21
            loc_nValComp = INT(VAL(SUBSTR(loc_cConfig, 21, 1)))
        ENDIF
        IF VARTYPE(THIS.chk_4c_ChkCompo) = "O"
            THIS.chk_4c_ChkCompo.Value   = loc_nValComp
            THIS.chk_4c_ChkCompo.Visible = loc_oBO.this_lChkCompoVisivel
        ENDIF
        loc_oBO.this_nChkCompo = loc_nValComp

        *-- ChkItensP: nao marcado por default
        IF VARTYPE(THIS.chk_4c_ChkItensP) = "O"
            THIS.chk_4c_ChkItensP.Value = 0
        ENDIF
        loc_oBO.this_nChkItensP = 0

        *-- chkDescIng: nao marcado por default
        IF VARTYPE(THIS.chk_4c_ChkDescIng) = "O"
            THIS.chk_4c_ChkDescIng.Value = 0
        ENDIF
        loc_oBO.this_nChkDescIng = 0

        *-- chkImpPag: nao marcado por default (ImpTodasPaginas desligado)
        IF VARTYPE(THIS.chk_4c_ChkImpPag) = "O"
            THIS.chk_4c_ChkImpPag.Value = 0
        ENDIF
        loc_oBO.this_nChkImpPag       = 0
        loc_oBO.this_lImpTodasPaginas = .F.

        *-- OptAgrupa: default "Nenhum" (valor 2)
        IF VARTYPE(THIS.obj_4c_OptAgrupa) = "O"
            THIS.obj_4c_OptAgrupa.Value = 2
        ENDIF
        loc_oBO.this_nOptAgrupa = 2

        *-- Sincroniza permissoes vindas do BO para os botoes de acesso
        THIS.this_lAcImprimir     = loc_oBO.this_lAcImprimir
        THIS.this_lAcExcel        = loc_oBO.this_lAcExcel
        THIS.this_lChkImpDocAcess = loc_oBO.this_lChkImpDocAcess
    ENDPROC

    *--------------------------------------------------------------------------
    * AlternarPagina - Despacha acao do relatorio conforme par_nPagina
    *
    * Em forms REPORT (frmrelatorio) nao ha Page1/Page2 para alternar - este
    * metodo eh o equivalente funcional do "alternar pagina" CRUD: despacha
    * para uma das 4 acoes do CommandGroup superior conforme o codigo:
    *   1 = Visualizar (preview na tela)
    *   2 = Imprimir   (impressora padrao)
    *   3 = DocExcel   (exportacao para planilha)
    *   4 = Encerrar   (fecha o dialogo, restaura impressora)
    *
    * Permite invocar acoes do relatorio via codigo (testes / shortcuts /
    * RemoteTrigger) sem depender do Click direto dos botoes.
    *--------------------------------------------------------------------------
    PROCEDURE AlternarPagina(par_nPagina)
        LOCAL loc_nAcao
        loc_nAcao = IIF(VARTYPE(par_nPagina) = "N", par_nPagina, 0)

        DO CASE
            CASE loc_nAcao = 1
                THIS.BtnVisualizarClick()
            CASE loc_nAcao = 2
                THIS.BtnImprimirClick()
            CASE loc_nAcao = 3
                THIS.BtnExcelClick()
            CASE loc_nAcao = 4
                THIS.BtnEncerrarClick()
            OTHERWISE
                MsgAviso("AlternarPagina: a" + CHR(231) + CHR(227) + "o inv" + ;
                    CHR(225) + "lida (" + ALLTRIM(STR(loc_nAcao)) + ;
                    "). Use 1=Visualizar, 2=Imprimir, 3=Excel, 4=Encerrar.", "Aviso")
        ENDCASE
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarCabecalho - Container escuro superior com titulo do dialogo
    *   Equivalente ao cntSombra do frmrelatorio legado.
    *   Largura = Width do form (cobre toda a faixa superior).
    *   Height = 83 para acomodar os botoes (cmg_4c_Botoes Height=80 acima).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarCabecalho()
        THIS.AddObject("cnt_4c_Cabecalho", "Container")
        WITH THIS.cnt_4c_Cabecalho
            .Top         = 0
            .Left        = 0
            .Width       = THIS.Width
            .Height      = 83
            .BackStyle   = 1
            .BackColor   = RGB(100, 100, 100)
            .BorderWidth = 0
            .Visible     = .T.

            *-- Sombra deslocada 2px para efeito 3D no texto branco
            .AddObject("lbl_4c_Sombra", "Label")
            WITH .lbl_4c_Sombra
                .Top       = 22
                .Left      = 22
                .Width     = THIS.Width
                .Height    = 30
                .Caption   = "Impress" + CHR(227) + "o de Documento"
                .FontName  = "Tahoma"
                .FontSize  = 14
                .FontBold  = .T.
                .ForeColor = RGB(0, 0, 0)
                .BackStyle = 0
                .Visible   = .T.
            ENDWITH

            *-- Titulo em branco sobre a sombra
            .AddObject("lbl_4c_Titulo", "Label")
            WITH .lbl_4c_Titulo
                .Top       = 20
                .Left      = 20
                .Width     = THIS.Width
                .Height    = 30
                .Caption   = "Impress" + CHR(227) + "o de Documento"
                .FontName  = "Tahoma"
                .FontSize  = 14
                .FontBold  = .T.
                .ForeColor = RGB(255, 255, 255)
                .BackStyle = 0
                .Visible   = .T.
            ENDWITH
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * Destroy - Reativa form pai, restaura impressora e libera BO
    *   Chamado automaticamente pelo VFP9 ao executar Release() no form.
    *   Equivalente ao PROCEDURE Release do SIGREDCU legado.
    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
        TRY
            *-- Reativa o form pai ao fechar este dialogo
            IF VARTYPE(THIS.this_oFormPai) = "O" AND !ISNULL(THIS.this_oFormPai)
                THIS.this_oFormPai.Enabled = .T.
            ENDIF

            *-- Restaura impressora padrao (Set Printer to Default do legado)
            SET PRINTER TO DEFAULT

            *-- Libera BO (NAO usar .Release() - Custom nao tem Release)
            IF VARTYPE(THIS.this_oRelatorio) = "O" AND !ISNULL(THIS.this_oRelatorio)
                THIS.this_oRelatorio = .NULL.
            ENDIF

            THIS.this_oFormPai = .NULL.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Formsigredcu.Destroy")
        ENDTRY
        DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarBotoesRelatorio - CommandGroup com 4 botoes de acao do relatorio
    *   Geometria EXATA do frmrelatorio framework: Top=0 Left=529 Width=273 Height=80
    *   Buttons(1)=Visualizar, (2)=Imprimir, (3)=DocExcel, (4)=Encerrar
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarBotoesRelatorio()
        THIS.AddObject("cmg_4c_Botoes", "CommandGroup")

        WITH THIS.cmg_4c_Botoes
            .Top           = 0
            .Left          = 529
            .Width         = 273
            .Height        = 80
            .ButtonCount   = 4
            .BackStyle     = 0
            .BorderStyle   = 0
            .BorderColor   = RGB(136, 189, 188)
            .SpecialEffect = 1
            .Themes        = .F.
            .Value         = 0
            .Visible       = .T.
        ENDWITH

        WITH THIS.cmg_4c_Botoes.Buttons(1)
            .Caption         = "Visualizar"
            .Top             = 5
            .Left            = 5
            .Width           = 65
            .Height          = 70
            .Picture         = gc_4c_CaminhoIcones + "relatorio_video_26.jpg"
            .FontName        = "Comic Sans MS"
            .FontBold        = .T.
            .FontItalic      = .T.
            .FontSize        = 8
            .BackColor       = RGB(255, 255, 255)
            .ForeColor       = RGB(90, 90, 90)
            .PicturePosition = 13
            .SpecialEffect   = 0
            .MousePointer    = 15
            .Themes          = .F.
        ENDWITH

        WITH THIS.cmg_4c_Botoes.Buttons(2)
            .Caption         = "Imprimir"
            .Top             = 5
            .Left            = 71
            .Width           = 65
            .Height          = 70
            .Picture         = gc_4c_CaminhoIcones + "relatorio_impressora_26.jpg"
            .FontName        = "Comic Sans MS"
            .FontBold        = .T.
            .FontItalic      = .T.
            .FontSize        = 8
            .BackColor       = RGB(255, 255, 255)
            .ForeColor       = RGB(90, 90, 90)
            .PicturePosition = 13
            .SpecialEffect   = 0
            .MousePointer    = 15
            .Themes          = .F.
        ENDWITH

        WITH THIS.cmg_4c_Botoes.Buttons(3)
            .Caption         = "\<Arquivos Email"
            .WordWrap        = .T.
            .Top             = 5
            .Left            = 137
            .Width           = 65
            .Height          = 70
            .Picture         = gc_4c_CaminhoIcones + "geral_envelope_32.jpg"
            .FontName        = "Comic Sans MS"
            .FontBold        = .T.
            .FontItalic      = .T.
            .FontSize        = 8
            .BackColor       = RGB(255, 255, 255)
            .ForeColor       = RGB(90, 90, 90)
            .PicturePosition = 13
            .SpecialEffect   = 0
            .MousePointer    = 15
            .Themes          = .F.
        ENDWITH

        WITH THIS.cmg_4c_Botoes.Buttons(4)
            .Caption         = "Encerrar"
            .WordWrap        = .T.
            .Top             = 5
            .Left            = 203
            .Width           = 65
            .Height          = 70
            .Picture         = gc_4c_CaminhoIcones + "relatorio_sair_60.jpg"
            .FontName        = "Comic Sans MS"
            .FontBold        = .T.
            .FontItalic      = .T.
            .FontSize        = 8
            .BackColor       = RGB(255, 255, 255)
            .ForeColor       = RGB(90, 90, 90)
            .PicturePosition = 13
            .SpecialEffect   = 0
            .MousePointer    = 15
            .Themes          = .F.
            .Cancel          = .T.
        ENDWITH

        BINDEVENT(THIS.cmg_4c_Botoes.Buttons(1), "Click", THIS, "BtnVisualizarClick")
        BINDEVENT(THIS.cmg_4c_Botoes.Buttons(2), "Click", THIS, "BtnImprimirClick")
        BINDEVENT(THIS.cmg_4c_Botoes.Buttons(3), "Click", THIS, "BtnExcelClick")
        BINDEVENT(THIS.cmg_4c_Botoes.Buttons(4), "Click", THIS, "BtnEncerrarClick")
    ENDPROC

    *--------------------------------------------------------------------------
    * AplicarTipoImpressaoInicial - Auto-executa acao pre-selecionada pelo chamador
    *   TpImpressao: 0=usuario escolhe, 1=video, 2=impressora, 3=excel, 4=encerrar
    *   Chamado ao final de InicializarForm() depois de THIS.Visible = .T.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE AplicarTipoImpressaoInicial()
        DO CASE
        CASE THIS.this_nTpImpressao = 1
            THIS.BtnVisualizarClick()
        CASE THIS.this_nTpImpressao = 2
            THIS.BtnImprimirClick()
        CASE THIS.this_nTpImpressao = 3
            THIS.BtnExcelClick()
        CASE THIS.this_nTpImpressao = 4
            THIS.BtnEncerrarClick()
        ENDCASE
    ENDPROC

    *--------------------------------------------------------------------------
    * InibirBotoes - Habilita ou desabilita o CommandGroup durante processamento
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE InibirBotoes(par_lInibir)
        IF PEMSTATUS(THIS, "cmg_4c_Botoes", 5)
            THIS.cmg_4c_Botoes.Enabled = !par_lInibir
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnVisualizarClick - Preview do documento na tela (Buttons(1))
    *   Equivale a This.Value=1 no Click do CommandGroup legado
    *--------------------------------------------------------------------------
    PROCEDURE BtnVisualizarClick()
        LOCAL loc_cSep, loc_cPnt
        loc_cSep = SET("Separator")
        loc_cPnt = SET("Point")
        TRY
            IF VARTYPE(go_4c_Sistema) = "O" AND PEMSTATUS(go_4c_Sistema, "QtdDecimais", 5)
                IF INLIST(go_4c_Sistema.QtdDecimais, 0, 2)
                    SET SEPARATOR TO ","
                    SET POINT TO "."
                ELSE
                    SET SEPARATOR TO "."
                    SET POINT TO ","
                ENDIF
            ENDIF

            THIS.AlwaysOnTop = .F.
            THIS.InibirBotoes(.T.)
            THIS.FormParaRelatorio()

            IF !THIS.this_oRelatorio.Atualizar()
                IF !EMPTY(THIS.this_oRelatorio.ObterMensagemErro())
                MsgErro(THIS.this_oRelatorio.ObterMensagemErro(), ;
                    "Formsigredcu.BtnVisualizarClick")
                ENDIF
            ENDIF

            THIS.AlwaysOnTop = .T.
        CATCH TO loc_oErro
            THIS.AlwaysOnTop = .T.
            MsgErro(loc_oErro.Message, "Formsigredcu.BtnVisualizarClick")
        ENDTRY
        SET SEPARATOR TO (loc_cSep)
        SET POINT TO (loc_cPnt)
        THIS.InibirBotoes(.F.)
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnImprimirClick - Envia documento para impressora (Buttons(2))
    *   Equivale a This.Value=2 no Click do CommandGroup legado.
    *   Verifica acesso e controle de impressao antes de processar.
    *--------------------------------------------------------------------------
    PROCEDURE BtnImprimirClick()
        LOCAL loc_cSep, loc_cPnt, loc_lPodeProsseguir
        loc_cSep = SET("Separator")
        loc_cPnt = SET("Point")
        loc_lPodeProsseguir = .T.
        TRY
            IF VARTYPE(go_4c_Sistema) = "O" AND PEMSTATUS(go_4c_Sistema, "QtdDecimais", 5)
                IF INLIST(go_4c_Sistema.QtdDecimais, 0, 2)
                    SET SEPARATOR TO ","
                    SET POINT TO "."
                ELSE
                    SET SEPARATOR TO "."
                    SET POINT TO ","
                ENDIF
            ENDIF

            IF !THIS.this_lAcImprimir
                MsgAviso("Acesso negado " + CHR(224) + " opera" + CHR(231) + ;
                    CHR(227) + "o Imprimir.", "Acesso")
                loc_lPodeProsseguir = .F.
            ENDIF

            IF loc_lPodeProsseguir AND THIS.this_lChkImpDoc
                IF THIS.this_oRelatorio.VerificarReimpressao() AND !THIS.this_lChkImpDocAcess
                    MsgAviso("Documento j" + CHR(225) + " foi impresso." + CHR(13) + ;
                        "N" + CHR(227) + "o h" + CHR(225) + " permiss" + CHR(227) + ;
                        "o para reimpress" + CHR(227) + "o.", ;
                        "Controle de Impress" + CHR(227) + "o")
                    loc_lPodeProsseguir = .F.
                ENDIF
            ENDIF

            IF loc_lPodeProsseguir
                IF VARTYPE(go_4c_Sistema) = "O" AND PEMSTATUS(go_4c_Sistema, "ControlaImp", 5)
                    go_4c_Sistema.ControlaImp = .F.
                ENDIF

                THIS.AlwaysOnTop = .F.
                THIS.InibirBotoes(.T.)
                THIS.FormParaRelatorio()

                IF !THIS.this_oRelatorio.Inserir()
                    IF !EMPTY(THIS.this_oRelatorio.ObterMensagemErro())
                    MsgErro(THIS.this_oRelatorio.ObterMensagemErro(), ;
                        "Formsigredcu.BtnImprimirClick")
                    ENDIF
                ELSE
                    IF !EMPTY(THIS.this_oRelatorio.this_cEmail) AND ;
                       !EMPTY(THIS.this_oRelatorio.this_cArqEmail) AND ;
                       FILE(THIS.this_oRelatorio.this_cArqEmail)
                        THIS.this_oRelatorio.EnviarEmail(THIS.this_oRelatorio.this_cArqEmail)
                    ENDIF
                ENDIF

                THIS.AlwaysOnTop = .T.
            ENDIF

        CATCH TO loc_oErro
            THIS.AlwaysOnTop = .T.
            MsgErro(loc_oErro.Message, "Formsigredcu.BtnImprimirClick")
        ENDTRY
        SET SEPARATOR TO (loc_cSep)
        SET POINT TO (loc_cPnt)
        THIS.InibirBotoes(.F.)
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnExcelClick - Gera exportacao do documento para Excel (Buttons(3))
    *   Equivale a This.Value=3 no Click do CommandGroup legado.
    *   Apos gerar o arquivo envia por email se this_cEmail estiver configurado.
    *--------------------------------------------------------------------------
    PROCEDURE BtnExcelClick()
        LOCAL loc_cSep, loc_cPnt, loc_lPodeProsseguir
        loc_cSep = SET("Separator")
        loc_cPnt = SET("Point")
        loc_lPodeProsseguir = .T.
        TRY
            IF VARTYPE(go_4c_Sistema) = "O" AND PEMSTATUS(go_4c_Sistema, "QtdDecimais", 5)
                IF INLIST(go_4c_Sistema.QtdDecimais, 0, 2)
                    SET SEPARATOR TO ","
                    SET POINT TO "."
                ELSE
                    SET SEPARATOR TO "."
                    SET POINT TO ","
                ENDIF
            ENDIF

            IF !THIS.this_lAcExcel
                MsgAviso("Acesso negado " + CHR(224) + " opera" + CHR(231) + ;
                    CHR(227) + "o Excel.", "Acesso")
                loc_lPodeProsseguir = .F.
            ENDIF

            IF loc_lPodeProsseguir
                IF VARTYPE(go_4c_Sistema) = "O" AND PEMSTATUS(go_4c_Sistema, "ControlaImp", 5)
                    go_4c_Sistema.ControlaImp = .F.
                ENDIF

                THIS.AlwaysOnTop = .F.
                THIS.InibirBotoes(.T.)
                THIS.FormParaRelatorio()

                IF !THIS.this_oRelatorio.DocumentoExcel()
                    IF !EMPTY(THIS.this_oRelatorio.ObterMensagemErro())
                    MsgErro(THIS.this_oRelatorio.ObterMensagemErro(), ;
                        "Formsigredcu.BtnExcelClick")
                    ENDIF
                ELSE
                    IF !EMPTY(THIS.this_oRelatorio.this_cEmail) AND ;
                       !EMPTY(THIS.this_oRelatorio.this_cArqEmail) AND ;
                       FILE(THIS.this_oRelatorio.this_cArqEmail)
                        THIS.this_oRelatorio.EnviarEmail(THIS.this_oRelatorio.this_cArqEmail)
                    ENDIF
                ENDIF

                THIS.AlwaysOnTop = .T.
            ENDIF

        CATCH TO loc_oErro
            THIS.AlwaysOnTop = .T.
            MsgErro(loc_oErro.Message, "Formsigredcu.BtnExcelClick")
        ENDTRY
        SET SEPARATOR TO (loc_cSep)
        SET POINT TO (loc_cPnt)
        THIS.InibirBotoes(.F.)
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnEncerrarClick - Fecha o dialogo de impressao (Buttons(4) / ESC)
    *   Equivale a This.Value=4 no Click do CommandGroup legado.
    *   Destroy() reativa o form pai e restaura SET PRINTER automaticamente.
    *--------------------------------------------------------------------------
    PROCEDURE BtnEncerrarClick()
        THIS.Release()
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPaginaDados - Cria controles do dialogo (Fase 5: primeiros 50%)
    *   Cria: chk_4c_ChkImagem, chk_4c_ChkItensP, chk_4c_ChkDescIng, chk_4c_ChkCompo
    *   Posicoes EXATAS do original SIGREDCU (Top=88/105/122/139, Left=36)
    *   Fase 6 completa com chk_4c_ChkImpPag, obj_4c_OptAgrupa, lbl_4c_Agrupa
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPaginaDados()
        *-- chkImagem: "Imprimir Imagem" (Top=88)
        THIS.AddObject("chk_4c_ChkImagem", "CheckBox")
        WITH THIS.chk_4c_ChkImagem
            .Top       = 88
            .Left      = 36
            .Height    = 17
            .Width     = 140
            .Caption   = "Imprimir Imagem"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .AutoSize  = .T.
            .Alignment = 0
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Value     = 0
            .Visible   = .T.
        ENDWITH
        BINDEVENT(THIS.chk_4c_ChkImagem, "Click", THIS, "ChkImagemClick")

        *-- ChkItensP: checkbox filtro de itens (Top=105)
        THIS.AddObject("chk_4c_ChkItensP", "CheckBox")
        WITH THIS.chk_4c_ChkItensP
            .Top       = 105
            .Left      = 36
            .Height    = 17
            .Width     = 200
            .Caption   = "Imprimir Apenas Itens Pendentes"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .AutoSize  = .T.
            .Alignment = 0
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Value     = 0
            .Visible   = .T.
        ENDWITH
        BINDEVENT(THIS.chk_4c_ChkItensP, "Click", THIS, "ChkItensPClick")

        *-- chkDescIng: "Imprimir Descricao em Ingles" (Top=122)
        THIS.AddObject("chk_4c_ChkDescIng", "CheckBox")
        WITH THIS.chk_4c_ChkDescIng
            .Top       = 122
            .Left      = 36
            .Height    = 17
            .Width     = 200
            .Caption   = "Imprimir Descri" + CHR(231) + CHR(227) + "o em Ingl" + CHR(234) + "s"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .AutoSize  = .T.
            .Alignment = 0
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Value     = 0
            .Visible   = .T.
        ENDWITH
        BINDEVENT(THIS.chk_4c_ChkDescIng, "Click", THIS, "ChkDescIngClick")

        *-- chkCompo: "Inibir Composicao Desmembrada" (Top=139)
        THIS.AddObject("chk_4c_ChkCompo", "CheckBox")
        WITH THIS.chk_4c_ChkCompo
            .Top       = 139
            .Left      = 36
            .Height    = 17
            .Width     = 200
            .Caption   = "Inibir Composi" + CHR(231) + CHR(227) + "o Desmembrada"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .AutoSize  = .T.
            .Alignment = 0
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Value     = 0
            .Visible   = .T.
        ENDWITH
        BINDEVENT(THIS.chk_4c_ChkCompo, "Click", THIS, "ChkCompoClick")

        *-- chkImpPag: "Imprimir o Cabecalho em Todas as Paginas" (Top=156)
        THIS.AddObject("chk_4c_ChkImpPag", "CheckBox")
        WITH THIS.chk_4c_ChkImpPag
            .Top       = 156
            .Left      = 36
            .Height    = 17
            .Width     = 230
            .Caption   = "Imprimir o Cabe" + CHR(231) + "alho em Todas as P" + CHR(225) + "ginas"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .AutoSize  = .T.
            .Alignment = 0
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Value     = 0
            .Visible   = .T.
        ENDWITH
        BINDEVENT(THIS.chk_4c_ChkImpPag, "Click", THIS, "ChkImpPagClick")

        *-- lbl_4c_Agrupa: "Agrupar por :" (Top=180, Left=36)
        THIS.AddObject("lbl_4c_Agrupa", "Label")
        WITH THIS.lbl_4c_Agrupa
            .Top       = 180
            .Left      = 36
            .Height    = 15
            .Width     = 67
            .Caption   = "Agrupar por :"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .AutoSize  = .T.
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        *-- obj_4c_OptAgrupa: OptionGroup com 3 opcoes de agrupamento (Top=174, Left=117)
        THIS.AddObject("obj_4c_OptAgrupa", "OptionGroup")
        WITH THIS.obj_4c_OptAgrupa
            .Top         = 174
            .Left        = 117
            .Width       = 210
            .Height      = 57
            .ButtonCount = 3
            .BackStyle   = 0
            .BorderStyle = 0
            .Value       = 2
            .Visible     = .T.
        ENDWITH
        WITH THIS.obj_4c_OptAgrupa.Buttons(1)
            .Caption   = "Produto, Cor, Valor Unit" + CHR(225) + "rio"
            .Top       = 5
            .Left      = 6
            .Height    = 15
            .Width     = 151
            .FontName  = "Comic Sans MS"
            .FontSize  = 8
            .BackStyle = 0
            .AutoSize  = .T.
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH
        WITH THIS.obj_4c_OptAgrupa.Buttons(2)
            .Caption   = "Nenhum"
            .Top       = 20
            .Left      = 6
            .Height    = 17
            .Width     = 78
            .FontName  = "Comic Sans MS"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH
        WITH THIS.obj_4c_OptAgrupa.Buttons(3)
            .Caption   = "Ref fornecedor, Cor, Tamanho"
            .WordWrap        = .T.
            .Top       = 37
            .Left      = 6
            .Height    = 15
            .Width     = 194
            .FontName  = "Comic Sans MS"
            .FontSize  = 8
            .BackStyle = 0
            .AutoSize  = .F.
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH
        BINDEVENT(THIS.obj_4c_OptAgrupa, "InteractiveChange", THIS, "OptAgrupaInteractiveChange")
    ENDPROC

    *--------------------------------------------------------------------------
    * ChkImagemClick - Sincroniza flag imagem no BO e reprocessa TmpRelat
    *   Equivale a chkImagem.Click() do legado (chama SigPrIdc com novo valor)
    *--------------------------------------------------------------------------
    PROCEDURE ChkImagemClick()
        IF VARTYPE(THIS.this_oRelatorio) = "O"
            THIS.this_oRelatorio.this_nChkImagem = THIS.chk_4c_ChkImagem.Value
            IF !THIS.this_oRelatorio.AtualizarOpcoes()
                IF !EMPTY(THIS.this_oRelatorio.ObterMensagemErro())
                MsgErro(THIS.this_oRelatorio.ObterMensagemErro(), "Formsigredcu.ChkImagemClick")
                ENDIF
            ENDIF
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * ChkItensPClick - Sincroniza flag ChkItensP no BO e reprocessa TmpRelat
    *   Equivale a ChkItensP.Click() do legado (chama SigPrIdc com novo valor)
    *--------------------------------------------------------------------------
    PROCEDURE ChkItensPClick()
        IF VARTYPE(THIS.this_oRelatorio) = "O"
            THIS.this_oRelatorio.this_nChkItensP = THIS.chk_4c_ChkItensP.Value
            IF !THIS.this_oRelatorio.AtualizarOpcoes()
                IF !EMPTY(THIS.this_oRelatorio.ObterMensagemErro())
                MsgErro(THIS.this_oRelatorio.ObterMensagemErro(), "Formsigredcu.ChkItensPClick")
                ENDIF
            ENDIF
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * ChkDescIngClick - Sincroniza flag descricao em ingles no BO e reprocessa TmpRelat
    *   Equivale a chkDescIng.Click() do legado (chama SigPrIdc com novo valor)
    *--------------------------------------------------------------------------
    PROCEDURE ChkDescIngClick()
        IF VARTYPE(THIS.this_oRelatorio) = "O"
            THIS.this_oRelatorio.this_nChkDescIng = THIS.chk_4c_ChkDescIng.Value
            IF !THIS.this_oRelatorio.AtualizarOpcoes()
                IF !EMPTY(THIS.this_oRelatorio.ObterMensagemErro())
                MsgErro(THIS.this_oRelatorio.ObterMensagemErro(), "Formsigredcu.ChkDescIngClick")
                ENDIF
            ENDIF
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * ChkCompoClick - Sincroniza flag inibir composicao no BO e reprocessa TmpRelat
    *   Equivale a chkCompo.Click() do legado (lnInibCompo = this.Value, chama SigPrIdc)
    *--------------------------------------------------------------------------
    PROCEDURE ChkCompoClick()
        IF VARTYPE(THIS.this_oRelatorio) = "O"
            THIS.this_oRelatorio.this_nChkCompo = THIS.chk_4c_ChkCompo.Value
            IF !THIS.this_oRelatorio.AtualizarOpcoes()
                IF !EMPTY(THIS.this_oRelatorio.ObterMensagemErro())
                MsgErro(THIS.this_oRelatorio.ObterMensagemErro(), "Formsigredcu.ChkCompoClick")
                ENDIF
            ENDIF
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * ChkImpPagClick - Sincroniza flag ImpTodasPaginas no BO
    *   Equivale a chkImpPag.Click() do legado (atualiza this_lImpTodasPaginas)
    *--------------------------------------------------------------------------
    PROCEDURE ChkImpPagClick()
        IF VARTYPE(THIS.this_oRelatorio) = "O"
            THIS.this_oRelatorio.this_nChkImpPag       = THIS.chk_4c_ChkImpPag.Value
            THIS.this_oRelatorio.this_lImpTodasPaginas = (THIS.chk_4c_ChkImpPag.Value = 1)
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * OptAgrupaInteractiveChange - Sincroniza agrupamento no BO e reprocessa TmpRelat
    *   Equivale a OptAgrupa.Valid() do legado (chama SigPrIdc com novo agrupamento)
    *--------------------------------------------------------------------------
    PROCEDURE OptAgrupaInteractiveChange()
        IF VARTYPE(THIS.this_oRelatorio) = "O"
            THIS.this_oRelatorio.this_nOptAgrupa = THIS.obj_4c_OptAgrupa.Value
            IF !THIS.this_oRelatorio.AtualizarOpcoes()
                IF !EMPTY(THIS.this_oRelatorio.ObterMensagemErro())
                MsgErro(THIS.this_oRelatorio.ObterMensagemErro(), ;
                    "Formsigredcu.OptAgrupaInteractiveChange")
                ENDIF
            ENDIF
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnIncluirClick - Acao principal para REPORT: gera/imprime o documento
    *
    * Em forms REPORT (frmrelatorio) "Incluir" nao tem sentido CRUD. O equivalente
    * funcional eh a acao primaria do dialogo: enviar documento para impressora
    * (registra impressao se this_lChkImpDoc estiver ativo).
    *
    * Delega para BtnImprimirClick que ja implementa toda a logica de:
    *   - Validacao de acesso (this_lAcImprimir)
    *   - Controle de reimpressao (VerificarReimpressao + this_lChkImpDocAcess)
    *   - Chamada this_oRelatorio.Inserir() (executa Impressao + RegistrarImpressao)
    *   - Envio por email se this_cEmail estiver configurado
    *--------------------------------------------------------------------------
    PROCEDURE BtnIncluirClick()
        TRY
            THIS.BtnImprimirClick()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Formsigredcu.BtnIncluirClick")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnAlterarClick - Restaura opcoes padrao do dialogo de impressao
    *
    * Em forms REPORT (frmrelatorio) "Alterar" nao tem sentido CRUD. O equivalente
    * funcional eh permitir ao usuario voltar as opcoes para o estado inicial
    * (chk_4c_Imagem, chk_4c_ItensP, chk_4c_DescIng, chk_4c_Compo, chk_4c_ImpPag,
    *  obj_4c_OptAgrupa = 2) e reprocessar TmpRelat com os defaults.
    *
    * Reaplica ConfigurarPaginaLista (sincroniza estado inicial dos controles com
    * o BO) e dispara AtualizarOpcoes() para reprocessar SigPrIdc com defaults.
    *--------------------------------------------------------------------------
    PROCEDURE BtnAlterarClick()
        LOCAL loc_oBO
        TRY
            loc_oBO = THIS.this_oRelatorio
            IF VARTYPE(loc_oBO) = "O"
                THIS.ConfigurarPaginaLista()
                IF !loc_oBO.AtualizarOpcoes()
                    MsgErro(loc_oBO.ObterMensagemErro(), ;
                        "Formsigredcu.BtnAlterarClick")
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Formsigredcu.BtnAlterarClick")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnExcluirClick - Encerra o dialogo de impressao com confirmacao
    *
    * Em forms REPORT (frmrelatorio) "Excluir" nao tem sentido CRUD. O equivalente
    * funcional eh encerrar o dialogo (mesmo papel do botao Encerrar - Buttons(4)
    * do cmg_4c_Botoes). Pede confirmacao antes de fechar para nao perder as
    * opcoes/configuracoes selecionadas pelo usuario acidentalmente.
    *
    * Destroy() reativa o form pai e restaura SET PRINTER automaticamente.
    *--------------------------------------------------------------------------
    PROCEDURE BtnExcluirClick()
        IF MsgConfirma("Deseja encerrar a impress" + CHR(227) + "o do documento?", ;
                       "Encerrar")
            THIS.BtnEncerrarClick()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * FormParaRelatorio - Sincroniza TODOS os controles do form para o BO
    *   Garante que o BO tem o estado exato antes de Visualizar/Imprimir/Excel.
    *   Equivalente ao FormParaBO() dos forms CRUD.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE FormParaRelatorio()
        LOCAL loc_oBO
        loc_oBO = THIS.this_oRelatorio
        IF VARTYPE(loc_oBO) != "O"
            RETURN
        ENDIF
        WITH loc_oBO
            .this_nChkImagem       = IIF(VARTYPE(THIS.chk_4c_ChkImagem)  = "O", THIS.chk_4c_ChkImagem.Value,  0)
            .this_nChkItensP       = IIF(VARTYPE(THIS.chk_4c_ChkItensP)  = "O", THIS.chk_4c_ChkItensP.Value,  0)
            .this_nChkDescIng      = IIF(VARTYPE(THIS.chk_4c_ChkDescIng) = "O", THIS.chk_4c_ChkDescIng.Value, 0)
            .this_nChkCompo        = IIF(VARTYPE(THIS.chk_4c_ChkCompo)   = "O", THIS.chk_4c_ChkCompo.Value,   0)
            .this_nChkImpPag       = IIF(VARTYPE(THIS.chk_4c_ChkImpPag)  = "O", THIS.chk_4c_ChkImpPag.Value,  0)
            .this_lImpTodasPaginas = (IIF(VARTYPE(THIS.chk_4c_ChkImpPag) = "O", THIS.chk_4c_ChkImpPag.Value, 0) = 1)
            .this_nOptAgrupa       = IIF(VARTYPE(THIS.obj_4c_OptAgrupa)  = "O", THIS.obj_4c_OptAgrupa.Value,  2)
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * RelatorioParaForm - Sincroniza valores do BO de volta para os controles
    *   Equivalente ao BOParaForm() dos forms CRUD. Usado em LimparCampos().
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE RelatorioParaForm()
        LOCAL loc_oBO
        loc_oBO = THIS.this_oRelatorio
        IF VARTYPE(loc_oBO) != "O"
            RETURN
        ENDIF
        IF VARTYPE(THIS.chk_4c_ChkImagem) = "O"
            THIS.chk_4c_ChkImagem.Value = loc_oBO.this_nChkImagem
        ENDIF
        IF VARTYPE(THIS.chk_4c_ChkItensP) = "O"
            THIS.chk_4c_ChkItensP.Value = loc_oBO.this_nChkItensP
        ENDIF
        IF VARTYPE(THIS.chk_4c_ChkDescIng) = "O"
            THIS.chk_4c_ChkDescIng.Value = loc_oBO.this_nChkDescIng
        ENDIF
        IF VARTYPE(THIS.chk_4c_ChkCompo) = "O"
            THIS.chk_4c_ChkCompo.Value   = loc_oBO.this_nChkCompo
            THIS.chk_4c_ChkCompo.Visible = loc_oBO.this_lChkCompoVisivel
        ENDIF
        IF VARTYPE(THIS.chk_4c_ChkImpPag) = "O"
            THIS.chk_4c_ChkImpPag.Value = loc_oBO.this_nChkImpPag
        ENDIF
        IF VARTYPE(THIS.obj_4c_OptAgrupa) = "O"
            THIS.obj_4c_OptAgrupa.Value = loc_oBO.this_nOptAgrupa
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * LimparCampos - Restaura todos os controles para os valores iniciais
    *   Reaplica ConfigurarPaginaLista (recalcula defaults do BO) e reflete no form.
    *--------------------------------------------------------------------------
    PROCEDURE LimparCampos()
        TRY
            THIS.ConfigurarPaginaLista()
            THIS.RelatorioParaForm()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Formsigredcu.LimparCampos")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * HabilitarCampos - Habilita ou desabilita controles de opcao do dialogo
    *   par_lHabilitar = .T. habilita todos, .F. desabilita durante processamento.
    *--------------------------------------------------------------------------
    PROCEDURE HabilitarCampos(par_lHabilitar)
        LOCAL loc_lHab
        loc_lHab = IIF(VARTYPE(par_lHabilitar) = "L", par_lHabilitar, .T.)
        IF VARTYPE(THIS.chk_4c_ChkImagem) = "O"
            THIS.chk_4c_ChkImagem.Enabled = loc_lHab
        ENDIF
        IF VARTYPE(THIS.chk_4c_ChkItensP) = "O"
            THIS.chk_4c_ChkItensP.Enabled = loc_lHab
        ENDIF
        IF VARTYPE(THIS.chk_4c_ChkDescIng) = "O"
            THIS.chk_4c_ChkDescIng.Enabled = loc_lHab
        ENDIF
        IF VARTYPE(THIS.chk_4c_ChkCompo) = "O"
            THIS.chk_4c_ChkCompo.Enabled = loc_lHab
        ENDIF
        IF VARTYPE(THIS.chk_4c_ChkImpPag) = "O"
            THIS.chk_4c_ChkImpPag.Enabled = loc_lHab
        ENDIF
        IF VARTYPE(THIS.obj_4c_OptAgrupa) = "O"
            THIS.obj_4c_OptAgrupa.Enabled = loc_lHab
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * AjustarBotoesPorModo - Ajusta estado dos botoes conforme permissoes de acesso
    *   Desabilita Imprimir se !this_lAcImprimir, Excel se !this_lAcExcel.
    *   Chamado apos carregar dados e apos recarregar permissoes do BO.
    *--------------------------------------------------------------------------
    PROCEDURE AjustarBotoesPorModo()
        IF PEMSTATUS(THIS, "cmg_4c_Botoes", 5)
            THIS.cmg_4c_Botoes.Buttons(1).Enabled = .T.
            THIS.cmg_4c_Botoes.Buttons(2).Enabled = THIS.this_lAcImprimir
            THIS.cmg_4c_Botoes.Buttons(3).Enabled = THIS.this_lAcExcel
            THIS.cmg_4c_Botoes.Buttons(4).Enabled = .T.
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarLista - Form REPORT nao tem grade de lista
    *   Equivalente funcional: recarrega dados da operacao no BO via PrepararDados.
    *   Mantem assinatura padrao do pipeline para compatibilidade com ValidarUIFidelity.
    *--------------------------------------------------------------------------
    PROCEDURE CarregarLista()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            IF TYPE("gb_4c_ValidandoUI") != "L" OR !gb_4c_ValidandoUI
                IF VARTYPE(THIS.this_oRelatorio) = "O"
                    loc_lSucesso = THIS.this_oRelatorio.PrepararDados()
                    IF !loc_lSucesso
                        IF !EMPTY(THIS.this_oRelatorio.ObterMensagemErro())
                        MsgErro(THIS.this_oRelatorio.ObterMensagemErro(), ;
                            "Formsigredcu.CarregarLista")
                        ENDIF
                    ENDIF
                ENDIF
            ELSE
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Formsigredcu.CarregarLista")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnSalvarClick - Acao primaria do dialogo REPORT (equiv. Salvar CRUD)
    *
    * Em forms REPORT (frmrelatorio) "Salvar" nao tem sentido CRUD. O equivalente
    * funcional eh consolidar/processar o documento - aqui mapeia para a acao
    * de impressao (mesma logica de BtnIncluirClick) que executa o registro
    * de impressao via this_oRelatorio.Inserir() e envia por email se aplicavel.
    *--------------------------------------------------------------------------
    PROCEDURE BtnSalvarClick()
        TRY
            THIS.BtnImprimirClick()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Formsigredcu.BtnSalvarClick")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnCancelarClick - Cancela operacao e encerra dialogo (equiv. Cancelar CRUD)
    *
    * Em forms REPORT (frmrelatorio) "Cancelar" eh equivalente a encerrar o
    * dialogo de impressao - delega para BtnEncerrarClick que faz Release()
    * (reativa form pai e restaura SET PRINTER via Destroy()).
    *--------------------------------------------------------------------------
    PROCEDURE BtnCancelarClick()
        TRY
            THIS.BtnEncerrarClick()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Formsigredcu.BtnCancelarClick")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * FormParaBO - Alias CRUD para FormParaRelatorio (compatibilidade pipeline)
    *
    * O pipeline de migracao espera FormParaBO em forms CRUD. Em forms REPORT
    * o equivalente eh FormParaRelatorio (sincroniza controles -> BO antes de
    * Visualizar/Imprimir/Excel). Este alias garante compatibilidade com a
    * validacao de completude e mantem a semantica do form REPORT.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE FormParaBO()
        THIS.FormParaRelatorio()
    ENDPROC

    *--------------------------------------------------------------------------
    * BOParaForm - Alias CRUD para RelatorioParaForm (compatibilidade pipeline)
    *
    * O pipeline de migracao espera BOParaForm em forms CRUD. Em forms REPORT
    * o equivalente eh RelatorioParaForm (sincroniza BO -> controles). Este
    * alias garante compatibilidade com a validacao de completude.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE BOParaForm()
        THIS.RelatorioParaForm()
    ENDPROC

ENDDEFINE

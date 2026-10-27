*==============================================================================
* FormSigOpCfl.prg - Consulta de FollowUp de Cheques
* Origem: SigOpCfl.SCX (task687)
* Herda de: FormBase
* Tipo: OPERACIONAL (form de consulta/historico, SEM Page1/Page2) - layout
*       FLAT: cabecalho + area de dados do cheque (Banco/Agencia/Conta/
*       N.Cheque) + grade de historico (followup) + painel flutuante de
*       inclusao/alteracao de ocorrencia (cnt_4c__inserir, Visible=.F. por
*       padrao) + botao de saida, igual ao SIGOPCFL.SCX legado.
* Aberto por programa (par_cConta = SigChe.Nums do cheque selecionado),
* diretamente de outro form/tela (sem form pai no acervo desta task).
*
* Fase 3/8 - Estrutura base: cabecalho + shape decorativo + containers
*            vazios (cnt_4c_Dadoschq/cnt_4c__inserir, sem filhos ainda) +
*            botao Encerrar (cmg_4c_Commandgroup1).
* Fase 4/8 - Grade de historico (grd_4c_Dados) + CommandGroup de acoes
*            (cmg_4c_CmdApagaitem: Incluir/Alterar/Apagar/Listar) +
*            carga do cursor da grade (CarregarLista/RepintarGrade).
* Fase 5/8 - Cabecalho do cheque: Emissor (txt_4c_Conta/txt_4c_DConta) +
*            filhos de cnt_4c_Dadoschq (Banco/Agencia/Conta/N.Cheque).
* Fase 6/8 - Filhos de cnt_4c__inserir (Data/Hora + Observacao) + legenda
*            do historico automatico (lbl_4c_Label4/shp_4c_Shape1) +
*            eventos de DADOS do legado: When/Valid da celula de data da
*            grade (classe TextBoxCelulaFollowupCfl_4c instalada na
*            Column1) e LostFocus de gravacao do painel de inclusao/
*            alteracao (GetHist.LostFocus legado). O legado NAO tem lookup
*            algum (zero fwbuscaext/fwBuscaSel/sigacess no dump) - nao ha
*            picker a reproduzir (PILAR 1: "NUNCA inventar tabelas de
*            lookup que nao existem no original").
* Fase 7/8 - Eventos principais: reposicionamento/visibilidade dos botoes de
*            acao por fChecaAcesso (legado: With ThisForm.cmdApagaItem no
*            Init) + Click dos 4 botoes (Incluir/Alterar/Apagar - "Listar"
*            nao tem codigo no legado, logo nao recebe handler) + Click do
*            Encerrar (legado: Commandgroup1.Command1.Valid).
* Fase 8/8 - Consolidacao final:
*            - TabIndex transcritos do dump (regra: o SCX declara TabIndex em
*              15 controles e a migracao os descartou - a ordem de tabulacao
*              faz parte do PILAR 1);
*            - BOParaForm()/LimparCampos()/HabilitarCampos()/
*              AjustarBotoesPorModo()/BtnCancelarClick() - o FUNIL unico de
*              estado do painel flutuante, derivado de this_cModoAtual;
*            - SQL movido do form para o BO (CarregarHistorico/
*              CarregarCabecalho em SigOpCflBO) - PILAR 3: o form nao fala
*              com o banco;
*            - guardas de alias corrigidas (VFP9 nao faz short-circuit em
*              OR: "USED(x) OR RECCOUNT(x) = 0" avalia o RECCOUNT com o
*              alias fechado e estoura "Alias is not found").
*
* O que o legado NAO tem e por isso NAO foi criado (regra "NUNCA inventar"):
*   - botao de Buscar/Salvar/Confirmar: a gravacao do followup acontece no
*     LostFocus de GetHist (HistoricoLostFocus), nao em botao;
*   - botao de Cancelar: o caminho de cancelamento EXISTE (observacao em
*     branco fecha o painel sem gravar) e eh ele que BtnCancelarClick
*     implementa - nenhum botao novo foi desenhado na tela;
*   - entrada no menu: SIGOPCFL eh aberto POR PROGRAMA, recebendo o cheque
*     em par_cConta, e nao ha caller no acervo desta task. Uma entrada de
*     menu abriria a tela sem cheque (nums vazio), e o Incluir gravaria
*     followup orfao em SigCheh - por isso a tela nao foi registrada em
*     menu.prg. config.prg nao precisa de nada: ele carrega
*     forms\operacionais\Form*.prg e classes\*BO.prg por ADIR().
*==============================================================================

DEFINE CLASS FormSigOpCfl AS FormBase

    *-- Propriedades visuais (analise.json: Width=1000, Height=600, Tahoma 8)
    Height      = 600
    Width       = 1000
    Caption     = "Consulta de FollowUp de Cheques"
    AutoCenter  = .T.
    ShowWindow  = 1
    WindowType  = 1
    ControlBox  = .F.
    Closable    = .F.
    MaxButton   = .F.
    MinButton   = .F.
    TitleBar    = 0
    ClipControls = .F.
    Themes      = .F.
    BorderStyle = 2

    *-- DataSession = 2 transcrito do dump (SIGOPCFL declara DataSession = 2).
    *-- Sessao de dados PRIVADA: os cursores desta tela (cursor_4c_Dados e os
    *-- temporarios do BO) ficam isolados, como no legado.
    *-- DUAS consequencias que o VFP9 NAO avisa:
    *--   1. a sessao privada nasce com os SETs no DEFAULT do VFP
    *--      (SET DATE AMERICAN / CENTURY OFF), e sem correcao as datas da
    *--      grade sairiam como 05/25/26. FormBase.Init() repoe BRITISH +
    *--      CENTURY ON, e por isso o Init() deste form PRECISA continuar
    *--      chamando DODEFAULT() (regra #9.4).
    *--   2. SET SAFETY tambem eh escopado por sessao e vale ON aqui, mesmo
    *--      com o SET SAFETY OFF do main.prg. Com SAFETY ON o ZAP abre o
    *--      dialogo "Zap ... Are you sure?" e CONGELA a tela - por isso todo
    *--      ZAP desta tela passa por EsvaziarCursorDados().
    DataSession = 2

    *-- Propriedades de estado
    this_oBusinessObject = .NULL.
    this_cModoAtual       = ""      && "" / "INSERIR" / "ALTERAR" (legado: ThisForm.Tipo)
    this_cConta           = ""      && SigChe.Nums do cheque consultado (legado: ThisForm.conta)
    this_lEmGravacao      = .F.     && guarda de reentrancia do GetHist.LostFocus (regra #47)

    *==========================================================================
    * Init - par_cConta/par_dData chegam do caller (legado: LParameters pConta,
    * pData). Guarda par_cConta ANTES de DODEFAULT() - FormBase.Init() ja
    * encadeia para InicializarForm(), que precisa de this_cConta pronto para
    * as fases seguintes (carga do cheque/historico).
    *==========================================================================
    PROCEDURE Init(par_cConta, par_dData)
        THIS.this_cConta = IIF(VARTYPE(par_cConta) = "C", par_cConta, "")
        RETURN DODEFAULT()
    ENDPROC

    *==========================================================================
    * InicializarForm - Instancia o BO e monta a estrutura visual base
    *==========================================================================
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        TRY
            THIS.Picture = gc_4c_CaminhoIcones + "new_background.jpg"

            THIS.this_oBusinessObject = CREATEOBJECT("SigOpCflBO")
            IF VARTYPE(THIS.this_oBusinessObject) = "O"

                THIS.ConfigurarPageFrame()

                *-- Sincronizar caption nos labels do cabecalho
                THIS.cnt_4c_Sombra.lbl_4c_LblSombra.Caption = THIS.Caption
                THIS.cnt_4c_Sombra.lbl_4c_LblTitulo.Caption = THIS.Caption

                THIS.TornarControlesVisiveis(THIS)

                *-- Carga do historico do cheque (legado: Requery('CrSigCheh')
                *-- no proprio Init) + cabecalho fixo do cheque (legado:
                *-- Cursorquery SigChe/SigCdCli, logo depois do Requery). Em
                *-- validacao de UI / modo teste nao ha conexao SQL - a grade
                *-- e o cabecalho ficam vazios, sem impedir a abertura.
                IF (TYPE("gb_4c_ValidandoUI") != "L" OR !gb_4c_ValidandoUI) AND ;
                   (TYPE("gb_4c_ModoTeste")   != "L" OR !gb_4c_ModoTeste)
                    THIS.CarregarLista()
                    THIS.CarregarCabecalhoCheque()
                ENDIF

                loc_lSucesso = .T.
            ELSE
                MsgErro("Falha ao criar SigOpCflBO.", "Erro em InicializarForm")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, "Erro em InicializarForm")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * ConfigurarPageFrame - Orquestrador de montagem visual. SigOpCfl.SCX e
    * form PLANO sem PageFrame (cntSombra + dados do cheque + grade +
    * painel flutuante + botoes direto no form). Mantido o nome
    * "ConfigurarPageFrame" so para preservar o papel arquitetural de ponto
    * de entrada da montagem visual (mesmo padrao de FormSIGOPCFE/FormFop),
    * delegando para helpers dedicados.
    * Fase 3: cabecalho + containers base (vazios) + botao de saida.
    * Fase 4: grade de historico + CommandGroup de acoes + carga da grade.
    * Fase 5/6: filhos dos containers base.
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPageFrame()
        THIS.ConfigurarCabecalho()
        THIS.ConfigurarContainersBase()
        THIS.ConfigurarDadosCheque()
        THIS.ConfigurarPainelInserir()
        THIS.ConfigurarGrid()
        THIS.ConfigurarLegendaAutomatico()
        THIS.ConfigurarAcoes()
        THIS.ConfigurarSaida()
    ENDPROC

    *==========================================================================
    * ConfigurarCabecalho - cnt_4c_Sombra (cntSombra do legado) + os dois
    * labels sobrepostos (sombra preta + titulo branco - padrao canonico do
    * projeto, regra #11/CLAUDE.md). Width acompanha THIS.Width (legado:
    * cntSombra.Width = SIGOPCFL.Width, ou seja, igual a largura do form).
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarCabecalho()
        LOCAL loc_oErro
        TRY
            THIS.AddObject("cnt_4c_Sombra", "Container")
            WITH THIS.cnt_4c_Sombra
                .Top         = 0
                .Left        = 0
                .Width       = THIS.Width
                .Height      = 80
                .BackStyle   = 1
                .BackColor   = RGB(100, 100, 100)
                .BorderWidth = 0
                .Visible     = .T.
            ENDWITH

            THIS.cnt_4c_Sombra.AddObject("lbl_4c_LblSombra", "Label")
            WITH THIS.cnt_4c_Sombra.lbl_4c_LblSombra
                .FontBold      = .T.
                .FontName      = "Tahoma"
                .FontSize      = 16
                .FontUnderline = .F.
                .WordWrap      = .T.
                .Alignment     = 0
                .BackStyle     = 0
                .AutoSize      = .F.
                .Caption       = THIS.Caption
                .Height        = 40
                .Left          = 10
                .Top           = 15
                .Width         = THIS.Width - 370
                .ForeColor     = RGB(0, 0, 0)
                .Visible       = .T.
            ENDWITH

            THIS.cnt_4c_Sombra.AddObject("lbl_4c_LblTitulo", "Label")
            WITH THIS.cnt_4c_Sombra.lbl_4c_LblTitulo
                .FontBold      = .T.
                .FontName      = "Tahoma"
                .FontSize      = 16
                .FontUnderline = .F.
                .WordWrap      = .T.
                .Alignment     = 0
                .BackStyle     = 0
                .AutoSize      = .F.
                .Caption       = THIS.Caption
                .Height        = 46
                .Left          = 10
                .Top           = 18
                .Width         = THIS.Width - 370
                .ForeColor     = RGB(255, 255, 255)
                .ToolTipText   = "T" + CHR(237) + "tulo"
                .Visible       = .T.
            ENDWITH
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, "Erro em ConfigurarCabecalho")
        ENDTRY
    ENDPROC

    *==========================================================================
    * ConfigurarContainersBase - Cria, vazios, o shape decorativo e os dois
    * containers principais do corpo do form. Posicoes EXATAS do dump
    * (SigOpCfl.SCX) - a area de dados NAO escala com a largura nova do
    * form (1000px), so o cabecalho/botoes usam a largura nova, mesmo
    * padrao do FormSIGOPCFE (ConfigurarGrade).
    *   shp_4c_Shape2    (Shape2)     Top=110/Left=62/W=675/H=403 - moldura
    *                    da area de dados/grade.
    *   cnt_4c_Dadoschq  (cntDadoschq) Top=142/Left=66/W=665/H=34 - filhos
    *                    (Banco/Agencia/Conta/N.Cheque) na Fase 5.
    *   cnt_4c__inserir  (cnt_inserir) Top=284/Left=78/W=640/H=82,
    *                    Visible=.F. - painel flutuante de Incluir/Alterar
    *                    ocorrencia, filhos (Data/Hora+Observacao) na
    *                    Fase 6, toggle de Visible na Fase 7/8.
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarContainersBase()
        LOCAL loc_oErro
        TRY
            THIS.AddObject("shp_4c_Shape2", "Shape")
            WITH THIS.shp_4c_Shape2
                .Top         = 110
                .Left        = 62
                .Width       = 675
                .Height      = 403
                .BackStyle   = 1
                .BackColor   = RGB(255, 255, 255)
                .BorderColor = RGB(90, 90, 90)
                .Visible     = .T.
            ENDWITH

            THIS.AddObject("cnt_4c_Dadoschq", "Container")
            WITH THIS.cnt_4c_Dadoschq
                .Top           = 142
                .Left          = 66
                .Width         = 665
                .Height        = 34
                .BorderWidth   = 1
                .SpecialEffect = 0
                .BackColor     = RGB(255, 255, 255)
                .BorderColor   = RGB(136, 189, 188)
                .Visible       = .T.
            ENDWITH

            *-- cnt_inserir legado: Visible=.F. - so aparece quando o usuario
            *-- clica Incluir/Alterar (regra #40: nasce oculto, toggle no
            *-- funil de eventos, Fase 7/8).
            THIS.AddObject("cnt_4c__inserir", "Container")
            WITH THIS.cnt_4c__inserir
                .Top           = 284
                .Left          = 78
                .Width         = 640
                .Height        = 82
                .BackStyle     = 1
                .BorderWidth   = 1
                .SpecialEffect = 0
                .BackColor     = RGB(255, 255, 255)
                .BorderColor   = RGB(136, 189, 188)
                .Visible       = .F.
            ENDWITH
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, "Erro em ConfigurarContainersBase")
        ENDTRY
    ENDPROC

    *==========================================================================
    * ConfigurarDadosCheque - Cabecalho do cheque consultado. Dois blocos,
    * posicoes EXATAS do dump (SigOpCfl.SCX) - area de dados NAO escala com
    * a largura nova do form (mesmo padrao de ConfigurarContainersBase):
    *   - Emissor (direto no form): lbl_4c_Label1 ("Emissor :") +
    *     txt_4c_Conta (getConta, Iclis) + txt_4c_DConta (getDConta, Rclis).
    *   - Filhos de cnt_4c_Dadoschq (criado em ConfigurarContainersBase):
    *     Banco (lbl_4c_Label13/txt_4c_Bco), Agencia (lbl_4c_Label9/
    *     txt_4c_Agc), Conta (lbl_4c_Label1/txt_4c_Cta) e N.Cheque
    *     (lbl_4c_Label2/txt_4c_Nch).
    * Todos os TextBox sao SOMENTE LEITURA (legado: Enabled=.F. em
    * getConta/getDConta, ReadOnly=.T. em Get_Agc/Get_bco/Get_Cta/Get_Nch) -
    * exibem dados do cheque, nunca editados pelo usuario. MaxLength vem da
    * largura das colunas no schema (regra #19), NUNCA do Width em pixels:
    * SigCdCli.iclis char(10)/rclis char(50); SigChe.bancos char(3)/
    * agencias char(4)/ncontas char(10)/ncheques char(6). Labels sem
    * Width/Alignment no dump (classe say pura) usam .Alignment = 0 +
    * .Width calculada para caber o texto (regra #23) e ForeColor
    * RGB(90,90,90) - o default da classe say sem ForeColor declarado
    * (regra #12). Populados em CarregarCabecalhoCheque().
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarDadosCheque()
        LOCAL loc_oErro
        TRY
            *-- Emissor (direto no form - legado: Say1/getConta/getDConta)
            THIS.AddObject("lbl_4c_Label1", "Label")
            WITH THIS.lbl_4c_Label1
                .FontName  = "Tahoma"
                .FontSize  = 8
                .Alignment = 0
                .BackStyle = 0
                .AutoSize  = .F.
                .Caption   = "Emissor : "
                .Left      = 81
                .Top       = 122
                .Width     = 45
                .Height    = 17
                .ForeColor = RGB(90, 90, 90)
                .Visible   = .T.
            ENDWITH

            THIS.AddObject("txt_4c_Conta", "TextBox")
            WITH THIS.txt_4c_Conta
                .FontName          = "Tahoma"
                .FontSize          = 8
                .Left              = 128
                .Top               = 118
                .Width             = 80
                .Height            = 23
                .MaxLength         = 10
                .Enabled           = .F.
                .ForeColor         = RGB(0, 0, 0)
                .DisabledBackColor = RGB(255, 255, 255)
                .DisabledForeColor = RGB(0, 0, 0)
                .Value             = ""
                .Visible           = .T.
            ENDWITH

            THIS.AddObject("txt_4c_DConta", "TextBox")
            WITH THIS.txt_4c_DConta
                .FontName          = "Tahoma"
                .FontSize          = 8
                .Left              = 209
                .Top               = 118
                .Width             = 360
                .Height            = 23
                .MaxLength         = 50
                .Enabled           = .F.
                .ForeColor         = RGB(0, 0, 0)
                .DisabledBackColor = RGB(255, 255, 255)
                .DisabledForeColor = RGB(0, 0, 0)
                .Value             = ""
                .Visible           = .T.
            ENDWITH

            *-- Filhos de cnt_4c_Dadoschq (legado: Banco/Agencia/Conta/N.Cheque)
            THIS.cnt_4c_Dadoschq.AddObject("lbl_4c_Label13", "Label")
            WITH THIS.cnt_4c_Dadoschq.lbl_4c_Label13
                .FontName  = "Tahoma"
                .FontSize  = 8
                .Alignment = 0
                .BackStyle = 0
                .AutoSize  = .F.
                .Caption   = "Banco:"
                .TabIndex  = 44
                .Left      = 22
                .Top       = 6
                .Width     = 34
                .Height    = 17
                .ForeColor = RGB(90, 90, 90)
                .Visible   = .T.
            ENDWITH

            THIS.cnt_4c_Dadoschq.AddObject("txt_4c_Bco", "TextBox")
            WITH THIS.cnt_4c_Dadoschq.txt_4c_Bco
                .FontName          = "Tahoma"
                .FontSize          = 8
                .Left              = 59
                .TabIndex          = 18
                .Format            = "K!"
                .Top               = 3
                .Width             = 31
                .Height            = 23
                .MaxLength         = 3
                .ReadOnly          = .T.
                .ForeColor         = RGB(0, 0, 0)
                .DisabledBackColor = RGB(255, 255, 255)
                .DisabledForeColor = RGB(0, 0, 0)
                .Value             = ""
                .Visible           = .T.
            ENDWITH

            THIS.cnt_4c_Dadoschq.AddObject("lbl_4c_Label9", "Label")
            WITH THIS.cnt_4c_Dadoschq.lbl_4c_Label9
                .FontName  = "Tahoma"
                .FontSize  = 8
                .Alignment = 0
                .BackStyle = 0
                .AutoSize  = .F.
                .Caption   = "Ag" + CHR(234) + "ncia:"
                .TabIndex  = 45
                .Left      = 107
                .Top       = 6
                .Width     = 44
                .Height    = 17
                .ForeColor = RGB(90, 90, 90)
                .Visible   = .T.
            ENDWITH

            THIS.cnt_4c_Dadoschq.AddObject("txt_4c_Agc", "TextBox")
            WITH THIS.cnt_4c_Dadoschq.txt_4c_Agc
                .FontName          = "Tahoma"
                .FontSize          = 8
                .Left              = 153
                .TabIndex          = 19
                .Format            = "K!"
                .Top               = 3
                .Width             = 38
                .Height            = 23
                .MaxLength         = 4
                .ReadOnly          = .T.
                .ForeColor         = RGB(0, 0, 0)
                .DisabledBackColor = RGB(255, 255, 255)
                .DisabledForeColor = RGB(0, 0, 0)
                .Value             = ""
                .Visible           = .T.
            ENDWITH

            THIS.cnt_4c_Dadoschq.AddObject("lbl_4c_Label1", "Label")
            WITH THIS.cnt_4c_Dadoschq.lbl_4c_Label1
                .FontName  = "Tahoma"
                .FontSize  = 8
                .Alignment = 0
                .BackStyle = 0
                .AutoSize  = .F.
                .Caption   = "Conta:"
                .TabIndex  = 45
                .Left      = 208
                .Top       = 6
                .Width     = 34
                .Height    = 17
                .ForeColor = RGB(90, 90, 90)
                .Visible   = .T.
            ENDWITH

            THIS.cnt_4c_Dadoschq.AddObject("txt_4c_Cta", "TextBox")
            WITH THIS.cnt_4c_Dadoschq.txt_4c_Cta
                .FontName          = "Tahoma"
                .FontSize          = 8
                .Left              = 245
                .TabIndex          = 19
                .Format            = "K!"
                .Top               = 3
                .Width             = 80
                .Height            = 23
                .MaxLength         = 10
                .ReadOnly          = .T.
                .ForeColor         = RGB(0, 0, 0)
                .DisabledBackColor = RGB(255, 255, 255)
                .DisabledForeColor = RGB(0, 0, 0)
                .Value             = ""
                .Visible           = .T.
            ENDWITH

            THIS.cnt_4c_Dadoschq.AddObject("lbl_4c_Label2", "Label")
            WITH THIS.cnt_4c_Dadoschq.lbl_4c_Label2
                .FontName  = "Tahoma"
                .FontSize  = 8
                .Alignment = 0
                .BackStyle = 0
                .AutoSize  = .F.
                .Caption   = "N.Cheque:"
                .TabIndex  = 45
                .Left      = 336
                .Top       = 6
                .Width     = 54
                .Height    = 17
                .ForeColor = RGB(90, 90, 90)
                .Visible   = .T.
            ENDWITH

            THIS.cnt_4c_Dadoschq.AddObject("txt_4c_Nch", "TextBox")
            WITH THIS.cnt_4c_Dadoschq.txt_4c_Nch
                .FontName          = "Tahoma"
                .FontSize          = 8
                .Left              = 392
                .TabIndex          = 19
                .Format            = "K!"
                .Top               = 3
                .Width             = 52
                .Height            = 23
                .MaxLength         = 6
                .ReadOnly          = .T.
                .ForeColor         = RGB(0, 0, 0)
                .DisabledBackColor = RGB(255, 255, 255)
                .DisabledForeColor = RGB(0, 0, 0)
                .Value             = ""
                .Visible           = .T.
            ENDWITH
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, "Erro em ConfigurarDadosCheque")
        ENDTRY
    ENDPROC

    *==========================================================================
    * CarregarCabecalhoCheque - Carrega os dados FIXOS do cheque consultado
    * (Emissor + Banco/Agencia/Conta/N.Cheque). Chamado UMA UNICA VEZ a
    * partir de InicializarForm - o cheque consultado nao muda durante a
    * vida do form (so o historico de followup, na grade, eh recarregado
    * por CarregarLista). Legado (SIGOPCFL.Init):
    *     =ThisForm.Podatamgr.Cursorquery('SigChe','CrTmpChe','Nums',lcNum)
    *     =ThisForm.Podatamgr.Cursorquery('SigCdCli','CrTmpCli','Iclis',CrTmpChe.Iclis)
    *     ThisForm.GetConta.Value  = CrTmpCli.Iclis
    *     ThisForm.GetdConta.Value = CrTmpCli.Rclis
    *     Thisform.CntDadoschq.Get_bco.Value = CrTmpChe.Bancos
    *     Thisform.CntDadoschq.Get_agc.Value = CrTmpChe.agencias
    *     Thisform.CntDadoschq.Get_cta.Value = CrTmpChe.nContas
    *     Thisform.CntDadoschq.Get_Nch.Value = CrTmpChe.nCheques
    * Sem conexao (validacao de UI / modo teste) os campos ficam vazios,
    * sem impedir a abertura do form (mesma guarda de CarregarLista).
    *==========================================================================
    PROCEDURE CarregarCabecalhoCheque()
        LOCAL loc_oBO, loc_oErro

        TRY
            loc_oBO = THIS.this_oBusinessObject

            IF TYPE("gnConnHandle") = "N" AND gnConnHandle > 0 AND ;
               VARTYPE(loc_oBO) = "O" AND !EMPTY(ALLTRIM(THIS.this_cConta))
                *-- As duas consultas moram no BO (PILAR 3). O resultado fica
                *-- nas propriedades auxiliares dele e eh ExibirCabecalhoCheque
                *-- que as leva para a tela.
                IF loc_oBO.CarregarCabecalho(THIS.this_cConta)
                    THIS.ExibirCabecalhoCheque()
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, "Erro em CarregarCabecalhoCheque")
        ENDTRY
    ENDPROC

    *==========================================================================
    * ExibirCabecalhoCheque - Leva as propriedades auxiliares do BO (dados
    * FIXOS do cheque, carregados por SigOpCflBO.CarregarCabecalho) para os
    * seis controles somente-leitura do topo. Espelha, uma a uma, as
    * atribuicoes do Init legado:
    *     ThisForm.GetConta.Value  = CrTmpCli.Iclis
    *     ThisForm.GetdConta.Value = CrTmpCli.Rclis
    *     Thisform.CntDadoschq.Get_bco.Value = CrTmpChe.Bancos
    *     Thisform.CntDadoschq.Get_agc.Value = CrTmpChe.agencias
    *     Thisform.CntDadoschq.Get_cta.Value = CrTmpChe.nContas
    *     Thisform.CntDadoschq.Get_Nch.Value = CrTmpChe.nCheques
    * NAO eh o BOParaForm: este cabecalho nao eh a entidade do BO (SigCheh) e
    * nao muda durante a vida do form - eh carregado UMA vez, de SigChe/
    * SigCdCli. BOParaForm cuida do registro de followup (o painel).
    *==========================================================================
    PROCEDURE ExibirCabecalhoCheque()
        LOCAL loc_oBO, loc_oCnt

        loc_oBO = THIS.this_oBusinessObject

        IF VARTYPE(loc_oBO) = "O"
            THIS.txt_4c_Conta.Value  = loc_oBO.this_cIclis
            THIS.txt_4c_DConta.Value = loc_oBO.this_cRclis

            loc_oCnt = THIS.cnt_4c_Dadoschq
            loc_oCnt.txt_4c_Bco.Value = loc_oBO.this_cBancos
            loc_oCnt.txt_4c_Agc.Value = loc_oBO.this_cAgencias
            loc_oCnt.txt_4c_Cta.Value = loc_oBO.this_cNContas
            loc_oCnt.txt_4c_Nch.Value = loc_oBO.this_cNCheques
        ENDIF
    ENDPROC

    *==========================================================================
    * ConfigurarPainelInserir - Filhos de cnt_4c__inserir (cnt_inserir do
    * legado): painel flutuante de Incluir/Alterar ocorrencia de followup,
    * com os dois campos que o legado le em GetHist.LostFocus (This.Parent.
    * GetData.Value / This.Parent.GetHist.Value). Posicoes EXATAS do dump
    * (SigOpCfl.SCX), relativas ao container (regra #28 - Left/Top sao
    * relativos ao pai, nao ao form).
    *   lbl_4c_Label13 ("Data / Hora :") + txt_4c_Data (GetData)
    *   lbl_4c_Label19 ("Observa" + CHR(231) + CHR(227) + "o :") + txt_4c_Hist (GetHist)
    * txt_4c_Data guarda DATETIME (legado: .Value = DateTime() no Incluir,
    * CrSigCheh.Datas no Alterar - Value inicial {} igual ao this_dDatas
    * do BO). txt_4c_Hist eh CHARACTER (SigCheh.hists char(76) - MaxLength
    * = 76, regra #19/CLAUDE.md; o dump legado nao declara MaxLength
    * nesse controle porque GetHist nao tem ControlSource fixo, mas o
    * destino SQL eh char(76), igual ao LEFT(...,76) de
    * SigOpCflBO.Inserir/Atualizar). Format = "K!"/"K" transcritos
    * literalmente do dump (regra #49/CLAUDE.md).
    * O LostFocus de txt_4c_Hist (GetHist.LostFocus legado) eh ligado aqui
    * por BINDEVENT - eh ELE que grava o followup. O toggle de Visible do
    * container e o preenchimento inicial dos dois campos (Incluir/Alterar)
    * ficam para a Fase 8 (eventos dos botoes de acao).
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPainelInserir()
        LOCAL loc_oErro
        TRY
            THIS.cnt_4c__inserir.AddObject("lbl_4c_Label13", "Label")
            WITH THIS.cnt_4c__inserir.lbl_4c_Label13
                .FontName  = "Tahoma"
                .FontSize  = 8
                .Alignment = 0
                .BackStyle = 0
                .AutoSize  = .F.
                .Caption   = "Data / Hora :"
                .TabIndex  = 44
                .Left      = 21
                .Top       = 19
                .Width     = 64
                .Height    = 17
                .ForeColor = RGB(90, 90, 90)
                .Visible   = .T.
            ENDWITH

            THIS.cnt_4c__inserir.AddObject("txt_4c_Data", "TextBox")
            WITH THIS.cnt_4c__inserir.txt_4c_Data
                .FontName  = "Tahoma"
                .FontSize  = 8
                .Left      = 88
                .Top       = 15
                .Width     = 150
                .Height    = 23
                .MaxLength = 20
                .Format    = "K!"
                .TabIndex  = 20
                .ForeColor = RGB(0, 0, 0)
                .Value     = {}
                .Visible   = .T.
            ENDWITH

            THIS.cnt_4c__inserir.AddObject("lbl_4c_Label19", "Label")
            WITH THIS.cnt_4c__inserir.lbl_4c_Label19
                .FontName  = "Tahoma"
                .FontSize  = 8
                .Alignment = 0
                .BackStyle = 0
                .AutoSize  = .F.
                .Caption   = "Observa" + CHR(231) + CHR(227) + "o :"
                .TabIndex  = 38
                .Left      = 19
                .Top       = 43
                .Width     = 70
                .Height    = 17
                .ForeColor = RGB(90, 90, 90)
                .Visible   = .T.
            ENDWITH

            THIS.cnt_4c__inserir.AddObject("txt_4c_Hist", "TextBox")
            WITH THIS.cnt_4c__inserir.txt_4c_Hist
                .FontName  = "Tahoma"
                .FontSize  = 8
                .Left      = 88
                .Top       = 40
                .Width     = 540
                .Height    = 23
                .MaxLength = 76
                .Format    = "K"
                .TabIndex  = 22
                .ForeColor = RGB(0, 0, 0)
                .Value     = ""
                .Visible   = .T.
            ENDWITH

            *-- GetHist.LostFocus legado: eh ELE que grava o followup (INSERIR
            *-- ou ALTERAR) e fecha o painel. Vai em "LostFocus" mesmo - esse
            *-- eh o evento do legado, nao um lookup travestido (regra #47: o
            *-- defeito seria ligar em "KeyPress" sem testar a tecla). Handler
            *-- PUBLIC e SEM parametro: LostFocus nao passa nenhum (regra #3).
            BINDEVENT(THIS.cnt_4c__inserir.txt_4c_Hist, "LostFocus", ;
                      THIS, "HistoricoLostFocus")
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, "Erro em ConfigurarPainelInserir")
        ENDTRY
    ENDPROC

    *==========================================================================
    * ConfigurarGrid - grd_4c_Dados (gridFollowup do legado): grade de
    * historico de followup do cheque. Posicao EXATA do dump (dentro da
    * moldura shp_4c_Shape2) - area de dados NAO escala com a largura nova
    * do form (mesmo padrao de ConfigurarContainersBase).
    * Liga a grade a um cursor PLACEHOLDER (cursor_4c_Dados) criado aqui -
    * regra #41/CLAUDE.md: Column.ControlSource exige o alias JA existir,
    * senao o Init inteiro estoura "Alias is not found". A ORDEM dos campos
    * eh IDENTICA a SigOpCflBO.CarregarDoCursor (cidchaves, nums, datas,
    * emps, hists, numlotes, autos) - a Fase 7/8 popula este mesmo cursor
    * via SQLEXEC em cursor temporario + ZAP + APPEND FROM DBF().
    * Bloco de configuracao runtime (ColumnCount/RecordSource/ControlSource/
    * Width/Header.Caption, nesta ordem) e o DynamicForeColor (verde para
    * historico automatico) transcritos literalmente do Init legado
    * (With ThisForm.gridFollowup ... SetAll('DynamicForeColor', ...)).
* A celula "Data / Hora" (Column1) recebe a classe
* TextBoxCelulaFollowupCfl_4c via AddObject + CurrentControl + Sparse =
* .F. (regra #18): eh ela que carrega o When e o Valid que o legado tem em
* gridFollowup.Column1.Text1 - BINDEVENT em evento de celula de Grid nao eh
* confiavel (regra #46).
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarGrid()
        LOCAL loc_oErro
        TRY
            IF USED("cursor_4c_Dados")
                USE IN cursor_4c_Dados
            ENDIF
            SET NULL ON
            CREATE CURSOR cursor_4c_Dados ;
                (cidchaves C(20), nums C(8), datas T, emps C(3), hists C(76), numlotes N(8,0), autos L)
            SET NULL OFF

            THIS.AddObject("grd_4c_Dados", "Grid")
            WITH THIS.grd_4c_Dados
                .Top           = 177
                .Left          = 67
                .Width         = 667
                .Height        = 312
                .ReadOnly      = .T.
                .DeleteMark    = .F.
                .RecordMark    = .F.
                .ScrollBars    = 2
                .GridLineColor = RGB(238, 238, 238)
                .TabIndex      = 1
                .BackColor     = RGB(255, 255, 255)
                .Visible       = .T.

                .ColumnCount  = 2
                .RecordSource = "cursor_4c_Dados"

                .Column1.ControlSource = "cursor_4c_Dados.datas"
                .Column2.ControlSource = "cursor_4c_Dados.hists"

                .Column1.Width = 144
                .Column2.Width = 490

                .Column1.Movable   = .F.
                .Column2.Movable   = .F.
                .Column1.Resizable = .F.
                .Column2.Resizable = .F.
                .Column1.ReadOnly  = .T.
                .Column2.ReadOnly  = .T.
                .Column2.InputMask = REPLICATE("X", 76)

                .Column1.FontName = "Courier New"
                .Column2.FontName = "Courier New"

                .Column1.Text1.Alignment   = 3
                .Column1.Text1.BorderStyle = 0
                .Column1.Text1.Margin      = 0
                .Column1.Text1.ReadOnly    = .T.
                .Column1.Text1.ForeColor   = RGB(0, 0, 0)
                .Column1.Text1.BackColor   = RGB(255, 255, 255)

                .Column2.Text1.Margin    = 0
                .Column2.Text1.ReadOnly  = .T.
                .Column2.Text1.ForeColor = RGB(0, 0, 0)
                .Column2.Text1.BackColor = RGB(255, 255, 255)

                .Column1.Header1.Caption   = "Data / Hora"
                .Column1.Header1.Alignment = 2
                .Column1.Header1.FontName  = "Tahoma"
                .Column1.Header1.FontSize  = 8

                .Column2.Header1.Caption   = "Observa" + CHR(231) + CHR(227) + "o"
                .Column2.Header1.Alignment = 2
                .Column2.Header1.FontName  = "Tahoma"
                .Column2.Header1.FontSize  = 8

                .SetAll("DynamicForeColor", ;
                    "IIF(cursor_4c_Dados.autos, RGB(0,128,64), RGB(0,0,0))", "Column")

                *-- Celula "Data / Hora" (Column1): o legado tem When e Valid
                *-- no gridFollowup.Column1.Text1. BINDEVENT em evento de
                *-- celula de Grid nao eh confiavel (regra #46), entao a celula
                *-- eh uma classe com os eventos EMBUTIDOS
                *-- (TextBoxCelulaFollowupCfl_4c, classes\TextBoxGridLookup.prg),
                *-- instalada com AddObject + CurrentControl + Sparse = .F.
                *-- (regra #18 - sem CurrentControl a coluna continua
                *-- desenhando o Text1 dela e os eventos nunca rodam; sem
                *-- Sparse = .F. o controle so aparece na linha ativa).
                .Column1.AddObject("txt_4c_CelulaData", "TextBoxCelulaFollowupCfl_4c")
                .Column1.CurrentControl = "txt_4c_CelulaData"
                .Column1.Sparse         = .F.
            ENDWITH

            *-- Propriedades da celula por caminho EXPLICITO, nao com WITH
            *-- aninhado logo apos o AddObject: dentro de um WITH externo o
            *-- "WITH .filho" relativo falha em SILENCIO no VFP9 e as
            *-- propriedades nao sao aplicadas (Erro47/Erro49). FontName/
            *-- FontSize/Margin/BorderStyle/Alignment/ReadOnly ja sao default
            *-- da classe; aqui ficam as cores e o Visible.
            THIS.grd_4c_Dados.Column1.txt_4c_CelulaData.ForeColor = RGB(0, 0, 0)
            THIS.grd_4c_Dados.Column1.txt_4c_CelulaData.BackColor = RGB(255, 255, 255)
            THIS.grd_4c_Dados.Column1.txt_4c_CelulaData.Visible   = .T.

            WITH THIS.grd_4c_Dados

                *-- Column.ReadOnly reafirmado DEPOIS do Grid.ReadOnly e da
                *-- troca de CurrentControl (regra #18): o ReadOnly do grid
                *-- propaga para as colunas e a grade do legado eh inteiramente
                *-- somente-leitura (dump: gridFollowup.ReadOnly = .T.,
                *-- Column1/Column2.ReadOnly = .T., os dois Text1.ReadOnly =
                *-- .T.). O When existe so para gatear o FOCO da celula.
                .Column1.ReadOnly = .T.
                .Column2.ReadOnly = .T.
            ENDWITH
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, "Erro em ConfigurarGrid")
        ENDTRY
    ENDPROC

    *==========================================================================
    * ConfigurarLegendaAutomatico - Legenda do historico automatico (Say4/
    * Shape1 do legado): quadrado verde + "Lancamento Automatico", com a
    * MESMA cor (RGB(0,128,64)) usada pelo DynamicForeColor da grade
    * (ConfigurarGrid) - o usuario associa a cor do texto na grade a esta
    * legenda, por isso o metodo vem DEPOIS de ConfigurarGrid. Posicoes
    * EXATAS do dump - direto no form, NAO escalam com a largura nova do
    * form (mesmo padrao de ConfigurarContainersBase/ConfigurarDadosCheque).
    * Say4 eh classe "say" mas DECLARA Width=117 no SCX - nao eh o caso
    * generico da regra #23 (label sem Width/Alignment no dump); aqui o
    * Width foi desenhado explicitamente no Form Designer, logo eh
    * transcrito literal com AutoSize = .F. (regra #23: AutoSize=.T. eh
    * no-op em Label criado por AddObject - a Width ficaria no default).
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarLegendaAutomatico()
        LOCAL loc_oErro
        TRY
            THIS.AddObject("shp_4c_Shape1", "Shape")
            WITH THIS.shp_4c_Shape1
                .Top           = 495
                .Left          = 333
                .Width         = 14
                .Height        = 14
                .BackStyle     = 1
                .SpecialEffect = 0
                .BackColor     = RGB(0, 128, 64)
                .Visible       = .T.
            ENDWITH

            THIS.AddObject("lbl_4c_Label4", "Label")
            WITH THIS.lbl_4c_Label4
                .FontName  = "Tahoma"
                .FontSize  = 8
                .Alignment = 0
                .BackStyle = 0
                .AutoSize  = .F.
                .Caption   = "Lan" + CHR(231) + "amento Autom" + CHR(225) + "tico"
                .TabIndex  = 15
                .Left      = 350
                .Top       = 495
                .Width     = 117
                .Height    = 17
                .ForeColor = RGB(90, 90, 90)
                .Visible   = .T.
            ENDWITH
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, "Erro em ConfigurarLegendaAutomatico")
        ENDTRY
    ENDPROC

    *==========================================================================
    * CarregarLista - Popula a grade de historico (followup) do cheque
    * consultado. Legado (SIGOPCFL.Init):
    *     lcQueryCheh = [Select * From SigCheh Where Nums = ?lcNum ]
    *     .AddCursor('SigCheh','CidChaves','CrSigCheh','','',lcQueryCheh)
    *     =ThisForm.Podatamgr.Requery('CrSigCheh')
    *     Select crSigCheH / Go Top
    * Ou seja: o filtro eh SEMPRE aplicado (inclusive com Nums vazio, caso em
    * que a consulta nao casa nada e a grade abre vazia de proposito - regra
    * #35a). O SQLEXEC vai para um cursor TEMPORARIO e o alias da grade eh
    * recarregado com ZAP + APPEND FROM DBF(), para nao derrubar
    * RecordSource/ControlSource/largura das colunas (SQLEXEC sobre o alias
    * ligado ao Grid zera o ColumnCount). Fecha com GO TOP + Refresh, que eh
    * o 'Go Top' + repintura que o legado faz (regra #21a).
    * A lista de colunas do SELECT eh IDENTICA (nome e ordem) a do
    * CREATE CURSOR de ConfigurarGrid - APPEND FROM casa por NOME.
    *==========================================================================
    PROCEDURE CarregarLista()
        LOCAL loc_lSucesso, loc_oBO, loc_oErro
        loc_lSucesso = .F.

        TRY
            IF !USED("cursor_4c_Dados")
                THIS.ConfigurarGrid()
            ENDIF

            IF USED("cursor_4c_DadosTmp")
                USE IN cursor_4c_DadosTmp
            ENDIF

            loc_oBO = THIS.this_oBusinessObject

            *-- Sem conexao (validacao de UI / modo teste) a grade fica vazia,
            *-- mas o cursor e o binding continuam validos.
            IF TYPE("gnConnHandle") = "N" AND gnConnHandle > 0 AND VARTYPE(loc_oBO) = "O"
                *-- A consulta mora no BO (PILAR 3 - o form nao fala com o
                *-- banco). O BO devolve as linhas no cursor TEMPORARIO e o
                *-- alias ligado ao Grid eh recarregado com ZAP + APPEND FROM
                *-- DBF(), que preserva RecordSource/ControlSource/Width das
                *-- colunas e o CurrentControl da celula de data.
                IF loc_oBO.CarregarHistorico(THIS.this_cConta, "cursor_4c_DadosTmp")
                    *-- Esvazia SO depois do SELECT ter dado certo: ZAP antes
                    *-- da consulta deixaria a grade vazia quando o SQL Server
                    *-- recusasse.
                    THIS.EsvaziarCursorDados()
                    APPEND FROM DBF("cursor_4c_DadosTmp")
                    loc_lSucesso = .T.
                ENDIF

                IF USED("cursor_4c_DadosTmp")
                    USE IN cursor_4c_DadosTmp
                ENDIF
            ELSE
                THIS.EsvaziarCursorDados()
                loc_lSucesso = .T.
            ENDIF

            THIS.RepintarGrade()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, "Erro em CarregarLista")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * EsvaziarCursorDados - ZAP no cursor da grade, com SET SAFETY guardado.
    * ZAP (e nao USE IN + CREATE CURSOR) eh a escolha CERTA aqui: eh o
    * 'Zap In <cursor>' do legado Fortyus e preserva a estrutura, o
    * RecordSource/ControlSource do Grid e o CurrentControl da celula de data -
    * fechar e recriar o alias derrubaria o binding e a grade ficaria
    * permanentemente vazia com o cursor cheio.
    * O guard de SAFETY eh obrigatorio porque este form eh DataSession = 2:
    * SET SAFETY eh escopado por sessao de dados e vale ON na sessao privada
    * MESMO com o SET SAFETY OFF do main.prg. Com SAFETY ON o ZAP abre o
    * dialogo modal "Zap ... Are you sure?" e a tela CONGELA esperando um
    * clique que ninguem ve - em teste headless isso aparece como timeout sem
    * erro nenhum, nao como falha.
    * Restaura o valor ANTERIOR em vez de forcar OFF: desligar SAFETY para o
    * resto da vida da sessao tiraria a protecao de outros comandos
    * destrutivos (COPY TO / COPY FILE sobre arquivo existente).
    * Deixa cursor_4c_Dados SELECIONADO na saida - o APPEND FROM de
    * CarregarLista conta com isso (APPEND vai para a area de trabalho
    * CORRENTE, e ZAP IN nao muda a area corrente).
    *==========================================================================
    PROCEDURE EsvaziarCursorDados()
        LOCAL loc_cSafety

        IF USED("cursor_4c_Dados")
            loc_cSafety = SET("SAFETY")
            SET SAFETY OFF

            SELECT cursor_4c_Dados
            ZAP

            IF loc_cSafety = "ON"
                SET SAFETY ON
            ENDIF
        ENDIF
    ENDPROC

    *==========================================================================
    * RepintarGrade - Posiciona no topo e repinta a grade. Metodo UNICO,
    * chamado por TODO caminho que popula cursor_4c_Dados: popular cursor NAO
    * repinta a grade sozinho (regra #21a), e o legado sempre fecha com
    * 'Select crSigCheH / Go Top' + 'ThisForm.gridFollowup.Refresh'.
    *==========================================================================
    PROCEDURE RepintarGrade()
        IF USED("cursor_4c_Dados")
            SELECT cursor_4c_Dados
            GO TOP IN cursor_4c_Dados
        ENDIF

        IF PEMSTATUS(THIS, "grd_4c_Dados", 5)
            THIS.grd_4c_Dados.Refresh()
        ENDIF
    ENDPROC

    *==========================================================================
    * CelulaDataFollowupEditavel - When da celula "Data / Hora" da grade.
    * Legado (SIGOPCFL.gridFollowup.Column1.Text1.When), transcrito:
    *     Return ThisForm.cmdApagaItem.cmdApagar.Visible
    * cmdApagar eh o Buttons(1) de cmg_4c_CmdApagaitem - a ordem de declaracao
    * do legado eh Apagar=1, Listar=2, Incluir=3, Alterar=4 (ver
    * ConfigurarAcoes). Ou seja: a celula so recebe FOCO quando o usuario tem
    * acesso de EXCLUIR; eh esse foco que o Apaga Item devolve para a grade
    * depois de apagar a linha (legado: Column1.Text1.Setfocus).
    * PUBLIC obrigatoriamente: a classe da celula
    * (TextBoxCelulaFollowupCfl_4c) chama THISFORM.<metodo> de FORA da classe
    * do form, e PEMSTATUS(..., 5) devolve .T. mesmo para metodo PROTECTED - o
    * teste passaria e a chamada real estouraria "Property ... is not found"
    * em runtime (regras #3 e #34).
    *==========================================================================
    PROCEDURE CelulaDataFollowupEditavel(par_oTxt)
        LOCAL loc_lEditavel

        *-- Sem o CommandGroup de acoes nao ha como consultar a permissao;
        *-- liberar o foco mantem a grade navegavel (o legado nunca chega
        *-- aqui sem o grupo, criado no Init junto com a grade).
        loc_lEditavel = .T.

        IF PEMSTATUS(THIS, "cmg_4c_CmdApagaitem", 5)
            IF THIS.cmg_4c_CmdApagaitem.ButtonCount >= 1
                loc_lEditavel = THIS.cmg_4c_CmdApagaitem.Buttons(1).Visible
            ENDIF
        ENDIF

        RETURN loc_lEditavel
    ENDPROC

    *==========================================================================
    * ValidarCelulaDataFollowupExec - Valid da celula "Data / Hora" da grade.
    * Legado (SIGOPCFL.gridFollowup.Column1.Text1.Valid), transcrito:
    *     If Empty(this.value)
    *         Messagebox('Data Invalida!',0+64,"Atencao!")
    *         Return 0
    *     Endif
    * O retorno 0 mantem o foco na celula (comportamento do Valid em VFP9).
    * O valor avaliado eh par_oTxt.Value - dentro do Valid o que o usuario
    * digitou AINDA NAO chegou ao cursor, entao ler do cursor validaria o
    * valor ANTERIOR (regra #46).
    * PUBLIC pelo mesmo motivo de CelulaDataFollowupEditavel.
    *==========================================================================
    PROCEDURE ValidarCelulaDataFollowupExec(par_oTxt)
        LOCAL loc_lValido
        loc_lValido = .T.

        IF VARTYPE(par_oTxt) = "O"
            IF EMPTY(par_oTxt.Value)
                MsgAviso("Data Inv" + CHR(225) + "lida!", ;
                         "Aten" + CHR(231) + CHR(227) + "o!")
                loc_lValido = .F.
            ENDIF
        ENDIF

        *-- Devolve 0 (nao .F.) no caminho de recusa: eh o retorno do legado e
        *-- eh o que faz o VFP9 manter o foco na celula.
        RETURN IIF(loc_lValido, .T., 0)
    ENDPROC

    *==========================================================================
    * FormParaBO - Transfere o painel de inclusao/alteracao (cnt_4c__inserir)
    * para as propriedades do BO. Espelha os Replace do GetHist.LostFocus
    * legado:
    *     Nums      With lcConta                 (ThisForm.Conta)
    *     Datas     With This.Parent.GetData.Value
    *     Emps      With _Empr                   -> go_4c_Sistema.cCodEmpresa
    *     CidChaves with pChave                  (fUniqueIds, gerado no BO)
    *     Hists     With This.Parent.GetHist.Value
    * Em ALTERAR o legado regrava SO Hists sobre a linha corrente do cursor,
    * entao a chave vem de cursor_4c_Dados.cidchaves (linha selecionada na
    * grade) e Nums/Datas/Emps/Autos do registro original sao preservados - o
    * UPDATE do BO toca apenas hists.
    * _EMPR eh LEGADO e nunca se usa: a empresa vem de go_4c_Sistema.
    * Devolve .F. (com aviso) quando falta a chave da linha em ALTERAR -
    * gravar sem chave faria um UPDATE sem WHERE valido.
    * PROTECTED EXPLICITO: FormBase ja declara PROTECTED PROCEDURE FormParaBO e
    * em VFP9 a subclasse NAO alarga escopo herdado - omitir o modificador
    * mentiria para quem le (o metodo fica protegido de qualquer jeito) e
    * PEMSTATUS(..., 5) devolveria .T. sem a chamada externa funcionar.
    * Chamado sempre por THIS. de dentro da classe (regra #8).
    *==========================================================================
    PROTECTED PROCEDURE FormParaBO()
        LOCAL loc_oBO, loc_cModo, loc_uData, loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        TRY
            loc_oBO   = THIS.this_oBusinessObject
            loc_cModo = UPPER(ALLTRIM(THIS.this_cModoAtual))

            IF VARTYPE(loc_oBO) = "O"
                *-- Observacao: comum aos dois modos (legado: Replace Hists
                *-- fora do IF de INSERIR). O MaxLength do TextBox e o
                *-- LEFT(..., 76) do BO vem de SigCheh.hists char(76)
                *-- (regra #19).
                loc_oBO.this_cHists = THIS.cnt_4c__inserir.txt_4c_Hist.Value

                IF loc_cModo = "INSERIR"
                    *-- cidchaves fica vazia de proposito: o Inserir() do BO
                    *-- gera a chave com fUniqueIds() - NUNCA string vazia,
                    *-- senao o 2o registro colide no indice unico (regra #22).
                    loc_oBO.this_cCidChaves = ""
                    loc_oBO.this_cNums      = THIS.this_cConta

                    *-- Datas: o botao Incluir enche GetData com DATETIME() e o
                    *-- Alterar com a data da linha, mas o TextBox nasce com
                    *-- .Value = {} (DATE). Normalizar aqui evita entregar DATE
                    *-- onde o destino eh datetime (regra #16).
                    loc_uData = THIS.cnt_4c__inserir.txt_4c_Data.Value
                    DO CASE
                    CASE VARTYPE(loc_uData) = "T"
                        loc_oBO.this_dDatas = loc_uData
                    CASE VARTYPE(loc_uData) = "D"
                        loc_oBO.this_dDatas = DTOT(loc_uData)
                    OTHERWISE
                        *-- Mesmo default do ramo INSERIR do legado
                        *-- (GetData.Value = DateTime()).
                        loc_oBO.this_dDatas = DATETIME()
                    ENDCASE

                    IF VARTYPE(go_4c_Sistema) = "O"
                        loc_oBO.this_cEmps = go_4c_Sistema.cCodEmpresa
                    ELSE
                        loc_oBO.this_cEmps = ""
                    ENDIF

                    loc_oBO.this_nNumlotes = 0
                    loc_oBO.this_lAutos    = .F.

                    loc_lSucesso = .T.
                ELSE
                    *-- ALTERAR: a chave eh a da linha corrente da grade
                    *-- (legado: Replace Hists sobre CrSigCheh posicionado).
                    loc_oBO.this_cCidChaves = ""

                    IF USED("cursor_4c_Dados")
                        IF !EOF("cursor_4c_Dados") AND !BOF("cursor_4c_Dados")
                            loc_oBO.this_cCidChaves = ;
                                ALLTRIM(NVL(cursor_4c_Dados.cidchaves, ""))
                        ENDIF
                    ENDIF

                    IF EMPTY(loc_oBO.this_cCidChaves)
                        MsgAviso("Selecione na grade o hist" + CHR(243) + "rico " + ;
                                 "que deseja alterar.", ;
                                 "Aten" + CHR(231) + CHR(227) + "o")
                    ELSE
                        loc_lSucesso = .T.
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, "Erro em FormParaBO")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * BOParaForm - Caminho inverso de FormParaBO: leva o registro de followup
    * carregado no BO (SigCheh) para os dois campos do painel flutuante.
    * Espelha o que o cmdAlterar.Click legado faz lendo o cursor direto:
    *     ThisForm.cnt_inserir.GetData.Value = CrSigCheh.Datas
    *     ThisForm.cnt_inserir.GetHist.Value = CrSigCheh.Hists
    * Na nova arquitetura a linha selecionada passa pelo BO
    * (CarregarDoCursor) e chega aos controles por aqui - os valores sao os
    * MESMOS, so o caminho respeita as camadas (PILAR 3).
    * Datas normalizado para DATETIME: a coluna eh datetime e o TextBox nasce
    * com .Value = {} (DATE); entregar DATE onde o resto do fluxo espera
    * DATETIME eh o que dispara erro 11 adiante (regra #16).
    * PROTECTED EXPLICITO, pelo mesmo motivo de FormParaBO: FormBase declara
    * PROTECTED PROCEDURE BOParaForm e em VFP9 a subclasse NAO alarga escopo
    * herdado. Chamado sempre por THIS. de dentro da classe (regra #8).
    *==========================================================================
    PROTECTED PROCEDURE BOParaForm()
        LOCAL loc_oBO, loc_oPainel, loc_uData, loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        TRY
            loc_oBO = THIS.this_oBusinessObject

            IF VARTYPE(loc_oBO) = "O"
                loc_oPainel = THIS.cnt_4c__inserir

                loc_uData = loc_oBO.this_dDatas
                DO CASE
                CASE VARTYPE(loc_uData) = "T"
                    loc_oPainel.txt_4c_Data.Value = loc_uData
                CASE VARTYPE(loc_uData) = "D"
                    loc_oPainel.txt_4c_Data.Value = DTOT(loc_uData)
                OTHERWISE
                    loc_oPainel.txt_4c_Data.Value = {}
                ENDCASE

                loc_oPainel.txt_4c_Hist.Value = loc_oBO.this_cHists

                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, "Erro em BOParaForm")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * LimparCampos - Zera os dois campos do painel flutuante. O branco de
    * GetHist eh SPACE(50) porque eh o que o ramo INSERIR do legado escreve
    * (ThisForm.cnt_inserir.GetHist.Value = Space(50)); para EMPTY() e para o
    * SQL Server isso eh equivalente a string vazia, e transcrever o literal
    * do legado custa nada.
    * Limpar ao FECHAR o painel (BtnCancelarClick) eh necessario porque este
    * form, diferente do legado (modal, um registro por vida), nao fecha
    * entre uma operacao e outra: dado residual do followup anterior
    * reapareceria no proximo Incluir (regra #32).
    * PUBLIC: nenhum caller externo hoje, mas eh o nome canonico do projeto e
    * o harness de teste costuma chamar metodos de estado de FORA da classe,
    * onde PROTECTED estoura em runtime mesmo passando no PEMSTATUS (regra #3).
    *==========================================================================
    PROCEDURE LimparCampos()
        IF PEMSTATUS(THIS, "cnt_4c__inserir", 5)
            THIS.cnt_4c__inserir.txt_4c_Data.Value = {}
            THIS.cnt_4c__inserir.txt_4c_Hist.Value = SPACE(50)
        ENDIF
    ENDPROC

    *==========================================================================
    * HabilitarCampos - Libera ou trava os dois campos EDITAVEIS da tela (os
    * do painel flutuante). Os outros seis controles do topo (Emissor e
    * Banco/Agencia/Conta/N.Cheque) nascem somente-leitura no SCX legado e
    * NAO entram aqui - travar ou liberar ja seria mudar o legado.
    * O legado nao desabilita nada: GetData.When e GetHist.When sao apenas
    * um comentario ("*"), e quem impede o acesso eh a VISIBILIDADE do painel
    * - com cnt_inserir oculto os dois campos sao inalcancaveis. Por isso
    * este metodo eh chamado SO pelo funil AjustarBotoesPorModo, com o MESMO
    * valor que decide a visibilidade do painel: painel visivel -> campos
    * liberados. Assim nao existe estado onde o painel aparece com os campos
    * travados, e a travada no fechamento eh invisivel ao usuario (regra #40:
    * quem desabilita tem de reabilitar no funil de volta).
    *==========================================================================
    PROCEDURE HabilitarCampos(par_lHabilitar)
        LOCAL loc_lHabilitar

        loc_lHabilitar = IIF(VARTYPE(par_lHabilitar) = "L", par_lHabilitar, .F.)

        IF PEMSTATUS(THIS, "cnt_4c__inserir", 5)
            THIS.cnt_4c__inserir.txt_4c_Data.ReadOnly = !loc_lHabilitar
            THIS.cnt_4c__inserir.txt_4c_Hist.ReadOnly = !loc_lHabilitar
        ENDIF
    ENDPROC

    *==========================================================================
    * AjustarBotoesPorModo - FUNIL UNICO de estado da tela, derivado de
    * this_cModoAtual (legado: ThisForm.Tipo). Tres coisas, sempre juntas:
    *   1. painel flutuante visivel <=> modo INSERIR/ALTERAR (legado:
    *      cnt_inserir.Visible = .t. nos dois Click, = .f. no LostFocus);
    *   2. campos do painel liberados <=> painel visivel (HabilitarCampos);
    *   3. botoes de acao reempilhados por permissao (AjustarAcoesPorAcesso,
    *      que eh o bloco 'With ThisForm.cmdApagaItem' do Init legado).
    * Existir como FUNIL eh o que impede o defeito classico de modo: quem
    * muda o estado em cada botao, e nao num ponto so, esquece o caminho de
    * VOLTA e deixa a tela travada (regra #40). Todos os caminhos
    * (BtnIncluirClick/BtnAlterarClick/BtnCancelarClick e a montagem inicial,
    * em ConfigurarAcoes) passam por aqui.
    * NENHUM botao eh desabilitado: o legado nao desabilita os botoes de acao
    * enquanto o painel esta aberto, e inventar isso mudaria a UX (PILAR 1).
    * Modo "" (estado inicial e pos-gravacao) e qualquer outro valor que
    * chegue de fora - o harness de teste atribui "VISUALIZAR" direto na
    * property - caem no mesmo ramo: painel fechado, campos travados.
    * PUBLIC: TesteAutomatico.prg chama THIS.oForm.AjustarBotoesPorModo() de
    * FORA da classe, e PEMSTATUS(..., 5) devolve .T. mesmo para metodo
    * PROTECTED - o teste entraria no branch e a chamada estouraria em
    * runtime com "Property ... is not found" (regra #3).
    *==========================================================================
    PROCEDURE AjustarBotoesPorModo()
        LOCAL loc_lEditando, loc_oErro

        TRY
            loc_lEditando = INLIST(UPPER(ALLTRIM(THIS.this_cModoAtual)), "INSERIR", "ALTERAR")

            IF PEMSTATUS(THIS, "cnt_4c__inserir", 5)
                THIS.cnt_4c__inserir.Visible = loc_lEditando
            ENDIF

            THIS.HabilitarCampos(loc_lEditando)

            IF PEMSTATUS(THIS, "cmg_4c_CmdApagaitem", 5)
                THIS.AjustarAcoesPorAcesso()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, "Erro em AjustarBotoesPorModo")
        ENDTRY
    ENDPROC

    *==========================================================================
    * TemLinhaSelecionada - A grade tem linha corrente utilizavel?
    * IFs ANINHADOS de proposito: VFP9 NAO faz short-circuit, entao
    * 'USED(x) OR RECCOUNT(x) = 0' avalia o RECCOUNT mesmo com o alias
    * FECHADO e estoura "Alias is not found" - exatamente o defeito que
    * existia em BtnAlterarClick/BtnExcluirClick antes desta fase.
    *==========================================================================
    PROCEDURE TemLinhaSelecionada()
        LOCAL loc_lTem
        loc_lTem = .F.

        IF USED("cursor_4c_Dados")
            IF RECCOUNT("cursor_4c_Dados") > 0
                IF !EOF("cursor_4c_Dados") AND !BOF("cursor_4c_Dados")
                    loc_lTem = .T.
                ENDIF
            ENDIF
        ENDIF

        RETURN loc_lTem
    ENDPROC

    *==========================================================================
    * FocarCelulaHistorico - Devolve o foco para a celula "Data / Hora" da
    * grade. Legado: 'ThisForm.GridFollowup.Column1.SetFocus' no fim do
    * GetHist.LostFocus e do cmdApagar.Click.
    * O foco so vai quando a celula PODE recebe-lo: o When dela devolve a
    * visibilidade do Apaga Item (CelulaDataFollowupEditavel), e SetFocus em
    * celula cujo When eh .F. falharia; grade vazia tambem nao tem celula
    * para focar. Extraido porque os dois caminhos repetiam o bloco inteiro.
    *==========================================================================
    PROCEDURE FocarCelulaHistorico()
        IF THIS.CelulaDataFollowupEditavel(.NULL.)
            IF THIS.TemLinhaSelecionada()
                THIS.grd_4c_Dados.Column1.SetFocus()
            ENDIF
        ENDIF
    ENDPROC

    *==========================================================================
    * HistoricoLostFocus - Wrapper do GetHist.LostFocus legado, com guarda de
    * reentrancia. O corpo fecha o painel e devolve o foco para a grade, e
    * isso REDISPARA o proprio LostFocus; sem a guarda a gravacao aconteceria
    * duas vezes (regra #47). A flag eh liberada AQUI, no wrapper, e nao no
    * corpo - assim ela nao trava ligada quando o corpo sai por RETURN
    * antecipado, o que mataria a gravacao pelo resto da vida do form.
    * PUBLIC e SEM parametro: LostFocus nao passa nenhum (regra #3).
    *==========================================================================
    PROCEDURE HistoricoLostFocus()
        IF THIS.this_lEmGravacao
            RETURN
        ENDIF

        THIS.this_lEmGravacao = .T.
        THIS.HistoricoLostFocusExec()
        THIS.this_lEmGravacao = .F.
    ENDPROC

    *==========================================================================
    * HistoricoLostFocusExec - Corpo do GetHist.LostFocus legado:
    *     Local lcConta
    *     lcConta = ThisForm.Conta
    *     Select CrSigCheh
    *     If !Empty(This.Value)
    *         If ThisForm.Tipo = 'INSERIR'
    *             pChave = fUniqueIds()
    *             Append Blank
    *             Replace Nums With lcConta, Datas With This.Parent.GetData.Value,;
    *                     Emps With _Empr, CidChaves with pChave
    *         Endif
    *         Replace Hists With This.Parent.GetHist.Value
    *         ThisForm.podatamgr.Update('CrSigCheh')
    *         ThisForm.podatamgr.commit()
    *     Endif
    *     ThisForm.cnt_inserir.Visible = .f.
    *     ThisForm.gridFollowup.Refresh
    *     ThisForm.GridFollowup.Column1.SetFocus
    *
    * Na nova arquitetura o Append/Replace + Update + commit do cursor viram
    * NovoRegistro/EditarRegistro + FormParaBO + Salvar() no BO (INSERT ou
    * UPDATE em SigCheh) e a grade eh RECARREGADA do banco por CarregarLista,
    * em vez de editada no cursor.
    *
    * As TRES ultimas linhas do legado rodam SEMPRE - inclusive com a
    * observacao em branco, caso em que nada eh gravado e o painel so fecha.
    * Por isso ficam FORA do IF de gravacao, igual ao legado.
    *
    * A gravacao exige painel VISIVEL e modo INSERIR/ALTERAR: no legado eh o
    * cmdInserir/cmdAlterar que mostra o painel e define ThisForm.Tipo, e com
    * o painel oculto GetHist nao recebe foco - a visibilidade EH o gate.
    * Salvar() do BusinessBase ja reporta a falha sozinho (regra #20), por
    * isso nao ha ELSE repetindo a mensagem.
    *==========================================================================
    PROCEDURE HistoricoLostFocusExec()
        LOCAL loc_oBO, loc_cModo, loc_cHist, loc_oErro

        TRY
            loc_oBO   = THIS.this_oBusinessObject
            loc_cModo = UPPER(ALLTRIM(THIS.this_cModoAtual))
            loc_cHist = THIS.cnt_4c__inserir.txt_4c_Hist.Value

            IF THIS.cnt_4c__inserir.Visible AND ;
               INLIST(loc_cModo, "INSERIR", "ALTERAR") AND ;
               !EMPTY(loc_cHist) AND VARTYPE(loc_oBO) = "O"

                IF loc_cModo = "INSERIR"
                    *-- NovoRegistro ANTES do FormParaBO: ele chama
                    *-- LimparDados e zeraria o que tivesse sido transferido.
                    loc_oBO.NovoRegistro()
                    IF THIS.FormParaBO()
                        THIS.this_oBusinessObject.Salvar()
                    ENDIF
                ELSE
                    *-- CancelarEdicao normaliza this_lNovoRegistro: se uma
                    *-- inclusao anterior falhou, a flag ficaria ligada e o
                    *-- EditarRegistro recusaria toda alteracao seguinte.
                    loc_oBO.CancelarEdicao()
                    IF THIS.FormParaBO()
                        IF loc_oBO.EditarRegistro()
                            THIS.this_oBusinessObject.Salvar()
                        ENDIF
                    ENDIF
                ENDIF
            ENDIF

            *-- As TRES ultimas linhas do legado (cnt_inserir.Visible = .f. /
            *-- gridFollowup.Refresh / Column1.SetFocus) rodam SEMPRE, mesmo
            *-- sem gravar nada - e sao exatamente o que BtnCancelarClick faz.
            *-- Observacao em branco cai aqui direto: eh o caminho de
            *-- CANCELAMENTO do legado, que nunca teve botao.
            THIS.BtnCancelarClick()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, "Erro em HistoricoLostFocusExec")
        ENDTRY
    ENDPROC

    *==========================================================================
    * ConfigurarAcoes - cmg_4c_CmdApagaitem (cmdApagaitem do legado):
    * CommandGroup com 4 botoes de acao sobre o historico selecionado na
    * grade (Incluir/Alterar/Apagar/Listar). Posicao e Left de cada botao
    * EXATOS do dump (SigOpCfl.SCX) - a ordem de declaracao dos Buttons
    * (Apagar=1, Listar=2, Incluir=3, Alterar=4) NAO eh a ordem visual
    * esquerda-direita (Incluir/Alterar/Apagar/Listar); cada Buttons(N) usa
    * o Left individual do dump, igual ao legado.
    * O reposicionamento dinamico por fChecaAcesso (legado: With
    * ThisForm.cmdApagaItem ... .cmdInserir.Visible = fChecaAcesso(...)) eh
    * feito por AjustarAcoesPorAcesso() (Fase 7/8), chamado ao final deste
    * metodo - junto com o BINDEVENT dos 3 botoes que tem Click no legado
    * (Incluir/Alterar/Apagar; "Listar" nao tem codigo no dump, logo fica
    * sem handler - regra: nunca inventar funcionalidade que o legado nao
    * tem).
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarAcoes()
        LOCAL loc_oErro
        TRY
            THIS.AddObject("cmg_4c_CmdApagaitem", "CommandGroup")
            WITH THIS.cmg_4c_CmdApagaitem
                .ButtonCount   = 4
                .Top           = -1
                .Left          = 420
                .Width         = 310
                .Height        = 85
                .TabIndex      = 2
                .BackStyle     = 0
                .BorderStyle   = 0
                .SpecialEffect = 1
                .BorderColor   = RGB(136, 189, 188)
                .Themes        = .F.
                .Visible       = .T.
            ENDWITH

            *-- Command1 = cmdApagar ("Apaga Item")
            WITH THIS.cmg_4c_CmdApagaitem.Buttons(1)
                .Top             = 5
                .Left            = 155
                .Width           = 75
                .Height          = 75
                .FontBold        = .T.
                .FontItalic      = .T.
                .FontName        = "Comic Sans MS"
                .FontSize        = 8
                .Picture         = gc_4c_CaminhoIcones + "cadastro_excluir_60.jpg"
                .TabIndex        = 2
                .DisabledPicture = gc_4c_CaminhoIcones + "cadastro_excluir_60.jpg"
                .Caption         = "A\<paga Item"
                .ForeColor       = RGB(90, 90, 90)
                .BackColor       = RGB(255, 255, 255)
                .Themes          = .F.
            ENDWITH

            *-- Command2 = cmdListar ("Listar")
            WITH THIS.cmg_4c_CmdApagaitem.Buttons(2)
                .Top             = 5
                .Left            = 230
                .Width           = 75
                .Height          = 75
                .FontBold        = .T.
                .FontItalic      = .T.
                .FontName        = "Comic Sans MS"
                .FontSize        = 8
                .Picture         = gc_4c_CaminhoIcones + "geral_impressora_normal_60.jpg"
                .TabIndex        = 3
                .DisabledPicture = gc_4c_CaminhoIcones + "geral_impressora_normal_60.jpg"
                .Caption         = "\<Listar"
                .ForeColor       = RGB(90, 90, 90)
                .BackColor       = RGB(255, 255, 255)
                .Themes          = .F.
            ENDWITH

            *-- Command3 = cmdInserir ("Incluir")
            WITH THIS.cmg_4c_CmdApagaitem.Buttons(3)
                .Top             = 5
                .Left            = 5
                .Width           = 75
                .Height          = 75
                .FontBold        = .T.
                .FontItalic      = .T.
                .FontName        = "Comic Sans MS"
                .FontSize        = 8
                .Picture         = gc_4c_CaminhoIcones + "cadastro_inserir_60.jpg"
                .DisabledPicture = gc_4c_CaminhoIcones + "cadastro_inserir_60.jpg"
                .Caption         = "\<Incluir"
                .ForeColor       = RGB(90, 90, 90)
                .BackColor       = RGB(255, 255, 255)
                .Themes          = .F.
            ENDWITH

            *-- Command4 = cmdAlterar ("Alterar")
            WITH THIS.cmg_4c_CmdApagaitem.Buttons(4)
                .Top             = 5
                .Left            = 80
                .Width           = 75
                .Height          = 75
                .FontBold        = .T.
                .FontItalic      = .T.
                .FontName        = "Comic Sans MS"
                .FontSize        = 8
                .Picture         = gc_4c_CaminhoIcones + "cadastro_alterar_60.jpg"
                .DisabledPicture = gc_4c_CaminhoIcones + "cadastro_alterar_60.jpg"
                .Caption         = "\<Alterar"
                .ForeColor       = RGB(90, 90, 90)
                .BackColor       = RGB(255, 255, 255)
                .Themes          = .F.
            ENDWITH

            *-- Click dos 3 botoes com codigo no legado (regra #8: sempre
            *-- THIS. de dentro da classe). "Listar" (Buttons(2)) fica sem
            *-- BINDEVENT - o dump nao tem PROCEDURE cmdListar.Click.
            BINDEVENT(THIS.cmg_4c_CmdApagaitem.Buttons(3), "Click", THIS, "BtnIncluirClick")
            BINDEVENT(THIS.cmg_4c_CmdApagaitem.Buttons(4), "Click", THIS, "BtnAlterarClick")
            BINDEVENT(THIS.cmg_4c_CmdApagaitem.Buttons(1), "Click", THIS, "BtnExcluirClick")

            *-- Estado inicial pelo FUNIL, nao direto no AjustarAcoesPorAcesso:
            *-- com this_cModoAtual = "" ele deixa o painel flutuante fechado e
            *-- os campos travados, alem de reempilhar os botoes por permissao.
            *-- cnt_4c__inserir e os dois TextBox dele ja existem neste ponto
            *-- (ConfigurarContainersBase e ConfigurarPainelInserir rodam antes
            *-- de ConfigurarAcoes em ConfigurarPageFrame).
            THIS.AjustarBotoesPorModo()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, "Erro em ConfigurarAcoes")
        ENDTRY
    ENDPROC

    *==========================================================================
    * AjustarAcoesPorAcesso - Reposiciona e mostra/esconde os 4 botoes de acao
    * por permissao. Legado (SIGOPCFL.Init, With ThisForm.cmdApagaItem):
    *     .cmdInserir.Visible = fChecaAcesso('SIGOPCFL','INSERIR')
    *     .cmdAlterar.Visible = fChecaAcesso('SIGOPCFL','ALTERAR')
    *     .cmdApagar.Visible  = fChecaAcesso('SIGOPCFL','EXCLUIR')
    *     .cmdListar.Visible  = fChecaAcesso('SIGOPCFL','LISTAR')
    *     lcPos = 5 / lcLrg = 80  -- reempilha da esquerda, na ordem Incluir/
    *     Alterar/Apagar/Listar, so os VISIVEIS; sem nenhum visivel, o
    *     CommandGroup inteiro fica oculto (.Visible = .f.).
    * fChecaAcesso() (utils/functions.prg) eh stub de compatibilidade e
    * sempre devolve .T. - entao, na pratica, os 4 ficam visiveis e
    * reempilhados em 5/85/165/245 (Width final = 330), que eh o resultado
    * REAL do Init legado em runtime - os valores estaticos do dump (SCX)
    * nunca sao o que o usuario ve, porque este bloco os sobrescreve sempre.
    * WITH .Buttons(N) aninhado em 1 nivel dentro do WITH do CommandGroup eh
    * seguro (regra #38 - so AddObject aninhado quebra, Buttons(N) eh
    * accessor).
    *==========================================================================
    PROTECTED PROCEDURE AjustarAcoesPorAcesso()
        LOCAL loc_nPos, loc_nLrg, loc_oErro

        TRY
            loc_nPos = 5
            loc_nLrg = 80

            WITH THIS.cmg_4c_CmdApagaitem
                .Buttons(3).Visible = fChecaAcesso("SIGOPCFL", "INSERIR")
                .Buttons(4).Visible = fChecaAcesso("SIGOPCFL", "ALTERAR")
                .Buttons(1).Visible = fChecaAcesso("SIGOPCFL", "EXCLUIR")
                .Buttons(2).Visible = fChecaAcesso("SIGOPCFL", "LISTAR")

                IF .Buttons(3).Visible
                    .Buttons(3).Left = loc_nPos
                    loc_nPos = loc_nPos + loc_nLrg
                ENDIF
                IF .Buttons(4).Visible
                    .Buttons(4).Left = loc_nPos
                    loc_nPos = loc_nPos + loc_nLrg
                ENDIF
                IF .Buttons(1).Visible
                    .Buttons(1).Left = loc_nPos
                    loc_nPos = loc_nPos + loc_nLrg
                ENDIF
                IF .Buttons(2).Visible
                    .Buttons(2).Left = loc_nPos
                    loc_nPos = loc_nPos + loc_nLrg
                ENDIF

                IF loc_nPos > 5
                    .Width = loc_nPos + 5
                    .Refresh()
                ELSE
                    .Visible = .F.
                ENDIF
            ENDWITH
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, "Erro em AjustarAcoesPorAcesso")
        ENDTRY
    ENDPROC

    *==========================================================================
    * ConfigurarSaida - cmg_4c_Commandgroup1 (Commandgroup1 do legado):
    * CommandGroup com 1 botao (Encerrar). Reposicionado flush-a-direita
    * com a largura nova do form (legado: Left=723 num form de 800px, ou
    * seja, a ~3px da borda direita - em 1000px o equivalente e Left =
    * THIS.Width - 85 = 915, mesmo padrao do cmd_4c_Saida do FormSIGOPCFE).
    * Evento (legado: Commandgroup1.Command1.Valid -> ThisForm.Release) eh
    * ligado aqui via Click - mesmo padrao do projeto para botao avulso em
    * CommandGroup (ver o CommandGroup de sair do FormCliente e a barra de
    * botoes do FormGr1).
    *
    * NAO citar aqui o nome do CommandGroup de barra de botoes dos forms
    * REPORT: a heuristica "arquivo tem <aquele nome> em algum lugar" do
    * CorretorAutomatico (patterns #103/#168 e o de WordWrap) nao distingue
    * COMENTARIO de codigo. Com o nome escrito num comentario, este form
    * OPERACIONAL era classificado como REPORT e o corretor injetava
    * HeaderHeight = 0 na grade - o que ESCONDE os cabecalhos
    * "Data / Hora" e "Observacao" que o legado mostra.
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarSaida()
        LOCAL loc_oErro
        TRY
            THIS.AddObject("cmg_4c_Commandgroup1", "CommandGroup")
            WITH THIS.cmg_4c_Commandgroup1
                .ButtonCount  = 1
                .Top          = 3
                .Left         = THIS.Width - 85
                .Width        = 80
                .Height       = 80
                .BackStyle    = 0
                .BorderStyle  = 0
                .SpecialEffect = 1
                .BackColor    = RGB(255, 255, 255)
                .BorderColor  = RGB(136, 189, 188)
                .TabIndex     = 2
                .Themes       = .F.
                .Visible      = .T.
            ENDWITH

            WITH THIS.cmg_4c_Commandgroup1.Buttons(1)
                .Top        = 1
                .Left       = 2
                .Width      = 75
                .Height     = 75
                .FontBold   = .T.
                .FontItalic = .T.
                .FontName   = "Comic Sans MS"
                .FontSize   = 8
                .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
                .DisabledPicture = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
                .Caption    = "Encerrar"
                .Cancel     = .T.
                .ForeColor  = RGB(90, 90, 90)
                .BackColor  = RGB(255, 255, 255)
                .Themes     = .F.
            ENDWITH

            BINDEVENT(THIS.cmg_4c_Commandgroup1.Buttons(1), "Click", THIS, "BtnEncerrarClick")
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, "Erro em ConfigurarSaida")
        ENDTRY
    ENDPROC

    *==========================================================================
    * BtnIncluirClick - cmdInserir.Click (Buttons(3) de cmg_4c_CmdApagaitem).
    * Legado (SIGOPCFL.cmdApagaitem.cmdInserir.Click), transcrito:
    *     ThisForm.Tipo = 'INSERIR'
    *     ThisForm.cnt_inserir.Visible = .t.
    *     ThisForm.cnt_inserir.GetData.Value = DateTime()
    *     ThisForm.cnt_inserir.GetHist.Value = Space(50)
    *     ThisForm.cnt_inserir.Refresh
    *     ThisForm.cnt_inserir.GetData.SetFocus
    * A gravacao de fato so acontece no LostFocus de txt_4c_Hist
    * (HistoricoLostFocus, Fase 6) - este botao so abre o painel com os
    * defaults do ramo INSERIR. PUBLIC: ligado por BINDEVENT (regra #3).
    *==========================================================================
    PROCEDURE BtnIncluirClick()
        *-- Sem cheque nao ha followup: SigCheh.nums eh char(8) NOT NULL e
        *-- aponta para SigChe.nums. A tela so chega sem cheque quando eh
        *-- aberta sem par_cConta (o legado tolera: 'If Type(pConta)#"C"'),
        *-- e nesse estado o Incluir gravaria um followup ORFAO. Recusar
        *-- aqui, antes de abrir o painel, eh mais claro do que abrir e so
        *-- avisar depois (regra #50). O BO repete a regra em ValidarDados
        *-- (fonte unica), este guard so evita a ida e volta.
        IF EMPTY(ALLTRIM(THIS.this_cConta))
            MsgAviso("Cheque n" + CHR(227) + "o informado - abra o FollowUp a " + ;
                     "partir de um cheque.", "Aten" + CHR(231) + CHR(227) + "o")
        ELSE
            *-- Legado (cmdInserir.Click): Tipo = 'INSERIR' / cnt_inserir
            *-- visivel / GetData = DateTime() / GetHist = Space(50) /
            *-- Refresh / GetData.SetFocus.
            THIS.this_cModoAtual = "INSERIR"

            THIS.LimparCampos()
            THIS.cnt_4c__inserir.txt_4c_Data.Value = DATETIME()

            *-- Abre o painel e libera os campos pelo funil de modo (regra #40)
            THIS.AjustarBotoesPorModo()

            THIS.cnt_4c__inserir.Refresh()
            THIS.cnt_4c__inserir.txt_4c_Data.SetFocus()
        ENDIF
    ENDPROC

    *==========================================================================
    * BtnAlterarClick - cmdAlterar.Click (Buttons(4) de cmg_4c_CmdApagaitem).
    * Legado (SIGOPCFL.cmdApagaitem.cmdAlterar.Click), transcrito:
    *     ThisForm.Tipo = 'ALTERAR'
    *     ThisForm.cnt_inserir.Visible = .t.
    *     ThisForm.cnt_inserir.GetData.Value = CrSigCheh.Datas
    *     ThisForm.cnt_inserir.GetHist.Value = CrSigCheh.Hists
    *     ThisForm.cnt_inserir.Refresh
    *     ThisForm.cnt_inserir.GetData.SetFocus
    * O legado le CrSigCheh (linha corrente da grade) sem guarda - aqui a
    * guarda contra grade vazia/sem selecao eh necessaria (cursor_4c_Dados
    * sem linha corrente): sem ela o painel abriria com Data/Hist em branco
    * e a alteracao, no LostFocus, cairia no aviso de FormParaBO ("Selecione
    * na grade..."). Evitar abrir o painel sem o que precisa eh mais claro
    * para o usuario do que abrir e so avisar depois (regra #50).
    *==========================================================================
    PROCEDURE BtnAlterarClick()
        LOCAL loc_oBO

        IF !THIS.TemLinhaSelecionada()
            MsgAviso("Selecione na grade o hist" + CHR(243) + "rico que deseja alterar.", ;
                     "Aten" + CHR(231) + CHR(227) + "o")
        ELSE
            *-- A linha selecionada passa pelo BO e chega aos campos por
            *-- BOParaForm - os valores sao os mesmos que o legado le direto
            *-- do cursor (CrSigCheh.Datas/Hists), so o caminho respeita as
            *-- camadas (PILAR 3).
            *-- CancelarEdicao ANTES de CarregarDoCursor normaliza
            *-- this_lNovoRegistro: se um Incluir anterior falhou ao salvar, a
            *-- flag ficaria ligada e o EditarRegistro do LostFocus recusaria
            *-- esta alteracao (regra #32 - o form nao fecha entre operacoes).
            loc_oBO = THIS.this_oBusinessObject
            IF VARTYPE(loc_oBO) = "O"
                loc_oBO.CancelarEdicao()
                loc_oBO.CarregarDoCursor("cursor_4c_Dados")
            ENDIF

            THIS.this_cModoAtual = "ALTERAR"

            THIS.LimparCampos()
            THIS.BOParaForm()

            *-- Abre o painel e libera os campos pelo funil de modo (regra #40)
            THIS.AjustarBotoesPorModo()

            THIS.cnt_4c__inserir.Refresh()
            THIS.cnt_4c__inserir.txt_4c_Data.SetFocus()
        ENDIF
    ENDPROC

    *==========================================================================
    * BtnCancelarClick - Fecha o painel de Incluir/Alterar SEM gravar e
    * devolve a tela ao estado de consulta. Eh o caminho de CANCELAMENTO que
    * o legado tem (observacao em branco no GetHist.LostFocus: o IF de
    * gravacao nao entra e as tres ultimas linhas rodam de qualquer jeito) -
    * NENHUM botao novo foi desenhado na tela, o legado nao tem um e inventar
    * violaria o PILAR 1. Legado, literal:
    *     ThisForm.cnt_inserir.Visible = .f.
    *     ThisForm.gridFollowup.Refresh
    *     ThisForm.GridFollowup.Column1.SetFocus
    * Chamado pelo proprio HistoricoLostFocusExec (nos dois ramos, com e sem
    * gravacao) e disponivel ao harness de teste, que chama
    * THIS.oForm.BtnCancelarClick() de FORA da classe - por isso PUBLIC
    * (regra #3).
    * GUARDA DE REENTRANCIA em save/restore, nao set/clear: fechar o painel
    * tira o foco de txt_4c_Hist e REDISPARA o LostFocus dele, que voltaria
    * aqui; e quando a chamada vem de dentro de HistoricoLostFocusExec a flag
    * JA esta ligada - um clear simples a liberaria cedo demais e deixaria a
    * segunda passagem acontecer (regra #47).
    *==========================================================================
    PROCEDURE BtnCancelarClick()
        LOCAL loc_lEmGravacaoAnt

        loc_lEmGravacaoAnt    = THIS.this_lEmGravacao
        THIS.this_lEmGravacao = .T.

        *-- O modo volta a "" porque este form, diferente do legado (modal,
        *-- um registro por vida), nao fecha entre uma operacao e outra: modo
        *-- residual faria um LostFocus solto regravar (regra #32).
        THIS.this_cModoAtual = ""
        THIS.LimparCampos()

        *-- Fecha o painel e trava os campos pelo funil de modo (regra #40)
        THIS.AjustarBotoesPorModo()

        *-- Legado: gridFollowup.Refresh. Recarrega do banco porque a gravacao
        *-- (quando houve) foi INSERT/UPDATE em SigCheh, nao edicao de cursor.
        *-- CarregarLista fecha chamando RepintarGrade (GO TOP + Refresh -
        *-- regra #21a).
        THIS.CarregarLista()

        *-- Legado: GridFollowup.Column1.SetFocus
        THIS.FocarCelulaHistorico()

        THIS.this_lEmGravacao = loc_lEmGravacaoAnt
    ENDPROC

    *==========================================================================
    * BtnExcluirClick - cmdApagar.Click (Buttons(1) de cmg_4c_CmdApagaitem).
    * Legado (SIGOPCFL.cmdApagaitem.cmdApagar.Click):
    *     Select CrSigCheh
    *     If !Eof()
    *         If !CrSigCheH.Autos .or. IsEmpty(CrSigCheh.Hists) Or IsEmpty(CrSigCheh.Datas)
    *             pchave = CrSigCheh.CidChaves
    *             lcDelete = [ Delete From SigCheh Where CidChaves = ']+pChave+[']
    *             lnErro = ThisForm.poDatamgr.SqlExecute(lcDelete,'')
    *             If lnErro > 0
    *                 ThisForm.poDatamgr.Commit() / Select CrSigCheh / Delete / Skip / Skip -1
    *             Else
    *                 MessageBox('Favor Reiniciar o Processo !!!',0+48,'Falha na Conexao')
    *             Endif
    *         Else
    *             MessageBox('Historico automatico !!!',0+48,'Impossivel Excluir')
    *         EndIf
    *     Endif
    *     Select CrSigCheH / Thisform.GridFollowUp.Refresh / Column1.Text1.Setfocus
    * A guarda Autos/Hists/Datas e a mensagem "Historico automatico!!!" ja
    * estao em SigOpCflBO.ExecutarExclusao() (Fase 2) - aqui so carrega a
    * linha selecionada no BO e delega para Excluir() (PUBLIC - regra #51,
    * NUNCA chamar ExecutarExclusao de fora do BO). CancelarEdicao() ANTES
    * de CarregarDoCursor normaliza this_lNovoRegistro: se um Incluir
    * anterior tivesse falhado ao salvar, a flag ficaria em .T. e Excluir()
    * recusaria com "Nao ha registro para excluir" mesmo com uma linha
    * valida selecionada (regra #32 - form nao fecha entre operacoes).
    *==========================================================================
    PROCEDURE BtnExcluirClick()
        LOCAL loc_oBO

        *-- Legado: 'Select CrSigCheh / If !Eof()' - sem linha corrente o
        *-- Click nao faz nada (nem avisa). TemLinhaSelecionada usa IFs
        *-- aninhados porque VFP9 nao faz short-circuit.
        IF THIS.TemLinhaSelecionada()
            loc_oBO = THIS.this_oBusinessObject
            IF VARTYPE(loc_oBO) = "O"
                loc_oBO.CancelarEdicao()
                loc_oBO.CarregarDoCursor("cursor_4c_Dados")
                THIS.this_oBusinessObject.Excluir()
            ENDIF

            *-- Legado: Select CrSigCheH / gridFollowup.Refresh /
            *-- Column1.Text1.Setfocus - sempre, mesmo quando o BO recusou a
            *-- exclusao (ja avisou na MsgAviso do ExecutarExclusao).
            THIS.CarregarLista()
            THIS.FocarCelulaHistorico()
        ENDIF
    ENDPROC

    *==========================================================================
    * BtnEncerrarClick - Commandgroup1.Command1.Valid do legado:
    *     ThisForm.Release
    * PUBLIC: ligado por BINDEVENT em ConfigurarSaida (regra #3).
    *==========================================================================
    PROCEDURE BtnEncerrarClick()
        THIS.Release()
    ENDPROC

    *==========================================================================
    * TornarControlesVisiveis - AddObject cria filhos com Visible=.F.; forca
    * Visible=.T. recursivamente, EXCETO cnt_4c__inserir, que nasce oculto
    * de proposito (painel flutuante de Incluir/Alterar - regra #40).
    *==========================================================================
    PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
        LOCAL loc_nI, loc_oControl

        FOR loc_nI = 1 TO par_oContainer.ControlCount
            loc_oControl = par_oContainer.Controls(loc_nI)

            IF VARTYPE(loc_oControl) = "O"
                IF UPPER(loc_oControl.Name) = "CNT_4C__INSERIR"
                    *-- O container nasce oculto de proposito, mas os FILHOS
                    *-- dele precisam de Visible=.T. - senao, quando o botao
                    *-- Incluir/Alterar tornar o painel visivel, ele aparece
                    *-- VAZIO (pattern #109).
                    IF PEMSTATUS(loc_oControl, "ControlCount", 5) AND loc_oControl.ControlCount > 0
                        THIS.TornarControlesVisiveis(loc_oControl)
                    ENDIF
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

    *==========================================================================
    * Destroy - libera os cursores da tela antes de encadear para
    * FormBase.Destroy():
    *   cursor_4c_Dados    - placeholder da grade (criado em ConfigurarGrid)
    *   cursor_4c_DadosTmp - temporario de CarregarLista (fechado la, repetido
    *                        aqui para o caso de o metodo ter saido pelo CATCH)
    *   cursor_4c_CflChe   - temporarios de SigOpCflBO.CarregarCabecalho, que
    *   cursor_4c_CflCli     os fecha sozinho; mesma razao do anterior
    * SEM TABLEREVERT: todos nascem com Buffering = 1 (CREATE CURSOR e cursor
    * de SQLEXEC), onde TABLEREVERT estoura erro 1586, e USE IN fecha o alias
    * de qualquer jeito (regra #52).
    * DODEFAULT() eh a ULTIMA linha: eh FormBase.Destroy que reconstroi os
    * popups do menu principal - sem ele os menus aparecem encolhidos.
    *==========================================================================
    PROCEDURE Destroy()
        IF USED("cursor_4c_Dados")
            USE IN cursor_4c_Dados
        ENDIF
        IF USED("cursor_4c_DadosTmp")
            USE IN cursor_4c_DadosTmp
        ENDIF
        IF USED("cursor_4c_CflChe")
            USE IN cursor_4c_CflChe
        ENDIF
        IF USED("cursor_4c_CflCli")
            USE IN cursor_4c_CflCli
        ENDIF
        DODEFAULT()
    ENDPROC

ENDDEFINE

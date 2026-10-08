*==============================================================================
* FormSigPrIct.prg - Integracao Contabil
*
* Origem legado: SIGPRICT.SCX (task625)
* Herda de: FormBase
* Tipo: OPERACIONAL - form PLANO sem PageFrame (layout.json: cntSombra,
*       Get_DataI/Get_DataF, labels e os dois CommandGroup sao todos filhos
*       DIRETOS de SIGPRICT - nao ha Pagina.Lista/Pagina.Dados). Tela de
*       FILTRO + PROCESSAMENTO: recebe um periodo (Data Inicial/Data Final),
*       concilia o movimento financeiro do periodo contra o plano de contas
*       (SigPrIctBO.Processar, ja completo nas Fases 1/2) e grava arquivo(s)
*       texto no diretorio contabil configurado em SigCdPam.DirContabv.
*
* BO: SigPrIctBO (sem tabela/registro proprio - processo gera arquivo texto,
*     nao grava em tabela - ver nota de arquitetura no cabecalho do BO)
*
* Estrutura visual (SigPrIct_form_codigo_fonte.txt, SECAO 2):
*   cntSombra (cabecalho cinza, Top=0 Left=0 Width=800 Height=80)
*     lblSombra / lblTitulo (Caption dinamico = THIS.Caption, igual FormSigPrGf1)
*   Label2 "Inicial :" (Top=108 Left=186) / Get_DataI (Top=105 Left=227)
*   Label3 "Final :"   (Top=141 Left=191) / Get_DataF (Top=137 Left=227)
*   Label1 " Periodo "  (Top=141 Left=132) - visivel
*   Label4 " Periodo "  (Top=108 Left=132, Visible=.F. no proprio SCX - mantido
*                        oculto por fidelidade, PILAR 1 nao exige reativar o
*                        que o legado ja desativou)
*   cntBotoes (Top=-7 Left=558 Width=252 Height=96, Visible=.F. no Init) ->
*     btnReport (CommandGroup, 3 botoes: Imprimir/Sair/Visualizar - aparece
*     SOMENTE apos o processamento, equivalente ao toggle de Visible no
*     Init/Procedure do legado)
*   btnReport (CommandGroup direto no form, Top=90 Left=316, 2 botoes:
*     Processar/Encerrar - visivel desde o Init, eh o disparo do
*     processamento)
*
* Criado em: Fase 3 - Estrutura Base (DEFINE CLASS, Init, InicializarForm,
*            cabecalho). Containers de botoes criados VAZIOS (posicao/
*            visibilidade do dump), sem os CommandGroup internos.
*
* Fase 4 (esta) - ConfigurarBotoesReport() monta o CommandGroup
*            obj_4c_CmdGReport dentro de cnt_4c_Botoes (3 botoes:
*            Imprimir/Encerrar/Visualizar, posicoes RELATIVAS ao container -
*            no legado o CommandGroup ja era filho direto de cntBotoes,
*            entao os Left/Top do dump sao usados sem ajuste) e
*            ConfigurarBotoesAcao() monta obj_4c_CmdGProcessar dentro de
*            cnt_4c_BotoesAcao (2 botoes: Processar/Encerrar). ATENCAO: no
*            legado esse 2o CommandGroup era filho DIRETO de SIGPRICT
*            (Top=90 Left=316); a Fase 3 criou cnt_4c_BotoesAcao EXATAMENTE
*            nesse retangulo (Top=90 Left=316 Width=160 Height=85), logo o
*            CommandGroup dentro dele usa Top=0/Left=0 (preenche o
*            container) - os Left/Top de cada botao MEMBRO (Command1/
*            Command2) continuam os do dump, pois sao relativos ao proprio
*            grupo e nao ao form. So estrutura visual, sem BINDEVENT ainda.
*
* Roteiro das proximas fases (documentado aqui para nao divergir depois):
*   Fase 5 (esta, PARTE 1/2) - ConfigurarFiltroPeriodo() com a linha "Data
*            Inicial": lbl_4c_Label2 ("Inicial : ") + txt_4c_DataI
*            (Get_DataI) + lbl_4c_Label4 (duplicata " Periodo " oculta no
*            proprio SCX, mantida Visible=.F.)
*   Fase 6 (PARTE 2/2) - mesmo metodo, linha "Data Final": lbl_4c_Label3
*            ("Final : ") + txt_4c_DataF (Get_DataF) + lbl_4c_Label1
*            (" Periodo " visivel) + FormParaBO/BOParaForm do par de datas +
*            BINDEVENT de KeyPress dos dois TextBox (padrao
*            FormSigPrGf1.ConfigurarFiltroPeriodo) + ValidarPeriodo(), a
*            regra dos tres guards que o Click do btnReport legado aplica
*            SOBRE esses dois campos (eles sao os unicos digitaveis do SCX
*            e nao tem Valid proprio, entao a validacao deles eh entrega
*            DESTA fase - ver comentario do metodo)
*   Fase 7/8 (esta) - eventos dos dois CommandGroup:
*            obj_4c_CmdGProcessar: BtnProcessarClick (ValidarPeriodo() +
*              confirma + this_oBusinessObject.Processar() + AposProcessar(),
*              que mostra o grupo obj_4c_CmdGReport quando ha inconsistencia
*              ou grava o arquivo direto quando nao ha) / BtnEncerrarClick
*              (fecha o form).
*            obj_4c_CmdGReport: BtnImprimirClick/BtnVisualizarClick (monta os
*              cursores de nome literal "SemConta"/"Cabecalho" que o
*              SigPrIct.frx exige - PrepararCursoresRelatorio() - executa o
*              REPORT FORM via ExecutarReportForm() e grava o arquivo em
*              seguida) / BtnEncerrarReportClick (grava o arquivo e fecha,
*              reproduzindo o Click do botao MAIS o Click do grupo do
*              legado - ver comentario do metodo).
*            GravarArquivoContabil() reproduz a parte de UI do PROCEDURE
*              gravar legado (a parte de negocio mora no BO,
*              GravarArquivosContabeis - Fase 2).
*
*   Fase 8 (esta) - eventos AUXILIARES e consolidacao. O que faltava era UM
*            passo de UI do PROCEDURE processamento legado, perdido na
*            migracao: o dialogo das DIFERENCAS e o despacho para a tela
*            SigReDif. O BO ja calculava this_lPossuiDiferenca/
*            this_nTotalDiferencas (VerificarDiferencas) e ja expunha
*            ObterCursorDiferencas()/ObterCursorMovimento() - e NENHUM ponto
*            do Form consumia os quatro, superficie de BO morta sendo o
*            proprio sintoma. Entregas:
*              ExibirDiferencas()           - "If Reccount() > 0 And
*                Messagebox('Visualizar as diferencas na Tela?',4+32,
*                'Visualizar') = 6 / Do Form SigReDif With
*                Thisform.DataSessionId", chamado no INICIO de
*                AposProcessar() porque no legado ele vem ANTES do ramo
*                SemConta. Monta os alias de contrato que
*                SigReDifBO.PrepararDados exige por nome LITERAL (movaux e
*                dif2) e abre FormSigReDif(THIS.DataSessionId) com o Show()
*                FORA do TRY (regra #29, form modal).
*              LiberarCursoresDiferencas()  - fecha movaux/dif2/crGrid; usado
*                antes de montar, depois do Show() e em Destroy().
*
* NAO possui CarregarLista()/AjustarBotoesPorModo()/HabilitarCampos()/
* LimparCampos()/BtnSalvarClick()/BtnCancelarClick()/BtnBuscarClick(): o
* dump legado nao tem lista, nao tem grade, nao tem os modos LISTA/INCLUIR/
* ALTERAR/VISUALIZAR e nao grava registro em tabela nenhuma (mesma decisao
* de projeto registrada em FormSigPrGf1 - criar esses metodos aqui produziria
* casca vazia sem correspondente no legado, que a regra de completude
* proibe).
*==============================================================================

DEFINE CLASS FormSigPrIct AS FormBase

    *-- Propriedades visuais (pixel-perfect do SCX original - PILAR 1)
    *-- SIGPRICT.SCX: Width=800, Height=192 (SECAO 2) - dialogo de
    *-- filtro/processamento, sem necessidade de escalar para o canonico
    *-- 1000x600 (esse canonico vale para forms CRUD frmcadastro).
    Width        = 800
    Height       = 192
    AutoCenter   = .T.
    Caption      = "Integra" + CHR(231) + CHR(227) + "o Cont" + CHR(225) + "bil"
    ShowWindow   = 1
    WindowType   = 1
    ControlBox   = .F.
    Closable     = .F.
    MaxButton    = .F.
    MinButton    = .F.
    TitleBar     = 0
    BorderStyle  = 2
    ClipControls = .F.

    *-- DataSession = 2 transcrito do SCX ("DataSession = 2" nas PROPRIEDADES
    *-- DE SIGPRICT). Isola os cursores desta tela (cursor_4c_MovAux,
    *-- cursor_4c_Grupos, cursor_4c_SemConta, etc. - todos criados pelo BO em
    *-- PrepararCursoresProcesso) da sessao compartilhada de outras telas.
    DataSession  = 2

    *-- Guarda de reentrancia do botao Processar (Fase 7/8). O BO exibe
    *-- fwprogressbar durante ConciliarMovimento(), e cada Update()/Refresh()
    *-- devolve a vez ao VFP: sem este guard um segundo clique em Processar
    *-- entraria em BtnProcessarClick com o primeiro processamento ainda
    *-- rodando, disputando os mesmos cursores (cursor_4c_MovAux/SemConta/...).
    this_lProcessando = .F.

    *-- WindowType = 1 eh canonico do projeto, NAO transcricao: o SCX herda o
    *-- default 0 (modeless) do baseclass form, mas o menu.prg abre a tela com
    *-- CREATEOBJECT + variavel LOCAL + Show(), e com modeless o Show()
    *-- retorna na hora, a LOCAL sai de escopo e o form eh destruido (pisca e
    *-- some) - mesmo raciocinio de FormSigPrGf1.

    *==========================================================================
    * Init - Sem parametros recebidos do chamador (form aberto direto pelo
    * menu, popMovimentos). DODEFAULT() encadeia para FormBase.Init(), que
    *==========================================================================
    PROCEDURE Init()
        RETURN DODEFAULT()
    ENDPROC

    *==========================================================================
    * InicializarForm - Instancia o BO e monta a estrutura visual (cabecalho
    * + os dois containers de botoes, cada um com seu CommandGroup interno -
    * ConfigurarBotoesReport/ConfigurarBotoesAcao, Fase 4).
    *==========================================================================
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        TRY
            THIS.this_oBusinessObject = CREATEOBJECT("SigPrIctBO")

            IF VARTYPE(THIS.this_oBusinessObject) = "O"
                THIS.Picture = gc_4c_CaminhoIcones + "fundo_cadastro.jpg"

                THIS.ConfigurarPageFrame()

                THIS.cnt_4c_Sombra.lbl_4c_LblSombra.Caption = THIS.Caption
                THIS.cnt_4c_Sombra.lbl_4c_LblTitulo.Caption = THIS.Caption

                THIS.TornarControlesVisiveis(THIS)
                THIS.Visible = .T.

                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao criar SigPrIctBO. VARTYPE retornou: " + ;
                    VARTYPE(THIS.this_oBusinessObject), "FormSigPrIct.InicializarForm")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro em FormSigPrIct.InicializarForm")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * ConfigurarPageFrame - Orquestrador de montagem visual. SIGPRICT nao tem
    * PageFrame no legado (layout flat) - o nome do metodo eh mantido apenas
    * como ponto de entrada arquitetural padrao (mesmo papel em
    * FormSigPrGf1/FormFop/FormEnd).
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPageFrame()
        THIS.ConfigurarCabecalho()
        THIS.ConfigurarContainerBotoesReport()
        THIS.ConfigurarContainerBotoesAcao()
        THIS.ConfigurarFiltroPeriodo()

        *-- Reposicionamento do Init legado - so passa a importar a partir
        *-- desta fase, que implementa o show/hide de cnt_4c_Botoes (Fase 7/8):
        *--     .cntBotoes.Top  = ThisForm.btnReport.Top  + 60
        *--     .cntBotoes.Left = ThisForm.btnReport.Left - 69
        *-- "ThisForm.btnReport" (o CommandGroup Processar/Encerrar) eh
        *-- THIS.cnt_4c_BotoesAcao aqui (o container ocupa o MESMO retangulo
        *-- do CommandGroup legado - ver ConfigurarContainerBotoesAcao).
        *-- cnt_4c_Botoes continua Visible = .F.; isto so prepara a posicao de
        *-- repouso para quando AposProcessar() o mostrar.
        THIS.cnt_4c_Botoes.Top  = THIS.cnt_4c_BotoesAcao.Top  + 60
        THIS.cnt_4c_Botoes.Left = THIS.cnt_4c_BotoesAcao.Left - 69
    ENDPROC

    *==========================================================================
    * ConfigurarCabecalho - Container cinza escuro com titulo do form.
    * Original: cntSombra Top=0, Left=0, Width=800, Height=80,
    * BackColor=RGB(100,100,100) (SECAO 2) - copiado sem escala, pois
    * THIS.Width ja eh 800 (identico ao legado).
    *
    * lblSombra/lblTitulo no dump trazem Caption="Cadastro de Testes" (texto
    * generico de template, nao atualizado pelo legado para este form
    * especifico) - por isso, igual a FormSigPrGf1, o Caption real eh
    * atribuido em runtime a partir de THIS.Caption (InicializarForm), nunca
    * o literal do dump.
    *==========================================================================
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
                .Top           = 0
                .Width         = 769
                .ForeColor     = RGB(0, 0, 0)
                .Visible       = .T.
            ENDWITH

            loc_oCnt.AddObject("lbl_4c_LblTitulo", "Label")
            WITH loc_oCnt.lbl_4c_LblTitulo
                .FontBold   = .T.
                .FontName   = "Tahoma"
                .FontSize   = 18
                .WordWrap   = .T.
                .Alignment  = 0
                .BackStyle  = 0
                .AutoSize   = .F.
                .Caption    = THIS.Caption
                .Height     = 46
                .Left       = 10
                .Top        = 3
                .Width      = 769
                .ForeColor  = RGB(255, 255, 255)
                .Visible    = .T.
            ENDWITH
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro em ConfigurarCabecalho")
        ENDTRY
    ENDPROC

    *==========================================================================
    * ConfigurarContainerBotoesReport - Container equivalente ao cntBotoes
    * legado (Top=-7, Left=558, Width=252, Height=96, BackStyle=0,
    * BorderWidth=0, Visible=.F. - SECAO 2). No legado ele hospeda o
    * CommandGroup btnReport (3 botoes: Imprimir/Sair/Visualizar), que so
    * aparece DEPOIS do processamento (Procedure Gravar faz
    * ThisForm.cntBotoes.Visible = .t. - essa troca de Visible fica para a
    * Fase 7/8, junto com BtnProcessarClick). Aqui (Fase 4) o container
    * continua Visible=.F. e ganha o CommandGroup obj_4c_CmdGReport, ja
    * configurado por dentro.
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarContainerBotoesReport()
        LOCAL loc_oErro

        TRY
            THIS.AddObject("cnt_4c_Botoes", "Container")
            WITH THIS.cnt_4c_Botoes
                .Top         = -7
                .Left        =  542
                .Width       = 252
                .Height      = 96
                .BackStyle   = 0
                .BorderWidth = 0
                .Visible     = .F.
            ENDWITH

            THIS.ConfigurarBotoesReport()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro em ConfigurarContainerBotoesReport")
        ENDTRY
    ENDPROC

    *==========================================================================
    * ConfigurarBotoesReport - CommandGroup obj_4c_CmdGReport, filho de
    * cnt_4c_Botoes. Transcrito de SIGPRICT.cntBotoes.btnReport (SECAO 2):
    * ButtonCount=3, AutoSize=.T., BackStyle=0, BorderStyle=0,
    * SpecialEffect=1, BorderColor=RGB(136,189,188), Height=85, Left=12,
    * Top=5, Width=235. Left/Top sao RELATIVOS a cnt_4c_Botoes (no legado o
    * CommandGroup ja era filho direto do container) - nao ha offset a
    * aplicar. Icones de vbmp\ via gc_4c_CaminhoIcones (regra #25 - nomes
    * EXATOS do dump, nunca inventados).
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarBotoesReport()
        WITH THIS.cnt_4c_Botoes
            .AddObject("obj_4c_CmdGReport", "CommandGroup")
            .Visible     = .T.
        ENDWITH

        WITH THIS.cnt_4c_Botoes.obj_4c_CmdGReport
            .ButtonCount   = 3
            .AutoSize      = .T.
            .BackStyle     = 0
            .BorderStyle   = 0
            .SpecialEffect = 1
            .BorderColor   = RGB(136, 189, 188)
            .Top           = 5
            .Left          = 12
            .Width         = 235
            .Height        = 85
            .Value         = 1

            WITH .Buttons(1)
                .Top            = 5
                .Left           = 80
                .Width          = 75
                .Height         = 75
                .FontName       = "Tahoma"
                .FontSize       = 8
                .FontBold       = .T.
                .FontItalic     = .T.
                .WordWrap       = .T.
                .PicturePosition = 13
                .Picture        = gc_4c_CaminhoIcones + "relatorio_impressora_26.jpg"
                .Caption        = "\<Impressora"
                .ForeColor      = RGB(90, 90, 90)
                .BackColor      = RGB(255, 255, 255)
                .Themes         = .F.
            ENDWITH

            WITH .Buttons(2)
                .Top        = 5
                .Left       = 155
                .Width      = 75
                .Height     = 75
                .FontName   = "Comic Sans MS"
                .FontSize   = 8
                .FontBold   = .T.
                .FontItalic = .T.
                .WordWrap   = .T.
                .Picture    = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
                .Cancel     = .T.
                .Caption    = "\<Encerrar"
                .ForeColor  = RGB(90, 90, 90)
                .BackColor  = RGB(255, 255, 255)
                .Themes     = .F.
            ENDWITH

            WITH .Buttons(3)
                .Top            = 5
                .Left           = 5
                .Width          = 75
                .Height         = 75
                .FontName       = "Tahoma"
                .FontSize       = 8
                .FontBold       = .T.
                .FontItalic     = .T.
                .WordWrap       = .T.
                .PicturePosition = 13
                .Picture        = gc_4c_CaminhoIcones + "relatorio_video_26.jpg"
                .Caption        = " \<Video    "
                .ForeColor      = RGB(90, 90, 90)
                .BackColor      = RGB(255, 255, 255)
                .Themes         = .F.
            ENDWITH
        ENDWITH

        *-- Eventos (Fase 7/8) - um handler por botao, igual ao dump legado
        *-- (Command1/btnImprimir, Command2/btnSair, Command3/btnVisualizar
        *-- tem Click PROPRIO, diferente um do outro).
        BINDEVENT(THIS.cnt_4c_Botoes.obj_4c_CmdGReport.Buttons(1), "Click", THIS, "BtnImprimirClick")
        BINDEVENT(THIS.cnt_4c_Botoes.obj_4c_CmdGReport.Buttons(2), "Click", THIS, "BtnEncerrarReportClick")
        BINDEVENT(THIS.cnt_4c_Botoes.obj_4c_CmdGReport.Buttons(3), "Click", THIS, "BtnVisualizarClick")
    ENDPROC

    *==========================================================================
    * ConfigurarContainerBotoesAcao - No legado, o segundo CommandGroup
    * btnReport (2 botoes: Processar/Encerrar, Top=90 Left=316 Width=160
    * Height=85 - SECAO 2) eh filho DIRETO de SIGPRICT, sem container
    * proprio. Aqui ele ganha um container fino (cnt_4c_BotoesAcao) na MESMA
    * posicao/tamanho do CommandGroup legado, para manter o padrao do
    * projeto de "um container por grupo de botoes".
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarContainerBotoesAcao()
        LOCAL loc_oErro

        TRY
            THIS.AddObject("cnt_4c_BotoesAcao", "Container")
            WITH THIS.cnt_4c_BotoesAcao
                .Top         = 90
                .Left        = 316
                .Width       = 160
                .Height      = 85
                .BackStyle   = 0
                .BorderWidth = 0
                .Visible     = .T.
            ENDWITH

            THIS.ConfigurarBotoesAcao()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro em ConfigurarContainerBotoesAcao")
        ENDTRY
    ENDPROC

    *==========================================================================
    * ConfigurarBotoesAcao - CommandGroup obj_4c_CmdGProcessar, filho de
    * cnt_4c_BotoesAcao. Transcrito de SIGPRICT.btnReport (SECAO 2):
    * ButtonCount=2, AutoSize=.T., BackStyle=0, BorderStyle=0,
    * SpecialEffect=1, BorderColor=RGB(136,189,188), Width=160, Height=85.
    * No legado esse CommandGroup era filho DIRETO do form (Top=90
    * Left=316); como cnt_4c_BotoesAcao foi criado EXATAMENTE nesse
    * retangulo (ConfigurarContainerBotoesAcao), o grupo aqui usa Top=0/
    * Left=0 para preencher o container - os Left/Top de Buttons(1)/
    * Buttons(2) sao relativos ao GRUPO (nao ao form) e continuam os do
    * dump, sem ajuste.
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarBotoesAcao()
        WITH THIS.cnt_4c_BotoesAcao
            .AddObject("obj_4c_CmdGProcessar", "CommandGroup")
            .Visible     = .T.
        ENDWITH

        WITH THIS.cnt_4c_BotoesAcao.obj_4c_CmdGProcessar
            .ButtonCount   = 2
            .AutoSize      = .T.
            .BackStyle     = 0
            .BorderStyle   = 0
            .SpecialEffect = 1
            .BorderColor   = RGB(136, 189, 188)
            .Top           = 0
            .Left          = 0
            .Width         = 160
            .Height        = 85
            .Value         = 1

            WITH .Buttons(1)
                .Top        = 5
                .Left       = 5
                .Width      = 75
                .Height     = 75
                .FontName   = "Tahoma"
                .FontSize   = 8
                .FontBold   = .T.
                .FontItalic = .T.
                .WordWrap   = .T.
                .Picture    = gc_4c_CaminhoIcones + "geral_processar_60.jpg"
                .Caption    = "\<Processar"
                .ForeColor  = RGB(90, 90, 90)
                .BackColor  = RGB(255, 255, 255)
                .Themes     = .F.
            ENDWITH

            WITH .Buttons(2)
                .Top        = 5
                .Left       = 80
                .Width      = 75
                .Height     = 75
                .FontName   = "Tahoma"
                .FontSize   = 8
                .FontBold   = .T.
                .FontItalic = .T.
                .WordWrap   = .T.
                .Picture    = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
                .Cancel     = .T.
                .Caption    = "Encerrar"
                .ForeColor  = RGB(90, 90, 90)
                .BackColor  = RGB(255, 255, 255)
                .Themes     = .F.
            ENDWITH
        ENDWITH

        *-- Eventos (Fase 7/8)
        BINDEVENT(THIS.cnt_4c_BotoesAcao.obj_4c_CmdGProcessar.Buttons(1), "Click", THIS, "BtnProcessarClick")
        BINDEVENT(THIS.cnt_4c_BotoesAcao.obj_4c_CmdGProcessar.Buttons(2), "Click", THIS, "BtnEncerrarClick")
    ENDPROC

    *==========================================================================
    * ConfigurarFiltroPeriodo - Campos de filtro de periodo (Fase 5/8 - PARTE
    * 1/2). Filhos DIRETOS de THIS (SIGPRICT e form PLANO, sem PageFrame -
    * layout.json confirma parent="SIGPRICT" para os quatro objetos desta
    * linha e da linha irma).
    *
    * PARTE 1 (esta fase) - linha "Data Inicial" (Top original 105/108),
    * dump SECAO 2:
    *   Label2    Top=108 Left=186 Width=39 Caption="Inicial : " -> lbl_4c_Label2
    *   Get_DataI Top=105 Left=227 TabIndex=1 (fweditdata)       -> txt_4c_DataI
    *   Label4    Top=108 Left=132 Width=51 Caption=" Per" + CHR(237) + "odo "
    *             Visible=.F. NO PROPRIO SCX (duplicata oculta do Label1 da
    *             linha "Data Final") -> lbl_4c_Label4, MANTIDO OCULTO por
    *             fidelidade (regra do projeto: nao reativar o que o legado ja
    *             desativou). TornarControlesVisiveis tem excecao explicita
    *             para este nome (ver abaixo), senao o laco forcaria
    *             Visible=.T. e o duplicado apareceria sobre a linha errada.
    *
    * PARTE 2 (Fase 6, esta) - linha "Data Final" (Label3/Get_DataF) +
    * Label1 (" Periodo " visivel, irmao do Label4 oculto desta parte) +
    * FormParaBO/BOParaForm do par de datas + BINDEVENT de KeyPress dos dois
    * TextBox - igual ao padrao de FormSigPrGf1.ConfigurarFiltroPeriodo
    * (operacoes/FormSigPrGf1.prg), citado nesta mesma funcao.
    *
    * Label3 "Final : " (Top=141 Left=191 Width=34) e Label1 " Periodo "
    * (Top=141 Left=132 Width=51, Visible=.T. no dump - irmao visivel do
    * Label4 oculto da linha "Data Inicial") sao transcritos da SECAO 2.
    * txt_4c_DataF usa o MESMO Width/Height/Alignment/InputMask/Format de
    * txt_4c_DataI (fweditdata, mesma analogia de FormSigPrGf1 - nao vem no
    * dump porque a classe eh do framework.vcx, nao extraido).
    *
    * BO (SigPrIctBO) ja expoe this_dDataI/this_dDataF (Init os preenche com
    * DATE()/DATE() - CLAUDE.md regra #16: ConverterParaData() em vez de
    * TTOD(), porque o .Value do TextBox pode chegar como DATE/DATETIME/CHAR
    * conforme o caminho). FormParaBO/BOParaForm sao a UNICA via de leitura/
    * escrita dessas properties - ValidarPeriodo() (abaixo, desta fase) e
    * Processar() (Fase 7/8) leem exclusivamente do BO, nunca do TextBox
    * direto (PILAR 3: fonte unica da regra); quem espelha a tela no BO
    * antes de validar eh o proprio ValidarPeriodo().
    *
    * Width/Height de txt_4c_DataI (79x25), Alignment=3, InputMask="99/99/9999"
    * e Format="K" nao vem do dump (fweditdata herda do framework.vcx, que nao
    * foi extraido) - transcritos por analogia de FormSigPrGf1, que usa a
    * MESMA classe fweditdata para o mesmo papel (par de datas de filtro de
    * periodo em form OPERACIONAL flat). .Value = {} (DATE) e nao {^1900-01-01}
    * -  TextBox nasce vazio, igual ao Get_DataI legado antes do Init popular
    * (regra ConverterParaData/TTOD-so-aceita-DATETIME sera aplicada na Fase 6,
    * quando FormParaBO/BOParaForm lerem/gravarem a property do BO).
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarFiltroPeriodo()
        LOCAL loc_oErro

        TRY
            THIS.AddObject("lbl_4c_Label2", "Label")
            WITH THIS.lbl_4c_Label2
                .Top       = 108
                .Left      = 186
                .Width     = 39
                .Height    = 15
                .FontName  = "Tahoma"
                .FontSize  = 8
                .BackStyle = 0
                .Alignment = 0
                .AutoSize  = .F.
                .ForeColor = RGB(90, 90, 90)
                .Caption   = "Inicial : "
                .Visible   = .T.
            ENDWITH

            THIS.AddObject("txt_4c_DataI", "TextBox")
            WITH THIS.txt_4c_DataI
                .Top       = 105
                .Left      = 227
                .Width     = 79
                .Height    = 25
                .FontName  = "Tahoma"
                .FontSize  = 8
                .TabIndex  = 1
                .Alignment = 3
                .Themes    = .F.
                .InputMask = "99/99/9999"
                .Format    = "K"
                .Value     = {}
                .Visible   = .T.
            ENDWITH

            *-- Label4: duplicata de " Periodo " oculta no proprio SCX legado
            *-- (Visible=.F. - SECAO 2). Criado aqui so para paridade de
            *-- objetos (PILAR 2/3 nao exige objeto a mais, mas a regra do
            *-- projeto de nao reativar o que o legado desativou vale tambem
            *-- no sentido inverso: o objeto existe no dump, entao existe no
            *-- migrado, so que permanece oculto).
            THIS.AddObject("lbl_4c_Label4", "Label")
            WITH THIS.lbl_4c_Label4
                .Top       = 108
                .Left      = 132
                .Width     = 51
                .Height    = 15
                .FontName  = "Tahoma"
                .FontSize  = 8
                .FontBold  = .T.
                .BackStyle = 0
                .Alignment = 0
                .AutoSize  = .F.
                .ForeColor = RGB(90, 90, 90)
                .Caption   = " Per" + CHR(237) + "odo "
                .Visible   = .F.
            ENDWITH

            *-- Linha "Data Final" (Fase 6 - PARTE 2/2)
            THIS.AddObject("lbl_4c_Label3", "Label")
            WITH THIS.lbl_4c_Label3
                .Top       = 141
                .Left      = 191
                .Width     = 34
                .Height    = 15
                .FontName  = "Tahoma"
                .FontSize  = 8
                .BackStyle = 0
                .Alignment = 0
                .AutoSize  = .F.
                .ForeColor = RGB(90, 90, 90)
                .Caption   = "Final : "
                .Visible   = .T.
            ENDWITH

            THIS.AddObject("txt_4c_DataF", "TextBox")
            WITH THIS.txt_4c_DataF
                .Top       = 137
                .Left      = 227
                .Width     = 79
                .Height    = 25
                .FontName  = "Tahoma"
                .FontSize  = 8
                .TabIndex  = 2
                .Alignment = 3
                .Themes    = .F.
                .InputMask = "99/99/9999"
                .Format    = "K"
                .Value     = {}
                .Visible   = .T.
            ENDWITH

            *-- Label1: " Periodo " - irmao VISIVEL do Label4 oculto da linha
            *-- "Data Inicial" (ver comentario do metodo). Visible=.T. no
            *-- proprio dump (SECAO 2 nao declara Visible = .F. para ele).
            THIS.AddObject("lbl_4c_Label1", "Label")
            WITH THIS.lbl_4c_Label1
                .Top       = 141
                .Left      = 132
                .Width     = 51
                .Height    = 15
                .FontName  = "Tahoma"
                .FontSize  = 8
                .FontBold  = .T.
                .BackStyle = 0
                .Alignment = 0
                .AutoSize  = .F.
                .ForeColor = RGB(90, 90, 90)
                .Caption   = " Per" + CHR(237) + "odo "
                .Visible   = .T.
            ENDWITH

            *-- Carga inicial dos dois campos a partir do BO (Init do
            *-- SigPrIctBO preenche this_dDataI/this_dDataF com DATE()/DATE(),
            *-- equivalente a "Get_Datai.Value = Date() / Get_Dataf.Value =
            *-- Date()" do Init legado). O .Value = {} acima eh so para o
            *-- controle nascer tipado DATE antes do BOParaForm preencher.
            THIS.BOParaForm()

            *-- Eventos dos campos de periodo. BINDEVENT em "KeyPress" (nunca
            *-- "Valid", que nao dispara de forma confiavel em TextBox, nem
            *-- "LostFocus", que dispara tambem quando outro controle recebe o
            *-- foco). Os handlers apenas SINCRONIZAM o valor digitado com as
            *-- properties do BO - o legado tambem nao valida campo a campo
            *-- (nem Get_DataI nem Get_DataF tem Valid no SCX; os tres guards
            *-- do periodo rodam de uma vez em THIS.ValidarPeriodo(), que a
            *-- Fase 7/8 chama do Click do botao Processar, igual ao legado).
            BINDEVENT(THIS.txt_4c_DataI, "KeyPress", THIS, "DataIKeyPress")
            BINDEVENT(THIS.txt_4c_DataF, "KeyPress", THIS, "DataFKeyPress")
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro em ConfigurarFiltroPeriodo")
        ENDTRY
    ENDPROC

    *==========================================================================
    * DataIKeyPress / DataFKeyPress - handlers de KeyPress dos dois campos de
    * periodo, ligados por BINDEVENT (logo PUBLIC - metodo PROTECTED falha em
    * silencio, CLAUDE.md regra #3). LPARAMETERS obrigatorio: sem ele o VFP9
    * estoura "No PARAMETER statement is found" na primeira tecla digitada.
    *
    * Nao validam nem exibem mensagem - o legado nao tem Valid em Get_DataI
    * nem Get_DataF, e antecipar a mensagem aqui divergiria do PILAR 1 (ao
    * sair da Data Inicial com a Final ainda vazia o usuario receberia "Data
    * Final Invalida!!!" que o legado nunca exibe nesse momento). Ao
    * confirmar o campo (ENTER/TAB) so espelham o valor nas properties do
    * BO, que eh de onde ValidarPeriodo() e Processar() leem o periodo.
    *==========================================================================
    PROCEDURE DataIKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 13 OR par_nKeyCode = 9
            THIS.FormParaBO()
        ENDIF
    ENDPROC

    PROCEDURE DataFKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 13 OR par_nKeyCode = 9
            THIS.FormParaBO()
        ENDIF
    ENDPROC

    *==========================================================================
    * FormParaBO - transporta o par de datas da TELA para this_dDataI/
    * this_dDataF no BO. Este form tem exatamente DOIS campos editaveis (o
    * periodo de processamento), logo o FormParaBO cobre os dois e nada mais.
    *
    * ConverterParaData() em vez de TTOD(): o .Value nasce DATE (BOParaForm o
    * preenche a partir do BO) mas pode chegar como DATETIME ou CHAR conforme
    * o que o usuario digitar - TTOD() com DATE dispara erro 11 em runtime
    * (CLAUDE.md regra #16).
    *
    * PROTECTED explicito: FormBase declara "PROTECTED PROCEDURE FormParaBO()"
    * / "PROTECTED PROCEDURE BOParaForm()", e em VFP9 redeclarar na subclasse
    * SEM o modificador NAO alarga o escopo herdado (mesma armadilha da regra
    * do metodo PROTECTED/BINDEVENT). Nao ha perda: os dois sao chamados so
    * de dentro da classe (ConfigurarFiltroPeriodo, DataIKeyPress,
    * DataFKeyPress), e nenhum deles esta na lista de metodos que o
    * TesteAutomatico.prg invoca de fora.
    *==========================================================================
    PROTECTED PROCEDURE FormParaBO()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        IF VARTYPE(THIS.this_oBusinessObject) = "O"
            THIS.this_oBusinessObject.this_dDataI = ;
                ConverterParaData(THIS.txt_4c_DataI.Value)
            THIS.this_oBusinessObject.this_dDataF = ;
                ConverterParaData(THIS.txt_4c_DataF.Value)
            loc_lSucesso = .T.
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * BOParaForm - caminho inverso: joga this_dDataI/this_dDataF do BO nos
    * dois campos. Usado na carga inicial (ConfigurarFiltroPeriodo), onde o
    * periodo default eh a data de hoje nos dois campos (SigPrIctBO.Init
    * espelhando "Get_Datai.Value = Date() / Get_Dataf.Value = Date()" do
    * Init legado). O Form NAO recalcula - le do BO (PILAR 3: fonte unica).
    *
    * PROTECTED pelo mesmo motivo do FormParaBO acima.
    *==========================================================================
    PROTECTED PROCEDURE BOParaForm()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        IF VARTYPE(THIS.this_oBusinessObject) = "O"
            THIS.txt_4c_DataI.Value = ;
                ConverterParaData(THIS.this_oBusinessObject.this_dDataI)
            THIS.txt_4c_DataF.Value = ;
                ConverterParaData(THIS.this_oBusinessObject.this_dDataF)
            loc_lSucesso = .T.
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * ValidarPeriodo - TRANSCRICAO dos tres guards que o legado escreveu no
    * Click do btnReport (SigPrIct_form_codigo_fonte.txt: SIGPRICT.btnReport
    * PROCEDURE Click, e o Click identico de SIGPRICT.cntBotoes.btnReport):
    *
    *     If Empty(ThisForm.Get_DataI.value)
    *         Messagebox('Data Inicial Invalida!!!',0+48,'')
    *         ThisForm.Get_DataI.SetFocus
    *         Return 0
    *     Endif
    *     If Empty(ThisForm.Get_DataF.value)
    *         Messagebox('Data Final Invalida!!!',0+48,'')
    *         ThisForm.Get_DataF.SetFocus
    *         Return 0
    *     Endif
    *     If ThisForm.Get_DataF.value < ThisForm.Get_DataI.value
    *         Messagebox('A Data Final Nao Pode Ser Menor Que a Inicial!!!', 0+48, '')
    *         ThisForm.Get_DataF.SetFocus
    *         Return 0
    *     Endif
    *
    * Esta eh a regra dos DOIS campos digitaveis que esta fase entrega:
    * Get_DataI/Get_DataF sao os UNICOS controles de entrada do SCX (SECAO 2
    * lista 2 textbox, 6 label e 2 commandgroup) e o dump NAO tem Valid, When
    * nem LostFocus em nenhum dos dois - toda a validacao do periodo mora no
    * Click do botao. Por isso o metodo nasce JUNTO com os campos, e nao na
    * fase dos botoes: a Fase 7/8 apenas CHAMA
    * (BtnProcessarClick -> IF !THIS.ValidarPeriodo() / RETURN), sem
    * reescrever a regra.
    *
    * A regra em si vive no BO (SigPrIctBO.ValidarPeriodo, Fase 2), que ja
    * carrega os tres testes na MESMA ordem e as tres mensagens EXATAS do
    * legado em this_cMensagemErro - fonte unica (PILAR 3). O Form faz as
    * tres coisas que o BO nao pode fazer: espelhar a tela nas properties,
    * exibir a mensagem e devolver o foco ao campo recusado.
    *
    * FormParaBO() ANTES de validar: no legado os tres guards leem
    * "ThisForm.Get_DataI.value" / "Get_DataF.value", isto eh, o TEXTBOX eh a
    * fonte do valor - nunca a property guardada de um estado anterior (regra
    * do textbox visivel como fonte unica). Sem este espelho, limpar o campo
    * na tela e acionar Processar validaria o periodo ANTIGO, que o usuario
    * acabou de apagar.
    *
    * MsgAviso (nao MsgErro): os tres casos sao validacao de UI, e o legado
    * usa Messagebox(..., 0+48, ...) - icone de aviso. Chamado SEM titulo, o
    * MsgAviso usa "Atencao", equivalente ao titulo vazio do legado.
    *
    * SetFocus espelhando o legado: o 1o guard devolve o foco a Data Inicial;
    * o 2o e o 3o devolvem a Data Final. Como o BO testa a Data Inicial
    * primeiro, "Data Inicial vazia" eh o UNICO caso em que txt_4c_DataI
    * esta vazio - dai o IF EMPTY() reproduzir exatamente os tres destinos.
    *
    * PUBLIC (sem PROTECTED): sera chamado de FORA da classe pelos handlers
    * de botao da Fase 7/8 e pelo harness de teste; metodo PROTECTED falha em
    * silencio nesse uso (CLAUDE.md regra #3), e PEMSTATUS nao protege porque
    * so verifica existencia, nao escopo.
    *
    * RETURN unico, DEPOIS do ENDTRY (CLAUDE.md regra #1 - RETURN dentro de
    * TRY/CATCH eh proibido, inclusive o bare).
    *==========================================================================
    PROCEDURE ValidarPeriodo()
        LOCAL loc_lValido, loc_oErro
        loc_lValido = .F.

        TRY
            IF VARTYPE(THIS.this_oBusinessObject) = "O"
                *-- Tela -> BO: o TextBox eh a fonte do valor, igual ao legado
                THIS.FormParaBO()

                IF THIS.this_oBusinessObject.ValidarPeriodo()
                    loc_lValido = .T.
                ELSE
                    *-- Mensagem EXATA do legado, montada pelo BO
                    MsgAviso(THIS.this_oBusinessObject.this_cMensagemErro)

                    IF EMPTY(THIS.txt_4c_DataI.Value)
                        THIS.txt_4c_DataI.SetFocus()
                    ELSE
                        THIS.txt_4c_DataF.SetFocus()
                    ENDIF
                ENDIF
            ELSE
                MsgErro("Objeto de neg" + CHR(243) + "cio n" + CHR(227) + ;
                    "o dispon" + CHR(237) + "vel para validar o per" + ;
                    CHR(237) + "odo.", "Integra" + CHR(231) + CHR(227) + ;
                    "o Cont" + CHR(225) + "bil")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro em ValidarPeriodo")
        ENDTRY

        RETURN loc_lValido
    ENDPROC

    *==========================================================================
    * BtnProcessarClick - evento do botao "Processar" (obj_4c_CmdGProcessar,
    * Buttons(1)). Legado (SIGPRICT.btnReport.Click, ramo This.Value <> 2 -
    * os tres guards de periodo ja saem via ValidarPeriodo(), Fase 5/6):
    *
    *     If Messagebox('Confirma o Processamento ?', 4+32+256, '') = 6
    *         ThisForm.Processamento
    *     Else
    *         Return 0
    *     EndIf
    *
    * this_oBusinessObject.Processar() ja encapsula TODO o Processamento
    * legado (Fases 1/2); aqui so resta confirmar e despachar o resultado
    * para AposProcessar(), que reproduz o fecho do metodo legado (mostrar o
    * grupo de relatorio OU gravar direto, conforme haja inconsistencia).
    *==========================================================================
    PROCEDURE BtnProcessarClick()
        LOCAL loc_oErro

        IF THIS.this_lProcessando
            RETURN
        ENDIF

        IF VARTYPE(THIS.this_oBusinessObject) != "O"
            MsgErro("Objeto de neg" + CHR(243) + "cio n" + CHR(227) + "o dispon" + ;
                CHR(237) + "vel.", "Erro em FormSigPrIct.BtnProcessarClick")
            RETURN
        ENDIF

        IF !THIS.ValidarPeriodo()
            RETURN
        ENDIF

        IF !MsgConfirma("Confirma o Processamento ?")
            RETURN
        ENDIF

        TRY
            THIS.this_lProcessando = .T.
            THIS.MousePointer      = 11
            THIS.Refresh()

            IF THIS.this_oBusinessObject.Processar()
                THIS.AposProcessar()
            ENDIF

            THIS.MousePointer      = 0
            THIS.this_lProcessando = .F.
        CATCH TO loc_oErro
            THIS.MousePointer      = 0
            THIS.this_lProcessando = .F.
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro em BtnProcessarClick")
        ENDTRY
    ENDPROC

    *==========================================================================
    * AposProcessar - fecho do PROCEDURE processamento legado:
    *
    *     Select SemConta / Set Order to Conta / Go Top
    *     If Not Eof()
    *         ThisForm.cntBotoes.Top     = ThisForm.btnReport.Top - 2
    *         ThisForm.btnReport.Enabled = .F.
    *         ThisForm.Get_Datai.Enabled = .F.
    *         ThisForm.Get_Dataf.Enabled = .F.
    *         ThisForm.cntBotoes.Visible = .T.
    *     Else
    *         Select MovAux / Go Top
    *         If !Eof()
    *             Messagebox('Nenhuma Inconsistencia Foi Encontrada!!!', 32, 'ATENCAO')
    *         Else
    *             Messagebox('Nao Existe Movimentacao no Periodo!!!', 32, 'ATENCAO')
    *         Endif
    *         ThisForm.Gravar
    *     Endif
    *
    * "ThisForm.btnReport" (o grupo Processar/Encerrar) eh
    * THIS.cnt_4c_BotoesAcao.obj_4c_CmdGProcessar; "ThisForm.cntBotoes" eh
    * THIS.cnt_4c_Botoes. this_lPossuiInconsistencia/this_lPossuiMovimento
    * sao a FONTE UNICA (BO, Fase 2) - o Form so le, nunca recalcula.
    *==========================================================================
    PROTECTED PROCEDURE AposProcessar()
        *-- Dialogo das DIFERENCAS primeiro, na ordem EXATA do legado: no
        *-- PROCEDURE processamento ele vem ANTES do ramo SemConta.
        THIS.ExibirDiferencas()

        IF THIS.this_oBusinessObject.this_lPossuiInconsistencia
            THIS.cnt_4c_Botoes.Top                              = THIS.cnt_4c_BotoesAcao.Top - 2
            THIS.cnt_4c_BotoesAcao.obj_4c_CmdGProcessar.Enabled = .F.
            THIS.txt_4c_DataI.Enabled                           = .F.
            THIS.txt_4c_DataF.Enabled                           = .F.
            THIS.cnt_4c_Botoes.Visible                          = .T.
        ELSE
            IF THIS.this_oBusinessObject.this_lPossuiMovimento
                MsgAviso("Nenhuma Inconsist" + CHR(234) + "ncia Foi Encontrada!!!", ;
                    "ATEN" + CHR(199) + CHR(195) + "O")
            ELSE
                MsgAviso("N" + CHR(227) + "o Existe Movimenta" + CHR(231) + CHR(227) + ;
                    "o no Per" + CHR(237) + "odo!!!", "ATEN" + CHR(199) + CHR(195) + "O")
            ENDIF

            THIS.GravarArquivoContabil()
        ENDIF
    ENDPROC

    *==========================================================================
    * ExibirDiferencas - passo de UI que o PROCEDURE processamento legado
    * executa ANTES do ramo SemConta e que a migracao havia perdido. O BO ja
    * calculava this_lPossuiDiferenca/this_nTotalDiferencas em
    * VerificarDiferencas() e ja expunha ObterCursorDiferencas()/
    * ObterCursorMovimento(), mas NENHUM ponto do Form consumia os quatro -
    * superficie de BO morta eh exatamente o sintoma. Legado
    * (SigPrIct_form_codigo_fonte.txt, fim do PROCEDURE processamento):
    *
    *     Select Transacaos, Sum(Val(Debs)/100) As Deb, Sum(Val(Creds)/100) As Cred ;
    *         From MovAux Group By Transacaos Into Cursor Dif1
    *     Select Transacaos From Dif1 Where Deb <> Cred Into Cursor dif2
    *     Select * From MovAux Where Transacaos In ( Select Transacaos From dif2 ) ;
    *         Into Cursor diferenca
    *     If Reccount() > 0 And Messagebox("Visualizar as diferencas na Tela?",4+32,"Visualizar") = 6
    *         Do Form SigReDif With Thisform.DataSessionId
    *     Endif
    *
    * O "Reccount() > 0" do legado mede o cursor "diferenca" (alias corrente
    * logo depois do Into Cursor), que aqui eh this_lPossuiDiferenca - FONTE
    * UNICA no BO (PILAR 3), o Form nunca recalcula.
    *
    * MsgConfirma devolve LOGICAL (regra #7 - NUNCA comparar com 6) e exibe
    * Sim/Nao com icone de pergunta, equivalente ao 4+32 do legado; o titulo
    * "Visualizar" eh o do legado. Em modo de teste MsgConfirma devolve .F.,
    * entao o harness headless nunca chega a abrir a tela filha (Show() de
    * form modal travaria a execucao).
    *
    * ALIAS DE CONTRATO (movaux/dif2): SigReDifBO.PrepararDados le os alias de
    * nome LITERAL "movaux" e "dif2" na data session do chamador
    * (IF !USED("movaux") OR !USED("dif2") -> recusa com MsgErro) e monta o
    * crGrid com "Select *, 99999999.99 As Deb1s, 99999999.99 As Cred1s From
    * movaux Where Transacaos In (Select Transacaos From dif2)". Os nomes
    * pertencem AO CONSUMIDOR, nao a arquitetura nova, logo NAO levam prefixo
    * cursor_4c_ - mesma razao de SemConta/Cabecalho em
    * PrepararCursoresRelatorio(). Montados aqui a partir dos cursores do BO:
    *   movaux = cursor_4c_MovAux           (ObterCursorMovimento)
    *   dif2   = Transacaos DISTINTAS de cursor_4c_Diferenca
    *            (ObterCursorDiferencas). Equivalente EXATO ao dif2 legado,
    *            porque "diferenca" E' MovAux filtrado por esse mesmo dif2 -
    *            toda Transacaos de dif2 tem pelo menos uma linha em MovAux
    *            (dif2 nasce de um Group By sobre MovAux). Reconstruir eh
    *            necessario porque VerificarDiferencas() FECHA cursor_4c_Dif2
    *            ao terminar.
    * O "Select *" do crGrid exige que movaux NAO tenha Deb1s/Cred1s -
    * cursor_4c_MovAux nao tem (PrepararCursoresProcesso, Fase 2).
    *
    * DataSessionId: este form tem DataSession = 2 (sessao privada) e
    * FormSigReDif.Init(par_nDataSessionId) faz "THIS.DataSessionId =
    * par_nDataSessionId" para ENTRAR nesta sessao e alcancar os dois alias -
    * transcricao de "Do Form SigReDif With Thisform.DataSessionId".
    *
    * Show() FORA do TRY (regra #29): FormSigReDif eh modal (WindowType = 1),
    * logo o Show() BLOQUEIA e todo o uso da tela filha rodaria dentro do
    * bloco - qualquer erro de runtime la dentro saltaria para este CATCH, a
    * referencia LOCAL cairia e a tela filha fecharia sozinha.
    *
    * Os alias de contrato sao fechados DEPOIS do Show() (a tela filha eh
    * modal, portanto ja terminou) e tambem em Destroy(), porque o CATCH pode
    * deixar algum deles aberto.
    *
    * RETURN unico e SEMPRE fora do TRY/CATCH (regra #1) - os RETURN de
    * guarda ficam ANTES do TRY.
    *==========================================================================
    PROCEDURE ExibirDiferencas()
        LOCAL loc_oForm, loc_oErro, loc_cCursorMov, loc_cCursorDif, loc_lPronto

        loc_lPronto = .F.
        loc_oForm   = .NULL.

        IF VARTYPE(THIS.this_oBusinessObject) != "O"
            RETURN .F.
        ENDIF

        *-- "Reccount() > 0" do legado, medido pelo BO
        IF !THIS.this_oBusinessObject.this_lPossuiDiferenca
            RETURN .F.
        ENDIF

        IF !MsgConfirma("Visualizar as diferen" + CHR(231) + "as na Tela?", "Visualizar")
            RETURN .F.
        ENDIF

        TRY
            loc_cCursorMov = THIS.this_oBusinessObject.ObterCursorMovimento()
            loc_cCursorDif = THIS.this_oBusinessObject.ObterCursorDiferencas()

            IF USED(loc_cCursorMov) AND USED(loc_cCursorDif)
                *-- Antes de montar: nao herdar alias de um processamento anterior
                THIS.LiberarCursoresDiferencas()

                SELECT * FROM (loc_cCursorMov) INTO CURSOR movaux READWRITE
                SELECT DISTINCT Transacaos FROM (loc_cCursorDif) INTO CURSOR dif2 READWRITE

                loc_lPronto = USED("movaux") AND USED("dif2")
            ELSE
                MsgAviso("Cursores de diferen" + CHR(231) + "a n" + CHR(227) + ;
                    "o dispon" + CHR(237) + "veis - reprocesse o per" + ;
                    CHR(237) + "odo.", "Visualizar")
            ENDIF

            IF loc_lPronto
                loc_oForm = CREATEOBJECT("FormSigReDif", THIS.DataSessionId)
            ENDIF
        CATCH TO loc_oErro
            loc_lPronto = .F.
            loc_oForm   = .NULL.
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro em ExibirDiferencas")
        ENDTRY

        *-- Show() FORA do TRY (regra #29) - FormSigReDif eh modal
        IF VARTYPE(loc_oForm) = "O"
            loc_oForm.Show()
        ENDIF

        THIS.LiberarCursoresDiferencas()

        RETURN loc_lPronto
    ENDPROC

    *==========================================================================
    * LiberarCursoresDiferencas - fecha os alias de CONTRATO da tela de
    * diferencas: movaux/dif2 (montados por ExibirDiferencas) e crGrid, que
    * SigReDifBO.PrepararDados cria DENTRO desta data session (ele faz
    * "SET DATASESSION TO (this_nDataSessionId)" antes do SELECT, entao o
    * cursor fica aqui, nao na sessao da tela filha). Chamado em tres pontos:
    * antes de montar, depois do Show() e em Destroy().
    *==========================================================================
    PROTECTED PROCEDURE LiberarCursoresDiferencas()
        IF USED("movaux")
            USE IN movaux
        ENDIF
        IF USED("dif2")
            USE IN dif2
        ENDIF
        IF USED("crGrid")
            USE IN crGrid
        ENDIF
    ENDPROC

    *==========================================================================
    * GravarArquivoContabil - traducao do PROCEDURE gravar legado. A parte de
    * UI (reabilitar Processar/Encerrar e as datas, esconder o grupo de
    * relatorio) fica aqui; a parte de NEGOCIO (geracao do arquivo texto
    * CTPV*, formato SDF, um grupo por EmpCont) mora no BO
    * (GravarArquivosContabeis, Fase 2):
    *
    *     ThisForm.cntBotoes.Top     = ThisForm.btnReport.Top + 60
    *     ThisForm.btnReport.Enabled = .t.
    *     ThisForm.Get_DataI.Enabled = .t.
    *     ThisForm.Get_DataF.Enabled = .t.
    *     ThisForm.cntBotoes.Visible = .f.
    *     If Messagebox('Confirma a Geracao do Arquivo?', 4+32+256, '') = 6
    *         [Copy To ... Type SDF - GravarArquivosContabeis()]
    *     EndIf
    *
    * Chamado nos TRES pontos do legado: fim do Processamento sem
    * inconsistencia (AposProcessar), BtnImprimirClick e
    * BtnEncerrarReportClick (os dois do grupo obj_4c_CmdGReport).
    *
    * BusinessBase ja reporta falha de gravacao sozinho (regra #20 -
    * GravarArquivosContabeis chama MsgErro em todo caminho que devolve .F.),
    * entao esta PROCEDURE nao precisa de ELSE.
    *==========================================================================
    PROCEDURE GravarArquivoContabil()
        THIS.cnt_4c_Botoes.Top                              = THIS.cnt_4c_BotoesAcao.Top + 60
        THIS.cnt_4c_BotoesAcao.obj_4c_CmdGProcessar.Enabled = .T.
        THIS.txt_4c_DataI.Enabled                           = .T.
        THIS.txt_4c_DataF.Enabled                           = .T.
        THIS.cnt_4c_Botoes.Visible                          = .F.

        IF MsgConfirma("Confirma a Gera" + CHR(231) + CHR(227) + "o do Arquivo?")
            THIS.this_oBusinessObject.GravarArquivosContabeis()
        ENDIF
    ENDPROC

    *==========================================================================
    * BtnEncerrarClick - evento do botao "Encerrar" do grupo Processar
    * (obj_4c_CmdGProcessar, Buttons(2)). Legado: SIGPRICT.Sair.Click
    * ("ThisForm.Release") E o ramo Else do Click do GRUPO (This.Value = 2,
    * tambem "ThisForm.Release") - os dois fazem a MESMA coisa, entao uma
    * unica chamada aqui reproduz ambos.
    *==========================================================================
    PROCEDURE BtnEncerrarClick()
        THIS.Release()
    ENDPROC

    *==========================================================================
    * BtnImprimirClick - evento do botao "Impressora" (obj_4c_CmdGReport,
    * Buttons(1) = btnImprimir do dump). Legado:
    *
    *     Report Form SIGPRICT to PRINTER Prompt NoConsole
    *     ThisForm.Gravar
    *==========================================================================
    PROCEDURE BtnImprimirClick()
        LOCAL loc_oErro

        TRY
            IF THIS.PrepararCursoresRelatorio()
                THIS.ExecutarReportForm("SigPrIct", "PRINTER_PROMPT", "SemConta")
            ENDIF

            THIS.GravarArquivoContabil()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro em BtnImprimirClick")
        ENDTRY
    ENDPROC

    *==========================================================================
    * BtnVisualizarClick - evento do botao "Video" (obj_4c_CmdGReport,
    * Buttons(3) = btnVisualizar do dump). Legado:
    *
    *     Report Form SIGPRICT Preview
    *     ThisForm.Gravar
    *==========================================================================
    PROCEDURE BtnVisualizarClick()
        LOCAL loc_oErro

        TRY
            IF THIS.PrepararCursoresRelatorio()
                THIS.ExecutarReportForm("SigPrIct", "PREVIEW", "SemConta")
            ENDIF

            THIS.GravarArquivoContabil()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro em BtnVisualizarClick")
        ENDTRY
    ENDPROC

    *==========================================================================
    * BtnEncerrarReportClick - evento do botao "Encerrar" do grupo de
    * relatorio (obj_4c_CmdGReport, Buttons(2) = btnSair do dump). Legado:
    *
    *     SIGPRICT.cntBotoes.btnReport.btnSair.Click -> "ThisForm.Gravar"
    *     SIGPRICT.cntBotoes.btnReport.Click (This.Value = 2, grupo) ->
    *         "ThisForm.Release" (bolha depois do Click do botao, pois o
    *         dump nao tem NODEFAULT em btnSair.Click)
    *
    * Em VFP9 o Click do MEMBRO roda primeiro e, sem NODEFAULT, borbulha para
    * o Click do GRUPO - por isso aqui tambem: grava o arquivo (com a chance
    * do usuario confirmar ou nao) e so entao fecha o form.
    *==========================================================================
    PROCEDURE BtnEncerrarReportClick()
        THIS.GravarArquivoContabil()
        THIS.Release()
    ENDPROC

    *==========================================================================
    * PrepararCursoresRelatorio - monta os dois alias de NOME LITERAL que o
    * SigPrIct.frx consome por contrato (mesmo padrao de MontarCursoresImpressao/
    * MontarCabecalhoImpressao de outros forms REPORT desta base - os nomes
    * NAO levam prefixo cursor_4c_ porque pertencem ao FRX, nao a arquitetura
    * nova; renomear quebraria as expressoes gravadas no relatorio):
    *
    *   SemConta  - detalhe do relatorio (Contas/DataS/Hists/Valors/Ocors),
    *               espelho de cursor_4c_SemConta
    *               (this_oBusinessObject.ObterCursorInconsistencias()).
    *   Cabecalho - titulo/periodo do cabecalho impresso, equivalente a:
    *       Thisform.poDataMgr.CursorQuery('SigCdEmp','crSigCdEmp','Cemps',_Empr,'Razas')
    *       Create Cursor Cabecalho (Empresa c(80), Titulo c(80), SubTit c(80), Periodo c(80))
    *       Insert Into Cabecalho (Empresa, Titulo, Periodo) Values ;
    *           (_Empr + ' - ' + crSigCdEmp.Razas, ;
    *            'Relatorio de Inconsistencias de Integracao Contabil', ;
    *            'Periodo: ' + Dtoc(IniPer) + ' a ' + Dtoc(FinPer))
    *   "_Empr" (legado) = go_4c_Sistema.cCodEmpresa (CLAUDE.md - _EMPR nunca
    *   usado direto). this_dDataI/this_dDataF (BO) sao a FONTE UNICA do
    *   periodo - o mesmo que ValidarPeriodo()/Processar() ja usaram.
    *==========================================================================
    PROTECTED FUNCTION PrepararCursoresRelatorio()
        LOCAL loc_cCursorOrigem, loc_cSQL, loc_nResultado, loc_cRazao

        loc_cCursorOrigem = THIS.this_oBusinessObject.ObterCursorInconsistencias()

        IF !USED(loc_cCursorOrigem) OR RECCOUNT(loc_cCursorOrigem) = 0
            MsgAviso("Nenhuma inconsist" + CHR(234) + "ncia dispon" + CHR(237) + ;
                "vel para o relat" + CHR(243) + "rio.")
            RETURN .F.
        ENDIF

        IF USED("SemConta")
            USE IN SemConta
        ENDIF
        *-- ORDER BY Contas, DataS reproduz o "Select SemConta / Set Order to Conta" que
        *-- o legado executa ANTES do If Not Eof() (o TAG Conta eh
        *-- "Contas + Dtos(DataS)"): o SigPrIct.frx imprime na ordem do indice, e
        *-- um SELECT sem ORDER BY entregaria a ordem de INSERCAO.
        SELECT * FROM (loc_cCursorOrigem) ORDER BY Contas, DataS ;
            INTO CURSOR SemConta READWRITE

        loc_cRazao = ""
        IF USED("cursor_4c_EmpRelatorio")
            USE IN cursor_4c_EmpRelatorio
        ENDIF
        loc_cSQL = "SELECT Cemps, Razas FROM SigCdEmp WHERE Cemps = " + EscaparSQL(go_4c_Sistema.cCodEmpresa)
        loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_EmpRelatorio")
        IF loc_nResultado >= 1 AND USED("cursor_4c_EmpRelatorio") AND !EOF("cursor_4c_EmpRelatorio")
            loc_cRazao = ALLTRIM(TratarNulo(cursor_4c_EmpRelatorio.Razas, ""))
        ENDIF
        IF USED("cursor_4c_EmpRelatorio")
            USE IN cursor_4c_EmpRelatorio
        ENDIF

        IF USED("Cabecalho")
            USE IN Cabecalho
        ENDIF
        CREATE CURSOR Cabecalho (Empresa C(80), Titulo C(80), SubTit C(80), Periodo C(80))
        INSERT INTO Cabecalho (Empresa, Titulo, Periodo) VALUES ;
            (ALLTRIM(go_4c_Sistema.cCodEmpresa) + " - " + loc_cRazao, ;
             "Relat" + CHR(243) + "rio de Inconsist" + CHR(234) + "ncias de Integra" + ;
                CHR(231) + CHR(227) + "o Cont" + CHR(225) + "bil", ;
             "Per" + CHR(237) + "odo: " + DTOC(THIS.this_oBusinessObject.this_dDataI) + ;
                " " + CHR(224) + " " + DTOC(THIS.this_oBusinessObject.this_dDataF))

        RETURN .T.
    ENDFUNC

    *==========================================================================
    * ExecutarReportForm - helper canonico de REPORT FORM (mesmo padrao de
    * FormSigPrFem/FormSIGPGCNB/FormSIGPRCNB - CorretorAutomatico #117/#147):
    *   1. guard de EXISTENCIA do FRX (o legado usa "Report Form SIGPRICT"
    *      BARE, o VFP9 procuraria o arquivo no diretorio corrente);
    *   2. guard de cursor VAZIO (preview em branco nao diz nada ao usuario);
    *   3. isolamento de locale - SET POINT "." / SEPARATOR "," /
    *      REPORTBEHAVIOR 80 (FRX Fortyus com PICTURE americana);
    *   4. restauracao do menu - REPORT FORM PREVIEW corrompe o cache visual
    *      do _MSYSMENU (Erro63).
    * par_cModo: "PREVIEW" | "PRINTER_PROMPT" | "PRINTER".
    *==========================================================================
    PROTECTED FUNCTION ExecutarReportForm(par_cRelatorioBase, par_cModo, par_cCursorDados)
        LOCAL loc_cFRX, loc_cPointOrig, loc_cSepOrig, loc_nBehaviorOrig

        loc_cFRX = FULLPATH(gc_4c_CaminhoReports + par_cRelatorioBase + ".frx")

        IF NOT FILE(loc_cFRX)
            MsgErro("Arquivo de relat" + CHR(243) + "rio n" + CHR(227) + "o encontrado:" + ;
                CHR(13) + loc_cFRX, "Erro")
            RETURN .F.
        ENDIF

        IF VARTYPE(par_cCursorDados) == "C" AND !EMPTY(par_cCursorDados)
            IF !USED(par_cCursorDados) OR RECCOUNT(par_cCursorDados) = 0
                MsgAviso("Nenhum registro encontrado com os filtros informados.", ;
                    "Aten" + CHR(231) + CHR(227) + "o")
                RETURN .F.
            ENDIF
            SELECT (par_cCursorDados)
            GO TOP
        ENDIF

        loc_cPointOrig    = SET("POINT")
        loc_cSepOrig      = SET("SEPARATOR")
        loc_nBehaviorOrig = SET("REPORTBEHAVIOR")
        SET POINT TO "."
        SET SEPARATOR TO ","
        SET REPORTBEHAVIOR 80

        DO CASE
            CASE par_cModo == "PREVIEW"
                REPORT FORM (loc_cFRX) PREVIEW NOCONSOLE
            CASE par_cModo == "PRINTER_PROMPT"
                REPORT FORM (loc_cFRX) TO PRINTER PROMPT NOCONSOLE
            CASE par_cModo == "PRINTER"
                REPORT FORM (loc_cFRX) TO PRINTER NOCONSOLE
        ENDCASE

        SET POINT TO (loc_cPointOrig)
        SET SEPARATOR TO (loc_cSepOrig)
        SET REPORTBEHAVIOR (loc_nBehaviorOrig)

        TRY
            SET SYSMENU TO DEFAULT
            RELEASE POPUP popArquivo, popCadastros, popMovimentos, ;
                popRelatorios, popFerramentas, popAjuda
            CriarMenuPrincipal()
        CATCH
            *-- CriarMenuPrincipal fora de escopo (teste automatizado) - silencioso
        ENDTRY

        RETURN .T.
    ENDFUNC

    *==========================================================================
    * TornarControlesVisiveis - AddObject cria controles com Visible=.F. por
    * padrao. Percorre recursivamente containers/PageFrames para tornar tudo
    * visivel apos a montagem. Filtra cnt_4c_Botoes (equivalente ao cntBotoes
    * legado, que so fica visivel DEPOIS do processamento - Fase 7/8): pula o
    * Visible do proprio container, mas recursa nos filhos para eles nao
    * ficarem hidden quando o container for mostrado depois. Filtra tambem
    * lbl_4c_Label4 (duplicata de " Periodo " oculta no proprio SCX - ver
    * ConfigurarFiltroPeriodo): sem esta excecao, o laco forcaria
    * Visible=.T. e o duplicado apareceria sobre a linha "Data Inicial".
    *==========================================================================
    PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
        LOCAL loc_nI, loc_oObjeto, loc_nP

        FOR loc_nI = 1 TO par_oContainer.ControlCount
            loc_oObjeto = par_oContainer.Controls(loc_nI)

            IF VARTYPE(loc_oObjeto) = "O"
                IF INLIST(UPPER(loc_oObjeto.Name), "CNT_4C_BOTOES")
                    THIS.TornarControlesVisiveis(loc_oObjeto)
                    LOOP
                ENDIF

                IF UPPER(loc_oObjeto.Name) = "LBL_4C_LABEL4"
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
    * Destroy - Equivalente do "PROCEDURE Release" legado (que soltava o
    * poDataMgr; aqui a conexao eh o gnConnHandle global e nao pertence ao
    * form). Fecha os cursores de processamento desta tela, se ainda abertos,
    * antes de encadear para FormBase.Destroy(), que libera o BO e restaura o
    * menu principal. DODEFAULT() SEMPRE por ultimo (Destroy sem DODEFAULT
    * deixa o menu do sistema encolhido - CLAUDE.md regra correlata).
    *==========================================================================
    PROCEDURE Destroy()
        *-- Cursores do BO (inclui Dif1/Dif2/Diferenca, que o processamento
        *-- so cria quando VerificarDiferencas() encontra transacao
        *-- desbalanceada - FinalizarProcesso() cobre a lista inteira).
        IF VARTYPE(THIS.this_oBusinessObject) = "O"
            THIS.this_oBusinessObject.FinalizarProcesso()
        ENDIF

        IF USED("cursor_4c_MovAux")
            USE IN cursor_4c_MovAux
        ENDIF
        IF USED("cursor_4c_SemConta")
            USE IN cursor_4c_SemConta
        ENDIF
        IF USED("cursor_4c_Grupos")
            USE IN cursor_4c_Grupos
        ENDIF
        IF USED("cursor_4c_TodosGrupos")
            USE IN cursor_4c_TodosGrupos
        ENDIF
        IF USED("cursor_4c_Empresas")
            USE IN cursor_4c_Empresas
        ENDIF
        IF USED("cursor_4c_LoteProc")
            USE IN cursor_4c_LoteProc
        ENDIF
        IF USED("cursor_4c_MvCcr")
            USE IN cursor_4c_MvCcr
        ENDIF

        *-- Cursores de nome literal montados por PrepararCursoresRelatorio()
        *-- (Fase 7/8) para o SigPrIct.frx - nao levam prefixo cursor_4c_.
        IF USED("SemConta")
            USE IN SemConta
        ENDIF
        IF USED("Cabecalho")
            USE IN Cabecalho
        ENDIF
        IF USED("cursor_4c_EmpRelatorio")
            USE IN cursor_4c_EmpRelatorio
        ENDIF

        *-- Alias de CONTRATO da tela de diferencas (movaux/dif2/crGrid).
        *-- ExibirDiferencas() ja os fecha depois do Show(), mas o CATCH dele
        *-- pode deixar algum aberto - fechar aqui tambem.
        THIS.LiberarCursoresDiferencas()

        DODEFAULT()
    ENDPROC

ENDDEFINE

*==============================================================================
* FormSIGPRVTX.prg
* Form Operacional: Cadastro de Testes / Importacao de SKU para VTEX (SigPrVtx)
* Herda de: FormBase
* Tipo: OPERACIONAL - layout FLAT, sem PageFrame (igual ao legado SIGPRVTX.SCX)
* SCX Origem: SIGPRVTX.SCX
*
* Fluxo: usuario escolhe uma planilha Excel (cmd_4c_Cmdgetp + txt_4c_Planilha),
* clica Processar (le a planilha e acrescenta linhas novas no cursor local
* cursor_4c_Grade, exibido no grd_4c_Dados), edita a coluna "Referencia SKU"
* se precisar e clica Salvar (obj_4c_Grupo_Botao, botao "Salvar") para
* substituir TODO o conteudo da tabela SigPrVtx pelo conteudo da grade.
*
* CAMPOS DE DIGITACAO deste form (Fase 6): o SCX legado tem UM UNICO campo
* editavel - a coluna 4 da grade ("Referencia SKU" / refsku). GetPlanilha eh
* ReadOnly = .T. + Enabled = .F. no legado (preenchido so pelo GetFile do
* cmdgetp) e Grade.Column1/2/3 declaram ReadOnly = .T.
*
* LOOKUPS: NENHUM. O dump do legado nao tem fwBuscaExt/fwBuscaSel/fwBuscaInt,
* sigacess(), Acesso*() nem mAddColuna - este form nao consulta tabela
* auxiliar em campo algum. NAO inventar lookup (PILAR 1 + regra "NUNCA
* inventar tabelas de lookup que nao existem no original").
*==============================================================================

DEFINE CLASS FormSIGPRVTX AS FormBase

    *-- Propriedades visuais (PILAR 1 - UX FIDELITY: Height/Width/Caption EXATOS do original)
    Height      = 577
    Width       = 800
    Caption     = "Cadastro de Testes"
    AutoCenter  = .T.
    ShowWindow  = 1
    WindowType  = 1
    ControlBox  = .F.
    MaxButton   = .F.
    TitleBar    = 0
    Themes      = .F.
    BorderStyle = 2
    DataSession = 1
    KeyPreview  = .T.

    *-- Propriedades de estado
    this_oBusinessObject = .NULL.

    *===========================================================================
    * Init - Inicializa o formulario
    * REGRA CRITICA: Apenas RETURN DODEFAULT()
    * FormBase.Init() ja chama InicializarForm() - NAO duplicar a chamada!
    *===========================================================================
    PROCEDURE Init()
        RETURN DODEFAULT()
    ENDPROC

    *-- Load legado ("=fConfigGeral()") NAO PORTADO - mesma decisao registrada
    *-- em FormSigPrTar.prg/FormSigMvMen.prg/FormSigMvExp.prg. fConfigGeral era
    *-- funcao GLOBAL de inicializacao da aplicacao legado; na arquitetura nova
    *-- esse papel eh de start\config.prg, que roda uma vez no startup. O
    *-- wrapper utils\fconfiggeral.prg existe so para o p-code dos VCX legado
    *-- que ainda o chamam (regra #27 CLAUDE.md) - codigo nosso nao o chama de
    *-- novo por form.
    *
    *-- O Init legado tambem fazia "SqlExecute([Select * From SigCdPac]) /
    *-- ThisForm.SigKey = CrSigCdPac.SigKeys". Essa property eh ESCRITA e nunca
    *-- LIDA em lugar nenhum do SCX (conferido no dump inteiro): eh estado
    *-- morto, por isso nao foi portada - portar exigiria uma consulta a
    *-- SigCdPac que nada consome.

    *===========================================================================
    * InicializarForm - Cria o cursor local da grade, instancia o Business
    * Object, monta o cabecalho, os controles e vincula a grade.
    * Chamado automaticamente pelo FormBase.Init() via DODEFAULT()
    *===========================================================================
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        TRY
            *-- Cursor local da grade (espelha "Create Cursor csGrade" do Load
            *-- legado - MESMA ordem de campos, para o APPEND/REPLACE casar)
            IF USED("cursor_4c_Grade")
                USE IN cursor_4c_Grade
            ENDIF
            CREATE CURSOR cursor_4c_Grade (nomesku C(100), refsku C(40), skuativo C(3), skuid C(10))
            INDEX ON skuid TAG skuid
            GO TOP

            *-- Instanciar Business Object
            THIS.this_oBusinessObject = CREATEOBJECT("SIGPRVTXBO")

            IF VARTYPE(THIS.this_oBusinessObject) <> "O"
                MsgErro("Erro ao criar SIGPRVTXBO. VARTYPE retornou: " + ;
                    VARTYPE(THIS.this_oBusinessObject), "FormSIGPRVTX.InicializarForm")
            ELSE
                THIS.Picture = gc_4c_CaminhoIcones + "new_background.jpg"

                *-- Construir cabecalho PRIMEIRO: obj_4c_Grupo_Botao fica em
                *-- Top = -2, DENTRO da area da faixa (Top 0..80), e so aparece
                *-- se for criado DEPOIS dela (regra #11 CLAUDE.md)
                THIS.ConfigurarCabecalho()
                THIS.cnt_4c_Sombra.lbl_4c_LblSombra.Caption = THIS.Caption
                THIS.cnt_4c_Sombra.lbl_4c_LblTitulo.Caption = THIS.Caption

                *-- Construir Shape, Planilha, Grade, Processar/Limpar e o
                *-- Grupo_Botao (Salvar/Encerrar), e vincular o grid ao cursor
                THIS.ConfigurarControles()
                THIS.MontarGrade()

                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro em FormSIGPRVTX.InicializarForm")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *===========================================================================
    * ConfigurarCabecalho - Faixa cinza do titulo (cntSombra do legado).
    * Identificar a faixa por BackColor = RGB(100,100,100) + Height >= 60,
    * NUNCA pelo nome do container (regra #11 CLAUDE.md).
    *===========================================================================
    PROTECTED PROCEDURE ConfigurarCabecalho()
        LOCAL loc_oCnt

        THIS.AddObject("cnt_4c_Sombra", "Container")
        loc_oCnt = THIS.cnt_4c_Sombra
        WITH loc_oCnt
            .Top         = 0
            .Left        = 0
            .Width       = 800
            .Height      = 80
            .BorderWidth = 0
            .BackStyle   = 1
            .BackColor   = RGB(100, 100, 100)
            .Visible     = .T.
        ENDWITH

        *-- lblSombra: sombra PRETA do titulo (desenhada atras do lblTitulo).
        *-- AutoSize = .F. + Width/Height transcritos do SCX: AutoSize eh no-op
        *-- em Label criado por AddObject e, com WordWrap = .T., DESCARTA a
        *-- Height e corta o texto (regra #23 CLAUDE.md).
        loc_oCnt.AddObject("lbl_4c_LblSombra", "Label")
        WITH loc_oCnt.lbl_4c_LblSombra
            .AutoSize      = .F.
            .FontName      = "Tahoma"
            .FontSize      = 18
            .FontBold      = .T.
            .FontUnderline = .F.
            .WordWrap      = .T.
            .Alignment     = 0
            .BackStyle     = 0
            .Caption       = "Cadastro de Testes"
            .Height        = 40
            .Left          = 10
            .Top           = 18
            .Width         = 769
            .ForeColor     = RGB(0, 0, 0)
            .Visible       = .T.
        ENDWITH

        *-- lblTitulo: titulo BRANCO sobre a faixa cinza opaca (excecao
        *-- legitima da regra #12 - o container eh BackStyle = 1 escuro)
        loc_oCnt.AddObject("lbl_4c_LblTitulo", "Label")
        WITH loc_oCnt.lbl_4c_LblTitulo
            .AutoSize    = .F.
            .FontName    = "Tahoma"
            .FontSize    = 18
            .FontBold    = .T.
            .WordWrap    = .T.
            .Alignment   = 0
            .BackStyle   = 0
            .Caption     = "Cadastro de Testes"
            .Height      = 46
            .Left        = 10
            .Top         = 17
            .Width       = 769
            .ForeColor   = RGB(255, 255, 255)
            .ToolTipText = "T" + CHR(237) + "tulo do Relat" + CHR(243) + "rio"
            .Visible     = .T.
        ENDWITH
    ENDPROC

    *===========================================================================
    * ConfigurarControles - Shape, label/campo da Planilha, botao do GetFile,
    * grade, Processar/Limpar e o Grupo_Botao (Salvar/Encerrar).
    * Todas as posicoes/cores/fontes transcritas do SCX legado (PILAR 1).
    *===========================================================================
    PROTECTED PROCEDURE ConfigurarControles()
        LOCAL loc_oGrp

        *-- Shape1 -> moldura do bloco "Planilha" (so borda, sem preenchimento).
        *-- Shape NAO tem ForeColor nem ShapeType (regra #33) - a cor da borda
        *-- eh BorderColor.
        THIS.AddObject("shp_4c_Shape1", "Shape")
        WITH THIS.shp_4c_Shape1
            .Top           = 21
            .Left          = 30
            .Height        = 110
            .Width         = 586
            .BackStyle     = 0
            .BorderStyle   = 0
            .SpecialEffect = 1
            .BorderColor   = RGB(136, 189, 188)
            .Visible       = .T.
        ENDWITH

        *-- Say4 -> rotulo "Planilha:". O legado nao declara BackStyle; a classe
        *-- "say" eh transparente e Alignment = 0 (regra #23) - NAO inventar
        *-- Alignment = 1. ForeColor transcrito do dump (90,90,90).
        THIS.AddObject("lbl_4c_Label4", "Label")
        WITH THIS.lbl_4c_Label4
            .AutoSize  = .F.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .T.
            .Alignment = 0
            .BackStyle = 0
            .Caption   = "Planilha:"
            .Height    = 15
            .Left      = 133
            .Top       = 84
            .Width     = 49
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        *-- GetPlanilha -> caminho do arquivo escolhido. ReadOnly = .T. +
        *-- Enabled = .F. transcritos do SCX: no legado este campo NUNCA eh
        *-- digitado, so recebe o retorno do GetFile do cmdgetp.
        THIS.AddObject("txt_4c_Planilha", "TextBox")
        WITH THIS.txt_4c_Planilha
            .Height            = 23
            .Left              = 133
            .Top               = 101
            .Width             = 336
            .MaxLength         = 40
            .ReadOnly          = .T.
            .Enabled           = .F.
            .DisabledBackColor = RGB(255, 255, 255)
            .Value             = ""
            .Visible           = .T.
        ENDWITH

        *-- cmdgetp -> abre dialogo de selecao de arquivo XLS.
        *-- .Picture transcrito do SCX (geral_pasta_26.jpg), NUNCA palpitado
        *-- (regra #25 - .Picture inexistente falha em silencio).
        THIS.AddObject("cmd_4c_Cmdgetp", "CommandButton")
        WITH THIS.cmd_4c_Cmdgetp
            .Top       = 86
            .Left      = 471
            .Height    = 44
            .Width     = 65
            .FontName  = "Verdana"
            .FontSize  = 8
            .Picture   = gc_4c_CaminhoIcones + "geral_pasta_26.jpg"
            .Caption   = ""
            .ForeColor = RGB(36, 84, 155)
            .BackColor = RGB(255, 255, 255)
            .Themes    = .F.
            .Visible   = .T.
        ENDWITH
        BINDEVENT(THIS.cmd_4c_Cmdgetp, "Click", THIS, "CmdGetPClick")

        *-- Grade -> grid do conteudo importado (cursor_4c_Grade), 4 colunas
        THIS.AddObject("grd_4c_Dados", "Grid")
        WITH THIS.grd_4c_Dados
            .Top           = 133
            .Left          = 30
            .Width         = 725
            .Height        = 435
            .ColumnCount   = 4
            .FontName      = "Tahoma"
            .FontSize      = 8
            .DeleteMark    = .F.
            .RecordMark    = .F.
            .RowHeight     = 16
            .ScrollBars    = 2
            .GridLineColor = RGB(238, 238, 238)
            .Visible       = .T.

            WITH .Column1
                .FontName = "Tahoma"
                .FontSize = 8
                WITH .Text1
                    .BorderStyle = 0
                    .Margin      = 0
                    .ForeColor   = RGB(0, 0, 0)
                    .BackColor   = RGB(255, 255, 255)
                ENDWITH
            ENDWITH

            WITH .Column2
                .FontName = "Tahoma"
                .FontSize = 8
                WITH .Text1
                    .BorderStyle = 0
                    .Margin      = 0
                    .ForeColor   = RGB(0, 0, 0)
                    .BackColor   = RGB(255, 255, 255)
                ENDWITH
            ENDWITH

            WITH .Column3
                .FontName = "Tahoma"
                .FontSize = 8
                WITH .Text1
                    .BorderStyle = 0
                    .Margin      = 0
                    .ForeColor   = RGB(0, 0, 0)
                    .BackColor   = RGB(255, 255, 255)
                ENDWITH
            ENDWITH

            WITH .Column4
                .FontName = "Tahoma"
                .FontSize = 8
                WITH .Text1
                    .BorderStyle = 0
                    .Margin      = 0
                    .ForeColor   = RGB(0, 0, 0)
                    .BackColor   = RGB(255, 255, 255)
                ENDWITH
            ENDWITH
        ENDWITH

        *-- cmdProcessar -> le a planilha e acrescenta linhas novas na grade
        THIS.AddObject("cmd_4c_CmdProcessar", "CommandButton")
        WITH THIS.cmd_4c_CmdProcessar
            .Top        = 3
            .Left       = 573
            .Height     = 75
            .Width      = 75
            .FontName   = "Comic Sans MS"
            .FontSize   = 8
            .FontBold   = .T.
            .FontItalic = .T.
            .Picture    = gc_4c_CaminhoIcones + "geral_processar_60.jpg"
            .Caption    = "\<Processar"
            .ForeColor  = RGB(90, 90, 90)
            .BackColor  = RGB(255, 255, 255)
            .Themes     = .F.
            .Visible    = .T.
        ENDWITH
        BINDEVENT(THIS.cmd_4c_CmdProcessar, "Click", THIS, "CmdProcessarClick")

        *-- cmdLimpar -> esvazia a grade e o campo Planilha
        THIS.AddObject("cmd_4c_CmdLimpar", "CommandButton")
        WITH THIS.cmd_4c_CmdLimpar
            .Top        = 3
            .Left       = 498
            .Height     = 75
            .Width      = 75
            .FontName   = "Comic Sans MS"
            .FontSize   = 8
            .FontBold   = .T.
            .FontItalic = .T.
            .Picture    = gc_4c_CaminhoIcones + "geral_limpa_grade_60.jpg"
            .Caption    = "\<Limpar"
            .ForeColor  = RGB(90, 90, 90)
            .BackColor  = RGB(255, 255, 255)
            .Themes     = .F.
            .Visible    = .T.
        ENDWITH
        BINDEVENT(THIS.cmd_4c_CmdLimpar, "Click", THIS, "CmdLimparClick")

        *-- Grupo_Botao -> CommandGroup com cmdok ("Salvar") e cmdsair
        *-- ("Encerrar"). CommandGroup NAO tem ForeColor nem FontName
        *-- (regra #33 CLAUDE.md) - essas propriedades moram nos Buttons(N).
        *-- AutoSize = .F. + Width/Height do SCX: com AutoSize = .T. a
        *-- geometria do grupo passaria a depender dos botoes internos.
        THIS.AddObject("obj_4c_Grupo_Botao", "CommandGroup")
        loc_oGrp = THIS.obj_4c_Grupo_Botao
        WITH loc_oGrp
            .ButtonCount   = 2
            .AutoSize      = .F.
            .BackStyle     = 0
            .BorderStyle   = 0
            .SpecialEffect = 1
            .BorderColor   = RGB(136, 189, 188)
            .Value         = 1
            .Top           = -2
            .Left          = 643
            .Height        = 85
            .Width         = 160

            WITH .Buttons(1)
                .Top        = 5
                .Left       = 5
                .Height     = 75
                .Width      = 75
                .FontName   = "Comic Sans MS"
                .FontSize   = 8
                .FontBold   = .T.
                .FontItalic = .T.
                .WordWrap   = .T.
                .Picture    = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
                .Caption    = "\<Salvar"
                .ForeColor  = RGB(90, 90, 90)
                .BackColor  = RGB(255, 255, 255)
                .Themes     = .F.
                .Visible    = .T.
            ENDWITH

            WITH .Buttons(2)
                .Top        = 5
                .Left       = 80
                .Height     = 75
                .Width      = 75
                .FontName   = "Comic Sans MS"
                .FontSize   = 8
                .FontBold   = .T.
                .FontItalic = .T.
                .WordWrap   = .T.
                .Picture    = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
                .Caption    = "Encerrar"
                .ForeColor  = RGB(90, 90, 90)
                .BackColor  = RGB(255, 255, 255)
                .Themes     = .F.
                .Visible    = .T.
            ENDWITH

            .Visible = .T.
        ENDWITH
        BINDEVENT(loc_oGrp.Buttons(1), "Click", THIS, "BtnSalvarClick")
        BINDEVENT(loc_oGrp.Buttons(2), "Click", THIS, "BtnEncerrarClick")
    ENDPROC

    *===========================================================================
    * MontarGrade - Vincula grd_4c_Dados ao cursor_4c_Grade (espelha o
    * "montagrade" do legado). RecordSource/ControlSource resetam Width e
    * Header1.Caption das colunas, por isso essas propriedades sao
    * reaplicadas DEPOIS do bind, nunca so na criacao do grid
    *===========================================================================
    PROCEDURE MontarGrade()
        LOCAL loc_nAreaAnterior
        loc_nAreaAnterior = SELECT()

        THIS.grd_4c_Dados.RecordSource = ""

        IF USED("cursor_4c_Grade")
            SELECT cursor_4c_Grade
            GO TOP
        ENDIF

        WITH THIS.grd_4c_Dados
            .RecordSource = "cursor_4c_Grade"

            .Column1.ControlSource = "cursor_4c_Grade.skuid"
            .Column2.ControlSource = "cursor_4c_Grade.nomesku"
            .Column3.ControlSource = "cursor_4c_Grade.skuativo"
            .Column4.ControlSource = "cursor_4c_Grade.refsku"

            .Column1.Header1.Caption = "SKU ID"
            .Column2.Header1.Caption = "Nome SKU"
            .Column3.Header1.Caption = "SKU Ativo"
            .Column4.Header1.Caption = "Referencia SKU"

            .Column1.Header1.Alignment = 2
            .Column2.Header1.Alignment = 2
            .Column3.Header1.Alignment = 2
            .Column4.Header1.Alignment = 2
            .Column1.Header1.ForeColor = RGB(90, 90, 90)

            .Column1.Width = 70
            .Column2.Width = 400
            .Column3.Width = 70
            .Column4.Width = 150

            .Column1.Movable = .F.
            .Column2.Movable = .F.
            .Column3.Movable = .F.

            .Column1.Resizable = .F.
            .Column2.Resizable = .F.
            .Column3.Resizable = .F.

            *-- ReadOnly POR COLUNA depois de qualquer ReadOnly do Grid
            *-- (regra #18 CLAUDE.md): o ReadOnly do Grid propaga e sobrescreve
            *-- o das colunas. O legado declara Column1/2/3.ReadOnly = .T. e
            *-- NAO declara ReadOnly em Column4 nem em Column4.Text1 - a
            *-- "Referencia SKU" eh editavel DE PROPOSITO e eh o unico campo de
            *-- digitacao do form. Explicito aqui para nao depender do default.
            .Column1.ReadOnly = .T.
            .Column2.ReadOnly = .T.
            .Column3.ReadOnly = .T.
            .Column4.ReadOnly = .F.
        ENDWITH

        *-- Celula editavel: TextBox com Valid EMBUTIDO (regra #46 - BINDEVENT
        *-- em "Valid" de TextBox dentro de Column nao dispara de forma
        *-- confiavel). Vai DEPOIS do bind porque mexer em RecordSource/
        *-- ColumnCount pode recriar os objetos Column e levar o AddObject.
        THIS.InstalarCelulaRefSku(THIS.grd_4c_Dados)

        THIS.grd_4c_Dados.Refresh()

        IF loc_nAreaAnterior > 0
            SELECT (loc_nAreaAnterior)
        ENDIF
    ENDPROC

    *===========================================================================
    * InstalarCelulaRefSku - poe o TextBox com Valid embutido na Column4
    * ("Referencia SKU" / coluna refsku), a UNICA celula editavel do form.
    * AddObject + CurrentControl + Sparse = .F. sao os TRES passos obrigatorios
    * (regra #18 CLAUDE.md): sem CurrentControl a Column continua desenhando o
    * Text1 dela e o controle novo NUNCA aparece; sem Sparse = .F. ele so
    * aparece na linha ativa.
    * Idempotente: chamado pelo MontarGrade, que refaz o bind do grid.
    *===========================================================================
    PROTECTED PROCEDURE InstalarCelulaRefSku(par_oGrid)
        LOCAL loc_oCol

        IF VARTYPE(par_oGrid) = "O"
            loc_oCol = par_oGrid.Column4

            IF !PEMSTATUS(loc_oCol, "txt_4c_RefSku", 5)
                loc_oCol.AddObject("txt_4c_RefSku", "TextBoxRefSkuVtx_4c")
            ENDIF

            WITH loc_oCol.txt_4c_RefSku
                .FontName    = "Tahoma"
                .FontSize    = 8
                .BorderStyle = 0
                .Margin      = 0
                .MaxLength   = 40
                .ForeColor   = RGB(0, 0, 0)
                .BackColor   = RGB(255, 255, 255)
                .Visible     = .T.
            ENDWITH

            loc_oCol.CurrentControl = "txt_4c_RefSku"
            loc_oCol.Sparse         = .F.
        ENDIF
    ENDPROC

    *===========================================================================
    * ValidarRefSkuGrade - Valid da celula "Referencia SKU", chamado pela classe
    * TextBoxRefSkuVtx_4c (NUNCA por BINDEVENT - regra #46 CLAUDE.md).
    *
    * O SCX legado NAO tem Valid nesta celula, entao NAO se inventa regra de
    * negocio aqui (PILAR 1): a validacao so faz cumprir a largura que o schema
    * impoe - refsku eh char(40) NOT NULL em SigPrVtx (docs/schema.sql) e C(40)
    * no cursor_4c_Grade - e confirmar o valor digitado no cursor.
    *
    * Em BRANCO eh VALIDO: o legado grava refsku vazio sem reclamar (Gather
    * Memvar sobre Append Blank) e char(40) NOT NULL aceita "". Exigir
    * preenchimento mudaria o comportamento do legado.
    *===========================================================================
    PROCEDURE ValidarRefSkuGrade(par_oTxt)
        LOCAL loc_cDigitado, loc_cNormalizado

        IF VARTYPE(par_oTxt) = "O"
            *-- O valor digitado esta em par_oTxt.Value: o CURSOR so o recebe
            *-- DEPOIS que o Valid devolve .T. (regra #46). Ler do cursor aqui
            *-- validaria o valor ANTERIOR da celula.
            loc_cDigitado = NVL(par_oTxt.Value, "")
            IF VARTYPE(loc_cDigitado) <> "C"
                loc_cDigitado = ""
            ENDIF

            loc_cNormalizado = LEFT(ALLTRIM(loc_cDigitado), 40)

            *-- Devolver tambem para o .Value, senao o texto digitado sobrescreve
            *-- o cursor quando o VFP commita a celula (regra #46).
            par_oTxt.Value = loc_cNormalizado

            IF USED("cursor_4c_Grade") AND !EOF("cursor_4c_Grade")
                REPLACE refsku WITH loc_cNormalizado IN cursor_4c_Grade
            ENDIF
        ENDIF

        RETURN .T.
    ENDPROC

    *===========================================================================
    * ValidarGrade - Pre-condicoes do "Grupo_Botao.cmdok.Click" legado,
    * transcritas literalmente:
    *     Select csGrade / Go Top
    *     If Reccount([csGrade])=0 -> "Nenhum Registro para Atualizacao." / .F.
    *     lnResp=Messagebox([Deseja Atualizar as informacoes.],4+32,...)
    *     If lnResp<>6 -> .F.
    * O GO TOP tambem eh o que COMMITA no cursor a celula Referencia SKU que o
    * usuario possa ter deixado em edicao ao clicar Salvar.
    *===========================================================================
    PROCEDURE ValidarGrade()
        LOCAL loc_lValido
        loc_lValido = .F.

        IF !USED("cursor_4c_Grade")
            MsgAviso("Nenhum Registro para Atualiza" + CHR(231) + CHR(227) + "o.", ;
                "Aten" + CHR(231) + CHR(227) + "o")
        ELSE
            SELECT cursor_4c_Grade
            GO TOP

            IF RECCOUNT("cursor_4c_Grade") = 0
                MsgAviso("Nenhum Registro para Atualiza" + CHR(231) + CHR(227) + "o.", ;
                    "Aten" + CHR(231) + CHR(227) + "o")
            ELSE
                loc_lValido = MsgConfirma("Deseja Atualizar as informa" + CHR(231) + CHR(245) + "es.", ;
                    "Aten" + CHR(231) + CHR(227) + "o")
            ENDIF
        ENDIF

        RETURN loc_lValido
    ENDPROC

    *===========================================================================
    * LimparGrade - Esvazia cursor_4c_Grade e o campo Planilha (espelha o
    * "limpagrade" do legado - RecordSource fica vazio ate o proximo
    * Processar/MontarGrade, igual ao SCX original)
    *===========================================================================
    PROCEDURE LimparGrade()
        THIS.grd_4c_Dados.RecordSource = ""

        IF USED("cursor_4c_Grade")
            SELECT cursor_4c_Grade
            ZAP
        ENDIF

        THIS.grd_4c_Dados.Refresh()

        THIS.txt_4c_Planilha.Value = ""
        THIS.txt_4c_Planilha.Refresh()
    ENDPROC

    *===========================================================================
    * CmdGetPClick - Abre dialogo de selecao do arquivo XLS (espelha
    * "cmdgetp.Click" do legado). Eh o UNICO caminho de preenchimento do campo
    * Planilha: no legado ele eh ReadOnly = .T. + Enabled = .F.
    *===========================================================================
    PROCEDURE CmdGetPClick()
        THIS.txt_4c_Planilha.Value = GETFILE("xls", "Planilha", "Importar")
    ENDPROC

    *===========================================================================
    * CmdProcessarClick / CmdLimparClick - delegam para a logica de negocio
    *===========================================================================
    PROCEDURE CmdProcessarClick()
        THIS.Processamento()
    ENDPROC

    PROCEDURE CmdLimparClick()
        THIS.LimparGrade()
    ENDPROC

    *===========================================================================
    * Processamento - Le a planilha Excel selecionada e acrescenta na grade
    * SOMENTE os SKUs que ainda nao estao nela (espelha "processamento" do
    * legado). ImpExcelDriver(arquivo) abre o XLS e popula o cursor xlResults
    * com uma coluna por titulo de coluna da planilha.
    *===========================================================================
    PROCEDURE Processamento()
        LOCAL loc_cArquivo, loc_lRecno, loc_cSkuId, loc_cNomeSku
        LOCAL loc_cSkuAtivo, loc_cRefSku, loc_oErro
        loc_lRecno = .T.

        TRY
            loc_cArquivo = THIS.txt_4c_Planilha.Value

            IF EMPTY(loc_cArquivo)
                MsgAviso("Planilha n" + CHR(227) + "o Informada.", "Aten" + CHR(231) + CHR(227) + "o")
                loc_lRecno = .F.
            ELSE
                IF USED("Planilha")
                    USE IN Planilha
                ENDIF

                IF USED("cursor_4c_Grade")
                    SELECT cursor_4c_Grade
                    ZAP
                ENDIF

                IF !ImpExcelDriver(loc_cArquivo)
                    loc_lRecno = .F.
                ENDIF

                IF !loc_lRecno
                    MsgErro("N" + CHR(227) + "o Foi Poss" + CHR(237) + "vel Criar o Cursor Tempor" + CHR(225) + "rio." + CHR(13) + ;
                        "Verifique Se a Planilha N" + CHR(227) + "o Esta Em Uso Por Outro Processo.", "Erro")
                ELSE
                    IF !USED("xlResults")
                        MsgAviso("Planilha vazia ou formato inv" + CHR(225) + "lido.", "Aviso")
                        loc_lRecno = .F.
                    ELSE
                        SELECT * FROM xlResults INTO CURSOR Planilha READWRITE

                        SELECT Planilha
                        GO TOP
                        SCAN
                            loc_cSkuId    = STR(IIF(INLIST(TYPE("Planilha.skuid"), "C", "M"), VAL(NVL(Planilha.skuid, "")), ;
                                                IIF(TYPE("Planilha.skuid") = "N", NVL(Planilha.skuid, 0), 0)), 10)
                            loc_cNomeSku  = IIF(INLIST(TYPE("Planilha.nomesku"), "C", "M"), NVL(Planilha.nomesku, ""), "")
                            loc_cSkuAtivo = IIF(INLIST(TYPE("Planilha.skuativo"), "C", "M"), NVL(Planilha.skuativo, ""), "")
                            loc_cRefSku   = IIF(INLIST(TYPE("Planilha.refsku"), "C", "M"), NVL(Planilha.refsku, ""), "")

                            IF !SEEK(loc_cSkuId, "cursor_4c_Grade", "skuid")
                                SELECT cursor_4c_Grade
                                APPEND BLANK
                                REPLACE skuid    WITH loc_cSkuId, ;
                                    nomesku  WITH loc_cNomeSku, ;
                                    refsku   WITH loc_cRefSku, ;
                                    skuativo WITH loc_cSkuAtivo

                                SELECT Planilha
                            ENDIF
                        ENDSCAN

                        IF USED("xlResults")
                            USE IN xlResults
                        ENDIF

                        *-- MontarGrade faz GO TOP + Refresh e reinstala a celula
                        *-- editavel: popular o cursor NAO repinta a grade sozinho
                        *-- (regra #21 CLAUDE.md)
                        THIS.MontarGrade()
                        THIS.txt_4c_Planilha.Value = ""
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro em FormSIGPRVTX.Processamento")
            loc_lRecno = .F.
        ENDTRY

        RETURN loc_lRecno
    ENDPROC

    *===========================================================================
    * BtnSalvarClick - Substitui TODO o conteudo de SigPrVtx pelo conteudo da
    * grade (espelha "Grupo_Botao.cmdok.Click" do legado)
    *===========================================================================
    PROCEDURE BtnSalvarClick()
        THIS.GravarGrade()
    ENDPROC

    PROCEDURE GravarGrade()
        LOCAL loc_lOk

        *-- Pre-condicoes do cmdok.Click legado (grade vazia + confirmacao)
        IF !THIS.ValidarGrade()
            RETURN .F.
        ENDIF

        loc_lOk = THIS.this_oBusinessObject.ExcluirTodos()
        IF !loc_lOk
            RETURN .F.
        ENDIF

        SELECT cursor_4c_Grade
        GO TOP
        SCAN
            loc_lOk = THIS.this_oBusinessObject.NovoRegistro()

            IF loc_lOk
                THIS.this_oBusinessObject.this_cSkuId    = cursor_4c_Grade.skuid
                THIS.this_oBusinessObject.this_cNomeSku  = cursor_4c_Grade.nomesku
                THIS.this_oBusinessObject.this_cRefSku   = cursor_4c_Grade.refsku
                THIS.this_oBusinessObject.this_cSkuAtivo = cursor_4c_Grade.skuativo
                loc_lOk = THIS.this_oBusinessObject.Salvar()
            ENDIF

            IF !loc_lOk
                MsgErro("Favor reiniciar o Processo.", "Falha na Grava" + CHR(231) + CHR(227) + "o")
                RETURN .F.
            ENDIF

            SELECT cursor_4c_Grade
        ENDSCAN

        THIS.LimparGrade()
        MsgInfo("Registros atualizados com sucesso!", "Confirmar")

        RETURN .T.
    ENDPROC

    *===========================================================================
    * BtnEncerrarClick - Fecha o formulario (espelha "Grupo_Botao.cmdsair.Click")
    *===========================================================================
    PROCEDURE BtnEncerrarClick()
        THIS.Release()
    ENDPROC

    *===========================================================================
    * KeyPress - ESC fecha o formulario (espelha "SIGPRVTX.KeyPress" do legado:
    * If nKeyCode = 27 / thisform.grupo_Botao.cmdsair.Click / EndIf).
    * Exige KeyPreview = .T. na classe para o evento chegar ao Form.
    *===========================================================================
    PROCEDURE KeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 27
            THIS.BtnEncerrarClick()
        ENDIF
    ENDPROC

    *===========================================================================
    * Destroy - Libera os cursores locais antes de encerrar
    *===========================================================================
    PROCEDURE Destroy()
        IF USED("cursor_4c_Grade")
            USE IN cursor_4c_Grade
        ENDIF
        IF USED("Planilha")
            USE IN Planilha
        ENDIF
        IF USED("xlResults")
            USE IN xlResults
        ENDIF
        DODEFAULT()
    ENDPROC

ENDDEFINE

*==============================================================================
* TextBoxRefSkuVtx_4c - celula "Referencia SKU" (Grade.Column4 / coluna refsku)
* do FormSIGPRVTX. Eh a UNICA celula editavel do form: o SCX legado declara
* Grade.Column1/2/3.ReadOnly = .T. e NAO declara ReadOnly em Column4 nem em
* Column4.Text1, e GetPlanilha eh ReadOnly = .T. + Enabled = .F.
*
* O Valid fica EMBUTIDO na classe porque BINDEVENT em "Valid" de TextBox dentro
* de Column nao dispara de forma confiavel (regra #46 CLAUDE.md /
* TextBoxGridLookup.prg). Mesmo padrao de TextBoxProdutoLpr_4c (FormLpr.prg).
*
* O legado nao tem Valid nesta celula: a validacao delegada apenas faz cumprir
* a largura do schema (refsku char(40)) - nenhuma regra de negocio inventada.
* NAO tem lookup: o dump do legado nao consulta tabela auxiliar em campo algum.
*==============================================================================
DEFINE CLASS TextBoxRefSkuVtx_4c AS TextBox
    FontName    = "Tahoma"
    FontSize    = 8
    BorderStyle = 0
    Margin      = 0
    MaxLength   = 40

    PROCEDURE Valid()
        LOCAL loc_lRetorno
        loc_lRetorno = .T.
        IF PEMSTATUS(THISFORM, "ValidarRefSkuGrade", 5)
            loc_lRetorno = THISFORM.ValidarRefSkuGrade(THIS)
        ENDIF
        RETURN loc_lRetorno
    ENDPROC
ENDDEFINE

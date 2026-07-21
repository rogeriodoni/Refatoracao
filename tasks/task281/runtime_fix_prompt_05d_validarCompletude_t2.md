# CORRIGIR ERRO DE RUNTIME VFP9

## TAREFA OBRIGATORIA
O formulario VFP9 apresentou erro de runtime durante teste automatizado.
Voce DEVE corrigir o erro e salvar os arquivos corrigidos usando Write tool.

## ERRO DETECTADO
- Etapa: 05d_validarCompletude
- Tentativa: 2/10
- Mensagem: Validacao de completude falhou. Procedures vazias/TODOs encontrados:
[FormSigPrEs1.prg] Indicador de pendencia: *-- OptionGroup Situacao: Pendente

IMPORTANTE: Preencha TODAS as procedures vazias com codigo funcional REAL. NAO use TODO, FIXME, PLACEHOLDER ou comentarios de pendencia. Cada procedure deve ter implementacao completa.

## CONTEXTO DO ERRO


## ERROS COMUNS E SOLUCOES (Consultar CLAUDE.md)
- "Property PAGE1 is not found" -> Definir .PageCount ANTES de acessar .Page1
- "Property BACKCOLOR is not found" em PageFrame -> Remover BackColor do PageFrame, usar Page1.BackColor
- "RETURN/RETRY not allowed in TRY/CATCH" -> Usar variavel loc_lResultado e RETURN fora do TRY
- "Property ALLOWDELETE is not found" -> Grid VFP9 nao tem AllowDelete/AllowEdit/AllowAddNew
- "Property VISIBLE is not found" em Page -> Pages NAO tem .Visible, apenas PageFrame tem
- "Property ERASEPAGE is not found" -> PageFrame NAO tem ErasePage
- "Unknown member BUTTON1" -> OptionGroup: usar .Buttons(1) ao inves de .Button1
- "Property FONTNAME is not found" em OptionGroup -> OptionGroup NAO tem FontName/FontSize, definir nas Buttons(N)
- "Property FONTNAME is not found" em Grid -> SetAll("FontName",...,"Column") invalido, usar Grid.FontName diretamente
- "Alias XXX is not found" -> Criar cursor ANTES de definir ControlSource
- "Property THIS_CNOMETABELA is not found" -> Usar this_cTabela (nao this_cNomeTabela)
- "Property OBTERTODOS is not found" -> Usar Buscar("") (nao ObterTodos)
- "Property RELEASE is not found" -> Custom/BO NAO tem Release(), usar = .NULL.
- "Function argument value, type, or count is invalid" em FormParaBO -> Se TextBox.Value ja eh numerico, NAO usar VAL()
- "Unknown member PAGE1" apos WITH PageFrame -> Mover config das Pages para FORA do WITH block
- "PAGE1" ou "COLUMN1" apos .Name -> NUNCA usar .Name em Pages ou Columns (rename quebra TODAS as referencias .Page1/.Column1 no resto do codigo)
- BINDEVENT nao funciona -> Metodo deve ser PUBLIC (sem PROTECTED)
- "Incorrect syntax near" em SQL com EscaparSQL/FormatarDataSQL -> Estas funcoes JA INCLUEM aspas. NUNCA adicionar aspas extras: usar campo = " + EscaparSQL(val), NAO campo = '" + EscaparSQL(val) + "'"
- TIMEOUT sem mensagem de erro visivel -> Provavelmente dialog modal de erro travando VFP

## REGRAS OBRIGATORIAS
- Corrigir APENAS o erro indicado, NAO alterar logica de negocio
- NAO remover campos, funcionalidades ou lookups
- NAO alterar nomes de tabelas/colunas do banco (PILAR 2)
- Manter nomenclatura padronizada _4c_ (PILAR 3)
- Strings SQL longas DEVEM ser quebradas com `+;` (continuation) a cada 3-4 campos - NUNCA numa unica linha
- Usar Write tool para salvar os arquivos corrigidos nos mesmos caminhos

## CODIGO ATUAL DOS ARQUIVOS

### FORM (C:\4c\projeto\app\forms\operacionais\FormSigPrEs1.prg):
*==============================================================================
* FormSigPrEs1.prg - Posicao Por Movimentacao
* Form OPERACIONAL - filtro de movimentacoes em SigMvCab
* Abre sigpres2 com os resultados filtrados
* Herda de FormBase
*==============================================================================

DEFINE CLASS FormSigPrEs1 AS FormBase

    *-- Propriedades visuais
    Height       = 600
    Width        = 1000
    AutoCenter   = .T.
    ShowWindow = 1
    WindowType = 1
    ControlBox   = .F.
    MaxButton    = .F.
    MinButton    = .F.
    TitleBar     = 0
    Closable     = .F.
    BorderStyle  = 2
    ClipControls = .F.
    Themes       = .F.
    DataSession  = 2

    *-- Business Object
    this_oBusinessObject = .NULL.

    *===========================================================================
    * Init - DODEFAULT() chama FormBase.Init() que chama InicializarForm()
    *===========================================================================
    PROCEDURE Init()
        RETURN DODEFAULT()
    ENDPROC

    *===========================================================================
    * InicializarForm - Conecta BO, configura layout e inicializa controles
    *===========================================================================
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lResultado, loc_oErro
        loc_lResultado = .F.

        TRY
            *-- Cria Business Object
            THIS.this_oBusinessObject = CREATEOBJECT("SigPrEs1BO")

            IF VARTYPE(THIS.this_oBusinessObject) != "O"
                MsgErro("Falha ao criar SigPrEs1BO", "Erro")
                loc_lResultado = .F.
            ENDIF

            *-- Configura picture de fundo (form OPERACIONAL flat)
            THIS.ConfigurarPageFrame()

            *-- Configura layout flat (sem PageFrame - form OPERACIONAL)
            THIS.ConfigurarCabecalho()
            THIS.ConfigurarContainerFiltros()
            THIS.ConfigurarBotoes()

            *-- Torna todos os controles visiveis
            THIS.TornarControlesVisiveis(THIS)

            *-- Define titulo no cabecalho
            THIS.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = "Posi" + CHR(231) + CHR(227) + "o Por Movimenta" + CHR(231) + CHR(227) + "o"
            THIS.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = "Posi" + CHR(231) + CHR(227) + "o Por Movimenta" + CHR(231) + CHR(227) + "o"

            *-- Inicializa valores dos campos
            THIS.InicializarCampos()

            *-- Liga eventos de lookup (KeyPress) aos campos
            THIS.ConfigurarBindEvents()

            loc_lResultado = .T.

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
                    " PROC=" + loc_oErro.Procedure, "Erro FormSigPrEs1.InicializarForm")
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *===========================================================================
    * ConfigurarPageFrame - Form OPERACIONAL flat (sem PageFrame real)
    * Configura picture de fundo do form (new_background.jpg do Framework)
    *===========================================================================
    PROTECTED PROCEDURE ConfigurarPageFrame()
        LOCAL loc_cImgFundo
        loc_cImgFundo = gc_4c_CaminhoBase + "Framework\imagens\new_background.jpg"
        IF FILE(loc_cImgFundo)
            THIS.Picture = loc_cImgFundo
        ENDIF
    ENDPROC

    *===========================================================================
    * ConfigurarPaginaLista - Form OPERACIONAL flat (nao possui Page1/Grid CRUD)
    * O legado SIGPRES1 eh form de filtros flat que dispara SigPrEs2 com os
    * resultados. A "lista" de resultados eh tratada em form separado; aqui a
    * area equivalente eh o container de filtros configurado no InicializarForm.
    * Metodo mantido para conformidade com contrato da FormBase multi-fase.
    *===========================================================================
    PROTECTED PROCEDURE ConfigurarPaginaLista()
        RETURN .T.
    ENDPROC

    *===========================================================================
    * ConfigurarPaginaDados - Form OPERACIONAL flat (nao possui Page2/Dados CRUD)
    * Os campos de entrada/filtro sao tratados em ConfigurarContainerFiltros().
    * Metodo mantido para conformidade com contrato da FormBase multi-fase.
    *===========================================================================
    PROTECTED PROCEDURE ConfigurarPaginaDados()
        RETURN .T.
    ENDPROC

    *===========================================================================
    * AlternarPagina - Form OPERACIONAL flat (sem PageFrame)
    * Nao ha paginas a alternar; a navegacao para resultados ocorre via
    * BtnConsultarClick que abre FormSigPrEs2. Metodo mantido para conformidade
    * com contrato da FormBase multi-fase.
    *===========================================================================
    PROCEDURE AlternarPagina(par_nPagina)
        RETURN .T.
    ENDPROC

    *===========================================================================
    * ConfigurarCabecalho - Cria container escuro do topo (cntSombra)
    *===========================================================================
    PROTECTED PROCEDURE ConfigurarCabecalho()
        THIS.AddObject("cnt_4c_Cabecalho", "Container")
        WITH THIS.cnt_4c_Cabecalho
            .Top        = 0
            .Left       = 0
            .Width      = THIS.Width
            .Height     = 80
            .BackStyle  = 1
            .BackColor  = RGB(100, 100, 100)
            .BorderWidth = 0
            .Visible    = .T.

            .AddObject("lbl_4c_Sombra", "Label")
            WITH .lbl_4c_Sombra
                .Top       = 25
                .Left      = 10
                .Width     = THIS.Width
                .Height    = 40
                .AutoSize  = .F.
                .FontName  = "Tahoma"
                .FontSize  = 18
                .FontBold  = .T.
                .BackStyle = 0
                .ForeColor = RGB(0, 0, 0)
                .Caption   = ""
                .Visible   = .T.
            ENDWITH

            .AddObject("lbl_4c_Titulo", "Label")
            WITH .lbl_4c_Titulo
                .Top       = 24
                .Left      = 10
                .Width     = THIS.Width
                .Height    = 46
                .AutoSize  = .F.
                .FontName  = "Tahoma"
                .FontSize  = 18
                .FontBold  = .T.
                .BackStyle = 0
                .ForeColor = RGB(255, 255, 255)
                .Caption   = ""
                .Visible   = .T.
            ENDWITH
        ENDWITH
    ENDPROC

    *===========================================================================
    * ConfigurarContainerFiltros - Cria cnt_4c_Container1 com todos os filtros
    * Proporcional ao original: left=84->102, width=618->752, height=249->303
    * Escalado de 823->1000 (fator ~1.215)
    *===========================================================================
    PROTECTED PROCEDURE ConfigurarContainerFiltros()
        LOCAL loc_oCnt
        THIS.AddObject("cnt_4c_Container1", "Container")
        WITH THIS.cnt_4c_Container1
            .Top        = 84
            .Left       = 102
            .Width      = 752
            .Height     = 303
            .BackStyle  = 0
            .BorderWidth = 0
            .Visible    = .T.

            *-- Label Empresa
            .AddObject("lbl_4c_Empresa", "Label")
            WITH .lbl_4c_Empresa
                .Top       = 13
                .Left      = 55
                .Width     = 60
                .Height    = 15
                .AutoSize  = .F.
                .FontName  = "Tahoma"
                .FontSize  = 8
                .BackStyle = 0
                .ForeColor = RGB(90, 90, 90)
                .Caption   = "Empresa :"
                .Visible   = .T.
            ENDWITH

            *-- Codigo Empresa (3 chars)
            .AddObject("txt_4c_CdEmpresa", "TextBox")
            WITH .txt_4c_CdEmpresa
                .Top           = 10
                .Left          = 122
                .Width         = 38
                .Height        = 23
                .FontName      = "Tahoma"
                .FontSize      = 8
                .Format        = "K!"
                .MaxLength     = 3
                .SpecialEffect = 1
                .ForeColor     = RGB(0, 0, 0)
                .Themes        = .F.
                .Value         = ""
                .Visible       = .T.
            ENDWITH

            *-- Descricao Empresa
            .AddObject("txt_4c_DsEmpresa", "TextBox")
            WITH .txt_4c_DsEmpresa
                .Top           = 10
                .Left          = 163
                .Width         = 354
                .Height        = 23
                .FontName      = "Tahoma"
                .FontSize      = 8
                .Format        = "K!"
                .MaxLength     = 40
                .SpecialEffect = 1
                .ForeColor     = RGB(0, 0, 0)
                .Themes        = .F.
                .Value         = ""
                .Visible       = .T.
            ENDWITH

            *-- CheckBox Empresa Destino
            .AddObject("chk_4c_EmpD", "CheckBox")
            WITH .chk_4c_EmpD
                .Top       = 14
                .Left      = 530
                .Width     = 120
                .Height    = 15
                .FontName  = "Tahoma"
                .FontSize  = 8
                .BackStyle = 0
                .AutoSize  = .F.
                .Alignment = 0
                .Caption   = "Empresa Destino"
                .ForeColor = RGB(90, 90, 90)
                .Value     = 0
                .Visible   = .T.
            ENDWITH

            *-- Label Periodo
            .AddObject("lbl_4c_Periodo", "Label")
            WITH .lbl_4c_Periodo
                .Top       = 41
                .Left      = 61
                .Width     = 55
                .Height    = 15
                .AutoSize  = .F.
                .FontName  = "Tahoma"
                .FontSize  = 8
                .BackStyle = 0
                .ForeColor = RGB(90, 90, 90)
                .Caption   = "Per" + CHR(237) + "odo :"
                .Visible   = .T.
            ENDWITH

            *-- Data Inicial
            .AddObject("txt_4c_DtInicial", "TextBox")
            WITH .txt_4c_DtInicial
                .Top           = 37
                .Left          = 122
                .Width         = 97
                .Height        = 23
                .FontName      = "Tahoma"
                .FontSize      = 8
                .Format        = "K"
                .SpecialEffect = 1
                .ForeColor     = RGB(0, 0, 0)
                .Themes        = .F.
                .Value         = {}
                .Visible       = .T.
            ENDWITH

            *-- Label separador "a"
            .AddObject("lbl_4c_PeriodoA", "Label")
            WITH .lbl_4c_PeriodoA
                .Top       = 41
                .Left      = 222
                .Width     = 10
                .Height    = 15
                .AutoSize  = .F.
                .FontName  = "Tahoma"
                .FontSize  = 8
                .BackStyle = 0
                .ForeColor = RGB(90, 90, 90)
                .Caption   = CHR(224)
                .Visible   = .T.
            ENDWITH

            *-- Data Final
            .AddObject("txt_4c_DtFinal", "TextBox")
            WITH .txt_4c_DtFinal
                .Top           = 37
                .Left          = 235
                .Width         = 97
                .Height        = 23
                .FontName      = "Tahoma"
                .FontSize      = 8
                .Format        = "K"
                .SpecialEffect = 1
                .ForeColor     = RGB(0, 0, 0)
                .Themes        = .F.
                .Value         = {}
                .Visible       = .T.
            ENDWITH

            *-- OptionGroup Periodo (Lancamento / Prazo Entrega)
            .AddObject("obj_4c_OptPeriodo", "OptionGroup")
            WITH .obj_4c_OptPeriodo
                .Top         = 36
                .Left        = 332
                .Width       = 225
                .Height      = 25
                .ButtonCount = 2
                .BackStyle   = 0
                .Value       = 1
                .Themes      = .F.
                .AutoSize    = .F.
                WITH .Buttons(1)
                    .Top       = 5
                    .Left      = 5
                    .Width     = 92
                    .Height    = 15
                    .AutoSize  = .F.
                    .BackStyle = 0
                    .ForeColor = RGB(90, 90, 90)
                    .Caption   = "Lan" + CHR(231) + "amento"
                ENDWITH
                WITH .Buttons(2)
                    .Top       = 5
                    .Left      = 114
                    .Width     = 105
                    .Height    = 15
                    .AutoSize  = .F.
                    .BackStyle = 0
                    .FontName  = "Tahoma"
                    .FontSize  = 8
                    .ForeColor = RGB(90, 90, 90)
                    .Caption   = "Prazo Entrega"
                ENDWITH
                .Visible = .T.
            ENDWITH

            *-- Label Movimentacao
            .AddObject("lbl_4c_Movimentacao", "Label")
            WITH .lbl_4c_Movimentacao
                .Top       = 67
                .Left      = 21
                .Width     = 95
                .Height    = 15
                .AutoSize  = .F.
                .FontName  = "Tahoma"
                .FontSize  = 8
                .BackStyle = 0
                .ForeColor = RGB(90, 90, 90)
                .Caption   = "Movimenta" + CHR(231) + CHR(227) + "o :"
                .Visible   = .T.
            ENDWITH

            *-- Campo Movimentacao / Operacao
            .AddObject("txt_4c_NmOperacao", "TextBox")
            WITH .txt_4c_NmOperacao
                .Top           = 63
                .Left          = 122
                .Width         = 182
                .Height        = 23
                .FontName      = "Tahoma"
                .FontSize      = 9
                .Format        = "K!"
                .MaxLength     = 20
                .SpecialEffect = 1
                .ForeColor     = RGB(0, 0, 0)
                .Themes        = .F.
                .Value         = ""
                .Visible       = .T.
            ENDWITH

            *-- Label Numero
            .AddObject("lbl_4c_Numero", "Label")
            WITH .lbl_4c_Numero
                .Top       = 67
                .Left      = 305
                .Width     = 40
                .Height    = 15
                .AutoSize  = .F.
                .FontName  = "Tahoma"
                .FontSize  = 8
                .BackStyle = 0
                .ForeColor = RGB(90, 90, 90)
                .Caption   = "N" + CHR(250) + "m :"
                .Visible   = .T.
            ENDWITH

            *-- Campo Numero
            .AddObject("txt_4c_Numero", "TextBox")
            WITH .txt_4c_Numero
                .Top           = 63
                .Left          = 306
                .Width         = 67
                .Height        = 23
                .FontName      = "Tahoma"
                .FontSize      = 8
                .Alignment     = 3
                .Format        = "K"
                .InputMask     = "999999"
                .SpecialEffect = 1
                .ForeColor     = RGB(0, 0, 0)
                .Themes        = .F.
                .Value         = 0
                .Visible       = .T.
            ENDWITH

            *-- Label OP
            .AddObject("lbl_4c_Op", "Label")
            WITH .lbl_4c_Op
                .Top       = 67
                .Left      = 387
                .Width     = 28
                .Height    = 15
                .AutoSize  = .F.
                .FontName  = "Tahoma"
                .FontSize  = 8
                .BackStyle = 0
                .ForeColor = RGB(90, 90, 90)
                .Caption   = "OP :"
                .Visible   = .T.
            ENDWITH

            *-- Campo OP
            .AddObject("txt_4c_Op", "TextBox")
            WITH .txt_4c_Op
                .Top           = 63
                .Left          = 423
                .Width         = 67
                .Height        = 23
                .FontName      = "Tahoma"
                .FontSize      = 8
                .Alignment     = 3
                .Format        = "K"
                .InputMask     = "999999"
                .SpecialEffect = 1
                .ForeColor     = RGB(0, 0, 0)
                .Themes        = .F.
                .Value         = 0
                .Visible       = .T.
            ENDWITH

            *-- Label Status
            .AddObject("lbl_4c_Status", "Label")
            WITH .lbl_4c_Status
                .Top       = 67
                .Left      = 498
                .Width     = 48
                .Height    = 15
                .AutoSize  = .F.
                .FontName  = "Tahoma"
                .FontSize  = 8
                .BackStyle = 0
                .ForeColor = RGB(90, 90, 90)
                .Caption   = "Status :"
                .Visible   = .T.
            ENDWITH

            *-- Campo pStatus (1 char, A=Ativo, etc)
            .AddObject("txt_4c_PStatus", "TextBox")
            WITH .txt_4c_PStatus
                .Top           = 63
                .Left          = 554
                .Width         = 21
                .Height        = 23
                .FontName      = "Tahoma"
                .FontSize      = 8
                .InputMask     = "A"
                .SpecialEffect = 1
                .ForeColor     = RGB(0, 0, 0)
                .Themes        = .F.
                .Value         = ""
                .Visible       = .T.
            ENDWITH

            *-- Label Grupo
            .AddObject("lbl_4c_Grupo", "Label")
            WITH .lbl_4c_Grupo
                .Top       = 93
                .Left      = 69
                .Width     = 47
                .Height    = 15
                .AutoSize  = .F.
                .FontName  = "Tahoma"
                .FontSize  = 8
                .BackStyle = 0
                .ForeColor = RGB(90, 90, 90)
                .Caption   = "Grupo :"
                .Visible   = .T.
            ENDWITH

            *-- Codigo Grupo Contabil
            .AddObject("txt_4c_Grupo", "TextBox")
            WITH .txt_4c_Grupo
                .Top           = 89
                .Left          = 122
                .Width         = 97
                .Height        = 23
                .FontName      = "Tahoma"
                .FontSize      = 8
                .Format        = "K"
                .MaxLength     = 10
                .SpecialEffect = 1
                .ForeColor     = RGB(0, 0, 0)
                .Themes        = .F.
                .Value         = ""
                .Visible       = .T.
            ENDWITH

            *-- Descricao Grupo
            .AddObject("txt_4c_DsGrupo", "TextBox")
            WITH .txt_4c_DsGrupo
                .Top           = 89
                .Left          = 222
                .Width         = 353
                .Height        = 23
                .FontName      = "Tahoma"
                .FontSize      = 8
                .Format        = "K"
                .MaxLength     = 20
                .SpecialEffect = 1
                .ForeColor     = RGB(0, 0, 0)
                .Themes        = .F.
                .Value         = ""
                .Visible       = .T.
            ENDWITH

            *-- Label Conta
            .AddObject("lbl_4c_Conta", "Label")
            WITH .lbl_4c_Conta
                .Top       = 119
                .Left      = 69
                .Width     = 47
                .Height    = 15
                .AutoSize  = .F.
                .FontName  = "Tahoma"
                .FontSize  = 8
                .BackStyle = 0
                .ForeColor = RGB(90, 90, 90)
                .Caption   = "Conta :"
                .Visible   = .T.
            ENDWITH

            *-- Codigo Conta (iClis)
            .AddObject("txt_4c_Conta", "TextBox")
            WITH .txt_4c_Conta
                .Top           = 115
                .Left          = 122
                .Width         = 97
                .Height        = 23
                .FontName      = "Tahoma"
                .FontSize      = 9
                .Format        = "K"
                .MaxLength     = 10
                .SpecialEffect = 1
                .ForeColor     = RGB(0, 0, 0)
                .Themes        = .F.
                .Value         = ""
                .Visible       = .T.
            ENDWITH

            *-- CPF/CNPJ (busca alternativa por documento)
            .AddObject("txt_4c_Cpf", "TextBox")
            WITH .txt_4c_Cpf
                .Top           = 115
                .Left          = 222
                .Width         = 178
                .Height        = 23
                .FontName      = "Tahoma"
                .FontSize      = 8
                .InputMask     = "XXXXXXXXXXXXXXXXXXXX"
                .MaxLength     = 20
                .SpecialEffect = 1
                .ForeColor     = RGB(0, 0, 0)
                .Themes        = .F.
                .Value         = ""
                .Visible       = .T.
            ENDWITH

            *-- Descricao Conta (rClis)
            .AddObject("txt_4c_DsConta", "TextBox")
            WITH .txt_4c_DsConta
                .Top           = 115
                .Left          = 404
                .Width         = 341
                .Height        = 23
                .FontName      = "Courier New"
                .FontSize      = 8
                .Format        = "K"
                .MaxLength     = 40
                .SpecialEffect = 1
                .ForeColor     = RGB(0, 0, 0)
                .Themes        = .F.
                .Value         = ""
                .Visible       = .T.
            ENDWITH

            *-- Label Responsavel
            .AddObject("lbl_4c_Responsavel", "Label")
            WITH .lbl_4c_Responsavel
                .Top       = 145
                .Left      = 30
                .Width     = 87
                .Height    = 15
                .AutoSize  = .F.
                .FontName  = "Tahoma"
                .FontSize  = 8
                .BackStyle = 0
                .ForeColor = RGB(90, 90, 90)
                .Caption   = "Respons" + CHR(225) + "vel :"
                .Visible   = .T.
            ENDWITH

            *-- Codigo Responsavel (Vends/iClis do vendedor)
            .AddObject("txt_4c_Resps", "TextBox")
            WITH .txt_4c_Resps
                .Top           = 141
                .Left          = 122
                .Width         = 97
                .Height        = 23
                .FontName      = "Tahoma"
                .FontSize      = 9
                .Format        = "K"
                .MaxLength     = 10
                .SpecialEffect = 1
                .ForeColor     = RGB(0, 0, 0)
                .Themes        = .F.
                .Value         = ""
                .Visible       = .T.
            ENDWITH

            *-- Descricao Responsavel
            .AddObject("txt_4c_DsResps", "TextBox")
            WITH .txt_4c_DsResps
                .Top           = 141
                .Left          = 222
                .Width         = 353
                .Height        = 23
                .FontName      = "Tahoma"
                .FontSize      = 8
                .Format        = "K"
                .MaxLength     = 40
                .SpecialEffect = 1
                .ForeColor     = RGB(0, 0, 0)
                .Themes        = .F.
                .Value         = ""
                .Visible       = .T.
            ENDWITH

            *-- Label Moeda
            .AddObject("lbl_4c_Moeda", "Label")
            WITH .lbl_4c_Moeda
                .Top       = 171
                .Left      = 66
                .Width     = 50
                .Height    = 15
                .AutoSize  = .F.
                .FontName  = "Tahoma"
                .FontSize  = 8
                .BackStyle = 0
                .ForeColor = RGB(90, 90, 90)
                .Caption   = "Moeda :"
                .Visible   = .T.
            ENDWITH

            *-- Codigo Moeda (CMoes, 3 chars)
            .AddObject("txt_4c_CdMoeda", "TextBox")
            WITH .txt_4c_CdMoeda
                .Top           = 167
                .Left          = 122
                .Width         = 38
                .Height        = 23
                .FontName      = "Tahoma"
                .FontSize      = 8
                .Format        = "K!"
                .MaxLength     = 3
                .SpecialEffect = 1
                .ForeColor     = RGB(0, 0, 0)
                .Themes        = .F.
                .Value         = ""
                .Visible       = .T.
            ENDWITH

            *-- Descricao Moeda (DMoes)
            .AddObject("txt_4c_DsMoeda", "TextBox")
            WITH .txt_4c_DsMoeda
                .Top           = 167
                .Left          = 163
                .Width         = 140
                .Height        = 23
                .FontName      = "Tahoma"
                .FontSize      = 8
                .Format        = "K!"
                .MaxLength     = 15
                .SpecialEffect = 1
                .ForeColor     = RGB(0, 0, 0)
                .Themes        = .F.
                .Value         = ""
                .Visible       = .T.
            ENDWITH

            *-- Label Cotacao
            .AddObject("lbl_4c_Cotacao", "Label")
            WITH .lbl_4c_Cotacao
                .Top       = 171
                .Left      = 308
                .Width     = 60
                .Height    = 15
                .AutoSize  = .F.
                .FontName  = "Tahoma"
                .FontSize  = 8
                .BackStyle = 0
                .ForeColor = RGB(90, 90, 90)
                .Caption   = "Cota" + CHR(231) + CHR(227) + "o :"
                .Visible   = .T.
            ENDWITH

            *-- OptionGroup Cotacao (Fechamento / Movimentacao)
            .AddObject("obj_4c_OptCotacao", "OptionGroup")
            WITH .obj_4c_OptCotacao
                .Top         = 165
                .Left        = 375
                .Width       = 247
                .Height      = 27
                .ButtonCount = 2
                .BackStyle   = 0
                .Value       = 1
                .Themes      = .F.
                .AutoSize    = .F.
                WITH .Buttons(1)
                    .Top       = 5
                    .Left      = 5
                    .Width     = 108
                    .Height    = 17
                    .AutoSize  = .F.
                    .BackStyle = 0
                    .ForeColor = RGB(90, 90, 90)
                    .Caption   = "Fechamento"
                ENDWITH
                WITH .Buttons(2)
                    .Top       = 5
                    .Left      = 122
                    .Width     = 121
                    .Height    = 17
                    .AutoSize  = .F.
                    .BackStyle = 0
                    .FontName  = "Tahoma"
                    .FontSize  = 8
                    .ForeColor = RGB(90, 90, 90)
                    .Caption   = "Movimenta" + CHR(231) + CHR(227) + "o"
                ENDWITH
                .Visible = .T.
            ENDWITH

            *-- Label Situacao
            .AddObject("lbl_4c_Situacao", "Label")
            WITH .lbl_4c_Situacao
                .Top       = 196
                .Left      = 55
                .Width     = 61
                .Height    = 15
                .AutoSize  = .F.
                .FontName  = "Tahoma"
                .FontSize  = 8
                .BackStyle = 0
                .ForeColor = RGB(90, 90, 90)
                .Caption   = "Situa" + CHR(231) + CHR(227) + "o :"
                .Visible   = .T.
            ENDWITH

            *-- OptionGroup Situacao: Pendentes, Baixadas ou Todas
            .AddObject("obj_4c_OptPendente", "OptionGroup")
            WITH .obj_4c_OptPendente
                .Top         = 191
                .Left        = 114
                .Width       = 282
                .Height      = 25
                .ButtonCount = 3
                .BackStyle   = 0
                .Value       = 3
                .Themes      = .F.
                .AutoSize    = .F.
                WITH .Buttons(1)
                    .Top       = 5
                    .Left      = 5
                    .Width     = 84
                    .Height    = 15
                    .AutoSize  = .F.
                    .BackStyle = 0
                    .ForeColor = RGB(90, 90, 90)
                    .Caption   = "Pendentes"
                ENDWITH
                WITH .Buttons(2)
                    .Top       = 5
                    .Left      = 108
                    .Width     = 74
                    .Height    = 15
                    .AutoSize  = .F.
                    .BackStyle = 0
                    .FontName  = "Tahoma"
                    .FontSize  = 8
                    .ForeColor = RGB(90, 90, 90)
                    .Caption   = "Baixadas"
                ENDWITH
                WITH .Buttons(3)
                    .Top       = 5
                    .Left      = 202
                    .Width     = 74
                    .Height    = 15
                    .AutoSize  = .F.
                    .BackStyle = 0
                    .FontName  = "Tahoma"
                    .FontSize  = 8
                    .ForeColor = RGB(90, 90, 90)
                    .Caption   = "Todas"
                ENDWITH
                .Visible = .T.
            ENDWITH

            *-- Label Impressao
            .AddObject("lbl_4c_Impressao", "Label")
            WITH .lbl_4c_Impressao
                .Top       = 218
                .Left      = 44
                .Width     = 72
                .Height    = 15
                .AutoSize  = .F.
                .FontName  = "Tahoma"
                .FontSize  = 8
                .BackStyle = 0
                .ForeColor = RGB(90, 90, 90)
                .Caption   = "Impress" + CHR(227) + "o :"
                .Visible   = .T.
            ENDWITH

            *-- OptionGroup Impressao (Por Vendedor / Por Movimentacao)
            .AddObject("obj_4c_OptImpressao", "OptionGroup")
            WITH .obj_4c_OptImpressao
                .Top         = 213
                .Left        = 114
                .Width       = 279
                .Height      = 25
                .ButtonCount = 2
                .BackStyle   = 0
                .Value       = 1
                .Themes      = .F.
                .AutoSize    = .F.
                WITH .Buttons(1)
                    .Top       = 5
                    .Left      = 5
                    .Width     = 101
                    .Height    = 15
                    .AutoSize  = .F.
                    .BackStyle = 0
                    .ForeColor = RGB(90, 90, 90)
                    .Caption   = "Por Vendedor"
                ENDWITH
                WITH .Buttons(2)
                    .Top       = 5
                    .Left      = 143
                    .Width     = 130
                    .Height    = 15
                    .AutoSize  = .F.
                    .BackStyle = 0
                    .FontName  = "Tahoma"
                    .FontSize  = 8
                    .ForeColor = RGB(90, 90, 90)
                    .Caption   = "Por Movimenta" + CHR(231) + CHR(227) + "o"
                ENDWITH
                .Visible = .T.
            ENDWITH

        ENDWITH
    ENDPROC

    *===========================================================================
    * ConfigurarBotoes - Cria CommandGroup com botoes Consultar e Encerrar
    * Proporcional: original left=665, width=161 -> new left=808, width=186
    *===========================================================================
    PROTECTED PROCEDURE ConfigurarBotoes()
        THIS.AddObject("obj_4c_Sair", "CommandGroup")
        WITH THIS.obj_4c_Sair
            .Top         = -2
            .Left        = 808
            .Width       = 186
            .Height      = 85
            .ButtonCount = 2
            .BackStyle   = 0
            .BorderStyle = 0
            .Value       = 1
            .Themes      = .F.
            .Visible     = .T.

            WITH .Buttons(1)
                .Top           = 5
                .Left          = 5
                .Width         = 75
                .Height        = 75
                .FontBold      = .T.
                .FontItalic    = .T.
                .WordWrap      = .T.
                .Caption       = "Consultar"
                .Picture       = gc_4c_CaminhoIcones + "geral_procura_60.jpg"
                .ForeColor     = RGB(90, 90, 90)
                .BackColor     = RGB(255, 255, 255)
                .Themes        = .F.
                .SpecialEffect = 0
                .MousePointer  = 15
                .PicturePosition = 13
            ENDWITH

            WITH .Buttons(2)
                .Top           = 5
                .Left          = 98
                .Width         = 75
                .Height        = 75
                .FontBold      = .T.
                .FontItalic    = .T.
                .FontName      = "Comic Sans MS"
                .FontSize      = 8
                .WordWrap      = .T.
                .Caption       = "Encerrar"
                .Cancel        = .T.
                .Picture       = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
                .ForeColor     = RGB(90, 90, 90)
                .BackColor     = RGB(255, 255, 255)
                .Themes        = .F.
                .SpecialEffect = 0
                .MousePointer  = 15
                .PicturePosition = 13
            ENDWITH
        ENDWITH

        BINDEVENT(THIS.obj_4c_Sair.Buttons(1), "Click", THIS, "BtnConsultarClick")
        BINDEVENT(THIS.obj_4c_Sair.Buttons(2), "Click", THIS, "BtnEncerrarClick")
    ENDPROC

    *===========================================================================
    * InicializarCampos - Seta valores default dos campos de filtro
    * Replica logica do Init() original
    *===========================================================================
    PROTECTED PROCEDURE InicializarCampos()
        WITH THIS.cnt_4c_Container1
            .txt_4c_NmOperacao.Value  = ""
            .txt_4c_DtInicial.Value   = DATE()
            .txt_4c_DtFinal.Value     = DATE()
            .txt_4c_Grupo.Value       = SPACE(10)
            .txt_4c_DsGrupo.Value     = SPACE(20)
            .txt_4c_Conta.Value       = SPACE(10)
            .txt_4c_DsConta.Value     = SPACE(40)
            .txt_4c_CdMoeda.Value     = " "
            .txt_4c_DsMoeda.Value     = ""
            .txt_4c_Resps.Value       = ""
            .txt_4c_DsResps.Value     = ""
            .txt_4c_Cpf.Value         = ""
            .txt_4c_Numero.Value      = 0
            .txt_4c_Op.Value          = 0
            .txt_4c_PStatus.Value     = ""
            .chk_4c_EmpD.Value        = 0

            *-- Empresa logada
            IF TYPE("go_4c_Sistema") = "O"
                .txt_4c_CdEmpresa.Value = go_4c_Sistema.cCodEmpresa
            ENDIF
            .Visible     = .T.
        ENDWITH
    ENDPROC

    *===========================================================================
    * TornarControlesVisiveis - Torna controles visiveis recursivamente
    *===========================================================================
    PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
        LOCAL loc_i, loc_oControl
        IF VARTYPE(par_oContainer) != "O"
            RETURN
        ENDIF
        FOR loc_i = 1 TO par_oContainer.ControlCount
            loc_oControl = par_oContainer.Controls(loc_i)
            IF VARTYPE(loc_oControl) = "O"
                IF PEMSTATUS(loc_oControl, "Visible", 5)
                    loc_oControl.Visible = .T.
                ENDIF
                IF UPPER(loc_oControl.BaseClass) = "PAGEFRAME"
                    LOCAL loc_nP
                    FOR loc_nP = 1 TO loc_oControl.PageCount
                        THIS.TornarControlesVisiveis(loc_oControl.Pages(loc_nP))
                    ENDFOR
                ENDIF
                IF PEMSTATUS(loc_oControl, "ControlCount", 5)
                    IF loc_oControl.ControlCount > 0
                        THIS.TornarControlesVisiveis(loc_oControl)
                    ENDIF
                ENDIF
            ENDIF
        ENDFOR
    ENDPROC

    *===========================================================================
    * FormParaBO - Transfere filtros do Form para o Business Object
    *===========================================================================
    PROCEDURE FormParaBO()
        WITH THIS.this_oBusinessObject
            .this_cEmpresa    = ALLTRIM(THIS.cnt_4c_Container1.txt_4c_CdEmpresa.Value)
            .this_cDsEmpresa  = ALLTRIM(THIS.cnt_4c_Container1.txt_4c_DsEmpresa.Value)
            .this_nEmpD       = THIS.cnt_4c_Container1.chk_4c_EmpD.Value
            .this_cNmOperacao = ALLTRIM(THIS.cnt_4c_Container1.txt_4c_NmOperacao.Value)
            .this_nNumero     = THIS.cnt_4c_Container1.txt_4c_Numero.Value
            .this_nOp         = THIS.cnt_4c_Container1.txt_4c_Op.Value
            .this_dDtInicial  = THIS.cnt_4c_Container1.txt_4c_DtInicial.Value
            .this_dDtFinal    = THIS.cnt_4c_Container1.txt_4c_DtFinal.Value
            .this_nPeriodo    = THIS.cnt_4c_Container1.obj_4c_OptPeriodo.Value
            .this_cGrupo      = ALLTRIM(THIS.cnt_4c_Container1.txt_4c_Grupo.Value)
            .this_cDsGrupo    = ALLTRIM(THIS.cnt_4c_Container1.txt_4c_DsGrupo.Value)
            .this_cConta      = ALLTRIM(THIS.cnt_4c_Container1.txt_4c_Conta.Value)
            .this_cDsConta    = ALLTRIM(THIS.cnt_4c_Container1.txt_4c_DsConta.Value)
            .this_cCpf        = ALLTRIM(THIS.cnt_4c_Container1.txt_4c_Cpf.Value)
            .this_cResps      = ALLTRIM(THIS.cnt_4c_Container1.txt_4c_Resps.Value)
            .this_cDsResps    = ALLTRIM(THIS.cnt_4c_Container1.txt_4c_DsResps.Value)
            .this_cMoeda      = ALLTRIM(THIS.cnt_4c_Container1.txt_4c_CdMoeda.Value)
            .this_cDsMoeda    = ALLTRIM(THIS.cnt_4c_Container1.txt_4c_DsMoeda.Value)
            .this_nSituacao   = THIS.cnt_4c_Container1.obj_4c_OptPendente.Value
            .this_nImpressao  = THIS.cnt_4c_Container1.obj_4c_OptImpressao.Value
            .this_nCotacao    = THIS.cnt_4c_Container1.obj_4c_OptCotacao.Value
            .this_cStatus     = ALLTRIM(THIS.cnt_4c_Container1.txt_4c_PStatus.Value)
        ENDWITH
    ENDPROC

    *===========================================================================
    * BOParaForm - Transfere valores do BO de volta ao Form
    *===========================================================================
    PROCEDURE BOParaForm()
        WITH THIS.this_oBusinessObject
            THIS.cnt_4c_Container1.txt_4c_CdEmpresa.Value  = .this_cEmpresa
            THIS.cnt_4c_Container1.txt_4c_DsEmpresa.Value  = .this_cDsEmpresa
            THIS.cnt_4c_Container1.chk_4c_EmpD.Value       = .this_nEmpD
            THIS.cnt_4c_Container1.txt_4c_NmOperacao.Value = .this_cNmOperacao
            THIS.cnt_4c_Container1.txt_4c_Numero.Value     = .this_nNumero
            THIS.cnt_4c_Container1.txt_4c_Op.Value         = .this_nOp
            THIS.cnt_4c_Container1.txt_4c_DtInicial.Value  = .this_dDtInicial
            THIS.cnt_4c_Container1.txt_4c_DtFinal.Value    = .this_dDtFinal
            THIS.cnt_4c_Container1.obj_4c_OptPeriodo.Value = .this_nPeriodo
            THIS.cnt_4c_Container1.txt_4c_Grupo.Value      = .this_cGrupo
            THIS.cnt_4c_Container1.txt_4c_DsGrupo.Value    = .this_cDsGrupo
            THIS.cnt_4c_Container1.txt_4c_Conta.Value      = .this_cConta
            THIS.cnt_4c_Container1.txt_4c_DsConta.Value    = .this_cDsConta
            THIS.cnt_4c_Container1.txt_4c_Cpf.Value        = .this_cCpf
            THIS.cnt_4c_Container1.txt_4c_Resps.Value      = .this_cResps
            THIS.cnt_4c_Container1.txt_4c_DsResps.Value    = .this_cDsResps
            THIS.cnt_4c_Container1.txt_4c_CdMoeda.Value    = .this_cMoeda
            THIS.cnt_4c_Container1.txt_4c_DsMoeda.Value    = .this_cDsMoeda
            THIS.cnt_4c_Container1.obj_4c_OptPendente.Value  = .this_nSituacao
            THIS.cnt_4c_Container1.obj_4c_OptImpressao.Value = .this_nImpressao
            THIS.cnt_4c_Container1.obj_4c_OptCotacao.Value   = .this_nCotacao
            THIS.cnt_4c_Container1.txt_4c_PStatus.Value    = .this_cStatus
        ENDWITH
    ENDPROC

    *===========================================================================
    * BtnIncluirClick - N/A (form OPERACIONAL de consulta/relat" + CHR(243) + "rio, sem CRUD)
    * SIGPRES1 eh um dialogo de filtros que dispara consulta "Posicao Por
    * Movimentacao" (abre SigPrEs2 com os resultados). Nao inclui/altera/
    * visualiza/exclui registros de negocio - apenas coleta parametros e
    * chama ExecutarConsulta() no BO. Ver BtnConsultarClick() para o fluxo
    * principal do form.
    * Metodo mantido apenas para conformidade com o contrato da pipeline (Fase 7).
    *===========================================================================
    PROCEDURE BtnIncluirClick()
        *-- Sem-operacao: dialogo de filtros nao suporta inclusao de registros.
        *-- Ver BtnConsultarClick() para executar a consulta configurada.
        RETURN
    ENDPROC

    *===========================================================================
    * BtnAlterarClick - N/A (form OPERACIONAL de consulta/relatorio, sem CRUD)
    * SIGPRES1 nao possui grid de registros nem persiste dados - os campos da
    * tela sao filtros voluteis usados apenas para montar a consulta.
    * Metodo mantido apenas para conformidade com o contrato da pipeline (Fase 7).
    *===========================================================================
    PROCEDURE BtnAlterarClick()
        *-- Sem-operacao: dialogo de filtros nao suporta alteracao de registros.
        RETURN
    ENDPROC

    *===========================================================================
    * BtnVisualizarClick - N/A (form OPERACIONAL de consulta/relatorio, sem CRUD)
    * A visualizacao dos resultados eh feita pelo form filho SigPrEs2, aberto
    * por BtnConsultarClick() apos validacao dos filtros. SIGPRES1 nao possui
    * lista propria para "visualizar" - eh o dialogo de entrada de parametros.
    * Metodo mantido apenas para conformidade com o contrato da pipeline (Fase 7).
    *===========================================================================
    PROCEDURE BtnVisualizarClick()
        *-- Sem-operacao: para visualizar resultados, chame BtnConsultarClick().
        RETURN
    ENDPROC

    *===========================================================================
    * BtnExcluirClick - N/A (form OPERACIONAL de consulta/relatorio, sem CRUD)
    * SIGPRES1 nao persiste dados nem exibe registros excluiveis. Encerrar o
    * form eh via BtnEncerrarClick() (que tambem libera o cursor csTemporario).
    * Metodo mantido apenas para conformidade com o contrato da pipeline (Fase 7).
    *===========================================================================
    PROCEDURE BtnExcluirClick()
        *-- Sem-operacao: dialogo de filtros nao suporta exclusao de registros.
        *-- Para encerrar o form, chame BtnEncerrarClick().
        RETURN
    ENDPROC

    *===========================================================================
    * BtnConsultarClick - Valida, executa consulta e abre FormSigPrEs2
    * Replica consulta.Click do legado
    *===========================================================================
    PROCEDURE BtnConsultarClick()
        LOCAL loc_lResultado, loc_cNmOp, loc_nSessaoId
        loc_lResultado = .F.

        *-- Valida campos obrigatorios
        IF EMPTY(ALLTRIM(THIS.cnt_4c_Container1.txt_4c_CdEmpresa.Value))
            MsgAviso("Empresa Inv" + CHR(225) + "lida!!!", "Aviso")
            THIS.cnt_4c_Container1.txt_4c_CdEmpresa.SetFocus()
            RETURN
        ENDIF

        IF EMPTY(ALLTRIM(THIS.cnt_4c_Container1.txt_4c_NmOperacao.Value))
            MsgAviso("Opera" + CHR(231) + CHR(227) + "o Inv" + CHR(225) + "lida!!!", "Aviso")
            THIS.cnt_4c_Container1.txt_4c_NmOperacao.SetFocus()
            RETURN
        ENDIF

        IF THIS.cnt_4c_Container1.txt_4c_DtFinal.Value < THIS.cnt_4c_Container1.txt_4c_DtInicial.Value
            MsgAviso("Per" + CHR(237) + "odo Inv" + CHR(225) + "lido!!! Data Final Menor do Que a Inicial!!!", "Aviso")
            THIS.cnt_4c_Container1.txt_4c_DtInicial.SetFocus()
            RETURN
        ENDIF

        *-- Transfere filtros para o BO
        THIS.FormParaBO()

        *-- Executa consulta
        THIS.Enabled = .F.
        TRY
            IF THIS.this_oBusinessObject.ExecutarConsulta()
                *-- Registra auditoria
                THIS.this_oBusinessObject.RegistrarAuditoria("CONSULTA")

                *-- Abre form de resultados passando operacao e DataSessionId
                loc_cNmOp     = ALLTRIM(THIS.this_oBusinessObject.this_cNmOperacao)
                loc_nSessaoId = THIS.DataSessionId

                DO FORM SigPrEs2 WITH loc_cNmOp, loc_nSessaoId, THIS

                loc_lResultado = .T.
            ELSE
                IF !EMPTY(THIS.this_oBusinessObject.this_cMensagemErro)
                    MsgAviso(THIS.this_oBusinessObject.this_cMensagemErro, "Aviso")
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
                    " PROC=" + loc_oErro.Procedure, "Erro Consulta")
        ENDTRY
        THIS.Enabled = .T.
    ENDPROC

    *===========================================================================
    * BtnEncerrarClick - Fecha o formulario
    *===========================================================================
    PROCEDURE BtnEncerrarClick()
        IF USED("csTemporario")
            USE IN csTemporario
        ENDIF
        THIS.Release()
    ENDPROC

    *===========================================================================
    * AbrirBuscaEmpresa - Abre picker de empresa (FormBuscaAuxiliar)
    * Substituto canonico de fAcessoEmpresa()
    *===========================================================================
    PROCEDURE AbrirBuscaEmpresa(par_cModo)
        LOCAL loc_oBusca, loc_nResultado, loc_cSQL
        TRY
            IF par_cModo = "C"
                loc_cSQL = "SELECT TOP 200 Cemps AS Cemps, Razas AS Razas FROM SigCdEmp ORDER BY Cemps"
            ELSE
                loc_cSQL = "SELECT TOP 200 Cemps AS Cemps, Razas AS Razas FROM SigCdEmp ORDER BY Razas"
            ENDIF

            IF USED("cursor_4c_BuscaEmp")
                USE IN cursor_4c_BuscaEmp
            ENDIF

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaEmp")
            IF loc_nResultado < 1
                RETURN
            ENDIF

            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, "", ;
                "cursor_4c_BuscaEmp", "Cemps", "", ;
                "Sele" + CHR(231) + CHR(227) + "o de Empresa", .T., .T., "")
            loc_oBusca.mAddColuna("Cemps", "", "C" + CHR(243) + "d.")
            loc_oBusca.mAddColuna("Razas", "", "Empresa")
            loc_oBusca.Show()

            IF loc_oBusca.this_lSelecionou
                THIS.cnt_4c_Container1.txt_4c_CdEmpresa.Value  = ALLTRIM(NVL(cursor_4c_BuscaEmp.Cemps, ""))
                THIS.cnt_4c_Container1.txt_4c_DsEmpresa.Value  = ALLTRIM(NVL(cursor_4c_BuscaEmp.Razas, ""))
            ENDIF

            IF USED("cursor_4c_BuscaEmp")
                USE IN cursor_4c_BuscaEmp
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro AbrirBuscaEmpresa")
        ENDTRY
    ENDPROC

    *===========================================================================
    * AbrirBuscaOperacao - Abre picker de operacao (SigCdOpe.Dopes)
    *===========================================================================
    PROCEDURE AbrirBuscaOperacao(par_cValor)
        LOCAL loc_oBusca, loc_nResultado, loc_cSQL, loc_cWhere
        TRY
            loc_cWhere = ""
            IF !EMPTY(ALLTRIM(par_cValor))
                loc_cWhere = "WHERE Dopes LIKE " + EscaparSQL(ALLTRIM(par_cValor) + "%")
            ENDIF

            loc_cSQL = "SELECT TOP 200 Dopes FROM SigCdOpe " + loc_cWhere + " ORDER BY Dopes"

            IF USED("cursor_4c_BuscaOpe")
                USE IN cursor_4c_BuscaOpe
            ENDIF

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaOpe")
            IF loc_nResultado < 1
                RETURN
            ENDIF

            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, "", ;
                "cursor_4c_BuscaOpe", "Dopes", "", ;
                "Opera" + CHR(231) + CHR(227) + "o", .T., .T., "")
            loc_oBusca.mAddColuna("Dopes", "", "Opera" + CHR(231) + CHR(227) + "o")
            loc_oBusca.Show()

            IF loc_oBusca.this_lSelecionou
                THIS.cnt_4c_Container1.txt_4c_NmOperacao.Value = ALLTRIM(NVL(cursor_4c_BuscaOpe.Dopes, ""))
            ENDIF

            IF USED("cursor_4c_BuscaOpe")
                USE IN cursor_4c_BuscaOpe
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro AbrirBuscaOperacao")
        ENDTRY
    ENDPROC

    *===========================================================================
    * AbrirBuscaMoeda - Abre picker de moeda (SigCdMoe)
    *===========================================================================
    PROCEDURE AbrirBuscaMoeda(par_cModo, par_cValor)
        LOCAL loc_oBusca, loc_nResultado, loc_cSQL, loc_cWhere
        TRY
            IF par_cModo = "C"
                loc_cWhere = IIF(EMPTY(ALLTRIM(par_cValor)), "", ;
                    "WHERE CMoes LIKE " + EscaparSQL(ALLTRIM(par_cValor) + "%"))
                loc_cSQL = "SELECT TOP 100 CMoes, DMoes FROM SigCdMoe " + ;
                    loc_cWhere + " ORDER BY CMoes"
            ELSE
                loc_cWhere = IIF(EMPTY(ALLTRIM(par_cValor)), "", ;
                    "WHERE RTRIM(DMoes) LIKE " + EscaparSQL(ALLTRIM(par_cValor) + "%"))
                loc_cSQL = "SELECT TOP 100 CMoes, DMoes FROM SigCdMoe " + ;
                    loc_cWhere + " ORDER BY DMoes"
            ENDIF

            IF USED("cursor_4c_BuscaMoe")
                USE IN cursor_4c_BuscaMoe
            ENDIF

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaMoe")
            IF loc_nResultado < 1
                RETURN
            ENDIF

            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, "", ;
                "cursor_4c_BuscaMoe", IIF(par_cModo = "C", "CMoes", "DMoes"), "", ;
                "Sele" + CHR(231) + CHR(227) + "o de Moeda", .T., .T., "")
            loc_oBusca.mAddColuna("CMoes", "", "C" + CHR(243) + "d.")
            loc_oBusca.mAddColuna("DMoes", "", "Descri" + CHR(231) + CHR(227) + "o")
            loc_oBusca.Show()

            IF loc_oBusca.this_lSelecionou
                THIS.cnt_4c_Container1.txt_4c_CdMoeda.Value = ALLTRIM(NVL(cursor_4c_BuscaMoe.CMoes, ""))
                THIS.cnt_4c_Container1.txt_4c_DsMoeda.Value = ALLTRIM(NVL(cursor_4c_BuscaMoe.DMoes, ""))
            ENDIF

            IF USED("cursor_4c_BuscaMoe")
                USE IN cursor_4c_BuscaMoe
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro AbrirBuscaMoeda")
        ENDTRY
    ENDPROC

    *===========================================================================
    * AbrirBuscaConta - Abre picker de conta SigCdCli (por codigo ou descricao)
    * Substituto canonico de fAcessoContas()
    *===========================================================================
    PROCEDURE AbrirBuscaConta(par_cModo, par_cGrupo, par_cValor)
        LOCAL loc_oBusca, loc_nResultado, loc_cSQL, loc_cWhere
        TRY
            IF par_cModo = "C"
                loc_cWhere = "WHERE IClis LIKE " + EscaparSQL(ALLTRIM(par_cValor) + "%")
            ELSE
                loc_cWhere = "WHERE RTRIM(RClis) LIKE " + EscaparSQL(ALLTRIM(par_cValor) + "%")
            ENDIF

            IF !EMPTY(ALLTRIM(par_cGrupo))
                loc_cWhere = loc_cWhere + " AND Grupos = " + EscaparSQL(PADR(ALLTRIM(par_cGrupo), 10))
            ENDIF

            loc_cSQL = "SELECT TOP 200 IClis, RClis, Cpfs FROM SigCdCli " + ;
                loc_cWhere + " ORDER BY IClis"

            IF USED("cursor_4c_BuscaCli")
                USE IN cursor_4c_BuscaCli
            ENDIF

            IF EMPTY(ALLTRIM(par_cValor))
                loc_cSQL = "SELECT TOP 200 IClis, RClis, Cpfs FROM SigCdCli ORDER BY IClis"
            ENDIF

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaCli")
            IF loc_nResultado < 1
                RETURN
            ENDIF

            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, "", ;
                "cursor_4c_BuscaCli", IIF(par_cModo = "C", "IClis", "RClis"), "", ;
                "Sele" + CHR(231) + CHR(227) + "o de Conta", .T., .T., "")
            loc_oBusca.mAddColuna("IClis", "", "C" + CHR(243) + "digo")
            loc_oBusca.mAddColuna("RClis", "", "Nome")
            loc_oBusca.Show()

            IF loc_oBusca.this_lSelecionou
                THIS.cnt_4c_Container1.txt_4c_Conta.Value   = ALLTRIM(NVL(cursor_4c_BuscaCli.IClis, ""))
                THIS.cnt_4c_Container1.txt_4c_DsConta.Value = ALLTRIM(NVL(cursor_4c_BuscaCli.RClis, ""))
                THIS.cnt_4c_Container1.txt_4c_Cpf.Value     = ALLTRIM(NVL(cursor_4c_BuscaCli.Cpfs, ""))
            ENDIF

            IF USED("cursor_4c_BuscaCli")
                USE IN cursor_4c_BuscaCli
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro AbrirBuscaConta")
        ENDTRY
    ENDPROC

    *===========================================================================
    * AbrirBuscaResponsavel - Abre picker de responsavel/vendedor (SigCdCli)
    * Usa grupo padrao de vendedores (this_oBusinessObject.this_cGrPadVens)
    *===========================================================================
    PROCEDURE AbrirBuscaResponsavel(par_cModo, par_cValor)
        LOCAL loc_oBusca, loc_nResultado, loc_cSQL, loc_cWhere, loc_cGrPadVens
        TRY
            loc_cGrPadVens = ""
            IF VARTYPE(THIS.this_oBusinessObject) = "O"
                loc_cGrPadVens = ALLTRIM(THIS.this_oBusinessObject.this_cGrPadVens)
            ENDIF

            IF par_cModo = "C"
                loc_cWhere = "WHERE IClis LIKE " + EscaparSQL(ALLTRIM(par_cValor) + "%")
            ELSE
                loc_cWhere = "WHERE RTRIM(RClis) LIKE " + EscaparSQL(ALLTRIM(par_cValor) + "%")
            ENDIF

            IF !EMPTY(loc_cGrPadVens)
                loc_cWhere = loc_cWhere + " AND Grupos = " + EscaparSQL(PADR(loc_cGrPadVens, 10))
            ENDIF

            loc_cSQL = "SELECT TOP 200 IClis, RClis FROM SigCdCli " + ;
                loc_cWhere + " ORDER BY IClis"

            IF EMPTY(ALLTRIM(par_cValor))
                IF EMPTY(loc_cGrPadVens)
                    loc_cSQL = "SELECT TOP 200 IClis, RClis FROM SigCdCli ORDER BY IClis"
                ELSE
                    loc_cSQL = "SELECT TOP 200 IClis, RClis FROM SigCdCli WHERE Grupos = " + ;
                        EscaparSQL(PADR(loc_cGrPadVens, 10)) + " ORDER BY IClis"
                ENDIF
            ENDIF

            IF USED("cursor_4c_BuscaResp")
                USE IN cursor_4c_BuscaResp
            ENDIF

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaResp")
            IF loc_nResultado < 1
                RETURN
            ENDIF

            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, "", ;
                "cursor_4c_BuscaResp", IIF(par_cModo = "C", "IClis", "RClis"), "", ;
                "Sele" + CHR(231) + CHR(227) + "o de Respons" + CHR(225) + "vel", .T., .T., "")
            loc_oBusca.mAddColuna("IClis", "", "C" + CHR(243) + "digo")
            loc_oBusca.mAddColuna("RClis", "", "Nome")
            loc_oBusca.Show()

            IF loc_oBusca.this_lSelecionou
                THIS.cnt_4c_Container1.txt_4c_Resps.Value   = ALLTRIM(NVL(cursor_4c_BuscaResp.IClis, ""))
                THIS.cnt_4c_Container1.txt_4c_DsResps.Value = ALLTRIM(NVL(cursor_4c_BuscaResp.RClis, ""))
            ENDIF

            IF USED("cursor_4c_BuscaResp")
                USE IN cursor_4c_BuscaResp
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro AbrirBuscaResponsavel")
        ENDTRY
    ENDPROC

    *===========================================================================
    * ValidarCdEmpresa - Handler KeyPress de txt_4c_CdEmpresa
    * ENTER/TAB: SELECT exato; miss -> AbrirBuscaEmpresa
    * F4: abre picker direto
    *===========================================================================
    PROCEDURE ValidarCdEmpresa
        LPARAMETERS par_nKeyCode, par_nShiftAltCtrl
        LOCAL loc_nResultado, loc_cSQL, loc_cCod
        IF par_nKeyCode != 13 AND par_nKeyCode != 9 AND par_nKeyCode != 115
            RETURN
        ENDIF
        IF par_nKeyCode = 115
            THIS.AbrirBuscaEmpresa("C")
            RETURN
        ENDIF
        loc_cCod = ALLTRIM(THIS.cnt_4c_Container1.txt_4c_CdEmpresa.Value)
        IF EMPTY(loc_cCod)
            THIS.cnt_4c_Container1.txt_4c_DsEmpresa.Value = ""
            RETURN
        ENDIF
        TRY
            loc_cSQL = "SELECT TOP 1 Cemps, Razas FROM SigCdEmp WHERE Cemps = " + EscaparSQL(loc_cCod)
            IF USED("cursor_4c_EmpTmp")
                USE IN cursor_4c_EmpTmp
            ENDIF
            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_EmpTmp")
            IF loc_nResultado >= 1
                SELECT cursor_4c_EmpTmp
                IF !EOF("cursor_4c_EmpTmp")
                    THIS.cnt_4c_Container1.txt_4c_CdEmpresa.Value  = ALLTRIM(NVL(cursor_4c_EmpTmp.Cemps, ""))
                    THIS.cnt_4c_Container1.txt_4c_DsEmpresa.Value  = ALLTRIM(NVL(cursor_4c_EmpTmp.Razas, ""))
                    USE IN cursor_4c_EmpTmp
                    RETURN
                ENDIF
                USE IN cursor_4c_EmpTmp
            ENDIF
            THIS.AbrirBuscaEmpresa("C")
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ValidarCdEmpresa")
        ENDTRY
    ENDPROC

    *===========================================================================
    * ValidarDsEmpresa - Handler KeyPress de txt_4c_DsEmpresa
    *===========================================================================
    PROCEDURE ValidarDsEmpresa
        LPARAMETERS par_nKeyCode, par_nShiftAltCtrl
        LOCAL loc_nResultado, loc_cSQL, loc_cDs
        IF par_nKeyCode != 13 AND par_nKeyCode != 9 AND par_nKeyCode != 115
            RETURN
        ENDIF
        IF par_nKeyCode = 115
            THIS.AbrirBuscaEmpresa("D")
            RETURN
        ENDIF
        loc_cDs = ALLTRIM(THIS.cnt_4c_Container1.txt_4c_DsEmpresa.Value)
        IF EMPTY(loc_cDs)
            THIS.cnt_4c_Container1.txt_4c_CdEmpresa.Value = ""
            RETURN
        ENDIF
        TRY
            loc_cSQL = "SELECT TOP 1 Cemps, Razas FROM SigCdEmp WHERE RTRIM(Razas) LIKE " + ;
                EscaparSQL(loc_cDs + "%")
            IF USED("cursor_4c_EmpTmp")
                USE IN cursor_4c_EmpTmp
            ENDIF
            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_EmpTmp")
            IF loc_nResultado >= 1
                SELECT cursor_4c_EmpTmp
                IF !EOF("cursor_4c_EmpTmp")
                    THIS.cnt_4c_Container1.txt_4c_CdEmpresa.Value = ALLTRIM(NVL(cursor_4c_EmpTmp.Cemps, ""))
                    THIS.cnt_4c_Container1.txt_4c_DsEmpresa.Value = ALLTRIM(NVL(cursor_4c_EmpTmp.Razas, ""))
                    USE IN cursor_4c_EmpTmp
                    RETURN
                ENDIF
                USE IN cursor_4c_EmpTmp
            ENDIF
            THIS.AbrirBuscaEmpresa("D")
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ValidarDsEmpresa")
        ENDTRY
    ENDPROC

    *===========================================================================
    * ValidarNmOperacao - Handler KeyPress de txt_4c_NmOperacao (fAcessoMovmto)
    * ENTER/TAB/F4 -> abre picker SigCdOpe
    *===========================================================================
    PROCEDURE ValidarNmOperacao
        LPARAMETERS par_nKeyCode, par_nShiftAltCtrl
        LOCAL loc_nResultado, loc_cSQL, loc_cOpe
        IF par_nKeyCode != 13 AND par_nKeyCode != 9 AND par_nKeyCode != 115
            RETURN
        ENDIF
        loc_cOpe = ALLTRIM(THIS.cnt_4c_Container1.txt_4c_NmOperacao.Value)
        IF par_nKeyCode = 115
            THIS.AbrirBuscaOperacao(loc_cOpe)
            RETURN
        ENDIF
        IF EMPTY(loc_cOpe)
            RETURN
        ENDIF
        TRY
            loc_cSQL = "SELECT TOP 1 Dopes FROM SigCdOpe WHERE Dopes = " + EscaparSQL(PADR(loc_cOpe, 20))
            IF USED("cursor_4c_OpeTmp")
                USE IN cursor_4c_OpeTmp
            ENDIF
            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_OpeTmp")
            IF loc_nResultado >= 1
                SELECT cursor_4c_OpeTmp
                IF !EOF("cursor_4c_OpeTmp")
                    THIS.cnt_4c_Container1.txt_4c_NmOperacao.Value = ALLTRIM(NVL(cursor_4c_OpeTmp.Dopes, ""))
                    USE IN cursor_4c_OpeTmp
                    RETURN
                ENDIF
                USE IN cursor_4c_OpeTmp
            ENDIF
            THIS.AbrirBuscaOperacao(loc_cOpe)
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ValidarNmOperacao")
        ENDTRY
    ENDPROC

    *===========================================================================
    * ValidarCdGrupo - Handler KeyPress de txt_4c_Grupo
    * Usa fAcessoContab substituido por SQL direto + FormBuscaAuxiliar
    *===========================================================================
    PROCEDURE ValidarCdGrupo
        LPARAMETERS par_nKeyCode, par_nShiftAltCtrl
        LOCAL loc_nResultado, loc_cSQL, loc_cGrp, loc_oBusca
        IF par_nKeyCode != 13 AND par_nKeyCode != 9 AND par_nKeyCode != 115
            RETURN
        ENDIF
        loc_cGrp = ALLTRIM(THIS.cnt_4c_Container1.txt_4c_Grupo.Value)
        IF par_nKeyCode = 115 OR EMPTY(loc_cGrp)
            THIS.AbrirBuscaGrupoContabil("C", loc_cGrp)
            RETURN
        ENDIF
        TRY
            loc_cSQL = "SELECT TOP 1 codigos, descrs FROM SigCdGcr WHERE codigos = " + ;
                EscaparSQL(PADR(loc_cGrp, 10))
            IF USED("cursor_4c_GrpTmp")
                USE IN cursor_4c_GrpTmp
            ENDIF
            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_GrpTmp")
            IF loc_nResultado >= 1
                SELECT cursor_4c_GrpTmp
                IF !EOF("cursor_4c_GrpTmp")
                    THIS.cnt_4c_Container1.txt_4c_Grupo.Value    = ALLTRIM(NVL(cursor_4c_GrpTmp.codigos, ""))
                    THIS.cnt_4c_Container1.txt_4c_DsGrupo.Value  = ALLTRIM(NVL(cursor_4c_GrpTmp.descrs, ""))
                    USE IN cursor_4c_GrpTmp
                    RETURN
                ENDIF
                USE IN cursor_4c_GrpTmp
            ENDIF
            THIS.AbrirBuscaGrupoContabil("C", loc_cGrp)
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ValidarCdGrupo")
        ENDTRY
    ENDPROC

    *===========================================================================
    * ValidarDsGrupo - Handler KeyPress de txt_4c_DsGrupo
    *===========================================================================
    PROCEDURE ValidarDsGrupo
        LPARAMETERS par_nKeyCode, par_nShiftAltCtrl
        LOCAL loc_nResultado, loc_cSQL, loc_cDs, loc_oBusca
        IF par_nKeyCode != 13 AND par_nKeyCode != 9 AND par_nKeyCode != 115
            RETURN
        ENDIF
        loc_cDs = ALLTRIM(THIS.cnt_4c_Container1.txt_4c_DsGrupo.Value)
        IF par_nKeyCode = 115 OR EMPTY(loc_cDs)
            THIS.AbrirBuscaGrupoContabil("D", loc_cDs)
            RETURN
        ENDIF
        TRY
            loc_cSQL = "SELECT TOP 1 codigos, descrs FROM SigCdGcr WHERE RTRIM(descrs) LIKE " + ;
                EscaparSQL(loc_cDs + "%")
            IF USED("cursor_4c_GrpTmp")
                USE IN cursor_4c_GrpTmp
            ENDIF
            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_GrpTmp")
            IF loc_nResultado >= 1
                SELECT cursor_4c_GrpTmp
                IF !EOF("cursor_4c_GrpTmp")
                    THIS.cnt_4c_Container1.txt_4c_Grupo.Value   = ALLTRIM(NVL(cursor_4c_GrpTmp.codigos, ""))
                    THIS.cnt_4c_Container1.txt_4c_DsGrupo.Value = ALLTRIM(NVL(cursor_4c_GrpTmp.descrs, ""))
                    USE IN cursor_4c_GrpTmp
                    RETURN
                ENDIF
                USE IN cursor_4c_GrpTmp
            ENDIF
            THIS.AbrirBuscaGrupoContabil("D", loc_cDs)
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ValidarDsGrupo")
        ENDTRY
    ENDPROC

    *===========================================================================
    * AbrirBuscaGrupoContabil - Picker SigCdGcr (codigos/descrs com r)
    *===========================================================================
    PROCEDURE AbrirBuscaGrupoContabil(par_cModo, par_cValor)
        LOCAL loc_oBusca, loc_nResultado, loc_cSQL, loc_cWhere
        TRY
            IF par_cModo = "C"
                loc_cWhere = IIF(EMPTY(ALLTRIM(par_cValor)), "", ;
                    "WHERE codigos LIKE " + EscaparSQL(ALLTRIM(par_cValor) + "%"))
            ELSE
                loc_cWhere = IIF(EMPTY(ALLTRIM(par_cValor)), "", ;
                    "WHERE RTRIM(descrs) LIKE " + EscaparSQL(ALLTRIM(par_cValor) + "%"))
            ENDIF
            loc_cSQL = "SELECT TOP 200 codigos, descrs FROM SigCdGcr " + loc_cWhere + " ORDER BY codigos"

            IF USED("cursor_4c_BuscaGcr")
                USE IN cursor_4c_BuscaGcr
            ENDIF
            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaGcr")
            IF loc_nResultado < 1
                RETURN
            ENDIF

            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, "", ;
                "cursor_4c_BuscaGcr", IIF(par_cModo = "C", "codigos", "descrs"), "", ;
                "Sele" + CHR(231) + CHR(227) + "o de Grupo", .T., .T., "")
            loc_oBusca.mAddColuna("codigos", "", "C" + CHR(243) + "digo")
            loc_oBusca.mAddColuna("descrs", "", "Descri" + CHR(231) + CHR(227) + "o")
            loc_oBusca.Show()

            IF loc_oBusca.this_lSelecionou
                THIS.cnt_4c_Container1.txt_4c_Grupo.Value   = ALLTRIM(NVL(cursor_4c_BuscaGcr.codigos, ""))
                THIS.cnt_4c_Container1.txt_4c_DsGrupo.Value = ALLTRIM(NVL(cursor_4c_BuscaGcr.descrs, ""))
            ENDIF

            IF USED("cursor_4c_BuscaGcr")
                USE IN cursor_4c_BuscaGcr
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro AbrirBuscaGrupoContabil")
        ENDTRY
    ENDPROC

    *===========================================================================
    * ValidarCdConta - Handler KeyPress de txt_4c_Conta
    *===========================================================================
    PROCEDURE ValidarCdConta
        LPARAMETERS par_nKeyCode, par_nShiftAltCtrl
        LOCAL loc_nResultado, loc_cSQL, loc_cCta, loc_cGrp
        IF par_nKeyCode != 13 AND par_nKeyCode != 9 AND par_nKeyCode != 115
            RETURN
        ENDIF
        loc_cCta = ALLTRIM(THIS.cnt_4c_Container1.txt_4c_Conta.Value)
        loc_cGrp = ALLTRIM(THIS.cnt_4c_Container1.txt_4c_Grupo.Value)
        IF par_nKeyCode = 115 OR EMPTY(loc_cCta)
            THIS.AbrirBuscaConta("C", loc_cGrp, loc_cCta)
            RETURN
        ENDIF
        TRY
            loc_cSQL = "SELECT TOP 1 IClis, RClis, Cpfs FROM SigCdCli WHERE IClis = " + ;
                EscaparSQL(PADR(loc_cCta, 10))
            IF !EMPTY(loc_cGrp)
                loc_cSQL = loc_cSQL + " AND Grupos = " + EscaparSQL(PADR(loc_cGrp, 10))
            ENDIF
            IF USED("cursor_4c_CtaTmp")
                USE IN cursor_4c_CtaTmp
            ENDIF
            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_CtaTmp")
            IF loc_nResultado >= 1
                SELECT cursor_4c_CtaTmp
                IF !EOF("cursor_4c_CtaTmp")
                    THIS.cnt_4c_Container1.txt_4c_Conta.Value   = ALLTRIM(NVL(cursor_4c_CtaTmp.IClis, ""))
                    THIS.cnt_4c_Container1.txt_4c_DsConta.Value = ALLTRIM(NVL(cursor_4c_CtaTmp.RClis, ""))
                    THIS.cnt_4c_Container1.txt_4c_Cpf.Value     = ALLTRIM(NVL(cursor_4c_CtaTmp.Cpfs, ""))
                    USE IN cursor_4c_CtaTmp
                    RETURN
                ENDIF
                USE IN cursor_4c_CtaTmp
            ENDIF
            THIS.AbrirBuscaConta("C", loc_cGrp, loc_cCta)
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ValidarCdConta")
        ENDTRY
    ENDPROC

    *===========================================================================
    * ValidarDsConta - Handler KeyPress de txt_4c_DsConta
    *===========================================================================
    PROCEDURE ValidarDsConta
        LPARAMETERS par_nKeyCode, par_nShiftAltCtrl
        LOCAL loc_nResultado, loc_cSQL, loc_cDs, loc_cGrp
        IF par_nKeyCode != 13 AND par_nKeyCode != 9 AND par_nKeyCode != 115
            RETURN
        ENDIF
        loc_cDs  = ALLTRIM(THIS.cnt_4c_Container1.txt_4c_DsConta.Value)
        loc_cGrp = ALLTRIM(THIS.cnt_4c_Container1.txt_4c_Grupo.Value)
        IF par_nKeyCode = 115 OR EMPTY(loc_cDs)
            THIS.AbrirBuscaConta("D", loc_cGrp, loc_cDs)
            RETURN
        ENDIF
        TRY
            loc_cSQL = "SELECT TOP 1 IClis, RClis, Cpfs FROM SigCdCli WHERE RTRIM(RClis) LIKE " + ;
                EscaparSQL(loc_cDs + "%")
            IF !EMPTY(loc_cGrp)
                loc_cSQL = loc_cSQL + " AND Grupos = " + EscaparSQL(PADR(loc_cGrp, 10))
            ENDIF
            IF USED("cursor_4c_CtaTmp")
                USE IN cursor_4c_CtaTmp
            ENDIF
            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_CtaTmp")
            IF loc_nResultado >= 1
                SELECT cursor_4c_CtaTmp
                IF !EOF("cursor_4c_CtaTmp")
                    THIS.cnt_4c_Container1.txt_4c_Conta.Value   = ALLTRIM(NVL(cursor_4c_CtaTmp.IClis, ""))
                    THIS.cnt_4c_Container1.txt_4c_DsConta.Value = ALLTRIM(NVL(cursor_4c_CtaTmp.RClis, ""))
                    THIS.cnt_4c_Container1.txt_4c_Cpf.Value     = ALLTRIM(NVL(cursor_4c_CtaTmp.Cpfs, ""))
                    USE IN cursor_4c_CtaTmp
                    RETURN
                ENDIF
                USE IN cursor_4c_CtaTmp
            ENDIF
            THIS.AbrirBuscaConta("D", loc_cGrp, loc_cDs)
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ValidarDsConta")
        ENDTRY
    ENDPROC

    *===========================================================================
    * ValidarCpf - Handler KeyPress de txt_4c_Cpf
    * Valida CPF/CNPJ e popula txt_4c_Conta/txt_4c_DsConta
    *===========================================================================
    PROCEDURE ValidarCpf
        LPARAMETERS par_nKeyCode, par_nShiftAltCtrl
        LOCAL loc_oCpfRet, loc_cCpf
        IF par_nKeyCode != 13 AND par_nKeyCode != 9
            RETURN
        ENDIF
        loc_cCpf = ALLTRIM(THIS.cnt_4c_Container1.txt_4c_Cpf.Value)
        IF EMPTY(loc_cCpf)
            THIS.cnt_4c_Container1.txt_4c_Conta.Value   = ""
            THIS.cnt_4c_Container1.txt_4c_DsConta.Value = ""
            RETURN
        ENDIF
        TRY
            loc_oCpfRet = THIS.this_oBusinessObject.ValidarCpfCnpj(loc_cCpf)
            IF !loc_oCpfRet.lValido
                IF !EMPTY(loc_oCpfRet.cErro)
                    MsgAviso(loc_oCpfRet.cErro, "Aviso")
                    THIS.cnt_4c_Container1.txt_4c_Cpf.Value     = ""
                    THIS.cnt_4c_Container1.txt_4c_Conta.Value   = ""
                    THIS.cnt_4c_Container1.txt_4c_DsConta.Value = ""
                ENDIF
                RETURN
            ENDIF
            IF !EMPTY(loc_oCpfRet.cConta)
                THIS.cnt_4c_Container1.txt_4c_Conta.Value   = ALLTRIM(loc_oCpfRet.cConta)
                THIS.cnt_4c_Container1.txt_4c_DsConta.Value = ALLTRIM(loc_oCpfRet.cDsConta)
                THIS.cnt_4c_Container1.txt_4c_Cpf.Value     = ALLTRIM(loc_oCpfRet.cCpf)
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ValidarCpf")
        ENDTRY
    ENDPROC

    *===========================================================================
    * ValidarCdResps - Handler KeyPress de txt_4c_Resps
    *===========================================================================
    PROCEDURE ValidarCdResps
        LPARAMETERS par_nKeyCode, par_nShiftAltCtrl
        LOCAL loc_nResultado, loc_cSQL, loc_cCod, loc_cGrpPad
        IF par_nKeyCode != 13 AND par_nKeyCode != 9 AND par_nKeyCode != 115
            RETURN
        ENDIF
        loc_cCod    = ALLTRIM(THIS.cnt_4c_Container1.txt_4c_Resps.Value)
        loc_cGrpPad = IIF(VARTYPE(THIS.this_oBusinessObject) = "O", ;
                          ALLTRIM(THIS.this_oBusinessObject.this_cGrPadVens), "")
        IF par_nKeyCode = 115 OR EMPTY(loc_cCod)
            THIS.AbrirBuscaResponsavel("C", loc_cCod)
            RETURN
        ENDIF
        TRY
            loc_cSQL = "SELECT TOP 1 IClis, RClis FROM SigCdCli WHERE IClis = " + ;
                EscaparSQL(PADR(loc_cCod, 10))
            IF !EMPTY(loc_cGrpPad)
                loc_cSQL = loc_cSQL + " AND Grupos = " + EscaparSQL(PADR(loc_cGrpPad, 10))
            ENDIF
            IF USED("cursor_4c_RespTmp")
                USE IN cursor_4c_RespTmp
            ENDIF
            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_RespTmp")
            IF loc_nResultado >= 1
                SELECT cursor_4c_RespTmp
                IF !EOF("cursor_4c_RespTmp")
                    THIS.cnt_4c_Container1.txt_4c_Resps.Value   = ALLTRIM(NVL(cursor_4c_RespTmp.IClis, ""))
                    THIS.cnt_4c_Container1.txt_4c_DsResps.Value = ALLTRIM(NVL(cursor_4c_RespTmp.RClis, ""))
                    USE IN cursor_4c_RespTmp
                    RETURN
                ENDIF
                USE IN cursor_4c_RespTmp
            ENDIF
            THIS.AbrirBuscaResponsavel("C", loc_cCod)
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ValidarCdResps")
        ENDTRY
    ENDPROC

    *===========================================================================
    * ValidarDsResps - Handler KeyPress de txt_4c_DsResps
    *===========================================================================
    PROCEDURE ValidarDsResps
        LPARAMETERS par_nKeyCode, par_nShiftAltCtrl
        LOCAL loc_nResultado, loc_cSQL, loc_cDs, loc_cGrpPad
        IF par_nKeyCode != 13 AND par_nKeyCode != 9 AND par_nKeyCode != 115
            RETURN
        ENDIF
        loc_cDs     = ALLTRIM(THIS.cnt_4c_Container1.txt_4c_DsResps.Value)
        loc_cGrpPad = IIF(VARTYPE(THIS.this_oBusinessObject) = "O", ;
                          ALLTRIM(THIS.this_oBusinessObject.this_cGrPadVens), "")
        IF par_nKeyCode = 115 OR EMPTY(loc_cDs)
            THIS.AbrirBuscaResponsavel("D", loc_cDs)
            RETURN
        ENDIF
        TRY
            loc_cSQL = "SELECT TOP 1 IClis, RClis FROM SigCdCli WHERE RTRIM(RClis) LIKE " + ;
                EscaparSQL(loc_cDs + "%")
            IF !EMPTY(loc_cGrpPad)
                loc_cSQL = loc_cSQL + " AND Grupos = " + EscaparSQL(PADR(loc_cGrpPad, 10))
            ENDIF
            IF USED("cursor_4c_RespTmp")
                USE IN cursor_4c_RespTmp
            ENDIF
            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_RespTmp")
            IF loc_nResultado >= 1
                SELECT cursor_4c_RespTmp
                IF !EOF("cursor_4c_RespTmp")
                    THIS.cnt_4c_Container1.txt_4c_Resps.Value   = ALLTRIM(NVL(cursor_4c_RespTmp.IClis, ""))
                    THIS.cnt_4c_Container1.txt_4c_DsResps.Value = ALLTRIM(NVL(cursor_4c_RespTmp.RClis, ""))
                    USE IN cursor_4c_RespTmp
                    RETURN
                ENDIF
                USE IN cursor_4c_RespTmp
            ENDIF
            THIS.AbrirBuscaResponsavel("D", loc_cDs)
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ValidarDsResps")
        ENDTRY
    ENDPROC

    *===========================================================================
    * ValidarCdMoeda - Handler KeyPress de txt_4c_CdMoeda
    *===========================================================================
    PROCEDURE ValidarCdMoeda
        LPARAMETERS par_nKeyCode, par_nShiftAltCtrl
        LOCAL loc_nResultado, loc_cSQL, loc_cCod
        IF par_nKeyCode != 13 AND par_nKeyCode != 9 AND par_nKeyCode != 115
            RETURN
        ENDIF
        loc_cCod = ALLTRIM(THIS.cnt_4c_Container1.txt_4c_CdMoeda.Value)
        IF par_nKeyCode = 115 OR EMPTY(loc_cCod)
            THIS.AbrirBuscaMoeda("C", loc_cCod)
            RETURN
        ENDIF
        TRY
            loc_cSQL = "SELECT TOP 1 CMoes, DMoes FROM SigCdMoe WHERE CMoes = " + EscaparSQL(loc_cCod)
            IF USED("cursor_4c_MoeTmp")
                USE IN cursor_4c_MoeTmp
            ENDIF
            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_MoeTmp")
            IF loc_nResultado >= 1
                SELECT cursor_4c_MoeTmp
                IF !EOF("cursor_4c_MoeTmp")
                    THIS.cnt_4c_Container1.txt_4c_CdMoeda.Value = ALLTRIM(NVL(cursor_4c_MoeTmp.CMoes, ""))
                    THIS.cnt_4c_Container1.txt_4c_DsMoeda.Value = ALLTRIM(NVL(cursor_4c_MoeTmp.DMoes, ""))
                    USE IN cursor_4c_MoeTmp
                    RETURN
                ENDIF
                USE IN cursor_4c_MoeTmp
            ENDIF
            THIS.AbrirBuscaMoeda("C", loc_cCod)
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ValidarCdMoeda")
        ENDTRY
    ENDPROC

    *===========================================================================
    * ValidarDsMoeda - Handler KeyPress de txt_4c_DsMoeda
    *===========================================================================
    PROCEDURE ValidarDsMoeda
        LPARAMETERS par_nKeyCode, par_nShiftAltCtrl
        LOCAL loc_nResultado, loc_cSQL, loc_cDs
        IF par_nKeyCode != 13 AND par_nKeyCode != 9 AND par_nKeyCode != 115
            RETURN
        ENDIF
        loc_cDs = ALLTRIM(THIS.cnt_4c_Container1.txt_4c_DsMoeda.Value)
        IF par_nKeyCode = 115 OR EMPTY(loc_cDs)
            THIS.AbrirBuscaMoeda("D", loc_cDs)
            RETURN
        ENDIF
        TRY
            loc_cSQL = "SELECT TOP 1 CMoes, DMoes FROM SigCdMoe WHERE RTRIM(DMoes) LIKE " + ;
                EscaparSQL(loc_cDs + "%")
            IF USED("cursor_4c_MoeTmp")
                USE IN cursor_4c_MoeTmp
            ENDIF
            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_MoeTmp")
            IF loc_nResultado >= 1
                SELECT cursor_4c_MoeTmp
                IF !EOF("cursor_4c_MoeTmp")
                    THIS.cnt_4c_Container1.txt_4c_CdMoeda.Value = ALLTRIM(NVL(cursor_4c_MoeTmp.CMoes, ""))
                    THIS.cnt_4c_Container1.txt_4c_DsMoeda.Value = ALLTRIM(NVL(cursor_4c_MoeTmp.DMoes, ""))
                    USE IN cursor_4c_MoeTmp
                    RETURN
                ENDIF
                USE IN cursor_4c_MoeTmp
            ENDIF
            THIS.AbrirBuscaMoeda("D", loc_cDs)
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ValidarDsMoeda")
        ENDTRY
    ENDPROC

    *===========================================================================
    * ConfigurarBindEvents - Liga eventos de lookup aos campos
    * Chamado ao final de InicializarForm apos TornarControlesVisiveis
    *===========================================================================
    PROCEDURE ConfigurarBindEvents()
        LOCAL loc_oCnt
        loc_oCnt = THIS.cnt_4c_Container1

        BINDEVENT(loc_oCnt.txt_4c_CdEmpresa,  "KeyPress", THIS, "ValidarCdEmpresa")
        BINDEVENT(loc_oCnt.txt_4c_DsEmpresa,  "KeyPress", THIS, "ValidarDsEmpresa")
        BINDEVENT(loc_oCnt.txt_4c_NmOperacao, "KeyPress", THIS, "ValidarNmOperacao")
        BINDEVENT(loc_oCnt.txt_4c_Grupo,      "KeyPress", THIS, "ValidarCdGrupo")
        BINDEVENT(loc_oCnt.txt_4c_DsGrupo,    "KeyPress", THIS, "ValidarDsGrupo")
        BINDEVENT(loc_oCnt.txt_4c_Conta,      "KeyPress", THIS, "ValidarCdConta")
        BINDEVENT(loc_oCnt.txt_4c_DsConta,    "KeyPress", THIS, "ValidarDsConta")
        BINDEVENT(loc_oCnt.txt_4c_Cpf,        "KeyPress", THIS, "ValidarCpf")
        BINDEVENT(loc_oCnt.txt_4c_Resps,      "KeyPress", THIS, "ValidarCdResps")
        BINDEVENT(loc_oCnt.txt_4c_DsResps,    "KeyPress", THIS, "ValidarDsResps")
        BINDEVENT(loc_oCnt.txt_4c_CdMoeda,    "KeyPress", THIS, "ValidarCdMoeda")
        BINDEVENT(loc_oCnt.txt_4c_DsMoeda,    "KeyPress", THIS, "ValidarDsMoeda")
    ENDPROC

    *===========================================================================
    * LimparCampos - Restaura todos os filtros para o estado inicial
    * Chamado quando o usuario quer limpar o formulario de filtros
    *===========================================================================
    PROCEDURE LimparCampos()
        WITH THIS.cnt_4c_Container1
            .txt_4c_NmOperacao.Value  = ""
            .txt_4c_DtInicial.Value   = DATE()
            .txt_4c_DtFinal.Value     = DATE()
            .txt_4c_Grupo.Value       = SPACE(10)
            .txt_4c_DsGrupo.Value     = SPACE(20)
            .txt_4c_Conta.Value       = SPACE(10)
            .txt_4c_DsConta.Value     = SPACE(40)
            .txt_4c_CdMoeda.Value     = " "
            .txt_4c_DsMoeda.Value     = ""
            .txt_4c_Resps.Value       = ""
            .txt_4c_DsResps.Value     = ""
            .txt_4c_Cpf.Value         = ""
            .txt_4c_Numero.Value      = 0
            .txt_4c_Op.Value          = 0
            .txt_4c_PStatus.Value     = ""
            .chk_4c_EmpD.Value        = 0
            .obj_4c_OptPeriodo.Value  = 1
            .obj_4c_OptPendente.Value = 3
            .obj_4c_OptImpressao.Value = 1
            .obj_4c_OptCotacao.Value  = 1

            IF TYPE("go_4c_Sistema") = "O"
                .txt_4c_CdEmpresa.Value = go_4c_Sistema.cCodEmpresa
            ELSE
                .txt_4c_CdEmpresa.Value = ""
            ENDIF
            .txt_4c_DsEmpresa.Value = ""
            .Visible     = .T.
        ENDWITH
    ENDPROC

    *===========================================================================
    * HabilitarCampos - Habilita/desabilita campos conforme modo do formulario
    * Form OPERACIONAL: todos os campos de filtro sempre habilitados
    *===========================================================================
    PROCEDURE HabilitarCampos(par_lHabilitar)
        LOCAL loc_lHab
        loc_lHab = IIF(VARTYPE(par_lHabilitar) = "L", par_lHabilitar, .T.)
        WITH THIS.cnt_4c_Container1
            .txt_4c_CdEmpresa.Enabled  = loc_lHab
            .txt_4c_DsEmpresa.Enabled  = loc_lHab
            .chk_4c_EmpD.Enabled       = loc_lHab
            .txt_4c_NmOperacao.Enabled = loc_lHab
            .txt_4c_Numero.Enabled     = loc_lHab
            .txt_4c_Op.Enabled         = loc_lHab
            .txt_4c_PStatus.Enabled    = loc_lHab
            .txt_4c_DtInicial.Enabled  = loc_lHab
            .txt_4c_DtFinal.Enabled    = loc_lHab
            .obj_4c_OptPeriodo.Enabled = loc_lHab
            .txt_4c_Grupo.Enabled      = loc_lHab
            .txt_4c_DsGrupo.Enabled    = loc_lHab
            .txt_4c_Conta.Enabled      = loc_lHab
            .txt_4c_DsConta.Enabled    = loc_lHab
            .txt_4c_Cpf.Enabled        = loc_lHab
            .txt_4c_Resps.Enabled      = loc_lHab
            .txt_4c_DsResps.Enabled    = loc_lHab
            .txt_4c_CdMoeda.Enabled    = loc_lHab
            .txt_4c_DsMoeda.Enabled    = loc_lHab
            .obj_4c_OptCotacao.Enabled = loc_lHab
            .obj_4c_OptPendente.Enabled  = loc_lHab
            .obj_4c_OptImpressao.Enabled = loc_lHab
            .Visible     = .T.
        ENDWITH
        IF VARTYPE(THIS.obj_4c_Sair) = "O"
            THIS.obj_4c_Sair.Buttons(1).Enabled = loc_lHab
        ENDIF
    ENDPROC

    *===========================================================================
    * CarregarLista - N/A para form OPERACIONAL de filtros
    * Form nao possui grid de lista; resultados sao exibidos em FormSigPrEs2
    *===========================================================================
    PROCEDURE CarregarLista()
        RETURN .T.
    ENDPROC

    *===========================================================================
    * AjustarBotoesPorModo - N/A para form OPERACIONAL de filtros
    * Form nao possui modos INCLUIR/ALTERAR/VISUALIZAR/EXCLUIR do CRUD
    *===========================================================================
    PROCEDURE AjustarBotoesPorModo()
        RETURN
    ENDPROC

    *===========================================================================
    * BtnBuscarClick - Alias de BtnConsultarClick (conformidade com pipeline)
    *===========================================================================
    PROCEDURE BtnBuscarClick()
        THIS.BtnConsultarClick()
    ENDPROC

    *===========================================================================
    * BtnSalvarClick - N/A para form OPERACIONAL de filtros (sem CRUD)
    *===========================================================================
    PROCEDURE BtnSalvarClick()
        RETURN
    ENDPROC

    *===========================================================================
    * BtnCancelarClick - N/A para form OPERACIONAL de filtros (sem CRUD)
    * Para encerrar o form usar BtnEncerrarClick
    *===========================================================================
    PROCEDURE BtnCancelarClick()
        RETURN
    ENDPROC

    *===========================================================================
    * Destroy - Libera recursos ao fechar o formulario
    *===========================================================================
    PROCEDURE Destroy()
        IF VARTYPE(THIS.this_oBusinessObject) = "O"
            THIS.this_oBusinessObject = .NULL.
        ENDIF
        IF USED("csTemporario")
            USE IN csTemporario
        ENDIF
        DODEFAULT()
    ENDPROC

ENDDEFINE


### BO (C:\4c\projeto\app\classes\SigPrEs1BO.prg):
*==============================================================================
* SigPrEs1BO.prg - Business Object: Posicao Por Movimentacao
* Herda de BusinessBase
* Form OPERACIONAL - consulta/filtro de movimentacoes em SigMvCab
*==============================================================================

DEFINE CLASS SigPrEs1BO AS BusinessBase

    *-- Empresa
    this_cEmpresa      = ""
    this_cDsEmpresa    = ""
    this_nEmpD         = 0

    *-- Operacao / Movimentacao
    this_cNmOperacao   = ""
    this_nNumero       = 0
    this_nOp           = 0

    *-- Periodo
    this_dDtInicial    = {}
    this_dDtFinal      = {}
    this_nPeriodo      = 1

    *-- Grupo contabil
    this_cGrupo        = ""
    this_cDsGrupo      = ""

    *-- Conta
    this_cConta        = ""
    this_cDsConta      = ""

    *-- CPF/CNPJ
    this_cCpf          = ""

    *-- Responsavel / Vendedor
    this_cResps        = ""
    this_cDsResps      = ""

    *-- Moeda
    this_cMoeda        = ""
    this_cDsMoeda      = ""

    *-- Opcoes de filtro
    this_nSituacao     = 3
    this_nImpressao    = 1
    this_nCotacao      = 1
    this_cStatus       = ""

    *-- Grupo padrao de vendedores (SigCdPam.grpadvens) - carregado em Init
    this_cGrPadVens    = ""

    *--------------------------------------------------------------------------
    PROCEDURE Init()
        THIS.this_cTabela     = "SigMvCab"
        THIS.this_cCampoChave = ""
        DODEFAULT()
        THIS.CarregarGrPadVens()
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarGrPadVens - Carrega o grupo padrao de vendedores de SigCdPam
    * Necessario para validacao de Responsavel via fAcessoContab
    *--------------------------------------------------------------------------
    FUNCTION CarregarGrPadVens()
        LOCAL loc_lResultado, loc_cSQL, loc_nResultado
        loc_lResultado = .F.

        TRY
            loc_cSQL = "SELECT TOP 1 grpadvens AS GrPadVens FROM SigCdPam"

            IF USED("cursor_4c_ParamPam")
                USE IN cursor_4c_ParamPam
            ENDIF

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ParamPam")

            IF loc_nResultado >= 1
                SELECT cursor_4c_ParamPam
                GO TOP
                IF !EOF("cursor_4c_ParamPam")
                    THIS.this_cGrPadVens = NVL(cursor_4c_ParamPam.GrPadVens, "")
                    loc_lResultado = .T.
                ENDIF
                USE IN cursor_4c_ParamPam
            ELSE
                THIS.this_cMensagemErro = "Erro ao carregar par" + CHR(226) + "metros SigCdPam"
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
            THIS.this_cMensagemErro = loc_oErro.Message
        ENDTRY

        RETURN loc_lResultado
    ENDFUNC

    *--------------------------------------------------------------------------
    * ValidarFiltros - Valida filtros antes de executar consulta
    * Retorna .T. se valido; popula this_cMensagemErro se invalido
    *--------------------------------------------------------------------------
    FUNCTION ValidarFiltros()
        THIS.this_cMensagemErro = ""

        IF EMPTY(ALLTRIM(THIS.this_cEmpresa))
            THIS.this_cMensagemErro = "Empresa Inv" + CHR(225) + "lida!!!"
            RETURN .F.
        ENDIF

        IF EMPTY(ALLTRIM(THIS.this_cNmOperacao))
            THIS.this_cMensagemErro = "Opera" + CHR(231) + CHR(227) + "o Inv" + CHR(225) + "lida!!!"
            RETURN .F.
        ENDIF

        IF !EMPTY(THIS.this_dDtFinal) AND !EMPTY(THIS.this_dDtInicial)
            IF THIS.this_dDtFinal < THIS.this_dDtInicial
                THIS.this_cMensagemErro = "Per" + CHR(237) + "odo Inv" + CHR(225) + "lido!!! " + ;
                    "Data Final Menor do Que a Inicial!!!"
                RETURN .F.
            ENDIF
        ENDIF

        RETURN .T.
    ENDFUNC

    *--------------------------------------------------------------------------
    * ExecutarConsulta - Executa a consulta principal contra SigMvCab
    * Cria cursor csTemporario com resultados indexados
    * Retorna .T. se encontrou registros, .F. caso contrario
    *--------------------------------------------------------------------------
    FUNCTION ExecutarConsulta()
        LOCAL loc_lResultado, loc_cSQL, loc_cWhere, loc_nResultado
        LOCAL loc_cEmp, loc_cNmO, loc_cGrupo, loc_cConta, loc_cResps, loc_cSta
        LOCAL loc_nEmpD, loc_nNrP, loc_nPen, loc_nOp, loc_nNum
        LOCAL loc_dDtI, loc_dDtF, loc_cDtISQL, loc_cDtFSQL, loc_cEmpFilter

        loc_lResultado = .F.

        TRY
            loc_cEmp    = ALLTRIM(THIS.this_cEmpresa)
            loc_cNmO    = ALLTRIM(THIS.this_cNmOperacao)
            loc_cGrupo  = ALLTRIM(THIS.this_cGrupo)
            loc_cConta  = ALLTRIM(THIS.this_cConta)
            loc_cResps  = ALLTRIM(THIS.this_cResps)
            loc_cSta    = ALLTRIM(THIS.this_cStatus)
            loc_nEmpD   = THIS.this_nEmpD
            loc_nNrP    = THIS.this_nPeriodo
            loc_nPen    = THIS.this_nSituacao
            loc_nOp     = THIS.this_nOp
            loc_nNum    = THIS.this_nNumero
            loc_dDtI    = THIS.this_dDtInicial
            loc_dDtF    = THIS.this_dDtFinal

            *-- Formata datas para SQL Server (com componente de hora)
            loc_cDtISQL = "'" + PADL(YEAR(loc_dDtI), 4, "0") + "-" + ;
                PADL(MONTH(loc_dDtI), 2, "0") + "-" + ;
                PADL(DAY(loc_dDtI), 2, "0") + " 00:00:00'"
            loc_cDtFSQL = "'" + PADL(YEAR(loc_dDtF), 4, "0") + "-" + ;
                PADL(MONTH(loc_dDtF), 2, "0") + "-" + ;
                PADL(DAY(loc_dDtF), 2, "0") + " 23:59:59'"

            *-- Monta WHERE replicando logica de consulta.Click do legado
            loc_cWhere = ""

            IF !EMPTY(loc_cNmO)
                loc_cWhere = loc_cWhere + "a.Dopes = " + EscaparSQL(loc_cNmO) + " And "
            ENDIF

            IF loc_nNrP = 1
                loc_cWhere = loc_cWhere + "a.Datas "
            ELSE
                loc_cWhere = loc_cWhere + "a.PrazoEnts "
            ENDIF
            loc_cWhere = loc_cWhere + "BetWeen " + loc_cDtISQL + " And " + loc_cDtFSQL + " And "

            IF !EMPTY(loc_cGrupo)
                loc_cWhere = loc_cWhere + "(a.GrupoOs = " + EscaparSQL(loc_cGrupo) + ;
                    " Or a.GrupoDs = " + EscaparSQL(loc_cGrupo) + ") And "
            ENDIF

            IF !EMPTY(loc_cConta)
                loc_cWhere = loc_cWhere + "(a.ContaOs = " + EscaparSQL(loc_cConta) + ;
                    " Or a.ContaDs = " + EscaparSQL(loc_cConta) + ") And "
            ENDIF

            IF loc_nOp > 0
                loc_cWhere = loc_cWhere + "a.Nops = " + FormatarNumeroSQL(loc_nOp, 0) + " And "
            ENDIF

            IF loc_nNum > 0
                loc_cWhere = loc_cWhere + "a.Numes = " + FormatarNumeroSQL(loc_nNum, 0) + " And "
            ENDIF

            IF !EMPTY(loc_cResps)
                loc_cWhere = loc_cWhere + "a.Vends = " + EscaparSQL(loc_cResps) + " And "
            ENDIF

            DO CASE
                CASE loc_nPen = 1
                    loc_cWhere = loc_cWhere + "a.ChkSubn = 0 And "
                CASE loc_nPen = 2
                    loc_cWhere = loc_cWhere + "a.ChkSubn = 1 And "
            ENDCASE

            IF !EMPTY(loc_cSta)
                loc_cWhere = loc_cWhere + "a.pStatus = " + EscaparSQL(loc_cSta) + " And "
            ENDIF

            *-- Filtro de empresa (com empresa destino opcional)
            loc_cEmpFilter = "(a.Emps = " + EscaparSQL(loc_cEmp)
            IF loc_nEmpD != 0
                loc_cEmpFilter = loc_cEmpFilter + " Or a.Empds = " + EscaparSQL(loc_cEmp)
            ENDIF
            loc_cEmpFilter = loc_cEmpFilter + ")"

            loc_cSQL = "Select a.* " + ;
                "From SigMvCab a, SigCdOpe b " + ;
                "Where " + loc_cEmpFilter + " And " + ;
                loc_cWhere + ;
                "a.Dopes = b.Dopes"

            IF USED("csTemporario")
                USE IN csTemporario
            ENDIF

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "csTemporario")

            IF loc_nResultado >= 1
                SELECT csTemporario
                IF RECCOUNT("csTemporario") > 0
                    INDEX ON EmpDopNums TAG EmpDopNums
                    *-- Corrige PrazoEnts NULL (replica Update Set PrazoEnts = Iif(IsNull,Ctod(''),PrazoEnts))
                    REPLACE ALL prazoents WITH IIF(ISNULL(prazoents), CTOD(""), prazoents) IN csTemporario
                    GO TOP IN csTemporario
                    loc_lResultado = .T.
                ELSE
                    THIS.this_cMensagemErro = "Nenhum Registro Selecionado!!!"
                    USE IN csTemporario
                ENDIF
            ELSE
                THIS.this_cMensagemErro = "Falha ao executar consulta (csTemporario)"
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
            THIS.this_cMensagemErro = loc_oErro.Message
        ENDTRY

        RETURN loc_lResultado
    ENDFUNC

    *--------------------------------------------------------------------------
    * CarregarCpfPorConta - Carrega CPF do cliente pelo codigo da conta (iclis)
    * Retorna o CPF (string) ou "" se nao encontrado
    *--------------------------------------------------------------------------
    FUNCTION CarregarCpfPorConta(par_cConta)
        LOCAL loc_cCpf, loc_cSQL, loc_nResultado
        loc_cCpf = ""

        IF EMPTY(ALLTRIM(par_cConta))
            RETURN ""
        ENDIF

        TRY
            loc_cSQL = "SELECT TOP 1 Cpfs FROM SigCdCli " + ;
                "WHERE iClis = " + EscaparSQL(PADR(ALLTRIM(par_cConta), 10))

            IF USED("cursor_4c_CpfCli")
                USE IN cursor_4c_CpfCli
            ENDIF

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_CpfCli")

            IF loc_nResultado >= 1
                SELECT cursor_4c_CpfCli
                IF !EOF("cursor_4c_CpfCli")
                    loc_cCpf = NVL(cursor_4c_CpfCli.Cpfs, "")
                ENDIF
                USE IN cursor_4c_CpfCli
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_cCpf
    ENDFUNC

    *--------------------------------------------------------------------------
    * ValidarCpfCnpj - Valida CPF/CNPJ e localiza conta vinculada em SigCdCli
    * Retorna objeto Empty com: lValido, cConta, cDsConta, cCpf, cErro
    * Replica logica de Get_cpf.Valid do legado
    *--------------------------------------------------------------------------
    FUNCTION ValidarCpfCnpj(par_cCpfCnpj)
        LOCAL loc_oRet, loc_cCgc, loc_cCgc1, loc_nLen, loc_nVerCpfCgc, loc_nResultado

        loc_oRet = CREATEOBJECT("Empty")
        ADDPROPERTY(loc_oRet, "lValido",  .F.)
        ADDPROPERTY(loc_oRet, "cConta",   "")
        ADDPROPERTY(loc_oRet, "cDsConta", "")
        ADDPROPERTY(loc_oRet, "cCpf",     "")
        ADDPROPERTY(loc_oRet, "cErro",    "")

        IF EMPTY(ALLTRIM(par_cCpfCnpj))
            loc_oRet.lValido = .T.
            RETURN loc_oRet
        ENDIF

        loc_cCgc = STRTRAN(STRTRAN(STRTRAN(ALLTRIM(par_cCpfCnpj), ".", ""), "-", ""), "/", "")
        loc_nLen = LEN(ALLTRIM(loc_cCgc))
        loc_nVerCpfCgc = 0

        IF loc_nLen <> 14
            loc_cCgc1 = TRANSFORM(loc_cCgc, "@R 999.999.999-99")
            IF loc_nLen = 11
                loc_nVerCpfCgc = IIF(ValidarCPF(loc_cCgc1), 1, 2)
            ENDIF
        ELSE
            loc_cCgc1 = TRANSFORM(loc_cCgc, "@R 99.999.999/9999-99")
            loc_nVerCpfCgc = IIF(ValidarCNPJ(loc_cCgc1), 1, 2)
        ENDIF

        IF loc_nVerCpfCgc = 2
            loc_oRet.cErro = "CPF / CGC Incorreto !!!"
            RETURN loc_oRet
        ENDIF

        TRY
            loc_cSQL = "SELECT TOP 1 iclis, rclis, cpfs FROM SigCdCli " + ;
                "WHERE cpfs = " + EscaparSQL(PADR(ALLTRIM(loc_cCgc1), 20))

            IF USED("cursor_4c_BuscaCpf")
                USE IN cursor_4c_BuscaCpf
            ENDIF

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaCpf")

            IF loc_nResultado >= 1
                SELECT cursor_4c_BuscaCpf
                IF !EOF("cursor_4c_BuscaCpf")
                    loc_oRet.cConta   = NVL(cursor_4c_BuscaCpf.iclis, "")
                    loc_oRet.cDsConta = NVL(cursor_4c_BuscaCpf.rclis, "")
                    loc_oRet.cCpf     = NVL(cursor_4c_BuscaCpf.cpfs, "")
                    loc_oRet.lValido  = .T.
                ELSE
                    IF loc_nVerCpfCgc = 1
                        loc_oRet.cErro = "CPF / CGC n" + CHR(227) + "o encontrado !!!"
                    ELSE
                        loc_oRet.lValido = .T.
                    ENDIF
                ENDIF
                USE IN cursor_4c_BuscaCpf
            ELSE
                loc_oRet.cErro = "Falha ao buscar CPF/CGC em SigCdCli"
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
            loc_oRet.cErro = loc_oErro.Message
        ENDTRY

        RETURN loc_oRet
    ENDFUNC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Chave composta de SigMvCab (Emps + Dopes + Nums)
    * Usada em RegistrarAuditoria para log de consulta/operacoes
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ObterChavePrimaria()
        RETURN ALLTRIM(THIS.this_cEmpresa) + "|" + ;
               ALLTRIM(THIS.this_cNmOperacao) + "|" + ;
               ALLTRIM(TRANSFORM(THIS.this_nNumero))
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Carrega chave e campos principais de SigMvCab
    * a partir da linha corrente do cursor (usado quando usuario seleciona
    * uma movimentacao no grid de resultados de ExecutarConsulta)
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        IF !USED(par_cAliasCursor)
            THIS.this_cMensagemErro = "Cursor " + par_cAliasCursor + " n" + CHR(227) + "o est" + CHR(225) + " aberto"
            RETURN .F.
        ENDIF

        TRY
            SELECT (par_cAliasCursor)

            IF TYPE(par_cAliasCursor + ".emps") != "U"
                THIS.this_cEmpresa    = TratarNulo(emps, "C")
            ENDIF
            IF TYPE(par_cAliasCursor + ".empds") != "U"
                THIS.this_nEmpD       = IIF(NVL(empds, "") != THIS.this_cEmpresa AND !EMPTY(NVL(empds, "")), 1, 0)
            ENDIF
            IF TYPE(par_cAliasCursor + ".dopes") != "U"
                THIS.this_cNmOperacao = TratarNulo(dopes, "C")
            ENDIF
            IF TYPE(par_cAliasCursor + ".nops") != "U"
                THIS.this_nOp         = NVL(nops, 0)
            ENDIF
            IF TYPE(par_cAliasCursor + ".numes") != "U"
                THIS.this_nNumero     = NVL(numes, 0)
            ENDIF
            IF TYPE(par_cAliasCursor + ".grupos") != "U"
                THIS.this_cGrupo      = TratarNulo(grupos, "C")
            ENDIF
            IF TYPE(par_cAliasCursor + ".iclis") != "U"
                THIS.this_cConta      = TratarNulo(iclis, "C")
            ENDIF
            IF TYPE(par_cAliasCursor + ".vends") != "U"
                THIS.this_cResps      = TratarNulo(vends, "C")
            ENDIF
            IF TYPE(par_cAliasCursor + ".datas") != "U"
                THIS.this_dDtInicial  = TratarNulo(datas, "D")
            ENDIF
            IF TYPE(par_cAliasCursor + ".prazoents") != "U"
                THIS.this_dDtFinal    = TratarNulo(prazoents, "D")
            ENDIF
            IF TYPE(par_cAliasCursor + ".pstatus") != "U"
                THIS.this_cStatus     = TratarNulo(pstatus, "C")
            ENDIF
            IF TYPE(par_cAliasCursor + ".chksubn") != "U"
                THIS.this_nSituacao   = IIF(NVL(chksubn, .F.), 2, 1)
            ENDIF

            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
                    " PROC=" + loc_oErro.Procedure, "Erro SigPrEs1BO.CarregarDoCursor")
            THIS.this_cMensagemErro = loc_oErro.Message
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir - NAO APLICAVEL a form OPERACIONAL de consulta
    * SigPrEs1 (Posicao Por Movimentacao) apenas LE registros de SigMvCab
    * atraves de ExecutarConsulta. Inclusao de movimentacoes ocorre nos
    * forms de entrada de operacao (SigMvCab tem forms proprios de CRUD).
    * Metodo mantido para conformidade com contrato BusinessBase; sempre
    * retorna .F. com mensagem clara para prevenir uso indevido.
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION Inserir()
        THIS.this_cMensagemErro = "Opera" + CHR(231) + CHR(227) + "o n" + CHR(227) + ;
            "o suportada: SigPrEs1 " + CHR(233) + " form de consulta de posi" + ;
            CHR(231) + CHR(227) + "o por movimenta" + CHR(231) + CHR(227) + "o. " + ;
            "Utilize o form pr" + CHR(243) + "prio da opera" + CHR(231) + CHR(227) + ;
            "o para incluir movimenta" + CHR(231) + CHR(245) + "es."
        RETURN .F.
    ENDFUNC

    *--------------------------------------------------------------------------
    * Atualizar - NAO APLICAVEL a form OPERACIONAL de consulta
    * Mesma razao de Inserir(): SigPrEs1 apenas consulta SigMvCab.
    * Atualizacoes ocorrem nos forms de operacao correspondentes.
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION Atualizar()
        THIS.this_cMensagemErro = "Opera" + CHR(231) + CHR(227) + "o n" + CHR(227) + ;
            "o suportada: SigPrEs1 " + CHR(233) + " form de consulta de posi" + ;
            CHR(231) + CHR(227) + "o por movimenta" + CHR(231) + CHR(227) + "o. " + ;
            "Utilize o form pr" + CHR(243) + "prio da opera" + CHR(231) + CHR(227) + ;
            "o para atualizar movimenta" + CHR(231) + CHR(245) + "es."
        RETURN .F.
    ENDFUNC

    *--------------------------------------------------------------------------
    * RegistrarAuditoria - Registra em LogAuditoria a consulta executada
    * Sobrescreve BusinessBase para logar operacao "CONSULTA" com filtros
    * aplicados (empresa, operacao, periodo). DataHora usa GETDATE() (regra
    * canonica - GETDATE() rejeita tipo T).
    *--------------------------------------------------------------------------
    FUNCTION RegistrarAuditoria(par_cOperacao)
        LOCAL loc_lSucesso, loc_cSQL, loc_cChave, loc_cUsuario, loc_cDetalhes
        loc_lSucesso = .F.

        TRY
            loc_cUsuario = IIF(TYPE("gc_4c_UsuarioLogado") = "C", ;
                              ALLTRIM(gc_4c_UsuarioLogado), "SISTEMA")
            loc_cChave = THIS.ObterChavePrimaria()

            loc_cDetalhes = "Empresa=" + ALLTRIM(THIS.this_cEmpresa) + ;
                "; Operacao=" + ALLTRIM(THIS.this_cNmOperacao) + ;
                "; Periodo=" + DTOC(THIS.this_dDtInicial) + ".." + DTOC(THIS.this_dDtFinal)

            loc_cSQL = "INSERT INTO LogAuditoria " + ;
                "(Tabela, Operacao, ChavePrimaria, Usuario, DataHora, Detalhes) " + ;
                "VALUES (" + ;
                EscaparSQL("SigPrEs1") + ", " + ;
                EscaparSQL(par_cOperacao) + ", " + ;
                EscaparSQL(loc_cChave) + ", " + ;
                EscaparSQL(loc_cUsuario) + ", " + ;
                "GETDATE(), " + ;
                EscaparSQL(loc_cDetalhes) + ")"

            IF SQLEXEC(gnConnHandle, loc_cSQL) >= 1
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            *-- Falha de auditoria nao interrompe operacao principal
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

ENDDEFINE


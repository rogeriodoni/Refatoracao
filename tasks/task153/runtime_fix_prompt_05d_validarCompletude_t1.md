# CORRIGIR ERRO DE RUNTIME VFP9

## TAREFA OBRIGATORIA
O formulario VFP9 apresentou erro de runtime durante teste automatizado.
Voce DEVE corrigir o erro e salvar os arquivos corrigidos usando Write tool.

## ERRO DETECTADO
- Etapa: 05d_validarCompletude
- Tentativa: 1/10
- Mensagem: Validacao de completude falhou. Procedures vazias/TODOs encontrados:
[FormSIGPGCNB.prg] Indicador de pendencia: * CnabBrasil - Stub para Banco do Brasil (nao implement

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

### FORM (C:\4c\projeto\app\forms\operacionais\FormSIGPGCNB.prg):
*==============================================================================
* FormSIGPGCNB.prg - Form Operacional: Geracao de Arquivos CNAB - Pagamentos
* Migrado de SIGPGCNB.SCX
* Herda de FormBase
* Tabelas: SigMvCcr, SigCdCli, SigCdGcr, SigCdCeb, SigCdEmp, SigMvCcb, SigPcOol
*
* Pilares:
*   UX   -> layout PIXEL-PERFECT identico ao legado
*   BD   -> Schema IDENTICO (SigPcOol, SigMvCcr, etc.)
*   CODE -> arquitetura em camadas (FormBase / SIGPGCNBBO)
*==============================================================================

DEFINE CLASS FormSIGPGCNB AS FormBase

    *-- Dimensoes e propriedades visuais (copiadas do SCX original)
    Height      = 600
    Width       = 1000
    BorderStyle = 2
    AutoCenter  = .T.
    ShowTips    = .T.
    Caption     = "Gera" + CHR(231) + CHR(227) + "o de Arquivos CNAB - Pagamentos"
    ControlBox  = .F.
    MaxButton   = .F.
    MinButton   = .F.
    TitleBar    = 0
    WindowState = 0
    ShowWindow  = 1
    WindowType  = 1
    DataSession = 2
    Themes      = .F.

    *-- Business Object
    this_oBusinessObject = .NULL.

    *-- Contador de lotes do arquivo CNAB (compartilhado entre sub-metodos)
    *-- Necessario porque VFP9 passa parametros por VALOR - sub-metodos nao propagam de volta
    this_nCnabLot = 0

    *==========================================================================
    PROCEDURE Init()
    *==========================================================================
        RETURN DODEFAULT()
    ENDPROC

    *==========================================================================
    * InicializarForm - Chamado por FormBase.Init via DODEFAULT
    *==========================================================================
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        TRY
            THIS.this_oBusinessObject = CREATEOBJECT("SIGPGCNBBO")

            IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
                loc_lSucesso = .T.
            ELSE
                IF gnConnHandle <= 0
                    MsgErro("Imposs" + CHR(237) + "vel Efetuar Conex" + CHR(227) + "o " + ;
                            "Com o Servidor de Banco de Dados...", "Conex" + CHR(227) + "o")
                ELSE
                    THIS.ConfigurarPageFrame()
                    THIS.ConfigurarPaginaLista()
                    THIS.ConfigurarPaginaDados()
                    THIS.TornarControlesVisiveis()
                    THIS.ConfigurarBINDEVENTs()
                    THIS.InicializarValores()
                    loc_lSucesso = .T.
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro InicializarForm")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * ConfigurarPageFrame - Constroi o PageFrame com 2 paginas
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPageFrame()
        LOCAL loc_oPgf

        THIS.AddObject("pgf_4c_Principal", "PageFrame")
        loc_oPgf = THIS.pgf_4c_Principal

        loc_oPgf.PageCount = 2
        loc_oPgf.ErasePage = .T.
        loc_oPgf.Top       = -24
        loc_oPgf.Left      = 0
        loc_oPgf.Width     = 1003
        loc_oPgf.Height    = 635
        loc_oPgf.TabIndex  = 1
        loc_oPgf.Tabs      = .F.

        loc_oPgf.Page1.Caption = "Filtro"
        loc_oPgf.Page1.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"

        loc_oPgf.Page2.Caption = "Dados"
        loc_oPgf.Page2.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
        loc_oPgf.Page2.Enabled = .F.

        loc_oPgf.Visible    = .T.
        loc_oPgf.ActivePage = 1
    ENDPROC

    *==========================================================================
    * ConfigurarPaginaLista - Constroi controles da Page1 (filtros + grid de grupos)
    * Nota: form OPERACIONAL - Page1 hospeda os filtros e o grid de grupos
    * (analogo a "Lista" em forms CRUD, conforme padrao canonico)
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPaginaLista()
        LOCAL loc_oP1, loc_oCnt, loc_oCgp, loc_oCtrl

        loc_oP1 = THIS.pgf_4c_Principal.pgfiltro

        *-- Container cabecalho (cntSombra)
        loc_oP1.AddObject("cnt_4c_Sombra", "Container")
        loc_oCnt = loc_oP1.cnt_4c_Sombra
        WITH loc_oCnt
            .Top         = 0
            .Left        = 0
            .Width       = 1100
            .Height      = 80
            .BorderWidth = 0
            .BackColor   = RGB(100,100,100)
            .AddObject("lbl_4c_Sombra", "Label")
            WITH .lbl_4c_Sombra
                .FontBold      = .T.
                .FontName      = "Tahoma"
                .FontSize      = 18
                .FontUnderline = .F.
                .WordWrap      = .T.
                .Alignment     = 0
                .BackStyle     = 0
                .Caption       = "Gera" + CHR(231) + CHR(227) + "o de Arquivos CNAB - Pagamentos"
                .Height        = 40
                .Left          = 10
                .Top           = 18
                .Width         = THIS.Width
                .ForeColor     = RGB(0,0,0)
            ENDWITH
            .AddObject("lbl_4c_Titulo", "Label")
            WITH .lbl_4c_Titulo
                .FontBold   = .T.
                .FontName   = "Tahoma"
                .FontSize   = 18
                .WordWrap   = .T.
                .Alignment  = 0
                .BackStyle  = 0
                .Caption    = "Gera" + CHR(231) + CHR(227) + "o de Arquivos CNAB - Pagamentos"
                .Height     = 46
                .Left       = 10
                .Top        = 17
                .Width      = THIS.Width
                .ForeColor  = RGB(255,255,255)
            ENDWITH
        ENDWITH

        *-- CommandGroup Processar + Encerrar (cmdTestaPos no original)
        loc_oP1.AddObject("cgp_4c_Filtro", "CommandGroup")
        loc_oCgp = loc_oP1.cgp_4c_Filtro
        WITH loc_oCgp
            .AutoSize      = .T.
            .ButtonCount   = 2
            .BackStyle     = 0
            .BorderStyle   = 0
            .Value         = 1
            .Height        = 85
            .Left          = 844
            .SpecialEffect = 1
            .Top           = -2
            .Width         = 160
            .TabIndex      = 12
            .BackColor     = RGB(240,240,240)
            .Themes        = .F.
            WITH .Command1
                .Top           = 5
                .Left          = 5
                .Height        = 75
                .Width         = 75
                .FontBold      = .T.
                .FontItalic    = .T.
                .FontName      = "Comic Sans MS"
                .FontSize      = 8
                .WordWrap      = .T.
                .Picture       = gc_4c_CaminhoIcones + "geral_processar_60.jpg"
                .Caption       = "Processar"
                .MousePointer  = 15
                .SpecialEffect = 0
                .ForeColor     = RGB(90,90,90)
                .BackColor     = RGB(255,255,255)
                .Themes        = .F.
                .Name          = "btnProcessar"
            ENDWITH
            WITH .Command2
                .Top           = 5
                .Left          = 80
                .Height        = 75
                .Width         = 75
                .FontBold      = .T.
                .FontItalic    = .T.
                .FontName      = "Comic Sans MS"
                .FontSize      = 8
                .Picture       = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
                .Cancel        = .T.
                .Caption       = "Encerrar"
                .ToolTipText   = "[ESC] Encerrar"
                .ForeColor     = RGB(90,90,90)
                .BackColor     = RGB(255,255,255)
                .Themes        = .F.
                .Name          = "btnsair"
            ENDWITH
        ENDWITH

        *-- Label "Operacoes:"
        loc_oP1.AddObject("lbl_4c_LblOper", "Label")
        WITH loc_oP1.lbl_4c_LblOper
            .AutoSize   = .T.
            .FontBold   = .T.
            .FontName   = "Tahoma"
            .FontSize   = 8
            .BackStyle  = 0
            .Caption    = "Opera" + CHR(231) + CHR(245) + "es :"
            .Height     = 15
            .Left       = 301
            .Top        = 91
            .Width      = 68
            .TabIndex   = 13
            .ForeColor  = RGB(90,90,90)
        ENDWITH

        *-- OptionGroup processados
        loc_oP1.AddObject("opt_4c_Processados", "OptionGroup")
        WITH loc_oP1.opt_4c_Processados
            .BackStyle   = 0
            .BorderStyle = 0
            .ButtonCount = 2
            .Height      = 19
            .Left        = 366
            .Top         = 90
            .Width       = 235
            .Value       = 1
            .TabIndex    = 1
            WITH .Option1
                .BackStyle = 0
                .Caption   = "N" + CHR(227) + "o Processadas"
                .Left      = 5
                .Top       = 2
                .AutoSize  = .T.
                .ForeColor = RGB(90,90,90)
                .Value     = 1
            ENDWITH
            WITH .Option2
                .FontName  = "Tahoma"
                .FontSize  = 8
                .BackStyle = 0
                .Caption   = "J" + CHR(225) + " Processadas"
                .Left      = 126
                .Top       = 2
                .AutoSize  = .T.
                .ForeColor = RGB(90,90,90)
                .Value     = 0
            ENDWITH
        ENDWITH

        *-- Label "Empresa :"
        loc_oP1.AddObject("lbl_4c_LblEmpresa", "Label")
        WITH loc_oP1.lbl_4c_LblEmpresa
            .AutoSize   = .T.
            .FontName   = "Tahoma"
            .FontSize   = 8
            .BackStyle  = 0
            .Caption    = "Empresa :"
            .Left       = 319
            .Top        = 118
            .Width      = 50
            .TabIndex   = 14
            .ForeColor  = RGB(90,90,90)
        ENDWITH

        *-- TextBox Codigo Empresa
        loc_oP1.AddObject("txt_4c_CdEmpresa", "TextBox")
        WITH loc_oP1.txt_4c_CdEmpresa
            .FontName      = "Tahoma"
            .FontSize      = 8
            .Format        = "K"
            .Height        = 23
            .Left          = 371
            .MaxLength     = 3
            .SpecialEffect = 1
            .TabIndex      = 2
            .Top           = 115
            .Width         = 31
            .Value         = ""
            .ForeColor     = RGB(0,0,0)
            .BorderColor   = RGB(100,100,100)
        ENDWITH

        *-- TextBox Descricao Empresa
        loc_oP1.AddObject("txt_4c_DsEmpresa", "TextBox")
        WITH loc_oP1.txt_4c_DsEmpresa
            .FontName      = "Tahoma"
            .FontSize      = 8
            .Format        = "K"
            .Height        = 23
            .Left          = 405
            .MaxLength     = 40
            .SpecialEffect = 1
            .TabIndex      = 3
            .Top           = 115
            .Width         = 290
            .Value         = ""
            .ForeColor     = RGB(0,0,0)
            .BorderColor   = RGB(100,100,100)
        ENDWITH

        *-- Label "Periodo :"
        loc_oP1.AddObject("lbl_4c_LblPeriodo", "Label")
        WITH loc_oP1.lbl_4c_LblPeriodo
            .AutoSize   = .T.
            .FontName   = "Tahoma"
            .FontSize   = 8
            .Caption    = "Per" + CHR(237) + "odo :"
            .Left       = 324
            .Top        = 146
            .Width      = 45
            .TabIndex   = 16
            .BackStyle  = 0
            .ForeColor  = RGB(90,90,90)
        ENDWITH

        *-- TextBox Data Inicial
        loc_oP1.AddObject("txt_4c_Datai", "TextBox")
        WITH loc_oP1.txt_4c_Datai
            .FontName      = "Tahoma"
            .FontSize      = 8
            .Alignment     = 3
            .Format        = "KD"
            .BorderStyle   = 1
            .Value         = {}
            .Left          = 371
            .SpecialEffect = 1
            .TabIndex      = 4
            .Top           = 143
            .Width         = 80
            .ForeColor     = RGB(0,0,0)
            .BorderColor   = RGB(100,100,100)
        ENDWITH

        *-- Label "ate"
        loc_oP1.AddObject("lbl_4c_LblAte", "Label")
        WITH loc_oP1.lbl_4c_LblAte
            .AutoSize  = .T.
            .FontName  = "Tahoma"
            .Caption   = "at" + CHR(233)
            .Left      = 456
            .Top       = 146
            .TabIndex  = 17
            .BackStyle = 0
            .ForeColor = RGB(90,90,90)
        ENDWITH

        *-- TextBox Data Final
        loc_oP1.AddObject("txt_4c_Dataf", "TextBox")
        WITH loc_oP1.txt_4c_Dataf
            .FontName      = "Tahoma"
            .FontSize      = 8
            .Alignment     = 3
            .Format        = "KD"
            .BorderStyle   = 1
            .Value         = {}
            .Left          = 479
            .SpecialEffect = 1
            .TabIndex      = 5
            .Top           = 143
            .Width         = 80
            .ForeColor     = RGB(0,0,0)
            .BorderColor   = RGB(100,100,100)
        ENDWITH

        *-- OptionGroup periodo
        loc_oP1.AddObject("opt_4c_Periodo", "OptionGroup")
        WITH loc_oP1.opt_4c_Periodo
            .AutoSize    = .F.
            .ButtonCount = 2
            .BackStyle   = 0
            .BorderStyle = 0
            .Height      = 25
            .Left        = 566
            .Top         = 141
            .Width       = 168
            .Value       = 1
            .TabIndex    = 6
            WITH .Option1
                .BackStyle = 0
                .Caption   = "Vencimento"
                .Value     = 1
                .Height    = 15
                .Left      = 5
                .Top       = 5
                .Width     = 73
                .AutoSize  = .T.
                .ForeColor = RGB(90,90,90)
            ENDWITH
            WITH .Option2
                .FontName  = "Tahoma"
                .FontSize  = 8
                .BackStyle = 0
                .Caption   = "Emiss" + CHR(227) + "o"
                .Value     = 0
                .Left      = 96
                .Top       = 5
                .AutoSize  = .T.
                .ForeColor = RGB(90,90,90)
            ENDWITH
        ENDWITH

        *-- Label "Banco :"
        loc_oP1.AddObject("lbl_4c_LblBanco", "Label")
        WITH loc_oP1.lbl_4c_LblBanco
            .AutoSize   = .T.
            .FontName   = "Tahoma"
            .FontSize   = 8
            .Caption    = "Banco :"
            .Left       = 331
            .Top        = 175
            .Width      = 38
            .TabIndex   = 18
            .BackStyle  = 0
            .ForeColor  = RGB(90,90,90)
        ENDWITH

        *-- TextBox Codigo Conta/Banco
        loc_oP1.AddObject("txt_4c_CdConta", "TextBox")
        WITH loc_oP1.txt_4c_CdConta
            .FontName      = "Tahoma"
            .FontSize      = 8
            .Format        = "K"
            .Height        = 23
            .Left          = 371
            .MaxLength     = 10
            .SpecialEffect = 1
            .TabIndex      = 7
            .Top           = 171
            .Width         = 79
            .Value         = ""
            .ForeColor     = RGB(0,0,0)
            .BorderColor   = RGB(100,100,100)
        ENDWITH

        *-- TextBox Descricao Conta/Banco
        loc_oP1.AddObject("txt_4c_DsConta", "TextBox")
        WITH loc_oP1.txt_4c_DsConta
            .FontName      = "Tahoma"
            .FontSize      = 8
            .Format        = "K"
            .Height        = 23
            .Left          = 452
            .MaxLength     = 40
            .SpecialEffect = 1
            .TabIndex      = 8
            .Top           = 171
            .Width         = 290
            .Value         = ""
            .ForeColor     = RGB(0,0,0)
            .BorderColor   = RGB(100,100,100)
        ENDWITH

        *-- Label "Empresa do convenio :"
        loc_oP1.AddObject("lbl_4c_LblEmpConv", "Label")
        WITH loc_oP1.lbl_4c_LblEmpConv
            .AutoSize   = .T.
            .FontName   = "Tahoma"
            .FontSize   = 8
            .Caption    = "Empresa do conv" + CHR(234) + "nio :"
            .Left       = 258
            .Top        = 201
            .Width      = 111
            .TabIndex   = 15
            .BackStyle  = 0
            .ForeColor  = RGB(90,90,90)
        ENDWITH

        *-- TextBox Codigo Empresa Convenio
        loc_oP1.AddObject("txt_4c_CdEmpConv", "TextBox")
        WITH loc_oP1.txt_4c_CdEmpConv
            .FontName      = "Tahoma"
            .FontSize      = 8
            .Format        = "K"
            .Height        = 23
            .Left          = 371
            .MaxLength     = 3
            .SpecialEffect = 1
            .TabIndex      = 9
            .Top           = 198
            .Width         = 31
            .Value         = ""
            .ForeColor     = RGB(0,0,0)
            .BorderColor   = RGB(100,100,100)
        ENDWITH

        *-- TextBox Descricao Empresa Convenio
        loc_oP1.AddObject("txt_4c_DsEmpConv", "TextBox")
        WITH loc_oP1.txt_4c_DsEmpConv
            .FontName      = "Tahoma"
            .FontSize      = 8
            .Format        = "K"
            .Height        = 23
            .Left          = 405
            .MaxLength     = 40
            .SpecialEffect = 1
            .TabIndex      = 10
            .Top           = 198
            .Width         = 290
            .Value         = ""
            .ForeColor     = RGB(0,0,0)
            .BorderColor   = RGB(100,100,100)
        ENDWITH

        *-- Label "Grupos Fornecedores :"
        loc_oP1.AddObject("lbl_4c_LblGrupos", "Label")
        WITH loc_oP1.lbl_4c_LblGrupos
            .FontName  = "Tahoma"
            .Caption   = "Grupos Fornecedores :"
            .Left      = 257
            .Top       = 238
            .TabIndex  = 19
            .BackStyle = 0
            .ForeColor = RGB(90,90,90)
            .AutoSize  = .T.
        ENDWITH

        *-- Grid de Grupos (grdgrupos)
        loc_oP1.AddObject("grd_4c_Grupos", "Grid")
        WITH loc_oP1.grd_4c_Grupos
            .ColumnCount      = 2
            .FontName         = "Tahoma"
            .AllowHeaderSizing = .F.
            .AllowRowSizing   = .F.
            .DeleteMark       = .F.
            .GridLines        = 3
            .Height           = 344
            .Left             = 372
            .Panel            = 1
            .ScrollBars       = 2
            .SplitBar         = .F.
            .TabIndex         = 11
            .Top              = 236
            .Width            = 202
            .GridLineColor    = RGB(238,238,238)
            .Themes           = .F.
            .Column1.Width    = 18
            .Column1.Movable  = .F.
            .Column1.Resizable = .F.
            .Column1.Sparse   = .F.
            .Column1.AddObject("Check1", "CheckBox")
            .Column1.Check1.Caption = ""
            .Column1.Check1.Value   = 0
            .Column1.CurrentControl = "Check1"
            .Column2.Width    = 150
            .Column2.Movable  = .F.
            .Column2.Resizable = .F.
            .Column2.ReadOnly = .T.
            .RecordMark   = .F.
        ENDWITH

        *-- CommandGroup Marcar/Desmarcar grupos
        loc_oP1.AddObject("cgp_4c_MarcaFiltro", "CommandGroup")
        WITH loc_oP1.cgp_4c_MarcaFiltro
            .AutoSize      = .T.
            .ButtonCount   = 2
            .BackStyle     = 0
            .BorderStyle   = 0
            .Value         = 0
            .Height        = 91
            .Left          = 585
            .SpecialEffect = 1
            .Top           = 319
            .Width         = 50
            .TabIndex      = 20
            .BackColor     = RGB(240,240,240)
            .Themes        = .F.
            WITH .Command1
                .Top         = 5
                .Left        = 5
                .Height      = 40
                .Width       = 40
                .Picture     = gc_4c_CaminhoIcones + "geral_adicao_26.jpg"
                .Caption     = ""
                .ToolTipText = "Marcar tudo"
                .ForeColor   = RGB(36,84,155)
                .BackColor   = RGB(255,255,255)
                .Themes      = .F.
                .Name        = "btnmarca"
            ENDWITH
            WITH .Command2
                .Top         = 46
                .Left        = 5
                .Height      = 40
                .Width       = 40
                .FontName    = "Verdana"
                .FontSize    = 8
                .Picture     = gc_4c_CaminhoIcones + "cadastro_excluir_26.jpg"
                .Caption     = ""
                .ToolTipText = "Desmarcar tudo"
                .ForeColor   = RGB(36,84,155)
                .BackColor   = RGB(255,255,255)
                .Themes      = .F.
                .Name        = "btndesmarca"
            ENDWITH
        ENDWITH
    ENDPROC

    *==========================================================================
    * ConfigurarPaginaDados - Constroi controles da Page2 (dados/operacoes)
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPaginaDados()
        LOCAL loc_oP2, loc_oCgp

        loc_oP2 = THIS.pgf_4c_Principal.pgdados

        *-- Grid de Operacoes (grdope)
        loc_oP2.AddObject("grd_4c_Dados", "Grid")
        WITH loc_oP2.grd_4c_Dados
            .ColumnCount       = 8
            .FontName          = "Tahoma"
            .AllowHeaderSizing = .F.
            .AllowRowSizing    = .F.
            .DeleteMark        = .F.
            .Height            = 382
            .Left              = 9
            .Panel             = 1
            .RecordMark        = .F.
            .ScrollBars        = 2
            .SplitBar          = .F.
            .TabIndex          = 1
            .Top               = 152
            .Width             = 981
            .GridLineColor     = RGB(238,238,238)
            .Themes            = .F.
            .Column1.Width     = 16
            .Column1.Movable   = .F.
            .Column1.Resizable = .F.
            .Column1.Sparse    = .F.
            .Column1.ColumnOrder = 1
            .Column1.AddObject("Check1", "CheckBox")
            .Column1.Check1.Caption = ""
            .Column1.Check1.Value   = 0
            .Column1.CurrentControl = "Check1"
            .Column2.Width     = 70
            .Column2.Movable   = .F.
            .Column2.Resizable = .F.
            .Column2.ReadOnly  = .T.
            .Column2.ColumnOrder = 3
            .Column3.Width     = 70
            .Column3.Movable   = .F.
            .Column3.Resizable = .F.
            .Column3.ReadOnly  = .T.
            .Column3.ColumnOrder = 4
            .Column4.Width     = 100
            .Column4.Movable   = .F.
            .Column4.Resizable = .F.
            .Column4.ReadOnly  = .T.
            .Column4.ColumnOrder = 5
            .Column5.Width     = 40
            .Column5.Movable   = .F.
            .Column5.Resizable = .F.
            .Column5.ReadOnly  = .T.
            .Column5.ColumnOrder = 6
            .Column6.Width     = 400
            .Column6.Movable   = .F.
            .Column6.Resizable = .F.
            .Column6.ReadOnly  = .T.
            .Column6.ColumnOrder = 7
            .Column7.Width     = 300
            .Column7.Movable   = .F.
            .Column7.Resizable = .F.
            .Column7.ReadOnly  = .T.
            .Column7.ColumnOrder = 8
            .Column8.Width     = 60
            .Column8.Movable   = .F.
            .Column8.Resizable = .F.
            .Column8.ReadOnly  = .T.
            .Column8.ColumnOrder = 2
        ENDWITH

        *-- CommandGroup Encerrar (Page2) - volta para Page1
        loc_oP2.AddObject("cgp_4c_Encerrar", "CommandGroup")
        loc_oCgp = loc_oP2.cgp_4c_Encerrar
        WITH loc_oCgp
            .AutoSize      = .T.
            .ButtonCount   = 1
            .BackStyle     = 0
            .BorderStyle   = 0
            .Value         = 0
            .Height        = 85
            .Left          = 917
            .SpecialEffect = 1
            .Top           = -2
            .Width         = 85
            .TabIndex      = 2
            .BackColor     = RGB(240,240,240)
            .Themes        = .F.
            WITH .Command1
                .Top           = 5
                .Left          = 5
                .Height        = 75
                .Width         = 75
                .FontBold      = .T.
                .FontItalic    = .T.
                .FontName      = "Comic Sans MS"
                .FontSize      = 8
                .Picture       = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
                .Cancel        = .T.
                .Caption       = "Encerrar"
                .ToolTipText   = "[ESC] Encerrar"
                .ForeColor     = RGB(90,90,90)
                .BackColor     = RGB(255,255,255)
                .Themes        = .F.
                .Name          = "btnsair"
            ENDWITH
        ENDWITH

        *-- CommandGroup acoes CNAB (Gerar CNAB + Relatorio + Boleto)
        loc_oP2.AddObject("cgp_4c_Acoes", "CommandGroup")
        loc_oCgp = loc_oP2.cgp_4c_Acoes
        WITH loc_oCgp
            .AutoSize      = .T.
            .ButtonCount   = 3
            .BackStyle     = 0
            .BorderStyle   = 0
            .Value         = 0
            .Height        = 85
            .Left          = 692
            .SpecialEffect = 1
            .Top           = -2
            .Width         = 235
            .TabIndex      = 3
            .BackColor     = RGB(240,240,240)
            .Themes        = .F.
            WITH .Command1
                .Top     = 5
                .Left    = 5
                .Height  = 75
                .Width   = 75
                .FontBold = .T.
                .FontItalic = .T.
                .FontName = "Comic Sans MS"
                .FontSize = 8
                .Picture  = gc_4c_CaminhoIcones + "geral_disco2_60.jpg"
                .Caption  = "Gerar CNAB"
                .ForeColor = RGB(90,90,90)
                .BackColor = RGB(255,255,255)
                .Themes   = .F.
                .Name     = "btncnab"
            ENDWITH
            WITH .Command2
                .Top     = 5
                .Left    = 80
                .Height  = 75
                .Width   = 75
                .FontBold = .T.
                .FontItalic = .T.
                .FontName = "Comic Sans MS"
                .FontSize = 8
                .Picture  = gc_4c_CaminhoIcones + "geral_video_60.jpg"
                .Caption  = "Relat" + CHR(243) + "rio"
                .Enabled  = .F.
                .ForeColor = RGB(90,90,90)
                .BackColor = RGB(255,255,255)
                .Themes   = .F.
                .Name     = "btnrelatorio"
            ENDWITH
            WITH .Command3
                .Top     = 5
                .Left    = 155
                .Height  = 75
                .Width   = 75
                .FontBold = .T.
                .FontItalic = .T.
                .FontName = "Comic Sans MS"
                .FontSize = 8
                .Picture  = gc_4c_CaminhoIcones + "geral_impressora_60.jpg"
                .Caption  = "Boleto"
                .Enabled  = .F.
                .ForeColor = RGB(90,90,90)
                .BackColor = RGB(255,255,255)
                .Name     = "btnBoleto"
            ENDWITH
        ENDWITH

        *-- Label "Protestar apos :"
        loc_oP2.AddObject("lbl_4c_Protestar", "Label")
        WITH loc_oP2.lbl_4c_Protestar
            .Caption  = "Protestar ap" + CHR(243) + "s :"
            .Enabled  = .F.
            .Height   = 15
            .Left     = 423
            .Top      = 117
            .Width    = 80
            .TabIndex = 5
            .BackStyle = 0
            .ForeColor = RGB(90,90,90)
        ENDWITH

        *-- Spinner dias (spndias)
        loc_oP2.AddObject("spn_4c_Dias", "Spinner")
        WITH loc_oP2.spn_4c_Dias
            .FontName          = "Tahoma"
            .FontSize          = 8
            .Enabled           = .F.
            .Height            = 24
            .KeyboardHighValue = 99
            .KeyboardLowValue  = 0
            .Left              = 505
            .SpecialEffect     = 1
            .SpinnerHighValue  = 99
            .SpinnerLowValue   = 0
            .TabIndex          = 7
            .Top               = 113
            .Width             = 45
            .Value             = 5
        ENDWITH

        *-- Label "dias"
        loc_oP2.AddObject("lbl_4c_Dias", "Label")
        WITH loc_oP2.lbl_4c_Dias
            .Caption  = "dias"
            .Enabled  = .F.
            .Height   = 15
            .Left     = 555
            .Top      = 118
            .Width    = 21
            .TabIndex = 6
            .BackStyle = 0
            .ForeColor = RGB(90,90,90)
        ENDWITH

        *-- CommandGroup Marcar/Desmarcar operacoes
        loc_oP2.AddObject("cgp_4c_MarcaDados", "CommandGroup")
        WITH loc_oP2.cgp_4c_MarcaDados
            .AutoSize      = .F.
            .ButtonCount   = 2
            .BackStyle     = 0
            .BorderStyle   = 0
            .Value         = 0
            .Height        = 50
            .Left          = 9
            .SpecialEffect = 1
            .Top           = 540
            .Width         = 92
            .TabIndex      = 4
            .BackColor     = RGB(240,240,240)
            .Themes        = .F.
            WITH .Command1
                .Top     = 5
                .Left    = 7
                .Height  = 40
                .Width   = 40
                .Picture  = gc_4c_CaminhoIcones + "geral_adicao_26.jpg"
                .Caption  = ""
                .ToolTipText = "Marcar tudo"
                .ForeColor = RGB(36,84,155)
                .BackColor = RGB(255,255,255)
                .Themes   = .F.
                .Name     = "btnmarca"
            ENDWITH
            WITH .Command2
                .Top     = 5
                .Left    = 47
                .Height  = 40
                .Width   = 40
                .FontName = "Verdana"
                .FontSize = 8
                .Picture  = gc_4c_CaminhoIcones + "cadastro_excluir_26.jpg"
                .Caption  = ""
                .ToolTipText = "Desmarcar tudo"
                .ForeColor = RGB(36,84,155)
                .BackColor = RGB(255,255,255)
                .Themes   = .F.
                .Name     = "btndesmarca"
            ENDWITH
        ENDWITH
    ENDPROC

    *==========================================================================
    * TornarControlesVisiveis
    *==========================================================================
    PROTECTED PROCEDURE TornarControlesVisiveis()
        LOCAL loc_oP1, loc_oP2, loc_oPgf

        loc_oPgf = THIS.pgf_4c_Principal
        loc_oPgf.Visible = .T.

        loc_oP1 = loc_oPgf.pgfiltro
        loc_oP1.cnt_4c_Sombra.Visible            = .T.
        loc_oP1.cnt_4c_Sombra.lbl_4c_Sombra.Visible = .T.
        loc_oP1.cnt_4c_Sombra.lbl_4c_Titulo.Visible = .T.
        loc_oP1.cgp_4c_Filtro.Visible            = .T.
        loc_oP1.lbl_4c_LblOper.Visible           = .T.
        loc_oP1.opt_4c_Processados.Visible        = .T.
        loc_oP1.lbl_4c_LblEmpresa.Visible         = .T.
        loc_oP1.txt_4c_CdEmpresa.Visible          = .T.
        loc_oP1.txt_4c_DsEmpresa.Visible          = .T.
        loc_oP1.lbl_4c_LblPeriodo.Visible         = .T.
        loc_oP1.txt_4c_Datai.Visible              = .T.
        loc_oP1.lbl_4c_LblAte.Visible             = .T.
        loc_oP1.txt_4c_Dataf.Visible              = .T.
        loc_oP1.opt_4c_Periodo.Visible            = .T.
        loc_oP1.lbl_4c_LblBanco.Visible           = .T.
        loc_oP1.txt_4c_CdConta.Visible            = .T.
        loc_oP1.txt_4c_DsConta.Visible            = .T.
        loc_oP1.lbl_4c_LblEmpConv.Visible         = .T.
        loc_oP1.txt_4c_CdEmpConv.Visible          = .T.
        loc_oP1.txt_4c_DsEmpConv.Visible          = .T.
        loc_oP1.lbl_4c_LblGrupos.Visible          = .T.
        loc_oP1.grd_4c_Grupos.Visible             = .T.
        loc_oP1.cgp_4c_MarcaFiltro.Visible        = .T.

        loc_oP2 = loc_oPgf.pgdados
        loc_oP2.grd_4c_Dados.Visible              = .T.
        loc_oP2.cgp_4c_Encerrar.Visible           = .T.
        loc_oP2.cgp_4c_Acoes.Visible              = .T.
        loc_oP2.lbl_4c_Protestar.Visible          = .T.
        loc_oP2.spn_4c_Dias.Visible               = .T.
        loc_oP2.lbl_4c_Dias.Visible               = .T.
        loc_oP2.cgp_4c_MarcaDados.Visible         = .T.
    ENDPROC

    *==========================================================================
    * ConfigurarBINDEVENTs - Liga eventos aos handlers do form
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarBINDEVENTs()
        LOCAL loc_oP1, loc_oP2

        loc_oP1 = THIS.pgf_4c_Principal.pgfiltro
        loc_oP2 = THIS.pgf_4c_Principal.pgdados

        *-- Botoes filtro
        BINDEVENT(loc_oP1.cgp_4c_Filtro.Command1, "Click", THIS, "ClickProcessar")
        BINDEVENT(loc_oP1.cgp_4c_Filtro.Command2, "Click", THIS, "ClickEncerrarFiltro")

        *-- Validacao e lookup dos campos de filtro
        *-- KeyPress: ENTER(13)/TAB(9) valida, F4(115) abre lookup, DblClick abre lookup
        BINDEVENT(loc_oP1.txt_4c_CdEmpresa,  "KeyPress", THIS, "TxtCdEmpresaKeyPress")
        BINDEVENT(loc_oP1.txt_4c_CdEmpresa,  "DblClick", THIS, "AbrirLookupEmpresa")
        BINDEVENT(loc_oP1.txt_4c_DsEmpresa,  "KeyPress", THIS, "TxtDsEmpresaKeyPress")
        BINDEVENT(loc_oP1.txt_4c_CdConta,    "KeyPress", THIS, "TxtCdContaKeyPress")
        BINDEVENT(loc_oP1.txt_4c_CdConta,    "DblClick", THIS, "AbrirLookupConta")
        BINDEVENT(loc_oP1.txt_4c_DsConta,    "KeyPress", THIS, "TxtDsContaKeyPress")
        BINDEVENT(loc_oP1.txt_4c_CdEmpConv,  "KeyPress", THIS, "TxtCdEmpConvKeyPress")
        BINDEVENT(loc_oP1.txt_4c_CdEmpConv,  "DblClick", THIS, "AbrirLookupEmpConv")
        BINDEVENT(loc_oP1.txt_4c_DsEmpConv,  "KeyPress", THIS, "TxtDsEmpConvKeyPress")
        BINDEVENT(loc_oP1.txt_4c_Dataf,      "KeyPress", THIS, "TxtDatafKeyPress")

        *-- Marcar/desmarcar grupos
        BINDEVENT(loc_oP1.cgp_4c_MarcaFiltro.Command1, "Click", THIS, "ClickMarcarGrupos")
        BINDEVENT(loc_oP1.cgp_4c_MarcaFiltro.Command2, "Click", THIS, "ClickDesmarcarGrupos")

        *-- Botoes dados
        BINDEVENT(loc_oP2.cgp_4c_Encerrar.Command1, "Click", THIS, "ClickEncerrarDados")
        BINDEVENT(loc_oP2.cgp_4c_Acoes.Command1, "Click", THIS, "ClickGerarCNAB")
        BINDEVENT(loc_oP2.cgp_4c_Acoes.Command2, "Click", THIS, "ClickRelatorio")
        BINDEVENT(loc_oP2.cgp_4c_Acoes.Command3, "Click", THIS, "ClickBoleto")

        *-- Marcar/desmarcar operacoes
        BINDEVENT(loc_oP2.cgp_4c_MarcaDados.Command1, "Click", THIS, "ClickMarcarOper")
        BINDEVENT(loc_oP2.cgp_4c_MarcaDados.Command2, "Click", THIS, "ClickDesmarcarOper")

        *-- Headers do grid de operacoes (clique para ordenar)
        BINDEVENT(loc_oP2.grd_4c_Dados.Column3.Header1, "Click", THIS, "ClickHeaderVencs")
        BINDEVENT(loc_oP2.grd_4c_Dados.Column4.Header1, "Click", THIS, "ClickHeaderValors")
        BINDEVENT(loc_oP2.grd_4c_Dados.Column6.Header1, "Click", THIS, "ClickHeaderHisto")
        BINDEVENT(loc_oP2.grd_4c_Dados.Column7.Header1, "Click", THIS, "ClickHeaderRclis")
    ENDPROC

    *==========================================================================
    * InicializarValores - Carrega dados iniciais (grupos, etc.)
    *==========================================================================
    PROTECTED PROCEDURE InicializarValores()
        LOCAL loc_oGrd

        IF THIS.this_oBusinessObject.BuscarGrupos()
            loc_oGrd = THIS.pgf_4c_Principal.pgfiltro.grd_4c_Grupos
            loc_oGrd.ColumnCount = 2
            loc_oGrd.RecordSource      = "cursor_4c_Grupos"
            loc_oGrd.Column1.ControlSource = "cursor_4c_Grupos.marca"
            loc_oGrd.Column2.ControlSource = "cursor_4c_Grupos.descrs"
            loc_oGrd.Column1.Header1.Caption = ""
            loc_oGrd.Column2.Header1.Caption = "Grupos"
            loc_oGrd.Column2.Header1.Alignment = 2
            loc_oGrd.Refresh()
        ENDIF

        THIS.pgf_4c_Principal.pgfiltro.txt_4c_CdEmpresa.SetFocus()
    ENDPROC

    *==========================================================================
    * HANDLERS DE VALIDACAO DOS CAMPOS DE FILTRO
    *==========================================================================

    PROCEDURE ValidarCdEmpresa()
        LOCAL loc_cCod, loc_cSQL
        loc_cCod = ALLTRIM(THIS.pgf_4c_Principal.pgfiltro.txt_4c_CdEmpresa.Value)
        IF EMPTY(loc_cCod)
            THIS.pgf_4c_Principal.pgfiltro.txt_4c_DsEmpresa.Value = ""
            RETURN
        ENDIF
        IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
            RETURN
        ENDIF
        loc_cSQL = "SELECT TOP 1 RazSocs FROM SigCdEmp WHERE Cemps = " + EscaparSQL(loc_cCod)
        IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_EmpTmpV") >= 1 AND RECCOUNT("cursor_4c_EmpTmpV") > 0
            SELECT cursor_4c_EmpTmpV
            THIS.pgf_4c_Principal.pgfiltro.txt_4c_DsEmpresa.Value = ALLTRIM(cursor_4c_EmpTmpV.RazSocs)
        ELSE
            THIS.pgf_4c_Principal.pgfiltro.txt_4c_CdEmpresa.Value = ""
            THIS.pgf_4c_Principal.pgfiltro.txt_4c_DsEmpresa.Value = ""
            MsgAviso("Empresa inv" + CHR(225) + "lida.")
        ENDIF
        IF USED("cursor_4c_EmpTmpV")
            USE IN cursor_4c_EmpTmpV
        ENDIF
    ENDPROC

    PROCEDURE ValidarDsEmpresa()
        LOCAL loc_cDs, loc_cSQL
        loc_cDs = ALLTRIM(THIS.pgf_4c_Principal.pgfiltro.txt_4c_DsEmpresa.Value)
        IF EMPTY(loc_cDs)
            RETURN
        ENDIF
        IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
            RETURN
        ENDIF
        loc_cSQL = "SELECT TOP 1 Cemps, RazSocs FROM SigCdEmp WHERE RazSocs LIKE " + EscaparSQL(loc_cDs + "%")
        IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_EmpTmpV") >= 1 AND RECCOUNT("cursor_4c_EmpTmpV") > 0
            SELECT cursor_4c_EmpTmpV
            THIS.pgf_4c_Principal.pgfiltro.txt_4c_CdEmpresa.Value = ALLTRIM(cursor_4c_EmpTmpV.Cemps)
            THIS.pgf_4c_Principal.pgfiltro.txt_4c_DsEmpresa.Value = ALLTRIM(cursor_4c_EmpTmpV.RazSocs)
        ELSE
            THIS.pgf_4c_Principal.pgfiltro.txt_4c_CdEmpresa.Value = ""
            THIS.pgf_4c_Principal.pgfiltro.txt_4c_DsEmpresa.Value = ""
        ENDIF
        IF USED("cursor_4c_EmpTmpV")
            USE IN cursor_4c_EmpTmpV
        ENDIF
    ENDPROC

    PROCEDURE ValidarCdConta()
        LOCAL loc_cCod, loc_cGrupo, loc_llRet
        loc_cCod = ALLTRIM(THIS.pgf_4c_Principal.pgfiltro.txt_4c_CdConta.Value)
        IF EMPTY(loc_cCod)
            THIS.pgf_4c_Principal.pgfiltro.txt_4c_DsConta.Value = ""
            RETURN
        ENDIF
        IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
            RETURN
        ENDIF
        loc_cGrupo = ""
        loc_llRet = fAcessoContas(gc_4c_UsuarioLogado, loc_cGrupo, "C", loc_cCod, ;
                    THIS.pgf_4c_Principal.pgfiltro.txt_4c_CdConta, ;
                    THIS.pgf_4c_Principal.pgfiltro.txt_4c_DsConta)
        IF !loc_llRet
            MsgAviso("Conta inv" + CHR(225) + "lida, acesso negado.")
            THIS.pgf_4c_Principal.pgfiltro.txt_4c_CdConta.Value = ""
            THIS.pgf_4c_Principal.pgfiltro.txt_4c_DsConta.Value = ""
        ENDIF
    ENDPROC

    PROCEDURE ValidarDsConta()
        LOCAL loc_cDs, loc_cGrupo, loc_llRet
        loc_cDs = ALLTRIM(THIS.pgf_4c_Principal.pgfiltro.txt_4c_DsConta.Value)
        IF EMPTY(loc_cDs)
            RETURN
        ENDIF
        IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
            RETURN
        ENDIF
        loc_cGrupo = ""
        loc_llRet = fAcessoContas(gc_4c_UsuarioLogado, loc_cGrupo, "D", loc_cDs, ;
                    THIS.pgf_4c_Principal.pgfiltro.txt_4c_CdConta, ;
                    THIS.pgf_4c_Principal.pgfiltro.txt_4c_DsConta)
        IF !loc_llRet
            THIS.pgf_4c_Principal.pgfiltro.txt_4c_CdConta.Value = ""
            THIS.pgf_4c_Principal.pgfiltro.txt_4c_DsConta.Value = ""
        ENDIF
    ENDPROC

    PROCEDURE ValidarCdEmpConv()
        LOCAL loc_cCod, loc_cSQL
        loc_cCod = ALLTRIM(THIS.pgf_4c_Principal.pgfiltro.txt_4c_CdEmpConv.Value)
        IF EMPTY(loc_cCod)
            THIS.pgf_4c_Principal.pgfiltro.txt_4c_DsEmpConv.Value = ""
            RETURN
        ENDIF
        IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
            RETURN
        ENDIF
        loc_cSQL = "SELECT TOP 1 RazSocs FROM SigCdEmp WHERE Cemps = " + EscaparSQL(loc_cCod)
        IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_EmpConvV") >= 1 AND RECCOUNT("cursor_4c_EmpConvV") > 0
            SELECT cursor_4c_EmpConvV
            THIS.pgf_4c_Principal.pgfiltro.txt_4c_DsEmpConv.Value = ALLTRIM(cursor_4c_EmpConvV.RazSocs)
        ELSE
            THIS.pgf_4c_Principal.pgfiltro.txt_4c_CdEmpConv.Value = ""
            THIS.pgf_4c_Principal.pgfiltro.txt_4c_DsEmpConv.Value = ""
            MsgAviso("Empresa do conv" + CHR(234) + "nio inv" + CHR(225) + "lida.")
        ENDIF
        IF USED("cursor_4c_EmpConvV")
            USE IN cursor_4c_EmpConvV
        ENDIF
    ENDPROC

    PROCEDURE ValidarDsEmpConv()
        LOCAL loc_cDs, loc_cSQL
        loc_cDs = ALLTRIM(THIS.pgf_4c_Principal.pgfiltro.txt_4c_DsEmpConv.Value)
        IF EMPTY(loc_cDs)
            RETURN
        ENDIF
        IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
            RETURN
        ENDIF
        loc_cSQL = "SELECT TOP 1 Cemps, RazSocs FROM SigCdEmp WHERE RazSocs LIKE " + EscaparSQL(loc_cDs + "%")
        IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_EmpConvV") >= 1 AND RECCOUNT("cursor_4c_EmpConvV") > 0
            SELECT cursor_4c_EmpConvV
            THIS.pgf_4c_Principal.pgfiltro.txt_4c_CdEmpConv.Value = ALLTRIM(cursor_4c_EmpConvV.Cemps)
            THIS.pgf_4c_Principal.pgfiltro.txt_4c_DsEmpConv.Value = ALLTRIM(cursor_4c_EmpConvV.RazSocs)
        ELSE
            THIS.pgf_4c_Principal.pgfiltro.txt_4c_CdEmpConv.Value = ""
            THIS.pgf_4c_Principal.pgfiltro.txt_4c_DsEmpConv.Value = ""
        ENDIF
        IF USED("cursor_4c_EmpConvV")
            USE IN cursor_4c_EmpConvV
        ENDIF
    ENDPROC

    PROCEDURE ValidarDataf()
        LOCAL loc_dDatf, loc_dDati
        loc_dDatf = THIS.pgf_4c_Principal.pgfiltro.txt_4c_Dataf.Value
        loc_dDati = THIS.pgf_4c_Principal.pgfiltro.txt_4c_Datai.Value
        IF !EMPTY(loc_dDati) AND !EMPTY(loc_dDatf) AND loc_dDatf < loc_dDati
            MsgAviso("Data Final Deve Ser Maior Que a Inicial!!!")
            THIS.pgf_4c_Principal.pgfiltro.txt_4c_Dataf.Value = {}
        ENDIF
    ENDPROC

    *==========================================================================
    * HANDLERS KEYPRESS - Disparam validacao (ENTER/TAB) e lookup (F4)
    *==========================================================================

    PROCEDURE TxtCdEmpresaKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 13 OR par_nKeyCode = 9 OR par_nKeyCode = 115
            THIS.AbrirLookupEmpresa()
        ENDIF
        IF par_nKeyCode = 13 OR par_nKeyCode = 9
            THIS.ValidarCdEmpresa()
        ENDIF
    ENDPROC

    PROCEDURE TxtDsEmpresaKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 13 OR par_nKeyCode = 9
            THIS.ValidarDsEmpresa()
        ENDIF
    ENDPROC

    PROCEDURE TxtCdContaKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 13 OR par_nKeyCode = 9 OR par_nKeyCode = 115
            THIS.AbrirLookupConta()
        ENDIF
        IF par_nKeyCode = 13 OR par_nKeyCode = 9
            THIS.ValidarCdConta()
        ENDIF
    ENDPROC

    PROCEDURE TxtDsContaKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 13 OR par_nKeyCode = 9
            THIS.ValidarDsConta()
        ENDIF
    ENDPROC

    PROCEDURE TxtCdEmpConvKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 13 OR par_nKeyCode = 9 OR par_nKeyCode = 115
            THIS.AbrirLookupEmpConv()
        ENDIF
        IF par_nKeyCode = 13 OR par_nKeyCode = 9
            THIS.ValidarCdEmpConv()
        ENDIF
    ENDPROC

    PROCEDURE TxtDsEmpConvKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 13 OR par_nKeyCode = 9
            THIS.ValidarDsEmpConv()
        ENDIF
    ENDPROC

    PROCEDURE TxtDatafKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 13 OR par_nKeyCode = 9
            THIS.ValidarDataf()
        ENDIF
    ENDPROC

    *==========================================================================
    * LOOKUPS - Abrem FormBuscaAuxiliar para selecao de Empresa ou Conta
    *==========================================================================

    PROCEDURE AbrirLookupEmpresa()
        LOCAL loc_oBusca, loc_oP1
        loc_oP1 = THIS.pgf_4c_Principal.pgfiltro

        IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
            RETURN
        ENDIF

        loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
            "SigCdEmp", ;
            "cursor_4c_BuscaEmpresa", ;
            "Cemps", ;
            ALLTRIM(loc_oP1.txt_4c_CdEmpresa.Value), ;
            "Buscar Empresa")

        loc_oBusca.mAddColuna("Cemps",   "", "C" + CHR(243) + "digo")
        loc_oBusca.mAddColuna("RazSocs", "", "Raz" + CHR(227) + "o Social")
        loc_oBusca.mAddColuna("Cgcs",    "", "CNPJ")
        loc_oBusca.Show()

        IF loc_oBusca.this_lSelecionou
            IF USED("cursor_4c_BuscaEmpresa")
                SELECT cursor_4c_BuscaEmpresa
                loc_oP1.txt_4c_CdEmpresa.Value = ALLTRIM(cursor_4c_BuscaEmpresa.Cemps)
                loc_oP1.txt_4c_DsEmpresa.Value = ALLTRIM(cursor_4c_BuscaEmpresa.RazSocs)
            ENDIF
        ENDIF

        IF USED("cursor_4c_BuscaEmpresa")
            USE IN cursor_4c_BuscaEmpresa
        ENDIF
        loc_oBusca.Release()
    ENDPROC

    PROCEDURE AbrirLookupConta()
        LOCAL loc_oBusca, loc_oP1
        loc_oP1 = THIS.pgf_4c_Principal.pgfiltro

        IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
            RETURN
        ENDIF

        loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
            "SigCdCeb", ;
            "cursor_4c_BuscaConta", ;
            "GruContas", ;
            ALLTRIM(loc_oP1.txt_4c_CdConta.Value), ;
            "Buscar Conta Banc" + CHR(225) + "ria")

        loc_oBusca.mAddColuna("GruContas", "", "C" + CHR(243) + "digo")
        loc_oBusca.mAddColuna("bancos",    "", "Banco")
        loc_oBusca.mAddColuna("NAgencias", "", "Ag" + CHR(234) + "ncia")
        loc_oBusca.Show()

        IF loc_oBusca.this_lSelecionou
            IF USED("cursor_4c_BuscaConta")
                SELECT cursor_4c_BuscaConta
                loc_oP1.txt_4c_CdConta.Value = ALLTRIM(cursor_4c_BuscaConta.GruContas)
                loc_oP1.txt_4c_DsConta.Value = ALLTRIM(cursor_4c_BuscaConta.bancos) + ;
                                               " - Ag" + CHR(234) + " " + ;
                                               ALLTRIM(cursor_4c_BuscaConta.NAgencias)
            ENDIF
        ENDIF

        IF USED("cursor_4c_BuscaConta")
            USE IN cursor_4c_BuscaConta
        ENDIF
        loc_oBusca.Release()
    ENDPROC

    PROCEDURE AbrirLookupEmpConv()
        LOCAL loc_oBusca, loc_oP1
        loc_oP1 = THIS.pgf_4c_Principal.pgfiltro

        IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
            RETURN
        ENDIF

        loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
            "SigCdEmp", ;
            "cursor_4c_BuscaEmpConv", ;
            "Cemps", ;
            ALLTRIM(loc_oP1.txt_4c_CdEmpConv.Value), ;
            "Buscar Empresa Conv" + CHR(234) + "nio")

        loc_oBusca.mAddColuna("Cemps",   "", "C" + CHR(243) + "digo")
        loc_oBusca.mAddColuna("RazSocs", "", "Raz" + CHR(227) + "o Social")
        loc_oBusca.mAddColuna("Cgcs",    "", "CNPJ")
        loc_oBusca.Show()

        IF loc_oBusca.this_lSelecionou
            IF USED("cursor_4c_BuscaEmpConv")
                SELECT cursor_4c_BuscaEmpConv
                loc_oP1.txt_4c_CdEmpConv.Value = ALLTRIM(cursor_4c_BuscaEmpConv.Cemps)
                loc_oP1.txt_4c_DsEmpConv.Value = ALLTRIM(cursor_4c_BuscaEmpConv.RazSocs)
            ENDIF
        ENDIF

        IF USED("cursor_4c_BuscaEmpConv")
            USE IN cursor_4c_BuscaEmpConv
        ENDIF
        loc_oBusca.Release()
    ENDPROC

    *==========================================================================
    * HANDLERS DOS BOTOES
    *==========================================================================

    PROCEDURE ClickProcessar()
        LOCAL loc_cCdEmp, loc_dDati, loc_dDatf, loc_cCdConta, loc_cCdEmpConv
        LOCAL loc_nCont

        loc_cCdEmp    = ALLTRIM(THIS.pgf_4c_Principal.pgfiltro.txt_4c_CdEmpresa.Value)
        loc_dDati     = THIS.pgf_4c_Principal.pgfiltro.txt_4c_Datai.Value
        loc_dDatf     = THIS.pgf_4c_Principal.pgfiltro.txt_4c_Dataf.Value
        loc_cCdConta  = ALLTRIM(THIS.pgf_4c_Principal.pgfiltro.txt_4c_CdConta.Value)
        loc_cCdEmpConv = ALLTRIM(THIS.pgf_4c_Principal.pgfiltro.txt_4c_CdEmpConv.Value)

        IF EMPTY(loc_cCdEmp)
            MsgAviso("Empresa inv" + CHR(225) + "lida")
            THIS.pgf_4c_Principal.pgfiltro.txt_4c_CdEmpresa.SetFocus()
            RETURN
        ENDIF
        IF EMPTY(loc_dDati) OR EMPTY(loc_dDatf)
            MsgAviso("Per" + CHR(237) + "odo inv" + CHR(225) + "lido")
            THIS.pgf_4c_Principal.pgfiltro.txt_4c_Datai.SetFocus()
            RETURN
        ENDIF
        IF EMPTY(loc_cCdConta)
            MsgAviso("Banco inv" + CHR(225) + "lido")
            THIS.pgf_4c_Principal.pgfiltro.txt_4c_CdConta.SetFocus()
            RETURN
        ENDIF
        IF EMPTY(loc_cCdEmpConv)
            MsgAviso("Empresa com dados banc" + CHR(225) + "rios inv" + CHR(225) + "lida")
            THIS.pgf_4c_Principal.pgfiltro.txt_4c_CdEmpConv.SetFocus()
            RETURN
        ENDIF

        IF USED("cursor_4c_Grupos")
            SELECT cursor_4c_Grupos
            loc_nCont = 0
            SCAN
                IF cursor_4c_Grupos.marca
                    loc_nCont = loc_nCont + 1
                ENDIF
            ENDSCAN
            IF loc_nCont = 0
                MsgAviso("Nenhum grupo foi selecionado")
                RETURN
            ENDIF
        ENDIF

        THIS.Processamento()
    ENDPROC

    PROCEDURE ClickEncerrarFiltro()
        THIS.Release()
    ENDPROC

    PROCEDURE ClickEncerrarDados()
        THIS.AlternarPagina(1)
    ENDPROC

    PROCEDURE ClickGerarCNAB()
        THIS.GerarCNAB("A")
    ENDPROC

    PROCEDURE ClickRelatorio()
        THIS.GerarCNAB("V")
    ENDPROC

    PROCEDURE ClickBoleto()
        THIS.GerarCNAB("I")
        THIS.ImpBoleto(.T.)
    ENDPROC

    *==========================================================================
    * ImpBoleto - Imprime/exibe boletos dos registros marcados em cursor_4c_Filtro2Rel
    * par_lImprimir: .T. = preview + impressora, .F. = apenas preview
    * Chamado apos GerarCNAB("I") que prepara cursor_4c_Filtro2Rel e cursor_4c_CabRel
    *==========================================================================
    PROCEDURE ImpBoleto(par_lImprimir)
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        TRY
            IF !USED("cursor_4c_Filtro2Rel") OR RECCOUNT("cursor_4c_Filtro2Rel") = 0
                MsgAviso("Nenhum dado dispon" + CHR(237) + "vel para impress" + CHR(227) + "o de boleto")
                RETURN
            ENDIF

            SELECT cursor_4c_Filtro2Rel
            GO TOP

            IF par_lImprimir
                REPORT FORM sigrecnb PREVIEW NOCONSOLE
            ELSE
                REPORT FORM sigrecnb PREVIEW
            ENDIF

            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ImpBoleto")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    PROCEDURE ClickMarcarGrupos()
        IF USED("cursor_4c_Grupos")
            SELECT cursor_4c_Grupos
            REPLACE ALL marca WITH .T.
            GO TOP
            THIS.pgf_4c_Principal.pgfiltro.grd_4c_Grupos.Refresh()
        ENDIF
    ENDPROC

    PROCEDURE ClickDesmarcarGrupos()
        IF USED("cursor_4c_Grupos")
            SELECT cursor_4c_Grupos
            REPLACE ALL marca WITH .F.
            GO TOP
            THIS.pgf_4c_Principal.pgfiltro.grd_4c_Grupos.Refresh()
        ENDIF
    ENDPROC

    PROCEDURE ClickMarcarOper()
        IF USED("cursor_4c_Filtro")
            SELECT cursor_4c_Filtro
            REPLACE ALL marca WITH .T.
            GO TOP
            THIS.pgf_4c_Principal.pgdados.grd_4c_Dados.Refresh()
        ENDIF
    ENDPROC

    PROCEDURE ClickDesmarcarOper()
        IF USED("cursor_4c_Filtro")
            SELECT cursor_4c_Filtro
            REPLACE ALL marca WITH .F.
            GO TOP
            THIS.pgf_4c_Principal.pgdados.grd_4c_Dados.Refresh()
        ENDIF
    ENDPROC

    PROCEDURE ClickHeaderVencs()
        IF USED("cursor_4c_Filtro")
            SELECT cursor_4c_Filtro
            INDEX ON vencs TAG vencs
            SET ORDER TO vencs
            THIS.OrdenarGrade()
        ENDIF
    ENDPROC

    PROCEDURE ClickHeaderValors()
        IF USED("cursor_4c_Filtro")
            SELECT cursor_4c_Filtro
            INDEX ON Valors TAG valors
            SET ORDER TO valors
            THIS.OrdenarGrade()
        ENDIF
    ENDPROC

    PROCEDURE ClickHeaderHisto()
        IF USED("cursor_4c_Filtro")
            SELECT cursor_4c_Filtro
            INDEX ON histo TAG histo
            SET ORDER TO histo
            THIS.OrdenarGrade()
        ENDIF
    ENDPROC

    PROCEDURE ClickHeaderRclis()
        IF USED("cursor_4c_Filtro")
            SELECT cursor_4c_Filtro
            INDEX ON rclis TAG rclis
            SET ORDER TO rclis
            THIS.OrdenarGrade()
        ENDIF
    ENDPROC

    *==========================================================================
    * BtnIncluirClick - Inicia novo processamento (volta para pagina de filtros)
    * Form OPERACIONAL: "Incluir" = preparar novo lote CNAB a partir da pag. filtro
    * Limpa o grid de dados e habilita filtros para nova selecao de operacoes
    *==========================================================================
    PROCEDURE BtnIncluirClick()
        LOCAL loc_oErro

        TRY
            THIS.AlternarPagina(1)
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro BtnIncluirClick")
        ENDTRY
    ENDPROC

    *==========================================================================
    * BtnAlterarClick - Executa o processamento dos filtros (operacao principal)
    * Form OPERACIONAL: "Alterar" = aplicar filtros e popular grid de operacoes
    * Delega para ClickProcessar (botao Testa Posicoes no SCX original)
    *==========================================================================
    PROCEDURE BtnAlterarClick()
        LOCAL loc_oErro

        TRY
            THIS.ClickProcessar()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro BtnAlterarClick")
        ENDTRY
    ENDPROC

    *==========================================================================
    * BtnVisualizarClick - Visualiza relatorio dos lancamentos selecionados
    * Form OPERACIONAL: "Visualizar" = gerar previa em modo visualizacao (Tipo "V")
    * Delega para ClickRelatorio que chama GerarCNAB("V") - preview do CNAB
    *==========================================================================
    PROCEDURE BtnVisualizarClick()
        LOCAL loc_oErro

        TRY
            IF !USED("cursor_4c_Filtro") OR RECCOUNT("cursor_4c_Filtro") = 0
                MsgAviso("Nenhuma opera" + CHR(231) + CHR(227) + "o dispon" + CHR(237) + ;
                         "vel para visualiza" + CHR(231) + CHR(227) + "o." + CHR(13) + ;
                         "Execute o processamento primeiro.", "Aviso")
                RETURN
            ENDIF

            THIS.ClickRelatorio()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro BtnVisualizarClick")
        ENDTRY
    ENDPROC

    *==========================================================================
    * BtnExcluirClick - Desmarca todas as operacoes selecionadas
    * Form OPERACIONAL: "Excluir" = remover marcas das operacoes do grid
    * Delega para ClickDesmarcarOper que zera marca em cursor_4c_Filtro
    *==========================================================================
    PROCEDURE BtnExcluirClick()
        LOCAL loc_oErro

        TRY
            IF !USED("cursor_4c_Filtro") OR RECCOUNT("cursor_4c_Filtro") = 0
                MsgAviso("Nenhuma opera" + CHR(231) + CHR(227) + "o para desmarcar.", "Aviso")
                RETURN
            ENDIF

            IF MsgConfirma("Desmarcar todas as opera" + CHR(231) + CHR(245) + "es selecionadas?", ;
                           "Confirma" + CHR(231) + CHR(227) + "o")
                THIS.ClickDesmarcarOper()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro BtnExcluirClick")
        ENDTRY
    ENDPROC

    *==========================================================================
    * AlternarPagina - Navega entre pagina de filtro (1) e pagina de dados (2)
    *==========================================================================
    PROCEDURE AlternarPagina(par_nPagina)
        LOCAL loc_oP1, loc_oP2
        loc_oP1 = THIS.pgf_4c_Principal.pgfiltro
        loc_oP2 = THIS.pgf_4c_Principal.pgdados

        IF par_nPagina = 1
            loc_oP2.grd_4c_Dados.RecordSource = ""
            loc_oP1.Enabled = .T.
            loc_oP2.Enabled = .F.
            THIS.pgf_4c_Principal.ActivePage = 1
        ELSE
            loc_oP1.Enabled = .F.
            loc_oP2.Enabled = .T.
            THIS.pgf_4c_Principal.ActivePage = 2
        ENDIF
    ENDPROC

    *==========================================================================
    * OrdenarGrade - Atualiza o grid de operacoes apos ordenacao
    *==========================================================================
    PROCEDURE OrdenarGrade()
        LOCAL loc_oGrd
        loc_oGrd = THIS.pgf_4c_Principal.pgdados.grd_4c_Dados
        GO BOTTOM IN cursor_4c_Filtro
        GO TOP IN cursor_4c_Filtro
        loc_oGrd.RecordSource = ""
        loc_oGrd.Refresh()
        loc_oGrd.ColumnCount = 8
        loc_oGrd.RecordSource = "cursor_4c_Filtro"
        loc_oGrd.SetAll("DynamicForeColor", "RGB(0,0,0)", "Column")
        loc_oGrd.Refresh()
    ENDPROC

    *==========================================================================
    * Processamento - Executa busca com filtros e muda para pagina de dados
    *==========================================================================
    PROCEDURE Processamento()
        LOCAL loc_oP1, loc_oP2, loc_oGrd
        LOCAL loc_cCdEmp, loc_cCdConta, loc_dDati, loc_dDatf
        LOCAL loc_lNaoProc, loc_nPeriodo, loc_cGrupos
        LOCAL loc_oBO

        loc_oP1  = THIS.pgf_4c_Principal.pgfiltro
        loc_oP2  = THIS.pgf_4c_Principal.pgdados
        loc_oGrd = loc_oP2.grd_4c_Dados
        loc_oBO  = THIS.this_oBusinessObject

        loc_cCdEmp   = ALLTRIM(loc_oP1.txt_4c_CdEmpresa.Value)
        loc_cCdConta = ALLTRIM(loc_oP1.txt_4c_CdConta.Value)
        loc_dDati    = loc_oP1.txt_4c_Datai.Value
        loc_dDatf    = loc_oP1.txt_4c_Dataf.Value
        loc_lNaoProc = (loc_oP1.opt_4c_Processados.Value = 1)
        loc_nPeriodo = loc_oP1.opt_4c_Periodo.Value

        *-- Monta lista de grupos marcados
        loc_cGrupos = "("
        IF USED("cursor_4c_Grupos")
            SELECT cursor_4c_Grupos
            SCAN
                IF cursor_4c_Grupos.marca
                    loc_cGrupos = loc_cGrupos + IIF(loc_cGrupos == "(", "", ",") + ;
                                  "'" + ALLTRIM(cursor_4c_Grupos.codigos) + "'"
                ENDIF
            ENDSCAN
        ENDIF
        loc_cGrupos = loc_cGrupos + ")"

        *-- Limpa grid antes da busca
        loc_oGrd.RecordSource = ""
        loc_oGrd.Refresh()

        IF !loc_oBO.BuscarOperacoes(loc_cCdEmp, loc_cCdConta, loc_dDati, loc_dDatf, ;
                                     loc_lNaoProc, loc_nPeriodo, loc_cGrupos)
            RETURN
        ENDIF

        IF RECCOUNT("cursor_4c_Filtro") = 0
            MsgAviso("Nenhum dado foi encontrado")
            RETURN
        ENDIF

        *-- Liga grid ao cursor
        loc_oGrd.ColumnCount = 8
        loc_oGrd.RecordSource = "cursor_4c_Filtro"
        loc_oGrd.Column1.ControlSource = "cursor_4c_Filtro.marca"
        loc_oGrd.Column2.ControlSource = "cursor_4c_Filtro.datas"
        loc_oGrd.Column3.ControlSource = "cursor_4c_Filtro.vencs"
        loc_oGrd.Column4.ControlSource = "cursor_4c_Filtro.Valors"
        loc_oGrd.Column5.ControlSource = "cursor_4c_Filtro.moedas"
        loc_oGrd.Column6.ControlSource = "cursor_4c_Filtro.histo"
        loc_oGrd.Column7.ControlSource = "cursor_4c_Filtro.rclis"
        loc_oGrd.Column8.ControlSource = "cursor_4c_Filtro.emps"

        loc_oGrd.Column1.Header1.Caption = ""
        loc_oGrd.Column2.Header1.Caption = "Data"
        loc_oGrd.Column3.Header1.Caption = "Vencimento"
        loc_oGrd.Column4.Header1.Caption = "Valor"
        loc_oGrd.Column5.Header1.Caption = "Moeda"
        loc_oGrd.Column6.Header1.Caption = "Historico"
        loc_oGrd.Column7.Header1.Caption = "Fornecedor"
        loc_oGrd.Column8.Header1.Caption = "Empresa"

        loc_oGrd.SetAll("DynamicForeColor", "RGB(0,0,0)", "Column")
        loc_oGrd.Refresh()

        *-- Muda para pagina de dados
        THIS.AlternarPagina(2)
        loc_oP2.cgp_4c_Acoes.Command3.Enabled = .F.
    ENDPROC

    *==========================================================================
    * GerarCNAB - Despacha para o metodo CNAB correto baseado no banco
    * pTipo: 'A' = gerar arquivo, 'V' = relatorio/preview, 'I' = boleto
    *==========================================================================
    PROCEDURE GerarCNAB(par_cTipo)
        LOCAL loc_cCdConta, loc_cCdEmp, loc_dDati, loc_dDatf, loc_cCdEmpConv
        LOCAL loc_cGrupos, loc_cGruposConta, loc_cSQL, loc_cBanco
        LOCAL loc_oP1, loc_oP2, loc_oBO

        SET SAFETY OFF

        loc_oP1      = THIS.pgf_4c_Principal.pgfiltro
        loc_oP2      = THIS.pgf_4c_Principal.pgdados
        loc_oBO      = THIS.this_oBusinessObject
        loc_cCdConta = ALLTRIM(loc_oP1.txt_4c_CdConta.Value)
        loc_cCdEmp   = ALLTRIM(loc_oP1.txt_4c_CdEmpresa.Value)
        loc_dDati    = loc_oP1.txt_4c_Datai.Value
        loc_dDatf    = loc_oP1.txt_4c_Dataf.Value
        loc_cCdEmpConv = ALLTRIM(loc_oP1.txt_4c_CdEmpConv.Value)

        *-- Carrega dados da empresa do convenio
        IF !loc_oBO.BuscarEmpresa(loc_cCdEmpConv)
            MsgAviso("N" + CHR(227) + "o Foi Encontrada a Raz" + CHR(227) + "o Social e/ou o CNPJ da Empresa [" + ;
                     loc_cCdEmpConv + "]" + CHR(13) + ;
                     "Complete os Dados no Cadastro de Empresas e Tente Novamente!!!")
            RETURN
        ENDIF

        IF RECCOUNT("cursor_4c_Empresa") = 0 OR ;
           EMPTY(ALLTRIM(NVL(cursor_4c_Empresa.RazSocs, ""))) OR ;
           EMPTY(ALLTRIM(NVL(cursor_4c_Empresa.Cgcs, "")))
            MsgAviso("N" + CHR(227) + "o Foi Encontrada a Raz" + CHR(227) + "o Social e/ou o CNPJ da Empresa [" + ;
                     loc_cCdEmpConv + "]" + CHR(13) + ;
                     "Complete os Dados no Cadastro de Empresas e Tente Novamente!!!")
            RETURN
        ENDIF

        IF par_cTipo = "A"
            *-- Verifica se ha registros marcados
            LOCAL loc_nCont
            loc_nCont = 0
            IF USED("cursor_4c_Filtro")
                SELECT cursor_4c_Filtro
                SCAN
                    IF cursor_4c_Filtro.marca
                        loc_nCont = loc_nCont + 1
                    ENDIF
                ENDSCAN
            ENDIF
            IF loc_nCont = 0
                MsgAviso("Nenhum registro foi selecionado")
                RETURN
            ENDIF

            *-- Busca grupos da conta bancaria para montar GruContas
            loc_cGruposConta = loc_oBO.BuscarGruposContaCli(loc_cCdConta)
            IF EMPTY(loc_cGruposConta)
                MsgAviso("N" + CHR(227) + "o foi poss" + CHR(237) + "vel determinar o grupo da conta banc" + CHR(225) + "ria.")
                RETURN
            ENDIF

            *-- Busca dados do convenio bancario
            IF !loc_oBO.BuscarConvenio(loc_cGruposConta + loc_cCdConta)
                MsgAviso("N" + CHR(227) + "o Foi Encontrado o N" + CHR(250) + "mero da Ag" + CHR(234) + "ncia e/ou o C" + CHR(243) + "digo do Conv" + CHR(234) + "nio Para" + CHR(13) + ;
                         "o Banco [" + loc_cCdConta + "]!!! Complete os Dados no Cadastro de Contas!!!")
                RETURN
            ENDIF

            IF RECCOUNT("cursor_4c_Convenio") = 0
                MsgAviso("N" + CHR(227) + "o Foi Encontrado o N" + CHR(250) + "mero da Ag" + CHR(234) + "ncia e/ou o C" + CHR(243) + "digo do Conv" + CHR(234) + "nio Para" + CHR(13) + ;
                         "o Banco [" + loc_cCdConta + "]!!! Complete os Dados no Cadastro de Contas!!!")
                RETURN
            ENDIF

            SELECT cursor_4c_Convenio
            GO TOP

            *-- Define dias protesto do convenio
            loc_oP2.spn_4c_Dias.Value = IIF(EMPTY(NVL(cursor_4c_Convenio.DiasProts, 0)), 5, cursor_4c_Convenio.DiasProts)

            *-- Despacha para o metodo CNAB correto
            loc_cBanco = ALLTRIM(cursor_4c_Convenio.nbancos)
            DO CASE
                CASE loc_cBanco = "001"
                    THIS.CnabBrasil()
                CASE loc_cBanco = "341"
                    THIS.CnabItau240()
                CASE loc_cBanco = "237"
                    THIS.CnabBrades240()
                CASE INLIST(loc_cBanco, "033", "353")
                    THIS.CnabSantander240()
                OTHERWISE
                    MsgAviso("Banco " + loc_cBanco + " n" + CHR(227) + "o suportado para gera" + CHR(231) + CHR(227) + "o CNAB.")
            ENDCASE

        ELSE
            *-- Modo relatorio ou boleto: busca convenio para cabecalho
            loc_cGruposConta = loc_oBO.BuscarGruposContaCli(loc_cCdConta)
            IF !EMPTY(loc_cGruposConta)
                loc_oBO.BuscarConvenio(loc_cGruposConta + loc_cCdConta)
            ENDIF

            *-- Cursor cabecalho do relatorio
            LOCAL loc_cProt, loc_cDataRel
            loc_cProt    = PADL(ALLTRIM(STR(IIF(loc_oP2.spn_4c_Dias.Value = 0, 5, loc_oP2.spn_4c_Dias.Value))), 2, "0")
            loc_cDataRel = "Per" + CHR(237) + "odo: " + DTOC(loc_dDati) + " at" + CHR(233) + " " + DTOC(loc_dDatf) + ;
                           " - Protesto em " + loc_cProt + " dias"

            IF USED("cursor_4c_CabRel")
                USE IN cursor_4c_CabRel
            ENDIF
            CREATE CURSOR cursor_4c_CabRel (titulo C(100), periodo C(100), empresa C(100))
            INSERT INTO cursor_4c_CabRel (titulo, periodo, empresa) ;
                VALUES ("Dados para gera" + CHR(231) + CHR(227) + "o do CNAB", ;
                        loc_cDataRel, ;
                        loc_cCdEmp + " - " + ALLTRIM(NVL(cursor_4c_Empresa.RazSocs, "")))

            IF USED("cursor_4c_Filtro2Rel")
                USE IN cursor_4c_Filtro2Rel
            ENDIF
            SELECT *, SPACE(11) AS SeqNums FROM cursor_4c_Filtro WHERE marca INTO CURSOR cursor_4c_Filtro2Rel

            IF par_cTipo = "V"
                REPORT FORM sigrecnb PREVIEW
            ENDIF
        ENDIF
    ENDPROC

    *==========================================================================
    * BuscarBoleto - Classifica registros de cursor_4c_Filtro por tipo pagamento
    * par_cBco: codigo banco FEBRABAN (ex: '341', '237', '033')
    * Cria cursores: crFiltro2 (cc), crFiltroTr (transfer/pix), crFiltro3 (boleto),
    *                crFiltro4 (doc), crFiltro5 (boleto outro banco),
    *                crFiltro6 (tributos), crFiltro20 (todos processados)
    *==========================================================================
    PROCEDURE BuscarBoleto(par_cBco)
        LOCAL loc_cSQL, loc_cFkChaves, loc_cBarras

        *-- Busca contas do banco e de outros bancos
        IF !THIS.this_oBusinessObject.BuscarContasBanco(par_cBco)
            MsgAviso("Falha ao carregar contas do banco " + par_cBco + ".")
            RETURN
        ENDIF

        *-- Preenche campo barras em crFiltro2 a partir de SigMvCcb
        SELECT crFiltro2
        GO TOP
        SCAN
            loc_cFkChaves = ALLTRIM(crFiltro2.Emps) + STR(crFiltro2.Nopers, 10) + ALLTRIM(crFiltro2.Opers)
            loc_cBarras   = THIS.this_oBusinessObject.BuscarBarrasCcb(loc_cFkChaves)
            IF !EMPTY(loc_cBarras)
                REPLACE barras WITH loc_cBarras IN crFiltro2
            ENDIF
            SELECT crFiltro2
        ENDSCAN

        *-- Salva snapshot de tudo (para update titbans depois)
        IF USED("crFiltro20")
            USE IN crFiltro20
        ENDIF
        SELECT * FROM crFiltro2 INTO CURSOR crFiltro20

        *-- Separa boletos (com barras) de transferencias (sem barras)
        IF USED("crFiltro3")
            USE IN crFiltro3
        ENDIF
        IF USED("crFiltroTr")
            USE IN crFiltroTr
        ENDIF
        SELECT * FROM crFiltro2 WHERE ALLTRIM(barras) != SPACE(50) AND !EMPTY(ALLTRIM(barras)) INTO CURSOR crFiltro3 READWRITE
        SELECT * FROM crFiltro2 WHERE ALLTRIM(barras) = SPACE(50) OR EMPTY(ALLTRIM(barras)) INTO CURSOR crFiltroTr READWRITE

        *-- Classifica transferencias: DOC (outro banco) vs credito em conta (mesmo banco)
        IF USED("crFiltro4")
            USE IN crFiltro4
        ENDIF
        IF USED("crFiltro2")
            USE IN crFiltro2
        ENDIF
        SELECT * FROM crFiltroTr WHERE Grupos + contas IN (SELECT GruContas FROM cursor_4c_BancoDif) INTO CURSOR crFiltro4 READWRITE
        SELECT * FROM crFiltroTr WHERE Grupos + contas IN (SELECT GruContas FROM cursor_4c_BancoIgual) INTO CURSOR crFiltro2 READWRITE

        *-- Classifica boletos: tributos (len=48), mesmo banco, outro banco
        IF USED("crFiltro6")
            USE IN crFiltro6
        ENDIF
        IF USED("crFiltro5")
            USE IN crFiltro5
        ENDIF
        SELECT * FROM crFiltro3 WHERE LEN(ALLTRIM(barras)) = 48 INTO CURSOR crFiltro6 READWRITE
        SELECT * FROM crFiltro3 WHERE LEN(ALLTRIM(barras)) != 48 AND SUBSTR(barras, 1, 3) != par_cBco INTO CURSOR crFiltro5 READWRITE
        SELECT * FROM crFiltro3 WHERE LEN(ALLTRIM(barras)) != 48 AND SUBSTR(barras, 1, 3) = par_cBco INTO CURSOR crFiltro3 READWRITE

        *-- Identifica PIX (tipochv preenchido em crFiltroTr)
        SELECT * FROM crFiltroTr WHERE !EMPTY(ALLTRIM(tipochv)) INTO CURSOR crFiltroTr READWRITE

        *-- Se ha PIX, esvazia os outros cursores (processa apenas PIX)
        LOCAL loc_cMsg
        loc_cMsg = ""
        IF RECCOUNT("crFiltroTr") > 0
            SELECT * FROM crFiltro2  WHERE 0 = 1 INTO CURSOR crFiltro2  READWRITE
            SELECT * FROM crFiltro3  WHERE 0 = 1 INTO CURSOR crFiltro3  READWRITE
            SELECT * FROM crFiltro4  WHERE 0 = 1 INTO CURSOR crFiltro4  READWRITE
            SELECT * FROM crFiltro5  WHERE 0 = 1 INTO CURSOR crFiltro5  READWRITE
            SELECT * FROM crFiltro6  WHERE 0 = 1 INTO CURSOR crFiltro6  READWRITE
            loc_cMsg = "Ser" + CHR(225) + " gerado remessa apenas de PIX." + CHR(13) + CHR(10)
        ENDIF

        *-- Titulos sem dados bancarios (para aviso)
        LOCAL loc_cSemDados
        loc_cSemDados = ""
        IF USED("crErro")
            USE IN crErro
        ENDIF
        SELECT * FROM crFiltro20 ;
            WHERE Grupos + contas NOT IN (SELECT Grupos + contas FROM crFiltro2) ;
            AND   Grupos + contas NOT IN (SELECT Grupos + contas FROM crFiltro3) ;
            AND   Grupos + contas NOT IN (SELECT Grupos + contas FROM crFiltro4) ;
            AND   Grupos + contas NOT IN (SELECT Grupos + contas FROM crFiltro5) ;
            AND   Grupos + contas NOT IN (SELECT Grupos + contas FROM crFiltroTr) ;
            AND   Grupos + contas NOT IN (SELECT Grupos + contas FROM crFiltro6) ;
            INTO CURSOR crErro

        SELECT crErro
        GO TOP
        SCAN
            loc_cMsg = loc_cMsg + ALLTRIM(crErro.contas) + "-" + ALLTRIM(crErro.rclis) + CHR(13) + CHR(10)
        ENDSCAN

        IF !EMPTY(loc_cMsg)
            MsgAviso(loc_cMsg + CHR(13) + "N" + CHR(227) + "o entraram no CNAB")
        ENDIF

        *-- Atualiza crFiltro20 removendo os que nao entraram
        SELECT * FROM crFiltro20 WHERE Grupos + contas NOT IN (SELECT Grupos + contas FROM crErro) INTO CURSOR crFiltro20 READWRITE
    ENDPROC

    *==========================================================================
    * CnabItau240 - Gera arquivo CNAB 240 posicoes para Itau (banco 341)
    *==========================================================================
    PROCEDURE CnabItau240()
        LOCAL loc_oBO, loc_oP2
        LOCAL lcCnv, lcAgeE, lcDigAE, lcCtaCE, lcDigCE, lcCtaE
        LOCAL lcRaz, lcCgc, lctpcgc, lcrazbco
        LOCAL lcDat, lcHora, lcprot, lcEnv, lcArq, lcTpCtArq, lcTpCtBol
        LOCAL lcEndesE, lcNumsE, lcComplE, lcCidaE, lcCepE, lcCep1E, lcEstaE, lcOco
        LOCAL lnLot, lcLot, lnSeq, lcSeq, lcFin, lnQlote, lcQlote
        LOCAL lcstrg, lok, lnPix
        LOCAL loc_cSQL

        SET SAFETY OFF
        loc_oBO = THIS.this_oBusinessObject
        loc_oP2 = THIS.pgf_4c_Principal.pgdados

        *-- Cria cursor de trabalho a partir dos registros marcados
        IF USED("crFiltro2")
            USE IN crFiltro2
        ENDIF
        SELECT *, SPACE(10) AS nossoNum, SPACE(50) AS barras FROM cursor_4c_Filtro WHERE marca INTO CURSOR crFiltro2 READWRITE

        *-- Classifica registros por tipo de pagamento
        THIS.BuscarBoleto("341")

        *-- Variaveis do convenio e empresa (de cursor_4c_Convenio e cursor_4c_Empresa)
        SELECT cursor_4c_Convenio
        GO TOP

        lcCnv  = PADR(ALLTRIM(cursor_4c_Convenio.Convenios), 20, " ")
        lcAgeE = PADL(ALLTRIM(cursor_4c_Convenio.NAgencias), 5, "0")
        lcDigAE= ALLTRIM(cursor_4c_Convenio.DigiAgen)
        lcCtaCE= PADL(ALLTRIM(CHRTRAN(cursor_4c_Convenio.contas, ".-", "")), 13, "0")
        lcDigCE= SUBSTR(lcCtaCE, 13, 1)
        lcCtaE = SUBSTR(lcCtaCE, 1, 12)

        SELECT cursor_4c_Empresa
        GO TOP

        lcRaz    = PADR(ALLTRIM(cursor_4c_Empresa.RazSocs), 30)
        lcCgc    = PADL(ALLTRIM(STRTRAN(STRTRAN(STRTRAN(cursor_4c_Empresa.Cgcs, "/", ""), ".", ""), "-", "")), 14, "0")
        lctpcgc  = IIF(LEN(ALLTRIM(CHRTRAN(cursor_4c_Empresa.Cgcs, "/.-", ""))) = 11, "1", "2")
        lcrazbco = PADR(ALLTRIM(cursor_4c_Convenio.bancos), 30)

        lcDat     = SUBSTR(DTOC(DATE()), 1, 2) + SUBSTR(DTOC(DATE()), 4, 2) + SUBSTR(DTOC(DATE()), 7, 4)
        lcHora    = TTOC(DATETIME())
        lcHora    = SUBSTR(lcHora, 12, 2) + SUBSTR(lcHora, 15, 2) + SUBSTR(lcHora, 18, 2)
        lcprot    = IIF(loc_oP2.spn_4c_Dias.Value = 0, 5, loc_oP2.spn_4c_Dias.Value)
        lcprot    = PADL(ALLTRIM(STR(lcprot)), 2, "0")
        lcEnv     = PADL(fGerUniqueKey("ITAUENV"), 7, "0")
        lcArq     = ALLTRIM(cursor_4c_Convenio.Drive) + IIF(EMPTY(ALLTRIM(cursor_4c_Convenio.Drive)), "", "\")
        lcArq     = STRTRAN(lcArq + ALLTRIM(cursor_4c_Convenio.ArqCnabs) + lcEnv + ".REM", "\\", "\")
        lcTpCtArq = ALLTRIM(cursor_4c_Convenio.TpCtArqs)
        lcTpCtBol = ALLTRIM(cursor_4c_Convenio.TpCtBols)

        lcEndesE = PADR(ALLTRIM(cursor_4c_Empresa.endes), 30)
        lcNumsE  = PADL(ALLTRIM(cursor_4c_Empresa.numeros), 5, "0")
        lcComplE = PADR(ALLTRIM(cursor_4c_Empresa.compls), 15)
        lcCidaE  = PADR(ALLTRIM(cursor_4c_Empresa.cidas), 20)
        lcCepE   = SUBSTR(cursor_4c_Empresa.ceps, 1, 5)
        lcCep1E  = SUBSTR(cursor_4c_Empresa.ceps, 7, 3)
        lcEstaE  = ALLTRIM(cursor_4c_Empresa.estas)
        lcOco    = SPACE(10)

        THIS.this_nCnabLot = 0
        lnLot = 0
        lcLot = TRANSFORM(lnLot, "@L 9999")
        lnSeq = 1
        lcSeq = TRANSFORM(lnSeq, "@L 999999")

        *-- Cabecalho do arquivo
        LOCAL lcH001a003, lcH004a007, lcH008a008, lcH009a014, lcH015a017, lcH018a018
        LOCAL lcH019a032, lcH033a052, lcH053a057, lcH058a058, lcH059a070, lcH071a071
        LOCAL lcH072a072, lcH073a102, lcH103a132, lcH133a142, lcH143a143, lcH144a151
        LOCAL lcH152a157, lcH158a166, lcH167a171, lcH172a240

        lcH001a003 = "341"
        lcH004a007 = lcLot
        lcH008a008 = "0"
        lcH009a014 = SPACE(6)
        lcH015a017 = "080"
        lcH018a018 = lctpcgc
        lcH019a032 = lcCgc
        lcH033a052 = SPACE(20)
        lcH053a057 = lcAgeE
        lcH058a058 = SPACE(1)
        lcH059a070 = lcCtaE
        lcH071a071 = SPACE(1)
        lcH072a072 = lcDigCE
        lcH073a102 = lcRaz
        lcH103a132 = lcrazbco
        lcH133a142 = SPACE(10)
        lcH143a143 = "1"
        lcH144a151 = lcDat
        lcH152a157 = lcHora
        lcH158a166 = "000000000"
        lcH167a171 = "00000"
        lcH172a240 = SPACE(69)

        lcstrg = lcH001a003+lcH004a007+lcH008a008+lcH009a014+lcH015a017+lcH018a018+ ;
                 lcH019a032+lcH033a052+lcH053a057+lcH058a058+lcH059a070+lcH071a071+ ;
                 lcH072a072+lcH073a102+lcH103a132+lcH133a142+lcH143a143+lcH144a151+ ;
                 lcH152a157+lcH158a166+lcH167a171+lcH172a240+CHR(13)+CHR(10)

        lcstrg = fLimpaTexto(lcstrg)
        STRTOFILE(lcstrg, lcArq, 0)

        *-- PIX (crFiltroTr) - processa primeiro se existir
        IF RECCOUNT("crFiltroTr") > 0
            THIS.CnabItau240Lote("341", "45", ;
                lcLot, lnLot, lnSeq, lcSeq, lctpcgc, lcCgc, lcAgeE, lcCtaE, lcDigCE, ;
                lcRaz, lcEndesE, lcNumsE, lcComplE, lcCidaE, lcCepE, lcCep1E, lcEstaE, lcOco, ;
                lcArq, lcprot)
        ENDIF

        *-- Credito em conta (crFiltro2 - mesmo banco, sem boleto, sem PIX)
        IF RECCOUNT("crFiltro2") > 0 AND RECCOUNT("crFiltroTr") = 0
            THIS.CnabItau240LoteCC(lcLot, lnLot, lnSeq, lcSeq, lctpcgc, lcCgc, lcAgeE, lcCtaE, lcDigCE, ;
                lcRaz, lcEndesE, lcNumsE, lcComplE, lcCidaE, lcCepE, lcCep1E, lcEstaE, lcOco, ;
                lcArq, lcprot, "01", "crFiltro2", "341")
        ENDIF

        *-- DOC (crFiltro4 - outro banco, sem boleto)
        IF RECCOUNT("crFiltro4") > 0 AND RECCOUNT("crFiltroTr") = 0
            THIS.CnabItau240LoteCC(lcLot, lnLot, lnSeq, lcSeq, lctpcgc, lcCgc, lcAgeE, lcCtaE, lcDigCE, ;
                lcRaz, lcEndesE, lcNumsE, lcComplE, lcCidaE, lcCepE, lcCep1E, lcEstaE, lcOco, ;
                lcArq, lcprot, "03", "crFiltro4", "341")
        ENDIF

        *-- Boleto mesmo banco (crFiltro3)
        IF RECCOUNT("crFiltro3") > 0 AND RECCOUNT("crFiltroTr") = 0
            THIS.CnabItau240LoteBoleto(lcLot, lnLot, lnSeq, lcSeq, lctpcgc, lcCgc, lcAgeE, lcCtaE, lcDigCE, ;
                lcRaz, lcEndesE, lcNumsE, lcComplE, lcCidaE, lcCepE, lcCep1E, lcEstaE, lcOco, ;
                lcArq, lcprot, "30", "crFiltro3", "341")
        ENDIF

        *-- Boleto outro banco (crFiltro5)
        IF RECCOUNT("crFiltro5") > 0 AND RECCOUNT("crFiltroTr") = 0
            SELECT * FROM crFiltro5 INTO CURSOR crFiltro3 READWRITE
            THIS.CnabItau240LoteBoleto(lcLot, lnLot, lnSeq, lcSeq, lctpcgc, lcCgc, lcAgeE, lcCtaE, lcDigCE, ;
                lcRaz, lcEndesE, lcNumsE, lcComplE, lcCidaE, lcCepE, lcCep1E, lcEstaE, lcOco, ;
                lcArq, lcprot, "31", "crFiltro3", "341")
        ENDIF

        *-- Trailer do arquivo
        IF FILE(lcArq)
            LOCAL lcT001a003, lcT004a007, lcT008a008, lcT009a017, lcT018a023, lcT024a029, lcT030a035, lcT036a240
            lcT001a003 = "341"
            lcT004a007 = "9999"
            lcT008a008 = "9"
            lcT009a017 = SPACE(9)
            lcT018a023 = "00" + PADL(ALLTRIM(STR(THIS.this_nCnabLot)), 4, "0")
            lcT024a029 = PADL(ALLTRIM(STR(INT(FSIZE(lcArq)/242)+1)), 6, "0")
            lcT030a035 = "000000"
            lcT036a240 = SPACE(205)
            lcstrg = lcT001a003+lcT004a007+lcT008a008+lcT009a017+lcT018a023+lcT024a029+lcT030a035+lcT036a240+CHR(13)+CHR(10)
            lcstrg = fLimpaTexto(lcstrg)
            STRTOFILE(lcstrg, lcArq, 1)

            *-- Atualiza titbans em SigMvCcr
            lok = .T.
            IF lok
                SELECT crFiltro20
                SCAN
                    LOCAL loc_cTitBans, loc_cTitulos, loc_lAtua
                    loc_cTitBans = loc_oBO.BuscarTituloBanco(crFiltro20.nopers)
                    loc_cTitulos = ALLTRIM(NVL(crFiltro20.titulos, ""))
                    loc_lAtua = .T.
                    IF !EMPTY(loc_cTitBans)
                        loc_lAtua = MsgConfirma('T' + CHR(237) + 'tulo "' + loc_cTitulos + '" j' + CHR(225) + ' possui T' + CHR(237) + 'tulo do Banco preenchido. Sobrescrever?')
                    ENDIF
                    IF loc_lAtua
                        loc_oBO.AtualizarTituloBanco(crFiltro20.nopers, "TIT ITAU")
                    ENDIF
                    SELECT crFiltro20
                ENDSCAN
            ENDIF

            MsgAviso("Arquivo '" + lcArq + "' gerado com sucesso.")
            THIS.pgf_4c_Principal.pgdados.cgp_4c_Acoes.Command3.Enabled = .F.
        ENDIF
    ENDPROC

    *==========================================================================
    * CnabItau240LoteCC - Gera lote de credito em conta / DOC para Itau 240
    *==========================================================================
    PROTECTED PROCEDURE CnabItau240LoteCC(lcLot, lnLot, lnSeq, lcSeq, lctpcgc, lcCgc, lcAgeE, lcCtaE, lcDigCE, ;
        lcRaz, lcEndesE, lcNumsE, lcComplE, lcCidaE, lcCepE, lcCep1E, lcEstaE, lcOco, ;
        lcArq, lcprot, par_cFormaPgto, par_cCursor, par_cBanco)

        LOCAL loc_oBO, lcFin, lnQlote, lcQlote, lnSeql, lcSeql, lcSemCC
        LOCAL lnValtot, lnMoetot, lcstrg, loc_cSQL

        loc_oBO = THIS.this_oBusinessObject

        THIS.this_nCnabLot = THIS.this_nCnabLot + 1
        lnLot = THIS.this_nCnabLot
        lcLot = TRANSFORM(lnLot, "@L 9999")
        lcFin = PADR("SISPAG", 30)
        lnQlote = 1

        LOCAL lcL001a003, lcL004a007, lcL008a008, lcL009a009, lcL010a011, lcL012a013
        LOCAL lcL014a016, lcL017a017, lcL018a018, lcL019a032, lcL033a036, lcL037a052
        LOCAL lcL053a057, lcL058a058, lcL059a070, lcL071a071, lcL072a072, lcL073a102
        LOCAL lcL103a132, lcL133a142, lcL143a172, lcL173a177, lcL178a192, lcL193a212
        LOCAL lcL213a217, lcL218a220, lcL221a222, lcL223a230, lcL231a240

        lcL001a003 = par_cBanco
        lcL004a007 = lcLot
        lcL008a008 = "1"
        lcL009a009 = "C"
        lcL010a011 = "20"
        lcL012a013 = par_cFormaPgto
        lcL014a016 = "040"
        lcL017a017 = SPACE(1)
        lcL018a018 = lctpcgc
        lcL019a032 = lcCgc
        lcL033a036 = "HP13"
        lcL037a052 = SPACE(16)
        lcL053a057 = lcAgeE
        lcL058a058 = SPACE(1)
        lcL059a070 = lcCtaE
        lcL071a071 = SPACE(1)
        lcL072a072 = lcDigCE
        lcL073a102 = lcRaz
        lcL103a132 = lcFin
        lcL133a142 = SPACE(10)
        lcL143a172 = lcEndesE
        lcL173a177 = lcNumsE
        lcL178a192 = lcComplE
        lcL193a212 = lcCidaE
        lcL213a217 = lcCepE
        lcL218a220 = lcCep1E
        lcL221a222 = lcEstaE
        lcL223a230 = SPACE(8)
        lcL231a240 = SPACE(10)

        lcstrg = lcL001a003+lcL004a007+lcL008a008+lcL009a009+lcL010a011+lcL012a013+ ;
                 lcL014a016+lcL017a017+lcL018a018+lcL019a032+lcL033a036+lcL037a052+ ;
                 lcL053a057+lcL058a058+lcL059a070+lcL071a071+lcL072a072+lcL073a102+ ;
                 lcL103a132+lcL133a142+lcL143a172+lcL173a177+lcL178a192+lcL193a212+ ;
                 lcL213a217+lcL218a220+lcL221a222+lcL223a230+lcL231a240+CHR(13)+CHR(10)
        lcstrg = fLimpaTexto(lcstrg)
        STRTOFILE(lcstrg, lcArq, 1)

        lnSeql  = 0
        lcSemCC = ""
        lnValtot = 0
        lnMoetot = 0

        SELECT (par_cCursor)
        SCAN
            *-- Busca conta do favorecido
            loc_cSQL = "SELECT * FROM SigCdCeb WHERE GruContas = " + ;
                       EscaparSQL(Grupos + contas) + ;
                       " AND NAgencias != '' AND contas != '' AND nbancos != 0 ORDER BY NAgencias"
            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Conta") < 1
                MsgAviso("Falha na conex" + CHR(227) + "o ao buscar conta do favorecido.")
                LOOP
            ENDIF
            GO TOP IN cursor_4c_Conta
            SELECT (par_cCursor)
            IF RECCOUNT("cursor_4c_Conta") = 0
                lcSemCC = lcSemCC + contas + " "
                LOOP
            ENDIF

            LOCAL lcnopers, lcvenc, lccgccli, lctpcgcCli, lcnome
            LOCAL lcValpag, lcValmoe, lcende, lcbair, lcCep, lcCida, lcEsta
            LOCAL lcnumero, lcCompl, lcCep1, lcCep2
            LOCAL lcBco, lcAge, lcDigA, lcCtaC, lcDigC, lcDigAC, lcCta, lcAgCta, lcTpcta
            LOCAL lcOutCgc, lcnumtit, lcChave, lcNossoNum, lcTptrans
            LOCAL lcA001a003, lcA004a007, lcA008a008, lcA009a013, lcA014a014
            LOCAL lcA015a017, lcA018a020, lcA021a023, lcA024a043, lcA044a073
            LOCAL lcA074a093, lcA094a101, lcA102a104, lcA105a112, lcA113a114
            LOCAL lcA115a119, lcA120a134, lcA135a149, lcA150a154, lcA155a162
            LOCAL lcA163a177, lcA178a195, lcA196a197, lcA198a203, lcA204a217
            LOCAL lcA218a219, lcA220a224, lcA225a229, lcA230a230, lcA231a240

            lcnopers   = TRANSFORM(nopers, "@L 9999999999")
            lcvenc     = SUBSTR(DTOC(vencs), 1, 2) + SUBSTR(DTOC(vencs), 4, 2) + SUBSTR(DTOC(vencs), 7, 4)
            lccgccli   = PADL(ALLTRIM(CHRTRAN(cpfs, "/.-,", "")), 14, "0")
            lctpcgcCli = IIF(LEN(ALLTRIM(CHRTRAN(cpfs, "/.-", ""))) = 11, "1", "2")
            lcnome     = PADR(ALLTRIM(IIF(EMPTY(Razaos), rclis, Razaos)), 30)
            lcValpag   = TRANSFORM(valors * 100, "@L 999999999999999")
            lcValmoe   = TRANSFORM(valors * 100000, "@L 999999999999999")
            lnValtot   = lnValtot + valors
            lnMoetot   = lnMoetot + valors
            lcTptrans  = "00"
            lcende  = PADR(ALLTRIM(endes), 30)
            lcbair  = PADR(ALLTRIM(bairs), 15)
            lcCep   = PADL(ALLTRIM(CHRTRAN(ceps, ".-", "")), 8, "0")
            lcCida  = PADR(ALLTRIM(cidas), 20)
            lcEsta  = PADR(estas, 2)
            lcnumero = PADL(ALLTRIM(nums), 5, "0")
            lcCompl = PADR(ALLTRIM(compls), 15)
            lcCep1  = SUBSTR(lcCep, 1, 5)
            lcCep2  = SUBSTR(lcCep, 6, 3)

            SELECT cursor_4c_Conta
            GO TOP
            lcBco  = PADL(ALLTRIM(cursor_4c_Conta.nbancos), 3, "0")
            lcAge  = PADL(ALLTRIM(cursor_4c_Conta.NAgencias), 5, "0")
            lcDigA = ALLTRIM(cursor_4c_Conta.DigiAgen)
            lcCtaC = PADL(ALLTRIM(CHRTRAN(cursor_4c_Conta.contas, ".-", "")), 13, "0")
            lcDigC = SUBSTR(lcCtaC, 13, 1)
            lcDigAC = " "
            lcCta  = SUBSTR(lcCtaC, 1, 12)
            lcAgCta = lcAge + " " + lcCta + " " + lcDigC
            lcTpcta = IIF(cursor_4c_Conta.tpCtas = "02", "02", "01")
            lcOutCgc = ALLTRIM(CHRTRAN(cursor_4c_Conta.Convenios, "/.-,", ""))
            lccgccli = IIF(LEN(lcOutCgc) != 11 AND LEN(lcOutCgc) != 14, lccgccli, PADL(lcOutCgc, 14, "0"))

            SELECT (par_cCursor)
            lcnumtit = PADL(ALLTRIM(STRTRAN(titulos, "/", "")), 15, "0")
            lcChave  = PADR(ALLTRIM(titulos), 10) + lcnopers

            lcNossoNum = ALLTRIM(STR(fGerUniqueKey("BRNOSSONUM")))
            REPLACE nossoNum WITH PADL(lcNossoNum, 10, "0") IN (par_cCursor)
            lcNossoNum = PADR(lcNossoNum, 20)

            lnSeql = lnSeql + 1
            lcSeql = TRANSFORM(lnSeql, "@L 99999")
            lnQlote = lnQlote + 1
            lnSeq = lnSeq + 1

            lcA001a003 = par_cBanco
            lcA004a007 = lcLot
            lcA008a008 = "3"
            lcA009a013 = lcSeql
            lcA014a014 = "A"
            lcA015a017 = "000"
            lcA018a020 = "000"
            lcA021a023 = lcBco
            lcA024a043 = lcAgCta
            lcA044a073 = lcnome
            lcA074a093 = lcChave
            lcA094a101 = lcvenc
            lcA102a104 = "REA"
            lcA105a112 = "00000000"
            lcA113a114 = lcTptrans
            lcA115a119 = "00000"
            lcA120a134 = lcValpag
            lcA135a149 = SPACE(15)
            lcA150a154 = SPACE(5)
            lcA155a162 = "00000000"
            lcA163a177 = "000000000000000"
            lcA178a195 = SPACE(18)
            lcA196a197 = SPACE(2)
            lcA198a203 = "000000"
            lcA204a217 = lccgccli
            lcA218a219 = "01"
            lcA220a224 = "00010"
            lcA225a229 = SPACE(5)
            lcA230a230 = "0"
            lcA231a240 = SPACE(10)

            lcstrg = lcA001a003+lcA004a007+lcA008a008+lcA009a013+lcA014a014+ ;
                     lcA015a017+lcA018a020+lcA021a023+lcA024a043+lcA044a073+ ;
                     lcA074a093+lcA094a101+lcA102a104+lcA105a112+lcA113a114+ ;
                     lcA115a119+lcA120a134+lcA135a149+lcA150a154+lcA155a162+ ;
                     lcA163a177+lcA178a195+lcA196a197+lcA198a203+lcA204a217+ ;
                     lcA218a219+lcA220a224+lcA225a229+lcA230a230+lcA231a240+CHR(13)+CHR(10)

            lcstrg = fLimpaTexto(lcstrg)
            STRTOFILE(lcstrg, lcArq, 1)

            loc_oBO.RegistrarLinhaArquivo("C", nopers, lcstrg, titulos, lcChave)

            SELECT (par_cCursor)
        ENDSCAN

        *-- Trailer do lote
        lnSeq = lnSeq + 1
        lnSeql = lnSeql + 1
        lcSeql = TRANSFORM(lnSeql, "@L 999999")
        lnQlote = lnQlote + 1
        lcQlote = TRANSFORM(lnQlote, "@L 999999")
        LOCAL lcValtotStr, lcMoetotStr
        lcValtotStr = TRANSFORM(lnValtot * 100, "@L 999999999999999999")
        lcMoetotStr = TRANSFORM(lnMoetot * 100000, "@L 999999999999999999")

        LOCAL lcTL001a003, lcTL004a007, lcTL008a008, lcTL009a017, lcTL018a023
        LOCAL lcTL024a041, lcTL042a059, lcTL060a230, lcTL231a240
        lcTL001a003 = par_cBanco
        lcTL004a007 = lcLot
        lcTL008a008 = "5"
        lcTL009a017 = SPACE(9)
        lcTL018a023 = lcQlote
        lcTL024a041 = lcValtotStr
        lcTL042a059 = "000000000000000000"
        lcTL060a230 = SPACE(171)
        lcTL231a240 = SPACE(10)
        lcstrg = lcTL001a003+lcTL004a007+lcTL008a008+lcTL009a017+lcTL018a023+ ;
                 lcTL024a041+lcTL042a059+lcTL060a230+lcTL231a240+CHR(13)+CHR(10)
        lcstrg = fLimpaTexto(lcstrg)
        STRTOFILE(lcstrg, lcArq, 1)
    ENDPROC

    *==========================================================================
    * CnabItau240LoteBoleto - Gera lote de boletos para Itau 240
    *==========================================================================
    PROTECTED PROCEDURE CnabItau240LoteBoleto(lcLot, lnLot, lnSeq, lcSeq, lctpcgc, lcCgc, lcAgeE, lcCtaE, lcDigCE, ;
        lcRaz, lcEndesE, lcNumsE, lcComplE, lcCidaE, lcCepE, lcCep1E, lcEstaE, lcOco, ;
        lcArq, lcprot, par_cFormaPgto, par_cCursor, par_cBanco)

        LOCAL loc_oBO, lcFin, lnQlote, lcQlote, lnSeql, lcSeql, lnValtot, lnMoetot, lcstrg
        LOCAL loc_cSQL

        loc_oBO = THIS.this_oBusinessObject

        THIS.this_nCnabLot = THIS.this_nCnabLot + 1
        lnLot = THIS.this_nCnabLot
        lcLot = TRANSFORM(lnLot, "@L 9999")
        lnQlote = 1

        LOCAL lcL001a003, lcL004a007, lcL008a008, lcL009a009, lcL010a011, lcL012a013
        LOCAL lcL014a016, lcL017a017, lcL018a018, lcL019a032, lcL033a052
        LOCAL lcL053a057, lcL058a058, lcL059a070, lcL071a071, lcL072a072, lcL073a102
        LOCAL lcL103a132, lcL133a142, lcL143a172, lcL173a177, lcL178a192, lcL193a212
        LOCAL lcL213a217, lcL218a220, lcL221a222, lcL223a230, lcL231a240

        lcL001a003 = par_cBanco
        lcL004a007 = lcLot
        lcL008a008 = "1"
        lcL009a009 = "C"
        lcL010a011 = "20"
        lcL012a013 = par_cFormaPgto
        lcL014a016 = "030"
        lcL017a017 = SPACE(1)
        lcL018a018 = lctpcgc
        lcL019a032 = lcCgc
        lcL033a052 = SPACE(20)
        lcL053a057 = lcAgeE
        lcL058a058 = " "
        lcL059a070 = lcCtaE
        lcL071a071 = " "
        lcL072a072 = lcDigCE
        lcL073a102 = lcRaz
        lcL103a132 = SPACE(30)
        lcL133a142 = SPACE(10)
        lcL143a172 = lcEndesE
        lcL173a177 = lcNumsE
        lcL178a192 = lcComplE
        lcL193a212 = lcCidaE
        lcL213a217 = lcCepE
        lcL218a220 = lcCep1E
        lcL221a222 = lcEstaE
        lcL223a230 = SPACE(8)
        lcL231a240 = lcOco

        lcstrg = lcL001a003+lcL004a007+lcL008a008+lcL009a009+lcL010a011+lcL012a013+ ;
                 lcL014a016+lcL017a017+lcL018a018+lcL019a032+lcL033a052+ ;
                 lcL053a057+lcL058a058+lcL059a070+lcL071a071+lcL072a072+lcL073a102+ ;
                 lcL103a132+lcL133a142+lcL143a172+lcL173a177+lcL178a192+lcL193a212+ ;
                 lcL213a217+lcL218a220+lcL221a222+lcL223a230+lcL231a240+CHR(13)+CHR(10)
        lcstrg = fLimpaTexto(lcstrg)
        STRTOFILE(lcstrg, lcArq, 1)

        lnSeql  = 0
        lnValtot = 0
        lnMoetot = 0

        SELECT (par_cCursor)
        SCAN
            lnQlote = lnQlote + 1

            LOCAL lcnopers, lcvenc, lccgccli, lctpcgcCli, lcnome, lcValpag, lcValmoe
            LOCAL lcBarra, lcChave, lcNossoNum
            LOCAL lcJ001a003, lcJ004a007, lcJ008a008, lcJ009a013, lcJ014a014
            LOCAL lcJ015a017, lcJ018a061, lcJ062a091, lcJ092a099, lcJ100a114
            LOCAL lcJ115a129, lcJ130a144, lcJ145a152, lcJ153a167, lcJ168a182
            LOCAL lcJ183a202, lcJ203a215, lcJ216a230, lcJ231a240

            lcnopers   = TRANSFORM(nopers, "@L 9999999999")
            lcvenc     = SUBSTR(DTOC(vencs), 1, 2) + SUBSTR(DTOC(vencs), 4, 2) + SUBSTR(DTOC(vencs), 7, 4)
            lccgccli   = PADL(ALLTRIM(CHRTRAN(cpfs, "/.-,", "")), 14, "0")
            lctpcgcCli = IIF(LEN(ALLTRIM(CHRTRAN(cpfs, "/.-", ""))) = 11, "1", "2")
            lcnome     = PADR(ALLTRIM(IIF(EMPTY(Razaos), rclis, Razaos)), 30)
            lcValpag   = TRANSFORM(valors * 100, "@L 999999999999999")
            lnValtot   = lnValtot + valors
            lcBarra    = ALLTRIM(CHRTRAN(barras, "/.-", "")) + REPLICATE("0", 44)
            lcBarra    = SUBSTR(lcBarra, 1, 4) + SUBSTR(lcBarra, 33, 15) + SUBSTR(lcBarra, 5, 5) + SUBSTR(lcBarra, 11, 10) + SUBSTR(lcBarra, 22, 10)

            lcNossoNum = ALLTRIM(STR(fGerUniqueKey("BRNOSSONUM")))
            REPLACE nossoNum WITH PADL(lcNossoNum, 10, "0") IN (par_cCursor)
            lcNossoNum = PADR(lcNossoNum, 20)
            lcChave    = PADR(ALLTRIM(titulos), 10) + lcnopers

            lnSeql = lnSeql + 1
            lcSeql = TRANSFORM(lnSeql, "@L 99999")
            lnSeq = lnSeq + 1

            lcJ001a003 = par_cBanco
            lcJ004a007 = lcLot
            lcJ008a008 = "3"
            lcJ009a013 = lcSeql
            lcJ014a014 = "J"
            lcJ015a017 = "000"
            lcJ018a061 = lcBarra
            lcJ062a091 = lcnome
            lcJ092a099 = lcvenc
            lcJ100a114 = lcValpag
            lcJ115a129 = "000000000000000"
            lcJ130a144 = "000000000000000"
            lcJ145a152 = lcvenc
            lcJ153a167 = lcValpag
            lcJ168a182 = "000000000000000"
            lcJ183a202 = lcChave
            lcJ203a215 = SPACE(13)
            lcJ216a230 = SPACE(15)
            lcJ231a240 = SPACE(10)

            lcstrg = lcJ001a003+lcJ004a007+lcJ008a008+lcJ009a013+lcJ014a014+ ;
                     lcJ015a017+lcJ018a061+lcJ062a091+lcJ092a099+lcJ100a114+ ;
                     lcJ115a129+lcJ130a144+lcJ145a152+lcJ153a167+lcJ168a182+ ;
                     lcJ183a202+lcJ203a215+lcJ216a230+lcJ231a240+CHR(13)+CHR(10)
            lcstrg = fLimpaTexto(lcstrg)
            STRTOFILE(lcstrg, lcArq, 1)

            *-- Segmento J52
            lnQlote = lnQlote + 1
            lnSeql = lnSeql + 1
            lcSeql = TRANSFORM(lnSeql, "@L 99999")
            lnSeq = lnSeq + 1

            LOCAL lcJJ001a003, lcJJ004a007, lcJJ008a008, lcJJ009a013, lcJJ014a014
            LOCAL lcJJ015a017, lcJJ018a019, lcJJ020a020, lcJJ021a035, lcJJ036a075
            LOCAL lcJJ076a076, lcJJ077a091, lcJJ092a131, lcJJ132a132, lcJJ133a147
            LOCAL lcJJ148a187, lcJJ188a240

            lcJJ001a003 = par_cBanco
            lcJJ004a007 = lcLot
            lcJJ008a008 = "3"
            lcJJ009a013 = lcSeql
            lcJJ014a014 = "J"
            lcJJ015a017 = "000"
            lcJJ018a019 = "52"
            lcJJ020a020 = lctpcgc
            lcJJ021a035 = "0" + lcCgc
            lcJJ036a075 = lcRaz + SPACE(10)
            lcJJ076a076 = lctpcgcCli
            lcJJ077a091 = "0" + lccgccli
            lcJJ092a131 = lcnome + SPACE(10)
            lcJJ132a132 = "0"
            lcJJ133a147 = "000000000000000"
            lcJJ148a187 = SPACE(40)
            lcJJ188a240 = SPACE(53)

            lcstrg = lcJJ001a003+lcJJ004a007+lcJJ008a008+lcJJ009a013+lcJJ014a014+ ;
                     lcJJ015a017+lcJJ018a019+lcJJ020a020+lcJJ021a035+lcJJ036a075+ ;
                     lcJJ076a076+lcJJ077a091+lcJJ092a131+lcJJ132a132+lcJJ133a147+ ;
                     lcJJ148a187+lcJJ188a240+CHR(13)+CHR(10)
            lcstrg = fLimpaTexto(lcstrg)
            STRTOFILE(lcstrg, lcArq, 1)

            loc_oBO.RegistrarLinhaArquivo("C", nopers, lcstrg, titulos, lcChave)

            SELECT (par_cCursor)
        ENDSCAN

        *-- Trailer do lote
        lnSeq = lnSeq + 1
        lnSeql = lnSeql + 1
        lcSeql = TRANSFORM(lnSeql, "@L 999999")
        lnQlote = lnQlote + 1
        lcQlote = TRANSFORM(lnQlote, "@L 999999")
        LOCAL lcValtotStr, lcMoetotStr
        lcValtotStr = TRANSFORM(lnValtot * 100, "@L 999999999999999999")
        lcMoetotStr = "000000000000000000"

        LOCAL lcTL001a003, lcTL004a007, lcTL008a008, lcTL009a017, lcTL018a023
        LOCAL lcTL024a041, lcTL042a059, lcTL060a065, lcTL066a230, lcTL231a240
        lcTL001a003 = par_cBanco
        lcTL004a007 = lcLot
        lcTL008a008 = "5"
        lcTL009a017 = SPACE(9)
        lcTL018a023 = lcQlote
        lcTL024a041 = lcValtotStr
        lcTL042a059 = lcMoetotStr
        lcTL060a065 = "000000"
        lcTL066a230 = SPACE(165)
        lcTL231a240 = SPACE(10)
        lcstrg = lcTL001a003+lcTL004a007+lcTL008a008+lcTL009a017+lcTL018a023+ ;
                 lcTL024a041+lcTL042a059+lcTL060a065+lcTL066a230+lcTL231a240+CHR(13)+CHR(10)
        lcstrg = fLimpaTexto(lcstrg)
        STRTOFILE(lcstrg, lcArq, 1)
    ENDPROC

    *==========================================================================
    * CnabBrades240 - Gera arquivo CNAB 240 posicoes para Bradesco (banco 237)
    *==========================================================================
    PROCEDURE CnabBrades240()
        LOCAL loc_oBO, loc_oP2
        LOCAL lcCnv, lcAgeE, lcDigAE, lcCtaCE, lcDigCE, lcCtaE, lcDigACE
        LOCAL lcRaz, lcCgc, lctpcgc, lcrazbco
        LOCAL lcDat, lcprot, lcEnv, lcArq, lcTpCtArq, lcTpCtBol
        LOCAL lcEndesE, lcNumsE, lcComplE, lcCidaE, lcCepE, lcCep1E, lcEstaE, lcOco
        LOCAL lnLot, lcLot, lnSeq, lcSeq, lnQlote, lcQlote
        LOCAL lcstrg, lok

        SET SAFETY OFF
        loc_oBO = THIS.this_oBusinessObject
        loc_oP2 = THIS.pgf_4c_Principal.pgdados

        IF USED("crFiltro2")
            USE IN crFiltro2
        ENDIF
        SELECT *, SPACE(10) AS nossoNum, SPACE(50) AS barras FROM cursor_4c_Filtro WHERE marca INTO CURSOR crFiltro2 READWRITE
        THIS.BuscarBoleto("237")

        SELECT cursor_4c_Convenio
        GO TOP
        SELECT cursor_4c_Empresa
        GO TOP

        lcCnv  = PADR(ALLTRIM(cursor_4c_Convenio.Convenios), 20, " ")
        lcAgeE = PADL(ALLTRIM(cursor_4c_Convenio.NAgencias), 5, "0")
        lcDigAE= PADR(ALLTRIM(cursor_4c_Convenio.DigiAgen), 1)
        lcCtaCE= PADL(ALLTRIM(CHRTRAN(cursor_4c_Convenio.contas, ".-", "")), 13, "0")
        lcDigCE= SUBSTR(lcCtaCE, 13, 1)
        lcDigACE = " "
        lcCtaE = SUBSTR(lcCtaCE, 1, 12)
        lcRaz    = PADR(ALLTRIM(cursor_4c_Empresa.RazSocs), 30)
        lcCgc    = PADL(ALLTRIM(STRTRAN(STRTRAN(STRTRAN(cursor_4c_Empresa.Cgcs, "/", ""), ".", ""), "-", "")), 14, "0")
        lctpcgc  = IIF(LEN(ALLTRIM(CHRTRAN(cursor_4c_Empresa.Cgcs, "/.-", ""))) = 11, "1", "2")
        lcrazbco = PADR(ALLTRIM(cursor_4c_Convenio.bancos), 30)
        lcDat    = SUBSTR(DTOC(DATE()), 1, 2) + SUBSTR(DTOC(DATE()), 4, 2) + SUBSTR(DTOC(DATE()), 7, 4)
        lcprot   = IIF(loc_oP2.spn_4c_Dias.Value = 0, 5, loc_oP2.spn_4c_Dias.Value)
        lcprot   = PADL(ALLTRIM(STR(lcprot)), 2, "0")
        lcEnv    = PADL(fGerUniqueKey("BRADESCOENV"), 7, "0")
        lcArq    = ALLTRIM(cursor_4c_Convenio.Drive) + IIF(EMPTY(ALLTRIM(cursor_4c_Convenio.Drive)), "", "\")
        lcArq    = STRTRAN(lcArq + ALLTRIM(cursor_4c_Convenio.ArqCnabs) + lcEnv + ".REM", "\\", "\")
        lcTpCtArq = ALLTRIM(cursor_4c_Convenio.TpCtArqs)
        lcTpCtBol = ALLTRIM(cursor_4c_Convenio.TpCtBols)
        lcEndesE  = PADR(ALLTRIM(cursor_4c_Empresa.endes), 30)
        lcNumsE   = PADL(ALLTRIM(cursor_4c_Empresa.numeros), 5, "0")
        lcComplE  = PADR(ALLTRIM(cursor_4c_Empresa.compls), 15)
        lcCidaE   = PADR(ALLTRIM(cursor_4c_Empresa.cidas), 20)
        lcCepE    = SUBSTR(cursor_4c_Empresa.ceps, 1, 5)
        lcCep1E   = SUBSTR(cursor_4c_Empresa.ceps, 7, 3)
        lcEstaE   = ALLTRIM(cursor_4c_Empresa.estas)
        lcOco     = SPACE(10)

        THIS.this_nCnabLot = 0
        lnLot = 0
        lcLot = TRANSFORM(lnLot, "@L 9999")
        lnSeq = 1
        lcSeq = TRANSFORM(lnSeq, "@L 999999")

        *-- Cabecalho do arquivo
        LOCAL lcH001a003, lcH004a007, lcH008a008, lcH009a017, lcH018a018, lcH019a032
        LOCAL lcH033a052, lcH053a057, lcH058a058, lcH059a070, lcH071a071, lcH072a072
        LOCAL lcH073a102, lcH103a132, lcH133a142, lcH143a143, lcH144a151, lcH152a157
        LOCAL lcH158a163, lcH164a166, lcH167a171, lcH172a240

        lcH001a003 = "237"
        lcH004a007 = lcLot
        lcH008a008 = "0"
        lcH009a017 = SPACE(9)
        lcH018a018 = lctpcgc
        lcH019a032 = lcCgc
        lcH033a052 = lcCnv
        lcH053a057 = lcAgeE
        lcH058a058 = "0"
        lcH059a070 = lcCtaE
        lcH071a071 = lcDigCE
        lcH072a072 = lcDigACE
        lcH073a102 = lcRaz
        lcH103a132 = lcrazbco
        lcH133a142 = SPACE(10)
        lcH143a143 = "1"
        lcH144a151 = lcDat
        lcH152a157 = SPACE(6)
        lcH158a163 = SUBSTR(lcEnv, 2)
        lcH164a166 = "089"
        lcH167a171 = "01600"
        lcH172a240 = SPACE(69)

        lcstrg = lcH001a003+lcH004a007+lcH008a008+lcH009a017+lcH018a018+lcH019a032+ ;
                 lcH033a052+lcH053a057+lcH058a058+lcH059a070+lcH071a071+lcH072a072+ ;
                 lcH073a102+lcH103a132+lcH133a142+lcH143a143+lcH144a151+lcH152a157+ ;
                 lcH158a163+lcH164a166+lcH167a171+lcH172a240+CHR(13)+CHR(10)
        lcstrg = fLimpaTexto(lcstrg)
        STRTOFILE(lcstrg, lcArq, 0)

        *-- Gera lotes de credito em conta e boletos usando metodos auxiliares
        IF RECCOUNT("crFiltro2") > 0
            THIS.CnabBrades240LoteCC(lcLot, lnLot, lnSeq, lcSeq, lctpcgc, lcCgc, lcAgeE, lcCtaE, lcDigCE, lcDigACE, ;
                lcRaz, lcEndesE, lcNumsE, lcComplE, lcCidaE, lcCepE, lcCep1E, lcEstaE, lcOco, ;
                lcArq, lcprot, "01", "crFiltro2", "237")
        ENDIF

        IF RECCOUNT("crFiltro4") > 0
            THIS.CnabBrades240LoteCC(lcLot, lnLot, lnSeq, lcSeq, lctpcgc, lcCgc, lcAgeE, lcCtaE, lcDigCE, lcDigACE, ;
                lcRaz, lcEndesE, lcNumsE, lcComplE, lcCidaE, lcCepE, lcCep1E, lcEstaE, lcOco, ;
                lcArq, lcprot, "03", "crFiltro4", "237")
        ENDIF

        IF RECCOUNT("crFiltro3") > 0
            THIS.CnabBrades240LoteBoleto(lcLot, lnLot, lnSeq, lcSeq, lctpcgc, lcCgc, lcAgeE, lcCtaE, lcDigCE, lcDigACE, ;
                lcRaz, lcEndesE, lcNumsE, lcComplE, lcCidaE, lcCepE, lcCep1E, lcEstaE, lcOco, ;
                lcArq, lcprot, "crFiltro3", "237")
        ENDIF

        IF RECCOUNT("crFiltro5") > 0
            SELECT * FROM crFiltro5 INTO CURSOR crFiltro3 READWRITE
            THIS.CnabBrades240LoteBoleto(lcLot, lnLot, lnSeq, lcSeq, lctpcgc, lcCgc, lcAgeE, lcCtaE, lcDigCE, lcDigACE, ;
                lcRaz, lcEndesE, lcNumsE, lcComplE, lcCidaE, lcCepE, lcCep1E, lcEstaE, lcOco, ;
                lcArq, lcprot, "crFiltro3", "237")
        ENDIF

        *-- Trailer do arquivo
        IF FILE(lcArq)
            LOCAL lcT001a003, lcT004a007, lcT008a008, lcT009a017, lcT018a023, lcT024a029, lcT030a035, lcT036a240
            lcT001a003 = "237"
            lcT004a007 = "9999"
            lcT008a008 = "9"
            lcT009a017 = SPACE(9)
            lcT018a023 = "00" + PADL(ALLTRIM(STR(THIS.this_nCnabLot)), 4, "0")
            lcT024a029 = PADL(ALLTRIM(STR(INT(FSIZE(lcArq)/242)+1)), 6, "0")
            lcT030a035 = "000000"
            lcT036a240 = SPACE(205)
            lcstrg = lcT001a003+lcT004a007+lcT008a008+lcT009a017+lcT018a023+lcT024a029+lcT030a035+lcT036a240+CHR(13)+CHR(10)
            lcstrg = fLimpaTexto(lcstrg)
            STRTOFILE(lcstrg, lcArq, 1)

            lok = .T.
            IF lok
                SELECT crFiltro20
                SCAN
                    LOCAL loc_cTitBans, loc_cTitulos, loc_lAtua
                    loc_cTitBans = loc_oBO.BuscarTituloBanco(crFiltro20.nopers)
                    loc_cTitulos = ALLTRIM(NVL(crFiltro20.titulos, ""))
                    loc_lAtua = .T.
                    IF !EMPTY(loc_cTitBans)
                        loc_lAtua = MsgConfirma('T' + CHR(237) + 'tulo "' + loc_cTitulos + '" j' + CHR(225) + ' possui T' + CHR(237) + 'tulo do Banco preenchido. Sobrescrever?')
                    ENDIF
                    IF loc_lAtua
                        loc_oBO.AtualizarTituloBanco(crFiltro20.nopers, "TIT BRADESC")
                    ENDIF
                    SELECT crFiltro20
                ENDSCAN
            ENDIF

            MsgAviso("Arquivo '" + lcArq + "' gerado com sucesso.")
            THIS.pgf_4c_Principal.pgdados.cgp_4c_Acoes.Command3.Enabled = .F.
        ENDIF
    ENDPROC

    *==========================================================================
    * CnabBrades240LoteCC - Lote credito em conta para Bradesco
    *==========================================================================
    PROTECTED PROCEDURE CnabBrades240LoteCC(lcLot, lnLot, lnSeq, lcSeq, lctpcgc, lcCgc, lcAgeE, lcCtaE, lcDigCE, lcDigACE, ;
        lcRaz, lcEndesE, lcNumsE, lcComplE, lcCidaE, lcCepE, lcCep1E, lcEstaE, lcOco, ;
        lcArq, lcprot, par_cFormaPgto, par_cCursor, par_cBanco)

        LOCAL loc_oBO, lcFin, lnQlote, lcQlote, lnSeql, lcSeql, lnValtot, lnMoetot, lcstrg
        LOCAL loc_cSQL

        loc_oBO = THIS.this_oBusinessObject
        THIS.this_nCnabLot = THIS.this_nCnabLot + 1
        lnLot = THIS.this_nCnabLot
        lcLot = TRANSFORM(lnLot, "@L 9999")
        lcFin = PADR("SISPAG", 30)
        lnQlote = 1

        LOCAL lcL001a003, lcL004a007, lcL008a008, lcL009a009, lcL010a011, lcL012a013
        LOCAL lcL014a016, lcL017a017, lcL018a018, lcL019a032, lcL033a052
        LOCAL lcL053a057, lcL058a058, lcL059a070, lcL071a071, lcL072a072, lcL073a102
        LOCAL lcL103a132, lcL133a142, lcL143a172, lcL173a177, lcL178a192, lcL193a212
        LOCAL lcL213a217, lcL218a220, lcL221a222, lcL223a230, lcL231a240

        lcL001a003 = par_cBanco
        lcL004a007 = lcLot
        lcL008a008 = "1"
        lcL009a009 = "C"
        lcL010a011 = "20"
        lcL012a013 = par_cFormaPgto
        lcL014a016 = "030"
        lcL017a017 = SPACE(1)
        lcL018a018 = lctpcgc
        lcL019a032 = lcCgc
        lcL033a052 = SPACE(20)
        lcL053a057 = lcAgeE
        lcL058a058 = SPACE(1)
        lcL059a070 = lcCtaE
        lcL071a071 = lcDigCE
        lcL072a072 = lcDigACE
        lcL073a102 = lcRaz
        lcL103a132 = lcFin
        lcL133a142 = SPACE(10)
        lcL143a172 = lcEndesE
        lcL173a177 = lcNumsE
        lcL178a192 = lcComplE
        lcL193a212 = lcCidaE
        lcL213a217 = lcCepE
        lcL218a220 = lcCep1E
        lcL221a222 = lcEstaE
        lcL223a230 = SPACE(8)
        lcL231a240 = SPACE(10)

        lcstrg = lcL001a003+lcL004a007+lcL008a008+lcL009a009+lcL010a011+lcL012a013+ ;
                 lcL014a016+lcL017a017+lcL018a018+lcL019a032+lcL033a052+ ;
                 lcL053a057+lcL058a058+lcL059a070+lcL071a071+lcL072a072+lcL073a102+ ;
                 lcL103a132+lcL133a142+lcL143a172+lcL173a177+lcL178a192+lcL193a212+ ;
                 lcL213a217+lcL218a220+lcL221a222+lcL223a230+lcL231a240+CHR(13)+CHR(10)
        lcstrg = fLimpaTexto(lcstrg)
        STRTOFILE(lcstrg, lcArq, 1)

        lnSeql = 0
        lnValtot = 0
        lnMoetot = 0

        SELECT (par_cCursor)
        SCAN
            loc_cSQL = "SELECT * FROM SigCdCeb WHERE GruContas = " + ;
                       EscaparSQL(Grupos + contas) + ;
                       " AND NAgencias != '' AND contas != '' AND nbancos != 0 ORDER BY NAgencias"
            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Conta") < 1
                LOOP
            ENDIF
            GO TOP IN cursor_4c_Conta
            SELECT (par_cCursor)
            IF RECCOUNT("cursor_4c_Conta") = 0
                LOOP
            ENDIF

            LOCAL lcnopers, lcvenc, lccgccli, lctpcgcCli, lcnome
            LOCAL lcValpag, lcChave, lcNossoNum, lcTpcta
            LOCAL lcBco, lcAge, lcDigA, lcCtaC, lcDigC, lcCta, lcAgCta, lcOutCgc

            lcnopers   = TRANSFORM(nopers, "@L 9999999999")
            lcvenc     = SUBSTR(DTOC(vencs), 1, 2) + SUBSTR(DTOC(vencs), 4, 2) + SUBSTR(DTOC(vencs), 7, 4)
            lccgccli   = PADL(ALLTRIM(CHRTRAN(cpfs, "/.-,", "")), 14, "0")
            lctpcgcCli = IIF(LEN(ALLTRIM(CHRTRAN(cpfs, "/.-", ""))) = 11, "1", "2")
            lcnome     = PADR(ALLTRIM(IIF(EMPTY(Razaos), rclis, Razaos)), 30)
            lcValpag   = TRANSFORM(valors * 100, "@L 999999999999999")
            lnValtot   = lnValtot + valors

            SELECT cursor_4c_Conta
            GO TOP
            lcBco  = PADL(ALLTRIM(cursor_4c_Conta.nbancos), 3, "0")
            lcAge  = PADL(ALLTRIM(cursor_4c_Conta.NAgencias), 5, "0")
            lcCtaC = PADL(ALLTRIM(CHRTRAN(cursor_4c_Conta.contas, ".-", "")), 13, "0")
            lcDigC = SUBSTR(lcCtaC, 13, 1)
            lcCta  = SUBSTR(lcCtaC, 1, 12)
            lcAgCta = lcAge + " " + lcCta + " " + lcDigC
            lcTpcta = IIF(cursor_4c_Conta.tpCtas = "02", "PP", "CC")
            lcOutCgc = ALLTRIM(CHRTRAN(cursor_4c_Conta.Convenios, "/.-,", ""))
            lccgccli = IIF(LEN(lcOutCgc) != 11 AND LEN(lcOutCgc) != 14, lccgccli, PADL(lcOutCgc, 14, "0"))

            SELECT (par_cCursor)
            lcChave  = PADR(ALLTRIM(titulos), 10) + lcnopers
            lcNossoNum = ALLTRIM(STR(fGerUniqueKey("BRNOSSONUM")))
            REPLACE nossoNum WITH PADL(lcNossoNum, 10, "0") IN (par_cCursor)

            lnSeql = lnSeql + 1
            lcSeql = TRANSFORM(lnSeql, "@L 99999")
            lnQlote = lnQlote + 1
            lnSeq = lnSeq + 1

            LOCAL lcA001a003, lcA004a007, lcA008a008, lcA009a013, lcA014a014
            LOCAL lcA015a017, lcA018a020, lcA021a023, lcA024a043, lcA044a073
            LOCAL lcA074a093, lcA094a101, lcA102a104, lcA105a112, lcA113a119
            LOCAL lcA120a134, lcA135a149, lcA150a154, lcA155a162, lcA163a177
            LOCAL lcA178a195, lcA196a197, lcA198a203, lcA204a217, lcA218a219
            LOCAL lcA220a224, lcA225a229, lcA230a230, lcA231a240

            lcA001a003 = par_cBanco
            lcA004a007 = lcLot
            lcA008a008 = "3"
            lcA009a013 = lcSeql
            lcA014a014 = "A"
            lcA015a017 = "000"
            lcA018a020 = "000"
            lcA021a023 = lcBco
            lcA024a043 = lcAgCta
            lcA044a073 = lcnome
            lcA074a093 = lcChave
            lcA094a101 = lcvenc
            lcA102a104 = "REA"
            lcA105a112 = "00000000"
            lcA113a119 = "0000000"
            lcA120a134 = lcValpag
            lcA135a149 = SPACE(15)
            lcA150a154 = SPACE(5)
            lcA155a162 = "00000000"
            lcA163a177 = "000000000000000"
            lcA178a195 = SPACE(18)
            lcA196a197 = SPACE(2)
            lcA198a203 = "000000"
            lcA204a217 = lccgccli
            lcA218a219 = "01"
            lcA220a224 = "00010"
            lcA225a229 = SPACE(5)
            lcA230a230 = "0"
            lcA231a240 = SPACE(10)

            lcstrg = lcA001a003+lcA004a007+lcA008a008+lcA009a013+lcA014a014+ ;
                     lcA015a017+lcA018a020+lcA021a023+lcA024a043+lcA044a073+ ;
                     lcA074a093+lcA094a101+lcA102a104+lcA105a112+lcA113a119+ ;
                     lcA120a134+lcA135a149+lcA150a154+lcA155a162+lcA163a177+ ;
                     lcA178a195+lcA196a197+lcA198a203+lcA204a217+lcA218a219+ ;
                     lcA220a224+lcA225a229+lcA230a230+lcA231a240+CHR(13)+CHR(10)
            lcstrg = fLimpaTexto(lcstrg)
            STRTOFILE(lcstrg, lcArq, 1)

            loc_oBO.RegistrarLinhaArquivo("C", nopers, lcstrg, titulos, lcChave)
            SELECT (par_cCursor)
        ENDSCAN

        lnSeq = lnSeq + 1
        lnSeql = lnSeql + 1
        lcSeql = TRANSFORM(lnSeql, "@L 999999")
        lnQlote = lnQlote + 1
        lcQlote = TRANSFORM(lnQlote, "@L 999999")
        LOCAL lcValtotStr, lcMoetotStr
        lcValtotStr = TRANSFORM(lnValtot * 100, "@L 999999999999999999")
        lcMoetotStr = "000000000000000000"
        LOCAL lcTL001a003, lcTL004a007, lcTL008a008, lcTL009a017, lcTL018a023
        LOCAL lcTL024a041, lcTL042a059, lcTL060a230, lcTL231a240
        lcTL001a003 = par_cBanco
        lcTL004a007 = lcLot
        lcTL008a008 = "5"
        lcTL009a017 = SPACE(9)
        lcTL018a023 = lcQlote
        lcTL024a041 = lcValtotStr
        lcTL042a059 = lcMoetotStr
        lcTL060a230 = SPACE(171)
        lcTL231a240 = SPACE(10)
        lcstrg = lcTL001a003+lcTL004a007+lcTL008a008+lcTL009a017+lcTL018a023+ ;
                 lcTL024a041+lcTL042a059+lcTL060a230+lcTL231a240+CHR(13)+CHR(10)
        lcstrg = fLimpaTexto(lcstrg)
        STRTOFILE(lcstrg, lcArq, 1)
    ENDPROC

    *==========================================================================
    * CnabBrades240LoteBoleto - Lote boletos para Bradesco
    *==========================================================================
    PROTECTED PROCEDURE CnabBrades240LoteBoleto(lcLot, lnLot, lnSeq, lcSeq, lctpcgc, lcCgc, lcAgeE, lcCtaE, lcDigCE, lcDigACE, ;
        lcRaz, lcEndesE, lcNumsE, lcComplE, lcCidaE, lcCepE, lcCep1E, lcEstaE, lcOco, ;
        lcArq, lcprot, par_cCursor, par_cBanco)

        LOCAL loc_oBO, lnQlote, lcQlote, lnSeql, lcSeql, lnValtot, lnMoetot, lcstrg
        LOCAL loc_cSQL

        loc_oBO = THIS.this_oBusinessObject
        THIS.this_nCnabLot = THIS.this_nCnabLot + 1
        lnLot = THIS.this_nCnabLot
        lcLot = TRANSFORM(lnLot, "@L 9999")
        lnQlote = 1

        LOCAL lcL001a003, lcL004a007, lcL008a008, lcL009a009, lcL010a011, lcL012a013
        LOCAL lcL014a016, lcL015a015, lcL017a017, lcL018a018, lcL019a032, lcL033a061
        LOCAL lcL053a057, lcL058a058, lcL059a070, lcL071a072, lcL073a102
        LOCAL lcL103a132, lcL133a142, lcL143a172, lcL173a177, lcL178a192, lcL193a212
        LOCAL lcL213a217, lcL218a220, lcL221a222, lcL223a230, lcL231a240

        lcL001a003 = par_cBanco
        lcL004a007 = lcLot
        lcL008a008 = "1"
        lcL009a009 = "C"
        lcL010a011 = "09"
        lcL012a013 = "00"
        lcL014a016 = "030"
        lcL017a017 = SPACE(1)
        lcL018a018 = lctpcgc
        lcL019a032 = lcCgc
        lcL033a061 = SPACE(29)
        lcL053a057 = lcAgeE
        lcL058a058 = lcDigAE
        lcL059a070 = lcCtaE
        lcL071a072 = lcDigCE + lcDigACE
        lcL073a102 = lcRaz
        lcL103a132 = SPACE(30)
        lcL133a142 = SPACE(10)
        lcL143a172 = lcEndesE
        lcL173a177 = lcNumsE
        lcL178a192 = lcComplE
        lcL193a212 = lcCidaE
        lcL213a217 = lcCepE
        lcL218a220 = lcCep1E
        lcL221a222 = lcEstaE
        lcL223a230 = SPACE(8)
        lcL231a240 = lcOco

        lcstrg = lcL001a003+lcL004a007+lcL008a008+lcL009a009+lcL010a011+lcL012a013+ ;
                 lcL014a016+lcL017a017+lcL018a018+lcL019a032+lcL033a061+ ;
                 lcL053a057+lcL058a058+lcL059a070+lcL071a072+lcL073a102+ ;
                 lcL103a132+lcL133a142+lcL143a172+lcL173a177+lcL178a192+lcL193a212+ ;
                 lcL213a217+lcL218a220+lcL221a222+lcL223a230+lcL231a240+CHR(13)+CHR(10)
        lcstrg = fLimpaTexto(lcstrg)
        STRTOFILE(lcstrg, lcArq, 1)

        lnSeql = 0
        lnValtot = 0

        SELECT (par_cCursor)
        SCAN
            lnQlote = lnQlote + 1
            loc_cSQL = "SELECT * FROM SigCdCeb WHERE GruContas = " + ;
                       EscaparSQL(Grupos + contas) + ;
                       " ORDER BY NAgencias"
            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Conta") >= 1
                GO TOP IN cursor_4c_Conta
            ENDIF
            SELECT (par_cCursor)

            LOCAL lcnopers, lcvenc, lccgccli, lcnome, lcValpag, lcBarra, lcChave, lcNossoNum
            LOCAL lcO001a003, lcO004a007, lcO008a008, lcO009a013, lcO014a014
            LOCAL lcO015a015, lcO016a017, lcO018a061, lcO062a091, lcO092a099
            LOCAL lcO100a107, lcO108a122, lcO123a142, lcO143a162, lcO163a230, lcO231a240

            lcnopers = TRANSFORM(nopers, "@L 9999999999")
            lcvenc   = SUBSTR(DTOC(vencs), 1, 2) + SUBSTR(DTOC(vencs), 4, 2) + SUBSTR(DTOC(vencs), 7, 4)
            lccgccli = PADL(ALLTRIM(CHRTRAN(cpfs, "/.-,", "")), 14, "0")
            lcnome   = PADR(ALLTRIM(IIF(EMPTY(Razaos), rclis, Razaos)), 30)
            lcValpag = TRANSFORM(valors * 100, "@L 999999999999999")
            lnValtot = lnValtot + valors
            lcBarra  = ALLTRIM(CHRTRAN(barras, "/.-", "")) + REPLICATE("0", 44)
            lcBarra  = SUBSTR(lcBarra, 1, 4) + SUBSTR(lcBarra, 33, 15) + SUBSTR(lcBarra, 5, 5) + SUBSTR(lcBarra, 11, 10) + SUBSTR(lcBarra, 22, 10)
            lcChave  = PADR(ALLTRIM(titulos), 10) + lcnopers

            lcNossoNum = ALLTRIM(STR(fGerUniqueKey("BRNOSSONUM")))
            REPLACE nossoNum WITH PADL(lcNossoNum, 10, "0") IN (par_cCursor)
            lnSeql = lnSeql + 1
            lcSeql = TRANSFORM(lnSeql, "@L 99999")
            lnSeq  = lnSeq + 1

            lcO001a003 = par_cBanco
            lcO004a007 = lcLot
            lcO008a008 = "3"
            lcO009a013 = lcSeql
            lcO014a014 = "J"
            lcO015a015 = "0"
            lcO016a017 = "00"
            lcO018a061 = lcBarra
            lcO062a091 = lcnome
            lcO092a099 = lcvenc
            lcO100a107 = lcvenc
            lcO108a122 = lcValpag
            lcO123a142 = "00000000000000000000"
            lcO143a162 = lcValpag
            lcO163a230 = lcChave + SPACE(50)
            lcO231a240 = SPACE(10)

            lcstrg = lcO001a003+lcO004a007+lcO008a008+lcO009a013+lcO014a014+ ;
                     lcO015a015+lcO016a017+lcO018a061+lcO062a091+lcO092a099+ ;
                     lcO100a107+lcO108a122+lcO123a142+lcO143a162+lcO163a230+lcO231a240+CHR(13)+CHR(10)
            lcstrg = fLimpaTexto(lcstrg)
            STRTOFILE(lcstrg, lcArq, 1)

            loc_oBO.RegistrarLinhaArquivo("C", nopers, lcstrg, titulos, lcChave)
            SELECT (par_cCursor)
        ENDSCAN

        lnSeq = lnSeq + 1
        lnSeql = lnSeql + 1
        lcSeql = TRANSFORM(lnSeql, "@L 999999")
        lnQlote = lnQlote + 1
        lcQlote = TRANSFORM(lnQlote, "@L 999999")
        LOCAL lcValtotStr
        lcValtotStr = TRANSFORM(lnValtot * 100, "@L 999999999999999999")
        LOCAL lcTL001a003, lcTL004a007, lcTL008a008, lcTL009a017, lcTL018a023
        LOCAL lcTL024a041, lcTL042a059, lcTL060a065, lcTL066a230, lcTL231a240
        lcTL001a003 = par_cBanco
        lcTL004a007 = lcLot
        lcTL008a008 = "5"
        lcTL009a017 = SPACE(9)
        lcTL018a023 = lcQlote
        lcTL024a041 = lcValtotStr
        lcTL042a059 = "000000000000000000"
        lcTL060a065 = "000000"
        lcTL066a230 = SPACE(165)
        lcTL231a240 = SPACE(10)
        lcstrg = lcTL001a003+lcTL004a007+lcTL008a008+lcTL009a017+lcTL018a023+ ;
                 lcTL024a041+lcTL042a059+lcTL060a065+lcTL066a230+lcTL231a240+CHR(13)+CHR(10)
        lcstrg = fLimpaTexto(lcstrg)
        STRTOFILE(lcstrg, lcArq, 1)
    ENDPROC

    *==========================================================================
    * CnabSantander240 - Gera arquivo CNAB 240 posicoes para Santander (033/353)
    *==========================================================================
    PROCEDURE CnabSantander240()
        LOCAL loc_oBO, loc_oP2
        LOCAL lcCnv, lcAgeE, lcDigAE, lcCtaCE, lcDigCE, lcCtaE, lcDigACE
        LOCAL lcRaz, lcCgc, lctpcgc, lcrazbco
        LOCAL lcDat, lcHora, lcprot, lcEnv, lcArq, lcTpCtArq, lcTpCtBol
        LOCAL lcEndesE, lcNumsE, lcComplE, lcCidaE, lcCepE, lcCep1E, lcEstaE, lcOco
        LOCAL lnLot, lcLot, lnSeq, lcSeq, lnQlote, lcQlote
        LOCAL lcstrg, lok

        SET SAFETY OFF
        loc_oBO = THIS.this_oBusinessObject
        loc_oP2 = THIS.pgf_4c_Principal.pgdados

        IF USED("crFiltro2")
            USE IN crFiltro2
        ENDIF
        SELECT *, SPACE(10) AS nossoNum, SPACE(50) AS barras FROM cursor_4c_Filtro WHERE marca INTO CURSOR crFiltro2 READWRITE
        THIS.BuscarBoleto("033")

        SELECT cursor_4c_Convenio
        GO TOP
        SELECT cursor_4c_Empresa
        GO TOP

        lcAgeE = PADL(ALLTRIM(cursor_4c_Convenio.NAgencias), 5, "0")
        lcCnv  = "0033" + SUBSTR(lcAgeE, 2, 4) + PADL(ALLTRIM(cursor_4c_Convenio.Convenios), 12, "0")
        lcDigAE = ALLTRIM(cursor_4c_Convenio.DigiAgen)
        lcCtaCE = PADL(ALLTRIM(CHRTRAN(cursor_4c_Convenio.contas, ".-", "")), 13, "0")
        lcDigCE = SUBSTR(lcCtaCE, 13, 1)
        lcDigACE = " "
        lcCtaE = SUBSTR(lcCtaCE, 1, 12)
        lcRaz    = PADR(ALLTRIM(cursor_4c_Empresa.RazSocs), 30)
        lcCgc    = PADL(ALLTRIM(STRTRAN(STRTRAN(STRTRAN(cursor_4c_Empresa.Cgcs, "/", ""), ".", ""), "-", "")), 14, "0")
        lctpcgc  = IIF(LEN(ALLTRIM(CHRTRAN(cursor_4c_Empresa.Cgcs, "/.-", ""))) = 11, "1", "2")
        lcrazbco = PADR(ALLTRIM(cursor_4c_Convenio.bancos), 30)
        lcDat    = SUBSTR(DTOC(DATE()), 1, 2) + SUBSTR(DTOC(DATE()), 4, 2) + SUBSTR(DTOC(DATE()), 7, 4)
        lcHora   = TTOC(DATETIME())
        lcHora   = SUBSTR(lcHora, 12, 2) + SUBSTR(lcHora, 15, 2) + SUBSTR(lcHora, 18, 2)
        lcprot   = IIF(loc_oP2.spn_4c_Dias.Value = 0, 5, loc_oP2.spn_4c_Dias.Value)
        lcprot   = PADL(ALLTRIM(STR(lcprot)), 2, "0")
        lcEnv    = PADL(fGerUniqueKey("SANTANDERENV"), 7, "0")
        lcArq    = ALLTRIM(cursor_4c_Convenio.Drive) + IIF(EMPTY(ALLTRIM(cursor_4c_Convenio.Drive)), "", "\")
        lcArq    = STRTRAN(lcArq + ALLTRIM(cursor_4c_Convenio.ArqCnabs) + lcEnv + ".REM", "\\", "\")
        lcTpCtArq = ALLTRIM(cursor_4c_Convenio.TpCtArqs)
        lcTpCtBol = ALLTRIM(cursor_4c_Convenio.TpCtBols)
        lcEndesE  = PADR(ALLTRIM(cursor_4c_Empresa.endes), 30)
        lcNumsE   = PADL(ALLTRIM(cursor_4c_Empresa.numeros), 5, "0")
        lcComplE  = PADR(ALLTRIM(cursor_4c_Empresa.compls), 15)
        lcCidaE   = PADR(ALLTRIM(cursor_4c_Empresa.cidas), 20)
        lcCepE    = SUBSTR(cursor_4c_Empresa.ceps, 1, 5)
        lcCep1E   = SUBSTR(cursor_4c_Empresa.ceps, 7, 3)
        lcEstaE   = ALLTRIM(cursor_4c_Empresa.estas)
        lcOco     = SPACE(10)

        THIS.this_nCnabLot = 0
        lnLot = 0
        lcLot = TRANSFORM(lnLot, "@L 9999")
        lnSeq = 1
        lcSeq = TRANSFORM(lnSeq, "@L 999999")

        *-- Cabecalho do arquivo
        LOCAL lcH001a003, lcH004a007, lcH008a008, lcH009a017, lcH018a018, lcH019a032
        LOCAL lcH033a052, lcH053a057, lcH058a058, lcH059a070, lcH071a071, lcH072a072
        LOCAL lcH073a102, lcH103a132, lcH133a142, lcH143a143, lcH144a151, lcH152a157
        LOCAL lcH158a163, lcH164a166, lcH167a171, lcH172a191, lcH192a211, lcH212a230, lcH231a240

        lcH001a003 = "033"
        lcH004a007 = lcLot
        lcH008a008 = "0"
        lcH009a017 = SPACE(9)
        lcH018a018 = lctpcgc
        lcH019a032 = lcCgc
        lcH033a052 = lcCnv
        lcH053a057 = lcAgeE
        lcH058a058 = SPACE(1)
        lcH059a070 = lcCtaE
        lcH071a071 = lcDigCE
        lcH072a072 = lcDigACE
        lcH073a102 = lcRaz
        lcH103a132 = lcrazbco
        lcH133a142 = SPACE(10)
        lcH143a143 = "1"
        lcH144a151 = lcDat
        lcH152a157 = lcHora
        lcH158a163 = "000000"
        lcH164a166 = "060"
        lcH167a171 = "00000"
        lcH172a191 = SPACE(20)
        lcH192a211 = SPACE(20)
        lcH212a230 = SPACE(19)
        lcH231a240 = SPACE(10)

        lcstrg = lcH001a003+lcH004a007+lcH008a008+lcH009a017+lcH018a018+lcH019a032+ ;
                 lcH033a052+lcH053a057+lcH058a058+lcH059a070+lcH071a071+lcH072a072+ ;
                 lcH073a102+lcH103a132+lcH133a142+lcH143a143+lcH144a151+lcH152a157+ ;
                 lcH158a163+lcH164a166+lcH167a171+lcH172a191+lcH192a211+lcH212a230+lcH231a240+CHR(13)+CHR(10)
        lcstrg = fLimpaTexto(lcstrg)
        STRTOFILE(lcstrg, lcArq, 0)

        *-- Gera lotes
        IF RECCOUNT("crFiltro2") > 0
            THIS.CnabSant240LoteCC(lcLot, lnLot, lnSeq, lcSeq, lctpcgc, lcCgc, lcAgeE, lcCtaE, lcDigCE, lcDigACE, ;
                lcRaz, lcCnv, lcEndesE, lcNumsE, lcComplE, lcCidaE, lcCepE, lcCep1E, lcEstaE, lcOco, ;
                lcArq, lcprot, "crFiltro2", "033")
        ENDIF

        IF RECCOUNT("crFiltro4") > 0
            THIS.CnabSant240LoteCC(lcLot, lnLot, lnSeq, lcSeq, lctpcgc, lcCgc, lcAgeE, lcCtaE, lcDigCE, lcDigACE, ;
                lcRaz, lcCnv, lcEndesE, lcNumsE, lcComplE, lcCidaE, lcCepE, lcCep1E, lcEstaE, lcOco, ;
                lcArq, lcprot, "crFiltro4", "033")
        ENDIF

        IF RECCOUNT("crFiltro3") > 0
            THIS.CnabSant240LoteBoleto(lcLot, lnLot, lnSeq, lcSeq, lctpcgc, lcCgc, lcAgeE, lcCtaE, lcDigCE, lcDigACE, ;
                lcRaz, lcCnv, lcEndesE, lcNumsE, lcComplE, lcCidaE, lcCepE, lcCep1E, lcEstaE, lcOco, ;
                lcArq, lcprot, "crFiltro3", "033")
        ENDIF

        IF RECCOUNT("crFiltro5") > 0
            SELECT * FROM crFiltro5 INTO CURSOR crFiltro3 READWRITE
            THIS.CnabSant240LoteBoleto(lcLot, lnLot, lnSeq, lcSeq, lctpcgc, lcCgc, lcAgeE, lcCtaE, lcDigCE, lcDigACE, ;
                lcRaz, lcCnv, lcEndesE, lcNumsE, lcComplE, lcCidaE, lcCepE, lcCep1E, lcEstaE, lcOco, ;
                lcArq, lcprot, "crFiltro3", "033")
        ENDIF

        *-- Trailer do arquivo
        IF FILE(lcArq)
            LOCAL lcT001a003, lcT004a007, lcT008a008, lcT009a017, lcT018a023, lcT024a029, lcT030a035, lcT036a240
            lcT001a003 = "033"
            lcT004a007 = "9999"
            lcT008a008 = "9"
            lcT009a017 = SPACE(9)
            lcT018a023 = "00" + PADL(ALLTRIM(STR(THIS.this_nCnabLot)), 4, "0")
            lcT024a029 = PADL(ALLTRIM(STR(INT(FSIZE(lcArq)/242)+1)), 6, "0")
            lcT030a035 = "000000"
            lcT036a240 = SPACE(205)
            lcstrg = lcT001a003+lcT004a007+lcT008a008+lcT009a017+lcT018a023+lcT024a029+lcT030a035+lcT036a240+CHR(13)+CHR(10)
            lcstrg = fLimpaTexto(lcstrg)
            STRTOFILE(lcstrg, lcArq, 1)

            lok = .T.
            IF lok
                SELECT crFiltro20
                SCAN
                    LOCAL loc_cTitBans, loc_cTitulos, loc_lAtua
                    loc_cTitBans = loc_oBO.BuscarTituloBanco(crFiltro20.nopers)
                    loc_cTitulos = ALLTRIM(NVL(crFiltro20.titulos, ""))
                    loc_lAtua = .T.
                    IF !EMPTY(loc_cTitBans)
                        loc_lAtua = MsgConfirma('T' + CHR(237) + 'tulo "' + loc_cTitulos + '" j' + CHR(225) + ' possui T' + CHR(237) + 'tulo do Banco preenchido. Sobrescrever?')
                    ENDIF
                    IF loc_lAtua
                        loc_oBO.AtualizarTituloBanco(crFiltro20.nopers, "TIT SANTANDER")
                    ENDIF
                    SELECT crFiltro20
                ENDSCAN
            ENDIF

            MsgAviso("Arquivo '" + lcArq + "' gerado com sucesso.")
        ENDIF
    ENDPROC

    *==========================================================================
    * CnabSant240LoteCC - Lote credito em conta para Santander
    *==========================================================================
    PROTECTED PROCEDURE CnabSant240LoteCC(lcLot, lnLot, lnSeq, lcSeq, lctpcgc, lcCgc, lcAgeE, lcCtaE, lcDigCE, lcDigACE, ;
        lcRaz, lcCnv, lcEndesE, lcNumsE, lcComplE, lcCidaE, lcCepE, lcCep1E, lcEstaE, lcOco, ;
        lcArq, lcprot, par_cCursor, par_cBanco)

        LOCAL loc_oBO, lcFin, lnQlote, lcQlote, lnSeql, lcSeql, lnValtot, lnMoetot, lcstrg
        LOCAL loc_cSQL

        loc_oBO = THIS.this_oBusinessObject
        THIS.this_nCnabLot = THIS.this_nCnabLot + 1
        lnLot = THIS.this_nCnabLot
        lcLot = TRANSFORM(lnLot, "@L 9999")
        lcFin = PADR("SISPAG", 30)
        lnQlote = 1

        LOCAL lcL001a003, lcL004a007, lcL008a008, lcL009a009, lcL010a011, lcL012a013
        LOCAL lcL014a016, lcL017a017, lcL018a018, lcL019a032, lcL033a052
        LOCAL lcL053a057, lcL058a058, lcL059a070, lcL071a071, lcL072a072, lcL073a102
        LOCAL lcL103a132, lcL133a142, lcL143a172, lcL173a177, lcL178a192, lcL193a212
        LOCAL lcL213a217, lcL218a220, lcL221a222, lcL223a230, lcL231a240

        lcL001a003 = par_cBanco
        lcL004a007 = lcLot
        lcL008a008 = "1"
        lcL009a009 = "C"
        lcL010a011 = "20"
        lcL012a013 = "45"
        lcL014a016 = "040"
        lcL017a017 = SPACE(1)
        lcL018a018 = lctpcgc
        lcL019a032 = lcCgc
        lcL033a052 = SPACE(20)
        lcL053a057 = lcAgeE
        lcL058a058 = SPACE(1)
        lcL059a070 = lcCtaE
        lcL071a071 = lcDigCE
        lcL072a072 = lcDigACE
        lcL073a102 = lcRaz
        lcL103a132 = lcFin
        lcL133a142 = SPACE(10)
        lcL143a172 = lcEndesE
        lcL173a177 = lcNumsE
        lcL178a192 = lcComplE
        lcL193a212 = lcCidaE
        lcL213a217 = lcCepE
        lcL218a220 = lcCep1E
        lcL221a222 = lcEstaE
        lcL223a230 = SPACE(8)
        lcL231a240 = SPACE(10)

        lcstrg = lcL001a003+lcL004a007+lcL008a008+lcL009a009+lcL010a011+lcL012a013+ ;
                 lcL014a016+lcL017a017+lcL018a018+lcL019a032+lcL033a052+ ;
                 lcL053a057+lcL058a058+lcL059a070+lcL071a071+lcL072a072+lcL073a102+ ;
                 lcL103a132+lcL133a142+lcL143a172+lcL173a177+lcL178a192+lcL193a212+ ;
                 lcL213a217+lcL218a220+lcL221a222+lcL223a230+lcL231a240+CHR(13)+CHR(10)
        lcstrg = fLimpaTexto(lcstrg)
        STRTOFILE(lcstrg, lcArq, 1)

        lnSeql = 0
        lnValtot = 0
        lnMoetot = 0

        SELECT (par_cCursor)
        SCAN
            loc_cSQL = "SELECT * FROM SigCdCeb WHERE GruContas = " + ;
                       EscaparSQL(Grupos + contas) + ;
                       " AND NAgencias != '' AND contas != '' AND nbancos != 0 ORDER BY NAgencias"
            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Conta") < 1
                LOOP
            ENDIF
            GO TOP IN cursor_4c_Conta
            SELECT (par_cCursor)
            IF RECCOUNT("cursor_4c_Conta") = 0
                LOOP
            ENDIF

            LOCAL lcnopers, lcvenc, lccgccli, lctpcgcCli, lcnome
            LOCAL lcValpag, lcChave, lcNossoNum, lcTpcta
            LOCAL lcBco, lcAge, lcDigA, lcCtaC, lcDigC, lcCta, lcAgCta, lcOutCgc

            lcnopers   = TRANSFORM(nopers, "@L 9999999999")
            lcvenc     = SUBSTR(DTOC(vencs), 1, 2) + SUBSTR(DTOC(vencs), 4, 2) + SUBSTR(DTOC(vencs), 7, 4)
            lccgccli   = PADL(ALLTRIM(CHRTRAN(cpfs, "/.-,", "")), 14, "0")
            lctpcgcCli = IIF(LEN(ALLTRIM(CHRTRAN(cpfs, "/.-", ""))) = 11, "1", "2")
            lcnome     = PADR(ALLTRIM(IIF(EMPTY(Razaos), rclis, Razaos)), 30)
            lcValpag   = TRANSFORM(valors * 100, "@L 999999999999999")
            lnValtot   = lnValtot + valors

            SELECT cursor_4c_Conta
            GO TOP
            lcBco  = PADL(ALLTRIM(cursor_4c_Conta.nbancos), 3, "0")
            lcAge  = PADL(ALLTRIM(cursor_4c_Conta.NAgencias), 5, "0")
            lcCtaC = PADL(ALLTRIM(CHRTRAN(cursor_4c_Conta.contas, ".-", "")), 13, "0")
            lcDigC = SUBSTR(lcCtaC, 13, 1)
            lcCta  = SUBSTR(lcCtaC, 1, 12)
            lcAgCta = lcAge + " " + lcCta + " " + lcDigC
            lcOutCgc = ALLTRIM(CHRTRAN(cursor_4c_Conta.Convenios, "/.-,", ""))
            lccgccli = IIF(LEN(lcOutCgc) != 11 AND LEN(lcOutCgc) != 14, lccgccli, PADL(lcOutCgc, 14, "0"))

            SELECT (par_cCursor)
            lcChave  = PADR(ALLTRIM(titulos), 10) + lcnopers
            lcNossoNum = ALLTRIM(STR(fGerUniqueKey("BRNOSSONUM")))
            REPLACE nossoNum WITH PADL(lcNossoNum, 10, "0") IN (par_cCursor)

            lnSeql = lnSeql + 1
            lcSeql = TRANSFORM(lnSeql, "@L 99999")
            lnQlote = lnQlote + 1
            lnSeq = lnSeq + 1

            LOCAL lcA001a003, lcA004a007, lcA008a008, lcA009a013, lcA014a014
            LOCAL lcA015a017, lcA018a020, lcA021a023, lcA024a043, lcA044a073
            LOCAL lcA074a093, lcA094a101, lcA102a104, lcA105a112, lcA113a114
            LOCAL lcA115a119, lcA120a134, lcA135a149, lcA150a154, lcA155a162
            LOCAL lcA163a177, lcA178a195, lcA196a197, lcA198a203, lcA204a217
            LOCAL lcA218a219, lcA220a224, lcA225a229, lcA230a230, lcA231a240

            lcA001a003 = par_cBanco
            lcA004a007 = lcLot
            lcA008a008 = "3"
            lcA009a013 = lcSeql
            lcA014a014 = "A"
            lcA015a017 = "000"
            lcA018a020 = "000"
            lcA021a023 = lcBco
            lcA024a043 = lcAgCta
            lcA044a073 = lcnome
            lcA074a093 = lcChave
            lcA094a101 = lcvenc
            lcA102a104 = "REA"
            lcA105a112 = "00000000"
            lcA113a114 = "00"
            lcA115a119 = "00000"
            lcA120a134 = lcValpag
            lcA135a149 = SPACE(15)
            lcA150a154 = SPACE(5)
            lcA155a162 = "00000000"
            lcA163a177 = "000000000000000"
            lcA178a195 = SPACE(18)
            lcA196a197 = SPACE(2)
            lcA198a203 = "000000"
            lcA204a217 = lccgccli
            lcA218a219 = "01"
            lcA220a224 = "00010"
            lcA225a229 = SPACE(5)
            lcA230a230 = "0"
            lcA231a240 = SPACE(10)

            lcstrg = lcA001a003+lcA004a007+lcA008a008+lcA009a013+lcA014a014+ ;
                     lcA015a017+lcA018a020+lcA021a023+lcA024a043+lcA044a073+ ;
                     lcA074a093+lcA094a101+lcA102a104+lcA105a112+lcA113a114+ ;
                     lcA115a119+lcA120a134+lcA135a149+lcA150a154+lcA155a162+ ;
                     lcA163a177+lcA178a195+lcA196a197+lcA198a203+lcA204a217+ ;
                     lcA218a219+lcA220a224+lcA225a229+lcA230a230+lcA231a240+CHR(13)+CHR(10)
            lcstrg = fLimpaTexto(lcstrg)
            STRTOFILE(lcstrg, lcArq, 1)

            loc_oBO.RegistrarLinhaArquivo("C", nopers, lcstrg, titulos, lcChave)
            SELECT (par_cCursor)
        ENDSCAN

        lnSeq = lnSeq + 1
        lnSeql = lnSeql + 1
        lcSeql = TRANSFORM(lnSeql, "@L 999999")
        lnQlote = lnQlote + 1
        lcQlote = TRANSFORM(lnQlote, "@L 999999")
        LOCAL lcValtotStr, lcMoetotStr
        lcValtotStr = TRANSFORM(lnValtot * 100, "@L 999999999999999999")
        lcMoetotStr = "000000000000000000"
        LOCAL lcTL001a003, lcTL004a007, lcTL008a008, lcTL009a017, lcTL018a023
        LOCAL lcTL024a041, lcTL042a059, lcTL060a230, lcTL231a240
        lcTL001a003 = par_cBanco
        lcTL004a007 = lcLot
        lcTL008a008 = "5"
        lcTL009a017 = SPACE(9)
        lcTL018a023 = lcQlote
        lcTL024a041 = lcValtotStr
        lcTL042a059 = lcMoetotStr
        lcTL060a230 = SPACE(171)
        lcTL231a240 = SPACE(10)
        lcstrg = lcTL001a003+lcTL004a007+lcTL008a008+lcTL009a017+lcTL018a023+ ;
                 lcTL024a041+lcTL042a059+lcTL060a230+lcTL231a240+CHR(13)+CHR(10)
        lcstrg = fLimpaTexto(lcstrg)
        STRTOFILE(lcstrg, lcArq, 1)
    ENDPROC

    *==========================================================================
    * CnabSant240LoteBoleto - Lote boletos para Santander
    *==========================================================================
    PROTECTED PROCEDURE CnabSant240LoteBoleto(lcLot, lnLot, lnSeq, lcSeq, lctpcgc, lcCgc, lcAgeE, lcCtaE, lcDigCE, lcDigACE, ;
        lcRaz, lcCnv, lcEndesE, lcNumsE, lcComplE, lcCidaE, lcCepE, lcCep1E, lcEstaE, lcOco, ;
        lcArq, lcprot, par_cCursor, par_cBanco)

        LOCAL loc_oBO, lnQlote, lcQlote, lnSeql, lcSeql, lnValtot, lcstrg
        LOCAL loc_cSQL

        loc_oBO = THIS.this_oBusinessObject
        THIS.this_nCnabLot = THIS.this_nCnabLot + 1
        lnLot = THIS.this_nCnabLot
        lcLot = TRANSFORM(lnLot, "@L 9999")
        lnQlote = 1

        LOCAL lcL001a003, lcL004a007, lcL008a008, lcL009a009, lcL010a011, lcL012a013
        LOCAL lcL014a016, lcL017a017, lcL018a018, lcL019a032, lcL033a052
        LOCAL lcL053a057, lcL058a058, lcL059a070, lcL071a071, lcL072a072, lcL073a102
        LOCAL lcL103a132, lcL133a142, lcL143a172, lcL173a177, lcL178a192, lcL193a212
        LOCAL lcL213a217, lcL218a220, lcL221a222, lcL223a230, lcL231a240

        lcL001a003 = par_cBanco
        lcL004a007 = lcLot
        lcL008a008 = "1"
        lcL009a009 = "C"
        lcL010a011 = "09"
        lcL012a013 = "00"
        lcL014a016 = "030"
        lcL017a017 = SPACE(1)
        lcL018a018 = lctpcgc
        lcL019a032 = lcCgc
        lcL033a052 = SPACE(20)
        lcL053a057 = lcAgeE
        lcL058a058 = lcDigAE
        lcL059a070 = lcCtaE
        lcL071a071 = lcDigCE
        lcL072a072 = lcDigACE
        lcL073a102 = lcRaz
        lcL103a132 = SPACE(30)
        lcL133a142 = SPACE(10)
        lcL143a172 = lcEndesE
        lcL173a177 = lcNumsE
        lcL178a192 = lcComplE
        lcL193a212 = lcCidaE
        lcL213a217 = lcCepE
        lcL218a220 = lcCep1E
        lcL221a222 = lcEstaE
        lcL223a230 = SPACE(8)
        lcL231a240 = lcOco

        lcstrg = lcL001a003+lcL004a007+lcL008a008+lcL009a009+lcL010a011+lcL012a013+ ;
                 lcL014a016+lcL017a017+lcL018a018+lcL019a032+lcL033a052+ ;
                 lcL053a057+lcL058a058+lcL059a070+lcL071a071+lcL072a072+lcL073a102+ ;
                 lcL103a132+lcL133a142+lcL143a172+lcL173a177+lcL178a192+lcL193a212+ ;
                 lcL213a217+lcL218a220+lcL221a222+lcL223a230+lcL231a240+CHR(13)+CHR(10)
        lcstrg = fLimpaTexto(lcstrg)
        STRTOFILE(lcstrg, lcArq, 1)

        lnSeql = 0
        lnValtot = 0

        SELECT (par_cCursor)
        SCAN
            lnQlote = lnQlote + 1
            loc_cSQL = "SELECT * FROM SigCdCeb WHERE GruContas = " + ;
                       EscaparSQL(Grupos + contas) + ;
                       " ORDER BY NAgencias"
            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Conta") >= 1
                GO TOP IN cursor_4c_Conta
            ENDIF
            SELECT (par_cCursor)

            LOCAL lcnopers, lcvenc, lccgccli, lcnome, lcValpag, lcBarra, lcChave, lcNossoNum
            LOCAL lcJ001a003, lcJ004a007, lcJ008a008, lcJ009a013, lcJ014a014
            LOCAL lcJ015a017, lcJ018a061, lcJ062a091, lcJ092a099, lcJ100a114
            LOCAL lcJ115a129, lcJ130a144, lcJ145a152, lcJ153a167, lcJ168a182
            LOCAL lcJ183a202, lcJ203a215, lcJ216a230, lcJ231a240

            lcnopers = TRANSFORM(nopers, "@L 9999999999")
            lcvenc   = SUBSTR(DTOC(vencs), 1, 2) + SUBSTR(DTOC(vencs), 4, 2) + SUBSTR(DTOC(vencs), 7, 4)
            lccgccli = PADL(ALLTRIM(CHRTRAN(cpfs, "/.-,", "")), 14, "0")
            lcnome   = PADR(ALLTRIM(IIF(EMPTY(Razaos), rclis, Razaos)), 30)
            lcValpag = TRANSFORM(valors * 100, "@L 999999999999999")
            lnValtot = lnValtot + valors
            lcBarra  = ALLTRIM(CHRTRAN(barras, "/.-", "")) + REPLICATE("0", 44)
            lcBarra  = SUBSTR(lcBarra, 1, 4) + SUBSTR(lcBarra, 33, 15) + SUBSTR(lcBarra, 5, 5) + SUBSTR(lcBarra, 11, 10) + SUBSTR(lcBarra, 22, 10)
            lcChave  = PADR(ALLTRIM(titulos), 10) + lcnopers
            lcNossoNum = ALLTRIM(STR(fGerUniqueKey("BRNOSSONUM")))
            REPLACE nossoNum WITH PADL(lcNossoNum, 10, "0") IN (par_cCursor)
            lnSeql = lnSeql + 1
            lcSeql = TRANSFORM(lnSeql, "@L 99999")
            lnSeq  = lnSeq + 1

            lcJ001a003 = par_cBanco
            lcJ004a007 = lcLot
            lcJ008a008 = "3"
            lcJ009a013 = lcSeql
            lcJ014a014 = "J"
            lcJ015a017 = "000"
            lcJ018a061 = lcBarra
            lcJ062a091 = lcnome
            lcJ092a099 = lcvenc
            lcJ100a114 = lcValpag
            lcJ115a129 = "000000000000000"
            lcJ130a144 = "000000000000000"
            lcJ145a152 = lcvenc
            lcJ153a167 = lcValpag
            lcJ168a182 = "000000000000000"
            lcJ183a202 = lcChave
            lcJ203a215 = SPACE(13)
            lcJ216a230 = SPACE(15)
            lcJ231a240 = SPACE(10)

            lcstrg = lcJ001a003+lcJ004a007+lcJ008a008+lcJ009a013+lcJ014a014+ ;
                     lcJ015a017+lcJ018a061+lcJ062a091+lcJ092a099+lcJ100a114+ ;
                     lcJ115a129+lcJ130a144+lcJ145a152+lcJ153a167+lcJ168a182+ ;
                     lcJ183a202+lcJ203a215+lcJ216a230+lcJ231a240+CHR(13)+CHR(10)
            lcstrg = fLimpaTexto(lcstrg)
            STRTOFILE(lcstrg, lcArq, 1)

            loc_oBO.RegistrarLinhaArquivo("C", nopers, lcstrg, titulos, lcChave)
            SELECT (par_cCursor)
        ENDSCAN

        lnSeq = lnSeq + 1
        lnSeql = lnSeql + 1
        lcSeql = TRANSFORM(lnSeql, "@L 999999")
        lnQlote = lnQlote + 1
        lcQlote = TRANSFORM(lnQlote, "@L 999999")
        LOCAL lcValtotStr
        lcValtotStr = TRANSFORM(lnValtot * 100, "@L 999999999999999999")
        LOCAL lcTL001a003, lcTL004a007, lcTL008a008, lcTL009a017, lcTL018a023
        LOCAL lcTL024a041, lcTL042a059, lcTL060a230, lcTL231a240
        lcTL001a003 = par_cBanco
        lcTL004a007 = lcLot
        lcTL008a008 = "5"
        lcTL009a017 = SPACE(9)
        lcTL018a023 = lcQlote
        lcTL024a041 = lcValtotStr
        lcTL042a059 = "000000000000000000"
        lcTL060a230 = SPACE(171)
        lcTL231a240 = SPACE(10)
        lcstrg = lcTL001a003+lcTL004a007+lcTL008a008+lcTL009a017+lcTL018a023+ ;
                 lcTL024a041+lcTL042a059+lcTL060a230+lcTL231a240+CHR(13)+CHR(10)
        lcstrg = fLimpaTexto(lcstrg)
        STRTOFILE(lcstrg, lcArq, 1)
    ENDPROC

    *==========================================================================
    * CnabBrasil - Stub para Banco do Brasil (nao implementado no original)
    *==========================================================================
    PROCEDURE CnabBrasil()
        MsgAviso("Gera" + CHR(231) + CHR(227) + "o CNAB para Banco do Brasil n" + CHR(227) + "o implementada nesta vers" + CHR(227) + "o.")
    ENDPROC

    *==========================================================================
    * CnabItau240Lote - Gera lote PIX para Itau (simplificado)
    * Parametros passados por valor para compatibilidade
    *==========================================================================
    PROTECTED PROCEDURE CnabItau240Lote(par_cBanco, par_cFormaPgto, ;
        lcLot, lnLot, lnSeq, lcSeq, lctpcgc, lcCgc, lcAgeE, lcCtaE, lcDigCE, ;
        lcRaz, lcEndesE, lcNumsE, lcComplE, lcCidaE, lcCepE, lcCep1E, lcEstaE, lcOco, ;
        lcArq, lcprot)

        *-- Processa lote PIX/Transferencia para Itau 240
        *-- Implementacao simplificada: delega ao lote CC com forma 45
        THIS.CnabItau240LoteCC(lcLot, lnLot, lnSeq, lcSeq, lctpcgc, lcCgc, lcAgeE, lcCtaE, lcDigCE, ;
            lcRaz, lcEndesE, lcNumsE, lcComplE, lcCidaE, lcCepE, lcCep1E, lcEstaE, lcOco, ;
            lcArq, lcprot, par_cFormaPgto, "crFiltroTr", par_cBanco)
    ENDPROC

    *==========================================================================
    * BtnBuscarClick - Executa busca com filtros atuais (equivalente ao Processar)
    * Form OPERACIONAL: "Buscar" = aplicar filtros e popular grid de operacoes
    *==========================================================================
    PROCEDURE BtnBuscarClick()
        LOCAL loc_oErro

        TRY
            THIS.ClickProcessar()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro BtnBuscarClick")
        ENDTRY
    ENDPROC

    *==========================================================================
    * BtnEncerrarClick - Fecha o formulario
    *==========================================================================
    PROCEDURE BtnEncerrarClick()
        LOCAL loc_oErro

        TRY
            THIS.Release()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro BtnEncerrarClick")
        ENDTRY
    ENDPROC

    *==========================================================================
    * BtnSalvarClick - Gera arquivo CNAB (modo "A" = arquivo real)
    * Form OPERACIONAL: "Salvar" = gerar arquivo CNAB para os registros marcados
    *==========================================================================
    PROCEDURE BtnSalvarClick()
        LOCAL loc_oErro

        TRY
            IF !USED("cursor_4c_Filtro") OR RECCOUNT("cursor_4c_Filtro") = 0
                MsgAviso("Nenhuma opera" + CHR(231) + CHR(227) + "o dispon" + CHR(237) + ;
                         "vel para gera" + CHR(231) + CHR(227) + "o." + CHR(13) + ;
                         "Execute o processamento primeiro.", "Aviso")
                RETURN
            ENDIF

            THIS.ClickGerarCNAB()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro BtnSalvarClick")
        ENDTRY
    ENDPROC

    *==========================================================================
    * BtnCancelarClick - Volta para pagina de filtros / cancela operacao atual
    * Form OPERACIONAL: "Cancelar" = retornar a pagina de filtros sem gerar arquivo
    *==========================================================================
    PROCEDURE BtnCancelarClick()
        LOCAL loc_oErro

        TRY
            THIS.AlternarPagina(1)
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro BtnCancelarClick")
        ENDTRY
    ENDPROC

    *==========================================================================
    * FormParaBO - Copia filtros do form para o Business Object
    * Form OPERACIONAL: passa parametros de busca para o BO usar em queries
    *==========================================================================
    PROCEDURE FormParaBO()
        LOCAL loc_oP1, loc_oBO

        loc_oP1 = THIS.pgf_4c_Principal.pgfiltro
        loc_oBO = THIS.this_oBusinessObject

        loc_oBO.this_cCdEmpresa     = ALLTRIM(loc_oP1.txt_4c_CdEmpresa.Value)
        loc_oBO.this_cDsEmpresa     = ALLTRIM(loc_oP1.txt_4c_DsEmpresa.Value)
        loc_oBO.this_dDatai         = loc_oP1.txt_4c_Datai.Value
        loc_oBO.this_dDataf         = loc_oP1.txt_4c_Dataf.Value
        loc_oBO.this_cCdConta       = ALLTRIM(loc_oP1.txt_4c_CdConta.Value)
        loc_oBO.this_cDsConta       = ALLTRIM(loc_oP1.txt_4c_DsConta.Value)
        loc_oBO.this_cCdEmpConvenio = ALLTRIM(loc_oP1.txt_4c_CdEmpConv.Value)
        loc_oBO.this_cDsEmpConvenio = ALLTRIM(loc_oP1.txt_4c_DsEmpConv.Value)
        loc_oBO.this_nProcessados   = loc_oP1.opt_4c_Processados.Value
        loc_oBO.this_nPeriodo       = loc_oP1.opt_4c_Periodo.Value
    ENDPROC

    *==========================================================================
    * BOParaForm - Preenche campos do form a partir do Business Object
    * Form OPERACIONAL: restaura filtros salvos no BO de volta para a tela
    *==========================================================================
    PROCEDURE BOParaForm()
        LOCAL loc_oP1, loc_oBO

        loc_oP1 = THIS.pgf_4c_Principal.pgfiltro
        loc_oBO = THIS.this_oBusinessObject

        loc_oP1.txt_4c_CdEmpresa.Value    = loc_oBO.this_cCdEmpresa
        loc_oP1.txt_4c_DsEmpresa.Value    = loc_oBO.this_cDsEmpresa
        loc_oP1.txt_4c_Datai.Value        = loc_oBO.this_dDatai
        loc_oP1.txt_4c_Dataf.Value        = loc_oBO.this_dDataf
        loc_oP1.txt_4c_CdConta.Value      = loc_oBO.this_cCdConta
        loc_oP1.txt_4c_DsConta.Value      = loc_oBO.this_cDsConta
        loc_oP1.txt_4c_CdEmpConv.Value    = loc_oBO.this_cCdEmpConvenio
        loc_oP1.txt_4c_DsEmpConv.Value    = loc_oBO.this_cDsEmpConvenio
        loc_oP1.opt_4c_Processados.Value  = IIF(loc_oBO.this_nProcessados = 2, 2, 1)
        loc_oP1.opt_4c_Periodo.Value      = IIF(loc_oBO.this_nPeriodo = 2, 2, 1)
    ENDPROC

    *==========================================================================
    * HabilitarCampos - Habilita ou desabilita campos de filtro
    * par_lHabilitar: .T. = habilitar (edicao), .F. = desabilitar (somente leitura)
    *==========================================================================
    PROCEDURE HabilitarCampos(par_lHabilitar)
        LOCAL loc_oP1

        loc_oP1 = THIS.pgf_4c_Principal.pgfiltro

        loc_oP1.txt_4c_CdEmpresa.Enabled   = par_lHabilitar
        loc_oP1.txt_4c_DsEmpresa.Enabled   = par_lHabilitar
        loc_oP1.txt_4c_Datai.Enabled        = par_lHabilitar
        loc_oP1.txt_4c_Dataf.Enabled        = par_lHabilitar
        loc_oP1.txt_4c_CdConta.Enabled     = par_lHabilitar
        loc_oP1.txt_4c_DsConta.Enabled     = par_lHabilitar
        loc_oP1.txt_4c_CdEmpConv.Enabled   = par_lHabilitar
        loc_oP1.txt_4c_DsEmpConv.Enabled   = par_lHabilitar
        loc_oP1.opt_4c_Processados.Enabled = par_lHabilitar
        loc_oP1.opt_4c_Periodo.Enabled     = par_lHabilitar
        loc_oP1.grd_4c_Grupos.Enabled      = par_lHabilitar
        loc_oP1.cgp_4c_MarcaFiltro.Enabled = par_lHabilitar
        loc_oP1.cgp_4c_Filtro.Command1.Enabled = par_lHabilitar
    ENDPROC

    *==========================================================================
    * LimparCampos - Zera todos os campos de filtro e o grid de dados
    *==========================================================================
    PROCEDURE LimparCampos()
        LOCAL loc_oP1, loc_oP2

        loc_oP1 = THIS.pgf_4c_Principal.pgfiltro
        loc_oP2 = THIS.pgf_4c_Principal.pgdados

        loc_oP1.txt_4c_CdEmpresa.Value  = ""
        loc_oP1.txt_4c_DsEmpresa.Value  = ""
        loc_oP1.txt_4c_Datai.Value      = {}
        loc_oP1.txt_4c_Dataf.Value      = {}
        loc_oP1.txt_4c_CdConta.Value    = ""
        loc_oP1.txt_4c_DsConta.Value    = ""
        loc_oP1.txt_4c_CdEmpConv.Value  = ""
        loc_oP1.txt_4c_DsEmpConv.Value  = ""
        loc_oP1.opt_4c_Processados.Value = 1
        loc_oP1.opt_4c_Periodo.Value     = 1

        *-- Desmarca todos os grupos
        IF USED("cursor_4c_Grupos")
            SELECT cursor_4c_Grupos
            REPLACE ALL marca WITH .F.
            GO TOP
            loc_oP1.grd_4c_Grupos.Refresh()
        ENDIF

        *-- Limpa grid de dados
        loc_oP2.grd_4c_Dados.RecordSource = ""
        loc_oP2.grd_4c_Dados.Refresh()

        *-- Fecha cursores de resultado anterior
        LOCAL loc_i
        LOCAL loc_aCur(9)
        loc_aCur(1) = "cursor_4c_Filtro"
        loc_aCur(2) = "crFiltro2"
        loc_aCur(3) = "crFiltro3"
        loc_aCur(4) = "crFiltro4"
        loc_aCur(5) = "crFiltro5"
        loc_aCur(6) = "crFiltro6"
        loc_aCur(7) = "crFiltroTr"
        loc_aCur(8) = "crFiltro20"
        loc_aCur(9) = "crErro"
        FOR loc_i = 1 TO ALEN(loc_aCur)
            IF USED(loc_aCur[loc_i])
                USE IN (loc_aCur[loc_i])
            ENDIF
        ENDFOR

        *-- Desabilita botoes de acao (nao ha dados ainda)
        loc_oP2.cgp_4c_Acoes.Command2.Enabled = .F.
        loc_oP2.cgp_4c_Acoes.Command3.Enabled = .F.

        loc_oP1.txt_4c_CdEmpresa.SetFocus()
    ENDPROC

    *==========================================================================
    * CarregarLista - Executa o processamento e exibe resultados no grid
    * Form OPERACIONAL: "CarregarLista" = executar filtros e popular grid de operacoes
    * Requer que os filtros estejam preenchidos (empresa, periodo, banco)
    *==========================================================================
    PROCEDURE CarregarLista()
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        TRY
            IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
                loc_lSucesso = .T.
            ENDIF

            THIS.ClickProcessar()
            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro CarregarLista")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * AjustarBotoesPorModo - Ajusta estado dos botoes de acao conforme estado atual
    * par_cModo: "FILTRO" = em filtros (sem dados), "DADOS" = exibindo resultados
    *==========================================================================
    PROCEDURE AjustarBotoesPorModo(par_cModo)
        LOCAL loc_oP2, loc_lTemDados

        loc_oP2 = THIS.pgf_4c_Principal.pgdados
        loc_lTemDados = USED("cursor_4c_Filtro") AND RECCOUNT("cursor_4c_Filtro") > 0

        DO CASE
            CASE UPPER(par_cModo) = "FILTRO"
                *-- Na pagina de filtros: habilitar edicao dos campos
                THIS.HabilitarCampos(.T.)
                *-- Botoes de acao CNAB permanecem como estao (so ativam apos Processar)
            CASE UPPER(par_cModo) = "DADOS"
                *-- Na pagina de dados: botao Gerar CNAB habilitado se ha dados
                loc_oP2.cgp_4c_Acoes.Command1.Enabled = loc_lTemDados
                *-- Relatorio e Boleto ficam habilitados conforme dados
                loc_oP2.cgp_4c_Acoes.Command2.Enabled = loc_lTemDados
                loc_oP2.cgp_4c_Acoes.Command3.Enabled = .F.
        ENDCASE
    ENDPROC

    *==========================================================================
    * Destroy - Limpa recursos ao fechar o form
    *==========================================================================
    PROCEDURE Destroy()
        LOCAL loc_i
        LOCAL loc_aCursores(16)
        loc_aCursores(1)  = "cursor_4c_Filtro"
        loc_aCursores(2)  = "cursor_4c_Grupos"
        loc_aCursores(3)  = "cursor_4c_Empresa"
        loc_aCursores(4)  = "cursor_4c_Convenio"
        loc_aCursores(5)  = "cursor_4c_BancoIgual"
        loc_aCursores(6)  = "cursor_4c_BancoDif"
        loc_aCursores(7)  = "crFiltro2"
        loc_aCursores(8)  = "crFiltro3"
        loc_aCursores(9)  = "crFiltro4"
        loc_aCursores(10) = "crFiltro5"
        loc_aCursores(11) = "crFiltro6"
        loc_aCursores(12) = "crFiltroTr"
        loc_aCursores(13) = "crFiltro20"
        loc_aCursores(14) = "crErro"
        loc_aCursores(15) = "cursor_4c_CabRel"
        loc_aCursores(16) = "cursor_4c_Filtro2Rel"
        FOR loc_i = 1 TO ALEN(loc_aCursores)
            IF USED(loc_aCursores[loc_i])
                USE IN (loc_aCursores[loc_i])
            ENDIF
        ENDFOR

        THIS.this_oBusinessObject = .NULL.
        DODEFAULT()
    ENDPROC

ENDDEFINE


### BO (C:\4c\projeto\app\classes\SIGPGCNBBO.prg):
*==============================================================================
* SIGPGCNBBO.prg - Business Object para Geracao de Arquivos CNAB - Pagamentos
* Data: 2026-06-19
* Tabela principal: SigPcOol | PK: cidchaves
* Tabela de operacoes: SigMvCcr (leitura) | SigCdCeb (convenios)
*==============================================================================

DEFINE CLASS SIGPGCNBBO AS BusinessBase

    *-- -----------------------------------------------------------------------
    *-- FILTROS DE TELA (pgfiltro)
    *-- -----------------------------------------------------------------------

    *-- Empresa (get_cd_empresa / get_ds_empresa)
    this_cCdEmpresa        = ""    && Emps     CHAR(3)  - C" + CHR(243) + "digo empresa
    this_cDsEmpresa        = ""    && RazSocs  CHAR(40) - Raz" + CHR(227) + "o social

    *-- Per" + CHR(237) + "odo (Get_Datai / Get_Dataf)
    this_dDatai            = {}    && Per" + CHR(237) + "odo inicial
    this_dDataf            = {}    && Per" + CHR(237) + "odo final

    *-- Op" + CHR(231) + CHR(227) + "o processados (optProcessados: 1=N" + CHR(227) + "o Processados, 2=J" + CHR(225) + " Processados)
    this_nProcessados      = 1

    *-- Op" + CHR(231) + CHR(227) + "o per" + CHR(237) + "odo (optPeriodo: 1=Vencimento, 2=Emiss" + CHR(227) + "o)
    this_nPeriodo          = 1

    *-- Conta banc" + CHR(225) + "ria (get_cd_car_conta / get_ds_car_conta)
    this_cCdConta          = ""    && IClis / GruContas CHAR(10) - C" + CHR(243) + "digo conta
    this_cDsConta          = ""    && Descri" + CHR(231) + CHR(227) + "o da conta CHAR(40)

    *-- Empresa do conv" + CHR(234) + "nio (getCEmpc / getDEmpc)
    this_cCdEmpConvenio    = ""    && Cemps    CHAR(3)  - C" + CHR(243) + "digo empresa conv" + CHR(234) + "nio
    this_cDsEmpConvenio    = ""    && RazSocs  CHAR(40) - Descri" + CHR(231) + CHR(227) + "o empresa conv" + CHR(234) + "nio

    *-- -----------------------------------------------------------------------
    *-- ESTADO DO PROCESSAMENTO (pgdados)
    *-- -----------------------------------------------------------------------

    *-- Spinner dias protesto (spndias, default=5)
    this_nDiasProt         = 5     && DiasProts NUMERIC - Dias para protestos

    *-- Caminho do arquivo CNAB gerado
    this_cArquivoCNAB      = ""    && Drive + ArqCnabs - Caminho completo do .REM

    *-- C" + CHR(243) + "digo do banco do conv" + CHR(234) + "nio ativo (ex: "001", "341", "237", "033")
    this_cBancoNr          = ""    && nbancos CHAR(3) - C" + CHR(243) + "digo banco FEBRABAN

    *-- -----------------------------------------------------------------------
    *-- REGISTRO DE PROCESSAMENTO (SigPcOol)
    *-- -----------------------------------------------------------------------

    *-- Campos da tabela SigPcOol (usados em INSERT)
    this_cDopes            = ""    && dopes     CHAR    - Tipo operacao ('C' = CNAB)
    this_nNopers           = 0     && nopers    NUMERIC - N" + CHR(250) + "mero operacao de SigMvCcr
    this_cUsuars           = ""    && usuars    CHAR    - Usu" + CHR(225) + "rio que gerou
    this_cTipos            = ""    && tipos     CHAR    - Identificador ('SIGPGCNB')
    this_cProcessos        = ""    && processos CHAR    - Processo ('CNAB')
    this_cProdutos         = ""    && produtos  MEMO    - Conte" + CHR(250) + "do do arquivo gerado
    this_dDataS            = {}    && DataS     DATETIME - Data/hora de geracao
    this_cCidChaves        = ""    && cidchaves CHAR    - Chave " + CHR(250) + "nica (PK)
    this_cDopeds           = ""    && dopeds    CHAR    - Referencia doc (titulo)
    this_cEdndests         = ""    && edndests  CHAR    - Chave destino (titulo+nopers)

    *-- -----------------------------------------------------------------------
    *-- DADOS DO CONVENIO BANCARIO (SigCdCeb - carregado em geracnab)
    *-- -----------------------------------------------------------------------
    this_cConvenio         = ""    && Convenios  CHAR - C" + CHR(243) + "digo conv" + CHR(234) + "nio
    this_cAgencia          = ""    && NAgencias  CHAR - Ag" + CHR(234) + "ncia empresa
    this_cDigitoAgencia    = ""    && DigiAgen   CHAR - D" + CHR(237) + "gito ag" + CHR(234) + "ncia
    this_cContaConv        = ""    && contas     CHAR - Conta do conv" + CHR(234) + "nio
    this_cArqCnabs         = ""    && ArqCnabs   CHAR - Nome base do arquivo
    this_cDrive            = ""    && Drive      CHAR - Drive de destino
    this_cTpCtArq          = ""    && TpCtArqs   CHAR - Tipo conta arquivo
    this_cTpCtBol          = ""    && TpCtBols   CHAR - Tipo conta boleto
    this_cBancos           = ""    && bancos     CHAR - Raz" + CHR(227) + "o social banco

    *-- -----------------------------------------------------------------------
    *-- DADOS DA EMPRESA (SigCdEmp - carregado em geracnab)
    *-- -----------------------------------------------------------------------
    this_cRazSocs          = ""    && RazSocs   CHAR - Raz" + CHR(227) + "o social empresa
    this_cCgcs             = ""    && Cgcs      CHAR - CNPJ/CPF empresa
    this_cEndesEmp         = ""    && Endes     CHAR - Endere" + CHR(231) + "o empresa
    this_cNumerosEmp       = ""    && Numeros   CHAR - N" + CHR(250) + "mero endere" + CHR(231) + "o
    this_cComplsEmp        = ""    && Compls    CHAR - Complemento
    this_cBairsEmp         = ""    && Bairs     CHAR - Bairro
    this_cCidasEmp         = ""    && Cidas     CHAR - Cidade
    this_cCepsEmp          = ""    && Ceps      CHAR - CEP
    this_cEstasEmp         = ""    && Estas     CHAR - Estado (UF)

    *--------------------------------------------------------------------------
    * Init - Inicializa o Business Object
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        DODEFAULT()
        THIS.this_cTabela     = "SigPcOol"
        THIS.this_cCampoChave = "cidchaves"
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Retorna a chave primaria do registro atual
    * Usado pelo sistema de auditoria do BusinessBase
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ObterChavePrimaria()
        RETURN THIS.this_cCidChaves
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Mapeia colunas do cursor para propriedades do BO
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        IF USED(par_cAliasCursor)
            SELECT (par_cAliasCursor)
            THIS.this_cCidChaves  = TratarNulo(cidchaves, "C")
            THIS.this_cDopes      = TratarNulo(dopes, "C")
            THIS.this_nNopers     = TratarNulo(nopers, "N")
            THIS.this_cUsuars     = TratarNulo(usuars, "C")
            THIS.this_cTipos      = TratarNulo(tipos, "C")
            THIS.this_cProcessos  = TratarNulo(processos, "C")
            THIS.this_cProdutos   = TratarNulo(produtos, "C")
            THIS.this_cDopeds     = TratarNulo(dopeds, "C")
            THIS.this_cEdndests   = TratarNulo(edndests, "C")
            IF TYPE("DataS") != "U"
                THIS.this_dDataS  = TratarNulo(DataS, "D")
            ENDIF
            loc_lSucesso = .T.
        ENDIF
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir - Insere um registro de processamento CNAB em SigPcOol
    * Chamado para cada linha/segmento gerado durante geracao do arquivo CNAB
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Inserir()
        LOCAL loc_lSucesso, loc_cSQL, loc_oErro
        LOCAL loc_cProdutos
        loc_lSucesso = .F.
        TRY
            THIS.this_cCidChaves = ALLTRIM(fUniqueIds())
            THIS.this_cUsuars    = ALLTRIM(gc_4c_UsuarioLogado)
            THIS.this_cTipos     = "SIGPGCNB"
            THIS.this_cProcessos = "CNAB"

            loc_cProdutos = THIS.this_cProdutos

            loc_cSQL = "INSERT INTO SigPcOol " + ;
                       "(dopes, nopers, usuars, tipos, processos, produtos, DataS, cidchaves, dopeds, edndests)" + ;
                       " VALUES (" + ;
                       EscaparSQL(THIS.this_cDopes) + ", " + ;
                       FormatarNumeroSQL(THIS.this_nNopers) + ", " + ;
                       EscaparSQL(THIS.this_cUsuars) + ", " + ;
                       EscaparSQL(THIS.this_cTipos) + ", " + ;
                       EscaparSQL(THIS.this_cProcessos) + ", " + ;
                       "?loc_cProdutos, " + ;
                       "GETDATE(), " + ;
                       EscaparSQL(THIS.this_cCidChaves) + ", " + ;
                       EscaparSQL(THIS.this_cDopeds) + ", " + ;
                       EscaparSQL(THIS.this_cEdndests) + ")"

            IF SQLEXEC(gnConnHandle, loc_cSQL) >= 1
                THIS.RegistrarAuditoria("INSERT")
                loc_lSucesso = .T.
            ELSE
                MostrarErro("Erro ao inserir registro em SigPcOol." + CHR(13) + ;
                            CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MostrarErro("Erro ao inserir em SigPcOol:" + CHR(13) + ;
                        loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - Atualiza registro de processamento CNAB em SigPcOol
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Atualizar()
        LOCAL loc_lSucesso, loc_cSQL, loc_oErro
        LOCAL loc_cProdutos
        loc_lSucesso = .F.
        TRY
            loc_cProdutos = THIS.this_cProdutos

            loc_cSQL = "UPDATE SigPcOol" + ;
                       " SET dopes     = " + EscaparSQL(THIS.this_cDopes) + ;
                       ",    nopers    = " + FormatarNumeroSQL(THIS.this_nNopers) + ;
                       ",    usuars    = " + EscaparSQL(THIS.this_cUsuars) + ;
                       ",    tipos     = " + EscaparSQL(THIS.this_cTipos) + ;
                       ",    processos = " + EscaparSQL(THIS.this_cProcessos) + ;
                       ",    produtos  = ?loc_cProdutos" + ;
                       ",    dopeds    = " + EscaparSQL(THIS.this_cDopeds) + ;
                       ",    edndests  = " + EscaparSQL(THIS.this_cEdndests) + ;
                       " WHERE cidchaves = " + EscaparSQL(THIS.this_cCidChaves)

            IF SQLEXEC(gnConnHandle, loc_cSQL) >= 1
                THIS.RegistrarAuditoria("UPDATE")
                loc_lSucesso = .T.
            ELSE
                MostrarErro("Erro ao atualizar registro em SigPcOol." + CHR(13) + ;
                            CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MostrarErro("Erro ao atualizar em SigPcOol:" + CHR(13) + ;
                        loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * BuscarGrupos - Carrega grupos de fornecedores (SigCdGcr) para grid filtro
    * Cria cursor_4c_Grupos com campos: codigos, descrs, marca (bool=.F.)
    *--------------------------------------------------------------------------
    PROCEDURE BuscarGrupos()
        LOCAL loc_lSucesso, loc_cSQL, loc_oErro, loc_lFalso
        loc_lSucesso = .F.
        TRY
            IF USED("cursor_4c_GruposTemp")
                USE IN cursor_4c_GruposTemp
            ENDIF
            loc_lFalso = .F.
            loc_cSQL = "SELECT Codigos, Descrs, ?loc_lFalso AS marca FROM SigCdGcr" + ;
                       " WHERE PadPgRecs IN (4,2) ORDER BY Codigos"
            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_GruposTemp") >= 1
                IF USED("cursor_4c_Grupos")
                    USE IN cursor_4c_Grupos
                ENDIF
                SET NULL ON
                CREATE CURSOR cursor_4c_Grupos (codigos C(9) NULL, descrs C(40) NULL, marca L NULL)
                SET NULL OFF
                SELECT cursor_4c_Grupos
                APPEND FROM DBF("cursor_4c_GruposTemp")
                SELECT cursor_4c_Grupos
                GO TOP
                loc_lSucesso = .T.
            ELSE
                MostrarErro("Erro ao carregar grupos de fornecedores." + CHR(13) + ;
                            CapturarErroSQL(), "Erro SQL")
            ENDIF
            IF USED("cursor_4c_GruposTemp")
                USE IN cursor_4c_GruposTemp
            ENDIF
        CATCH TO loc_oErro
            MostrarErro("Erro em BuscarGrupos:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * BuscarOperacoes - Consulta operacoes de pagamento em SigMvCcr
    * Parametros:
    *   par_cCodEmp        - Codigo da empresa
    *   par_cCodConta      - Codigo da conta bancaria (get_cd_car_conta)
    *   par_dDatai         - Data inicial do periodo
    *   par_dDataf         - Data final do periodo
    *   par_lNaoProc       - .T.=Nao Processados, .F.=Ja Processados
    *   par_nPeriodo       - 1=Vencimento, 2=Emissao
    *   par_cGrupos        - Lista SQL de grupos marcados: ('GR1','GR2',...)
    * Cria cursor_4c_Filtro com registros de SigMvCcr+SigCdCli
    *--------------------------------------------------------------------------
    PROCEDURE BuscarOperacoes(par_cCodEmp, par_cCodConta, par_dDatai, par_dDataf, ;
                               par_lNaoProc, par_nPeriodo, par_cGrupos)
        LOCAL loc_lSucesso, loc_cSQL, loc_cCampoPeriodo, loc_cNaoProc, loc_oErro
        LOCAL loc_dDatai, loc_dDataf, loc_lFalso
        loc_lSucesso = .F.
        TRY
            loc_dDatai = par_dDatai
            loc_dDataf = par_dDataf
            loc_lFalso = .F.

            IF par_nPeriodo = 1
                loc_cCampoPeriodo = "a.Vencs"
            ELSE
                loc_cCampoPeriodo = "a.Datas"
            ENDIF

            IF par_lNaoProc
                loc_cNaoProc = "NOT "
            ELSE
                loc_cNaoProc = ""
            ENDIF

            IF USED("cursor_4c_FiltroTemp")
                USE IN cursor_4c_FiltroTemp
            ENDIF

            loc_cSQL = "SELECT ?loc_lFalso AS marca, a.emps, a.datas, a.vencs, a.Valors, " + ;
                       "a.moedas, a.Hists + a.Titulos + a.Nfs AS histo, b.rclis, b.iclis, " + ;
                       "a.Grupos, a.contas, a.Nopers, a.Tipos, " + ;
                       "a.Contapgs, a.Dopes, a.ValPags, a.GruConMoes, a.Opers, " + ;
                       "a.cotacaos, a.cotusus, a.GrupEms, " + ;
                       "a.ContEms, a.GrupAges, a.ContAges, a.EmpDopNcs, a.Pagos, a.Titulos, a.Nfs, " + ;
                       "b.razaos, b.cpfs, b.endes, b.nums, b.bairs, b.cidas, b.ceps, b.estas, " + ;
                       "b.compls, b.tipochv, b.chvpix " + ;
                       "FROM SigMvCcr a, SigCdCli b " + ;
                       "WHERE a.pagos = 1 " + ;
                       "AND a.ContaPgs != 2 " + ;
                       "AND a.opers = 'C' " + ;
                       "AND " + loc_cCampoPeriodo + " BETWEEN ?loc_dDatai AND ?loc_dDataf " + ;
                       "AND a.Nopers <> 0 " + ;
                       "AND a.emps = " + EscaparSQL(par_cCodEmp) + " " + ;
                       "AND a.cidchaves IN (" + ;
                           "SELECT cidchaves FROM SigMvCcr " + ;
                           "WHERE grupos IN " + par_cGrupos + " " + ;
                           "AND " + loc_cCampoPeriodo + " BETWEEN ?loc_dDatai AND ?loc_dDataf" + ;
                       ") " + ;
                       "AND a.grupos = b.grupos " + ;
                       "AND a.contas = b.iclis " + ;
                       "AND a.nopers " + loc_cNaoProc + ;
                       "IN (SELECT e.nopers FROM SigPcOol e WHERE e.Tipos = 'SIGPGCNB' AND e.dopes = 'C') " + ;
                       "ORDER BY a.emps, " + loc_cCampoPeriodo

            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_FiltroTemp") >= 1
                IF USED("cursor_4c_Filtro")
                    IF USED("cursor_4c_Filtro")
                        TABLEREVERT(.T., "cursor_4c_Filtro")
                        USE IN cursor_4c_Filtro
                    ENDIF
                ENDIF
                SET NULL ON
                CREATE CURSOR cursor_4c_Filtro (marca L NULL, emps C(3) NULL, ;
                    datas D NULL, vencs D NULL, Valors N(14,2) NULL, moedas C(6) NULL, ;
                    histo C(60) NULL, rclis C(40) NULL, iclis C(10) NULL, ;
                    Grupos C(6) NULL, contas C(10) NULL, Nopers N(10,0) NULL, ;
                    Tipos C(6) NULL, Contapgs N(1,0) NULL, Dopes C(6) NULL, ;
                    ValPags N(14,2) NULL, GruConMoes C(6) NULL, Opers C(6) NULL, ;
                    cotacaos N(14,6) NULL, cotusus C(10) NULL, GrupEms C(6) NULL, ;
                    ContEms C(10) NULL, GrupAges C(6) NULL, ContAges C(10) NULL, ;
                    EmpDopNcs C(9) NULL, Pagos N(1,0) NULL, Titulos C(10) NULL, ;
                    Nfs C(9) NULL, razaos C(40) NULL, cpfs C(20) NULL, ;
                    endes C(40) NULL, nums C(6) NULL, bairs C(20) NULL, ;
                    cidas C(20) NULL, ceps C(9) NULL, estas C(2) NULL, ;
                    compls C(15) NULL, tipochv C(2) NULL, chvpix C(50) NULL)
                SET NULL OFF
                SELECT cursor_4c_Filtro
                APPEND FROM DBF("cursor_4c_FiltroTemp")
                SELECT cursor_4c_Filtro
                GO TOP
                loc_lSucesso = .T.
            ELSE
                MostrarErro("Erro ao buscar opera" + CHR(231) + CHR(245) + "es." + CHR(13) + ;
                            CapturarErroSQL(), "Erro SQL")
            ENDIF
            IF USED("cursor_4c_FiltroTemp")
                USE IN cursor_4c_FiltroTemp
            ENDIF
        CATCH TO loc_oErro
            MostrarErro("Erro em BuscarOperacoes:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * BuscarEmpresa - Carrega dados da empresa para geracao CNAB (SigCdEmp)
    * Parametro: par_cCodEmpConvenio - Codigo da empresa do convenio (Cemps)
    * Cria cursor_4c_Empresa com: RazSocs, Cgcs, Tel1s, Ceps, Endes, Numeros,
    *                              Bairs, Cidas, Estas, Compls
    *--------------------------------------------------------------------------
    PROCEDURE BuscarEmpresa(par_cCodEmpConvenio)
        LOCAL loc_lSucesso, loc_cSQL, loc_oErro
        LOCAL loc_cCodEmp
        loc_lSucesso = .F.
        TRY
            loc_cCodEmp = ALLTRIM(par_cCodEmpConvenio)
            IF USED("cursor_4c_EmpresaTemp")
                USE IN cursor_4c_EmpresaTemp
            ENDIF
            loc_cSQL = "SELECT RazSocs, Cgcs, Tel1s, Ceps, Endes, Numeros," + ;
                       " Bairs, Cidas, Estas, Compls" + ;
                       " FROM SigCdEmp WHERE Cemps = " + EscaparSQL(loc_cCodEmp)
            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_EmpresaTemp") >= 1
                IF USED("cursor_4c_Empresa")
                    USE IN cursor_4c_Empresa
                ENDIF
                SET NULL ON
                CREATE CURSOR cursor_4c_Empresa (RazSocs C(40) NULL, Cgcs C(20) NULL, ;
                    Tel1s C(14) NULL, Ceps C(9) NULL, Endes C(40) NULL, ;
                    Numeros C(6) NULL, Bairs C(20) NULL, Cidas C(20) NULL, ;
                    Estas C(2) NULL, Compls C(15) NULL)
                SET NULL OFF
                SELECT cursor_4c_Empresa
                APPEND FROM DBF("cursor_4c_EmpresaTemp")
                SELECT cursor_4c_Empresa
                GO TOP
                loc_lSucesso = !EOF("cursor_4c_Empresa")
            ELSE
                MostrarErro("Erro ao carregar dados da empresa " + loc_cCodEmp + "." + CHR(13) + ;
                            CapturarErroSQL(), "Erro SQL")
            ENDIF
            IF USED("cursor_4c_EmpresaTemp")
                USE IN cursor_4c_EmpresaTemp
            ENDIF
        CATCH TO loc_oErro
            MostrarErro("Erro em BuscarEmpresa:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * BuscarConvenio - Carrega dados do convenio bancario (SigCdCeb)
    * Parametros:
    *   par_cGruContas - Grupos+Contas concatenado (ex: crBancos.Grupos + lcconta)
    * Cria cursor_4c_Convenio com dados do SigCdCeb
    *--------------------------------------------------------------------------
    PROCEDURE BuscarConvenio(par_cGruContas)
        LOCAL loc_lSucesso, loc_cSQL, loc_oErro
        LOCAL loc_cGruContas
        loc_lSucesso = .F.
        TRY
            loc_cGruContas = ALLTRIM(par_cGruContas)
            IF USED("cursor_4c_ConvenioTemp")
                USE IN cursor_4c_ConvenioTemp
            ENDIF
            loc_cSQL = "SELECT * FROM SigCdCeb" + ;
                       " WHERE GruContas = " + EscaparSQL(loc_cGruContas) + ;
                       " AND NAgencias != '' AND Convenios != ''" + ;
                       " ORDER BY NAgencias, Convenios"
            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ConvenioTemp") >= 1
                IF USED("cursor_4c_Convenio")
                    USE IN cursor_4c_Convenio
                ENDIF
                SELECT cursor_4c_ConvenioTemp
                SELECT *, " " AS placeHolder FROM cursor_4c_ConvenioTemp INTO CURSOR cursor_4c_Convenio READWRITE
                SELECT cursor_4c_Convenio
                GO TOP
                loc_lSucesso = !EOF("cursor_4c_Convenio")
            ELSE
                MostrarErro("Erro ao carregar conv" + CHR(234) + "nio bancario." + CHR(13) + ;
                            CapturarErroSQL(), "Erro SQL")
            ENDIF
            IF USED("cursor_4c_ConvenioTemp")
                USE IN cursor_4c_ConvenioTemp
            ENDIF
        CATCH TO loc_oErro
            MostrarErro("Erro em BuscarConvenio:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * BuscarContaBancaria - Carrega dados da conta do favorecido (SigCdCeb)
    * Parametros:
    *   par_cGruContas - Grupos+Contas do favorecido
    * Cria cursor_4c_ContaFav com dados do SigCdCeb
    *--------------------------------------------------------------------------
    PROCEDURE BuscarContaBancaria(par_cGruContas)
        LOCAL loc_lSucesso, loc_cSQL, loc_oErro
        LOCAL loc_cGruContas
        loc_lSucesso = .F.
        TRY
            loc_cGruContas = ALLTRIM(par_cGruContas)
            IF USED("cursor_4c_ContaFavTemp")
                USE IN cursor_4c_ContaFavTemp
            ENDIF
            loc_cSQL = "SELECT * FROM SigCdCeb" + ;
                       " WHERE GruContas = " + EscaparSQL(loc_cGruContas) + ;
                       " AND NAgencias != '' AND contas != '' AND nbancos != 0" + ;
                       " ORDER BY NAgencias"
            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ContaFavTemp") >= 1
                IF USED("cursor_4c_ContaFav")
                    USE IN cursor_4c_ContaFav
                ENDIF
                SELECT cursor_4c_ContaFavTemp
                SELECT * FROM cursor_4c_ContaFavTemp INTO CURSOR cursor_4c_ContaFav READWRITE
                SELECT cursor_4c_ContaFav
                GO TOP
                loc_lSucesso = .T.
            ELSE
                MostrarErro("Erro ao carregar conta do favorecido." + CHR(13) + ;
                            CapturarErroSQL(), "Erro SQL")
            ENDIF
            IF USED("cursor_4c_ContaFavTemp")
                USE IN cursor_4c_ContaFavTemp
            ENDIF
        CATCH TO loc_oErro
            MostrarErro("Erro em BuscarContaBancaria:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * BuscarContasBanco - Carrega contas do banco especificado (SigCdCeb)
    * Para buscaboleto: separa contas do mesmo banco vs outros bancos
    * Parametro: par_cBco - Codigo do banco FEBRABAN (ex: '341', '237', '033')
    * Cria cursor_4c_BancoIgual e cursor_4c_BancoDif
    *--------------------------------------------------------------------------
    PROCEDURE BuscarContasBanco(par_cBco)
        LOCAL loc_lSucesso, loc_cSQL, loc_oErro, loc_cBco
        loc_lSucesso = .F.
        TRY
            loc_cBco = ALLTRIM(par_cBco)
            IF USED("cursor_4c_BancoIgualTemp")
                USE IN cursor_4c_BancoIgualTemp
            ENDIF
            IF USED("cursor_4c_BancoDifTemp")
                USE IN cursor_4c_BancoDifTemp
            ENDIF
            loc_cSQL = "SELECT * FROM SigCdCeb WHERE nbancos = " + ALLTRIM(loc_cBco)
            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BancoIgualTemp") < 1
                MostrarErro("Erro ao carregar contas do banco " + loc_cBco + "." + CHR(13) + ;
                            CapturarErroSQL(), "Erro SQL")
            ELSE
                loc_cSQL = "SELECT * FROM SigCdCeb WHERE nbancos != " + ALLTRIM(loc_cBco)
                IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BancoDifTemp") < 1
                    MostrarErro("Erro ao carregar demais contas." + CHR(13) + ;
                                CapturarErroSQL(), "Erro SQL")
                ELSE
                    IF USED("cursor_4c_BancoIgual")
                        USE IN cursor_4c_BancoIgual
                    ENDIF
                    IF USED("cursor_4c_BancoDif")
                        USE IN cursor_4c_BancoDif
                    ENDIF
                    SELECT cursor_4c_BancoIgualTemp
                    SELECT * FROM cursor_4c_BancoIgualTemp INTO CURSOR cursor_4c_BancoIgual READWRITE
                    SELECT cursor_4c_BancoDifTemp
                    SELECT * FROM cursor_4c_BancoDifTemp INTO CURSOR cursor_4c_BancoDif READWRITE
                    loc_lSucesso = .T.
                ENDIF
            ENDIF
            IF USED("cursor_4c_BancoIgualTemp")
                USE IN cursor_4c_BancoIgualTemp
            ENDIF
            IF USED("cursor_4c_BancoDifTemp")
                USE IN cursor_4c_BancoDifTemp
            ENDIF
        CATCH TO loc_oErro
            MostrarErro("Erro em BuscarContasBanco:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * BuscarBarrasCcb - Busca codigo de barras de um titulo em SigMvCcb
    * Parametro: par_cFkChaves - chave fk (emps + str(nopers,10) + opers)
    * Retorna a string de barras ou "" se nao encontrado
    *--------------------------------------------------------------------------
    PROCEDURE BuscarBarrasCcb(par_cFkChaves)
        LOCAL loc_cBarras, loc_cSQL, loc_oErro
        LOCAL loc_cFkChaves
        loc_cBarras = ""
        TRY
            loc_cFkChaves = ALLTRIM(par_cFkChaves)
            IF USED("cursor_4c_BarraTemp")
                USE IN cursor_4c_BarraTemp
            ENDIF
            loc_cSQL = "SELECT ccb_bars FROM SigMvCcb WHERE fkchaves = " + ;
                       EscaparSQL(loc_cFkChaves)
            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BarraTemp") >= 1
                SELECT cursor_4c_BarraTemp
                GO TOP
                IF !EOF("cursor_4c_BarraTemp")
                    loc_cBarras = NVL(cursor_4c_BarraTemp.ccb_bars, "")
                ENDIF
            ENDIF
            IF USED("cursor_4c_BarraTemp")
                USE IN cursor_4c_BarraTemp
            ENDIF
        CATCH TO loc_oErro
            MostrarErro("Erro em BuscarBarrasCcb:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_cBarras
    ENDPROC

    *--------------------------------------------------------------------------
    * BuscarGruposContaCli - Carrega grupos de uma conta (SigCdCli)
    * Parametro: par_cIClis - Codigo da conta (IClis)
    * Retorna valor do campo Grupos ou ""
    *--------------------------------------------------------------------------
    PROCEDURE BuscarGruposContaCli(par_cIClis)
        LOCAL loc_cGrupos, loc_cSQL, loc_oErro
        LOCAL loc_cIClis
        loc_cGrupos = ""
        TRY
            loc_cIClis = ALLTRIM(par_cIClis)
            IF USED("cursor_4c_CliGrupoTemp")
                USE IN cursor_4c_CliGrupoTemp
            ENDIF
            loc_cSQL = "SELECT Grupos FROM SigCdCli WHERE IClis = " + EscaparSQL(loc_cIClis)
            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_CliGrupoTemp") >= 1
                SELECT cursor_4c_CliGrupoTemp
                GO TOP
                IF !EOF("cursor_4c_CliGrupoTemp")
                    loc_cGrupos = NVL(ALLTRIM(cursor_4c_CliGrupoTemp.Grupos), "")
                ENDIF
            ENDIF
            IF USED("cursor_4c_CliGrupoTemp")
                USE IN cursor_4c_CliGrupoTemp
            ENDIF
        CATCH TO loc_oErro
            MostrarErro("Erro em BuscarGruposContaCli:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_cGrupos
    ENDPROC

    *--------------------------------------------------------------------------
    * AtualizarTituloBanco - Atualiza titbans em SigMvCcr apos geracao CNAB
    * Parametros:
    *   par_nNopers - Numero da operacao
    *   par_cTitulo - Titulo banco para gravar (ex: 'TIT ITAU')
    *--------------------------------------------------------------------------
    PROCEDURE AtualizarTituloBanco(par_nNopers, par_cTitulo)
        LOCAL loc_lSucesso, loc_cSQL, loc_oErro
        LOCAL loc_nNopers
        loc_lSucesso = .F.
        TRY
            loc_nNopers = par_nNopers
            loc_cSQL = "UPDATE SigMvCcr SET titbans = " + EscaparSQL(par_cTitulo) + ;
                       " WHERE opers = 'C' AND nopers = ?loc_nNopers"
            IF SQLEXEC(gnConnHandle, loc_cSQL) >= 1
                loc_lSucesso = .T.
            ELSE
                MostrarErro("Erro ao atualizar t" + CHR(237) + "tulo banco." + CHR(13) + ;
                            CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MostrarErro("Erro em AtualizarTituloBanco:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * BuscarTituloBanco - Verifica titbans existente em SigMvCcr
    * Parametro: par_nNopers - Numero da operacao
    * Retorna o titbans atual ou ""
    *--------------------------------------------------------------------------
    PROCEDURE BuscarTituloBanco(par_nNopers)
        LOCAL loc_cTitulo, loc_cSQL, loc_oErro
        LOCAL loc_nNopers
        loc_cTitulo = ""
        TRY
            loc_nNopers = par_nNopers
            IF USED("cursor_4c_TitBanTemp")
                USE IN cursor_4c_TitBanTemp
            ENDIF
            loc_cSQL = "SELECT titulos, titbans FROM SigMvCcr WHERE opers = 'C' AND nopers = ?loc_nNopers"
            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_TitBanTemp") >= 1
                SELECT cursor_4c_TitBanTemp
                GO TOP
                IF !EOF("cursor_4c_TitBanTemp")
                    loc_cTitulo = NVL(ALLTRIM(cursor_4c_TitBanTemp.titbans), "")
                ENDIF
            ENDIF
            IF USED("cursor_4c_TitBanTemp")
                USE IN cursor_4c_TitBanTemp
            ENDIF
        CATCH TO loc_oErro
            MostrarErro("Erro em BuscarTituloBanco:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_cTitulo
    ENDPROC

    *--------------------------------------------------------------------------
    * GerarChaveUnica - Gera chave unica para cidchaves usando fUniqueIds()
    * Retorna a chave gerada como string
    *--------------------------------------------------------------------------
    PROCEDURE GerarChaveUnica()
        RETURN ALLTRIM(fUniqueIds())
    ENDPROC

    *--------------------------------------------------------------------------
    * RegistrarLinhaArquivo - Insere uma linha do arquivo CNAB em SigPcOol
    * Chamado pelas procedures de geracao CNAB no FormSIGPGCNB
    * Parametros:
    *   par_cDopes    - Tipo operacao ('C')
    *   par_nNopers   - Numero da operacao em SigMvCcr
    *   par_cProdutos - Conteudo da linha CNAB gerada
    *   par_cDopeds   - Referencia do documento (titulo)
    *   par_cEdndests - Chave destino (titulo+nopers)
    *--------------------------------------------------------------------------
    PROCEDURE RegistrarLinhaArquivo(par_cDopes, par_nNopers, par_cProdutos, par_cDopeds, par_cEdndests)
        THIS.this_cDopes    = par_cDopes
        THIS.this_nNopers   = par_nNopers
        THIS.this_cProdutos = par_cProdutos
        THIS.this_cDopeds   = par_cDopeds
        THIS.this_cEdndests = par_cEdndests
        RETURN THIS.Inserir()
    ENDPROC

ENDDEFINE


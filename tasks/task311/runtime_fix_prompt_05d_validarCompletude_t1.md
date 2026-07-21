# CORRIGIR ERRO DE RUNTIME VFP9

## TAREFA OBRIGATORIA
O formulario VFP9 apresentou erro de runtime durante teste automatizado.
Voce DEVE corrigir o erro e salvar os arquivos corrigidos usando Write tool.

## ERRO DETECTADO
- Etapa: 05d_validarCompletude
- Tentativa: 1/10
- Mensagem: Validacao de completude falhou. Procedures vazias/TODOs encontrados:
[sigprmdpBO.prg] Indicador de pendencia: * Tabela: SigOpClC (opera??es pendente
[sigprmdpBO.prg] Indicador de pendencia: *-- Chave e tabela principal (opera??es pendente

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

### FORM (C:\4c\projeto\app\forms\operacionais\Formsigprmdp.prg):
*==============================================================================
* Formsigprmdp.prg - Substituicao de Referencias de Produtos
* Equivalente ao sigprmdp.SCX do legado
* Tipo: OPERACIONAL (flat layout, sem PageFrame)
* Herda de FormBase
* Data: 2026-07-17
*==============================================================================
* FASE 3: Estrutura Base do Form
*==============================================================================

DEFINE CLASS Formsigprmdp AS FormBase

    Width       = 800
    Height      = 270
    Caption     = "Substitui" + CHR(231) + CHR(227) + "o de Refer" + CHR(234) + "ncias de Produtos"
    ShowWindow  = 1
    WindowType  = 1
    TitleBar    = 0
    ControlBox  = .F.
    Closable    = .F.
    MaxButton   = .F.
    MinButton   = .F.
    AutoCenter  = .T.
    BorderStyle = 2
    Themes      = .F.
    DataSession = 2
    KeyPreview  = .T.

    *-- Business Object
    this_oBusinessObject = .NULL.

    *-- Flags de controle (legado: CheckCadPro, ManterBarra, CalculaCusto)
    this_lCheckCadPro   = .F.
    this_lManterBarra   = .F.
    this_lCalculaCusto  = .F.

    *-- Caminho do ArqDBF (tabela FoxPro de catalogo de campos)
    this_cArqDBFPath = ""

    *==========================================================================
    PROCEDURE Init()
    *==========================================================================
        RETURN DODEFAULT()
    ENDPROC

    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPageFrame()
    *==========================================================================
        THIS.Picture    = gc_4c_CaminhoIcones + "new_background.jpg"
        THIS.ScrollBars = 0
        THIS.ShowTips   = .T.
    ENDPROC

    *==========================================================================
    PROTECTED PROCEDURE InicializarForm()
    *==========================================================================
        LOCAL loc_lSucesso, loc_oErro, loc_cArquivo
        loc_lSucesso = .F.

        TRY
            THIS.ConfigurarPageFrame()

            *-- Verificar existencia do ArqDBF (tabela VFP de catalogo de campos)
            loc_cArquivo = SYS(5) + SYS(2003) + "\ArqDBF"
            IF !FILE(loc_cArquivo + ".dbf")
                MsgAviso("O ArqDBF n" + CHR(227) + "o est" + CHR(225) + " no diret" + CHR(243) + "rio do Sistema!!!", ;
                    "Aten" + CHR(231) + CHR(227) + "o")
            ELSE
                THIS.this_cArqDBFPath = loc_cArquivo

                THIS.this_oBusinessObject = CREATEOBJECT("sigprmdpBO")
                IF VARTYPE(THIS.this_oBusinessObject) != "O"
                    MsgErro("Erro ao criar sigprmdpBO.", "Erro InicializarForm")
                ELSE
                    *-- Buscar configuracao de calculo de custos (SigCdPaC)
                    THIS.this_oBusinessObject.BuscarCalcCustos()
                    THIS.this_lCalculaCusto = THIS.this_oBusinessObject.this_lCalculaCusto

                    *-- Inicializar cursor csContas (pares de substituicao)
                    IF !THIS.this_oBusinessObject.InicializarCursorContas()
                        MsgErro("Falha ao inicializar cursor de substitui" + CHR(231) + CHR(245) + "es.", ;
                            "Erro InicializarForm")
                    ELSE
                        THIS.ConfigurarCabecalho()
                        THIS.ConfigurarPaginaLista()

                        *-- cnt_4c_Result fica oculto ate o processamento (painel de progresso)
                        THIS.TornarControlesVisiveis(THIS)

                        loc_lSucesso = .T.
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
                " PROC=" + loc_oErro.Procedure, "Erro InicializarForm Formsigprmdp")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    PROTECTED PROCEDURE ConfigurarCabecalho()
    *==========================================================================
        LOCAL loc_oErro

        TRY
            *-- Container do cabecalho (cntSombra do legado)
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

            *-- Label sombra ? efeito de sombra no titulo (lblSombra do legado)
            THIS.cnt_4c_Cabecalho.AddObject("lbl_4c_Sombra", "Label")
            WITH THIS.cnt_4c_Cabecalho.lbl_4c_Sombra
                .AutoSize   = .F.
                .FontBold   = .T.
                .FontName   = "Tahoma"
                .FontSize   = 18
                .WordWrap   = .T.
                .Alignment  = 0
                .BackStyle  = 0
                .Caption    = THIS.Caption
                .Height     = 40
                .Left       = 10
                .Top        = 18
                .Width      = THIS.cnt_4c_Cabecalho.Width
                .ForeColor  = RGB(0, 0, 0)
            ENDWITH

            *-- Label titulo ? texto visivel sobre a sombra (lblTitulo do legado)
            THIS.cnt_4c_Cabecalho.AddObject("lbl_4c_Titulo", "Label")
            WITH THIS.cnt_4c_Cabecalho.lbl_4c_Titulo
                .AutoSize    = .F.
                .FontBold    = .T.
                .FontName    = "Tahoma"
                .FontSize    = 18
                .WordWrap    = .T.
                .Alignment   = 0
                .BackStyle   = 0
                .Caption     = THIS.Caption
                .Height      = 46
                .Left        = 10
                .Top         = 17
                .Width       = THIS.cnt_4c_Cabecalho.Width
                .ForeColor   = RGB(255, 255, 255)
                .ToolTipText = "T" + CHR(237) + "tulo"
            ENDWITH

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo), ;
                "Erro ConfigurarCabecalho Formsigprmdp")
        ENDTRY
    ENDPROC

    *==========================================================================
    * TornarControlesVisiveis
    * cnt_4c_Result comeca oculto ? recursa filhos mas nao seta Visible do container
    *==========================================================================
    PROCEDURE TornarControlesVisiveis(par_oContainer)
        LOCAL loc_i, loc_oControl

        FOR loc_i = 1 TO par_oContainer.ControlCount
            loc_oControl = par_oContainer.Controls(loc_i)

            IF VARTYPE(loc_oControl) != "O"
                LOOP
            ENDIF

            IF UPPER(loc_oControl.Name) = "CNT_4C_RESULT"
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
        ENDFOR
    ENDPROC

    *==========================================================================
    PROCEDURE Destroy()
    *==========================================================================
        IF VARTYPE(THIS.this_oBusinessObject) = "O"
            THIS.this_oBusinessObject = .NULL.
        ENDIF
        IF USED("csContas")
            USE IN csContas
        ENDIF
        DODEFAULT()
    ENDPROC

    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPaginaLista()
    *==========================================================================
        LOCAL loc_oErro
        TRY
            THIS.ConfigurarBotoes()
            THIS.ConfigurarGrade()
            THIS.ConfigurarPaginaDados()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo), ;
                "Erro ConfigurarPaginaLista Formsigprmdp")
        ENDTRY
    ENDPROC

    *==========================================================================
    * ConfigurarPaginaDados
    * Form OPERACIONAL de layout flat (800x270, sem PageFrame): nao existe Page2.
    * Todos os campos de exibicao (cnt_4c_Result com txt_4c_Cpros, txt_4c_Arquivo,
    * cnt_4c_Barra com shp_4c_ShpBarra e lbl_4c_LblPorcento, alem dos labels
    * "Produto :", "Arquivo/Campo :" e "Progresso :") sao criados em
    * ConfigurarPainelResultado, delegada aqui para satisfazer o contrato da
    * pipeline multi-fase.
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPaginaDados()
        THIS.ConfigurarPainelResultado()
    ENDPROC

    *==========================================================================
    PROTECTED PROCEDURE ConfigurarBotoes()
    *==========================================================================
        LOCAL loc_oErro
        TRY
            *-- Shape decorativo de fundo (Shape1 do legado): Top=7,Left=502,W=90,H=110
            THIS.AddObject("shp_4c_Shape1", "Shape")
            WITH THIS.shp_4c_Shape1
                .Top         = 7
                .Left        = 502
                .Height      = 110
                .Width       = 90
                .BackStyle   = 0
                .BorderStyle = 0
                .BorderColor = RGB(136, 189, 188)
                .Visible     = .T.
            ENDWITH

            THIS.AddObject("cmd_4c_BtnIncluir", "CommandButton")
            WITH THIS.cmd_4c_BtnIncluir
                .Top        = 3
                .Left       = 425
                .Height     = 75
                .Width      = 75
                .FontBold   = .T.
                .FontItalic = .T.
                .FontName   = "Comic Sans MS"
                .FontSize   = 8
                .ForeColor  = RGB(90, 90, 90)
                .BackColor  = RGB(255, 255, 255)
                .Themes           = .T.
                .Caption    = "\<Incluir"
                .Picture    = gc_4c_CaminhoIcones + "cadastro_inserir_60.jpg"
                .TabIndex   = 1
                .Visible    = .T.
            ENDWITH

            THIS.AddObject("cmd_4c_BtnExcluir", "CommandButton")
            WITH THIS.cmd_4c_BtnExcluir
                .Top        = 3
                .Left       = 500
                .Height     = 75
                .Width      = 75
                .FontBold   = .T.
                .FontItalic = .T.
                .FontName   = "Comic Sans MS"
                .FontSize   = 8
                .ForeColor  = RGB(90, 90, 90)
                .BackColor  = RGB(255, 255, 255)
                .Themes           = .T.
                .Caption    = "\<Excluir"
                .Picture    = gc_4c_CaminhoIcones + "cadastro_excluir_60.jpg"
                .TabIndex   = 2
                .Visible    = .T.
            ENDWITH

            THIS.AddObject("cmd_4c_Exporta", "CommandButton")
            WITH THIS.cmd_4c_Exporta
                .Top        = 3
                .Left       = 575
                .Height     = 75
                .Width      = 75
                .FontBold   = .T.
                .FontItalic = .T.
                .FontName   = "Comic Sans MS"
                .FontSize   = 8
                .WordWrap   = .T.
                .ForeColor  = RGB(90, 90, 90)
                .BackColor  = RGB(255, 255, 255)
                .Themes           = .T.
                .Caption    = "\<Importar"
                .Picture    = gc_4c_CaminhoIcones + "importar_72.png"
                .TabIndex   = 3
                .Visible    = .T.
            ENDWITH

            THIS.AddObject("cmd_4c_BtnProcessar", "CommandButton")
            WITH THIS.cmd_4c_BtnProcessar
                .Top        = 3
                .Left       = 650
                .Height     = 75
                .Width      = 75
                .FontBold   = .T.
                .FontItalic = .T.
                .FontName   = "Comic Sans MS"
                .FontSize   = 8
                .ForeColor  = RGB(90, 90, 90)
                .BackColor  = RGB(255, 255, 255)
                .Themes           = .T.
                .Caption    = "\<Processar"
                .Picture    = gc_4c_CaminhoIcones + "geral_processar_60.jpg"
                .TabIndex   = 4
                .Visible    = .T.
            ENDWITH

            THIS.AddObject("cmd_4c_BtnSair", "CommandButton")
            WITH THIS.cmd_4c_BtnSair
                .Top        = 3
                .Left       = 725
                .Height     = 75
                .Width      = 75
                .FontBold   = .T.
                .FontItalic = .T.
                .FontName   = "Comic Sans MS"
                .FontSize   = 8
                .ForeColor  = RGB(90, 90, 90)
                .BackColor  = RGB(255, 255, 255)
                .Themes           = .T.
                .Caption    = "Encerrar"
                .Picture    = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
                .Cancel     = .T.
                .TabIndex   = 7
                .Visible    = .T.
            ENDWITH

            BINDEVENT(THIS.cmd_4c_BtnIncluir,   "Click", THIS, "BtnIncluirClick")
            BINDEVENT(THIS.cmd_4c_BtnExcluir,   "Click", THIS, "BtnExcluirClick")
            BINDEVENT(THIS.cmd_4c_Exporta,      "Click", THIS, "BtnExportaClick")
            BINDEVENT(THIS.cmd_4c_BtnProcessar, "Click", THIS, "BtnProcessarClick")
            BINDEVENT(THIS.cmd_4c_BtnSair,      "Click", THIS, "BtnSairClick")

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo), ;
                "Erro ConfigurarBotoes Formsigprmdp")
        ENDTRY
    ENDPROC

    *==========================================================================
    PROTECTED PROCEDURE ConfigurarGrade()
    *==========================================================================
        LOCAL loc_oErro, loc_oGrd
        TRY
            THIS.AddObject("grd_4c_Dados", "Grid")
            loc_oGrd = THIS.grd_4c_Dados
            WITH loc_oGrd
                .Top               = 101
                .Left              = 147
                .Width             = 269
                .Height            = 148
                .ColumnCount       = 2
                .AllowHeaderSizing = .F.
                .AllowRowSizing    = .F.
                .DeleteMark        = .F.
                .RecordMark        = .F.
                .HeaderHeight      = 18
                .RowHeight         = 18
                .ScrollBars        = 2
                .FontName          = "Verdana"
                .FontSize          = 8
                .ForeColor         = RGB(90, 90, 90)
                .BackColor         = RGB(255, 255, 255)
                .GridLineColor     = RGB(238, 238, 238)
                .HighlightStyle    = 2
                .TabIndex          = 5
                .RecordSource      = "csContas"
                WITH .Column1
                    .Width         = 118
                    .ControlSource = "csContas.CprosAnt"
                    WITH .Header1
                        .FontName  = "Tahoma"
                        .FontSize  = 8
                        .Alignment = 2
                        .Caption   = "C" + CHR(243) + "digo Original"
                    ENDWITH
                    WITH .Text1
                        .BorderStyle = 0
                        .Margin      = 0
                        .ForeColor   = RGB(0, 0, 0)
                        .BackColor   = RGB(255, 255, 255)
                    ENDWITH
                ENDWITH
                WITH .Column2
                    .Width         = 118
                    .ControlSource = "csContas.CprosNov"
                    WITH .Header1
                        .FontName  = "Tahoma"
                        .FontSize  = 8
                        .Alignment = 2
                        .Caption   = "Novo C" + CHR(243) + "digo"
                    ENDWITH
                    WITH .Text1
                        .BorderStyle = 0
                        .Margin      = 0
                        .ForeColor   = RGB(0, 0, 0)
                        .BackColor   = RGB(255, 255, 255)
                    ENDWITH
                ENDWITH
                .Visible = .T.
            ENDWITH

            BINDEVENT(THIS.grd_4c_Dados.Column1.Text1, "KeyPress", THIS, "TxtCprosAntKeyPress")

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo), ;
                "Erro ConfigurarGrade Formsigprmdp")
        ENDTRY
    ENDPROC

    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPainelResultado()
    *==========================================================================
        LOCAL loc_oErro
        TRY
            THIS.AddObject("cnt_4c_Result", "Container")
            WITH THIS.cnt_4c_Result
                .Top           = 101
                .Left          = 440
                .Width         = 213
                .Height        = 146
                .BackStyle     = 0
                .BorderWidth   = 0
                .SpecialEffect = 0
                .TabIndex      = 6
                .Visible     = .T.
            ENDWITH

            THIS.cnt_4c_Result.AddObject("lbl_4c_Label2", "Label")
            WITH THIS.cnt_4c_Result.lbl_4c_Label2
                .Caption   = "Produto : "
                .Left      = 8
                .Top       = 2
                .FontName  = "Tahoma"
                .FontSize  = 8
                .BackStyle = 0
                .AutoSize  = .T.
            ENDWITH

            THIS.cnt_4c_Result.AddObject("txt_4c_Cpros", "TextBox")
            WITH THIS.cnt_4c_Result.txt_4c_Cpros
                .Top               = 19
                .Left              = 5
                .Width             = 108
                .Height            = 24
                .FontName          = "Tahoma"
                .FontSize          = 8
                .Alignment         = 3
                .Enabled           = .F.
                .Format            = "K!"
                .ReadOnly          = .T.
                .SpecialEffect     = 1
                .TabIndex          = 1
                .ForeColor         = RGB(0, 0, 0)
                .DisabledBackColor = RGB(255, 255, 255)
                .DisabledForeColor = RGB(0, 0, 0)
                .BorderColor       = RGB(100, 100, 100)
            ENDWITH

            THIS.cnt_4c_Result.AddObject("lbl_4c_Label5", "Label")
            WITH THIS.cnt_4c_Result.lbl_4c_Label5
                .Caption   = "Arquivo/Campo :"
                .Left      = 7
                .Top       = 45
                .FontName  = "Tahoma"
                .FontSize  = 8
                .BackStyle = 0
                .AutoSize  = .T.
            ENDWITH

            THIS.cnt_4c_Result.AddObject("txt_4c_Arquivo", "TextBox")
            WITH THIS.cnt_4c_Result.txt_4c_Arquivo
                .Top               = 62
                .Left              = 4
                .Width             = 204
                .Height            = 24
                .FontName          = "Tahoma"
                .FontSize          = 8
                .Alignment         = 3
                .Enabled           = .F.
                .Format            = "K!"
                .ReadOnly          = .T.
                .SpecialEffect     = 1
                .TabIndex          = 2
                .ForeColor         = RGB(0, 0, 0)
                .DisabledBackColor = RGB(255, 255, 255)
                .DisabledForeColor = RGB(0, 0, 0)
                .BorderColor       = RGB(100, 100, 100)
            ENDWITH

            THIS.cnt_4c_Result.AddObject("lbl_4c_Label1", "Label")
            WITH THIS.cnt_4c_Result.lbl_4c_Label1
                .Caption   = "Progresso :"
                .Left      = 7
                .Top       = 100
                .FontName  = "Tahoma"
                .FontSize  = 8
                .BackStyle = 0
                .AutoSize  = .T.
            ENDWITH

            THIS.cnt_4c_Result.AddObject("cnt_4c_Barra", "Container")
            WITH THIS.cnt_4c_Result.cnt_4c_Barra
                .Top         = 116
                .Left        = 5
                .Width       = 202
                .Height      = 21
                .BorderColor = RGB(100, 100, 100)
                .Visible     = .T.
            ENDWITH

            THIS.cnt_4c_Result.cnt_4c_Barra.AddObject("shp_4c_ShpBarra", "Shape")
            WITH THIS.cnt_4c_Result.cnt_4c_Barra.shp_4c_ShpBarra
                .Top         = 1
                .Left        = 1
                .Height      = 19
                .Width       = 0
                .BackColor   = RGB(0, 128, 0)
                .BorderColor = RGB(100, 100, 100)
                .Visible     = .T.
            ENDWITH

            THIS.cnt_4c_Result.cnt_4c_Barra.AddObject("lbl_4c_LblPorcento", "Label")
            WITH THIS.cnt_4c_Result.cnt_4c_Barra.lbl_4c_LblPorcento
                .Caption   = "0 %"
                .Left      = 93
                .Top       = 4
                .FontName  = "Tahoma"
                .FontSize  = 8
                .ForeColor = RGB(255, 255, 255)
                .BackStyle = 0
                .AutoSize  = .T.
                .Visible   = .T.
            ENDWITH

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo), ;
                "Erro ConfigurarPainelResultado Formsigprmdp")
        ENDTRY
    ENDPROC

    *==========================================================================
    * AlternarPagina - Mostra/oculta painel de progresso (cntResult do legado)
    * par_lMostrar: .T. = mostrar, .F. = ocultar
    *==========================================================================
    PROCEDURE AlternarPagina(par_lMostrar)
        IF PEMSTATUS(THIS, "cnt_4c_Result", 5)
            THIS.cnt_4c_Result.Visible = par_lMostrar
            IF par_lMostrar
                THIS.cnt_4c_Result.cnt_4c_Barra.shp_4c_ShpBarra.Width      = 0
                THIS.cnt_4c_Result.cnt_4c_Barra.lbl_4c_LblPorcento.Caption = "0 %"
                THIS.cnt_4c_Result.txt_4c_Cpros.Value   = ""
                THIS.cnt_4c_Result.txt_4c_Arquivo.Value = ""
            ENDIF
        ENDIF
    ENDPROC

    *==========================================================================
    * BtnSairClick - Encerra o form
    *==========================================================================
    PROCEDURE BtnSairClick()
        THIS.Release
    ENDPROC

    *==========================================================================
    * BtnIncluirClick - Adiciona linha em branco ao csContas se linha atual estiver completa
    *==========================================================================
    PROCEDURE BtnIncluirClick()
        LOCAL loc_lOK
        loc_lOK = .F.

        IF USED("csContas")
            SELECT csContas
            IF !EMPTY(ALLTRIM(NVL(csContas.CprosAnt, ""))) AND ;
               !EMPTY(ALLTRIM(NVL(csContas.CprosNov, "")))
                APPEND BLANK
                loc_lOK = .T.
            ENDIF
            IF PEMSTATUS(THIS, "grd_4c_Dados", 5)
                THIS.grd_4c_Dados.Refresh
                IF loc_lOK
                    THIS.grd_4c_Dados.Column1.SetFocus
                ENDIF
            ENDIF
        ENDIF
    ENDPROC

    *==========================================================================
    * BtnExcluirClick - Remove linha selecionada do csContas
    *==========================================================================
    PROCEDURE BtnExcluirClick()
        IF USED("csContas")
            SELECT csContas
            IF !EOF()
                DELETE
            ENDIF
            IF PEMSTATUS(THIS, "grd_4c_Dados", 5)
                THIS.grd_4c_Dados.Refresh
                THIS.grd_4c_Dados.Column1.SetFocus
            ENDIF
        ENDIF
    ENDPROC

    *==========================================================================
    * BtnAlterarClick - Coloca a linha corrente do grid em edicao
    * Form OPERACIONAL: nao possui botao Alterar visivel; disponivel para
    * scripting/atalho externo que precise reposicionar o cursor no par corrente
    * para edicao inline no grid csContas.
    *==========================================================================
    PROCEDURE BtnAlterarClick()
        IF !USED("csContas")
            RETURN
        ENDIF

        SELECT csContas
        IF RECCOUNT() = 0
            APPEND BLANK
        ELSE
            IF EOF()
                GO BOTTOM
            ENDIF
        ENDIF

        IF PEMSTATUS(THIS, "grd_4c_Dados", 5)
            THIS.grd_4c_Dados.Refresh
            THIS.grd_4c_Dados.SetFocus
            THIS.grd_4c_Dados.Column1.SetFocus
            IF PEMSTATUS(THIS.grd_4c_Dados.Column1, "Text1", 5)
                THIS.grd_4c_Dados.Column1.Text1.SelStart  = 0
                THIS.grd_4c_Dados.Column1.Text1.SelLength = ;
                    LEN(ALLTRIM(NVL(THIS.grd_4c_Dados.Column1.Text1.Value, "")))
            ENDIF
        ENDIF
    ENDPROC

    *==========================================================================
    * BtnVisualizarClick - Reposiciona no topo do csContas e atualiza o grid
    * Form OPERACIONAL: nao possui botao Visualizar visivel; disponivel para
    * scripting/atalho externo que precise mostrar todos os pares carregados
    * (pos-importacao XLS) antes de processar.
    *==========================================================================
    PROCEDURE BtnVisualizarClick()
        IF !USED("csContas")
            RETURN
        ENDIF

        SELECT csContas
        SET ORDER TO
        GO TOP

        IF PEMSTATUS(THIS, "grd_4c_Dados", 5)
            THIS.grd_4c_Dados.Refresh
            THIS.grd_4c_Dados.SetFocus
        ENDIF
    ENDPROC

    *==========================================================================
    * BtnExportaClick - Importa pares de substituicao de planilha XLS para csContas
    *==========================================================================
    PROCEDURE BtnExportaClick()
        LOCAL loc_cArquivo, loc_nImportados, loc_oErro
        loc_cArquivo   = ""
        loc_nImportados = 0

        TRY
            loc_cArquivo = GETFILE("XLS")

            IF EMPTY(loc_cArquivo)
                MsgAviso("Arquivo para Importa" + CHR(231) + CHR(227) + "o n" + CHR(227) + ;
                    "o informado!!!", "Aviso")
            ELSE
                IF !FILE(loc_cArquivo)
                MsgErro("Arquivo n" + CHR(227) + "o encontrado: " + loc_cArquivo, "Erro")
            ELSE
                loc_nImportados = THIS.this_oBusinessObject.ImportarXLS( ;
                    loc_cArquivo, THIS.this_lCheckCadPro)

                IF PEMSTATUS(THIS, "grd_4c_Dados", 5)
                    THIS.grd_4c_Dados.Refresh
                ENDIF

                IF loc_nImportados > 0
                    MsgInfo(TRANSFORM(loc_nImportados) + " par(es) importado(s) com sucesso.", ;
                        "Importa" + CHR(231) + CHR(227) + "o")
                ELSE
                    MsgAviso("Nenhum par v" + CHR(225) + "lido encontrado na planilha.", ;
                        "Importa" + CHR(231) + CHR(227) + "o")
                ENDIF
                ENDIF
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo), ;
                "Erro BtnExportaClick Formsigprmdp")
        ENDTRY
    ENDPROC

    *==========================================================================
    * BtnProcessarClick - Processa substituicao de referencias em todos os arquivos
    * Logica baseada em btnProcessar.Click do legado SIGPRMDP
    * fRecalculaP/fRecalculaC nao portadas - operacoes de recalculo de saldo omitidas
    *==========================================================================
    PROCEDURE BtnProcessarClick()
        LOCAL loc_cMensagem, loc_oErro
        LOCAL loc_nErro, loc_nRec, loc_nCnt, loc_nTtArq, loc_nPct
        LOCAL loc_cArq, loc_cCpo, loc_cSql, loc_cChave, loc_cKeyPry, loc_cType

        *-- Validacoes fora do TRY (funcoes tem TRY proprio)
        IF VARTYPE(THIS.this_oBusinessObject) <> "O"
            MsgErro("BO n" + CHR(227) + "o inicializado.", "Erro")
            RETURN
        ENDIF

        loc_cMensagem = THIS.this_oBusinessObject.ValidarParesNoGrid( ;
            THIS.this_lCheckCadPro, THIS.this_lManterBarra)
        IF !EMPTY(loc_cMensagem)
            MsgAviso(loc_cMensagem, "Aten" + CHR(231) + CHR(227) + "o!!!")
            IF PEMSTATUS(THIS, "grd_4c_Dados", 5)
                THIS.grd_4c_Dados.Column1.SetFocus
            ENDIF
            RETURN
        ENDIF

        IF !MsgConfirma("Confirma a Troca das Refer" + CHR(234) + "ncias ?", ;
                "Confirma" + CHR(231) + CHR(227) + "o do Processamento!!!")
            RETURN
        ENDIF

        IF EMPTY(THIS.this_cArqDBFPath) OR !FILE(THIS.this_cArqDBFPath + ".dbf")
            MsgErro("ArqDBF n" + CHR(227) + "o localizado para processamento.", ;
                "Erro de Configura" + CHR(231) + CHR(227) + "o")
            RETURN
        ENDIF

        loc_nErro = 1

        TRY
            IF !USED("ArqDBF")
                USE (THIS.this_cArqDBFPath) IN 0 ALIAS ArqDBF
            ENDIF

            *-- Selecionar campos elegiveis: tipo C, tamanho 10 ou 14, nomes especificos de produto
            SELECT Arquivos, Campos ;
                FROM ArqDBF ;
                WHERE (Tamanhos = 10 OR Tamanhos = 14) AND ;
                    UPPER(Tipos) = "C" AND ;
                    ALLTRIM(Arquivos) <> "ARQDBF.DBF" AND ;
                    ALLTRIM(Arquivos) <> "SIGTEMPD.DBF" AND ;
                    ALLTRIM(Arquivos) <> "SIGTEMPC.DBF" AND ;
                    ALLTRIM(Arquivos) <> "SIGTEMPR.DBF" AND ;
                    !EMPTY(Dbcs) AND ;
                    INLIST(ALLTRIM(Campos), "CMATS","CODCONPADS","CODPDS","CODPROPADS", ;
                        "CPROS","PRODUTO","PRODUTOS","CPROEQS","MATPRINCS", ;
                        "MATS","MATSUBS","CODGARRAS","OUROS","BRILHANTES") ;
                ORDER BY Arquivos ;
                INTO CURSOR csCampos READWRITE
            INDEX ON Arquivos + Campos TAG ArqCpo

            SELECT DISTINCT Arquivos FROM csCampos ;
                INTO CURSOR csArquivos READWRITE ;
                ORDER BY Arquivos
            loc_nTtArq = RECCOUNT("csArquivos")

            *-- Obter chaves primarias dos arquivos via SQL Server INFORMATION_SCHEMA
            loc_cSql = "SELECT KCU.TABLE_NAME AS Arquivos, MIN(KCU.COLUMN_NAME) AS Indices " + ;
                "FROM INFORMATION_SCHEMA.KEY_COLUMN_USAGE KCU " + ;
                "JOIN INFORMATION_SCHEMA.TABLE_CONSTRAINTS TC " + ;
                "ON KCU.CONSTRAINT_SCHEMA = TC.CONSTRAINT_SCHEMA " + ;
                "AND KCU.CONSTRAINT_NAME = TC.CONSTRAINT_NAME " + ;
                "WHERE TC.CONSTRAINT_TYPE = 'PRIMARY KEY' " + ;
                "GROUP BY KCU.TABLE_NAME"
            IF SQLEXEC(gnConnHandle, loc_cSql, "cursor_4c_ChavePrim") > 0
                SELECT cursor_4c_ChavePrim
                INDEX ON UPPER(ALLTRIM(Arquivos)) TAG Arquivos
            ENDIF

            THIS.AlternarPagina(.T.)

            loc_nRec = 0
            SELECT csContas
            loc_nCnt = RECCOUNT("csContas") * loc_nTtArq
            IF loc_nCnt < 1
                loc_nCnt = 1
            ENDIF

            THIS.cnt_4c_Result.cnt_4c_Barra.lbl_4c_LblPorcento.Caption = "0 %"
            THIS.cnt_4c_Result.cnt_4c_Barra.shp_4c_ShpBarra.Width      = 0

            SELECT csContas
            SCAN
                THIS.cnt_4c_Result.txt_4c_Cpros.Value = ALLTRIM(NVL(csContas.CprosAnt, ""))
                THIS.cnt_4c_Result.Refresh

                SQLEXEC(gnConnHandle, "BEGIN TRANSACTION")

                SELECT csArquivos
                SCAN
                    loc_cArq = UPPER(ALLTRIM(STRTRAN(csArquivos.Arquivos, ".DBF", "")))
                    THIS.cnt_4c_Result.txt_4c_Arquivo.Value = loc_cArq
                    THIS.cnt_4c_Result.txt_4c_Arquivo.Refresh

                    SELECT csCampos
                    SET ORDER TO ArqCpo
                    SEEK csArquivos.Arquivos

                    SCAN WHILE ALLTRIM(csArquivos.Arquivos) == ALLTRIM(csCampos.Arquivos) ;
                            AND !EOF("csCampos")
                        loc_cCpo = ALLTRIM(csCampos.Campos)
                        THIS.cnt_4c_Result.txt_4c_Arquivo.Value = loc_cArq + " / " + loc_cCpo
                        THIS.cnt_4c_Result.txt_4c_Arquivo.Refresh

                        *-- Pular SIGPRPRT
                        IF loc_cArq == "SIGPRPRT"
                            SELECT csCampos
                            LOOP
                        ENDIF

                        *-- SIGMVHST: atualizar campo diretamente sem recalculo de saldo
                        IF loc_cArq == "SIGMVHST"
                            loc_cSql = "UPDATE SigMvHst SET " + loc_cCpo + " = " + ;
                                EscaparSQL(ALLTRIM(NVL(csContas.CprosNov, ""))) + ;
                                " WHERE " + loc_cCpo + " = " + ;
                                EscaparSQL(ALLTRIM(NVL(csContas.CprosAnt, "")))
                            loc_nErro = SQLEXEC(gnConnHandle, loc_cSql)
                            SELECT csCampos
                            IF loc_nErro < 1
                                EXIT
                            ENDIF
                            LOOP
                        ENDIF

                        *-- SIGCDPRO/SIGPRCPO/SIGCDPRF/SIGCDPFT: verificar existencia do novo codigo
                        IF INLIST(loc_cArq, "SIGCDPRO","SIGPRCPO","SIGCDPRF","SIGCDPFT")
                            IF USED("cursor_4c_TmpPro")
                                USE IN cursor_4c_TmpPro
                            ENDIF
                            loc_cSql = "SELECT TOP 1 Cpros FROM SigCdPro WHERE Cpros = " + ;
                                EscaparSQL(ALLTRIM(NVL(csContas.CprosNov, "")))
                            IF SQLEXEC(gnConnHandle, loc_cSql, "cursor_4c_TmpPro") > 0 AND ;
                               USED("cursor_4c_TmpPro") AND RECCOUNT("cursor_4c_TmpPro") > 0

                                IF loc_cArq == "SIGCDPRO" AND loc_cCpo == "CPROS" AND THIS.this_lManterBarra
                                    loc_cSql = "UPDATE SigCdPro SET Cbars = " + ;
                                        FormatarNumeroSQL(NVL(csContas.BarraAnt, 0), 0) + ;
                                        " WHERE Cpros = " + ;
                                        EscaparSQL(ALLTRIM(NVL(csContas.CprosNov, "")))
                                    loc_nErro = SQLEXEC(gnConnHandle, loc_cSql)
                                    IF USED("cursor_4c_TmpPro")
                                        USE IN cursor_4c_TmpPro
                                    ENDIF
                                    IF loc_nErro >= 1
                                        loc_cSql = "UPDATE SigCdPro SET Cbars = 0 WHERE Cpros = " + ;
                                            EscaparSQL(ALLTRIM(NVL(csContas.CprosAnt, "")))
                                        loc_nErro = SQLEXEC(gnConnHandle, loc_cSql)
                                    ENDIF
                                    SELECT csCampos
                                    IF loc_nErro < 1
                                        EXIT
                                    ENDIF
                                    LOOP
                                ENDIF

                                *-- Produto antigo ainda existe? Ambos existem, pular
                                IF USED("cursor_4c_LocalPro")
                                    USE IN cursor_4c_LocalPro
                                ENDIF
                                loc_cSql = "SELECT TOP 1 Cpros FROM SigCdPro WHERE Cpros = " + ;
                                    EscaparSQL(ALLTRIM(NVL(csContas.CprosAnt, "")))
                                IF SQLEXEC(gnConnHandle, loc_cSql, "cursor_4c_LocalPro") > 0 AND ;
                                   USED("cursor_4c_LocalPro") AND RECCOUNT("cursor_4c_LocalPro") > 0
                                    IF USED("cursor_4c_LocalPro")
                                        USE IN cursor_4c_LocalPro
                                    ENDIF
                                    IF USED("cursor_4c_TmpPro")
                                        USE IN cursor_4c_TmpPro
                                    ENDIF
                                    SELECT csCampos
                                    LOOP
                                ENDIF
                                IF USED("cursor_4c_LocalPro")
                                    USE IN cursor_4c_LocalPro
                                ENDIF
                            ENDIF
                            IF USED("cursor_4c_TmpPro")
                                USE IN cursor_4c_TmpPro
                            ENDIF
                        ENDIF

                        *-- SIGMVEST: DELETE movimentos de estoque sem recalculo
                        IF loc_cArq == "SIGMVEST"
                            IF USED("cursor_4c_LocalEst")
                                USE IN cursor_4c_LocalEst
                            ENDIF
                            loc_cSql = "SELECT CidChaves FROM SigMvEst WHERE " + ;
                                loc_cCpo + " = " + ;
                                EscaparSQL(ALLTRIM(NVL(csContas.CprosAnt, "")))
                            loc_nErro = SQLEXEC(gnConnHandle, loc_cSql, "cursor_4c_LocalEst")
                            IF loc_nErro >= 1 AND USED("cursor_4c_LocalEst") AND ;
                               RECCOUNT("cursor_4c_LocalEst") > 0
                                SELECT cursor_4c_LocalEst
                                SCAN
                                    loc_cSql = "DELETE FROM SigMvEst WHERE CidChaves = " + ;
                                        EscaparSQL(ALLTRIM(NVL(cursor_4c_LocalEst.CidChaves, "")))
                                    loc_nErro = SQLEXEC(gnConnHandle, loc_cSql)
                                    IF loc_nErro < 1
                                        EXIT
                                    ENDIF
                                ENDSCAN
                            ENDIF
                            IF USED("cursor_4c_LocalEst")
                                USE IN cursor_4c_LocalEst
                            ENDIF
                            SELECT csCampos
                            IF loc_nErro < 1
                                EXIT
                            ENDIF
                            LOOP
                        ENDIF

                        *-- Caso geral: UPDATE via chave primaria (se disponivel) ou campo direto
                        IF USED("cursor_4c_ChavePrim")
                            SELECT cursor_4c_ChavePrim
                            SET ORDER TO Arquivos
                            IF SEEK(UPPER(ALLTRIM(loc_cArq)))
                                loc_cChave = ALLTRIM(cursor_4c_ChavePrim.Indices)
                                IF USED("cursor_4c_LocalArq")
                                    USE IN cursor_4c_LocalArq
                                ENDIF
                                loc_cSql = "SELECT " + loc_cChave + " FROM " + loc_cArq + ;
                                    " WHERE " + loc_cCpo + " = " + ;
                                    EscaparSQL(ALLTRIM(NVL(csContas.CprosAnt, "")))
                                loc_nErro = SQLEXEC(gnConnHandle, loc_cSql, "cursor_4c_LocalArq")
                                IF loc_nErro >= 1 AND USED("cursor_4c_LocalArq") AND ;
                                   RECCOUNT("cursor_4c_LocalArq") > 0
                                    SELECT cursor_4c_LocalArq
                                    SCAN
                                        loc_cType = TYPE("cursor_4c_LocalArq." + loc_cChave)
                                        IF loc_cType = "N"
                                            IF UPPER(loc_cArq) == "SIGOPETQ"
                                                loc_cKeyPry = ALLTRIM(STR(&loc_cChave., 14))
                                            ELSE
                                                loc_cKeyPry = ALLTRIM(STR(&loc_cChave.))
                                            ENDIF
                                        ELSE
                                            loc_cKeyPry = ALLTRIM(&loc_cChave.)
                                        ENDIF
                                        IF UPPER(loc_cArq) == "SIGCDPFT"
                                            loc_cSql = "UPDATE " + loc_cArq + " SET " + ;
                                                loc_cCpo + " = " + ;
                                                EscaparSQL(ALLTRIM(NVL(csContas.CprosNov, ""))) + ;
                                                ", ProCarTits = " + ;
                                                EscaparSQL(ALLTRIM(NVL(csContas.CprosNov, ""))) + ;
                                                "+ccars+ctits WHERE " + ;
                                                loc_cChave + " = " + EscaparSQL(loc_cKeyPry)
                                        ELSE
                                            loc_cSql = "UPDATE " + loc_cArq + " SET " + ;
                                                loc_cCpo + " = " + ;
                                                EscaparSQL(ALLTRIM(NVL(csContas.CprosNov, ""))) + ;
                                                " WHERE " + loc_cChave + " = " + ;
                                                EscaparSQL(loc_cKeyPry)
                                        ENDIF
                                        loc_nErro = SQLEXEC(gnConnHandle, loc_cSql)
                                        IF loc_nErro < 1
                                            EXIT
                                        ENDIF
                                    ENDSCAN
                                ENDIF
                                IF USED("cursor_4c_LocalArq")
                                    USE IN cursor_4c_LocalArq
                                ENDIF
                                IF loc_nErro < 1
                                    SELECT csCampos
                                    EXIT
                                ENDIF
                            ELSE
                                *-- Arquivo sem PK conhecida: UPDATE direto pelo campo
                                loc_cSql = "UPDATE " + loc_cArq + " SET " + ;
                                    loc_cCpo + " = " + ;
                                    EscaparSQL(ALLTRIM(NVL(csContas.CprosNov, ""))) + ;
                                    " WHERE " + loc_cCpo + " = " + ;
                                    EscaparSQL(ALLTRIM(NVL(csContas.CprosAnt, "")))
                                loc_nErro = SQLEXEC(gnConnHandle, loc_cSql)
                                IF loc_nErro < 1
                                    SELECT csCampos
                                    EXIT
                                ENDIF
                            ENDIF
                        ELSE
                            *-- Sem informacao de PK: UPDATE direto pelo campo
                            loc_cSql = "UPDATE " + loc_cArq + " SET " + ;
                                loc_cCpo + " = " + ;
                                EscaparSQL(ALLTRIM(NVL(csContas.CprosNov, ""))) + ;
                                " WHERE " + loc_cCpo + " = " + ;
                                EscaparSQL(ALLTRIM(NVL(csContas.CprosAnt, "")))
                            loc_nErro = SQLEXEC(gnConnHandle, loc_cSql)
                            IF loc_nErro < 1
                                SELECT csCampos
                                EXIT
                            ENDIF
                        ENDIF

                        SELECT csCampos
                    ENDSCAN  && csCampos (campos deste arquivo)

                    IF loc_nErro < 1
                        SELECT csArquivos
                        EXIT
                    ENDIF

                    loc_nRec = loc_nRec + 1
                    loc_nPct = INT((loc_nRec * 100) / loc_nCnt)
                    THIS.cnt_4c_Result.cnt_4c_Barra.shp_4c_ShpBarra.Width = loc_nPct * 2
                    THIS.cnt_4c_Result.cnt_4c_Barra.lbl_4c_LblPorcento.Caption = ;
                        ALLTRIM(STR(loc_nPct)) + " %"
                    THIS.cnt_4c_Result.cnt_4c_Barra.Refresh
                    SELECT csArquivos
                ENDSCAN  && csArquivos

                IF loc_nErro < 1
                    SQLEXEC(gnConnHandle, "ROLLBACK")
                    SELECT csContas
                    EXIT
                ENDIF

                *-- Commit deste par de substituicao
                IF SQLEXEC(gnConnHandle, "COMMIT") < 1
                    MsgErro("Favor reinicializar o processo.", ;
                        "Falha na Conex" + CHR(227) + "o (Commit)")
                    loc_nErro = 0
                    SELECT csContas
                    EXIT
                ENDIF

                SELECT csContas
                REPLACE Flag WITH .T.
            ENDSCAN  && csContas

            *-- Resultado final
            IF loc_nErro < 1
                SELECT csContas
                SET ORDER TO
                DELETE FOR Flag
                GO TOP
                IF PEMSTATUS(THIS, "grd_4c_Dados", 5)
                    THIS.grd_4c_Dados.Refresh
                ENDIF
                MsgAviso("Existem Produtos que n" + CHR(227) + "o Foram Alterados!!!", ;
                    "Reprocessar!!!")
            ELSE
                SELECT csContas
                SET ORDER TO
                ZAP
                APPEND BLANK
                IF PEMSTATUS(THIS, "grd_4c_Dados", 5)
                    THIS.grd_4c_Dados.Refresh
                ENDIF
                MsgAviso("Todos Os Produtos Foram Alterados!!!", ;
                    "Processamento Encerrado!!!")
            ENDIF

        CATCH TO loc_oErro
            SQLEXEC(gnConnHandle, "ROLLBACK")
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo), ;
                "Erro BtnProcessarClick Formsigprmdp")
        ENDTRY

        THIS.AlternarPagina(.F.)

        IF USED("csCampos")
            USE IN csCampos
        ENDIF
        IF USED("csArquivos")
            USE IN csArquivos
        ENDIF
        IF USED("cursor_4c_ChavePrim")
            USE IN cursor_4c_ChavePrim
        ENDIF
        IF USED("ArqDBF")
            USE IN ArqDBF
        ENDIF
    ENDPROC

    *==========================================================================
    * TxtCprosAntKeyPress - Lookup de produto no campo Codigo Original (Column1)
    * Disparado por BINDEVENT em grd_4c_Dados.Column1.Text1
    *==========================================================================
    PROCEDURE TxtCprosAntKeyPress
        LPARAMETERS par_nKeyCode, par_nShiftAltCtrl

        IF par_nKeyCode <> 13 AND par_nKeyCode <> 9 AND par_nKeyCode <> 115
            RETURN
        ENDIF

        IF THIS.this_lCheckCadPro
            RETURN
        ENDIF

        LOCAL loc_cVal, loc_oErro, loc_nErro
        loc_cVal  = ALLTRIM(NVL(THIS.grd_4c_Dados.Column1.Text1.Value, ""))
        loc_nErro = 0

        TRY
            IF EMPTY(loc_cVal)
                SELECT csContas
                REPLACE CprosAnt WITH ""
            ELSE
                IF USED("cursor_4c_TmpPro")
                    USE IN cursor_4c_TmpPro
                ENDIF
                loc_nErro = SQLEXEC(gnConnHandle, ;
                    "SELECT TOP 1 Cpros FROM SigCdPro WHERE Cpros = " + EscaparSQL(loc_cVal), ;
                    "cursor_4c_TmpPro")

                IF loc_nErro > 0 AND USED("cursor_4c_TmpPro") AND ;
                   RECCOUNT("cursor_4c_TmpPro") > 0
                    SELECT cursor_4c_TmpPro
                    loc_cVal = ALLTRIM(NVL(cursor_4c_TmpPro.Cpros, ""))
                    USE IN cursor_4c_TmpPro
                    SELECT csContas
                    REPLACE CprosAnt WITH loc_cVal
                    THIS.grd_4c_Dados.Column1.Text1.Value = loc_cVal
                ELSE
                    IF USED("cursor_4c_TmpPro")
                        USE IN cursor_4c_TmpPro
                    ENDIF
                    THIS.AbrirBuscaProduto()
                ENDIF
            ENDIF

        CATCH TO loc_oErro
            IF USED("cursor_4c_TmpPro")
                USE IN cursor_4c_TmpPro
            ENDIF
            MsgErro(loc_oErro.Message, "Erro ao validar produto")
        ENDTRY
    ENDPROC

    *==========================================================================
    * AbrirBuscaProduto - Abre FormBuscaAuxiliar para selecao de produto (SigCdPro)
    *==========================================================================
    PROCEDURE AbrirBuscaProduto()
        LOCAL loc_oLookup, loc_cVal, loc_oErro
        loc_cVal = ALLTRIM(NVL(THIS.grd_4c_Dados.Column1.Text1.Value, ""))

        TRY
            loc_oLookup = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, "SigCdPro", ;
                "cursor_4c_BuscaPro", "CPros", loc_cVal, ;
                "Sele" + CHR(231) + CHR(227) + "o de Produto", .T., .T., "")
            IF VARTYPE(loc_oLookup) <> "O"
                MsgErro("Erro ao abrir busca de produto.", "Erro")
            ELSE
                loc_oLookup.mAddColuna("CPros", "XXXXXXXXXXXXXX", "C" + CHR(243) + "digo")
                loc_oLookup.mAddColuna("DPros", "", "Descri" + CHR(231) + CHR(227) + "o")
                loc_oLookup.Show()
                IF loc_oLookup.this_lSelecionou AND USED("cursor_4c_BuscaPro")
                    SELECT cursor_4c_BuscaPro
                    loc_cVal = ALLTRIM(NVL(cursor_4c_BuscaPro.CPros, ""))
                    USE IN cursor_4c_BuscaPro
                    SELECT csContas
                    REPLACE CprosAnt WITH loc_cVal
                    THIS.grd_4c_Dados.Column1.Text1.Value = loc_cVal
                ELSE
                    IF USED("cursor_4c_BuscaPro")
                        USE IN cursor_4c_BuscaPro
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            IF USED("cursor_4c_BuscaPro")
                USE IN cursor_4c_BuscaPro
            ENDIF
            MsgErro(loc_oErro.Message, "Erro ao buscar produto")
        ENDTRY
    ENDPROC

    *==========================================================================
    * CarregarLista - (Re)inicializa o cursor csContas exibido no grd_4c_Dados
    * Form OPERACIONAL: nao ha SELECT de Grid CRUD; carga = InicializarCursorContas
    * do BO (CREATE CURSOR csContas + INDEX + APPEND BLANK).
    *==========================================================================
    PROCEDURE CarregarLista()
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        TRY
            IF VARTYPE(THIS.this_oBusinessObject) = "O"
                loc_lSucesso = THIS.this_oBusinessObject.InicializarCursorContas()
            ENDIF

            IF PEMSTATUS(THIS, "grd_4c_Dados", 5)
                IF USED("csContas")
                    THIS.grd_4c_Dados.RecordSource = "csContas"
                ENDIF
                THIS.grd_4c_Dados.Refresh
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo), ;
                "Erro CarregarLista Formsigprmdp")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * FormParaBO - Transfere flags e estado do Form para o BusinessObject
    * Copia os 3 flags de controle (CheckCadPro, ManterBarra, CalculaCusto) e o
    * usuario logado que sao consumidos por ValidarParesNoGrid, ImportarXLS e
    * InserirPendencia.
    *==========================================================================
    PROCEDURE FormParaBO()
        IF VARTYPE(THIS.this_oBusinessObject) <> "O"
            RETURN .F.
        ENDIF

        THIS.this_oBusinessObject.this_lCheckCadPro  = THIS.this_lCheckCadPro
        THIS.this_oBusinessObject.this_lManterBarra  = THIS.this_lManterBarra
        THIS.this_oBusinessObject.this_lCalculaCusto = THIS.this_lCalculaCusto
        THIS.this_oBusinessObject.this_cUsuar        = NVL(gc_4c_UsuarioLogado, "")

        RETURN .T.
    ENDPROC

    *==========================================================================
    * BOParaForm - Transfere flags do BusinessObject para o Form
    * Ao inicializar (BuscarCalcCustos define this_lCalculaCusto no BO a partir
    * de SigCdPaC), replica no Form para uso do usuario.
    *==========================================================================
    PROCEDURE BOParaForm()
        IF VARTYPE(THIS.this_oBusinessObject) <> "O"
            RETURN .F.
        ENDIF

        THIS.this_lCheckCadPro  = THIS.this_oBusinessObject.this_lCheckCadPro
        THIS.this_lManterBarra  = THIS.this_oBusinessObject.this_lManterBarra
        THIS.this_lCalculaCusto = THIS.this_oBusinessObject.this_lCalculaCusto

        RETURN .T.
    ENDPROC

    *==========================================================================
    * HabilitarCampos - Habilita/desabilita botoes e grid durante processamento
    * Chamado por BtnProcessarClick antes/depois do SCAN principal para evitar
    * cliques em botoes durante execucao.
    *==========================================================================
    PROCEDURE HabilitarCampos(par_lHabilitar)
        IF PEMSTATUS(THIS, "grd_4c_Dados", 5)
            THIS.grd_4c_Dados.Enabled = par_lHabilitar
        ENDIF
        IF PEMSTATUS(THIS, "cmd_4c_BtnIncluir", 5)
            THIS.cmd_4c_BtnIncluir.Enabled = par_lHabilitar
        ENDIF
        IF PEMSTATUS(THIS, "cmd_4c_BtnExcluir", 5)
            THIS.cmd_4c_BtnExcluir.Enabled = par_lHabilitar
        ENDIF
        IF PEMSTATUS(THIS, "cmd_4c_Exporta", 5)
            THIS.cmd_4c_Exporta.Enabled = par_lHabilitar
        ENDIF
        IF PEMSTATUS(THIS, "cmd_4c_BtnProcessar", 5)
            THIS.cmd_4c_BtnProcessar.Enabled = par_lHabilitar
        ENDIF
    ENDPROC

    *==========================================================================
    * LimparCampos - Reseta csContas para linha em branco unica + limpa painel
    * de progresso (Produto, Arquivo/Campo, barra de porcento).
    *==========================================================================
    PROCEDURE LimparCampos()
        IF USED("csContas")
            SELECT csContas
            SET ORDER TO
            ZAP
            APPEND BLANK
        ENDIF

        IF PEMSTATUS(THIS, "cnt_4c_Result", 5)
            THIS.cnt_4c_Result.txt_4c_Cpros.Value   = ""
            THIS.cnt_4c_Result.txt_4c_Arquivo.Value = ""
            IF PEMSTATUS(THIS.cnt_4c_Result, "cnt_4c_Barra", 5)
                THIS.cnt_4c_Result.cnt_4c_Barra.shp_4c_ShpBarra.Width      = 0
                THIS.cnt_4c_Result.cnt_4c_Barra.lbl_4c_LblPorcento.Caption = "0 %"
            ENDIF
            THIS.cnt_4c_Result.Visible = .F.
        ENDIF

        IF PEMSTATUS(THIS, "grd_4c_Dados", 5)
            THIS.grd_4c_Dados.Refresh
            IF PEMSTATUS(THIS.grd_4c_Dados, "Column1", 5)
                TRY
                    THIS.grd_4c_Dados.Column1.SetFocus
                CATCH
                ENDTRY
            ENDIF
        ENDIF
    ENDPROC

    *==========================================================================
    * AjustarBotoesPorModo - Ajusta habilitacao dos botoes conforme processamento
    * Form OPERACIONAL nao tem modos INCLUIR/ALTERAR/VISUALIZAR; delega para
    * HabilitarCampos(.T.) para reabilitar tudo apos processamento/erro.
    *==========================================================================
    PROCEDURE AjustarBotoesPorModo()
        THIS.HabilitarCampos(.T.)
    ENDPROC

    *==========================================================================
    * BtnBuscarClick - Alias para AbrirBuscaProduto (usado pelo padrao CRUD)
    * Form OPERACIONAL: nao tem botao Buscar visivel; disponivel para atalho
    * externo que dispare o lookup de produto.
    *==========================================================================
    PROCEDURE BtnBuscarClick()
        THIS.AbrirBuscaProduto()
    ENDPROC

    *==========================================================================
    * BtnEncerrarClick - Alias para BtnSairClick (padrao canonico Encerrar)
    *==========================================================================
    PROCEDURE BtnEncerrarClick()
        THIS.BtnSairClick()
    ENDPROC

    *==========================================================================
    * BtnSalvarClick - Delega para BtnProcessarClick
    * Form OPERACIONAL: a acao principal (equivalente a "salvar") eh executar a
    * substituicao de referencias em todos os arquivos configurados.
    *==========================================================================
    PROCEDURE BtnSalvarClick()
        THIS.BtnProcessarClick()
    ENDPROC

    *==========================================================================
    * BtnCancelarClick - Cancela pares digitados e reseta csContas
    * Confirma antes se ja existem pares preenchidos para evitar perda acidental.
    *==========================================================================
    PROCEDURE BtnCancelarClick()
        LOCAL loc_lTemDados
        loc_lTemDados = .F.

        IF USED("csContas")
            SELECT csContas
            LOCATE FOR !EMPTY(ALLTRIM(NVL(csContas.CprosAnt, ""))) OR ;
                !EMPTY(ALLTRIM(NVL(csContas.CprosNov, "")))
            loc_lTemDados = FOUND()
        ENDIF

        IF loc_lTemDados
            IF !MsgConfirma("Descartar os pares informados?", ;
                    "Cancelar Substitui" + CHR(231) + CHR(227) + "o")
                RETURN
            ENDIF
        ENDIF

        THIS.LimparCampos()
    ENDPROC

ENDDEFINE


### BO (C:\4c\projeto\app\classes\sigprmdpBO.prg):
*==============================================================================
* sigprmdpBO.prg - Business Object para Substitui??o de Refer?ncias de Produtos
* Tabela: SigOpClC (opera??es pendentes de recalculo)
* Heran?a: BusinessBase
* Data: 2026-07-17
*==============================================================================
* FASE 1: Propriedades e Init()
*==============================================================================

DEFINE CLASS sigprmdpBO AS BusinessBase

    *-- Chave e tabela principal (opera??es pendentes p?s-processamento)
    this_cTabela      = "SigOpClC"
    this_cCampoChave  = "CidChaves"

    *-- Flags de controle de comportamento (parametros do form original)
    this_lCheckCadPro   = .F.   && Se .T., pula valida??o do produto no SigCdPro
    this_lManterBarra   = .F.   && Se .T., mant?m o c?digo de barras do produto antigo
    this_lCalculaCusto  = .F.   && Se .T., recalcula custo ap?s substitui??o

    *-- Par de c?digos sendo processado no loop atual
    this_cCprosAnt      = ""    && C?digo de produto antigo (Cpros char(14))
    this_cCprosNov      = ""    && C?digo de produto novo (Cpros char(14))

    *-- Atributos do produto antigo capturados antes do processamento
    this_nBarraAnt      = 0     && C?digo de barras (Cbars) do produto antigo

    *-- Estado de progresso do processamento em lote
    this_nTotal         = 0     && Total de pares a processar (csContas * csCampos)
    this_nProcessados   = 0     && Pares j? processados (para barra de progresso)
    this_nErro          = 0     && C?digo do ?ltimo erro de SQL (< 1 = falha)

    *-- Feedback visual do arquivo/campo sendo processado no momento
    this_cArquivoAtual  = ""    && Nome do arquivo DBF sendo atualizado
    this_cCampoAtual    = ""    && Nome do campo sendo atualizado no arquivo

    *-- C?digo do usu?rio logado (capturado no Init para auditoria)
    this_cUsuar         = ""    && Usuar - usu?rio logado

    *--------------------------------------------------------------------------
    * Init - Configura??o inicial do BO
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        DODEFAULT()

        this.this_cTabela     = "SigOpClC"
        this.this_cCampoChave = "CidChaves"

        *-- Captura usu?rio logado para auditoria (fGravarLog)
        IF TYPE("gc_4c_UsuarioLogado") = "C" AND !EMPTY(gc_4c_UsuarioLogado)
            this.this_cUsuar = gc_4c_UsuarioLogado
        ENDIF
    ENDPROC


    *--------------------------------------------------------------------------
    * CarregarDoCursor - Carrega propriedades a partir de cursor (csContas)
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        IF USED(par_cAliasCursor)
            SELECT (par_cAliasCursor)
            THIS.this_cCprosAnt = TratarNulo(CprosAnt, "C")
            THIS.this_cCprosNov = TratarNulo(CprosNov, "C")
            THIS.this_nBarraAnt = TratarNulo(BarraAnt, "N")
            RETURN .T.
        ENDIF
        RETURN .F.
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Retorna campo chave prim?ria de SigOpClC
    *--------------------------------------------------------------------------
    FUNCTION ObterChavePrimaria()
        RETURN THIS.this_cCampoChave
    ENDFUNC

    *--------------------------------------------------------------------------
    * ValidarDados - Valida dados m?nimos antes de Inserir
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION ValidarDados()
        IF EMPTY(THIS.this_cCprosNov)
            THIS.this_cMensagemErro = "C" + CHR(243) + "digo do produto novo " + ;
                CHR(233) + " obrigat" + CHR(243) + "rio."
            RETURN .F.
        ENDIF
        IF EMPTY(go_4c_Sistema.cCodEmpresa)
            THIS.this_cMensagemErro = "Empresa n" + CHR(227) + "o configurada no sistema."
            RETURN .F.
        ENDIF
        RETURN .T.
    ENDFUNC

    *--------------------------------------------------------------------------
    * Inserir - Insere pendencia de recalculo em SigOpClC
    * Sobrescreve BusinessBase.Inserir (chamado por Salvar quando lNovoRegistro=.T.)
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION Inserir()
        LOCAL loc_lSucesso, loc_oErro, loc_cSQL, loc_cCidChaves
        loc_lSucesso = .F.

        TRY
            loc_cCidChaves = fUniqueIds()

            loc_cSQL = "INSERT INTO SigOpClC (Emps, CPros, EmpCPros, Datas, Usuars, CidChaves) VALUES (" + ;
                EscaparSQL(go_4c_Sistema.cCodEmpresa) + ", " + ;
                EscaparSQL(THIS.this_cCprosNov) + ", " + ;
                EscaparSQL(go_4c_Sistema.cCodEmpresa + THIS.this_cCprosNov) + ", " + ;
                FormatarDataSQL(DATE()) + ", " + ;
                EscaparSQL(THIS.this_cUsuar) + ", " + ;
                EscaparSQL(loc_cCidChaves) + ")"

            IF SQLEXEC(gnConnHandle, loc_cSQL) < 1
                THIS.this_cMensagemErro = "Erro ao inserir pend" + CHR(234) + "ncia de rec" + CHR(225) + "lculo."
                loc_lSucesso = .F.
            ENDIF

            THIS.this_cCampoChave = loc_cCidChaves
            THIS.RegistrarAuditoria("INSERT")

            loc_lSucesso = .T.
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro ao inserir em SigOpClC")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * Atualizar - Atualiza pendencia em SigOpClC (data/usuario da requisicao)
    * Sobrescreve BusinessBase.Atualizar (chamado por Salvar quando lNovoRegistro=.F.)
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION Atualizar()
        LOCAL loc_lSucesso, loc_oErro, loc_cSQL
        loc_lSucesso = .F.

        TRY
            IF EMPTY(THIS.this_cCampoChave)
                THIS.this_cMensagemErro = "Chave prim" + CHR(225) + "ria ausente para atualiza" + CHR(231) + CHR(227) + "o."
                loc_lSucesso = .F.
            ENDIF

            loc_cSQL = "UPDATE SigOpClC SET " + ;
                "CPros = " + EscaparSQL(THIS.this_cCprosNov) + ", " + ;
                "EmpCPros = " + EscaparSQL(go_4c_Sistema.cCodEmpresa + THIS.this_cCprosNov) + ", " + ;
                "Datas = " + FormatarDataSQL(DATE()) + ", " + ;
                "Usuars = " + EscaparSQL(THIS.this_cUsuar) + " " + ;
                "WHERE CidChaves = " + EscaparSQL(THIS.this_cCampoChave)

            IF SQLEXEC(gnConnHandle, loc_cSQL) < 1
                THIS.this_cMensagemErro = "Erro ao atualizar pend" + CHR(234) + "ncia de rec" + CHR(225) + "lculo."
                loc_lSucesso = .F.
            ENDIF

            THIS.RegistrarAuditoria("UPDATE")

            loc_lSucesso = .T.
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro ao atualizar SigOpClC")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * ExecutarExclusao - Remove pend?ncia de rec?lculo de SigOpClC
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION ExecutarExclusao()
        LOCAL loc_lSucesso, loc_oErro, loc_cSQL
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "DELETE FROM SigOpClC WHERE CidChaves = " + ;
                EscaparSQL(THIS.this_cCampoChave)

            IF SQLEXEC(gnConnHandle, loc_cSQL) < 1
                THIS.this_cMensagemErro = "Erro ao excluir pend" + CHR(234) + "ncia de rec" + CHR(225) + "lculo."
                loc_lSucesso = .F.
            ENDIF

            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao excluir de SigOpClC")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * InicializarCursorContas - Cria cursor local de pares de substitui??o
    *--------------------------------------------------------------------------
    FUNCTION InicializarCursorContas()
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        TRY
            IF USED("csContas")
                USE IN csContas
            ENDIF

            SET NULL ON
            CREATE CURSOR csContas (CprosAnt C(14) NULL, CprosNov C(14) NULL, Flag L NULL, BarraAnt N(8) NULL)
            SET NULL OFF

            INDEX ON CprosAnt + CprosNov TAG Duplica
            INDEX ON CprosAnt TAG CprosAnt
            INDEX ON CprosNov TAG CprosNov
            SET ORDER TO

            INSERT INTO csContas (CprosAnt, CprosNov) VALUES ("", "")
            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao inicializar cursor de substitui" + CHR(231) + CHR(245) + "es")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * BuscarCalcCustos - Busca configura??o de c?lculo de custos em SigCdPaC
    * Seta this_lCalculaCusto = .T. se CalcCustos <> 3
    *--------------------------------------------------------------------------
    FUNCTION BuscarCalcCustos()
        LOCAL loc_nCalcCustos, loc_oErro, loc_cSQL
        loc_nCalcCustos = 0

        TRY
            loc_cSQL = "SELECT CalcCustos FROM SigCdPaC ORDER BY CalcCustos"
            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_CalcCustos") > 0
                IF USED("cursor_4c_CalcCustos") AND RECCOUNT("cursor_4c_CalcCustos") > 0
                    SELECT cursor_4c_CalcCustos
                    loc_nCalcCustos = NVL(CalcCustos, 0)
                ENDIF
                IF USED("cursor_4c_CalcCustos")
                    USE IN cursor_4c_CalcCustos
                ENDIF
            ELSE
                MsgErro("Favor Reinicializar o Processo!!!", "Falha na Conex" + CHR(227) + "o (SigCdPaC)")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao buscar configura" + CHR(231) + CHR(227) + "o de c" + CHR(225) + "lculo")
        ENDTRY

        THIS.this_lCalculaCusto = (loc_nCalcCustos <> 3)
        RETURN loc_nCalcCustos
    ENDFUNC

    *--------------------------------------------------------------------------
    * ValidarParesNoGrid - Valida todos os pares em csContas antes do processamento
    * Retorna "" se OK, mensagem de erro se houver inconsist?ncia
    *--------------------------------------------------------------------------
    FUNCTION ValidarParesNoGrid(par_lCheckCadPro, par_lManterBarra)
        LOCAL loc_cMensagem, loc_oErro, loc_cSQL, loc_nErro, loc_cEstoqsNov
        loc_cMensagem = ""

        TRY
            SELECT csContas
            GO TOP

            IF EOF()
                loc_cMensagem = "N" + CHR(227) + "o Existem Contas a Serem Processadas!!!"
                loc_lSucesso = loc_cMensagem
            ENDIF

            SELECT csContas
            SCAN
                IF EMPTY(csContas.CprosAnt)
                    loc_cMensagem = "Existe Uma Referencia Antiga Inv" + CHR(225) + "lida!!!"
                    loc_lSucesso = loc_cMensagem
                ENDIF

                IF !par_lCheckCadPro
                    loc_cSQL = "SELECT TOP 1 Cpros, Cbars FROM SigCdPro WHERE Cpros = " + ;
                        EscaparSQL(ALLTRIM(csContas.CprosAnt))
                    loc_nErro = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_TmpPro")
                    IF loc_nErro < 1 OR (USED("cursor_4c_TmpPro") AND RECCOUNT("cursor_4c_TmpPro") = 0)
                        IF USED("cursor_4c_TmpPro")
                            USE IN cursor_4c_TmpPro
                        ENDIF
                        loc_cMensagem = "Existe Uma Referencia Antiga Inv" + CHR(225) + "lida!!!"
                        loc_lSucesso = loc_cMensagem
                    ENDIF
                    IF USED("cursor_4c_TmpPro") AND RECCOUNT("cursor_4c_TmpPro") > 0
                        SELECT cursor_4c_TmpPro
                        REPLACE BarraAnt WITH NVL(cursor_4c_TmpPro.Cbars, 0) IN csContas
                        USE IN cursor_4c_TmpPro
                    ENDIF
                ENDIF

                IF par_lManterBarra AND csContas.BarraAnt = 0
                    loc_cMensagem = "Existe Uma Referencia Antigo Sem Barra !!!"
                    loc_lSucesso = loc_cMensagem
                ENDIF

                IF EMPTY(csContas.CprosNov)
                    loc_cMensagem = "Existe Uma Referencia Nova Inv" + CHR(225) + "lida!!!"
                    loc_lSucesso = loc_cMensagem
                ENDIF

                IF csContas.CprosAnt = csContas.CprosNov
                    loc_cMensagem = "Existe Uma Referencia Antiga e Uma Referencia Nova Com o Mesmo C" + CHR(243) + "digo!!!"
                    loc_lSucesso = loc_cMensagem
                ENDIF

                loc_cSQL = "SELECT a.Cgrus, b.Cestoqs FROM SigCdPro a " + ;
                    "JOIN SigCdGrp b ON a.Cgrus = b.Cgrus " + ;
                    "WHERE a.Cpros = " + EscaparSQL(ALLTRIM(csContas.CprosNov))
                IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_LocalPro") > 0
                    IF USED("cursor_4c_LocalPro") AND RECCOUNT("cursor_4c_LocalPro") > 0
                        SELECT cursor_4c_LocalPro
                        loc_cEstoqsNov = ALLTRIM(NVL(cursor_4c_LocalPro.Cestoqs, ""))
                        USE IN cursor_4c_LocalPro

                        loc_cSQL = "SELECT a.Cgrus, b.Cestoqs FROM SigCdPro a " + ;
                            "JOIN SigCdGrp b ON a.Cgrus = b.Cgrus " + ;
                            "WHERE a.Cpros = " + EscaparSQL(ALLTRIM(csContas.CprosAnt))
                        IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_LocalPro2") > 0
                            IF USED("cursor_4c_LocalPro2") AND RECCOUNT("cursor_4c_LocalPro2") > 0
                                SELECT cursor_4c_LocalPro2
                                IF ALLTRIM(NVL(cursor_4c_LocalPro2.Cestoqs, "")) <> loc_cEstoqsNov
                                    USE IN cursor_4c_LocalPro2
                                    loc_cMensagem = "Existe Uma Referencia Antiga e Uma Referencia Nova com Controle de Estoque diferente!!!"
                                    loc_lSucesso = loc_cMensagem
                                ENDIF
                            ENDIF
                            IF USED("cursor_4c_LocalPro2")
                                USE IN cursor_4c_LocalPro2
                            ENDIF
                        ENDIF
                    ELSE
                        IF USED("cursor_4c_LocalPro")
                            USE IN cursor_4c_LocalPro
                        ENDIF
                    ENDIF
                ENDIF
            ENDSCAN
        CATCH TO loc_oErro
            loc_cMensagem = "Erro na valida" + CHR(231) + CHR(227) + "o: " + loc_oErro.Message
        ENDTRY

        RETURN loc_cMensagem
    ENDFUNC

    *--------------------------------------------------------------------------
    * InserirPendencia - Insere linha em SigOpClC para rec?lculo posterior
    * Chamado no loop de processamento para cada produto/empresa
    *--------------------------------------------------------------------------
    FUNCTION InserirPendencia(par_cEmps, par_cCpros, par_dData)
        LOCAL loc_lSucesso, loc_oErro, loc_cSQL, loc_cCidChaves
        loc_lSucesso = .F.

        TRY
            loc_cCidChaves = fUniqueIds()
            loc_cSQL = "INSERT INTO SigOpClC (Emps, CPros, EmpCPros, Datas, Usuars, CidChaves) VALUES (" + ;
                EscaparSQL(par_cEmps) + ", " + ;
                EscaparSQL(par_cCpros) + ", " + ;
                EscaparSQL(par_cEmps + par_cCpros) + ", " + ;
                FormatarDataSQL(par_dData) + ", " + ;
                EscaparSQL(THIS.this_cUsuar) + ", " + ;
                EscaparSQL(loc_cCidChaves) + ")"

            IF SQLEXEC(gnConnHandle, loc_cSQL) < 1
                loc_lSucesso = .F.
            ENDIF
            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao inserir pend" + CHR(234) + "ncia em SigOpClC")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * ImportarXLS - Importa pares de substitui??o de planilha Excel para csContas
    * Retorna n?mero de registros importados com sucesso
    *--------------------------------------------------------------------------
    FUNCTION ImportarXLS(par_cArquivoXLS, par_lCheckCadPro)
        LOCAL loc_nImportados, loc_oErro, loc_cSQL, loc_cCprosAnt, loc_cCprosNov
        loc_nImportados = 0

        TRY
            IF !FILE(par_cArquivoXLS)
                MsgErro("Arquivo Excel n" + CHR(227) + "o encontrado: " + par_cArquivoXLS, "Erro")
                loc_lSucesso = 0
            ENDIF

            IF USED("cursor_4c_Importa")
                USE IN cursor_4c_Importa
            ENDIF

            CREATE CURSOR cursor_4c_Importa (CprosAnt C(14), CprosNov C(14))
            INDEX ON CprosAnt TAG CprosAnt

            SELECT cursor_4c_Importa
            APPEND FROM (par_cArquivoXLS) TYPE XLS

            SELECT cursor_4c_Importa
            SCAN
                loc_cCprosAnt = ALLTRIM(cursor_4c_Importa.CprosAnt)
                loc_cCprosNov = ALLTRIM(cursor_4c_Importa.CprosNov)

                IF EMPTY(loc_cCprosAnt) OR EMPTY(loc_cCprosNov) OR loc_cCprosAnt = loc_cCprosNov
                    LOOP
                ENDIF

                IF !par_lCheckCadPro
                    loc_cSQL = "SELECT TOP 1 Cpros FROM SigCdPro WHERE Cpros = " + ;
                        EscaparSQL(loc_cCprosAnt)
                    IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_TmpPro") < 1
                        IF USED("cursor_4c_TmpPro")
                            USE IN cursor_4c_TmpPro
                        ENDIF
                        LOOP
                    ENDIF
                    IF !USED("cursor_4c_TmpPro") OR RECCOUNT("cursor_4c_TmpPro") = 0
                        IF USED("cursor_4c_TmpPro")
                            USE IN cursor_4c_TmpPro
                        ENDIF
                        LOOP
                    ENDIF
                    IF USED("cursor_4c_TmpPro")
                        USE IN cursor_4c_TmpPro
                    ENDIF
                ENDIF

                SELECT csContas
                SET ORDER TO Duplica
                IF !SEEK(loc_cCprosAnt + loc_cCprosNov)
                    APPEND BLANK
                    REPLACE CprosAnt WITH loc_cCprosAnt, CprosNov WITH loc_cCprosNov
                    loc_nImportados = loc_nImportados + 1
                ENDIF
            ENDSCAN

            SELECT csContas
            SET ORDER TO
            GO BOTTOM

            IF USED("cursor_4c_Importa")
                USE IN cursor_4c_Importa
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao importar planilha Excel")
        ENDTRY

        RETURN loc_nImportados
    ENDFUNC

ENDDEFINE


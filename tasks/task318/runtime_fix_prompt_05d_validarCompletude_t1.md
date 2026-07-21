# CORRIGIR ERRO DE RUNTIME VFP9

## TAREFA OBRIGATORIA
O formulario VFP9 apresentou erro de runtime durante teste automatizado.
Voce DEVE corrigir o erro e salvar os arquivos corrigidos usando Write tool.

## ERRO DETECTADO
- Etapa: 05d_validarCompletude
- Tentativa: 1/10
- Mensagem: Validacao de completude falhou. Procedures vazias/TODOs encontrados:
[SigPrPcpBO.prg] Indicador de pendencia: * Processar - Processa OPs pendente
[SigPrPcpBO.prg] Indicador de pendencia: *-- Buscar OPs pendente
[SigPrPcpBO.prg] Indicador de pendencia: *-- Buscar OPs pendente

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

### FORM (C:\4c\projeto\app\forms\operacionais\FormSigPrPcp.prg):
*==============================================================================
* FormSigPrPcp.prg - Priorizacao de Operacoes para Planejamento de Producao
* Tipo: OPERACIONAL - layout flat customizado (sem PageFrame)
* Migrado de: SIGPRPCP.SCX
* Fase 8/8 - COMPLETO: Todos os metodos implementados
*
* OBJETOS MIGRADOS (100%):
*   cnt_4c_Sombra + lbl_4c_Sombra + lbl_4c_Titulo  (cntSombra do legado)
*   grd_4c_Dados  (Grade 6 colunas - grade principal de selecao)
*   grd_4c_Itens  (GradeItem 4 colunas - itens da OP selecionada)
*   cmd_4c_Confirmar (Salva), cmd_4c_Cancelar (Sair)
*   txt_4c_Info (Text1 - identificacao da OP), lbl_4c_Cliente, txt_4c_Cliente
*   lbl_4c_Ordenacao, cbo_4c_Ordenacao (Cmb_Concilia - ordenacao da grade)
*   lbl_4c_TabDica (Label1 - dica TAB)
*   shp_4c_Shape4 + img_4c_FigJpg (foto do produto - Visible=.F. por padrao)
*
* NOTA: Nenhum campo de lookup (F4/F5) - original tem todos os campos
* somente-leitura ou preenchidos programaticamente via AfterRowColChange.
* Os uticos campos editaveis sao Column1 (Priors) da grade principal.
*==============================================================================

DEFINE CLASS FormSigPrPcp AS FormBase

    *-- Propriedades visuais (copiadas exatamente do original SIGPRPCP)
    Height       = 600
    Width        = 800
    Caption      = "Prioriza" + CHR(231) + CHR(227) + "o de Opera" + CHR(231) + CHR(245) + "es para Planejamento de Produ" + CHR(231) + CHR(227) + "o"
    AutoCenter   = .T.
    BorderStyle  = 2
    TitleBar     = 0
    DataSession  = 2
    ShowWindow   = 1
    WindowType   = 1
    ControlBox   = .F.
    Closable     = .F.
    MaxButton    = .F.
    MinButton    = .F.
    Movable      = .F.
    ClipControls = .F.
    ShowTips     = .T.
    KeyPreview   = .T.

    *-- Estado / Negocio
    this_oBusinessObject = .NULL.
    this_cArquivoTempImg = ""

    *==========================================================================
    PROCEDURE Init()
    *==========================================================================
        *-- DataSession=2 reseta SET DATE/CENTURY (regra 9.4)
        SET DATE TO BRITISH
        SET CENTURY ON
        RETURN DODEFAULT()
    ENDPROC

    *==========================================================================
    PROTECTED PROCEDURE InicializarForm
    *==========================================================================
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        TRY
            THIS.this_oBusinessObject = CREATEOBJECT("SigPrPcpBO")
            IF VARTYPE(THIS.this_oBusinessObject) # "O"
                MsgErro("Erro ao criar objeto de neg" + CHR(243) + "cio SigPrPcpBO.", "Erro")
            ELSE
                THIS.this_cArquivoTempImg = SYS(2023) + "\SigPrPcp.jpg"

                IF !THIS.this_oBusinessObject.ObterConfiguracaoPam()
                    MsgErro("Falha ao carregar configura" + CHR(231) + CHR(227) + "o do sistema (SigCdPam).", "Erro")
                ELSE
                    *-- Criar cursor base para dados PCP (zTmppPcp do legado)
                    SET NULL ON
                    CREATE CURSOR cursor_4c_PcpDados ( ;
                        Priors    N(6)    NULL, ;
                        Nenvs     N(10)   NULL, ;
                        Nops      N(10)   NULL, ;
                        Emps      C(3)    NULL, ;
                        Dopes     C(20)   NULL, ;
                        Numes     N(6)    NULL, ;
                        Contas    C(10)   NULL, ;
                        Rclis     C(40)   NULL, ;
                        PrazoEnts T       NULL, ;
                        Cpros     C(14)   NULL, ;
                        Qtds      N(9,3)  NULL, ;
                        aPriors   N(6)    NULL  ;
                    )
                    SET NULL OFF

                    IF !THIS.this_oBusinessObject.Processar("cursor_4c_PcpDados")
                        MsgErro("Erro no Processamento dos Dados...", "Erro")
                    ELSE
                        *-- Criar cursor de selecao consolidado (zTmpSelecao do legado)
                        SET NULL ON
                        SELECT DISTINCT Emps, Dopes, Numes, Contas, Rclis, ;
                                        PrazoEnts, Priors, aPriors ;
                            FROM cursor_4c_PcpDados ;
                            INTO CURSOR cursor_4c_Selecao READWRITE
                        SET NULL OFF

                        *-- Indexar cursor de selecao para ordenacao
                        SELECT cursor_4c_Selecao
                        INDEX ON Emps + Dopes + STR(Numes,6) TAG EmpdopNum
                        INDEX ON DTOS(PrazoEnts) + Emps + Dopes + STR(Numes,6) TAG Entrega
                        INDEX ON Contas TAG Cliente
                        INDEX ON STR(Priors,6) + Emps + Dopes + STR(Numes,6) TAG Prioridade
                        SET ORDER TO Entrega

                        *-- Indexar cursor de dados PCP para RELATION
                        SELECT cursor_4c_PcpDados
                        INDEX ON Emps + Dopes + STR(Numes,6) TAG EmpdopNum
                        GO TOP

                        *-- Estabelecer relacao entre cursores (como SET RELATION do legado)
                        SELECT cursor_4c_Selecao
                        GO TOP
                        SET RELATION TO Emps + Dopes + STR(Numes,6) INTO cursor_4c_PcpDados

                        *-- Montar interface visual
                        THIS.ConfigurarPageFrame()
                        THIS.ConfigurarCabecalho()
                        THIS.ConfigurarPaginaLista()
                        THIS.ConfigurarBotoes()
                        THIS.ConfigurarPaginaDados()
                        THIS.ConfigurarControlesAuxiliares()
                        THIS.ConfigurarImagemProduto()
                        THIS.TornarControlesVisiveis()

                        *-- Propagar titulo para labels do cabecalho
                        THIS.cnt_4c_Sombra.lbl_4c_Sombra.Caption = THIS.Caption
                        THIS.cnt_4c_Sombra.lbl_4c_Titulo.Caption = THIS.Caption

                        *-- Carregar dados nos grids e vincular eventos
                        THIS.CarregarGrades()
                        THIS.VincularEventos()

                        loc_lSucesso = .T.
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
                    " PROC=" + loc_oErro.Procedure, ;
                    "Erro FormSigPrPcp.InicializarForm")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * ConfigurarPageFrame - OPERACIONAL: sem PageFrame, fundo via Picture
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPageFrame
        THIS.Picture      = gc_4c_CaminhoBase + "..\..\..\Framework\imagens\new_background.jpg"
        THIS.ClipControls = .F.
    ENDPROC

    *==========================================================================
    * ConfigurarCabecalho - Container escuro com titulo (cntSombra do legado)
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarCabecalho
        THIS.AddObject("cnt_4c_Sombra", "Container")
        WITH THIS.cnt_4c_Sombra
            .Visible     = .T.
            .Top         = 0
            .Left        = 0
            .Width       = THIS.Width
            .Height      = 80
            .BorderWidth = 0
            .BackColor   = RGB(100,100,100)
        ENDWITH
        THIS.cnt_4c_Sombra.AddObject("lbl_4c_Sombra", "Label")
        WITH THIS.cnt_4c_Sombra.lbl_4c_Sombra
            .FontBold      = .T.
            .FontName      = "Tahoma"
            .FontSize      = 18
            .FontUnderline = .F.
            .WordWrap      = .T.
            .Alignment     = 0
            .AutoSize      = .F.
            .BackStyle     = 0
            .Caption       = THIS.Caption
            .Height        = 40
            .Left          = 10
            .Top           = 18
            .Width         = THIS.Width
            .ForeColor     = RGB(0,0,0)
            .Visible       = .T.
        ENDWITH
        THIS.cnt_4c_Sombra.AddObject("lbl_4c_Titulo", "Label")
        WITH THIS.cnt_4c_Sombra.lbl_4c_Titulo
            .FontBold   = .T.
            .FontName   = "Tahoma"
            .FontSize   = 18
            .WordWrap   = .T.
            .Alignment  = 0
            .AutoSize   = .F.
            .BackStyle  = 0
            .Caption    = THIS.Caption
            .Height     = 46
            .Left       = 10
            .Top        = 17
            .Width      = THIS.Width
            .ForeColor  = RGB(255,255,255)
            .Visible    = .T.
        ENDWITH
    ENDPROC

    *==========================================================================
    * TornarControlesVisiveis - Torna controles do form visiveis recursivamente
    * NOTA: img_4c_FigJpg e shp_4c_Shape4 sao excluidos (Visible=.F. por default)
    *==========================================================================
    PROTECTED PROCEDURE TornarControlesVisiveis
        LOCAL loc_nI, loc_oObj
        FOR loc_nI = 1 TO THIS.ControlCount
            loc_oObj = THIS.Controls(loc_nI)
            IF VARTYPE(loc_oObj) = "O"
                IF INLIST(UPPER(loc_oObj.Name), "IMG_4C_FIGJPG", "SHP_4C_SHAPE4")
                    THIS.TornarSubControlesVisiveis(loc_oObj)
                    LOOP
                ENDIF
                IF PEMSTATUS(loc_oObj, "Visible", 5)
                    loc_oObj.Visible = .T.
                ENDIF
                IF PEMSTATUS(loc_oObj, "ControlCount", 5) AND loc_oObj.ControlCount > 0
                    THIS.TornarSubControlesVisiveis(loc_oObj)
                ENDIF
            ENDIF
        ENDFOR
    ENDPROC

    *==========================================================================
    * TornarSubControlesVisiveis - Recursao interna de TornarControlesVisiveis
    *==========================================================================
    PROTECTED PROCEDURE TornarSubControlesVisiveis(par_oContainer)
        LOCAL loc_nI, loc_oObj
        FOR loc_nI = 1 TO par_oContainer.ControlCount
            loc_oObj = par_oContainer.Controls(loc_nI)
            IF VARTYPE(loc_oObj) = "O"
                IF PEMSTATUS(loc_oObj, "Visible", 5)
                    loc_oObj.Visible = .T.
                ENDIF
                IF PEMSTATUS(loc_oObj, "ControlCount", 5) AND loc_oObj.ControlCount > 0
                    THIS.TornarSubControlesVisiveis(loc_oObj)
                ENDIF
            ENDIF
        ENDFOR
    ENDPROC

    *==========================================================================
    * ConfigurarPaginaLista - Monta a "lista" (grade principal Dados + grade Itens
    * + container de botoes de acao) equivalente a Page1 do padrao CRUD.
    * Em forms OPERACIONAIS sem PageFrame, este metodo consolida a configuracao
    * da area principal de trabalho (grids + botoes canonicos Confirmar/Sair).
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPaginaLista
        *-- Grade principal (Grade do legado) - lado esquerdo, 6 colunas
        THIS.AddObject("grd_4c_Dados", "Grid")
        WITH THIS.grd_4c_Dados
            .Top           = 110
            .Left          = 0
            .Width         = 469
            .Height        = 398
            .ColumnCount   = 6
            .FontName      = "Tahoma"
            .FontSize      = 8
            .DeleteMark    = .F.
            .RecordMark    = .F.
            .ReadOnly      = .T.
            .RowHeight     = 16
            .ScrollBars    = 2
            .GridLineColor = RGB(238,238,238)
            .Visible       = .T.

            WITH .Column1
                .Width             = 50
                .Movable           = .F.
                .Resizable         = .F.
                .ReadOnly          = .F.
                .Header1.Caption   = "Prioridade"
                .Header1.Alignment = 2
                .Header1.ForeColor = RGB(0,0,0)
                .Text1.InputMask   = "999999"
                .Text1.BorderStyle = 0
                .Text1.Margin      = 0
                .Text1.ForeColor   = RGB(0,0,0)
                .Text1.BackColor   = RGB(255,255,255)
            ENDWITH

            WITH .Column2
                .Width             = 31
                .Movable           = .F.
                .Resizable         = .F.
                .ReadOnly          = .T.
                .Header1.Caption   = "Emp"
                .Header1.Alignment = 2
                .Header1.ForeColor = RGB(0,0,0)
                .Text1.BorderStyle = 0
                .Text1.Margin      = 0
                .Text1.ForeColor   = RGB(0,0,0)
                .Text1.BackColor   = RGB(255,255,255)
            ENDWITH

            WITH .Column3
                .Width             = 150
                .Movable           = .F.
                .Resizable         = .F.
                .ReadOnly          = .T.
                .Header1.Caption   = "Opera" + CHR(231) + CHR(227) + "o"
                .Header1.Alignment = 2
                .Header1.ForeColor = RGB(0,0,0)
                .Text1.BorderStyle = 0
                .Text1.Margin      = 0
                .Text1.ForeColor   = RGB(0,0,0)
                .Text1.BackColor   = RGB(255,255,255)
            ENDWITH

            WITH .Column4
                .Width             = 52
                .Movable           = .F.
                .Resizable         = .F.
                .ReadOnly          = .T.
                .Header1.Caption   = "Codigo"
                .Header1.Alignment = 2
                .Header1.ForeColor = RGB(0,0,0)
                .Text1.BorderStyle = 0
                .Text1.Margin      = 0
                .Text1.ForeColor   = RGB(0,0,0)
                .Text1.BackColor   = RGB(255,255,255)
            ENDWITH

            WITH .Column5
                .Width             = 80
                .Movable           = .F.
                .Resizable         = .F.
                .ReadOnly          = .T.
                .Header1.Caption   = "Cliente"
                .Header1.Alignment = 2
                .Header1.ForeColor = RGB(0,0,0)
                .Text1.BorderStyle = 0
                .Text1.Margin      = 0
                .Text1.ForeColor   = RGB(0,0,0)
                .Text1.BackColor   = RGB(255,255,255)
            ENDWITH

            WITH .Column6
                .Width             = 80
                .Movable           = .F.
                .Resizable         = .F.
                .ReadOnly          = .T.
                .Header1.Caption   = "Prazo.Entrega"
                .Header1.Alignment = 2
                .Header1.ForeColor = RGB(0,0,0)
                .Text1.BorderStyle = 0
                .Text1.Margin      = 0
                .Text1.ForeColor   = RGB(0,0,0)
                .Text1.BackColor   = RGB(255,255,255)
            ENDWITH
        ENDWITH

        *-- Grade de itens (GradeItem do legado) - lado direito, 4 colunas
        THIS.AddObject("grd_4c_Itens", "Grid")
        WITH THIS.grd_4c_Itens
            .Top           = 131
            .Left          = 470
            .Width         = 329
            .Height        = 325
            .ColumnCount   = 4
            .FontName      = "Tahoma"
            .FontSize      = 8
            .DeleteMark    = .F.
            .RecordMark    = .F.
            .ReadOnly      = .T.
            .RowHeight     = 16
            .ScrollBars    = 2
            .GridLineColor = RGB(238,238,238)
            .Visible       = .T.

            WITH .Column1
                .Width             = 80
                .Movable           = .F.
                .Resizable         = .F.
                .ReadOnly          = .T.
                .Header1.Caption   = "Envelope"
                .Header1.Alignment = 2
                .Header1.ForeColor = RGB(0,0,0)
                .Text1.BorderStyle = 0
                .Text1.Margin      = 0
                .Text1.ForeColor   = RGB(0,0,0)
                .Text1.BackColor   = RGB(255,255,255)
            ENDWITH

            WITH .Column2
                .Width             = 80
                .Movable           = .F.
                .Resizable         = .F.
                .ReadOnly          = .T.
                .Header1.Caption   = "O.P."
                .Header1.Alignment = 2
                .Header1.ForeColor = RGB(0,0,0)
                .Text1.BorderStyle = 0
                .Text1.Margin      = 0
                .Text1.ForeColor   = RGB(0,0,0)
                .Text1.BackColor   = RGB(255,255,255)
            ENDWITH

            WITH .Column3
                .Width             = 108
                .Movable           = .F.
                .Resizable         = .F.
                .ReadOnly          = .T.
                .Header1.Caption   = "Produto"
                .Header1.Alignment = 2
                .Header1.ForeColor = RGB(0,0,0)
                .Text1.BorderStyle = 0
                .Text1.Margin      = 0
                .Text1.ForeColor   = RGB(0,0,0)
                .Text1.BackColor   = RGB(255,255,255)
            ENDWITH

            WITH .Column4
                .Width              = 52
                .Movable            = .F.
                .Resizable          = .F.
                .ReadOnly           = .T.
                .Header1.Caption    = "Qtde"
                .Header1.Alignment  = 2
                .Header1.ForeColor  = RGB(0,0,0)
                .Text1.InputMask    = "9999.99"
                .Text1.BorderStyle  = 0
                .Text1.Margin       = 0
                .Text1.ForeColor    = RGB(0,0,0)
                .Text1.BackColor    = RGB(255,255,255)
            ENDWITH
        ENDWITH
    ENDPROC

    *==========================================================================
    * ConfigurarBotoes - Cria botoes Confirmar e Cancelar
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarBotoes
        *-- Botao Confirmar (Salva do legado)
        THIS.AddObject("cmd_4c_Confirmar", "CommandButton")
        WITH THIS.cmd_4c_Confirmar
            .Top        = 3
            .Left       = 650
            .Height     = 75
            .Width      = 75
            .FontBold   = .T.
            .FontItalic = .T.
            .FontName   = "Comic Sans MS"
            .FontSize   = 8
            .WordWrap   = .F.
            .Picture    = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
            .Caption    = "Confirmar"
            .ForeColor  = RGB(90,90,90)
            .BackColor  = RGB(255,255,255)
            .Themes           = .T.
            .Visible    = .T.
        ENDWITH

        *-- Botao Cancelar/Sair (Sair do legado)
        THIS.AddObject("cmd_4c_Cancelar", "CommandButton")
        WITH THIS.cmd_4c_Cancelar
            .Top        = 3
            .Left       = 725
            .Height     = 75
            .Width      = 75
            .FontBold   = .T.
            .FontItalic = .T.
            .FontName   = "Comic Sans MS"
            .FontSize   = 8
            .WordWrap   = .F.
            .Picture    = gc_4c_CaminhoIcones + "cadastro_cancelar_60.jpg"
            .Cancel     = .T.
            .Caption    = "Encerrar"
            .ForeColor  = RGB(90,90,90)
            .BackColor  = RGB(255,255,255)
            .Themes           = .T.
            .Visible    = .T.
        ENDWITH
    ENDPROC

    *==========================================================================
    * ConfigurarPaginaDados - Controles de exibicao auxiliares (equivalente a
    * "Page2 Dados" nos forms CRUD). Para este form OPERACIONAL sem PageFrame,
    * agrupa os controles de exibicao de contexto da operacao selecionada:
    * txt_4c_Info (identificacao da OP), lbl_4c_Cliente e txt_4c_Cliente.
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPaginaDados
        *-- Caixa de identificacao da operacao selecionada (Text1 do legado)
        *-- Exibe: "EMP OPERACAO NUMES" ao navegar na grade principal
        THIS.AddObject("txt_4c_Info", "TextBox")
        WITH THIS.txt_4c_Info
            .Top         = 110
            .Left        = 470
            .Width       = 329
            .Height      = 21
            .FontBold    = .T.
            .FontName    = "Tahoma"
            .FontSize    = 8
            .Alignment   = 2
            .ForeColor   = RGB(0,0,0)
            .BackColor   = RGB(0,128,255)
            .ReadOnly    = .T.
            .BorderStyle = 0
            .Value       = ""
            .Visible     = .T.
        ENDWITH

        *-- Label "Cliente" (Say3 do legado)
        THIS.AddObject("lbl_4c_Cliente", "Label")
        WITH THIS.lbl_4c_Cliente
            .AutoSize   = .T.
            .FontBold   = .F.
            .FontItalic = .F.
            .FontName   = "Tahoma"
            .FontSize   = 8
            .BackStyle  = 0
            .Caption    = "Cliente"
            .Left       = 23
            .Top        = 515
            .ForeColor  = RGB(90,90,90)
            .Visible    = .T.
        ENDWITH

        *-- Caixa do cliente (Get_Cliente do legado - somente leitura, preenchida via Grade)
        THIS.AddObject("txt_4c_Cliente", "TextBox")
        WITH THIS.txt_4c_Cliente
            .FontBold    = .T.
            .FontName    = "Tahoma"
            .FontSize    = 8
            .Height      = 23
            .Left        = 60
            .Top         = 512
            .Width       = 411
            .ForeColor   = RGB(0,0,0)
            .BackColor   = RGB(255,255,221)
            .ReadOnly    = .T.
            .BorderStyle = 0
            .Value       = ""
            .Visible     = .T.
        ENDWITH
    ENDPROC

    *==========================================================================
    * ConfigurarControlesAuxiliares - Cria controles de filtros e ordenacao
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarControlesAuxiliares
        *-- Label "Ordenacao" (lbl_lancamentos do legado)
        THIS.AddObject("lbl_4c_Ordenacao", "Label")
        WITH THIS.lbl_4c_Ordenacao
            .AutoSize   = .T.
            .FontBold   = .F.
            .FontItalic = .F.
            .FontName   = "Tahoma"
            .FontSize   = 8
            .BackStyle  = 0
            .Caption    = "Ordena" + CHR(231) + CHR(227) + "o :"
            .Left       = 16
            .Top        = 545
            .ForeColor  = RGB(90,90,90)
            .Visible    = .T.
        ENDWITH

        *-- ComboBox de ordenacao (Cmb_Concilia do legado)
        THIS.AddObject("cbo_4c_Ordenacao", "ComboBox")
        WITH THIS.cbo_4c_Ordenacao
            .FontName      = "Tahoma"
            .FontSize      = 8
            .RowSourceType = 0
            .Style         = 2
            .Height        = 24
            .Left          = 80
            .Top           = 540
            .Width         = 140
            .Visible       = .T.
        ENDWITH

        *-- Label de dica TAB (Label1 do legado)
        THIS.AddObject("lbl_4c_TabDica", "Label")
        WITH THIS.lbl_4c_TabDica
            .AutoSize   = .T.
            .FontBold   = .F.
            .FontItalic = .F.
            .FontName   = "Tahoma"
            .FontSize   = 8
            .BackStyle  = 0
            .Caption    = "[ < TAB > para mudar de Grade ] "
            .Left       = 306
            .Top        = 545
            .ForeColor  = RGB(90,90,90)
            .Visible    = .T.
        ENDWITH
    ENDPROC

    *==========================================================================
    * ConfigurarImagemProduto - Cria shape e imagem do produto (ocultos por padrao)
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarImagemProduto
        *-- Shape de fundo (Shape4 do legado)
        THIS.AddObject("shp_4c_Shape4", "Shape")
        WITH THIS.shp_4c_Shape4
            .Top         = 461
            .Left        = 480
            .Width       = 148
            .Height      = 109
            .BackStyle   = 0
            .BorderColor = RGB(90,90,90)
            .Visible     = .F.
        ENDWITH

        *-- Imagem do produto (FigJpg do legado)
        THIS.AddObject("img_4c_FigJpg", "Image")
        WITH THIS.img_4c_FigJpg
            .Stretch = 1
            .Top     = 463
            .Left    = 483
            .Width   = 143
            .Height  = 105
            .Visible = .F.
        ENDWITH
    ENDPROC

    *==========================================================================
    * CarregarGrades - Configura RecordSource/ControlSource e popula combo
    *==========================================================================
    PROTECTED PROCEDURE CarregarGrades
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        TRY
            IF !USED("cursor_4c_Selecao") OR !USED("cursor_4c_PcpDados")
                MsgErro("Cursores de dados n" + CHR(227) + "o inicializados.", "Erro")
            ELSE
                *-- Vincular grade principal ao cursor de selecao
                WITH THIS.grd_4c_Dados
                    .ColumnCount           = 6
                    .RecordSource          = "cursor_4c_Selecao"
                    .Column1.ControlSource = "cursor_4c_Selecao.Priors"
                    .Column2.ControlSource = "cursor_4c_Selecao.Emps"
                    .Column3.ControlSource = "cursor_4c_Selecao.Dopes"
                    .Column4.ControlSource = "cursor_4c_Selecao.Numes"
                    .Column5.ControlSource = "cursor_4c_Selecao.Contas"
                    .Column6.ControlSource = "cursor_4c_Selecao.PrazoEnts"
                    .Refresh()
                ENDWITH

                *-- Vincular grade de itens ao cursor de dados PCP
                WITH THIS.grd_4c_Itens
                    .ColumnCount           = 4
                    .RecordSource          = "cursor_4c_PcpDados"
                    .Column1.ControlSource = "cursor_4c_PcpDados.Nenvs"
                    .Column2.ControlSource = "cursor_4c_PcpDados.Nops"
                    .Column3.ControlSource = "cursor_4c_PcpDados.Cpros"
                    .Column4.ControlSource = "cursor_4c_PcpDados.Qtds"
                    .Refresh()
                ENDWITH

                *-- Popular combo de ordenacao (itens sem acento, como no legado)
                WITH THIS.cbo_4c_Ordenacao
                    .Clear()
                    .AddItem("Operacao")
                    .AddItem("Cliente")
                    .AddItem("Prazo Entrega")
                    .AddItem("Prioridade")
                    .Value = "Prazo Entrega"
                ENDWITH

                *-- Posicionar e atualizar painel de info
                SELECT cursor_4c_PcpDados
                GO TOP
                SELECT cursor_4c_Selecao
                GO TOP
                THIS.grd_4c_Dados.SetFocus()
                THIS.GrdDadosAfterRowColChange(1)

                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
                    " PROC=" + loc_oErro.Procedure, ;
                    "Erro FormSigPrPcp.CarregarGrades")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * VincularEventos - Estabelece BINDEVENTs para eventos dos controles
    *==========================================================================
    PROTECTED PROCEDURE VincularEventos
        BINDEVENT(THIS.grd_4c_Dados, "AfterRowColChange", THIS, "GrdDadosAfterRowColChange")
        BINDEVENT(THIS.grd_4c_Itens, "AfterRowColChange", THIS, "GrdItensAfterRowColChange")
        BINDEVENT(THIS.grd_4c_Dados.Column1.Text1, "KeyPress", THIS, "GrdDadosCol1LostFocus")
        BINDEVENT(THIS.grd_4c_Itens.Column1.Text1, "KeyPress", THIS, "GrdItensCol1LostFocus")
        BINDEVENT(THIS.cbo_4c_Ordenacao, "InteractiveChange", THIS, "CboOrdenacaoInteractiveChange")
        BINDEVENT(THIS.cmd_4c_Confirmar, "Click", THIS, "BtnConfirmarClick")
        BINDEVENT(THIS.cmd_4c_Cancelar, "Click", THIS, "BtnCancelarClick")
    ENDPROC

    *==========================================================================
    * AlternarPagina - Alterna foco entre a grade principal (1) e a grade de
    * itens (2). Em OPERACIONAL sem PageFrame, este metodo cumpre o papel do
    * <TAB> descrito no rodape do form legado ("[ <TAB> para mudar de Grade ]").
    *==========================================================================
    PROCEDURE AlternarPagina(par_nPagina)
        LOCAL loc_nPagina
        loc_nPagina = IIF(VARTYPE(par_nPagina) = "N" AND par_nPagina > 0, par_nPagina, 1)
        DO CASE
            CASE loc_nPagina = 1
                IF PEMSTATUS(THIS, "grd_4c_Dados", 5)
                    THIS.grd_4c_Dados.SetFocus()
                    THIS.grd_4c_Dados.Refresh()
                ENDIF
            CASE loc_nPagina = 2
                IF PEMSTATUS(THIS, "grd_4c_Itens", 5)
                    THIS.grd_4c_Itens.SetFocus()
                    THIS.grd_4c_Itens.Refresh()
                ENDIF
        ENDCASE
    ENDPROC

    *==========================================================================
    * GrdDadosAfterRowColChange - Atualiza paineis ao mudar linha na grade principal
    *==========================================================================
    PROCEDURE GrdDadosAfterRowColChange
        LPARAMETERS par_nColIndex
        IF !USED("cursor_4c_Selecao")
            RETURN
        ENDIF
        THIS.LockScreen = .T.
        SELECT cursor_4c_Selecao
        THIS.txt_4c_Cliente.Value = NVL(cursor_4c_Selecao.Rclis, "")
        THIS.txt_4c_Cliente.Refresh()
        SELECT cursor_4c_PcpDados
        GO TOP
        THIS.grd_4c_Itens.Refresh()
        THIS.img_4c_FigJpg.Visible = .F.
        THIS.img_4c_FigJpg.Picture = ""
        SELECT cursor_4c_Selecao
        THIS.txt_4c_Info.Value = NVL(cursor_4c_Selecao.Emps, "") + " " + ;
            ALLTRIM(NVL(cursor_4c_Selecao.Dopes, "")) + " " + ;
            STR(NVL(cursor_4c_Selecao.Numes, 0), 6)
        THIS.LockScreen = .F.
    ENDPROC

    *==========================================================================
    * GrdItensAfterRowColChange - Carrega foto do produto ao mudar linha nos itens
    *==========================================================================
    PROCEDURE GrdItensAfterRowColChange
        LPARAMETERS par_nColIndex
        LOCAL loc_cCpros
        IF !USED("cursor_4c_PcpDados")
            RETURN
        ENDIF
        THIS.LockScreen = .T.
        THIS.img_4c_FigJpg.Visible = .F.
        THIS.img_4c_FigJpg.Picture = ""
        THIS.shp_4c_Shape4.Visible = .F.
        SELECT cursor_4c_PcpDados
        IF !EOF("cursor_4c_PcpDados")
            loc_cCpros = NVL(cursor_4c_PcpDados.Cpros, "")
            IF !EMPTY(loc_cCpros)
                IF THIS.this_oBusinessObject.ObterImagemProduto(loc_cCpros, THIS.this_cArquivoTempImg)
                    THIS.img_4c_FigJpg.Picture = THIS.this_cArquivoTempImg
                    THIS.img_4c_FigJpg.Visible = .T.
                    THIS.shp_4c_Shape4.Visible = .T.
                ENDIF
            ENDIF
        ENDIF
        SELECT cursor_4c_PcpDados
        THIS.LockScreen = .F.
    ENDPROC

    *==========================================================================
    * GrdDadosCol1LostFocus - TAB na coluna Prioridade salta para grade de itens
    *==========================================================================
    PROCEDURE GrdDadosCol1LostFocus
        LPARAMETERS par_nKeyCode, par_nShiftAltCtrl
        IF LASTKEY() = 9
            THIS.grd_4c_Itens.SetFocus()
        ENDIF
    ENDPROC

    *==========================================================================
    * GrdItensCol1LostFocus - TAB na coluna Envelope retorna para grade principal
    *==========================================================================
    PROCEDURE GrdItensCol1LostFocus
        LPARAMETERS par_nKeyCode, par_nShiftAltCtrl
        IF LASTKEY() = 9
            THIS.grd_4c_Dados.SetFocus()
        ENDIF
    ENDPROC

    *==========================================================================
    * CboOrdenacaoInteractiveChange - Reordena grade principal ao mudar combo
    *==========================================================================
    PROCEDURE CboOrdenacaoInteractiveChange
        IF !USED("cursor_4c_Selecao")
            RETURN
        ENDIF
        SELECT cursor_4c_Selecao
        SET RELATION TO
        SET ORDER TO
        DO CASE
            CASE ALLTRIM(THIS.cbo_4c_Ordenacao.Value) = "Prazo Entrega"
                SET ORDER TO Entrega
            CASE ALLTRIM(THIS.cbo_4c_Ordenacao.Value) = "Cliente"
                SET ORDER TO Cliente
            CASE ALLTRIM(THIS.cbo_4c_Ordenacao.Value) = "Operacao"
                SET ORDER TO EmpDopNum
            CASE ALLTRIM(THIS.cbo_4c_Ordenacao.Value) = "Prioridade"
                SET ORDER TO Prioridade
        ENDCASE
        SELECT cursor_4c_Selecao
        SET RELATION TO Emps + Dopes + STR(Numes,6) INTO cursor_4c_PcpDados
        THIS.grd_4c_Dados.Refresh()
    ENDPROC

    *==========================================================================
    * BtnConfirmarClick - Grava prioridades no banco (Salva.Click do legado)
    *==========================================================================
    PROCEDURE BtnConfirmarClick
        IF !USED("cursor_4c_Selecao")
            MsgAviso("Dados de sele" + CHR(231) + CHR(227) + "o n" + CHR(227) + "o dispon" + CHR(237) + "veis.")
            RETURN
        ENDIF
        IF !MsgConfirma("Confirma Grava" + CHR(231) + CHR(227) + "o dos Dados!!!")
            RETURN
        ENDIF
        IF THIS.this_oBusinessObject.GravarPrioridades("cursor_4c_Selecao")
            THIS.Release()
        ENDIF
    ENDPROC

    *==========================================================================
    * BtnCancelarClick - Confirma abandono da priorizacao (Sair.Click do legado)
    *==========================================================================
    PROCEDURE BtnCancelarClick
        IF MsgConfirma("Deseja Realmente abandonar Prioriza" + CHR(231) + CHR(227) + "o")
            THIS.Release()
        ENDIF
    ENDPROC

    *==========================================================================
    * BtnIncluirClick - Ativa edicao de prioridades (foco na grade principal)
    * Mapeamento OPERACIONAL: "incluir" = iniciar entrada de dados de prioridade
    * na coluna Priors da grade principal, posicionando no topo da lista.
    *==========================================================================
    PROCEDURE BtnIncluirClick()
        LOCAL loc_oErro
        TRY
            IF !USED("cursor_4c_Selecao") OR RECCOUNT("cursor_4c_Selecao") = 0
                MsgAviso("N" + CHR(227) + "o existem opera" + CHR(231) + CHR(245) + ;
                         "es para priorizar.", "Aviso")
                RETURN
            ENDIF
            SELECT cursor_4c_Selecao
            GO TOP
            THIS.grd_4c_Dados.Refresh()
            THIS.GrdDadosAfterRowColChange(1)
            THIS.grd_4c_Dados.SetFocus()
            THIS.grd_4c_Dados.ActivateCell(1, 1)
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo), ;
                    "Erro BtnIncluir")
        ENDTRY
    ENDPROC

    *==========================================================================
    * BtnAlterarClick - Edita prioridade da linha selecionada na grade principal
    * Mapeamento OPERACIONAL: "alterar" = editar a coluna Priors da linha corrente
    *==========================================================================
    PROCEDURE BtnAlterarClick()
        LOCAL loc_oErro, loc_nLinha
        TRY
            IF !USED("cursor_4c_Selecao") OR RECCOUNT("cursor_4c_Selecao") = 0
                MsgAviso("N" + CHR(227) + "o existem opera" + CHR(231) + CHR(245) + ;
                         "es para alterar.", "Aviso")
                RETURN
            ENDIF
            SELECT cursor_4c_Selecao
            IF EOF() OR BOF()
                GO TOP
            ENDIF
            loc_nLinha = THIS.grd_4c_Dados.RelativeRow
            IF loc_nLinha < 1
                loc_nLinha = 1
            ENDIF
            THIS.grd_4c_Dados.SetFocus()
            THIS.grd_4c_Dados.ActivateCell(loc_nLinha, 1)
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo), ;
                    "Erro BtnAlterar")
        ENDTRY
    ENDPROC

    *==========================================================================
    * BtnVisualizarClick - Recarrega/reprocessa dados dos grids do zero
    * Mapeamento OPERACIONAL: "visualizar" = refresh completo (reprocessa PCP)
    *==========================================================================
    PROCEDURE BtnVisualizarClick()
        LOCAL loc_oErro
        TRY
            IF !MsgConfirma("Recarregar todos os dados descarta as altera" + ;
                            CHR(231) + CHR(245) + "es n" + CHR(227) + "o gravadas." + ;
                            CHR(13) + "Confirma?")
                RETURN
            ENDIF
            THIS.LockScreen = .T.

            *-- Encerrar relacao e cursores para reprocessar
            IF USED("cursor_4c_Selecao")
                SELECT cursor_4c_Selecao
                SET RELATION TO
                USE IN cursor_4c_Selecao
            ENDIF
            IF USED("cursor_4c_PcpDados")
                USE IN cursor_4c_PcpDados
            ENDIF

            *-- Recriar cursor base
            SET NULL ON
            CREATE CURSOR cursor_4c_PcpDados ( ;
                Priors    N(6)    NULL, ;
                Nenvs     N(10)   NULL, ;
                Nops      N(10)   NULL, ;
                Emps      C(3)    NULL, ;
                Dopes     C(20)   NULL, ;
                Numes     N(6)    NULL, ;
                Contas    C(10)   NULL, ;
                Rclis     C(40)   NULL, ;
                PrazoEnts T       NULL, ;
                Cpros     C(14)   NULL, ;
                Qtds      N(9,3)  NULL, ;
                aPriors   N(6)    NULL  ;
            )
            SET NULL OFF

            IF THIS.this_oBusinessObject.Processar("cursor_4c_PcpDados")
                *-- Recriar cursor de selecao consolidado
                SET NULL ON
                SELECT DISTINCT Emps, Dopes, Numes, Contas, Rclis, ;
                                PrazoEnts, Priors, aPriors ;
                    FROM cursor_4c_PcpDados ;
                    INTO CURSOR cursor_4c_Selecao READWRITE
                SET NULL OFF

                *-- Reindexar
                SELECT cursor_4c_Selecao
                INDEX ON Emps + Dopes + STR(Numes,6) TAG EmpdopNum
                INDEX ON DTOS(PrazoEnts) + Emps + Dopes + STR(Numes,6) TAG Entrega
                INDEX ON Contas TAG Cliente
                INDEX ON STR(Priors,6) + Emps + Dopes + STR(Numes,6) TAG Prioridade
                SET ORDER TO Entrega

                SELECT cursor_4c_PcpDados
                INDEX ON Emps + Dopes + STR(Numes,6) TAG EmpdopNum
                GO TOP

                SELECT cursor_4c_Selecao
                GO TOP
                SET RELATION TO Emps + Dopes + STR(Numes,6) INTO cursor_4c_PcpDados

                *-- Revincular grids aos cursores recriados
                THIS.CarregarGrades()
                MsgInfo("Dados recarregados com sucesso.", "Visualizar")
            ELSE
                MsgErro("Falha ao reprocessar dados PCP.", "Erro Visualizar")
            ENDIF

            THIS.LockScreen = .F.
        CATCH TO loc_oErro
            THIS.LockScreen = .F.
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo), ;
                    "Erro BtnVisualizar")
        ENDTRY
    ENDPROC

    *==========================================================================
    * BtnExcluirClick - Zera prioridade da linha selecionada (Priors = 0)
    * Mapeamento OPERACIONAL: "excluir" = remover a prioridade (voltar ao default)
    *==========================================================================
    PROCEDURE BtnExcluirClick()
        LOCAL loc_oErro
        TRY
            IF !USED("cursor_4c_Selecao") OR RECCOUNT("cursor_4c_Selecao") = 0
                MsgAviso("N" + CHR(227) + "o existem opera" + CHR(231) + CHR(245) + ;
                         "es para atualizar.", "Aviso")
                RETURN
            ENDIF
            SELECT cursor_4c_Selecao
            IF EOF() OR BOF()
                MsgAviso("Selecione uma linha na grade antes de zerar a prioridade.", ;
                         "Aviso")
                RETURN
            ENDIF
            IF NVL(cursor_4c_Selecao.Priors, 0) = 0
                MsgAviso("A prioridade desta opera" + CHR(231) + CHR(227) + ;
                         "o j" + CHR(225) + " est" + CHR(225) + " zerada.", "Aviso")
                RETURN
            ENDIF
            IF !MsgConfirma("Zerar prioridade da opera" + CHR(231) + CHR(227) + "o selecionada?")
                RETURN
            ENDIF
            REPLACE cursor_4c_Selecao.Priors WITH 0
            THIS.grd_4c_Dados.Refresh()
            THIS.GrdDadosAfterRowColChange(1)
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo), ;
                    "Erro BtnExcluir")
        ENDTRY
    ENDPROC

    *==========================================================================
    * CarregarLista - Recarrega os grids (wrapper publico de CarregarGrades)
    *==========================================================================
    PROCEDURE CarregarLista()
        THIS.CarregarGrades()
    ENDPROC

    *==========================================================================
    * FormParaBO - Carrega propriedades do BO a partir da linha corrente do cursor
    *==========================================================================
    PROCEDURE FormParaBO()
        IF USED("cursor_4c_Selecao") AND !EOF("cursor_4c_Selecao")
            THIS.this_oBusinessObject.CarregarDoCursor("cursor_4c_Selecao")
        ENDIF
    ENDPROC

    *==========================================================================
    * BOParaForm - Atualiza controles de exibicao a partir das props do BO
    *==========================================================================
    PROCEDURE BOParaForm()
        LOCAL loc_oBO
        loc_oBO = THIS.this_oBusinessObject
        THIS.txt_4c_Info.Value    = ALLTRIM(loc_oBO.this_cEmps) + " " + ;
                                    ALLTRIM(loc_oBO.this_cDopes) + " " + ;
                                    STR(loc_oBO.this_nNumes, 6)
        THIS.txt_4c_Cliente.Value = loc_oBO.this_cRclis
        THIS.txt_4c_Info.Refresh()
        THIS.txt_4c_Cliente.Refresh()
    ENDPROC

    *==========================================================================
    * HabilitarCampos - Habilita/desabilita controles conforme disponibilidade
    *==========================================================================
    PROCEDURE HabilitarCampos()
        LOCAL loc_lTemDados
        loc_lTemDados = USED("cursor_4c_Selecao") AND RECCOUNT("cursor_4c_Selecao") > 0
        IF PEMSTATUS(THIS, "cmd_4c_Confirmar", 5)
            THIS.cmd_4c_Confirmar.Enabled = loc_lTemDados
        ENDIF
        IF PEMSTATUS(THIS, "cbo_4c_Ordenacao", 5)
            THIS.cbo_4c_Ordenacao.Enabled = loc_lTemDados
        ENDIF
        IF PEMSTATUS(THIS, "grd_4c_Dados", 5)
            THIS.grd_4c_Dados.Enabled = loc_lTemDados
        ENDIF
        IF PEMSTATUS(THIS, "grd_4c_Itens", 5)
            THIS.grd_4c_Itens.Enabled = loc_lTemDados
        ENDIF
    ENDPROC

    *==========================================================================
    * LimparCampos - Limpa controles de exibicao e oculta imagem do produto
    *==========================================================================
    PROCEDURE LimparCampos()
        THIS.txt_4c_Info.Value    = ""
        THIS.txt_4c_Cliente.Value = ""
        THIS.img_4c_FigJpg.Visible  = .F.
        THIS.img_4c_FigJpg.Picture  = ""
        THIS.shp_4c_Shape4.Visible  = .F.
    ENDPROC

    *==========================================================================
    * AjustarBotoesPorModo - Habilita botao Confirmar apenas se houver dados
    *==========================================================================
    PROCEDURE AjustarBotoesPorModo()
        LOCAL loc_lTemDados
        loc_lTemDados = USED("cursor_4c_Selecao") AND RECCOUNT("cursor_4c_Selecao") > 0
        IF PEMSTATUS(THIS, "cmd_4c_Confirmar", 5)
            THIS.cmd_4c_Confirmar.Enabled = loc_lTemDados
        ENDIF
    ENDPROC

    *==========================================================================
    * BtnBuscarClick - Volta ao topo da grade principal e reposiciona painel
    * Mapeamento OPERACIONAL: "buscar" = posicionar no inicio da lista
    *==========================================================================
    PROCEDURE BtnBuscarClick()
        LOCAL loc_oErro
        TRY
            IF !USED("cursor_4c_Selecao") OR RECCOUNT("cursor_4c_Selecao") = 0
                MsgAviso("N" + CHR(227) + "o existem opera" + CHR(231) + CHR(245) + "es para exibir.")
                RETURN
            ENDIF
            SELECT cursor_4c_Selecao
            GO TOP
            THIS.grd_4c_Dados.Refresh()
            THIS.GrdDadosAfterRowColChange(1)
            THIS.grd_4c_Dados.SetFocus()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo), ;
                    "Erro BtnBuscar")
        ENDTRY
    ENDPROC

    *==========================================================================
    * BtnSalvarClick - Alias de BtnConfirmarClick (padrao FormBase)
    *==========================================================================
    PROCEDURE BtnSalvarClick()
        THIS.BtnConfirmarClick()
    ENDPROC

    *==========================================================================
    * BtnEncerrarClick - Alias de BtnCancelarClick (padrao FormBase canonico)
    *==========================================================================
    PROCEDURE BtnEncerrarClick()
        THIS.BtnCancelarClick()
    ENDPROC

    *==========================================================================
    PROCEDURE Destroy()
    *==========================================================================
        *-- Encerrar relacao entre cursores antes de fechar
        IF USED("cursor_4c_Selecao")
            SELECT cursor_4c_Selecao
            SET RELATION TO
            USE IN cursor_4c_Selecao
        ENDIF
        IF USED("cursor_4c_PcpDados")
            USE IN cursor_4c_PcpDados
        ENDIF
        *-- Remover arquivo temporario de imagem de produto
        IF !EMPTY(THIS.this_cArquivoTempImg) AND FILE(THIS.this_cArquivoTempImg)
            ERASE (THIS.this_cArquivoTempImg)
        ENDIF
        THIS.this_oBusinessObject = .NULL.
        DODEFAULT()
    ENDPROC

ENDDEFINE


### BO (C:\4c\projeto\app\classes\SigPrPcpBO.prg):
*==============================================================================
* SigPrPcpBO.prg - Business Object: Priorizacao de Operacoes para PCP
* Tabela principal: SigMvCab (UPDATE Priors)
* Formulario: FormSigPrPcp.prg
*==============================================================================
DEFINE CLASS SigPrPcpBO AS BusinessBase

    *-- Tabela e chave (alvo do UPDATE de prioridades)
    this_cTabela      = "SigMvCab"
    this_cCampoChave  = "EmpDopNums"

    *-- Parametros de configuracao (lidos de SigCdPam)
    this_cOperacao    = ""   && DoppPads - tipo de operacao para planejamento
    this_cServico     = ""   && DoppServs - tipo de servico para planejamento

    *-- Registro corrente do cursor zTmpSelecao / zTmppPcp
    this_nPriors      = 0    && Priors n(6)   - prioridade atual (editavel)
    this_nNenvs       = 0    && nenvs n(10)   - numero envelope
    this_nNops        = 0    && Nops n(10)    - numero OP (SigPdMvf.NOps)
    this_cEmps        = ""   && Emps c(3)     - codigo empresa
    this_cDopes       = ""   && Dopes c(20)   - codigo operacao
    this_nNumes       = 0    && Numes n(6)    - numero da ordem de producao
    this_cContas      = ""   && Contas c(10)  - codigo conta/cliente (SigCdCli.Iclis)
    this_cRclis       = ""   && Rclis c(40)   - razao social do cliente
    this_tPrazoEnts   = {}   && PrazoEnts T   - prazo de entrega (DateTime)
    this_cCpros       = ""   && Cpros c(14)   - codigo do produto (SigCdPro)
    this_nQtds        = 0    && Qtds n(9,3)   - quantidade da OP
    this_nAPriors     = 0    && aPriors n(6)  - prioridade original antes de editar

    *-- Chave concatenada usada em INDEX e RELATION
    this_cEmpDopNum   = ""   && Emps + Dopes + Str(Numes,6)

    *-- Contexto de processamento (SigCdOpd)
    this_cNivels      = ""   && Nivels - nivel da operacao (SigCdOpd)
    this_nChkDests    = 0    && ChkDests n(1,0) - flag destino (SigCdOpd): 3=ignorar

    *-- Dados do item de grade (SigOpPic + SigMvCab + SigCdOpe)
    this_cContaOs     = ""   && ContaOs c(10) - conta origem (SigMvCab)
    this_cContaDs     = ""   && ContaDs c(10) - conta destino (SigMvCab)
    this_nGlobalizas  = 0    && Globalizas n(1,0) - flag globalizacao (SigCdOpe)
    this_nServicos    = 0    && Servicos n(1,0)   - flag servico (SigCdOpe)

    *--------------------------------------------------------------------------
    * Init - Configura tabela e chave; chama BusinessBase.Init via DODEFAULT
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        THIS.this_cTabela     = "SigMvCab"
        THIS.this_cCampoChave = "EmpDopNums"
        DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Retorna chave concatenada do registro corrente
    *--------------------------------------------------------------------------
    FUNCTION ObterChavePrimaria()
        RETURN THIS.this_cEmps + THIS.this_cDopes + STR(THIS.this_nNumes, 6)
    ENDFUNC

    *--------------------------------------------------------------------------
    * ObterConfiguracaoPam - Le DoppPads e DoppServs de SigCdPam
    * Popula: this_cOperacao, this_cServico
    *--------------------------------------------------------------------------
    FUNCTION ObterConfiguracaoPam()
        LOCAL loc_cSQL, loc_lSucesso, loc_oErro
        loc_lSucesso = .F.
        TRY
            loc_cSQL = "Select DoppPads, DoppServs From SigCdPam"
            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Pam") > 0
                IF USED("cursor_4c_Pam") AND RECCOUNT("cursor_4c_Pam") > 0
                    SELECT cursor_4c_Pam
                    THIS.this_cOperacao = ALLTRIM(NVL(DoppPads, ""))
                    THIS.this_cServico  = ALLTRIM(NVL(DoppServs, ""))
                    loc_lSucesso = .T.
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        IF USED("cursor_4c_Pam")
            USE IN cursor_4c_Pam
        ENDIF
        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Carrega propriedades this_* a partir de cursor
    * par_cAliasCursor: alias do cursor (zTmppPcp ou zTmpSelecao)
    *--------------------------------------------------------------------------
    FUNCTION CarregarDoCursor(par_cAliasCursor)
        IF USED(par_cAliasCursor)
            SELECT (par_cAliasCursor)
            THIS.this_nPriors    = NVL(Priors, 0)
            THIS.this_nNenvs     = NVL(Nenvs, 0)
            THIS.this_nNops      = NVL(Nops, 0)
            THIS.this_cEmps      = ALLTRIM(NVL(Emps, ""))
            THIS.this_cDopes     = ALLTRIM(NVL(Dopes, ""))
            THIS.this_nNumes     = NVL(Numes, 0)
            THIS.this_cContas    = ALLTRIM(NVL(Contas, ""))
            THIS.this_cRclis     = ALLTRIM(NVL(Rclis, ""))
            THIS.this_tPrazoEnts = NVL(PrazoEnts, {})
            THIS.this_cCpros     = ALLTRIM(NVL(Cpros, ""))
            THIS.this_nQtds      = NVL(Qtds, 0)
            THIS.this_nAPriors   = NVL(aPriors, 0)
            THIS.this_cEmpDopNum = THIS.this_cEmps + THIS.this_cDopes + STR(THIS.this_nNumes, 6)
            RETURN .T.
        ENDIF
        RETURN .F.
    ENDFUNC

    *--------------------------------------------------------------------------
    * Processar - Processa OPs pendentes e popula cursor destino (zTmppPcp)
    * Requer: ObterConfiguracaoPam() chamado antes
    * par_cCursorDestino: cursor criado pelo Form (estrutura zTmppPcp)
    *--------------------------------------------------------------------------
    FUNCTION Processar(par_cCursorDestino)
        LOCAL loc_lSucesso, loc_lAbortar, loc_cSQL, loc_oErro, loc_oProg
        LOCAL loc_cEmpresa, loc_lEnvelope, loc_nEnv, loc_cCliente, loc_cRclis
        LOCAL loc_cOpCompara, loc_nPop
        LOCAL loc_nMfasNops, loc_nMfasNenvs, loc_nMfasNumps
        LOCAL loc_nPriors, loc_cEmps, loc_cDopes, loc_nNumes
        LOCAL loc_tPrazoEnts, loc_cCpros, loc_nQtds

        loc_lSucesso  = .F.
        loc_lAbortar  = .F.
        loc_cEmpresa  = go_4c_Sistema.cCodEmpresa

        TRY
            IF USED(par_cCursorDestino)
                SELECT (par_cCursorDestino)
                ZAP
            ENDIF

            *-- Buscar OPs pendentes de Operacao (DoppPads) em SigCdNec
            loc_cSQL = "Select Numps, Dopps, cIdChaves From SigCdNec " + ;
                       "Where EmpDNps Between " + ;
                       EscaparSQL(loc_cEmpresa + THIS.this_cOperacao + STR(0,10)) + ;
                       " And " + ;
                       EscaparSQL(loc_cEmpresa + THIS.this_cOperacao + "9999999999") + ;
                       " And ChkSubn = 0 Order By Numps, Dopps, cIdChaves"
            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_OpPend1") < 1
                loc_lAbortar = .T.
                MsgErro("Favor Reinicializar o Processo!!!", ;
                        "Falha na Conex" + CHR(227) + "o (OpPendente1)")
            ENDIF

            IF !loc_lAbortar
                *-- Buscar OPs pendentes de Servico (DoppServs) em SigCdNec
                loc_cSQL = "Select Numps, Dopps, cIdChaves From SigCdNec " + ;
                           "Where EmpDNps Between " + ;
                           EscaparSQL(loc_cEmpresa + THIS.this_cServico + STR(0,10)) + ;
                           " And " + ;
                           EscaparSQL(loc_cEmpresa + THIS.this_cServico + "9999999999") + ;
                           " And ChkSubn = 0 And 0=1 Order By Numps, Dopps, cIdChaves"
                IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_OpPend2") < 1
                    loc_lAbortar = .T.
                    MsgErro("Favor Reinicializar o Processo!!!", ;
                            "Falha na Conex" + CHR(227) + "o (OpPendente2)")
                ENDIF
            ENDIF

            IF !loc_lAbortar
                *-- Unir cursores de Operacao e Servico
                SELECT 0 AS Priors, Numps, Dopps FROM cursor_4c_OpPend1 ;
                    UNION ALL ;
                    SELECT 0 AS Priors, Numps, Dopps FROM cursor_4c_OpPend2 ;
                    INTO CURSOR cursor_4c_OpPendente READWRITE

                IF USED("cursor_4c_OpPend1")
                    USE IN cursor_4c_OpPend1
                ENDIF
                IF USED("cursor_4c_OpPend2")
                    USE IN cursor_4c_OpPend2
                ENDIF

                SELECT cursor_4c_OpPendente
                loc_oProg = CREATEOBJECT("fwprogressbar", "Processando Ops ...", RECCOUNT())
                loc_oProg.Show()

                SCAN
                    loc_oProg.Update(.T.)

                    *-- Buscar movimentos de producao (SigPdMvf)
                    loc_cSQL = "Select * From SigPdMvf Where Nops = " + ;
                               FormatarNumeroSQL(cursor_4c_OpPendente.Numps, 0) + ;
                               " Order by Nops, CidChaves desc"
                    SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_TmpMfas")

                    IF !USED("cursor_4c_TmpMfas") OR RECCOUNT("cursor_4c_TmpMfas") = 0
                        IF USED("cursor_4c_TmpMfas")
                            USE IN cursor_4c_TmpMfas
                        ENDIF
                        LOOP
                    ENDIF

                    SELECT cursor_4c_TmpMfas
                    GO TOP
                    IF EMPTY(NVL(cursor_4c_TmpMfas.GrupoDs, ""))
                        USE IN cursor_4c_TmpMfas
                        LOOP
                    ENDIF

                    *-- Salvar valores de TmpMfas antes de trocar work area
                    loc_nMfasNops  = NVL(cursor_4c_TmpMfas.Nops, 0)
                    loc_nMfasNenvs = NVL(cursor_4c_TmpMfas.Nenvs, 0)
                    loc_nMfasNumps = NVL(cursor_4c_TmpMfas.Numps, 0)
                    loc_nPop       = loc_nMfasNops

                    loc_cOpCompara = IIF(ALLTRIM(NVL(cursor_4c_OpPendente.Dopps, "")) = ;
                                        ALLTRIM(THIS.this_cOperacao), ;
                                        THIS.this_cOperacao, THIS.this_cServico)

                    *-- Buscar dados da operacao em SigCdOpd
                    loc_cSQL = "Select * From SigCdOpd Where Dopps = " + ;
                               EscaparSQL(ALLTRIM(cursor_4c_TmpMfas.Dopps))
                    SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_SigCdOpd")

                    IF !USED("cursor_4c_SigCdOpd") OR RECCOUNT("cursor_4c_SigCdOpd") = 0
                        IF USED("cursor_4c_SigCdOpd")
                            USE IN cursor_4c_SigCdOpd
                        ENDIF
                        USE IN cursor_4c_TmpMfas
                        LOOP
                    ENDIF

                    SELECT cursor_4c_SigCdOpd
                    IF NVL(cursor_4c_SigCdOpd.ChkDests, 0) = 3
                        USE IN cursor_4c_SigCdOpd
                        USE IN cursor_4c_TmpMfas
                        LOOP
                    ENDIF

                    loc_lEnvelope = (ALLTRIM(NVL(cursor_4c_SigCdOpd.Nivels, "")) <> ;
                                    ALLTRIM(loc_cOpCompara) OR ;
                                    NVL(cursor_4c_SigCdOpd.ChkDests, 0) = 1)
                    USE IN cursor_4c_SigCdOpd

                    *-- Query principal: SigOpPic + SigMvCab + SigCdOpe agrupados
                    loc_cSQL = "Select a.Nops, Sum(a.Qtds) as Qtds, b.ContaOs, b.ContaDs, " + ;
                               "b.prazoents, b.empdopNums, b.priors, b.Emps, b.Dopes, b.Numes, " + ;
                               "c.Globalizas, c.Servicos, a.cpros " + ;
                               "From SigOpPic a, SigMvCab b, SigCdOpe c " + ;
                               "Where a.Nops = " + FormatarNumeroSQL(loc_nPop, 0) + ;
                               " And a.EmpDopNums = b.EmpDopNums " + ;
                               "And b.Dopes = c.Dopes " + ;
                               "Group by a.Nops, b.ContaOs, b.ContaDs, b.prazoents, " + ;
                               "b.empdopnums, b.priors, b.emps, b.dopes, " + ;
                               "b.numes, c.globalizas, c.Servicos, a.cpros"

                    IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_TmpOpi") < 1
                        USE IN cursor_4c_TmpMfas
                        loc_lAbortar = .T.
                        MsgErro("Favor Reinicializar o Processo!!!", ;
                                "Falha na Conex" + CHR(227) + "o (crTmpOpi)")
                        EXIT
                    ENDIF

                    *-- Processar cada item da OP
                    SELECT cursor_4c_TmpOpi
                    SCAN
                        IF NVL(cursor_4c_TmpOpi.Qtds, 0) <> 0
                            *-- Calcular numero do envelope
                            IF loc_lEnvelope
                                loc_nEnv = loc_nMfasNenvs
                                IF loc_nMfasNenvs = loc_nMfasNops
                                    loc_nEnv = loc_nMfasNumps
                                ENDIF
                            ELSE
                                loc_nEnv = 0
                            ENDIF
                            loc_nEnv = IIF(loc_nEnv = 0, loc_nMfasNops, loc_nEnv)

                            *-- Globalizas=1 ou Servicos=1: usa ContaOs; senao ContaDs
                            IF NVL(cursor_4c_TmpOpi.Globalizas, 0) = 1 OR ;
                               NVL(cursor_4c_TmpOpi.Servicos, 0) = 1
                                loc_cCliente = ALLTRIM(NVL(cursor_4c_TmpOpi.ContaOs, ""))
                            ELSE
                                loc_cCliente = ALLTRIM(NVL(cursor_4c_TmpOpi.ContaDs, ""))
                            ENDIF

                            *-- Buscar razao social do cliente em SigCdCli
                            loc_cSQL = "Select rclis From SigCdCli Where Iclis = " + ;
                                       EscaparSQL(loc_cCliente)
                            SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_TmpCli")
                            loc_cRclis = ""
                            IF USED("cursor_4c_TmpCli") AND RECCOUNT("cursor_4c_TmpCli") > 0
                                SELECT cursor_4c_TmpCli
                                loc_cRclis = ALLTRIM(NVL(rclis, ""))
                            ENDIF
                            IF USED("cursor_4c_TmpCli")
                                USE IN cursor_4c_TmpCli
                            ENDIF

                            *-- Capturar valores de TmpOpi para o REPLACE
                            SELECT cursor_4c_TmpOpi
                            loc_nPriors    = NVL(cursor_4c_TmpOpi.Priors, 0)
                            loc_cEmps      = ALLTRIM(NVL(cursor_4c_TmpOpi.Emps, ""))
                            loc_cDopes     = ALLTRIM(NVL(cursor_4c_TmpOpi.Dopes, ""))
                            loc_nNumes     = NVL(cursor_4c_TmpOpi.Numes, 0)
                            loc_tPrazoEnts = NVL(cursor_4c_TmpOpi.PrazoEnts, {})
                            loc_cCpros     = ALLTRIM(NVL(cursor_4c_TmpOpi.Cpros, ""))
                            loc_nQtds      = NVL(cursor_4c_TmpOpi.Qtds, 0)

                            *-- Inserir no cursor destino
                            SELECT (par_cCursorDestino)
                            APPEND BLANK
                            REPLACE Priors    WITH loc_nPriors, ;
                                    Nenvs     WITH loc_nEnv, ;
                                    Nops      WITH loc_nMfasNops, ;
                                    Emps      WITH loc_cEmps, ;
                                    Dopes     WITH loc_cDopes, ;
                                    Numes     WITH loc_nNumes, ;
                                    Contas    WITH loc_cCliente, ;
                                    Rclis     WITH LEFT(loc_cRclis, 40), ;
                                    PrazoEnts WITH loc_tPrazoEnts, ;
                                    Cpros     WITH loc_cCpros, ;
                                    Qtds      WITH loc_nQtds, ;
                                    aPriors   WITH loc_nPriors
                        ENDIF
                    ENDSCAN

                    IF USED("cursor_4c_TmpOpi")
                        USE IN cursor_4c_TmpOpi
                    ENDIF
                    IF USED("cursor_4c_TmpMfas")
                        USE IN cursor_4c_TmpMfas
                    ENDIF
                ENDSCAN

                IF VARTYPE(loc_oProg) = "O"
                    loc_oProg.Complete()
                    loc_oProg = .NULL.
                ENDIF

                IF !loc_lAbortar
                    loc_lSucesso = .T.
                ENDIF
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        *-- Limpeza de cursores temporarios
        IF USED("cursor_4c_OpPend1")
            USE IN cursor_4c_OpPend1
        ENDIF
        IF USED("cursor_4c_OpPend2")
            USE IN cursor_4c_OpPend2
        ENDIF
        IF USED("cursor_4c_OpPendente")
            USE IN cursor_4c_OpPendente
        ENDIF
        IF USED("cursor_4c_TmpMfas")
            USE IN cursor_4c_TmpMfas
        ENDIF
        IF USED("cursor_4c_SigCdOpd")
            USE IN cursor_4c_SigCdOpd
        ENDIF
        IF USED("cursor_4c_TmpOpi")
            USE IN cursor_4c_TmpOpi
        ENDIF
        IF USED("cursor_4c_TmpCli")
            USE IN cursor_4c_TmpCli
        ENDIF

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * Atualizar - Atualiza prioridade de uma OP individual em SigMvCab
    * Usa: this_nPriors, this_cEmps, this_cDopes, this_nNumes
    *--------------------------------------------------------------------------
    FUNCTION Atualizar()
        LOCAL loc_lSucesso, loc_cSQL, loc_oErro
        loc_lSucesso = .F.
        TRY
            loc_cSQL = "Update SigMvCab Set Priors = " + ;
                       FormatarNumeroSQL(THIS.this_nPriors, 0) + ;
                       " Where EmpDopNums = " + ;
                       EscaparSQL(THIS.ObterChavePrimaria())
            IF SQLEXEC(gnConnHandle, loc_cSQL) > 0
                THIS.RegistrarAuditoria("ATUALIZAR")
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * GravarPrioridades - Grava todas as prioridades alteradas em lote
    * par_cCursorSelecao: cursor com os registros (ex: "zTmpSelecao")
    * Ignora registros onde Priors=0 E aPriors=0 (sem alteracao)
    *--------------------------------------------------------------------------
    FUNCTION GravarPrioridades(par_cCursorSelecao)
        LOCAL loc_lSucesso, loc_lTransacao, loc_cSQL, loc_oErro
        LOCAL loc_cEdn, loc_nPriors

        loc_lSucesso   = .T.
        loc_lTransacao = .F.

        TRY
            SQLEXEC(gnConnHandle, "BEGIN TRANSACTION")
            loc_lTransacao = .T.

            SELECT (par_cCursorSelecao)
            GO TOP
            SCAN
                IF NVL(Priors, 0) = 0 AND NVL(aPriors, 0) = 0
                    LOOP
                ENDIF

                loc_nPriors = NVL(Priors, 0)
                loc_cEdn    = ALLTRIM(NVL(Emps, "")) + ;
                              ALLTRIM(NVL(Dopes, "")) + ;
                              STR(NVL(Numes, 0), 6)

                loc_cSQL = "Update SigMvCab Set Priors = " + ;
                           FormatarNumeroSQL(loc_nPriors, 0) + ;
                           " Where EmpDopNums = " + EscaparSQL(loc_cEdn)

                IF SQLEXEC(gnConnHandle, loc_cSQL) < 0
                    loc_lSucesso = .F.
                    EXIT
                ENDIF
            ENDSCAN

            IF loc_lSucesso
                SQLEXEC(gnConnHandle, "COMMIT")
                THIS.RegistrarAuditoria("GRAVARPRIORIDADES")
            ELSE
                SQLEXEC(gnConnHandle, "ROLLBACK")
                MsgErro("N" + CHR(227) + "o foi poss" + CHR(237) + "vel completar " + ;
                        "o processamento (commit). Tente novamente!!", ;
                        "Falha na Grava" + CHR(231) + CHR(227) + "o")
            ENDIF

        CATCH TO loc_oErro
            IF loc_lTransacao
                SQLEXEC(gnConnHandle, "ROLLBACK")
            ENDIF
            MsgErro(loc_oErro.Message, "Erro")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * ObterImagemProduto - Busca e grava imagem Base64 de SigCdPro em arquivo
    * par_cCpros: codigo do produto
    * par_cArquivoDestino: caminho completo do arquivo temporario
    * Retorna: .T. se imagem obtida e gravada com sucesso
    *--------------------------------------------------------------------------
    FUNCTION ObterImagemProduto(par_cCpros, par_cArquivoDestino)
        LOCAL loc_lSucesso, loc_cSQL, loc_oErro, loc_cFoto
        loc_lSucesso = .F.
        TRY
            loc_cSQL = "Select FigJpgs From SigCdPro Where Cpros = " + ;
                       EscaparSQL(par_cCpros)
            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_TmpPro") > 0
                IF USED("cursor_4c_TmpPro") AND RECCOUNT("cursor_4c_TmpPro") > 0
                    SELECT cursor_4c_TmpPro
                    IF !EMPTY(NVL(cursor_4c_TmpPro.FigJpgs, ""))
                        loc_cFoto = STRCONV(STRTRAN(STRTRAN(STRTRAN( ;
                                    cursor_4c_TmpPro.FigJpgs, ;
                                    "data:image/png;base64,", ""), ;
                                    "data:image/jpeg;base64,", ""), ;
                                    "data:image/jpg;base64,", ""), 14)
                        IF STRTOFILE(loc_cFoto, par_cArquivoDestino) > 0
                            loc_lSucesso = .T.
                        ENDIF
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        IF USED("cursor_4c_TmpPro")
            USE IN cursor_4c_TmpPro
        ENDIF
        RETURN loc_lSucesso
    ENDFUNC

ENDDEFINE


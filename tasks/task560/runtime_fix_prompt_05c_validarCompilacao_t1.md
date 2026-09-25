# CORRIGIR ERRO DE RUNTIME VFP9

## TAREFA OBRIGATORIA
O formulario VFP9 apresentou erro de runtime durante teste automatizado.
Voce DEVE corrigir o erro e salvar os arquivos corrigidos usando Write tool.

## ERRO DETECTADO
- Etapa: 05c_validarCompilacao
- Tentativa: 1/10
- Mensagem: C:\4c\projeto\app\classes\sigmvcabBO.prg: Excecao: Line is too long.

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

### FORM (C:\4c\projeto\app\forms\cadastros\Formsigmvcab.prg):
*==============================================================================
* Formsigmvcab.prg - Formulario de Movimentacao (Cabecalho)
* Migrado de: SIGMVCAB.SCX (frmcadastro)
*
* FASE 3/8: Form - Estrutura Base (PageFrame, cabecalhos nas duas paginas)
* FASE 4/8: Form - Grid e Botoes CRUD (Page1)
* - grd_4c_Lista (Emps/Dopes/Numes/Datas/ContaOs/ContaDs/Valos) ligado a
*   cursor_4c_Dados (sigmvcabBO.Buscar, TOP 300 ORDER BY Datas DESC)
* - cnt_4c_Botoes: Incluir/Visualizar/Alterar/Excluir/Buscar
* - cnt_4c_Saida: Encerrar (padrao canonico, regra #10)
* - CarregarLista()/AlternarPagina()/TornarControlesVisiveis()/FormatarGridLista()
* FASE 5/8: Form - Campos principais da Page2 (parte 1/2 - identificacao)
* - txt_4c_Emps/Dopes/Numes (linha 1), txt_4c_Datas (linha 2)
* - txt_4c_GrupoOs/ContaOs (linha 3), txt_4c_GrupoDs/ContaDs (linha 4)
* - txt_4c_Vends (linha 5)
* - Layout simplificado direto na Page2 (sem reproduzir o PageFrame interno
*   pgfPrincipal/pgContas do legado); abas Operacional/Informacoes completas
*   ficam fora do escopo desta migracao simplificada.
* FASE 6/8: Form - Campos restantes (parte 2) e lookups completos
* - txt_4c_Tabds/Lprecos (linha 6), txt_4c_Jobs/Fpubls (linha 7),
*   txt_4c_Valos (linha 8), txt_4c_Obses memo (linha 9)
* - cnt_4c_BotoesAcao: cmd_4c_Confirmar/cmd_4c_Cancelar + BtnSalvarClick/
*   BtnCancelarClick
* - FormParaBO()/BOParaForm()/LimparCampos()/HabilitarCampos() ligados aos
*   fluxos de Incluir/Alterar/Visualizar/Salvar
* - Lookups (F4/DblClick) completos para GrupoOs/ContaOs/GrupoDs/ContaDs/
*   Vends via AbrirBuscaGrupoConta() (Grupo=SigCdGcr Codigos/Descrs,
*   Conta/Vendedor=SigCdCli Iclis/Rclis)
* FASE 7/8: Form - BtnBuscarClick (FormBuscaAuxiliar por EmpDopNums +
*   LocalizarNaLista), BtnEncerrarClick, Destroy() liberando cursores
* FASE 8/8: Form - Consolidacao final: AjustarBotoesPorModo() (Confirmar
*   desabilitado + Cancelar vira "Voltar" em VISUALIZAR), chamado junto com
*   HabilitarCampos() em BtnIncluirClick/BtnAlterarClick/BtnVisualizarClick.
*   Integracao com config.prg (ADIR dinamico, ja cobre classes\*BO.prg e
*   forms\cadastros\Form*.prg) e menu.prg (AbrirFormsigmvcab + popMovimentos
*   Bar 1) conferida e correta.
*==============================================================================

DEFINE CLASS Formsigmvcab AS FormBase

    *-- Propriedades visuais (PILAR 1 - UX FIDELITY: Height/Width EXATOS do original)
    Height      = 600
    Width       = 1050
    Caption     = "Movimenta" + CHR(231) + CHR(227) + "o"
    AutoCenter  = .T.
    ShowWindow  = 1
    WindowType  = 1
    ControlBox  = .F.
    TitleBar    = 0
    Themes      = .F.
    BorderStyle = 2

    *-- Propriedades de estado
    this_oBusinessObject = .NULL.
    this_cModoAtual      = "LISTA"

    *===========================================================================
    * Init - Inicializa o formulario
    * REGRA CRITICA: Apenas RETURN DODEFAULT()
    * FormBase.Init() ja chama InicializarForm() - NAO duplicar a chamada!
    *===========================================================================
    PROCEDURE Init()
        RETURN DODEFAULT()
    ENDPROC

    *===========================================================================
    * InicializarForm - Configura estrutura completa
    * Chamado automaticamente pelo FormBase.Init() via DODEFAULT()
    *===========================================================================
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            THIS.this_oBusinessObject = CREATEOBJECT("sigmvcabBO")

            IF VARTYPE(THIS.this_oBusinessObject) != "O"
                MostrarErro("Erro ao criar sigmvcabBO" + CHR(13) + ;
                    "VARTYPE retornou: " + VARTYPE(THIS.this_oBusinessObject), ;
                    "Formsigmvcab.InicializarForm")
            ELSE
                THIS.ConfigurarPageFrame()

                *-- Regra #11 (CLAUDE.md): faixa do cabecalho nas DUAS paginas
                THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
                THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
                THIS.pgf_4c_Paginas.Page2.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
                THIS.pgf_4c_Paginas.Page2.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption

                THIS.pgf_4c_Paginas.Visible = .T.
                THIS.pgf_4c_Paginas.ActivePage = 1
                THIS.this_cModoAtual = "LISTA"

                IF TYPE("gb_4c_ValidandoUI") != "L" OR !gb_4c_ValidandoUI
                    THIS.CarregarLista()
                ENDIF

                loc_lSucesso = .T.
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao inicializar Formsigmvcab:" + CHR(13) + ;
                loException.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loException.LineNo), ;
                "Formsigmvcab.InicializarForm")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *===========================================================================
    * ConfigurarPageFrame - Cria PageFrame com Page1 (Lista) e Page2 (Dados)
    * Top=-29 para esconder abas; controles compensam +29 no Top
    *===========================================================================
    PROTECTED PROCEDURE ConfigurarPageFrame()
        THIS.AddObject("pgf_4c_Paginas", "PageFrame")

        WITH THIS.pgf_4c_Paginas
            .PageCount = 2
            .Top       = -29
            .Left      = 0
            .Width     = THIS.Width
            .Height    = THIS.Height + 29
            .Tabs      = .F.
            .Visible   = .T.

            .Page1.Caption   = "Lista"
            .Page1.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
            .Page1.BackColor = RGB(255, 255, 255)

            .Page2.Caption   = "Dados"
            .Page2.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
            .Page2.BackColor = RGB(255, 255, 255)
        ENDWITH

        THIS.ConfigurarPaginaLista()
        THIS.ConfigurarPaginaDados()
    ENDPROC

    *===========================================================================
    * ConfigurarPaginaLista - Configura Page1 com Grid e botoes CRUD completos
    * Colunas do grid: Emps, Dopes, Numes, Datas, ContaOs, ContaDs, Valos
    * (cursor_4c_Dados do sigmvcabBO.Buscar; cidchaves vem junto, oculto)
    *===========================================================================
    PROTECTED PROCEDURE ConfigurarPaginaLista()
        LOCAL loc_oPagina
        loc_oPagina = THIS.pgf_4c_Paginas.Page1

        *-- Fundo padrao do framework frmcadastro (sem isso a pagina fica branca)
        loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"

        *-- Container Cabecalho (cntSombra no legado) - PRIMEIRO AddObject da pagina (regra #11)
        loc_oPagina.AddObject("cnt_4c_Cabecalho", "Container")
        WITH loc_oPagina.cnt_4c_Cabecalho
            .Top         = 29
            .Left        = 0
            .Width       = THIS.Width
            .Height      = 80
            .BackColor   = RGB(100, 100, 100)
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH

        loc_oPagina.cnt_4c_Cabecalho.AddObject("lbl_4c_Sombra", "Label")
        WITH loc_oPagina.cnt_4c_Cabecalho.lbl_4c_Sombra
            .Caption   = THIS.Caption
            .Top       = 15
            .Left      = 10
            .Width     = THIS.Width - 20
            .Height    = 40
            .FontName  = "Tahoma"
            .FontSize  = 16
            .FontBold  = .T.
            .ForeColor = RGB(0, 0, 0)
            .BackStyle = 0
            .AutoSize  = .F.
            .Visible   = .T.
        ENDWITH

        loc_oPagina.cnt_4c_Cabecalho.AddObject("lbl_4c_Titulo", "Label")
        WITH loc_oPagina.cnt_4c_Cabecalho.lbl_4c_Titulo
            .Caption   = THIS.Caption
            .Top       = 18
            .Left      = 10
            .Width     = THIS.Width - 20
            .Height    = 46
            .FontName  = "Tahoma"
            .FontSize  = 16
            .FontBold  = .T.
            .ForeColor = RGB(255, 255, 255)
            .BackStyle = 0
            .AutoSize  = .F.
            .Visible   = .T.
        ENDWITH

        *-- Container Botoes CRUD (Grupo_op no legado) - canonico
        loc_oPagina.AddObject("cnt_4c_Botoes", "Container")
        WITH loc_oPagina.cnt_4c_Botoes
            .Top         = 29
            .Left        = 542
            .Width       = 390
            .Height      = 85
            .BackStyle   = 0
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH

        *-- Botao Incluir (Left=5)
        loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Incluir", "CommandButton")
        WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Incluir
            .Caption         = "Incluir"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_inserir_26.jpg"
            .PicturePosition = 13
            .Top             = 5
            .Left            = 5
            .Width           = 75
            .Height          = 75
            .FontName        = "Tahoma"
            .FontBold        = .T.
            .FontItalic      = .T.
            .FontSize        = 8
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .Themes          = .F.
            .SpecialEffect   = 0
            .MousePointer    = 15
            .WordWrap        = .T.
            .AutoSize        = .F.
            .Visible         = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Incluir, "Click", THIS, "BtnIncluirClick")

        *-- Botao Visualizar (Left=80)
        loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Visualizar", "CommandButton")
        WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar
            .Caption         = "Visualizar"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_vizualizar_60.jpg"
            .PicturePosition = 13
            .Top             = 5
            .Left            = 80
            .Width           = 75
            .Height          = 75
            .FontName        = "Tahoma"
            .FontBold        = .T.
            .FontItalic      = .T.
            .FontSize        = 8
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .Themes          = .F.
            .SpecialEffect   = 0
            .MousePointer    = 15
            .WordWrap        = .T.
            .AutoSize        = .F.
            .Visible         = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar, "Click", THIS, "BtnVisualizarClick")

        *-- Botao Alterar (Left=155)
        loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Alterar", "CommandButton")
        WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar
            .Caption         = "Alterar"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_alterar_60.jpg"
            .PicturePosition = 13
            .Top             = 5
            .Left            = 155
            .Width           = 75
            .Height          = 75
            .FontName        = "Tahoma"
            .FontBold        = .T.
            .FontItalic      = .T.
            .FontSize        = 8
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .Themes          = .F.
            .SpecialEffect   = 0
            .MousePointer    = 15
            .WordWrap        = .T.
            .AutoSize        = .F.
            .Visible         = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar, "Click", THIS, "BtnAlterarClick")

        *-- Botao Excluir (Left=230)
        loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Excluir", "CommandButton")
        WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir
            .Caption         = "Excluir"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_excluir_60.jpg"
            .PicturePosition = 13
            .Top             = 5
            .Left            = 230
            .Width           = 75
            .Height          = 75
            .FontName        = "Tahoma"
            .FontBold        = .T.
            .FontItalic      = .T.
            .FontSize        = 8
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .Themes          = .F.
            .SpecialEffect   = 0
            .MousePointer    = 15
            .WordWrap        = .T.
            .AutoSize        = .F.
            .Visible         = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir, "Click", THIS, "BtnExcluirClick")

        *-- Botao Buscar (Left=305)
        loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Buscar", "CommandButton")
        WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Buscar
            .Caption         = "Buscar"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_procurar_60.jpg"
            .PicturePosition = 13
            .Top             = 5
            .Left            = 305
            .Width           = 75
            .Height          = 75
            .FontName        = "Tahoma"
            .FontBold        = .T.
            .FontItalic      = .T.
            .FontSize        = 8
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .Themes          = .F.
            .SpecialEffect   = 0
            .MousePointer    = 15
            .WordWrap        = .T.
            .AutoSize        = .F.
            .Visible         = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Buscar, "Click", THIS, "BtnBuscarClick")

        *-- Container Saida - PADRAO CANONICO (prevalece sobre legado, CLAUDE.md regra #10)
        loc_oPagina.AddObject("cnt_4c_Saida", "Container")
        WITH loc_oPagina.cnt_4c_Saida
            .Top         = 29
            .Left        = 917
            .Width       = 90
            .Height      = 85
            .BackStyle   = 0
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH

        *-- Botao Encerrar - PADRAO CANONICO: Caption="Encerrar", Width=75, Height=75
        loc_oPagina.cnt_4c_Saida.AddObject("cmd_4c_Encerrar", "CommandButton")
        WITH loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar
            .Caption         = "Encerrar"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
            .PicturePosition = 13
            .Top             = 5
            .Left            = 5
            .Width           = 75
            .Height          = 75
            .FontName        = "Tahoma"
            .FontBold        = .T.
            .FontItalic      = .T.
            .FontSize        = 8
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .Themes          = .F.
            .SpecialEffect   = 0
            .MousePointer    = 15
            .WordWrap        = .T.
            .AutoSize        = .F.
            .Visible         = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar, "Click", THIS, "BtnEncerrarClick")

        *-- Grid de listagem de movimentos
        *-- Canonico framework: Top=117 (88+29 compensacao), Left=26, Width=880, Height=498
        loc_oPagina.AddObject("grd_4c_Lista", "Grid")
        *-- ColumnCount FORA do WITH (RecordSource dentro do WITH nao cria colunas imediatamente)
        loc_oPagina.grd_4c_Lista.ColumnCount = 7
        WITH loc_oPagina.grd_4c_Lista
            .Top                = 117
            .Left               = 26
            .Width              = 880
            .Height             = 498
            .FontName           = "Verdana"
            .FontSize           = 8
            .ForeColor          = RGB(90, 90, 90)
            .BackColor          = RGB(255, 255, 255)
            .GridLineColor      = RGB(238, 238, 238)
            .HighlightBackColor = RGB(255, 255, 255)
            .HighlightForeColor = RGB(15, 41, 104)
            .HighlightStyle     = 2
            .DeleteMark         = .F.
            .RecordMark         = .F.
            .RowHeight          = 16
            .ScrollBars         = 2
            .GridLines          = 3
            .Visible            = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.grd_4c_Lista, "DblClick", THIS, "BtnVisualizarClick")

        THIS.TornarControlesVisiveis(loc_oPagina)
    ENDPROC

    *===========================================================================
    * ConfigurarPaginaDados - Estrutura base da Page2 (Dados)
    * Campos e botoes de acao (Confirmar/Cancelar) sao adicionados nas proximas fases
    *===========================================================================
    PROTECTED PROCEDURE ConfigurarPaginaDados()
        LOCAL loc_oPagina
        loc_oPagina = THIS.pgf_4c_Paginas.Page2

        *-- Fundo padrao do framework frmcadastro (sem isso a pagina fica branca)
        loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"

        *-- Container Cabecalho - PRIMEIRO AddObject da pagina (regra #11: faixa nas DUAS paginas)
        loc_oPagina.AddObject("cnt_4c_Cabecalho", "Container")
        WITH loc_oPagina.cnt_4c_Cabecalho
            .Top         = 29
            .Left        = 0
            .Width       = THIS.Width
            .Height      = 80
            .BackColor   = RGB(100, 100, 100)
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH

        loc_oPagina.cnt_4c_Cabecalho.AddObject("lbl_4c_Sombra", "Label")
        WITH loc_oPagina.cnt_4c_Cabecalho.lbl_4c_Sombra
            .Caption   = THIS.Caption
            .Top       = 15
            .Left      = 10
            .Width     = THIS.Width - 20
            .Height    = 40
            .FontName  = "Tahoma"
            .FontSize  = 16
            .FontBold  = .T.
            .ForeColor = RGB(0, 0, 0)
            .BackStyle = 0
            .AutoSize  = .F.
            .Visible   = .T.
        ENDWITH

        loc_oPagina.cnt_4c_Cabecalho.AddObject("lbl_4c_Titulo", "Label")
        WITH loc_oPagina.cnt_4c_Cabecalho.lbl_4c_Titulo
            .Caption   = THIS.Caption
            .Top       = 18
            .Left      = 10
            .Width     = THIS.Width - 20
            .Height    = 46
            .FontName  = "Tahoma"
            .FontSize  = 16
            .FontBold  = .T.
            .ForeColor = RGB(255, 255, 255)
            .BackStyle = 0
            .AutoSize  = .F.
            .Visible   = .T.
        ENDWITH

        *-- Container Botoes de Acao (Grupo_salva no legado) - canonico
        loc_oPagina.AddObject("cnt_4c_BotoesAcao", "Container")
        WITH loc_oPagina.cnt_4c_BotoesAcao
            .Top         = 33
            .Left        = 842
            .Width       = 160
            .Height      = 85
            .BackStyle = 1
            .BackColor = RGB(255, 255, 255)
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH

        *-- Botao Confirmar/Salvar (Left=5)
        loc_oPagina.cnt_4c_BotoesAcao.AddObject("cmd_4c_Confirmar", "CommandButton")
        WITH loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Confirmar
            .Caption         = "Confirmar"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
            .PicturePosition = 13
            .Top             = 5
            .Left            = 5
            .Width           = 75
            .Height          = 75
            .FontName        = "Tahoma"
            .FontBold        = .T.
            .FontItalic      = .T.
            .FontSize        = 8
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .Themes          = .F.
            .SpecialEffect   = 0
            .MousePointer    = 15
            .WordWrap        = .T.
            .AutoSize        = .F.
            .Visible         = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Confirmar, "Click", THIS, "BtnSalvarClick")

        *-- Botao Cancelar (Left=80)
        loc_oPagina.cnt_4c_BotoesAcao.AddObject("cmd_4c_Cancelar", "CommandButton")
        WITH loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Cancelar
            .Caption         = "Encerrar"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_cancelar_60.jpg"
            .PicturePosition = 13
            .Top             = 5
            .Left            = 80
            .Width           = 75
            .Height          = 75
            .FontName        = "Tahoma"
            .FontBold        = .T.
            .FontItalic      = .T.
            .FontSize        = 8
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .Themes          = .F.
            .SpecialEffect   = 0
            .MousePointer    = 15
            .WordWrap        = .T.
            .AutoSize        = .F.
            .Visible         = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Cancelar, "Click", THIS, "BtnCancelarClick")

        *-- FASE 5/8: Campos principais (parte 1) - identificacao do movimento
        *-- Legado: getCodigo/getEmpD/getDatas (pgOperacional) + Origem/Destino
        *-- (pgContas.Origem/Destino Get_grupo/Get_conta). Layout simplificado:
        *-- campos direto na Page2, sem reproduzir o PageFrame interno pgfPrincipal
        *-- (escopo desta fase e a identificacao do movimento; abas Operacional/
        *-- Informacoes/Contas completas ficam para fases seguintes).

        *-- Linha 1: Empresa / Operacao / Numero
        loc_oPagina.AddObject("lbl_4c_Emps", "Label")
        WITH loc_oPagina.lbl_4c_Emps
            .Caption   = "Emp :"
            .Left      = 30
            .Top       = 120
            .AutoSize  = .T.
            .BackStyle = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH
        loc_oPagina.AddObject("txt_4c_Emps", "TextBox")
        WITH loc_oPagina.txt_4c_Emps
            .Left          = 65
            .Top           = 118
            .Width         = 45
            .Height        = 21
            .MaxLength     = 3
            .SpecialEffect = 1
            .FontName      = "Tahoma"
            .FontSize      = 8
            .Visible       = .T.
        ENDWITH

        loc_oPagina.AddObject("lbl_4c_Dopes", "Label")
        WITH loc_oPagina.lbl_4c_Dopes
            .Caption   = "Opera" + CHR(231) + CHR(227) + "o :"
            .Left      = 130
            .Top       = 120
            .AutoSize  = .T.
            .BackStyle = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH
        loc_oPagina.AddObject("txt_4c_Dopes", "TextBox")
        WITH loc_oPagina.txt_4c_Dopes
            .Left          = 185
            .Top           = 118
            .Width         = 200
            .Height        = 21
            .MaxLength     = 20
            .ReadOnly      = .T.
            .SpecialEffect = 1
            .FontName      = "Tahoma"
            .FontSize      = 8
            .BackColor     = RGB(240, 240, 240)
            .Visible       = .T.
        ENDWITH

        loc_oPagina.AddObject("lbl_4c_Numes", "Label")
        WITH loc_oPagina.lbl_4c_Numes
            .Caption   = "N" + CHR(250) + "mero :"
            .Left      = 400
            .Top       = 120
            .AutoSize  = .T.
            .BackStyle = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH
        loc_oPagina.AddObject("txt_4c_Numes", "TextBox")
        WITH loc_oPagina.txt_4c_Numes
            .Left          = 450
            .Top           = 118
            .Width         = 90
            .Height        = 21
            .InputMask     = "999999"
            .ReadOnly      = .T.
            .SpecialEffect = 1
            .FontName      = "Tahoma"
            .FontSize      = 8
            .BackColor     = RGB(240, 240, 240)
            .Visible       = .T.
        ENDWITH

        *-- Linha 2: Data
        loc_oPagina.AddObject("lbl_4c_Datas", "Label")
        WITH loc_oPagina.lbl_4c_Datas
            .Caption   = "Data :"
            .Left      = 30
            .Top       = 155
            .AutoSize  = .T.
            .BackStyle = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH
        loc_oPagina.AddObject("txt_4c_Datas", "TextBox")
        WITH loc_oPagina.txt_4c_Datas
            .Left          = 65
            .Top           = 153
            .Width         = 100
            .Height        = 21
            .Format        = "K"
            .SpecialEffect = 1
            .FontName      = "Tahoma"
            .FontSize      = 8
            .Visible       = .T.
        ENDWITH

        *-- Linha 3: Grupo/Conta Origem
        loc_oPagina.AddObject("lbl_4c_GrupoOs", "Label")
        WITH loc_oPagina.lbl_4c_GrupoOs
            .Caption   = "Grupo Origem :"
            .Left      = 30
            .Top       = 190
            .AutoSize  = .T.
            .BackStyle = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH
        loc_oPagina.AddObject("txt_4c_GrupoOs", "TextBox")
        WITH loc_oPagina.txt_4c_GrupoOs
            .Left          = 130
            .Top           = 188
            .Width         = 80
            .Height        = 21
            .MaxLength     = 10
            .SpecialEffect = 1
            .FontName      = "Tahoma"
            .FontSize      = 8
            .Visible       = .T.
        ENDWITH

        loc_oPagina.AddObject("lbl_4c_ContaOs", "Label")
        WITH loc_oPagina.lbl_4c_ContaOs
            .Caption   = "Conta Origem :"
            .Left      = 230
            .Top       = 190
            .AutoSize  = .T.
            .BackStyle = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH
        loc_oPagina.AddObject("txt_4c_ContaOs", "TextBox")
        WITH loc_oPagina.txt_4c_ContaOs
            .Left          = 330
            .Top           = 188
            .Width         = 120
            .Height        = 21
            .MaxLength     = 10
            .SpecialEffect = 1
            .FontName      = "Tahoma"
            .FontSize      = 8
            .Visible       = .T.
        ENDWITH

        *-- Linha 4: Grupo/Conta Destino
        loc_oPagina.AddObject("lbl_4c_GrupoDs", "Label")
        WITH loc_oPagina.lbl_4c_GrupoDs
            .Caption   = "Grupo Destino :"
            .Left      = 30
            .Top       = 225
            .AutoSize  = .T.
            .BackStyle = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH
        loc_oPagina.AddObject("txt_4c_GrupoDs", "TextBox")
        WITH loc_oPagina.txt_4c_GrupoDs
            .Left          = 130
            .Top           = 223
            .Width         = 80
            .Height        = 21
            .MaxLength     = 10
            .SpecialEffect = 1
            .FontName      = "Tahoma"
            .FontSize      = 8
            .Visible       = .T.
        ENDWITH

        loc_oPagina.AddObject("lbl_4c_ContaDs", "Label")
        WITH loc_oPagina.lbl_4c_ContaDs
            .Caption   = "Conta Destino :"
            .Left      = 230
            .Top       = 225
            .AutoSize  = .T.
            .BackStyle = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH
        loc_oPagina.AddObject("txt_4c_ContaDs", "TextBox")
        WITH loc_oPagina.txt_4c_ContaDs
            .Left          = 330
            .Top           = 223
            .Width         = 120
            .Height        = 21
            .MaxLength     = 10
            .SpecialEffect = 1
            .FontName      = "Tahoma"
            .FontSize      = 8
            .Visible       = .T.
        ENDWITH

        *-- Linha 5: Vendedor
        loc_oPagina.AddObject("lbl_4c_Vends", "Label")
        WITH loc_oPagina.lbl_4c_Vends
            .Caption   = "Vendedor :"
            .Left      = 30
            .Top       = 260
            .AutoSize  = .T.
            .BackStyle = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH
        loc_oPagina.AddObject("txt_4c_Vends", "TextBox")
        WITH loc_oPagina.txt_4c_Vends
            .Left          = 130
            .Top           = 258
            .Width         = 120
            .Height        = 21
            .MaxLength     = 10
            .SpecialEffect = 1
            .FontName      = "Tahoma"
            .FontSize      = 8
            .Visible       = .T.
        ENDWITH

        *-- Lookups (F4/DblClick) dos campos de Grupo/Conta/Vendedor da parte 1
        BINDEVENT(loc_oPagina.txt_4c_GrupoOs, "KeyPress", THIS, "GrupoOsLookupKeyPress")
        BINDEVENT(loc_oPagina.txt_4c_GrupoOs, "DblClick", THIS, "GrupoOsLookupDblClick")
        BINDEVENT(loc_oPagina.txt_4c_ContaOs, "KeyPress", THIS, "ContaOsLookupKeyPress")
        BINDEVENT(loc_oPagina.txt_4c_ContaOs, "DblClick", THIS, "ContaOsLookupDblClick")
        BINDEVENT(loc_oPagina.txt_4c_GrupoDs, "KeyPress", THIS, "GrupoDsLookupKeyPress")
        BINDEVENT(loc_oPagina.txt_4c_GrupoDs, "DblClick", THIS, "GrupoDsLookupDblClick")
        BINDEVENT(loc_oPagina.txt_4c_ContaDs, "KeyPress", THIS, "ContaDsLookupKeyPress")
        BINDEVENT(loc_oPagina.txt_4c_ContaDs, "DblClick", THIS, "ContaDsLookupDblClick")
        BINDEVENT(loc_oPagina.txt_4c_Vends, "KeyPress", THIS, "VendsLookupKeyPress")
        BINDEVENT(loc_oPagina.txt_4c_Vends, "DblClick", THIS, "VendsLookupDblClick")

        *-- FASE 6/8: Campos restantes (parte 2) - tabela de desconto, job,
        *-- publicidade, lista de precos, valor e observacao

        *-- Linha 6: Tabela de Desconto / Lista de Precos
        loc_oPagina.AddObject("lbl_4c_Tabds", "Label")
        WITH loc_oPagina.lbl_4c_Tabds
            .Caption   = "Tabela Desc. :"
            .Left      = 30
            .Top       = 295
            .AutoSize  = .T.
            .BackStyle = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH
        loc_oPagina.AddObject("txt_4c_Tabds", "TextBox")
        WITH loc_oPagina.txt_4c_Tabds
            .Left          = 130
            .Top           = 293
            .Width         = 80
            .Height        = 21
            .MaxLength     = 10
            .SpecialEffect = 1
            .FontName      = "Tahoma"
            .FontSize      = 8
            .Visible       = .T.
        ENDWITH

        loc_oPagina.AddObject("lbl_4c_Lprecos", "Label")
        WITH loc_oPagina.lbl_4c_Lprecos
            .Caption   = "Lista Pre" + CHR(231) + CHR(111) + "s :"
            .Left      = 230
            .Top       = 295
            .AutoSize  = .T.
            .BackStyle = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH
        loc_oPagina.AddObject("txt_4c_Lprecos", "TextBox")
        WITH loc_oPagina.txt_4c_Lprecos
            .Left          = 330
            .Top           = 293
            .Width         = 120
            .Height        = 21
            .MaxLength     = 30
            .SpecialEffect = 1
            .FontName      = "Tahoma"
            .FontSize      = 8
            .Visible       = .T.
        ENDWITH

        *-- Linha 7: Job / Forma de Publicidade
        loc_oPagina.AddObject("lbl_4c_Jobs", "Label")
        WITH loc_oPagina.lbl_4c_Jobs
            .Caption   = "Job :"
            .Left      = 30
            .Top       = 330
            .AutoSize  = .T.
            .BackStyle = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH
        loc_oPagina.AddObject("txt_4c_Jobs", "TextBox")
        WITH loc_oPagina.txt_4c_Jobs
            .Left          = 130
            .Top           = 328
            .Width         = 80
            .Height        = 21
            .MaxLength     = 10
            .SpecialEffect = 1
            .FontName      = "Tahoma"
            .FontSize      = 8
            .Visible       = .T.
        ENDWITH

        loc_oPagina.AddObject("lbl_4c_Fpubls", "Label")
        WITH loc_oPagina.lbl_4c_Fpubls
            .Caption   = "F. Publicidade :"
            .Left      = 230
            .Top       = 330
            .AutoSize  = .T.
            .BackStyle = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH
        loc_oPagina.AddObject("txt_4c_Fpubls", "TextBox")
        WITH loc_oPagina.txt_4c_Fpubls
            .Left          = 330
            .Top           = 328
            .Width         = 60
            .Height        = 21
            .MaxLength     = 3
            .SpecialEffect = 1
            .FontName      = "Tahoma"
            .FontSize      = 8
            .Visible       = .T.
        ENDWITH

        *-- Linha 8: Valor
        loc_oPagina.AddObject("lbl_4c_Valos", "Label")
        WITH loc_oPagina.lbl_4c_Valos
            .Caption   = "Valor :"
            .Left      = 30
            .Top       = 365
            .AutoSize  = .T.
            .BackStyle = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH
        loc_oPagina.AddObject("txt_4c_Valos", "TextBox")
        WITH loc_oPagina.txt_4c_Valos
            .Left          = 130
            .Top           = 363
            .Width         = 120
            .Height        = 21
            .InputMask     = "999,999,999.99"
            .Alignment     = 1
            .SpecialEffect = 1
            .FontName      = "Tahoma"
            .FontSize      = 8
            .Visible       = .T.
        ENDWITH

        *-- Linha 9: Observacao (memo)
        loc_oPagina.AddObject("lbl_4c_Obses", "Label")
        WITH loc_oPagina.lbl_4c_Obses
            .Caption   = "Observa" + CHR(231) + CHR(227) + "o :"
            .Left      = 30
            .Top       = 400
            .AutoSize  = .T.
            .BackStyle = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH
        loc_oPagina.AddObject("txt_4c_Obses", "EditBox")
        WITH loc_oPagina.txt_4c_Obses
            .Left          = 130
            .Top           = 398
            .Width         = 500
            .Height        = 60
            .SpecialEffect = 1
            .FontName      = "Tahoma"
            .FontSize      = 8
            .Visible       = .T.
        ENDWITH

        THIS.TornarControlesVisiveis(loc_oPagina)
    ENDPROC

    *===========================================================================
    * CarregarLista - Carrega dados no grid da Page1
    * par_cFiltro (opcional): WHERE extra somado ao TOP 300 padrao do BO
    * (usado por LocalizarNaLista para trazer um registro fora da janela).
    * OBRIGATORIO: RecordSource FORA do WITH; ControlSource/Headers APOS
    * RecordSource (RecordSource reseta ControlSource/Header via auto-bind).
    *===========================================================================
    PROCEDURE CarregarLista(par_cFiltro)
        LOCAL loc_lResultado, loc_oGrid, loc_cFiltro
        loc_lResultado = .F.
        loc_cFiltro = IIF(VARTYPE(par_cFiltro) = "C", par_cFiltro, "")

        TRY
            IF !THIS.this_oBusinessObject.Buscar(loc_cFiltro)
                loc_lResultado = .F.
            ELSE
                loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Lista

                loc_oGrid.ColumnCount = 7
                loc_oGrid.RecordSource = "cursor_4c_Dados"

                loc_oGrid.Column1.ControlSource = "cursor_4c_Dados.Emps"
                loc_oGrid.Column2.ControlSource = "cursor_4c_Dados.Dopes"
                loc_oGrid.Column3.ControlSource = "cursor_4c_Dados.Numes"
                loc_oGrid.Column4.ControlSource = "cursor_4c_Dados.Datas"
                loc_oGrid.Column5.ControlSource = "cursor_4c_Dados.ContaOs"
                loc_oGrid.Column6.ControlSource = "cursor_4c_Dados.ContaDs"
                loc_oGrid.Column7.ControlSource = "cursor_4c_Dados.Valos"

                loc_oGrid.Column1.Width = 55
                loc_oGrid.Column2.Width = 150
                loc_oGrid.Column3.Width = 70
                loc_oGrid.Column4.Width = 90
                loc_oGrid.Column5.Width = 165
                loc_oGrid.Column6.Width = 165
                loc_oGrid.Column7.Width = 130

                *-- Headers APOS RecordSource (RecordSource reseta os captions)
                loc_oGrid.Column1.Header1.Caption = "Emp"
                loc_oGrid.Column2.Header1.Caption = "Opera" + CHR(231) + CHR(227) + "o"
                loc_oGrid.Column3.Header1.Caption = "N" + CHR(250) + "mero"
                loc_oGrid.Column4.Header1.Caption = "Data"
                loc_oGrid.Column5.Header1.Caption = "Conta Origem"
                loc_oGrid.Column6.Header1.Caption = "Conta Destino"
                loc_oGrid.Column7.Header1.Caption = "Valor"

                THIS.FormatarGridLista(loc_oGrid)
                loc_lResultado = .T.
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao carregar lista:" + CHR(13) + loException.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loException.LineNo), ;
                "Formsigmvcab.CarregarLista")
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *===========================================================================
    * AlternarPagina - Alterna entre Page1 (Lista=1) e Page2 (Dados=2)
    * Ao voltar para Page1, recarrega a lista
    *===========================================================================
    PROCEDURE AlternarPagina(par_nPagina)
        LOCAL loc_lResultado
        loc_lResultado = .F.

        TRY
            IF VARTYPE(par_nPagina) != "N" OR par_nPagina < 1 OR par_nPagina > 2
                MsgAviso("P" + CHR(225) + "gina inv" + CHR(225) + "lida: " + TRANSFORM(par_nPagina))
            ELSE
                THIS.pgf_4c_Paginas.ActivePage = par_nPagina

                IF par_nPagina = 1
                    THIS.this_cModoAtual = "LISTA"
                    THIS.CarregarLista()
                ENDIF

                loc_lResultado = .T.
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao alternar p" + CHR(225) + "gina:" + CHR(13) + loException.Message, ;
                "Formsigmvcab.AlternarPagina")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *===========================================================================
    * FormatarGridLista - Formata visual do grid de lista (FontName/FontSize)
    *===========================================================================
    PROTECTED PROCEDURE FormatarGridLista(par_oGrid)
        TRY
            WITH par_oGrid
                .FontName = "Verdana"
                .FontSize = 8
            ENDWITH
        CATCH TO loException
            MostrarErro("Erro ao formatar grid:" + CHR(13) + loException.Message, ;
                "Formsigmvcab.FormatarGridLista")
        ENDTRY
    ENDPROC

    *===========================================================================
    * TornarControlesVisiveis - Torna todos os controles visiveis recursivamente
    * REGRA: Chamar SEMPRE com parametro: THIS.TornarControlesVisiveis(loc_oPagina)
    *===========================================================================
    PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
        LOCAL loc_nI, loc_oObjeto, loc_nP

        FOR loc_nI = 1 TO par_oContainer.ControlCount
            loc_oObjeto = par_oContainer.Controls(loc_nI)

            IF VARTYPE(loc_oObjeto) = "O"
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

    *===========================================================================
    * ObterChaveSelecionada - Le a cidchaves (PK) do registro selecionado no Grid
    *===========================================================================
    PROTECTED PROCEDURE ObterChaveSelecionada()
        LOCAL loc_cChave
        loc_cChave = ""

        IF USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados")
            SELECT cursor_4c_Dados
            loc_cChave = ALLTRIM(cursor_4c_Dados.cidchaves)
        ENDIF

        RETURN loc_cChave
    ENDPROC

    *===========================================================================
    * LocalizarNaLista - Posiciona o Grid no registro par_cChave (cidchaves)
    * Se estiver fora da janela padrao (TOP 300), recarrega filtrando por ele
    *===========================================================================
    PROTECTED PROCEDURE LocalizarNaLista(par_cChave)
        LOCAL loc_lAchou
        loc_lAchou = .F.

        IF USED("cursor_4c_Dados")
            SELECT cursor_4c_Dados
            LOCATE FOR ALLTRIM(cidchaves) == par_cChave
            loc_lAchou = FOUND()
        ENDIF

        IF loc_lAchou
            THIS.pgf_4c_Paginas.Page1.grd_4c_Lista.Refresh()
        ELSE
            THIS.CarregarLista("cidchaves = " + EscaparSQL(par_cChave))
        ENDIF
    ENDPROC

    *===========================================================================
    * BtnIncluirClick - Prepara o BO para incluir novo registro e abre Page2
    * PUBLIC: BINDEVENT requer metodo publico
    *===========================================================================
    PROCEDURE BtnIncluirClick()
        THIS.this_oBusinessObject.NovoRegistro()
        THIS.LimparCampos()
        THIS.this_cModoAtual = "INCLUIR"
        THIS.HabilitarCampos(.T.)
        THIS.AjustarBotoesPorModo()
        THIS.AlternarPagina(2)
    ENDPROC

    *===========================================================================
    * BtnVisualizarClick - Abre Page2 em modo somente leitura
    * PUBLIC: BINDEVENT requer metodo publico
    *===========================================================================
    PROCEDURE BtnVisualizarClick()
        LOCAL loc_cChave
        loc_cChave = THIS.ObterChaveSelecionada()

        IF EMPTY(loc_cChave)
            MsgAviso("Selecione um registro para visualizar.")
        ELSE
            IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cChave)
                THIS.BOParaForm()
                THIS.this_cModoAtual = "VISUALIZAR"
                THIS.HabilitarCampos(.F.)
                THIS.AjustarBotoesPorModo()
                THIS.AlternarPagina(2)
            ENDIF
        ENDIF
    ENDPROC

    *===========================================================================
    * BtnAlterarClick - Abre Page2 para alterar o registro selecionado
    * PUBLIC: BINDEVENT requer metodo publico
    *===========================================================================
    PROCEDURE BtnAlterarClick()
        LOCAL loc_cChave
        loc_cChave = THIS.ObterChaveSelecionada()

        IF EMPTY(loc_cChave)
            MsgAviso("Selecione um registro para alterar.")
        ELSE
            IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cChave)
                THIS.this_oBusinessObject.EditarRegistro()
                THIS.BOParaForm()
                THIS.this_cModoAtual = "ALTERAR"
                THIS.HabilitarCampos(.T.)
                THIS.AjustarBotoesPorModo()
                THIS.AlternarPagina(2)
            ENDIF
        ENDIF
    ENDPROC

    *===========================================================================
    * BtnExcluirClick - Exclui o registro selecionado, com confirmacao
    * PUBLIC: BINDEVENT requer metodo publico
    *===========================================================================
    PROCEDURE BtnExcluirClick()
        LOCAL loc_cChave, loc_cDescricao
        loc_cChave = THIS.ObterChaveSelecionada()

        IF EMPTY(loc_cChave)
            MsgAviso("Selecione um registro para excluir.")
        ELSE
            loc_cDescricao = ""
            IF USED("cursor_4c_Dados")
                SELECT cursor_4c_Dados
                loc_cDescricao = ALLTRIM(cursor_4c_Dados.Emps) + " " + ALLTRIM(cursor_4c_Dados.Dopes) + ;
                    " " + ALLTRIM(TRANSFORM(cursor_4c_Dados.Numes))
            ENDIF

            IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cChave)
                IF MsgConfirma("Confirma a exclus" + CHR(227) + "o do movimento [" + loc_cDescricao + "]?", ;
                    "Confirmar Exclus" + CHR(227) + "o")
                    IF THIS.this_oBusinessObject.Excluir()
                        MsgInfo("Registro exclu" + CHR(237) + "do com sucesso!")
                        THIS.CarregarLista()
                    ENDIF
                ENDIF
            ENDIF
        ENDIF
    ENDPROC

    *===========================================================================
    * BtnBuscarClick - Localiza um movimento pela chave EmpDopNums (Emp+Doc+Num)
    * e posiciona o Grid nele
    * PUBLIC: BINDEVENT requer metodo publico
    *===========================================================================
    PROCEDURE BtnBuscarClick()
        LOCAL loc_oBusca, loc_cChave
        loc_cChave = ""

        TRY
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigMvCab", "cursor_4c_BuscaMov", "EmpDopNums", "", ;
                "Buscar Movimenta" + CHR(231) + CHR(227) + "o")

            IF VARTYPE(loc_oBusca) = "O"
                loc_oBusca.mAddColuna("Emps",  "", "Emp")
                loc_oBusca.mAddColuna("Dopes", "", "Opera" + CHR(231) + CHR(227) + "o")
                loc_oBusca.mAddColuna("Numes", "", "N" + CHR(250) + "mero")
                loc_oBusca.mAddColuna("Datas", "", "Data")
                loc_oBusca.Show()

                IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaMov")
                    SELECT cursor_4c_BuscaMov
                    loc_cChave = ALLTRIM(cursor_4c_BuscaMov.cidchaves)
                ENDIF

                loc_oBusca.Release()
            ENDIF

            IF USED("cursor_4c_BuscaMov")
                USE IN cursor_4c_BuscaMov
            ENDIF

            IF !EMPTY(loc_cChave)
                THIS.LocalizarNaLista(loc_cChave)
            ENDIF

        CATCH TO loException
            MostrarErro("Erro na busca:" + CHR(13) + loException.Message, "Formsigmvcab.BtnBuscarClick")
            IF USED("cursor_4c_BuscaMov")
                USE IN cursor_4c_BuscaMov
            ENDIF
        ENDTRY
    ENDPROC

    *===========================================================================
    * BtnEncerrarClick - Fecha o formulario
    * PUBLIC: BINDEVENT requer metodo publico
    *===========================================================================
    PROCEDURE BtnEncerrarClick()
        THIS.Release()
    ENDPROC

    *===========================================================================
    * BtnSalvarClick - Transfere Form->BO e grava (Inserir/Atualizar conforme
    * this_lNovoRegistro, controlado pelo BusinessBase). PUBLIC: BINDEVENT.
    *===========================================================================
    PROCEDURE BtnSalvarClick()
        THIS.FormParaBO()

        IF THIS.this_oBusinessObject.Salvar()
            MsgInfo("Registro salvo com sucesso!", "Confirmar")
            THIS.AlternarPagina(1)
        ELSE
            IF !THIS.this_oBusinessObject.this_lErroExibido
                MsgErro("N" + CHR(227) + "o foi poss" + CHR(237) + "vel gravar o registro.", "Confirmar")
            ENDIF
        ENDIF
    ENDPROC

    *===========================================================================
    * BtnCancelarClick - Descarta alteracoes e volta para a lista
    * PUBLIC: BINDEVENT requer metodo publico
    *===========================================================================
    PROCEDURE BtnCancelarClick()
        THIS.AlternarPagina(1)
    ENDPROC

    *===========================================================================
    * FormParaBO - Transfere os valores dos campos da Page2 para o BO
    * Chamado por BtnSalvarClick antes de THIS.this_oBusinessObject.Salvar()
    *===========================================================================
    PROTECTED PROCEDURE FormParaBO()
        LOCAL loc_oPg, loc_oBO
        loc_oPg = THIS.pgf_4c_Paginas.Page2
        loc_oBO = THIS.this_oBusinessObject

        loc_oBO.this_cEmps      = ALLTRIM(loc_oPg.txt_4c_Emps.Value)
        loc_oBO.this_cDopes     = ALLTRIM(loc_oPg.txt_4c_Dopes.Value)
        loc_oBO.this_nNumes     = TRANSFORM(loc_oPg.txt_4c_Numes.Value)
        loc_oBO.this_dDatas     = loc_oPg.txt_4c_Datas.Value
        loc_oBO.this_cGrupoos   = ALLTRIM(loc_oPg.txt_4c_GrupoOs.Value)
        loc_oBO.this_cContaos   = ALLTRIM(loc_oPg.txt_4c_ContaOs.Value)
        loc_oBO.this_cGrupods   = ALLTRIM(loc_oPg.txt_4c_GrupoDs.Value)
        loc_oBO.this_cContads   = ALLTRIM(loc_oPg.txt_4c_ContaDs.Value)
        loc_oBO.this_cVends     = ALLTRIM(loc_oPg.txt_4c_Vends.Value)
        loc_oBO.this_cTabds     = ALLTRIM(loc_oPg.txt_4c_Tabds.Value)
        loc_oBO.this_cLprecos   = ALLTRIM(loc_oPg.txt_4c_Lprecos.Value)
        loc_oBO.this_cJobs      = ALLTRIM(loc_oPg.txt_4c_Jobs.Value)
        loc_oBO.this_cFpubls    = ALLTRIM(loc_oPg.txt_4c_Fpubls.Value)
        loc_oBO.this_nValos     = loc_oPg.txt_4c_Valos.Value
        loc_oBO.this_cObses     = ALLTRIM(loc_oPg.txt_4c_Obses.Value)
    ENDPROC

    *===========================================================================
    * BOParaForm - Transfere os valores do BO para os campos da Page2
    * Chamado por BtnVisualizarClick/BtnAlterarClick apos CarregarPorCodigo()
    *===========================================================================
    PROTECTED PROCEDURE BOParaForm()
        LOCAL loc_oPg, loc_oBO
        loc_oPg = THIS.pgf_4c_Paginas.Page2
        loc_oBO = THIS.this_oBusinessObject

        loc_oPg.txt_4c_Emps.Value     = loc_oBO.this_cEmps
        loc_oPg.txt_4c_Dopes.Value    = loc_oBO.this_cDopes
        loc_oPg.txt_4c_Numes.Value    = loc_oBO.this_nNumes
        loc_oPg.txt_4c_Datas.Value    = ConverterParaData(loc_oBO.this_dDatas)
        loc_oPg.txt_4c_GrupoOs.Value  = loc_oBO.this_cGrupoos
        loc_oPg.txt_4c_ContaOs.Value  = loc_oBO.this_cContaos
        loc_oPg.txt_4c_GrupoDs.Value  = loc_oBO.this_cGrupods
        loc_oPg.txt_4c_ContaDs.Value  = loc_oBO.this_cContads
        loc_oPg.txt_4c_Vends.Value    = loc_oBO.this_cVends
        loc_oPg.txt_4c_Tabds.Value    = loc_oBO.this_cTabds
        loc_oPg.txt_4c_Lprecos.Value  = loc_oBO.this_cLprecos
        loc_oPg.txt_4c_Jobs.Value     = loc_oBO.this_cJobs
        loc_oPg.txt_4c_Fpubls.Value   = loc_oBO.this_cFpubls
        loc_oPg.txt_4c_Valos.Value    = loc_oBO.this_nValos
        loc_oPg.txt_4c_Obses.Value    = loc_oBO.this_cObses
    ENDPROC

    *===========================================================================
    * LimparCampos - Limpa os campos da Page2 (usado em Incluir)
    *===========================================================================
    PROTECTED PROCEDURE LimparCampos()
        LOCAL loc_oPg
        loc_oPg = THIS.pgf_4c_Paginas.Page2

        loc_oPg.txt_4c_Emps.Value     = ""
        loc_oPg.txt_4c_Dopes.Value    = ""
        loc_oPg.txt_4c_Numes.Value    = 0
        loc_oPg.txt_4c_Datas.Value    = {}
        loc_oPg.txt_4c_GrupoOs.Value  = ""
        loc_oPg.txt_4c_ContaOs.Value  = ""
        loc_oPg.txt_4c_GrupoDs.Value  = ""
        loc_oPg.txt_4c_ContaDs.Value  = ""
        loc_oPg.txt_4c_Vends.Value    = ""
        loc_oPg.txt_4c_Tabds.Value    = ""
        loc_oPg.txt_4c_Lprecos.Value  = ""
        loc_oPg.txt_4c_Jobs.Value     = ""
        loc_oPg.txt_4c_Fpubls.Value   = ""
        loc_oPg.txt_4c_Valos.Value    = 0
        loc_oPg.txt_4c_Obses.Value    = ""
    ENDPROC

    *===========================================================================
    * HabilitarCampos - Habilita/desabilita os campos editaveis da Page2
    * par_lHabilitar = .T. (Incluir/Alterar) ou .F. (Visualizar)
    * Emps/Dopes/Numes sao sempre ReadOnly (chave de negocio, nao editavel)
    *===========================================================================
    PROTECTED PROCEDURE HabilitarCampos(par_lHabilitar)
        LOCAL loc_oPg
        loc_oPg = THIS.pgf_4c_Paginas.Page2

        loc_oPg.txt_4c_Datas.Enabled    = par_lHabilitar
        loc_oPg.txt_4c_GrupoOs.Enabled  = par_lHabilitar
        loc_oPg.txt_4c_ContaOs.Enabled  = par_lHabilitar
        loc_oPg.txt_4c_GrupoDs.Enabled  = par_lHabilitar
        loc_oPg.txt_4c_ContaDs.Enabled  = par_lHabilitar
        loc_oPg.txt_4c_Vends.Enabled    = par_lHabilitar
        loc_oPg.txt_4c_Tabds.Enabled    = par_lHabilitar
        loc_oPg.txt_4c_Lprecos.Enabled  = par_lHabilitar
        loc_oPg.txt_4c_Jobs.Enabled     = par_lHabilitar
        loc_oPg.txt_4c_Fpubls.Enabled   = par_lHabilitar
        loc_oPg.txt_4c_Valos.Enabled    = par_lHabilitar
        loc_oPg.txt_4c_Obses.Enabled    = par_lHabilitar

        loc_oPg.cnt_4c_BotoesAcao.cmd_4c_Confirmar.Enabled = par_lHabilitar
    ENDPROC

    *===========================================================================
    * AjustarBotoesPorModo - Ajusta caption/estado dos botoes de acao da Page2
    * (cnt_4c_BotoesAcao) conforme this_cModoAtual (INCLUIR/ALTERAR/VISUALIZAR).
    * Chamado junto com HabilitarCampos() apos this_cModoAtual ser definido.
    * Confirmar fica desabilitado em VISUALIZAR (regra #20 CLAUDE.md: falha de
    * gravacao/modo somente-leitura nunca deixa o botao de gravar acionavel);
    * Cancelar vira "Voltar" nesse modo, pois nao ha alteracao a descartar.
    *===========================================================================
    PROCEDURE AjustarBotoesPorModo()
        LOCAL loc_oBotoes
        loc_oBotoes = THIS.pgf_4c_Paginas.Page2.cnt_4c_BotoesAcao

        DO CASE
            CASE THIS.this_cModoAtual = "VISUALIZAR"
                loc_oBotoes.cmd_4c_Confirmar.Enabled = .F.
                loc_oBotoes.cmd_4c_Cancelar.Caption  = "Voltar"

            CASE INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
                loc_oBotoes.cmd_4c_Confirmar.Enabled = .T.
                loc_oBotoes.cmd_4c_Cancelar.Caption  = "Cancelar"

            OTHERWISE
                loc_oBotoes.cmd_4c_Confirmar.Enabled = .T.
                loc_oBotoes.cmd_4c_Cancelar.Caption  = "Cancelar"
        ENDCASE
    ENDPROC

    *===========================================================================
    * Lookups (F4/DblClick) - Grupo/Conta Origem, Grupo/Conta Destino, Vendedor
    * Grupo  -> SigCdGcr (Grupos de Conta Corrente): Codigos/Descrs
    * Conta / Vendedor -> SigCdCli (Contas/Clientes): Iclis/Rclis
    * PUBLIC: metodos de evento chamados via BINDEVENT devem ser publicos
    *===========================================================================
    PROCEDURE GrupoOsLookupKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 28
            THIS.AbrirLookupGrupoOs()
        ENDIF
    ENDPROC

    PROCEDURE GrupoOsLookupDblClick()
        THIS.AbrirLookupGrupoOs()
    ENDPROC

    PROCEDURE AbrirLookupGrupoOs()
        IF THIS.pgf_4c_Paginas.Page2.txt_4c_GrupoOs.Enabled
            THIS.pgf_4c_Paginas.Page2.txt_4c_GrupoOs.Value = ;
                THIS.AbrirBuscaGrupoConta("SigCdGcr", "Codigos", "Descrs", ;
                    THIS.pgf_4c_Paginas.Page2.txt_4c_GrupoOs.Value, "Buscar Grupo Origem")
        ENDIF
    ENDPROC

    PROCEDURE ContaOsLookupKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 28
            THIS.AbrirLookupContaOs()
        ENDIF
    ENDPROC

    PROCEDURE ContaOsLookupDblClick()
        THIS.AbrirLookupContaOs()
    ENDPROC

    PROCEDURE AbrirLookupContaOs()
        IF THIS.pgf_4c_Paginas.Page2.txt_4c_ContaOs.Enabled
            THIS.pgf_4c_Paginas.Page2.txt_4c_ContaOs.Value = ;
                THIS.AbrirBuscaGrupoConta("SigCdCli", "Iclis", "Rclis", ;
                    THIS.pgf_4c_Paginas.Page2.txt_4c_ContaOs.Value, "Buscar Conta Origem")
        ENDIF
    ENDPROC

    PROCEDURE GrupoDsLookupKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 28
            THIS.AbrirLookupGrupoDs()
        ENDIF
    ENDPROC

    PROCEDURE GrupoDsLookupDblClick()
        THIS.AbrirLookupGrupoDs()
    ENDPROC

    PROCEDURE AbrirLookupGrupoDs()
        IF THIS.pgf_4c_Paginas.Page2.txt_4c_GrupoDs.Enabled
            THIS.pgf_4c_Paginas.Page2.txt_4c_GrupoDs.Value = ;
                THIS.AbrirBuscaGrupoConta("SigCdGcr", "Codigos", "Descrs", ;
                    THIS.pgf_4c_Paginas.Page2.txt_4c_GrupoDs.Value, "Buscar Grupo Destino")
        ENDIF
    ENDPROC

    PROCEDURE ContaDsLookupKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 28
            THIS.AbrirLookupContaDs()
        ENDIF
    ENDPROC

    PROCEDURE ContaDsLookupDblClick()
        THIS.AbrirLookupContaDs()
    ENDPROC

    PROCEDURE AbrirLookupContaDs()
        IF THIS.pgf_4c_Paginas.Page2.txt_4c_ContaDs.Enabled
            THIS.pgf_4c_Paginas.Page2.txt_4c_ContaDs.Value = ;
                THIS.AbrirBuscaGrupoConta("SigCdCli", "Iclis", "Rclis", ;
                    THIS.pgf_4c_Paginas.Page2.txt_4c_ContaDs.Value, "Buscar Conta Destino")
        ENDIF
    ENDPROC

    PROCEDURE VendsLookupKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 28
            THIS.AbrirLookupVends()
        ENDIF
    ENDPROC

    PROCEDURE VendsLookupDblClick()
        THIS.AbrirLookupVends()
    ENDPROC

    PROCEDURE AbrirLookupVends()
        IF THIS.pgf_4c_Paginas.Page2.txt_4c_Vends.Enabled
            THIS.pgf_4c_Paginas.Page2.txt_4c_Vends.Value = ;
                THIS.AbrirBuscaGrupoConta("SigCdCli", "Iclis", "Rclis", ;
                    THIS.pgf_4c_Paginas.Page2.txt_4c_Vends.Value, "Buscar Vendedor")
        ENDIF
    ENDPROC

    *===========================================================================
    * AbrirBuscaGrupoConta - Helper comum aos lookups de Grupo/Conta/Vendedor
    * (mesmo par tabela/campo-chave/campo-descricao, unica coisa que muda
    * entre eles e a tabela e o titulo do dialogo)
    *===========================================================================
    PROTECTED PROCEDURE AbrirBuscaGrupoConta(par_cTabela, par_cCampoChave, par_cCampoDesc, par_cValorAtual, par_cTitulo)
        LOCAL loc_oBusca, loc_cCursor, loc_cRetorno
        loc_cRetorno = ALLTRIM(par_cValorAtual)
        loc_cCursor  = "cursor_4c_BuscaGrpCta"

        TRY
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                par_cTabela, loc_cCursor, par_cCampoChave, ALLTRIM(par_cValorAtual), par_cTitulo)

            IF VARTYPE(loc_oBusca) = "O"
                IF !loc_oBusca.this_lAchouRegistro
                    loc_oBusca.mAddColuna(par_cCampoChave, "", "C" + CHR(243) + "digo")
                    loc_oBusca.mAddColuna(par_cCampoDesc, "", "Descri" + CHR(231) + CHR(227) + "o")
                    loc_oBusca.Show()
                ENDIF

                IF loc_oBusca.this_lSelecionou AND USED(loc_cCursor)
                    SELECT (loc_cCursor)
                    loc_cRetorno = ALLTRIM(EVALUATE(loc_cCursor + "." + par_cCampoChave))
                ENDIF

                loc_oBusca.Release()
            ENDIF

            IF USED(loc_cCursor)
                USE IN (loc_cCursor)
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao buscar " + par_cTitulo + ":" + CHR(13) + loException.Message, ;
                "Formsigmvcab.AbrirBuscaGrupoConta")
            IF USED(loc_cCursor)
                USE IN (loc_cCursor)
            ENDIF
        ENDTRY

        RETURN loc_cRetorno
    ENDPROC

    *===========================================================================
    * Destroy - Libera recursos ao fechar o formulario
    *===========================================================================
    PROCEDURE Destroy()
        IF VARTYPE(THIS.this_oBusinessObject) = "O"
            THIS.this_oBusinessObject = .NULL.
        ENDIF

        IF USED("cursor_4c_Dados")
            USE IN cursor_4c_Dados
        ENDIF

        IF USED("cursor_4c_BuscaMov")
            USE IN cursor_4c_BuscaMov
        ENDIF

        IF USED("cursor_4c_BuscaGrpCta")
            USE IN cursor_4c_BuscaGrpCta
        ENDIF

        DODEFAULT()
    ENDPROC

ENDDEFINE


### BO (C:\4c\projeto\app\classes\sigmvcabBO.prg):
*====================================================================
* sigmvcabBO.prg
*
* Business Object para Movimentacao (Cabecalho) - SIGMVCAB
* Tabela: SigMvCab
* Chave: cidchaves (fUniqueIds())
* Herda de: BusinessBase
*
* FASE 1/8: Propriedades e Init() - demais metodos vem nas proximas fases
*====================================================================

DEFINE CLASS sigmvcabBO AS BusinessBase

    *-- Propriedades da entidade (mapeamento para tabela SigMvCab)
    this_nNpedclis      = 0    && npedclis numeric(11,0)
    this_nAcres         = 0    && acres numeric(8,4)
    this_cAntecs        = ""   && antecs char(6)
    this_lChksubn       = .F.  && chksubn bit
    this_nCodpeds       = 0    && codpeds numeric(8,0)
    this_cContads       = ""   && contads char(10)
    this_cContaos       = ""   && contaos char(10)
    this_dDatars        = {}   && datars datetime NULL
    this_dDatas         = {}   && datas datetime NULL
    this_dDatatrans     = {}   && datatrans datetime NULL
    this_nDesc2s        = 0    && desc2s numeric(5,2)
    this_nDescs         = 0    && descs numeric(8,4)
    this_nDevols        = 0    && devols numeric(8,0)
    this_cDopes         = ""   && dopes char(20)
    this_cEmpds         = ""   && empds char(3)
    this_cEmps          = ""   && emps char(3)
    this_cGrresps       = ""   && grresps char(10)
    this_cGrupods       = ""   && grupods char(10)
    this_cGrupoos       = ""   && grupoos char(10)
    this_cGrupos        = ""   && grupos char(10)
    this_cGrvends       = ""   && grvends char(10)
    this_cIclis         = ""   && iclis char(10)
    this_cIfors         = ""   && ifors char(10)
    this_cLocals        = ""   && locals char(10)
    this_nLotechqs      = 0    && lotechqs numeric(8,0)
    this_cLprecos       = ""   && lprecos char(30)
    this_cMascnum       = ""   && mascnum char(10)
    this_cNcarnecs      = ""   && ncarnecs char(11)
    this_cNemps         = ""   && nemps char(40)
    this_nNops          = 0    && nops numeric(10,0)
    this_cNotas         = ""   && notas char(6)
    this_cNrcons        = ""   && nrcons char(10)
    this_nNtrans        = 0    && ntrans numeric(6,0)
    this_nNumes         = 0    && numes numeric(6,0)
    this_nNumolds       = 0    && numolds numeric(6,0)
    this_cObses         = ""   && obses text NULL (memo)
    this_cOpers         = ""   && opers char(1)
    this_dPrazoents     = {}   && prazoents datetime NULL
    this_cResps         = ""   && resps char(10)
    this_cTabds         = ""   && tabds char(10)
    this_cTpfats        = ""   && tpfats char(3)
    this_lTransps       = .F.  && transps bit
    this_cUsuals        = ""   && usuals char(10)
    this_cUsuars        = ""   && usuars char(10)
    this_cUsulibs       = ""   && usulibs char(10)
    this_nValacres      = 0    && valacres numeric(11,2)
    this_nValdes2s      = 0    && valdes2s numeric(11,2)
    this_nValdescs      = 0    && valdescs numeric(11,2)
    this_nValdevs       = 0    && valdevs numeric(11,2)
    this_nValencs       = 0    && valencs numeric(11,2)
    this_nValinis       = 0    && valinis numeric(11,2)
    this_nValos         = 0    && valos numeric(11,2)
    this_nValservs      = 0    && valservs numeric(11,2)
    this_nValvars       = 0    && valvars numeric(11,2)
    this_nVars          = 0    && vars numeric(9,4)
    this_cVends         = ""   && vends char(10)
    this_cCotusus       = ""   && cotusus char(10)
    this_dDtemis        = {}   && dtemis datetime NULL
    this_cEspes         = ""   && espes char(10)
    this_nPbrus         = 0    && pbrus numeric(10,3) NULL
    this_nPliqs         = 0    && pliqs numeric(10,3) NULL
    this_nQtdes         = 0    && qtdes numeric(6,0)
    this_lLcancelas     = .F.  && lcancelas bit
    this_lCofs          = .F.  && cofs bit
    this_lLivros        = .F.  && livros bit
    this_dDttransms     = {}   && dttransms datetime NULL
    this_lChkbxparcs    = .F.  && chkbxparcs bit
    this_cEcfs          = ""   && ecfs char(7)
    this_nCodobs        = 0    && codobs numeric(3,0)
    this_cDgopes        = ""   && dgopes char(20)
    this_dDtfechas      = {}   && dtfechas datetime NULL
    this_nTrfisicos     = 0    && trfisicos numeric(2,0)
    this_nUtilizados    = 0    && utilizados numeric(1,0)
    this_nValndevs      = 0    && valndevs numeric(11,2)
    this_nValobxs       = 0    && valobxs numeric(11,2)
    this_cNoforms       = ""   && noforms char(10)
    this_cAuditors      = ""   && auditors char(10)
    this_dDtaudits      = {}   && dtaudits datetime NULL
    this_cCidchaves     = ""   && cidchaves char(20) - PK (fUniqueIds())
    this_dDtalts        = {}   && dtalts datetime NULL
    this_cEmpdopnums    = ""   && empdopnums char(29)
    this_dDtbaixas      = {}   && dtbaixas datetime NULL
    this_dDtrecs        = {}   && dtrecs datetime NULL
    this_cEmpgopnums    = ""   && empgopnums char(29)
    this_cContaes       = ""   && contaes char(10)
    this_dDtagends      = {}   && dtagends datetime NULL
    this_nLocalents     = 0    && localents numeric(10,0)
    this_cLocalizas     = ""   && localizas char(6)
    this_lChkpagos      = .F.  && chkpagos bit
    this_lChkpgs        = .F.  && chkpgs bit
    this_cCodtrans      = ""   && codtrans char(10)
    this_dDtbxestqs     = {}   && dtbxestqs datetime NULL
    this_cEmpdnbxs      = ""   && empdnbxs char(29)
    this_cEmpdncrds     = ""   && empdncrds char(29)
    this_cObsagends     = ""   && obsagends char(15)
    this_cOperadors     = ""   && operadors char(10)
    this_nVcompensas    = 0    && vcompensas numeric(5,2)
    this_dDtrtrans      = {}   && dtrtrans datetime NULL
    this_cMotdscs       = ""   && motdscs char(10)
    this_nNdeclaras     = 0    && ndeclaras numeric(10,0)
    this_nNumbalds      = 0    && numbalds numeric(6,0)
    this_nNumbals       = 0    && numbals numeric(6,0)
    this_nPriors        = 0    && priors numeric(2,0)
    this_lProcbals      = .F.  && procbals bit
    this_lProcdbal      = .F.  && procdbal bit
    this_nProtats       = 0    && protats numeric(6,0)
    this_cUsupagos      = ""   && usupagos char(10)
    this_cUltgrvs       = ""   && ultgrvs char(40)
    this_cMoeits        = ""   && moeits char(3)
    this_dDtagendfs     = {}   && dtagendfs datetime NULL
    this_nRnops         = 0    && rnops numeric(10,0)
    this_nImpress       = 0    && impress numeric(1,0)
    this_dPrzclis       = {}   && przclis datetime NULL
    this_cPstatus       = ""   && pstatus char(1)
    this_nValvarps      = 0    && valvarps numeric(11,2)
    this_cCifccfs       = ""   && cifccfs char(6)
    this_nCupfis        = 0    && cupfis numeric(1,0)
    this_nIdconta       = 0    && idconta numeric(10,0)
    this_cNcupoms       = ""   && ncupoms char(6)
    this_cStatus        = ""   && status char(3)
    this_nValtrans      = 0    && valtrans numeric(8,2)
    this_nImpcpfs       = 0    && impcpfs numeric(1,0)
    this_cCcfgnfs       = ""   && ccfgnfs char(6)
    this_cFpubls        = ""   && fpubls char(3)
    this_cJobs          = ""   && jobs char(10)
    this_nPtax1s        = 0    && ptax1s numeric(4,2)
    this_nPtax2s        = 0    && ptax2s numeric(4,2)
    this_nPtax3s        = 0    && ptax3s numeric(4,2)
    this_cObscabmovs    = ""   && obscabmovs char(40)
    this_cCodobs2       = ""   && codobs2 char(60)
    this_nValserfix     = 0    && valserfix numeric(12,2)
    this_nPerserfix     = 0    && perserfix numeric(5,2)
    this_nValosfix      = 0    && valosfix numeric(12,2)
    this_nChkencerra    = 0    && chkencerra numeric(1,0)
    this_nPerdesc       = 0    && perdesc numeric(4,2)
    this_cCompet        = ""   && compet char(10)
    this_cPedidoweb     = ""   && pedidoweb char(50)
    this_cCdrastreio    = ""   && cdrastreio char(20)
    this_cIdentrega     = ""   && identrega char(50)
    this_cIdtransp      = ""   && idtransp char(15)
    this_nPeracresc     = 0    && peracresc numeric(4,2)
    this_cTpmovs        = ""   && tpmovs char(2)
    this_cEmpfats       = ""   && empfats char(3)
    this_cNumeronota    = ""   && numeronota char(10)
    this_cMeiotrans     = ""   && meiotrans char(50)
    this_cChavenota     = ""   && chavenota char(44)
    this_cContaccs      = ""   && contaccs char(10)
    this_cGrupoccs      = ""   && grupoccs char(10)
    this_nNatend        = 0    && natend numeric(6,0)
    this_nNlivdg        = 0    && nlivdg numeric(15,0)
    this_nPresente      = 0    && presente numeric(1,0)
    this_cChaveexterna  = ""   && chaveexterna char(33)
    this_cEmpret        = ""   && empret char(3)
    this_cMsgpresnte    = ""   && msgpresnte char(150)
    this_nCkoperpend    = 0    && ckoperpend numeric(1,0)
    this_dDtfabricacao  = {}   && dtfabricacao datetime NULL
    this_dDtvalidade    = {}   && dtvalidade datetime NULL
    this_cUsuconfs      = ""   && usuconfs char(10)

    *====================================================================
    * Init - Inicializa Business Object
    *====================================================================
    PROCEDURE Init()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            DODEFAULT()
            THIS.this_cTabela     = "SigMvCab"
            THIS.this_cCampoChave = "cidchaves"
            loc_lSucesso = .T.
        CATCH TO loException
            MostrarErro(loException, "sigmvcabBO.Init")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * ObterChavePrimaria - Retorna a chave primaria (cidchaves) para
    * uso em RegistrarAuditoria()
    *====================================================================
    PROTECTED PROCEDURE ObterChavePrimaria()
        RETURN ALLTRIM(THIS.this_cCidchaves)
    ENDPROC

    *====================================================================
    * CarregarDoCursor - Mapeia TODAS as colunas do cursor SQL para as
    * propriedades do BO. SEMPRE usar SELECT (par_cAliasCursor) antes de
    * acessar os campos (regra #8 CLAUDE.md).
    *====================================================================
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF USED(par_cAliasCursor)
                SELECT (par_cAliasCursor)

                THIS.this_nNpedclis = TratarNulo(npedclis, "N")
                THIS.this_nAcres = TratarNulo(acres, "N")
                THIS.this_cAntecs = TratarNulo(antecs, "C")
                IF VARTYPE(chksubn) = "L"
                    THIS.this_lChksubn = chksubn
                ELSE
                    THIS.this_lChksubn = (NVL(chksubn, 0) = 1)
                ENDIF
                THIS.this_nCodpeds = TratarNulo(codpeds, "N")
                THIS.this_cContads = TratarNulo(contads, "C")
                THIS.this_cContaos = TratarNulo(contaos, "C")
                THIS.this_dDatars = TratarNulo(datars, "D")
                THIS.this_dDatas = TratarNulo(datas, "D")
                THIS.this_dDatatrans = TratarNulo(datatrans, "D")
                THIS.this_nDesc2s = TratarNulo(desc2s, "N")
                THIS.this_nDescs = TratarNulo(descs, "N")
                THIS.this_nDevols = TratarNulo(devols, "N")
                THIS.this_cDopes = TratarNulo(dopes, "C")
                THIS.this_cEmpds = TratarNulo(empds, "C")
                THIS.this_cEmps = TratarNulo(emps, "C")
                THIS.this_cGrresps = TratarNulo(grresps, "C")
                THIS.this_cGrupods = TratarNulo(grupods, "C")
                THIS.this_cGrupoos = TratarNulo(grupoos, "C")
                THIS.this_cGrupos = TratarNulo(grupos, "C")
                THIS.this_cGrvends = TratarNulo(grvends, "C")
                THIS.this_cIclis = TratarNulo(iclis, "C")
                THIS.this_cIfors = TratarNulo(ifors, "C")
                THIS.this_cLocals = TratarNulo(locals, "C")
                THIS.this_nLotechqs = TratarNulo(lotechqs, "N")
                THIS.this_cLprecos = TratarNulo(lprecos, "C")
                THIS.this_cMascnum = TratarNulo(mascnum, "C")
                THIS.this_cNcarnecs = TratarNulo(ncarnecs, "C")
                THIS.this_cNemps = TratarNulo(nemps, "C")
                THIS.this_nNops = TratarNulo(nops, "N")
                THIS.this_cNotas = TratarNulo(notas, "C")
                THIS.this_cNrcons = TratarNulo(nrcons, "C")
                THIS.this_nNtrans = TratarNulo(ntrans, "N")
                THIS.this_nNumes = TratarNulo(numes, "N")
                THIS.this_nNumolds = TratarNulo(numolds, "N")
                THIS.this_cObses = TratarNulo(obses, "C")
                THIS.this_cOpers = TratarNulo(opers, "C")
                THIS.this_dPrazoents = TratarNulo(prazoents, "D")
                THIS.this_cResps = TratarNulo(resps, "C")
                THIS.this_cTabds = TratarNulo(tabds, "C")
                THIS.this_cTpfats = TratarNulo(tpfats, "C")
                IF VARTYPE(transps) = "L"
                    THIS.this_lTransps = transps
                ELSE
                    THIS.this_lTransps = (NVL(transps, 0) = 1)
                ENDIF
                THIS.this_cUsuals = TratarNulo(usuals, "C")
                THIS.this_cUsuars = TratarNulo(usuars, "C")
                THIS.this_cUsulibs = TratarNulo(usulibs, "C")
                THIS.this_nValacres = TratarNulo(valacres, "N")
                THIS.this_nValdes2s = TratarNulo(valdes2s, "N")
                THIS.this_nValdescs = TratarNulo(valdescs, "N")
                THIS.this_nValdevs = TratarNulo(valdevs, "N")
                THIS.this_nValencs = TratarNulo(valencs, "N")
                THIS.this_nValinis = TratarNulo(valinis, "N")
                THIS.this_nValos = TratarNulo(valos, "N")
                THIS.this_nValservs = TratarNulo(valservs, "N")
                THIS.this_nValvars = TratarNulo(valvars, "N")
                THIS.this_nVars = TratarNulo(vars, "N")
                THIS.this_cVends = TratarNulo(vends, "C")
                THIS.this_cCotusus = TratarNulo(cotusus, "C")
                THIS.this_dDtemis = TratarNulo(dtemis, "D")
                THIS.this_cEspes = TratarNulo(espes, "C")
                THIS.this_nPbrus = TratarNulo(pbrus, "N")
                THIS.this_nPliqs = TratarNulo(pliqs, "N")
                THIS.this_nQtdes = TratarNulo(qtdes, "N")
                IF VARTYPE(lcancelas) = "L"
                    THIS.this_lLcancelas = lcancelas
                ELSE
                    THIS.this_lLcancelas = (NVL(lcancelas, 0) = 1)
                ENDIF
                IF VARTYPE(cofs) = "L"
                    THIS.this_lCofs = cofs
                ELSE
                    THIS.this_lCofs = (NVL(cofs, 0) = 1)
                ENDIF
                IF VARTYPE(livros) = "L"
                    THIS.this_lLivros = livros
                ELSE
                    THIS.this_lLivros = (NVL(livros, 0) = 1)
                ENDIF
                THIS.this_dDttransms = TratarNulo(dttransms, "D")
                IF VARTYPE(chkbxparcs) = "L"
                    THIS.this_lChkbxparcs = chkbxparcs
                ELSE
                    THIS.this_lChkbxparcs = (NVL(chkbxparcs, 0) = 1)
                ENDIF
                THIS.this_cEcfs = TratarNulo(ecfs, "C")
                THIS.this_nCodobs = TratarNulo(codobs, "N")
                THIS.this_cDgopes = TratarNulo(dgopes, "C")
                THIS.this_dDtfechas = TratarNulo(dtfechas, "D")
                THIS.this_nTrfisicos = TratarNulo(trfisicos, "N")
                THIS.this_nUtilizados = TratarNulo(utilizados, "N")
                THIS.this_nValndevs = TratarNulo(valndevs, "N")
                THIS.this_nValobxs = TratarNulo(valobxs, "N")
                THIS.this_cNoforms = TratarNulo(noforms, "C")
                THIS.this_cAuditors = TratarNulo(auditors, "C")
                THIS.this_dDtaudits = TratarNulo(dtaudits, "D")
                THIS.this_cCidchaves = TratarNulo(cidchaves, "C")
                THIS.this_dDtalts = TratarNulo(dtalts, "D")
                THIS.this_cEmpdopnums = TratarNulo(empdopnums, "C")
                THIS.this_dDtbaixas = TratarNulo(dtbaixas, "D")
                THIS.this_dDtrecs = TratarNulo(dtrecs, "D")
                THIS.this_cEmpgopnums = TratarNulo(empgopnums, "C")
                THIS.this_cContaes = TratarNulo(contaes, "C")
                THIS.this_dDtagends = TratarNulo(dtagends, "D")
                THIS.this_nLocalents = TratarNulo(localents, "N")
                THIS.this_cLocalizas = TratarNulo(localizas, "C")
                IF VARTYPE(chkpagos) = "L"
                    THIS.this_lChkpagos = chkpagos
                ELSE
                    THIS.this_lChkpagos = (NVL(chkpagos, 0) = 1)
                ENDIF
                IF VARTYPE(chkpgs) = "L"
                    THIS.this_lChkpgs = chkpgs
                ELSE
                    THIS.this_lChkpgs = (NVL(chkpgs, 0) = 1)
                ENDIF
                THIS.this_cCodtrans = TratarNulo(codtrans, "C")
                THIS.this_dDtbxestqs = TratarNulo(dtbxestqs, "D")
                THIS.this_cEmpdnbxs = TratarNulo(empdnbxs, "C")
                THIS.this_cEmpdncrds = TratarNulo(empdncrds, "C")
                THIS.this_cObsagends = TratarNulo(obsagends, "C")
                THIS.this_cOperadors = TratarNulo(operadors, "C")
                THIS.this_nVcompensas = TratarNulo(vcompensas, "N")
                THIS.this_dDtrtrans = TratarNulo(dtrtrans, "D")
                THIS.this_cMotdscs = TratarNulo(motdscs, "C")
                THIS.this_nNdeclaras = TratarNulo(ndeclaras, "N")
                THIS.this_nNumbalds = TratarNulo(numbalds, "N")
                THIS.this_nNumbals = TratarNulo(numbals, "N")
                THIS.this_nPriors = TratarNulo(priors, "N")
                IF VARTYPE(procbals) = "L"
                    THIS.this_lProcbals = procbals
                ELSE
                    THIS.this_lProcbals = (NVL(procbals, 0) = 1)
                ENDIF
                IF VARTYPE(procdbal) = "L"
                    THIS.this_lProcdbal = procdbal
                ELSE
                    THIS.this_lProcdbal = (NVL(procdbal, 0) = 1)
                ENDIF
                THIS.this_nProtats = TratarNulo(protats, "N")
                THIS.this_cUsupagos = TratarNulo(usupagos, "C")
                THIS.this_cUltgrvs = TratarNulo(ultgrvs, "C")
                THIS.this_cMoeits = TratarNulo(moeits, "C")
                THIS.this_dDtagendfs = TratarNulo(dtagendfs, "D")
                THIS.this_nRnops = TratarNulo(rnops, "N")
                THIS.this_nImpress = TratarNulo(impress, "N")
                THIS.this_dPrzclis = TratarNulo(przclis, "D")
                THIS.this_cPstatus = TratarNulo(pstatus, "C")
                THIS.this_nValvarps = TratarNulo(valvarps, "N")
                THIS.this_cCifccfs = TratarNulo(cifccfs, "C")
                THIS.this_nCupfis = TratarNulo(cupfis, "N")
                THIS.this_nIdconta = TratarNulo(idconta, "N")
                THIS.this_cNcupoms = TratarNulo(ncupoms, "C")
                THIS.this_cStatus = TratarNulo(status, "C")
                THIS.this_nValtrans = TratarNulo(valtrans, "N")
                THIS.this_nImpcpfs = TratarNulo(impcpfs, "N")
                THIS.this_cCcfgnfs = TratarNulo(ccfgnfs, "C")
                THIS.this_cFpubls = TratarNulo(fpubls, "C")
                THIS.this_cJobs = TratarNulo(jobs, "C")
                THIS.this_nPtax1s = TratarNulo(ptax1s, "N")
                THIS.this_nPtax2s = TratarNulo(ptax2s, "N")
                THIS.this_nPtax3s = TratarNulo(ptax3s, "N")
                THIS.this_cObscabmovs = TratarNulo(obscabmovs, "C")
                THIS.this_cCodobs2 = TratarNulo(codobs2, "C")
                THIS.this_nValserfix = TratarNulo(valserfix, "N")
                THIS.this_nPerserfix = TratarNulo(perserfix, "N")
                THIS.this_nValosfix = TratarNulo(valosfix, "N")
                THIS.this_nChkencerra = TratarNulo(chkencerra, "N")
                THIS.this_nPerdesc = TratarNulo(perdesc, "N")
                THIS.this_cCompet = TratarNulo(compet, "C")
                THIS.this_cPedidoweb = TratarNulo(pedidoweb, "C")
                THIS.this_cCdrastreio = TratarNulo(cdrastreio, "C")
                THIS.this_cIdentrega = TratarNulo(identrega, "C")
                THIS.this_cIdtransp = TratarNulo(idtransp, "C")
                THIS.this_nPeracresc = TratarNulo(peracresc, "N")
                THIS.this_cTpmovs = TratarNulo(tpmovs, "C")
                THIS.this_cEmpfats = TratarNulo(empfats, "C")
                THIS.this_cNumeronota = TratarNulo(numeronota, "C")
                THIS.this_cMeiotrans = TratarNulo(meiotrans, "C")
                THIS.this_cChavenota = TratarNulo(chavenota, "C")
                THIS.this_cContaccs = TratarNulo(contaccs, "C")
                THIS.this_cGrupoccs = TratarNulo(grupoccs, "C")
                THIS.this_nNatend = TratarNulo(natend, "N")
                THIS.this_nNlivdg = TratarNulo(nlivdg, "N")
                THIS.this_nPresente = TratarNulo(presente, "N")
                THIS.this_cChaveexterna = TratarNulo(chaveexterna, "C")
                THIS.this_cEmpret = TratarNulo(empret, "C")
                THIS.this_cMsgpresnte = TratarNulo(msgpresnte, "C")
                THIS.this_nCkoperpend = TratarNulo(ckoperpend, "N")
                THIS.this_dDtfabricacao = TratarNulo(dtfabricacao, "D")
                THIS.this_dDtvalidade = TratarNulo(dtvalidade, "D")
                THIS.this_cUsuconfs = TratarNulo(usuconfs, "C")

                loc_lSucesso = .T.
            ENDIF
        CATCH TO loException
            MsgErro(loException.Message, "Erro em sigmvcabBO.CarregarDoCursor")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * Inserir - Insere novo registro em SigMvCab
    * PK (cidchaves) gerada via fUniqueIds() se ainda nao preenchida
    *====================================================================
    PROTECTED PROCEDURE Inserir()
        LOCAL loc_cSQL, loc_nResult, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF EMPTY(ALLTRIM(NVL(THIS.this_cCidchaves, "")))
                THIS.this_cCidchaves = LEFT(fUniqueIds(), 20)
            ENDIF

            *-- Campo computado: Emps + Dopes + Numes (chave de movimentacao)
            THIS.this_cEmpdopnums = PADR(THIS.this_cEmps, 3) + PADR(THIS.this_cDopes, 20) + STR(THIS.this_nNumes, 6)

            loc_cSQL = "INSERT INTO SigMvCab (" + ;
                "npedclis, acres, antecs, chksubn, codpeds, contads, contaos, datars," + ;
                "datas, datatrans, desc2s, descs, devols, dopes, empds, emps," + ;
                "grresps, grupods, grupoos, grupos, grvends, iclis, ifors, locals," + ;
                "lotechqs, lprecos, mascnum, ncarnecs, nemps, nops, notas, nrcons," + ;
                "ntrans, numes, numolds, obses, opers, prazoents, resps, tabds," + ;
                "tpfats, transps, usuals, usuars, usulibs, valacres, valdes2s, valdescs," + ;
                "valdevs, valencs, valinis, valos, valservs, valvars, vars, vends," + ;
                "cotusus, dtemis, espes, pbrus, pliqs, qtdes, lcancelas, cofs," + ;
                "livros, dttransms, chkbxparcs, ecfs, codobs, dgopes, dtfechas, trfisicos," + ;
                "utilizados, valndevs, valobxs, noforms, auditors, dtaudits, cidchaves, dtalts," + ;
                "empdopnums, dtbaixas, dtrecs, empgopnums, contaes, dtagends, localents, localizas," + ;
                "chkpagos, chkpgs, codtrans, dtbxestqs, empdnbxs, empdncrds, obsagends, operadors," + ;
                "vcompensas, dtrtrans, motdscs, ndeclaras, numbalds, numbals, priors, procbals," + ;
                "procdbal, protats, usupagos, ultgrvs, moeits, dtagendfs, rnops, impress," + ;
                "przclis, pstatus, valvarps, cifccfs, cupfis, idconta, ncupoms, status," + ;
                "valtrans, impcpfs, ccfgnfs, fpubls, jobs, ptax1s, ptax2s, ptax3s," + ;
                "obscabmovs, codobs2, valserfix, perserfix, valosfix, chkencerra, perdesc, compet," + ;
                "pedidoweb, cdrastreio, identrega, idtransp, peracresc, tpmovs, empfats, numeronota," + ;
                "meiotrans, chavenota, contaccs, grupoccs, natend, nlivdg, presente, chaveexterna," + ;
                "empret, msgpresnte, ckoperpend, dtfabricacao, dtvalidade, usuconfs" + ;
                ") VALUES (" + ;
                FormatarNumeroSQL(THIS.this_nNpedclis, 0) + "," + ;
                FormatarNumeroSQL(THIS.this_nAcres, 4) + "," + ;
                EscaparSQL(LEFT(THIS.this_cAntecs, 6)) + "," + ;
                IIF(THIS.this_lChksubn, 1, 0) + "," + ;
                FormatarNumeroSQL(THIS.this_nCodpeds, 0) + "," + ;
                EscaparSQL(LEFT(THIS.this_cContads, 10)) + "," + ;
                EscaparSQL(LEFT(THIS.this_cContaos, 10)) + "," + ;
                FormatarDataSQL(THIS.this_dDatars) + "," + ;
                FormatarDataSQL(THIS.this_dDatas) + "," + ;
                FormatarDataSQL(THIS.this_dDatatrans) + "," + ;
                FormatarNumeroSQL(THIS.this_nDesc2s, 2) + "," + ;
                FormatarNumeroSQL(THIS.this_nDescs, 4) + "," + ;
                FormatarNumeroSQL(THIS.this_nDevols, 0) + "," + ;
                EscaparSQL(LEFT(THIS.this_cDopes, 20)) + "," + ;
                EscaparSQL(LEFT(THIS.this_cEmpds, 3)) + "," + ;
                EscaparSQL(LEFT(THIS.this_cEmps, 3)) + "," + ;
                EscaparSQL(LEFT(THIS.this_cGrresps, 10)) + "," + ;
                EscaparSQL(LEFT(THIS.this_cGrupods, 10)) + "," + ;
                EscaparSQL(LEFT(THIS.this_cGrupoos, 10)) + "," + ;
                EscaparSQL(LEFT(THIS.this_cGrupos, 10)) + "," + ;
                EscaparSQL(LEFT(THIS.this_cGrvends, 10)) + "," + ;
                EscaparSQL(LEFT(THIS.this_cIclis, 10)) + "," + ;
                EscaparSQL(LEFT(THIS.this_cIfors, 10)) + "," + ;
                EscaparSQL(LEFT(THIS.this_cLocals, 10)) + "," + ;
                FormatarNumeroSQL(THIS.this_nLotechqs, 0) + "," + ;
                EscaparSQL(LEFT(THIS.this_cLprecos, 30)) + "," + ;
                EscaparSQL(LEFT(THIS.this_cMascnum, 10)) + "," + ;
                EscaparSQL(LEFT(THIS.this_cNcarnecs, 11)) + "," + ;
                EscaparSQL(LEFT(THIS.this_cNemps, 40)) + "," + ;
                FormatarNumeroSQL(THIS.this_nNops, 0) + "," + ;
                EscaparSQL(LEFT(THIS.this_cNotas, 6)) + "," + ;
                EscaparSQL(LEFT(THIS.this_cNrcons, 10)) + "," + ;
                FormatarNumeroSQL(THIS.this_nNtrans, 0) + "," + ;
                FormatarNumeroSQL(THIS.this_nNumes, 0) + "," + ;
                FormatarNumeroSQL(THIS.this_nNumolds, 0) + "," + ;
                EscaparSQL(THIS.this_cObses) + "," + ;
                EscaparSQL(LEFT(THIS.this_cOpers, 1)) + "," + ;
                FormatarDataSQL(THIS.this_dPrazoents) + "," + ;
                EscaparSQL(LEFT(THIS.this_cResps, 10)) + "," + ;
                EscaparSQL(LEFT(THIS.this_cTabds, 10)) + "," + ;
                EscaparSQL(LEFT(THIS.this_cTpfats, 3)) + "," + ;
                IIF(THIS.this_lTransps, 1, 0) + "," + ;
                EscaparSQL(LEFT(THIS.this_cUsuals, 10)) + "," + ;
                EscaparSQL(LEFT(THIS.this_cUsuars, 10)) + "," + ;
                EscaparSQL(LEFT(THIS.this_cUsulibs, 10)) + "," + ;
                FormatarNumeroSQL(THIS.this_nValacres, 2) + "," + ;
                FormatarNumeroSQL(THIS.this_nValdes2s, 2) + "," + ;
                FormatarNumeroSQL(THIS.this_nValdescs, 2) + "," + ;
                FormatarNumeroSQL(THIS.this_nValdevs, 2) + "," + ;
                FormatarNumeroSQL(THIS.this_nValencs, 2) + "," + ;
                FormatarNumeroSQL(THIS.this_nValinis, 2) + "," + ;
                FormatarNumeroSQL(THIS.this_nValos, 2) + "," + ;
                FormatarNumeroSQL(THIS.this_nValservs, 2) + "," + ;
                FormatarNumeroSQL(THIS.this_nValvars, 2) + "," + ;
                FormatarNumeroSQL(THIS.this_nVars, 4) + "," + ;
                EscaparSQL(LEFT(THIS.this_cVends, 10)) + "," + ;
                EscaparSQL(LEFT(THIS.this_cCotusus, 10)) + "," + ;
                FormatarDataSQL(THIS.this_dDtemis) + "," + ;
                EscaparSQL(LEFT(THIS.this_cEspes, 10)) + "," + ;
                FormatarNumeroSQL(THIS.this_nPbrus, 3) + "," + ;
                FormatarNumeroSQL(THIS.this_nPliqs, 3) + "," + ;
                FormatarNumeroSQL(THIS.this_nQtdes, 0) + "," + ;
                IIF(THIS.this_lLcancelas, 1, 0) + "," + ;
                IIF(THIS.this_lCofs, 1, 0) + "," + ;
                IIF(THIS.this_lLivros, 1, 0) + "," + ;
                FormatarDataSQL(THIS.this_dDttransms) + "," + ;
                IIF(THIS.this_lChkbxparcs, 1, 0) + "," + ;
                EscaparSQL(LEFT(THIS.this_cEcfs, 7)) + "," + ;
                FormatarNumeroSQL(THIS.this_nCodobs, 0) + "," + ;
                EscaparSQL(LEFT(THIS.this_cDgopes, 20)) + "," + ;
                FormatarDataSQL(THIS.this_dDtfechas) + "," + ;
                FormatarNumeroSQL(THIS.this_nTrfisicos, 0) + "," + ;
                FormatarNumeroSQL(THIS.this_nUtilizados, 0) + "," + ;
                FormatarNumeroSQL(THIS.this_nValndevs, 2) + "," + ;
                FormatarNumeroSQL(THIS.this_nValobxs, 2) + "," + ;
                EscaparSQL(LEFT(THIS.this_cNoforms, 10)) + "," + ;
                EscaparSQL(LEFT(THIS.this_cAuditors, 10)) + "," + ;
                FormatarDataSQL(THIS.this_dDtaudits) + "," + ;
                EscaparSQL(LEFT(THIS.this_cCidchaves, 20)) + "," + ;
                FormatarDataSQL(THIS.this_dDtalts) + "," + ;
                EscaparSQL(LEFT(THIS.this_cEmpdopnums, 29)) + "," + ;
                FormatarDataSQL(THIS.this_dDtbaixas) + "," + ;
                FormatarDataSQL(THIS.this_dDtrecs) + "," + ;
                EscaparSQL(LEFT(THIS.this_cEmpgopnums, 29)) + "," + ;
                EscaparSQL(LEFT(THIS.this_cContaes, 10)) + "," + ;
                FormatarDataSQL(THIS.this_dDtagends) + "," + ;
                FormatarNumeroSQL(THIS.this_nLocalents, 0) + "," + ;
                EscaparSQL(LEFT(THIS.this_cLocalizas, 6)) + "," + ;
                IIF(THIS.this_lChkpagos, 1, 0) + "," + ;
                IIF(THIS.this_lChkpgs, 1, 0) + "," + ;
                EscaparSQL(LEFT(THIS.this_cCodtrans, 10)) + "," + ;
                FormatarDataSQL(THIS.this_dDtbxestqs) + "," + ;
                EscaparSQL(LEFT(THIS.this_cEmpdnbxs, 29)) + "," + ;
                EscaparSQL(LEFT(THIS.this_cEmpdncrds, 29)) + "," + ;
                EscaparSQL(LEFT(THIS.this_cObsagends, 15)) + "," + ;
                EscaparSQL(LEFT(THIS.this_cOperadors, 10)) + "," + ;
                FormatarNumeroSQL(THIS.this_nVcompensas, 2) + "," + ;
                FormatarDataSQL(THIS.this_dDtrtrans) + "," + ;
                EscaparSQL(LEFT(THIS.this_cMotdscs, 10)) + "," + ;
                FormatarNumeroSQL(THIS.this_nNdeclaras, 0) + "," + ;
                FormatarNumeroSQL(THIS.this_nNumbalds, 0) + "," + ;
                FormatarNumeroSQL(THIS.this_nNumbals, 0) + "," + ;
                FormatarNumeroSQL(THIS.this_nPriors, 0) + "," + ;
                IIF(THIS.this_lProcbals, 1, 0) + "," + ;
                IIF(THIS.this_lProcdbal, 1, 0) + "," + ;
                FormatarNumeroSQL(THIS.this_nProtats, 0) + "," + ;
                EscaparSQL(LEFT(THIS.this_cUsupagos, 10)) + "," + ;
                EscaparSQL(LEFT(THIS.this_cUltgrvs, 40)) + "," + ;
                EscaparSQL(LEFT(THIS.this_cMoeits, 3)) + "," + ;
                FormatarDataSQL(THIS.this_dDtagendfs) + "," + ;
                FormatarNumeroSQL(THIS.this_nRnops, 0) + "," + ;
                FormatarNumeroSQL(THIS.this_nImpress, 0) + "," + ;
                FormatarDataSQL(THIS.this_dPrzclis) + "," + ;
                EscaparSQL(LEFT(THIS.this_cPstatus, 1)) + "," + ;
                FormatarNumeroSQL(THIS.this_nValvarps, 2) + "," + ;
                EscaparSQL(LEFT(THIS.this_cCifccfs, 6)) + "," + ;
                FormatarNumeroSQL(THIS.this_nCupfis, 0) + "," + ;
                FormatarNumeroSQL(THIS.this_nIdconta, 0) + "," + ;
                EscaparSQL(LEFT(THIS.this_cNcupoms, 6)) + "," + ;
                EscaparSQL(LEFT(THIS.this_cStatus, 3)) + "," + ;
                FormatarNumeroSQL(THIS.this_nValtrans, 2) + "," + ;
                FormatarNumeroSQL(THIS.this_nImpcpfs, 0) + "," + ;
                EscaparSQL(LEFT(THIS.this_cCcfgnfs, 6)) + "," + ;
                EscaparSQL(LEFT(THIS.this_cFpubls, 3)) + "," + ;
                EscaparSQL(LEFT(THIS.this_cJobs, 10)) + "," + ;
                FormatarNumeroSQL(THIS.this_nPtax1s, 2) + "," + ;
                FormatarNumeroSQL(THIS.this_nPtax2s, 2) + "," + ;
                FormatarNumeroSQL(THIS.this_nPtax3s, 2) + "," + ;
                EscaparSQL(LEFT(THIS.this_cObscabmovs, 40)) + "," + ;
                EscaparSQL(LEFT(THIS.this_cCodobs2, 60)) + "," + ;
                FormatarNumeroSQL(THIS.this_nValserfix, 2) + "," + ;
                FormatarNumeroSQL(THIS.this_nPerserfix, 2) + "," + ;
                FormatarNumeroSQL(THIS.this_nValosfix, 2) + "," + ;
                FormatarNumeroSQL(THIS.this_nChkencerra, 0) + "," + ;
                FormatarNumeroSQL(THIS.this_nPerdesc, 2) + "," + ;
                EscaparSQL(LEFT(THIS.this_cCompet, 10)) + "," + ;
                EscaparSQL(LEFT(THIS.this_cPedidoweb, 50)) + "," + ;
                EscaparSQL(LEFT(THIS.this_cCdrastreio, 20)) + "," + ;
                EscaparSQL(LEFT(THIS.this_cIdentrega, 50)) + "," + ;
                EscaparSQL(LEFT(THIS.this_cIdtransp, 15)) + "," + ;
                FormatarNumeroSQL(THIS.this_nPeracresc, 2) + "," + ;
                EscaparSQL(LEFT(THIS.this_cTpmovs, 2)) + "," + ;
                EscaparSQL(LEFT(THIS.this_cEmpfats, 3)) + "," + ;
                EscaparSQL(LEFT(THIS.this_cNumeronota, 10)) + "," + ;
                EscaparSQL(LEFT(THIS.this_cMeiotrans, 50)) + "," + ;
                EscaparSQL(LEFT(THIS.this_cChavenota, 44)) + "," + ;
                EscaparSQL(LEFT(THIS.this_cContaccs, 10)) + "," + ;
                EscaparSQL(LEFT(THIS.this_cGrupoccs, 10)) + "," + ;
                FormatarNumeroSQL(THIS.this_nNatend, 0) + "," + ;
                FormatarNumeroSQL(THIS.this_nNlivdg, 0) + "," + ;
                FormatarNumeroSQL(THIS.this_nPresente, 0) + "," + ;
                EscaparSQL(LEFT(THIS.this_cChaveexterna, 33)) + "," + ;
                EscaparSQL(LEFT(THIS.this_cEmpret, 3)) + "," + ;
                EscaparSQL(LEFT(THIS.this_cMsgpresnte, 150)) + "," + ;
                FormatarNumeroSQL(THIS.this_nCkoperpend, 0) + "," + ;
                FormatarDataSQL(THIS.this_dDtfabricacao) + "," + ;
                FormatarDataSQL(THIS.this_dDtvalidade) + "," + ;
                EscaparSQL(LEFT(THIS.this_cUsuconfs, 10)) + ")"

            IF USED("cursor_4c_Insert")
                USE IN cursor_4c_Insert
            ENDIF

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Insert")

            IF loc_nResult < 0
                MsgErro("Erro ao inserir movimento:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ELSE
                THIS.RegistrarAuditoria("INSERT")
                IF USED("cursor_4c_Insert")
                    USE IN cursor_4c_Insert
                ENDIF
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loException
            MsgErro(loException.Message, "Erro em sigmvcabBO.Inserir")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * Atualizar - Atualiza registro existente em SigMvCab (por cidchaves)
    *====================================================================
    PROTECTED PROCEDURE Atualizar()
        LOCAL loc_cSQL, loc_nResult, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            *-- Campo computado: Emps + Dopes + Numes (chave de movimentacao)
            THIS.this_cEmpdopnums = PADR(THIS.this_cEmps, 3) + PADR(THIS.this_cDopes, 20) + STR(THIS.this_nNumes, 6)

            *-- Data de alteracao
            THIS.this_dDtalts = DATETIME()

            loc_cSQL = "UPDATE SigMvCab SET" + ;
                " npedclis = " + FormatarNumeroSQL(THIS.this_nNpedclis, 0) + "," + ;
                " acres = " + FormatarNumeroSQL(THIS.this_nAcres, 4) + "," + ;
                " antecs = " + EscaparSQL(LEFT(THIS.this_cAntecs, 6)) + "," + ;
                " chksubn = " + IIF(THIS.this_lChksubn, 1, 0) + "," + ;
                " codpeds = " + FormatarNumeroSQL(THIS.this_nCodpeds, 0) + "," + ;
                " contads = " + EscaparSQL(LEFT(THIS.this_cContads, 10)) + "," + ;
                " contaos = " + EscaparSQL(LEFT(THIS.this_cContaos, 10)) + "," + ;
                " datars = " + FormatarDataSQL(THIS.this_dDatars) + "," + ;
                " datas = " + FormatarDataSQL(THIS.this_dDatas) + "," + ;
                " datatrans = " + FormatarDataSQL(THIS.this_dDatatrans) + "," + ;
                " desc2s = " + FormatarNumeroSQL(THIS.this_nDesc2s, 2) + "," + ;
                " descs = " + FormatarNumeroSQL(THIS.this_nDescs, 4) + "," + ;
                " devols = " + FormatarNumeroSQL(THIS.this_nDevols, 0) + "," + ;
                " dopes = " + EscaparSQL(LEFT(THIS.this_cDopes, 20)) + "," + ;
                " empds = " + EscaparSQL(LEFT(THIS.this_cEmpds, 3)) + "," + ;
                " emps = " + EscaparSQL(LEFT(THIS.this_cEmps, 3)) + "," + ;
                " grresps = " + EscaparSQL(LEFT(THIS.this_cGrresps, 10)) + "," + ;
                " grupods = " + EscaparSQL(LEFT(THIS.this_cGrupods, 10)) + "," + ;
                " grupoos = " + EscaparSQL(LEFT(THIS.this_cGrupoos, 10)) + "," + ;
                " grupos = " + EscaparSQL(LEFT(THIS.this_cGrupos, 10)) + "," + ;
                " grvends = " + EscaparSQL(LEFT(THIS.this_cGrvends, 10)) + "," + ;
                " iclis = " + EscaparSQL(LEFT(THIS.this_cIclis, 10)) + "," + ;
                " ifors = " + EscaparSQL(LEFT(THIS.this_cIfors, 10)) + "," + ;
                " locals = " + EscaparSQL(LEFT(THIS.this_cLocals, 10)) + "," + ;
                " lotechqs = " + FormatarNumeroSQL(THIS.this_nLotechqs, 0) + "," + ;
                " lprecos = " + EscaparSQL(LEFT(THIS.this_cLprecos, 30)) + "," + ;
                " mascnum = " + EscaparSQL(LEFT(THIS.this_cMascnum, 10)) + "," + ;
                " ncarnecs = " + EscaparSQL(LEFT(THIS.this_cNcarnecs, 11)) + "," + ;
                " nemps = " + EscaparSQL(LEFT(THIS.this_cNemps, 40)) + "," + ;
                " nops = " + FormatarNumeroSQL(THIS.this_nNops, 0) + "," + ;
                " notas = " + EscaparSQL(LEFT(THIS.this_cNotas, 6)) + "," + ;
                " nrcons = " + EscaparSQL(LEFT(THIS.this_cNrcons, 10)) + "," + ;
                " ntrans = " + FormatarNumeroSQL(THIS.this_nNtrans, 0) + "," + ;
                " numes = " + FormatarNumeroSQL(THIS.this_nNumes, 0) + "," + ;
                " numolds = " + FormatarNumeroSQL(THIS.this_nNumolds, 0) + "," + ;
                " obses = " + EscaparSQL(THIS.this_cObses) + "," + ;
                " opers = " + EscaparSQL(LEFT(THIS.this_cOpers, 1)) + "," + ;
                " prazoents = " + FormatarDataSQL(THIS.this_dPrazoents) + "," + ;
                " resps = " + EscaparSQL(LEFT(THIS.this_cResps, 10)) + "," + ;
                " tabds = " + EscaparSQL(LEFT(THIS.this_cTabds, 10)) + "," + ;
                " tpfats = " + EscaparSQL(LEFT(THIS.this_cTpfats, 3)) + "," + ;
                " transps = " + IIF(THIS.this_lTransps, 1, 0) + "," + ;
                " usuals = " + EscaparSQL(LEFT(THIS.this_cUsuals, 10)) + "," + ;
                " usuars = " + EscaparSQL(LEFT(THIS.this_cUsuars, 10)) + "," + ;
                " usulibs = " + EscaparSQL(LEFT(THIS.this_cUsulibs, 10)) + "," + ;
                " valacres = " + FormatarNumeroSQL(THIS.this_nValacres, 2) + "," + ;
                " valdes2s = " + FormatarNumeroSQL(THIS.this_nValdes2s, 2) + "," + ;
                " valdescs = " + FormatarNumeroSQL(THIS.this_nValdescs, 2) + "," + ;
                " valdevs = " + FormatarNumeroSQL(THIS.this_nValdevs, 2) + "," + ;
                " valencs = " + FormatarNumeroSQL(THIS.this_nValencs, 2) + "," + ;
                " valinis = " + FormatarNumeroSQL(THIS.this_nValinis, 2) + "," + ;
                " valos = " + FormatarNumeroSQL(THIS.this_nValos, 2) + "," + ;
                " valservs = " + FormatarNumeroSQL(THIS.this_nValservs, 2) + "," + ;
                " valvars = " + FormatarNumeroSQL(THIS.this_nValvars, 2) + "," + ;
                " vars = " + FormatarNumeroSQL(THIS.this_nVars, 4) + "," + ;
                " vends = " + EscaparSQL(LEFT(THIS.this_cVends, 10)) + "," + ;
                " cotusus = " + EscaparSQL(LEFT(THIS.this_cCotusus, 10)) + "," + ;
                " dtemis = " + FormatarDataSQL(THIS.this_dDtemis) + "," + ;
                " espes = " + EscaparSQL(LEFT(THIS.this_cEspes, 10)) + "," + ;
                " pbrus = " + FormatarNumeroSQL(THIS.this_nPbrus, 3) + "," + ;
                " pliqs = " + FormatarNumeroSQL(THIS.this_nPliqs, 3) + "," + ;
                " qtdes = " + FormatarNumeroSQL(THIS.this_nQtdes, 0) + "," + ;
                " lcancelas = " + IIF(THIS.this_lLcancelas, 1, 0) + "," + ;
                " cofs = " + IIF(THIS.this_lCofs, 1, 0) + "," + ;
                " livros = " + IIF(THIS.this_lLivros, 1, 0) + "," + ;
                " dttransms = " + FormatarDataSQL(THIS.this_dDttransms) + "," + ;
                " chkbxparcs = " + IIF(THIS.this_lChkbxparcs, 1, 0) + "," + ;
                " ecfs = " + EscaparSQL(LEFT(THIS.this_cEcfs, 7)) + "," + ;
                " codobs = " + FormatarNumeroSQL(THIS.this_nCodobs, 0) + "," + ;
                " dgopes = " + EscaparSQL(LEFT(THIS.this_cDgopes, 20)) + "," + ;
                " dtfechas = " + FormatarDataSQL(THIS.this_dDtfechas) + "," + ;
                " trfisicos = " + FormatarNumeroSQL(THIS.this_nTrfisicos, 0) + "," + ;
                " utilizados = " + FormatarNumeroSQL(THIS.this_nUtilizados, 0) + "," + ;
                " valndevs = " + FormatarNumeroSQL(THIS.this_nValndevs, 2) + "," + ;
                " valobxs = " + FormatarNumeroSQL(THIS.this_nValobxs, 2) + "," + ;
                " noforms = " + EscaparSQL(LEFT(THIS.this_cNoforms, 10)) + "," + ;
                " auditors = " + EscaparSQL(LEFT(THIS.this_cAuditors, 10)) + "," + ;
                " dtaudits = " + FormatarDataSQL(THIS.this_dDtaudits) + "," + ;
                " dtalts = " + FormatarDataSQL(THIS.this_dDtalts) + "," + ;
                " empdopnums = " + EscaparSQL(LEFT(THIS.this_cEmpdopnums, 29)) + "," + ;
                " dtbaixas = " + FormatarDataSQL(THIS.this_dDtbaixas) + "," + ;
                " dtrecs = " + FormatarDataSQL(THIS.this_dDtrecs) + "," + ;
                " empgopnums = " + EscaparSQL(LEFT(THIS.this_cEmpgopnums, 29)) + "," + ;
                " contaes = " + EscaparSQL(LEFT(THIS.this_cContaes, 10)) + "," + ;
                " dtagends = " + FormatarDataSQL(THIS.this_dDtagends) + "," + ;
                " localents = " + FormatarNumeroSQL(THIS.this_nLocalents, 0) + "," + ;
                " localizas = " + EscaparSQL(LEFT(THIS.this_cLocalizas, 6)) + "," + ;
                " chkpagos = " + IIF(THIS.this_lChkpagos, 1, 0) + "," + ;
                " chkpgs = " + IIF(THIS.this_lChkpgs, 1, 0) + "," + ;
                " codtrans = " + EscaparSQL(LEFT(THIS.this_cCodtrans, 10)) + "," + ;
                " dtbxestqs = " + FormatarDataSQL(THIS.this_dDtbxestqs) + "," + ;
                " empdnbxs = " + EscaparSQL(LEFT(THIS.this_cEmpdnbxs, 29)) + "," + ;
                " empdncrds = " + EscaparSQL(LEFT(THIS.this_cEmpdncrds, 29)) + "," + ;
                " obsagends = " + EscaparSQL(LEFT(THIS.this_cObsagends, 15)) + "," + ;
                " operadors = " + EscaparSQL(LEFT(THIS.this_cOperadors, 10)) + "," + ;
                " vcompensas = " + FormatarNumeroSQL(THIS.this_nVcompensas, 2) + "," + ;
                " dtrtrans = " + FormatarDataSQL(THIS.this_dDtrtrans) + "," + ;
                " motdscs = " + EscaparSQL(LEFT(THIS.this_cMotdscs, 10)) + "," + ;
                " ndeclaras = " + FormatarNumeroSQL(THIS.this_nNdeclaras, 0) + "," + ;
                " numbalds = " + FormatarNumeroSQL(THIS.this_nNumbalds, 0) + "," + ;
                " numbals = " + FormatarNumeroSQL(THIS.this_nNumbals, 0) + "," + ;
                " priors = " + FormatarNumeroSQL(THIS.this_nPriors, 0) + "," + ;
                " procbals = " + IIF(THIS.this_lProcbals, 1, 0) + "," + ;
                " procdbal = " + IIF(THIS.this_lProcdbal, 1, 0) + "," + ;
                " protats = " + FormatarNumeroSQL(THIS.this_nProtats, 0) + "," + ;
                " usupagos = " + EscaparSQL(LEFT(THIS.this_cUsupagos, 10)) + "," + ;
                " ultgrvs = " + EscaparSQL(LEFT(THIS.this_cUltgrvs, 40)) + "," + ;
                " moeits = " + EscaparSQL(LEFT(THIS.this_cMoeits, 3)) + "," + ;
                " dtagendfs = " + FormatarDataSQL(THIS.this_dDtagendfs) + "," + ;
                " rnops = " + FormatarNumeroSQL(THIS.this_nRnops, 0) + "," + ;
                " impress = " + FormatarNumeroSQL(THIS.this_nImpress, 0) + "," + ;
                " przclis = " + FormatarDataSQL(THIS.this_dPrzclis) + "," + ;
                " pstatus = " + EscaparSQL(LEFT(THIS.this_cPstatus, 1)) + "," + ;
                " valvarps = " + FormatarNumeroSQL(THIS.this_nValvarps, 2) + "," + ;
                " cifccfs = " + EscaparSQL(LEFT(THIS.this_cCifccfs, 6)) + "," + ;
                " cupfis = " + FormatarNumeroSQL(THIS.this_nCupfis, 0) + "," + ;
                " idconta = " + FormatarNumeroSQL(THIS.this_nIdconta, 0) + "," + ;
                " ncupoms = " + EscaparSQL(LEFT(THIS.this_cNcupoms, 6)) + "," + ;
                " status = " + EscaparSQL(LEFT(THIS.this_cStatus, 3)) + "," + ;
                " valtrans = " + FormatarNumeroSQL(THIS.this_nValtrans, 2) + "," + ;
                " impcpfs = " + FormatarNumeroSQL(THIS.this_nImpcpfs, 0) + "," + ;
                " ccfgnfs = " + EscaparSQL(LEFT(THIS.this_cCcfgnfs, 6)) + "," + ;
                " fpubls = " + EscaparSQL(LEFT(THIS.this_cFpubls, 3)) + "," + ;
                " jobs = " + EscaparSQL(LEFT(THIS.this_cJobs, 10)) + "," + ;
                " ptax1s = " + FormatarNumeroSQL(THIS.this_nPtax1s, 2) + "," + ;
                " ptax2s = " + FormatarNumeroSQL(THIS.this_nPtax2s, 2) + "," + ;
                " ptax3s = " + FormatarNumeroSQL(THIS.this_nPtax3s, 2) + "," + ;
                " obscabmovs = " + EscaparSQL(LEFT(THIS.this_cObscabmovs, 40)) + "," + ;
                " codobs2 = " + EscaparSQL(LEFT(THIS.this_cCodobs2, 60)) + "," + ;
                " valserfix = " + FormatarNumeroSQL(THIS.this_nValserfix, 2) + "," + ;
                " perserfix = " + FormatarNumeroSQL(THIS.this_nPerserfix, 2) + "," + ;
                " valosfix = " + FormatarNumeroSQL(THIS.this_nValosfix, 2) + "," + ;
                " chkencerra = " + FormatarNumeroSQL(THIS.this_nChkencerra, 0) + "," + ;
                " perdesc = " + FormatarNumeroSQL(THIS.this_nPerdesc, 2) + "," + ;
                " compet = " + EscaparSQL(LEFT(THIS.this_cCompet, 10)) + "," + ;
                " pedidoweb = " + EscaparSQL(LEFT(THIS.this_cPedidoweb, 50)) + "," + ;
                " cdrastreio = " + EscaparSQL(LEFT(THIS.this_cCdrastreio, 20)) + "," + ;
                " identrega = " + EscaparSQL(LEFT(THIS.this_cIdentrega, 50)) + "," + ;
                " idtransp = " + EscaparSQL(LEFT(THIS.this_cIdtransp, 15)) + "," + ;
                " peracresc = " + FormatarNumeroSQL(THIS.this_nPeracresc, 2) + "," + ;
                " tpmovs = " + EscaparSQL(LEFT(THIS.this_cTpmovs, 2)) + "," + ;
                " empfats = " + EscaparSQL(LEFT(THIS.this_cEmpfats, 3)) + "," + ;
                " numeronota = " + EscaparSQL(LEFT(THIS.this_cNumeronota, 10)) + "," + ;
                " meiotrans = " + EscaparSQL(LEFT(THIS.this_cMeiotrans, 50)) + "," + ;
                " chavenota = " + EscaparSQL(LEFT(THIS.this_cChavenota, 44)) + "," + ;
                " contaccs = " + EscaparSQL(LEFT(THIS.this_cContaccs, 10)) + "," + ;
                " grupoccs = " + EscaparSQL(LEFT(THIS.this_cGrupoccs, 10)) + "," + ;
                " natend = " + FormatarNumeroSQL(THIS.this_nNatend, 0) + "," + ;
                " nlivdg = " + FormatarNumeroSQL(THIS.this_nNlivdg, 0) + "," + ;
                " presente = " + FormatarNumeroSQL(THIS.this_nPresente, 0) + "," + ;
                " chaveexterna = " + EscaparSQL(LEFT(THIS.this_cChaveexterna, 33)) + "," + ;
                " empret = " + EscaparSQL(LEFT(THIS.this_cEmpret, 3)) + "," + ;
                " msgpresnte = " + EscaparSQL(LEFT(THIS.this_cMsgpresnte, 150)) + "," + ;
                " ckoperpend = " + FormatarNumeroSQL(THIS.this_nCkoperpend, 0) + "," + ;
                " dtfabricacao = " + FormatarDataSQL(THIS.this_dDtfabricacao) + "," + ;
                " dtvalidade = " + FormatarDataSQL(THIS.this_dDtvalidade) + "," + ;
                " usuconfs = " + EscaparSQL(LEFT(THIS.this_cUsuconfs, 10)) + ;
                " WHERE cidchaves = " + EscaparSQL(THIS.this_cCidchaves)

            IF USED("cursor_4c_Update")
                USE IN cursor_4c_Update
            ENDIF

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Update")

            IF loc_nResult < 0
                MsgErro("Erro ao atualizar movimento:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ELSE
                THIS.RegistrarAuditoria("UPDATE")
                IF USED("cursor_4c_Update")
                    USE IN cursor_4c_Update
                ENDIF
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loException
            MsgErro(loException.Message, "Erro em sigmvcabBO.Atualizar")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * ExecutarExclusao - Exclui registro de SigMvCab (por cidchaves)
    *====================================================================
    PROTECTED PROCEDURE ExecutarExclusao()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "DELETE FROM SigMvCab WHERE cidchaves = " + EscaparSQL(THIS.this_cCidchaves)
            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("DELETE")
                loc_lSucesso = .T.
            ELSE
                MostrarErro("Erro ao excluir movimenta" + CHR(231) + CHR(227) + "o:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loException
            MostrarErro("Erro ao excluir:" + CHR(13) + loException.Message, "sigmvcabBO.ExecutarExclusao")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * Buscar - Lista movimentos para o Grid da Page1 (cursor_4c_Dados)
    * Colunas: Emps, Dopes, Numes, Datas, ContaOs, ContaDs, Valos, cidchaves
    * TOP 300 ORDER BY Datas DESC: SigMvCab acumula todo o historico de
    * movimentacao (tabela de milhoes de linhas); sem os filtros de
    * periodo/empresa da tela legada (fase futura), limitar o volume
    * evita carregar a tabela inteira no Grid. Filtro extra (ex.: busca
    * por cidchaves) se sobrepoe ao TOP 300 normalmente.
    *====================================================================
    PROCEDURE Buscar(par_cFiltro)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "SELECT TOP 300 Emps, Dopes, Numes, Datas, ContaOs, ContaDs," + ;
                " Valos, cidchaves FROM SigMvCab"

            IF VARTYPE(par_cFiltro) = "C" AND !EMPTY(par_cFiltro)
                loc_cSQL = loc_cSQL + " WHERE " + par_cFiltro
            ENDIF

            loc_cSQL = loc_cSQL + " ORDER BY Datas DESC"

            IF USED("cursor_4c_Dados")
                USE IN cursor_4c_Dados
            ENDIF

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")

            IF loc_nResultado >= 0
                loc_lSucesso = .T.
            ELSE
                MostrarErro("Erro ao buscar movimenta" + CHR(231) + CHR(245) + "es:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loException
            MostrarErro("Erro ao buscar:" + CHR(13) + loException.Message, "sigmvcabBO.Buscar")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * CarregarPorCodigo - Carrega registro pela chave primaria (cidchaves)
    *====================================================================
    PROCEDURE CarregarPorCodigo(par_cCodigo)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "SELECT * FROM SigMvCab WHERE cidchaves = " + EscaparSQL(par_cCodigo)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")

            IF loc_nResultado >= 0
                IF RECCOUNT("cursor_4c_Carrega") > 0
                    loc_lSucesso = THIS.CarregarDoCursor("cursor_4c_Carrega")
                    THIS.this_lNovoRegistro = .F.
                ELSE
                    MsgAviso("Movimenta" + CHR(231) + CHR(227) + "o n" + CHR(227) + "o encontrada!")
                ENDIF

                IF USED("cursor_4c_Carrega")
                    USE IN cursor_4c_Carrega
                ENDIF
            ELSE
                MostrarErro("Erro ao carregar movimenta" + CHR(231) + CHR(227) + "o:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loException
            MostrarErro("Erro ao carregar:" + CHR(13) + loException.Message, "sigmvcabBO.CarregarPorCodigo")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

ENDDEFINE


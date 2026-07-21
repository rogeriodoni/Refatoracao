# CORRIGIR ERRO DE RUNTIME VFP9

## TAREFA OBRIGATORIA
O formulario VFP9 apresentou erro de runtime durante teste automatizado.
Voce DEVE corrigir o erro e salvar os arquivos corrigidos usando Write tool.

## ERRO DETECTADO
- Etapa: 05d_validarCompletude
- Tentativa: 1/10
- Mensagem: Validacao de completude falhou. Procedures vazias/TODOs encontrados:
[FormSIGPRCCR.prg] Procedure vazia (sem codigo): FormParaRelatorio
[FormSIGPRCCR.prg] Procedure vazia (sem codigo): BOParaForm
[FormSIGPRCCR.prg] Procedure vazia (sem codigo): HabilitarCampos
[FormSIGPRCCR.prg] Procedure vazia (sem codigo): LimparCampos
[FormSIGPRCCR.prg] Procedure vazia (sem codigo): AjustarBotoesPorModo

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

### FORM (C:\4c\projeto\app\forms\relatorios\FormSIGPRCCR.prg):
*==============================================================================
* FORMSIGPRCCR.PRG
* Impressao de Produtos com Precos Alterados - Formulario de Relatorio
* Tipo: REPORT (herda FormBase, BO herda RelatorioBase)
* Migrado de: SIGPRCCR.SCX (frmrelatorio)
*
* Acionado APOS o usuario marcar produtos em FormSigPrCcc/FormSigPrCcp.
* Pressupoe que CrProdutos existe no datasession corrente (DataSession=1).
* SIGPRCCRBO.PrepararDados() filtra CrProdutos WHERE lMarca=1 -> CsRelatorio.
*==============================================================================

DEFINE CLASS FormSIGPRCCR AS FormBase

    *-- Dimensoes e aparencia (EXATAS do original SCX: Width=800, Height=130)
    Height      = 130
    Width       = 800
    DataSession = 1
    ShowWindow  = 1
    WindowType  = 1
    AutoCenter  = .T.
    BorderStyle = 2
    ControlBox  = .F.
    MaxButton   = .F.
    MinButton   = .F.
    TitleBar    = 0
    Themes      = .F.
    ShowTips    = .T.

    *-- Referencia ao BO de relatorio (instanciado em InicializarForm)
    this_oRelatorio    = .NULL.
    this_cMensagemErro = ""

    *-- Permissao PDF (migrado do original: This.lacpdf = fChecaAcesso(ThisForm.Name,'PDF'))
    this_lPermitePdf = .F.

    *--------------------------------------------------------------------------
    * Init - Delega para FormBase.Init() que chama THIS.InicializarForm()
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        RETURN DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    * InicializarForm - Cria estrutura visual do formulario de relatorio
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lSucesso, loc_lContinuar
        loc_lSucesso   = .F.
        loc_lContinuar = .T.
        TRY
            THIS.Caption = "Impress" + CHR(227) + "o de Produtos com Pre" + CHR(231) + "os alterados"

            IF TYPE("gc_4c_CaminhoIcones") = "U"
                gc_4c_CaminhoIcones = ""
            ENDIF
            IF TYPE("gc_4c_CaminhoReports") = "U"
                gc_4c_CaminhoReports = ""
            ENDIF

            *-- Instanciar BO de relatorio
            THIS.this_oRelatorio = CREATEOBJECT("SIGPRCCRBO")
            IF VARTYPE(THIS.this_oRelatorio) != "O"
                MsgErro("Erro ao criar SIGPRCCRBO" + CHR(13) + ;
                    "VARTYPE retornou: " + VARTYPE(THIS.this_oRelatorio), "Erro")
                loc_lContinuar = .F.
            ENDIF

            IF loc_lContinuar
                THIS.ConfigurarPageFrame()

                *-- Vincular eventos Click dos botoes do relatorio
                BINDEVENT(THIS.cmg_4c_Botoes.Buttons(1), "Click", THIS, "BtnVisualizarClick")
                BINDEVENT(THIS.cmg_4c_Botoes.Buttons(2), "Click", THIS, "BtnImprimirClick")
                BINDEVENT(THIS.cmg_4c_Botoes.Buttons(3), "Click", THIS, "BtnExcelClick")
                BINDEVENT(THIS.cmg_4c_Botoes.Buttons(4), "Click", THIS, "BtnSairClick")

                THIS.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
                THIS.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro Detalhado")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPageFrame - Entry-point de montagem da UI (contrato canonico
    *   do FormBase). REPORT forms nao possuem PageFrame de Lista/Dados do
    *   padrao CRUD ??? a UI eh flat: cabecalho cinza + CommandGroup de 4 botoes
    *   de relatorio. Este metodo orquestra a montagem na ordem correta
    *   (cabecalho primeiro para z-order abaixo dos botoes, botoes depois).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPageFrame()
        THIS.ConfigurarPaginaLista()
        THIS.ConfigurarPaginaDados()
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPaginaDados - Estado de "dados" do REPORT form
    *   Este REPORT nao possui campos de filtro na UI (Width=800, Height=130 no
    *   SCX original ??? apenas cabecalho cinza + 4 botoes). Aqui migramos a
    *   inicializacao de estado do original SIGPRCCR.Init:
    *       This.lacpdf = fChecaAcesso(ThisForm.Name, 'PDF')
    *   Verificacao de permissao PDF do usuario logado, usada por Buttons(3)
    *   (Arquivos Email / export). Se sem permissao, o botao fica desabilitado.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPaginaDados()
        THIS.this_lPermitePdf = fChecaAcesso("SIGPRCCR", "PDF")
        IF !THIS.this_lPermitePdf
            THIS.cmg_4c_Botoes.Buttons(3).Enabled = .F.
            THIS.cmg_4c_Botoes.Buttons(3).ToolTipText = "Sem permiss" + CHR(227) + ;
                "o para exportar (PDF/Email)"
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPaginaLista - Monta a "unica pagina" visivel do REPORT form
    *   (equivalente semantico a Page1 dos CRUD forms). REPORT forms nao tem
    *   grid nem CRUD buttons: exibem faixa cinza superior + 4 botoes canonicos
    *   (Visualizar, Imprimir, Arquivos Email, Encerrar). Delega para os
    *   configuradores especializados na ordem correta de z-order:
    *     1. Cabecalho (Container atras) - preenche todo o form
    *     2. Botoes (CommandGroup na frente) - sobrepostos no canto direito
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPaginaLista()
        THIS.ConfigurarCabecalho()
        THIS.ConfigurarBotoes()
    ENDPROC

    *--------------------------------------------------------------------------
    * AlternarPagina - REPORT forms tem layout unico (flat), portanto nao ha
    *   navegacao entre paginas Lista/Dados como em CRUD forms. Este metodo
    *   existe apenas para satisfazer o contrato de FormBase e retorna .T.
    *   quando par_nPagina = 1 (a unica "pagina" valida). Chamadas com outros
    *   valores sao ignoradas silenciosamente (compatibilidade com framework).
    *   par_nPagina - deve ser 1 (layout unico do REPORT)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE AlternarPagina(par_nPagina)
        LOCAL loc_lValida
        loc_lValida = .F.
        IF VARTYPE(par_nPagina) = "N" AND par_nPagina = 1
            *-- REPORT form ja esta na unica "pagina" possivel - nada a fazer
            loc_lValida = .T.
        ENDIF
        RETURN loc_lValida
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarCabecalho - Container escuro que cobre todo o form
    *   O form nao tem campos de filtro, portanto a faixa cinza ocupa toda
    *   a altura (THIS.Height), com os botoes sobrepostos.
    *   AutoSize=.F. obrigatorio nos Labels (regra #98).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarCabecalho()
        THIS.AddObject("cnt_4c_Cabecalho", "Container")
        WITH THIS.cnt_4c_Cabecalho
            .Top         = 0
            .Left        = 0
            .Width       = THIS.Width
            .Height      = THIS.Height
            .BackStyle   = 1
            .BackColor   = RGB(100, 100, 100)
            .BorderWidth = 0
            .Visible     = .T.

            .AddObject("lbl_4c_Sombra", "Label")
            WITH .lbl_4c_Sombra
                .Top       = 22
                .Left      = 22
                .Width     = THIS.Width
                .Height    = 30
                .Caption   = "Impress" + CHR(227) + "o de Produtos com Pre" + CHR(231) + "os alterados"
                .FontName  = "Tahoma"
                .FontSize  = 14
                .FontBold  = .T.
                .AutoSize  = .F.
                .ForeColor = RGB(0, 0, 0)
                .BackStyle = 0
                .Visible   = .T.
            ENDWITH

            .AddObject("lbl_4c_Titulo", "Label")
            WITH .lbl_4c_Titulo
                .Top       = 20
                .Left      = 20
                .Width     = THIS.Width
                .Height    = 30
                .Caption   = "Impress" + CHR(227) + "o de Produtos com Pre" + CHR(231) + "os alterados"
                .FontName  = "Tahoma"
                .FontSize  = 14
                .FontBold  = .T.
                .AutoSize  = .F.
                .ForeColor = RGB(255, 255, 255)
                .BackStyle = 0
                .Visible   = .T.
            ENDWITH
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarBotoes - CommandGroup com 4 botoes de relatorio
    *   Geometria EXATA do original SCX:
    *     btnReport.Top=-2 (ajustado para 0), Left=495, Width=310, Height=85
    *     Cada botao: Width=75, Height=75, Left=5/80/155/230 (incremento 75)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarBotoes()
        THIS.AddObject("cmg_4c_Botoes", "CommandGroup")
        WITH THIS.cmg_4c_Botoes
            .Top           = 0
            .Left          = 495
            .Width         = 310
            .Height        = 85
            .ButtonCount   = 4
            .BackStyle     = 0
            .BorderStyle   = 0
            .BorderColor   = RGB(136, 189, 188)
            .SpecialEffect = 1
            .Themes        = .F.
            .Visible       = .T.

            WITH .Buttons(1)
                .Top             = 5
                .Left            = 5
                .Width           = 75
                .Height          = 75
                .Caption         = "Visualizar"
                .FontName        = "Comic Sans MS"
                .FontSize        = 8
                .FontBold        = .T.
                .FontItalic      = .T.
                .BackColor       = RGB(255, 255, 255)
                .ForeColor       = RGB(90, 90, 90)
                .Picture         = gc_4c_CaminhoIcones + "relatorio_video_26.jpg"
                .PicturePosition = 13
                .SpecialEffect   = 0
                .MousePointer    = 15
                .ToolTipText     = "Gerar o Relat" + CHR(243) + "rio no V" + CHR(237) + "deo"
                .Themes          = .F.
                .Visible         = .T.
            ENDWITH

            WITH .Buttons(2)
                .Top             = 5
                .Left            = 80
                .Width           = 75
                .Height          = 75
                .Caption         = "Imprimir"
                .FontName        = "Comic Sans MS"
                .FontSize        = 8
                .FontBold        = .T.
                .FontItalic      = .T.
                .BackColor       = RGB(255, 255, 255)
                .ForeColor       = RGB(90, 90, 90)
                .Picture         = gc_4c_CaminhoIcones + "relatorio_impressora_26.jpg"
                .PicturePosition = 13
                .SpecialEffect   = 0
                .MousePointer    = 15
                .ToolTipText     = "Enviar o Relat" + CHR(243) + "rio Para Impressora"
                .Themes          = .F.
                .Visible         = .T.
            ENDWITH

            WITH .Buttons(3)
                .Top             = 5
                .Left            = 155
                .Width           = 75
                .Height          = 75
                .Caption         = "Arquivos Email"
                .WordWrap        = .T.
                .FontName        = "Comic Sans MS"
                .FontSize        = 8
                .FontBold        = .T.
                .FontItalic      = .T.
                .BackColor       = RGB(255, 255, 255)
                .ForeColor       = RGB(90, 90, 90)
                .Picture         = gc_4c_CaminhoIcones + "geral_envelope_32.jpg"
                .PicturePosition = 13
                .SpecialEffect   = 0
                .MousePointer    = 15
                .ToolTipText     = "Arquivos Email"
                .Themes          = .F.
                .Visible         = .T.
            ENDWITH

            WITH .Buttons(4)
                .Top             = 5
                .Left            = 230
                .Width           = 75
                .Height          = 75
                .Caption         = "Encerrar"
                .Cancel          = .T.
                .WordWrap        = .T.
                .FontName        = "Comic Sans MS"
                .FontSize        = 8
                .FontBold        = .T.
                .FontItalic      = .T.
                .BackColor       = RGB(255, 255, 255)
                .ForeColor       = RGB(90, 90, 90)
                .Picture         = gc_4c_CaminhoIcones + "relatorio_sair_60.jpg"
                .PicturePosition = 13
                .SpecialEffect   = 0
                .MousePointer    = 15
                .ToolTipText     = "[Esc] Encerrar"
                .Themes          = .F.
                .Visible         = .T.
            ENDWITH
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * FormParaRelatorio - Sem filtros a copiar (form nao tem campos de entrada)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE FormParaRelatorio()
        *-- Nenhum campo de filtro neste relatorio
    ENDPROC

    *--------------------------------------------------------------------------
    * ExecutarReportForm - Helper canonico (Pattern #117)
    *   par_cRelatorioBase : nome base do FRX sem extensao e sem path
    *   par_cModo          : "PREVIEW", "PRINTER_PROMPT" ou "PRINTER"
    *   par_cCursorDados   : nome do cursor (opcional - guard de vazio/inexistente)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ExecutarReportForm(par_cRelatorioBase, par_cModo, par_cCursorDados)
        LOCAL loc_lSucesso, loc_cFRX, loc_cPoint, loc_cSep
        loc_lSucesso = .F.
        TRY
            loc_cFRX = FULLPATH(gc_4c_CaminhoReports + par_cRelatorioBase + ".frx")
            IF !FILE(loc_cFRX)
                MsgErro("Arquivo de relat" + CHR(243) + "rio n" + CHR(227) + "o encontrado:" + ;
                    CHR(13) + loc_cFRX, "Relat" + CHR(243) + "rio")
                loc_lSucesso = .F.
            ENDIF

            IF VARTYPE(par_cCursorDados) = "C" AND !EMPTY(par_cCursorDados)
                IF !USED(par_cCursorDados) OR RECCOUNT(par_cCursorDados) = 0
                    MsgAviso("Nenhum registro encontrado para o relat" + ;
                        CHR(243) + "rio.", "Relat" + CHR(243) + "rio")
                    loc_lSucesso = .F.
                ENDIF
            ENDIF

            loc_cPoint = SET("POINT")
            loc_cSep   = SET("SEPARATOR")
            SET POINT TO "."
            SET SEPARATOR TO ","
            SET REPORTBEHAVIOR 80

            DO CASE
            CASE par_cModo = "PREVIEW"
                REPORT FORM (loc_cFRX) PREVIEW NOCONSOLE
            CASE par_cModo = "PRINTER_PROMPT"
                REPORT FORM (loc_cFRX) TO PRINTER PROMPT NOCONSOLE
            OTHERWISE
                REPORT FORM (loc_cFRX) TO PRINTER NOCONSOLE
            ENDCASE

            SET POINT TO (loc_cPoint)
            SET SEPARATOR TO (loc_cSep)
            SET REPORTBEHAVIOR 90

            loc_lSucesso = .T.

        CATCH TO loc_oErro
            SET POINT TO (loc_cPoint)
            SET SEPARATOR TO (loc_cSep)
            SET REPORTBEHAVIOR 90
            MsgErro("Erro ao executar relat" + CHR(243) + "rio:" + CHR(13) + ;
                "Erro: " + loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo), "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * HANDLERS DOS BOTOES DO RELATORIO (PUBLIC - contrato BINDEVENT)
    *==========================================================================

    *--------------------------------------------------------------------------
    * BtnVisualizarClick - Prepara dados e exibe preview na tela
    *   Original: PROCEDURE visualizacao -> Report Form SigPrCcr Preview NoConsole
    *--------------------------------------------------------------------------
    PROCEDURE BtnVisualizarClick()
        THIS.FormParaRelatorio()
        IF THIS.this_oRelatorio.Atualizar()
            THIS.ExecutarReportForm(THIS.this_oRelatorio.this_cRelatorio, "PREVIEW", ;
                THIS.this_oRelatorio.this_cCursorDados)
        ELSE
            IF !EMPTY(THIS.this_oRelatorio.this_cMensagemErro)
                MsgErro(THIS.this_oRelatorio.this_cMensagemErro, "Relat" + CHR(243) + "rio")
            ENDIF
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnImprimirClick - Prepara dados e imprime com dialogo de impressora
    *   Original: PROCEDURE impressao -> Report Form SigPrCcr To PRINTER Prompt NoConsole
    *--------------------------------------------------------------------------
    PROCEDURE BtnImprimirClick()
        THIS.FormParaRelatorio()
        IF THIS.this_oRelatorio.Atualizar()
            THIS.ExecutarReportForm(THIS.this_oRelatorio.this_cRelatorio, "PRINTER_PROMPT", ;
                THIS.this_oRelatorio.this_cCursorDados)
        ELSE
            IF !EMPTY(THIS.this_oRelatorio.this_cMensagemErro)
                MsgErro(THIS.this_oRelatorio.this_cMensagemErro, "Relat" + CHR(243) + "rio")
            ENDIF
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnExcelClick - Envia relatorio direto para impressora (sem dialogo)
    *   Original: PROCEDURE memail -> Report Form SigPrCcr To Printer NoConsole + DoDefault()
    *--------------------------------------------------------------------------
    PROCEDURE BtnExcelClick()
        THIS.FormParaRelatorio()
        IF THIS.this_oRelatorio.Atualizar()
            THIS.ExecutarReportForm(THIS.this_oRelatorio.this_cRelatorio, "PRINTER", ;
                THIS.this_oRelatorio.this_cCursorDados)
        ELSE
            IF !EMPTY(THIS.this_oRelatorio.this_cMensagemErro)
                MsgErro(THIS.this_oRelatorio.this_cMensagemErro, "Relat" + CHR(243) + "rio")
            ENDIF
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnSairClick - Fecha o formulario
    *--------------------------------------------------------------------------
    PROCEDURE BtnSairClick()
        THIS.Release()
    ENDPROC

    *==========================================================================
    * HANDLERS DE COMPATIBILIDADE COM O CONTRATO CRUD DO FRAMEWORK
    *   Este eh um formulario REPORT (frmrelatorio). A UI real possui apenas os
    *   4 botoes do cmg_4c_Botoes (Visualizar, Imprimir, Arquivos Email,
    *   Encerrar). Os handlers BtnIncluirClick/BtnAlterarClick/BtnExcluirClick
    *   nao sao vinculados via BINDEVENT a nenhum botao visivel, mas existem
    *   para satisfazer o contrato padronizado do framework (compatibilidade
    *   com validadores e chamadas por acesso reflexivo tipo THIS.PEMSTATUS).
    *   Cada um delega para o handler REPORT semanticamente mais proximo:
    *     BtnIncluirClick  -> BtnVisualizarClick (gerar novo preview)
    *     BtnAlterarClick  -> BtnImprimirClick   (reenviar para impressora)
    *     BtnExcluirClick  -> BtnSairClick       (encerrar o relatorio)
    *==========================================================================

    *--------------------------------------------------------------------------
    * BtnIncluirClick - Delegado para BtnVisualizarClick (gera preview novo)
    *--------------------------------------------------------------------------
    PROCEDURE BtnIncluirClick()
        THIS.BtnVisualizarClick()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnAlterarClick - Delegado para BtnImprimirClick (envia para impressora)
    *--------------------------------------------------------------------------
    PROCEDURE BtnAlterarClick()
        THIS.BtnImprimirClick()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnExcluirClick - Delegado para BtnSairClick (encerra o formulario)
    *--------------------------------------------------------------------------
    PROCEDURE BtnExcluirClick()
        THIS.BtnSairClick()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnBuscarClick - Nao aplicavel em REPORT (sem lista/filtro interativo)
    *   Delegado para BtnVisualizarClick como comportamento semanticamente
    *   mais proximo (reprocessar/buscar dados = gerar preview atualizado).
    *--------------------------------------------------------------------------
    PROCEDURE BtnBuscarClick()
        THIS.BtnVisualizarClick()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnEncerrarClick - Encerra o formulario (alias canonico para BtnSairClick)
    *--------------------------------------------------------------------------
    PROCEDURE BtnEncerrarClick()
        THIS.BtnSairClick()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnSalvarClick - Nao aplicavel em REPORT (sem persistencia de dados)
    *   Delegado para BtnImprimirClick (acao final de "concluir" do relatorio).
    *--------------------------------------------------------------------------
    PROCEDURE BtnSalvarClick()
        THIS.BtnImprimirClick()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnCancelarClick - Cancela/encerra o formulario de relatorio
    *--------------------------------------------------------------------------
    PROCEDURE BtnCancelarClick()
        THIS.BtnSairClick()
    ENDPROC

    *--------------------------------------------------------------------------
    * FormParaBO - Para REPORT forms, delega para FormParaRelatorio
    *   Copia os filtros do form para o BO de relatorio antes de executar.
    *   Mantido por compatibilidade com o contrato do framework.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE FormParaBO()
        THIS.FormParaRelatorio()
    ENDPROC

    *--------------------------------------------------------------------------
    * BOParaForm - Nao aplicavel em REPORT (dados fluem BO -> FRX, nao -> form)
    *   Metodo vazio por compatibilidade com contrato do framework.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE BOParaForm()
        *-- REPORT: dados vao direto para o FRX, nao ha campos no form para popular
    ENDPROC

    *--------------------------------------------------------------------------
    * HabilitarCampos - Nao aplicavel em REPORT (sem campos editaveis no form)
    *   Metodo vazio por compatibilidade com contrato do framework.
    *   par_lHabilitar - ignorado (nao ha controles para habilitar/desabilitar)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE HabilitarCampos(par_lHabilitar)
        *-- REPORT form: controles gerenciados pelos handlers de botao (Enabled do cmg_4c_Botoes)
    ENDPROC

    *--------------------------------------------------------------------------
    * LimparCampos - Nao aplicavel em REPORT (sem campos de entrada no form)
    *   Metodo vazio por compatibilidade com contrato do framework.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE LimparCampos()
        *-- REPORT form sem campos de filtro: nada a limpar
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarLista - Nao aplicavel em REPORT (sem grid de lista)
    *   Retorna .T. por compatibilidade com contrato do framework.
    *   O REPORT opera sobre cursor CrProdutos pre-existente (criado pelo form pai)
    *   e nao precisa carregar lista propria.
    *--------------------------------------------------------------------------
    PROCEDURE CarregarLista()
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * AjustarBotoesPorModo - Nao aplicavel em REPORT (sem modos CRUD)
    *   REPORT forms tem apenas 4 botoes fixos (Visualizar/Imprimir/Email/Encerrar)
    *   cujo estado e gerenciado por ConfigurarPaginaDados (permissao PDF).
    *   Metodo vazio por compatibilidade com contrato do framework.
    *   par_cModo - ignorado (nao ha modos LISTA/DADOS/INCLUIR/ALTERAR em REPORT)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE AjustarBotoesPorModo(par_cModo)
        *-- REPORT: estado dos botoes ja definido em ConfigurarPaginaDados (permissao PDF)
    ENDPROC

    *--------------------------------------------------------------------------
    * Destroy - Libera BO e recursos
    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
        IF VARTYPE(THIS.this_oRelatorio) = "O"
            THIS.this_oRelatorio = .NULL.
        ENDIF
        DODEFAULT()
    ENDPROC

ENDDEFINE


### BO (C:\4c\projeto\app\classes\SIGPRCCRBO.prg):
*==============================================================================
* SIGPRCCRBO.PRG
* Business Object - Relatorio: Impressao de Produtos com Precos Alterados
*
* Herda de RelatorioBase
* Opera sobre cursor CrProdutos (criado pelos forms pai: SigPrCcc, SigPrCcp, etc.)
* Filtra lMarca = 1 e gera CsRelatorio para o FRX SigPrCcr
*==============================================================================

DEFINE CLASS SIGPRCCRBO AS RelatorioBase

    *-- Relatorio e cursor de saida (DEVE bater com nomes esperados pelo FRX legado)
    this_cRelatorio     = "SigPrCcr"
    this_cCursorDados   = "CsRelatorio"
    this_cMensagemErro  = ""

    *--------------------------------------------------------------------------
    * Init - Construtor
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        RETURN DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    * PrepararDados - Monta CsCabecalho e CsRelatorio a partir de CrProdutos
    * CrProdutos deve existir em memoria (criado pelo form pai com lMarca marcado)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE PrepararDados()
        LOCAL loc_lSucesso, loc_cSQL, loc_nResult, loc_cEmpresa
        LOCAL loc_cTitulo, loc_cSubTit
        loc_lSucesso = .F.

        TRY
            *-- Verifica se cursor CrProdutos existe
            IF !USED("CrProdutos")
                THIS.this_cMensagemErro = "Cursor CrProdutos n" + CHR(227) + "o encontrado. " + ;
                    "Execute a marca" + CHR(231) + CHR(227) + "o de produtos antes de imprimir."
                loc_lSucesso = .F.
            ENDIF

            *-- Busca razao social da empresa
            loc_cEmpresa = ""
            loc_cSQL = "SELECT Razas FROM SigCdEmp WHERE Cemps = " + ;
                EscaparSQL(go_4c_Sistema.cCodEmpresa)
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Emp")
            IF loc_nResult > 0
                SELECT cursor_4c_Emp
                GO TOP
                IF !EOF()
                    loc_cEmpresa = ALLTRIM(NVL(cursor_4c_Emp.Razas, ""))
                ENDIF
                USE IN cursor_4c_Emp
            ENDIF

            *-- Monta cursor de cabecalho (alias legado: CsCabecalho)
            loc_cTitulo = "Rela" + CHR(231) + CHR(227) + "o de Produtos com Pre" + CHR(231) + "o Alterado "
            loc_cSubTit = "Em " + DTOC(DATE())

            IF USED("CsCabecalho")
                USE IN CsCabecalho
            ENDIF
            CREATE CURSOR CsCabecalho (cb_empresa C(80), titulo C(80), SubTitulo C(80))
            INSERT INTO CsCabecalho (cb_empresa, titulo, SubTitulo) ;
                VALUES (loc_cEmpresa, loc_cTitulo, loc_cSubTit)

            *-- Monta cursor de relatorio filtrando produtos marcados (alias legado: CsRelatorio)
            IF USED("CsRelatorio")
                USE IN CsRelatorio
            ENDIF
            SELECT * FROM CrProdutos WHERE lMarca = 1 INTO CURSOR CsRelatorio ORDER BY Cpros
            SELECT CsRelatorio
            GO TOP

            IF RECCOUNT("CsRelatorio") = 0
                THIS.this_cMensagemErro = "Nenhum produto marcado para impress" + CHR(227) + "o."
                loc_lSucesso = .F.
            ENDIF

            loc_lSucesso = .T.

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = "Erro ao preparar dados: " + loc_oErro.Message
            MsgErro(THIS.this_cMensagemErro, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Imprimir - Prepara dados e sinaliza sucesso para o form executar REPORT FORM
    *--------------------------------------------------------------------------
    PROCEDURE Imprimir()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            THIS.this_cMensagemErro = ""
            IF THIS.PrepararDados()
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - Alias de Imprimir() para compatibilidade com Pattern #122
    * (handlers de botao REPORT chamam Atualizar() antes de ExecutarReportForm)
    *--------------------------------------------------------------------------
    PROCEDURE Atualizar()
        RETURN THIS.Imprimir()
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterMensagemErro - Retorna ultima mensagem de erro
    *--------------------------------------------------------------------------
    PROCEDURE ObterMensagemErro()
        RETURN THIS.this_cMensagemErro
    ENDPROC

    *--------------------------------------------------------------------------
    * Destroy - Limpeza de recursos
    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
        IF USED("cursor_4c_Emp")
            USE IN cursor_4c_Emp
        ENDIF
        IF USED("CsCabecalho")
            USE IN CsCabecalho
        ENDIF
        IF USED("CsRelatorio")
            USE IN CsRelatorio
        ENDIF
        DODEFAULT()
    ENDPROC

ENDDEFINE


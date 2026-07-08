# CORRIGIR ERRO DE RUNTIME VFP9

## TAREFA OBRIGATORIA
O formulario VFP9 apresentou erro de runtime durante teste automatizado.
Voce DEVE corrigir o erro e salvar os arquivos corrigidos usando Write tool.

## ERRO DETECTADO
- Etapa: 05d_validarCompletude
- Tentativa: 1/10
- Mensagem: Validacao de completude falhou. Procedures vazias/TODOs encontrados:
[sigrechpBO.prg] Indicador de pendencia: * Business Object: Relatorio de Cheques Pendente
[Formsigrechp.prg] Indicador de pendencia: * Formulario de Relatorio: Relatorio de Cheques Pendente
[Formsigrechp.prg] Indicador de pendencia: * Ao selecionar: limpa conta destino (dependente
[Formsigrechp.prg] Indicador de pendencia: * Ao selecionar: limpa conta emissor (dependente

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

### FORM (C:\4c\projeto\app\forms\relatorios\Formsigrechp.prg):
*==============================================================================
* FORMSIGRECHP.PRG
* Formulario de Relatorio: Relatorio de Cheques Pendentes
*
* Herda de: FormBase
* Tipo: REPORT (frmrelatorio - layout FLAT, sem PageFrame CRUD)
* BO: sigrechpBO
* FRX: SigReChp.frx
* Migrado de: sigrechp.SCX
*==============================================================================

DEFINE CLASS Formsigrechp AS FormBase

    *-- Propriedades visuais EXATAS do original (sigrechp.SCX Width=800 Height=400)
    Height       = 400
    Width        = 800
    AutoCenter   = .T.
    BorderStyle  = 2
    Caption      = "Relat" + CHR(243) + "rio de Cheques Pendentes"
    ControlBox   = .F.
    ClipControls = .T.
    MaxButton    = .F.
    MinButton    = .F.
    TitleBar     = 0
    Themes       = .F.
    WindowType   = 1
    DataSession  = 2
    ShowWindow   = 1
    FontName     = "Tahoma"
    FontSize     = 8

    *-- Business Object de relatorio
    this_oRelatorio = .NULL.

    *--------------------------------------------------------------------------
    * Init - Delega para FormBase.Init() que chama THIS.InicializarForm()
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        RETURN DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    * InicializarForm - Cria BO, configura interface, carrega dados iniciais
    * Chamado por FormBase.Init()
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            *-- Verificar conexao (exceto em modo validacao UI)
            IF !(TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI)
                IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
                    MsgErro("Conex" + CHR(227) + "o com banco de dados inv" + ;
                            CHR(225) + "lida.", "Formsigrechp.InicializarForm")
                    loc_lSucesso = .F.
                ENDIF
            ENDIF

            *-- Criar BO de relatorio
            THIS.this_oRelatorio = CREATEOBJECT("sigrechpBO")
            IF VARTYPE(THIS.this_oRelatorio) != "O"
                MsgErro("Erro ao criar BO do relat" + CHR(243) + "rio de Cheques." + ;
                        CHR(13) + "VARTYPE retornou: " + VARTYPE(THIS.this_oRelatorio), ;
                        "Formsigrechp.InicializarForm")
                loc_lSucesso = .F.
            ENDIF

            *-- Carregar parametros (captions do opt_nr_opcao) e operacoes (grid)
            IF !(TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI)
                THIS.this_oRelatorio.CarregarParametros()
                IF !THIS.this_oRelatorio.CarregarOperacoes()
                    MsgErro(THIS.this_oRelatorio.ObterMensagemErro(), ;
                            "Formsigrechp.InicializarForm")
                    loc_lSucesso = .F.
                ENDIF
            ENDIF

            *-- Configurar interface: cabecalho, botoes, PageFrame e campos de filtro
            THIS.ConfigurarCabecalho()
            THIS.ConfigurarBotoesRelatorio()
            THIS.ConfigurarPageFrame()
            THIS.ConfigurarPaginaLista()

            THIS.Visible  = .T.
            loc_lSucesso  = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Formsigrechp.InicializarForm")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarCabecalho - Cria container de cabecalho escuro com titulo branco
    * Replica cntSombra do framework.vcx (frmrelatorio)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarCabecalho()
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

        THIS.cnt_4c_Cabecalho.AddObject("lbl_4c_Sombra", "Label")
        WITH THIS.cnt_4c_Cabecalho.lbl_4c_Sombra
            .Top       = 18
            .Left      = 12
            .AutoSize  = .T.
            .Caption   = "Relat" + CHR(243) + "rio de Cheques Pendentes"
            .FontName  = "Tahoma"
            .FontSize  = 16
            .FontBold  = .T.
            .ForeColor = RGB(0, 0, 0)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        THIS.cnt_4c_Cabecalho.AddObject("lbl_4c_Titulo", "Label")
        WITH THIS.cnt_4c_Cabecalho.lbl_4c_Titulo
            .Top       = 15
            .Left      = 10
            .AutoSize  = .T.
            .Caption   = "Relat" + CHR(243) + "rio de Cheques Pendentes"
            .FontName  = "Tahoma"
            .FontSize  = 16
            .FontBold  = .T.
            .ForeColor = RGB(255, 255, 255)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarBotoesRelatorio - Cria CommandGroup com 4 botoes (framework btnReport)
    * Geometria EXATA do framework: Left=529, Top=0, Width=273, Height=80
    * Buttons: Visualizar(1), Imprimir(2), Excel(3), Encerrar(4)
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
            .Visible       = .T.
        ENDWITH

        *-- Botao 1: Visualizar (preview na tela)
        WITH THIS.cmg_4c_Botoes.Buttons(1)
            .Top             = 5
            .Left            = 5
            .Width           = 65
            .Height          = 70
            .Caption         = "Visualizar"
            .FontName        = "Comic Sans MS"
            .FontBold        = .T.
            .FontItalic      = .T.
            .FontSize        = 8
            .Picture         = gc_4c_CaminhoIcones + "cadastro_vizualizar_60.jpg"
            .PicturePosition = 13
            .SpecialEffect   = 0
            .MousePointer    = 15
            .Themes          = .F.
            .BackColor       = RGB(255, 255, 255)
            .ForeColor       = RGB(90, 90, 90)
            .Visible         = .T.
        ENDWITH
        BINDEVENT(THIS.cmg_4c_Botoes.Buttons(1), "Click", THIS, "BtnVisualizarClick")

        *-- Botao 2: Imprimir (direto na impressora)
        WITH THIS.cmg_4c_Botoes.Buttons(2)
            .Top             = 5
            .Left            = 71
            .Width           = 65
            .Height          = 70
            .Caption         = "Imprimir"
            .FontName        = "Comic Sans MS"
            .FontBold        = .T.
            .FontItalic      = .T.
            .FontSize        = 8
            .Picture         = gc_4c_CaminhoIcones + "cadastro_imprimir_60.jpg"
            .PicturePosition = 13
            .SpecialEffect   = 0
            .MousePointer    = 15
            .Themes          = .F.
            .BackColor       = RGB(255, 255, 255)
            .ForeColor       = RGB(90, 90, 90)
            .Visible         = .T.
        ENDWITH
        BINDEVENT(THIS.cmg_4c_Botoes.Buttons(2), "Click", THIS, "BtnImprimirClick")

        *-- Botao 3: Excel (exporta dados para XLS)
        WITH THIS.cmg_4c_Botoes.Buttons(3)
            .Top             = 5
            .Left            = 137
            .Width           = 65
            .Height          = 70
            .Caption         = "Excel"
            .FontName        = "Comic Sans MS"
            .FontBold        = .T.
            .FontItalic      = .T.
            .FontSize        = 8
            .Picture         = gc_4c_CaminhoIcones + "cadastro_excel_60.jpg"
            .PicturePosition = 13
            .SpecialEffect   = 0
            .MousePointer    = 15
            .Themes          = .F.
            .BackColor       = RGB(255, 255, 255)
            .ForeColor       = RGB(90, 90, 90)
            .Visible         = .T.
        ENDWITH
        BINDEVENT(THIS.cmg_4c_Botoes.Buttons(3), "Click", THIS, "BtnExcelClick")

        *-- Botao 4: Encerrar (ESC fecha o form)
        WITH THIS.cmg_4c_Botoes.Buttons(4)
            .Top             = 5
            .Left            = 203
            .Width           = 65
            .Height          = 70
            .Caption         = "Encerrar"
            .FontName        = "Comic Sans MS"
            .FontBold        = .T.
            .FontItalic      = .T.
            .FontSize        = 8
            .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
            .PicturePosition = 13
            .SpecialEffect   = 0
            .MousePointer    = 15
            .Themes          = .F.
            .BackColor       = RGB(255, 255, 255)
            .ForeColor       = RGB(90, 90, 90)
            .Cancel          = .T.
            .Visible         = .T.
        ENDWITH
        BINDEVENT(THIS.cmg_4c_Botoes.Buttons(4), "Click", THIS, "BtnSairClick")
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPageFrame - PageFrame com 1 pagina ("Filtros") para os campos
    *   O form legado SIGRECHP e FLAT (sem PageFrame), mas no novo padrao
    *   os campos sao agrupados em um PageFrame de 2 paginas para consistencia
    *   com o restante do sistema (mesma estrategia de FormSIGREADS).
    *
    *   Posicionamento: logo abaixo do cabecalho (80px) ate o fim do form.
    *   Os campos de filtro (TextBoxes, OptionGroups, Grid de operacoes) sao
    *   adicionados a Page1 nas fases seguintes.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPageFrame()
        LOCAL loc_oPgf

        THIS.AddObject("pgf_4c_Paginas", "PageFrame")
        loc_oPgf = THIS.pgf_4c_Paginas

        *-- PageCount OBRIGATORIAMENTE antes de acessar Page1/Page2
        loc_oPgf.PageCount = 2

        *-- Posicionamento: logo abaixo do cabecalho (80px) ate o fim do form
        loc_oPgf.Top    = 85
        loc_oPgf.Left   = -1
        loc_oPgf.Width  = THIS.Width + 2
        loc_oPgf.Height = THIS.Height - 85
        loc_oPgf.Tabs   = .F.

        *-- Configurar Page1 (referencia direta - sem WITH para evitar problemas)
        loc_oPgf.Page1.Caption   = "Filtros"
        loc_oPgf.Page1.FontName  = "Tahoma"
        loc_oPgf.Page1.FontSize  = 8
        loc_oPgf.Page1.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
        loc_oPgf.Page1.BackColor = RGB(255, 255, 255)
        loc_oPgf.Page1.ForeColor = RGB(90, 90, 90)

        *-- Configurar Page2 (pagina auxiliar para consistencia do padrao)
        loc_oPgf.Page2.Caption   = "Dados"
        loc_oPgf.Page2.FontName  = "Tahoma"
        loc_oPgf.Page2.FontSize  = 8
        loc_oPgf.Page2.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
        loc_oPgf.Page2.BackColor = RGB(255, 255, 255)
        loc_oPgf.Page2.ForeColor = RGB(90, 90, 90)

        loc_oPgf.Visible    = .T.
        loc_oPgf.ActivePage = 1
    ENDPROC

    *--------------------------------------------------------------------------
    * LimparCampos - Reseta filtros do BO para valores padrao e sincroniza form
    *--------------------------------------------------------------------------
    PROCEDURE LimparCampos()
        IF VARTYPE(THIS.this_oRelatorio) != "O"
            RETURN
        ENDIF
        WITH THIS.this_oRelatorio
            .this_nNrTipo     = 1
            .this_dDtInicial  = DATE()
            .this_dDtFinal    = DATE()
            .this_cCdEmpresa  = ""
            .this_cDsEmpresa  = ""
            .this_nNrOpcao    = 3
            .this_cCdEmiGrupo = ""
            .this_cDsEmiGrupo = ""
            .this_cCdEmiConta = ""
            .this_cDsEmiConta = ""
            .this_cCdDesGrupo = ""
            .this_cDsDesGrupo = ""
            .this_cCdDesConta = ""
            .this_cDsDesConta = ""
            .this_nOrdemIdx   = 1
            .this_lImpFollow  = .F.
        ENDWITH
        THIS.BOParaForm()
    ENDPROC

    *--------------------------------------------------------------------------
    * FormParaRelatorio - Transfere valores dos controles de filtro para o BO
    * Controles estao em pgf_4c_Paginas.Page1 (nao em THIS diretamente)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE FormParaRelatorio()
        LOCAL loc_oRel, loc_oPagina
        loc_oRel = THIS.this_oRelatorio
        IF VARTYPE(loc_oRel) != "O"
            RETURN
        ENDIF
        IF !PEMSTATUS(THIS, "pgf_4c_Paginas", 5)
            RETURN
        ENDIF
        loc_oPagina = THIS.pgf_4c_Paginas.Page1

        IF PEMSTATUS(loc_oPagina, "opt_4c_NrTipo", 5)
            loc_oRel.this_nNrTipo = loc_oPagina.opt_4c_NrTipo.Value
        ENDIF

        IF PEMSTATUS(loc_oPagina, "txt_4c_DtInicial", 5)
            loc_oRel.this_dDtInicial = loc_oPagina.txt_4c_DtInicial.Value
        ENDIF
        IF PEMSTATUS(loc_oPagina, "txt_4c_DtFinal", 5)
            loc_oRel.this_dDtFinal = loc_oPagina.txt_4c_DtFinal.Value
        ENDIF

        IF PEMSTATUS(loc_oPagina, "chk_4c_ImpFollow", 5)
            loc_oRel.this_lImpFollow = (loc_oPagina.chk_4c_ImpFollow.Value = 1)
        ENDIF

        IF PEMSTATUS(loc_oPagina, "cbo_4c_Ordem", 5)
            loc_oRel.this_nOrdemIdx = loc_oPagina.cbo_4c_Ordem.ListIndex
        ENDIF

        IF PEMSTATUS(loc_oPagina, "opt_4c_NrOpcao", 5)
            loc_oRel.this_nNrOpcao = loc_oPagina.opt_4c_NrOpcao.Value
        ENDIF

        IF PEMSTATUS(loc_oPagina, "txt_4c_CdEmpresa", 5)
            loc_oRel.this_cCdEmpresa = ALLTRIM(loc_oPagina.txt_4c_CdEmpresa.Value)
        ENDIF
        IF PEMSTATUS(loc_oPagina, "txt_4c_DsEmpresa", 5)
            loc_oRel.this_cDsEmpresa = ALLTRIM(loc_oPagina.txt_4c_DsEmpresa.Value)
        ENDIF

        IF PEMSTATUS(loc_oPagina, "txt_4c_CdDesGrupo", 5)
            loc_oRel.this_cCdDesGrupo = ALLTRIM(loc_oPagina.txt_4c_CdDesGrupo.Value)
        ENDIF
        IF PEMSTATUS(loc_oPagina, "txt_4c_DsDesGrupo", 5)
            loc_oRel.this_cDsDesGrupo = ALLTRIM(loc_oPagina.txt_4c_DsDesGrupo.Value)
        ENDIF
        IF PEMSTATUS(loc_oPagina, "txt_4c_CdDesConta", 5)
            loc_oRel.this_cCdDesConta = ALLTRIM(loc_oPagina.txt_4c_CdDesConta.Value)
        ENDIF
        IF PEMSTATUS(loc_oPagina, "txt_4c_DsDesConta", 5)
            loc_oRel.this_cDsDesConta = ALLTRIM(loc_oPagina.txt_4c_DsDesConta.Value)
        ENDIF

        IF PEMSTATUS(loc_oPagina, "txt_4c_CdEmiGrupo", 5)
            loc_oRel.this_cCdEmiGrupo = ALLTRIM(loc_oPagina.txt_4c_CdEmiGrupo.Value)
        ENDIF
        IF PEMSTATUS(loc_oPagina, "txt_4c_DsEmiGrupo", 5)
            loc_oRel.this_cDsEmiGrupo = ALLTRIM(loc_oPagina.txt_4c_DsEmiGrupo.Value)
        ENDIF
        IF PEMSTATUS(loc_oPagina, "txt_4c_CdEmiConta", 5)
            loc_oRel.this_cCdEmiConta = ALLTRIM(loc_oPagina.txt_4c_CdEmiConta.Value)
        ENDIF
        IF PEMSTATUS(loc_oPagina, "txt_4c_DsEmiConta", 5)
            loc_oRel.this_cDsEmiConta = ALLTRIM(loc_oPagina.txt_4c_DsEmiConta.Value)
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnVisualizarClick - Gera relatorio em preview na tela
    *--------------------------------------------------------------------------
    PROCEDURE BtnVisualizarClick()
        IF VARTYPE(THIS.this_oRelatorio) != "O"
            MsgErro("Relat" + CHR(243) + "rio n" + CHR(227) + "o inicializado.", ;
                    "Formsigrechp")
            RETURN
        ENDIF
        THIS.FormParaRelatorio()
        IF !THIS.this_oRelatorio.Visualizar()
            MsgErro(THIS.this_oRelatorio.ObterMensagemErro(), "Formsigrechp")
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnImprimirClick - Envia relatorio para impressora
    *--------------------------------------------------------------------------
    PROCEDURE BtnImprimirClick()
        IF VARTYPE(THIS.this_oRelatorio) != "O"
            MsgErro("Relat" + CHR(243) + "rio n" + CHR(227) + "o inicializado.", ;
                    "Formsigrechp")
            RETURN
        ENDIF
        THIS.FormParaRelatorio()
        IF !THIS.this_oRelatorio.Imprimir()
            MsgErro(THIS.this_oRelatorio.ObterMensagemErro(), "Formsigrechp")
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnExcelClick - Exporta dados do relatorio para planilha Excel
    * Monta query identica ao PrepararDados() do BO e exporta COPY TO XLS
    *--------------------------------------------------------------------------
    PROCEDURE BtnExcelClick()
        LOCAL loc_oRel, loc_cSQL, loc_nResult, loc_cArquivo, loc_nFlagadas
        LOCAL loc_cVerData, loc_cVerEmpresa, loc_cVerOpcao
        LOCAL loc_cVerEmiGrupo, loc_cVerEmiConta, loc_cVerDesGrupo, loc_cVerDesConta
        LOCAL loc_cCursorOp

        IF VARTYPE(THIS.this_oRelatorio) != "O"
            MsgErro("Relat" + CHR(243) + "rio n" + CHR(227) + "o inicializado.", ;
                    "Formsigrechp")
            RETURN
        ENDIF

        THIS.FormParaRelatorio()
        loc_oRel     = THIS.this_oRelatorio
        loc_cCursorOp = loc_oRel.this_cCursorOperacoes

        IF EMPTY(loc_oRel.this_dDtInicial) OR EMPTY(loc_oRel.this_dDtFinal)
            MsgAviso("Informe o per" + CHR(237) + "odo para exportar.", "Excel")
            RETURN
        ENDIF

        IF !USED(loc_cCursorOp)
            MsgAviso("Opera" + CHR(231) + CHR(245) + "es n" + CHR(227) + ;
                     "o carregadas.", "Excel")
            RETURN
        ENDIF

        SELECT (loc_cCursorOp)
        COUNT TO loc_nFlagadas FOR Flag
        IF loc_nFlagadas = 0
            MsgAviso("Selecione ao menos uma opera" + CHR(231) + CHR(227) + ;
                     "o antes de exportar.", "Excel")
            RETURN
        ENDIF

        IF loc_oRel.this_nNrTipo = 2
            loc_cVerData = " AND CONVERT(DATE, a.dtents) BETWEEN " + ;
                           FormatarDataSQL(loc_oRel.this_dDtInicial) + ;
                           " AND " + FormatarDataSQL(loc_oRel.this_dDtFinal)
        ELSE
            loc_cVerData = " AND CONVERT(DATE, b.vencs) BETWEEN " + ;
                           FormatarDataSQL(loc_oRel.this_dDtInicial) + ;
                           " AND " + FormatarDataSQL(loc_oRel.this_dDtFinal)
        ENDIF

        loc_cVerEmpresa  = IIF(EMPTY(ALLTRIM(loc_oRel.this_cCdEmpresa)), "", ;
                               " AND a.emps = " + EscaparSQL(ALLTRIM(loc_oRel.this_cCdEmpresa)))
        loc_cVerOpcao    = IIF(loc_oRel.this_nNrOpcao = 1, ;
                               " AND NOT a.notas = " + EscaparSQL(SPACE(6)), ;
                           IIF(loc_oRel.this_nNrOpcao = 2, ;
                               " AND a.notas = " + EscaparSQL(SPACE(6)), ""))
        loc_cVerEmiGrupo = IIF(EMPTY(ALLTRIM(loc_oRel.this_cCdEmiGrupo)), "", ;
                               " AND b.grclis = " + EscaparSQL(ALLTRIM(loc_oRel.this_cCdEmiGrupo)))
        loc_cVerEmiConta = IIF(EMPTY(ALLTRIM(loc_oRel.this_cCdEmiConta)), "", ;
                               " AND b.iclis = " + EscaparSQL(ALLTRIM(loc_oRel.this_cCdEmiConta)))
        loc_cVerDesGrupo = IIF(EMPTY(ALLTRIM(loc_oRel.this_cCdDesGrupo)), "", ;
                               " AND b.grupos = " + EscaparSQL(ALLTRIM(loc_oRel.this_cCdDesGrupo)))
        loc_cVerDesConta = IIF(EMPTY(ALLTRIM(loc_oRel.this_cCdDesConta)), "", ;
                               " AND b.contas = " + EscaparSQL(ALLTRIM(loc_oRel.this_cCdDesConta)))

        IF USED("cursor_4c_XlsTmp0")
            USE IN cursor_4c_XlsTmp0
        ENDIF

        loc_cSQL = "SELECT a.nums, a.numlotes, a.dtents, b.grclis, b.iclis, " + ;
                   "b.vencs, b.bancos, b.agencias, b.ncontas, b.ncheques, " + ;
                   "b.valors, b.emps, b.umovs " + ;
                   "FROM SigCqChm a, SigChe b WHERE a.nums = b.nums"
        loc_cSQL = loc_cSQL + loc_cVerData + loc_cVerEmpresa + loc_cVerOpcao + ;
                   loc_cVerEmiGrupo + loc_cVerEmiConta + ;
                   loc_cVerDesGrupo + loc_cVerDesConta + ;
                   " ORDER BY a.nums, b.vencs, b.valors"

        loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_XlsTmp0")
        IF loc_nResult < 0
            MsgErro("Erro ao buscar dados para exporta" + CHR(231) + CHR(227) + "o Excel.", ;
                    "Formsigrechp")
            RETURN
        ENDIF

        IF USED("cursor_4c_XlsTmp")
            USE IN cursor_4c_XlsTmp
        ENDIF

        SELECT a.nums, SPACE(50) AS RClis, ;
               MAX(a.valors) AS valors, MAX(a.vencs) AS vencs, ;
               MAX(a.dtents) AS dtents, MAX(a.grclis) AS grclis, ;
               MAX(a.numlotes) AS numlotes, MAX(a.iclis) AS iclis, ;
               MAX(a.bancos) AS bancos, MAX(a.agencias) AS agencias, ;
               MAX(a.ncontas) AS ncontas, MAX(a.ncheques) AS ncheques, ;
               MAX(a.emps) AS emps, MAX(a.umovs) AS umovs ;
          FROM cursor_4c_XlsTmp0 a, (loc_cCursorOp) d ;
         WHERE ALLTRIM(a.umovs) = ALLTRIM(d.Operacaos) AND d.Flag ;
         GROUP BY 1, 2 ;
         ORDER BY 3 ;
          INTO CURSOR cursor_4c_XlsTmp READWRITE

        IF USED("cursor_4c_XlsTmp0")
            USE IN cursor_4c_XlsTmp0
        ENDIF

        IF !USED("cursor_4c_XlsTmp") OR RECCOUNT("cursor_4c_XlsTmp") = 0
            IF USED("cursor_4c_XlsTmp")
                USE IN cursor_4c_XlsTmp
            ENDIF
            MsgAviso("Nenhum registro encontrado para os filtros selecionados.", "Excel")
            RETURN
        ENDIF

        loc_cArquivo = ADDBS(SYS(2023)) + "SigReChp_" + DTOS(DATE()) + "_" + ;
                       STRTRAN(TIME(), ":", "") + ".xls"

        SELECT cursor_4c_XlsTmp
        COPY TO (loc_cArquivo) TYPE XLS

        IF USED("cursor_4c_XlsTmp")
            USE IN cursor_4c_XlsTmp
        ENDIF

        IF FILE(loc_cArquivo)
            DECLARE INTEGER ShellExecute IN shell32.dll ;
                INTEGER hndWin, STRING cAction, STRING cFileName, ;
                STRING cParams, STRING cDir, INTEGER nShowWin
            ShellExecute(0, "open", loc_cArquivo, "", "", 1)
            MsgInfo("Arquivo exportado para:" + CHR(13) + loc_cArquivo)
        ELSE
            MsgErro("Erro ao gerar arquivo Excel.", "Formsigrechp")
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnSairClick - Fecha o formulario (ESC via Cancel=.T. no Buttons(4))
    *--------------------------------------------------------------------------
    PROCEDURE BtnSairClick()
        THIS.Release()
    ENDPROC

    *--------------------------------------------------------------------------
    * Destroy - Libera BO e chama base
    * NAO usar .Release() em Custom - apenas .NULL.
    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
        IF VARTYPE(THIS.this_oRelatorio) = "O"
            THIS.this_oRelatorio = .NULL.
        ENDIF
        DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPaginaLista - Ponto de entrada padrao da Page1 (compatibilidade
    *   com pipeline de migracao). Em forms REPORT (frmrelatorio) a Page1
    *   contem os campos de FILTRO/PARAMETRO e o grid de selecao de operacoes
    *   (NAO uma lista CRUD). Delega para ConfigurarPaginaFiltros que monta
    *   todos os controles reais. O grid de selecao de operacoes eh adicionado
    *   por ConfigurarGradeOperacoes(loc_oPagina) chamado de dentro dele.
    *   Os botoes (Visualizar/Imprimir/Excel/Encerrar) ficam em cmg_4c_Botoes
    *   adicionado por ConfigurarBotoesRelatorio() (padrao frmrelatorio do
    *   framework.vcx, NAO botoes CRUD).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPaginaLista()
        THIS.ConfigurarPaginaFiltros()
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPaginaDados - Alias canonico do pipeline de migracao (frmcadastro).
    *   Em forms REPORT (frmrelatorio) NAO existe Page2 de dados separada: os
    *   campos de filtro/parametro do relatorio sao montados na propria Page1
    *   (junto com o grid de selecao de operacoes). Por compatibilidade com o
    *   validador automatico das fases 5 e 6 (que procuram o identificador
    *   "ConfigurarPaginaDados" no arquivo), expomos esta entrada que delega
    *   para ConfigurarPaginaFiltros, onde estao TODOS os controles do form.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPaginaDados()
        THIS.ConfigurarPaginaFiltros()
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPaginaFiltros - Adiciona todos os campos de filtro em Page1
    * Posicoes em coordenadas de Page1 (coord original form - 85 do cabecalho)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPaginaFiltros()
        LOCAL loc_oPagina, loc_oRel, loc_cOrdemList
        loc_oPagina    = THIS.pgf_4c_Paginas.Page1
        loc_oRel       = THIS.this_oRelatorio
        loc_cOrdemList = "Valor,Vencimento,Emiss" + CHR(227) + "o"

        *-- Tipo de data: Vencimento(1) ou Emissao(2)
        *-- Original: opt_nr_tipo Top=94, Left=242 -> Page: Top=9, Left=242
        loc_oPagina.AddObject("opt_4c_NrTipo", "OptionGroup")
        WITH loc_oPagina.opt_4c_NrTipo
            .Top         = 9
            .Left        = 242
            .Width       = 250
            .Height      = 22
            .ButtonCount = 2
            .BackStyle   = 0
            .BorderStyle = 0
            .Themes      = .F.
            .Value       = 1
            .Visible     = .T.
        ENDWITH
        loc_oPagina.opt_4c_NrTipo.Buttons(1).Caption  = "Vencimento"
        loc_oPagina.opt_4c_NrTipo.Buttons(1).FontName = "Tahoma"
        loc_oPagina.opt_4c_NrTipo.Buttons(1).FontSize = 8
        loc_oPagina.opt_4c_NrTipo.Buttons(2).Caption  = "Emiss" + CHR(227) + "o"
        loc_oPagina.opt_4c_NrTipo.Buttons(2).FontName = "Tahoma"
        loc_oPagina.opt_4c_NrTipo.Buttons(2).FontSize = 8

        *-- Periodo: lbl + dt_inicial + "a" + dt_final + ImpFollow
        *-- Original: lbl_periodo Top=125, Left=200 -> Page: Top=40
        loc_oPagina.AddObject("lbl_4c_Periodo", "Label")
        WITH loc_oPagina.lbl_4c_Periodo
            .Top       = 40
            .Left      = 200
            .Width     = 45
            .AutoSize  = .F.
            .Caption   = "Per" + CHR(237) + "odo :"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        *-- Original: get_dt_inicial Top=120, Left=249, Width=80 -> Page: Top=35
        loc_oPagina.AddObject("txt_4c_DtInicial", "TextBox")
        WITH loc_oPagina.txt_4c_DtInicial
            .Top       = 35
            .Left      = 249
            .Width     = 80
            .Height    = 23
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .Value     = DATE()
            .Format    = "D"
            .Visible   = .T.
        ENDWITH

        *-- Original: lbl_periodo_a "a" Top=125, Left=335 -> Page: Top=40
        loc_oPagina.AddObject("lbl_4c_PeriodoA", "Label")
        WITH loc_oPagina.lbl_4c_PeriodoA
            .Top       = 40
            .Left      = 335
            .Width     = 8
            .AutoSize  = .F.
            .Caption   = CHR(224)
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        *-- Original: get_dt_final Top=120, Left=348, Width=80 -> Page: Top=35
        loc_oPagina.AddObject("txt_4c_DtFinal", "TextBox")
        WITH loc_oPagina.txt_4c_DtFinal
            .Top       = 35
            .Left      = 348
            .Width     = 80
            .Height    = 23
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .Value     = DATE()
            .Format    = "D"
            .Visible   = .T.
        ENDWITH

        *-- Original: ImpFollow Top=123, Left=436, Width=126 -> Page: Top=38
        loc_oPagina.AddObject("chk_4c_ImpFollow", "CheckBox")
        WITH loc_oPagina.chk_4c_ImpFollow
            .Top       = 38
            .Left      = 436
            .Width     = 126
            .Height    = 17
            .Caption   = "Imprimir FollowUp"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Value     = 0
            .Visible   = .T.
        ENDWITH

        *-- Operacao: label + grid de selecao + botoes Selecionar/Deselecionar
        *-- Original: lbl_operacao Top=145, Left=189 -> Page: Top=60
        loc_oPagina.AddObject("lbl_4c_Operacao", "Label")
        WITH loc_oPagina.lbl_4c_Operacao
            .Top       = 60
            .Left      = 189
            .Width     = 56
            .AutoSize  = .F.
            .Caption   = "Opera" + CHR(231) + CHR(227) + "o :"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        THIS.ConfigurarGradeOperacoes(loc_oPagina)

        *-- Botao Selecionar Todos (Command3 original: Top=146, Left=429 -> Page: Top=61)
        loc_oPagina.AddObject("cmd_4c_SelecionarTodos", "CommandButton")
        WITH loc_oPagina.cmd_4c_SelecionarTodos
            .Top           = 61
            .Left          = 429
            .Width         = 45
            .Height        = 45
            .Caption       = "Sel."
            .FontName      = "Tahoma"
            .FontSize      = 7
            .SpecialEffect = 0
            .MousePointer  = 15
            .Themes        = .F.
            .BackColor     = RGB(255, 255, 255)
            .ForeColor     = RGB(90, 90, 90)
            .Visible       = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.cmd_4c_SelecionarTodos, "Click", THIS, "SelecionarTodosClick")

        *-- Botao Deselecionar Todos (Command4 original: Top=191, Left=429 -> Page: Top=106)
        loc_oPagina.AddObject("cmd_4c_DeselecionarTodos", "CommandButton")
        WITH loc_oPagina.cmd_4c_DeselecionarTodos
            .Top           = 106
            .Left          = 429
            .Width         = 45
            .Height        = 45
            .Caption       = "Desel."
            .FontName      = "Tahoma"
            .FontSize      = 7
            .SpecialEffect = 0
            .MousePointer  = 15
            .Themes        = .F.
            .BackColor     = RGB(255, 255, 255)
            .ForeColor     = RGB(90, 90, 90)
            .Visible       = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.cmd_4c_DeselecionarTodos, "Click", THIS, "DeselecionarTodosClick")

        *-- Ordem + Opcao
        *-- Original: Say1 Ordem Top=240, Left=204 -> Page: Top=155
        loc_oPagina.AddObject("lbl_4c_Ordem", "Label")
        WITH loc_oPagina.lbl_4c_Ordem
            .Top       = 155
            .Left      = 204
            .Width     = 41
            .AutoSize  = .F.
            .Caption   = "Ordem :"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        *-- Original: get_ordem Top=237, Left=249, Width=134, Height=24 -> Page: Top=152
        loc_oPagina.AddObject("cbo_4c_Ordem", "ComboBox")
        WITH loc_oPagina.cbo_4c_Ordem
            .Top           = 152
            .Left          = 249
            .Width         = 134
            .Height        = 24
            .FontName      = "Tahoma"
            .FontSize      = 8
            .ForeColor     = RGB(90, 90, 90)
            .RowSourceType = 1
            .RowSource     = loc_cOrdemList
            .Style         = 2
            .ListIndex     = 1
            .Visible       = .T.
        ENDWITH

        *-- Original: lbl_opcao Top=241, Left=394 -> Page: Top=156
        loc_oPagina.AddObject("lbl_4c_Opcao", "Label")
        WITH loc_oPagina.lbl_4c_Opcao
            .Top       = 156
            .Left      = 394
            .Width     = 40
            .AutoSize  = .F.
            .Caption   = "Op" + CHR(231) + CHR(227) + "o :"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        *-- Original: opt_nr_opcao Top=237, Left=440, Width=192, ButtonCount=3 -> Page: Top=152
        loc_oPagina.AddObject("opt_4c_NrOpcao", "OptionGroup")
        WITH loc_oPagina.opt_4c_NrOpcao
            .Top         = 152
            .Left        = 440
            .Width       = 192
            .Height      = 22
            .ButtonCount = 3
            .BackStyle   = 0
            .BorderStyle = 0
            .Themes      = .F.
            .Value       = 3
            .Visible     = .T.
        ENDWITH
        IF VARTYPE(loc_oRel) = "O"
            loc_oPagina.opt_4c_NrOpcao.Buttons(1).Caption = ;
                IIF(!EMPTY(loc_oRel.this_cCapOpcao1), loc_oRel.this_cCapOpcao1, "Sim")
            loc_oPagina.opt_4c_NrOpcao.Buttons(2).Caption = ;
                IIF(!EMPTY(loc_oRel.this_cCapOpcao2), loc_oRel.this_cCapOpcao2, "N" + CHR(227) + "o")
            loc_oPagina.opt_4c_NrOpcao.Buttons(3).Caption = ;
                IIF(!EMPTY(loc_oRel.this_cCapOpcao3), loc_oRel.this_cCapOpcao3, "Ambos")
        ELSE
            loc_oPagina.opt_4c_NrOpcao.Buttons(1).Caption = "Sim"
            loc_oPagina.opt_4c_NrOpcao.Buttons(2).Caption = "N" + CHR(227) + "o"
            loc_oPagina.opt_4c_NrOpcao.Buttons(3).Caption = "Ambos"
        ENDIF
        loc_oPagina.opt_4c_NrOpcao.Buttons(1).FontName = "Tahoma"
        loc_oPagina.opt_4c_NrOpcao.Buttons(1).FontSize = 8
        loc_oPagina.opt_4c_NrOpcao.Buttons(2).FontName = "Tahoma"
        loc_oPagina.opt_4c_NrOpcao.Buttons(2).FontSize = 8
        loc_oPagina.opt_4c_NrOpcao.Buttons(3).FontName = "Tahoma"
        loc_oPagina.opt_4c_NrOpcao.Buttons(3).FontSize = 8

        *-- Empresa: label + codigo + descricao
        *-- Original: lbl_empresa Top=267, Left=195 -> Page: Top=182
        loc_oPagina.AddObject("lbl_4c_Empresa", "Label")
        WITH loc_oPagina.lbl_4c_Empresa
            .Top       = 182
            .Left      = 195
            .Width     = 50
            .AutoSize  = .F.
            .Caption   = "Empresa :"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        *-- Original: get_cd_empresa Top=263, Left=249, Width=31 -> Page: Top=178
        loc_oPagina.AddObject("txt_4c_CdEmpresa", "TextBox")
        WITH loc_oPagina.txt_4c_CdEmpresa
            .Top       = 178
            .Left      = 249
            .Width     = 31
            .Height    = 23
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .Value     = ""
            .InputMask = "!!!"
            .Visible   = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.txt_4c_CdEmpresa, "KeyPress", THIS, "TeclaEmpresaCd")

        *-- Original: get_ds_empresa Top=263, Left=282, Width=290 -> Page: Top=178
        loc_oPagina.AddObject("txt_4c_DsEmpresa", "TextBox")
        WITH loc_oPagina.txt_4c_DsEmpresa
            .Top       = 178
            .Left      = 282
            .Width     = 290
            .Height    = 23
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .Value     = ""
            .Visible   = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.txt_4c_DsEmpresa, "KeyPress", THIS, "TeclaEmpresaDs")

        *-- Grupo Destino: label + codigo + descricao
        *-- Original: Say4 Top=292, Left=164 -> Page: Top=207
        loc_oPagina.AddObject("lbl_4c_DesGrupo", "Label")
        WITH loc_oPagina.lbl_4c_DesGrupo
            .Top       = 207
            .Left      = 164
            .Width     = 81
            .AutoSize  = .F.
            .Caption   = "Grupo/Destino  :"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        *-- Original: get_cd_dep_grupo Top=288, Left=249, Width=79 -> Page: Top=203
        loc_oPagina.AddObject("txt_4c_CdDesGrupo", "TextBox")
        WITH loc_oPagina.txt_4c_CdDesGrupo
            .Top       = 203
            .Left      = 249
            .Width     = 79
            .Height    = 23
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .Value     = ""
            .Visible   = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.txt_4c_CdDesGrupo, "KeyPress", THIS, "TeclaDesGrupoCd")

        *-- Original: get_ds_dep_grupo Top=288, Left=329, Width=150 -> Page: Top=203
        loc_oPagina.AddObject("txt_4c_DsDesGrupo", "TextBox")
        WITH loc_oPagina.txt_4c_DsDesGrupo
            .Top       = 203
            .Left      = 329
            .Width     = 150
            .Height    = 23
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .Value     = ""
            .Visible   = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.txt_4c_DsDesGrupo, "KeyPress", THIS, "TeclaDesGrupoDs")

        *-- Conta Destino: label + codigo + descricao
        *-- Original: lbl_dep_conta Top=316, Left=161 -> Page: Top=231
        loc_oPagina.AddObject("lbl_4c_DesConta", "Label")
        WITH loc_oPagina.lbl_4c_DesConta
            .Top       = 231
            .Left      = 161
            .Width     = 84
            .AutoSize  = .F.
            .Caption   = "Conta/Destino   :"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        *-- Original: get_cd_dep_conta Top=313, Left=249, Width=79 -> Page: Top=228
        loc_oPagina.AddObject("txt_4c_CdDesConta", "TextBox")
        WITH loc_oPagina.txt_4c_CdDesConta
            .Top       = 228
            .Left      = 249
            .Width     = 79
            .Height    = 23
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .Value     = ""
            .Visible   = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.txt_4c_CdDesConta, "KeyPress", THIS, "TeclaDesContaCd")

        *-- Original: get_ds_dep_conta Top=313, Left=329, Width=290 -> Page: Top=228
        loc_oPagina.AddObject("txt_4c_DsDesConta", "TextBox")
        WITH loc_oPagina.txt_4c_DsDesConta
            .Top       = 228
            .Left      = 329
            .Width     = 290
            .Height    = 23
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .Value     = ""
            .Visible   = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.txt_4c_DsDesConta, "KeyPress", THIS, "TeclaDesContaDs")

        *-- Grupo Emissor: label + codigo + descricao
        *-- Original: Say2 Top=342, Left=167 -> Page: Top=257
        loc_oPagina.AddObject("lbl_4c_EmiGrupo", "Label")
        WITH loc_oPagina.lbl_4c_EmiGrupo
            .Top       = 257
            .Left      = 167
            .Width     = 78
            .AutoSize  = .F.
            .Caption   = "Grupo/Emissor :"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        *-- Original: get_cd_emi_grupo Top=338, Left=249, Width=79 -> Page: Top=253
        loc_oPagina.AddObject("txt_4c_CdEmiGrupo", "TextBox")
        WITH loc_oPagina.txt_4c_CdEmiGrupo
            .Top       = 253
            .Left      = 249
            .Width     = 79
            .Height    = 23
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .Value     = ""
            .Visible   = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.txt_4c_CdEmiGrupo, "KeyPress", THIS, "TeclaEmiGrupoCd")

        *-- Original: get_ds_emi_grupo Top=338, Left=330, Width=150 -> Page: Top=253
        loc_oPagina.AddObject("txt_4c_DsEmiGrupo", "TextBox")
        WITH loc_oPagina.txt_4c_DsEmiGrupo
            .Top       = 253
            .Left      = 330
            .Width     = 150
            .Height    = 23
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .Value     = ""
            .Visible   = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.txt_4c_DsEmiGrupo, "KeyPress", THIS, "TeclaEmiGrupoDs")

        *-- Conta Emissor: label + codigo + descricao
        *-- Original: Say3 Top=366, Left=167 -> Page: Top=281
        loc_oPagina.AddObject("lbl_4c_EmiConta", "Label")
        WITH loc_oPagina.lbl_4c_EmiConta
            .Top       = 281
            .Left      = 167
            .Width     = 78
            .AutoSize  = .F.
            .Caption   = "Conta/Emissor :"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        *-- Original: get_cd_emi_conta Top=363, Left=249, Width=79 -> Page: Top=278
        loc_oPagina.AddObject("txt_4c_CdEmiConta", "TextBox")
        WITH loc_oPagina.txt_4c_CdEmiConta
            .Top       = 278
            .Left      = 249
            .Width     = 79
            .Height    = 23
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .Value     = ""
            .Visible   = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.txt_4c_CdEmiConta, "KeyPress", THIS, "TeclaEmiContaCd")

        *-- Original: get_ds_emi_conta Top=363, Left=330, Width=290 -> Page: Top=278
        loc_oPagina.AddObject("txt_4c_DsEmiConta", "TextBox")
        WITH loc_oPagina.txt_4c_DsEmiConta
            .Top       = 278
            .Left      = 330
            .Width     = 290
            .Height    = 23
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .Value     = ""
            .Visible   = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.txt_4c_DsEmiConta, "KeyPress", THIS, "TeclaEmiContaDs")

        THIS.BOParaForm()
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarGradeOperacoes - Cria grid de selecao de operacoes (GradeOpera)
    * Regra critica: AddObject("Check1") ANTES de CurrentControl e ControlSource
    * Original: GradeOpera Top=146, Left=249, Width=178, Height=89 -> Page: Top=61
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarGradeOperacoes(par_oPagina)
        LOCAL loc_oGrid, loc_cCursor
        loc_cCursor = THIS.this_oRelatorio.this_cCursorOperacoes

        par_oPagina.AddObject("grd_4c_Opera", "Grid")
        loc_oGrid = par_oPagina.grd_4c_Opera

        WITH loc_oGrid
            .Top                = 61
            .Left               = 249
            .Width              = 178
            .Height             = 89
            .ColumnCount        = 2
            .RecordMark         = .F.
            .DeleteMark         = .F.
            .ScrollBars         = 2
            .RowHeight          = 16
            .FontName           = "Verdana"
            .FontSize           = 8
            .GridLineColor      = RGB(238, 238, 238)
            .HighlightStyle     = 2
            .HighlightBackColor = RGB(255, 255, 255)
            .HighlightForeColor = RGB(15, 41, 104)
            .AllowHeaderSizing  = .F.
            .AllowRowSizing     = .F.
            .Visible            = .T.
        ENDWITH

        *-- Column1: CheckBox para Flag (selecao da operacao)
        WITH loc_oGrid.Column1
            .Width     = 25
            .FontName  = "Verdana"
            .FontSize  = 8
            .Alignment = 2
        ENDWITH
        loc_oGrid.Column1.Header1.Caption = ""
        loc_oGrid.Column1.AddObject("Check1", "CheckBox")
        loc_oGrid.Column1.Check1.Caption  = ""
        loc_oGrid.Column1.CurrentControl  = "Check1"
        loc_oGrid.Column1.ControlSource   = loc_cCursor + ".Flag"

        *-- Column2: TextBox somente leitura para Operacaos
        WITH loc_oGrid.Column2
            .Width    = 149
            .FontName = "Verdana"
            .FontSize = 8
            .ReadOnly = .T.
        ENDWITH
        loc_oGrid.Column2.Header1.Caption = "Opera" + CHR(231) + CHR(227) + "o"
        loc_oGrid.Column2.ControlSource   = loc_cCursor + ".Operacaos"

        IF USED(loc_cCursor)
            loc_oGrid.RecordSource = loc_cCursor
            SELECT (loc_cCursor)
            GO TOP
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * BOParaForm - Sincroniza valores do BO com os controles de Page1
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE BOParaForm()
        LOCAL loc_oPagina, loc_oRel
        IF VARTYPE(THIS.this_oRelatorio) != "O"
            RETURN
        ENDIF
        IF !PEMSTATUS(THIS, "pgf_4c_Paginas", 5)
            RETURN
        ENDIF
        loc_oPagina = THIS.pgf_4c_Paginas.Page1
        loc_oRel    = THIS.this_oRelatorio

        IF PEMSTATUS(loc_oPagina, "opt_4c_NrTipo", 5)
            loc_oPagina.opt_4c_NrTipo.Value = loc_oRel.this_nNrTipo
        ENDIF
        IF PEMSTATUS(loc_oPagina, "txt_4c_DtInicial", 5)
            loc_oPagina.txt_4c_DtInicial.Value = loc_oRel.this_dDtInicial
        ENDIF
        IF PEMSTATUS(loc_oPagina, "txt_4c_DtFinal", 5)
            loc_oPagina.txt_4c_DtFinal.Value = loc_oRel.this_dDtFinal
        ENDIF
        IF PEMSTATUS(loc_oPagina, "chk_4c_ImpFollow", 5)
            loc_oPagina.chk_4c_ImpFollow.Value = IIF(loc_oRel.this_lImpFollow, 1, 0)
        ENDIF
        IF PEMSTATUS(loc_oPagina, "cbo_4c_Ordem", 5)
            loc_oPagina.cbo_4c_Ordem.ListIndex = loc_oRel.this_nOrdemIdx
        ENDIF
        IF PEMSTATUS(loc_oPagina, "opt_4c_NrOpcao", 5)
            loc_oPagina.opt_4c_NrOpcao.Value = loc_oRel.this_nNrOpcao
        ENDIF
        IF PEMSTATUS(loc_oPagina, "txt_4c_CdEmpresa", 5)
            loc_oPagina.txt_4c_CdEmpresa.Value = loc_oRel.this_cCdEmpresa
        ENDIF
        IF PEMSTATUS(loc_oPagina, "txt_4c_DsEmpresa", 5)
            loc_oPagina.txt_4c_DsEmpresa.Value = loc_oRel.this_cDsEmpresa
        ENDIF
        IF PEMSTATUS(loc_oPagina, "txt_4c_CdDesGrupo", 5)
            loc_oPagina.txt_4c_CdDesGrupo.Value = loc_oRel.this_cCdDesGrupo
        ENDIF
        IF PEMSTATUS(loc_oPagina, "txt_4c_DsDesGrupo", 5)
            loc_oPagina.txt_4c_DsDesGrupo.Value = loc_oRel.this_cDsDesGrupo
        ENDIF
        IF PEMSTATUS(loc_oPagina, "txt_4c_CdDesConta", 5)
            loc_oPagina.txt_4c_CdDesConta.Value = loc_oRel.this_cCdDesConta
        ENDIF
        IF PEMSTATUS(loc_oPagina, "txt_4c_DsDesConta", 5)
            loc_oPagina.txt_4c_DsDesConta.Value = loc_oRel.this_cDsDesConta
        ENDIF
        IF PEMSTATUS(loc_oPagina, "txt_4c_CdEmiGrupo", 5)
            loc_oPagina.txt_4c_CdEmiGrupo.Value = loc_oRel.this_cCdEmiGrupo
        ENDIF
        IF PEMSTATUS(loc_oPagina, "txt_4c_DsEmiGrupo", 5)
            loc_oPagina.txt_4c_DsEmiGrupo.Value = loc_oRel.this_cDsEmiGrupo
        ENDIF
        IF PEMSTATUS(loc_oPagina, "txt_4c_CdEmiConta", 5)
            loc_oPagina.txt_4c_CdEmiConta.Value = loc_oRel.this_cCdEmiConta
        ENDIF
        IF PEMSTATUS(loc_oPagina, "txt_4c_DsEmiConta", 5)
            loc_oPagina.txt_4c_DsEmiConta.Value = loc_oRel.this_cDsEmiConta
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * SelecionarTodosClick - Marca Flag=.T. em todas as operacoes
    * Equivalente ao Command3.Click do original
    *--------------------------------------------------------------------------
    PROCEDURE SelecionarTodosClick()
        LOCAL loc_cCursor, loc_nRecno
        IF VARTYPE(THIS.this_oRelatorio) != "O"
            RETURN
        ENDIF
        loc_cCursor = THIS.this_oRelatorio.this_cCursorOperacoes
        IF !USED(loc_cCursor)
            RETURN
        ENDIF
        TRY
            SELECT (loc_cCursor)
            loc_nRecno = RECNO()
            REPLACE ALL Flag WITH .T. IN (loc_cCursor)
            IF BETWEEN(loc_nRecno, 1, RECCOUNT(loc_cCursor))
                GOTO loc_nRecno IN (loc_cCursor)
            ENDIF
            IF PEMSTATUS(THIS.pgf_4c_Paginas.Page1, "grd_4c_Opera", 5)
                THIS.pgf_4c_Paginas.Page1.grd_4c_Opera.Refresh()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Formsigrechp.SelecionarTodosClick")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * DeselecionarTodosClick - Marca Flag=.F. em todas as operacoes
    * Equivalente ao Command4.Click do original
    *--------------------------------------------------------------------------
    PROCEDURE DeselecionarTodosClick()
        LOCAL loc_cCursor, loc_nRecno
        IF VARTYPE(THIS.this_oRelatorio) != "O"
            RETURN
        ENDIF
        loc_cCursor = THIS.this_oRelatorio.this_cCursorOperacoes
        IF !USED(loc_cCursor)
            RETURN
        ENDIF
        TRY
            SELECT (loc_cCursor)
            loc_nRecno = RECNO()
            REPLACE ALL Flag WITH .F. IN (loc_cCursor)
            IF BETWEEN(loc_nRecno, 1, RECCOUNT(loc_cCursor))
                GOTO loc_nRecno IN (loc_cCursor)
            ENDIF
            IF PEMSTATUS(THIS.pgf_4c_Paginas.Page1, "grd_4c_Opera", 5)
                THIS.pgf_4c_Paginas.Page1.grd_4c_Opera.Refresh()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Formsigrechp.DeselecionarTodosClick")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * TeclaEmpresaCd/Ds - KeyPress handlers para campos de Empresa
    * F4(115)/ENTER(13)/TAB(9) disparam validacao/lookup
    *--------------------------------------------------------------------------
    PROCEDURE TeclaEmpresaCd(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 13 OR par_nKeyCode = 9 OR par_nKeyCode = 115
            THIS.AbrirLookupEmpresa()
        ELSE
            IF par_nKeyCode = 13 OR par_nKeyCode = 9
            THIS.ValidarCdEmpresa()
            ENDIF
        ENDIF
    ENDPROC

    PROCEDURE TeclaEmpresaDs(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 13 OR par_nKeyCode = 9 OR par_nKeyCode = 115
            THIS.AbrirLookupEmpresa()
        ELSE
            IF par_nKeyCode = 13 OR par_nKeyCode = 9
            THIS.ValidarDsEmpresa()
            ENDIF
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarCdEmpresa - Valida codigo empresa em SigCdEmp; preenche Razas
    * SigCdEmp: cEmps (codigo), Razas (razao social)
    *--------------------------------------------------------------------------
    PROCEDURE ValidarCdEmpresa()
        LOCAL loc_cCod, loc_cSql, loc_nResult, loc_oPagina
        IF !PEMSTATUS(THIS, "pgf_4c_Paginas", 5)
            RETURN
        ENDIF
        loc_oPagina = THIS.pgf_4c_Paginas.Page1
        IF !PEMSTATUS(loc_oPagina, "txt_4c_CdEmpresa", 5)
            RETURN
        ENDIF
        loc_cCod = ALLTRIM(loc_oPagina.txt_4c_CdEmpresa.Value)
        IF EMPTY(loc_cCod)
            IF PEMSTATUS(loc_oPagina, "txt_4c_DsEmpresa", 5)
                loc_oPagina.txt_4c_DsEmpresa.Value = ""
            ENDIF
            RETURN
        ENDIF
        TRY
            IF USED("cursor_4c_EmpVal")
                USE IN cursor_4c_EmpVal
            ENDIF
            loc_cSql    = "SELECT TOP 1 Razas FROM SigCdEmp WHERE cEmps = " + ;
                          EscaparSQL(loc_cCod)
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSql, "cursor_4c_EmpVal")
            IF loc_nResult > 0
                SELECT cursor_4c_EmpVal
                IF !EOF()
                    IF PEMSTATUS(loc_oPagina, "txt_4c_DsEmpresa", 5)
                        loc_oPagina.txt_4c_DsEmpresa.Value = ALLTRIM(cursor_4c_EmpVal.Razas)
                    ENDIF
                ELSE
                    MsgAviso("Empresa " + CHR(39) + loc_cCod + CHR(39) + ;
                             " n" + CHR(227) + "o encontrada.", "Empresa")
                    loc_oPagina.txt_4c_CdEmpresa.Value = ""
                    IF PEMSTATUS(loc_oPagina, "txt_4c_DsEmpresa", 5)
                        loc_oPagina.txt_4c_DsEmpresa.Value = ""
                    ENDIF
                ENDIF
                USE IN cursor_4c_EmpVal
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Formsigrechp.ValidarCdEmpresa")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarDsEmpresa - Busca empresa por Razas; preenche cEmps
    *--------------------------------------------------------------------------
    PROCEDURE ValidarDsEmpresa()
        LOCAL loc_cDesc, loc_cSql, loc_nResult, loc_oPagina
        IF !PEMSTATUS(THIS, "pgf_4c_Paginas", 5)
            RETURN
        ENDIF
        loc_oPagina = THIS.pgf_4c_Paginas.Page1
        IF !PEMSTATUS(loc_oPagina, "txt_4c_DsEmpresa", 5)
            RETURN
        ENDIF
        loc_cDesc = ALLTRIM(loc_oPagina.txt_4c_DsEmpresa.Value)
        IF EMPTY(loc_cDesc)
            IF PEMSTATUS(loc_oPagina, "txt_4c_CdEmpresa", 5)
                loc_oPagina.txt_4c_CdEmpresa.Value = ""
            ENDIF
            RETURN
        ENDIF
        TRY
            IF USED("cursor_4c_EmpVal")
                USE IN cursor_4c_EmpVal
            ENDIF
            loc_cSql    = "SELECT TOP 1 cEmps, Razas FROM SigCdEmp " + ;
                          "WHERE Razas LIKE " + EscaparSQL(loc_cDesc + "%") + ;
                          " ORDER BY cEmps"
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSql, "cursor_4c_EmpVal")
            IF loc_nResult > 0
                SELECT cursor_4c_EmpVal
                IF !EOF()
                    IF PEMSTATUS(loc_oPagina, "txt_4c_CdEmpresa", 5)
                        loc_oPagina.txt_4c_CdEmpresa.Value = ALLTRIM(cursor_4c_EmpVal.cEmps)
                    ENDIF
                    loc_oPagina.txt_4c_DsEmpresa.Value = ALLTRIM(cursor_4c_EmpVal.Razas)
                ENDIF
                USE IN cursor_4c_EmpVal
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Formsigrechp.ValidarDsEmpresa")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * TeclaDesGrupoCd/Ds - KeyPress handlers para Grupo Destino
    *--------------------------------------------------------------------------
    PROCEDURE TeclaDesGrupoCd(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 13 OR par_nKeyCode = 9 OR par_nKeyCode = 115
            THIS.AbrirLookupDesGrupo()
        ELSE
            IF par_nKeyCode = 13 OR par_nKeyCode = 9
            THIS.ValidarCdDesGrupo()
            ENDIF
        ENDIF
    ENDPROC

    PROCEDURE TeclaDesGrupoDs(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 13 OR par_nKeyCode = 9 OR par_nKeyCode = 115
            THIS.AbrirLookupDesGrupo()
        ELSE
            IF par_nKeyCode = 13 OR par_nKeyCode = 9
            THIS.ValidarDsDesGrupo()
            ENDIF
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarCdDesGrupo - Valida codigo grupo destino em SigCdGcr; preenche desc
    * Ao limpar codigo: limpa desc + conta destino associada
    *--------------------------------------------------------------------------
    PROCEDURE ValidarCdDesGrupo()
        LOCAL loc_cCod, loc_cSql, loc_nResult, loc_oPagina
        IF !PEMSTATUS(THIS, "pgf_4c_Paginas", 5)
            RETURN
        ENDIF
        loc_oPagina = THIS.pgf_4c_Paginas.Page1
        IF !PEMSTATUS(loc_oPagina, "txt_4c_CdDesGrupo", 5)
            RETURN
        ENDIF
        loc_cCod = ALLTRIM(loc_oPagina.txt_4c_CdDesGrupo.Value)
        IF EMPTY(loc_cCod)
            IF PEMSTATUS(loc_oPagina, "txt_4c_DsDesGrupo", 5)
                loc_oPagina.txt_4c_DsDesGrupo.Value = ""
            ENDIF
            IF PEMSTATUS(loc_oPagina, "txt_4c_CdDesConta", 5)
                loc_oPagina.txt_4c_CdDesConta.Value = ""
            ENDIF
            IF PEMSTATUS(loc_oPagina, "txt_4c_DsDesConta", 5)
                loc_oPagina.txt_4c_DsDesConta.Value = ""
            ENDIF
            RETURN
        ENDIF
        TRY
            IF USED("cursor_4c_GrpDesVal")
                USE IN cursor_4c_GrpDesVal
            ENDIF
            loc_cSql    = "SELECT TOP 1 Codigos, Descrs FROM SigCdGcr WHERE Codigos = " + ;
                          EscaparSQL(loc_cCod)
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSql, "cursor_4c_GrpDesVal")
            IF loc_nResult > 0
                SELECT cursor_4c_GrpDesVal
                IF !EOF()
                    IF PEMSTATUS(loc_oPagina, "txt_4c_DsDesGrupo", 5)
                        loc_oPagina.txt_4c_DsDesGrupo.Value = ALLTRIM(cursor_4c_GrpDesVal.Descrs)
                    ENDIF
                ELSE
                    MsgAviso("Grupo " + CHR(39) + loc_cCod + CHR(39) + ;
                             " n" + CHR(227) + "o encontrado.", "Grupo/Destino")
                    loc_oPagina.txt_4c_CdDesGrupo.Value = ""
                    IF PEMSTATUS(loc_oPagina, "txt_4c_DsDesGrupo", 5)
                        loc_oPagina.txt_4c_DsDesGrupo.Value = ""
                    ENDIF
                    IF PEMSTATUS(loc_oPagina, "txt_4c_CdDesConta", 5)
                        loc_oPagina.txt_4c_CdDesConta.Value = ""
                    ENDIF
                    IF PEMSTATUS(loc_oPagina, "txt_4c_DsDesConta", 5)
                        loc_oPagina.txt_4c_DsDesConta.Value = ""
                    ENDIF
                ENDIF
                USE IN cursor_4c_GrpDesVal
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Formsigrechp.ValidarCdDesGrupo")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarDsDesGrupo - Busca grupo destino por Descrs em SigCdGcr
    *--------------------------------------------------------------------------
    PROCEDURE ValidarDsDesGrupo()
        LOCAL loc_cDesc, loc_cSql, loc_nResult, loc_oPagina
        IF !PEMSTATUS(THIS, "pgf_4c_Paginas", 5)
            RETURN
        ENDIF
        loc_oPagina = THIS.pgf_4c_Paginas.Page1
        IF !PEMSTATUS(loc_oPagina, "txt_4c_DsDesGrupo", 5)
            RETURN
        ENDIF
        loc_cDesc = ALLTRIM(loc_oPagina.txt_4c_DsDesGrupo.Value)
        IF EMPTY(loc_cDesc)
            IF PEMSTATUS(loc_oPagina, "txt_4c_CdDesGrupo", 5)
                loc_oPagina.txt_4c_CdDesGrupo.Value = ""
            ENDIF
            RETURN
        ENDIF
        TRY
            IF USED("cursor_4c_GrpDesVal")
                USE IN cursor_4c_GrpDesVal
            ENDIF
            loc_cSql    = "SELECT TOP 1 Codigos, Descrs FROM SigCdGcr " + ;
                          "WHERE Descrs LIKE " + EscaparSQL(loc_cDesc + "%") + ;
                          " ORDER BY Codigos"
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSql, "cursor_4c_GrpDesVal")
            IF loc_nResult > 0
                SELECT cursor_4c_GrpDesVal
                IF !EOF()
                    IF PEMSTATUS(loc_oPagina, "txt_4c_CdDesGrupo", 5)
                        loc_oPagina.txt_4c_CdDesGrupo.Value = ALLTRIM(cursor_4c_GrpDesVal.Codigos)
                    ENDIF
                    loc_oPagina.txt_4c_DsDesGrupo.Value = ALLTRIM(cursor_4c_GrpDesVal.Descrs)
                ENDIF
                USE IN cursor_4c_GrpDesVal
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Formsigrechp.ValidarDsDesGrupo")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * TeclaDesContaCd/Ds - KeyPress handlers para Conta Destino
    *--------------------------------------------------------------------------
    PROCEDURE TeclaDesContaCd(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 13 OR par_nKeyCode = 9 OR par_nKeyCode = 115
            THIS.AbrirLookupDesConta()
        ELSE
            IF par_nKeyCode = 13 OR par_nKeyCode = 9
            THIS.ValidarCdDesConta()
            ENDIF
        ENDIF
    ENDPROC

    PROCEDURE TeclaDesContaDs(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 13 OR par_nKeyCode = 9 OR par_nKeyCode = 115
            THIS.AbrirLookupDesConta()
        ELSE
            IF par_nKeyCode = 13 OR par_nKeyCode = 9
            THIS.ValidarDsDesConta()
            ENDIF
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarCdDesConta - Valida conta destino em SigCdCli (Iclis/rClis)
    * Original: fAcessoContas verifica conta; retorna .F. e limpa se invalida
    *--------------------------------------------------------------------------
    PROCEDURE ValidarCdDesConta()
        LOCAL loc_cCod, loc_cGrupo, loc_cSql, loc_nResult, loc_oPagina
        IF !PEMSTATUS(THIS, "pgf_4c_Paginas", 5)
            RETURN
        ENDIF
        loc_oPagina = THIS.pgf_4c_Paginas.Page1
        IF !PEMSTATUS(loc_oPagina, "txt_4c_CdDesConta", 5)
            RETURN
        ENDIF
        loc_cCod   = ALLTRIM(loc_oPagina.txt_4c_CdDesConta.Value)
        loc_cGrupo = IIF(PEMSTATUS(loc_oPagina, "txt_4c_CdDesGrupo", 5), ;
                         ALLTRIM(loc_oPagina.txt_4c_CdDesGrupo.Value), "")
        IF EMPTY(loc_cCod)
            IF PEMSTATUS(loc_oPagina, "txt_4c_DsDesConta", 5)
                loc_oPagina.txt_4c_DsDesConta.Value = ""
            ENDIF
            RETURN
        ENDIF
        TRY
            IF USED("cursor_4c_CliVal")
                USE IN cursor_4c_CliVal
            ENDIF
            loc_cSql = "SELECT TOP 1 rClis FROM SigCdCli WHERE Iclis = " + ;
                       EscaparSQL(loc_cCod)
            IF !EMPTY(loc_cGrupo)
                loc_cSql = loc_cSql + " AND grclis = " + EscaparSQL(loc_cGrupo)
            ENDIF
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSql, "cursor_4c_CliVal")
            IF loc_nResult > 0
                SELECT cursor_4c_CliVal
                IF !EOF()
                    IF PEMSTATUS(loc_oPagina, "txt_4c_DsDesConta", 5)
                        loc_oPagina.txt_4c_DsDesConta.Value = ALLTRIM(cursor_4c_CliVal.rClis)
                    ENDIF
                ELSE
                    MsgAviso("Conta " + CHR(39) + loc_cCod + CHR(39) + ;
                             " inv" + CHR(225) + "lida.", "Conta/Destino")
                    loc_oPagina.txt_4c_CdDesConta.Value = ""
                    IF PEMSTATUS(loc_oPagina, "txt_4c_DsDesConta", 5)
                        loc_oPagina.txt_4c_DsDesConta.Value = ""
                    ENDIF
                ENDIF
                USE IN cursor_4c_CliVal
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Formsigrechp.ValidarCdDesConta")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarDsDesConta - Busca conta destino por rClis em SigCdCli
    *--------------------------------------------------------------------------
    PROCEDURE ValidarDsDesConta()
        LOCAL loc_cDesc, loc_cGrupo, loc_cSql, loc_nResult, loc_oPagina
        IF !PEMSTATUS(THIS, "pgf_4c_Paginas", 5)
            RETURN
        ENDIF
        loc_oPagina = THIS.pgf_4c_Paginas.Page1
        IF !PEMSTATUS(loc_oPagina, "txt_4c_DsDesConta", 5)
            RETURN
        ENDIF
        loc_cDesc  = ALLTRIM(loc_oPagina.txt_4c_DsDesConta.Value)
        loc_cGrupo = IIF(PEMSTATUS(loc_oPagina, "txt_4c_CdDesGrupo", 5), ;
                         ALLTRIM(loc_oPagina.txt_4c_CdDesGrupo.Value), "")
        IF EMPTY(loc_cDesc)
            IF PEMSTATUS(loc_oPagina, "txt_4c_CdDesConta", 5)
                loc_oPagina.txt_4c_CdDesConta.Value = ""
            ENDIF
            RETURN
        ENDIF
        TRY
            IF USED("cursor_4c_CliVal")
                USE IN cursor_4c_CliVal
            ENDIF
            loc_cSql = "SELECT TOP 1 Iclis, rClis FROM SigCdCli " + ;
                       "WHERE rClis LIKE " + EscaparSQL(loc_cDesc + "%")
            IF !EMPTY(loc_cGrupo)
                loc_cSql = loc_cSql + " AND grclis = " + EscaparSQL(loc_cGrupo)
            ENDIF
            loc_cSql    = loc_cSql + " ORDER BY Iclis"
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSql, "cursor_4c_CliVal")
            IF loc_nResult > 0
                SELECT cursor_4c_CliVal
                IF !EOF()
                    IF PEMSTATUS(loc_oPagina, "txt_4c_CdDesConta", 5)
                        loc_oPagina.txt_4c_CdDesConta.Value = ALLTRIM(cursor_4c_CliVal.Iclis)
                    ENDIF
                    loc_oPagina.txt_4c_DsDesConta.Value = ALLTRIM(cursor_4c_CliVal.rClis)
                ENDIF
                USE IN cursor_4c_CliVal
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Formsigrechp.ValidarDsDesConta")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * TeclaEmiGrupoCd/Ds - KeyPress handlers para Grupo Emissor
    *--------------------------------------------------------------------------
    PROCEDURE TeclaEmiGrupoCd(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 13 OR par_nKeyCode = 9 OR par_nKeyCode = 115
            THIS.AbrirLookupEmiGrupo()
        ELSE
            IF par_nKeyCode = 13 OR par_nKeyCode = 9
            THIS.ValidarCdEmiGrupo()
            ENDIF
        ENDIF
    ENDPROC

    PROCEDURE TeclaEmiGrupoDs(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 13 OR par_nKeyCode = 9 OR par_nKeyCode = 115
            THIS.AbrirLookupEmiGrupo()
        ELSE
            IF par_nKeyCode = 13 OR par_nKeyCode = 9
            THIS.ValidarDsEmiGrupo()
            ENDIF
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarCdEmiGrupo - Valida codigo grupo emissor em SigCdGcr; preenche desc
    * Ao limpar codigo: limpa desc + conta emissor associada
    *--------------------------------------------------------------------------
    PROCEDURE ValidarCdEmiGrupo()
        LOCAL loc_cCod, loc_cSql, loc_nResult, loc_oPagina
        IF !PEMSTATUS(THIS, "pgf_4c_Paginas", 5)
            RETURN
        ENDIF
        loc_oPagina = THIS.pgf_4c_Paginas.Page1
        IF !PEMSTATUS(loc_oPagina, "txt_4c_CdEmiGrupo", 5)
            RETURN
        ENDIF
        loc_cCod = ALLTRIM(loc_oPagina.txt_4c_CdEmiGrupo.Value)
        IF EMPTY(loc_cCod)
            IF PEMSTATUS(loc_oPagina, "txt_4c_DsEmiGrupo", 5)
                loc_oPagina.txt_4c_DsEmiGrupo.Value = ""
            ENDIF
            IF PEMSTATUS(loc_oPagina, "txt_4c_CdEmiConta", 5)
                loc_oPagina.txt_4c_CdEmiConta.Value = ""
            ENDIF
            IF PEMSTATUS(loc_oPagina, "txt_4c_DsEmiConta", 5)
                loc_oPagina.txt_4c_DsEmiConta.Value = ""
            ENDIF
            RETURN
        ENDIF
        TRY
            IF USED("cursor_4c_GrpEmiVal")
                USE IN cursor_4c_GrpEmiVal
            ENDIF
            loc_cSql    = "SELECT TOP 1 Codigos, Descrs FROM SigCdGcr WHERE Codigos = " + ;
                          EscaparSQL(loc_cCod)
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSql, "cursor_4c_GrpEmiVal")
            IF loc_nResult > 0
                SELECT cursor_4c_GrpEmiVal
                IF !EOF()
                    IF PEMSTATUS(loc_oPagina, "txt_4c_DsEmiGrupo", 5)
                        loc_oPagina.txt_4c_DsEmiGrupo.Value = ALLTRIM(cursor_4c_GrpEmiVal.Descrs)
                    ENDIF
                ELSE
                    MsgAviso("Grupo " + CHR(39) + loc_cCod + CHR(39) + ;
                             " n" + CHR(227) + "o encontrado.", "Grupo/Emissor")
                    loc_oPagina.txt_4c_CdEmiGrupo.Value = ""
                    IF PEMSTATUS(loc_oPagina, "txt_4c_DsEmiGrupo", 5)
                        loc_oPagina.txt_4c_DsEmiGrupo.Value = ""
                    ENDIF
                    IF PEMSTATUS(loc_oPagina, "txt_4c_CdEmiConta", 5)
                        loc_oPagina.txt_4c_CdEmiConta.Value = ""
                    ENDIF
                    IF PEMSTATUS(loc_oPagina, "txt_4c_DsEmiConta", 5)
                        loc_oPagina.txt_4c_DsEmiConta.Value = ""
                    ENDIF
                ENDIF
                USE IN cursor_4c_GrpEmiVal
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Formsigrechp.ValidarCdEmiGrupo")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarDsEmiGrupo - Busca grupo emissor por Descrs em SigCdGcr
    *--------------------------------------------------------------------------
    PROCEDURE ValidarDsEmiGrupo()
        LOCAL loc_cDesc, loc_cSql, loc_nResult, loc_oPagina
        IF !PEMSTATUS(THIS, "pgf_4c_Paginas", 5)
            RETURN
        ENDIF
        loc_oPagina = THIS.pgf_4c_Paginas.Page1
        IF !PEMSTATUS(loc_oPagina, "txt_4c_DsEmiGrupo", 5)
            RETURN
        ENDIF
        loc_cDesc = ALLTRIM(loc_oPagina.txt_4c_DsEmiGrupo.Value)
        IF EMPTY(loc_cDesc)
            IF PEMSTATUS(loc_oPagina, "txt_4c_CdEmiGrupo", 5)
                loc_oPagina.txt_4c_CdEmiGrupo.Value = ""
            ENDIF
            RETURN
        ENDIF
        TRY
            IF USED("cursor_4c_GrpEmiVal")
                USE IN cursor_4c_GrpEmiVal
            ENDIF
            loc_cSql    = "SELECT TOP 1 Codigos, Descrs FROM SigCdGcr " + ;
                          "WHERE Descrs LIKE " + EscaparSQL(loc_cDesc + "%") + ;
                          " ORDER BY Codigos"
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSql, "cursor_4c_GrpEmiVal")
            IF loc_nResult > 0
                SELECT cursor_4c_GrpEmiVal
                IF !EOF()
                    IF PEMSTATUS(loc_oPagina, "txt_4c_CdEmiGrupo", 5)
                        loc_oPagina.txt_4c_CdEmiGrupo.Value = ALLTRIM(cursor_4c_GrpEmiVal.Codigos)
                    ENDIF
                    loc_oPagina.txt_4c_DsEmiGrupo.Value = ALLTRIM(cursor_4c_GrpEmiVal.Descrs)
                ENDIF
                USE IN cursor_4c_GrpEmiVal
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Formsigrechp.ValidarDsEmiGrupo")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * TeclaEmiContaCd/Ds - KeyPress handlers para Conta Emissor
    *--------------------------------------------------------------------------
    PROCEDURE TeclaEmiContaCd(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 13 OR par_nKeyCode = 9 OR par_nKeyCode = 115
            THIS.AbrirLookupEmiConta()
        ELSE
            IF par_nKeyCode = 13 OR par_nKeyCode = 9
            THIS.ValidarCdEmiConta()
            ENDIF
        ENDIF
    ENDPROC

    PROCEDURE TeclaEmiContaDs(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 13 OR par_nKeyCode = 9 OR par_nKeyCode = 115
            THIS.AbrirLookupEmiConta()
        ELSE
            IF par_nKeyCode = 13 OR par_nKeyCode = 9
            THIS.ValidarDsEmiConta()
            ENDIF
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarCdEmiConta - Valida conta emissor em SigCdCli (Iclis/rClis)
    * Original: fAcessoContas verifica conta; limpa e retorna .F. se invalida
    *--------------------------------------------------------------------------
    PROCEDURE ValidarCdEmiConta()
        LOCAL loc_cCod, loc_cGrupo, loc_cSql, loc_nResult, loc_oPagina
        IF !PEMSTATUS(THIS, "pgf_4c_Paginas", 5)
            RETURN
        ENDIF
        loc_oPagina = THIS.pgf_4c_Paginas.Page1
        IF !PEMSTATUS(loc_oPagina, "txt_4c_CdEmiConta", 5)
            RETURN
        ENDIF
        loc_cCod   = ALLTRIM(loc_oPagina.txt_4c_CdEmiConta.Value)
        loc_cGrupo = IIF(PEMSTATUS(loc_oPagina, "txt_4c_CdEmiGrupo", 5), ;
                         ALLTRIM(loc_oPagina.txt_4c_CdEmiGrupo.Value), "")
        IF EMPTY(loc_cCod)
            IF PEMSTATUS(loc_oPagina, "txt_4c_DsEmiConta", 5)
                loc_oPagina.txt_4c_DsEmiConta.Value = ""
            ENDIF
            RETURN
        ENDIF
        TRY
            IF USED("cursor_4c_EmiCliVal")
                USE IN cursor_4c_EmiCliVal
            ENDIF
            loc_cSql = "SELECT TOP 1 rClis FROM SigCdCli WHERE Iclis = " + ;
                       EscaparSQL(loc_cCod)
            IF !EMPTY(loc_cGrupo)
                loc_cSql = loc_cSql + " AND grclis = " + EscaparSQL(loc_cGrupo)
            ENDIF
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSql, "cursor_4c_EmiCliVal")
            IF loc_nResult > 0
                SELECT cursor_4c_EmiCliVal
                IF !EOF()
                    IF PEMSTATUS(loc_oPagina, "txt_4c_DsEmiConta", 5)
                        loc_oPagina.txt_4c_DsEmiConta.Value = ALLTRIM(cursor_4c_EmiCliVal.rClis)
                    ENDIF
                ELSE
                    MsgAviso("Conta " + CHR(39) + loc_cCod + CHR(39) + ;
                             " inv" + CHR(225) + "lida.", "Conta/Emissor")
                    loc_oPagina.txt_4c_CdEmiConta.Value = ""
                    IF PEMSTATUS(loc_oPagina, "txt_4c_DsEmiConta", 5)
                        loc_oPagina.txt_4c_DsEmiConta.Value = ""
                    ENDIF
                ENDIF
                USE IN cursor_4c_EmiCliVal
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Formsigrechp.ValidarCdEmiConta")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarDsEmiConta - Busca conta emissor por rClis em SigCdCli
    *--------------------------------------------------------------------------
    PROCEDURE ValidarDsEmiConta()
        LOCAL loc_cDesc, loc_cGrupo, loc_cSql, loc_nResult, loc_oPagina
        IF !PEMSTATUS(THIS, "pgf_4c_Paginas", 5)
            RETURN
        ENDIF
        loc_oPagina = THIS.pgf_4c_Paginas.Page1
        IF !PEMSTATUS(loc_oPagina, "txt_4c_DsEmiConta", 5)
            RETURN
        ENDIF
        loc_cDesc  = ALLTRIM(loc_oPagina.txt_4c_DsEmiConta.Value)
        loc_cGrupo = IIF(PEMSTATUS(loc_oPagina, "txt_4c_CdEmiGrupo", 5), ;
                         ALLTRIM(loc_oPagina.txt_4c_CdEmiGrupo.Value), "")
        IF EMPTY(loc_cDesc)
            IF PEMSTATUS(loc_oPagina, "txt_4c_CdEmiConta", 5)
                loc_oPagina.txt_4c_CdEmiConta.Value = ""
            ENDIF
            RETURN
        ENDIF
        TRY
            IF USED("cursor_4c_EmiCliVal")
                USE IN cursor_4c_EmiCliVal
            ENDIF
            loc_cSql = "SELECT TOP 1 Iclis, rClis FROM SigCdCli " + ;
                       "WHERE rClis LIKE " + EscaparSQL(loc_cDesc + "%")
            IF !EMPTY(loc_cGrupo)
                loc_cSql = loc_cSql + " AND grclis = " + EscaparSQL(loc_cGrupo)
            ENDIF
            loc_cSql    = loc_cSql + " ORDER BY Iclis"
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSql, "cursor_4c_EmiCliVal")
            IF loc_nResult > 0
                SELECT cursor_4c_EmiCliVal
                IF !EOF()
                    IF PEMSTATUS(loc_oPagina, "txt_4c_CdEmiConta", 5)
                        loc_oPagina.txt_4c_CdEmiConta.Value = ALLTRIM(cursor_4c_EmiCliVal.Iclis)
                    ENDIF
                    loc_oPagina.txt_4c_DsEmiConta.Value = ALLTRIM(cursor_4c_EmiCliVal.rClis)
                ENDIF
                USE IN cursor_4c_EmiCliVal
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Formsigrechp.ValidarDsEmiConta")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * AlternarPagina - Navega entre paginas do PageFrame
    * Para form REPORT: Page1=Filtros (pagina principal ativa)
    *--------------------------------------------------------------------------
    PROCEDURE AlternarPagina(par_nPagina)
        IF !PEMSTATUS(THIS, "pgf_4c_Paginas", 5)
            RETURN
        ENDIF
        IF par_nPagina >= 1 AND par_nPagina <= THIS.pgf_4c_Paginas.PageCount
            THIS.pgf_4c_Paginas.ActivePage = par_nPagina
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * AbrirLookupEmpresa - Abre FormBuscaAuxiliar para selecao de empresa (F4)
    * Tabela: SigCdEmp (cEmps=codigo, Razas=razao social)
    *--------------------------------------------------------------------------
    PROCEDURE AbrirLookupEmpresa()
        LOCAL loc_oBusca, loc_oPagina, loc_cCodAtual
        IF !PEMSTATUS(THIS, "pgf_4c_Paginas", 5)
            RETURN
        ENDIF
        loc_oPagina  = THIS.pgf_4c_Paginas.Page1
        loc_cCodAtual = IIF(PEMSTATUS(loc_oPagina, "txt_4c_CdEmpresa", 5), ;
                            ALLTRIM(loc_oPagina.txt_4c_CdEmpresa.Value), "")
        TRY
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigCdEmp", ;
                "cursor_4c_BuscaEmp", ;
                "cEmps", ;
                loc_cCodAtual, ;
                "Buscar Empresa")
            loc_oBusca.mAddColuna("cEmps", "", "C" + CHR(243) + "digo")
            loc_oBusca.mAddColuna("Razas", "", "Raz" + CHR(227) + "o Social")
            loc_oBusca.Show()
            IF loc_oBusca.this_lSelecionou
                IF USED("cursor_4c_BuscaEmp")
                    SELECT cursor_4c_BuscaEmp
                    IF PEMSTATUS(loc_oPagina, "txt_4c_CdEmpresa", 5)
                        loc_oPagina.txt_4c_CdEmpresa.Value = ALLTRIM(cursor_4c_BuscaEmp.cEmps)
                    ENDIF
                    IF PEMSTATUS(loc_oPagina, "txt_4c_DsEmpresa", 5)
                        loc_oPagina.txt_4c_DsEmpresa.Value = ALLTRIM(cursor_4c_BuscaEmp.Razas)
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Formsigrechp.AbrirLookupEmpresa")
        ENDTRY
        IF USED("cursor_4c_BuscaEmp")
            USE IN cursor_4c_BuscaEmp
        ENDIF
        IF VARTYPE(loc_oBusca) = "O"
            loc_oBusca = .NULL.
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * AbrirLookupDesGrupo - Abre FormBuscaAuxiliar para selecao de grupo destino (F4)
    * Tabela: SigCdGcr (Codigos=codigo, Descrs=descricao)
    * Ao selecionar: limpa conta destino (dependente do grupo)
    *--------------------------------------------------------------------------
    PROCEDURE AbrirLookupDesGrupo()
        LOCAL loc_oBusca, loc_oPagina, loc_cCodAtual
        IF !PEMSTATUS(THIS, "pgf_4c_Paginas", 5)
            RETURN
        ENDIF
        loc_oPagina   = THIS.pgf_4c_Paginas.Page1
        loc_cCodAtual = IIF(PEMSTATUS(loc_oPagina, "txt_4c_CdDesGrupo", 5), ;
                            ALLTRIM(loc_oPagina.txt_4c_CdDesGrupo.Value), "")
        TRY
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigCdGcr", ;
                "cursor_4c_BuscaDesGrp", ;
                "Codigos", ;
                loc_cCodAtual, ;
                "Buscar Grupo Destino")
            loc_oBusca.mAddColuna("Codigos", "", "C" + CHR(243) + "digo")
            loc_oBusca.mAddColuna("Descrs",  "", "Descri" + CHR(231) + CHR(227) + "o")
            loc_oBusca.Show()
            IF loc_oBusca.this_lSelecionou
                IF USED("cursor_4c_BuscaDesGrp")
                    SELECT cursor_4c_BuscaDesGrp
                    IF PEMSTATUS(loc_oPagina, "txt_4c_CdDesGrupo", 5)
                        loc_oPagina.txt_4c_CdDesGrupo.Value = ALLTRIM(cursor_4c_BuscaDesGrp.Codigos)
                    ENDIF
                    IF PEMSTATUS(loc_oPagina, "txt_4c_DsDesGrupo", 5)
                        loc_oPagina.txt_4c_DsDesGrupo.Value = ALLTRIM(cursor_4c_BuscaDesGrp.Descrs)
                    ENDIF
                    *-- Limpa conta destino pois depende do grupo
                    IF PEMSTATUS(loc_oPagina, "txt_4c_CdDesConta", 5)
                        loc_oPagina.txt_4c_CdDesConta.Value = ""
                    ENDIF
                    IF PEMSTATUS(loc_oPagina, "txt_4c_DsDesConta", 5)
                        loc_oPagina.txt_4c_DsDesConta.Value = ""
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Formsigrechp.AbrirLookupDesGrupo")
        ENDTRY
        IF USED("cursor_4c_BuscaDesGrp")
            USE IN cursor_4c_BuscaDesGrp
        ENDIF
        IF VARTYPE(loc_oBusca) = "O"
            loc_oBusca = .NULL.
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * AbrirLookupDesConta - Abre FormBuscaAuxiliar para selecao de conta destino (F4)
    * Tabela: SigCdCli (Iclis=codigo, rClis=nome), filtrado por grupo destino se informado
    *--------------------------------------------------------------------------
    PROCEDURE AbrirLookupDesConta()
        LOCAL loc_oBusca, loc_oPagina, loc_cCodAtual, loc_cGrupo, loc_cSQL
        IF !PEMSTATUS(THIS, "pgf_4c_Paginas", 5)
            RETURN
        ENDIF
        loc_oPagina   = THIS.pgf_4c_Paginas.Page1
        loc_cCodAtual = IIF(PEMSTATUS(loc_oPagina, "txt_4c_CdDesConta", 5), ;
                            ALLTRIM(loc_oPagina.txt_4c_CdDesConta.Value), "")
        loc_cGrupo    = IIF(PEMSTATUS(loc_oPagina, "txt_4c_CdDesGrupo", 5), ;
                            ALLTRIM(loc_oPagina.txt_4c_CdDesGrupo.Value), "")
        TRY
            IF EMPTY(loc_cGrupo)
                loc_cSQL = ""
            ELSE
                loc_cSQL = " WHERE grclis = " + EscaparSQL(loc_cGrupo)
            ENDIF
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigCdCli" + loc_cSQL, ;
                "cursor_4c_BuscaDesCli", ;
                "Iclis", ;
                loc_cCodAtual, ;
                "Buscar Conta Destino")
            loc_oBusca.mAddColuna("Iclis", "", "C" + CHR(243) + "digo")
            loc_oBusca.mAddColuna("rClis", "", "Nome")
            loc_oBusca.Show()
            IF loc_oBusca.this_lSelecionou
                IF USED("cursor_4c_BuscaDesCli")
                    SELECT cursor_4c_BuscaDesCli
                    IF PEMSTATUS(loc_oPagina, "txt_4c_CdDesConta", 5)
                        loc_oPagina.txt_4c_CdDesConta.Value = ALLTRIM(cursor_4c_BuscaDesCli.Iclis)
                    ENDIF
                    IF PEMSTATUS(loc_oPagina, "txt_4c_DsDesConta", 5)
                        loc_oPagina.txt_4c_DsDesConta.Value = ALLTRIM(cursor_4c_BuscaDesCli.rClis)
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Formsigrechp.AbrirLookupDesConta")
        ENDTRY
        IF USED("cursor_4c_BuscaDesCli")
            USE IN cursor_4c_BuscaDesCli
        ENDIF
        IF VARTYPE(loc_oBusca) = "O"
            loc_oBusca = .NULL.
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * AbrirLookupEmiGrupo - Abre FormBuscaAuxiliar para selecao de grupo emissor (F4)
    * Tabela: SigCdGcr (Codigos=codigo, Descrs=descricao)
    * Ao selecionar: limpa conta emissor (dependente do grupo)
    *--------------------------------------------------------------------------
    PROCEDURE AbrirLookupEmiGrupo()
        LOCAL loc_oBusca, loc_oPagina, loc_cCodAtual
        IF !PEMSTATUS(THIS, "pgf_4c_Paginas", 5)
            RETURN
        ENDIF
        loc_oPagina   = THIS.pgf_4c_Paginas.Page1
        loc_cCodAtual = IIF(PEMSTATUS(loc_oPagina, "txt_4c_CdEmiGrupo", 5), ;
                            ALLTRIM(loc_oPagina.txt_4c_CdEmiGrupo.Value), "")
        TRY
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigCdGcr", ;
                "cursor_4c_BuscaEmiGrp", ;
                "Codigos", ;
                loc_cCodAtual, ;
                "Buscar Grupo Emissor")
            loc_oBusca.mAddColuna("Codigos", "", "C" + CHR(243) + "digo")
            loc_oBusca.mAddColuna("Descrs",  "", "Descri" + CHR(231) + CHR(227) + "o")
            loc_oBusca.Show()
            IF loc_oBusca.this_lSelecionou
                IF USED("cursor_4c_BuscaEmiGrp")
                    SELECT cursor_4c_BuscaEmiGrp
                    IF PEMSTATUS(loc_oPagina, "txt_4c_CdEmiGrupo", 5)
                        loc_oPagina.txt_4c_CdEmiGrupo.Value = ALLTRIM(cursor_4c_BuscaEmiGrp.Codigos)
                    ENDIF
                    IF PEMSTATUS(loc_oPagina, "txt_4c_DsEmiGrupo", 5)
                        loc_oPagina.txt_4c_DsEmiGrupo.Value = ALLTRIM(cursor_4c_BuscaEmiGrp.Descrs)
                    ENDIF
                    *-- Limpa conta emissor pois depende do grupo
                    IF PEMSTATUS(loc_oPagina, "txt_4c_CdEmiConta", 5)
                        loc_oPagina.txt_4c_CdEmiConta.Value = ""
                    ENDIF
                    IF PEMSTATUS(loc_oPagina, "txt_4c_DsEmiConta", 5)
                        loc_oPagina.txt_4c_DsEmiConta.Value = ""
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Formsigrechp.AbrirLookupEmiGrupo")
        ENDTRY
        IF USED("cursor_4c_BuscaEmiGrp")
            USE IN cursor_4c_BuscaEmiGrp
        ENDIF
        IF VARTYPE(loc_oBusca) = "O"
            loc_oBusca = .NULL.
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnIncluirClick - Evento CRUD compatibilidade pipeline: para form REPORT
    *   equivale a Imprimir (gerar copia fisica do relatorio)
    *--------------------------------------------------------------------------
    PROCEDURE BtnIncluirClick()
        THIS.BtnImprimirClick()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnAlterarClick - Evento CRUD compatibilidade pipeline: para form REPORT
    *   equivale a Visualizar (preview do relatorio na tela)
    *--------------------------------------------------------------------------
    PROCEDURE BtnAlterarClick()
        THIS.BtnVisualizarClick()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnExcluirClick - Evento CRUD compatibilidade pipeline: para form REPORT
    *   equivale a Encerrar (nao ha exclusao em relatorios)
    *--------------------------------------------------------------------------
    PROCEDURE BtnExcluirClick()
        THIS.BtnSairClick()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnBuscarClick - Compatibilidade pipeline CRUD: para form REPORT equivale a Visualizar
    *--------------------------------------------------------------------------
    PROCEDURE BtnBuscarClick()
        THIS.BtnVisualizarClick()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnEncerrarClick - Fecha o formulario
    *--------------------------------------------------------------------------
    PROCEDURE BtnEncerrarClick()
        THIS.Release()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnSalvarClick - Compatibilidade pipeline CRUD: para form REPORT equivale a Imprimir
    *--------------------------------------------------------------------------
    PROCEDURE BtnSalvarClick()
        THIS.BtnImprimirClick()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnCancelarClick - Fecha o formulario (cancelar = encerrar em form REPORT)
    *--------------------------------------------------------------------------
    PROCEDURE BtnCancelarClick()
        THIS.Release()
    ENDPROC

    *--------------------------------------------------------------------------
    * FormParaBO - Alias canonico de FormParaRelatorio para compatibilidade com
    *   o pipeline de migracao (que espera o nome FormParaBO em forms CRUD).
    *   Em forms REPORT (frmrelatorio) o "BO" eh o objeto de relatorio. Delega
    *   para FormParaRelatorio, que ja transfere TODOS os valores dos controles
    *   de filtro para as propriedades this_* do BO de relatorio.
    *--------------------------------------------------------------------------
    PROCEDURE FormParaBO()
        THIS.FormParaRelatorio()
    ENDPROC

    *--------------------------------------------------------------------------
    * HabilitarCampos - Em form REPORT todos os campos de filtro ficam sempre
    *   habilitados (nao ha modos INCLUIR/ALTERAR/VISUALIZAR). Implementacao
    *   funcional: itera os controles editaveis de Page1 e aplica Enabled =
    *   par_lHabilitar. Garante consistencia visual e atende ao contrato do
    *   pipeline de validacao automatica.
    *--------------------------------------------------------------------------
    PROCEDURE HabilitarCampos(par_lHabilitar)
        LOCAL loc_lHab, loc_oPag, loc_aNomes, loc_nI, loc_cNome
        IF !PEMSTATUS(THIS, "pgf_4c_Paginas", 5)
            RETURN
        ENDIF
        loc_lHab = IIF(VARTYPE(par_lHabilitar) = "L", par_lHabilitar, .T.)
        loc_oPag = THIS.pgf_4c_Paginas.Page1
        DIMENSION loc_aNomes(20)
        loc_aNomes(1)  = "opt_4c_NrTipo"
        loc_aNomes(2)  = "txt_4c_DtInicial"
        loc_aNomes(3)  = "txt_4c_DtFinal"
        loc_aNomes(4)  = "chk_4c_ImpFollow"
        loc_aNomes(5)  = "cbo_4c_Ordem"
        loc_aNomes(6)  = "opt_4c_NrOpcao"
        loc_aNomes(7)  = "txt_4c_CdEmpresa"
        loc_aNomes(8)  = "txt_4c_DsEmpresa"
        loc_aNomes(9)  = "txt_4c_CdDesGrupo"
        loc_aNomes(10) = "txt_4c_DsDesGrupo"
        loc_aNomes(11) = "txt_4c_CdDesConta"
        loc_aNomes(12) = "txt_4c_DsDesConta"
        loc_aNomes(13) = "txt_4c_CdEmiGrupo"
        loc_aNomes(14) = "txt_4c_DsEmiGrupo"
        loc_aNomes(15) = "txt_4c_CdEmiConta"
        loc_aNomes(16) = "txt_4c_DsEmiConta"
        loc_aNomes(17) = "grd_4c_Opera"
        loc_aNomes(18) = "cmd_4c_SelecionarTodos"
        loc_aNomes(19) = "cmd_4c_DeselecionarTodos"
        loc_aNomes(20) = ""
        FOR loc_nI = 1 TO 20
            loc_cNome = loc_aNomes(loc_nI)
            IF !EMPTY(loc_cNome) AND PEMSTATUS(loc_oPag, loc_cNome, 5)
                EVALUATE("loc_oPag." + loc_cNome + ".Enabled = loc_lHab")
            ENDIF
        ENDFOR
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarLista - Em form REPORT nao existe grid CRUD de lista. Recarrega
    *   o cursor de operacoes (usado pelo grid de selecao em Page1) e retorna
    *   .T. para compatibilidade com o pipeline de validacao automatica.
    *--------------------------------------------------------------------------
    PROCEDURE CarregarLista()
        LOCAL loc_lOk
        loc_lOk = .T.
        IF VARTYPE(THIS.this_oRelatorio) = "O"
            TRY
                loc_lOk = THIS.this_oRelatorio.CarregarOperacoes()
                IF loc_lOk AND PEMSTATUS(THIS, "pgf_4c_Paginas", 5)
                    IF PEMSTATUS(THIS.pgf_4c_Paginas.Page1, "grd_4c_Opera", 5)
                        THIS.pgf_4c_Paginas.Page1.grd_4c_Opera.Refresh()
                    ENDIF
                ENDIF
            CATCH TO loc_oErro
                MsgErro(loc_oErro.Message, "Formsigrechp.CarregarLista")
                loc_lOk = .F.
            ENDTRY
        ENDIF
        RETURN loc_lOk
    ENDPROC

    *--------------------------------------------------------------------------
    * AjustarBotoesPorModo - Em form REPORT nao existem modos INCLUIR/ALTERAR/
    *   VISUALIZAR; os botoes Visualizar/Imprimir/Excel/Encerrar ficam sempre
    *   habilitados. Implementacao funcional: garante .Enabled = .T. em todos
    *   os Buttons() do CommandGroup principal cmg_4c_Botoes apos qualquer
    *   alteracao de estado (atende ao contrato do pipeline de migracao).
    *--------------------------------------------------------------------------
    PROCEDURE AjustarBotoesPorModo()
        LOCAL loc_nI, loc_nQtde
        IF !PEMSTATUS(THIS, "cmg_4c_Botoes", 5)
            RETURN
        ENDIF
        loc_nQtde = THIS.cmg_4c_Botoes.ButtonCount
        FOR loc_nI = 1 TO loc_nQtde
            THIS.cmg_4c_Botoes.Buttons(loc_nI).Enabled = .T.
        ENDFOR
    ENDPROC

    *--------------------------------------------------------------------------
    * AbrirLookupEmiConta - Abre FormBuscaAuxiliar para selecao de conta emissor (F4)
    * Tabela: SigCdCli (Iclis=codigo, rClis=nome), filtrado por grupo emissor se informado
    *--------------------------------------------------------------------------
    PROCEDURE AbrirLookupEmiConta()
        LOCAL loc_oBusca, loc_oPagina, loc_cCodAtual, loc_cGrupo, loc_cSQL
        IF !PEMSTATUS(THIS, "pgf_4c_Paginas", 5)
            RETURN
        ENDIF
        loc_oPagina   = THIS.pgf_4c_Paginas.Page1
        loc_cCodAtual = IIF(PEMSTATUS(loc_oPagina, "txt_4c_CdEmiConta", 5), ;
                            ALLTRIM(loc_oPagina.txt_4c_CdEmiConta.Value), "")
        loc_cGrupo    = IIF(PEMSTATUS(loc_oPagina, "txt_4c_CdEmiGrupo", 5), ;
                            ALLTRIM(loc_oPagina.txt_4c_CdEmiGrupo.Value), "")
        TRY
            IF EMPTY(loc_cGrupo)
                loc_cSQL = ""
            ELSE
                loc_cSQL = " WHERE grclis = " + EscaparSQL(loc_cGrupo)
            ENDIF
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigCdCli" + loc_cSQL, ;
                "cursor_4c_BuscaEmiCli", ;
                "Iclis", ;
                loc_cCodAtual, ;
                "Buscar Conta Emissor")
            loc_oBusca.mAddColuna("Iclis", "", "C" + CHR(243) + "digo")
            loc_oBusca.mAddColuna("rClis", "", "Nome")
            loc_oBusca.Show()
            IF loc_oBusca.this_lSelecionou
                IF USED("cursor_4c_BuscaEmiCli")
                    SELECT cursor_4c_BuscaEmiCli
                    IF PEMSTATUS(loc_oPagina, "txt_4c_CdEmiConta", 5)
                        loc_oPagina.txt_4c_CdEmiConta.Value = ALLTRIM(cursor_4c_BuscaEmiCli.Iclis)
                    ENDIF
                    IF PEMSTATUS(loc_oPagina, "txt_4c_DsEmiConta", 5)
                        loc_oPagina.txt_4c_DsEmiConta.Value = ALLTRIM(cursor_4c_BuscaEmiCli.rClis)
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Formsigrechp.AbrirLookupEmiConta")
        ENDTRY
        IF USED("cursor_4c_BuscaEmiCli")
            USE IN cursor_4c_BuscaEmiCli
        ENDIF
        IF VARTYPE(loc_oBusca) = "O"
            loc_oBusca = .NULL.
        ENDIF
    ENDPROC

ENDDEFINE


### BO (C:\4c\projeto\app\classes\sigrechpBO.prg):
*==============================================================================
* SIGRECHPBO.PRG
* Business Object: Relatorio de Cheques Pendentes
*
* Herda de: RelatorioBase
* Tipo: REPORT
* Tabela principal: SigCqChm + SigChe (join)
* FRX: SigReChp.frx
*==============================================================================

DEFINE CLASS sigrechpBO AS RelatorioBase

    *-- Filtro: tipo de data (1=Data Vencimento, 2=Data Operacao)
    this_nNrTipo            = 1

    *-- Filtro: periodo
    this_dDtInicial         = {}
    this_dDtFinal           = {}

    *-- Filtro: empresa
    this_cCdEmpresa         = ""
    this_cDsEmpresa         = ""

    *-- Filtro: opcao de nota (1=Sim/com nota, 2=Nao/sem nota, 3=Ambos)
    this_nNrOpcao           = 3

    *-- Filtro: emissor - grupo contabil
    this_cCdEmiGrupo        = ""
    this_cDsEmiGrupo        = ""

    *-- Filtro: emissor - conta contabil
    this_cCdEmiConta        = ""
    this_cDsEmiConta        = ""

    *-- Filtro: destino - grupo contabil
    this_cCdDesGrupo        = ""
    this_cDsDesGrupo        = ""

    *-- Filtro: destino - conta contabil
    this_cCdDesConta        = ""
    this_cDsDesConta        = ""

    *-- Filtro: ordem de classificacao e index selecionado
    this_cNmOrdem           = ""
    this_nOrdemIdx          = 1

    *-- Filtro: imprimir follow-up
    this_lImpFollow         = .F.

    *-- Captions dinamicos do opt_nr_opcao (carregados de SigCdPac)
    this_cCapOpcao1         = ""
    this_cCapOpcao2         = ""
    this_cCapOpcao3         = ""

    *-- Cursores de trabalho
    this_cCursorOperacoes   = "cursor_4c_Operacoes"
    this_cCursorTemp        = "cursor_4c_Temp"

    *-- Variaveis de cabecalho do relatorio
    this_cNomeEmpresa       = ""
    this_cTitulo            = ""
    this_cPeriodo           = ""
    this_cEmissor           = ""
    this_cDestino           = ""

    *-- Caminho do arquivo FRX
    this_cArquivoRelatorio  = ""

    *--------------------------------------------------------------------------
    * Init - Configura propriedades basicas do BO de relatorio
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            THIS.this_cTabela          = ""
            THIS.this_cCampoChave      = ""
            THIS.this_cArquivoRelatorio = gc_4c_CaminhoReports + "SigReChp.frx"
            THIS.this_dDtInicial       = DATE()
            THIS.this_dDtFinal         = DATE()
            THIS.this_nNrTipo          = 1
            THIS.this_nNrOpcao         = 3
            THIS.this_nOrdemIdx        = 1
            THIS.this_cTitulo          = "Relat" + CHR(243) + "rio de Cheques Pendentes"
            THIS.this_cCapOpcao1       = "Sim"
            THIS.this_cCapOpcao2       = "N" + CHR(227) + "o"
            THIS.this_cCapOpcao3       = "Ambos"
            loc_lSucesso               = DODEFAULT()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "sigrechpBO.Init")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterMensagemErro - Retorna mensagem de erro do ultimo processamento
    *--------------------------------------------------------------------------
    PROCEDURE ObterMensagemErro()
        RETURN THIS.this_cMensagemErro
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarParametros - Carrega captions do opt_nr_opcao de SigCdPac
    * Chamado pelo Form em InicializarForm()
    *--------------------------------------------------------------------------
    PROCEDURE CarregarParametros()
        LOCAL loc_lSucesso, loc_nResult, loc_cSql
        loc_lSucesso = .F.
        TRY
            loc_cSql = "SELECT TitOpcS, TitOpcN, TitOpcA FROM SigCdPac"
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSql, "cursor_4c_Pac")
            IF loc_nResult > 0
                SELECT cursor_4c_Pac
                GO TOP
                IF !EOF()
                    THIS.this_cCapOpcao1 = IIF(!EMPTY(ALLTRIM(cursor_4c_Pac.TitOpcS)), ;
                        ALLTRIM(cursor_4c_Pac.TitOpcS), "Sim")
                    THIS.this_cCapOpcao2 = IIF(!EMPTY(ALLTRIM(cursor_4c_Pac.TitOpcN)), ;
                        ALLTRIM(cursor_4c_Pac.TitOpcN), "N" + CHR(227) + "o")
                    THIS.this_cCapOpcao3 = IIF(!EMPTY(ALLTRIM(cursor_4c_Pac.TitOpcA)), ;
                        ALLTRIM(cursor_4c_Pac.TitOpcA), "Ambos")
                ENDIF
                IF USED("cursor_4c_Pac")
                    USE IN cursor_4c_Pac
                ENDIF
            ENDIF
            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "sigrechpBO.CarregarParametros")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarOperacoes - Carrega operacoes DB/TR de SigCdOpt
    * Cria cursor_4c_Operacoes com Flag (L) e Operacaos (C15)
    * Chamado pelo Form em InicializarForm() para popular o grid
    *--------------------------------------------------------------------------
    PROCEDURE CarregarOperacoes()
        LOCAL loc_lSucesso, loc_nResult, loc_cSql, loc_cOpc
        loc_lSucesso = .F.
        TRY
            IF USED(THIS.this_cCursorOperacoes)
                USE IN (THIS.this_cCursorOperacoes)
            ENDIF

            CREATE CURSOR (THIS.this_cCursorOperacoes) (Flag L, Operacaos C(15))

            loc_cSql = "SELECT Operacaos FROM SigCdOpt " + ;
                       "WHERE Tipos = 'DB' OR Tipos = 'TR' " + ;
                       "ORDER BY Operacaos"
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSql, "cursor_4c_OpcLoad")
            IF loc_nResult < 0
                THIS.this_cMensagemErro = "Erro ao carregar opera" + CHR(231) + CHR(245) + ;
                                          "es de SigCdOpt"
                loc_lSucesso = .F.
            ENDIF

            SELECT cursor_4c_OpcLoad
            SCAN
                loc_cOpc = ALLTRIM(Operacaos)
                INSERT INTO (THIS.this_cCursorOperacoes) (Flag, Operacaos) ;
                    VALUES (.F., loc_cOpc)
            ENDSCAN

            IF USED("cursor_4c_OpcLoad")
                USE IN cursor_4c_OpcLoad
            ENDIF

            SELECT (THIS.this_cCursorOperacoes)
            GO TOP
            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "sigrechpBO.CarregarOperacoes")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * PrepararDados - Monta SQL com filtros e popula CsRelatorio para impressao
    * Chamado por Imprimir() e Visualizar()
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE PrepararDados()
        LOCAL loc_lSucesso, loc_nResult, loc_cSql, loc_nFlagadas
        LOCAL loc_cVerData, loc_cVerEmpresa, loc_cVerOpcao
        LOCAL loc_cVerEmiGrupo, loc_cVerEmiConta, loc_cVerDesGrupo, loc_cVerDesConta
        LOCAL loc_cCursorFinal

        loc_lSucesso = .F.
        TRY
            *-- Valida periodo
            IF EMPTY(THIS.this_dDtInicial) OR EMPTY(THIS.this_dDtFinal)
                THIS.this_cMensagemErro = "Per" + CHR(237) + "odo n" + CHR(227) + "o informado"
                loc_lSucesso = .F.
            ENDIF
            IF THIS.this_dDtInicial > THIS.this_dDtFinal
                THIS.this_cMensagemErro = "Data inicial maior que data final"
                loc_lSucesso = .F.
            ENDIF

            *-- Valida operacoes selecionadas
            IF !USED(THIS.this_cCursorOperacoes)
                THIS.this_cMensagemErro = "Opera" + CHR(231) + CHR(245) + ;
                                          "es n" + CHR(227) + "o carregadas"
                loc_lSucesso = .F.
            ENDIF
            SELECT (THIS.this_cCursorOperacoes)
            COUNT TO loc_nFlagadas FOR Flag
            IF loc_nFlagadas = 0
                THIS.this_cMensagemErro = "Selecione ao menos uma opera" + CHR(231) + CHR(227) + "o"
                loc_lSucesso = .F.
            ENDIF

            *-- Clausula WHERE: tipo de data (Vencimento=1 ou Operacao=2)
            IF THIS.this_nNrTipo = 2
                loc_cVerData = " AND CONVERT(DATE, a.dtents) BETWEEN " + ;
                               FormatarDataSQL(THIS.this_dDtInicial) + ;
                               " AND " + FormatarDataSQL(THIS.this_dDtFinal)
            ELSE
                loc_cVerData = " AND CONVERT(DATE, b.vencs) BETWEEN " + ;
                               FormatarDataSQL(THIS.this_dDtInicial) + ;
                               " AND " + FormatarDataSQL(THIS.this_dDtFinal)
            ENDIF

            *-- Clausula WHERE: empresa (opcional)
            IF EMPTY(ALLTRIM(THIS.this_cCdEmpresa))
                loc_cVerEmpresa = ""
            ELSE
                loc_cVerEmpresa = " AND a.emps = " + EscaparSQL(ALLTRIM(THIS.this_cCdEmpresa))
            ENDIF

            *-- Clausula WHERE: opcao de nota (1=com nota, 2=sem nota, 3=ambos)
            IF THIS.this_nNrOpcao = 1
                loc_cVerOpcao = " AND NOT a.notas = " + EscaparSQL(SPACE(6))
            ELSE
                IF THIS.this_nNrOpcao = 2
                loc_cVerOpcao = " AND a.notas = " + EscaparSQL(SPACE(6))
            ELSE
                loc_cVerOpcao = ""
                ENDIF
            ENDIF

            *-- Clausula WHERE: grupo emissor (opcional)
            IF EMPTY(ALLTRIM(THIS.this_cCdEmiGrupo))
                loc_cVerEmiGrupo = ""
            ELSE
                loc_cVerEmiGrupo = " AND b.grclis = " + EscaparSQL(ALLTRIM(THIS.this_cCdEmiGrupo))
            ENDIF

            *-- Clausula WHERE: conta emissor (opcional)
            IF EMPTY(ALLTRIM(THIS.this_cCdEmiConta))
                loc_cVerEmiConta = ""
            ELSE
                loc_cVerEmiConta = " AND b.iclis = " + EscaparSQL(ALLTRIM(THIS.this_cCdEmiConta))
            ENDIF

            *-- Clausula WHERE: grupo destino (opcional)
            IF EMPTY(ALLTRIM(THIS.this_cCdDesGrupo))
                loc_cVerDesGrupo = ""
            ELSE
                loc_cVerDesGrupo = " AND b.grupos = " + EscaparSQL(ALLTRIM(THIS.this_cCdDesGrupo))
            ENDIF

            *-- Clausula WHERE: conta destino (opcional)
            IF EMPTY(ALLTRIM(THIS.this_cCdDesConta))
                loc_cVerDesConta = ""
            ELSE
                loc_cVerDesConta = " AND b.contas = " + EscaparSQL(ALLTRIM(THIS.this_cCdDesConta))
            ENDIF

            *-- 1. Query SQL Server: SigCqChm JOIN SigChe com todos os filtros
            IF USED("cursor_4c_SqlTmp0")
                USE IN cursor_4c_SqlTmp0
            ENDIF

            loc_cSql = "SELECT a.nums, a.numlotes, a.dtents, b.grclis, b.iclis, " + ;
                       "b.vencs, b.bancos, b.agencias, b.ncontas, b.ncheques, " + ;
                       "b.valors, b.emps, b.umovs, ' ' AS Hists " + ;
                       "FROM SigCqChm a, SigChe b " + ;
                       "WHERE a.nums = b.nums"
            loc_cSql = loc_cSql + loc_cVerData + loc_cVerEmpresa + loc_cVerOpcao + ;
                       loc_cVerEmiGrupo + loc_cVerEmiConta + ;
                       loc_cVerDesGrupo + loc_cVerDesConta + ;
                       " ORDER BY a.nums, a.numlotes, a.dtents, " + ;
                       "b.grclis, b.iclis, b.vencs, b.bancos, " + ;
                       "b.agencias, b.ncontas, b.ncheques, b.valors, b.emps, b.umovs"

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSql, "cursor_4c_SqlTmp0")
            IF loc_nResult < 0
                THIS.this_cMensagemErro = "Erro ao buscar dados dos cheques"
                loc_lSucesso = .F.
            ENDIF

            *-- 2. Join VFP local com operacoes selecionadas -> cursor resultado
            *-- ImpFollow: resultado vai para cursor_4c_Temp; senao: vai para CsRelatorio
            loc_cCursorFinal = IIF(THIS.this_lImpFollow, THIS.this_cCursorTemp, "CsRelatorio")

            IF USED("CsRelatorio")
                USE IN CsRelatorio
            ENDIF
            IF THIS.this_lImpFollow AND USED(THIS.this_cCursorTemp)
                USE IN (THIS.this_cCursorTemp)
            ENDIF

            *-- SELECT com ORDER BY dinamico baseado no indice do combobox de ordem
            DO CASE
                CASE THIS.this_nOrdemIdx = 2
                    SELECT a.nums, SPACE(50) AS RClis, ;
                           MAX(a.valors) AS valors, MAX(a.vencs) AS vencs, ;
                           MAX(a.dtents) AS dtents, MAX(a.grclis) AS grclis, ;
                           MAX(a.numlotes) AS numlotes, MAX(a.iclis) AS iclis, ;
                           MAX(a.bancos) AS bancos, MAX(a.agencias) AS agencias, ;
                           MAX(a.ncontas) AS ncontas, MAX(a.ncheques) AS ncheques, ;
                           MAX(a.emps) AS emps, MAX(a.umovs) AS umovs, ;
                           MAX(a.Hists) AS Hists ;
                      FROM cursor_4c_SqlTmp0 a, cursor_4c_Operacoes d ;
                     WHERE ALLTRIM(a.umovs) = ALLTRIM(d.Operacaos) AND d.Flag ;
                     GROUP BY 1, 2 ;
                     ORDER BY 4 ;
                      INTO CURSOR (loc_cCursorFinal) READWRITE
                CASE THIS.this_nOrdemIdx = 3
                    SELECT a.nums, SPACE(50) AS RClis, ;
                           MAX(a.valors) AS valors, MAX(a.vencs) AS vencs, ;
                           MAX(a.dtents) AS dtents, MAX(a.grclis) AS grclis, ;
                           MAX(a.numlotes) AS numlotes, MAX(a.iclis) AS iclis, ;
                           MAX(a.bancos) AS bancos, MAX(a.agencias) AS agencias, ;
                           MAX(a.ncontas) AS ncontas, MAX(a.ncheques) AS ncheques, ;
                           MAX(a.emps) AS emps, MAX(a.umovs) AS umovs, ;
                           MAX(a.Hists) AS Hists ;
                      FROM cursor_4c_SqlTmp0 a, cursor_4c_Operacoes d ;
                     WHERE ALLTRIM(a.umovs) = ALLTRIM(d.Operacaos) AND d.Flag ;
                     GROUP BY 1, 2 ;
                     ORDER BY 5 ;
                      INTO CURSOR (loc_cCursorFinal) READWRITE
                OTHERWISE
                    SELECT a.nums, SPACE(50) AS RClis, ;
                           MAX(a.valors) AS valors, MAX(a.vencs) AS vencs, ;
                           MAX(a.dtents) AS dtents, MAX(a.grclis) AS grclis, ;
                           MAX(a.numlotes) AS numlotes, MAX(a.iclis) AS iclis, ;
                           MAX(a.bancos) AS bancos, MAX(a.agencias) AS agencias, ;
                           MAX(a.ncontas) AS ncontas, MAX(a.ncheques) AS ncheques, ;
                           MAX(a.emps) AS emps, MAX(a.umovs) AS umovs, ;
                           MAX(a.Hists) AS Hists ;
                      FROM cursor_4c_SqlTmp0 a, cursor_4c_Operacoes d ;
                     WHERE ALLTRIM(a.umovs) = ALLTRIM(d.Operacaos) AND d.Flag ;
                     GROUP BY 1, 2 ;
                     ORDER BY 3 ;
                      INTO CURSOR (loc_cCursorFinal) READWRITE
            ENDCASE

            IF USED("cursor_4c_SqlTmp0")
                USE IN cursor_4c_SqlTmp0
            ENDIF

            *-- 3. Preenche rClis e opcionalmente Hists
            IF THIS.this_lImpFollow
                THIS.ProcessarComFollowUp()
            ELSE
                THIS.BuscarClientes()
            ENDIF

            SELECT CsRelatorio
            GO TOP
            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "sigrechpBO.PrepararDados")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * BuscarClientes - Preenche rClis em CsRelatorio via SigCdCli (sem FollowUp)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE BuscarClientes()
        LOCAL loc_cSqlC, loc_nResult, loc_cIclis
        TRY
            SELECT CsRelatorio
            SCAN
                loc_cIclis = ALLTRIM(CsRelatorio.Iclis)
                IF !EMPTY(loc_cIclis)
                    loc_cSqlC = "SELECT TOP 1 rClis FROM SigCdCli WHERE Iclis = " + ;
                                EscaparSQL(loc_cIclis)
                    loc_nResult = SQLEXEC(gnConnHandle, loc_cSqlC, "cursor_4c_CliB")
                    IF loc_nResult > 0
                        SELECT cursor_4c_CliB
                        IF !EOF()
                            REPLACE CsRelatorio.RClis WITH ALLTRIM(cursor_4c_CliB.rClis) ;
                                    IN CsRelatorio
                        ENDIF
                        USE IN cursor_4c_CliB
                    ENDIF
                    SELECT CsRelatorio
                ENDIF
            ENDSCAN
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "sigrechpBO.BuscarClientes")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * ProcessarComFollowUp - Cria CsRelatorio com Hists e rClis do SigCheH/SigCdCli
    * Usado quando ImpFollow = .T.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ProcessarComFollowUp()
        LOCAL loc_cSqlH, loc_cSqlC, loc_nResult, loc_cNums, loc_cIclis
        TRY
            IF USED("CsRelatorio")
                USE IN CsRelatorio
            ENDIF
            CREATE CURSOR CsRelatorio (Nums C(8), Numlotes N(8,0), dtents D, ;
                                       GrClis C(10), Iclis C(10), Vencs D, ;
                                       Bancos C(3), Agencias C(4), nContas C(10), ;
                                       nCheques C(6), Valors N(12,2), Emps C(3), ;
                                       Umovs C(15), Hists C(76), RClis C(50))

            SELECT (THIS.this_cCursorTemp)
            SCAN
                SCATTER MEMVAR MEMO

                SELECT CsRelatorio
                APPEND BLANK
                GATHER MEMVAR MEMO

                *-- Busca historico do cheque em SigCheH
                loc_cNums = ALLTRIM(m.Nums)
                loc_cSqlH = "SELECT TOP 1 Hists FROM SigCheH WHERE Nums = " + ;
                            EscaparSQL(loc_cNums)
                loc_nResult = SQLEXEC(gnConnHandle, loc_cSqlH, "cursor_4c_CheH")
                IF loc_nResult > 0
                    SELECT cursor_4c_CheH
                    IF !EOF()
                        REPLACE CsRelatorio.Hists WITH ALLTRIM(cursor_4c_CheH.Hists) ;
                                IN CsRelatorio
                    ENDIF
                    USE IN cursor_4c_CheH
                ENDIF

                *-- Busca razao social do cliente em SigCdCli
                loc_cIclis = ALLTRIM(m.Iclis)
                IF !EMPTY(loc_cIclis)
                    loc_cSqlC = "SELECT TOP 1 rClis FROM SigCdCli WHERE Iclis = " + ;
                                EscaparSQL(loc_cIclis)
                    loc_nResult = SQLEXEC(gnConnHandle, loc_cSqlC, "cursor_4c_CliF")
                    IF loc_nResult > 0
                        SELECT cursor_4c_CliF
                        IF !EOF()
                            REPLACE CsRelatorio.RClis WITH ALLTRIM(cursor_4c_CliF.rClis) ;
                                    IN CsRelatorio
                        ENDIF
                        USE IN cursor_4c_CliF
                    ENDIF
                ENDIF

                SELECT (THIS.this_cCursorTemp)
            ENDSCAN

            IF USED(THIS.this_cCursorTemp)
                USE IN (THIS.this_cCursorTemp)
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "sigrechpBO.ProcessarComFollowUp")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * MontarCabecalho - Cria cursor CsCabecalho para o cabecalho do relatorio
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE MontarCabecalho()
        LOCAL loc_lSucesso, loc_nResult, loc_cSqlEmp
        LOCAL loc_cNomeEmpresa, loc_cTipoData, loc_cPeriodo, loc_cEmissor, loc_cDestino

        loc_lSucesso = .F.
        TRY
            loc_cNomeEmpresa = ""
            loc_cSqlEmp = "SELECT TOP 1 Razas FROM SigCdEmp WHERE cEmps = " + ;
                          EscaparSQL(go_4c_Sistema.cCodEmpresa)
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSqlEmp, "cursor_4c_Emp")
            IF loc_nResult > 0
                SELECT cursor_4c_Emp
                IF !EOF()
                    loc_cNomeEmpresa = ALLTRIM(cursor_4c_Emp.Razas)
                ENDIF
                USE IN cursor_4c_Emp
            ENDIF

            IF THIS.this_nNrTipo = 2
                loc_cTipoData = "Data da Movimenta" + CHR(231) + CHR(227) + "o: "
            ELSE
                loc_cTipoData = "Data de Vencimento: "
            ENDIF

            loc_cPeriodo = loc_cTipoData + ;
                           DTOC(THIS.this_dDtInicial) + " " + CHR(224) + " " + ;
                           DTOC(THIS.this_dDtFinal) + " - " + ;
                           "Empresa: " + ;
                           IIF(EMPTY(ALLTRIM(THIS.this_cCdEmpresa)), ;
                               "Geral", ;
                               ALLTRIM(THIS.this_cCdEmpresa) + " - " + ALLTRIM(THIS.this_cDsEmpresa))

            loc_cEmissor = "Grupo / Conta Emissor  : " + ;
                           IIF(EMPTY(ALLTRIM(THIS.this_cCdEmiGrupo)), ;
                               "Todos", ;
                               ALLTRIM(THIS.this_cCdEmiGrupo) + " - " + ;
                               ALLTRIM(THIS.this_cDsEmiGrupo)) + ;
                           " / " + ;
                           IIF(EMPTY(ALLTRIM(THIS.this_cCdEmiConta)), ;
                               "Todas", ;
                               ALLTRIM(THIS.this_cCdEmiConta) + " - " + ;
                               ALLTRIM(THIS.this_cDsEmiConta))

            loc_cDestino = "Grupo / Conta Destino  : " + ;
                           IIF(EMPTY(ALLTRIM(THIS.this_cCdDesGrupo)), ;
                               "Todos", ;
                               ALLTRIM(THIS.this_cCdDesGrupo) + " - " + ;
                               ALLTRIM(THIS.this_cDsDesGrupo)) + ;
                           " / " + ;
                           IIF(EMPTY(ALLTRIM(THIS.this_cCdDesConta)), ;
                               "Todas", ;
                               ALLTRIM(THIS.this_cCdDesConta) + " - " + ;
                               ALLTRIM(THIS.this_cDsDesConta))

            IF USED("CsCabecalho")
                USE IN CsCabecalho
            ENDIF
            CREATE CURSOR CsCabecalho (NomeEmpresa C(80), Titulo C(80), ;
                                       Periodo C(80), Operacao C(80), ;
                                       Emissor C(80), Destino C(80))
            INSERT INTO CsCabecalho (NomeEmpresa, Titulo, Periodo, Emissor, Destino) ;
                VALUES (loc_cNomeEmpresa, THIS.this_cTitulo, ;
                        loc_cPeriodo, loc_cEmissor, loc_cDestino)

            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "sigrechpBO.MontarCabecalho")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * LimparCursores - Fecha cursores de trabalho apos impressao/visualizacao
    *--------------------------------------------------------------------------
    PROCEDURE LimparCursores()
        TRY
            IF USED("CsRelatorio")
                USE IN CsRelatorio
            ENDIF
            IF USED("CsCabecalho")
                USE IN CsCabecalho
            ENDIF
            IF USED(THIS.this_cCursorTemp)
                USE IN (THIS.this_cCursorTemp)
            ENDIF
            IF USED("cursor_4c_SqlTmp0")
                USE IN cursor_4c_SqlTmp0
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "sigrechpBO.LimparCursores")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * Imprimir - Prepara dados e imprime relatorio na impressora
    *--------------------------------------------------------------------------
    PROCEDURE Imprimir()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            THIS.this_cMensagemErro = ""
            IF !THIS.PrepararDados()
                IF EMPTY(THIS.this_cMensagemErro)
                    THIS.this_cMensagemErro = "Erro ao preparar dados do relat" + CHR(243) + "rio"
                ENDIF
                loc_lSucesso = .F.
            ENDIF
            IF !THIS.MontarCabecalho()
                loc_lSucesso = .F.
            ENDIF
            SELECT CsRelatorio
            REPORT FORM (THIS.this_cArquivoRelatorio) TO PRINTER PROMPT NOCONSOLE
            THIS.LimparCursores()
            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "sigrechpBO.Imprimir")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Visualizar - Prepara dados e exibe relatorio em preview na tela
    *--------------------------------------------------------------------------
    PROCEDURE Visualizar()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            THIS.this_cMensagemErro = ""
            IF !THIS.PrepararDados()
                IF EMPTY(THIS.this_cMensagemErro)
                    THIS.this_cMensagemErro = "Erro ao preparar dados do relat" + CHR(243) + "rio"
                ENDIF
                loc_lSucesso = .F.
            ENDIF
            IF !THIS.MontarCabecalho()
                loc_lSucesso = .F.
            ENDIF
            SELECT CsRelatorio
            REPORT FORM (THIS.this_cArquivoRelatorio) PREVIEW NOCONSOLE
            THIS.LimparCursores()
            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "sigrechpBO.Visualizar")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Retorna chave composta dos filtros do relatorio
    * Usada pela auditoria para identificar a execucao do relatorio
    *--------------------------------------------------------------------------
    PROCEDURE ObterChavePrimaria()
        LOCAL loc_cChave
        loc_cChave = "TIPO=" + ALLTRIM(STR(THIS.this_nNrTipo, 1)) + ;
                     ";OPC="  + ALLTRIM(STR(THIS.this_nNrOpcao, 1)) + ;
                     ";ORD="  + ALLTRIM(STR(THIS.this_nOrdemIdx, 1)) + ;
                     ";DT="   + DTOC(THIS.this_dDtInicial) + ;
                     "-"      + DTOC(THIS.this_dDtFinal) + ;
                     ";EMP="  + ALLTRIM(THIS.this_cCdEmpresa) + ;
                     ";EMI="  + ALLTRIM(THIS.this_cCdEmiGrupo) + "/" + ALLTRIM(THIS.this_cCdEmiConta) + ;
                     ";DES="  + ALLTRIM(THIS.this_cCdDesGrupo) + "/" + ALLTRIM(THIS.this_cCdDesConta) + ;
                     ";FLW="  + IIF(THIS.this_lImpFollow, "S", "N")
        RETURN loc_cChave
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Carrega filtros do BO a partir de cursor de preset
    * par_cAliasCursor: nome do cursor com colunas dos filtros previamente usados
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso, loc_cAlias
        loc_lSucesso = .F.
        TRY
            loc_cAlias = par_cAliasCursor
            IF EMPTY(loc_cAlias) OR !USED(loc_cAlias)
                THIS.this_cMensagemErro = "Cursor de preset n" + CHR(227) + ;
                    "o dispon" + CHR(237) + "vel: " + ALLTRIM(NVL(loc_cAlias, ""))
            ELSE
                SELECT (loc_cAlias)
                IF EOF()
                    THIS.this_cMensagemErro = "Cursor de preset vazio: " + loc_cAlias
                ELSE
                    SCATTER MEMVAR

                    IF TYPE("m.nNrTipo") = "N"
                        THIS.this_nNrTipo = m.nNrTipo
                    ENDIF
                    IF TYPE("m.dDtInicial") = "D"
                        THIS.this_dDtInicial = m.dDtInicial
                    ENDIF
                    IF TYPE("m.dDtFinal") = "D"
                        THIS.this_dDtFinal = m.dDtFinal
                    ENDIF
                    IF TYPE("m.cCdEmpresa") = "C"
                        THIS.this_cCdEmpresa = ALLTRIM(m.cCdEmpresa)
                    ENDIF
                    IF TYPE("m.cDsEmpresa") = "C"
                        THIS.this_cDsEmpresa = ALLTRIM(m.cDsEmpresa)
                    ENDIF
                    IF TYPE("m.nNrOpcao") = "N"
                        THIS.this_nNrOpcao = m.nNrOpcao
                    ENDIF
                    IF TYPE("m.cCdEmiGrupo") = "C"
                        THIS.this_cCdEmiGrupo = ALLTRIM(m.cCdEmiGrupo)
                    ENDIF
                    IF TYPE("m.cDsEmiGrupo") = "C"
                        THIS.this_cDsEmiGrupo = ALLTRIM(m.cDsEmiGrupo)
                    ENDIF
                    IF TYPE("m.cCdEmiConta") = "C"
                        THIS.this_cCdEmiConta = ALLTRIM(m.cCdEmiConta)
                    ENDIF
                    IF TYPE("m.cDsEmiConta") = "C"
                        THIS.this_cDsEmiConta = ALLTRIM(m.cDsEmiConta)
                    ENDIF
                    IF TYPE("m.cCdDesGrupo") = "C"
                        THIS.this_cCdDesGrupo = ALLTRIM(m.cCdDesGrupo)
                    ENDIF
                    IF TYPE("m.cDsDesGrupo") = "C"
                        THIS.this_cDsDesGrupo = ALLTRIM(m.cDsDesGrupo)
                    ENDIF
                    IF TYPE("m.cCdDesConta") = "C"
                        THIS.this_cCdDesConta = ALLTRIM(m.cCdDesConta)
                    ENDIF
                    IF TYPE("m.cDsDesConta") = "C"
                        THIS.this_cDsDesConta = ALLTRIM(m.cDsDesConta)
                    ENDIF
                    IF TYPE("m.nOrdemIdx") = "N"
                        THIS.this_nOrdemIdx = m.nOrdemIdx
                    ENDIF
                    IF TYPE("m.lImpFollow") = "L"
                        THIS.this_lImpFollow = m.lImpFollow
                    ENDIF

                    loc_lSucesso = .T.
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "sigrechpBO.CarregarDoCursor")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir - Semantica para BO de relatorio: produzir documento impresso
    * Delega para Imprimir e registra auditoria de IMPRESSAO
    *--------------------------------------------------------------------------
    PROCEDURE Inserir()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            loc_lSucesso = THIS.Imprimir()
            IF loc_lSucesso
                THIS.RegistrarAuditoria("IMPRESSAO")
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "sigrechpBO.Inserir")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - Semantica para BO de relatorio: recalcular e visualizar
    * Delega para Visualizar e registra auditoria de VISUALIZACAO
    *--------------------------------------------------------------------------
    PROCEDURE Atualizar()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            loc_lSucesso = THIS.Visualizar()
            IF loc_lSucesso
                THIS.RegistrarAuditoria("VISUALIZACAO")
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "sigrechpBO.Atualizar")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * RegistrarAuditoria - Registra geracao do relatorio em LogAuditoria
    * par_cOperacao: tipo de operacao (IMPRESSAO, VISUALIZACAO)
    *--------------------------------------------------------------------------
    PROCEDURE RegistrarAuditoria(par_cOperacao)
        LOCAL loc_lSucesso, loc_cSQL, loc_cChave, loc_nResult, loc_cUsuario
        loc_lSucesso = .F.
        TRY
            loc_cUsuario = ""
            IF TYPE("gc_4c_UsuarioLogado") = "C"
                loc_cUsuario = ALLTRIM(NVL(gc_4c_UsuarioLogado, ""))
            ENDIF

            loc_cChave = THIS.ObterChavePrimaria()

            loc_cSQL = "INSERT INTO LogAuditoria " + ;
                       "(DataHora, Usuario, Tabela, Operacao, ChaveRegistro) " + ;
                       "VALUES (GETDATE(), " + ;
                       EscaparSQL(loc_cUsuario) + ", " + ;
                       EscaparSQL("SigReChp") + ", " + ;
                       EscaparSQL(par_cOperacao) + ", " + ;
                       EscaparSQL(loc_cChave) + ")"

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)
            loc_lSucesso = (loc_nResult >= 0)
        CATCH TO loc_oErro
            *-- Auditoria nao deve interromper geracao do relatorio
            THIS.this_cMensagemErro = loc_oErro.Message
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Destroy - Limpa cursores e chama base
    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
        THIS.LimparCursores()
        IF USED(THIS.this_cCursorOperacoes)
            USE IN (THIS.this_cCursorOperacoes)
        ENDIF
        DODEFAULT()
    ENDPROC

ENDDEFINE


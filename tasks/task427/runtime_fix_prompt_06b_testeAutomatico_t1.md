# CORRIGIR ERRO DE RUNTIME VFP9

## TAREFA OBRIGATORIA
O formulario VFP9 apresentou erro de runtime durante teste automatizado.
Voce DEVE corrigir o erro e salvar os arquivos corrigidos usando Write tool.

## ERRO DETECTADO
- Etapa: 06b_testeAutomatico
- Tentativa: 1/10
- Mensagem: Testes automaticos: 89% < 100%. Falhas: Teste 'CarregarDadosReais': Property CARREGARDADOS is not found. | Detalhes: Linha: 799, Proc: testecarregardadosreais

## CONTEXTO DO ERRO

### LOG DA ETAPA (06b_testeAutomatico):
[2026-08-06 02:21:23] [INFO] === VFP EXECUTOR v2.0 ===
[2026-08-06 02:21:23] [INFO] Config FPW: (nao fornecido)
[2026-08-06 02:21:23] [INFO] Script PRG: C:\4c\projeto\app\utils\TesteAutomatico.prg
[2026-08-06 02:21:23] [INFO] Timeout: 300 segundos
[2026-08-06 02:21:23] [INFO] Wrapper PRG criado para parametros: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_c1vmhdzs.prg
[2026-08-06 02:21:23] [INFO] Conteudo do wrapper:
[2026-08-06 02:21:23] [INFO] * Auto-generated wrapper for parameters
* Script: C:\4c\projeto\app\utils\TesteAutomatico.prg
* Parameters: 'FormFpN', 'C:\4c\tasks\task427', 'OPERACIONAL'

* Anti-dialog protections for unattended execution
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
SET NOTIFY OFF
SYS(2335, 0)

DO "C:\4c\projeto\app\utils\TesteAutomatico" WITH 'FormFpN', 'C:\4c\tasks\task427', 'OPERACIONAL'
QUIT

[2026-08-06 02:21:23] [INFO] Comando VFP: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_c1vmhdzs.prg
[2026-08-06 02:21:23] [INFO] VFP output esperado em: C:\4c\tasks\task427\vfp_output.txt
[2026-08-06 02:21:23] [INFO] Executando Visual FoxPro 9...
[2026-08-06 02:21:23] [INFO] Comando completo: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_c1vmhdzs.prg
[2026-08-06 02:21:23] [INFO] Executando: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_c1vmhdzs.prg
[2026-08-06 02:21:23] [INFO] Timeout configurado: 300 segundos
[2026-08-06 02:22:21] [INFO] VFP9 finalizou normalmente com exit code: 
[2026-08-06 02:22:21] [INFO] VFP9 finalizado em 58.4493294 segundos
[2026-08-06 02:22:21] [INFO] Exit Code: 
[2026-08-06 02:22:21] [INFO] 
[2026-08-06 02:22:21] [INFO] Arquivos temporarios preservados para inspecao:
[2026-08-06 02:22:21] [INFO]   Wrapper.prg: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_c1vmhdzs.prg
[2026-08-06 02:22:21] [INFO] 
[2026-08-06 02:22:21] [INFO] === Conteudo do Wrapper.prg temporario ===
[2026-08-06 02:22:21] [INFO] * Auto-generated wrapper for parameters
[2026-08-06 02:22:21] [INFO] * Script: C:\4c\projeto\app\utils\TesteAutomatico.prg
[2026-08-06 02:22:21] [INFO] * Parameters: 'FormFpN', 'C:\4c\tasks\task427', 'OPERACIONAL'
[2026-08-06 02:22:21] [INFO] 
[2026-08-06 02:22:21] [INFO] * Anti-dialog protections for unattended execution
[2026-08-06 02:22:21] [INFO] SET SAFETY OFF
[2026-08-06 02:22:21] [INFO] SET RESOURCE OFF
[2026-08-06 02:22:21] [INFO] SET TALK OFF
[2026-08-06 02:22:21] [INFO] SET NOTIFY OFF
[2026-08-06 02:22:21] [INFO] SYS(2335, 0)
[2026-08-06 02:22:21] [INFO] 
[2026-08-06 02:22:21] [INFO] DO "C:\4c\projeto\app\utils\TesteAutomatico" WITH 'FormFpN', 'C:\4c\tasks\task427', 'OPERACIONAL'
[2026-08-06 02:22:21] [INFO] QUIT
[2026-08-06 02:22:21] [INFO] 
[2026-08-06 02:22:21] [INFO] === Fim do Wrapper.prg ===
[2026-08-06 02:22:21] [WARN] AVISO: VFP9 retornou exit code  (normal para VFP9 GUI - validar pelo arquivo de saida)


### RESULTADO DOS TESTES (teste_resultado.json):
{
  "formClass": "FormFpN",
  "timestamp": "20260806022221",
  "testes": [
    {
      "nome": "Instanciacao",
      "passou": true,
      "erro": "",
      "detalhes": "Objeto criado com sucesso"
    },
    {
      "nome": "ContainersFlutuantes",
      "passou": true,
      "erro": "",
      "detalhes": "Nenhum container flutuante encontrado (OK)"
    },
    {
      "nome": "CarregarDadosReais",
      "passou": false,
      "erro": "Property CARREGARDADOS is not found.",
      "detalhes": "Linha: 799, Proc: testecarregardadosreais"
    },
    {
      "nome": "NavegacaoPaginas",
      "passou": true,
      "erro": "",
      "detalhes": "1/1 paginas navegadas com sucesso"
    },
    {
      "nome": "BtnIncluirNavegacao",
      "passou": true,
      "erro": "",
      "detalhes": "Form OPERACIONAL com BtnIncluirClick sem navegacao por PageFrame (OK)"
    },
    {
      "nome": "BtnEncerrarExiste",
      "passou": true,
      "erro": "",
      "detalhes": "Metodo BtnEncerrarClick encontrado"
    },
    {
      "nome": "GridTemDados",
      "passou": true,
      "erro": "",
      "detalhes": "Teste pulado (gb_4c_ValidandoUI = .T., sem conexao ao banco)"
    },
    {
      "nome": "LookupMetodosExistem",
      "passou": true,
      "erro": "",
      "detalhes": "AbrirLookup: 0 | KeyPress handlers: 1 (KEYPRESS)"
    },
    {
      "nome": "Fechar",
      "passou": true,
      "erro": "",
      "detalhes": "Formulario fechado com sucesso"
    }
  ],
  "resumo": {
    "total": 9,
    "passou": 8,
    "falhou": 1,
    "percentual": 89
  }
}



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

### FORM (C:\4c\projeto\app\forms\operacionais\FormFpN.prg):
*==============================================================================
* FormFpN.prg
* Form: Condicoes de Pagamento por Operacao (SIGCDTBD)
* OPERACIONAL - Dialog popup aberto por form pai passando (oFormPai, cDopes)
* Tabela: SigCdFpN
* Herda de: FormBase
*
* Uso: CREATEOBJECT("FormFpN", oFormPai, cDopes)
*   oFormPai : referencia ao form que abre este dialog (sera desabilitado)
*   cDopes   : codigo da operacao (FK SigCdOpe.Dopes)
*==============================================================================

DEFINE CLASS FormFpN AS FormBase

    Width        = 800
    Height       = 400
    AutoCenter   = .T.
    TitleBar     = 0
    ShowWindow = 1
    WindowType = 1
    ControlBox   = .F.
    Movable      = .F.
    BorderStyle  = 2
    ClipControls = .F.
    ShowTips     = .T.
    DataSession  = 2

    *-- Referencia ao form pai (Enabled=.F. ao abrir, .T. ao fechar)
    this_oParentForm = .NULL.

    *-- Codigo da operacao que esta sendo editada
    this_cDopes = ""

    *==========================================================================
    * Init - Recebe referencia ao form pai e codigo da operacao
    * Desabilita o form pai antes de abrir (comportamento modal original)
    *==========================================================================
    PROCEDURE Init()
        LPARAMETERS par_oParentForm, par_cDopes

        LOCAL loc_oErro
        TRY
            IF VARTYPE(par_oParentForm) = "O"
                THIS.this_oParentForm = par_oParentForm
                par_oParentForm.Enabled = .F.
            ENDIF

            THIS.this_cDopes = ALLTRIM(IIF(VARTYPE(par_cDopes) = "C", par_cDopes, ""))
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro em FormFpN.Init")
        ENDTRY

        RETURN DODEFAULT()
    ENDPROC

    *==========================================================================
    * InicializarForm - Cria estrutura visual e carrega dados
    *==========================================================================
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.
        TRY
            THIS.Picture = gc_4c_CaminhoIcones + "new_background.jpg"
            SET DATE TO BRITISH
            SET CENTURY ON

            THIS.this_oBusinessObject = CREATEOBJECT("FpNBO")
            IF VARTYPE(THIS.this_oBusinessObject) = "O"
                THIS.Caption = "Condi" + CHR(231) + CHR(245) + "es de Pagamento " + THIS.this_cDopes

                THIS.ConfigurarCabecalho()
                THIS.ConfigurarBotoes()
                THIS.ConfigurarPageFrame()

                THIS.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
                THIS.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption

                THIS.ConfigurarPaginaLista()

                BINDEVENT(THIS.cmd_4c_Inserir,   "Click", THIS, "CmdInserirClick")
                BINDEVENT(THIS.cmd_4c_Excluir,   "Click", THIS, "CmdExcluirClick")
                BINDEVENT(THIS.cmd_4c_Confirmar, "Click", THIS, "CmdConfirmarClick")
                BINDEVENT(THIS.cmd_4c_Cancelar,  "Click", THIS, "CmdCancelarClick")

                THIS.pgf_4c_Principal.Visible    = .T.
                THIS.pgf_4c_Principal.ActivePage = 1

                IF NOT (TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI)
                    THIS.CarregarDados()
                ENDIF

                THIS.TornarControlesVisiveis(THIS)
                THIS.Visible  = .T.
                loc_lSucesso  = .T.
            ELSE
                MsgErro("Falha ao criar FpNBO.", "Erro em FormFpN.InicializarForm")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro em FormFpN.InicializarForm")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * ConfigurarCabecalho - Container header cinza com labels de titulo
    * Original: cntSombra Top=0, Left=-1, Width=800, Height=80, BackColor=100,100,100
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarCabecalho()
        LOCAL loc_oErro
        TRY
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
                .Top           = 18
                .Width         = THIS.Width - 20
                .ForeColor     = RGB(0, 0, 0)
                .Visible       = .T.
            ENDWITH

            THIS.cnt_4c_Cabecalho.AddObject("lbl_4c_Titulo", "Label")
            WITH THIS.cnt_4c_Cabecalho.lbl_4c_Titulo
                .FontBold      = .T.
                .FontName      = "Tahoma"
                .FontSize      = 18
                .WordWrap      = .T.
                .Alignment     = 0
                .BackStyle     = 0
                .AutoSize      = .F.
                .Caption       = THIS.Caption
                .Height        = 46
                .Left          = 10
                .Top           = 17
                .Width         = THIS.Width - 20
                .ForeColor     = RGB(255, 255, 255)
                .ToolTipText   = "T" + CHR(237) + "tulo"
                .Visible       = .T.
            ENDWITH
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro em FormFpN.ConfigurarCabecalho")
        ENDTRY
    ENDPROC

    *==========================================================================
    * ConfigurarBotoes - Cria botoes de acao sobrepostos ao cabecalho
    * Original: cmdInserir(500,4), cmdExcluir(575,4), cmdSair/Confirmar(650,4),
    *           Cancela(725,4) - todos Width=75, Height=75 (fwbtng padrao)
    * Ordem do Original (esquerda->direita): Inserir, Excluir, Confirmar, Cancelar
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarBotoes()
        LOCAL loc_oErro
        TRY
            THIS.AddObject("cmd_4c_Inserir", "CommandButton")
            WITH THIS.cmd_4c_Inserir
                .Top             = 4
                .Left            = 500
                .Width           = 75
                .Height          = 75
                .Caption         = "Inserir"
                .Picture         = gc_4c_CaminhoIcones + "cadastro_inserir_60.jpg"
                .ToolTipText     = "Inserir nova condi" + CHR(231) + CHR(227) + "o de pagamento"
                .FontName        = "Tahoma"
                .FontBold        = .T.
                .FontItalic      = .T.
                .FontSize        = 8
                .ForeColor       = RGB(90, 90, 90)
                .BackColor       = RGB(255, 255, 255)
                .Themes          = .T.
                .SpecialEffect   = 0
                .PicturePosition = 13
                .MousePointer    = 15
                .WordWrap        = .T.
                .AutoSize        = .F.
                .Visible         = .T.
                .Enabled         = .T.
            ENDWITH

            THIS.AddObject("cmd_4c_Excluir", "CommandButton")
            WITH THIS.cmd_4c_Excluir
                .Top             = 4
                .Left            = 575
                .Width           = 75
                .Height          = 75
                .Caption         = "Excluir"
                .Picture         = gc_4c_CaminhoIcones + "cadastro_excluir_60.jpg"
                .ToolTipText     = "Excluir condi" + CHR(231) + CHR(227) + "o selecionada"
                .FontName        = "Tahoma"
                .FontBold        = .T.
                .FontItalic      = .T.
                .FontSize        = 8
                .ForeColor       = RGB(90, 90, 90)
                .BackColor       = RGB(255, 255, 255)
                .Themes          = .T.
                .SpecialEffect   = 0
                .PicturePosition = 13
                .MousePointer    = 15
                .WordWrap        = .T.
                .AutoSize        = .F.
                .Visible         = .T.
                .Enabled         = .T.
            ENDWITH

            THIS.AddObject("cmd_4c_Confirmar", "CommandButton")
            WITH THIS.cmd_4c_Confirmar
                .Top             = 4
                .Left            = 650
                .Width           = 75
                .Height          = 75
                .Caption         = "Confirmar"
                .Picture         = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
                .ToolTipText     = "Confirmar e gravar as condi" + CHR(231) + CHR(245) + "es"
                .FontName        = "Tahoma"
                .FontBold        = .T.
                .FontItalic      = .T.
                .FontSize        = 8
                .ForeColor       = RGB(90, 90, 90)
                .BackColor       = RGB(255, 255, 255)
                .Themes          = .T.
                .SpecialEffect   = 0
                .PicturePosition = 13
                .MousePointer    = 15
                .WordWrap        = .T.
                .AutoSize        = .F.
                .Visible         = .T.
                .Enabled         = .T.
            ENDWITH

            THIS.AddObject("cmd_4c_Cancelar", "CommandButton")
            WITH THIS.cmd_4c_Cancelar
                .Top             = 4
                .Left            = 725
                .Width           = 75
                .Height          = 75
                .Caption         = "Encerrar"
                .Picture         = gc_4c_CaminhoIcones + "cadastro_cancelar_60.jpg"
                .ToolTipText     = "Cancelar sem gravar e fechar"
                .Cancel          = .T.
                .FontName        = "Tahoma"
                .FontBold        = .T.
                .FontItalic      = .T.
                .FontSize        = 8
                .ForeColor       = RGB(90, 90, 90)
                .BackColor       = RGB(255, 255, 255)
                .Themes          = .T.
                .SpecialEffect   = 0
                .PicturePosition = 13
                .MousePointer    = 15
                .WordWrap        = .T.
                .AutoSize        = .F.
                .Visible         = .T.
                .Enabled         = .T.
            ENDWITH
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro em FormFpN.ConfigurarBotoes")
        ENDTRY
    ENDPROC

    *==========================================================================
    * ConfigurarPageFrame - PageFrame de 1 pagina ocupando area abaixo do header
    * Original nao tem PageFrame (grid solto na form);
    * usamos PageFrame de 1 pagina para satisfazer contrato FormBase e
    * hospedar grd_4c_GradeOpe na Fase 4.
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPageFrame()
        LOCAL loc_oErro
        TRY
            THIS.AddObject("pgf_4c_Principal", "PageFrame")
            WITH THIS.pgf_4c_Principal
                .Top         = 80
                .Left        = 0
                .Width       = THIS.Width
                .Height      = THIS.Height - 80
                .PageCount   = 1
                .Tabs        = .F.
                .BorderWidth = 0
                .Visible     = .T.
            ENDWITH

            WITH THIS.pgf_4c_Principal.Page1
                .Caption = "Condi" + CHR(231) + CHR(245) + "es"
                .Picture = gc_4c_CaminhoIcones + "new_background.jpg"
            ENDWITH
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro em FormFpN.ConfigurarPageFrame")
        ENDTRY
    ENDPROC

    *==========================================================================
    * ConfigurarPaginaLista - Configura Page1 com grid de condicoes de pagamento
    * Original: GradeOpe Top=115, Left=236, Width=313, Height=274 (relativo ao form)
    * Relativo a Page1 (PageFrame Top=80): Top = 115-80 = 35
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPaginaLista()
        LOCAL loc_oPagina, loc_oGrid, loc_oErro
        TRY
            loc_oPagina = THIS.pgf_4c_Principal.Page1

            loc_oPagina.AddObject("grd_4c_GradeOpe", "Grid")
            loc_oGrid = loc_oPagina.grd_4c_GradeOpe

            WITH loc_oGrid
                .Top           = 35
                .Left          = 236
                .Width         = 313
                .Height        = 274
                .ColumnCount   = 2
                .DeleteMark    = .F.
                .RecordMark    = .F.
                .GridLines     = 1
                .GridLineColor = RGB(238, 238, 238)
                .FontName      = "Tahoma"
                .FontSize      = 8
                .ForeColor     = RGB(90, 90, 90)
                .RowHeight     = 16
                .ScrollBars    = 2
                .Visible       = .T.
            ENDWITH

            WITH loc_oGrid.Column1
                .Width     = 80
                .Movable   = .F.
                .Resizable = .F.
                .ForeColor = RGB(90, 90, 90)
                .FontName  = "Tahoma"
                .FontSize  = 8
                WITH .Header1
                    .FontName  = "Tahoma"
                    .FontSize  = 8
                    .Alignment = 2
                    .Caption   = "Condi" + CHR(231) + CHR(227) + "o"
                    .ForeColor = RGB(36, 84, 155)
                ENDWITH
                WITH .Text1
                    .BorderStyle = 0
                    .Margin      = 0
                    .ForeColor   = RGB(90, 90, 90)
                    .BackColor   = RGB(255, 255, 255)
                    .FontName    = "Tahoma"
                    .FontSize    = 8
                    .MaxLength   = 12
                ENDWITH
            ENDWITH

            WITH loc_oGrid.Column2
                .Width     = 200
                .Movable   = .F.
                .Resizable = .F.
                .ReadOnly  = .T.
                .ForeColor = RGB(90, 90, 90)
                .FontName  = "Tahoma"
                .FontSize  = 8
                WITH .Header1
                    .FontName  = "Tahoma"
                    .FontSize  = 8
                    .Alignment = 2
                    .Caption   = "Descri" + CHR(231) + CHR(227) + "o"
                    .ForeColor = RGB(36, 84, 155)
                ENDWITH
                WITH .Text1
                    .BorderStyle = 0
                    .Margin      = 0
                    .ForeColor   = RGB(90, 90, 90)
                    .BackColor   = RGB(255, 255, 255)
                    .FontName    = "Tahoma"
                    .FontSize    = 8
                    .ReadOnly    = .T.
                ENDWITH
            ENDWITH

            *-- BINDEVENT KeyPress na Column1.Text1 para lookup/validacao de Fpags
            BINDEVENT(loc_oGrid.Column1.Text1, "KeyPress", THIS, "ValidarFpagsTxt")
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro em FormFpN.ConfigurarPaginaLista")
        ENDTRY
    ENDPROC

    *==========================================================================
    * CarregarDados - Carrega registros do BO e vincula grid ao cursor
    * Deve ser chamado APOS ConfigurarPaginaLista (grid ja existe)
    * RecordSource/ControlSource definidos aqui pois BO recria o cursor
    *==========================================================================
    PROTECTED PROCEDURE CarregarDados()
        LOCAL loc_lSucesso, loc_oGrid, loc_cCursor, loc_oErro
        loc_lSucesso = .F.
        TRY
            IF VARTYPE(THIS.this_oBusinessObject) = "O" AND NOT EMPTY(THIS.this_cDopes)
                loc_lSucesso = THIS.this_oBusinessObject.CarregarRegistros(THIS.this_cDopes)
                loc_cCursor  = THIS.this_oBusinessObject.this_cCursorOpe

                IF VARTYPE(THIS.pgf_4c_Principal) = "O"
                    IF VARTYPE(THIS.pgf_4c_Principal.Page1.grd_4c_GradeOpe) = "O"
                        loc_oGrid = THIS.pgf_4c_Principal.Page1.grd_4c_GradeOpe

                        *-- Pinar ColumnCount ANTES de RecordSource (evita auto-expand)
                        loc_oGrid.ColumnCount  = 2
                        loc_oGrid.RecordSource = loc_cCursor

                        loc_oGrid.Column1.ControlSource = loc_cCursor + ".Fpags"
                        loc_oGrid.Column2.ControlSource = loc_cCursor + ".Descrs"

                        *-- Reaplicar cabecalhos apos ControlSource (VFP reseta captions)
                        loc_oGrid.Column1.Header1.Caption = "Condi" + CHR(231) + CHR(227) + "o"
                        loc_oGrid.Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"

                        THIS.FormatarGridLista(loc_oGrid)
                        loc_oGrid.Refresh()
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro em FormFpN.CarregarDados")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * FormatarGridLista - Aplica formatacao visual padrao ao grid
    * Original: GradeOpe FontName=Tahoma, FontSize=8, ForeColor=90,90,90
    *==========================================================================
    PROTECTED PROCEDURE FormatarGridLista(par_oGrid)
        WITH par_oGrid
            .FontName = "Tahoma"
            .FontSize = 8
            .SetAll("ForeColor", RGB(90, 90, 90),   "Column")
            .SetAll("BackColor", RGB(255, 255, 255), "Column")
            .HighlightStyle      = 2
            .HighlightBackColor  = RGB(255, 255, 255)
            .HighlightForeColor  = RGB(15, 41, 104)
            .GridLineColor       = RGB(238, 238, 238)
        ENDWITH
    ENDPROC

    *==========================================================================
    * ConfigurarPaginaDados - Nao aplicavel (form OPERACIONAL sem Page2)
    * O form SIGCDTBD original tem apenas grid + botoes, sem pagina de dados
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPaginaDados()
        RETURN
    ENDPROC

    *==========================================================================
    * TornarControlesVisiveis - Torna controles visiveis recursivamente
    * Itera Controls e Pages de PageFrames aninhados
    *==========================================================================
    PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
        LOCAL loc_nI, loc_oControl, loc_nP
        FOR loc_nI = 1 TO par_oContainer.ControlCount
            loc_oControl = par_oContainer.Controls(loc_nI)
            IF VARTYPE(loc_oControl) = "O"
                IF PEMSTATUS(loc_oControl, "Visible", 5)
                    loc_oControl.Visible = .T.
                ENDIF
                IF UPPER(loc_oControl.BaseClass) = "PAGEFRAME"
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

    *==========================================================================
    * AlternarPagina - Stub de compatibilidade (form tem apenas 1 pagina)
    *==========================================================================
    PROCEDURE AlternarPagina(par_nPagina)
        IF VARTYPE(THIS.pgf_4c_Principal) = "O"
            THIS.pgf_4c_Principal.ActivePage = 1
        ENDIF
    ENDPROC

    *==========================================================================
    * CmdInserirClick - Insere linha em branco no grid para nova condicao
    * Original: Insert Into xOpe (fpags) Values (Space(12)) + SetFocus Column1
    *==========================================================================
    PROCEDURE CmdInserirClick()
        LOCAL loc_oGrid, loc_oErro
        TRY
            IF THIS.this_oBusinessObject.InserirLinhaVazia()
                IF VARTYPE(THIS.pgf_4c_Principal) = "O"
                    loc_oGrid = THIS.pgf_4c_Principal.Page1.grd_4c_GradeOpe
                    IF VARTYPE(loc_oGrid) = "O"
                        SELECT (THIS.this_oBusinessObject.this_cCursorOpe)
                        GO BOTTOM
                        loc_oGrid.Refresh()
                        loc_oGrid.Column1.SetFocus()
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro em FormFpN.CmdInserirClick")
        ENDTRY
    ENDPROC

    *==========================================================================
    * CmdExcluirClick - Exclui linha corrente do grid
    * Original: Delete + Skip + Go Bott (se Eof) + GradeOpe.SetFocus
    *==========================================================================
    PROCEDURE CmdExcluirClick()
        LOCAL loc_oErro
        TRY
            IF THIS.this_oBusinessObject.ExcluirLinhaAtual()
                IF VARTYPE(THIS.pgf_4c_Principal) = "O"
                    THIS.pgf_4c_Principal.Page1.grd_4c_GradeOpe.Refresh()
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro em FormFpN.CmdExcluirClick")
        ENDTRY
    ENDPROC

    *==========================================================================
    * CmdConfirmarClick - Salva condicoes e fecha o dialog
    * Original: valida duplicatas -> se duplicata Return .F. (NAO fecha)
    *           -> DELETE SigCdFpN -> INSERT novos -> Release
    *==========================================================================
    PROCEDURE CmdConfirmarClick()
        LOCAL loc_lPodeFechar, loc_oErro
        loc_lPodeFechar = .T.
        TRY
            IF THIS.this_oBusinessObject.this_lGravaDados
                IF !THIS.this_oBusinessObject.Salvar(THIS.this_cDopes)
                    loc_lPodeFechar = .F.
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro em FormFpN.CmdConfirmarClick")
            loc_lPodeFechar = .F.
        ENDTRY
        IF loc_lPodeFechar
            THIS.Release()
        ENDIF
    ENDPROC

    *==========================================================================
    * CmdCancelarClick - Fecha sem salvar (Destroy reabilita o form pai)
    * Original: parentform.enabled = .T. + Release
    *==========================================================================
    PROCEDURE CmdCancelarClick()
        THIS.Release()
    ENDPROC

    *==========================================================================
    * ValidarFpagsTxt - KeyPress handler do Column1.Text1 (lookup de condicao)
    * Dispara em ENTER(13), TAB(9), F4(115)
    * Valida codigo no SQL Server; abre picker se nao encontrado ou F4 direto
    *==========================================================================
    PROCEDURE ValidarFpagsTxt(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oGrid, loc_cFpags

        IF par_nKeyCode != 13 AND par_nKeyCode != 9 AND par_nKeyCode != 115
            RETURN
        ENDIF

        IF VARTYPE(THIS.pgf_4c_Principal) != "O"
            RETURN
        ENDIF
        loc_oGrid = THIS.pgf_4c_Principal.Page1.grd_4c_GradeOpe
        IF VARTYPE(loc_oGrid) != "O"
            RETURN
        ENDIF

        loc_cFpags = ALLTRIM(NVL(loc_oGrid.Column1.Text1.Value, ""))

        IF par_nKeyCode = 115 OR EMPTY(loc_cFpags)
            THIS.AbrirLookupFpags()
        ELSE
            IF THIS.this_oBusinessObject.ValidarLookupFpags(loc_cFpags)
                SELECT (THIS.this_oBusinessObject.this_cCursorOpe)
                REPLACE Descrs WITH ALLTRIM(THIS.this_oBusinessObject.this_cDescrs)
                THIS.this_oBusinessObject.this_lGravaDados = .T.
                loc_oGrid.Refresh()
            ELSE
                THIS.AbrirLookupFpags()
            ENDIF
        ENDIF
    ENDPROC

    *==========================================================================
    * AbrirLookupFpags - Abre picker FormBuscaAuxiliar para SigOpFp
    * Original: fwBuscaExt em Column1.Text1.Valid
    *==========================================================================
    PROTECTED PROCEDURE AbrirLookupFpags()
        LOCAL loc_oBusca, loc_oGrid, loc_cValAtual, loc_oErro
        TRY
            loc_oGrid = THIS.pgf_4c_Principal.Page1.grd_4c_GradeOpe
            loc_cValAtual = ""
            IF VARTYPE(loc_oGrid) = "O"
                loc_cValAtual = ALLTRIM(NVL(loc_oGrid.Column1.Text1.Value, ""))
            ENDIF

            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", ;
                gnConnHandle, ;
                "SigOpFp", ;
                "cursor_4c_FpNLkpPicker", ;
                "Fpags", ;
                loc_cValAtual, ;
                "Sele" + CHR(231) + CHR(227) + "o de Condi" + CHR(231) + CHR(227) + "o", ;
                .F., ;
                .T., ;
                "")

            IF VARTYPE(loc_oBusca) = "O"
                loc_oBusca.mAddColuna("Fpags",  "", "Condi" + CHR(231) + CHR(227) + "o de Pagamento")
                loc_oBusca.mAddColuna("descrs", "", "Descri" + CHR(231) + CHR(227) + "o")
                loc_oBusca.Show()

                IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_FpNLkpPicker")
                    SELECT cursor_4c_FpNLkpPicker
                    LOCAL loc_cFpagsEscolhido, loc_cDescrsEscolhido
                    loc_cFpagsEscolhido  = ALLTRIM(Fpags)
                    loc_cDescrsEscolhido = ALLTRIM(descrs)

                    SELECT (THIS.this_oBusinessObject.this_cCursorOpe)
                    REPLACE Fpags  WITH loc_cFpagsEscolhido
                    REPLACE Descrs WITH loc_cDescrsEscolhido
                    THIS.this_oBusinessObject.this_lGravaDados = .T.

                    IF VARTYPE(loc_oGrid) = "O"
                        loc_oGrid.Refresh()
                    ENDIF
                ENDIF

                IF USED("cursor_4c_FpNLkpPicker")
                    USE IN cursor_4c_FpNLkpPicker
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            IF USED("cursor_4c_FpNLkpPicker")
                USE IN cursor_4c_FpNLkpPicker
            ENDIF
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro em FormFpN.AbrirLookupFpags")
        ENDTRY
    ENDPROC

    *==========================================================================
    * BtnIncluirClick - Alias CRUD do CmdInserirClick (padrao esperado pelo pipeline)
    * Form OPERACIONAL: reusa a rotina real de insercao de linha vazia no grid
    *==========================================================================
    PROCEDURE BtnIncluirClick()
        THIS.CmdInserirClick()
    ENDPROC

    *==========================================================================
    * BtnAlterarClick - Alias CRUD; neste form OPERACIONAL a alteracao ocorre
    * diretamente na Column1 do grid (lookup Fpags). Foca a celula editavel
    * do registro corrente para permitir digitacao imediata.
    *==========================================================================
    PROCEDURE BtnAlterarClick()
        LOCAL loc_oGrid, loc_cCursor, loc_oErro
        TRY
            IF VARTYPE(THIS.pgf_4c_Principal) = "O"
                loc_oGrid = THIS.pgf_4c_Principal.Page1.grd_4c_GradeOpe
                IF VARTYPE(loc_oGrid) = "O"
                    loc_cCursor = THIS.this_oBusinessObject.this_cCursorOpe
                    IF USED(loc_cCursor)
                        SELECT (loc_cCursor)
                        IF RECCOUNT() > 0 AND !EOF()
                            loc_oGrid.Refresh()
                            loc_oGrid.Column1.SetFocus()
                        ELSE
                            MsgAviso("Nenhuma condi" + CHR(231) + CHR(227) + ;
                                "o de pagamento para alterar.", "Aviso")
                        ENDIF
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro em FormFpN.BtnAlterarClick")
        ENDTRY
    ENDPROC

    *==========================================================================
    * BtnVisualizarClick - Alias CRUD; foca o grid em modo leitura (sem editar)
    *==========================================================================
    PROCEDURE BtnVisualizarClick()
        LOCAL loc_oGrid, loc_cCursor, loc_oErro
        TRY
            IF VARTYPE(THIS.pgf_4c_Principal) = "O"
                loc_oGrid = THIS.pgf_4c_Principal.Page1.grd_4c_GradeOpe
                IF VARTYPE(loc_oGrid) = "O"
                    loc_cCursor = THIS.this_oBusinessObject.this_cCursorOpe
                    IF USED(loc_cCursor)
                        SELECT (loc_cCursor)
                        IF RECCOUNT() > 0
                            GO TOP
                            loc_oGrid.Refresh()
                            loc_oGrid.SetFocus()
                        ELSE
                            MsgAviso("Nenhuma condi" + CHR(231) + CHR(227) + ;
                                "o de pagamento cadastrada.", "Aviso")
                        ENDIF
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro em FormFpN.BtnVisualizarClick")
        ENDTRY
    ENDPROC

    *==========================================================================
    * BtnExcluirClick - Alias CRUD do CmdExcluirClick com confirmacao do usuario
    * Reusa a rotina real de exclusao de linha do grid
    *==========================================================================
    PROCEDURE BtnExcluirClick()
        LOCAL loc_oErro
        TRY
            IF MsgConfirma("Confirma a exclus" + CHR(227) + "o da condi" + ;
                CHR(231) + CHR(227) + "o de pagamento selecionada?", ;
                "Confirma" + CHR(231) + CHR(227) + "o")
                THIS.CmdExcluirClick()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro em FormFpN.BtnExcluirClick")
        ENDTRY
    ENDPROC

    *==========================================================================
    * BtnBuscarClick - Recarrega dados do servidor (buscar atualizado)
    * OPERACIONAL: nao ha filtro de pesquisa; recarrega registros da operacao
    *==========================================================================
    PROCEDURE BtnBuscarClick()
        LOCAL loc_oErro
        TRY
            IF NOT EMPTY(THIS.this_cDopes)
                THIS.CarregarDados()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro em FormFpN.BtnBuscarClick")
        ENDTRY
    ENDPROC

    *==========================================================================
    * BtnEncerrarClick - Fecha dialog sem salvar (alias de CmdCancelarClick)
    *==========================================================================
    PROCEDURE BtnEncerrarClick()
        THIS.CmdCancelarClick()
    ENDPROC

    *==========================================================================
    * BtnSalvarClick - Salva e fecha dialog (alias de CmdConfirmarClick)
    *==========================================================================
    PROCEDURE BtnSalvarClick()
        THIS.CmdConfirmarClick()
    ENDPROC

    *==========================================================================
    * BtnCancelarClick - Cancela sem salvar (alias de CmdCancelarClick)
    *==========================================================================
    PROCEDURE BtnCancelarClick()
        THIS.CmdCancelarClick()
    ENDPROC

    *==========================================================================
    * CarregarLista - Alias de CarregarDados para compatibilidade com pipeline
    *==========================================================================
    PROCEDURE CarregarLista()
        RETURN THIS.CarregarDados()
    ENDPROC

    *==========================================================================
    * FormParaBO - Nao aplicavel: form OPERACIONAL gerencia cursor diretamente
    * Retorna .T. para nao bloquear fluxos que chamem este metodo via heranca
    *==========================================================================
    PROTECTED PROCEDURE FormParaBO()
        RETURN .T.
    ENDPROC

    *==========================================================================
    * BOParaForm - Nao aplicavel: form OPERACIONAL gerencia cursor diretamente
    * Retorna .T. para nao bloquear fluxos que chamem este metodo via heranca
    *==========================================================================
    PROTECTED PROCEDURE BOParaForm()
        RETURN .T.
    ENDPROC

    *==========================================================================
    * HabilitarCampos - Nao aplicavel: form OPERACIONAL sem modo INCLUIR/ALTERAR
    * Stub de compatibilidade com FormBase
    *==========================================================================
    PROTECTED PROCEDURE HabilitarCampos(par_lHabilitar)
        RETURN
    ENDPROC

    *==========================================================================
    * LimparCampos - Nao aplicavel: form OPERACIONAL sem campos de Page2
    * Stub de compatibilidade com FormBase
    *==========================================================================
    PROTECTED PROCEDURE LimparCampos()
        RETURN
    ENDPROC

    *==========================================================================
    * AjustarBotoesPorModo - Nao aplicavel: form OPERACIONAL sem modo CRUD
    * Stub de compatibilidade com FormBase
    *==========================================================================
    PROTECTED PROCEDURE AjustarBotoesPorModo(par_cModo)
        RETURN
    ENDPROC

    *==========================================================================
    * Destroy - Reabilita form pai e libera recursos
    *==========================================================================
    PROCEDURE Destroy()
        IF VARTYPE(THIS.this_oParentForm) = "O" AND !ISNULL(THIS.this_oParentForm)
            THIS.this_oParentForm.Enabled = .T.
        ENDIF
        THIS.this_oParentForm     = .NULL.
        THIS.this_oBusinessObject = .NULL.
        DODEFAULT()
    ENDPROC

ENDDEFINE


### BO (C:\4c\projeto\app\classes\FpNBO.prg):
*====================================================================
* FpNBO.prg
*
* Business Object para Condicoes de Pagamento por Operacao
* Tabela: SigCdFpN (sigcdfpn)
* Schema: cidchaves char(20) PK, dopes char(20), fpags char(12)
* Herda de: BusinessBase
*====================================================================

DEFINE CLASS FpNBO AS BusinessBase

    *-- Campos de SigCdFpN (mapeamento direto com a tabela)
    this_cIdChaves = ""    && cidchaves char(20) - PK (chave unica)
    this_cDopes    = ""    && dopes char(20) - codigo da operacao (FK SigCdOpe)
    this_cFpags    = ""    && fpags char(12) - codigo da condicao de pagamento (FK SigOpFp)

    *-- Campo auxiliar de lookup (SigOpFp.descrs - nao armazenado em SigCdFpN)
    this_cDescrs   = ""    && descrs char(30) - descricao da condicao (SigOpFp)

    *-- Controle de estado operacional
    this_lGravaDados = .F. && .T. se houver alteracoes pendentes de gravacao

    *-- Cursores de trabalho
    this_cCursorOpe    = "cursor_4c_xOpe"        && cursor editavel do grid
    this_cCursorDados  = "cursor_4c_SigCdFpN"    && cursor de dados SQL Server

    *====================================================================
    * Init - Inicializa Business Object
    *====================================================================
    PROCEDURE Init()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            DODEFAULT()
            THIS.this_cTabela     = "SigCdFpN"
            THIS.this_cCampoChave = "cIdChaves"
            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MostrarErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "FpNBO.Init")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * ObterChavePrimaria - Retorna chave primaria para auditoria
    *====================================================================
    FUNCTION ObterChavePrimaria()
        RETURN ALLTRIM(THIS.this_cIdChaves)
    ENDFUNC

    *====================================================================
    * CarregarDoCursor - Carrega propriedades a partir de cursor
    *====================================================================
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            IF USED(par_cAliasCursor)
                SELECT (par_cAliasCursor)
                THIS.this_cIdChaves = TratarNulo(cIdChaves, "C")
                THIS.this_cDopes    = TratarNulo(Dopes,     "C")
                THIS.this_cFpags    = TratarNulo(Fpags,     "C")
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MostrarErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "FpNBO.CarregarDoCursor")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * InicializarCursorTrabalho - Cria cursor editavel para o grid
    * Estrutura identica ao cursor xOpe do legado
    *====================================================================
    PROCEDURE InicializarCursorTrabalho()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            IF USED(THIS.this_cCursorOpe)
                USE IN (THIS.this_cCursorOpe)
            ENDIF
            SET NULL ON
            CREATE CURSOR (THIS.this_cCursorOpe) ;
                (Dopes C(20) NULL, Fpags C(12) NULL, Descrs C(30) NULL)
            SET NULL OFF
            INDEX ON Dopes TAG Dopes
            SET ORDER TO
            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MostrarErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "FpNBO.InicializarCursorTrabalho")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * CarregarRegistros - Carrega SigCdFpN + descricao SigOpFp para o grid
    * par_cDopes = codigo da operacao (FK SigCdOpe.Dopes)
    *====================================================================
    PROCEDURE CarregarRegistros(par_cDopes)
        LOCAL loc_lSucesso, loc_cSQL, loc_nRet
        loc_lSucesso = .F.
        TRY
            IF !THIS.InicializarCursorTrabalho()
                loc_lSucesso = .F.
            ENDIF

            loc_cSQL = "SELECT a.Dopes, a.Fpags, b.descrs " + ;
                       "FROM SigCdFpN a " + ;
                       "INNER JOIN SigOpFp b ON a.Fpags = b.Fpags " + ;
                       "WHERE a.Dopes = " + EscaparSQL(ALLTRIM(par_cDopes))

            loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_FpNTemp")
            IF loc_nRet < 1
                MsgAviso("Erro ao carregar condi" + CHR(231) + CHR(245) + ;
                    "es de pagamento para opera" + CHR(231) + CHR(227) + "o: " + ;
                    ALLTRIM(par_cDopes), "Aviso")
                loc_lSucesso = .F.
            ENDIF

            SELECT (THIS.this_cCursorOpe)
            APPEND FROM DBF("cursor_4c_FpNTemp")

            IF USED("cursor_4c_FpNTemp")
                USE IN cursor_4c_FpNTemp
            ENDIF

            SELECT (THIS.this_cCursorOpe)
            SET ORDER TO
            GO TOP

            loc_lSucesso = .T.
        CATCH TO loc_oErro
            IF USED("cursor_4c_FpNTemp")
                USE IN cursor_4c_FpNTemp
            ENDIF
            MostrarErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "FpNBO.CarregarRegistros")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * InserirLinhaVazia - Adiciona linha em branco no cursor de trabalho
    *====================================================================
    PROCEDURE InserirLinhaVazia()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            IF USED(THIS.this_cCursorOpe)
                SELECT (THIS.this_cCursorOpe)
                INSERT INTO (THIS.this_cCursorOpe) (Fpags) VALUES (SPACE(12))
                THIS.this_lGravaDados = .T.
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MostrarErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "FpNBO.InserirLinhaVazia")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * ExcluirLinhaAtual - Exclui linha corrente do cursor de trabalho
    *====================================================================
    PROCEDURE ExcluirLinhaAtual()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            IF USED(THIS.this_cCursorOpe)
                SELECT (THIS.this_cCursorOpe)
                IF NOT EOF()
                    DELETE
                    SKIP
                    IF EOF()
                        GO BOTTOM
                    ENDIF
                    THIS.this_lGravaDados = .T.
                    loc_lSucesso = .T.
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MostrarErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "FpNBO.ExcluirLinhaAtual")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * ValidarDuplicatas - Verifica se ha condicoes de pagamento duplicadas
    * Retorna .T. se SEM duplicatas, .F. se houver
    *====================================================================
    FUNCTION ValidarDuplicatas()
        LOCAL loc_lValido, loc_nDupls
        loc_lValido = .T.
        TRY
            IF USED(THIS.this_cCursorOpe)
                SELECT Fpags, COUNT(*) AS Qt ;
                    FROM (THIS.this_cCursorOpe) ;
                    WHERE NOT DELETED() AND NOT EMPTY(ALLTRIM(Fpags)) ;
                    GROUP BY Fpags ;
                    HAVING COUNT(*) > 1 ;
                    INTO CURSOR cursor_4c_FpNDupl

                loc_nDupls = RECCOUNT("cursor_4c_FpNDupl")
                IF USED("cursor_4c_FpNDupl")
                    USE IN cursor_4c_FpNDupl
                ENDIF

                IF loc_nDupls > 0
                    MsgAviso("Existem lan" + CHR(231) + "amentos de Condi" + CHR(231) + ;
                        CHR(245) + "es Em Duplicidade!!!", ;
                        "Valida" + CHR(231) + CHR(227) + "o")
                    loc_lValido = .F.
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            IF USED("cursor_4c_FpNDupl")
                USE IN cursor_4c_FpNDupl
            ENDIF
            MostrarErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "FpNBO.ValidarDuplicatas")
            loc_lValido = .F.
        ENDTRY
        RETURN loc_lValido
    ENDFUNC

    *====================================================================
    * ValidarLookupFpags - Valida codigo de condicao de pagamento no SQL Server
    * Retorna .T. se encontrado e preenche this_cDescrs
    *====================================================================
    FUNCTION ValidarLookupFpags(par_cFpags)
        LOCAL loc_lEncontrou, loc_cSQL, loc_nRet
        loc_lEncontrou = .F.
        TRY
            IF NOT EMPTY(ALLTRIM(par_cFpags))
                loc_cSQL = "SELECT TOP 1 Fpags, descrs FROM SigOpFp " + ;
                           "WHERE Fpags = " + EscaparSQL(ALLTRIM(par_cFpags))

                loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_FpNLkp")
                IF loc_nRet >= 1 AND RECCOUNT("cursor_4c_FpNLkp") > 0
                    SELECT cursor_4c_FpNLkp
                    THIS.this_cFpags  = ALLTRIM(Fpags)
                    THIS.this_cDescrs = ALLTRIM(descrs)
                    loc_lEncontrou = .T.
                ENDIF
                IF USED("cursor_4c_FpNLkp")
                    USE IN cursor_4c_FpNLkp
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            IF USED("cursor_4c_FpNLkp")
                USE IN cursor_4c_FpNLkp
            ENDIF
            MostrarErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "FpNBO.ValidarLookupFpags")
        ENDTRY
        RETURN loc_lEncontrou
    ENDFUNC

    *====================================================================
    * Inserir - Insere registro unico em SigCdFpN via SQLEXEC
    *====================================================================
    FUNCTION Inserir()
        LOCAL loc_lSucesso, loc_cSQL, loc_nRet
        loc_lSucesso = .F.
        TRY
            IF EMPTY(ALLTRIM(THIS.this_cDopes)) OR EMPTY(ALLTRIM(THIS.this_cFpags))
                MsgAviso("Opera" + CHR(231) + CHR(227) + "o e Condi" + CHR(231) + ;
                    CHR(227) + "o de Pagamento s" + CHR(227) + "o obrigat" + CHR(243) + "rios.", ;
                    "Valida" + CHR(231) + CHR(227) + "o")
                loc_lSucesso = .F.
            ENDIF

            THIS.this_cIdChaves = LEFT(SYS(2015) + SYS(2015), 20)

            loc_cSQL = "INSERT INTO SigCdFpN (cIdChaves, Dopes, Fpags) VALUES (" + ;
                       EscaparSQL(THIS.this_cIdChaves) + ", " + ;
                       EscaparSQL(ALLTRIM(THIS.this_cDopes)) + ", " + ;
                       EscaparSQL(ALLTRIM(THIS.this_cFpags)) + ")"

            loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL, "")
            IF loc_nRet >= 0
                THIS.RegistrarAuditoria("INSERIR")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao inserir condi" + CHR(231) + CHR(227) + "o de pagamento.", "FpNBO.Inserir")
            ENDIF
        CATCH TO loc_oErro
            MostrarErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "FpNBO.Inserir")
        ENDTRY
        RETURN loc_lSucesso
    ENDFUNC

    *====================================================================
    * Atualizar - Atualiza registro unico em SigCdFpN via SQLEXEC
    *====================================================================
    FUNCTION Atualizar()
        LOCAL loc_lSucesso, loc_cSQL, loc_nRet
        loc_lSucesso = .F.
        TRY
            IF EMPTY(ALLTRIM(THIS.this_cDopes)) OR EMPTY(ALLTRIM(THIS.this_cFpags))
                MsgAviso("Registro n" + CHR(227) + "o identificado para atualiza" + ;
                    CHR(231) + CHR(227) + "o.", "Valida" + CHR(231) + CHR(227) + "o")
                loc_lSucesso = .F.
            ENDIF

            loc_cSQL = "UPDATE SigCdFpN SET " + ;
                       "Fpags = " + EscaparSQL(ALLTRIM(THIS.this_cFpags)) + " " + ;
                       "WHERE Dopes = " + EscaparSQL(ALLTRIM(THIS.this_cDopes)) + ;
                       " AND Fpags = " + EscaparSQL(ALLTRIM(THIS.this_cFpags))

            loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL, "")
            IF loc_nRet >= 0
                THIS.RegistrarAuditoria("ATUALIZAR")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao atualizar condi" + CHR(231) + CHR(227) + "o de pagamento.", "FpNBO.Atualizar")
            ENDIF
        CATCH TO loc_oErro
            MostrarErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "FpNBO.Atualizar")
        ENDTRY
        RETURN loc_lSucesso
    ENDFUNC

    *====================================================================
    * ExecutarExclusao - Exclui registro unico por chave primaria
    *====================================================================
    PROTECTED FUNCTION ExecutarExclusao()
        LOCAL loc_lSucesso, loc_cSQL, loc_nRet
        loc_lSucesso = .F.
        TRY
            IF EMPTY(ALLTRIM(THIS.this_cDopes)) OR EMPTY(ALLTRIM(THIS.this_cFpags))
                loc_lSucesso = .F.
            ENDIF

            loc_cSQL = "DELETE FROM SigCdFpN WHERE Dopes = " + ;
                       EscaparSQL(ALLTRIM(THIS.this_cDopes)) + ;
                       " AND Fpags = " + EscaparSQL(ALLTRIM(THIS.this_cFpags))

            loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL, "")
            IF loc_nRet >= 0
                THIS.RegistrarAuditoria("EXCLUIR")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao excluir condi" + CHR(231) + CHR(227) + "o de pagamento.", ;
                    "FpNBO.ExecutarExclusao")
            ENDIF
        CATCH TO loc_oErro
            MostrarErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "FpNBO.ExecutarExclusao")
        ENDTRY
        RETURN loc_lSucesso
    ENDFUNC

    *====================================================================
    * Salvar - Salva todas as condicoes de pagamento de uma operacao
    * Fluxo: validar duplicatas -> DELETE todos -> INSERT novos -> COMMIT
    * par_cDopes = codigo da operacao (FK SigCdOpe.Dopes)
    *====================================================================
    FUNCTION Salvar(par_cDopes)
        LOCAL loc_lSucesso, loc_nRet, loc_cSql, loc_cIdChaves, loc_cFpags
        loc_lSucesso = .F.
        TRY
            *-- 1. Validar duplicatas antes de qualquer operacao SQL
            IF NOT THIS.ValidarDuplicatas()
                loc_lSucesso = .F.
            ENDIF

            *-- 2. Excluir todos os registros existentes para a operacao
            loc_cSql = "DELETE FROM SigCdFpN WHERE Dopes = " + EscaparSQL(ALLTRIM(par_cDopes))
            loc_nRet = SQLEXEC(gnConnHandle, loc_cSql, "")
            IF loc_nRet < 0
                MsgErro("Erro ao excluir registros anteriores de " + ALLTRIM(par_cDopes) + ".", ;
                    "FpNBO.Salvar")
                loc_lSucesso = .F.
            ENDIF

            *-- 3. Inserir registros nao-excluidos e nao-vazios do cursor de trabalho
            SELECT (THIS.this_cCursorOpe)
            SCAN FOR NOT DELETED() AND NOT EMPTY(ALLTRIM(Fpags))
                loc_cFpags    = ALLTRIM(Fpags)
                loc_cIdChaves = LEFT(SYS(2015) + SYS(2015), 20)

                loc_cSql = "INSERT INTO SigCdFpN (cIdChaves, Dopes, Fpags) VALUES (" + ;
                           EscaparSQL(loc_cIdChaves) + ", " + ;
                           EscaparSQL(ALLTRIM(par_cDopes)) + ", " + ;
                           EscaparSQL(loc_cFpags) + ")"

                loc_nRet = SQLEXEC(gnConnHandle, loc_cSql, "")
                IF loc_nRet < 0
                    MsgErro("Erro ao inserir condi" + CHR(231) + CHR(227) + "o: " + loc_cFpags + ".", ;
                        "FpNBO.Salvar")
                    loc_lSucesso = .F.
                ENDIF

                SELECT (THIS.this_cCursorOpe)
            ENDSCAN

            *-- 4. Auditoria
            THIS.this_cDopes = ALLTRIM(par_cDopes)
            THIS.RegistrarAuditoria("ATUALIZAR")

            THIS.this_lGravaDados = .F.
            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MostrarErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "FpNBO.Salvar")
        ENDTRY
        RETURN loc_lSucesso
    ENDFUNC

    *====================================================================
    * Destroy - Libera cursores ao destruir o BO
    *====================================================================
    PROCEDURE Destroy()
        IF USED(THIS.this_cCursorOpe)
            USE IN (THIS.this_cCursorOpe)
        ENDIF
        IF USED(THIS.this_cCursorDados)
            USE IN (THIS.this_cCursorDados)
        ENDIF
        DODEFAULT()
    ENDPROC

ENDDEFINE


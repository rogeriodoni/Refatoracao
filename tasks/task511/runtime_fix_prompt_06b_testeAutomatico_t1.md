# CORRIGIR ERRO DE RUNTIME VFP9

## TAREFA OBRIGATORIA
O formulario VFP9 apresentou erro de runtime durante teste automatizado.
Voce DEVE corrigir o erro e salvar os arquivos corrigidos usando Write tool.

## ERRO DETECTADO
- Etapa: 06b_testeAutomatico
- Tentativa: 1/10
- Mensagem: Testes automaticos: 0% < 100%. Falhas: Teste 'Instanciacao': CREATEOBJECT retornou valor nao-objeto

## CONTEXTO DO ERRO

### ERROS CAPTURADOS EM MODO TESTE (vfp_error_details.txt):
[23/08/2026 09:55:40 AM] Formrgr.InicializarForm: Erro ao inicializar Formrgr: | Property BORDERWIDTH is not found. | Linha: 653


### LOG DA ETAPA (06b_testeAutomatico):
[2026-08-23 09:53:57] [INFO] === VFP EXECUTOR v2.0 ===
[2026-08-23 09:53:57] [INFO] Config FPW: (nao fornecido)
[2026-08-23 09:53:57] [INFO] Script PRG: C:\4c\projeto\app\utils\TesteAutomatico.prg
[2026-08-23 09:53:57] [INFO] Timeout: 300 segundos
[2026-08-23 09:53:57] [INFO] Wrapper PRG criado para parametros: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_im5ri3pn.prg
[2026-08-23 09:53:57] [INFO] Conteudo do wrapper:
[2026-08-23 09:53:57] [INFO] * Auto-generated wrapper for parameters
* Script: C:\4c\projeto\app\utils\TesteAutomatico.prg
* Parameters: 'Formrgr', 'C:\4c\tasks\task511', 'CRUD'

* Anti-dialog protections for unattended execution
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
SET NOTIFY OFF
SYS(2335, 0)

DO "C:\4c\projeto\app\utils\TesteAutomatico" WITH 'Formrgr', 'C:\4c\tasks\task511', 'CRUD'
QUIT

[2026-08-23 09:53:57] [INFO] Comando VFP: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_im5ri3pn.prg
[2026-08-23 09:53:57] [INFO] VFP output esperado em: C:\4c\tasks\task511\vfp_output.txt
[2026-08-23 09:53:57] [INFO] Executando Visual FoxPro 9...
[2026-08-23 09:53:57] [INFO] Comando completo: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_im5ri3pn.prg
[2026-08-23 09:53:57] [INFO] Executando: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_im5ri3pn.prg
[2026-08-23 09:53:57] [INFO] Timeout configurado: 300 segundos
[2026-08-23 09:55:40] [INFO] VFP9 finalizou normalmente com exit code: 
[2026-08-23 09:55:40] [INFO] VFP9 finalizado em 102.8167042 segundos
[2026-08-23 09:55:40] [INFO] Exit Code: 
[2026-08-23 09:55:40] [INFO] 
[2026-08-23 09:55:40] [INFO] Arquivos temporarios preservados para inspecao:
[2026-08-23 09:55:40] [INFO]   Wrapper.prg: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_im5ri3pn.prg
[2026-08-23 09:55:40] [INFO] 
[2026-08-23 09:55:40] [INFO] === Conteudo do Wrapper.prg temporario ===
[2026-08-23 09:55:40] [INFO] * Auto-generated wrapper for parameters
[2026-08-23 09:55:40] [INFO] * Script: C:\4c\projeto\app\utils\TesteAutomatico.prg
[2026-08-23 09:55:40] [INFO] * Parameters: 'Formrgr', 'C:\4c\tasks\task511', 'CRUD'
[2026-08-23 09:55:40] [INFO] 
[2026-08-23 09:55:40] [INFO] * Anti-dialog protections for unattended execution
[2026-08-23 09:55:40] [INFO] SET SAFETY OFF
[2026-08-23 09:55:40] [INFO] SET RESOURCE OFF
[2026-08-23 09:55:40] [INFO] SET TALK OFF
[2026-08-23 09:55:40] [INFO] SET NOTIFY OFF
[2026-08-23 09:55:40] [INFO] SYS(2335, 0)
[2026-08-23 09:55:40] [INFO] 
[2026-08-23 09:55:40] [INFO] DO "C:\4c\projeto\app\utils\TesteAutomatico" WITH 'Formrgr', 'C:\4c\tasks\task511', 'CRUD'
[2026-08-23 09:55:40] [INFO] QUIT
[2026-08-23 09:55:40] [INFO] 
[2026-08-23 09:55:40] [INFO] === Fim do Wrapper.prg ===
[2026-08-23 09:55:40] [WARN] AVISO: VFP9 retornou exit code  (normal para VFP9 GUI - validar pelo arquivo de saida)


### RESULTADO DOS TESTES (teste_resultado.json):
{
  "formClass": "Formrgr",
  "timestamp": "20260823095540",
  "testes": [
    {
      "nome": "Instanciacao",
      "passou": false,
      "erro": "CREATEOBJECT retornou valor nao-objeto",
      "detalhes": ""
    }
  ],
  "resumo": {
    "total": 1,
    "passou": 0,
    "falhou": 1,
    "percentual": 0
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

### FORM (C:\4c\projeto\app\forms\cadastros\Formrgr.prg):
*==============================================================================
* Formrgr.prg - Formulario de Cadastro de Regras de E-Commerce
* Migrado de: SIGCDRGR.SCX (frmcadastro)
* Tabelas: SigCdRGR (cabecalho), SigCdRga (regras - grid Page2)
* DataSession = 2 (private); compensacao PageFrame +27 (Pagina.Top=-27 original)
*==============================================================================

DEFINE CLASS Formrgr AS FormBase

    *-- Propriedades visuais (PILAR 1 - UX FIDELITY: exatos do original)
    Height      = 600
    Width       = 1000
    Caption     = "Regras de E-Commerce"
    AutoCenter  = .T.
    ShowWindow  = 1
    WindowType  = 1
    ControlBox  = .F.
    TitleBar    = 0
    Themes      = .F.
    BorderStyle = 2
    DataSession = 2

    *-- Propriedades de estado
    this_oBusinessObject = .NULL.
    this_cModoAtual      = "LISTA"

    *===========================================================================
    * Init - REGRA CRITICA: apenas RETURN DODEFAULT()
    * FormBase.Init() ja chama InicializarForm() via DODEFAULT - NAO duplicar!
    *===========================================================================
    PROCEDURE Init()
        RETURN DODEFAULT()
    ENDPROC

    *===========================================================================
    * InicializarForm - Configura estrutura completa (chamado pelo FormBase.Init)
    *===========================================================================
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            THIS.this_oBusinessObject = CREATEOBJECT("rgrBO")

            IF VARTYPE(THIS.this_oBusinessObject) != "O"
                MostrarErro("Erro ao criar rgrBO" + CHR(13) + ;
                    "VARTYPE retornou: " + VARTYPE(THIS.this_oBusinessObject), ;
                    "Formrgr.InicializarForm")
            ELSE
                SET DELETED ON
                THIS.ConfigurarPageFrame()

                THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
                THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
                THIS.pgf_4c_Paginas.Visible  = .T.
                THIS.pgf_4c_Paginas.ActivePage = 1
                THIS.this_cModoAtual = "LISTA"

                IF TYPE("gb_4c_ValidandoUI") != "L" OR !gb_4c_ValidandoUI
                    THIS.CarregarLista()
                ENDIF

                loc_lSucesso = .T.
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao inicializar Formrgr:" + CHR(13) + ;
                loException.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loException.LineNo), ;
                "Formrgr.InicializarForm")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *===========================================================================
    * ConfigurarPageFrame - Cria PageFrame com Page1 (Lista) e Page2 (Dados)
    * Pagina.Top = -27 no original; compensacao +27 em controles das Pages
    *===========================================================================
    PROTECTED PROCEDURE ConfigurarPageFrame()
        THIS.AddObject("pgf_4c_Paginas", "PageFrame")

        WITH THIS.pgf_4c_Paginas
            .PageCount = 2
            .Top       = -27
            .Left      = 0
            .Width     = THIS.Width
            .Height    = THIS.Height + 27
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
    * ConfigurarPaginaLista - Page1: cabecalho, 5 botoes CRUD e grid SigCdRGR
    *===========================================================================
    PROTECTED PROCEDURE ConfigurarPaginaLista()
        LOCAL loc_oPagina, loc_oBotoes
        loc_oPagina = THIS.pgf_4c_Paginas.Page1

        *-- Fundo padrao do framework frmcadastro (sem isso a pagina fica branca)
        loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"

        *-- Container Cabecalho (cntSombra no legado: Top=2; +27 compensacao = 29)
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
            .Width     = 769
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
            .Width     = 769
            .Height    = 46
            .FontName  = "Tahoma"
            .FontSize  = 16
            .FontBold  = .T.
            .ForeColor = RGB(255, 255, 255)
            .BackStyle = 0
            .AutoSize  = .F.
            .Visible   = .T.
        ENDWITH

        *-- Container Botoes CRUD (Grupo_op no legado: Left=542, Top=27 canonico)
        loc_oPagina.AddObject("cnt_4c_Botoes", "Container")
        WITH loc_oPagina.cnt_4c_Botoes
            .Top         = 27
            .Left        = 542
            .Width       = 390
            .Height      = 85
            .BackStyle   = 0
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH

        loc_oBotoes = loc_oPagina.cnt_4c_Botoes

        *-- Botao Incluir (Left=5)
        loc_oBotoes.AddObject("cmd_4c_Incluir", "CommandButton")
        WITH loc_oBotoes.cmd_4c_Incluir
            .Caption         = "Incluir"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_inserir_26.jpg"
            .PicturePosition = 13
            .Top             = 5
            .Left            = 5
            .Width           = 75
            .Height          = 75
            .FontName        = "Tahoma"
            .FontSize        = 8
            .FontBold        = .T.
            .FontItalic      = .T.
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .Themes          = .F.
            .SpecialEffect   = 0
            .MousePointer    = 15
            .WordWrap        = .T.
            .AutoSize        = .F.
            .Visible         = .T.
        ENDWITH
        BINDEVENT(loc_oBotoes.cmd_4c_Incluir, "Click", THIS, "BtnIncluirClick")

        *-- Botao Visualizar (Left=80)
        loc_oBotoes.AddObject("cmd_4c_Visualizar", "CommandButton")
        WITH loc_oBotoes.cmd_4c_Visualizar
            .Caption         = "Visualizar"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_vizualizar_60.jpg"
            .PicturePosition = 13
            .Top             = 5
            .Left            = 80
            .Width           = 75
            .Height          = 75
            .FontName        = "Tahoma"
            .FontSize        = 8
            .FontBold        = .T.
            .FontItalic      = .T.
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .Themes          = .F.
            .SpecialEffect   = 0
            .MousePointer    = 15
            .WordWrap        = .T.
            .AutoSize        = .F.
            .Visible         = .T.
        ENDWITH
        BINDEVENT(loc_oBotoes.cmd_4c_Visualizar, "Click", THIS, "BtnVisualizarClick")

        *-- Botao Alterar (Left=155)
        loc_oBotoes.AddObject("cmd_4c_Alterar", "CommandButton")
        WITH loc_oBotoes.cmd_4c_Alterar
            .Caption         = "Alterar"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_alterar_60.jpg"
            .PicturePosition = 13
            .Top             = 5
            .Left            = 155
            .Width           = 75
            .Height          = 75
            .FontName        = "Tahoma"
            .FontSize        = 8
            .FontBold        = .T.
            .FontItalic      = .T.
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .Themes          = .F.
            .SpecialEffect   = 0
            .MousePointer    = 15
            .WordWrap        = .T.
            .AutoSize        = .F.
            .Visible         = .T.
        ENDWITH
        BINDEVENT(loc_oBotoes.cmd_4c_Alterar, "Click", THIS, "BtnAlterarClick")

        *-- Botao Excluir (Left=230)
        loc_oBotoes.AddObject("cmd_4c_Excluir", "CommandButton")
        WITH loc_oBotoes.cmd_4c_Excluir
            .Caption         = "Excluir"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_excluir_60.jpg"
            .PicturePosition = 13
            .Top             = 5
            .Left            = 230
            .Width           = 75
            .Height          = 75
            .FontName        = "Tahoma"
            .FontSize        = 8
            .FontBold        = .T.
            .FontItalic      = .T.
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .Themes          = .F.
            .SpecialEffect   = 0
            .MousePointer    = 15
            .WordWrap        = .T.
            .AutoSize        = .F.
            .Visible         = .T.
        ENDWITH
        BINDEVENT(loc_oBotoes.cmd_4c_Excluir, "Click", THIS, "BtnExcluirClick")

        *-- Botao Buscar (Left=305)
        loc_oBotoes.AddObject("cmd_4c_Buscar", "CommandButton")
        WITH loc_oBotoes.cmd_4c_Buscar
            .Caption         = "Buscar"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_procurar_60.jpg"
            .PicturePosition = 13
            .Top             = 5
            .Left            = 305
            .Width           = 75
            .Height          = 75
            .FontName        = "Tahoma"
            .FontSize        = 8
            .FontBold        = .T.
            .FontItalic      = .T.
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .Themes          = .F.
            .SpecialEffect   = 0
            .MousePointer    = 15
            .WordWrap        = .T.
            .AutoSize        = .F.
            .Visible         = .T.
        ENDWITH
        BINDEVENT(loc_oBotoes.cmd_4c_Buscar, "Click", THIS, "BtnBuscarClick")

        *-- Container Saida - PADRAO CANONICO (CLAUDE.md #10)
        loc_oPagina.AddObject("cnt_4c_Saida", "Container")
        WITH loc_oPagina.cnt_4c_Saida
            .Top         = 27
            .Left        = 917
            .Width       = 90
            .Height      = 85
            .BackStyle   = 0
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH

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
            .FontSize        = 8
            .FontBold        = .T.
            .FontItalic      = .T.
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

        *-- Grid de lista SigCdRGR (Top=115 = 88+27 compensacao PageFrame)
        *-- Width=880 para nao sobrepor cnt_4c_Saida (Left=917)
        loc_oPagina.AddObject("grd_4c_Lista", "Grid")
        WITH loc_oPagina.grd_4c_Lista
            .Top                = 115
            .Left               = 26
            .Width              = 880
            .Height             = 478
            .ColumnCount        = 2
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
            .ReadOnly           = .T.
            .Visible            = .T.
        ENDWITH

        WITH loc_oPagina.grd_4c_Lista
            .Column1.Width     = 100
            .Column1.Alignment = 0
            .Column2.Width     = 250
            .Column2.Alignment = 0
        ENDWITH

        BINDEVENT(loc_oPagina.grd_4c_Lista, "DblClick", THIS, "BtnVisualizarClick")

        THIS.TornarControlesVisiveis(loc_oPagina)
    ENDPROC

    *===========================================================================
    * ConfigurarPaginaDados - Page2: campos do cabecalho SigCdRGR + grid SigCdRga
    * Compensacao PageFrame: pgf_4c_Paginas.Top=-27 -> todos os Tops +27
    *===========================================================================
    PROTECTED PROCEDURE ConfigurarPaginaDados()
        LOCAL loc_oPagina, loc_oGrd, loc_oCmdGrp1, loc_oCmdGrp2
        loc_oPagina = THIS.pgf_4c_Paginas.Page2

        *-- Fundo padrao do framework frmcadastro (sem isso a pagina fica branca)
        loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"

        *-- Container Salvar/Cancelar (Grupo_Salva: Left=638, Top=8+27=35)
        loc_oPagina.AddObject("cnt_4c_Salva", "Container")
        WITH loc_oPagina.cnt_4c_Salva
            .Top         = 35
            .Left        = 638
            .Width       = 160
            .Height      = 85
            .BackStyle = 1
            .BackColor = RGB(255, 255, 255)
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH

        loc_oPagina.cnt_4c_Salva.AddObject("cmd_4c_Confirmar", "CommandButton")
        WITH loc_oPagina.cnt_4c_Salva.cmd_4c_Confirmar
            .Caption         = "Salvar"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
            .PicturePosition = 13
            .Top             = 5
            .Left            = 5
            .Width           = 75
            .Height          = 75
            .FontName        = "Tahoma"
            .FontSize        = 8
            .FontBold        = .T.
            .FontItalic      = .T.
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .Themes          = .F.
            .SpecialEffect   = 0
            .MousePointer    = 15
            .WordWrap        = .T.
            .AutoSize        = .F.
            .Visible         = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.cnt_4c_Salva.cmd_4c_Confirmar, "Click", THIS, "BtnSalvarClick")

        loc_oPagina.cnt_4c_Salva.AddObject("cmd_4c_Cancelar", "CommandButton")
        WITH loc_oPagina.cnt_4c_Salva.cmd_4c_Cancelar
            .Caption         = "Encerrar"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_cancelar_60.jpg"
            .PicturePosition = 13
            .Top             = 5
            .Left            = 80
            .Width           = 75
            .Height          = 75
            .FontName        = "Tahoma"
            .FontSize        = 8
            .FontBold        = .T.
            .FontItalic      = .T.
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .Themes          = .F.
            .SpecialEffect   = 0
            .MousePointer    = 15
            .WordWrap        = .T.
            .AutoSize        = .F.
            .Visible         = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.cnt_4c_Salva.cmd_4c_Cancelar, "Click", THIS, "BtnCancelarClick")

        *-- Label + TextBox Codigo (getCodigo: Top=54+27=81, Left=227, Width=82)
        loc_oPagina.AddObject("lbl_4c_LblGrupo", "Label")
        WITH loc_oPagina.lbl_4c_LblGrupo
            .Caption   = "C" + CHR(243) + "digo :"
            .Top       = 85
            .Left      = 181
            .Width     = 42
            .Height    = 17
            .FontName  = "Tahoma"
            .FontSize  = 8
            .AutoSize  = .F.
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("txt_4c_Codigo", "TextBox")
        WITH loc_oPagina.txt_4c_Codigo
            .Value     = ""
            .Top       = 81
            .Left      = 227
            .Width     = 82
            .Height    = 23
            .FontName  = "Tahoma"
            .FontSize  = 8
            .MaxLength = 10
            .ReadOnly  = .F.
            .Visible   = .T.
        ENDWITH

        *-- CheckBox Inativa (Check1: Top=58+27=85, Left=320)
        loc_oPagina.AddObject("chk_4c_Check1", "CheckBox")
        WITH loc_oPagina.chk_4c_Check1
            .Caption   = "Inativa"
            .Value     = 0
            .Top       = 85
            .Left      = 320
            .Width     = 52
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Visible   = .T.
        ENDWITH

        *-- Label + TextBox Descricao (GetDescricao: Top=80+27=107, Left=227, Width=351)
        loc_oPagina.AddObject("lbl_4c_Label6", "Label")
        WITH loc_oPagina.lbl_4c_Label6
            .Caption   = "Descri" + CHR(231) + CHR(227) + "o :"
            .Top       = 110
            .Left      = 168
            .Width     = 55
            .Height    = 17
            .FontName  = "Tahoma"
            .FontSize  = 8
            .AutoSize  = .F.
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("txt_4c_Descricao", "TextBox")
        WITH loc_oPagina.txt_4c_Descricao
            .Value     = ""
            .Top       = 107
            .Left      = 227
            .Width     = 351
            .Height    = 21
            .FontName  = "Tahoma"
            .FontSize  = 8
            .MaxLength = 40
            .ReadOnly  = .F.
            .Visible   = .T.
        ENDWITH
        *-- LostFocus: se descricao preenchida e modo edicao, insere linha vazia na grade
        BINDEVENT(loc_oPagina.txt_4c_Descricao, "KeyPress", THIS, "DescricaoLostFocus")

        *-- Label + TextBox Valor (getValor: Top=104+27=131, Left=227, Width=105)
        loc_oPagina.AddObject("lbl_4c_Label2", "Label")
        WITH loc_oPagina.lbl_4c_Label2
            .Caption   = "Valor acima de :"
            .Top       = 136
            .Left      = 145
            .Width     = 78
            .Height    = 17
            .FontName  = "Tahoma"
            .FontSize  = 8
            .AutoSize  = .F.
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("txt_4c_Valor", "TextBox")
        WITH loc_oPagina.txt_4c_Valor
            .Value     = 0
            .Top       = 131
            .Left      = 227
            .Width     = 105
            .Height    = 21
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Format    = "N"
            .InputMask = "999,999,999.99"
            .ReadOnly  = .F.
            .Visible   = .T.
        ENDWITH

        *-- Grid SigCdRga (grdRegra: Top=129+27=156, Left=11, Width=739, Height=371)
        *-- Cursor placeholder criado aqui; ZAP preserva estrutura em CarregarGradeRegra (Problem 34)
        IF !USED("csSigCdRga")
            CREATE CURSOR csSigCdRga ( ;
                cIdChaves  C(20), ;
                Codigo     C(10), ;
                Empresa    C(3),  ;
                Grupo      C(10), ;
                Conta      C(10), ;
                Colecao    C(20), ;
                Quantidade N(3,0), ;
                Prioridade N(3,0), ;
                GrupoPr    C(3),  ;
                Zerar      C(1),  ;
                Ordem      C(1)   ;
            )
        ENDIF

        loc_oPagina.AddObject("grd_4c_Dados", "Grid")

        *-- RecordSource + ColumnCount FORA do WITH (Problem 36/48)
        loc_oPagina.grd_4c_Dados.RecordSource = "csSigCdRga"
        loc_oPagina.grd_4c_Dados.ColumnCount  = 9

        WITH loc_oPagina.grd_4c_Dados
            .Top                = 156
            .Left               = 11
            .Width              = 739
            .Height             = 371
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
            .ReadOnly           = .F.
            .Visible            = .T.
        ENDWITH

        *-- ControlSource APOS RecordSource para sobrepor auto-bind (Problem 36/48)
        loc_oGrd = loc_oPagina.grd_4c_Dados
        WITH loc_oGrd
            .Column1.ControlSource   = "csSigCdRga.Empresa"
            .Column1.Width           = 60
            .Column1.Alignment       = 0
            .Column1.Header1.Caption = "Empresa"

            .Column2.ControlSource   = "csSigCdRga.Grupo"
            .Column2.Width           = 95
            .Column2.Alignment       = 0
            .Column2.Header1.Caption = "Grupo"

            .Column3.ControlSource   = "csSigCdRga.Conta"
            .Column3.Width           = 85
            .Column3.Alignment       = 0
            .Column3.Header1.Caption = "Conta"

            .Column4.ControlSource   = "csSigCdRga.Colecao"
            .Column4.Width           = 140
            .Column4.Alignment       = 0
            .Column4.Header1.Caption = "Grupo de Venda"

            .Column5.ControlSource   = "csSigCdRga.Quantidade"
            .Column5.Width           = 65
            .Column5.Alignment       = 2
            .Column5.Header1.Caption = "Qtde. Min."

            .Column6.ControlSource   = "csSigCdRga.Prioridade"
            .Column6.Width           = 70
            .Column6.Alignment       = 2
            .Column6.Header1.Caption = "Prior."

            .Column7.ControlSource   = "csSigCdRga.GrupoPr"
            .Column7.Width           = 105
            .Column7.Alignment       = 0
            .Column7.Header1.Caption = "Grupo de Produto"

            .Column8.ControlSource   = "csSigCdRga.Zerar"
            .Column8.Width           = 50
            .Column8.Alignment       = 1
            .Column8.Header1.Caption = "Zerar"

            .Column9.ControlSource   = "csSigCdRga.Ordem"
            .Column9.Width           = 50
            .Column9.Alignment       = 1
            .Column9.Header1.Caption = "Ordem"
        ENDWITH

        BINDEVENT(loc_oGrd, "AfterRowColChange", THIS, "GradeRegraAfterRowColChange")

        *-- CommandGroup Mover linhas (Commandgroup1: Top=200+27=227, Left=748, W=50, H=90)
        loc_oPagina.AddObject("obj_4c_Commandgroup1", "CommandGroup")
        WITH loc_oPagina.obj_4c_Commandgroup1
            .Top         = 227
            .Left        = 748
            .Width       = 50
            .Height      = 90
            .BackStyle   = 0
            .BorderWidth = 0
            .ButtonCount = 2
            .Visible     = .T.
        ENDWITH

        loc_oCmdGrp1 = loc_oPagina.obj_4c_Commandgroup1
        WITH loc_oCmdGrp1.Buttons(1)
            .Caption  = "^"
            .Top      = 0
            .Left     = 0
            .Width    = 50
            .Height   = 45
            .FontName = "Tahoma"
            .FontSize = 14
            .FontBold = .T.
        ENDWITH
        WITH loc_oCmdGrp1.Buttons(2)
            .Caption  = "v"
            .Top      = 45
            .Left     = 0
            .Width    = 50
            .Height   = 45
            .FontName = "Tahoma"
            .FontSize = 14
            .FontBold = .T.
        ENDWITH
        BINDEVENT(loc_oCmdGrp1.Buttons(1), "Click", THIS, "CmdMoveUpClick")
        BINDEVENT(loc_oCmdGrp1.Buttons(2), "Click", THIS, "CmdMoveDownClick")

        *-- CommandGroup Inserir/Deletar linhas (cmdInsFtc: Top=287+27=314, Left=748, W=50, H=90)
        loc_oPagina.AddObject("obj_4c_CmdInsFtc", "CommandGroup")
        WITH loc_oPagina.obj_4c_CmdInsFtc
            .Top         = 314
            .Left        = 748
            .Width       = 50
            .Height      = 90
            .BackStyle   = 0
            .BorderWidth = 0
            .ButtonCount = 2
            .Visible     = .T.
        ENDWITH

        loc_oCmdGrp2 = loc_oPagina.obj_4c_CmdInsFtc
        WITH loc_oCmdGrp2.Buttons(1)
            .Caption  = "+"
            .Top      = 0
            .Left     = 0
            .Width    = 50
            .Height   = 45
            .FontName = "Tahoma"
            .FontSize = 14
            .FontBold = .T.
        ENDWITH
        WITH loc_oCmdGrp2.Buttons(2)
            .Caption  = "-"
            .Top      = 45
            .Left     = 0
            .Width    = 50
            .Height   = 45
            .FontName = "Tahoma"
            .FontSize = 14
            .FontBold = .T.
        ENDWITH
        BINDEVENT(loc_oCmdGrp2.Buttons(1), "Click", THIS, "CmdInsRowClick")
        BINDEVENT(loc_oCmdGrp2.Buttons(2), "Click", THIS, "CmdDelRowClick")

        *-- Shape1 - separador horizontal acima da area de observacao (Top=503+27=530)
        loc_oPagina.AddObject("shp_4c_Shape1", "Shape")
        WITH loc_oPagina.shp_4c_Shape1
            .Top           = 530
            .Left          = 7
            .Width         = 780
            .Height        = 2
            .BackStyle     = 0
            .BorderWidth   = 2
            .SpecialEffect = 0
            .Visible       = .T.
        ENDWITH

        *-- Label Observacao (Say1: Top=519+27=546, Left=88)
        loc_oPagina.AddObject("lbl_4c_Label1", "Label")
        WITH loc_oPagina.lbl_4c_Label1
            .Caption   = "Observa" + CHR(231) + CHR(227) + "o :"
            .Top       = 546
            .Left      = 88
            .Width     = 65
            .Height    = 17
            .FontName  = "Tahoma"
            .FontSize  = 8
            .AutoSize  = .T.
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        *-- EditBox Observacao (edtObservacao: Top=514+27=541, Left=157, Width=465, Height=80)
        loc_oPagina.AddObject("edt_4c_Observacao", "EditBox")
        WITH loc_oPagina.edt_4c_Observacao
            .Value         = ""
            .Top           = 541
            .Left          = 157
            .Width         = 465
            .Height        = 80
            .FontName      = "Verdana"
            .FontSize      = 8
            .SpecialEffect = 1
            .ReadOnly      = .F.
            .Visible       = .T.
        ENDWITH

        *-- Area de Auditoria (Data/Usuario - READ ONLY)
        *-- Label "Data / Usuario" (Say20: Top=511+27=538, Left=626)
        loc_oPagina.AddObject("lbl_4c_Label20", "Label")
        WITH loc_oPagina.lbl_4c_Label20
            .Caption   = "Data / Usu" + CHR(225) + "rio"
            .Top       = 538
            .Left      = 626
            .Width     = 71
            .Height    = 17
            .FontName  = "Tahoma"
            .FontSize  = 8
            .AutoSize  = .T.
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        *-- Label "Inclusao" (Say24: Top=530+27=557, Left=626)
        loc_oPagina.AddObject("lbl_4c_Label24", "Label")
        WITH loc_oPagina.lbl_4c_Label24
            .Caption   = "Inclus" + CHR(227) + "o"
            .Top       = 557
            .Left      = 626
            .Width     = 42
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .AutoSize  = .T.
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        *-- Label "Alteracao" (Say25: Top=530+27=557, Left=707)
        loc_oPagina.AddObject("lbl_4c_Label25", "Label")
        WITH loc_oPagina.lbl_4c_Label25
            .Caption   = "Altera" + CHR(231) + CHR(227) + "o"
            .Top       = 557
            .Left      = 707
            .Width     = 48
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .AutoSize  = .T.
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        *-- Shape3 - separador linha auditoria (Top=526+27=553, Left=626)
        loc_oPagina.AddObject("shp_4c_Shape3", "Shape")
        WITH loc_oPagina.shp_4c_Shape3
            .Top           = 553
            .Left          = 626
            .Width         = 161
            .Height        = 2
            .BackStyle     = 0
            .BorderWidth   = 2
            .SpecialEffect = 0
            .Visible       = .T.
        ENDWITH

        *-- Data Inclusao READ ONLY (Get_DtIncs: Top=545+27=572, Left=626, Width=79)
        loc_oPagina.AddObject("txt_4c_DtIncs", "TextBox")
        WITH loc_oPagina.txt_4c_DtIncs
            .Value         = {}
            .Top           = 572
            .Left          = 626
            .Width         = 79
            .Height        = 23
            .FontName      = "Tahoma"
            .FontSize      = 8
            .MaxLength     = 8
            .ReadOnly      = .T.
            .BackColor     = RGB(240, 240, 240)
            .ForeColor     = RGB(0, 0, 0)
            .SpecialEffect = 1
            .Visible       = .T.
        ENDWITH

        *-- Usuario Inclusao READ ONLY (Get_Usuario: Top=569+27=596, Left=626, Width=79)
        loc_oPagina.AddObject("txt_4c_Usuario", "TextBox")
        WITH loc_oPagina.txt_4c_Usuario
            .Value         = ""
            .Top           = 596
            .Left          = 626
            .Width         = 79
            .Height        = 23
            .MaxLength     = 10
            .FontName      = "Tahoma"
            .FontSize      = 8
            .ReadOnly      = .T.
            .BackColor     = RGB(240, 240, 240)
            .ForeColor     = RGB(0, 0, 0)
            .SpecialEffect = 1
            .Visible       = .T.
        ENDWITH

        *-- Data Alteracao READ ONLY (getDataAlts: Top=545+27=572, Left=707, Width=79)
        loc_oPagina.AddObject("txt_4c_DataAlts", "TextBox")
        WITH loc_oPagina.txt_4c_DataAlts
            .Value         = {}
            .Top           = 572
            .Left          = 707
            .Width         = 79
            .Height        = 23
            .FontName      = "Tahoma"
            .FontSize      = 8
            .MaxLength     = 8
            .ReadOnly      = .T.
            .BackColor     = RGB(240, 240, 240)
            .ForeColor     = RGB(0, 0, 0)
            .SpecialEffect = 1
            .Visible       = .T.
        ENDWITH

        *-- Usuario Alteracao READ ONLY (getUsuaAlts: Top=569+27=596, Left=707, Width=79)
        loc_oPagina.AddObject("txt_4c_UsuaAlts", "TextBox")
        WITH loc_oPagina.txt_4c_UsuaAlts
            .Value         = ""
            .Top           = 596
            .Left          = 707
            .Width         = 79
            .Height        = 23
            .MaxLength     = 10
            .FontName      = "Tahoma"
            .FontSize      = 8
            .ReadOnly      = .T.
            .BackColor     = RGB(240, 240, 240)
            .ForeColor     = RGB(0, 0, 0)
            .SpecialEffect = 1
            .Visible       = .T.
        ENDWITH

        THIS.TornarControlesVisiveis(loc_oPagina)
    ENDPROC

    *===========================================================================
    * CarregarLista - Busca SigCdRGR e vincula ao grd_4c_Lista da Page1
    *===========================================================================
    PROCEDURE CarregarLista()
        LOCAL loc_lResultado, loc_oGrd
        loc_lResultado = .F.

        TRY
            IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
                loc_lResultado = .T.
            ELSE
                IF THIS.this_oBusinessObject.Buscar("")
                loc_oGrd = THIS.pgf_4c_Paginas.Page1.grd_4c_Lista

                *-- RecordSource + ColumnCount FORA do WITH (Problem 36/48)
                loc_oGrd.ColumnCount = 1
                loc_oGrd.RecordSource = "cursor_4c_Dados"
                loc_oGrd.ColumnCount  = 2

                *-- ControlSource APOS RecordSource; Headers OBRIGATORIOS (Problem 2/32)
                WITH loc_oGrd
                    .Column1.ControlSource  = "cursor_4c_Dados.codigo"
                    .Column2.ControlSource  = "cursor_4c_Dados.descricao"

                    .Column1.Header1.Caption = "C" + CHR(243) + "digo"
                    .Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"

                    .Column1.Width     = 100
                    .Column2.Width     = 250
                    .Column1.Alignment = 0
                    .Column2.Alignment = 0
                ENDWITH

                THIS.FormatarGridLista(loc_oGrd)
                loc_lResultado = .T.
            ELSE
                loc_lResultado = .F.
                ENDIF
            ENDIF
        CATCH TO loException
            MsgErro("Erro ao carregar lista:" + CHR(13) + loException.Message, "Erro")
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *===========================================================================
    * AlternarPagina - Alterna entre Page1 (Lista=1) e Page2 (Dados=2)
    *===========================================================================
    PROTECTED PROCEDURE AlternarPagina(par_nPagina)
        LOCAL loc_lResultado
        loc_lResultado = .F.

        IF VARTYPE(par_nPagina) != "N" OR par_nPagina < 1 OR par_nPagina > 2
            RETURN .F.
        ENDIF

        TRY
            THIS.pgf_4c_Paginas.ActivePage = par_nPagina

            IF par_nPagina = 1
                THIS.this_cModoAtual = "LISTA"
                THIS.CarregarLista()
            ENDIF

            loc_lResultado = .T.
        CATCH TO loException
            MsgErro("Erro ao alternar pagina:" + CHR(13) + loException.Message, "Erro")
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *===========================================================================
    * BtnIncluirClick - Prepara BO para novo registro e navega para Page2
    *===========================================================================
    PROCEDURE BtnIncluirClick()
        LOCAL loc_lResultado
        loc_lResultado = .F.

        TRY
            THIS.this_oBusinessObject.NovoRegistro()
            THIS.this_cModoAtual = "INCLUIR"
            THIS.LimparCampos()
            THIS.HabilitarCampos(.T.)
            THIS.AjustarBotoesPorModo()

            IF USED("csSigCdRga")
                ZAP IN csSigCdRga
            ENDIF

            loc_lResultado = THIS.AlternarPagina(2)
        CATCH TO loException
            MsgErro("Erro ao preparar inclus" + CHR(227) + "o:" + CHR(13) + ;
                    loException.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loException.LineNo), "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *===========================================================================
    * BtnVisualizarClick - Carrega registro selecionado em modo somente leitura
    *===========================================================================
    PROCEDURE BtnVisualizarClick()
        LOCAL loc_lResultado, loc_cCodigo
        loc_lResultado = .F.

        IF !USED("cursor_4c_Dados") OR RECCOUNT("cursor_4c_Dados") = 0 OR EOF("cursor_4c_Dados")
            MsgAviso("Selecione um registro para visualizar.", ;
                     "Aten" + CHR(231) + CHR(227) + "o")
            RETURN .F.
        ENDIF

        TRY
            SELECT cursor_4c_Dados
            loc_cCodigo = ALLTRIM(cursor_4c_Dados.codigo)

            IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
                THIS.BOParaForm()
                THIS.CarregarGradeRegra(loc_cCodigo)
                THIS.this_cModoAtual = "VISUALIZAR"
                THIS.HabilitarCampos(.F.)
                THIS.AjustarBotoesPorModo()
                loc_lResultado = THIS.AlternarPagina(2)
            ENDIF
        CATCH TO loException
            MsgErro("Erro ao carregar registro:" + CHR(13) + ;
                    loException.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loException.LineNo), "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *===========================================================================
    * BtnAlterarClick - Carrega registro selecionado para edicao
    *===========================================================================
    PROCEDURE BtnAlterarClick()
        LOCAL loc_lResultado, loc_cCodigo
        loc_lResultado = .F.

        IF !USED("cursor_4c_Dados") OR RECCOUNT("cursor_4c_Dados") = 0 OR EOF("cursor_4c_Dados")
            MsgAviso("Selecione um registro para alterar.", ;
                     "Aten" + CHR(231) + CHR(227) + "o")
            RETURN .F.
        ENDIF

        TRY
            SELECT cursor_4c_Dados
            loc_cCodigo = ALLTRIM(cursor_4c_Dados.codigo)

            IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
                THIS.this_oBusinessObject.EditarRegistro()
                THIS.BOParaForm()
                THIS.CarregarGradeRegra(loc_cCodigo)
                THIS.this_cModoAtual = "ALTERAR"
                THIS.HabilitarCampos(.T.)
                THIS.AjustarBotoesPorModo()
                loc_lResultado = THIS.AlternarPagina(2)
            ENDIF
        CATCH TO loException
            MsgErro("Erro ao carregar registro:" + CHR(13) + ;
                    loException.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loException.LineNo), "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *===========================================================================
    * BtnExcluirClick - Confirma e exclui o registro selecionado
    *===========================================================================
    PROCEDURE BtnExcluirClick()
        LOCAL loc_lResultado, loc_cCodigo, loc_cDescricao
        loc_lResultado = .F.

        IF !USED("cursor_4c_Dados") OR RECCOUNT("cursor_4c_Dados") = 0 OR EOF("cursor_4c_Dados")
            MsgAviso("Selecione um registro para excluir.", ;
                     "Aten" + CHR(231) + CHR(227) + "o")
            RETURN .F.
        ENDIF

        SELECT cursor_4c_Dados
        loc_cCodigo    = ALLTRIM(cursor_4c_Dados.codigo)
        loc_cDescricao = ALLTRIM(cursor_4c_Dados.descricao)

        IF !MsgConfirma("Confirma a exclus" + CHR(227) + "o da regra:" + CHR(13) + ;
                        loc_cCodigo + " - " + loc_cDescricao + "?", ;
                        "Confirmar Exclus" + CHR(227) + "o")
            RETURN .F.
        ENDIF

        TRY
            IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
                IF THIS.this_oBusinessObject.Excluir()
                    MsgInfo("Regra exclu" + CHR(237) + "da com sucesso!")
                    THIS.CarregarLista()
                    loc_lResultado = .T.
                ENDIF
            ENDIF
        CATCH TO loException
            MsgErro("Erro ao excluir registro:" + CHR(13) + ;
                    loException.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loException.LineNo), "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *===========================================================================
    * BtnBuscarClick - Recarrega lista e posiciona no primeiro registro que
    * contenha o texto digitado no codigo ou descricao
    *===========================================================================
    PROCEDURE BtnBuscarClick()
        LOCAL loc_cBuscar, loc_oGrd
        loc_cBuscar = ALLTRIM(INPUTBOX("C" + CHR(243) + "digo ou descri" + CHR(231) + ;
                                       CHR(227) + "o:", "Buscar Regra", ""))

        IF THIS.CarregarLista()
            IF !EMPTY(loc_cBuscar) AND USED("cursor_4c_Dados")
                SELECT cursor_4c_Dados
                LOCATE FOR UPPER(loc_cBuscar) $ UPPER(ALLTRIM(codigo)) OR ;
                           UPPER(loc_cBuscar) $ UPPER(ALLTRIM(descricao))
                IF EOF("cursor_4c_Dados")
                    GO TOP IN cursor_4c_Dados
                    MsgAviso("Nenhum registro encontrado para: " + loc_cBuscar, "Buscar")
                ENDIF
            ENDIF
            loc_oGrd = THIS.pgf_4c_Paginas.Page1.grd_4c_Lista
            IF VARTYPE(loc_oGrd) = "O"
                loc_oGrd.Refresh()
            ENDIF
        ENDIF
    ENDPROC

    *===========================================================================
    * BtnEncerrarClick - Fecha o formulario
    *===========================================================================
    PROCEDURE BtnEncerrarClick()
        THIS.Release()
    ENDPROC

    *===========================================================================
    * FormatarGridLista - Formata visual do grid de lista (Page1)
    *===========================================================================
    PROTECTED PROCEDURE FormatarGridLista(par_oGrid)
        WITH par_oGrid
            .FontName = "Tahoma"
            .FontSize = 8
        ENDWITH
    ENDPROC

    *===========================================================================
    * TornarControlesVisiveis - Torna visiveis todos os controles do container
    * REGRA: Sempre chamar COM parametro: THIS.TornarControlesVisiveis(loc_oPagina)
    *===========================================================================
    PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
        LOCAL loc_nI, loc_oObjeto

        FOR loc_nI = 1 TO par_oContainer.ControlCount
            loc_oObjeto = par_oContainer.Controls(loc_nI)

            IF VARTYPE(loc_oObjeto) = "O"
                IF PEMSTATUS(loc_oObjeto, "Visible", 5)
                    loc_oObjeto.Visible = .T.
                ENDIF

                IF UPPER(loc_oObjeto.BaseClass) = "PAGEFRAME"
                    LOCAL loc_nP
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
    * BtnSalvarClick - Coleta dados do form, chama Inserir ou Atualizar no BO
    *===========================================================================
    PROCEDURE BtnSalvarClick()
        LOCAL loc_lResultado, loc_oPg2
        loc_lResultado = .F.
        loc_oPg2       = THIS.pgf_4c_Paginas.Page2

        IF THIS.this_cModoAtual = "INCLUIR" AND EMPTY(ALLTRIM(loc_oPg2.txt_4c_Codigo.Value))
            MsgAviso("C" + CHR(243) + "digo obrigat" + CHR(243) + "rio.", "Aviso")
            loc_oPg2.txt_4c_Codigo.SetFocus()
            RETURN .F.
        ENDIF

        TRY
            THIS.FormParaBO()

            loc_lResultado = THIS.this_oBusinessObject.Salvar()

            IF loc_lResultado
                MsgInfo("Registro salvo com sucesso!")
                THIS.AlternarPagina(1)
            ENDIF
        CATCH TO loException
            MsgErro("Erro ao salvar registro:" + CHR(13) + ;
                    loException.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loException.LineNo), "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *===========================================================================
    * BtnCancelarClick - Retorna para Page1 sem salvar
    *===========================================================================
    PROCEDURE BtnCancelarClick()
        THIS.AlternarPagina(1)
    ENDPROC

    *===========================================================================
    * FormParaBO - Transfere valores dos controles da Page2 para o BO
    *===========================================================================
    PROTECTED PROCEDURE FormParaBO()
        LOCAL loc_oPg2
        loc_oPg2 = THIS.pgf_4c_Paginas.Page2

        THIS.this_oBusinessObject.this_cCodigo      = ALLTRIM(loc_oPg2.txt_4c_Codigo.Value)
        THIS.this_oBusinessObject.this_cDescricao   = ALLTRIM(loc_oPg2.txt_4c_Descricao.Value)
        THIS.this_oBusinessObject.this_nValor        = loc_oPg2.txt_4c_Valor.Value
        THIS.this_oBusinessObject.this_nInativas     = IIF(loc_oPg2.chk_4c_Check1.Value = 1, 1, 0)
        THIS.this_oBusinessObject.this_cObservacao   = ALLTRIM(loc_oPg2.edt_4c_Observacao.Value)
    ENDPROC

    *===========================================================================
    * BOParaForm - Transfere valores do BO para os controles da Page2
    *===========================================================================
    PROTECTED PROCEDURE BOParaForm()
        LOCAL loc_oPg2
        loc_oPg2 = THIS.pgf_4c_Paginas.Page2

        loc_oPg2.txt_4c_Codigo.Value      = ALLTRIM(THIS.this_oBusinessObject.this_cCodigo)
        loc_oPg2.txt_4c_Descricao.Value   = ALLTRIM(THIS.this_oBusinessObject.this_cDescricao)
        loc_oPg2.txt_4c_Valor.Value       = THIS.this_oBusinessObject.this_nValor
        loc_oPg2.chk_4c_Check1.Value      = THIS.this_oBusinessObject.this_nInativas
        loc_oPg2.edt_4c_Observacao.Value  = ALLTRIM(THIS.this_oBusinessObject.this_cObservacao)
        loc_oPg2.txt_4c_DtIncs.Value      = TTOD(THIS.this_oBusinessObject.this_dDatas)
        loc_oPg2.txt_4c_Usuario.Value     = ALLTRIM(THIS.this_oBusinessObject.this_cUsuIncs)
        loc_oPg2.txt_4c_DataAlts.Value    = TTOD(THIS.this_oBusinessObject.this_dDtaAlts)
        loc_oPg2.txt_4c_UsuaAlts.Value    = ALLTRIM(THIS.this_oBusinessObject.this_cUsaAlts)
    ENDPROC

    *===========================================================================
    * LimparCampos - Zera todos os controles da Page2 (modo INCLUIR)
    *===========================================================================
    PROTECTED PROCEDURE LimparCampos()
        LOCAL loc_oPg2
        loc_oPg2 = THIS.pgf_4c_Paginas.Page2

        loc_oPg2.txt_4c_Codigo.Value     = ""
        loc_oPg2.txt_4c_Descricao.Value  = ""
        loc_oPg2.txt_4c_Valor.Value      = 0
        loc_oPg2.chk_4c_Check1.Value    = 0
        loc_oPg2.edt_4c_Observacao.Value = ""
        loc_oPg2.txt_4c_DtIncs.Value    = {}
        loc_oPg2.txt_4c_Usuario.Value   = ""
        loc_oPg2.txt_4c_DataAlts.Value  = {}
        loc_oPg2.txt_4c_UsuaAlts.Value  = ""
    ENDPROC

    *===========================================================================
    * HabilitarCampos - Habilita ou desabilita campos conforme modo atual
    *===========================================================================
    PROTECTED PROCEDURE HabilitarCampos(par_lHabilitar)
        LOCAL loc_oPg2
        loc_oPg2 = THIS.pgf_4c_Paginas.Page2

        loc_oPg2.txt_4c_Codigo.ReadOnly         = !par_lHabilitar
        loc_oPg2.txt_4c_Descricao.ReadOnly      = !par_lHabilitar
        loc_oPg2.txt_4c_Valor.ReadOnly          = !par_lHabilitar
        loc_oPg2.chk_4c_Check1.Enabled         = par_lHabilitar
        loc_oPg2.edt_4c_Observacao.ReadOnly     = !par_lHabilitar
        loc_oPg2.grd_4c_Dados.ReadOnly          = !par_lHabilitar
        loc_oPg2.obj_4c_CmdInsFtc.Enabled       = par_lHabilitar
        loc_oPg2.obj_4c_Commandgroup1.Enabled   = par_lHabilitar
    ENDPROC

    *===========================================================================
    * AjustarBotoesPorModo - Ativa/desativa Salvar conforme modo
    *===========================================================================
    PROTECTED PROCEDURE AjustarBotoesPorModo()
        LOCAL loc_lEdicao, loc_oPg2
        loc_lEdicao = (THIS.this_cModoAtual = "INCLUIR" OR THIS.this_cModoAtual = "ALTERAR")
        loc_oPg2    = THIS.pgf_4c_Paginas.Page2

        loc_oPg2.cnt_4c_Salva.cmd_4c_Confirmar.Enabled = loc_lEdicao
        loc_oPg2.cnt_4c_Salva.cmd_4c_Cancelar.Enabled  = .T.
    ENDPROC

    *===========================================================================
    * CarregarGradeRegra - ZAP + SQLEXEC + APPEND para preservar colunas do grid
    * NAO chama rgrBO.CarregarLinhasRegra() pois ela recriar o cursor (Problem 34)
    *===========================================================================
    PROTECTED PROCEDURE CarregarGradeRegra(par_cCodigo)
        LOCAL loc_lResultado, loc_nSQL, loc_cSQL
        loc_lResultado = .F.

        TRY
            IF USED("csSigCdRga")
                ZAP IN csSigCdRga
            ENDIF

            loc_cSQL = "SELECT cidchaves, codigo, empresa, grupo, conta, colecao, " + ;
                       "       quantidade, prioridade, grupopr, zerar, ordem "       + ;
                       "  FROM SigCdRga "                                             + ;
                       " WHERE codigo = " + EscaparSQL(par_cCodigo)                  + ;
                       " ORDER BY prioridade"

            loc_nSQL = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_RgaTmp")

            IF loc_nSQL > 0
                SELECT cursor_4c_RgaTmp
                SCAN
                    SELECT csSigCdRga
                    APPEND BLANK
                    REPLACE cIdChaves  WITH cursor_4c_RgaTmp.cidchaves,  ;
                            Codigo     WITH cursor_4c_RgaTmp.codigo,     ;
                            Empresa    WITH cursor_4c_RgaTmp.empresa,    ;
                            Grupo      WITH cursor_4c_RgaTmp.grupo,      ;
                            Conta      WITH cursor_4c_RgaTmp.conta,      ;
                            Colecao    WITH cursor_4c_RgaTmp.colecao,    ;
                            Quantidade WITH cursor_4c_RgaTmp.quantidade, ;
                            Prioridade WITH cursor_4c_RgaTmp.prioridade, ;
                            GrupoPr    WITH cursor_4c_RgaTmp.grupopr,    ;
                            Zerar      WITH cursor_4c_RgaTmp.zerar,      ;
                            Ordem      WITH cursor_4c_RgaTmp.ordem
                    SELECT cursor_4c_RgaTmp
                ENDSCAN

                IF USED("cursor_4c_RgaTmp")
                    USE IN cursor_4c_RgaTmp
                ENDIF

                SELECT csSigCdRga
                IF RECCOUNT("csSigCdRga") > 0
                    INDEX ON Prioridade TAG PriIdx
                    SET ORDER TO TAG PriIdx
                    GO TOP
                ENDIF

                loc_lResultado = .T.
            ELSE
                IF USED("cursor_4c_RgaTmp")
                    USE IN cursor_4c_RgaTmp
                ENDIF
                MsgErro("Erro ao carregar regras do servidor.", "Erro")
            ENDIF
        CATCH TO loException
            IF USED("cursor_4c_RgaTmp")
                USE IN cursor_4c_RgaTmp
            ENDIF
            MsgErro("Erro ao carregar grade de regras:" + CHR(13) + ;
                    loException.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loException.LineNo), "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *===========================================================================
    * GradeRegraAfterRowColChange - Validacoes ao sair de colunas do grid
    * Deve ser PUBLIC - handler BINDEVENT (CLAUDE.md regra #3)
    *===========================================================================
    PROCEDURE GradeRegraAfterRowColChange(par_nColIndex)
        IF !USED("csSigCdRga") OR EOF("csSigCdRga") OR DELETED("csSigCdRga")
            RETURN
        ENDIF
        IF THIS.this_cModoAtual = "VISUALIZAR"
            RETURN
        ENDIF

        DO CASE
        CASE par_nColIndex = 1
            THIS.ValidarEmpresaGrid()
        CASE par_nColIndex = 2
            THIS.ValidarGrupoContabilGrid()
        CASE par_nColIndex = 3
            THIS.ValidarContaGrid()
        CASE par_nColIndex = 4
            THIS.ValidarColecaoGrid()
        CASE par_nColIndex = 7
            THIS.ValidarGrupoProdutoGrid()
        CASE par_nColIndex = 8
            THIS.ValidarZerarGrid()
        CASE par_nColIndex = 9
            THIS.ValidarOrdemGrid()
        ENDCASE
    ENDPROC

    *===========================================================================
    * ValidarEmpresaGrid - Valida col Empresa via fAcessoEmpresa (sigacess.PRG)
    *===========================================================================
    PROTECTED PROCEDURE ValidarEmpresaGrid()
        IF !USED("csSigCdRga") OR EOF("csSigCdRga")
            RETURN
        ENDIF

        LOCAL loc_cEmp
        SELECT csSigCdRga
        loc_cEmp = ALLTRIM(csSigCdRga.Empresa)

        IF EMPTY(loc_cEmp)
            RETURN
        ENDIF

        TRY
            *!! CORRETOR #110: fAcessoEmpresa() NAO existe na nova arquitetura. Substituir por bloco FormBuscaAuxiliar apontando SigCdEmp (chave Cemps modo C, Razas modo D). Ver Formsigatcrp.prg:2278-2378.
            IF !fAcessoEmpresa(Usuar, 'C', loc_cEmp, .NULL., '')
                SELECT csSigCdRga
                REPLACE Empresa WITH ""
            ENDIF
        CATCH TO loException
            MsgErro("Erro ao validar empresa:" + CHR(13) + loException.Message, "Erro")
        ENDTRY
    ENDPROC

    *===========================================================================
    * ValidarGrupoContabilGrid - Valida col Grupo via fAcessoContab (sigacess.PRG)
    *===========================================================================
    PROTECTED PROCEDURE ValidarGrupoContabilGrid()
        IF !USED("csSigCdRga") OR EOF("csSigCdRga")
            RETURN
        ENDIF

        LOCAL loc_cGrp
        SELECT csSigCdRga
        loc_cGrp = ALLTRIM(csSigCdRga.Grupo)

        IF EMPTY(loc_cGrp)
            RETURN
        ENDIF

        TRY
            IF !fAcessoContab(Usuar, 'C', loc_cGrp, .NULL., '')
                MsgAviso("Acesso Negado !!!", "Grupo Cont" + CHR(225) + "bil")
                SELECT csSigCdRga
                REPLACE Grupo WITH ""
            ENDIF
        CATCH TO loException
            MsgErro("Erro ao validar grupo contabil:" + CHR(13) + loException.Message, "Erro")
        ENDTRY
    ENDPROC

    *===========================================================================
    * ValidarContaGrid - Valida col Conta via fAcessoContas (sigacess.PRG)
    * Depende do Grupo da mesma linha para contexto de acesso
    *===========================================================================
    PROTECTED PROCEDURE ValidarContaGrid()
        IF !USED("csSigCdRga") OR EOF("csSigCdRga")
            RETURN
        ENDIF

        LOCAL loc_cConta, loc_cGrp, loc_lRet
        SELECT csSigCdRga
        loc_cConta = ALLTRIM(csSigCdRga.Conta)
        loc_cGrp   = ALLTRIM(csSigCdRga.Grupo)

        IF EMPTY(loc_cConta)
            RETURN
        ENDIF

        TRY
            loc_lRet = fAcessoContas(Usuar, loc_cGrp, 'C', loc_cConta, .NULL., '')
            IF !loc_lRet
                MsgAviso("Acesso Negado !!!", "Conta")
                SELECT csSigCdRga
                REPLACE Conta WITH ""
            ENDIF
        CATCH TO loException
            MsgErro("Erro ao validar conta:" + CHR(13) + loException.Message, "Erro")
        ENDTRY
    ENDPROC

    *===========================================================================
    * ValidarColecaoGrid - Valida col Colecao; abre lookup se nao encontrado
    *===========================================================================
    PROTECTED PROCEDURE ValidarColecaoGrid()
        IF !USED("csSigCdRga") OR EOF("csSigCdRga")
            RETURN
        ENDIF

        LOCAL loc_cCol, loc_nSQL
        SELECT csSigCdRga
        loc_cCol = ALLTRIM(csSigCdRga.Colecao)

        IF EMPTY(loc_cCol)
            RETURN
        ENDIF

        loc_nSQL = SQLEXEC(gnConnHandle, ;
            "SELECT COUNT(*) AS qtd FROM SigCdCol WHERE Colecao = " + EscaparSQL(loc_cCol), ;
            "cursor_4c_ValCol")

        IF loc_nSQL > 0 AND USED("cursor_4c_ValCol")
            IF cursor_4c_ValCol.qtd = 0
                USE IN cursor_4c_ValCol
                THIS.AbrirLookupColecao()
            ELSE
                USE IN cursor_4c_ValCol
            ENDIF
        ENDIF
    ENDPROC

    *===========================================================================
    * ValidarGrupoProdutoGrid - Valida col GrupoPr; abre lookup se nao encontrado
    *===========================================================================
    PROTECTED PROCEDURE ValidarGrupoProdutoGrid()
        IF !USED("csSigCdRga") OR EOF("csSigCdRga")
            RETURN
        ENDIF

        LOCAL loc_cGrp, loc_nSQL
        SELECT csSigCdRga
        loc_cGrp = ALLTRIM(csSigCdRga.GrupoPr)

        IF EMPTY(loc_cGrp)
            RETURN
        ENDIF

        loc_nSQL = SQLEXEC(gnConnHandle, ;
            "SELECT COUNT(*) AS qtd FROM SigCdGrp WHERE CGrus = " + EscaparSQL(loc_cGrp), ;
            "cursor_4c_ValGrp")

        IF loc_nSQL > 0 AND USED("cursor_4c_ValGrp")
            IF cursor_4c_ValGrp.qtd = 0
                USE IN cursor_4c_ValGrp
                THIS.AbrirLookupGrupoProduto()
            ELSE
                USE IN cursor_4c_ValGrp
            ENDIF
        ENDIF
    ENDPROC

    *===========================================================================
    * ValidarZerarGrid - Valida col Zerar: aceita somente S ou N
    *===========================================================================
    PROTECTED PROCEDURE ValidarZerarGrid()
        IF !USED("csSigCdRga") OR EOF("csSigCdRga")
            RETURN
        ENDIF

        LOCAL loc_cZerar
        SELECT csSigCdRga
        loc_cZerar = UPPER(ALLTRIM(csSigCdRga.Zerar))

        IF !EMPTY(loc_cZerar) AND loc_cZerar != "S" AND loc_cZerar != "N"
            MsgAviso("Zerar deve ser S ou N.", "Zerar")
            REPLACE Zerar WITH "S"
        ENDIF
    ENDPROC

    *===========================================================================
    * ValidarOrdemGrid - Valida col Ordem: aceita somente P ou D
    *===========================================================================
    PROTECTED PROCEDURE ValidarOrdemGrid()
        IF !USED("csSigCdRga") OR EOF("csSigCdRga")
            RETURN
        ENDIF

        LOCAL loc_cOrdem
        SELECT csSigCdRga
        loc_cOrdem = UPPER(ALLTRIM(csSigCdRga.Ordem))

        IF !EMPTY(loc_cOrdem) AND loc_cOrdem != "P" AND loc_cOrdem != "D"
            MsgAviso("Ordem deve ser P ou D.", "Ordem")
            REPLACE Ordem WITH "P"
        ENDIF
    ENDPROC

    *===========================================================================
    * CmdInsRowClick - Insere nova linha em branco no grid de regras
    *===========================================================================
    PROCEDURE CmdInsRowClick()
        IF !USED("csSigCdRga") OR THIS.this_cModoAtual = "VISUALIZAR"
            RETURN
        ENDIF

        LOCAL loc_nProx, loc_cIdChav, loc_cCodigo
        SELECT csSigCdRga
        CALCULATE MAX(Prioridade) TO loc_nProx
        loc_nProx   = loc_nProx + 1
        loc_cIdChav = ALLTRIM(THIS.this_oBusinessObject.this_cCidChaves)
        loc_cCodigo = ALLTRIM(THIS.this_oBusinessObject.this_cCodigo)

        APPEND BLANK IN csSigCdRga
        SELECT csSigCdRga
        GO BOTTOM
        REPLACE cIdChaves  WITH loc_cIdChav, ;
                Codigo     WITH loc_cCodigo, ;
                Prioridade WITH loc_nProx

        THIS.pgf_4c_Paginas.Page2.grd_4c_Dados.Refresh()
    ENDPROC

    *===========================================================================
    * CmdDelRowClick - Marca linha atual do grid como excluida (DELETE)
    *===========================================================================
    PROCEDURE CmdDelRowClick()
        IF !USED("csSigCdRga") OR RECCOUNT("csSigCdRga") = 0 OR EOF("csSigCdRga")
            RETURN
        ENDIF
        IF THIS.this_cModoAtual = "VISUALIZAR" OR DELETED("csSigCdRga")
            RETURN
        ENDIF

        IF MsgConfirma("Confirma a exclus" + CHR(227) + "o desta linha?", ;
                       "Excluir Linha")
            SELECT csSigCdRga
            DELETE
            SET DELETED ON
            THIS.pgf_4c_Paginas.Page2.grd_4c_Dados.Refresh()
        ENDIF
    ENDPROC

    *===========================================================================
    * CmdMoveUpClick - Move a linha atual para cima (troca Prioridade com anterior)
    *===========================================================================
    PROCEDURE CmdMoveUpClick()
        IF !USED("csSigCdRga") OR RECCOUNT("csSigCdRga") = 0 OR EOF("csSigCdRga")
            RETURN
        ENDIF
        IF THIS.this_cModoAtual = "VISUALIZAR" OR DELETED("csSigCdRga")
            RETURN
        ENDIF

        LOCAL loc_nAtual, loc_nAnterior
        SELECT csSigCdRga
        loc_nAtual    = csSigCdRga.Prioridade
        loc_nAnterior = loc_nAtual - 1

        IF loc_nAtual <= 1
            RETURN
        ENDIF

        UPDATE csSigCdRga SET Prioridade = 0           WHERE Prioridade = loc_nAtual
        UPDATE csSigCdRga SET Prioridade = loc_nAtual  WHERE Prioridade = loc_nAnterior
        UPDATE csSigCdRga SET Prioridade = loc_nAnterior WHERE Prioridade = 0

        SELECT csSigCdRga
        INDEX ON Prioridade TAG PriIdx
        SET ORDER TO TAG PriIdx
        LOCATE FOR Prioridade = loc_nAnterior

        THIS.pgf_4c_Paginas.Page2.grd_4c_Dados.Refresh()
    ENDPROC

    *===========================================================================
    * CmdMoveDownClick - Move a linha atual para baixo (troca Prioridade com proxima)
    *===========================================================================
    PROCEDURE CmdMoveDownClick()
        IF !USED("csSigCdRga") OR RECCOUNT("csSigCdRga") = 0 OR EOF("csSigCdRga")
            RETURN
        ENDIF
        IF THIS.this_cModoAtual = "VISUALIZAR" OR DELETED("csSigCdRga")
            RETURN
        ENDIF

        LOCAL loc_nAtual, loc_nProximo, loc_nMax
        SELECT csSigCdRga
        loc_nAtual  = csSigCdRga.Prioridade
        CALCULATE MAX(Prioridade) TO loc_nMax
        loc_nProximo = loc_nAtual + 1

        IF loc_nAtual >= loc_nMax
            RETURN
        ENDIF

        UPDATE csSigCdRga SET Prioridade = 0           WHERE Prioridade = loc_nAtual
        UPDATE csSigCdRga SET Prioridade = loc_nAtual  WHERE Prioridade = loc_nProximo
        UPDATE csSigCdRga SET Prioridade = loc_nProximo WHERE Prioridade = 0

        SELECT csSigCdRga
        INDEX ON Prioridade TAG PriIdx
        SET ORDER TO TAG PriIdx
        LOCATE FOR Prioridade = loc_nProximo

        THIS.pgf_4c_Paginas.Page2.grd_4c_Dados.Refresh()
    ENDPROC

    *===========================================================================
    * AbrirLookupColecao - FormBuscaAuxiliar para SigCdCol (Pattern A canonico)
    *===========================================================================
    PROCEDURE AbrirLookupColecao()
        LOCAL loc_oBusca, loc_nSQL, loc_cValAtual, loc_cSQL
        loc_cValAtual = ""

        IF USED("csSigCdRga") AND !EOF("csSigCdRga") AND !DELETED("csSigCdRga")
            SELECT csSigCdRga
            loc_cValAtual = ALLTRIM(csSigCdRga.Colecao)
        ENDIF

        IF EMPTY(loc_cValAtual)
            loc_cSQL = "SELECT Colecao, Descs FROM SigCdCol ORDER BY Colecao"
        ELSE
            loc_cSQL = "SELECT Colecao, Descs FROM SigCdCol " + ;
                       " WHERE Colecao LIKE " + EscaparSQL(loc_cValAtual + "%") + ;
                       " ORDER BY Colecao"
        ENDIF

        loc_nSQL = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaCol")

        IF loc_nSQL > 0 AND USED("cursor_4c_BuscaCol")
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
            IF VARTYPE(loc_oBusca) = "O"
                loc_oBusca.this_cCursorDestino = "cursor_4c_BuscaCol"
                loc_oBusca.DefinirCursor("cursor_4c_BuscaCol", "Colecao", "Descs", ;
                    "Cole" + CHR(231) + CHR(227) + "o")
                IF loc_oBusca.Mostrar()
                    IF USED("csSigCdRga") AND !EOF("csSigCdRga")
                        SELECT csSigCdRga
                        REPLACE Colecao WITH ALLTRIM(loc_oBusca.cCodigoSelecionado)
                    ENDIF
                ENDIF
                loc_oBusca.Release()
            ENDIF
            IF USED("cursor_4c_BuscaCol")
                USE IN cursor_4c_BuscaCol
            ENDIF
        ENDIF

        IF VARTYPE(THIS.pgf_4c_Paginas.Page2.grd_4c_Dados) = "O"
            THIS.pgf_4c_Paginas.Page2.grd_4c_Dados.Refresh()
        ENDIF
    ENDPROC

    *===========================================================================
    * AbrirLookupGrupoProduto - FormBuscaAuxiliar para SigCdGrp (Pattern A canonico)
    *===========================================================================
    PROCEDURE AbrirLookupGrupoProduto()
        LOCAL loc_oBusca, loc_nSQL, loc_cValAtual, loc_cSQL
        loc_cValAtual = ""

        IF USED("csSigCdRga") AND !EOF("csSigCdRga") AND !DELETED("csSigCdRga")
            SELECT csSigCdRga
            loc_cValAtual = ALLTRIM(csSigCdRga.GrupoPr)
        ENDIF

        IF EMPTY(loc_cValAtual)
            loc_cSQL = "SELECT CGrus, DGrus FROM SigCdGrp ORDER BY CGrus"
        ELSE
            loc_cSQL = "SELECT CGrus, DGrus FROM SigCdGrp " + ;
                       " WHERE CGrus LIKE " + EscaparSQL(loc_cValAtual + "%") + ;
                       " ORDER BY CGrus"
        ENDIF

        loc_nSQL = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaGrp")

        IF loc_nSQL > 0 AND USED("cursor_4c_BuscaGrp")
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
            IF VARTYPE(loc_oBusca) = "O"
                loc_oBusca.this_cCursorDestino = "cursor_4c_BuscaGrp"
                loc_oBusca.DefinirCursor("cursor_4c_BuscaGrp", "CGrus", "DGrus", ;
                    "Grupo de Produto")
                IF loc_oBusca.Mostrar()
                    IF USED("csSigCdRga") AND !EOF("csSigCdRga")
                        SELECT csSigCdRga
                        REPLACE GrupoPr WITH ALLTRIM(loc_oBusca.cCodigoSelecionado)
                    ENDIF
                ENDIF
                loc_oBusca.Release()
            ENDIF
            IF USED("cursor_4c_BuscaGrp")
                USE IN cursor_4c_BuscaGrp
            ENDIF
        ENDIF

        IF VARTYPE(THIS.pgf_4c_Paginas.Page2.grd_4c_Dados) = "O"
            THIS.pgf_4c_Paginas.Page2.grd_4c_Dados.Refresh()
        ENDIF
    ENDPROC

    *===========================================================================
    * DescricaoLostFocus - Insere linha vazia no grid ao sair do campo Descricao
    * Deve ser PUBLIC - handler BINDEVENT (CLAUDE.md regra #3)
    * Espelha: GetDescricao.LostFocus no legado (SIGCDRGR.SCX:1560-1564)
    *===========================================================================
    PROCEDURE DescricaoLostFocus
        LPARAMETERS par_nKeyCode, par_nShiftAltCtrl
        LOCAL loc_oPg2
        loc_oPg2 = THIS.pgf_4c_Paginas.Page2

        IF !EMPTY(ALLTRIM(loc_oPg2.txt_4c_Descricao.Value)) AND ;
           INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
            THIS.CmdInsRowClick()
            IF VARTYPE(loc_oPg2.grd_4c_Dados) = "O"
                loc_oPg2.grd_4c_Dados.SetFocus()
            ENDIF
        ENDIF
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

        IF USED("csSigCdRga")
            USE IN csSigCdRga
        ENDIF

        DODEFAULT()
    ENDPROC

ENDDEFINE


### BO (C:\4c\projeto\app\classes\rgrBO.prg):
*==============================================================================
* rgrBO.prg - Business Object para Regras de E-Commerce
* Tabela principal : SigCdRGR
* Tabela detalhe   : SigCdRga (gerenciada via cursor csSigCdRga)
* Form relacionado : Formrgr.prg
*==============================================================================

DEFINE CLASS rgrBO AS BusinessBase

    *--------------------------------------------------------------------------
    * Propriedades - SigCdRGR (cabecalho da regra)
    *--------------------------------------------------------------------------
    this_cCidChaves  = ""   && cidchaves  char(20) - chave interna (fUniqueIds)
    this_cCodigo     = ""   && codigo     char(10) - codigo da regra (chave visivel)
    this_cDescricao  = ""   && descricao  char(40) - descricao
    this_dDatas      = {}   && datas      datetime - data de inclusao
    this_dDtaAlts    = {}   && dtaalts    datetime - data de alteracao
    this_cObservacao = ""   && observacao text     - observacao
    this_cUsaAlts    = ""   && usualts    char(10) - usuario que alterou
    this_cUsuIncs    = ""   && usuincs    char(10) - usuario que incluiu
    this_nInativas   = 0    && inativas   numeric(1,0) - 0=ativo / 1=inativo
    this_nValor      = 0    && valor      numeric(12,2)- valor minimo do pedido

    *--------------------------------------------------------------------------
    * Init - Configura tabela e campo-chave
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        DODEFAULT()
        THIS.this_cTabela     = "SigCdRGR"
        THIS.this_cCampoChave = "Codigo"
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Retorna chave interna para auditoria
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION ObterChavePrimaria()
        RETURN THIS.this_cCidChaves
    ENDPROC

    *--------------------------------------------------------------------------
    * Buscar - SELECT lista de regras para o Grid da Page1
    *--------------------------------------------------------------------------
    FUNCTION Buscar(par_cFiltro)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF USED("cursor_4c_Dados")
                USE IN cursor_4c_Dados
            ENDIF

            loc_cSQL = "SELECT a.cidchaves, a.codigo, a.descricao," + ;
                       " a.inativas, a.valor" + ;
                       " FROM SigCdRGR a" + ;
                       " ORDER BY a.codigo"

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")
            IF loc_nResultado >= 0
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao buscar regras:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao buscar regras:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarPorCodigo - Carrega um registro RGR pelo codigo
    *--------------------------------------------------------------------------
    FUNCTION CarregarPorCodigo(par_cCodigo)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF USED("cursor_4c_Carrega")
                USE IN cursor_4c_Carrega
            ENDIF

            loc_cSQL = "SELECT a.cidchaves, a.codigo, a.descricao, a.datas," + ;
                       " a.dtaalts, a.observacao, a.usualts, a.usuincs," + ;
                       " a.inativas, a.valor" + ;
                       " FROM SigCdRGR a" + ;
                       " WHERE a.codigo = " + EscaparSQL(ALLTRIM(par_cCodigo))

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")
            IF loc_nResultado >= 0 AND RECCOUNT("cursor_4c_Carrega") > 0
                loc_lSucesso = THIS.CarregarDoCursor("cursor_4c_Carrega")
                THIS.this_lNovoRegistro = .F.
            ELSE
                IF loc_nResultado < 0
                    MsgErro("Erro ao carregar regra:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                ENDIF
            ENDIF

            IF USED("cursor_4c_Carrega")
                USE IN cursor_4c_Carrega
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao carregar regra:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Carrega propriedades do BO a partir de cursor
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        IF USED(par_cAliasCursor)
            SELECT (par_cAliasCursor)
            THIS.this_cCidChaves  = TratarNulo(cidchaves,  "C")
            THIS.this_cCodigo     = TratarNulo(codigo,     "C")
            THIS.this_cDescricao  = TratarNulo(descricao,  "C")
            THIS.this_dDatas      = TratarNulo(datas,      "D")
            THIS.this_dDtaAlts    = TratarNulo(dtaalts,    "D")
            THIS.this_cObservacao = TratarNulo(observacao,  "")
            THIS.this_cUsaAlts    = TratarNulo(usualts,    "C")
            THIS.this_cUsuIncs    = TratarNulo(usuincs,    "C")
            THIS.this_nInativas   = TratarNulo(inativas,   "N")
            THIS.this_nValor      = TratarNulo(valor,      "N")
            loc_lSucesso = .T.
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarLinhasRegra - Popula cursor csSigCdRga com linhas do servidor
    *--------------------------------------------------------------------------
    FUNCTION CarregarLinhasRegra(par_cCodigo)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF USED("csSigCdRga")
                USE IN csSigCdRga
            ENDIF

            SET NULL ON
            CREATE CURSOR csSigCdRga ( ;
                cIdChaves  C(20), ;
                Codigo     C(10), ;
                Empresa    C(3),  ;
                Grupo      C(10), ;
                Conta      C(10), ;
                Colecao    C(20), ;
                Quantidade N(3,0),;
                Prioridade N(3,0),;
                GrupoPr    C(3),  ;
                Zerar      C(1),  ;
                Ordem      C(1)   ;
            )
            SET NULL OFF

            IF NOT EMPTY(ALLTRIM(par_cCodigo))
                loc_cSQL = "SELECT a.cidchaves, a.codigo, a.empresa, a.grupo," + ;
                           " a.conta, a.colecao, a.quantidade, a.prioridade," + ;
                           " a.grupopr, a.zerar, a.ordem" + ;
                           " FROM SigCdRga a" + ;
                           " WHERE a.codigo = " + EscaparSQL(ALLTRIM(par_cCodigo)) + ;
                           " ORDER BY a.prioridade"

                *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
                IF USED("cursor_4c_LinhasRgr")
                    TABLEREVERT(.T., "cursor_4c_LinhasRgr")
                    USE IN cursor_4c_LinhasRgr
                ENDIF

                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_LinhasRgr")
                IF loc_nResultado >= 0
                    IF RECCOUNT("cursor_4c_LinhasRgr") > 0
                        SELECT cursor_4c_LinhasRgr
                        GO TOP
                        SCAN
                            SELECT csSigCdRga
                            APPEND BLANK
                            REPLACE cIdChaves  WITH ALLTRIM(cursor_4c_LinhasRgr.cidchaves)
                            REPLACE Codigo     WITH ALLTRIM(cursor_4c_LinhasRgr.codigo)
                            REPLACE Empresa    WITH ALLTRIM(cursor_4c_LinhasRgr.empresa)
                            REPLACE Grupo      WITH ALLTRIM(cursor_4c_LinhasRgr.grupo)
                            REPLACE Conta      WITH ALLTRIM(cursor_4c_LinhasRgr.conta)
                            REPLACE Colecao    WITH ALLTRIM(cursor_4c_LinhasRgr.colecao)
                            REPLACE Quantidade WITH cursor_4c_LinhasRgr.quantidade
                            REPLACE Prioridade WITH cursor_4c_LinhasRgr.prioridade
                            REPLACE GrupoPr    WITH ALLTRIM(cursor_4c_LinhasRgr.grupopr)
                            REPLACE Zerar      WITH ALLTRIM(cursor_4c_LinhasRgr.zerar)
                            REPLACE Ordem      WITH ALLTRIM(cursor_4c_LinhasRgr.ordem)
                            SELECT cursor_4c_LinhasRgr
                        ENDSCAN
                    ENDIF
                    loc_lSucesso = .T.
                ELSE
                    MsgErro("Erro ao carregar linhas de regra:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                ENDIF

                IF USED("cursor_4c_LinhasRgr")
                    USE IN cursor_4c_LinhasRgr
                ENDIF
            ELSE
                loc_lSucesso = .T.
            ENDIF

            SELECT csSigCdRga
            GO TOP
        CATCH TO loc_oErro
            MsgErro("Erro ao carregar linhas:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * InserirLinhasRegra - Insere linhas validas do csSigCdRga no SigCdRga
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION InserirLinhasRegra()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso, loc_cChaveRga
        loc_lSucesso = .T.

        IF NOT USED("csSigCdRga")
            RETURN .T.
        ENDIF

        TRY
            SELECT csSigCdRga
            GO TOP
            SCAN
                IF EMPTY(ALLTRIM(csSigCdRga.Empresa))    AND ;
                   EMPTY(ALLTRIM(csSigCdRga.Grupo))      AND ;
                   EMPTY(ALLTRIM(csSigCdRga.Conta))      AND ;
                   EMPTY(ALLTRIM(csSigCdRga.Colecao))    AND ;
                   EMPTY(ALLTRIM(csSigCdRga.GrupoPr))    AND ;
                   csSigCdRga.Quantidade = 0
                    LOOP
                ENDIF

                IF EMPTY(ALLTRIM(csSigCdRga.cIdChaves))
                    loc_cChaveRga = LEFT(SYS(2015) + SYS(2015) + SYS(2015), 20)
                ELSE
                    loc_cChaveRga = ALLTRIM(csSigCdRga.cIdChaves)
                ENDIF

                loc_cSQL = "INSERT INTO SigCdRga" + ;
                           " (cidchaves, codigo, empresa, grupo, conta, colecao," + ;
                           "  quantidade, prioridade, grupopr, zerar, ordem)" + ;
                           " VALUES (" + ;
                           EscaparSQL(loc_cChaveRga) + "," + ;
                           EscaparSQL(THIS.this_cCodigo) + "," + ;
                           EscaparSQL(ALLTRIM(csSigCdRga.Empresa)) + "," + ;
                           EscaparSQL(ALLTRIM(csSigCdRga.Grupo)) + "," + ;
                           EscaparSQL(ALLTRIM(csSigCdRga.Conta)) + "," + ;
                           EscaparSQL(ALLTRIM(csSigCdRga.Colecao)) + "," + ;
                           FormatarNumeroSQL(csSigCdRga.Quantidade) + "," + ;
                           FormatarNumeroSQL(csSigCdRga.Prioridade) + "," + ;
                           EscaparSQL(ALLTRIM(csSigCdRga.GrupoPr)) + "," + ;
                           EscaparSQL(ALLTRIM(csSigCdRga.Zerar)) + "," + ;
                           EscaparSQL(ALLTRIM(csSigCdRga.Ordem)) + ")"

                *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
                IF USED("cursor_4c_InsRga")
                    TABLEREVERT(.T., "cursor_4c_InsRga")
                    USE IN cursor_4c_InsRga
                ENDIF

                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_InsRga")
                IF USED("cursor_4c_InsRga")
                    USE IN cursor_4c_InsRga
                ENDIF

                IF loc_nResultado < 0
                    MsgErro("Erro ao inserir linha de regra:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                    loc_lSucesso = .F.
                    EXIT
                ENDIF
            ENDSCAN
        CATCH TO loc_oErro
            MsgErro("Erro ao inserir linhas:" + CHR(13) + loc_oErro.Message, "Erro")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir - INSERT em SigCdRGR + SigCdRga (PROTECTED)
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION Inserir()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            THIS.this_cCidChaves = LEFT(SYS(2015) + SYS(2015) + SYS(2015), 20)

            loc_cSQL = "INSERT INTO SigCdRGR" + ;
                       " (cidchaves, codigo, descricao, datas," + ;
                       "  observacao, usuincs, usualts, inativas, valor, dtaalts)" + ;
                       " VALUES (" + ;
                       EscaparSQL(THIS.this_cCidChaves) + "," + ;
                       EscaparSQL(THIS.this_cCodigo) + "," + ;
                       EscaparSQL(THIS.this_cDescricao) + "," + ;
                       "GETDATE()," + ;
                       EscaparSQL(THIS.this_cObservacao) + "," + ;
                       EscaparSQL(gc_4c_UsuarioLogado) + "," + ;
                       EscaparSQL("") + "," + ;
                       FormatarNumeroSQL(THIS.this_nInativas) + "," + ;
                       FormatarNumeroSQL(THIS.this_nValor) + "," + ;
                       "NULL)"

            *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
            IF USED("cursor_4c_InsRgr")
                TABLEREVERT(.T., "cursor_4c_InsRgr")
                USE IN cursor_4c_InsRgr
            ENDIF

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_InsRgr")
            IF USED("cursor_4c_InsRgr")
                USE IN cursor_4c_InsRgr
            ENDIF

            IF loc_nResultado >= 0
                loc_lSucesso = THIS.InserirLinhasRegra()
                IF loc_lSucesso
                    THIS.RegistrarAuditoria("INSERT")
                ENDIF
            ELSE
                MsgErro("Erro ao inserir regra:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao inserir regra:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - UPDATE SigCdRGR + DELETE/INSERT SigCdRga (PROTECTED)
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION Atualizar()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "UPDATE SigCdRGR SET" + ;
                       " descricao = " + EscaparSQL(THIS.this_cDescricao) + "," + ;
                       " observacao = " + EscaparSQL(THIS.this_cObservacao) + "," + ;
                       " usualts = " + EscaparSQL(gc_4c_UsuarioLogado) + "," + ;
                       " inativas = " + FormatarNumeroSQL(THIS.this_nInativas) + "," + ;
                       " valor = " + FormatarNumeroSQL(THIS.this_nValor) + "," + ;
                       " dtaalts = GETDATE()" + ;
                       " WHERE codigo = " + EscaparSQL(THIS.this_cCodigo)

            *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
            IF USED("cursor_4c_UpdRgr")
                TABLEREVERT(.T., "cursor_4c_UpdRgr")
                USE IN cursor_4c_UpdRgr
            ENDIF

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_UpdRgr")
            IF USED("cursor_4c_UpdRgr")
                USE IN cursor_4c_UpdRgr
            ENDIF

            IF loc_nResultado >= 0
                loc_cSQL = "DELETE FROM SigCdRga WHERE codigo = " + EscaparSQL(THIS.this_cCodigo)
                *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
                IF USED("cursor_4c_DelRga")
                    TABLEREVERT(.T., "cursor_4c_DelRga")
                    USE IN cursor_4c_DelRga
                ENDIF

                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_DelRga")
                IF USED("cursor_4c_DelRga")
                    USE IN cursor_4c_DelRga
                ENDIF

                IF loc_nResultado >= 0
                    loc_lSucesso = THIS.InserirLinhasRegra()
                    IF loc_lSucesso
                        loc_cSQL = "UPDATE SigPrdWb SET qtds = 0 WHERE codregra = " + ;
                                   EscaparSQL(THIS.this_cCodigo)
                        *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
                        IF USED("cursor_4c_UpdWb")
                            TABLEREVERT(.T., "cursor_4c_UpdWb")
                            USE IN cursor_4c_UpdWb
                        ENDIF

                        SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_UpdWb")
                        IF USED("cursor_4c_UpdWb")
                            USE IN cursor_4c_UpdWb
                        ENDIF
                        THIS.RegistrarAuditoria("UPDATE")
                    ENDIF
                ELSE
                    MsgErro("Erro ao excluir linhas antigas:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                ENDIF
            ELSE
                MsgErro("Erro ao atualizar regra:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao atualizar regra:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ExecutarExclusao - DELETE SigCdRga + SigCdRGR (PROTECTED)
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION ExecutarExclusao()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "DELETE FROM SigCdRga WHERE codigo = " + EscaparSQL(THIS.this_cCodigo)
            *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
            IF USED("cursor_4c_DelRga")
                TABLEREVERT(.T., "cursor_4c_DelRga")
                USE IN cursor_4c_DelRga
            ENDIF

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_DelRga")
            IF USED("cursor_4c_DelRga")
                USE IN cursor_4c_DelRga
            ENDIF

            IF loc_nResultado >= 0
                loc_cSQL = "DELETE FROM SigCdRGR WHERE codigo = " + EscaparSQL(THIS.this_cCodigo)
                *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
                IF USED("cursor_4c_DelRgr")
                    TABLEREVERT(.T., "cursor_4c_DelRgr")
                    USE IN cursor_4c_DelRgr
                ENDIF

                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_DelRgr")
                IF USED("cursor_4c_DelRgr")
                    USE IN cursor_4c_DelRgr
                ENDIF

                IF loc_nResultado >= 0
                    THIS.RegistrarAuditoria("DELETE")
                    loc_lSucesso = .T.
                ELSE
                    MsgErro("Erro ao excluir regra:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                ENDIF
            ELSE
                MsgErro("Erro ao excluir linhas de regra:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao excluir regra:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Destroy - Limpeza de cursores ao destruir o BO
    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
        IF USED("cursor_4c_Dados")
            USE IN cursor_4c_Dados
        ENDIF
        IF USED("csSigCdRga")
            USE IN csSigCdRga
        ENDIF
        DODEFAULT()
    ENDPROC

ENDDEFINE


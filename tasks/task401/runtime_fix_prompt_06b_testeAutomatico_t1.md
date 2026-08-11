# CORRIGIR ERRO DE RUNTIME VFP9

## TAREFA OBRIGATORIA
O formulario VFP9 apresentou erro de runtime durante teste automatizado.
Voce DEVE corrigir o erro e salvar os arquivos corrigidos usando Write tool.

## ERRO DETECTADO
- Etapa: 06b_testeAutomatico
- Tentativa: 1/10
- Mensagem: Testes automaticos: 78% < 100%. Falhas: Teste 'CarregarLista': Nenhum cursor padrao foi criado (cursor_4c_Dados/Lista/Busca/etc); Teste 'ModoVisualizar': Property AJUSTARBOTOESPORMODO is not found. | Detalhes: Linha: 542

## CONTEXTO DO ERRO

### LOG DA ETAPA (06b_testeAutomatico):
[2026-08-01 09:39:17] [INFO] === VFP EXECUTOR v2.0 ===
[2026-08-01 09:39:17] [INFO] Config FPW: (nao fornecido)
[2026-08-01 09:39:17] [INFO] Script PRG: C:\4c\projeto\app\utils\TesteAutomatico.prg
[2026-08-01 09:39:17] [INFO] Timeout: 300 segundos
[2026-08-01 09:39:17] [INFO] Wrapper PRG criado para parametros: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_kttmvoko.prg
[2026-08-01 09:39:17] [INFO] Conteudo do wrapper:
[2026-08-01 09:39:17] [INFO] * Auto-generated wrapper for parameters
* Script: C:\4c\projeto\app\utils\TesteAutomatico.prg
* Parameters: 'Formema', 'C:\4c\tasks\task401', 'CRUD'

* Anti-dialog protections for unattended execution
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
SET NOTIFY OFF
SYS(2335, 0)

DO "C:\4c\projeto\app\utils\TesteAutomatico" WITH 'Formema', 'C:\4c\tasks\task401', 'CRUD'
QUIT

[2026-08-01 09:39:17] [INFO] Comando VFP: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_kttmvoko.prg
[2026-08-01 09:39:17] [INFO] VFP output esperado em: C:\4c\tasks\task401\vfp_output.txt
[2026-08-01 09:39:17] [INFO] Executando Visual FoxPro 9...
[2026-08-01 09:39:17] [INFO] Comando completo: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_kttmvoko.prg
[2026-08-01 09:39:17] [INFO] Executando: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_kttmvoko.prg
[2026-08-01 09:39:17] [INFO] Timeout configurado: 300 segundos
[2026-08-01 09:40:07] [INFO] VFP9 finalizou normalmente com exit code: 
[2026-08-01 09:40:07] [INFO] VFP9 finalizado em 50.4023556 segundos
[2026-08-01 09:40:07] [INFO] Exit Code: 
[2026-08-01 09:40:07] [INFO] 
[2026-08-01 09:40:07] [INFO] Arquivos temporarios preservados para inspecao:
[2026-08-01 09:40:07] [INFO]   Wrapper.prg: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_kttmvoko.prg
[2026-08-01 09:40:07] [INFO] 
[2026-08-01 09:40:07] [INFO] === Conteudo do Wrapper.prg temporario ===
[2026-08-01 09:40:07] [INFO] * Auto-generated wrapper for parameters
[2026-08-01 09:40:07] [INFO] * Script: C:\4c\projeto\app\utils\TesteAutomatico.prg
[2026-08-01 09:40:07] [INFO] * Parameters: 'Formema', 'C:\4c\tasks\task401', 'CRUD'
[2026-08-01 09:40:07] [INFO] 
[2026-08-01 09:40:07] [INFO] * Anti-dialog protections for unattended execution
[2026-08-01 09:40:07] [INFO] SET SAFETY OFF
[2026-08-01 09:40:07] [INFO] SET RESOURCE OFF
[2026-08-01 09:40:07] [INFO] SET TALK OFF
[2026-08-01 09:40:07] [INFO] SET NOTIFY OFF
[2026-08-01 09:40:07] [INFO] SYS(2335, 0)
[2026-08-01 09:40:07] [INFO] 
[2026-08-01 09:40:07] [INFO] DO "C:\4c\projeto\app\utils\TesteAutomatico" WITH 'Formema', 'C:\4c\tasks\task401', 'CRUD'
[2026-08-01 09:40:07] [INFO] QUIT
[2026-08-01 09:40:07] [INFO] 
[2026-08-01 09:40:07] [INFO] === Fim do Wrapper.prg ===
[2026-08-01 09:40:07] [WARN] AVISO: VFP9 retornou exit code  (normal para VFP9 GUI - validar pelo arquivo de saida)


### RESULTADO DOS TESTES (teste_resultado.json):
{
  "formClass": "Formema",
  "timestamp": "20260801094007",
  "testes": [
    {
      "nome": "Instanciacao",
      "passou": true,
      "erro": "",
      "detalhes": "Objeto criado com sucesso"
    },
    {
      "nome": "CarregarLista",
      "passou": false,
      "erro": "Nenhum cursor padrao foi criado (cursor_4c_Dados/Lista/Busca/etc)",
      "detalhes": ""
    },
    {
      "nome": "ModoIncluir",
      "passou": true,
      "erro": "",
      "detalhes": "Page2 ativada com sucesso"
    },
    {
      "nome": "ModoVisualizar",
      "passou": false,
      "erro": "Property AJUSTARBOTOESPORMODO is not found.",
      "detalhes": "Linha: 542"
    },
    {
      "nome": "BtnIncluirNavegacao",
      "passou": true,
      "erro": "",
      "detalhes": "BtnIncluirClick navegou para Page2 | BtnCancelarClick retornou para Page1"
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
    "passou": 7,
    "falhou": 2,
    "percentual": 78
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

### FORM (C:\4c\projeto\app\forms\cadastros\Formema.prg):
*==============================================================================
* Formema.prg - Formulario de Cadastro de Email
* Tabela: SigCdEma (cIdChaves, Cods)
* Herda de: FormBase
* Tipo: CRUD (frmcadastro)
* FASE 7/8: Form - Eventos principais (Incluir/Visualizar/Alterar/Excluir)
*==============================================================================

DEFINE CLASS Formema AS FormBase

    *-- Propriedades visuais (PILAR 1 - UX Fidelity - SIGCDEMA: W=1000, H=600)
    Height      = 600
    Width       = 1000
    Caption     = "Cadastro de Email"
    AutoCenter  = .T.
    ShowWindow  = 1
    WindowType  = 1
    ControlBox  = .F.
    TitleBar    = 0
    Themes      = .F.
    BorderStyle = 2
    BackColor   = RGB(100, 100, 100)
    DataSession = 2

    *-- Propriedades internas
    this_oBusinessObject = .NULL.
    this_cMensagemErro   = ""

    *--------------------------------------------------------------------------
    * Init - Delega para FormBase (que chama InicializarForm e SET DATE/CENTURY)
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_lSucesso = DODEFAULT()
        CATCH TO loc_oErro
            MsgErro("Erro em Formema.Init:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * InicializarForm - Cria estrutura completa do formulario
    * Chamado automaticamente por FormBase.Init()
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            THIS.this_oBusinessObject = CREATEOBJECT("emaBO")

            IF VARTYPE(THIS.this_oBusinessObject) != "O"
                MsgErro("Erro ao criar emaBO", "Erro")
            ELSE
                THIS.ConfigurarPageFrame()
                THIS.ConfigurarPaginaLista()
                THIS.ConfigurarPaginaDados()

                THIS.pgf_4c_Paginas.Page1.cnt_4c_Sombra.lbl_4c_Sombra.Caption = THIS.Caption
                THIS.pgf_4c_Paginas.Page1.cnt_4c_Sombra.lbl_4c_Titulo.Caption = THIS.Caption
                THIS.pgf_4c_Paginas.Page2.cnt_4c_Sombra.lbl_4c_Sombra.Caption = THIS.Caption
                THIS.pgf_4c_Paginas.Page2.cnt_4c_Sombra.lbl_4c_Titulo.Caption = THIS.Caption

                THIS.CarregarLista()

                THIS.pgf_4c_Paginas.Visible   = .T.
                THIS.pgf_4c_Paginas.ActivePage = 1
                THIS.this_cModoAtual = "LISTA"
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em InicializarForm:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPageFrame - Cria PageFrame com 2 paginas (Lista e Dados)
    * Original: Pagina.Width=1003; PageFrame.Top=-29 para ocultar abas
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPageFrame()
        THIS.AddObject("pgf_4c_Paginas", "PageFrame")

        WITH THIS.pgf_4c_Paginas
            .PageCount = 2
            .Top       = -29
            .Left      = 0
            .Width     = 1003
            .Height    = 631    && runtime adiciona +4 -> 635 visivel
            .Tabs      = .F.
        ENDWITH

        THIS.pgf_4c_Paginas.Page1.Caption   = "Lista"
        THIS.pgf_4c_Paginas.Page1.BackColor = RGB(255, 255, 255)
        THIS.pgf_4c_Paginas.Page1.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"

        THIS.pgf_4c_Paginas.Page2.Caption   = "Dados"
        THIS.pgf_4c_Paginas.Page2.BackColor = RGB(255, 255, 255)
        THIS.pgf_4c_Paginas.Page2.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPaginaLista - Cria estrutura da Page1
    * Original: cntSombra(Top=1,L=-1,W=1020,H=80), Grupo_op(L=542,T=-1),
    *           Grupo_Saida(L=917,T=-1), Grade(T=112,L=20,W=940,H=470)
    * Fase 3: containers vazios; Fase 4 adiciona grade e botoes CRUD
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPaginaLista()
        LOCAL loc_oPagina
        loc_oPagina = THIS.pgf_4c_Paginas.Page1

        *-- Fundo padrao do framework frmcadastro (sem isso a pagina fica branca)
        loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"

        *-- Container sombra/titulo (cntSombra: Top=1+29=30, Left=0, W=1020, H=80)
        loc_oPagina.AddObject("cnt_4c_Sombra", "Container")
        WITH loc_oPagina.cnt_4c_Sombra
            .Top         = 30       && 1 + 29 (compensacao PageFrame.Top=-29)
            .Left        = 0
            .Width       = 1020
            .Height      = 80
            .BackColor   = RGB(100, 100, 100)
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH

        loc_oPagina.cnt_4c_Sombra.AddObject("lbl_4c_Sombra", "Label")
        WITH loc_oPagina.cnt_4c_Sombra.lbl_4c_Sombra
            .Caption   = THIS.Caption
            .Top       = 45
            .Left      = 12
            .Width     = 980
            .Height    = 30
            .AutoSize  = .F.
            .FontName  = "Tahoma"
            .FontSize  = 18
            .FontBold  = .T.
            .ForeColor = RGB(30, 30, 30)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oPagina.cnt_4c_Sombra.AddObject("lbl_4c_Titulo", "Label")
        WITH loc_oPagina.cnt_4c_Sombra.lbl_4c_Titulo
            .Caption   = THIS.Caption
            .Top       = 43
            .Left      = 10
            .Width     = 980
            .Height    = 30
            .AutoSize  = .F.
            .FontName  = "Tahoma"
            .FontSize  = 18
            .FontBold  = .T.
            .ForeColor = RGB(255, 255, 255)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        *-- Container botoes CRUD (Grupo_op: L=542, Top=-1+29=28)
        loc_oPagina.AddObject("cnt_4c_Botoes", "Container")
        WITH loc_oPagina.cnt_4c_Botoes
            .Top         = 28
            .Left        = 542
            .Width       = 390
            .Height      = 88
            .BackStyle   = 0
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH

        *-- Botao Incluir
        loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Incluir", "CommandButton")
        WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Incluir
            .Caption         = "Incluir"
            .Top             = 5
            .Left            = 5
            .Width           = 75
            .Height          = 75
            .Picture         = gc_4c_CaminhoIcones + "cadastro_inserir_26.jpg"
            .PicturePosition = 13
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
        ENDWITH

        *-- Botao Visualizar
        loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Visualizar", "CommandButton")
        WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar
            .Caption         = "Visualizar"
            .Top             = 5
            .Left            = 80
            .Width           = 75
            .Height          = 75
            .Picture         = gc_4c_CaminhoIcones + "cadastro_vizualizar_60.jpg"
            .PicturePosition = 13
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
        ENDWITH

        *-- Botao Alterar
        loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Alterar", "CommandButton")
        WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar
            .Caption         = "Alterar"
            .Top             = 5
            .Left            = 155
            .Width           = 75
            .Height          = 75
            .Picture         = gc_4c_CaminhoIcones + "cadastro_alterar_60.jpg"
            .PicturePosition = 13
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
        ENDWITH

        *-- Botao Excluir
        loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Excluir", "CommandButton")
        WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir
            .Caption         = "Excluir"
            .Top             = 5
            .Left            = 230
            .Width           = 75
            .Height          = 75
            .Picture         = gc_4c_CaminhoIcones + "cadastro_excluir_60.jpg"
            .PicturePosition = 13
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
        ENDWITH

        *-- Botao Buscar
        loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Buscar", "CommandButton")
        WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Buscar
            .Caption         = "Buscar"
            .Top             = 5
            .Left            = 305
            .Width           = 75
            .Height          = 75
            .Picture         = gc_4c_CaminhoIcones + "cadastro_procurar_60.jpg"
            .PicturePosition = 13
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
        ENDWITH

        *-- Container botao Encerrar (canonico: L=917, Top=29)
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

        *-- Botao Encerrar
        loc_oPagina.cnt_4c_Saida.AddObject("cmd_4c_Encerrar", "CommandButton")
        WITH loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar
            .Caption         = "Encerrar"
            .Top             = 5
            .Left            = 5
            .Width           = 75
            .Height          = 75
            .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
            .PicturePosition = 13
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
        ENDWITH

        *-- Grid lista (Grade: Top=112+29=141, Left=20, Width=890, Height=470)
        loc_oPagina.AddObject("grd_4c_Lista", "Grid")
        WITH loc_oPagina.grd_4c_Lista
            .Top                = 141
            .Left               = 20
            .Width              = 890
            .Height             = 470
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

        *-- BINDEVENTs dos botoes CRUD (handlers devem ser PUBLIC)
        BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Incluir,    "Click", THIS, "BtnIncluirClick")
        BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar, "Click", THIS, "BtnVisualizarClick")
        BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar,    "Click", THIS, "BtnAlterarClick")
        BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir,    "Click", THIS, "BtnExcluirClick")
        BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Buscar,     "Click", THIS, "BtnBuscarClick")
        BINDEVENT(loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar,    "Click", THIS, "BtnEncerrarClick")
        BINDEVENT(loc_oPagina.grd_4c_Lista, "DblClick", THIS, "GradeListaDblClick")

        THIS.TornarControlesVisiveis(loc_oPagina)
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPaginaDados - Cria estrutura da Page2
    * Original: Grupo_Salva(L=812,T=24), getCods(T=137,L=359,W=339,H=24),
    *           Say1(T=141,L=301) "Descricao :"
    * Fase 5: adicionados lbl_4c_Label1 + txt_4c_Codigo (email)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPaginaDados()
        LOCAL loc_oPagina
        loc_oPagina = THIS.pgf_4c_Paginas.Page2

        *-- Fundo padrao do framework frmcadastro (sem isso a pagina fica branca)
        loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"

        *-- Container sombra/titulo (espelha Page1)
        loc_oPagina.AddObject("cnt_4c_Sombra", "Container")
        WITH loc_oPagina.cnt_4c_Sombra
            .Top         = 30       && 1 + 29 (compensacao PageFrame.Top=-29)
            .Left        = 0
            .Width       = 1020
            .Height      = 80
            .BackColor   = RGB(100, 100, 100)
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH

        loc_oPagina.cnt_4c_Sombra.AddObject("lbl_4c_Sombra", "Label")
        WITH loc_oPagina.cnt_4c_Sombra.lbl_4c_Sombra
            .Caption   = THIS.Caption
            .Top       = 45
            .Left      = 12
            .Width     = 980
            .Height    = 30
            .AutoSize  = .F.
            .FontName  = "Tahoma"
            .FontSize  = 18
            .FontBold  = .T.
            .ForeColor = RGB(30, 30, 30)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oPagina.cnt_4c_Sombra.AddObject("lbl_4c_Titulo", "Label")
        WITH loc_oPagina.cnt_4c_Sombra.lbl_4c_Titulo
            .Caption   = THIS.Caption
            .Top       = 43
            .Left      = 10
            .Width     = 980
            .Height    = 30
            .AutoSize  = .F.
            .FontName  = "Tahoma"
            .FontSize  = 18
            .FontBold  = .T.
            .ForeColor = RGB(255, 255, 255)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        *-- Container botoes Salvar/Cancelar (Grupo_Salva: L=812, Top=24+29=53)
        loc_oPagina.AddObject("cnt_4c_BotoesAcao", "Container")
        WITH loc_oPagina.cnt_4c_BotoesAcao
            .Top         = 53       && 24 + 29
            .Left        = 812
            .Width       = 175
            .Height      = 88
            .BackStyle = 0
            .BackColor   = RGB(255, 255, 255)
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH

        *-- Botao Salvar (Salva: Left=7, Top=5)
        loc_oPagina.cnt_4c_BotoesAcao.AddObject("cmd_4c_Salvar", "CommandButton")
        WITH loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Salvar
            .Caption         = "Salvar"
            .Top             = 5
            .Left            = 7
            .Width           = 75
            .Height          = 75
            .Picture         = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
            .PicturePosition = 13
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
        ENDWITH

        *-- Botao Cancelar (Cancelar: Left=82, Top=5)
        loc_oPagina.cnt_4c_BotoesAcao.AddObject("cmd_4c_Cancelar", "CommandButton")
        WITH loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Cancelar
            .Caption         = "Encerrar"
            .Top             = 5
            .Left            = 82
            .Width           = 75
            .Height          = 75
            .Picture         = gc_4c_CaminhoIcones + "cadastro_cancelar_60.jpg"
            .PicturePosition = 13
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
        ENDWITH

        *-- BINDEVENTs dos botoes de acao (handlers PUBLIC para BINDEVENT funcionar)
        BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Salvar,   "Click", THIS, "BtnSalvarClick")
        BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Cancelar, "Click", THIS, "BtnCancelarClick")

        *-- Label "Descricao :" (Say1: Top=141+29=170, Left=301, ForeColor=RGB(90,90,90))
        loc_oPagina.AddObject("lbl_4c_Label1", "Label")
        WITH loc_oPagina.lbl_4c_Label1
            .Caption   = "Descri" + CHR(231) + CHR(227) + "o :"
            .Top       = 170
            .Left      = 301
            .Width     = 55
            .Height    = 17
            .AutoSize  = .F.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .F.
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Alignment = 1
            .Visible   = .T.
        ENDWITH

        *-- Campo Email (getCods: Top=137+29=166, Left=359, W=339, H=24, MaxLength=50)
        loc_oPagina.AddObject("txt_4c_Codigo", "TextBox")
        WITH loc_oPagina.txt_4c_Codigo
            .Value         = ""
            .Top           = 166
            .Left          = 359
            .Width         = 339
            .Height        = 24
            .MaxLength     = 50
            .SpecialEffect = 1
            .FontName      = "Tahoma"
            .FontSize      = 8
            .ReadOnly      = .T.
            .Visible       = .T.
        ENDWITH

        THIS.TornarControlesVisiveis(loc_oPagina)
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarLista - Carrega dados no Grid da Page1 e vincula colunas
    *--------------------------------------------------------------------------
    PROCEDURE CarregarLista()
        LOCAL loc_lResultado, loc_oGrid
        loc_lResultado = .F.

        TRY
            IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
                SET NULL ON
                CREATE CURSOR cursor_4c_Dados (Cods C(50))
                SET NULL OFF
                loc_lResultado = .T.
            ELSE
                loc_lResultado = THIS.this_oBusinessObject.Buscar("")
            ENDIF

            IF loc_lResultado AND PEMSTATUS(THIS.pgf_4c_Paginas.Page1, "grd_4c_Lista", 5)
                loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Lista

                *-- RecordSource e ColumnCount FORA de WITH (Problema 36/48)
                loc_oGrid.ColumnCount = 3
                loc_oGrid.RecordSource = "cursor_4c_Dados"
                loc_oGrid.ColumnCount  = 1

                WITH loc_oGrid
                    .Column1.ControlSource   = "cursor_4c_Dados.Cods"
                    .Column1.Width           = 880
                    .Column1.Header1.Caption = "Email"
                ENDWITH

                THIS.FormatarGridLista(loc_oGrid)
                loc_oGrid.Refresh()
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em CarregarLista:" + CHR(13) + loc_oErro.Message, "Erro")
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * AlternarPagina - Alterna entre Page1 (Lista=1) e Page2 (Dados=2)
    *--------------------------------------------------------------------------
    PROCEDURE AlternarPagina(par_nPagina)
        LOCAL loc_lResultado
        loc_lResultado = .F.

        IF VARTYPE(par_nPagina) != "N" OR par_nPagina < 1 OR par_nPagina > 2
            RETURN .F.
        ENDIF

        THIS.pgf_4c_Paginas.ActivePage = par_nPagina

        IF par_nPagina = 1
            THIS.CarregarLista()
        ENDIF

        loc_lResultado = .T.
        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * TornarControlesVisiveis - Torna controles visiveis recursivamente
    * Percorre Pages de PageFrames e Controls de Containers
    *--------------------------------------------------------------------------
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

    *--------------------------------------------------------------------------
    * FormatarGridLista - Formata visual do grid da lista
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE FormatarGridLista(par_oGrid)
        WITH par_oGrid
            .FontName = "Tahoma"
            .FontSize = 8
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnIncluirClick - Prepara formulario para inclusao de novo registro
    *--------------------------------------------------------------------------
    PROCEDURE BtnIncluirClick()
        THIS.this_oBusinessObject.NovoRegistro()
        THIS.LimparCampos()
        THIS.this_cModoAtual = "INCLUIR"
        THIS.HabilitarCampos(.T.)
        THIS.AlternarPagina(2)
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnVisualizarClick - Carrega registro selecionado em modo somente leitura
    *--------------------------------------------------------------------------
    PROCEDURE BtnVisualizarClick()
        LOCAL loc_cCodigo
        loc_cCodigo = ""

        IF USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados")
            SELECT cursor_4c_Dados
            loc_cCodigo = ALLTRIM(cursor_4c_Dados.Cods)
        ENDIF

        IF EMPTY(loc_cCodigo)
            MsgAviso("Selecione um registro na lista.", "Visualizar")
            RETURN
        ENDIF

        IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
            THIS.BOParaForm()
            THIS.this_cModoAtual = "VISUALIZAR"
            THIS.HabilitarCampos(.F.)
            THIS.AlternarPagina(2)
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnAlterarClick - Carrega registro selecionado para edicao
    *--------------------------------------------------------------------------
    PROCEDURE BtnAlterarClick()
        LOCAL loc_cCodigo
        loc_cCodigo = ""

        IF USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados")
            SELECT cursor_4c_Dados
            loc_cCodigo = ALLTRIM(cursor_4c_Dados.Cods)
        ENDIF

        IF EMPTY(loc_cCodigo)
            MsgAviso("Selecione um registro na lista.", "Alterar")
            RETURN
        ENDIF

        IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
            THIS.this_oBusinessObject.EditarRegistro()
            THIS.BOParaForm()
            THIS.this_cModoAtual = "ALTERAR"
            THIS.HabilitarCampos(.T.)
            THIS.AlternarPagina(2)
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnExcluirClick - Confirma e exclui o registro selecionado
    *--------------------------------------------------------------------------
    PROCEDURE BtnExcluirClick()
        LOCAL loc_cCodigo, loc_lConfirmado
        loc_cCodigo    = ""
        loc_lConfirmado = .F.

        IF USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados")
            SELECT cursor_4c_Dados
            loc_cCodigo = ALLTRIM(cursor_4c_Dados.Cods)
        ENDIF

        IF EMPTY(loc_cCodigo)
            MsgAviso("Selecione um registro na lista.", "Excluir")
            RETURN
        ENDIF

        loc_lConfirmado = MsgConfirma("Confirma a exclus" + CHR(227) + "o deste registro?", ;
                                      "Confirmar Exclus" + CHR(227) + "o")
        IF !loc_lConfirmado
            RETURN
        ENDIF

        IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
            IF THIS.this_oBusinessObject.Excluir()
                MsgInfo("Registro exclu" + CHR(237) + "do com sucesso.", "Exclus" + CHR(227) + "o")
                THIS.CarregarLista()
            ENDIF
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnBuscarClick - Filtra registros da lista por email digitado
    *--------------------------------------------------------------------------
    PROCEDURE BtnBuscarClick()
        LOCAL loc_cFiltro, loc_lResultado
        loc_cFiltro    = ""
        loc_lResultado = .F.

        IF PEMSTATUS(THIS.pgf_4c_Paginas.Page1, "txt_4c_Busca", 5)
            loc_cFiltro = ALLTRIM(THIS.pgf_4c_Paginas.Page1.txt_4c_Busca.Value)
        ENDIF

        TRY
            loc_lResultado = THIS.this_oBusinessObject.Buscar(loc_cFiltro)
            IF loc_lResultado AND PEMSTATUS(THIS.pgf_4c_Paginas.Page1, "grd_4c_Lista", 5)
                LOCAL loc_oGrid
                loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Lista
                loc_oGrid.ColumnCount = 3
                loc_oGrid.RecordSource = "cursor_4c_Dados"
                loc_oGrid.ColumnCount  = 1
                WITH loc_oGrid
                    .Column1.ControlSource   = "cursor_4c_Dados.Cods"
                    .Column1.Width           = 880
                    .Column1.Header1.Caption = "Email"
                ENDWITH
                loc_oGrid.Refresh()
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em BtnBuscarClick:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnEncerrarClick - Fecha o formulario
    *--------------------------------------------------------------------------
    PROCEDURE BtnEncerrarClick()
        THIS.Release()
    ENDPROC

    *--------------------------------------------------------------------------
    * GradeListaDblClick - Duplo clique na grade abre modo visualizar
    *--------------------------------------------------------------------------
    PROCEDURE GradeListaDblClick()
        THIS.BtnVisualizarClick()
    ENDPROC

    *--------------------------------------------------------------------------
    * LimparCampos - Limpa valores dos campos da Page2
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE LimparCampos()
        LOCAL loc_oPagina
        loc_oPagina = THIS.pgf_4c_Paginas.Page2

        IF PEMSTATUS(loc_oPagina, "txt_4c_Codigo", 5)
            loc_oPagina.txt_4c_Codigo.Value = ""
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * HabilitarCampos - Habilita ou desabilita campos da Page2
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE HabilitarCampos(par_lHabilitar)
        LOCAL loc_oPagina, loc_lEdicao
        loc_oPagina = THIS.pgf_4c_Paginas.Page2
        loc_lEdicao = (par_lHabilitar AND THIS.this_cModoAtual != "VISUALIZAR")

        IF PEMSTATUS(loc_oPagina, "txt_4c_Codigo", 5)
            loc_oPagina.txt_4c_Codigo.ReadOnly = !loc_lEdicao
        ENDIF

        IF PEMSTATUS(loc_oPagina, "cnt_4c_BotoesAcao", 5)
            IF PEMSTATUS(loc_oPagina.cnt_4c_BotoesAcao, "cmd_4c_Salvar", 5)
                loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Salvar.Enabled = loc_lEdicao
            ENDIF
            IF PEMSTATUS(loc_oPagina.cnt_4c_BotoesAcao, "cmd_4c_Cancelar", 5)
                loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Cancelar.Enabled = .T.
            ENDIF
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * FormParaBO - Transfere valores dos campos do formulario para o BO
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE FormParaBO()
        LOCAL loc_oPagina
        loc_oPagina = THIS.pgf_4c_Paginas.Page2

        IF PEMSTATUS(loc_oPagina, "txt_4c_Codigo", 5)
            THIS.this_oBusinessObject.this_cCods = ;
                ALLTRIM(loc_oPagina.txt_4c_Codigo.Value)
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * BOParaForm - Transfere valores do BO para os campos do formulario
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE BOParaForm()
        LOCAL loc_oPagina
        loc_oPagina = THIS.pgf_4c_Paginas.Page2

        IF PEMSTATUS(loc_oPagina, "txt_4c_Codigo", 5)
            loc_oPagina.txt_4c_Codigo.Value = ;
                ALLTRIM(THIS.this_oBusinessObject.this_cCods)
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnSalvarClick - Valida e salva o registro (INSERT ou UPDATE)
    * Logica: valida email nao vazio, delega ao BO (que verifica duplicidade)
    *--------------------------------------------------------------------------
    PROCEDURE BtnSalvarClick()
        LOCAL loc_cEmail, loc_lSucesso
        loc_cEmail   = ""
        loc_lSucesso = .F.

        *-- Validacao ANTES do TRY (RETURN e permitido fora de TRY/CATCH)
        IF PEMSTATUS(THIS.pgf_4c_Paginas.Page2, "txt_4c_Codigo", 5)
            loc_cEmail = ALLTRIM(THIS.pgf_4c_Paginas.Page2.txt_4c_Codigo.Value)
        ENDIF

        IF EMPTY(loc_cEmail)
            MsgAviso("Email Inv" + CHR(225) + "lido!!!", "Aten" + CHR(231) + CHR(227) + "o!!!")
            IF PEMSTATUS(THIS.pgf_4c_Paginas.Page2, "txt_4c_Codigo", 5)
                THIS.pgf_4c_Paginas.Page2.txt_4c_Codigo.SetFocus()
            ENDIF
            RETURN
        ENDIF

        TRY
            THIS.FormParaBO()
            loc_lSucesso = THIS.this_oBusinessObject.Salvar()

            IF loc_lSucesso
                MsgInfo("Registro salvo com sucesso.", "Cadastro de Email")
                THIS.this_cModoAtual = "LISTA"
                THIS.AlternarPagina(1)
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao salvar:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnCancelarClick - Cancela edicao e volta para a lista
    *--------------------------------------------------------------------------
    PROCEDURE BtnCancelarClick()
        THIS.this_cModoAtual = "LISTA"
        THIS.AlternarPagina(1)
    ENDPROC

    *--------------------------------------------------------------------------
    * AjustarBotoesPorModo - Habilita/desabilita botoes CRUD conforme o modo
    * INCLUIR/ALTERAR: habilita Salvar, desabilita Incluir/Alterar/Excluir
    * VISUALIZAR/LISTA: ajuste padrao
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE AjustarBotoesPorModo()
        LOCAL loc_oPg1, loc_oPg2, loc_lNaLista
        loc_lNaLista = (THIS.this_cModoAtual = "LISTA")

        IF PEMSTATUS(THIS.pgf_4c_Paginas, "Page1", 5) AND ;
           PEMSTATUS(THIS.pgf_4c_Paginas.Page1, "cnt_4c_Botoes", 5)

            loc_oPg1 = THIS.pgf_4c_Paginas.Page1.cnt_4c_Botoes

            IF PEMSTATUS(loc_oPg1, "cmd_4c_Incluir", 5)
                loc_oPg1.cmd_4c_Incluir.Enabled = loc_lNaLista
            ENDIF
            IF PEMSTATUS(loc_oPg1, "cmd_4c_Visualizar", 5)
                loc_oPg1.cmd_4c_Visualizar.Enabled = loc_lNaLista
            ENDIF
            IF PEMSTATUS(loc_oPg1, "cmd_4c_Alterar", 5)
                loc_oPg1.cmd_4c_Alterar.Enabled = loc_lNaLista
            ENDIF
            IF PEMSTATUS(loc_oPg1, "cmd_4c_Excluir", 5)
                loc_oPg1.cmd_4c_Excluir.Enabled = loc_lNaLista
            ENDIF
            IF PEMSTATUS(loc_oPg1, "cmd_4c_Buscar", 5)
                loc_oPg1.cmd_4c_Buscar.Enabled = loc_lNaLista
            ENDIF
        ENDIF

        IF PEMSTATUS(THIS.pgf_4c_Paginas, "Page2", 5) AND ;
           PEMSTATUS(THIS.pgf_4c_Paginas.Page2, "cnt_4c_BotoesAcao", 5)

            loc_oPg2 = THIS.pgf_4c_Paginas.Page2.cnt_4c_BotoesAcao
            LOCAL loc_lEdicao
            loc_lEdicao = INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")

            IF PEMSTATUS(loc_oPg2, "cmd_4c_Salvar", 5)
                loc_oPg2.cmd_4c_Salvar.Enabled = loc_lEdicao
            ENDIF
            IF PEMSTATUS(loc_oPg2, "cmd_4c_Cancelar", 5)
                loc_oPg2.cmd_4c_Cancelar.Enabled = .T.
            ENDIF
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * Destroy - Libera recursos ao fechar o formulario
    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
        IF VARTYPE(THIS.this_oBusinessObject) = "O"
            THIS.this_oBusinessObject = .NULL.
        ENDIF

        IF USED("cursor_4c_Dados")
            USE IN cursor_4c_Dados
        ENDIF

        DODEFAULT()
    ENDPROC

ENDDEFINE


### BO (C:\4c\projeto\app\classes\emaBO.prg):
*==============================================================================
* EMABO.PRG
* Business Object para Cadastro de Email (SigCdEma)
* Herda de BusinessBase
*==============================================================================

DEFINE CLASS emaBO AS BusinessBase

    *-- Propriedades de dados
    this_cIdChaves     = ""    && cIdChaves (C 20) - PK tecnica (UUID gerado por fUniqueIds)
    this_cCods         = ""    && Email (C 50) - chave natural unica
    this_cCodsOriginal = ""    && Cods original apos CarregarPorCodigo (para UPDATE WHERE)

    *--------------------------------------------------------------------------
    * Init - Configura tabela e campo chave
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        LOCAL loc_lResultado
        loc_lResultado = .F.

        TRY
            DODEFAULT()
            THIS.this_cTabela     = "SigCdEma"
            THIS.this_cCampoChave = "cIdChaves"
            loc_lResultado = .T.
        CATCH TO loc_oErro
            MsgErro("Erro ao inicializar emaBO: " + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Retorna PK atual para auditoria
    *--------------------------------------------------------------------------
    FUNCTION ObterChavePrimaria()
        RETURN THIS.this_cIdChaves
    ENDFUNC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Carrega propriedades a partir de cursor
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lResultado
        loc_lResultado = .F.

        IF USED(par_cAliasCursor)
            SELECT (par_cAliasCursor)
            THIS.this_cIdChaves     = TratarNulo(cIdChaves, "C")
            THIS.this_cCods         = TratarNulo(Cods, "C")
            THIS.this_cCodsOriginal = THIS.this_cCods
            loc_lResultado = .T.
        ENDIF

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * Buscar - Retorna todos os emails (ou filtrados por texto)
    *--------------------------------------------------------------------------
    PROCEDURE Buscar(par_cFiltro)
        LOCAL loc_lResultado, loc_cSQL, loc_nResultado
        loc_lResultado = .F.

        TRY
            IF VARTYPE(par_cFiltro) != "C"
                par_cFiltro = ""
            ENDIF

            loc_cSQL = "SELECT cIdChaves, Cods FROM SigCdEma"

            IF !EMPTY(par_cFiltro)
                loc_cSQL = loc_cSQL + ;
                           " WHERE Cods LIKE " + EscaparSQL(par_cFiltro + "%")
            ENDIF

            loc_cSQL = loc_cSQL + " ORDER BY Cods"

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")

            IF loc_nResultado >= 0
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao buscar emails:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarPorCodigo - Carrega um registro pelo email (Cods)
    *--------------------------------------------------------------------------
    PROCEDURE CarregarPorCodigo(par_cCodigo)
        LOCAL loc_lResultado, loc_cSQL, loc_nResultado
        loc_lResultado = .F.

        TRY
            loc_cSQL = "SELECT cIdChaves, Cods FROM SigCdEma" + ;
                       " WHERE Cods = " + EscaparSQL(PADR(ALLTRIM(par_cCodigo), 50))

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")

            IF loc_nResultado >= 0
                IF RECCOUNT("cursor_4c_Carrega") > 0
                    loc_lResultado = THIS.CarregarDoCursor("cursor_4c_Carrega")
                    THIS.this_lNovoRegistro = .F.
                ENDIF
                IF USED("cursor_4c_Carrega")
                    USE IN cursor_4c_Carrega
                ENDIF
            ELSE
                MsgErro("Erro ao carregar email:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir - INSERT na tabela SigCdEma
    * Logica do legado: valida email nao vazio, verifica duplicidade, gera PK
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Inserir()
        LOCAL loc_lResultado, loc_cSQL, loc_nResultado, loc_cSQLDup, loc_nDup
        loc_lResultado = .F.

        *-- Validacoes fora do TRY (RETURN permitido aqui)
        IF EMPTY(ALLTRIM(THIS.this_cCods))
            MsgAviso("Email Inv" + CHR(225) + "lido!!!", "Aten" + CHR(231) + CHR(227) + "o")
            RETURN .F.
        ENDIF

        TRY
            *-- Verificar duplicidade de email (logica identica ao legado)
            loc_cSQLDup = "SELECT Cods FROM SigCdEma" + ;
                          " WHERE Cods = " + EscaparSQL(PADR(ALLTRIM(THIS.this_cCods), 50))
            loc_nDup = SQLEXEC(gnConnHandle, loc_cSQLDup, "cursor_4c_Dup")

            IF loc_nDup >= 0 AND RECCOUNT("cursor_4c_Dup") > 0
                IF USED("cursor_4c_Dup")
                    USE IN cursor_4c_Dup
                ENDIF
                MsgAviso("Email J" + CHR(225) + " Cadastrado!!!", "Aten" + CHR(231) + CHR(227) + "o")
            ELSE
                IF USED("cursor_4c_Dup")
                    USE IN cursor_4c_Dup
                ENDIF

                THIS.this_cIdChaves = ALLTRIM(fUniqueIds())
                loc_cSQL = "INSERT INTO SigCdEma (cIdChaves, Cods)" + ;
                           " VALUES (" + EscaparSQL(THIS.this_cIdChaves) + ;
                           ", " + EscaparSQL(ALLTRIM(THIS.this_cCods)) + ")"

                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

                IF loc_nResultado >= 0
                    THIS.RegistrarAuditoria("INSERT")
                    loc_lResultado = .T.
                ELSE
                    MsgErro("Erro ao inserir email:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - UPDATE na tabela SigCdEma
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Atualizar()
        LOCAL loc_lResultado, loc_cSQL, loc_nResultado
        loc_lResultado = .F.

        *-- Validacoes fora do TRY (RETURN permitido aqui)
        IF EMPTY(ALLTRIM(THIS.this_cCods))
            MsgAviso("Email Inv" + CHR(225) + "lido!!!", "Aten" + CHR(231) + CHR(227) + "o")
            RETURN .F.
        ENDIF

        TRY
            loc_cSQL = "UPDATE SigCdEma" + ;
                       " SET Cods = " + EscaparSQL(ALLTRIM(THIS.this_cCods)) + ;
                       " WHERE Cods = " + EscaparSQL(PADR(ALLTRIM(THIS.this_cCodsOriginal), 50))

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("UPDATE")
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao atualizar email:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * ExecutarExclusao - DELETE na tabela SigCdEma
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ExecutarExclusao()
        LOCAL loc_lResultado, loc_cSQL, loc_nResultado
        loc_lResultado = .F.

        TRY
            loc_cSQL = "DELETE FROM SigCdEma" + ;
                       " WHERE Cods = " + EscaparSQL(PADR(ALLTRIM(THIS.this_cCods), 50))

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("DELETE")
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao excluir email:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

ENDDEFINE


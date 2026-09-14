# CORRIGIR ERRO DE RUNTIME VFP9

## TAREFA OBRIGATORIA
O formulario VFP9 apresentou erro de runtime durante teste automatizado.
Voce DEVE corrigir o erro e salvar os arquivos corrigidos usando Write tool.

## ERRO DETECTADO
- Etapa: 06b_testeAutomatico
- Tentativa: 1/10
- Mensagem: Testes automaticos: 78% < 100%. Falhas: Teste 'CarregarLista': Nenhum cursor padrao foi criado (cursor_4c_Dados/Lista/Busca/etc); Teste 'ModoVisualizar': Property AJUSTARBOTOESPORMODO is not found. | Detalhes: Linha: 542

## CONTEXTO DO ERRO

### ERROS CAPTURADOS EM MODO TESTE (vfp_error_details.txt):
[28/04/2026 11:57:34 AM] Erro: Erro ao buscar acessos: |  | Erro: Connection handle is invalid. | Linha: 66
[28/04/2026 11:57:34 AM] Erro: Erro ao buscar acessos: |  | Erro: Connection handle is invalid. | Linha: 66
[28/04/2026 11:57:34 AM] Erro: Erro ao buscar acessos: |  | Erro: Connection handle is invalid. | Linha: 66


### LOG DA ETAPA (06b_testeAutomatico):
[2026-04-28 11:57:32] [INFO] === VFP EXECUTOR v2.0 ===
[2026-04-28 11:57:32] [INFO] Config FPW: (nao fornecido)
[2026-04-28 11:57:32] [INFO] Script PRG: C:\4c\projeto\app\utils\TesteAutomatico.prg
[2026-04-28 11:57:32] [INFO] Timeout: 300 segundos
[2026-04-28 11:57:32] [INFO] Wrapper PRG criado para parametros: C:\Users\rafae\AppData\Local\Temp\vfp_wrapper_qgmra3bn.prg
[2026-04-28 11:57:32] [INFO] Conteudo do wrapper:
[2026-04-28 11:57:32] [INFO] * Auto-generated wrapper for parameters
* Script: C:\4c\projeto\app\utils\TesteAutomatico.prg
* Parameters: 'FormSigAcCcr', 'C:\4c\tasks\task021', 'CRUD'

* Anti-dialog protections for unattended execution
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
SET NOTIFY OFF
SYS(2335, 0)

DO "C:\4c\projeto\app\utils\TesteAutomatico" WITH 'FormSigAcCcr', 'C:\4c\tasks\task021', 'CRUD'
QUIT

[2026-04-28 11:57:32] [INFO] Comando VFP: C:\Users\rafae\AppData\Local\Temp\vfp_wrapper_qgmra3bn.prg
[2026-04-28 11:57:32] [INFO] VFP output esperado em: C:\4c\tasks\task021\vfp_output.txt
[2026-04-28 11:57:32] [INFO] Executando Visual FoxPro 9...
[2026-04-28 11:57:32] [INFO] Comando completo: VFP9.EXE -T C:\Users\rafae\AppData\Local\Temp\vfp_wrapper_qgmra3bn.prg
[2026-04-28 11:57:32] [INFO] Executando: VFP9.EXE -T C:\Users\rafae\AppData\Local\Temp\vfp_wrapper_qgmra3bn.prg
[2026-04-28 11:57:32] [INFO] Timeout configurado: 300 segundos
[2026-04-28 11:57:34] [INFO] VFP9 finalizou normalmente com exit code: 
[2026-04-28 11:57:34] [INFO] VFP9 finalizado em 1.9351777 segundos
[2026-04-28 11:57:34] [INFO] Exit Code: 
[2026-04-28 11:57:34] [INFO] 
[2026-04-28 11:57:34] [INFO] Arquivos temporarios preservados para inspecao:
[2026-04-28 11:57:34] [INFO]   Wrapper.prg: C:\Users\rafae\AppData\Local\Temp\vfp_wrapper_qgmra3bn.prg
[2026-04-28 11:57:34] [INFO] 
[2026-04-28 11:57:34] [INFO] === Conteudo do Wrapper.prg temporario ===
[2026-04-28 11:57:34] [INFO] * Auto-generated wrapper for parameters
[2026-04-28 11:57:34] [INFO] * Script: C:\4c\projeto\app\utils\TesteAutomatico.prg
[2026-04-28 11:57:34] [INFO] * Parameters: 'FormSigAcCcr', 'C:\4c\tasks\task021', 'CRUD'
[2026-04-28 11:57:34] [INFO] 
[2026-04-28 11:57:34] [INFO] * Anti-dialog protections for unattended execution
[2026-04-28 11:57:34] [INFO] SET SAFETY OFF
[2026-04-28 11:57:34] [INFO] SET RESOURCE OFF
[2026-04-28 11:57:34] [INFO] SET TALK OFF
[2026-04-28 11:57:34] [INFO] SET NOTIFY OFF
[2026-04-28 11:57:34] [INFO] SYS(2335, 0)
[2026-04-28 11:57:34] [INFO] 
[2026-04-28 11:57:34] [INFO] DO "C:\4c\projeto\app\utils\TesteAutomatico" WITH 'FormSigAcCcr', 'C:\4c\tasks\task021', 'CRUD'
[2026-04-28 11:57:34] [INFO] QUIT
[2026-04-28 11:57:34] [INFO] 
[2026-04-28 11:57:34] [INFO] === Fim do Wrapper.prg ===
[2026-04-28 11:57:34] [WARN] AVISO: VFP9 retornou exit code  (normal para VFP9 GUI - validar pelo arquivo de saida)


### RESULTADO DOS TESTES (teste_resultado.json):
{
  "formClass": "FormSigAcCcr",
  "timestamp": "20260428115734",
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
      "detalhes": "AbrirLookup: 6 (ABRIRLOOKUPCDCONTA, ABRIRLOOKUPDCONTA, ABRIRLOOKUPDGRCONTA, ABRIRLOOKUPGRCONTA, ABRIRLOOKUPGRUPOACESSO, ABRIRLOOKUPUSUARIO) | KeyPress handlers: 7 (KEYPRESS, TXT_4C_CDCONTA_KEYPRESS, TXT_4C_DCONTA_KEYPRESS, TXT_4C_DGRCONTA_KEYPRESS, TXT_4C_GRCONTA_KEYPRESS, TXT_4C_GRUPO_KEYPRESS, TXT_4C_USUARIO_KEYPRESS)"
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

### FORM (C:\4c\projeto\app\forms\cadastros\FormSigAcCcr.prg):
*==============================================================================
* FormSigAcCcr.prg - Formulario de Acesso a Conta Corrente
* Tabela: SigSyAcc | PK: cIdChaves
* Legado: SIGACCCR.SCX (frmcadastro)
*==============================================================================

DEFINE CLASS FormSigAcCcr AS FormBase

    *-- Propriedades visuais (PILAR 1 - UX FIDELITY)
    Height       = 600
    Width        = 1000
    Caption      = "Acesso a Conta Corrente"
    AutoCenter   = .T.
    ShowWindow   = 1
    WindowType   = 1
    ControlBox   = .F.
    Closable     = .F.
    MaxButton    = .F.
    TitleBar     = 0
    ClipControls = .F.
    Themes       = .F.
    BorderStyle  = 2
    FontName     = "Tahoma"
    ForeColor    = RGB(90, 90, 90)

    *-- Propriedades do formulario
    this_oBusinessObject = .NULL.
    this_cMensagemErro   = ""

    *--------------------------------------------------------------------------
    * Init
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        RETURN DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    * InicializarForm - Configuracao inicial do formulario
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            THIS.this_oBusinessObject = CREATEOBJECT("SigAcCcrBO")

            IF ISNULL(THIS.this_oBusinessObject)
                MostrarErro("Erro ao criar Business Object SigAcCcrBO", "Erro Cr" + CHR(237) + "tico")
            ELSE
                THIS.ConfigurarPageFrame()
                THIS.ConfigurarPaginaLista()
                THIS.ConfigurarPaginaDados()
                THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption

                IF NOT (TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI)
                    IF !THIS.CarregarLista()
                        *-- Falha nao impede abertura
                    ENDIF
                ENDIF

                THIS.pgf_4c_Paginas.Visible = .T.
                THIS.pgf_4c_Paginas.ActivePage = 1
                THIS.this_cModoAtual = "LISTA"
                loc_lSucesso = .T.
            ENDIF

        CATCH TO loException
            THIS.this_cMensagemErro = "Linha: " + TRANSFORM(loException.LineNo) + " - " + loException.Message
            MostrarErro("Erro ao inicializar FormSigAcCcr:" + CHR(13) + THIS.this_cMensagemErro, "Erro")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPageFrame - Configura PageFrame principal
    * PageFrame.Top=-29 para ocultar abas (compensacao +29 nos controles)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPageFrame()
        THIS.AddObject("pgf_4c_Paginas", "PageFrame")

        WITH THIS.pgf_4c_Paginas
            .Top       = -29
            .Left      = 0
            .Width     = 1003
            .Height    = 629
            .PageCount = 2
            .Tabs      = .F.
            .Visible   = .T.
        ENDWITH

        THIS.pgf_4c_Paginas.Page1.Caption   = "Lista"
        THIS.pgf_4c_Paginas.Page1.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
        THIS.pgf_4c_Paginas.Page1.BackColor = RGB(255, 255, 255)

        THIS.pgf_4c_Paginas.Page2.Caption   = "Dados"
        THIS.pgf_4c_Paginas.Page2.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
        THIS.pgf_4c_Paginas.Page2.BackColor = RGB(255, 255, 255)
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPaginaLista - Configura Page1 (Lista com grid e botoes CRUD)
    * Compensacao +29: todos os controles top += 29
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPaginaLista()
        LOCAL loc_oPagina
        loc_oPagina = THIS.pgf_4c_Paginas.Page1

        *-- Fundo padrao do framework frmcadastro (sem isso a pagina fica branca)
        loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"

        *-- Container de cabecalho (Top=2+29=31)
        loc_oPagina.AddObject("cnt_4c_Cabecalho", "Container")
        WITH loc_oPagina.cnt_4c_Cabecalho
            .Top         = 31
            .Left        = 0
            .Width       = 1003
            .Height      = 80
            .BackStyle   = 0
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH

        loc_oPagina.cnt_4c_Cabecalho.AddObject("lbl_4c_Titulo", "Label")
        WITH loc_oPagina.cnt_4c_Cabecalho.lbl_4c_Titulo
            .Caption   = "Acesso a Conta Corrente"
            .Top       = 20
            .Left      = 20
            .Width     = 400
            .Height    = 30
            .FontName  = "Tahoma"
            .FontSize  = 14
            .FontBold  = .T.
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        *-- Container de botoes CRUD (Top=0+29=29, Left=544)
        loc_oPagina.AddObject("cnt_4c_Botoes", "Container")
        WITH loc_oPagina.cnt_4c_Botoes
            .Top         = 29
            .Left        =  542
            .Width       = 390
            .Height      = 85
            .BackStyle   = 0
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH

        *-- Botao Incluir
        loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Incluir", "CommandButton")
        WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Incluir
            .Caption         = "Incluir"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_inserir_26.jpg"
            .PicturePosition = 13
            .Width           = 75
            .Height          = 75
            .Left            = 5
            .Top             = 5
            .FontName        = "Tahoma"
            .FontSize        = 8
            .Themes          = .F.
            .SpecialEffect   = 0
            .BackColor       = RGB(255, 255, 255)
            .ForeColor       = RGB(90, 90, 90)
            .Visible         = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Incluir, "Click", THIS, "BtnIncluirClick")

        *-- Botao Visualizar
        loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Visualizar", "CommandButton")
        WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar
            .Caption         = "Visualizar"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_vizualizar_60.jpg"
            .PicturePosition = 13
            .Width           = 75
            .Height          = 75
            .Left            = 80
            .Top             = 5
            .FontName        = "Tahoma"
            .FontSize        = 8
            .Themes          = .F.
            .SpecialEffect   = 0
            .BackColor       = RGB(255, 255, 255)
            .ForeColor       = RGB(90, 90, 90)
            .Visible         = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar, "Click", THIS, "BtnVisualizarClick")

        *-- Botao Alterar
        loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Alterar", "CommandButton")
        WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar
            .Caption         = "Alterar"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_alterar_60.jpg"
            .PicturePosition = 13
            .Width           = 75
            .Height          = 75
            .Left            = 155
            .Top             = 5
            .FontName        = "Tahoma"
            .FontSize        = 8
            .Themes          = .F.
            .SpecialEffect   = 0
            .BackColor       = RGB(255, 255, 255)
            .ForeColor       = RGB(90, 90, 90)
            .Visible         = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar, "Click", THIS, "BtnAlterarClick")

        *-- Botao Excluir
        loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Excluir", "CommandButton")
        WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir
            .Caption         = "Excluir"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_excluir_60.jpg"
            .PicturePosition = 13
            .Width           = 75
            .Height          = 75
            .Left            = 230
            .Top             = 5
            .FontName        = "Tahoma"
            .FontSize        = 8
            .Themes          = .F.
            .SpecialEffect   = 0
            .BackColor       = RGB(255, 255, 255)
            .ForeColor       = RGB(90, 90, 90)
            .Visible         = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir, "Click", THIS, "BtnExcluirClick")

        *-- Botao Buscar
        loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Buscar", "CommandButton")
        WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Buscar
            .Caption         = "Buscar"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_procurar_60.jpg"
            .PicturePosition = 13
            .Width           = 75
            .Height          = 75
            .Left            = 305
            .Top             = 5
            .FontName        = "Tahoma"
            .FontSize        = 8
            .Themes          = .F.
            .SpecialEffect   = 0
            .BackColor       = RGB(255, 255, 255)
            .ForeColor       = RGB(90, 90, 90)
            .Visible         = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Buscar, "Click", THIS, "BtnBuscarClick")

        *-- Container Encerrar (canonico: Left=917, Width=90)
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

        loc_oPagina.cnt_4c_Saida.AddObject("cmd_4c_Encerrar", "CommandButton")
        WITH loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar
            .Caption         = "Encerrar"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
            .PicturePosition = 13
            .Width           = 75
            .Height          = 75
            .Left            = 5
            .Top             = 5
            .FontName        = "Tahoma"
            .FontSize        = 8
            .Themes          = .F.
            .SpecialEffect   = 0
            .BackColor       = RGB(255, 255, 255)
            .ForeColor       = RGB(90, 90, 90)
            .Visible         = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar, "Click", THIS, "BtnEncerrarClick")

        *-- Grid de lista (Top=88+29=117, Left=12, Width=890)
        loc_oPagina.AddObject("grd_4c_Lista", "Grid")
        WITH loc_oPagina.grd_4c_Lista
            .Top                  = 117
            .Left                 = 12
            .Width                = 890
            .Height               = 454
            .FontName             = "Verdana"
            .FontSize             = 8
            .ForeColor            = RGB(90, 90, 90)
            .BackColor            = RGB(255, 255, 255)
            .GridLineColor        = RGB(238, 238, 238)
            .GridLines            = 3
            .HighlightBackColor   = RGB(255, 255, 255)
            .HighlightForeColor   = RGB(15, 41, 104)
            .HighlightStyle       = 2
            .DeleteMark           = .F.
            .RecordMark           = .F.
            .RowHeight            = 16
            .ScrollBars           = 2
            .ColumnCount          = 4
            .Visible              = .T.
        ENDWITH

        loc_oPagina.grd_4c_Lista.Column1.Header1.Caption = "Grupo Acesso"
        loc_oPagina.grd_4c_Lista.Column1.Width = 120
        loc_oPagina.grd_4c_Lista.Column2.Header1.Caption = "Usu" + CHR(225) + "rio Acesso"
        loc_oPagina.grd_4c_Lista.Column2.Width = 150
        loc_oPagina.grd_4c_Lista.Column3.Header1.Caption = "Grupo Conta"
        loc_oPagina.grd_4c_Lista.Column3.Width = 120
        loc_oPagina.grd_4c_Lista.Column4.Header1.Caption = "Conta Corrente"
        loc_oPagina.grd_4c_Lista.Column4.Width = 200

        THIS.TornarControlesVisiveis(loc_oPagina)
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPaginaDados - Configura Page2 (campos de edicao)
    * Campos: Grupo/Nome (Usuario) + GrConta/DGrConta/CdConta/DCONTA (Conta Corrente)
    * Posicoes do layout.json + compensacao +29
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPaginaDados()
        LOCAL loc_oPagina
        loc_oPagina = THIS.pgf_4c_Paginas.Page2

        *-- Fundo padrao do framework frmcadastro (sem isso a pagina fica branca)
        loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"

        *-- Container de botoes Salvar/Cancelar (Top=4+29=33, Left=842)
        loc_oPagina.AddObject("cnt_4c_BotoesAcao", "Container")
        WITH loc_oPagina.cnt_4c_BotoesAcao
            .Top         = 33
            .Left        = 842
            .Width       = 160
            .Height      = 85
            .BackStyle   = 0
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH

        loc_oPagina.cnt_4c_BotoesAcao.AddObject("cmd_4c_Confirmar", "CommandButton")
        WITH loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Confirmar
            .Caption         = "Confirmar"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
            .PicturePosition = 13
            .Width           = 75
            .Height          = 75
            .Left            = 5
            .Top             = 5
            .FontName        = "Tahoma"
            .FontSize        = 8
            .Themes          = .F.
            .SpecialEffect   = 0
            .BackColor       = RGB(255, 255, 255)
            .ForeColor       = RGB(90, 90, 90)
            .Visible         = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Confirmar, "Click", THIS, "BtnSalvarClick")

        loc_oPagina.cnt_4c_BotoesAcao.AddObject("cmd_4c_Cancelar", "CommandButton")
        WITH loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Cancelar
            .Caption         = "Encerrar"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_cancelar_60.jpg"
            .PicturePosition = 13
            .Width           = 75
            .Height          = 75
            .Left            = 80
            .Top             = 5
            .FontName        = "Tahoma"
            .FontSize        = 8
            .Themes          = .F.
            .SpecialEffect   = 0
            .BackColor       = RGB(255, 255, 255)
            .ForeColor       = RGB(90, 90, 90)
            .Visible         = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Cancelar, "Click", THIS, "BtnCancelarClick")

        *-- ======================== SECAO USUARIO ========================
        *-- Say2: "Usu?rio" (Top=107+29=136, Left=207) - label de secao
        loc_oPagina.AddObject("lbl_4c_SecUsuario", "Label")
        WITH loc_oPagina.lbl_4c_SecUsuario
            .Caption   = "Usu" + CHR(225) + "rio"
            .Top       = 136
            .Left      = 207
            .Width     = 88
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .T.
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        *-- Say1: "Grupo :" (Top=124+29=153, Left=160)
        loc_oPagina.AddObject("lbl_4c_LblGrupo", "Label")
        WITH loc_oPagina.lbl_4c_LblGrupo
            .Caption   = "Grupo :"
            .Top       = 153
            .Left      = 160
            .Width     = 45
            .Height    = 17
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Alignment = 1
            .Visible   = .T.
        ENDWITH

        *-- Get_Grupo (Top=121+29=150, Left=207, Width=80)
        loc_oPagina.AddObject("txt_4c_Grupo", "TextBox")
        WITH loc_oPagina.txt_4c_Grupo
            .Top         = 150
            .Left        = 207
            .Width       = 80
            .Height      = 23
            .Value       = ""
            .FontName    = "Tahoma"
            .FontSize    = 8
            .ForeColor   = RGB(90, 90, 90)
            .BackColor   = RGB(255, 255, 255)
            .BorderStyle = 1
            .Visible     = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.txt_4c_Grupo, "KeyPress", THIS, "ValidarGrupoUsuario")
        BINDEVENT(loc_oPagina.txt_4c_Grupo, "KeyPress",  THIS, "txt_4c_Grupo_KeyPress")

        *-- Say3: "Nome :" (Top=149+29=178, Left=162)
        loc_oPagina.AddObject("lbl_4c_LblNome", "Label")
        WITH loc_oPagina.lbl_4c_LblNome
            .Caption   = "Nome :"
            .Top       = 178
            .Left      = 162
            .Width     = 45
            .Height    = 17
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Alignment = 1
            .Visible   = .T.
        ENDWITH

        *-- Get_Usuario (Top=145+29=174, Left=207, Width=80)
        loc_oPagina.AddObject("txt_4c_Usuario", "TextBox")
        WITH loc_oPagina.txt_4c_Usuario
            .Top         = 174
            .Left        = 207
            .Width       = 80
            .Height      = 23
            .Value       = ""
            .FontName    = "Tahoma"
            .FontSize    = 8
            .ForeColor   = RGB(90, 90, 90)
            .BackColor   = RGB(255, 255, 255)
            .BorderStyle = 1
            .Visible     = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.txt_4c_Usuario, "KeyPress", THIS, "ValidarUsuario")
        BINDEVENT(loc_oPagina.txt_4c_Usuario, "KeyPress",  THIS, "txt_4c_Usuario_KeyPress")

        *-- ======================== SECAO CONTA CORRENTE ========================
        *-- Say6: "Conta Corrente" (Top=195+29=224, Left=207) - label de secao
        loc_oPagina.AddObject("lbl_4c_SecConta", "Label")
        WITH loc_oPagina.lbl_4c_SecConta
            .Caption   = "Conta Corrente"
            .Top       = 224
            .Left      = 207
            .Width     = 88
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .T.
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        *-- Say4: "Grupo :" (Top=214+29=243, Left=160)
        loc_oPagina.AddObject("lbl_4c_LblGrConta", "Label")
        WITH loc_oPagina.lbl_4c_LblGrConta
            .Caption   = "Grupo :"
            .Top       = 243
            .Left      = 160
            .Width     = 45
            .Height    = 17
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Alignment = 1
            .Visible   = .T.
        ENDWITH

        *-- Get_GrConta (Top=212+29=241, Left=206, Width=79)
        loc_oPagina.AddObject("txt_4c_GrConta", "TextBox")
        WITH loc_oPagina.txt_4c_GrConta
            .Top         = 241
            .Left        = 206
            .Width       = 79
            .Height      = 23
            .Value       = ""
            .FontName    = "Tahoma"
            .FontSize    = 8
            .ForeColor   = RGB(90, 90, 90)
            .BackColor   = RGB(255, 255, 255)
            .BorderStyle = 1
            .Visible     = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.txt_4c_GrConta, "KeyPress", THIS, "ValidarGrConta")
        BINDEVENT(loc_oPagina.txt_4c_GrConta, "KeyPress",  THIS, "txt_4c_GrConta_KeyPress")

        *-- Get_DGrConta (Top=212+29=241, Left=287, Width=150) - campo descricao grupo
        loc_oPagina.AddObject("txt_4c_DGrConta", "TextBox")
        WITH loc_oPagina.txt_4c_DGrConta
            .Top         = 241
            .Left        = 287
            .Width       = 150
            .Height      = 23
            .Value       = ""
            .FontName    = "Tahoma"
            .FontSize    = 8
            .ForeColor   = RGB(90, 90, 90)
            .BackColor   = RGB(240, 240, 240)
            .BorderStyle = 1
            .Enabled     = .F.
            .Visible     = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.txt_4c_DGrConta, "KeyPress", THIS, "ValidarDGrConta")
        BINDEVENT(loc_oPagina.txt_4c_DGrConta, "KeyPress",  THIS, "txt_4c_DGrConta_KeyPress")

        *-- Say5: "Conta :" (Top=238+29=267, Left=160)
        loc_oPagina.AddObject("lbl_4c_LblCdConta", "Label")
        WITH loc_oPagina.lbl_4c_LblCdConta
            .Caption   = "Conta :"
            .Top       = 267
            .Left      = 160
            .Width     = 45
            .Height    = 17
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Alignment = 1
            .Visible   = .T.
        ENDWITH

        *-- Get_CdConta (Top=236+29=265, Left=206, Width=79)
        loc_oPagina.AddObject("txt_4c_CdConta", "TextBox")
        WITH loc_oPagina.txt_4c_CdConta
            .Top         = 265
            .Left        = 206
            .Width       = 79
            .Height      = 23
            .Value       = ""
            .FontName    = "Tahoma"
            .FontSize    = 8
            .ForeColor   = RGB(90, 90, 90)
            .BackColor   = RGB(255, 255, 255)
            .BorderStyle = 1
            .Visible     = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.txt_4c_CdConta, "KeyPress", THIS, "ValidarCdConta")
        BINDEVENT(loc_oPagina.txt_4c_CdConta, "KeyPress",  THIS, "txt_4c_CdConta_KeyPress")

        *-- Get_DCONTA (Top=236+29=265, Left=287, Width=360) - campo descricao conta
        loc_oPagina.AddObject("txt_4c_DCONTA", "TextBox")
        WITH loc_oPagina.txt_4c_DCONTA
            .Top         = 265
            .Left        = 287
            .Width       = 360
            .Height      = 23
            .Value       = ""
            .FontName    = "Tahoma"
            .FontSize    = 8
            .ForeColor   = RGB(90, 90, 90)
            .BackColor   = RGB(240, 240, 240)
            .BorderStyle = 1
            .Enabled     = .F.
            .Visible     = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.txt_4c_DCONTA, "KeyPress", THIS, "ValidarDConta")
        BINDEVENT(loc_oPagina.txt_4c_DCONTA, "KeyPress",  THIS, "txt_4c_DCONTA_KeyPress")

        THIS.TornarControlesVisiveis(loc_oPagina)
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarLista - Carrega registros no grid da Page1
    *--------------------------------------------------------------------------
    PROCEDURE CarregarLista()
        LOCAL loc_lResultado, loc_oGrid
        loc_lResultado = .F.

        TRY
            loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Lista

            IF !THIS.this_oBusinessObject.Buscar("")
                loc_lResultado = .F.
            ELSE
                loc_oGrid.ColumnCount = 4
                loc_oGrid.RecordSource = "cursor_4c_Dados"
                loc_oGrid.ColumnCount  = 4
                loc_oGrid.Column1.ControlSource = "cursor_4c_Dados.gracess"
                loc_oGrid.Column2.ControlSource = "cursor_4c_Dados.usuacess"
                loc_oGrid.Column3.ControlSource = "cursor_4c_Dados.grcontas"
                loc_oGrid.Column4.ControlSource = "cursor_4c_Dados.cdcontas"
                loc_oGrid.Column1.Width = 120
                loc_oGrid.Column2.Width = 150
                loc_oGrid.Column3.Width = 120
                loc_oGrid.Column4.Width = 200
                loc_oGrid.Column1.Header1.Caption = "Grupo Acesso"
                loc_oGrid.Column2.Header1.Caption = "Usu" + CHR(225) + "rio Acesso"
                loc_oGrid.Column3.Header1.Caption = "Grupo Conta"
                loc_oGrid.Column4.Header1.Caption = "Conta Corrente"
                THIS.FormatarGridLista(loc_oGrid)
                loc_lResultado = .T.
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao carregar lista:" + CHR(13) + CHR(13) + ;
                        "Erro: " + loException.Message + CHR(13) + ;
                        "Linha: " + TRANSFORM(loException.LineNo), "Erro")
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * AlternarPagina - Alterna entre Page1 (Lista) e Page2 (Dados)
    *--------------------------------------------------------------------------
    PROCEDURE AlternarPagina(par_nPagina)
        LOCAL loc_lResultado
        loc_lResultado = .F.

        IF VARTYPE(par_nPagina) != "N" OR par_nPagina < 1 OR par_nPagina > 2
            RETURN .F.
        ENDIF

        TRY
            THIS.pgf_4c_Paginas.ActivePage = par_nPagina

            IF par_nPagina = 1
                THIS.CarregarLista()
            ENDIF

            loc_lResultado = .T.

        CATCH TO loException
            MostrarErro("Erro ao alternar p" + CHR(225) + "gina:" + CHR(13) + ;
                        loException.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * FormParaBO - Transfere valores do formulario para o Business Object
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE FormParaBO()
        LOCAL loc_oPagina
        loc_oPagina = THIS.pgf_4c_Paginas.Page2

        THIS.this_oBusinessObject.this_cGrAcess  = ALLTRIM(loc_oPagina.txt_4c_Grupo.Value)
        THIS.this_oBusinessObject.this_cUsuAcess = ALLTRIM(loc_oPagina.txt_4c_Usuario.Value)
        THIS.this_oBusinessObject.this_cGrContas = ALLTRIM(loc_oPagina.txt_4c_GrConta.Value)
        THIS.this_oBusinessObject.this_cCdContas = ALLTRIM(loc_oPagina.txt_4c_CdConta.Value)
        THIS.this_oBusinessObject.this_cDGrConta = ALLTRIM(loc_oPagina.txt_4c_DGrConta.Value)
        THIS.this_oBusinessObject.this_cDConta   = ALLTRIM(loc_oPagina.txt_4c_DCONTA.Value)
    ENDPROC

    *--------------------------------------------------------------------------
    * BOParaForm - Transfere valores do Business Object para o formulario
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE BOParaForm()
        LOCAL loc_oPagina
        loc_oPagina = THIS.pgf_4c_Paginas.Page2

        loc_oPagina.txt_4c_Grupo.Value    = THIS.this_oBusinessObject.this_cGrAcess
        loc_oPagina.txt_4c_Usuario.Value  = THIS.this_oBusinessObject.this_cUsuAcess
        loc_oPagina.txt_4c_GrConta.Value  = THIS.this_oBusinessObject.this_cGrContas
        loc_oPagina.txt_4c_DGrConta.Value = THIS.this_oBusinessObject.this_cDGrConta
        loc_oPagina.txt_4c_CdConta.Value  = THIS.this_oBusinessObject.this_cCdContas
        loc_oPagina.txt_4c_DCONTA.Value   = THIS.this_oBusinessObject.this_cDConta
    ENDPROC

    *--------------------------------------------------------------------------
    * LimparCampos - Limpa todos os campos da Page2
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE LimparCampos()
        LOCAL loc_oPagina
        loc_oPagina = THIS.pgf_4c_Paginas.Page2

        loc_oPagina.txt_4c_Grupo.Value    = ""
        loc_oPagina.txt_4c_Usuario.Value  = ""
        loc_oPagina.txt_4c_GrConta.Value  = ""
        loc_oPagina.txt_4c_DGrConta.Value = ""
        loc_oPagina.txt_4c_CdConta.Value  = ""
        loc_oPagina.txt_4c_DCONTA.Value   = ""
    ENDPROC

    *--------------------------------------------------------------------------
    * HabilitarCampos - Habilita ou desabilita campos editaveis
    * Get_Grupo habilitado apenas se Get_Usuario vazio (e vice-versa)
    * Get_GrConta e Get_CdConta habilitados sempre em INCLUIR/ALTERAR
    * Get_DGrConta habilitado apenas se Get_GrConta vazio
    * Get_DCONTA habilitado apenas se Get_CdConta vazio
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE HabilitarCampos(par_lHabilitar)
        LOCAL loc_oPagina, loc_cUsuario, loc_cGrupo
        loc_oPagina = THIS.pgf_4c_Paginas.Page2

        IF par_lHabilitar
            loc_cGrupo   = ALLTRIM(loc_oPagina.txt_4c_Grupo.Value)
            loc_cUsuario = ALLTRIM(loc_oPagina.txt_4c_Usuario.Value)

            *-- Grupo habilitado apenas se Usuario vazio
            loc_oPagina.txt_4c_Grupo.Enabled    = EMPTY(loc_cUsuario)
            *-- Usuario habilitado apenas se Grupo vazio
            loc_oPagina.txt_4c_Usuario.Enabled  = EMPTY(loc_cGrupo)
            *-- GrConta e CdConta sempre habilitados em edicao
            loc_oPagina.txt_4c_GrConta.Enabled  = .T.
            loc_oPagina.txt_4c_CdConta.Enabled  = .T.
            *-- DGrConta habilitado se GrConta vazio
            loc_oPagina.txt_4c_DGrConta.Enabled = EMPTY(loc_oPagina.txt_4c_GrConta.Value)
            *-- DCONTA habilitado se CdConta vazio
            loc_oPagina.txt_4c_DCONTA.Enabled   = EMPTY(loc_oPagina.txt_4c_CdConta.Value)
        ELSE
            loc_oPagina.txt_4c_Grupo.Enabled    = .F.
            loc_oPagina.txt_4c_Usuario.Enabled  = .F.
            loc_oPagina.txt_4c_GrConta.Enabled  = .F.
            loc_oPagina.txt_4c_DGrConta.Enabled = .F.
            loc_oPagina.txt_4c_CdConta.Enabled  = .F.
            loc_oPagina.txt_4c_DCONTA.Enabled   = .F.
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * AjustarBotoesPorModo - Ajusta estado dos botoes conforme modo atual
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE AjustarBotoesPorModo()
        LOCAL loc_oPg1, loc_oPg2, loc_lVisualizando
        loc_oPg1 = THIS.pgf_4c_Paginas.Page1
        loc_oPg2 = THIS.pgf_4c_Paginas.Page2
        loc_lVisualizando = (THIS.this_cModoAtual = "VISUALIZAR")

        loc_oPg1.cnt_4c_Botoes.cmd_4c_Incluir.Enabled   = .T.
        loc_oPg1.cnt_4c_Botoes.cmd_4c_Visualizar.Enabled = .T.
        loc_oPg1.cnt_4c_Botoes.cmd_4c_Alterar.Enabled   = .T.
        loc_oPg1.cnt_4c_Botoes.cmd_4c_Excluir.Enabled   = .T.
        loc_oPg1.cnt_4c_Botoes.cmd_4c_Buscar.Enabled    = .T.

        loc_oPg2.cnt_4c_BotoesAcao.cmd_4c_Confirmar.Enabled = !loc_lVisualizando
        loc_oPg2.cnt_4c_BotoesAcao.cmd_4c_Cancelar.Enabled  = .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnIncluirClick - Inclui novo registro
    *--------------------------------------------------------------------------
    PROCEDURE BtnIncluirClick()
        THIS.this_oBusinessObject.NovoRegistro()
        THIS.LimparCampos()
        THIS.this_cModoAtual = "INCLUIR"
        THIS.HabilitarCampos(.T.)
        THIS.AjustarBotoesPorModo()
        THIS.pgf_4c_Paginas.ActivePage = 2
        THIS.pgf_4c_Paginas.Page2.txt_4c_Grupo.SetFocus()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnVisualizarClick - Visualiza registro selecionado (somente leitura)
    *--------------------------------------------------------------------------
    PROCEDURE BtnVisualizarClick()
        LOCAL loc_cChave
        loc_cChave = ""

        IF USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados")
            SELECT cursor_4c_Dados
            loc_cChave = ALLTRIM(cIdChaves)
        ENDIF

        IF EMPTY(loc_cChave)
            MsgAviso("Selecione um registro na lista.", "")
            RETURN
        ENDIF

        IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cChave)
            THIS.this_oBusinessObject.CarregarDescricoesConta()
            THIS.this_cModoAtual = "VISUALIZAR"
            THIS.BOParaForm()
            THIS.HabilitarCampos(.F.)
            THIS.AjustarBotoesPorModo()
            THIS.pgf_4c_Paginas.ActivePage = 2
        ELSE
            MsgAviso("N" + CHR(227) + "o foi poss" + CHR(237) + "vel carregar o registro.", "")
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnAlterarClick - Altera registro selecionado
    *--------------------------------------------------------------------------
    PROCEDURE BtnAlterarClick()
        LOCAL loc_cChave
        loc_cChave = ""

        IF USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados")
            SELECT cursor_4c_Dados
            loc_cChave = ALLTRIM(cIdChaves)
        ENDIF

        IF EMPTY(loc_cChave)
            MsgAviso("Selecione um registro na lista.", "")
            RETURN
        ENDIF

        IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cChave)
            THIS.this_oBusinessObject.CarregarDescricoesConta()
            THIS.this_oBusinessObject.EditarRegistro()
            THIS.this_cModoAtual = "ALTERAR"
            THIS.BOParaForm()
            THIS.HabilitarCampos(.T.)
            THIS.AjustarBotoesPorModo()
            THIS.pgf_4c_Paginas.ActivePage = 2
            THIS.pgf_4c_Paginas.Page2.txt_4c_GrConta.SetFocus()
        ELSE
            MsgAviso("N" + CHR(227) + "o foi poss" + CHR(237) + "vel carregar o registro.", "")
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnExcluirClick - Exclui registro selecionado
    *--------------------------------------------------------------------------
    PROCEDURE BtnExcluirClick()
        LOCAL loc_cChave
        loc_cChave = ""

        IF USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados")
            SELECT cursor_4c_Dados
            loc_cChave = ALLTRIM(cIdChaves)
        ENDIF

        IF EMPTY(loc_cChave)
            MsgAviso("Selecione um registro na lista.", "")
            RETURN
        ENDIF

        IF !MsgConfirma("Confirma a exclus" + CHR(227) + "o deste registro?", ;
                        "Confirmar Exclus" + CHR(227) + "o")
            RETURN
        ENDIF

        IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cChave)
            IF THIS.this_oBusinessObject.Excluir()
                MsgInfo("Registro exclu" + CHR(237) + "do com sucesso!")
                THIS.CarregarLista()
            ENDIF
        ELSE
            MsgAviso("N" + CHR(227) + "o foi poss" + CHR(237) + "vel carregar o registro.", "")
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnBuscarClick - Busca registros por filtro
    *--------------------------------------------------------------------------
    PROCEDURE BtnBuscarClick()
        LOCAL loc_cFiltro, loc_cValor
        loc_cFiltro = ""

        IF TYPE("gb_4c_ModoTeste") = "L" AND gb_4c_ModoTeste
            RETURN
        ENDIF

        loc_cValor = INPUTBOX("Informe o grupo de acesso ou usu" + CHR(225) + "rio:", ;
                              "Buscar Acesso", "")

        IF !EMPTY(loc_cValor)
            loc_cFiltro = "gracess LIKE '%" + STRTRAN(loc_cValor, "'", "''") + "%'" + ;
                          " OR usuacess LIKE '%" + STRTRAN(loc_cValor, "'", "''") + "%'"
        ENDIF

        IF THIS.this_oBusinessObject.Buscar(loc_cFiltro)
            LOCAL loc_oGrid
            loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Lista
            loc_oGrid.ColumnCount = 4
            loc_oGrid.RecordSource = "cursor_4c_Dados"
            loc_oGrid.ColumnCount  = 4
            loc_oGrid.Column1.ControlSource = "cursor_4c_Dados.gracess"
            loc_oGrid.Column2.ControlSource = "cursor_4c_Dados.usuacess"
            loc_oGrid.Column3.ControlSource = "cursor_4c_Dados.grcontas"
            loc_oGrid.Column4.ControlSource = "cursor_4c_Dados.cdcontas"
            loc_oGrid.Column1.Width = 120
            loc_oGrid.Column2.Width = 150
            loc_oGrid.Column3.Width = 120
            loc_oGrid.Column4.Width = 200
            loc_oGrid.Column1.Header1.Caption = "Grupo Acesso"
            loc_oGrid.Column2.Header1.Caption = "Usu" + CHR(225) + "rio Acesso"
            loc_oGrid.Column3.Header1.Caption = "Grupo Conta"
            loc_oGrid.Column4.Header1.Caption = "Conta Corrente"
            THIS.FormatarGridLista(loc_oGrid)
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnEncerrarClick - Fecha o formulario
    *--------------------------------------------------------------------------
    PROCEDURE BtnEncerrarClick()
        THIS.Release()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnSalvarClick - Salva o registro (Inserir ou Atualizar)
    *--------------------------------------------------------------------------
    PROCEDURE BtnSalvarClick()
        LOCAL loc_oPagina, loc_cGrAcess, loc_cUsuAcess, loc_cGrContas, loc_cCdContas
        loc_oPagina = THIS.pgf_4c_Paginas.Page2

        loc_cGrAcess  = ALLTRIM(loc_oPagina.txt_4c_Grupo.Value)
        loc_cUsuAcess = ALLTRIM(loc_oPagina.txt_4c_Usuario.Value)
        loc_cGrContas = ALLTRIM(loc_oPagina.txt_4c_GrConta.Value)
        loc_cCdContas = ALLTRIM(loc_oPagina.txt_4c_CdConta.Value)

        *-- Validacoes do legado: usuario/grupo obrigatorio em INSERIR
        IF INLIST(THIS.this_cModoAtual, "INCLUIR")
            IF EMPTY(loc_cGrAcess) AND EMPTY(loc_cUsuAcess)
                MsgAviso("Usu" + CHR(225) + "rio/Grupo Inv" + CHR(225) + "lido !!!")
                loc_oPagina.txt_4c_Grupo.SetFocus()
                RETURN
            ENDIF
        ENDIF

        IF EMPTY(loc_cGrContas) AND EMPTY(loc_cCdContas)
            MsgAviso("Grupo/Conta Corrente Inv" + CHR(225) + "lidos !!")
            loc_oPagina.txt_4c_GrConta.SetFocus()
            RETURN
        ENDIF

        THIS.FormParaBO()

        IF THIS.this_oBusinessObject.Salvar()
            MsgInfo("Registro salvo com sucesso!")
            THIS.AlternarPagina(1)
            THIS.this_cModoAtual = "LISTA"
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnCancelarClick - Cancela edicao e volta para lista
    *--------------------------------------------------------------------------
    PROCEDURE BtnCancelarClick()
        THIS.AlternarPagina(1)
        THIS.this_cModoAtual = "LISTA"
        THIS.CarregarLista()
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarGrupoUsuario - LostFocus de txt_4c_Grupo
    * Logica do legado: fwBuscaExt em SigCdGrA por campo "Grupos"
    *--------------------------------------------------------------------------
    PROCEDURE ValidarGrupoUsuario(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_cGrupo, loc_oBusca
        loc_cGrupo = ALLTRIM(THIS.pgf_4c_Paginas.Page2.txt_4c_Grupo.Value)

        IF EMPTY(loc_cGrupo)
            THIS.pgf_4c_Paginas.Page2.txt_4c_Usuario.Enabled = .T.
            RETURN
        ENDIF

        THIS.pgf_4c_Paginas.Page2.txt_4c_Usuario.Enabled = .F.

        TRY
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigCdGrA", "cursor_4c_BuscaGrpA", "Grupos", loc_cGrupo, ;
                "Sele" + CHR(231) + CHR(227) + "o")

            IF VARTYPE(loc_oBusca) = "O"
                IF !loc_oBusca.this_lAchouRegistro
                    loc_oBusca.mAddColuna("Grupos", "", "C" + CHR(243) + "digo")
                    loc_oBusca.Show()
                ENDIF

                IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaGrpA")
                    SELECT cursor_4c_BuscaGrpA
                    THIS.pgf_4c_Paginas.Page2.txt_4c_Grupo.Value = ALLTRIM(Grupos)
                ELSE
                    IF !loc_oBusca.this_lSelecionou
                    THIS.pgf_4c_Paginas.Page2.txt_4c_Grupo.Value = ""
                    THIS.pgf_4c_Paginas.Page2.txt_4c_Usuario.Enabled = .T.
                    ENDIF
                ENDIF

                loc_oBusca.Release()
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao validar grupo:" + CHR(13) + loException.Message, "Erro")
        ENDTRY

        IF USED("cursor_4c_BuscaGrpA")
            USE IN cursor_4c_BuscaGrpA
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarUsuario - LostFocus de txt_4c_Usuario
    * Logica do legado: fwBuscaExt em SigCdUsu por campo "Usuarios"
    *--------------------------------------------------------------------------
    PROCEDURE ValidarUsuario(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_cUsuario, loc_oBusca
        loc_cUsuario = ALLTRIM(THIS.pgf_4c_Paginas.Page2.txt_4c_Usuario.Value)

        IF EMPTY(loc_cUsuario)
            THIS.pgf_4c_Paginas.Page2.txt_4c_Grupo.Enabled = .T.
            RETURN
        ENDIF

        THIS.pgf_4c_Paginas.Page2.txt_4c_Grupo.Enabled = .F.

        TRY
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigCdUsu", "cursor_4c_BuscaUsu", "Usuarios", loc_cUsuario, ;
                "Sele" + CHR(231) + CHR(227) + "o")

            IF VARTYPE(loc_oBusca) = "O"
                IF !loc_oBusca.this_lAchouRegistro
                    loc_oBusca.mAddColuna("Usuarios", "", "C" + CHR(243) + "digo")
                    loc_oBusca.mAddColuna("CCargs",   "", "Cargo")
                    loc_oBusca.Show()
                ENDIF

                IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaUsu")
                    SELECT cursor_4c_BuscaUsu
                    THIS.pgf_4c_Paginas.Page2.txt_4c_Usuario.Value = ALLTRIM(Usuarios)
                ELSE
                    IF !loc_oBusca.this_lSelecionou
                    THIS.pgf_4c_Paginas.Page2.txt_4c_Usuario.Value = ""
                    THIS.pgf_4c_Paginas.Page2.txt_4c_Grupo.Enabled = .T.
                    ENDIF
                ENDIF

                loc_oBusca.Release()
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao validar usu" + CHR(225) + "rio:" + CHR(13) + loException.Message, "Erro")
        ENDTRY

        IF USED("cursor_4c_BuscaUsu")
            USE IN cursor_4c_BuscaUsu
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarGrConta - LostFocus de txt_4c_GrConta
    * Logica do legado: fwBuscaExt em SigCdGcr por campo "Codigos"
    * Apos selecao: preenche txt_4c_DGrConta (Descrs), carrega lista de contas
    *--------------------------------------------------------------------------
    PROCEDURE ValidarGrConta(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_cGrConta, loc_oBusca
        loc_cGrConta = ALLTRIM(THIS.pgf_4c_Paginas.Page2.txt_4c_GrConta.Value)

        IF EMPTY(loc_cGrConta)
            THIS.pgf_4c_Paginas.Page2.txt_4c_DGrConta.Value  = ""
            THIS.pgf_4c_Paginas.Page2.txt_4c_DGrConta.Enabled = .T.
            THIS.pgf_4c_Paginas.Page2.txt_4c_CdConta.Value   = ""
            THIS.pgf_4c_Paginas.Page2.txt_4c_DCONTA.Value    = ""
            RETURN
        ENDIF

        THIS.pgf_4c_Paginas.Page2.txt_4c_DGrConta.Enabled = .F.

        TRY
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigCdGcr", "cursor_4c_BuscaGcr", "Codigos", loc_cGrConta, ;
                "Sele" + CHR(231) + CHR(227) + "o")

            IF VARTYPE(loc_oBusca) = "O"
                IF !loc_oBusca.this_lAchouRegistro
                    loc_oBusca.mAddColuna("CODIGOS", "", "C" + CHR(243) + "digo")
                    loc_oBusca.mAddColuna("DESCRS",  "", "Descri" + CHR(231) + CHR(227) + "o")
                    loc_oBusca.Show()
                ENDIF

                IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaGcr")
                    SELECT cursor_4c_BuscaGcr
                    THIS.pgf_4c_Paginas.Page2.txt_4c_GrConta.Value  = ALLTRIM(Codigos)
                    THIS.pgf_4c_Paginas.Page2.txt_4c_DGrConta.Value = ALLTRIM(Descrs)
                    *-- Limpa conta ao mudar grupo
                    THIS.pgf_4c_Paginas.Page2.txt_4c_CdConta.Value  = ""
                    THIS.pgf_4c_Paginas.Page2.txt_4c_DCONTA.Value   = ""
                ELSE
                    IF !loc_oBusca.this_lSelecionou
                    THIS.pgf_4c_Paginas.Page2.txt_4c_GrConta.Value  = ""
                    THIS.pgf_4c_Paginas.Page2.txt_4c_DGrConta.Value = ""
                    THIS.pgf_4c_Paginas.Page2.txt_4c_DGrConta.Enabled = .T.
                    ENDIF
                ENDIF

                loc_oBusca.Release()
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao validar grupo de conta:" + CHR(13) + loException.Message, "Erro")
        ENDTRY

        IF USED("cursor_4c_BuscaGcr")
            USE IN cursor_4c_BuscaGcr
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarDGrConta - LostFocus de txt_4c_DGrConta
    * Campo descricao do grupo: fwBuscaExt em SigCdGcr por campo "Descrs"
    * Apos selecao: preenche txt_4c_GrConta (Codigos)
    *--------------------------------------------------------------------------
    PROCEDURE ValidarDGrConta(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_cDescGr, loc_oBusca
        loc_cDescGr = ALLTRIM(THIS.pgf_4c_Paginas.Page2.txt_4c_DGrConta.Value)

        IF EMPTY(loc_cDescGr)
            RETURN
        ENDIF

        IF !EMPTY(ALLTRIM(THIS.pgf_4c_Paginas.Page2.txt_4c_GrConta.Value))
            RETURN
        ENDIF

        TRY
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigCdGcr", "cursor_4c_BuscaGcrD", "Descrs", loc_cDescGr, ;
                "Sele" + CHR(231) + CHR(227) + "o")

            IF VARTYPE(loc_oBusca) = "O"
                IF !loc_oBusca.this_lAchouRegistro
                    loc_oBusca.mAddColuna("DESCRS",  "", "Descri" + CHR(231) + CHR(227) + "o")
                    loc_oBusca.mAddColuna("CODIGOS", "", "C" + CHR(243) + "digo")
                    loc_oBusca.Show()
                ENDIF

                IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaGcrD")
                    SELECT cursor_4c_BuscaGcrD
                    THIS.pgf_4c_Paginas.Page2.txt_4c_DGrConta.Value = ALLTRIM(Descrs)
                    THIS.pgf_4c_Paginas.Page2.txt_4c_GrConta.Value  = ALLTRIM(Codigos)
                    THIS.pgf_4c_Paginas.Page2.txt_4c_DGrConta.Enabled = .F.
                    *-- Limpa conta ao mudar grupo
                    THIS.pgf_4c_Paginas.Page2.txt_4c_CdConta.Value = ""
                    THIS.pgf_4c_Paginas.Page2.txt_4c_DCONTA.Value  = ""
                ELSE
                    IF !loc_oBusca.this_lSelecionou
                    THIS.pgf_4c_Paginas.Page2.txt_4c_DGrConta.Value = ""
                    ENDIF
                ENDIF

                loc_oBusca.Release()
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao validar descri" + CHR(231) + CHR(227) + "o de grupo:" + ;
                        CHR(13) + loException.Message, "Erro")
        ENDTRY

        IF USED("cursor_4c_BuscaGcrD")
            USE IN cursor_4c_BuscaGcrD
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarCdConta - LostFocus de txt_4c_CdConta
    * Logica do legado: fAcessoContas('C', grupo, codigo)
    * Equivalente: verifica se conta existe no grupo em SigCdCli
    * Preenche txt_4c_DCONTA (RClis)
    *--------------------------------------------------------------------------
    PROCEDURE ValidarCdConta(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_cGrConta, loc_cCdConta, loc_cSQL, loc_nRes, loc_oBusca
        loc_cGrConta = ALLTRIM(THIS.pgf_4c_Paginas.Page2.txt_4c_GrConta.Value)
        loc_cCdConta = ALLTRIM(THIS.pgf_4c_Paginas.Page2.txt_4c_CdConta.Value)

        IF EMPTY(loc_cCdConta)
            THIS.pgf_4c_Paginas.Page2.txt_4c_DCONTA.Value  = ""
            THIS.pgf_4c_Paginas.Page2.txt_4c_DCONTA.Enabled = .T.
            RETURN
        ENDIF

        THIS.pgf_4c_Paginas.Page2.txt_4c_DCONTA.Enabled = .F.

        TRY
            IF !EMPTY(loc_cGrConta)
                loc_cSQL = "SELECT TOP 1 IClis, RClis FROM SigCdCli" + ;
                           " WHERE Grupos = " + EscaparSQL(loc_cGrConta) + ;
                           " AND   IClis  = " + EscaparSQL(loc_cCdConta)
            ELSE
                loc_cSQL = "SELECT TOP 1 IClis, RClis FROM SigCdCli" + ;
                           " WHERE IClis = " + EscaparSQL(loc_cCdConta)
            ENDIF

            loc_nRes = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_VerConta")

            IF loc_nRes >= 0 AND RECCOUNT("cursor_4c_VerConta") > 0
                SELECT cursor_4c_VerConta
                THIS.pgf_4c_Paginas.Page2.txt_4c_CdConta.Value = ALLTRIM(IClis)
                THIS.pgf_4c_Paginas.Page2.txt_4c_DCONTA.Value  = ALLTRIM(RClis)
            ELSE
                MsgAviso("Acesso Negado...")
                THIS.pgf_4c_Paginas.Page2.txt_4c_CdConta.Value = ""
                THIS.pgf_4c_Paginas.Page2.txt_4c_DCONTA.Value  = ""
                THIS.pgf_4c_Paginas.Page2.txt_4c_DCONTA.Enabled = .T.
            ENDIF

            IF USED("cursor_4c_VerConta")
                USE IN cursor_4c_VerConta
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao validar conta:" + CHR(13) + loException.Message, "Erro")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarDConta - LostFocus de txt_4c_DCONTA
    * Campo descricao conta: busca por nome quando codigo nao informado
    * Preenche txt_4c_CdConta
    *--------------------------------------------------------------------------
    PROCEDURE ValidarDConta(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_cGrConta, loc_cDConta, loc_cSQL, loc_nRes
        loc_cGrConta = ALLTRIM(THIS.pgf_4c_Paginas.Page2.txt_4c_GrConta.Value)
        loc_cDConta  = ALLTRIM(THIS.pgf_4c_Paginas.Page2.txt_4c_DCONTA.Value)

        IF EMPTY(loc_cDConta)
            RETURN
        ENDIF

        IF !EMPTY(ALLTRIM(THIS.pgf_4c_Paginas.Page2.txt_4c_CdConta.Value))
            RETURN
        ENDIF

        TRY
            IF !EMPTY(loc_cGrConta)
                loc_cSQL = "SELECT TOP 1 IClis, RClis FROM SigCdCli" + ;
                           " WHERE Grupos = " + EscaparSQL(loc_cGrConta) + ;
                           " AND   RClis LIKE '%" + STRTRAN(loc_cDConta, "'", "''") + "%'"
            ELSE
                loc_cSQL = "SELECT TOP 1 IClis, RClis FROM SigCdCli" + ;
                           " WHERE RClis LIKE '%" + STRTRAN(loc_cDConta, "'", "''") + "%'"
            ENDIF

            loc_nRes = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_VerDConta")

            IF loc_nRes >= 0 AND RECCOUNT("cursor_4c_VerDConta") > 0
                SELECT cursor_4c_VerDConta
                THIS.pgf_4c_Paginas.Page2.txt_4c_CdConta.Value = ALLTRIM(IClis)
                THIS.pgf_4c_Paginas.Page2.txt_4c_DCONTA.Value  = ALLTRIM(RClis)
                THIS.pgf_4c_Paginas.Page2.txt_4c_DCONTA.Enabled = .F.
            ELSE
                MsgAviso("Acesso Negado...")
                THIS.pgf_4c_Paginas.Page2.txt_4c_DCONTA.Value   = ""
                THIS.pgf_4c_Paginas.Page2.txt_4c_CdConta.Value  = ""
            ENDIF

            IF USED("cursor_4c_VerDConta")
                USE IN cursor_4c_VerDConta
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao validar nome de conta:" + CHR(13) + loException.Message, "Erro")
        ENDTRY
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
    * TornarControlesVisiveis - Torna controles visiveis recursivamente
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

    *==========================================================================
    *-- KEYPRESS HANDLERS (F4 = keycode 115 em VFP9)
    *==========================================================================

    PROCEDURE txt_4c_Grupo_KeyPress
        LPARAMETERS par_nKeyCode, par_nShiftAltCtrl
        IF par_nKeyCode = 115  && F4
            THIS.AbrirLookupGrupoAcesso()
        ENDIF
    ENDPROC

    PROCEDURE txt_4c_Usuario_KeyPress
        LPARAMETERS par_nKeyCode, par_nShiftAltCtrl
        IF par_nKeyCode = 115  && F4
            THIS.AbrirLookupUsuario()
        ENDIF
    ENDPROC

    PROCEDURE txt_4c_GrConta_KeyPress
        LPARAMETERS par_nKeyCode, par_nShiftAltCtrl
        IF par_nKeyCode = 115  && F4
            THIS.AbrirLookupGrConta()
        ENDIF
    ENDPROC

    PROCEDURE txt_4c_DGrConta_KeyPress
        LPARAMETERS par_nKeyCode, par_nShiftAltCtrl
        IF par_nKeyCode = 115  && F4
            THIS.AbrirLookupDGrConta()
        ENDIF
    ENDPROC

    PROCEDURE txt_4c_CdConta_KeyPress
        LPARAMETERS par_nKeyCode, par_nShiftAltCtrl
        IF par_nKeyCode = 115  && F4
            THIS.AbrirLookupCdConta()
        ENDIF
    ENDPROC

    PROCEDURE txt_4c_DCONTA_KeyPress
        LPARAMETERS par_nKeyCode, par_nShiftAltCtrl
        IF par_nKeyCode = 115  && F4
            THIS.AbrirLookupDConta()
        ENDIF
    ENDPROC

    *==========================================================================
    *-- Handlers F4: abrem picker para selecao via FormBuscaAuxiliar
    *==========================================================================

    *--------------------------------------------------------------------------
    * AbrirLookupGrupoAcesso - Picker em SigCdGrA (campo Grupos)
    * Legado: Get_Grupo.Valid -> fwBuscaExt em SigCdGrA, campo 'Grupos'
    *--------------------------------------------------------------------------
    PROCEDURE AbrirLookupGrupoAcesso()
        LOCAL loc_oPagina, loc_oBusca
        loc_oPagina = THIS.pgf_4c_Paginas.Page2

        IF !loc_oPagina.txt_4c_Grupo.Enabled
            RETURN
        ENDIF

        TRY
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigCdGrA", "cursor_4c_BuscaGrpA", "Grupos", ;
                ALLTRIM(loc_oPagina.txt_4c_Grupo.Value), ;
                "Sele" + CHR(231) + CHR(227) + "o")

            IF VARTYPE(loc_oBusca) = "O"
                loc_oBusca.mAddColuna("Grupos", "", "C" + CHR(243) + "digo")
                loc_oBusca.Show()

                IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaGrpA")
                    SELECT cursor_4c_BuscaGrpA
                    loc_oPagina.txt_4c_Grupo.Value    = ALLTRIM(Grupos)
                    loc_oPagina.txt_4c_Usuario.Enabled = .F.
                ENDIF

                loc_oBusca.Release()
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao abrir lookup de grupo:" + CHR(13) + loException.Message, "Erro")
        ENDTRY

        IF USED("cursor_4c_BuscaGrpA")
            USE IN cursor_4c_BuscaGrpA
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * AbrirLookupUsuario - Picker em SigCdUsu (campo Usuarios)
    * Legado: Get_Usuario.Valid -> fwBuscaExt em SigCdUsu, campo 'Usuarios'
    *--------------------------------------------------------------------------
    PROCEDURE AbrirLookupUsuario()
        LOCAL loc_oPagina, loc_oBusca
        loc_oPagina = THIS.pgf_4c_Paginas.Page2

        IF !loc_oPagina.txt_4c_Usuario.Enabled
            RETURN
        ENDIF

        TRY
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigCdUsu", "cursor_4c_BuscaUsu", "Usuarios", ;
                ALLTRIM(loc_oPagina.txt_4c_Usuario.Value), ;
                "Sele" + CHR(231) + CHR(227) + "o")

            IF VARTYPE(loc_oBusca) = "O"
                loc_oBusca.mAddColuna("Usuarios", "", "C" + CHR(243) + "digo")
                loc_oBusca.mAddColuna("CCargs",   "", "Cargo")
                loc_oBusca.Show()

                IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaUsu")
                    SELECT cursor_4c_BuscaUsu
                    loc_oPagina.txt_4c_Usuario.Value  = ALLTRIM(Usuarios)
                    loc_oPagina.txt_4c_Grupo.Enabled  = .F.
                ENDIF

                loc_oBusca.Release()
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao abrir lookup de usu" + CHR(225) + "rio:" + CHR(13) + ;
                        loException.Message, "Erro")
        ENDTRY

        IF USED("cursor_4c_BuscaUsu")
            USE IN cursor_4c_BuscaUsu
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * AbrirLookupGrConta - Picker em SigCdGcr por codigo (campo CODIGOS)
    * Legado: Get_GrConta.Valid -> fwBuscaExt em SigCdGcr, campo 'Codigos'
    * Apos selecao: preenche DGrConta e limpa CdConta/DCONTA
    *--------------------------------------------------------------------------
    PROCEDURE AbrirLookupGrConta()
        LOCAL loc_oPagina, loc_oBusca
        loc_oPagina = THIS.pgf_4c_Paginas.Page2

        IF !loc_oPagina.txt_4c_GrConta.Enabled
            RETURN
        ENDIF

        TRY
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigCdGcr", "cursor_4c_BuscaGcr", "Codigos", ;
                ALLTRIM(loc_oPagina.txt_4c_GrConta.Value), ;
                "Sele" + CHR(231) + CHR(227) + "o")

            IF VARTYPE(loc_oBusca) = "O"
                loc_oBusca.mAddColuna("CODIGOS", "", "C" + CHR(243) + "digo")
                loc_oBusca.mAddColuna("DESCRS",  "", "Descri" + CHR(231) + CHR(227) + "o")
                loc_oBusca.Show()

                IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaGcr")
                    SELECT cursor_4c_BuscaGcr
                    loc_oPagina.txt_4c_GrConta.Value    = ALLTRIM(Codigos)
                    loc_oPagina.txt_4c_DGrConta.Value   = ALLTRIM(Descrs)
                    loc_oPagina.txt_4c_DGrConta.Enabled = .F.
                    loc_oPagina.txt_4c_CdConta.Value    = ""
                    loc_oPagina.txt_4c_DCONTA.Value     = ""
                ENDIF

                loc_oBusca.Release()
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao abrir lookup de grupo de conta:" + CHR(13) + ;
                        loException.Message, "Erro")
        ENDTRY

        IF USED("cursor_4c_BuscaGcr")
            USE IN cursor_4c_BuscaGcr
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * AbrirLookupDGrConta - Picker em SigCdGcr por descricao (campo DESCRS)
    * Legado: Get_DGrConta.Valid -> fwBuscaExt em SigCdGcr, campo 'Descrs'
    * Habilitado apenas quando txt_4c_GrConta esta vazio
    *--------------------------------------------------------------------------
    PROCEDURE AbrirLookupDGrConta()
        LOCAL loc_oPagina, loc_oBusca
        loc_oPagina = THIS.pgf_4c_Paginas.Page2

        IF !loc_oPagina.txt_4c_DGrConta.Enabled
            RETURN
        ENDIF

        TRY
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigCdGcr", "cursor_4c_BuscaGcrD", "Descrs", ;
                ALLTRIM(loc_oPagina.txt_4c_DGrConta.Value), ;
                "Sele" + CHR(231) + CHR(227) + "o")

            IF VARTYPE(loc_oBusca) = "O"
                loc_oBusca.mAddColuna("DESCRS",  "", "Descri" + CHR(231) + CHR(227) + "o")
                loc_oBusca.mAddColuna("CODIGOS", "", "C" + CHR(243) + "digo")
                loc_oBusca.Show()

                IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaGcrD")
                    SELECT cursor_4c_BuscaGcrD
                    loc_oPagina.txt_4c_DGrConta.Value   = ALLTRIM(Descrs)
                    loc_oPagina.txt_4c_GrConta.Value    = ALLTRIM(Codigos)
                    loc_oPagina.txt_4c_DGrConta.Enabled = .F.
                    loc_oPagina.txt_4c_CdConta.Value    = ""
                    loc_oPagina.txt_4c_DCONTA.Value     = ""
                ENDIF

                loc_oBusca.Release()
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao abrir lookup de descri" + CHR(231) + CHR(227) + ;
                        "o de grupo:" + CHR(13) + loException.Message, "Erro")
        ENDTRY

        IF USED("cursor_4c_BuscaGcrD")
            USE IN cursor_4c_BuscaGcrD
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * AbrirLookupCdConta - Picker em SigCdCli (campos IClis+RClis)
    * Filtrado pelo grupo de conta corrente selecionado
    * Legado: Get_CdConta.Valid -> fAcessoContas('C', grupo, codigo)
    *--------------------------------------------------------------------------
    PROCEDURE AbrirLookupCdConta()
        LOCAL loc_oPagina, loc_oBusca, loc_cGrConta, loc_cFiltro
        loc_oPagina  = THIS.pgf_4c_Paginas.Page2
        loc_cGrConta = ALLTRIM(loc_oPagina.txt_4c_GrConta.Value)

        IF !loc_oPagina.txt_4c_CdConta.Enabled
            RETURN
        ENDIF

        loc_cFiltro = IIF(!EMPTY(loc_cGrConta), "Grupos = " + EscaparSQL(loc_cGrConta), "")

        TRY
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigCdCli", "cursor_4c_BuscaCli", "IClis", ;
                ALLTRIM(loc_oPagina.txt_4c_CdConta.Value), ;
                "Selecionar Conta", .F., .T., loc_cFiltro)

            IF VARTYPE(loc_oBusca) = "O"
                loc_oBusca.mAddColuna("IClis", "", "Conta")
                loc_oBusca.mAddColuna("RClis", "", "Nome")
                loc_oBusca.Show()

                IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaCli")
                    SELECT cursor_4c_BuscaCli
                    loc_oPagina.txt_4c_CdConta.Value  = ALLTRIM(IClis)
                    loc_oPagina.txt_4c_DCONTA.Value   = ALLTRIM(RClis)
                    loc_oPagina.txt_4c_DCONTA.Enabled = .F.
                ENDIF

                loc_oBusca.Release()
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao abrir lookup de conta:" + CHR(13) + loException.Message, "Erro")
        ENDTRY

        IF USED("cursor_4c_BuscaCli")
            USE IN cursor_4c_BuscaCli
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * AbrirLookupDConta - Picker em SigCdCli por nome (campos RClis+IClis)
    * Habilitado apenas quando txt_4c_CdConta esta vazio
    * Legado: Get_DCONTA.Valid -> fAcessoContas('D', grupo, descricao)
    *--------------------------------------------------------------------------
    PROCEDURE AbrirLookupDConta()
        LOCAL loc_oPagina, loc_oBusca, loc_cGrConta, loc_cFiltro
        loc_oPagina  = THIS.pgf_4c_Paginas.Page2
        loc_cGrConta = ALLTRIM(loc_oPagina.txt_4c_GrConta.Value)

        IF !loc_oPagina.txt_4c_DCONTA.Enabled
            RETURN
        ENDIF

        loc_cFiltro = IIF(!EMPTY(loc_cGrConta), "Grupos = " + EscaparSQL(loc_cGrConta), "")

        TRY
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigCdCli", "cursor_4c_BuscaCliN", "RClis", ;
                ALLTRIM(loc_oPagina.txt_4c_DCONTA.Value), ;
                "Selecionar Conta", .F., .T., loc_cFiltro)

            IF VARTYPE(loc_oBusca) = "O"
                loc_oBusca.mAddColuna("RClis", "", "Nome")
                loc_oBusca.mAddColuna("IClis", "", "Conta")
                loc_oBusca.Show()

                IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaCliN")
                    SELECT cursor_4c_BuscaCliN
                    loc_oPagina.txt_4c_DCONTA.Value   = ALLTRIM(RClis)
                    loc_oPagina.txt_4c_CdConta.Value  = ALLTRIM(IClis)
                    loc_oPagina.txt_4c_DCONTA.Enabled = .F.
                ENDIF

                loc_oBusca.Release()
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao abrir lookup de nome de conta:" + CHR(13) + ;
                        loException.Message, "Erro")
        ENDTRY

        IF USED("cursor_4c_BuscaCliN")
            USE IN cursor_4c_BuscaCliN
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * Destroy - Libera recursos ao fechar o formulario
    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
        IF USED("cursor_4c_Dados")
            USE IN cursor_4c_Dados
        ENDIF
        IF USED("cursor_4c_BuscaGrpA")
            USE IN cursor_4c_BuscaGrpA
        ENDIF
        IF USED("cursor_4c_BuscaUsu")
            USE IN cursor_4c_BuscaUsu
        ENDIF
        IF USED("cursor_4c_BuscaGcr")
            USE IN cursor_4c_BuscaGcr
        ENDIF
        IF USED("cursor_4c_BuscaGcrD")
            USE IN cursor_4c_BuscaGcrD
        ENDIF
        IF USED("cursor_4c_BuscaCli")
            USE IN cursor_4c_BuscaCli
        ENDIF
        IF USED("cursor_4c_BuscaCliN")
            USE IN cursor_4c_BuscaCliN
        ENDIF
        IF !ISNULL(THIS.this_oBusinessObject)
            THIS.this_oBusinessObject = .NULL.
        ENDIF
        DODEFAULT()
    ENDPROC

ENDDEFINE


### BO (C:\4c\projeto\app\classes\SigAcCcrBO.prg):
*==============================================================================
* SigAcCcrBO.prg - Business Object para Acesso a Conta Corrente
* Tabela: SigSyAcc
* PK: cIdChaves (Character, gerada por fUniqueIds)
*==============================================================================

DEFINE CLASS SigAcCcrBO AS BusinessBase

    *-- Campos da tabela SigSyAcc
    this_cIdChave  = ""    && cIdChaves - Chave primaria (gerada por fUniqueIds)
    this_cGrAcess  = ""    && gracess   - Grupo de acesso
    this_cUsuAcess = ""    && usuacess  - Usuario de acesso
    this_cGrContas = ""    && grcontas  - Grupo da conta corrente
    this_cCdContas = ""    && cdcontas  - Codigo da conta corrente

    *-- Campos virtuais (lookup display, nao persistidos no banco)
    this_cDGrConta = ""    && Descricao do grupo de conta (SigCdGcr.Descrs)
    this_cDConta   = ""    && Nome da conta corrente (SigCdCli.RClis)

    *--------------------------------------------------------------------------
    * Init - Inicializa o Business Object
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        DODEFAULT()
        THIS.this_cTabela     = "SigSyAcc"
        THIS.this_cCampoChave = "cIdChaves"
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Carrega dados do cursor para propriedades
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE CarregarDoCursor(par_cAliasCursor)
        IF USED(par_cAliasCursor)
            SELECT (par_cAliasCursor)
            THIS.this_cIdChave  = TratarNulo(cIdChaves, "C")
            THIS.this_cGrAcess  = TratarNulo(gracess,   "C")
            THIS.this_cUsuAcess = TratarNulo(usuacess,  "C")
            THIS.this_cGrContas = TratarNulo(grcontas,  "C")
            THIS.this_cCdContas = TratarNulo(cdcontas,  "C")
            RETURN .T.
        ENDIF
        RETURN .F.
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Retorna chave primaria para auditoria
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ObterChavePrimaria()
        RETURN THIS.this_cIdChave
    ENDPROC

    *--------------------------------------------------------------------------
    * Buscar - Seleciona registros com filtro opcional
    *--------------------------------------------------------------------------
    PROCEDURE Buscar(par_cFiltro)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "SELECT cIdChaves, gracess, usuacess, grcontas, cdcontas" + ;
                       " FROM SigSyAcc" + ;
                       IIF(!EMPTY(par_cFiltro), " WHERE " + par_cFiltro, "") + ;
                       " ORDER BY gracess, usuacess, grcontas, cdcontas"

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")

            IF loc_nResultado >= 0
                loc_lSucesso = .T.
            ELSE
                MostrarErro("Erro ao buscar acessos:" + CHR(13) + CHR(13) + ;
                            "SQL: " + loc_cSQL + CHR(13) + CHR(13) + ;
                            CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao buscar acessos:" + CHR(13) + CHR(13) + ;
                        "Erro: " + loException.Message + CHR(13) + ;
                        "Linha: " + TRANSFORM(loException.LineNo), "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarPorCodigo - Carrega registro pela chave primaria
    *--------------------------------------------------------------------------
    PROCEDURE CarregarPorCodigo(par_cCodigo)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "SELECT cIdChaves, gracess, usuacess, grcontas, cdcontas" + ;
                       " FROM SigSyAcc" + ;
                       " WHERE cIdChaves = " + EscaparSQL(par_cCodigo)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")

            IF loc_nResultado < 0
                MostrarErro("Erro ao carregar acesso:" + CHR(13) + CHR(13) + ;
                            "SQL: " + loc_cSQL + CHR(13) + CHR(13) + ;
                            CapturarErroSQL(), "Erro SQL")
            ELSE
                IF RECCOUNT("cursor_4c_Carrega") > 0
                    loc_lSucesso = THIS.CarregarDoCursor("cursor_4c_Carrega")
                    THIS.this_lNovoRegistro = .F.
                ENDIF
            ENDIF

            IF USED("cursor_4c_Carrega")
                USE IN cursor_4c_Carrega
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao carregar acesso:" + CHR(13) + CHR(13) + ;
                        "Erro: " + loException.Message + CHR(13) + ;
                        "Linha: " + TRANSFORM(loException.LineNo), "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarDados - Validacoes de negocio
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ValidarDados()
        IF EMPTY(THIS.this_cGrAcess) AND EMPTY(THIS.this_cUsuAcess)
            MsgAviso("Usu" + CHR(225) + "rio/Grupo Inv" + CHR(225) + "lido !!!")
            RETURN .F.
        ENDIF

        IF EMPTY(THIS.this_cGrContas) AND EMPTY(THIS.this_cCdContas)
            MsgAviso("Grupo/Conta Corrente Inv" + CHR(225) + "lidos !!")
            RETURN .F.
        ENDIF

        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarDuplicata - Verifica se ja existe registro identico (INSERT)
    *--------------------------------------------------------------------------
    PROCEDURE ValidarDuplicata()
        LOCAL loc_cSQL, loc_nResultado, loc_lDuplicado
        loc_lDuplicado = .F.

        TRY
            loc_cSQL = "SELECT TOP 1 cIdChaves FROM SigSyAcc" + ;
                       " WHERE gracess  = " + EscaparSQL(THIS.this_cGrAcess)  + ;
                       " AND   usuacess = " + EscaparSQL(THIS.this_cUsuAcess) + ;
                       " AND   grcontas = " + EscaparSQL(THIS.this_cGrContas) + ;
                       " AND   cdcontas = " + EscaparSQL(THIS.this_cCdContas)

            IF !EMPTY(THIS.this_cIdChave)
                loc_cSQL = loc_cSQL + " AND cIdChaves <> " + EscaparSQL(THIS.this_cIdChave)
            ENDIF

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Duplic")

            IF loc_nResultado >= 0 AND RECCOUNT("cursor_4c_Duplic") > 0
                loc_lDuplicado = .T.
            ENDIF

            IF USED("cursor_4c_Duplic")
                USE IN cursor_4c_Duplic
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao validar duplicata:" + CHR(13) + CHR(13) + ;
                        "Erro: " + loException.Message + CHR(13) + ;
                        "Linha: " + TRANSFORM(loException.LineNo), "Erro")
        ENDTRY

        RETURN loc_lDuplicado
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir - Insere novo registro em SigSyAcc
    * cIdChaves gerado com SYS(2015) - equivalente ao fUniqueIds() do legado
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Inserir()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            THIS.this_cIdChave = SYS(2015)

            loc_cSQL = "INSERT INTO SigSyAcc (cIdChaves, gracess, usuacess, grcontas, cdcontas)" + ;
                       " VALUES (" + EscaparSQL(THIS.this_cIdChave)  + ;
                       ", "        + EscaparSQL(THIS.this_cGrAcess)  + ;
                       ", "        + EscaparSQL(THIS.this_cUsuAcess) + ;
                       ", "        + EscaparSQL(THIS.this_cGrContas) + ;
                       ", "        + EscaparSQL(THIS.this_cCdContas) + ")"

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("INSERT")
                loc_lSucesso = .T.
            ELSE
                MostrarErro("Erro ao inserir acesso:" + CHR(13) + CHR(13) + ;
                            "SQL: " + loc_cSQL + CHR(13) + CHR(13) + ;
                            CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao inserir acesso:" + CHR(13) + CHR(13) + ;
                        "Erro: " + loException.Message + CHR(13) + ;
                        "Linha: " + TRANSFORM(loException.LineNo), "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - Atualiza registro existente em SigSyAcc
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Atualizar()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "UPDATE SigSyAcc" + ;
                       " SET gracess  = " + EscaparSQL(THIS.this_cGrAcess)  + ;
                       ",    usuacess = " + EscaparSQL(THIS.this_cUsuAcess) + ;
                       ",    grcontas = " + EscaparSQL(THIS.this_cGrContas) + ;
                       ",    cdcontas = " + EscaparSQL(THIS.this_cCdContas) + ;
                       " WHERE cIdChaves = " + EscaparSQL(THIS.this_cIdChave)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("UPDATE")
                loc_lSucesso = .T.
            ELSE
                MostrarErro("Erro ao atualizar acesso:" + CHR(13) + CHR(13) + ;
                            "SQL: " + loc_cSQL + CHR(13) + CHR(13) + ;
                            CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao atualizar acesso:" + CHR(13) + CHR(13) + ;
                        "Erro: " + loException.Message + CHR(13) + ;
                        "Linha: " + TRANSFORM(loException.LineNo), "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ExecutarExclusao - Exclui registro de SigSyAcc
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ExecutarExclusao()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "DELETE FROM SigSyAcc" + ;
                       " WHERE cIdChaves = " + EscaparSQL(THIS.this_cIdChave)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("DELETE")
                loc_lSucesso = .T.
            ELSE
                MostrarErro("Erro ao excluir acesso:" + CHR(13) + CHR(13) + ;
                            "SQL: " + loc_cSQL + CHR(13) + CHR(13) + ;
                            CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao excluir acesso:" + CHR(13) + CHR(13) + ;
                        "Erro: " + loException.Message + CHR(13) + ;
                        "Linha: " + TRANSFORM(loException.LineNo), "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDescricoesConta - Carrega descricoes de display (GrConta e Conta)
    * Preenche this_cDGrConta (SigCdGcr.Descrs) e this_cDConta (SigCdCli.RClis)
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDescricoesConta()
        LOCAL loc_cSQL, loc_nResultado
        THIS.this_cDGrConta = ""
        THIS.this_cDConta   = ""

        TRY
            IF !EMPTY(THIS.this_cGrContas)
                loc_cSQL = "SELECT TOP 1 Descrs FROM SigCdGcr" + ;
                           " WHERE Codigos = " + EscaparSQL(THIS.this_cGrContas)
                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_GrDesc")
                IF loc_nResultado >= 0 AND RECCOUNT("cursor_4c_GrDesc") > 0
                    SELECT cursor_4c_GrDesc
                    THIS.this_cDGrConta = TratarNulo(Descrs, "C")
                ENDIF
                IF USED("cursor_4c_GrDesc")
                    USE IN cursor_4c_GrDesc
                ENDIF
            ENDIF

            IF !EMPTY(THIS.this_cGrContas) AND !EMPTY(THIS.this_cCdContas)
                loc_cSQL = "SELECT TOP 1 RClis FROM SigCdCli" + ;
                           " WHERE Grupos = " + EscaparSQL(THIS.this_cGrContas) + ;
                           " AND   IClis  = " + EscaparSQL(THIS.this_cCdContas)
                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_CtaDesc")
                IF loc_nResultado >= 0 AND RECCOUNT("cursor_4c_CtaDesc") > 0
                    SELECT cursor_4c_CtaDesc
                    THIS.this_cDConta = TratarNulo(RClis, "C")
                ENDIF
                IF USED("cursor_4c_CtaDesc")
                    USE IN cursor_4c_CtaDesc
                ENDIF
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao carregar descri" + CHR(231) + CHR(245) + "es de conta:" + CHR(13) + ;
                        "Erro: " + loException.Message + CHR(13) + ;
                        "Linha: " + TRANSFORM(loException.LineNo), "Erro")
        ENDTRY
    ENDPROC

ENDDEFINE


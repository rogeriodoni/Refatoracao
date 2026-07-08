# CORRIGIR ERRO DE RUNTIME VFP9

## TAREFA OBRIGATORIA
O formulario VFP9 apresentou erro de runtime durante teste automatizado.
Voce DEVE corrigir o erro e salvar os arquivos corrigidos usando Write tool.

## ERRO DETECTADO
- Etapa: 06b_testeAutomatico
- Tentativa: 1/10
- Mensagem: Testes automaticos: 89% < 100%. Falhas: Teste 'ModoVisualizar': Property AJUSTARBOTOESPORMODO is not found. | Detalhes: Linha: 551

## CONTEXTO DO ERRO

### ERROS CAPTURADOS EM MODO TESTE (vfp_error_details.txt):
[09/04/2026 08:39:48 PM] Erro SQL: Erro ao consultar produtos:Connectivity error: [Microsoft][ODBC SQL Server Driver][SQL Server]Invalid column name 'DataAlts'.


### LOG DA ETAPA (06b_testeAutomatico):
[2026-04-09 20:39:46] [INFO] === VFP EXECUTOR v2.0 ===
[2026-04-09 20:39:46] [INFO] Config FPW: (nao fornecido)
[2026-04-09 20:39:46] [INFO] Script PRG: C:\4c\projeto\app\utils\TesteAutomatico.prg
[2026-04-09 20:39:46] [INFO] Timeout: 300 segundos
[2026-04-09 20:39:46] [INFO] Wrapper PRG criado para parametros: C:\Users\clebe\AppData\Local\Temp\vfp_wrapper_3pjdwubd.prg
[2026-04-09 20:39:46] [INFO] Conteudo do wrapper:
[2026-04-09 20:39:46] [INFO] * Auto-generated wrapper for parameters
* Script: C:\4c\projeto\app\utils\TesteAutomatico.prg
* Parameters: 'FormProduto', 'C:\4c\tasks\task005', 'CRUD'

* Anti-dialog protections for unattended execution
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
SET NOTIFY OFF
SYS(2335, 0)

DO "C:\4c\projeto\app\utils\TesteAutomatico" WITH 'FormProduto', 'C:\4c\tasks\task005', 'CRUD'
QUIT

[2026-04-09 20:39:46] [INFO] Comando VFP: C:\Users\clebe\AppData\Local\Temp\vfp_wrapper_3pjdwubd.prg
[2026-04-09 20:39:46] [INFO] VFP output esperado em: C:\4c\tasks\task005\vfp_output.txt
[2026-04-09 20:39:46] [INFO] Executando Visual FoxPro 9...
[2026-04-09 20:39:46] [INFO] Comando completo: VFP9.EXE -T C:\Users\clebe\AppData\Local\Temp\vfp_wrapper_3pjdwubd.prg
[2026-04-09 20:39:46] [INFO] Executando: VFP9.EXE -T C:\Users\clebe\AppData\Local\Temp\vfp_wrapper_3pjdwubd.prg
[2026-04-09 20:39:46] [INFO] Timeout configurado: 300 segundos
[2026-04-09 20:39:48] [INFO] VFP9 finalizou normalmente com exit code: 
[2026-04-09 20:39:48] [INFO] VFP9 finalizado em 1.6263748 segundos
[2026-04-09 20:39:48] [INFO] Exit Code: 
[2026-04-09 20:39:48] [INFO] 
[2026-04-09 20:39:48] [INFO] Arquivos temporarios preservados para inspecao:
[2026-04-09 20:39:48] [INFO]   Wrapper.prg: C:\Users\clebe\AppData\Local\Temp\vfp_wrapper_3pjdwubd.prg
[2026-04-09 20:39:48] [INFO] 
[2026-04-09 20:39:48] [INFO] === Conteudo do Wrapper.prg temporario ===
[2026-04-09 20:39:48] [INFO] * Auto-generated wrapper for parameters
[2026-04-09 20:39:48] [INFO] * Script: C:\4c\projeto\app\utils\TesteAutomatico.prg
[2026-04-09 20:39:48] [INFO] * Parameters: 'FormProduto', 'C:\4c\tasks\task005', 'CRUD'
[2026-04-09 20:39:48] [INFO] 
[2026-04-09 20:39:48] [INFO] * Anti-dialog protections for unattended execution
[2026-04-09 20:39:48] [INFO] SET SAFETY OFF
[2026-04-09 20:39:48] [INFO] SET RESOURCE OFF
[2026-04-09 20:39:48] [INFO] SET TALK OFF
[2026-04-09 20:39:48] [INFO] SET NOTIFY OFF
[2026-04-09 20:39:48] [INFO] SYS(2335, 0)
[2026-04-09 20:39:48] [INFO] 
[2026-04-09 20:39:48] [INFO] DO "C:\4c\projeto\app\utils\TesteAutomatico" WITH 'FormProduto', 'C:\4c\tasks\task005', 'CRUD'
[2026-04-09 20:39:48] [INFO] QUIT
[2026-04-09 20:39:48] [INFO] 
[2026-04-09 20:39:49] [INFO] === Fim do Wrapper.prg ===
[2026-04-09 20:39:49] [WARN] AVISO: VFP9 retornou exit code  (normal para VFP9 GUI - validar pelo arquivo de saida)


### RESULTADO DOS TESTES (teste_resultado.json):
{
  "formClass": "FormProduto",
  "timestamp": "20260409203948",
  "testes": [
    {
      "nome": "Instanciacao",
      "passou": true,
      "erro": "",
      "detalhes": "Objeto criado com sucesso"
    },
    {
      "nome": "CarregarLista",
      "passou": true,
      "erro": "",
      "detalhes": "0 registros em cursor_4c_Lista"
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
      "detalhes": "Linha: 551"
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
      "detalhes": "AbrirLookup: 18 (ABRIRLOOKUPDADOSCGRU, ABRIRLOOKUPDADOSCLASS, ABRIRLOOKUPDADOSCODACB, ABRIRLOOKUPDADOSCODFINP, ABRIRLOOKUPDADOSCOL, ABRIRLOOKUPDADOSCOR, ABRIRLOOKUPDADOSCPRO, ABRIRLOOKUPDADOSCPROEQ, ABRIRLOOKUPDADOSCUNI, ABRIRLOOKUPDADOSCUNIP, ABRIRLOOKUPDADOSIFOR, ABRIRLOOKUPDADOSLIN, ABRIRLOOKUPDADOSLOCAL, ABRIRLOOKUPDADOSMCTOTAL, ABRIRLOOKUPDADOSMFVENDA, ABRIRLOOKUPDADOSMPVENDA, ABRIRLOOKUPDADOSTAM, ABRIRLOOKUPGRUPO) | KeyPress handlers: 19 (DADOSCGRUKEYPRESS, DADOSCLASSKEYPRESS, DADOSCODACBKEYPRESS, DADOSCODFINPKEYPRESS, DADOSCOLKEYPRESS, DADOSCORKEYPRESS, DADOSCPROEQKEYPRESS, DADOSCPROKEYPRESS, DADOSCUNIKEYPRESS, DADOSCUNIPKEYPRESS, DADOSIFORKEYPRESS, DADOSLINKEYPRESS, DADOSLOCALKEYPRESS, DADOSMCTOTALKEYPRESS, DADOSMFVENDAKEYPRESS, DADOSMPVENDAKEYPRESS, DADOSTAMKEYPRESS, FILTROGRUPOKEYPRESS, KEYPRESS)"
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

### FORM (C:\4c\projeto\app\forms\cadastros\FormProduto.prg):
*==============================================================================
* FormProduto.prg - Formulario de Cadastro de Produtos
* Data: 2026-04-09
* Tabela: SigCdPro | PK: cpros
* Legado: SIGCDPRO.SCX (frmcadastro)
* FASE 3/8: Estrutura base - PageFrame, containers, navegacao interna
*
* ESTRUTURA PILAR 1 (UX FIDELITY):
*   Page1 (Lista): Filtros + Grade (7 colunas) + Botoes CRUD + Saida
*   Page2 (Dados): OptionGroup-nav (7 botoes) + pgf_4c_DadosInternos (7 sub-paginas)
*                  + Salvar/Cancelar
* PILAR 2 (DB): SigCdPro, campos cpros/dpros/cbars/cgrus/ifors/reffs/etc.
* PILAR 3 (CODE): FormBase > FormProduto | ProdutoBO
*==============================================================================

DEFINE CLASS FormProduto AS FormBase

    *-- Propriedades visuais (PILAR 1 - UX FIDELITY - Width=1000, Height=600 do legado)
    Height       = 600
    Width        = 1000
    Caption      = "Cadastro de Produtos"
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

    *-- Propriedades do formulario
    this_oBusinessObject = .NULL.
    this_cMensagemErro   = ""      && OBRIGATORIO - nao herdado de FormBase
    this_cModoAtual      = "LISTA"
    this_lNovoRegistro   = .F.

    *--------------------------------------------------------------------------
    * Init - Inicializacao do formulario
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        *-- DODEFAULT() ja chama InicializarForm() via FormBase.Init()
        RETURN DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    * InicializarForm - Configuracao inicial: BO + estrutura visual
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            THIS.this_oBusinessObject = CREATEOBJECT("ProdutoBO")

            IF ISNULL(THIS.this_oBusinessObject)
                MsgErro("Erro ao criar Business Object ProdutoBO", "Erro Cr" + CHR(237) + "tico")
            ELSE
                THIS.ConfigurarPageFrame()
                THIS.ConfigurarPaginaLista()
                THIS.ConfigurarPaginaDados()

                THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption

                *-- Pula CarregarLista() se estiver validando UI (sem conexao SQL)
                IF NOT (TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI)
                    IF !THIS.CarregarLista()
                        *-- Falha ao carregar nao impede abertura do formulario
                    ENDIF
                ENDIF

                THIS.pgf_4c_Paginas.Visible   = .T.
                THIS.pgf_4c_Paginas.ActivePage = 1
                THIS.this_cModoAtual           = "LISTA"
                loc_lSucesso                   = .T.
            ENDIF

        CATCH TO loc_oErro
            MsgErro("Erro ao inicializar FormProduto:" + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPageFrame - PageFrame principal (Top=-29 oculta abas)
    * Legado: Pagina Width=1003, Height=600, PageCount=2
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPageFrame()
        THIS.AddObject("pgf_4c_Paginas", "PageFrame")

        WITH THIS.pgf_4c_Paginas
            .Top        = -29
            .Left       = 0
            .Width      = 1003
            .Height     = 600
            .PageCount  = 2
            .Tabs       = .F.
            .Visible    = .T.

            *-- Page1 - Lista
            .Page1.Caption   = "Lista"
            .Page1.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
            .Page1.BackColor = RGB(255, 255, 255)

            *-- Page2 - Dados
            .Page2.Caption   = "Dados"
            .Page2.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
            .Page2.BackColor = RGB(255, 255, 255)
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPaginaLista - Page1: cabecalho, botoes CRUD, filtros, grid
    * Compensacao +29: Top legado -> Top migrado (+29px por PageFrame.Top=-29)
    * Grupo_op: Top=-1+29=28  | cntFiltros: Top=82+29=111 | Grade: Top=173+29=202
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPaginaLista()
        LOCAL loc_oPagina
        loc_oPagina = THIS.pgf_4c_Paginas.Page1

        *----------------------------------------------------------------------
        *-- Container cabecalho (novo padrao arquitetura - topo escuro)
        *----------------------------------------------------------------------
        loc_oPagina.AddObject("cnt_4c_Cabecalho", "Container")
        WITH loc_oPagina.cnt_4c_Cabecalho
            .Top         = 29
            .Left        = 0
            .Width       = 1003
            .Height      = 80
            .BackStyle   = 1
            .BackColor   = RGB(53, 53, 53)
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH

        loc_oPagina.cnt_4c_Cabecalho.AddObject("lbl_4c_Titulo", "Label")
        WITH loc_oPagina.cnt_4c_Cabecalho.lbl_4c_Titulo
            .Caption   = "Cadastro de Produtos"
            .Top       = 20
            .Left      = 20
            .Width     = 400
            .Height    = 30
            .FontName  = "Tahoma"
            .FontSize  = 14
            .FontBold  = .T.
            .BackStyle = 0
            .ForeColor = RGB(255, 255, 255)
            .Visible   = .T.
        ENDWITH

        *----------------------------------------------------------------------
        *-- Container botoes CRUD (Grupo_op: Left=542, Top=-1 -> 28)
        *----------------------------------------------------------------------
        loc_oPagina.AddObject("cnt_4c_Botoes", "Container")
        WITH loc_oPagina.cnt_4c_Botoes
            .Top         = 28
            .Left        = 542
            .Width       = 390
            .Height      = 85
            .BackStyle = 1
            .BackColor = RGB(53, 53, 53)
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH

        *-- Botao Incluir (Inserir: Left=5)
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

        *-- Botao Visualizar (Consultar: Left=80)
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

        *-- Botao Alterar (Left=155)
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

        *-- Botao Excluir (Left=230)
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

        *-- Botao Buscar (Procurar: Left=305)
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

        *----------------------------------------------------------------------
        *-- Container saida (Botoes: Left=959, Top=171 -> 200 com compensacao +29)
        *----------------------------------------------------------------------
        loc_oPagina.AddObject("cnt_4c_Saida", "Container")
        WITH loc_oPagina.cnt_4c_Saida
            .Top         = 200
            .Left        = 959
            .Width       = 90
            .Height      = 85
            .BackStyle = 1
            .BackColor = RGB(53, 53, 53)
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

        *----------------------------------------------------------------------
        *-- Container filtros (cntFiltros: Top=82+29=111, Left=0, W=383, H=87)
        *-- Conteudo: lblGrupo, getCgru, getDgru, lblData1, getDtIni, lblData2, getDtFim, optFilSituas
        *----------------------------------------------------------------------
        loc_oPagina.AddObject("cnt_4c_Filtros", "Container")
        WITH loc_oPagina.cnt_4c_Filtros
            .Top         = 111
            .Left        = 0
            .Width       = 383
            .Height      = 87
            .BackStyle   = 0
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH

        *-- Label "Grupo de Produto :" (lblGrupo: Top=18, Left=21, W=94)
        loc_oPagina.cnt_4c_Filtros.AddObject("lbl_4c_LblGrupo", "Label")
        WITH loc_oPagina.cnt_4c_Filtros.lbl_4c_LblGrupo
            .Caption   = "Grupo de Produto :"
            .Top       = 18
            .Left      = 21
            .Width     = 94
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        *-- Codigo grupo (getCgru: Top=14, Left=116, W=31, H=23) + F4 abre lookup
        loc_oPagina.cnt_4c_Filtros.AddObject("txt_4c_Cgru", "TextBox")
        WITH loc_oPagina.cnt_4c_Filtros.txt_4c_Cgru
            .Value    = ""
            .Top      = 14
            .Left     = 116
            .Width    = 31
            .Height   = 23
            .FontName = "Tahoma"
            .FontSize = 8
            .Themes   = .F.
            .Visible  = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.cnt_4c_Filtros.txt_4c_Cgru, "KeyPress", THIS, "FiltroGrupoKeyPress")

        *-- Descricao grupo (getDgru: Top=14, Left=149, W=148, H=23 - somente leitura)
        loc_oPagina.cnt_4c_Filtros.AddObject("txt_4c_Dgru", "TextBox")
        WITH loc_oPagina.cnt_4c_Filtros.txt_4c_Dgru
            .Value     = ""
            .Top       = 14
            .Left      = 149
            .Width     = 148
            .Height    = 23
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ReadOnly  = .T.
            .Themes    = .F.
            .BackColor = RGB(240, 240, 240)
            .Visible   = .T.
        ENDWITH

        *-- Label "Ult. Alteracao :" (lblData1: Top=43, Left=28, W=87)
        loc_oPagina.cnt_4c_Filtros.AddObject("lbl_4c_LblData1", "Label")
        WITH loc_oPagina.cnt_4c_Filtros.lbl_4c_LblData1
            .Caption   = CHR(218) + "lt. Altera" + CHR(231) + CHR(227) + "o :"
            .Top       = 43
            .Left      = 28
            .Width     = 87
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        *-- Data inicial (getDtIni: Top=39, Left=116, W=80, H=23)
        loc_oPagina.cnt_4c_Filtros.AddObject("txt_4c_DtIni", "TextBox")
        WITH loc_oPagina.cnt_4c_Filtros.txt_4c_DtIni
            .Value    = {^1900-01-01}
            .Format   = "D"
            .Top      = 39
            .Left     = 116
            .Width    = 80
            .Height   = 23
            .FontName = "Tahoma"
            .FontSize = 8
            .Themes   = .F.
            .Visible  = .T.
        ENDWITH

        *-- Label "ate" (lblData2: Top=43, Left=202, W=18)
        loc_oPagina.cnt_4c_Filtros.AddObject("lbl_4c_LblData2", "Label")
        WITH loc_oPagina.cnt_4c_Filtros.lbl_4c_LblData2
            .Caption   = "at" + CHR(233)
            .Top       = 43
            .Left      = 202
            .Width     = 18
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        *-- Data final (getDtFim: Top=39, Left=225, W=73, H=23)
        loc_oPagina.cnt_4c_Filtros.AddObject("txt_4c_DtFim", "TextBox")
        WITH loc_oPagina.cnt_4c_Filtros.txt_4c_DtFim
            .Value    = {^2900-12-31}
            .Format   = "D"
            .Top      = 39
            .Left     = 225
            .Width    = 73
            .Height   = 23
            .FontName = "Tahoma"
            .FontSize = 8
            .Themes   = .F.
            .Visible  = .T.
        ENDWITH

        *-- OptionGroup situacao (optFilSituas: Top=19, Left=303, W=78, H=46, ButtonCount=3)
        *-- Value=1 Todos, 2 Ativos (Situas=1), 3 Inativos (Situas=2)
        loc_oPagina.cnt_4c_Filtros.AddObject("obj_4c_Situa", "OptionGroup")
        WITH loc_oPagina.cnt_4c_Filtros.obj_4c_Situa
            .ButtonCount = 3
            .BorderStyle = 0
            .Value       = 1
            .Top         = 19
            .Left        = 303
            .Width       = 78
            .Height      = 46
            .AutoSize    = .F.

            WITH .Buttons(1)
                .Caption   = "Todos"
                .Left      = 2
                .Top       = 2
                .Width     = 74
                .Height    = 14
                .Themes    = .F.
                .Visible   = .T.
            ENDWITH

            WITH .Buttons(2)
                .Caption   = "Ativos"
                .Left      = 2
                .Top       = 17
                .Width     = 74
                .Height    = 14
                .FontName  = "Tahoma"
                .FontSize  = 8
                .Themes    = .F.
                .Visible   = .T.
            ENDWITH

            WITH .Buttons(3)
                .Caption   = "Inativos"
                .Left      = 2
                .Top       = 32
                .Width     = 74
                .Height    = 14
                .FontName  = "Tahoma"
                .FontSize  = 8
                .Themes    = .F.
                .Visible   = .T.
            ENDWITH
        ENDWITH
        BINDEVENT(loc_oPagina.cnt_4c_Filtros.obj_4c_Situa, "InteractiveChange", THIS, "FiltroSituaChange")

        *----------------------------------------------------------------------
        *-- Grid lista principal (Grade: Top=173+29=202, Left=38, W=922, H=409)
        *-- 7 colunas: cpros, dpros, cgrus, subgru, reffs, usuario, inativo(chk)
        *-- Conteudo detalhado (colunas, ControlSource): FASE 4
        *----------------------------------------------------------------------
        loc_oPagina.AddObject("grd_4c_Lista", "Grid")
        WITH loc_oPagina.grd_4c_Lista
            .Top             = 202
            .Left            = 38
            .Width           = 922
            .Height          = 409
            .FontName        = "Tahoma"
            .FontSize        = 8
            .GridLines       = 1
            .GridLineColor   = RGB(200, 200, 200)
            .HeaderHeight    = 23
            .RowHeight       = 20
            .DeleteMark      = .F.
            .RecordMark      = .F.
            .Themes          = .F.
            .ReadOnly        = .T.
            .ColumnCount     = 0
            .Visible         = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.grd_4c_Lista, "DblClick", THIS, "GrdListaDblClick")

        *-- Criar cursor placeholder ANTES do RecordSource (evita auto-bind errado)
        *-- Campos: cpros, dpros, cgrus, sgrus, reffs, colecoes, ImpEtiqs(L), Situas(N)
        IF USED("cursor_4c_Lista")
            USE IN cursor_4c_Lista
        ENDIF
        SET NULL ON
        CREATE CURSOR cursor_4c_Lista ;
            (cpros C(25), dpros C(80), cgrus C(5), sgrus C(5), ;
             reffs C(25), colecoes C(20), ImpEtiqs L, Situas N(1,0))
        SET NULL OFF

        *-- RecordSource + ColumnCount OBRIGATORIAMENTE FORA do WITH (regra VFP9)
        LOCAL loc_oGrid
        loc_oGrid = loc_oPagina.grd_4c_Lista
        loc_oGrid.RecordSource = "cursor_4c_Lista"
        loc_oGrid.ColumnCount  = 7

        *-- Re-definir ControlSource de TODAS as colunas apos RecordSource (GRID-AUTOBIND)
        *-- VFP faz auto-bind pela ordem dos campos do cursor, ignorando ControlSource anterior
        loc_oGrid.Column1.ControlSource = "cursor_4c_Lista.cpros"
        loc_oGrid.Column2.ControlSource = "cursor_4c_Lista.dpros"
        loc_oGrid.Column3.ControlSource = "cursor_4c_Lista.cgrus"
        loc_oGrid.Column4.ControlSource = "cursor_4c_Lista.sgrus"
        loc_oGrid.Column5.ControlSource = "cursor_4c_Lista.reffs"
        loc_oGrid.Column6.ControlSource = "cursor_4c_Lista.colecoes"
        *-- Column7 (CheckBox): ControlSource definido apos AddObject/CurrentControl abaixo

        *-- Coluna 1: Produto (CPros) - 100px
        WITH loc_oGrid.Column1
            .ControlSource   = "cursor_4c_Lista.cpros"
            .Width           = 100
            .ReadOnly        = .T.
            .Header1.Caption = "Produto"
            .DynamicForeColor = "IIF(cursor_4c_Lista.Situas=1,RGB(0,0,0),RGB(255,0,0))"
        ENDWITH

        *-- Coluna 2: Descricao (DPros) - 305px
        WITH loc_oGrid.Column2
            .ControlSource   = "cursor_4c_Lista.dpros"
            .Width           = 305
            .ReadOnly        = .T.
            .Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
            .DynamicForeColor = "IIF(cursor_4c_Lista.Situas=1,RGB(0,0,0),RGB(255,0,0))"
        ENDWITH

        *-- Coluna 3: Grupo (CGrus) - 65px
        WITH loc_oGrid.Column3
            .ControlSource   = "cursor_4c_Lista.cgrus"
            .Width           = 65
            .ReadOnly        = .T.
            .Header1.Caption = "Grupo"
            .DynamicForeColor = "IIF(cursor_4c_Lista.Situas=1,RGB(0,0,0),RGB(255,0,0))"
        ENDWITH

        *-- Coluna 4: Subgrupo (SGrus) - 65px
        WITH loc_oGrid.Column4
            .ControlSource   = "cursor_4c_Lista.sgrus"
            .Width           = 65
            .ReadOnly        = .T.
            .Header1.Caption = "Subgrp."
            .DynamicForeColor = "IIF(cursor_4c_Lista.Situas=1,RGB(0,0,0),RGB(255,0,0))"
        ENDWITH

        *-- Coluna 5: Ref. Fornecedor (Reffs) - 155px
        WITH loc_oGrid.Column5
            .ControlSource   = "cursor_4c_Lista.reffs"
            .Width           = 155
            .ReadOnly        = .T.
            .Header1.Caption = "Ref. Fornecedor"
            .DynamicForeColor = "IIF(cursor_4c_Lista.Situas=1,RGB(0,0,0),RGB(255,0,0))"
        ENDWITH

        *-- Coluna 6: Grp.Venda (Colecoes) - 150px
        WITH loc_oGrid.Column6
            .ControlSource   = "cursor_4c_Lista.colecoes"
            .Width           = 150
            .ReadOnly        = .T.
            .Header1.Caption = "Grp"
            .DynamicForeColor = "IIF(cursor_4c_Lista.Situas=1,RGB(0,0,0),RGB(255,0,0))"
        ENDWITH

        *-- Coluna 7: ImpEtiqs CheckBox ("I") - 30px
        *-- OBRIGATORIO: AddObject ANTES de CurrentControl ANTES de ControlSource
        loc_oGrid.Column7.AddObject("Check1", "CheckBox")
        loc_oGrid.Column7.CurrentControl    = "Check1"
        loc_oGrid.Column7.ControlSource     = "cursor_4c_Lista.ImpEtiqs"
        loc_oGrid.Column7.Width             = 30
        loc_oGrid.Column7.ReadOnly          = .T.
        loc_oGrid.Column7.Header1.Caption   = "I"
        WITH loc_oGrid.Column7.Check1
            .Caption   = ""
            .BackStyle = 0
            .Enabled   = .F.
            .Themes    = .F.
        ENDWITH

        *-- Label contador de registros (lblProdutos: Top=584+29=613 mas limitado)
        loc_oPagina.AddObject("lbl_4c_Contador", "Label")
        WITH loc_oPagina.lbl_4c_Contador
            .Caption   = "Produtos Selecionados : 0"
            .Top       = 613
            .Left      = 38
            .Width     = 200
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(60, 60, 60)
            .Visible   = .T.
        ENDWITH

        THIS.TornarControlesVisiveis(loc_oPagina)
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPaginaDados - Page2: OptionGroup-nav + pgf_4c_DadosInternos (7pp)
    *                         + Salvar/Cancelar
    * Compensacao +29 aplicada: Top legado -> Top migrado
    * Optiongroup1: Top=5+29=34 | Grupo_Salva: Top=5+29=34, Left=842
    * pgframeDados: Top=-54+29=-25, Left=-1, W=1003, H=656, PageCount=7
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPaginaDados()
        LOCAL loc_oPagina
        loc_oPagina = THIS.pgf_4c_Paginas.Page2

        *----------------------------------------------------------------------
        *-- OptionGroup de navegacao entre sub-paginas
        *-- Optiongroup1: Left=5, Top=5+29=34, Width=535, Height=85, ButtonCount=7
        *----------------------------------------------------------------------
        loc_oPagina.AddObject("obj_4c_NavegacaoDados", "OptionGroup")
        WITH loc_oPagina.obj_4c_NavegacaoDados
            .ButtonCount   = 7
            .AutoSize      = .T.
            .BorderStyle   = 0
            .Value         = 1
            .Top           = 34
            .Left          = 5
            .Width         = 535
            .Height        = 85

            *-- Option 1: Principal (optDados)
            WITH .Buttons(1)
                .Caption       = "\<Principal"
                .Picture       = gc_4c_CaminhoIcones + "geral_produtos_60.jpg"
                .Height        = 75
                .Width         = 75
                .Left          = 5
                .Top           = 5
                .Style         = 1
                .SpecialEffect = 0
                .FontBold      = .T.
                .FontItalic    = .T.
                .ForeColor     = RGB(90, 90, 90)
                .BackColor     = RGB(255, 255, 255)
                .Themes        = .F.
                .AutoSize      = .F.
                .Visible       = .T.
            ENDWITH

            *-- Option 2: Componente (optComposicao) -> pgComposicao (PageOrder=2)
            WITH .Buttons(2)
                .Caption       = "Componen\<te"
                .Picture       = gc_4c_CaminhoIcones + "geral_configuracao_60.jpg"
                .Height        = 75
                .Width         = 75
                .Left          = 80
                .Top           = 5
                .Style         = 1
                .SpecialEffect = 0
                .FontBold      = .T.
                .FontItalic    = .T.
                .FontName      = "Comic Sans MS"
                .FontSize      = 8
                .ForeColor     = RGB(90, 90, 90)
                .BackColor     = RGB(255, 255, 255)
                .Themes        = .F.
                .AutoSize      = .F.
                .Visible       = .T.
            ENDWITH

            *-- Option 3: Fiscal (optDadosFiscais) -> pgDadosFiscais (PageOrder=3)
            WITH .Buttons(3)
                .Caption       = "\<Fiscal"
                .Picture       = gc_4c_CaminhoIcones + "geral_nota_60.jpg"
                .Height        = 75
                .Width         = 75
                .Left          = 155
                .Top           = 5
                .Style         = 1
                .SpecialEffect = 0
                .FontBold      = .T.
                .FontItalic    = .T.
                .FontName      = "Comic Sans MS"
                .FontSize      = 8
                .ForeColor     = RGB(90, 90, 90)
                .BackColor     = RGB(255, 255, 255)
                .Themes        = .F.
                .AutoSize      = .F.
                .Visible       = .T.
            ENDWITH

            *-- Option 4: Processo (optDadosFaseP) -> PgDadosFaseP (PageOrder=4)
            WITH .Buttons(4)
                .Caption       = "P\<rocesso"
                .Picture       = gc_4c_CaminhoIcones + "geral_cronometro_60.jpg"
                .Height        = 75
                .Width         = 75
                .Left          = 230
                .Top           = 5
                .Style         = 1
                .SpecialEffect = 0
                .FontBold      = .T.
                .FontItalic    = .T.
                .FontName      = "Comic Sans MS"
                .FontSize      = 8
                .ForeColor     = RGB(90, 90, 90)
                .BackColor     = RGB(255, 255, 255)
                .Themes        = .F.
                .AutoSize      = .F.
                .Visible       = .T.
            ENDWITH

            *-- Option 5: Consumo (optDadosConsP) -> PgDadosConsP (PageOrder=5)
            WITH .Buttons(5)
                .Caption       = "Co\<nsumo"
                .Picture       = gc_4c_CaminhoIcones + "geral_pn_btn_60.jpg"
                .Height        = 75
                .Width         = 75
                .Left          = 305
                .Top           = 5
                .Style         = 1
                .SpecialEffect = 0
                .FontBold      = .T.
                .FontItalic    = .T.
                .FontName      = "Comic Sans MS"
                .FontSize      = 8
                .ForeColor     = RGB(90, 90, 90)
                .BackColor     = RGB(255, 255, 255)
                .Themes        = .F.
                .AutoSize      = .F.
                .Visible       = .T.
            ENDWITH

            *-- Option 6: Custo (optCusto) -> pgCusto (PageOrder=6)
            WITH .Buttons(6)
                .Caption       = "C\<usto"
                .Picture       = gc_4c_CaminhoIcones + "geral_calculadora_60.jpg"
                .Height        = 75
                .Width         = 75
                .Left          = 380
                .Top           = 5
                .Style         = 1
                .SpecialEffect = 0
                .FontBold      = .T.
                .FontItalic    = .T.
                .FontName      = "Comic Sans MS"
                .FontSize      = 8
                .ForeColor     = RGB(90, 90, 90)
                .BackColor     = RGB(255, 255, 255)
                .Themes        = .F.
                .AutoSize      = .F.
                .Visible       = .T.
            ENDWITH

            *-- Option 7: Designer (optDesigner) -> pgDesigner (PageOrder=7)
            WITH .Buttons(7)
                .Caption       = "\<Designer"
                .Picture       = gc_4c_CaminhoIcones + "geral_cores_60.jpg"
                .Height        = 75
                .Width         = 75
                .Left          = 455
                .Top           = 5
                .Style         = 1
                .SpecialEffect = 0
                .FontBold      = .T.
                .FontItalic    = .T.
                .FontName      = "Comic Sans MS"
                .FontSize      = 8
                .ForeColor     = RGB(90, 90, 90)
                .BackColor     = RGB(255, 255, 255)
                .Themes        = .F.
                .AutoSize      = .F.
                .Visible       = .T.
            ENDWITH
        ENDWITH
        BINDEVENT(loc_oPagina.obj_4c_NavegacaoDados, "InteractiveChange", THIS, "NavegacaoDadosChange")

        *----------------------------------------------------------------------
        *-- Container botoes Salvar/Cancelar
        *-- Grupo_Salva: Left=842, Top=5+29=34, Width=165, Height=85
        *----------------------------------------------------------------------
        loc_oPagina.AddObject("cnt_4c_Salva", "Container")
        WITH loc_oPagina.cnt_4c_Salva
            .Top         = 34
            .Left        = 842
            .Width       = 165
            .Height      = 85
            .BackStyle   = 0
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH

        *-- Botao Confirmar/Salvar (Salva: Left=5)
        loc_oPagina.cnt_4c_Salva.AddObject("cmd_4c_Confirmar", "CommandButton")
        WITH loc_oPagina.cnt_4c_Salva.cmd_4c_Confirmar
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
        BINDEVENT(loc_oPagina.cnt_4c_Salva.cmd_4c_Confirmar, "Click", THIS, "BtnConfirmarClick")

        *-- Botao Cancelar (Left=80)
        loc_oPagina.cnt_4c_Salva.AddObject("cmd_4c_Cancelar", "CommandButton")
        WITH loc_oPagina.cnt_4c_Salva.cmd_4c_Cancelar
            .Caption         = "Cancelar"
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
        BINDEVENT(loc_oPagina.cnt_4c_Salva.cmd_4c_Cancelar, "Click", THIS, "BtnCancelarClick")

        *----------------------------------------------------------------------
        *-- PageFrame interno com 7 sub-paginas (pgframeDados migrado)
        *-- Top=-54+29=-25, Left=-1, Width=1003, Height=656, PageCount=7
        *-- Tabs posicionados acima da area visivel; nav via obj_4c_NavegacaoDados
        *----------------------------------------------------------------------
        loc_oPagina.AddObject("pgf_4c_DadosInternos", "PageFrame")
        WITH loc_oPagina.pgf_4c_DadosInternos
            .Top        = -25
            .Left       = -1
            .Width      = 1003
            .Height     = 656
            .PageCount  = 7
            .Tabs       = .T.
            .Visible    = .T.

            *-- Page1: Dados Principais (pgDados - PageOrder=1)
            .Page1.Caption   = "Dados Principais"
            .Page1.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
            .Page1.BackColor = RGB(255, 255, 255)
            .Page1.FontBold  = .T.
            .Page1.ForeColor = RGB(36, 84, 155)

            *-- Page2: Custos - nome pgComposicao no legado (PageOrder=2)
            .Page2.Caption   = "Custos"
            .Page2.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
            .Page2.BackColor = RGB(255, 255, 255)
            .Page2.FontBold  = .T.
            .Page2.FontName  = "Verdana"
            .Page2.FontSize  = 8
            .Page2.ForeColor = RGB(36, 84, 155)

            *-- Page3: Dados Fiscais (pgDadosFiscais - PageOrder=3)
            .Page3.Caption   = "Dados Fiscais"
            .Page3.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
            .Page3.BackColor = RGB(255, 255, 255)
            .Page3.FontBold  = .T.
            .Page3.FontName  = "Verdana"
            .Page3.FontSize  = 8
            .Page3.ForeColor = RGB(36, 84, 155)

            *-- Page4: Processos (PgDadosFaseP - PageOrder=4)
            .Page4.Caption   = "Processos"
            .Page4.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
            .Page4.BackColor = RGB(255, 255, 255)
            .Page4.FontBold  = .T.
            .Page4.FontName  = "Verdana"
            .Page4.FontSize  = 8
            .Page4.ForeColor = RGB(36, 84, 155)

            *-- Page5: Consumo (PgDadosConsP - PageOrder=5)
            .Page5.Caption   = "Consumo"
            .Page5.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
            .Page5.BackColor = RGB(255, 255, 255)
            .Page5.FontBold  = .T.
            .Page5.FontName  = "Verdana"
            .Page5.FontSize  = 8
            .Page5.ForeColor = RGB(36, 84, 155)

            *-- Page6: Composicao - nome pgCusto no legado (PageOrder=6)
            .Page6.Caption   = "Composi" + CHR(231) + CHR(227) + "o"
            .Page6.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
            .Page6.BackColor = RGB(255, 255, 255)
            .Page6.FontBold  = .T.
            .Page6.FontName  = "Verdana"
            .Page6.FontSize  = 8
            .Page6.ForeColor = RGB(36, 84, 155)

            *-- Page7: Designer (pgDesigner - PageOrder=7)
            .Page7.Caption   = "Designer"
            .Page7.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
            .Page7.BackColor = RGB(255, 255, 255)
            .Page7.ForeColor = RGB(36, 84, 155)
        ENDWITH

        THIS.ConfigurarPgDados1()
        THIS.ConfigurarPgDados1b()
        THIS.TornarControlesVisiveis(loc_oPagina)
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPgDados1 - Page1 dos Dados Internos (pgDados) - Parte 1/2
    * Campos: identificacao, grupos, fornecedor, codigos, status, EAN, Cor, Tam
    * Top values: FROM layout.json AS-IS (sem compensacao - pageframe interno)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPgDados1()
        LOCAL loc_oPg1
        loc_oPg1 = THIS.pgf_4c_Paginas.Page2.pgf_4c_DadosInternos.Page1

        *----------------------------------------------------------------------
        *-- ROW 1 (Top=130): Produto + Descricao + Status + DtSituas
        *----------------------------------------------------------------------
        *-- Label "Produto:" (top=134, left=58, w=53)
        loc_oPg1.AddObject("lbl_4c_LblProduto", "Label")
        WITH loc_oPg1.lbl_4c_LblProduto
            .Caption   = "Produto :"
            .Top       = 134
            .Left      = 58
            .Width     = 53
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        *-- getCpro -> txt_4c_Cpro (top=130, left=113, w=108, h=23)
        loc_oPg1.AddObject("txt_4c_Cpro", "TextBox")
        WITH loc_oPg1.txt_4c_Cpro
            .Value    = ""
            .Top      = 130
            .Left     = 113
            .Width    = 108
            .Height   = 23
            .FontName = "Tahoma"
            .FontSize = 8
            .Themes   = .F.
            .Visible  = .T.
        ENDWITH
        BINDEVENT(loc_oPg1.txt_4c_Cpro, "KeyPress", THIS, "DadosCproKeyPress")

        *-- getDpro -> txt_4c_Dpro (top=130, left=222, w=290, h=23)
        loc_oPg1.AddObject("txt_4c_Dpro", "TextBox")
        WITH loc_oPg1.txt_4c_Dpro
            .Value    = ""
            .Top      = 130
            .Left     = 222
            .Width    = 290
            .Height   = 23
            .FontName = "Tahoma"
            .FontSize = 8
            .Themes   = .F.
            .Visible  = .T.
        ENDWITH

        *-- opc_situacao -> obj_4c_OpcSituacao (top=130, left=735, w=142, h=25)
        *-- Situas: 1=Ativo, 2=Inativo
        loc_oPg1.AddObject("obj_4c_OpcSituacao", "OptionGroup")
        WITH loc_oPg1.obj_4c_OpcSituacao
            .ButtonCount = 2
            .BorderStyle = 0
            .Value       = 1
            .Top         = 130
            .Left        = 735
            .Width       = 142
            .Height      = 25
            WITH .Buttons(1)
                .Caption  = "Ativo"
                .Left     = 2
                .Top      = 4
                .Width    = 55
                .Height   = 14
                .Themes   = .F.
                .Visible  = .T.
            ENDWITH
            WITH .Buttons(2)
                .Caption  = "Inativo"
                .Left     = 60
                .Top      = 4
                .Width    = 75
                .Height   = 14
                .FontName = "Tahoma"
                .FontSize = 8
                .Themes   = .F.
                .Visible  = .T.
            ENDWITH
        ENDWITH

        *-- getDtSituas -> txt_4c_DtSituas (top=132, left=878, w=80, h=21) - data do status
        loc_oPg1.AddObject("txt_4c_DtSituas", "TextBox")
        WITH loc_oPg1.txt_4c_DtSituas
            .Value     = {^2000-01-01}
            .Format    = "D"
            .Top       = 132
            .Left      = 878
            .Width     = 80
            .Height    = 21
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ReadOnly  = .T.
            .BackColor = RGB(240, 240, 240)
            .Themes    = .F.
            .Visible   = .T.
        ENDWITH

        *----------------------------------------------------------------------
        *-- ROW 2 (Top=154): Descritivo + Barra + LtMins + Equivalente
        *----------------------------------------------------------------------
        *-- Label "Descritivo:" (top=158, left=55, w=56)
        loc_oPg1.AddObject("lbl_4c_LblDescritivo", "Label")
        WITH loc_oPg1.lbl_4c_LblDescritivo
            .Caption   = "Descritivo :"
            .Top       = 158
            .Left      = 55
            .Width     = 56
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        *-- getDPro2s -> txt_4c_DPro2s (top=154, left=113, w=399, h=23)
        loc_oPg1.AddObject("txt_4c_DPro2s", "TextBox")
        WITH loc_oPg1.txt_4c_DPro2s
            .Value    = ""
            .Top      = 154
            .Left     = 113
            .Width    = 399
            .Height   = 23
            .FontName = "Tahoma"
            .FontSize = 8
            .Themes   = .F.
            .Visible  = .T.
        ENDWITH

        *-- Label "Equivalente:" (top=137, left=560, w=65)
        loc_oPg1.AddObject("lbl_4c_LblCProEq", "Label")
        WITH loc_oPg1.lbl_4c_LblCProEq
            .Caption   = "Equivalente :"
            .Top       = 137
            .Left      = 560
            .Width     = 65
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        *-- Get_CProEq -> txt_4c_CProEq (top=133, left=626, w=108, h=21)
        loc_oPg1.AddObject("txt_4c_CProEq", "TextBox")
        WITH loc_oPg1.txt_4c_CProEq
            .Value    = ""
            .Top      = 133
            .Left     = 626
            .Width    = 108
            .Height   = 21
            .FontName = "Tahoma"
            .FontSize = 8
            .Themes   = .F.
            .Visible  = .T.
        ENDWITH
        BINDEVENT(loc_oPg1.txt_4c_CProEq, "KeyPress", THIS, "DadosCProEqKeyPress")

        *-- Label "Barra:" (top=157, left=590, w=35)
        loc_oPg1.AddObject("lbl_4c_LblCbar", "Label")
        WITH loc_oPg1.lbl_4c_LblCbar
            .Caption   = "Barra :"
            .Top       = 157
            .Left      = 590
            .Width     = 35
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        *-- getCbar -> txt_4c_Cbar (top=155, left=626, w=108, h=21) - numeric
        loc_oPg1.AddObject("txt_4c_Cbar", "TextBox")
        WITH loc_oPg1.txt_4c_Cbar
            .Value    = 0
            .Top      = 155
            .Left     = 626
            .Width    = 108
            .Height   = 21
            .FontName = "Tahoma"
            .FontSize = 8
            .Themes   = .F.
            .Visible  = .T.
        ENDWITH

        *-- Label "Lote M" + CHR(237) + "nimo:" (top=157, left=812, w=65)
        loc_oPg1.AddObject("lbl_4c_LblLtMins", "Label")
        WITH loc_oPg1.lbl_4c_LblLtMins
            .Caption   = "Lote M" + CHR(237) + "nimo :"
            .Top       = 157
            .Left      = 812
            .Width     = 65
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        *-- getLtMinsV -> txt_4c_LtMinsV (top=154, left=878, w=80, h=21)
        loc_oPg1.AddObject("txt_4c_LtMinsV", "TextBox")
        WITH loc_oPg1.txt_4c_LtMinsV
            .Value    = 0.000
            .Top      = 154
            .Left     = 878
            .Width    = 80
            .Height   = 21
            .FontName = "Tahoma"
            .FontSize = 8
            .Themes   = .F.
            .Visible  = .T.
        ENDWITH

        *----------------------------------------------------------------------
        *-- ROW 3 (Top=178): Grupo + Merc + IdeCPros + EAN13 + ProdWeb
        *----------------------------------------------------------------------
        *-- Label "Grupo:" (top=182, left=73, w=38)
        loc_oPg1.AddObject("lbl_4c_LblCgru", "Label")
        WITH loc_oPg1.lbl_4c_LblCgru
            .Caption   = "Grupo :"
            .Top       = 182
            .Left      = 73
            .Width     = 38
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        *-- getCgru -> txt_4c_Cgru (top=178, left=113, w=31, h=23)
        loc_oPg1.AddObject("txt_4c_Cgru", "TextBox")
        WITH loc_oPg1.txt_4c_Cgru
            .Value    = ""
            .Top      = 178
            .Left     = 113
            .Width    = 31
            .Height   = 23
            .FontName = "Tahoma"
            .FontSize = 8
            .Themes   = .F.
            .Visible  = .T.
        ENDWITH
        BINDEVENT(loc_oPg1.txt_4c_Cgru, "KeyPress", THIS, "DadosCgruKeyPress")

        *-- getDgru -> txt_4c_Dgru (top=178, left=145, w=171, h=23) - somente leitura
        loc_oPg1.AddObject("txt_4c_Dgru", "TextBox")
        WITH loc_oPg1.txt_4c_Dgru
            .Value     = ""
            .Top       = 178
            .Left      = 145
            .Width     = 171
            .Height    = 23
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ReadOnly  = .T.
            .BackColor = RGB(240, 240, 240)
            .Themes    = .F.
            .Visible   = .T.
        ENDWITH

        *-- getMerc -> txt_4c_Merc (top=178, left=318, w=31, h=23) - no label in layout
        loc_oPg1.AddObject("txt_4c_Merc", "TextBox")
        WITH loc_oPg1.txt_4c_Merc
            .Value    = ""
            .Top      = 178
            .Left     = 318
            .Width    = 31
            .Height   = 23
            .FontName = "Tahoma"
            .FontSize = 8
            .Themes   = .F.
            .Visible  = .T.
        ENDWITH

        *-- Label "Identificador:" (top=182, left=408, w=70)
        loc_oPg1.AddObject("lbl_4c_LblIdeCPros", "Label")
        WITH loc_oPg1.lbl_4c_LblIdeCPros
            .Caption   = "Identificador :"
            .Top       = 182
            .Left      = 408
            .Width     = 70
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        *-- getIdeCPros -> txt_4c_IdeCPros (top=178, left=481, w=31, h=23)
        loc_oPg1.AddObject("txt_4c_IdeCPros", "TextBox")
        WITH loc_oPg1.txt_4c_IdeCPros
            .Value    = ""
            .Top      = 178
            .Left     = 481
            .Width    = 31
            .Height   = 23
            .FontName = "Tahoma"
            .FontSize = 8
            .Themes   = .F.
            .Visible  = .T.
        ENDWITH

        *-- Label "EAN/GTIN:" (top=181, left=568, w=57)
        loc_oPg1.AddObject("lbl_4c_LblEAN13", "Label")
        WITH loc_oPg1.lbl_4c_LblEAN13
            .Caption   = "EAN/GTIN :"
            .Top       = 181
            .Left      = 568
            .Width     = 57
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        *-- getEAN13 -> txt_4c_EAN13 (top=177, left=626, w=108, h=21)
        loc_oPg1.AddObject("txt_4c_EAN13", "TextBox")
        WITH loc_oPg1.txt_4c_EAN13
            .Value    = 0
            .Top      = 177
            .Left     = 626
            .Width    = 108
            .Height   = 21
            .FontName = "Tahoma"
            .FontSize = 8
            .Themes   = .F.
            .Visible  = .T.
        ENDWITH

        *-- Label "Produto Web:" (top=176, left=805, w=72) - para obj_4c_ProdWeb
        loc_oPg1.AddObject("lbl_4c_LblProdWeb", "Label")
        WITH loc_oPg1.lbl_4c_LblProdWeb
            .Caption   = "Produto Web :"
            .Top       = 176
            .Left      = 805
            .Width     = 72
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        *-- Fwoption1 -> obj_4c_ProdWeb (top=172, left=879, w=117, h=42, 4 botoes)
        *-- Varias field mapeado: 0=Nenhum, 1=Sim, 2=Nao, 3=Destaque
        loc_oPg1.AddObject("obj_4c_ProdWeb", "OptionGroup")
        WITH loc_oPg1.obj_4c_ProdWeb
            .ButtonCount = 4
            .BorderStyle = 0
            .Value       = 1
            .Top         = 172
            .Left        = 879
            .Width       = 117
            .Height      = 42
            WITH .Buttons(1)
                .Caption  = "Nenhum"
                .Left     = 2
                .Top      = 2
                .Width    = 55
                .Height   = 14
                .Themes   = .F.
                .Visible  = .T.
            ENDWITH
            WITH .Buttons(2)
                .Caption  = "Sim"
                .Left     = 60
                .Top      = 2
                .Width    = 55
                .Height   = 14
                .FontName = "Tahoma"
                .FontSize = 8
                .Themes   = .F.
                .Visible  = .T.
            ENDWITH
            WITH .Buttons(3)
                .Caption  = "N" + CHR(227) + "o"
                .Left     = 2
                .Top      = 18
                .Width    = 55
                .Height   = 14
                .FontName = "Tahoma"
                .FontSize = 8
                .Themes   = .F.
                .Visible  = .T.
            ENDWITH
            WITH .Buttons(4)
                .Caption  = "Destaque"
                .Left     = 60
                .Top      = 18
                .Width    = 55
                .Height   = 14
                .FontName = "Tahoma"
                .FontSize = 8
                .Themes   = .F.
                .Visible  = .T.
            ENDWITH
        ENDWITH

        *----------------------------------------------------------------------
        *-- ROW 4 (Top=202): Subgrupo + Variacao
        *----------------------------------------------------------------------
        *-- Label "Subgrupo:" (top=206, left=56, w=55)
        loc_oPg1.AddObject("lbl_4c_LblCSGru", "Label")
        WITH loc_oPg1.lbl_4c_LblCSGru
            .Caption   = "Subgrupo :"
            .Top       = 206
            .Left      = 56
            .Width     = 55
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        *-- GetCSGru -> txt_4c_CSGru (top=202, left=113, w=52, h=23)
        *-- Sem tabela de lookup separada para subgrupos
        loc_oPg1.AddObject("txt_4c_CSGru", "TextBox")
        WITH loc_oPg1.txt_4c_CSGru
            .Value    = ""
            .Top      = 202
            .Left     = 113
            .Width    = 52
            .Height   = 23
            .FontName = "Tahoma"
            .FontSize = 8
            .Themes   = .F.
            .Visible  = .T.
        ENDWITH

        *-- GetDsGru -> txt_4c_DsGru (top=202, left=166, w=150, h=23) - somente leitura
        loc_oPg1.AddObject("txt_4c_DsGru", "TextBox")
        WITH loc_oPg1.txt_4c_DsGru
            .Value     = ""
            .Top       = 202
            .Left      = 166
            .Width     = 150
            .Height    = 23
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ReadOnly  = .T.
            .BackColor = RGB(240, 240, 240)
            .Themes    = .F.
            .Visible   = .T.
        ENDWITH

        *-- Label "Variacao:" (top=207, left=827, w=50)
        loc_oPg1.AddObject("lbl_4c_LblVariacao", "Label")
        WITH loc_oPg1.lbl_4c_LblVariacao
            .Caption   = "Varia" + CHR(231) + CHR(227) + "o :"
            .Top       = 207
            .Left      = 827
            .Width     = 50
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        *-- Fwoption2 -> obj_4c_Variacao (top=203, left=874, w=107, h=22, 2 botoes)
        *-- 0=Nenhum / 1=Cor-Tam (mapeado em Varias de SigCdPro)
        loc_oPg1.AddObject("obj_4c_Variacao", "OptionGroup")
        WITH loc_oPg1.obj_4c_Variacao
            .ButtonCount = 2
            .BorderStyle = 0
            .Value       = 1
            .Top         = 203
            .Left        = 874
            .Width       = 107
            .Height      = 22
            WITH .Buttons(1)
                .Caption  = "Nenhum"
                .Left     = 2
                .Top      = 4
                .Width    = 50
                .Height   = 14
                .Themes   = .F.
                .Visible  = .T.
            ENDWITH
            WITH .Buttons(2)
                .Caption  = "Cor-Tam"
                .Left     = 55
                .Top      = 4
                .Width    = 50
                .Height   = 14
                .FontName = "Tahoma"
                .FontSize = 8
                .Themes   = .F.
                .Visible  = .T.
            ENDWITH
        ENDWITH

        *----------------------------------------------------------------------
        *-- ROW 5 (Top=226): Linha + QtPed + Garantia + ChkGarVit
        *----------------------------------------------------------------------
        *-- Label "Linha:" (top=230, left=77, w=34)
        loc_oPg1.AddObject("lbl_4c_LblLin", "Label")
        WITH loc_oPg1.lbl_4c_LblLin
            .Caption   = "Linha :"
            .Top       = 230
            .Left      = 77
            .Width     = 34
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        *-- GetLin -> txt_4c_Lin (top=226, left=113, w=80, h=23)
        loc_oPg1.AddObject("txt_4c_Lin", "TextBox")
        WITH loc_oPg1.txt_4c_Lin
            .Value    = ""
            .Top      = 226
            .Left     = 113
            .Width    = 80
            .Height   = 23
            .FontName = "Tahoma"
            .FontSize = 8
            .Themes   = .F.
            .Visible  = .T.
        ENDWITH
        BINDEVENT(loc_oPg1.txt_4c_Lin, "KeyPress", THIS, "DadosLinKeyPress")

        *-- GetDLin -> txt_4c_DLin (top=226, left=194, w=318, h=23) - somente leitura
        loc_oPg1.AddObject("txt_4c_DLin", "TextBox")
        WITH loc_oPg1.txt_4c_DLin
            .Value     = ""
            .Top       = 226
            .Left      = 194
            .Width     = 318
            .Height    = 23
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ReadOnly  = .T.
            .BackColor = RGB(240, 240, 240)
            .Themes    = .F.
            .Visible   = .T.
        ENDWITH

        *-- Label "Garantia:" (top=228, left=827, w=50)
        loc_oPg1.AddObject("lbl_4c_LblDiasGar", "Label")
        WITH loc_oPg1.lbl_4c_LblDiasGar
            .Caption   = "Garantia :"
            .Top       = 228
            .Left      = 827
            .Width     = 50
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        *-- getDiasGar -> txt_4c_DiasGar (top=224, left=880, w=34, h=21)
        loc_oPg1.AddObject("txt_4c_DiasGar", "TextBox")
        WITH loc_oPg1.txt_4c_DiasGar
            .Value    = 0
            .Top      = 224
            .Left     = 880
            .Width    = 34
            .Height   = 21
            .FontName = "Tahoma"
            .FontSize = 8
            .Themes   = .F.
            .Visible  = .T.
        ENDWITH

        *-- Label "Dias" (top=228, left=918, w=22)
        loc_oPg1.AddObject("lbl_4c_LblDias", "Label")
        WITH loc_oPg1.lbl_4c_LblDias
            .Caption   = "Dias"
            .Top       = 228
            .Left      = 918
            .Width     = 22
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        *-- ChkGarVit -> chk_4c_GarVit (top=228, left=943) - Vitalicia
        loc_oPg1.AddObject("chk_4c_GarVit", "CheckBox")
        WITH loc_oPg1.chk_4c_GarVit
            .Caption   = "Vital" + CHR(237) + "cia"
            .Value     = 0
            .Top       = 228
            .Left      = 943
            .Width     = 54
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Themes    = .F.
            .Visible   = .T.
        ENDWITH

        *----------------------------------------------------------------------
        *-- ROW 6 (Top=250): Colecao/Grupo de Venda + Obs3
        *----------------------------------------------------------------------
        *-- Label "Grupo de Venda:" (top=253, left=25, w=86)
        loc_oPg1.AddObject("lbl_4c_LblCol", "Label")
        WITH loc_oPg1.lbl_4c_LblCol
            .Caption   = "Grupo de Venda :"
            .Top       = 253
            .Left      = 25
            .Width     = 86
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        *-- GetCol -> txt_4c_Col (top=250, left=113, w=80, h=23)
        loc_oPg1.AddObject("txt_4c_Col", "TextBox")
        WITH loc_oPg1.txt_4c_Col
            .Value    = ""
            .Top      = 250
            .Left     = 113
            .Width    = 80
            .Height   = 23
            .FontName = "Tahoma"
            .FontSize = 8
            .Themes   = .F.
            .Visible  = .T.
        ENDWITH
        BINDEVENT(loc_oPg1.txt_4c_Col, "KeyPress", THIS, "DadosColKeyPress")

        *-- GetDCol -> txt_4c_DCol (top=250, left=194, w=318, h=23) - somente leitura
        loc_oPg1.AddObject("txt_4c_DCol", "TextBox")
        WITH loc_oPg1.txt_4c_DCol
            .Value     = ""
            .Top       = 250
            .Left      = 194
            .Width     = 318
            .Height    = 23
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ReadOnly  = .T.
            .BackColor = RGB(240, 240, 240)
            .Themes    = .F.
            .Visible   = .T.
        ENDWITH

        *-- Label "Obs. Componente:" (top=247, left=529, w=96)
        loc_oPg1.AddObject("lbl_4c_LblObsComp", "Label")
        WITH loc_oPg1.lbl_4c_LblObsComp
            .Caption   = "Obs. Componente :"
            .Top       = 247
            .Left      = 529
            .Width     = 96
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        *-- GetObs3 -> txt_4c_Obs3 (top=243, left=626, w=80, h=21) -> obsetqs
        loc_oPg1.AddObject("txt_4c_Obs3", "TextBox")
        WITH loc_oPg1.txt_4c_Obs3
            .Value    = ""
            .Top      = 243
            .Left     = 626
            .Width    = 80
            .Height   = 21
            .FontName = "Tahoma"
            .FontSize = 8
            .Themes   = .F.
            .Visible  = .T.
        ENDWITH

        *----------------------------------------------------------------------
        *-- ROW 7 (Top=274): Fornecedor + Obs1
        *----------------------------------------------------------------------
        *-- Label "Fornecedor:" (top=278, left=47, w=64)
        loc_oPg1.AddObject("lbl_4c_LblIfor", "Label")
        WITH loc_oPg1.lbl_4c_LblIfor
            .Caption   = "Fornecedor :"
            .Top       = 278
            .Left      = 47
            .Width     = 64
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        *-- getIfor -> txt_4c_Ifor (top=274, left=113, w=80, h=23)
        loc_oPg1.AddObject("txt_4c_Ifor", "TextBox")
        WITH loc_oPg1.txt_4c_Ifor
            .Value    = ""
            .Top      = 274
            .Left     = 113
            .Width    = 80
            .Height   = 23
            .FontName = "Tahoma"
            .FontSize = 8
            .Themes   = .F.
            .Visible  = .T.
        ENDWITH
        BINDEVENT(loc_oPg1.txt_4c_Ifor, "KeyPress", THIS, "DadosIforKeyPress")

        *-- getDfor -> txt_4c_Dfor (top=274, left=194, w=318, h=23) - somente leitura
        loc_oPg1.AddObject("txt_4c_Dfor", "TextBox")
        WITH loc_oPg1.txt_4c_Dfor
            .Value     = ""
            .Top       = 274
            .Left      = 194
            .Width     = 318
            .Height    = 23
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ReadOnly  = .T.
            .BackColor = RGB(240, 240, 240)
            .Themes    = .F.
            .Visible   = .T.
        ENDWITH

        *-- Label "Observacao:" (top=269, left=558, w=67)
        loc_oPg1.AddObject("lbl_4c_LblObs1", "Label")
        WITH loc_oPg1.lbl_4c_LblObs1
            .Caption   = "Observa" + CHR(231) + CHR(227) + "o :"
            .Top       = 269
            .Left      = 558
            .Width     = 67
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        *-- getObs1 -> txt_4c_Obs1 (top=265, left=626, w=220, h=21) -> obspeds
        loc_oPg1.AddObject("txt_4c_Obs1", "TextBox")
        WITH loc_oPg1.txt_4c_Obs1
            .Value    = ""
            .Top      = 265
            .Left     = 626
            .Width    = 220
            .Height   = 21
            .FontName = "Tahoma"
            .FontSize = 8
            .Themes   = .F.
            .Visible  = .T.
        ENDWITH

        *-- Label "Complemento:" (top=290, left=551, w=74)
        loc_oPg1.AddObject("lbl_4c_LblObs2", "Label")
        WITH loc_oPg1.lbl_4c_LblObs2
            .Caption   = "Complemento :"
            .Top       = 290
            .Left      = 551
            .Width     = 74
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        *-- getObs2 -> txt_4c_Obs2 (top=287, left=626, w=220, h=21) -> obspes
        loc_oPg1.AddObject("txt_4c_Obs2", "TextBox")
        WITH loc_oPg1.txt_4c_Obs2
            .Value    = ""
            .Top      = 287
            .Left     = 626
            .Width    = 220
            .Height   = 21
            .FontName = "Tahoma"
            .FontSize = 8
            .Themes   = .F.
            .Visible  = .T.
        ENDWITH

        *----------------------------------------------------------------------
        *-- ROW 8 (Top=298): Ref.Fornecedor + Cor + Tam
        *----------------------------------------------------------------------
        *-- Label "Ref. Fornecedor:" (top=301, left=23, w=88)
        loc_oPg1.AddObject("lbl_4c_LblRefs", "Label")
        WITH loc_oPg1.lbl_4c_LblRefs
            .Caption   = "Ref. Fornecedor :"
            .Top       = 301
            .Left      = 23
            .Width     = 88
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        *-- getRefs -> txt_4c_Refs (top=298, left=113, w=152, h=23)
        loc_oPg1.AddObject("txt_4c_Refs", "TextBox")
        WITH loc_oPg1.txt_4c_Refs
            .Value    = ""
            .Top      = 298
            .Left     = 113
            .Width    = 152
            .Height   = 23
            .FontName = "Tahoma"
            .FontSize = 8
            .Themes   = .F.
            .Visible  = .T.
        ENDWITH

        *-- Label "Padrao > Cor:" (top=302, left=323)
        loc_oPg1.AddObject("lbl_4c_LblCor", "Label")
        WITH loc_oPg1.lbl_4c_LblCor
            .Caption   = "Padr" + CHR(227) + "o > Cor :"
            .Top       = 302
            .Left      = 323
            .Width     = 75
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        *-- getCor -> txt_4c_Cor (top=298, left=401, w=38) -> codcors
        loc_oPg1.AddObject("txt_4c_Cor", "TextBox")
        WITH loc_oPg1.txt_4c_Cor
            .Value    = ""
            .Top      = 298
            .Left     = 401
            .Width    = 38
            .Height   = 23
            .FontName = "Tahoma"
            .FontSize = 8
            .Themes   = .F.
            .Visible  = .T.
        ENDWITH
        BINDEVENT(loc_oPg1.txt_4c_Cor, "KeyPress", THIS, "DadosCorKeyPress")

        *-- Label "Tam:" (top=302, left=442)
        loc_oPg1.AddObject("lbl_4c_LblTam", "Label")
        WITH loc_oPg1.lbl_4c_LblTam
            .Caption   = "Tam:"
            .Top       = 302
            .Left      = 442
            .Width     = 30
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        *-- getTam -> txt_4c_Tam (top=298, left=474, w=38) -> codtams
        loc_oPg1.AddObject("txt_4c_Tam", "TextBox")
        WITH loc_oPg1.txt_4c_Tam
            .Value    = ""
            .Top      = 298
            .Left     = 474
            .Width    = 38
            .Height   = 23
            .FontName = "Tahoma"
            .FontSize = 8
            .Themes   = .F.
            .Visible  = .T.
        ENDWITH
        BINDEVENT(loc_oPg1.txt_4c_Tam, "KeyPress", THIS, "DadosTamKeyPress")

        *----------------------------------------------------------------------
        *-- ROW 9 (Top=322): Modelo (getCodFinP)
        *----------------------------------------------------------------------
        *-- Label "Modelo:" (top=326, left=7, w=104)
        loc_oPg1.AddObject("lbl_4c_LblModelo", "Label")
        WITH loc_oPg1.lbl_4c_LblModelo
            .Caption   = "Modelo :"
            .Top       = 326
            .Left      = 7
            .Width     = 104
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        *-- getCodFinP -> txt_4c_CodFinP (top=322, left=113, w=31, h=23)
        loc_oPg1.AddObject("txt_4c_CodFinP", "TextBox")
        WITH loc_oPg1.txt_4c_CodFinP
            .Value    = ""
            .Top      = 322
            .Left     = 113
            .Width    = 31
            .Height   = 23
            .FontName = "Tahoma"
            .FontSize = 8
            .Themes   = .F.
            .Visible  = .T.
        ENDWITH
        BINDEVENT(loc_oPg1.txt_4c_CodFinP, "KeyPress", THIS, "DadosCodFinPKeyPress")

        *-- getDesFinP -> txt_4c_DesFinP (top=322, left=145, w=150, h=23) - somente leitura
        loc_oPg1.AddObject("txt_4c_DesFinP", "TextBox")
        WITH loc_oPg1.txt_4c_DesFinP
            .Value     = ""
            .Top       = 322
            .Left      = 145
            .Width     = 150
            .Height    = 23
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ReadOnly  = .T.
            .BackColor = RGB(240, 240, 240)
            .Themes    = .F.
            .Visible   = .T.
        ENDWITH

        *----------------------------------------------------------------------
        *-- ROW 10 (Top=346): Acabamento (get_codacb)
        *----------------------------------------------------------------------
        *-- Label "Acabamento:" (top=350, left=7, w=104)
        loc_oPg1.AddObject("lbl_4c_LblAcabamento", "Label")
        WITH loc_oPg1.lbl_4c_LblAcabamento
            .Caption   = "Acabamento :"
            .Top       = 350
            .Left      = 7
            .Width     = 104
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        *-- get_codacb -> txt_4c_Codacb (top=346, left=113, w=31, h=23) -> codacbs
        loc_oPg1.AddObject("txt_4c_Codacb", "TextBox")
        WITH loc_oPg1.txt_4c_Codacb
            .Value    = ""
            .Top      = 346
            .Left     = 113
            .Width    = 31
            .Height   = 23
            .FontName = "Tahoma"
            .FontSize = 8
            .Themes   = .F.
            .Visible  = .T.
        ENDWITH
        BINDEVENT(loc_oPg1.txt_4c_Codacb, "KeyPress", THIS, "DadosCodacbKeyPress")

        *-- get_Dacb -> txt_4c_Dacb (top=346, left=145, w=150, h=23) - somente leitura
        loc_oPg1.AddObject("txt_4c_Dacb", "TextBox")
        WITH loc_oPg1.txt_4c_Dacb
            .Value     = ""
            .Top       = 346
            .Left      = 145
            .Width     = 150
            .Height    = 23
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ReadOnly  = .T.
            .BackColor = RGB(240, 240, 240)
            .Themes    = .F.
            .Visible   = .T.
        ENDWITH

    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPgDados1b - Page1 dos Dados Internos (pgDados) - Parte 2/2
    * Campos: unidades, local, classe, precos, auditoria, dimensoes, checkboxes, memos
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPgDados1b()
        LOCAL loc_oPg1
        loc_oPg1 = THIS.pgf_4c_Paginas.Page2.pgf_4c_DadosInternos.Page1

        *----------------------------------------------------------------------
        *-- ROW 4 adicoes (Top=199-202): getConjunto + getQmin + CmdQtMin
        *----------------------------------------------------------------------
        *-- Label "Conjunto :" (top=206, left=408, w=53)
        loc_oPg1.AddObject("lbl_4c_LblConjunto", "Label")
        WITH loc_oPg1.lbl_4c_LblConjunto
            .Caption   = "Conjunto :"
            .Top       = 206
            .Left      = 408
            .Width     = 53
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        *-- getConjunto -> txt_4c_Conjunto (top=202, left=460, w=52, h=23)
        loc_oPg1.AddObject("txt_4c_Conjunto", "TextBox")
        WITH loc_oPg1.txt_4c_Conjunto
            .Value    = ""
            .Top      = 202
            .Left     = 460
            .Width    = 52
            .Height   = 23
            .FontName = "Tahoma"
            .FontSize = 8
            .Themes   = .F.
            .Visible  = .T.
        ENDWITH

        *-- Label "Qtde. Minima :" (top=203, left=553, w=72)
        loc_oPg1.AddObject("lbl_4c_LblQmin", "Label")
        WITH loc_oPg1.lbl_4c_LblQmin
            .Caption   = "Qtde. M" + CHR(237) + "nima :"
            .Top       = 203
            .Left      = 553
            .Width     = 72
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        *-- getQmin -> txt_4c_Qmin (top=199, left=626, w=80, h=21)
        loc_oPg1.AddObject("txt_4c_Qmin", "TextBox")
        WITH loc_oPg1.txt_4c_Qmin
            .Value    = 0.000
            .Top      = 199
            .Left     = 626
            .Width    = 80
            .Height   = 21
            .FontName = "Tahoma"
            .FontSize = 8
            .Themes   = .F.
            .Visible  = .T.
        ENDWITH

        *-- CmdQtMin -> cmd_4c_QtMin (top=199, left=709, w=25, h=23, caption=". . .")
        loc_oPg1.AddObject("cmd_4c_QtMin", "CommandButton")
        WITH loc_oPg1.cmd_4c_QtMin
            .Caption       = ". . ."
            .Top           = 199
            .Left          = 709
            .Width         = 25
            .Height        = 23
            .FontName      = "Tahoma"
            .FontSize      = 8
            .Themes        = .F.
            .SpecialEffect = 0
            .Visible       = .T.
        ENDWITH
        BINDEVENT(loc_oPg1.cmd_4c_QtMin, "Click", THIS, "CmdQtMinClick")

        *----------------------------------------------------------------------
        *-- ROW 5 adicoes (Top=221): getQtPed
        *----------------------------------------------------------------------
        *-- Label "Qtde. Pedido :" (top=225, left=553, w=72)
        loc_oPg1.AddObject("lbl_4c_LblQtPed", "Label")
        WITH loc_oPg1.lbl_4c_LblQtPed
            .Caption   = "Qtde. Pedido :"
            .Top       = 225
            .Left      = 553
            .Width     = 72
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        *-- getQtPed -> txt_4c_QtPed (top=221, left=626, w=80, h=21)
        loc_oPg1.AddObject("txt_4c_QtPed", "TextBox")
        WITH loc_oPg1.txt_4c_QtPed
            .Value    = 0.000
            .Top      = 221
            .Left     = 626
            .Width    = 80
            .Height   = 21
            .FontName = "Tahoma"
            .FontSize = 8
            .Themes   = .F.
            .Visible  = .T.
        ENDWITH

        *----------------------------------------------------------------------
        *-- DIMENSOES FISICAS - lado direito (left=923, top=247-335)
        *-- Campos: altura, largura, diametro, espessura, comprimento
        *----------------------------------------------------------------------
        *-- Label "Altura :" (top=474, left=749, w=38)
        loc_oPg1.AddObject("lbl_4c_LblAltura", "Label")
        WITH loc_oPg1.lbl_4c_LblAltura
            .Caption   = "Altura :"
            .Top       = 474
            .Left      = 749
            .Width     = 38
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        *-- getaltura -> txt_4c_Altura (top=471, left=793, w=48, h=21)
        loc_oPg1.AddObject("txt_4c_Altura", "TextBox")
        WITH loc_oPg1.txt_4c_Altura
            .Value    = 0.00
            .Top      = 471
            .Left     = 793
            .Width    = 48
            .Height   = 21
            .FontName = "Tahoma"
            .FontSize = 8
            .Themes   = .F.
            .Visible  = .T.
        ENDWITH

        *-- Label "MM" (top=475, left=845)
        loc_oPg1.AddObject("lbl_4c_LblAltMM", "Label")
        WITH loc_oPg1.lbl_4c_LblAltMM
            .Caption   = "MM"
            .Top       = 475
            .Left      = 845
            .Width     = 18
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        *-- Label "Largura :" (top=270, left=873, w=46)
        loc_oPg1.AddObject("lbl_4c_LblLargura", "Label")
        WITH loc_oPg1.lbl_4c_LblLargura
            .Caption   = "Largura :"
            .Top       = 270
            .Left      = 873
            .Width     = 46
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        *-- getlargura -> txt_4c_Largura (top=269, left=923, w=48, h=21)
        loc_oPg1.AddObject("txt_4c_Largura", "TextBox")
        WITH loc_oPg1.txt_4c_Largura
            .Value    = 0.00
            .Top      = 269
            .Left     = 923
            .Width    = 48
            .Height   = 21
            .FontName = "Tahoma"
            .FontSize = 8
            .Themes   = .F.
            .Visible  = .T.
        ENDWITH

        *-- Label "MM" (top=271, left=976)
        loc_oPg1.AddObject("lbl_4c_LblLarMM", "Label")
        WITH loc_oPg1.lbl_4c_LblLarMM
            .Caption   = "MM"
            .Top       = 271
            .Left      = 976
            .Width     = 18
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        *-- Label "Diametro :" (top=293, left=867, w=52)
        loc_oPg1.AddObject("lbl_4c_LblDiametro", "Label")
        WITH loc_oPg1.lbl_4c_LblDiametro
            .Caption   = "Di" + CHR(226) + "metro :"
            .Top       = 293
            .Left      = 867
            .Width     = 52
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        *-- getdiametro -> txt_4c_Diametro (top=291, left=923, w=48, h=21)
        loc_oPg1.AddObject("txt_4c_Diametro", "TextBox")
        WITH loc_oPg1.txt_4c_Diametro
            .Value    = 0.00
            .Top      = 291
            .Left     = 923
            .Width    = 48
            .Height   = 21
            .FontName = "Tahoma"
            .FontSize = 8
            .Themes   = .F.
            .Visible  = .T.
        ENDWITH

        *-- Label "MM" (top=294, left=976)
        loc_oPg1.AddObject("lbl_4c_LblDiaMM", "Label")
        WITH loc_oPg1.lbl_4c_LblDiaMM
            .Caption   = "MM"
            .Top       = 294
            .Left      = 976
            .Width     = 18
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        *-- Label "Espessura :" (top=316, left=861, w=58)
        loc_oPg1.AddObject("lbl_4c_LblEspessura", "Label")
        WITH loc_oPg1.lbl_4c_LblEspessura
            .Caption   = "Espessura :"
            .Top       = 316
            .Left      = 861
            .Width     = 58
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        *-- getespessura -> txt_4c_Espessura (top=313, left=923, w=48, h=21)
        loc_oPg1.AddObject("txt_4c_Espessura", "TextBox")
        WITH loc_oPg1.txt_4c_Espessura
            .Value    = 0.00
            .Top      = 313
            .Left     = 923
            .Width    = 48
            .Height   = 21
            .FontName = "Tahoma"
            .FontSize = 8
            .Themes   = .F.
            .Visible  = .T.
        ENDWITH

        *-- Label "MM" (top=317, left=976)
        loc_oPg1.AddObject("lbl_4c_LblEspMM", "Label")
        WITH loc_oPg1.lbl_4c_LblEspMM
            .Caption   = "MM"
            .Top       = 317
            .Left      = 976
            .Width     = 18
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        *-- Label "Comprimento :" (top=474, left=847, w=72)
        loc_oPg1.AddObject("lbl_4c_LblComprimento", "Label")
        WITH loc_oPg1.lbl_4c_LblComprimento
            .Caption   = "Comprimento :"
            .Top       = 474
            .Left      = 847
            .Width     = 72
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        *-- getcompriment -> txt_4c_Comprimento (top=471, left=923, w=48, h=21)
        loc_oPg1.AddObject("txt_4c_Comprimento", "TextBox")
        WITH loc_oPg1.txt_4c_Comprimento
            .Value    = 0.00
            .Top      = 471
            .Left     = 923
            .Width    = 48
            .Height   = 21
            .FontName = "Tahoma"
            .FontSize = 8
            .Themes   = .F.
            .Visible  = .T.
        ENDWITH

        *-- Label "CM" (top=340, left=976)
        loc_oPg1.AddObject("lbl_4c_LblCmpCM", "Label")
        WITH loc_oPg1.lbl_4c_LblCmpCM
            .Caption   = "CM"
            .Top       = 340
            .Left      = 976
            .Width     = 17
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        *----------------------------------------------------------------------
        *-- ROW 9 adicoes (Top=322): getPesoBs "Peso Bruto"
        *----------------------------------------------------------------------
        *-- Label "Peso Bruto :" (top=326, left=336, w=61)
        loc_oPg1.AddObject("lbl_4c_LblPesoBs", "Label")
        WITH loc_oPg1.lbl_4c_LblPesoBs
            .Caption   = "Peso Bruto :"
            .Top       = 326
            .Left      = 336
            .Width     = 61
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        *-- getPesoBs -> txt_4c_PesoBs (top=322, left=401, w=111, h=23)
        loc_oPg1.AddObject("txt_4c_PesoBs", "TextBox")
        WITH loc_oPg1.txt_4c_PesoBs
            .Value    = 0.000
            .Top      = 322
            .Left     = 401
            .Width    = 111
            .Height   = 23
            .FontName = "Tahoma"
            .FontSize = 8
            .Themes   = .F.
            .Visible  = .T.
        ENDWITH

        *----------------------------------------------------------------------
        *-- Ultima compra (read-only, Top=309-331)
        *----------------------------------------------------------------------
        *-- Label "Ult.Compra :" (top=313, left=562, w=63)
        loc_oPg1.AddObject("lbl_4c_LblUltCompra", "Label")
        WITH loc_oPg1.lbl_4c_LblUltCompra
            .Caption   = CHR(218) + "lt.Compra :"
            .Top       = 313
            .Left      = 562
            .Width     = 63
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        *-- get_Dtucp -> txt_4c_DtUltCompra (top=309, left=626, w=79, h=21) - read-only
        loc_oPg1.AddObject("txt_4c_DtUltCompra", "TextBox")
        WITH loc_oPg1.txt_4c_DtUltCompra
            .Value     = {^2000-01-01}
            .Format    = "D"
            .Top       = 309
            .Left      = 626
            .Width     = 79
            .Height    = 21
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ReadOnly  = .T.
            .BackColor = RGB(240, 240, 240)
            .Themes    = .F.
            .Visible   = .T.
        ENDWITH

        *-- Get_vucp -> txt_4c_VUltCompra (top=309, left=706, w=106, h=21) - read-only
        loc_oPg1.AddObject("txt_4c_VUltCompra", "TextBox")
        WITH loc_oPg1.txt_4c_VUltCompra
            .Value     = 0.00
            .Top       = 309
            .Left      = 706
            .Width     = 106
            .Height    = 21
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ReadOnly  = .T.
            .BackColor = RGB(240, 240, 240)
            .Themes    = .F.
            .Visible   = .T.
        ENDWITH

        *-- Get_mucp -> txt_4c_MUltCompra (top=309, left=813, w=33, h=21) - read-only
        loc_oPg1.AddObject("txt_4c_MUltCompra", "TextBox")
        WITH loc_oPg1.txt_4c_MUltCompra
            .Value     = ""
            .Top       = 309
            .Left      = 813
            .Width     = 33
            .Height    = 21
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ReadOnly  = .T.
            .BackColor = RGB(240, 240, 240)
            .Themes    = .F.
            .Visible   = .T.
        ENDWITH

        *-- Label "Qtde Ult.Compra :" (top=335, left=535, w=90)
        loc_oPg1.AddObject("lbl_4c_LblQUltComp", "Label")
        WITH loc_oPg1.lbl_4c_LblQUltComp
            .Caption   = "Qtde " + CHR(218) + "lt.Compra :"
            .Top       = 335
            .Left      = 535
            .Width     = 90
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        *-- Get_qtdultcomp -> txt_4c_QtdUltComp (top=331, left=626, w=79, h=21) - read-only
        loc_oPg1.AddObject("txt_4c_QtdUltComp", "TextBox")
        WITH loc_oPg1.txt_4c_QtdUltComp
            .Value     = 0.000
            .Top       = 331
            .Left      = 626
            .Width     = 79
            .Height    = 21
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ReadOnly  = .T.
            .BackColor = RGB(240, 240, 240)
            .Themes    = .F.
            .Visible   = .T.
        ENDWITH

        *----------------------------------------------------------------------
        *-- ROW 10 adicoes (Top=346): getPmedio "Peso Liquido"
        *----------------------------------------------------------------------
        *-- Label "Peso Liquido :" (top=350, left=329, w=68)
        loc_oPg1.AddObject("lbl_4c_LblPesoMs", "Label")
        WITH loc_oPg1.lbl_4c_LblPesoMs
            .Caption   = "Peso L" + CHR(237) + "quido :"
            .Top       = 350
            .Left      = 329
            .Width     = 68
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        *-- getPmedio -> txt_4c_Pmedio (top=346, left=401, w=111, h=23)
        loc_oPg1.AddObject("txt_4c_Pmedio", "TextBox")
        WITH loc_oPg1.txt_4c_Pmedio
            .Value    = 0.000
            .Top      = 346
            .Left     = 401
            .Width    = 111
            .Height   = 23
            .FontName = "Tahoma"
            .FontSize = 8
            .Themes   = .F.
            .Visible  = .T.
        ENDWITH

        *----------------------------------------------------------------------
        *-- Estoque (read-only, Top=353)
        *----------------------------------------------------------------------
        *-- Label "Estoque :" (top=357, left=577, w=48)
        loc_oPg1.AddObject("lbl_4c_LblEstoque", "Label")
        WITH loc_oPg1.lbl_4c_LblEstoque
            .Caption   = "Estoque :"
            .Top       = 357
            .Left      = 577
            .Width     = 48
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        *-- getEstoques -> txt_4c_Estoques (top=353, left=626, w=79, h=21) - read-only
        loc_oPg1.AddObject("txt_4c_Estoques", "TextBox")
        WITH loc_oPg1.txt_4c_Estoques
            .Value     = ""
            .Top       = 353
            .Left      = 626
            .Width     = 79
            .Height    = 21
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ReadOnly  = .T.
            .BackColor = RGB(240, 240, 240)
            .Themes    = .F.
            .Visible   = .T.
        ENDWITH

        *-- getQtdEsts -> txt_4c_QtdEsts (top=353, left=706, w=79, h=21) - read-only
        loc_oPg1.AddObject("txt_4c_QtdEsts", "TextBox")
        WITH loc_oPg1.txt_4c_QtdEsts
            .Value     = 0.000
            .Top       = 353
            .Left      = 706
            .Width     = 79
            .Height    = 21
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ReadOnly  = .T.
            .BackColor = RGB(240, 240, 240)
            .Themes    = .F.
            .Visible   = .T.
        ENDWITH

        *----------------------------------------------------------------------
        *-- ROW 11 - NEW (Top=370): Classificacao + Local
        *----------------------------------------------------------------------
        *-- Label "Classificacao :" (top=374, left=7, w=104)
        loc_oPg1.AddObject("lbl_4c_LblClass", "Label")
        WITH loc_oPg1.lbl_4c_LblClass
            .Caption   = "Classifica" + CHR(231) + CHR(227) + "o :"
            .Top       = 374
            .Left      = 7
            .Width     = 104
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        *-- Get_Class -> txt_4c_Class (top=370, left=113, w=31, h=23) -> SigCdCls: cods/descs
        loc_oPg1.AddObject("txt_4c_Class", "TextBox")
        WITH loc_oPg1.txt_4c_Class
            .Value    = ""
            .Top      = 370
            .Left     = 113
            .Width    = 31
            .Height   = 23
            .FontName = "Tahoma"
            .FontSize = 8
            .Themes   = .F.
            .Visible  = .T.
        ENDWITH
        BINDEVENT(loc_oPg1.txt_4c_Class, "KeyPress", THIS, "DadosClassKeyPress")

        *-- Get_DClass -> txt_4c_DClass (top=370, left=145, w=150, h=23) - somente leitura
        loc_oPg1.AddObject("txt_4c_DClass", "TextBox")
        WITH loc_oPg1.txt_4c_DClass
            .Value     = ""
            .Top       = 370
            .Left      = 145
            .Width     = 150
            .Height    = 23
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ReadOnly  = .T.
            .BackColor = RGB(240, 240, 240)
            .Themes    = .F.
            .Visible   = .T.
        ENDWITH

        *-- Label "Local :" (top=374, left=364, w=33)
        loc_oPg1.AddObject("lbl_4c_LblLocal", "Label")
        WITH loc_oPg1.lbl_4c_LblLocal
            .Caption   = "Local :"
            .Top       = 374
            .Left      = 364
            .Width     = 33
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        *-- Get_Local -> txt_4c_Local (top=370, left=401, w=111, h=23) -> SigPrLcl: codigos/descricaos
        loc_oPg1.AddObject("txt_4c_Local", "TextBox")
        WITH loc_oPg1.txt_4c_Local
            .Value    = ""
            .Top      = 370
            .Left     = 401
            .Width    = 111
            .Height   = 23
            .FontName = "Tahoma"
            .FontSize = 8
            .Themes   = .F.
            .Visible  = .T.
        ENDWITH
        BINDEVENT(loc_oPg1.txt_4c_Local, "KeyPress", THIS, "DadosLocalKeyPress")

        *----------------------------------------------------------------------
        *-- PRECOS E CUSTOS (Top=375-419) - direita
        *-- Custo total (top=375): getCtotal + getMctotal
        *-- Preco venda (top=397): getPvenda + getMpvenda
        *-- Fator venda (top=419): getFvenda + getMfvenda
        *----------------------------------------------------------------------
        *-- Label "Valor de Custo :" (top=379, left=546, w=79)
        loc_oPg1.AddObject("lbl_4c_LblCtotal", "Label")
        WITH loc_oPg1.lbl_4c_LblCtotal
            .Caption   = "Valor de Custo :"
            .Top       = 379
            .Left      = 546
            .Width     = 79
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        *-- getCtotal -> txt_4c_Ctotal (top=375, left=626, w=127, h=21) - read-only
        loc_oPg1.AddObject("txt_4c_Ctotal", "TextBox")
        WITH loc_oPg1.txt_4c_Ctotal
            .Value     = 0.00000
            .Top       = 375
            .Left      = 626
            .Width     = 127
            .Height    = 21
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ReadOnly  = .T.
            .BackColor = RGB(240, 240, 240)
            .Themes    = .F.
            .Visible   = .T.
        ENDWITH

        *-- getMctotal -> txt_4c_Mctotal (top=375, left=754, w=31, h=21) -> SigCdMoe: cmoes/dmoes
        loc_oPg1.AddObject("txt_4c_Mctotal", "TextBox")
        WITH loc_oPg1.txt_4c_Mctotal
            .Value    = ""
            .Top      = 375
            .Left     = 754
            .Width    = 31
            .Height   = 21
            .FontName = "Tahoma"
            .FontSize = 8
            .Themes   = .F.
            .Visible  = .T.
        ENDWITH
        BINDEVENT(loc_oPg1.txt_4c_Mctotal, "KeyPress", THIS, "DadosMctotalKeyPress")

        *-- Label "Valor de Venda :" (top=400, left=505, w=120)
        loc_oPg1.AddObject("lbl_4c_LblPvenda", "Label")
        WITH loc_oPg1.lbl_4c_LblPvenda
            .Caption   = "Valor de Venda :"
            .Top       = 400
            .Left      = 505
            .Width     = 120
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        *-- getPvenda -> txt_4c_Pvenda (top=397, left=626, w=127, h=21)
        loc_oPg1.AddObject("txt_4c_Pvenda", "TextBox")
        WITH loc_oPg1.txt_4c_Pvenda
            .Value    = 0.00000
            .Top      = 397
            .Left     = 626
            .Width    = 127
            .Height   = 21
            .FontName = "Tahoma"
            .FontSize = 8
            .Themes   = .F.
            .Visible  = .T.
        ENDWITH

        *-- getMpvenda -> txt_4c_Mpvenda (top=397, left=754, w=31, h=21) -> SigCdMoe
        loc_oPg1.AddObject("txt_4c_Mpvenda", "TextBox")
        WITH loc_oPg1.txt_4c_Mpvenda
            .Value    = ""
            .Top      = 397
            .Left     = 754
            .Width    = 31
            .Height   = 21
            .FontName = "Tahoma"
            .FontSize = 8
            .Themes   = .F.
            .Visible  = .T.
        ENDWITH
        BINDEVENT(loc_oPg1.txt_4c_Mpvenda, "KeyPress", THIS, "DadosMpvendaKeyPress")

        *-- Label "Fator de Venda :" (top=422, left=539, w=86)
        loc_oPg1.AddObject("lbl_4c_LblFvenda", "Label")
        WITH loc_oPg1.lbl_4c_LblFvenda
            .Caption   = "Fator  de Venda :"
            .Top       = 422
            .Left      = 539
            .Width     = 86
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        *-- getFvenda -> txt_4c_Fvenda (top=419, left=626, w=127, h=21)
        loc_oPg1.AddObject("txt_4c_Fvenda", "TextBox")
        WITH loc_oPg1.txt_4c_Fvenda
            .Value    = 1.000
            .Top      = 419
            .Left     = 626
            .Width    = 127
            .Height   = 21
            .FontName = "Tahoma"
            .FontSize = 8
            .Themes   = .F.
            .Visible  = .T.
        ENDWITH

        *-- getMfvenda -> txt_4c_Mfvenda (top=419, left=754, w=31, h=21) -> SigCdMoe
        loc_oPg1.AddObject("txt_4c_Mfvenda", "TextBox")
        WITH loc_oPg1.txt_4c_Mfvenda
            .Value    = ""
            .Top      = 419
            .Left     = 754
            .Width    = 31
            .Height   = 21
            .FontName = "Tahoma"
            .FontSize = 8
            .Themes   = .F.
            .Visible  = .T.
        ENDWITH
        BINDEVENT(loc_oPg1.txt_4c_Mfvenda, "KeyPress", THIS, "DadosMfvendaKeyPress")

        *----------------------------------------------------------------------
        *-- ROW 12 - NEW (Top=394): Unidade (1) + Unidade (2)
        *----------------------------------------------------------------------
        *-- Label "Unidades (1) :" (top=398, left=41, w=70)
        loc_oPg1.AddObject("lbl_4c_LblCuni", "Label")
        WITH loc_oPg1.lbl_4c_LblCuni
            .Caption   = "Unidades (1) :"
            .Top       = 398
            .Left      = 41
            .Width     = 70
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        *-- Get_Cuni -> txt_4c_Cuni (top=394, left=113, w=31, h=23) -> SigCdUni: CUnis/DUnis
        loc_oPg1.AddObject("txt_4c_Cuni", "TextBox")
        WITH loc_oPg1.txt_4c_Cuni
            .Value    = ""
            .Top      = 394
            .Left     = 113
            .Width    = 31
            .Height   = 23
            .FontName = "Tahoma"
            .FontSize = 8
            .Themes   = .F.
            .Visible  = .T.
        ENDWITH
        BINDEVENT(loc_oPg1.txt_4c_Cuni, "KeyPress", THIS, "DadosCuniKeyPress")

        *-- Get_Duni -> txt_4c_Duni (top=394, left=145, w=150, h=23) - somente leitura
        loc_oPg1.AddObject("txt_4c_Duni", "TextBox")
        WITH loc_oPg1.txt_4c_Duni
            .Value     = ""
            .Top       = 394
            .Left      = 145
            .Width     = 150
            .Height    = 23
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ReadOnly  = .T.
            .BackColor = RGB(240, 240, 240)
            .Themes    = .F.
            .Visible   = .T.
        ENDWITH

        *-- Label "(2) :" (top=398, left=301, w=23)
        loc_oPg1.AddObject("lbl_4c_LblCunip", "Label")
        WITH loc_oPg1.lbl_4c_LblCunip
            .Caption   = "(2) :"
            .Top       = 398
            .Left      = 301
            .Width     = 23
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        *-- Get_cunip -> txt_4c_Cunip (top=394, left=330, w=31, h=23) -> SigCdUni
        loc_oPg1.AddObject("txt_4c_Cunip", "TextBox")
        WITH loc_oPg1.txt_4c_Cunip
            .Value    = ""
            .Top      = 394
            .Left     = 330
            .Width    = 31
            .Height   = 23
            .FontName = "Tahoma"
            .FontSize = 8
            .Themes   = .F.
            .Visible  = .T.
        ENDWITH
        BINDEVENT(loc_oPg1.txt_4c_Cunip, "KeyPress", THIS, "DadosCunipKeyPress")

        *-- get_dunip -> txt_4c_Dunip (top=394, left=362, w=150, h=23) - somente leitura
        loc_oPg1.AddObject("txt_4c_Dunip", "TextBox")
        WITH loc_oPg1.txt_4c_Dunip
            .Value     = ""
            .Top       = 394
            .Left      = 362
            .Width     = 150
            .Height    = 23
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ReadOnly  = .T.
            .BackColor = RGB(240, 240, 240)
            .Themes    = .F.
            .Visible   = .T.
        ENDWITH

        *----------------------------------------------------------------------
        *-- AUDITORIA (read-only, Top=397-419): DtIncs/Usuario/DataAlts/UsuaAlts
        *----------------------------------------------------------------------
        *-- Label "Data / Usuario" (top=365, left=833, w=84)
        loc_oPg1.AddObject("lbl_4c_LblDtUsu", "Label")
        WITH loc_oPg1.lbl_4c_LblDtUsu
            .Caption   = "Data / Usu" + CHR(225) + "rio"
            .Top       = 365
            .Left      = 833
            .Width     = 84
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        *-- Label "Inclusao" (top=384, left=833, w=42)
        loc_oPg1.AddObject("lbl_4c_LblIncs", "Label")
        WITH loc_oPg1.lbl_4c_LblIncs
            .Caption   = "Inclus" + CHR(227) + "o"
            .Top       = 384
            .Left      = 833
            .Width     = 42
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        *-- Label "Alteracao" (top=384, left=914, w=48)
        loc_oPg1.AddObject("lbl_4c_LblAlts", "Label")
        WITH loc_oPg1.lbl_4c_LblAlts
            .Caption   = "Altera" + CHR(231) + CHR(227) + "o"
            .Top       = 384
            .Left      = 914
            .Width     = 48
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        *-- Get_DtIncs -> txt_4c_DtIncs (top=397, left=833, w=79, h=21) - read-only
        loc_oPg1.AddObject("txt_4c_DtIncs", "TextBox")
        WITH loc_oPg1.txt_4c_DtIncs
            .Value     = {^2000-01-01}
            .Format    = "D"
            .Top       = 397
            .Left      = 833
            .Width     = 79
            .Height    = 21
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ReadOnly  = .T.
            .BackColor = RGB(240, 240, 240)
            .Themes    = .F.
            .Visible   = .T.
        ENDWITH

        *-- getDataAlts -> txt_4c_DataAlts (top=397, left=914, w=79, h=21) - read-only
        loc_oPg1.AddObject("txt_4c_DataAlts", "TextBox")
        WITH loc_oPg1.txt_4c_DataAlts
            .Value     = {^2000-01-01}
            .Format    = "D"
            .Top       = 397
            .Left      = 914
            .Width     = 79
            .Height    = 21
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ReadOnly  = .T.
            .BackColor = RGB(240, 240, 240)
            .Themes    = .F.
            .Visible   = .T.
        ENDWITH

        *-- Get_Usuario -> txt_4c_UsuIncs (top=419, left=833, w=79, h=21) - read-only
        loc_oPg1.AddObject("txt_4c_UsuIncs", "TextBox")
        WITH loc_oPg1.txt_4c_UsuIncs
            .Value     = ""
            .Top       = 419
            .Left      = 833
            .Width     = 79
            .Height    = 21
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ReadOnly  = .T.
            .BackColor = RGB(240, 240, 240)
            .Themes    = .F.
            .Visible   = .T.
        ENDWITH

        *-- getUsuaAlts -> txt_4c_UsuAlts (top=419, left=914, w=79, h=21) - read-only
        loc_oPg1.AddObject("txt_4c_UsuAlts", "TextBox")
        WITH loc_oPg1.txt_4c_UsuAlts
            .Value     = ""
            .Top       = 419
            .Left      = 914
            .Width     = 79
            .Height    = 21
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ReadOnly  = .T.
            .BackColor = RGB(240, 240, 240)
            .Themes    = .F.
            .Visible   = .T.
        ENDWITH

        *----------------------------------------------------------------------
        *-- ROW 13 - Cod. Identidade (read-only, Top=418)
        *----------------------------------------------------------------------
        *-- Label "Cod. Identidade :" (top=422, left=24, w=87)
        loc_oPg1.AddObject("lbl_4c_LblCodIdent", "Label")
        WITH loc_oPg1.lbl_4c_LblCodIdent
            .Caption   = "Cod. Identidade :"
            .Top       = 422
            .Left      = 24
            .Width     = 87
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        *-- GetCodIdent -> txt_4c_CodIdent (top=418, left=113, w=182, h=23) - read-only
        loc_oPg1.AddObject("txt_4c_CodIdent", "TextBox")
        WITH loc_oPg1.txt_4c_CodIdent
            .Value     = ""
            .Top       = 418
            .Left      = 113
            .Width     = 182
            .Height    = 23
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ReadOnly  = .T.
            .BackColor = RGB(240, 240, 240)
            .Themes    = .F.
            .Visible   = .T.
        ENDWITH

        *----------------------------------------------------------------------
        *-- CHECKBOXES situacao produto (Top=451)
        *-- Situacao: Consigna + Fabr.Propria + Encomenda
        *----------------------------------------------------------------------
        *-- Label "Situacao :" (top=451, left=548, w=50)
        loc_oPg1.AddObject("lbl_4c_LblSitProd", "Label")
        WITH loc_oPg1.lbl_4c_LblSitProd
            .Caption   = "Situa" + CHR(231) + CHR(227) + "o :"
            .Top       = 451
            .Left      = 548
            .Width     = 50
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        *-- get_Consig -> chk_4c_Consig (top=451, left=601, caption="Consigna")
        loc_oPg1.AddObject("chk_4c_Consig", "CheckBox")
        WITH loc_oPg1.chk_4c_Consig
            .Caption   = "Consigna"
            .Value     = 0
            .Top       = 451
            .Left      = 601
            .Width     = 75
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Themes    = .F.
            .Visible   = .T.
        ENDWITH

        *-- chkFabrProprs -> chk_4c_FabrProprs (top=451, left=681, caption="Fabr. Propria")
        loc_oPg1.AddObject("chk_4c_FabrProprs", "CheckBox")
        WITH loc_oPg1.chk_4c_FabrProprs
            .Caption   = "Fabr. Pr" + CHR(243) + "pria"
            .Value     = 0
            .Top       = 451
            .Left      = 681
            .Width     = 90
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Themes    = .F.
            .Visible   = .T.
        ENDWITH

        *-- chkEncoms -> chk_4c_Encoms (top=451, left=781, caption="Encomenda")
        loc_oPg1.AddObject("chk_4c_Encoms", "CheckBox")
        WITH loc_oPg1.chk_4c_Encoms
            .Caption   = "Encomenda"
            .Value     = 0
            .Top       = 451
            .Left      = 781
            .Width     = 85
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Themes    = .F.
            .Visible   = .T.
        ENDWITH

        *----------------------------------------------------------------------
        *-- DIMENSOES CAIXA + VOLUMES (Top=470) e getTEnts (Top=447)
        *-- fwget3=Volumes, fwget4=Comprimento, fwget5=Profundidade, fwget6=Largura
        *----------------------------------------------------------------------
        *-- getTEnts -> txt_4c_TEnts (top=447, left=934, w=31, h=22) - read-only
        loc_oPg1.AddObject("txt_4c_TEnts", "TextBox")
        WITH loc_oPg1.txt_4c_TEnts
            .Value     = 0
            .Top       = 447
            .Left      = 934
            .Width     = 31
            .Height    = 22
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ReadOnly  = .T.
            .BackColor = RGB(240, 240, 240)
            .Themes    = .F.
            .Visible   = .T.
        ENDWITH

        *-- Label "Dimensao :" (top=474, left=543, w=55)
        loc_oPg1.AddObject("lbl_4c_LblDimCaixa", "Label")
        WITH loc_oPg1.lbl_4c_LblDimCaixa
            .Caption   = "Dimens" + CHR(227) + "o :"
            .Top       = 474
            .Left      = 543
            .Width     = 55
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        *-- fwget6 -> txt_4c_DimLarg (top=470, left=601, w=58) - Largura caixa
        loc_oPg1.AddObject("txt_4c_DimLarg", "TextBox")
        WITH loc_oPg1.txt_4c_DimLarg
            .Value    = 0.00
            .Top      = 470
            .Left     = 601
            .Width    = 58
            .Height   = 23
            .FontName = "Tahoma"
            .FontSize = 8
            .Themes   = .F.
            .Visible  = .T.
        ENDWITH

        *-- Label "ppp" profundidade (top=474, left=661)
        loc_oPg1.AddObject("lbl_4c_LblPpp", "Label")
        WITH loc_oPg1.lbl_4c_LblPpp
            .Caption   = "ppp"
            .Top       = 474
            .Left      = 661
            .Width     = 20
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        *-- fwget5 -> txt_4c_DimProf (top=470, left=688, w=58) - Profundidade caixa
        loc_oPg1.AddObject("txt_4c_DimProf", "TextBox")
        WITH loc_oPg1.txt_4c_DimProf
            .Value    = 0.00
            .Top      = 470
            .Left     = 688
            .Width    = 58
            .Height   = 23
            .FontName = "Tahoma"
            .FontSize = 8
            .Themes   = .F.
            .Visible  = .T.
        ENDWITH

        *-- Label "aaa" altura caixa (top=474, left=749)
        loc_oPg1.AddObject("lbl_4c_LblAaa", "Label")
        WITH loc_oPg1.lbl_4c_LblAaa
            .Caption   = "aaa"
            .Top       = 474
            .Left      = 749
            .Width     = 20
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        *-- fwget4 -> txt_4c_DimAltura (top=470, left=776, w=58) - Altura caixa
        loc_oPg1.AddObject("txt_4c_DimAltura", "TextBox")
        WITH loc_oPg1.txt_4c_DimAltura
            .Value    = 0.00
            .Top      = 470
            .Left     = 776
            .Width    = 58
            .Height   = 23
            .FontName = "Tahoma"
            .FontSize = 8
            .Themes   = .F.
            .Visible  = .T.
        ENDWITH

        *-- Label "ccc" comprimento caixa (top=474, left=836)
        loc_oPg1.AddObject("lbl_4c_LblCcc", "Label")
        WITH loc_oPg1.lbl_4c_LblCcc
            .Caption   = "ccc"
            .Top       = 474
            .Left      = 836
            .Width     = 17
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        *-- Label "Volumes :" (top=474, left=883, w=48)
        loc_oPg1.AddObject("lbl_4c_LblVolumes", "Label")
        WITH loc_oPg1.lbl_4c_LblVolumes
            .Caption   = "Volumes :"
            .Top       = 474
            .Left      = 883
            .Width     = 48
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        *-- fwget3 -> txt_4c_Volumes (top=470, left=934, w=31, h=23) - Volumes
        loc_oPg1.AddObject("txt_4c_Volumes", "TextBox")
        WITH loc_oPg1.txt_4c_Volumes
            .Value    = 0
            .Top      = 470
            .Left     = 934
            .Width    = 31
            .Height   = 23
            .FontName = "Tahoma"
            .FontSize = 8
            .Themes   = .F.
            .Visible  = .T.
        ENDWITH

        *----------------------------------------------------------------------
        *-- MEMO FIELDS (EditBox) - parte inferior
        *----------------------------------------------------------------------
        *-- Label "Descricao de : Compra ." (top=448, left=23, w=88)
        loc_oPg1.AddObject("lbl_4c_LblDscCompras", "Label")
        WITH loc_oPg1.lbl_4c_LblDscCompras
            .Caption   = "Descri" + CHR(231) + CHR(227) + "o de : Compra ."
            .Top       = 452
            .Left      = 23
            .Width     = 88
            .Height    = 28
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        *-- getdsccompras -> edt_4c_DscCompras (EditBox, top=448, left=113, w=400, h=58)
        loc_oPg1.AddObject("edt_4c_DscCompras", "EditBox")
        WITH loc_oPg1.edt_4c_DscCompras
            .Value    = ""
            .Top      = 448
            .Left     = 113
            .Width    = 400
            .Height   = 58
            .FontName = "Tahoma"
            .FontSize = 8
            .Themes   = .F.
            .Visible  = .T.
        ENDWITH

        *-- Label "Descricao : Completa ." (top=507, left=23, w=88)
        loc_oPg1.AddObject("lbl_4c_LblDPro3s", "Label")
        WITH loc_oPg1.lbl_4c_LblDPro3s
            .Caption   = "Descri" + CHR(231) + CHR(227) + "o : Completa ."
            .Top       = 511
            .Left      = 23
            .Width     = 88
            .Height    = 28
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        *-- getDPro3s -> edt_4c_DPro3s (EditBox, top=507, left=113, w=400, h=58)
        loc_oPg1.AddObject("edt_4c_DPro3s", "EditBox")
        WITH loc_oPg1.edt_4c_DPro3s
            .Value    = ""
            .Top      = 507
            .Left     = 113
            .Width    = 400
            .Height   = 58
            .FontName = "Tahoma"
            .FontSize = 8
            .Themes   = .F.
            .Visible  = .T.
        ENDWITH

        *-- Label "Observacao : da Compra ." (top=566, left=23, w=88)
        loc_oPg1.AddObject("lbl_4c_LblObsCompras", "Label")
        WITH loc_oPg1.lbl_4c_LblObsCompras
            .Caption   = "Observa" + CHR(231) + CHR(227) + "o : da  Compra ."
            .Top       = 570
            .Left      = 23
            .Width     = 88
            .Height    = 28
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        *-- getObsCompras -> edt_4c_ObsCompras (EditBox, top=566, left=113, w=400, h=58)
        loc_oPg1.AddObject("edt_4c_ObsCompras", "EditBox")
        WITH loc_oPg1.edt_4c_ObsCompras
            .Value    = ""
            .Top      = 566
            .Left     = 113
            .Width    = 400
            .Height   = 58
            .FontName = "Tahoma"
            .FontSize = 8
            .Themes   = .F.
            .Visible  = .T.
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * NavegacaoDadosChange - Troca sub-pagina ativa via OptionGroup (BINDEVENT)
    * Mapeamento: Value 1=Dados(p1), 2=Componente(p2), 3=Fiscal(p3),
    *             4=Processo(p4), 5=Consumo(p5), 6=Custo(p6), 7=Designer(p7)
    * NOTA: Legado mapeava Value=3 -> pgCusto(PageOrder=6), Value=4 -> pgDadosFiscais(3)
    *       Aqui os botoes foram reordenados para sequencia logica (1..7 = pagina 1..7)
    *--------------------------------------------------------------------------
    PROCEDURE NavegacaoDadosChange()
        LOCAL loc_nValor, loc_nPagina
        loc_nValor  = THIS.pgf_4c_Paginas.Page2.obj_4c_NavegacaoDados.Value
        loc_nPagina = 1

        DO CASE
            CASE loc_nValor = 1    && Principal -> pgDados (PageOrder=1)
                loc_nPagina = 1
            CASE loc_nValor = 2    && Componente -> pgComposicao (PageOrder=2)
                loc_nPagina = 2
            CASE loc_nValor = 3    && Fiscal -> pgDadosFiscais (PageOrder=3)
                loc_nPagina = 3
            CASE loc_nValor = 4    && Processo -> PgDadosFaseP (PageOrder=4)
                loc_nPagina = 4
            CASE loc_nValor = 5    && Consumo -> PgDadosConsP (PageOrder=5)
                loc_nPagina = 5
            CASE loc_nValor = 6    && Custo -> pgCusto (PageOrder=6)
                loc_nPagina = 6
            CASE loc_nValor = 7    && Designer -> pgDesigner (PageOrder=7)
                loc_nPagina = 7
        ENDCASE

        THIS.pgf_4c_Paginas.Page2.pgf_4c_DadosInternos.ActivePage = loc_nPagina
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarLista - Carrega grid da pagina Lista com dados do SQL Server
    * Filtros: getCgru (grupo), getDtIni/getDtFim (DataAlts), optFilSituas (Situas)
    * Situacao: Situas=1 Ativo(verde/preto), Situas=2 Inativo(vermelho)
    * Padrao SQLEXEC: query em temp ? ZAP cursor_4c_Lista ? APPEND FROM DBF
    *--------------------------------------------------------------------------
    PROCEDURE CarregarLista()
        LOCAL loc_lSucesso, loc_cSQL, loc_nResult, loc_cCgru, loc_dIni, loc_dFim
        LOCAL loc_nStI, loc_nStF, loc_cFiltroGrupo, loc_cFiltroSitua, loc_oGrid, loc_oPg1
        LOCAL loc_aErros(1)
        loc_lSucesso = .F.

        TRY
            IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
                loc_lSucesso = .T.
            ELSE
                loc_oPg1 = THIS.pgf_4c_Paginas.Page1

                *-- Ler filtros com defaults seguros
                loc_cCgru = ""
                loc_dIni  = {^1900-01-01}
                loc_dFim  = {^2900-12-31}
                loc_nStI  = 1
                loc_nStF  = 2

                IF PEMSTATUS(loc_oPg1, "cnt_4c_Filtros", 5)
                    IF PEMSTATUS(loc_oPg1.cnt_4c_Filtros, "txt_4c_Cgru", 5)
                        loc_cCgru = ALLTRIM(loc_oPg1.cnt_4c_Filtros.txt_4c_Cgru.Value)
                    ENDIF
                    IF PEMSTATUS(loc_oPg1.cnt_4c_Filtros, "txt_4c_DtIni", 5)
                        IF !EMPTY(loc_oPg1.cnt_4c_Filtros.txt_4c_DtIni.Value)
                            loc_dIni = loc_oPg1.cnt_4c_Filtros.txt_4c_DtIni.Value
                        ENDIF
                    ENDIF
                    IF PEMSTATUS(loc_oPg1.cnt_4c_Filtros, "txt_4c_DtFim", 5)
                        IF !EMPTY(loc_oPg1.cnt_4c_Filtros.txt_4c_DtFim.Value)
                            loc_dFim = loc_oPg1.cnt_4c_Filtros.txt_4c_DtFim.Value
                        ENDIF
                    ENDIF
                    IF PEMSTATUS(loc_oPg1.cnt_4c_Filtros, "obj_4c_Situa", 5)
                        LOCAL loc_nSitua
                        loc_nSitua = loc_oPg1.cnt_4c_Filtros.obj_4c_Situa.Value
                        *-- Value=1 Todos: IN(1,2) | Value=2 Ativos: IN(1,1) | Value=3 Inativos: IN(2,2)
                        loc_nStI = IIF(loc_nSitua = 3, 2, 1)
                        loc_nStF = IIF(loc_nSitua = 2, 1, 2)
                    ENDIF
                ENDIF

                *-- Filtro grupo (opcional - se vazio carrega todos)
                loc_cFiltroGrupo = ""
                IF !EMPTY(loc_cCgru)
                    loc_cFiltroGrupo = " AND CGrus = " + EscaparSQL(PADR(loc_cCgru, 3))
                ENDIF

                *-- Filtro situacao: Situas IN (loc_nStI, loc_nStF)
                loc_cFiltroSitua = " AND ISNULL(Situas, 1) IN (" + ;
                    TRANSFORM(loc_nStI) + "," + TRANSFORM(loc_nStF) + ")"

                *-- Montar SQL com ISNULL para campos potencialmente nulos
                loc_cSQL = "SELECT " + ;
                    "ISNULL(CPros,'') AS cpros, " + ;
                    "ISNULL(DPros,'') AS dpros, " + ;
                    "ISNULL(CGrus,'') AS cgrus, " + ;
                    "ISNULL(SGrus,'') AS sgrus, " + ;
                    "ISNULL(Reffs,'') AS reffs, " + ;
                    "ISNULL(Colecoes,'') AS colecoes, " + ;
                    "CAST(ISNULL(ImpEtiqs,0) AS BIT) AS ImpEtiqs, " + ;
                    "ISNULL(Situas,1) AS Situas " + ;
                    "FROM SigCdPro " + ;
                    "WHERE CONVERT(date, ISNULL(DataAlts,'19000101')) >= " + FormatarDataSQL(loc_dIni) + ;
                    " AND CONVERT(date, ISNULL(DataAlts,'19000101')) <= " + FormatarDataSQL(loc_dFim) + ;
                    loc_cFiltroGrupo + loc_cFiltroSitua + ;
                    " ORDER BY CPros"

                *-- Executar query em cursor temporario
                IF USED("cursor_4c_Temp_Pro")
                    USE IN cursor_4c_Temp_Pro
                ENDIF
                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Temp_Pro")

                IF loc_nResult > 0
                    *-- ZAP + APPEND mantem RecordSource do grid intacto (nao destroi colunas)
                    SELECT cursor_4c_Lista
                    ZAP
                    IF RECCOUNT("cursor_4c_Temp_Pro") > 0
                        APPEND FROM DBF("cursor_4c_Temp_Pro")
                    ENDIF
                    IF USED("cursor_4c_Temp_Pro")
                        USE IN cursor_4c_Temp_Pro
                    ENDIF
                    GO TOP IN cursor_4c_Lista
                ELSE
                    AERROR(loc_aErros)
                    MsgErro("Erro ao consultar produtos:" + CHR(13) + ;
                        TRANSFORM(loc_aErros(1, 2)), "Erro SQL")
                    IF USED("cursor_4c_Temp_Pro")
                        USE IN cursor_4c_Temp_Pro
                    ENDIF
                ENDIF

                *-- Atualizar contador
                IF PEMSTATUS(loc_oPg1, "lbl_4c_Contador", 5)
                    loc_oPg1.lbl_4c_Contador.Caption = "Produtos Selecionados : " + ;
                        TRANSFORM(RECCOUNT("cursor_4c_Lista"))
                ENDIF

                *-- Refresh grid
                loc_oGrid = loc_oPg1.grd_4c_Lista
                IF PEMSTATUS(loc_oGrid, "Refresh", 5)
                    loc_oGrid.Refresh()
                ENDIF

                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao carregar lista de produtos:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * BOParaForm - Transfere dados do BO para os campos do formulario
    * FASE 5: Implementar apos adicionar campos em ConfigurarPaginaDados
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE BOParaForm()
        LOCAL loc_oPg1, loc_oBO
        loc_oPg1 = THIS.pgf_4c_Paginas.Page2.pgf_4c_DadosInternos.Page1
        loc_oBO  = THIS.this_oBusinessObject

        *-- ROW 1: Produto + Descricao + Status + DtSituas
        loc_oPg1.txt_4c_Cpro.Value        = ALLTRIM(loc_oBO.this_cCpros)
        loc_oPg1.txt_4c_Dpro.Value        = ALLTRIM(loc_oBO.this_cDpros)
        loc_oPg1.obj_4c_OpcSituacao.Value = IIF(loc_oBO.this_nSituas = 2, 2, 1)
        IF !EMPTY(loc_oBO.this_dDatas)
            loc_oPg1.txt_4c_DtSituas.Value = loc_oBO.this_dDatas
        ELSE
            loc_oPg1.txt_4c_DtSituas.Value = DATE()
        ENDIF

        *-- ROW 2: Descritivo + CProEq + Cbar + LtMinsV
        loc_oPg1.txt_4c_DPro2s.Value      = ALLTRIM(loc_oBO.this_cDpro2s)
        loc_oPg1.txt_4c_CProEq.Value      = ALLTRIM(loc_oBO.this_cCproeqs)
        loc_oPg1.txt_4c_Cbar.Value        = loc_oBO.this_nCbars
        loc_oPg1.txt_4c_LtMinsV.Value     = loc_oBO.this_nLtminsv

        *-- ROW 3: Grupo + Merc + IdeCPros + EAN13 + ProdWeb
        loc_oPg1.txt_4c_Cgru.Value        = ALLTRIM(loc_oBO.this_cCgrus)
        loc_oPg1.txt_4c_Dgru.Value        = ""
        loc_oPg1.txt_4c_Merc.Value        = ALLTRIM(loc_oBO.this_cMercs)
        loc_oPg1.txt_4c_IdeCPros.Value    = ALLTRIM(loc_oBO.this_cIdecpros)
        loc_oPg1.txt_4c_EAN13.Value       = loc_oBO.this_nEan13
        loc_oPg1.obj_4c_ProdWeb.Value     = loc_oBO.this_nWebpros + 1

        *-- ROW 4: Subgrupo + Variacao
        loc_oPg1.txt_4c_CSGru.Value       = ALLTRIM(loc_oBO.this_cSgrus)
        loc_oPg1.txt_4c_DsGru.Value       = ""
        loc_oPg1.obj_4c_Variacao.Value    = IIF(loc_oBO.this_nVarias = 1, 2, 1)

        *-- ROW 5: Linha + Garantia
        loc_oPg1.txt_4c_Lin.Value         = ALLTRIM(loc_oBO.this_cLinhas)
        loc_oPg1.txt_4c_DLin.Value        = ""
        loc_oPg1.txt_4c_DiasGar.Value     = loc_oBO.this_nDiasinas
        loc_oPg1.chk_4c_GarVit.Value      = 0

        *-- ROW 6: Colecao/Grupo de Venda + Obs3
        loc_oPg1.txt_4c_Col.Value         = ALLTRIM(loc_oBO.this_cColecoes)
        loc_oPg1.txt_4c_DCol.Value        = ""
        loc_oPg1.txt_4c_Obs3.Value        = ALLTRIM(loc_oBO.this_cObsetqs)

        *-- ROW 7: Fornecedor + Obs1 + Obs2
        loc_oPg1.txt_4c_Ifor.Value        = ALLTRIM(loc_oBO.this_cIfors)
        loc_oPg1.txt_4c_Dfor.Value        = ""
        loc_oPg1.txt_4c_Obs1.Value        = ALLTRIM(loc_oBO.this_cObspeds)
        loc_oPg1.txt_4c_Obs2.Value        = ALLTRIM(loc_oBO.this_cObspes)

        *-- ROW 8: Refs + Cor + Tam
        loc_oPg1.txt_4c_Refs.Value        = ALLTRIM(loc_oBO.this_cReffs)
        loc_oPg1.txt_4c_Cor.Value         = ALLTRIM(loc_oBO.this_cCodcors)
        loc_oPg1.txt_4c_Tam.Value         = ALLTRIM(loc_oBO.this_cCodtams)

        *-- ROW 9: Modelo
        loc_oPg1.txt_4c_CodFinP.Value     = ALLTRIM(loc_oBO.this_cCodfinp)
        loc_oPg1.txt_4c_DesFinP.Value     = ""

        *-- ROW 10: Acabamento
        loc_oPg1.txt_4c_Codacb.Value      = ALLTRIM(loc_oBO.this_cCodacbs)
        loc_oPg1.txt_4c_Dacb.Value        = ""

        *-- ROW 4 adicional: QtMin + QtPed
        loc_oPg1.txt_4c_Qmin.Value         = loc_oBO.this_nQmins
        loc_oPg1.txt_4c_QtPed.Value        = loc_oBO.this_nQtped

        *-- Dimensoes fisicas
        loc_oPg1.txt_4c_Altura.Value       = loc_oBO.this_nTamhs
        loc_oPg1.txt_4c_Largura.Value      = loc_oBO.this_nTamls
        loc_oPg1.txt_4c_Diametro.Value     = loc_oBO.this_nTamps

        *-- Peso
        loc_oPg1.txt_4c_PesoBs.Value       = loc_oBO.this_nPesobs
        loc_oPg1.txt_4c_Pmedio.Value       = loc_oBO.this_nPesoms

        *-- Ultima compra (somente leitura)
        IF !EMPTY(loc_oBO.this_dUltcomps)
            loc_oPg1.txt_4c_DtUltCompra.Value = loc_oBO.this_dUltcomps
        ENDIF
        loc_oPg1.txt_4c_VUltCompra.Value   = loc_oBO.this_nVultcomps
        loc_oPg1.txt_4c_MUltCompra.Value   = ALLTRIM(loc_oBO.this_cMultcomps)
        loc_oPg1.txt_4c_QtdUltComp.Value   = loc_oBO.this_nQultcomp

        *-- Classificacao + Local
        loc_oPg1.txt_4c_Class.Value        = ALLTRIM(loc_oBO.this_cCclass)
        loc_oPg1.txt_4c_DClass.Value       = ""
        loc_oPg1.txt_4c_Local.Value        = ALLTRIM(loc_oBO.this_cLocals)

        *-- Precos e moedas
        loc_oPg1.txt_4c_Ctotal.Value       = loc_oBO.this_nPcuss
        loc_oPg1.txt_4c_Mctotal.Value      = ALLTRIM(loc_oBO.this_cMoecs)
        loc_oPg1.txt_4c_Pvenda.Value       = loc_oBO.this_nPvens
        loc_oPg1.txt_4c_Mpvenda.Value      = ALLTRIM(loc_oBO.this_cMoepvs)
        loc_oPg1.txt_4c_Fvenda.Value       = loc_oBO.this_nFvendas
        loc_oPg1.txt_4c_Mfvenda.Value      = ALLTRIM(loc_oBO.this_cMoepvs)

        *-- Unidades
        loc_oPg1.txt_4c_Cuni.Value         = ALLTRIM(loc_oBO.this_cCunis)
        loc_oPg1.txt_4c_Duni.Value         = ""
        loc_oPg1.txt_4c_Cunip.Value        = ALLTRIM(loc_oBO.this_cCunips)
        loc_oPg1.txt_4c_Dunip.Value        = ""

        *-- Auditoria (somente leitura)
        IF !EMPTY(loc_oBO.this_dDtincs)
            loc_oPg1.txt_4c_DtIncs.Value   = loc_oBO.this_dDtincs
        ENDIF
        IF !EMPTY(loc_oBO.this_dDatas)
            loc_oPg1.txt_4c_DataAlts.Value = loc_oBO.this_dDatas
        ENDIF
        loc_oPg1.txt_4c_UsuIncs.Value      = ALLTRIM(loc_oBO.this_cUsuincs)
        loc_oPg1.txt_4c_UsuAlts.Value      = ALLTRIM(gc_4c_UsuarioLogado)

        *-- CheckBoxes
        loc_oPg1.chk_4c_Consig.Value       = loc_oBO.this_nConsigs
        loc_oPg1.chk_4c_FabrProprs.Value   = loc_oBO.this_nFabrproprs
        loc_oPg1.chk_4c_Encoms.Value       = loc_oBO.this_nEncoms

        *-- Dimensoes caixa + volumes + tipos de entrada
        loc_oPg1.txt_4c_Volumes.Value      = loc_oBO.this_nVolumes
        loc_oPg1.txt_4c_TEnts.Value        = loc_oBO.this_nTents

        *-- Memos
        loc_oPg1.edt_4c_DscCompras.Value   = ALLTRIM(loc_oBO.this_cDsccompras)
        loc_oPg1.edt_4c_DPro3s.Value       = ALLTRIM(loc_oBO.this_cDpro3s)
        loc_oPg1.edt_4c_ObsCompras.Value   = ALLTRIM(loc_oBO.this_cObscompras)

        *-- Identificador (somente leitura)
        IF PEMSTATUS(loc_oPg1, "txt_4c_CodIdent", 5)
            loc_oPg1.txt_4c_CodIdent.Value = ALLTRIM(loc_oBO.this_cCpros)
        ENDIF

        *-- Carregar descricoes lookup quando existir conexao
        IF TYPE("gnConnHandle") = "N" AND gnConnHandle > 0
            THIS.CarregarDescricoesForm(loc_oPg1)
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * FormParaBO - Transfere dados dos campos para o BO
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE FormParaBO()
        LOCAL loc_oPg1, loc_oBO
        loc_oPg1 = THIS.pgf_4c_Paginas.Page2.pgf_4c_DadosInternos.Page1
        loc_oBO  = THIS.this_oBusinessObject

        *-- ROW 1: Produto + Descricao + Status + DtSituas
        loc_oBO.this_cCpros    = ALLTRIM(loc_oPg1.txt_4c_Cpro.Value)
        loc_oBO.this_cDpros    = ALLTRIM(loc_oPg1.txt_4c_Dpro.Value)
        loc_oBO.this_nSituas   = loc_oPg1.obj_4c_OpcSituacao.Value
        IF !EMPTY(loc_oPg1.txt_4c_DtSituas.Value)
            loc_oBO.this_dDatas = loc_oPg1.txt_4c_DtSituas.Value
        ELSE
            loc_oBO.this_dDatas = DATE()
        ENDIF

        *-- ROW 2: Descritivo + CProEq + Cbar + LtMinsV
        loc_oBO.this_cDpro2s   = ALLTRIM(loc_oPg1.txt_4c_DPro2s.Value)
        loc_oBO.this_cCproeqs  = ALLTRIM(loc_oPg1.txt_4c_CProEq.Value)
        loc_oBO.this_nCbars    = loc_oPg1.txt_4c_Cbar.Value
        loc_oBO.this_nLtminsv  = loc_oPg1.txt_4c_LtMinsV.Value

        *-- ROW 3: Grupo + Merc + IdeCPros + EAN13 + ProdWeb
        loc_oBO.this_cCgrus    = ALLTRIM(loc_oPg1.txt_4c_Cgru.Value)
        loc_oBO.this_cMercs    = ALLTRIM(loc_oPg1.txt_4c_Merc.Value)
        loc_oBO.this_cIdecpros = ALLTRIM(loc_oPg1.txt_4c_IdeCPros.Value)
        loc_oBO.this_nEan13    = loc_oPg1.txt_4c_EAN13.Value
        loc_oBO.this_nWebpros  = loc_oPg1.obj_4c_ProdWeb.Value - 1

        *-- ROW 4: Subgrupo + Variacao
        loc_oBO.this_cSgrus    = ALLTRIM(loc_oPg1.txt_4c_CSGru.Value)
        loc_oBO.this_nVarias   = IIF(loc_oPg1.obj_4c_Variacao.Value = 2, 1, 0)

        *-- ROW 5: Linha + Garantia
        loc_oBO.this_cLinhas   = ALLTRIM(loc_oPg1.txt_4c_Lin.Value)
        loc_oBO.this_nDiasinas = loc_oPg1.txt_4c_DiasGar.Value

        *-- ROW 6: Colecao/Grupo de Venda + Obs3
        loc_oBO.this_cColecoes = ALLTRIM(loc_oPg1.txt_4c_Col.Value)
        loc_oBO.this_cObsetqs  = ALLTRIM(loc_oPg1.txt_4c_Obs3.Value)

        *-- ROW 7: Fornecedor + Obs1 + Obs2
        loc_oBO.this_cIfors    = ALLTRIM(loc_oPg1.txt_4c_Ifor.Value)
        loc_oBO.this_cObspeds  = ALLTRIM(loc_oPg1.txt_4c_Obs1.Value)
        loc_oBO.this_cObspes   = ALLTRIM(loc_oPg1.txt_4c_Obs2.Value)

        *-- ROW 8: Refs + Cor + Tam
        loc_oBO.this_cReffs    = ALLTRIM(loc_oPg1.txt_4c_Refs.Value)
        loc_oBO.this_cCodcors  = ALLTRIM(loc_oPg1.txt_4c_Cor.Value)
        loc_oBO.this_cCodtams  = ALLTRIM(loc_oPg1.txt_4c_Tam.Value)

        *-- ROW 9: Modelo
        loc_oBO.this_cCodfinp  = ALLTRIM(loc_oPg1.txt_4c_CodFinP.Value)

        *-- ROW 10: Acabamento
        loc_oBO.this_cCodacbs  = ALLTRIM(loc_oPg1.txt_4c_Codacb.Value)

        *-- Campos adicionais editaveis
        loc_oBO.this_nQmins        = loc_oPg1.txt_4c_Qmin.Value
        loc_oBO.this_nQtped        = loc_oPg1.txt_4c_QtPed.Value
        loc_oBO.this_nTamhs        = loc_oPg1.txt_4c_Altura.Value
        loc_oBO.this_nTamls        = loc_oPg1.txt_4c_Largura.Value
        loc_oBO.this_nTamps        = loc_oPg1.txt_4c_Diametro.Value
        loc_oBO.this_nPesobs       = loc_oPg1.txt_4c_PesoBs.Value
        loc_oBO.this_nPesoms       = loc_oPg1.txt_4c_Pmedio.Value
        loc_oBO.this_cCclass       = ALLTRIM(loc_oPg1.txt_4c_Class.Value)
        loc_oBO.this_cLocals       = ALLTRIM(loc_oPg1.txt_4c_Local.Value)
        loc_oBO.this_nPcuss        = loc_oPg1.txt_4c_Ctotal.Value
        loc_oBO.this_cMoecs        = ALLTRIM(loc_oPg1.txt_4c_Mctotal.Value)
        loc_oBO.this_nPvens        = loc_oPg1.txt_4c_Pvenda.Value
        loc_oBO.this_cMoepvs       = ALLTRIM(loc_oPg1.txt_4c_Mpvenda.Value)
        loc_oBO.this_nFvendas      = loc_oPg1.txt_4c_Fvenda.Value
        loc_oBO.this_cCunis        = ALLTRIM(loc_oPg1.txt_4c_Cuni.Value)
        loc_oBO.this_cCunips       = ALLTRIM(loc_oPg1.txt_4c_Cunip.Value)
        loc_oBO.this_nConsigs      = loc_oPg1.chk_4c_Consig.Value
        loc_oBO.this_nFabrproprs   = loc_oPg1.chk_4c_FabrProprs.Value
        loc_oBO.this_nEncoms       = loc_oPg1.chk_4c_Encoms.Value
        loc_oBO.this_nVolumes      = loc_oPg1.txt_4c_Volumes.Value
        loc_oBO.this_nTents        = loc_oPg1.txt_4c_TEnts.Value
        loc_oBO.this_cDsccompras   = ALLTRIM(loc_oPg1.edt_4c_DscCompras.Value)
        loc_oBO.this_cDpro3s       = ALLTRIM(loc_oPg1.edt_4c_DPro3s.Value)
        loc_oBO.this_cObscompras   = ALLTRIM(loc_oPg1.edt_4c_ObsCompras.Value)
    ENDPROC

    *--------------------------------------------------------------------------
    * HabilitarCampos - Habilita/desabilita campos conforme modo de edicao
    * par_lHabilitar: .T.=editar, .F.=somente leitura (VISUALIZAR)
    * par_lHabilitarCodigo: .T.=codigo editavel (INCLUIR), .F.=codigo bloqueado (ALTERAR)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE HabilitarCampos(par_lHabilitar, par_lHabilitarCodigo)
        LOCAL loc_oPg1
        loc_oPg1 = THIS.pgf_4c_Paginas.Page2.pgf_4c_DadosInternos.Page1

        *-- Codigo produto: editavel apenas em INCLUIR
        loc_oPg1.txt_4c_Cpro.ReadOnly      = !par_lHabilitarCodigo
        loc_oPg1.txt_4c_Cpro.BackColor     = IIF(par_lHabilitarCodigo, RGB(255,255,255), RGB(240,240,240))

        *-- Campos editaveis (ROW1-ROW10 exceto os ReadOnly permanentes)
        loc_oPg1.txt_4c_Dpro.ReadOnly      = !par_lHabilitar
        loc_oPg1.txt_4c_Dpro.BackColor     = IIF(par_lHabilitar, RGB(255,255,255), RGB(240,240,240))

        loc_oPg1.obj_4c_OpcSituacao.Enabled = par_lHabilitar

        loc_oPg1.txt_4c_DPro2s.ReadOnly    = !par_lHabilitar
        loc_oPg1.txt_4c_DPro2s.BackColor   = IIF(par_lHabilitar, RGB(255,255,255), RGB(240,240,240))

        loc_oPg1.txt_4c_CProEq.ReadOnly    = !par_lHabilitar
        loc_oPg1.txt_4c_CProEq.BackColor   = IIF(par_lHabilitar, RGB(255,255,255), RGB(240,240,240))

        loc_oPg1.txt_4c_Cbar.ReadOnly      = !par_lHabilitar
        loc_oPg1.txt_4c_Cbar.BackColor     = IIF(par_lHabilitar, RGB(255,255,255), RGB(240,240,240))

        loc_oPg1.txt_4c_LtMinsV.ReadOnly   = !par_lHabilitar
        loc_oPg1.txt_4c_LtMinsV.BackColor  = IIF(par_lHabilitar, RGB(255,255,255), RGB(240,240,240))

        loc_oPg1.txt_4c_Cgru.ReadOnly      = !par_lHabilitar
        loc_oPg1.txt_4c_Cgru.BackColor     = IIF(par_lHabilitar, RGB(255,255,255), RGB(240,240,240))

        loc_oPg1.txt_4c_Merc.ReadOnly      = !par_lHabilitar
        loc_oPg1.txt_4c_Merc.BackColor     = IIF(par_lHabilitar, RGB(255,255,255), RGB(240,240,240))

        loc_oPg1.txt_4c_IdeCPros.ReadOnly  = !par_lHabilitar
        loc_oPg1.txt_4c_IdeCPros.BackColor = IIF(par_lHabilitar, RGB(255,255,255), RGB(240,240,240))

        loc_oPg1.txt_4c_EAN13.ReadOnly     = !par_lHabilitar
        loc_oPg1.txt_4c_EAN13.BackColor    = IIF(par_lHabilitar, RGB(255,255,255), RGB(240,240,240))

        loc_oPg1.obj_4c_ProdWeb.Enabled    = par_lHabilitar

        loc_oPg1.txt_4c_CSGru.ReadOnly     = !par_lHabilitar
        loc_oPg1.txt_4c_CSGru.BackColor    = IIF(par_lHabilitar, RGB(255,255,255), RGB(240,240,240))

        loc_oPg1.obj_4c_Variacao.Enabled   = par_lHabilitar

        loc_oPg1.txt_4c_Lin.ReadOnly       = !par_lHabilitar
        loc_oPg1.txt_4c_Lin.BackColor      = IIF(par_lHabilitar, RGB(255,255,255), RGB(240,240,240))

        loc_oPg1.txt_4c_DiasGar.ReadOnly   = !par_lHabilitar
        loc_oPg1.txt_4c_DiasGar.BackColor  = IIF(par_lHabilitar, RGB(255,255,255), RGB(240,240,240))

        loc_oPg1.chk_4c_GarVit.Enabled     = par_lHabilitar

        loc_oPg1.txt_4c_Col.ReadOnly       = !par_lHabilitar
        loc_oPg1.txt_4c_Col.BackColor      = IIF(par_lHabilitar, RGB(255,255,255), RGB(240,240,240))

        loc_oPg1.txt_4c_Obs3.ReadOnly      = !par_lHabilitar
        loc_oPg1.txt_4c_Obs3.BackColor     = IIF(par_lHabilitar, RGB(255,255,255), RGB(240,240,240))

        loc_oPg1.txt_4c_Ifor.ReadOnly      = !par_lHabilitar
        loc_oPg1.txt_4c_Ifor.BackColor     = IIF(par_lHabilitar, RGB(255,255,255), RGB(240,240,240))

        loc_oPg1.txt_4c_Obs1.ReadOnly      = !par_lHabilitar
        loc_oPg1.txt_4c_Obs1.BackColor     = IIF(par_lHabilitar, RGB(255,255,255), RGB(240,240,240))

        loc_oPg1.txt_4c_Obs2.ReadOnly      = !par_lHabilitar
        loc_oPg1.txt_4c_Obs2.BackColor     = IIF(par_lHabilitar, RGB(255,255,255), RGB(240,240,240))

        loc_oPg1.txt_4c_Refs.ReadOnly      = !par_lHabilitar
        loc_oPg1.txt_4c_Refs.BackColor     = IIF(par_lHabilitar, RGB(255,255,255), RGB(240,240,240))

        loc_oPg1.txt_4c_Cor.ReadOnly       = !par_lHabilitar
        loc_oPg1.txt_4c_Cor.BackColor      = IIF(par_lHabilitar, RGB(255,255,255), RGB(240,240,240))

        loc_oPg1.txt_4c_Tam.ReadOnly       = !par_lHabilitar
        loc_oPg1.txt_4c_Tam.BackColor      = IIF(par_lHabilitar, RGB(255,255,255), RGB(240,240,240))

        loc_oPg1.txt_4c_CodFinP.ReadOnly   = !par_lHabilitar
        loc_oPg1.txt_4c_CodFinP.BackColor  = IIF(par_lHabilitar, RGB(255,255,255), RGB(240,240,240))

        loc_oPg1.txt_4c_Codacb.ReadOnly    = !par_lHabilitar
        loc_oPg1.txt_4c_Codacb.BackColor   = IIF(par_lHabilitar, RGB(255,255,255), RGB(240,240,240))

        *-- Campos adicionais editaveis
        loc_oPg1.txt_4c_Qmin.ReadOnly      = !par_lHabilitar
        loc_oPg1.txt_4c_Qmin.BackColor     = IIF(par_lHabilitar, RGB(255,255,255), RGB(240,240,240))

        loc_oPg1.txt_4c_QtPed.ReadOnly     = !par_lHabilitar
        loc_oPg1.txt_4c_QtPed.BackColor    = IIF(par_lHabilitar, RGB(255,255,255), RGB(240,240,240))

        loc_oPg1.txt_4c_Altura.ReadOnly    = !par_lHabilitar
        loc_oPg1.txt_4c_Altura.BackColor   = IIF(par_lHabilitar, RGB(255,255,255), RGB(240,240,240))

        loc_oPg1.txt_4c_Largura.ReadOnly   = !par_lHabilitar
        loc_oPg1.txt_4c_Largura.BackColor  = IIF(par_lHabilitar, RGB(255,255,255), RGB(240,240,240))

        loc_oPg1.txt_4c_Diametro.ReadOnly  = !par_lHabilitar
        loc_oPg1.txt_4c_Diametro.BackColor = IIF(par_lHabilitar, RGB(255,255,255), RGB(240,240,240))

        loc_oPg1.txt_4c_PesoBs.ReadOnly    = !par_lHabilitar
        loc_oPg1.txt_4c_PesoBs.BackColor   = IIF(par_lHabilitar, RGB(255,255,255), RGB(240,240,240))

        loc_oPg1.txt_4c_Pmedio.ReadOnly    = !par_lHabilitar
        loc_oPg1.txt_4c_Pmedio.BackColor   = IIF(par_lHabilitar, RGB(255,255,255), RGB(240,240,240))

        loc_oPg1.txt_4c_Class.ReadOnly     = !par_lHabilitar
        loc_oPg1.txt_4c_Class.BackColor    = IIF(par_lHabilitar, RGB(255,255,255), RGB(240,240,240))

        loc_oPg1.txt_4c_Local.ReadOnly     = !par_lHabilitar
        loc_oPg1.txt_4c_Local.BackColor    = IIF(par_lHabilitar, RGB(255,255,255), RGB(240,240,240))

        loc_oPg1.txt_4c_Mctotal.ReadOnly   = !par_lHabilitar
        loc_oPg1.txt_4c_Mctotal.BackColor  = IIF(par_lHabilitar, RGB(255,255,255), RGB(240,240,240))

        loc_oPg1.txt_4c_Pvenda.ReadOnly    = !par_lHabilitar
        loc_oPg1.txt_4c_Pvenda.BackColor   = IIF(par_lHabilitar, RGB(255,255,255), RGB(240,240,240))

        loc_oPg1.txt_4c_Mpvenda.ReadOnly   = !par_lHabilitar
        loc_oPg1.txt_4c_Mpvenda.BackColor  = IIF(par_lHabilitar, RGB(255,255,255), RGB(240,240,240))

        loc_oPg1.txt_4c_Fvenda.ReadOnly    = !par_lHabilitar
        loc_oPg1.txt_4c_Fvenda.BackColor   = IIF(par_lHabilitar, RGB(255,255,255), RGB(240,240,240))

        loc_oPg1.txt_4c_Mfvenda.ReadOnly   = !par_lHabilitar
        loc_oPg1.txt_4c_Mfvenda.BackColor  = IIF(par_lHabilitar, RGB(255,255,255), RGB(240,240,240))

        loc_oPg1.txt_4c_Cuni.ReadOnly      = !par_lHabilitar
        loc_oPg1.txt_4c_Cuni.BackColor     = IIF(par_lHabilitar, RGB(255,255,255), RGB(240,240,240))

        loc_oPg1.txt_4c_Cunip.ReadOnly     = !par_lHabilitar
        loc_oPg1.txt_4c_Cunip.BackColor    = IIF(par_lHabilitar, RGB(255,255,255), RGB(240,240,240))

        loc_oPg1.chk_4c_Consig.Enabled     = par_lHabilitar
        loc_oPg1.chk_4c_FabrProprs.Enabled = par_lHabilitar
        loc_oPg1.chk_4c_Encoms.Enabled     = par_lHabilitar

        loc_oPg1.txt_4c_Volumes.ReadOnly   = !par_lHabilitar
        loc_oPg1.txt_4c_Volumes.BackColor  = IIF(par_lHabilitar, RGB(255,255,255), RGB(240,240,240))

        loc_oPg1.edt_4c_DscCompras.ReadOnly = !par_lHabilitar
        loc_oPg1.edt_4c_DscCompras.BackColor = IIF(par_lHabilitar, RGB(255,255,255), RGB(240,240,240))

        loc_oPg1.edt_4c_DPro3s.ReadOnly    = !par_lHabilitar
        loc_oPg1.edt_4c_DPro3s.BackColor   = IIF(par_lHabilitar, RGB(255,255,255), RGB(240,240,240))

        loc_oPg1.edt_4c_ObsCompras.ReadOnly = !par_lHabilitar
        loc_oPg1.edt_4c_ObsCompras.BackColor = IIF(par_lHabilitar, RGB(255,255,255), RGB(240,240,240))

        loc_oPg1.cmd_4c_QtMin.Enabled      = par_lHabilitar
    ENDPROC

    *==========================================================================
    *-- KEYPESS HANDLERS - Page2 Dados (pgDados Page1)
    *==========================================================================

    *--------------------------------------------------------------------------
    * DadosCproKeyPress - Handler KeyPress no txt_4c_Cpro (codigo produto)
    *--------------------------------------------------------------------------
    PROCEDURE DadosCproKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 115
            THIS.AbrirLookupDadosCpro()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * AbrirLookupDadosCpro - Lookup produto pelo codigo (F4 em txt_4c_Cpro)
    *--------------------------------------------------------------------------
    PROCEDURE AbrirLookupDadosCpro()
        LOCAL loc_oBusca, loc_cCod, loc_oPg1
        loc_oBusca = .NULL.
        loc_cCod   = ""
        TRY
            IF USED("cursor_4c_Busca")
                USE IN cursor_4c_Busca
            ENDIF
            IF TYPE("gnConnHandle") = "N" AND gnConnHandle > 0
                SQLEXEC(gnConnHandle, "SELECT CPros AS cpros, DPros AS dpros FROM SigCdPro ORDER BY CPros", "cursor_4c_Busca")
            ENDIF
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
            IF !ISNULL(loc_oBusca)
                loc_oBusca.this_cTabela        = "SigCdPro"
                loc_oBusca.this_cCampoChave    = "cpros"
                loc_oBusca.this_cCampoBusca    = "cpros"
                loc_oBusca.this_cCursorDestino = "cursor_4c_Busca"
                loc_oBusca.mAddColuna("cpros", "XXXXXXXXXXXXXX",                             "Produto")
                loc_oBusca.mAddColuna("dpros", "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX", "Descri" + CHR(231) + CHR(227) + "o")
                loc_oBusca.Caption = "Buscar Produto"
                loc_oBusca.Show()
                IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_Busca")
                    loc_cCod = ALLTRIM(cursor_4c_Busca.cpros)
                ENDIF
                IF USED("cursor_4c_Busca")
                    USE IN cursor_4c_Busca
                ENDIF
                loc_oBusca.Release()
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro na busca de produto:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY
        loc_oBusca = .NULL.
        IF !EMPTY(loc_cCod)
            loc_oPg1 = THIS.pgf_4c_Paginas.Page2.pgf_4c_DadosInternos.Page1
            loc_oPg1.txt_4c_Cpro.Value = loc_cCod
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * DadosCgruKeyPress - Handler KeyPress no txt_4c_Cgru (grupo)
    *--------------------------------------------------------------------------
    PROCEDURE DadosCgruKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 13 OR par_nKeyCode = 9
            THIS.ValidarDadosCgru()
        ENDIF
        IF par_nKeyCode = 115
            THIS.AbrirLookupDadosCgru()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * DadosLinKeyPress - Handler KeyPress no txt_4c_Lin (linha)
    *--------------------------------------------------------------------------
    PROCEDURE DadosLinKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 13 OR par_nKeyCode = 9
            THIS.ValidarDadosLin()
        ENDIF
        IF par_nKeyCode = 115
            THIS.AbrirLookupDadosLin()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * DadosColKeyPress - Handler KeyPress no txt_4c_Col (colecao/grupo de venda)
    *--------------------------------------------------------------------------
    PROCEDURE DadosColKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 13 OR par_nKeyCode = 9
            THIS.ValidarDadosCol()
        ENDIF
        IF par_nKeyCode = 115
            THIS.AbrirLookupDadosCol()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * DadosIforKeyPress - Handler KeyPress no txt_4c_Ifor (fornecedor)
    *--------------------------------------------------------------------------
    PROCEDURE DadosIforKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 13 OR par_nKeyCode = 9
            THIS.ValidarDadosIfor()
        ENDIF
        IF par_nKeyCode = 115
            THIS.AbrirLookupDadosIfor()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * DadosCorKeyPress - Handler KeyPress no txt_4c_Cor (cor)
    *--------------------------------------------------------------------------
    PROCEDURE DadosCorKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 13 OR par_nKeyCode = 9
            THIS.ValidarDadosCor()
        ENDIF
        IF par_nKeyCode = 115
            THIS.AbrirLookupDadosCor()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * DadosTamKeyPress - Handler KeyPress no txt_4c_Tam (tamanho)
    *--------------------------------------------------------------------------
    PROCEDURE DadosTamKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 13 OR par_nKeyCode = 9
            THIS.ValidarDadosTam()
        ENDIF
        IF par_nKeyCode = 115
            THIS.AbrirLookupDadosTam()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * DadosCodFinPKeyPress - Handler KeyPress no txt_4c_CodFinP (modelo)
    *--------------------------------------------------------------------------
    PROCEDURE DadosCodFinPKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 13 OR par_nKeyCode = 9
            THIS.ValidarDadosCodFinP()
        ENDIF
        IF par_nKeyCode = 115
            THIS.AbrirLookupDadosCodFinP()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * DadosCodacbKeyPress - Handler KeyPress no txt_4c_Codacb (acabamento)
    *--------------------------------------------------------------------------
    PROCEDURE DadosCodacbKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 13 OR par_nKeyCode = 9
            THIS.ValidarDadosCodacb()
        ENDIF
        IF par_nKeyCode = 115
            THIS.AbrirLookupDadosCodacb()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * DadosCProEqKeyPress - Handler KeyPress no txt_4c_CProEq (produto equivalente)
    *--------------------------------------------------------------------------
    PROCEDURE DadosCProEqKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 13 OR par_nKeyCode = 9
            THIS.ValidarDadosCProEq()
        ENDIF
        IF par_nKeyCode = 115
            THIS.AbrirLookupDadosCProEq()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * CmdQtMinClick - Handler botao "..." para QtMin por empresa
    *--------------------------------------------------------------------------
    PROCEDURE CmdQtMinClick()
        MsgInfo("Funcionalidade de estoque m" + CHR(237) + "nimo por empresa n" + CHR(227) + "o implementada nesta vers" + CHR(227) + "o.", "Informa" + CHR(231) + CHR(227) + "o")
    ENDPROC

    *--------------------------------------------------------------------------
    * DadosClassKeyPress - Handler KeyPress no txt_4c_Class (classificacao)
    *--------------------------------------------------------------------------
    PROCEDURE DadosClassKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 13 OR par_nKeyCode = 9
            THIS.ValidarDadosClass()
        ENDIF
        IF par_nKeyCode = 115
            THIS.AbrirLookupDadosClass()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * DadosLocalKeyPress - Handler KeyPress no txt_4c_Local (local de estoque)
    *--------------------------------------------------------------------------
    PROCEDURE DadosLocalKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 13 OR par_nKeyCode = 9
            THIS.ValidarDadosLocal()
        ENDIF
        IF par_nKeyCode = 115
            THIS.AbrirLookupDadosLocal()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * DadosMctotalKeyPress - Handler KeyPress no txt_4c_Mctotal (moeda custo)
    *--------------------------------------------------------------------------
    PROCEDURE DadosMctotalKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 13 OR par_nKeyCode = 9
            THIS.ValidarDadosMctotal()
        ENDIF
        IF par_nKeyCode = 115
            THIS.AbrirLookupDadosMctotal()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * DadosMpvendaKeyPress - Handler KeyPress no txt_4c_Mpvenda (moeda preco venda)
    *--------------------------------------------------------------------------
    PROCEDURE DadosMpvendaKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 13 OR par_nKeyCode = 9
            THIS.ValidarDadosMpvenda()
        ENDIF
        IF par_nKeyCode = 115
            THIS.AbrirLookupDadosMpvenda()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * DadosMfvendaKeyPress - Handler KeyPress no txt_4c_Mfvenda (moeda fator venda)
    *--------------------------------------------------------------------------
    PROCEDURE DadosMfvendaKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 13 OR par_nKeyCode = 9
            THIS.ValidarDadosMfvenda()
        ENDIF
        IF par_nKeyCode = 115
            THIS.AbrirLookupDadosMfvenda()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * DadosCuniKeyPress - Handler KeyPress no txt_4c_Cuni (unidade)
    *--------------------------------------------------------------------------
    PROCEDURE DadosCuniKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 13 OR par_nKeyCode = 9
            THIS.ValidarDadosCuni()
        ENDIF
        IF par_nKeyCode = 115
            THIS.AbrirLookupDadosCuni()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * DadosCunipKeyPress - Handler KeyPress no txt_4c_Cunip (unidade pauta)
    *--------------------------------------------------------------------------
    PROCEDURE DadosCunipKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 13 OR par_nKeyCode = 9
            THIS.ValidarDadosCunip()
        ENDIF
        IF par_nKeyCode = 115
            THIS.AbrirLookupDadosCunip()
        ENDIF
    ENDPROC

    *==========================================================================
    *-- VALIDACAO - Valida codigo e carrega descricao (ENTER/TAB)
    *==========================================================================

    *--------------------------------------------------------------------------
    * ValidarDadosCgru - Valida grupo (SigCdGrp: cgrus/dgrus)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ValidarDadosCgru()
        LOCAL loc_oPg1, loc_cCgru, loc_cSQL, loc_nResult
        loc_oPg1  = THIS.pgf_4c_Paginas.Page2.pgf_4c_DadosInternos.Page1
        loc_cCgru = ALLTRIM(loc_oPg1.txt_4c_Cgru.Value)
        IF EMPTY(loc_cCgru)
            loc_oPg1.txt_4c_Dgru.Value = ""
        ELSE
            IF TYPE("gnConnHandle") = "N" AND gnConnHandle > 0
                loc_cSQL    = "SELECT ISNULL(DGrus,'') AS DGrus FROM SigCdGrp " + ;
                              "WHERE CGrus = " + EscaparSQL(PADR(loc_cCgru, 3))
                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_GruD")
                IF loc_nResult > 0 AND RECCOUNT("cursor_4c_GruD") > 0
                    loc_oPg1.txt_4c_Dgru.Value = ALLTRIM(cursor_4c_GruD.DGrus)
                ELSE
                    loc_oPg1.txt_4c_Dgru.Value = ""
                    loc_oPg1.txt_4c_Cgru.Value = ""
                    MsgAviso("Grupo n" + CHR(227) + "o encontrado: " + loc_cCgru, "Aviso")
                ENDIF
                IF USED("cursor_4c_GruD")
                    USE IN cursor_4c_GruD
                ENDIF
            ENDIF
        ENDIF
        THIS.CarregarLista()
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarDadosLin - Valida linha (SigCdLin: linhas/descs)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ValidarDadosLin()
        LOCAL loc_oPg1, loc_cLin, loc_cSQL, loc_nResult
        loc_oPg1 = THIS.pgf_4c_Paginas.Page2.pgf_4c_DadosInternos.Page1
        loc_cLin = ALLTRIM(loc_oPg1.txt_4c_Lin.Value)
        IF EMPTY(loc_cLin)
            loc_oPg1.txt_4c_DLin.Value = ""
        ELSE
            IF TYPE("gnConnHandle") = "N" AND gnConnHandle > 0
                loc_cSQL    = "SELECT ISNULL(Descs,'') AS Descs FROM SigCdLin " + ;
                              "WHERE Linhas = " + EscaparSQL(PADR(loc_cLin, 10))
                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_LinD")
                IF loc_nResult > 0 AND RECCOUNT("cursor_4c_LinD") > 0
                    loc_oPg1.txt_4c_DLin.Value = ALLTRIM(cursor_4c_LinD.Descs)
                ELSE
                    loc_oPg1.txt_4c_DLin.Value = ""
                    loc_oPg1.txt_4c_Lin.Value  = ""
                    MsgAviso("Linha n" + CHR(227) + "o encontrada: " + loc_cLin, "Aviso")
                ENDIF
                IF USED("cursor_4c_LinD")
                    USE IN cursor_4c_LinD
                ENDIF
            ENDIF
        ENDIF
        THIS.CarregarLista()
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarDadosCol - Valida colecao/grupo de venda (SIGCDCOL: colecoes/descs)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ValidarDadosCol()
        LOCAL loc_oPg1, loc_cCol, loc_cSQL, loc_nResult
        loc_oPg1 = THIS.pgf_4c_Paginas.Page2.pgf_4c_DadosInternos.Page1
        loc_cCol = ALLTRIM(loc_oPg1.txt_4c_Col.Value)
        IF EMPTY(loc_cCol)
            loc_oPg1.txt_4c_DCol.Value = ""
        ELSE
            IF TYPE("gnConnHandle") = "N" AND gnConnHandle > 0
                loc_cSQL    = "SELECT ISNULL(Descs,'') AS Descs FROM SIGCDCOL " + ;
                              "WHERE Colecoes = " + EscaparSQL(PADR(loc_cCol, 10))
                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ColD")
                IF loc_nResult > 0 AND RECCOUNT("cursor_4c_ColD") > 0
                    loc_oPg1.txt_4c_DCol.Value = ALLTRIM(cursor_4c_ColD.Descs)
                ELSE
                    loc_oPg1.txt_4c_DCol.Value = ""
                    loc_oPg1.txt_4c_Col.Value  = ""
                    MsgAviso("Cole" + CHR(231) + CHR(227) + "o n" + CHR(227) + "o encontrada: " + loc_cCol, "Aviso")
                ENDIF
                IF USED("cursor_4c_ColD")
                    USE IN cursor_4c_ColD
                ENDIF
            ENDIF
        ENDIF
        THIS.CarregarLista()
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarDadosIfor - Valida fornecedor (SIGCDCLI: iclis/rclis)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ValidarDadosIfor()
        LOCAL loc_oPg1, loc_cIfor, loc_cSQL, loc_nResult
        loc_oPg1  = THIS.pgf_4c_Paginas.Page2.pgf_4c_DadosInternos.Page1
        loc_cIfor = ALLTRIM(loc_oPg1.txt_4c_Ifor.Value)
        IF EMPTY(loc_cIfor)
            loc_oPg1.txt_4c_Dfor.Value = ""
        ELSE
            IF TYPE("gnConnHandle") = "N" AND gnConnHandle > 0
                loc_cSQL    = "SELECT ISNULL(RClis,'') AS RClis FROM SIGCDCLI " + ;
                              "WHERE IClis = " + EscaparSQL(PADR(loc_cIfor, 10))
                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_IforD")
                IF loc_nResult > 0 AND RECCOUNT("cursor_4c_IforD") > 0
                    loc_oPg1.txt_4c_Dfor.Value = ALLTRIM(cursor_4c_IforD.RClis)
                ELSE
                    loc_oPg1.txt_4c_Dfor.Value = ""
                    loc_oPg1.txt_4c_Ifor.Value = ""
                    MsgAviso("Fornecedor n" + CHR(227) + "o encontrado: " + loc_cIfor, "Aviso")
                ENDIF
                IF USED("cursor_4c_IforD")
                    USE IN cursor_4c_IforD
                ENDIF
            ENDIF
        ENDIF
        THIS.CarregarLista()
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarDadosCor - Valida cor (SigCdCor: cods/descs)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ValidarDadosCor()
        LOCAL loc_oPg1, loc_cCor, loc_cSQL, loc_nResult
        loc_oPg1 = THIS.pgf_4c_Paginas.Page2.pgf_4c_DadosInternos.Page1
        loc_cCor = ALLTRIM(loc_oPg1.txt_4c_Cor.Value)
        IF EMPTY(loc_cCor)
            *-- Cor vazia e valida (produto sem cor padrao)
        ELSE
            IF TYPE("gnConnHandle") = "N" AND gnConnHandle > 0
                loc_cSQL    = "SELECT COUNT(*) AS nExiste FROM SigCdCor " + ;
                              "WHERE Cods = " + EscaparSQL(PADR(loc_cCor, 4))
                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_CorD")
                IF loc_nResult > 0 AND RECCOUNT("cursor_4c_CorD") > 0
                    IF cursor_4c_CorD.nExiste = 0
                        loc_oPg1.txt_4c_Cor.Value = ""
                        MsgAviso("Cor n" + CHR(227) + "o encontrada: " + loc_cCor, "Aviso")
                    ENDIF
                ENDIF
                IF USED("cursor_4c_CorD")
                    USE IN cursor_4c_CorD
                ENDIF
            ENDIF
        ENDIF
        THIS.CarregarLista()
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarDadosTam - Valida tamanho (SigCdTam: cods/descs)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ValidarDadosTam()
        LOCAL loc_oPg1, loc_cTam, loc_cSQL, loc_nResult
        loc_oPg1 = THIS.pgf_4c_Paginas.Page2.pgf_4c_DadosInternos.Page1
        loc_cTam = ALLTRIM(loc_oPg1.txt_4c_Tam.Value)
        IF EMPTY(loc_cTam)
            *-- Tamanho vazio e valido (produto sem tamanho padrao)
        ELSE
            IF TYPE("gnConnHandle") = "N" AND gnConnHandle > 0
                loc_cSQL    = "SELECT COUNT(*) AS nExiste FROM SigCdTam " + ;
                              "WHERE Cods = " + EscaparSQL(PADR(loc_cTam, 4))
                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_TamD")
                IF loc_nResult > 0 AND RECCOUNT("cursor_4c_TamD") > 0
                    IF cursor_4c_TamD.nExiste = 0
                        loc_oPg1.txt_4c_Tam.Value = ""
                        MsgAviso("Tamanho n" + CHR(227) + "o encontrado: " + loc_cTam, "Aviso")
                    ENDIF
                ENDIF
                IF USED("cursor_4c_TamD")
                    USE IN cursor_4c_TamD
                ENDIF
            ENDIF
        ENDIF
        THIS.CarregarLista()
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarDadosCodFinP - Valida modelo (sigcdmod: pkchave/descs)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ValidarDadosCodFinP()
        LOCAL loc_oPg1, loc_cCod, loc_cSQL, loc_nResult
        loc_oPg1 = THIS.pgf_4c_Paginas.Page2.pgf_4c_DadosInternos.Page1
        loc_cCod = ALLTRIM(loc_oPg1.txt_4c_CodFinP.Value)
        IF EMPTY(loc_cCod)
            loc_oPg1.txt_4c_DesFinP.Value = ""
        ELSE
            IF TYPE("gnConnHandle") = "N" AND gnConnHandle > 0
                loc_cSQL    = "SELECT ISNULL(Descs,'') AS Descs FROM sigcdmod " + ;
                              "WHERE Codigos = " + EscaparSQL(PADR(loc_cCod, 3))
                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ModD")
                IF loc_nResult > 0 AND RECCOUNT("cursor_4c_ModD") > 0
                    loc_oPg1.txt_4c_DesFinP.Value = ALLTRIM(cursor_4c_ModD.Descs)
                ELSE
                    loc_oPg1.txt_4c_DesFinP.Value = ""
                    loc_oPg1.txt_4c_CodFinP.Value = ""
                    MsgAviso("Modelo n" + CHR(227) + "o encontrado: " + loc_cCod, "Aviso")
                ENDIF
                IF USED("cursor_4c_ModD")
                    USE IN cursor_4c_ModD
                ENDIF
            ENDIF
        ENDIF
        THIS.CarregarLista()
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarDadosCodacb - Valida acabamento (SigCdAca: cods/descrs)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ValidarDadosCodacb()
        LOCAL loc_oPg1, loc_cCod, loc_cSQL, loc_nResult
        loc_oPg1 = THIS.pgf_4c_Paginas.Page2.pgf_4c_DadosInternos.Page1
        loc_cCod = ALLTRIM(loc_oPg1.txt_4c_Codacb.Value)
        IF EMPTY(loc_cCod)
            loc_oPg1.txt_4c_Dacb.Value = ""
        ELSE
            IF TYPE("gnConnHandle") = "N" AND gnConnHandle > 0
                loc_cSQL    = "SELECT ISNULL(Descrs,'') AS Descrs FROM SigCdAca " + ;
                              "WHERE Cods = " + EscaparSQL(PADR(loc_cCod, 3))
                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_AcaD")
                IF loc_nResult > 0 AND RECCOUNT("cursor_4c_AcaD") > 0
                    loc_oPg1.txt_4c_Dacb.Value = ALLTRIM(cursor_4c_AcaD.Descrs)
                ELSE
                    loc_oPg1.txt_4c_Dacb.Value = ""
                    loc_oPg1.txt_4c_Codacb.Value = ""
                    MsgAviso("Acabamento n" + CHR(227) + "o encontrado: " + loc_cCod, "Aviso")
                ENDIF
                IF USED("cursor_4c_AcaD")
                    USE IN cursor_4c_AcaD
                ENDIF
            ENDIF
        ENDIF
        THIS.CarregarLista()
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarDadosCProEq - Valida produto equivalente (SigCdPro: cpros/dpros)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ValidarDadosCProEq()
        LOCAL loc_oPg1, loc_cCod, loc_cSQL, loc_nResult
        loc_oPg1 = THIS.pgf_4c_Paginas.Page2.pgf_4c_DadosInternos.Page1
        loc_cCod = ALLTRIM(loc_oPg1.txt_4c_CProEq.Value)
        IF EMPTY(loc_cCod)
            *-- Equivalente vazio e valido
        ELSE
            IF TYPE("gnConnHandle") = "N" AND gnConnHandle > 0
                loc_cSQL    = "SELECT COUNT(*) AS nExiste FROM SigCdPro " + ;
                              "WHERE CPros = " + EscaparSQL(PADR(loc_cCod, 14))
                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_EqD")
                IF loc_nResult > 0 AND RECCOUNT("cursor_4c_EqD") > 0
                    IF cursor_4c_EqD.nExiste = 0
                        loc_oPg1.txt_4c_CProEq.Value = ""
                        MsgAviso("Produto equivalente n" + CHR(227) + "o encontrado: " + loc_cCod, "Aviso")
                    ENDIF
                ENDIF
                IF USED("cursor_4c_EqD")
                    USE IN cursor_4c_EqD
                ENDIF
            ENDIF
        ENDIF
        THIS.CarregarLista()
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarDadosClass - Valida classificacao (SigCdCls: Cods/Descs)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ValidarDadosClass()
        LOCAL loc_oPg1, loc_cCod, loc_cSQL, loc_nResult
        loc_oPg1 = THIS.pgf_4c_Paginas.Page2.pgf_4c_DadosInternos.Page1
        loc_cCod = ALLTRIM(loc_oPg1.txt_4c_Class.Value)
        IF EMPTY(loc_cCod)
            loc_oPg1.txt_4c_DClass.Value = ""
        ELSE
            IF TYPE("gnConnHandle") = "N" AND gnConnHandle > 0
                loc_cSQL    = "SELECT ISNULL(Descs,'') AS Descs FROM SigCdCls " + ;
                              "WHERE Cods = " + EscaparSQL(PADR(loc_cCod, 3))
                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ClsD")
                IF loc_nResult > 0 AND RECCOUNT("cursor_4c_ClsD") > 0
                    loc_oPg1.txt_4c_DClass.Value = ALLTRIM(cursor_4c_ClsD.Descs)
                ELSE
                    loc_oPg1.txt_4c_DClass.Value = ""
                    loc_oPg1.txt_4c_Class.Value  = ""
                    MsgAviso("Classifica" + CHR(231) + CHR(227) + "o n" + CHR(227) + "o encontrada: " + loc_cCod, "Aviso")
                ENDIF
                IF USED("cursor_4c_ClsD")
                    USE IN cursor_4c_ClsD
                ENDIF
            ENDIF
        ENDIF
        THIS.CarregarLista()
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarDadosLocal - Valida local de estoque (SigPrLcl: Codigos/Descricaos)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ValidarDadosLocal()
        LOCAL loc_oPg1, loc_cCod, loc_cSQL, loc_nResult
        loc_oPg1 = THIS.pgf_4c_Paginas.Page2.pgf_4c_DadosInternos.Page1
        loc_cCod = ALLTRIM(loc_oPg1.txt_4c_Local.Value)
        IF !EMPTY(loc_cCod)
            IF TYPE("gnConnHandle") = "N" AND gnConnHandle > 0
                loc_cSQL    = "SELECT COUNT(*) AS nExiste FROM SigPrLcl " + ;
                              "WHERE Codigos = " + EscaparSQL(PADR(loc_cCod, 10))
                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_LclD")
                IF loc_nResult > 0 AND RECCOUNT("cursor_4c_LclD") > 0
                    IF cursor_4c_LclD.nExiste = 0
                        loc_oPg1.txt_4c_Local.Value = ""
                        MsgAviso("Local de estoque n" + CHR(227) + "o encontrado: " + loc_cCod, "Aviso")
                    ENDIF
                ENDIF
                IF USED("cursor_4c_LclD")
                    USE IN cursor_4c_LclD
                ENDIF
            ENDIF
        ENDIF
        THIS.CarregarLista()
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarDadosCuni - Valida unidade (SigCdUni: CUnis/DUnis)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ValidarDadosCuni()
        LOCAL loc_oPg1, loc_cCod, loc_cSQL, loc_nResult
        loc_oPg1 = THIS.pgf_4c_Paginas.Page2.pgf_4c_DadosInternos.Page1
        loc_cCod = ALLTRIM(loc_oPg1.txt_4c_Cuni.Value)
        IF EMPTY(loc_cCod)
            loc_oPg1.txt_4c_Duni.Value = ""
        ELSE
            IF TYPE("gnConnHandle") = "N" AND gnConnHandle > 0
                loc_cSQL    = "SELECT ISNULL(DUnis,'') AS DUnis FROM SigCdUni " + ;
                              "WHERE CUnis = " + EscaparSQL(PADR(loc_cCod, 3))
                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_UniD")
                IF loc_nResult > 0 AND RECCOUNT("cursor_4c_UniD") > 0
                    loc_oPg1.txt_4c_Duni.Value = ALLTRIM(cursor_4c_UniD.DUnis)
                ELSE
                    loc_oPg1.txt_4c_Duni.Value = ""
                    loc_oPg1.txt_4c_Cuni.Value = ""
                    MsgAviso("Unidade n" + CHR(227) + "o encontrada: " + loc_cCod, "Aviso")
                ENDIF
                IF USED("cursor_4c_UniD")
                    USE IN cursor_4c_UniD
                ENDIF
            ENDIF
        ENDIF
        THIS.CarregarLista()
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarDadosCunip - Valida unidade de pauta (SigCdUni: CUnis/DUnis)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ValidarDadosCunip()
        LOCAL loc_oPg1, loc_cCod, loc_cSQL, loc_nResult
        loc_oPg1 = THIS.pgf_4c_Paginas.Page2.pgf_4c_DadosInternos.Page1
        loc_cCod = ALLTRIM(loc_oPg1.txt_4c_Cunip.Value)
        IF EMPTY(loc_cCod)
            loc_oPg1.txt_4c_Dunip.Value = ""
        ELSE
            IF TYPE("gnConnHandle") = "N" AND gnConnHandle > 0
                loc_cSQL    = "SELECT ISNULL(DUnis,'') AS DUnis FROM SigCdUni " + ;
                              "WHERE CUnis = " + EscaparSQL(PADR(loc_cCod, 3))
                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_UnipD")
                IF loc_nResult > 0 AND RECCOUNT("cursor_4c_UnipD") > 0
                    loc_oPg1.txt_4c_Dunip.Value = ALLTRIM(cursor_4c_UnipD.DUnis)
                ELSE
                    loc_oPg1.txt_4c_Dunip.Value = ""
                    loc_oPg1.txt_4c_Cunip.Value = ""
                    MsgAviso("Unidade n" + CHR(227) + "o encontrada: " + loc_cCod, "Aviso")
                ENDIF
                IF USED("cursor_4c_UnipD")
                    USE IN cursor_4c_UnipD
                ENDIF
            ENDIF
        ENDIF
        THIS.CarregarLista()
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarDadosMctotal - Valida moeda custo (SigCdMoe: CMoes/DMoes)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ValidarDadosMctotal()
        LOCAL loc_oPg1, loc_cCod, loc_cSQL, loc_nResult
        loc_oPg1 = THIS.pgf_4c_Paginas.Page2.pgf_4c_DadosInternos.Page1
        loc_cCod = ALLTRIM(loc_oPg1.txt_4c_Mctotal.Value)
        IF !EMPTY(loc_cCod)
            IF TYPE("gnConnHandle") = "N" AND gnConnHandle > 0
                loc_cSQL    = "SELECT COUNT(*) AS nExiste FROM SigCdMoe " + ;
                              "WHERE CMoes = " + EscaparSQL(PADR(loc_cCod, 3))
                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_MoeCtD")
                IF loc_nResult > 0 AND RECCOUNT("cursor_4c_MoeCtD") > 0
                    IF cursor_4c_MoeCtD.nExiste = 0
                        loc_oPg1.txt_4c_Mctotal.Value = ""
                        MsgAviso("Moeda n" + CHR(227) + "o encontrada: " + loc_cCod, "Aviso")
                    ENDIF
                ENDIF
                IF USED("cursor_4c_MoeCtD")
                    USE IN cursor_4c_MoeCtD
                ENDIF
            ENDIF
        ENDIF
        THIS.CarregarLista()
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarDadosMpvenda - Valida moeda preco venda (SigCdMoe: CMoes/DMoes)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ValidarDadosMpvenda()
        LOCAL loc_oPg1, loc_cCod, loc_cSQL, loc_nResult
        loc_oPg1 = THIS.pgf_4c_Paginas.Page2.pgf_4c_DadosInternos.Page1
        loc_cCod = ALLTRIM(loc_oPg1.txt_4c_Mpvenda.Value)
        IF !EMPTY(loc_cCod)
            IF TYPE("gnConnHandle") = "N" AND gnConnHandle > 0
                loc_cSQL    = "SELECT COUNT(*) AS nExiste FROM SigCdMoe " + ;
                              "WHERE CMoes = " + EscaparSQL(PADR(loc_cCod, 3))
                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_MoePvD")
                IF loc_nResult > 0 AND RECCOUNT("cursor_4c_MoePvD") > 0
                    IF cursor_4c_MoePvD.nExiste = 0
                        loc_oPg1.txt_4c_Mpvenda.Value = ""
                        MsgAviso("Moeda n" + CHR(227) + "o encontrada: " + loc_cCod, "Aviso")
                    ENDIF
                ENDIF
                IF USED("cursor_4c_MoePvD")
                    USE IN cursor_4c_MoePvD
                ENDIF
            ENDIF
        ENDIF
        THIS.CarregarLista()
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarDadosMfvenda - Valida moeda fator venda (SigCdMoe: CMoes/DMoes)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ValidarDadosMfvenda()
        LOCAL loc_oPg1, loc_cCod, loc_cSQL, loc_nResult
        loc_oPg1 = THIS.pgf_4c_Paginas.Page2.pgf_4c_DadosInternos.Page1
        loc_cCod = ALLTRIM(loc_oPg1.txt_4c_Mfvenda.Value)
        IF !EMPTY(loc_cCod)
            IF TYPE("gnConnHandle") = "N" AND gnConnHandle > 0
                loc_cSQL    = "SELECT COUNT(*) AS nExiste FROM SigCdMoe " + ;
                              "WHERE CMoes = " + EscaparSQL(PADR(loc_cCod, 3))
                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_MoeFvD")
                IF loc_nResult > 0 AND RECCOUNT("cursor_4c_MoeFvD") > 0
                    IF cursor_4c_MoeFvD.nExiste = 0
                        loc_oPg1.txt_4c_Mfvenda.Value = ""
                        MsgAviso("Moeda n" + CHR(227) + "o encontrada: " + loc_cCod, "Aviso")
                    ENDIF
                ENDIF
                IF USED("cursor_4c_MoeFvD")
                    USE IN cursor_4c_MoeFvD
                ENDIF
            ENDIF
        ENDIF
        THIS.CarregarLista()
    ENDPROC

    *==========================================================================
    *-- LOOKUPS - Abertura de FormBuscaAuxiliar (F4)
    *==========================================================================

    *--------------------------------------------------------------------------
    * AbrirLookupDadosCgru - Lookup grupo (SigCdGrp: cgrus/dgrus)
    *--------------------------------------------------------------------------
    PROCEDURE AbrirLookupDadosCgru()
        LOCAL loc_oBusca, loc_cCgru, loc_cDgru, loc_oPg1
        loc_oBusca = .NULL.
        loc_cCgru  = ""
        loc_cDgru  = ""
        TRY
            IF USED("cursor_4c_Busca")
                USE IN cursor_4c_Busca
            ENDIF
            IF TYPE("gnConnHandle") = "N" AND gnConnHandle > 0
                SQLEXEC(gnConnHandle, "SELECT CGrus AS cgrus, DGrus AS dgrus FROM SigCdGrp ORDER BY CGrus", "cursor_4c_Busca")
            ENDIF
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
            IF !ISNULL(loc_oBusca)
                loc_oBusca.this_cTabela        = "SigCdGrp"
                loc_oBusca.this_cCampoChave    = "cgrus"
                loc_oBusca.this_cCampoBusca    = "cgrus"
                loc_oBusca.this_cCursorDestino = "cursor_4c_Busca"
                loc_oBusca.mAddColuna("cgrus", "XXXXX",                                  "Grupo")
                loc_oBusca.mAddColuna("dgrus", "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX", "Descri" + CHR(231) + CHR(227) + "o")
                loc_oBusca.Caption = "Buscar Grupo de Produto"
                loc_oBusca.Show()
                IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_Busca")
                    loc_cCgru = ALLTRIM(cursor_4c_Busca.cgrus)
                    loc_cDgru = ALLTRIM(cursor_4c_Busca.dgrus)
                ENDIF
                IF USED("cursor_4c_Busca")
                    USE IN cursor_4c_Busca
                ENDIF
                loc_oBusca.Release()
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro na busca de grupo:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY
        loc_oBusca = .NULL.
        IF !EMPTY(loc_cCgru)
            loc_oPg1 = THIS.pgf_4c_Paginas.Page2.pgf_4c_DadosInternos.Page1
            loc_oPg1.txt_4c_Cgru.Value = loc_cCgru
            loc_oPg1.txt_4c_Dgru.Value = loc_cDgru
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * AbrirLookupDadosLin - Lookup linha (SigCdLin: linhas/descs)
    *--------------------------------------------------------------------------
    PROCEDURE AbrirLookupDadosLin()
        LOCAL loc_oBusca, loc_cLin, loc_cDLin, loc_oPg1
        loc_oBusca = .NULL.
        loc_cLin   = ""
        loc_cDLin  = ""
        TRY
            IF USED("cursor_4c_Busca")
                USE IN cursor_4c_Busca
            ENDIF
            IF TYPE("gnConnHandle") = "N" AND gnConnHandle > 0
                SQLEXEC(gnConnHandle, "SELECT Linhas AS linhas, Descs AS descs FROM SigCdLin ORDER BY Linhas", "cursor_4c_Busca")
            ENDIF
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
            IF !ISNULL(loc_oBusca)
                loc_oBusca.this_cTabela        = "SigCdLin"
                loc_oBusca.this_cCampoChave    = "linhas"
                loc_oBusca.this_cCampoBusca    = "linhas"
                loc_oBusca.this_cCursorDestino = "cursor_4c_Busca"
                loc_oBusca.mAddColuna("linhas", "XXXXXXXXXX",                               "Linha")
                loc_oBusca.mAddColuna("descs",  "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX", "Descri" + CHR(231) + CHR(227) + "o")
                loc_oBusca.Caption = "Buscar Linha"
                loc_oBusca.Show()
                IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_Busca")
                    loc_cLin  = ALLTRIM(cursor_4c_Busca.linhas)
                    loc_cDLin = ALLTRIM(cursor_4c_Busca.descs)
                ENDIF
                IF USED("cursor_4c_Busca")
                    USE IN cursor_4c_Busca
                ENDIF
                loc_oBusca.Release()
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro na busca de linha:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY
        loc_oBusca = .NULL.
        IF !EMPTY(loc_cLin)
            loc_oPg1 = THIS.pgf_4c_Paginas.Page2.pgf_4c_DadosInternos.Page1
            loc_oPg1.txt_4c_Lin.Value  = loc_cLin
            loc_oPg1.txt_4c_DLin.Value = loc_cDLin
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * AbrirLookupDadosCol - Lookup colecao/grupo de venda (SIGCDCOL: colecoes/descs)
    *--------------------------------------------------------------------------
    PROCEDURE AbrirLookupDadosCol()
        LOCAL loc_oBusca, loc_cCol, loc_cDCol, loc_oPg1
        loc_oBusca = .NULL.
        loc_cCol   = ""
        loc_cDCol  = ""
        TRY
            IF USED("cursor_4c_Busca")
                USE IN cursor_4c_Busca
            ENDIF
            IF TYPE("gnConnHandle") = "N" AND gnConnHandle > 0
                SQLEXEC(gnConnHandle, "SELECT Colecoes AS colecoes, Descs AS descs FROM SIGCDCOL ORDER BY Colecoes", "cursor_4c_Busca")
            ENDIF
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
            IF !ISNULL(loc_oBusca)
                loc_oBusca.this_cTabela        = "SIGCDCOL"
                loc_oBusca.this_cCampoChave    = "colecoes"
                loc_oBusca.this_cCampoBusca    = "colecoes"
                loc_oBusca.this_cCursorDestino = "cursor_4c_Busca"
                loc_oBusca.mAddColuna("colecoes", "XXXXXXXXXX",                               "Cole" + CHR(231) + CHR(227) + "o")
                loc_oBusca.mAddColuna("descs",    "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX", "Descri" + CHR(231) + CHR(227) + "o")
                loc_oBusca.Caption = "Buscar Grupo de Venda"
                loc_oBusca.Show()
                IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_Busca")
                    loc_cCol  = ALLTRIM(cursor_4c_Busca.colecoes)
                    loc_cDCol = ALLTRIM(cursor_4c_Busca.descs)
                ENDIF
                IF USED("cursor_4c_Busca")
                    USE IN cursor_4c_Busca
                ENDIF
                loc_oBusca.Release()
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro na busca de cole" + CHR(231) + CHR(227) + "o:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY
        loc_oBusca = .NULL.
        IF !EMPTY(loc_cCol)
            loc_oPg1 = THIS.pgf_4c_Paginas.Page2.pgf_4c_DadosInternos.Page1
            loc_oPg1.txt_4c_Col.Value  = loc_cCol
            loc_oPg1.txt_4c_DCol.Value = loc_cDCol
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * AbrirLookupDadosIfor - Lookup fornecedor (SIGCDCLI: iclis/rclis)
    *--------------------------------------------------------------------------
    PROCEDURE AbrirLookupDadosIfor()
        LOCAL loc_oBusca, loc_cIfor, loc_cDfor, loc_oPg1
        loc_oBusca = .NULL.
        loc_cIfor  = ""
        loc_cDfor  = ""
        TRY
            IF USED("cursor_4c_Busca")
                USE IN cursor_4c_Busca
            ENDIF
            IF TYPE("gnConnHandle") = "N" AND gnConnHandle > 0
                SQLEXEC(gnConnHandle, "SELECT IClis AS iclis, RClis AS rclis FROM SIGCDCLI ORDER BY IClis", "cursor_4c_Busca")
            ENDIF
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
            IF !ISNULL(loc_oBusca)
                loc_oBusca.this_cTabela        = "SIGCDCLI"
                loc_oBusca.this_cCampoChave    = "iclis"
                loc_oBusca.this_cCampoBusca    = "iclis"
                loc_oBusca.this_cCursorDestino = "cursor_4c_Busca"
                loc_oBusca.mAddColuna("iclis", "XXXXXXXXXX",                               "Fornecedor")
                loc_oBusca.mAddColuna("rclis", "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX", "Raz" + CHR(227) + "o Social")
                loc_oBusca.Caption = "Buscar Fornecedor"
                loc_oBusca.Show()
                IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_Busca")
                    loc_cIfor = ALLTRIM(cursor_4c_Busca.iclis)
                    loc_cDfor = ALLTRIM(cursor_4c_Busca.rclis)
                ENDIF
                IF USED("cursor_4c_Busca")
                    USE IN cursor_4c_Busca
                ENDIF
                loc_oBusca.Release()
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro na busca de fornecedor:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY
        loc_oBusca = .NULL.
        IF !EMPTY(loc_cIfor)
            loc_oPg1 = THIS.pgf_4c_Paginas.Page2.pgf_4c_DadosInternos.Page1
            loc_oPg1.txt_4c_Ifor.Value = loc_cIfor
            loc_oPg1.txt_4c_Dfor.Value = loc_cDfor
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * AbrirLookupDadosCor - Lookup cor (SigCdCor: cods/descs)
    *--------------------------------------------------------------------------
    PROCEDURE AbrirLookupDadosCor()
        LOCAL loc_oBusca, loc_cCod, loc_oPg1
        loc_oBusca = .NULL.
        loc_cCod   = ""
        TRY
            IF USED("cursor_4c_Busca")
                USE IN cursor_4c_Busca
            ENDIF
            IF TYPE("gnConnHandle") = "N" AND gnConnHandle > 0
                SQLEXEC(gnConnHandle, "SELECT Cods AS cods, Descs AS descs FROM SigCdCor ORDER BY Cods", "cursor_4c_Busca")
            ENDIF
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
            IF !ISNULL(loc_oBusca)
                loc_oBusca.this_cTabela        = "SigCdCor"
                loc_oBusca.this_cCampoChave    = "cods"
                loc_oBusca.this_cCampoBusca    = "cods"
                loc_oBusca.this_cCursorDestino = "cursor_4c_Busca"
                loc_oBusca.mAddColuna("cods",  "XXXX",                                      "Cor")
                loc_oBusca.mAddColuna("descs", "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX", "Descri" + CHR(231) + CHR(227) + "o")
                loc_oBusca.Caption = "Buscar Cor"
                loc_oBusca.Show()
                IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_Busca")
                    loc_cCod = ALLTRIM(cursor_4c_Busca.cods)
                ENDIF
                IF USED("cursor_4c_Busca")
                    USE IN cursor_4c_Busca
                ENDIF
                loc_oBusca.Release()
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro na busca de cor:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY
        loc_oBusca = .NULL.
        IF !EMPTY(loc_cCod)
            loc_oPg1 = THIS.pgf_4c_Paginas.Page2.pgf_4c_DadosInternos.Page1
            loc_oPg1.txt_4c_Cor.Value = loc_cCod
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * AbrirLookupDadosTam - Lookup tamanho (SigCdTam: cods/descs)
    *--------------------------------------------------------------------------
    PROCEDURE AbrirLookupDadosTam()
        LOCAL loc_oBusca, loc_cCod, loc_oPg1
        loc_oBusca = .NULL.
        loc_cCod   = ""
        TRY
            IF USED("cursor_4c_Busca")
                USE IN cursor_4c_Busca
            ENDIF
            IF TYPE("gnConnHandle") = "N" AND gnConnHandle > 0
                SQLEXEC(gnConnHandle, "SELECT Cods AS cods, Descs AS descs FROM SigCdTam ORDER BY Cods", "cursor_4c_Busca")
            ENDIF
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
            IF !ISNULL(loc_oBusca)
                loc_oBusca.this_cTabela        = "SigCdTam"
                loc_oBusca.this_cCampoChave    = "cods"
                loc_oBusca.this_cCampoBusca    = "cods"
                loc_oBusca.this_cCursorDestino = "cursor_4c_Busca"
                loc_oBusca.mAddColuna("cods",  "XXXX",                                      "Tamanho")
                loc_oBusca.mAddColuna("descs", "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX", "Descri" + CHR(231) + CHR(227) + "o")
                loc_oBusca.Caption = "Buscar Tamanho"
                loc_oBusca.Show()
                IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_Busca")
                    loc_cCod = ALLTRIM(cursor_4c_Busca.cods)
                ENDIF
                IF USED("cursor_4c_Busca")
                    USE IN cursor_4c_Busca
                ENDIF
                loc_oBusca.Release()
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro na busca de tamanho:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY
        loc_oBusca = .NULL.
        IF !EMPTY(loc_cCod)
            loc_oPg1 = THIS.pgf_4c_Paginas.Page2.pgf_4c_DadosInternos.Page1
            loc_oPg1.txt_4c_Tam.Value = loc_cCod
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * AbrirLookupDadosCodFinP - Lookup modelo (sigcdmod: pkchave/descs)
    *--------------------------------------------------------------------------
    PROCEDURE AbrirLookupDadosCodFinP()
        LOCAL loc_oBusca, loc_cCod, loc_cDes, loc_oPg1
        loc_oBusca = .NULL.
        loc_cCod   = ""
        loc_cDes   = ""
        TRY
            IF USED("cursor_4c_Busca")
                USE IN cursor_4c_Busca
            ENDIF
            IF TYPE("gnConnHandle") = "N" AND gnConnHandle > 0
                SQLEXEC(gnConnHandle, "SELECT pkchave, Descs AS descs FROM sigcdmod ORDER BY pkchave", "cursor_4c_Busca")
            ENDIF
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
            IF !ISNULL(loc_oBusca)
                loc_oBusca.this_cTabela        = "sigcdmod"
                loc_oBusca.this_cCampoChave    = "pkchave"
                loc_oBusca.this_cCampoBusca    = "pkchave"
                loc_oBusca.this_cCursorDestino = "cursor_4c_Busca"
                loc_oBusca.mAddColuna("pkchave", "XXX",                                      "Modelo")
                loc_oBusca.mAddColuna("descs",   "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX", "Descri" + CHR(231) + CHR(227) + "o")
                loc_oBusca.Caption = "Buscar Modelo"
                loc_oBusca.Show()
                IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_Busca")
                    loc_cCod = ALLTRIM(cursor_4c_Busca.pkchave)
                    loc_cDes = ALLTRIM(cursor_4c_Busca.descs)
                ENDIF
                IF USED("cursor_4c_Busca")
                    USE IN cursor_4c_Busca
                ENDIF
                loc_oBusca.Release()
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro na busca de modelo:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY
        loc_oBusca = .NULL.
        IF !EMPTY(loc_cCod)
            loc_oPg1 = THIS.pgf_4c_Paginas.Page2.pgf_4c_DadosInternos.Page1
            loc_oPg1.txt_4c_CodFinP.Value  = loc_cCod
            loc_oPg1.txt_4c_DesFinP.Value  = loc_cDes
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * AbrirLookupDadosCodacb - Lookup acabamento (SigCdAca: cods/descrs)
    *--------------------------------------------------------------------------
    PROCEDURE AbrirLookupDadosCodacb()
        LOCAL loc_oBusca, loc_cCod, loc_cDes, loc_oPg1
        loc_oBusca = .NULL.
        loc_cCod   = ""
        loc_cDes   = ""
        TRY
            IF USED("cursor_4c_Busca")
                USE IN cursor_4c_Busca
            ENDIF
            IF TYPE("gnConnHandle") = "N" AND gnConnHandle > 0
                SQLEXEC(gnConnHandle, "SELECT Cods AS cods, Descrs AS descrs FROM SigCdAca ORDER BY Cods", "cursor_4c_Busca")
            ENDIF
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
            IF !ISNULL(loc_oBusca)
                loc_oBusca.this_cTabela        = "SigCdAca"
                loc_oBusca.this_cCampoChave    = "cods"
                loc_oBusca.this_cCampoBusca    = "cods"
                loc_oBusca.this_cCursorDestino = "cursor_4c_Busca"
                loc_oBusca.mAddColuna("cods",   "XXX",                                      "Acabamento")
                loc_oBusca.mAddColuna("descrs", "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX", "Descri" + CHR(231) + CHR(227) + "o")
                loc_oBusca.Caption = "Buscar Acabamento"
                loc_oBusca.Show()
                IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_Busca")
                    loc_cCod = ALLTRIM(cursor_4c_Busca.cods)
                    loc_cDes = ALLTRIM(cursor_4c_Busca.descrs)
                ENDIF
                IF USED("cursor_4c_Busca")
                    USE IN cursor_4c_Busca
                ENDIF
                loc_oBusca.Release()
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro na busca de acabamento:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY
        loc_oBusca = .NULL.
        IF !EMPTY(loc_cCod)
            loc_oPg1 = THIS.pgf_4c_Paginas.Page2.pgf_4c_DadosInternos.Page1
            loc_oPg1.txt_4c_Codacb.Value = loc_cCod
            loc_oPg1.txt_4c_Dacb.Value   = loc_cDes
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * AbrirLookupDadosCProEq - Lookup produto equivalente (SigCdPro: cpros/dpros)
    *--------------------------------------------------------------------------
    PROCEDURE AbrirLookupDadosCProEq()
        LOCAL loc_oBusca, loc_cCod, loc_oPg1
        loc_oBusca = .NULL.
        loc_cCod   = ""
        TRY
            IF USED("cursor_4c_Busca")
                USE IN cursor_4c_Busca
            ENDIF
            IF TYPE("gnConnHandle") = "N" AND gnConnHandle > 0
                SQLEXEC(gnConnHandle, "SELECT CPros AS cpros, DPros AS dpros FROM SigCdPro ORDER BY CPros", "cursor_4c_Busca")
            ENDIF
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
            IF !ISNULL(loc_oBusca)
                loc_oBusca.this_cTabela        = "SigCdPro"
                loc_oBusca.this_cCampoChave    = "cpros"
                loc_oBusca.this_cCampoBusca    = "cpros"
                loc_oBusca.this_cCursorDestino = "cursor_4c_Busca"
                loc_oBusca.mAddColuna("cpros", "XXXXXXXXXXXXXX",                             "Produto")
                loc_oBusca.mAddColuna("dpros", "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX", "Descri" + CHR(231) + CHR(227) + "o")
                loc_oBusca.Caption = "Buscar Produto Equivalente"
                loc_oBusca.Show()
                IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_Busca")
                    loc_cCod = ALLTRIM(cursor_4c_Busca.cpros)
                ENDIF
                IF USED("cursor_4c_Busca")
                    USE IN cursor_4c_Busca
                ENDIF
                loc_oBusca.Release()
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro na busca de produto equivalente:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY
        loc_oBusca = .NULL.
        IF !EMPTY(loc_cCod)
            loc_oPg1 = THIS.pgf_4c_Paginas.Page2.pgf_4c_DadosInternos.Page1
            loc_oPg1.txt_4c_CProEq.Value = loc_cCod
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * AbrirLookupDadosClass - Lookup classificacao (SigCdCls: Cods/Descs)
    *--------------------------------------------------------------------------
    PROCEDURE AbrirLookupDadosClass()
        LOCAL loc_oBusca, loc_cCod, loc_cDesc, loc_oPg1
        loc_oBusca = .NULL.
        loc_cCod   = ""
        loc_cDesc  = ""
        TRY
            IF USED("cursor_4c_Busca")
                USE IN cursor_4c_Busca
            ENDIF
            IF TYPE("gnConnHandle") = "N" AND gnConnHandle > 0
                SQLEXEC(gnConnHandle, "SELECT Cods, Descs FROM SigCdCls ORDER BY Cods", "cursor_4c_Busca")
            ENDIF
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
            IF !ISNULL(loc_oBusca)
                loc_oBusca.this_cTabela        = "SigCdCls"
                loc_oBusca.this_cCampoChave    = "Cods"
                loc_oBusca.this_cCampoBusca    = "Cods"
                loc_oBusca.this_cCursorDestino = "cursor_4c_Busca"
                loc_oBusca.mAddColuna("Cods",  "XXXXX",                                    "Cod")
                loc_oBusca.mAddColuna("Descs", "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX", "Descri" + CHR(231) + CHR(227) + "o")
                loc_oBusca.Caption = "Buscar Classifica" + CHR(231) + CHR(227) + "o"
                loc_oBusca.Show()
                IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_Busca")
                    loc_cCod  = ALLTRIM(cursor_4c_Busca.Cods)
                    loc_cDesc = ALLTRIM(cursor_4c_Busca.Descs)
                ENDIF
                IF USED("cursor_4c_Busca")
                    USE IN cursor_4c_Busca
                ENDIF
                loc_oBusca.Release()
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro na busca de classifica" + CHR(231) + CHR(227) + "o:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY
        loc_oBusca = .NULL.
        IF !EMPTY(loc_cCod)
            loc_oPg1 = THIS.pgf_4c_Paginas.Page2.pgf_4c_DadosInternos.Page1
            loc_oPg1.txt_4c_Class.Value  = loc_cCod
            loc_oPg1.txt_4c_DClass.Value = loc_cDesc
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * AbrirLookupDadosLocal - Lookup local de estoque (SigPrLcl: Codigos/Descricaos)
    *--------------------------------------------------------------------------
    PROCEDURE AbrirLookupDadosLocal()
        LOCAL loc_oBusca, loc_cCod, loc_oPg1
        loc_oBusca = .NULL.
        loc_cCod   = ""
        TRY
            IF USED("cursor_4c_Busca")
                USE IN cursor_4c_Busca
            ENDIF
            IF TYPE("gnConnHandle") = "N" AND gnConnHandle > 0
                SQLEXEC(gnConnHandle, "SELECT Codigos, Descricaos FROM SigPrLcl ORDER BY Codigos", "cursor_4c_Busca")
            ENDIF
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
            IF !ISNULL(loc_oBusca)
                loc_oBusca.this_cTabela        = "SigPrLcl"
                loc_oBusca.this_cCampoChave    = "Codigos"
                loc_oBusca.this_cCampoBusca    = "Codigos"
                loc_oBusca.this_cCursorDestino = "cursor_4c_Busca"
                loc_oBusca.mAddColuna("Codigos",    "XXXXXXXXXX",                               "Cod")
                loc_oBusca.mAddColuna("Descricaos", "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX", "Descri" + CHR(231) + CHR(227) + "o")
                loc_oBusca.Caption = "Buscar Local de Estoque"
                loc_oBusca.Show()
                IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_Busca")
                    loc_cCod = ALLTRIM(cursor_4c_Busca.Codigos)
                ENDIF
                IF USED("cursor_4c_Busca")
                    USE IN cursor_4c_Busca
                ENDIF
                loc_oBusca.Release()
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro na busca de local de estoque:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY
        loc_oBusca = .NULL.
        IF !EMPTY(loc_cCod)
            loc_oPg1 = THIS.pgf_4c_Paginas.Page2.pgf_4c_DadosInternos.Page1
            loc_oPg1.txt_4c_Local.Value = loc_cCod
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * AbrirLookupDadosCuni - Lookup unidade (SigCdUni: CUnis/DUnis)
    *--------------------------------------------------------------------------
    PROCEDURE AbrirLookupDadosCuni()
        LOCAL loc_oBusca, loc_cCod, loc_cDesc, loc_oPg1
        loc_oBusca = .NULL.
        loc_cCod   = ""
        loc_cDesc  = ""
        TRY
            IF USED("cursor_4c_Busca")
                USE IN cursor_4c_Busca
            ENDIF
            IF TYPE("gnConnHandle") = "N" AND gnConnHandle > 0
                SQLEXEC(gnConnHandle, "SELECT CUnis, DUnis FROM SigCdUni ORDER BY CUnis", "cursor_4c_Busca")
            ENDIF
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
            IF !ISNULL(loc_oBusca)
                loc_oBusca.this_cTabela        = "SigCdUni"
                loc_oBusca.this_cCampoChave    = "CUnis"
                loc_oBusca.this_cCampoBusca    = "CUnis"
                loc_oBusca.this_cCursorDestino = "cursor_4c_Busca"
                loc_oBusca.mAddColuna("CUnis", "XXXXX",                                    "Unidade")
                loc_oBusca.mAddColuna("DUnis", "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX", "Descri" + CHR(231) + CHR(227) + "o")
                loc_oBusca.Caption = "Buscar Unidade"
                loc_oBusca.Show()
                IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_Busca")
                    loc_cCod  = ALLTRIM(cursor_4c_Busca.CUnis)
                    loc_cDesc = ALLTRIM(cursor_4c_Busca.DUnis)
                ENDIF
                IF USED("cursor_4c_Busca")
                    USE IN cursor_4c_Busca
                ENDIF
                loc_oBusca.Release()
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro na busca de unidade:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY
        loc_oBusca = .NULL.
        IF !EMPTY(loc_cCod)
            loc_oPg1 = THIS.pgf_4c_Paginas.Page2.pgf_4c_DadosInternos.Page1
            loc_oPg1.txt_4c_Cuni.Value = loc_cCod
            loc_oPg1.txt_4c_Duni.Value = loc_cDesc
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * AbrirLookupDadosCunip - Lookup unidade pauta (SigCdUni: CUnis/DUnis)
    *--------------------------------------------------------------------------
    PROCEDURE AbrirLookupDadosCunip()
        LOCAL loc_oBusca, loc_cCod, loc_cDesc, loc_oPg1
        loc_oBusca = .NULL.
        loc_cCod   = ""
        loc_cDesc  = ""
        TRY
            IF USED("cursor_4c_Busca")
                USE IN cursor_4c_Busca
            ENDIF
            IF TYPE("gnConnHandle") = "N" AND gnConnHandle > 0
                SQLEXEC(gnConnHandle, "SELECT CUnis, DUnis FROM SigCdUni ORDER BY CUnis", "cursor_4c_Busca")
            ENDIF
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
            IF !ISNULL(loc_oBusca)
                loc_oBusca.this_cTabela        = "SigCdUni"
                loc_oBusca.this_cCampoChave    = "CUnis"
                loc_oBusca.this_cCampoBusca    = "CUnis"
                loc_oBusca.this_cCursorDestino = "cursor_4c_Busca"
                loc_oBusca.mAddColuna("CUnis", "XXXXX",                                    "Unidade")
                loc_oBusca.mAddColuna("DUnis", "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX", "Descri" + CHR(231) + CHR(227) + "o")
                loc_oBusca.Caption = "Buscar Unidade de Pauta"
                loc_oBusca.Show()
                IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_Busca")
                    loc_cCod  = ALLTRIM(cursor_4c_Busca.CUnis)
                    loc_cDesc = ALLTRIM(cursor_4c_Busca.DUnis)
                ENDIF
                IF USED("cursor_4c_Busca")
                    USE IN cursor_4c_Busca
                ENDIF
                loc_oBusca.Release()
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro na busca de unidade de pauta:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY
        loc_oBusca = .NULL.
        IF !EMPTY(loc_cCod)
            loc_oPg1 = THIS.pgf_4c_Paginas.Page2.pgf_4c_DadosInternos.Page1
            loc_oPg1.txt_4c_Cunip.Value = loc_cCod
            loc_oPg1.txt_4c_Dunip.Value = loc_cDesc
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * AbrirLookupDadosMctotal - Lookup moeda custo (SigCdMoe: CMoes/DMoes)
    *--------------------------------------------------------------------------
    PROCEDURE AbrirLookupDadosMctotal()
        LOCAL loc_oBusca, loc_cCod, loc_oPg1
        loc_oBusca = .NULL.
        loc_cCod   = ""
        TRY
            IF USED("cursor_4c_Busca")
                USE IN cursor_4c_Busca
            ENDIF
            IF TYPE("gnConnHandle") = "N" AND gnConnHandle > 0
                SQLEXEC(gnConnHandle, "SELECT CMoes, DMoes FROM SigCdMoe ORDER BY CMoes", "cursor_4c_Busca")
            ENDIF
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
            IF !ISNULL(loc_oBusca)
                loc_oBusca.this_cTabela        = "SigCdMoe"
                loc_oBusca.this_cCampoChave    = "CMoes"
                loc_oBusca.this_cCampoBusca    = "CMoes"
                loc_oBusca.this_cCursorDestino = "cursor_4c_Busca"
                loc_oBusca.mAddColuna("CMoes", "XXXXX",                                    "Moeda")
                loc_oBusca.mAddColuna("DMoes", "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX", "Descri" + CHR(231) + CHR(227) + "o")
                loc_oBusca.Caption = "Buscar Moeda (Custo)"
                loc_oBusca.Show()
                IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_Busca")
                    loc_cCod = ALLTRIM(cursor_4c_Busca.CMoes)
                ENDIF
                IF USED("cursor_4c_Busca")
                    USE IN cursor_4c_Busca
                ENDIF
                loc_oBusca.Release()
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro na busca de moeda:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY
        loc_oBusca = .NULL.
        IF !EMPTY(loc_cCod)
            loc_oPg1 = THIS.pgf_4c_Paginas.Page2.pgf_4c_DadosInternos.Page1
            loc_oPg1.txt_4c_Mctotal.Value = loc_cCod
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * AbrirLookupDadosMpvenda - Lookup moeda preco venda (SigCdMoe: CMoes/DMoes)
    *--------------------------------------------------------------------------
    PROCEDURE AbrirLookupDadosMpvenda()
        LOCAL loc_oBusca, loc_cCod, loc_oPg1
        loc_oBusca = .NULL.
        loc_cCod   = ""
        TRY
            IF USED("cursor_4c_Busca")
                USE IN cursor_4c_Busca
            ENDIF
            IF TYPE("gnConnHandle") = "N" AND gnConnHandle > 0
                SQLEXEC(gnConnHandle, "SELECT CMoes, DMoes FROM SigCdMoe ORDER BY CMoes", "cursor_4c_Busca")
            ENDIF
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
            IF !ISNULL(loc_oBusca)
                loc_oBusca.this_cTabela        = "SigCdMoe"
                loc_oBusca.this_cCampoChave    = "CMoes"
                loc_oBusca.this_cCampoBusca    = "CMoes"
                loc_oBusca.this_cCursorDestino = "cursor_4c_Busca"
                loc_oBusca.mAddColuna("CMoes", "XXXXX",                                    "Moeda")
                loc_oBusca.mAddColuna("DMoes", "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX", "Descri" + CHR(231) + CHR(227) + "o")
                loc_oBusca.Caption = "Buscar Moeda (Pre" + CHR(231) + "o Venda)"
                loc_oBusca.Show()
                IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_Busca")
                    loc_cCod = ALLTRIM(cursor_4c_Busca.CMoes)
                ENDIF
                IF USED("cursor_4c_Busca")
                    USE IN cursor_4c_Busca
                ENDIF
                loc_oBusca.Release()
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro na busca de moeda:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY
        loc_oBusca = .NULL.
        IF !EMPTY(loc_cCod)
            loc_oPg1 = THIS.pgf_4c_Paginas.Page2.pgf_4c_DadosInternos.Page1
            loc_oPg1.txt_4c_Mpvenda.Value = loc_cCod
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * AbrirLookupDadosMfvenda - Lookup moeda fator venda (SigCdMoe: CMoes/DMoes)
    *--------------------------------------------------------------------------
    PROCEDURE AbrirLookupDadosMfvenda()
        LOCAL loc_oBusca, loc_cCod, loc_oPg1
        loc_oBusca = .NULL.
        loc_cCod   = ""
        TRY
            IF USED("cursor_4c_Busca")
                USE IN cursor_4c_Busca
            ENDIF
            IF TYPE("gnConnHandle") = "N" AND gnConnHandle > 0
                SQLEXEC(gnConnHandle, "SELECT CMoes, DMoes FROM SigCdMoe ORDER BY CMoes", "cursor_4c_Busca")
            ENDIF
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
            IF !ISNULL(loc_oBusca)
                loc_oBusca.this_cTabela        = "SigCdMoe"
                loc_oBusca.this_cCampoChave    = "CMoes"
                loc_oBusca.this_cCampoBusca    = "CMoes"
                loc_oBusca.this_cCursorDestino = "cursor_4c_Busca"
                loc_oBusca.mAddColuna("CMoes", "XXXXX",                                    "Moeda")
                loc_oBusca.mAddColuna("DMoes", "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX", "Descri" + CHR(231) + CHR(227) + "o")
                loc_oBusca.Caption = "Buscar Moeda (Fator Venda)"
                loc_oBusca.Show()
                IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_Busca")
                    loc_cCod = ALLTRIM(cursor_4c_Busca.CMoes)
                ENDIF
                IF USED("cursor_4c_Busca")
                    USE IN cursor_4c_Busca
                ENDIF
                loc_oBusca.Release()
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro na busca de moeda:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY
        loc_oBusca = .NULL.
        IF !EMPTY(loc_cCod)
            loc_oPg1 = THIS.pgf_4c_Paginas.Page2.pgf_4c_DadosInternos.Page1
            loc_oPg1.txt_4c_Mfvenda.Value = loc_cCod
        ENDIF
    ENDPROC

    *==========================================================================
    *-- AUXILIAR - Carrega descricoes lookup ao abrir registro
    *==========================================================================

    *--------------------------------------------------------------------------
    * CarregarDescricoesForm - Carrega descricoes dos campos lookup na pagina Dados
    * Chamado por BOParaForm quando gnConnHandle esta disponivel
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE CarregarDescricoesForm(par_oPg1)
        LOCAL loc_cSQL, loc_nResult, loc_cCgru, loc_cLin, loc_cCol, loc_cIfor
        LOCAL loc_cCodFinP, loc_cCodacb

        *-- Grupo
        loc_cCgru = ALLTRIM(par_oPg1.txt_4c_Cgru.Value)
        IF !EMPTY(loc_cCgru)
            loc_cSQL    = "SELECT ISNULL(DGrus,'') AS DGrus FROM SigCdGrp " + ;
                          "WHERE CGrus = " + EscaparSQL(PADR(loc_cCgru, 3))
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_GruBof")
            IF loc_nResult > 0 AND RECCOUNT("cursor_4c_GruBof") > 0
                par_oPg1.txt_4c_Dgru.Value = ALLTRIM(cursor_4c_GruBof.DGrus)
            ENDIF
            IF USED("cursor_4c_GruBof")
                USE IN cursor_4c_GruBof
            ENDIF
        ENDIF

        *-- Linha
        loc_cLin = ALLTRIM(par_oPg1.txt_4c_Lin.Value)
        IF !EMPTY(loc_cLin)
            loc_cSQL    = "SELECT ISNULL(Descs,'') AS Descs FROM SigCdLin " + ;
                          "WHERE Linhas = " + EscaparSQL(PADR(loc_cLin, 10))
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_LinBof")
            IF loc_nResult > 0 AND RECCOUNT("cursor_4c_LinBof") > 0
                par_oPg1.txt_4c_DLin.Value = ALLTRIM(cursor_4c_LinBof.Descs)
            ENDIF
            IF USED("cursor_4c_LinBof")
                USE IN cursor_4c_LinBof
            ENDIF
        ENDIF

        *-- Colecao/Grupo de Venda
        loc_cCol = ALLTRIM(par_oPg1.txt_4c_Col.Value)
        IF !EMPTY(loc_cCol)
            loc_cSQL    = "SELECT ISNULL(Descs,'') AS Descs FROM SIGCDCOL " + ;
                          "WHERE Colecoes = " + EscaparSQL(PADR(loc_cCol, 10))
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ColBof")
            IF loc_nResult > 0 AND RECCOUNT("cursor_4c_ColBof") > 0
                par_oPg1.txt_4c_DCol.Value = ALLTRIM(cursor_4c_ColBof.Descs)
            ENDIF
            IF USED("cursor_4c_ColBof")
                USE IN cursor_4c_ColBof
            ENDIF
        ENDIF

        *-- Fornecedor
        loc_cIfor = ALLTRIM(par_oPg1.txt_4c_Ifor.Value)
        IF !EMPTY(loc_cIfor)
            loc_cSQL    = "SELECT ISNULL(RClis,'') AS RClis FROM SIGCDCLI " + ;
                          "WHERE IClis = " + EscaparSQL(PADR(loc_cIfor, 10))
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_IforBof")
            IF loc_nResult > 0 AND RECCOUNT("cursor_4c_IforBof") > 0
                par_oPg1.txt_4c_Dfor.Value = ALLTRIM(cursor_4c_IforBof.RClis)
            ENDIF
            IF USED("cursor_4c_IforBof")
                USE IN cursor_4c_IforBof
            ENDIF
        ENDIF

        *-- Modelo
        loc_cCodFinP = ALLTRIM(par_oPg1.txt_4c_CodFinP.Value)
        IF !EMPTY(loc_cCodFinP)
            loc_cSQL    = "SELECT ISNULL(Descs,'') AS Descs FROM sigcdmod " + ;
                          "WHERE Codigos = " + EscaparSQL(PADR(loc_cCodFinP, 3))
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ModBof")
            IF loc_nResult > 0 AND RECCOUNT("cursor_4c_ModBof") > 0
                par_oPg1.txt_4c_DesFinP.Value = ALLTRIM(cursor_4c_ModBof.Descs)
            ENDIF
            IF USED("cursor_4c_ModBof")
                USE IN cursor_4c_ModBof
            ENDIF
        ENDIF

        *-- Acabamento
        loc_cCodacb = ALLTRIM(par_oPg1.txt_4c_Codacb.Value)
        IF !EMPTY(loc_cCodacb)
            loc_cSQL    = "SELECT ISNULL(Descrs,'') AS Descrs FROM SigCdAca " + ;
                          "WHERE Cods = " + EscaparSQL(PADR(loc_cCodacb, 3))
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_AcaBof")
            IF loc_nResult > 0 AND RECCOUNT("cursor_4c_AcaBof") > 0
                par_oPg1.txt_4c_Dacb.Value = ALLTRIM(cursor_4c_AcaBof.Descrs)
            ENDIF
            IF USED("cursor_4c_AcaBof")
                USE IN cursor_4c_AcaBof
            ENDIF
        ENDIF

        *-- Classificacao (SigCdCls: Cods/Descs)
        LOCAL loc_cClass
        loc_cClass = ALLTRIM(par_oPg1.txt_4c_Class.Value)
        IF !EMPTY(loc_cClass)
            loc_cSQL    = "SELECT ISNULL(Descs,'') AS Descs FROM SigCdCls " + ;
                          "WHERE Cods = " + EscaparSQL(PADR(loc_cClass, 3))
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ClsBof")
            IF loc_nResult > 0 AND RECCOUNT("cursor_4c_ClsBof") > 0
                par_oPg1.txt_4c_DClass.Value = ALLTRIM(cursor_4c_ClsBof.Descs)
            ENDIF
            IF USED("cursor_4c_ClsBof")
                USE IN cursor_4c_ClsBof
            ENDIF
        ENDIF

        *-- Unidade (SigCdUni: CUnis/DUnis)
        LOCAL loc_cCuni, loc_cCunip
        loc_cCuni = ALLTRIM(par_oPg1.txt_4c_Cuni.Value)
        IF !EMPTY(loc_cCuni)
            loc_cSQL    = "SELECT ISNULL(DUnis,'') AS DUnis FROM SigCdUni " + ;
                          "WHERE CUnis = " + EscaparSQL(PADR(loc_cCuni, 3))
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_UniBof")
            IF loc_nResult > 0 AND RECCOUNT("cursor_4c_UniBof") > 0
                par_oPg1.txt_4c_Duni.Value = ALLTRIM(cursor_4c_UniBof.DUnis)
            ENDIF
            IF USED("cursor_4c_UniBof")
                USE IN cursor_4c_UniBof
            ENDIF
        ENDIF

        *-- Unidade de Pauta (SigCdUni: CUnis/DUnis)
        loc_cCunip = ALLTRIM(par_oPg1.txt_4c_Cunip.Value)
        IF !EMPTY(loc_cCunip)
            loc_cSQL    = "SELECT ISNULL(DUnis,'') AS DUnis FROM SigCdUni " + ;
                          "WHERE CUnis = " + EscaparSQL(PADR(loc_cCunip, 3))
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_UnipBof")
            IF loc_nResult > 0 AND RECCOUNT("cursor_4c_UnipBof") > 0
                par_oPg1.txt_4c_Dunip.Value = ALLTRIM(cursor_4c_UnipBof.DUnis)
            ENDIF
            IF USED("cursor_4c_UnipBof")
                USE IN cursor_4c_UnipBof
            ENDIF
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * AjustarBotoesPorModo - Ajusta visibilidade/estado dos botoes por modo atual
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE AjustarBotoesPorModo()
        LOCAL loc_oPg1, loc_oPg2, loc_lEditing
        loc_oPg1    = THIS.pgf_4c_Paginas.Page1
        loc_oPg2    = THIS.pgf_4c_Paginas.Page2
        loc_lEditing = (THIS.this_cModoAtual = "INCLUIR" OR THIS.this_cModoAtual = "ALTERAR")

        *-- Botoes CRUD habilitados apenas em modo LISTA
        IF PEMSTATUS(loc_oPg1, "cnt_4c_Botoes", 5)
            loc_oPg1.cnt_4c_Botoes.cmd_4c_Incluir.Enabled   = (THIS.this_cModoAtual = "LISTA")
            loc_oPg1.cnt_4c_Botoes.cmd_4c_Visualizar.Enabled = (THIS.this_cModoAtual = "LISTA")
            loc_oPg1.cnt_4c_Botoes.cmd_4c_Alterar.Enabled   = (THIS.this_cModoAtual = "LISTA")
            loc_oPg1.cnt_4c_Botoes.cmd_4c_Excluir.Enabled   = (THIS.this_cModoAtual = "LISTA")
            loc_oPg1.cnt_4c_Botoes.cmd_4c_Buscar.Enabled    = (THIS.this_cModoAtual = "LISTA")
        ENDIF

        *-- Botoes Confirmar/Cancelar
        IF PEMSTATUS(loc_oPg2, "cnt_4c_Salva", 5)
            loc_oPg2.cnt_4c_Salva.cmd_4c_Confirmar.Enabled = (THIS.this_cModoAtual != "VISUALIZAR")
            loc_oPg2.cnt_4c_Salva.cmd_4c_Cancelar.Enabled  = .T.
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterCodigoSelecionado - Retorna codigo do registro selecionado no grid
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ObterCodigoSelecionado()
        IF USED("cursor_4c_Lista") AND RECCOUNT("cursor_4c_Lista") > 0
            SELECT cursor_4c_Lista
            RETURN ALLTRIM(cursor_4c_Lista.cpros)
        ENDIF
        RETURN ""
    ENDPROC

    *==========================================================================
    *-- HANDLERS DE BOTOES - Page1 (Lista)
    *==========================================================================

    *--------------------------------------------------------------------------
    * BtnIncluirClick - Modo INCLUIR: prepara formulario para novo registro
    *--------------------------------------------------------------------------
    PROCEDURE BtnIncluirClick()
        THIS.this_cModoAtual   = "INCLUIR"
        THIS.this_lNovoRegistro = .T.
        THIS.this_oBusinessObject.NovoRegistro()
        THIS.LimparCampos()
        THIS.HabilitarCampos(.T., .T.)
        THIS.AlternarPagina(2)
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnVisualizarClick - Modo VISUALIZAR: abre registro selecionado somente leitura
    *--------------------------------------------------------------------------
    PROCEDURE BtnVisualizarClick()
        LOCAL loc_cCodigo
        loc_cCodigo = THIS.ObterCodigoSelecionado()
        IF EMPTY(loc_cCodigo)
            MsgAviso("Selecione um produto na lista.", "Aviso")
            RETURN
        ENDIF
        IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
            THIS.this_cModoAtual   = "VISUALIZAR"
            THIS.this_lNovoRegistro = .F.
            THIS.BOParaForm()
            THIS.HabilitarCampos(.F., .F.)
            THIS.AlternarPagina(2)
        ELSE
            MsgErro("Produto n" + CHR(227) + "o encontrado.", "Erro")
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnAlterarClick - Modo ALTERAR: abre registro para edicao
    *--------------------------------------------------------------------------
    PROCEDURE BtnAlterarClick()
        LOCAL loc_cCodigo
        loc_cCodigo = THIS.ObterCodigoSelecionado()
        IF EMPTY(loc_cCodigo)
            MsgAviso("Selecione um produto na lista.", "Aviso")
            RETURN
        ENDIF
        IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
            THIS.this_cModoAtual   = "ALTERAR"
            THIS.this_lNovoRegistro = .F.
            THIS.this_oBusinessObject.EditarRegistro()
            THIS.BOParaForm()
            THIS.HabilitarCampos(.T., .F.)
            THIS.AlternarPagina(2)
        ELSE
            MsgErro("Produto n" + CHR(227) + "o encontrado.", "Erro")
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnExcluirClick - Confirma e executa exclusao do registro selecionado
    *--------------------------------------------------------------------------
    PROCEDURE BtnExcluirClick()
        LOCAL loc_cCodigo, loc_lConfirmado
        loc_cCodigo     = THIS.ObterCodigoSelecionado()
        loc_lConfirmado = .F.
        IF EMPTY(loc_cCodigo)
            MsgAviso("Selecione um produto na lista.", "Aviso")
            RETURN
        ENDIF
        loc_lConfirmado = MsgConfirma("Confirma a exclus" + CHR(227) + "o do produto " + ALLTRIM(loc_cCodigo) + "?", "Confirmar Exclus" + CHR(227) + "o")
        IF loc_lConfirmado
            IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
                IF !THIS.this_oBusinessObject.Excluir()
                    MsgErro("Erro ao excluir produto: " + THIS.this_oBusinessObject.this_cMensagemErro, "Erro")
                ELSE
                    THIS.CarregarLista()
                ENDIF
            ENDIF
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnBuscarClick - Abre busca auxiliar de produtos
    *--------------------------------------------------------------------------
    PROCEDURE BtnBuscarClick()
        LOCAL loc_oBusca, loc_cCodigo
        loc_oBusca  = .NULL.
        loc_cCodigo = ""
        TRY
            IF USED("cursor_4c_Busca")
                USE IN cursor_4c_Busca
            ENDIF
            IF TYPE("gnConnHandle") = "N" AND gnConnHandle > 0
                SQLEXEC(gnConnHandle, "SELECT CPros AS cpros, DPros AS dpros, CGrus AS cgrus FROM SigCdPro ORDER BY CPros", "cursor_4c_Busca")
            ENDIF
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
            IF !ISNULL(loc_oBusca)
                loc_oBusca.this_cTabela        = "SigCdPro"
                loc_oBusca.this_cCampoChave    = "cpros"
                loc_oBusca.this_cCampoBusca    = "cpros"
                loc_oBusca.this_cCursorDestino = "cursor_4c_Busca"
                loc_oBusca.mAddColuna("cpros",  "XXXXXXXXXXXXXXXXXXXXXXXXXX", "Produto")
                loc_oBusca.mAddColuna("dpros",  "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX", "Descri" + CHR(231) + CHR(227) + "o")
                loc_oBusca.mAddColuna("cgrus",  "XXXXX", "Grupo")
                loc_oBusca.Caption = "Buscar Produto"
                loc_oBusca.Show()
                IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_Busca")
                    loc_cCodigo = ALLTRIM(cursor_4c_Busca.cpros)
                ENDIF
                IF USED("cursor_4c_Busca")
                    USE IN cursor_4c_Busca
                ENDIF
                loc_oBusca.Release()
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro na busca de produtos:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY
        loc_oBusca = .NULL.
        IF !EMPTY(loc_cCodigo)
            THIS.CarregarLista()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnEncerrarClick - Encerra o formulario
    *--------------------------------------------------------------------------
    PROCEDURE BtnEncerrarClick()
        THIS.Release()
    ENDPROC

    *==========================================================================
    *-- HANDLERS DE BOTOES - Page2 (Dados)
    *==========================================================================

    *--------------------------------------------------------------------------
    * BtnConfirmarClick - Salva registro (Inserir ou Atualizar)
    * FASE 5: Implementar FormParaBO() + chamada ao BO
    *--------------------------------------------------------------------------
    PROCEDURE BtnConfirmarClick()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            THIS.FormParaBO()
            IF THIS.this_lNovoRegistro
                loc_lSucesso = THIS.this_oBusinessObject.Inserir()
            ELSE
                loc_lSucesso = THIS.this_oBusinessObject.Atualizar()
            ENDIF
            IF loc_lSucesso
                THIS.this_cModoAtual = "LISTA"
                THIS.AlternarPagina(1)
                THIS.CarregarLista()
            ELSE
                MsgErro("Erro ao salvar produto: " + THIS.this_oBusinessObject.this_cMensagemErro, "Erro")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao confirmar produto:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnCancelarClick - Cancela edicao e retorna para Lista
    *--------------------------------------------------------------------------
    PROCEDURE BtnCancelarClick()
        THIS.this_cModoAtual = "LISTA"
        THIS.AlternarPagina(1)
    ENDPROC

    *--------------------------------------------------------------------------
    * GrdListaDblClick - Duplo clique no grid abre registro para visualizacao
    *--------------------------------------------------------------------------
    PROCEDURE GrdListaDblClick()
        THIS.BtnVisualizarClick()
    ENDPROC

    *--------------------------------------------------------------------------
    * AlternarPagina - Navega entre Page1 (Lista) e Page2 (Dados)
    * par_nPagina: 1=Lista, 2=Dados
    *--------------------------------------------------------------------------
    PROCEDURE AlternarPagina(par_nPagina)
        THIS.pgf_4c_Paginas.ActivePage = par_nPagina
        IF par_nPagina = 2
            THIS.pgf_4c_Paginas.Page2.pgf_4c_DadosInternos.ActivePage = 1
            THIS.pgf_4c_Paginas.Page2.obj_4c_NavegacaoDados.Value      = 1
        ENDIF
        THIS.AjustarBotoesPorModo()
    ENDPROC

    *--------------------------------------------------------------------------
    * FiltroGrupoKeyPress - Handler KeyPress no txt_4c_Cgru
    * ENTER(13) ou TAB(9): valida e recarrega lista
    * F4(115): abre lookup de grupos
    *--------------------------------------------------------------------------
    PROCEDURE FiltroGrupoKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 13 OR par_nKeyCode = 9
            THIS.ValidarGrupoFiltro()
        ENDIF
        IF par_nKeyCode = 115
            THIS.AbrirLookupGrupo()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * FiltroSituaChange - Handler InteractiveChange no obj_4c_Situa
    * Recarrega lista quando usuario altera filtro de situacao
    *--------------------------------------------------------------------------
    PROCEDURE FiltroSituaChange()
        THIS.CarregarLista()
    ENDPROC

    *--------------------------------------------------------------------------
    * AbrirLookupGrupo - Abre FormBuscaAuxiliar para selecionar grupo de produto
    * Chama SigCdGrp (cgrus, dgrus)
    *--------------------------------------------------------------------------
    PROCEDURE AbrirLookupGrupo()
        LOCAL loc_oBusca, loc_cCgru, loc_cDgru, loc_oPg1
        loc_oBusca = .NULL.
        loc_cCgru  = ""
        loc_cDgru  = ""
        TRY
            IF USED("cursor_4c_Busca")
                USE IN cursor_4c_Busca
            ENDIF
            IF TYPE("gnConnHandle") = "N" AND gnConnHandle > 0
                SQLEXEC(gnConnHandle, "SELECT CGrus AS cgrus, DGrus AS dgrus FROM SigCdGrp ORDER BY CGrus", "cursor_4c_Busca")
            ENDIF
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
            IF !ISNULL(loc_oBusca)
                loc_oBusca.this_cTabela        = "SigCdGrp"
                loc_oBusca.this_cCampoChave    = "cgrus"
                loc_oBusca.this_cCampoBusca    = "cgrus"
                loc_oBusca.this_cCursorDestino = "cursor_4c_Busca"
                loc_oBusca.mAddColuna("cgrus", "XXXXX",                                     "Grupo")
                loc_oBusca.mAddColuna("dgrus", "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX", "Descri" + CHR(231) + CHR(227) + "o")
                loc_oBusca.Caption = "Buscar Grupo de Produto"
                loc_oBusca.Show()
                IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_Busca")
                    loc_cCgru = ALLTRIM(cursor_4c_Busca.cgrus)
                    loc_cDgru = ALLTRIM(cursor_4c_Busca.dgrus)
                ENDIF
                IF USED("cursor_4c_Busca")
                    USE IN cursor_4c_Busca
                ENDIF
                loc_oBusca.Release()
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro na busca de grupo:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY
        loc_oBusca = .NULL.
        IF !EMPTY(loc_cCgru)
            loc_oPg1 = THIS.pgf_4c_Paginas.Page1
            loc_oPg1.cnt_4c_Filtros.txt_4c_Cgru.Value = loc_cCgru
            loc_oPg1.cnt_4c_Filtros.txt_4c_Dgru.Value = loc_cDgru
            THIS.CarregarLista()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarGrupoFiltro - Valida codigo de grupo e carrega descricao + lista
    * Chamado em ENTER/TAB no txt_4c_Cgru
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ValidarGrupoFiltro()
        LOCAL loc_oPg1, loc_cCgru, loc_cSQL, loc_nResult
        loc_oPg1  = THIS.pgf_4c_Paginas.Page1
        loc_cCgru = ALLTRIM(loc_oPg1.cnt_4c_Filtros.txt_4c_Cgru.Value)
        IF EMPTY(loc_cCgru)
            loc_oPg1.cnt_4c_Filtros.txt_4c_Dgru.Value = ""
        ELSE
            IF TYPE("gnConnHandle") = "N" AND gnConnHandle > 0
                loc_cSQL = "SELECT ISNULL(DGrus,'') AS DGrus FROM SigCdGrp " + ;
                           "WHERE CGrus = " + EscaparSQL(PADR(loc_cCgru, 3))
                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_GruFiltro")
                IF loc_nResult > 0 AND RECCOUNT("cursor_4c_GruFiltro") > 0
                    loc_oPg1.cnt_4c_Filtros.txt_4c_Dgru.Value = ALLTRIM(cursor_4c_GruFiltro.DGrus)
                ELSE
                    loc_oPg1.cnt_4c_Filtros.txt_4c_Dgru.Value = ""
                    loc_oPg1.cnt_4c_Filtros.txt_4c_Cgru.Value = ""
                ENDIF
                IF USED("cursor_4c_GruFiltro")
                    USE IN cursor_4c_GruFiltro
                ENDIF
            ENDIF
        ENDIF
        THIS.CarregarLista()
    ENDPROC

    *==========================================================================
    *-- METODOS AUXILIARES
    *==========================================================================

    *--------------------------------------------------------------------------
    * FormatarGridLista - Formata visual do grid de lista
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE FormatarGridLista(par_oGrid)
        WITH par_oGrid
            IF .ColumnCount > 0
                .FontName = "Tahoma"
                .FontSize = 8
            ENDIF
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * TornarControlesVisiveis - Torna todos os controles visiveis recursivamente
    * Filtro por nome evita tornar visiveis containers flutuantes (Visible=.F.)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
        LOCAL loc_nI, loc_oObjeto

        FOR loc_nI = 1 TO par_oContainer.ControlCount
            loc_oObjeto = par_oContainer.Controls(loc_nI)

            IF VARTYPE(loc_oObjeto) = "O"
                *-- Nao tornar visiveis containers flutuantes (iniciam com cnt_4c_Float)
                IF LEFT(LOWER(loc_oObjeto.Name), 13) != "cnt_4c_float_"
                    IF PEMSTATUS(loc_oObjeto, "Visible", 5)
                        loc_oObjeto.Visible = .T.
                    ENDIF
                ENDIF

                *-- Trata PageFrame - itera Pages
                IF UPPER(loc_oObjeto.BaseClass) = "PAGEFRAME"
                    LOCAL loc_nP
                    FOR loc_nP = 1 TO loc_oObjeto.PageCount
                        THIS.TornarControlesVisiveis(loc_oObjeto.Pages(loc_nP))
                    ENDFOR
                ENDIF

                *-- Trata containers com ControlCount
                IF PEMSTATUS(loc_oObjeto, "ControlCount", 5)
                    THIS.TornarControlesVisiveis(loc_oObjeto)
                ENDIF
            ENDIF
        ENDFOR
    ENDPROC

    *--------------------------------------------------------------------------
    * LimparCampos - Limpa todos os campos do formulario (Page2/pgDados)
    * Chamado ao entrar em modo INCLUIR para garantir campos zerados
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE LimparCampos()
        LOCAL loc_oPg1
        loc_oPg1 = THIS.pgf_4c_Paginas.Page2.pgf_4c_DadosInternos.Page1

        TRY
            *-- ROW 1: Produto + Descricao + Status
            loc_oPg1.txt_4c_Cpro.Value          = ""
            loc_oPg1.txt_4c_Dpro.Value          = ""
            loc_oPg1.obj_4c_OpcSituacao.Value   = 1
            loc_oPg1.txt_4c_DtSituas.Value      = DATE()

            *-- ROW 2: Descritivo + CProEq + Cbar + LtMinsV
            loc_oPg1.txt_4c_DPro2s.Value        = ""
            loc_oPg1.txt_4c_CProEq.Value        = ""
            loc_oPg1.txt_4c_Cbar.Value          = 0
            loc_oPg1.txt_4c_LtMinsV.Value       = 0

            *-- ROW 3: Grupo + Merc + IdeCPros + EAN13 + ProdWeb
            loc_oPg1.txt_4c_Cgru.Value          = ""
            loc_oPg1.txt_4c_Dgru.Value          = ""
            loc_oPg1.txt_4c_Merc.Value          = ""
            loc_oPg1.txt_4c_IdeCPros.Value      = ""
            loc_oPg1.txt_4c_EAN13.Value         = 0
            loc_oPg1.obj_4c_ProdWeb.Value       = 1

            *-- ROW 4: Subgrupo + Variacao
            loc_oPg1.txt_4c_CSGru.Value         = ""
            loc_oPg1.txt_4c_DsGru.Value         = ""
            loc_oPg1.obj_4c_Variacao.Value      = 1

            *-- ROW 5: Linha + Garantia
            loc_oPg1.txt_4c_Lin.Value           = ""
            loc_oPg1.txt_4c_DLin.Value          = ""
            loc_oPg1.txt_4c_DiasGar.Value       = 0
            loc_oPg1.chk_4c_GarVit.Value        = 0

            *-- ROW 6: Colecao/Grupo de Venda + Obs3
            loc_oPg1.txt_4c_Col.Value           = ""
            loc_oPg1.txt_4c_DCol.Value          = ""
            loc_oPg1.txt_4c_Obs3.Value          = ""

            *-- ROW 7: Fornecedor + Obs1 + Obs2
            loc_oPg1.txt_4c_Ifor.Value          = ""
            loc_oPg1.txt_4c_Dfor.Value          = ""
            loc_oPg1.txt_4c_Obs1.Value          = ""
            loc_oPg1.txt_4c_Obs2.Value          = ""

            *-- ROW 8: Refs + Cor + Tam
            loc_oPg1.txt_4c_Refs.Value          = ""
            loc_oPg1.txt_4c_Cor.Value           = ""
            loc_oPg1.txt_4c_Tam.Value           = ""

            *-- ROW 9: Modelo
            loc_oPg1.txt_4c_CodFinP.Value       = ""
            loc_oPg1.txt_4c_DesFinP.Value       = ""

            *-- ROW 10: Acabamento
            loc_oPg1.txt_4c_Codacb.Value        = ""
            loc_oPg1.txt_4c_Dacb.Value          = ""

            *-- Quantidades
            loc_oPg1.txt_4c_Qmin.Value          = 0
            loc_oPg1.txt_4c_QtPed.Value         = 0

            *-- Dimensoes fisicas
            loc_oPg1.txt_4c_Altura.Value        = 0
            loc_oPg1.txt_4c_Largura.Value       = 0
            loc_oPg1.txt_4c_Diametro.Value      = 0

            *-- Peso
            loc_oPg1.txt_4c_PesoBs.Value        = 0
            loc_oPg1.txt_4c_Pmedio.Value        = 0

            *-- Ultima compra (somente leitura - limpa display)
            loc_oPg1.txt_4c_DtUltCompra.Value   = {}
            loc_oPg1.txt_4c_VUltCompra.Value    = 0
            loc_oPg1.txt_4c_MUltCompra.Value    = ""
            loc_oPg1.txt_4c_QtdUltComp.Value    = 0

            *-- Classificacao + Local
            loc_oPg1.txt_4c_Class.Value         = ""
            loc_oPg1.txt_4c_DClass.Value        = ""
            loc_oPg1.txt_4c_Local.Value         = ""

            *-- Precos e moedas
            loc_oPg1.txt_4c_Ctotal.Value        = 0
            loc_oPg1.txt_4c_Mctotal.Value       = ""
            loc_oPg1.txt_4c_Pvenda.Value        = 0
            loc_oPg1.txt_4c_Mpvenda.Value       = ""
            loc_oPg1.txt_4c_Fvenda.Value        = 0
            loc_oPg1.txt_4c_Mfvenda.Value       = ""

            *-- Unidades
            loc_oPg1.txt_4c_Cuni.Value          = ""
            loc_oPg1.txt_4c_Duni.Value          = ""
            loc_oPg1.txt_4c_Cunip.Value         = ""
            loc_oPg1.txt_4c_Dunip.Value         = ""

            *-- CheckBoxes
            loc_oPg1.chk_4c_Consig.Value        = 0
            loc_oPg1.chk_4c_FabrProprs.Value    = 0
            loc_oPg1.chk_4c_Encoms.Value        = 0

            *-- Volumes
            loc_oPg1.txt_4c_Volumes.Value       = 0

            *-- Memos
            loc_oPg1.edt_4c_DscCompras.Value    = ""
            loc_oPg1.edt_4c_DPro3s.Value        = ""
            loc_oPg1.edt_4c_ObsCompras.Value    = ""

            *-- Auditoria
            loc_oPg1.txt_4c_DtIncs.Value        = {}
            loc_oPg1.txt_4c_DataAlts.Value      = {}
            loc_oPg1.txt_4c_UsuIncs.Value       = ""
            loc_oPg1.txt_4c_UsuAlts.Value       = ALLTRIM(gc_4c_UsuarioLogado)

        CATCH TO loc_oErro
            MsgErro("Erro ao limpar campos:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * Destroy - Limpeza ao fechar formulario
    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
        IF USED("cursor_4c_Lista")
            USE IN cursor_4c_Lista
        ENDIF
        IF USED("cursor_4c_Dados")
            USE IN cursor_4c_Dados
        ENDIF
        IF !ISNULL(THIS.this_oBusinessObject)
            THIS.this_oBusinessObject = .NULL.
        ENDIF
        DODEFAULT()
    ENDPROC

ENDDEFINE


### BO (C:\4c\projeto\app\classes\ProdutoBO.prg):
*==============================================================================
* ProdutoBO.prg - Business Object para Cadastro de Produtos
* Tabela: SigCdPro | PK: cpros (C14)
* Data: 2026-04-09
*==============================================================================

DEFINE CLASS ProdutoBO AS BusinessBase

    *-- Identificacao
    this_cCpros     = ""   && C(14) - Codigo do produto (PK)
    this_cDpros     = ""   && C(65) - Descricao principal
    this_cDpro2s    = ""   && C(45) - Descricao secundaria (descritivo)

    *-- Classificacao/grupo
    this_cCgrus     = ""   && C(3)  - Grupo
    this_cSgrus     = ""   && C(6)  - Subgrupo
    this_cLinhas    = ""   && C(10) - Linha
    this_cColecoes  = ""   && C(10) - Colecao / Grupo de Venda
    this_cMercs     = ""   && C(3)  - Mercado
    this_cIdecpros  = ""   && C(3)  - Identificador
    this_cCclass    = ""   && C(3)  - Classificacao

    *-- Fornecedor
    this_cIfors     = ""   && C(10) - Codigo do fornecedor
    this_cReffs     = ""   && C(40) - Referencia do fornecedor

    *-- Codigos produto
    this_cCodfinp   = ""   && C(3)  - Codigo do modelo (finishing product)
    this_cCodacbs   = ""   && C(3)  - Codigo do acabamento
    this_cCodcors   = ""   && C(4)  - Codigo da cor
    this_cCodtams   = ""   && C(4)  - Codigo do tamanho
    this_cCproeqs   = ""   && C(14) - Produto equivalente

    *-- Status e datas
    this_nSituas    = 1    && N(1)  - Status: 1=Ativo, 2=Inativo
    this_dDatas     = {}   && Date  - Data do status
    this_dDtincs    = {}   && Date  - Data de inclusao (read-only)
    this_cUsuincs   = ""   && C(10) - Usuario de inclusao

    *-- Codigos de barra
    this_nCbars     = 0    && N(14,0) - Codigo de barra
    this_nEan13     = 0    && N(13,0) - EAN13/GTIN

    *-- Quantidades e lotes
    this_nLtminsv   = 0    && N(9,3) - Lote minimo de venda
    this_nQmins     = 0    && N(9,3) - Quantidade minima
    this_nQtped     = 0    && N(9,3) - Quantidade de pedido

    *-- Unidades
    this_cCunis     = ""   && C(3)  - Unidade (1)
    this_cCunips    = ""   && C(3)  - Unidade (2)

    *-- Pesos e dimensoes
    this_nPesobs    = 0    && N(7,3) - Peso bruto
    this_nPesoms    = 0    && N(8,3) - Peso medio/liquido

    *-- Localizacao
    this_cLocals    = ""   && C(10) - Local

    *-- Precos e custos
    this_nPvens     = 0    && N(11,5) - Preco de venda
    this_nFvendas   = 0    && N(7,3)  - Fator de venda
    this_nPcuss     = 0    && N(11,5) - Preco de custo
    this_cMoecs     = ""   && C(3)   - Moeda de custo
    this_cMoepvs    = ""   && C(3)   - Moeda de venda

    *-- Ultima compra
    this_dUltcomps  = {}   && Date  - Data da ultima compra
    this_nVultcomps = 0    && N(11,2) - Valor da ultima compra
    this_cMultcomps = ""   && C(3)   - Moeda da ultima compra
    this_nQultcomp  = 0    && N(9,3) - Qtde da ultima compra

    *-- Dias de garantia
    this_nDiasinas  = 0    && N(5,0) - Dias de garantia/inatividade

    *-- Checkboxes
    this_nConsigs   = 0    && N(1) - Consignado
    this_nFabrproprs= 0    && N(1) - Fabricacao propria
    this_nEncoms    = 0    && N(1) - Encomenda
    this_nChkfunds  = 0    && N(1) - Fundo

    *-- Observacoes
    this_cObspeds   = ""   && C(30) - Observacao 1
    this_cObspes    = ""   && C(30) - Observacao 2
    this_cObsetqs   = ""   && C(10) - Observacao componente

    *-- Memos (text fields)
    this_cDpro3s    = ""   && text  - Descricao completa
    this_cDsccompras= ""   && text  - Descricao compra
    this_cObscompras= ""   && text  - Observacao compra

    *-- Variacao e web
    this_nVarias    = 0    && N(1) - Variacao (0=nenhum, 1=cor-tam)
    this_nWebpros   = 0    && N(1) - Produto web (0=nenhum, 1=sim, 2=nao, 3=destaque)

    *-- Dimensoes
    this_nTamhs     = 0    && N(5,2) - Altura
    this_nTamls     = 0    && N(5,2) - Largura
    this_nTamps     = 0    && N(5,2) - Profundidade
    this_nVolumes   = 0    && N(3,0) - Volumes
    this_nTents     = 0    && N(3,0) - Entradas

    *--------------------------------------------------------------------------
    PROCEDURE Init()
    *--------------------------------------------------------------------------
        DODEFAULT()
        THIS.this_cTabela     = "SigCdPro"
        THIS.this_cCampoChave = "cpros"
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    PROCEDURE ObterChavePrimaria()
    *--------------------------------------------------------------------------
        RETURN THIS.this_cCpros
    ENDPROC

    *--------------------------------------------------------------------------
    * NovoRegistro - Limpa propriedades para inclusao
    *--------------------------------------------------------------------------
    PROCEDURE NovoRegistro()
        DODEFAULT()
        THIS.this_cCpros      = ""
        THIS.this_cDpros      = ""
        THIS.this_cDpro2s     = ""
        THIS.this_cCgrus      = ""
        THIS.this_cSgrus      = ""
        THIS.this_cLinhas     = ""
        THIS.this_cColecoes   = ""
        THIS.this_cMercs      = ""
        THIS.this_cIdecpros   = ""
        THIS.this_cCclass     = ""
        THIS.this_cIfors      = ""
        THIS.this_cReffs      = ""
        THIS.this_cCodfinp    = ""
        THIS.this_cCodacbs    = ""
        THIS.this_cCodcors    = ""
        THIS.this_cCodtams    = ""
        THIS.this_cCproeqs    = ""
        THIS.this_nSituas     = 1
        THIS.this_dDatas      = DATE()
        THIS.this_dDtincs     = DATE()
        THIS.this_cUsuincs    = gc_4c_UsuarioLogado
        THIS.this_nCbars      = 0
        THIS.this_nEan13      = 0
        THIS.this_nLtminsv    = 0
        THIS.this_nQmins      = 0
        THIS.this_nQtped      = 0
        THIS.this_cCunis      = ""
        THIS.this_cCunips     = ""
        THIS.this_nPesobs     = 0
        THIS.this_nPesoms     = 0
        THIS.this_cLocals     = ""
        THIS.this_nPvens      = 0
        THIS.this_nFvendas    = 1
        THIS.this_nPcuss      = 0
        THIS.this_cMoecs      = ""
        THIS.this_cMoepvs     = ""
        THIS.this_dUltcomps   = {}
        THIS.this_nVultcomps  = 0
        THIS.this_cMultcomps  = ""
        THIS.this_nQultcomp   = 0
        THIS.this_nDiasinas   = 0
        THIS.this_nConsigs    = 0
        THIS.this_nFabrproprs = 0
        THIS.this_nEncoms     = 0
        THIS.this_nChkfunds   = 0
        THIS.this_cObspeds    = ""
        THIS.this_cObspes     = ""
        THIS.this_cObsetqs    = ""
        THIS.this_cDpro3s     = ""
        THIS.this_cDsccompras = ""
        THIS.this_cObscompras = ""
        THIS.this_nVarias     = 0
        THIS.this_nWebpros    = 0
        THIS.this_nTamhs      = 0
        THIS.this_nTamls      = 0
        THIS.this_nTamps      = 0
        THIS.this_nVolumes    = 0
        THIS.this_nTents      = 0
    ENDPROC

    *--------------------------------------------------------------------------
    * EditarRegistro - Prepara para edicao (dados ja carregados via CarregarPorCodigo)
    *--------------------------------------------------------------------------
    PROCEDURE EditarRegistro()
        DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    * Buscar - Carrega cursor_4c_Dados com registros conforme filtro
    * par_cFiltro: "" = todos | "WHERE ..." = com filtro
    *--------------------------------------------------------------------------
    PROCEDURE Buscar(par_cFiltro)
        LOCAL loc_lResultado, loc_cSQL, loc_nRet, loc_aErros(1)
        loc_lResultado = .F.

        TRY
            IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
                loc_lResultado = .T.
            ELSE
                loc_cSQL = "SELECT " + ;
                    "ISNULL(CPros,'')       AS cpros, " + ;
                    "ISNULL(DPros,'')       AS dpros, " + ;
                    "ISNULL(DPro2s,'')      AS dpro2s, " + ;
                    "ISNULL(CGrus,'')       AS cgrus, " + ;
                    "ISNULL(SGrus,'')       AS sgrus, " + ;
                    "ISNULL(Linhas,'')      AS linhas, " + ;
                    "ISNULL(Colecoes,'')    AS colecoes, " + ;
                    "ISNULL(Mercs,'')       AS mercs, " + ;
                    "ISNULL(IdeCPros,'')    AS idecpros, " + ;
                    "ISNULL(CClass,'')      AS cclass, " + ;
                    "ISNULL(IFors,'')       AS ifors, " + ;
                    "ISNULL(Reffs,'')       AS reffs, " + ;
                    "ISNULL(CodFinP,'')     AS codfinp, " + ;
                    "ISNULL(CodAcbs,'')     AS codacbs, " + ;
                    "ISNULL(CodCors,'')     AS codcors, " + ;
                    "ISNULL(CodTams,'')     AS codtams, " + ;
                    "ISNULL(CProEqs,'')     AS cproeqs, " + ;
                    "ISNULL(Situas,1)       AS situas, " + ;
                    "ISNULL(Datas,GETDATE()) AS datas, " + ;
                    "ISNULL(DtIncs,GETDATE()) AS dtincs, " + ;
                    "ISNULL(UsuIncs,'')     AS usuincs, " + ;
                    "ISNULL(CBars,0)        AS cbars, " + ;
                    "ISNULL(EAN13,0)        AS ean13, " + ;
                    "ISNULL(LtMinsV,0)      AS ltminsv, " + ;
                    "ISNULL(QMins,0)        AS qmins, " + ;
                    "ISNULL(QtPed,0)        AS qtped, " + ;
                    "ISNULL(Locals,'')      AS locals, " + ;
                    "ISNULL(CUnis,'')       AS cunis, " + ;
                    "ISNULL(CUniPs,'')      AS cunips, " + ;
                    "ISNULL(PesoBS,0)       AS pesobs, " + ;
                    "ISNULL(PesoMs,0)       AS pesoms, " + ;
                    "ISNULL(PVens,0)        AS pvens, " + ;
                    "ISNULL(FVendas,1)      AS fvendas, " + ;
                    "ISNULL(PCuss,0)        AS pcuss, " + ;
                    "ISNULL(MoECs,'')       AS moecs, " + ;
                    "ISNULL(MoePVs,'')      AS moepvs, " + ;
                    "ISNULL(UltComps,NULL)  AS ultcomps, " + ;
                    "ISNULL(VultComps,0)    AS vultcomps, " + ;
                    "ISNULL(MultComps,'')   AS multcomps, " + ;
                    "ISNULL(qtdultcomp,0)   AS qultcomp, " + ;
                    "ISNULL(DiasINas,0)     AS diasinas, " + ;
                    "ISNULL(ConSigs,0)      AS consigs, " + ;
                    "ISNULL(FabrProprs,0)   AS fabrproprs, " + ;
                    "ISNULL(EnComs,0)       AS encoms, " + ;
                    "ISNULL(ChkFunds,0)     AS chkfunds, " + ;
                    "ISNULL(ObsPeds,'')     AS obspeds, " + ;
                    "ISNULL(ObsPes,'')      AS obspes, " + ;
                    "ISNULL(ObsEtqs,'')     AS obsetqs, " + ;
                    "ISNULL(DPro3s,'')      AS dpro3s, " + ;
                    "ISNULL(DscCompras,'')  AS dsccompras, " + ;
                    "ISNULL(ObsCompras,'')  AS obscompras, " + ;
                    "ISNULL(Varias,0)       AS varias, " + ;
                    "ISNULL(prodwebs,0)     AS webpros, " + ;
                    "ISNULL(TamHs,0)        AS tamhs, " + ;
                    "ISNULL(TamLs,0)        AS tamls, " + ;
                    "ISNULL(TamPs,0)        AS tamps, " + ;
                    "ISNULL(Volumes,0)      AS volumes, " + ;
                    "ISNULL(TEnts,0)        AS tents " + ;
                    "FROM SigCdPro " + par_cFiltro + " ORDER BY CPros"

                IF USED("cursor_4c_Temp_Dados")
                    USE IN cursor_4c_Temp_Dados
                ENDIF
                loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Temp_Dados")

                IF loc_nRet > 0
                    IF USED("cursor_4c_Dados")
                        USE IN cursor_4c_Dados
                    ENDIF
                    SELECT cursor_4c_Temp_Dados
                    IF RECCOUNT() > 0
                        SELECT * FROM cursor_4c_Temp_Dados INTO CURSOR cursor_4c_Dados READWRITE
                        SELECT cursor_4c_Dados
                    ELSE
                        SET NULL ON
                        CREATE CURSOR cursor_4c_Dados ;
                            (cpros C(14), dpros C(65), dpro2s C(45), cgrus C(3), sgrus C(6), ;
                             linhas C(10), colecoes C(10), mercs C(3), idecpros C(3), cclass C(3), ;
                             ifors C(10), reffs C(40), codfinp C(3), codacbs C(3), codcors C(4), ;
                             codtams C(4), cproeqs C(14), situas N(1,0), datas D, dtincs D, ;
                             usuincs C(10), cbars N(14,0), ean13 N(13,0), ltminsv N(9,3), ;
                             qmins N(9,3), qtped N(9,3), locals C(10), cunis C(3), cunips C(3), ;
                             pesobs N(7,3), pesoms N(8,3), pvens N(11,5), fvendas N(7,3), ;
                             pcuss N(11,5), moecs C(3), moepvs C(3), ultcomps D, ;
                             vultcomps N(11,2), multcomps C(3), qultcomp N(9,3), ;
                             diasinas N(5,0), consigs N(1,0), fabrproprs N(1,0), ;
                             encoms N(1,0), chkfunds N(1,0), obspeds C(30), obspes C(30), ;
                             obsetqs C(10), dpro3s C(254), dsccompras C(254), obscompras C(254), ;
                             varias N(1,0), webpros N(1,0), tamhs N(5,2), tamls N(5,2), ;
                             tamps N(5,2), volumes N(3,0), tents N(3,0))
                        SET NULL OFF
                    ENDIF
                    IF USED("cursor_4c_Temp_Dados")
                        USE IN cursor_4c_Temp_Dados
                    ENDIF
                    loc_lResultado = .T.
                ELSE
                    AERROR(loc_aErros)
                    THIS.this_cMensagemErro = "Erro SQL ao buscar produtos: " + TRANSFORM(loc_aErros(1,2))
                    IF USED("cursor_4c_Temp_Dados")
                        USE IN cursor_4c_Temp_Dados
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro ao buscar produtos")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarPorCodigo - Carrega dados de um produto pelo codigo
    *--------------------------------------------------------------------------
    PROCEDURE CarregarPorCodigo(par_cCodigo)
        LOCAL loc_lResultado, loc_cSQL, loc_nRet, loc_aErros(1)
        loc_lResultado = .F.

        TRY
            IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
                loc_lResultado = .T.
            ELSE
                loc_cSQL = "SELECT " + ;
                    "ISNULL(CPros,'')       AS cpros, " + ;
                    "ISNULL(DPros,'')       AS dpros, " + ;
                    "ISNULL(DPro2s,'')      AS dpro2s, " + ;
                    "ISNULL(CGrus,'')       AS cgrus, " + ;
                    "ISNULL(SGrus,'')       AS sgrus, " + ;
                    "ISNULL(Linhas,'')      AS linhas, " + ;
                    "ISNULL(Colecoes,'')    AS colecoes, " + ;
                    "ISNULL(Mercs,'')       AS mercs, " + ;
                    "ISNULL(IdeCPros,'')    AS idecpros, " + ;
                    "ISNULL(CClass,'')      AS cclass, " + ;
                    "ISNULL(IFors,'')       AS ifors, " + ;
                    "ISNULL(Reffs,'')       AS reffs, " + ;
                    "ISNULL(CodFinP,'')     AS codfinp, " + ;
                    "ISNULL(CodAcbs,'')     AS codacbs, " + ;
                    "ISNULL(CodCors,'')     AS codcors, " + ;
                    "ISNULL(CodTams,'')     AS codtams, " + ;
                    "ISNULL(CProEqs,'')     AS cproeqs, " + ;
                    "ISNULL(Situas,1)       AS situas, " + ;
                    "CONVERT(date,ISNULL(Datas,GETDATE())) AS datas, " + ;
                    "CONVERT(date,ISNULL(DtIncs,GETDATE())) AS dtincs, " + ;
                    "ISNULL(UsuIncs,'')     AS usuincs, " + ;
                    "ISNULL(CBars,0)        AS cbars, " + ;
                    "ISNULL(EAN13,0)        AS ean13, " + ;
                    "ISNULL(LtMinsV,0)      AS ltminsv, " + ;
                    "ISNULL(QMins,0)        AS qmins, " + ;
                    "ISNULL(QtPed,0)        AS qtped, " + ;
                    "ISNULL(Locals,'')      AS locals, " + ;
                    "ISNULL(CUnis,'')       AS cunis, " + ;
                    "ISNULL(CUniPs,'')      AS cunips, " + ;
                    "ISNULL(PesoBS,0)       AS pesobs, " + ;
                    "ISNULL(PesoMs,0)       AS pesoms, " + ;
                    "ISNULL(PVens,0)        AS pvens, " + ;
                    "ISNULL(FVendas,1)      AS fvendas, " + ;
                    "ISNULL(PCuss,0)        AS pcuss, " + ;
                    "ISNULL(MoECs,'')       AS moecs, " + ;
                    "ISNULL(MoePVs,'')      AS moepvs, " + ;
                    "CONVERT(date,ISNULL(UltComps,NULL)) AS ultcomps, " + ;
                    "ISNULL(VultComps,0)    AS vultcomps, " + ;
                    "ISNULL(MultComps,'')   AS multcomps, " + ;
                    "ISNULL(qtdultcomp,0)   AS qultcomp, " + ;
                    "ISNULL(DiasINas,0)     AS diasinas, " + ;
                    "ISNULL(ConSigs,0)      AS consigs, " + ;
                    "ISNULL(FabrProprs,0)   AS fabrproprs, " + ;
                    "ISNULL(EnComs,0)       AS encoms, " + ;
                    "ISNULL(ChkFunds,0)     AS chkfunds, " + ;
                    "ISNULL(ObsPeds,'')     AS obspeds, " + ;
                    "ISNULL(ObsPes,'')      AS obspes, " + ;
                    "ISNULL(ObsEtqs,'')     AS obsetqs, " + ;
                    "ISNULL(CONVERT(varchar(2000),DPro3s),'')     AS dpro3s, " + ;
                    "ISNULL(CONVERT(varchar(2000),DscCompras),'') AS dsccompras, " + ;
                    "ISNULL(CONVERT(varchar(2000),ObsCompras),'') AS obscompras, " + ;
                    "ISNULL(Varias,0)       AS varias, " + ;
                    "ISNULL(prodwebs,0)     AS webpros, " + ;
                    "ISNULL(TamHs,0)        AS tamhs, " + ;
                    "ISNULL(TamLs,0)        AS tamls, " + ;
                    "ISNULL(TamPs,0)        AS tamps, " + ;
                    "ISNULL(Volumes,0)      AS volumes, " + ;
                    "ISNULL(TEnts,0)        AS tents " + ;
                    "FROM SigCdPro " + ;
                    "WHERE CPros = " + EscaparSQL(ALLTRIM(par_cCodigo))

                IF USED("cursor_4c_CarregaPro")
                    USE IN cursor_4c_CarregaPro
                ENDIF
                loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_CarregaPro")

                IF loc_nRet > 0 AND RECCOUNT("cursor_4c_CarregaPro") > 0
                    THIS.CarregarDoCursor("cursor_4c_CarregaPro")
                    loc_lResultado = .T.
                ELSE
                    THIS.this_cMensagemErro = "Produto n" + CHR(227) + "o encontrado: " + ALLTRIM(par_cCodigo)
                ENDIF

                IF USED("cursor_4c_CarregaPro")
                    USE IN cursor_4c_CarregaPro
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro ao carregar produto")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Popula propriedades a partir de cursor ativo
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE CarregarDoCursor(par_cAliasCursor)
        SELECT (par_cAliasCursor)
        THIS.this_cCpros      = ALLTRIM(cpros)
        THIS.this_cDpros      = ALLTRIM(dpros)
        THIS.this_cDpro2s     = ALLTRIM(dpro2s)
        THIS.this_cCgrus      = ALLTRIM(cgrus)
        THIS.this_cSgrus      = ALLTRIM(sgrus)
        THIS.this_cLinhas     = ALLTRIM(linhas)
        THIS.this_cColecoes   = ALLTRIM(colecoes)
        THIS.this_cMercs      = ALLTRIM(mercs)
        THIS.this_cIdecpros   = ALLTRIM(idecpros)
        THIS.this_cCclass     = ALLTRIM(cclass)
        THIS.this_cIfors      = ALLTRIM(ifors)
        THIS.this_cReffs      = ALLTRIM(reffs)
        THIS.this_cCodfinp    = ALLTRIM(codfinp)
        THIS.this_cCodacbs    = ALLTRIM(codacbs)
        THIS.this_cCodcors    = ALLTRIM(codcors)
        THIS.this_cCodtams    = ALLTRIM(codtams)
        THIS.this_cCproeqs    = ALLTRIM(cproeqs)
        THIS.this_nSituas     = NVL(situas, 1)
        THIS.this_dDatas      = IIF(EMPTY(datas), DATE(), datas)
        THIS.this_dDtincs     = IIF(EMPTY(dtincs), DATE(), dtincs)
        THIS.this_cUsuincs    = ALLTRIM(usuincs)
        THIS.this_nCbars      = NVL(cbars, 0)
        THIS.this_nEan13      = NVL(ean13, 0)
        THIS.this_nLtminsv    = NVL(ltminsv, 0)
        THIS.this_nQmins      = NVL(qmins, 0)
        THIS.this_nQtped      = NVL(qtped, 0)
        THIS.this_cLocals     = ALLTRIM(locals)
        THIS.this_cCunis      = ALLTRIM(cunis)
        THIS.this_cCunips     = ALLTRIM(cunips)
        THIS.this_nPesobs     = NVL(pesobs, 0)
        THIS.this_nPesoms     = NVL(pesoms, 0)
        THIS.this_nPvens      = NVL(pvens, 0)
        THIS.this_nFvendas    = NVL(fvendas, 1)
        THIS.this_nPcuss      = NVL(pcuss, 0)
        THIS.this_cMoecs      = ALLTRIM(moecs)
        THIS.this_cMoepvs     = ALLTRIM(moepvs)
        THIS.this_dUltcomps   = IIF(EMPTY(ultcomps), {}, ultcomps)
        THIS.this_nVultcomps  = NVL(vultcomps, 0)
        THIS.this_cMultcomps  = ALLTRIM(multcomps)
        THIS.this_nQultcomp   = NVL(qultcomp, 0)
        THIS.this_nDiasinas   = NVL(diasinas, 0)
        THIS.this_nConsigs    = NVL(consigs, 0)
        THIS.this_nFabrproprs = NVL(fabrproprs, 0)
        THIS.this_nEncoms     = NVL(encoms, 0)
        THIS.this_nChkfunds   = NVL(chkfunds, 0)
        THIS.this_cObspeds    = ALLTRIM(obspeds)
        THIS.this_cObspes     = ALLTRIM(obspes)
        THIS.this_cObsetqs    = ALLTRIM(obsetqs)
        THIS.this_cDpro3s     = ALLTRIM(dpro3s)
        THIS.this_cDsccompras = ALLTRIM(dsccompras)
        THIS.this_cObscompras = ALLTRIM(obscompras)
        THIS.this_nVarias     = NVL(varias, 0)
        THIS.this_nWebpros    = NVL(webpros, 0)
        THIS.this_nTamhs      = NVL(tamhs, 0)
        THIS.this_nTamls      = NVL(tamls, 0)
        THIS.this_nTamps      = NVL(tamps, 0)
        THIS.this_nVolumes    = NVL(volumes, 0)
        THIS.this_nTents      = NVL(tents, 0)
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir - Insere novo produto em SigCdPro
    *--------------------------------------------------------------------------
    PROCEDURE Inserir()
        LOCAL loc_lResultado, loc_cSQL, loc_nRet
        loc_lResultado = .F.

        TRY
            *-- Verificar codigo duplicado
            IF TYPE("gnConnHandle") = "N" AND gnConnHandle > 0
                LOCAL loc_nExiste
                loc_nExiste = 0
                SQLEXEC(gnConnHandle, "SELECT COUNT(*) AS nExiste FROM SigCdPro WHERE CPros = " + ;
                    EscaparSQL(THIS.this_cCpros), "cursor_4c_ChkPro")
                IF USED("cursor_4c_ChkPro")
                    SELECT cursor_4c_ChkPro
                    loc_nExiste = nExiste
                    USE IN cursor_4c_ChkPro
                ENDIF
                IF loc_nExiste > 0
                    THIS.this_cMensagemErro = "Produto j" + CHR(225) + " existe: " + ALLTRIM(THIS.this_cCpros)
                    loc_lResultado = .F.
                ENDIF
            ENDIF

            loc_cSQL = THIS.MontarSQL_INSERT()
            loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nRet > 0
                THIS.RegistrarAuditoria("INSERT")
                loc_lResultado = .T.
            ELSE
                LOCAL loc_aErros(1)
                AERROR(loc_aErros)
                THIS.this_cMensagemErro = "Erro ao inserir produto: " + TRANSFORM(loc_aErros(1,2))
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro ao inserir produto")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - Atualiza produto existente
    *--------------------------------------------------------------------------
    PROCEDURE Atualizar()
        LOCAL loc_lResultado, loc_cSQL, loc_nRet
        loc_lResultado = .F.

        TRY
            loc_cSQL = THIS.MontarSQL_UPDATE()
            loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nRet > 0
                THIS.RegistrarAuditoria("UPDATE")
                loc_lResultado = .T.
            ELSE
                LOCAL loc_aErros(1)
                AERROR(loc_aErros)
                THIS.this_cMensagemErro = "Erro ao atualizar produto: " + TRANSFORM(loc_aErros(1,2))
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro ao atualizar produto")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * ExecutarExclusao - Remove produto (chamado por Excluir() da BusinessBase)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ExecutarExclusao()
        LOCAL loc_lResultado, loc_nRet
        loc_lResultado = .F.

        TRY
            loc_nRet = SQLEXEC(gnConnHandle, "DELETE FROM SigCdPro WHERE CPros = " + ;
                EscaparSQL(THIS.this_cCpros))
            IF loc_nRet > 0
                THIS.RegistrarAuditoria("DELETE")
                loc_lResultado = .T.
            ELSE
                THIS.this_cMensagemErro = "Erro ao excluir produto."
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro ao excluir produto")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * MontarSQL_INSERT - Gera SQL de insercao (PROTECTED)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE MontarSQL_INSERT()
        LOCAL loc_cSQL
        loc_cSQL = "INSERT INTO SigCdPro " + ;
            "(CPros, DPros, DPro2s, CGrus, SGrus, Linhas, Colecoes, Mercs, IdeCPros, CClass, " + ;
            " IFors, Reffs, CodFinP, CodAcbs, CodCors, CodTams, CProEqs, Situas, Datas, DtIncs, " + ;
            " UsuIncs, CBars, EAN13, LtMinsV, QMins, QtPed, Locals, CUnis, CUniPs, PesoBS, PesoMs, " + ;
            " PVens, FVendas, PCuss, MoECs, MoePVs, UltComps, VultComps, MultComps, qtdultcomp, " + ;
            " DiasINas, ConSigs, FabrProprs, EnComs, ChkFunds, ObsPeds, ObsPes, " + ;
            " ObsEtqs, DPro3s, DscCompras, ObsCompras, Varias, prodwebs, TamHs, TamLs, TamPs, " + ;
            " Volumes, TEnts) " + ;
            "VALUES (" + ;
            EscaparSQL(THIS.this_cCpros)                     + ", " + ;
            EscaparSQL(THIS.this_cDpros)                     + ", " + ;
            EscaparSQL(THIS.this_cDpro2s)                    + ", " + ;
            EscaparSQL(PADR(THIS.this_cCgrus,3))             + ", " + ;
            EscaparSQL(PADR(THIS.this_cSgrus,6))             + ", " + ;
            EscaparSQL(PADR(THIS.this_cLinhas,10))           + ", " + ;
            EscaparSQL(PADR(THIS.this_cColecoes,10))         + ", " + ;
            EscaparSQL(PADR(THIS.this_cMercs,3))             + ", " + ;
            EscaparSQL(PADR(THIS.this_cIdecpros,3))          + ", " + ;
            EscaparSQL(PADR(THIS.this_cCclass,3))            + ", " + ;
            EscaparSQL(PADR(THIS.this_cIfors,10))            + ", " + ;
            EscaparSQL(THIS.this_cReffs)                     + ", " + ;
            EscaparSQL(PADR(THIS.this_cCodfinp,3))           + ", " + ;
            EscaparSQL(PADR(THIS.this_cCodacbs,3))           + ", " + ;
            EscaparSQL(PADR(THIS.this_cCodcors,4))           + ", " + ;
            EscaparSQL(PADR(THIS.this_cCodtams,4))           + ", " + ;
            EscaparSQL(THIS.this_cCproeqs)                   + ", " + ;
            FormatarNumeroSQL(THIS.this_nSituas)              + ", " + ;
            FormatarDataSQL(THIS.this_dDatas)                 + ", " + ;
            FormatarDataSQL(DATE())                           + ", " + ;
            EscaparSQL(gc_4c_UsuarioLogado)                  + ", " + ;
            FormatarNumeroSQL(THIS.this_nCbars)               + ", " + ;
            FormatarNumeroSQL(THIS.this_nEan13)               + ", " + ;
            FormatarNumeroSQL(THIS.this_nLtminsv)             + ", " + ;
            FormatarNumeroSQL(THIS.this_nQmins)               + ", " + ;
            FormatarNumeroSQL(THIS.this_nQtped)               + ", " + ;
            EscaparSQL(PADR(THIS.this_cLocals,10))           + ", " + ;
            EscaparSQL(PADR(THIS.this_cCunis,3))             + ", " + ;
            EscaparSQL(PADR(THIS.this_cCunips,3))            + ", " + ;
            FormatarNumeroSQL(THIS.this_nPesobs)              + ", " + ;
            FormatarNumeroSQL(THIS.this_nPesoms)              + ", " + ;
            FormatarNumeroSQL(THIS.this_nPvens)               + ", " + ;
            FormatarNumeroSQL(THIS.this_nFvendas)             + ", " + ;
            FormatarNumeroSQL(THIS.this_nPcuss)               + ", " + ;
            EscaparSQL(PADR(THIS.this_cMoecs,3))             + ", " + ;
            EscaparSQL(PADR(THIS.this_cMoepvs,3))            + ", " + ;
            FormatarDataSQL(THIS.this_dUltcomps)              + ", " + ;
            FormatarNumeroSQL(THIS.this_nVultcomps)           + ", " + ;
            EscaparSQL(PADR(THIS.this_cMultcomps,3))          + ", " + ;
            FormatarNumeroSQL(THIS.this_nQultcomp)            + ", " + ;
            FormatarNumeroSQL(THIS.this_nDiasinas)            + ", " + ;
            FormatarNumeroSQL(THIS.this_nConsigs)             + ", " + ;
            FormatarNumeroSQL(THIS.this_nFabrproprs)          + ", " + ;
            FormatarNumeroSQL(THIS.this_nEncoms)              + ", " + ;
            FormatarNumeroSQL(THIS.this_nChkfunds)            + ", " + ;
            EscaparSQL(THIS.this_cObspeds)                   + ", " + ;
            EscaparSQL(THIS.this_cObspes)                    + ", " + ;
            EscaparSQL(THIS.this_cObsetqs)                   + ", " + ;
            EscaparSQL(THIS.this_cDpro3s)                    + ", " + ;
            EscaparSQL(THIS.this_cDsccompras)                + ", " + ;
            EscaparSQL(THIS.this_cObscompras)                + ", " + ;
            FormatarNumeroSQL(THIS.this_nVarias)              + ", " + ;
            FormatarNumeroSQL(THIS.this_nWebpros)             + ", " + ;
            FormatarNumeroSQL(THIS.this_nTamhs)               + ", " + ;
            FormatarNumeroSQL(THIS.this_nTamls)               + ", " + ;
            FormatarNumeroSQL(THIS.this_nTamps)               + ", " + ;
            FormatarNumeroSQL(THIS.this_nVolumes)             + ", " + ;
            FormatarNumeroSQL(THIS.this_nTents)               + ")"

        RETURN loc_cSQL
    ENDPROC

    *--------------------------------------------------------------------------
    * MontarSQL_UPDATE - Gera SQL de atualizacao (PROTECTED)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE MontarSQL_UPDATE()
        LOCAL loc_cSQL
        loc_cSQL = "UPDATE SigCdPro SET " + ;
            "DPros = "       + EscaparSQL(THIS.this_cDpros)              + ", " + ;
            "DPro2s = "      + EscaparSQL(THIS.this_cDpro2s)             + ", " + ;
            "CGrus = "       + EscaparSQL(PADR(THIS.this_cCgrus,3))      + ", " + ;
            "SGrus = "       + EscaparSQL(PADR(THIS.this_cSgrus,6))      + ", " + ;
            "Linhas = "      + EscaparSQL(PADR(THIS.this_cLinhas,10))    + ", " + ;
            "Colecoes = "    + EscaparSQL(PADR(THIS.this_cColecoes,10))  + ", " + ;
            "Mercs = "       + EscaparSQL(PADR(THIS.this_cMercs,3))      + ", " + ;
            "IdeCPros = "    + EscaparSQL(PADR(THIS.this_cIdecpros,3))   + ", " + ;
            "CClass = "      + EscaparSQL(PADR(THIS.this_cCclass,3))     + ", " + ;
            "IFors = "       + EscaparSQL(PADR(THIS.this_cIfors,10))     + ", " + ;
            "Reffs = "       + EscaparSQL(THIS.this_cReffs)              + ", " + ;
            "CodFinP = "     + EscaparSQL(PADR(THIS.this_cCodfinp,3))    + ", " + ;
            "CodAcbs = "     + EscaparSQL(PADR(THIS.this_cCodacbs,3))    + ", " + ;
            "CodCors = "     + EscaparSQL(PADR(THIS.this_cCodcors,4))    + ", " + ;
            "CodTams = "     + EscaparSQL(PADR(THIS.this_cCodtams,4))    + ", " + ;
            "CProEqs = "     + EscaparSQL(THIS.this_cCproeqs)            + ", " + ;
            "Situas = "      + FormatarNumeroSQL(THIS.this_nSituas)       + ", " + ;
            "Datas = "       + FormatarDataSQL(THIS.this_dDatas)          + ", " + ;
            "CBars = "       + FormatarNumeroSQL(THIS.this_nCbars)        + ", " + ;
            "EAN13 = "       + FormatarNumeroSQL(THIS.this_nEan13)        + ", " + ;
            "LtMinsV = "     + FormatarNumeroSQL(THIS.this_nLtminsv)      + ", " + ;
            "QMins = "       + FormatarNumeroSQL(THIS.this_nQmins)        + ", " + ;
            "QtPed = "       + FormatarNumeroSQL(THIS.this_nQtped)       + ", " + ;
            "Locals = "      + EscaparSQL(PADR(THIS.this_cLocals,10))    + ", " + ;
            "CUnis = "       + EscaparSQL(PADR(THIS.this_cCunis,3))      + ", " + ;
            "CUniPs = "      + EscaparSQL(PADR(THIS.this_cCunips,3))     + ", " + ;
            "PesoBS = "      + FormatarNumeroSQL(THIS.this_nPesobs)       + ", " + ;
            "PesoMs = "      + FormatarNumeroSQL(THIS.this_nPesoms)       + ", " + ;
            "PVens = "       + FormatarNumeroSQL(THIS.this_nPvens)        + ", " + ;
            "FVendas = "     + FormatarNumeroSQL(THIS.this_nFvendas)      + ", " + ;
            "PCuss = "       + FormatarNumeroSQL(THIS.this_nPcuss)        + ", " + ;
            "MoECs = "       + EscaparSQL(PADR(THIS.this_cMoecs,3))      + ", " + ;
            "MoePVs = "      + EscaparSQL(PADR(THIS.this_cMoepvs,3))     + ", " + ;
            "UltComps = "    + FormatarDataSQL(THIS.this_dUltcomps)       + ", " + ;
            "VultComps = "   + FormatarNumeroSQL(THIS.this_nVultcomps)    + ", " + ;
            "MultComps = "   + EscaparSQL(PADR(THIS.this_cMultcomps,3))   + ", " + ;
            "qtdultcomp = "  + FormatarNumeroSQL(THIS.this_nQultcomp)     + ", " + ;
            "DiasINas = "    + FormatarNumeroSQL(THIS.this_nDiasinas)     + ", " + ;
            "ConSigs = "     + FormatarNumeroSQL(THIS.this_nConsigs)      + ", " + ;
            "FabrProprs = "  + FormatarNumeroSQL(THIS.this_nFabrproprs)   + ", " + ;
            "EnComs = "      + FormatarNumeroSQL(THIS.this_nEncoms)       + ", " + ;
            "ChkFunds = "    + FormatarNumeroSQL(THIS.this_nChkfunds)    + ", " + ;
            "ObsPeds = "     + EscaparSQL(THIS.this_cObspeds)            + ", " + ;
            "ObsPes = "      + EscaparSQL(THIS.this_cObspes)             + ", " + ;
            "ObsEtqs = "     + EscaparSQL(THIS.this_cObsetqs)            + ", " + ;
            "DPro3s = "      + EscaparSQL(THIS.this_cDpro3s)             + ", " + ;
            "DscCompras = "  + EscaparSQL(THIS.this_cDsccompras)         + ", " + ;
            "ObsCompras = "  + EscaparSQL(THIS.this_cObscompras)         + ", " + ;
            "Varias = "      + FormatarNumeroSQL(THIS.this_nVarias)       + ", " + ;
            "prodwebs = "    + FormatarNumeroSQL(THIS.this_nWebpros)      + ", " + ;
            "TamHs = "       + FormatarNumeroSQL(THIS.this_nTamhs)        + ", " + ;
            "TamLs = "       + FormatarNumeroSQL(THIS.this_nTamls)        + ", " + ;
            "TamPs = "       + FormatarNumeroSQL(THIS.this_nTamps)        + ", " + ;
            "Volumes = "     + FormatarNumeroSQL(THIS.this_nVolumes)      + ", " + ;
            "TEnts = "       + FormatarNumeroSQL(THIS.this_nTents)        + " " + ;
            "WHERE CPros = " + EscaparSQL(THIS.this_cCpros)

        RETURN loc_cSQL
    ENDPROC

ENDDEFINE


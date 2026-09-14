# CORRIGIR ERRO DE RUNTIME VFP9

## TAREFA OBRIGATORIA
O formulario VFP9 apresentou erro de runtime durante teste automatizado.
Voce DEVE corrigir o erro e salvar os arquivos corrigidos usando Write tool.

## ERRO DETECTADO
- Etapa: 06b_testeAutomatico
- Tentativa: 1/10
- Mensagem: Testes automaticos: 67% < 100%. Falhas: Teste 'CarregarLista': Nenhum cursor padrao foi criado (cursor_4c_Dados/Lista/Busca/etc); Teste 'ModoIncluir': Property ALTERNARPAGINA is not found. | Detalhes: Linha: 412; Teste 'ModoVisualizar': Property AJUSTARBOTOESPORMODO is not found. | Detalhes: Linha: 542

## CONTEXTO DO ERRO

### LOG DA ETAPA (06b_testeAutomatico):
[2026-06-19 08:20:20] [INFO] === VFP EXECUTOR v2.0 ===
[2026-06-19 08:20:20] [INFO] Config FPW: (nao fornecido)
[2026-06-19 08:20:20] [INFO] Script PRG: C:\4c\projeto\app\utils\TesteAutomatico.prg
[2026-06-19 08:20:20] [INFO] Timeout: 300 segundos
[2026-06-19 08:20:20] [INFO] Wrapper PRG criado para parametros: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_o5phn22x.prg
[2026-06-19 08:20:20] [INFO] Conteudo do wrapper:
[2026-06-19 08:20:20] [INFO] * Auto-generated wrapper for parameters
* Script: C:\4c\projeto\app\utils\TesteAutomatico.prg
* Parameters: 'Formsigpdmp7', 'C:\4c\tasks\task148', 'CRUD'

* Anti-dialog protections for unattended execution
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
SET NOTIFY OFF
SYS(2335, 0)

DO "C:\4c\projeto\app\utils\TesteAutomatico" WITH 'Formsigpdmp7', 'C:\4c\tasks\task148', 'CRUD'
QUIT

[2026-06-19 08:20:20] [INFO] Comando VFP: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_o5phn22x.prg
[2026-06-19 08:20:20] [INFO] VFP output esperado em: C:\4c\tasks\task148\vfp_output.txt
[2026-06-19 08:20:20] [INFO] Executando Visual FoxPro 9...
[2026-06-19 08:20:20] [INFO] Comando completo: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_o5phn22x.prg
[2026-06-19 08:20:20] [INFO] Executando: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_o5phn22x.prg
[2026-06-19 08:20:20] [INFO] Timeout configurado: 300 segundos
[2026-06-19 08:20:33] [INFO] VFP9 finalizou normalmente com exit code: 
[2026-06-19 08:20:33] [INFO] VFP9 finalizado em 12.9320566 segundos
[2026-06-19 08:20:33] [INFO] Exit Code: 
[2026-06-19 08:20:33] [INFO] 
[2026-06-19 08:20:33] [INFO] Arquivos temporarios preservados para inspecao:
[2026-06-19 08:20:33] [INFO]   Wrapper.prg: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_o5phn22x.prg
[2026-06-19 08:20:33] [INFO] 
[2026-06-19 08:20:33] [INFO] === Conteudo do Wrapper.prg temporario ===
[2026-06-19 08:20:33] [INFO] * Auto-generated wrapper for parameters
[2026-06-19 08:20:33] [INFO] * Script: C:\4c\projeto\app\utils\TesteAutomatico.prg
[2026-06-19 08:20:33] [INFO] * Parameters: 'Formsigpdmp7', 'C:\4c\tasks\task148', 'CRUD'
[2026-06-19 08:20:33] [INFO] 
[2026-06-19 08:20:33] [INFO] * Anti-dialog protections for unattended execution
[2026-06-19 08:20:33] [INFO] SET SAFETY OFF
[2026-06-19 08:20:33] [INFO] SET RESOURCE OFF
[2026-06-19 08:20:33] [INFO] SET TALK OFF
[2026-06-19 08:20:33] [INFO] SET NOTIFY OFF
[2026-06-19 08:20:33] [INFO] SYS(2335, 0)
[2026-06-19 08:20:33] [INFO] 
[2026-06-19 08:20:33] [INFO] DO "C:\4c\projeto\app\utils\TesteAutomatico" WITH 'Formsigpdmp7', 'C:\4c\tasks\task148', 'CRUD'
[2026-06-19 08:20:33] [INFO] QUIT
[2026-06-19 08:20:33] [INFO] 
[2026-06-19 08:20:33] [INFO] === Fim do Wrapper.prg ===
[2026-06-19 08:20:33] [WARN] AVISO: VFP9 retornou exit code  (normal para VFP9 GUI - validar pelo arquivo de saida)


### RESULTADO DOS TESTES (teste_resultado.json):
{
  "formClass": "Formsigpdmp7",
  "timestamp": "20260619082032",
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
      "passou": false,
      "erro": "Property ALTERNARPAGINA is not found.",
      "detalhes": "Linha: 412"
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
    "passou": 6,
    "falhou": 3,
    "percentual": 67
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

### FORM (C:\4c\projeto\app\forms\cadastros\Formsigpdmp7.prg):
*==============================================================================
* Formsigpdmp7.prg - Formulario de Movimentacao por Funcionario
* Tabela: SigCdNec | PK: cidchaves
* Legado: SIGPDMP7.SCX (frmcadastro)
* Fase 3/8: Estrutura Base - PageFrame, containers principais, metodos base
*==============================================================================

DEFINE CLASS Formsigpdmp7 AS FormBase

    *-- Propriedades visuais (PILAR 1 - UX FIDELITY)
    Height       = 600
    Width        = 1000
    AutoCenter   = .T.
    ShowWindow   = 1
    WindowType   = 1
    ControlBox   = .F.
    Closable     = .F.
    MaxButton    = .F.
    MinButton    = .T.
    TitleBar     = 0
    ClipControls = .F.
    Themes       = .F.
    BorderStyle  = 2
    FontName     = "Tahoma"
    ForeColor    = RGB(90, 90, 90)
    DataSession  = 2

    *-- Business Object e mensagem de erro
    this_oBusinessObject = .NULL.
    this_cMensagemErro   = ""

    *-- Estado do movimento corrente
    this_cDopp        = ""    && Operacao/documento corrente (legado: _Dopp)
    this_cPQuery      = ""    && Filtro/query recebido no Init (legado: pQuery)
    this_oParentForm  = .NULL. && Referencia ao form pai (legado: ParentForm)
    this_cPcEscolha   = ""    && Modo: INSERIR/CONSULTAR/ALTERAR/EXCLUIR/PROCURAR
    this_lEditaOrig   = .T.   && Permite editar conta de origem (legado: editaorigem)
    this_lAtFoco      = .F.   && Controla SetFocus no Activate (legado: AtFoco)
    this_cTitulo      = ""    && Titulo da operacao corrente (legado: Titulo)
    this_cPEmps       = ""    && Empresa selecionada no filtro

    *-- Cache de nomes dos containers Origem/Destino/Responsavel
    this_cNomeContaos = ""    && Nome da conta de Origem (legado: TmpCli.RClis via Origem)
    this_cNomeContads = ""    && Nome da conta de Destino
    this_cNomeVends   = ""    && Nome da conta do Responsavel

    *--------------------------------------------------------------------------
    * Init - Captura parametros opcionais (legado: LParameters pQuery, pForm)
    * pQuery : filtro/query para a lista (WHERE livre ou valor de busca)
    * pForm  : referencia ao formulario pai que abriu este form
    *--------------------------------------------------------------------------
    PROCEDURE Init(par_cQuery, par_oFormPai)
        THIS.this_cPQuery    = IIF(VARTYPE(par_cQuery)   = "C", ALLTRIM(par_cQuery), "")
        THIS.this_oParentForm = IIF(VARTYPE(par_oFormPai) = "O", par_oFormPai, .NULL.)
        IF VARTYPE(par_oFormPai) = "O" AND PEMSTATUS(par_oFormPai, "cCodEmpresa", 5)
            THIS.this_cPEmps = ALLTRIM(par_oFormPai.cCodEmpresa)
        ENDIF
        RETURN DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    * InicializarForm - Chamado pelo FormBase.Init()
    * Cria BO, cursores de trabalho, monta PageFrame e carrega lista inicial
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            THIS.Caption = "Movimenta" + CHR(231) + CHR(227) + "o por Funcion" + CHR(225) + "rio"

            THIS.this_oBusinessObject = CREATEOBJECT("sigpdmp7BO")

            IF VARTYPE(THIS.this_oBusinessObject) != "O"
                MostrarErro("Erro ao criar sigpdmp7BO", "Erro Cr" + CHR(237) + "tico")
            ELSE
                *-- Cursor placeholder para grid de lista (SigCdNec - colunas do SELECT do BO)
                IF !USED("cursor_4c_Dados")
                    SET NULL ON
                    CREATE CURSOR cursor_4c_Dados (;
                        cidchaves C(20), empdnps C(33), emps C(3),;
                        dopps C(20), numps N(10,0), datas D,;
                        totpesos N(11,3), usuars C(10),;
                        grupoos C(10), contaos C(10),;
                        grupods C(10), contads C(10))
                    SET NULL OFF
                ENDIF

                *-- Cursor placeholder para GradeOperacao (TmpOperacao - legado: criacursor)
                IF !USED("TmpOperacao")
                    SET NULL ON
                    CREATE CURSOR TmpOperacao (Codigos N(12,0))
                    SET NULL OFF
                ENDIF

                THIS.ConfigurarPageFrame()
                THIS.ConfigurarPaginaLista()
                THIS.ConfigurarPaginaDados()

                THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
                THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption

                *-- Inicializar empresa via sistema global se nao recebida via parametro
                IF EMPTY(THIS.this_cPEmps) AND VARTYPE(go_4c_Sistema) = "O"
                    THIS.this_cPEmps = ALLTRIM(go_4c_Sistema.cCodEmpresa)
                ENDIF

                THIS.pgf_4c_Paginas.Visible   = .T.
                THIS.pgf_4c_Paginas.ActivePage = 1
                THIS.this_cModoAtual = "LISTA"

                *-- Nao executar SQL durante validacao de UI (sem conexao)
                IF TYPE("gb_4c_ValidandoUI") != "L" OR !gb_4c_ValidandoUI
                    THIS.CarregarLista()
                ENDIF

                loc_lSucesso = .T.
            ENDIF

        CATCH TO loException
            THIS.this_cMensagemErro = "Linha: " + TRANSFORM(loException.LineNo) + " - " + loException.Message
            MostrarErro("Erro ao inicializar Formsigpdmp7:" + CHR(13) + THIS.this_cMensagemErro, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPageFrame - Configura PageFrame principal com 2 paginas
    * Top=-29 oculta abas do PageFrame; todos os controles nas Pages: Top += 29
    * Legado: Pagina.Top=-29, Left=-1, Width=1005, Height=635
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPageFrame()
        THIS.AddObject("pgf_4c_Paginas", "PageFrame")

        WITH THIS.pgf_4c_Paginas
            .Top       = -29
            .Left      = -1
            .Width     = 1005
            .Height    = 631   && 635-4: Tabs=.F. via AddObject adiciona +4 ao Page.Height em runtime
            .PageCount = 2
            .Tabs      = .F.
            .Visible   = .T.
        ENDWITH

        THIS.pgf_4c_Paginas.Page1.Caption   = "Lista"
        THIS.pgf_4c_Paginas.Page1.Picture   = gc_4c_CaminhoIcones + "new_background.jpg"
        THIS.pgf_4c_Paginas.Page1.BackColor = RGB(255, 255, 255)

        THIS.pgf_4c_Paginas.Page2.Caption   = "Dados"
        THIS.pgf_4c_Paginas.Page2.Picture   = gc_4c_CaminhoIcones + "new_background.jpg"
        THIS.pgf_4c_Paginas.Page2.BackColor = RGB(255, 255, 255)
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPaginaLista - Page1: cabecalho, container botoes CRUD (vazio),
    *   container saida com Encerrar
    * Compensacao PageFrame.Top=-29: controles de topo: Top += 29
    * Botoes CRUD e grid adicionados na Fase 4
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPaginaLista()
        LOCAL loc_oPagina
        loc_oPagina = THIS.pgf_4c_Paginas.Page1

        *-- Fundo padrao do framework frmcadastro (sem isso a pagina fica branca)
        loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"

        *-- Container de cabecalho (fundo cinza escuro com titulo)
        *-- Legado: cntSombra.Top=2->31 (comp.); Width=1100; BackColor=RGB(100,100,100)
        loc_oPagina.AddObject("cnt_4c_Cabecalho", "Container")
        WITH loc_oPagina.cnt_4c_Cabecalho
            .Top         = 31
            .Left        = 0
            .Width       = 1003
            .Height      = 80
            .BackStyle   = 1
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
            .Visible   = .T.
        ENDWITH

        *-- Container de botoes CRUD com 5 botoes de acao
        *-- Legado: Grupo_op.Left=542, Top=-1+29=28, Width=385, Height=85
        loc_oPagina.AddObject("cnt_4c_Botoes", "Container")
        WITH loc_oPagina.cnt_4c_Botoes
            .Top         = 28
            .Left        = 542
            .Width       = 385
            .Height      = 85
            .BackStyle   = 0
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH

        loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Incluir", "CommandButton")
        WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Incluir
            .Top             = 5
            .Left            = 5
            .Width           = 75
            .Height          = 75
            .FontName        = "Tahoma"
            .FontSize        = 8
            .Caption         = "Incluir"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_inserir_26.jpg"
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .Themes          = .F.
            .PicturePosition = 13
            .Visible         = .T.
        ENDWITH

        loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Visualizar", "CommandButton")
        WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar
            .Top             = 5
            .Left            = 80
            .Width           = 75
            .Height          = 75
            .FontName        = "Tahoma"
            .FontSize        = 8
            .Caption         = "Visualizar"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_vizualizar_60.jpg"
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .Themes          = .F.
            .PicturePosition = 13
            .Visible         = .T.
        ENDWITH

        loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Alterar", "CommandButton")
        WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar
            .Top             = 5
            .Left            = 155
            .Width           = 75
            .Height          = 75
            .FontName        = "Tahoma"
            .FontSize        = 8
            .Caption         = "Alterar"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_alterar_60.jpg"
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .Themes          = .F.
            .PicturePosition = 13
            .Visible         = .T.
        ENDWITH

        loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Excluir", "CommandButton")
        WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir
            .Top             = 5
            .Left            = 230
            .Width           = 75
            .Height          = 75
            .FontName        = "Tahoma"
            .FontSize        = 8
            .Caption         = "Excluir"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_excluir_60.jpg"
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .Themes          = .F.
            .PicturePosition = 13
            .Visible         = .T.
        ENDWITH

        loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Buscar", "CommandButton")
        WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Buscar
            .Top             = 5
            .Left            = 305
            .Width           = 75
            .Height          = 75
            .FontName        = "Tahoma"
            .FontSize        = 8
            .Caption         = "Buscar"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_procurar_60.jpg"
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .Themes          = .F.
            .PicturePosition = 13
            .Visible         = .T.
        ENDWITH

        *-- Container de saida (padrao canonico - CLAUDE.md regra #10)
        *-- cnt_4c_Saida transparente flutuante; Left=917, Width=90
        loc_oPagina.AddObject("cnt_4c_Saida", "Container")
        WITH loc_oPagina.cnt_4c_Saida
            .Top         = 28
            .Left        = 917
            .Width       = 90
            .Height      = 85
            .BackStyle   = 0
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH

        loc_oPagina.cnt_4c_Saida.AddObject("cmd_4c_Encerrar", "CommandButton")
        WITH loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar
            .Top             = 5
            .Left            = 5
            .Width           = 75
            .Height          = 75
            .FontName        = "Tahoma"
            .FontSize        = 8
            .Caption         = "Encerrar"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .Themes          = .F.
            .PicturePosition = 13
            .Visible         = .T.
        ENDWITH

        *-- Grid de lista (Top=88+29=117; Left=26; Width=888; 9 colunas de SigCdNec)
        *-- ColumnCount fora do WITH para garantir criacao imediata das colunas (Problema 36)
        loc_oPagina.AddObject("grd_4c_Lista", "Grid")
        loc_oPagina.grd_4c_Lista.ColumnCount = 9

        WITH loc_oPagina.grd_4c_Lista
            .Top                = 117
            .Left               = 26
            .Width              = 888
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
            .Column1.Width      = 70
            .Column2.Width      = 80
            .Column3.Width      = 80
            .Column4.Width      = 120
            .Column5.Width      = 100
            .Column6.Width      = 80
            .Column7.Width      = 80
            .Column8.Width      = 80
            .Column9.Width      = 80
            .Column1.Header1.Caption = "C" + CHR(243) + "digo"
            .Column2.Header1.Caption = "Data"
            .Column3.Header1.Caption = "Peso"
            .Column4.Header1.Caption = "Opera" + CHR(231) + CHR(227) + "o"
            .Column5.Header1.Caption = "Usu" + CHR(225) + "rio"
            .Column6.Header1.Caption = "Gr.Origem"
            .Column7.Header1.Caption = "Ct.Origem"
            .Column8.Header1.Caption = "Gr.Destino"
            .Column9.Header1.Caption = "Ct.Destino"
            .Visible            = .T.
        ENDWITH

        *-- Vincular eventos dos botoes e do grid da Page1
        BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Incluir,    "Click", THIS, "BtnIncluirClick")
        BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar, "Click", THIS, "BtnVisualizarClick")
        BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar,    "Click", THIS, "BtnAlterarClick")
        BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir,    "Click", THIS, "BtnExcluirClick")
        BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Buscar,     "Click", THIS, "BtnBuscarClick")
        BINDEVENT(loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar,    "Click", THIS, "BtnEncerrarClick")
        BINDEVENT(loc_oPagina.grd_4c_Lista, "AfterRowColChange", THIS, "GridListaAfterRowColChange")

        THIS.TornarControlesVisiveis(loc_oPagina)
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPaginaDados - Page2: todos os controles de edicao
    * Fase 5: cnt_4c_Dados (Codigo/Data/NomeOperacao) + cnt_4c_Origem (Grupo/Conta/Nome)
    * Fase 6: cnt_4c_Destino, cnt_4c_Responsavel, botoes de acao, grid, memo
    * Compensacao PageFrame.Top=-29: controles diretos na Page: Top += 29
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPaginaDados()
        LOCAL loc_oPagina
        loc_oPagina = THIS.pgf_4c_Paginas.Page2

        *-- Fundo padrao do framework frmcadastro (sem isso a pagina fica branca)
        loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"

        *----------------------------------------------------------------------
        *-- Container central de dados (cntDados - Top=117+29=146, Left=8)
        *-- Contem: Codigo, Data, label NomeOperacao
        *----------------------------------------------------------------------
        loc_oPagina.AddObject("cnt_4c_Dados", "Container")
        WITH loc_oPagina.cnt_4c_Dados
            .Top         = 146
            .Left        = 8
            .Width       = 571
            .Height      = 75
            .BackStyle   = 1
            .BackColor   = RGB(255, 255, 255)
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH

        *-- Linha separadora horizontal
        loc_oPagina.cnt_4c_Dados.AddObject("lin_4c_Line1", "Line")
        WITH loc_oPagina.cnt_4c_Dados.lin_4c_Line1
            .Top     = 22
            .Left    = 11
            .Width   = 340
            .Height  = 0
            .Visible = .T.
        ENDWITH

        *-- Label "C?digo " (Say2)
        loc_oPagina.cnt_4c_Dados.AddObject("lbl_4c_Label2", "Label")
        WITH loc_oPagina.cnt_4c_Dados.lbl_4c_Label2
            .Caption   = "C" + CHR(243) + "digo "
            .Top       = 6
            .Left      = 11
            .AutoSize  = .T.
            .BackStyle = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        *-- TextBox Codigo (Get_codigo)
        *-- When legado: edita somente em PROCURAR ou INSERIR c/ numeras=1 e EditaOrigem
        loc_oPagina.cnt_4c_Dados.AddObject("txt_4c_Codigo", "TextBox")
        WITH loc_oPagina.cnt_4c_Dados.txt_4c_Codigo
            .Value     = ""
            .Top       = 28
            .Left      = 11
            .Width     = 81
            .Height    = 23
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackColor = RGB(255, 255, 255)
            .ReadOnly  = .T.
            .Enabled   = .T.
            .Visible   = .T.
        ENDWITH

        *-- Label "Data " (Say3)
        loc_oPagina.cnt_4c_Dados.AddObject("lbl_4c_Label3", "Label")
        WITH loc_oPagina.cnt_4c_Dados.lbl_4c_Label3
            .Caption   = "Data "
            .Top       = 6
            .Left      = 101
            .AutoSize  = .T.
            .BackStyle = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        *-- TextBox Data da Movimentacao (Dt_data)
        *-- When legado: somente INSERIR/ALTERAR e sem envelopes no TmpOperacao
        *-- Valid legado: verifica periodo bloqueado (fVerificaBloqueio / fBloqueioPorPeriodo)
        loc_oPagina.cnt_4c_Dados.AddObject("txt_4c_Dt_data", "TextBox")
        WITH loc_oPagina.cnt_4c_Dados.txt_4c_Dt_data
            .Value     = DATE()
            .Top       = 28
            .Left      = 101
            .Width     = 80
            .Height    = 23
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackColor = RGB(255, 255, 255)
            .Enabled   = .T.
            .Visible   = .T.
        ENDWITH

        *-- Label nome da operacao corrente (Nom_Operacao)
        *-- Preenchido via BOParaForm() / BtnIncluirClick() com nome da operacao
        loc_oPagina.cnt_4c_Dados.AddObject("lbl_4c_Nom_Operacao", "Label")
        WITH loc_oPagina.cnt_4c_Dados.lbl_4c_Nom_Operacao
            .Caption   = ""
            .Top       = 36
            .Left      = 319
            .Width     = 56
            .Height    = 15
            .AutoSize  = .F.
            .BackStyle = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        *-- BINDEVENT: Valid da data valida periodo bloqueado (LostFocus no lugar do Valid do legado)
        BINDEVENT(loc_oPagina.cnt_4c_Dados.txt_4c_Dt_data, "LostFocus", THIS, "ValidarDataMov")

        *----------------------------------------------------------------------
        *-- Container Origem (Origem.Top=198+29=227, Left=7, Width=571, Height=75)
        *-- Todos os campos sao somente leitura (When=Return .F. no legado)
        *-- Preenchidos automaticamente ao selecionar operacao
        *----------------------------------------------------------------------
        loc_oPagina.AddObject("cnt_4c_Origem", "Container")
        WITH loc_oPagina.cnt_4c_Origem
            .Top         = 227
            .Left        = 7
            .Width       = 571
            .Height      = 75
            .BackStyle   = 1
            .BackColor   = RGB(255, 255, 255)
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH

        *-- Label "Origem" (Say4)
        loc_oPagina.cnt_4c_Origem.AddObject("lbl_4c_Label4", "Label")
        WITH loc_oPagina.cnt_4c_Origem.lbl_4c_Label4
            .Caption   = "Origem"
            .Top       = 6
            .Left      = 11
            .AutoSize  = .T.
            .BackStyle = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .T.
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        *-- Linha separadora Origem
        loc_oPagina.cnt_4c_Origem.AddObject("lin_4c_Line1", "Line")
        WITH loc_oPagina.cnt_4c_Origem.lin_4c_Line1
            .Top     = 22
            .Left    = 11
            .Width   = 340
            .Height  = 0
            .Visible = .T.
        ENDWITH

        *-- Label "Grupo" (Say1)
        loc_oPagina.cnt_4c_Origem.AddObject("lbl_4c_Label1", "Label")
        WITH loc_oPagina.cnt_4c_Origem.lbl_4c_Label1
            .Caption   = "Grupo"
            .Top       = 27
            .Left      = 11
            .AutoSize  = .T.
            .BackStyle = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        *-- Label "Conta" (Say2)
        loc_oPagina.cnt_4c_Origem.AddObject("lbl_4c_Label2", "Label")
        WITH loc_oPagina.cnt_4c_Origem.lbl_4c_Label2
            .Caption   = "Conta"
            .Top       = 27
            .Left      = 96
            .AutoSize  = .T.
            .BackStyle = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        *-- Label "Nome" (Say3)
        loc_oPagina.cnt_4c_Origem.AddObject("lbl_4c_Label3", "Label")
        WITH loc_oPagina.cnt_4c_Origem.lbl_4c_Label3
            .Caption   = "Nome"
            .Top       = 27
            .Left      = 180
            .AutoSize  = .T.
            .BackStyle = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        *-- TextBox Grupo de Origem (Get_grupo) - somente leitura
        loc_oPagina.cnt_4c_Origem.AddObject("txt_4c_Grupo", "TextBox")
        WITH loc_oPagina.cnt_4c_Origem.txt_4c_Grupo
            .Value     = ""
            .Top       = 42
            .Left      = 11
            .Width     = 80
            .Height    = 23
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackColor = RGB(240, 240, 240)
            .ReadOnly  = .T.
            .Visible   = .T.
        ENDWITH

        *-- TextBox Conta de Origem (Get_conta) - somente leitura
        loc_oPagina.cnt_4c_Origem.AddObject("txt_4c_Conta", "TextBox")
        WITH loc_oPagina.cnt_4c_Origem.txt_4c_Conta
            .Value     = ""
            .Top       = 42
            .Left      = 96
            .Width     = 80
            .Height    = 23
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackColor = RGB(240, 240, 240)
            .ReadOnly  = .T.
            .Visible   = .T.
        ENDWITH

        *-- TextBox Nome da Conta de Origem (Get_dconta) - somente leitura
        loc_oPagina.cnt_4c_Origem.AddObject("txt_4c_Dconta", "TextBox")
        WITH loc_oPagina.cnt_4c_Origem.txt_4c_Dconta
            .Value     = ""
            .Top       = 42
            .Left      = 180
            .Width     = 302
            .Height    = 23
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackColor = RGB(240, 240, 240)
            .ReadOnly  = .T.
            .Visible   = .T.
        ENDWITH

        *----------------------------------------------------------------------
        *-- Container de botoes Confirmar/Cancelar
        *-- Legado: Grupo_Salva.Left=842, Top=-1+29=28
        *----------------------------------------------------------------------
        loc_oPagina.AddObject("cnt_4c_BotoesAcao", "Container")
        WITH loc_oPagina.cnt_4c_BotoesAcao
            .Top         = 28
            .Left        = 842
            .Width       = 160
            .Height      = 85
            .BackStyle   = 0
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH

        loc_oPagina.cnt_4c_BotoesAcao.AddObject("cmd_4c_Confirmar", "CommandButton")
        WITH loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Confirmar
            .Top             = 5
            .Left            = 5
            .Width           = 75
            .Height          = 75
            .FontName        = "Tahoma"
            .FontSize        = 8
            .Caption         = "Confirmar"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .Themes          = .F.
            .PicturePosition = 13
            .Visible         = .T.
        ENDWITH

        loc_oPagina.cnt_4c_BotoesAcao.AddObject("cmd_4c_Cancelar", "CommandButton")
        WITH loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Cancelar
            .Top             = 5
            .Left            = 80
            .Width           = 75
            .Height          = 75
            .FontName        = "Tahoma"
            .FontSize        = 8
            .Caption         = "Encerrar"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_cancelar_60.jpg"
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .Themes          = .F.
            .PicturePosition = 13
            .Visible         = .T.
        ENDWITH

        *----------------------------------------------------------------------
        *-- Container Destino (Destino.Top=278+29=307, Left=7, Width=571, Height=75)
        *-- Campos somente leitura: preenchidos ao selecionar operacao (When=.F. no legado)
        *----------------------------------------------------------------------
        loc_oPagina.AddObject("cnt_4c_Destino", "Container")
        WITH loc_oPagina.cnt_4c_Destino
            .Top         = 307
            .Left        = 7
            .Width       = 571
            .Height      = 75
            .BackStyle   = 1
            .BackColor   = RGB(255, 255, 255)
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH

        loc_oPagina.cnt_4c_Destino.AddObject("lbl_4c_Label4", "Label")
        WITH loc_oPagina.cnt_4c_Destino.lbl_4c_Label4
            .Caption   = "Destino"
            .Top       = 6
            .Left      = 11
            .AutoSize  = .T.
            .BackStyle = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .T.
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        loc_oPagina.cnt_4c_Destino.AddObject("lin_4c_Line1", "Line")
        WITH loc_oPagina.cnt_4c_Destino.lin_4c_Line1
            .Top         = 22
            .Left        = 11
            .Width       = 340
            .Height      = 0
            .BorderWidth = 2
            .BorderColor = RGB(90, 90, 90)
            .Visible     = .T.
        ENDWITH

        loc_oPagina.cnt_4c_Destino.AddObject("lbl_4c_Label1", "Label")
        WITH loc_oPagina.cnt_4c_Destino.lbl_4c_Label1
            .Caption   = "Grupo"
            .Top       = 27
            .Left      = 11
            .AutoSize  = .T.
            .BackStyle = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        loc_oPagina.cnt_4c_Destino.AddObject("lbl_4c_Label2", "Label")
        WITH loc_oPagina.cnt_4c_Destino.lbl_4c_Label2
            .Caption   = "Conta"
            .Top       = 27
            .Left      = 96
            .AutoSize  = .T.
            .BackStyle = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        loc_oPagina.cnt_4c_Destino.AddObject("lbl_4c_Label3", "Label")
        WITH loc_oPagina.cnt_4c_Destino.lbl_4c_Label3
            .Caption   = "Nome"
            .Top       = 27
            .Left      = 180
            .AutoSize  = .T.
            .BackStyle = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        loc_oPagina.cnt_4c_Destino.AddObject("txt_4c_Grupo", "TextBox")
        WITH loc_oPagina.cnt_4c_Destino.txt_4c_Grupo
            .Value     = ""
            .Top       = 42
            .Left      = 11
            .Width     = 80
            .Height    = 23
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackColor = RGB(240, 240, 240)
            .ReadOnly  = .T.
            .Visible   = .T.
        ENDWITH

        loc_oPagina.cnt_4c_Destino.AddObject("txt_4c_Conta", "TextBox")
        WITH loc_oPagina.cnt_4c_Destino.txt_4c_Conta
            .Value     = ""
            .Top       = 42
            .Left      = 96
            .Width     = 80
            .Height    = 23
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackColor = RGB(240, 240, 240)
            .ReadOnly  = .T.
            .Visible   = .T.
        ENDWITH

        loc_oPagina.cnt_4c_Destino.AddObject("txt_4c_Dconta", "TextBox")
        WITH loc_oPagina.cnt_4c_Destino.txt_4c_Dconta
            .Value     = ""
            .Top       = 42
            .Left      = 180
            .Width     = 302
            .Height    = 23
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackColor = RGB(240, 240, 240)
            .ReadOnly  = .T.
            .Visible   = .T.
        ENDWITH

        *----------------------------------------------------------------------
        *-- Container Responsavel (Responsavel.Top=357+29=386, Left=7, Width=571, Height=75)
        *-- Campos somente leitura: preenchidos ao selecionar operacao
        *----------------------------------------------------------------------
        loc_oPagina.AddObject("cnt_4c_Responsavel", "Container")
        WITH loc_oPagina.cnt_4c_Responsavel
            .Top         = 386
            .Left        = 7
            .Width       = 571
            .Height      = 75
            .BackStyle   = 1
            .BackColor   = RGB(255, 255, 255)
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH

        loc_oPagina.cnt_4c_Responsavel.AddObject("lbl_4c_Label4", "Label")
        WITH loc_oPagina.cnt_4c_Responsavel.lbl_4c_Label4
            .Caption   = "Respons" + CHR(225) + "vel"
            .Top       = 6
            .Left      = 11
            .AutoSize  = .T.
            .BackStyle = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .T.
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        loc_oPagina.cnt_4c_Responsavel.AddObject("lin_4c_Line1", "Line")
        WITH loc_oPagina.cnt_4c_Responsavel.lin_4c_Line1
            .Top         = 22
            .Left        = 11
            .Width       = 340
            .Height      = 0
            .BorderWidth = 2
            .BorderColor = RGB(100, 100, 100)
            .Visible     = .T.
        ENDWITH

        loc_oPagina.cnt_4c_Responsavel.AddObject("lbl_4c_Label1", "Label")
        WITH loc_oPagina.cnt_4c_Responsavel.lbl_4c_Label1
            .Caption   = "Grupo"
            .Top       = 27
            .Left      = 11
            .AutoSize  = .T.
            .BackStyle = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        loc_oPagina.cnt_4c_Responsavel.AddObject("lbl_4c_Label2", "Label")
        WITH loc_oPagina.cnt_4c_Responsavel.lbl_4c_Label2
            .Caption   = "Conta"
            .Top       = 27
            .Left      = 96
            .AutoSize  = .T.
            .BackStyle = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        loc_oPagina.cnt_4c_Responsavel.AddObject("lbl_4c_Label3", "Label")
        WITH loc_oPagina.cnt_4c_Responsavel.lbl_4c_Label3
            .Caption   = "Nome"
            .Top       = 27
            .Left      = 180
            .AutoSize  = .T.
            .BackStyle = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        loc_oPagina.cnt_4c_Responsavel.AddObject("txt_4c_Grupo", "TextBox")
        WITH loc_oPagina.cnt_4c_Responsavel.txt_4c_Grupo
            .Value     = ""
            .Top       = 42
            .Left      = 11
            .Width     = 80
            .Height    = 23
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackColor = RGB(240, 240, 240)
            .ReadOnly  = .T.
            .Visible   = .T.
        ENDWITH

        loc_oPagina.cnt_4c_Responsavel.AddObject("txt_4c_Conta", "TextBox")
        WITH loc_oPagina.cnt_4c_Responsavel.txt_4c_Conta
            .Value     = ""
            .Top       = 42
            .Left      = 96
            .Width     = 80
            .Height    = 23
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackColor = RGB(240, 240, 240)
            .ReadOnly  = .T.
            .Visible   = .T.
        ENDWITH

        loc_oPagina.cnt_4c_Responsavel.AddObject("txt_4c_Dconta", "TextBox")
        WITH loc_oPagina.cnt_4c_Responsavel.txt_4c_Dconta
            .Value     = ""
            .Top       = 42
            .Left      = 180
            .Width     = 302
            .Height    = 23
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackColor = RGB(240, 240, 240)
            .ReadOnly  = .T.
            .Visible   = .T.
        ENDWITH

        *----------------------------------------------------------------------
        *-- Botoes de acao na Page2 (Top=4+29=33) - abrem sub-formularios especificos
        *-- Legado: classe fwbtng. Visivel somente nos modos INSERIR/ALTERAR/CONSULTAR.
        *-- Posicoes: Left=397,472,547,622,697,772 (gap de 75px entre cada um)
        *----------------------------------------------------------------------
        loc_oPagina.AddObject("cmd_4c_Operacao", "CommandButton")
        WITH loc_oPagina.cmd_4c_Operacao
            .Top             = 33
            .Left            = 397
            .Width           = 70
            .Height          = 75
            .FontName        = "Tahoma"
            .FontSize        = 8
            .Caption         = "Opera" + CHR(231) + CHR(245) + "es"
            .Picture         = gc_4c_CaminhoIcones + "geral_pendencia_60.jpg"
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .Themes          = .F.
            .PicturePosition = 13
            .Visible         = .T.
        ENDWITH

        loc_oPagina.AddObject("cmd_4c_Componentes", "CommandButton")
        WITH loc_oPagina.cmd_4c_Componentes
            .Top             = 33
            .Left            = 472
            .Width           = 70
            .Height          = 75
            .FontName        = "Tahoma"
            .FontSize        = 8
            .Caption         = "Componen."
            .Picture         = gc_4c_CaminhoIcones + "geral_produtos_60.jpg"
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .Themes          = .F.
            .PicturePosition = 13
            .ToolTipText     = "Componentes"
            .Visible         = .T.
        ENDWITH

        loc_oPagina.AddObject("cmd_4c_Etiquetas", "CommandButton")
        WITH loc_oPagina.cmd_4c_Etiquetas
            .Top             = 33
            .Left            = 547
            .Width           = 70
            .Height          = 75
            .FontName        = "Tahoma"
            .FontSize        = 8
            .Caption         = "Etiquetas"
            .Picture         = gc_4c_CaminhoIcones + "geral_etiqueta_60.jpg"
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .Themes          = .F.
            .PicturePosition = 13
            .ToolTipText     = "Etiquetas"
            .Visible         = .T.
        ENDWITH

        loc_oPagina.AddObject("cmd_4c_Dados", "CommandButton")
        WITH loc_oPagina.cmd_4c_Dados
            .Top             = 33
            .Left            = 622
            .Width           = 70
            .Height          = 75
            .FontName        = "Tahoma"
            .FontSize        = 8
            .Caption         = "Complem."
            .Picture         = gc_4c_CaminhoIcones + "geral_adicao_60.jpg"
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .Themes          = .F.
            .PicturePosition = 13
            .ToolTipText     = "Complemento"
            .Visible         = .T.
        ENDWITH

        loc_oPagina.AddObject("cmd_4c_Boleto", "CommandButton")
        WITH loc_oPagina.cmd_4c_Boleto
            .Top             = 33
            .Left            = 697
            .Width           = 70
            .Height          = 75
            .FontName        = "Tahoma"
            .FontSize        = 8
            .Caption         = "Boleto"
            .Picture         = gc_4c_CaminhoIcones + "geral_boleto_60.jpg"
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .Themes          = .F.
            .PicturePosition = 13
            .Visible         = .T.
        ENDWITH

        loc_oPagina.AddObject("cmd_4c_Documento", "CommandButton")
        WITH loc_oPagina.cmd_4c_Documento
            .Top             = 33
            .Left            = 772
            .Width           = 70
            .Height          = 75
            .FontName        = "Tahoma"
            .FontSize        = 8
            .Caption         = "Documento"
            .Picture         = gc_4c_CaminhoIcones + "geral_documento_60.jpg"
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .Themes          = .F.
            .PicturePosition = 13
            .Visible         = .T.
        ENDWITH

        *----------------------------------------------------------------------
        *-- Shape de fundo para area dos botoes de acao
        *-- Legado: shpBtnGs.Top=150+29=179, Left=6, Width=484, Height=110
        *-- BackStyle=0 (transparente), BorderStyle=0 (sem borda)
        *----------------------------------------------------------------------
        loc_oPagina.AddObject("shp_4c_ShpBtnGs", "Shape")
        WITH loc_oPagina.shp_4c_ShpBtnGs
            .Top         = 179
            .Left        = 6
            .Width       = 484
            .Height      = 110
            .BackStyle   = 0
            .BorderStyle = 0
            .BorderColor = RGB(36, 84, 155)
            .Visible     = .T.
        ENDWITH

        *----------------------------------------------------------------------
        *-- Label "Observacao :" (Say3 na raiz de Page2 - Top=337+29=366, Left=592)
        *----------------------------------------------------------------------
        loc_oPagina.AddObject("lbl_4c_Label3", "Label")
        WITH loc_oPagina.lbl_4c_Label3
            .Caption   = "Observa" + CHR(231) + CHR(227) + "o : "
            .Top       = 366
            .Left      = 592
            .AutoSize  = .T.
            .BackStyle = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .T.
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        *----------------------------------------------------------------------
        *-- EditBox Observacao (Mm_obs - Top=353+29=382, Left=592, Width=397, Height=205)
        *-- Legado: ControlSource = "TmpNens.Obss"
        *----------------------------------------------------------------------
        loc_oPagina.AddObject("obj_4c_Mm_obs", "EditBox")
        WITH loc_oPagina.obj_4c_Mm_obs
            .Value     = ""
            .Top       = 382
            .Left      = 592
            .Width     = 397
            .Height    = 205
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(0, 0, 0)
            .BackColor = RGB(255, 255, 255)
            .Enabled   = .T.
            .Visible   = .T.
        ENDWITH

        *----------------------------------------------------------------------
        *-- Grid GradeOperacao (Top=4+29=33, Left=592, Width=171, Height=218)
        *-- Legado: RecordSource=TmpOperacao; Column1 oculto; grid inicia Visible=.F.
        *-- Preenchido pelos sub-formularios de operacao via cursor TmpOperacao
        *----------------------------------------------------------------------
        loc_oPagina.AddObject("grd_4c_Dados", "Grid")
        loc_oPagina.grd_4c_Dados.ColumnCount = 1

        WITH loc_oPagina.grd_4c_Dados
            .Top                = 33
            .Left               = 592
            .Width              = 171
            .Height             = 218
            .FontName           = "Tahoma"
            .FontSize           = 8
            .ForeColor          = RGB(90, 90, 90)
            .BackColor          = RGB(255, 255, 255)
            .GridLineColor      = RGB(238, 238, 238)
            .HighlightBackColor = RGB(255, 255, 255)
            .HighlightForeColor = RGB(15, 41, 104)
            .HighlightStyle     = 2
            .DeleteMark         = .F.
            .RecordMark         = .F.
            .ReadOnly           = .T.
            .RowHeight          = 16
            .ScrollBars         = 2
            .GridLines          = 3
            .HeaderHeight       = 17
            .Column1.Width      = 94
            .Column1.Movable    = .F.
            .Column1.Resizable  = .F.
            .Column1.FontName   = "Courier New"
            .Column1.Format     = "KLZ"
            .Column1.InputMask  = "999999999999"
            .Column1.Visible    = .F.
            .Column1.Header1.Caption   = "Industrializa" + CHR(231) + CHR(227) + "o"
            .Column1.Header1.FontName  = "Tahoma"
            .Column1.Header1.FontSize  = 8
            .Column1.Header1.Alignment = 2
            .Visible            = .F.  && Inicia oculto (preenchido pelos sub-forms)
        ENDWITH

        *-- Vincular RecordSource do grid ao cursor TmpOperacao (criado em InicializarForm)
        IF USED("TmpOperacao")
            loc_oPagina.grd_4c_Dados.RecordSource = "TmpOperacao"
            loc_oPagina.grd_4c_Dados.Column1.ControlSource = "TmpOperacao.Codigos"
        ENDIF

        *-- BINDEVENTs para botoes de acao da Page2
        BINDEVENT(loc_oPagina.cmd_4c_Operacao,    "Click", THIS, "BtnOperacaoClick")
        BINDEVENT(loc_oPagina.cmd_4c_Componentes, "Click", THIS, "BtnComponentesClick")
        BINDEVENT(loc_oPagina.cmd_4c_Etiquetas,   "Click", THIS, "BtnEtiquetasClick")
        BINDEVENT(loc_oPagina.cmd_4c_Dados,       "Click", THIS, "BtnDadosClick")
        BINDEVENT(loc_oPagina.cmd_4c_Boleto,      "Click", THIS, "BtnBoletoClick")
        BINDEVENT(loc_oPagina.cmd_4c_Documento,   "Click", THIS, "BtnDocumentoClick")

        *-- Vincular eventos dos botoes da Page2
        BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Confirmar, "Click", THIS, "BtnSalvarClick")
        BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Cancelar,  "Click", THIS, "BtnCancelarClick")

        THIS.TornarControlesVisiveis(loc_oPagina)

        *-- Restaurar Visible=.F. do grid apos TornarControlesVisiveis (que seta tudo para .T.)
        IF PEMSTATUS(loc_oPagina, "grd_4c_Dados", 5)
            loc_oPagina.grd_4c_Dados.Visible = .F.
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarLista - Executa Buscar() no BO e atualiza o grid de lista
    * O grid (grd_4c_Lista) e adicionado na Fase 4; usa PEMSTATUS para nao
    * crashar quando chamado antes da Fase 4 ser aplicada
    *--------------------------------------------------------------------------
    PROCEDURE CarregarLista()
        LOCAL loc_lResultado, loc_oGrid
        loc_lResultado = .F.

        TRY
            IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
                loc_lResultado = .T.
            ELSE
                IF !THIS.this_oBusinessObject.Buscar(THIS.this_cPQuery)
                    loc_lResultado = .F.
                ELSE
                    *-- Configurar grid quando existir (adicionado na Fase 4)
                    IF PEMSTATUS(THIS.pgf_4c_Paginas.Page1, "grd_4c_Lista", 5)
                        loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Lista
                        loc_oGrid.ColumnCount = 9
                        loc_oGrid.RecordSource = "cursor_4c_Dados"
                        loc_oGrid.Column1.ControlSource = "cursor_4c_Dados.numps"
                        loc_oGrid.Column2.ControlSource = "cursor_4c_Dados.datas"
                        loc_oGrid.Column3.ControlSource = "cursor_4c_Dados.totpesos"
                        loc_oGrid.Column4.ControlSource = "cursor_4c_Dados.dopps"
                        loc_oGrid.Column5.ControlSource = "cursor_4c_Dados.usuars"
                        loc_oGrid.Column6.ControlSource = "cursor_4c_Dados.grupoos"
                        loc_oGrid.Column7.ControlSource = "cursor_4c_Dados.contaos"
                        loc_oGrid.Column8.ControlSource = "cursor_4c_Dados.grupods"
                        loc_oGrid.Column9.ControlSource = "cursor_4c_Dados.contads"
                        THIS.FormatarGridLista(loc_oGrid)
                    ENDIF
                    loc_lResultado = .T.
                ENDIF
            ENDIF
        CATCH TO loException
            MostrarErro("Erro ao carregar lista:" + CHR(13) + loException.Message, "Erro")
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * AlternarPagina - Alterna entre Page1 (Lista=1) e Page2 (Dados=2)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE AlternarPagina(par_nPagina)
        LOCAL loc_lResultado
        loc_lResultado = .F.

        IF VARTYPE(par_nPagina) != "N" OR par_nPagina < 1 OR par_nPagina > 2
            loc_lResultado = .F.
        ELSE
            TRY
                THIS.pgf_4c_Paginas.ActivePage = par_nPagina
                IF par_nPagina = 1
                    THIS.CarregarLista()
                ENDIF
                loc_lResultado = .T.
            CATCH TO loException
                MostrarErro("Erro ao alternar p" + CHR(225) + "gina:" + CHR(13) + loException.Message, "Erro")
            ENDTRY
        ENDIF

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * FormatarGridLista - Aplica formatacao visual padrao ao grid de lista
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE FormatarGridLista(par_oGrid)
        WITH par_oGrid
            .FontName = "Tahoma"
            .FontSize = 8
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * TornarControlesVisiveis - Torna todos os controles visiveis recursivamente
    * Itera Pages de PageFrames e Controls de Containers
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
        LOCAL loc_nI, loc_oObjeto, loc_nP

        FOR loc_nI = 1 TO par_oContainer.ControlCount
            loc_oObjeto = par_oContainer.Controls(loc_nI)

            IF VARTYPE(loc_oObjeto) = "O"
                IF PEMSTATUS(loc_oObjeto, "Visible", 5) AND ;
                   !INLIST(UPPER(loc_oObjeto.Name), "CNT_4C_CABECALHO")
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
    * GridListaAfterRowColChange - Atualiza this_cDopp ao mover linha no grid
    *--------------------------------------------------------------------------
    PROCEDURE GridListaAfterRowColChange(par_nColIndex)
        IF USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados")
            SELECT cursor_4c_Dados
            THIS.this_cDopp = ALLTRIM(cursor_4c_Dados.dopps)
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnIncluirClick - Prepara BO para novo registro e navega para Page2
    *--------------------------------------------------------------------------
    PROCEDURE BtnIncluirClick()
        THIS.this_oBusinessObject.NovoRegistro()
        THIS.LimparCampos()
        THIS.this_cPcEscolha  = "INSERIR"
        THIS.this_cModoAtual  = "INCLUIR"
        THIS.HabilitarCampos(.T.)
        THIS.AjustarBotoesPorModo()
        THIS.AlternarPagina(2)
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnVisualizarClick - Carrega registro selecionado em modo somente leitura
    *--------------------------------------------------------------------------
    PROCEDURE BtnVisualizarClick()
        LOCAL loc_cCodigo
        IF !USED("cursor_4c_Dados") OR EOF("cursor_4c_Dados")
            MsgAviso("Selecione um registro para visualizar.", "")
            RETURN
        ENDIF
        SELECT cursor_4c_Dados
        loc_cCodigo = ALLTRIM(cursor_4c_Dados.cidchaves)
        IF EMPTY(loc_cCodigo)
            MsgAviso("Selecione um registro para visualizar.", "")
            RETURN
        ENDIF
        IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
            THIS.this_cDopp      = ALLTRIM(cursor_4c_Dados.dopps)
            THIS.this_cPcEscolha = "CONSULTAR"
            THIS.this_cModoAtual = "VISUALIZAR"
            THIS.BOParaForm()
            THIS.HabilitarCampos(.F.)
            THIS.AjustarBotoesPorModo()
            THIS.AlternarPagina(2)
        ELSE
            MsgErro("Erro ao carregar registro para visualiza" + CHR(231) + CHR(227) + "o.", "Erro")
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnAlterarClick - Carrega registro selecionado para edicao
    *--------------------------------------------------------------------------
    PROCEDURE BtnAlterarClick()
        LOCAL loc_cCodigo
        IF !USED("cursor_4c_Dados") OR EOF("cursor_4c_Dados")
            MsgAviso("Selecione um registro para alterar.", "")
            RETURN
        ENDIF
        SELECT cursor_4c_Dados
        loc_cCodigo = ALLTRIM(cursor_4c_Dados.cidchaves)
        IF EMPTY(loc_cCodigo)
            MsgAviso("Selecione um registro para alterar.", "")
            RETURN
        ENDIF
        IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
            THIS.this_oBusinessObject.EditarRegistro()
            THIS.this_cDopp      = ALLTRIM(cursor_4c_Dados.dopps)
            THIS.this_cPcEscolha = "ALTERAR"
            THIS.this_cModoAtual = "ALTERAR"
            THIS.BOParaForm()
            THIS.HabilitarCampos(.T.)
            THIS.AjustarBotoesPorModo()
            THIS.AlternarPagina(2)
        ELSE
            MsgErro("Erro ao carregar registro para altera" + CHR(231) + CHR(227) + "o.", "Erro")
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnExcluirClick - Confirma e exclui registro selecionado
    *--------------------------------------------------------------------------
    PROCEDURE BtnExcluirClick()
        LOCAL loc_cCodigo
        IF !USED("cursor_4c_Dados") OR EOF("cursor_4c_Dados")
            MsgAviso("Selecione um registro para excluir.", "")
            RETURN
        ENDIF
        SELECT cursor_4c_Dados
        loc_cCodigo = ALLTRIM(cursor_4c_Dados.cidchaves)
        IF EMPTY(loc_cCodigo)
            MsgAviso("Selecione um registro para excluir.", "")
            RETURN
        ENDIF
        IF MsgConfirma("Confirma a exclus" + CHR(227) + "o deste registro?", "Confirmar Exclus" + CHR(227) + "o")
            IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
                IF THIS.this_oBusinessObject.Excluir()
                    MsgInfo("Registro exclu" + CHR(237) + "do com sucesso!", "")
                    THIS.CarregarLista()
                ELSE
                    MsgErro("Erro ao excluir o registro.", "Erro")
                ENDIF
            ELSE
                MsgErro("Erro ao carregar registro para exclus" + CHR(227) + "o.", "Erro")
            ENDIF
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnBuscarClick - Filtra lista por codigo, operacao ou usuario
    *--------------------------------------------------------------------------
    PROCEDURE BtnBuscarClick()
        LOCAL loc_cFiltro
        loc_cFiltro = INPUTBOX("Informe o c" + CHR(243) + "digo, opera" + CHR(231) + ;
            CHR(227) + "o ou usu" + CHR(225) + "rio:", "Buscar")
        IF VARTYPE(loc_cFiltro) = "C"
            THIS.this_cPQuery = ALLTRIM(loc_cFiltro)
            THIS.CarregarLista()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnEncerrarClick - Fecha o formulario
    *--------------------------------------------------------------------------
    PROCEDURE BtnEncerrarClick()
        THIS.Release()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnSalvarClick - Transfere Form->BO e chama Salvar(); volta para lista
    *--------------------------------------------------------------------------
    PROCEDURE BtnSalvarClick()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            THIS.FormParaBO()
            IF THIS.this_oBusinessObject.Salvar()
                MsgInfo("Registro salvo com sucesso!", "")
                THIS.this_cModoAtual = "LISTA"
                THIS.AlternarPagina(1)
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao salvar o registro.", "Erro")
            ENDIF
        CATCH TO loException
            MostrarErro("Erro ao salvar:" + CHR(13) + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnCancelarClick - Cancela edicao e retorna para lista recarregada
    *--------------------------------------------------------------------------
    PROCEDURE BtnCancelarClick()
        THIS.this_cModoAtual = "LISTA"
        THIS.AlternarPagina(1)
        THIS.CarregarLista()
    ENDPROC

    *--------------------------------------------------------------------------
    * FormParaBO - Transfere valores do formulario para o Business Object
    * Usa PEMSTATUS para acessar controles da Page2 com seguranca
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE FormParaBO()
        LOCAL loc_oPg2, loc_oBO
        loc_oPg2 = THIS.pgf_4c_Paginas.Page2
        loc_oBO  = THIS.this_oBusinessObject

        *-- Empresa e operacao
        loc_oBO.this_cEmps  = THIS.this_cPEmps
        loc_oBO.this_cDopps = THIS.this_cDopp

        *-- Container central de dados (cntDados)
        IF PEMSTATUS(loc_oPg2, "cnt_4c_Dados", 5)
            IF PEMSTATUS(loc_oPg2.cnt_4c_Dados, "txt_4c_Codigo", 5)
                loc_oBO.this_cCidchaves = ALLTRIM(loc_oPg2.cnt_4c_Dados.txt_4c_Codigo.Value)
            ENDIF
            IF PEMSTATUS(loc_oPg2.cnt_4c_Dados, "txt_4c_Dt_data", 5)
                loc_oBO.this_dDatas = loc_oPg2.cnt_4c_Dados.txt_4c_Dt_data.Value
            ENDIF
        ENDIF

        *-- Origem
        IF PEMSTATUS(loc_oPg2, "cnt_4c_Origem", 5)
            IF PEMSTATUS(loc_oPg2.cnt_4c_Origem, "txt_4c_Grupo", 5)
                loc_oBO.this_cGrupoos = ALLTRIM(loc_oPg2.cnt_4c_Origem.txt_4c_Grupo.Value)
            ENDIF
            IF PEMSTATUS(loc_oPg2.cnt_4c_Origem, "txt_4c_Conta", 5)
                loc_oBO.this_cContaos = ALLTRIM(loc_oPg2.cnt_4c_Origem.txt_4c_Conta.Value)
            ENDIF
        ENDIF

        *-- Destino
        IF PEMSTATUS(loc_oPg2, "cnt_4c_Destino", 5)
            IF PEMSTATUS(loc_oPg2.cnt_4c_Destino, "txt_4c_Grupo", 5)
                loc_oBO.this_cGrupods = ALLTRIM(loc_oPg2.cnt_4c_Destino.txt_4c_Grupo.Value)
            ENDIF
            IF PEMSTATUS(loc_oPg2.cnt_4c_Destino, "txt_4c_Conta", 5)
                loc_oBO.this_cContads = ALLTRIM(loc_oPg2.cnt_4c_Destino.txt_4c_Conta.Value)
            ENDIF
        ENDIF

        *-- Responsavel
        IF PEMSTATUS(loc_oPg2, "cnt_4c_Responsavel", 5)
            IF PEMSTATUS(loc_oPg2.cnt_4c_Responsavel, "txt_4c_Grupo", 5)
                loc_oBO.this_cGrvends = ALLTRIM(loc_oPg2.cnt_4c_Responsavel.txt_4c_Grupo.Value)
            ENDIF
            IF PEMSTATUS(loc_oPg2.cnt_4c_Responsavel, "txt_4c_Conta", 5)
                loc_oBO.this_cVends = ALLTRIM(loc_oPg2.cnt_4c_Responsavel.txt_4c_Conta.Value)
            ENDIF
        ENDIF

        *-- Observacao
        IF PEMSTATUS(loc_oPg2, "obj_4c_Mm_obs", 5)
            loc_oBO.this_cObss = loc_oPg2.obj_4c_Mm_obs.Value
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * BOParaForm - Transfere valores do Business Object para o formulario
    * Usa PEMSTATUS para acessar controles da Page2 com seguranca
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE BOParaForm()
        LOCAL loc_oPg2, loc_oBO
        loc_oPg2 = THIS.pgf_4c_Paginas.Page2
        loc_oBO  = THIS.this_oBusinessObject

        IF PEMSTATUS(loc_oPg2, "cnt_4c_Dados", 5)
            IF PEMSTATUS(loc_oPg2.cnt_4c_Dados, "txt_4c_Codigo", 5)
                loc_oPg2.cnt_4c_Dados.txt_4c_Codigo.Value = ALLTRIM(loc_oBO.this_cCidchaves)
            ENDIF
            IF PEMSTATUS(loc_oPg2.cnt_4c_Dados, "txt_4c_Dt_data", 5)
                loc_oPg2.cnt_4c_Dados.txt_4c_Dt_data.Value = loc_oBO.this_dDatas
            ENDIF
            IF PEMSTATUS(loc_oPg2.cnt_4c_Dados, "lbl_4c_Nom_Operacao", 5)
                loc_oPg2.cnt_4c_Dados.lbl_4c_Nom_Operacao.Caption = ALLTRIM(loc_oBO.this_cDopps)
            ENDIF
        ENDIF

        IF PEMSTATUS(loc_oPg2, "cnt_4c_Origem", 5)
            IF PEMSTATUS(loc_oPg2.cnt_4c_Origem, "txt_4c_Grupo", 5)
                loc_oPg2.cnt_4c_Origem.txt_4c_Grupo.Value = ALLTRIM(loc_oBO.this_cGrupoos)
            ENDIF
            IF PEMSTATUS(loc_oPg2.cnt_4c_Origem, "txt_4c_Conta", 5)
                loc_oPg2.cnt_4c_Origem.txt_4c_Conta.Value = ALLTRIM(loc_oBO.this_cContaos)
            ENDIF
            IF PEMSTATUS(loc_oPg2.cnt_4c_Origem, "txt_4c_Dconta", 5)
                loc_oPg2.cnt_4c_Origem.txt_4c_Dconta.Value = ""
            ENDIF
        ENDIF

        IF PEMSTATUS(loc_oPg2, "cnt_4c_Destino", 5)
            IF PEMSTATUS(loc_oPg2.cnt_4c_Destino, "txt_4c_Grupo", 5)
                loc_oPg2.cnt_4c_Destino.txt_4c_Grupo.Value = ALLTRIM(loc_oBO.this_cGrupods)
            ENDIF
            IF PEMSTATUS(loc_oPg2.cnt_4c_Destino, "txt_4c_Conta", 5)
                loc_oPg2.cnt_4c_Destino.txt_4c_Conta.Value = ALLTRIM(loc_oBO.this_cContads)
            ENDIF
            IF PEMSTATUS(loc_oPg2.cnt_4c_Destino, "txt_4c_Dconta", 5)
                loc_oPg2.cnt_4c_Destino.txt_4c_Dconta.Value = ""
            ENDIF
        ENDIF

        IF PEMSTATUS(loc_oPg2, "cnt_4c_Responsavel", 5)
            IF PEMSTATUS(loc_oPg2.cnt_4c_Responsavel, "txt_4c_Grupo", 5)
                loc_oPg2.cnt_4c_Responsavel.txt_4c_Grupo.Value = ALLTRIM(loc_oBO.this_cGrvends)
            ENDIF
            IF PEMSTATUS(loc_oPg2.cnt_4c_Responsavel, "txt_4c_Conta", 5)
                loc_oPg2.cnt_4c_Responsavel.txt_4c_Conta.Value = ALLTRIM(loc_oBO.this_cVends)
            ENDIF
            IF PEMSTATUS(loc_oPg2.cnt_4c_Responsavel, "txt_4c_Dconta", 5)
                loc_oPg2.cnt_4c_Responsavel.txt_4c_Dconta.Value = ""
            ENDIF
        ENDIF

        IF PEMSTATUS(loc_oPg2, "obj_4c_Mm_obs", 5)
            loc_oPg2.obj_4c_Mm_obs.Value = ALLTRIM(loc_oBO.this_cObss)
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * HabilitarCampos - Habilita/desabilita controles editaveis da Page2
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE HabilitarCampos(par_lHabilitar)
        LOCAL loc_oPg2
        loc_oPg2 = THIS.pgf_4c_Paginas.Page2

        IF PEMSTATUS(loc_oPg2, "cnt_4c_Dados", 5)
            IF PEMSTATUS(loc_oPg2.cnt_4c_Dados, "txt_4c_Codigo", 5)
                loc_oPg2.cnt_4c_Dados.txt_4c_Codigo.Enabled = ;
                    par_lHabilitar AND (THIS.this_cModoAtual = "INCLUIR")
            ENDIF
            IF PEMSTATUS(loc_oPg2.cnt_4c_Dados, "txt_4c_Dt_data", 5)
                loc_oPg2.cnt_4c_Dados.txt_4c_Dt_data.Enabled = par_lHabilitar
            ENDIF
        ENDIF

        IF PEMSTATUS(loc_oPg2, "cnt_4c_Origem", 5)
            IF PEMSTATUS(loc_oPg2.cnt_4c_Origem, "txt_4c_Grupo", 5)
                loc_oPg2.cnt_4c_Origem.txt_4c_Grupo.ReadOnly = !par_lHabilitar
            ENDIF
            IF PEMSTATUS(loc_oPg2.cnt_4c_Origem, "txt_4c_Conta", 5)
                loc_oPg2.cnt_4c_Origem.txt_4c_Conta.ReadOnly = !par_lHabilitar
            ENDIF
        ENDIF

        IF PEMSTATUS(loc_oPg2, "cnt_4c_Destino", 5)
            IF PEMSTATUS(loc_oPg2.cnt_4c_Destino, "txt_4c_Grupo", 5)
                loc_oPg2.cnt_4c_Destino.txt_4c_Grupo.ReadOnly = !par_lHabilitar
            ENDIF
            IF PEMSTATUS(loc_oPg2.cnt_4c_Destino, "txt_4c_Conta", 5)
                loc_oPg2.cnt_4c_Destino.txt_4c_Conta.ReadOnly = !par_lHabilitar
            ENDIF
        ENDIF

        IF PEMSTATUS(loc_oPg2, "cnt_4c_Responsavel", 5)
            IF PEMSTATUS(loc_oPg2.cnt_4c_Responsavel, "txt_4c_Grupo", 5)
                loc_oPg2.cnt_4c_Responsavel.txt_4c_Grupo.ReadOnly = !par_lHabilitar
            ENDIF
            IF PEMSTATUS(loc_oPg2.cnt_4c_Responsavel, "txt_4c_Conta", 5)
                loc_oPg2.cnt_4c_Responsavel.txt_4c_Conta.ReadOnly = !par_lHabilitar
            ENDIF
        ENDIF

        IF PEMSTATUS(loc_oPg2, "obj_4c_Mm_obs", 5)
            loc_oPg2.obj_4c_Mm_obs.Enabled = par_lHabilitar
        ENDIF

        IF PEMSTATUS(loc_oPg2, "cnt_4c_BotoesAcao", 5)
            IF PEMSTATUS(loc_oPg2.cnt_4c_BotoesAcao, "cmd_4c_Confirmar", 5)
                loc_oPg2.cnt_4c_BotoesAcao.cmd_4c_Confirmar.Enabled = par_lHabilitar
            ENDIF
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * LimparCampos - Limpa valores dos controles da Page2
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE LimparCampos()
        LOCAL loc_oPg2
        loc_oPg2 = THIS.pgf_4c_Paginas.Page2

        IF PEMSTATUS(loc_oPg2, "cnt_4c_Dados", 5)
            IF PEMSTATUS(loc_oPg2.cnt_4c_Dados, "txt_4c_Codigo", 5)
                loc_oPg2.cnt_4c_Dados.txt_4c_Codigo.Value = ""
            ENDIF
            IF PEMSTATUS(loc_oPg2.cnt_4c_Dados, "txt_4c_Dt_data", 5)
                loc_oPg2.cnt_4c_Dados.txt_4c_Dt_data.Value = DATE()
            ENDIF
            IF PEMSTATUS(loc_oPg2.cnt_4c_Dados, "lbl_4c_Nom_Operacao", 5)
                loc_oPg2.cnt_4c_Dados.lbl_4c_Nom_Operacao.Caption = ""
            ENDIF
        ENDIF

        IF PEMSTATUS(loc_oPg2, "cnt_4c_Origem", 5)
            IF PEMSTATUS(loc_oPg2.cnt_4c_Origem, "txt_4c_Grupo", 5)
                loc_oPg2.cnt_4c_Origem.txt_4c_Grupo.Value = ""
            ENDIF
            IF PEMSTATUS(loc_oPg2.cnt_4c_Origem, "txt_4c_Conta", 5)
                loc_oPg2.cnt_4c_Origem.txt_4c_Conta.Value = ""
            ENDIF
            IF PEMSTATUS(loc_oPg2.cnt_4c_Origem, "txt_4c_Dconta", 5)
                loc_oPg2.cnt_4c_Origem.txt_4c_Dconta.Value = ""
            ENDIF
        ENDIF

        IF PEMSTATUS(loc_oPg2, "cnt_4c_Destino", 5)
            IF PEMSTATUS(loc_oPg2.cnt_4c_Destino, "txt_4c_Grupo", 5)
                loc_oPg2.cnt_4c_Destino.txt_4c_Grupo.Value = ""
            ENDIF
            IF PEMSTATUS(loc_oPg2.cnt_4c_Destino, "txt_4c_Conta", 5)
                loc_oPg2.cnt_4c_Destino.txt_4c_Conta.Value = ""
            ENDIF
            IF PEMSTATUS(loc_oPg2.cnt_4c_Destino, "txt_4c_Dconta", 5)
                loc_oPg2.cnt_4c_Destino.txt_4c_Dconta.Value = ""
            ENDIF
        ENDIF

        IF PEMSTATUS(loc_oPg2, "cnt_4c_Responsavel", 5)
            IF PEMSTATUS(loc_oPg2.cnt_4c_Responsavel, "txt_4c_Grupo", 5)
                loc_oPg2.cnt_4c_Responsavel.txt_4c_Grupo.Value = ""
            ENDIF
            IF PEMSTATUS(loc_oPg2.cnt_4c_Responsavel, "txt_4c_Conta", 5)
                loc_oPg2.cnt_4c_Responsavel.txt_4c_Conta.Value = ""
            ENDIF
            IF PEMSTATUS(loc_oPg2.cnt_4c_Responsavel, "txt_4c_Dconta", 5)
                loc_oPg2.cnt_4c_Responsavel.txt_4c_Dconta.Value = ""
            ENDIF
        ENDIF

        IF PEMSTATUS(loc_oPg2, "obj_4c_Mm_obs", 5)
            loc_oPg2.obj_4c_Mm_obs.Value = ""
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * AjustarBotoesPorModo - Habilita/desabilita botoes conforme modo corrente
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE AjustarBotoesPorModo()
        LOCAL loc_oPg1, loc_oPg2, loc_lLista, loc_lEditar
        loc_oPg1   = THIS.pgf_4c_Paginas.Page1
        loc_oPg2   = THIS.pgf_4c_Paginas.Page2
        loc_lLista  = (THIS.this_cModoAtual = "LISTA")
        loc_lEditar = INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")

        IF PEMSTATUS(loc_oPg1, "cnt_4c_Botoes", 5)
            IF PEMSTATUS(loc_oPg1.cnt_4c_Botoes, "cmd_4c_Incluir", 5)
                loc_oPg1.cnt_4c_Botoes.cmd_4c_Incluir.Enabled    = loc_lLista
            ENDIF
            IF PEMSTATUS(loc_oPg1.cnt_4c_Botoes, "cmd_4c_Visualizar", 5)
                loc_oPg1.cnt_4c_Botoes.cmd_4c_Visualizar.Enabled = loc_lLista
            ENDIF
            IF PEMSTATUS(loc_oPg1.cnt_4c_Botoes, "cmd_4c_Alterar", 5)
                loc_oPg1.cnt_4c_Botoes.cmd_4c_Alterar.Enabled    = loc_lLista
            ENDIF
            IF PEMSTATUS(loc_oPg1.cnt_4c_Botoes, "cmd_4c_Excluir", 5)
                loc_oPg1.cnt_4c_Botoes.cmd_4c_Excluir.Enabled    = loc_lLista
            ENDIF
            IF PEMSTATUS(loc_oPg1.cnt_4c_Botoes, "cmd_4c_Buscar", 5)
                loc_oPg1.cnt_4c_Botoes.cmd_4c_Buscar.Enabled     = loc_lLista
            ENDIF
        ENDIF

        IF PEMSTATUS(loc_oPg2, "cnt_4c_BotoesAcao", 5)
            IF PEMSTATUS(loc_oPg2.cnt_4c_BotoesAcao, "cmd_4c_Confirmar", 5)
                loc_oPg2.cnt_4c_BotoesAcao.cmd_4c_Confirmar.Enabled = loc_lEditar
            ENDIF
            IF PEMSTATUS(loc_oPg2.cnt_4c_BotoesAcao, "cmd_4c_Cancelar", 5)
                loc_oPg2.cnt_4c_BotoesAcao.cmd_4c_Cancelar.Enabled  = .T.
            ENDIF
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarDataMov - Valida data da movimentacao ao sair do campo
    * Legado: Dt_data.Valid - verifica fVerificaBloqueio e fBloqueioPorPeriodo
    * No novo sistema: verifica se a data esta dentro do periodo permitido pelo BO
    * Tambem bloqueia alteracao de data quando ja existem envelopes (TmpOperacao)
    *--------------------------------------------------------------------------
    PROCEDURE ValidarDataMov()
        LOCAL loc_oPg2, loc_dData, loc_lBloqueado, loc_nContEnv
        loc_lBloqueado = .F.

        TRY
            loc_oPg2 = THIS.pgf_4c_Paginas.Page2

            IF !PEMSTATUS(loc_oPg2, "cnt_4c_Dados", 5)
                RETURN
            ENDIF
            IF !PEMSTATUS(loc_oPg2.cnt_4c_Dados, "txt_4c_Dt_data", 5)
                RETURN
            ENDIF

            loc_dData = loc_oPg2.cnt_4c_Dados.txt_4c_Dt_data.Value

            IF !INLIST(THIS.this_cPcEscolha, "INSERIR", "ALTERAR")
                RETURN
            ENDIF

            IF EMPTY(loc_dData)
                MsgAviso("Informe uma data v" + CHR(225) + "lida.", "")
                loc_oPg2.cnt_4c_Dados.txt_4c_Dt_data.Value = DATE()
                RETURN
            ENDIF

            *-- Verifica se ja existem envelopes/ops lancados (TmpOperacao)
            *-- Legado: Count to _LnCont For Codigos > 0
            IF USED("TmpOperacao")
                SELECT TmpOperacao
                COUNT TO loc_nContEnv FOR Codigos > 0
                IF loc_nContEnv > 0
                    MsgAviso("A Data s" + CHR(243) + "mente pode ser alterada antes de Informar Envelopes/Ops", "")
                    loc_lBloqueado = .T.
                ENDIF
            ENDIF

            *-- Verifica bloqueio de periodo no BO
            IF !loc_lBloqueado
                IF VARTYPE(THIS.this_oBusinessObject) = "O"
                    IF THIS.this_oBusinessObject.VerificarPeriodoBloqueado(loc_dData)
                        MsgAviso("Per" + CHR(237) + "odo Bloqueado!!!", "")
                        loc_lBloqueado = .T.
                    ENDIF
                ENDIF
            ENDIF

            IF loc_lBloqueado
                loc_oPg2.cnt_4c_Dados.txt_4c_Dt_data.Value = DATE()
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao validar data:" + CHR(13) + loException.Message, "Erro")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnOperacaoClick - Abre sub-formulario de operacoes (legado: SigPdMp5)
    * Legado: If pcEscolha<>'PROCURAR' -> Disable form -> Select xMfas -> Do Form SigPdMp5
    *--------------------------------------------------------------------------
    PROCEDURE BtnOperacaoClick()
        LOCAL loc_cFormPath
        IF THIS.this_cPcEscolha = "PROCURAR"
            RETURN
        ENDIF
        TRY
            THIS.Enabled = .F.
            IF USED("xMfas")
                SELECT xMfas
                SET ORDER TO
            ENDIF
            loc_cFormPath = gc_4c_CaminhoBase + "..\Framework\SigPdMp5.scx"
            IF FILE(loc_cFormPath)
                DO FORM (loc_cFormPath) WITH THIS, THIS.DataSessionId
            ELSE
                MsgAviso("Subformul" + CHR(225) + "rio de Opera" + CHR(231) + CHR(245) + "es (SigPdMp5) n" + ;
                    CHR(227) + "o dispon" + CHR(237) + "vel.", "")
            ENDIF
            THIS.Enabled = .T.
        CATCH TO loException
            THIS.Enabled = .T.
            MostrarErro("Erro ao abrir Opera" + CHR(231) + CHR(245) + "es:" + CHR(13) + loException.Message, "Erro")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnComponentesClick - Abre sub-formulario de componentes (legado: SigPdMp2)
    * Legado: If pcEscolha<>'PROCURAR' -> Disable form -> Select xNensi -> Do Form SigPdMp2
    *--------------------------------------------------------------------------
    PROCEDURE BtnComponentesClick()
        LOCAL loc_cFormPath
        IF THIS.this_cPcEscolha = "PROCURAR"
            RETURN
        ENDIF
        TRY
            THIS.Enabled = .F.
            IF USED("xNensi")
                SELECT xNensi
                SET ORDER TO
            ENDIF
            loc_cFormPath = gc_4c_CaminhoBase + "..\Framework\SigPdMp2.scx"
            IF FILE(loc_cFormPath)
                DO FORM (loc_cFormPath) WITH THIS, THIS.DataSessionId
            ELSE
                MsgAviso("Subformul" + CHR(225) + "rio de Componentes (SigPdMp2) n" + ;
                    CHR(227) + "o dispon" + CHR(237) + "vel.", "")
            ENDIF
            THIS.Enabled = .T.
        CATCH TO loException
            THIS.Enabled = .T.
            MostrarErro("Erro ao abrir Componentes:" + CHR(13) + loException.Message, "Erro")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnEtiquetasClick - Abre sub-formulario de etiquetas/pesagem
    * Legado: If pcEscolha<>'PROCURAR':
    *   If crSigCdPam.AltPesas=1 -> Select xOpi -> Do Form SigPdMp3
    *   Else -> Select xPesa -> Do Form SigPdMp9
    *--------------------------------------------------------------------------
    PROCEDURE BtnEtiquetasClick()
        LOCAL loc_cFormPath, loc_lAltPesas
        IF THIS.this_cPcEscolha = "PROCURAR"
            RETURN
        ENDIF
        TRY
            THIS.Enabled = .F.
            loc_lAltPesas = .F.

            *-- Verifica flag AltPesas no cursor de parametros (crSigCdPam)
            IF USED("crSigCdPam") AND PEMSTATUS(crSigCdPam, "AltPesas", 8)
                loc_lAltPesas = (crSigCdPam.AltPesas = 1)
            ENDIF

            IF loc_lAltPesas
                IF USED("xOpi")
                    SELECT xOpi
                    GO TOP
                ENDIF
                loc_cFormPath = gc_4c_CaminhoBase + "..\Framework\SigPdMp3.scx"
                IF FILE(loc_cFormPath)
                    DO FORM (loc_cFormPath) WITH THIS, THIS.DataSessionId
                ELSE
                    MsgAviso("Subformul" + CHR(225) + "rio de Etiquetas (SigPdMp3) n" + ;
                        CHR(227) + "o dispon" + CHR(237) + "vel.", "")
                ENDIF
            ELSE
                IF USED("xPesa")
                    SELECT xPesa
                    GO TOP
                ENDIF
                loc_cFormPath = gc_4c_CaminhoBase + "..\Framework\SigPdMp9.scx"
                IF FILE(loc_cFormPath)
                    DO FORM (loc_cFormPath) WITH THIS
                ELSE
                    MsgAviso("Subformul" + CHR(225) + "rio de Etiquetas (SigPdMp9) n" + ;
                        CHR(227) + "o dispon" + CHR(237) + "vel.", "")
                ENDIF
            ENDIF
            THIS.Enabled = .T.
        CATCH TO loException
            THIS.Enabled = .T.
            MostrarErro("Erro ao abrir Etiquetas:" + CHR(13) + loException.Message, "Erro")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnDadosClick - Abre sub-formulario de complemento de dados (legado: SigOpInf)
    * Legado: Do Form SigOpInf With ThisForm, ThisForm.DataSessionId
    *--------------------------------------------------------------------------
    PROCEDURE BtnDadosClick()
        LOCAL loc_cFormPath
        TRY
            loc_cFormPath = gc_4c_CaminhoBase + "..\Framework\SigOpInf.scx"
            IF FILE(loc_cFormPath)
                DO FORM (loc_cFormPath) WITH THIS, THIS.DataSessionId
            ELSE
                MsgAviso("Subformul" + CHR(225) + "rio de Complemento (SigOpInf) n" + ;
                    CHR(227) + "o dispon" + CHR(237) + "vel.", "")
            ENDIF
        CATCH TO loException
            MostrarErro("Erro ao abrir Complemento:" + CHR(13) + loException.Message, "Erro")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnBoletoClick - Impressao de boleto se operacao permite
    * Legado: Seek(ThisForm._Dopp,'crSigCdOpd','Dopps') -> If Boletos=1 -> ImpBol()
    *--------------------------------------------------------------------------
    PROCEDURE BtnBoletoClick()
        LOCAL loc_lPermite
        loc_lPermite = .F.
        TRY
            IF !EMPTY(THIS.this_cDopp) AND USED("crSigCdOpd")
                SELECT crSigCdOpd
                SET NEAR ON
                SEEK THIS.this_cDopp ORDER TAG Dopps
                SET NEAR OFF
                IF FOUND() AND !EOF("crSigCdOpd")
                    loc_lPermite = (crSigCdOpd.Boletos = 1)
                ENDIF
            ENDIF
            IF loc_lPermite
                THIS.ImpBol()
            ELSE
                MsgAviso("Opera" + CHR(231) + CHR(227) + "o atual n" + CHR(227) + ;
                    "o permite impress" + CHR(227) + "o de boleto.", "")
            ENDIF
        CATCH TO loException
            MostrarErro("Erro ao imprimir boleto:" + CHR(13) + loException.Message, "Erro")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnDocumentoClick - Impressao de documento se operacao permite
    * Legado: Seek(ThisForm._Dopp,'crSigCdOpd','Dopps') -> If Docus=1 -> Do SigPrIdc
    *--------------------------------------------------------------------------
    PROCEDURE BtnDocumentoClick()
        LOCAL loc_lPermite, loc_cPrgPath
        loc_lPermite = .F.
        TRY
            IF !EMPTY(THIS.this_cDopp) AND USED("crSigCdOpd")
                SELECT crSigCdOpd
                SET NEAR ON
                SEEK THIS.this_cDopp ORDER TAG Dopps
                SET NEAR OFF
                IF FOUND() AND !EOF("crSigCdOpd")
                    loc_lPermite = (crSigCdOpd.Docus = 1)
                ENDIF
            ENDIF
            IF loc_lPermite AND USED("TmpNens") AND !EOF("TmpNens")
                SELECT TmpNens

                *-- Atualiza cursor crSigCdNec para registro corrente
                IF USED("crSigCdOpd")
                    SELECT crSigCdOpd
                    SET NEAR ON
                    SEEK ALLTRIM(TmpNens.Dopps) ORDER TAG Dopps
                    SET NEAR OFF
                ENDIF

                loc_cPrgPath = gc_4c_CaminhoBase + "..\Framework\SigPrIdc.prg"
                IF FILE(loc_cPrgPath)
                    DO (loc_cPrgPath) WITH ;
                        ALLTRIM(TmpNens.Emps), ALLTRIM(TmpNens.Dopps), TmpNens.Numps, ;
                        0, crSigCdOpd.QtdDocs, .F., .F., .F., .F., .F., .F., THIS
                ELSE
                    MsgAviso("Rotina de impress" + CHR(227) + "o de documento (SigPrIdc) n" + ;
                        CHR(227) + "o dispon" + CHR(237) + "vel.", "")
                ENDIF
            ELSE
                MsgAviso("Opera" + CHR(231) + CHR(227) + "o atual n" + CHR(227) + ;
                    "o permite impress" + CHR(227) + "o de documento.", "")
            ENDIF
        CATCH TO loException
            MostrarErro("Erro ao imprimir documento:" + CHR(13) + loException.Message, "Erro")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * ImpBol - Impressao de boleto via sub-formulario SigOpIbo
    * Legado: Do Form SigOpIbo With Thisform, 2, This.Titulo
    *--------------------------------------------------------------------------
    PROCEDURE ImpBol()
        LOCAL loc_cFormPath
        TRY
            loc_cFormPath = gc_4c_CaminhoBase + "..\Framework\SigOpIbo.scx"
            IF FILE(loc_cFormPath)
                DO FORM (loc_cFormPath) WITH THIS, 2, THIS.this_cTitulo
            ELSE
                MsgAviso("Subformul" + CHR(225) + "rio de boleto (SigOpIbo) n" + ;
                    CHR(227) + "o dispon" + CHR(237) + "vel.", "")
            ENDIF
        CATCH TO loException
            MostrarErro("Erro ao imprimir boleto (ImpBol):" + CHR(13) + loException.Message, "Erro")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * Activate - Gerencia foco automatico ao ativar o formulario
    * Legado: Activate -> Seek(Dopp, crSigCdOpd, Dopps) + SetFocus nos campos
    * this_lAtFoco controla se deve setar foco (evita loop na 1a abertura)
    *--------------------------------------------------------------------------
    PROCEDURE Activate()
        LOCAL loc_oPg2
        TRY
            DODEFAULT()

            *-- Posiciona cursor de operacoes no Dopp corrente
            IF !EMPTY(THIS.this_cDopp) AND USED("crSigCdOpd")
                SELECT crSigCdOpd
                SET NEAR ON
                SEEK THIS.this_cDopp ORDER TAG Dopps
                SET NEAR OFF
            ENDIF

            *-- Coloca foco no campo adequado conforme modo
            IF THIS.this_lAtFoco
                THIS.this_lAtFoco = .F.
                loc_oPg2 = THIS.pgf_4c_Paginas.Page2

                DO CASE
                    CASE THIS.this_cPcEscolha = "PROCURAR"
                        IF PEMSTATUS(loc_oPg2, "cnt_4c_Dados", 5) AND ;
                           PEMSTATUS(loc_oPg2.cnt_4c_Dados, "txt_4c_Codigo", 5)
                            loc_oPg2.cnt_4c_Dados.txt_4c_Codigo.SetFocus
                        ENDIF

                    CASE INLIST(THIS.this_cPcEscolha, "CONSULTAR", "EXCLUIR")
                        IF PEMSTATUS(loc_oPg2, "cnt_4c_BotoesAcao", 5) AND ;
                           PEMSTATUS(loc_oPg2.cnt_4c_BotoesAcao, "cmd_4c_Confirmar", 5)
                            loc_oPg2.cnt_4c_BotoesAcao.cmd_4c_Confirmar.SetFocus
                        ENDIF
                ENDCASE
            ENDIF

            *-- Garantir cursor TmpNens no topo se disponivel
            IF USED("TmpNens")
                SELECT TmpNens
                GO TOP
            ENDIF

        CATCH TO loException
            *-- Erros de foco nao devem travar a interface
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * Destroy - Libera recursos ao fechar o formulario
    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
        LOCAL loc_oErro
        TRY
            IF USED("cursor_4c_Dados")
                USE IN cursor_4c_Dados
            ENDIF
            IF USED("TmpOperacao")
                USE IN TmpOperacao
            ENDIF
            IF VARTYPE(THIS.this_oBusinessObject) = "O"
                THIS.this_oBusinessObject = .NULL.
            ENDIF
        CATCH TO loc_oErro
            *-- Ignorar erros no Destroy para nao bloquear fechamento
        ENDTRY
        DODEFAULT()
    ENDPROC

ENDDEFINE


### BO (C:\4c\projeto\app\classes\sigpdmp7BO.prg):
*==============================================================================
* sigpdmp7BO.prg - Business Object para Movimentacao por Funcionario
* Tabela principal: SigCdNec | PK: cidchaves
* Chave de negocio: empdnps (emps + dopps + str(numps,10))
*==============================================================================

DEFINE CLASS sigpdmp7BO AS BusinessBase

    *-- Propriedades da entidade (mapeamento com campos da tabela SigCdNec)
    *-- Identificacao / chaves
    this_cCidchaves  = ""   && cidchaves CHAR(20)   - PK do sistema
    this_cEmpdnps    = ""   && empdnps   CHAR(33)   - Chave de negocio (emps+dopps+numps)
    this_cEmps       = ""   && emps      CHAR(3)    - Empresa
    this_cEmpds      = ""   && empds     CHAR(3)    - Empresa destino
    this_cDopps      = ""   && dopps     CHAR(20)   - Operacao
    this_nNumps      = 0    && numps     NUMERIC(10)- Numero do processo

    *-- Datas
    this_dDatas      = {}   && datas     DATETIME   - Data da movimentacao
    this_dDatars     = {}   && datars    DATETIME   - Data de registro
    this_dDatatrans  = {}   && datatrans DATETIME   - Data da transacao

    *-- Totais e pesos
    this_nTotpesos   = 0    && totpesos  NUMERIC(11,3) - Total de pesos
    this_nPesolancs  = 0    && pesolancs NUMERIC(11,3) - Peso lancado

    *-- Grupos e contas - Origem
    this_cGrupoos    = ""   && grupoos   CHAR(10)   - Grupo de Origem
    this_cContaos    = ""   && contaos   CHAR(10)   - Conta de Origem

    *-- Grupos e contas - Destino
    this_cGrupods    = ""   && grupods   CHAR(10)   - Grupo de Destino
    this_cContads    = ""   && contads   CHAR(10)   - Conta de Destino

    *-- Responsavel/Vendedor
    this_cGrvends    = ""   && grvends   CHAR(10)   - Grupo do responsavel
    this_cVends      = ""   && vends     CHAR(10)   - Vendedor/Responsavel

    *-- Observacao
    this_cObss       = ""   && obss      TEXT       - Observacao

    *-- Usuario
    this_cUsuars     = ""   && usuars    CHAR(10)   - Usuario lancamento
    this_cUsulibs    = ""   && usulibs   CHAR(10)   - Usuario liberacao
    this_cUsuconfs   = ""   && usuconfs  CHAR(10)   - Usuario confirmacao

    *-- Documentos e localidade
    this_cDocus      = ""   && docus     CHAR(10)   - Documento
    this_cLocals     = ""   && locals    CHAR(10)   - Local
    this_cJobs       = ""   && jobs      CHAR(10)   - Job
    this_cCodnconfs  = ""   && codnconfs CHAR(10)   - Codigo nao conformidade
    this_cLibprods   = ""   && libprods  CHAR(10)   - Liberacao producao

    *-- Contadores numericos
    this_nNtrans     = 0    && ntrans    NUMERIC(6) - Numero transacao
    this_nNops       = 0    && nops      NUMERIC(10)- Numero de operacoes
    this_nNaceites   = 0    && naceites  NUMERIC(10)- Numero de aceites
    this_nNumbalds   = 0    && numbalds  NUMERIC(6) - Numero balancete dest
    this_nNumbals    = 0    && numbals   NUMERIC(6) - Numero balancete orig
    this_nCodobs     = 0    && codobs    NUMERIC(3) - Codigo observacao
    this_nNlotes     = 0    && nlotes    NUMERIC(10)- Numero do lote
    this_nChkbaixa   = 0    && chkbaixa  NUMERIC(1) - Check baixa

    *-- Flags logicos (bit)
    this_lChksubn    = .F.  && chksubn   BIT        - Check sub-numero
    this_lImprs      = .F.  && imprs     BIT        - Impresso
    this_lLccs       = .F.  && lccs      BIT        - LCC
    this_lProcbals   = .F.  && procbals  BIT        - Processado balanco orig
    this_lProcdbal   = .F.  && procdbal  BIT        - Processado balanco dest
    this_lRetrabs    = .F.  && retrabs   BIT        - Retrabalho
    this_lAutos      = .F.  && autos     BIT        - Automatico
    this_lNconforms  = .F.  && nconforms BIT        - Nao conformidade

    *--------------------------------------------------------------------------
    * Init - Inicializa o Business Object
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            DODEFAULT()
            THIS.this_cTabela     = "SigCdNec"
            THIS.this_cCampoChave = "cidchaves"
            loc_lSucesso = .T.
        CATCH TO loException
            MostrarErro("Erro ao inicializar sigpdmp7BO: " + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Retorna chave primaria para auditoria
    *--------------------------------------------------------------------------
    PROCEDURE ObterChavePrimaria()
        RETURN ALLTRIM(THIS.this_cCidchaves)
    ENDPROC

    *--------------------------------------------------------------------------
    * MontarChaveComposta - Calcula empdnps a partir dos componentes
    *--------------------------------------------------------------------------
    FUNCTION MontarChaveComposta()
        LOCAL loc_cChave
        loc_cChave = PADR(ALLTRIM(THIS.this_cEmps),  3) + ;
                     PADR(ALLTRIM(THIS.this_cDopps), 20) + ;
                     STR(THIS.this_nNumps, 10)
        THIS.this_cEmpdnps = loc_cChave
        RETURN loc_cChave
    ENDFUNC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Carrega propriedades a partir do cursor informado
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        IF USED(par_cAliasCursor)
            SELECT (par_cAliasCursor)

            *-- Chave primaria e chave composta
            THIS.this_cCidchaves  = TratarNulo(cidchaves,  "")
            THIS.this_cEmpdnps    = TratarNulo(empdnps,    "")
            THIS.this_cEmps       = TratarNulo(emps,       "")
            THIS.this_cEmpds      = TratarNulo(empds,      "")
            THIS.this_cDopps      = TratarNulo(dopps,      "")
            THIS.this_nNumps      = TratarNulo(numps,       0)

            *-- Datas (SQLEXEC retorna DateTime)
            THIS.this_dDatas     = IIF(VARTYPE(datas)     = "T", TTOD(datas),     TratarNulo(datas,     {}))
            THIS.this_dDatars    = IIF(VARTYPE(datars)    = "T", TTOD(datars),    TratarNulo(datars,    {}))
            THIS.this_dDatatrans = IIF(VARTYPE(datatrans) = "T", TTOD(datatrans), TratarNulo(datatrans, {}))

            *-- Totais
            THIS.this_nTotpesos   = TratarNulo(totpesos,   0)
            THIS.this_nPesolancs  = TratarNulo(pesolancs,  0)

            *-- Origem
            THIS.this_cGrupoos    = TratarNulo(grupoos,    "")
            THIS.this_cContaos    = TratarNulo(contaos,    "")

            *-- Destino
            THIS.this_cGrupods    = TratarNulo(grupods,    "")
            THIS.this_cContads    = TratarNulo(contads,    "")

            *-- Responsavel
            THIS.this_cGrvends    = TratarNulo(grvends,    "")
            THIS.this_cVends      = TratarNulo(vends,      "")

            *-- Observacao (campo text/memo)
            THIS.this_cObss       = TratarNulo(obss,       "")

            *-- Usuarios
            THIS.this_cUsuars     = TratarNulo(usuars,     "")
            THIS.this_cUsulibs    = TratarNulo(usulibs,    "")
            THIS.this_cUsuconfs   = TratarNulo(usuconfs,   "")

            *-- Documentos e localidade
            THIS.this_cDocus      = TratarNulo(docus,      "")
            THIS.this_cLocals     = TratarNulo(locals,     "")
            THIS.this_cJobs       = TratarNulo(jobs,       "")
            THIS.this_cCodnconfs  = TratarNulo(codnconfs,  "")
            THIS.this_cLibprods   = TratarNulo(libprods,   "")

            *-- Contadores numericos
            THIS.this_nNtrans     = TratarNulo(ntrans,      0)
            THIS.this_nNops       = TratarNulo(nops,        0)
            THIS.this_nNaceites   = TratarNulo(naceites,    0)
            THIS.this_nNumbalds   = TratarNulo(numbalds,    0)
            THIS.this_nNumbals    = TratarNulo(numbals,     0)
            THIS.this_nCodobs     = TratarNulo(codobs,      0)
            THIS.this_nNlotes     = TratarNulo(nlotes,      0)
            THIS.this_nChkbaixa   = TratarNulo(chkbaixa,   0)

            *-- Flags logicos (BIT -> LOGICAL)
            THIS.this_lChksubn    = (TratarNulo(chksubn,   0) = 1)
            THIS.this_lImprs      = (TratarNulo(imprs,     0) = 1)
            THIS.this_lLccs       = (TratarNulo(lccs,      0) = 1)
            THIS.this_lProcbals   = (TratarNulo(procbals,  0) = 1)
            THIS.this_lProcdbal   = (TratarNulo(procdbal,  0) = 1)
            THIS.this_lRetrabs    = (TratarNulo(retrabs,   0) = 1)
            THIS.this_lAutos      = (TratarNulo(autos,     0) = 1)
            THIS.this_lNconforms  = (TratarNulo(nconforms, 0) = 1)

            THIS.this_lNovoRegistro = .F.
            loc_lSucesso = .T.
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarPorCodigo - Carrega registro pela chave primaria cidchaves
    * par_cChave : valor de cidchaves (C20)
    *--------------------------------------------------------------------------
    PROCEDURE CarregarPorCodigo(par_cChave)
        LOCAL loc_lSucesso, loc_cSQL, loc_nResultado
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "SELECT cidchaves, empdnps, emps, empds, dopps, numps," + ;
                       " datas, datars, datatrans," + ;
                       " totpesos, pesolancs," + ;
                       " grupoos, contaos, grupods, contads," + ;
                       " grvends, vends, obss," + ;
                       " usuars, usulibs, usuconfs," + ;
                       " docus, locals, jobs, codnconfs, libprods," + ;
                       " ntrans, nops, naceites, numbalds, numbals," + ;
                       " codobs, nlotes, chkbaixa," + ;
                       " chksubn, imprs, lccs, procbals, procdbal," + ;
                       " retrabs, autos, nconforms" + ;
                       " FROM SigCdNec" + ;
                       " WHERE cidchaves = " + EscaparSQL(ALLTRIM(par_cChave))

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")
            IF loc_nResultado > 0 AND RECCOUNT("cursor_4c_Carrega") > 0
                loc_lSucesso = THIS.CarregarDoCursor("cursor_4c_Carrega")
                THIS.this_lNovoRegistro = .F.
            ENDIF

            IF USED("cursor_4c_Carrega")
                USE IN cursor_4c_Carrega
            ENDIF
        CATCH TO loException
            MostrarErro(loException, "sigpdmp7BO.CarregarPorCodigo")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Buscar - Carrega lista de movimentacoes para cursor_4c_Dados
    * par_cFiltro : filtro livre (emps ou dopps - pode ser vazio)
    *--------------------------------------------------------------------------
    PROCEDURE Buscar(par_cFiltro)
        LOCAL loc_lSucesso, loc_cSQL, loc_nResultado, loc_cWhere
        loc_lSucesso = .F.

        TRY
            loc_cWhere = " WHERE 1=1"

            loc_cSQL = "SELECT cidchaves, empdnps, emps, dopps, numps," + ;
                       " datas, totpesos, usuars," + ;
                       " grupoos, contaos, grupods, contads" + ;
                       " FROM SigCdNec" + ;
                       loc_cWhere + ;
                       " ORDER BY datas DESC, numps DESC"

            IF USED("cursor_4c_Dados")
                USE IN cursor_4c_Dados
            ENDIF

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")
            IF loc_nResultado >= 0
                IF RECCOUNT("cursor_4c_Dados") > 0
                    GO TOP IN cursor_4c_Dados
                ENDIF
                loc_lSucesso = .T.
            ELSE
                MostrarErro("Erro ao buscar movimenta" + CHR(231) + CHR(245) + "es:" + ;
                    CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loException
            MostrarErro(loException, "sigpdmp7BO.Buscar")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir - Insere novo registro em SigCdNec
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Inserir()
        LOCAL loc_lSucesso, loc_cSQL, loc_nResultado
        loc_lSucesso = .F.

        TRY
            *-- Gerar cidchaves unico se nao informado
            IF EMPTY(ALLTRIM(THIS.this_cCidchaves))
                THIS.this_cCidchaves = LEFT(SYS(2015) + SYS(2015), 20)
            ENDIF

            *-- Montar chave composta
            THIS.MontarChaveComposta()

            *-- Usuario logado
            IF EMPTY(ALLTRIM(THIS.this_cUsuars))
                THIS.this_cUsuars = ALLTRIM(gc_4c_UsuarioLogado)
            ENDIF

            loc_cSQL = "INSERT INTO SigCdNec (" + ;
                       "cidchaves, empdnps, emps, empds, dopps, numps," + ;
                       " datas, datars, datatrans," + ;
                       " totpesos, pesolancs," + ;
                       " grupoos, contaos, grupods, contads," + ;
                       " grvends, vends, obss," + ;
                       " usuars, usulibs, usuconfs," + ;
                       " docus, locals, jobs, codnconfs, libprods," + ;
                       " ntrans, nops, naceites, numbalds, numbals," + ;
                       " codobs, nlotes, chkbaixa," + ;
                       " chksubn, imprs, lccs, procbals, procdbal," + ;
                       " retrabs, autos, nconforms)" + ;
                       " VALUES (" + ;
                       EscaparSQL(THIS.this_cCidchaves) + ", " + ;
                       EscaparSQL(THIS.this_cEmpdnps) + ", " + ;
                       EscaparSQL(THIS.this_cEmps) + ", " + ;
                       EscaparSQL(THIS.this_cEmpds) + ", " + ;
                       EscaparSQL(THIS.this_cDopps) + ", " + ;
                       FormatarNumeroSQL(THIS.this_nNumps) + ", " + ;
                       FormatarDataSQL(THIS.this_dDatas) + ", " + ;
                       FormatarDataSQL(THIS.this_dDatars) + ", " + ;
                       FormatarDataSQL(THIS.this_dDatatrans) + ", " + ;
                       FormatarNumeroSQL(THIS.this_nTotpesos) + ", " + ;
                       FormatarNumeroSQL(THIS.this_nPesolancs) + ", " + ;
                       EscaparSQL(THIS.this_cGrupoos) + ", " + ;
                       EscaparSQL(THIS.this_cContaos) + ", " + ;
                       EscaparSQL(THIS.this_cGrupods) + ", " + ;
                       EscaparSQL(THIS.this_cContads) + ", " + ;
                       EscaparSQL(THIS.this_cGrvends) + ", " + ;
                       EscaparSQL(THIS.this_cVends) + ", " + ;
                       EscaparSQL(THIS.this_cObss) + ", " + ;
                       EscaparSQL(THIS.this_cUsuars) + ", " + ;
                       EscaparSQL(THIS.this_cUsulibs) + ", " + ;
                       EscaparSQL(THIS.this_cUsuconfs) + ", " + ;
                       EscaparSQL(THIS.this_cDocus) + ", " + ;
                       EscaparSQL(THIS.this_cLocals) + ", " + ;
                       EscaparSQL(THIS.this_cJobs) + ", " + ;
                       EscaparSQL(THIS.this_cCodnconfs) + ", " + ;
                       EscaparSQL(THIS.this_cLibprods) + ", " + ;
                       FormatarNumeroSQL(THIS.this_nNtrans) + ", " + ;
                       FormatarNumeroSQL(THIS.this_nNops) + ", " + ;
                       FormatarNumeroSQL(THIS.this_nNaceites) + ", " + ;
                       FormatarNumeroSQL(THIS.this_nNumbalds) + ", " + ;
                       FormatarNumeroSQL(THIS.this_nNumbals) + ", " + ;
                       FormatarNumeroSQL(THIS.this_nCodobs) + ", " + ;
                       FormatarNumeroSQL(THIS.this_nNlotes) + ", " + ;
                       FormatarNumeroSQL(THIS.this_nChkbaixa) + ", " + ;
                       IIF(THIS.this_lChksubn,  "1", "0") + ", " + ;
                       IIF(THIS.this_lImprs,    "1", "0") + ", " + ;
                       IIF(THIS.this_lLccs,     "1", "0") + ", " + ;
                       IIF(THIS.this_lProcbals, "1", "0") + ", " + ;
                       IIF(THIS.this_lProcdbal, "1", "0") + ", " + ;
                       IIF(THIS.this_lRetrabs,  "1", "0") + ", " + ;
                       IIF(THIS.this_lAutos,    "1", "0") + ", " + ;
                       IIF(THIS.this_lNconforms,"1", "0") + ")"

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("INSERT")
                loc_lSucesso = .T.
            ELSE
                MostrarErro("Erro ao inserir movimenta" + CHR(231) + CHR(227) + "o:" + ;
                    CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loException
            MostrarErro(loException, "sigpdmp7BO.Inserir")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - Atualiza registro existente em SigCdNec
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Atualizar()
        LOCAL loc_lSucesso, loc_cSQL, loc_nResultado
        loc_lSucesso = .F.

        TRY
            IF EMPTY(ALLTRIM(THIS.this_cCidchaves))
                MostrarErro("Chave prim" + CHR(225) + "ria n" + CHR(227) + "o informada para atualiza" + ;
                    CHR(231) + CHR(227) + "o.", "Erro")
                loc_lSucesso = .F.
            ELSE
                *-- Remontar chave composta
                THIS.MontarChaveComposta()

                loc_cSQL = "UPDATE SigCdNec SET " + ;
                           "empdnps    = " + EscaparSQL(THIS.this_cEmpdnps) + ", " + ;
                           "emps       = " + EscaparSQL(THIS.this_cEmps) + ", " + ;
                           "empds      = " + EscaparSQL(THIS.this_cEmpds) + ", " + ;
                           "dopps      = " + EscaparSQL(THIS.this_cDopps) + ", " + ;
                           "numps      = " + FormatarNumeroSQL(THIS.this_nNumps) + ", " + ;
                           "datas      = " + FormatarDataSQL(THIS.this_dDatas) + ", " + ;
                           "datars     = " + FormatarDataSQL(THIS.this_dDatars) + ", " + ;
                           "datatrans  = " + FormatarDataSQL(THIS.this_dDatatrans) + ", " + ;
                           "totpesos   = " + FormatarNumeroSQL(THIS.this_nTotpesos) + ", " + ;
                           "pesolancs  = " + FormatarNumeroSQL(THIS.this_nPesolancs) + ", " + ;
                           "grupoos    = " + EscaparSQL(THIS.this_cGrupoos) + ", " + ;
                           "contaos    = " + EscaparSQL(THIS.this_cContaos) + ", " + ;
                           "grupods    = " + EscaparSQL(THIS.this_cGrupods) + ", " + ;
                           "contads    = " + EscaparSQL(THIS.this_cContads) + ", " + ;
                           "grvends    = " + EscaparSQL(THIS.this_cGrvends) + ", " + ;
                           "vends      = " + EscaparSQL(THIS.this_cVends) + ", " + ;
                           "obss       = " + EscaparSQL(THIS.this_cObss) + ", " + ;
                           "usuars     = " + EscaparSQL(THIS.this_cUsuars) + ", " + ;
                           "usulibs    = " + EscaparSQL(THIS.this_cUsulibs) + ", " + ;
                           "usuconfs   = " + EscaparSQL(THIS.this_cUsuconfs) + ", " + ;
                           "docus      = " + EscaparSQL(THIS.this_cDocus) + ", " + ;
                           "locals     = " + EscaparSQL(THIS.this_cLocals) + ", " + ;
                           "jobs       = " + EscaparSQL(THIS.this_cJobs) + ", " + ;
                           "codnconfs  = " + EscaparSQL(THIS.this_cCodnconfs) + ", " + ;
                           "libprods   = " + EscaparSQL(THIS.this_cLibprods) + ", " + ;
                           "ntrans     = " + FormatarNumeroSQL(THIS.this_nNtrans) + ", " + ;
                           "nops       = " + FormatarNumeroSQL(THIS.this_nNops) + ", " + ;
                           "naceites   = " + FormatarNumeroSQL(THIS.this_nNaceites) + ", " + ;
                           "numbalds   = " + FormatarNumeroSQL(THIS.this_nNumbalds) + ", " + ;
                           "numbals    = " + FormatarNumeroSQL(THIS.this_nNumbals) + ", " + ;
                           "codobs     = " + FormatarNumeroSQL(THIS.this_nCodobs) + ", " + ;
                           "nlotes     = " + FormatarNumeroSQL(THIS.this_nNlotes) + ", " + ;
                           "chkbaixa   = " + FormatarNumeroSQL(THIS.this_nChkbaixa) + ", " + ;
                           "chksubn    = " + IIF(THIS.this_lChksubn,  "1", "0") + ", " + ;
                           "imprs      = " + IIF(THIS.this_lImprs,    "1", "0") + ", " + ;
                           "lccs       = " + IIF(THIS.this_lLccs,     "1", "0") + ", " + ;
                           "procbals   = " + IIF(THIS.this_lProcbals, "1", "0") + ", " + ;
                           "procdbal   = " + IIF(THIS.this_lProcdbal, "1", "0") + ", " + ;
                           "retrabs    = " + IIF(THIS.this_lRetrabs,  "1", "0") + ", " + ;
                           "autos      = " + IIF(THIS.this_lAutos,    "1", "0") + ", " + ;
                           "nconforms  = " + IIF(THIS.this_lNconforms,"1", "0") + " " + ;
                           "WHERE cidchaves = " + EscaparSQL(ALLTRIM(THIS.this_cCidchaves))

                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
                IF loc_nResultado >= 0
                    THIS.RegistrarAuditoria("UPDATE")
                    loc_lSucesso = .T.
                ELSE
                    MostrarErro("Erro ao atualizar movimenta" + CHR(231) + CHR(227) + "o:" + ;
                        CHR(13) + CapturarErroSQL(), "Erro SQL")
                ENDIF
            ENDIF
        CATCH TO loException
            MostrarErro(loException, "sigpdmp7BO.Atualizar")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ExecutarExclusao - Exclui registro de SigCdNec pela PK cidchaves
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ExecutarExclusao()
        LOCAL loc_lSucesso, loc_cSQL, loc_nResultado
        loc_lSucesso = .F.

        TRY
            IF EMPTY(ALLTRIM(THIS.this_cCidchaves))
                MostrarErro("Chave prim" + CHR(225) + "ria n" + CHR(227) + ;
                    "o informada para exclus" + CHR(227) + "o.", "Erro")
                loc_lSucesso = .F.
            ELSE
                loc_cSQL = "DELETE FROM SigCdNec" + ;
                           " WHERE cidchaves = " + EscaparSQL(ALLTRIM(THIS.this_cCidchaves))

                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
                IF loc_nResultado >= 0
                    THIS.RegistrarAuditoria("DELETE")
                    loc_lSucesso = .T.
                ELSE
                    MostrarErro("Erro ao excluir movimenta" + CHR(231) + CHR(227) + "o:" + ;
                        CHR(13) + CapturarErroSQL(), "Erro SQL")
                ENDIF
            ENDIF
        CATCH TO loException
            MostrarErro(loException, "sigpdmp7BO.ExecutarExclusao")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * VerificarPeriodoBloqueado - Verifica se a data cai em periodo bloqueado
    * Equivalente ao fVerificaBloqueio + fBloqueioPorPeriodo do Framework legado
    * par_dData: data a verificar
    * Retorno: .T. se bloqueado, .F. se permitido
    *--------------------------------------------------------------------------
    PROCEDURE VerificarPeriodoBloqueado(par_dData)
        LOCAL loc_lBloqueado, loc_nResultado, loc_cSQL
        loc_lBloqueado = .F.

        TRY
            IF EMPTY(par_dData) OR VARTYPE(par_dData) != "D"
                loc_lBloqueado = .F.
            ELSE
                *-- Tenta usar funcoes do Framework legado se disponiveis no ambiente
                TRY
                    IF PEMSTATUS(_VFP, "fVerificaBloqueio", 5) OR ;
                       TYPE("fVerificaBloqueio") = "FP"
                        IF fVerificaBloqueio(par_dData, gnConnHandle) <> 0
                            loc_lBloqueado = .T.
                        ENDIF
                    ENDIF
                CATCH
                    *-- Framework nao disponivel, nao bloquear
                    loc_lBloqueado = .F.
                ENDTRY

                IF !loc_lBloqueado
                    TRY
                        IF PEMSTATUS(_VFP, "fBloqueioPorPeriodo", 5) OR ;
                           TYPE("fBloqueioPorPeriodo") = "FP"
                            IF fBloqueioPorPeriodo(par_dData, gnConnHandle) <> 0
                                loc_lBloqueado = .T.
                            ENDIF
                        ENDIF
                    CATCH
                        *-- Framework nao disponivel, nao bloquear
                        loc_lBloqueado = .F.
                    ENDTRY
                ENDIF
            ENDIF
        CATCH TO loException
            MostrarErro("Erro ao verificar per" + CHR(237) + "odo:" + ;
                CHR(13) + loException.Message, "Erro")
            loc_lBloqueado = .F.
        ENDTRY

        RETURN loc_lBloqueado
    ENDPROC

ENDDEFINE


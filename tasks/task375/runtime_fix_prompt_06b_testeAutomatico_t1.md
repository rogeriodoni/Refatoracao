# CORRIGIR ERRO DE RUNTIME VFP9

## TAREFA OBRIGATORIA
O formulario VFP9 apresentou erro de runtime durante teste automatizado.
Voce DEVE corrigir o erro e salvar os arquivos corrigidos usando Write tool.

## ERRO DETECTADO
- Etapa: 06b_testeAutomatico
- Tentativa: 1/10
- Mensagem: Testes automaticos: 78% < 100%. Falhas: Teste 'ModoIncluir': Property ALTERNARPAGINA is not found. | Detalhes: Linha: 412; Teste 'BtnIncluirNavegacao': BtnIncluirClick nao navegou para Page2 (ActivePage=1)

## CONTEXTO DO ERRO

### ERROS CAPTURADOS EM MODO TESTE (vfp_error_details.txt):
[29/07/2026 08:15:27] Inserção de Carta: Selecione uma Nota Fiscal na lista.
[29/07/2026 08:15:27] Erro ao inserir carta: RETURN/RETRY statement not allowed in TRY/CATCH.


### LOG DA ETAPA (06b_testeAutomatico):
[2026-07-29 08:14:46] [INFO] === VFP EXECUTOR v2.0 ===
[2026-07-29 08:14:46] [INFO] Config FPW: (nao fornecido)
[2026-07-29 08:14:46] [INFO] Script PRG: C:\4c\projeto\app\utils\TesteAutomatico.prg
[2026-07-29 08:14:46] [INFO] Timeout: 300 segundos
[2026-07-29 08:14:46] [INFO] Wrapper PRG criado para parametros: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_egelp3l2.prg
[2026-07-29 08:14:46] [INFO] Conteudo do wrapper:
[2026-07-29 08:14:46] [INFO] * Auto-generated wrapper for parameters
* Script: C:\4c\projeto\app\utils\TesteAutomatico.prg
* Parameters: 'FormCNF', 'C:\4c\tasks\task375', 'CRUD'

* Anti-dialog protections for unattended execution
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
SET NOTIFY OFF
SYS(2335, 0)

DO "C:\4c\projeto\app\utils\TesteAutomatico" WITH 'FormCNF', 'C:\4c\tasks\task375', 'CRUD'
QUIT

[2026-07-29 08:14:46] [INFO] Comando VFP: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_egelp3l2.prg
[2026-07-29 08:14:46] [INFO] VFP output esperado em: C:\4c\tasks\task375\vfp_output.txt
[2026-07-29 08:14:46] [INFO] Executando Visual FoxPro 9...
[2026-07-29 08:14:46] [INFO] Comando completo: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_egelp3l2.prg
[2026-07-29 08:14:46] [INFO] Executando: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_egelp3l2.prg
[2026-07-29 08:14:46] [INFO] Timeout configurado: 300 segundos
[2026-07-29 08:15:27] [INFO] VFP9 finalizou normalmente com exit code: 
[2026-07-29 08:15:27] [INFO] VFP9 finalizado em 41.6793681 segundos
[2026-07-29 08:15:27] [INFO] Exit Code: 
[2026-07-29 08:15:27] [INFO] 
[2026-07-29 08:15:27] [INFO] Arquivos temporarios preservados para inspecao:
[2026-07-29 08:15:27] [INFO]   Wrapper.prg: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_egelp3l2.prg
[2026-07-29 08:15:27] [INFO] 
[2026-07-29 08:15:27] [INFO] === Conteudo do Wrapper.prg temporario ===
[2026-07-29 08:15:27] [INFO] * Auto-generated wrapper for parameters
[2026-07-29 08:15:27] [INFO] * Script: C:\4c\projeto\app\utils\TesteAutomatico.prg
[2026-07-29 08:15:27] [INFO] * Parameters: 'FormCNF', 'C:\4c\tasks\task375', 'CRUD'
[2026-07-29 08:15:27] [INFO] 
[2026-07-29 08:15:27] [INFO] * Anti-dialog protections for unattended execution
[2026-07-29 08:15:27] [INFO] SET SAFETY OFF
[2026-07-29 08:15:27] [INFO] SET RESOURCE OFF
[2026-07-29 08:15:27] [INFO] SET TALK OFF
[2026-07-29 08:15:27] [INFO] SET NOTIFY OFF
[2026-07-29 08:15:27] [INFO] SYS(2335, 0)
[2026-07-29 08:15:27] [INFO] 
[2026-07-29 08:15:27] [INFO] DO "C:\4c\projeto\app\utils\TesteAutomatico" WITH 'FormCNF', 'C:\4c\tasks\task375', 'CRUD'
[2026-07-29 08:15:27] [INFO] QUIT
[2026-07-29 08:15:27] [INFO] 
[2026-07-29 08:15:27] [INFO] === Fim do Wrapper.prg ===
[2026-07-29 08:15:27] [WARN] AVISO: VFP9 retornou exit code  (normal para VFP9 GUI - validar pelo arquivo de saida)


### RESULTADO DOS TESTES (teste_resultado.json):
{
  "formClass": "FormCNF",
  "timestamp": "20260729081527",
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
      "detalhes": "0 registros em cursor_4c_Dados"
    },
    {
      "nome": "ModoIncluir",
      "passou": false,
      "erro": "Property ALTERNARPAGINA is not found.",
      "detalhes": "Linha: 412"
    },
    {
      "nome": "ModoVisualizar",
      "passou": true,
      "erro": "",
      "detalhes": "Modo VISUALIZAR configurado"
    },
    {
      "nome": "BtnIncluirNavegacao",
      "passou": false,
      "erro": "BtnIncluirClick nao navegou para Page2 (ActivePage=1)",
      "detalhes": ""
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

### FORM (C:\4c\projeto\app\forms\cadastros\FormCNF.prg):
*==============================================================================
* FormCNF.prg - Formulario de Correcao de Notas Fiscais
* Data: 2026-07-29
* Tabela principal: SigMvNfi (PK: cidchaves)
* Legado: SIGCDCNF.SCX (frmcadastro)
* Fase 3/8: Estrutura base - PageFrame, containers, botoes, navegacao
*==============================================================================

DEFINE CLASS FormCNF AS FormBase

    *-- Propriedades visuais (PILAR 1 - UX FIDELITY)
    *-- Original: width=781, height=622 -> novo padrao: 1000x600
    Height       = 600
    Width        = 1000
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
    this_cMensagemErro   = ""
    this_cModoAtual      = "LISTA"

    *-- Estado dos filtros (replicando pSeries/pEmisDe/pEmisAte/pOpE/pOpS do legado)
    this_cEmps           = ""   && empresa corrente (go_4c_Sistema.cCodEmpresa)
    this_cSeriesFiltro   = ""   && serie selecionada no filtro
    this_dEmisDeFiltro   = {}   && data inicio do filtro de emissao
    this_dEmisAteFiltro  = {}   && data fim do filtro de emissao
    this_cOpeFiltro      = "A"  && A=Ambas E=Entrada S=Saida
    this_lCancelasFiltro = .F.  && .T. = exibir canceladas tambem

    *==========================================================================
    * Init - inicializacao padrao (FormBase.Init chama InicializarForm)
    *==========================================================================
    PROCEDURE Init()
        RETURN DODEFAULT()
    ENDPROC

    *==========================================================================
    * InicializarForm - configuracao completa (chamada pelo FormBase.Init)
    *==========================================================================
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            THIS.Caption = "Corre" + CHR(231) + CHR(227) + "o de Notas Fiscais"

            THIS.this_oBusinessObject = CREATEOBJECT("CNFBO")

            IF VARTYPE(THIS.this_oBusinessObject) # "O"
                THIS.this_cMensagemErro = "Erro ao criar CNFBO"
                MsgErro("Erro ao criar CNFBO", "Erro de inicializa" + CHR(231) + CHR(227) + "o")
            ELSE
                *-- Inicializar empresa com empresa do sistema
                THIS.this_cEmps = ALLTRIM(go_4c_Sistema.cCodEmpresa)

                *-- Criar cursor placeholder para a grade (campo a campo - Fase 4 configura grid)
                IF USED("cursor_4c_Dados")
                    USE IN cursor_4c_Dados
                ENDIF
                SET NULL ON
                CREATE CURSOR cursor_4c_Dados ( ;
                    cidchaves   C(20), ;
                    empdopnums  C(29), ;
                    emps        C(3),  ;
                    dopes       C(20), ;
                    numes       N(6,0), ;
                    nfis        C(6),  ;
                    series      C(8),  ;
                    especienfs  C(6),  ;
                    emis        T,     ;
                    dtsaidas    T,     ;
                    datans      T,     ;
                    operas      C(1),  ;
                    correcs     I,     ;
                    cancelas    I,     ;
                    regs        I,     ;
                    cfis        C(10), ;
                    clfis       C(12), ;
                    clifors     C(20), ;
                    cgcs        C(21), ;
                    totprods    N(14,2), ;
                    totnotas    N(14,2), ;
                    vals        N(14,2), ;
                    vlfretes    N(14,2), ;
                    vlseguros   N(14,2), ;
                    despaces    N(14,2), ;
                    codtrans    C(10), ;
                    fretes      N(1,0), ;
                    placas      C(8),  ;
                    ufplacas    C(2),  ;
                    rclis       C(40), ;
                    descricaos  C(60) ;
                )
                SET NULL OFF

                THIS.ConfigurarPageFrame()
                THIS.ConfigurarPaginaLista()
                THIS.ConfigurarPaginaDados()
                THIS.ConfigurarBindings()

                *-- Propagar caption para label do cabecalho
                THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
                THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption

                IF NOT (TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI)
                    IF !THIS.CarregarLista()
                        *-- falha nao impede abertura
                    ENDIF
                ENDIF

                THIS.pgf_4c_Paginas.Visible    = .T.
                THIS.pgf_4c_Paginas.ActivePage = 1
                THIS.this_cModoAtual           = "LISTA"
                loc_lSucesso                   = .T.
            ENDIF

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro ao inicializar FormCNF")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * ConfigurarPageFrame - PageFrame principal (Legado: SIGCDCNF.Pagina)
    * Legado: frmcadastro - PageCount=2, Top varia por heranca
    * Novo: Top=-29 (padrao framework), Width=1000
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPageFrame()
        THIS.AddObject("pgf_4c_Paginas", "PageFrame")

        WITH THIS.pgf_4c_Paginas
            .Top       = -29
            .Left      = 0
            .Width     = 1000
            .Height    = 629
            .PageCount = 2
            .Tabs      = .F.
            .Visible   = .T.

            .Page1.Caption   = "Lista"
            .Page1.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
            .Page1.BackColor = RGB(255, 255, 255)

            .Page2.Caption   = "Dados"
            .Page2.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
            .Page2.BackColor = RGB(255, 255, 255)
        ENDWITH
    ENDPROC

    *==========================================================================
    * ConfigurarPaginaLista - Page1: cabecalho + filtros + botoes + grade
    * Legado: cntFiltros (empresa/serie/periodo/optFiltro) + InserirCarta +
    *         AlteraCarta + ImpCarta (top=85) + Grade
    * Compensacao PageFrame: +29 em Top
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPaginaLista()
        LOCAL loc_oPagina, loc_oGrid
        loc_oPagina = THIS.pgf_4c_Paginas.Page1

        *-- Fundo padrao do framework frmcadastro (sem isso a pagina fica branca)
        loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"

        *-- Cabecalho escuro com titulo (cntSombra do legado: Top=2 -> 31)
        loc_oPagina.AddObject("cnt_4c_Cabecalho", "Container")
        WITH loc_oPagina.cnt_4c_Cabecalho
            .Top         = 31
            .Left        = 0
            .Width       = THIS.Width
            .Height      = 80
            .BackStyle   = 1
            .BackColor   = RGB(100, 100, 100)
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH

        loc_oPagina.cnt_4c_Cabecalho.AddObject("lbl_4c_Sombra", "Label")
        WITH loc_oPagina.cnt_4c_Cabecalho.lbl_4c_Sombra
            .Caption   = THIS.Caption
            .Top       = 17
            .Left      = 12
            .Width     = THIS.Width - 20
            .Height    = 46
            .FontName  = "Tahoma"
            .FontSize  = 16
            .FontBold  = .T.
            .AutoSize  = .F.
            .BackStyle = 0
            .ForeColor = RGB(0, 0, 0)
            .Visible   = .T.
        ENDWITH

        loc_oPagina.cnt_4c_Cabecalho.AddObject("lbl_4c_Titulo", "Label")
        WITH loc_oPagina.cnt_4c_Cabecalho.lbl_4c_Titulo
            .Caption   = THIS.Caption
            .Top       = 20
            .Left      = 10
            .Width     = THIS.Width - 20
            .Height    = 46
            .FontName  = "Tahoma"
            .FontSize  = 16
            .FontBold  = .T.
            .AutoSize  = .F.
            .BackStyle = 0
            .ForeColor = RGB(255, 255, 255)
            .Visible   = .T.
        ENDWITH

        *-- Botoes de acao personalizados (InserirCarta/AlteraCarta/ImpCarta)
        *-- Legado: top=85 -> compensado=114, left=41/113/185 (esq. da pagina)
        *-- Novo: posicao relativa ao canvas - lado direito sobre o cabecalho
        loc_oPagina.AddObject("cnt_4c_Botoes", "Container")
        WITH loc_oPagina.cnt_4c_Botoes
            .Top         = 29
            .Left        = 542
            .Width       = 370
            .Height      = 85
            .BackStyle   = 0
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH

        loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_InserirCarta", "CommandButton")
        WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_InserirCarta
            .Caption         = "Incluir"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_inserir_26.jpg"
            .PicturePosition = 13
            .Width           = 75
            .Height          = 75
            .Left            = 5
            .Top             = 5
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

        loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_AlteraCarta", "CommandButton")
        WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_AlteraCarta
            .Caption         = "Alterar"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_alterar_60.jpg"
            .PicturePosition = 13
            .Width           = 75
            .Height          = 75
            .Left            = 80
            .Top             = 5
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

        loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_ImpCarta", "CommandButton")
        WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_ImpCarta
            .Caption         = "Imprimir"
            .Picture         = gc_4c_CaminhoIcones + "relatorio_imprimir_60.jpg"
            .PicturePosition = 13
            .Width           = 75
            .Height          = 75
            .Left            = 155
            .Top             = 5
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

        *-- Container Saida/Encerrar - padrao canonico (Left=917, Width=90)
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

        *-- Container de filtros (cntFiltros do legado: top=164, height=48)
        loc_oPagina.AddObject("cnt_4c_Filtros", "Container")
        WITH loc_oPagina.cnt_4c_Filtros
            .Top         = 116
            .Left        = 0
            .Width       = THIS.Width
            .Height      = 48
            .BackStyle   = 1
            .BackColor   = RGB(210, 210, 210)
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH

        THIS.ConfigurarFiltros(loc_oPagina)

        *-- Grade de notas fiscais (legado: Grade top=224 left=35 w=736 h=410)
        *-- Novo: top=166 (abaixo dos filtros), largura total, altura ate fundo da pagina
        loc_oPagina.AddObject("grd_4c_Lista", "Grid")
        loc_oGrid = loc_oPagina.grd_4c_Lista
        WITH loc_oGrid
            .Top          = 166
            .Left         = 0
            .Width        = THIS.Width
            .Height       = 461
            .ReadOnly     = .T.
            .ColumnCount  = 4
            .Visible      = .T.
        ENDWITH

        WITH loc_oGrid.Column1
            .ControlSource = "cursor_4c_Dados.nfis"
            .Width         = 70
            .Alignment     = 2
        ENDWITH
        loc_oGrid.Column1.Header1.Caption = "NF N" + CHR(176)

        WITH loc_oGrid.Column2
            .ControlSource = "cursor_4c_Dados.emis"
            .Width         = 95
            .Alignment     = 2
        ENDWITH
        loc_oGrid.Column2.Header1.Caption = "Emiss" + CHR(227) + "o"

        WITH loc_oGrid.Column3
            .ControlSource = "cursor_4c_Dados.totnotas"
            .Width         = 120
            .Alignment     = 2
        ENDWITH
        loc_oGrid.Column3.Header1.Caption = "Total NF"

        WITH loc_oGrid.Column4
            .ControlSource = "cursor_4c_Dados.rclis"
            .Width         = 715
            .Alignment     = 2
        ENDWITH
        loc_oGrid.Column4.Header1.Caption = "Cliente / Fornecedor"

        loc_oGrid.ColumnCount = 3
        loc_oGrid.RecordSource = "cursor_4c_Dados"

        *-- Redefinir ControlSource apos RecordSource (VFP faz auto-bind pela ordem dos campos)
        loc_oGrid.Column1.ControlSource = "cursor_4c_Dados.nfis"
        loc_oGrid.Column2.ControlSource = "cursor_4c_Dados.emis"
        loc_oGrid.Column3.ControlSource = "cursor_4c_Dados.totnotas"
        loc_oGrid.Column1.Header1.Caption = "NF N" + CHR(176)
        loc_oGrid.Column2.Header1.Caption = "Emiss" + CHR(227) + "o"
        loc_oGrid.Column3.Header1.Caption = "Total NF"

        *-- NFs com carta de correcao em vermelho (legado: DynamicForeColor em Grade)
        loc_oGrid.SetAll("DynamicForeColor", ;
            "IIF(cursor_4c_Dados.correcs > 0, RGB(255,0,0), RGB(0,0,0))", "Column")

        THIS.FormatarGridLista(loc_oGrid)

        THIS.TornarControlesVisiveis(loc_oPagina)
    ENDPROC

    *==========================================================================
    * ConfigurarPaginaDados - Page2: campos NF + aba Impostos/Servicos
    * Legado: Dados com Get_dope/Get_nume/Get_nota/etc + Pagina(Impostos+Servicos)
    * Compensacao PageFrame: +29 em Top
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPaginaDados()
        LOCAL loc_oPagina, loc_oCab
        loc_oPagina = THIS.pgf_4c_Paginas.Page2

        loc_oPagina.Picture  = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
        loc_oPagina.BackColor = RGB(255, 255, 255)

        *-- Container Salva: Confirmar + Cancelar (Grupo_Salva do legado: top=4 -> 33)
        loc_oPagina.AddObject("cnt_4c_Salva", "Container")
        WITH loc_oPagina.cnt_4c_Salva
            .Top         = 33
            .Left        = 842
            .Width       = 160
            .Height      = 85
            .BackStyle   = 0
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH

        loc_oPagina.cnt_4c_Salva.AddObject("cmd_4c_Confirmar", "CommandButton")
        WITH loc_oPagina.cnt_4c_Salva.cmd_4c_Confirmar
            .Caption         = "Confirmar"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
            .PicturePosition = 13
            .Width           = 75
            .Height          = 75
            .Left            = 5
            .Top             = 17
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

        loc_oPagina.cnt_4c_Salva.AddObject("cmd_4c_Cancelar", "CommandButton")
        WITH loc_oPagina.cnt_4c_Salva.cmd_4c_Cancelar
            .Caption         = "Encerrar"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_cancelar_60.jpg"
            .PicturePosition = 13
            .Width           = 75
            .Height          = 75
            .Left            = 80
            .Top             = 5
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

        *-- Container dos campos de cabecalho da NF (Pagina.Dados diretos)
        *-- Legado: campos Say1/Get_dope/etc original top=10-91 dentro de Pagina.Dados
        *-- Container em Page2: top=33 (=4+29), left=15
        *-- Campos internos: top = original_top - 4, left = original_left - 15
        loc_oPagina.AddObject("cnt_4c_DadosCab", "Container")
        loc_oCab = loc_oPagina.cnt_4c_DadosCab
        WITH loc_oCab
            .Top         = 33
            .Left        = 15
            .Width       = 820
            .Height      = 115
            .BackStyle   = 0
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH

        *-- Row 1 esq: Say1 "Operacao" (original top=14, left=72 -> cnt top=10, left=57)
        loc_oCab.AddObject("lbl_4c_SayOpe", "Label")
        WITH loc_oCab.lbl_4c_SayOpe
            .Caption   = "Opera" + CHR(231) + CHR(227) + "o"
            .Top       = 10
            .Left      = 57
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(53, 53, 53)
            .AutoSize  = .T.
            .Visible   = .T.
        ENDWITH

        *-- Get_dope (original top=29, left=72, width=150 -> cnt top=25, left=57)
        loc_oCab.AddObject("txt_4c_Dope", "TextBox")
        WITH loc_oCab.txt_4c_Dope
            .Top       = 25
            .Left      = 57
            .Width     = 150
            .Height    = 21
            .MaxLength = 20
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ReadOnly  = .T.
            .Value     = ""
            .Visible   = .T.
        ENDWITH

        *-- Row 1 dir: Say_Emissao "Data Emissao" (original top=10, left=455 -> cnt top=6, left=440)
        loc_oCab.AddObject("lbl_4c_SayEmissao", "Label")
        WITH loc_oCab.lbl_4c_SayEmissao
            .Caption   = "Data Emiss" + CHR(227) + "o"
            .Top       = 6
            .Left      = 440
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(53, 53, 53)
            .AutoSize  = .T.
            .Visible   = .T.
        ENDWITH

        *-- Get_Emissao (original top=25, left=455, width=80 -> cnt top=21, left=440)
        loc_oCab.AddObject("txt_4c_DtEmissao", "TextBox")
        WITH loc_oCab.txt_4c_DtEmissao
            .Top       = 21
            .Left      = 440
            .Width     = 80
            .Height    = 21
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ReadOnly  = .T.
            .Value     = {}
            .Visible   = .T.
        ENDWITH

        *-- Row 2 esq: Say2 "Numero" (original top=51, left=71 -> cnt top=47, left=56)
        loc_oCab.AddObject("lbl_4c_SayNum", "Label")
        WITH loc_oCab.lbl_4c_SayNum
            .Caption   = "N" + CHR(250) + "mero"
            .Top       = 47
            .Left      = 56
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(53, 53, 53)
            .AutoSize  = .T.
            .Visible   = .T.
        ENDWITH

        *-- Get_Numero (original top=66, left=71, width=52 -> cnt top=62, left=56)
        loc_oCab.AddObject("txt_4c_Numes", "TextBox")
        WITH loc_oCab.txt_4c_Numes
            .Top       = 62
            .Left      = 56
            .Width     = 52
            .Height    = 21
            .MaxLength = 8
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ReadOnly  = .T.
            .Value     = ""
            .Visible   = .T.
        ENDWITH

        *-- Say7 "Serie" (original top=51, left=143 -> cnt top=47, left=128)
        loc_oCab.AddObject("lbl_4c_SaySerie", "Label")
        WITH loc_oCab.lbl_4c_SaySerie
            .Caption   = "S" + CHR(233) + "rie"
            .Top       = 47
            .Left      = 128
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(53, 53, 53)
            .AutoSize  = .T.
            .Visible   = .T.
        ENDWITH

        *-- Get_Serie NF (original top=66, left=143, width=34 -> cnt top=62, left=128)
        *-- Atencao: diferente de txt_4c_Serie do filtro (Page1)
        loc_oCab.AddObject("txt_4c_NfSerie", "TextBox")
        WITH loc_oCab.txt_4c_NfSerie
            .Top       = 62
            .Left      = 128
            .Width     = 34
            .Height    = 21
            .MaxLength = 8
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ReadOnly  = .T.
            .Value     = ""
            .Visible   = .T.
        ENDWITH

        *-- Say4 "NF no" (original top=51, left=196 -> cnt top=47, left=181)
        loc_oCab.AddObject("lbl_4c_SayNfNum", "Label")
        WITH loc_oCab.lbl_4c_SayNfNum
            .Caption   = "NF n" + CHR(176)
            .Top       = 47
            .Left      = 181
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(53, 53, 53)
            .AutoSize  = .T.
            .Visible   = .T.
        ENDWITH

        *-- Get_nota (original top=66, left=196, width=52 -> cnt top=62, left=181)
        *-- Legado: When=InList(pcEscolha,'PROCURAR'); LostFocus=SetFocus Salva
        loc_oCab.AddObject("txt_4c_Nota", "TextBox")
        WITH loc_oCab.txt_4c_Nota
            .Top       = 62
            .Left      = 181
            .Width     = 52
            .Height    = 21
            .MaxLength = 6
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ReadOnly  = .T.
            .Value     = ""
            .Visible   = .T.
        ENDWITH

        *-- Say8 "Especie" (original top=51, left=257 -> cnt top=47, left=242)
        loc_oCab.AddObject("lbl_4c_SayEsp", "Label")
        WITH loc_oCab.lbl_4c_SayEsp
            .Caption   = "Esp" + CHR(233) + "cie"
            .Top       = 47
            .Left      = 242
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(53, 53, 53)
            .AutoSize  = .T.
            .Visible   = .T.
        ENDWITH

        *-- Get_Especie (original top=66, left=257, width=53 -> cnt top=62, left=242)
        loc_oCab.AddObject("txt_4c_Especie", "TextBox")
        WITH loc_oCab.txt_4c_Especie
            .Top       = 62
            .Left      = 242
            .Width     = 53
            .Height    = 21
            .MaxLength = 6
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ReadOnly  = .T.
            .Value     = ""
            .Visible   = .T.
        ENDWITH

        *-- Say6 "Data Saida" (original top=50, left=455 -> cnt top=46, left=440)
        loc_oCab.AddObject("lbl_4c_SaySaida", "Label")
        WITH loc_oCab.lbl_4c_SaySaida
            .Caption   = "Data Sa" + CHR(237) + "da"
            .Top       = 46
            .Left      = 440
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(53, 53, 53)
            .AutoSize  = .T.
            .Visible   = .T.
        ENDWITH

        *-- Get_Saidas (original top=65, left=455, width=80 -> cnt top=61, left=440)
        loc_oCab.AddObject("txt_4c_DtSaidas", "TextBox")
        WITH loc_oCab.txt_4c_DtSaidas
            .Top       = 61
            .Left      = 440
            .Width     = 80
            .Height    = 21
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ReadOnly  = .T.
            .Value     = {}
            .Visible   = .T.
        ENDWITH

        *-- Row 3: Say5 "CFOP :" (original top=95, left=27 -> cnt top=91, left=12)
        loc_oCab.AddObject("lbl_4c_SayCfop", "Label")
        WITH loc_oCab.lbl_4c_SayCfop
            .Caption   = "CFOP :"
            .Top       = 91
            .Left      = 12
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(53, 53, 53)
            .AutoSize  = .T.
            .Visible   = .T.
        ENDWITH

        *-- Get_ClFiscal (original top=91, left=71, width=63 -> cnt top=87, left=56)
        loc_oCab.AddObject("txt_4c_ClFiscal", "TextBox")
        WITH loc_oCab.txt_4c_ClFiscal
            .Top       = 87
            .Left      = 56
            .Width     = 63
            .Height    = 21
            .MaxLength = 10
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ReadOnly  = .T.
            .Value     = ""
            .Visible   = .T.
        ENDWITH

        *-- Get_DClFiscal (original top=91, left=136, width=407 -> cnt top=87, left=121)
        loc_oCab.AddObject("txt_4c_DClFiscal", "TextBox")
        WITH loc_oCab.txt_4c_DClFiscal
            .Top       = 87
            .Left      = 121
            .Width     = 407
            .Height    = 21
            .MaxLength = 60
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ReadOnly  = .T.
            .Value     = ""
            .Visible   = .T.
        ENDWITH

        *-- PageFrame interno (SIGCDCNF.Pagina.Dados.Pagina)
        *-- Legado: top=123, left=15, width=739, height=459, PageCount=2
        *-- Compensacao PageFrame outer (-29 +29 = 0 neste nivel), so top=123+29=152
        loc_oPagina.AddObject("pgf_4c_InnerPage", "PageFrame")
        loc_oPagina.pgf_4c_InnerPage.Top       = 152
        loc_oPagina.pgf_4c_InnerPage.Left      = 15
        loc_oPagina.pgf_4c_InnerPage.Width     = 970
        loc_oPagina.pgf_4c_InnerPage.Height    = 447
        loc_oPagina.pgf_4c_InnerPage.PageCount = 2
        loc_oPagina.pgf_4c_InnerPage.Tabs      = .T.
        loc_oPagina.pgf_4c_InnerPage.Visible   = .T.

        WITH loc_oPagina.pgf_4c_InnerPage
            .Page1.Caption   = "Impostos"
            .Page1.BackColor = RGB(255, 255, 255)
            .Page2.Caption   = "Servi" + CHR(231) + "os"
            .Page2.BackColor = RGB(255, 255, 255)
        ENDWITH

        THIS.ConfigurarAbaImpostos()
        THIS.ConfigurarAbaServicos()
        THIS.TornarControlesVisiveis(loc_oPagina)
    ENDPROC

    *==========================================================================
    * ConfigurarBindings - BINDEVENTs dos botoes e grade
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarBindings()
        LOCAL loc_oPg1, loc_oPg2
        loc_oPg1 = THIS.pgf_4c_Paginas.Page1
        loc_oPg2 = THIS.pgf_4c_Paginas.Page2

        *-- Encerrar (Page1)
        BINDEVENT(loc_oPg1.cnt_4c_Saida.cmd_4c_Encerrar, "Click", THIS, "BtnEncerrarClick")

        *-- Acoes personalizadas (Page1)
        BINDEVENT(loc_oPg1.cnt_4c_Botoes.cmd_4c_InserirCarta, "Click", THIS, "BtnInserirCartaClick")
        BINDEVENT(loc_oPg1.cnt_4c_Botoes.cmd_4c_AlteraCarta,  "Click", THIS, "BtnAlteraCartaClick")
        BINDEVENT(loc_oPg1.cnt_4c_Botoes.cmd_4c_ImpCarta,     "Click", THIS, "BtnImpCartaClick")

        *-- Grade: selecao de linha atualiza estado dos botoes
        BINDEVENT(loc_oPg1.grd_4c_Lista, "AfterRowColChange", THIS, "GrdListaAfterRowColChange")

        *-- Filtros (Page1)
        LOCAL loc_oCnt
        loc_oCnt = loc_oPg1.cnt_4c_Filtros
        BINDEVENT(loc_oCnt.txt_4c_Emp,    "KeyPress",         THIS, "ValidarEmpresa")
        BINDEVENT(loc_oCnt.txt_4c_Serie,  "KeyPress",         THIS, "ValidarSerie")
        BINDEVENT(loc_oCnt.txt_4c_DtIni,  "KeyPress",         THIS, "ValidarDtIni")
        BINDEVENT(loc_oCnt.txt_4c_DtFim,  "KeyPress",         THIS, "ValidarDtFim")
        BINDEVENT(loc_oCnt.txt_4c_DtFim,  "When",              THIS, "DtFimWhenCheck")
        BINDEVENT(loc_oCnt.opt_4c_Filtro, "InteractiveChange", THIS, "FiltroChanged")

        *-- Salvar/Cancelar (Page2)
        BINDEVENT(loc_oPg2.cnt_4c_Salva.cmd_4c_Confirmar, "Click", THIS, "BtnConfirmarClick")
        BINDEVENT(loc_oPg2.cnt_4c_Salva.cmd_4c_Cancelar,  "Click", THIS, "BtnCancelarClick")

        *-- NF numero: LostFocus move foco para Confirmar (legado: Get_nota.LostFocus -> Salva.SetFocus)
        BINDEVENT(loc_oPg2.cnt_4c_DadosCab.txt_4c_Nota, "KeyPress", THIS, "NotaLostFocus")

        *-- Botao Dados na aba Impostos (abre SigMvExp)
        LOCAL loc_oAbaImp
        loc_oAbaImp = THIS.pgf_4c_Paginas.Page2.pgf_4c_InnerPage.Page1
        BINDEVENT(loc_oAbaImp.cmd_4c_Dados, "Click", THIS, "BtnDadosClick")
    ENDPROC

    *==========================================================================
    * CarregarLista - Carrega lista de NFs segundo filtros atuais
    *==========================================================================
    PROCEDURE CarregarLista()
        LOCAL loc_lResultado
        loc_lResultado = .F.

        TRY
            IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
                loc_lResultado = .T.
            ELSE
                *-- Repassar filtros para o BO antes de chamar Buscar
                THIS.this_oBusinessObject.this_cEmps           = THIS.this_cEmps
                THIS.this_oBusinessObject.this_cSeriesFiltro   = THIS.this_cSeriesFiltro
                THIS.this_oBusinessObject.this_tEmisDeFiltro   = THIS.this_dEmisDeFiltro
                THIS.this_oBusinessObject.this_tEmisAteFiltro  = THIS.this_dEmisAteFiltro
                THIS.this_oBusinessObject.this_cOpeFiltro      = THIS.this_cOpeFiltro
                THIS.this_oBusinessObject.this_lCancelasFiltro = THIS.this_lCancelasFiltro
                THIS.this_oBusinessObject.this_cNfisDeFiltro   = ""
                THIS.this_oBusinessObject.this_cNfisAteFiltro  = ""

                *-- Buscar requer empresa e serie preenchidos para consultar
                IF !EMPTY(ALLTRIM(THIS.this_cEmps)) AND !EMPTY(ALLTRIM(THIS.this_cSeriesFiltro))
                    IF THIS.this_oBusinessObject.Buscar("")
                        THIS.pgf_4c_Paginas.Page1.grd_4c_Lista.ColumnCount = 3
                        THIS.pgf_4c_Paginas.Page1.grd_4c_Lista.RecordSource = "cursor_4c_Dados"
                        THIS.pgf_4c_Paginas.Page1.grd_4c_Lista.Column1.ControlSource = "cursor_4c_Dados.nfis"
                        THIS.pgf_4c_Paginas.Page1.grd_4c_Lista.Column2.ControlSource = "cursor_4c_Dados.emis"
                        THIS.pgf_4c_Paginas.Page1.grd_4c_Lista.Column3.ControlSource = "cursor_4c_Dados.totnotas"
                        THIS.pgf_4c_Paginas.Page1.grd_4c_Lista.Refresh()
                        loc_lResultado = .T.
                    ELSE
                        loc_lResultado = .F.
                    ENDIF
                ELSE
                    *-- Sem filtros suficientes: lista permanece vazia (nao e erro)
                    loc_lResultado = .T.
                ENDIF
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao carregar lista de NFs")
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * AlternarPagina - Navega entre Page1 (Lista) e Page2 (Dados)
    *==========================================================================
    PROTECTED PROCEDURE AlternarPagina(par_nPagina)
        LOCAL loc_lResultado
        loc_lResultado = .F.

        IF VARTYPE(par_nPagina) # "N" OR par_nPagina < 1 OR par_nPagina > 2
            RETURN .F.
        ENDIF

        TRY
            THIS.pgf_4c_Paginas.ActivePage = par_nPagina

            IF par_nPagina = 1
                THIS.this_cModoAtual = "LISTA"
                IF NOT (TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI)
                    THIS.CarregarLista()
                ENDIF
            ENDIF

            loc_lResultado = .T.

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao alternar p" + CHR(225) + "gina")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * GrdListaAfterRowColChange - Habilita/desabilita botoes conforme linha selecionada
    * (BINDEVENT AfterRowColChange exige LPARAMETERS com par_nColIndex)
    *==========================================================================
    PROCEDURE GrdListaAfterRowColChange(par_nColIndex)
        LOCAL loc_lTemCarta
        loc_lTemCarta = .F.

        TRY
            IF USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados") AND !BOF("cursor_4c_Dados")
                SELECT cursor_4c_Dados
                loc_lTemCarta = (NVL(cursor_4c_Dados.correcs, 0) > 0)
            ENDIF

            WITH THIS.pgf_4c_Paginas.Page1.cnt_4c_Botoes
                .cmd_4c_AlteraCarta.Enabled = loc_lTemCarta
                .cmd_4c_ImpCarta.Enabled    = loc_lTemCarta
                .Visible     = .T.
            ENDWITH

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao atualizar bot" + CHR(245) + "es")
        ENDTRY
    ENDPROC

    *==========================================================================
    * BtnEncerrarClick - Fecha o formulario
    *==========================================================================
    PROCEDURE BtnEncerrarClick()
        THIS.Release()
    ENDPROC

    *==========================================================================
    * BtnInserirCartaClick - Inserir nova carta de correcao para NF selecionada
    *==========================================================================
    PROCEDURE BtnInserirCartaClick()
        LOCAL loc_lResultado
        loc_lResultado = .F.

        TRY
            IF !USED("cursor_4c_Dados") OR RECCOUNT("cursor_4c_Dados") = 0 OR ;
               EOF("cursor_4c_Dados")
                MsgAviso("Selecione uma Nota Fiscal na lista.", ;
                    "Inser" + CHR(231) + CHR(227) + "o de Carta")
                RETURN
            ENDIF

            SELECT cursor_4c_Dados

            IF THIS.this_oBusinessObject.CarregarPorCodigo(ALLTRIM(cursor_4c_Dados.cidchaves))
                THIS.this_oBusinessObject.NovoRegistro()
                THIS.this_cModoAtual = "INCLUIR"
                THIS.BOParaForm()
                THIS.HabilitarCampos(.T.)
                THIS.AlternarPagina(2)
                loc_lResultado = .T.
            ELSE
                MsgErro(THIS.this_oBusinessObject.this_cMensagemErro, ;
                    "Erro ao carregar NF")
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao inserir carta")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * BtnAlteraCartaClick - Alterar carta de correcao existente
    *==========================================================================
    PROCEDURE BtnAlteraCartaClick()
        LOCAL loc_lResultado
        loc_lResultado = .F.

        TRY
            IF !USED("cursor_4c_Dados") OR RECCOUNT("cursor_4c_Dados") = 0 OR ;
               EOF("cursor_4c_Dados")
                MsgAviso("Selecione uma Nota Fiscal na lista.", ;
                    "Altera" + CHR(231) + CHR(227) + "o de Carta")
                RETURN
            ENDIF

            SELECT cursor_4c_Dados

            IF NVL(cursor_4c_Dados.correcs, 0) = 0
                MsgAviso("A nota selecionada n" + CHR(227) + "o possui carta de corre" + ;
                    CHR(231) + CHR(227) + "o para alterar.", "Aviso")
                RETURN
            ENDIF

            IF THIS.this_oBusinessObject.CarregarPorCodigo(ALLTRIM(cursor_4c_Dados.cidchaves))
                THIS.this_oBusinessObject.EditarRegistro()
                THIS.this_cModoAtual = "ALTERAR"
                THIS.BOParaForm()
                THIS.HabilitarCampos(.T.)
                THIS.AlternarPagina(2)
                loc_lResultado = .T.
            ELSE
                MsgErro(THIS.this_oBusinessObject.this_cMensagemErro, ;
                    "Erro ao carregar NF")
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao alterar carta")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * BtnImpCartaClick - Imprimir carta de correcao (handler Fase 7)
    * Logica: DO FORM SigCnFCrt (legado) com parametros da NF selecionada
    *==========================================================================
    PROCEDURE BtnImpCartaClick()
        LOCAL loc_lResultado, loc_cCidchaves, loc_cEdns, loc_cSerie
        LOCAL loc_dEmisDe, loc_dEmisAte
        loc_lResultado = .F.

        IF !USED("cursor_4c_Dados") OR RECCOUNT("cursor_4c_Dados") = 0 OR ;
           EOF("cursor_4c_Dados")
            MsgAviso("Selecione uma Nota Fiscal na lista.", ;
                "Impress" + CHR(227) + "o de Carta")
            RETURN .F.
        ENDIF

        SELECT cursor_4c_Dados

        IF NVL(cursor_4c_Dados.correcs, 0) = 0
            MsgAviso("A nota selecionada n" + CHR(227) + "o possui carta de corre" + ;
                CHR(231) + CHR(227) + "o para imprimir.", "Aviso")
            RETURN .F.
        ENDIF

        TRY
            loc_cCidchaves = ALLTRIM(cursor_4c_Dados.cidchaves)
            loc_cEdns      = ALLTRIM(cursor_4c_Dados.empdopnums)
            loc_cSerie     = ALLTRIM(THIS.this_cSeriesFiltro)
            loc_dEmisDe    = THIS.this_dEmisDeFiltro
            loc_dEmisAte   = THIS.this_dEmisAteFiltro

            IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCidchaves)
                *-- Impressao via helper do BO (metodo ImprimirCarta adicionado na Fase 7)
                loc_lResultado = THIS.this_oBusinessObject.ImprimirCarta( ;
                    loc_cEdns, loc_cSerie, loc_dEmisDe, loc_dEmisAte)
            ELSE
                MsgErro(THIS.this_oBusinessObject.this_cMensagemErro, ;
                    "Erro ao carregar NF")
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao imprimir carta")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * BtnConfirmarClick - Salvar dados da carta de correcao
    *==========================================================================
    PROCEDURE BtnConfirmarClick()
        LOCAL loc_lResultado
        loc_lResultado = .F.

        TRY
            THIS.FormParaBO()

            IF THIS.this_oBusinessObject.Salvar()
                MsgInfo("Carta de corre" + CHR(231) + CHR(227) + "o salva com sucesso!", "Sucesso")
                THIS.this_cModoAtual = "LISTA"
                THIS.HabilitarCampos(.F.)
                THIS.AlternarPagina(1)
                loc_lResultado = .T.
            ELSE
                MsgErro(THIS.this_oBusinessObject.this_cMensagemErro, ;
                    "Erro ao salvar carta")
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao confirmar")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * BtnCancelarClick - Cancelar edicao e voltar para lista
    *==========================================================================
    PROCEDURE BtnCancelarClick()
        THIS.this_cModoAtual = "LISTA"
        THIS.HabilitarCampos(.F.)
        *-- Re-habilitar Confirmar (pode ter sido desabilitado em modo VISUALIZAR)
        THIS.pgf_4c_Paginas.Page2.cnt_4c_Salva.cmd_4c_Confirmar.Enabled = .T.
        THIS.AlternarPagina(1)
    ENDPROC

    *==========================================================================
    * NotaLostFocus - Ao sair do campo NF num, move foco para Confirmar
    * Legado: Get_nota.LostFocus = Grupo_Salva.Salva.SetFocus
    *==========================================================================
    PROCEDURE NotaLostFocus(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oErro
        TRY
            THIS.pgf_4c_Paginas.Page2.cnt_4c_Salva.cmd_4c_Confirmar.SetFocus()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao mover foco")
        ENDTRY
    ENDPROC

    *==========================================================================
    * FormParaBO - Transfere valores do form para as propriedades do BO
    *==========================================================================
    PROTECTED PROCEDURE FormParaBO()
        LOCAL loc_lResultado, loc_oCab
        loc_lResultado = .F.

        TRY
            loc_oCab = THIS.pgf_4c_Paginas.Page2.cnt_4c_DadosCab

            THIS.this_oBusinessObject.this_cEmps       = THIS.this_cEmps

            *-- Campos display-only do cabecalho (readonly; valores carregados via BOParaForm)
            *-- txt_4c_Nota (nfis) pode ser modificado em modo PROCURAR, mas em INCLUIR/ALTERAR
            *-- a NF ja vem carregada; repassar o valor atual para garantir consistencia
            THIS.this_oBusinessObject.this_cNfis       = ALLTRIM(loc_oCab.txt_4c_Nota.Value)

            *-- Data de saida pode ser ajustada pelo usuario no fluxo de correcao
            IF !EMPTY(loc_oCab.txt_4c_DtSaidas.Value)
                THIS.this_oBusinessObject.this_tDtsaidas = DATETIME( ;
                    YEAR(loc_oCab.txt_4c_DtSaidas.Value), ;
                    MONTH(loc_oCab.txt_4c_DtSaidas.Value), ;
                    DAY(loc_oCab.txt_4c_DtSaidas.Value))
            ELSE
                THIS.this_oBusinessObject.this_tDtsaidas = {}
            ENDIF

            *-- CFOP: readonly no formulario; BO ja tem o valor correto do load
            THIS.this_oBusinessObject.this_cCfis       = ALLTRIM(loc_oCab.txt_4c_ClFiscal.Value)
            THIS.this_oBusinessObject.this_cDescricaos = ALLTRIM(loc_oCab.txt_4c_DClFiscal.Value)

            loc_lResultado = .T.

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro em FormParaBO")
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * BOParaForm - Transfere propriedades do BO para os campos do form
    *==========================================================================
    PROTECTED PROCEDURE BOParaForm()
        LOCAL loc_lResultado, loc_oCab, loc_oBO, loc_tEmis, loc_tSaida
        loc_lResultado = .F.

        TRY
            loc_oCab = THIS.pgf_4c_Paginas.Page2.cnt_4c_DadosCab
            loc_oBO  = THIS.this_oBusinessObject

            *-- Operacao
            loc_oCab.txt_4c_Dope.Value     = ALLTRIM(loc_oBO.this_cDopes)

            *-- Data Emissao (DateTime -> Date)
            loc_tEmis = loc_oBO.this_tEmis
            IF !EMPTY(loc_tEmis)
                loc_oCab.txt_4c_DtEmissao.Value = DATE(YEAR(loc_tEmis), MONTH(loc_tEmis), DAY(loc_tEmis))
            ELSE
                loc_oCab.txt_4c_DtEmissao.Value = {}
            ENDIF

            *-- Numero, Serie, NF num, Especie
            loc_oCab.txt_4c_Numes.Value    = TRANSFORM(loc_oBO.this_nNumes)
            loc_oCab.txt_4c_NfSerie.Value  = ALLTRIM(loc_oBO.this_cSeries)
            loc_oCab.txt_4c_Nota.Value     = ALLTRIM(loc_oBO.this_cNfis)
            loc_oCab.txt_4c_Especie.Value  = ALLTRIM(loc_oBO.this_cEspecienfs)

            *-- Data Saida (DateTime -> Date)
            loc_tSaida = loc_oBO.this_tDtsaidas
            IF !EMPTY(loc_tSaida)
                loc_oCab.txt_4c_DtSaidas.Value = DATE(YEAR(loc_tSaida), MONTH(loc_tSaida), DAY(loc_tSaida))
            ELSE
                loc_oCab.txt_4c_DtSaidas.Value = {}
            ENDIF

            *-- CFOP e descricao
            loc_oCab.txt_4c_ClFiscal.Value  = ALLTRIM(loc_oBO.this_cCfis)
            loc_oCab.txt_4c_DClFiscal.Value = ALLTRIM(loc_oBO.this_cDescricaos)

            *-- *** Aba Impostos ***
            LOCAL loc_oImp
            loc_oImp = THIS.pgf_4c_Paginas.Page2.pgf_4c_InnerPage.Page1
            loc_oImp.txt_4c_BaseIPI.Value    = loc_oBO.this_nBasecipis
            loc_oImp.txt_4c_ValorIPI.Value   = loc_oBO.this_nValipis
            loc_oImp.txt_4c_BaseICMS.Value   = loc_oBO.this_nBasecicms
            loc_oImp.txt_4c_PercICMS.Value   = loc_oBO.this_nIcms
            loc_oImp.txt_4c_ValorICMS.Value  = loc_oBO.this_nValicms
            loc_oImp.txt_4c_TotalProds.Value = loc_oBO.this_nTotProds
            loc_oImp.txt_4c_TotalNf.Value    = loc_oBO.this_nTotNotas
            loc_oImp.txt_4c_TFrete.Value     = loc_oBO.this_nVlFretes
            loc_oImp.txt_4c_TSeguros.Value   = loc_oBO.this_nVlSeguros
            loc_oImp.txt_4c_DespAces.Value   = loc_oBO.this_nDespAces
            loc_oImp.txt_4c_CodTransp.Value  = ALLTRIM(loc_oBO.this_cCodtrans)
            loc_oImp.txt_4c_TranspNome.Value = ALLTRIM(loc_oBO.this_cTranspNome)
            loc_oImp.txt_4c_TranspEnde.Value = ALLTRIM(loc_oBO.this_cTranspEnde)
            loc_oImp.txt_4c_TranspCida.Value = ALLTRIM(loc_oBO.this_cTranspCida)
            loc_oImp.txt_4c_TranspEsta.Value = ALLTRIM(loc_oBO.this_cTranspEsta)
            loc_oImp.txt_4c_Placa.Value      = ALLTRIM(loc_oBO.this_cPlacas)
            loc_oImp.txt_4c_UfPlaca.Value    = ALLTRIM(loc_oBO.this_cUfPlacas)
            DO CASE
            CASE loc_oBO.this_nFretes = 0
                loc_oImp.txt_4c_TipoFrete.Value = "0 - Emitente"
            CASE loc_oBO.this_nFretes = 1
                loc_oImp.txt_4c_TipoFrete.Value = "1 - Destinat" + CHR(225) + "rio"
            OTHERWISE
                loc_oImp.txt_4c_TipoFrete.Value = TRANSFORM(loc_oBO.this_nFretes)
            ENDCASE
            loc_oImp.txt_4c_Qtdes.Value      = loc_oBO.this_nQtdes
            loc_oImp.txt_4c_EspeVol.Value    = ALLTRIM(loc_oBO.this_cEspes)
            loc_oImp.txt_4c_Marcas.Value     = ALLTRIM(loc_oBO.this_cMarcas)
            loc_oImp.txt_4c_NumerosVol.Value = ALLTRIM(loc_oBO.this_cNumeros)
            loc_oImp.txt_4c_PesoLiq.Value    = loc_oBO.this_nPliqs
            loc_oImp.txt_4c_PesoBruto.Value  = loc_oBO.this_nPbrus

            *-- *** Aba Servicos ***
            LOCAL loc_oSer
            loc_oSer = THIS.pgf_4c_Paginas.Page2.pgf_4c_InnerPage.Page2
            loc_oSer.edt_4c_DescSer.Value  = ALLTRIM(loc_oBO.this_cDescsers)
            loc_oSer.txt_4c_Vtotsers.Value = loc_oBO.this_nVtotsers
            loc_oSer.txt_4c_Perciss.Value  = loc_oBO.this_nPerciss
            loc_oSer.txt_4c_Vtotiss.Value  = loc_oBO.this_nVtotiss

            loc_lResultado = .T.

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro em BOParaForm")
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * HabilitarCampos - Habilita ou desabilita controles para edicao
    *==========================================================================
    PROTECTED PROCEDURE HabilitarCampos(par_lHabilitar)
        LOCAL loc_oPg1, loc_lAtivo
        loc_oPg1  = THIS.pgf_4c_Paginas.Page1
        loc_lAtivo = !par_lHabilitar

        *-- Botoes de acao e encerrar ficam bloqueados durante edicao na Page2
        loc_oPg1.cnt_4c_Botoes.cmd_4c_InserirCarta.Enabled = loc_lAtivo
        loc_oPg1.cnt_4c_Botoes.cmd_4c_AlteraCarta.Enabled  = loc_lAtivo
        loc_oPg1.cnt_4c_Botoes.cmd_4c_ImpCarta.Enabled     = loc_lAtivo
        loc_oPg1.cnt_4c_Saida.cmd_4c_Encerrar.Enabled      = loc_lAtivo
    ENDPROC

    *==========================================================================
    * LimparCampos - Limpa todos os campos do cabecalho da NF
    *==========================================================================
    PROTECTED PROCEDURE LimparCampos()
        LOCAL loc_oCab
        TRY
            loc_oCab = THIS.pgf_4c_Paginas.Page2.cnt_4c_DadosCab
            loc_oCab.txt_4c_Dope.Value      = ""
            loc_oCab.txt_4c_DtEmissao.Value = {}
            loc_oCab.txt_4c_Numes.Value     = ""
            loc_oCab.txt_4c_NfSerie.Value   = ""
            loc_oCab.txt_4c_Nota.Value      = ""
            loc_oCab.txt_4c_Especie.Value   = ""
            loc_oCab.txt_4c_DtSaidas.Value  = {}
            loc_oCab.txt_4c_ClFiscal.Value  = ""
            loc_oCab.txt_4c_DClFiscal.Value = ""

            *-- Aba Impostos
            LOCAL loc_oImpL
            loc_oImpL = THIS.pgf_4c_Paginas.Page2.pgf_4c_InnerPage.Page1
            loc_oImpL.txt_4c_BaseIPI.Value    = 0
            loc_oImpL.txt_4c_ValorIPI.Value   = 0
            loc_oImpL.txt_4c_BaseICMS.Value   = 0
            loc_oImpL.txt_4c_PercICMS.Value   = 0
            loc_oImpL.txt_4c_ValorICMS.Value  = 0
            loc_oImpL.txt_4c_TotalProds.Value = 0
            loc_oImpL.txt_4c_TotalNf.Value    = 0
            loc_oImpL.txt_4c_TFrete.Value     = 0
            loc_oImpL.txt_4c_TSeguros.Value   = 0
            loc_oImpL.txt_4c_DespAces.Value   = 0
            loc_oImpL.txt_4c_CodTransp.Value  = ""
            loc_oImpL.txt_4c_TranspNome.Value = ""
            loc_oImpL.txt_4c_TranspEnde.Value = ""
            loc_oImpL.txt_4c_TranspCida.Value = ""
            loc_oImpL.txt_4c_TranspEsta.Value = ""
            loc_oImpL.txt_4c_Placa.Value      = ""
            loc_oImpL.txt_4c_UfPlaca.Value    = ""
            loc_oImpL.txt_4c_TipoFrete.Value  = ""
            loc_oImpL.txt_4c_Qtdes.Value      = 0
            loc_oImpL.txt_4c_EspeVol.Value    = ""
            loc_oImpL.txt_4c_Marcas.Value     = ""
            loc_oImpL.txt_4c_NumerosVol.Value = ""
            loc_oImpL.txt_4c_PesoLiq.Value    = 0
            loc_oImpL.txt_4c_PesoBruto.Value  = 0

            *-- Aba Servicos
            LOCAL loc_oSerL
            loc_oSerL = THIS.pgf_4c_Paginas.Page2.pgf_4c_InnerPage.Page2
            loc_oSerL.edt_4c_DescSer.Value  = ""
            loc_oSerL.txt_4c_Vtotsers.Value = 0
            loc_oSerL.txt_4c_Perciss.Value  = 0
            loc_oSerL.txt_4c_Vtotiss.Value  = 0

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao limpar campos")
        ENDTRY
    ENDPROC

    *==========================================================================
    * TornarControlesVisiveis - Torna todos os controles visiveis recursivamente
    *==========================================================================
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

    *==========================================================================
    * FormatarGridLista - Formata visual do grid da lista
    *==========================================================================
    PROTECTED PROCEDURE FormatarGridLista(par_oGrid)
        WITH par_oGrid
            .FontName = "Verdana"
            .FontSize = 8
            .ForeColor         = RGB(90, 90, 90)
            .BackColor         = RGB(255, 255, 255)
            .GridLineColor     = RGB(238, 238, 238)
            .HighlightBackColor = RGB(255, 255, 255)
            .HighlightForeColor = RGB(15, 41, 104)
            .HighlightStyle    = 2
            .DeleteMark        = .F.
            .RecordMark        = .F.
            .RowHeight         = 16
            .ScrollBars        = 2
            .GridLines         = 3
        ENDWITH
    ENDPROC

    *==========================================================================
    * ConfigurarFiltros - Popula cnt_4c_Filtros com controles de filtro
    * Legado: GetEmp / Get_Serie / DtIni / DtFim / optFiltro
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarFiltros(par_oPagina)
        LOCAL loc_oCnt
        loc_oCnt = par_oPagina.cnt_4c_Filtros

        *-- Label: Empresa (Label2: top=19, left=16, width=57)
        loc_oCnt.AddObject("lbl_4c_Empresa", "Label")
        WITH loc_oCnt.lbl_4c_Empresa
            .Caption   = "Empresa :"
            .Top       = 14
            .Left      = 16
            .Width     = 57
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(53, 53, 53)
            .Visible   = .T.
        ENDWITH

        *-- TextBox: Empresa (GetEmp: top=16, left=84, width=31, height=23)
        loc_oCnt.AddObject("txt_4c_Emp", "TextBox")
        WITH loc_oCnt.txt_4c_Emp
            .Top       = 12
            .Left      = 84
            .Width     = 31
            .Height    = 23
            .MaxLength = 3
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Value     = ALLTRIM(THIS.this_cEmps)
            .Visible   = .T.
        ENDWITH

        *-- Label: No. Serie (Say1: top=19, left=138)
        loc_oCnt.AddObject("lbl_4c_Serie", "Label")
        WITH loc_oCnt.lbl_4c_Serie
            .Caption   = "No. S" + CHR(233) + "rie : "
            .Top       = 14
            .Left      = 138
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(53, 53, 53)
            .AutoSize  = .T.
            .Visible   = .T.
        ENDWITH

        *-- TextBox: Serie (Get_Serie: top=16, left=208, width=36, height=23)
        loc_oCnt.AddObject("txt_4c_Serie", "TextBox")
        WITH loc_oCnt.txt_4c_Serie
            .Top       = 12
            .Left      = 208
            .Width     = 36
            .Height    = 23
            .MaxLength = 8
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Value     = ""
            .Visible   = .T.
        ENDWITH

        *-- Label: Periodo (Say2: top=19, left=276)
        loc_oCnt.AddObject("lbl_4c_Periodo", "Label")
        WITH loc_oCnt.lbl_4c_Periodo
            .Caption   = "Per" + CHR(237) + "odo : "
            .Top       = 14
            .Left      = 276
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(53, 53, 53)
            .AutoSize  = .T.
            .Visible   = .T.
        ENDWITH

        *-- TextBox: Data Inicial (DtIni: top=16, left=338, width=80, height=23)
        loc_oCnt.AddObject("txt_4c_DtIni", "TextBox")
        WITH loc_oCnt.txt_4c_DtIni
            .Top       = 12
            .Left      = 338
            .Width     = 80
            .Height    = 23
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Value     = {}
            .Visible   = .T.
        ENDWITH

        *-- Label: separador "a" entre datas (Say3: top=19, left=424, caption="?"/CHR(224))
        loc_oCnt.AddObject("lbl_4c_Sep", "Label")
        WITH loc_oCnt.lbl_4c_Sep
            .Caption   = CHR(224)
            .Top       = 14
            .Left      = 424
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(53, 53, 53)
            .AutoSize  = .T.
            .Visible   = .T.
        ENDWITH

        *-- TextBox: Data Final (DtFim: top=16, left=438, width=80, height=23)
        loc_oCnt.AddObject("txt_4c_DtFim", "TextBox")
        WITH loc_oCnt.txt_4c_DtFim
            .Top       = 12
            .Left      = 438
            .Width     = 80
            .Height    = 23
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Value     = {}
            .Visible   = .T.
        ENDWITH

        *-- OptionGroup: Filtro (optFiltro: top=14, left=538, w=183, h=25, buttonCount=3)
        *-- Value=1=Entrada, Value=2=Saida, Value=3=Ambas (default)
        loc_oCnt.AddObject("opt_4c_Filtro", "OptionGroup")
        WITH loc_oCnt.opt_4c_Filtro
            .ButtonCount = 3
            .Top         = 10
            .Left        = 538
            .Width       = 206
            .Height      = 26
            .BackStyle   = 0
            .BorderStyle = 0
            .Visible     = .T.
        ENDWITH
        WITH loc_oCnt.opt_4c_Filtro.Buttons(1)
            .Caption   = "Entrada"
            .BackStyle = 0
            .Left      = 5
            .Top       = 4
            .AutoSize  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(53, 53, 53)
            .Themes    = .F.
        ENDWITH
        WITH loc_oCnt.opt_4c_Filtro.Buttons(2)
            .Caption   = "Sa" + CHR(237) + "da"
            .BackStyle = 0
            .Left      = 74
            .Top       = 4
            .AutoSize  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(53, 53, 53)
            .Themes    = .F.
        ENDWITH
        WITH loc_oCnt.opt_4c_Filtro.Buttons(3)
            .Caption   = "Ambas"
            .BackStyle = 0
            .Left      = 140
            .Top       = 4
            .AutoSize  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(53, 53, 53)
            .Themes    = .F.
        ENDWITH
        *-- Default: Ambas (pOpE=[E], pOpS=[S] = comportamento padrao do legado)
        loc_oCnt.opt_4c_Filtro.Value = 3
    ENDPROC

    *==========================================================================
    * ValidarEmpresa - LostFocus de txt_4c_Emp: valida empresa em SigCdEmp
    * Legado: GetEmp.Valid usa fAcessoEmpresa() (nao portada -> substituida)
    *==========================================================================
    PROCEDURE ValidarEmpresa(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oCnt, loc_cEmps, loc_cSQL, loc_nResult
        loc_oCnt  = THIS.pgf_4c_Paginas.Page1.cnt_4c_Filtros
        loc_cEmps = ALLTRIM(loc_oCnt.txt_4c_Emp.Value)

        IF EMPTY(loc_cEmps)
            MsgAviso("Preenchimento Obrigat" + CHR(243) + "rio!!!", "Empresa")
            loc_oCnt.txt_4c_Emp.SetFocus()
            RETURN
        ENDIF

        TRY
            loc_cSQL    = "SELECT CEmps, Razas FROM SigCdEmp WHERE CEmps = " + ;
                EscaparSQL(loc_cEmps)
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaEmp")

            IF loc_nResult > 0 AND RECCOUNT("cursor_4c_BuscaEmp") > 0
                THIS.this_cEmps = loc_cEmps
            ELSE
                MsgAviso("Empresa n" + CHR(227) + "o encontrada: " + loc_cEmps, ;
                    "Empresa")
                loc_oCnt.txt_4c_Emp.Value = THIS.this_cEmps
            ENDIF

            IF USED("cursor_4c_BuscaEmp")
                USE IN cursor_4c_BuscaEmp
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao validar empresa")
        ENDTRY
    ENDPROC

    *==========================================================================
    * ValidarSerie - LostFocus de txt_4c_Serie: valida em SigCdSer
    * Legado: Get_Serie.Valid usa fwBuscaInt sobre cursor crSigCdSer
    *==========================================================================
    PROCEDURE ValidarSerie(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oCnt, loc_cSerie, loc_cSQL, loc_nResult, loc_lEncontrou
        loc_oCnt      = THIS.pgf_4c_Paginas.Page1.cnt_4c_Filtros
        loc_cSerie    = ALLTRIM(loc_oCnt.txt_4c_Serie.Value)
        loc_lEncontrou = .F.

        IF EMPTY(loc_cSerie)
            THIS.this_cSeriesFiltro = ""
            RETURN
        ENDIF

        TRY
            loc_cSQL    = "SELECT DISTINCT Cods, Descs FROM SigCdSer ORDER BY Cods"
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaSer")

            IF loc_nResult > 0 AND RECCOUNT("cursor_4c_BuscaSer") > 0
                SELECT cursor_4c_BuscaSer
                GO TOP
                LOCATE FOR UPPER(ALLTRIM(cursor_4c_BuscaSer.Cods)) == UPPER(loc_cSerie)

                IF FOUND()
                    THIS.this_cSeriesFiltro            = ALLTRIM(cursor_4c_BuscaSer.Cods)
                    loc_oCnt.txt_4c_Serie.Value        = THIS.this_cSeriesFiltro
                    loc_lEncontrou                     = .T.
                ELSE
                    *-- Nao encontrou exato: abrir picker
                    LOCAL loc_oBusca
                    loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
                    IF VARTYPE(loc_oBusca) = "O"
                        loc_oBusca.this_cCursorDestino = "cursor_4c_BuscaSer"
                        loc_oBusca.this_cTitulo        = "S" + CHR(233) + "ries"
                        loc_oBusca.this_cCampoChave    = "Cods"
                        loc_oBusca.this_cValorInicial  = loc_cSerie
                        loc_oBusca.mAddColuna("Cods",  "XXXXX",              ;
                            "S" + CHR(233) + "rie")
                        loc_oBusca.mAddColuna("Descs", "XXXXXXXXXXXXXXXXXXXX", ;
                            "Descri" + CHR(231) + CHR(227) + "o")
                        loc_oBusca.Show()

                        IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaSer")
                            SELECT cursor_4c_BuscaSer
                            THIS.this_cSeriesFiltro     = ALLTRIM(cursor_4c_BuscaSer.Cods)
                            loc_oCnt.txt_4c_Serie.Value = THIS.this_cSeriesFiltro
                            loc_lEncontrou              = .T.
                        ELSE
                            loc_oCnt.txt_4c_Serie.Value = ""
                            THIS.this_cSeriesFiltro     = ""
                        ENDIF
                        loc_oBusca.Release()
                    ENDIF
                ENDIF
            ENDIF

            IF USED("cursor_4c_BuscaSer")
                USE IN cursor_4c_BuscaSer
            ENDIF

            *-- Se serie valida e datas preenchidas, recarregar lista
            IF loc_lEncontrou AND ;
               !EMPTY(THIS.this_dEmisDeFiltro) AND ;
               !EMPTY(THIS.this_dEmisAteFiltro)
                THIS.CarregarLista()
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao validar s" + CHR(233) + "rie")
        ENDTRY
    ENDPROC

    *==========================================================================
    * ValidarDtIni - LostFocus de txt_4c_DtIni: valida consistencia com DtFim
    * Legado: DtIni.Valid - se DtFim preenchida e DtIni > DtFim, limpar
    *==========================================================================
    PROCEDURE ValidarDtIni(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oCnt, loc_dDtIni, loc_dDtFim
        loc_oCnt   = THIS.pgf_4c_Paginas.Page1.cnt_4c_Filtros
        loc_dDtIni = loc_oCnt.txt_4c_DtIni.Value
        loc_dDtFim = loc_oCnt.txt_4c_DtFim.Value

        IF !EMPTY(loc_dDtFim) AND !EMPTY(loc_dDtIni) AND loc_dDtIni > loc_dDtFim
            MsgAviso("Data Inv" + CHR(225) + "lida !!", "")
            loc_oCnt.txt_4c_DtIni.Value = {}
            THIS.this_dEmisDeFiltro     = {}
        ELSE
            THIS.this_dEmisDeFiltro = loc_dDtIni
        ENDIF
    ENDPROC

    *==========================================================================
    * ValidarDtFim - LostFocus de txt_4c_DtFim: valida e recarrega lista
    * Legado: DtFim.Valid - valida, se serie+datas OK chama Requery
    *==========================================================================
    PROCEDURE ValidarDtFim(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oCnt, loc_dDtIni, loc_dDtFim
        loc_oCnt   = THIS.pgf_4c_Paginas.Page1.cnt_4c_Filtros
        loc_dDtIni = loc_oCnt.txt_4c_DtIni.Value
        loc_dDtFim = loc_oCnt.txt_4c_DtFim.Value

        IF !EMPTY(loc_dDtFim) AND !EMPTY(loc_dDtIni) AND loc_dDtFim < loc_dDtIni
            MsgAviso("Data Inv" + CHR(225) + "lida !!", "")
            loc_oCnt.txt_4c_DtFim.Value = {}
            THIS.this_dEmisAteFiltro    = {}
            RETURN
        ENDIF

        THIS.this_dEmisAteFiltro = loc_dDtFim

        *-- Se filtros completos, recarregar lista
        IF !EMPTY(THIS.this_cSeriesFiltro) AND ;
           !EMPTY(THIS.this_dEmisDeFiltro) AND ;
           !EMPTY(THIS.this_dEmisAteFiltro)
            THIS.CarregarLista()
        ENDIF
    ENDPROC

    *==========================================================================
    * DtFimWhenCheck - When de txt_4c_DtFim: so permite foco se DtIni preenchida
    * Legado: DtFim.When = Return(!Empty(DtIni.Value))
    *==========================================================================
    FUNCTION DtFimWhenCheck()
        LOCAL loc_dDtIni
        loc_dDtIni = {}
        TRY
            loc_dDtIni = THIS.pgf_4c_Paginas.Page1.cnt_4c_Filtros.txt_4c_DtIni.Value
        CATCH
            loc_lResultado = .T.
        ENDTRY
        RETURN !EMPTY(loc_dDtIni)
    ENDFUNC

    *==========================================================================
    * FiltroChanged - InteractiveChange de opt_4c_Filtro: atualiza e recarrega
    * Legado: optFiltro.InteractiveChange - atualiza pOpE/pOpS e chama Requery
    * Value=1=Entradas, Value=2=Saidas, Value=3=Ambas
    *==========================================================================
    PROCEDURE FiltroChanged()
        LOCAL loc_nOpcao
        TRY
            loc_nOpcao = THIS.pgf_4c_Paginas.Page1.cnt_4c_Filtros.opt_4c_Filtro.Value

            DO CASE
            CASE loc_nOpcao = 1
                THIS.this_cOpeFiltro = "E"
            CASE loc_nOpcao = 2
                THIS.this_cOpeFiltro = "S"
            OTHERWISE
                THIS.this_cOpeFiltro = "A"
            ENDCASE

            *-- Recarregar se filtros completos
            IF !EMPTY(THIS.this_cSeriesFiltro) AND ;
               !EMPTY(THIS.this_dEmisDeFiltro) AND ;
               !EMPTY(THIS.this_dEmisAteFiltro)
                THIS.CarregarLista()
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao mudar filtro")
        ENDTRY
    ENDPROC

    *==========================================================================
    * ConfigurarAbaImpostos - Cria controles na aba Impostos do PageFrame interno
    * Legado: SIGCDCNF.Pagina.Dados.Pagina.Impostos
    * Coordenadas originais do SCX (sem compensacao - inner PageFrame usa Tabs=.T.)
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarAbaImpostos()
        LOCAL loc_oAba
        loc_oAba = THIS.pgf_4c_Paginas.Page2.pgf_4c_InnerPage.Page1

        *-- Say17: titulo da secao (top=2, left=5)
        loc_oAba.AddObject("lbl_4c_SecImpostos", "Label")
        WITH loc_oAba.lbl_4c_SecImpostos
            .Caption   = " Impostos "
            .Top       = 2
            .Left      = 5
            .AutoSize  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(53, 53, 53)
        ENDWITH

        *-- Shape1: divisor horizontal (top=20, left=5, width=494, height=2)
        loc_oAba.AddObject("shp_4c_Div1", "Shape")
        WITH loc_oAba.shp_4c_Div1
            .Top         = 20
            .Left        = 5
            .Width       = 494
            .Height      = 2
            .BackColor   = RGB(180, 180, 180)
            .BorderColor = RGB(180, 180, 180)
        ENDWITH

        *-- Labels cabecalho IPI/ICMS (top=26)
        loc_oAba.AddObject("lbl_4c_SayBaseIPI", "Label")
        WITH loc_oAba.lbl_4c_SayBaseIPI
            .Caption   = "Base C" + CHR(225) + "lculo IPI"
            .Top       = 26
            .Left      = 5
            .AutoSize  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(53, 53, 53)
        ENDWITH

        loc_oAba.AddObject("lbl_4c_SayValorIPI", "Label")
        WITH loc_oAba.lbl_4c_SayValorIPI
            .Caption   = "Valor IPI"
            .Top       = 26
            .Left      = 116
            .AutoSize  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(53, 53, 53)
        ENDWITH

        loc_oAba.AddObject("lbl_4c_SayBaseICMS", "Label")
        WITH loc_oAba.lbl_4c_SayBaseICMS
            .Caption   = "Base C" + CHR(225) + "lculo ICMS"
            .Top       = 26
            .Left      = 227
            .AutoSize  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(53, 53, 53)
        ENDWITH

        loc_oAba.AddObject("lbl_4c_SayPercICMS", "Label")
        WITH loc_oAba.lbl_4c_SayPercICMS
            .Caption   = "% ICMS "
            .Top       = 26
            .Left      = 340
            .AutoSize  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(53, 53, 53)
        ENDWITH

        loc_oAba.AddObject("lbl_4c_SayValorICMS", "Label")
        WITH loc_oAba.lbl_4c_SayValorICMS
            .Caption   = "Valor ICMS"
            .Top       = 26
            .Left      = 394
            .AutoSize  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(53, 53, 53)
        ENDWITH

        *-- Campos IPI/ICMS (top=43)
        loc_oAba.AddObject("txt_4c_BaseIPI", "TextBox")
        WITH loc_oAba.txt_4c_BaseIPI
            .Top      = 43
            .Left     = 5
            .Width    = 107
            .Height   = 21
            .FontName = "Tahoma"
            .FontSize = 8
            .ReadOnly = .T.
            .Value    = 0
        ENDWITH

        loc_oAba.AddObject("txt_4c_ValorIPI", "TextBox")
        WITH loc_oAba.txt_4c_ValorIPI
            .Top      = 43
            .Left     = 116
            .Width    = 107
            .Height   = 21
            .FontName = "Tahoma"
            .FontSize = 8
            .ReadOnly = .T.
            .Value    = 0
        ENDWITH

        loc_oAba.AddObject("txt_4c_BaseICMS", "TextBox")
        WITH loc_oAba.txt_4c_BaseICMS
            .Top      = 43
            .Left     = 227
            .Width    = 107
            .Height   = 21
            .FontName = "Tahoma"
            .FontSize = 8
            .ReadOnly = .T.
            .Value    = 0
        ENDWITH

        loc_oAba.AddObject("txt_4c_PercICMS", "TextBox")
        WITH loc_oAba.txt_4c_PercICMS
            .Top      = 43
            .Left     = 338
            .Width    = 52
            .Height   = 21
            .FontName = "Tahoma"
            .FontSize = 8
            .ReadOnly = .T.
            .Value    = 0
        ENDWITH

        loc_oAba.AddObject("txt_4c_ValorICMS", "TextBox")
        WITH loc_oAba.txt_4c_ValorICMS
            .Top      = 43
            .Left     = 394
            .Width    = 107
            .Height   = 21
            .FontName = "Tahoma"
            .FontSize = 8
            .ReadOnly = .T.
            .Value    = 0
        ENDWITH

        *-- Labels Totais (top=67)
        loc_oAba.AddObject("lbl_4c_SayTotProds", "Label")
        WITH loc_oAba.lbl_4c_SayTotProds
            .Caption   = "Total Produtos"
            .Top       = 67
            .Left      = 5
            .AutoSize  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(53, 53, 53)
        ENDWITH

        loc_oAba.AddObject("lbl_4c_SayTotalNf", "Label")
        WITH loc_oAba.lbl_4c_SayTotalNf
            .Caption   = "Total NFiscal"
            .Top       = 67
            .Left      = 116
            .AutoSize  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(53, 53, 53)
        ENDWITH

        *-- Campos Totais (top=83)
        loc_oAba.AddObject("txt_4c_TotalProds", "TextBox")
        WITH loc_oAba.txt_4c_TotalProds
            .Top      = 83
            .Left     = 5
            .Width    = 107
            .Height   = 21
            .FontName = "Tahoma"
            .FontSize = 8
            .ReadOnly = .T.
            .Value    = 0
        ENDWITH

        loc_oAba.AddObject("txt_4c_TotalNf", "TextBox")
        WITH loc_oAba.txt_4c_TotalNf
            .Top      = 83
            .Left     = 116
            .Width    = 106
            .Height   = 21
            .FontName = "Tahoma"
            .FontSize = 8
            .ReadOnly = .T.
            .Value    = 0
        ENDWITH

        *-- Botao Dados (abre SigMvExp): top=17, left=516
        loc_oAba.AddObject("cmd_4c_Dados", "CommandButton")
        WITH loc_oAba.cmd_4c_Dados
            .Caption         = "Dados"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_procurar_26.jpg"
            .PicturePosition = 13
            .Top             = 17
            .Left            = 516
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
        ENDWITH

        *-- Say18: "Outros Valores" (top=115, left=5)
        loc_oAba.AddObject("lbl_4c_SayOutrosVal", "Label")
        WITH loc_oAba.lbl_4c_SayOutrosVal
            .Caption   = " Outros Valores "
            .Top       = 115
            .Left      = 5
            .AutoSize  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(53, 53, 53)
        ENDWITH

        *-- Shape3: divisor "Outros Valores" (top=132, left=5, width=494, height=2)
        loc_oAba.AddObject("shp_4c_Div3", "Shape")
        WITH loc_oAba.shp_4c_Div3
            .Top         = 132
            .Left        = 5
            .Width       = 494
            .Height      = 2
            .BackColor   = RGB(180, 180, 180)
            .BorderColor = RGB(180, 180, 180)
        ENDWITH

        *-- Labels Outros Valores (top=137)
        loc_oAba.AddObject("lbl_4c_SayTFrete", "Label")
        WITH loc_oAba.lbl_4c_SayTFrete
            .Caption   = "Valor do Frete"
            .Top       = 137
            .Left      = 5
            .AutoSize  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(53, 53, 53)
        ENDWITH

        loc_oAba.AddObject("lbl_4c_SayTSeguros", "Label")
        WITH loc_oAba.lbl_4c_SayTSeguros
            .Caption   = "Valor do Seguro"
            .Top       = 137
            .Left      = 119
            .AutoSize  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(53, 53, 53)
        ENDWITH

        loc_oAba.AddObject("lbl_4c_SayDespAces", "Label")
        WITH loc_oAba.lbl_4c_SayDespAces
            .Caption   = "Despesas Acess" + CHR(243) + "rias"
            .Top       = 137
            .Left      = 233
            .AutoSize  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(53, 53, 53)
        ENDWITH

        *-- Campos Outros Valores (top=153)
        loc_oAba.AddObject("txt_4c_TFrete", "TextBox")
        WITH loc_oAba.txt_4c_TFrete
            .Top      = 153
            .Left     = 5
            .Width    = 105
            .Height   = 21
            .FontName = "Tahoma"
            .FontSize = 8
            .ReadOnly = .T.
            .Value    = 0
        ENDWITH

        loc_oAba.AddObject("txt_4c_TSeguros", "TextBox")
        WITH loc_oAba.txt_4c_TSeguros
            .Top      = 153
            .Left     = 119
            .Width    = 105
            .Height   = 21
            .FontName = "Tahoma"
            .FontSize = 8
            .ReadOnly = .T.
            .Value    = 0
        ENDWITH

        loc_oAba.AddObject("txt_4c_DespAces", "TextBox")
        WITH loc_oAba.txt_4c_DespAces
            .Top      = 153
            .Left     = 233
            .Width    = 105
            .Height   = 21
            .FontName = "Tahoma"
            .FontSize = 8
            .ReadOnly = .T.
            .Value    = 0
        ENDWITH

        *-- Say26: "Transportador" (top=185, left=5)
        loc_oAba.AddObject("lbl_4c_SayTransp", "Label")
        WITH loc_oAba.lbl_4c_SayTransp
            .Caption   = " Transportador "
            .Top       = 185
            .Left      = 5
            .AutoSize  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(53, 53, 53)
        ENDWITH

        *-- Shape4: divisor "Transportador" (top=203, left=5, width=494, height=2)
        loc_oAba.AddObject("shp_4c_Div4", "Shape")
        WITH loc_oAba.shp_4c_Div4
            .Top         = 203
            .Left        = 5
            .Width       = 494
            .Height      = 2
            .BackColor   = RGB(180, 180, 180)
            .BorderColor = RGB(180, 180, 180)
        ENDWITH

        *-- Say20: label "Transportadora" (top=209, left=5)
        loc_oAba.AddObject("lbl_4c_SayTranspNome", "Label")
        WITH loc_oAba.lbl_4c_SayTranspNome
            .Caption   = "Transportadora"
            .Top       = 209
            .Left      = 5
            .AutoSize  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(53, 53, 53)
        ENDWITH

        *-- Codigo transportadora (top=225, left=5, width=82)
        loc_oAba.AddObject("txt_4c_CodTransp", "TextBox")
        WITH loc_oAba.txt_4c_CodTransp
            .Top       = 225
            .Left      = 5
            .Width     = 82
            .Height    = 23
            .MaxLength = 10
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ReadOnly  = .T.
            .Value     = ""
        ENDWITH

        *-- Nome transportadora (top=225, left=90, width=377)
        loc_oAba.AddObject("txt_4c_TranspNome", "TextBox")
        WITH loc_oAba.txt_4c_TranspNome
            .Top       = 225
            .Left      = 90
            .Width     = 377
            .Height    = 23
            .MaxLength = 40
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ReadOnly  = .T.
            .Value     = ""
        ENDWITH

        *-- Say21: "Endereco" (top=251, left=5)
        loc_oAba.AddObject("lbl_4c_SayTranspEnde", "Label")
        WITH loc_oAba.lbl_4c_SayTranspEnde
            .Caption   = "Endere" + CHR(231) + "o"
            .Top       = 251
            .Left      = 5
            .AutoSize  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(53, 53, 53)
        ENDWITH

        *-- Endereco transportadora (top=267, left=5, width=462)
        loc_oAba.AddObject("txt_4c_TranspEnde", "TextBox")
        WITH loc_oAba.txt_4c_TranspEnde
            .Top       = 267
            .Left      = 5
            .Width     = 462
            .Height    = 23
            .MaxLength = 60
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ReadOnly  = .T.
            .Value     = ""
        ENDWITH

        *-- Labels linha de Cidade/UF/Placa/Frete (top=293)
        loc_oAba.AddObject("lbl_4c_SayCidade", "Label")
        WITH loc_oAba.lbl_4c_SayCidade
            .Caption   = "Cidade"
            .Top       = 293
            .Left      = 5
            .AutoSize  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(53, 53, 53)
        ENDWITH

        loc_oAba.AddObject("lbl_4c_SayEstado", "Label")
        WITH loc_oAba.lbl_4c_SayEstado
            .Caption   = "UF"
            .Top       = 293
            .Left      = 184
            .AutoSize  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(53, 53, 53)
        ENDWITH

        loc_oAba.AddObject("lbl_4c_SayPlaca", "Label")
        WITH loc_oAba.lbl_4c_SayPlaca
            .Caption   = "Placa"
            .Top       = 293
            .Left      = 221
            .AutoSize  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(53, 53, 53)
        ENDWITH

        loc_oAba.AddObject("lbl_4c_SayUfPlaca", "Label")
        WITH loc_oAba.lbl_4c_SayUfPlaca
            .Caption   = "UF"
            .Top       = 293
            .Left      = 303
            .AutoSize  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(53, 53, 53)
        ENDWITH

        loc_oAba.AddObject("lbl_4c_SayTipoFrete", "Label")
        WITH loc_oAba.lbl_4c_SayTipoFrete
            .Caption   = "Frete"
            .Top       = 293
            .Left      = 337
            .AutoSize  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(53, 53, 53)
        ENDWITH

        *-- Campos Cidade/UF/Placa/Frete (top=309)
        loc_oAba.AddObject("txt_4c_TranspCida", "TextBox")
        WITH loc_oAba.txt_4c_TranspCida
            .Top       = 309
            .Left      = 5
            .Width     = 175
            .Height    = 23
            .MaxLength = 40
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ReadOnly  = .T.
            .Value     = ""
        ENDWITH

        loc_oAba.AddObject("txt_4c_TranspEsta", "TextBox")
        WITH loc_oAba.txt_4c_TranspEsta
            .Top       = 309
            .Left      = 183
            .Width     = 26
            .Height    = 23
            .MaxLength = 2
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ReadOnly  = .T.
            .Value     = ""
        ENDWITH

        loc_oAba.AddObject("txt_4c_Placa", "TextBox")
        WITH loc_oAba.txt_4c_Placa
            .Top       = 309
            .Left      = 219
            .Width     = 80
            .Height    = 23
            .MaxLength = 8
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ReadOnly  = .T.
            .Value     = ""
        ENDWITH

        loc_oAba.AddObject("txt_4c_UfPlaca", "TextBox")
        WITH loc_oAba.txt_4c_UfPlaca
            .Top       = 309
            .Left      = 302
            .Width     = 26
            .Height    = 23
            .MaxLength = 2
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ReadOnly  = .T.
            .Value     = ""
        ENDWITH

        loc_oAba.AddObject("txt_4c_TipoFrete", "TextBox")
        WITH loc_oAba.txt_4c_TipoFrete
            .Top       = 309
            .Left      = 336
            .Width     = 132
            .Height    = 23
            .MaxLength = 20
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ReadOnly  = .T.
            .Value     = ""
        ENDWITH

        *-- Say16: "Volumes Transportados" (top=342, left=5)
        loc_oAba.AddObject("lbl_4c_SayVolumes", "Label")
        WITH loc_oAba.lbl_4c_SayVolumes
            .Caption   = " Volumes Transportados "
            .Top       = 342
            .Left      = 5
            .AutoSize  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(53, 53, 53)
        ENDWITH

        *-- Shape2: divisor "Volumes" (top=360, left=5, width=494, height=2)
        loc_oAba.AddObject("shp_4c_Div2", "Shape")
        WITH loc_oAba.shp_4c_Div2
            .Top         = 360
            .Left        = 5
            .Width       = 494
            .Height      = 2
            .BackColor   = RGB(180, 180, 180)
            .BorderColor = RGB(180, 180, 180)
        ENDWITH

        *-- Labels Volumes (top=364)
        loc_oAba.AddObject("lbl_4c_SayQtdes", "Label")
        WITH loc_oAba.lbl_4c_SayQtdes
            .Caption   = "Qtde."
            .Top       = 364
            .Left      = 5
            .AutoSize  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(53, 53, 53)
        ENDWITH

        loc_oAba.AddObject("lbl_4c_SayEspe", "Label")
        WITH loc_oAba.lbl_4c_SayEspe
            .Caption   = "Esp" + CHR(233) + "cie"
            .Top       = 364
            .Left      = 59
            .AutoSize  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(53, 53, 53)
        ENDWITH

        loc_oAba.AddObject("lbl_4c_SayMarcas", "Label")
        WITH loc_oAba.lbl_4c_SayMarcas
            .Caption   = "Marca"
            .Top       = 364
            .Left      = 149
            .AutoSize  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(53, 53, 53)
        ENDWITH

        loc_oAba.AddObject("lbl_4c_SayNumeros", "Label")
        WITH loc_oAba.lbl_4c_SayNumeros
            .Caption   = "N" + CHR(250) + "mero"
            .Top       = 364
            .Left      = 239
            .AutoSize  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(53, 53, 53)
        ENDWITH

        loc_oAba.AddObject("lbl_4c_SayPesoLiq", "Label")
        WITH loc_oAba.lbl_4c_SayPesoLiq
            .Caption   = "Peso L" + CHR(237) + "quido"
            .Top       = 364
            .Left      = 329
            .AutoSize  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(53, 53, 53)
        ENDWITH

        loc_oAba.AddObject("lbl_4c_SayPesoBruto", "Label")
        WITH loc_oAba.lbl_4c_SayPesoBruto
            .Caption   = "Peso Bruto"
            .Top       = 364
            .Left      = 405
            .AutoSize  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(53, 53, 53)
        ENDWITH

        *-- Campos Volumes (top=380)
        loc_oAba.AddObject("txt_4c_Qtdes", "TextBox")
        WITH loc_oAba.txt_4c_Qtdes
            .Top      = 380
            .Left     = 5
            .Width    = 51
            .Height   = 21
            .FontName = "Tahoma"
            .FontSize = 8
            .ReadOnly = .T.
            .Value    = 0
        ENDWITH

        loc_oAba.AddObject("txt_4c_EspeVol", "TextBox")
        WITH loc_oAba.txt_4c_EspeVol
            .Top       = 380
            .Left      = 59
            .Width     = 87
            .Height    = 21
            .MaxLength = 20
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ReadOnly  = .T.
            .Value     = ""
        ENDWITH

        loc_oAba.AddObject("txt_4c_Marcas", "TextBox")
        WITH loc_oAba.txt_4c_Marcas
            .Top       = 380
            .Left      = 149
            .Width     = 87
            .Height    = 21
            .MaxLength = 20
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ReadOnly  = .T.
            .Value     = ""
        ENDWITH

        loc_oAba.AddObject("txt_4c_NumerosVol", "TextBox")
        WITH loc_oAba.txt_4c_NumerosVol
            .Top       = 380
            .Left      = 239
            .Width     = 87
            .Height    = 21
            .MaxLength = 20
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ReadOnly  = .T.
            .Value     = ""
        ENDWITH

        loc_oAba.AddObject("txt_4c_PesoLiq", "TextBox")
        WITH loc_oAba.txt_4c_PesoLiq
            .Top      = 380
            .Left     = 329
            .Width    = 73
            .Height   = 21
            .FontName = "Tahoma"
            .FontSize = 8
            .ReadOnly = .T.
            .Value    = 0
        ENDWITH

        loc_oAba.AddObject("txt_4c_PesoBruto", "TextBox")
        WITH loc_oAba.txt_4c_PesoBruto
            .Top      = 380
            .Left     = 405
            .Width    = 73
            .Height   = 21
            .FontName = "Tahoma"
            .FontSize = 8
            .ReadOnly = .T.
            .Value    = 0
        ENDWITH
    ENDPROC

    *==========================================================================
    * ConfigurarAbaServicos - Cria controles na aba Servicos do PageFrame interno
    * Legado: SIGCDCNF.Pagina.Dados.Pagina.Servicos
    * Coordenadas originais do SCX (sem compensacao - inner PageFrame usa Tabs=.T.)
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarAbaServicos()
        LOCAL loc_oAba
        loc_oAba = THIS.pgf_4c_Paginas.Page2.pgf_4c_InnerPage.Page2

        *-- Say1: "Descricao dos Servicos Prestados :" (top=2, left=7)
        loc_oAba.AddObject("lbl_4c_SayDescSer", "Label")
        WITH loc_oAba.lbl_4c_SayDescSer
            .Caption   = "Descri" + CHR(231) + CHR(227) + "o dos Servi" + CHR(231) + "os Prestados : "
            .Top       = 2
            .Left      = 7
            .AutoSize  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(53, 53, 53)
        ENDWITH

        *-- Memo_desc EditBox (top=18, left=5, width=724, height=144)
        loc_oAba.AddObject("edt_4c_DescSer", "EditBox")
        WITH loc_oAba.edt_4c_DescSer
            .Top      = 18
            .Left     = 5
            .Width    = 724
            .Height   = 144
            .FontName = "Tahoma"
            .FontSize = 8
            .ReadOnly = .T.
            .Value    = ""
        ENDWITH

        *-- Say2: "Valor Total Servicos :" (top=167, left=15)
        loc_oAba.AddObject("lbl_4c_SayVtotsers", "Label")
        WITH loc_oAba.lbl_4c_SayVtotsers
            .Caption   = "Valor Total Servi" + CHR(231) + "os : "
            .Top       = 167
            .Left      = 15
            .AutoSize  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(53, 53, 53)
        ENDWITH

        *-- Get_vtotser (top=164, left=144, width=136)
        loc_oAba.AddObject("txt_4c_Vtotsers", "TextBox")
        WITH loc_oAba.txt_4c_Vtotsers
            .Top      = 164
            .Left     = 144
            .Width    = 136
            .Height   = 23
            .FontName = "Tahoma"
            .FontSize = 8
            .ReadOnly = .T.
            .Value    = 0
        ENDWITH

        *-- Say3: "% I.S.S. :" (top=192, left=81)
        loc_oAba.AddObject("lbl_4c_SayPerciss", "Label")
        WITH loc_oAba.lbl_4c_SayPerciss
            .Caption   = "% I.S.S. : "
            .Top       = 192
            .Left      = 81
            .AutoSize  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(53, 53, 53)
        ENDWITH

        *-- Get_perciss (top=189, left=144, width=52)
        loc_oAba.AddObject("txt_4c_Perciss", "TextBox")
        WITH loc_oAba.txt_4c_Perciss
            .Top      = 189
            .Left     = 144
            .Width    = 52
            .Height   = 23
            .FontName = "Tahoma"
            .FontSize = 8
            .ReadOnly = .T.
            .Value    = 0
        ENDWITH

        *-- Say4: "Valor Total do I.S.S. :" (top=217, left=14)
        loc_oAba.AddObject("lbl_4c_SayVtotiss", "Label")
        WITH loc_oAba.lbl_4c_SayVtotiss
            .Caption   = "Valor Total do I.S.S. : "
            .Top       = 217
            .Left      = 14
            .AutoSize  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(53, 53, 53)
        ENDWITH

        *-- Get_vtotiss (top=214, left=144, width=136)
        loc_oAba.AddObject("txt_4c_Vtotiss", "TextBox")
        WITH loc_oAba.txt_4c_Vtotiss
            .Top      = 214
            .Left     = 144
            .Width    = 136
            .Height   = 23
            .FontName = "Tahoma"
            .FontSize = 8
            .ReadOnly = .T.
            .Value    = 0
        ENDWITH
    ENDPROC

    *==========================================================================
    * BtnDadosClick - Abre SigMvExp com detalhes das movimentacoes da NF
    * Legado: Dados.Click -> SELECT Dopes FROM SigCdOpe -> DO FORM SigMvExp WITH ...
    *==========================================================================
    PROCEDURE BtnDadosClick()
        LOCAL loc_lResultado, loc_cDopes, loc_nNumes, loc_cEmps, loc_nResult, loc_cSQL
        loc_lResultado = .F.

        TRY
            THIS.Enabled = .F.

            loc_cDopes = ALLTRIM(THIS.this_oBusinessObject.this_cDopes)
            loc_nNumes = THIS.this_oBusinessObject.this_nNumes
            loc_cEmps  = THIS.this_cEmps

            IF EMPTY(loc_cDopes)
                MsgAviso("Opera" + CHR(231) + CHR(227) + "o n" + CHR(227) + "o definida.", "Dados")
            ELSE
                loc_cSQL    = "SELECT Dopes FROM SigCdOpe WHERE Dopes = " + EscaparSQL(loc_cDopes)
                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_TmpOpe")

                IF loc_nResult > 0 AND USED("cursor_4c_TmpOpe") AND RECCOUNT("cursor_4c_TmpOpe") > 0
                    DO FORM SigMvExp WITH loc_cDopes, "C", loc_nNumes, loc_cEmps, .T.
                    loc_lResultado = .T.
                ELSE
                    MsgAviso("Opera" + CHR(231) + CHR(227) + "o n" + CHR(227) + "o encontrada.", "Dados")
                ENDIF

                IF USED("cursor_4c_TmpOpe")
                    USE IN cursor_4c_TmpOpe
                ENDIF
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao abrir dados da NF")
        ENDTRY

        THIS.Enabled = .T.

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * BtnIncluirClick - Alias canonico para InserirCarta (inserir carta de correcao)
    * Mapeia o padrao CRUD para este formulario especializado
    *==========================================================================
    PROCEDURE BtnIncluirClick()
        THIS.BtnInserirCartaClick()
    ENDPROC

    *==========================================================================
    * BtnAlterarClick - Alias canonico para AlteraCarta (alterar carta de correcao)
    * Mapeia o padrao CRUD para este formulario especializado
    *==========================================================================
    PROCEDURE BtnAlterarClick()
        THIS.BtnAlteraCartaClick()
    ENDPROC

    *==========================================================================
    * BtnVisualizarClick - Visualiza NF selecionada em modo somente leitura
    * Legado: pcEscolha='CONSULTAR' -> Page2 com dados da NF (campos bloqueados)
    *==========================================================================
    PROCEDURE BtnVisualizarClick()
        LOCAL loc_lResultado
        loc_lResultado = .F.

        TRY
            IF !USED("cursor_4c_Dados") OR RECCOUNT("cursor_4c_Dados") = 0 OR ;
               EOF("cursor_4c_Dados")
                MsgAviso("Selecione uma Nota Fiscal na lista.", "Visualizar")
            ELSE
                SELECT cursor_4c_Dados

                IF THIS.this_oBusinessObject.CarregarPorCodigo(ALLTRIM(cursor_4c_Dados.cidchaves))
                    THIS.this_cModoAtual = "VISUALIZAR"
                    THIS.BOParaForm()
                    THIS.HabilitarCampos(.F.)
                    *-- Desabilitar Confirmar em modo VISUALIZAR (somente leitura)
                    THIS.pgf_4c_Paginas.Page2.cnt_4c_Salva.cmd_4c_Confirmar.Enabled = .F.
                    THIS.AlternarPagina(2)
                    loc_lResultado = .T.
                ELSE
                    MsgErro(THIS.this_oBusinessObject.this_cMensagemErro, ;
                        "Erro ao carregar NF")
                ENDIF
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao visualizar NF")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * BtnExcluirClick - Exclui carta de correcao da NF selecionada
    * Remove a carta de correcao (correcs=0), mantendo a NF original no sistema
    *==========================================================================
    PROCEDURE BtnExcluirClick()
        LOCAL loc_lResultado, loc_cCidchaves
        loc_lResultado = .F.

        IF !USED("cursor_4c_Dados") OR RECCOUNT("cursor_4c_Dados") = 0 OR ;
           EOF("cursor_4c_Dados")
            MsgAviso("Selecione uma Nota Fiscal na lista.", ;
                "Excluir Carta de Corre" + CHR(231) + CHR(227) + CHR(227) + "o")
            RETURN .F.
        ENDIF

        SELECT cursor_4c_Dados

        IF NVL(cursor_4c_Dados.correcs, 0) = 0
            MsgAviso("A nota selecionada n" + CHR(227) + "o possui carta de corre" + ;
                CHR(231) + CHR(227) + "o para excluir.", "Aviso")
            RETURN .F.
        ENDIF

        IF !MsgConfirma("Confirma a exclus" + CHR(227) + "o da carta de corre" + ;
                CHR(231) + CHR(227) + "o desta NF?", ;
                "Excluir Carta")
            RETURN .F.
        ENDIF

        TRY
            loc_cCidchaves = ALLTRIM(cursor_4c_Dados.cidchaves)

            IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCidchaves)
                IF THIS.this_oBusinessObject.Excluir()
                    MsgInfo("Carta de corre" + CHR(231) + CHR(227) + "o exclu" + ;
                        CHR(237) + "da com sucesso!", "Sucesso")
                    THIS.CarregarLista()
                    loc_lResultado = .T.
                ELSE
                    MsgErro(THIS.this_oBusinessObject.this_cMensagemErro, "Erro ao excluir")
                ENDIF
            ELSE
                MsgErro(THIS.this_oBusinessObject.this_cMensagemErro, "Erro ao carregar NF")
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, ;
                "Erro ao excluir carta de corre" + CHR(231) + CHR(227) + "o")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * Destroy - Limpeza ao fechar o formulario
    *==========================================================================
    PROCEDURE Destroy()
        IF USED("cursor_4c_Dados")
            USE IN cursor_4c_Dados
        ENDIF

        THIS.this_oBusinessObject = .NULL.
        DODEFAULT()
    ENDPROC

    *==========================================================================
    * BtnBuscarClick - Recarrega lista com filtros atuais (busca manual)
    *==========================================================================
    PROCEDURE BtnBuscarClick()
        IF EMPTY(ALLTRIM(THIS.this_cEmps))
            MsgAviso("Informe a Empresa para pesquisa.", "Buscar")
            THIS.pgf_4c_Paginas.Page1.cnt_4c_Filtros.txt_4c_Emp.SetFocus()
            RETURN
        ENDIF
        IF EMPTY(ALLTRIM(THIS.this_cSeriesFiltro))
            MsgAviso("Informe a S" + CHR(233) + "rie para pesquisa.", "Buscar")
            THIS.pgf_4c_Paginas.Page1.cnt_4c_Filtros.txt_4c_Serie.SetFocus()
            RETURN
        ENDIF
        THIS.CarregarLista()
    ENDPROC

    *==========================================================================
    * BtnSalvarClick - Alias canonico para BtnConfirmarClick (salvar dados)
    *==========================================================================
    PROCEDURE BtnSalvarClick()
        THIS.BtnConfirmarClick()
    ENDPROC

    *==========================================================================
    * AjustarBotoesPorModo - Ajusta estados de botoes conforme modo atual
    *==========================================================================
    PROCEDURE AjustarBotoesPorModo()
        LOCAL loc_oPg1, loc_oPg2, loc_lEdicao
        loc_oPg1    = THIS.pgf_4c_Paginas.Page1
        loc_oPg2    = THIS.pgf_4c_Paginas.Page2
        loc_lEdicao = INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")

        WITH loc_oPg1.cnt_4c_Botoes
            .cmd_4c_InserirCarta.Enabled = !loc_lEdicao
            .cmd_4c_AlteraCarta.Enabled  = !loc_lEdicao
            .cmd_4c_ImpCarta.Enabled     = !loc_lEdicao
            .Visible     = .T.
        ENDWITH
        loc_oPg1.cnt_4c_Saida.cmd_4c_Encerrar.Enabled = !loc_lEdicao

        WITH loc_oPg2.cnt_4c_Salva
            .cmd_4c_Confirmar.Enabled = loc_lEdicao
            .cmd_4c_Cancelar.Enabled  = .T.
            .Visible     = .T.
        ENDWITH
    ENDPROC

ENDDEFINE


### BO (C:\4c\projeto\app\classes\CNFBO.prg):
*==============================================================================
* CNFBO.prg - Business Object de Correcao de Notas Fiscais
* Tabela principal: SigMvNfi (PK: cidchaves)
*==============================================================================

DEFINE CLASS CNFBO AS BusinessBase

    *-- =========================================================================
    *-- Chave primaria e identificacao
    *-- =========================================================================
    this_cCidchaves    = ""   && char(20) PK composta
    this_cEmpdopnums   = ""   && char(29) emps+dopes+numes
    this_cEmps         = ""   && char(3)

    *-- =========================================================================
    *-- Cabecalho da NF
    *-- =========================================================================
    this_cDopes        = ""   && char(20) tipo de operacao
    this_nNumes        = 0    && numeric(6,0) numero interno
    this_cNfis         = ""   && char(6) numero da NF fiscal
    this_cSeries       = ""   && char(8) serie
    this_cEspecienfs   = ""   && char(6) especie da NF
    this_tEmis         = {}   && datetime data emissao
    this_tDtsaidas     = {}   && datetime data saida
    this_tDatans       = {}   && datetime data da nota
    this_cOperas       = ""   && char(1) E=Entrada S=Saida
    this_lCorrecs      = .F.  && bit possui carta de correcao
    this_lCancelas     = .F.  && bit cancelada
    this_lRegs         = .F.  && bit registrada

    *-- =========================================================================
    *-- Fiscal / CFOP
    *-- =========================================================================
    this_cCfis         = ""   && char(10) cod. fiscal CFOP
    this_cClfis        = ""   && char(12) classe fiscal
    this_cCodcons      = ""   && char(9)  cod. condicao
    this_cConds        = ""   && char(12) condicoes
    this_cCfosubs      = ""   && char(10) CFOP substituto

    *-- Display-only: JOIN SigCdCfo.descricaos
    this_cDescricaos   = ""

    *-- =========================================================================
    *-- Cliente / Fornecedor
    *-- =========================================================================
    this_cClifors      = ""   && char(20) cod. cliente/fornecedor
    this_cCgcs         = ""   && char(21) CGC/CNPJ

    *-- Display-only: JOIN SigCdCli.rclis
    this_cRclis        = ""

    *-- =========================================================================
    *-- Impostos - IPI
    *-- =========================================================================
    this_nBasecipis    = 0    && numeric(14,2) base calculo IPI
    this_nValipis      = 0    && numeric(14,2) valor IPI
    this_nIpis         = 0    && numeric(4,2)  aliquota IPI
    this_nIpincreds    = 0    && numeric(14,2) IPI nao credita
    this_nBasecip2s    = 0    && numeric(14,2) base IPI 2
    this_nBasecip3s    = 0    && numeric(14,2) base IPI 3
    this_nDesipis      = 0    && numeric(15,2) desoner. IPI
    this_nFrtipis      = 0    && numeric(15,2) frete IPI
    this_nSegipis      = 0    && numeric(15,2) seguro IPI

    *-- =========================================================================
    *-- Impostos - ICMS
    *-- =========================================================================
    this_nBasecicms    = 0    && numeric(14,2) base calculo ICMS
    this_nValicms      = 0    && numeric(14,2) valor ICMS
    this_nIcms         = 0    && numeric(4,2)  aliquota % ICMS
    this_nBasecic2s    = 0    && numeric(14,2) base ICMS 2
    this_nBasecic3s    = 0    && numeric(14,2) base ICMS 3
    this_nBcicmss      = 0    && numeric(15,2) base ICMS subst.
    this_nIcmss        = 0    && numeric(15,2) ICMS substituicao
    this_nDesicms      = 0    && numeric(15,2) desoner. ICMS
    this_nFrticms      = 0    && numeric(15,2) frete ICMS
    this_nSegicms      = 0    && numeric(15,2) seguro ICMS
    this_nVfcpst       = 0    && numeric(14,2) FCP ST

    *-- =========================================================================
    *-- Totais
    *-- =========================================================================
    this_nTotProds     = 0    && numeric(14,2) total produtos
    this_nTotNotas     = 0    && numeric(14,2) total da NF
    this_nVals         = 0    && numeric(14,2) valor
    this_nPesos        = 0    && numeric(7,2)  peso

    *-- =========================================================================
    *-- Outros valores / frete / seguro
    *-- =========================================================================
    this_nVlFretes     = 0    && numeric(14,2) valor do frete
    this_nVlSeguros    = 0    && numeric(14,2) valor do seguro
    this_nDespAces     = 0    && numeric(14,2) despesas acessorias

    *-- =========================================================================
    *-- Transporte
    *-- =========================================================================
    this_cCodtrans     = ""   && char(10) cod. transportadora
    this_nFretes       = 0    && numeric(1,0) tipo frete 0=Emit/1=Dest
    this_cPlacas       = ""   && char(8)  placa veiculo
    this_cUfPlacas     = ""   && char(2)  UF placa
    this_tDatatrans    = {}   && datetime data transporte
    this_nNtrans       = 0    && numeric(6,0) numero transporte
    this_cObsfretes    = ""   && char(10) obs frete

    *-- Display-only via JOIN SigPrTrp
    this_cTranspNome   = ""
    this_cTranspEnde   = ""
    this_cTranspCida   = ""
    this_cTranspEsta   = ""

    *-- =========================================================================
    *-- Volumes transportados
    *-- =========================================================================
    this_nQtdes        = 0    && numeric(6,0) qtde de volumes
    this_cEspes        = ""   && char(10) especie do volume
    this_cMarcas       = ""   && char(10) marca do volume
    this_cNumeros      = ""   && char(10) numero do volume
    this_nPliqs        = 0    && numeric(10,3) peso liquido
    this_nPbrus        = 0    && numeric(10,3) peso bruto
    this_cObspbrus     = ""   && char(10) obs peso bruto
    this_cObspliqs     = ""   && char(10) obs peso liquido

    *-- =========================================================================
    *-- Servicos
    *-- =========================================================================
    this_cDescsers     = ""   && text  descricao servicos (memo)
    this_nVtotsers     = 0    && numeric(14,2) valor total servicos
    this_nPerciss      = 0    && numeric(5,2)  % ISS
    this_nVtotiss      = 0    && numeric(14,2) valor total ISS
    this_cCodservs     = ""   && char(10) cod. servico
    this_cDescservs    = ""   && char(40) desc. servico

    *-- ISS retido / outras retencoes
    this_nIssretidos   = 0    && numeric(1,0)  ISS retido flag
    this_nOutretens    = 0    && numeric(15,2) outras retencoes
    this_cPrestservs   = ""   && char(7)  prestador servicos
    this_nVdeducoes    = 0    && numeric(15,2) valor deducoes
    this_nVdscconds    = 0    && numeric(15,2) desc. condicionado
    this_nVdsciconds   = 0    && numeric(15,2) desc. incondicionado
    this_cTiponfs      = ""   && char(2)  tipo NF
    this_nTptribsers   = 0    && numeric(2,0)  tipo tribut. servicos
    this_cCodsrvfis    = ""   && char(6)  cod. servico fiscal
    this_cCodbenefs    = ""   && char(3)  cod. beneficio

    *-- =========================================================================
    *-- PIS / COFINS / CSLL / IR / INSS
    *-- =========================================================================
    this_nPcofins      = 0    && numeric(5,2)  % COFINS
    this_nVcofins      = 0    && numeric(14,2) valor COFINS
    this_nPcsll        = 0    && numeric(5,2)  % CSLL
    this_nVcsll        = 0    && numeric(14,2) valor CSLL
    this_nPinss        = 0    && numeric(5,2)  % INSS
    this_nVinss        = 0    && numeric(14,2) valor INSS
    this_nPirf         = 0    && numeric(5,2)  % IR
    this_nVirf         = 0    && numeric(14,2) valor IR
    this_nPpis         = 0    && numeric(5,2)  % PIS
    this_nVpis         = 0    && numeric(14,2) valor PIS
    this_nValiis       = 0    && numeric(14,2) valor II

    *-- =========================================================================
    *-- RPS (Recibo Provisorio de Servicos)
    *-- =========================================================================
    this_nLoterps      = 0    && numeric(6,0)  lote RPS
    this_nNumrps       = 0    && numeric(12,0) numero RPS
    this_cSerierps     = ""   && char(5)  serie RPS
    this_cTiporps      = ""   && char(5)  tipo RPS

    *-- =========================================================================
    *-- NF-e / Chaves eletronicas
    *-- =========================================================================
    this_cNfechv       = ""   && char(44) chave NF-e
    this_cNfechvc      = ""   && char(44) chave NF-e cancelamento
    this_cChnfes       = ""   && char(44) chave NF-e referenciada
    this_cNfepdf       = ""   && text     NF-e PDF
    this_cNfeprt       = ""   && char(15) NF-e protocolo
    this_cNfetxt       = ""   && text     NF-e texto
    this_cNfexml       = ""   && text     NF-e XML
    this_cCanxml       = ""   && text     XML cancelamento
    this_tDdesembs     = {}   && datetime data desembarque
    this_tDregdis      = {}   && datetime data registro DI
    this_cNdis         = ""   && char(10) numero DI
    this_tInvcbds      = {}   && datetime data invalida CBD
    this_nChkenvias    = 0    && numeric(1,0) flag enviado
    this_cChaveexterna = ""   && char(33) chave externa
    this_nChkrastreio  = 0    && numeric(1,0) flag rastreio

    *-- =========================================================================
    *-- Observacoes / Misc
    *-- =========================================================================
    this_cObss         = ""   && char(40) observacoes
    this_cObs2s        = ""   && char(40) observacoes 2
    this_nImpress      = 0    && numeric(6,0)  numero de impressoes
    this_nSelos        = 0    && numeric(10,0) selos
    this_cLocals       = ""   && char(10) local
    this_tImportas     = {}   && datetime data importacao
    this_cNumeronota   = ""   && char(10) numero nota alternativo

    *-- =========================================================================
    *-- Filtros de pesquisa (usados em Buscar)
    *-- =========================================================================
    this_cEmpsFiltro    = ""   && empresa para filtro
    this_cSeriesFiltro  = ""   && serie para filtro
    this_tEmisDeFiltro  = {}   && periodo emissao de
    this_tEmisAteFiltro = {}   && periodo emissao ate
    this_cOpeFiltro     = "A"  && E=Entrada S=Saida A=Ambas
    this_cNfisDeFiltro  = ""   && NF de (filtro por numero)
    this_cNfisAteFiltro = ""   && NF ate (filtro por numero)
    this_lCancelasFiltro = .F. && incluir canceladas

    *==========================================================================
    PROCEDURE Init()
        DODEFAULT()
        THIS.this_cTabela     = "SigMvNfi"
        THIS.this_cCampoChave = "cidchaves"
        RETURN .T.
    ENDPROC

    PROTECTED PROCEDURE ObterChavePrimaria()
        RETURN ALLTRIM(THIS.this_cCidchaves)
    ENDPROC

    *==========================================================================
    * LimparDados - Limpa propriedades
    *==========================================================================
    PROTECTED PROCEDURE LimparDados()
        THIS.this_cCidchaves    = ""
        THIS.this_cEmpdopnums   = ""
        THIS.this_cEmps         = ""
        THIS.this_cDopes        = ""
        THIS.this_nNumes        = 0
        THIS.this_cNfis         = ""
        THIS.this_cSeries       = ""
        THIS.this_cEspecienfs   = ""
        THIS.this_tEmis         = {}
        THIS.this_tDtsaidas     = {}
        THIS.this_tDatans       = {}
        THIS.this_cOperas       = ""
        THIS.this_lCorrecs      = .F.
        THIS.this_lCancelas     = .F.
        THIS.this_lRegs         = .F.
        THIS.this_cCfis         = ""
        THIS.this_cClfis        = ""
        THIS.this_cCodcons      = ""
        THIS.this_cConds        = ""
        THIS.this_cCfosubs      = ""
        THIS.this_cDescricaos   = ""
        THIS.this_cClifors      = ""
        THIS.this_cCgcs         = ""
        THIS.this_cRclis        = ""
        THIS.this_nBasecipis    = 0
        THIS.this_nValipis      = 0
        THIS.this_nIpis         = 0
        THIS.this_nIpincreds    = 0
        THIS.this_nBasecip2s    = 0
        THIS.this_nBasecip3s    = 0
        THIS.this_nDesipis      = 0
        THIS.this_nFrtipis      = 0
        THIS.this_nSegipis      = 0
        THIS.this_nBasecicms    = 0
        THIS.this_nValicms      = 0
        THIS.this_nIcms         = 0
        THIS.this_nBasecic2s    = 0
        THIS.this_nBasecic3s    = 0
        THIS.this_nBcicmss      = 0
        THIS.this_nIcmss        = 0
        THIS.this_nDesicms      = 0
        THIS.this_nFrticms      = 0
        THIS.this_nSegicms      = 0
        THIS.this_nVfcpst       = 0
        THIS.this_nTotProds     = 0
        THIS.this_nTotNotas     = 0
        THIS.this_nVals         = 0
        THIS.this_nPesos        = 0
        THIS.this_nVlFretes     = 0
        THIS.this_nVlSeguros    = 0
        THIS.this_nDespAces     = 0
        THIS.this_cCodtrans     = ""
        THIS.this_nFretes       = 0
        THIS.this_cPlacas       = ""
        THIS.this_cUfPlacas     = ""
        THIS.this_tDatatrans    = {}
        THIS.this_nNtrans       = 0
        THIS.this_cObsfretes    = ""
        THIS.this_cTranspNome   = ""
        THIS.this_cTranspEnde   = ""
        THIS.this_cTranspCida   = ""
        THIS.this_cTranspEsta   = ""
        THIS.this_nQtdes        = 0
        THIS.this_cEspes        = ""
        THIS.this_cMarcas       = ""
        THIS.this_cNumeros      = ""
        THIS.this_nPliqs        = 0
        THIS.this_nPbrus        = 0
        THIS.this_cObspbrus     = ""
        THIS.this_cObspliqs     = ""
        THIS.this_cDescsers     = ""
        THIS.this_nVtotsers     = 0
        THIS.this_nPerciss      = 0
        THIS.this_nVtotiss      = 0
        THIS.this_cCodservs     = ""
        THIS.this_cDescservs    = ""
        THIS.this_nIssretidos   = 0
        THIS.this_nOutretens    = 0
        THIS.this_cPrestservs   = ""
        THIS.this_nVdeducoes    = 0
        THIS.this_nVdscconds    = 0
        THIS.this_nVdsciconds   = 0
        THIS.this_cTiponfs      = ""
        THIS.this_nTptribsers   = 0
        THIS.this_cCodsrvfis    = ""
        THIS.this_cCodbenefs    = ""
        THIS.this_nPcofins      = 0
        THIS.this_nVcofins      = 0
        THIS.this_nPcsll        = 0
        THIS.this_nVcsll        = 0
        THIS.this_nPinss        = 0
        THIS.this_nVinss        = 0
        THIS.this_nPirf         = 0
        THIS.this_nVirf         = 0
        THIS.this_nPpis         = 0
        THIS.this_nVpis         = 0
        THIS.this_nValiis       = 0
        THIS.this_nLoterps      = 0
        THIS.this_nNumrps       = 0
        THIS.this_cSerierps     = ""
        THIS.this_cTiporps      = ""
        THIS.this_cNfechv       = ""
        THIS.this_cNfechvc      = ""
        THIS.this_cChnfes       = ""
        THIS.this_cNfepdf       = ""
        THIS.this_cNfeprt       = ""
        THIS.this_cNfetxt       = ""
        THIS.this_cNfexml       = ""
        THIS.this_cCanxml       = ""
        THIS.this_tDdesembs     = {}
        THIS.this_tDregdis      = {}
        THIS.this_cNdis         = ""
        THIS.this_tInvcbds      = {}
        THIS.this_nChkenvias    = 0
        THIS.this_cChaveexterna = ""
        THIS.this_nChkrastreio  = 0
        THIS.this_cObss         = ""
        THIS.this_cObs2s        = ""
        THIS.this_nImpress      = 0
        THIS.this_nSelos        = 0
        THIS.this_cLocals       = ""
        THIS.this_tImportas     = {}
        THIS.this_cNumeronota   = ""
    ENDPROC

    *==========================================================================
    * CarregarDoCursor - Carrega dados do cursor para propriedades do BO
    *==========================================================================
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lResultado
        loc_lResultado = .F.

        IF !USED(par_cAliasCursor)
            RETURN .F.
        ENDIF

        TRY
            SELECT (par_cAliasCursor)

            THIS.this_cCidchaves   = TratarNulo(cidchaves,   "C")
            THIS.this_cEmpdopnums  = TratarNulo(empdopnums,  "C")
            THIS.this_cEmps        = TratarNulo(emps,        "C")
            THIS.this_cDopes       = TratarNulo(dopes,       "C")
            THIS.this_nNumes       = TratarNulo(numes,       "N")
            THIS.this_cNfis        = TratarNulo(nfis,        "C")
            THIS.this_cSeries      = TratarNulo(series,      "C")
            THIS.this_cEspecienfs  = TratarNulo(especienfs,  "C")
            IF !ISNULL(emis)
                THIS.this_tEmis    = emis
            ENDIF
            IF !ISNULL(dtsaidas)
                THIS.this_tDtsaidas = dtsaidas
            ENDIF
            IF !ISNULL(datans)
                THIS.this_tDatans  = datans
            ENDIF
            THIS.this_cOperas      = TratarNulo(operas,      "C")
            THIS.this_lCorrecs     = (IIF(ISNULL(correcs),  0, correcs)  <> 0)
            THIS.this_lCancelas    = (IIF(ISNULL(cancelas), 0, cancelas) <> 0)
            THIS.this_lRegs        = (IIF(ISNULL(regs),     0, regs)     <> 0)
            THIS.this_cCfis        = TratarNulo(cfis,        "C")
            THIS.this_cClfis       = TratarNulo(clfis,       "C")
            THIS.this_cCodcons     = TratarNulo(codcons,     "C")
            THIS.this_cConds       = TratarNulo(conds,       "C")
            THIS.this_cClifors     = TratarNulo(clifors,     "C")
            THIS.this_cCgcs        = TratarNulo(cgcs,        "C")
            THIS.this_nBasecipis   = TratarNulo(basecipis,   "N")
            THIS.this_nValipis     = TratarNulo(valipis,     "N")
            THIS.this_nIpis        = TratarNulo(ipis,        "N")
            THIS.this_nIpincreds   = TratarNulo(ipincreds,   "N")
            THIS.this_nBasecip2s   = TratarNulo(basecip2s,   "N")
            THIS.this_nBasecip3s   = TratarNulo(basecip3s,   "N")
            THIS.this_nBasecicms   = TratarNulo(basecicms,   "N")
            THIS.this_nValicms     = TratarNulo(valicms,     "N")
            THIS.this_nIcms        = TratarNulo(icms,        "N")
            THIS.this_nBasecic2s   = TratarNulo(basecic2s,   "N")
            THIS.this_nBasecic3s   = TratarNulo(basecic3s,   "N")
            THIS.this_nTotProds    = TratarNulo(totprods,    "N")
            THIS.this_nTotNotas    = TratarNulo(totnotas,    "N")
            THIS.this_nVals        = TratarNulo(vals,        "N")
            THIS.this_nPesos       = TratarNulo(pesos,       "N")
            THIS.this_nVlFretes    = TratarNulo(vlfretes,    "N")
            THIS.this_nVlSeguros   = TratarNulo(vlseguros,   "N")
            THIS.this_nDespAces    = TratarNulo(despaces,    "N")
            THIS.this_cCodtrans    = TratarNulo(codtrans,    "C")
            THIS.this_nFretes      = TratarNulo(fretes,      "N")
            THIS.this_cPlacas      = TratarNulo(placas,      "C")
            THIS.this_cUfPlacas    = TratarNulo(ufplacas,    "C")
            IF !ISNULL(datatrans)
                THIS.this_tDatatrans = datatrans
            ENDIF
            THIS.this_nQtdes       = TratarNulo(qtdes,       "N")
            THIS.this_cEspes       = TratarNulo(espes,       "C")
            THIS.this_cMarcas      = TratarNulo(marcas,      "C")
            THIS.this_cNumeros     = TratarNulo(numeros,     "C")
            THIS.this_nPliqs       = TratarNulo(pliqs,       "N")
            THIS.this_nPbrus       = TratarNulo(pbrus,       "N")
            THIS.this_cDescsers    = TratarNulo(descsers,    "C")
            THIS.this_nVtotsers    = TratarNulo(vtotsers,    "N")
            THIS.this_nPerciss     = TratarNulo(perciss,     "N")
            THIS.this_nVtotiss     = TratarNulo(vtotiss,     "N")
            THIS.this_nImpress     = TratarNulo(impress,     "N")
            THIS.this_cObss        = TratarNulo(obss,        "C")
            THIS.this_cObs2s       = TratarNulo(obs2s,       "C")
            IF !ISNULL(importas)
                THIS.this_tImportas = importas
            ENDIF
            *-- Campos de JOIN (presentes quando vem de Buscar ou CarregarPorCodigo)
            IF TYPE("rclis") <> "U"
                THIS.this_cRclis       = TratarNulo(rclis,       "C")
            ENDIF
            IF TYPE("descricaos") <> "U"
                THIS.this_cDescricaos  = TratarNulo(descricaos,  "C")
            ENDIF
            THIS.this_lNovoRegistro = .F.
            loc_lResultado = .T.
        CATCH TO loc_oErro
            MsgErro("Erro ao carregar cursor: " + loc_oErro.Message, "Erro")
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * Buscar - Pesquisa NFs com filtros configurados nas propriedades de filtro
    *==========================================================================
    PROCEDURE Buscar(par_cFiltro)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        LOCAL loc_cJoinCfg, loc_cWhereOpe, loc_cWhereSerie, loc_cWhereData
        LOCAL loc_cWhereNfi, loc_cWhereCan, loc_nCfgCount
        loc_lSucesso  = .F.
        loc_nCfgCount = 0

        IF EMPTY(THIS.this_cEmps)
            MsgAviso("Empresa obrigat" + CHR(243) + "ria para pesquisa.", "Aten" + CHR(231) + CHR(227) + "o")
            RETURN .F.
        ENDIF

        TRY
            *-- Verifica SigCnFNF: join por emps+series ou apenas series
            loc_nResultado = SQLEXEC(gnConnHandle, ;
                "SELECT COUNT(*) AS qtd FROM SigCnFNF WHERE emps = " + ;
                EscaparSQL(PADR(THIS.this_cEmps, 3)), ;
                "cursor_4c_CfgNFNF")
            IF loc_nResultado >= 0 AND USED("cursor_4c_CfgNFNF") AND RECCOUNT("cursor_4c_CfgNFNF") > 0
                SELECT cursor_4c_CfgNFNF
                loc_nCfgCount = cursor_4c_CfgNFNF.qtd
            ENDIF
            IF USED("cursor_4c_CfgNFNF")
                USE IN cursor_4c_CfgNFNF
            ENDIF

            IF loc_nCfgCount > 0
                loc_cJoinCfg = "LEFT JOIN SigCnFNF g ON g.emps + g.series = n.emps + n.series"
            ELSE
                loc_cJoinCfg = "LEFT JOIN SigCnFNF g ON g.series = n.series"
            ENDIF

            *-- Filtro operacao E/S/A
            DO CASE
                CASE THIS.this_cOpeFiltro = "E"
                    loc_cWhereOpe = " AND n.operas = 'E'"
                CASE THIS.this_cOpeFiltro = "S"
                    loc_cWhereOpe = " AND n.operas = 'S'"
                OTHERWISE
                    loc_cWhereOpe = " AND n.operas IN ('E','S')"
            ENDCASE

            *-- Filtro serie
            IF EMPTY(THIS.this_cSeriesFiltro)
                loc_cWhereSerie = ""
            ELSE
                loc_cWhereSerie = " AND n.series = " + EscaparSQL(PADR(THIS.this_cSeriesFiltro, 8))
            ENDIF

            *-- Filtro data emissao
            IF EMPTY(THIS.this_tEmisDeFiltro) OR EMPTY(THIS.this_tEmisAteFiltro)
                loc_cWhereData = ""
            ELSE
                loc_cWhereData = " AND CAST(n.emis AS DATE) BETWEEN " + ;
                    FormatarDataSQL(THIS.this_tEmisDeFiltro) + ;
                    " AND " + FormatarDataSQL(THIS.this_tEmisAteFiltro)
            ENDIF

            *-- Filtro numero NF
            IF EMPTY(THIS.this_cNfisDeFiltro) AND EMPTY(THIS.this_cNfisAteFiltro)
                loc_cWhereNfi = ""
            ELSE
                loc_cWhereNfi = " AND n.nfis BETWEEN " + ;
                    EscaparSQL(PADR(THIS.this_cNfisDeFiltro, 6)) + ;
                    " AND " + EscaparSQL(IIF(EMPTY(THIS.this_cNfisAteFiltro), ;
                        REPLICATE(CHR(254), 6), PADR(THIS.this_cNfisAteFiltro, 6)))
            ENDIF

            *-- Filtro canceladas (padrao = so nao canceladas)
            IF THIS.this_lCancelasFiltro
                loc_cWhereCan = ""
            ELSE
                loc_cWhereCan = " AND n.cancelas = 0"
            ENDIF

            loc_cSQL = "SELECT n.cidchaves, n.empdopnums, n.emps, n.dopes, n.numes," + ;
                " n.nfis, n.series, n.especienfs, n.emis, n.dtsaidas, n.datans," + ;
                " n.operas, n.correcs, n.cancelas, n.regs," + ;
                " n.cfis, n.clfis, n.codcons, n.conds," + ;
                " n.clifors, n.cgcs," + ;
                " n.basecipis, n.valipis, n.ipis, n.ipincreds," + ;
                " n.basecip2s, n.basecip3s," + ;
                " n.basecicms, n.valicms, n.icms," + ;
                " n.basecic2s, n.basecic3s," + ;
                " n.totprods, n.totnotas, n.vals, n.pesos," + ;
                " n.vlfretes, n.vlseguros, n.despaces," + ;
                " n.codtrans, n.fretes, n.placas, n.ufplacas, n.datatrans," + ;
                " n.qtdes, n.espes, n.marcas, n.numeros, n.pliqs, n.pbrus," + ;
                " n.descsers, n.vtotsers, n.perciss, n.vtotiss," + ;
                " n.impress, n.obss, n.obs2s, n.importas," + ;
                " c.rclis, f.descricaos" + ;
                " FROM SigMvNfi n" + ;
                " " + loc_cJoinCfg + ;
                " LEFT JOIN SigCdCfo f ON f.codigos = n.cfis" + ;
                " LEFT JOIN SigCdCli c ON c.iclis = n.clifors" + ;
                " WHERE n.emps = " + EscaparSQL(PADR(THIS.this_cEmps, 3)) + ;
                loc_cWhereSerie + ;
                loc_cWhereData + ;
                loc_cWhereOpe + ;
                loc_cWhereCan + ;
                loc_cWhereNfi + ;
                " ORDER BY n.nfis, n.emis"

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")
            IF loc_nResultado >= 0
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao buscar notas fiscais:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loc_oErro
            MsgErro("Erro ao buscar notas fiscais:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * CarregarPorCodigo - Carrega registro completo pelo cidchaves (PK)
    *==========================================================================
    PROCEDURE CarregarPorCodigo(par_cCidchaves)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "SELECT n.*, c.rclis, f.descricaos" + ;
                " FROM SigMvNfi n" + ;
                " LEFT JOIN SigCdCfo f ON f.codigos = n.cfis" + ;
                " LEFT JOIN SigCdCli c ON c.iclis = n.clifors" + ;
                " WHERE n.cidchaves = " + EscaparSQL(PADR(ALLTRIM(par_cCidchaves), 20))

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")
            IF loc_nResultado >= 0 AND USED("cursor_4c_Carrega") AND RECCOUNT("cursor_4c_Carrega") > 0
                loc_lSucesso = THIS.CarregarDoCursor("cursor_4c_Carrega")
            ENDIF

        CATCH TO loc_oErro
            MsgErro("Erro ao carregar NF:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        IF USED("cursor_4c_Carrega")
            USE IN cursor_4c_Carrega
        ENDIF

        *-- Carregar dados da transportadora automaticamente apos carregar NF
        IF loc_lSucesso AND !EMPTY(ALLTRIM(THIS.this_cCodtrans))
            THIS.CarregarTransportadora(THIS.this_cCodtrans)
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * CarregarTransportadora - Carrega dados do transportador por codtrans
    *==========================================================================
    PROTECTED PROCEDURE CarregarTransportadora(par_cCodTrans)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        THIS.this_cTranspNome = ""
        THIS.this_cTranspEnde = ""
        THIS.this_cTranspCida = ""
        THIS.this_cTranspEsta = ""

        IF EMPTY(par_cCodTrans)
            RETURN .T.
        ENDIF

        TRY
            loc_cSQL = "SELECT razaos, endes, cidas, estas" + ;
                " FROM SigPrTrp WHERE itras = " + ;
                EscaparSQL(PADR(ALLTRIM(par_cCodTrans), 20))

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Transp")
            IF loc_nResultado >= 0 AND USED("cursor_4c_Transp") AND RECCOUNT("cursor_4c_Transp") > 0
                SELECT cursor_4c_Transp
                THIS.this_cTranspNome = TratarNulo(razaos, "C")
                THIS.this_cTranspEnde = TratarNulo(endes,  "C")
                THIS.this_cTranspCida = TratarNulo(cidas,  "C")
                THIS.this_cTranspEsta = TratarNulo(estas,  "C")
                loc_lSucesso = .T.
            ENDIF

        CATCH TO loc_oErro
            MsgErro("Erro ao carregar transportadora:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        IF USED("cursor_4c_Transp")
            USE IN cursor_4c_Transp
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * BuscarSeries - Carrega series para lookup no filtro
    *==========================================================================
    PROCEDURE BuscarSeries(par_cEmpsFiltro)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF EMPTY(par_cEmpsFiltro)
                loc_cSQL = "SELECT DISTINCT Cods, Descs FROM SigCdSer ORDER BY Cods"
            ELSE
                loc_cSQL = "SELECT DISTINCT Cods, Descs FROM SigCdSer" + ;
                    " WHERE emps = " + EscaparSQL(PADR(ALLTRIM(par_cEmpsFiltro), 3)) + ;
                    " ORDER BY Cods"
            ENDIF

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Series")
            IF loc_nResultado >= 0
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao buscar s" + CHR(233) + "ries:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao buscar s" + CHR(233) + "ries:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * Inserir - INSERT no SigMvNfi
    *==========================================================================
    PROTECTED PROCEDURE Inserir()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "INSERT INTO SigMvNfi" + ;
                " (cidchaves, empdopnums, emps, dopes, numes," + ;
                "  nfis, series, especienfs, emis, dtsaidas, datans, operas," + ;
                "  correcs, cancelas, regs, cfis, clfis, codcons, conds," + ;
                "  clifors, cgcs, basecipis, valipis, ipis, ipincreds," + ;
                "  basecip2s, basecip3s, basecicms, valicms, icms," + ;
                "  basecic2s, basecic3s, totprods, totnotas, vals, pesos," + ;
                "  vlfretes, vlseguros, despaces, codtrans, fretes," + ;
                "  placas, ufplacas, datatrans," + ;
                "  qtdes, espes, marcas, numeros, pliqs, pbrus," + ;
                "  descsers, vtotsers, perciss, vtotiss, impress, obss, obs2s)" + ;
                " VALUES ("
            loc_cSQL = loc_cSQL + ;
                EscaparSQL(PADR(ALLTRIM(THIS.this_cCidchaves), 20)) + "," + ;
                EscaparSQL(PADR(ALLTRIM(THIS.this_cEmpdopnums), 29)) + "," + ;
                EscaparSQL(PADR(ALLTRIM(THIS.this_cEmps), 3)) + "," + ;
                EscaparSQL(PADR(ALLTRIM(THIS.this_cDopes), 20)) + "," + ;
                FormatarNumeroSQL(THIS.this_nNumes) + ","
            loc_cSQL = loc_cSQL + ;
                EscaparSQL(PADR(ALLTRIM(THIS.this_cNfis), 6)) + "," + ;
                EscaparSQL(PADR(ALLTRIM(THIS.this_cSeries), 8)) + "," + ;
                EscaparSQL(PADR(ALLTRIM(THIS.this_cEspecienfs), 6)) + "," + ;
                IIF(EMPTY(THIS.this_tEmis), "NULL", FormatarDataSQL(THIS.this_tEmis)) + "," + ;
                IIF(EMPTY(THIS.this_tDtsaidas), "NULL", FormatarDataSQL(THIS.this_tDtsaidas)) + "," + ;
                IIF(EMPTY(THIS.this_tDatans), "NULL", FormatarDataSQL(THIS.this_tDatans)) + "," + ;
                EscaparSQL(LEFT(ALLTRIM(THIS.this_cOperas), 1)) + ","
            loc_cSQL = loc_cSQL + ;
                IIF(THIS.this_lCorrecs, "1", "0") + "," + ;
                IIF(THIS.this_lCancelas, "1", "0") + "," + ;
                IIF(THIS.this_lRegs, "1", "0") + "," + ;
                EscaparSQL(PADR(ALLTRIM(THIS.this_cCfis), 10)) + "," + ;
                EscaparSQL(PADR(ALLTRIM(THIS.this_cClfis), 12)) + "," + ;
                EscaparSQL(PADR(ALLTRIM(THIS.this_cCodcons), 9)) + "," + ;
                EscaparSQL(PADR(ALLTRIM(THIS.this_cConds), 12)) + ","
            loc_cSQL = loc_cSQL + ;
                EscaparSQL(PADR(ALLTRIM(THIS.this_cClifors), 20)) + "," + ;
                EscaparSQL(PADR(ALLTRIM(THIS.this_cCgcs), 21)) + "," + ;
                FormatarNumeroSQL(THIS.this_nBasecipis) + "," + ;
                FormatarNumeroSQL(THIS.this_nValipis) + "," + ;
                FormatarNumeroSQL(THIS.this_nIpis) + "," + ;
                FormatarNumeroSQL(THIS.this_nIpincreds) + ","
            loc_cSQL = loc_cSQL + ;
                FormatarNumeroSQL(THIS.this_nBasecip2s) + "," + ;
                FormatarNumeroSQL(THIS.this_nBasecip3s) + "," + ;
                FormatarNumeroSQL(THIS.this_nBasecicms) + "," + ;
                FormatarNumeroSQL(THIS.this_nValicms) + "," + ;
                FormatarNumeroSQL(THIS.this_nIcms) + ","
            loc_cSQL = loc_cSQL + ;
                FormatarNumeroSQL(THIS.this_nBasecic2s) + "," + ;
                FormatarNumeroSQL(THIS.this_nBasecic3s) + "," + ;
                FormatarNumeroSQL(THIS.this_nTotProds) + "," + ;
                FormatarNumeroSQL(THIS.this_nTotNotas) + "," + ;
                FormatarNumeroSQL(THIS.this_nVals) + "," + ;
                FormatarNumeroSQL(THIS.this_nPesos) + ","
            loc_cSQL = loc_cSQL + ;
                FormatarNumeroSQL(THIS.this_nVlFretes) + "," + ;
                FormatarNumeroSQL(THIS.this_nVlSeguros) + "," + ;
                FormatarNumeroSQL(THIS.this_nDespAces) + "," + ;
                EscaparSQL(PADR(ALLTRIM(THIS.this_cCodtrans), 10)) + "," + ;
                FormatarNumeroSQL(THIS.this_nFretes) + ","
            loc_cSQL = loc_cSQL + ;
                EscaparSQL(PADR(ALLTRIM(THIS.this_cPlacas), 8)) + "," + ;
                EscaparSQL(PADR(ALLTRIM(THIS.this_cUfPlacas), 2)) + "," + ;
                IIF(EMPTY(THIS.this_tDatatrans), "NULL", FormatarDataSQL(THIS.this_tDatatrans)) + ","
            loc_cSQL = loc_cSQL + ;
                FormatarNumeroSQL(THIS.this_nQtdes) + "," + ;
                EscaparSQL(PADR(ALLTRIM(THIS.this_cEspes), 10)) + "," + ;
                EscaparSQL(PADR(ALLTRIM(THIS.this_cMarcas), 10)) + "," + ;
                EscaparSQL(PADR(ALLTRIM(THIS.this_cNumeros), 10)) + "," + ;
                FormatarNumeroSQL(THIS.this_nPliqs) + "," + ;
                FormatarNumeroSQL(THIS.this_nPbrus) + ","
            loc_cSQL = loc_cSQL + ;
                EscaparSQL(ALLTRIM(THIS.this_cDescsers)) + "," + ;
                FormatarNumeroSQL(THIS.this_nVtotsers) + "," + ;
                FormatarNumeroSQL(THIS.this_nPerciss) + "," + ;
                FormatarNumeroSQL(THIS.this_nVtotiss) + "," + ;
                FormatarNumeroSQL(THIS.this_nImpress) + "," + ;
                EscaparSQL(LEFT(ALLTRIM(THIS.this_cObss), 40)) + "," + ;
                EscaparSQL(LEFT(ALLTRIM(THIS.this_cObs2s), 40)) + ")"

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Insert")
            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("INSERT")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao inserir nota fiscal:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao inserir nota fiscal:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        IF USED("cursor_4c_Insert")
            USE IN cursor_4c_Insert
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * Atualizar - UPDATE no SigMvNfi pelo cidchaves
    *==========================================================================
    PROTECTED PROCEDURE Atualizar()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "UPDATE SigMvNfi SET" + ;
                " nfis     = " + EscaparSQL(PADR(ALLTRIM(THIS.this_cNfis), 6)) + "," + ;
                " dtsaidas = " + IIF(EMPTY(THIS.this_tDtsaidas), "NULL", FormatarDataSQL(THIS.this_tDtsaidas)) + "," + ;
                " correcs  = " + IIF(THIS.this_lCorrecs, "1", "0") + ","
            loc_cSQL = loc_cSQL + ;
                " cfis    = " + EscaparSQL(PADR(ALLTRIM(THIS.this_cCfis), 10)) + "," + ;
                " clfis   = " + EscaparSQL(PADR(ALLTRIM(THIS.this_cClfis), 12)) + "," + ;
                " clifors = " + EscaparSQL(PADR(ALLTRIM(THIS.this_cClifors), 20)) + ","
            loc_cSQL = loc_cSQL + ;
                " basecipis = " + FormatarNumeroSQL(THIS.this_nBasecipis) + "," + ;
                " valipis   = " + FormatarNumeroSQL(THIS.this_nValipis) + "," + ;
                " ipis      = " + FormatarNumeroSQL(THIS.this_nIpis) + "," + ;
                " basecicms = " + FormatarNumeroSQL(THIS.this_nBasecicms) + ","
            loc_cSQL = loc_cSQL + ;
                " valicms  = " + FormatarNumeroSQL(THIS.this_nValicms) + "," + ;
                " icms     = " + FormatarNumeroSQL(THIS.this_nIcms) + "," + ;
                " totprods = " + FormatarNumeroSQL(THIS.this_nTotProds) + "," + ;
                " totnotas = " + FormatarNumeroSQL(THIS.this_nTotNotas) + ","
            loc_cSQL = loc_cSQL + ;
                " vlfretes  = " + FormatarNumeroSQL(THIS.this_nVlFretes) + "," + ;
                " vlseguros = " + FormatarNumeroSQL(THIS.this_nVlSeguros) + "," + ;
                " despaces  = " + FormatarNumeroSQL(THIS.this_nDespAces) + ","
            loc_cSQL = loc_cSQL + ;
                " codtrans = " + EscaparSQL(PADR(ALLTRIM(THIS.this_cCodtrans), 10)) + "," + ;
                " fretes   = " + FormatarNumeroSQL(THIS.this_nFretes) + "," + ;
                " placas   = " + EscaparSQL(PADR(ALLTRIM(THIS.this_cPlacas), 8)) + "," + ;
                " ufplacas = " + EscaparSQL(PADR(ALLTRIM(THIS.this_cUfPlacas), 2)) + ","
            loc_cSQL = loc_cSQL + ;
                " datatrans = " + IIF(EMPTY(THIS.this_tDatatrans), "NULL", FormatarDataSQL(THIS.this_tDatatrans)) + "," + ;
                " qtdes     = " + FormatarNumeroSQL(THIS.this_nQtdes) + "," + ;
                " espes     = " + EscaparSQL(PADR(ALLTRIM(THIS.this_cEspes), 10)) + ","
            loc_cSQL = loc_cSQL + ;
                " marcas  = " + EscaparSQL(PADR(ALLTRIM(THIS.this_cMarcas), 10)) + "," + ;
                " numeros = " + EscaparSQL(PADR(ALLTRIM(THIS.this_cNumeros), 10)) + "," + ;
                " pliqs   = " + FormatarNumeroSQL(THIS.this_nPliqs) + "," + ;
                " pbrus   = " + FormatarNumeroSQL(THIS.this_nPbrus) + ","
            loc_cSQL = loc_cSQL + ;
                " descsers = " + EscaparSQL(ALLTRIM(THIS.this_cDescsers)) + "," + ;
                " vtotsers = " + FormatarNumeroSQL(THIS.this_nVtotsers) + "," + ;
                " perciss  = " + FormatarNumeroSQL(THIS.this_nPerciss) + "," + ;
                " vtotiss  = " + FormatarNumeroSQL(THIS.this_nVtotiss) + ","
            loc_cSQL = loc_cSQL + ;
                " obss  = " + EscaparSQL(LEFT(ALLTRIM(THIS.this_cObss), 40)) + "," + ;
                " obs2s = " + EscaparSQL(LEFT(ALLTRIM(THIS.this_cObs2s), 40)) + ;
                " WHERE cidchaves = " + EscaparSQL(PADR(ALLTRIM(THIS.this_cCidchaves), 20))

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Update")
            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("UPDATE")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao atualizar nota fiscal:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao atualizar nota fiscal:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        IF USED("cursor_4c_Update")
            USE IN cursor_4c_Update
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * ExecutarExclusao - DELETE do SigMvNfi pelo cidchaves
    *==========================================================================
    PROTECTED PROCEDURE ExecutarExclusao()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "DELETE FROM SigMvNfi" + ;
                " WHERE cidchaves = " + EscaparSQL(PADR(ALLTRIM(THIS.this_cCidchaves), 20))

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Delete")
            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("DELETE")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao excluir nota fiscal:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao excluir nota fiscal:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        IF USED("cursor_4c_Delete")
            USE IN cursor_4c_Delete
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

ENDDEFINE


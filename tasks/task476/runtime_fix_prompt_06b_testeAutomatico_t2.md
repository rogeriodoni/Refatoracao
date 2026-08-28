# CORRIGIR ERRO DE RUNTIME VFP9

## TAREFA OBRIGATORIA
O formulario VFP9 apresentou erro de runtime durante teste automatizado.
Voce DEVE corrigir o erro e salvar os arquivos corrigidos usando Write tool.

## ERRO DETECTADO
- Etapa: 06b_testeAutomatico
- Tentativa: 2/10
- Mensagem: Testes automaticos: 67% < 100%. Falhas: Teste 'CarregarLista': Nenhum cursor padrao foi criado (cursor_4c_Dados/Lista/Busca/etc); Teste 'ModoIncluir': Property ALTERNARPAGINA is not found. | Detalhes: Linha: 429; Teste 'ModoVisualizar': Property AJUSTARBOTOESPORMODO is not found. | Detalhes: Linha: 559

## CONTEXTO DO ERRO

### LOG DA ETAPA (06b_testeAutomatico):
[2026-08-22 00:45:20] [INFO] === VFP EXECUTOR v2.0 ===
[2026-08-22 00:45:20] [INFO] Config FPW: (nao fornecido)
[2026-08-22 00:45:20] [INFO] Script PRG: C:\4c\projeto\app\utils\TesteAutomatico.prg
[2026-08-22 00:45:20] [INFO] Timeout: 300 segundos
[2026-08-22 00:45:20] [INFO] Wrapper PRG criado para parametros: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_gufslwjv.prg
[2026-08-22 00:45:20] [INFO] Conteudo do wrapper:
[2026-08-22 00:45:20] [INFO] * Auto-generated wrapper for parameters
* Script: C:\4c\projeto\app\utils\TesteAutomatico.prg
* Parameters: 'FormObs', 'C:\4c\tasks\task476', 'CRUD'

* Anti-dialog protections for unattended execution
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
SET NOTIFY OFF
SYS(2335, 0)

DO "C:\4c\projeto\app\utils\TesteAutomatico" WITH 'FormObs', 'C:\4c\tasks\task476', 'CRUD'
QUIT

[2026-08-22 00:45:20] [INFO] Comando VFP: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_gufslwjv.prg
[2026-08-22 00:45:20] [INFO] VFP output esperado em: C:\4c\tasks\task476\vfp_output.txt
[2026-08-22 00:45:20] [INFO] Executando Visual FoxPro 9...
[2026-08-22 00:45:20] [INFO] Comando completo: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_gufslwjv.prg
[2026-08-22 00:45:20] [INFO] Executando: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_gufslwjv.prg
[2026-08-22 00:45:20] [INFO] Timeout configurado: 300 segundos
[2026-08-22 00:46:38] [INFO] VFP9 finalizou normalmente com exit code: 
[2026-08-22 00:46:38] [INFO] VFP9 finalizado em 78.0570595 segundos
[2026-08-22 00:46:38] [INFO] Exit Code: 
[2026-08-22 00:46:38] [INFO] 
[2026-08-22 00:46:38] [INFO] Arquivos temporarios preservados para inspecao:
[2026-08-22 00:46:38] [INFO]   Wrapper.prg: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_gufslwjv.prg
[2026-08-22 00:46:38] [INFO] 
[2026-08-22 00:46:38] [INFO] === Conteudo do Wrapper.prg temporario ===
[2026-08-22 00:46:38] [INFO] * Auto-generated wrapper for parameters
[2026-08-22 00:46:38] [INFO] * Script: C:\4c\projeto\app\utils\TesteAutomatico.prg
[2026-08-22 00:46:38] [INFO] * Parameters: 'FormObs', 'C:\4c\tasks\task476', 'CRUD'
[2026-08-22 00:46:38] [INFO] 
[2026-08-22 00:46:38] [INFO] * Anti-dialog protections for unattended execution
[2026-08-22 00:46:38] [INFO] SET SAFETY OFF
[2026-08-22 00:46:38] [INFO] SET RESOURCE OFF
[2026-08-22 00:46:38] [INFO] SET TALK OFF
[2026-08-22 00:46:38] [INFO] SET NOTIFY OFF
[2026-08-22 00:46:38] [INFO] SYS(2335, 0)
[2026-08-22 00:46:38] [INFO] 
[2026-08-22 00:46:38] [INFO] DO "C:\4c\projeto\app\utils\TesteAutomatico" WITH 'FormObs', 'C:\4c\tasks\task476', 'CRUD'
[2026-08-22 00:46:38] [INFO] QUIT
[2026-08-22 00:46:38] [INFO] 
[2026-08-22 00:46:38] [INFO] === Fim do Wrapper.prg ===
[2026-08-22 00:46:38] [WARN] AVISO: VFP9 retornou exit code  (normal para VFP9 GUI - validar pelo arquivo de saida)
[2026-08-22 00:47:58] [INFO] === VFP EXECUTOR v2.0 ===
[2026-08-22 00:47:58] [INFO] Config FPW: (nao fornecido)
[2026-08-22 00:47:58] [INFO] Script PRG: C:\4c\projeto\app\utils\TesteAutomatico.prg
[2026-08-22 00:47:58] [INFO] Timeout: 300 segundos
[2026-08-22 00:47:58] [INFO] Wrapper PRG criado para parametros: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_dwwgmlcb.prg
[2026-08-22 00:47:58] [INFO] Conteudo do wrapper:
[2026-08-22 00:47:58] [INFO] * Auto-generated wrapper for parameters
* Script: C:\4c\projeto\app\utils\TesteAutomatico.prg
* Parameters: 'FormObs', 'C:\4c\tasks\task476', 'CRUD'

* Anti-dialog protections for unattended execution
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
SET NOTIFY OFF
SYS(2335, 0)

DO "C:\4c\projeto\app\utils\TesteAutomatico" WITH 'FormObs', 'C:\4c\tasks\task476', 'CRUD'
QUIT

[2026-08-22 00:47:58] [INFO] Comando VFP: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_dwwgmlcb.prg
[2026-08-22 00:47:58] [INFO] VFP output esperado em: C:\4c\tasks\task476\vfp_output.txt
[2026-08-22 00:47:58] [INFO] Executando Visual FoxPro 9...
[2026-08-22 00:47:58] [INFO] Comando completo: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_dwwgmlcb.prg
[2026-08-22 00:47:58] [INFO] Executando: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_dwwgmlcb.prg
[2026-08-22 00:47:58] [INFO] Timeout configurado: 300 segundos
[2026-08-22 00:49:23] [INFO] VFP9 finalizou normalmente com exit code: 
[2026-08-22 00:49:23] [INFO] VFP9 finalizado em 85.2249394 segundos
[2026-08-22 00:49:23] [INFO] Exit Code: 
[2026-08-22 00:49:23] [INFO] 
[2026-08-22 00:49:23] [INFO] Arquivos temporarios preservados para inspecao:
[2026-08-22 00:49:23] [INFO]   Wrapper.prg: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_dwwgmlcb.prg
[2026-08-22 00:49:23] [INFO] 
[2026-08-22 00:49:23] [INFO] === Conteudo do Wrapper.prg temporario ===
[2026-08-22 00:49:23] [INFO] * Auto-generated wrapper for parameters
[2026-08-22 00:49:23] [INFO] * Script: C:\4c\projeto\app\utils\TesteAutomatico.prg
[2026-08-22 00:49:23] [INFO] * Parameters: 'FormObs', 'C:\4c\tasks\task476', 'CRUD'
[2026-08-22 00:49:23] [INFO] 
[2026-08-22 00:49:23] [INFO] * Anti-dialog protections for unattended execution
[2026-08-22 00:49:23] [INFO] SET SAFETY OFF
[2026-08-22 00:49:23] [INFO] SET RESOURCE OFF
[2026-08-22 00:49:23] [INFO] SET TALK OFF
[2026-08-22 00:49:23] [INFO] SET NOTIFY OFF
[2026-08-22 00:49:23] [INFO] SYS(2335, 0)
[2026-08-22 00:49:23] [INFO] 
[2026-08-22 00:49:23] [INFO] DO "C:\4c\projeto\app\utils\TesteAutomatico" WITH 'FormObs', 'C:\4c\tasks\task476', 'CRUD'
[2026-08-22 00:49:23] [INFO] QUIT
[2026-08-22 00:49:23] [INFO] 
[2026-08-22 00:49:23] [INFO] === Fim do Wrapper.prg ===
[2026-08-22 00:49:23] [WARN] AVISO: VFP9 retornou exit code  (normal para VFP9 GUI - validar pelo arquivo de saida)


### RESULTADO DOS TESTES (teste_resultado.json):
{
  "formClass": "FormObs",
  "timestamp": "20260822004923",
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
      "detalhes": "Linha: 429"
    },
    {
      "nome": "ModoVisualizar",
      "passou": false,
      "erro": "Property AJUSTARBOTOESPORMODO is not found.",
      "detalhes": "Linha: 559"
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
      "detalhes": "AbrirLookup: 1 (ABRIRLOOKUPCANONICO) | KeyPress handlers: 1 (KEYPRESS)"
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

### FORM (C:\4c\projeto\app\forms\cadastros\FormObs.prg):
*==============================================================================
* FormObs.PRG - Fase 3/8: Estrutura Base
* Formulario de Cadastro de Observacoes (SIGCDOBS)
*
* Tabela: SigCdObs
* Tipo: CRUD (frmcadastro)
* BO: ObsBO
*
* Fase 3: DEFINE CLASS + Init + InicializarForm + ConfigurarPageFrame + Destroy
*==============================================================================

DEFINE CLASS FormObs AS FormBase

    *-- Propriedades visuais (PILAR 1 - UX FIDELITY)
    Height      = 600
    Width       = 1000
    Caption     = "Cadastro de Observacoes"
    AutoCenter  = .T.
    ShowWindow  = 1
    WindowType  = 1
    ControlBox  = .F.
    Closable    = .F.
    MaxButton   = .F.
    TitleBar    = 0
    Themes      = .F.
    BorderStyle = 2
    DataSession = 2

    *-- Propriedades de estado
    this_oBusinessObject = .NULL.
    this_cModoAtual      = "LISTA"

    *--------------------------------------------------------------------------
    * Init - APENAS retorna DODEFAULT (FormBase.Init chama InicializarForm)
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        LOCAL loc_lResultado
        loc_lResultado = .F.

        TRY
            loc_lResultado = DODEFAULT()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "FormObs.Init")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * InicializarForm - Configura estrutura completa
    * Chamado automaticamente pelo FormBase.Init()
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lResultado
        loc_lResultado = .F.

        TRY
            THIS.Caption = "Cadastro de Observa" + CHR(231) + CHR(245) + "es"

            THIS.this_oBusinessObject = CREATEOBJECT("ObsBO")

            IF VARTYPE(THIS.this_oBusinessObject) != "O"
                MsgErro("Falha ao criar ObsBO", "Erro")
            ELSE
                IF TYPE("gb_4c_ValidandoUI") != "L" OR !gb_4c_ValidandoUI
                    SQLEXEC(gnConnHandle, ;
                        "SELECT Dopes, Cmoes, nFiscals, Abrevs FROM SigCdOpe" + ;
                        " ORDER BY Dopes", ;
                        "cursor_4c_Nivel")
                ENDIF

                THIS.ConfigurarPageFrame()

                THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
                THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption

                IF TYPE("gb_4c_ValidandoUI") != "L" OR !gb_4c_ValidandoUI
                    THIS.CarregarLista()
                ENDIF

                THIS.pgf_4c_Paginas.Visible  = .T.
                THIS.pgf_4c_Paginas.ActivePage = 1
                THIS.this_cModoAtual = "LISTA"
                loc_lResultado = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "FormObs.InicializarForm")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPageFrame - Cria PageFrame com Page1 (Lista) e Page2 (Dados)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPageFrame()
        LOCAL loc_oPgf
        THIS.AddObject("pgf_4c_Paginas", "PageFrame")
        loc_oPgf = THIS.pgf_4c_Paginas

        WITH loc_oPgf
            .PageCount = 2
            .Top       = -29
            .Left      = 0
            .Width     = THIS.Width
            .Height    = THIS.Height + 29
            .Tabs      = .F.
            .Visible   = .T.
            .Page1.Caption   = "Lista"
            .Page1.BackColor = RGB(100, 100, 100)
            .Page1.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
            .Page2.Caption   = "Dados"
            .Page2.BackColor = RGB(100, 100, 100)
            .Page2.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
        ENDWITH

        THIS.ConfigurarPaginaLista()
        THIS.ConfigurarPaginaDados()
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPaginaLista - Cria estrutura completa da Page1
    * Cabecalho + Botoes CRUD + Grid + Encerrar
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPaginaLista()
        LOCAL loc_oPg1, loc_oCab, loc_oBotoes, loc_oSaida, loc_oGrid
        loc_oPg1 = THIS.pgf_4c_Paginas.Page1

        *-- Container cabecalho (cntSombra.Top=1 no original + 29 compensacao = 30)
        loc_oPg1.AddObject("cnt_4c_Cabecalho", "Container")
        loc_oCab = loc_oPg1.cnt_4c_Cabecalho
        WITH loc_oCab
            .Top         = 30
            .Left        = 0
            .Width       = THIS.Width
            .Height      = 80
            .BackColor   = RGB(100, 100, 100)
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH

        loc_oCab.AddObject("lbl_4c_Sombra", "Label")
        WITH loc_oCab.lbl_4c_Sombra
            .AutoSize  = .F.
            .Caption   = THIS.Caption
            .Top       = 15
            .Left      = 10
            .Width     = THIS.Width
            .Height    = 40
            .FontName  = "Tahoma"
            .FontSize  = 16
            .FontBold  = .T.
            .ForeColor = RGB(0, 0, 0)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oCab.AddObject("lbl_4c_Titulo", "Label")
        WITH loc_oCab.lbl_4c_Titulo
            .AutoSize  = .F.
            .Caption   = THIS.Caption
            .Top       = 18
            .Left      = 10
            .Width     = THIS.Width
            .Height    = 46
            .FontName  = "Tahoma"
            .FontSize  = 16
            .FontBold  = .T.
            .ForeColor = RGB(255, 255, 255)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        *-- Container botoes CRUD (Grupo_op.Left=543, Top=0+29=29)
        loc_oPg1.AddObject("cnt_4c_Botoes", "Container")
        loc_oBotoes = loc_oPg1.cnt_4c_Botoes
        WITH loc_oBotoes
            .Top         = 29
            .Left        = 542
            .Width       = 390
            .Height      = 85
            .BackColor   = RGB(53, 53, 53)
            .BackStyle   = 1
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH

        *-- Botao Incluir
        loc_oBotoes.AddObject("cmd_4c_Incluir", "CommandButton")
        WITH loc_oBotoes.cmd_4c_Incluir
            .Caption         = "Incluir"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_inserir_26.jpg"
            .PicturePosition = 13
            .Top             = 5
            .Left            = 5
            .Width           = 75
            .Height          = 75
            .BackColor       = RGB(255, 255, 255)
            .ForeColor       = RGB(90, 90, 90)
            .FontName        = "Tahoma"
            .FontSize        = 8
            .FontBold        = .T.
            .FontItalic      = .T.
            .Themes          = .F.
            .SpecialEffect   = 0
            .MousePointer    = 15
            .WordWrap        = .T.
            .AutoSize        = .F.
            .Visible         = .T.
        ENDWITH
        BINDEVENT(loc_oBotoes.cmd_4c_Incluir, "Click", THIS, "BtnIncluirClick")

        *-- Botao Visualizar
        loc_oBotoes.AddObject("cmd_4c_Visualizar", "CommandButton")
        WITH loc_oBotoes.cmd_4c_Visualizar
            .Caption         = "Visualizar"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_vizualizar_60.jpg"
            .PicturePosition = 13
            .Top             = 5
            .Left            = 80
            .Width           = 75
            .Height          = 75
            .BackColor       = RGB(255, 255, 255)
            .ForeColor       = RGB(90, 90, 90)
            .FontName        = "Tahoma"
            .FontSize        = 8
            .FontBold        = .T.
            .FontItalic      = .T.
            .Themes          = .F.
            .SpecialEffect   = 0
            .MousePointer    = 15
            .WordWrap        = .T.
            .AutoSize        = .F.
            .Visible         = .T.
        ENDWITH
        BINDEVENT(loc_oBotoes.cmd_4c_Visualizar, "Click", THIS, "BtnVisualizarClick")

        *-- Botao Alterar
        loc_oBotoes.AddObject("cmd_4c_Alterar", "CommandButton")
        WITH loc_oBotoes.cmd_4c_Alterar
            .Caption         = "Alterar"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_alterar_60.jpg"
            .PicturePosition = 13
            .Top             = 5
            .Left            = 155
            .Width           = 75
            .Height          = 75
            .BackColor       = RGB(255, 255, 255)
            .ForeColor       = RGB(90, 90, 90)
            .FontName        = "Tahoma"
            .FontSize        = 8
            .FontBold        = .T.
            .FontItalic      = .T.
            .Themes          = .F.
            .SpecialEffect   = 0
            .MousePointer    = 15
            .WordWrap        = .T.
            .AutoSize        = .F.
            .Visible         = .T.
        ENDWITH
        BINDEVENT(loc_oBotoes.cmd_4c_Alterar, "Click", THIS, "BtnAlterarClick")

        *-- Botao Excluir
        loc_oBotoes.AddObject("cmd_4c_Excluir", "CommandButton")
        WITH loc_oBotoes.cmd_4c_Excluir
            .Caption         = "Excluir"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_excluir_60.jpg"
            .PicturePosition = 13
            .Top             = 5
            .Left            = 230
            .Width           = 75
            .Height          = 75
            .BackColor       = RGB(255, 255, 255)
            .ForeColor       = RGB(90, 90, 90)
            .FontName        = "Tahoma"
            .FontSize        = 8
            .FontBold        = .T.
            .FontItalic      = .T.
            .Themes          = .F.
            .SpecialEffect   = 0
            .MousePointer    = 15
            .WordWrap        = .T.
            .AutoSize        = .F.
            .Visible         = .T.
        ENDWITH
        BINDEVENT(loc_oBotoes.cmd_4c_Excluir, "Click", THIS, "BtnExcluirClick")

        *-- Botao Buscar
        loc_oBotoes.AddObject("cmd_4c_Buscar", "CommandButton")
        WITH loc_oBotoes.cmd_4c_Buscar
            .Caption         = "Buscar"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_procurar_60.jpg"
            .PicturePosition = 13
            .Top             = 5
            .Left            = 305
            .Width           = 75
            .Height          = 75
            .BackColor       = RGB(255, 255, 255)
            .ForeColor       = RGB(90, 90, 90)
            .FontName        = "Tahoma"
            .FontSize        = 8
            .FontBold        = .T.
            .FontItalic      = .T.
            .Themes          = .F.
            .SpecialEffect   = 0
            .MousePointer    = 15
            .WordWrap        = .T.
            .AutoSize        = .F.
            .Visible         = .T.
        ENDWITH
        BINDEVENT(loc_oBotoes.cmd_4c_Buscar, "Click", THIS, "BtnBuscarClick")

        *-- Container Encerrar - padrao canonico (CLAUDE.md regra #10)
        loc_oPg1.AddObject("cnt_4c_Saida", "Container")
        loc_oSaida = loc_oPg1.cnt_4c_Saida
        WITH loc_oSaida
            .Top         = 29
            .Left        = 917
            .Width       = 90
            .Height      = 85
            .BackStyle   = 0
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH

        loc_oSaida.AddObject("cmd_4c_Encerrar", "CommandButton")
        WITH loc_oSaida.cmd_4c_Encerrar
            .Caption         = "Encerrar"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
            .PicturePosition = 13
            .Top             = 5
            .Left            = 5
            .Width           = 75
            .Height          = 75
            .BackColor       = RGB(255, 255, 255)
            .ForeColor       = RGB(90, 90, 90)
            .FontName        = "Tahoma"
            .FontSize        = 8
            .FontBold        = .T.
            .FontItalic      = .T.
            .Themes          = .F.
            .SpecialEffect   = 0
            .MousePointer    = 15
            .WordWrap        = .T.
            .AutoSize        = .F.
            .Visible         = .T.
        ENDWITH
        BINDEVENT(loc_oSaida.cmd_4c_Encerrar, "Click", THIS, "BtnEncerrarClick")

        *-- Grid de listagem (Top=117: 88+29 compensacao, Left=12 do original)
        loc_oPg1.AddObject("grd_4c_Lista", "Grid")
        loc_oGrid = loc_oPg1.grd_4c_Lista
        WITH loc_oGrid
            .Top                = 117
            .Left               = 12
            .Width              = 894
            .Height             = 455
            .DeleteMark         = .F.
            .RecordMark         = .F.
            .RowHeight          = 16
            .ScrollBars         = 2
            .GridLines          = 3
            .HighlightStyle     = 2
            .HighlightBackColor = RGB(255, 255, 255)
            .HighlightForeColor = RGB(15, 41, 104)
            .GridLineColor      = RGB(238, 238, 238)
            .BackColor          = RGB(255, 255, 255)
            .FontName           = "Tahoma"
            .FontSize           = 8
            .Visible            = .T.
        ENDWITH

        *-- ColumnCount FORA de WITH (Problema 36: colunas precisam existir antes de acessar)
        loc_oGrid.ColumnCount = 5

        WITH loc_oGrid
            .Column1.Width           = 50
            .Column1.Alignment       = 2
            .Column1.Header1.Caption = "C" + CHR(243) + "digo"
            .Column2.Width           = 450
            .Column2.Header1.Caption = "Descri" + CHR(231) + CHR(245) + "es"
            .Column3.Width           = 90
            .Column3.Alignment       = 2
            .Column3.Header1.Caption = "Pg.Comiss" + CHR(227) + "o"
            .Column4.Width           = 80
            .Column4.Header1.Caption = "Grupo"
            .Column5.Width           = 80
            .Column5.Header1.Caption = "Agrupam."
        ENDWITH

        THIS.TornarControlesVisiveis(loc_oPg1)
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPaginaDados - Fase 5/8: botoes Confirmar/Cancelar +
    * Row1 (Codigo/Grupo/Agrupas/MovAutDop) + Row2 (Observacao)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPaginaDados()
        LOCAL loc_oPg2, loc_oBotoesAcao
        loc_oPg2 = THIS.pgf_4c_Paginas.Page2

        *-- Container botoes Confirmar/Cancelar (Grupo_Salva.Left=819, Top=7+29=36)
        loc_oPg2.AddObject("cnt_4c_BotoesAcao", "Container")
        loc_oBotoesAcao = loc_oPg2.cnt_4c_BotoesAcao
        WITH loc_oBotoesAcao
            .Top         = 36
            .Left        = 819
            .Width       = 165
            .Height      = 85
            .BackStyle   = 0
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH

        *-- Botao Confirmar (salva.Left=5, Top=5)
        loc_oBotoesAcao.AddObject("cmd_4c_Confirmar", "CommandButton")
        WITH loc_oBotoesAcao.cmd_4c_Confirmar
            .Caption         = "Confirmar"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
            .PicturePosition = 13
            .Top             = 5
            .Left            = 5
            .Width           = 75
            .Height          = 75
            .BackColor       = RGB(255, 255, 255)
            .ForeColor       = RGB(90, 90, 90)
            .FontName        = "Tahoma"
            .FontSize        = 8
            .FontBold        = .T.
            .FontItalic      = .T.
            .Themes          = .F.
            .SpecialEffect   = 0
            .MousePointer    = 15
            .WordWrap        = .T.
            .AutoSize        = .F.
            .Visible         = .T.
        ENDWITH
        BINDEVENT(loc_oBotoesAcao.cmd_4c_Confirmar, "Click", THIS, "BtnSalvarClick")

        *-- Botao Cancelar (cancelar.Left=81, Top=5)
        loc_oBotoesAcao.AddObject("cmd_4c_Cancelar", "CommandButton")
        WITH loc_oBotoesAcao.cmd_4c_Cancelar
            .Caption         = "Encerrar"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_cancelar_60.jpg"
            .PicturePosition = 13
            .Top             = 5
            .Left            = 81
            .Width           = 75
            .Height          = 75
            .BackColor       = RGB(255, 255, 255)
            .ForeColor       = RGB(90, 90, 90)
            .FontName        = "Tahoma"
            .FontSize        = 8
            .FontBold        = .T.
            .FontItalic      = .T.
            .Themes          = .F.
            .SpecialEffect   = 0
            .MousePointer    = 15
            .WordWrap        = .T.
            .AutoSize        = .F.
            .Visible         = .T.
        ENDWITH
        BINDEVENT(loc_oBotoesAcao.cmd_4c_Cancelar, "Click", THIS, "BtnCancelarClick")

        *-- ===== ROW 1: Codigo | Grupo | Agrupamento | Movimentacao Automatica =====
        *-- Compensacao PageFrame.Top=-29: Tops originais + 29

        *-- Label Codigo (Say1: Left=55, Top=31 -> 60)
        loc_oPg2.AddObject("lbl_4c_Codigo", "Label")
        WITH loc_oPg2.lbl_4c_Codigo
            .Caption   = "C" + CHR(243) + "digo :"
            .Left      = 55
            .Top       = 60
            .Width     = 40
            .Height    = 17
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        *-- TextBox Codigos (Get_Codigos: Left=100, Top=28->57, Width=37, InputMask="999", numeric)
        loc_oPg2.AddObject("txt_4c_Codigos", "TextBox")
        WITH loc_oPg2.txt_4c_Codigos
            .Value         = 0
            .InputMask     = "999"
            .Alignment     = 3
            .Left          = 100
            .Top           = 57
            .Width         = 37
            .Height        = 23
            .FontName      = "Tahoma"
            .FontSize      = 8
            .ForeColor     = RGB(90, 90, 90)
            .SpecialEffect = 1
            .Visible       = .T.
        ENDWITH

        *-- Label Grupo (Say7: Left=154, Top=31 -> 60)
        loc_oPg2.AddObject("lbl_4c_Grupo", "Label")
        WITH loc_oPg2.lbl_4c_Grupo
            .Caption   = "Grupo :"
            .Left      = 154
            .Top       = 60
            .Width     = 37
            .Height    = 17
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        *-- TextBox Grupos (getGrupos: Left=194, Top=28->57, Width=80)
        loc_oPg2.AddObject("txt_4c_Grupos", "TextBox")
        WITH loc_oPg2.txt_4c_Grupos
            .Value         = ""
            .Left          = 194
            .Top           = 57
            .Width         = 80
            .Height        = 23
            .FontName      = "Tahoma"
            .FontSize      = 8
            .ForeColor     = RGB(90, 90, 90)
            .SpecialEffect = 1
            .Visible       = .T.
        ENDWITH

        *-- Label Agrupamento (Say8: Left=293, Top=32 -> 61)
        loc_oPg2.AddObject("lbl_4c_Agrupamento", "Label")
        WITH loc_oPg2.lbl_4c_Agrupamento
            .Caption   = "Agrupamento :"
            .Left      = 293
            .Top       = 61
            .Width     = 77
            .Height    = 17
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        *-- TextBox Agrupas (getAgrupas: Left=373, Top=28->57, Width=80, InputMask="!!!!!!!!!!")
        loc_oPg2.AddObject("txt_4c_Agrupas", "TextBox")
        WITH loc_oPg2.txt_4c_Agrupas
            .Value         = ""
            .InputMask     = "!!!!!!!!!!"
            .Left          = 373
            .Top           = 57
            .Width         = 80
            .Height        = 23
            .FontName      = "Tahoma"
            .FontSize      = 8
            .ForeColor     = RGB(90, 90, 90)
            .SpecialEffect = 1
            .Visible       = .T.
        ENDWITH

        *-- Label Movimentacao Automatica (Say3: Left=481, Top=32 -> 61)
        loc_oPg2.AddObject("lbl_4c_MovAut", "Label")
        WITH loc_oPg2.lbl_4c_MovAut
            .Caption   = "Movimenta" + CHR(231) + CHR(227) + "o Automatica :"
            .Left      = 481
            .Top       = 61
            .Width     = 133
            .Height    = 17
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        *-- TextBox MovAutDop (getMovAutDop: Left=621, Top=28->57, Width=192)
        *-- Lookup via cursor_4c_Nivel (SigCdOpe) no LostFocus
        loc_oPg2.AddObject("txt_4c_MovAutDop", "TextBox")
        WITH loc_oPg2.txt_4c_MovAutDop
            .Value         = ""
            .Left          = 621
            .Top           = 57
            .Width         = 192
            .Height        = 23
            .FontName      = "Tahoma"
            .FontSize      = 8
            .ForeColor     = RGB(90, 90, 90)
            .SpecialEffect = 1
            .Visible       = .T.
        ENDWITH
        BINDEVENT(loc_oPg2.txt_4c_MovAutDop, "KeyPress", THIS, "ValidarMovAutDop")

        *-- ===== ROW 2: Observacao (EditBox/memo) =====

        *-- Label Observacao (Say2: Left=30, Top=56 -> 85)
        loc_oPg2.AddObject("lbl_4c_Observacao", "Label")
        WITH loc_oPg2.lbl_4c_Observacao
            .Caption   = "Observa" + CHR(231) + CHR(227) + "o :"
            .Left      = 30
            .Top       = 85
            .Width     = 65
            .Height    = 17
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        *-- EditBox Observas (fwmemo_Observas: Left=100, Top=56->85, Width=713, Height=179)
        loc_oPg2.AddObject("edt_4c_Observas", "EditBox")
        WITH loc_oPg2.edt_4c_Observas
            .Value         = ""
            .Left          = 100
            .Top           = 85
            .Width         = 713
            .Height        = 179
            .FontName      = "Tahoma"
            .FontSize      = 8
            .ForeColor     = RGB(90, 90, 90)
            .SpecialEffect = 1
            .Visible       = .T.
        ENDWITH

        *-- ===== ROW 3: Descricao =====

        *-- Label Descricao (Say5: Left=42, Top=241 -> 270)
        loc_oPg2.AddObject("lbl_4c_Descricao", "Label")
        WITH loc_oPg2.lbl_4c_Descricao
            .Caption   = "Descri" + CHR(231) + CHR(227) + "o :"
            .Left      = 42
            .Top       = 270
            .Width     = 55
            .Height    = 17
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        *-- TextBox Descrs (getDescrs: Left=100, Top=238->267, Width=713, Height=23)
        loc_oPg2.AddObject("txt_4c_Descrs", "TextBox")
        WITH loc_oPg2.txt_4c_Descrs
            .Value         = ""
            .Left          = 100
            .Top           = 267
            .Width         = 713
            .Height        = 23
            .FontName      = "Tahoma"
            .FontSize      = 8
            .ForeColor     = RGB(90, 90, 90)
            .SpecialEffect = 1
            .Visible       = .T.
        ENDWITH

        *-- ===== ROW 4: Paga Comissao + Classificacao =====

        *-- Label Paga Comissao (Say4: Left=119, Top=272 -> 301)
        loc_oPg2.AddObject("lbl_4c_PagaComissao", "Label")
        WITH loc_oPg2.lbl_4c_PagaComissao
            .Caption   = "Paga Comiss" + CHR(227) + "o :"
            .Left      = 119
            .Top       = 301
            .Width     = 78
            .Height    = 17
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        *-- OptionGroup getPagaComiss (Left=200, Top=267->296, Width=96, Height=27, ButtonCount=2)
        loc_oPg2.AddObject("opt_4c_PagaComiss", "OptionGroup")
        *-- ButtonCount=2 FORA de WITH para garantir que Buttons(2) existe (analogia ColumnCount grid)
        loc_oPg2.opt_4c_PagaComiss.ButtonCount = 2
        WITH loc_oPg2.opt_4c_PagaComiss
            .AutoSize    = .F.
            .BackStyle   = 0
            .BorderStyle = 0
            .Height      = 27
            .Left        = 200
            .Top         = 296
            .Width       = 101
            .Value       = 1
            .Visible     = .T.
        ENDWITH
        WITH loc_oPg2.opt_4c_PagaComiss.Buttons(1)
            .Caption   = "Sim"
            .Height    = 17
            .Left      = 5
            .Top       = 5
            .Width     = 40
            .AutoSize  = .F.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
        ENDWITH
        WITH loc_oPg2.opt_4c_PagaComiss.Buttons(2)
            .Caption   = "N" + CHR(227) + "o"
            .Height    = 17
            .Left      = 51
            .Top       = 5
            .Width     = 40
            .AutoSize  = .F.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
        ENDWITH

        *-- Label Classificacao (Say6: Left=391, Top=272 -> 301)
        loc_oPg2.AddObject("lbl_4c_Classificacao", "Label")
        WITH loc_oPg2.lbl_4c_Classificacao
            .Caption   = "Classifica" + CHR(231) + CHR(227) + "o : "
            .Left      = 391
            .Top       = 301
            .Width     = 72
            .Height    = 17
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        *-- OptionGroup Opc_Classif (Left=465, Top=267->296, Width=200, Height=27, ButtonCount=3)
        loc_oPg2.AddObject("opt_4c_Classif", "OptionGroup")
        *-- ButtonCount=3 FORA de WITH para garantir que Buttons(3) existe (analogia ColumnCount grid)
        loc_oPg2.opt_4c_Classif.ButtonCount = 3
        WITH loc_oPg2.opt_4c_Classif
            .AutoSize    = .F.
            .BackStyle   = 0
            .BorderStyle = 0
            .Height      = 27
            .Left        = 465
            .Top         = 296
            .Width       = 205
            .Value       = 1
            .Visible     = .T.
        ENDWITH
        WITH loc_oPg2.opt_4c_Classif.Buttons(1)
            .Caption   = "Grave"
            .Height    = 15
            .Left      = 5
            .Top       = 5
            .Width     = 47
            .AutoSize  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
        ENDWITH
        WITH loc_oPg2.opt_4c_Classif.Buttons(2)
            .Caption   = "Leve"
            .Height    = 15
            .Left      = 75
            .Top       = 5
            .Width     = 41
            .AutoSize  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
        ENDWITH
        WITH loc_oPg2.opt_4c_Classif.Buttons(3)
            .Caption   = "Interno"
            .Height    = 17
            .Left      = 134
            .Top       = 5
            .Width     = 61
            .AutoSize  = .F.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
        ENDWITH

        *-- ===== CONTAINER COMANDOS ESPECIAIS =====
        *-- Container1: Left=121, Top=311->340, Width=671, Height=276, BackColor amarelo
        loc_oPg2.AddObject("cnt_4c_Container1", "Container")
        WITH loc_oPg2.cnt_4c_Container1
            .Top         = 340
            .Left        = 121
            .Width       = 671
            .Height      = 276
            .BackColor   = RGB(255, 253, 179)
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH

        *-- Say15: "Comandos Especiais:" (Bold, Left=13, Top=9)
        loc_oPg2.cnt_4c_Container1.AddObject("lbl_4c_CmdEsp", "Label")
        WITH loc_oPg2.cnt_4c_Container1.lbl_4c_CmdEsp
            .Caption   = "Comandos Especiais:"
            .Left      = 13
            .Top       = 9
            .Width     = 150
            .Height    = 17
            .FontName  = "Tahoma"
            .FontSize  = 9
            .FontBold  = .T.
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        *-- Say17: instrucao geral (Bold, Left=13, Top=29)
        loc_oPg2.cnt_4c_Container1.AddObject("lbl_4c_CmdInserir", "Label")
        WITH loc_oPg2.cnt_4c_Container1.lbl_4c_CmdInserir
            .Caption   = "Para inserir automaticamente em uma observa" + CHR(231) + CHR(227) + "o..."
            .Left      = 13
            .Top       = 29
            .Width     = 450
            .Height    = 17
            .FontName  = "Tahoma"
            .FontSize  = 9
            .FontBold  = .T.
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        *-- Say3: simbolo # (Left=50, Top=52)
        loc_oPg2.cnt_4c_Container1.AddObject("lbl_4c_CmdNumDoc", "Label")
        WITH loc_oPg2.cnt_4c_Container1.lbl_4c_CmdNumDoc
            .Caption   = "...o n" + CHR(250) + "mero do documento da opera" + CHR(231) + CHR(227) + "o utilizada indicar com o simbolo # "
            .Left      = 50
            .Top       = 52
            .Width     = 590
            .Height    = 17
            .FontName  = "Tahoma"
            .FontSize  = 9
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        *-- Say9: simbolo $ (Left=50, Top=72)
        loc_oPg2.cnt_4c_Container1.AddObject("lbl_4c_CmdSerieNota", "Label")
        WITH loc_oPg2.cnt_4c_Container1.lbl_4c_CmdSerieNota
            .Caption   = "...serie + Nota utilizada indicar com o simbolo $ "
            .Left      = 50
            .Top       = 72
            .Width     = 450
            .Height    = 17
            .FontName  = "Tahoma"
            .FontSize  = 9
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        *-- Say10: simbolo ^% (Left=50, Top=92)
        loc_oPg2.cnt_4c_Container1.AddObject("lbl_4c_CmdNota", "Label")
        WITH loc_oPg2.cnt_4c_Container1.lbl_4c_CmdNota
            .Caption   = "...dados da Nota do SubN" + CHR(237) + "vel indicar com o simbolo ^%"
            .Left      = 50
            .Top       = 92
            .Width     = 450
            .Height    = 17
            .FontName  = "Tahoma"
            .FontSize  = 9
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        *-- Say11: simbolo ^! (Left=50, Top=112)
        loc_oPg2.cnt_4c_Container1.AddObject("lbl_4c_CmdSubNivel", "Label")
        WITH loc_oPg2.cnt_4c_Container1.lbl_4c_CmdSubNivel
            .Caption   = "...a relacao dos SubN" + CHR(237) + "veis Utilizados indicar com o simbolo ^!"
            .Left      = 50
            .Top       = 112
            .Width     = 490
            .Height    = 17
            .FontName  = "Tahoma"
            .FontSize  = 9
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        *-- Say4: simbolo ^N! (Left=50, Top=131)
        loc_oPg2.cnt_4c_Container1.AddObject("lbl_4c_CmdSubNivelN", "Label")
        WITH loc_oPg2.cnt_4c_Container1.lbl_4c_CmdSubNivelN
            .Caption   = "...a relacao do SubN" + CHR(237) + "vel do SubN" + CHR(237) + "vel Utilizados indicar com o simbolo ^N!"
            .Left      = 50
            .Top       = 131
            .Width     = 560
            .Height    = 17
            .FontName  = "Tahoma"
            .FontSize  = 9
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        *-- Say12: simbolo @ (Left=50, Top=150)
        loc_oPg2.cnt_4c_Container1.AddObject("lbl_4c_CmdEnderecos", "Label")
        WITH loc_oPg2.cnt_4c_Container1.lbl_4c_CmdEnderecos
            .Caption   = "...dados de endere" + CHR(231) + "os, use o s" + CHR(237) + "mbolo @"
            .Left      = 50
            .Top       = 150
            .Width     = 400
            .Height    = 17
            .FontName  = "Tahoma"
            .FontSize  = 9
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        *-- Say13: simbolo ^V (Left=50, Top=170)
        loc_oPg2.cnt_4c_Container1.AddObject("lbl_4c_CmdVendedor", "Label")
        WITH loc_oPg2.cnt_4c_Container1.lbl_4c_CmdVendedor
            .Caption   = "...dados do vendedor, use o s" + CHR(237) + "mbolo ^V"
            .Left      = 50
            .Top       = 170
            .Width     = 400
            .Height    = 17
            .FontName  = "Tahoma"
            .FontSize  = 9
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        *-- Say14: simbolo ^$ (Left=50, Top=190)
        loc_oPg2.cnt_4c_Container1.AddObject("lbl_4c_CmdAlqRed", "Label")
        WITH loc_oPg2.cnt_4c_Container1.lbl_4c_CmdAlqRed
            .Caption   = "...mensagem para Al" + CHR(237) + "quota reduzida de ICMS, use o s" + CHR(237) + "mbolo ^$"
            .Left      = 50
            .Top       = 190
            .Width     = 500
            .Height    = 17
            .FontName  = "Tahoma"
            .FontSize  = 9
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        *-- Say16: simbolo ^D (Left=50, Top=210)
        loc_oPg2.cnt_4c_Container1.AddObject("lbl_4c_CmdDtVenc", "Label")
        WITH loc_oPg2.cnt_4c_Container1.lbl_4c_CmdDtVenc
            .Caption   = "...observa" + CHR(231) + CHR(227) + "o mensagem para Datas de Vencimento, use o s" + CHR(237) + "mbolo ^D"
            .Left      = 50
            .Top       = 210
            .Width     = 560
            .Height    = 17
            .FontName  = "Tahoma"
            .FontSize  = 9
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        *-- Say1: simbolo ^> (Left=50, Top=229)
        loc_oPg2.cnt_4c_Container1.AddObject("lbl_4c_CmdIcmsVal", "Label")
        WITH loc_oPg2.cnt_4c_Container1.lbl_4c_CmdIcmsVal
            .Caption   = "...valor do ICMS a recuperar para n" + CHR(227) + "o inscritos no Simples Nacional use o s" + CHR(237) + "mbolo ^>"
            .Left      = 50
            .Top       = 229
            .Width     = 600
            .Height    = 17
            .FontName  = "Tahoma"
            .FontSize  = 9
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        *-- Say2: simbolo ^< (Left=50, Top=249)
        loc_oPg2.cnt_4c_Container1.AddObject("lbl_4c_CmdIcmsAlq", "Label")
        WITH loc_oPg2.cnt_4c_Container1.lbl_4c_CmdIcmsAlq
            .Caption   = "...Al" + CHR(237) + "quota do ICMS a recuperar para n" + CHR(227) + "o inscritos no Simples Nacional use o s" + CHR(237) + "mbolo ^<"
            .Left      = 50
            .Top       = 249
            .Width     = 610
            .Height    = 17
            .FontName  = "Tahoma"
            .FontSize  = 9
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        THIS.TornarControlesVisiveis(loc_oPg2)
    ENDPROC

    *--------------------------------------------------------------------------
    * Destroy - Libera recursos
    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
        IF VARTYPE(THIS.this_oBusinessObject) = "O"
            THIS.this_oBusinessObject = .NULL.
        ENDIF

        IF USED("cursor_4c_Dados")
            USE IN cursor_4c_Dados
        ENDIF

        IF USED("cursor_4c_Nivel")
            USE IN cursor_4c_Nivel
        ENDIF

        DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    * TornarControlesVisiveis - Torna todos os controles visiveis recursivamente
    *--------------------------------------------------------------------------
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
    * CarregarLista - Carrega dados no grid da Page1 via ObsBO.Buscar()
    *--------------------------------------------------------------------------
    PROCEDURE CarregarLista()
        LOCAL loc_lResultado, loc_oGrid
        loc_lResultado = .F.

        TRY
            IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
                loc_lResultado = .T.
            ELSE
                IF !THIS.this_oBusinessObject.Buscar("")
                    loc_lResultado = .F.
                ELSE
                    loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Lista

                    *-- RecordSource e ColumnCount FORA de WITH (Problema 36)
                    loc_oGrid.ColumnCount = 5
                    loc_oGrid.RecordSource = "cursor_4c_Dados"
                    loc_oGrid.ColumnCount  = 5

                    *-- ControlSource APOS RecordSource (Problema 48)
                    loc_oGrid.Column1.ControlSource = "cursor_4c_Dados.Codigos"
                    loc_oGrid.Column2.ControlSource = "cursor_4c_Dados.Descrs"
                    loc_oGrid.Column3.ControlSource = "cursor_4c_Dados.PgComissao"
                    loc_oGrid.Column4.ControlSource = "cursor_4c_Dados.Grupos"
                    loc_oGrid.Column5.ControlSource = "cursor_4c_Dados.Agrupas"

                    *-- Larguras e Headers APOS RecordSource (Problema 32)
                    loc_oGrid.Column1.Width           = 50
                    loc_oGrid.Column1.Alignment       = 2
                    loc_oGrid.Column1.Header1.Caption = "C" + CHR(243) + "digo"
                    loc_oGrid.Column2.Width           = 450
                    loc_oGrid.Column2.Header1.Caption = "Descri" + CHR(231) + CHR(245) + "es"
                    loc_oGrid.Column3.Width           = 90
                    loc_oGrid.Column3.Alignment       = 2
                    loc_oGrid.Column3.Header1.Caption = "Pg.Comiss" + CHR(227) + "o"
                    loc_oGrid.Column4.Width           = 80
                    loc_oGrid.Column4.Header1.Caption = "Grupo"
                    loc_oGrid.Column5.Width           = 80
                    loc_oGrid.Column5.Header1.Caption = "Agrupam."

                    THIS.FormatarGridLista(loc_oGrid)
                    loc_lResultado = .T.
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "FormObs.CarregarLista")
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

        TRY
            IF VARTYPE(par_nPagina) = "N" AND par_nPagina >= 1 AND par_nPagina <= 2
                THIS.pgf_4c_Paginas.ActivePage = par_nPagina
                IF par_nPagina = 1
                    THIS.this_cModoAtual = "LISTA"
                    THIS.CarregarLista()
                ENDIF
                loc_lResultado = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "FormObs.AlternarPagina")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnEncerrarClick - Fecha o formulario
    *--------------------------------------------------------------------------
    PROCEDURE BtnEncerrarClick()
        THIS.Release()
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarMovAutDop - Valida Movimentacao Automatica ao sair do campo
    * Busca em cursor_4c_Nivel (SigCdOpe por Dopes); abre busca se nao encontrado
    * Handler PUBLIC para BINDEVENT (Problema 17)
    *--------------------------------------------------------------------------
    PROCEDURE ValidarMovAutDop
        LPARAMETERS par_nKeyCode, par_nShiftAltCtrl
        IF par_nKeyCode != 13 AND par_nKeyCode != 9 AND par_nKeyCode != 115
            RETURN
        ENDIF
        LOCAL loc_lResultado, loc_cValor, loc_oBusca
        loc_lResultado = .F.

        IF !INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
            RETURN .T.
        ENDIF

        TRY
            loc_cValor = ALLTRIM(THIS.pgf_4c_Paginas.Page2.txt_4c_MovAutDop.Value)

            IF EMPTY(loc_cValor)
                loc_lResultado = .T.
            ELSE
                IF USED("cursor_4c_Nivel")
                SELECT Dopes, Cmoes, nFiscals, Abrevs ;
                    FROM cursor_4c_Nivel ;
                    WHERE !EMPTY(ALLTRIM(Abrevs)) ;
                    INTO CURSOR cursor_4c_NivelSel READWRITE

                SELECT cursor_4c_NivelSel
                LOCATE FOR ALLTRIM(Dopes) = loc_cValor
                IF EOF()
                    loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
                    IF VARTYPE(loc_oBusca) = "O"
                        loc_oBusca.this_cCursorDestino = "cursor_4c_NivelSel"
                        loc_oBusca.this_cTitulo = "Opera" + CHR(231) + CHR(245) + "es"
                        loc_oBusca.mAddColuna("Dopes", "", "C" + CHR(243) + "digo")
                        loc_oBusca.Show()

                        IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_NivelSel")
                            THIS.pgf_4c_Paginas.Page2.txt_4c_MovAutDop.Value = ;
                                ALLTRIM(cursor_4c_NivelSel.Dopes)
                        ELSE
                            THIS.pgf_4c_Paginas.Page2.txt_4c_MovAutDop.Value = ""
                        ENDIF
                        loc_oBusca.Release()
                    ENDIF
                ENDIF

                IF USED("cursor_4c_NivelSel")
                    USE IN cursor_4c_NivelSel
                ENDIF

                loc_lResultado = .T.
            ELSE
                loc_lResultado = .T.
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "FormObs.ValidarMovAutDop")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * FormParaBO - Transfere valores do Form para o BO
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE FormParaBO()
        LOCAL loc_oPg2
        loc_oPg2 = THIS.pgf_4c_Paginas.Page2

        THIS.this_oBusinessObject.this_nCodigos   = loc_oPg2.txt_4c_Codigos.Value
        THIS.this_oBusinessObject.this_cDescrs    = ALLTRIM(loc_oPg2.txt_4c_Descrs.Value)
        THIS.this_oBusinessObject.this_cObservas  = loc_oPg2.edt_4c_Observas.Value
        THIS.this_oBusinessObject.this_cGrupos    = ALLTRIM(loc_oPg2.txt_4c_Grupos.Value)
        THIS.this_oBusinessObject.this_cAgrupas   = ALLTRIM(loc_oPg2.txt_4c_Agrupas.Value)
        THIS.this_oBusinessObject.this_cMovAutDop = ALLTRIM(loc_oPg2.txt_4c_MovAutDop.Value)
        THIS.this_oBusinessObject.this_nComiss    = loc_oPg2.opt_4c_PagaComiss.Value
        THIS.this_oBusinessObject.this_nClassifs  = loc_oPg2.opt_4c_Classif.Value
    ENDPROC

    *--------------------------------------------------------------------------
    * BOParaForm - Transfere valores do BO para o Form
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE BOParaForm()
        LOCAL loc_oPg2, loc_nComiss, loc_nClassifs
        loc_oPg2 = THIS.pgf_4c_Paginas.Page2

        loc_oPg2.txt_4c_Codigos.Value   = THIS.this_oBusinessObject.this_nCodigos
        loc_oPg2.txt_4c_Descrs.Value    = THIS.this_oBusinessObject.this_cDescrs
        loc_oPg2.edt_4c_Observas.Value  = THIS.this_oBusinessObject.this_cObservas
        loc_oPg2.txt_4c_Grupos.Value    = THIS.this_oBusinessObject.this_cGrupos
        loc_oPg2.txt_4c_Agrupas.Value   = THIS.this_oBusinessObject.this_cAgrupas
        loc_oPg2.txt_4c_MovAutDop.Value = THIS.this_oBusinessObject.this_cMovAutDop

        *-- Comiss=1=Sim(Button1), Comiss=2=Nao(Button2)
        loc_nComiss = THIS.this_oBusinessObject.this_nComiss
        loc_oPg2.opt_4c_PagaComiss.Value = IIF(loc_nComiss >= 1 AND loc_nComiss <= 2, loc_nComiss, 1)

        *-- Classifs: 1=Grave, 2=Leve, 3=Interno
        loc_nClassifs = THIS.this_oBusinessObject.this_nClassifs
        loc_oPg2.opt_4c_Classif.Value = IIF(loc_nClassifs >= 1 AND loc_nClassifs <= 3, loc_nClassifs, 1)
    ENDPROC

    *--------------------------------------------------------------------------
    * LimparCampos - Limpa todos os campos da Page2
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE LimparCampos()
        LOCAL loc_oPg2
        loc_oPg2 = THIS.pgf_4c_Paginas.Page2

        loc_oPg2.txt_4c_Codigos.Value    = 0
        loc_oPg2.txt_4c_Descrs.Value     = ""
        loc_oPg2.edt_4c_Observas.Value   = ""
        loc_oPg2.txt_4c_Grupos.Value     = ""
        loc_oPg2.txt_4c_Agrupas.Value    = ""
        loc_oPg2.txt_4c_MovAutDop.Value  = ""
        loc_oPg2.opt_4c_PagaComiss.Value = 1
        loc_oPg2.opt_4c_Classif.Value    = 1
    ENDPROC

    *--------------------------------------------------------------------------
    * HabilitarCampos - Habilita ou desabilita campos conforme modo
    * par_lHabilitar=.T. -> INCLUIR/ALTERAR; par_lHabilitar=.F. -> VISUALIZAR
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE HabilitarCampos(par_lHabilitar)
        LOCAL loc_oPg2
        loc_oPg2 = THIS.pgf_4c_Paginas.Page2

        *-- Codigo: somente editavel em INCLUIR (PK nao se altera em ALTERAR)
        loc_oPg2.txt_4c_Codigos.ReadOnly = !(par_lHabilitar AND THIS.this_cModoAtual = "INCLUIR")

        loc_oPg2.txt_4c_Descrs.ReadOnly    = !par_lHabilitar
        loc_oPg2.edt_4c_Observas.ReadOnly  = !par_lHabilitar
        loc_oPg2.txt_4c_Grupos.ReadOnly    = !par_lHabilitar
        loc_oPg2.txt_4c_Agrupas.ReadOnly   = !par_lHabilitar
        loc_oPg2.txt_4c_MovAutDop.ReadOnly = !par_lHabilitar

        loc_oPg2.opt_4c_PagaComiss.Enabled = par_lHabilitar
        loc_oPg2.opt_4c_Classif.Enabled    = par_lHabilitar

        *-- Confirmar: disponivel apenas em INCLUIR/ALTERAR
        loc_oPg2.cnt_4c_BotoesAcao.cmd_4c_Confirmar.Enabled = par_lHabilitar
    ENDPROC

    *--------------------------------------------------------------------------
    * AjustarBotoesPorModo - Ajusta estado dos botoes CRUD da Page1
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE AjustarBotoesPorModo()
        LOCAL loc_oPg1, loc_lTemRegistro
        loc_oPg1 = THIS.pgf_4c_Paginas.Page1

        loc_lTemRegistro = USED("cursor_4c_Dados") AND ;
                           RECCOUNT("cursor_4c_Dados") > 0 AND ;
                           !EOF("cursor_4c_Dados")

        loc_oPg1.cnt_4c_Botoes.cmd_4c_Incluir.Enabled    = .T.
        loc_oPg1.cnt_4c_Botoes.cmd_4c_Visualizar.Enabled = loc_lTemRegistro
        loc_oPg1.cnt_4c_Botoes.cmd_4c_Alterar.Enabled    = loc_lTemRegistro
        loc_oPg1.cnt_4c_Botoes.cmd_4c_Excluir.Enabled    = loc_lTemRegistro
        loc_oPg1.cnt_4c_Botoes.cmd_4c_Buscar.Enabled     = .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnIncluirClick - Inicia inclusao de novo registro
    * Handler PUBLIC para BINDEVENT (Problema 17)
    *--------------------------------------------------------------------------
    PROCEDURE BtnIncluirClick()
        THIS.this_oBusinessObject.NovoRegistro()
        THIS.LimparCampos()
        THIS.this_cModoAtual = "INCLUIR"
        THIS.HabilitarCampos(.T.)
        THIS.AlternarPagina(2)

        TRY
            THIS.pgf_4c_Paginas.Page2.txt_4c_Codigos.SetFocus()
        CATCH
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnAlterarClick - Carrega e abre registro selecionado para edicao
    * Foco vai para edt_4c_Observas (replica original: ALTERAR -> fwmemo_Observas)
    * Handler PUBLIC para BINDEVENT (Problema 17)
    *--------------------------------------------------------------------------
    PROCEDURE BtnAlterarClick()
        LOCAL loc_nCodigo
        loc_nCodigo = 0

        IF !USED("cursor_4c_Dados") OR RECCOUNT("cursor_4c_Dados") = 0 OR EOF("cursor_4c_Dados")
            MsgAviso("Selecione um registro para alterar.", "Alterar")
            RETURN
        ENDIF

        SELECT cursor_4c_Dados
        loc_nCodigo = cursor_4c_Dados.Codigos

        IF !THIS.this_oBusinessObject.CarregarPorCodigo(loc_nCodigo)
            MsgErro("Registro n" + CHR(227) + "o encontrado.", "Alterar")
            RETURN
        ENDIF

        THIS.this_oBusinessObject.EditarRegistro()
        THIS.this_cModoAtual = "ALTERAR"
        THIS.BOParaForm()
        THIS.HabilitarCampos(.T.)
        THIS.AlternarPagina(2)

        TRY
            THIS.pgf_4c_Paginas.Page2.edt_4c_Observas.SetFocus()
        CATCH
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnVisualizarClick - Carrega registro selecionado em modo leitura
    * Handler PUBLIC para BINDEVENT (Problema 17)
    *--------------------------------------------------------------------------
    PROCEDURE BtnVisualizarClick()
        LOCAL loc_nCodigo
        loc_nCodigo = 0

        IF !USED("cursor_4c_Dados") OR RECCOUNT("cursor_4c_Dados") = 0 OR EOF("cursor_4c_Dados")
            MsgAviso("Selecione um registro para visualizar.", "Visualizar")
            RETURN
        ENDIF

        SELECT cursor_4c_Dados
        loc_nCodigo = cursor_4c_Dados.Codigos

        IF !THIS.this_oBusinessObject.CarregarPorCodigo(loc_nCodigo)
            MsgErro("Registro n" + CHR(227) + "o encontrado.", "Visualizar")
            RETURN
        ENDIF

        THIS.this_cModoAtual = "VISUALIZAR"
        THIS.BOParaForm()
        THIS.HabilitarCampos(.F.)
        THIS.AlternarPagina(2)

        TRY
            THIS.pgf_4c_Paginas.Page2.cnt_4c_BotoesAcao.cmd_4c_Cancelar.SetFocus()
        CATCH
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnExcluirClick - Exclui registro selecionado apos confirmacao
    * Handler PUBLIC para BINDEVENT (Problema 17)
    *--------------------------------------------------------------------------
    PROCEDURE BtnExcluirClick()
        LOCAL loc_nCodigo

        IF !USED("cursor_4c_Dados") OR RECCOUNT("cursor_4c_Dados") = 0 OR EOF("cursor_4c_Dados")
            MsgAviso("Selecione um registro para excluir.", "Excluir")
            RETURN
        ENDIF

        SELECT cursor_4c_Dados
        loc_nCodigo = cursor_4c_Dados.Codigos

        IF !MsgConfirma("Confirma a exclus" + CHR(227) + "o da observa" + CHR(231) + ;
                CHR(227) + "o " + TRANSFORM(loc_nCodigo) + "?", "Excluir")
            RETURN
        ENDIF

        IF !THIS.this_oBusinessObject.CarregarPorCodigo(loc_nCodigo)
            MsgErro("Registro n" + CHR(227) + "o encontrado.", "Excluir")
            RETURN
        ENDIF

        IF THIS.this_oBusinessObject.Excluir()
            MsgInfo("Observa" + CHR(231) + CHR(227) + "o exclu" + CHR(237) + "da com sucesso!", "Excluir")
            THIS.CarregarLista()
            THIS.AjustarBotoesPorModo()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnBuscarClick - Modo PROCURAR: navega para Page2 com apenas Codigos editavel
    * Replica comportamento original (pcEscolha='PROCURAR' -> focus Get_Codigos)
    * Handler PUBLIC para BINDEVENT (Problema 17)
    *--------------------------------------------------------------------------
    PROCEDURE BtnBuscarClick()
        LOCAL loc_oPg2
        loc_oPg2 = THIS.pgf_4c_Paginas.Page2

        THIS.LimparCampos()
        THIS.this_cModoAtual = "PROCURAR"

        *-- Em PROCURAR: somente Codigos editavel para busca por codigo
        loc_oPg2.txt_4c_Codigos.ReadOnly           = .F.
        loc_oPg2.txt_4c_Descrs.ReadOnly            = .T.
        loc_oPg2.edt_4c_Observas.ReadOnly          = .T.
        loc_oPg2.txt_4c_Grupos.ReadOnly            = .T.
        loc_oPg2.txt_4c_Agrupas.ReadOnly           = .T.
        loc_oPg2.txt_4c_MovAutDop.ReadOnly         = .T.
        loc_oPg2.opt_4c_PagaComiss.Enabled         = .F.
        loc_oPg2.opt_4c_Classif.Enabled            = .F.
        loc_oPg2.cnt_4c_BotoesAcao.cmd_4c_Confirmar.Enabled = .T.

        THIS.AlternarPagina(2)

        TRY
            loc_oPg2.txt_4c_Codigos.SetFocus()
        CATCH
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnSalvarClick - Salva registro (INCLUIR/ALTERAR) ou localiza (PROCURAR)
    * Handler PUBLIC para BINDEVENT (Problema 17)
    *--------------------------------------------------------------------------
    PROCEDURE BtnSalvarClick()
        LOCAL loc_oPg2, loc_nCodigo, loc_nVerif

        *-- Modo PROCURAR: localizar codigo no grid e retornar para lista
        IF THIS.this_cModoAtual = "PROCURAR"
            loc_nCodigo = THIS.pgf_4c_Paginas.Page2.txt_4c_Codigos.Value
            IF loc_nCodigo > 0 AND USED("cursor_4c_Dados")
                SELECT cursor_4c_Dados
                LOCATE FOR Codigos = loc_nCodigo
                THIS.pgf_4c_Paginas.Page1.grd_4c_Lista.Refresh()
            ENDIF
            THIS.AlternarPagina(1)
            RETURN
        ENDIF

        *-- Modo VISUALIZAR: Confirmar nao deveria estar habilitado, mas por seguranca cancela
        IF THIS.this_cModoAtual = "VISUALIZAR"
            THIS.BtnCancelarClick()
            RETURN
        ENDIF

        loc_oPg2    = THIS.pgf_4c_Paginas.Page2
        loc_nCodigo = loc_oPg2.txt_4c_Codigos.Value

        *-- Validacoes ANTES do TRY/CATCH (Regra critica CLAUDE.md: NUNCA RETURN dentro de TRY)
        IF loc_nCodigo <= 0
            MsgAviso("Informe o c" + CHR(243) + "digo da observa" + CHR(231) + CHR(227) + "o.", "Salvar")
            loc_oPg2.txt_4c_Codigos.SetFocus()
            RETURN
        ENDIF

        IF EMPTY(ALLTRIM(loc_oPg2.txt_4c_Descrs.Value))
            MsgAviso("Informe a descri" + CHR(231) + CHR(227) + "o.", "Salvar")
            loc_oPg2.txt_4c_Descrs.SetFocus()
            RETURN
        ENDIF

        THIS.FormParaBO()

        IF THIS.this_oBusinessObject.Salvar()
            MsgInfo("Observa" + CHR(231) + CHR(227) + "o salva com sucesso!", "Salvar")
            THIS.AlternarPagina(1)
            THIS.AjustarBotoesPorModo()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnCancelarClick - Cancela edicao e retorna para lista
    * Handler PUBLIC para BINDEVENT (Problema 17)
    *--------------------------------------------------------------------------
    PROCEDURE BtnCancelarClick()
        THIS.LimparCampos()
        THIS.AlternarPagina(1)
        THIS.AjustarBotoesPorModo()
    ENDPROC

ENDDEFINE


### BO (C:\4c\projeto\app\classes\ObsBO.prg):
*====================================================================
* ObsBO.prg
*
* Business Object para Cadastro de Observacoes
* Tabela: SigCdObs
* Herda de: BusinessBase
*====================================================================

DEFINE CLASS ObsBO AS BusinessBase

    *-- Propriedades da entidade (mapeamento para tabela SigCdObs)
    this_nCodigos    = 0     && Codigos numeric(3,0) - PK
    this_cDescrs     = ""    && descrs  char
    this_cObservas   = ""    && Observas memo
    this_cGrupos     = ""    && grupos  char
    this_cAgrupas    = ""    && agrupas char
    this_nComiss     = 0     && Comiss  numeric (1=Sim, 2=Nao)
    this_nClassifs   = 0     && Classifs numeric (1=Grave, 2=Leve, 3=Interno)
    this_cMovAutDop  = ""    && MovAutDop char (lookup SigCdOpe.Dopes)

    *====================================================================
    * Init - Inicializa Business Object
    *====================================================================
    PROCEDURE Init()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            DODEFAULT()
            THIS.this_cTabela     = "SigCdObs"
            THIS.this_cCampoChave = "Codigos"
            loc_lSucesso = .T.
        CATCH TO loException
            MostrarErro(loException, "ObsBO.Init")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * ObterChavePrimaria - Retorna valor da PK para auditoria (PUBLIC)
    *====================================================================
    FUNCTION ObterChavePrimaria()
        RETURN TRANSFORM(THIS.this_nCodigos)
    ENDFUNC

    *====================================================================
    * Buscar - Carrega lista de registros no cursor_4c_Dados (PUBLIC)
    * par_cFiltro: condicao WHERE sem "WHERE" (pode ser "")
    *====================================================================
    FUNCTION Buscar(par_cFiltro)
        LOCAL loc_cSQL, loc_cWhere, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cWhere = ""
            IF VARTYPE(par_cFiltro) = "C" AND !EMPTY(ALLTRIM(par_cFiltro))
                loc_cWhere = " WHERE " + par_cFiltro
            ENDIF

            loc_cSQL = "SELECT Codigos, Descrs," + ;
                       " CASE WHEN Comiss = 2 THEN 'NAO' ELSE 'SIM' END AS PgComissao," + ;
                       " Grupos, Agrupas" + ;
                       " FROM SigCdObs" + ;
                       loc_cWhere + ;
                       " ORDER BY Codigos"

            IF USED("cursor_4c_Dados")
                USE IN cursor_4c_Dados
            ENDIF

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")

            IF loc_nResultado >= 0
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao buscar observa" + CHR(231) + CHR(245) + "es:" + CHR(13) + ;
                        CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loException
            MostrarErro(loException, "ObsBO.Buscar")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *====================================================================
    * CarregarPorCodigo - Carrega registro pelo codigo (PUBLIC)
    *====================================================================
    FUNCTION CarregarPorCodigo(par_nCodigo)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "SELECT Codigos, Descrs, Observas, Comiss, Classifs," + ;
                       " Grupos, Agrupas, MovAutDop" + ;
                       " FROM SigCdObs" + ;
                       " WHERE Codigos = " + FormatarNumeroSQL(par_nCodigo)

            IF USED("cursor_4c_Carrega")
                USE IN cursor_4c_Carrega
            ENDIF

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")

            IF loc_nResultado >= 0 AND RECCOUNT("cursor_4c_Carrega") > 0
                loc_lSucesso = THIS.CarregarDoCursor("cursor_4c_Carrega")
                THIS.this_lNovoRegistro = .F.
            ELSE
                IF loc_nResultado < 0
                    MsgErro("Erro ao carregar observa" + CHR(231) + CHR(227) + "o:" + CHR(13) + ;
                            CapturarErroSQL(), "Erro SQL")
                ENDIF
            ENDIF
        CATCH TO loException
            MostrarErro(loException, "ObsBO.CarregarPorCodigo")
        ENDTRY

        IF USED("cursor_4c_Carrega")
            USE IN cursor_4c_Carrega
        ENDIF

        RETURN loc_lSucesso
    ENDFUNC

    *====================================================================
    * CarregarDoCursor - Popula propriedades a partir de cursor (PROTECTED)
    *====================================================================
    PROTECTED FUNCTION CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF USED(par_cAliasCursor)
                SELECT (par_cAliasCursor)
                THIS.this_nCodigos   = TratarNulo(codigos,   "N")
                THIS.this_cDescrs    = TratarNulo(descrs,    "C")
                THIS.this_cObservas  = TratarNulo(observas,  "C")
                THIS.this_cGrupos    = TratarNulo(grupos,    "C")
                THIS.this_cAgrupas   = TratarNulo(agrupas,   "C")
                THIS.this_nComiss    = TratarNulo(comiss,    "N")
                THIS.this_nClassifs  = TratarNulo(classifs,  "N")
                THIS.this_cMovAutDop = TratarNulo(movautdop, "C")
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loException
            MostrarErro(loException, "ObsBO.CarregarDoCursor")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *====================================================================
    * Inserir - Insere novo registro na tabela (PROTECTED)
    * Chamado por BusinessBase.Salvar() quando this_lNovoRegistro=.T.
    *====================================================================
    PROTECTED FUNCTION Inserir()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "INSERT INTO SigCdObs" + ;
                       " (Codigos, Descrs, Observas, Comiss, Classifs," + ;
                       "  Grupos, Agrupas, MovAutDop)" + ;
                       " VALUES (" + ;
                       FormatarNumeroSQL(THIS.this_nCodigos) + ", " + ;
                       EscaparSQL(THIS.this_cDescrs) + ", " + ;
                       EscaparSQL(THIS.this_cObservas) + ", " + ;
                       FormatarNumeroSQL(THIS.this_nComiss) + ", " + ;
                       FormatarNumeroSQL(THIS.this_nClassifs) + ", " + ;
                       EscaparSQL(THIS.this_cGrupos) + ", " + ;
                       EscaparSQL(THIS.this_cAgrupas) + ", " + ;
                       EscaparSQL(THIS.this_cMovAutDop) + ")"

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("INSERT")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao inserir observa" + CHR(231) + CHR(227) + "o:" + CHR(13) + ;
                        CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loException
            MostrarErro(loException, "ObsBO.Inserir")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *====================================================================
    * Atualizar - Atualiza registro existente (PROTECTED)
    * Chamado por BusinessBase.Salvar() quando this_lNovoRegistro=.F.
    *====================================================================
    PROTECTED FUNCTION Atualizar()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "UPDATE SigCdObs SET" + ;
                       " Descrs    = " + EscaparSQL(THIS.this_cDescrs) + "," + ;
                       " Observas  = " + EscaparSQL(THIS.this_cObservas) + "," + ;
                       " Comiss    = " + FormatarNumeroSQL(THIS.this_nComiss) + "," + ;
                       " Classifs  = " + FormatarNumeroSQL(THIS.this_nClassifs) + "," + ;
                       " Grupos    = " + EscaparSQL(THIS.this_cGrupos) + "," + ;
                       " Agrupas   = " + EscaparSQL(THIS.this_cAgrupas) + "," + ;
                       " MovAutDop = " + EscaparSQL(THIS.this_cMovAutDop) + ;
                       " WHERE Codigos = " + FormatarNumeroSQL(THIS.this_nCodigos)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("UPDATE")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao atualizar observa" + CHR(231) + CHR(227) + "o:" + CHR(13) + ;
                        CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loException
            MostrarErro(loException, "ObsBO.Atualizar")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *====================================================================
    * ExecutarExclusao - Remove registro da tabela (PROTECTED)
    * Chamado internamente por BusinessBase.Excluir()
    *====================================================================
    PROTECTED FUNCTION ExecutarExclusao()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "DELETE FROM SigCdObs" + ;
                       " WHERE Codigos = " + FormatarNumeroSQL(THIS.this_nCodigos)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("DELETE")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao excluir observa" + CHR(231) + CHR(227) + "o:" + CHR(13) + ;
                        CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loException
            MostrarErro(loException, "ObsBO.ExecutarExclusao")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *====================================================================
    * BuscarOperacoesNivel - Carrega cursor para lookup de MovAutDop (PUBLIC)
    * Equivalente ao: Select Dopes,Cmoes,nFiscals,Abrevs From SigCdOpe
    * Usado pelo Form para popular o lookup de Movimentacao Automatica
    *====================================================================
    FUNCTION BuscarOperacoesNivel()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF USED("cursor_4c_Nivel")
                USE IN cursor_4c_Nivel
            ENDIF

            loc_cSQL = "SELECT Dopes, Cmoes, NFiscals, Abrevs" + ;
                       " FROM SigCdOpe" + ;
                       " WHERE LTRIM(RTRIM(Abrevs)) <> ''" + ;
                       " ORDER BY Dopes"

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Nivel")

            IF loc_nResultado >= 0
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao carregar opera" + CHR(231) + CHR(245) + "es:" + CHR(13) + ;
                        CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loException
            MostrarErro(loException, "ObsBO.BuscarOperacoesNivel")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

ENDDEFINE


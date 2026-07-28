# CORRIGIR ERRO DE RUNTIME VFP9

## TAREFA OBRIGATORIA
O formulario VFP9 apresentou erro de runtime durante teste automatizado.
Voce DEVE corrigir o erro e salvar os arquivos corrigidos usando Write tool.

## ERRO DETECTADO
- Etapa: 06b_testeAutomatico
- Tentativa: 2/10
- Mensagem: Testes automaticos: 89% < 100%. Falhas: Teste 'CarregarLista': Nenhum cursor padrao foi criado (cursor_4c_Dados/Lista/Busca/etc)

## CONTEXTO DO ERRO

### ERROS CAPTURADOS EM MODO TESTE (vfp_error_details.txt):
[21/07/2026 18:33:14] Erro: Erro ao buscar tipos de árvore:Connection handle is invalid.
[21/07/2026 18:33:14] Erro: Erro ao buscar tipos de árvore:Connection handle is invalid.


### LOG DA ETAPA (06b_testeAutomatico):
[2026-07-21 18:30:32] [INFO] === VFP EXECUTOR v2.0 ===
[2026-07-21 18:30:32] [INFO] Config FPW: (nao fornecido)
[2026-07-21 18:30:32] [INFO] Script PRG: C:\4c\projeto\app\utils\TesteAutomatico.prg
[2026-07-21 18:30:32] [INFO] Timeout: 300 segundos
[2026-07-21 18:30:32] [INFO] Wrapper PRG criado para parametros: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_go5v3bpv.prg
[2026-07-21 18:30:32] [INFO] Conteudo do wrapper:
[2026-07-21 18:30:32] [INFO] * Auto-generated wrapper for parameters
* Script: C:\4c\projeto\app\utils\TesteAutomatico.prg
* Parameters: 'FormARV', 'C:\4c\tasks\task347', 'CRUD'

* Anti-dialog protections for unattended execution
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
SET NOTIFY OFF
SYS(2335, 0)

DO "C:\4c\projeto\app\utils\TesteAutomatico" WITH 'FormARV', 'C:\4c\tasks\task347', 'CRUD'
QUIT

[2026-07-21 18:30:32] [INFO] Comando VFP: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_go5v3bpv.prg
[2026-07-21 18:30:32] [INFO] VFP output esperado em: C:\4c\tasks\task347\vfp_output.txt
[2026-07-21 18:30:32] [INFO] Executando Visual FoxPro 9...
[2026-07-21 18:30:32] [INFO] Comando completo: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_go5v3bpv.prg
[2026-07-21 18:30:32] [INFO] Executando: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_go5v3bpv.prg
[2026-07-21 18:30:32] [INFO] Timeout configurado: 300 segundos
[2026-07-21 18:31:08] [INFO] VFP9 finalizou normalmente com exit code: 
[2026-07-21 18:31:08] [INFO] VFP9 finalizado em 36.2517607 segundos
[2026-07-21 18:31:08] [INFO] Exit Code: 
[2026-07-21 18:31:08] [INFO] 
[2026-07-21 18:31:08] [INFO] Arquivos temporarios preservados para inspecao:
[2026-07-21 18:31:08] [INFO]   Wrapper.prg: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_go5v3bpv.prg
[2026-07-21 18:31:08] [INFO] 
[2026-07-21 18:31:08] [INFO] === Conteudo do Wrapper.prg temporario ===
[2026-07-21 18:31:08] [INFO] * Auto-generated wrapper for parameters
[2026-07-21 18:31:08] [INFO] * Script: C:\4c\projeto\app\utils\TesteAutomatico.prg
[2026-07-21 18:31:08] [INFO] * Parameters: 'FormARV', 'C:\4c\tasks\task347', 'CRUD'
[2026-07-21 18:31:08] [INFO] 
[2026-07-21 18:31:08] [INFO] * Anti-dialog protections for unattended execution
[2026-07-21 18:31:08] [INFO] SET SAFETY OFF
[2026-07-21 18:31:08] [INFO] SET RESOURCE OFF
[2026-07-21 18:31:08] [INFO] SET TALK OFF
[2026-07-21 18:31:08] [INFO] SET NOTIFY OFF
[2026-07-21 18:31:08] [INFO] SYS(2335, 0)
[2026-07-21 18:31:08] [INFO] 
[2026-07-21 18:31:08] [INFO] DO "C:\4c\projeto\app\utils\TesteAutomatico" WITH 'FormARV', 'C:\4c\tasks\task347', 'CRUD'
[2026-07-21 18:31:08] [INFO] QUIT
[2026-07-21 18:31:08] [INFO] 
[2026-07-21 18:31:08] [INFO] === Fim do Wrapper.prg ===
[2026-07-21 18:31:08] [WARN] AVISO: VFP9 retornou exit code  (normal para VFP9 GUI - validar pelo arquivo de saida)
[2026-07-21 18:32:35] [INFO] === VFP EXECUTOR v2.0 ===
[2026-07-21 18:32:35] [INFO] Config FPW: (nao fornecido)
[2026-07-21 18:32:35] [INFO] Script PRG: C:\4c\projeto\app\utils\TesteAutomatico.prg
[2026-07-21 18:32:35] [INFO] Timeout: 300 segundos
[2026-07-21 18:32:35] [INFO] Wrapper PRG criado para parametros: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_cekeaecj.prg
[2026-07-21 18:32:35] [INFO] Conteudo do wrapper:
[2026-07-21 18:32:35] [INFO] * Auto-generated wrapper for parameters
* Script: C:\4c\projeto\app\utils\TesteAutomatico.prg
* Parameters: 'FormARV', 'C:\4c\tasks\task347', 'CRUD'

* Anti-dialog protections for unattended execution
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
SET NOTIFY OFF
SYS(2335, 0)

DO "C:\4c\projeto\app\utils\TesteAutomatico" WITH 'FormARV', 'C:\4c\tasks\task347', 'CRUD'
QUIT

[2026-07-21 18:32:35] [INFO] Comando VFP: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_cekeaecj.prg
[2026-07-21 18:32:35] [INFO] VFP output esperado em: C:\4c\tasks\task347\vfp_output.txt
[2026-07-21 18:32:35] [INFO] Executando Visual FoxPro 9...
[2026-07-21 18:32:35] [INFO] Comando completo: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_cekeaecj.prg
[2026-07-21 18:32:35] [INFO] Executando: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_cekeaecj.prg
[2026-07-21 18:32:35] [INFO] Timeout configurado: 300 segundos
[2026-07-21 18:33:14] [INFO] VFP9 finalizou normalmente com exit code: 
[2026-07-21 18:33:14] [INFO] VFP9 finalizado em 39.1245262 segundos
[2026-07-21 18:33:14] [INFO] Exit Code: 
[2026-07-21 18:33:14] [INFO] 
[2026-07-21 18:33:14] [INFO] Arquivos temporarios preservados para inspecao:
[2026-07-21 18:33:14] [INFO]   Wrapper.prg: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_cekeaecj.prg
[2026-07-21 18:33:14] [INFO] 
[2026-07-21 18:33:14] [INFO] === Conteudo do Wrapper.prg temporario ===
[2026-07-21 18:33:14] [INFO] * Auto-generated wrapper for parameters
[2026-07-21 18:33:14] [INFO] * Script: C:\4c\projeto\app\utils\TesteAutomatico.prg
[2026-07-21 18:33:14] [INFO] * Parameters: 'FormARV', 'C:\4c\tasks\task347', 'CRUD'
[2026-07-21 18:33:14] [INFO] 
[2026-07-21 18:33:14] [INFO] * Anti-dialog protections for unattended execution
[2026-07-21 18:33:14] [INFO] SET SAFETY OFF
[2026-07-21 18:33:14] [INFO] SET RESOURCE OFF
[2026-07-21 18:33:14] [INFO] SET TALK OFF
[2026-07-21 18:33:14] [INFO] SET NOTIFY OFF
[2026-07-21 18:33:14] [INFO] SYS(2335, 0)
[2026-07-21 18:33:14] [INFO] 
[2026-07-21 18:33:14] [INFO] DO "C:\4c\projeto\app\utils\TesteAutomatico" WITH 'FormARV', 'C:\4c\tasks\task347', 'CRUD'
[2026-07-21 18:33:14] [INFO] QUIT
[2026-07-21 18:33:14] [INFO] 
[2026-07-21 18:33:14] [INFO] === Fim do Wrapper.prg ===
[2026-07-21 18:33:14] [WARN] AVISO: VFP9 retornou exit code  (normal para VFP9 GUI - validar pelo arquivo de saida)


### RESULTADO DOS TESTES (teste_resultado.json):
{
  "formClass": "FormARV",
  "timestamp": "20260721183314",
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
      "passou": true,
      "erro": "",
      "detalhes": "Modo VISUALIZAR configurado"
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

### FORM (C:\4c\projeto\app\forms\cadastros\FormARV.prg):
*==============================================================================
* FormARV.prg - Fase 7/8: Form - Eventos Principais
* Formulario de Cadastro de Tipos de Arvore (SIGCDARV)
*
* Tabela: SigCdArv
* Tipo: CRUD (frmcadastro)
* BO: ARVBO
*==============================================================================

DEFINE CLASS FormARV AS FormBase

    *-- Propriedades visuais (PILAR 1 - UX FIDELITY)
    Height      = 600
    Width       = 1000
    Caption     = "Tipos de " + CHR(193) + "rvore"
    AutoCenter  = .T.
    ShowWindow  = 1
    WindowType  = 1
    ControlBox  = .F.
    Closable    = .F.
    MaxButton   = .F.
    TitleBar    = 0
    Themes      = .F.
    BorderStyle = 2

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
            MsgErro(loc_oErro.Message, "FormARV.Init")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * InicializarForm - Configura estrutura basica do form
    * Chamado automaticamente pelo FormBase.Init()
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lResultado
        loc_lResultado = .F.

        TRY
            THIS.this_oBusinessObject = CREATEOBJECT("ARVBO")

            IF VARTYPE(THIS.this_oBusinessObject) != "O"
                MsgErro("Falha ao criar ARVBO", "Erro")
            ELSE
                THIS.ConfigurarPageFrame()

                THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
                THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption

                THIS.pgf_4c_Paginas.Visible    = .T.
                THIS.pgf_4c_Paginas.ActivePage = 1
                THIS.this_cModoAtual = "LISTA"

                IF TYPE("gb_4c_ValidandoUI") != "L" OR !gb_4c_ValidandoUI
                    THIS.CarregarLista()
                ENDIF

                loc_lResultado = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "FormARV.InicializarForm")
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
    * ConfigurarPaginaLista - Cria containers da Page1 (Lista) com grid e botoes
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPaginaLista()
        LOCAL loc_oPg1, loc_oCab, loc_oBotoes, loc_oSaida, loc_oGrid
        loc_oPg1 = THIS.pgf_4c_Paginas.Page1

        *-- Cabecalho cinza (Top = 2+29 = 31, compensacao PageFrame.Top=-29)
        loc_oPg1.AddObject("cnt_4c_Cabecalho", "Container")
        loc_oCab = loc_oPg1.cnt_4c_Cabecalho
        WITH loc_oCab
            .Top         = 31
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

        *-- Container botoes CRUD (canonico: Top=29, Left=542, Width=390)
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
            .Top    = 5
            .Left   = 5
            .Width  = 75
            .Height = 75
            .FontName = "Tahoma"
            .FontSize = 8
            .FontBold   = .T.
            .FontItalic = .T.
            .ForeColor = RGB(90,90,90)
            .BackColor = RGB(255,255,255)
            .Themes        = .F.
            .SpecialEffect = 0
            .MousePointer = 15
            .WordWrap     = .T.
            .AutoSize     = .F.
            .Visible = .T.
        ENDWITH

        *-- Botao Visualizar
        loc_oBotoes.AddObject("cmd_4c_Visualizar", "CommandButton")
        WITH loc_oBotoes.cmd_4c_Visualizar
            .Caption         = "Visualizar"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_vizualizar_60.jpg"
            .PicturePosition = 13
            .Top    = 5
            .Left   = 80
            .Width  = 75
            .Height = 75
            .FontName = "Tahoma"
            .FontSize = 8
            .FontBold   = .T.
            .FontItalic = .T.
            .ForeColor = RGB(90,90,90)
            .BackColor = RGB(255,255,255)
            .Themes        = .F.
            .SpecialEffect = 0
            .MousePointer = 15
            .WordWrap     = .T.
            .AutoSize     = .F.
            .Visible = .T.
        ENDWITH

        *-- Botao Alterar
        loc_oBotoes.AddObject("cmd_4c_Alterar", "CommandButton")
        WITH loc_oBotoes.cmd_4c_Alterar
            .Caption         = "Alterar"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_alterar_60.jpg"
            .PicturePosition = 13
            .Top    = 5
            .Left   = 155
            .Width  = 75
            .Height = 75
            .FontName = "Tahoma"
            .FontSize = 8
            .FontBold   = .T.
            .FontItalic = .T.
            .ForeColor = RGB(90,90,90)
            .BackColor = RGB(255,255,255)
            .Themes        = .F.
            .SpecialEffect = 0
            .MousePointer = 15
            .WordWrap     = .T.
            .AutoSize     = .F.
            .Visible = .T.
        ENDWITH

        *-- Botao Excluir
        loc_oBotoes.AddObject("cmd_4c_Excluir", "CommandButton")
        WITH loc_oBotoes.cmd_4c_Excluir
            .Caption         = "Excluir"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_excluir_60.jpg"
            .PicturePosition = 13
            .Top    = 5
            .Left   = 230
            .Width  = 75
            .Height = 75
            .FontName = "Tahoma"
            .FontSize = 8
            .FontBold   = .T.
            .FontItalic = .T.
            .ForeColor = RGB(90,90,90)
            .BackColor = RGB(255,255,255)
            .Themes        = .F.
            .SpecialEffect = 0
            .MousePointer = 15
            .WordWrap     = .T.
            .AutoSize     = .F.
            .Visible = .T.
        ENDWITH

        *-- Botao Buscar
        loc_oBotoes.AddObject("cmd_4c_Buscar", "CommandButton")
        WITH loc_oBotoes.cmd_4c_Buscar
            .Caption         = "Buscar"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_procurar_60.jpg"
            .PicturePosition = 13
            .Top    = 5
            .Left   = 305
            .Width  = 75
            .Height = 75
            .FontName = "Tahoma"
            .FontSize = 8
            .FontBold   = .T.
            .FontItalic = .T.
            .ForeColor = RGB(90,90,90)
            .BackColor = RGB(255,255,255)
            .Themes        = .F.
            .SpecialEffect = 0
            .MousePointer = 15
            .WordWrap     = .T.
            .AutoSize     = .F.
            .Visible = .T.
        ENDWITH

        *-- Container Encerrar (canonico: Left=917, Width=90)
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

        *-- Botao Encerrar (canonico)
        loc_oSaida.AddObject("cmd_4c_Encerrar", "CommandButton")
        WITH loc_oSaida.cmd_4c_Encerrar
            .Caption         = "Encerrar"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
            .PicturePosition = 13
            .Top    = 5
            .Left   = 5
            .Width  = 75
            .Height = 75
            .FontName = "Tahoma"
            .FontSize = 8
            .FontBold   = .T.
            .FontItalic = .T.
            .ForeColor = RGB(90,90,90)
            .BackColor = RGB(255,255,255)
            .Themes        = .F.
            .SpecialEffect = 0
            .MousePointer = 15
            .WordWrap     = .T.
            .AutoSize     = .F.
            .Visible = .T.
        ENDWITH

        *-- Grid de listagem
        loc_oPg1.AddObject("grd_4c_Lista", "Grid")
        loc_oGrid = loc_oPg1.grd_4c_Lista
        WITH loc_oGrid
            .Top                = 117
            .Left               = 26
            .Width              = 890
            .Height             = 498
            .FontName           = "Verdana"
            .FontSize           = 8
            .ForeColor          = RGB(90, 90, 90)
            .BackColor          = RGB(255, 255, 255)
            .GridLineColor      = RGB(238, 238, 238)
            .GridLines          = 3
            .HighlightBackColor = RGB(255, 255, 255)
            .HighlightForeColor = RGB(15, 41, 104)
            .HighlightStyle     = 2
            .DeleteMark         = .F.
            .RecordMark         = .F.
            .RowHeight          = 16
            .ScrollBars         = 2
            .Visible            = .T.
        ENDWITH
        loc_oGrid.ColumnCount              = 2
        loc_oGrid.Column1.Width            = 80
        loc_oGrid.Column1.Header1.Caption  = "C" + CHR(243) + "digos"
        loc_oGrid.Column2.Width            = 290
        loc_oGrid.Column2.Header1.Caption  = "Descri" + CHR(231) + CHR(227) + "o"

        *-- BINDEVENT botoes Page1
        BINDEVENT(loc_oBotoes.cmd_4c_Incluir,    "Click", THIS, "BtnIncluirClick")
        BINDEVENT(loc_oBotoes.cmd_4c_Visualizar, "Click", THIS, "BtnVisualizarClick")
        BINDEVENT(loc_oBotoes.cmd_4c_Alterar,    "Click", THIS, "BtnAlterarClick")
        BINDEVENT(loc_oBotoes.cmd_4c_Excluir,    "Click", THIS, "BtnExcluirClick")
        BINDEVENT(loc_oBotoes.cmd_4c_Buscar,     "Click", THIS, "BtnBuscarClick")
        BINDEVENT(loc_oSaida.cmd_4c_Encerrar,    "Click", THIS, "BtnEncerrarClick")
        BINDEVENT(loc_oGrid,                      "DblClick", THIS, "BtnVisualizarClick")

        THIS.TornarControlesVisiveis(loc_oPg1)
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPaginaDados - Page2 (Dados): Salva + campos Parte 1/2 (Fase 5)
    * Coordenadas: Top_original + 29 (compensacao PageFrame.Top=-29)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPaginaDados()
        LOCAL loc_oPg2, loc_oSalva
        loc_oPg2 = THIS.pgf_4c_Paginas.Page2

        *-- Container botoes Confirmar/Cancelar (canonico: Top=33, Left=842)
        loc_oPg2.AddObject("cnt_4c_Salva", "Container")
        loc_oSalva = loc_oPg2.cnt_4c_Salva
        WITH loc_oSalva
            .Top         = 33
            .Left        = 842
            .Width       = 160
            .Height      = 85
            .BackStyle   = 0
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH

        *-- Botao Confirmar
        loc_oSalva.AddObject("cmd_4c_Confirmar", "CommandButton")
        WITH loc_oSalva.cmd_4c_Confirmar
            .Caption         = "Confirmar"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
            .PicturePosition = 13
            .Top    = 5
            .Left   = 5
            .Width  = 75
            .Height = 75
            .FontName = "Tahoma"
            .FontSize = 8
            .FontBold   = .T.
            .FontItalic = .T.
            .ForeColor = RGB(90,90,90)
            .BackColor = RGB(255,255,255)
            .Themes        = .F.
            .SpecialEffect = 0
            .MousePointer = 15
            .WordWrap     = .T.
            .AutoSize     = .F.
            .Visible = .T.
        ENDWITH

        *-- Botao Cancelar
        loc_oSalva.AddObject("cmd_4c_Cancelar", "CommandButton")
        WITH loc_oSalva.cmd_4c_Cancelar
            .Caption         = "Encerrar"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_cancelar_60.jpg"
            .PicturePosition = 13
            .Top    = 5
            .Left   = 80
            .Width  = 75
            .Height = 75
            .FontName = "Tahoma"
            .FontSize = 8
            .FontBold   = .T.
            .FontItalic = .T.
            .ForeColor = RGB(90,90,90)
            .BackColor = RGB(255,255,255)
            .Themes        = .F.
            .SpecialEffect = 0
            .MousePointer = 15
            .WordWrap     = .T.
            .AutoSize     = .F.
            .Visible = .T.
        ENDWITH

        BINDEVENT(loc_oSalva.cmd_4c_Confirmar, "Click", THIS, "BtnSalvarClick")
        BINDEVENT(loc_oSalva.cmd_4c_Cancelar,  "Click", THIS, "BtnCancelarClick")

        *----------------------------------------------------------------------
        *-- CAMPOS PARTE 1/2 ? Say1/get_Cod, Say2/get_descs, Say3/get_formula,
        *--                     Label7/get_perc/Label8, Label1 (Fundicao)
        *----------------------------------------------------------------------

        *-- Label "Codigo :" (Say1, top 171+29=200)
        loc_oPg2.AddObject("lbl_4c_Codigo", "Label")
        WITH loc_oPg2.lbl_4c_Codigo
            .Caption   = "C" + CHR(243) + "digo :"
            .Top       = 200
            .Left      = 61
            .Width     = 50
            .Height    = 17
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(255, 255, 255)
            .BackStyle = 0
            .AutoSize  = .F.
            .Visible   = .T.
        ENDWITH

        *-- TextBox Codigos (get_Cod, top 168+29=197)
        loc_oPg2.AddObject("txt_4c_Codigos", "TextBox")
        WITH loc_oPg2.txt_4c_Codigos
            .Value    = ""
            .Top      = 197
            .Left     = 116
            .Width    = 80
            .Height   = 21
            .FontName = "Tahoma"
            .FontSize = 8
            .Visible  = .T.
        ENDWITH

        *-- Label "Descricao :" (Say2, top 198+29=227)
        loc_oPg2.AddObject("lbl_4c_Descs", "Label")
        WITH loc_oPg2.lbl_4c_Descs
            .Caption   = "Descri" + CHR(231) + CHR(227) + "o :"
            .Top       = 227
            .Left      = 45
            .Width     = 68
            .Height    = 17
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(255, 255, 255)
            .BackStyle = 0
            .AutoSize  = .F.
            .Visible   = .T.
        ENDWITH

        *-- TextBox Descs (get_descs, top 192+29=221)
        loc_oPg2.AddObject("txt_4c_Descs", "TextBox")
        WITH loc_oPg2.txt_4c_Descs
            .Value    = ""
            .Top      = 221
            .Left     = 116
            .Width    = 290
            .Height   = 21
            .FontName = "Tahoma"
            .FontSize = 8
            .Visible  = .T.
        ENDWITH

        *-- Label "Formula :" (Say3, top 227+29=256)
        loc_oPg2.AddObject("lbl_4c_Formula", "Label")
        WITH loc_oPg2.lbl_4c_Formula
            .Caption   = "F" + CHR(243) + "rmula :"
            .Top       = 256
            .Left      = 55
            .Width     = 58
            .Height    = 17
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(255, 255, 255)
            .BackStyle = 0
            .AutoSize  = .F.
            .Visible   = .T.
        ENDWITH

        *-- EditBox Formulas (get_formula, top 228+29=257, height=100)
        loc_oPg2.AddObject("obj_4c_Formulas", "EditBox")
        WITH loc_oPg2.obj_4c_Formulas
            .Value      = ""
            .Top        = 257
            .Left       = 115
            .Width      = 290
            .Height     = 100
            .FontName   = "Tahoma"
            .FontSize   = 8
            .BackColor  = RGB(255, 255, 255)
            .ForeColor  = RGB(0, 0, 0)
            .ScrollBars = 2
            .Visible    = .T.
        ENDWITH

        *-- Label "Metal Novo :" (Label7, top 170+29=199)
        loc_oPg2.AddObject("lbl_4c_MetalNovo", "Label")
        WITH loc_oPg2.lbl_4c_MetalNovo
            .Caption   = "Metal Novo :"
            .Top       = 199
            .Left      = 435
            .Width     = 74
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(255, 255, 255)
            .BackStyle = 0
            .AutoSize  = .F.
            .Visible   = .T.
        ENDWITH

        *-- TextBox Percentual metal novo (get_perc, top 166+29=195, mask 999.99)
        loc_oPg2.AddObject("txt_4c_Percs", "TextBox")
        WITH loc_oPg2.txt_4c_Percs
            .Value     = 0
            .Top       = 195
            .Left      = 514
            .Width     = 52
            .Height    = 21
            .FontName  = "Tahoma"
            .FontSize  = 8
            .InputMask = "999.99"
            .Visible   = .T.
        ENDWITH

        *-- Label "%" (Label8, top 170+29=199)
        loc_oPg2.AddObject("lbl_4c_Pct", "Label")
        WITH loc_oPg2.lbl_4c_Pct
            .Caption   = "%"
            .Top       = 199
            .Left      = 570
            .Width     = 14
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(255, 255, 255)
            .BackStyle = 0
            .AutoSize  = .F.
            .Visible   = .T.
        ENDWITH

        *-- Label titulo secao "Fundicao" (Label1, top 208+29=237)
        loc_oPg2.AddObject("lbl_4c_Fundicao", "Label")
        WITH loc_oPg2.lbl_4c_Fundicao
            .Caption   = "Fundi" + CHR(231) + CHR(227) + "o"
            .Top       = 237
            .Left      = 435
            .Width     = 61
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .T.
            .ForeColor = RGB(255, 255, 255)
            .BackStyle = 0
            .AutoSize  = .F.
            .Visible   = .T.
        ENDWITH

        *-- Label "Temperatura Metal" (Label2, top 226+29=255)
        loc_oPg2.AddObject("lbl_4c_TempMet", "Label")
        WITH loc_oPg2.lbl_4c_TempMet
            .Caption   = "Temperatura Metal"
            .Top       = 255
            .Left      = 465
            .Width     = 110
            .Height    = 15
            .FontName  = "Verdana"
            .FontSize  = 8
            .FontBold  = .F.
            .ForeColor = RGB(36, 84, 155)
            .BackStyle = 0
            .AutoSize  = .F.
            .Visible   = .T.
        ENDWITH

        *-- TextBox TempMets (Get_TempMet, top 242+29=271, MaxLength=15)
        loc_oPg2.AddObject("txt_4c_TempMets", "TextBox")
        WITH loc_oPg2.txt_4c_TempMets
            .Value     = ""
            .Top       = 271
            .Left      = 465
            .Width     = 115
            .Height    = 23
            .MaxLength = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Visible   = .T.
        ENDWITH

        *-- Label "Temperatura Tubo" (Label3, top 226+29=255)
        loc_oPg2.AddObject("lbl_4c_TempTub", "Label")
        WITH loc_oPg2.lbl_4c_TempTub
            .Caption   = "Temperatura Tubo"
            .Top       = 255
            .Left      = 615
            .Width     = 108
            .Height    = 15
            .FontName  = "Verdana"
            .FontSize  = 8
            .FontBold  = .F.
            .ForeColor = RGB(231, 254, 253)
            .BackStyle = 0
            .AutoSize  = .F.
            .Visible   = .T.
        ENDWITH

        *-- TextBox TempTubs (Get_TempTub, top 242+29=271, MaxLength=15)
        loc_oPg2.AddObject("txt_4c_TempTubs", "TextBox")
        WITH loc_oPg2.txt_4c_TempTubs
            .Value     = ""
            .Top       = 271
            .Left      = 615
            .Width     = 115
            .Height    = 23
            .MaxLength = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Visible   = .T.
        ENDWITH

        *-- Label "Revestimento" (Label4, top 272+29=301)
        loc_oPg2.AddObject("lbl_4c_Revestimento", "Label")
        WITH loc_oPg2.lbl_4c_Revestimento
            .Caption   = "Revestimento"
            .Top       = 301
            .Left      = 435
            .Width     = 91
            .Height    = 15
            .FontName  = "Verdana"
            .FontSize  = 8
            .FontBold  = .T.
            .ForeColor = RGB(36, 84, 155)
            .BackStyle = 0
            .AutoSize  = .F.
            .Visible   = .T.
        ENDWITH

        *-- Label "Temperatura Ambiente" (Label5, top 288+29=317)
        loc_oPg2.AddObject("lbl_4c_TempAmb", "Label")
        WITH loc_oPg2.lbl_4c_TempAmb
            .Caption   = "Temperatura Ambiente"
            .Top       = 317
            .Left      = 465
            .Width     = 134
            .Height    = 15
            .FontName  = "Verdana"
            .FontSize  = 8
            .FontBold  = .F.
            .ForeColor = RGB(36, 84, 155)
            .BackStyle = 0
            .AutoSize  = .F.
            .Visible   = .T.
        ENDWITH

        *-- TextBox TempAmbs (Get_TempAmb, top 304+29=333, MaxLength=15)
        loc_oPg2.AddObject("txt_4c_TempAmbs", "TextBox")
        WITH loc_oPg2.txt_4c_TempAmbs
            .Value     = ""
            .Top       = 333
            .Left      = 465
            .Width     = 115
            .Height    = 23
            .MaxLength = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Visible   = .T.
        ENDWITH

        *-- Label "Temperatura Agua" (Label6, top 288+29=317)
        loc_oPg2.AddObject("lbl_4c_TempAgu", "Label")
        WITH loc_oPg2.lbl_4c_TempAgu
            .Caption   = "Temperatura " + CHR(193) + "gua"
            .Top       = 317
            .Left      = 615
            .Width     = 109
            .Height    = 15
            .FontName  = "Verdana"
            .FontSize  = 8
            .FontBold  = .F.
            .ForeColor = RGB(231, 254, 253)
            .BackStyle = 0
            .AutoSize  = .F.
            .Visible   = .T.
        ENDWITH

        *-- TextBox Tempagus (Get_TempAgu, top 304+29=333, MaxLength=15)
        loc_oPg2.AddObject("txt_4c_Tempagus", "TextBox")
        WITH loc_oPg2.txt_4c_Tempagus
            .Value     = ""
            .Top       = 333
            .Left      = 615
            .Width     = 115
            .Height    = 23
            .MaxLength = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Visible   = .T.
        ENDWITH

        *-- Say4: instrucoes para formula (Say4, top 349+29=378)
        loc_oPg2.AddObject("lbl_4c_Say4", "Label")
        WITH loc_oPg2.lbl_4c_Say4
            .Caption   = "Para montar a f" + CHR(243) + "rmula tem que usar os seguintes campos :"
            .Top       = 378
            .Left      = 61
            .Width     = 380
            .Height    = 18
            .FontName  = "Tahoma"
            .FontSize  = 10
            .FontBold  = .F.
            .ForeColor = RGB(255, 0, 0)
            .BackStyle = 0
            .AutoSize  = .F.
            .WordWrap  = .T.
            .Visible   = .T.
        ENDWITH

        *-- Say5: BCERAS = Base + Cera (top 369+29=398)
        loc_oPg2.AddObject("lbl_4c_Say5", "Label")
        WITH loc_oPg2.lbl_4c_Say5
            .Caption   = "BCERAS = Base + Cera"
            .Top       = 398
            .Left      = 61
            .Width     = 150
            .Height    = 18
            .FontName  = "Tahoma"
            .FontSize  = 10
            .FontBold  = .F.
            .ForeColor = RGB(255, 0, 0)
            .BackStyle = 0
            .AutoSize  = .F.
            .WordWrap  = .T.
            .Visible   = .T.
        ENDWITH

        *-- Say6: BASES = Base (top 389+29=418)
        loc_oPg2.AddObject("lbl_4c_Say6", "Label")
        WITH loc_oPg2.lbl_4c_Say6
            .Caption   = "BASES = Base"
            .Top       = 418
            .Left      = 61
            .Width     = 93
            .Height    = 18
            .FontName  = "Tahoma"
            .FontSize  = 10
            .FontBold  = .F.
            .ForeColor = RGB(255, 0, 0)
            .BackStyle = 0
            .AutoSize  = .F.
            .WordWrap  = .T.
            .Visible   = .T.
        ENDWITH

        *-- Say7: exemplo de formula (top 409+29=438)
        loc_oPg2.AddObject("lbl_4c_Say7", "Label")
        WITH loc_oPg2.lbl_4c_Say7
            .Caption   = "Ex: (((BCERAS - BASES) * 15,3) - 40)/5"
            .Top       = 438
            .Left      = 61
            .Width     = 268
            .Height    = 18
            .FontName  = "Tahoma"
            .FontSize  = 10
            .FontBold  = .F.
            .ForeColor = RGB(255, 0, 0)
            .BackStyle = 0
            .AutoSize  = .F.
            .WordWrap  = .T.
            .Visible   = .T.
        ENDWITH

        THIS.TornarControlesVisiveis(loc_oPg2)
    ENDPROC

    *--------------------------------------------------------------------------
    * TornarControlesVisiveis - Torna todos os controles visiveis recursivamente
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
    * CarregarLista - Carrega dados no Grid da Page1
    *--------------------------------------------------------------------------
    PROCEDURE CarregarLista()
        LOCAL loc_lResultado, loc_oGrid
        loc_lResultado = .F.

        TRY
            IF VARTYPE(THIS.this_oBusinessObject) != "O"
                loc_lResultado = .F.
            ENDIF

            loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Lista

            IF !THIS.this_oBusinessObject.Buscar("")
                loc_lResultado = .F.
            ELSE
                loc_oGrid.ColumnCount = 2
                loc_oGrid.RecordSource          = "cursor_4c_Dados"
                loc_oGrid.Column1.ControlSource = "cursor_4c_Dados.codigos"
                loc_oGrid.Column2.ControlSource = "cursor_4c_Dados.descs"
                loc_oGrid.Column1.Width         = 80
                loc_oGrid.Column2.Width         = 290
                loc_oGrid.Column1.Header1.Caption = "C" + CHR(243) + "digos"
                loc_oGrid.Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
                THIS.FormatarGridLista(loc_oGrid)
                loc_lResultado = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "FormARV.CarregarLista")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * AlternarPagina - Alterna entre Page1 (Lista=1) e Page2 (Dados=2)
    *--------------------------------------------------------------------------
    PROCEDURE AlternarPagina(par_nPagina)
        LOCAL loc_lResultado
        loc_lResultado = .F.

        TRY
            IF VARTYPE(par_nPagina) != "N" OR par_nPagina < 1 OR par_nPagina > 2
                loc_lResultado = .F.
            ENDIF

            THIS.pgf_4c_Paginas.ActivePage = par_nPagina

            IF par_nPagina = 1
                THIS.this_cModoAtual = "LISTA"
                THIS.CarregarLista()
            ENDIF

            loc_lResultado = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "FormARV.AlternarPagina")
        ENDTRY

        RETURN loc_lResultado
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
    * HabilitarCampos - Habilita/desabilita campos de Page2 conforme modo
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE HabilitarCampos(par_lHabilitar)
        LOCAL loc_oPg2, loc_lEdicao
        loc_oPg2   = THIS.pgf_4c_Paginas.Page2
        loc_lEdicao = INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")

        IF PEMSTATUS(loc_oPg2, "txt_4c_Codigos", 5)
            loc_oPg2.txt_4c_Codigos.Enabled = par_lHabilitar AND (THIS.this_cModoAtual = "INCLUIR")
        ENDIF
        IF PEMSTATUS(loc_oPg2, "txt_4c_Descs", 5)
            loc_oPg2.txt_4c_Descs.Enabled = par_lHabilitar AND loc_lEdicao
        ENDIF
        IF PEMSTATUS(loc_oPg2, "obj_4c_Formulas", 5)
            loc_oPg2.obj_4c_Formulas.ReadOnly = !(par_lHabilitar AND loc_lEdicao)
        ENDIF
        IF PEMSTATUS(loc_oPg2, "txt_4c_Percs", 5)
            loc_oPg2.txt_4c_Percs.Enabled = par_lHabilitar AND loc_lEdicao
        ENDIF
        IF PEMSTATUS(loc_oPg2, "txt_4c_TempMets", 5)
            loc_oPg2.txt_4c_TempMets.Enabled = par_lHabilitar AND loc_lEdicao
        ENDIF
        IF PEMSTATUS(loc_oPg2, "txt_4c_TempTubs", 5)
            loc_oPg2.txt_4c_TempTubs.Enabled = par_lHabilitar AND loc_lEdicao
        ENDIF
        IF PEMSTATUS(loc_oPg2, "txt_4c_TempAmbs", 5)
            loc_oPg2.txt_4c_TempAmbs.Enabled = par_lHabilitar AND loc_lEdicao
        ENDIF
        IF PEMSTATUS(loc_oPg2, "txt_4c_Tempagus", 5)
            loc_oPg2.txt_4c_Tempagus.Enabled = par_lHabilitar AND loc_lEdicao
        ENDIF

        IF PEMSTATUS(loc_oPg2, "cnt_4c_Salva", 5)
            IF PEMSTATUS(loc_oPg2.cnt_4c_Salva, "cmd_4c_Confirmar", 5)
                loc_oPg2.cnt_4c_Salva.cmd_4c_Confirmar.Enabled = par_lHabilitar AND loc_lEdicao
            ENDIF
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * LimparCampos - Limpa valores dos campos de Page2
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE LimparCampos()
        LOCAL loc_oPg2
        loc_oPg2 = THIS.pgf_4c_Paginas.Page2

        IF PEMSTATUS(loc_oPg2, "txt_4c_Codigos", 5)
            loc_oPg2.txt_4c_Codigos.Value = ""
        ENDIF
        IF PEMSTATUS(loc_oPg2, "txt_4c_Descs", 5)
            loc_oPg2.txt_4c_Descs.Value = ""
        ENDIF
        IF PEMSTATUS(loc_oPg2, "obj_4c_Formulas", 5)
            loc_oPg2.obj_4c_Formulas.Value = ""
        ENDIF
        IF PEMSTATUS(loc_oPg2, "txt_4c_Percs", 5)
            loc_oPg2.txt_4c_Percs.Value = 0
        ENDIF
        IF PEMSTATUS(loc_oPg2, "txt_4c_TempMets", 5)
            loc_oPg2.txt_4c_TempMets.Value = ""
        ENDIF
        IF PEMSTATUS(loc_oPg2, "txt_4c_TempTubs", 5)
            loc_oPg2.txt_4c_TempTubs.Value = ""
        ENDIF
        IF PEMSTATUS(loc_oPg2, "txt_4c_TempAmbs", 5)
            loc_oPg2.txt_4c_TempAmbs.Value = ""
        ENDIF
        IF PEMSTATUS(loc_oPg2, "txt_4c_Tempagus", 5)
            loc_oPg2.txt_4c_Tempagus.Value = ""
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * FormParaBO - Transfere valores do formulario para o BO
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE FormParaBO()
        LOCAL loc_oPg2
        loc_oPg2 = THIS.pgf_4c_Paginas.Page2

        IF PEMSTATUS(loc_oPg2, "txt_4c_Codigos", 5)
            THIS.this_oBusinessObject.this_cCodigos = ALLTRIM(loc_oPg2.txt_4c_Codigos.Value)
        ENDIF
        IF PEMSTATUS(loc_oPg2, "txt_4c_Descs", 5)
            THIS.this_oBusinessObject.this_cDescs = ALLTRIM(loc_oPg2.txt_4c_Descs.Value)
        ENDIF
        IF PEMSTATUS(loc_oPg2, "obj_4c_Formulas", 5)
            THIS.this_oBusinessObject.this_cFormulas = ALLTRIM(loc_oPg2.obj_4c_Formulas.Value)
        ENDIF
        IF PEMSTATUS(loc_oPg2, "txt_4c_Percs", 5)
            THIS.this_oBusinessObject.this_nPercs = loc_oPg2.txt_4c_Percs.Value
        ENDIF
        IF PEMSTATUS(loc_oPg2, "txt_4c_TempMets", 5)
            THIS.this_oBusinessObject.this_cTempMets = ALLTRIM(loc_oPg2.txt_4c_TempMets.Value)
        ENDIF
        IF PEMSTATUS(loc_oPg2, "txt_4c_TempTubs", 5)
            THIS.this_oBusinessObject.this_cTempTubs = ALLTRIM(loc_oPg2.txt_4c_TempTubs.Value)
        ENDIF
        IF PEMSTATUS(loc_oPg2, "txt_4c_TempAmbs", 5)
            THIS.this_oBusinessObject.this_cTempAmbs = ALLTRIM(loc_oPg2.txt_4c_TempAmbs.Value)
        ENDIF
        IF PEMSTATUS(loc_oPg2, "txt_4c_Tempagus", 5)
            THIS.this_oBusinessObject.this_cTempagus = ALLTRIM(loc_oPg2.txt_4c_Tempagus.Value)
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * BOParaForm - Transfere valores do BO para o formulario
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE BOParaForm()
        LOCAL loc_oPg2
        loc_oPg2 = THIS.pgf_4c_Paginas.Page2

        IF PEMSTATUS(loc_oPg2, "txt_4c_Codigos", 5)
            loc_oPg2.txt_4c_Codigos.Value = ALLTRIM(THIS.this_oBusinessObject.this_cCodigos)
        ENDIF
        IF PEMSTATUS(loc_oPg2, "txt_4c_Descs", 5)
            loc_oPg2.txt_4c_Descs.Value = ALLTRIM(THIS.this_oBusinessObject.this_cDescs)
        ENDIF
        IF PEMSTATUS(loc_oPg2, "obj_4c_Formulas", 5)
            loc_oPg2.obj_4c_Formulas.Value = THIS.this_oBusinessObject.this_cFormulas
        ENDIF
        IF PEMSTATUS(loc_oPg2, "txt_4c_Percs", 5)
            loc_oPg2.txt_4c_Percs.Value = THIS.this_oBusinessObject.this_nPercs
        ENDIF
        IF PEMSTATUS(loc_oPg2, "txt_4c_TempMets", 5)
            loc_oPg2.txt_4c_TempMets.Value = ALLTRIM(THIS.this_oBusinessObject.this_cTempMets)
        ENDIF
        IF PEMSTATUS(loc_oPg2, "txt_4c_TempTubs", 5)
            loc_oPg2.txt_4c_TempTubs.Value = ALLTRIM(THIS.this_oBusinessObject.this_cTempTubs)
        ENDIF
        IF PEMSTATUS(loc_oPg2, "txt_4c_TempAmbs", 5)
            loc_oPg2.txt_4c_TempAmbs.Value = ALLTRIM(THIS.this_oBusinessObject.this_cTempAmbs)
        ENDIF
        IF PEMSTATUS(loc_oPg2, "txt_4c_Tempagus", 5)
            loc_oPg2.txt_4c_Tempagus.Value = ALLTRIM(THIS.this_oBusinessObject.this_cTempagus)
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnIncluirClick - Novo registro
    *--------------------------------------------------------------------------
    PROCEDURE BtnIncluirClick()
        THIS.this_oBusinessObject.NovoRegistro()
        THIS.LimparCampos()
        THIS.this_cModoAtual = "INCLUIR"
        THIS.HabilitarCampos(.T.)
        THIS.pgf_4c_Paginas.ActivePage = 2
        IF PEMSTATUS(THIS.pgf_4c_Paginas.Page2, "txt_4c_Codigos", 5)
            THIS.pgf_4c_Paginas.Page2.txt_4c_Codigos.SetFocus()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnVisualizarClick - Visualizar registro selecionado (somente leitura)
    *--------------------------------------------------------------------------
    PROCEDURE BtnVisualizarClick()
        LOCAL loc_cCodigo
        loc_cCodigo = ""

        IF !USED("cursor_4c_Dados") OR EOF("cursor_4c_Dados")
            MsgAviso("Selecione um registro na lista.", "Visualizar")
            RETURN
        ENDIF

        SELECT cursor_4c_Dados
        loc_cCodigo = ALLTRIM(cursor_4c_Dados.codigos)

        IF EMPTY(loc_cCodigo)
            MsgAviso("Selecione um registro na lista.", "Visualizar")
            RETURN
        ENDIF

        IF !THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
            MsgErro("Registro n" + CHR(227) + "o encontrado.", "Visualizar")
            RETURN
        ENDIF

        THIS.BOParaForm()
        THIS.this_cModoAtual = "VISUALIZAR"
        THIS.HabilitarCampos(.F.)
        THIS.pgf_4c_Paginas.ActivePage = 2
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnAlterarClick - Alterar registro selecionado
    *--------------------------------------------------------------------------
    PROCEDURE BtnAlterarClick()
        LOCAL loc_cCodigo
        loc_cCodigo = ""

        IF !USED("cursor_4c_Dados") OR EOF("cursor_4c_Dados")
            MsgAviso("Selecione um registro na lista.", "Alterar")
            RETURN
        ENDIF

        SELECT cursor_4c_Dados
        loc_cCodigo = ALLTRIM(cursor_4c_Dados.codigos)

        IF EMPTY(loc_cCodigo)
            MsgAviso("Selecione um registro na lista.", "Alterar")
            RETURN
        ENDIF

        IF !THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
            MsgErro("Registro n" + CHR(227) + "o encontrado.", "Alterar")
            RETURN
        ENDIF

        THIS.this_oBusinessObject.EditarRegistro()
        THIS.BOParaForm()
        THIS.this_cModoAtual = "ALTERAR"
        THIS.HabilitarCampos(.T.)
        THIS.pgf_4c_Paginas.ActivePage = 2
        IF PEMSTATUS(THIS.pgf_4c_Paginas.Page2, "txt_4c_Descs", 5)
            THIS.pgf_4c_Paginas.Page2.txt_4c_Descs.SetFocus()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnExcluirClick - Excluir registro selecionado
    *--------------------------------------------------------------------------
    PROCEDURE BtnExcluirClick()
        LOCAL loc_cCodigo, loc_lConfirma
        loc_cCodigo   = ""
        loc_lConfirma = .F.

        IF !USED("cursor_4c_Dados") OR EOF("cursor_4c_Dados")
            MsgAviso("Selecione um registro na lista.", "Excluir")
            RETURN
        ENDIF

        SELECT cursor_4c_Dados
        loc_cCodigo = ALLTRIM(cursor_4c_Dados.codigos)

        IF EMPTY(loc_cCodigo)
            MsgAviso("Selecione um registro na lista.", "Excluir")
            RETURN
        ENDIF

        loc_lConfirma = MsgConfirma("Confirma a exclus" + CHR(227) + "o do registro '" + loc_cCodigo + "'?", "Excluir")
        IF !loc_lConfirma
            RETURN
        ENDIF

        IF !THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
            MsgErro("Registro n" + CHR(227) + "o encontrado.", "Excluir")
            RETURN
        ENDIF

        IF THIS.this_oBusinessObject.Excluir()
            MsgInfo("Registro exclu" + CHR(237) + "do com sucesso!", "Excluir")
            THIS.CarregarLista()
        ELSE
            MsgErro("Erro ao excluir o registro.", "Excluir")
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnBuscarClick - Abre FormBuscaAuxiliar para localizar registro
    *--------------------------------------------------------------------------
    PROCEDURE BtnBuscarClick()
        LOCAL loc_oBusca, loc_cCodigo
        loc_oBusca  = .NULL.
        loc_cCodigo = ""

        TRY
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigCdArv", "cursor_4c_BuscaArv", "codigos", "", ;
                "Buscar Tipo de " + CHR(193) + "rvore")

            IF VARTYPE(loc_oBusca) = "O"
                loc_oBusca.mAddColuna("codigos", "", "C" + CHR(243) + "digos")
                loc_oBusca.mAddColuna("descs",   "", "Descri" + CHR(231) + CHR(227) + "o")
                loc_oBusca.Show()

                IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaArv")
                    loc_cCodigo = ALLTRIM(cursor_4c_BuscaArv.codigos)
                    IF USED("cursor_4c_Dados")
                        SELECT cursor_4c_Dados
                        LOCATE FOR ALLTRIM(cursor_4c_Dados.codigos) = loc_cCodigo
                        THIS.pgf_4c_Paginas.Page1.grd_4c_Lista.Refresh()
                    ENDIF
                ENDIF

                loc_oBusca.Release()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "FormARV.BtnBuscarClick")
        ENDTRY

        IF USED("cursor_4c_BuscaArv")
            USE IN cursor_4c_BuscaArv
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnEncerrarClick - Fecha o formulario
    *--------------------------------------------------------------------------
    PROCEDURE BtnEncerrarClick()
        THIS.Release()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnSalvarClick - Salva registro (chamado pelo cmd_4c_Confirmar da Page2)
    *--------------------------------------------------------------------------
    PROCEDURE BtnSalvarClick()
        LOCAL loc_cCodigo, loc_nChk, loc_lSucesso
        loc_cCodigo  = ""
        loc_nChk     = 0
        loc_lSucesso = .F.

        THIS.FormParaBO()
        loc_cCodigo = ALLTRIM(THIS.this_oBusinessObject.this_cCodigos)

        IF EMPTY(loc_cCodigo)
            MsgAviso("C" + CHR(243) + "digo n" + CHR(227) + "o pode ficar em branco!", "Salvar")
            IF PEMSTATUS(THIS.pgf_4c_Paginas.Page2, "txt_4c_Codigos", 5)
                THIS.pgf_4c_Paginas.Page2.txt_4c_Codigos.SetFocus()
            ENDIF
            RETURN
        ENDIF

        IF THIS.this_cModoAtual = "INCLUIR"
            loc_nChk = SQLEXEC(gnConnHandle, ;
                "SELECT COUNT(*) AS cnt FROM SigCdArv WHERE codigos = " + EscaparSQL(loc_cCodigo), ;
                "cursor_4c_ChkArv")
            IF loc_nChk >= 0 AND RECCOUNT("cursor_4c_ChkArv") > 0
                SELECT cursor_4c_ChkArv
                IF cursor_4c_ChkArv.cnt > 0
                    MsgAviso("Tipo de " + CHR(225) + "rvore j" + CHR(225) + " cadastrado!", "Salvar")
                    IF USED("cursor_4c_ChkArv")
                        USE IN cursor_4c_ChkArv
                    ENDIF
                    IF PEMSTATUS(THIS.pgf_4c_Paginas.Page2, "txt_4c_Codigos", 5)
                        THIS.pgf_4c_Paginas.Page2.txt_4c_Codigos.SetFocus()
                    ENDIF
                    RETURN
                ENDIF
            ENDIF
            IF USED("cursor_4c_ChkArv")
                USE IN cursor_4c_ChkArv
            ENDIF
        ENDIF

        IF THIS.this_oBusinessObject.Salvar()
            MsgInfo("Registro salvo com sucesso!", "Salvar")
            THIS.AlternarPagina(1)
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnCancelarClick - Cancela edicao e volta para lista
    *--------------------------------------------------------------------------
    PROCEDURE BtnCancelarClick()
        THIS.AlternarPagina(1)
    ENDPROC

    *--------------------------------------------------------------------------
    * AjustarBotoesPorModo - Ajusta estado dos botoes de Page2 conforme modo
    *--------------------------------------------------------------------------
    PROCEDURE AjustarBotoesPorModo()
        LOCAL loc_oPg2, loc_lEdicao
        loc_oPg2    = THIS.pgf_4c_Paginas.Page2
        loc_lEdicao = INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")

        IF PEMSTATUS(loc_oPg2, "cnt_4c_Salva", 5)
            IF PEMSTATUS(loc_oPg2.cnt_4c_Salva, "cmd_4c_Confirmar", 5)
                loc_oPg2.cnt_4c_Salva.cmd_4c_Confirmar.Enabled = loc_lEdicao
            ENDIF
            IF PEMSTATUS(loc_oPg2.cnt_4c_Salva, "cmd_4c_Cancelar", 5)
                loc_oPg2.cnt_4c_Salva.cmd_4c_Cancelar.Enabled = .T.
            ENDIF
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * Destroy - Libera recursos ao fechar o form
    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
        IF VARTYPE(THIS.this_oBusinessObject) = "O"
            THIS.this_oBusinessObject = .NULL.
        ENDIF
        DODEFAULT()
    ENDPROC

ENDDEFINE


### BO (C:\4c\projeto\app\classes\ARVBO.prg):
*====================================================================
* ARVBO.prg
*
* Business Object para Tipos de Arvore
* Tabela: SigCdArv
* Herda de: BusinessBase
*====================================================================

DEFINE CLASS ARVBO AS BusinessBase

	*-- Propriedades da entidade (SigCdArv)
	this_cCodigos  = ""   && codigos  char - PK
	this_cDescs    = ""   && descs    char - Descricao
	this_cFormulas = ""   && formulas memo/char - Formula de calculo
	this_cTempMets = ""   && TempMets char(15) - Formula temperatura metal (Fundicao)
	this_cTempTubs = ""   && TempTubs char(15) - Formula temperatura tubo (Fundicao)
	this_cTempAmbs = ""   && TempAmbs char(15) - Formula temperatura ambiente (Revestimento)
	this_cTempagus = ""   && Tempagus char(15) - Formula temperatura agua (Revestimento)
	this_nPercs    = 0    && Percs    numeric(5,2) - Percentual metal novo

	*====================================================================
	* Init - Inicializa Business Object
	*====================================================================
	PROCEDURE Init()
		DODEFAULT()
		THIS.this_cTabela     = "SigCdArv"
		THIS.this_cCampoChave = "codigos"
		RETURN .T.
	ENDPROC

	*====================================================================
	* ObterChavePrimaria - Retorna chave primaria para auditoria
	*====================================================================
	PROTECTED PROCEDURE ObterChavePrimaria()
		RETURN ALLTRIM(THIS.this_cCodigos)
	ENDPROC

	*====================================================================
	* Buscar - Carrega lista de tipos de arvore no cursor_4c_Dados
	*====================================================================
	PROCEDURE Buscar(par_cFiltro)
		LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
		loc_lSucesso = .F.

		TRY
			IF EMPTY(par_cFiltro)
				loc_cSQL = "SELECT codigos, descs, formulas, TempMets, TempTubs," + ;
				           " TempAmbs, Tempagus, Percs" + ;
				           " FROM SigCdArv" + ;
				           " ORDER BY codigos"
			ELSE
				loc_cSQL = "SELECT codigos, descs, formulas, TempMets, TempTubs," + ;
				           " TempAmbs, Tempagus, Percs" + ;
				           " FROM SigCdArv" + ;
				           " WHERE codigos LIKE " + EscaparSQL(ALLTRIM(par_cFiltro) + "%") + ;
				           " ORDER BY codigos"
			ENDIF

			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")
			IF loc_nResultado >= 0
				loc_lSucesso = .T.
			ELSE
				IF !USED("cursor_4c_Dados")
					CREATE CURSOR cursor_4c_Dados (codigos C(10), descs C(100), formulas M, ;
					    TempMets C(15), TempTubs C(15), TempAmbs C(15), Tempagus C(15), Percs N(5,2))
				ENDIF
				MsgErro("Erro ao buscar tipos de " + CHR(225) + "rvore:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
			ENDIF
		CATCH TO loc_oErro
			MsgErro("Erro ao buscar tipos de " + CHR(225) + "rvore:" + CHR(13) + loc_oErro.Message, "Erro")
		ENDTRY

		RETURN loc_lSucesso
	ENDPROC

	*====================================================================
	* CarregarPorCodigo - Carrega um registro pelo codigo (PK)
	*====================================================================
	PROCEDURE CarregarPorCodigo(par_cCodigo)
		LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
		loc_lSucesso = .F.

		TRY
			loc_cSQL = "SELECT codigos, descs, formulas, TempMets, TempTubs," + ;
			           " TempAmbs, Tempagus, Percs" + ;
			           " FROM SigCdArv" + ;
			           " WHERE codigos = " + EscaparSQL(par_cCodigo)

			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")
			IF loc_nResultado >= 0 AND RECCOUNT("cursor_4c_Carrega") > 0
				loc_lSucesso = THIS.CarregarDoCursor("cursor_4c_Carrega")
				THIS.this_lNovoRegistro = .F.
			ELSE
				MsgErro("Tipo de " + CHR(225) + "rvore n" + CHR(227) + "o encontrado!", "Aviso")
			ENDIF
		CATCH TO loc_oErro
			MsgErro("Erro ao carregar tipo de " + CHR(225) + "rvore:" + CHR(13) + loc_oErro.Message, "Erro")
		ENDTRY

		IF USED("cursor_4c_Carrega")
			USE IN cursor_4c_Carrega
		ENDIF

		RETURN loc_lSucesso
	ENDPROC

	*====================================================================
	* CarregarDoCursor - Popula propriedades a partir de cursor
	*====================================================================
	PROCEDURE CarregarDoCursor(par_cAliasCursor)
		LOCAL loc_lSucesso
		loc_lSucesso = .F.

		IF USED(par_cAliasCursor)
			SELECT (par_cAliasCursor)
			THIS.this_cCodigos  = TratarNulo(codigos,  "C")
			THIS.this_cDescs    = TratarNulo(descs,    "C")
			THIS.this_cFormulas = TratarNulo(formulas, "C")
			THIS.this_cTempMets = TratarNulo(TempMets, "C")
			THIS.this_cTempTubs = TratarNulo(TempTubs, "C")
			THIS.this_cTempAmbs = TratarNulo(TempAmbs, "C")
			THIS.this_cTempagus = TratarNulo(Tempagus, "C")
			THIS.this_nPercs    = TratarNulo(Percs,    "N")
			loc_lSucesso = .T.
		ENDIF

		RETURN loc_lSucesso
	ENDPROC

	*====================================================================
	* Inserir - Insere novo registro (PROTECTED - chamado por Salvar())
	*====================================================================
	PROTECTED PROCEDURE Inserir()
		LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
		loc_lSucesso = .F.

		TRY
			loc_cSQL = "INSERT INTO SigCdArv" + ;
			           " (codigos, descs, formulas, TempMets, TempTubs, TempAmbs, Tempagus, Percs)" + ;
			           " VALUES (" + ;
			           EscaparSQL(THIS.this_cCodigos)  + "," + ;
			           EscaparSQL(THIS.this_cDescs)    + "," + ;
			           EscaparSQL(THIS.this_cFormulas) + "," + ;
			           EscaparSQL(THIS.this_cTempMets) + "," + ;
			           EscaparSQL(THIS.this_cTempTubs) + "," + ;
			           EscaparSQL(THIS.this_cTempAmbs) + "," + ;
			           EscaparSQL(THIS.this_cTempagus) + "," + ;
			           FormatarNumeroSQL(THIS.this_nPercs) + ")"

			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
			IF loc_nResultado >= 0
				THIS.RegistrarAuditoria("INSERT")
				loc_lSucesso = .T.
			ELSE
				MsgErro("Erro ao inserir tipo de " + CHR(225) + "rvore:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
			ENDIF
		CATCH TO loc_oErro
			MsgErro("Erro ao inserir tipo de " + CHR(225) + "rvore:" + CHR(13) + loc_oErro.Message, "Erro")
		ENDTRY

		RETURN loc_lSucesso
	ENDPROC

	*====================================================================
	* Atualizar - Atualiza registro existente (PROTECTED - chamado por Salvar())
	*====================================================================
	PROTECTED PROCEDURE Atualizar()
		LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
		loc_lSucesso = .F.

		TRY
			loc_cSQL = "UPDATE SigCdArv SET" + ;
			           " descs    = " + EscaparSQL(THIS.this_cDescs)    + "," + ;
			           " formulas = " + EscaparSQL(THIS.this_cFormulas) + "," + ;
			           " TempMets = " + EscaparSQL(THIS.this_cTempMets) + "," + ;
			           " TempTubs = " + EscaparSQL(THIS.this_cTempTubs) + "," + ;
			           " TempAmbs = " + EscaparSQL(THIS.this_cTempAmbs) + "," + ;
			           " Tempagus = " + EscaparSQL(THIS.this_cTempagus) + "," + ;
			           " Percs    = " + FormatarNumeroSQL(THIS.this_nPercs) + ;
			           " WHERE codigos = " + EscaparSQL(THIS.this_cCodigos)

			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
			IF loc_nResultado >= 0
				THIS.RegistrarAuditoria("UPDATE")
				loc_lSucesso = .T.
			ELSE
				MsgErro("Erro ao atualizar tipo de " + CHR(225) + "rvore:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
			ENDIF
		CATCH TO loc_oErro
			MsgErro("Erro ao atualizar tipo de " + CHR(225) + "rvore:" + CHR(13) + loc_oErro.Message, "Erro")
		ENDTRY

		RETURN loc_lSucesso
	ENDPROC

	*====================================================================
	* ExecutarExclusao - Exclui registro (PROTECTED - chamado por Excluir())
	*====================================================================
	PROTECTED PROCEDURE ExecutarExclusao()
		LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
		loc_lSucesso = .F.

		TRY
			loc_cSQL = "DELETE FROM SigCdArv" + ;
			           " WHERE codigos = " + EscaparSQL(THIS.this_cCodigos)

			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
			IF loc_nResultado >= 0
				THIS.RegistrarAuditoria("DELETE")
				loc_lSucesso = .T.
			ELSE
				MsgErro("Erro ao excluir tipo de " + CHR(225) + "rvore:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
			ENDIF
		CATCH TO loc_oErro
			MsgErro("Erro ao excluir tipo de " + CHR(225) + "rvore:" + CHR(13) + loc_oErro.Message, "Erro")
		ENDTRY

		RETURN loc_lSucesso
	ENDPROC

ENDDEFINE


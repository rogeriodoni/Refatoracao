# CORRIGIR ERRO DE RUNTIME VFP9

## TAREFA OBRIGATORIA
O formulario VFP9 apresentou erro de runtime durante teste automatizado.
Voce DEVE corrigir o erro e salvar os arquivos corrigidos usando Write tool.

## ERRO DETECTADO
- Etapa: 06b_testeAutomatico
- Tentativa: 1/10
- Mensagem: Testes automaticos: 67% < 100%. Falhas: Teste 'CarregarLista': Nenhum cursor padrao foi criado (cursor_4c_Dados/Lista/Busca/etc); Teste 'ModoIncluir': Property ALTERNARPAGINA is not found. | Detalhes: Linha: 429; Teste 'ModoVisualizar': Property AJUSTARBOTOESPORMODO is not found. | Detalhes: Linha: 559

## CONTEXTO DO ERRO

### LOG DA ETAPA (06b_testeAutomatico):
[2026-09-02 02:24:33] [INFO] === VFP EXECUTOR v2.0 ===
[2026-09-02 02:24:33] [INFO] Config FPW: (nao fornecido)
[2026-09-02 02:24:33] [INFO] Script PRG: C:\4c\projeto\app\utils\TesteAutomatico.prg
[2026-09-02 02:24:33] [INFO] Timeout: 300 segundos
[2026-09-02 02:24:33] [INFO] Wrapper PRG criado para parametros: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_ejhjbzjx.prg
[2026-09-02 02:24:33] [INFO] Conteudo do wrapper:
[2026-09-02 02:24:33] [INFO] * Auto-generated wrapper for parameters
* Script: C:\4c\projeto\app\utils\TesteAutomatico.prg
* Parameters: 'FormScl', 'C:\4c\tasks\task517', 'CRUD'

* Anti-dialog protections for unattended execution
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
SET NOTIFY OFF
SYS(2335, 0)

DO "C:\4c\projeto\app\utils\TesteAutomatico" WITH 'FormScl', 'C:\4c\tasks\task517', 'CRUD'
QUIT

[2026-09-02 02:24:33] [INFO] Comando VFP: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_ejhjbzjx.prg
[2026-09-02 02:24:33] [INFO] VFP output esperado em: C:\4c\tasks\task517\vfp_output.txt
[2026-09-02 02:24:33] [INFO] Executando Visual FoxPro 9...
[2026-09-02 02:24:33] [INFO] Comando completo: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_ejhjbzjx.prg
[2026-09-02 02:24:33] [INFO] Executando: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_ejhjbzjx.prg
[2026-09-02 02:24:33] [INFO] Timeout configurado: 300 segundos
[2026-09-02 02:26:08] [INFO] VFP9 finalizou normalmente com exit code: 
[2026-09-02 02:26:08] [INFO] VFP9 finalizado em 95.1890315 segundos
[2026-09-02 02:26:08] [INFO] Exit Code: 
[2026-09-02 02:26:08] [INFO] 
[2026-09-02 02:26:08] [INFO] Arquivos temporarios preservados para inspecao:
[2026-09-02 02:26:08] [INFO]   Wrapper.prg: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_ejhjbzjx.prg
[2026-09-02 02:26:08] [INFO] 
[2026-09-02 02:26:08] [INFO] === Conteudo do Wrapper.prg temporario ===
[2026-09-02 02:26:08] [INFO] * Auto-generated wrapper for parameters
[2026-09-02 02:26:08] [INFO] * Script: C:\4c\projeto\app\utils\TesteAutomatico.prg
[2026-09-02 02:26:08] [INFO] * Parameters: 'FormScl', 'C:\4c\tasks\task517', 'CRUD'
[2026-09-02 02:26:08] [INFO] 
[2026-09-02 02:26:08] [INFO] * Anti-dialog protections for unattended execution
[2026-09-02 02:26:08] [INFO] SET SAFETY OFF
[2026-09-02 02:26:08] [INFO] SET RESOURCE OFF
[2026-09-02 02:26:08] [INFO] SET TALK OFF
[2026-09-02 02:26:08] [INFO] SET NOTIFY OFF
[2026-09-02 02:26:08] [INFO] SYS(2335, 0)
[2026-09-02 02:26:08] [INFO] 
[2026-09-02 02:26:08] [INFO] DO "C:\4c\projeto\app\utils\TesteAutomatico" WITH 'FormScl', 'C:\4c\tasks\task517', 'CRUD'
[2026-09-02 02:26:08] [INFO] QUIT
[2026-09-02 02:26:08] [INFO] 
[2026-09-02 02:26:08] [INFO] === Fim do Wrapper.prg ===
[2026-09-02 02:26:08] [WARN] AVISO: VFP9 retornou exit code  (normal para VFP9 GUI - validar pelo arquivo de saida)


### RESULTADO DOS TESTES (teste_resultado.json):
{
  "formClass": "FormScl",
  "timestamp": "20260902022608",
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

### FORM (C:\4c\projeto\app\forms\cadastros\FormScl.prg):
*==============================================================================
* FormScl.prg - Formulario de Cadastro de Situacao de Contas
* Tabela: SigCdCst | Chave: codigos
* Fase 8/8: Completo - AjustarBotoesPorModo + integracao menu/config
*==============================================================================

DEFINE CLASS FormScl AS FormBase

    *-- Propriedades visuais (PILAR 1 - UX Fidelity)
    Height      = 600
    Width       = 1000
    DataSession = 2
    AutoCenter  = .T.
    ShowWindow  = 1
    WindowType  = 1
    ControlBox  = .F.
    TitleBar    = 0
    Themes      = .F.
    BorderStyle = 2

    *-- Propriedades internas
    this_oBusinessObject = .NULL.
    this_cModoAtual      = "LISTA"

    *--------------------------------------------------------------------------
    PROCEDURE Init()
        RETURN DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            THIS.Caption = "Situa" + CHR(231) + CHR(227) + "o de Contas"

            THIS.this_oBusinessObject = CREATEOBJECT("SclBO")
            IF VARTYPE(THIS.this_oBusinessObject) != "O"
                MsgErro("Erro ao criar SclBO.", "Inicializa" + CHR(231) + CHR(227) + "o")
            ELSE
                THIS.ConfigurarPageFrame()
                THIS.ConfigurarPaginaLista()
                THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
                THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
                THIS.ConfigurarPaginaDados()

                IF TYPE("gb_4c_ValidandoUI") != "L" OR !gb_4c_ValidandoUI
                    THIS.CarregarLista()
                ENDIF

                THIS.pgf_4c_Paginas.Visible = .T.
                THIS.pgf_4c_Paginas.ActivePage = 1
                THIS.this_cModoAtual = "LISTA"
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loException
            MsgErro("Erro ao inicializar FormScl:" + CHR(13) + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPageFrame()
        THIS.AddObject("pgf_4c_Paginas", "PageFrame")
        WITH THIS.pgf_4c_Paginas
            .PageCount = 2
            .Top       = -29
            .Left      = 0
            .Width     = THIS.Width
            .Height    = THIS.Height + 29
            .Tabs      = .F.
            .TabStop   = .F.
            .Visible   = .T.
            .Page1.Caption = "Lista"
            .Page1.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
            .Page2.Caption = "Dados"
            .Page2.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPaginaLista()
        LOCAL loc_oPagina
        loc_oPagina = THIS.pgf_4c_Paginas.Page1

        *-- Fundo padrao do framework frmcadastro (sem isso a pagina fica branca)
        loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"

        *-- Cabecalho (cntSombra no legado)
        loc_oPagina.AddObject("cnt_4c_Cabecalho", "Container")
        WITH loc_oPagina.cnt_4c_Cabecalho
            .Top         = 31
            .Left        = 0
            .Width       = THIS.Width
            .Height      = 80
            .BackColor   = RGB(100, 100, 100)
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH

        loc_oPagina.cnt_4c_Cabecalho.AddObject("lbl_4c_Sombra", "Label")
        WITH loc_oPagina.cnt_4c_Cabecalho.lbl_4c_Sombra
            .Caption   = "Situa" + CHR(231) + CHR(227) + "o de Contas"
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
            .Caption   = "Situa" + CHR(231) + CHR(227) + "o de Contas"
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

        *-- Container botoes CRUD (Grupo_op no legado, Left=544 original -> canonico Left=542)
        loc_oPagina.AddObject("cnt_4c_Botoes", "Container")
        WITH loc_oPagina.cnt_4c_Botoes
            .Top         = 29
            .Left        = 542
            .Width       = 385
            .Height      = 85
            .BackStyle = 0
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH

        *-- Botao Incluir
        loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Incluir", "CommandButton")
        WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Incluir
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
        BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Incluir, "Click", THIS, "BtnIncluirClick")

        *-- Botao Visualizar
        loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Visualizar", "CommandButton")
        WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar
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
        BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar, "Click", THIS, "BtnVisualizarClick")

        *-- Botao Alterar
        loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Alterar", "CommandButton")
        WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar
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
        BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar, "Click", THIS, "BtnAlterarClick")

        *-- Botao Excluir
        loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Excluir", "CommandButton")
        WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir
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
        BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir, "Click", THIS, "BtnExcluirClick")

        *-- Botao Buscar
        loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Buscar", "CommandButton")
        WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Buscar
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
        BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Buscar, "Click", THIS, "BtnBuscarClick")

        *-- Container saida canonico (CLAUDE.md regra #10 - prevalece sobre legado)
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

        *-- Botao Encerrar (canonico)
        loc_oPagina.cnt_4c_Saida.AddObject("cmd_4c_Encerrar", "CommandButton")
        WITH loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar
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
        BINDEVENT(loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar, "Click", THIS, "BtnEncerrarClick")

        *-- Grid de listagem (Grade no legado: top=98, left=29, width=941, height=487)
        *-- Top compensado: 98 + 29 = 127 (PageFrame.Top = -29)
        loc_oPagina.AddObject("grd_4c_Lista", "Grid")
        *-- ColumnCount FORA de WITH para colunas serem criadas imediatamente (Problema 36)
        loc_oPagina.grd_4c_Lista.ColumnCount = 4
        WITH loc_oPagina.grd_4c_Lista
            .Top                = 127
            .Left               = 29
            .Width              = 941
            .Height             = 487
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
            .HeaderHeight       = 22
            .Visible            = .T.
        ENDWITH
        *-- Larguras das colunas conforme pColuna do legado: 70, 240, 240, 70
        loc_oPagina.grd_4c_Lista.Column1.Width = 70
        loc_oPagina.grd_4c_Lista.Column2.Width = 240
        loc_oPagina.grd_4c_Lista.Column3.Width = 240
        loc_oPagina.grd_4c_Lista.Column4.Width = 70

        THIS.TornarControlesVisiveis(loc_oPagina)
    ENDPROC

    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPaginaDados()
        LOCAL loc_oPagina
        loc_oPagina = THIS.pgf_4c_Paginas.Page2

        *-- Fundo padrao do framework frmcadastro (sem isso a pagina fica branca)
        loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"

        *-- Container botoes acao (Grupo_Salva: Left=843, Top=-3, Width=160)
        *-- Top compensado: -3+29=26
        loc_oPagina.AddObject("cnt_4c_Salva", "Container")
        WITH loc_oPagina.cnt_4c_Salva
            .Top         = 26
            .Left        = 843
            .Width       = 160
            .Height      = 85
            .BackStyle   = 0
            .Visible     = .T.
        ENDWITH

        *-- Botao Confirmar (Salvar)
        loc_oPagina.cnt_4c_Salva.AddObject("cmd_4c_Confirmar", "CommandButton")
        WITH loc_oPagina.cnt_4c_Salva.cmd_4c_Confirmar
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
        BINDEVENT(loc_oPagina.cnt_4c_Salva.cmd_4c_Confirmar, "Click", THIS, "BtnSalvarClick")

        *-- Botao Cancelar
        loc_oPagina.cnt_4c_Salva.AddObject("cmd_4c_Cancelar", "CommandButton")
        WITH loc_oPagina.cnt_4c_Salva.cmd_4c_Cancelar
            .Caption         = "Encerrar"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_cancelar_60.jpg"
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
        BINDEVENT(loc_oPagina.cnt_4c_Salva.cmd_4c_Cancelar, "Click", THIS, "BtnCancelarClick")

        *-- Codigo (Get_Codigo: legado top=151, left=251, w=31 -> top compensado=180)
        loc_oPagina.AddObject("lbl_4c_Codigo_label", "Label")
        WITH loc_oPagina.lbl_4c_Codigo_label
            .Caption   = "C" + CHR(243) + "digo :"
            .Top       = 184
            .Left      = 207
            .Width     = 45
            .Height    = 17
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("txt_4c_Codigo", "TextBox")
        WITH loc_oPagina.txt_4c_Codigo
            .Value     = ""
            .Top       = 180
            .Left      = 251
            .Width     = 31
            .Height    = 23
            .MaxLength = 3
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Visible   = .T.
        ENDWITH

        *-- Movimentacao (op_com: legado top=155, left=631, w=116 -> top compensado=184)
        loc_oPagina.AddObject("lbl_4c_Movimentacao_label", "Label")
        WITH loc_oPagina.lbl_4c_Movimentacao_label
            .Caption   = "Movimenta" + CHR(231) + CHR(227) + "o :"
            .Top       = 189
            .Left      = 555
            .Width     = 78
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("opt_4c_Movimentacao", "OptionGroup")
        WITH loc_oPagina.opt_4c_Movimentacao
            .ButtonCount = 2
            .Top         = 184
            .Left        = 631
            .Width       = 116
            .Height      = 25
            .BackStyle   = 0
            .BorderStyle = 0
            .Value       = 1
            .Visible     = .T.
        ENDWITH
        WITH loc_oPagina.opt_4c_Movimentacao.Buttons(1)
            .Caption   = "Sim"
            .BackStyle = 0
            .Left      = 5
            .Top       = 5
            .Width     = 40
            .AutoSize  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
        ENDWITH
        WITH loc_oPagina.opt_4c_Movimentacao.Buttons(2)
            .Caption   = "N" + CHR(227) + "o"
            .BackStyle = 0
            .Left      = 48
            .Top       = 5
            .Width     = 40
            .AutoSize  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
        ENDWITH

        *-- Descricao (Get_Descr: legado top=176, left=251, w=220 -> top compensado=205)
        loc_oPagina.AddObject("lbl_4c_Descr_label", "Label")
        WITH loc_oPagina.lbl_4c_Descr_label
            .Caption   = "Descri" + CHR(231) + CHR(227) + "o :"
            .Top       = 209
            .Left      = 194
            .Width     = 55
            .Height    = 17
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("txt_4c_Descr", "TextBox")
        WITH loc_oPagina.txt_4c_Descr
            .Value     = ""
            .Top       = 205
            .Left      = 251
            .Width     = 220
            .Height    = 23
            .MaxLength = 30
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Visible   = .T.
        ENDWITH

        *-- Bloquear Movimentacao (op_blqMov: legado top=180, left=631, w=276, 3 btns -> top=209)
        loc_oPagina.AddObject("lbl_4c_BlqMov_label", "Label")
        WITH loc_oPagina.lbl_4c_BlqMov_label
            .Caption   = "Bloquear Movimenta" + CHR(231) + CHR(227) + "o :"
            .Top       = 214
            .Left      = 510
            .Width     = 123
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("opt_4c_BlqMov", "OptionGroup")
        WITH loc_oPagina.opt_4c_BlqMov
            .ButtonCount = 3
            .Top         = 209
            .Left        = 631
            .Width       = 276
            .Height      = 25
            .BackStyle   = 0
            .BorderStyle = 0
            .Value       = 1
            .Visible     = .T.
        ENDWITH
        WITH loc_oPagina.opt_4c_BlqMov.Buttons(1)
            .Caption   = "Sim"
            .BackStyle = 0
            .Left      = 5
            .Top       = 5
            .Width     = 40
            .AutoSize  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
        ENDWITH
        WITH loc_oPagina.opt_4c_BlqMov.Buttons(2)
            .Caption   = "N" + CHR(227) + "o"
            .BackStyle = 0
            .Left      = 48
            .Top       = 5
            .Width     = 40
            .AutoSize  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
        ENDWITH
        WITH loc_oPagina.opt_4c_BlqMov.Buttons(3)
            .Caption   = "Verifica Cond. Pagto."
            .BackStyle = 0
            .Left      = 90
            .Top       = 5
            .Width     = 170
            .AutoSize  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
        ENDWITH

        *-- Descricao Para Movimentacoes (get_Descr2: legado top=201, left=251, w=220 -> top=230)
        loc_oPagina.AddObject("lbl_4c_Descr2_label", "Label")
        WITH loc_oPagina.lbl_4c_Descr2_label
            .Caption   = "Descri" + CHR(231) + CHR(227) + "o Para Movimenta" + ;
                         CHR(231) + CHR(245) + "es :"
            .Top       = 234
            .Left      = 92
            .Width     = 155
            .Height    = 17
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("txt_4c_Descr2", "TextBox")
        WITH loc_oPagina.txt_4c_Descr2
            .Value     = ""
            .Top       = 230
            .Left      = 251
            .Width     = 220
            .Height    = 23
            .MaxLength = 30
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Visible   = .T.
        ENDWITH

        *-- Bloquear Desconto (fwoption1: legado top=205, left=631, w=116 -> top compensado=234)
        loc_oPagina.AddObject("lbl_4c_BlqDesconto_label", "Label")
        WITH loc_oPagina.lbl_4c_BlqDesconto_label
            .Caption   = "Bloquear Desconto :"
            .Top       = 239
            .Left      = 534
            .Width     = 99
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("opt_4c_BlqDesconto", "OptionGroup")
        WITH loc_oPagina.opt_4c_BlqDesconto
            .ButtonCount = 2
            .Top         = 234
            .Left        = 631
            .Width       = 116
            .Height      = 25
            .BackStyle   = 0
            .BorderStyle = 0
            .Value       = 1
            .Visible     = .T.
        ENDWITH
        WITH loc_oPagina.opt_4c_BlqDesconto.Buttons(1)
            .Caption   = "Sim"
            .BackStyle = 0
            .Left      = 5
            .Top       = 5
            .Width     = 40
            .AutoSize  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
        ENDWITH
        WITH loc_oPagina.opt_4c_BlqDesconto.Buttons(2)
            .Caption   = "N" + CHR(227) + "o"
            .BackStyle = 0
            .Left      = 48
            .Top       = 5
            .Width     = 40
            .AutoSize  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
        ENDWITH

        *-- Mala Direta (getMalad: legado top=226, left=251, w=19 -> top compensado=255)
        loc_oPagina.AddObject("lbl_4c_Say3", "Label")
        WITH loc_oPagina.lbl_4c_Say3
            .Caption   = "Mala Direta :"
            .Top       = 259
            .Left      = 186
            .Width     = 70
            .Height    = 17
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("txt_4c_Malad", "TextBox")
        WITH loc_oPagina.txt_4c_Malad
            .Value         = ""
            .Top           = 255
            .Left          = 251
            .Width         = 19
            .Height        = 23
            .MaxLength     = 1
            .Format        = "M"
            .InputMask     = "S,N, "
            .FontName      = "Tahoma"
            .FontSize      = 8
            .SpecialEffect = 1
            .Visible       = .T.
        ENDWITH

        *-- Prioridade (fwget1: legado top=252, left=251, w=31 -> top compensado=281)
        loc_oPagina.AddObject("lbl_4c_Say4", "Label")
        WITH loc_oPagina.lbl_4c_Say4
            .Caption   = "Prioridade :"
            .Top       = 286
            .Left      = 192
            .Width     = 60
            .Height    = 17
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("txt_4c_Priors", "TextBox")
        WITH loc_oPagina.txt_4c_Priors
            .Value         = 0
            .Top           = 281
            .Left          = 251
            .Width         = 31
            .Height        = 23
            .MaxLength     = 3
            .InputMask     = "999"
            .FontName      = "Tahoma"
            .FontSize      = 8
            .SpecialEffect = 1
            .Visible       = .T.
        ENDWITH

        *-- Tipo (optAutos: legado top=229, left=631, w=151 -> top compensado=258)
        loc_oPagina.AddObject("lbl_4c_Say5", "Label")
        WITH loc_oPagina.lbl_4c_Say5
            .Caption   = "Tipo :"
            .Top       = 263
            .Left      = 604
            .Width     = 29
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("opt_4c_Autos", "OptionGroup")
        WITH loc_oPagina.opt_4c_Autos
            .ButtonCount = 2
            .Top         = 258
            .Left        = 631
            .Width       = 151
            .Height      = 25
            .BackStyle   = 0
            .BorderStyle = 0
            .Value       = 1
            .Visible     = .T.
        ENDWITH
        WITH loc_oPagina.opt_4c_Autos.Buttons(1)
            .Caption   = "Normal"
            .BackStyle = 0
            .Left      = 5
            .Top       = 5
            .AutoSize  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
        ENDWITH
        WITH loc_oPagina.opt_4c_Autos.Buttons(2)
            .Caption   = "Autom" + CHR(225) + "tica"
            .BackStyle = 0
            .Left      = 74
            .Top       = 5
            .AutoSize  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
        ENDWITH

        *-- Exibe dados da Ultima Compra (Fwoption2: legado top=251, left=632, w=116 -> top=280)
        loc_oPagina.AddObject("lbl_4c_Say7", "Label")
        WITH loc_oPagina.lbl_4c_Say7
            .Caption   = "Exibe dados da Ultima Compra :"
            .Top       = 286
            .Left      = 479
            .Width     = 154
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("opt_4c_UltCompra", "OptionGroup")
        WITH loc_oPagina.opt_4c_UltCompra
            .ButtonCount = 2
            .Top         = 280
            .Left        = 632
            .Width       = 116
            .Height      = 25
            .BackStyle   = 0
            .BorderStyle = 0
            .Value       = 1
            .Visible     = .T.
        ENDWITH
        WITH loc_oPagina.opt_4c_UltCompra.Buttons(1)
            .Caption   = "Sim"
            .BackStyle = 0
            .Left      = 5
            .Top       = 5
            .AutoSize  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
        ENDWITH
        WITH loc_oPagina.opt_4c_UltCompra.Buttons(2)
            .Caption   = "N" + CHR(227) + "o"
            .BackStyle = 0
            .Left      = 74
            .Top       = 5
            .AutoSize  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
        ENDWITH

        *-- Label informativa [999] Situacao Liberada (Label1: legado top=256, left=286 -> top=285)
        loc_oPagina.AddObject("lbl_4c_Label1", "Label")
        WITH loc_oPagina.lbl_4c_Label1
            .Caption   = "[999] Situa" + CHR(231) + CHR(227) + "o Liberada"
            .Top       = 285
            .Left      = 286
            .Width     = 116
            .Height    = 15
            .AutoSize  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        THIS.TornarControlesVisiveis(loc_oPagina)
    ENDPROC

    *--------------------------------------------------------------------------
    PROCEDURE CarregarLista()
        LOCAL loc_lResultado, loc_oGrid
        loc_lResultado = .F.

        IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
            RETURN .T.
        ENDIF

        TRY
            IF THIS.this_oBusinessObject.Buscar("")
                loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Lista
                *-- RecordSource FORA de WITH (Problema 36/48 - auto-bind)
                loc_oGrid.ColumnCount = 4
                loc_oGrid.RecordSource = "cursor_4c_Dados"
                *-- ControlSource APOS RecordSource (Problema 48)
                loc_oGrid.Column1.ControlSource = "cursor_4c_Dados.codigos"
                loc_oGrid.Column2.ControlSource = "cursor_4c_Dados.descrs"
                loc_oGrid.Column3.ControlSource = "cursor_4c_Dados.descr2s"
                loc_oGrid.Column4.ControlSource = "cursor_4c_Dados.cMalads"
                *-- Larguras apos ControlSource
                loc_oGrid.Column1.Width = 70
                loc_oGrid.Column2.Width = 240
                loc_oGrid.Column3.Width = 240
                loc_oGrid.Column4.Width = 70
                *-- Headers APOS RecordSource (Problema 32 - reset de captions)
                loc_oGrid.Column1.Header1.Caption = "C" + CHR(243) + "digo"
                loc_oGrid.Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
                loc_oGrid.Column3.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o 2"
                loc_oGrid.Column4.Header1.Caption = "Mala Direta"
                THIS.FormatarGridLista(loc_oGrid)
                THIS.AjustarBotoesPorModo()
                loc_lResultado = .T.
            ENDIF
        CATCH TO loException
            MsgErro("Erro ao carregar lista:" + CHR(13) + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE AlternarPagina(par_nPagina)
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
            MsgErro("Erro ao alternar p" + CHR(225) + "gina:" + CHR(13) + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * Metodos de click dos botoes CRUD (PUBLIC para BINDEVENT funcionar)
    *--------------------------------------------------------------------------

    PROCEDURE BtnIncluirClick()
        THIS.this_oBusinessObject.NovoRegistro()
        THIS.this_cModoAtual = "INCLUIR"
        THIS.LimparCampos()
        THIS.HabilitarCampos(.T.)
        THIS.AlternarPagina(2)
        THIS.pgf_4c_Paginas.Page2.txt_4c_Codigo.SetFocus()
    ENDPROC

    *--------------------------------------------------------------------------
    PROCEDURE BtnVisualizarClick()
        LOCAL loc_cCodigo
        IF !USED("cursor_4c_Dados") OR RECCOUNT("cursor_4c_Dados") = 0 OR EOF("cursor_4c_Dados")
            MsgAviso("Selecione um registro na lista.", "Visualizar")
            RETURN
        ENDIF
        SELECT cursor_4c_Dados
        loc_cCodigo = ALLTRIM(codigos)
        IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
            THIS.this_cModoAtual = "VISUALIZAR"
            THIS.BOParaForm()
            THIS.HabilitarCampos(.F.)
            THIS.AlternarPagina(2)
            THIS.pgf_4c_Paginas.Page2.cnt_4c_Salva.cmd_4c_Confirmar.SetFocus()
        ELSE
            MsgErro("Registro n" + CHR(227) + "o encontrado.", "Visualizar")
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    PROCEDURE BtnAlterarClick()
        LOCAL loc_cCodigo
        IF !USED("cursor_4c_Dados") OR RECCOUNT("cursor_4c_Dados") = 0 OR EOF("cursor_4c_Dados")
            MsgAviso("Selecione um registro na lista.", "Alterar")
            RETURN
        ENDIF
        SELECT cursor_4c_Dados
        loc_cCodigo = ALLTRIM(codigos)
        IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
            THIS.this_oBusinessObject.EditarRegistro()
            THIS.this_cModoAtual = "ALTERAR"
            THIS.BOParaForm()
            THIS.HabilitarCampos(.T.)
            THIS.AlternarPagina(2)
            THIS.pgf_4c_Paginas.Page2.txt_4c_Descr.SetFocus()
        ELSE
            MsgErro("Registro n" + CHR(227) + "o encontrado.", "Alterar")
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    PROCEDURE BtnExcluirClick()
        LOCAL loc_cCodigo
        IF !USED("cursor_4c_Dados") OR RECCOUNT("cursor_4c_Dados") = 0 OR EOF("cursor_4c_Dados")
            MsgAviso("Selecione um registro na lista.", "Excluir")
            RETURN
        ENDIF
        SELECT cursor_4c_Dados
        loc_cCodigo = ALLTRIM(codigos)
        IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
            THIS.this_cModoAtual = "EXCLUIR"
            THIS.BOParaForm()
            THIS.HabilitarCampos(.F.)
            THIS.AlternarPagina(2)
            THIS.pgf_4c_Paginas.Page2.cnt_4c_Salva.cmd_4c_Confirmar.SetFocus()
        ELSE
            MsgErro("Registro n" + CHR(227) + "o encontrado.", "Excluir")
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    PROCEDURE BtnBuscarClick()
        THIS.CarregarLista()
    ENDPROC

    *--------------------------------------------------------------------------
    PROCEDURE BtnEncerrarClick()
        THIS.Release()
    ENDPROC

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
    PROCEDURE BtnSalvarClick()
        LOCAL loc_oPg2, loc_cCodigo
        loc_oPg2 = THIS.pgf_4c_Paginas.Page2

        *-- Validacoes de UI fora do TRY (CLAUDE.md regra: RETURN fora de TRY)
        IF THIS.this_cModoAtual = "INCLUIR" OR THIS.this_cModoAtual = "ALTERAR"
            loc_cCodigo = ALLTRIM(loc_oPg2.txt_4c_Codigo.Value)
            IF EMPTY(loc_cCodigo)
                MsgAviso("Dados Inv" + CHR(225) + "lidos", "Valida" + CHR(231) + CHR(227) + "o")
                loc_oPg2.txt_4c_Codigo.SetFocus()
                RETURN
            ENDIF
            IF !INLIST(UPPER(ALLTRIM(loc_oPg2.txt_4c_Malad.Value)), "S", "N")
                MsgAviso("Especifica" + CHR(231) + CHR(227) + "o da Mala Direta Inv" + CHR(225) + ;
                         "lida, Apenas [S]im ou [N]" + CHR(227) + "o.", "Valida" + CHR(231) + CHR(227) + "o")
                loc_oPg2.txt_4c_Malad.SetFocus()
                RETURN
            ENDIF
        ENDIF

        IF THIS.this_cModoAtual = "EXCLUIR"
            IF !MsgConfirma("Confirma exclus" + CHR(227) + "o do registro?", "Excluir")
                RETURN
            ENDIF
            TRY
                IF THIS.this_oBusinessObject.Excluir()
                    THIS.AlternarPagina(1)
                    THIS.this_cModoAtual = "LISTA"
                ENDIF
            CATCH TO loException
                MsgErro("Erro ao excluir:" + CHR(13) + loException.Message, "Erro")
            ENDTRY
            RETURN
        ENDIF

        *-- INCLUIR ou ALTERAR
        TRY
            THIS.FormParaBO()
            IF THIS.this_oBusinessObject.Salvar()
                THIS.AlternarPagina(1)
                THIS.this_cModoAtual = "LISTA"
            ENDIF
        CATCH TO loException
            MsgErro("Erro ao salvar:" + CHR(13) + loException.Message, "Erro")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    PROCEDURE BtnCancelarClick()
        THIS.AlternarPagina(1)
        THIS.this_cModoAtual = "LISTA"
        THIS.CarregarLista()
    ENDPROC

    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE FormParaBO()
        LOCAL loc_oPg2
        loc_oPg2 = THIS.pgf_4c_Paginas.Page2
        THIS.this_oBusinessObject.this_cCodigos   = ALLTRIM(loc_oPg2.txt_4c_Codigo.Value)
        THIS.this_oBusinessObject.this_cDescrs    = ALLTRIM(loc_oPg2.txt_4c_Descr.Value)
        THIS.this_oBusinessObject.this_cDescr2s   = ALLTRIM(loc_oPg2.txt_4c_Descr2.Value)
        THIS.this_oBusinessObject.this_cMalads    = UPPER(ALLTRIM(loc_oPg2.txt_4c_Malad.Value))
        THIS.this_oBusinessObject.this_nDispMovs  = loc_oPg2.opt_4c_Movimentacao.Value - 1
        THIS.this_oBusinessObject.this_nBlqMovs   = loc_oPg2.opt_4c_BlqMov.Value - 1
        THIS.this_oBusinessObject.this_nBlqDescs  = loc_oPg2.opt_4c_BlqDesconto.Value - 1
        THIS.this_oBusinessObject.this_nAutos     = loc_oPg2.opt_4c_Autos.Value - 1
        THIS.this_oBusinessObject.this_nPriors    = loc_oPg2.txt_4c_Priors.Value
        THIS.this_oBusinessObject.this_nUltCompra = loc_oPg2.opt_4c_UltCompra.Value - 1
    ENDPROC

    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE BOParaForm()
        LOCAL loc_oPg2, loc_nVal
        loc_oPg2 = THIS.pgf_4c_Paginas.Page2
        loc_oPg2.txt_4c_Codigo.Value       = ALLTRIM(THIS.this_oBusinessObject.this_cCodigos)
        loc_oPg2.txt_4c_Descr.Value        = ALLTRIM(THIS.this_oBusinessObject.this_cDescrs)
        loc_oPg2.txt_4c_Descr2.Value       = ALLTRIM(THIS.this_oBusinessObject.this_cDescr2s)
        loc_oPg2.txt_4c_Malad.Value        = ALLTRIM(THIS.this_oBusinessObject.this_cMalads)
        loc_oPg2.txt_4c_Priors.Value       = THIS.this_oBusinessObject.this_nPriors

        *-- OptionGroups: DB value 0-based -> VFP9 Value 1-based (valor+1)
        loc_nVal = THIS.this_oBusinessObject.this_nDispMovs + 1
        loc_oPg2.opt_4c_Movimentacao.Value = IIF(loc_nVal >= 1 AND loc_nVal <= 2, loc_nVal, 1)

        loc_nVal = THIS.this_oBusinessObject.this_nBlqMovs + 1
        loc_oPg2.opt_4c_BlqMov.Value       = IIF(loc_nVal >= 1 AND loc_nVal <= 3, loc_nVal, 1)

        loc_nVal = THIS.this_oBusinessObject.this_nBlqDescs + 1
        loc_oPg2.opt_4c_BlqDesconto.Value  = IIF(loc_nVal >= 1 AND loc_nVal <= 2, loc_nVal, 1)

        loc_nVal = THIS.this_oBusinessObject.this_nAutos + 1
        loc_oPg2.opt_4c_Autos.Value        = IIF(loc_nVal >= 1 AND loc_nVal <= 2, loc_nVal, 1)

        loc_nVal = THIS.this_oBusinessObject.this_nUltCompra + 1
        loc_oPg2.opt_4c_UltCompra.Value    = IIF(loc_nVal >= 1 AND loc_nVal <= 2, loc_nVal, 1)
    ENDPROC

    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE LimparCampos()
        LOCAL loc_oPg2
        loc_oPg2 = THIS.pgf_4c_Paginas.Page2
        loc_oPg2.txt_4c_Codigo.Value           = ""
        loc_oPg2.txt_4c_Descr.Value            = ""
        loc_oPg2.txt_4c_Descr2.Value           = ""
        loc_oPg2.txt_4c_Malad.Value            = ""
        loc_oPg2.txt_4c_Priors.Value           = 0
        loc_oPg2.opt_4c_Movimentacao.Value     = 1
        loc_oPg2.opt_4c_BlqMov.Value           = 1
        loc_oPg2.opt_4c_BlqDesconto.Value      = 1
        loc_oPg2.opt_4c_Autos.Value            = 1
        loc_oPg2.opt_4c_UltCompra.Value        = 1
    ENDPROC

    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE HabilitarCampos(par_lHabilitar)
        LOCAL loc_oPg2
        loc_oPg2 = THIS.pgf_4c_Paginas.Page2

        *-- Codigo: editavel apenas em INCLUIR
        loc_oPg2.txt_4c_Codigo.Enabled         = par_lHabilitar AND (THIS.this_cModoAtual = "INCLUIR")
        loc_oPg2.txt_4c_Descr.Enabled          = par_lHabilitar
        loc_oPg2.txt_4c_Descr2.Enabled         = par_lHabilitar
        loc_oPg2.txt_4c_Malad.Enabled          = par_lHabilitar
        loc_oPg2.txt_4c_Priors.Enabled         = par_lHabilitar
        loc_oPg2.opt_4c_Movimentacao.Enabled   = par_lHabilitar
        loc_oPg2.opt_4c_BlqMov.Enabled         = par_lHabilitar
        loc_oPg2.opt_4c_BlqDesconto.Enabled    = par_lHabilitar
        loc_oPg2.opt_4c_Autos.Enabled          = par_lHabilitar
        loc_oPg2.opt_4c_UltCompra.Enabled      = par_lHabilitar

        *-- Confirmar: habilitado em INCLUIR/ALTERAR e tambem em EXCLUIR (para confirmar exclusao)
        loc_oPg2.cnt_4c_Salva.cmd_4c_Confirmar.Enabled = par_lHabilitar OR ;
            (THIS.this_cModoAtual = "EXCLUIR")
    ENDPROC

    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE AjustarBotoesPorModo()
        LOCAL loc_oPg1, loc_lTemRegistro
        loc_oPg1 = THIS.pgf_4c_Paginas.Page1
        loc_lTemRegistro = USED("cursor_4c_Dados") AND ;
                           RECCOUNT("cursor_4c_Dados") > 0 AND ;
                           !EOF("cursor_4c_Dados")
        loc_oPg1.cnt_4c_Botoes.cmd_4c_Visualizar.Enabled = loc_lTemRegistro
        loc_oPg1.cnt_4c_Botoes.cmd_4c_Alterar.Enabled    = loc_lTemRegistro
        loc_oPg1.cnt_4c_Botoes.cmd_4c_Excluir.Enabled    = loc_lTemRegistro
    ENDPROC

    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE FormatarGridLista(par_oGrid)
        WITH par_oGrid
            .FontName = "Tahoma"
            .FontSize = 8
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
        IF VARTYPE(THIS.this_oBusinessObject) = "O"
            THIS.this_oBusinessObject = .NULL.
        ENDIF
        DODEFAULT()
    ENDPROC

ENDDEFINE


### BO (C:\4c\projeto\app\classes\SclBO.prg):
*==============================================================================
* SclBO.prg - Business Object para Situacao de Contas
* Tabela: SigCdCst | PK: codigos
*==============================================================================

DEFINE CLASS SclBO AS BusinessBase

    *-- Propriedades - SigCdCst
    this_cCodigos  = ""    && codigos  char(3)
    this_cDescrs   = ""    && descrs   char(30)
    this_cDescr2s  = ""    && descr2s  char(30) - Descricao Para Movimentacoes
    this_cMalads   = ""    && cmalads  char(1)  - Mala Direta (S/N)
    this_nDispMovs = 0     && dispmovs numeric(1,0) - Movimentacao (0=Sim 1=Nao)
    this_nPriors   = 0     && priors   numeric(3,0) - Prioridade
    this_nAutos    = 0     && autos    numeric(1,0) - Tipo (0=Normal 1=Automatica)
    this_nBlqMovs  = 0     && blqmovs  numeric(1,0) - Bloquear Movimentacao (0=Sim 1=Nao 2=VerificaCondPagto)
    this_nBlqDescs = 0     && blqdescs numeric(1,0) - Bloquear Desconto (0=Sim 1=Nao)
    this_nUltCompra = 0    && ultcompra numeric(6,3) - Exibe dados Ultima Compra (0=Sim 1=Nao)

    *--------------------------------------------------------------------------
    PROCEDURE Init()
        DODEFAULT()
        THIS.this_cTabela     = "SigCdCst"
        THIS.this_cCampoChave = "codigos"
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    FUNCTION ObterChavePrimaria()
        RETURN THIS.this_cCodigos
    ENDFUNC

    *--------------------------------------------------------------------------
    FUNCTION CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lResultado
        loc_lResultado = .F.
        IF USED(par_cAliasCursor)
            SELECT (par_cAliasCursor)
            THIS.this_cCodigos   = TratarNulo(codigos,   "C")
            THIS.this_cDescrs    = TratarNulo(descrs,    "C")
            THIS.this_cDescr2s   = TratarNulo(descr2s,   "C")
            THIS.this_cMalads    = TratarNulo(cmalads,   "C")
            THIS.this_nDispMovs  = TratarNulo(dispmovs,  "N")
            THIS.this_nPriors    = TratarNulo(priors,    "N")
            THIS.this_nAutos     = TratarNulo(autos,     "N")
            THIS.this_nBlqMovs   = TratarNulo(blqmovs,   "N")
            THIS.this_nBlqDescs  = TratarNulo(blqdescs,  "N")
            THIS.this_nUltCompra = TratarNulo(ultcompra, "N")
            loc_lResultado = .T.
        ENDIF
        RETURN loc_lResultado
    ENDFUNC

    *--------------------------------------------------------------------------
    FUNCTION Buscar(par_cFiltro)
        LOCAL loc_lResultado, loc_cSQL, loc_nResult
        loc_lResultado = .F.

        TRY
            IF USED("cursor_4c_Dados")
                USE IN cursor_4c_Dados
            ENDIF

            loc_cSQL = "SELECT codigos, descrs, descr2s, cmalads," + ;
                       " dispmovs, priors, autos, blqmovs, blqdescs, ultcompra" + ;
                       " FROM SigCdCst"

            IF !EMPTY(ALLTRIM(par_cFiltro))
                loc_cSQL = loc_cSQL + " WHERE " + ALLTRIM(par_cFiltro)
            ENDIF

            loc_cSQL = loc_cSQL + " ORDER BY codigos"

            *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
            IF USED("cursor_4c_Dados")
                TABLEREVERT(.T., "cursor_4c_Dados")
                USE IN cursor_4c_Dados
            ENDIF

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")
            IF loc_nResult >= 0
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao buscar Situa" + CHR(231) + CHR(227) + "o de Contas:" + ;
                        CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loException
            MsgErro("Erro: " + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDFUNC

    *--------------------------------------------------------------------------
    FUNCTION CarregarPorCodigo(par_cCodigo)
        LOCAL loc_lResultado, loc_cSQL, loc_nResult
        loc_lResultado = .F.

        TRY
            IF USED("cursor_4c_Carrega")
                USE IN cursor_4c_Carrega
            ENDIF

            loc_cSQL = "SELECT codigos, descrs, descr2s, cmalads," + ;
                       " dispmovs, priors, autos, blqmovs, blqdescs, ultcompra" + ;
                       " FROM SigCdCst WHERE codigos = " + EscaparSQL(ALLTRIM(par_cCodigo))

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")
            IF loc_nResult >= 0 AND RECCOUNT("cursor_4c_Carrega") > 0
                loc_lResultado = THIS.CarregarDoCursor("cursor_4c_Carrega")
                THIS.this_lNovoRegistro = .F.
            ENDIF

            IF USED("cursor_4c_Carrega")
                USE IN cursor_4c_Carrega
            ENDIF
        CATCH TO loException
            MsgErro("Erro: " + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDFUNC

    *--------------------------------------------------------------------------
    PROTECTED FUNCTION Validar()
        LOCAL loc_lValido
        loc_lValido = .T.

        IF EMPTY(ALLTRIM(THIS.this_cCodigos))
            MsgAviso("C" + CHR(243) + "digo obrigat" + CHR(243) + "rio.", "Valida" + CHR(231) + CHR(227) + "o")
            loc_lValido = .F.
        ENDIF

        IF loc_lValido AND !INLIST(UPPER(ALLTRIM(THIS.this_cMalads)), "S", "N")
            MsgAviso("Especifica" + CHR(231) + CHR(227) + "o da Mala Direta Inv" + CHR(225) + "lida, Apenas [S]im ou [N]" + CHR(227) + "o.", "Valida" + CHR(231) + CHR(227) + "o")
            loc_lValido = .F.
        ENDIF

        RETURN loc_lValido
    ENDFUNC

    *--------------------------------------------------------------------------
    PROTECTED FUNCTION Inserir()
        LOCAL loc_lResultado, loc_cSQL, loc_nResult
        loc_lResultado = .F.

        TRY
            loc_cSQL = "INSERT INTO SigCdCst" + ;
                       " (codigos, descrs, descr2s, cmalads," + ;
                       " dispmovs, priors, autos, blqmovs, blqdescs, ultcompra)" + ;
                       " VALUES (" + ;
                       EscaparSQL(THIS.this_cCodigos)             + ", " + ;
                       EscaparSQL(THIS.this_cDescrs)              + ", " + ;
                       EscaparSQL(THIS.this_cDescr2s)             + ", " + ;
                       EscaparSQL(UPPER(THIS.this_cMalads))       + ", " + ;
                       FormatarNumeroSQL(THIS.this_nDispMovs)      + ", " + ;
                       FormatarNumeroSQL(THIS.this_nPriors)        + ", " + ;
                       FormatarNumeroSQL(THIS.this_nAutos)         + ", " + ;
                       FormatarNumeroSQL(THIS.this_nBlqMovs)       + ", " + ;
                       FormatarNumeroSQL(THIS.this_nBlqDescs)      + ", " + ;
                       FormatarNumeroSQL(THIS.this_nUltCompra)     + ")"

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nResult >= 0
                THIS.RegistrarAuditoria("INSERT")
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao inserir Situa" + CHR(231) + CHR(227) + "o de Contas:" + ;
                        CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loException
            MsgErro("Erro: " + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDFUNC

    *--------------------------------------------------------------------------
    PROTECTED FUNCTION Atualizar()
        LOCAL loc_lResultado, loc_cSQL, loc_nResult
        loc_lResultado = .F.

        TRY
            loc_cSQL = "UPDATE SigCdCst SET" + ;
                       " descrs   = " + EscaparSQL(THIS.this_cDescrs)              + ", " + ;
                       " descr2s  = " + EscaparSQL(THIS.this_cDescr2s)             + ", " + ;
                       " cmalads  = " + EscaparSQL(UPPER(THIS.this_cMalads))       + ", " + ;
                       " dispmovs = " + FormatarNumeroSQL(THIS.this_nDispMovs)      + ", " + ;
                       " priors   = " + FormatarNumeroSQL(THIS.this_nPriors)        + ", " + ;
                       " autos    = " + FormatarNumeroSQL(THIS.this_nAutos)         + ", " + ;
                       " blqmovs  = " + FormatarNumeroSQL(THIS.this_nBlqMovs)       + ", " + ;
                       " blqdescs = " + FormatarNumeroSQL(THIS.this_nBlqDescs)      + ", " + ;
                       " ultcompra= " + FormatarNumeroSQL(THIS.this_nUltCompra)     + ;
                       " WHERE codigos = " + EscaparSQL(THIS.this_cCodigos)

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nResult >= 0
                THIS.RegistrarAuditoria("UPDATE")
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao atualizar Situa" + CHR(231) + CHR(227) + "o de Contas:" + ;
                        CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loException
            MsgErro("Erro: " + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDFUNC

    *--------------------------------------------------------------------------
    PROTECTED FUNCTION ExecutarExclusao()
        LOCAL loc_lResultado, loc_cSQL, loc_nResult
        loc_lResultado = .F.

        TRY
            loc_cSQL = "DELETE FROM SigCdCst WHERE codigos = " + ;
                       EscaparSQL(THIS.this_cCodigos)

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nResult >= 0
                THIS.RegistrarAuditoria("DELETE")
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao excluir Situa" + CHR(231) + CHR(227) + "o de Contas:" + ;
                        CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loException
            MsgErro("Erro: " + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDFUNC

ENDDEFINE


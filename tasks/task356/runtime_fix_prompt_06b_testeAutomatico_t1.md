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
[2026-07-22 06:28:49] [INFO] === VFP EXECUTOR v2.0 ===
[2026-07-22 06:28:49] [INFO] Config FPW: (nao fornecido)
[2026-07-22 06:28:49] [INFO] Script PRG: C:\4c\projeto\app\utils\TesteAutomatico.prg
[2026-07-22 06:28:49] [INFO] Timeout: 300 segundos
[2026-07-22 06:28:49] [INFO] Wrapper PRG criado para parametros: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_jbzna10o.prg
[2026-07-22 06:28:49] [INFO] Conteudo do wrapper:
[2026-07-22 06:28:49] [INFO] * Auto-generated wrapper for parameters
* Script: C:\4c\projeto\app\utils\TesteAutomatico.prg
* Parameters: 'FormCCJ', 'C:\4c\tasks\task356', 'CRUD'

* Anti-dialog protections for unattended execution
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
SET NOTIFY OFF
SYS(2335, 0)

DO "C:\4c\projeto\app\utils\TesteAutomatico" WITH 'FormCCJ', 'C:\4c\tasks\task356', 'CRUD'
QUIT

[2026-07-22 06:28:49] [INFO] Comando VFP: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_jbzna10o.prg
[2026-07-22 06:28:49] [INFO] VFP output esperado em: C:\4c\tasks\task356\vfp_output.txt
[2026-07-22 06:28:49] [INFO] Executando Visual FoxPro 9...
[2026-07-22 06:28:49] [INFO] Comando completo: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_jbzna10o.prg
[2026-07-22 06:28:49] [INFO] Executando: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_jbzna10o.prg
[2026-07-22 06:28:49] [INFO] Timeout configurado: 300 segundos
[2026-07-22 06:29:25] [INFO] VFP9 finalizou normalmente com exit code: 
[2026-07-22 06:29:25] [INFO] VFP9 finalizado em 36.6634185 segundos
[2026-07-22 06:29:25] [INFO] Exit Code: 
[2026-07-22 06:29:25] [INFO] 
[2026-07-22 06:29:25] [INFO] Arquivos temporarios preservados para inspecao:
[2026-07-22 06:29:25] [INFO]   Wrapper.prg: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_jbzna10o.prg
[2026-07-22 06:29:25] [INFO] 
[2026-07-22 06:29:25] [INFO] === Conteudo do Wrapper.prg temporario ===
[2026-07-22 06:29:25] [INFO] * Auto-generated wrapper for parameters
[2026-07-22 06:29:25] [INFO] * Script: C:\4c\projeto\app\utils\TesteAutomatico.prg
[2026-07-22 06:29:25] [INFO] * Parameters: 'FormCCJ', 'C:\4c\tasks\task356', 'CRUD'
[2026-07-22 06:29:25] [INFO] 
[2026-07-22 06:29:25] [INFO] * Anti-dialog protections for unattended execution
[2026-07-22 06:29:25] [INFO] SET SAFETY OFF
[2026-07-22 06:29:25] [INFO] SET RESOURCE OFF
[2026-07-22 06:29:25] [INFO] SET TALK OFF
[2026-07-22 06:29:25] [INFO] SET NOTIFY OFF
[2026-07-22 06:29:25] [INFO] SYS(2335, 0)
[2026-07-22 06:29:25] [INFO] 
[2026-07-22 06:29:25] [INFO] DO "C:\4c\projeto\app\utils\TesteAutomatico" WITH 'FormCCJ', 'C:\4c\tasks\task356', 'CRUD'
[2026-07-22 06:29:25] [INFO] QUIT
[2026-07-22 06:29:25] [INFO] 
[2026-07-22 06:29:25] [INFO] === Fim do Wrapper.prg ===
[2026-07-22 06:29:25] [WARN] AVISO: VFP9 retornou exit code  (normal para VFP9 GUI - validar pelo arquivo de saida)


### RESULTADO DOS TESTES (teste_resultado.json):
{
  "formClass": "FormCCJ",
  "timestamp": "20260722062925",
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
      "detalhes": "AbrirLookup: 0 | KeyPress handlers: 2 (CONTASKEYPRESS, KEYPRESS)"
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

### FORM (C:\4c\projeto\app\forms\cadastros\FormCCJ.prg):
*==============================================================================
* FormCCJ.prg - Fase 8/8: Form - COMPLETO (consolidado)
* Formulario de Calculo de Juros (SIGCDCCJ)
*
* Tabela principal: SigCdCcj (PK: codigo char(6))
* Tabela detalhe  : SigDtCcj (PK: cidchaves char(20), FK: codigo char(6))
* Tipo: CRUD (frmcadastro) com grade de detalhe em Page2
* BO: CCJBO
*==============================================================================

DEFINE CLASS FormCCJ AS FormBase

    *-- Propriedades visuais (PILAR 1 - UX FIDELITY)
    Height      = 600
    Width       = 1000
    Caption     = "C" + CHR(225) + "lculo de Juros"
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
    * Init - Retorna DODEFAULT (FormBase.Init chama InicializarForm)
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        LOCAL loc_lResultado
        loc_lResultado = .F.

        TRY
            loc_lResultado = DODEFAULT()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "FormCCJ.Init")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * InicializarForm - Configura estrutura completa do formulario
    * Chamado automaticamente pelo FormBase.Init()
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lResultado
        loc_lResultado = .F.

        TRY
            THIS.this_oBusinessObject = CREATEOBJECT("CCJBO")

            IF VARTYPE(THIS.this_oBusinessObject) != "O"
                MsgErro("Falha ao criar CCJBO", "Erro")
            ELSE
                THIS.ConfigurarPageFrame()

                THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
                THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption

                IF TYPE("gb_4c_ValidandoUI") != "L" OR !gb_4c_ValidandoUI
                    THIS.CarregarLista()
                ENDIF

                THIS.pgf_4c_Paginas.Visible = .T.
                THIS.pgf_4c_Paginas.ActivePage = 1
                THIS.this_cModoAtual = "LISTA"
                loc_lResultado = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "FormCCJ.InicializarForm")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPageFrame - Cria PageFrame com Page1 (Lista) e Page2 (Dados)
    * PageFrame.Top=-29 compensa abas ocultas; controles internos somam +29
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
    * ConfigurarPaginaLista - Cria containers da Page1 (Lista)
    * Fase 3: cabecalho + shell cnt_4c_Botoes + cnt_4c_Saida/Encerrar
    * Fase 4: grid grd_4c_Lista e botoes CRUD dentro de cnt_4c_Botoes
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPaginaLista()
        LOCAL loc_oPg1, loc_oCab, loc_oBotoes, loc_oSaida, loc_oGrid
        loc_oPg1 = THIS.pgf_4c_Paginas.Page1

        *-- Container cabecalho cinza escuro (Top = 2+29 = 31, compensacao PageFrame.Top=-29)
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

        BINDEVENT(loc_oBotoes.cmd_4c_Incluir,    "Click", THIS, "BtnIncluirClick")
        BINDEVENT(loc_oBotoes.cmd_4c_Visualizar, "Click", THIS, "BtnVisualizarClick")
        BINDEVENT(loc_oBotoes.cmd_4c_Alterar,    "Click", THIS, "BtnAlterarClick")
        BINDEVENT(loc_oBotoes.cmd_4c_Excluir,    "Click", THIS, "BtnExcluirClick")
        BINDEVENT(loc_oBotoes.cmd_4c_Buscar,     "Click", THIS, "BtnBuscarClick")

        *-- Container Encerrar (canonico: Left=917, Width=90, Height=85)
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

        *-- Grid de lista (Top=117=88+29, Left=26)
        *-- Colunas: Conta, Descricao, Data Base, Fator, Total, Liquido
        loc_oPg1.AddObject("grd_4c_Lista", "Grid")
        loc_oGrid = loc_oPg1.grd_4c_Lista

        loc_oGrid.RecordSource = ""
        loc_oGrid.ColumnCount  = 6

        WITH loc_oGrid
            .Top                = 117
            .Left               = 26
            .Width              = 880
            .Height             = 480
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

        THIS.TornarControlesVisiveis(loc_oPg1)
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPaginaDados - Cria containers da Page2 (Dados)
    * Fase 3: cnt_4c_BotoesAcao com Confirmar/Cancelar
    * Fase 5: BtnRec/BtnVideo + campos Conta/DataBase/Fator/OptDias
    * Fase 6: GradeDetalhe, InserirV/ExcluirV, secao Totais
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPaginaDados()
        LOCAL loc_oPg2, loc_oBotoesAcao, loc_oGrdDet
        loc_oPg2 = THIS.pgf_4c_Paginas.Page2

        *-- Container Confirmar/Cancelar (canonico: Top=33, Left=842, Width=160)
        loc_oPg2.AddObject("cnt_4c_BotoesAcao", "Container")
        loc_oBotoesAcao = loc_oPg2.cnt_4c_BotoesAcao
        WITH loc_oBotoesAcao
            .Top         = 33
            .Left        = 842
            .Width       = 160
            .Height      = 85
            .BackStyle   = 0
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH

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

        loc_oBotoesAcao.AddObject("cmd_4c_Cancelar", "CommandButton")
        WITH loc_oBotoesAcao.cmd_4c_Cancelar
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

        BINDEVENT(loc_oBotoesAcao.cmd_4c_Confirmar, "Click", THIS, "BtnConfirmarClick")
        BINDEVENT(loc_oBotoesAcao.cmd_4c_Cancelar,  "Click", THIS, "BtnCancelarClick")

        *-- Botao Recalcular (BtnRec: original top=3+29=32, left=499)
        loc_oPg2.AddObject("cmd_4c_BtnRec", "CommandButton")
        WITH loc_oPg2.cmd_4c_BtnRec
            .Caption         = "Recalcular"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_alterar_60.jpg"
            .PicturePosition = 13
            .Top             = 32
            .Left            = 499
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

        *-- Botao Relatorio/Video (BtnVideo: original top=3+29=32, left=574)
        loc_oPg2.AddObject("cmd_4c_BtnVideo", "CommandButton")
        WITH loc_oPg2.cmd_4c_BtnVideo
            .Caption         = "Relat" + CHR(243) + "rio"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_vizualizar_60.jpg"
            .PicturePosition = 13
            .Top             = 32
            .Left            = 574
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

        BINDEVENT(loc_oPg2.cmd_4c_BtnRec,   "Click", THIS, "BtnRecalcularClick")
        BINDEVENT(loc_oPg2.cmd_4c_BtnVideo, "Click", THIS, "BtnRelatorioClick")

        *-- Label + TextBox Conta (Say42+Get_Contas: original top=119/115 -> +29=148/144)
        loc_oPg2.AddObject("lbl_4c_Label42", "Label")
        WITH loc_oPg2.lbl_4c_Label42
            .Caption   = "Conta :"
            .Top       = 148
            .Left      = 220
            .Width     = 60
            .Height    = 17
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Alignment = 1
            .Visible   = .T.
        ENDWITH

        loc_oPg2.AddObject("txt_4c_Contas", "TextBox")
        WITH loc_oPg2.txt_4c_Contas
            .Value         = ""
            .Top           = 144
            .Left          = 260
            .Width         = 81
            .Height        = 23
            .FontName      = "Tahoma"
            .FontSize      = 8
            .ForeColor     = RGB(90, 90, 90)
            .BackColor     = RGB(255, 255, 255)
            .Themes        = .F.
            .SpecialEffect = 0
            .Visible       = .T.
        ENDWITH

        *-- TextBox descricao da conta - readonly, auto-preenchido (Get_DContas: top=115+29=144, left=345)
        loc_oPg2.AddObject("txt_4c_DContas", "TextBox")
        WITH loc_oPg2.txt_4c_DContas
            .Value         = ""
            .Top           = 144
            .Left          = 345
            .Width         = 279
            .Height        = 23
            .FontName      = "Tahoma"
            .FontSize      = 8
            .ForeColor     = RGB(90, 90, 90)
            .BackColor     = RGB(255, 255, 230)
            .ReadOnly      = .T.
            .Themes        = .F.
            .SpecialEffect = 0
            .Visible       = .T.
        ENDWITH

        BINDEVENT(loc_oPg2.txt_4c_Contas, "KeyPress", THIS, "ValidarContas")
        BINDEVENT(loc_oPg2.txt_4c_Contas, "KeyPress",  THIS, "ContasKeyPress")
        BINDEVENT(loc_oPg2.txt_4c_Contas, "DblClick",  THIS, "ContasDblClick")

        *-- Label + TextBox Data Base (Say15+Get_DataBase: original top=146/142 -> +29=175/171)
        loc_oPg2.AddObject("lbl_4c_Label15", "Label")
        WITH loc_oPg2.lbl_4c_Label15
            .Caption   = "Data Base :"
            .Top       = 175
            .Left      = 200
            .Width     = 58
            .Height    = 17
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Alignment = 1
            .Visible   = .T.
        ENDWITH

        loc_oPg2.AddObject("txt_4c_DataBase", "TextBox")
        WITH loc_oPg2.txt_4c_DataBase
            .Value         = {}
            .Top           = 171
            .Left          = 260
            .Width         = 81
            .Height        = 23
            .FontName      = "Tahoma"
            .FontSize      = 8
            .ForeColor     = RGB(90, 90, 90)
            .BackColor     = RGB(255, 255, 255)
            .InputMask     = "99/99/9999"
            .Themes        = .F.
            .SpecialEffect = 0
            .Visible       = .T.
        ENDWITH

        *-- Label + TextBox Fator (Say1+Get_Fator: original top=173/169 -> +29=202/198)
        loc_oPg2.AddObject("lbl_4c_Label1", "Label")
        WITH loc_oPg2.lbl_4c_Label1
            .Caption   = "Fator :"
            .Top       = 202
            .Left      = 223
            .Width     = 35
            .Height    = 17
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Alignment = 1
            .Visible   = .T.
        ENDWITH

        loc_oPg2.AddObject("txt_4c_Fator", "TextBox")
        WITH loc_oPg2.txt_4c_Fator
            .Value         = 0
            .Top           = 198
            .Left          = 260
            .Width         = 81
            .Height        = 23
            .FontName      = "Tahoma"
            .FontSize      = 8
            .ForeColor     = RGB(90, 90, 90)
            .BackColor     = RGB(255, 255, 255)
            .InputMask     = "9999.9999"
            .Themes        = .F.
            .SpecialEffect = 0
            .Visible       = .T.
        ENDWITH

        *-- Label "Dias :" + OptionGroup (Say13+optDias: original top=149/144 -> +29=178/173)
        *-- Value=1 Corridos (todos os dias), Value=2 Uteis (exclui sab/dom)
        loc_oPg2.AddObject("lbl_4c_Label13", "Label")
        WITH loc_oPg2.lbl_4c_Label13
            .Caption   = "Dias :"
            .Top       = 178
            .Left      = 357
            .Width     = 35
            .Height    = 17
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oPg2.AddObject("opt_4c_OptDias", "OptionGroup")
        WITH loc_oPg2.opt_4c_OptDias
            .ButtonCount = 2
            .Top         = 173
            .Left        = 383
            .Width       = 119
            .Height      = 25
            .BackStyle   = 0
            .BorderStyle = 0
            .Value       = 1
            .Visible     = .T.
        ENDWITH

        loc_oPg2.opt_4c_OptDias.Buttons(1).Caption   = "Corridos"
        loc_oPg2.opt_4c_OptDias.Buttons(1).Left      = 5
        loc_oPg2.opt_4c_OptDias.Buttons(1).Top       = 5
        loc_oPg2.opt_4c_OptDias.Buttons(1).Width     = 60
        loc_oPg2.opt_4c_OptDias.Buttons(1).AutoSize  = .T.
        loc_oPg2.opt_4c_OptDias.Buttons(1).FontName  = "Tahoma"
        loc_oPg2.opt_4c_OptDias.Buttons(1).FontSize  = 8
        loc_oPg2.opt_4c_OptDias.Buttons(1).ForeColor = RGB(90, 90, 90)
        loc_oPg2.opt_4c_OptDias.Buttons(1).Themes    = .F.

        loc_oPg2.opt_4c_OptDias.Buttons(2).Caption   = CHR(218) + "teis"
        loc_oPg2.opt_4c_OptDias.Buttons(2).Left      = 63
        loc_oPg2.opt_4c_OptDias.Buttons(2).Top       = 5
        loc_oPg2.opt_4c_OptDias.Buttons(2).Width     = 50
        loc_oPg2.opt_4c_OptDias.Buttons(2).AutoSize  = .T.
        loc_oPg2.opt_4c_OptDias.Buttons(2).FontName  = "Tahoma"
        loc_oPg2.opt_4c_OptDias.Buttons(2).FontSize  = 8
        loc_oPg2.opt_4c_OptDias.Buttons(2).ForeColor = RGB(90, 90, 90)
        loc_oPg2.opt_4c_OptDias.Buttons(2).Themes    = .F.

        BINDEVENT(loc_oPg2.opt_4c_OptDias, "InteractiveChange", THIS, "OptDiasChanged")

        *-- Forma decorativa superior (Shape3: original top=-23 -> compensado=6)
        loc_oPg2.AddObject("shp_4c_Shape3", "Shape")
        WITH loc_oPg2.shp_4c_Shape3
            .Top           = 6
            .Left          = 0
            .Width         = THIS.Width
            .Height        = 2
            .SpecialEffect = 0
            .BackStyle     = 1
            .BackColor     = RGB(53, 53, 53)
            .BorderStyle   = 0
            .Visible       = .T.
        ENDWITH

        *-- Forma decorativa separador de secoes (Shape4: original top=219 -> compensado=248)
        loc_oPg2.AddObject("shp_4c_Shape4", "Shape")
        WITH loc_oPg2.shp_4c_Shape4
            .Top           = 248
            .Left          = 255
            .Width         = 420
            .Height        = 2
            .SpecialEffect = 0
            .BackStyle     = 1
            .BackColor     = RGB(150, 150, 150)
            .BorderStyle   = 0
            .Visible       = .T.
        ENDWITH

        *-- Grade Detalhe (original top=196 -> compensado=225, left=260)
        *-- Colunas: Data/Valor (editaveis), Dias/Liquido (calculados, readonly)
        loc_oPg2.AddObject("grd_4c_Detalhe", "Grid")
        loc_oGrdDet = loc_oPg2.grd_4c_Detalhe
        WITH loc_oGrdDet
            .RecordSource       = ""
            .ColumnCount        = 4
            .Top                = 225
            .Left               = 260
            .Width              = 365
            .Height             = 382
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
            .RowHeight          = 18
            .ScrollBars         = 2
            .GridLines          = 3
            .ReadOnly           = .F.
            .Visible            = .T.
        ENDWITH

        loc_oGrdDet.Column1.Header1.Caption  = "Data"
        loc_oGrdDet.Column1.Width            = 90
        loc_oGrdDet.Column1.Sparse           = .F.
        loc_oGrdDet.Column1.ReadOnly         = .F.
        loc_oGrdDet.Column1.ControlSource    = ""
        loc_oGrdDet.Column1.Text1.InputMask  = "99/99/9999"

        loc_oGrdDet.Column2.Header1.Caption  = "Valor"
        loc_oGrdDet.Column2.Width            = 90
        loc_oGrdDet.Column2.Sparse           = .F.
        loc_oGrdDet.Column2.ReadOnly         = .F.
        loc_oGrdDet.Column2.ControlSource    = ""

        loc_oGrdDet.Column3.Header1.Caption  = "Dias"
        loc_oGrdDet.Column3.Width            = 45
        loc_oGrdDet.Column3.Sparse           = .F.
        loc_oGrdDet.Column3.ReadOnly         = .T.
        loc_oGrdDet.Column3.ControlSource    = ""

        loc_oGrdDet.Column4.Header1.Caption  = "Valor Liquido"
        loc_oGrdDet.Column4.Width            = 130
        loc_oGrdDet.Column4.Sparse           = .F.
        loc_oGrdDet.Column4.ReadOnly         = .T.
        loc_oGrdDet.Column4.ControlSource    = ""

        BINDEVENT(loc_oGrdDet.Column2.Text1, "LostFocus", THIS, "RecalcularItem")
        BINDEVENT(loc_oGrdDet.Column1.Text1, "KeyPress", THIS, "ValidarDataDetalhe")

        *-- Botao InserirV (original top=317 -> compensado=346, left=630, 45x45)
        loc_oPg2.AddObject("cmd_4c_InserirV", "CommandButton")
        WITH loc_oPg2.cmd_4c_InserirV
            .Caption         = "Inserir"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_inserir_26.jpg"
            .PicturePosition = 13
            .Top             = 346
            .Left            = 630
            .Width           = 45
            .Height          = 45
            .BackColor       = RGB(255, 255, 255)
            .ForeColor       = RGB(90, 90, 90)
            .FontName        = "Tahoma"
            .FontSize        = 7
            .FontBold        = .T.
            .Themes          = .F.
            .SpecialEffect   = 0
            .MousePointer    = 15
            .WordWrap        = .T.
            .AutoSize        = .F.
            .Visible         = .T.
        ENDWITH

        *-- Botao ExcluirV (original top=362 -> compensado=391, left=630, 45x45)
        loc_oPg2.AddObject("cmd_4c_ExcluirV", "CommandButton")
        WITH loc_oPg2.cmd_4c_ExcluirV
            .Caption         = "Excluir"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_excluir_26.jpg"
            .PicturePosition = 13
            .Top             = 391
            .Left            = 630
            .Width           = 45
            .Height          = 45
            .BackColor       = RGB(255, 255, 255)
            .ForeColor       = RGB(90, 90, 90)
            .FontName        = "Tahoma"
            .FontSize        = 7
            .FontBold        = .T.
            .Themes          = .F.
            .SpecialEffect   = 0
            .MousePointer    = 15
            .WordWrap        = .T.
            .AutoSize        = .F.
            .Visible         = .T.
        ENDWITH

        BINDEVENT(loc_oPg2.cmd_4c_InserirV, "Click", THIS, "InserirVClick")
        BINDEVENT(loc_oPg2.cmd_4c_ExcluirV, "Click", THIS, "ExcluirVClick")

        *-- Secao Totais (direita do grid, esquerda dos botoes de acao)
        loc_oPg2.AddObject("lbl_4c_Label5", "Label")
        WITH loc_oPg2.lbl_4c_Label5
            .Caption   = "Totais"
            .Top       = 248
            .Left      = 690
            .Width     = 130
            .Height    = 20
            .FontName  = "Tahoma"
            .FontSize  = 10
            .FontBold  = .T.
            .ForeColor = RGB(53, 53, 53)
            .BackStyle = 0
            .Alignment = 2
            .Visible   = .T.
        ENDWITH

        loc_oPg2.AddObject("lbl_4c_Label2", "Label")
        WITH loc_oPg2.lbl_4c_Label2
            .Caption   = "Qtde :"
            .Top       = 278
            .Left      = 690
            .Width     = 60
            .Height    = 17
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Alignment = 1
            .Visible   = .T.
        ENDWITH

        loc_oPg2.AddObject("txt_4c_Qtde", "TextBox")
        WITH loc_oPg2.txt_4c_Qtde
            .Value         = 0
            .Top           = 275
            .Left          = 752
            .Width         = 68
            .Height        = 23
            .FontName      = "Tahoma"
            .FontSize      = 8
            .ForeColor     = RGB(90, 90, 90)
            .BackColor     = RGB(255, 255, 230)
            .ReadOnly      = .T.
            .Themes        = .F.
            .SpecialEffect = 0
            .Visible       = .T.
        ENDWITH

        loc_oPg2.AddObject("lbl_4c_Label6", "Label")
        WITH loc_oPg2.lbl_4c_Label6
            .Caption   = "M" + CHR(233) + "dia :"
            .Top       = 305
            .Left      = 690
            .Width     = 60
            .Height    = 17
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Alignment = 1
            .Visible   = .T.
        ENDWITH

        loc_oPg2.AddObject("txt_4c_Media", "TextBox")
        WITH loc_oPg2.txt_4c_Media
            .Value         = 0
            .Top           = 302
            .Left          = 752
            .Width         = 68
            .Height        = 23
            .FontName      = "Tahoma"
            .FontSize      = 8
            .ForeColor     = RGB(90, 90, 90)
            .BackColor     = RGB(255, 255, 230)
            .ReadOnly      = .T.
            .Themes        = .F.
            .SpecialEffect = 0
            .Visible       = .T.
        ENDWITH

        loc_oPg2.AddObject("lbl_4c_Label3", "Label")
        WITH loc_oPg2.lbl_4c_Label3
            .Caption   = "Total :"
            .Top       = 332
            .Left      = 690
            .Width     = 60
            .Height    = 17
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Alignment = 1
            .Visible   = .T.
        ENDWITH

        loc_oPg2.AddObject("txt_4c_Total", "TextBox")
        WITH loc_oPg2.txt_4c_Total
            .Value         = 0
            .Top           = 329
            .Left          = 752
            .Width         = 68
            .Height        = 23
            .FontName      = "Tahoma"
            .FontSize      = 8
            .ForeColor     = RGB(90, 90, 90)
            .BackColor     = RGB(255, 255, 230)
            .ReadOnly      = .T.
            .Themes        = .F.
            .SpecialEffect = 0
            .Visible       = .T.
        ENDWITH

        loc_oPg2.AddObject("lbl_4c_Label4", "Label")
        WITH loc_oPg2.lbl_4c_Label4
            .Caption   = "Total L" + CHR(237) + "q. :"
            .Top       = 359
            .Left      = 690
            .Width     = 60
            .Height    = 17
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Alignment = 1
            .Visible   = .T.
        ENDWITH

        loc_oPg2.AddObject("txt_4c_TotLiq", "TextBox")
        WITH loc_oPg2.txt_4c_TotLiq
            .Value         = 0
            .Top           = 356
            .Left          = 752
            .Width         = 68
            .Height        = 23
            .FontName      = "Tahoma"
            .FontSize      = 8
            .ForeColor     = RGB(90, 90, 90)
            .BackColor     = RGB(255, 255, 230)
            .ReadOnly      = .T.
            .Themes        = .F.
            .SpecialEffect = 0
            .Visible       = .T.
        ENDWITH

        THIS.TornarControlesVisiveis(loc_oPg2)
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarLista - Popula cursor_4c_Dados e atualiza grd_4c_Lista
    *--------------------------------------------------------------------------
    PROCEDURE CarregarLista()
        LOCAL loc_lResultado
        loc_lResultado = .F.

        TRY
            IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
                loc_lResultado = .T.
            ELSE
                IF THIS.this_oBusinessObject.Buscar("")
                    THIS.AtualizarGrid()
                    loc_lResultado = .T.
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "FormCCJ.CarregarLista")
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * AlternarPagina - Navega entre Page1 (Lista=1) e Page2 (Dados=2)
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
                THIS.this_cModoAtual = "LISTA"
                THIS.CarregarLista()
            ENDIF

            loc_lResultado = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "FormCCJ.AlternarPagina")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnEncerrarClick - Encerra o formulario
    *--------------------------------------------------------------------------
    PROCEDURE BtnEncerrarClick()
        THIS.Release()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnConfirmarClick - Valida, salva e retorna a lista
    *--------------------------------------------------------------------------
    PROCEDURE BtnConfirmarClick()
        LOCAL loc_oPg2, loc_lSucesso
        loc_oPg2    = THIS.pgf_4c_Paginas.Page2
        loc_lSucesso = .F.

        IF EMPTY(ALLTRIM(NVL(loc_oPg2.txt_4c_Contas.Value, "")))
            MsgAviso("Conta n" + CHR(227) + "o informada.", "Confirmar")
            RETURN
        ENDIF

        IF EMPTY(loc_oPg2.txt_4c_DataBase.Value)
            MsgAviso("Data Base n" + CHR(227) + "o informada.", "Confirmar")
            RETURN
        ENDIF

        TRY
            IF THIS.this_cModoAtual = "INCLUIR"
                THIS.this_oBusinessObject.this_cCodigo = THIS.this_oBusinessObject.GerarCodigo()
            ENDIF

            THIS.FormParaBO()
            THIS.this_oBusinessObject.Recalcular()

            IF THIS.this_oBusinessObject.Salvar()
                MsgInfo("Registro salvo com sucesso!", "Confirmar")
                THIS.AlternarPagina(1)
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "BtnConfirmarClick")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnCancelarClick - Cancela edicao e retorna a lista
    *--------------------------------------------------------------------------
    PROCEDURE BtnCancelarClick()
        THIS.AlternarPagina(1)
    ENDPROC

    *--------------------------------------------------------------------------
    * AtualizarGrid - Wire RecordSource/ControlSource/Headers do grd_4c_Lista
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE AtualizarGrid()
        LOCAL loc_oGrid
        loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Lista

        loc_oGrid.ColumnCount = 6
        loc_oGrid.RecordSource = "cursor_4c_Dados"

        loc_oGrid.Column1.ControlSource = "cursor_4c_Dados.contas"
        loc_oGrid.Column2.ControlSource = "cursor_4c_Dados.desconta"
        loc_oGrid.Column3.ControlSource = "cursor_4c_Dados.data_base"
        loc_oGrid.Column4.ControlSource = "cursor_4c_Dados.fator"
        loc_oGrid.Column5.ControlSource = "cursor_4c_Dados.total"
        loc_oGrid.Column6.ControlSource = "cursor_4c_Dados.totliq"

        loc_oGrid.Column1.Width = 80
        loc_oGrid.Column2.Width = 300
        loc_oGrid.Column3.Width = 100
        loc_oGrid.Column4.Width = 60
        loc_oGrid.Column5.Width = 100
        loc_oGrid.Column6.Width = 100

        loc_oGrid.Column1.Header1.Caption = "Conta"
        loc_oGrid.Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
        loc_oGrid.Column3.Header1.Caption = "Data Base"
        loc_oGrid.Column4.Header1.Caption = "Fator"
        loc_oGrid.Column5.Header1.Caption = "Total"
        loc_oGrid.Column6.Header1.Caption = "Liq."

        THIS.FormatarGridLista(loc_oGrid)
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
    * AjustarBotoesPorModo - Habilita/desabilita Confirmar conforme modo corrente
    * VISUALIZAR: Confirmar disabled  |  INCLUIR/ALTERAR: Confirmar enabled
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE AjustarBotoesPorModo()
        LOCAL loc_oPg2, loc_lEdicao
        loc_oPg2   = THIS.pgf_4c_Paginas.Page2
        loc_lEdicao = INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")

        IF PEMSTATUS(loc_oPg2, "cnt_4c_BotoesAcao", 5)
            IF PEMSTATUS(loc_oPg2.cnt_4c_BotoesAcao, "cmd_4c_Confirmar", 5)
                loc_oPg2.cnt_4c_BotoesAcao.cmd_4c_Confirmar.Enabled = loc_lEdicao
            ENDIF
            IF PEMSTATUS(loc_oPg2.cnt_4c_BotoesAcao, "cmd_4c_Cancelar", 5)
                loc_oPg2.cnt_4c_BotoesAcao.cmd_4c_Cancelar.Enabled = .T.
            ENDIF
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnIncluirClick - Abre Page2 para inclusao de novo registro
    *--------------------------------------------------------------------------
    PROCEDURE BtnIncluirClick()
        THIS.this_oBusinessObject.NovoRegistro()
        THIS.this_oBusinessObject.BuscarDetalhe("")
        THIS.this_cModoAtual = "INCLUIR"
        THIS.LimparCampos()
        THIS.AtualizarGradeDetalhe()
        THIS.HabilitarCampos(.T.)
        THIS.AjustarBotoesPorModo()
        THIS.AlternarPagina(2)
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnVisualizarClick - Carrega registro selecionado em modo consulta
    *--------------------------------------------------------------------------
    PROCEDURE BtnVisualizarClick()
        LOCAL loc_cCodigo
        loc_cCodigo = ""

        IF USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados")
            SELECT cursor_4c_Dados
            loc_cCodigo = ALLTRIM(NVL(cursor_4c_Dados.codigo, ""))
        ENDIF

        IF EMPTY(loc_cCodigo)
            MsgAviso("Selecione um registro na lista.", "Visualizar")
            RETURN
        ENDIF

        IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
            THIS.this_oBusinessObject.BuscarDetalhe(loc_cCodigo)
            THIS.AtualizarGradeDetalhe()
            THIS.this_cModoAtual = "VISUALIZAR"
            THIS.BOParaForm()
            THIS.HabilitarCampos(.F.)
            THIS.AjustarBotoesPorModo()
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
            loc_cCodigo = ALLTRIM(NVL(cursor_4c_Dados.codigo, ""))
        ENDIF

        IF EMPTY(loc_cCodigo)
            MsgAviso("Selecione um registro na lista.", "Alterar")
            RETURN
        ENDIF

        IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
            THIS.this_oBusinessObject.BuscarDetalhe(loc_cCodigo)
            THIS.AtualizarGradeDetalhe()
            THIS.this_oBusinessObject.EditarRegistro()
            THIS.this_cModoAtual = "ALTERAR"
            THIS.BOParaForm()
            THIS.HabilitarCampos(.T.)
            THIS.AjustarBotoesPorModo()
            THIS.AlternarPagina(2)
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnExcluirClick - Confirma e exclui registro selecionado
    *--------------------------------------------------------------------------
    PROCEDURE BtnExcluirClick()
        LOCAL loc_cCodigo, loc_lConfirma
        loc_cCodigo  = ""
        loc_lConfirma = .F.

        IF USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados")
            SELECT cursor_4c_Dados
            loc_cCodigo = ALLTRIM(NVL(cursor_4c_Dados.codigo, ""))
        ENDIF

        IF EMPTY(loc_cCodigo)
            MsgAviso("Selecione um registro na lista.", "Excluir")
            RETURN
        ENDIF

        loc_lConfirma = MsgConfirma("Deseja excluir o c" + CHR(225) + ;
            "lculo de juros selecionado?", "Excluir")
        IF !loc_lConfirma
            RETURN
        ENDIF

        IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
            IF THIS.this_oBusinessObject.Excluir()
                MsgInfo("Registro exclu" + CHR(237) + "do com sucesso!", "Excluir")
                THIS.CarregarLista()
            ENDIF
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnBuscarClick - Busca registros filtrando por conta ou descricao
    *--------------------------------------------------------------------------
    PROCEDURE BtnBuscarClick()
        LOCAL loc_cFiltro
        loc_cFiltro = INPUTBOX("Informe conta ou descri" + CHR(231) + CHR(227) + ;
            "o (vazio = todos):", "Buscar")

        IF VARTYPE(loc_cFiltro) = "C"
            IF THIS.this_oBusinessObject.Buscar(loc_cFiltro)
                THIS.AtualizarGrid()
            ENDIF
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * ContasKeyPress - Abre picker de conta ao pressionar F4
    *--------------------------------------------------------------------------
    PROCEDURE ContasKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 28  && F4
            THIS.AbrirBuscaContas(ALLTRIM(NVL(THIS.pgf_4c_Paginas.Page2.txt_4c_Contas.Value, "")))
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * ContasDblClick - Abre picker de conta ao dar duplo clique
    *--------------------------------------------------------------------------
    PROCEDURE ContasDblClick()
        THIS.AbrirBuscaContas(ALLTRIM(NVL(THIS.pgf_4c_Paginas.Page2.txt_4c_Contas.Value, "")))
    ENDPROC

    *--------------------------------------------------------------------------
    * TornarControlesVisiveis - Torna todos controles visiveis recursivamente
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

                IF PEMSTATUS(loc_oObjeto, "ControlCount", 5) AND loc_oObjeto.ControlCount > 0
                    THIS.TornarControlesVisiveis(loc_oObjeto)
                ENDIF
            ENDIF
        ENDFOR
    ENDPROC

    *--------------------------------------------------------------------------
    * HabilitarCampos - Habilita/desabilita campos conforme modo corrente
    * Fase 5: controles Conta/DataBase/Fator/OptDias/BtnRec/BtnVideo
    * Fase 6: extende para GradeDetalhe e botoes InserirV/ExcluirV
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE HabilitarCampos(par_lHabilitar)
        LOCAL loc_oPg2, loc_lEdicao
        loc_oPg2   = THIS.pgf_4c_Paginas.Page2
        loc_lEdicao = INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")

        IF !PEMSTATUS(loc_oPg2, "txt_4c_Contas", 5)
            RETURN
        ENDIF

        *-- Conta: editavel em INCLUIR
        loc_oPg2.txt_4c_Contas.ReadOnly  = !(THIS.this_cModoAtual = "INCLUIR")
        loc_oPg2.txt_4c_DContas.ReadOnly = .T.

        *-- DataBase, Fator, OptDias: editaveis em INCLUIR e ALTERAR
        loc_oPg2.txt_4c_DataBase.ReadOnly = !loc_lEdicao
        loc_oPg2.txt_4c_Fator.ReadOnly    = !loc_lEdicao
        loc_oPg2.opt_4c_OptDias.Enabled   = loc_lEdicao

        *-- BtnRec: habilitado em INCLUIR/ALTERAR; BtnVideo: habilitado em VISUALIZAR
        loc_oPg2.cmd_4c_BtnRec.Enabled   = loc_lEdicao
        loc_oPg2.cmd_4c_BtnVideo.Enabled = !loc_lEdicao

        *-- Grade Detalhe e botoes de linha: editaveis em INCLUIR/ALTERAR
        IF PEMSTATUS(loc_oPg2, "grd_4c_Detalhe", 5)
            loc_oPg2.grd_4c_Detalhe.ReadOnly = !loc_lEdicao
        ENDIF
        IF PEMSTATUS(loc_oPg2, "cmd_4c_InserirV", 5)
            loc_oPg2.cmd_4c_InserirV.Enabled = loc_lEdicao
            loc_oPg2.cmd_4c_ExcluirV.Enabled = loc_lEdicao
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * LimparCampos - Limpa valores dos campos da Page2
    * Fase 5: Conta/DataBase/Fator/OptDias
    * Fase 6: extende para campos de Totais
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE LimparCampos()
        LOCAL loc_oPg2
        loc_oPg2 = THIS.pgf_4c_Paginas.Page2

        IF !PEMSTATUS(loc_oPg2, "txt_4c_Contas", 5)
            RETURN
        ENDIF

        loc_oPg2.txt_4c_Contas.Value    = ""
        loc_oPg2.txt_4c_DContas.Value   = ""
        loc_oPg2.txt_4c_DataBase.Value  = {}
        loc_oPg2.txt_4c_Fator.Value     = 0
        loc_oPg2.opt_4c_OptDias.Value   = 1

        IF PEMSTATUS(loc_oPg2, "txt_4c_Qtde", 5)
            loc_oPg2.txt_4c_Qtde.Value   = 0
            loc_oPg2.txt_4c_Media.Value  = 0
            loc_oPg2.txt_4c_Total.Value  = 0
            loc_oPg2.txt_4c_TotLiq.Value = 0
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * BOParaForm - Transfere propriedades do BO para os campos da Page2
    * Fase 5: Conta/DContas/DataBase/Fator/OptDias
    * Fase 6: extende para campos de Totais
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE BOParaForm()
        LOCAL loc_oPg2, loc_oBO
        loc_oPg2 = THIS.pgf_4c_Paginas.Page2
        loc_oBO  = THIS.this_oBusinessObject

        IF !PEMSTATUS(loc_oPg2, "txt_4c_Contas", 5)
            RETURN
        ENDIF

        TRY
            loc_oPg2.txt_4c_Contas.Value   = loc_oBO.this_cContas
            loc_oPg2.txt_4c_DataBase.Value  = loc_oBO.this_dDataBase
            loc_oPg2.txt_4c_Fator.Value     = loc_oBO.this_nFator
            loc_oPg2.opt_4c_OptDias.Value   = loc_oBO.this_nTiposDias

            *-- Carrega descricao da conta
            IF loc_oBO.BuscarContaPorCodigo(loc_oBO.this_cContas)
                loc_oPg2.txt_4c_DContas.Value = loc_oBO.this_cDContas
            ELSE
                loc_oPg2.txt_4c_DContas.Value = ""
            ENDIF

            *-- Computa totais e atualiza campos de exibicao
            THIS.AtualizarTotais()

            *-- Refresh da grade de detalhe
            IF PEMSTATUS(loc_oPg2, "grd_4c_Detalhe", 5)
                loc_oPg2.grd_4c_Detalhe.Refresh()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "BOParaForm")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * FormParaBO - Transfere valores dos campos da Page2 para o BO
    * Fase 5: Conta/DataBase/Fator/OptDias
    * Fase 6: extende para campos de Totais (calculados pelo BO.Recalcular)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE FormParaBO()
        LOCAL loc_oPg2, loc_oBO
        loc_oPg2 = THIS.pgf_4c_Paginas.Page2
        loc_oBO  = THIS.this_oBusinessObject

        IF !PEMSTATUS(loc_oPg2, "txt_4c_Contas", 5)
            RETURN
        ENDIF

        TRY
            loc_oBO.this_cContas    = ALLTRIM(NVL(loc_oPg2.txt_4c_Contas.Value, ""))
            loc_oBO.this_dDataBase  = NVL(loc_oPg2.txt_4c_DataBase.Value, {})
            loc_oBO.this_nFator     = NVL(loc_oPg2.txt_4c_Fator.Value, 0)
            loc_oBO.this_nTiposDias = NVL(loc_oPg2.opt_4c_OptDias.Value, 1)
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "FormParaBO")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnRecalcularClick - Confirma e aciona recalculo de juros (BtnRec)
    *--------------------------------------------------------------------------
    PROCEDURE BtnRecalcularClick()
        LOCAL loc_oPg2
        loc_oPg2 = THIS.pgf_4c_Paginas.Page2

        IF EMPTY(loc_oPg2.txt_4c_DataBase.Value)
            MsgAviso("Data Base n" + CHR(227) + "o informada.", "Recalcular")
            RETURN
        ENDIF

        IF !MsgConfirma("Deseja Recalcular os Valores?", "Aten" + CHR(231) + CHR(227) + "o")
            RETURN
        ENDIF

        TRY
            THIS.FormParaBO()
            THIS.this_oBusinessObject.Recalcular()
            THIS.AtualizarTotais()
            IF PEMSTATUS(THIS.pgf_4c_Paginas.Page2, "grd_4c_Detalhe", 5)
                THIS.pgf_4c_Paginas.Page2.grd_4c_Detalhe.Refresh()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "BtnRecalcularClick")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnRelatorioClick - Gera relatorio de calculo de juros (BtnVideo)
    *--------------------------------------------------------------------------
    PROCEDURE BtnRelatorioClick()
        LOCAL loc_cCursorDet
        loc_cCursorDet = THIS.this_oBusinessObject.this_cCursorDetalhe

        IF !USED(loc_cCursorDet) OR RECCOUNT(loc_cCursorDet) = 0
            MsgAviso("Nenhum detalhe dispon" + CHR(237) + "vel para relat" + CHR(243) + "rio.", "Relat" + CHR(243) + "rio")
            RETURN
        ENDIF

        TRY
            THIS.ExecutarReportForm(gc_4c_CaminhoReports + "SIGCDCCJ.frx", "PREVIEW", loc_cCursorDet)
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "BtnRelatorioClick")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarContas - Valida conta informada e auto-preenche descricao (LostFocus)
    * Substitui fAcessoContas do legado por SQL direto + FormBuscaAuxiliar
    *--------------------------------------------------------------------------
    PROCEDURE ValidarContas
        LPARAMETERS par_nKeyCode, par_nShiftAltCtrl
        LOCAL loc_oPg2, loc_cContas
        loc_oPg2    = THIS.pgf_4c_Paginas.Page2
        loc_cContas = ALLTRIM(NVL(loc_oPg2.txt_4c_Contas.Value, ""))

        IF EMPTY(loc_cContas)
            loc_oPg2.txt_4c_DContas.Value = ""
            RETURN
        ENDIF

        TRY
            IF THIS.this_oBusinessObject.BuscarContaPorCodigo(loc_cContas)
                loc_oPg2.txt_4c_DContas.Value = THIS.this_oBusinessObject.this_cDContas
            ELSE
                THIS.AbrirBuscaContas(loc_cContas)
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "ValidarContas")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * AbrirBuscaContas - Abre FormBuscaAuxiliar para selecionar conta em SigCdCli
    *--------------------------------------------------------------------------
    PROCEDURE AbrirBuscaContas(par_cValorInicial)
        LOCAL loc_oBusca, loc_oPg2
        loc_oBusca = .NULL.
        loc_oPg2   = THIS.pgf_4c_Paginas.Page2

        TRY
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigCdCli", "cursor_4c_BuscaConta", "iclis", ;
                par_cValorInicial, "Selecionar Conta")

            IF VARTYPE(loc_oBusca) = "O"
                IF loc_oBusca.this_lAchouRegistro AND loc_oBusca.this_lSelecionou
                    IF USED("cursor_4c_BuscaConta")
                        SELECT cursor_4c_BuscaConta
                        loc_oPg2.txt_4c_Contas.Value  = ALLTRIM(NVL(iclis, ""))
                        loc_oPg2.txt_4c_DContas.Value = ALLTRIM(NVL(rclis, ""))
                    ENDIF
                ELSE
                    IF !loc_oBusca.this_lAchouRegistro
                    loc_oBusca.mAddColuna("iclis", "", "Conta")
                    loc_oBusca.mAddColuna("rclis", "", "Nome")
                    loc_oBusca.Show()
                    IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaConta")
                        SELECT cursor_4c_BuscaConta
                        loc_oPg2.txt_4c_Contas.Value  = ALLTRIM(NVL(iclis, ""))
                        loc_oPg2.txt_4c_DContas.Value = ALLTRIM(NVL(rclis, ""))
                    ELSE
                        loc_oPg2.txt_4c_Contas.Value  = ""
                        loc_oPg2.txt_4c_DContas.Value = ""
                    ENDIF
                    ENDIF
                ENDIF
                loc_oBusca.Release()
            ENDIF

            IF USED("cursor_4c_BuscaConta")
                USE IN cursor_4c_BuscaConta
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "AbrirBuscaContas")
            IF USED("cursor_4c_BuscaConta")
                USE IN cursor_4c_BuscaConta
            ENDIF
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * OptDiasChanged - Dispara recalculo ao mudar tipo de dias (Corridos/Uteis)
    *--------------------------------------------------------------------------
    PROCEDURE OptDiasChanged()
        LOCAL loc_oPg2
        loc_oPg2 = THIS.pgf_4c_Paginas.Page2

        IF EMPTY(loc_oPg2.txt_4c_DataBase.Value)
            RETURN
        ENDIF

        TRY
            THIS.FormParaBO()
            THIS.this_oBusinessObject.Recalcular()
            THIS.AtualizarTotais()
            IF PEMSTATUS(THIS.pgf_4c_Paginas.Page2, "grd_4c_Detalhe", 5)
                THIS.pgf_4c_Paginas.Page2.grd_4c_Detalhe.Refresh()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "OptDiasChanged")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * AtualizarGradeDetalhe - Wira RecordSource/ControlSources do grd_4c_Detalhe
    * Chamado apos BuscarDetalhe() para associar grid ao cursor de detalhe
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE AtualizarGradeDetalhe()
        LOCAL loc_oPg2, loc_oGrd, loc_cAlias
        loc_oPg2  = THIS.pgf_4c_Paginas.Page2
        loc_cAlias = THIS.this_oBusinessObject.this_cCursorDetalhe

        IF !PEMSTATUS(loc_oPg2, "grd_4c_Detalhe", 5)
            RETURN
        ENDIF

        TRY
            loc_oGrd = loc_oPg2.grd_4c_Detalhe

            IF USED(loc_cAlias)
                loc_oGrd.RecordSource          = loc_cAlias
                loc_oGrd.Column1.ControlSource = loc_cAlias + ".datas"
                loc_oGrd.Column2.ControlSource = loc_cAlias + ".valor"
                loc_oGrd.Column3.ControlSource = loc_cAlias + ".dias"
                loc_oGrd.Column4.ControlSource = loc_cAlias + ".liquido"
            ELSE
                loc_oGrd.RecordSource          = ""
                loc_oGrd.Column1.ControlSource = ""
                loc_oGrd.Column2.ControlSource = ""
                loc_oGrd.Column3.ControlSource = ""
                loc_oGrd.Column4.ControlSource = ""
            ENDIF

            loc_oGrd.Refresh()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "AtualizarGradeDetalhe")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * AtualizarTotais - Escaneia cursor de detalhe e atualiza campos de totais
    * Chamado apos Recalcular(), ExcluirVClick() e BOParaForm()
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE AtualizarTotais()
        LOCAL loc_oPg2, loc_cAlias
        LOCAL loc_nQtde, loc_nTotalDias, loc_nTotal, loc_nTotLiq, loc_nDias
        loc_oPg2       = THIS.pgf_4c_Paginas.Page2
        loc_cAlias     = THIS.this_oBusinessObject.this_cCursorDetalhe
        loc_nQtde      = 0
        loc_nTotalDias = 0
        loc_nTotal     = 0
        loc_nTotLiq    = 0
        loc_nDias      = 0

        IF !PEMSTATUS(loc_oPg2, "txt_4c_Qtde", 5)
            RETURN
        ENDIF

        TRY
            IF USED(loc_cAlias)
                SELECT (loc_cAlias)
                SCAN
                    IF !EMPTY(datas)
                        loc_nQtde      = loc_nQtde + 1
                        loc_nDias      = NVL(dias, 0)
                        loc_nTotalDias = loc_nTotalDias + loc_nDias
                        loc_nTotal     = loc_nTotal + NVL(valor, 0)
                        loc_nTotLiq    = loc_nTotLiq + NVL(liquido, 0)
                    ENDIF
                ENDSCAN
            ENDIF

            loc_oPg2.txt_4c_Qtde.Value   = loc_nQtde
            loc_oPg2.txt_4c_Media.Value  = IIF(loc_nQtde > 0, loc_nTotalDias / loc_nQtde, 0)
            loc_oPg2.txt_4c_Total.Value  = loc_nTotal
            loc_oPg2.txt_4c_TotLiq.Value = loc_nTotLiq
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "AtualizarTotais")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * RecalcularItem - Recalcula juros ao sair do campo Valor no grid (LostFocus)
    *--------------------------------------------------------------------------
    PROCEDURE RecalcularItem()
        LOCAL loc_oPg2
        loc_oPg2 = THIS.pgf_4c_Paginas.Page2

        IF EMPTY(THIS.this_oBusinessObject.this_dDataBase)
            RETURN
        ENDIF

        TRY
            THIS.this_oBusinessObject.Recalcular()

            IF PEMSTATUS(loc_oPg2, "grd_4c_Detalhe", 5)
                loc_oPg2.grd_4c_Detalhe.Refresh()
            ENDIF

            THIS.AtualizarTotais()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "RecalcularItem")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarDataDetalhe - Valida data ao sair do campo Data no grid (LostFocus)
    * Limpa data invalida (ano < 1900) para nao quebrar Recalcular
    *--------------------------------------------------------------------------
    PROCEDURE ValidarDataDetalhe
        LPARAMETERS par_nKeyCode, par_nShiftAltCtrl
        LOCAL loc_oPg2, loc_cAlias
        loc_oPg2  = THIS.pgf_4c_Paginas.Page2
        loc_cAlias = THIS.this_oBusinessObject.this_cCursorDetalhe

        TRY
            IF !PEMSTATUS(loc_oPg2, "grd_4c_Detalhe", 5) OR !USED(loc_cAlias)
                RETURN
            ENDIF

            SELECT (loc_cAlias)

            IF !EOF() AND !BOF() AND !EMPTY(datas) AND YEAR(TTOD(datas)) < 1900
                REPLACE datas WITH {}
                loc_oPg2.grd_4c_Detalhe.Refresh()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "ValidarDataDetalhe")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * InserirVClick - Adiciona nova linha em branco ao cursor de detalhe
    *--------------------------------------------------------------------------
    PROCEDURE InserirVClick()
        LOCAL loc_cAlias, loc_oPg2
        loc_cAlias = THIS.this_oBusinessObject.this_cCursorDetalhe
        loc_oPg2   = THIS.pgf_4c_Paginas.Page2

        IF !USED(loc_cAlias)
            RETURN
        ENDIF

        TRY
            SELECT (loc_cAlias)
            APPEND BLANK
            REPLACE cidchaves WITH "", ;
                    codigo    WITH THIS.this_oBusinessObject.this_cCodigo, ;
                    datas     WITH {}, ;
                    dias      WITH 0, ;
                    liquido   WITH 0, ;
                    valor     WITH 0

            IF PEMSTATUS(loc_oPg2, "grd_4c_Detalhe", 5)
                loc_oPg2.grd_4c_Detalhe.Refresh()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "InserirVClick")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * ExcluirVClick - Remove linha corrente do cursor de detalhe
    * Reconstroi o cursor sem o registro excluido (PACK nao funciona em cursors)
    *--------------------------------------------------------------------------
    PROCEDURE ExcluirVClick()
        LOCAL loc_cAlias, loc_oPg2, loc_lConfirma, loc_cTemp
        loc_cAlias    = THIS.this_oBusinessObject.this_cCursorDetalhe
        loc_oPg2      = THIS.pgf_4c_Paginas.Page2
        loc_lConfirma = .F.
        loc_cTemp     = "cursor_4c_DetTemp"

        IF !USED(loc_cAlias)
            RETURN
        ENDIF

        SELECT (loc_cAlias)
        IF RECCOUNT() = 0 OR EOF()
            MsgAviso("Nenhuma linha selecionada.", "Excluir")
            RETURN
        ENDIF

        loc_lConfirma = MsgConfirma("Deseja excluir a linha selecionada?", "Excluir")
        IF !loc_lConfirma
            RETURN
        ENDIF

        TRY
            *-- Marca e reconstroi cursor sem o registro (DELETE + SELECT WHERE !DELETED())
            SELECT (loc_cAlias)
            DELETE

            IF USED(loc_cTemp)
                USE IN (loc_cTemp)
            ENDIF

            SELECT cidchaves, codigo, datas, dias, liquido, valor ;
                FROM (loc_cAlias) WHERE !DELETED() ;
                INTO CURSOR (loc_cTemp) READWRITE

            USE IN (loc_cAlias)

            SELECT cidchaves, codigo, datas, dias, liquido, valor ;
                FROM (loc_cTemp) ;
                INTO CURSOR (loc_cAlias) READWRITE

            IF USED(loc_cTemp)
                USE IN (loc_cTemp)
            ENDIF

            THIS.AtualizarGradeDetalhe()
            THIS.AtualizarTotais()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "ExcluirVClick")
            IF USED(loc_cTemp)
                USE IN (loc_cTemp)
            ENDIF
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * ExecutarReportForm - Helper REPORT FORM com guards FILE/cursor e isolamento locale
    * par_cModo: "PREVIEW" | "PRINTER" | "PRINTER_PROMPT"
    *--------------------------------------------------------------------------
    PROCEDURE ExecutarReportForm(par_cFRXPath, par_cModo, par_cCursorDados)
        LOCAL loc_cPonto, loc_cSeparador, loc_lResultado
        loc_cPonto     = SET("POINT")
        loc_cSeparador = SET("SEPARATOR")
        loc_lResultado = .F.

        IF !FILE(FULLPATH(par_cFRXPath))
            MsgErro("Arquivo de relat" + CHR(243) + "rio n" + CHR(227) + "o encontrado:" + ;
                CHR(13) + par_cFRXPath, "Relat" + CHR(243) + "rio")
            RETURN .F.
        ENDIF

        IF VARTYPE(par_cCursorDados) = "C" AND !EMPTY(par_cCursorDados)
            IF !USED(par_cCursorDados) OR RECCOUNT(par_cCursorDados) = 0
                MsgAviso("Nenhum dado dispon" + CHR(237) + "vel para o relat" + ;
                    CHR(243) + "rio.", "Relat" + CHR(243) + "rio")
                RETURN .F.
            ENDIF
        ENDIF

        TRY
            SET POINT TO "."
            SET SEPARATOR TO ","
            SET REPORTBEHAVIOR 80

            DO CASE
            CASE UPPER(ALLTRIM(par_cModo)) = "PREVIEW"
                REPORT FORM (FULLPATH(par_cFRXPath)) NOCONSOLE PREVIEW
            CASE UPPER(ALLTRIM(par_cModo)) = "PRINTER_PROMPT"
                REPORT FORM (FULLPATH(par_cFRXPath)) NOCONSOLE TO PRINTER PROMPT
            CASE UPPER(ALLTRIM(par_cModo)) = "PRINTER"
                REPORT FORM (FULLPATH(par_cFRXPath)) NOCONSOLE TO PRINTER
            OTHERWISE
                REPORT FORM (FULLPATH(par_cFRXPath)) NOCONSOLE PREVIEW
            ENDCASE

            loc_lResultado = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "ExecutarReportForm")
        ENDTRY

        SET POINT TO loc_cPonto
        SET SEPARATOR TO loc_cSeparador
        SET REPORTBEHAVIOR 90

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * Destroy - Libera cursor e BO; chama FormBase.Destroy como ultima linha
    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
        TRY
            IF USED("cursor_4c_Dados")
                USE IN cursor_4c_Dados
            ENDIF

            IF USED("cursor_4c_Detalhe")
                USE IN cursor_4c_Detalhe
            ENDIF

            IF VARTYPE(THIS.this_oBusinessObject) = "O"
                THIS.this_oBusinessObject = .NULL.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "FormCCJ.Destroy")
        ENDTRY

        DODEFAULT()
    ENDPROC

ENDDEFINE


### BO (C:\4c\projeto\app\classes\CCJBO.prg):
*============================================================================
* CCJBO.prg - Business Object para Calculo de Juros
*
* Tabela principal : SigCdCcj  (PK: codigo char(6))
* Tabela detalhe   : SigDtCcj  (PK: cidchaves char(20), FK: codigo char(6))
* Lookup conta     : SigCdCli  (PK: Iclis, desc: Rclis)
*
* Herda de: BusinessBase
* Criado em: Fase 1 - Propriedades e Init
*============================================================================

DEFINE CLASS CCJBO AS BusinessBase

    *==========================================================================
    * Propriedades da entidade SigCdCcj (campos do banco)
    *==========================================================================
    this_cCodigo   = ""    && char(6)       - Chave primaria (gerada externamente)
    this_cContas   = ""    && char(10)      - Conta (FK SigCdCli.Iclis)
    this_dDataBase = {}    && datetime NULL - Data Base para calculo de juros
    this_nFator    = 0     && numeric(5,2)  - Fator de juros (porcentagem)
    this_nTotal    = 0     && numeric(11,2) - Total bruto dos documentos
    this_nTotLiq   = 0     && numeric(11,2) - Total liquido apos calculo de juros

    *==========================================================================
    * Propriedades de exibicao - nao armazenadas no banco
    *==========================================================================
    this_cDContas   = ""   && Descricao da conta (SigCdCli.Rclis, exibicao)
    this_nQtde      = 0    && Quantidade de documentos no detalhe (calculada)
    this_nMedia     = 0    && Media de dias calculados
    this_nTiposDias = 1    && Tipo calculo: 1=Corridos, 2=Uteis (optDias.Value)

    *==========================================================================
    * Init - Inicializa o Business Object configurando tabela e chave primaria
    *==========================================================================
    PROCEDURE Init()
        LOCAL loc_lResultado
        loc_lResultado = .F.

        TRY
            DODEFAULT()
            THIS.this_cTabela     = "SigCdCcj"
            THIS.this_cCampoChave = "codigo"
            loc_lResultado = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *-- Alias do cursor de detalhe (SigDtCcj)
    this_cCursorDetalhe = "cursor_4c_Detalhe"

    *==========================================================================
    * ObterChavePrimaria - Retorna valor da PK para RegistrarAuditoria
    *==========================================================================
    PROTECTED PROCEDURE ObterChavePrimaria()
        RETURN THIS.this_cCodigo
    ENDPROC

    *==========================================================================
    * CarregarDoCursor - Mapeia campos do cursor para propriedades do BO
    *==========================================================================
    PROTECTED PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        IF USED(par_cAliasCursor)
            SELECT (par_cAliasCursor)
            THIS.this_cCodigo   = ALLTRIM(TratarNulo(codigo, "C"))
            THIS.this_cContas   = ALLTRIM(TratarNulo(contas, "C"))
            THIS.this_dDataBase = TratarNulo(data_base, "D")
            THIS.this_nFator    = TratarNulo(fator, "N")
            THIS.this_nTotal    = TratarNulo(total, "N")
            THIS.this_nTotLiq   = TratarNulo(totliq, "N")
            THIS.this_lNovoRegistro = .F.
            loc_lSucesso = .T.
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * Buscar - SELECT com JOIN SigCdCli para o grid da lista
    *==========================================================================
    PROCEDURE Buscar(par_cFiltro)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso, loc_cWhere
        loc_lSucesso = .F.
        loc_cWhere   = ""

        TRY
            IF USED("cursor_4c_Dados")
                USE IN cursor_4c_Dados
            ENDIF

            loc_cSQL = "SELECT a.codigo, a.contas, a.data_base, a.fator, a.total, a.totliq," + ;
                       " ISNULL(b.rclis, '') AS desconta" + ;
                       " FROM sigcdccj a" + ;
                       " LEFT JOIN sigcdcli b ON b.iclis = a.contas"

            IF VARTYPE(par_cFiltro) = "C" AND !EMPTY(ALLTRIM(par_cFiltro))
                loc_cWhere = " WHERE a.contas LIKE " + EscaparSQL("%" + ALLTRIM(par_cFiltro) + "%") + ;
                             " OR ISNULL(b.rclis, '') LIKE " + EscaparSQL("%" + ALLTRIM(par_cFiltro) + "%")
                loc_cSQL = loc_cSQL + loc_cWhere
            ENDIF

            loc_cSQL = loc_cSQL + " ORDER BY a.contas, a.data_base DESC"

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")

            IF loc_nResultado > 0
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao buscar C" + CHR(225) + "lculo de Juros:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * CarregarPorCodigo - SELECT pelo codigo (PK) para edicao/visualizacao
    *==========================================================================
    PROCEDURE CarregarPorCodigo(par_cCodigo)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF USED("cursor_4c_Carrega")
                USE IN cursor_4c_Carrega
            ENDIF

            loc_cSQL = "SELECT codigo, contas, data_base, fator, total, totliq" + ;
                       " FROM sigcdccj" + ;
                       " WHERE codigo = " + EscaparSQL(par_cCodigo)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")

            IF loc_nResultado > 0 AND RECCOUNT("cursor_4c_Carrega") > 0
                loc_lSucesso = THIS.CarregarDoCursor("cursor_4c_Carrega")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        IF USED("cursor_4c_Carrega")
            USE IN cursor_4c_Carrega
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * GerarCodigo - Gera codigo unico de 6 chars via SQL Server NEWID()
    *==========================================================================
    PROCEDURE GerarCodigo()
        LOCAL loc_cSQL, loc_nResultado, loc_cNovoCodigo
        loc_cNovoCodigo = ""

        TRY
            IF USED("cursor_4c_GerarCod")
                USE IN cursor_4c_GerarCod
            ENDIF

            loc_cSQL = "SELECT UPPER(LEFT(REPLACE(NEWID(), '-', ''), 6)) AS novoCodigo"
            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_GerarCod")

            IF loc_nResultado > 0 AND RECCOUNT("cursor_4c_GerarCod") > 0
                SELECT cursor_4c_GerarCod
                loc_cNovoCodigo = ALLTRIM(novoCodigo)
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        IF USED("cursor_4c_GerarCod")
            USE IN cursor_4c_GerarCod
        ENDIF

        RETURN loc_cNovoCodigo
    ENDPROC

    *==========================================================================
    * BuscarDetalhe - Carrega linhas de SigDtCcj para cursor de detalhe
    *                 Se par_cCodigo vazio, cria cursor vazio com a estrutura
    *==========================================================================
    PROCEDURE BuscarDetalhe(par_cCodigo)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF USED(THIS.this_cCursorDetalhe)
                USE IN (THIS.this_cCursorDetalhe)
            ENDIF

            IF EMPTY(ALLTRIM(par_cCodigo))
                SET NULL ON
                CREATE CURSOR (THIS.this_cCursorDetalhe) ;
                    (cidchaves C(20), codigo C(6), datas T, ;
                     dias N(3,0), liquido N(11,2), valor N(11,2))
                SET NULL OFF
                loc_lSucesso = .T.
            ELSE
                loc_cSQL = "SELECT cidchaves, codigo, datas, dias, liquido, valor" + ;
                           " FROM sigdtccj" + ;
                           " WHERE codigo = " + EscaparSQL(par_cCodigo) + ;
                           " ORDER BY datas"

                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_DetLoad")

                IF loc_nResultado > 0
                    *-- Converte para READWRITE (SQLEXEC gera somente-leitura por padrao)
                    *-- Necessario para APPEND BLANK (InserirV) e REPLACE (Recalcular)
                    SELECT cidchaves, codigo, datas, dias, liquido, valor ;
                        FROM cursor_4c_DetLoad ;
                        INTO CURSOR (THIS.this_cCursorDetalhe) READWRITE
                    IF USED("cursor_4c_DetLoad")
                        USE IN cursor_4c_DetLoad
                    ENDIF
                    loc_lSucesso = .T.
                ELSE
                    MsgErro("Erro ao carregar detalhe:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * BuscarContaPorCodigo - Valida e retorna descricao de SigCdCli
    *==========================================================================
    PROCEDURE BuscarContaPorCodigo(par_cConta)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        IF EMPTY(ALLTRIM(par_cConta))
            THIS.this_cDContas = ""
            RETURN .F.
        ENDIF

        TRY
            IF USED("cursor_4c_BuscaConta")
                USE IN cursor_4c_BuscaConta
            ENDIF

            loc_cSQL = "SELECT iclis, rclis" + ;
                       " FROM sigcdcli" + ;
                       " WHERE iclis = " + EscaparSQL(par_cConta)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaConta")

            IF loc_nResultado > 0 AND RECCOUNT("cursor_4c_BuscaConta") > 0
                SELECT cursor_4c_BuscaConta
                THIS.this_cDContas = ALLTRIM(NVL(rclis, ""))
                loc_lSucesso = .T.
            ELSE
                THIS.this_cDContas = ""
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        IF USED("cursor_4c_BuscaConta")
            USE IN cursor_4c_BuscaConta
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * InserirDetalhe - PROTECTED: persiste cursor de detalhe em sigdtccj
    *==========================================================================
    PROTECTED PROCEDURE InserirDetalhe()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso, loc_cAlias
        LOCAL loc_cCodigo, loc_dDatas, loc_nDias, loc_nLiquido, loc_nValor
        loc_lSucesso = .T.
        loc_cAlias   = THIS.this_cCursorDetalhe

        IF !USED(loc_cAlias)
            RETURN .T.
        ENDIF

        TRY
            SELECT (loc_cAlias)
            GO TOP

            SCAN
                IF EMPTY(datas)
                    LOOP
                ENDIF

                loc_cCodigo  = THIS.this_cCodigo
                loc_dDatas   = datas
                loc_nDias    = NVL(dias, 0)
                loc_nLiquido = NVL(liquido, 0)
                loc_nValor   = NVL(valor, 0)

                loc_cSQL = "INSERT INTO sigdtccj" + ;
                           " (cidchaves, codigo, datas, dias, liquido, valor)" + ;
                           " VALUES (" + ;
                           " LEFT(REPLACE(NEWID(), '-', ''), 20)," + ;
                           EscaparSQL(loc_cCodigo) + "," + ;
                           FormatarDataSQL(loc_dDatas) + "," + ;
                           FormatarNumeroSQL(loc_nDias) + "," + ;
                           FormatarNumeroSQL(loc_nLiquido) + "," + ;
                           FormatarNumeroSQL(loc_nValor) + ")"

                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

                IF loc_nResultado < 0
                    MsgErro("Erro ao inserir linha de detalhe:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                    loc_lSucesso = .F.
                    EXIT
                ENDIF
            ENDSCAN
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * Inserir - PROTECTED: INSERT em sigcdccj + linhas sigdtccj
    *==========================================================================
    PROTECTED PROCEDURE Inserir()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "INSERT INTO sigcdccj (codigo, contas, data_base, fator, total, totliq)" + ;
                       " VALUES (" + ;
                       EscaparSQL(THIS.this_cCodigo) + "," + ;
                       EscaparSQL(THIS.this_cContas) + "," + ;
                       FormatarDataSQL(THIS.this_dDataBase) + "," + ;
                       FormatarNumeroSQL(THIS.this_nFator) + "," + ;
                       FormatarNumeroSQL(THIS.this_nTotal) + "," + ;
                       FormatarNumeroSQL(THIS.this_nTotLiq) + ")"

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                IF THIS.InserirDetalhe()
                    THIS.RegistrarAuditoria("INSERT")
                    loc_lSucesso = .T.
                ENDIF
            ELSE
                MsgErro("Erro ao inserir C" + CHR(225) + "lculo de Juros:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * Atualizar - PROTECTED: DELETE+INSERT (padrao legado msv_alterar)
    *             Delete cabecalho + detalhe antigos, reinsere com novos valores
    *==========================================================================
    PROTECTED PROCEDURE Atualizar()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            *-- DELETE detalhe primeiro (FK)
            loc_cSQL = "DELETE FROM sigdtccj WHERE codigo = " + EscaparSQL(THIS.this_cCodigo)
            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado < 0
                MsgErro("Erro ao remover detalhe para atualizar:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                loc_lSucesso = .F.
            ENDIF

            *-- DELETE cabecalho
            loc_cSQL = "DELETE FROM sigcdccj WHERE codigo = " + EscaparSQL(THIS.this_cCodigo)
            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado < 0
                MsgErro("Erro ao remover cabecalho para atualizar:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                loc_lSucesso = .F.
            ENDIF

            *-- RE-INSERT cabecalho com valores atualizados
            loc_cSQL = "INSERT INTO sigcdccj (codigo, contas, data_base, fator, total, totliq)" + ;
                       " VALUES (" + ;
                       EscaparSQL(THIS.this_cCodigo) + "," + ;
                       EscaparSQL(THIS.this_cContas) + "," + ;
                       FormatarDataSQL(THIS.this_dDataBase) + "," + ;
                       FormatarNumeroSQL(THIS.this_nFator) + "," + ;
                       FormatarNumeroSQL(THIS.this_nTotal) + "," + ;
                       FormatarNumeroSQL(THIS.this_nTotLiq) + ")"

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                IF THIS.InserirDetalhe()
                    THIS.RegistrarAuditoria("UPDATE")
                    loc_lSucesso = .T.
                ENDIF
            ELSE
                MsgErro("Erro ao reinserir C" + CHR(225) + "lculo de Juros:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * ExecutarExclusao - PROTECTED: DELETE de sigdtccj e sigcdccj
    *==========================================================================
    PROTECTED PROCEDURE ExecutarExclusao()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            *-- DELETE detalhe primeiro (integridade referencial)
            loc_cSQL = "DELETE FROM sigdtccj WHERE codigo = " + EscaparSQL(THIS.this_cCodigo)
            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado < 0
                MsgErro("Erro ao excluir detalhe:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                loc_lSucesso = .F.
            ENDIF

            *-- DELETE cabecalho
            loc_cSQL = "DELETE FROM sigcdccj WHERE codigo = " + EscaparSQL(THIS.this_cCodigo)
            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("DELETE")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao excluir C" + CHR(225) + "lculo de Juros:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * Recalcular - Recalcula juros de cada linha do detalhe
    * Prerequisito: this_dDataBase, this_nFator e this_nTiposDias setados
    * Atualiza Dias/Liquido no cursor_4c_Detalhe e acumula this_n* totais
    *==========================================================================
    PROCEDURE Recalcular()
        LOCAL loc_lSucesso, loc_cAlias
        LOCAL loc_dBase, loc_nFator, loc_nTipo
        LOCAL loc_nQtde, loc_nTotalDias, loc_nTotal, loc_nTotLiq
        LOCAL loc_nDias, loc_nLiquido, loc_dDatas_d, loc_dBase_d, loc_nValor

        loc_lSucesso   = .F.
        loc_cAlias     = THIS.this_cCursorDetalhe
        loc_dBase      = THIS.this_dDataBase
        loc_nFator     = THIS.this_nFator
        loc_nTipo      = THIS.this_nTiposDias
        loc_nQtde      = 0
        loc_nTotalDias = 0
        loc_nTotal     = 0
        loc_nTotLiq    = 0

        IF !USED(loc_cAlias)
            MsgErro("Cursor de detalhe n" + CHR(227) + "o dispon" + CHR(237) + "vel.", "Recalcular")
            RETURN .F.
        ENDIF

        IF EMPTY(loc_dBase)
            MsgErro("Data Base n" + CHR(227) + "o informada.", "Recalcular")
            RETURN .F.
        ENDIF

        TRY
            loc_dBase_d = TTOD(loc_dBase)

            SELECT (loc_cAlias)
            GO TOP

            SCAN
                IF EMPTY(datas)
                    LOOP
                ENDIF

                loc_dDatas_d = TTOD(datas)
                loc_nValor   = NVL(valor, 0)
                loc_nDias    = loc_dDatas_d - loc_dBase_d

                IF loc_nDias < 0
                    loc_nDias = 0
                ENDIF

                IF loc_nDias > 0 AND loc_nTipo = 2
                    loc_nDias = THIS.ContarDiasUteis(loc_dBase_d, loc_dDatas_d)
                ENDIF

                loc_nLiquido = loc_nValor + loc_nValor * (loc_nFator / 100) * loc_nDias

                REPLACE dias WITH loc_nDias, liquido WITH loc_nLiquido

                loc_nQtde      = loc_nQtde + 1
                loc_nTotalDias = loc_nTotalDias + loc_nDias
                loc_nTotal     = loc_nTotal + loc_nValor
                loc_nTotLiq    = loc_nTotLiq + loc_nLiquido
            ENDSCAN

            THIS.this_nQtde   = loc_nQtde
            THIS.this_nMedia  = IIF(loc_nQtde > 0, loc_nTotalDias / loc_nQtde, 0)
            THIS.this_nTotal  = loc_nTotal
            THIS.this_nTotLiq = loc_nTotLiq

            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Recalcular")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * ContarDiasUteis - Conta dias seg-sex entre par_dInicio e par_dFim (inc.)
    *==========================================================================
    PROTECTED PROCEDURE ContarDiasUteis(par_dInicio, par_dFim)
        LOCAL loc_nCount, loc_dCurrent, loc_nDow
        loc_nCount   = 0
        loc_dCurrent = par_dInicio

        DO WHILE loc_dCurrent <= par_dFim
            loc_nDow = DOW(loc_dCurrent)
            IF loc_nDow != 1 AND loc_nDow != 7
                loc_nCount = loc_nCount + 1
            ENDIF
            loc_dCurrent = loc_dCurrent + 1
        ENDDO

        RETURN loc_nCount
    ENDPROC

ENDDEFINE


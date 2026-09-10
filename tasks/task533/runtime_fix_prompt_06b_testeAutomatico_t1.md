# CORRIGIR ERRO DE RUNTIME VFP9

## TAREFA OBRIGATORIA
O formulario VFP9 apresentou erro de runtime durante teste automatizado.
Voce DEVE corrigir o erro e salvar os arquivos corrigidos usando Write tool.

## ERRO DETECTADO
- Etapa: 06b_testeAutomatico
- Tentativa: 1/10
- Mensagem: Testes automaticos: 89% < 100%. Falhas: Teste 'ModoVisualizar': Property AJUSTARBOTOESPORMODO is not found. | Detalhes: Linha: 574

## CONTEXTO DO ERRO

### LOG DA ETAPA (06b_testeAutomatico):
[2026-09-09 18:17:52] [INFO] === VFP EXECUTOR v2.0 ===
[2026-09-09 18:17:52] [INFO] Config FPW: (nao fornecido)
[2026-09-09 18:17:52] [INFO] Script PRG: C:\4c\projeto\app\utils\TesteAutomatico.prg
[2026-09-09 18:17:52] [INFO] Timeout: 300 segundos
[2026-09-09 18:17:52] [INFO] Wrapper PRG criado para parametros: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_dmzhj1uq.prg
[2026-09-09 18:17:52] [INFO] Conteudo do wrapper:
[2026-09-09 18:17:52] [INFO] * Auto-generated wrapper for parameters
* Script: C:\4c\projeto\app\utils\TesteAutomatico.prg
* Parameters: 'FormTCL', 'C:\4c\tasks\task533', 'CRUD'

* Anti-dialog protections for unattended execution
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
SET NOTIFY OFF
SYS(2335, 0)

DO "C:\4c\projeto\app\utils\TesteAutomatico" WITH 'FormTCL', 'C:\4c\tasks\task533', 'CRUD'
QUIT

[2026-09-09 18:17:52] [INFO] Comando VFP: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_dmzhj1uq.prg
[2026-09-09 18:17:52] [INFO] VFP output esperado em: C:\4c\tasks\task533\vfp_output.txt
[2026-09-09 18:17:52] [INFO] Executando Visual FoxPro 9...
[2026-09-09 18:17:52] [INFO] Comando completo: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_dmzhj1uq.prg
[2026-09-09 18:17:52] [INFO] Executando: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_dmzhj1uq.prg
[2026-09-09 18:17:52] [INFO] Timeout configurado: 300 segundos
[2026-09-09 18:19:32] [INFO] VFP9 finalizou normalmente com exit code: 
[2026-09-09 18:19:32] [INFO] VFP9 finalizado em 99.9754095 segundos
[2026-09-09 18:19:32] [INFO] Exit Code: 
[2026-09-09 18:19:32] [INFO] 
[2026-09-09 18:19:32] [INFO] Arquivos temporarios preservados para inspecao:
[2026-09-09 18:19:32] [INFO]   Wrapper.prg: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_dmzhj1uq.prg
[2026-09-09 18:19:32] [INFO] 
[2026-09-09 18:19:32] [INFO] === Conteudo do Wrapper.prg temporario ===
[2026-09-09 18:19:32] [INFO] * Auto-generated wrapper for parameters
[2026-09-09 18:19:32] [INFO] * Script: C:\4c\projeto\app\utils\TesteAutomatico.prg
[2026-09-09 18:19:32] [INFO] * Parameters: 'FormTCL', 'C:\4c\tasks\task533', 'CRUD'
[2026-09-09 18:19:32] [INFO] 
[2026-09-09 18:19:32] [INFO] * Anti-dialog protections for unattended execution
[2026-09-09 18:19:32] [INFO] SET SAFETY OFF
[2026-09-09 18:19:32] [INFO] SET RESOURCE OFF
[2026-09-09 18:19:32] [INFO] SET TALK OFF
[2026-09-09 18:19:32] [INFO] SET NOTIFY OFF
[2026-09-09 18:19:32] [INFO] SYS(2335, 0)
[2026-09-09 18:19:32] [INFO] 
[2026-09-09 18:19:32] [INFO] DO "C:\4c\projeto\app\utils\TesteAutomatico" WITH 'FormTCL', 'C:\4c\tasks\task533', 'CRUD'
[2026-09-09 18:19:32] [INFO] QUIT
[2026-09-09 18:19:32] [INFO] 
[2026-09-09 18:19:32] [INFO] === Fim do Wrapper.prg ===
[2026-09-09 18:19:32] [WARN] AVISO: VFP9 retornou exit code  (normal para VFP9 GUI - validar pelo arquivo de saida)


### RESULTADO DOS TESTES (teste_resultado.json):
{
  "formClass": "FormTCL",
  "timestamp": "20260909181932",
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
      "detalhes": "Sem conexao DB: cursor nao criado (OK em modo teste)"
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
      "detalhes": "Linha: 574"
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

### FORM (C:\4c\projeto\app\forms\cadastros\FormTCL.prg):
*==============================================================================
* FormTCL.prg
* Formulario de Cadastro de Classes (SIGCDTCL)
*
* Tabela principal: SigCdCss (classes PK)
* Tipo: CRUD (frmcadastro)
* BO: TCLBO
*==============================================================================

DEFINE CLASS FormTCL AS FormBase

    *-- Propriedades visuais (PILAR 1 - UX FIDELITY)
    Height      = 600
    Width       = 1000
    Caption     = "Cadastro de Classes"
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
    this_cModoAtual       = "LISTA"

    *--------------------------------------------------------------------------
    * Init - APENAS retorna DODEFAULT (FormBase.Init chama InicializarForm)
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        LOCAL loc_lResultado
        loc_lResultado = .F.

        TRY
            loc_lResultado = DODEFAULT()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "FormTCL.Init")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * InicializarForm - Configura estrutura completa
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lResultado
        loc_lResultado = .F.

        TRY
            THIS.this_oBusinessObject = CREATEOBJECT("TCLBO")

            IF VARTYPE(THIS.this_oBusinessObject) != "O"
                MsgErro("Falha ao criar TCLBO", "Erro")
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
            MsgErro(loc_oErro.Message, "FormTCL.InicializarForm")
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
    * ConfigurarPaginaLista - Page1: cabecalho (faixa) + botoes CRUD
    * (Incluir/Visualizar/Alterar/Excluir/Buscar/Encerrar) + grid de listagem
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPaginaLista()
        LOCAL loc_oPg1, loc_oCab, loc_oBotoes
        loc_oPg1 = THIS.pgf_4c_Paginas.Page1

        *-- Cabecalho cinza (PRIMEIRO AddObject da pagina - CLAUDE.md regra #11)
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

        *-- Container de botoes CRUD (Grupo_op no legado: Left=542, Top=29)
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
        BINDEVENT(loc_oBotoes.cmd_4c_Buscar, "Click", THIS, "BtnBuscarClick")

        *-- Container Saida - PADRAO CANONICO (CLAUDE.md regra #10, prevalece sobre legado)
        loc_oPg1.AddObject("cnt_4c_Saida", "Container")
        WITH loc_oPg1.cnt_4c_Saida
            .Top         = 29
            .Left        = 917
            .Width       = 90
            .Height      = 85
            .BackStyle   = 0
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH

        loc_oPg1.cnt_4c_Saida.AddObject("cmd_4c_Encerrar", "CommandButton")
        WITH loc_oPg1.cnt_4c_Saida.cmd_4c_Encerrar
            .Caption         = "Encerrar"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
            .PicturePosition = 13
            .Top             = 5
            .Left            = 5
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
            .AutoSize        = .F.
            .Visible         = .T.
        ENDWITH
        BINDEVENT(loc_oPg1.cnt_4c_Saida.cmd_4c_Encerrar, "Click", THIS, "BtnEncerrarClick")

        *-- Grid de listagem de classes (colunas do legado: classes, descrs, nivels -
        *-- pColuna('classes',...,100), pColuna('descrs',...,319), pColuna('nivels',...,83))
        *-- Canonico framework: Top=117 (88+29 compensacao), Left=26, Width=880, Height=498
        loc_oPg1.AddObject("grd_4c_Lista", "Grid")
        loc_oPg1.grd_4c_Lista.ColumnCount = 3
        WITH loc_oPg1.grd_4c_Lista
            .Top                = 117
            .Left               = 26
            .Width              = 880
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
            .Visible            = .T.
        ENDWITH
        BINDEVENT(loc_oPg1.grd_4c_Lista, "DblClick", THIS, "BtnVisualizarClick")

        THIS.TornarControlesVisiveis(loc_oPg1)
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPaginaDados - Page2: faixa de cabecalho + container de botoes
    * de acao + primeiros 50% dos campos (Nivel, Classe, Descricao)
    * CLAUDE.md regra #11: a faixa deve ser o PRIMEIRO AddObject da pagina;
    * containers de botao (Top=29..33) sao criados DEPOIS para desenhar por cima.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPaginaDados()
        LOCAL loc_oPg2, loc_oCab, loc_oBotoesAcao
        loc_oPg2 = THIS.pgf_4c_Paginas.Page2

        *-- Faixa de cabecalho cinza (PRIMEIRO AddObject da pagina)
        loc_oPg2.AddObject("cnt_4c_Cabecalho", "Container")
        loc_oCab = loc_oPg2.cnt_4c_Cabecalho
        WITH loc_oCab
            .Top         = 29
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

        *-- Container de botoes de acao (Grupo_Salva no legado) - criado DEPOIS
        *-- da faixa para desenhar por cima (Top=33 fica dentro da area 29..109)
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

        *-- ===================================================================
        *-- CAMPOS PRINCIPAIS - PARTE 1/2 (FASE 5/8)
        *-- Compensacao PageFrame.Top=-29: Top_migrado = Top_original + 29
        *-- ===================================================================

        *-- txt_4c_Nivel (Get_nivel: ControlSource=crSigCdCss.nivels, Top=175,
        *-- Left=448, Width=17, Height=25) - numeric(1,0), dominio [1,2,3]
        loc_oPg2.AddObject("txt_4c_Nivel", "TextBox")
        WITH loc_oPg2.txt_4c_Nivel
            .Top           = 204
            .Left          = 448
            .Width         = 17
            .Height        = 25
            .InputMask     = "9"
            .SpecialEffect = 1
            .BorderColor   = RGB(100, 100, 100)
            .ForeColor     = RGB(0, 0, 0)
            .FontName      = "Tahoma"
            .FontSize      = 8
            .Value         = 0
            .Visible       = .T.
        ENDWITH

        *-- lbl_4c_Label1 (Say1: "N?vel :", Top=180, Left=414)
        loc_oPg2.AddObject("lbl_4c_Label1", "Label")
        WITH loc_oPg2.lbl_4c_Label1
            .AutoSize  = .T.
            .Caption   = "N" + CHR(237) + "vel :"
            .Top       = 209
            .Left      = 414
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        *-- lbl_4c_Label3 (Say3: dica de dominio "[1,2,3]", Top=179, Left=468)
        loc_oPg2.AddObject("lbl_4c_Label3", "Label")
        WITH loc_oPg2.lbl_4c_Label3
            .AutoSize  = .T.
            .Caption   = "[1,2,3]"
            .Top       = 208
            .Left      = 468
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        *-- txt_4c_Classe (Get_classe: ControlSource=crSigCdCss.classes, Top=202,
        *-- Left=448, Width=80, Height=25) - char(10), tamanho depende do nivel
        loc_oPg2.AddObject("txt_4c_Classe", "TextBox")
        WITH loc_oPg2.txt_4c_Classe
            .Top           = 231
            .Left          = 448
            .Width         = 80
            .Height        = 25
            .MaxLength     = 10
            .SpecialEffect = 1
            .BorderColor   = RGB(100, 100, 100)
            .ForeColor     = RGB(0, 0, 0)
            .FontName      = "Tahoma"
            .FontSize      = 8
            .Value         = ""
            .Visible       = .T.
        ENDWITH

        *-- lbl_4c_Label4 (Say4: "Classe :", Top=207, Left=406)
        loc_oPg2.AddObject("lbl_4c_Label4", "Label")
        WITH loc_oPg2.lbl_4c_Label4
            .AutoSize  = .T.
            .Caption   = "Classe :"
            .Top       = 236
            .Left      = 406
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        *-- txt_4c_Descr (Get_descr: ControlSource=crSigCdCss.descrs, Top=229,
        *-- Left=448, Width=220, Height=25) - char(30)
        loc_oPg2.AddObject("txt_4c_Descr", "TextBox")
        WITH loc_oPg2.txt_4c_Descr
            .Top           = 258
            .Left          = 448
            .Width         = 220
            .Height        = 25
            .MaxLength     = 30
            .SpecialEffect = 1
            .BorderColor   = RGB(100, 100, 100)
            .ForeColor     = RGB(0, 0, 0)
            .FontName      = "Tahoma"
            .FontSize      = 8
            .Value         = ""
            .Visible       = .T.
        ENDWITH

        *-- lbl_4c_Label2 (Say2: "Descri??o :", Top=234, Left=391)
        loc_oPg2.AddObject("lbl_4c_Label2", "Label")
        WITH loc_oPg2.lbl_4c_Label2
            .AutoSize  = .T.
            .Caption   = "Descri" + CHR(231) + CHR(227) + "o :"
            .Top       = 263
            .Left      = 391
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        *-- BINDEVENT Nivel/Classe - reproduz Get_nivel.Valid e Get_classe.GotFocus
        *-- do legado (ajuste dinamico de mascara + forca opbalancos=Sim quando nivel<>1)
        BINDEVENT(loc_oPg2.txt_4c_Nivel, "LostFocus", THIS, "ValidarCampoNivel")
        BINDEVENT(loc_oPg2.txt_4c_Classe, "GotFocus", THIS, "AjustarMascaraClasse")

        *-- ===================================================================
        *-- CAMPOS PRINCIPAIS - PARTE 2/2 (FASE 6/8)
        *-- OptionGroups (SEM lookup - comportamento.json confirma temLookup=false
        *-- em todos os 9 metodos do form original; nenhuma tabela auxiliar
        *-- referenciada via fwbuscaext/fwBuscaSel/sigacess)
        *-- ===================================================================

        *-- opt_4c_OpBalanco (optGreps: ControlSource=crSigCdCss.opbalancos,
        *-- Top=255, Left=442, Height=25) - "Incluir em Invent?rio" Sim(1)/Nao(2)
        loc_oPg2.AddObject("opt_4c_OpBalanco", "OptionGroup")
        WITH loc_oPg2.opt_4c_OpBalanco
            .ButtonCount = 2
            .Top         = 284
            .Left        = 442
            .Width       = 95
            .Height      = 25
            .BackStyle   = 0
            .BorderStyle = 0
            .Value       = 1
            .Visible     = .T.
        ENDWITH
        WITH loc_oPg2.opt_4c_OpBalanco.Buttons(1)
            .Caption   = "Sim"
            .Left      = 5
            .Top       = 5
            .AutoSize  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Themes    = .F.
        ENDWITH
        WITH loc_oPg2.opt_4c_OpBalanco.Buttons(2)
            .Caption   = "N" + CHR(227) + "o"
            .Left      = 50
            .Top       = 5
            .AutoSize  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Themes    = .F.
        ENDWITH

        *-- lbl_4c_Label5 (Say5: "Incluir em Invent?rio :", Top=260, Left=338)
        loc_oPg2.AddObject("lbl_4c_Label5", "Label")
        WITH loc_oPg2.lbl_4c_Label5
            .AutoSize  = .T.
            .Caption   = "Incluir em Invent" + CHR(225) + "rio :"
            .Top       = 289
            .Left      = 338
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        *-- opt_4c_InvEmisCc (Fwoption1: ControlSource=crSigCdCss.invemisccs,
        *-- Top=278, Left=442, Height=25) - "Trocar CC por Emissor" Sim(1)/Nao(2)
        loc_oPg2.AddObject("opt_4c_InvEmisCc", "OptionGroup")
        WITH loc_oPg2.opt_4c_InvEmisCc
            .ButtonCount = 2
            .Top         = 307
            .Left        = 442
            .Width       = 95
            .Height      = 25
            .BackStyle   = 0
            .BorderStyle = 0
            .Value       = 1
            .Visible     = .T.
        ENDWITH
        WITH loc_oPg2.opt_4c_InvEmisCc.Buttons(1)
            .Caption   = "Sim"
            .Left      = 5
            .Top       = 5
            .AutoSize  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Themes    = .F.
        ENDWITH
        WITH loc_oPg2.opt_4c_InvEmisCc.Buttons(2)
            .Caption   = "N" + CHR(227) + "o"
            .Left      = 50
            .Top       = 5
            .AutoSize  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Themes    = .F.
        ENDWITH

        *-- lbl_4c_Label6 (Say6: "Trocar CC por Emissor :", Top=283, Left=331)
        loc_oPg2.AddObject("lbl_4c_Label6", "Label")
        WITH loc_oPg2.lbl_4c_Label6
            .AutoSize  = .T.
            .Caption   = "Trocar CC por Emissor :"
            .Top       = 312
            .Left      = 331
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        *-- ===================================================================
        *-- BOTOES DE ACAO (Grupo_Salva no legado) - dentro de cnt_4c_BotoesAcao
        *-- criado em InicializarForm/ConfigurarPaginaDados acima (Top=33,Left=842)
        *-- ===================================================================

        *-- cmd_4c_Confirmar (Salva: Left=5, Top=5)
        loc_oBotoesAcao.AddObject("cmd_4c_Confirmar", "CommandButton")
        WITH loc_oBotoesAcao.cmd_4c_Confirmar
            .Caption         = "Confirmar"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
            .PicturePosition = 13
            .Top             = 5
            .Left            = 5
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
            .AutoSize        = .F.
            .Visible         = .T.
        ENDWITH
        BINDEVENT(loc_oBotoesAcao.cmd_4c_Confirmar, "Click", THIS, "BtnSalvarClick")

        *-- cmd_4c_Cancelar (Cancelar: Left=80, Top=5)
        loc_oBotoesAcao.AddObject("cmd_4c_Cancelar", "CommandButton")
        WITH loc_oBotoesAcao.cmd_4c_Cancelar
            .Caption         = "Encerrar"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_cancelar_60.jpg"
            .PicturePosition = 13
            .Top             = 5
            .Left            = 80
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
            .AutoSize        = .F.
            .Visible         = .T.
        ENDWITH
        BINDEVENT(loc_oBotoesAcao.cmd_4c_Cancelar, "Click", THIS, "BtnCancelarClick")

        THIS.TornarControlesVisiveis(loc_oPg2)
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarCampoNivel - Equivalente ao SIGCDTCL.Pagina.Dados.Get_nivel.Valid
    * do legado: nivel fora de [1,2,3] avisa e devolve foco; nivel <> 1 forca
    * "Incluir em Invent?rio" = Sim (Buttons(1)) automaticamente.
    * PUBLIC (sem PROTECTED) - OBRIGATORIO para BINDEVENT funcionar (CLAUDE.md #3)
    *--------------------------------------------------------------------------
    PROCEDURE ValidarCampoNivel()
        LOCAL loc_oPg2, loc_nNivel

        TRY
            loc_oPg2  = THIS.pgf_4c_Paginas.Page2
            loc_nNivel = VAL(TRANSFORM(loc_oPg2.txt_4c_Nivel.Value))

            IF EMPTY(ALLTRIM(TRANSFORM(loc_oPg2.txt_4c_Nivel.Value)))
                *-- campo vazio: nao valida agora (sera pego na validacao final do BO)
            ELSE
                IF !INLIST(loc_nNivel, 1, 2, 3)
                    MsgAviso("N" + CHR(237) + "vel Inv" + CHR(225) + "lido !!")
                    loc_oPg2.txt_4c_Nivel.SetFocus()
                ELSE
                    *-- Get_nivel.Valid: This.Parent.optGreps.Value = Iif(nivel==1, atual, 1)
                    IF loc_nNivel != 1
                        loc_oPg2.opt_4c_OpBalanco.Value = 1
                        loc_oPg2.opt_4c_OpBalanco.Refresh()
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "FormTCL.ValidarCampoNivel")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * AjustarMascaraClasse - Equivalente ao SIGCDTCL.Pagina.Dados.Get_classe.GotFocus
    * do legado: monta InputMask conforme o nivel (1 digito/2 digitos/4 digitos)
    * e limpa o valor se ele nao couber mais na nova mascara.
    * PUBLIC (sem PROTECTED) - OBRIGATORIO para BINDEVENT funcionar (CLAUDE.md #3)
    *--------------------------------------------------------------------------
    PROCEDURE AjustarMascaraClasse()
        LOCAL loc_oPg2, loc_nNivel, loc_nMaxDig

        TRY
            loc_oPg2   = THIS.pgf_4c_Paginas.Page2
            loc_nNivel = VAL(TRANSFORM(loc_oPg2.txt_4c_Nivel.Value))
            loc_nMaxDig = 0

            DO CASE
                CASE loc_nNivel = 1
                    loc_oPg2.txt_4c_Classe.InputMask = "9"
                    loc_nMaxDig = 1
                CASE loc_nNivel = 2
                    loc_oPg2.txt_4c_Classe.InputMask = "99"
                    loc_nMaxDig = 2
                CASE loc_nNivel = 3
                    loc_oPg2.txt_4c_Classe.InputMask = "9999"
                    loc_nMaxDig = 4
            ENDCASE

            *-- So limpa o campo se diminuiu o tamanho de digitos possiveis
            IF loc_nMaxDig > 0 AND LEN(ALLTRIM(loc_oPg2.txt_4c_Classe.Value)) > loc_nMaxDig
                loc_oPg2.txt_4c_Classe.Value = ""
                loc_oPg2.txt_4c_Classe.Refresh()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "FormTCL.AjustarMascaraClasse")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarLista - Carrega dados no grid da Page1 (cursor_4c_Dados)
    * Colunas: classes (100), descrs (319), nivels (83) - conforme AddCursor/
    * pColuna do SIGCDTCL.Init original
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

                    *-- RecordSource ANTES de ControlSource (ColumnCount FORA do WITH)
                    loc_oGrid.ColumnCount  = 3
                    loc_oGrid.RecordSource = "cursor_4c_Dados"

                    *-- ControlSource APOS RecordSource (auto-bind seria sobrescrito)
                    loc_oGrid.Column1.ControlSource = "cursor_4c_Dados.classes"
                    loc_oGrid.Column2.ControlSource = "cursor_4c_Dados.descrs"
                    loc_oGrid.Column3.ControlSource = "cursor_4c_Dados.nivels"

                    loc_oGrid.Column1.Width = 100
                    loc_oGrid.Column2.Width = 319
                    loc_oGrid.Column3.Width = 83

                    *-- Headers APOS RecordSource (OBRIGATORIO - RecordSource reseta captions)
                    loc_oGrid.Column1.Header1.Caption = "Classe"
                    loc_oGrid.Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
                    loc_oGrid.Column3.Header1.Caption = "N" + CHR(237) + "vel"

                    THIS.FormatarGridLista(loc_oGrid)
                    loc_lResultado = .T.
                ENDIF
            ENDIF

        CATCH TO loc_oErro
            MsgErro("Erro ao carregar lista:" + CHR(13) + loc_oErro.Message, "FormTCL.CarregarLista")
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * AlternarPagina - Alterna entre Page1 (Lista=1) e Page2 (Dados=2)
    * Ao voltar para Page1, recarrega a lista
    *--------------------------------------------------------------------------
    PROCEDURE AlternarPagina(par_nPagina)
        LOCAL loc_lResultado
        loc_lResultado = .F.

        TRY
            IF VARTYPE(par_nPagina) != "N" OR par_nPagina < 1 OR par_nPagina > 2
                MsgAviso("P" + CHR(225) + "gina inv" + CHR(225) + "lida: " + TRANSFORM(par_nPagina))
            ELSE
                THIS.pgf_4c_Paginas.ActivePage = par_nPagina

                IF par_nPagina = 1
                    THIS.this_cModoAtual = "LISTA"
                    THIS.CarregarLista()
                ENDIF

                loc_lResultado = .T.
            ENDIF

        CATCH TO loc_oErro
            MsgErro("Erro ao alternar p" + CHR(225) + "gina:" + CHR(13) + loc_oErro.Message, "FormTCL.AlternarPagina")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * FormatarGridLista - Formata visual do grid de lista (FontName/FontSize)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE FormatarGridLista(par_oGrid)
        TRY
            WITH par_oGrid
                .FontName = "Tahoma"
                .FontSize = 8
            ENDWITH
        CATCH TO loc_oErro
            MsgErro("Erro ao formatar grid:" + CHR(13) + loc_oErro.Message, "FormTCL.FormatarGridLista")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * TornarControlesVisiveis - Torna todos os controles visiveis recursivamente
    * REGRA: Chamar SEMPRE com parametro: THIS.TornarControlesVisiveis(loc_oPagina)
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
    * FormParaBO - Transfere valores dos campos da Page2 para o BO
    * (chamado antes de THIS.this_oBusinessObject.Salvar())
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE FormParaBO()
        LOCAL loc_oPg2

        TRY
            loc_oPg2 = THIS.pgf_4c_Paginas.Page2

            THIS.this_oBusinessObject.this_cClasse    = ALLTRIM(TRANSFORM(loc_oPg2.txt_4c_Classe.Value))
            THIS.this_oBusinessObject.this_cDescricao = ALLTRIM(loc_oPg2.txt_4c_Descr.Value)
            THIS.this_oBusinessObject.this_nNivel     = TRANSFORM(loc_oPg2.txt_4c_Nivel.Value)
            THIS.this_oBusinessObject.this_nOpBalanco = loc_oPg2.opt_4c_OpBalanco.Value
            THIS.this_oBusinessObject.this_nInvEmisCc = loc_oPg2.opt_4c_InvEmisCc.Value
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "FormTCL.FormParaBO")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BOParaForm - Transfere valores do BO para os campos da Page2
    * (chamado apos CarregarPorCodigo, em Alterar/Visualizar)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE BOParaForm()
        LOCAL loc_oPg2

        TRY
            loc_oPg2 = THIS.pgf_4c_Paginas.Page2

            loc_oPg2.txt_4c_Classe.Value = ALLTRIM(THIS.this_oBusinessObject.this_cClasse)
            loc_oPg2.txt_4c_Descr.Value  = ALLTRIM(THIS.this_oBusinessObject.this_cDescricao)
            loc_oPg2.txt_4c_Nivel.Value  = THIS.this_oBusinessObject.this_nNivel

            *-- Ajusta InputMask da Classe conforme o nivel carregado
            *-- (mesma logica do GotFocus/AjustarMascaraClasse)
            DO CASE
                CASE THIS.this_oBusinessObject.this_nNivel = 1
                    loc_oPg2.txt_4c_Classe.InputMask = "9"
                CASE THIS.this_oBusinessObject.this_nNivel = 2
                    loc_oPg2.txt_4c_Classe.InputMask = "99"
                CASE THIS.this_oBusinessObject.this_nNivel = 3
                    loc_oPg2.txt_4c_Classe.InputMask = "9999"
                OTHERWISE
                    loc_oPg2.txt_4c_Classe.InputMask = ""
            ENDCASE

            loc_oPg2.opt_4c_OpBalanco.Value = IIF(THIS.this_oBusinessObject.this_nOpBalanco = 0, 1, THIS.this_oBusinessObject.this_nOpBalanco)
            loc_oPg2.opt_4c_InvEmisCc.Value = IIF(THIS.this_oBusinessObject.this_nInvEmisCc = 0, 1, THIS.this_oBusinessObject.this_nInvEmisCc)
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "FormTCL.BOParaForm")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * LimparCampos - Limpa valores dos campos da Page2 (modo INCLUIR)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE LimparCampos()
        LOCAL loc_oPg2

        TRY
            loc_oPg2 = THIS.pgf_4c_Paginas.Page2

            loc_oPg2.txt_4c_Classe.InputMask = ""
            loc_oPg2.txt_4c_Classe.Value     = ""
            loc_oPg2.txt_4c_Descr.Value      = ""
            loc_oPg2.txt_4c_Nivel.Value      = 0
            loc_oPg2.opt_4c_OpBalanco.Value  = 1
            loc_oPg2.opt_4c_InvEmisCc.Value  = 1
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "FormTCL.LimparCampos")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * HabilitarCampos - Habilita/desabilita campos da Page2 conforme modo
    * txt_4c_Classe (PK) so fica editavel em modo INCLUIR (Alterar mantem
    * a chave travada, igual ao legado - classes nao pode ser trocada)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE HabilitarCampos(par_lHabilitar)
        LOCAL loc_oPg2, loc_lHabilitar

        TRY
            loc_oPg2       = THIS.pgf_4c_Paginas.Page2
            loc_lHabilitar = (par_lHabilitar = .T.)

            loc_oPg2.txt_4c_Classe.Enabled     = loc_lHabilitar AND (THIS.this_cModoAtual = "INCLUIR")
            loc_oPg2.txt_4c_Nivel.Enabled      = loc_lHabilitar
            loc_oPg2.txt_4c_Descr.Enabled      = loc_lHabilitar
            loc_oPg2.opt_4c_OpBalanco.Enabled  = loc_lHabilitar
            loc_oPg2.opt_4c_InvEmisCc.Enabled  = loc_lHabilitar

            *-- Confirmar tambem fica habilitado em modo EXCLUIR (padrao CLAUDE.md)
            loc_oPg2.cnt_4c_BotoesAcao.cmd_4c_Confirmar.Enabled = loc_lHabilitar OR (THIS.this_cModoAtual = "EXCLUIR")
            loc_oPg2.cnt_4c_BotoesAcao.cmd_4c_Cancelar.Enabled  = .T.

            THIS.AjustarBotoesPorModo()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "FormTCL.HabilitarCampos")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnIncluirClick - Prepara BO e formulario para inclusao de nova classe
    * PUBLIC (sem PROTECTED) - OBRIGATORIO para BINDEVENT funcionar (CLAUDE.md #3)
    *--------------------------------------------------------------------------
    PROCEDURE BtnIncluirClick()
        TRY
            THIS.this_oBusinessObject.NovoRegistro()
            THIS.this_cModoAtual = "INCLUIR"
            THIS.LimparCampos()
            THIS.HabilitarCampos(.T.)
            THIS.AlternarPagina(2)
            THIS.pgf_4c_Paginas.Page2.txt_4c_Nivel.SetFocus()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "FormTCL.BtnIncluirClick")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnAlterarClick - Carrega classe selecionada na grade e habilita edicao
    * PUBLIC (sem PROTECTED) - OBRIGATORIO para BINDEVENT funcionar (CLAUDE.md #3)
    *--------------------------------------------------------------------------
    PROCEDURE BtnAlterarClick()
        LOCAL loc_cClasse

        TRY
            IF !USED("cursor_4c_Dados") OR RECCOUNT("cursor_4c_Dados") = 0
                MsgAviso("Selecione uma classe para alterar!")
            ELSE
                SELECT cursor_4c_Dados
                IF EOF()
                    MsgAviso("Selecione uma classe para alterar!")
                ELSE
                    loc_cClasse = ALLTRIM(cursor_4c_Dados.classes)

                    IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cClasse)
                        THIS.this_oBusinessObject.EditarRegistro()
                        THIS.this_cModoAtual = "ALTERAR"
                        THIS.BOParaForm()
                        THIS.HabilitarCampos(.T.)
                        THIS.AlternarPagina(2)
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "FormTCL.BtnAlterarClick")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnVisualizarClick - Carrega classe selecionada em modo somente leitura
    * PUBLIC (sem PROTECTED) - OBRIGATORIO para BINDEVENT funcionar (CLAUDE.md #3)
    *--------------------------------------------------------------------------
    PROCEDURE BtnVisualizarClick()
        LOCAL loc_cClasse

        TRY
            IF !USED("cursor_4c_Dados") OR RECCOUNT("cursor_4c_Dados") = 0
                MsgAviso("Selecione uma classe para visualizar!")
            ELSE
                SELECT cursor_4c_Dados
                IF EOF()
                    MsgAviso("Selecione uma classe para visualizar!")
                ELSE
                    loc_cClasse = ALLTRIM(cursor_4c_Dados.classes)

                    IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cClasse)
                        THIS.this_cModoAtual = "VISUALIZAR"
                        THIS.BOParaForm()
                        THIS.HabilitarCampos(.F.)
                        THIS.AlternarPagina(2)
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "FormTCL.BtnVisualizarClick")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnExcluirClick - Confirma e exclui a classe selecionada na grade
    * PUBLIC (sem PROTECTED) - OBRIGATORIO para BINDEVENT funcionar (CLAUDE.md #3)
    *--------------------------------------------------------------------------
    PROCEDURE BtnExcluirClick()
        LOCAL loc_cClasse

        TRY
            IF !USED("cursor_4c_Dados") OR RECCOUNT("cursor_4c_Dados") = 0
                MsgAviso("Selecione uma classe para excluir!")
            ELSE
                SELECT cursor_4c_Dados
                IF EOF()
                    MsgAviso("Selecione uma classe para excluir!")
                ELSE
                    loc_cClasse = ALLTRIM(cursor_4c_Dados.classes)

                    IF MsgConfirma("Confirma a exclus" + CHR(227) + "o da classe " + loc_cClasse + "?")
                        IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cClasse)
                            THIS.this_cModoAtual = "EXCLUIR"

                            IF THIS.this_oBusinessObject.Excluir()
                                MsgInfo("Classe exclu" + CHR(237) + "da com sucesso!")
                                THIS.this_cModoAtual = "LISTA"
                                THIS.CarregarLista()
                            ELSE
                                THIS.this_cModoAtual = "LISTA"
                            ENDIF
                        ENDIF
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "FormTCL.BtnExcluirClick")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnBuscarClick - Filtra a lista pelo codigo/descricao da classe
    * (nao existe fwbuscaext/fwBuscaSel/sigacess no original - comportamento.json
    * confirma temLookup=false em todos os 9 metodos; "Buscar" aqui e o filtro
    * simples da lista, equivalente ao LocateCursor do Procedure do legado)
    * PUBLIC (sem PROTECTED) - OBRIGATORIO para BINDEVENT funcionar (CLAUDE.md #3)
    *--------------------------------------------------------------------------
    PROCEDURE BtnBuscarClick()
        LOCAL loc_cFiltro, loc_cClasse

        TRY
            loc_cClasse = ALLTRIM(INPUTBOX("Digite a classe para filtrar (em branco lista todas):", "Buscar Classe", ""))

            IF EMPTY(loc_cClasse)
                loc_cFiltro = ""
            ELSE
                loc_cFiltro = "classes LIKE " + EscaparSQL(loc_cClasse + "%")
            ENDIF

            IF !THIS.this_oBusinessObject.Buscar(loc_cFiltro)
                MsgErro("Erro ao buscar classes!", "FormTCL.BtnBuscarClick")
            ELSE
                LOCAL loc_oGrid
                loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Lista

                loc_oGrid.ColumnCount  = 3
                loc_oGrid.RecordSource = "cursor_4c_Dados"

                loc_oGrid.Column1.ControlSource = "cursor_4c_Dados.classes"
                loc_oGrid.Column2.ControlSource = "cursor_4c_Dados.descrs"
                loc_oGrid.Column3.ControlSource = "cursor_4c_Dados.nivels"

                loc_oGrid.Column1.Width = 100
                loc_oGrid.Column2.Width = 319
                loc_oGrid.Column3.Width = 83

                loc_oGrid.Column1.Header1.Caption = "Classe"
                loc_oGrid.Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
                loc_oGrid.Column3.Header1.Caption = "N" + CHR(237) + "vel"

                THIS.FormatarGridLista(loc_oGrid)
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "FormTCL.BtnBuscarClick")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnEncerrarClick - Fecha o formulario
    * PUBLIC (sem PROTECTED) - OBRIGATORIO para BINDEVENT funcionar (CLAUDE.md #3)
    *--------------------------------------------------------------------------
    PROCEDURE BtnEncerrarClick()
        TRY
            THIS.Release()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "FormTCL.BtnEncerrarClick")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnSalvarClick - Confirma inclusao/alteracao: valida, transfere Form->BO
    * e persiste (Salvar() decide INSERT/UPDATE por this_lNovoRegistro)
    * PUBLIC (sem PROTECTED) - OBRIGATORIO para BINDEVENT funcionar (CLAUDE.md #3)
    *--------------------------------------------------------------------------
    PROCEDURE BtnSalvarClick()
        TRY
            THIS.FormParaBO()

            IF THIS.this_oBusinessObject.Salvar()
                MsgInfo("Classe salva com sucesso!")
                THIS.this_cModoAtual = "LISTA"
                THIS.AlternarPagina(1)
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "FormTCL.BtnSalvarClick")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnCancelarClick - Cancela edicao/visualizacao e volta para a lista
    * PUBLIC (sem PROTECTED) - OBRIGATORIO para BINDEVENT funcionar (CLAUDE.md #3)
    *--------------------------------------------------------------------------
    PROCEDURE BtnCancelarClick()
        TRY
            THIS.this_cModoAtual = "LISTA"
            THIS.AlternarPagina(1)
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "FormTCL.BtnCancelarClick")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * AjustarBotoesPorModo - Ajusta Confirmar/Cancelar conforme this_cModoAtual
    * (INCLUIR/ALTERAR: Confirmar habilitado; VISUALIZAR: Confirmar desabilitado;
    * EXCLUIR: Confirmar habilitado - padrao CLAUDE.md, ver HabilitarCampos)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE AjustarBotoesPorModo()
        LOCAL loc_oBotoesAcao

        TRY
            loc_oBotoesAcao = THIS.pgf_4c_Paginas.Page2.cnt_4c_BotoesAcao

            DO CASE
                CASE INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
                    loc_oBotoesAcao.cmd_4c_Confirmar.Enabled = .T.
                    loc_oBotoesAcao.cmd_4c_Cancelar.Enabled  = .T.
                CASE THIS.this_cModoAtual = "VISUALIZAR"
                    loc_oBotoesAcao.cmd_4c_Confirmar.Enabled = .F.
                    loc_oBotoesAcao.cmd_4c_Cancelar.Enabled  = .T.
                CASE THIS.this_cModoAtual = "EXCLUIR"
                    loc_oBotoesAcao.cmd_4c_Confirmar.Enabled = .T.
                    loc_oBotoesAcao.cmd_4c_Cancelar.Enabled  = .T.
                OTHERWISE
                    loc_oBotoesAcao.cmd_4c_Confirmar.Enabled = .T.
                    loc_oBotoesAcao.cmd_4c_Cancelar.Enabled  = .T.
            ENDCASE
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "FormTCL.AjustarBotoesPorModo")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * Destroy - Libera recursos do formulario
    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
        TRY
            IF VARTYPE(THIS.this_oBusinessObject) = "O"
                THIS.this_oBusinessObject = .NULL.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "FormTCL.Destroy")
        ENDTRY

        DODEFAULT()
    ENDPROC

ENDDEFINE


### BO (C:\4c\projeto\app\classes\TCLBO.prg):
*====================================================================
* TCLBO.prg
*
* Business Object para Cadastro de Classes (SIGCDTCL)
* Tabela: SigCdCss
* Herda de: BusinessBase
*
* NOTA: o codigo fonte original (SIGCDTCL_form_codigo_fonte.txt) usa
* ThisForm.poDataMgr.AddCursor('SigCdCss','classes','crSigCdCss', ...)
* como cursor principal do form. O cursor 'crSigCdGcr' (SigCdGcr) e
* criado no Init original apenas como cursor auxiliar (nao possui
* nenhum controle vinculado no layout) e por isso NAO faz parte das
* propriedades desta entidade.
*====================================================================

DEFINE CLASS TCLBO AS BusinessBase

    *-- Propriedades da entidade (mapeamento para tabela SigCdCss)
    this_cClasse    = ""    && classes    char(10) - PK
    this_cDescricao = ""    && descrs     char(30)
    this_cFf        = ""    && ff         char(10) - NOT NULL, sem controle no form original (grava SPACE(10))
    this_nNivel     = 0     && nivels     numeric(1,0) - dominio [1,2,3]
    this_nOpBalanco = 0     && opbalancos numeric(1,0) - OptionGroup optGreps  (1=Sim / 2=Nao) "Incluir em Inventario"
    this_nInvEmisCc = 0     && invemisccs numeric(1,0) - OptionGroup Fwoption1 (1=Sim / 2=Nao) "Trocar CC por Emissor"

    *====================================================================
    * Init - Inicializa Business Object
    *====================================================================
    PROCEDURE Init()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            DODEFAULT()
            THIS.this_cTabela     = "SigCdCss"
            THIS.this_cCampoChave = "classes"
            loc_lSucesso = .T.
        CATCH TO loException
            MostrarErro(loException, "TCLBO.Init")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * InicializarValoresPadrao - Valores default para novo registro
    * ff nao tem controle no form original: legado grava SPACE(10)
    *====================================================================
    PROTECTED PROCEDURE InicializarValoresPadrao()
        THIS.this_cFf = SPACE(10)
    ENDPROC

    *====================================================================
    * ObterChavePrimaria - Retorna chave primaria para auditoria
    *====================================================================
    FUNCTION ObterChavePrimaria()
        RETURN ALLTRIM(THIS.this_cClasse)
    ENDFUNC

    *====================================================================
    * CarregarDoCursor - Carrega propriedades do BO a partir de cursor
    * REGRA CRITICA: SELECT (par_cAliasCursor) ANTES de acessar campos
    *====================================================================
    PROTECTED PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF USED(par_cAliasCursor)
                SELECT (par_cAliasCursor)
                THIS.this_cClasse    = TratarNulo(classes,    "C")
                THIS.this_cDescricao = TratarNulo(descrs,     "C")
                THIS.this_cFf        = TratarNulo(ff,         "C")
                THIS.this_nNivel     = TratarNulo(nivels,     "N")
                THIS.this_nOpBalanco = TratarNulo(opbalancos, "N")
                THIS.this_nInvEmisCc = TratarNulo(invemisccs, "N")
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loException
            MostrarErro("Erro ao carregar do cursor:" + CHR(13) + loException.Message, "TCLBO.CarregarDoCursor")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * ValidarDados - Valida dados antes de salvar
    * Regras extraidas do legado (SIGCDTCL.Pagina.Dados.Get_nivel.Valid
    * e SIGCDTCL.Click do Confirmar - ver comportamento.json)
    *====================================================================
    PROTECTED PROCEDURE ValidarDados()
        LOCAL loc_lValido, loc_nTamanhoEsperado, loc_cClasseSemEspacos
        loc_lValido = .T.

        *-- Get_nivel.Valid: nivel fora do dominio [1,2,3]
        IF !INLIST(THIS.this_nNivel, 1, 2, 3)
            MsgAviso("N" + CHR(237) + "vel Inv" + CHR(225) + "lido !!")
            loc_lValido = .F.
        ENDIF

        *-- Get_nivel.Valid: se nivel <> 1, forca "Incluir em Invent" + CHR(225) + "rio" = Sim (1)
        IF loc_lValido AND THIS.this_nNivel != 1
            THIS.this_nOpBalanco = 1
        ENDIF

        IF loc_lValido
            *-- Click Confirmar: tamanho da classe depende do nivel
            *-- nivel 1 -> substr('124',1,1)='1' (1 digito) | nivel 2 -> '2' (2 digitos) | nivel 3 -> '4' (4 digitos)
            loc_cClasseSemEspacos = STRTRAN(ALLTRIM(THIS.this_cClasse), " ", "")
            loc_nTamanhoEsperado  = VAL(SUBSTR("124", THIS.this_nNivel, 1))
            IF LEN(loc_cClasseSemEspacos) != loc_nTamanhoEsperado
                MsgAviso("Classe Inv" + CHR(225) + "lida !!")
                loc_lValido = .F.
            ENDIF
        ENDIF

        IF loc_lValido AND EMPTY(THIS.this_cDescricao)
            MsgAviso("Descri" + CHR(231) + CHR(227) + "o n" + CHR(227) + "o pode ficar em branco!")
            loc_lValido = .F.
        ENDIF

        IF loc_lValido AND THIS.this_lNovoRegistro
            IF THIS.VerificarClasseExistente(THIS.this_cClasse)
                MsgAviso("Classe j" + CHR(225) + " Cadastrada!")
                loc_lValido = .F.
            ENDIF
        ENDIF

        RETURN loc_lValido
    ENDPROC

    *====================================================================
    * VerificarClasseExistente - Verifica se classes ja existe no banco
    * Equivalente ao ChkRegister('SigCdCss','classes',...) do legado
    *====================================================================
    PROCEDURE VerificarClasseExistente(par_cClasse)
        LOCAL loc_cSQL, loc_nResultado, loc_lExiste
        loc_lExiste = .F.

        TRY
            loc_cSQL = "SELECT COUNT(*) AS qtd FROM SigCdCss" + ;
                " WHERE classes = " + EscaparSQL(par_cClasse)
            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ChkCla")
            IF loc_nResultado >= 0 AND USED("cursor_4c_ChkCla")
                SELECT cursor_4c_ChkCla
                loc_lExiste = (cursor_4c_ChkCla.qtd > 0)
                USE IN cursor_4c_ChkCla
            ENDIF
        CATCH TO loException
            MostrarErro("Erro ao verificar classe:" + CHR(13) + loException.Message, "TCLBO.VerificarClasseExistente")
        ENDTRY

        RETURN loc_lExiste
    ENDPROC

    *====================================================================
    * Inserir - Insere novo registro na tabela SigCdCss
    *====================================================================
    PROTECTED PROCEDURE Inserir()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            TEXT TO loc_cSQL TEXTMERGE NOSHOW
                INSERT INTO SigCdCss (classes, descrs, ff, nivels, opbalancos, invemisccs)
                VALUES (
                    <<EscaparSQL(THIS.this_cClasse)>>,
                    <<EscaparSQL(THIS.this_cDescricao)>>,
                    <<EscaparSQL(THIS.this_cFf)>>,
                    <<FormatarNumeroSQL(THIS.this_nNivel, 0)>>,
                    <<FormatarNumeroSQL(THIS.this_nOpBalanco, 0)>>,
                    <<FormatarNumeroSQL(THIS.this_nInvEmisCc, 0)>>
                )
            ENDTEXT

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("INSERT")
                loc_lSucesso = .T.
            ELSE
                MostrarErro("Erro ao inserir classe:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao inserir:" + CHR(13) + loException.Message, "TCLBO.Inserir")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * Atualizar - Atualiza registro existente na tabela SigCdCss
    * classes eh chave primaria - nao entra no SET
    *====================================================================
    PROTECTED PROCEDURE Atualizar()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            TEXT TO loc_cSQL TEXTMERGE NOSHOW
                UPDATE SigCdCss
                SET descrs     = <<EscaparSQL(THIS.this_cDescricao)>>,
                    ff         = <<EscaparSQL(THIS.this_cFf)>>,
                    nivels     = <<FormatarNumeroSQL(THIS.this_nNivel, 0)>>,
                    opbalancos = <<FormatarNumeroSQL(THIS.this_nOpBalanco, 0)>>,
                    invemisccs = <<FormatarNumeroSQL(THIS.this_nInvEmisCc, 0)>>
                WHERE classes = <<EscaparSQL(THIS.this_cClasse)>>
            ENDTEXT

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("UPDATE")
                loc_lSucesso = .T.
            ELSE
                MostrarErro("Erro ao atualizar classe:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao atualizar:" + CHR(13) + loException.Message, "TCLBO.Atualizar")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * ExecutarExclusao - Exclui registro da tabela SigCdCss
    * Sem verificacao de dependencia no legado (framework generico)
    *====================================================================
    PROTECTED PROCEDURE ExecutarExclusao()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "DELETE FROM SigCdCss WHERE classes = " + EscaparSQL(THIS.this_cClasse)
            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("DELETE")
                loc_lSucesso = .T.
            ELSE
                MostrarErro("Erro ao excluir classe:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao excluir:" + CHR(13) + loException.Message, "TCLBO.ExecutarExclusao")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * Buscar - Busca registros com filtro opcional
    * Retorna cursor_4c_Dados com classes, descrs, nivels (colunas da
    * grade original: pColuna('classes'...), pColuna('descrs'...),
    * pColuna('nivels'...))
    *====================================================================
    PROCEDURE Buscar(par_cFiltro)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
                IF !USED("cursor_4c_Dados")
                    SET NULL ON
                    CREATE CURSOR cursor_4c_Dados (classes C(10), descrs C(30), nivels N(1,0))
                    SET NULL OFF
                ENDIF
                loc_lSucesso = .T.
            ELSE
                loc_cSQL = "SELECT classes, descrs, nivels FROM SigCdCss"

                IF VARTYPE(par_cFiltro) = "C" AND !EMPTY(par_cFiltro)
                    loc_cSQL = loc_cSQL + " WHERE " + par_cFiltro
                ENDIF

                loc_cSQL = loc_cSQL + " ORDER BY classes"

                IF USED("cursor_4c_Dados")
                    USE IN cursor_4c_Dados
                ENDIF
                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")
                IF loc_nResultado >= 0
                    loc_lSucesso = .T.
                ELSE
                    MostrarErro("Erro ao buscar classes:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                ENDIF
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao buscar:" + CHR(13) + loException.Message, "TCLBO.Buscar")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * CarregarPorCodigo - Carrega registro pela chave primaria (classes)
    *====================================================================
    PROCEDURE CarregarPorCodigo(par_cClasse)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "SELECT classes, descrs, ff, nivels, opbalancos, invemisccs" + ;
                " FROM SigCdCss WHERE classes = " + EscaparSQL(par_cClasse)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")

            IF loc_nResultado >= 0
                IF RECCOUNT("cursor_4c_Carrega") > 0
                    loc_lSucesso = THIS.CarregarDoCursor("cursor_4c_Carrega")
                    THIS.this_lNovoRegistro = .F.
                ELSE
                    MsgAviso("Classe n" + CHR(227) + "o encontrada!")
                ENDIF

                IF USED("cursor_4c_Carrega")
                    USE IN cursor_4c_Carrega
                ENDIF
            ELSE
                MostrarErro("Erro ao carregar classe:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao carregar:" + CHR(13) + loException.Message, "TCLBO.CarregarPorCodigo")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

ENDDEFINE


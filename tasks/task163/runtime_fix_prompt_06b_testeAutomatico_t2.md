# CORRIGIR ERRO DE RUNTIME VFP9

## TAREFA OBRIGATORIA
O formulario VFP9 apresentou erro de runtime durante teste automatizado.
Voce DEVE corrigir o erro e salvar os arquivos corrigidos usando Write tool.

## ERRO DETECTADO
- Etapa: 06b_testeAutomatico
- Tentativa: 2/10
- Mensagem: Testes automaticos: 89% < 100%. Falhas: Teste 'CarregarDadosReais': Property CARREGARDADOS is not found. | Detalhes: Linha: 799, Proc: testecarregardadosreais

## CONTEXTO DO ERRO

### LOG DA ETAPA (06b_testeAutomatico):
[2026-07-02 07:42:24] [INFO] === VFP EXECUTOR v2.0 ===
[2026-07-02 07:42:24] [INFO] Config FPW: (nao fornecido)
[2026-07-02 07:42:24] [INFO] Script PRG: C:\4c\projeto\app\utils\TesteAutomatico.prg
[2026-07-02 07:42:24] [INFO] Timeout: 300 segundos
[2026-07-02 07:42:24] [INFO] Wrapper PRG criado para parametros: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_x5h5zbeq.prg
[2026-07-02 07:42:24] [INFO] Conteudo do wrapper:
[2026-07-02 07:42:24] [INFO] * Auto-generated wrapper for parameters
* Script: C:\4c\projeto\app\utils\TesteAutomatico.prg
* Parameters: 'FormSIGPRCIC', 'C:\4c\tasks\task163', 'OPERACIONAL'

* Anti-dialog protections for unattended execution
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
SET NOTIFY OFF
SYS(2335, 0)

DO "C:\4c\projeto\app\utils\TesteAutomatico" WITH 'FormSIGPRCIC', 'C:\4c\tasks\task163', 'OPERACIONAL'
QUIT

[2026-07-02 07:42:24] [INFO] Comando VFP: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_x5h5zbeq.prg
[2026-07-02 07:42:24] [INFO] VFP output esperado em: C:\4c\tasks\task163\vfp_output.txt
[2026-07-02 07:42:24] [INFO] Executando Visual FoxPro 9...
[2026-07-02 07:42:24] [INFO] Comando completo: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_x5h5zbeq.prg
[2026-07-02 07:42:24] [INFO] Executando: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_x5h5zbeq.prg
[2026-07-02 07:42:24] [INFO] Timeout configurado: 300 segundos
[2026-07-02 07:42:40] [INFO] VFP9 finalizou normalmente com exit code: 
[2026-07-02 07:42:40] [INFO] VFP9 finalizado em 15.4410975 segundos
[2026-07-02 07:42:40] [INFO] Exit Code: 
[2026-07-02 07:42:40] [INFO] 
[2026-07-02 07:42:40] [INFO] Arquivos temporarios preservados para inspecao:
[2026-07-02 07:42:40] [INFO]   Wrapper.prg: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_x5h5zbeq.prg
[2026-07-02 07:42:40] [INFO] 
[2026-07-02 07:42:40] [INFO] === Conteudo do Wrapper.prg temporario ===
[2026-07-02 07:42:40] [INFO] * Auto-generated wrapper for parameters
[2026-07-02 07:42:40] [INFO] * Script: C:\4c\projeto\app\utils\TesteAutomatico.prg
[2026-07-02 07:42:40] [INFO] * Parameters: 'FormSIGPRCIC', 'C:\4c\tasks\task163', 'OPERACIONAL'
[2026-07-02 07:42:40] [INFO] 
[2026-07-02 07:42:40] [INFO] * Anti-dialog protections for unattended execution
[2026-07-02 07:42:40] [INFO] SET SAFETY OFF
[2026-07-02 07:42:40] [INFO] SET RESOURCE OFF
[2026-07-02 07:42:40] [INFO] SET TALK OFF
[2026-07-02 07:42:40] [INFO] SET NOTIFY OFF
[2026-07-02 07:42:40] [INFO] SYS(2335, 0)
[2026-07-02 07:42:40] [INFO] 
[2026-07-02 07:42:40] [INFO] DO "C:\4c\projeto\app\utils\TesteAutomatico" WITH 'FormSIGPRCIC', 'C:\4c\tasks\task163', 'OPERACIONAL'
[2026-07-02 07:42:40] [INFO] QUIT
[2026-07-02 07:42:40] [INFO] 
[2026-07-02 07:42:40] [INFO] === Fim do Wrapper.prg ===
[2026-07-02 07:42:40] [WARN] AVISO: VFP9 retornou exit code  (normal para VFP9 GUI - validar pelo arquivo de saida)
[2026-07-02 07:43:34] [INFO] === VFP EXECUTOR v2.0 ===
[2026-07-02 07:43:34] [INFO] Config FPW: (nao fornecido)
[2026-07-02 07:43:34] [INFO] Script PRG: C:\4c\projeto\app\utils\TesteAutomatico.prg
[2026-07-02 07:43:34] [INFO] Timeout: 300 segundos
[2026-07-02 07:43:34] [INFO] Wrapper PRG criado para parametros: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_v3qzdsnj.prg
[2026-07-02 07:43:34] [INFO] Conteudo do wrapper:
[2026-07-02 07:43:34] [INFO] * Auto-generated wrapper for parameters
* Script: C:\4c\projeto\app\utils\TesteAutomatico.prg
* Parameters: 'FormSIGPRCIC', 'C:\4c\tasks\task163', 'OPERACIONAL'

* Anti-dialog protections for unattended execution
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
SET NOTIFY OFF
SYS(2335, 0)

DO "C:\4c\projeto\app\utils\TesteAutomatico" WITH 'FormSIGPRCIC', 'C:\4c\tasks\task163', 'OPERACIONAL'
QUIT

[2026-07-02 07:43:34] [INFO] Comando VFP: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_v3qzdsnj.prg
[2026-07-02 07:43:34] [INFO] VFP output esperado em: C:\4c\tasks\task163\vfp_output.txt
[2026-07-02 07:43:34] [INFO] Executando Visual FoxPro 9...
[2026-07-02 07:43:34] [INFO] Comando completo: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_v3qzdsnj.prg
[2026-07-02 07:43:34] [INFO] Executando: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_v3qzdsnj.prg
[2026-07-02 07:43:34] [INFO] Timeout configurado: 300 segundos
[2026-07-02 07:43:52] [INFO] VFP9 finalizou normalmente com exit code: 
[2026-07-02 07:43:52] [INFO] VFP9 finalizado em 18.2380864 segundos
[2026-07-02 07:43:52] [INFO] Exit Code: 
[2026-07-02 07:43:52] [INFO] 
[2026-07-02 07:43:52] [INFO] Arquivos temporarios preservados para inspecao:
[2026-07-02 07:43:52] [INFO]   Wrapper.prg: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_v3qzdsnj.prg
[2026-07-02 07:43:52] [INFO] 
[2026-07-02 07:43:52] [INFO] === Conteudo do Wrapper.prg temporario ===
[2026-07-02 07:43:52] [INFO] * Auto-generated wrapper for parameters
[2026-07-02 07:43:52] [INFO] * Script: C:\4c\projeto\app\utils\TesteAutomatico.prg
[2026-07-02 07:43:52] [INFO] * Parameters: 'FormSIGPRCIC', 'C:\4c\tasks\task163', 'OPERACIONAL'
[2026-07-02 07:43:52] [INFO] 
[2026-07-02 07:43:52] [INFO] * Anti-dialog protections for unattended execution
[2026-07-02 07:43:52] [INFO] SET SAFETY OFF
[2026-07-02 07:43:52] [INFO] SET RESOURCE OFF
[2026-07-02 07:43:52] [INFO] SET TALK OFF
[2026-07-02 07:43:52] [INFO] SET NOTIFY OFF
[2026-07-02 07:43:52] [INFO] SYS(2335, 0)
[2026-07-02 07:43:52] [INFO] 
[2026-07-02 07:43:52] [INFO] DO "C:\4c\projeto\app\utils\TesteAutomatico" WITH 'FormSIGPRCIC', 'C:\4c\tasks\task163', 'OPERACIONAL'
[2026-07-02 07:43:52] [INFO] QUIT
[2026-07-02 07:43:52] [INFO] 
[2026-07-02 07:43:52] [INFO] === Fim do Wrapper.prg ===
[2026-07-02 07:43:52] [WARN] AVISO: VFP9 retornou exit code  (normal para VFP9 GUI - validar pelo arquivo de saida)


### RESULTADO DOS TESTES (teste_resultado.json):
{
  "formClass": "FormSIGPRCIC",
  "timestamp": "20260702074352",
  "testes": [
    {
      "nome": "Instanciacao",
      "passou": true,
      "erro": "",
      "detalhes": "Objeto criado com sucesso"
    },
    {
      "nome": "ContainersFlutuantes",
      "passou": true,
      "erro": "",
      "detalhes": "Nenhum container flutuante encontrado (OK)"
    },
    {
      "nome": "CarregarDadosReais",
      "passou": false,
      "erro": "Property CARREGARDADOS is not found.",
      "detalhes": "Linha: 799, Proc: testecarregardadosreais"
    },
    {
      "nome": "NavegacaoPaginas",
      "passou": true,
      "erro": "",
      "detalhes": "2/2 paginas navegadas com sucesso"
    },
    {
      "nome": "BtnIncluirNavegacao",
      "passou": true,
      "erro": "",
      "detalhes": "Form OPERACIONAL com BtnIncluirClick e PageFrame - navegacao Page2 nao aplicavel"
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
      "detalhes": "AbrirLookup: 0 | KeyPress handlers: 2 (GRDDADOSTEXT1KEYPRESS, KEYPRESS)"
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

### FORM (C:\4c\projeto\app\forms\operacionais\FormSIGPRCIC.prg):
*==============================================================================
* FormSIGPRCIC.prg - Dialog de Escolha de Icones para Programas
* Data: 2026-07-02
* Funcao: Dialog modal para selecionar icone de item de menu/programa
*
* Filosofia 3 Pilares:
*   UX     -> layout do SCX legado preservado (grid de icones + preview + campo Programa)
*   BANCO  -> opera sobre cursores crProg1/crProg2/crSigSyIco1 do form pai (sem SQL proprio)
*   CODE   -> arquitetura em camadas (FormBase / SIGPRCICBO), sufixo _4c_
*
* Obs: Compartilha datasession do form pai (DataSession=1); nao usa SQLEXEC direto.
*==============================================================================

DEFINE CLASS FormSIGPRCIC AS FormBase

    *-- Dimensoes e propriedades visuais (copiadas do SCX original)
    Width           = 469
    Height          = 496
    AutoCenter      = .T.
    TitleBar        = 0
    ShowWindow = 1
    ControlBox      = .F.
    Closable        = .F.
    MaxButton       = .F.
    MinButton       = .F.
    ClipControls    = .F.
    BorderStyle     = 2
    WindowType      = 1
    DataSession     = 1     && Compartilha datasession do form pai (acessa crProg1/crProg2/crSigSyIco1)

    *-- Business Object
    this_oBusinessObject    = .NULL.

    *-- Chave do programa recebida como parametro (pkChaves de crProg1/crProg2)
    this_cIdChaves          = ""

    *-- Referencia ao form pai (para compartilhar datasession)
    this_oFormPai           = .NULL.

    *--------------------------------------------------------------------------
    * Init - Recebe form pai e chave do programa; delega inicializacao a FormBase
    *--------------------------------------------------------------------------
    PROCEDURE Init(par_oFormPai, par_cIdChaves)
        *-- Armazena parametros ANTES do DODEFAULT para que InicializarForm os encontre
        IF TYPE("par_oFormPai") = "O"
            THIS.this_oFormPai = par_oFormPai
        ELSE
            THIS.this_oFormPai = THIS
        ENDIF

        IF TYPE("par_cIdChaves") = "C"
            THIS.this_cIdChaves = par_cIdChaves
        ELSE
            THIS.this_cIdChaves = ""
        ENDIF

        RETURN DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    * InicializarForm - Chamado por FormBase.Init via DODEFAULT
    * Cria BO, constroi PageFrame + containers principais e prepara dados iniciais
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        TRY
            *-- Herdar datasession do form pai para acessar crProg1/crProg2/crSigSyIco1
            *-- Equivalente ao .DataSessionId = .poForm1.DataSessionId do legado
            IF VARTYPE(THIS.this_oFormPai) = "O" AND THIS.this_oFormPai != THIS
                THIS.DataSessionId = THIS.this_oFormPai.DataSessionId
            ENDIF

            *-- Caption com acento via CHR (regra: sem literais acentuados em PRG)
            THIS.Caption = "Escolha de " + CHR(237) + "cones"

            *-- Imagem de fundo do form (copiada do SCX legado)
            THIS.Picture = gc_4c_CaminhoIcones + "new_background.jpg"

            *-- Cria Business Object
            THIS.this_oBusinessObject = CREATEOBJECT("SIGPRCICBO")

            IF VARTYPE(THIS.this_oBusinessObject) # "O"
                MsgErro("Erro ao criar SIGPRCICBO", "Erro")
                loc_lSucesso = .F.
            ENDIF

            *-- Construcao do form
            THIS.LockScreen = .T.
            THIS.ConfigurarCabecalho()
            THIS.ConfigurarPageFrame()
            THIS.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
            THIS.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
            THIS.TornarControlesVisiveis(THIS)
            THIS.LockScreen = .F.

            IF !(TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI)
                THIS.CarregarDados()
            ENDIF

            loc_lSucesso = .T.

        CATCH TO loc_oErro
            THIS.LockScreen = .F.
            MsgErro(loc_oErro.Message, "Erro InicializarForm")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarCabecalho - Cria cnt_4c_Cabecalho (cntSombra do legado)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarCabecalho()
        LOCAL loc_oCab

        THIS.AddObject("cnt_4c_Cabecalho", "Container")
        loc_oCab = THIS.cnt_4c_Cabecalho
        WITH loc_oCab
            .Top         = 0
            .Left        = 0
            .Width       = THIS.Width
            .Height      = 80
            .BackStyle   = 1
            .BackColor   = RGB(100, 100, 100)
            .BorderWidth = 0

            .AddObject("lbl_4c_Sombra", "Label")
            WITH .lbl_4c_Sombra
                .AutoSize      = .F.
                .Top           = 18
                .Left          = 10
                .Width         = loc_oCab.Width
                .Height        = 40
                .FontBold      = .T.
                .FontName      = "Tahoma"
                .FontSize      = 18
                .FontUnderline = .F.
                .WordWrap      = .T.
                .Alignment     = 0
                .BackStyle     = 0
                .Caption       = "Escolha de " + CHR(237) + "cones"
                .ForeColor     = RGB(0, 0, 0)
            ENDWITH

            .AddObject("lbl_4c_Titulo", "Label")
            WITH .lbl_4c_Titulo
                .AutoSize  = .F.
                .Top       = 17
                .Left      = 10
                .Width     = loc_oCab.Width
                .Height    = 46
                .FontBold  = .T.
                .FontName  = "Tahoma"
                .FontSize  = 18
                .WordWrap  = .T.
                .Alignment = 0
                .BackStyle = 0
                .Caption   = "Escolha de " + CHR(237) + "cones"
                .ForeColor = RGB(255, 255, 255)
            ENDWITH
        ENDWITH

        *-- Torna cabecalho visivel explicitamente (TornarControlesVisiveis o filtra via INLIST)
        loc_oCab.Visible = .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPageFrame - Constroi pgf_4c_Paginas com Page1 e Page2,
    * delegando a construcao dos controles a ConfigurarPaginaLista().
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPageFrame()
        LOCAL loc_oPgf

        *-- Cria PageFrame que ocupa area abaixo do cabecalho
        THIS.AddObject("pgf_4c_Paginas", "PageFrame")
        loc_oPgf = THIS.pgf_4c_Paginas
        loc_oPgf.PageCount = 2
        loc_oPgf.Top       = 80
        loc_oPgf.Left      = 0
        loc_oPgf.Width     = THIS.Width
        loc_oPgf.Height    = THIS.Height - 80
        loc_oPgf.TabIndex  = 1
        loc_oPgf.Tabs      = .F.

        loc_oPgf.Page1.Caption = "Lista"
        loc_oPgf.Page2.Caption = "Dados"

        *-- Constroi controles da Page1 (grid de icones + preview + campo Programa)
        THIS.ConfigurarPaginaLista()

        *-- Page2: dialog plano, sem campos adicionais no original
        THIS.ConfigurarPaginaDados()

        *-- Ativa Page1 por default (visao principal do dialog)
        loc_oPgf.Visible    = .T.
        loc_oPgf.ActivePage = 1
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPaginaLista - Constroi todos os controles de Page1:
    *   - lbl_4c_Programa + txt_4c_Programa (campo programa, somente leitura)
    *   - shp_4c_Preview (borda decorativa ao redor do preview)
    *   - img_4c_Icone (imagem preview do icone selecionado)
    *   - grd_4c_Dados (lista de icones - mapeado de Grid1 do legado)
    *   - BINDEVENTs para navegacao no grid e selecao de icone
    *
    * Posicoes: PageFrame.Top=80; controles em coords relativas a Page1
    * (Top_original - 80). RecordSource definido em CarregarDados().
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPaginaLista()
        LOCAL loc_oPagina, loc_oGrid

        loc_oPagina = THIS.pgf_4c_Paginas.Page1

        *-- Label "Programa" (Say2 do legado: Top=86 -> 86-80=6)
        loc_oPagina.AddObject("lbl_4c_Programa", "Label")
        WITH loc_oPagina.lbl_4c_Programa
            .Caption   = "Programa"
            .Left      = 12
            .Top       = 6
            .AutoSize  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
        ENDWITH

        *-- TextBox nome do programa - somente leitura (Text1 do legado: Top=103 -> 23)
        loc_oPagina.AddObject("txt_4c_Programa", "TextBox")
        WITH loc_oPagina.txt_4c_Programa
            .FontBold  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Height    = 24
            .Left      = 9
            .Top       = 23
            .Width     = 457
            .ForeColor = RGB(90, 90, 90)
            .ReadOnly  = .T.
            .Value     = ""
        ENDWITH

        *-- Shape - borda decorativa ao redor do preview (Shape1 do legado: Top=184 -> 104)
        loc_oPagina.AddObject("shp_4c_Preview", "Shape")
        WITH loc_oPagina.shp_4c_Preview
            .Top         = 104
            .Left        = 276
            .Height      = 169
            .Width       = 169
            .BackStyle   = 0
            .BorderStyle = 0
            .BorderColor = RGB(136, 189, 188)
        ENDWITH

        *-- Image - preview do icone selecionado (Icone do legado: Top=200 -> 120)
        loc_oPagina.AddObject("img_4c_Icone", "Image")
        WITH loc_oPagina.img_4c_Icone
            .Stretch = 1
            .Height  = 156
            .Left    = 282
            .Top     = 120
            .Width   = 156
        ENDWITH

        *-- Grid de icones (Grid1 do legado: Top=131 -> 51)
        loc_oPagina.AddObject("grd_4c_Dados", "Grid")
        loc_oGrid = loc_oPagina.grd_4c_Dados
        WITH loc_oGrid
            .ColumnCount       = 1
            .AllowHeaderSizing = .F.
            .AllowRowSizing    = .F.
            .DeleteMark        = .F.
            .RecordMark        = .F.
            .Height            = 345
            .Left              = 10
            .Top               = 51
            .Width             = 242
            .GridLineColor     = RGB(238, 238, 238)
            .ReadOnly          = .T.
            .ScrollBars        = 2
            .HeaderHeight      = 15
            .RowHeight         = 15

            *-- Formatacao via SetAll (espelhando Init() do legado)
            .FontName = "Courier New"
            .SetAll("FontName",    "Arial",        "Header")
            .SetAll("FontName",    "Courier New", "TextBox")
            .FontSize = 9
            .SetAll("FontSize",    8,              "Header")
            .SetAll("FontSize",    9,              "TextBox")
            .SetAll("Format",      "K",            "Column")
            .SetAll("Format",      "K",            "TextBox")
            .SetAll("Movable",     .F.,            "Column")
            .SetAll("ReadOnly",    .T.,            "Column")
            .SetAll("ReadOnly",    .T.,            "TextBox")
            .SetAll("Resizable",   .F.,            "Column")
            .SetAll("Alignment",   3,              "Column")
            .SetAll("Alignment",   3,              "TextBox")
            .SetAll("Alignment",   2,              "Header")
            .SetAll("BorderStyle", 0,              "TextBox")
            .SetAll("Margin",      0,              "TextBox")
            .SetAll("Visible",     .T.,            "TextBox")

            *-- Propriedades da coluna
            .Column1.Width    = 211
            .Column1.Movable  = .F.
            .Column1.ReadOnly = .T.
            .Column1.FontName = "Courier New"

            *-- Header (CHR(205) = I-agudo maiusculo)
            .Column1.Header1.Caption   = CHR(205) + "cones"
            .Column1.Header1.FontName  = "Tahoma"
            .Column1.Header1.FontSize  = 8
            .Column1.Header1.Alignment = 2
            .Column1.Header1.ForeColor = RGB(90, 90, 90)

            *-- TextBox dentro da coluna
            .Column1.Text1.FontName    = "Courier New"
            .Column1.Text1.BorderStyle = 0
            .Column1.Text1.Margin      = 0
            .Column1.Text1.ReadOnly    = .T.
            .Column1.Text1.ForeColor   = RGB(0, 0, 0)
            .Column1.Text1.BackColor   = RGB(255, 255, 255)
        ENDWITH

        *-- BINDEVENTs para navegacao no grid e selecao de icone
        BINDEVENT(loc_oGrid, "AfterRowColChange",  THIS, "GrdDadosAfterRowColChange")
        BINDEVENT(loc_oGrid, "BeforeRowColChange", THIS, "GrdDadosBeforeRowColChange")
        BINDEVENT(loc_oGrid, "Scrolled",           THIS, "GrdDadosScrolled")
        BINDEVENT(loc_oGrid.Column1.Text1, "DblClick",  THIS, "GrdDadosText1DblClick")
        BINDEVENT(loc_oGrid.Column1.Text1, "KeyPress",  THIS, "GrdDadosText1KeyPress")
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPaginaDados - Page2 nao possui controles no form original
    * SIGPRCIC e um dialog flat: todos os campos estao em Page1
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPaginaDados()
        THIS.pgf_4c_Paginas.Page2.BackColor = RGB(240, 240, 240)
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDados - Le o icone atual do programa via BO e posiciona o cursor
    * de icones no arquivo correspondente.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE CarregarDados()
        LOCAL loc_lSucesso, loc_cArqIcone, loc_cArquivo, loc_oPagina, loc_oErro
        loc_lSucesso = .F.

        TRY
            loc_oPagina   = THIS.pgf_4c_Paginas.Page1
            loc_cArqIcone = THIS.this_oBusinessObject.BuscarIconeAtual(THIS.this_cIdChaves)

            *-- Popula campo Programa com descricao lida pelo BO (crProg2.descricaos)
            loc_oPagina.txt_4c_Programa.Value = THIS.this_oBusinessObject.this_cDescricao

            *-- Posiciona cursor de icones (aberto pelo form pai) no icone atual
            IF USED("crSigSyIco1")
                SET ORDER TO ("carqicones") IN ("crSigSyIco1")

                IF !SEEK(loc_cArqIcone, "crSigSyIco1", "carqicones")
                    SELECT crSigSyIco1
                    GO TOP
                ENDIF

                *-- RecordSource fora do WITH: Column1 pode ser acessado com seguranca em seguida
                loc_oPagina.grd_4c_Dados.RecordSource = "crSigSyIco1"
                WITH loc_oPagina.grd_4c_Dados
                    .Column1.ControlSource = "crSigSyIco1.carqicones"
                    .LinkMaster            = ""
                    .RelationalExpr        = ""
                ENDWITH

                *-- Atualiza preview com o icone da linha inicial
                loc_cArquivo = ALLTRIM(crSigSyIco1.ctmpicones)
                IF !EMPTY(loc_cArquivo)
                    loc_oPagina.img_4c_Icone.Picture = loc_cArquivo
                    loc_oPagina.img_4c_Icone.Visible = .T.
                ELSE
                    loc_oPagina.img_4c_Icone.Visible = .F.
                ENDIF
            ENDIF

            loc_lSucesso = .T.

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro CarregarDados")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * TornarControlesVisiveis - Torna sub-controles visiveis apos AddObject
    * AddObject cria com Visible=.F.; percorre Controls + Pages recursivamente.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
        LOCAL loc_nI, loc_oObjeto, loc_nP

        FOR loc_nI = 1 TO par_oContainer.ControlCount
            loc_oObjeto = par_oContainer.Controls(loc_nI)

            IF VARTYPE(loc_oObjeto) = "O"
                *-- Recursao ANTES do filtro: garante que filhos de containers ocultos
                *-- tambem se tornem visiveis (LOOP antecipado perderia os filhos)
                IF PEMSTATUS(loc_oObjeto, "PageCount", 5)
                    FOR loc_nP = 1 TO loc_oObjeto.PageCount
                        THIS.TornarControlesVisiveis(loc_oObjeto.Pages(loc_nP))
                    ENDFOR
                ENDIF

                IF PEMSTATUS(loc_oObjeto, "ControlCount", 5) AND loc_oObjeto.ControlCount > 0
                    THIS.TornarControlesVisiveis(loc_oObjeto)
                ENDIF

                *-- cnt_4c_Cabecalho tem Visible gerenciado explicitamente em ConfigurarCabecalho
                IF INLIST(LOWER(loc_oObjeto.Name), "cnt_4c_cabecalho")
                    LOOP
                ENDIF

                IF PEMSTATUS(loc_oObjeto, "Visible", 5)
                    loc_oObjeto.Visible = .T.
                ENDIF
            ENDIF
        ENDFOR
    ENDPROC

    *--------------------------------------------------------------------------
    * AlternarPagina - Muda a pagina ativa do PageFrame
    *--------------------------------------------------------------------------
    PROCEDURE AlternarPagina(par_nPagina)
        IF par_nPagina >= 1 AND par_nPagina <= THIS.pgf_4c_Paginas.PageCount
            THIS.pgf_4c_Paginas.ActivePage = par_nPagina
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * AtualizarPreviewIcone - Atualiza img_4c_Icone com o icone da linha atual
    * Chamado pelos handlers de navegacao do grid.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE AtualizarPreviewIcone()
        LOCAL loc_cArquivo, loc_oImagem

        IF !USED("crSigSyIco1") OR EOF("crSigSyIco1")
            RETURN
        ENDIF

        loc_oImagem  = THIS.pgf_4c_Paginas.Page1.img_4c_Icone
        loc_cArquivo = ALLTRIM(crSigSyIco1.ctmpicones)

        IF !EMPTY(loc_cArquivo)
            loc_oImagem.Picture = loc_cArquivo
            loc_oImagem.Visible = .T.
        ELSE
            loc_oImagem.Visible = .F.
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * GrdDadosAfterRowColChange - Atualiza preview apos mover linha (BINDEVENT)
    *--------------------------------------------------------------------------
    PROCEDURE GrdDadosAfterRowColChange(par_nColIndex)
        THIS.AtualizarPreviewIcone()
    ENDPROC

    *--------------------------------------------------------------------------
    * GrdDadosBeforeRowColChange - Atualiza preview antes de mudar linha (BINDEVENT)
    *--------------------------------------------------------------------------
    PROCEDURE GrdDadosBeforeRowColChange(par_nColIndex)
        THIS.AtualizarPreviewIcone()
    ENDPROC

    *--------------------------------------------------------------------------
    * GrdDadosScrolled - Atualiza preview ao rolar o grid (BINDEVENT)
    *--------------------------------------------------------------------------
    PROCEDURE GrdDadosScrolled(par_nDirection)
        THIS.AtualizarPreviewIcone()
    ENDPROC

    *--------------------------------------------------------------------------
    * GrdDadosText1DblClick - Seleciona icone e fecha dialog (BINDEVENT)
    * Mapeado de Grid1.Column1.Text1.DblClick do legado.
    *--------------------------------------------------------------------------
    PROCEDURE GrdDadosText1DblClick()
        LOCAL loc_cArqIcone
        loc_cArqIcone = LOWER(ALLTRIM(THIS.pgf_4c_Paginas.Page1.grd_4c_Dados.Column1.Text1.Value))
        THIS.this_oBusinessObject.SelecionarIcone(loc_cArqIcone, THIS.this_cIdChaves)
        THIS.Release()
    ENDPROC

    *--------------------------------------------------------------------------
    * GrdDadosText1KeyPress - ENTER na celula aciona selecao (BINDEVENT)
    * Mapeado de Grid1.Column1.Text1.KeyPress do legado.
    *--------------------------------------------------------------------------
    PROCEDURE GrdDadosText1KeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 13
            THIS.GrdDadosText1DblClick()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * KeyPress - ESC fecha o dialog sem salvar
    *--------------------------------------------------------------------------
    PROCEDURE KeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 27
            THIS.Release()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterIconeSelecionadoNoGrid - Retorna nome do arquivo de icone da linha ativa
    * Lida com marcador "< nenhum >" transformando em string vazia.
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION ObterIconeSelecionadoNoGrid()
        LOCAL loc_cArqIcone

        IF !USED("crSigSyIco1") OR EOF("crSigSyIco1")
            RETURN ""
        ENDIF

        loc_cArqIcone = LOWER(ALLTRIM(NVL(crSigSyIco1.carqicones, "")))
        IF loc_cArqIcone == "< nenhum >"
            loc_cArqIcone = ""
        ENDIF

        RETURN loc_cArqIcone
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnIncluirClick - Atribui o icone selecionado ao programa
    * Le o icone da linha ativa do grid + chama BO.Inserir + fecha o dialog.
    * Equivalente ao Grid1.Column1.Text1.DblClick do legado quando nao havia icone.
    *--------------------------------------------------------------------------
    PROCEDURE BtnIncluirClick()
        LOCAL loc_cArqIcone, loc_lSucesso, loc_oErro

        TRY
            IF EMPTY(THIS.this_cIdChaves)
                MsgAviso("Chave do programa n" + CHR(227) + "o informada.", "Aviso")
                RETURN
            ENDIF

            loc_cArqIcone = THIS.ObterIconeSelecionadoNoGrid()

            THIS.this_oBusinessObject.this_cIdChaves = THIS.this_cIdChaves
            THIS.this_oBusinessObject.this_cArqIcone = loc_cArqIcone

            loc_lSucesso = THIS.this_oBusinessObject.Salvar()

            IF loc_lSucesso
                THIS.Release()
            ELSE
                MsgAviso(THIS.this_oBusinessObject.this_cMensagemErro, "Aviso")
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro BtnIncluirClick")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnAlterarClick - Troca o icone atribuido ao programa
    * Le o icone da linha ativa do grid + chama BO.Atualizar + fecha o dialog.
    * Equivalente ao Grid1.Column1.Text1.DblClick do legado quando ja havia icone.
    *--------------------------------------------------------------------------
    PROCEDURE BtnAlterarClick()
        LOCAL loc_cArqIcone, loc_lSucesso, loc_oErro

        TRY
            IF EMPTY(THIS.this_cIdChaves)
                MsgAviso("Chave do programa n" + CHR(227) + "o informada.", "Aviso")
                RETURN
            ENDIF

            loc_cArqIcone = THIS.ObterIconeSelecionadoNoGrid()

            THIS.this_oBusinessObject.this_cIdChaves = THIS.this_cIdChaves
            THIS.this_oBusinessObject.this_cArqIcone = loc_cArqIcone

            IF THIS.this_oBusinessObject.SelecionarIcone(loc_cArqIcone, THIS.this_cIdChaves)
                THIS.Release()
            ELSE
                MsgAviso("Falha ao atualizar " + CHR(237) + "cone.", "Aviso")
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro BtnAlterarClick")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnVisualizarClick - Atualiza preview do icone da linha ativa
    * Equivalente ao Grid1.AfterRowColChange do legado (que atualizava o preview).
    *--------------------------------------------------------------------------
    PROCEDURE BtnVisualizarClick()
        LOCAL loc_oErro

        TRY
            IF !USED("crSigSyIco1")
                MsgAviso("Lista de " + CHR(237) + "cones n" + CHR(227) + "o dispon" + CHR(237) + "vel.", "Aviso")
                RETURN
            ENDIF

            THIS.AtualizarPreviewIcone()

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro BtnVisualizarClick")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnExcluirClick - Remove o icone atribuido ao programa
    * Chama BO.Excluir para zerar barrapict/barraforms em crProg1/crProg2 + fecha.
    *--------------------------------------------------------------------------
    PROCEDURE BtnExcluirClick()
        LOCAL loc_lConfirma, loc_lSucesso, loc_oErro

        TRY
            IF EMPTY(THIS.this_cIdChaves)
                MsgAviso("Chave do programa n" + CHR(227) + "o informada.", "Aviso")
                RETURN
            ENDIF

            loc_lConfirma = MsgConfirma("Confirma a remo" + CHR(231) + CHR(227) + "o do " + CHR(237) + "cone atribu" + CHR(237) + "do?", "Confirma" + CHR(231) + CHR(227) + "o")

            IF !loc_lConfirma
                RETURN
            ENDIF

            THIS.this_oBusinessObject.this_cIdChaves = THIS.this_cIdChaves
            loc_lSucesso = THIS.this_oBusinessObject.Excluir()

            IF loc_lSucesso
                THIS.Release()
            ELSE
                MsgAviso(THIS.this_oBusinessObject.this_cMensagemErro, "Aviso")
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro BtnExcluirClick")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarLista - Reinicializa o grid com crSigSyIco1 e atualiza preview
    * Util para refresco apos mudanca de icone ou retorno ao dialog.
    *--------------------------------------------------------------------------
    PROCEDURE CarregarLista()
        LOCAL loc_lSucesso, loc_oPagina, loc_oErro
        loc_lSucesso = .F.

        TRY
            loc_oPagina = THIS.pgf_4c_Paginas.Page1

            IF USED("crSigSyIco1")
                *-- RecordSource fora do WITH: Column1 pode ser acessado com seguranca em seguida
                loc_oPagina.grd_4c_Dados.RecordSource = "crSigSyIco1"
                WITH loc_oPagina.grd_4c_Dados
                    .Column1.ControlSource = "crSigSyIco1.carqicones"
                    .LinkMaster            = ""
                    .RelationalExpr        = ""
                ENDWITH
                THIS.AtualizarPreviewIcone()
            ENDIF

            loc_lSucesso = .T.

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro CarregarLista")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * FormParaBO - Transfere o icone selecionado no grid para o BO
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE FormParaBO()
        LOCAL loc_cArqIcone

        TRY
            loc_cArqIcone = THIS.ObterIconeSelecionadoNoGrid()
            THIS.this_oBusinessObject.this_cIdChaves = THIS.this_cIdChaves
            THIS.this_oBusinessObject.this_cArqIcone = loc_cArqIcone
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro FormParaBO")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BOParaForm - Atualiza preview do form com o icone registrado no BO
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE BOParaForm()
        LOCAL loc_cArquivo, loc_oPagina, loc_oErro

        TRY
            loc_oPagina = THIS.pgf_4c_Paginas.Page1
            loc_cArquivo = ALLTRIM(THIS.this_oBusinessObject.this_cArqIcone)

            IF !EMPTY(loc_cArquivo)
                loc_oPagina.img_4c_Icone.Picture = loc_cArquivo
                loc_oPagina.img_4c_Icone.Visible = .T.
            ELSE
                loc_oPagina.img_4c_Icone.Visible = .F.
            ENDIF

            loc_oPagina.txt_4c_Programa.Value = THIS.this_oBusinessObject.this_cDescricao
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro BOParaForm")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * HabilitarCampos - Neste dialog os campos sao sempre readonly (somente grid)
    * Implementado para compatibilidade com FormBase.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE HabilitarCampos(par_lHabilitar)
        LOCAL loc_oPagina

        IF PEMSTATUS(THIS, "pgf_4c_Paginas", 5)
            loc_oPagina = THIS.pgf_4c_Paginas.Page1
            IF PEMSTATUS(loc_oPagina, "txt_4c_Programa", 5)
                loc_oPagina.txt_4c_Programa.ReadOnly = .T.
            ENDIF
            IF PEMSTATUS(loc_oPagina, "grd_4c_Dados", 5)
                loc_oPagina.grd_4c_Dados.ReadOnly = .T.
            ENDIF
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * LimparCampos - Limpa o preview e o campo de programa
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE LimparCampos()
        LOCAL loc_oPagina, loc_oErro

        TRY
            loc_oPagina = THIS.pgf_4c_Paginas.Page1
            loc_oPagina.img_4c_Icone.Visible = .F.
            loc_oPagina.img_4c_Icone.Picture = ""
            loc_oPagina.txt_4c_Programa.Value = ""
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro LimparCampos")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * AjustarBotoesPorModo - Dialog plano sem modos CRUD; sem ajuste de botoes
    * Implementado para compatibilidade com FormBase.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE AjustarBotoesPorModo()
        RETURN
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnBuscarClick - Recarrega o grid de icones e posiciona no icone atual
    *--------------------------------------------------------------------------
    PROCEDURE BtnBuscarClick()
        LOCAL loc_oErro

        TRY
            THIS.CarregarDados()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro BtnBuscarClick")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnSalvarClick - Seleciona o icone da linha atual e fecha o dialog
    * Equivalente ao DblClick/ENTER no grid; usa FormParaBO antes de salvar.
    *--------------------------------------------------------------------------
    PROCEDURE BtnSalvarClick()
        LOCAL loc_lSucesso, loc_oErro

        TRY
            THIS.FormParaBO()
            loc_lSucesso = THIS.this_oBusinessObject.SelecionarIcone( ;
                THIS.this_oBusinessObject.this_cArqIcone, ;
                THIS.this_cIdChaves)

            IF loc_lSucesso
                THIS.Release()
            ELSE
                MsgAviso("Falha ao atribuir " + CHR(237) + "cone.", "Aviso")
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro BtnSalvarClick")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnCancelarClick - Fecha o dialog sem salvar (mesmo comportamento do ESC)
    *--------------------------------------------------------------------------
    PROCEDURE BtnCancelarClick()
        THIS.Release()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnEncerrarClick - Fecha o dialog (alias de Cancelar para compatibilidade)
    *--------------------------------------------------------------------------
    PROCEDURE BtnEncerrarClick()
        THIS.Release()
    ENDPROC

    *--------------------------------------------------------------------------
    * Destroy - Libera Business Object e delega restante ao FormBase
    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
        LOCAL loc_oErro

        TRY
            IF VARTYPE(THIS.this_oBusinessObject) = "O"
                THIS.this_oBusinessObject = .NULL.
            ENDIF
        CATCH TO loc_oErro
            *-- Ignorar erros no Destroy (form ja esta sendo liberado)
        ENDTRY

        DODEFAULT()
    ENDPROC

ENDDEFINE


### BO (C:\4c\projeto\app\classes\SIGPRCICBO.prg):
*==============================================================================
* SIGPRCICBO.prg - Business Object para Seletor de Icones de Programas
* Data: 2026-07-02
* Funcao: Dialog de escolha de icone para item de menu/programa
* Obs: Form opera na datasession do form pai (sem SQL proprio)
*==============================================================================

DEFINE CLASS SIGPRCICBO AS BusinessBase

    *-- Chave do programa passada pelo form pai (pcIdChaves no legado)
    this_cIdChaves      = ""    && pkChaves do programa (crProg1/crProg2)

    *-- Icone atualmente selecionado (barrapict no legado)
    this_cArqIcone      = ""    && nome do arquivo de icone (ex: "geral_ok_26.jpg")

    *-- Descricao do programa exibida no campo readonly
    this_cDescricao     = ""    && descricaos de crProg2

    *--------------------------------------------------------------------------
    * Init - Inicializa o Business Object
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        DODEFAULT()
        THIS.this_cTabela     = "SIGPRCIC"
        THIS.this_cCampoChave = "pkChaves"
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Popula propriedades a partir de crProg2 ou alias
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF USED(par_cAliasCursor)
                SELECT (par_cAliasCursor)
                THIS.this_cIdChaves  = TratarNulo(pkChaves,   "C")
                THIS.this_cArqIcone  = LOWER(ALLTRIM(TratarNulo(barrapict,  "C")))
                THIS.this_cDescricao = TratarNulo(descricaos, "C")
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Retorna a chave do programa selecionado
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION ObterChavePrimaria()
        RETURN THIS.this_cIdChaves
    ENDPROC

    *--------------------------------------------------------------------------
    * SelecionarIcone - Atualiza barrapict em crProg1 e crProg2 (cursor REPLACE)
    * Este form opera na datasession do form pai; nao usa SQLEXEC proprio.
    * A gravacao definitiva no SQL Server eh feita pelo form pai ao salvar.
    *--------------------------------------------------------------------------
    FUNCTION SelecionarIcone(par_cArqIcone, par_cIdChaves)
        LOCAL loc_lSucesso, loc_cIcone
        loc_lSucesso = .F.

        TRY
            loc_cIcone = LOWER(ALLTRIM(par_cArqIcone))
            IF loc_cIcone = "< nenhum >"
                loc_cIcone = ""
            ENDIF

            IF USED("crProg1") AND SEEK(par_cIdChaves, "crProg1", "pkChaves")
                SELECT crProg1
                REPLACE barrapict WITH loc_cIcone, ;
                        barraforms WITH IIF(!EMPTY(barraforms), barraforms, crProg1.programas)
            ENDIF

            IF USED("crProg2") AND SEEK(par_cIdChaves, "crProg2", "pkChaves")
                SELECT crProg2
                REPLACE barrapict WITH loc_cIcone, ;
                        barraforms WITH IIF(!EMPTY(barraforms), barraforms, crProg2.programas)
            ENDIF

            THIS.this_cArqIcone = loc_cIcone
            THIS.this_cIdChaves = par_cIdChaves
            loc_lSucesso = .T.

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir - Atribui um icone ao programa (primeira selecao)
    * Faz REPLACE em crProg1/crProg2 com o icone selecionado + audita.
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION Inserir()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF EMPTY(THIS.this_cIdChaves)
                THIS.this_cMensagemErro = "Chave do programa n" + CHR(227) + "o informada"
                loc_lSucesso = .F.
            ENDIF

            IF THIS.SelecionarIcone(THIS.this_cArqIcone, THIS.this_cIdChaves)
                THIS.RegistrarAuditoria("INSERT")
                loc_lSucesso = .T.
            ELSE
                THIS.this_cMensagemErro = "Falha ao atribuir " + CHR(237) + "cone"
            ENDIF

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - Troca o icone atribuido ao programa
    * Faz REPLACE em crProg1/crProg2 com o novo icone + audita.
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION Atualizar()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF EMPTY(THIS.this_cIdChaves)
                THIS.this_cMensagemErro = "Chave do programa n" + CHR(227) + "o informada"
                loc_lSucesso = .F.
            ENDIF

            IF THIS.SelecionarIcone(THIS.this_cArqIcone, THIS.this_cIdChaves)
                THIS.RegistrarAuditoria("UPDATE")
                loc_lSucesso = .T.
            ELSE
                THIS.this_cMensagemErro = "Falha ao atualizar " + CHR(237) + "cone"
            ENDIF

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ExecutarExclusao - Remove o icone atribuido (barrapict = "")
    * Faz REPLACE em crProg1/crProg2 zerando o icone + audita.
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION ExecutarExclusao()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF EMPTY(THIS.this_cIdChaves)
                THIS.this_cMensagemErro = "Chave do programa n" + CHR(227) + "o informada"
                loc_lSucesso = .F.
            ENDIF

            IF USED("crProg1") AND SEEK(THIS.this_cIdChaves, "crProg1", "pkChaves")
                SELECT crProg1
                REPLACE barrapict WITH "", barraforms WITH ""
            ENDIF

            IF USED("crProg2") AND SEEK(THIS.this_cIdChaves, "crProg2", "pkChaves")
                SELECT crProg2
                REPLACE barrapict WITH "", barraforms WITH ""
            ENDIF

            THIS.this_cArqIcone = ""
            THIS.RegistrarAuditoria("DELETE")
            loc_lSucesso = .T.

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * RegistrarAuditoria - Grava a alteracao de icone em LogAuditoria
    * Override: escreve com Tabela="SIGPRCIC" (form nao mapeia tabela real)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE RegistrarAuditoria(par_cOperacao)
        LOCAL loc_cSQL, loc_cChave, loc_cUsuario

        loc_cChave = THIS.ObterChavePrimaria()

        IF EMPTY(loc_cChave) OR TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
            RETURN .F.
        ENDIF

        loc_cUsuario = IIF(TYPE("gc_4c_UsuarioLogado") = "C", gc_4c_UsuarioLogado, "SISTEMA")

        loc_cSQL = "INSERT INTO LogAuditoria (Tabela, Operacao, ChaveRegistro, Usuario, DataHora) " + ;
                   "VALUES (" + EscaparSQL(THIS.this_cTabela) + ", " + ;
                   EscaparSQL(par_cOperacao) + ", " + ;
                   EscaparSQL(loc_cChave) + ", " + ;
                   EscaparSQL(loc_cUsuario) + ", GETDATE())"

        SQLEXEC(gnConnHandle, loc_cSQL)
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * BuscarIconeAtual - Le o icone atual do cursor crProg2 para o par_cIdChaves
    *--------------------------------------------------------------------------
    FUNCTION BuscarIconeAtual(par_cIdChaves)
        LOCAL loc_cIcone
        loc_cIcone = ""

        TRY
            IF USED("crProg2") AND SEEK(par_cIdChaves, "crProg2", "pkChaves")
                IF !EMPTY(crProg2.barrapict)
                    loc_cIcone = PADR(LOWER(ALLTRIM(crProg2.barrapict)), 64)
                ENDIF
                THIS.this_cDescricao = TratarNulo(crProg2.descricaos, "C")
            ENDIF

            IF EMPTY(loc_cIcone) AND !EMPTY(par_cIdChaves)
                loc_cIcone = PADR(LOWER(ALLTRIM(JUSTFNAME(par_cIdChaves))), 64)
            ENDIF

            THIS.this_cArqIcone = loc_cIcone
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_cIcone
    ENDPROC

ENDDEFINE


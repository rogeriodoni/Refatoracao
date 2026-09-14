# CORRIGIR ERRO DE RUNTIME VFP9

## TAREFA OBRIGATORIA
O formulario VFP9 apresentou erro de runtime durante teste automatizado.
Voce DEVE corrigir o erro e salvar os arquivos corrigidos usando Write tool.

## ERRO DETECTADO
- Etapa: 06b_testeAutomatico
- Tentativa: 1/10
- Mensagem: Testes automaticos: 89% < 100%. Falhas: Teste 'CarregarDadosReais': Property CARREGARDADOS is not found. | Detalhes: Linha: 799, Proc: testecarregardadosreais

## CONTEXTO DO ERRO

### LOG DA ETAPA (06b_testeAutomatico):
[2026-07-01 22:37:24] [INFO] === VFP EXECUTOR v2.0 ===
[2026-07-01 22:37:24] [INFO] Config FPW: (nao fornecido)
[2026-07-01 22:37:24] [INFO] Script PRG: C:\4c\projeto\app\utils\TesteAutomatico.prg
[2026-07-01 22:37:24] [INFO] Timeout: 300 segundos
[2026-07-01 22:37:24] [INFO] Wrapper PRG criado para parametros: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_flbpx4na.prg
[2026-07-01 22:37:24] [INFO] Conteudo do wrapper:
[2026-07-01 22:37:24] [INFO] * Auto-generated wrapper for parameters
* Script: C:\4c\projeto\app\utils\TesteAutomatico.prg
* Parameters: 'FormSigPrCar', 'C:\4c\tasks\task157', 'OPERACIONAL'

* Anti-dialog protections for unattended execution
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
SET NOTIFY OFF
SYS(2335, 0)

DO "C:\4c\projeto\app\utils\TesteAutomatico" WITH 'FormSigPrCar', 'C:\4c\tasks\task157', 'OPERACIONAL'
QUIT

[2026-07-01 22:37:24] [INFO] Comando VFP: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_flbpx4na.prg
[2026-07-01 22:37:24] [INFO] VFP output esperado em: C:\4c\tasks\task157\vfp_output.txt
[2026-07-01 22:37:24] [INFO] Executando Visual FoxPro 9...
[2026-07-01 22:37:24] [INFO] Comando completo: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_flbpx4na.prg
[2026-07-01 22:37:24] [INFO] Executando: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_flbpx4na.prg
[2026-07-01 22:37:24] [INFO] Timeout configurado: 300 segundos
[2026-07-01 22:37:39] [INFO] VFP9 finalizou normalmente com exit code: 
[2026-07-01 22:37:39] [INFO] VFP9 finalizado em 14.6053638 segundos
[2026-07-01 22:37:39] [INFO] Exit Code: 
[2026-07-01 22:37:39] [INFO] 
[2026-07-01 22:37:39] [INFO] Arquivos temporarios preservados para inspecao:
[2026-07-01 22:37:39] [INFO]   Wrapper.prg: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_flbpx4na.prg
[2026-07-01 22:37:39] [INFO] 
[2026-07-01 22:37:39] [INFO] === Conteudo do Wrapper.prg temporario ===
[2026-07-01 22:37:39] [INFO] * Auto-generated wrapper for parameters
[2026-07-01 22:37:39] [INFO] * Script: C:\4c\projeto\app\utils\TesteAutomatico.prg
[2026-07-01 22:37:39] [INFO] * Parameters: 'FormSigPrCar', 'C:\4c\tasks\task157', 'OPERACIONAL'
[2026-07-01 22:37:39] [INFO] 
[2026-07-01 22:37:39] [INFO] * Anti-dialog protections for unattended execution
[2026-07-01 22:37:39] [INFO] SET SAFETY OFF
[2026-07-01 22:37:39] [INFO] SET RESOURCE OFF
[2026-07-01 22:37:39] [INFO] SET TALK OFF
[2026-07-01 22:37:39] [INFO] SET NOTIFY OFF
[2026-07-01 22:37:39] [INFO] SYS(2335, 0)
[2026-07-01 22:37:39] [INFO] 
[2026-07-01 22:37:39] [INFO] DO "C:\4c\projeto\app\utils\TesteAutomatico" WITH 'FormSigPrCar', 'C:\4c\tasks\task157', 'OPERACIONAL'
[2026-07-01 22:37:39] [INFO] QUIT
[2026-07-01 22:37:39] [INFO] 
[2026-07-01 22:37:39] [INFO] === Fim do Wrapper.prg ===
[2026-07-01 22:37:39] [WARN] AVISO: VFP9 retornou exit code  (normal para VFP9 GUI - validar pelo arquivo de saida)


### RESULTADO DOS TESTES (teste_resultado.json):
{
  "formClass": "FormSigPrCar",
  "timestamp": "20260701223739",
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
      "detalhes": "Nenhum PageFrame encontrado (form sem paginas)"
    },
    {
      "nome": "BtnIncluirNavegacao",
      "passou": true,
      "erro": "",
      "detalhes": "Form OPERACIONAL com BtnIncluirClick sem navegacao por PageFrame (OK)"
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
      "detalhes": "AbrirLookup: 0 | KeyPress handlers: 3 (KEYPRESS, TXTCODIGOSKEYPRESS, TXTDESCRSKEYPRESS)"
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

### FORM (C:\4c\projeto\app\forms\operacionais\FormSigPrCar.prg):
*==============================================================================
* FormSigPrCar.prg - Formulario Operacional: Caracteristicas do Produto
* Migrado de: SigPrCar.SCX
* Tipo: OPERACIONAL (layout flat, sem PageFrame CRUD)
* Abertura: FormSigCdPro abre este form modalmente passando referencia e contexto
* Parametros Init: par_oFormPai, par_cCPros, par_cCGrus, par_cPcEscolha
*
* Layout original (480x540):
*   cntSombra   Top=0    Left=0  Width=480 Height=80  (cabecalho cinza)
*   Shape1      Top=-3   Left=239 (fundo visual area botoes)
*   cmdInserir  Top=3    Left=255 (visivel apenas INSERIR/ALTERAR)
*   cmdExcluir  Top=3    Left=330 (visivel apenas INSERIR/ALTERAR)
*   cmdSair     Top=3    Left=405 (sempre visivel, Caption="Encerrar")
*   grd_4c_Dados Top=103 Left=8  Width=463 Height=411
*==============================================================================

DEFINE CLASS FormSigPrCar AS FormBase

    *-- Propriedades visuais identicas ao original (PILAR 1)
    this_cMensagemErro = ""
    Width       = 480
    Height      = 540
    AutoCenter  = .T.
    BorderStyle = 2
    ShowWindow = 1
    ControlBox  = .F.
    MaxButton   = .F.
    MinButton   = .F.
    TitleBar    = 0
    WindowType  = 1
    Themes      = .F.
    FontName    = "Tahoma"
    FontSize    = 8

    *-- Titulo do form (definido em Init com CHR() - DEFINE CLASS nao aceita funcoes)
    this_cTituloForm = ""

    *-- Propriedades operacionais (espelham legado: parentform/pcescolha/houveincl/houveexcl)
    this_oFormPai     = .NULL.       && Referencia ao form pai (FormSigCdPro)
    this_cPcEscolha   = "CONSULTAR"  && Modo: INSERIR / ALTERAR / CONSULTAR
    this_lHouveIncl   = .F.          && Sinaliza ao pai que houve inclusao
    this_lHouveExcl   = .F.          && Sinaliza ao pai que houve exclusao

    *-- Contexto do produto (recebido do pai; substitui acesso a crSigCdPro)
    this_cCPros       = ""           && Codigo do produto (FK -> sigprcar.cpros)
    this_cCGrus       = ""           && Grupo do produto (filtro do lookup SigCrRap)

    *==========================================================================
    * Init - Armazena parametros ANTES de DODEFAULT (InicializarForm precisa deles)
    * par_oFormPai   : referencia ao FormSigCdPro (legado: poForm)
    * par_cCPros     : codigo do produto para filtrar caracteristicas
    * par_cCGrus     : grupo do produto para filtro do lookup SigCrRap
    * par_cPcEscolha : modo de operacao (INSERIR / ALTERAR / CONSULTAR)
    *==========================================================================
    PROCEDURE Init(par_oFormPai, par_cCPros, par_cCGrus, par_cPcEscolha)
        THIS.this_cTituloForm = "Caracter" + CHR(237) + "sticas do Produto"
        THIS.this_oFormPai    = par_oFormPai
        THIS.this_cCPros      = ALLTRIM(IIF(VARTYPE(par_cCPros) = "C", par_cCPros, ""))
        THIS.this_cCGrus      = ALLTRIM(IIF(VARTYPE(par_cCGrus) = "C", par_cCGrus, ""))
        THIS.this_cPcEscolha  = UPPER(ALLTRIM(IIF(VARTYPE(par_cPcEscolha) = "C", par_cPcEscolha, "CONSULTAR")))
        THIS.this_lHouveIncl  = .F.
        THIS.this_lHouveExcl  = .F.
        RETURN DODEFAULT()
    ENDPROC

    *==========================================================================
    * InicializarForm - Chamado por FormBase.Init via DODEFAULT
    * Constroi o layout e carrega dados iniciais do produto
    *==========================================================================
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lSucesso, loc_oErro

        loc_lSucesso = .F.

        TRY
            THIS.this_oBusinessObject = CREATEOBJECT("SigPrCarBO")

            THIS.Picture = gc_4c_CaminhoBase + "Framework\imagens\new_background.jpg"

            THIS.ConfigurarPageFrame()
            THIS.ConfigurarPaginaLista()
            THIS.ConfigurarPaginaDados()

            THIS.TornarControlesVisiveis(THIS)
            THIS.AjustarVisibilidadeBotoes()

            IF (TYPE("gb_4c_ValidandoUI") != "L" OR !gb_4c_ValidandoUI) AND ;
               (TYPE("gb_4c_ModoTeste") != "L" OR !gb_4c_ModoTeste)
                IF !EMPTY(THIS.this_cCPros)
                    IF THIS.this_oBusinessObject.Buscar(THIS.this_cCPros)
                        THIS.CarregarDados()
                    ENDIF
                ENDIF
            ENDIF

            loc_lSucesso = .T.

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "FormSigPrCar.InicializarForm")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * ConfigurarPageFrame - Cria cabecalho cinza (cntSombra do legado)
    * Forms OPERACIONAIS nao tem PageFrame CRUD; este metodo cria a estrutura
    * fixa do topo (cabecalho com sombra e titulo do form).
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPageFrame()
        THIS.AddObject("cnt_4c_Sombra", "Container")
        WITH THIS.cnt_4c_Sombra
            .Top         = 0
            .Left        = 0
            .Width       = THIS.Width
            .Height      = 80
            .BackColor   = RGB(100, 100, 100)
            .BackStyle   = 1
            .BorderWidth = 0

            .AddObject("lbl_4c_LblSombra", "Label")
            WITH .lbl_4c_LblSombra
                .Top           = 25
                .Left          = 10
                .Width         = THIS.Width
                .Height        = 40
                .FontBold      = .T.
                .FontName      = "Tahoma"
                .FontSize      = 18
                .BackStyle     = 0
                .AutoSize      = .F.
                .WordWrap      = .T.
                .Alignment     = 0
                .ForeColor     = RGB(0, 0, 0)
                .Caption       = THIS.this_cTituloForm
            ENDWITH

            .AddObject("lbl_4c_LblTitulo", "Label")
            WITH .lbl_4c_LblTitulo
                .Top           = 24
                .Left          = 10
                .Width         = THIS.Width
                .Height        = 46
                .FontBold      = .T.
                .FontName      = "Tahoma"
                .FontSize      = 18
                .BackStyle     = 0
                .AutoSize      = .F.
                .WordWrap      = .T.
                .Alignment     = 0
                .ForeColor     = RGB(255, 255, 255)
                .Caption       = THIS.this_cTituloForm
            ENDWITH
        ENDWITH
    ENDPROC

    *==========================================================================
    * ConfigurarPaginaLista - Constroi a "pagina" de listagem da tela operacional
    * Forms OPERACIONAIS nao tem PageFrame; esta rotina eh a fachada que agrupa
    * a criacao do grid de caracteristicas onde o usuario visualiza os registros
    * do produto. Equivale, na semantica CRUD, ao "Page1 Lista".
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPaginaLista()
        THIS.ConfigurarGrid()
    ENDPROC

    *==========================================================================
    * ConfigurarPaginaDados - Constroi a "pagina" de acao/edicao da tela
    * Este form OPERACIONAL nao possui pagina de campos separada; a entrada de
    * dados ocorre diretamente nas celulas do grid. Esta rotina cria os botoes
    * de acao que disparam a manipulacao dos dados: Inserir (nova caracteristica),
    * Excluir (remover selecionada) e Encerrar (persistir e sair). Equivale, na
    * semantica CRUD, ao "Page2 Dados" onde a edicao acontece.
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPaginaDados()
        THIS.ConfigurarBotoes()
    ENDPROC

    *==========================================================================
    * AlternarPagina - Alterna o modo operacional do form (INSERIR/ALTERAR/
    * CONSULTAR). Como este form nao possui PageFrame, "alternar pagina"
    * corresponde a alternar o modo de operacao: ajusta visibilidade dos botoes
    * de edicao (Inserir/Excluir) conforme o novo modo e recarrega o grid.
    *
    * par_cModo : "INSERIR", "ALTERAR" ou "CONSULTAR"
    *==========================================================================
    PROCEDURE AlternarPagina(par_cModo)
        LOCAL loc_cModoNovo

        loc_cModoNovo = UPPER(ALLTRIM(IIF(VARTYPE(par_cModo) = "C", par_cModo, "")))

        IF EMPTY(loc_cModoNovo) OR ;
           !INLIST(loc_cModoNovo, "INSERIR", "ALTERAR", "CONSULTAR")
            RETURN
        ENDIF

        THIS.this_cPcEscolha = loc_cModoNovo

        *-- Reaplica visibilidade/enabled dos botoes conforme novo modo
        THIS.AjustarVisibilidadeBotoes()

        *-- Recarrega dados do produto no novo modo (grid reflete estado atual)
        IF !EMPTY(THIS.this_cCPros) AND VARTYPE(THIS.this_oBusinessObject) = "O"
            IF THIS.this_oBusinessObject.Buscar(THIS.this_cCPros)
                THIS.CarregarDados()
            ENDIF
        ENDIF
    ENDPROC

    *==========================================================================
    * TornarControlesVisiveis - Torna todos os controles visiveis recursivamente
    * AddObject() cria controles com Visible=.F. por padrao
    *==========================================================================
    PROCEDURE TornarControlesVisiveis(par_oContainer)
        LOCAL loc_nI, loc_oControl

        FOR loc_nI = 1 TO par_oContainer.ControlCount
            loc_oControl = par_oContainer.Controls(loc_nI)

            IF VARTYPE(loc_oControl) = "O"
                IF PEMSTATUS(loc_oControl, "Visible", 5)
                    loc_oControl.Visible = .T.
                ENDIF

                IF UPPER(loc_oControl.BaseClass) = "PAGEFRAME"
                    LOCAL loc_nP
                    FOR loc_nP = 1 TO loc_oControl.PageCount
                        THIS.TornarControlesVisiveis(loc_oControl.Pages(loc_nP))
                    ENDFOR
                ENDIF

                IF PEMSTATUS(loc_oControl, "ControlCount", 5) AND loc_oControl.ControlCount > 0
                    THIS.TornarControlesVisiveis(loc_oControl)
                ENDIF
            ENDIF
        ENDFOR
    ENDPROC

    *==========================================================================
    * Destroy - Libera recursos ao fechar o form
    *==========================================================================
    PROCEDURE Destroy()
        *-- Garantir que o form pai seja reabilitado mesmo se o form fechar inesperadamente
        IF VARTYPE(THIS.this_oFormPai) = "O"
            TRY
                THIS.this_oFormPai.Enabled = .T.
            CATCH
            ENDTRY
        ENDIF
        IF USED("cursor_4c_Dados")
            USE IN cursor_4c_Dados
        ENDIF
        IF USED("cursor_4c_DadosTemp")
            USE IN cursor_4c_DadosTemp
        ENDIF
        IF USED("cursor_4c_DadosSwap")
            USE IN cursor_4c_DadosSwap
        ENDIF
        IF USED("cursor_4c_DupCheck")
            USE IN cursor_4c_DupCheck
        ENDIF
        IF USED("cursor_4c_Busca")
            USE IN cursor_4c_Busca
        ENDIF
        IF VARTYPE(THIS.this_oBusinessObject) = "O"
            THIS.this_oBusinessObject = .NULL.
        ENDIF
        DODEFAULT()
    ENDPROC

    *==========================================================================
    * ConfigurarGrid - Cria grid de caracteristicas com 2 colunas
    * Column1 = Codigos (busca por codigo), Column2 = Descrs (busca por descricao)
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarGrid()
        *-- Cursor placeholder (estrutura identica ao BO.Buscar)
        IF USED("cursor_4c_Dados")
            USE IN cursor_4c_Dados
        ENDIF
        SET NULL ON
        CREATE CURSOR cursor_4c_Dados ;
            (codigos C(20) NULL, descrs C(40) NULL, cpros C(14) NULL, pkchaves C(20) NULL)
        SET NULL OFF

        THIS.AddObject("grd_4c_Dados", "Grid")
        THIS.grd_4c_Dados.ColumnCount  = 2
        THIS.grd_4c_Dados.RecordSource = "cursor_4c_Dados"
        WITH THIS.grd_4c_Dados
            .Top               = 103
            .Left              = 8
            .Width             = 463
            .Height            = 411
            .FontName          = "Tahoma"
            .FontSize          = 8
            .DeleteMark        = .F.
            .RecordMark        = .F.
            .AllowHeaderSizing = .F.
            .AllowRowSizing    = .F.
            .RowHeight         = 17
            .ScrollBars        = 2
            .GridLineColor     = RGB(238, 238, 238)
            .AllowCellSelection = .T.
            .Panel             = 1
        ENDWITH
        WITH THIS.grd_4c_Dados.Column1
            .ControlSource     = "cursor_4c_Dados.codigos"
            .Width             = 150
            .FontName          = "Tahoma"
            .FontSize          = 8
            .Movable           = .F.
            .Resizable         = .F.
            .Header1.Caption   = "Caracter" + CHR(237) + "stica"
            .Header1.FontName  = "Tahoma"
            .Header1.FontSize  = 8
            .Header1.Alignment = 2
            .Header1.ForeColor = RGB(90, 90, 90)
        ENDWITH
        WITH THIS.grd_4c_Dados.Column2
            .ControlSource     = "cursor_4c_Dados.descrs"
            .Width             = 290
            .FontName          = "Tahoma"
            .FontSize          = 8
            .Movable           = .F.
            .Resizable         = .F.
            .Header1.Caption   = "Descri" + CHR(231) + CHR(227) + "o"
            .Header1.FontName  = "Tahoma"
            .Header1.FontSize  = 8
            .Header1.Alignment = 2
            .Header1.ForeColor = RGB(90, 90, 90)
        ENDWITH

        BINDEVENT(THIS.grd_4c_Dados.Column1.Text1, "KeyPress", THIS, "TxtCodigosKeyPress")
        BINDEVENT(THIS.grd_4c_Dados.Column2.Text1, "KeyPress", THIS, "TxtDescrsKeyPress")
    ENDPROC

    *==========================================================================
    * ConfigurarBotoes - Cria Shape1 e 3 botoes de acao sobrepostos ao cabecalho
    * Inserir (Left=255), Excluir (Left=330), Encerrar (Left=405)
    * Visibilidade controlada por AjustarVisibilidadeBotoes()
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarBotoes()
        *-- Shape1: fundo visual da area de botoes (BackStyle=0 = transparente)
        THIS.AddObject("shp_4c_Shape1", "Shape")
        WITH THIS.shp_4c_Shape1
            .Top         = -3
            .Left        = 239
            .Width       = 250
            .Height      = 38
            .BackStyle   = 0
            .BorderStyle = 0
            .BorderColor = RGB(136, 189, 188)
        ENDWITH

        THIS.AddObject("cmd_4c_Inserir", "CommandButton")
        WITH THIS.cmd_4c_Inserir
            .Top             = 3
            .Left            = 255
            .Width           = 70
            .Height          = 30
            .Caption         = "Inserir"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_inserir_60.jpg"
            .Themes          = .T.
            .DisabledPicture = gc_4c_CaminhoIcones + "cadastro_inserir_60.jpg"
            .FontName        = "Tahoma"
            .FontSize        = 8
            .FontBold        = .T.
            .FontItalic      = .T.
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .SpecialEffect   = 0
            .PicturePosition = 13
            .MousePointer    = 15
            .WordWrap        = .T.
            .AutoSize        = .F.
        ENDWITH
        BINDEVENT(THIS.cmd_4c_Inserir, "Click", THIS, "CmdInserirClick")

        THIS.AddObject("cmd_4c_Excluir", "CommandButton")
        WITH THIS.cmd_4c_Excluir
            .Top             = 3
            .Left            = 330
            .Width           = 70
            .Height          = 30
            .Caption         = "Excluir"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_excluir_60.jpg"
            .Themes          = .T.
            .DisabledPicture = gc_4c_CaminhoIcones + "cadastro_excluir_60.jpg"
            .FontName        = "Tahoma"
            .FontSize        = 8
            .FontBold        = .T.
            .FontItalic      = .T.
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .SpecialEffect   = 0
            .PicturePosition = 13
            .MousePointer    = 15
            .WordWrap        = .T.
            .AutoSize        = .F.
        ENDWITH
        BINDEVENT(THIS.cmd_4c_Excluir, "Click", THIS, "CmdExcluirClick")

        THIS.AddObject("cmd_4c_Sair", "CommandButton")
        WITH THIS.cmd_4c_Sair
            .Top             = 3
            .Left            = 405
            .Width           = 75
            .Height          = 75
            .Caption         = "Encerrar"
            .Cancel          = .T.
            .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
            .Themes          = .T.
            .DisabledPicture = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
            .FontName        = "Tahoma"
            .FontSize        = 8
            .FontBold        = .T.
            .FontItalic      = .T.
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .SpecialEffect   = 0
            .PicturePosition = 13
            .MousePointer    = 15
            .WordWrap        = .T.
            .AutoSize        = .F.
        ENDWITH
        BINDEVENT(THIS.cmd_4c_Sair, "Click", THIS, "CmdSairClick")
    ENDPROC

    *==========================================================================
    * AjustarVisibilidadeBotoes - Mostra/oculta Inserir e Excluir conforme modo
    * INSERIR/ALTERAR: mostra ambos | CONSULTAR: oculta e ajusta Shape1
    *==========================================================================
    PROTECTED PROCEDURE AjustarVisibilidadeBotoes()
        LOCAL loc_lEdicao
        loc_lEdicao = INLIST(THIS.this_cPcEscolha, "INSERIR", "ALTERAR")

        THIS.cmd_4c_Inserir.Visible = loc_lEdicao
        THIS.cmd_4c_Inserir.Enabled = loc_lEdicao
        THIS.cmd_4c_Excluir.Visible = loc_lEdicao
        THIS.cmd_4c_Excluir.Enabled = loc_lEdicao

        IF !loc_lEdicao
            THIS.shp_4c_Shape1.Width = THIS.cmd_4c_Sair.Width + 10
            THIS.shp_4c_Shape1.Left  = THIS.cmd_4c_Sair.Left - 5
        ENDIF
    ENDPROC

    *==========================================================================
    * CarregarDados - Vincula grid ao cursor_4c_Dados apos BO.Buscar()
    * Redefine RecordSource e reconfigura cabecalhos (resetados por RecordSource)
    *==========================================================================
    PROTECTED PROCEDURE CarregarDados()
        IF !USED("cursor_4c_Dados")
            RETURN
        ENDIF

        THIS.grd_4c_Dados.ColumnCount  = 2
        THIS.grd_4c_Dados.RecordSource = "cursor_4c_Dados"
        THIS.grd_4c_Dados.Column1.ControlSource = "cursor_4c_Dados.codigos"
        THIS.grd_4c_Dados.Column2.ControlSource = "cursor_4c_Dados.descrs"
        *-- Reconfigurar cabecalhos (reset automatico apos alterar RecordSource)
        THIS.grd_4c_Dados.Column1.Header1.Caption   = "Caracter" + CHR(237) + "stica"
        THIS.grd_4c_Dados.Column1.Header1.FontName  = "Tahoma"
        THIS.grd_4c_Dados.Column1.Header1.FontSize  = 8
        THIS.grd_4c_Dados.Column1.Header1.Alignment = 2
        THIS.grd_4c_Dados.Column1.Header1.ForeColor = RGB(90, 90, 90)
        THIS.grd_4c_Dados.Column2.Header1.Caption   = "Descri" + CHR(231) + CHR(227) + "o"
        THIS.grd_4c_Dados.Column2.Header1.FontName  = "Tahoma"
        THIS.grd_4c_Dados.Column2.Header1.FontSize  = 8
        THIS.grd_4c_Dados.Column2.Header1.Alignment = 2
        THIS.grd_4c_Dados.Column2.Header1.ForeColor = RGB(90, 90, 90)

        SELECT cursor_4c_Dados
        GO TOP
        THIS.FormatarGridLista(THIS.grd_4c_Dados)
        THIS.grd_4c_Dados.Refresh()
    ENDPROC

    *==========================================================================
    * CmdInserirClick - Adiciona nova linha vazia ao grid para preenchimento
    * Equivale a cmdInserir.Click do legado (Insert Into crSigPrCar + SetFocus)
    *==========================================================================
    PROCEDURE CmdInserirClick()
        LOCAL loc_oErro

        TRY
            IF !USED("cursor_4c_Dados")
                RETURN
            ENDIF

            THIS.this_lHouveIncl = .T.

            SELECT cursor_4c_Dados
            LOCATE FOR EMPTY(ALLTRIM(NVL(codigos, "")))
            IF EOF()
                *-- Nao existe linha vazia: adicionar nova
                APPEND BLANK IN cursor_4c_Dados
                SELECT cursor_4c_Dados
                GO BOTTOM
                REPLACE cpros WITH THIS.this_cCPros IN cursor_4c_Dados
            ELSE
                *-- Ja existe linha vazia: posicionar nela
                SELECT cursor_4c_Dados
            ENDIF

            THIS.grd_4c_Dados.Refresh()
            THIS.grd_4c_Dados.SetFocus()

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "FormSigPrCar.CmdInserirClick")
        ENDTRY
    ENDPROC

    *==========================================================================
    * CmdExcluirClick - Exclui linha atual do grid
    * Para registros persistidos: SQL DELETE via BO.Excluir()
    * Reconstroi cursor_4c_Dados sem o registro para atualizar grid imediatamente
    *==========================================================================
    PROCEDURE CmdExcluirClick()
        LOCAL loc_cPkChaves, loc_nRecnoAtual, loc_oErro

        TRY
            IF !USED("cursor_4c_Dados") OR EOF("cursor_4c_Dados")
                RETURN
            ENDIF

            SELECT cursor_4c_Dados
            IF ALLTRIM(NVL(cpros, "")) != ALLTRIM(THIS.this_cCPros)
                RETURN
            ENDIF

            loc_cPkChaves  = ALLTRIM(NVL(pkchaves, ""))
            loc_nRecnoAtual = RECNO("cursor_4c_Dados")

            *-- Se registro persistido no SQL Server, excluir la primeiro
            IF !EMPTY(loc_cPkChaves)
                THIS.this_oBusinessObject.this_cPkChaves = loc_cPkChaves
                IF !THIS.this_oBusinessObject.Excluir()
                    RETURN
                ENDIF
            ENDIF

            *-- Reconstruir cursor_4c_Dados sem o registro excluido
            IF USED("cursor_4c_DadosSwap")
                USE IN cursor_4c_DadosSwap
            ENDIF
            SET NULL ON
            CREATE CURSOR cursor_4c_DadosSwap ;
                (codigos C(20) NULL, descrs C(40) NULL, cpros C(14) NULL, pkchaves C(20) NULL)
            SET NULL OFF

            SELECT cursor_4c_Dados
            GO TOP
            DO WHILE !EOF("cursor_4c_Dados")
                IF RECNO("cursor_4c_Dados") != loc_nRecnoAtual
                    SCATTER MEMVAR MEMO
                    SELECT cursor_4c_DadosSwap
                    APPEND BLANK
                    GATHER MEMVAR MEMO
                ENDIF
                SELECT cursor_4c_Dados
                SKIP
            ENDDO

            USE IN cursor_4c_Dados
            SET NULL ON
            CREATE CURSOR cursor_4c_Dados ;
                (codigos C(20) NULL, descrs C(40) NULL, cpros C(14) NULL, pkchaves C(20) NULL)
            SET NULL OFF
            SELECT cursor_4c_Dados
            APPEND FROM DBF("cursor_4c_DadosSwap")
            USE IN cursor_4c_DadosSwap

            *-- Rebind do grid
            THIS.grd_4c_Dados.ColumnCount  = 2
            THIS.grd_4c_Dados.RecordSource = "cursor_4c_Dados"
            THIS.grd_4c_Dados.Column1.ControlSource = "cursor_4c_Dados.codigos"
            THIS.grd_4c_Dados.Column2.ControlSource = "cursor_4c_Dados.descrs"
            THIS.grd_4c_Dados.Column1.Header1.Caption   = "Caracter" + CHR(237) + "stica"
            THIS.grd_4c_Dados.Column1.Header1.FontName  = "Tahoma"
            THIS.grd_4c_Dados.Column1.Header1.FontSize  = 8
            THIS.grd_4c_Dados.Column1.Header1.Alignment = 2
            THIS.grd_4c_Dados.Column1.Header1.ForeColor = RGB(90, 90, 90)
            THIS.grd_4c_Dados.Column2.Header1.Caption   = "Descri" + CHR(231) + CHR(227) + "o"
            THIS.grd_4c_Dados.Column2.Header1.FontName  = "Tahoma"
            THIS.grd_4c_Dados.Column2.Header1.FontSize  = 8
            THIS.grd_4c_Dados.Column2.Header1.Alignment = 2
            THIS.grd_4c_Dados.Column2.Header1.ForeColor = RGB(90, 90, 90)
            THIS.FormatarGridLista(THIS.grd_4c_Dados)

            THIS.this_lHouveExcl = .T.
            SELECT cursor_4c_Dados
            IF !EOF()
                GO TOP
            ENDIF
            THIS.grd_4c_Dados.Refresh()

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "FormSigPrCar.CmdExcluirClick")
        ENDTRY
    ENDPROC

    *==========================================================================
    * CmdSairClick - Persiste alteracoes no SQL Server e fecha o form
    * Em INSERIR/ALTERAR: INSERT novas linhas, UPDATE linhas existentes
    * Em CONSULTAR: apenas reabilita o form pai e fecha
    * Equivale a cmdSair.Click do legado
    *==========================================================================
    PROCEDURE CmdSairClick()
        LOCAL loc_oBO, loc_oErro

        TRY
            IF INLIST(THIS.this_cPcEscolha, "INSERIR", "ALTERAR") AND USED("cursor_4c_Dados")
                loc_oBO = THIS.this_oBusinessObject

                SELECT cursor_4c_Dados
                SCAN FOR !DELETED()
                    IF EMPTY(ALLTRIM(NVL(codigos, "")))
                        LOOP
                    ENDIF

                    loc_oBO.this_cCodigos  = ALLTRIM(NVL(codigos, ""))
                    loc_oBO.this_cCPros    = ALLTRIM(NVL(cpros, THIS.this_cCPros))
                    loc_oBO.this_cDescrs   = ALLTRIM(NVL(descrs, ""))

                    IF EMPTY(ALLTRIM(NVL(pkchaves, "")))
                        *-- Nova caracteristica: INSERT
                        loc_oBO.this_cPkChaves    = ""
                        loc_oBO.this_lEmEdicao    = .T.
                        loc_oBO.this_lNovoRegistro = .T.
                        IF loc_oBO.Salvar()
                            REPLACE pkchaves WITH loc_oBO.this_cPkChaves IN cursor_4c_Dados
                        ENDIF
                    ELSE
                        *-- Caracteristica existente: UPDATE (garante que lookup editados sejam salvos)
                        loc_oBO.this_cPkChaves    = ALLTRIM(NVL(pkchaves, ""))
                        loc_oBO.this_lEmEdicao    = .T.
                        loc_oBO.this_lNovoRegistro = .F.
                        loc_oBO.Salvar()
                    ENDIF
                ENDSCAN
            ENDIF

            *-- Reabilitar form pai antes de fechar
            IF VARTYPE(THIS.this_oFormPai) = "O"
                THIS.this_oFormPai.Enabled = .T.
            ENDIF

            THIS.Release()

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "FormSigPrCar.CmdSairClick")
        ENDTRY
    ENDPROC

    *==========================================================================
    * TxtCodigosKeyPress - KeyPress no Column1 (Codigo) do grid
    * ENTER(13)/TAB(9)/F4(115): abre FormBuscaAuxiliar por codigo na SigCrRap
    * Filtro: CGrus do produto (equivale ao fwBuscaExt do legado)
    * Verifica duplicidade antes de aceitar a selecao
    *==========================================================================
    PROCEDURE TxtCodigosKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oBusca, loc_cValorAtual, loc_cPkChavesAtual
        LOCAL loc_cCodSel, loc_cDescSel, loc_cFiltro, loc_cTitulo, loc_oErro

        IF par_nKeyCode != 13 AND par_nKeyCode != 9 AND par_nKeyCode != 115
            RETURN
        ENDIF

        TRY
            IF !USED("cursor_4c_Dados") OR EOF("cursor_4c_Dados")
                RETURN
            ENDIF

            loc_cValorAtual    = ALLTRIM(NVL(THIS.grd_4c_Dados.Column1.Text1.Value, ""))
            loc_cPkChavesAtual = ALLTRIM(NVL(cursor_4c_Dados.pkchaves, ""))

            IF EMPTY(loc_cValorAtual)
                REPLACE codigos WITH "" IN cursor_4c_Dados
                REPLACE descrs  WITH "" IN cursor_4c_Dados
                THIS.grd_4c_Dados.Column1.Text1.Value = ""
                THIS.grd_4c_Dados.Column2.Text1.Value = ""
                THIS.grd_4c_Dados.Refresh()
                RETURN
            ENDIF

            loc_cFiltro = "CGrus IN (" + EscaparSQL(THIS.this_cCGrus) + ", '   ')"
            loc_cTitulo = "Sele" + CHR(231) + CHR(227) + "o"

            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigCrRap", "cursor_4c_Busca", "codigos", loc_cValorAtual, ;
                loc_cTitulo, .F., .F., loc_cFiltro)

            IF VARTYPE(loc_oBusca) = "O"
                IF !loc_oBusca.this_lAchouRegistro
                    loc_oBusca.mAddColuna("codigos", "", "C" + CHR(243) + "digo")
                    loc_oBusca.mAddColuna("descrs",  "", "Descri" + CHR(231) + CHR(227) + "o")
                    loc_oBusca.Show()
                ENDIF

                IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_Busca")
                    SELECT cursor_4c_Busca
                    loc_cCodSel  = ALLTRIM(NVL(codigos, ""))
                    loc_cDescSel = ALLTRIM(NVL(descrs, ""))
                    SELECT cursor_4c_Dados

                    IF THIS.this_oBusinessObject.ValidarCaracteristicaDuplicada( ;
                            loc_cCodSel, THIS.this_cCPros, loc_cPkChavesAtual)
                        MsgAviso("Caracter" + CHR(237) + "stica j" + CHR(225) + ;
                                 " informada para este produto!", ;
                                 "Aten" + CHR(231) + CHR(227) + "o")
                        REPLACE codigos WITH "" IN cursor_4c_Dados
                        REPLACE descrs  WITH "" IN cursor_4c_Dados
                        THIS.grd_4c_Dados.Column1.Text1.Value = ""
                        THIS.grd_4c_Dados.Column2.Text1.Value = ""
                    ELSE
                        REPLACE codigos WITH loc_cCodSel  IN cursor_4c_Dados
                        REPLACE descrs  WITH loc_cDescSel IN cursor_4c_Dados
                        THIS.grd_4c_Dados.Column1.Text1.Value = loc_cCodSel
                        THIS.grd_4c_Dados.Column2.Text1.Value = loc_cDescSel
                    ENDIF
                ELSE
                    REPLACE codigos WITH "" IN cursor_4c_Dados
                    REPLACE descrs  WITH "" IN cursor_4c_Dados
                    THIS.grd_4c_Dados.Column1.Text1.Value = ""
                    THIS.grd_4c_Dados.Column2.Text1.Value = ""
                ENDIF

                loc_oBusca.Release()
            ENDIF

            IF USED("cursor_4c_Busca")
                USE IN cursor_4c_Busca
            ENDIF

            THIS.grd_4c_Dados.Refresh()

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "FormSigPrCar.TxtCodigosKeyPress")
        ENDTRY
    ENDPROC

    *==========================================================================
    * TxtDescrsKeyPress - KeyPress no Column2 (Descricao) do grid
    * ENTER(13)/TAB(9)/F4(115): abre FormBuscaAuxiliar por descricao na SigCrRap
    * Condicao (equivale ao When do legado): so ativo quando Column1 esta vazio
    *==========================================================================
    PROCEDURE TxtDescrsKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oBusca, loc_cValorAtual, loc_cPkChavesAtual
        LOCAL loc_cCodSel, loc_cDescSel, loc_cFiltro, loc_cTitulo, loc_oErro

        IF par_nKeyCode != 13 AND par_nKeyCode != 9 AND par_nKeyCode != 115
            RETURN
        ENDIF

        TRY
            IF !USED("cursor_4c_Dados") OR EOF("cursor_4c_Dados")
                RETURN
            ENDIF

            *-- Column2 so e operacional quando Column1 esta vazio (legado: When condition)
            IF !EMPTY(ALLTRIM(NVL(cursor_4c_Dados.codigos, "")))
                RETURN
            ENDIF

            loc_cValorAtual    = ALLTRIM(NVL(THIS.grd_4c_Dados.Column2.Text1.Value, ""))
            loc_cPkChavesAtual = ALLTRIM(NVL(cursor_4c_Dados.pkchaves, ""))

            IF EMPTY(loc_cValorAtual)
                REPLACE codigos WITH "" IN cursor_4c_Dados
                REPLACE descrs  WITH "" IN cursor_4c_Dados
                THIS.grd_4c_Dados.Column1.Text1.Value = ""
                THIS.grd_4c_Dados.Column2.Text1.Value = ""
                THIS.grd_4c_Dados.Refresh()
                RETURN
            ENDIF

            loc_cFiltro = "CGrus IN (" + EscaparSQL(THIS.this_cCGrus) + ", '   ')"
            loc_cTitulo = "Sele" + CHR(231) + CHR(227) + "o"

            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigCrRap", "cursor_4c_Busca", "descrs", loc_cValorAtual, ;
                loc_cTitulo, .F., .F., loc_cFiltro)

            IF VARTYPE(loc_oBusca) = "O"
                IF !loc_oBusca.this_lAchouRegistro
                    loc_oBusca.mAddColuna("descrs",  "", "Descri" + CHR(231) + CHR(227) + "o")
                    loc_oBusca.mAddColuna("codigos", "", "C" + CHR(243) + "digo")
                    loc_oBusca.Show()
                ENDIF

                IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_Busca")
                    SELECT cursor_4c_Busca
                    loc_cCodSel  = ALLTRIM(NVL(codigos, ""))
                    loc_cDescSel = ALLTRIM(NVL(descrs, ""))
                    SELECT cursor_4c_Dados

                    IF THIS.this_oBusinessObject.ValidarCaracteristicaDuplicada( ;
                            loc_cCodSel, THIS.this_cCPros, loc_cPkChavesAtual)
                        MsgAviso("Caracter" + CHR(237) + "stica j" + CHR(225) + ;
                                 " informada para este produto!", ;
                                 "Aten" + CHR(231) + CHR(227) + "o")
                        REPLACE codigos WITH "" IN cursor_4c_Dados
                        REPLACE descrs  WITH "" IN cursor_4c_Dados
                        THIS.grd_4c_Dados.Column1.Text1.Value = ""
                        THIS.grd_4c_Dados.Column2.Text1.Value = ""
                    ELSE
                        REPLACE codigos WITH loc_cCodSel  IN cursor_4c_Dados
                        REPLACE descrs  WITH loc_cDescSel IN cursor_4c_Dados
                        THIS.grd_4c_Dados.Column1.Text1.Value = loc_cCodSel
                        THIS.grd_4c_Dados.Column2.Text1.Value = loc_cDescSel
                    ENDIF
                ELSE
                    REPLACE codigos WITH "" IN cursor_4c_Dados
                    REPLACE descrs  WITH "" IN cursor_4c_Dados
                    THIS.grd_4c_Dados.Column1.Text1.Value = ""
                    THIS.grd_4c_Dados.Column2.Text1.Value = ""
                ENDIF

                loc_oBusca.Release()
            ENDIF

            IF USED("cursor_4c_Busca")
                USE IN cursor_4c_Busca
            ENDIF

            THIS.grd_4c_Dados.Refresh()

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "FormSigPrCar.TxtDescrsKeyPress")
        ENDTRY
    ENDPROC

    *==========================================================================
    * FormatarGridLista - Formata fonte das colunas do grid
    * Chamado apos rebind de RecordSource para garantir consistencia visual
    *==========================================================================
    PROTECTED PROCEDURE FormatarGridLista(par_oGrid)
        WITH par_oGrid
            .FontName = "Tahoma"
            .FontSize = 8
        ENDWITH
    ENDPROC

    *==========================================================================
    * BtnIncluirClick - Override do FormBase: delega a CmdInserirClick
    * Este form OPERACIONAL usa cmd_4c_Inserir (nao o botao CRUD padrao).
    * Override garante que chamadas via FormBase nao disparem comportamento CRUD.
    *==========================================================================
    PROCEDURE BtnIncluirClick()
        IF INLIST(THIS.this_cPcEscolha, "INSERIR", "ALTERAR")
            THIS.CmdInserirClick()
        ENDIF
    ENDPROC

    *==========================================================================
    * BtnAlterarClick - Override do FormBase: nao aplicavel neste OPERACIONAL
    * Edicao ocorre diretamente nas celulas do grid (inline editing).
    * Override previne comportamento CRUD padrao do FormBase.
    *==========================================================================
    PROCEDURE BtnAlterarClick()
        IF INLIST(THIS.this_cPcEscolha, "INSERIR", "ALTERAR") AND VARTYPE(THIS.grd_4c_Dados) = "O"
            THIS.grd_4c_Dados.SetFocus()
        ENDIF
    ENDPROC

    *==========================================================================
    * BtnVisualizarClick - Override do FormBase: nao aplicavel neste OPERACIONAL
    * Form OPERACIONAL nao possui modo VISUALIZAR separado - o grid sempre exibe
    * os dados carregados. Override previne comportamento CRUD padrao do FormBase.
    *==========================================================================
    PROCEDURE BtnVisualizarClick()
        IF VARTYPE(THIS.grd_4c_Dados) = "O"
            THIS.grd_4c_Dados.Refresh()
        ENDIF
    ENDPROC

    *==========================================================================
    * BtnExcluirClick - Override do FormBase: delega a CmdExcluirClick
    * Este form OPERACIONAL usa cmd_4c_Excluir (nao o botao CRUD padrao).
    * Override garante que chamadas via FormBase nao disparem comportamento CRUD.
    *==========================================================================
    PROCEDURE BtnExcluirClick()
        IF INLIST(THIS.this_cPcEscolha, "INSERIR", "ALTERAR")
            THIS.CmdExcluirClick()
        ENDIF
    ENDPROC

    *==========================================================================
    * BtnBuscarClick - Override do FormBase: recarrega lista via BO.Buscar
    * Pesquisa ocorre via lookup inline no grid (TxtCodigosKeyPress /
    * TxtDescrsKeyPress); este override recarrega os dados do produto.
    *==========================================================================
    PROCEDURE BtnBuscarClick()
        THIS.CarregarLista()
    ENDPROC

    *==========================================================================
    * BtnEncerrarClick - Override do FormBase: delega a CmdSairClick
    * CmdSairClick persiste dados (INSERT/UPDATE) e fecha o form corretamente.
    *==========================================================================
    PROCEDURE BtnEncerrarClick()
        THIS.CmdSairClick()
    ENDPROC

    *==========================================================================
    * BtnSalvarClick - Override do FormBase: delega a CmdSairClick
    * Neste form OPERACIONAL salvar equivale a encerrar (persiste e fecha).
    *==========================================================================
    PROCEDURE BtnSalvarClick()
        THIS.CmdSairClick()
    ENDPROC

    *==========================================================================
    * BtnCancelarClick - Override do FormBase: fecha sem persistir alteracoes
    * Reabilita o form pai antes de fechar (simetrico ao CmdSairClick).
    *==========================================================================
    PROCEDURE BtnCancelarClick()
        IF VARTYPE(THIS.this_oFormPai) = "O"
            TRY
                THIS.this_oFormPai.Enabled = .T.
            CATCH
            ENDTRY
        ENDIF
        THIS.Release()
    ENDPROC

    *==========================================================================
    * FormParaBO - Override do FormBase: nao aplicavel neste OPERACIONAL
    * A populacao do BO ocorre no SCAN loop do CmdSairClick, linha a linha
    * do cursor_4c_Dados, e nao no padrao FormParaBO unico do frmcadastro.
    *==========================================================================
    PROCEDURE FormParaBO()
        RETURN .T.
    ENDPROC

    *==========================================================================
    * BOParaForm - Override do FormBase: delega a CarregarDados
    * Exibe no grid os dados do cursor_4c_Dados populado por BO.Buscar().
    *==========================================================================
    PROCEDURE BOParaForm()
        THIS.CarregarDados()
        RETURN .T.
    ENDPROC

    *==========================================================================
    * HabilitarCampos - Controla editabilidade do grid conforme modo
    * INSERIR/ALTERAR -> grid editavel | CONSULTAR -> grid somente leitura
    * par_lHabilitar: se omitido, deriva do this_cPcEscolha atual
    *==========================================================================
    PROCEDURE HabilitarCampos(par_lHabilitar)
        LOCAL loc_lEdicao

        IF VARTYPE(par_lHabilitar) = "L"
            loc_lEdicao = par_lHabilitar
        ELSE
            loc_lEdicao = INLIST(THIS.this_cPcEscolha, "INSERIR", "ALTERAR")
        ENDIF

        IF VARTYPE(THIS.grd_4c_Dados) = "O"
            THIS.grd_4c_Dados.Column1.ReadOnly = !loc_lEdicao
            THIS.grd_4c_Dados.Column2.ReadOnly = !loc_lEdicao
        ENDIF
    ENDPROC

    *==========================================================================
    * LimparCampos - Limpa o cursor de dados do grid
    * Chamado ao inicializar modo INCLUIR ou ao cancelar uma operacao.
    *==========================================================================
    PROCEDURE LimparCampos()
        IF USED("cursor_4c_Dados")
            SELECT cursor_4c_Dados
            ZAP
            IF VARTYPE(THIS.grd_4c_Dados) = "O"
                THIS.grd_4c_Dados.Refresh()
            ENDIF
        ENDIF
    ENDPROC

    *==========================================================================
    * CarregarLista - Carrega caracteristicas do produto via BO.Buscar
    * Chamado na inicializacao e sempre que os dados precisam ser recarregados.
    *==========================================================================
    PROCEDURE CarregarLista()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        IF !EMPTY(THIS.this_cCPros) AND VARTYPE(THIS.this_oBusinessObject) = "O"
            IF THIS.this_oBusinessObject.Buscar(THIS.this_cCPros)
                THIS.CarregarDados()
                loc_lSucesso = .T.
            ENDIF
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * AjustarBotoesPorModo - Override do FormBase: delega a AjustarVisibilidadeBotoes
    * FormBase pode chamar este metodo apos mudanca de modo; este form
    * controla visibilidade pelo this_cPcEscolha via AjustarVisibilidadeBotoes.
    *==========================================================================
    PROCEDURE AjustarBotoesPorModo()
        THIS.AjustarVisibilidadeBotoes()
    ENDPROC

ENDDEFINE


### BO (C:\4c\projeto\app\classes\SigPrCarBO.prg):
*==============================================================================
* SigPrCarBO.prg - Business Object para Caracter" + CHR(237) + "sticas do Produto
* Data: 2026-07-01
* Tabela: sigprcar | PK: pkchaves
* Relacionamento: sigprcar JOIN SIGCRRAP (para descrs)
* Filtro lookup: SIGCRRAP.cgrus = produto.cgrus
*==============================================================================

DEFINE CLASS SigPrCarBO AS BusinessBase

    *-- Propriedades persistidas (tabela sigprcar)
    this_cCodigos   = ""    && codigos   CHAR(20) - C" + CHR(243) + "digo da caracter" + CHR(237) + "stica (FK -> SIGCRRAP)
    this_cCPros     = ""    && cpros     CHAR(14) - C" + CHR(243) + "digo do produto (FK)
    this_cPkChaves  = ""    && pkchaves  CHAR(20) - Chave prim" + CHR(225) + "ria

    *-- Propriedades auxiliares (n" + CHR(227) + "o persistidas - carregadas via JOIN)
    this_cDescrs    = ""    && SIGCRRAP.descrs  CHAR(40) - Descri" + CHR(231) + CHR(227) + "o da caracter" + CHR(237) + "stica
    this_cCGrus     = ""    && produto.cgrus    CHAR(3)  - Grupo (filtro do lookup SigCrRap)

    *--------------------------------------------------------------------------
    * Init - Inicializa o Business Object
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        DODEFAULT()
        THIS.this_cTabela     = "sigprcar"
        THIS.this_cCampoChave = "pkchaves"
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Retorna chave prim" + CHR(225) + "ria para auditoria
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ObterChavePrimaria()
        RETURN THIS.this_cPkChaves
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Carrega propriedades do BO a partir de cursor
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        IF USED(par_cAliasCursor)
            SELECT (par_cAliasCursor)
            THIS.this_cCodigos  = TratarNulo(codigos, "C")
            THIS.this_cCPros    = TratarNulo(cpros, "C")
            THIS.this_cPkChaves = TratarNulo(pkchaves, "C")
            IF TYPE("descrs") != "U"
                THIS.this_cDescrs = TratarNulo(descrs, "C")
            ENDIF
            RETURN .T.
        ENDIF
        RETURN .F.
    ENDPROC

    *--------------------------------------------------------------------------
    * Buscar - Carrega caracter" + CHR(237) + "sticas de um produto do SQL Server
    * par_cCPros: c" + CHR(243) + "digo do produto (obrigat" + CHR(243) + "rio)
    * Popula cursor_4c_Dados com JOIN em SIGCRRAP para obter descri" + CHR(231) + CHR(227) + "o
    *--------------------------------------------------------------------------
    PROCEDURE Buscar(par_cCPros)
        LOCAL loc_lSucesso, loc_cSQL, loc_oErro

        loc_lSucesso = .F.

        TRY
            IF USED("cursor_4c_Dados")
                TABLEREVERT(.T., "cursor_4c_Dados")
                USE IN cursor_4c_Dados
            ENDIF

            IF USED("cursor_4c_DadosTemp")
                USE IN cursor_4c_DadosTemp
            ENDIF

            loc_cSQL = "SELECT p.codigos, r.descrs, p.cpros, p.pkchaves " + ;
                       "FROM sigprcar p " + ;
                       "LEFT JOIN SIGCRRAP r ON r.codigos = p.codigos " + ;
                       "WHERE p.cpros = " + EscaparSQL(par_cCPros) + " " + ;
                       "ORDER BY r.descrs"

            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_DadosTemp") > 0
                SET NULL ON
                CREATE CURSOR cursor_4c_Dados ;
                    (codigos C(20) NULL, descrs C(40) NULL, cpros C(14) NULL, pkchaves C(20) NULL)
                SET NULL OFF

                SELECT cursor_4c_Dados
                APPEND FROM DBF("cursor_4c_DadosTemp")
                USE IN cursor_4c_DadosTemp

                SELECT cursor_4c_Dados
                GO TOP
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao carregar caracter" + CHR(237) + "sticas do produto.", "SigPrCarBO.Buscar")
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "SigPrCarBO.Buscar")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarCaracteristicaDuplicada - Verifica se caracter" + CHR(237) + "stica j" + CHR(225) + " existe
    * para o produto (excluindo o registro atual em edi" + CHR(231) + CHR(227) + "o)
    * Retorna .T. se duplicada (j" + CHR(225) + " existe), .F. se " + CHR(250) + "nica
    *--------------------------------------------------------------------------
    PROCEDURE ValidarCaracteristicaDuplicada(par_cCodigos, par_cCPros, par_cPkChavesAtual)
        LOCAL loc_cSQL, loc_lDuplicado, loc_oErro

        loc_lDuplicado = .F.

        TRY
            loc_cSQL = "SELECT COUNT(*) AS nExiste " + ;
                       "FROM sigprcar " + ;
                       "WHERE codigos = " + EscaparSQL(par_cCodigos) + " " + ;
                       "AND cpros = " + EscaparSQL(par_cCPros)

            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_DupCheck") > 0
                SELECT cursor_4c_DupCheck
                loc_lDuplicado = NVL(nExiste, 0) > 0
                USE IN cursor_4c_DupCheck
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "SigPrCarBO.ValidarCaracteristicaDuplicada")
        ENDTRY

        RETURN loc_lDuplicado
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarDados - Valida dados antes de Inserir/Atualizar
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ValidarDados()
        IF EMPTY(ALLTRIM(THIS.this_cCodigos))
            MsgAviso("Informe o c" + CHR(243) + "digo da caracter" + CHR(237) + "stica.", ;
                     "Valida" + CHR(231) + CHR(227) + "o")
            RETURN .F.
        ENDIF

        IF EMPTY(ALLTRIM(THIS.this_cCPros))
            MsgAviso("C" + CHR(243) + "digo do produto n" + CHR(227) + "o informado.", ;
                     "Valida" + CHR(231) + CHR(227) + "o")
            RETURN .F.
        ENDIF

        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir - Insere nova caracter" + CHR(237) + "stica no SQL Server
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Inserir()
        LOCAL loc_lSucesso, loc_cSQL, loc_oErro

        loc_lSucesso = .F.

        TRY
            IF !THIS.ValidarDados()
                loc_lSucesso = .F.
            ENDIF

            *-- Gera chave prim" + CHR(225) + "ria se n" + CHR(227) + "o informada
            IF EMPTY(ALLTRIM(THIS.this_cPkChaves))
                THIS.this_cPkChaves = LEFT(SYS(2015) + SYS(2015), 20)
            ENDIF

            loc_cSQL = "INSERT INTO sigprcar " + ;
                       "(codigos, cpros, pkchaves) " + ;
                       "VALUES (" + ;
                       EscaparSQL(THIS.this_cCodigos) + ", " + ;
                       EscaparSQL(THIS.this_cCPros) + ", " + ;
                       EscaparSQL(THIS.this_cPkChaves) + ")"

            IF SQLEXEC(gnConnHandle, loc_cSQL) > 0
                THIS.RegistrarAuditoria("INSERIR")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao inserir caracter" + CHR(237) + "stica.", "SigPrCarBO.Inserir")
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "SigPrCarBO.Inserir")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - Atualiza c" + CHR(243) + "digo da caracter" + CHR(237) + "stica no SQL Server
    * (descrs n" + CHR(227) + "o " + CHR(233) + " persistida - vem de JOIN com SIGCRRAP)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Atualizar()
        LOCAL loc_lSucesso, loc_cSQL, loc_oErro

        loc_lSucesso = .F.

        TRY
            IF !THIS.ValidarDados()
                loc_lSucesso = .F.
            ENDIF

            IF EMPTY(ALLTRIM(THIS.this_cPkChaves))
                MsgAviso("Caracter" + CHR(237) + "stica sem chave prim" + CHR(225) + "ria.", ;
                         "Valida" + CHR(231) + CHR(227) + "o")
                loc_lSucesso = .F.
            ENDIF

            loc_cSQL = "UPDATE sigprcar " + ;
                       "SET codigos = " + EscaparSQL(THIS.this_cCodigos) + " " + ;
                       "WHERE pkchaves = " + EscaparSQL(THIS.this_cPkChaves)

            IF SQLEXEC(gnConnHandle, loc_cSQL) > 0
                THIS.RegistrarAuditoria("ALTERAR")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao atualizar caracter" + CHR(237) + "stica.", "SigPrCarBO.Atualizar")
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "SigPrCarBO.Atualizar")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ExecutarExclusao - Exclui caracter" + CHR(237) + "stica do SQL Server
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ExecutarExclusao()
        LOCAL loc_lSucesso, loc_cSQL, loc_oErro

        loc_lSucesso = .F.

        TRY
            IF EMPTY(ALLTRIM(THIS.this_cPkChaves))
                MsgAviso("Nenhuma caracter" + CHR(237) + "stica selecionada para exclus" + CHR(227) + "o.", ;
                         "Valida" + CHR(231) + CHR(227) + "o")
                loc_lSucesso = .F.
            ENDIF

            loc_cSQL = "DELETE FROM sigprcar " + ;
                       "WHERE pkchaves = " + EscaparSQL(THIS.this_cPkChaves)

            IF SQLEXEC(gnConnHandle, loc_cSQL) > 0
                THIS.RegistrarAuditoria("EXCLUIR")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao excluir caracter" + CHR(237) + "stica.", "SigPrCarBO.ExecutarExclusao")
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "SigPrCarBO.ExecutarExclusao")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

ENDDEFINE


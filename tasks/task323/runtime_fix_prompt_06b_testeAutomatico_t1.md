# CORRIGIR ERRO DE RUNTIME VFP9

## TAREFA OBRIGATORIA
O formulario VFP9 apresentou erro de runtime durante teste automatizado.
Voce DEVE corrigir o erro e salvar os arquivos corrigidos usando Write tool.

## ERRO DETECTADO
- Etapa: 06b_testeAutomatico
- Tentativa: 1/10
- Mensagem: Testes automaticos: 0% < 100%. Falhas: Teste 'Instanciacao': Function argument value, type, or count is invalid. | Detalhes: Linha: 47, Proc: init

## CONTEXTO DO ERRO

### LOG DA ETAPA (06b_testeAutomatico):
[2026-07-18 09:35:35] [INFO] === VFP EXECUTOR v2.0 ===
[2026-07-18 09:35:35] [INFO] Config FPW: (nao fornecido)
[2026-07-18 09:35:35] [INFO] Script PRG: C:\4c\projeto\app\utils\TesteAutomatico.prg
[2026-07-18 09:35:35] [INFO] Timeout: 300 segundos
[2026-07-18 09:35:35] [INFO] Wrapper PRG criado para parametros: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_3i3bmmbh.prg
[2026-07-18 09:35:35] [INFO] Conteudo do wrapper:
[2026-07-18 09:35:35] [INFO] * Auto-generated wrapper for parameters
* Script: C:\4c\projeto\app\utils\TesteAutomatico.prg
* Parameters: 'FormSIGPRPRO', 'C:\4c\tasks\task323', 'OPERACIONAL'

* Anti-dialog protections for unattended execution
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
SET NOTIFY OFF
SYS(2335, 0)

DO "C:\4c\projeto\app\utils\TesteAutomatico" WITH 'FormSIGPRPRO', 'C:\4c\tasks\task323', 'OPERACIONAL'
QUIT

[2026-07-18 09:35:35] [INFO] Comando VFP: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_3i3bmmbh.prg
[2026-07-18 09:35:35] [INFO] VFP output esperado em: C:\4c\tasks\task323\vfp_output.txt
[2026-07-18 09:35:35] [INFO] Executando Visual FoxPro 9...
[2026-07-18 09:35:35] [INFO] Comando completo: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_3i3bmmbh.prg
[2026-07-18 09:35:35] [INFO] Executando: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_3i3bmmbh.prg
[2026-07-18 09:35:35] [INFO] Timeout configurado: 300 segundos
[2026-07-18 09:36:02] [INFO] VFP9 finalizou normalmente com exit code: 
[2026-07-18 09:36:02] [INFO] VFP9 finalizado em 27.2431984 segundos
[2026-07-18 09:36:02] [INFO] Exit Code: 
[2026-07-18 09:36:02] [INFO] 
[2026-07-18 09:36:02] [INFO] Arquivos temporarios preservados para inspecao:
[2026-07-18 09:36:02] [INFO]   Wrapper.prg: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_3i3bmmbh.prg
[2026-07-18 09:36:02] [INFO] 
[2026-07-18 09:36:02] [INFO] === Conteudo do Wrapper.prg temporario ===
[2026-07-18 09:36:02] [INFO] * Auto-generated wrapper for parameters
[2026-07-18 09:36:02] [INFO] * Script: C:\4c\projeto\app\utils\TesteAutomatico.prg
[2026-07-18 09:36:02] [INFO] * Parameters: 'FormSIGPRPRO', 'C:\4c\tasks\task323', 'OPERACIONAL'
[2026-07-18 09:36:02] [INFO] 
[2026-07-18 09:36:02] [INFO] * Anti-dialog protections for unattended execution
[2026-07-18 09:36:02] [INFO] SET SAFETY OFF
[2026-07-18 09:36:02] [INFO] SET RESOURCE OFF
[2026-07-18 09:36:02] [INFO] SET TALK OFF
[2026-07-18 09:36:02] [INFO] SET NOTIFY OFF
[2026-07-18 09:36:02] [INFO] SYS(2335, 0)
[2026-07-18 09:36:02] [INFO] 
[2026-07-18 09:36:02] [INFO] DO "C:\4c\projeto\app\utils\TesteAutomatico" WITH 'FormSIGPRPRO', 'C:\4c\tasks\task323', 'OPERACIONAL'
[2026-07-18 09:36:02] [INFO] QUIT
[2026-07-18 09:36:02] [INFO] 
[2026-07-18 09:36:02] [INFO] === Fim do Wrapper.prg ===
[2026-07-18 09:36:02] [WARN] AVISO: VFP9 retornou exit code  (normal para VFP9 GUI - validar pelo arquivo de saida)


### RESULTADO DOS TESTES (teste_resultado.json):
{
  "formClass": "FormSIGPRPRO",
  "timestamp": "20260718093602",
  "testes": [
    {
      "nome": "Instanciacao",
      "passou": false,
      "erro": "Function argument value, type, or count is invalid.",
      "detalhes": "Linha: 47, Proc: init"
    }
  ],
  "resumo": {
    "total": 1,
    "passou": 0,
    "falhou": 1,
    "percentual": 0
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

### FORM (C:\4c\projeto\app\forms\operacionais\FormSIGPRPRO.prg):
*==============================================================================
* FormSIGPRPRO.prg - Formulario OPERACIONAL: Caracteristicas de Produtos
* Equivalente ao SIGPRPRO.SCX do legado
* Herda de FormBase
* FASE 6/8: Form completo - sem lookups (form somente-leitura: getCPros/getDPros/
*           getComples/GetMemo todos com When=.F. no original, apenas OK fecha)
*           Campos: shpShape + shpCodigo + shpShape1 + lbl"Produto" + txt_CPros +
*                   txt_DPros + grd_Dados(col Caracteris) + txt_Comples + edt_Infos
*           Eventos: GrdDadosAfterRowColChange (Comples+Infos), CmdOkClick (Release)
*==============================================================================

DEFINE CLASS FormSIGPRPRO AS FormBase

    *-- Dimensoes (proporcional ao original 800x500 escalado para 1000x600)
    Width       = 1000
    Height      = 600

    *-- Aparencia (reproduz propriedades visuais do SCX legado)
    Caption     = "Caracter" + CHR(237) + "sticas de Produtos"
    TitleBar    = 0
    ShowWindow  = 1
    WindowType  = 1
    ControlBox  = .F.
    Closable    = .F.
    MaxButton   = .F.
    MinButton   = .F.
    AutoCenter  = .T.
    BorderStyle = 2
    Themes      = .F.
    ShowTips    = .T.
    Movable     = .F.

    *-- Sessao privada (DataSession=2 - locale corrigido por FormBase.Init)
    DataSession = 2

    *-- Estado do form
    this_oParentForm = .NULL.   && Form pai recebido no Init (reservado p/ uso futuro)
    this_cCPros      = ""       && Codigo do produto recebido no Init

    *---------------------------------------------------------------------------
    PROCEDURE Init(par_oFrm, par_cCPros)
    *-- Captura parametros antes de DODEFAULT() que chama InicializarForm()
    *---------------------------------------------------------------------------
        LOCAL loc_lOk

        THIS.this_oParentForm = par_oFrm
        THIS.this_cCPros      = ALLTRIM(NVL(par_cCPros, ""))

        loc_lOk = DODEFAULT()
        RETURN loc_lOk
    ENDPROC

    *---------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPageFrame()
    *-- Form OPERACIONAL plano (sem PageFrame): define aparencia base do form
    *---------------------------------------------------------------------------
        THIS.Picture    = gc_4c_CaminhoIcones + "new_background.jpg"
        THIS.ScrollBars = 0
    ENDPROC

    *---------------------------------------------------------------------------
    PROTECTED PROCEDURE InicializarForm()
    *---------------------------------------------------------------------------
        LOCAL loc_lSucesso, loc_oErro, loc_cErroParam

        loc_lSucesso  = .F.
        loc_cErroParam = ""

        TRY
            *-- Validar parametro obrigatorio (antes de qualquer operacao)
            IF EMPTY(THIS.this_cCPros)
                loc_cErroParam = "C" + CHR(243) + "digo do produto n" + CHR(227) + "o informado."
            ENDIF

            IF EMPTY(loc_cErroParam)
                *-- Aparencia base
                THIS.ConfigurarPageFrame()

                *-- Inicializar Business Object
                THIS.this_oBusinessObject = CREATEOBJECT("SIGPRPROBO")
                IF VARTYPE(THIS.this_oBusinessObject) != "O"
                    loc_cErroParam = "Falha ao criar SIGPRPROBO."
                ENDIF
            ENDIF

            IF EMPTY(loc_cErroParam)
                *-- Carregar descricao do produto
                THIS.this_oBusinessObject.BuscarDadosProduto(THIS.this_cCPros)

                *-- Criar cursor placeholder para o grid (estrutura identica ao SQLEXEC do BO)
                IF USED("cursor_4c_Carac")
                    TABLEREVERT(.T., "cursor_4c_Carac")
                    USE IN cursor_4c_Carac
                ENDIF
                SET NULL ON
                CREATE CURSOR cursor_4c_Carac ;
                    (cidchaves  C(20), ;
                     caracteris C(40), ;
                     compls     C(40), ;
                     infos      M)
                SET NULL OFF

                *-- Criar componentes visuais
                THIS.ConfigurarCabecalho()
                THIS.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
                THIS.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption

                *-- Criar area de exibicao do produto (shapes decorativos + codigo)
                THIS.ConfigurarPaginaLista()
                *-- Criar area de conteudo (grid + complemento + memo + botao OK)
                THIS.ConfigurarPaginaDados()

                *-- Tornar controles visiveis (AddObject cria com Visible=.F.)
                THIS.TornarControlesVisiveis(THIS)

                *-- Carregar dados (popula grid e campos)
                THIS.CarregarDados()

                loc_lSucesso = .T.
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " | LN=" + TRANSFORM(loc_oErro.LineNo) + ;
                    " | PROC=" + loc_oErro.Procedure, "Erro ao inicializar form")
        ENDTRY

        IF !EMPTY(loc_cErroParam)
            MsgErro(loc_cErroParam, "Erro")
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *---------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarCabecalho()
    *-- Cria container de cabecalho (equivalente ao cntSombra do legado)
    *-- Original: Top=0, Left=0, Width=800, Height=80 -> escalado para 1000x96
    *---------------------------------------------------------------------------
        LOCAL loc_oCab

        THIS.AddObject("cnt_4c_Cabecalho", "Container")
        WITH THIS.cnt_4c_Cabecalho
            .Top         = 0
            .Left        = 0
            .Width       = THIS.Width
            .Height      = 96
            .BackStyle   = 1
            .BackColor   = RGB(100, 100, 100)
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH

        *-- Label sombra (efeito de sombra no texto do titulo)
        *-- Original: Top=25, Left=10, FontSize=18, ForeColor=0,0,0 -> sombra preta
        loc_oCab = THIS.cnt_4c_Cabecalho
        loc_oCab.AddObject("lbl_4c_Sombra", "Label")
        WITH loc_oCab.lbl_4c_Sombra
            .Top       = 30
            .Left      = 12
            .Width     = loc_oCab.Width - 140
            .Height    = 48
            .FontName  = "Tahoma"
            .FontSize  = 18
            .FontBold  = .T.
            .AutoSize  = .F.
            .WordWrap  = .T.
            .BackStyle = 0
            .ForeColor = RGB(0, 0, 0)
            .Caption   = THIS.Caption
            .Visible   = .T.
        ENDWITH

        *-- Label titulo (texto principal branco sobre a sombra)
        *-- Original: Top=24, Left=10, FontSize=18, ForeColor=255,255,255
        loc_oCab.AddObject("lbl_4c_Titulo", "Label")
        WITH loc_oCab.lbl_4c_Titulo
            .Top       = 29
            .Left      = 12
            .Width     = loc_oCab.Width - 140
            .Height    = 55
            .FontName  = "Tahoma"
            .FontSize  = 18
            .FontBold  = .T.
            .AutoSize  = .F.
            .WordWrap  = .T.
            .BackStyle = 0
            .ForeColor = RGB(255, 255, 255)
            .Caption   = THIS.Caption
            .Visible   = .T.
        ENDWITH
    ENDPROC

    *---------------------------------------------------------------------------
    PROCEDURE TornarControlesVisiveis(par_oContainer)
    *-- Torna todos os controles visiveis recursivamente apos AddObject
    *---------------------------------------------------------------------------
        LOCAL loc_i, loc_oCtrl

        FOR loc_i = 1 TO par_oContainer.ControlCount
            loc_oCtrl = par_oContainer.Controls(loc_i)
            IF VARTYPE(loc_oCtrl) = "O"
                IF PEMSTATUS(loc_oCtrl, "Visible", 5)
                    loc_oCtrl.Visible = .T.
                ENDIF
                IF PEMSTATUS(loc_oCtrl, "ControlCount", 5) AND loc_oCtrl.ControlCount > 0
                    THIS.TornarControlesVisiveis(loc_oCtrl)
                ENDIF
            ENDIF
        ENDFOR
    ENDPROC

    *---------------------------------------------------------------------------
    PROCEDURE Destroy()
    *---------------------------------------------------------------------------
        IF USED("cursor_4c_Carac")
            TABLEREVERT(.T., "cursor_4c_Carac")
            USE IN cursor_4c_Carac
        ENDIF
        DODEFAULT()
    ENDPROC

    *---------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPaginaLista()
    *-- Primeiro 50% dos controles visuais:
    *-- Shapes decorativos + area de exibicao do codigo/descricao do produto
    *-- Layout fiel ao SIGPRPRO.SCX (800x500 escalado para 1000x600, fx=1.25, fy=1.2)
    *---------------------------------------------------------------------------

        *-- Shape decorativo superior-direito (area do botao OK)
        *-- Original: Top=7, Left=697, Width=90, Height=110
        THIS.AddObject("shp_4c_Shape", "Shape")
        WITH THIS.shp_4c_Shape
            .Top         = 8
            .Left        = 871
            .Width       = 113
            .Height      = 132
            .BackStyle   = 0
            .BorderStyle = 0
            .BorderColor = RGB(136, 189, 188)
            .Visible     = .T.
        ENDWITH

        *-- Borda da area de codigo do produto
        *-- Original: shpCodigo - Top=94, Left=13, Width=671, Height=34
        THIS.AddObject("shp_4c_ShpCodigo", "Shape")
        WITH THIS.shp_4c_ShpCodigo
            .Top           = 113
            .Left          = 16
            .Width         = 839
            .Height        = 41
            .BackStyle     = 0
            .Curvature     = 0
            .SpecialEffect = 1
            .BorderColor   = RGB(90, 90, 90)
            .Visible       = .T.
        ENDWITH

        *-- Borda da area de conteudo principal
        *-- Original: Shape1 - Top=133, Left=13, Width=671, Height=341
        THIS.AddObject("shp_4c_Shape1", "Shape")
        WITH THIS.shp_4c_Shape1
            .Top           = 160
            .Left          = 16
            .Width         = 839
            .Height        = 409
            .BackStyle     = 0
            .Curvature     = 0
            .SpecialEffect = 1
            .BorderColor   = RGB(90, 90, 90)
            .Visible       = .T.
        ENDWITH

        *-- Label "Produto :"
        *-- Original: Label1 - Top=103, Left=25
        THIS.AddObject("lbl_4c_Label1", "Label")
        WITH THIS.lbl_4c_Label1
            .Top       = 124
            .Left      = 31
            .Width     = 59
            .Height    = 18
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .F.
            .AutoSize  = .T.
            .BackStyle = 0
            .Caption   = "Produto :"
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        *-- Campo codigo do produto (somente leitura - Enabled=.F.)
        *-- Original: getCPros - Top=99, Left=75, Width=108, Enabled=.F.
        THIS.AddObject("txt_4c_CPros", "TextBox")
        WITH THIS.txt_4c_CPros
            .Top               = 119
            .Left              = 94
            .Width             = 135
            .Height            = 28
            .Value             = THIS.this_cCPros
            .Enabled           = .F.
            .DisabledBackColor = RGB(255, 255, 230)
            .DisabledForeColor = RGB(90, 90, 90)
            .FontName          = "Tahoma"
            .FontSize          = 8
            .BorderStyle       = 1
            .Visible           = .T.
        ENDWITH
    ENDPROC

    *---------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPaginaDados()
    *-- Segundo 50% dos controles visuais (Fase 5/8 - Parte 1):
    *-- Descricao do produto, grid de caracteristicas, complemento, memo e botao OK
    *-- Original: getDPros + GradeCarac + getComples + GetMemo + Ok
    *---------------------------------------------------------------------------
        LOCAL loc_oGrd

        *-- Campo descricao do produto (somente leitura - Enabled=.F., Format="K!")
        *-- Original: getDPros - Top=99, Left=184, Width=494, Enabled=.F.
        THIS.AddObject("txt_4c_DPros", "TextBox")
        WITH THIS.txt_4c_DPros
            .Top               = 119
            .Left              = 230
            .Width             = 618
            .Height            = 28
            .Value             = ""
            .Enabled           = .F.
            .Format            = "K!"
            .DisabledBackColor = RGB(255, 255, 230)
            .DisabledForeColor = RGB(90, 90, 90)
            .FontName          = "Tahoma"
            .FontSize          = 8
            .BorderStyle       = 1
            .Visible           = .T.
        ENDWITH

        *-- Grid de caracteristicas do produto
        *-- Original: GradeCarac - Top=139, Left=20, Width=319, Height=328, ColumnCount=1
        THIS.AddObject("grd_4c_Dados", "Grid")
        WITH THIS.grd_4c_Dados
            .Top                = 167
            .Left               = 25
            .Width              = 399
            .Height             = 394
            .ColumnCount        = 1
            .ReadOnly           = .F.
            .RecordMark         = .F.
            .DeleteMark         = .F.
            .GridLineColor      = RGB(238, 238, 238)
            .HighlightBackColor = RGB(255, 255, 255)
            .HighlightForeColor = RGB(15, 41, 104)
            .HighlightStyle     = 2
            .ScrollBars         = 2
            .RowHeight          = 16
            .Visible            = .T.
        ENDWITH

        *-- Configurar coluna 1: Caracteristicas
        *-- Original: Column1.FontName="Courier New", Width=290, Text1.When()=.F.
        loc_oGrd = THIS.grd_4c_Dados
        WITH loc_oGrd.Column1
            .Width     = 363
            .Movable   = .F.
            .Resizable = .F.
            .ReadOnly  = .T.
            .FontName  = "Courier New"
            .FontSize  = 8
        ENDWITH
        WITH loc_oGrd.Column1.Header1
            .FontName  = "Tahoma"
            .Alignment = 2
            .Caption   = "Caracter" + CHR(237) + "sticas"
            .ForeColor = RGB(90, 90, 90)
        ENDWITH

        *-- Campo complemento (preenchido via AfterRowColChange)
        *-- Original: getComples - Top=139, Left=348, Width=329, Height=23
        THIS.AddObject("txt_4c_Comples", "TextBox")
        WITH THIS.txt_4c_Comples
            .Top         = 167
            .Left        = 435
            .Width       = 411
            .Height      = 28
            .Value       = ""
            .ReadOnly    = .T.
            .FontName    = "Tahoma"
            .FontSize    = 8
            .BorderStyle = 1
            .Visible     = .T.
        ENDWITH

        *-- Campo memo de informacoes adicionais (preenchido via AfterRowColChange)
        *-- Original: GetMemo (fwmemo/editbox) - Top=167, Left=348, Width=329, Height=300
        THIS.AddObject("edt_4c_Infos", "EditBox")
        WITH THIS.edt_4c_Infos
            .Top        = 200
            .Left       = 435
            .Width      = 411
            .Height     = 360
            .Value      = ""
            .ReadOnly   = .T.
            .FontName   = "Tahoma"
            .FontSize   = 8
            .ScrollBars = 2
            .Visible    = .T.
        ENDWITH

        *-- Botao OK (fecha o form)
        *-- Original: Ok - Top=3, Left=723, Caption="OK", Picture=cadastro_salvar_60.jpg
        THIS.AddObject("cmd_4c_Ok", "CommandButton")
        WITH THIS.cmd_4c_Ok
            .Top             = 4
            .Left            = 723
            .Width           = 75
            .Height          = 75
            .Caption         = "OK"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
            .DisabledPicture = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
            .FontName        = "Tahoma"
            .FontSize        = 8
            .FontBold        = .T.
            .FontItalic      = .T.
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .Themes          = .T.
            .SpecialEffect   = 0
            .PicturePosition = 13
            .MousePointer    = 15
            .WordWrap        = .T.
            .Visible         = .T.
        ENDWITH

        *-- Vincular eventos (metodos devem ser PUBLIC para BINDEVENT)
        BINDEVENT(THIS.grd_4c_Dados, "AfterRowColChange", THIS, "GrdDadosAfterRowColChange")
        BINDEVENT(THIS.cmd_4c_Ok,    "Click",             THIS, "CmdOkClick")
    ENDPROC

    *---------------------------------------------------------------------------
    PROTECTED PROCEDURE CarregarDados()
    *-- Popula grid de caracteristicas e campos de exibicao
    *---------------------------------------------------------------------------
        LOCAL loc_oGrd, loc_oErro

        TRY
            *-- Descricao do produto (carregada pelo BO em BuscarDadosProduto)
            IF VARTYPE(THIS.this_oBusinessObject) = "O"
                THIS.txt_4c_DPros.Value = ALLTRIM(NVL(THIS.this_oBusinessObject.this_cDPros, ""))
            ENDIF

            *-- Carregar caracteristicas via BO (popula cursor_4c_Carac)
            IF VARTYPE(THIS.this_oBusinessObject) = "O"
                THIS.this_oBusinessObject.BuscarCaracteristicas(THIS.this_cCPros)
            ENDIF

            *-- Configurar RecordSource do grid (ColumnCount ANTES de RecordSource)
            loc_oGrd = THIS.grd_4c_Dados
            loc_oGrd.ColumnCount           = 1
            loc_oGrd.RecordSource          = "cursor_4c_Carac"
            loc_oGrd.Column1.ControlSource = "cursor_4c_Carac.caracteris"
            *-- Re-setar cabecalho (RecordSource pode resetar headers)
            loc_oGrd.Column1.Header1.Caption = "Caracter" + CHR(237) + "sticas"

            *-- Exibir informacoes da primeira caracteristica (se houver)
            IF USED("cursor_4c_Carac") AND RECCOUNT("cursor_4c_Carac") > 0
                GO TOP IN cursor_4c_Carac
                THIS.txt_4c_Comples.Value = NVL(cursor_4c_Carac.compls, "")
                THIS.edt_4c_Infos.Value   = NVL(cursor_4c_Carac.infos, "")
            ELSE
                THIS.txt_4c_Comples.Value = ""
                THIS.edt_4c_Infos.Value   = ""
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " | LN=" + TRANSFORM(loc_oErro.LineNo), ;
                    "Erro ao carregar dados")
        ENDTRY
    ENDPROC

    *---------------------------------------------------------------------------
    PROTECTED PROCEDURE AlternarPagina(par_nPagina)
    *-- Form plano (sem PageFrame) - nao aplica alternancia de paginas
    *---------------------------------------------------------------------------
        RETURN
    ENDPROC

    *---------------------------------------------------------------------------
    PROCEDURE GrdDadosAfterRowColChange(par_nColIndex)
    *-- Atualiza campos Comples e Infos ao navegar no grid de caracteristicas
    *-- PUBLIC: obrigatorio para BINDEVENT (AfterRowColChange)
    *-- Equivalente ao GradeCarac.AfterRowColChange do SIGPRPRO.SCX
    *---------------------------------------------------------------------------
        IF USED("cursor_4c_Carac") AND !EOF("cursor_4c_Carac")
            THIS.txt_4c_Comples.Value = NVL(cursor_4c_Carac.compls, "")
            THIS.edt_4c_Infos.Value   = NVL(cursor_4c_Carac.infos, "")
        ENDIF
    ENDPROC

    *---------------------------------------------------------------------------
    PROCEDURE CmdOkClick()
    *-- Fecha o form de caracteristicas de produto
    *-- PUBLIC: obrigatorio para BINDEVENT (Click)
    *-- Equivalente ao Ok.Click do SIGPRPRO.SCX
    *---------------------------------------------------------------------------
        THIS.Release()
    ENDPROC

    *---------------------------------------------------------------------------
    PROCEDURE BtnIncluirClick()
    *-- Popup somente-leitura (SIGPRPRO.SCX legado nao tem CRUD).
    *-- Manutencao de caracteristicas de produto e feita em FormSigPrCps
    *-- (cadastro de caracteristicas). Este popup apenas consulta.
    *---------------------------------------------------------------------------
        MsgAviso("Este formul" + CHR(225) + "rio " + CHR(233) + " apenas de consulta." + CHR(13) + ;
                 "Para incluir caracter" + CHR(237) + "sticas, utilize o cadastro" + CHR(13) + ;
                 "de caracter" + CHR(237) + "sticas de produto.", ;
                 "Opera" + CHR(231) + CHR(227) + "o n" + CHR(227) + "o dispon" + CHR(237) + "vel")
    ENDPROC

    *---------------------------------------------------------------------------
    PROCEDURE BtnAlterarClick()
    *-- Popup somente-leitura - alteracao nao permitida neste contexto.
    *---------------------------------------------------------------------------
        MsgAviso("Este formul" + CHR(225) + "rio " + CHR(233) + " apenas de consulta." + CHR(13) + ;
                 "Para alterar caracter" + CHR(237) + "sticas, utilize o cadastro" + CHR(13) + ;
                 "de caracter" + CHR(237) + "sticas de produto.", ;
                 "Opera" + CHR(231) + CHR(227) + "o n" + CHR(227) + "o dispon" + CHR(237) + "vel")
    ENDPROC

    *---------------------------------------------------------------------------
    PROCEDURE BtnVisualizarClick()
    *-- Popup ja e o proprio modo visualizacao. Reexibe registro atual.
    *-- Recarrega dados do produto e caracteristicas do banco.
    *---------------------------------------------------------------------------
        LOCAL loc_oErro

        TRY
            IF !EMPTY(THIS.this_cCPros) AND VARTYPE(THIS.this_oBusinessObject) = "O"
                THIS.this_oBusinessObject.BuscarDadosProduto(THIS.this_cCPros)
                THIS.CarregarDados()
                IF USED("cursor_4c_Carac") AND RECCOUNT("cursor_4c_Carac") > 0
                    THIS.grd_4c_Dados.Refresh()
                ENDIF
            ELSE
                MsgAviso("Nenhum produto carregado para visualiza" + CHR(231) + CHR(227) + "o.", ;
                         "Visualizar")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " | LN=" + TRANSFORM(loc_oErro.LineNo), ;
                    "Erro ao visualizar")
        ENDTRY
    ENDPROC

    *---------------------------------------------------------------------------
    PROCEDURE BtnExcluirClick()
    *-- Popup somente-leitura - exclusao nao permitida neste contexto.
    *---------------------------------------------------------------------------
        MsgAviso("Este formul" + CHR(225) + "rio " + CHR(233) + " apenas de consulta." + CHR(13) + ;
                 "Para excluir caracter" + CHR(237) + "sticas, utilize o cadastro" + CHR(13) + ;
                 "de caracter" + CHR(237) + "sticas de produto.", ;
                 "Opera" + CHR(231) + CHR(227) + "o n" + CHR(227) + "o dispon" + CHR(237) + "vel")
    ENDPROC

    *---------------------------------------------------------------------------
    PROCEDURE BtnBuscarClick()
    *-- Recarrega dados do produto e caracteristicas (equivale a uma re-consulta).
    *-- Util caso dados tenham sido alterados externamente enquanto popup aberto.
    *---------------------------------------------------------------------------
        LOCAL loc_oErro

        TRY
            IF !EMPTY(THIS.this_cCPros) AND VARTYPE(THIS.this_oBusinessObject) = "O"
                THIS.this_oBusinessObject.BuscarDadosProduto(THIS.this_cCPros)
                THIS.CarregarDados()
                IF USED("cursor_4c_Carac") AND RECCOUNT("cursor_4c_Carac") > 0
                    THIS.grd_4c_Dados.Refresh()
                ENDIF
            ELSE
                MsgAviso("Nenhum produto carregado para busca.", "Buscar")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " | LN=" + TRANSFORM(loc_oErro.LineNo), ;
                    "Erro ao buscar")
        ENDTRY
    ENDPROC

    *---------------------------------------------------------------------------
    PROCEDURE BtnEncerrarClick()
    *-- Fecha o popup (equivalente ao cmd_4c_Ok / botao Encerrar canonico).
    *---------------------------------------------------------------------------
        THIS.Release()
    ENDPROC

    *---------------------------------------------------------------------------
    PROCEDURE BtnSalvarClick()
    *-- Formulario somente-leitura - salvar nao disponivel neste contexto.
    *---------------------------------------------------------------------------
        MsgAviso("Este formul" + CHR(225) + "rio " + CHR(233) + " apenas de consulta." + CHR(13) + ;
                 "Nenhuma altera" + CHR(231) + CHR(227) + "o pode ser salva.", ;
                 "Opera" + CHR(231) + CHR(227) + "o n" + CHR(227) + "o dispon" + CHR(237) + "vel")
    ENDPROC

    *---------------------------------------------------------------------------
    PROCEDURE BtnCancelarClick()
    *-- Fecha o popup sem nenhuma acao (identico ao Encerrar neste contexto).
    *---------------------------------------------------------------------------
        THIS.Release()
    ENDPROC

    *---------------------------------------------------------------------------
    PROTECTED PROCEDURE FormParaBO()
    *-- Propaga estado do form para o BO.
    *-- Campos sao somente-leitura: apenas this_cCPros e propagado
    *-- (descricao e caracteristicas sao carregadas pelo proprio BO via SQL).
    *---------------------------------------------------------------------------
        IF VARTYPE(THIS.this_oBusinessObject) = "O"
            THIS.this_oBusinessObject.this_cCPros = THIS.this_cCPros
        ENDIF
    ENDPROC

    *---------------------------------------------------------------------------
    PROTECTED PROCEDURE BOParaForm()
    *-- Propaga dados do BO para os controles de exibicao do form.
    *-- Equivalente ao bloco de carga do Init original (getDPros.Value = LocalPro.DPros).
    *---------------------------------------------------------------------------
        IF VARTYPE(THIS.this_oBusinessObject) != "O"
            RETURN
        ENDIF

        IF PEMSTATUS(THIS, "txt_4c_CPros", 5)
            THIS.txt_4c_CPros.Value = ALLTRIM(NVL(THIS.this_cCPros, ""))
        ENDIF

        IF PEMSTATUS(THIS, "txt_4c_DPros", 5)
            THIS.txt_4c_DPros.Value = ALLTRIM(NVL(THIS.this_oBusinessObject.this_cDPros, ""))
        ENDIF

        IF PEMSTATUS(THIS, "txt_4c_Comples", 5)
            IF USED("cursor_4c_Carac") AND RECCOUNT("cursor_4c_Carac") > 0
                SELECT cursor_4c_Carac
                GO TOP
                THIS.txt_4c_Comples.Value = NVL(ALLTRIM(compls), "")
                THIS.edt_4c_Infos.Value   = NVL(infos, "")
            ELSE
                THIS.txt_4c_Comples.Value = ""
                THIS.edt_4c_Infos.Value   = ""
            ENDIF
        ENDIF
    ENDPROC

    *---------------------------------------------------------------------------
    PROTECTED PROCEDURE HabilitarCampos(par_lHabilitar)
    *-- Formulario somente-leitura: ignora o parametro.
    *-- Todos os campos permanecem desabilitados (When=.F. no legado).
    *-- O unico controle interativo eh o grid e o botao OK.
    *---------------------------------------------------------------------------
        RETURN
    ENDPROC

    *---------------------------------------------------------------------------
    PROTECTED PROCEDURE LimparCampos()
    *-- Limpa todos os campos de exibicao (preparacao para recarga ou fechamento).
    *---------------------------------------------------------------------------
        IF PEMSTATUS(THIS, "txt_4c_DPros", 5)
            THIS.txt_4c_DPros.Value = ""
        ENDIF
        IF PEMSTATUS(THIS, "txt_4c_Comples", 5)
            THIS.txt_4c_Comples.Value = ""
        ENDIF
        IF PEMSTATUS(THIS, "edt_4c_Infos", 5)
            THIS.edt_4c_Infos.Value = ""
        ENDIF
    ENDPROC

    *---------------------------------------------------------------------------
    PROCEDURE CarregarLista()
    *-- Alias de CarregarDados() para compatibilidade com FormBase.
    *-- Form plano (OPERACIONAL) nao tem lista paginada: recarrega os dados.
    *---------------------------------------------------------------------------
        THIS.CarregarDados()
    ENDPROC

    *---------------------------------------------------------------------------
    PROTECTED PROCEDURE AjustarBotoesPorModo()
    *-- Form plano sem modos CRUD (somente-leitura).
    *-- Nenhum ajuste de botoes necessario.
    *---------------------------------------------------------------------------
        RETURN
    ENDPROC

ENDDEFINE


### BO (C:\4c\projeto\app\classes\SIGPRPROBO.prg):
*==============================================================================
* SIGPRPROBO.prg - Business Object: Caracteristicas de Produtos
* Tabela principal : SigPrCrr
* Form OPERACIONAL - somente leitura (viewer de caracteristicas por produto)
* Fase 2/8: Metodos CRUD (BuscarDadosProduto, BuscarCaracteristicas,
*            CarregarDoCursor, ObterChavePrimaria)
*==============================================================================
DEFINE CLASS SIGPRPROBO AS BusinessBase

  *-- SigCdPro
  this_cCPros   = ""   && cpros char(14) - codigo do produto (FK SigCdPro)
  this_cDPros   = ""   && dpros char(65) - descricao do produto

  *-- SigPrCrr
  this_cCidChaves  = ""   && cidchaves  char(20) - chave PK da caracteristica
  this_cCaracteris = ""   && caracteris char(40) - texto da caracteristica
  this_cCompls     = ""   && compls     char(40) - complemento
  this_cInfos      = ""   && infos      text     - informacoes detalhadas (memo)

  *----------------------------------------------------------------------------
  PROCEDURE Init()
    THIS.this_cTabela     = "SigPrCrr"
    THIS.this_cCampoChave = "cidchaves"
    DODEFAULT()
  ENDPROC

  *----------------------------------------------------------------------------
  * BuscarDadosProduto - Carrega descricao do produto em this_cDPros
  *   Equivale ao: SELECT DPros FROM SigCdPro WHERE CPros = pPro
  * Retorna .T. se encontrou, .F. se nao encontrou ou erro
  *----------------------------------------------------------------------------
  FUNCTION BuscarDadosProduto(par_cCPros)
    LOCAL loc_lSucesso, loc_cSQL, loc_nRet, loc_oErro

    loc_lSucesso = .F.

    TRY
      loc_cSQL = "SELECT dpros FROM SigCdPro " + ;
                 "WHERE cpros = " + EscaparSQL(ALLTRIM(par_cCPros))

      IF USED("cursor_4c_ProTemp")
        USE IN cursor_4c_ProTemp
      ENDIF

      loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ProTemp")

      IF loc_nRet > 0 AND USED("cursor_4c_ProTemp") AND RECCOUNT("cursor_4c_ProTemp") > 0
        SELECT cursor_4c_ProTemp
        GO TOP
        THIS.this_cDPros = NVL(ALLTRIM(dpros), "")
        loc_lSucesso = .T.
      ELSE
        THIS.this_cDPros = ""
      ENDIF

      IF USED("cursor_4c_ProTemp")
        USE IN cursor_4c_ProTemp
      ENDIF

    CATCH TO loc_oErro
      MsgErro(loc_oErro.Message, "Erro")
    ENDTRY

    RETURN loc_lSucesso
  ENDFUNC

  *----------------------------------------------------------------------------
  * BuscarCaracteristicas - Carrega SigPrCrr no cursor_4c_Carac para o grid
  *   Equivale ao: CursorQuery('SigPrCrr', 'LocalCrPro', 'CPros', pPro)
  *   O cursor cursor_4c_Carac deve existir (criado no InicializarForm do Form)
  * Retorna .T. se sucesso, .F. se erro
  *----------------------------------------------------------------------------
  FUNCTION BuscarCaracteristicas(par_cCPros)
    LOCAL loc_lSucesso, loc_cSQL, loc_nRet, loc_oErro

    loc_lSucesso = .F.

    TRY
      loc_cSQL = "SELECT cidchaves, caracteris, compls, infos " + ;
                 "FROM SigPrCrr " + ;
                 "WHERE cpros = " + EscaparSQL(ALLTRIM(par_cCPros)) + " " + ;
                 "ORDER BY cidchaves"

      IF USED("cursor_4c_CaracTemp")
        USE IN cursor_4c_CaracTemp
      ENDIF

      loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_CaracTemp")

      IF loc_nRet >= 0
        IF USED("cursor_4c_Carac")
          TABLEREVERT(.T., "cursor_4c_Carac")
          SELECT cursor_4c_Carac
          ZAP
          IF USED("cursor_4c_CaracTemp") AND RECCOUNT("cursor_4c_CaracTemp") > 0
            APPEND FROM DBF("cursor_4c_CaracTemp")
          ENDIF
          GO TOP IN cursor_4c_Carac
        ENDIF

        IF USED("cursor_4c_CaracTemp")
          USE IN cursor_4c_CaracTemp
        ENDIF

        loc_lSucesso = .T.
      ELSE
        IF USED("cursor_4c_CaracTemp")
          USE IN cursor_4c_CaracTemp
        ENDIF
        MsgErro("Erro ao consultar caracter" + CHR(237) + "sticas do produto.", "Erro")
      ENDIF

    CATCH TO loc_oErro
      MsgErro(loc_oErro.Message, "Erro")
    ENDTRY

    RETURN loc_lSucesso
  ENDFUNC

  *----------------------------------------------------------------------------
  * CarregarDoCursor - Carrega propriedades do BO a partir de um cursor
  *   par_cAliasCursor: nome do alias do cursor (ex: "cursor_4c_Carac")
  * Retorna .T. se sucesso, .F. caso contrario
  *----------------------------------------------------------------------------
  FUNCTION CarregarDoCursor(par_cAliasCursor)
    LOCAL loc_lSucesso, loc_oErro

    loc_lSucesso = .F.

    TRY
      IF USED(par_cAliasCursor) AND RECCOUNT(par_cAliasCursor) > 0
        SELECT (par_cAliasCursor)
        THIS.this_cCidChaves  = NVL(ALLTRIM(cidchaves), "")
        THIS.this_cCaracteris = NVL(ALLTRIM(caracteris), "")
        THIS.this_cCompls     = NVL(ALLTRIM(compls), "")
        THIS.this_cInfos      = NVL(ALLTRIM(infos), "")
        loc_lSucesso = .T.
      ENDIF
    CATCH TO loc_oErro
      MsgErro(loc_oErro.Message, "Erro")
    ENDTRY

    RETURN loc_lSucesso
  ENDFUNC

  *----------------------------------------------------------------------------
  * ObterChavePrimaria - Retorna valor da chave primaria (cidchaves)
  *----------------------------------------------------------------------------
  PROTECTED FUNCTION ObterChavePrimaria()
    RETURN ALLTRIM(THIS.this_cCidChaves)
  ENDFUNC

  *----------------------------------------------------------------------------
  * ValidarDados - Valida campos obrigatorios de SigPrCrr
  *----------------------------------------------------------------------------
  PROTECTED FUNCTION ValidarDados()
    LOCAL loc_lValido

    loc_lValido = .T.
    THIS.this_cMensagemErro = ""

    IF EMPTY(ALLTRIM(THIS.this_cCPros))
      THIS.this_cMensagemErro = "C" + CHR(243) + "digo do produto (cpros) " + CHR(233) + " obrigat" + CHR(243) + "rio."
      loc_lValido = .F.
    ENDIF

    IF loc_lValido AND EMPTY(ALLTRIM(THIS.this_cCidChaves))
      THIS.this_cMensagemErro = "Chave da caracter" + CHR(237) + "stica (cidchaves) " + CHR(233) + " obrigat" + CHR(243) + "ria."
      loc_lValido = .F.
    ENDIF

    IF loc_lValido AND EMPTY(ALLTRIM(THIS.this_cCaracteris))
      THIS.this_cMensagemErro = "Descri" + CHR(231) + CHR(227) + "o da caracter" + CHR(237) + "stica " + CHR(233) + " obrigat" + CHR(243) + "ria."
      loc_lValido = .F.
    ENDIF

    RETURN loc_lValido
  ENDFUNC

  *----------------------------------------------------------------------------
  * Inserir - Insere novo registro em SigPrCrr
  *   Colunas: caracteris char(40), cidchaves char(20) PK, compls char(40),
  *            cpros char(14), infos text NULL
  *----------------------------------------------------------------------------
  PROTECTED FUNCTION Inserir()
    LOCAL loc_lSucesso, loc_cSQL, loc_nRet, loc_oErro

    loc_lSucesso = .F.
    THIS.this_cMensagemErro = ""

    TRY
      loc_cSQL = "INSERT INTO SigPrCrr (caracteris, cidchaves, compls, cpros, infos) VALUES (" + ;
                 EscaparSQL(LEFT(ALLTRIM(THIS.this_cCaracteris), 40)) + ", " + ;
                 EscaparSQL(LEFT(ALLTRIM(THIS.this_cCidChaves), 20)) + ", " + ;
                 EscaparSQL(LEFT(ALLTRIM(THIS.this_cCompls), 40)) + ", " + ;
                 EscaparSQL(LEFT(ALLTRIM(THIS.this_cCPros), 14)) + ", " + ;
                 EscaparSQL(ALLTRIM(THIS.this_cInfos)) + ")"

      loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL)

      IF loc_nRet > 0
        THIS.RegistrarAuditoria("INSERT")
        loc_lSucesso = .T.
      ELSE
        THIS.this_cMensagemErro = "Falha ao inserir caracter" + CHR(237) + "stica no SigPrCrr."
      ENDIF

    CATCH TO loc_oErro
      THIS.this_cMensagemErro = loc_oErro.Message
      MsgErro(loc_oErro.Message, "Erro")
    ENDTRY

    RETURN loc_lSucesso
  ENDFUNC

  *----------------------------------------------------------------------------
  * Atualizar - Atualiza registro existente em SigPrCrr (chave cidchaves)
  *----------------------------------------------------------------------------
  PROTECTED FUNCTION Atualizar()
    LOCAL loc_lSucesso, loc_cSQL, loc_nRet, loc_oErro

    loc_lSucesso = .F.
    THIS.this_cMensagemErro = ""

    TRY
      loc_cSQL = "UPDATE SigPrCrr SET " + ;
                 "caracteris = " + EscaparSQL(LEFT(ALLTRIM(THIS.this_cCaracteris), 40)) + ", " + ;
                 "compls = " + EscaparSQL(LEFT(ALLTRIM(THIS.this_cCompls), 40)) + ", " + ;
                 "cpros = " + EscaparSQL(LEFT(ALLTRIM(THIS.this_cCPros), 14)) + ", " + ;
                 "infos = " + EscaparSQL(ALLTRIM(THIS.this_cInfos)) + " " + ;
                 "WHERE cidchaves = " + EscaparSQL(LEFT(ALLTRIM(THIS.this_cCidChaves), 20))

      loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL)

      IF loc_nRet >= 0
        THIS.RegistrarAuditoria("UPDATE")
        loc_lSucesso = .T.
      ELSE
        THIS.this_cMensagemErro = "Falha ao atualizar caracter" + CHR(237) + "stica no SigPrCrr."
      ENDIF

    CATCH TO loc_oErro
      THIS.this_cMensagemErro = loc_oErro.Message
      MsgErro(loc_oErro.Message, "Erro")
    ENDTRY

    RETURN loc_lSucesso
  ENDFUNC

  *----------------------------------------------------------------------------
  * ExecutarExclusao - Deleta registro em SigPrCrr (chave cidchaves)
  *----------------------------------------------------------------------------
  PROTECTED FUNCTION ExecutarExclusao()
    LOCAL loc_lSucesso, loc_cSQL, loc_nRet, loc_oErro

    loc_lSucesso = .F.
    THIS.this_cMensagemErro = ""

    TRY
      loc_cSQL = "DELETE FROM SigPrCrr WHERE cidchaves = " + ;
                 EscaparSQL(LEFT(ALLTRIM(THIS.this_cCidChaves), 20))

      loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL)

      IF loc_nRet >= 0
        THIS.RegistrarAuditoria("DELETE")
        loc_lSucesso = .T.
      ELSE
        THIS.this_cMensagemErro = "Falha ao excluir caracter" + CHR(237) + "stica do SigPrCrr."
      ENDIF

    CATCH TO loc_oErro
      THIS.this_cMensagemErro = loc_oErro.Message
      MsgErro(loc_oErro.Message, "Erro")
    ENDTRY

    RETURN loc_lSucesso
  ENDFUNC

ENDDEFINE


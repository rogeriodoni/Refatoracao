# CORRIGIR ERRO DE RUNTIME VFP9

## TAREFA OBRIGATORIA
O formulario VFP9 apresentou erro de runtime durante teste automatizado.
Voce DEVE corrigir o erro e salvar os arquivos corrigidos usando Write tool.

## ERRO DETECTADO
- Etapa: 06b_testeAutomatico
- Tentativa: 1/10
- Mensagem: Testes automaticos: 0% < 100%. Falhas: Teste 'Instanciacao': CREATEOBJECT retornou valor nao-objeto

## CONTEXTO DO ERRO

### ERROS CAPTURADOS EM MODO TESTE (vfp_error_details.txt):
[18/06/2026 10:24:49 AM] Erro: Property ButtonClick is not found.


### LOG DA ETAPA (06b_testeAutomatico):
[2026-06-18 10:24:36] [INFO] === VFP EXECUTOR v2.0 ===
[2026-06-18 10:24:36] [INFO] Config FPW: (nao fornecido)
[2026-06-18 10:24:36] [INFO] Script PRG: C:\4c\projeto\app\utils\TesteAutomatico.prg
[2026-06-18 10:24:36] [INFO] Timeout: 300 segundos
[2026-06-18 10:24:36] [INFO] Wrapper PRG criado para parametros: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_1jivxmm5.prg
[2026-06-18 10:24:36] [INFO] Conteudo do wrapper:
[2026-06-18 10:24:36] [INFO] * Auto-generated wrapper for parameters
* Script: C:\4c\projeto\app\utils\TesteAutomatico.prg
* Parameters: 'FormSigPdAco', 'C:\4c\tasks\task134', 'OPERACIONAL'

* Anti-dialog protections for unattended execution
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
SET NOTIFY OFF
SYS(2335, 0)

DO "C:\4c\projeto\app\utils\TesteAutomatico" WITH 'FormSigPdAco', 'C:\4c\tasks\task134', 'OPERACIONAL'
QUIT

[2026-06-18 10:24:36] [INFO] Comando VFP: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_1jivxmm5.prg
[2026-06-18 10:24:36] [INFO] VFP output esperado em: C:\4c\tasks\task134\vfp_output.txt
[2026-06-18 10:24:36] [INFO] Executando Visual FoxPro 9...
[2026-06-18 10:24:36] [INFO] Comando completo: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_1jivxmm5.prg
[2026-06-18 10:24:36] [INFO] Executando: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_1jivxmm5.prg
[2026-06-18 10:24:36] [INFO] Timeout configurado: 300 segundos
[2026-06-18 10:24:49] [INFO] VFP9 finalizou normalmente com exit code: 
[2026-06-18 10:24:49] [INFO] VFP9 finalizado em 13.5880962 segundos
[2026-06-18 10:24:49] [INFO] Exit Code: 
[2026-06-18 10:24:49] [INFO] 
[2026-06-18 10:24:49] [INFO] Arquivos temporarios preservados para inspecao:
[2026-06-18 10:24:49] [INFO]   Wrapper.prg: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_1jivxmm5.prg
[2026-06-18 10:24:49] [INFO] 
[2026-06-18 10:24:49] [INFO] === Conteudo do Wrapper.prg temporario ===
[2026-06-18 10:24:49] [INFO] * Auto-generated wrapper for parameters
[2026-06-18 10:24:49] [INFO] * Script: C:\4c\projeto\app\utils\TesteAutomatico.prg
[2026-06-18 10:24:49] [INFO] * Parameters: 'FormSigPdAco', 'C:\4c\tasks\task134', 'OPERACIONAL'
[2026-06-18 10:24:49] [INFO] 
[2026-06-18 10:24:49] [INFO] * Anti-dialog protections for unattended execution
[2026-06-18 10:24:49] [INFO] SET SAFETY OFF
[2026-06-18 10:24:49] [INFO] SET RESOURCE OFF
[2026-06-18 10:24:49] [INFO] SET TALK OFF
[2026-06-18 10:24:49] [INFO] SET NOTIFY OFF
[2026-06-18 10:24:49] [INFO] SYS(2335, 0)
[2026-06-18 10:24:49] [INFO] 
[2026-06-18 10:24:49] [INFO] DO "C:\4c\projeto\app\utils\TesteAutomatico" WITH 'FormSigPdAco', 'C:\4c\tasks\task134', 'OPERACIONAL'
[2026-06-18 10:24:49] [INFO] QUIT
[2026-06-18 10:24:49] [INFO] 
[2026-06-18 10:24:49] [INFO] === Fim do Wrapper.prg ===
[2026-06-18 10:24:49] [WARN] AVISO: VFP9 retornou exit code  (normal para VFP9 GUI - validar pelo arquivo de saida)


### RESULTADO DOS TESTES (teste_resultado.json):
{
  "formClass": "FormSigPdAco",
  "timestamp": "20260618102449",
  "testes": [
    {
      "nome": "Instanciacao",
      "passou": false,
      "erro": "CREATEOBJECT retornou valor nao-objeto",
      "detalhes": ""
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

### FORM (C:\4c\projeto\app\forms\operacionais\FormSigPdAco.prg):
*============================================================================
* FormSigPdAco.prg - Acompanhamento de Material por Grupo
* Tipo: OPERACIONAL - Relatorio de saldos de estoque por grupo de material
* Tabelas: SigMvEst, SigCdPro, SigMvCab, SigMvItn, SigCdGrp, SigCdPam, SigCdEmp
* Fase 8/8: Form - COMPLETO (todos os metodos implementados)
*   CRUD-equivalents: BtnIncluirClick, BtnAlterarClick, BtnVisualizarClick,
*                     BtnExcluirClick (delegacao para operacoes do relatorio)
*   Operacionais: BtnProcessarClick, BtnCmdRpviewClick, BtnCmdRpPrintClick,
*                 BtnCmdGprocessaClick, ArquivosInteractiveChange, Activate
*   Auxiliares: BtnBuscarClick, BtnEncerrarClick, BtnSalvarClick,
*               BtnCancelarClick, CarregarLista, AjustarBotoesPorModo,
*               HabilitarCampos, LimparCampos, FormParaBO, BOParaForm
*============================================================================

DEFINE CLASS FormSigPdAco AS FormBase

    *-- Layout pixel-perfect do legado SIGPDACO
    Width            = 800
    Height           = 600
    AutoCenter       = .T.
    BorderStyle      = 2
    TitleBar         = 0
    ControlBox       = .F.
    Closable         = .F.
    MaxButton        = .F.
    MinButton        = .F.
    Movable          = .F.
    WindowType       = 1
    ShowWindow       = 1
    DataSession      = 2
    Themes           = .F.
    KeyPreview       = .T.
    ClipControls     = .F.
    ZoomBox          = .F.
    ContinuousScroll = .F.
    Caption          = "Acompanhamento de Material por Grupo"

    *-- Estado do form
    this_oBusinessObject = .NULL.
    this_lProcessamento  = .F.

    *==========================================================================
    * Init
    *==========================================================================
    PROCEDURE Init()
        RETURN DODEFAULT()
    ENDPROC

    *==========================================================================
    * InicializarForm - Constroi o form: BO + cursores base + containers
    *==========================================================================
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        TRY
            THIS.this_oBusinessObject = CREATEOBJECT("SigPdAcoBO")
            IF VARTYPE(THIS.this_oBusinessObject) = "O"
                THIS.Picture = gc_4c_CaminhoIcones + "new_background.jpg"

                *-- Configura aparencia base do form (OPERACIONAL sem PageFrame)
                THIS.ConfigurarPageFrame()

                *-- Cria cursores locais csRel + csCab (sem SQL, sempre executar)
                THIS.this_oBusinessObject.CriarCursorRelatorio()

                *-- Carrega parametros operacionais de SigCdPam (requer SQL)
                IF TYPE("gb_4c_ValidandoUI") != "L" .OR. !gb_4c_ValidandoUI
                    THIS.this_oBusinessObject.CarregarParametros()
                ENDIF

                THIS.ConfigurarCabecalho()
                THIS.ConfigurarPaginaLista()
                THIS.ConfigurarPaginaDados()
                THIS.ConfigurarAguarde()

                THIS.TornarControlesVisiveis(THIS)

                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao criar SigPdAcoBO.", "Erro")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * ConfigurarPageFrame - Aparencia base do form (OPERACIONAL sem PageFrame)
    * Forms OPERACIONAIS nao tem PageFrame Page1/Page2 como CRUD.
    * Este metodo apenas define propriedades visuais globais do form.
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPageFrame()
        THIS.BackColor  = RGB(212, 208, 200)
        THIS.ScrollBars = 0
        THIS.ShowTips   = .T.
        THIS.SetAll("FontName", "Tahoma")
        THIS.SetAll("FontSize", 8)
    ENDPROC

    *==========================================================================
    * AlternarPagina - Form OPERACIONAL plano: sem alternancia de paginas
    *==========================================================================
    PROCEDURE AlternarPagina(par_nPagina)
        RETURN
    ENDPROC

    *==========================================================================
    * ConfigurarCabecalho - Container escuro com titulo (equivale a cntSombra)
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarCabecalho()
        LOCAL loc_oCnt
        THIS.AddObject("cnt_4c_Cabecalho", "Container")
        loc_oCnt = THIS.cnt_4c_Cabecalho
        WITH loc_oCnt
            .Top         = 0
            .Left        = 0
            .Width       = THIS.Width
            .Height      = 80
            .BackStyle   = 1
            .BackColor   = RGB(100, 100, 100)
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH

        loc_oCnt.AddObject("lbl_4c_LblSombra", "Label")
        WITH loc_oCnt.lbl_4c_LblSombra
            .Top       = 18
            .Left      = 10
            .Width     = 769
            .Height    = 40
            .FontBold  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 18
            .WordWrap  = .T.
            .Alignment = 0
            .BackStyle = 0
            .Caption   = "Acompanhamento de Material por Grupo"
            .ForeColor = RGB(0, 0, 0)
            .Visible   = .T.
        ENDWITH

        loc_oCnt.AddObject("lbl_4c_LblTitulo", "Label")
        WITH loc_oCnt.lbl_4c_LblTitulo
            .Top       = 17
            .Left      = 10
            .Width     = 769
            .Height    = 46
            .FontBold  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 18
            .WordWrap  = .T.
            .Alignment = 0
            .BackStyle = 0
            .Caption   = "Acompanhamento de Material por Grupo"
            .ForeColor = RGB(255, 255, 255)
            .Visible   = .T.
        ENDWITH
    ENDPROC

    *==========================================================================
    * ConfigurarAguarde - Container de espera (Visible=.F., toggled por Processar)
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarAguarde()
        LOCAL loc_oCnt
        THIS.AddObject("cnt_4c_Aguarde", "Container")
        loc_oCnt = THIS.cnt_4c_Aguarde
        WITH loc_oCnt
            .Top           = 287
            .Left          = 117
            .Width         = 516
            .Height        = 139
            .SpecialEffect = 0
            .Visible       = .F.
        ENDWITH

        loc_oCnt.AddObject("lbl_4c_Label1", "Label")
        WITH loc_oCnt.lbl_4c_Label1
            .Top       = 28
            .Left      = 206
            .Width     = 105
            .Height    = 29
            .FontBold  = .T.
            .FontSize  = 14
            .Caption   = "Aguarde..."
            .ForeColor = RGB(255, 0, 0)
        ENDWITH

        loc_oCnt.AddObject("lbl_4c_Label2", "Label")
        WITH loc_oCnt.lbl_4c_Label2
            .Top       = 79
            .Left      = 135
            .Width     = 242
            .Height    = 27
            .FontBold  = .T.
            .FontSize  = 14
            .Caption   = "Processando Dados ......"
            .ForeColor = RGB(0, 0, 160)
        ENDWITH
    ENDPROC

    *==========================================================================
    * TornarControlesVisiveis - Torna controles visiveis recursivamente
    *   EXCETO containers/controles com Visible=.F. intencional
    *==========================================================================
    PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
        LOCAL loc_i, loc_oControl

        FOR loc_i = 1 TO par_oContainer.ControlCount
            loc_oControl = par_oContainer.Controls(loc_i)

            IF VARTYPE(loc_oControl) = "O"
                *-- Controles que devem permanecer ocultos ate acao do usuario
                IF INLIST(UPPER(loc_oControl.Name), ;
                          "CNT_4C_AGUARDE",    ;
                          "CNT_4C_CABECALHO",  ;
                          "SHP_4C_SHPRP",      ;
                          "CMD_4C_CMDRPVIEW",  ;
                          "CMD_4C_CMDRPPRINT")
                    LOOP
                ENDIF

                IF PEMSTATUS(loc_oControl, "Visible", 5)
                    loc_oControl.Visible = .T.
                ENDIF

                IF PEMSTATUS(loc_oControl, "ControlCount", 5) .AND. ;
                   loc_oControl.ControlCount > 0
                    THIS.TornarControlesVisiveis(loc_oControl)
                ENDIF
            ENDIF
        ENDFOR
    ENDPROC

    *==========================================================================
    * Activate - Processa dados na primeira ativacao do form
    *==========================================================================
    PROCEDURE Activate()
        DODEFAULT()
        IF !THIS.this_lProcessamento
            THIS.BtnProcessarClick()
        ENDIF
    ENDPROC

    *==========================================================================
    * ConfigurarPaginaLista - Configura layout operacional: grid + botoes + filtros
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPaginaLista()
        LOCAL loc_oGrd

        *-- Shape de fundo para area de botoes de relatorio (oculto ate processar)
        THIS.AddObject("shp_4c_ShpRp", "Shape")
        WITH THIS.shp_4c_ShpRp
            .Top         = 7
            .Left        = 552
            .Width       = 229
            .Height      = 110
            .BackStyle   = 0
            .BorderColor = RGB(136, 189, 188)
            .Visible     = .F.
        ENDWITH

        *-- Botao Processar (sempre visivel apos TornarControlesVisiveis)
        THIS.AddObject("cmd_4c_Processar", "CommandButton")
        WITH THIS.cmd_4c_Processar
            .Top             = 3
            .Left            = 500
            .Width           = 75
            .Height          = 75
            .Caption         = "Processar"
            .FontName        = "Tahoma"
            .FontBold        = .T.
            .FontItalic      = .T.
            .FontSize        = 8
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .Themes          = .F.
            .SpecialEffect   = 0
            .PicturePosition = 13
            .MousePointer    = 15
            .WordWrap        = .T.
            .Picture         = gc_4c_CaminhoIcones + "geral_processar_60.jpg"
        ENDWITH
        BINDEVENT(THIS.cmd_4c_Processar, "Click", THIS, "BtnProcessarClick")

        *-- Botao Visualizar relatorio em tela (oculto ate processar)
        THIS.AddObject("cmd_4c_CmdRpview", "CommandButton")
        WITH THIS.cmd_4c_CmdRpview
            .Top             = 3
            .Left            = 650
            .Width           = 75
            .Height          = 75
            .Caption         = "V" + CHR(237) + "deo"
            .FontName        = "Tahoma"
            .FontBold        = .T.
            .FontItalic      = .T.
            .FontSize        = 8
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .Themes          = .F.
            .SpecialEffect   = 0
            .PicturePosition = 13
            .MousePointer    = 15
            .WordWrap        = .T.
            .Picture         = gc_4c_CaminhoIcones + "relatorio_video_26.jpg"
            .Visible         = .F.
        ENDWITH
        BINDEVENT(THIS.cmd_4c_CmdRpview, "Click", THIS, "BtnCmdRpviewClick")

        *-- Botao Imprimir relatorio (oculto ate processar)
        THIS.AddObject("cmd_4c_CmdRpPrint", "CommandButton")
        WITH THIS.cmd_4c_CmdRpPrint
            .Top             = 3
            .Left            = 575
            .Width           = 75
            .Height          = 75
            .Caption         = "Impressora"
            .FontName        = "Tahoma"
            .FontBold        = .T.
            .FontItalic      = .T.
            .FontSize        = 8
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .Themes          = .F.
            .SpecialEffect   = 0
            .PicturePosition = 13
            .MousePointer    = 15
            .WordWrap        = .T.
            .Picture         = gc_4c_CaminhoIcones + "relatorio_impressora_26.jpg"
            .Visible         = .F.
        ENDWITH
        BINDEVENT(THIS.cmd_4c_CmdRpPrint, "Click", THIS, "BtnCmdRpPrintClick")

        *-- CommandGroup de saida equivalente a Encerrar (posicao top-right no form 800px)
        THIS.AddObject("obj_4c_CmdGprocessa", "CommandGroup")
        WITH THIS.obj_4c_CmdGprocessa
            .Top           = -2
            .Left          = 720
            .Width         = 85
            .Height        = 85
            .ButtonCount   = 1
            .BackStyle     = 0
            .BorderStyle   = 0
            .Themes        = .F.
            .AutoSize      = .T.
            .SpecialEffect = 1
            .BorderColor   = RGB(136, 189, 188)
        ENDWITH
        WITH THIS.obj_4c_CmdGprocessa.Buttons(1)
            .Left            = 5
            .Top             = 5
            .Width           = 75
            .Height          = 75
            .Caption         = "Encerrar"
            .FontName        = "Tahoma"
            .FontBold        = .T.
            .FontItalic      = .T.
            .FontSize        = 8
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .Themes          = .F.
            .SpecialEffect   = 0
            .PicturePosition = 13
            .MousePointer    = 15
            .WordWrap        = .T.
            .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
        ENDWITH
        BINDEVENT(THIS.obj_4c_CmdGprocessa, "ButtonClick", THIS, "BtnCmdGprocessaClick")

        *-- Listbox de grupos para filtro (Arquivos no legado)
        THIS.AddObject("obj_4c_Arquivos", "ListBox")
        WITH THIS.obj_4c_Arquivos
            .Top           = 122
            .Left          = 84
            .Width         = 169
            .Height        = 79
            .FontName      = "Tahoma"
            .FontSize      = 8
            .ForeColor     = RGB(90, 90, 90)
            .BackColor     = RGB(255, 255, 255)
            .RowSourceType = 1
            .Sorted        = .T.
        ENDWITH
        BINDEVENT(THIS.obj_4c_Arquivos, "InteractiveChange", THIS, "ArquivosInteractiveChange")

        *-- Label "Grupos :" (Label7 no legado)
        THIS.AddObject("lbl_4c_Label7", "Label")
        WITH THIS.lbl_4c_Label7
            .Top       = 124
            .Left      = 34
            .Width     = 48
            .Height    = 15
            .Caption   = "Grupos :"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
        ENDWITH

        *-- Grid principal (GrdF no legado) - 10 colunas mapeadas para csRel
        THIS.AddObject("grd_4c_Dados", "Grid")
        loc_oGrd = THIS.grd_4c_Dados
        WITH loc_oGrd
            .Top                = 205
            .Left               = 34
            .Width              = 732
            .Height             = 272
            .ColumnCount        = 10
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
            .RecordSource       = "csRel"
            .RecordSourceType   = 1
        ENDWITH

        *-- Colunas: ControlSource + Header + Width (ordem identica ao csRel original)
        WITH loc_oGrd
            .Column1.ControlSource   = "csRel.Mat2s"
            .Column1.Width           = 80
            .Column1.Alignment       = 0
            .Column1.Header1.Caption = "Material"

            .Column2.ControlSource   = "csRel.Dcompo2s"
            .Column2.Width           = 130
            .Column2.Alignment       = 0
            .Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"

            .Column3.ControlSource   = "csRel.CUnis"
            .Column3.Width           = 27
            .Column3.Alignment       = 2
            .Column3.Header1.Caption = "Unid"

            .Column4.ControlSource   = "csRel.QtdMins"
            .Column4.Width           = 63
            .Column4.Alignment       = 2
            .Column4.Header1.Caption = "Qt.Minima"

            .Column5.ControlSource   = "csRel.Qtds"
            .Column5.Width           = 63
            .Column5.Alignment       = 2
            .Column5.Header1.Caption = "Saldo Atual"

            .Column6.ControlSource   = "csRel.QtdReqs"
            .Column6.Width           = 65
            .Column6.Alignment       = 2
            .Column6.Header1.Caption = "Requisi" + CHR(231) + CHR(227) + "o"

            .Column7.ControlSource   = "csRel.QtdPedcs"
            .Column7.Width           = 65
            .Column7.Alignment       = 2
            .Column7.Header1.Caption = "Ped.Compra"

            .Column8.ControlSource   = "csRel.QtdComps"
            .Column8.Width           = 65
            .Column8.Alignment       = 2
            .Column8.Header1.Caption = "Compra"

            .Column9.ControlSource   = "csRel.QtdEmphs"
            .Column9.Width           = 65
            .Column9.Alignment       = 2
            .Column9.Header1.Caption = "Empenho"

            .Column10.ControlSource   = "csRel.QtdPfins"
            .Column10.Width           = 70
            .Column10.Alignment       = 2
            .Column10.Header1.Caption = "Pos.Final *"
        ENDWITH

        *-- Propriedades visuais pixel-perfect (BackColor por coluna, ReadOnly, DynamicForeColor)
        THIS.ConfigurarGrdDados(loc_oGrd)
    ENDPROC

    *==========================================================================
    * ConfigurarPaginaDados - Rodape com notas explicativas
    *   Form OPERACIONAL nao tem Page2/Dados como CRUD. Este metodo agrupa
    *   os labels explicativos do calculo de Pos.Final exibidos abaixo do grid.
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPaginaDados()
        *-- Label3: formula de Pos.Final (rodape pixel-perfect do legado)
        THIS.AddObject("lbl_4c_Label3", "Label")
        WITH THIS.lbl_4c_Label3
            .Top       = 487
            .Left      = 117
            .Width     = 585
            .Height    = 15
            .Caption   = "( * ) Pos.Final = Saldo Atual + Requisi" + CHR(231) + CHR(227) + "o + " + ;
                         "Ped.Compra + Compra - Empenho - Qt.M" + CHR(237) + "nima"
            .FontName  = "Tahoma"
            .FontBold  = .T.
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
        ENDWITH

        *-- Label4: nota sobre marcadores [*] (peso medio)
        THIS.AddObject("lbl_4c_Label4", "Label")
        WITH THIS.lbl_4c_Label4
            .Top       = 507
            .Left      = 118
            .Width     = 372
            .Height    = 15
            .Caption   = "Descri" + CHR(231) + CHR(227) + "o = [ * ]   Calculado pelo Peso M" + CHR(233) + "dio do Material"
            .FontName  = "Tahoma"
            .FontBold  = .T.
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
        ENDWITH
    ENDPROC

    *==========================================================================
    * BtnIncluirClick - Inicia novo processamento (gera relatorio do zero)
    *   Form OPERACIONAL: "Incluir" equivale a iniciar nova geracao de relatorio
    *   resetando o estado anterior e executando processamento completo.
    *==========================================================================
    PROCEDURE BtnIncluirClick()
        THIS.this_lProcessamento = .F.
        IF VARTYPE(THIS.this_oBusinessObject) = "O"
            THIS.this_oBusinessObject.this_lProcessamento = .F.
        ENDIF
        THIS.shp_4c_ShpRp.Visible      = .F.
        THIS.cmd_4c_CmdRpview.Visible  = .F.
        THIS.cmd_4c_CmdRpPrint.Visible = .F.
        THIS.BtnProcessarClick()
    ENDPROC

    *==========================================================================
    * BtnAlterarClick - Atualiza dados do relatorio (re-processamento)
    *   Form OPERACIONAL: "Alterar" equivale a atualizar/re-processar os dados
    *   mantendo o estado de processamento ja realizado.
    *==========================================================================
    PROCEDURE BtnAlterarClick()
        IF !THIS.this_lProcessamento
            THIS.BtnProcessarClick()
        ELSE
            LOCAL loc_lSucesso, loc_oErro
            loc_lSucesso = .F.

            THIS.cnt_4c_Aguarde.Visible = .T.
            THIS.cnt_4c_Aguarde.ZOrder(0)
            THIS.Refresh

            TRY
                loc_lSucesso = THIS.this_oBusinessObject.Atualizar(THIS.obj_4c_Arquivos)
            CATCH TO loc_oErro
                MsgErro(loc_oErro.Message, "Erro")
            ENDTRY

            THIS.cnt_4c_Aguarde.Visible = .F.

            IF loc_lSucesso
                IF THIS.obj_4c_Arquivos.ListCount > 0 .AND. ;
                   !EMPTY(THIS.obj_4c_Arquivos.Value)
                    THIS.ArquivosInteractiveChange()
                ENDIF
                THIS.grd_4c_Dados.Refresh
            ENDIF
        ENDIF
    ENDPROC

    *==========================================================================
    * BtnVisualizarClick - Visualiza o relatorio em tela
    *   Form OPERACIONAL: "Visualizar" equivale ao preview do relatorio gerado.
    *   Exige que o processamento ja tenha sido executado.
    *==========================================================================
    PROCEDURE BtnVisualizarClick()
        IF !THIS.this_lProcessamento .OR. !USED("csRel") .OR. RECCOUNT("csRel") = 0
            MsgAviso("Execute o processamento antes de visualizar o relat" + CHR(243) + "rio.", "Aviso")
            RETURN
        ENDIF
        THIS.BtnCmdRpviewClick()
    ENDPROC

    *==========================================================================
    * BtnExcluirClick - Limpa dados do relatorio (reset)
    *   Form OPERACIONAL: "Excluir" equivale a limpar o cursor csRel e resetar
    *   o estado de processamento, ocultando botoes de visualizacao/impressao.
    *==========================================================================
    PROCEDURE BtnExcluirClick()
        IF !MsgConfirma("Deseja realmente limpar os dados do relat" + CHR(243) + "rio?", "Confirma" + CHR(231) + CHR(227) + "o")
            RETURN
        ENDIF

        IF USED("csRel")
            SELECT csRel
            ZAP
        ENDIF

        THIS.this_lProcessamento = .F.
        IF VARTYPE(THIS.this_oBusinessObject) = "O"
            THIS.this_oBusinessObject.this_lProcessamento = .F.
        ENDIF

        THIS.shp_4c_ShpRp.Visible      = .F.
        THIS.cmd_4c_CmdRpview.Visible  = .F.
        THIS.cmd_4c_CmdRpPrint.Visible = .F.
        THIS.grd_4c_Dados.Refresh
    ENDPROC

    *==========================================================================
    * BtnProcessarClick - Processa dados e popula grid
    *==========================================================================
    PROCEDURE BtnProcessarClick()
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        THIS.cnt_4c_Aguarde.Visible = .T.
        THIS.cnt_4c_Aguarde.ZOrder(0)
        THIS.Refresh

        TRY
            IF THIS.this_lProcessamento
                loc_lSucesso = THIS.this_oBusinessObject.Atualizar(THIS.obj_4c_Arquivos)
            ELSE
                loc_lSucesso = THIS.this_oBusinessObject.Inserir(THIS.obj_4c_Arquivos)
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        THIS.cnt_4c_Aguarde.Visible = .F.

        IF loc_lSucesso
            THIS.this_lProcessamento = .T.

            IF USED("csRel") .AND. RECCOUNT("csRel") > 0
                *-- Seleciona primeiro grupo da lista e filtra o grid (padrao original)
                IF THIS.obj_4c_Arquivos.ListCount > 0
                    THIS.obj_4c_Arquivos.ListIndex = 1
                    THIS.ArquivosInteractiveChange()
                ENDIF
                THIS.grd_4c_Dados.Refresh
                THIS.shp_4c_ShpRp.Visible     = .T.
                THIS.cmd_4c_CmdRpview.Visible  = .T.
                THIS.cmd_4c_CmdRpPrint.Visible = .T.
                THIS.obj_4c_Arquivos.SetFocus
            ELSE
                MsgAviso("N" + CHR(227) + "o Existe Movimenta" + CHR(231) + CHR(227) + "o!!!", "Aviso")
            ENDIF
        ENDIF
    ENDPROC

    *==========================================================================
    * BtnCmdRpviewClick - Exibe relatorio em tela (Preview)
    *==========================================================================
    PROCEDURE BtnCmdRpviewClick()
        LOCAL loc_cSub, loc_cRelatorio
        loc_cSub       = ""
        loc_cRelatorio = gc_4c_CaminhoReports + "RelSigPdAco.frx"

        IF !EMPTY(THIS.obj_4c_Arquivos.Value)
            loc_cSub = ALLTRIM(THIS.obj_4c_Arquivos.Value)
        ENDIF

        THIS.this_oBusinessObject.AtualizarCabecalhoRelatorio(loc_cSub)

        IF FILE(loc_cRelatorio)
            REPORT FORM (loc_cRelatorio) PREVIEW NOCONSOLE
        ELSE
            MsgAviso("Relat" + CHR(243) + "rio n" + CHR(227) + "o encontrado:" + CHR(13) + loc_cRelatorio, ;
                     "Relat" + CHR(243) + "rio")
        ENDIF
    ENDPROC

    *==========================================================================
    * BtnCmdRpPrintClick - Imprime relatorio na impressora
    *==========================================================================
    PROCEDURE BtnCmdRpPrintClick()
        LOCAL loc_cSub, loc_cRelatorio
        loc_cSub       = ""
        loc_cRelatorio = gc_4c_CaminhoReports + "RelSigPdAco.frx"

        IF !EMPTY(THIS.obj_4c_Arquivos.Value)
            loc_cSub = ALLTRIM(THIS.obj_4c_Arquivos.Value)
        ENDIF

        THIS.this_oBusinessObject.AtualizarCabecalhoRelatorio(loc_cSub)

        IF FILE(loc_cRelatorio)
            REPORT FORM (loc_cRelatorio) TO PRINTER PROMPT NOCONSOLE
        ELSE
            MsgAviso("Relat" + CHR(243) + "rio n" + CHR(227) + "o encontrado:" + CHR(13) + loc_cRelatorio, ;
                     "Relat" + CHR(243) + "rio")
        ENDIF
    ENDPROC

    *==========================================================================
    * BtnCmdGprocessaClick - Encerra o formulario
    *   par_nButton: indice do botao clicado no CommandGroup (sempre 1)
    *==========================================================================
    PROCEDURE BtnCmdGprocessaClick(par_nButton)
        THIS.Release()
    ENDPROC

    *==========================================================================
    * ArquivosInteractiveChange - Filtra grid pelo grupo selecionado no listbox
    *==========================================================================
    PROCEDURE ArquivosInteractiveChange()
        LOCAL loc_cGrupo

        IF VARTYPE(THIS.obj_4c_Arquivos) = "O" .AND. ;
           !EMPTY(THIS.obj_4c_Arquivos.Value)
            loc_cGrupo = ALLTRIM(LEFT(THIS.obj_4c_Arquivos.Value, 3))
            THIS.this_oBusinessObject.FiltrarPorGrupo(loc_cGrupo)
            THIS.grd_4c_Dados.Refresh
        ENDIF
    ENDPROC

    *==========================================================================
    * ConfigurarGrdDados - Propriedades visuais pixel-perfect das colunas do grid
    *   BackColor por coluna, ReadOnly/Movable/Resizable, Text1 props, DynamicForeColor
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarGrdDados(par_oGrd)
        LOCAL loc_oGrd
        loc_oGrd = par_oGrd

        *-- Coluna 1: Material (laranja - destaque)
        WITH loc_oGrd.Column1
            .BackColor  = RGB(255, 197, 138)
            .ReadOnly   = .T.
            .Movable    = .F.
            .Resizable  = .F.
            .FontName   = "Tahoma"
            .FontSize   = 8
            .Header1.Alignment = 2
            .Header1.FontName  = "Tahoma"
            .Header1.FontSize  = 8
            .Header1.ForeColor = RGB(0, 0, 0)
            .Text1.BackColor   = RGB(255, 197, 138)
            .Text1.ForeColor   = RGB(0, 0, 0)
            .Text1.BorderStyle = 0
            .Text1.Margin      = 0
            .Text1.ReadOnly    = .T.
            .Text1.FontName    = "Tahoma"
            .Text1.FontSize    = 8
        ENDWITH

        *-- Coluna 2: Descricao (branco)
        WITH loc_oGrd.Column2
            .BackColor  = RGB(255, 255, 255)
            .ReadOnly   = .T.
            .Movable    = .F.
            .Resizable  = .F.
            .FontName   = "Tahoma"
            .FontSize   = 8
            .Header1.Alignment = 2
            .Header1.FontName  = "Tahoma"
            .Header1.FontSize  = 8
            .Header1.ForeColor = RGB(0, 0, 0)
            .Text1.BackColor   = RGB(255, 255, 255)
            .Text1.ForeColor   = RGB(0, 0, 0)
            .Text1.BorderStyle = 0
            .Text1.Margin      = 0
            .Text1.ReadOnly    = .T.
            .Text1.FontName    = "Tahoma"
            .Text1.FontSize    = 8
        ENDWITH

        *-- Coluna 3: Unidade (branco)
        WITH loc_oGrd.Column3
            .BackColor  = RGB(255, 255, 255)
            .ReadOnly   = .T.
            .Movable    = .F.
            .Resizable  = .F.
            .FontName   = "Tahoma"
            .FontSize   = 8
            .Header1.Alignment = 2
            .Header1.FontName  = "Tahoma"
            .Header1.FontSize  = 8
            .Header1.ForeColor = RGB(0, 0, 0)
            .Text1.BackColor   = RGB(255, 255, 255)
            .Text1.ForeColor   = RGB(0, 0, 0)
            .Text1.BorderStyle = 0
            .Text1.Margin      = 0
            .Text1.ReadOnly    = .T.
            .Text1.FontName    = "Tahoma"
            .Text1.FontSize    = 8
        ENDWITH

        *-- Coluna 4: Qt.Minima (azul claro)
        WITH loc_oGrd.Column4
            .BackColor  = RGB(201, 204, 248)
            .ReadOnly   = .T.
            .Movable    = .F.
            .Resizable  = .F.
            .FontName   = "Tahoma"
            .FontSize   = 8
            .Header1.Alignment = 2
            .Header1.FontName  = "Tahoma"
            .Header1.FontSize  = 8
            .Header1.ForeColor = RGB(0, 0, 0)
            .Text1.BackColor   = RGB(201, 204, 248)
            .Text1.ForeColor   = RGB(0, 0, 0)
            .Text1.BorderStyle = 0
            .Text1.Margin      = 0
            .Text1.ReadOnly    = .T.
            .Text1.FontName    = "Tahoma"
            .Text1.FontSize    = 8
        ENDWITH

        *-- Coluna 5: Saldo Atual (amarelo claro)
        WITH loc_oGrd.Column5
            .BackColor  = RGB(255, 255, 196)
            .ReadOnly   = .T.
            .Movable    = .F.
            .Resizable  = .F.
            .FontName   = "Tahoma"
            .FontSize   = 8
            .Header1.Alignment = 2
            .Header1.FontName  = "Tahoma"
            .Header1.FontSize  = 8
            .Header1.ForeColor = RGB(0, 0, 0)
            .Text1.BackColor   = RGB(255, 255, 196)
            .Text1.ForeColor   = RGB(0, 0, 0)
            .Text1.BorderStyle = 0
            .Text1.Margin      = 0
            .Text1.ReadOnly    = .T.
            .Text1.FontName    = "Tahoma"
            .Text1.FontSize    = 8
        ENDWITH

        *-- Coluna 6: Requisicao (ciano claro)
        WITH loc_oGrd.Column6
            .BackColor  = RGB(223, 255, 255)
            .ReadOnly   = .T.
            .Movable    = .F.
            .Resizable  = .F.
            .FontName   = "Tahoma"
            .FontSize   = 8
            .Header1.Alignment = 2
            .Header1.FontName  = "Tahoma"
            .Header1.FontSize  = 8
            .Header1.ForeColor = RGB(0, 0, 0)
            .Text1.BackColor   = RGB(223, 255, 255)
            .Text1.ForeColor   = RGB(0, 0, 0)
            .Text1.BorderStyle = 0
            .Text1.Margin      = 0
            .Text1.ReadOnly    = .T.
            .Text1.FontName    = "Tahoma"
            .Text1.FontSize    = 8
        ENDWITH

        *-- Coluna 7: Ped.Compra (rosa claro - Format=Z, editavel para transferencia)
        WITH loc_oGrd.Column7
            .BackColor  = RGB(255, 234, 255)
            .Movable    = .F.
            .Resizable  = .F.
            .Format     = "Z"
            .FontName   = "Tahoma"
            .FontSize   = 8
            .Header1.Alignment = 2
            .Header1.FontName  = "Tahoma"
            .Header1.FontSize  = 8
            .Header1.ForeColor = RGB(0, 0, 0)
            .Text1.BackColor   = RGB(255, 234, 255)
            .Text1.ForeColor   = RGB(0, 0, 0)
            .Text1.BorderStyle = 0
            .Text1.Margin      = 0
            .Text1.FontName    = "Tahoma"
            .Text1.FontSize    = 8
        ENDWITH

        *-- Coluna 8: Compra (pessego claro)
        WITH loc_oGrd.Column8
            .BackColor  = RGB(255, 235, 215)
            .ReadOnly   = .T.
            .Movable    = .F.
            .Resizable  = .F.
            .FontName   = "Tahoma"
            .FontSize   = 8
            .Header1.Alignment = 2
            .Header1.FontName  = "Tahoma"
            .Header1.FontSize  = 8
            .Header1.ForeColor = RGB(0, 0, 0)
            .Text1.BackColor   = RGB(255, 235, 215)
            .Text1.ForeColor   = RGB(0, 0, 0)
            .Text1.BorderStyle = 0
            .Text1.Margin      = 0
            .Text1.ReadOnly    = .T.
            .Text1.FontName    = "Tahoma"
            .Text1.FontSize    = 8
        ENDWITH

        *-- Coluna 9: Empenho (vermelho claro)
        WITH loc_oGrd.Column9
            .BackColor  = RGB(255, 202, 202)
            .ReadOnly   = .T.
            .Movable    = .F.
            .Resizable  = .F.
            .FontName   = "Tahoma"
            .FontSize   = 8
            .Header1.Alignment = 2
            .Header1.FontName  = "Tahoma"
            .Header1.FontSize  = 8
            .Header1.ForeColor = RGB(0, 0, 0)
            .Text1.BackColor   = RGB(255, 202, 202)
            .Text1.ForeColor   = RGB(0, 0, 0)
            .Text1.BorderStyle = 0
            .Text1.Margin      = 0
            .Text1.ReadOnly    = .T.
            .Text1.FontName    = "Tahoma"
            .Text1.FontSize    = 8
        ENDWITH

        *-- Coluna 10: Pos.Final (verde claro)
        WITH loc_oGrd.Column10
            .BackColor  = RGB(220, 255, 220)
            .Movable    = .F.
            .Resizable  = .F.
            .FontName   = "Tahoma"
            .FontSize   = 8
            .Header1.Alignment = 2
            .Header1.FontName  = "Tahoma"
            .Header1.FontSize  = 8
            .Header1.ForeColor = RGB(0, 0, 0)
            .Text1.BackColor   = RGB(220, 255, 220)
            .Text1.ForeColor   = RGB(0, 0, 0)
            .Text1.BorderStyle = 0
            .Text1.Margin      = 0
            .Text1.FontName    = "Tahoma"
            .Text1.FontSize    = 8
        ENDWITH

        *-- DynamicForeColor: Flags=.T. e Seqs<>'2' -> vermelho; Seqs='2' -> azul; else preto
        loc_oGrd.SetAll("DynamicForeColor", ;
            "IIF(csRel.Flags .AND. csRel.Seqs <> [2], RGB(255,0,0), " + ;
            "IIF(csRel.Seqs = [2], RGB(0,0,255), RGB(0,0,0)))", ;
            "Column")
    ENDPROC

    *==========================================================================
    * Destroy - Libera BO e cursores do form
    *==========================================================================
    PROCEDURE Destroy()
        IF VARTYPE(THIS.this_oBusinessObject) = "O"
            THIS.this_oBusinessObject = .NULL.
        ENDIF

        LOCAL loc_aCursores(3), loc_i
        loc_aCursores(1) = "csRel"
        loc_aCursores(2) = "csCab"
        loc_aCursores(3) = "dbCabecalho"

        FOR loc_i = 1 TO 3
            IF USED(loc_aCursores(loc_i))
                USE IN (loc_aCursores(loc_i))
            ENDIF
        ENDFOR

        DODEFAULT()
    ENDPROC

    *==========================================================================
    * BtnBuscarClick - Aciona processamento ou re-filtro do grid
    *   Form OPERACIONAL: se ainda nao processado, executa BtnProcessarClick.
    *   Se ja processado, re-aplica o filtro do grupo selecionado no listbox.
    *==========================================================================
    PROCEDURE BtnBuscarClick()
        IF !THIS.this_lProcessamento
            THIS.BtnProcessarClick()
        ELSE
            THIS.ArquivosInteractiveChange()
            THIS.grd_4c_Dados.Refresh
        ENDIF
    ENDPROC

    *==========================================================================
    * BtnEncerrarClick - Encerra o formulario
    *==========================================================================
    PROCEDURE BtnEncerrarClick()
        THIS.Release()
    ENDPROC

    *==========================================================================
    * BtnSalvarClick - Atualiza cabecalho do relatorio com grupo selecionado
    *   Form OPERACIONAL: nao ha registros editaveis para persistir no banco.
    *   Transfere o grupo ativo como subtitulo para o cursor csCab do relatorio.
    *==========================================================================
    PROCEDURE BtnSalvarClick()
        LOCAL loc_cSub
        loc_cSub = ""

        IF THIS.this_lProcessamento .AND. VARTYPE(THIS.this_oBusinessObject) = "O"
            IF VARTYPE(THIS.obj_4c_Arquivos) = "O" .AND. ;
               !EMPTY(THIS.obj_4c_Arquivos.Value)
                loc_cSub = ALLTRIM(THIS.obj_4c_Arquivos.Value)
            ENDIF
            THIS.this_oBusinessObject.AtualizarCabecalhoRelatorio(loc_cSub)
        ENDIF
    ENDPROC

    *==========================================================================
    * BtnCancelarClick - Cancela processamento atual e reseta o form
    *   Form OPERACIONAL: limpa o cursor csRel, o listbox de grupos e reseta
    *   o flag de processamento para permitir novo ciclo.
    *==========================================================================
    PROCEDURE BtnCancelarClick()
        IF THIS.this_lProcessamento
            IF !MsgConfirma("Deseja cancelar o processamento atual?", ;
                            "Confirma" + CHR(231) + CHR(227) + "o")
                RETURN
            ENDIF
        ENDIF

        THIS.LimparCampos()
    ENDPROC

    *==========================================================================
    * CarregarLista - Atualiza exibicao do grid com dados do cursor csRel
    *   Form OPERACIONAL: nao executa SQL. Aplica filtro de grupo ativo se
    *   houver um selecionado no listbox; caso contrario, remove filtro.
    *==========================================================================
    PROCEDURE CarregarLista()
        IF !USED("csRel")
            RETURN
        ENDIF

        IF VARTYPE(THIS.obj_4c_Arquivos) = "O" .AND. ;
           !EMPTY(THIS.obj_4c_Arquivos.Value)
            THIS.ArquivosInteractiveChange()
        ELSE
            SELECT csRel
            SET ORDER TO TAG GruMat
            SET KEY TO
            GO TOP
        ENDIF

        IF VARTYPE(THIS.grd_4c_Dados) = "O"
            THIS.grd_4c_Dados.Refresh
        ENDIF
    ENDPROC

    *==========================================================================
    * AjustarBotoesPorModo - Gerencia visibilidade de botoes conforme estado
    *   Form OPERACIONAL: mostra/oculta os botoes de relatorio (Video,
    *   Impressora, ShpRp) de acordo com o estado de processamento atual.
    *==========================================================================
    PROCEDURE AjustarBotoesPorModo()
        LOCAL loc_lProcessado
        loc_lProcessado = THIS.this_lProcessamento .AND. ;
                          USED("csRel") .AND. RECCOUNT("csRel") > 0

        IF VARTYPE(THIS.shp_4c_ShpRp) = "O"
            THIS.shp_4c_ShpRp.Visible = loc_lProcessado
        ENDIF
        IF VARTYPE(THIS.cmd_4c_CmdRpview) = "O"
            THIS.cmd_4c_CmdRpview.Visible = loc_lProcessado
        ENDIF
        IF VARTYPE(THIS.cmd_4c_CmdRpPrint) = "O"
            THIS.cmd_4c_CmdRpPrint.Visible = loc_lProcessado
        ENDIF
    ENDPROC

    *==========================================================================
    * HabilitarCampos - Habilita/desabilita controles conforme estado
    *   Form OPERACIONAL: controla o listbox de grupos (apenas quando ha
    *   dados processados). Botao Processar permanece sempre habilitado.
    *==========================================================================
    PROTECTED PROCEDURE HabilitarCampos(par_lHabilitar)
        IF VARTYPE(THIS.obj_4c_Arquivos) = "O"
            THIS.obj_4c_Arquivos.Enabled = par_lHabilitar
        ENDIF
        IF VARTYPE(THIS.cmd_4c_Processar) = "O"
            THIS.cmd_4c_Processar.Enabled = .T.
        ENDIF
    ENDPROC

    *==========================================================================
    * LimparCampos - Limpa dados processados e reseta estado do form
    *   Form OPERACIONAL: zera cursor csRel, limpa listbox, oculta botoes de
    *   relatorio e reseta flags de processamento no form e no BO.
    *==========================================================================
    PROTECTED PROCEDURE LimparCampos()
        IF USED("csRel")
            SELECT csRel
            SET KEY TO
            ZAP
        ENDIF

        IF USED("csCab")
            SELECT csCab
            ZAP
            APPEND BLANK
        ENDIF

        IF VARTYPE(THIS.obj_4c_Arquivos) = "O"
            THIS.obj_4c_Arquivos.Clear()
        ENDIF

        THIS.this_lProcessamento = .F.

        IF VARTYPE(THIS.this_oBusinessObject) = "O"
            THIS.this_oBusinessObject.this_lProcessamento = .F.
            THIS.this_oBusinessObject.this_cGrupoAtual    = ""
        ENDIF

        THIS.AjustarBotoesPorModo()

        IF VARTYPE(THIS.grd_4c_Dados) = "O"
            THIS.grd_4c_Dados.Refresh
        ENDIF
    ENDPROC

    *==========================================================================
    * FormParaBO - Transfere estado do form para o Business Object
    *   Form OPERACIONAL: transfere o grupo selecionado no listbox e o
    *   subtitulo derivado para as propriedades correspondentes do BO.
    *==========================================================================
    PROTECTED PROCEDURE FormParaBO()
        IF VARTYPE(THIS.this_oBusinessObject) != "O"
            RETURN
        ENDIF

        *-- Grupo selecionado no listbox -> BO
        IF VARTYPE(THIS.obj_4c_Arquivos) = "O" .AND. ;
           !EMPTY(THIS.obj_4c_Arquivos.Value)
            THIS.this_oBusinessObject.this_cGrupoAtual = ;
                ALLTRIM(LEFT(THIS.obj_4c_Arquivos.Value, 3))
        ELSE
            THIS.this_oBusinessObject.this_cGrupoAtual = ""
        ENDIF

        *-- Subtitulo do relatorio = grupo ativo
        THIS.this_oBusinessObject.this_cSubTitulo = ;
            THIS.this_oBusinessObject.this_cGrupoAtual
    ENDPROC

    *==========================================================================
    * BOParaForm - Transfere estado do Business Object para o form
    *   Form OPERACIONAL: sincroniza selecao do listbox de grupos com o
    *   filtro ativo no BO e reaplica o filtro no cursor csRel.
    *==========================================================================
    PROTECTED PROCEDURE BOParaForm()
        LOCAL loc_cGrupo, loc_i

        IF VARTYPE(THIS.this_oBusinessObject) != "O"
            RETURN
        ENDIF

        *-- Sincroniza selecao do listbox com grupo ativo no BO
        IF !EMPTY(THIS.this_oBusinessObject.this_cGrupoAtual) .AND. ;
           VARTYPE(THIS.obj_4c_Arquivos) = "O" .AND. ;
           THIS.obj_4c_Arquivos.ListCount > 0
            loc_cGrupo = ALLTRIM(THIS.this_oBusinessObject.this_cGrupoAtual)
            FOR loc_i = 1 TO THIS.obj_4c_Arquivos.ListCount
                IF UPPER(LEFT(ALLTRIM(THIS.obj_4c_Arquivos.List(loc_i)), 3)) = UPPER(loc_cGrupo)
                    THIS.obj_4c_Arquivos.ListIndex = loc_i
                    EXIT
                ENDIF
            ENDFOR
        ENDIF

        *-- Reaplica filtro de grupo no cursor csRel
        IF !EMPTY(THIS.this_oBusinessObject.this_cGrupoAtual)
            THIS.this_oBusinessObject.FiltrarPorGrupo(THIS.this_oBusinessObject.this_cGrupoAtual)
        ENDIF
    ENDPROC

ENDDEFINE


### BO (C:\4c\projeto\app\classes\SigPdAcoBO.prg):
*==============================================================================
* SigPdAcoBO.prg - Business Object: Acompanhamento de Material por Grupo
* Form Operacional - sem tabela principal unica (multi-tabelas)
* Tabelas: SigMvEst, SigCdPro, SigMvCab, SigMvItn, SigCdGrp, SigCdPam, SigCdEmp
*==============================================================================

DEFINE CLASS SigPdAcoBO AS BusinessBase

    *-- Controle de estado do processamento
    this_lProcessamento  = .F.

    *-- Parametros de operacoes carregados de SigCdPam
    this_cDopEmphs   = ""
    this_cDopReqcs   = ""
    this_cDopPedcs   = ""
    this_cDopComps   = ""
    this_cDopTrfCps  = ""

    *-- Cabecalho do relatorio
    this_cTituloRel   = ""
    this_cSubTitulo   = ""
    this_cNomeEmpresa = ""

    *-- Filtro corrente
    this_cGrupoAtual  = ""

    *--------------------------------------------------------------------------
    * Init - Configura BO (form operacional sem tabela CRUD unica)
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        DODEFAULT()
        THIS.this_cTabela     = ""
        THIS.this_cCampoChave = ""
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Mapeia campos do cursor de parametros para this_*
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        IF USED(par_cAliasCursor)
            SELECT (par_cAliasCursor)
            THIS.this_cDopEmphs  = TratarNulo(DopEmphs,  "C")
            THIS.this_cDopReqcs  = TratarNulo(DopReqcs,  "C")
            THIS.this_cDopPedcs  = TratarNulo(DopPedcs,  "C")
            THIS.this_cDopComps  = TratarNulo(DopComps,  "C")
            THIS.this_cDopTrfCps = TratarNulo(DopTrfCps, "C")
            RETURN .T.
        ENDIF
        RETURN .F.
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Form operacional sem chave unica
    *--------------------------------------------------------------------------
    FUNCTION ObterChavePrimaria()
        RETURN ""
    ENDFUNC

    *--------------------------------------------------------------------------
    * Inserir - Executa primeira geracao do relatorio
    *   Form operacional de relatorio: a operacao "Inserir" equivale a executar
    *   o processamento inicial que monta o cursor csRel com saldos atuais,
    *   parametros e empresa. Retorna .T. se o processamento foi bem sucedido
    *   e o cursor csRel ficou disponivel para o Grid.
    *--------------------------------------------------------------------------
    PROCEDURE Inserir(par_oListbox)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            *-- Garante parametros e cursores prontos
            IF EMPTY(THIS.this_cDopEmphs) .AND. EMPTY(THIS.this_cDopReqcs) .AND. ;
               EMPTY(THIS.this_cDopPedcs) .AND. EMPTY(THIS.this_cDopComps) .AND. ;
               EMPTY(THIS.this_cDopTrfCps)
                THIS.CarregarParametros()
            ENDIF

            IF !USED("csRel") .OR. !USED("csCab")
                THIS.CriarCursorRelatorio()
            ENDIF

            *-- Executa processamento real (popula csRel + listbox de grupos)
            loc_lSucesso = THIS.Processar(par_oListbox)

            IF loc_lSucesso
                THIS.this_lProcessamento = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - Re-executa processamento do relatorio
    *   Form operacional de relatorio: a operacao "Atualizar" equivale a
    *   recalcular saldos atuais. Zera csRel, reprocessa do zero e mantem
    *   o filtro de grupo corrente. Usado quando o usuario clica "Processar"
    *   apos primeira execucao para refletir mudancas em estoque.
    *--------------------------------------------------------------------------
    PROCEDURE Atualizar(par_oListbox)
        LOCAL loc_lSucesso, loc_cGrupoAnterior
        loc_lSucesso = .F.
        loc_cGrupoAnterior = THIS.this_cGrupoAtual

        TRY
            *-- Limpa filtro previo para nao interferir no SCAN do Processar
            IF USED("csRel")
                SELECT csRel
                SET KEY TO
                ZAP
            ENDIF

            *-- Reprocessa carregando saldos atuais
            loc_lSucesso = THIS.Processar(par_oListbox)

            IF loc_lSucesso
                THIS.this_lProcessamento = .T.

                *-- Restaura filtro de grupo se havia um ativo
                IF !EMPTY(loc_cGrupoAnterior) .AND. USED("csRel")
                    THIS.FiltrarPorGrupo(loc_cGrupoAnterior)
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarParametros - Carrega parametros de operacao de SigCdPam
    *--------------------------------------------------------------------------
    PROCEDURE CarregarParametros()
        LOCAL loc_lSucesso, loc_cSQL
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "SELECT DopEmphs, DopReqcs, DopPedcs, DopComps, DopTrfCps " + ;
                       "FROM SigCdPam"

            IF USED("cursor_4c_Pam")
                USE IN cursor_4c_Pam
            ENDIF

            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Pam") > 0
                IF !EOF("cursor_4c_Pam")
                    THIS.CarregarDoCursor("cursor_4c_Pam")
                    loc_lSucesso = .T.
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarEmpresa - Carrega nome da empresa logada para this_cNomeEmpresa
    *--------------------------------------------------------------------------
    PROCEDURE CarregarEmpresa()
        LOCAL loc_cSQL, loc_cCodEmp
        loc_cCodEmp = go_4c_Sistema.cCodEmpresa

        TRY
            loc_cSQL = "SELECT Cemps, Razas FROM SigCdEmp"

            IF USED("cursor_4c_Emp")
                USE IN cursor_4c_Emp
            ENDIF

            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Emp") > 0
                SELECT cursor_4c_Emp
                LOCATE FOR ALLTRIM(Cemps) = ALLTRIM(loc_cCodEmp)
                IF FOUND()
                    THIS.this_cNomeEmpresa = ALLTRIM(loc_cCodEmp) + " - " + ALLTRIM(TratarNulo(Razas, "C"))
                ELSE
                    THIS.this_cNomeEmpresa = ALLTRIM(loc_cCodEmp)
                ENDIF
            ELSE
                THIS.this_cNomeEmpresa = ALLTRIM(loc_cCodEmp)
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * CriarCursorRelatorio - Cria cursores csRel e csCab para o relatorio
    *                        Estrutura IDENTICA a do Load original
    *--------------------------------------------------------------------------
    PROCEDURE CriarCursorRelatorio()
        IF USED("csCab")
            USE IN csCab
        ENDIF
        IF USED("csRel")
            USE IN csRel
        ENDIF

        CREATE CURSOR csCab (cbemp C(60), cbtit C(100), cbsubtit C(100))
        APPEND BLANK

        SET NULL ON
        CREATE CURSOR csRel ( ;
            Cgrus    C(3)    NULL, ;
            Mats     C(10)   NULL, ;
            Dcompos  C(30)   NULL, ;
            Qtds     N(10,3) NULL, ;
            QtdMins  N(10,3) NULL, ;
            CUnis    C(3)    NULL, ;
            QtdReqs  N(10,3) NULL, ;
            QtdPedcs N(10,3) NULL, ;
            QtdComps N(10,3) NULL, ;
            QtdEmphs N(10,3) NULL, ;
            QtdPfins N(10,3) NULL, ;
            QtdPfMs  N(12,3) NULL, ;
            Flags    L       NULL, ;
            Mat2s    C(10)   NULL, ;
            Dcompo2s C(30)   NULL, ;
            Seqs     C(1)    NULL, ;
            PesoMs   N(12,3) NULL  ;
        )
        SET NULL OFF

        INDEX ON Cgrus + Mats + Seqs TAG GruMat
        INDEX ON Mats + CUnis TAG Mats
    ENDPROC

    *--------------------------------------------------------------------------
    * Processar - Processa saldos e movimentacoes por grupo de material
    *             Popula cursor csRel. par_oListbox recebe grupos encontrados.
    *--------------------------------------------------------------------------
    PROCEDURE Processar(par_oListbox)
        LOCAL loc_lSucesso, loc_cSQL, loc_cCodEmp, loc_cEmpGE
        LOCAL loc_nX, loc_cOperBusca, loc_cCampo, loc_cEdI, loc_cEdF, loc_qtMin
        LOCAL loc_cCPros_s, loc_cDPros_s, loc_cCUnis_s, loc_cCGrus_s, loc_cCUniPs_s
        LOCAL loc_nQMins_s, loc_nPesoMs_s, loc_nSqtds_s, loc_nSPesos_s
        LOCAL loc_cCPros_o, loc_cCUnis_o, loc_cCUniPs_o, loc_cCGrus_o, loc_cDPros_o
        LOCAL loc_nQMins_o, loc_nPesoMs_o, loc_nQtdDiff_o

        loc_lSucesso = .F.
        loc_cCodEmp  = go_4c_Sistema.cCodEmpresa

        TRY
            *-- Prepara titulo e cabecalho do relatorio
            THIS.this_cTituloRel = "Relat" + CHR(243) + "rio de Acompanhamento de Material por Grupo"
            THIS.this_cSubTitulo = " "
            THIS.CarregarEmpresa()

            IF USED("csCab")
                SELECT csCab
                REPLACE cbemp    WITH THIS.this_cNomeEmpresa, ;
                        cbtit    WITH THIS.this_cTituloRel,   ;
                        cbsubtit WITH THIS.this_cSubTitulo
            ENDIF

            *-- Zera ou (re)cria csRel
            IF USED("csRel")
                SELECT csRel
                ZAP
            ELSE
                THIS.CriarCursorRelatorio()
            ENDIF

            *-- Carrega grupos validos (crGrupo com index por Cgrus)
            loc_cSQL = "SELECT Cgrus, Dgrus FROM SigCdGrp " + ;
                       "WHERE NOT GruEstPs = '" + SPACE(10) + "' AND " + ;
                             "NOT ConEstPs = '" + SPACE(10) + "'"

            IF USED("crGrupo")
                USE IN crGrupo
            ENDIF

            IF SQLEXEC(gnConnHandle, loc_cSQL, "crGrupo") < 1
                MsgAviso("Falha na conex" + CHR(227) + "o (crGrupo)", "Aviso")
                loc_lSucesso = loc_lSucesso
            ENDIF
            SELECT crGrupo
            INDEX ON Cgrus TAG Cgrus

            *-- Carrega combinacoes Grupos/Estos para busca no estoque
            loc_cSQL = "SELECT DISTINCT GruEstPs AS Grupos, ConEstps AS Estos " + ;
                       "FROM SigCdGrp " + ;
                       "WHERE NOT GruEstPs = '" + SPACE(10) + "' AND " + ;
                             "NOT ConEstPs = '" + SPACE(10) + "'"

            IF USED("crSigCdGrp")
                USE IN crSigCdGrp
            ENDIF

            IF SQLEXEC(gnConnHandle, loc_cSQL, "crSigCdGrp") < 1
                MsgAviso("Falha na conex" + CHR(227) + "o (crSigCdGrp)", "Aviso")
                loc_lSucesso = loc_lSucesso
            ENDIF

            *-- Cria cursor acumulador de estoque (writable) com campos necessarios
            IF USED("pEstoque")
                USE IN pEstoque
            ENDIF
            SET NULL ON
            CREATE CURSOR pEstoque (CPros C(10) NULL, Sqtds N(10,3) NULL, sPesos N(12,3) NULL)
            SET NULL OFF

            IF RECCOUNT("crSigCdGrp") = 1
                *-- Grupo unico: busca estoque diretamente
                SELECT crSigCdGrp
                GO TOP
                loc_cEmpGE = loc_cCodEmp + crSigCdGrp.Grupos + crSigCdGrp.Estos

                loc_cSQL = "SELECT CPros, Sqtds, sPesos FROM SigMvEst " + ;
                           "WHERE EmpGruEsts = " + EscaparSQL(loc_cEmpGE) + " AND NOT Sqtds = 0"

                IF USED("cursor_4c_EstTemp")
                    USE IN cursor_4c_EstTemp
                ENDIF

                IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_EstTemp") < 1
                    MsgAviso("Falha na conex" + CHR(227) + "o (pEstoque)", "Aviso")
                    loc_lSucesso = loc_lSucesso
                ENDIF

                SELECT cursor_4c_EstTemp
                SCAN
                    SCATTER MEMVAR
                    INSERT INTO pEstoque FROM MEMVAR
                ENDSCAN
            ELSE
                *-- Multiplos grupos: acumula em pEstoque
                SELECT crSigCdGrp
                SCAN
                    loc_cEmpGE = loc_cCodEmp + crSigCdGrp.Grupos + crSigCdGrp.Estos

                    loc_cSQL = "SELECT CPros, Sqtds, sPesos FROM SigMvEst " + ;
                               "WHERE EmpGruEsts = " + EscaparSQL(loc_cEmpGE) + " AND NOT Sqtds = 0"

                    IF USED("cursor_4c_TmpEst")
                        USE IN cursor_4c_TmpEst
                    ENDIF

                    IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_TmpEst") < 1
                        LOOP
                    ENDIF

                    SELECT cursor_4c_TmpEst
                    SCAN
                        SCATTER MEMVAR
                        INSERT INTO pEstoque FROM MEMVAR
                    ENDSCAN
                ENDSCAN
            ENDIF

            *-- Preenche listbox de grupos (Cgrus-Dgrus)
            IF TYPE("par_oListbox") = "O" .AND. !ISNULL(par_oListbox)
                par_oListbox.Clear()
                SELECT crGrupo
                GO TOP
                SCAN
                    par_oListbox.AddItem(ALLTRIM(crGrupo.Cgrus) + "-" + ALLTRIM(crGrupo.Dgrus))
                ENDSCAN
            ENDIF

            *-- Popula csRel com saldo atual de estoque por produto/unidade
            SELECT pEstoque
            GO TOP
            SCAN
                loc_cCPros_s = pEstoque.CPros

                loc_cSQL = "SELECT DPros, CUnis, CGrus, QMins, cUniPs, PesoMs " + ;
                           "FROM SigCdPro WHERE CPros = " + EscaparSQL(ALLTRIM(loc_cCPros_s))

                IF USED("crSigCdPro")
                    USE IN crSigCdPro
                ENDIF

                IF SQLEXEC(gnConnHandle, loc_cSQL, "crSigCdPro") <= 0 .OR. EOF("crSigCdPro")
                    LOOP
                ENDIF

                SELECT crSigCdPro
                loc_cDPros_s  = TratarNulo(DPros,  "C")
                loc_cCUnis_s  = TratarNulo(CUnis,  "C")
                loc_cCGrus_s  = TratarNulo(CGrus,  "C")
                loc_cCUniPs_s = TratarNulo(cUniPs, "C")
                loc_nQMins_s  = TratarNulo(QMins,  "N")
                loc_nPesoMs_s = TratarNulo(PesoMs, "N")

                *-- Produto deve pertencer a um grupo valido
                IF !SEEK(crSigCdPro.CGrus, "crGrupo", "Cgrus")
                    LOOP
                ENDIF

                SELECT pEstoque
                loc_nSqtds_s  = TratarNulo(Sqtds,  "N")
                loc_nSPesos_s = TratarNulo(sPesos,  "N")

                *-- Linha unidade primaria (Seqs='1')
                SELECT csRel
                IF !SEEK(loc_cCPros_s + loc_cCUnis_s, "csRel", "Mats")
                    APPEND BLANK
                ENDIF

                REPLACE Qtds     WITH Qtds + loc_nSqtds_s, ;
                        QtdMins  WITH loc_nQMins_s, ;
                        Mats     WITH loc_cCPros_s, ;
                        Mat2s    WITH loc_cCPros_s, ;
                        Dcompos  WITH loc_cDPros_s, ;
                        Dcompo2s WITH loc_cDPros_s, ;
                        CUnis    WITH loc_cCUnis_s, ;
                        CGrus    WITH loc_cCGrus_s, ;
                        Seqs     WITH "1"

                *-- Linha unidade alternativa por peso (Seqs='2')
                IF !EMPTY(loc_cCUniPs_s) .AND. loc_nPesoMs_s <> 0
                    loc_qtMin = ROUND(loc_nQMins_s / loc_nPesoMs_s, 0)

                    SELECT csRel
                    IF !SEEK(loc_cCPros_s + loc_cCUniPs_s, "csRel", "Mats")
                        APPEND BLANK
                    ENDIF

                    REPLACE Qtds     WITH Qtds + loc_nSPesos_s, ;
                            QtdMins  WITH loc_qtMin, ;
                            Mats     WITH loc_cCPros_s, ;
                            Dcompos  WITH loc_cDPros_s, ;
                            CUnis    WITH loc_cCUniPs_s, ;
                            CGrus    WITH loc_cCGrus_s, ;
                            PesoMs   WITH loc_nPesoMs_s, ;
                            Seqs     WITH "2"
                ENDIF
            ENDSCAN

            *-- Processa 5 tipos de operacao: Empenho(1), Requisicao(2),
            *   PedidoCompra(3), Compra(4), TransferenciaCompra(5->QtdComps)
            FOR loc_nX = 1 TO 5
                DO CASE
                    CASE loc_nX = 1
                        loc_cOperBusca = THIS.this_cDopEmphs
                        loc_cCampo     = "QtdEmphs"
                    CASE loc_nX = 2
                        loc_cOperBusca = THIS.this_cDopReqcs
                        loc_cCampo     = "QtdReqs"
                    CASE loc_nX = 3
                        loc_cOperBusca = THIS.this_cDopPedcs
                        loc_cCampo     = "QtdPedcs"
                    CASE loc_nX = 4
                        loc_cOperBusca = THIS.this_cDopComps
                        loc_cCampo     = "QtdComps"
                    CASE loc_nX = 5
                        loc_cOperBusca = THIS.this_cDopTrfCps
                        loc_cCampo     = "QtdComps"
                ENDCASE

                IF EMPTY(loc_cOperBusca)
                    LOOP
                ENDIF

                loc_cEdI = loc_cCodEmp + loc_cOperBusca + STR(0,      6)
                loc_cEdF = loc_cCodEmp + loc_cOperBusca + STR(999999, 6)

                loc_cSQL = "SELECT b.EmpDopNums, b.CPros, b.Qtds, b.QtBaixas, " + ;
                           "c.Cgrus, c.QMins, c.Dpros, c.CUnis, c.cUnips, c.PesoMs " + ;
                           "FROM SigMvCab a, SigMvItn b, SigCdPro c " + ;
                           "WHERE a.EmpDopNums BETWEEN " + EscaparSQL(loc_cEdI) + " AND " + EscaparSQL(loc_cEdF) + " AND " + ;
                                 "a.EmpDopNums = b.EmpDopNums AND " + ;
                                 "NOT ((b.Qtds - b.QtBaixas) = 0) AND " + ;
                                 "b.CPros = c.CPros " + ;
                           "ORDER BY b.EmpDopNums, b.CPros, b.Qtds, b.QtBaixas, " + ;
                                    "c.Cgrus, c.QMins, c.Dpros, c.CUnis"

                IF USED("crOperacao")
                    USE IN crOperacao
                ENDIF

                IF SQLEXEC(gnConnHandle, loc_cSQL, "crOperacao") < 1
                    LOOP
                ENDIF

                SELECT crOperacao
                SCAN
                    IF !SEEK(crOperacao.Cgrus, "crGrupo", "Cgrus")
                        LOOP
                    ENDIF

                    loc_cCPros_o   = crOperacao.CPros
                    loc_cCUnis_o   = crOperacao.CUnis
                    loc_cCUniPs_o  = TratarNulo(crOperacao.cUnips, "C")
                    loc_cCGrus_o   = crOperacao.Cgrus
                    loc_cDPros_o   = TratarNulo(crOperacao.Dpros,  "C")
                    loc_nQMins_o   = TratarNulo(crOperacao.QMins,  "N")
                    loc_nPesoMs_o  = TratarNulo(crOperacao.PesoMs, "N")
                    loc_nQtdDiff_o = TratarNulo(crOperacao.Qtds, "N") - TratarNulo(crOperacao.QtBaixas, "N")

                    *-- Linha unidade primaria
                    SELECT csRel
                    IF !SEEK(loc_cCPros_o + loc_cCUnis_o, "csRel", "Mats")
                        APPEND BLANK
                        REPLACE QtdMins  WITH loc_nQMins_o, ;
                                Mats     WITH loc_cCPros_o, ;
                                Dcompos  WITH loc_cDPros_o, ;
                                Mat2s    WITH loc_cCPros_o, ;
                                Dcompo2s WITH loc_cDPros_o, ;
                                CUnis    WITH loc_cCUnis_o, ;
                                CGrus    WITH loc_cCGrus_o, ;
                                PesoMs   WITH loc_nPesoMs_o, ;
                                Seqs     WITH "1"
                    ENDIF

                    DO CASE
                        CASE loc_cCampo = "QtdEmphs"
                            REPLACE QtdEmphs WITH QtdEmphs + loc_nQtdDiff_o
                        CASE loc_cCampo = "QtdReqs"
                            REPLACE QtdReqs  WITH QtdReqs  + loc_nQtdDiff_o
                        CASE loc_cCampo = "QtdPedcs"
                            REPLACE QtdPedcs WITH QtdPedcs + loc_nQtdDiff_o
                        CASE loc_cCampo = "QtdComps"
                            REPLACE QtdComps WITH QtdComps + loc_nQtdDiff_o
                    ENDCASE

                    *-- Linha unidade alternativa por peso
                    IF !EMPTY(loc_cCUniPs_o) .AND. loc_nPesoMs_o <> 0
                        loc_qtMin = ROUND(loc_nQMins_o / loc_nPesoMs_o, 0)

                        SELECT csRel
                        IF !SEEK(loc_cCPros_o + loc_cCUniPs_o, "csRel", "Mats")
                            APPEND BLANK
                            REPLACE QtdMins  WITH loc_qtMin, ;
                                    Mats     WITH loc_cCPros_o, ;
                                    Dcompos  WITH loc_cDPros_o, ;
                                    CUnis    WITH loc_cCUniPs_o, ;
                                    CGrus    WITH loc_cCGrus_o, ;
                                    PesoMs   WITH loc_nPesoMs_o, ;
                                    Seqs     WITH "2"
                        ENDIF

                        DO CASE
                            CASE loc_cCampo = "QtdEmphs"
                                REPLACE QtdEmphs WITH QtdEmphs + loc_nQtdDiff_o
                            CASE loc_cCampo = "QtdReqs"
                                REPLACE QtdReqs  WITH QtdReqs  + loc_nQtdDiff_o
                            CASE loc_cCampo = "QtdPedcs"
                                REPLACE QtdPedcs WITH QtdPedcs + loc_nQtdDiff_o
                            CASE loc_cCampo = "QtdComps"
                                REPLACE QtdComps WITH QtdComps + loc_nQtdDiff_o
                        ENDCASE
                    ENDIF
                ENDSCAN
            ENDFOR

            *-- Calcula posicao final e flag de alerta (linhas Seqs='2' em peso)
            SELECT csRel
            SCAN
                IF Seqs = "2"
                    REPLACE QtdReqs  WITH ROUND(QtdReqs  / PesoMs, 0), ;
                            QtdPedcs WITH ROUND(QtdPedcs / PesoMs, 0), ;
                            QtdComps WITH ROUND(QtdComps / PesoMs, 0), ;
                            QtdEmphs WITH ROUND(QtdEmphs / PesoMs, 0), ;
                            Dcompo2s WITH PADC("*", 35)
                ENDIF
                REPLACE QtdPfins WITH (Qtds - QtdMins + QtdReqs + QtdPedcs + QtdComps - QtdEmphs)
                REPLACE Flags    WITH IIF(QtdReqs > 0 .AND. QtdPfins > 0, .T., .F.)
            ENDSCAN

            THIS.this_lProcessamento = .T.
            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * FiltrarPorGrupo - Aplica filtro SET KEY no cursor csRel pelo grupo
    *--------------------------------------------------------------------------
    PROCEDURE FiltrarPorGrupo(par_cGrupo)
        THIS.this_cGrupoAtual = ALLTRIM(LEFT(par_cGrupo, 3))

        IF USED("csRel")
            SELECT csRel
            SET ORDER TO TAG GruMat
            SET KEY TO THIS.this_cGrupoAtual
            GO TOP
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * AtualizarCabecalhoRelatorio - Atualiza subtitulo no cursor csCab
    *--------------------------------------------------------------------------
    PROCEDURE AtualizarCabecalhoRelatorio(par_cSubTitulo)
        THIS.this_cSubTitulo = par_cSubTitulo
        IF USED("csCab")
            SELECT csCab
            REPLACE cbsubtit WITH par_cSubTitulo
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * Destroy - Libera cursores auxiliares criados pelo BO
    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
        LOCAL loc_aCursores(9), loc_i
        loc_aCursores(1) = "cursor_4c_Pam"
        loc_aCursores(2) = "cursor_4c_Emp"
        loc_aCursores(3) = "crGrupo"
        loc_aCursores(4) = "crSigCdGrp"
        loc_aCursores(5) = "pEstoque"
        loc_aCursores(6) = "crOperacao"
        loc_aCursores(7) = "crSigCdPro"
        loc_aCursores(8) = "cursor_4c_EstTemp"
        loc_aCursores(9) = "cursor_4c_TmpEst"

        FOR loc_i = 1 TO 9
            IF USED(loc_aCursores(loc_i))
                USE IN (loc_aCursores(loc_i))
            ENDIF
        ENDFOR

        DODEFAULT()
    ENDPROC

ENDDEFINE


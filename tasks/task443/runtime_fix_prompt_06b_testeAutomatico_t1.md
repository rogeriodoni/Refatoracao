# CORRIGIR ERRO DE RUNTIME VFP9

## TAREFA OBRIGATORIA
O formulario VFP9 apresentou erro de runtime durante teste automatizado.
Voce DEVE corrigir o erro e salvar os arquivos corrigidos usando Write tool.

## ERRO DETECTADO
- Etapa: 06b_testeAutomatico
- Tentativa: 1/10
- Mensagem: TIMEOUT: VFP9 travou durante teste automatico (300s). Possivel erro de runtime (Property not found, dialog modal).

## CONTEXTO DO ERRO

### LOG DA ETAPA (06b_testeAutomatico):
[2026-08-08 12:25:38] [INFO] === VFP EXECUTOR v2.0 ===
[2026-08-08 12:25:38] [INFO] Config FPW: (nao fornecido)
[2026-08-08 12:25:38] [INFO] Script PRG: C:\4c\projeto\app\utils\TesteAutomatico.prg
[2026-08-08 12:25:38] [INFO] Timeout: 300 segundos
[2026-08-08 12:25:38] [INFO] Wrapper PRG criado para parametros: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_eocjrybl.prg
[2026-08-08 12:25:38] [INFO] Conteudo do wrapper:
[2026-08-08 12:25:38] [INFO] * Auto-generated wrapper for parameters
* Script: C:\4c\projeto\app\utils\TesteAutomatico.prg
* Parameters: 'FormGrupo', 'C:\4c\tasks\task443', 'OPERACIONAL'

* Anti-dialog protections for unattended execution
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
SET NOTIFY OFF
SYS(2335, 0)

DO "C:\4c\projeto\app\utils\TesteAutomatico" WITH 'FormGrupo', 'C:\4c\tasks\task443', 'OPERACIONAL'
QUIT

[2026-08-08 12:25:38] [INFO] Comando VFP: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_eocjrybl.prg
[2026-08-08 12:25:38] [INFO] VFP output esperado em: C:\4c\tasks\task443\vfp_output.txt
[2026-08-08 12:25:38] [INFO] Executando Visual FoxPro 9...
[2026-08-08 12:25:38] [INFO] Comando completo: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_eocjrybl.prg
[2026-08-08 12:25:38] [INFO] Executando: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_eocjrybl.prg
[2026-08-08 12:25:38] [INFO] Timeout configurado: 300 segundos
[2026-08-08 12:30:38] [ERROR] TIMEOUT: VFP9 nao finalizou em 300 segundos. Encerrando processo (PID: 7400)...
[2026-08-08 12:30:40] [INFO] VFP9 finalizado em 302.0764551 segundos
[2026-08-08 12:30:40] [INFO] Exit Code: 4
[2026-08-08 12:30:40] [INFO] 
[2026-08-08 12:30:40] [INFO] Arquivos temporarios preservados para inspecao:
[2026-08-08 12:30:40] [INFO]   Wrapper.prg: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_eocjrybl.prg
[2026-08-08 12:30:40] [INFO] 
[2026-08-08 12:30:40] [INFO] === Conteudo do Wrapper.prg temporario ===
[2026-08-08 12:30:40] [INFO] * Auto-generated wrapper for parameters
[2026-08-08 12:30:40] [INFO] * Script: C:\4c\projeto\app\utils\TesteAutomatico.prg
[2026-08-08 12:30:40] [INFO] * Parameters: 'FormGrupo', 'C:\4c\tasks\task443', 'OPERACIONAL'
[2026-08-08 12:30:40] [INFO] 
[2026-08-08 12:30:40] [INFO] * Anti-dialog protections for unattended execution
[2026-08-08 12:30:40] [INFO] SET SAFETY OFF
[2026-08-08 12:30:40] [INFO] SET RESOURCE OFF
[2026-08-08 12:30:40] [INFO] SET TALK OFF
[2026-08-08 12:30:40] [INFO] SET NOTIFY OFF
[2026-08-08 12:30:40] [INFO] SYS(2335, 0)
[2026-08-08 12:30:40] [INFO] 
[2026-08-08 12:30:40] [INFO] DO "C:\4c\projeto\app\utils\TesteAutomatico" WITH 'FormGrupo', 'C:\4c\tasks\task443', 'OPERACIONAL'
[2026-08-08 12:30:40] [INFO] QUIT
[2026-08-08 12:30:40] [INFO] 
[2026-08-08 12:30:40] [INFO] === Fim do Wrapper.prg ===
[2026-08-08 12:30:40] [ERROR] TIMEOUT: VFP9 excedeu o tempo limite de 300 segundos e foi encerrado forcadamente



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

### FORM (C:\4c\projeto\app\forms\operacionais\FormGrupo.prg):
*==============================================================================
* FormGrupo.prg - Gerenciamento de Grupos de Produto por Operacao
* Form operacional popup: aberto pelo form pai de Operacoes (SigCdOpe)
* Original: SIGCDGRP.SCX
*==============================================================================
DEFINE CLASS FormGrupo AS FormBase

    *-- Referencia ao form pai (desabilitado enquanto este form esta aberto)
    this_oParentForm = .NULL.

    *-- Propriedades visuais (replicadas do SIGCDGRP)
    DataSession  = 2
    ShowWindow = 1
    Height       = 400
    Width        = 800
    AutoCenter   = .T.
    TitleBar     = 0
    ControlBox   = .F.
    Movable      = .F.
    ClipControls = .F.
    BorderStyle  = 2
    WindowType   = 1

    *==========================================================================
    * Init - Inicializa o popup de grupos
    * par_oForm    : referencia ao form pai (FormSigCdOpe ou similar)
    * par_nDataSes : numero da datasession do pai (onde crSigCdOpe esta aberto)
    *==========================================================================
    PROCEDURE Init(par_oForm, par_nDataSes)
        LOCAL loc_lSucesso, loc_cDopes, loc_nMinhaSessao, loc_oErro

        loc_lSucesso     = .F.
        loc_nMinhaSessao = DATASESSION()

        TRY
            *-- Guardar referencia ao pai e desabilita-lo
            THIS.this_oParentForm         = par_oForm
            THIS.this_oParentForm.Enabled = .F.

            *-- Ler codigo da operacao na datasession do pai (onde crSigCdOpe existe)
            SET DATASESSION TO par_nDataSes
            loc_cDopes = ALLTRIM(crSigCdOpe.Dopes)
            SET DATASESSION TO loc_nMinhaSessao

            *-- Criar Business Object
            THIS.this_oBusinessObject = CREATEOBJECT("GrpBO")
            IF VARTYPE(THIS.this_oBusinessObject) != "O"
                MsgErro("Erro ao criar GrupoBO." + CHR(13) + ;
                        "VARTYPE retornou: " + VARTYPE(THIS.this_oBusinessObject), ;
                        "Erro")
                THIS.this_oParentForm.Enabled = .T.
                loc_lSucesso = .F.
            ENDIF

            *-- Carregar grupos existentes da operacao do SQL Server
            IF !THIS.this_oBusinessObject.InicializarDados(loc_cDopes)
                THIS.this_oParentForm.Enabled = .T.
                loc_lSucesso = .F.
            ENDIF

            *-- DODEFAULT chama FormBase.Init (fix datas DataSession=2) + InicializarForm
            loc_lSucesso = DODEFAULT()

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Erro ao abrir Grupos de Produtos")
            IF VARTYPE(THIS.this_oParentForm) = "O"
                THIS.this_oParentForm.Enabled = .T.
            ENDIF
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * InicializarForm - Cria a interface do usuario
    *==========================================================================
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lSucesso, loc_cTitulo, loc_oErro

        loc_lSucesso = .F.

        TRY
            *-- Titulo baseado na operacao carregada
            loc_cTitulo = "Grupos de Produtos " + ;
                          ALLTRIM(THIS.this_oBusinessObject.this_cDopes)
            THIS.Caption = loc_cTitulo

            *-- Fundo do form (new_background.jpg do legado)
            IF FILE(gc_4c_CaminhoIcones + "new_background.jpg")
                THIS.Picture = gc_4c_CaminhoIcones + "new_background.jpg"
            ENDIF

            *-- Criar containers e controles
            THIS.ConfigurarPageFrame()

            *-- Setar caption nos labels do cabecalho
            THIS.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
            THIS.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption

            *-- Tornar controles visiveis
            THIS.TornarControlesVisiveis(THIS)

            loc_lSucesso = .T.

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Erro em InicializarForm")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * ConfigurarPageFrame - Cria os containers base do form operacional
    * Form OPERACIONAL sem PageFrame (SIGCDGRP legado eh single-page)
    * Fase 3: apenas cabecalho (cnt_4c_Cabecalho)
    * Fase 4: grid + botoes de acao
    * Fase 5-6: campo Grande Grupo + label
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPageFrame()
        LOCAL loc_oErro

        TRY
            *-- Cabecalho escuro (cntSombra do legado: Top=-1, W=800, H=80)
            THIS.AddObject("cnt_4c_Cabecalho", "Container")
            WITH THIS.cnt_4c_Cabecalho
                .Top         = -1
                .Left        = 0
                .Width       = THIS.Width
                .Height      = 80
                .BackStyle   = 1
                .BackColor   = RGB(100,100,100)
                .BorderWidth = 0
                .Visible     = .T.
            ENDWITH

            THIS.cnt_4c_Cabecalho.AddObject("lbl_4c_Sombra", "Label")
            WITH THIS.cnt_4c_Cabecalho.lbl_4c_Sombra
                .FontBold  = .T.
                .FontName  = "Tahoma"
                .FontSize  = 18
                .WordWrap  = .T.
                .Alignment = 0
                .BackStyle = 0
                .AutoSize  = .F.
                .Caption   = ""
                .Height    = 40
                .Left      = 10
                .Top       = 18
                .Width     = 769
                .ForeColor = RGB(0,0,0)
            ENDWITH

            THIS.cnt_4c_Cabecalho.AddObject("lbl_4c_Titulo", "Label")
            WITH THIS.cnt_4c_Cabecalho.lbl_4c_Titulo
                .FontBold  = .T.
                .FontName  = "Tahoma"
                .FontSize  = 18
                .WordWrap  = .T.
                .Alignment = 0
                .BackStyle = 0
                .AutoSize  = .F.
                .Caption   = ""
                .Height    = 46
                .Left      = 10
                .Top       = 17
                .Width     = 769
                .ForeColor = RGB(255,255,255)
            ENDWITH

            THIS.ConfigurarPaginaLista()
            THIS.ConfigurarPaginaDados()

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Erro em ConfigurarLayout")
        ENDTRY
    ENDPROC

    *==========================================================================
    * TornarControlesVisiveis - Torna controles visiveis recursivamente
    * Sem filtros de containers flutuantes (este form nao possui)
    *==========================================================================
    PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
        LOCAL loc_nI, loc_oControl

        FOR loc_nI = 1 TO par_oContainer.ControlCount
            loc_oControl = par_oContainer.Controls(loc_nI)
            IF VARTYPE(loc_oControl) = "O"
                IF PEMSTATUS(loc_oControl, "Visible", 5)
                    loc_oControl.Visible = .T.
                ENDIF
                IF PEMSTATUS(loc_oControl, "ControlCount", 5) AND ;
                   loc_oControl.ControlCount > 0
                    THIS.TornarControlesVisiveis(loc_oControl)
                ENDIF
            ENDIF
        ENDFOR
    ENDPROC

    *==========================================================================
    * Destroy - Libera recursos e reabilita form pai ao fechar
    *==========================================================================
    PROCEDURE Destroy()
        IF VARTYPE(THIS.this_oParentForm) = "O"
            THIS.this_oParentForm.Enabled = .T.
            THIS.this_oParentForm         = .NULL.
        ENDIF
        IF VARTYPE(THIS.this_oBusinessObject) = "O"
            THIS.this_oBusinessObject.LiberarCursores()
            THIS.this_oBusinessObject = .NULL.
        ENDIF
        DODEFAULT()
    ENDPROC

    *==========================================================================
    * ConfigurarPaginaLista - Cria grid e botoes de acao do form operacional
    * Grid grd_4c_Dados: lista grupos editaveis da operacao (cursor_4c_Ope)
    * Botoes standalone: Inserir, Excluir, Confirmar, Cancelar
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPaginaLista()
        LOCAL loc_oErro

        TRY
            *-- Grid de grupos (GradeOpe do legado: Top=115, Left=236, W=264, H=274)
            THIS.AddObject("grd_4c_Dados", "Grid")
            THIS.grd_4c_Dados.ColumnCount  = 2
            THIS.grd_4c_Dados.RecordSource = "cursor_4c_Ope"
            THIS.grd_4c_Dados.Column1.ControlSource = "cursor_4c_Ope.Cgrus"
            THIS.grd_4c_Dados.Column2.ControlSource = "cursor_4c_Ope.Dgrus"
            WITH THIS.grd_4c_Dados
                .Top          = 115
                .Left         = 236
                .Width        = 264
                .Height       = 274
                .RecordMark   = .F.
                .DeleteMark   = .F.
                .RowHeight    = 16
                .ScrollBars   = 2
                .FontName     = "Tahoma"
                .FontSize     = 8
                .ForeColor    = RGB(90,90,90)
                .GridLineColor      = RGB(238,238,238)
                .HighlightBackColor = RGB(255,255,255)
                .HighlightForeColor = RGB(15,41,104)
                .HighlightStyle     = 2

                WITH .Column1
                    .ControlSource = "cursor_4c_Ope.Cgrus"
                    .Width         = 50
                    .Movable       = .F.
                    .Resizable     = .F.
                    .FontName      = "Tahoma"
                    .FontSize      = 8
                    .ForeColor     = RGB(90,90,90)
                    .Header1.Caption   = "Grupo"
                    .Header1.FontName  = "Tahoma"
                    .Header1.FontSize  = 8
                    .Header1.Alignment = 2
                    .Header1.ForeColor = RGB(36,84,155)
                    WITH .Text1
                        .BorderStyle = 0
                        .Margin      = 0
                        .ForeColor   = RGB(90,90,90)
                        .BackColor   = RGB(255,255,255)
                    ENDWITH
                ENDWITH

                WITH .Column2
                    .ControlSource = "cursor_4c_Ope.Dgrus"
                    .Width         = 180
                    .Movable       = .F.
                    .Resizable     = .F.
                    .ReadOnly      = .T.
                    .FontName      = "Tahoma"
                    .FontSize      = 8
                    .ForeColor     = RGB(90,90,90)
                    .Header1.Caption   = "Descri" + CHR(231) + CHR(227) + "o"
                    .Header1.FontName  = "Tahoma"
                    .Header1.FontSize  = 8
                    .Header1.Alignment = 2
                    .Header1.ForeColor = RGB(36,84,155)
                    WITH .Text1
                        .BorderStyle = 0
                        .Margin      = 0
                        .ForeColor   = RGB(90,90,90)
                        .BackColor   = RGB(255,255,255)
                    ENDWITH
                ENDWITH
            ENDWITH

            BINDEVENT(THIS.grd_4c_Dados, "AfterRowColChange", THIS, "GrdOpeAfterRowColChange")
            BINDEVENT(THIS.grd_4c_Dados.Column1.Text1, "KeyPress", THIS, "TxtGrupoKeyPress")

            *-- Botao Inserir (cmdInserir do legado: Top=3, Left=500)
            THIS.AddObject("cmd_4c_Inserir", "CommandButton")
            WITH THIS.cmd_4c_Inserir
                .Top             = 3
                .Left            = 500
                .Width           = 75
                .Height          = 75
                .Caption         = "\<Inserir"
                .Picture         = gc_4c_CaminhoIcones + "cadastro_inserir_60.jpg"
                .DisabledPicture = gc_4c_CaminhoIcones + "cadastro_inserir_60.jpg"
                .FontName        = "Tahoma"
                .FontBold        = .T.
                .FontItalic      = .T.
                .FontSize        = 8
                .ForeColor       = RGB(90,90,90)
                .BackColor       = RGB(255,255,255)
                .Themes          = .T.
                .SpecialEffect   = 0
                .PicturePosition = 13
                .MousePointer    = 15
                .WordWrap        = .T.
                .AutoSize        = .F.
            ENDWITH
            BINDEVENT(THIS.cmd_4c_Inserir, "Click", THIS, "BtnInserirClick")

            *-- Botao Excluir (cmdExcluir do legado: Top=3, Left=575)
            THIS.AddObject("cmd_4c_Excluir", "CommandButton")
            WITH THIS.cmd_4c_Excluir
                .Top             = 3
                .Left            = 575
                .Width           = 75
                .Height          = 75
                .Caption         = "\<Excluir"
                .Picture         = gc_4c_CaminhoIcones + "cadastro_excluir_60.jpg"
                .DisabledPicture = gc_4c_CaminhoIcones + "cadastro_excluir_60.jpg"
                .FontName        = "Tahoma"
                .FontBold        = .T.
                .FontItalic      = .T.
                .FontSize        = 8
                .ForeColor       = RGB(90,90,90)
                .BackColor       = RGB(255,255,255)
                .Themes          = .T.
                .SpecialEffect   = 0
                .PicturePosition = 13
                .MousePointer    = 15
                .WordWrap        = .T.
                .AutoSize        = .F.
            ENDWITH
            BINDEVENT(THIS.cmd_4c_Excluir, "Click", THIS, "BtnExcluirClick")

            *-- Botao Confirmar (cmdSair do legado: salva e fecha; Top=3, Left=650)
            THIS.AddObject("cmd_4c_Confirmar", "CommandButton")
            WITH THIS.cmd_4c_Confirmar
                .Top             = 3
                .Left            = 650
                .Width           = 75
                .Height          = 75
                .Caption         = "\<Confirmar"
                .Picture         = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
                .DisabledPicture = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
                .FontName        = "Tahoma"
                .FontBold        = .T.
                .FontItalic      = .T.
                .FontSize        = 8
                .ForeColor       = RGB(90,90,90)
                .BackColor       = RGB(255,255,255)
                .Themes          = .T.
                .SpecialEffect   = 0
                .PicturePosition = 13
                .MousePointer    = 15
                .WordWrap        = .T.
                .AutoSize        = .F.
            ENDWITH
            BINDEVENT(THIS.cmd_4c_Confirmar, "Click", THIS, "BtnConfirmarClick")

            *-- Botao Cancelar (Cancela do legado: fecha sem salvar; Top=3, Left=725)
            THIS.AddObject("cmd_4c_Cancelar", "CommandButton")
            WITH THIS.cmd_4c_Cancelar
                .Top             = 3
                .Left            = 725
                .Width           = 75
                .Height          = 75
                .Caption         = "Encerrar"
                .Picture         = gc_4c_CaminhoIcones + "cadastro_cancelar_60.jpg"
                .DisabledPicture = gc_4c_CaminhoIcones + "cadastro_cancelar_60.jpg"
                .Cancel          = .T.
                .FontName        = "Tahoma"
                .FontBold        = .T.
                .FontItalic      = .T.
                .FontSize        = 8
                .ForeColor       = RGB(90,90,90)
                .BackColor       = RGB(255,255,255)
                .Themes          = .T.
                .SpecialEffect   = 0
                .PicturePosition = 13
                .MousePointer    = 15
                .WordWrap        = .T.
                .AutoSize        = .F.
            ENDWITH
            BINDEVENT(THIS.cmd_4c_Cancelar, "Click", THIS, "BtnCancelarClick")

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Erro em ConfigurarPaginaLista")
        ENDTRY
    ENDPROC

    *==========================================================================
    * BtnInserirClick - Adiciona linha em branco no grid de grupos
    * Replicado de cmdInserir.Click do legado
    *==========================================================================
    PROCEDURE BtnInserirClick()
        IF THIS.this_oBusinessObject.InserirLinhaGrid()
            THIS.grd_4c_Dados.Refresh()
            THIS.grd_4c_Dados.Column1.SetFocus
        ENDIF
    ENDPROC

    *==========================================================================
    * BtnExcluirClick - Remove linha corrente do grid de grupos
    * Replicado de cmdExcluir.Click do legado
    *==========================================================================
    PROCEDURE BtnExcluirClick()
        IF THIS.this_oBusinessObject.ExcluirLinhaGrid()
            THIS.grd_4c_Dados.Refresh()
            THIS.grd_4c_Dados.SetFocus
        ENDIF
    ENDPROC

    *==========================================================================
    * BtnIncluirClick - Insere nova linha em branco no grid de grupos
    * Equivalente CRUD de BtnInserirClick (delegacao para o metodo canonico)
    * Habilita gravacao e posiciona foco na coluna Cgrus para digitacao/lookup
    *==========================================================================
    PROCEDURE BtnIncluirClick()
        LOCAL loc_oErro

        TRY
            IF THIS.this_oBusinessObject.InserirLinhaGrid()
                THIS.grd_4c_Dados.Refresh()
                THIS.grd_4c_Dados.SetFocus
                THIS.grd_4c_Dados.Column1.SetFocus
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Erro em BtnIncluirClick")
        ENDTRY
    ENDPROC

    *==========================================================================
    * BtnAlterarClick - Ativa modo de edicao dos grupos ja carregados
    * Libera edicao na coluna Cgrus do grid, habilita campo Grande Grupo
    * e posiciona foco no primeiro registro para permitir alteracao
    *==========================================================================
    PROCEDURE BtnAlterarClick()
        LOCAL loc_oErro

        TRY
            IF !USED("cursor_4c_Ope") OR RECCOUNT("cursor_4c_Ope") = 0
                MsgAviso("N" + CHR(227) + "o h" + CHR(225) + ;
                         " grupos carregados para alterar." + CHR(13) + ;
                         "Utilize Incluir ou Carregar Grande Grupo.", ;
                         "Aten" + CHR(231) + CHR(227) + "o")
                RETURN
            ENDIF

            *-- Habilita edicao (Cgrus editavel + campo Grande Grupo)
            THIS.grd_4c_Dados.Column1.ReadOnly = .F.
            THIS.grd_4c_Dados.Column1.Enabled  = .T.
            THIS.txt_4c_GdeGrps.Enabled        = .T.
            THIS.this_oBusinessObject.this_lGravaDados = .T.

            *-- Posiciona no primeiro registro para edicao
            SELECT cursor_4c_Ope
            GO TOP IN cursor_4c_Ope
            THIS.grd_4c_Dados.Refresh()
            THIS.grd_4c_Dados.SetFocus
            THIS.grd_4c_Dados.Column1.SetFocus

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Erro em BtnAlterarClick")
        ENDTRY
    ENDPROC

    *==========================================================================
    * BtnVisualizarClick - Ativa modo somente-leitura dos grupos carregados
    * Bloqueia edicao no grid e campos auxiliares (Grande Grupo + Carregar)
    * mantendo navegacao livre entre os registros ja gravados
    *==========================================================================
    PROCEDURE BtnVisualizarClick()
        LOCAL loc_oErro

        TRY
            IF !USED("cursor_4c_Ope") OR RECCOUNT("cursor_4c_Ope") = 0
                MsgAviso("N" + CHR(227) + "o h" + CHR(225) + ;
                         " grupos carregados para visualizar.", ;
                         "Aten" + CHR(231) + CHR(227) + "o")
                RETURN
            ENDIF

            *-- Bloqueia edicao (Cgrus read-only + desabilita auxiliares)
            THIS.grd_4c_Dados.Column1.ReadOnly = .T.
            THIS.txt_4c_GdeGrps.Enabled        = .F.

            SELECT cursor_4c_Ope
            GO TOP IN cursor_4c_Ope
            THIS.grd_4c_Dados.Refresh()
            THIS.grd_4c_Dados.SetFocus

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Erro em BtnVisualizarClick")
        ENDTRY
    ENDPROC

    *==========================================================================
    * BtnConfirmarClick - Valida duplicatas e salva no SQL Server, entao fecha
    * Replicado de cmdSair.Click do legado
    *==========================================================================
    PROCEDURE BtnConfirmarClick()
        IF THIS.this_oBusinessObject.this_lGravaDados
            IF !THIS.this_oBusinessObject.Confirmar()
                RETURN
            ENDIF
        ENDIF
        THIS.Release()
    ENDPROC

    *==========================================================================
    * BtnCancelarClick - Fecha o form sem salvar alteracoes
    * Replicado de Cancela.Click do legado
    *==========================================================================
    PROCEDURE BtnCancelarClick()
        THIS.Release()
    ENDPROC

    *==========================================================================
    * GrdOpeAfterRowColChange - Valida Cgrus e preenche Dgrus apos navegar
    * Equivalente ao Valid do Column1.Text1 do legado (dispara apos commit)
    *==========================================================================
    PROCEDURE GrdOpeAfterRowColChange(par_nColIndex)
        LOCAL loc_cCgrus

        IF USED("cursor_4c_Ope") AND !EOF("cursor_4c_Ope")
            loc_cCgrus = ALLTRIM(cursor_4c_Ope.Cgrus)
            IF !EMPTY(loc_cCgrus)
                IF THIS.this_oBusinessObject.ValidarGrupo(loc_cCgrus)
                    THIS.this_oBusinessObject.this_lGravaDados = .T.
                ENDIF
                THIS.grd_4c_Dados.Refresh()
            ENDIF
        ENDIF
    ENDPROC

    *==========================================================================
    * TxtGrupoKeyPress - Abre picker ao pressionar F4 em Column1 (Cgrus)
    * Replicado do Valid do legado: abria fwBuscaExt para SigCdGrp
    *==========================================================================
    PROCEDURE TxtGrupoKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode != 115
            RETURN
        ENDIF
        THIS.AbrirBuscaGrupo()
    ENDPROC

    *==========================================================================
    * AbrirBuscaGrupo - Abre FormBuscaAuxiliar para SigCdGrp e aplica selecao
    *==========================================================================
    PROCEDURE AbrirBuscaGrupo()
        LOCAL loc_oBusca, loc_oErro

        TRY
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", ;
                                       gnConnHandle, ;
                                       "SigCdGrp", ;
                                       "cursor_4c_BuscaGrp", ;
                                       "Cgrus", ;
                                       ALLTRIM(THIS.grd_4c_Dados.Column1.Text1.Value), ;
                                       "Grupo de Produto", ;
                                       .T., .T., "")

            IF VARTYPE(loc_oBusca) = "O"
                loc_oBusca.mAddColuna("Cgrus", "", "Grupo")
                loc_oBusca.mAddColuna("Dgrus", "", "Descri" + CHR(231) + CHR(227) + "o")
                loc_oBusca.Show()

                IF loc_oBusca.this_lSelecionou
                    IF USED("cursor_4c_BuscaGrp") AND !EOF("cursor_4c_BuscaGrp")
                        THIS.grd_4c_Dados.Column1.Text1.Value = ;
                            ALLTRIM(cursor_4c_BuscaGrp.Cgrus)
                        IF USED("cursor_4c_Ope") AND !EOF("cursor_4c_Ope")
                            REPLACE Dgrus WITH ALLTRIM(cursor_4c_BuscaGrp.Dgrus) ;
                                IN cursor_4c_Ope
                        ENDIF
                        THIS.this_oBusinessObject.this_lGravaDados = .T.
                    ENDIF
                ENDIF

                IF USED("cursor_4c_BuscaGrp")
                    USE IN cursor_4c_BuscaGrp
                ENDIF

                THIS.grd_4c_Dados.Refresh()
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Erro ao abrir busca de grupo")
        ENDTRY
    ENDPROC

    *==========================================================================
    * AlternarPagina - Navega entre as regioes logicas do form operacional
    * Form single-page (sem PageFrame): alterna foco entre grid e campo edicao
    *   par_nPagina = 1 -> foco no grid (view lista)
    *   par_nPagina = 2 -> foco na celula editavel do Cgrus (view edicao)
    *==========================================================================
    PROCEDURE AlternarPagina(par_nPagina)
        LOCAL loc_oErro

        TRY
            IF par_nPagina = 2
                *-- Modo edicao: posiciona no Cgrus para digitar/lookup
                IF USED("cursor_4c_Ope") AND RECCOUNT("cursor_4c_Ope") > 0
                    THIS.grd_4c_Dados.SetFocus
                    THIS.grd_4c_Dados.Column1.SetFocus
                ELSE
                    *-- Sem registros: forca inserir uma linha em branco
                    THIS.BtnInserirClick()
                ENDIF
            ELSE
                *-- Modo lista (default): foco no grid
                THIS.grd_4c_Dados.SetFocus
            ENDIF
            THIS.grd_4c_Dados.Refresh()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Erro em AlternarPagina")
        ENDTRY
    ENDPROC

    *==========================================================================
    * ConfigurarPaginaDados - Adiciona Label e TextBox do Grande Grupo
    * Fase 5/8: primeira metade dos campos (label + textbox)
    * Corresponde a Say4 + getGdeGrps do legado
    * Campo habilita somente se parent form esta em modo INCLUIR/ALTERAR
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPaginaDados()
        LOCAL loc_lHabilitado, loc_oErro

        loc_lHabilitado = .T.

        TRY
            *-- Habilitar campo apenas se parent form esta em INCLUIR ou ALTERAR
            IF VARTYPE(THIS.this_oParentForm) = "O" AND ;
               PEMSTATUS(THIS.this_oParentForm, "this_cModoAtual", 5)
                loc_lHabilitado = INLIST(THIS.this_oParentForm.this_cModoAtual, ;
                                         "INCLUIR", "ALTERAR")
            ENDIF

            *-- Label "Grande Grupo :" (Say4: Left=588, Top=137, W=76, H=15)
            THIS.AddObject("lbl_4c_GrandeGrupo", "Label")
            WITH THIS.lbl_4c_GrandeGrupo
                .Caption   = "Grande Grupo :"
                .Left      = 588
                .Top       = 137
                .Width     = 76
                .Height    = 15
                .FontBold  = .F.
                .FontName  = "Tahoma"
                .FontSize  = 8
                .ForeColor = RGB(90,90,90)
                .BackStyle = 0
                .AutoSize  = .F.
            ENDWITH

            *-- TextBox codigo do Grande Grupo (getGdeGrps: Left=667, Top=134, W=38, MaxLength=3)
            THIS.AddObject("txt_4c_GdeGrps", "TextBox")
            WITH THIS.txt_4c_GdeGrps
                .Left          = 667
                .Top           = 134
                .Width         = 38
                .Height        = 24
                .MaxLength     = 3
                .SpecialEffect = 1
                .Alignment     = 3
                .BorderColor   = RGB(100,100,100)
                .Value         = ""
                .FontName      = "Tahoma"
                .FontSize      = 8
                .Enabled       = loc_lHabilitado
            ENDWITH
            BINDEVENT(THIS.txt_4c_GdeGrps, "KeyPress", THIS, "TxtGdeGrpsKeyPress")
            BINDEVENT(THIS.txt_4c_GdeGrps, "DblClick", THIS, "TxtGdeGrpsDblClick")

            *-- Botao Carregar (btnCarregar: Top=118, Left=507, W=52, H=52)
            THIS.AddObject("cmd_4c_Carregar", "CommandButton")
            WITH THIS.cmd_4c_Carregar
                .Top             = 118
                .Left            = 507
                .Width           = 52
                .Height          = 52
                .Caption         = ""
                .ToolTipText     = "Carregar Grande Grupo"
                .Picture         = gc_4c_CaminhoIcones + "importar_48.png"
                .DisabledPicture = gc_4c_CaminhoIcones + "importar_48.png"
                .BackColor       = RGB(255,255,255)
                .FontName        = "Verdana"
                .FontSize        = 8
                .Themes          = .T.
                .SpecialEffect   = 0
                .MousePointer    = 15
                .Enabled         = loc_lHabilitado
            ENDWITH
            BINDEVENT(THIS.cmd_4c_Carregar, "Click", THIS, "BtnCarregarClick")

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Erro em ConfigurarPaginaDados")
        ENDTRY
    ENDPROC

    *==========================================================================
    * TxtGdeGrpsKeyPress - Valida/lookup ao pressionar Enter/Tab/F4 no Grande Grupo
    * Replicado de getGdeGrps.Valid do legado (fwBuscaExt -> SigCdGpr)
    *==========================================================================
    PROCEDURE TxtGdeGrpsKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode != 13 AND par_nKeyCode != 9 AND par_nKeyCode != 115
            RETURN
        ENDIF
        THIS.ValidarGdeGrps()
    ENDPROC

    *==========================================================================
    * ValidarGdeGrps - Valida codigo do Grande Grupo contra SigCdGpr
    * Busca exata primeiro; se nao achar, abre FormBuscaAuxiliar
    * SigCdGpr: Codigos (char, codigo), Descs (descricao)
    *==========================================================================
    PROCEDURE ValidarGdeGrps()
        LOCAL loc_cCodigo, loc_oErro

        TRY
            loc_cCodigo = ALLTRIM(THIS.txt_4c_GdeGrps.Value)

            IF EMPTY(loc_cCodigo)
                RETURN
            ENDIF

            THIS.AbrirBuscaGdeGrps()

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Erro em ValidarGdeGrps")
        ENDTRY
    ENDPROC

    *==========================================================================
    * AbrirBuscaGdeGrps - Abre FormBuscaAuxiliar para SigCdGpr e aplica selecao
    * Tabela SigCdGpr: Codigos (codigo), Descs (descricao)
    *==========================================================================
    PROCEDURE AbrirBuscaGdeGrps()
        LOCAL loc_oBusca, loc_oErro

        TRY
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", ;
                                       gnConnHandle, ;
                                       "SigCdGpr", ;
                                       "cursor_4c_BuscaGde", ;
                                       "Codigos", ;
                                       ALLTRIM(THIS.txt_4c_GdeGrps.Value), ;
                                       "Sele" + CHR(231) + CHR(227) + "o", ;
                                       .T., .T., "")

            IF VARTYPE(loc_oBusca) = "O"
                loc_oBusca.mAddColuna("Codigos", "", "C" + CHR(243) + "digo")
                loc_oBusca.mAddColuna("Descs",   "", "Descri" + CHR(231) + CHR(227) + "o")
                loc_oBusca.Show()

                IF loc_oBusca.this_lSelecionou
                    IF USED("cursor_4c_BuscaGde") AND !EOF("cursor_4c_BuscaGde")
                        THIS.txt_4c_GdeGrps.Value = ALLTRIM(cursor_4c_BuscaGde.Codigos)
                    ENDIF
                ENDIF

                IF USED("cursor_4c_BuscaGde")
                    USE IN cursor_4c_BuscaGde
                ENDIF
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Erro ao abrir busca de Grande Grupo")
        ENDTRY
    ENDPROC

    *==========================================================================
    * TxtGdeGrpsDblClick - Abre picker ao dar duplo clique no Grande Grupo
    *==========================================================================
    PROCEDURE TxtGdeGrpsDblClick()
        THIS.AbrirBuscaGdeGrps()
    ENDPROC

    *==========================================================================
    * BtnCarregarClick - Carrega grupos do Grande Grupo selecionado
    * Replicado de btnCarregar.Click do legado (SigCdGrp WHERE Mercs = GdeGrp)
    * Delega logica ao GrupoBO.CarregarGrandeGrupo()
    *==========================================================================
    PROCEDURE BtnCarregarClick()
        LOCAL loc_cGde, loc_oErro

        TRY
            loc_cGde = ALLTRIM(THIS.txt_4c_GdeGrps.Value)

            IF EMPTY(loc_cGde)
                MsgAviso("Preencha o Grande Grupo Antes de Processar!", ;
                         "Aten" + CHR(231) + CHR(227) + "o")
                THIS.txt_4c_GdeGrps.SetFocus
                RETURN
            ENDIF

            IF THIS.this_oBusinessObject.CarregarGrandeGrupo(loc_cGde)
                THIS.grd_4c_Dados.Refresh()
                THIS.grd_4c_Dados.Column1.SetFocus
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Erro em BtnCarregarClick")
        ENDTRY
    ENDPROC

    *==========================================================================
    * CarregarLista - Recarrega cursor_4c_Ope do SQL Server descartando alteracoes
    *==========================================================================
    PROCEDURE CarregarLista()
        LOCAL loc_oErro

        TRY
            IF THIS.this_oBusinessObject.InicializarDados(THIS.this_oBusinessObject.this_cDopes)
                THIS.grd_4c_Dados.Refresh()
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Erro em CarregarLista")
        ENDTRY
    ENDPROC

    *==========================================================================
    * FormParaBO - Mapeia estado do form para o Business Object
    *==========================================================================
    PROTECTED PROCEDURE FormParaBO()
        WITH THIS.this_oBusinessObject
            .this_cGdeGrps = ALLTRIM(THIS.txt_4c_GdeGrps.Value)
        ENDWITH
    ENDPROC

    *==========================================================================
    * BOParaForm - Mapeia propriedades do Business Object para os campos do form
    *==========================================================================
    PROTECTED PROCEDURE BOParaForm()
        THIS.txt_4c_GdeGrps.Value = ALLTRIM(THIS.this_oBusinessObject.this_cGdeGrps)
    ENDPROC

    *==========================================================================
    * HabilitarCampos - Habilita ou desabilita controles editaveis do form
    * par_lHabilitar: .T. = edicao liberada, .F. = somente leitura
    *==========================================================================
    PROCEDURE HabilitarCampos(par_lHabilitar)
        THIS.txt_4c_GdeGrps.Enabled        = par_lHabilitar
        THIS.cmd_4c_Inserir.Enabled        = par_lHabilitar
        THIS.cmd_4c_Excluir.Enabled        = par_lHabilitar
        THIS.cmd_4c_Confirmar.Enabled      = par_lHabilitar
        THIS.grd_4c_Dados.Column1.ReadOnly = !par_lHabilitar
    ENDPROC

    *==========================================================================
    * LimparCampos - Limpa o campo Grande Grupo e esvazia o grid local
    *==========================================================================
    PROCEDURE LimparCampos()
        THIS.txt_4c_GdeGrps.Value                   = ""
        THIS.this_oBusinessObject.this_cGdeGrps     = ""
        THIS.this_oBusinessObject.this_lGravaDados  = .F.
        IF USED("cursor_4c_Ope")
            SELECT cursor_4c_Ope
            ZAP
            THIS.grd_4c_Dados.Refresh()
        ENDIF
    ENDPROC

    *==========================================================================
    * AjustarBotoesPorModo - Habilita/desabilita controles conforme modo do pai
    * Replica logica When do legado: InList(ParentForm.pcEscolha, INSERIR, ALTERAR)
    *==========================================================================
    PROCEDURE AjustarBotoesPorModo()
        LOCAL loc_lHabilitado

        loc_lHabilitado = .T.

        IF VARTYPE(THIS.this_oParentForm) = "O" AND ;
           PEMSTATUS(THIS.this_oParentForm, "this_cModoAtual", 5)
            loc_lHabilitado = INLIST(THIS.this_oParentForm.this_cModoAtual, ;
                                      "INCLUIR", "ALTERAR")
        ENDIF

        THIS.HabilitarCampos(loc_lHabilitado)
    ENDPROC

    *==========================================================================
    * BtnBuscarClick - Recarrega grupos do SQL Server (descarta alteracoes locais)
    * Confirma com usuario antes de descartar se houver alteracoes nao salvass
    *==========================================================================
    PROCEDURE BtnBuscarClick()
        LOCAL loc_oErro

        TRY
            IF THIS.this_oBusinessObject.this_lGravaDados
                IF MsgConfirma("H" + CHR(225) + " altera" + CHR(231) + CHR(245) + ;
                               "es n" + CHR(227) + "o salvas. Recarregar descarta " + ;
                               "as altera" + CHR(231) + CHR(245) + "es. Continuar?", ;
                               "Aten" + CHR(231) + CHR(227) + "o")
                    THIS.this_oBusinessObject.this_lGravaDados = .F.
                    THIS.CarregarLista()
                ENDIF
            ELSE
                THIS.CarregarLista()
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Erro em BtnBuscarClick")
        ENDTRY
    ENDPROC

    *==========================================================================
    * BtnEncerrarClick - Fecha o form; pede confirmacao se houver alteracoes nao salvas
    *==========================================================================
    PROCEDURE BtnEncerrarClick()
        LOCAL loc_oErro

        TRY
            IF THIS.this_oBusinessObject.this_lGravaDados
                IF !MsgConfirma("H" + CHR(225) + " altera" + CHR(231) + CHR(245) + ;
                                "es n" + CHR(227) + "o salvas. Fechar sem salvar?", ;
                                "Aten" + CHR(231) + CHR(227) + "o")
                    RETURN
                ENDIF
            ENDIF
            THIS.Release()

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Erro em BtnEncerrarClick")
        ENDTRY
    ENDPROC

    *==========================================================================
    * BtnSalvarClick - Alias canonico de BtnConfirmarClick
    *==========================================================================
    PROCEDURE BtnSalvarClick()
        THIS.BtnConfirmarClick()
    ENDPROC

ENDDEFINE


### BO (C:\4c\projeto\app\classes\GrupoBO.prg):
*==============================================================================
* GrupoBO.prg - Business Object para Grupos de Produto por Operacao
* Tabela principal : SigOpGpo (cgrus, cidchaves, dopes)
* Tabela referencia: SigCdGrp (cgrus, dgrus, mercs)
* Grande Grupo     : SigCdGpr (codigos, descs)
*==============================================================================
DEFINE CLASS GrupoBO AS BusinessBase

    *-- Configuracao da tabela
    this_cTabela     = "SigOpGpo"
    this_cCampoChave = "cidchaves"

    *-- Codigo da operacao corrente (vem do form pai via crSigCdOpe.Dopes)
    this_cDopes      = ""

    *-- Filtro de grande grupo (SigCdGpr.codigos char(3))
    this_cGdeGrps    = ""

    *-- Flag de gravacao (alteracoes nao salvas no grid)
    this_lGravaDados = .F.

    *-- Nomes dos cursores de trabalho
    this_cCursorOpe      = "cursor_4c_Ope"         && grid de edicao local
    this_cCursorSigOpGpo = "cursor_4c_SigOpGpo"    && cursor persistente (poDataMgr)

    *-- Propriedades para operacoes CRUD unitarias (linha unica de SigOpGpo)
    this_cCgrus      = ""    && SigOpGpo.Cgrus char(3)
    this_cIdChaves   = ""    && SigOpGpo.cIdChaves char(30) (PK gerada por SYS(2015))

    *==========================================================================
    PROCEDURE Init()
    *==========================================================================
        RETURN DODEFAULT()
    ENDPROC

    *==========================================================================
    * ObterChavePrimaria - retorna chave para auditoria
    *==========================================================================
    PROTECTED FUNCTION ObterChavePrimaria()
        RETURN THIS.this_cDopes
    ENDFUNC

    *==========================================================================
    * InicializarDados - Cria cursor local e carrega dados existentes do SQL Server
    * par_cDopes: codigo da operacao (ex: crSigCdOpe.Dopes do form pai)
    *==========================================================================
    PROCEDURE InicializarDados(par_cDopes)
        LOCAL loc_lSucesso, loc_cSQL, loc_oErro

        loc_lSucesso = .F.
        THIS.this_cDopes = ALLTRIM(par_cDopes)

        TRY
            SET NULL ON
            CREATE CURSOR cursor_4c_Ope (Dopes C(20) NULL, Cgrus C(3) NULL, Dgrus C(30) NULL)
            SET NULL OFF
            INDEX ON Cgrus TAG Cgrus
            SET ORDER TO

            loc_cSQL = "SELECT a.Dopes, a.Cgrus, b.Dgrus " + ;
                       "FROM SigOpGpo a " + ;
                       "INNER JOIN SigCdGrp b ON a.Cgrus = b.Cgrus " + ;
                       "WHERE a.Dopes = " + EscaparSQL(THIS.this_cDopes)

            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_OpeTemp") > 0
                SELECT cursor_4c_Ope
                ZAP
                APPEND FROM DBF("cursor_4c_OpeTemp")
                USE IN cursor_4c_OpeTemp
            ENDIF

            SELECT cursor_4c_Ope
            SET ORDER TO
            GO TOP

            loc_lSucesso = .T.

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Erro em InicializarDados")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * InserirLinhaGrid - Insere linha em branco no cursor local de trabalho
    *==========================================================================
    PROCEDURE InserirLinhaGrid()
        LOCAL loc_lSucesso, loc_oErro

        loc_lSucesso = .F.

        TRY
            IF USED("cursor_4c_Ope")
                INSERT INTO cursor_4c_Ope (Dopes, Cgrus, Dgrus) ;
                    VALUES (THIS.this_cDopes, SPACE(3), SPACE(30))
                SELECT cursor_4c_Ope
                THIS.this_lGravaDados = .T.
                loc_lSucesso = .T.
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Erro em InserirLinhaGrid")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * ExcluirLinhaGrid - Exclui a linha corrente do cursor local
    *==========================================================================
    PROCEDURE ExcluirLinhaGrid()
        LOCAL loc_lSucesso, loc_oErro

        loc_lSucesso = .F.

        TRY
            IF USED("cursor_4c_Ope") AND !EOF("cursor_4c_Ope")
                SELECT cursor_4c_Ope
                DELETE
                SKIP
                IF EOF("cursor_4c_Ope")
                    GO BOTTOM
                ENDIF
                THIS.this_lGravaDados = .T.
                loc_lSucesso = .T.
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Erro em ExcluirLinhaGrid")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * ValidarGrupo - Valida Cgrus em SigCdGrp e atualiza Dgrus no cursor local
    * par_cCgrus: codigo digitado
    * RETORNO: .T. se encontrado (Dgrus preenchido), .F. se nao encontrado
    *==========================================================================
    PROCEDURE ValidarGrupo(par_cCgrus)
        LOCAL loc_lSucesso, loc_cSQL, loc_oErro

        loc_lSucesso = .F.

        TRY
            loc_cSQL = "SELECT TOP 1 Cgrus, Dgrus FROM SigCdGrp " + ;
                       "WHERE Cgrus = " + EscaparSQL(ALLTRIM(par_cCgrus))

            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_GrpVal") > 0
                IF !EOF("cursor_4c_GrpVal")
                    IF USED("cursor_4c_Ope") AND !EOF("cursor_4c_Ope")
                        REPLACE Cgrus WITH ALLTRIM(cursor_4c_GrpVal.Cgrus) IN cursor_4c_Ope
                        REPLACE Dgrus WITH ALLTRIM(cursor_4c_GrpVal.Dgrus) IN cursor_4c_Ope
                    ENDIF
                    loc_lSucesso = .T.
                ENDIF
                USE IN cursor_4c_GrpVal
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Erro em ValidarGrupo")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * CarregarGrandeGrupo - Carrega grupos de SigCdGrp onde Mercs = par_cGdeGrps
    * par_cGdeGrps: codigo do grande grupo (SigCdGpr.Codigos)
    * RETORNO: .T. se carregou com sucesso
    *==========================================================================
    PROCEDURE CarregarGrandeGrupo(par_cGdeGrps)
        LOCAL loc_lSucesso, loc_cSQL, loc_oErro

        loc_lSucesso = .F.

        IF EMPTY(ALLTRIM(par_cGdeGrps))
            MsgAviso("Preencha o Grande Grupo Antes de Processar!", "Aten" + CHR(231) + CHR(227) + "o")
            RETURN .F.
        ENDIF

        TRY
            THIS.this_cGdeGrps  = par_cGdeGrps
            THIS.this_lGravaDados = .T.

            loc_cSQL = "SELECT Cgrus, Dgrus FROM SigCdGrp " + ;
                       "WHERE Mercs = " + EscaparSQL(ALLTRIM(par_cGdeGrps))

            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_LocalGru") < 1
                MsgErro("Falha ao carregar grupos do grande grupo.", "Erro")
            ELSE
                *-- Remover linhas em branco existentes
                IF !EOF("cursor_4c_LocalGru")
                    DELETE FROM cursor_4c_Ope WHERE EMPTY(ALLTRIM(Cgrus))
                ENDIF

                *-- Adicionar grupos ausentes no cursor local
                SELECT cursor_4c_LocalGru
                SCAN
                    SELECT cursor_4c_Ope
                    GO TOP
                    LOCATE FOR ALLTRIM(Cgrus) == ALLTRIM(cursor_4c_LocalGru.Cgrus)
                    IF EOF("cursor_4c_Ope")
                        INSERT INTO cursor_4c_Ope (Dopes, Cgrus, Dgrus) ;
                            VALUES (THIS.this_cDopes, ;
                                    ALLTRIM(cursor_4c_LocalGru.Cgrus), ;
                                    ALLTRIM(cursor_4c_LocalGru.Dgrus))
                    ENDIF
                ENDSCAN

                *-- Linha em branco ao final para entrada manual
                IF !EOF("cursor_4c_LocalGru")
                    INSERT INTO cursor_4c_Ope (Dopes, Cgrus, Dgrus) ;
                        VALUES (THIS.this_cDopes, SPACE(3), SPACE(30))
                ENDIF

                IF USED("cursor_4c_LocalGru")
                    USE IN cursor_4c_LocalGru
                ENDIF

                SELECT cursor_4c_Ope
                GO BOTTOM

                loc_lSucesso = .T.
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Erro em CarregarGrandeGrupo")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * ValidarDuplicidade - Verifica grupos duplicados no cursor local
    * RETORNO: .T. se valido (sem duplicatas), .F. se ha duplicatas
    *==========================================================================
    PROTECTED FUNCTION ValidarDuplicidade()
        LOCAL loc_lValido, loc_oErro

        loc_lValido = .T.

        TRY
            SELECT Cgrus, SUM(1) AS nQt ;
                FROM cursor_4c_Ope ;
                WHERE !EMPTY(ALLTRIM(Cgrus)) ;
                GROUP BY Cgrus ;
                HAVING SUM(1) > 1 ;
                INTO CURSOR cursor_4c_DupCheck READWRITE

            IF RECCOUNT("cursor_4c_DupCheck") > 0
                MsgAviso("Existem lan" + CHR(231) + "amentos de Grupos Em Duplicidade!!!", ;
                         "Duplicidade")
                loc_lValido = .F.
            ENDIF

            IF USED("cursor_4c_DupCheck")
                USE IN cursor_4c_DupCheck
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Erro em ValidarDuplicidade")
            loc_lValido = .F.
        ENDTRY

        RETURN loc_lValido
    ENDFUNC

    *==========================================================================
    * Confirmar - Salva todas as alteracoes no SQL Server
    * DELETE + INSERT por operacao (padrao do legado SigOpGpo)
    * RETORNO: .T. se gravado com sucesso, .F. caso contrario
    *==========================================================================
    PROCEDURE Confirmar()
        LOCAL loc_lSucesso, loc_lErroInserir, loc_cSQL, loc_cIdChave, loc_oErro

        loc_lSucesso   = .F.
        loc_lErroInserir = .F.

        TRY
            IF THIS.ValidarDuplicidade()
                loc_cSQL = "DELETE FROM SigOpGpo WHERE Dopes = " + EscaparSQL(THIS.this_cDopes)

                IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_DelResult") < 1
                    MsgErro("Erro ao excluir registros anteriores da opera" + CHR(231) + CHR(227) + "o.", "Erro")
                ELSE
                    IF USED("cursor_4c_DelResult")
                        USE IN cursor_4c_DelResult
                    ENDIF

                    SELECT cursor_4c_Ope
                    SCAN FOR !EMPTY(ALLTRIM(Cgrus))
                        loc_cIdChave = SYS(2015)
                        loc_cSQL = "INSERT INTO SigOpGpo (Dopes, Cgrus, cIdChaves) " + ;
                                   "VALUES (" + ;
                                   EscaparSQL(THIS.this_cDopes) + ", " + ;
                                   EscaparSQL(ALLTRIM(Cgrus)) + ", " + ;
                                   EscaparSQL(loc_cIdChave) + ")"

                        IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_InsResult") < 1
                            MsgErro("Erro ao inserir grupo " + ALLTRIM(Cgrus) + ".", "Erro")
                            loc_lErroInserir = .T.
                            EXIT
                        ENDIF

                        IF USED("cursor_4c_InsResult")
                            USE IN cursor_4c_InsResult
                        ENDIF
                    ENDSCAN

                    IF !loc_lErroInserir
                        THIS.this_lGravaDados = .F.
                        THIS.RegistrarAuditoria("ATUALIZAR")
                        loc_lSucesso = .T.
                    ENDIF
                ENDIF
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Erro em Confirmar")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * CarregarDoCursor - Mapeia colunas de um cursor (crSigCdOpe do form pai ou
    * cursor local do grid) para as propriedades this_c* do BO
    * par_cAliasCursor: nome do cursor origem (default: cursor_4c_Ope)
    * RETORNO: .T. se carregou com sucesso
    *==========================================================================
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso, loc_cAlias, loc_oErro

        loc_lSucesso = .F.
        loc_cAlias = IIF(EMPTY(par_cAliasCursor), THIS.this_cCursorOpe, par_cAliasCursor)

        TRY
            IF USED(loc_cAlias)
                SELECT (loc_cAlias)

                IF !EOF()
                    *-- Dopes: sempre presente em cursores de operacao/grid
                    IF TYPE(loc_cAlias + ".Dopes") != "U"
                        THIS.this_cDopes = ALLTRIM(NVL(Dopes, ""))
                    ENDIF

                    *-- Cgrus: presente no cursor local do grid e em SigOpGpo
                    IF TYPE(loc_cAlias + ".Cgrus") != "U"
                        THIS.this_cCgrus = ALLTRIM(NVL(Cgrus, ""))
                    ENDIF

                    *-- cIdChaves: apenas em SigOpGpo (PK)
                    IF TYPE(loc_cAlias + ".cIdChaves") != "U"
                        THIS.this_cIdChaves = ALLTRIM(NVL(cIdChaves, ""))
                    ENDIF

                    loc_lSucesso = .T.
                ENDIF
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Erro em CarregarDoCursor")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * Inserir - Insere uma linha unica em SigOpGpo (Dopes, Cgrus, cIdChaves)
    * Usa as propriedades this_cDopes, this_cCgrus preenchidas previamente
    * Gera cIdChaves via SYS(2015) se nao definida
    * RETORNO: .T. se inserido com sucesso, .F. caso contrario
    *==========================================================================
    PROCEDURE Inserir()
        LOCAL loc_lSucesso, loc_cSQL, loc_oErro

        loc_lSucesso = .F.

        TRY
            IF EMPTY(ALLTRIM(THIS.this_cDopes))
                MsgAviso("Opera" + CHR(231) + CHR(227) + "o (Dopes) n" + CHR(227) + "o informada.", ;
                         "Aten" + CHR(231) + CHR(227) + "o")
                loc_lSucesso = .F.
            ENDIF

            IF EMPTY(ALLTRIM(THIS.this_cCgrus))
                MsgAviso("Grupo (Cgrus) n" + CHR(227) + "o informado.", ;
                         "Aten" + CHR(231) + CHR(227) + "o")
                loc_lSucesso = .F.
            ENDIF

            IF EMPTY(ALLTRIM(THIS.this_cIdChaves))
                THIS.this_cIdChaves = SYS(2015)
            ENDIF

            loc_cSQL = "INSERT INTO SigOpGpo (Dopes, Cgrus, cIdChaves) " + ;
                       "VALUES (" + ;
                       EscaparSQL(ALLTRIM(THIS.this_cDopes)) + ", " + ;
                       EscaparSQL(ALLTRIM(THIS.this_cCgrus)) + ", " + ;
                       EscaparSQL(ALLTRIM(THIS.this_cIdChaves)) + ")"

            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_InsUnit") < 1
                MsgErro("Erro ao inserir registro em SigOpGpo.", "Erro")
            ELSE
                IF USED("cursor_4c_InsUnit")
                    USE IN cursor_4c_InsUnit
                ENDIF

                THIS.RegistrarAuditoria("INSERIR")
                loc_lSucesso = .T.
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Erro em Inserir")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * LiberarCursores - Libera todos os cursores temporarios ao fechar
    *==========================================================================
    PROCEDURE LiberarCursores()
        IF USED("cursor_4c_Ope")
            USE IN cursor_4c_Ope
        ENDIF
        IF USED("cursor_4c_OpeTemp")
            USE IN cursor_4c_OpeTemp
        ENDIF
        IF USED("cursor_4c_GrpVal")
            USE IN cursor_4c_GrpVal
        ENDIF
        IF USED("cursor_4c_LocalGru")
            USE IN cursor_4c_LocalGru
        ENDIF
        IF USED("cursor_4c_DupCheck")
            USE IN cursor_4c_DupCheck
        ENDIF
        IF USED("cursor_4c_DelResult")
            USE IN cursor_4c_DelResult
        ENDIF
        IF USED("cursor_4c_InsResult")
            USE IN cursor_4c_InsResult
        ENDIF
        IF USED("cursor_4c_InsUnit")
            USE IN cursor_4c_InsUnit
        ENDIF
    ENDPROC

ENDDEFINE


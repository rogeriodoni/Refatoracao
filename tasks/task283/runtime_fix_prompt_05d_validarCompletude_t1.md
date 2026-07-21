# CORRIGIR ERRO DE RUNTIME VFP9

## TAREFA OBRIGATORIA
O formulario VFP9 apresentou erro de runtime durante teste automatizado.
Voce DEVE corrigir o erro e salvar os arquivos corrigidos usando Write tool.

## ERRO DETECTADO
- Etapa: 05d_validarCompletude
- Tentativa: 1/10
- Mensagem: Validacao de completude falhou. Procedures vazias/TODOs encontrados:
[FormSIGPREST.prg] Procedure vazia (sem codigo): AjustarBotoesPorModo

IMPORTANTE: Preencha TODAS as procedures vazias com codigo funcional REAL. NAO use TODO, FIXME, PLACEHOLDER ou comentarios de pendencia. Cada procedure deve ter implementacao completa.

## CONTEXTO DO ERRO


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

### FORM (C:\4c\projeto\app\forms\operacionais\FormSIGPREST.prg):
*==============================================================================
* FormSIGPREST.prg - Form Gerar Estrutura de Arquivos DBF
* Herdado de: FormBase
* Tipo: OPERACIONAL (dialogo utilitario - sem PageFrame)
*==============================================================================
DEFINE CLASS FormSIGPREST AS FormBase

    *-- Propriedades visuais (PILAR 1: identico ao legado SIGPREST.SCX)
    Width       = 600
    Height      = 191
    AutoCenter  = .T.
    TitleBar    = 0
    ShowWindow = 1
    WindowType = 1
    ControlBox  = .F.
    Closable    = .F.
    MaxButton   = .F.
    MinButton   = .F.
    DataSession = 2

    *-- Business Object
    this_oBusinessObject = .NULL.

    *-- Estado de exibicao de mensagem ao usuario
    this_cMensagem = ""

    *--------------------------------------------------------------------------
    PROCEDURE Init()
    *--------------------------------------------------------------------------
        RETURN DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPageFrame - Aparencia base do dialogo (OPERACIONAL sem PageFrame)
    * Configura fundo, fontes e cor de base do form.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPageFrame()
        THIS.ScrollBars = 0
        THIS.ShowTips   = .F.
        THIS.SetAll("FontName", "Tahoma")
        THIS.SetAll("FontSize", 8)

        THIS.Picture = gc_4c_CaminhoIcones + "new_background.jpg"
    ENDPROC

    *--------------------------------------------------------------------------
    * InicializarForm - Cria Business Object e configura controles do dialogo
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lSucesso, loc_oErro

        loc_lSucesso = .F.

        TRY
            THIS.this_oBusinessObject = CREATEOBJECT("SIGPRESTBO")

            IF VARTYPE(THIS.this_oBusinessObject) = "O"
                THIS.ConfigurarPageFrame()
                THIS.ConfigurarCabecalho()
                THIS.ConfigurarPaginaLista()
                THIS.ConfigurarPaginaDados()

                THIS.TornarControlesVisiveis(THIS)

                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao criar Business Object SIGPRESTBO." + CHR(13) + ;
                    "VARTYPE retornou: " + VARTYPE(THIS.this_oBusinessObject), "Erro")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
                " PROC=" + loc_oErro.Procedure, "Erro")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarCabecalho - Container de cabecalho escuro com titulo do form
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarCabecalho()
        LOCAL loc_oCab

        THIS.AddObject("cnt_4c_Cabecalho", "Container")
        WITH THIS.cnt_4c_Cabecalho
            .Top        = -1
            .Left       = -1
            .Width      = THIS.Width
            .Height     = 80
            .BackStyle  = 1
            .BackColor  = RGB(100,100,100)
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH

        loc_oCab = THIS.cnt_4c_Cabecalho

        loc_oCab.AddObject("lbl_4c_Sombra", "Label")
        WITH loc_oCab.lbl_4c_Sombra
            .Top          = 18
            .Left         = 10
            .Width        = THIS.Width
            .Height       = 40
            .AutoSize     = .F.
            .FontBold     = .T.
            .FontName     = "Tahoma"
            .FontSize     = 18
            .FontUnderline = .F.
            .WordWrap     = .T.
            .Alignment    = 0
            .BackStyle    = 0
            .ForeColor    = RGB(0,0,0)
            .Caption      = "Gerar Estrutura"
        ENDWITH

        loc_oCab.AddObject("lbl_4c_Titulo", "Label")
        WITH loc_oCab.lbl_4c_Titulo
            .Top          = 17
            .Left         = 10
            .Width        = THIS.Width
            .Height       = 46
            .AutoSize     = .F.
            .FontBold     = .T.
            .FontName     = "Tahoma"
            .FontSize     = 18
            .WordWrap     = .T.
            .Alignment    = 0
            .BackStyle    = 0
            .ForeColor    = RGB(255,255,255)
            .ToolTipText  = "T" + CHR(237) + "tulo do Relat" + CHR(243) + "rio"
            .Caption      = "Gerar Estrutura"
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * TornarControlesVisiveis - Torna todos os controles visiveis recursivamente
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
        LOCAL loc_i, loc_oControl

        FOR loc_i = 1 TO par_oContainer.ControlCount
            loc_oControl = par_oContainer.Controls(loc_i)
            IF VARTYPE(loc_oControl) = "O"
                IF PEMSTATUS(loc_oControl, "Visible", 5)
                    loc_oControl.Visible = .T.
                ENDIF
                IF PEMSTATUS(loc_oControl, "ControlCount", 5) AND loc_oControl.ControlCount > 0
                    THIS.TornarControlesVisiveis(loc_oControl)
                ENDIF
            ENDIF
        ENDFOR
    ENDPROC

    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
    *--------------------------------------------------------------------------
        TRY
            IF VARTYPE(THIS.this_oBusinessObject) = "O"
                THIS.this_oBusinessObject = .NULL.
            ENDIF
        CATCH
        ENDTRY
        DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPaginaLista - Frame decorativo e botoes de acao do dialogo
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPaginaLista()

        *-- Shape decorativo que agrupa os checkboxes visualmente
        THIS.AddObject("shp_4c_Shape1", "Shape")
        WITH THIS.shp_4c_Shape1
            .Top           = 9
            .Left          = 49
            .Height        = 110
            .Width         = 173
            .BackStyle     = 0
            .BorderStyle   = 0
            .SpecialEffect = 0
        ENDWITH

        *-- Botao Gerar (cmd_4c_OK)
        THIS.AddObject("cmd_4c_OK", "CommandButton")
        WITH THIS.cmd_4c_OK
            .Top             = 3
            .Left            = 450
            .Width           = 75
            .Height          = 75
            .Caption         = "Gerar"
            .Picture         = gc_4c_CaminhoIcones + "geral_processar_60.jpg"
            .DisabledPicture = gc_4c_CaminhoIcones + "geral_processar_60.jpg"
            .FontBold        = .T.
            .FontItalic      = .T.
            .FontName        = "Comic Sans MS"
            .FontSize        = 8
            .ForeColor       = RGB(90,90,90)
            .BackColor       = RGB(255,255,255)
            .Themes          = .T.
            .WordWrap        = .T.
            .AutoSize        = .F.
            .PicturePosition = 13
            .SpecialEffect   = 0
            .MousePointer    = 15
        ENDWITH
        BINDEVENT(THIS.cmd_4c_OK, "Click", THIS, "BtnOKClick")

        *-- Botao Encerrar (cmd_4c_Cancela)
        THIS.AddObject("cmd_4c_Cancela", "CommandButton")
        WITH THIS.cmd_4c_Cancela
            .Top             = 3
            .Left            = 525
            .Width           = 75
            .Height          = 75
            .Caption         = "Encerrar"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
            .DisabledPicture = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
            .Cancel          = .T.
            .FontBold        = .T.
            .FontItalic      = .T.
            .FontName        = "Comic Sans MS"
            .FontSize        = 8
            .ForeColor       = RGB(90,90,90)
            .BackColor       = RGB(255,255,255)
            .Themes          = .T.
            .WordWrap        = .T.
            .AutoSize        = .F.
            .PicturePosition = 13
            .SpecialEffect   = 0
            .MousePointer    = 15
        ENDWITH
        BINDEVENT(THIS.cmd_4c_Cancela, "Click", THIS, "BtnCancelaClick")
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPaginaDados - Campos de entrada do dialogo (checkboxes + status)
    * SIGPREST eh utilitario sem PageFrame, entao "Dados" aqui sao os controles
    * de entrada do usuario (opcoes de processamento) e a label de status.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPaginaDados()

        *-- Checkbox: Gerar Estrutura
        THIS.AddObject("chk_4c_GeraArquivos", "CheckBox")
        WITH THIS.chk_4c_GeraArquivos
            .Top        = 90
            .Left       = 55
            .Width      = 75
            .Height     = 75
            .Caption    = "Estrutura"
            .Picture    = gc_4c_CaminhoIcones + "geral_limpa_grade_60.jpg"
            .FontBold   = .T.
            .FontItalic = .T.
            .FontName   = "Comic Sans MS"
            .FontSize   = 8
            .Alignment  = 2
            .BackStyle  = 1
            .BackColor  = RGB(255,255,255)
            .ForeColor  = RGB(90,90,90)
            .Themes     = .F.
            .WordWrap   = .T.
            .AutoSize   = .F.
            .Style      = 1
            .Value      = 1
        ENDWITH

        *-- Checkbox: Gerar Indices
        THIS.AddObject("chk_4c_GeraIndices", "CheckBox")
        WITH THIS.chk_4c_GeraIndices
            .Top        = 90
            .Left       = 136
            .Width      = 75
            .Height     = 75
            .Caption    = CHR(205) + "ndice"
            .Picture    = gc_4c_CaminhoIcones + "geral_limpa_grade_60.jpg"
            .FontBold   = .T.
            .FontItalic = .T.
            .FontName   = "Comic Sans MS"
            .FontSize   = 8
            .Alignment  = 2
            .BackStyle  = 1
            .BackColor  = RGB(255,255,255)
            .ForeColor  = RGB(90,90,90)
            .Themes     = .F.
            .WordWrap   = .T.
            .AutoSize   = .F.
            .Style      = 1
            .Value      = 1
        ENDWITH

        *-- Label de status do processamento
        THIS.AddObject("lbl_4c_Mensagem1", "Label")
        WITH THIS.lbl_4c_Mensagem1
            .Top       = 132
            .Left      = 48
            .Width     = 480
            .Height    = 24
            .Caption   = ""
            .Alignment = 2
            .BackStyle = 0
            .FontBold  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 11
            .ForeColor = RGB(90,90,90)
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnOKClick - Dispara geracao de estrutura de arquivos DBF e/ou indices
    *--------------------------------------------------------------------------
    PROCEDURE BtnOKClick()
        THIS.FormParaBO()
        THIS.HabilitarCampos(.F.)
        THIS.Refresh()

        THIS.this_oBusinessObject.GerarEstrutura( ;
            THIS.this_oBusinessObject.this_lGeraArquivos, ;
            THIS.this_oBusinessObject.this_lGeraIndices)

        THIS.BOParaForm()
        THIS.HabilitarCampos(.T.)
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnCancelaClick - Encerra o dialogo
    *--------------------------------------------------------------------------
    PROCEDURE BtnCancelaClick()
        THIS.this_oBusinessObject.CarregarLogoTipo()
        THIS.Release()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnIncluirClick - Acao principal do dialogo OPERACIONAL
    * SIGPREST eh utilitario de geracao de estrutura (nao CRUD): a acao "Incluir"
    * do padrao CRUD mapeia para a acao unica do dialogo = disparar a geracao
    * de ArqDBF/ArqInd via THIS.BtnOKClick(). Mantido para compatibilidade com
    * o pipeline e para permitir integracao via menu/toolbar generico.
    *--------------------------------------------------------------------------
    PROCEDURE BtnIncluirClick()
        THIS.BtnOKClick()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnAlterarClick - Re-executa a geracao (re-processa estrutura/indices)
    * Em um dialogo de utilitario, "Alterar" = re-rodar o processamento com as
    * opcoes correntes dos checkboxes (Estrutura/Indice). Delegacao explicita
    * para BtnOKClick que ja carrega o estado dos checkboxes e chama o BO.
    *--------------------------------------------------------------------------
    PROCEDURE BtnAlterarClick()
        THIS.BtnOKClick()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnVisualizarClick - Executa a geracao em modo somente-processamento
    * SIGPREST nao tem tela de "visualizacao de registro" (sem grid, sem lista):
    * a unica saida visivel eh a label de status atualizada via GerarEstrutura.
    * Delega para BtnOKClick que executa o processo e atualiza a mensagem.
    *--------------------------------------------------------------------------
    PROCEDURE BtnVisualizarClick()
        THIS.BtnOKClick()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnExcluirClick - Encerra o dialogo (equivale a cancelar/fechar)
    * Em um utilitario one-shot, "Excluir" nao remove registros (nao ha
    * entidade persistida); mapeia para o fluxo de saida do dialogo, que
    * garante fechamento de tabelas e recarga do logo via CarregarLogoTipo.
    *--------------------------------------------------------------------------
    PROCEDURE BtnExcluirClick()
        THIS.BtnCancelaClick()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnSalvarClick - Executa a geracao de estrutura (sinonimo de BtnOKClick)
    *--------------------------------------------------------------------------
    PROCEDURE BtnSalvarClick()
        THIS.BtnOKClick()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnCancelarClick - Encerra o dialogo (sinonimo de BtnCancelaClick)
    *--------------------------------------------------------------------------
    PROCEDURE BtnCancelarClick()
        THIS.BtnCancelaClick()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnBuscarClick - Sem lista neste dialogo; compatibilidade com pipeline
    *--------------------------------------------------------------------------
    PROCEDURE BtnBuscarClick()
        THIS.BtnOKClick()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnEncerrarClick - Encerra o dialogo
    *--------------------------------------------------------------------------
    PROCEDURE BtnEncerrarClick()
        THIS.BtnCancelaClick()
    ENDPROC

    *--------------------------------------------------------------------------
    * FormParaBO - Transfere opcoes dos checkboxes para o Business Object
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE FormParaBO()
        THIS.this_oBusinessObject.this_lGeraArquivos = (THIS.chk_4c_GeraArquivos.Value = 1)
        THIS.this_oBusinessObject.this_lGeraIndices  = (THIS.chk_4c_GeraIndices.Value = 1)
    ENDPROC

    *--------------------------------------------------------------------------
    * BOParaForm - Atualiza controles do dialogo com estado do Business Object
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE BOParaForm()
        THIS.chk_4c_GeraArquivos.Value = IIF(THIS.this_oBusinessObject.this_lGeraArquivos, 1, 0)
        THIS.chk_4c_GeraIndices.Value  = IIF(THIS.this_oBusinessObject.this_lGeraIndices, 1, 0)
        THIS.lbl_4c_Mensagem1.Caption  = THIS.this_oBusinessObject.this_cMensagem
    ENDPROC

    *--------------------------------------------------------------------------
    * HabilitarCampos - Habilita ou desabilita controles de entrada
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE HabilitarCampos(par_lHabilitar)
        THIS.chk_4c_GeraArquivos.Enabled = par_lHabilitar
        THIS.chk_4c_GeraIndices.Enabled  = par_lHabilitar
        THIS.cmd_4c_OK.Enabled           = par_lHabilitar
        THIS.cmd_4c_Cancela.Enabled      = par_lHabilitar
    ENDPROC

    *--------------------------------------------------------------------------
    * LimparCampos - Restaura controles para valores padrao
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE LimparCampos()
        THIS.chk_4c_GeraArquivos.Value = 1
        THIS.chk_4c_GeraIndices.Value  = 1
        THIS.lbl_4c_Mensagem1.Caption  = ""
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarLista - Nao aplicavel a este dialogo (sem grid de lista)
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION CarregarLista()
        RETURN .T.
    ENDFUNC

    *--------------------------------------------------------------------------
    * AjustarBotoesPorModo - Nao aplicavel a este dialogo (sem modos CRUD)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE AjustarBotoesPorModo()
    ENDPROC

ENDDEFINE


### BO (C:\4c\projeto\app\classes\SIGPRESTBO.prg):
*------------------------------------------------------------------------------
* SIGPRESTBO.prg - Business Object para Gerar Estrutura de Arquivos DBF
* Herdado de: BusinessBase
*------------------------------------------------------------------------------
DEFINE CLASS SIGPRESTBO AS BusinessBase

    *-- Configuracao da entidade (sem tabela SQL Server - opera em DBFs locais)
    this_cTabela     = ""
    this_cCampoChave = ""

    *-- Opcoes de processamento (mapeiam checkboxes do form)
    this_lGeraArquivos = .T.
    this_lGeraIndices  = .T.

    *-- Estado do processamento
    this_cMensagem    = ""
    this_cDiretorioBase = ""
    this_lProcessando = .F.

    *--------------------------------------------------------------------------
    PROCEDURE Init()
    *--------------------------------------------------------------------------
        LOCAL loc_lSucesso

        TRY
            loc_lSucesso = DODEFAULT()
            IF !loc_lSucesso
                loc_lSucesso = .F.
            ENDIF

            this_cTabela        = ""
            this_cCampoChave    = ""
            this_lGeraArquivos  = .T.
            this_lGeraIndices   = .T.
            this_cMensagem      = ""
            this_cDiretorioBase = ""
            this_lProcessando   = .F.

            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    FUNCTION ObterChavePrimaria()
    *--------------------------------------------------------------------------
        RETURN ""
    ENDFUNC

    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ValidarDados()
    *--------------------------------------------------------------------------
        IF !this_lGeraArquivos AND !this_lGeraIndices
            this_cMensagemErro = "Selecione pelo menos uma op" + CHR(231) + ;
                CHR(227) + "o de gera" + CHR(231) + CHR(227) + "o."
            RETURN .F.
        ENDIF
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    FUNCTION Inserir()
    *--------------------------------------------------------------------------
        RETURN .T.
    ENDFUNC

    *--------------------------------------------------------------------------
    FUNCTION Atualizar()
    *--------------------------------------------------------------------------
        RETURN .T.
    ENDFUNC

    *--------------------------------------------------------------------------
    FUNCTION CarregarDoCursor(par_cAliasCursor)
    *--------------------------------------------------------------------------
        RETURN .F.
    ENDFUNC

    *--------------------------------------------------------------------------
    * GerarEstrutura - Gera ArqDBF.dbf (estrutura) e ArqInd.dbf (indices)
    * a partir de todos os .DBF encontrados no diretorio basededados\
    *--------------------------------------------------------------------------
    FUNCTION GerarEstrutura(par_lGeraArquivos, par_lGeraIndices)
    *--------------------------------------------------------------------------
        LOCAL loc_lSucesso, loc_loBarra, loc_lnArq, loc_lcArquivo
        LOCAL loc_lnGeraArq, loc_lnGeraInd, loc_lnCampos, loc_lnCCampos
        LOCAL loc_lcDbc, loc_lnKey, loc_lcChave, loc_lcFiltro, loc_lcTag
        LOCAL loc_lcDirAtual, loc_lInterrompido
        LOCAL ARRAY loc_laArq[1]
        LOCAL ARRAY loc_laCampos[1]

        loc_lSucesso      = .F.
        loc_lInterrompido = .F.
        loc_lcDirAtual    = ADDBS(SYS(5)) + CURDIR()

        TRY
            this_lProcessando = .T.
            this_cMensagem    = ""

            CLOSE TABLES ALL
            SET DEFAULT TO ".\basededados\"

            IF par_lGeraArquivos

                SELECT 0

                CREATE TABLE ArqDBF FREE ;
                    ( Arquivos c(20), Dbcs c(50), Campos c(20), Tipos c(1), ;
                      Tamanhos n(3), Fracaos n(2), C_05s l, C_06s l, ;
                      C_07s c(20), C_08s c(20), C_09s c(20), C_10s c(20), ;
                      C_11s c(20), C_12s c(20), C_13s c(20), C_14s c(20), ;
                      C_15s c(20), C_16s c(20) )

                INDEX ON Arquivos + Campos TAG ArqCamp

                loc_lnArq = ADIR(loc_laArq, "*.Dbf")
                =ASORT(loc_laArq)

                loc_loBarra = CREATEOBJECT("fwProgressBar", ;
                    "Processando Estrutura de Arquivos.", loc_lnArq)
                loc_loBarra.Titulo.FontBold = .T.
                loc_loBarra.Show()

                FOR loc_lnGeraArq = 1 TO loc_lnArq

                    loc_lcArquivo = loc_laArq(loc_lnGeraArq, 1)

                    loc_loBarra.Update(.T.)
                    loc_loBarra.SubTitulo.Caption = ;
                        "Processando Arquivo : " + ALLTRIM(loc_lcArquivo)

                    IF INLIST(ALLTRIM(loc_lcArquivo), "ARQDBF.DBF", "ARQIND.DBF", "FOXUSER.DBF")
                        LOOP
                    ENDIF

                    USE (loc_lcArquivo) IN 0 ALIAS TmpArquivo AGAIN

                    SELECT TmpArquivo
                    loc_lcDbc    = ALLTRIM(JUSTFNAME(CURSORGETPROP("DataBase")))
                    loc_lnCampos = AFIELDS(loc_laCampos)

                    FOR loc_lnCCampos = 1 TO loc_lnCampos

                        IF loc_lnCCampos = 1
                            IF EMPTY(loc_laCampos(loc_lnCCampos, 12))
                                loc_laCampos(loc_lnCCampos, 12) = ;
                                    STRTRAN(loc_lcArquivo, ".DBF", "")
                            ENDIF
                        ENDIF

                        SELECT ArqDBF
                        INSERT INTO ArqDBF ;
                            ( Arquivos, Dbcs, Campos, Tipos, Tamanhos, Fracaos, ;
                              C_05s, C_06s, C_07s, C_08s, C_09s, C_10s, ;
                              C_11s, C_12s, C_13s, C_14s, C_15s, C_16s ) ;
                            VALUES ;
                            ( loc_lcArquivo, loc_lcDbc, ;
                              loc_laCampos(loc_lnCCampos, 1), loc_laCampos(loc_lnCCampos, 2), ;
                              loc_laCampos(loc_lnCCampos, 3), loc_laCampos(loc_lnCCampos, 4), ;
                              loc_laCampos(loc_lnCCampos, 5), loc_laCampos(loc_lnCCampos, 6), ;
                              loc_laCampos(loc_lnCCampos, 7), loc_laCampos(loc_lnCCampos, 8), ;
                              loc_laCampos(loc_lnCCampos, 9), loc_laCampos(loc_lnCCampos, 10), ;
                              loc_laCampos(loc_lnCCampos, 11), loc_laCampos(loc_lnCCampos, 12), ;
                              loc_laCampos(loc_lnCCampos, 13), loc_laCampos(loc_lnCCampos, 14), ;
                              loc_laCampos(loc_lnCCampos, 15), loc_laCampos(loc_lnCCampos, 16) )

                    ENDFOR

                    USE IN TmpArquivo

                ENDFOR

                loc_loBarra.Complete("Finalizando Processo de Estrutura.")

            ENDIF

            CLOSE TABLES ALL

            IF par_lGeraIndices AND !FILE("ArqDBF.Dbf")
                MsgAviso("Antes de gerar os " + CHR(237) + "ndices, " + CHR(233) + ;
                    " necess" + CHR(225) + "rio que seja gerada a Estrutura de Arquivos...", "")
                this_cMensagem    = "Processamento Interrompido."
                this_lProcessando = .F.
                loc_lInterrompido = .T.
            ENDIF

            IF par_lGeraIndices AND !loc_lInterrompido

                SELECT 0
                USE ArqDBF ORDER ArqCamp

                loc_lnArq = ADIR(loc_laArq, "*.Dbf")
                =ASORT(loc_laArq)

                IF FILE("ArqInd.Dbf")
                    DELETE FILE ArqInd.Dbf
                    DELETE FILE ArqInd.Cdx
                ENDIF

                CREATE TABLE ArqInd FREE ;
                    ( Arquivos c(20), Tags c(15), Indices c(240), ;
                      Filtros c(240), Indexs l, c_12s c(20) )
                INDEX ON Arquivos + Tags TAG Arquivos
                INDEX ON Arquivos TAG Temp UNIQUE

                loc_loBarra = CREATEOBJECT("fwProgressBar", ;
                    "Processando " + CHR(205) + "ndices de Arquivos.", loc_lnArq)
                loc_loBarra.Titulo.FontBold = .T.
                loc_loBarra.Show()

                FOR loc_lnGeraInd = 1 TO loc_lnArq

                    loc_lcArquivo = loc_laArq(loc_lnGeraInd, 1)

                    loc_loBarra.Update(.T.)
                    loc_loBarra.SubTitulo.Caption = ;
                        "Processando Arquivo : " + ALLTRIM(loc_lcArquivo)

                    IF INLIST(ALLTRIM(loc_lcArquivo), "ARQDBF.DBF", "ARQIND.DBF", "FOXUSER.DBF")
                        LOOP
                    ENDIF

                    SELECT 0
                    USE (loc_lcArquivo) ALIAS TmpArquivo AGAIN

                    loc_lnKey = 1
                    DO WHILE !EMPTY(TAG(loc_lnKey))
                        loc_lcChave  = KEY(loc_lnKey)
                        loc_lcFiltro = SYS(2021, loc_lnKey)
                        loc_lcTag    = TAG(loc_lnKey)
                        INSERT INTO ArqInd ( Arquivos, Tags, Indices, Filtros ) ;
                            VALUES ( loc_lcArquivo, loc_lcTag, loc_lcChave, loc_lcFiltro )
                        SELECT TmpArquivo
                        loc_lnKey = loc_lnKey + 1
                    ENDDO

                    USE

                ENDFOR

                loc_loBarra.Complete("Finalizando Processo de " + CHR(205) + "ndice.")

            ENDIF

            IF !loc_lInterrompido
                CLOSE TABLES ALL
                this_cMensagem    = "Processamento Finalizado."
                this_lProcessando = .F.
                loc_lSucesso      = .T.
                SET DEFAULT TO (loc_lcDirAtual)
                THIS.CarregarLogoTipo()
            ELSE
                SET DEFAULT TO (loc_lcDirAtual)
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
                " PROC=" + loc_oErro.Procedure, ;
                "Erro na Gera" + CHR(231) + CHR(227) + "o de Estrutura")
            this_cMensagem    = "Erro no processamento."
            this_lProcessando = .F.
            loc_lSucesso      = .F.

            TRY
                CLOSE TABLES ALL
                SET DEFAULT TO (loc_lcDirAtual)
            CATCH
            ENDTRY
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * CarregarLogoTipo - Garante cursor csLogoTipo disponivel (usado pelo sistema)
    *--------------------------------------------------------------------------
    PROCEDURE CarregarLogoTipo()
    *--------------------------------------------------------------------------
        LOCAL loc_oErro

        TRY
            IF !USED("csLogoTipo")
                SQLEXEC(gnConnHandle, "SELECT Logos FROM SigCdPam", "csLogoTipo")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao carregar logo")
        ENDTRY
    ENDPROC

ENDDEFINE


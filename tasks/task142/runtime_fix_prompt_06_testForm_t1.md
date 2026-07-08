# CORRIGIR ERRO DE RUNTIME VFP9

## TAREFA OBRIGATORIA
O formulario VFP9 apresentou erro de runtime durante teste automatizado.
Voce DEVE corrigir o erro e salvar os arquivos corrigidos usando Write tool.

## ERRO DETECTADO
- Etapa: 06_testForm
- Tentativa: 1/10
- Mensagem: TIMEOUT: VFP9 travou durante teste de formulario (300s). ERRO CAPTURADO: [18/06/2026 09:38:09 PM] Erro: Alias 'XNENSI' is not found.


## CONTEXTO DO ERRO

### ERROS CAPTURADOS EM MODO TESTE (vfp_error_details.txt):
[18/06/2026 09:38:09 PM] Erro: Alias 'XNENSI' is not found.


### LOG DA ETAPA (06_testForm):
[2026-06-18 21:37:54] [INFO] === VFP EXECUTOR v2.0 ===
[2026-06-18 21:37:54] [INFO] Config FPW: (nao fornecido)
[2026-06-18 21:37:54] [INFO] Script PRG: C:\4c\automation\vfp_helpers\TestFormWrapper.prg
[2026-06-18 21:37:54] [INFO] Timeout: 300 segundos
[2026-06-18 21:37:54] [INFO] Wrapper PRG criado para parametros: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_ofesgfav.prg
[2026-06-18 21:37:54] [INFO] Conteudo do wrapper:
[2026-06-18 21:37:54] [INFO] * Auto-generated wrapper for parameters
* Script: C:\4c\automation\vfp_helpers\TestFormWrapper.prg
* Parameters: 'FormSigPdMp1', 'C:\4c\tasks\task142\logs\06_testForm.log'

* Anti-dialog protections for unattended execution
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
SET NOTIFY OFF
SYS(2335, 0)

DO "C:\4c\automation\vfp_helpers\TestFormWrapper" WITH 'FormSigPdMp1', 'C:\4c\tasks\task142\logs\06_testForm.log'
QUIT

[2026-06-18 21:37:54] [INFO] Comando VFP: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_ofesgfav.prg
[2026-06-18 21:37:54] [INFO] VFP output esperado em: C:\4c\tasks\task142\vfp_output.txt
[2026-06-18 21:37:54] [INFO] Executando Visual FoxPro 9...
[2026-06-18 21:37:54] [INFO] Comando completo: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_ofesgfav.prg
[2026-06-18 21:37:54] [INFO] Executando: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_ofesgfav.prg
[2026-06-18 21:37:54] [INFO] Timeout configurado: 300 segundos
=== TESTE DE FORMULARIO ===
Classe: FormSigPdMp1
Inicio: 18/06/2026 21:37:54

[ETAPA 1] Carregando dependencias...
OK - Dependencias carregadas

[ETAPA 1B] Conectando ao banco de dados...
OK - Conectado ao banco (Handle: 1)

[ETAPA 2] Criando objeto do formulario...
[2026-06-18 21:42:54] [ERROR] TIMEOUT: VFP9 nao finalizou em 300 segundos. Encerrando processo (PID: 18916)...
[2026-06-18 21:42:56] [INFO] VFP9 finalizado em 302.0750013 segundos
[2026-06-18 21:42:56] [INFO] Exit Code: 4
[2026-06-18 21:42:56] [INFO] 
[2026-06-18 21:42:56] [INFO] Arquivos temporarios preservados para inspecao:
[2026-06-18 21:42:56] [INFO]   Wrapper.prg: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_ofesgfav.prg
[2026-06-18 21:42:56] [INFO] 
[2026-06-18 21:42:56] [INFO] === Conteudo do Wrapper.prg temporario ===
[2026-06-18 21:42:56] [INFO] * Auto-generated wrapper for parameters
[2026-06-18 21:42:56] [INFO] * Script: C:\4c\automation\vfp_helpers\TestFormWrapper.prg
[2026-06-18 21:42:56] [INFO] * Parameters: 'FormSigPdMp1', 'C:\4c\tasks\task142\logs\06_testForm.log'
[2026-06-18 21:42:56] [INFO] 
[2026-06-18 21:42:56] [INFO] * Anti-dialog protections for unattended execution
[2026-06-18 21:42:56] [INFO] SET SAFETY OFF
[2026-06-18 21:42:56] [INFO] SET RESOURCE OFF
[2026-06-18 21:42:56] [INFO] SET TALK OFF
[2026-06-18 21:42:56] [INFO] SET NOTIFY OFF
[2026-06-18 21:42:56] [INFO] SYS(2335, 0)
[2026-06-18 21:42:56] [INFO] 
[2026-06-18 21:42:56] [INFO] DO "C:\4c\automation\vfp_helpers\TestFormWrapper" WITH 'FormSigPdMp1', 'C:\4c\tasks\task142\logs\06_testForm.log'
[2026-06-18 21:42:56] [INFO] QUIT
[2026-06-18 21:42:56] [INFO] 
[2026-06-18 21:42:56] [INFO] === Fim do Wrapper.prg ===
[2026-06-18 21:42:56] [ERROR] TIMEOUT: VFP9 excedeu o tempo limite de 300 segundos e foi encerrado forcadamente



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

### FORM (C:\4c\projeto\app\forms\operacionais\FormSigPdMp1.prg):
*==============================================================================
* FORMSIGPDMP1.PRG
* Form OPERACIONAL: Componentes Agregados (SIGPDMP1)
* Aberto pelo FormSigPdMov passando referencia ao form pai (par_oFormPai).
* Compartilha DataSession com o form pai para acesso aos cursores xNensi
* e tmpnens. Permite visualizacao e edicao parcial dos componentes de
* uma operacao de industrializacao.
*==============================================================================

DEFINE CLASS FormSigPdMp1 AS FormBase

    *-- Propriedades visuais (exatas do original SIGPDMP1)
    Width            = 800
    Height           = 600
    Caption          = "Componentes Agregados"
    DataSession      = 2
    ShowWindow = 1
    WindowType = 1
    BorderStyle      = 2
    TitleBar         = 0
    ControlBox       = .F.
    Closable         = .F.
    MaxButton        = .F.
    MinButton        = .F.
    Movable          = .F.
    ClipControls     = .F.
    Themes           = .F.
    AutoCenter       = .T.
    Picture          = ""

    *-- Estado do form
    this_oBusinessObject  = .NULL.
    this_oFormPai         = .NULL.
    this_cEscolha         = ""
    this_nRecnoAnt        = 0
    this_lLiberaAlteracao = .F.
    this_nAntValue        = 0
    this_nTotPeso         = 0

    *-- Container cabecalho cinza (cntSombra no legado)
    ADD OBJECT cnt_4c_Sombra AS Container WITH ;
        Top = 0, Left = 0, Width = 800, Height = 80, ;
        BorderWidth = 0, BackColor = RGB(100,100,100)

    *-- Shape decorativo area botoes (Shape1 no legado)
    ADD OBJECT shp_4c_Shape1 AS Shape WITH ;
        Top = 7, Left = 694, Height = 110, Width = 90, ;
        BackStyle = 0, BorderStyle = 0, BorderColor = RGB(136,189,188)

    *-- Container dados da operacao (Opera=o no legado)
    *-- TextBoxes adicionados na Fase 5 (GetCodigo, GetEmpresa, GetOpera=o)
    ADD OBJECT cnt_4c_Operacao AS Container WITH ;
        Top = 82, Left = 38, Width = 358, Height = 40, ;
        BackStyle = 0, BorderWidth = 0, BackColor = RGB(255,255,255)

    *==========================================================================
    * Init - Compartilha datasession com o form pai e inicializa o form
    * Parametro: par_oFormPai - referencia ao form que chamou este form
    *==========================================================================
    PROCEDURE Init(par_oFormPai)
        IF VARTYPE(par_oFormPai) = "O"
            THIS.this_oFormPai = par_oFormPai
            THIS.this_cEscolha = ALLTRIM(par_oFormPai.pcEscolha)
            *-- Compartilha datasession do form pai: acessa xNensi, tmpnens, crSigCdOpd
            THIS.DataSessionId = par_oFormPai.DataSessionId
        ENDIF
        RETURN DODEFAULT()
    ENDPROC

    *==========================================================================
    * InicializarForm - Cria BO, inicializa cursores e configura interface
    * Chamado automaticamente por FormBase.Init() via DODEFAULT()
    *==========================================================================
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lSucesso, loc_oErro, loc_cCaption, loc_cTitulo
        loc_lSucesso = .F.

        THIS.this_oBusinessObject = CREATEOBJECT("SigPdMp1BO")
        IF VARTYPE(THIS.this_oBusinessObject) <> "O"
            MsgErro("Erro ao criar SigPdMp1BO.", "Erro")
            RETURN loc_lSucesso
        ENDIF

        TRY
            *-- Caption dinamico: Fase Anterior somente no modo INSERIR
            loc_cCaption = "Componentes Agregados"
            IF ALLTRIM(THIS.this_cEscolha) = "INSERIR"
                loc_cCaption = loc_cCaption + " Fase Anterior"
            ENDIF
            THIS.Caption = loc_cCaption

            *-- Fundo do form (new_background.jpg)
            THIS.Picture = gc_4c_CaminhoIcones + "new_background.jpg"

            *-- Titulo dinamico da coluna Industrializacao (dois niveis acima no legado)
            loc_cTitulo = ""
            IF VARTYPE(THIS.this_oFormPai) = "O"
                IF VARTYPE(THIS.this_oFormPai.ParentForm) = "O"
                    IF TYPE("THIS.this_oFormPai.ParentForm.Titulo") = "C"
                        loc_cTitulo = ALLTRIM(THIS.this_oFormPai.ParentForm.Titulo)
                    ENDIF
                ENDIF
            ENDIF

            *-- Inicializa cursor de distribuicao a partir de xNensi
            THIS.this_oBusinessObject.InicializarDistrib(loc_cTitulo)

            *-- Inicializa cursor de resumo (GROUP BY Cmats, Cunis, CuniPs sobre xNensi.Visivel)
            THIS.this_oBusinessObject.InicializarResumo()

            *-- Captura totalizadores calculados pelo BO
            THIS.this_nTotPeso  = THIS.this_oBusinessObject.this_nTotPeso
            THIS.this_nRecnoAnt = THIS.this_oBusinessObject.this_nRecnoAnt

            *-- Configura layout visual do form
            THIS.ConfigurarPageFrame()
            THIS.ConfigurarCabecalho()
            THIS.ConfigurarContainerOperacao()
            THIS.ConfigurarPaginaLista()
            THIS.ConfigurarPaginaDados()

            *-- Torna todos os controles visiveis
            THIS.TornarControlesVisiveis(THIS)

            *-- Caption dinamico do header Industrializacao (ParentForm.ParentForm.Titulo no legado)
            IF !EMPTY(loc_cTitulo) AND VARTYPE(THIS.grd_4c_Dados) = "O"
                THIS.grd_4c_Dados.Column1.Header1.Caption = loc_cTitulo
            ENDIF

            *-- Botao Alterar visivel somente no modo INSERIR (replica logica fChecaAcesso do legado)
            IF VARTYPE(THIS.cmd_4c_Alterar) = "O"
                THIS.cmd_4c_Alterar.Visible = INLIST(ALLTRIM(THIS.this_cEscolha), "INSERIR")
            ENDIF

            loc_lSucesso = .T.

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * ConfigurarPageFrame - Form OPERACIONAL nao usa PageFrame (Page1/Page2).
    * SIGPDMP1 original eh um popup modal com layout plano: cabecalho cinza,
    * container Operacao com codigo/empresa/operacao, dois grids (Grade e
    * grdResumo) e botoes Ok/Alterar diretamente no form. Sem PageFrame.
    *
    * Este metodo existe por compatibilidade com a pipeline de migracao e
    * garante propriedades essenciais do form (centralizacao, fundo, modo).
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPageFrame()
        *-- Centralizar e dimensoes (idempotente; pipeline pode rechamar)
        THIS.AutoCenter = .T.
        THIS.Width  = 800
        THIS.Height = 600

        *-- Fundo do form (padrao operacional)
        IF TYPE("gc_4c_CaminhoIcones") = "C"
            THIS.Picture = gc_4c_CaminhoIcones + "new_background.jpg"
        ENDIF

        *-- Caption ajustado conforme escolha (INSERIR mostra Fase Anterior)
        IF ALLTRIM(THIS.this_cEscolha) = "INSERIR"
            THIS.Caption = "Componentes Agregados Fase Anterior"
        ELSE
            THIS.Caption = "Componentes Agregados"
        ENDIF
    ENDPROC

    *==========================================================================
    * ConfigurarCabecalho - Adiciona labels de titulo no cnt_4c_Sombra
    * Equivale a lblSombra e lblTitulo dentro de cntSombra no legado
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarCabecalho()
        LOCAL loc_cCaption
        loc_cCaption = THIS.Caption

        WITH THIS.cnt_4c_Sombra
            .AddObject("lbl_4c_LblSombra", "Label")
            WITH .lbl_4c_LblSombra
                .FontBold      = .T.
                .FontName      = "Tahoma"
                .FontSize      = 18
                .FontUnderline = .F.
                .WordWrap      = .T.
                .Alignment     = 0
                .BackStyle     = 0
                .Caption       = loc_cCaption
                .Height        = 40
                .Left          = 10
                .Top           = 18
                .Width         = 769
                .ForeColor     = RGB(0, 0, 0)
                .Visible       = .T.
            ENDWITH

            .AddObject("lbl_4c_LblTitulo", "Label")
            WITH .lbl_4c_LblTitulo
                .FontBold   = .T.
                .FontName   = "Tahoma"
                .FontSize   = 18
                .WordWrap   = .T.
                .Alignment  = 0
                .BackStyle  = 0
                .Caption    = loc_cCaption
                .Height     = 46
                .Left       = 10
                .Top        = 17
                .Width      = 769
                .ForeColor  = RGB(255, 255, 255)
                .Visible    = .T.
            ENDWITH
        ENDWITH
    ENDPROC

    *==========================================================================
    * ConfigurarContainerOperacao - Adiciona label e textboxes no cnt_4c_Operacao
    * Say1 "Operacao :" + GetEmpresa + GetOperacao + GetCodigo (todos ReadOnly)
    * Vinculados ao cursor tmpnens (DataSession compartilhada com o form pai)
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarContainerOperacao()
        WITH THIS.cnt_4c_Operacao
            .AddObject("lbl_4c_LblOperacao", "Label")
            WITH .lbl_4c_LblOperacao
                .FontSize  = 8
                .Caption   = "Opera" + CHR(231) + CHR(227) + "o :"
                .Left      = 18
                .Top       = 13
                .ForeColor = RGB(90, 90, 90)
                .BackStyle = 0
                .Visible   = .T.
            ENDWITH

            .AddObject("txt_4c_Empresa", "TextBox")
            WITH .txt_4c_Empresa
                .Left          = 76
                .Top           = 9
                .Width         = 36
                .Height        = 23
                .ReadOnly      = .T.
                .ControlSource = "tmpnens.emps"
                .FontName      = "Tahoma"
                .FontSize      = 8
                .ForeColor     = RGB(0, 0, 0)
                .BackColor     = RGB(255, 255, 255)
                .BorderStyle   = 1
                .Themes        = .F.
                .Visible       = .T.
            ENDWITH

            .AddObject("txt_4c_Operacao", "TextBox")
            WITH .txt_4c_Operacao
                .Left          = 114
                .Top           = 9
                .Width         = 156
                .Height        = 23
                .ReadOnly      = .T.
                .ControlSource = "tmpnens.dopps"
                .FontName      = "Tahoma"
                .FontSize      = 8
                .ForeColor     = RGB(0, 0, 0)
                .BackColor     = RGB(255, 255, 255)
                .BorderStyle   = 1
                .Themes        = .F.
                .Visible       = .T.
            ENDWITH

            .AddObject("txt_4c_Codigo", "TextBox")
            WITH .txt_4c_Codigo
                .Left          = 272
                .Top           = 9
                .Width         = 81
                .Height        = 23
                .ReadOnly      = .T.
                .ControlSource = "tmpnens.numps"
                .InputMask     = "9999999999"
                .Alignment     = 3
                .FontName      = "Tahoma"
                .FontSize      = 8
                .ForeColor     = RGB(0, 0, 0)
                .BackColor     = RGB(255, 255, 255)
                .BorderStyle   = 1
                .Themes        = .F.
                .Visible       = .T.
            ENDWITH
        ENDWITH
    ENDPROC

    *==========================================================================
    * TornarControlesVisiveis - Torna controles visiveis recursivamente
    *==========================================================================
    PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
        LOCAL loc_i, loc_oControl

        FOR loc_i = 1 TO par_oContainer.ControlCount
            loc_oControl = par_oContainer.Controls(loc_i)

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
    * ConfigurarPaginaLista - Setup visual da area "lista" do form OPERACIONAL
    *
    * SIGPDMP1 eh OPERACIONAL (popup modal sem PageFrame Page1/Page2). A area
    * de "lista" no template CRUD eh aqui o bloco superior do form: o grid
    * principal de componentes (Grade no legado) e os botoes de acao (Alterar/
    * OK) no topo. O bloco inferior (descricao + totais + resumo) eh agrupado
    * em ConfigurarPaginaDados().
    *
    *  - grd_4c_Dados   : grid de componentes (Grade no legado, 11 colunas)
    *  - cmd_4c_Alterar : libera edicao das colunas (botao Alterar)
    *  - cmd_4c_Ok      : persiste alteracoes e fecha (botao ok)
    *
    * O form NAO tem botoes CRUD (Incluir/Visualizar/Excluir/Buscar/Encerrar)
    * porque o legado nao tem - paridade funcional 100% com SIGPDMP1.SCX.
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPaginaLista()
        THIS.ConfigurarGradeDistrib()
        THIS.ConfigurarBotoes()
    ENDPROC

    *==========================================================================
    * ConfigurarPaginaDados - Setup visual da area "dados/detalhes" do form
    *
    * Em forms CRUD, ConfigurarPaginaDados configura a Page2 com campos de
    * edicao. Em SIGPDMP1 (OPERACIONAL) nao ha Page2; este metodo agrupa o
    * bloco inferior do form com os campos de detalhe e o grid de totais:
    *
    *  - lbl_4c_Label2  : label "Descricao :" (Say2 no legado)
    *  - txt_4c_Descr   : campo de descricao da linha corrente do grid
    *                     principal (Get_descr no legado, vinculado a
    *                     cursor_4c_Distrib.CDescs)
    *  - txt_4c_TotPeso : total de peso da fase anterior calculado pelo BO
    *                     (getTotPeso no legado)
    *  - grd_4c_Resumo  : grid de resumo com totais agrupados por componente
    *                     (grdResumo no legado, 6 colunas, ReadOnly)
    *
    * Ordem importa: ConfigurarCamposExtras() cria os controles flutuantes
    * (labels/textboxes) que ficam visualmente sobre/abaixo do grid principal;
    * ConfigurarGradeResumo() cria o grid de totais no rodape do form.
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPaginaDados()
        THIS.ConfigurarCamposExtras()
        THIS.ConfigurarGradeResumo()
    ENDPROC

    *==========================================================================
    * AlternarPagina - Form OPERACIONAL SIGPDMP1 nao possui PageFrame Page1/
    * Page2 nem alternancia entre modos LISTA/DADOS. Este metodo existe para
    * compatibilidade com a estrutura padrao da pipeline de migracao; apenas
    * garante o foco na grade principal quando chamado.
    *==========================================================================
    PROTECTED PROCEDURE AlternarPagina(par_nPagina)
        IF VARTYPE(THIS.grd_4c_Dados) = "O"
            THIS.grd_4c_Dados.SetFocus()
        ENDIF
    ENDPROC

    *==========================================================================
    * ConfigurarGradeDistrib - Grid principal (Grade) com 11 colunas
    * Cols 3 (Pesos), 5 (Qtds), 8 (Peso2s) tornam-se editaveis apos Alterar
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarGradeDistrib()
        THIS.AddObject("grd_4c_Dados", "Grid")

        WITH THIS.grd_4c_Dados
            .Top         = 125
            .Left        = 38
            .Width       = 724
            .Height      = 329
            .ColumnCount = 11
            .RecordSource = "cursor_4c_Distrib"
            .RecordMark  = .F.
            .DeleteMark  = .F.
            .ReadOnly    = .F.
            .ScrollBars  = 2
            .GridLines   = 1
            .RowHeight   = 16
            .FontName    = "Verdana"
            .FontSize    = 8
            .Themes      = .F.

            *-- ColumnOrder replica a ordem visual do original (SCX usava ColumnOrder para rearranjar)
            *-- Visual: Industrializacao | Componente | Descricao | Cor | Tam. | Unid. | Qtde(1) | Unid.(2) | Qtde(2) | Peso Fabr. | Lote

            WITH .Column1
                .ColumnOrder   = 1
                .Width         = 83
                .ReadOnly      = .T.
                .ControlSource = "cursor_4c_Distrib.Nops"
                .FontName      = "Courier New"
                .FontSize      = 9
                .InputMask     = "9999999999"
                .Alignment     = 3
                .Header1.Caption = "Industrializa" + CHR(231) + CHR(227) + "o"
                .Header1.FontName = "Tahoma"
                .Header1.FontSize = 9
                .Header1.Alignment = 2
            ENDWITH

            WITH .Column2
                .ColumnOrder   = 2
                .Width         = 100
                .ReadOnly      = .T.
                .ControlSource = "cursor_4c_Distrib.CMats"
                .Header1.Caption = "Componente"
                .Header1.FontName = "Tahoma"
                .Header1.FontSize = 9
                .Header1.Alignment = 2
            ENDWITH

            WITH .Column3
                .ColumnOrder   = 10
                .Width         = 80
                .ReadOnly      = .T.
                .ControlSource = "cursor_4c_Distrib.Pesos"
                .Header1.Caption = "Peso Fabr."
                .Header1.FontName = "Tahoma"
                .Header1.FontSize = 9
                .Header1.Alignment = 2
            ENDWITH

            WITH .Column4
                .ColumnOrder   = 6
                .Width         = 31
                .ReadOnly      = .T.
                .ControlSource = "cursor_4c_Distrib.CUnis"
                .Header1.Caption = "Unid."
                .Header1.FontName = "Tahoma"
                .Header1.FontSize = 9
                .Header1.Alignment = 2
            ENDWITH

            WITH .Column5
                .ColumnOrder   = 7
                .Width         = 80
                .ReadOnly      = .T.
                .ControlSource = "cursor_4c_Distrib.Qtds"
                .Header1.Caption = "Qtde (1)"
                .Header1.FontName = "Tahoma"
                .Header1.FontSize = 9
                .Header1.Alignment = 2
            ENDWITH

            WITH .Column6
                .ColumnOrder   = 3
                .Width         = 50
                .ReadOnly      = .T.
                .ControlSource = "cursor_4c_Distrib.CDescs"
                .Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
                .Header1.FontName = "Tahoma"
                .Header1.FontSize = 9
                .Header1.Alignment = 2
            ENDWITH

            WITH .Column7
                .ColumnOrder   = 11
                .Width         = 80
                .ReadOnly      = .T.
                .ControlSource = "cursor_4c_Distrib.nLotes"
                .Header1.Caption = "Lote"
                .Header1.FontName = "Tahoma"
                .Header1.FontSize = 9
                .Header1.Alignment = 2
            ENDWITH

            WITH .Column8
                .ColumnOrder   = 9
                .Width         = 70
                .ReadOnly      = .T.
                .ControlSource = "cursor_4c_Distrib.Peso2s"
                .Header1.Caption = "Qtde (2)"
                .Header1.FontName = "Tahoma"
                .Header1.FontSize = 9
                .Header1.Alignment = 2
            ENDWITH

            WITH .Column9
                .ColumnOrder   = 8
                .Width         = 31
                .ReadOnly      = .T.
                .ControlSource = "cursor_4c_Distrib.cUniPs"
                .Header1.Caption = "Unid."
                .Header1.FontName = "Tahoma"
                .Header1.FontSize = 9
                .Header1.Alignment = 2
            ENDWITH

            WITH .Column10
                .ColumnOrder   = 4
                .Width         = 38
                .ReadOnly      = .T.
                .ControlSource = "cursor_4c_Distrib.CodCors"
                .Header1.Caption = "Cor"
                .Header1.FontName = "Tahoma"
                .Header1.FontSize = 9
                .Header1.Alignment = 2
            ENDWITH

            WITH .Column11
                .ColumnOrder   = 5
                .Width         = 38
                .ReadOnly      = .T.
                .ControlSource = "cursor_4c_Distrib.CodTams"
                .Header1.Caption = "Tam."
                .Header1.FontName = "Tahoma"
                .Header1.FontSize = 9
                .Header1.Alignment = 2
            ENDWITH

            .Visible = .T.
        ENDWITH

        *-- Redefine ControlSource apos RecordSource para neutralizar auto-bind do VFP
        THIS.grd_4c_Dados.Column1.ControlSource  = "cursor_4c_Distrib.Nops"
        THIS.grd_4c_Dados.Column2.ControlSource  = "cursor_4c_Distrib.CMats"
        THIS.grd_4c_Dados.Column3.ControlSource  = "cursor_4c_Distrib.Pesos"
        THIS.grd_4c_Dados.Column4.ControlSource  = "cursor_4c_Distrib.CUnis"
        THIS.grd_4c_Dados.Column5.ControlSource  = "cursor_4c_Distrib.Qtds"
        THIS.grd_4c_Dados.Column6.ControlSource  = "cursor_4c_Distrib.CDescs"
        THIS.grd_4c_Dados.Column7.ControlSource  = "cursor_4c_Distrib.nLotes"
        THIS.grd_4c_Dados.Column8.ControlSource  = "cursor_4c_Distrib.Peso2s"
        THIS.grd_4c_Dados.Column9.ControlSource  = "cursor_4c_Distrib.cUniPs"
        THIS.grd_4c_Dados.Column10.ControlSource = "cursor_4c_Distrib.CodCors"
        THIS.grd_4c_Dados.Column11.ControlSource = "cursor_4c_Distrib.CodTams"

        BINDEVENT(THIS.grd_4c_Dados, "AfterRowColChange", THIS, "GrdDistribAfterRowColChange")
        BINDEVENT(THIS.grd_4c_Dados.Column3.Text1, "GotFocus",  THIS, "GrdCol3GotFocus")
        BINDEVENT(THIS.grd_4c_Dados.Column3.Text1, "KeyPress", THIS, "GrdCol3LostFocus")
        BINDEVENT(THIS.grd_4c_Dados.Column5.Text1, "GotFocus",  THIS, "GrdCol5GotFocus")
        BINDEVENT(THIS.grd_4c_Dados.Column5.Text1, "KeyPress", THIS, "GrdCol5LostFocus")
        BINDEVENT(THIS.grd_4c_Dados.Column8.Text1, "GotFocus",  THIS, "GrdCol8GotFocus")
        BINDEVENT(THIS.grd_4c_Dados.Column8.Text1, "KeyPress", THIS, "GrdCol8LostFocus")
    ENDPROC

    *==========================================================================
    * ConfigurarGradeResumo - Grid de resumo com 6 colunas (grdResumo)
    * Exibe cursor_4c_Resumo: totais agrupados por componente
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarGradeResumo()
        THIS.AddObject("grd_4c_Resumo", "Grid")

        WITH THIS.grd_4c_Resumo
            .Top               = 481
            .Left              = 38
            .Width             = 446
            .Height            = 114
            .ColumnCount       = 6
            .RecordSource      = "cursor_4c_Resumo"
            .RecordMark        = .F.
            .DeleteMark        = .F.
            .ReadOnly          = .T.
            .ScrollBars        = 2
            .GridLines         = 1
            .RowHeight         = 16
            .HeaderHeight      = 16
            .AllowHeaderSizing = .F.
            .AllowRowSizing    = .F.
            .FontName          = "Verdana"
            .FontSize          = 8
            .Themes            = .F.

            WITH .Column1
                .Width         = 108
                .ControlSource = "cursor_4c_Resumo.CMats"
                .Header1.Caption = "Componente"
                .Header1.FontName = "Tahoma"
                .Header1.FontSize = 8
                .Header1.Alignment = 2
            ENDWITH

            WITH .Column2
                .Width         = 80
                .ControlSource = "cursor_4c_Resumo.Qtds"
                .Header1.Caption = "Qtde (1)"
                .Header1.FontName = "Tahoma"
                .Header1.FontSize = 8
                .Header1.Alignment = 2
            ENDWITH

            WITH .Column3
                .Width         = 31
                .ControlSource = "cursor_4c_Resumo.CUnis"
                .Header1.Caption = "Unid."
                .Header1.FontName = "Tahoma"
                .Header1.FontSize = 8
                .Header1.Alignment = 2
            ENDWITH

            WITH .Column4
                .Width         = 80
                .ControlSource = "cursor_4c_Resumo.Peso2s"
                .Header1.Caption = "Qtde (2)"
                .Header1.FontName = "Tahoma"
                .Header1.FontSize = 8
                .Header1.Alignment = 2
            ENDWITH

            WITH .Column5
                .Width         = 31
                .ControlSource = "cursor_4c_Resumo.CUniPs"
                .Header1.Caption = "Unid."
                .Header1.FontName = "Tahoma"
                .Header1.FontSize = 8
                .Header1.Alignment = 2
            ENDWITH

            WITH .Column6
                .Width         = 80
                .ControlSource = "cursor_4c_Resumo.Pesos"
                .Header1.Caption = "Peso Fabr."
                .Header1.FontName = "Tahoma"
                .Header1.FontSize = 8
                .Header1.Alignment = 2
            ENDWITH

            .Visible = .T.
        ENDWITH

        *-- Redefine ControlSource apos RecordSource para neutralizar auto-bind do VFP
        THIS.grd_4c_Resumo.Column1.ControlSource = "cursor_4c_Resumo.CMats"
        THIS.grd_4c_Resumo.Column2.ControlSource = "cursor_4c_Resumo.Qtds"
        THIS.grd_4c_Resumo.Column3.ControlSource = "cursor_4c_Resumo.CUnis"
        THIS.grd_4c_Resumo.Column4.ControlSource = "cursor_4c_Resumo.Peso2s"
        THIS.grd_4c_Resumo.Column5.ControlSource = "cursor_4c_Resumo.CUniPs"
        THIS.grd_4c_Resumo.Column6.ControlSource = "cursor_4c_Resumo.Pesos"
    ENDPROC

    *==========================================================================
    * ConfigurarCamposExtras - Label+TextBox descricao e TextBox total peso
    * Say2 "Descricao :" + Get_descr (descricao da linha corrente do grid)
    * getTotPeso (soma PsFaseAnt calculada em InicializarDistrib)
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarCamposExtras()
        THIS.AddObject("lbl_4c_Label2", "Label")
        WITH THIS.lbl_4c_Label2
            .Caption   = "Descri" + CHR(231) + CHR(227) + "o : "
            .Top       = 458
            .Left      = 71
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        THIS.AddObject("txt_4c_Descr", "TextBox")
        WITH THIS.txt_4c_Descr
            .Top           = 454
            .Left          = 131
            .Width         = 335
            .Height        = 23
            .ReadOnly      = .T.
            .ControlSource = "cursor_4c_Distrib.CDescs"
            .FontName      = "Tahoma"
            .FontSize      = 8
            .BackColor     = RGB(240, 240, 240)
            .BorderStyle   = 1
            .Themes        = .F.
            .Visible       = .T.
        ENDWITH

        THIS.AddObject("txt_4c_TotPeso", "TextBox")
        WITH THIS.txt_4c_TotPeso
            .Top         = 454
            .Left        = 577
            .Width       = 81
            .Height      = 23
            .ReadOnly    = .T.
            .Alignment   = 3
            .Value       = THIS.this_nTotPeso
            .FontName    = "Tahoma"
            .FontSize    = 8
            .ForeColor   = RGB(0, 0, 0)
            .BackColor   = RGB(240, 240, 240)
            .BorderStyle = 1
            .Themes      = .F.
            .Visible     = .T.
        ENDWITH
    ENDPROC

    *==========================================================================
    * ConfigurarBotoes - Botoes Alterar (left=650) e OK (left=725)
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarBotoes()
        THIS.AddObject("cmd_4c_Alterar", "CommandButton")
        WITH THIS.cmd_4c_Alterar
            .Top             = 3
            .Left            = 650
            .Width           = 75
            .Height          = 75
            .Caption         = "Alterar"
            .FontName        = "Tahoma"
            .FontSize        = 8
            .FontBold        = .T.
            .FontItalic      = .T.
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .Themes          = .F.
            .SpecialEffect   = 0
            .PicturePosition = 13
            .MousePointer    = 15
            .WordWrap        = .T.
            .Picture         = gc_4c_CaminhoIcones + "cadastro_alterar_60.jpg"
            .Visible         = .T.
        ENDWITH
        BINDEVENT(THIS.cmd_4c_Alterar, "Click", THIS, "BtnAlterarClick")

        THIS.AddObject("cmd_4c_Ok", "CommandButton")
        WITH THIS.cmd_4c_Ok
            .Top             = 3
            .Left            = 725
            .Width           = 75
            .Height          = 75
            .Caption         = "OK"
            .FontName        = "Tahoma"
            .FontSize        = 8
            .FontBold        = .T.
            .FontItalic      = .T.
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .Themes          = .F.
            .SpecialEffect   = 0
            .PicturePosition = 13
            .MousePointer    = 15
            .WordWrap        = .T.
            .Picture         = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
            .Visible         = .T.
        ENDWITH
        BINDEVENT(THIS.cmd_4c_Ok, "Click", THIS, "BtnOkClick")
    ENDPROC

    *==========================================================================
    * BtnAlterarClick - Habilita edicao nas colunas Pesos, Qtds e Peso2s
    * BackColor 12713983 = RGB(255,255,193) pale-yellow do legado
    *==========================================================================
    PROCEDURE BtnAlterarClick()
        WITH THIS.grd_4c_Dados
            .Column3.ReadOnly  = .F.
            .Column3.BackColor = RGB(255, 255, 193)
            .Column5.ReadOnly  = .F.
            .Column5.BackColor = RGB(255, 255, 193)
            .Column8.ReadOnly  = .F.
            .Column8.BackColor = RGB(255, 255, 193)
            .Refresh()
        ENDWITH
        THIS.this_oBusinessObject.HabilitarAlteracao()
        THIS.grd_4c_Dados.Column5.SetFocus()
    ENDPROC

    *==========================================================================
    * BtnIncluirClick - Reinicializa distribuicao a partir de xNensi
    *
    * SIGPDMP1 legado nao possui botao Incluir explicito; a "inclusao" ocorre
    * automaticamente no Init quando pcEscolha = "INSERIR" via reconstrucao
    * do cursor TmpDistrib percorrendo xNensi.Visivel = .F.. Este metodo
    * replica essa logica: recarrega cursor_4c_Distrib e cursor_4c_Resumo do
    * xNensi compartilhado pelo form pai e refresca grids e totalizador.
    *==========================================================================
    PROCEDURE BtnIncluirClick()
        LOCAL loc_cTitulo
        loc_cTitulo = THIS.this_oBusinessObject.this_cTitulo
        THIS.this_oBusinessObject.InicializarDistrib(loc_cTitulo)
        THIS.this_oBusinessObject.InicializarResumo()
        THIS.this_nTotPeso  = THIS.this_oBusinessObject.this_nTotPeso
        THIS.this_nRecnoAnt = THIS.this_oBusinessObject.this_nRecnoAnt
        IF VARTYPE(THIS.txt_4c_TotPeso) = "O"
            THIS.txt_4c_TotPeso.Value = THIS.this_nTotPeso
        ENDIF
        IF VARTYPE(THIS.grd_4c_Dados) = "O"
            THIS.grd_4c_Dados.Refresh()
        ENDIF
        IF VARTYPE(THIS.grd_4c_Resumo) = "O"
            THIS.grd_4c_Resumo.Refresh()
        ENDIF
        IF VARTYPE(THIS.txt_4c_Descr) = "O"
            THIS.txt_4c_Descr.Refresh()
        ENDIF
    ENDPROC

    *==========================================================================
    * BtnVisualizarClick - Restaura grid para modo somente-leitura
    *
    * Operacao inversa de BtnAlterarClick: ReadOnly = .T. e BackColor branco
    * nas colunas Pesos/Qtds/Peso2s, e desliga flag this_lLiberaAlteracao no
    * BO para que SalvarAlteracoes nao persista nada em xNensi.
    *==========================================================================
    PROCEDURE BtnVisualizarClick()
        IF VARTYPE(THIS.grd_4c_Dados) = "O"
            WITH THIS.grd_4c_Dados
                .Column3.ReadOnly  = .T.
                .Column3.BackColor = RGB(255, 255, 255)
                .Column5.ReadOnly  = .T.
                .Column5.BackColor = RGB(255, 255, 255)
                .Column8.ReadOnly  = .T.
                .Column8.BackColor = RGB(255, 255, 255)
                .Refresh()
            ENDWITH
        ENDIF
        IF VARTYPE(THIS.this_oBusinessObject) = "O"
            THIS.this_oBusinessObject.this_lLiberaAlteracao = .F.
        ENDIF
    ENDPROC

    *==========================================================================
    * BtnExcluirClick - Descarta alteracoes feitas em cursor_4c_Distrib
    *
    * Confirma com o usuario e recarrega cursor_4c_Distrib do xNensi
    * (chamando InicializarDistrib novamente). Qualquer linha marcada como
    * modificada (Locals = 'M') eh perdida. Util quando o usuario decide
    * cancelar as alteracoes antes de pressionar OK.
    *==========================================================================
    PROCEDURE BtnExcluirClick()
        LOCAL loc_cTitulo, loc_cMsg
        loc_cMsg = "Descartar todas as altera" + CHR(231) + CHR(245) + "es?"
        IF !MsgConfirma(loc_cMsg, "Confirma" + CHR(231) + CHR(227) + "o")
            RETURN
        ENDIF
        loc_cTitulo = THIS.this_oBusinessObject.this_cTitulo
        THIS.this_oBusinessObject.InicializarDistrib(loc_cTitulo)
        THIS.this_oBusinessObject.InicializarResumo()
        THIS.this_nTotPeso = THIS.this_oBusinessObject.this_nTotPeso
        IF VARTYPE(THIS.txt_4c_TotPeso) = "O"
            THIS.txt_4c_TotPeso.Value = THIS.this_nTotPeso
        ENDIF
        IF VARTYPE(THIS.grd_4c_Dados) = "O"
            THIS.grd_4c_Dados.Refresh()
        ENDIF
        IF VARTYPE(THIS.grd_4c_Resumo) = "O"
            THIS.grd_4c_Resumo.Refresh()
        ENDIF
        IF VARTYPE(THIS.txt_4c_Descr) = "O"
            THIS.txt_4c_Descr.Refresh()
        ENDIF
    ENDPROC

    *==========================================================================
    * BtnOkClick - Persiste alteracoes em xNensi e fecha o form
    *==========================================================================
    PROCEDURE BtnOkClick()
        THIS.this_oBusinessObject.SalvarAlteracoes()

        IF USED("xNensi")
            SELECT xNensi
            SET ORDER TO Editar
            IF THIS.this_nRecnoAnt > 0
                GO THIS.this_nRecnoAnt
            ENDIF
        ENDIF

        IF VARTYPE(THIS.this_oFormPai) = "O"
            THIS.this_oFormPai.Enabled = .T.
        ENDIF

        THIS.Release()
    ENDPROC

    *==========================================================================
    * GrdDistribAfterRowColChange - Atualiza campo descricao ao mudar linha/col
    *==========================================================================
    PROCEDURE GrdDistribAfterRowColChange(par_nColIndex)
        IF VARTYPE(THIS.txt_4c_Descr) = "O"
            THIS.txt_4c_Descr.Refresh()
        ENDIF
    ENDPROC

    *-- Handlers GotFocus/LostFocus para colunas editaveis (When/Valid do legado)

    PROCEDURE GrdCol3GotFocus()
        THIS.this_nAntValue = THIS.grd_4c_Dados.Column3.Text1.Value
    ENDPROC

    PROCEDURE GrdCol3LostFocus(par_nKeyCode, par_nShiftAltCtrl)
        IF THIS.grd_4c_Dados.Column3.Text1.Value <> THIS.this_nAntValue
            THIS.this_oBusinessObject.MarcarModificado()
        ENDIF
    ENDPROC

    PROCEDURE GrdCol5GotFocus()
        THIS.this_nAntValue = THIS.grd_4c_Dados.Column5.Text1.Value
    ENDPROC

    PROCEDURE GrdCol5LostFocus(par_nKeyCode, par_nShiftAltCtrl)
        IF THIS.grd_4c_Dados.Column5.Text1.Value <> THIS.this_nAntValue
            THIS.this_oBusinessObject.MarcarModificado()
        ENDIF
    ENDPROC

    PROCEDURE GrdCol8GotFocus()
        THIS.this_nAntValue = THIS.grd_4c_Dados.Column8.Text1.Value
    ENDPROC

    PROCEDURE GrdCol8LostFocus(par_nKeyCode, par_nShiftAltCtrl)
        IF THIS.grd_4c_Dados.Column8.Text1.Value <> THIS.this_nAntValue
            THIS.this_oBusinessObject.MarcarModificado()
        ENDIF
    ENDPROC

    *==========================================================================
    * CarregarLista - Recarrega cursores de distribuicao e resumo e refresca grids
    * Equivale ao bloco de carga do Init para uso apos alteracoes externas.
    *==========================================================================
    PROCEDURE CarregarLista()
        LOCAL loc_cTitulo
        loc_cTitulo = THIS.this_oBusinessObject.this_cTitulo
        THIS.this_oBusinessObject.InicializarDistrib(loc_cTitulo)
        THIS.this_oBusinessObject.InicializarResumo()
        THIS.this_nTotPeso  = THIS.this_oBusinessObject.this_nTotPeso
        THIS.this_nRecnoAnt = THIS.this_oBusinessObject.this_nRecnoAnt
        IF VARTYPE(THIS.txt_4c_TotPeso) = "O"
            THIS.txt_4c_TotPeso.Value = THIS.this_nTotPeso
        ENDIF
        IF VARTYPE(THIS.grd_4c_Dados) = "O"
            THIS.grd_4c_Dados.Refresh()
        ENDIF
        IF VARTYPE(THIS.grd_4c_Resumo) = "O"
            THIS.grd_4c_Resumo.Refresh()
        ENDIF
        IF VARTYPE(THIS.txt_4c_Descr) = "O"
            THIS.txt_4c_Descr.Refresh()
        ENDIF
    ENDPROC

    *==========================================================================
    * FormParaBO - Sincroniza propriedades de controle do form para o BO
    * O BO gerencia cursor_4c_Distrib diretamente; apenas sincroniza estado.
    *==========================================================================
    PROTECTED PROCEDURE FormParaBO()
        THIS.this_oBusinessObject.this_nTotPeso         = THIS.this_nTotPeso
        THIS.this_oBusinessObject.this_lLiberaAlteracao = THIS.this_lLiberaAlteracao
    ENDPROC

    *==========================================================================
    * BOParaForm - Atualiza controles do form com dados do BO
    * Refresca totalizador de peso e campo de descricao da linha corrente.
    *==========================================================================
    PROTECTED PROCEDURE BOParaForm()
        THIS.this_nTotPeso = THIS.this_oBusinessObject.this_nTotPeso
        IF VARTYPE(THIS.txt_4c_TotPeso) = "O"
            THIS.txt_4c_TotPeso.Value = THIS.this_nTotPeso
        ENDIF
        IF VARTYPE(THIS.txt_4c_Descr) = "O"
            THIS.txt_4c_Descr.Refresh()
        ENDIF
    ENDPROC

    *==========================================================================
    * HabilitarCampos - Habilita ou desabilita edicao nas colunas do grid
    * par_lHabilitar = .T. -> colunas Pesos/Qtds/Peso2s editaveis (amarelo)
    * par_lHabilitar = .F. -> colunas somente-leitura (branco)
    *==========================================================================
    PROTECTED PROCEDURE HabilitarCampos(par_lHabilitar)
        IF VARTYPE(THIS.grd_4c_Dados) = "O"
            WITH THIS.grd_4c_Dados
                .Column3.ReadOnly = !par_lHabilitar
                .Column5.ReadOnly = !par_lHabilitar
                .Column8.ReadOnly = !par_lHabilitar
                IF par_lHabilitar
                    .Column3.BackColor = RGB(255, 255, 193)
                    .Column5.BackColor = RGB(255, 255, 193)
                    .Column8.BackColor = RGB(255, 255, 193)
                ELSE
                    .Column3.BackColor = RGB(255, 255, 255)
                    .Column5.BackColor = RGB(255, 255, 255)
                    .Column8.BackColor = RGB(255, 255, 255)
                ENDIF
                .Refresh()
            ENDWITH
        ENDIF
    ENDPROC

    *==========================================================================
    * LimparCampos - Reseta estado do form para o estado inicial (sem edicao)
    * Zera totalizador, desativa modo de edicao e restaura colunas ReadOnly.
    *==========================================================================
    PROTECTED PROCEDURE LimparCampos()
        THIS.this_nTotPeso         = 0
        THIS.this_lLiberaAlteracao = .F.
        IF VARTYPE(THIS.txt_4c_TotPeso) = "O"
            THIS.txt_4c_TotPeso.Value = 0
        ENDIF
        IF VARTYPE(THIS.this_oBusinessObject) = "O"
            THIS.this_oBusinessObject.this_lLiberaAlteracao = .F.
        ENDIF
        THIS.HabilitarCampos(.F.)
    ENDPROC

    *==========================================================================
    * AjustarBotoesPorModo - Controla visibilidade do botao Alterar conforme modo
    * Botao Alterar visivel somente no modo INSERIR (replica fChecaAcesso do legado)
    *==========================================================================
    PROTECTED PROCEDURE AjustarBotoesPorModo()
        IF VARTYPE(THIS.cmd_4c_Alterar) = "O"
            THIS.cmd_4c_Alterar.Visible = INLIST(ALLTRIM(THIS.this_cEscolha), "INSERIR")
        ENDIF
    ENDPROC

    *==========================================================================
    * BtnSalvarClick - Persiste alteracoes e fecha (equivalente ao BtnOkClick)
    *==========================================================================
    PROCEDURE BtnSalvarClick()
        THIS.BtnOkClick()
    ENDPROC

    *==========================================================================
    * BtnCancelarClick - Fecha o form sem persistir alteracoes
    * Reabilita o form pai antes de encerrar.
    *==========================================================================
    PROCEDURE BtnCancelarClick()
        IF VARTYPE(THIS.this_oFormPai) = "O"
            THIS.this_oFormPai.Enabled = .T.
        ENDIF
        THIS.Release()
    ENDPROC

    *==========================================================================
    * BtnEncerrarClick - Fecha o form sem persistir alteracoes
    * Form operacional nao possui botao Encerrar fisico; metodo existe para
    * compatibilidade com FormBase e pode ser invocado via ESC/KeyPress.
    *==========================================================================
    PROCEDURE BtnEncerrarClick()
        IF VARTYPE(THIS.this_oFormPai) = "O"
            THIS.this_oFormPai.Enabled = .T.
        ENDIF
        THIS.Release()
    ENDPROC

    *==========================================================================
    * BtnBuscarClick - Nao aplicavel em form operacional SIGPDMP1
    * Metodo existe para compatibilidade com FormBase. Navega para o topo do
    * grid principal como comportamento neutro.
    *==========================================================================
    PROCEDURE BtnBuscarClick()
        IF VARTYPE(THIS.grd_4c_Dados) = "O"
            IF USED("cursor_4c_Distrib") AND !EOF("cursor_4c_Distrib")
                SELECT cursor_4c_Distrib
                GO TOP
            ENDIF
            THIS.grd_4c_Dados.Refresh()
        ENDIF
    ENDPROC

    *==========================================================================
    * Destroy - Libera BO e referencia ao form pai
    *==========================================================================
    PROCEDURE Destroy()
        THIS.this_oBusinessObject = .NULL.
        THIS.this_oFormPai        = .NULL.
        DODEFAULT()
    ENDPROC

ENDDEFINE


### BO (C:\4c\projeto\app\classes\SigPdMp1BO.prg):
*==============================================================================
* SIGPDMP1BO.PRG
* Business Object para Componentes Agregados (SIGPDMP1)
* Form operacional: exibe e permite edicao de componentes de uma operacao
* de industrializacao. Recebe cursor xNensi do form pai e trabalha
* com cursores locais cursor_4c_Distrib e cursor_4c_Resumo.
*==============================================================================

DEFINE CLASS SigPdMp1BO AS BusinessBase

    *-- Tabela e chave (form operacional sem CRUD direto na tabela principal)
    this_cTabela     = ""
    this_cCampoChave = ""

    *-- Dados da operacao (vindos de tmpnens / xNensi do form pai)
    this_nNumPs  = 0    && Numero da operacao (tmpnens.numps)
    this_cEmps   = ""   && Empresa (tmpnens.emps)
    this_cDOpPs  = ""   && Descricao da operacao (tmpnens.dopps)
    this_cTitulo = ""   && Titulo da col. Industrializacao (ParentForm.ParentForm.Titulo)

    *-- Controle de edicao
    this_lLiberaAlteracao = .F.  && .T. quando usuario clica Alterar
    this_cEscolha         = ""   && "INSERIR" ou outro modo vindo do form pai

    *-- Posicao de navegacao em xNensi antes de abrir o form
    this_nRecnoAnt = 0

    *-- Totalizador de peso (soma de PsFaseAnt dos registros nao-visiveis)
    this_nTotPeso = 0

    *-- Valor anterior de celula em edicao no grid (controle de alteracao)
    this_nAntValue = 0

    *--------------------------------------------------------------------------
    * INIT - Inicializa BO operacional de Componentes Agregados
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        THIS.this_cTabela     = ""
        THIS.this_cCampoChave = ""
        DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Retorna identificador da operacao corrente
    *--------------------------------------------------------------------------
    FUNCTION ObterChavePrimaria()
        RETURN THIS.this_nNumPs
    ENDFUNC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Carrega propriedades do BO a partir de cursor_4c_Distrib
    * Mapeia colunas da linha corrente do grid principal
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        IF USED(par_cAliasCursor)
            SELECT (par_cAliasCursor)
            THIS.this_nNumPs = TratarNulo(Nops,   "N")
            THIS.this_cEmps  = ALLTRIM(TratarNulo(CMats,  "C"))
            THIS.this_cDOpPs = ALLTRIM(TratarNulo(CDescs, "C"))
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * InicializarDistrib - Cria cursor_4c_Distrib a partir de xNensi
    * Equivale ao bloco de criacao do TmpDistrib no Init original.
    * Percorre xNensi na ordem NopCMat, incluindo apenas registros onde
    * Visivel = .F. (os que ainda nao foram distribuidos).
    * par_cTitulo: caption dinamico da coluna Industrializacao
    * Retorna .T. em caso de sucesso
    *--------------------------------------------------------------------------
    FUNCTION InicializarDistrib(par_cTitulo)
        LOCAL loc_lSucesso, loc_nTotPeso, loc_nX, loc_nQtds, loc_nPesos
        loc_lSucesso = .F.
        loc_nTotPeso = 0
        loc_nX       = 1

        TRY
            THIS.this_cTitulo = par_cTitulo

            *-- Salva posicao corrente de xNensi para restaurar no OK
            SELECT xNensi
            THIS.this_nRecnoAnt = RECNO()

            *-- Recria cursor de distribuicao
            IF USED("cursor_4c_Distrib")
                USE IN cursor_4c_Distrib
            ENDIF

            SET NULL ON
            CREATE CURSOR cursor_4c_Distrib ( ;
                Nops    N(10,0), ;
                Nenvs   N(10,0), ;
                CodPds  C(10),   ;
                CMats   C(14),   ;
                CUnis   C(3),    ;
                Qtds    N(10,3), ;
                Pesos   N(10,3), ;
                Qtds2   N(10,3), ;
                Pesos2  N(10,3), ;
                CDescs  C(40),   ;
                CGrus   C(3),    ;
                TpOps   C(15),   ;
                nLotes  N(10,0), ;
                Qtd2s   N(10,3), ;
                Peso2s  N(10,3), ;
                cUniPs  C(3),    ;
                CodCors C(4),    ;
                CodTams C(4),    ;
                nTrans  N(6,0),  ;
                Locals  C(1)     ;
            )

            *-- Percorre xNensi em ordem NopCMat, pula visiveis (ja distribuidos)
            SELECT xNensi
            SET ORDER TO NopCMat
            SCAN
                IF xNensi.Visivel
                    LOOP
                ENDIF

                loc_nQtds  = xNensi.QtFaseAnt
                loc_nPesos = xNensi.PsFaseAnt

                REPLACE nTrans WITH loc_nX IN xNensi

                INSERT INTO cursor_4c_Distrib ( ;
                    Nops, Nenvs, Qtds2, Pesos2, CUnis, CMats, CDescs, ;
                    CGrus, Qtds, Pesos, nLotes, Peso2s, cUniPs, ;
                    CodCors, CodTams, nTrans ;
                ) VALUES ( ;
                    xNensi.Nops, xNensi.Nenvs, loc_nQtds, loc_nPesos, ;
                    xNensi.CUnis, xNensi.CMats, xNensi.CDescs, ;
                    xNensi.CGrus, xNensi.Qtds, xNensi.Pesos, xNensi.nLotes, ;
                    xNensi.Peso2s, xNensi.cUniPs, xNensi.CodCors, ;
                    xNensi.CodTams, xNensi.nTrans ;
                )

                loc_nX       = loc_nX + 1
                loc_nTotPeso = loc_nTotPeso + loc_nPesos
            ENDSCAN

            THIS.this_nTotPeso = loc_nTotPeso

            SELECT cursor_4c_Distrib
            GO TOP
            SET NULL OFF

            loc_lSucesso = .T.

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * InicializarResumo - Cria cursor_4c_Resumo com totais por componente
    * Replica SELECT...GROUP BY...INTO CURSOR TmpResumo do Init original.
    * Agrupa xNensi onde Visivel = .T. (registros ja distribuidos).
    * Retorna .T. em caso de sucesso
    *--------------------------------------------------------------------------
    FUNCTION InicializarResumo()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF USED("cursor_4c_Resumo")
                USE IN cursor_4c_Resumo
            ENDIF

            SELECT CMats, CUnis, CUniPs,      ;
                   SUM(Qtds)   AS Qtds,       ;
                   SUM(Pesos)  AS Pesos,      ;
                   SUM(Peso2s) AS Peso2s      ;
            FROM xNensi                       ;
            WHERE xNensi.Visivel              ;
            GROUP BY CMats, CUnis, CUniPs     ;
            INTO CURSOR cursor_4c_Resumo READWRITE

            SELECT cursor_4c_Resumo
            GO TOP

            loc_lSucesso = .T.

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * SalvarAlteracoes - Grava linhas modificadas de cursor_4c_Distrib em xNensi
    * Replica logica do botao OK original.
    * So persiste quando this_lLiberaAlteracao = .T. (usuario clicou Alterar).
    * Identifica linhas modificadas pelo campo Locals = 'M'.
    * Atualiza Qtds, Pesos e Peso2s em xNensi via nTrans.
    * Retorna .T. em caso de sucesso
    *--------------------------------------------------------------------------
    FUNCTION SalvarAlteracoes()
        LOCAL loc_lSucesso
        loc_lSucesso = .T.

        TRY
            IF THIS.this_lLiberaAlteracao
                SELECT cursor_4c_Distrib
                SCAN
                    IF cursor_4c_Distrib.Locals = "M"
                        SELECT xNensi
                        LOCATE FOR nTrans = cursor_4c_Distrib.nTrans
                        IF !EOF()
                            REPLACE Qtds   WITH cursor_4c_Distrib.Qtds, ;
                                    Pesos  WITH cursor_4c_Distrib.Pesos, ;
                                    Peso2s WITH cursor_4c_Distrib.Peso2s
                        ENDIF
                    ENDIF
                ENDSCAN
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * HabilitarAlteracao - Permite edicao nas colunas Pesos, Qtds e Peso2s
    * Define this_lLiberaAlteracao = .T. para que SalvarAlteracoes persista
    *--------------------------------------------------------------------------
    PROCEDURE HabilitarAlteracao()
        THIS.this_lLiberaAlteracao = .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * MarcarModificado - Marca registro corrente de cursor_4c_Distrib como 'M'
    * Chamado pelos handlers de Valid/KeyPress do grid ao detectar mudanca
    *--------------------------------------------------------------------------
    PROCEDURE MarcarModificado()
        LOCAL loc_oErro
        TRY
            IF USED("cursor_4c_Distrib")
                REPLACE Locals WITH "M" IN cursor_4c_Distrib
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir - Nao aplicavel: form operacional nao insere registros no banco
    * A criacao inicial dos componentes ocorre via InicializarDistrib (cursor
    * em memoria) e a persistencia eh feita em xNensi pelo form pai (SigPdMov)
    * no momento do salvamento global da operacao.
    *--------------------------------------------------------------------------
    PROCEDURE Inserir()
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - Persiste alteracoes do cursor_4c_Distrib em xNensi
    * Equivale ao "OK Click" do form original: percorre linhas marcadas como
    * 'M' (modificadas) e replica Qtds/Pesos/Peso2s para o cursor pai xNensi
    * via campo nTrans. Form operacional nao executa UPDATE direto no banco;
    * a gravacao em SigPdNen ocorre pelo form SigPdMov que mantem xNensi.
    *--------------------------------------------------------------------------
    PROCEDURE Atualizar()
        RETURN THIS.SalvarAlteracoes()
    ENDPROC

    *--------------------------------------------------------------------------
    * RegistrarAuditoria - Nao aplicavel: form operacional usa cursores locais
    * Alteracoes ficam em xNensi (cursor do datasession do form pai)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE RegistrarAuditoria(par_cOperacao)
        IF EMPTY(par_cOperacao)
            RETURN
        ENDIF
        RETURN
    ENDPROC

ENDDEFINE


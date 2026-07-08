# CODE REVIEW - PASS SQL: SQL Validation (colunas, tabelas, aspas, filtros)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **SQL Validation (colunas, tabelas, aspas, filtros)**.

## PROBLEMAS DETECTADOS (1)
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'PENVELOPE' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: SERVICOS, GLOBALIZAS, DOPPS, NUMPS, ICLIS

## INSTRUCOES DE CORRECAO
### Foco deste pass: CORRECOES SQL
- [GRID-SQL] Campos no ControlSource que nao existem no CREATE CURSOR/SELECT
- [SQL-COLUNA] Nomes de colunas que NAO existem na tabela (validado contra banco real)
  - A mensagem mostra colunas VALIDAS - usar nome EXATO
  - Se sugere "voce quis dizer 'X'?", usar X
- [SQL-TABELA] Tabela inventada que nao existe no original
- [SQL-ASPAS] Aspas duplicadas ou concatenacao sem EscaparSQL
  - EscaparSQL() JA retorna com aspas. FormatarDataSQL() idem.
- [SQL-FILTRO-INVENTADO] Condicao WHERE inventada pela LLM - REMOVER
- [TRANSACAO-AVULSA] COMMIT/ROLLBACK sem BEGIN TRANSACTION - REMOVER

## REGRAS OBRIGATORIAS
- Corrigir APENAS os problemas listados, NAO alterar logica de negocio
- NAO remover campos, funcionalidades ou lookups
- **PROIBIDO alterar propriedades visuais** (Width, Height, Top, Left, BackColor, ForeColor, FontName, FontSize) EXCETO se o problema eh especificamente de ALINHAMENTO
- NUNCA juntar linhas com `;` numa linha unica
- Usar Write tool para salvar os arquivos corrigidos nos mesmos caminhos

### LINHAS SQL/CONTROLSOURCE DO CODIGO ORIGINAL (referencia):
Insert Into csCabecalho (cb_empresa, cb_titulo) Values (lcCbEmpresa, lcCbTitulo)
lcQuery = [Select Distinct DigEnves From SigCdOpe Where (Servicos = 1 Or Servicos = 2) Or ]+;
If (ThisForm.poDataMgr.SqlExecute(lcQuery, 'crTmpOpe') < 1)
lcSql = [Select DopEnvels From SigCdPam ]
ThisForm.Podatamgr.Sqlexecute(lcsql,'TmpParam')
SELECT CrTmpOpe
	lcQuery = [Select Nenvs, cIdChaves, Datas, Emps, Dopps, Numps, GrupoOs, ] + ;
			    [From SigPdMvf ] + ;
	If (ThisForm.poDataMgr.SqlExecute(lcQuery, 'crSigPdMvf') < 1)
	Select crSigPdMvf
		Create Cursor Temp_HisOp From Array xMfas
	Select crSigPdMvf
		lcQuery = [Select Rclis From SigCdCli Where Iclis = ']+m.ContaOs+[']
		=ThisForm.PodataMgr.SqlExecute(lcQuery,'CrTmpCli')
		lcQuery = [Select Rclis From SigCdCli Where Iclis = ']+m.ContaDs+[']
		=ThisForm.PodataMgr.SqlExecute(lcQuery,'CrTmpCli')
		Select Temp_HisOp
Select Temp_HisOp
	lcSql = [Select ObsOps From SigCdCe Where Iclis = ']+lcConta+[']
	If Thisform.Podatamgr.Sqlexecute(lcsql,'TmpCliE') > 0
		Select Temp_HisOp
	Select Temp_HisOp
		lcSql = [Select ObsOps From SigCdCe Where Iclis = ']+lcConta+[']
		Select Temp_HisOp
		If Thisform.Podatamgr.Sqlexecute(lcsql,'TmpCliE') > 0
Select Temp_HisOp

## CODIGO ATUAL DOS ARQUIVOS

### FORM (C:\4c\projeto\app\forms\relatorios\FormSigReHev.prg) - PRIMEIRAS 753 de 753 linhas:
*==============================================================================
* FORMSIGREHE.PRG
* Hist" + CHR(243) + "rico de Envelopes
* Tipo: REPORT (herda FormBase, BO herda RelatorioBase)
* Migrado de: SIGREHEV.SCX (frmrelatorio)
*
* Layout: FLAT (campos diretamente no form, sem PageFrame CRUD)
*   Cabe" + CHR(231) + "alho escuro + CommandGroup 4 bot" + CHR(245) + "es
*   Campo de filtro: Envelope (n" + CHR(250) + "mero inteiro)
*
* FASE 8/8 - COMPLETO
*   * DEFINE CLASS com propriedades
*   * Init() com tratamento de pEnvelope (modo autom" + CHR(225) + "tico)
*   * InicializarForm() / ConfigurarCabecalho() / ConfigurarBotoes()
*   * ConfigurarPageFrame() (1 p" + CHR(225) + "gina - Filtros)
*   * ConfigurarEventos() / TxtOpKeyPress()
*   * BtnVisualizarClick / BtnImprimirClick / BtnExcelClick / BtnEncerrarClick
*   * BtnIncluirClick / BtnAlterarClick / BtnExcluirClick (mapeamento CRUD-REPORT)
*   * BtnBuscarClick / BtnSalvarClick / BtnCancelarClick
*   * FormParaBO / BOParaForm / FormParaRelatorio
*   * HabilitarCampos / LimparCampos / CarregarLista
*   * AjustarBotoesPorModo / AlternarPagina
*   * Destroy()
*==============================================================================

DEFINE CLASS FormSigReHev AS FormBase

    *-- Dimens" + CHR(245) + "es e apar" + CHR(234) + "ncia (EXATAS do original: Width=800, Height=300)
    Height      = 300
    Width       = 800
    DataSession = 2
    ShowWindow  = 1
    WindowType  = 1
    AutoCenter  = .T.
    BorderStyle = 2
    ControlBox  = .F.
    MaxButton   = .F.
    MinButton   = .F.
    TitleBar    = 0
    Themes      = .F.
    ShowTips    = .T.

    *-- Refer" + CHR(234) + "ncia ao BO de relat" + CHR(243) + "rio (instanciado em InicializarForm)
    this_oRelatorio    = .NULL.
    this_cMensagemErro = ""

    *-- N" + CHR(250) + "mero do envelope passado por par" + CHR(226) + "metro (legado: ThisForm.Envelope)
    Envelope = 0

    *-- Controle de acesso resumido (legado: placesso)
    this_lAcesso = .F.

    *--------------------------------------------------------------------------
    * Init - Inicializa form com suporte a modo autom" + CHR(225) + "tico (pEnvelope)
    *   Se chamado com pEnvelope num" + CHR(233) + "rico: processa relat" + CHR(243) + "rio e fecha sem exibir form.
    *   Equivalente ao comportamento do Init original (SIGREHEV) com pEnvelope.
    *--------------------------------------------------------------------------
    PROCEDURE Init(pEnvelope)
        LOCAL loc_lSucesso
        THIS.Envelope = 0
        loc_lSucesso = DODEFAULT()

        IF loc_lSucesso AND TYPE("pEnvelope") = "N" AND pEnvelope > 0
            THIS.Envelope = pEnvelope
            THIS.this_oRelatorio.this_nEnvelope = pEnvelope
            THIS.pgf_4c_Paginas.Page1.txt_4c_Op.Value = pEnvelope
            IF !THIS.this_oRelatorio.Visualizar()
                MsgErro(THIS.this_oRelatorio.ObterMensagemErro(), "Erro")
            ENDIF
            THIS.Release()
            loc_lSucesso = .F.
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * InicializarForm - Cria estrutura base do formul" + CHR(225) + "rio de relat" + CHR(243) + "rio
    *   1. Define Caption / Picture (fundo)
    *   2. Cria SigReHevBO
    *   3. Monta cabe" + CHR(231) + "alho escuro + bot" + CHR(245) + "es do relat" + CHR(243) + "rio + PageFrame
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lSucesso, loc_lContinuar
        loc_lSucesso   = .F.
        loc_lContinuar = .T.
        TRY
            THIS.Caption = "Hist" + CHR(243) + "rico de Envelopes"

            IF TYPE("gc_4c_CaminhoIcones") = "U"
                gc_4c_CaminhoIcones = ""
            ENDIF
            THIS.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"

            THIS.this_oRelatorio = CREATEOBJECT("SigReHevBO")
            IF VARTYPE(THIS.this_oRelatorio) != "O"
                MsgErro("Erro ao criar SigReHevBO" + CHR(13) + ;
                    "VARTYPE retornou: " + VARTYPE(THIS.this_oRelatorio), "Erro")
                loc_lContinuar = .F.
            ENDIF

            IF loc_lContinuar
                THIS.ConfigurarCabecalho()
                THIS.ConfigurarBotoes()
                THIS.ConfigurarPageFrame()
                THIS.ConfigurarCamposFiltro()
                THIS.ConfigurarPaginaLista()
                THIS.ConfigurarPaginaDados()
                THIS.ConfigurarEventos()

                THIS.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
                THIS.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption

                THIS.LimparCampos()
                THIS.AlternarPagina(1)
                THIS.Visible = .T.
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro Detalhado")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarCabecalho - Container escuro superior com t" + CHR(237) + "tulo do relat" + CHR(243) + "rio
    *   Equivalente ao cntSombra do frmrelatorio legado.
    *   Largura = Width do form (cobre toda a faixa superior).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarCabecalho()
        THIS.AddObject("cnt_4c_Cabecalho", "Container")
        WITH THIS.cnt_4c_Cabecalho
            .Top         = 0
            .Left        = 0
            .Width       = THIS.Width
            .Height      = 80
            .BackStyle   = 1
            .BackColor   = RGB(100, 100, 100)
            .BorderWidth = 0
            .Visible     = .T.

            .AddObject("lbl_4c_Sombra", "Label")
            WITH .lbl_4c_Sombra
                .Top       = 22
                .Left      = 22
                .Width     = THIS.Width
                .Height    = 30
                .Caption   = "Hist" + CHR(243) + "rico de Envelopes"
                .FontName  = "Tahoma"
                .FontSize  = 14
                .FontBold  = .T.
                .ForeColor = RGB(0, 0, 0)
                .BackStyle = 0
                .Visible   = .T.
            ENDWITH

            .AddObject("lbl_4c_Titulo", "Label")
            WITH .lbl_4c_Titulo
                .Top       = 20
                .Left      = 20
                .Width     = THIS.Width
                .Height    = 30
                .Caption   = "Hist" + CHR(243) + "rico de Envelopes"
                .FontName  = "Tahoma"
                .FontSize  = 14
                .FontBold  = .T.
                .ForeColor = RGB(255, 255, 255)
                .BackStyle = 0
                .Visible   = .T.
            ENDWITH
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarBotoes - CommandGroup de bot" + CHR(245) + "es de relat" + CHR(243) + "rio (btnReport)
    *   Original: btnReport.Left=530, Top=0, 4 bot" + CHR(245) + "es
    *   Ordem: Visualiza(left=5), Imprime(left=70), DocExcel(left=135), Sair(left=200)
    *   BINDEVENTs Click vinculados na Fase 7
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarBotoes()
        THIS.AddObject("cmg_4c_Botoes", "CommandGroup")
        WITH THIS.cmg_4c_Botoes
            .Top           = 0
            .Left          = 529
            .Width         = 273
            .Height        = 80
            .ButtonCount   = 4
            .BackStyle     = 0
            .BorderStyle   = 0
            .BorderColor   = RGB(136, 189, 188)
            .SpecialEffect = 1
            .Themes        = .F.
            .Visible       = .T.

            WITH .Buttons(1)
                .Top             = 5
                .Left            = 5
                .Width           = 65
                .Height          = 70
                .Caption         = "Visualizar"
                .FontBold        = .T.
                .FontItalic      = .T.
                .BackColor       = RGB(255, 255, 255)
                .ForeColor       = RGB(90, 90, 90)
                .Picture         = gc_4c_CaminhoIcones + "relatorio_video_26.jpg"
                .PicturePosition = 13
                .SpecialEffect   = 0
                .MousePointer    = 15
                .ToolTipText     = "Gerar o Relat" + CHR(243) + "rio no V" + CHR(237) + "deo"
                .Themes          = .F.
                .Visible         = .T.
            ENDWITH

            WITH .Buttons(2)
                .Top             = 5
                .Left            = 71
                .Width           = 65
                .Height          = 70
                .Caption         = "Imprimir"
                .FontName        = "Tahoma"
                .FontBold        = .T.
                .FontItalic      = .T.
                .FontSize        = 8
                .BackColor       = RGB(255, 255, 255)
                .ForeColor       = RGB(90, 90, 90)
                .Picture         = gc_4c_CaminhoIcones + "relatorio_impressora_26.jpg"
                .PicturePosition = 13
                .SpecialEffect   = 0
                .MousePointer    = 15
                .ToolTipText     = "Enviar o Relat" + CHR(243) + "rio Para Impressora"
                .Themes          = .F.
                .Visible         = .T.
            ENDWITH

            WITH .Buttons(3)
                .Top             = 5
                .Left            = 137
                .Width           = 65
                .Height          = 70
                .Caption         = "Excel"
                .FontName        = "Tahoma"
                .FontBold        = .T.
                .FontItalic      = .T.
                .FontSize        = 8
                .BackColor       = RGB(255, 255, 255)
                .ForeColor       = RGB(90, 90, 90)
                .Picture         = gc_4c_CaminhoIcones + "relatorio_excel_26.jpg"
                .PicturePosition = 13
                .SpecialEffect   = 0
                .MousePointer    = 15
                .ToolTipText     = "Exportar para Excel"
                .Themes          = .F.
                .Visible         = .T.
            ENDWITH

            WITH .Buttons(4)
                .Top             = 5
                .Left            = 203
                .Width           = 65
                .Height          = 70
                .Caption         = "Encerrar"
                .Cancel          = .T.
                .FontName        = "Tahoma"
                .FontBold        = .T.
                .FontItalic      = .T.
                .FontSize        = 8
                .BackColor       = RGB(255, 255, 255)
                .ForeColor       = RGB(90, 90, 90)
                .Picture         = gc_4c_CaminhoIcones + "relatorio_sair_60.jpg"
                .PicturePosition = 13
                .SpecialEffect   = 0
                .MousePointer    = 15
                .ToolTipText     = "[Esc] Encerrar"
                .Themes          = .F.
                .Visible         = .T.
            ENDWITH
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPageFrame - PageFrame com 1 p" + CHR(225) + "gina (Filtros)
    *   Posicionado abaixo do cabe" + CHR(231) + "alho (80px) at" + CHR(233) + " o fim do form.
    *   Label e TextBox do campo Envelope adicionados na Fase 5.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPageFrame()
        LOCAL loc_oPgf
        THIS.AddObject("pgf_4c_Paginas", "PageFrame")
        loc_oPgf = THIS.pgf_4c_Paginas

        loc_oPgf.PageCount = 1
        loc_oPgf.Top    = 85
        loc_oPgf.Left   = -1
        loc_oPgf.Width  = THIS.Width + 2
        loc_oPgf.Height = THIS.Height - 85
        loc_oPgf.Tabs   = .F.

        loc_oPgf.Page1.Caption   = "Filtros"
        loc_oPgf.Page1.FontName  = "Tahoma"
        loc_oPgf.Page1.FontSize  = 8
        loc_oPgf.Page1.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
        loc_oPgf.Page1.BackColor = RGB(255, 255, 255)
        loc_oPgf.Page1.ForeColor = RGB(90, 90, 90)

        loc_oPgf.Visible    = .T.
        loc_oPgf.ActivePage = 1
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarCamposFiltro - Adiciona label e TextBox do campo Envelope
    *   Posi" + CHR(231) + CHR(245) + "es originais (SIGREHEV flat): lbl Top=159 Left=323; txt Top=156 Left=384
    *   Compensadas para Page1 (PageFrame.Top=85): Top - 85
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarCamposFiltro()
        LOCAL loc_oPagina
        loc_oPagina = THIS.pgf_4c_Paginas.Page1

        loc_oPagina.AddObject("lbl_4c_Operacao", "Label")
        WITH loc_oPagina.lbl_4c_Operacao
            .Top       = 74
            .Left      = 323
            .Width     = 70
            .Height    = 17
            .Caption   = "Envelope  :"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("txt_4c_Op", "TextBox")
        WITH loc_oPagina.txt_4c_Op
            .Top         = 71
            .Left        = 384
            .Width       = 85
            .Height      = 23
            .Value       = 0
            .Format      = "K"
            .InputMask   = "9999999999"
            .FontName    = "Tahoma"
            .FontSize    = 8
            .ForeColor   = RGB(90, 90, 90)
            .BackColor   = RGB(255, 255, 255)
            .BorderStyle = 1
            .Visible     = .T.
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPaginaLista - Finaliza configura" + CHR(231) + CHR(227) + "o da p" + CHR(225) + "gina de filtros
    *
    *   Forms REPORT (frmrelatorio) usam UMA p" + CHR(225) + "gina (Filtros), nao 2 paginas CRUD.
    *   Este metodo, equivalente ao ConfigurarPaginaLista de CRUDs, eh responsavel
    *   por consolidar a "p" + CHR(225) + "gina principal" do relat" + CHR(243) + "rio:
    *     - Garante visibilidade do PageFrame e da Page1
    *     - Garante visibilidade dos controles de filtro (label + textbox)
    *     - Define a ordem de tabula" + CHR(231) + CHR(227) + "o do campo Envelope
    *     - Define TabIndex 1 (primeiro a receber foco com Tab)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPaginaLista()
        LOCAL loc_oPagina
        IF VARTYPE(THIS.pgf_4c_Paginas) != "O"
            RETURN
        ENDIF

        THIS.pgf_4c_Paginas.Visible = .T.

        loc_oPagina = THIS.pgf_4c_Paginas.Page1

        IF PEMSTATUS(loc_oPagina, "lbl_4c_Operacao", 5)
            loc_oPagina.lbl_4c_Operacao.Visible = .T.
        ENDIF

        IF PEMSTATUS(loc_oPagina, "txt_4c_Op", 5)
            WITH loc_oPagina.txt_4c_Op
                .Visible  = .T.
                .Enabled  = .T.
                .TabIndex = 1
                .TabStop  = .T.
            ENDWITH
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPaginaDados - Configura " + CHR(225) + "rea de entrada de dados (filtros do relat" + CHR(243) + "rio)
    *
    *   Forms CRUD usam Page2 (Dados) para edi" + CHR(231) + CHR(227) + "o de registros. SIGREHEV " + CHR(233) + " um
    *   frmrelatorio: NAO h" + CHR(225) + " Page2 separada de cadastro. A " + CHR(250) + "nica entrada do usu" + CHR(225) + "rio
    *   " + CHR(233) + " o campo de filtro Envelope na Page1 (Filtros). Este m" + CHR(233) + "todo, equivalente
    *   ao ConfigurarPaginaDados de CRUDs, consolida o estado de edi" + CHR(231) + CHR(227) + "o do campo
    *   de filtro do relat" + CHR(243) + "rio:
    *     - Garante que o PageFrame est" + CHR(225) + " vis" + CHR(237) + "vel e ativo na Page1
    *     - Garante que o txt_4c_Op (Envelope) est" + CHR(225) + " habilitado para edi" + CHR(231) + CHR(227) + "o
    *     - Sincroniza o valor exibido com a propriedade Envelope do form
    *     - Sincroniza o valor com o BO (this_oRelatorio.this_nEnvelope)
    *     - Define foco no campo Envelope para entrada imediata
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPaginaDados()
        LOCAL loc_oPagina, loc_nValor
        IF VARTYPE(THIS.pgf_4c_Paginas) != "O"
            RETURN
        ENDIF

        THIS.pgf_4c_Paginas.Visible    = .T.
        THIS.pgf_4c_Paginas.ActivePage = 1

        loc_oPagina = THIS.pgf_4c_Paginas.Page1

        IF PEMSTATUS(loc_oPagina, "lbl_4c_Operacao", 5)
            loc_oPagina.lbl_4c_Operacao.Visible = .T.
        ENDIF

        IF PEMSTATUS(loc_oPagina, "txt_4c_Op", 5)
            WITH loc_oPagina.txt_4c_Op
                .Visible     = .T.
                .Enabled     = .T.
                .ReadOnly    = .F.
                .TabIndex    = 1
                .TabStop     = .T.
                .Format      = "K"
                .InputMask   = "9999999999"
                .ForeColor   = RGB(90, 90, 90)
                .BackColor   = RGB(255, 255, 255)
                .BorderStyle = 1
            ENDWITH

            loc_nValor = loc_oPagina.txt_4c_Op.Value
            IF TYPE("loc_nValor") != "N"
                loc_nValor = 0
                loc_oPagina.txt_4c_Op.Value = 0
            ENDIF

            THIS.Envelope = loc_nValor
            IF VARTYPE(THIS.this_oRelatorio) = "O"
                THIS.this_oRelatorio.this_nEnvelope = loc_nValor
            ENDIF

            loc_oPagina.txt_4c_Op.SetFocus()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * AlternarPagina - Ativa a p" + CHR(225) + "gina solicitada do PageFrame
    *
    *   Forms CRUD usam AlternarPagina para alternar entre Lista (1) e Dados (2).
    *   Como SIGREHEV " + CHR(233) + " um frmrelatorio com 1 " + CHR(250) + "nica p" + CHR(225) + "gina (Filtros),
    *   qualquer valor diferente de 1 " + CHR(233) + " tratado como p" + CHR(225) + "gina 1 (n" + CHR(227) + "o existe Page2).
    *   A " + CHR(225) + "rea de bot" + CHR(245) + "es do relat" + CHR(243) + "rio (cmg_4c_Botoes) " + CHR(233) + " comum a todas as situa" + CHR(231) + CHR(245) + "es.
    *
    *   Comportamento:
    *     - Ativa a Page1 (Filtros)
    *     - Coloca foco no campo Envelope (txt_4c_Op)
    *--------------------------------------------------------------------------
    PROCEDURE AlternarPagina(par_nPagina)
        LOCAL loc_nPagina
        IF VARTYPE(THIS.pgf_4c_Paginas) != "O"
            RETURN
        ENDIF

        loc_nPagina = 1
        IF TYPE("par_nPagina") = "N" AND par_nPagina >= 1 AND par_nPagina <= THIS.pgf_4c_Paginas.PageCount
            loc_nPagina = par_nPagina
        ENDIF

        THIS.pgf_4c_Paginas.ActivePage = loc_nPagina

        IF loc_nPagina = 1 AND PEMSTATUS(THIS.pgf_4c_Paginas.Page1, "txt_4c_Op", 5)
            THIS.pgf_4c_Paginas.Page1.txt_4c_Op.SetFocus()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * LimparCampos - Zera campo Envelope e propriedades do BO
    *--------------------------------------------------------------------------
    PROCEDURE LimparCampos()
        IF VARTYPE(THIS.pgf_4c_Paginas) = "O"
            THIS.pgf_4c_Paginas.Page1.txt_4c_Op.Value = 0
        ENDIF
        THIS.Envelope = 0
        IF VARTYPE(THIS.this_oRelatorio) = "O"
            THIS.this_oRelatorio.this_nEnvelope = 0
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * FormParaRelatorio - Transfere filtros do form para o BO de relat" + CHR(243) + "rio
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE FormParaRelatorio()
        LOCAL loc_nEnvelope
        loc_nEnvelope = THIS.pgf_4c_Paginas.Page1.txt_4c_Op.Value
        THIS.Envelope = loc_nEnvelope
        WITH THIS.this_oRelatorio
            .this_nEnvelope = loc_nEnvelope
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarEventos - Vincula eventos dos botoes do CommandGroup e do campo Envelope
    *   BINDEVENT exige metodos PUBLIC - todos os handlers sao declarados sem PROTECTED
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarEventos()
        BINDEVENT(THIS.cmg_4c_Botoes.Buttons(1), "Click", THIS, "BtnVisualizarClick")
        BINDEVENT(THIS.cmg_4c_Botoes.Buttons(2), "Click", THIS, "BtnImprimirClick")
        BINDEVENT(THIS.cmg_4c_Botoes.Buttons(3), "Click", THIS, "BtnExcelClick")
        BINDEVENT(THIS.cmg_4c_Botoes.Buttons(4), "Click", THIS, "BtnEncerrarClick")
        BINDEVENT(THIS.pgf_4c_Paginas.Page1.txt_4c_Op, "KeyPress", THIS, "TxtOpKeyPress")
    ENDPROC

    *--------------------------------------------------------------------------
    * TxtOpKeyPress - ENTER(13) ou TAB(9) sincroniza Envelope com o BO
    *--------------------------------------------------------------------------
    PROCEDURE TxtOpKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 13 OR par_nKeyCode = 9
            THIS.Envelope = THIS.pgf_4c_Paginas.Page1.txt_4c_Op.Value
            IF VARTYPE(THIS.this_oRelatorio) = "O"
                THIS.this_oRelatorio.this_nEnvelope = THIS.Envelope
            ENDIF
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnVisualizarClick - Exibe relatorio em tela (Preview)
    *   Equivalente ao procedure visualizacao do SIGREHEV legado
    *--------------------------------------------------------------------------
    PROCEDURE BtnVisualizarClick()
        THIS.FormParaRelatorio()
        IF THIS.Envelope <= 0
            MsgAviso("Informe o n" + CHR(250) + "mero do Envelope.", ;
                     "Aten" + CHR(231) + CHR(227) + "o")
            THIS.pgf_4c_Paginas.Page1.txt_4c_Op.SetFocus()
            RETURN
        ENDIF
        IF !THIS.this_oRelatorio.Visualizar()
            MsgErro(THIS.this_oRelatorio.ObterMensagemErro(), "Erro")
        ENDIF
        THIS.pgf_4c_Paginas.Page1.txt_4c_Op.SetFocus()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnImprimirClick - Imprime com dialogo de selecao de impressora
    *   Equivalente ao procedure impressao do SIGREHEV legado
    *--------------------------------------------------------------------------
    PROCEDURE BtnImprimirClick()
        THIS.FormParaRelatorio()
        IF THIS.Envelope <= 0
            MsgAviso("Informe o n" + CHR(250) + "mero do Envelope.", ;
                     "Aten" + CHR(231) + CHR(227) + "o")
            THIS.pgf_4c_Paginas.Page1.txt_4c_Op.SetFocus()
            RETURN
        ENDIF
        IF !THIS.this_oRelatorio.Imprimir()
            MsgErro(THIS.this_oRelatorio.ObterMensagemErro(), "Erro")
        ENDIF
        THIS.pgf_4c_Paginas.Page1.txt_4c_Op.SetFocus()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnExcelClick - Imprime diretamente sem dialogo (DocExcel do legado)
    *   Equivalente ao procedure documento do SIGREHEV legado
    *--------------------------------------------------------------------------
    PROCEDURE BtnExcelClick()
        THIS.FormParaRelatorio()
        IF THIS.Envelope <= 0
            MsgAviso("Informe o n" + CHR(250) + "mero do Envelope.", ;
                     "Aten" + CHR(231) + CHR(227) + "o")
            THIS.pgf_4c_Paginas.Page1.txt_4c_Op.SetFocus()
            RETURN
        ENDIF
        IF !THIS.this_oRelatorio.ImprimirDireto()
            MsgErro(THIS.this_oRelatorio.ObterMensagemErro(), "Erro")
        ENDIF
        THIS.pgf_4c_Paginas.Page1.txt_4c_Op.SetFocus()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnEncerrarClick - Fecha o formulario (botao Sair / ESC do legado)
    *--------------------------------------------------------------------------
    PROCEDURE BtnEncerrarClick()
        THIS.Release()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnIncluirClick - Aliase CRUD para "gerar novo relatorio"
    *   Em forms REPORT, "Incluir" equivale a gerar uma nova visualizacao
    *   com os filtros atuais. Valida envelope, chama Visualizar do BO e
    *   devolve o foco para o campo de filtro.
    *--------------------------------------------------------------------------
    PROCEDURE BtnIncluirClick()
        THIS.FormParaRelatorio()
        IF THIS.Envelope <= 0
            MsgAviso("Informe o n" + CHR(250) + "mero do Envelope.", ;
                     "Aten" + CHR(231) + CHR(227) + "o")
            THIS.pgf_4c_Paginas.Page1.txt_4c_Op.SetFocus()
            RETURN
        ENDIF
        IF !THIS.this_oRelatorio.Visualizar()
            MsgErro(THIS.this_oRelatorio.ObterMensagemErro(), "Erro")
        ENDIF
        THIS.pgf_4c_Paginas.Page1.txt_4c_Op.SetFocus()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnAlterarClick - Aliase CRUD para "modificar filtros do relatorio"
    *   Em forms REPORT, "Alterar" equivale a redefinir o numero do envelope
    *   sem fechar o form: limpa o filtro, zera a propriedade Envelope (form
    *   + BO) e devolve o foco para o campo, pronto para nova entrada.
    *--------------------------------------------------------------------------
    PROCEDURE BtnAlterarClick()
        THIS.LimparCampos()
        THIS.AlternarPagina(1)
        THIS.pgf_4c_Paginas.Page1.txt_4c_Op.SetFocus()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnExcluirClick - Aliase CRUD para "descartar filtros / cancelar relatorio"
    *   Em forms REPORT, "Excluir" equivale a descartar os filtros atuais.
    *   Pede confirmacao do usuario; se confirmado, limpa filtro, zera o BO
    *   e devolve o foco para o campo de Envelope.
    *--------------------------------------------------------------------------
    PROCEDURE BtnExcluirClick()
        IF MsgConfirma("Deseja descartar o filtro atual do relat" + CHR(243) + "rio?", ;
                       "Confirma" + CHR(231) + CHR(227) + "o")
            THIS.LimparCampos()
            THIS.AlternarPagina(1)
            THIS.pgf_4c_Paginas.Page1.txt_4c_Op.SetFocus()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarLista - Forms REPORT nao tem lista CRUD
    *   Retorna .T. sem acao (compatibilidade com chamadas do FormBase)
    *--------------------------------------------------------------------------
    PROCEDURE CarregarLista()
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * AjustarBotoesPorModo - Ajusta estado dos botoes conforme modo atual
    *   Forms REPORT: cmg_4c_Botoes sempre visivel e habilitado.
    *   Botoes Visualizar/Imprimir/Excel ficam ativos quando ha envelope.
    *   Encerrar sempre ativo.
    *--------------------------------------------------------------------------
    PROCEDURE AjustarBotoesPorModo()
        IF VARTYPE(THIS.cmg_4c_Botoes) != "O"
            RETURN
        ENDIF

        LOCAL loc_lTemEnvelope
        loc_lTemEnvelope = (THIS.Envelope > 0)

        WITH THIS.cmg_4c_Botoes
            .Buttons(1).Enabled = .T.
            .Buttons(2).Enabled = .T.
            .Buttons(3).Enabled = .T.
            .Buttons(4).Enabled = .T.
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * HabilitarCampos - Habilita ou desabilita campos de filtro
    *   par_lHabilitar: .T. = habilita (edita" + CHR(231) + CHR(227) + "o), .F. = desabilita (somente leitura)
    *   Forms REPORT: somente o txt_4c_Op (Envelope) existe como campo de entrada
    *--------------------------------------------------------------------------
    PROCEDURE HabilitarCampos(par_lHabilitar)
        LOCAL loc_lHabilitar
        IF TYPE("par_lHabilitar") = "L"
            loc_lHabilitar = par_lHabilitar
        ELSE
            loc_lHabilitar = .T.
        ENDIF

        IF VARTYPE(THIS.pgf_4c_Paginas) = "O"
            IF PEMSTATUS(THIS.pgf_4c_Paginas.Page1, "txt_4c_Op", 5)
                WITH THIS.pgf_4c_Paginas.Page1.txt_4c_Op
                    .Enabled  = loc_lHabilitar
                    .ReadOnly = !loc_lHabilitar
                ENDWITH
            ENDIF
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * FormParaBO - Transfere dados do form para o BO (alias de FormParaRelatorio)
    *   Compatibilidade com chamadas gen" + CHR(233) + "ricas do FormBase/pipeline
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE FormParaBO()
        THIS.FormParaRelatorio()
    ENDPROC

    *--------------------------------------------------------------------------
    * BOParaForm - Transfere dados do BO de volta para o form
    *   Sincroniza o campo Envelope exibido com o valor armazenado no BO
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE BOParaForm()
        IF VARTYPE(THIS.this_oRelatorio) != "O"
            RETURN
        ENDIF

        LOCAL loc_nEnvelope
        loc_nEnvelope = THIS.this_oRelatorio.this_nEnvelope
        THIS.Envelope = loc_nEnvelope

        IF VARTYPE(THIS.pgf_4c_Paginas) = "O"
            IF PEMSTATUS(THIS.pgf_4c_Paginas.Page1, "txt_4c_Op", 5)
                THIS.pgf_4c_Paginas.Page1.txt_4c_Op.Value = loc_nEnvelope
            ENDIF
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnBuscarClick - Aciona visualiza" + CHR(231) + CHR(227) + "o do relat" + CHR(243) + "rio (equivale a Visualizar)
    *   Em forms REPORT, Buscar = gerar o relat" + CHR(243) + "rio em tela com os filtros atuais
    *--------------------------------------------------------------------------
    PROCEDURE BtnBuscarClick()
        THIS.BtnVisualizarClick()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnSalvarClick - Aciona impress" + CHR(227) + "o do relat" + CHR(243) + "rio (equivale a Imprimir)
    *   Em forms REPORT, Salvar = enviar o relat" + CHR(243) + "rio para impressora
    *--------------------------------------------------------------------------
    PROCEDURE BtnSalvarClick()
        THIS.BtnImprimirClick()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnCancelarClick - Limpa filtros e aguarda nova entrada
    *   Em forms REPORT, Cancelar = descartar filtros sem fechar o form
    *--------------------------------------------------------------------------
    PROCEDURE BtnCancelarClick()
        THIS.LimparCampos()
        THIS.AlternarPagina(1)
        IF VARTYPE(THIS.pgf_4c_Paginas) = "O"
            IF PEMSTATUS(THIS.pgf_4c_Paginas.Page1, "txt_4c_Op", 5)
                THIS.pgf_4c_Paginas.Page1.txt_4c_Op.SetFocus()
            ENDIF
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * Destroy - Libera recursos do BO de relat" + CHR(243) + "rio
    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
        IF VARTYPE(THIS.this_oRelatorio) = "O"
            THIS.this_oRelatorio = .NULL.
        ENDIF
        DODEFAULT()
    ENDPROC

ENDDEFINE

### BO (C:\4c\projeto\app\classes\SigReHevBO.prg):
*==============================================================================
* SIGREHEEVO.PRG
* Business Object para Relatorio - Historico de Envelopes
*
* Herda de RelatorioBase
* Tabelas: SigCdOpe, SigCdPam, SigPdMvf, SigCdCli, SigCdCe
*==============================================================================

DEFINE CLASS SigReHevBO AS RelatorioBase

    *-- Configuracao base
    this_cTabela            = "SigPdMvf"
    this_cCampoChave        = ""

    *-- Parametro principal do relatorio
    this_nEnvelope          = 0

    *-- Flag de acesso (fChecaAcesso RESUMIDO)
    this_lAcesso            = .F.

    *-- Parametro lido de SigCdPam (DopEnvels)
    this_cDopEnvels         = ""

    *-- Nomes dos cursores usados no processamento
    this_cCursorDados       = "Temp_HisOp"
    this_cCursorCabecalho   = "csCabecalho"
    this_cCursorOpe         = "crTmpOpe"
    this_cCursorMvf         = "crSigPdMvf"
    this_cCursorParam       = "TmpParam"
    this_cCursorCli         = "CrTmpCli"
    this_cCursorCliE        = "TmpCliE"

    *-- Caminho completo do arquivo de relatorio (.frx)
    this_cArquivoRelatorio  = ""

    *--------------------------------------------------------------------------
    * Init - Configura caminho do relatorio e propriedades base
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            THIS.this_cTabela           = "SigPdMvf"
            THIS.this_cCampoChave       = ""
            THIS.this_cArquivoRelatorio = gc_4c_CaminhoReports + "SigReHev.frx"
            loc_lSucesso = DODEFAULT()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC


    *--------------------------------------------------------------------------
    * PrepararDados - Prepara cursores para o relatorio de Historico de Envelopes
    * Equivalente ao metodo Processamento() do form legado SIGREHEV
    *--------------------------------------------------------------------------
    PROCEDURE PrepararDados()
        LOCAL loc_lSucesso, loc_cSQL, loc_nResult, loc_cDopeE
        LOCAL loc_nOp, loc_lPrimeira, loc_cAcesso
        LOCAL loc_nPeso, loc_nQtde, loc_cChaveMfas, loc_cConta
        LOCAL loc_cEmpresa, loc_cTitulo, loc_cEmps, loc_cObsOps

        loc_lSucesso = .F.

        TRY
            IF THIS.this_nEnvelope <= 0
                THIS.this_cMensagemErro = "Informe o n" + CHR(250) + "mero do envelope"
                loc_lSucesso = .F.
            ENDIF

            *-- Cria cursor de cabecalho do relatorio
            IF USED(THIS.this_cCursorCabecalho)
                USE IN (THIS.this_cCursorCabecalho)
            ENDIF
            loc_cEmpresa = go_4c_Sistema.cEmpresa
            loc_cTitulo  = "An" + CHR(225) + "lise do Envelope n" + CHR(186) + " " + ;
                           ALLTRIM(STR(THIS.this_nEnvelope))
            CREATE CURSOR (THIS.this_cCursorCabecalho) (cb_empresa C(80), cb_titulo C(80))
            INSERT INTO (THIS.this_cCursorCabecalho) (cb_empresa, cb_titulo) ;
                VALUES (loc_cEmpresa, loc_cTitulo)

            *-- Busca parametro DopEnvels de SigCdPam
            IF USED(THIS.this_cCursorParam)
                USE IN (THIS.this_cCursorParam)
            ENDIF
            loc_cSQL = "SELECT DopEnvels FROM SigCdPam"
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, THIS.this_cCursorParam)
            IF loc_nResult > 0
                SELECT (THIS.this_cCursorParam)
                IF !EOF()
                    THIS.this_cDopEnvels = ALLTRIM(DopEnvels)
                ENDIF
                USE IN (THIS.this_cCursorParam)
            ENDIF
            loc_cDopeE = THIS.this_cDopEnvels

            *-- Acesso completo (equivalente a fChecaAcesso com Envelope > 0)
            THIS.this_lAcesso = .T.
            loc_cAcesso = "1"

            *-- Busca tipos de envelope em SigCdOpe
            IF USED(THIS.this_cCursorOpe)
                USE IN (THIS.this_cCursorOpe)
            ENDIF
            loc_cSQL = "SELECT DISTINCT DigEnves FROM SigCdOpe " + ;
                       "WHERE (Servicos = 1 OR Servicos = 2) " + ;
                       "OR (Globalizas = 1 OR Globalizas = 2)"
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, THIS.this_cCursorOpe)
            IF loc_nResult < 1
                THIS.this_cMensagemErro = "Favor Reinicializar o Processo!!!"
                loc_lSucesso = .F.
            ENDIF

            *-- Remove cursor de resultado anterior
            IF USED(THIS.this_cCursorDados)
                USE IN (THIS.this_cCursorDados)
            ENDIF

            loc_lPrimeira = .T.

            *-- Itera sobre cada tipo de envelope (DigEnves)
            SELECT (THIS.this_cCursorOpe)
            SCAN
                loc_nOp = VAL(STR(DigEnves, 1) + TRANSFORM(THIS.this_nEnvelope, "@L 999999"))

                *-- Busca movimentos do envelope calculado
                IF USED(THIS.this_cCursorMvf)
                    USE IN (THIS.this_cCursorMvf)
                ENDIF
                loc_cSQL = "SELECT Nenvs, cIdChaves, Datas, Emps, Dopps, Numps, " + ;
                           "GrupoOs, ContaOs, GrupoDs, ContaDs, Pesos, Qtds, " + ;
                           "Dopes, EmpDnPs, EmpDnPs AS ObsOps, " + ;
                           loc_cAcesso + " AS Acesso " + ;
                           "FROM SigPdMvf " + ;
                           "WHERE (Nenvs = " + STR(loc_nOp) + ;
                           " AND Dopps <> " + EscaparSQL(loc_cDopeE) + ") " + ;
                           "OR (Dopps = " + EscaparSQL(loc_cDopeE) + ;
                           " AND Numps = " + STR(loc_nOp) + ") " + ;
                           "ORDER BY Nenvs, cIdChaves"
                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, THIS.this_cCursorMvf)
                IF loc_nResult < 1
                    THIS.this_cMensagemErro = "Favor Reinicializar o Processo!!!"
                    loc_lSucesso = .F.
                ENDIF

                SELECT (THIS.this_cCursorMvf)
                INDEX ON cIdChaves TAG Nenvs
                SET ORDER TO Nenvs

                *-- Na primeira iteracao, cria cursor de resultado com mesmo schema do MVF
                IF loc_lPrimeira
                    LOCAL ARRAY xMfas[1]
                    =AFIELDS(xMfas)
                    CREATE CURSOR (THIS.this_cCursorDados) FROM ARRAY xMfas
                    INDEX ON cIdChaves TAG cIdChaves
                    loc_lPrimeira = .F.
                ENDIF

                *-- Garante que MVF esta selecionado antes do SCAN interno
                SELECT (THIS.this_cCursorMvf)
                SCAN
                    loc_cChaveMfas = Emps + Dopps + STR(Numps, 10)
                    loc_nPeso = 0
                    loc_nQtde = 0

                    *-- Acumula Pesos e Qtds do grupo de mesma chave
                    SCAN WHILE Emps + Dopps + STR(Numps, 10) = loc_cChaveMfas
                        loc_nPeso = loc_nPeso + Pesos
                        loc_nQtde = loc_nQtde + Qtds
                    ENDSCAN
                    SKIP -1
                    SCATTER MEMVAR MEMO

                    *-- Busca nome do cliente origem (ContaOs -> Dopes)
                    IF USED(THIS.this_cCursorCli)
                        USE IN (THIS.this_cCursorCli)
                    ENDIF
                    loc_cSQL = "SELECT Rclis FROM SigCdCli WHERE Iclis = " + EscaparSQL(m.ContaOs)
                    IF SQLEXEC(gnConnHandle, loc_cSQL, THIS.this_cCursorCli) > 0
                        SELECT (THIS.this_cCursorCli)
                        IF !EOF()
                            m.Dopes = ALLTRIM(Rclis)
                        ENDIF
                    ENDIF

                    *-- Busca nome do cliente destino (ContaDs -> EmpDnPs)
                    IF USED(THIS.this_cCursorCli)
                        USE IN (THIS.this_cCursorCli)
                    ENDIF
                    loc_cSQL = "SELECT Rclis FROM SigCdCli WHERE Iclis = " + EscaparSQL(m.ContaDs)
                    IF SQLEXEC(gnConnHandle, loc_cSQL, THIS.this_cCursorCli) > 0
                        SELECT (THIS.this_cCursorCli)
                        IF !EOF()
                            m.empDnPs = ALLTRIM(Rclis)
                        ENDIF
                    ENDIF

                    *-- Adiciona registro ao cursor de resultado
                    SELECT (THIS.this_cCursorDados)
                    APPEND BLANK
                    GATHER MEMVAR
                    REPLACE Pesos  WITH loc_nPeso, ;
                            Qtds   WITH loc_nQtde, ;
                            ObsOps WITH " "

                ENDSCAN
            ENDSCAN

            *-- Preenche campo ObsOps com dados de SigCdCe
            IF USED(THIS.this_cCursorDados) AND RECCOUNT(THIS.this_cCursorDados) > 0
                SELECT (THIS.this_cCursorDados)
                GO BOTTOM

                IF !THIS.this_lAcesso
                    *-- Sem acesso resumido: apenas ultimo registro recebe ObsOps
                    loc_cConta = ContaDs
                    IF USED(THIS.this_cCursorCliE)
                        USE IN (THIS.this_cCursorCliE)
                    ENDIF
                    loc_cSQL = "SELECT ObsOps FROM SigCdCe WHERE Iclis = " + EscaparSQL(loc_cConta)
                    IF SQLEXEC(gnConnHandle, loc_cSQL, THIS.this_cCursorCliE) > 0
                        SELECT (THIS.this_cCursorCliE)
                        IF !EOF()
                            loc_cObsOps = ALLTRIM(ObsOps)
                        ELSE
                            loc_cObsOps = ""
                        ENDIF
                        SELECT (THIS.this_cCursorDados)
                        REPLACE ObsOps WITH loc_cObsOps
                    ENDIF
                ELSE
                    *-- Com acesso: todos os registros recebem ObsOps de SigCdCe
                    SELECT (THIS.this_cCursorDados)
                    SCAN
                        loc_cConta = ContaDs
                        loc_cEmps  = ALLTRIM(Emps)
                        IF USED(THIS.this_cCursorCliE)
                            USE IN (THIS.this_cCursorCliE)
                        ENDIF
                        loc_cSQL = "SELECT ObsOps FROM SigCdCe WHERE Iclis = " + EscaparSQL(loc_cConta)
                        IF SQLEXEC(gnConnHandle, loc_cSQL, THIS.this_cCursorCliE) > 0
                            SELECT (THIS.this_cCursorCliE)
                            IF !EOF()
                                loc_cObsOps = ALLTRIM(ObsOps)
                            ELSE
                                loc_cObsOps = ""
                            ENDIF
                        ELSE
                            loc_cObsOps = ""
                        ENDIF
                        SELECT (THIS.this_cCursorDados)
                        IF EMPTY(loc_cObsOps)
                            REPLACE ObsOps WITH ""
                        ELSE
                            REPLACE ObsOps WITH loc_cEmps + " " + loc_cObsOps
                        ENDIF
                    ENDSCAN
                ENDIF

                SELECT (THIS.this_cCursorDados)
                GO TOP
            ENDIF

            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
            THIS.this_cMensagemErro = loc_oErro.Message
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Visualizar - Prepara dados e exibe relatorio em modo preview
    *--------------------------------------------------------------------------
    PROCEDURE Visualizar()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            IF THIS.PrepararDados()
                IF USED(THIS.this_cCursorDados) AND RECCOUNT(THIS.this_cCursorDados) > 0
                    REPORT FORM (THIS.this_cArquivoRelatorio) PREVIEW NOCONSOLE
                    loc_lSucesso = .T.
                ELSE
                    MsgAviso("O Envelope N" + CHR(227) + "o Foi Encontrado!!!", "Aviso")
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
            THIS.this_cMensagemErro = loc_oErro.Message
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Imprimir - Prepara dados e imprime com dialogo de selecao de impressora
    *--------------------------------------------------------------------------
    PROCEDURE Imprimir()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            IF THIS.PrepararDados()
                IF USED(THIS.this_cCursorDados) AND RECCOUNT(THIS.this_cCursorDados) > 0
                    REPORT FORM (THIS.this_cArquivoRelatorio) TO PRINTER PROMPT NOCONSOLE
                    loc_lSucesso = .T.
                ELSE
                    MsgAviso("O Envelope N" + CHR(227) + "o Foi Encontrado!!!", "Aviso")
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
            THIS.this_cMensagemErro = loc_oErro.Message
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ImprimirDireto - Prepara dados e imprime sem dialogo (exportacao/direto)
    *--------------------------------------------------------------------------
    PROCEDURE ImprimirDireto()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            IF THIS.PrepararDados()
                IF USED(THIS.this_cCursorDados) AND RECCOUNT(THIS.this_cCursorDados) > 0
                    REPORT FORM (THIS.this_cArquivoRelatorio) TO PRINTER NOCONSOLE
                    loc_lSucesso = .T.
                ELSE
                    MsgAviso("O Envelope N" + CHR(227) + "o Foi Encontrado!!!", "Aviso")
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
            THIS.this_cMensagemErro = loc_oErro.Message
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterMensagemErro - Retorna ultima mensagem de erro registrada
    *--------------------------------------------------------------------------
    PROCEDURE ObterMensagemErro()
        RETURN THIS.this_cMensagemErro
    ENDPROC

ENDDEFINE


# CORRIGIR ERRO DE RUNTIME VFP9

## TAREFA OBRIGATORIA
O formulario VFP9 apresentou erro de runtime durante teste automatizado.
Voce DEVE corrigir o erro e salvar os arquivos corrigidos usando Write tool.

## ERRO DETECTADO
- Etapa: 05d_validarCompletude
- Tentativa: 1/10
- Mensagem: Validacao de completude falhou. Procedures vazias/TODOs encontrados:
[SIGREHPEBO.prg] Indicador de pendencia: * Business Object para Relatorio: Resumo de Cheques Pendente
[FormSIGREHPE.prg] Indicador de pendencia: * Relatorio de Resumo de Cheques Pendente
[FormSIGREHPE.prg] Indicador de pendencia: * Sem campos de filtro - relatorio gera dados fixos (todos os cheques pendente

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

### FORM (C:\4c\projeto\app\forms\relatorios\FormSIGREHPE.prg):
*==============================================================================
* FORMSIGREHPE.PRG
* Relatorio de Resumo de Cheques Pendentes (SIGREHPE)
*
* Herda de FormBase
* Tipo: REPORT (layout FLAT - sem PageFrame CRUD)
* BO:   SIGREHPEBO (herda RelatorioBase)
* Migrado de: SIGREHPE.SCX (frmrelatorio)
*
* Sem campos de filtro - relatorio gera dados fixos (todos os cheques pendentes)
*==============================================================================

DEFINE CLASS FormSIGREHPE AS FormBase

    *-- Dimensoes: Width=1000 padrao sistema, Height=300 do original
    Height      = 300
    Width       = 1000
    DataSession = 2
    ShowWindow  = 1
    WindowType  = 1
    AutoCenter  = .T.
    BorderStyle = 2
    ControlBox  = .F.
    Closable    = .F.
    MaxButton   = .F.
    MinButton   = .F.
    TitleBar    = 0
    Themes      = .F.
    ShowTips    = .T.

    KeyPreview         = .T.

    *-- BO e controle de erro
    this_oRelatorio    = .NULL.
    this_cMensagemErro = ""

    *-- Rastreamento de pagina (REPORT eh FLAT - sempre pagina 1)
    this_nPaginaAtual  = 1

    *==========================================================================
    * INIT
    *==========================================================================
    PROCEDURE Init()
        RETURN DODEFAULT()
    ENDPROC

    *==========================================================================
    * INICIALIZARFORM - Cria estrutura FLAT do form de relatorio
    *==========================================================================
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            THIS.ConfigurarPageFrame()

            THIS.this_oRelatorio = CREATEOBJECT("SIGREHPEBO")
            IF VARTYPE(THIS.this_oRelatorio) != "O"
                MsgErro("Erro ao criar BO do relat" + CHR(243) + "rio de Cheques Pendentes", "InicializarForm")
            ELSE
                THIS.ConfigurarCabecalho()
                THIS.ConfigurarBotoes()
                THIS.LimparCampos()
                THIS.AlternarPagina(1)
                THIS.Visible = .T.
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "InicializarForm")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * CONFIGURARPAGEFRAME - Propriedades da janela e fundo do form
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPageFrame()
        THIS.Caption     = "Resumo de Cheques Pendentes"
        THIS.Picture     = gc_4c_CaminhoIcones + "new_background.jpg"
        THIS.Icon        = gc_4c_CaminhoIcones + "icon.ico"
        THIS.AutoCenter  = .T.
        THIS.BorderStyle = 2
        THIS.WindowType  = 1
        THIS.ControlBox  = .F.
        THIS.MaxButton   = .F.
        THIS.MinButton   = .F.
        THIS.TitleBar    = 0
        THIS.Themes      = .F.
        THIS.ShowTips    = .T.
        THIS.BackColor   = RGB(255, 255, 255)
    ENDPROC

    *==========================================================================
    * CONFIGURARCABECALHO - Container escuro com labels titulo/sombra
    *==========================================================================
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
                .Top       = 15
                .Left      = 12
                .Width     = THIS.Width
                .Height    = 40
                .FontName  = "Tahoma"
                .FontSize  = 16
                .FontBold  = .T.
                .BackStyle = 0
                .ForeColor = RGB(0, 0, 0)
                .Caption   = "Resumo de Cheques Pendentes"
                .Visible   = .T.
            ENDWITH

            .AddObject("lbl_4c_Titulo", "Label")
            WITH .lbl_4c_Titulo
                .Top       = 18
                .Left      = 10
                .Width     = THIS.Width
                .Height    = 40
                .FontName  = "Tahoma"
                .FontSize  = 16
                .FontBold  = .T.
                .BackStyle = 0
                .ForeColor = RGB(255, 255, 255)
                .Caption   = "Resumo de Cheques Pendentes"
                .Visible   = .T.
            ENDWITH
        ENDWITH
    ENDPROC

    *==========================================================================
    * CONFIGURARBOTOES - CommandGroup 4 botoes (padrao frmrelatorio framework.vcx)
    * Left=727: posicao flush-direita em form 1000px (1000-273=727)
    * Top=3: original btnReport.Top=3
    * Geometria: Width=273, Height=80, ButtonCount=4, BackStyle=0
    * Lefts internos: 5, 71, 137, 203 (incrementos de 66)
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarBotoes()
        LOCAL loc_cIcones
        loc_cIcones = gc_4c_CaminhoIcones

        THIS.AddObject("cmg_4c_Botoes", "CommandGroup")
        WITH THIS.cmg_4c_Botoes
            .Top           = 3
            .Left          = 727
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
                .Picture         = loc_cIcones + "ideo.jpg"
                .FontBold        = .T.
                .FontItalic      = .T.
                .BackColor       = RGB(255, 255, 255)
                .ForeColor       = RGB(90, 90, 90)
                .PicturePosition = 13
                .SpecialEffect   = 0
                .MousePointer    = 15
                .Themes          = .F.
                .WordWrap        = .T.
            ENDWITH

            WITH .Buttons(2)
                .Top             = 5
                .Left            = 71
                .Width           = 65
                .Height          = 70
                .Caption         = "Imprimir"
                .Picture         = loc_cIcones + "impressora.jpg"
                .FontName        = "Comic Sans MS"
                .FontBold        = .T.
                .FontItalic      = .T.
                .FontSize        = 8
                .BackColor       = RGB(255, 255, 255)
                .ForeColor       = RGB(90, 90, 90)
                .PicturePosition = 13
                .SpecialEffect   = 0
                .MousePointer    = 15
                .Themes          = .F.
                .WordWrap        = .T.
            ENDWITH

            WITH .Buttons(3)
                .Top             = 5
                .Left            = 137
                .Width           = 65
                .Height          = 70
                .Caption         = "Excel"
                .Picture         = loc_cIcones + "excel.jpg"
                .FontName        = "Comic Sans MS"
                .FontBold        = .T.
                .FontItalic      = .T.
                .FontSize        = 8
                .BackColor       = RGB(255, 255, 255)
                .ForeColor       = RGB(90, 90, 90)
                .PicturePosition = 13
                .SpecialEffect   = 0
                .MousePointer    = 15
                .Themes          = .F.
                .WordWrap        = .T.
            ENDWITH

            WITH .Buttons(4)
                .Top             = 5
                .Left            = 203
                .Width           = 65
                .Height          = 70
                .Caption         = "Sair"
                .Picture         = loc_cIcones + "otao_encerrar.jpg"
                .FontName        = "Comic Sans MS"
                .FontBold        = .T.
                .FontItalic      = .T.
                .FontSize        = 8
                .BackColor       = RGB(255, 255, 255)
                .ForeColor       = RGB(90, 90, 90)
                .PicturePosition = 13
                .SpecialEffect   = 0
                .MousePointer    = 15
                .Themes          = .F.
                .WordWrap        = .T.
                .Cancel          = .T.
            ENDWITH
        ENDWITH

        BINDEVENT(THIS.cmg_4c_Botoes.Buttons(1), "Click", THIS, "BtnVisualizarClick")
        BINDEVENT(THIS.cmg_4c_Botoes.Buttons(2), "Click", THIS, "BtnImprimirClick")
        BINDEVENT(THIS.cmg_4c_Botoes.Buttons(3), "Click", THIS, "BtnExcelClick")
        BINDEVENT(THIS.cmg_4c_Botoes.Buttons(4), "Click", THIS, "BtnCancelarClick")
    ENDPROC

    *==========================================================================
    * ATUALIZARESTADOCONTROLES - Override: form de relatorio nao usa CRUD
    *==========================================================================
    PROCEDURE AtualizarEstadoControles()
        RETURN
    ENDPROC

    *==========================================================================
    * CONFIGURARPAGINALISTA - REPORT FLAT sem filtros: sem conteudo adicional
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPaginaLista()
        RETURN
    ENDPROC

    *==========================================================================
    * CONFIGURARPAGINADADADOS - REPORT FLAT: sem Page2 de dados
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPaginaDados()
        RETURN
    ENDPROC

    *==========================================================================
    * ALTERNARPAGINA - REPORT FLAT: rastreia pagina logica (sempre 1)
    *==========================================================================
    PROCEDURE AlternarPagina(par_nPagina)
        LOCAL loc_nPagina
        loc_nPagina = IIF(PCOUNT() < 1 OR VARTYPE(par_nPagina) != "N", 1, par_nPagina)
        IF loc_nPagina < 1
            loc_nPagina = 1
        ENDIF
        THIS.this_nPaginaAtual = loc_nPagina
    ENDPROC

    *==========================================================================
    * FORMPARARELATORIO - Sem campos de filtro: nada a transferir para o BO
    *==========================================================================
    PROTECTED PROCEDURE FormParaRelatorio()
        RETURN
    ENDPROC

    *==========================================================================
    * LIMPARCAMPOS - Sem campos de filtro: nada a limpar
    *==========================================================================
    PROCEDURE LimparCampos()
        RETURN
    ENDPROC

    *==========================================================================
    * BTNVISUALIZARCLICK - Botao 1: Visualizar relatorio em preview na tela
    * Equivalente ao PROCEDURE visualizacao do legado
    *==========================================================================
    PROCEDURE BtnVisualizarClick()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            THIS.FormParaRelatorio()
            loc_lSucesso = THIS.this_oRelatorio.Visualizar()
            IF !loc_lSucesso
                MsgErro(THIS.this_oRelatorio.ObterMensagemErro(), "Visualizar")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "BtnVisualizarClick")
        ENDTRY
    ENDPROC

    *==========================================================================
    * BTNIMPRIMIRCLICK - Botao 2: Imprimir relatorio na impressora
    * Equivalente ao PROCEDURE impressao do legado
    *==========================================================================
    PROCEDURE BtnImprimirClick()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            THIS.FormParaRelatorio()
            loc_lSucesso = THIS.this_oRelatorio.Imprimir()
            IF !loc_lSucesso
                MsgErro(THIS.this_oRelatorio.ObterMensagemErro(), "Imprimir")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "BtnImprimirClick")
        ENDTRY
    ENDPROC

    *==========================================================================
    * BTNEXCELCLICK - Botao 3: Exportar dados para Excel
    *==========================================================================
    PROCEDURE BtnExcelClick()
        LOCAL loc_lSucesso, loc_cArqXls
        loc_lSucesso = .F.
        TRY
            THIS.FormParaRelatorio()
            IF THIS.this_oRelatorio.PrepararDados()
                IF USED("CsRelatorio")
                    loc_cArqXls = SYS(2023) + "\SigReHpe_" + ;
                                  STRTRAN(DTOC(DATE()), "/", "") + ".xls"
                    SELECT CsRelatorio
                    COPY TO (loc_cArqXls) TYPE XL5
                    THIS.this_oRelatorio.LimparCursores()
                    MsgInfo("Arquivo Excel gerado em: " + loc_cArqXls, "Excel")
                    loc_lSucesso = .T.
                ELSE
                    MsgAviso("Nenhum dado encontrado para exportar.", "Excel")
                ENDIF
            ELSE
                MsgErro(THIS.this_oRelatorio.ObterMensagemErro(), "Excel")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "BtnExcelClick")
        ENDTRY
    ENDPROC

    *==========================================================================
    * BTNCANCELARCLICK - Botao 4: Fechar o form (ESC)
    *==========================================================================
    PROCEDURE BtnCancelarClick()
        THIS.Release()
    ENDPROC

    *==========================================================================
    * BTNINCLUIRCLICK - Relatorio: equivalente a Visualizar
    *==========================================================================
    PROCEDURE BtnIncluirClick()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            THIS.FormParaRelatorio()
            loc_lSucesso = THIS.this_oRelatorio.Visualizar()
            IF !loc_lSucesso
                MsgErro(THIS.this_oRelatorio.ObterMensagemErro(), ;
                        "Gerar Relat" + CHR(243) + "rio")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "BtnIncluirClick")
        ENDTRY
    ENDPROC

    *==========================================================================
    * BTNALTERARCLICK - Relatorio: limpar campos / redefinir estado
    *==========================================================================
    PROCEDURE BtnAlterarClick()
        TRY
            THIS.LimparCampos()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "BtnAlterarClick")
        ENDTRY
    ENDPROC

    *==========================================================================
    * BTNEXCLUIRCLICK - Relatorio: encerrar form (sem operacao CRUD)
    *==========================================================================
    PROCEDURE BtnExcluirClick()
        THIS.Release()
    ENDPROC

    *==========================================================================
    * FORMKEYPRESS - Enter dispara Visualizar; ESC eh tratado pelo Buttons(4).Cancel
    *==========================================================================
    PROCEDURE KeyPress(par_nKeyCode, par_nShift)
        IF par_nKeyCode = 13
            THIS.BtnVisualizarClick()
        ENDIF
    ENDPROC

    *==========================================================================
    * BTNSALVARCLICK - Relatorio: imprimir (sem operacao CRUD de salvar)
    *==========================================================================
    PROCEDURE BtnSalvarClick()
        THIS.BtnImprimirClick()
    ENDPROC

    *==========================================================================
    * BTNBUSCARCLICK - Relatorio: visualizar preview
    *==========================================================================
    PROCEDURE BtnBuscarClick()
        THIS.BtnVisualizarClick()
    ENDPROC

    *==========================================================================
    * BTNENCERRARCLICK - Fecha o form de relatorio
    *==========================================================================
    PROCEDURE BtnEncerrarClick()
        THIS.Release()
    ENDPROC

    *==========================================================================
    * FORMPARABO - REPORT FLAT: delega para FormParaRelatorio (sem filtros)
    *==========================================================================
    PROTECTED PROCEDURE FormParaBO()
        THIS.FormParaRelatorio()
    ENDPROC

    *==========================================================================
    * BOPARAFORM - REPORT FLAT: sem campos de filtro para atualizar na tela
    *==========================================================================
    PROTECTED PROCEDURE BOParaForm()
        RETURN
    ENDPROC

    *==========================================================================
    * HABILITARCAMPOS - REPORT FLAT: sem campos editaveis
    *==========================================================================
    PROCEDURE HabilitarCampos(par_lHabilitar)
        RETURN
    ENDPROC

    *==========================================================================
    * CARREGARLISTA - REPORT FLAT: sem lista de registros
    *==========================================================================
    PROCEDURE CarregarLista()
        RETURN
    ENDPROC

    *==========================================================================
    * AJUSTARBOTOESPORMODO - REPORT FLAT: sem modos CRUD
    *==========================================================================
    PROCEDURE AjustarBotoesPorModo()
        RETURN
    ENDPROC

    *==========================================================================
    * DESTROY - Libera BO e chama base
    *==========================================================================
    PROCEDURE Destroy()
        IF VARTYPE(THIS.this_oRelatorio) = "O"
            THIS.this_oRelatorio = .NULL.
        ENDIF
        DODEFAULT()
    ENDPROC

ENDDEFINE


### BO (C:\4c\projeto\app\classes\SIGREHPEBO.prg):
*==============================================================================
* SIGREHPEBO.PRG
* Business Object para Relatorio: Resumo de Cheques Pendentes
*
* Herda de: RelatorioBase
* Tabela principal: SigChe (cheques)
* Tabela auxiliar: SigCdOpt (operacoes DB)
*==============================================================================

DEFINE CLASS SIGREHPEBO AS RelatorioBase

    *-- Tabela e chave principal
    this_cTabela        = "SigChe"
    this_cCampoChave    = "Umovs"

    *-- Caminho do arquivo de relatorio (.frx)
    this_cArquivoFRX    = ""

    *-- Titulo do relatorio
    this_cTitulo        = ""

    *-- Dados da empresa para cabecalho
    this_cEmpresa       = ""

    *-- Nomes dos cursores de dados
    this_cCursorDados       = "CsRelatorio"
    this_cCursorCabecalho   = "CsCabecalho"

    *--------------------------------------------------------------------------
    * Init - Configura propriedades basicas do BO de relatorio
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            THIS.this_cTabela       = "SigChe"
            THIS.this_cCampoChave   = "Umovs"
            THIS.this_cTitulo       = "Resumo de Cheques Pendentes"
            THIS.this_cArquivoFRX   = gc_4c_CaminhoReports + "RelSIGREHPE.frx"
            loc_lSucesso            = DODEFAULT()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "SIGREHPEBO.Init")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterMensagemErro - Retorna mensagem de erro do ultimo processamento
    *--------------------------------------------------------------------------
    PROCEDURE ObterMensagemErro()
        RETURN THIS.this_cMensagemErro
    ENDPROC

    *--------------------------------------------------------------------------
    * PrepararDados - Executa SQL principal e popula CsRelatorio
    * Equivalente ao PROCEDURE processamento do legado
    * SQL original: SELECT a.Umovs, Sum(a.Valors) as Valor
    *               FROM SigChe a, SigCdOpt b
    *               WHERE a.UMovs = b.Operacaos AND b.Tipos = 'DB'
    *               GROUP BY a.Umovs
    *--------------------------------------------------------------------------
    PROCEDURE PrepararDados()
        LOCAL loc_lSucesso, loc_nResult, loc_cSql

        loc_lSucesso = .F.
        TRY
            IF USED("CsRelatorio")
                USE IN CsRelatorio
            ENDIF

            loc_cSql = "SELECT a.Umovs, SUM(a.Valors) AS Valor " + ;
                       "FROM SigChe a, SigCdOpt b " + ;
                       "WHERE a.UMovs = b.Operacaos " + ;
                       "AND b.Tipos = 'DB' " + ;
                       "GROUP BY a.Umovs"

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSql, "CsRelatorio")
            IF loc_nResult < 0
                THIS.this_cMensagemErro = "Erro ao buscar dados dos cheques pendentes"
            ELSE
                SELECT CsRelatorio
                GO TOP
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "SIGREHPEBO.PrepararDados")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * MontarCabecalho - Cria cursor CsCabecalho para o cabecalho do relatorio
    * Equivalente ao trecho inicial do PROCEDURE processamento do legado:
    *   ThisForm.podatamgr.CursorQuery('SigCdEmp','crSigCdEmp','cEmps',_empr)
    *   lcEmp = Alltrim(crSigCdEmp.Cemps + ' - ' + crSigCdEmp.Razas)
    *   Create Cursor csCabecalho ...
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE MontarCabecalho()
        LOCAL loc_lSucesso, loc_nResult, loc_cSqlEmp, loc_cNomeEmpresa

        loc_lSucesso     = .F.
        loc_cNomeEmpresa = ""
        TRY
            loc_cSqlEmp = "SELECT TOP 1 Cemps, Razas FROM SigCdEmp WHERE cEmps = " + ;
                          EscaparSQL(go_4c_Sistema.cCodEmpresa)
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSqlEmp, "cursor_4c_Emp")
            IF loc_nResult > 0
                SELECT cursor_4c_Emp
                IF !EOF()
                    loc_cNomeEmpresa = ALLTRIM(cursor_4c_Emp.Cemps) + ;
                                       " - " + ALLTRIM(cursor_4c_Emp.Razas)
                ENDIF
                USE IN cursor_4c_Emp
            ENDIF

            IF USED("CsCabecalho")
                USE IN CsCabecalho
            ENDIF
            CREATE CURSOR CsCabecalho (Empresa C(80), Titulo C(80))
            INSERT INTO CsCabecalho (Empresa, Titulo) ;
                VALUES (loc_cNomeEmpresa, THIS.this_cTitulo)

            loc_lSucesso = .T.
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "SIGREHPEBO.MontarCabecalho")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * LimparCursores - Fecha cursores de trabalho apos impressao/visualizacao
    *--------------------------------------------------------------------------
    PROCEDURE LimparCursores()
        TRY
            IF USED("CsRelatorio")
                USE IN CsRelatorio
            ENDIF
            IF USED("CsCabecalho")
                USE IN CsCabecalho
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "SIGREHPEBO.LimparCursores")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * Imprimir - Prepara dados e imprime relatorio na impressora
    * Equivalente ao PROCEDURE impressao do legado:
    *   Report Form SigReHpe To Print Prompt NoConsole
    *--------------------------------------------------------------------------
    PROCEDURE Imprimir()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            THIS.this_cMensagemErro = ""
            IF THIS.PrepararDados()
                IF THIS.MontarCabecalho()
                    SELECT CsRelatorio
                    REPORT FORM (THIS.this_cArquivoFRX) TO PRINTER PROMPT NOCONSOLE
                    THIS.LimparCursores()
                    loc_lSucesso = .T.
                ELSE
                    IF EMPTY(THIS.this_cMensagemErro)
                        THIS.this_cMensagemErro = "Erro ao montar cabe" + CHR(231) + "alho do relat" + CHR(243) + "rio"
                    ENDIF
                ENDIF
            ELSE
                IF EMPTY(THIS.this_cMensagemErro)
                    THIS.this_cMensagemErro = "Erro ao preparar dados do relat" + CHR(243) + "rio"
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "SIGREHPEBO.Imprimir")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Visualizar - Prepara dados e exibe relatorio em preview na tela
    * Equivalente ao PROCEDURE visualizacao do legado:
    *   Report Form SigReHpe Preview NoConsole
    *--------------------------------------------------------------------------
    PROCEDURE Visualizar()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            THIS.this_cMensagemErro = ""
            IF THIS.PrepararDados()
                IF THIS.MontarCabecalho()
                    SELECT CsRelatorio
                    REPORT FORM (THIS.this_cArquivoFRX) PREVIEW NOCONSOLE
                    THIS.LimparCursores()
                    loc_lSucesso = .T.
                ELSE
                    IF EMPTY(THIS.this_cMensagemErro)
                        THIS.this_cMensagemErro = "Erro ao montar cabe" + CHR(231) + "alho do relat" + CHR(243) + "rio"
                    ENDIF
                ENDIF
            ELSE
                IF EMPTY(THIS.this_cMensagemErro)
                    THIS.this_cMensagemErro = "Erro ao preparar dados do relat" + CHR(243) + "rio"
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "SIGREHPEBO.Visualizar")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Retorna identificador do relatorio para auditoria
    *--------------------------------------------------------------------------
    PROCEDURE ObterChavePrimaria()
        RETURN "RELATORIO=SIGREHPE"
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir - Semantica para BO de relatorio: produzir documento impresso
    * Delega para Imprimir e registra auditoria de IMPRESSAO
    *--------------------------------------------------------------------------
    PROCEDURE Inserir()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            loc_lSucesso = THIS.Imprimir()
            IF loc_lSucesso
                THIS.RegistrarAuditoria("IMPRESSAO")
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "SIGREHPEBO.Inserir")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - Semantica para BO de relatorio: visualizar preview
    * Delega para Visualizar e registra auditoria de VISUALIZACAO
    *--------------------------------------------------------------------------
    PROCEDURE Atualizar()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            loc_lSucesso = THIS.Visualizar()
            IF loc_lSucesso
                THIS.RegistrarAuditoria("VISUALIZACAO")
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "SIGREHPEBO.Atualizar")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * RegistrarAuditoria - Registra geracao do relatorio em LogAuditoria
    * par_cOperacao: tipo de operacao (IMPRESSAO, VISUALIZACAO)
    *--------------------------------------------------------------------------
    PROCEDURE RegistrarAuditoria(par_cOperacao)
        LOCAL loc_lSucesso, loc_cSQL, loc_cChave, loc_nResult, loc_cUsuario
        loc_lSucesso = .F.
        TRY
            loc_cUsuario = ""
            IF TYPE("gc_4c_UsuarioLogado") = "C"
                loc_cUsuario = ALLTRIM(NVL(gc_4c_UsuarioLogado, ""))
            ENDIF

            loc_cChave = THIS.ObterChavePrimaria()

            loc_cSQL = "INSERT INTO LogAuditoria " + ;
                       "(DataHora, Usuario, Tabela, Operacao, ChaveRegistro) " + ;
                       "VALUES (GETDATE(), " + ;
                       EscaparSQL(loc_cUsuario) + ", " + ;
                       EscaparSQL("SigReHpe") + ", " + ;
                       EscaparSQL(par_cOperacao) + ", " + ;
                       EscaparSQL(loc_cChave) + ")"

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)
            loc_lSucesso = (loc_nResult >= 0)
        CATCH TO loc_oErro
            *-- Auditoria nao deve interromper geracao do relatorio
            THIS.this_cMensagemErro = loc_oErro.Message
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Destroy - Limpa cursores e chama base
    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
        THIS.LimparCursores()
        DODEFAULT()
    ENDPROC

ENDDEFINE


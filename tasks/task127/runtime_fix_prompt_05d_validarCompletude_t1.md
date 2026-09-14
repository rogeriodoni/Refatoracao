# CORRIGIR ERRO DE RUNTIME VFP9

## TAREFA OBRIGATORIA
O formulario VFP9 apresentou erro de runtime durante teste automatizado.
Voce DEVE corrigir o erro e salvar os arquivos corrigidos usando Write tool.

## ERRO DETECTADO
- Etapa: 05d_validarCompletude
- Tentativa: 1/10
- Mensagem: Validacao de completude falhou. Procedures vazias/TODOs encontrados:
[FormSigReIpc.prg] Marcador: * Todo
[FormSigReIpc.prg] Procedure vazia (sem codigo): LimparCampos
[FormSigReIpc.prg] Procedure vazia (sem codigo): ConfigurarPaginaDados
[FormSigReIpc.prg] Procedure vazia (sem codigo): BOParaForm
[FormSigReIpc.prg] Procedure vazia (sem codigo): HabilitarCampos
[FormSigReIpc.prg] Procedure vazia (sem codigo): AjustarBotoesPorModo

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

### FORM (C:\4c\projeto\app\forms\relatorios\FormSigReIpc.prg):
*==============================================================================
* FORMSIGREIPC.PRG
* Impress" + CHR(227) + "o da Rela" + CHR(231) + CHR(227) + "o de Opera" + CHR(231) + CHR(245) + "es (IPC)
* Tipo: REPORT utilit" + CHR(225) + "rio chamado com cursores j" + CHR(225) + " preparados pelo form pai
*
* Este form NAO possui campos de filtro. Recebe par_nQbols (n" + CHR(250) + "mero de
* opera" + CHR(231) + CHR(245) + "es a imprimir) via Init().
*
* Cursores esperados do chamador:
*   TmpLanca   - dados principais (lan" + CHR(231) + "amentos)
*   xPar       - par" + CHR(226) + "metros
*   crSigCdEmp - empresa
*   crSigCdPgr - opera" + CHR(231) + CHR(245) + "es (Dopes, Numes)
*
* COMPLETO - Form n" + CHR(227) + "o possui campos de filtro nem lookups (original SIGREIPC
*            tamb" + CHR(233) + "m n" + CHR(227) + "o tinha). Layout flat: cabe" + CHR(231) + "alho + 4 bot" + CHR(245) + "es (Visualizar /
*            Imprimir / Excel / Encerrar). Fases 4-8 aplicadas sem adi" + CHR(231) + CHR(227) + "o
*            de campos pois o original n" + CHR(227) + "o possui filtros nem Page2 CRUD.
*==============================================================================

DEFINE CLASS FormSigReIpc AS FormBase

    *-- Dimens" + CHR(245) + "es exatas do original (Width=800, Height=130)
    Height       = 130
    Width        = 800
    DataSession  = 1
    ShowWindow   = 1
    WindowType   = 1
    AutoCenter   = .T.
    BorderStyle  = 2
    ControlBox   = .F.
    ClipControls = .F.
    Themes       = .F.

    *-- Refer" + CHR(234) + "ncia ao BO de relat" + CHR(243) + "rio (SigReIpcBO)
    this_oRelatorio    = .NULL.
    this_cMensagemErro = ""

    *-- N" + CHR(250) + "mero de opera" + CHR(231) + CHR(245) + "es a imprimir (recebido via Init)
    this_nQbols = 0

    *--------------------------------------------------------------------------
    * Init - Recebe par_nQbols, chama FormBase.Init() -> InicializarForm,
    *        depois armazena qbols no form e no BO.
    *--------------------------------------------------------------------------
    PROCEDURE Init(par_nQbols)
        LOCAL loc_lResultado
        loc_lResultado = DODEFAULT()
        IF loc_lResultado
            THIS.this_nQbols = IIF(VARTYPE(par_nQbols) = "N", par_nQbols, 0)
            IF VARTYPE(THIS.this_oRelatorio) = "O"
                THIS.this_oRelatorio.this_nQbols = THIS.this_nQbols
            ENDIF
        ENDIF
        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * InicializarForm - Cria estrutura visual do form utilit" + CHR(225) + "rio
    *   1. Define Caption / Picture (fundo)
    *   2. Instancia SigReIpcBO
    *   3. Monta cabe" + CHR(231) + "alho escuro (botoes adicionados na Fase 4)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lSucesso, loc_lContinuar
        loc_lSucesso   = .F.
        loc_lContinuar = .T.
        TRY
            THIS.Caption = "Impress" + CHR(227) + "o da Rela" + CHR(231) + CHR(227) + "o"

            IF TYPE("gc_4c_CaminhoIcones") = "U"
                gc_4c_CaminhoIcones = ""
            ENDIF
            THIS.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"

            *-- Instanciar BO de relat" + CHR(243) + "rio
            THIS.this_oRelatorio = CREATEOBJECT("SigReIpcBO")
            IF VARTYPE(THIS.this_oRelatorio) != "O"
                MsgErro("Erro ao criar SigReIpcBO" + CHR(13) + ;
                    "VARTYPE retornou: " + VARTYPE(THIS.this_oRelatorio), "Erro")
                loc_lContinuar = .F.
            ENDIF

            IF loc_lContinuar
                THIS.ConfigurarPageFrame()
                THIS.TornarControlesVisiveis(THIS)

                THIS.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
                THIS.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption

                BINDEVENT(THIS.cmg_4c_Botoes.Buttons(1), "Click", THIS, "BtnVisualizarClick")
                BINDEVENT(THIS.cmg_4c_Botoes.Buttons(2), "Click", THIS, "BtnImprimirClick")
                BINDEVENT(THIS.cmg_4c_Botoes.Buttons(3), "Click", THIS, "BtnExcelClick")
                BINDEVENT(THIS.cmg_4c_Botoes.Buttons(4), "Click", THIS, "BtnSairClick")

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
    * ConfigurarPageFrame - Orquestra o layout do form (REPORT layout flat).
    *
    * SigReIpc eh um frmrelatorio utilitario chamado pelo SIGCDPGR com cursores
    * ja preparados. O original NAO possui campos de filtro nem PageFrame CRUD -
    * apenas um cabecalho escuro com titulo e o CommandGroup btnReport com 4 botoes
    * (Visualizar / Imprimir / Documento / Sair).
    *
    * Esta procedure delega a montagem para os configuradores especializados:
    *   - ConfigurarCabecalho : container cntSombra escuro com titulo (Fase 3)
    *   - ConfigurarBotoes    : cmg_4c_Botoes (Fase 4)
    *
    * O nome ConfigurarPageFrame foi mantido por convencao do padrao do sistema
    * (validador da pipeline e codigo cliente esperam este metodo).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPageFrame()
        THIS.ConfigurarPaginaLista()
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPaginaLista - Configura o painel unico do form de relatorio
    *
    * Em forms CRUD este metodo configura Page1 (Lista) do PageFrame.
    * Em frmrelatorio (layout flat sem PageFrame) este metodo agrega a
    * montagem do cabecalho escuro + CommandGroup de botoes, que juntos
    * compoem a area visivel unica do form ("pagina principal" do relatorio).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPaginaLista()
        THIS.ConfigurarCabecalho()
        THIS.ConfigurarBotoes()
    ENDPROC

    *--------------------------------------------------------------------------
    * AlternarPagina - Foca o primeiro botao de acao do relatorio
    *
    * Em forms CRUD este metodo alterna entre Page1 (Lista) e Page2 (Dados).
    * Em frmrelatorio (sem PageFrame multiplas paginas) o "alternar" significa
    * devolver o foco para o primeiro botao do CommandGroup (Visualizar),
    * que e o ponto de entrada padrao apos qualquer acao do usuario.
    *
    * par_nPagina - mantido por compatibilidade com a assinatura padrao.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE AlternarPagina(par_nPagina)
        LOCAL loc_nPagina
        loc_nPagina = IIF(VARTYPE(par_nPagina) = "N", par_nPagina, 1)
        IF loc_nPagina = 1
            IF PEMSTATUS(THIS, "cmg_4c_Botoes", 5)
                THIS.cmg_4c_Botoes.Buttons(1).SetFocus()
            ENDIF
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarCabecalho - Container escuro superior com t" + CHR(237) + "tulo do relat" + CHR(243) + "rio
    *   Equivalente ao cntSombra do frmrelatorio legado.
    *   Ocupa toda a largura do form; os bot" + CHR(245) + "es (cmg_4c_Botoes) ser" + CHR(227) + "o
    *   adicionados na Fase 4 sobrepostos ao lado direito deste container.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarCabecalho()
        THIS.AddObject("cnt_4c_Cabecalho", "Container")
        WITH THIS.cnt_4c_Cabecalho
            .Top         = 0
            .Left        = 0
            .Width       = THIS.Width
            .Height      = THIS.Height
            .BackStyle   = 1
            .BackColor   = RGB(100, 100, 100)
            .BorderWidth = 0
            .Visible     = .T.

            *-- Sombra deslocada 2px (efeito 3D sobre o t" + CHR(237) + "tulo branco)
            .AddObject("lbl_4c_Sombra", "Label")
            WITH .lbl_4c_Sombra
                .Top       = 42
                .Left      = 22
                .Width     = THIS.Width
                .Height    = 30
                .Caption   = "Impress" + CHR(227) + "o da Rela" + CHR(231) + CHR(227) + "o"
                .FontName  = "Tahoma"
                .FontSize  = 12
                .FontBold  = .T.
                .ForeColor = RGB(0, 0, 0)
                .BackStyle = 0
                .Visible   = .T.
            ENDWITH

            *-- T" + CHR(237) + "tulo em branco (sobre a sombra)
            .AddObject("lbl_4c_Titulo", "Label")
            WITH .lbl_4c_Titulo
                .Top       = 40
                .Left      = 20
                .Width     = THIS.Width
                .Height    = 30
                .Caption   = "Impress" + CHR(227) + "o da Rela" + CHR(231) + CHR(227) + "o"
                .FontName  = "Tahoma"
                .FontSize  = 12
                .FontBold  = .T.
                .ForeColor = RGB(255, 255, 255)
                .BackStyle = 0
                .Visible   = .T.
            ENDWITH
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarBotoes - CommandGroup de botoes do relatorio (btnReport original)
    *   Original: btnReport.Left=495, Top=-2, Width=310, Height=85, ButtonCount=4
    *   Botoes: Visualiza(5), Imprime(80), DocExcel(155), Sair(230) - W=75 cada
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarBotoes()
        THIS.AddObject("cmg_4c_Botoes", "CommandGroup")
        WITH THIS.cmg_4c_Botoes
            .Top           = 0
            .Left          = 495
            .Width         = 310
            .Height        = 85
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
                .Width           = 75
                .Height          = 75
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
                .Left            = 80
                .Width           = 75
                .Height          = 75
                .Caption         = "Imprimir"
                .FontName        = "Comic Sans MS"
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
                .Left            = 155
                .Width           = 75
                .Height          = 75
                .Caption         = "Excel"
                .FontName        = "Comic Sans MS"
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
                .Left            = 230
                .Width           = 75
                .Height          = 75
                .Caption         = "Encerrar"
                .Cancel          = .T.
                .FontName        = "Comic Sans MS"
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
    * FormParaRelatorio - Transfere estado do form para o BO
    * Este form nao tem campos de filtro; transfere apenas this_nQbols.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE FormParaRelatorio()
        IF VARTYPE(THIS.this_oRelatorio) = "O"
            THIS.this_oRelatorio.this_nQbols = THIS.this_nQbols
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * LimparCampos - Sem campos de filtro neste relatorio utilitario
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE LimparCampos()
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPaginaDados - Sem Page2 neste relatorio (layout flat/utilitario)
    * O form original SIGREIPC nao possui campos de filtro nem Page2 CRUD.
    * Todo o conteudo visual esta em ConfigurarCabecalho + ConfigurarBotoes (Fase 4).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPaginaDados()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnIncluirClick - Operacao CRUD nao aplicavel a relatorio utilitario
    *
    * SigReIpc eh frmrelatorio: nao mantem registros proprios. Os cursores
    * (TmpLanca, xPar) sao preparados pelo form chamador SIGCDPGR. O original
    * NAO possui botao Incluir. Este handler existe apenas para satisfazer a
    * interface padrao de forms do sistema; ao ser acionado (cenario impossivel
    * no fluxo normal), informa o operador via MsgAviso.
    *--------------------------------------------------------------------------
    PROCEDURE BtnIncluirClick()
        MsgAviso("Inclus" + CHR(227) + "o de registros n" + CHR(227) + ;
                 "o se aplica a este relat" + CHR(243) + "rio." + CHR(13) + ;
                 "Utilize a tela de Opera" + CHR(231) + CHR(245) + "es (SIGCDPGR) para incluir lan" + CHR(231) + "amentos.", ;
                 "Aviso")
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnAlterarClick - Operacao CRUD nao aplicavel a relatorio utilitario
    *
    * Mesma justificativa de BtnIncluirClick: relatorio nao edita registros.
    *--------------------------------------------------------------------------
    PROCEDURE BtnAlterarClick()
        MsgAviso("Altera" + CHR(231) + CHR(227) + "o de registros n" + CHR(227) + ;
                 "o se aplica a este relat" + CHR(243) + "rio." + CHR(13) + ;
                 "Utilize a tela de Opera" + CHR(231) + CHR(245) + "es (SIGCDPGR) para alterar lan" + CHR(231) + "amentos.", ;
                 "Aviso")
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnVisualizarClick - Exibe relatorio em preview (equivalente ao PROCEDURE visualizacao)
    *--------------------------------------------------------------------------
    PROCEDURE BtnVisualizarClick()
        THIS.FormParaRelatorio()
        IF VARTYPE(THIS.this_oRelatorio) = "O"
            IF !THIS.this_oRelatorio.Visualizar()
                MsgErro(THIS.this_oRelatorio.this_cMensagemErro, "Erro")
            ENDIF
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnExcluirClick - Operacao CRUD nao aplicavel a relatorio utilitario
    *
    * Mesma justificativa de BtnIncluirClick: relatorio nao remove registros.
    *--------------------------------------------------------------------------
    PROCEDURE BtnExcluirClick()
        MsgAviso("Exclus" + CHR(227) + "o de registros n" + CHR(227) + ;
                 "o se aplica a este relat" + CHR(243) + "rio." + CHR(13) + ;
                 "Utilize a tela de Opera" + CHR(231) + CHR(245) + "es (SIGCDPGR) para excluir lan" + CHR(231) + "amentos.", ;
                 "Aviso")
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnImprimirClick - Imprime relatorio na impressora (equivalente ao PROCEDURE impressao)
    *--------------------------------------------------------------------------
    PROCEDURE BtnImprimirClick()
        THIS.FormParaRelatorio()
        IF VARTYPE(THIS.this_oRelatorio) = "O"
            IF !THIS.this_oRelatorio.Imprimir()
                MsgErro(THIS.this_oRelatorio.this_cMensagemErro, "Erro")
            ENDIF
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnExcelClick - Exportacao para Excel nao aplicavel neste relatorio utilitario
    *   Os cursores (TmpLanca, xPar) sao gerenciados pelo form chamador (SIGCDPGR).
    *--------------------------------------------------------------------------
    PROCEDURE BtnExcelClick()
        MsgAviso("Exporta" + CHR(231) + CHR(227) + "o para Excel n" + CHR(227) + ;
                 "o dispon" + CHR(237) + "vel neste relat" + CHR(243) + "rio.", "Aviso")
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnSairClick - Fecha o formulario
    *--------------------------------------------------------------------------
    PROCEDURE BtnSairClick()
        THIS.Release()
    ENDPROC

    *--------------------------------------------------------------------------
    * TornarControlesVisiveis - Torna todos os controles visiveis recursivamente
    * Itera Controls de Containers e Pages de PageFrames recursivamente.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
        LOCAL loc_nI, loc_oObjeto
        FOR loc_nI = 1 TO par_oContainer.ControlCount
            loc_oObjeto = par_oContainer.Controls(loc_nI)
            IF VARTYPE(loc_oObjeto) = "O"
                IF PEMSTATUS(loc_oObjeto, "Visible", 5)
                    loc_oObjeto.Visible = .T.
                ENDIF
                IF UPPER(loc_oObjeto.BaseClass) = "PAGEFRAME"
                    LOCAL loc_nP
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
    * FormParaBO - Delega para FormParaRelatorio (padrao de relatorio)
    * FormBase.Salvar() chama FormParaBO(); este form redireciona para
    * FormParaRelatorio() que transfere this_nQbols ao BO.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE FormParaBO()
        THIS.FormParaRelatorio()
    ENDPROC

    *--------------------------------------------------------------------------
    * BOParaForm - Sem campos de entrada neste relatorio utilitario
    * Form nao possui filtros; cursores sao preparados pelo form chamador.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE BOParaForm()
    ENDPROC

    *--------------------------------------------------------------------------
    * HabilitarCampos - Sem campos editaveis neste relatorio utilitario
    * Toda a interacao e via botoes do CommandGroup (cmg_4c_Botoes).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE HabilitarCampos(par_lHabilitar)
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarLista - Sem lista neste relatorio utilitario
    * Dados sao fornecidos via cursores preparados pelo form chamador SIGCDPGR.
    *--------------------------------------------------------------------------
    PROCEDURE CarregarLista()
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * AjustarBotoesPorModo - Sem modos CRUD neste relatorio utilitario
    * Form possui apenas botoes Visualizar/Imprimir/Excel/Encerrar.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE AjustarBotoesPorModo(par_cModo)
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnBuscarClick - Busca nao aplicavel a relatorio utilitario
    * SIGREIPC nao possui campo de pesquisa; dados vem do form chamador.
    *--------------------------------------------------------------------------
    PROCEDURE BtnBuscarClick()
        MsgAviso("Pesquisa n" + CHR(227) + "o se aplica a este relat" + CHR(243) + "rio." + CHR(13) + ;
                 "Utilize a tela de Opera" + CHR(231) + CHR(245) + "es (SIGCDPGR) para selecionar lan" + CHR(231) + "amentos.", ;
                 "Aviso")
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnEncerrarClick - Fecha o formulario (alias de BtnSairClick)
    * Disponibilizado como metodo nomeado para compatibilidade com
    * padroes de forms que usam cnt_4c_Saida com cmd_4c_Encerrar.
    *--------------------------------------------------------------------------
    PROCEDURE BtnEncerrarClick()
        THIS.Release()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnSalvarClick - Salvar nao aplicavel a relatorio utilitario
    * SIGREIPC nao possui campos de entrada nem persistencia propria.
    *--------------------------------------------------------------------------
    PROCEDURE BtnSalvarClick()
        MsgAviso("Salvar n" + CHR(227) + "o se aplica a este relat" + CHR(243) + "rio." + CHR(13) + ;
                 "Utilize os bot" + CHR(245) + "es Visualizar ou Imprimir para gerar o relat" + CHR(243) + "rio.", ;
                 "Aviso")
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnCancelarClick - Fecha o formulario sem acao adicional
    * Form nao possui edicao em andamento; cancelar equivale a encerrar.
    *--------------------------------------------------------------------------
    PROCEDURE BtnCancelarClick()
        THIS.Release()
    ENDPROC

    *--------------------------------------------------------------------------
    * Destroy - Libera BO de relat" + CHR(243) + "rio
    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
        IF VARTYPE(THIS.this_oRelatorio) = "O"
            THIS.this_oRelatorio = .NULL.
        ENDIF
        DODEFAULT()
    ENDPROC

ENDDEFINE


### BO (C:\4c\projeto\app\classes\SigReIpcBO.prg):
*==============================================================================
* SIGREIPCBO.PRG
* Business Object para SigReIpc - Impress?o da Rela??o de Operacoes
*
* Herda de RelatorioBase
*
* Contexto: Form utilit?rio chamado pelo SIGCDPGR com cursores j? preparados.
*   - TmpLanca : cursor de dados principal (lancamentos)
*   - xPar     : cursor de par?metros
*   - crSigCdEmp: cursor de empresa
*   - crSigCdPgr: cursor de opera??es (contendo Dopes, Numes)
*   - Par?metro Qbols: n?mero de opera??es a imprimir
*==============================================================================

DEFINE CLASS SigReIpcBO AS RelatorioBase

    *-- N?mero de opera??es a imprimir (par?metro recebido pelo form)
    this_nQbols = 0

    *--------------------------------------------------------------------------
    * Init - Inicializa Business Object
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        DODEFAULT()

        THIS.this_cTabela     = ""
        THIS.this_cCampoChave = ""

        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * PrepararDados - Posiciona cursores para o relatorio
    * Cursores TmpLanca/xPar/crSigCdEmp/crSigCdPgr sao preparados pelo form chamador
    *--------------------------------------------------------------------------
    PROCEDURE PrepararDados()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            IF USED("TMPLANCA")
                SELECT TMPLANCA
                GO TOP
            ENDIF
            loc_lSucesso = .T.
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Visualizar - Exibe relatorio em preview, uma iteracao por operacao
    *--------------------------------------------------------------------------
    PROCEDURE Visualizar()
        LOCAL loc_nX, loc_cNomeEmpresa, loc_cRelTitulo, loc_cPeriodo, loc_lSucesso
        loc_lSucesso = .F.
        TRY
            FOR loc_nX = 1 TO THIS.this_nQbols
                loc_cNomeEmpresa = IIF(SEEK(go_4c_Sistema.cCodEmpresa, "crSigCdEmp", "Cemps"), ;
                                       ALLTRIM(crSigCdEmp.Razas), "")
                loc_cRelTitulo = "Rela" + CHR(231) + CHR(227) + "o de " + ;
                                 PROPER(ALLTRIM(crSigCdPgr.Dopes)) + "s"
                loc_cPeriodo   = "Opera" + CHR(231) + CHR(227) + "o : " + ;
                                 ALLTRIM(crSigCdPgr.Dopes) + " " + ;
                                 fGerMascara(crSigCdPgr.Numes)

                IF USED("Cabecalho")
                    USE IN Cabecalho
                ENDIF
                CREATE CURSOR Cabecalho (pNomeEmpresa C(80), pRelTitulo C(80), ;
                                         pTipo N(1), pPeriodo C(80))
                INSERT INTO Cabecalho (pNomeEmpresa, pRelTitulo, pPeriodo, pTipo) ;
                    VALUES (loc_cNomeEmpresa, loc_cRelTitulo, loc_cPeriodo, 1)

                IF USED("xPar")
                    SELECT xPar
                    GO TOP
                ENDIF

                SELECT TMPLANCA
                GO TOP

                REPORT FORM (gc_4c_CaminhoReports + "RelSigReIpc.frx") PREVIEW NOCONSOLE
            ENDFOR
            loc_lSucesso = .T.
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Imprimir - Imprime relatorio direto na impressora, uma iteracao por operacao
    *--------------------------------------------------------------------------
    PROCEDURE Imprimir()
        LOCAL loc_nX, loc_cNomeEmpresa, loc_cRelTitulo, loc_cPeriodo, loc_lSucesso
        loc_lSucesso = .F.
        TRY
            FOR loc_nX = 1 TO THIS.this_nQbols
                loc_cNomeEmpresa = IIF(SEEK(go_4c_Sistema.cCodEmpresa, "crSigCdEmp", "Cemps"), ;
                                       ALLTRIM(crSigCdEmp.Razas), "")
                loc_cRelTitulo = "Rela" + CHR(231) + CHR(227) + "o de " + ;
                                 PROPER(ALLTRIM(crSigCdPgr.Dopes)) + "s"
                loc_cPeriodo   = "Opera" + CHR(231) + CHR(227) + "o : " + ;
                                 ALLTRIM(crSigCdPgr.Dopes) + " " + ;
                                 fGerMascara(crSigCdPgr.Numes)

                IF USED("Cabecalho")
                    USE IN Cabecalho
                ENDIF
                CREATE CURSOR Cabecalho (pNomeEmpresa C(80), pRelTitulo C(80), ;
                                         pTipo N(1), pPeriodo C(80))
                INSERT INTO Cabecalho (pNomeEmpresa, pRelTitulo, pPeriodo, pTipo) ;
                    VALUES (loc_cNomeEmpresa, loc_cRelTitulo, loc_cPeriodo, 1)

                IF USED("xPar")
                    SELECT xPar
                    GO TOP
                ENDIF

                SELECT TMPLANCA
                GO TOP

                REPORT FORM (gc_4c_CaminhoReports + "RelSigReIpc.frx") TO PRINTER PROMPT NOCONSOLE
            ENDFOR
            loc_lSucesso = .T.
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Relatorio nao possui chave primaria
    *--------------------------------------------------------------------------
    PROCEDURE ObterChavePrimaria()
        RETURN ""
    ENDPROC

ENDDEFINE


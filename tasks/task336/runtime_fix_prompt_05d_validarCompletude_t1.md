# CORRIGIR ERRO DE RUNTIME VFP9

## TAREFA OBRIGATORIA
O formulario VFP9 apresentou erro de runtime durante teste automatizado.
Voce DEVE corrigir o erro e salvar os arquivos corrigidos usando Write tool.

## ERRO DETECTADO
- Etapa: 05d_validarCompletude
- Tentativa: 1/10
- Mensagem: Validacao de completude falhou. Procedures vazias/TODOs encontrados:
[FormSigPrTar.prg] Procedure vazia (sem codigo): AjustarBotoesPorModo

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

### FORM (C:\4c\projeto\app\forms\operacionais\FormSigPrTar.prg):
*------------------------------------------------------------------------------
* FormSigPrTar.prg - Sub-formulario modal de Observacao de Inspecao
* Sub-form aberto pelo form pai para exibir campo ObsInsp do csTmpPrTar
* Herda de FormBase
*------------------------------------------------------------------------------
DEFINE CLASS FormSigPrTar AS FormBase

    *-- Propriedades da instancia
    this_oBusinessObject = .NULL.
    this_oFormPai        = .NULL.
    this_lHouveIncl      = .F.
    this_lHouveExcl      = .F.

    *-- Propriedades visuais (SCX SIGSERPR)
    Width       = 588
    Height      = 325
    AutoCenter  = .T.
    TitleBar    = 0
    ShowWindow = 1
    ControlBox  = .F.
    MaxButton   = .F.
    MinButton   = .F.
    WindowType  = 1
    Themes      = .F.
    DataSession = 1

    *--------------------------------------------------------------------------
    * Init - recebe referencia ao form pai e compartilha datasession
    *--------------------------------------------------------------------------
    PROCEDURE Init(par_oFormPai)
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        TRY
            IF VARTYPE(par_oFormPai) = "O" AND !ISNULL(par_oFormPai)
                THIS.this_oFormPai = par_oFormPai
                SET DATASESSION TO par_oFormPai.DataSessionId
            ENDIF

            loc_lSucesso = DODEFAULT()

            IF loc_lSucesso
                THIS.this_lHouveIncl = .F.
                THIS.this_lHouveExcl = .F.
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
                    " PROC=" + loc_oErro.Procedure, "Erro Init FormSigPrTar")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * InicializarForm - cria BO e controles visuais do formulario
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        TRY
            THIS.this_oBusinessObject = CREATEOBJECT("SigPrTarBO")

            IF VARTYPE(THIS.this_oBusinessObject) = "O"
                THIS.Caption = "Inspira" + CHR(231) + CHR(227) + "o da Tarefa"
                THIS.Picture = gc_4c_CaminhoIcones + "new_background.jpg"

                THIS.ConfigurarPageFrame()
                THIS.ConfigurarEncerrar()
                THIS.ConfigurarPaginaDados()
                THIS.ConfigurarPaginaLista()

                THIS.TornarControlesVisiveis(THIS)

                THIS.CarregarDados()

                loc_lSucesso = .T.
            ELSE
                MsgErro("Falha ao criar SigPrTarBO", "Erro")
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
                    " PROC=" + loc_oErro.Procedure, "Erro InicializarForm FormSigPrTar")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPageFrame - container escuro com labels de sombra e titulo
    * (SIGSERPR nao usa PageFrame; metodo mantem nome canonico das convencoes
    *  do pipeline para configuracao inicial de layout)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPageFrame()
        LOCAL loc_nLargura, loc_cCaption
        loc_nLargura = THIS.Width
        loc_cCaption = THIS.Caption

        THIS.AddObject("cnt_4c_Cabecalho", "Container")
        WITH THIS.cnt_4c_Cabecalho
            .Top         = 0
            .Left        = 0
            .Width       = loc_nLargura
            .Height      = 80
            .BackStyle   = 1
            .BackColor   = RGB(100, 100, 100)
            .BorderWidth = 0

            .AddObject("lbl_4c_Sombra", "Label")
            .AddObject("lbl_4c_Titulo", "Label")
            .Visible     = .T.
        ENDWITH

        WITH THIS.cnt_4c_Cabecalho.lbl_4c_Sombra
            .AutoSize  = .F.
            .Width     = loc_nLargura
            .Height    = 40
            .Top       = 18
            .Left      = 10
            .FontName  = "Tahoma"
            .FontSize  = 18
            .FontBold  = .T.
            .BackStyle = 0
            .ForeColor = RGB(0, 0, 0)
            .WordWrap  = .T.
            .Caption   = loc_cCaption
        ENDWITH

        WITH THIS.cnt_4c_Cabecalho.lbl_4c_Titulo
            .AutoSize  = .F.
            .Width     = loc_nLargura
            .Height    = 46
            .Top       = 17
            .Left      = 10
            .FontName  = "Tahoma"
            .FontSize  = 18
            .FontBold  = .T.
            .BackStyle = 0
            .ForeColor = RGB(255, 255, 255)
            .WordWrap  = .T.
            .Caption   = loc_cCaption
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarEncerrar - Shape decorativo e botao Encerrar
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarEncerrar()
        THIS.AddObject("shp_4c_Shape1", "Shape")
        WITH THIS.shp_4c_Shape1
            .Top         = 31
            .Left        = 486
            .Height      = 53
            .Width       = 66
            .BackStyle   = 0
            .BorderStyle = 0
            .BorderColor = RGB(136, 189, 188)
        ENDWITH

        THIS.AddObject("cmd_4c_Encerrar", "CommandButton")
        WITH THIS.cmd_4c_Encerrar
            .Top             = 4
            .Left            = 510
            .Width           = 75
            .Height          = 75
            .Caption         = "Encerrar"
            .Cancel          = .T.
            .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
            .FontName        = "Comic Sans MS"
            .FontBold        = .T.
            .FontItalic      = .T.
            .FontSize        = 8
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .Themes           = .T.
            .SpecialEffect   = 0
            .PicturePosition = 13
            .MousePointer    = 15
            .WordWrap        = .T.
        ENDWITH

        BINDEVENT(THIS.cmd_4c_Encerrar, "Click", THIS, "CmdEncerrarClick")
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPaginaDados - campos principais do sub-form (SIGSERPR)
    * Nao ha PageFrame/Page2 neste form modal; o metodo cria os controles de
    * dados diretamente sobre o form (label descritivo + EditBox de Inspiracao)
    * seguindo a convencao canonica de nomes do pipeline de migracao.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPaginaDados()
        THIS.AddObject("lbl_4c_Label1", "Label")
        WITH THIS.lbl_4c_Label1
            .AutoSize  = .T.
            .FontBold  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .WordWrap  = .F.
            .Alignment = 1
            .Caption   = "Inspira" + CHR(231) + CHR(227) + "o"
            .Height    = 15
            .Left      = 12
            .Top       = 84
            .Width     = 62
            .ForeColor = RGB(90, 90, 90)
        ENDWITH

        THIS.AddObject("obj_4c_GetObsInsp", "EditBox")
        WITH THIS.obj_4c_GetObsInsp
            .FontName           = "Tahoma"
            .FontSize           = 8
            .Height             = 212
            .Left               = 12
            .Top                = 100
            .Width              = 564
            .ReadOnly           = .T.
            .DisabledBackColor  = RGB(255, 255, 255)
            .DisabledForeColor  = RGB(36, 84, 155)
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDados - liga EditBox ao cursor compartilhado csTmpPrTar
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDados()
        IF USED("csTmpPrTar") AND RECCOUNT("csTmpPrTar") > 0
            THIS.obj_4c_GetObsInsp.ControlSource = "csTmpPrTar.ObsInsp"
        ELSE
            THIS.obj_4c_GetObsInsp.Value = ""
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPaginaLista - configura vista principal do sub-form modal
    * SIGSERPR nao possui PageFrame nem Grid CRUD - a vista principal e o
    * EditBox de Inspiracao vinculado ao cursor compartilhado csTmpPrTar.
    * Metodo garante alinhamento visual do EditBox com o label e ajusta
    * ForeColor conforme estado (read-only=azul, editavel=preto).
    *--------------------------------------------------------------------------
    PROCEDURE ConfigurarPaginaLista()
        LOCAL loc_nLargura, loc_nAltura

        loc_nLargura = THIS.Width - 24
        loc_nAltura  = THIS.Height - 113

        IF PEMSTATUS(THIS, "obj_4c_GetObsInsp", 5)
            WITH THIS.obj_4c_GetObsInsp
                .Width  = loc_nLargura
                .Height = loc_nAltura
                IF .ReadOnly
                    .DisabledBackColor = RGB(255, 255, 255)
                    .DisabledForeColor = RGB(36, 84, 155)
                ELSE
                    .BackColor = RGB(255, 255, 255)
                    .ForeColor = RGB(0, 0, 0)
                ENDIF
                IF USED("csTmpPrTar") AND RECCOUNT("csTmpPrTar") > 0
                    .ControlSource = "csTmpPrTar.ObsInsp"
                ENDIF
            ENDWITH
        ENDIF

        IF PEMSTATUS(THIS, "lbl_4c_Label1", 5)
            THIS.lbl_4c_Label1.Caption = "Inspira" + CHR(231) + CHR(227) + "o"
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * AlternarPagina - alterna entre visualizacao do registro corrente e
    * refresh do cursor compartilhado. SIGSERPR e single-view (sem PageFrame),
    * portanto o parametro serve para refrescar (1) ou reposicionar (2) o
    * cursor csTmpPrTar. Chamado pelo form pai quando o registro corrente muda.
    *--------------------------------------------------------------------------
    PROCEDURE AlternarPagina(par_nPagina)
        LOCAL loc_nPagina
        loc_nPagina = IIF(VARTYPE(par_nPagina) = "N", par_nPagina, 1)

        DO CASE
            CASE loc_nPagina = 1
                *-- Modo visualizacao: garante bind do EditBox ao registro atual
                THIS.ConfigurarPaginaLista()
                THIS.CarregarDados()

            CASE loc_nPagina = 2
                *-- Modo refresh: reposiciona no primeiro registro do cursor
                IF USED("csTmpPrTar") AND RECCOUNT("csTmpPrTar") > 0
                    SELECT csTmpPrTar
                    GO TOP
                    THIS.CarregarDados()
                ENDIF
        ENDCASE

        THIS.Refresh()
    ENDPROC

    *--------------------------------------------------------------------------
    * TornarControlesVisiveis - percorre controles recursivamente
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
    * CmdEncerrarClick - reativa form pai e fecha este sub-form
    *--------------------------------------------------------------------------
    PROCEDURE CmdEncerrarClick()
        IF VARTYPE(THIS.this_oFormPai) = "O" AND !ISNULL(THIS.this_oFormPai)
            THIS.this_oFormPai.Enabled = .T.
        ENDIF
        THIS.Release()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnIncluirClick - inicia nova nota de Inspecao (limpa campo, modo editavel)
    * SIGSERPR nao tem toolbar CRUD; handler canonico do pipeline opera sobre
    * o cursor compartilhado csTmpPrTar.ObsInsp para permitir insercao.
    *--------------------------------------------------------------------------
    PROCEDURE BtnIncluirClick()
        LOCAL loc_oErro

        TRY
            IF !USED("csTmpPrTar") OR RECCOUNT("csTmpPrTar") = 0
                MsgAviso("Nenhum registro de tarefa disponivel para inclus" + ;
                        CHR(227) + "o de inspe" + CHR(231) + CHR(227) + "o.", ;
                        "Inclus" + CHR(227) + "o")
                RETURN
            ENDIF

            SELECT csTmpPrTar

            IF TYPE("csTmpPrTar.ObsInsp") = "U"
                MsgAviso("Campo ObsInsp n" + CHR(227) + "o existe no cursor csTmpPrTar.", ;
                        "Erro Inclus" + CHR(227) + "o")
                RETURN
            ENDIF

            REPLACE csTmpPrTar.ObsInsp WITH "" IN csTmpPrTar

            THIS.this_lHouveIncl = .T.

            IF PEMSTATUS(THIS, "obj_4c_GetObsInsp", 5)
                WITH THIS.obj_4c_GetObsInsp
                    .ReadOnly  = .F.
                    .BackColor = RGB(255, 255, 255)
                    .ForeColor = RGB(0, 0, 0)
                    .Value     = ""
                    .SetFocus()
                ENDWITH
            ENDIF

            THIS.CarregarDados()
            THIS.Refresh()

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
                    " PROC=" + loc_oErro.Procedure, "Erro BtnIncluirClick")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnAlterarClick - habilita edicao da Inspecao no registro corrente
    *--------------------------------------------------------------------------
    PROCEDURE BtnAlterarClick()
        LOCAL loc_oErro

        TRY
            IF !USED("csTmpPrTar") OR RECCOUNT("csTmpPrTar") = 0
                MsgAviso("Nenhum registro selecionado para altera" + ;
                        CHR(231) + CHR(227) + "o.", ;
                        "Altera" + CHR(231) + CHR(227) + "o")
                RETURN
            ENDIF

            IF TYPE("csTmpPrTar.ObsInsp") = "U"
                MsgAviso("Campo ObsInsp n" + CHR(227) + "o existe no cursor csTmpPrTar.", ;
                        "Erro Altera" + CHR(231) + CHR(227) + "o")
                RETURN
            ENDIF

            IF PEMSTATUS(THIS, "obj_4c_GetObsInsp", 5)
                WITH THIS.obj_4c_GetObsInsp
                    .ReadOnly  = .F.
                    .BackColor = RGB(255, 255, 255)
                    .ForeColor = RGB(0, 0, 0)
                    .ControlSource = "csTmpPrTar.ObsInsp"
                    .SetFocus()
                ENDWITH
            ENDIF

            THIS.Refresh()

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
                    " PROC=" + loc_oErro.Procedure, "Erro BtnAlterarClick")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnVisualizarClick - retorna EditBox ao modo read-only (azul)
    *--------------------------------------------------------------------------
    PROCEDURE BtnVisualizarClick()
        LOCAL loc_oErro

        TRY
            IF !USED("csTmpPrTar") OR RECCOUNT("csTmpPrTar") = 0
                MsgAviso("Nenhum registro dispon" + CHR(237) + "vel para visualiza" + ;
                        CHR(231) + CHR(227) + "o.", ;
                        "Visualiza" + CHR(231) + CHR(227) + "o")
                RETURN
            ENDIF

            IF PEMSTATUS(THIS, "obj_4c_GetObsInsp", 5)
                WITH THIS.obj_4c_GetObsInsp
                    .ReadOnly           = .T.
                    .DisabledBackColor  = RGB(255, 255, 255)
                    .DisabledForeColor  = RGB(36, 84, 155)
                    IF TYPE("csTmpPrTar.ObsInsp") != "U"
                        .ControlSource = "csTmpPrTar.ObsInsp"
                    ENDIF
                ENDWITH
            ENDIF

            THIS.CarregarDados()
            THIS.Refresh()

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
                    " PROC=" + loc_oErro.Procedure, "Erro BtnVisualizarClick")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnExcluirClick - remove nota de Inspecao do registro corrente
    * (limpa campo ObsInsp no cursor csTmpPrTar apos confirmacao do usuario)
    *--------------------------------------------------------------------------
    PROCEDURE BtnExcluirClick()
        LOCAL loc_lConfirma, loc_oErro

        TRY
            IF !USED("csTmpPrTar") OR RECCOUNT("csTmpPrTar") = 0
                MsgAviso("Nenhum registro selecionado para exclus" + ;
                        CHR(227) + "o.", ;
                        "Exclus" + CHR(227) + "o")
                RETURN
            ENDIF

            IF TYPE("csTmpPrTar.ObsInsp") = "U"
                MsgAviso("Campo ObsInsp n" + CHR(227) + "o existe no cursor csTmpPrTar.", ;
                        "Erro Exclus" + CHR(227) + "o")
                RETURN
            ENDIF

            SELECT csTmpPrTar
            IF EMPTY(csTmpPrTar.ObsInsp)
                MsgAviso("N" + CHR(227) + "o h" + CHR(225) + " inspe" + CHR(231) + ;
                        CHR(227) + "o cadastrada para excluir.", ;
                        "Exclus" + CHR(227) + "o")
                RETURN
            ENDIF

            loc_lConfirma = MsgConfirma("Confirma exclus" + CHR(227) + "o da inspe" + ;
                                        CHR(231) + CHR(227) + "o do registro corrente?", ;
                                        "Confirmar Exclus" + CHR(227) + "o")

            IF !loc_lConfirma
                RETURN
            ENDIF

            REPLACE csTmpPrTar.ObsInsp WITH "" IN csTmpPrTar

            THIS.this_lHouveExcl = .T.

            IF PEMSTATUS(THIS, "obj_4c_GetObsInsp", 5)
                THIS.obj_4c_GetObsInsp.Value = ""
            ENDIF

            THIS.CarregarDados()
            THIS.Refresh()

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
                    " PROC=" + loc_oErro.Procedure, "Erro BtnExcluirClick")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarLista - recarrega o EditBox a partir do cursor csTmpPrTar
    * Equivalente ao CarregarLista canonico; este form nao tem grid de lista
    *--------------------------------------------------------------------------
    PROCEDURE CarregarLista()
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        TRY
            IF USED("csTmpPrTar") AND RECCOUNT("csTmpPrTar") > 0
                IF PEMSTATUS(THIS, "obj_4c_GetObsInsp", 5)
                    THIS.obj_4c_GetObsInsp.ControlSource = "csTmpPrTar.ObsInsp"
                ENDIF
                loc_lSucesso = .T.
            ELSE
                IF PEMSTATUS(THIS, "obj_4c_GetObsInsp", 5)
                    THIS.obj_4c_GetObsInsp.Value = ""
                ENDIF
            ENDIF

            THIS.Refresh()

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
                    " PROC=" + loc_oErro.Procedure, "Erro CarregarLista FormSigPrTar")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnBuscarClick - atualiza exibicao do campo de inspiracao
    * Este form nao tem busca CRUD; o metodo re-sincroniza o EditBox
    *--------------------------------------------------------------------------
    PROCEDURE BtnBuscarClick()
        LOCAL loc_oErro

        TRY
            THIS.CarregarLista()

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
                    " PROC=" + loc_oErro.Procedure, "Erro BtnBuscarClick")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnEncerrarClick - alias canonico de CmdEncerrarClick
    *--------------------------------------------------------------------------
    PROCEDURE BtnEncerrarClick()
        THIS.CmdEncerrarClick()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnSalvarClick - confirma edicao do campo ObsInsp no cursor compartilhado
    * A edicao via ControlSource ja grava no buffer; basta retornar ao modo
    * read-only e propagar via FormParaBO
    *--------------------------------------------------------------------------
    PROCEDURE BtnSalvarClick()
        LOCAL loc_oErro

        TRY
            IF !USED("csTmpPrTar") OR RECCOUNT("csTmpPrTar") = 0
                MsgAviso("Nenhum registro dispon" + CHR(237) + "vel para salvar.", "Salvar")
                RETURN
            ENDIF

            THIS.FormParaBO()

            IF PEMSTATUS(THIS, "obj_4c_GetObsInsp", 5)
                WITH THIS.obj_4c_GetObsInsp
                    .ReadOnly          = .T.
                    .DisabledBackColor = RGB(255, 255, 255)
                    .DisabledForeColor = RGB(36, 84, 155)
                ENDWITH
            ENDIF

            THIS.Refresh()

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
                    " PROC=" + loc_oErro.Procedure, "Erro BtnSalvarClick")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnCancelarClick - cancela edicao e restaura conteudo do cursor
    *--------------------------------------------------------------------------
    PROCEDURE BtnCancelarClick()
        LOCAL loc_oErro

        TRY
            IF PEMSTATUS(THIS, "obj_4c_GetObsInsp", 5)
                WITH THIS.obj_4c_GetObsInsp
                    .ReadOnly          = .T.
                    .DisabledBackColor = RGB(255, 255, 255)
                    .DisabledForeColor = RGB(36, 84, 155)
                ENDWITH
            ENDIF

            THIS.CarregarLista()

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
                    " PROC=" + loc_oErro.Procedure, "Erro BtnCancelarClick")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * FormParaBO - transfere valor do EditBox para a propriedade do BO
    *--------------------------------------------------------------------------
    PROCEDURE FormParaBO()
        LOCAL loc_oErro

        TRY
            IF VARTYPE(THIS.this_oBusinessObject) = "O" AND ;
               !ISNULL(THIS.this_oBusinessObject)
                IF PEMSTATUS(THIS, "obj_4c_GetObsInsp", 5)
                    THIS.this_oBusinessObject.this_cObsInsp = ;
                        ALLTRIM(NVL(THIS.obj_4c_GetObsInsp.Value, ""))
                ENDIF
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
                    " PROC=" + loc_oErro.Procedure, "Erro FormParaBO")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BOParaForm - transfere propriedade do BO para o EditBox
    *--------------------------------------------------------------------------
    PROCEDURE BOParaForm()
        LOCAL loc_oErro

        TRY
            IF VARTYPE(THIS.this_oBusinessObject) = "O" AND ;
               !ISNULL(THIS.this_oBusinessObject)
                IF PEMSTATUS(THIS, "obj_4c_GetObsInsp", 5)
                    THIS.obj_4c_GetObsInsp.ControlSource = ""
                    THIS.obj_4c_GetObsInsp.Value = ;
                        THIS.this_oBusinessObject.this_cObsInsp
                ENDIF
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
                    " PROC=" + loc_oErro.Procedure, "Erro BOParaForm")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * HabilitarCampos - habilita ou desabilita o EditBox de inspiracao
    *--------------------------------------------------------------------------
    PROCEDURE HabilitarCampos(par_lHabilitar)
        LOCAL loc_lHabilitar

        loc_lHabilitar = IIF(VARTYPE(par_lHabilitar) = "L", par_lHabilitar, .F.)

        IF PEMSTATUS(THIS, "obj_4c_GetObsInsp", 5)
            IF loc_lHabilitar
                THIS.obj_4c_GetObsInsp.ReadOnly  = .F.
                THIS.obj_4c_GetObsInsp.BackColor = RGB(255, 255, 255)
                THIS.obj_4c_GetObsInsp.ForeColor = RGB(0, 0, 0)
            ELSE
                THIS.obj_4c_GetObsInsp.ReadOnly          = .T.
                THIS.obj_4c_GetObsInsp.DisabledBackColor = RGB(255, 255, 255)
                THIS.obj_4c_GetObsInsp.DisabledForeColor = RGB(36, 84, 155)
            ENDIF
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * LimparCampos - limpa o EditBox de inspiracao
    *--------------------------------------------------------------------------
    PROCEDURE LimparCampos()
        IF PEMSTATUS(THIS, "obj_4c_GetObsInsp", 5)
            THIS.obj_4c_GetObsInsp.ControlSource = ""
            THIS.obj_4c_GetObsInsp.Value         = ""
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * AjustarBotoesPorModo - este form nao possui toolbar CRUD
    * Metodo presente para compatibilidade com o pipeline canonico
    *--------------------------------------------------------------------------
    PROCEDURE AjustarBotoesPorModo()
        *-- sem botoes CRUD para ajustar neste sub-form modal
    ENDPROC

    *--------------------------------------------------------------------------
    * Destroy - reativa form pai e libera recursos
    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
        IF VARTYPE(THIS.this_oFormPai) = "O" AND !ISNULL(THIS.this_oFormPai)
            THIS.this_oFormPai.Enabled = .T.
            THIS.this_oFormPai = .NULL.
        ENDIF

        IF VARTYPE(THIS.this_oBusinessObject) = "O" AND !ISNULL(THIS.this_oBusinessObject)
            THIS.this_oBusinessObject = .NULL.
        ENDIF

        DODEFAULT()
    ENDPROC

ENDDEFINE


### BO (C:\4c\projeto\app\classes\SigPrTarBO.prg):
*------------------------------------------------------------------------------
* SigPrTarBO.prg - Business Object para FormSigPrTar
* Sub-formulario modal de visualizacao de Observacao de Inspecao
* Herda de BusinessBase
*------------------------------------------------------------------------------
DEFINE CLASS SigPrTarBO AS BusinessBase

    *-- ObsInsp do cursor csTmpPrTar compartilhado pelo form pai
    this_cObsInsp = ""

    *--------------------------------------------------------------------------
    * Init - Inicializa o BO
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        DODEFAULT()

        THIS.this_cTabela     = ""
        THIS.this_cCampoChave = ""
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Carrega ObsInsp do cursor csTmpPrTar compartilhado
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        IF USED(par_cAliasCursor)
            SELECT (par_cAliasCursor)
            THIS.this_cObsInsp = TratarNulo(ObsInsp, "C")
            RETURN .T.
        ENDIF
        RETURN .F.
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Chave logica do registro visualizado
    * Retorna hash do conteudo ObsInsp (permite auditar visualizacoes)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ObterChavePrimaria()
        LOCAL loc_cChave

        IF EMPTY(THIS.this_cObsInsp)
            loc_cChave = "SEM_OBSERVACAO"
        ELSE
            loc_cChave = LEFT(ALLTRIM(THIS.this_cObsInsp), 40)
        ENDIF

        RETURN loc_cChave
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir - Nao suportado (sub-form somente leitura)
    * O EditBox getObsInsp tem ReadOnly=.T. no SCX legado
    * A tabela real eh mantida pelo form pai via cursor csTmpPrTar compartilhado
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Inserir()
        THIS.this_cMensagemErro = "Formul" + CHR(225) + "rio de visualiza" + CHR(231) + CHR(227) + ;
                                  "o de observa" + CHR(231) + CHR(227) + "o n" + CHR(227) + ;
                                  "o suporta inclus" + CHR(227) + "o. As altera" + CHR(231) + ;
                                  CHR(245) + "es s" + CHR(227) + "o feitas no formul" + CHR(225) + "rio principal."
        RETURN .F.
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - Nao suportado (sub-form somente leitura)
    * O EditBox getObsInsp tem ReadOnly=.T. no SCX legado
    * A tabela real eh mantida pelo form pai via cursor csTmpPrTar compartilhado
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Atualizar()
        THIS.this_cMensagemErro = "Formul" + CHR(225) + "rio de visualiza" + CHR(231) + CHR(227) + ;
                                  "o de observa" + CHR(231) + CHR(227) + "o n" + CHR(227) + ;
                                  "o suporta altera" + CHR(231) + CHR(227) + "o. As altera" + CHR(231) + ;
                                  CHR(245) + "es s" + CHR(227) + "o feitas no formul" + CHR(225) + "rio principal."
        RETURN .F.
    ENDPROC

    *--------------------------------------------------------------------------
    * RegistrarAuditoria - Registra evento de visualizacao de observacao
    * Override do BusinessBase: usa nome logico "SigPrTar" na coluna Tabela
    * (o BO nao tem tabela fisica dedicada; audita a acao do sub-form)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE RegistrarAuditoria(par_cOperacao)
        LOCAL loc_cSQL, loc_cChave, loc_cUsuario, loc_nResultado

        loc_cChave = THIS.ObterChavePrimaria()

        IF EMPTY(loc_cChave)
            RETURN .F.
        ENDIF

        loc_cUsuario = IIF(TYPE("gc_4c_UsuarioLogado") = "C", gc_4c_UsuarioLogado, "SISTEMA")

        loc_cSQL = "INSERT INTO LogAuditoria (Tabela, Operacao, ChaveRegistro, Usuario, DataHora) " + ;
                   "VALUES (" + ;
                   EscaparSQL("SigPrTar") + ", " + ;
                   EscaparSQL(par_cOperacao) + ", " + ;
                   EscaparSQL(loc_cChave) + ", " + ;
                   EscaparSQL(loc_cUsuario) + ", " + ;
                   "GETDATE())"

        loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

        RETURN (loc_nResultado >= 0)
    ENDPROC

ENDDEFINE


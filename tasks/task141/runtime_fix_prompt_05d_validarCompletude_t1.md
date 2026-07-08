# CORRIGIR ERRO DE RUNTIME VFP9

## TAREFA OBRIGATORIA
O formulario VFP9 apresentou erro de runtime durante teste automatizado.
Voce DEVE corrigir o erro e salvar os arquivos corrigidos usando Write tool.

## ERRO DETECTADO
- Etapa: 05d_validarCompletude
- Tentativa: 1/10
- Mensagem: Validacao de completude falhou. Procedures vazias/TODOs encontrados:
[SigPdMfaBO.prg] Indicador de pendencia: *-- Determina sequencia da proxima fase
[FormSigPdMfa.prg] Procedure vazia (sem codigo): AtualizarEstadoControles

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

### FORM (C:\4c\projeto\app\forms\operacionais\FormSigPdMfa.prg):
*==============================================================================
* FormSigPdMfa.prg - Mudanca de Fase Automatica
* Herda de: FormBase
* Tipo: OPERACIONAL (layout plano, sem PageFrame)
* Form original: SIGPDMFA (Width=800, Height=279, TitleBar=0)
* Funcao: Seleciona OPs de producao e gera movimentacao em SigPdMvf/SigCdNec
*==============================================================================
DEFINE CLASS FormSigPdMfa AS FormBase

    *-- Propriedades visuais (fidelidade ao SIGPDMFA original)
    Width        = 800
    Height       = 279
    DataSession  = 2
    ShowWindow = 1
    AutoCenter   = .T.
    BorderStyle  = 2
    TitleBar     = 0
    ControlBox   = .F.
    Closable     = .F.
    MaxButton    = .F.
    MinButton    = .F.
    ClipControls = .F.
    WindowType   = 1
    Caption      = ""
    Picture      = ""

    *-- Estado do formulario
    this_oBusinessObject = .NULL.
    this_cModoAtual      = "OPERACIONAL"

    *-- Container cabecalho (cntSombra no legado): fundo cinza medio opaco
    ADD OBJECT cnt_4c_Sombra AS Container WITH ;
        Top = 0, Left = 0, Width = 800, Height = 80, ;
        BorderWidth = 0, BackStyle = 1, BackColor = RGB(100, 100, 100)

    *-- Container de espera durante processamento (Visible=.F. ate Processa.Click)
    ADD OBJECT cnt_4c_Aguarde AS Container WITH ;
        Top = 115, Left = 296, Width = 207, Height = 49, ;
        SpecialEffect = 0, BackStyle = 1, BackColor = RGB(255, 255, 255), ;
        Visible = .F.

    *==========================================================================
    * Init - Inicializa via FormBase (que chama InicializarForm)
    *==========================================================================
    PROCEDURE Init()
        RETURN DODEFAULT()
    ENDPROC

    *==========================================================================
    * InicializarForm - Cria BO, configura form e carrega dados iniciais
    * Chamado automaticamente por FormBase.Init()
    *==========================================================================
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        TRY
            *-- Configura propriedades visuais do form (sem literais acentuados)
            THIS.Caption = "Mudan" + CHR(231) + CHR(227) + "a de Fase Autom" + CHR(225) + "tica"
            THIS.Picture = gc_4c_CaminhoIcones + "new_background.jpg"

            *-- Instancia o Business Object
            THIS.this_oBusinessObject = CREATEOBJECT("SigPdMfaBO")
            IF VARTYPE(THIS.this_oBusinessObject) != "O"
                MsgErro("Falha ao criar SigPdMfaBO", "Erro")
                loc_lSucesso = .F.
            ENDIF

            *-- Layout (form OPERACIONAL: plano, sem PageFrame)
            THIS.ConfigurarPageFrame()

            *-- Configura labels internos dos containers declarados
            THIS.ConfigurarHeader()
            THIS.ConfigurarAguarde()

            *-- Adiciona campos, botoes e shape do form
            THIS.ConfigurarCampos()
            THIS.ConfigurarBotoes()

            *-- Carrega cursores de lookup (guarda contra validacao de UI sem conexao)
            IF TYPE("gb_4c_ValidandoUI") != "L" OR !gb_4c_ValidandoUI
                IF !THIS.this_oBusinessObject.CarregarParametros()
                    MsgErro("Falha ao carregar par" + CHR(226) + "metros do sistema", "Erro")
                    loc_lSucesso = .F.
                ENDIF

                IF !THIS.this_oBusinessObject.CarregarGruposContabeis()
                    MsgErro("Falha ao carregar grupos cont" + CHR(225) + "beis", "Erro")
                    loc_lSucesso = .F.
                ENDIF

                IF !THIS.this_oBusinessObject.CarregarContas()
                    MsgErro("Falha ao carregar contas", "Erro")
                    loc_lSucesso = .F.
                ENDIF
            ENDIF

            *-- Torna controles visiveis (exceto cnt_4c_Aguarde que e flutuante)
            THIS.TornarControlesVisiveis(THIS)

            *-- Vincula eventos e atualiza estado inicial dos campos
            THIS.ConfigurarBINDEVENTs()
            THIS.AtualizarEstadoCampos()

            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao inicializar FormSigPdMfa")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * ConfigurarPageFrame - Form OPERACIONAL: layout plano, sem PageFrame
    * Original SIGPDMFA herda de `form` generico (NAO frmcadastro) e usa
    * Width=800, Height=279, TitleBar=0 com todos os controles ancorados
    * diretamente no form. Mantemos este metodo para conformidade com a
    * pipeline de migracao e como ponto de extensao caso futuras versoes
    * adicionem abas.
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPageFrame()
        *-- Form operacional plano: o background e as dimensoes ja foram
        *-- definidos via propriedades da classe. cnt_4c_Sombra e cnt_4c_Aguarde
        *-- foram declarados via ADD OBJECT e nao precisam de container parent.
        THIS.AutoCenter = .T.
    ENDPROC

    *==========================================================================
    * ConfigurarPaginaLista - Form OPERACIONAL nao tem Page1/Lista.
    * SIGPDMFA original (Width=800, Height=279) usa layout plano: todos os
    * controles ficam direto no form, sem grid de registros e sem botoes CRUD
    * (Incluir/Alterar/Excluir/Buscar). O fluxo unico eh: usuario informa
    * Linha+OP+Grupo+Conta, clica Processar, BO chama ProcessarMudancaFase
    * e gera movimentacao em SigPdMvf/SigCdNec.
    *
    * Este metodo eh chamado pela pipeline de migracao por compatibilidade.
    * Garante (idempotentemente) que os campos e botoes do form plano foram
    * configurados, mesmo se invocado depois de InicializarForm.
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPaginaLista()
        *-- Idempotente: ConfigurarCampos e ConfigurarBotoes ja sao chamados
        *-- em InicializarForm. Esta chamada extra protege contra re-execucao
        *-- pela pipeline sem duplicar AddObject (que daria "member already exists").
        IF !PEMSTATUS(THIS, "txt_4c_Linha", 5)
            THIS.ConfigurarCampos()
        ENDIF

        IF !PEMSTATUS(THIS, "cmd_4c_Processa", 5)
            THIS.ConfigurarBotoes()
        ENDIF

        *-- Em forms OPERACIONAIS, AtualizarEstadoCampos substitui a logica
        *-- de modo (INCLUIR/ALTERAR/VISUALIZAR) dos forms CRUD: apenas
        *-- ajusta Enabled de DLinha e Dconta conforme campos relacionados.
        IF PEMSTATUS(THIS, "txt_4c_Linha", 5)
            THIS.AtualizarEstadoCampos()
        ENDIF
    ENDPROC

    *==========================================================================
    * ConfigurarPaginaDados - Form OPERACIONAL nao tem Page2/Dados separada.
    * SIGPDMFA original usa layout plano: campos e labels ficam diretamente
    * no form, gerenciados por ConfigurarCampos() no InicializarForm().
    *
    * Este metodo existe por compatibilidade com a pipeline de migracao
    * (fases 5-6). Os "campos equivalentes a Page2" neste form sao:
    *   - Parte 1 (50%): txt_4c_Linha, txt_4c_DLinha, txt_4c_Op
    *   - Parte 2 (50%): txt_4c_Grupo, txt_4c_Conta, txt_4c_Dconta
    * Todos criados atomicamente em ConfigurarCampos() junto com os labels.
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPaginaDados()
        *-- Idempotente: todos os campos foram criados em ConfigurarCampos()
        *-- durante InicializarForm(). Reconvocar AddObject causaria erro
        *-- "Member object with this name already exists".
        IF !PEMSTATUS(THIS, "txt_4c_Linha", 5)
            THIS.ConfigurarCampos()
        ENDIF
    ENDPROC

    *==========================================================================
    * AlternarPagina - Form OPERACIONAL nao tem PageFrame interno.
    * SIGPDMFA original eh um dialogo plano sem alternancia Lista/Dados.
    *
    * Este metodo existe por compatibilidade com a pipeline CRUD que pode
    * invoca-lo apos rotinas auxiliares. Em vez de mudar pagina, posiciona
    * o foco no campo inicial (txt_4c_Linha) quando par_nPagina=1, ou no
    * botao de processamento quando par_nPagina=2, para manter o fluxo
    * de navegacao ergonomico.
    *==========================================================================
    PROCEDURE AlternarPagina(par_nPagina)
        LOCAL loc_nPagina
        loc_nPagina = IIF(VARTYPE(par_nPagina) = "N", par_nPagina, 1)

        DO CASE
            CASE loc_nPagina = 1
                *-- "Voltar para lista" = posicionar foco no campo inicial
                IF PEMSTATUS(THIS, "txt_4c_Linha", 5) AND THIS.txt_4c_Linha.Visible
                    THIS.txt_4c_Linha.SetFocus()
                ENDIF
            CASE loc_nPagina = 2
                *-- "Ir para dados" = posicionar foco no botao processar
                IF PEMSTATUS(THIS, "cmd_4c_Processa", 5) AND THIS.cmd_4c_Processa.Visible
                    THIS.cmd_4c_Processa.SetFocus()
                ENDIF
        ENDCASE

        THIS.Refresh()
    ENDPROC

    *==========================================================================
    * ConfigurarHeader - Adiciona labels de sombra e titulo ao cnt_4c_Sombra
    * lblSombra: texto preto (deslocado 1px) - efeito de sombra
    * lblTitulo: texto branco - titulo visivel ao usuario
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarHeader()
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
                .Caption       = "Mudan" + CHR(231) + CHR(227) + "a de Fase Autom" + CHR(225) + "tica"
                .Height        = 40
                .Left          = 10
                .Top           = 18
                .Width         = 769
                .ForeColor     = RGB(0, 0, 0)
            ENDWITH

            .AddObject("lbl_4c_LblTitulo", "Label")
            WITH .lbl_4c_LblTitulo
                .FontBold      = .T.
                .FontName      = "Tahoma"
                .FontSize      = 18
                .WordWrap      = .T.
                .Alignment     = 0
                .BackStyle     = 0
                .Caption       = "Mudan" + CHR(231) + CHR(227) + "a de Fase Autom" + CHR(225) + "tica"
                .Height        = 46
                .Left          = 10
                .Top           = 17
                .Width         = 769
                .ForeColor     = RGB(255, 255, 255)
            ENDWITH
        ENDWITH
    ENDPROC

    *==========================================================================
    * ConfigurarAguarde - Adiciona labels ao container de espera
    * Exibido durante processamento (Aguarde.Visible = .T. em BtnProcessaClick)
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarAguarde()
        WITH THIS.cnt_4c_Aguarde
            .AddObject("lbl_4c_Label1", "Label")
            WITH .lbl_4c_Label1
                .AutoSize  = .T.
                .FontBold  = .T.
                .FontName  = "Tahoma"
                .FontSize  = 10
                .BackStyle = 0
                .Caption   = "Aguarde..."
                .Height    = 18
                .Left      = 68
                .Top       = 8
                .Width     = 70
                .ForeColor = RGB(255, 0, 0)
            ENDWITH

            .AddObject("lbl_4c_Label2", "Label")
            WITH .lbl_4c_Label2
                .AutoSize  = .T.
                .FontBold  = .T.
                .FontName  = "Tahoma"
                .FontSize  = 10
                .BackStyle = 0
                .Caption   = "Processando"
                .Height    = 18
                .Left      = 61
                .Top       = 26
                .Width     = 85
                .ForeColor = RGB(90, 90, 90)
            ENDWITH
        ENDWITH
    ENDPROC

    *==========================================================================
    * TornarControlesVisiveis - Torna controles visiveis recursivamente
    * FILTRA: cnt_4c_Aguarde permanece Visible=.F. (toggle por BtnProcessaClick)
    *==========================================================================
    PROCEDURE TornarControlesVisiveis(par_oContainer)
        LOCAL loc_nI, loc_oObjeto, loc_nP

        FOR loc_nI = 1 TO par_oContainer.ControlCount
            loc_oObjeto = par_oContainer.Controls(loc_nI)

            IF VARTYPE(loc_oObjeto) = "O"
                IF UPPER(ALLTRIM(loc_oObjeto.Name)) = "CNT_4C_AGUARDE"
                    LOOP
                ENDIF

                IF PEMSTATUS(loc_oObjeto, "Visible", 5)
                    loc_oObjeto.Visible = .T.
                ENDIF

                IF UPPER(loc_oObjeto.BaseClass) = "PAGEFRAME"
                    FOR loc_nP = 1 TO loc_oObjeto.PageCount
                        THIS.TornarControlesVisiveis(loc_oObjeto.Pages(loc_nP))
                    ENDFOR
                ENDIF

                IF PEMSTATUS(loc_oObjeto, "ControlCount", 5) AND ;
                   loc_oObjeto.ControlCount > 0
                    THIS.TornarControlesVisiveis(loc_oObjeto)
                ENDIF
            ENDIF
        ENDFOR
    ENDPROC

    *==========================================================================
    * ConfigurarCampos - Adiciona labels e textboxes do form (layout plano)
    * Reproduz Get_Linha, Get_DLinha, Get_Op, Get_grupo, Get_conta, Get_dconta
    * e os labels Say2, lbl_operacao, Say3 do SIGPDMFA original (Width=800)
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarCampos()
        *-- Label "Linha : " (Say2 original: top=130, left=151)
        THIS.AddObject("lbl_4c_Label2", "Label")
        WITH THIS.lbl_4c_Label2
            .AutoSize  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Caption   = "Linha : "
            .Height    = 15
            .Left      = 151
            .Top       = 130
            .Width     = 37
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        *-- Label "O.P. :" (lbl_operacao original: top=153, left=157)
        THIS.AddObject("lbl_4c_Lbl_operacao", "Label")
        WITH THIS.lbl_4c_Lbl_operacao
            .AutoSize  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Caption   = "O.P. :"
            .Height    = 15
            .Left      = 157
            .Top       = 153
            .Width     = 31
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        *-- Label "Grupo/Conta : " (Say3 original: top=177, left=114)
        THIS.AddObject("lbl_4c_Label3", "Label")
        WITH THIS.lbl_4c_Label3
            .AutoSize  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Caption   = "Grupo/Conta : "
            .Height    = 15
            .Left      = 114
            .Top       = 177
            .Width     = 74
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        *-- TextBox Linha - codigo da linha (Get_Linha: top=125, left=194, w=80)
        THIS.AddObject("txt_4c_Linha", "TextBox")
        WITH THIS.txt_4c_Linha
            .FontBold      = .F.
            .FontItalic    = .F.
            .FontName      = "Courier New"
            .FontSize      = 9
            .FontUnderline = .F.
            .Alignment     = 0
            .BackStyle     = 1
            .BorderStyle   = 1
            .Value         = ""
            .Format        = "K"
            .Height        = 25
            .Left          = 194
            .MaxLength     = 10
            .SpecialEffect = 1
            .Top           = 125
            .Width         = 80
            .ForeColor     = RGB(0, 0, 0)
            .Visible       = .T.
        ENDWITH

        *-- TextBox descricao da Linha (Get_DLinha: top=125, left=275, w=273)
        *-- Habilitado apenas quando txt_4c_Linha estiver vazio (When legado)
        THIS.AddObject("txt_4c_DLinha", "TextBox")
        WITH THIS.txt_4c_DLinha
            .FontName      = "Courier New"
            .Format        = "K"
            .Height        = 25
            .Left          = 275
            .MaxLength     = 40
            .SpecialEffect = 1
            .Top           = 125
            .Width         = 273
            .Value         = ""
            .Visible       = .T.
        ENDWITH

        *-- TextBox O.P. - numero da ordem de producao (Get_Op: top=151, left=194, w=52)
        THIS.AddObject("txt_4c_Op", "TextBox")
        WITH THIS.txt_4c_Op
            .Alignment     = 3
            .Value         = 0
            .Format        = "K"
            .Height        = 23
            .InputMask     = "999999"
            .Left          = 194
            .MaxLength     = 6
            .SpecialEffect = 1
            .Top           = 151
            .Width         = 52
            .Visible       = .T.
        ENDWITH

        *-- TextBox Grupo contabil (Get_grupo: top=175, left=194, w=80)
        THIS.AddObject("txt_4c_Grupo", "TextBox")
        WITH THIS.txt_4c_Grupo
            .Value         = ""
            .SpecialEffect = 1
            .Height        = 23
            .Left          = 194
            .MaxLength     = 20
            .Top           = 175
            .Width         = 80
            .Visible       = .T.
        ENDWITH

        *-- TextBox codigo da Conta (Get_conta: top=175, left=275, w=80)
        THIS.AddObject("txt_4c_Conta", "TextBox")
        WITH THIS.txt_4c_Conta
            .Value         = ""
            .SpecialEffect = 1
            .Height        = 23
            .Left          = 275
            .MaxLength     = 20
            .Top           = 175
            .Width         = 80
            .Visible       = .T.
        ENDWITH

        *-- TextBox descricao da Conta (Get_dconta: top=175, left=357, w=297)
        *-- Habilitado apenas quando txt_4c_Conta estiver vazio (When legado)
        THIS.AddObject("txt_4c_Dconta", "TextBox")
        WITH THIS.txt_4c_Dconta
            .Value         = ""
            .SpecialEffect = 1
            .Height        = 23
            .Left          = 357
            .MaxLength     = 60
            .Top           = 175
            .Width         = 297
            .Visible       = .T.
        ENDWITH
    ENDPROC

    *==========================================================================
    * ConfigurarBotoes - Adiciona Shape decorativo e botoes Processa/Cancela
    * Shape1: top=7, left=699, w=90, h=19 (decorativo, transparente)
    * Processa: top=3, left=648 (75x75) / Cancela: top=3, left=723 (75x75)
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarBotoes()
        *-- Shape decorativo (Shape1 original: top=7, left=699, w=90, h=19)
        THIS.AddObject("shp_4c_Shape1", "Shape")
        WITH THIS.shp_4c_Shape1
            .Top         = 7
            .Left        = 699
            .Height      = 19
            .Width       = 90
            .BackStyle   = 0
            .BorderStyle = 0
            .BorderColor = RGB(136, 189, 188)
            .Visible     = .T.
        ENDWITH

        *-- Botao Processar (Processa original: top=3, left=648)
        THIS.AddObject("cmd_4c_Processa", "CommandButton")
        WITH THIS.cmd_4c_Processa
            .Top      = 3
            .Left     = 648
            .Height   = 75
            .Width    = 75
            .Picture  = gc_4c_CaminhoIcones + "geral_processar_60.jpg"
            .Caption  = "\<Processar"
            .FontName = "Comic Sans MS"
            .FontBold = .T.
            .FontItalic = .T.
            .FontSize = 8
            .ForeColor = RGB(90, 90, 90)
            .BackColor = RGB(255, 255, 255)
            .Themes   = .F.
            .SpecialEffect = 0
            .PicturePosition = 13
            .WordWrap = .T.
            .MousePointer = 15
            .Visible  = .T.
        ENDWITH

        *-- Botao Encerrar (Cancela original: top=3, left=723, Cancel=.T.)
        THIS.AddObject("cmd_4c_Cancela", "CommandButton")
        WITH THIS.cmd_4c_Cancela
            .Top      = 3
            .Left     = 723
            .Height   = 75
            .Width    = 75
            .Picture  = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
            .Cancel   = .T.
            .Caption  = "Encerra"
            .FontName = "Comic Sans MS"
            .FontBold = .T.
            .FontItalic = .T.
            .FontSize = 8
            .ForeColor = RGB(90, 90, 90)
            .BackColor = RGB(255, 255, 255)
            .Themes   = .F.
            .SpecialEffect = 0
            .PicturePosition = 13
            .WordWrap = .T.
            .MousePointer = 15
            .Visible  = .T.
        ENDWITH
    ENDPROC

    *==========================================================================
    * ConfigurarBINDEVENTs - Vincula eventos de campos e botoes
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarBINDEVENTs()
        BINDEVENT(THIS.txt_4c_Linha,  "KeyPress", THIS, "TxtLinhaKeyPress")
        BINDEVENT(THIS.txt_4c_Linha,  "DblClick", THIS, "TxtLinhaDblClick")
        BINDEVENT(THIS.txt_4c_DLinha, "KeyPress", THIS, "TxtDLinhaKeyPress")
        BINDEVENT(THIS.txt_4c_DLinha, "DblClick", THIS, "TxtDLinhaDblClick")
        BINDEVENT(THIS.txt_4c_Grupo,  "KeyPress", THIS, "TxtGrupoKeyPress")
        BINDEVENT(THIS.txt_4c_Grupo,  "DblClick", THIS, "TxtGrupoDblClick")
        BINDEVENT(THIS.txt_4c_Conta,  "KeyPress", THIS, "TxtContaKeyPress")
        BINDEVENT(THIS.txt_4c_Conta,  "DblClick", THIS, "TxtContaDblClick")
        BINDEVENT(THIS.txt_4c_Dconta, "KeyPress", THIS, "TxtDContaKeyPress")
        BINDEVENT(THIS.txt_4c_Dconta, "DblClick", THIS, "TxtDContaDblClick")
        BINDEVENT(THIS.cmd_4c_Processa, "Click", THIS, "BtnProcessaClick")
        BINDEVENT(THIS.cmd_4c_Cancela,  "Click", THIS, "BtnCancelaClick")
    ENDPROC

    *==========================================================================
    * AtualizarEstadoCampos - Atualiza Enabled de DLinha e Dconta
    * DLinha habilitado apenas quando Linha vazio (When legado)
    * Dconta habilitado apenas quando Conta vazio (When legado)
    *==========================================================================
    PROCEDURE AtualizarEstadoCampos()
        LOCAL loc_lLinhaVazia, loc_lContaVazia
        loc_lLinhaVazia = EMPTY(ALLTRIM(THIS.txt_4c_Linha.Value))
        loc_lContaVazia = EMPTY(ALLTRIM(THIS.txt_4c_Conta.Value))

        THIS.txt_4c_DLinha.Enabled = loc_lLinhaVazia
        THIS.txt_4c_Dconta.Enabled = loc_lContaVazia
        THIS.txt_4c_DLinha.Refresh()
        THIS.txt_4c_Dconta.Refresh()
    ENDPROC

    *==========================================================================
    * TxtLinhaKeyPress - Lookup de Linha por codigo em SigCdLin
    * ENTER(13)/TAB(9)/F4(115): valida codigo ou abre busca
    *==========================================================================
    PROCEDURE TxtLinhaKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 13 OR par_nKeyCode = 9 OR par_nKeyCode = 115
            THIS.AbrirBuscaLinha(.F.)
        ENDIF
    ENDPROC

    *==========================================================================
    * AbrirBuscaLinha - Busca linha de producao por codigo (Linhas)
    * par_lPorDescricao: .T. = busca por Descs, .F. = busca por Linhas
    *==========================================================================
    PROCEDURE AbrirBuscaLinha(par_lPorDescricao)
        LOCAL loc_cValor, loc_cCampo, loc_cSQL, loc_oLookup, loc_oErro, loc_lOk
        loc_cValor = ALLTRIM(IIF(par_lPorDescricao, THIS.txt_4c_DLinha.Value, THIS.txt_4c_Linha.Value))
        loc_cCampo = IIF(par_lPorDescricao, "Descs", "Linhas")
        loc_lOk    = .F.

        TRY
            loc_cSQL = "SELECT Linhas, Descs FROM SigCdLin"
            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaLin") >= 1
                loc_lOk = .T.
            ELSE
                MsgErro("Falha ao buscar linhas de produ" + CHR(231) + CHR(227) + "o", "Erro")
            ENDIF

            IF loc_lOk
                SELECT cursor_4c_BuscaLin
                IF !EMPTY(loc_cValor)
                    LOCATE FOR ALLTRIM(EVALUATE(loc_cCampo)) == loc_cValor
                ENDIF

                IF FOUND() AND !EMPTY(loc_cValor)
                    THIS.txt_4c_Linha.Value  = ALLTRIM(cursor_4c_BuscaLin.Linhas)
                    THIS.txt_4c_DLinha.Value = ALLTRIM(cursor_4c_BuscaLin.Descs)
                ELSE
                    loc_oLookup = CREATEOBJECT("FormBuscaAuxiliar", "cursor_4c_BuscaLin", "Linhas", ;
                        "Sele" + CHR(231) + CHR(227) + "o de Linha")
                    IF VARTYPE(loc_oLookup) = "O"
                        loc_oLookup.mAddColuna("Linhas", "", "C" + CHR(243) + "digo")
                        loc_oLookup.mAddColuna("Descs",  "", "Descri" + CHR(231) + CHR(227) + "o")
                        loc_oLookup.Show()
                        IF loc_oLookup.this_lSelecionou
                            THIS.txt_4c_Linha.Value  = ALLTRIM(cursor_4c_BuscaLin.Linhas)
                            THIS.txt_4c_DLinha.Value = ALLTRIM(cursor_4c_BuscaLin.Descs)
                        ELSE
                            THIS.txt_4c_Linha.Value  = ""
                            THIS.txt_4c_DLinha.Value = ""
                        ENDIF
                        loc_oLookup = .NULL.
                    ENDIF
                ENDIF

                IF USED("cursor_4c_BuscaLin")
                    USE IN cursor_4c_BuscaLin
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro na busca de linha")
        ENDTRY

        THIS.txt_4c_Linha.Refresh()
        THIS.txt_4c_DLinha.Refresh()
        THIS.this_oBusinessObject.this_cLinha  = ALLTRIM(THIS.txt_4c_Linha.Value)
        THIS.this_oBusinessObject.this_cDLinha = ALLTRIM(THIS.txt_4c_DLinha.Value)
        THIS.AtualizarEstadoCampos()
    ENDPROC

    *==========================================================================
    * TxtDLinhaKeyPress - Lookup de Linha por descricao em SigCdLin
    * Ativo apenas quando txt_4c_Linha vazio (When legado)
    *==========================================================================
    PROCEDURE TxtDLinhaKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 13 OR par_nKeyCode = 9 OR par_nKeyCode = 115
            IF EMPTY(ALLTRIM(THIS.txt_4c_Linha.Value))
                THIS.AbrirBuscaLinha(.T.)
            ENDIF
        ENDIF
    ENDPROC

    *==========================================================================
    * TxtGrupoKeyPress - Lookup de Grupo contabil em SigCdGcr (GerBals=1)
    * ENTER(13)/TAB(9)/F4(115): valida codigo ou abre busca via TmpGccr
    *==========================================================================
    PROCEDURE TxtGrupoKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_cValor, loc_oLookup, loc_oErro, loc_lContinuar
        IF par_nKeyCode != 13 AND par_nKeyCode != 9 AND par_nKeyCode != 115
            RETURN
        ENDIF

        loc_cValor    = ALLTRIM(THIS.txt_4c_Grupo.Value)
        loc_lContinuar = !EMPTY(loc_cValor)

        TRY
            IF loc_lContinuar AND !USED("TmpGccr")
                IF !THIS.this_oBusinessObject.CarregarGruposContabeis()
                    loc_lContinuar = .F.
                ENDIF
            ENDIF

            IF loc_lContinuar
                IF SEEK(loc_cValor, "TmpGccr", "BalCodigo")
                    THIS.txt_4c_Grupo.Value = ALLTRIM(TmpGccr.Codigos)
                ELSE
                    loc_oLookup = CREATEOBJECT("FormBuscaAuxiliar", "TmpGccr", "Codigos", ;
                        "Sele" + CHR(231) + CHR(227) + "o de Grupo")
                    IF VARTYPE(loc_oLookup) = "O"
                        loc_oLookup.mAddColuna("Codigos", "", "C" + CHR(243) + "digo")
                        loc_oLookup.mAddColuna("Descrs",  "", "Descri" + CHR(231) + CHR(227) + "o")
                        loc_oLookup.Show()
                        IF loc_oLookup.this_lSelecionou
                            THIS.txt_4c_Grupo.Value = ALLTRIM(TmpGccr.Codigos)
                        ELSE
                            THIS.txt_4c_Grupo.Value = ""
                        ENDIF
                        loc_oLookup = .NULL.
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro na busca de grupo")
        ENDTRY

        THIS.txt_4c_Grupo.Refresh()
        THIS.this_oBusinessObject.this_cGrupo = ALLTRIM(THIS.txt_4c_Grupo.Value)
    ENDPROC

    *==========================================================================
    * TxtContaKeyPress - Lookup de Conta em TmpCli (SigCdCli GerBals=1)
    * ENTER(13)/TAB(9)/F4(115): busca por IClis, preenche Dconta e Grupo
    *==========================================================================
    PROCEDURE TxtContaKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_cValor, loc_oLookup, loc_oErro, loc_lContinuar
        IF par_nKeyCode != 13 AND par_nKeyCode != 9 AND par_nKeyCode != 115
            RETURN
        ENDIF

        loc_cValor     = ALLTRIM(THIS.txt_4c_Conta.Value)
        loc_lContinuar = !EMPTY(loc_cValor)

        TRY
            IF !loc_lContinuar
                THIS.txt_4c_Dconta.Value = ""
                THIS.this_oBusinessObject.this_cConta  = ""
                THIS.this_oBusinessObject.this_cDconta = ""
            ELSE
                IF !USED("TmpCli")
                    IF !THIS.this_oBusinessObject.CarregarContas()
                        loc_lContinuar = .F.
                    ENDIF
                ENDIF

                IF loc_lContinuar
                    IF SEEK(loc_cValor, "TmpCli", "BalCodigo")
                        THIS.txt_4c_Conta.Value  = ALLTRIM(TmpCli.IClis)
                        THIS.txt_4c_Dconta.Value = ALLTRIM(TmpCli.RClis)
                        IF EMPTY(ALLTRIM(THIS.txt_4c_Grupo.Value))
                            THIS.txt_4c_Grupo.Value = ALLTRIM(TmpCli.Grupos)
                        ENDIF
                    ELSE
                        loc_oLookup = CREATEOBJECT("FormBuscaAuxiliar", "TmpCli", "IClis", ;
                            "Cadastro de Contas")
                        IF VARTYPE(loc_oLookup) = "O"
                            loc_oLookup.mAddColuna("IClis",  "", "C" + CHR(243) + "digo")
                            loc_oLookup.mAddColuna("RClis",  "", "Descri" + CHR(231) + CHR(227) + "o")
                            loc_oLookup.mAddColuna("Grupos", "", "Grupo")
                            loc_oLookup.Show()
                            IF loc_oLookup.this_lSelecionou
                                THIS.txt_4c_Conta.Value  = ALLTRIM(TmpCli.IClis)
                                THIS.txt_4c_Dconta.Value = ALLTRIM(TmpCli.RClis)
                                IF EMPTY(ALLTRIM(THIS.txt_4c_Grupo.Value))
                                    THIS.txt_4c_Grupo.Value = ALLTRIM(TmpCli.Grupos)
                                ENDIF
                            ELSE
                                THIS.txt_4c_Conta.Value  = ""
                                THIS.txt_4c_Dconta.Value = ""
                            ENDIF
                            loc_oLookup = .NULL.
                        ENDIF
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro na busca de conta")
        ENDTRY

        THIS.txt_4c_Conta.Refresh()
        THIS.txt_4c_Dconta.Refresh()
        THIS.txt_4c_Grupo.Refresh()
        THIS.this_oBusinessObject.this_cConta  = ALLTRIM(THIS.txt_4c_Conta.Value)
        THIS.this_oBusinessObject.this_cDconta = ALLTRIM(THIS.txt_4c_Dconta.Value)
        THIS.this_oBusinessObject.this_cGrupo  = ALLTRIM(THIS.txt_4c_Grupo.Value)
        THIS.AtualizarEstadoCampos()
    ENDPROC

    *==========================================================================
    * TxtDContaKeyPress - Lookup de Conta por descricao em TmpCli (RClis)
    * Ativo apenas quando txt_4c_Conta vazio (When legado)
    *==========================================================================
    PROCEDURE TxtDContaKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_cValor, loc_oLookup, loc_oErro, loc_lContinuar
        IF par_nKeyCode != 13 AND par_nKeyCode != 9 AND par_nKeyCode != 115
            RETURN
        ENDIF

        IF !EMPTY(ALLTRIM(THIS.txt_4c_Conta.Value))
            RETURN
        ENDIF

        loc_cValor     = ALLTRIM(THIS.txt_4c_Dconta.Value)
        loc_lContinuar = .T.

        TRY
            IF !USED("TmpCli")
                IF !THIS.this_oBusinessObject.CarregarContas()
                    loc_lContinuar = .F.
                ENDIF
            ENDIF

            IF loc_lContinuar
                IF !EMPTY(loc_cValor) AND SEEK(loc_cValor, "TmpCli", "BalNome")
                    THIS.txt_4c_Conta.Value  = ALLTRIM(TmpCli.IClis)
                    THIS.txt_4c_Dconta.Value = ALLTRIM(TmpCli.RClis)
                    IF EMPTY(ALLTRIM(THIS.txt_4c_Grupo.Value))
                        THIS.txt_4c_Grupo.Value = ALLTRIM(TmpCli.Grupos)
                    ENDIF
                ELSE
                    loc_oLookup = CREATEOBJECT("FormBuscaAuxiliar", "TmpCli", "RClis", ;
                        "Cadastro de Contas")
                    IF VARTYPE(loc_oLookup) = "O"
                        loc_oLookup.mAddColuna("RClis",  "", "Descri" + CHR(231) + CHR(227) + "o")
                        loc_oLookup.mAddColuna("IClis",  "", "C" + CHR(243) + "digo")
                        loc_oLookup.mAddColuna("Grupos", "", "Grupo")
                        loc_oLookup.Show()
                        IF loc_oLookup.this_lSelecionou
                            THIS.txt_4c_Conta.Value  = ALLTRIM(TmpCli.IClis)
                            THIS.txt_4c_Dconta.Value = ALLTRIM(TmpCli.RClis)
                            IF EMPTY(ALLTRIM(THIS.txt_4c_Grupo.Value))
                                THIS.txt_4c_Grupo.Value = ALLTRIM(TmpCli.Grupos)
                            ENDIF
                        ELSE
                            THIS.txt_4c_Conta.Value = ""
                        ENDIF
                        loc_oLookup = .NULL.
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro na busca de descri" + CHR(231) + CHR(227) + "o de conta")
        ENDTRY

        THIS.txt_4c_Conta.Refresh()
        THIS.txt_4c_Dconta.Refresh()
        THIS.txt_4c_Grupo.Refresh()
        THIS.this_oBusinessObject.this_cConta  = ALLTRIM(THIS.txt_4c_Conta.Value)
        THIS.this_oBusinessObject.this_cDconta = ALLTRIM(THIS.txt_4c_Dconta.Value)
        THIS.this_oBusinessObject.this_cGrupo  = ALLTRIM(THIS.txt_4c_Grupo.Value)
        THIS.AtualizarEstadoCampos()
    ENDPROC

    *==========================================================================
    * TxtLinhaDblClick - DblClick em txt_4c_Linha abre busca de linha
    *==========================================================================
    PROCEDURE TxtLinhaDblClick()
        THIS.AbrirBuscaLinha(.F.)
    ENDPROC

    *==========================================================================
    * TxtDLinhaDblClick - DblClick em txt_4c_DLinha abre busca por descricao
    * Ativo apenas quando txt_4c_Linha estiver vazio
    *==========================================================================
    PROCEDURE TxtDLinhaDblClick()
        IF EMPTY(ALLTRIM(THIS.txt_4c_Linha.Value))
            THIS.AbrirBuscaLinha(.T.)
        ENDIF
    ENDPROC

    *==========================================================================
    * TxtGrupoDblClick - DblClick abre busca de grupo contabil (TmpGccr)
    * Abre lookup diretamente sem verificar valor preenchido
    *==========================================================================
    PROCEDURE TxtGrupoDblClick()
        LOCAL loc_oLookup, loc_oErro
        TRY
            IF !USED("TmpGccr")
                IF !THIS.this_oBusinessObject.CarregarGruposContabeis()
                    RETURN
                ENDIF
            ENDIF

            loc_oLookup = CREATEOBJECT("FormBuscaAuxiliar", "TmpGccr", "Codigos", ;
                "Sele" + CHR(231) + CHR(227) + "o de Grupo")
            IF VARTYPE(loc_oLookup) = "O"
                loc_oLookup.mAddColuna("Codigos", "", "C" + CHR(243) + "digo")
                loc_oLookup.mAddColuna("Descrs",  "", "Descri" + CHR(231) + CHR(227) + "o")
                loc_oLookup.Show()
                IF loc_oLookup.this_lSelecionou
                    THIS.txt_4c_Grupo.Value = ALLTRIM(TmpGccr.Codigos)
                ENDIF
                loc_oLookup = .NULL.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro na busca de grupo")
        ENDTRY

        THIS.txt_4c_Grupo.Refresh()
        THIS.this_oBusinessObject.this_cGrupo = ALLTRIM(THIS.txt_4c_Grupo.Value)
    ENDPROC

    *==========================================================================
    * TxtContaDblClick - DblClick abre busca de conta em TmpCli (por IClis)
    * Abre lookup diretamente sem verificar valor preenchido
    *==========================================================================
    PROCEDURE TxtContaDblClick()
        LOCAL loc_oLookup, loc_oErro
        TRY
            IF !USED("TmpCli")
                IF !THIS.this_oBusinessObject.CarregarContas()
                    RETURN
                ENDIF
            ENDIF

            loc_oLookup = CREATEOBJECT("FormBuscaAuxiliar", "TmpCli", "IClis", ;
                "Cadastro de Contas")
            IF VARTYPE(loc_oLookup) = "O"
                loc_oLookup.mAddColuna("IClis",  "", "C" + CHR(243) + "digo")
                loc_oLookup.mAddColuna("RClis",  "", "Descri" + CHR(231) + CHR(227) + "o")
                loc_oLookup.mAddColuna("Grupos", "", "Grupo")
                loc_oLookup.Show()
                IF loc_oLookup.this_lSelecionou
                    THIS.txt_4c_Conta.Value  = ALLTRIM(TmpCli.IClis)
                    THIS.txt_4c_Dconta.Value = ALLTRIM(TmpCli.RClis)
                    IF EMPTY(ALLTRIM(THIS.txt_4c_Grupo.Value))
                        THIS.txt_4c_Grupo.Value = ALLTRIM(TmpCli.Grupos)
                    ENDIF
                ENDIF
                loc_oLookup = .NULL.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro na busca de conta")
        ENDTRY

        THIS.txt_4c_Conta.Refresh()
        THIS.txt_4c_Dconta.Refresh()
        THIS.txt_4c_Grupo.Refresh()
        THIS.this_oBusinessObject.this_cConta  = ALLTRIM(THIS.txt_4c_Conta.Value)
        THIS.this_oBusinessObject.this_cDconta = ALLTRIM(THIS.txt_4c_Dconta.Value)
        THIS.this_oBusinessObject.this_cGrupo  = ALLTRIM(THIS.txt_4c_Grupo.Value)
        THIS.AtualizarEstadoCampos()
    ENDPROC

    *==========================================================================
    * TxtDContaDblClick - DblClick abre busca de conta por descricao (RClis)
    * Ativo apenas quando txt_4c_Conta estiver vazio
    *==========================================================================
    PROCEDURE TxtDContaDblClick()
        IF !EMPTY(ALLTRIM(THIS.txt_4c_Conta.Value))
            RETURN
        ENDIF

        LOCAL loc_oLookup, loc_oErro
        TRY
            IF !USED("TmpCli")
                IF !THIS.this_oBusinessObject.CarregarContas()
                    RETURN
                ENDIF
            ENDIF

            loc_oLookup = CREATEOBJECT("FormBuscaAuxiliar", "TmpCli", "RClis", ;
                "Cadastro de Contas")
            IF VARTYPE(loc_oLookup) = "O"
                loc_oLookup.mAddColuna("RClis",  "", "Descri" + CHR(231) + CHR(227) + "o")
                loc_oLookup.mAddColuna("IClis",  "", "C" + CHR(243) + "digo")
                loc_oLookup.mAddColuna("Grupos", "", "Grupo")
                loc_oLookup.Show()
                IF loc_oLookup.this_lSelecionou
                    THIS.txt_4c_Conta.Value  = ALLTRIM(TmpCli.IClis)
                    THIS.txt_4c_Dconta.Value = ALLTRIM(TmpCli.RClis)
                    IF EMPTY(ALLTRIM(THIS.txt_4c_Grupo.Value))
                        THIS.txt_4c_Grupo.Value = ALLTRIM(TmpCli.Grupos)
                    ENDIF
                ENDIF
                loc_oLookup = .NULL.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro na busca de descri" + CHR(231) + CHR(227) + "o de conta")
        ENDTRY

        THIS.txt_4c_Conta.Refresh()
        THIS.txt_4c_Dconta.Refresh()
        THIS.txt_4c_Grupo.Refresh()
        THIS.this_oBusinessObject.this_cConta  = ALLTRIM(THIS.txt_4c_Conta.Value)
        THIS.this_oBusinessObject.this_cDconta = ALLTRIM(THIS.txt_4c_Dconta.Value)
        THIS.this_oBusinessObject.this_cGrupo  = ALLTRIM(THIS.txt_4c_Grupo.Value)
        THIS.AtualizarEstadoCampos()
    ENDPROC

    *==========================================================================
    * BtnIncluirClick - Form OPERACIONAL: equivale a iniciar nova entrada.
    * SIGPDMFA original NAO tem botoes CRUD (Incluir/Alterar/Visualizar/Excluir).
    * O fluxo unico eh preencher Linha+OP+Grupo+Conta e clicar Processar.
    * Este metodo existe por compatibilidade com a pipeline e foi mapeado para
    * a operacao equivalente: limpar todos os campos e posicionar foco no
    * primeiro campo para nova entrada de dados (Linha).
    *==========================================================================
    PROCEDURE BtnIncluirClick()
        *-- Limpa todos os campos para uma nova entrada de dados
        THIS.txt_4c_Linha.Value  = ""
        THIS.txt_4c_DLinha.Value = ""
        THIS.txt_4c_Op.Value     = 0
        THIS.txt_4c_Grupo.Value  = ""
        THIS.txt_4c_Conta.Value  = ""
        THIS.txt_4c_Dconta.Value = ""

        *-- Limpa BO em memoria
        THIS.this_oBusinessObject.this_cLinha  = ""
        THIS.this_oBusinessObject.this_cDLinha = ""
        THIS.this_oBusinessObject.this_nOp     = 0
        THIS.this_oBusinessObject.this_cGrupo  = ""
        THIS.this_oBusinessObject.this_cConta  = ""
        THIS.this_oBusinessObject.this_cDconta = ""

        *-- Refresca controles e ajusta Enabled de DLinha/Dconta
        THIS.txt_4c_Linha.Refresh()
        THIS.txt_4c_DLinha.Refresh()
        THIS.txt_4c_Op.Refresh()
        THIS.txt_4c_Grupo.Refresh()
        THIS.txt_4c_Conta.Refresh()
        THIS.txt_4c_Dconta.Refresh()
        THIS.AtualizarEstadoCampos()

        *-- Posiciona foco no primeiro campo
        THIS.txt_4c_Linha.SetFocus()
    ENDPROC

    *==========================================================================
    * BtnAlterarClick - Form OPERACIONAL: nao ha registros para alterar.
    * SIGPDMFA processa OPs em tempo real (gera movimentacao em SigPdMvf) e
    * nao mantem cadastro proprio. Mapeado para reposicionar foco no campo
    * que precisa de ajuste (txt_4c_Linha), permitindo que o usuario revise
    * os valores informados antes de clicar Processar.
    *==========================================================================
    PROCEDURE BtnAlterarClick()
        *-- Permite ao usuario revisar/alterar os valores antes de processar
        THIS.txt_4c_Linha.Refresh()
        THIS.txt_4c_DLinha.Refresh()
        THIS.txt_4c_Op.Refresh()
        THIS.txt_4c_Grupo.Refresh()
        THIS.txt_4c_Conta.Refresh()
        THIS.txt_4c_Dconta.Refresh()
        THIS.AtualizarEstadoCampos()
        THIS.txt_4c_Linha.SetFocus()
    ENDPROC

    *==========================================================================
    * BtnVisualizarClick - Form OPERACIONAL: nao ha modo visualizacao.
    * SIGPDMFA nao expoe registros em grid; usuario informa parametros e o
    * processamento gera movimentacao diretamente. Mapeado para refrescar
    * os controles (refletindo estado atual do BO) e posicionar o foco no
    * botao Processar, simulando a transicao para "ver o que sera processado".
    *==========================================================================
    PROCEDURE BtnVisualizarClick()
        THIS.txt_4c_Linha.Refresh()
        THIS.txt_4c_DLinha.Refresh()
        THIS.txt_4c_Op.Refresh()
        THIS.txt_4c_Grupo.Refresh()
        THIS.txt_4c_Conta.Refresh()
        THIS.txt_4c_Dconta.Refresh()
        THIS.AtualizarEstadoCampos()

        IF PEMSTATUS(THIS, "cmd_4c_Processa", 5) AND THIS.cmd_4c_Processa.Enabled
            THIS.cmd_4c_Processa.SetFocus()
        ENDIF
    ENDPROC

    *==========================================================================
    * BtnExcluirClick - Form OPERACIONAL: nao ha exclusao de registros.
    * SIGPDMFA nao tem cadastro proprio (apenas gera movimentacao em SigPdMvf
    * via Processar). Mapeado para descartar os valores digitados nos campos,
    * voltando ao estado inicial. Equivalente funcional de "cancelar entrada
    * em andamento", sem afetar nenhum registro no banco.
    *==========================================================================
    PROCEDURE BtnExcluirClick()
        LOCAL loc_lConfirma
        loc_lConfirma = MsgConfirma("Descartar valores informados?", ;
                                     "Confirma" + CHR(231) + CHR(227) + "o")

        IF !loc_lConfirma
            RETURN
        ENDIF

        *-- Limpa campos do form
        THIS.txt_4c_Linha.Value  = ""
        THIS.txt_4c_DLinha.Value = ""
        THIS.txt_4c_Op.Value     = 0
        THIS.txt_4c_Grupo.Value  = ""
        THIS.txt_4c_Conta.Value  = ""
        THIS.txt_4c_Dconta.Value = ""

        *-- Limpa BO em memoria
        THIS.this_oBusinessObject.this_cLinha  = ""
        THIS.this_oBusinessObject.this_cDLinha = ""
        THIS.this_oBusinessObject.this_nOp     = 0
        THIS.this_oBusinessObject.this_cGrupo  = ""
        THIS.this_oBusinessObject.this_cConta  = ""
        THIS.this_oBusinessObject.this_cDconta = ""

        THIS.txt_4c_Linha.Refresh()
        THIS.txt_4c_DLinha.Refresh()
        THIS.txt_4c_Op.Refresh()
        THIS.txt_4c_Grupo.Refresh()
        THIS.txt_4c_Conta.Refresh()
        THIS.txt_4c_Dconta.Refresh()
        THIS.AtualizarEstadoCampos()
        THIS.txt_4c_Linha.SetFocus()
    ENDPROC

    *==========================================================================
    * BtnProcessaClick - Coleta campos, chama ProcessarMudancaFase no BO,
    * exibe Aguarde durante o processamento e limpa campos ao concluir.
    *==========================================================================
    PROCEDURE BtnProcessaClick()
        LOCAL loc_lSucesso, loc_oErro

        *-- Popula BO com valores atuais dos campos (fora do TRY: RETURN permitido)
        THIS.this_oBusinessObject.this_cLinha  = ALLTRIM(THIS.txt_4c_Linha.Value)
        THIS.this_oBusinessObject.this_cDLinha = ALLTRIM(THIS.txt_4c_DLinha.Value)
        THIS.this_oBusinessObject.this_nOp     = THIS.txt_4c_Op.Value
        THIS.this_oBusinessObject.this_cGrupo  = ALLTRIM(THIS.txt_4c_Grupo.Value)
        THIS.this_oBusinessObject.this_cConta  = ALLTRIM(THIS.txt_4c_Conta.Value)
        THIS.this_oBusinessObject.this_cDconta = ALLTRIM(THIS.txt_4c_Dconta.Value)

        *-- Validacoes rapidas (fora do TRY para RETURN direto)
        IF EMPTY(THIS.this_oBusinessObject.this_cLinha)
            MsgAviso(CHR(201) + " Obrigat" + CHR(243) + "rio Informar a Linha!!!", ;
                     "Valida" + CHR(231) + CHR(227) + CHR(227) + "o")
            THIS.txt_4c_Linha.SetFocus()
            RETURN
        ENDIF

        IF THIS.this_oBusinessObject.this_nOp = 0
            MsgAviso(CHR(201) + " Obrigat" + CHR(243) + "rio Informar a Op!!!", ;
                     "Valida" + CHR(231) + CHR(227) + CHR(227) + "o")
            THIS.txt_4c_Op.SetFocus()
            RETURN
        ENDIF

        IF EMPTY(THIS.this_oBusinessObject.this_cGrupo)
            MsgAviso(CHR(201) + " Obrigat" + CHR(243) + "rio Informar o Grupo!!!", ;
                     "Valida" + CHR(231) + CHR(227) + CHR(227) + "o")
            THIS.txt_4c_Grupo.SetFocus()
            RETURN
        ENDIF

        IF EMPTY(THIS.this_oBusinessObject.this_cConta)
            MsgAviso(CHR(201) + " Obrigat" + CHR(243) + "rio Informar a Conta!!!", ;
                     "Valida" + CHR(231) + CHR(227) + CHR(227) + "o")
            THIS.txt_4c_Conta.SetFocus()
            RETURN
        ENDIF

        *-- Exibe Aguarde e processa
        THIS.cnt_4c_Aguarde.ZOrder(0)
        THIS.cnt_4c_Aguarde.Visible = .T.
        THIS.Refresh()

        loc_lSucesso = .F.

        TRY
            loc_lSucesso = THIS.this_oBusinessObject.ProcessarMudancaFase()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro no processamento")
        ENDTRY

        THIS.cnt_4c_Aguarde.Visible = .F.

        IF loc_lSucesso
            MsgInfo("Processamento Finalizado...")
            *-- Limpa todos os campos para nova entrada
            THIS.txt_4c_Linha.Value  = ""
            THIS.txt_4c_DLinha.Value = ""
            THIS.txt_4c_Op.Value     = 0
            THIS.txt_4c_Grupo.Value  = ""
            THIS.txt_4c_Conta.Value  = ""
            THIS.txt_4c_Dconta.Value = ""
            THIS.txt_4c_Linha.Refresh()
            THIS.txt_4c_DLinha.Refresh()
            THIS.txt_4c_Op.Refresh()
            THIS.txt_4c_Grupo.Refresh()
            THIS.txt_4c_Conta.Refresh()
            THIS.txt_4c_Dconta.Refresh()
            THIS.AtualizarEstadoCampos()
            THIS.txt_4c_Linha.SetFocus()
        ENDIF

        THIS.Refresh()
    ENDPROC

    *==========================================================================
    * BtnCancelaClick - Encerra o formulario
    *==========================================================================
    PROCEDURE BtnCancelaClick()
        THIS.Release()
    ENDPROC

    *==========================================================================
    * FormParaBO - Transfere valores dos campos do form para o BO
    *==========================================================================
    PROCEDURE FormParaBO()
        THIS.this_oBusinessObject.this_cLinha  = ALLTRIM(THIS.txt_4c_Linha.Value)
        THIS.this_oBusinessObject.this_cDLinha = ALLTRIM(THIS.txt_4c_DLinha.Value)
        THIS.this_oBusinessObject.this_nOp     = THIS.txt_4c_Op.Value
        THIS.this_oBusinessObject.this_cGrupo  = ALLTRIM(THIS.txt_4c_Grupo.Value)
        THIS.this_oBusinessObject.this_cConta  = ALLTRIM(THIS.txt_4c_Conta.Value)
        THIS.this_oBusinessObject.this_cDconta = ALLTRIM(THIS.txt_4c_Dconta.Value)
    ENDPROC

    *==========================================================================
    * BOParaForm - Transfere propriedades do BO de volta para os campos do form
    *==========================================================================
    PROCEDURE BOParaForm()
        THIS.txt_4c_Linha.Value  = THIS.this_oBusinessObject.this_cLinha
        THIS.txt_4c_DLinha.Value = THIS.this_oBusinessObject.this_cDLinha
        THIS.txt_4c_Op.Value     = THIS.this_oBusinessObject.this_nOp
        THIS.txt_4c_Grupo.Value  = THIS.this_oBusinessObject.this_cGrupo
        THIS.txt_4c_Conta.Value  = THIS.this_oBusinessObject.this_cConta
        THIS.txt_4c_Dconta.Value = THIS.this_oBusinessObject.this_cDconta
        THIS.AtualizarEstadoCampos()
        THIS.Refresh()
    ENDPROC

    *==========================================================================
    * LimparCampos - Limpa todos os campos e reseta o BO
    *==========================================================================
    PROCEDURE LimparCampos()
        THIS.txt_4c_Linha.Value  = ""
        THIS.txt_4c_DLinha.Value = ""
        THIS.txt_4c_Op.Value     = 0
        THIS.txt_4c_Grupo.Value  = ""
        THIS.txt_4c_Conta.Value  = ""
        THIS.txt_4c_Dconta.Value = ""
        THIS.this_oBusinessObject.this_cLinha  = ""
        THIS.this_oBusinessObject.this_cDLinha = ""
        THIS.this_oBusinessObject.this_nOp     = 0
        THIS.this_oBusinessObject.this_cGrupo  = ""
        THIS.this_oBusinessObject.this_cConta  = ""
        THIS.this_oBusinessObject.this_cDconta = ""
        THIS.AtualizarEstadoCampos()
        THIS.Refresh()
    ENDPROC

    *==========================================================================
    * HabilitarCampos - Habilita ou desabilita campos de entrada
    * Em form OPERACIONAL, DLinha e Dconta tem regra propria (AtualizarEstadoCampos)
    *==========================================================================
    PROTECTED PROCEDURE HabilitarCampos(par_lHabilitar)
        THIS.txt_4c_Linha.Enabled    = par_lHabilitar
        THIS.txt_4c_Op.Enabled       = par_lHabilitar
        THIS.txt_4c_Grupo.Enabled    = par_lHabilitar
        THIS.txt_4c_Conta.Enabled    = par_lHabilitar
        THIS.cmd_4c_Processa.Enabled = par_lHabilitar

        IF par_lHabilitar
            THIS.AtualizarEstadoCampos()
        ELSE
            THIS.txt_4c_DLinha.Enabled  = .F.
            THIS.txt_4c_Dconta.Enabled  = .F.
        ENDIF

        THIS.Refresh()
    ENDPROC

    *==========================================================================
    * CarregarLista - Form OPERACIONAL nao tem grid de registros.
    * Recarrega os cursores de lookup (parametros, grupos, contas).
    *==========================================================================
    PROCEDURE CarregarLista()
        IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
            RETURN .T.
        ENDIF
        RETURN THIS.this_oBusinessObject.CarregarParametros()
    ENDPROC

    *==========================================================================
    * AjustarBotoesPorModo - Form OPERACIONAL nao tem modos CRUD.
    * Garante que cmd_4c_Processa e cmd_4c_Cancela estao habilitados.
    *==========================================================================
    PROTECTED PROCEDURE AjustarBotoesPorModo()
        IF PEMSTATUS(THIS, "cmd_4c_Processa", 5)
            THIS.cmd_4c_Processa.Enabled = .T.
        ENDIF
        IF PEMSTATUS(THIS, "cmd_4c_Cancela", 5)
            THIS.cmd_4c_Cancela.Enabled = .T.
        ENDIF
    ENDPROC

    *==========================================================================
    * BtnSalvarClick - Form OPERACIONAL: equivalente a Processar.
    * Mapeia para BtnProcessaClick para compatibilidade com pipeline CRUD.
    *==========================================================================
    PROCEDURE BtnSalvarClick()
        THIS.BtnProcessaClick()
    ENDPROC

    *==========================================================================
    * BtnCancelarClick - Encerra o formulario.
    * Mapeia para BtnCancelaClick para compatibilidade com pipeline CRUD.
    *==========================================================================
    PROCEDURE BtnCancelarClick()
        THIS.BtnCancelaClick()
    ENDPROC

    *==========================================================================
    * BtnBuscarClick - Form OPERACIONAL nao tem busca de registros em grid.
    * Limpa os campos para nova entrada de dados.
    *==========================================================================
    PROCEDURE BtnBuscarClick()
        THIS.LimparCampos()
        IF PEMSTATUS(THIS, "txt_4c_Linha", 5)
            THIS.txt_4c_Linha.SetFocus()
        ENDIF
    ENDPROC

    *==========================================================================
    * BtnEncerrarClick - Encerra o formulario.
    * Mapeia para BtnCancelaClick para compatibilidade com pipeline CRUD.
    *==========================================================================
    PROCEDURE BtnEncerrarClick()
        THIS.BtnCancelaClick()
    ENDPROC

    *==========================================================================
    * AtualizarEstadoControles - Sem estado CRUD (form operacional puro)
    *==========================================================================
    PROCEDURE AtualizarEstadoControles()
    ENDPROC

    *==========================================================================
    * Destroy - Fecha cursores de lookup e libera BO
    *==========================================================================
    PROCEDURE Destroy()
        LOCAL loc_oErro
        TRY
            IF USED("TmpGccr")
                USE IN TmpGccr
            ENDIF
            IF USED("TmpCli")
                USE IN TmpCli
            ENDIF

            IF VARTYPE(THIS.this_oBusinessObject) = "O"
                THIS.this_oBusinessObject = .NULL.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao encerrar FormSigPdMfa")
        ENDTRY

        DODEFAULT()
    ENDPROC

ENDDEFINE


### BO (C:\4c\projeto\app\classes\SigPdMfaBO.prg):
*------------------------------------------------------------------------------
* SigPdMfaBO.prg - Business Object para Mudanca de Fase Automatica
* Herda de: BusinessBase
* Tabela principal: SigPdMvf
* Chave: cIdChaves
*------------------------------------------------------------------------------
DEFINE CLASS SigPdMfaBO AS BusinessBase

    *-- Campos de entrada do formulario
    this_cLinha      = ""
    this_cDLinha     = ""
    this_nOp         = 0
    this_cGrupo      = ""
    this_cConta      = ""
    this_cDconta     = ""

    *-- Chave e parametros do sistema
    this_cSigKey      = ""
    this_cDopEntAuts  = ""
    this_cDoppPads    = ""
    this_cDoppServs   = ""

    *-- Contador interno para gerar cIdChaves unicas por execucao
    this_nSeqContador = 0

    *--------------------------------------------------------------------------
    * Init - Configura tabela e chave primaria
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        THIS.this_cTabela     = "SigPdMvf"
        THIS.this_cCampoChave = "cIdChaves"
        RETURN DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Retorna a chave primaria corrente
    *--------------------------------------------------------------------------
    FUNCTION ObterChavePrimaria()
        RETURN THIS.this_cSigKey
    ENDFUNC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Mapeia campos do cursor para propriedades do BO
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        IF USED(par_cAliasCursor)
            SELECT (par_cAliasCursor)
            THIS.this_cGrupo  = TratarNulo(Grupods,   "C")
            THIS.this_cConta  = TratarNulo(Contads,   "C")
            THIS.this_nOp     = TratarNulo(NOps,      "N")
            THIS.this_cSigKey = TratarNulo(cIdChaves, "C")
            RETURN .T.
        ENDIF
        RETURN .F.
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarDados - Valida campos obrigatorios antes do processamento
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ValidarDados()
        IF EMPTY(ALLTRIM(THIS.this_cLinha))
            MsgAviso(CHR(201) + " Obrigat" + CHR(243) + "rio Informar a Linha!!!", ;
                     "Valida" + CHR(231) + CHR(227) + CHR(227) + "o")
            RETURN .F.
        ENDIF

        IF THIS.this_nOp = 0
            MsgAviso(CHR(201) + " Obrigat" + CHR(243) + "rio Informar a O.P.!!!", ;
                     "Valida" + CHR(231) + CHR(227) + CHR(227) + "o")
            RETURN .F.
        ENDIF

        IF EMPTY(ALLTRIM(THIS.this_cGrupo))
            MsgAviso(CHR(201) + " Obrigat" + CHR(243) + "rio Informar o Grupo!!!", ;
                     "Valida" + CHR(231) + CHR(227) + CHR(227) + "o")
            RETURN .F.
        ENDIF

        IF EMPTY(ALLTRIM(THIS.this_cConta))
            MsgAviso(CHR(201) + " Obrigat" + CHR(243) + "rio Informar a Conta!!!", ;
                     "Valida" + CHR(231) + CHR(227) + CHR(227) + "o")
            RETURN .F.
        ENDIF

        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarParametros - Carrega SigKeys de SigCdPac e params de SigCdPam
    *--------------------------------------------------------------------------
    PROCEDURE CarregarParametros()
        LOCAL loc_lSucesso, loc_cSQL, loc_oErro
        loc_lSucesso = .F.

        TRY
            *-- SigKeys de SigCdPac
            loc_cSQL = "SELECT TOP 1 SigKeys FROM SigCdPac"
            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_SigCdPac") > 0
                SELECT cursor_4c_SigCdPac
                THIS.this_cSigKey = TratarNulo(SigKeys, "C")
                USE IN cursor_4c_SigCdPac
            ENDIF

            *-- Parametros operacionais de SigCdPam
            loc_cSQL = "SELECT TOP 1 DopEntAuts, DoppPads, DoppServs FROM SigCdPam"
            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_SigCdPam") > 0
                SELECT cursor_4c_SigCdPam
                THIS.this_cDopEntAuts = TratarNulo(DopEntAuts, "C")
                THIS.this_cDoppPads   = TratarNulo(DoppPads,   "C")
                THIS.this_cDoppServs  = TratarNulo(DoppServs,  "C")
                USE IN cursor_4c_SigCdPam
            ENDIF

            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao carregar par" + CHR(226) + "metros")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarGruposContabeis - Carrega TmpGccr de SigCdGcr (GerBals=1)
    * Retorna .T. se cursor criado com sucesso
    *--------------------------------------------------------------------------
    PROCEDURE CarregarGruposContabeis()
        LOCAL loc_lSucesso, loc_cSQL, loc_oErro
        loc_lSucesso = .F.

        TRY
            IF USED("TmpGccr")
                USE IN TmpGccr
            ENDIF

            loc_cSQL = "SELECT Codigos, Descrs FROM SigCdGcr WHERE GerBals = 1"

            IF SQLEXEC(gnConnHandle, loc_cSQL, "TmpGccr") < 1
                MsgErro("Falha ao carregar grupos cont" + CHR(225) + "beis (TmpGccr)", "Erro")
            ELSE
                SELECT TmpGccr
                INDEX ON Codigos TAG BalCodigo
                INDEX ON Descrs  TAG BalDescrs
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao carregar grupos contab" + CHR(233) + "is")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarContas - Carrega TmpCli de SigCdCli (GerBals=1)
    * Retorna .T. se cursor criado com sucesso
    *--------------------------------------------------------------------------
    PROCEDURE CarregarContas()
        LOCAL loc_lSucesso, loc_cSQL, loc_oErro
        loc_lSucesso = .F.

        TRY
            IF USED("TmpCli")
                USE IN TmpCli
            ENDIF

            loc_cSQL = "SELECT IClis, RClis, Grupos, Inativas FROM SigCdCli WHERE GerBals = 1"

            IF SQLEXEC(gnConnHandle, loc_cSQL, "TmpCli") < 1
                MsgErro("Falha ao carregar contas (TmpCli)", "Erro")
            ELSE
                SELECT TmpCli
                INDEX ON IClis TAG IClis
                INDEX ON IClis TAG BalCodigo
                INDEX ON RClis TAG BalNome
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao carregar contas")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * GerarNumBatch - Gera numero sequencial para o batch (Numps)
    *   Equivalente a fGerUniqueKey(lcDop + _Empr) do legado
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION GerarNumBatch(par_cDop, par_cEmpr)
        LOCAL loc_nChave, loc_cSQL, loc_oErro
        loc_nChave = 1

        TRY
            loc_cSQL = "SELECT ISNULL(MAX(Numps), 0) + 1 AS nProxChave " + ;
                       "FROM SigCdNec " + ;
                       "WHERE Emps  = " + EscaparSQL(par_cEmpr) + ;
                       "  AND Dopps = " + EscaparSQL(ALLTRIM(par_cDop))

            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_NumBatch") > 0
                SELECT cursor_4c_NumBatch
                loc_nChave = NVL(nProxChave, 1)
                USE IN cursor_4c_NumBatch
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao gerar n" + CHR(250) + "mero de batch")
        ENDTRY

        RETURN loc_nChave
    ENDFUNC

    *--------------------------------------------------------------------------
    * GerarIdChaves - Gera cIdChaves unico de 20 chars para cada registro
    *   Equivalente a Dtos(Date())+Transform(fGerUniqueKey(...), "@L 999999")+SigKey
    *   par_nBatch: numero do batch (Numps), usado para garantir unicidade inter-batch
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION GerarIdChaves(par_nBatch)
        THIS.this_nSeqContador = THIS.this_nSeqContador + 1

        LOCAL loc_cId, loc_nChaveSeq
        *-- Combina batch e contador para 6 digitos: batch ate 9999, contador ate 99
        loc_nChaveSeq = par_nBatch * 100 + THIS.this_nSeqContador
        loc_cId = DTOS(DATE()) + ;
                  TRANSFORM(loc_nChaveSeq, "@L 999999") + ;
                  LEFT(ALLTRIM(THIS.this_cSigKey) + SPACE(6), 6)

        RETURN LEFT(loc_cId + SPACE(20), 20)
    ENDFUNC

    *--------------------------------------------------------------------------
    * ProcessarMudancaFase - Logica principal equivalente ao Processa.Click
    *   Busca OPs na faixa, verifica condicoes em SigCdNec e gera movimentacao
    *--------------------------------------------------------------------------
    PROCEDURE ProcessarMudancaFase()
        LOCAL loc_lSucesso, loc_lContinuar, loc_oErro
        LOCAL loc_cLinha, loc_cGrupo, loc_cConta, loc_nOp
        LOCAL loc_cDop, loc_cOperacao, loc_cServico
        LOCAL loc_nOpI, loc_nOpF
        LOCAL loc_cGruOrigs, loc_cConOrigs, loc_nSeqs
        LOCAL loc_lSelItem, loc_nBatch, loc_cIds
        LOCAL loc_cSQL, loc_cEmpresa, loc_cUsuario

        loc_lSucesso   = .F.
        loc_lContinuar = .T.

        TRY
            *-- Captura campos e contexto
            loc_cLinha    = ALLTRIM(THIS.this_cLinha)
            loc_cGrupo    = ALLTRIM(THIS.this_cGrupo)
            loc_cConta    = ALLTRIM(THIS.this_cConta)
            loc_nOp       = THIS.this_nOp
            loc_cEmpresa  = go_4c_Sistema.cCodEmpresa
            loc_cUsuario  = gc_4c_UsuarioLogado
            loc_cDop      = ALLTRIM(THIS.this_cDopEntAuts)
            loc_cOperacao = ALLTRIM(THIS.this_cDoppPads)
            loc_cServico  = ALLTRIM(THIS.this_cDoppServs)

            *-- Validacao obrigatoria dos campos
            IF loc_lContinuar AND !THIS.ValidarDados()
                loc_lContinuar = .F.
            ENDIF

            *-- DOP obrigatorio no cadastro de parametros
            IF loc_lContinuar AND EMPTY(loc_cDop)
                MsgAviso("Opera" + CHR(231) + CHR(227) + "o n" + CHR(227) + "o informada " + ;
                         "no cadastro de par" + CHR(226) + "metros!", "Aviso")
                loc_lContinuar = .F.
            ENDIF

            *-- Busca detalhes da operacao DOP em SigCdOpd
            IF loc_lContinuar
                loc_cSQL = "SELECT TOP 1 GruOrigs, ConOrigs, Seqs " + ;
                           "FROM SigCdOpd " + ;
                           "WHERE Dopps = " + EscaparSQL(loc_cDop)

                IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_SigCdOpd") < 1
                    MsgErro("Falha ao buscar opera" + CHR(231) + CHR(227) + "o em SigCdOpd", "Erro")
                    loc_lContinuar = .F.
                ELSE
                    SELECT cursor_4c_SigCdOpd
                    GO TOP
                    IF EOF("cursor_4c_SigCdOpd")
                        MsgAviso("Opera" + CHR(231) + CHR(227) + "o DOP n" + CHR(227) + "o encontrada: " + loc_cDop, "Aviso")
                        loc_lContinuar = .F.
                    ELSE
                        loc_cGruOrigs = TratarNulo(GruOrigs, "C")
                        loc_cConOrigs = TratarNulo(ConOrigs, "C")
                        loc_nSeqs     = TratarNulo(Seqs,     "N")
                    ENDIF
                    USE IN cursor_4c_SigCdOpd
                ENDIF
            ENDIF

            *-- Calcula faixa de numeros de OP e busca movimentos
            IF loc_lContinuar
                loc_nOpI = loc_nOp * 10000
                loc_nOpF = loc_nOp * 10000 + 9999

                loc_cSQL = "SELECT Nops, cIdChaves, Emps, Grupods, Contads, " + ;
                           "CodPds, Unids, Obsps, Ordems, Obss, NEnvs " + ;
                           "FROM SigPdMvf " + ;
                           "WHERE Nops BETWEEN " + TRANSFORM(loc_nOpI) + " AND " + TRANSFORM(loc_nOpF)

                IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_SigPdMvf") < 1
                    MsgErro("Falha ao buscar movimentos de produ" + CHR(231) + CHR(227) + "o", "Erro")
                    loc_lContinuar = .F.
                ENDIF
            ENDIF

            *-- Cria cursor de staging (equivalente ao xMFas/UpSigPdMvf do legado)
            IF loc_lContinuar
                SET NULL ON
                CREATE CURSOR cursor_4c_xMFas ( ;
                    Emps    C(6)    NULL, ;
                    CodPds  C(20)   NULL, ;
                    Unids   C(6)    NULL, ;
                    Obsps   C(40)   NULL, ;
                    Obss    C(100)  NULL, ;
                    NOps    N(10,0) NULL, ;
                    NEnvs   N(10,0) NULL, ;
                    Pesos   N(14,4) NULL, ;
                    Qtds    N(14,4) NULL, ;
                    Ordems  N(6,0)  NULL  ;
                )
                SET NULL OFF
            ENDIF

            *-- Ordena movimentos desc e processa um registro por grupo de Nops
            IF loc_lContinuar
                SELECT cursor_4c_SigPdMvf
                INDEX ON STR(Nops, 10) + cIdChaves TAG Nops
                SET ORDER TO Nops DESCENDING
                GO TOP

                loc_lSelItem = .F.

                LOCAL loc_nOpPula, loc_llPula
                LOCAL loc_cEmpMvf, loc_nNops, loc_cCodPds, loc_cGrupods, loc_cContads
                LOCAL loc_cObsps, loc_cObss, loc_nNEnvs, loc_nOrdems, loc_cUnids

                DO WHILE !EOF("cursor_4c_SigPdMvf")
                    loc_nOpPula  = cursor_4c_SigPdMvf.Nops
                    loc_llPula   = .T.

                    *-- Captura dados do primeiro registro do grupo
                    loc_cEmpMvf  = TratarNulo(cursor_4c_SigPdMvf.Emps,    "C")
                    loc_nNops    = TratarNulo(cursor_4c_SigPdMvf.Nops,    "N")
                    loc_cCodPds  = TratarNulo(cursor_4c_SigPdMvf.CodPds,  "C")
                    loc_cGrupods = TratarNulo(cursor_4c_SigPdMvf.Grupods, "C")
                    loc_cContads = TratarNulo(cursor_4c_SigPdMvf.Contads, "C")
                    loc_cObsps   = TratarNulo(cursor_4c_SigPdMvf.Obsps,   "C")
                    loc_cObss    = TratarNulo(cursor_4c_SigPdMvf.Obss,    "C")
                    loc_nNEnvs   = TratarNulo(cursor_4c_SigPdMvf.NEnvs,   "N")
                    loc_nOrdems  = TratarNulo(cursor_4c_SigPdMvf.Ordems,  "N")
                    loc_cUnids   = TratarNulo(cursor_4c_SigPdMvf.Unids,   "C")

                    *-- Verifica SigCdNec com operacao padrao (DoppPads)
                    IF !EMPTY(loc_cOperacao)
                        LOCAL loc_cEmpDNpsOp
                        loc_cEmpDNpsOp = loc_cEmpMvf + loc_cOperacao + STR(loc_nNops, 10)

                        loc_cSQL = "SELECT TOP 1 ChkSubn FROM SigCdNec " + ;
                                   "WHERE EmpDNps = " + EscaparSQL(loc_cEmpDNpsOp)

                        IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_NecOp") > 0
                            SELECT cursor_4c_NecOp
                            IF !EOF("cursor_4c_NecOp")
                                IF !NVL(ChkSubn, .F.) AND ALLTRIM(loc_cEmpMvf) = ALLTRIM(loc_cEmpresa)
                                    loc_llPula = .F.
                                ENDIF
                            ENDIF
                            USE IN cursor_4c_NecOp
                        ENDIF
                    ENDIF

                    *-- Verifica SigCdNec com operacao de servico (DoppServs)
                    IF !EMPTY(loc_cServico)
                        LOCAL loc_cEmpDNpsSvc
                        loc_cEmpDNpsSvc = loc_cEmpMvf + loc_cServico + STR(loc_nNops, 10)

                        loc_cSQL = "SELECT TOP 1 ChkSubn FROM SigCdNec " + ;
                                   "WHERE EmpDNps = " + EscaparSQL(loc_cEmpDNpsSvc)

                        IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_NecSvc") > 0
                            SELECT cursor_4c_NecSvc
                            IF !EOF("cursor_4c_NecSvc")
                                IF !NVL(ChkSubn, .F.) AND ALLTRIM(loc_cEmpMvf) = ALLTRIM(loc_cEmpresa)
                                    loc_llPula = .F.
                                ENDIF
                            ENDIF
                            USE IN cursor_4c_NecSvc
                        ENDIF
                    ENDIF

                    IF loc_llPula
                        *-- Pula todo o grupo de Nops
                        SELECT cursor_4c_SigPdMvf
                        DO WHILE !EOF("cursor_4c_SigPdMvf") AND cursor_4c_SigPdMvf.Nops = loc_nOpPula
                            SKIP
                        ENDDO
                        LOOP
                    ENDIF

                    *-- Busca dados do produto em SigCdPro
                    LOCAL loc_cLinhasPro, loc_nPesoMs
                    loc_cLinhasPro = ""
                    loc_nPesoMs    = 0

                    loc_cSQL = "SELECT TOP 1 Linhas, PesoMs FROM SigCdPro " + ;
                               "WHERE CPros = " + EscaparSQL(ALLTRIM(loc_cCodPds))

                    IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_SigCdPro") > 0
                        SELECT cursor_4c_SigCdPro
                        IF !EOF("cursor_4c_SigCdPro")
                            loc_cLinhasPro = TratarNulo(Linhas, "C")
                            loc_nPesoMs    = TratarNulo(PesoMs, "N")
                        ENDIF
                        USE IN cursor_4c_SigCdPro
                    ENDIF

                    *-- Verifica condicoes para incluir este movimento no staging
                    IF ALLTRIM(loc_cGrupods)   = ALLTRIM(loc_cGruOrigs) AND ;
                       ALLTRIM(loc_cContads)   = ALLTRIM(loc_cConOrigs) AND ;
                       ALLTRIM(loc_cEmpMvf)    = ALLTRIM(loc_cEmpresa)  AND ;
                       ALLTRIM(loc_cLinhasPro) = ALLTRIM(loc_cLinha)

                        *-- Busca quantidade total em SigOpPic para esta OP
                        LOCAL loc_nQtde, loc_nTPeso
                        loc_nQtde = 0

                        loc_cSQL = "SELECT ISNULL(SUM(Qtds), 0) AS TotalQtds " + ;
                                   "FROM SigOpPic " + ;
                                   "WHERE Nops = " + TRANSFORM(loc_nNops)

                        IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_SigOpPic") > 0
                            SELECT cursor_4c_SigOpPic
                            loc_nQtde = NVL(TotalQtds, 0)
                            USE IN cursor_4c_SigOpPic
                        ENDIF

                        loc_nTPeso = loc_nQtde * loc_nPesoMs

                        *-- Insere no cursor de staging
                        INSERT INTO cursor_4c_xMFas ( ;
                            Emps, CodPds, Unids, Obsps, Obss, ;
                            NOps, NEnvs, Pesos, Qtds, Ordems ;
                        ) VALUES ( ;
                            loc_cEmpresa, loc_cCodPds, loc_cUnids, loc_cObsps, loc_cObss, ;
                            loc_nNops, loc_nNops, loc_nTPeso, loc_nQtde, loc_nOrdems ;
                        )

                        loc_lSelItem = .T.
                    ENDIF

                    *-- Avanca ate proximo grupo de Nops
                    SELECT cursor_4c_SigPdMvf
                    DO WHILE !EOF("cursor_4c_SigPdMvf") AND cursor_4c_SigPdMvf.Nops = loc_nOpPula
                        SKIP
                    ENDDO
                ENDDO
            ENDIF

            *-- Realiza insercoes reais no banco se houver itens selecionados
            IF loc_lContinuar AND loc_lSelItem
                THIS.this_nSeqContador = 0
                loc_nBatch = THIS.GerarNumBatch(loc_cDop, loc_cEmpresa)
                loc_cIds   = THIS.GerarIdChaves(loc_nBatch)

                SQLEXEC(gnConnHandle, "BEGIN TRANSACTION")

                LOCAL loc_lTransOk
                loc_lTransOk = .T.

                *-- Insere cabecalho em SigCdNec
                loc_cSQL = "INSERT INTO SigCdNec " + ;
                           "(Emps, Dopps, Numps, Datas, Usuars, Datars, " + ;
                           " Grupoos, Contaos, Grupods, Contads, cIdChaves, EmpDNps) " + ;
                           "VALUES (" + ;
                           EscaparSQL(loc_cEmpresa) + ", " + ;
                           EscaparSQL(loc_cDop) + ", " + ;
                           TRANSFORM(loc_nBatch) + ", " + ;
                           "GETDATE(), " + ;
                           EscaparSQL(loc_cUsuario) + ", " + ;
                           "GETDATE(), " + ;
                           EscaparSQL(loc_cGruOrigs) + ", " + ;
                           EscaparSQL(loc_cConOrigs) + ", " + ;
                           EscaparSQL(loc_cGrupo) + ", " + ;
                           EscaparSQL(loc_cConta) + ", " + ;
                           EscaparSQL(loc_cIds) + ", " + ;
                           EscaparSQL(loc_cEmpresa + loc_cDop + STR(loc_nBatch, 10)) + ;
                           ")"

                IF SQLEXEC(gnConnHandle, loc_cSQL) < 1
                    MsgErro("Falha ao inserir cabecalho em SigCdNec", "Erro")
                    loc_lTransOk = .F.
                ENDIF

                *-- Processa cada item do staging e insere em SigPdMvf
                IF loc_lTransOk
                    SELECT cursor_4c_xMFas
                    GO TOP

                    LOCAL loc_nOrdem, loc_nOrdMfa, loc_cCodPdsMfa, loc_cIdsMvf
                    DO WHILE !EOF("cursor_4c_xMFas") AND loc_lTransOk
                        loc_nOrdMfa    = TratarNulo(cursor_4c_xMFas.Ordems, "N")
                        loc_cCodPdsMfa = TratarNulo(cursor_4c_xMFas.CodPds, "C")
                        loc_nOrdem     = loc_nOrdMfa

                        *-- Determina sequencia da proxima fase (SigCdPrf) se Seqs=1
                        IF loc_nSeqs = 1
                            LOCAL loc_nPOrd
                            loc_nPOrd = loc_nOrdMfa + 1

                            *-- Primeira tentativa: fase seguinte pelo Ordems
                            loc_cSQL = "SELECT TOP 1 Grupos, Ordems FROM SigCdPrf " + ;
                                       "WHERE Produtos = " + EscaparSQL(ALLTRIM(loc_cCodPdsMfa)) + ;
                                       "  AND Ordems   = " + TRANSFORM(loc_nPOrd)

                            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Prf1") > 0
                                SELECT cursor_4c_Prf1
                                IF !EOF("cursor_4c_Prf1") AND ;
                                   ALLTRIM(TratarNulo(Grupos, "C")) = ALLTRIM(loc_cGrupo)
                                    loc_nOrdem = loc_nPOrd
                                ELSE
                                    *-- Segunda tentativa: fase com filtro de grupo
                                    loc_cSQL = "SELECT TOP 1 Grupos, Ordems FROM SigCdPrf " + ;
                                               "WHERE Produtos = " + EscaparSQL(ALLTRIM(loc_cCodPdsMfa)) + ;
                                               "  AND Grupos   = " + EscaparSQL(ALLTRIM(loc_cGrupo)) + ;
                                               "  AND Ordems   = " + TRANSFORM(loc_nPOrd)

                                    IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Prf2") > 0
                                        SELECT cursor_4c_Prf2
                                        IF !EOF("cursor_4c_Prf2")
                                            IF ALLTRIM(TratarNulo(Grupos, "C")) = ALLTRIM(loc_cGrupo)
                                                loc_nOrdem = TratarNulo(Ordems, "N")
                                            ELSE
                                                loc_nOrdem = 0
                                            ENDIF
                                        ENDIF
                                        USE IN cursor_4c_Prf2
                                    ENDIF
                                ENDIF
                                USE IN cursor_4c_Prf1
                            ENDIF
                        ENDIF

                        *-- Gera cIdChaves unico para este movimento
                        loc_cIdsMvf = THIS.GerarIdChaves(loc_nBatch)

                        *-- Monta e executa INSERT em SigPdMvf
                        SELECT cursor_4c_xMFas

                        loc_cSQL = "INSERT INTO SigPdMvf " + ;
                                   "(Emps, Dopps, Numps, Datars, Datas, Usuars, " + ;
                                   " Grupoos, Contaos, Grupods, Contads, " + ;
                                   " NOps, NEnvs, Dataps, Dataes, Obss, " + ;
                                   " Codpds, Unids, Pesos, Qtds, Obsps, " + ;
                                   " Inicios, Finals, Ordems, cIdChaves, EmpDopNums, EmpDNps) " + ;
                                   "VALUES (" + ;
                                   EscaparSQL(loc_cEmpresa) + ", " + ;
                                   EscaparSQL(loc_cDop) + ", " + ;
                                   TRANSFORM(loc_nBatch) + ", " + ;
                                   "GETDATE(), GETDATE(), " + ;
                                   EscaparSQL(loc_cUsuario) + ", " + ;
                                   EscaparSQL(loc_cGruOrigs) + ", " + ;
                                   EscaparSQL(loc_cConOrigs) + ", " + ;
                                   EscaparSQL(loc_cGrupo) + ", " + ;
                                   EscaparSQL(loc_cConta) + ", " + ;
                                   TRANSFORM(TratarNulo(cursor_4c_xMFas.NOps,   "N")) + ", " + ;
                                   TRANSFORM(TratarNulo(cursor_4c_xMFas.NEnvs,  "N")) + ", " + ;
                                   "GETDATE(), NULL, " + ;
                                   EscaparSQL(TratarNulo(cursor_4c_xMFas.Obss,  "C")) + ", " + ;
                                   EscaparSQL(TratarNulo(cursor_4c_xMFas.CodPds,"C")) + ", " + ;
                                   EscaparSQL(TratarNulo(cursor_4c_xMFas.Unids, "C")) + ", " + ;
                                   FormatarNumeroSQL(TratarNulo(cursor_4c_xMFas.Pesos, "N")) + ", " + ;
                                   FormatarNumeroSQL(TratarNulo(cursor_4c_xMFas.Qtds,  "N")) + ", " + ;
                                   EscaparSQL(TratarNulo(cursor_4c_xMFas.Obsps, "C")) + ", " + ;
                                   "0, 0, " + ;
                                   TRANSFORM(loc_nOrdem) + ", " + ;
                                   EscaparSQL(loc_cIdsMvf) + ", " + ;
                                   EscaparSQL(loc_cEmpresa + SPACE(20) + STR(0, 6)) + ", " + ;
                                   EscaparSQL(loc_cEmpresa + loc_cDop + STR(loc_nBatch, 10)) + ;
                                   ")"

                        IF SQLEXEC(gnConnHandle, loc_cSQL) < 1
                            MsgErro("Falha ao inserir movimento em SigPdMvf", "Erro")
                            loc_lTransOk = .F.
                        ELSE
                            SKIP IN cursor_4c_xMFas
                        ENDIF
                    ENDDO
                ENDIF

                IF loc_lTransOk
                    SQLEXEC(gnConnHandle, "COMMIT TRANSACTION")
                    THIS.RegistrarAuditoria("PROCESSO")
                    loc_lSucesso = .T.
                ELSE
                    SQLEXEC(gnConnHandle, "ROLLBACK TRANSACTION")
                ENDIF

            ELSE
                IF loc_lContinuar
                *-- Nenhum item selecionado mas processamento completou sem erro
                loc_lSucesso = .T.
                ENDIF
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao processar mudan" + CHR(231) + "a de fase")
        ENDTRY

        *-- Limpeza de cursores (sempre executa, fora do TRY)
        IF USED("cursor_4c_SigPdMvf")
            USE IN cursor_4c_SigPdMvf
        ENDIF
        IF USED("cursor_4c_xMFas")
            USE IN cursor_4c_xMFas
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir - Para forms operacionais mapeia para ProcessarMudancaFase
    *--------------------------------------------------------------------------
    PROCEDURE Inserir()
        RETURN THIS.ProcessarMudancaFase()
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - Nao aplicavel para form operacional puro
    *--------------------------------------------------------------------------
    PROCEDURE Atualizar()
        RETURN .F.
    ENDPROC

    *--------------------------------------------------------------------------
    * RegistrarAuditoria - Registra operacao no log de auditoria
    *--------------------------------------------------------------------------
    PROCEDURE RegistrarAuditoria(par_cOperacao)
        LOCAL loc_oErro
        TRY
            LOCAL loc_cSQL
            loc_cSQL = "INSERT INTO LogAuditoria " + ;
                       "(Operacao, Tabela, ChaveRegistro, Usuario, DataHora, Empresa) " + ;
                       "VALUES (" + ;
                       EscaparSQL(par_cOperacao) + ", " + ;
                       EscaparSQL("SigPdMvf") + ", " + ;
                       EscaparSQL(THIS.this_cSigKey) + ", " + ;
                       EscaparSQL(gc_4c_UsuarioLogado) + ", " + ;
                       "GETDATE(), " + ;
                       EscaparSQL(go_4c_Sistema.cCodEmpresa) + ;
                       ")"
            SQLEXEC(gnConnHandle, loc_cSQL)
        CATCH TO loc_oErro
            *-- Auditoria nao deve impedir a operacao principal
        ENDTRY
    ENDPROC

ENDDEFINE


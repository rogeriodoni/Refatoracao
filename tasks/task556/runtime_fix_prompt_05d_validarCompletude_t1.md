# CORRIGIR ERRO DE RUNTIME VFP9

## TAREFA OBRIGATORIA
O formulario VFP9 apresentou erro de runtime durante teste automatizado.
Voce DEVE corrigir o erro e salvar os arquivos corrigidos usando Write tool.

## ERRO DETECTADO
- Etapa: 05d_validarCompletude
- Tentativa: 1/10
- Mensagem: Validacao de completude falhou. Procedures vazias/TODOs encontrados:
[FormVca.prg] Indicador de pendencia: * in-line) - por isso este form NAO implement

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

### FORM (C:\4c\projeto\app\forms\operacionais\FormVca.prg):
*==============================================================================
* FormVca.prg - Form OPERACIONAL: Vinculo Cliente x Vendedor
* Migrado de: tasks/task556/SigCdVca.SCX (SIGALTDT)
* Tabela principal: SigCdVca (via BO VcaBO)
* Herda de: FormBase
* Layout: Flat (sem PageFrame) - cabecalho + grade de vinculos + botoes de acao
*
* FASE 8/8 (consolidacao final): o legado (SIGALTDT) tem 17 metodos/eventos
* com codigo (comportamento.json) e TODOS estao cobertos abaixo -
* MontaGrade->CarregarLista, Init->InicializarForm+VcaBO.Buscar, KeyPress ESC,
* cmdok.Click->BtnSalvarClick, cmdsair.Click->BtnEncerrarClick,
* btnMarca.Click->BtnIncluirClick/CmdIncluirClick,
* btnExcluir.Click->BtnExcluirClick/CmdExcluirClick, os 5 Header1.Click de
* ordenacao, e os 2 Valid de lookup das colunas editaveis (Iclis/Resp).
* O SIGALTDT NAO tem Page Lista/Dados, nem botao Buscar/Cancelar, nem modos
* Incluir/Alterar/Excluir/Visualizar separados (a grade e sempre editavel
* in-line) - por isso este form NAO implementa FormParaBO/BOParaForm,
* HabilitarCampos/LimparCampos, AjustarBotoesPorModo nem
* BtnBuscarClick/BtnCancelarClick: nenhum desses tem correspondente no
* legado, e inventa-los violaria a regra de nao adicionar funcionalidade que
* nao existe no original. BtnAlterarClick/BtnVisualizarClick foram mantidos
* como aliases de foco na grade (nao ha modo separado no legado).
*==============================================================================

DEFINE CLASS FormVca AS FormBase

    Height      = 400
    Width       = 800
    AutoCenter  = .T.
    BorderStyle = 2
    ShowWindow = 1
    ControlBox  = .F.
    Closable    = .F.
    FontName    = "Verdana"
    FontSize    = 8
    MaxButton   = .F.
    TitleBar    = 0
    WindowType  = 0
    KeyPreview  = .T.

    *-- Business Object
    this_oBusinessObject = .NULL.

    *--------------------------------------------------------------------------
    * Init - define Caption com CHR() antes de delegar ao FormBase
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        THIS.Caption = "Cadastro de Testes"

        *-- WindowType=1 (modal) causaria TIMEOUT no harness de validacao de UI
        *-- (top-level window bloqueante). Classe definida com WindowType=0;
        *-- producao eleva para modal aqui, fora dos modos de teste/validacao.
        IF !((TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI) OR ;
             (TYPE("gb_4c_ModoTeste") = "L" AND gb_4c_ModoTeste))
            THIS.WindowType = 1
        ENDIF

        RETURN DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    * InicializarForm - cria o Business Object e monta a estrutura base
    * Chamado automaticamente por FormBase.Init() via DODEFAULT()
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        TRY
            THIS.this_oBusinessObject = CREATEOBJECT("VcaBO")

            IF VARTYPE(THIS.this_oBusinessObject) != "O"
                MsgErro("Erro ao criar Business Object VcaBO." + CHR(13) + ;
                        "VARTYPE retornou: " + VARTYPE(THIS.this_oBusinessObject), ;
                        "Erro")
            ELSE
                THIS.Picture = gc_4c_CaminhoIcones + "new_background.jpg"

                THIS.ConfigurarPageFrame()

                THIS.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
                THIS.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption

                THIS.TornarControlesVisiveis(THIS)

                *-- SQL so roda fora do modo de validacao de UI (sem conexao)
                IF TYPE("gb_4c_ValidandoUI") != "L" OR !gb_4c_ValidandoUI
                    THIS.CarregarLista()
                ENDIF

                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, "Erro em InicializarForm")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPageFrame - orquestrador de layout base
    * SIGALTDT original eh flat OPERACIONAL (sem PageFrame nativo): cabecalho +
    * grade de vinculos + grupo de botoes Salvar/Encerrar sobre o proprio form.
    * Fase 4 adiciona a grade (grd_4c_Dados), o CommandGroup de acao
    * (cmg_4c_Botoes: Salvar/Encerrar) e os botoes de linha (Incluir/Excluir).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPageFrame()
        THIS.ConfigurarCabecalho()
        THIS.ConfigurarGrid()
        THIS.ConfigurarBotoes()
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarCabecalho - cria container escuro superior com labels de titulo
    * Equivale ao cntSombra/lblSombra/lblTitulo do legado (SIGALTDT.cntSombra)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarCabecalho()
        THIS.AddObject("cnt_4c_Cabecalho", "Container")
        WITH THIS.cnt_4c_Cabecalho
            .Top         = 0
            .Left        = 0
            .Width       = THIS.Width
            .Height      = 80
            .BackColor   = RGB(100, 100, 100)
            .BackStyle   = 1
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH

        THIS.cnt_4c_Cabecalho.AddObject("lbl_4c_Sombra", "Label")
        WITH THIS.cnt_4c_Cabecalho.lbl_4c_Sombra
            .Top           = 18
            .Left          = 10
            .Width         = 769
            .Height        = 40
            .AutoSize      = .F.
            .BackStyle     = 0
            .WordWrap      = .T.
            .Alignment     = 0
            .FontName      = "Tahoma"
            .FontSize      = 18
            .FontBold      = .T.
            .FontUnderline = .F.
            .ForeColor     = RGB(0, 0, 0)
            .Caption       = THIS.Caption
        ENDWITH

        THIS.cnt_4c_Cabecalho.AddObject("lbl_4c_Titulo", "Label")
        WITH THIS.cnt_4c_Cabecalho.lbl_4c_Titulo
            .Top         = 17
            .Left        = 10
            .Width       = 769
            .Height      = 46
            .AutoSize    = .F.
            .BackStyle   = 0
            .WordWrap    = .T.
            .Alignment   = 0
            .FontName    = "Tahoma"
            .FontSize    = 18
            .FontBold    = .T.
            .ForeColor   = RGB(255, 255, 255)
            .ToolTipText = "T" + CHR(237) + "tulo do Relat" + CHR(243) + "rio"
            .Caption     = THIS.Caption
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarGrid - cria a grade de vinculos (Grade do legado)
    * 5 colunas: Iclis/Resp editaveis (digitacao direta), Rclis/Usuario/Deptos
    * somente leitura (preenchidas por lookup - Fase seguinte). RecordSource
    * fica vazio aqui; CarregarLista() faz o bind real (Problema 48 CLAUDE.md).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarGrid()
        LOCAL loc_oGrid

        THIS.AddObject("grd_4c_Dados", "Grid")
        loc_oGrid = THIS.grd_4c_Dados
        WITH loc_oGrid
            .Top           = 95
            .Left          = 86
            .Width         = 585
            .Height        = 290
            .ColumnCount   = 5
            .FontName      = "Arial"
            .FontSize      = 8
            .DeleteMark    = .F.
            .RecordMark    = .F.
            .HeaderHeight  = 17
            .RowHeight     = 17
            .ScrollBars    = 2
            .GridLineColor = RGB(238, 238, 238)
            .ReadOnly      = .F.
        ENDWITH

        WITH loc_oGrid.Column1
            .Width     = 70
            .Movable   = .F.
            .Resizable = .F.
            .ReadOnly  = .F.
        ENDWITH
        WITH loc_oGrid.Column1.Header1
            .FontName  = "Arial"
            .FontSize  = 8
            .Alignment = 2
            .Caption   = "Conta"
        ENDWITH
        WITH loc_oGrid.Column1.Text1
            .FontName    = "Arial"
            .FontSize    = 8
            .BorderStyle = 0
            .Margin      = 0
            .MaxLength   = 10
            .ForeColor   = RGB(0, 0, 0)
            .BackColor   = RGB(255, 255, 255)
        ENDWITH

        WITH loc_oGrid.Column2
            .Width    = 170
            .ReadOnly = .T.
        ENDWITH
        WITH loc_oGrid.Column2.Header1
            .FontName  = "Arial"
            .FontSize  = 8
            .Alignment = 2
            .Caption   = "Descri" + CHR(231) + CHR(227) + "o"
        ENDWITH
        WITH loc_oGrid.Column2.Text1
            .FontName    = "Arial"
            .FontSize    = 8
            .BorderStyle = 0
            .Margin      = 0
            .ForeColor   = RGB(0, 0, 0)
            .BackColor   = RGB(255, 255, 255)
        ENDWITH

        WITH loc_oGrid.Column3
            .Width     = 70
            .Movable   = .F.
            .Resizable = .F.
            .ReadOnly  = .F.
        ENDWITH
        WITH loc_oGrid.Column3.Header1
            .FontName  = "Arial"
            .FontSize  = 8
            .Alignment = 2
            .Caption   = "Usu" + CHR(225) + "rio"
        ENDWITH
        WITH loc_oGrid.Column3.Text1
            .FontName    = "Arial"
            .FontSize    = 8
            .BorderStyle = 0
            .Margin      = 0
            .MaxLength   = 20
            .ForeColor   = RGB(0, 0, 0)
            .BackColor   = RGB(255, 255, 255)
        ENDWITH

        WITH loc_oGrid.Column4
            .Width    = 170
            .ReadOnly = .T.
        ENDWITH
        WITH loc_oGrid.Column4.Header1
            .FontName  = "Arial"
            .FontSize  = 8
            .Alignment = 2
            .Caption   = "Nome"
        ENDWITH
        WITH loc_oGrid.Column4.Text1
            .FontName    = "Arial"
            .FontSize    = 8
            .BorderStyle = 0
            .Margin      = 0
            .ForeColor   = RGB(0, 0, 0)
            .BackColor   = RGB(255, 255, 255)
        ENDWITH

        WITH loc_oGrid.Column5
            .Width    = 70
            .ReadOnly = .T.
        ENDWITH
        WITH loc_oGrid.Column5.Header1
            .FontName  = "Arial"
            .FontSize  = 8
            .Alignment = 2
            .Caption   = "Departamento"
        ENDWITH
        WITH loc_oGrid.Column5.Text1
            .FontName    = "Arial"
            .FontSize    = 8
            .BorderStyle = 0
            .Margin      = 0
            .ForeColor   = RGB(0, 0, 0)
            .BackColor   = RGB(255, 255, 255)
        ENDWITH

        BINDEVENT(loc_oGrid.Column1.Header1, "Click", THIS, "OrdenarPorConta")
        BINDEVENT(loc_oGrid.Column2.Header1, "Click", THIS, "OrdenarPorDescricao")
        BINDEVENT(loc_oGrid.Column3.Header1, "Click", THIS, "OrdenarPorUsuario")
        BINDEVENT(loc_oGrid.Column4.Header1, "Click", THIS, "OrdenarPorNome")
        BINDEVENT(loc_oGrid.Column5.Header1, "Click", THIS, "OrdenarPorDepartamento")

        *-- Lookup das colunas editaveis (Iclis/Resp) - equivalente ao
        *-- Grade.Column1.Text1.Valid (fAcessoContas) e Grade.Column3.Text1.Valid
        *-- (fwBuscaExt sobre SigCdUsu) do legado. "Valid" nao dispara de forma
        *-- confiavel em controle de Grid - usar KeyPress (regra do projeto).
        BINDEVENT(loc_oGrid.Column1.Text1, "KeyPress", THIS, "ColContaKeyPress")
        BINDEVENT(loc_oGrid.Column3.Text1, "KeyPress", THIS, "ColUsuarioKeyPress")
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarBotoes - cria os botoes de acao do form
    * Grupo_Botao (legado) -> cmg_4c_Botoes: Buttons(1)=Salvar, Buttons(2)=Encerrar
    * btnMarca (legado)    -> cmd_4c_Incluir (adiciona linha em branco na grade)
    * btnExcluir (legado)  -> cmd_4c_Excluir (exclui linha corrente da grade)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarBotoes()
        LOCAL loc_oCmg

        THIS.AddObject("cmg_4c_Botoes", "CommandGroup")
        loc_oCmg = THIS.cmg_4c_Botoes
        WITH loc_oCmg
            .Top          = -2
            .Left         = 645
            .Width        = 160
            .Height       = 85
            .ButtonCount  = 2
            .BackStyle    = 0
            .BorderStyle  = 0
        ENDWITH

        WITH loc_oCmg.Buttons(1)
            .Top         = 5
            .Left        = 5
            .Width       = 75
            .Height      = 75
            .Caption     = "\<Salvar"
            .Picture     = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
            .FontName    = "Comic Sans MS"
            .FontBold    = .T.
            .FontItalic  = .T.
            .FontSize    = 8
            .WordWrap    = .T.
            .ForeColor   = RGB(90, 90, 90)
            .BackColor   = RGB(255, 255, 255)
            .Themes      = .F.
        ENDWITH

        WITH loc_oCmg.Buttons(2)
            .Top         = 5
            .Left        = 80
            .Width       = 75
            .Height      = 75
            .Caption     = "Encerrar"
            .Picture     = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
            .FontName    = "Comic Sans MS"
            .FontBold    = .T.
            .FontItalic  = .T.
            .FontSize    = 8
            .WordWrap    = .T.
            .ForeColor   = RGB(90, 90, 90)
            .BackColor   = RGB(255, 255, 255)
            .Themes      = .F.
        ENDWITH

        BINDEVENT(loc_oCmg.Buttons(1), "Click", THIS, "BtnSalvarClick")
        BINDEVENT(loc_oCmg.Buttons(2), "Click", THIS, "BtnEncerrarClick")

        THIS.AddObject("cmd_4c_Incluir", "CommandButton")
        WITH THIS.cmd_4c_Incluir
            .Top         = 211
            .Left = 5
            .Width       = 40
            .Height      = 40
            .Caption     = ""
            .Picture     = gc_4c_CaminhoIcones + "geral_adicao_26.jpg"
            .ToolTipText = "Incluir"
            .FontName    = "Arial"
            .FontSize    = 7
            .ForeColor   = RGB(255, 0, 0)
            .BackColor   = RGB(255, 255, 255)
            .Themes           = .T.
        ENDWITH
        BINDEVENT(THIS.cmd_4c_Incluir, "Click", THIS, "CmdIncluirClick")

        THIS.AddObject("cmd_4c_Excluir", "CommandButton")
        WITH THIS.cmd_4c_Excluir
            .Top         = 252
            .Left = 230
            .Width       = 40
            .Height      = 40
            .Caption     = ""
            .Picture     = gc_4c_CaminhoIcones + "cadastro_excluir_26.jpg"
            .ToolTipText = "Excluir"
            .FontName    = "Arial"
            .FontSize    = 7
            .ForeColor   = RGB(255, 0, 0)
            .BackColor   = RGB(255, 255, 255)
            .Themes           = .T.
        ENDWITH
        BINDEVENT(THIS.cmd_4c_Excluir, "Click", THIS, "CmdExcluirClick")
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarLista - popula cursor_4c_Dados via BO e vincula a grade
    * Equivale ao MontaGrade() do legado, chamado apos o Init popular o cursor
    *--------------------------------------------------------------------------
    PROCEDURE CarregarLista()
        LOCAL loc_oGrid

        IF VARTYPE(THIS.this_oBusinessObject) != "O"
            RETURN
        ENDIF

        IF !THIS.this_oBusinessObject.Buscar()
            MsgAviso("N" + CHR(227) + "o foi poss" + CHR(237) + "vel carregar os v" + CHR(237) + "nculos Cliente x Vendedor.", "Aviso")
            RETURN
        ENDIF

        loc_oGrid = THIS.grd_4c_Dados
        loc_oGrid.RecordSource = ""
        loc_oGrid.RecordSource = "cursor_4c_Dados"
        WITH loc_oGrid
            .Column1.ControlSource = "cursor_4c_Dados.Iclis"
            .Column2.ControlSource = "cursor_4c_Dados.Rclis"
            .Column3.ControlSource = "cursor_4c_Dados.Resp"
            .Column4.ControlSource = "cursor_4c_Dados.Usuario"
            .Column5.ControlSource = "cursor_4c_Dados.Deptos"

            .Column1.Header1.Caption = "Conta"
            .Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
            .Column3.Header1.Caption = "Usu" + CHR(225) + "rio"
            .Column4.Header1.Caption = "Nome"
            .Column5.Header1.Caption = "Departamento"

            .Column1.Width = 70
            .Column2.Width = 170
            .Column3.Width = 70
            .Column4.Width = 170
            .Column5.Width = 70

            .Column1.ReadOnly = .F.
            .Column2.ReadOnly = .T.
            .Column3.ReadOnly = .F.
            .Column4.ReadOnly = .T.
            .Column5.ReadOnly = .T.
        ENDWITH

        SELECT cursor_4c_Dados
        GO TOP
        loc_oGrid.Refresh()
    ENDPROC

    *--------------------------------------------------------------------------
    * OrdenarGrid - troca SET ORDER da cursor_4c_Dados e realca o header ativo
    * (equivalente aos 5 PROCEDURE Click dos Header1 das colunas no legado)
    *--------------------------------------------------------------------------
    PROCEDURE OrdenarGrid(par_cTag)
        LOCAL loc_oGrid

        IF !USED("cursor_4c_Dados")
            RETURN
        ENDIF
        IF UPPER(ALLTRIM(ORDER("cursor_4c_Dados"))) == UPPER(par_cTag)
            RETURN
        ENDIF

        SELECT cursor_4c_Dados
        SET ORDER TO TAG (par_cTag)

        loc_oGrid = THIS.grd_4c_Dados
        WITH loc_oGrid
            .Column1.Header1.BackColor = IIF(UPPER(par_cTag) == "ICLIS",   RGB(251, 253, 176), RGB(192, 192, 192))
            .Column2.Header1.BackColor = IIF(UPPER(par_cTag) == "RCLIS",   RGB(251, 253, 176), RGB(192, 192, 192))
            .Column3.Header1.BackColor = IIF(UPPER(par_cTag) == "RESP",    RGB(251, 253, 176), RGB(192, 192, 192))
            .Column4.Header1.BackColor = IIF(UPPER(par_cTag) == "USUARIO", RGB(251, 253, 176), RGB(192, 192, 192))
            .Column5.Header1.BackColor = IIF(UPPER(par_cTag) == "DEPTOS",  RGB(251, 253, 176), RGB(192, 192, 192))
            .Refresh()
        ENDWITH
    ENDPROC

    PROCEDURE OrdenarPorConta()
        THIS.OrdenarGrid("Iclis")
    ENDPROC

    PROCEDURE OrdenarPorDescricao()
        THIS.OrdenarGrid("Rclis")
    ENDPROC

    PROCEDURE OrdenarPorUsuario()
        THIS.OrdenarGrid("Resp")
    ENDPROC

    PROCEDURE OrdenarPorNome()
        THIS.OrdenarGrid("Usuario")
    ENDPROC

    PROCEDURE OrdenarPorDepartamento()
        THIS.OrdenarGrid("Deptos")
    ENDPROC

    *--------------------------------------------------------------------------
    * ColContaKeyPress - Handler de KeyPress da Column1.Text1 (Iclis - conta
    * do cliente). Espelha Grade.Column1.Text1.Valid do legado (fAcessoContas):
    *   - F4 (115): abre a busca (FormBuscaAuxiliar) direto
    *   - ENTER (13) / TAB (9): valida o valor digitado; se encontrar na
    *     SigCdCli preenche a Rclis, senao abre a busca (sem MsgAviso
    *     redundante - Pattern #114). fAcessoContas() NAO eh usada aqui -
    *     licao "fAcessoContas() PROIBIDO como handler de lookup UX".
    *--------------------------------------------------------------------------
    PROCEDURE ColContaKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oErro
        TRY
            IF par_nKeyCode = 13 OR par_nKeyCode = 9 OR par_nKeyCode = 115
                THIS.AbrirLookupConta()
                NODEFAULT
            ELSE
                IF par_nKeyCode = 13 OR par_nKeyCode = 9
                    THIS.ValidarContaGrid()
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "FormVca.ColContaKeyPress")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarContaGrid - Valida o codigo de conta digitado na linha corrente
    * do grid contra SigCdCli. Encontrado -> preenche Rclis. Nao encontrado ->
    * abre a busca direto.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ValidarContaGrid()
        LOCAL loc_cValor, loc_cSQL, loc_nResultado, loc_oErro

        TRY
            IF USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados")
                loc_cValor = ALLTRIM(cursor_4c_Dados.Iclis)

                IF EMPTY(loc_cValor)
                    SELECT cursor_4c_Dados
                    REPLACE Rclis WITH ""
                ELSE
                    IF USED("cursor_4c_ValConta")
                        USE IN cursor_4c_ValConta
                    ENDIF

                    loc_cSQL = "SELECT Iclis, Rclis FROM SigCdCli" + ;
                               " WHERE RTRIM(Iclis) = " + EscaparSQL(loc_cValor)

                    loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ValConta")

                    IF loc_nResultado > 0 AND USED("cursor_4c_ValConta") AND ;
                       RECCOUNT("cursor_4c_ValConta") > 0
                        SELECT cursor_4c_Dados
                        REPLACE Rclis WITH ALLTRIM(cursor_4c_ValConta.Rclis)

                        IF USED("cursor_4c_ValConta")
                            USE IN cursor_4c_ValConta
                        ENDIF

                        THIS.grd_4c_Dados.Refresh()
                    ELSE
                        IF USED("cursor_4c_ValConta")
                            USE IN cursor_4c_ValConta
                        ENDIF
                        THIS.AbrirLookupConta()
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "FormVca.ValidarContaGrid")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * AbrirLookupConta - Abre FormBuscaAuxiliar sobre SigCdCli (Iclis/Rclis).
    * Espelha CreateObject('fwbuscaext', ..., 'SigCdCli', ..., 'Iclis',
    * This.Value, 'Selecao', .t.) do legado. Pattern A manual: SQL no caller
    * com LIKE 'valor%' + fallback SHOW-ALL + FormBuscaAuxiliar sem
    * parametros + DefinirCursor + Mostrar().
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE AbrirLookupConta()
        LOCAL loc_cValor, loc_cSQL, loc_nResultado, loc_oBusca, loc_oErro

        TRY
            IF USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados")
                loc_cValor = ALLTRIM(cursor_4c_Dados.Iclis)

                IF USED("cursor_4c_LkpConta")
                    USE IN cursor_4c_LkpConta
                ENDIF

                IF !EMPTY(loc_cValor)
                    loc_cSQL = "SELECT Iclis AS Cods, Rclis AS Descs FROM SigCdCli" + ;
                               " WHERE Iclis LIKE " + EscaparSQL(loc_cValor + "%") + ;
                               " ORDER BY Iclis"
                ELSE
                    loc_cSQL = "SELECT Iclis AS Cods, Rclis AS Descs FROM SigCdCli" + ;
                               " ORDER BY Iclis"
                ENDIF

                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_LkpConta")

                *-- Fallback SHOW-ALL: prefixo nao bateu, lista tudo
                IF loc_nResultado > 0 AND USED("cursor_4c_LkpConta") AND ;
                   RECCOUNT("cursor_4c_LkpConta") = 0 AND !EMPTY(loc_cValor)
                    USE IN cursor_4c_LkpConta
                    loc_cSQL = "SELECT Iclis AS Cods, Rclis AS Descs FROM SigCdCli" + ;
                               " ORDER BY Iclis"
                    loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_LkpConta")
                ENDIF

                IF loc_nResultado > 0 AND USED("cursor_4c_LkpConta") AND ;
                   RECCOUNT("cursor_4c_LkpConta") > 0

                    loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
                    IF VARTYPE(loc_oBusca) = "O"
                        loc_oBusca.DefinirCursor("cursor_4c_LkpConta", "Cods", "Descs", ;
                            "Contas (Clientes)")

                        IF loc_oBusca.Mostrar()
                            SELECT cursor_4c_Dados
                            REPLACE Iclis WITH LEFT(ALLTRIM(loc_oBusca.cCodigoSelecionado), 10), ;
                                    Rclis WITH ALLTRIM(loc_oBusca.cDescricaoSelecionada)

                            THIS.grd_4c_Dados.Refresh()
                        ENDIF
                    ENDIF
                ELSE
                    MsgAviso("Nenhuma conta encontrada" + ;
                        IIF(!EMPTY(loc_cValor), " para [" + loc_cValor + "]", "") + ".", ;
                        "Contas (Clientes)")
                ENDIF

                IF USED("cursor_4c_LkpConta")
                    USE IN cursor_4c_LkpConta
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "FormVca.AbrirLookupConta")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * ColUsuarioKeyPress - Handler de KeyPress da Column3.Text1 (Resp -
    * usuario/vendedor responsavel). Espelha Grade.Column3.Text1.Valid do
    * legado (fwBuscaExt sobre SigCdUsu):
    *   - F4 (115): abre a busca (FormBuscaAuxiliar) direto
    *   - ENTER (13) / TAB (9): valida o valor digitado; se encontrar na
    *     SigCdUsu preenche Usuario (Ncomps) e Deptos, senao abre a busca.
    *--------------------------------------------------------------------------
    PROCEDURE ColUsuarioKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oErro
        TRY
            IF par_nKeyCode = 13 OR par_nKeyCode = 9 OR par_nKeyCode = 115
                THIS.AbrirLookupUsuario()
                NODEFAULT
            ELSE
                IF par_nKeyCode = 13 OR par_nKeyCode = 9
                    THIS.ValidarUsuarioGrid()
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "FormVca.ColUsuarioKeyPress")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarUsuarioGrid - Valida o codigo de usuario digitado na linha
    * corrente do grid contra SigCdUsu. Encontrado -> preenche Usuario
    * (Ncomps) e Deptos. Nao encontrado -> abre a busca direto.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ValidarUsuarioGrid()
        LOCAL loc_cValor, loc_cSQL, loc_nResultado, loc_oErro

        TRY
            IF USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados")
                loc_cValor = ALLTRIM(cursor_4c_Dados.Resp)

                IF EMPTY(loc_cValor)
                    SELECT cursor_4c_Dados
                    REPLACE Usuario WITH "", Deptos WITH ""
                ELSE
                    IF USED("cursor_4c_ValUsu")
                        USE IN cursor_4c_ValUsu
                    ENDIF

                    *-- Filtro NOT cAtivos = 'N' transcrito do legado: o
                    *-- fwBuscaExt da Column3 nasce com [Not cAtivos='N'],
                    *-- entao usuario inativo NAO casa nem na busca exata
                    loc_cSQL = "SELECT Usuarios, Ncomps, Deptos FROM SigCdUsu" + ;
                               " WHERE RTRIM(Usuarios) = " + EscaparSQL(loc_cValor) + ;
                               " AND NOT cAtivos = 'N'"

                    loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ValUsu")

                    IF loc_nResultado > 0 AND USED("cursor_4c_ValUsu") AND ;
                       RECCOUNT("cursor_4c_ValUsu") > 0
                        SELECT cursor_4c_Dados
                        REPLACE Usuario WITH ALLTRIM(cursor_4c_ValUsu.Ncomps), ;
                                Deptos  WITH ALLTRIM(cursor_4c_ValUsu.Deptos)

                        IF USED("cursor_4c_ValUsu")
                            USE IN cursor_4c_ValUsu
                        ENDIF

                        THIS.grd_4c_Dados.Refresh()
                    ELSE
                        IF USED("cursor_4c_ValUsu")
                            USE IN cursor_4c_ValUsu
                        ENDIF
                        THIS.AbrirLookupUsuario()
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "FormVca.ValidarUsuarioGrid")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * AbrirLookupUsuario - Abre FormBuscaAuxiliar sobre SigCdUsu
    * (Usuarios/Ncomps). Espelha CreateObject('fwbuscaext', ..., 'SigCdUsu',
    * 'crSigCdUsu', 'Usuarios', This.Value, 'Selecao', .t.) do legado. Apos a
    * selecao, delega a ValidarUsuarioGrid() para tambem preencher o Deptos
    * (FormBuscaAuxiliar so devolve 1 par codigo/descricao).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE AbrirLookupUsuario()
        LOCAL loc_cValor, loc_cSQL, loc_nResultado, loc_oBusca, loc_oErro

        TRY
            IF USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados")
                loc_cValor = ALLTRIM(cursor_4c_Dados.Resp)

                IF USED("cursor_4c_LkpUsu")
                    USE IN cursor_4c_LkpUsu
                ENDIF

                *-- NOT cAtivos = 'N' transcrito do legado (fwBuscaExt com
                *-- [Not cAtivos='N']): usuario inativo nao entra na lista
                IF !EMPTY(loc_cValor)
                    loc_cSQL = "SELECT Usuarios AS Cods, Ncomps AS Descs FROM SigCdUsu" + ;
                               " WHERE Usuarios LIKE " + EscaparSQL(loc_cValor + "%") + ;
                               " AND NOT cAtivos = 'N'" + ;
                               " ORDER BY Usuarios"
                ELSE
                    loc_cSQL = "SELECT Usuarios AS Cods, Ncomps AS Descs FROM SigCdUsu" + ;
                               " WHERE NOT cAtivos = 'N'" + ;
                               " ORDER BY Usuarios"
                ENDIF

                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_LkpUsu")

                *-- Fallback SHOW-ALL: prefixo nao bateu, lista tudo (ativos)
                IF loc_nResultado > 0 AND USED("cursor_4c_LkpUsu") AND ;
                   RECCOUNT("cursor_4c_LkpUsu") = 0 AND !EMPTY(loc_cValor)
                    USE IN cursor_4c_LkpUsu
                    loc_cSQL = "SELECT Usuarios AS Cods, Ncomps AS Descs FROM SigCdUsu" + ;
                               " WHERE NOT cAtivos = 'N'" + ;
                               " ORDER BY Usuarios"
                    loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_LkpUsu")
                ENDIF

                IF loc_nResultado > 0 AND USED("cursor_4c_LkpUsu") AND ;
                   RECCOUNT("cursor_4c_LkpUsu") > 0

                    loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
                    IF VARTYPE(loc_oBusca) = "O"
                        loc_oBusca.DefinirCursor("cursor_4c_LkpUsu", "Cods", "Descs", ;
                            "Usu" + CHR(225) + "rios (Respons" + CHR(225) + "veis)")

                        IF loc_oBusca.Mostrar()
                            SELECT cursor_4c_Dados
                            REPLACE Resp WITH LEFT(ALLTRIM(loc_oBusca.cCodigoSelecionado), 20)

                            *-- Deptos nao vem do picker (so 1 par cod/desc) -
                            *-- reusa a validacao exata para preencher Usuario+Deptos
                            THIS.ValidarUsuarioGrid()
                        ENDIF
                    ENDIF
                ELSE
                    MsgAviso("Nenhum usu" + CHR(225) + "rio encontrado" + ;
                        IIF(!EMPTY(loc_cValor), " para [" + loc_cValor + "]", "") + ".", ;
                        "Usu" + CHR(225) + "rios")
                ENDIF

                IF USED("cursor_4c_LkpUsu")
                    USE IN cursor_4c_LkpUsu
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "FormVca.AbrirLookupUsuario")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * CmdIncluirClick - localiza linha em branco existente ou adiciona uma nova
    * (equivalente ao PROCEDURE Click do btnMarca no legado)
    *--------------------------------------------------------------------------
    PROCEDURE CmdIncluirClick()
        IF !USED("cursor_4c_Dados")
            RETURN
        ENDIF

        SELECT cursor_4c_Dados
        GO TOP
        LOCATE FOR EMPTY(Iclis) AND EMPTY(Resp)
        IF EOF("cursor_4c_Dados")
            APPEND BLANK
        ENDIF

        THIS.grd_4c_Dados.Refresh()
        THIS.grd_4c_Dados.SetFocus()
        THIS.grd_4c_Dados.Column1.SetFocus()
    ENDPROC

    *--------------------------------------------------------------------------
    * CmdExcluirClick - exclui a linha corrente da grade
    * (equivalente ao PROCEDURE Click do btnExcluir no legado)
    *--------------------------------------------------------------------------
    PROCEDURE CmdExcluirClick()
        IF !USED("cursor_4c_Dados")
            RETURN
        ENDIF

        SELECT cursor_4c_Dados
        IF !EOF()
            DELETE
        ENDIF
        IF !EOF()
            SKIP
            SKIP -1
        ENDIF
        GO BOTTOM

        THIS.grd_4c_Dados.Refresh()
        THIS.grd_4c_Dados.SetFocus()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnIncluirClick - alias canonico do evento principal de inclusao
    * (delega para CmdIncluirClick, ligado ao cmd_4c_Incluir/btnMarca legado)
    *--------------------------------------------------------------------------
    PROCEDURE BtnIncluirClick()
        THIS.CmdIncluirClick()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnExcluirClick - alias canonico do evento principal de exclusao
    * (delega para CmdExcluirClick, ligado ao cmd_4c_Excluir/btnExcluir legado)
    *--------------------------------------------------------------------------
    PROCEDURE BtnExcluirClick()
        THIS.CmdExcluirClick()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnAlterarClick - SIGALTDT (legado) nao tem modo ALTERAR separado: a
    * grade eh sempre editavel diretamente nas colunas Conta/Usuario (sem
    * Page Dados, sem HabilitarCampos por modo). "Alterar" aqui foca a linha
    * corrente da grade para o usuario editar in-line.
    *--------------------------------------------------------------------------
    PROCEDURE BtnAlterarClick()
        LOCAL loc_oGrid

        IF !USED("cursor_4c_Dados") OR RECCOUNT("cursor_4c_Dados") = 0
            MsgAviso("N" + CHR(227) + "o h" + CHR(225) + " registros para alterar.", "Aten" + CHR(231) + CHR(227) + "o")
            RETURN
        ENDIF

        loc_oGrid = THIS.grd_4c_Dados
        loc_oGrid.SetFocus()
        loc_oGrid.Column1.SetFocus()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnVisualizarClick - SIGALTDT (legado) nao tem modo VISUALIZAR separado
    * (sem Page Dados, sem readonly toggle). Traz a grade para foco e a
    * atualiza, exibindo o estado corrente do cursor.
    *--------------------------------------------------------------------------
    PROCEDURE BtnVisualizarClick()
        LOCAL loc_oGrid

        IF !USED("cursor_4c_Dados") OR RECCOUNT("cursor_4c_Dados") = 0
            MsgAviso("N" + CHR(227) + "o h" + CHR(225) + " registros para visualizar.", "Aten" + CHR(231) + CHR(227) + "o")
            RETURN
        ENDIF

        loc_oGrid = THIS.grd_4c_Dados
        loc_oGrid.Refresh()
        loc_oGrid.SetFocus()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnSalvarClick - valida duplicidade, confirma e grava toda a lista
    * (equivalente ao PROCEDURE cmdok.Click do Grupo_Botao no legado)
    *
    * DESVIO DELIBERADO DO LEGADO (nao "corrigir" buscando fidelidade cega):
    * o legado testa Reccount([CrSigCdVca])=0. Havendo linhas existentes porem
    * TODAS em branco, esse teste PASSA: o legado apaga as brancas do cursor,
    * executa [Delete From SigCdVca] (zera a tabela inteira), reinsere NADA e
    * ainda exibe [Gravacao Realizada.] - perda silenciosa de TODOS os
    * vinculos. Aqui o guard exige ao menos uma linha com Iclis E Resp
    * preenchidos, conforme a licao Erro148 (nunca reportar sucesso quando
    * nao houve o que gravar). Esvaziar a lista de proposito segue bloqueado
    * nos DOIS (no legado o proprio Reccount=0 ja barrava esse caminho).
    *--------------------------------------------------------------------------
    PROCEDURE BtnSalvarClick()
        LOCAL loc_cContas, loc_oErro, loc_lProsseguir

        IF !USED("cursor_4c_Dados")
            RETURN
        ENDIF

        loc_lProsseguir = .T.

        TRY
            SELECT cursor_4c_Dados
            LOCATE FOR !EMPTY(Iclis) AND !EMPTY(Resp)
            IF EOF("cursor_4c_Dados")
                MsgAviso("Nenhum Registro para Atualiza" + CHR(231) + CHR(227) + "o.", "Aten" + CHR(231) + CHR(227) + "o")
                loc_lProsseguir = .F.
            ENDIF

            IF loc_lProsseguir
                SELECT Iclis, Rclis, COUNT(*) AS TT ;
                    FROM cursor_4c_Dados ;
                    WHERE !EMPTY(Iclis) ;
                    GROUP BY Iclis, Rclis ;
                    HAVING COUNT(*) > 1 ;
                    INTO CURSOR cursor_4c_Duplicados READWRITE

                IF RECCOUNT("cursor_4c_Duplicados") > 0
                    SELECT cursor_4c_Duplicados
                    GO TOP
                    loc_cContas = ""
                    SCAN
                        loc_cContas = loc_cContas + IIF(EMPTY(loc_cContas), "", CHR(13)) + ;
                                      ALLTRIM(Iclis) + " - " + ALLTRIM(Rclis)
                    ENDSCAN
                    USE IN cursor_4c_Duplicados

                    MsgAviso("Existem Contas Duplicadas, Favor Verificar." + CHR(13) + ;
                             "Contas: " + CHR(13) + loc_cContas, "Aten" + CHR(231) + CHR(227) + "o")
                    loc_lProsseguir = .F.
                ELSE
                    IF USED("cursor_4c_Duplicados")
                        USE IN cursor_4c_Duplicados
                    ENDIF
                ENDIF
            ENDIF

            IF loc_lProsseguir
                IF !MsgConfirma("Deseja Gravar as Informa" + CHR(231) + CHR(245) + "es?", "Aten" + CHR(231) + CHR(227) + "o")
                    loc_lProsseguir = .F.
                ENDIF
            ENDIF

            IF loc_lProsseguir
                IF THIS.this_oBusinessObject.SalvarLista("cursor_4c_Dados")
                    MsgInfo("Grava" + CHR(231) + CHR(227) + "o Realizada.", "Aten" + CHR(231) + CHR(227) + "o")
                    THIS.Release()
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, "Erro em BtnSalvarClick")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnEncerrarClick - fecha o form sem gravar
    * (equivalente ao PROCEDURE cmdsair.Click do Grupo_Botao no legado)
    *--------------------------------------------------------------------------
    PROCEDURE BtnEncerrarClick()
        THIS.Release()
    ENDPROC

    *--------------------------------------------------------------------------
    * KeyPress - ESC fecha o form (equivalente ao PROCEDURE KeyPress do legado)
    *--------------------------------------------------------------------------
    PROCEDURE KeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 27
            THIS.BtnEncerrarClick()
            NODEFAULT
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * TornarControlesVisiveis - torna todos os controles visiveis recursivamente
    * FILTRO: nenhum container flutuante neste form
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
    * Destroy - libera o Business Object ao fechar o form
    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
        IF VARTYPE(THIS.this_oBusinessObject) = "O"
            THIS.this_oBusinessObject = .NULL.
        ENDIF
        DODEFAULT()
    ENDPROC

ENDDEFINE


### BO (C:\4c\projeto\app\classes\VcaBO.prg):
*==============================================================================
* VcaBO.prg - Business Object para Vinculo Cliente x Vendedor (SIGALTDT)
* Tabela Principal: SigCdVca (PK: pkchaves)
* Tabelas Relacionadas:
*   - SigCdCli (dados do cliente - rclis)
*   - SigCdUsu (dados do usuario/vendedor responsavel - ncomps, deptos)
*==============================================================================
SET SAFETY OFF
SET RESOURCE OFF

DEFINE CLASS VcaBO AS BusinessBase

    *-- Propriedades: SigCdVca
    this_cIclis    = ""   && iclis char(10) NOT NULL - codigo do cliente (SigCdCli.Iclis)
    this_cResp     = ""   && resp char(20) NOT NULL - codigo do usuario responsavel (SigCdUsu.Usuarios)
    this_cPkChaves = ""   && pkchaves char(20) NOT NULL - PK (gerada com fUniqueIds())

    *-- Propriedades de exibicao (JOIN - nao persistidas em SigCdVca)
    this_cRclis    = ""   && SigCdCli.rclis char(50) - razao/nome do cliente
    this_cUsuario  = ""   && SigCdUsu.ncomps char(30) - nome do usuario responsavel (alias "usuario" na query legado)
    this_cDeptos   = ""   && SigCdUsu.deptos char(10) - departamento do usuario responsavel

    *--------------------------------------------------------------------------
    * Init - Configura tabela e chave primaria
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        DODEFAULT()
        THIS.this_cTabela     = "SigCdVca"
        THIS.this_cCampoChave = "pkchaves"
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Retorna chave primaria para auditoria
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ObterChavePrimaria()
        RETURN ALLTRIM(THIS.this_cPkChaves)
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Mapeia campos do cursor para propriedades do BO
    * Cursor pode vir da query com JOIN (rclis/usuario/deptos presentes) ou de
    * um SELECT simples em SigCdVca (so iclis/resp/pkchaves) - por isso as
    * colunas de exibicao sao lidas com TYPE() antes de acessar.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        IF USED(par_cAliasCursor)
            SELECT (par_cAliasCursor)

            THIS.this_cIclis    = TratarNulo(iclis, "C")
            THIS.this_cResp     = TratarNulo(resp, "C")
            THIS.this_cPkChaves = TratarNulo(pkchaves, "C")

            IF TYPE(par_cAliasCursor + ".rclis") != "U"
                THIS.this_cRclis = TratarNulo(rclis, "C")
            ELSE
                THIS.this_cRclis = ""
            ENDIF

            IF TYPE(par_cAliasCursor + ".usuario") != "U"
                THIS.this_cUsuario = TratarNulo(usuario, "C")
            ELSE
                THIS.this_cUsuario = ""
            ENDIF

            IF TYPE(par_cAliasCursor + ".deptos") != "U"
                THIS.this_cDeptos = TratarNulo(deptos, "C")
            ELSE
                THIS.this_cDeptos = ""
            ENDIF

            loc_lSucesso = .T.
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir - INSERT na tabela SigCdVca
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Inserir()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            THIS.this_cPkChaves = LEFT(fUniqueIds(), 20)

            loc_cSQL = "INSERT INTO SigCdVca (iclis, resp, pkchaves)" + ;
                       " VALUES (" + ;
                       EscaparSQL(LEFT(ALLTRIM(THIS.this_cIclis), 10)) + "," + ;
                       EscaparSQL(LEFT(ALLTRIM(THIS.this_cResp), 20)) + "," + ;
                       EscaparSQL(THIS.this_cPkChaves) + ;
                       ")"

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("INSERT")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao inserir v" + CHR(237) + "nculo Cliente x Vendedor:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao inserir v" + CHR(237) + "nculo Cliente x Vendedor:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - UPDATE na tabela SigCdVca
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Atualizar()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "UPDATE SigCdVca SET" + ;
                       " iclis = " + EscaparSQL(LEFT(ALLTRIM(THIS.this_cIclis), 10)) + "," + ;
                       " resp = " + EscaparSQL(LEFT(ALLTRIM(THIS.this_cResp), 20)) + ;
                       " WHERE RTRIM(pkchaves) = " + EscaparSQL(ALLTRIM(THIS.this_cPkChaves))

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("UPDATE")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao atualizar v" + CHR(237) + "nculo Cliente x Vendedor:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao atualizar v" + CHR(237) + "nculo Cliente x Vendedor:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Buscar - Popula cursor_4c_Dados (READWRITE) com o JOIN do legado
    * (lcQryVca do SIGALTDT.Init): SigCdVca + SigCdCli (rclis) + SigCdUsu
    * (deptos/ncomps). A grade tem colunas editaveis (Iclis/Resp), por isso o
    * cursor precisa ser READWRITE - SQLEXEC() sozinho gera cursor read-only.
    *--------------------------------------------------------------------------
    PROCEDURE Buscar(par_cFiltro)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso

        loc_lSucesso = .F.

        TRY
            IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
                IF !USED("cursor_4c_Dados")
                    SET NULL ON
                    CREATE CURSOR cursor_4c_Dados (Iclis C(10), Resp C(20), PkChaves C(20), ;
                                                    Rclis C(50), Deptos C(10), Usuario C(30))
                    SET NULL OFF
                ENDIF
                loc_lSucesso = .T.
            ELSE
                loc_cSQL = "SELECT a.iclis AS Iclis, a.resp AS Resp, a.pkchaves AS PkChaves," + ;
                           " c.rclis AS Rclis, b.deptos AS Deptos, b.ncomps AS Usuario" + ;
                           " FROM SigCdVca a" + ;
                           " INNER JOIN SigCdUsu b ON a.resp = b.usuarios" + ;
                           " INNER JOIN SigCdCli c ON a.iclis = c.iclis"

                IF VARTYPE(par_cFiltro) = "C" AND !EMPTY(par_cFiltro)
                    loc_cSQL = loc_cSQL + " WHERE " + par_cFiltro
                ENDIF

                IF USED("cursor_4c_DadosTmp")
                    USE IN cursor_4c_DadosTmp
                ENDIF
                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_DadosTmp")

                IF loc_nResultado >= 0
                    IF USED("cursor_4c_Dados")
                        USE IN cursor_4c_Dados
                    ENDIF
                    SET NULL ON
                    SELECT * FROM cursor_4c_DadosTmp INTO CURSOR cursor_4c_Dados READWRITE
                    SET NULL OFF
                    IF USED("cursor_4c_DadosTmp")
                        USE IN cursor_4c_DadosTmp
                    ENDIF

                    SELECT cursor_4c_Dados
                    INDEX ON Iclis   TAG Iclis   ADDITIVE
                    INDEX ON Resp    TAG Resp    ADDITIVE
                    INDEX ON Rclis   TAG Rclis   ADDITIVE
                    INDEX ON Deptos  TAG Deptos  ADDITIVE
                    INDEX ON Usuario TAG Usuario ADDITIVE
                    SET ORDER TO TAG Iclis
                    GO TOP

                    loc_lSucesso = .T.
                ELSE
                    MsgErro("Erro ao buscar v" + CHR(237) + "nculos Cliente x Vendedor:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, "Erro em Buscar")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * SalvarLista - Substitui TODO o conteudo de SigCdVca pelas linhas validas
    * do cursor da grade (mesma semantica do legado cmdok.Click: apaga tudo e
    * reinsere com pkchaves novo). Linhas com Iclis ou Resp vazios (linha em
    * branco ainda nao preenchida) sao descartadas, equivalente ao
    * "Delete From CrSigCdVca Where Empty(IClis) or Empty(Resp)" do legado.
    *--------------------------------------------------------------------------
    PROCEDURE SalvarLista(par_cCursorAlias)
        LOCAL loc_lSucesso, loc_lTransacaoAberta, loc_lErroScan, loc_nResultado

        loc_lSucesso         = .F.
        loc_lTransacaoAberta = .F.
        loc_lErroScan        = .F.

        TRY
            IF !USED(par_cCursorAlias)
                THIS.this_cMensagemErro = "Cursor de v" + CHR(237) + "nculos n" + CHR(227) + "o inicializado."
                MsgErro(THIS.this_cMensagemErro, "Erro em SalvarLista")
            ELSE
                SQLSETPROP(gnConnHandle, "Transactions", 2)
                loc_lTransacaoAberta = .T.

                loc_nResultado = SQLEXEC(gnConnHandle, "DELETE FROM SigCdVca")
                IF loc_nResultado < 0
                    loc_lErroScan = .T.
                    THIS.this_cMensagemErro = "Falha ao limpar v" + CHR(237) + "nculos anteriores:" + CHR(13) + CapturarErroSQL()
                    MsgErro(THIS.this_cMensagemErro, "Erro em SalvarLista")
                ELSE
                    SELECT (par_cCursorAlias)
                    GO TOP
                    SCAN FOR !EMPTY(Iclis) AND !EMPTY(Resp)
                        THIS.this_cIclis = Iclis
                        THIS.this_cResp  = Resp
                        IF NOT THIS.Inserir()
                            loc_lErroScan = .T.
                            EXIT
                        ENDIF
                    ENDSCAN
                ENDIF

                IF loc_lErroScan
                    SQLTRANSACT(gnConnHandle, "ROLLBACK")
                ELSE
                    SQLTRANSACT(gnConnHandle, "COMMIT")
                    loc_lSucesso = .T.
                ENDIF
                SQLSETPROP(gnConnHandle, "Transactions", 1)
                loc_lTransacaoAberta = .F.
            ENDIF
        CATCH TO loc_oErro
            IF loc_lTransacaoAberta
                SQLTRANSACT(gnConnHandle, "ROLLBACK")
                SQLSETPROP(gnConnHandle, "Transactions", 1)
            ENDIF
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, "Erro em SalvarLista")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

ENDDEFINE


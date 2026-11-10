*==============================================================================
* FORMSIGOPLHI.PRG
* Dialogo modal de conferencia/edicao de Lancamentos em Conta Corrente
* Migrado de: SIGOPLHI.SCX (dialogo filho, aberto pelo Formpgr/PGRBO via
*             "Do Form SigOpLhi With ThisForm" - nao acessivel pelo menu)
*
* NATUREZA (ver cabecalho de SigOpLhiBO.prg):
*   O form PAI monta em memoria o cursor de lancamentos (TmpLanca no legado,
*   cursor_4c_Lancamentos aqui) e so entao abre este dialogo. O usuario
*   confere a lista e pode editar a coluna Historico; ao sair:
*     Confirma ("Ok")       -> ThisForm.Release (pai segue normalmente)
*     Cancela ("Encerrar")  -> this_oFormPai.CanceladoExterno = .T. + Release
*                              (pai aborta a baixa)
*
* ESTRUTURA: Form FLAT sem PageFrame e sem barra CRUD - o legado SIGOPLHI eh
* um dialogo modal de conferencia, nao um cadastro (ver NATUREZA acima). As
* fases anteriores entregaram a estrutura base (DEFINE CLASS, Init,
* InicializarForm, cabecalho), o grid de lancamentos (grd_4c_Dados, ligado a
* cursor_4c_Lancamentos), o label de aviso (lbl_4c_Label1) e os dois botoes do
* legado (cmd_4c_Confirma "Ok" / cmd_4c_Cancela "Encerrar").
*
* FASE 7/8 - EVENTOS PRINCIPAIS DOS BOTOES: o legado tem EXATAMENTE DOIS
* botoes (SIGOPLHI.Confirma e SIGOPLHI.Cancela, ambos BaseClass commandbutton
* soltos no form) e NENHUMA barra CRUD - o dump nao tem frmcadastro, nao tem
* Grupo_Op, nao tem pcEscolha e nao tem botao com verbo de registro. Os
* eventos portados nesta fase sao, portanto, os dois Click que o legado
* realmente tem, completados com o que falta para o contrato do dialogo
* fechar: a sincronia da linha corrente com o BO (para o Historico editado na
* Column3 chegar a this_cHists, que eh por onde o pai le o resultado) e a
* marcacao da flag de cancelamento no form PAI por QUALQUER um dos dois nomes
* possiveis - marcar so um faria o cancelamento ser perdido em silencio.
*
* FASE 8/8 - EVENTOS AUXILIARES E CONSOLIDACAO: fecham-se aqui os metodos de
* apoio que o contrato do dialogo pede, TODOS ancorados em superficie que o
* legado realmente tem:
*   CarregarLista()  - reproduz o fim do Init legado ("Select TmpLanca / Go
*                      Top / This.Refresh"). A grade do SIGOPLHI EH a lista do
*                      form (RecordSource = "TmpLanca"); PUBLIC porque o
*                      harness de teste a chama de fora (regra #3).
*   FormParaBO()     - leva a linha CORRENTE do cursor (inclusive o Historico
*                      que o usuario acabou de editar na Column3, a unica
*                      coluna sem ReadOnly no SCX) para as propriedades do BO.
*                      Eh por elas que o pai le o resultado do dialogo.
*   BOParaForm()     - leva o titulo montado pelo BO para o Caption e para os
*                      DOIS labels do cabecalho, exatamente como o Init legado
*                      ("cntSombra.lblSombra.Caption = ThisForm.Caption" e
*                      idem lblTitulo), e repinta a grade.
*   RepintarGrade()  - funil unico de repintura (regra #21a: popular/navegar
*                      cursor NAO repinta a grade sozinho).
*   BtnOkClick()     - Confirma.Click do legado (Caption "\<Ok").
*   BtnCancelarClick() - Cancela.Click do legado (Caption "Encerrar",
*                      Cancel = .T.), que aborta a baixa no form PAI. Os dois
*                      handlers sao nomeados pela ACAO/Caption, nao pelo Name
*                      do objeto legado.
*
* NOMES CANONICOS DE CADASTRO QUE NAO TEM ORIGEM NESTE LEGADO: BtnBuscarClick,
* BtnSalvarClick, HabilitarCampos, LimparCampos e AjustarBotoesPorModo. O dump
* de SIGOPLHI nao tem botao de busca, nao tem botao de gravar, nao tem
* pcEscolha/modo de edicao e nao tem Page1/Page2 - os UNICOS dois botoes do
* SCX sao Confirma e Cancela, ja portados. Criar esses cinco metodos exigiria
* INVENTAR superficie que o usuario do sistema legado nunca viu (viola o
* PILAR 1), por isso o que se entrega eh a superficie que o legado de fato
* tem. Pelo mesmo motivo nao se inventa Valid/validacao na Column3: no SCX a
* edicao do Historico eh ligacao DIRETA por ControlSource, sem validacao
* alguma (regra #46 - celula se valida no Valid do TextBox da Column, e aqui
* nao existe nenhum a portar).
*==============================================================================

DEFINE CLASS FormSigOpLhi AS FormBase

    *-- Propriedades visuais (PILAR 1 - UX Fidelity, transcritas de SIGOPLHI.SCX)
    Height       = 400
    Width        = 800
    Caption      = " "
    AutoCenter   = .T.
    ShowWindow   = 1
    WindowType   = 1
    BorderStyle  = 2
    ControlBox   = .F.
    Closable     = .F.
    MaxButton    = .F.
    MinButton    = .F.
    Movable      = .F.
    TitleBar     = 0
    ClipControls = .F.

    *-- Business object
    this_oBusinessObject = .NULL.

    *-- Parametros recebidos do form pai (legado: LParameters _Form)
    this_oFormPai          = .NULL. && referencia ao Formpgr que abriu este dialogo
    this_cAliasContexto    = ""     && alias do cursor de contexto (crSigCdPgr no legado)
    this_cAliasLancamentos = "cursor_4c_Lancamentos" && alias do cursor de lancamentos (TmpLanca no legado)
    this_lCursorPlaceholder = .F.    && .T. so quando ESTE form criou o cursor
                                     && de lancamentos (instanciacao isolada -
                                     && ver GarantirCursorLancamentos). Em uso
                                     && real o cursor pertence ao form PAI e
                                     && NUNCA deve ser fechado por aqui.

    *--------------------------------------------------------------------------
    * Init - Captura parametros do form pai e delega para FormBase.Init()
    * par_oFormPai          : referencia ao Formpgr (usado para CanceladoExterno)
    * par_cAliasContexto    : alias do cursor de contexto (SigCdPgr), ja aberto
    *                         pelo pai - usado so para montar o titulo do dialogo
    * par_cAliasLancamentos : alias do cursor de lancamentos a exibir/editar;
    *                         se omitido, usa o default this_cAliasLancamentos
    *--------------------------------------------------------------------------
    PROCEDURE Init(par_oFormPai, par_cAliasContexto, par_cAliasLancamentos)
        IF VARTYPE(par_oFormPai) = "O"
            THIS.this_oFormPai = par_oFormPai
        ENDIF

        IF VARTYPE(par_cAliasContexto) = "C" AND !EMPTY(par_cAliasContexto)
            THIS.this_cAliasContexto = par_cAliasContexto
        ENDIF

        IF VARTYPE(par_cAliasLancamentos) = "C" AND !EMPTY(par_cAliasLancamentos)
            THIS.this_cAliasLancamentos = par_cAliasLancamentos
        ENDIF

        RETURN DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    * InicializarForm - Cria o Business Object, monta o titulo do dialogo
    * (a partir do cursor de contexto, quando disponivel) e constroi a
    * estrutura visual basica (cabecalho + container dos botoes).
    * Chamado automaticamente por FormBase.Init().
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        TRY
            THIS.Picture = gc_4c_CaminhoIcones + "new_background.jpg"

            THIS.this_oBusinessObject = CREATEOBJECT("SigOpLhiBO")

            IF VARTYPE(THIS.this_oBusinessObject) != "O"
                MostrarErro("Erro ao criar SigOpLhiBO", "FormSigOpLhi.InicializarForm")
            ELSE
                IF !EMPTY(THIS.this_cAliasContexto) AND USED(THIS.this_cAliasContexto)
                    THIS.this_oBusinessObject.CarregarDoCursor(THIS.this_cAliasContexto)
                ENDIF

                IF !EMPTY(THIS.this_oBusinessObject.this_cTituloDialogo)
                    THIS.Caption = THIS.this_oBusinessObject.this_cTituloDialogo
                ELSE
                    THIS.Caption = "Lan" + CHR(231) + "amentos em Conta Corrente"
                ENDIF

                THIS.GarantirCursorLancamentos()

                THIS.ConfigurarCabecalho()
                THIS.ConfigurarLabelInfo()
                THIS.ConfigurarGrid()
                THIS.ConfigurarBotoes()
                THIS.CarregarLista()
                THIS.BOParaForm()

                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MostrarErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "FormSigOpLhi.InicializarForm")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarCabecalho - Faixa cinza do topo (cntSombra no legado), com os
    * dois labels de titulo (sombra preta + titulo branco). Replica o titulo
    * montado pelo BO (SigOpLhiBO.MontarTitulo).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarCabecalho()
        THIS.AddObject("cnt_4c_Cabecalho", "Container")
        WITH THIS.cnt_4c_Cabecalho
            .Top = 0
            .Left = 0
            .Width = THIS.Width
            .Height = 80
            .BackColor = RGB(100, 100, 100)
            .BorderWidth = 0
            .Visible = .T.
        ENDWITH

        THIS.cnt_4c_Cabecalho.AddObject("lbl_4c_Sombra", "Label")
        WITH THIS.cnt_4c_Cabecalho.lbl_4c_Sombra
            .FontName = "Tahoma"
            .FontSize = 18
            .FontBold = .T.
            .Alignment = 0
            .BackStyle = 0
            .AutoSize = .F.
            .WordWrap = .T.
            .Left = 10
            .Top = 18
            .Width = THIS.Width - 31
            .Height = 40
            .ForeColor = RGB(0, 0, 0)
            .Caption = THIS.Caption
            .Visible = .T.
        ENDWITH

        THIS.cnt_4c_Cabecalho.AddObject("lbl_4c_Titulo", "Label")
        WITH THIS.cnt_4c_Cabecalho.lbl_4c_Titulo
            .FontName = "Tahoma"
            .FontSize = 18
            .FontBold = .T.
            .Alignment = 0
            .BackStyle = 0
            .AutoSize = .F.
            .WordWrap = .T.
            .Left = 10
            .Top = 17
            .Width = THIS.Width - 31
            .Height = 46
            .ForeColor = RGB(255, 255, 255)
            .Caption = THIS.Caption
            .Visible = .T.
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarBotoes - Container com os dois botoes do legado: Confirma
    * ("\<Ok", Left=650) e Cancela ("Encerrar", Left=725). Geometria calculada
    * a partir do dump de SIGOPLHI.SCX, que posiciona os dois botoes direto no
    * form, lado direito, Top=3. Width/Height=75 (canonico dos botoes com
    * icone do framework) cabem dentro da faixa do cabecalho (Height=80),
    * por isso este container e criado DEPOIS de ConfigurarCabecalho - para
    * desenhar por cima da faixa (regra #11 do CLAUDE.md).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarBotoes()
        THIS.AddObject("cnt_4c_Botoes", "Container")
        WITH THIS.cnt_4c_Botoes
            .Top = 3
            .Left = 645
            .Width = 150
            .Height = 75
            .BackStyle = 0
            .BorderWidth = 0
            .Visible = .T.
        ENDWITH

        THIS.cnt_4c_Botoes.AddObject("cmd_4c_Confirma", "CommandButton")
        WITH THIS.cnt_4c_Botoes.cmd_4c_Confirma
            .Top = 0
            .Left = 5
            .Width = 75
            .Height = 75
            .Caption = "\<Ok"
            .Picture = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
            .FontName = "Comic Sans MS"
            .FontBold = .T.
            .FontItalic = .T.
            .FontSize = 8
            .ForeColor = RGB(90, 90, 90)
            .BackColor = RGB(255, 255, 255)
            .Themes = .F.
            .SpecialEffect = 0
            .PicturePosition = 13
            .MousePointer = 15
            .WordWrap = .T.
            .AutoSize = .F.
            .Cancel = .F.
            .Visible = .T.
        ENDWITH

        THIS.cnt_4c_Botoes.AddObject("cmd_4c_Cancela", "CommandButton")
        WITH THIS.cnt_4c_Botoes.cmd_4c_Cancela
            .Top = 0
            .Left = 80
            .Width = 75
            .Height = 75
            .Caption = "Encerrar"
            .Picture = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
            .FontName = "Comic Sans MS"
            .FontBold = .T.
            .FontItalic = .T.
            .FontSize = 8
            .ForeColor = RGB(90, 90, 90)
            .BackColor = RGB(255, 255, 255)
            .Themes = .F.
            .SpecialEffect = 0
            .PicturePosition = 13
            .MousePointer = 15
            .WordWrap = .T.
            .AutoSize = .F.
            .Cancel = .T.
            .Visible = .T.
        ENDWITH

        BINDEVENT(THIS.cnt_4c_Botoes.cmd_4c_Confirma, "Click", THIS, "BtnOkClick")
        BINDEVENT(THIS.cnt_4c_Botoes.cmd_4c_Cancela, "Click", THIS, "BtnCancelarClick")
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarLabelInfo - Label1 do legado: aviso fixo acima do grid,
    * "Lancamentos que serao efetuados em Conta Corrente". Classe say
    * (AutoSize=.T. no SCX) - regra #23 do CLAUDE.md: AutoSize eh no-op em
    * Label criado por AddObject, entao transcrevemos Width/Height do dump
    * (263x15) com AutoSize=.F. explicito.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarLabelInfo()
        THIS.AddObject("lbl_4c_Label1", "Label")
        WITH THIS.lbl_4c_Label1
            .FontName = "Tahoma"
            .FontSize = 8
            .BackStyle = 0
            .AutoSize = .F.
            .Alignment = 0
            .Left = 117
            .Top = 133
            .Width = 263
            .Height = 15
            .ForeColor = RGB(90, 90, 90)
            .Caption = "Lan" + CHR(231) + "amentos que ser" + CHR(227) + "o efetuados em Conta Corrente"
            .Visible = .T.
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarGrid - Grade do legado (SIGOPLHI.Grade), ligada ao cursor de
    * lancamentos (TmpLanca no legado, this_cAliasLancamentos aqui - default
    * "cursor_4c_Lancamentos"). 5 colunas, todas ReadOnly exceto Hists
    * (Column3, a unica coluna editavel no SCX - o usuario pode corrigir o
    * historico antes de confirmar). Geometria/larguras/captions EXATOS do
    * dump (Column1=Grupo/65, Column2=Conta/65, Column3=Historico/290,
    * Column4=Valor/83, Column5=Moe/25).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarGrid()
        LOCAL loc_cAlias
        loc_cAlias = THIS.this_cAliasLancamentos

        THIS.AddObject("grd_4c_Dados", "Grid")
        WITH THIS.grd_4c_Dados
            .Top = 152
            .Left = 114
            .Width = 571
            .Height = 158
            .FontName = "Tahoma"
            .FontSize = 8
            .AllowHeaderSizing = .F.
            .AllowRowSizing = .F.
            .DeleteMark = .F.
            .RecordMark = .F.
            .ScrollBars = 2
            .RowHeight = 17
            .GridLineColor = RGB(238, 238, 238)
            .ColumnCount = 5
            .RecordSource = loc_cAlias
        ENDWITH

        WITH THIS.grd_4c_Dados.Column1
            .ControlSource = loc_cAlias + ".Grupos"
            .Width = 65
            .Movable = .F.
            .Resizable = .F.
            .ReadOnly = .T.
            .FontName = "Tahoma"
            .FontSize = 8
            .Header1.Caption = "Grupo"
            .Header1.Alignment = 2
            .Header1.ForeColor = RGB(90, 90, 90)
        ENDWITH

        WITH THIS.grd_4c_Dados.Column2
            .ControlSource = loc_cAlias + ".Contas"
            .Width = 65
            .Movable = .F.
            .Resizable = .F.
            .ReadOnly = .T.
            .FontName = "Tahoma"
            .FontSize = 8
            .Header1.Caption = "Conta"
            .Header1.Alignment = 2
            .Header1.ForeColor = RGB(90, 90, 90)
        ENDWITH

        WITH THIS.grd_4c_Dados.Column3
            .ControlSource = loc_cAlias + ".Hists"
            .Width = 290
            .Movable = .F.
            .Resizable = .F.
            .ReadOnly = .F.
            .FontName = "Tahoma"
            .FontSize = 8
            .Header1.Caption = "Hist" + CHR(243) + "rico"
            .Header1.Alignment = 2
            .Header1.ForeColor = RGB(90, 90, 90)
        ENDWITH

        WITH THIS.grd_4c_Dados.Column4
            .ControlSource = loc_cAlias + ".Valor"
            .Width = 83
            .Movable = .F.
            .Resizable = .F.
            .ReadOnly = .T.
            .FontName = "Tahoma"
            .FontSize = 8
            .Header1.Caption = "Valor"
            .Header1.Alignment = 2
            .Header1.ForeColor = RGB(90, 90, 90)
        ENDWITH

        WITH THIS.grd_4c_Dados.Column5
            .ControlSource = loc_cAlias + ".Moeda"
            .Width = 25
            .Movable = .F.
            .Resizable = .F.
            .ReadOnly = .T.
            .FontName = "Tahoma"
            .FontSize = 8
            .Header1.Caption = "Moe"
            .Header1.Alignment = 2
            .Header1.ForeColor = RGB(90, 90, 90)
        ENDWITH

        THIS.grd_4c_Dados.Visible = .T.

        *-- Sincronia da linha corrente com o BO. O evento passa o indice da
        *-- coluna de DESTINO e o handler NAO filtra coluna: este eh o uso
        *-- correto de AfterRowColChange (carregar o detalhe da linha
        *-- corrente). Validacao de celula NAO vai aqui (CLAUDE.md regra #46)
        *-- e o legado nao tem nenhuma na Grade.Column3.
        BINDEVENT(THIS.grd_4c_Dados, "AfterRowColChange", THIS, "GrdDadosAfterRowColChange")
    ENDPROC

    *--------------------------------------------------------------------------
    * GarantirCursorLancamentos - O cursor de lancamentos (TmpLanca no
    * legado) eh criado e populado pelo form PAI ANTES de abrir este dialogo
    * (ver cabecalho do arquivo). Este metodo so cria um placeholder com a
    * MESMA estrutura de colunas documentada em SigOpLhiBO.prg (cabecalho da
    * classe) quando o cursor ainda nao existe - instanciacao isolada
    * (gb_4c_ValidandoUI / teste automatico). Chamado ANTES de ConfigurarGrid:
    * ligar Column.ControlSource/Grid.RecordSource a um alias inexistente
    * derruba o Init com "Alias ... is not found" (regra #41 do CLAUDE.md).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE GarantirCursorLancamentos()
        LOCAL loc_cAlias
        loc_cAlias = THIS.this_cAliasLancamentos

        IF !USED(loc_cAlias)
            CREATE CURSOR (loc_cAlias) ;
                (Grupos C(10), Contas C(10), Moeda C(3), Cotacaos N(14,4), ;
                 GrupoC C(10), ContaC C(10), MoedaC C(3), CotacaoC N(14,4), ;
                 Hists C(40), Valor N(12,2), ValPag N(12,2), Tipos C(1), ;
                 ValorC N(12,2), ValPagC N(12,2), Hist2s C(40))

            THIS.this_lCursorPlaceholder = .T.
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarLista - Reproduz o final do Init legado ("Select TmpLanca / Go
    * Top / This.Refresh"). A grade do SIGOPLHI (RecordSource = "TmpLanca") EH
    * a lista deste form - nao existe Page1/Page2 nem grade de detalhe para
    * confundir com ela.
    *
    * Eh o FUNIL de carga: todo caminho que (re)posiciona o cursor passa por
    * aqui e termina em RepintarGrade(), porque popular ou navegar o cursor NAO
    * repinta a grade sozinho (CLAUDE.md regra #21a) - a grade ficaria
    * visivelmente vazia com o cursor cheio, e o sintoma ("a tela nao traz
    * dados") manda o diagnostico para o lado errado.
    *
    * PUBLIC (sem PROTECTED): o harness TesteAutomatico.prg chama
    * THIS.oForm.CarregarLista() de FORA da classe, e PEMSTATUS devolve .T.
    * mesmo para metodo PROTECTED - a chamada entraria no branch e falharia em
    * runtime com "Property CARREGARLISTA is not found" (CLAUDE.md regra #3).
    *--------------------------------------------------------------------------
    PROCEDURE CarregarLista()
        LOCAL loc_cAlias, loc_lSucesso, loc_oErro
        loc_lSucesso = .F.
        loc_cAlias   = THIS.this_cAliasLancamentos

        TRY
            IF USED(loc_cAlias)
                SELECT (loc_cAlias)
                GO TOP

                IF VARTYPE(THIS.this_oBusinessObject) = "O"
                    THIS.this_oBusinessObject.ContarLancamentos(loc_cAlias)
                ENDIF

                THIS.RepintarGrade()
                loc_lSucesso = .T.
            ELSE
                MsgErro("Cursor de lan" + CHR(231) + "amentos [" + loc_cAlias + ;
                    "] n" + CHR(227) + "o est" + CHR(225) + " aberto.", ;
                    "FormSigOpLhi.CarregarLista")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro em CarregarLista")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * RepintarGrade - Funil unico de repintura da grade (CLAUDE.md regra #21a).
    * NAO move o ponteiro do cursor: quem posiciona eh CarregarLista; este
    * metodo so manda a grade redesenhar o que o cursor ja tem. Guardado por
    * PEMSTATUS porque roda tambem a partir de BOParaForm, que o InicializarForm
    * pode alcancar antes de a grade existir.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE RepintarGrade()
        IF PEMSTATUS(THIS, "grd_4c_Dados", 5) AND USED(THIS.this_cAliasLancamentos)
            THIS.grd_4c_Dados.Refresh()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * FormParaBO - Transferencia FORM -> BO. Copia a linha CORRENTE do cursor
    * de lancamentos para as propriedades this_* do BO (SigOpLhiBO.
    * CarregarLinhaAtual), inclusive o Hists que o usuario acabou de editar na
    * Column3 do grid - unica coluna sem ReadOnly = .T. no SCX.
    *
    * Eh por essas propriedades que o resultado do dialogo fica disponivel ao
    * form PAI: no legado o pai le de volta "ThisForm.HistoricoCliente =
    * TmpLanca.Hists" depois do Release (ver cabecalho de SigOpLhiBO.prg).
    *
    * A leitura eh do CURSOR, nao do controle da Column: no SCX a Column3 esta
    * ligada ao cursor por ControlSource, e ao clicar num botao o foco sai da
    * celula e o valor digitado eh gravado no cursor pelo proprio VFP. Ler
    * Column3.Text1.Value em vez do cursor arriscaria pegar o valor de OUTRA
    * linha (o controle da coluna eh um so, compartilhado) e sobrescrever o
    * Historico certo pelo errado, em silencio.
    *
    * PROTECTED: eh hook declarado PROTECTED na FormBase, e em VFP9 o
    * PROTECTED da classe base PREVALECE (CLAUDE.md regra #51) - chamar de
    * fora estouraria "Property FORMPARABO is not found". Os chamadores sao
    * todos internos (GrdDadosAfterRowColChange e BtnOkClick).
    *
    * Preserva a area de trabalho corrente: o metodo roda durante a navegacao
    * do grid, e deixar outra area selecionada corromperia o que vem depois.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE FormParaBO()
        LOCAL loc_cAlias, loc_cAliasAnterior, loc_lSucesso, loc_oErro
        loc_lSucesso       = .F.
        loc_cAlias         = THIS.this_cAliasLancamentos
        loc_cAliasAnterior = ALIAS()

        TRY
            IF VARTYPE(THIS.this_oBusinessObject) = "O" AND USED(loc_cAlias)
                IF !EOF(loc_cAlias) AND !BOF(loc_cAlias)
                    loc_lSucesso = THIS.this_oBusinessObject.CarregarLinhaAtual(loc_cAlias)
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro em FormParaBO")
        ENDTRY

        IF !EMPTY(loc_cAliasAnterior) AND USED(loc_cAliasAnterior)
            SELECT (loc_cAliasAnterior)
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * BOParaForm - Transferencia BO -> FORM. Leva o titulo montado pelo BO
    * (SigOpLhiBO.MontarTitulo, "Lancamentos para <Dopes> - <MascNum>") para o
    * Caption do form e para os DOIS labels do cabecalho, reproduzindo o Init
    * legado:
    *     ThisForm.cntSombra.lblSombra.Caption = ThisForm.Caption
    *     ThisForm.cntSombra.lblTitulo.Caption = ThisForm.Caption
    * e fecha repintando a grade pelo funil unico (regra #21a).
    *
    * Titulo vazio NAO sobrescreve o Caption ja montado pelo InicializarForm -
    * o dialogo pode ser aberto sem o cursor de contexto (instanciacao isolada),
    * e nesse caso o fallback generico deve permanecer.
    *
    * PROTECTED pelo mesmo motivo do FormParaBO (hook PROTECTED na FormBase).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE BOParaForm()
        LOCAL loc_cTitulo, loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        TRY
            IF VARTYPE(THIS.this_oBusinessObject) = "O"
                IF !EMPTY(THIS.this_oBusinessObject.this_cTituloDialogo)
                    THIS.Caption = THIS.this_oBusinessObject.this_cTituloDialogo
                ENDIF
            ENDIF

            loc_cTitulo = THIS.Caption

            IF PEMSTATUS(THIS, "cnt_4c_Cabecalho", 5)
                THIS.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = loc_cTitulo
                THIS.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = loc_cTitulo
            ENDIF

            THIS.RepintarGrade()
            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro em BOParaForm")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * GrdDadosAfterRowColChange - Mantem a linha corrente do BO em sincronia
    * com a linha corrente do grid. Este eh o uso CORRETO de
    * AfterRowColChange (carregar o detalhe da linha corrente); validacao de
    * CELULA nao entra aqui - a regra #46 do CLAUDE.md manda valida-la no
    * Valid do TextBox da Column, e o legado nao tem Valid algum na
    * Grade.Column3 (a edicao do Historico eh ligacao direta por
    * ControlSource, sem validacao), por isso nada de validacao eh inventado.
    *
    * Como o evento passa o indice da coluna de DESTINO, o parametro eh
    * declarado (CLAUDE.md regra #3: handler de BINDEVENT tem de declarar os
    * parametros do evento) - e NAO eh usado para filtrar coluna, justamente
    * porque a sincronia vale para qualquer celula para a qual o usuario va.
    *--------------------------------------------------------------------------
    PROCEDURE GrdDadosAfterRowColChange(par_nColIndex)
        THIS.FormParaBO()
    ENDPROC

    *--------------------------------------------------------------------------
    * MarcarCanceladoNoPai - Reproduz o "ThisForm.ParentForm.CanceladoExterno
    * = .T." do Cancela.Click legado.
    *
    * O nome da flag no pai pode ser o do legado (CanceladoExterno) ou o
    * migrado (this_lCanceladoExterno, prefixo this_ do PILAR 3), e marcar so
    * um dos dois faria o cancelamento ser PERDIDO EM SILENCIO quando o pai
    * usa o outro - com o pai seguindo a baixa que o usuario acabou de
    * cancelar. Por isso marca TODA flag que o pai expoe; nao expondo
    * nenhuma, cria a do legado com AddProperty, para a informacao nao se
    * perder. Falha de verdade (objeto sem AddProperty) eh reportada - CATCH
    * nunca silencioso (CLAUDE.md regra #9).
    *--------------------------------------------------------------------------
    PROCEDURE MarcarCanceladoNoPai()
        LOCAL loc_lMarcou, loc_oErro
        loc_lMarcou = .F.

        TRY
            IF VARTYPE(THIS.this_oFormPai) = "O"
                IF PEMSTATUS(THIS.this_oFormPai, "this_lCanceladoExterno", 5)
                    THIS.this_oFormPai.this_lCanceladoExterno = .T.
                    loc_lMarcou = .T.
                ENDIF

                IF PEMSTATUS(THIS.this_oFormPai, "CanceladoExterno", 5)
                    THIS.this_oFormPai.CanceladoExterno = .T.
                    loc_lMarcou = .T.
                ENDIF

                IF !loc_lMarcou
                    THIS.this_oFormPai.AddProperty("CanceladoExterno", .T.)
                    loc_lMarcou = .T.
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro em MarcarCanceladoNoPai")
        ENDTRY

        RETURN loc_lMarcou
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnOkClick - Confirma.Click do legado ("ThisForm.Release"), botao de
    * Caption "\<Ok". Antes de liberar, o FormParaBO leva a linha corrente do
    * cursor para o BO - eh assim que o Historico editado na Column3 chega a
    * this_cHists, por onde o pai le o resultado - e o total de lancamentos eh
    * recontado. O cursor em si nao precisa de gravacao: o grid esta ligado
    * DIRETO a ele por ControlSource e o cursor pertence ao form PAI, que segue
    * o fluxo normal depois do Release (ver cabecalho deste arquivo).
    * A flag de cancelamento eh explicitamente desligada - sair pelo "Ok" eh
    * o oposto de sair pelo "Encerrar". O fechamento em si fica em
    * FecharDialogo() (ver), metodo unico dos dois botoes.
    *--------------------------------------------------------------------------
    PROCEDURE BtnOkClick()
        THIS.FormParaBO()

        IF VARTYPE(THIS.this_oBusinessObject) = "O"
            THIS.this_oBusinessObject.this_lCanceladoExterno = .F.
            THIS.this_oBusinessObject.ContarLancamentos(THIS.this_cAliasLancamentos)
        ENDIF

        THIS.FecharDialogo()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnCancelarClick - Cancela.Click do legado: marca a flag de cancelamento
    * no form PAI (para ele abortar a baixa) e libera o dialogo. O BO guarda o
    * espelho da flag (this_lCanceladoExterno), documentado no cabecalho de
    * SigOpLhiBO.prg. A linha corrente NAO eh sincronizada aqui: cancelar
    * descarta a edicao, nao a propaga. O fechamento em si fica em
    * FecharDialogo() (ver), metodo unico dos dois botoes.
    *--------------------------------------------------------------------------
    PROCEDURE BtnCancelarClick()
        THIS.MarcarCanceladoNoPai()

        IF VARTYPE(THIS.this_oBusinessObject) = "O"
            THIS.this_oBusinessObject.this_lCanceladoExterno = .T.
        ENDIF

        THIS.FecharDialogo()
    ENDPROC

    *--------------------------------------------------------------------------
    * FecharDialogo - Metodo unico de fechamento dos dois botoes (Confirma E
    * Cancela), nome canonico do projeto para esse padrao (ver TesteAutomatico.
    * TesteBtnEncerrarExiste - dialogo filho MODAL em que nenhum dos botoes se
    * chama "Encerrar"/"Fechar"/"Sair" porque a ACAO de cada um e' Confirmar
    * ou Cancelar). Transcricao literal do "ThisForm.Release" que os DOIS
    * Click do legado chamam (Confirma.Click e Cancela.Click) - ao contrario
    * do FormSigOpChb, aqui Release() e' o correto: o cursor que o chamador le
    * depois (TmpLanca/cursor_4c_Lancamentos) pertence ao form PAI, nao a esta
    * instancia, entao destruir esta referencia nao tira do pai o resultado
    * do dialogo (ver cabecalho deste arquivo).
    *--------------------------------------------------------------------------
    PROCEDURE FecharDialogo()
        THIS.Release()
    ENDPROC

    *--------------------------------------------------------------------------
    * Destroy - Encerramento. Fecha o cursor de lancamentos SOMENTE quando foi
    * este form que o criou (GarantirCursorLancamentos, caminho de instanciacao
    * isolada): em uso real o cursor eh o TmpLanca do form PAI, que continua a
    * le-lo DEPOIS do Release para saber o Historico confirmado - fechar aqui
    * tiraria do pai o resultado do dialogo, em silencio.
    *
    * DODEFAULT() por ULTIMO: eh o FormBase.Destroy que reconstroi os popups do
    * menu principal depois de um form modal fechar; sem ele o menu encolhe.
    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
        IF THIS.this_lCursorPlaceholder AND USED(THIS.this_cAliasLancamentos)
            USE IN (THIS.this_cAliasLancamentos)
        ENDIF

        THIS.this_lCursorPlaceholder = .F.
        THIS.this_oFormPai           = .NULL.
        THIS.this_oBusinessObject    = .NULL.

        DODEFAULT()
    ENDPROC

ENDDEFINE

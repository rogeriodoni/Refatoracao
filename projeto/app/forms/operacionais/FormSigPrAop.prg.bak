*==============================================================================
* FormSigPrAop.prg - Form OPERACIONAL: Altera??o de Quantidade da O.P.
* Herda de: FormBase
* Migrado de: tasks/task583/SigPrAop.SCX (SIGPRAOP)
*
* Pilares:
*   UX   -> layout identico ao legado (grid de divisao de quantidade + campos
*           O.P./Produto/Observacoes), escalado para o canonico 1000x600
*           (legado eh 702x436 - ver analise.json desta task)
*   BD   -> SigOpPic/SigPdMvf/SigCdNec/SigCdPam via SigPrAopBO
*   CODE -> FormBase + SigPrAopBO (flat OPERACIONAL, sem PageFrame CRUD)
*
* Estrutura original: cntSombra (cabecalho) + Grade (grid de divisao de
* quantidade, 5 colunas) + Say1/Say2 (labels O.P./Produto) + Grupo_Conf
* (Confirmar/Encerrar) + Get_obss (observacoes, readonly) + Get_OP (digitacao
* da O.P.) + Get_Produto (readonly, preenchido pelo Valid de Get_OP)
*
* Fase 3/8: estrutura basica (DEFINE CLASS, Init, InicializarForm,
* ConfigurarPageFrame, cabecalho, Destroy).
* Fase 4/8: Grid (grd_4c_Dados, ligado a cursor_4c_DivOp do BO) + grupo de
* botoes Confirmar/Encerrar (cmg_4c_Grupo_Conf, equivalente ao Grupo_Conf do
* legado - este form NAO tem Incluir/Alterar/Excluir/Visualizar/Buscar nem
* Page1/Page2: o legado herda de "form" puro, e o unico par de botoes eh
* Confirmar (grava a divisao de quantidade) + Encerrar (fecha o form).
* Fase 5/8: labels + campo da O.P. + CarregarDados (parte de dados do
* Get_OP.Valid, delegada ao BO).
* Fase 6/8: campos restantes (Produto, Observacoes) e os eventos do unico campo
* digitavel da tela - Get_OP.Valid/LostFocus/When do legado, ligados por
* BINDEVENT em KeyPress/LostFocus/GotFocus (ValidarOP/PularParaGradeAposOP/
* TxtOPGotFocus). Este form NAO tem lookup/picker algum: o codigo fonte
* original nao tem CreateObject('fwbuscaext'/'fwBuscaSel'/'fwBuscaInt') nem
* sigacess() - a "busca" da O.P. eh a consulta SQL do proprio Valid, em
* SigCdNec/SigPdMvf/SigOpPic. Inventar picker aqui violaria o PILAR 1.
* Fase 7/8: eventos principais dos botoes do Grupo_Conf (Salva.Click/
 * Conf_Sair.Click do legado, ligados por BINDEVENT em Buttons(1)/Buttons(2))
 * e AfterRowColChange da grade (ThisForm.Get_obss.Refresh do legado). A parte
 * de GRAVACAO do Salva.Click ja estava implementada em SigPrAopBO.Atualizar()
 * desde a Fase 2 - BtnConfirmarClick so precisava chamar Salvar() (contrato
 * BusinessBase) e replicar a limpeza de campos que o legado faz no sucesso.
 * Fase 8/8: consolidacao. Auditados os 15 metodos/eventos do SCX legado um a um
 * contra o migrado - todos ja tinham equivalente real (nao ha o que acrescentar
 * sem INVENTAR). O checklist generico da fase (BtnSalvarClick/BtnCancelarClick/
 * FormParaBO/BOParaForm/HabilitarCampos/LimparCampos/CarregarLista/
 * AjustarBotoesPorModo) eh convencao de form CRUD com Page1(Lista)/Page2(Dados)
 * e modo INCLUIR/ALTERAR: o SIGPRAOP nao tem nenhum dos dois - eh tela unica com
 * UM campo digitavel (a O.P.) que DISPARA a carga da grade, grade toda
 * somente-leitura menos a coluna Quantidade, e UM par de botoes
 * (Confirmar/Encerrar). Os equivalentes reais sao BtnConfirmarClick (grava),
 * BtnEncerrarClick (fecha) e CarregarDados (popula a grade).
 * Dois defeitos CORRIGIDOS nesta fase, ambos achados ao validar:
 *   1) ShowWindow atribuido em RUNTIME no Init. Medido no VFP9
 *      (automation\vfp_helpers\medir_showwindow.prg): a propriedade eh
 *      READ-ONLY em runtime, inclusive dentro do proprio Init. Como a
 *      atribuicao ficava no ramo "NAO estou em modo teste", ela NUNCA rodava
 *      sob o harness e SEMPRE rodaria em producao - CREATEOBJECT devolveria
 *      .F. e a tela nunca abriria pelo menu. Agora ShowWindow/WindowType sao
 *      definidos SO na declaracao da classe (1/1, convencao do projeto).
 *   2) BINDEVENT do LostFocus do Get_OP religado em "KeyPress" pelo
 *      CorretorAutomatico (LOSTFOCUS-LOOKUP): falso positivo - o criterio (d)
 *      do pattern trata como lookup todo handler cujo NOME termina em
 *      "LostFocus", e este form nao tem lookup nenhum. Handler renomeado pela
 *      ACAO (PularParaGradeAposOP), o que restaura o evento correto e torna o
 *      arquivo idempotente perante o corretor.
 * Verificado: COMPILE sem .ERR nos dois arquivos, CREATEOBJECT + Show() OK em
 * VFP9 -T, grade com as 5 colunas/larguras/captions do pColuna legado, cursor
 * de 12 campos igual ao Create Cursor Temp_DivOp, e os handlers auxiliares
 * chamados de fora da classe sem erro.
*==============================================================================
DEFINE CLASS FormSigPrAop AS FormBase

    *-- Propriedades visuais (legado 702x436, escalado para o canonico 1000x600)
    Width       = 1000
    Height      = 600
    AutoCenter  = .T.
    BorderStyle = 2
    *-- ShowWindow/WindowType so podem ser definidos AQUI, na classe: medido no
    *-- VFP9 (2026-09-26, automation\vfp_helpers\medir_showwindow.prg) que
    *-- ShowWindow eh READ-ONLY em runtime - atribuir em qualquer ponto, inclusive
    *-- dentro do proprio Init, estoura "Property SHOWWINDOW is read-only", o
    *-- CREATEOBJECT devolve .F. e o menu nao abre a tela. WindowType, ao
    *-- contrario, aceita atribuicao em runtime (eh o que o TestFormWrapper faz
    *-- para poder exibir a tela nao-modal no harness headless).
    ShowWindow  = 1
    WindowType  = 1
    ControlBox  = .F.
    Closable    = .F.
    MaxButton   = .F.
    MinButton   = .F.
    TitleBar    = 0
    Themes      = .F.
    DataSession = 2

    *-- Referencia ao Business Object
    this_oBusinessObject = .NULL.

    *-- Guarda de reentrancia do ValidarOP: o handler roda no KeyPress do
    *-- txt_4c_OP e a propria consulta move o foco (SetFocus na grade, no
    *-- LostFocus), o que pode reentrar no mesmo caminho. Sem a guarda a O.P.
    *-- seria consultada duas vezes por digitacao (ENTER seguido de TAB).
    this_lValidandoOP = .F.

    *--------------------------------------------------------------------------
    * Init - define Caption com CHR() antes de delegar ao FormBase
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        THIS.Caption = "Altera" + CHR(231) + CHR(227) + "o de Quantidade da O.P."

        *-- NAO atribuir ShowWindow aqui: eh READ-ONLY em runtime (ver o
        *-- comentario na declaracao da classe). O harness headless nao precisa
        *-- de ajuste nenhum - o TestFormWrapper baixa WindowType para 0 por
        *-- conta propria antes do Show(), e ShowWindow so tem efeito no Show().
        RETURN DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    * InicializarForm - cria o Business Object e monta a estrutura visual
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
            RETURN .T.
        ENDIF

        TRY
            THIS.this_oBusinessObject = CREATEOBJECT("SigPrAopBO")
            IF VARTYPE(THIS.this_oBusinessObject) != "O"
                MsgErro("Erro ao criar objeto de neg" + CHR(243) + "cio SigPrAopBO.", ;
                        "Erro em InicializarForm")
                loc_lSucesso = .F.
            ELSE
                THIS.Picture = gc_4c_CaminhoIcones + "new_background.jpg"

                THIS.ConfigurarPageFrame()
                THIS.ConfigurarGrid()
                THIS.ConfigurarBotoes()
                THIS.ConfigurarCampos()

                THIS.TornarControlesVisiveis(THIS)

                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Erro em InicializarForm")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPageFrame - orquestra a montagem visual do form OPERACIONAL.
    * SIGPRAOP nao tem PageFrame Lista/Dados no legado (herda de "form" puro,
    * nao de frmcadastro) - o metodo eh mantido com este nome por conformidade
    * com o contrato do pipeline e delega para os configuradores especificos.
    * ConfigurarCabecalho() eh montado nesta fase; ConfigurarGrid()/
    * ConfigurarCampos()/ConfigurarBotoes() serao adicionados nas Fases 4-6.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPageFrame()
        THIS.ConfigurarCabecalho()
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarCabecalho - cria o container escuro superior com as labels de
    * titulo (SIGPRAOP.cntSombra.lblSombra/lblTitulo do legado)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarCabecalho()
        LOCAL loc_oCab

        THIS.AddObject("cnt_4c_Cabecalho", "Container")
        loc_oCab = THIS.cnt_4c_Cabecalho
        WITH loc_oCab
            .Top         = 0
            .Left        = 0
            .Width       = THIS.Width
            .Height      = 80
            .BackColor   = RGB(100,100,100)
            .BackStyle   = 1
            .BorderWidth = 0
        ENDWITH

        loc_oCab.AddObject("lbl_4c_Sombra", "Label")
        WITH loc_oCab.lbl_4c_Sombra
            .AutoSize      = .F.
            .Width         = loc_oCab.Width - 20
            .Height        = 40
            .Top           = 18
            .Left          = 10
            .FontName      = "Tahoma"
            .FontSize      = 18
            .FontBold      = .T.
            .FontUnderline = .F.
            .Alignment     = 0
            .BackStyle     = 0
            .WordWrap      = .T.
            .ForeColor     = RGB(0,0,0)
            .Caption       = THIS.Caption
        ENDWITH

        loc_oCab.AddObject("lbl_4c_Titulo", "Label")
        WITH loc_oCab.lbl_4c_Titulo
            .AutoSize      = .F.
            .Width         = loc_oCab.Width - 20
            .Height        = 46
            .Top           = 17
            .Left          = 10
            .FontName      = "Tahoma"
            .FontSize      = 18
            .FontBold      = .T.
            .Alignment     = 0
            .BackStyle     = 0
            .WordWrap      = .T.
            .ForeColor     = RGB(255,255,255)
            .Caption       = THIS.Caption
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarGrid - cria a grade de divisao de quantidade (SIGPRAOP.Grade
    * do legado, RecordSource="Temp_DivOp"). O cursor cursor_4c_DivOp ja
    * existe (vazio) neste ponto - THIS.this_oBusinessObject.CriarCursorItens()
    * roda dentro do Init do BO (chamado em InicializarForm ANTES deste
    * metodo) - sem isso o RecordSource travaria o Init (regra do cursor que
    * ainda nao existe).
    *
    * Colunas na ORDEM VISUAL do legado (ColumnOrder 1..5): Pedido (Dopes +
    * fGerMascara(Numes), somente leitura) / Cor (CodCors, somente leitura) /
    * Tam (CodTams, somente leitura) / Qtd.Atual (Qtds, somente leitura) /
    * Quantidade (QtdDivs, EDITAVEL - eh o campo que o usuario altera para
    * dividir a O.P., Grupo_Conf.Salva.Click grava esse valor de volta em
    * SigOpPic.Qtds/SeqDivs).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarGrid()
        LOCAL loc_oGrid

        THIS.AddObject("grd_4c_Dados", "Grid")
        loc_oGrid = THIS.grd_4c_Dados
        loc_oGrid.ColumnCount  = 5
        loc_oGrid.RecordSource = "cursor_4c_DivOp"
        WITH loc_oGrid
            .Top           = 142
            .Left          = 50
            .Width         = 442
            .Height        = 207
            .FontName      = "Arial"
            .FontSize      = 8
            .GridLines     = 3
            .GridLineWidth = 1
            .HeaderHeight  = 17
            .RowHeight     = 17
            .ScrollBars    = 2
            .DeleteMark    = .F.
            .RecordMark    = .F.

            .Column1.ControlSource   = "ALLTRIM(cursor_4c_DivOp.Dopes) + ' ' + ALLTRIM(fGerMascara(cursor_4c_DivOp.Numes))"
            .Column1.Width           = 180
            .Column1.Alignment       = 0
            .Column1.ReadOnly        = .T.
            .Column1.Movable         = .F.
            .Column1.Resizable       = .F.
            .Column1.FontName        = "Arial"
            .Column1.FontSize        = 8
            .Column1.Header1.Caption = "Pedido"

            .Column2.ControlSource   = "cursor_4c_DivOp.CodCors"
            .Column2.Width           = 38
            .Column2.ReadOnly        = .T.
            .Column2.Movable         = .F.
            .Column2.Resizable       = .F.
            .Column2.FontName        = "Arial"
            .Column2.FontSize        = 8
            .Column2.Header1.Caption = "Cor"

            .Column3.ControlSource   = "cursor_4c_DivOp.CodTams"
            .Column3.Width           = 38
            .Column3.ReadOnly        = .T.
            .Column3.Movable         = .F.
            .Column3.Resizable       = .F.
            .Column3.FontName        = "Arial"
            .Column3.FontSize        = 8
            .Column3.Header1.Caption = "Tam"

            .Column4.ControlSource   = "cursor_4c_DivOp.Qtds"
            .Column4.Width           = 80
            .Column4.Alignment       = 1
            .Column4.InputMask       = "999,999.999"
            .Column4.ReadOnly        = .T.
            .Column4.Movable         = .F.
            .Column4.Resizable       = .F.
            .Column4.FontName        = "Arial"
            .Column4.FontSize        = 8
            .Column4.Header1.Caption = "Qtd.Atual"

            .Column5.ControlSource   = "cursor_4c_DivOp.QtdDivs"
            .Column5.Width           = 80
            .Column5.Format          = "K"
            .Column5.ReadOnly        = .F.
            .Column5.Movable         = .F.
            .Column5.Resizable       = .F.
            .Column5.FontName        = "Arial"
            .Column5.FontSize        = 8
            .Column5.Header1.Caption = "Quantidade"
        ENDWITH

        *-- Legado: Grade.AfterRowColChange -> ThisForm.Get_obss.Refresh
        *-- (o EditBox de observacoes eh ligado por ControlSource direto ao
        *-- cursor - so precisa ser avisado para redesenhar ao mudar de linha)
        BINDEVENT(loc_oGrid, "AfterRowColChange", THIS, "GridAfterRowColChange")
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarBotoes - cria o grupo Confirmar/Encerrar (SIGPRAOP.Grupo_Conf
    * do legado). Top=-2/Left=544 posiciona o grupo flutuando SOBRE a faixa
    * do cabecalho (cnt_4c_Cabecalho, Top=0..80, ja criado por
    * ConfigurarPageFrame ANTES deste metodo - regra da faixa ser o PRIMEIRO
    * AddObject da tela, senao ela cobriria estes botoes).
    *
    * Confirmar (Buttons(1)) grava a divisao de quantidade em SigOpPic/
    * SigPdMvf (equivalente a Grupo_Conf.Salva.Click); Encerrar (Buttons(2))
    * fecha o form (equivalente a Grupo_Conf.Conf_Sair.Click). BINDEVENT dos
    * Click fica para a Fase 7-8, junto com o resto dos eventos do form.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarBotoes()
        LOCAL loc_oGrp

        THIS.AddObject("cmg_4c_Grupo_Conf", "CommandGroup")
        loc_oGrp = THIS.cmg_4c_Grupo_Conf
        WITH loc_oGrp
            .Top          = -2
            .Left         = 544
            .Width        = 160
            .Height       = 85
            .ButtonCount  = 2
            .BackStyle    = 0
            .BorderStyle  = 0
            .SpecialEffect = 1
            .Themes        = .F.

            WITH .Buttons(1)
                .Top        = 5
                .Left       = 5
                .Width      = 75
                .Height     = 75
                .FontName   = "Comic Sans MS"
                .FontSize   = 8
                .FontBold   = .T.
                .FontItalic = .T.
                .Picture    = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
                *-- DisabledPicture: CarregarDados alterna .Enabled deste botao
                *-- (legado: Get_OP.When desliga, Get_OP.Valid religa ao achar
                *-- a O.P.) - sem DisabledPicture o icone some no estado cinza
                .DisabledPicture = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
                *-- "\<Confirmar" preserva a tecla de acesso Alt+C do legado
                .Caption    = "\<Confirmar"
                .ForeColor  = RGB(90, 90, 90)
                .BackColor  = RGB(255, 255, 255)
                .Themes     = .F.
            ENDWITH

            WITH .Buttons(2)
                .Top        = 5
                .Left       = 80
                .Width      = 75
                .Height     = 75
                .FontName   = "Comic Sans MS"
                .FontSize   = 8
                .FontBold   = .T.
                .FontItalic = .T.
                .Picture    = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
                .Cancel     = .T.
                .Caption    = "Encerrar"
                .ForeColor  = RGB(90, 90, 90)
                .BackColor  = RGB(255, 255, 255)
                .Themes     = .F.
            ENDWITH
        ENDWITH

        *-- Legado: Grupo_Conf.Salva.Click / Grupo_Conf.Conf_Sair.Click.
        *-- BINDEVENT no Buttons(N) individual (nao no CommandGroup inteiro) -
        *-- padrao ja adotado em outros forms OPERACIONAIS/REPORT do projeto.
        BINDEVENT(loc_oGrp.Buttons(1), "Click", THIS, "BtnConfirmarClick")
        BINDEVENT(loc_oGrp.Buttons(2), "Click", THIS, "BtnEncerrarClick")
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarCampos - cria os campos de captura/exibicao da tela (SIGPRAOP.
    * Say1/Get_OP/Say2/Get_Produto/Get_obss do legado). Posicoes transcritas
    * EXATAS do dump (regiao acima e abaixo da grade, Top=142/Height=207 - ver
    * ConfigurarGrid): sem necessidade de offset porque o form manteve a
    * escala original de coordenadas do legado (703x436) dentro do canvas
    * 1000x600 (so o cabecalho usa THIS.Width para esticar a faixa).
    *
    * Say1/Say2 nao declaram Alignment no dump (classe "say" pura, AutoSize=.T.
    * por padrao no framework) -> Alignment=0 / AutoSize=.F. com Width fixo
    * (regra de label de dados: nunca inventar Alignment=1).
    *
    * txt_4c_OP (Get_OP): InputMask/MaxLength TRANSCRITOS do legado
    * (InputMask="999999999999", MaxLength=12) - digitacao da O.P.; a consulta
    * dispara em ENTER/TAB por ValidarOP (BINDEVENT no fim deste metodo), que
    * corta para os 10 digitos de SigOpPic.Nops como o Valid legado faz.
    *
    * txt_4c_Produto (Get_Produto): o legado NAO usa fwBuscaExt/sigacess aqui -
    * o campo eh so exibicao, preenchido por CarregarDados/BuscarItensPorOP a
    * partir de SigPdMvf.CodPds (Get_OP.Valid). O bloqueio de digitacao no
    * legado eh feito via PROCEDURE When / Return .f. (nunca recebe foco);
    * .ReadOnly = .T. reproduz o mesmo efeito pratico. NAO ha lookup F4/F5
    * neste form inteiro (nenhum CreateObject('fwbuscaext'/'fwBuscaSel') nem
    * sigacess() no codigo fonte original) - a "busca" da O.P. eh a propria
    * consulta SQL do Valid, ja implementada em CarregarDados (Fase 5).
    *
    * edt_4c_Obss (Get_obss): EditBox somente-leitura ligado por ControlSource
    * direto ao cursor da grade (cursor_4c_DivOp.Obss) - o VFP atualiza o
    * conteudo sozinho a cada mudanca de linha corrente, e AfterRowColChange
    * (Fase 7-8) so precisa dar THIS.edt_4c_Obss.Refresh() para redesenhar,
    * igual ao ThisForm.Get_obss.Refresh do legado.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarCampos()
        THIS.AddObject("lbl_4c_Label1", "Label")
        WITH THIS.lbl_4c_Label1
            .Top       = 93
            .Left      = 70
            .Width     = 31
            .Height    = 15
            .AutoSize  = .F.
            .Alignment = 0
            .BackStyle = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .Caption   = "O.P. :"
        ENDWITH

        THIS.AddObject("txt_4c_OP", "TextBox")
        WITH THIS.txt_4c_OP
            .Top        = 90
            .Left       = 107
            .Width      = 96
            .Height     = 23
            .InputMask  = "999999999999"
            .MaxLength  = 12
            .Value      = ""
        ENDWITH

        THIS.AddObject("lbl_4c_Label2", "Label")
        WITH THIS.lbl_4c_Label2
            .Top       = 117
            .Left      = 50
            .Width     = 47
            .Height    = 15
            .AutoSize  = .F.
            .Alignment = 0
            .BackStyle = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .Caption   = "Produto :"
        ENDWITH

        THIS.AddObject("txt_4c_Produto", "TextBox")
        WITH THIS.txt_4c_Produto
            .Top      = 114
            .Left     = 107
            .Width    = 96
            .Height   = 23
            .ReadOnly = .T.
            .Value    = ""
        ENDWITH

        THIS.AddObject("edt_4c_Obss", "EditBox")
        WITH THIS.edt_4c_Obss
            .Top               = 356
            .Left              = 48
            .Width             = 443
            .Height            = 70
            .ReadOnly          = .T.
            .ControlSource     = "cursor_4c_DivOp.Obss"
            .DisabledBackColor = RGB(255, 255, 255)
        ENDWITH

        *-- Eventos do unico campo digitavel da tela (Get_OP do legado). Os
        *-- handlers sao PUBLIC de proposito: BINDEVENT com metodo PROTECTED
        *-- falha em silencio, e o harness de teste chama estes metodos de fora
        *-- da classe.
        *
        *-- Get_OP.Valid -> "KeyPress", NAO "LostFocus": BINDEVENT em "Valid"
        *-- nao dispara de forma confiavel em TextBox, e LostFocus dispara
        *-- SEMPRE (inclusive por SetFocus de outro controle), o que colocaria a
        *-- consulta SQL da O.P. em recursao. ENTER/TAB reproduzem o momento em
        *-- que o Valid do legado rodava (ao confirmar/sair do campo).
        BINDEVENT(THIS.txt_4c_OP, "KeyPress",  THIS, "TxtOPKeyPress")

        *-- Get_OP.LostFocus -> salto de foco para a coluna editavel da grade.
        *-- Este eh o UNICO evento do form que tem de ficar mesmo em LostFocus:
        *-- o legado salta o foco ao SAIR do campo, nao ao teclar. Nao ha lookup
        *-- aqui (o form nao tem FormBuscaAuxiliar), logo nao ha o risco de
        *-- recursao que motiva a regra "lookup nunca em LostFocus". O handler eh
        *-- nomeado pela ACAO (PularParaGradeAposOP) e nao pelo evento: handler
        *-- com nome terminando em "LostFocus" eh tratado como lookup pelo
        *-- CorretorAutomatico (LOSTFOCUS-LOOKUP, criterio (d) - so o NOME), que
        *-- religava este BINDEVENT em "KeyPress" - o que empilhava um segundo
        *-- handler de KeyPress no mesmo controle, passava dois argumentos a um
        *-- metodo sem parametros e disparava o salto de foco a cada tecla.
        BINDEVENT(THIS.txt_4c_OP, "LostFocus", THIS, "PularParaGradeAposOP")

        *-- Get_OP.When (ThisForm.Grupo_Conf.Salva.Enabled = .f.) -> GotFocus:
        *-- o When do legado roda ao ENTRAR no campo e desliga o Confirmar, que
        *-- o Valid religa ao localizar a O.P. BINDEVENT em "When" nao eh
        *-- confiavel (e o retorno do delegate eh descartado), mas GotFocus
        *-- ocorre no mesmo instante pratico e o efeito colateral eh o mesmo.
        BINDEVENT(THIS.txt_4c_OP, "GotFocus",  THIS, "TxtOPGotFocus")
    ENDPROC

    *--------------------------------------------------------------------------
    * TxtOPGotFocus - Transcreve o PROCEDURE When do Get_OP legado:
    *
    *   ThisForm.Grupo_Conf.Salva.Enabled = .f.
    *
    * Ao voltar para o campo da O.P. o Confirmar eh desligado; CarregarDados o
    * religa quando a O.P. eh localizada (this_lOPLocalizada). Impede gravar a
    * divisao de uma O.P. que o usuario acabou de trocar sem reconsultar.
    *--------------------------------------------------------------------------
    PROCEDURE TxtOPGotFocus()
        IF PEMSTATUS(THIS, "cmg_4c_Grupo_Conf", 5)
            THIS.cmg_4c_Grupo_Conf.Buttons(1).Enabled = .F.
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * TxtOPKeyPress - dispara a validacao da O.P. em ENTER/TAB (o momento em
    * que o Valid do Get_OP legado rodava). F4/F5 NAO tem funcao neste campo:
    * o form inteiro nao possui lookup/picker (nenhum CreateObject('fwbuscaext'
    * /'fwBuscaSel'/'fwBuscaInt') nem sigacess() no codigo fonte original) - a
    * "busca" da O.P. eh a propria consulta SQL do Valid, em SigCdNec/SigPdMvf/
    * SigOpPic. Inventar um picker aqui violaria o PILAR 1.
    *
    * Os DOIS parametros do evento sao obrigatorios na assinatura: handler de
    * KeyPress que nao os declara falha em runtime ("No PARAMETER statement is
    * found"). Declarados aqui na propria PROCEDURE - acrescentar tambem um
    * LPARAMETERS seria declaracao duplicada.
    *--------------------------------------------------------------------------
    PROCEDURE TxtOPKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF VARTYPE(par_nKeyCode) = "N" AND (par_nKeyCode = 13 OR par_nKeyCode = 9)
            THIS.ValidarOP()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * PularParaGradeAposOP - Transcreve o PROCEDURE LostFocus do Get_OP legado
    * (nomeado pela ACAO, nao pelo evento - ver o BINDEVENT em ConfigurarCampos):
    *
    *   If Not Empty(This.Value) And Not Eof('Temp_divOp')
    *       ThisForm.Grade.Column2.Text1.SetFocus
    *   EndIf
    *
    * O legado renomeia as colunas da grade: o objeto chamado "Column2" no SCX
    * eh a coluna DECLARADA em 3o lugar, ControlSource Temp_DivOp.QtdDivs,
    * ColumnOrder = 5 - a unica editavel (as demais tem ReadOnly = .T. e
    * When -> Return .f.). No migrado, que segue a ordem VISUAL, ela eh a
    * Column5. Conferido no dump: Column3.Name = "Column2" / .Format = "K" /
    * sem ReadOnly, e Grade.Column2.Text1.When = On Key Label 'ENTER'.
    *
    * Este handler NAO consulta nada (a consulta fica no KeyPress): LostFocus
    * dispara sempre, e chamar SQL daqui entraria em recursao.
    *--------------------------------------------------------------------------
    PROCEDURE PularParaGradeAposOP()
        LOCAL loc_oBO, loc_cCursor

        loc_oBO = THIS.this_oBusinessObject
        IF VARTYPE(loc_oBO) != "O"
            RETURN
        ENDIF

        loc_cCursor = loc_oBO.this_cCursorItens

        IF !EMPTY(THIS.txt_4c_OP.Value) AND USED(loc_cCursor) AND !EOF(loc_cCursor) ;
           AND PEMSTATUS(THIS, "grd_4c_Dados", 5)
            IF THIS.grd_4c_Dados.Visible AND THIS.grd_4c_Dados.Enabled
                THIS.grd_4c_Dados.Column5.Text1.SetFocus()
            ENDIF
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarOP - Transcreve a parte de CAMPO do PROCEDURE Valid do Get_OP
    * legado (a parte de DADOS mora em CarregarDados/BO.BuscarItensPorOP):
    *
    *   Zap In Temp_DivOp                      -> CarregarDados(0) esvazia a grade
    *   If Empty(This.Value) / Return          -> sai sem avisar nada
    *   If Len(Alltrim(This.Value)) > 10       -\ a coluna SigOpPic.Nops eh
    *       This.Value = Right(This.Value, 10) -/ numeric(10) e o InputMask do
    *                                             campo aceita 12 digitos: o
    *                                             legado corta os excedentes A
    *                                             ESQUERDA, no proprio campo
    *   lnOp = Val( This.Value )               -> par_nNops de CarregarDados
    *
    * O legado NAO valida faixa nem exige minimo de digitos - transcricao
    * literal, sem guard inventado.
    *
    * PUBLIC de proposito (BINDEVENT + harness de teste chamam de fora).
    *--------------------------------------------------------------------------
    PROCEDURE ValidarOP()
        LOCAL loc_cValor, loc_lRet

        loc_lRet = .F.

        *-- Guarda de reentrancia: a consulta move o foco (LostFocus -> SetFocus
        *-- na grade) e o proprio campo pode reentrar aqui antes de terminar
        IF THIS.this_lValidandoOP
            RETURN .F.
        ENDIF

        THIS.this_lValidandoOP = .T.

        *-- Legado: Zap In Temp_DivOp acontece ANTES do teste de vazio, portanto
        *-- limpar o campo e sair tambem esvazia a grade (CarregarDados(0))
        loc_cValor = ALLTRIM(THIS.txt_4c_OP.Value)

        IF EMPTY(loc_cValor)
            loc_lRet = THIS.CarregarDados(0)
        ELSE
            *-- Legado: If (Len(Alltrim(This.Value)) > 10) / This.Value = Right(This.Value, 10)
            IF LEN(loc_cValor) > 10
                loc_cValor = RIGHT(loc_cValor, 10)
                THIS.txt_4c_OP.Value = loc_cValor
            ENDIF

            *-- Legado: lnOp = Val( This.Value )
            loc_lRet = THIS.CarregarDados(VAL(loc_cValor))
        ENDIF

        THIS.this_lValidandoOP = .F.

        RETURN loc_lRet
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDados - popula a grade de divisao de quantidade a partir de uma
    * O.P. Transcreve o PROCEDURE Valid do Get_OP legado:
    *
    *   Zap In Temp_DivOp                      -> BuscarItensPorOP recria o cursor
    *   If Empty(This.Value) / Return          -> par_nNops = 0 apenas esvazia
    *   CursorQuery SigCdNec ... ChkSubn       -\
    *   CursorQuery SigPdMvf ... CodPds        -+-> BuscarItensPorOP (no BO)
    *   Scan SigOpPic / Insert Into Temp_DivOp -/
    *   ThisForm.Get_Produto.Value = CodPds    -> espelha this_cCodProduto
    *   Grupo_Conf.Salva.Enabled = .t.         -> Buttons(1).Enabled
    *   Messagebox 'O.P. Ja Foi Encerrada!!!'  -\
    *   Messagebox 'O.P. Nao Localizada!!!'    -+-> this_cMensagemErro do BO
    *   This.Value = ''                        -> limpa Get_OP no insucesso
    *   ThisForm.Grade.Refresh                 -> GO TOP + grd_4c_Dados.Refresh
    *
    * As duas mensagens do legado so aparecem com O.P. informada: digitar vazio
    * e sair apenas limpa a grade, sem avisar (mesmo comportamento do Valid).
    *
    * PUBLIC de proposito: o harness de teste chama CarregarDados() de fora da
    * classe, e metodo PROTECTED falharia em runtime mesmo passando no PEMSTATUS.
    *
    * Os acessos a txt_4c_Produto/txt_4c_OP/cmg_4c_Grupo_Conf/grd_4c_Dados
    * ficam sob PEMSTATUS defensivamente (o harness de teste pode chamar este
    * metodo em cenarios onde ConfigurarCampos/ConfigurarBotoes/ConfigurarGrid
    * ainda nao rodaram).
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDados(par_nNops)
        LOCAL loc_nNops, loc_lSucesso, loc_oBO

        loc_oBO = THIS.this_oBusinessObject
        IF VARTYPE(loc_oBO) != "O"
            RETURN .F.
        ENDIF

        loc_nNops = IIF(VARTYPE(par_nNops) = "N", par_nNops, 0)

        loc_lSucesso = loc_oBO.BuscarItensPorOP(loc_nNops)

        IF loc_lSucesso
            IF loc_oBO.this_lOPLocalizada
                *-- Legado: ThisForm.Get_Produto.Value = crSigPdMvf.CodPds
                IF PEMSTATUS(THIS, "txt_4c_Produto", 5)
                    THIS.txt_4c_Produto.Value = loc_oBO.this_cCodProduto
                ENDIF
            ELSE
                *-- Legado: avisa (encerrada / nao localizada) e limpa o campo,
                *-- mas so quando alguma O.P. foi de fato digitada
                IF loc_nNops <> 0 AND !EMPTY(loc_oBO.this_cMensagemErro)
                    MsgAviso(loc_oBO.this_cMensagemErro, ;
                             "Aten" + CHR(231) + CHR(227) + "o")
                ENDIF
                IF PEMSTATUS(THIS, "txt_4c_Produto", 5)
                    THIS.txt_4c_Produto.Value = ""
                ENDIF
                IF loc_nNops <> 0 AND PEMSTATUS(THIS, "txt_4c_OP", 5)
                    THIS.txt_4c_OP.Value = ""
                ENDIF
            ENDIF
        ELSE
            MsgErro("N" + CHR(227) + "o foi poss" + CHR(237) + "vel carregar os " + ;
                    "itens da O.P." + CHR(13) + loc_oBO.this_cMensagemErro, ;
                    "Erro em CarregarDados")
        ENDIF

        *-- Legado: Grupo_Conf.Salva.Enabled = .t. no ramo de sucesso (o When do
        *-- Get_OP ja havia desligado), portanto o botao so vale com itens carregados
        IF PEMSTATUS(THIS, "cmg_4c_Grupo_Conf", 5)
            THIS.cmg_4c_Grupo_Conf.Buttons(1).Enabled = loc_oBO.this_lOPLocalizada
        ENDIF

        *-- Legado: Select Temp_DivOp / Go Top / ThisForm.Grade.Refresh
        *-- Popular o cursor NAO repinta a grade sozinho
        IF USED(loc_oBO.this_cCursorItens)
            SELECT (loc_oBO.this_cCursorItens)
            GO TOP
        ENDIF
        IF PEMSTATUS(THIS, "grd_4c_Dados", 5)
            THIS.grd_4c_Dados.Refresh()
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnConfirmarClick - Transcreve o PROCEDURE Salva.Click do Grupo_Conf
    * legado. A parte de GRAVACAO (UPDATE SigOpPic/SigPdMvf + Commit,
    * inclusive o guard "lnOp = Val(Get_OP.Value) / If (lnOp = 0) / Return 0")
    * ja esta implementada em SigPrAopBO.Atualizar() desde a Fase 2 - este
    * metodo so precisa acionar o contrato BusinessBase (EditarRegistro() +
    * Salvar()) e replicar a limpeza feita no SUCESSO do Click legado:
    *
    *   ThisForm.Get_Op.SetFocus / ThisForm.Refresh                    -\
    *   ThisForm.Get_Op.Value = ' ' / ThisForm.Get_Produto.Value = ''  -+-> abaixo
    *   ThisForm.Grupo_Conf.Salva.Enabled = .f.                        -/
    *
    * BusinessBase.Salvar() exige this_lEmEdicao = .T. (senao recusa com
    * "Nao esta em modo de edicao" - regra do contrato da base); este form nao
    * tem Incluir/Alterar separados, entao EditarRegistro() eh chamado aqui,
    * imediatamente antes de Salvar() - a gravacao eh sempre uma redistribuicao
    * de linhas JA existentes em SigOpPic, nunca um novo registro.
    *
    * BO.Salvar()/Atualizar() ja exibem a falha sozinhos (BusinessBase.
    * ExibirFalha) em caso de erro - nenhum ELSE necessario aqui (regra #20).
    *
    * PUBLIC de proposito: BINDEVENT chama este metodo, e metodo PROTECTED
    * falha em silencio (regra #3).
    *--------------------------------------------------------------------------
    PROCEDURE BtnConfirmarClick()
        LOCAL loc_oBO, loc_lSucesso

        loc_oBO = THIS.this_oBusinessObject
        IF VARTYPE(loc_oBO) != "O"
            RETURN
        ENDIF

        loc_oBO.EditarRegistro()

        loc_lSucesso = loc_oBO.Salvar()

        IF loc_lSucesso
            IF PEMSTATUS(THIS, "txt_4c_OP", 5)
                THIS.txt_4c_OP.Value = ""
            ENDIF
            IF PEMSTATUS(THIS, "txt_4c_Produto", 5)
                THIS.txt_4c_Produto.Value = ""
            ENDIF
            IF PEMSTATUS(THIS, "cmg_4c_Grupo_Conf", 5)
                THIS.cmg_4c_Grupo_Conf.Buttons(1).Enabled = .F.
            ENDIF
            *-- Legado: ThisForm.Refresh (Zap In Temp_DivOp ja rodou dentro de
            *-- Atualizar() no sucesso) - grade e observacoes precisam ser
            *-- avisadas para redesenhar vazias (regra: popular/esvaziar cursor
            *-- nao repinta o grid sozinho)
            IF PEMSTATUS(THIS, "grd_4c_Dados", 5)
                THIS.grd_4c_Dados.Refresh()
            ENDIF
            IF PEMSTATUS(THIS, "edt_4c_Obss", 5)
                THIS.edt_4c_Obss.Refresh()
            ENDIF
            IF PEMSTATUS(THIS, "txt_4c_OP", 5)
                THIS.txt_4c_OP.SetFocus()
            ENDIF
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnEncerrarClick - Transcreve o PROCEDURE Conf_Sair.Click do Grupo_Conf
    * legado (ThisForm.Release). O "On Key Label ENTER" do legado apenas limpa
    * um keyboard trap global de ENTER que o MENU CHAMADOR configurava antes de
    * abrir este form modal (unico outro uso de ON KEY LABEL no codigo fonte
    * original, no When da coluna editavel da grade) - o sistema novo nao usa
    * ON KEY LABEL global, entao nao ha trap para limpar aqui.
    *--------------------------------------------------------------------------
    PROCEDURE BtnEncerrarClick()
        THIS.Release()
    ENDPROC

    *--------------------------------------------------------------------------
    * GridAfterRowColChange - Transcreve o PROCEDURE AfterRowColChange da Grade
    * legada: ThisForm.Get_obss.Refresh. O EditBox edt_4c_Obss ja esta ligado
    * por ControlSource direto ao cursor da grade (cursor_4c_DivOp.Obss) - so
    * precisa ser avisado para redesenhar ao mudar de linha/coluna corrente.
    *--------------------------------------------------------------------------
    PROCEDURE GridAfterRowColChange(par_nColIndex)
        IF PEMSTATUS(THIS, "edt_4c_Obss", 5)
            THIS.edt_4c_Obss.Refresh()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * TornarControlesVisiveis - torna todos os controles visiveis recursivamente
    * FILTRO: nenhum container flutuante neste form (sem Visible=.F. condicional
    * no legado - todos os controles de SIGPRAOP sao permanentes na tela)
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
    * Destroy - libera a referencia ao Business Object. SigPrAopBO.Destroy()
    * (disparado automaticamente pelo VFP ao zerar a ultima referencia) libera
    * os cursores de trabalho abertos pelo BO.
    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
        IF VARTYPE(THIS.this_oBusinessObject) = "O"
            THIS.this_oBusinessObject = .NULL.
        ENDIF
        DODEFAULT()
    ENDPROC

ENDDEFINE

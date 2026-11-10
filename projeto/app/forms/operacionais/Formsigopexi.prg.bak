*==============================================================================
* Formsigopexi.prg - Dialogo de Devolucao de Produtos (bipagem por codigo de
* barras), chamado por um form de Movimentacao (parentform) que mantem os
* cursores globais Fortyus ja abertos na MESMA sessao de dados (crTpmMvItn,
* TprMvCab, CrSigCdOpe, CrSigOpCdc, TmpOperacao, xBaixa).
* Equivale a: SIGOPEXI.SCX (Framework Fortyus)
* Herda de: FormBase
*
* Form OPERACIONAL - dialogo MODAL, FLAT (sem PageFrame, sem Page1/Page2): o
* SCX legado nao tem nenhum PageFrame nem container de dados separado - os
* controles (cntSombra, Say7/getBarras, grdDevols, Say1/Say2/Say3 +
* gettotitens/gettotven, confirmar, btnCancelar) sao todos filhos DIRETOS do
* form, igual ao padrao ja adotado em Formsigopagr.prg (mesma familia de
* dialogo operacional, chamado por um form de Movimentacao).
*
* DataSession = 1 (sessao CORRENTE, NAO privada) - o dialogo PRECISA ver os
* cursores que o form chamador ja deixou abertos na sua propria sessao
* (crSigOpExI, crTpmMvItn, TprMvCab, CrSigCdOpe, CrSigOpCdc, TmpOperacao,
* xBaixa); DataSession = 2 isolaria este form numa sessao privada e nenhum
* desses cursores seria visto (DataSession = 1 significa sessao CORRENTE, nao
* sessao privada numero 1 - um form assim, instanciado de dentro de um form
* com DataSession = 2, roda na sessao privada do pai, e o cursor que ele
* criar eh visto normalmente pelo pai). No SCX legado o form nasce com
* DataSession = 2 mas o Init chama imediatamente "Set DataSession to
* pnDatSes" (o numero da sessao do PAI, recebido por parametro) para "pular"
* para a sessao do chamador - o equivalente funcional direto, sem depender
* de um numero de sessao passado por parametro, eh DataSession = 1 no form
* migrado (mesmo padrao de Formsigopagr.prg).
*
* Parametro de Init (equivalente ao legado LPARAMETERS poform, pnDatSes -
* pnDatSes nao tem equivalente aqui, ver paragrafo acima):
*   par_oFormPai - poform: referencia ao form de Movimentacao que abriu este
*                  dialogo. Usado pelo botao Confirmar (fase 7) para chamar
*                  de volta par_oFormPai.ExcluirPro()/ApaIte(), atualizar
*                  par_oFormPai.CItem e repintar par_oFormPai.fwgrade/
*                  fwgradeR - e lido aqui so para espelhar
*                  par_oFormPai.op_escolha (THIS.this_cOpEscolha), igual ao
*                  "thisform.op_escolha = poform.op_escolha" do Init legado.
*                  Leitura defensiva via PEMSTATUS porque o form de
*                  Movimentacao (parentform) ainda nao foi migrado nesta
*                  task - o nome exato da property espelhada no form novo
*                  sera confirmado quando aquele form for migrado.
*
* Historico de fases:
*   Fase 1/2: sigopexiBO.prg (propriedades, CarregarDoCursor, Inserir/
*             Atualizar, AdicionarItemPorBarras, ConfirmarDevolucoes,
*             AvaliarExclusaoProduto, MontarChaveEmpDopNums, AtualizarTotais,
*             ObterDescricaoProduto).
*   Fase 3:   Formsigopexi.prg - estrutura base (Init, InicializarForm,
*             Destroy). Sem ConfigurarPageFrame - este form NAO tem
*             PageFrame nem Page1/Page2 (ver comentario acima).
*   Fase 4:   Estrutura visual completa (todos filhos DIRETOS do form, sem
*             Page1/Page2 - este dialogo NAO tem PageFrame): ConfigurarCabecalho
*             (cnt_4c_Sombra + lbl_4c_LblSombra/LblTitulo), ConfigurarBarras
*             (lbl_4c_Label7 + txt_4c_Barras), ConfigurarGradeDevolucoes
*             (grd_4c_Dados, 4 colunas Item/Barras/Produto/Descricao - todas
*             ReadOnly, igual ao When=.F. do dump em cada Column.Text1),
*             ConfigurarTotais (lbl_4c_Label1 residual oculto + txt_4c_Totitens
*             + lbl_4c_Label2 + txt_4c_Totven + lbl_4c_Label3) e
*             ConfigurarBotoesAcao (cmd_4c_Confirmar/cmd_4c_BtnCancelar,
*             standalone). Column.ControlSource fica VAZIO (CLAUDE.md regra
*             #41 - o cursor crSigOpExI pode ainda nao estar com a estrutura
*             final neste ponto); o bind com o cursor (RecordSource +
*             Column*.ControlSource), o calculo dos totais (BO.
*             AtualizarTotais) e os handlers de clique/Valid ficam para fase
*             posterior, mesmo padrao de Formsigopagr.prg (Fase 4 so
*             estrutura, MontaGrade/eventos em fase seguinte).
*   Fase 5:   CarregarGrade() - bind do grd_4c_Dados ao cursor
*             crSigOpExI (RecordSource + Column1..4.ControlSource) e
*             espelhamento dos totais (BO.AtualizarTotais) em
*             txt_4c_Totitens/txt_4c_Totven, equivalente literal ao bloco
*             "If Used([crSigOpExI]) ... EndIf" do Init legado (ver
*             cabecalho do arquivo). So age quando o cursor JA esta aberto
*             (ele eh aberto pelo form de Movimentacao ANTES deste dialogo
*             ser criado) - CLAUDE.md regra #41. Chamado uma vez em
*             InicializarForm; os handlers que o chamam de novo apos
*             incluir/confirmar/cancelar item (getBarras.Valid, confirmar.
*             Click, btnCancelar.Click) ficam para fase posterior.
*   Fase 6:   ValidarBarras()/BarrasKeyPress() - equivalente ao getBarras.
*             Valid legado (bipagem do codigo de barras). Este form NAO tem
*             lookup F4/FormBuscaAuxiliar (comportamento.json: temLookup=
*             false em todos os metodos) - o "lookup" real desta fase eh a
*             busca do item na movimentacao (crTpmMvItn) por codigo de
*             barras, ja encapsulada em THIS.this_oBusinessObject.
*             AdicionarItemPorBarras() (fase 1/2). BINDEVENT em "KeyPress"
*             (ENTER/TAB), nao em "Valid" (CLAUDE.md regra #3/#35 -
*             BINDEVENT "Valid" nao funciona em TextBox). cmd_4c_Confirmar.
*             Click e cmd_4c_BtnCancelar.Click (equivalentes a confirmar.
*             Click/btnCancelar.Click do legado) ficam para fase posterior.
*   Fase 7:   BtnConfirmarClick()/BtnCancelarClick() - equivalentes a
*             confirmar.Click/btnCancelar.Click do dump (ver SECAO 3 do
*             codigo fonte). NOTA: o meta-prompt generico desta fase pede
*             BtnIncluirClick/BtnAlterarClick/BtnVisualizarClick/
*             BtnExcluirClick (template de form CRUD) - este dialogo
*             OPERACIONAL nao tem esses botoes (mapeamento.json so lista
*             "confirmar" e "btnCancelar"); os eventos reais implementados
*             aqui sao os unicos botoes clicaveis do form. BtnConfirmarClick
*             delega o SCAN da grade de devolucao a THIS.this_oBusinessObject.
*             ConfirmarDevolucoes() (ja implementado na fase 1/2) e so
*             executa, depois, o que o legado fazia contra "parentform"
*             (THIS.this_oFormPai) - CItem, ApaIte(), fwgrade/fwgradeR.
*             Refresh+Produto.SetFocus e o MessageBox+ExcluirPro() por
*             produto elegivel - tudo com leitura defensiva via PEMSTATUS,
*             porque o form de Movimentacao (parentform) ainda nao foi
*             migrado nesta task (ver comentario da property
*             this_oFormPai acima). BtnCancelarClick delega a
*             THIS.this_oBusinessObject.LimparItensDevolucao() (fase 1/2),
*             equivalente a "SELECT crSigOpExI / Zap" do legado.
*   Fase 8:   Consolidacao final - NENHUM metodo novo. O meta-prompt
*             generico desta fase pede BtnBuscarClick/BtnEncerrarClick/
*             BtnSalvarClick/BtnCancelarClick/FormParaBO/BOParaForm/
*             HabilitarCampos/LimparCampos/CarregarLista/
*             AjustarBotoesPorModo - template de form CRUD (Page1=Lista/
*             Page2=Dados, cursor_4c_Dados, modos INCLUIR/ALTERAR/
*             VISUALIZAR/EXCLUIR). Este dialogo NAO tem NENHUM desses
*             elementos: nao tem PageFrame, nao tem grid de LISTA de
*             registros (grd_4c_Dados eh a grade de ITENS da devolucao
*             em edicao, nao uma lista de "registros sigopexi"), nao tem
*             modos de form CRUD e seus UNICOS dois botoes (Confirmar/
*             Cancelar, equivalentes a confirmar/btnCancelar do dump -
*             mapeamento.json nao lista nenhum outro CommandButton) ja
*             tem handler completo desde a Fase 7 (BtnConfirmarClick/
*             BtnCancelarClick). Nao ha BtnBuscarClick/BtnEncerrarClick/
*             BtnSalvarClick a implementar porque esses botoes NAO EXISTEM
*             no form (nem no legado, nem no mapeamento). FormParaBO/
*             BOParaForm nao se aplicam porque o form nao edita um UNICO
*             registro via BO - cada bipagem de codigo de barras grava
*             direto no cursor da grade via THIS.this_oBusinessObject.
*             AdicionarItemPorBarras() (fase 1/2/6), e a gravacao final
*             (tabela sigopexi) acontece dentro de
*             THIS.this_oBusinessObject.ConfirmarDevolucoes() (fase 1/2/7).
*             Conferido: nenhum TODO/FIXME/stub remanescente no Form nem
*             no BO; todos os metodos chamados (ConfirmarDevolucoes,
*             AdicionarItemPorBarras, AtualizarTotais,
*             LimparItensDevolucao, ObterDescricaoProduto,
*             MontarChaveEmpDopNums, AvaliarExclusaoProduto) estao
*             implementados em sigopexiBO.prg. Integracao ao menu.prg NAO
*             se aplica: este eh um dialogo FILHO, instanciado via
*             CREATEOBJECT("Formsigopexi", par_oFormPai) de dentro do form
*             de Movimentacao (ainda nao migrado) - ele depende dos
*             cursores globais Fortyus que o pai deixa abertos
*             (crTpmMvItn, TprMvCab, CrSigCdOpe, CrSigOpCdc, TmpOperacao,
*             xBaixa) e por isso NAO pode ser aberto isoladamente por um
*             item de menu proprio (equivalente ao padrao de
*             Formsigopagr.prg, mesma familia de dialogo). Quando o form
*             de Movimentacao for migrado, o AddObject/CREATEOBJECT dele
*             para "Formsigopexi" ja sera resolvido automaticamente pelo
*             indice de dependencias (start\indice_classes.txt,
*             regenerado sozinho - CLAUDE.md "config.prg - Carga SOB
*             DEMANDA"), sem exigir edicao manual de config.prg/menu.prg
*             nesta task.
*==============================================================================

DEFINE CLASS Formsigopexi AS FormBase

    *-- Propriedades visuais (PILAR 1 - valores exatos do SCX SIGOPEXI)
    Width       = 1000
    Height      = 600
    AutoCenter  = .T.
    BorderStyle = 2
    Caption     = "Devolu" + CHR(231) + CHR(227) + "o de Produtos"
    ShowWindow = 1
    ControlBox  = .F.
    MaxButton   = .F.
    MinButton   = .F.
    TitleBar    = 0
    WindowType  = 1
    DataSession = 1

    *-- Business Object
    this_oBusinessObject = .NULL.

    *-- Referencia ao form de Movimentacao que abriu este dialogo
    *-- (equivalente a "parentform" do dump - ver cabecalho do arquivo)
    this_oFormPai = .NULL.

    *-- Espelha poform.op_escolha do legado - modo da operacao de
    *-- Movimentacao corrente ('INSERIR'/'ALTERAR'/...), usado pelo
    *-- getBarras.When e confirmar.When do dump (fase 7)
    this_cOpEscolha = ""

    *-- Nome do cursor de devolucao usado pela grade (equivalente literal a
    *-- "crSigOpExI" do dump - cursor global Fortyus, criado/populado pelo
    *-- form de Movimentacao ANTES de abrir este dialogo)
    this_cCursorDevolucao = "crSigOpExI"

    *--------------------------------------------------------------------------
    * Init - Guarda a referencia ao form chamador, espelha op_escolha, cria
    * o Business Object e dispara FormBase.Init() (que chama
    * THIS.InicializarForm() via DODEFAULT()).
    *--------------------------------------------------------------------------
    PROCEDURE Init(par_oFormPai)
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        TRY
            IF VARTYPE(par_oFormPai) = "O"
                THIS.this_oFormPai = par_oFormPai
                IF PEMSTATUS(par_oFormPai, "this_cOpEscolha", 5)
                    THIS.this_cOpEscolha = par_oFormPai.this_cOpEscolha
                ELSE
                    IF PEMSTATUS(par_oFormPai, "op_escolha", 5)
                        THIS.this_cOpEscolha = par_oFormPai.op_escolha
                    ENDIF
                ENDIF
            ENDIF

            THIS.this_oBusinessObject = CREATEOBJECT("sigopexiBO")
            IF VARTYPE(THIS.this_oBusinessObject) != "O"
                MsgErro("Erro ao criar Business Object sigopexiBO." + CHR(13) + ;
                    "VARTYPE retornou: " + VARTYPE(THIS.this_oBusinessObject), ;
                    "Formsigopexi.Init")
            ELSE
                *-- DODEFAULT() dispara FormBase.Init() que chama THIS.InicializarForm()
                loc_lSucesso = DODEFAULT()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Formsigopexi.Init")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * InicializarForm - Fundo do form + estrutura visual completa (cntSombra,
    * getBarras, grdDevols, labels de total, confirmar, btnCancelar) - este
    * form NAO tem PageFrame nem container de dados (o SCX legado tambem nao
    * tem - ver cabecalho do arquivo). Ordem de criacao IDENTICA a arvore do
    * dump (SECAO 1): cntSombra, Say7+getBarras, grdDevols, Say1+gettotitens+
    * Say2+gettotven+Say3, confirmar+btnCancelar. Bind do grid ao cursor
    * crSigOpExI (Column*.ControlSource, que fica VAZIO aqui) e o calculo dos
    * totais ficam para fase posterior (CLAUDE.md regra #41 - o cursor pode
    * ainda nao estar populado neste ponto, mesmo padrao de
    * Formsigopagr.ConfigurarGradeItens/MontaGrade). Chamado automaticamente
    * por FormBase.Init() via DODEFAULT().
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        TRY
            *-- Fundo do form (imagem do Framework Fortyus legado:
            *-- "..\framework\imagens\new_background.jpg" no SCX)
            THIS.Picture = gc_4c_CaminhoFramework + "imagens\new_background.jpg"

            THIS.ConfigurarCabecalho()
            THIS.ConfigurarBarras()
            THIS.ConfigurarGradeDevolucoes()
            THIS.ConfigurarTotais()
            THIS.ConfigurarBotoesAcao()
            THIS.CarregarGrade()

            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Formsigopexi.InicializarForm")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarCabecalho - Faixa cinza do topo (SIGOPEXI.cntSombra do dump),
    * filha DIRETA do form (sem compensacao +29 - nao ha PageFrame). Detectada
    * por BackColor=RGB(100,100,100)+Height>=60 (CLAUDE.md regra #11).
    * lblSombra/lblTitulo recebem Caption = THIS.Caption diretamente aqui
    * (equivalente a "ThisForm.cntSombra.lblSombra.Caption = ThisForm.Caption"
    * do Init legado - a classe "say" do dump so tinha o texto residual
    * "Cadastro de Testes", sobrescrito em runtime pelo proprio Init).
    * AddObject dos labels fica FORA do WITH do container, e cada WITH usa o
    * caminho explicito completo (NUNCA "WITH .filho" aninhado logo apos
    * ".AddObject" - props ficariam SILENCIOSAMENTE ignoradas).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarCabecalho()
        LOCAL loc_cCaption
        loc_cCaption = THIS.Caption

        THIS.AddObject("cnt_4c_Sombra", "Container")
        WITH THIS.cnt_4c_Sombra
            .Top         = 0
            .Left        = 0
            .Width       = THIS.Width
            .Height      = 80
            .BackColor   = RGB(100, 100, 100)
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH

        THIS.cnt_4c_Sombra.AddObject("lbl_4c_LblSombra", "Label")
        WITH THIS.cnt_4c_Sombra.lbl_4c_LblSombra
            .Top        = 18
            .Left       = 10
            .Width      = 769
            .Height     = 40
            .FontName   = "Tahoma"
            .FontSize   = 18
            .FontBold   = .T.
            .WordWrap   = .T.
            .Alignment  = 0
            .BackStyle  = 0
            .ForeColor  = RGB(0, 0, 0)
            .Caption    = loc_cCaption
            .Visible    = .T.
        ENDWITH

        THIS.cnt_4c_Sombra.AddObject("lbl_4c_LblTitulo", "Label")
        WITH THIS.cnt_4c_Sombra.lbl_4c_LblTitulo
            .Top         = 17
            .Left        = 10
            .Width       = 769
            .Height      = 46
            .FontName    = "Tahoma"
            .FontSize    = 18
            .FontBold    = .T.
            .WordWrap    = .T.
            .Alignment   = 0
            .BackStyle   = 0
            .ForeColor   = RGB(255, 255, 255)
            .ToolTipText = "T" + CHR(237) + "tulo do Relat" + CHR(243) + "rio"
            .Caption     = loc_cCaption
            .Visible     = .T.
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarBarras - Say7 ("Barra :") + getBarras (campo de bipagem do
    * codigo de barras), filhos DIRETOS do form. getBarras.Enabled replica o
    * When do dump ("Return Inlist(ThisForm.Op_Escolha, [INSERIR],
    * [ALTERAR])"), avaliado AQUI na criacao - THIS.this_cOpEscolha ja foi
    * atribuido em Init() antes do DODEFAULT() que chama este metodo
    * (CLAUDE.md regra sobre Enabled=.F. em runtime apagar icone so se aplica
    * a mudanca POSTERIOR a criacao - aqui nao ha Picture, entao nem isso se
    * aplica). InputMask com 14 noves = largura exata de cbars numeric(14,0).
    * lbl_4c_Label7.Width = 42 (nao autosize, regra #23) - derivado do GAP do
    * dump (getBarras.Left=61 - Say7.Left=16 = 45px, menos margem), NUNCA do
    * tamanho do texto, para nao invadir o TextBox vizinho.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarBarras()
        LOCAL loc_lHabilitado
        loc_lHabilitado = INLIST(THIS.this_cOpEscolha, "INSERIR", "ALTERAR")

        THIS.AddObject("lbl_4c_Label7", "Label")
        WITH THIS.lbl_4c_Label7
            .Top       = 87
            .Left      = 16
            .Width     = 42
            .Height    = 17
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Alignment = 0
            .BackStyle = 0
            .ForeColor = RGB(0, 0, 0)
            .Caption   = "Barra :"
            .Visible   = .T.
        ENDWITH

        THIS.AddObject("txt_4c_Barras", "TextBox")
        WITH THIS.txt_4c_Barras
            .Top       = 84
            .Left      = 61
            .Width     = 108
            .Height    = 24
            .Alignment = 3
            .Value     = 0
            .Format    = "K!"
            .InputMask = "99999999999999"
            .BackColor = RGB(234, 255, 234)
            .Enabled   = loc_lHabilitado
            .Visible   = .T.
        ENDWITH

        *-- BINDEVENT em "Valid" nao dispara de forma confiavel em TextBox
        *-- (CLAUDE.md regra #3/#35) - equivalente ao getBarras.Valid legado
        *-- vive em ValidarBarras(), disparado no KeyPress (ENTER/TAB), igual
        *-- ao fluxo natural de bipagem por leitor de codigo de barras.
        BINDEVENT(THIS.txt_4c_Barras, "KeyPress", THIS, "BarrasKeyPress")
    ENDPROC

    *--------------------------------------------------------------------------
    * BarrasKeyPress - dispara ValidarBarras() em ENTER(13)/TAB(9), igual ao
    * getBarras.Valid legado (que roda ao SAIR do campo).
    *--------------------------------------------------------------------------
    PROCEDURE BarrasKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 13 OR par_nKeyCode = 9
            THIS.ValidarBarras()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarBarras - equivalente literal ao getBarras.Valid do dump (ver
    * cabecalho do arquivo): delega a THIS.this_oBusinessObject.
    * AdicionarItemPorBarras() e trata os 4 status possiveis exatamente como
    * o legado:
    *   "OK"          - limpa o campo, espelha os totais recalculados pelo
    *                   BO (AtualizarTotais, chamado dentro do proprio
    *                   AdicionarItemPorBarras) em txt_4c_Totitens/
    *                   txt_4c_Totven, GO TOP + Refresh na grade (cursor
    *                   populado nao repinta a grade sozinho).
    *   "BLOQUEADO"   - MsgAviso igual ao MessageBox(...,0+48,...) legado;
    *                   NAO limpa o campo (o legado tambem nao limpa aqui -
    *                   so no caminho INEXISTENTE).
    *   "INEXISTENTE" - MsgAviso igual ao MessageBox(...,64,'Aviso') legado;
    *                   limpa o campo (This.Value = 0 no legado).
    *   "DUPLICADO"   - nenhuma acao (o legado tambem ignora em silencio -
    *                   "If Eof([csProcura])" sem ELSE para o caso
    *                   duplicado).
    * SetFocus no fim devolve o foco ao campo de barras para a leitura
    * seguinte (equivalente ao foco que o legado mantem no campo ao
    * retornar .F. do Valid).
    *--------------------------------------------------------------------------
    PROCEDURE ValidarBarras()
        LOCAL loc_nBarras, loc_cStatus, loc_cCursor

        loc_nBarras = THIS.txt_4c_Barras.Value
        loc_cCursor = THIS.this_cCursorDevolucao

        *-- Equivalente a "If Not Empty(This.Value)" do legado
        IF VARTYPE(loc_nBarras) != "N" OR loc_nBarras = 0
            RETURN
        ENDIF

        loc_cStatus = THIS.this_oBusinessObject.AdicionarItemPorBarras(loc_nBarras, loc_cCursor)

        DO CASE
            CASE loc_cStatus == "OK"
                THIS.txt_4c_Barras.Value   = 0
                THIS.txt_4c_Totitens.Value = THIS.this_oBusinessObject.this_nTotalItens
                THIS.txt_4c_Totven.Value   = THIS.this_oBusinessObject.this_nTotalValor

                IF USED(loc_cCursor)
                    SELECT (loc_cCursor)
                    GO TOP
                ENDIF
                THIS.grd_4c_Dados.Refresh()

            CASE loc_cStatus == "BLOQUEADO"
                MsgAviso("C" + CHR(243) + "digo do Produto n" + CHR(227) + "o pode ser Alterado", ;
                    "Opera" + CHR(231) + CHR(227) + "o com Baixa Parcial")

            CASE loc_cStatus == "INEXISTENTE"
                MsgAviso("Item inexistente nessa opera" + CHR(231) + CHR(227) + "o", "Aviso")
                THIS.txt_4c_Barras.Value = 0

            OTHERWISE
                *-- "DUPLICADO" - sem acao, igual ao legado
        ENDCASE

        IF THIS.txt_4c_Barras.Enabled
            THIS.txt_4c_Barras.SetFocus()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarGradeDevolucoes - grdDevols do dump (grd_4c_Dados), filha
    * DIRETA do form, 4 colunas (Item/Barras/Produto/Descricao). Larguras,
    * ColumnOrder, Format/InputMask e headers EXATOS do dump (SECAO 2 -
    * "PROPRIEDADES DE: SIGOPEXI.grdDevols" - a extracao lista as 4 colunas
    * fora de ordem, mas o campo .Name de cada grupo confere com o Column
    * real: grupo rotulado "Column2" no dump pertence a Column3/"Produto",
    * grupo "Column3" pertence a Column4/"Descricao", grupo "Column4"
    * pertence a Column2/"Barras"). Column*.ControlSource fica VAZIO
    * propositalmente - ver comentario de InicializarForm.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarGradeDevolucoes()
        LOCAL loc_oGrid

        THIS.AddObject("grd_4c_Dados", "Grid")
        loc_oGrid = THIS.grd_4c_Dados
        WITH loc_oGrid
            .Top               = 112
            .Left              = 9
            .Width             = 809
            .Height            = 452
            .ColumnCount       = 4
            .FontName          = "Courier New"
            .AllowHeaderSizing = .F.
            .DeleteMark        = .F.
            .RecordMark        = .F.
            .HeaderHeight      = 16
            .ScrollBars        = 2
            .ToolTipText       = "Grade de Produtos Para Devolu" + CHR(231) + CHR(227) + "o"
            .Visible           = .T.
        ENDWITH

        *-- Column1: Item (crSigOpExI.CItens)
        WITH loc_oGrid.Column1
            .FontName          = "Courier New"
            .ControlSource     = ""
            .Width             = 31
            .Movable           = .F.
            .Resizable         = .F.
            .ReadOnly          = .T.
            .Format            = "K!"
            .InputMask         = "9999"
            .Visible           = .T.
            .Header1.FontName  = "Arial"
            .Header1.FontSize  = 8
            .Header1.Alignment = 2
            .Header1.Caption   = "Item"
            .Text1.Margin      = 0
            .Text1.ReadOnly    = .T.
        ENDWITH

        *-- Column2: Barras (crSigOpExI.CBars) - ColumnOrder 2
        WITH loc_oGrid.Column2
            .FontName          = "Courier New"
            .ColumnOrder       = 2
            .ControlSource     = ""
            .Width             = 108
            .Movable           = .F.
            .Resizable         = .F.
            .ReadOnly          = .T.
            .InputMask         = "99999999999999"
            .Visible           = .T.
            .Header1.FontName  = "Arial"
            .Header1.FontSize  = 8
            .Header1.Alignment = 2
            .Header1.Caption   = "Barras"
            .Text1.FontName    = "Courier New"
            .Text1.Alignment   = 3
            .Text1.BorderStyle = 0
            .Text1.InputMask   = "99999999"
            .Text1.Margin      = 0
            .Text1.ReadOnly    = .T.
            .Text1.ForeColor   = RGB(0, 0, 0)
        ENDWITH

        *-- Column3: Produto (crSigOpExI.CPros) - ColumnOrder 3
        WITH loc_oGrid.Column3
            .FontName          = "Courier New"
            .ColumnOrder       = 3
            .ControlSource     = ""
            .Width             = 122
            .Movable           = .F.
            .Resizable         = .F.
            .ReadOnly          = .T.
            .Visible           = .T.
            .Header1.FontName  = "Arial"
            .Header1.FontSize  = 8
            .Header1.Alignment = 2
            .Header1.Caption   = "Produto"
            .Text1.ReadOnly    = .T.
        ENDWITH

        *-- Column4: Descricao (crSigOpExI.DPros) - ColumnOrder 4
        WITH loc_oGrid.Column4
            .FontName          = "Courier New"
            .ColumnOrder       = 4
            .ControlSource     = ""
            .Width             = 513
            .Resizable         = .F.
            .ReadOnly          = .T.
            .Visible           = .T.
            .Header1.FontName  = "Arial"
            .Header1.FontSize  = 8
            .Header1.Alignment = 2
            .Header1.Caption   = "Descri" + CHR(231) + CHR(227) + "o"
            .Text1.Height      = 23
            .Text1.Left        = 35
            .Text1.Top         = 19
            .Text1.Width       = 100
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarTotais - Say1 (residual, invisivel no dump - Visible = .F.),
    * gettotitens, Say2, gettotven, Say3, filhos DIRETOS do form. gettotitens/
    * gettotven sao SEMPRE ReadOnly (When do dump retorna .F. nos dois) - os
    * valores sao calculados pelo BO (AtualizarTotais) e espelhados aqui em
    * fase posterior, junto com o bind do grid. lbl_4c_Label2/Label3.Width
    * (64/70, regra #23) vem do GAP do dump ate o proximo TextBox
    * (gettotitens.Left=89 - Say2.Left=22 / gettotven.Left=249 - Say3.Left=176),
    * nao do tamanho do texto - evita invadir o campo vizinho.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarTotais()
        THIS.AddObject("lbl_4c_Label1", "Label")
        WITH THIS.lbl_4c_Label1
            .Top       = 24
            .Left      = 370
            .Width     = 300
            .Height    = 25
            .FontName  = "Tahoma"
            .FontSize  = 16
            .ForeColor = RGB(0, 0, 0)
            .Caption   = "Devolu" + CHR(231) + CHR(227) + "o de Produtos"
            .Visible   = .F.
        ENDWITH

        THIS.AddObject("txt_4c_Totitens", "TextBox")
        WITH THIS.txt_4c_Totitens
            .Top       = 569
            .Left      = 89
            .Width     = 66
            .Height    = 23
            .Alignment = 3
            .Value     = 0
            .Format    = "K!"
            .BackColor = RGB(234, 255, 234)
            .ReadOnly  = .T.
            .Visible   = .T.
        ENDWITH

        THIS.AddObject("lbl_4c_Label2", "Label")
        WITH THIS.lbl_4c_Label2
            .Top       = 574
            .Left      = 22
            .Width     = 64
            .Height    = 17
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Alignment = 0
            .BackStyle = 0
            .ForeColor = RGB(0, 0, 0)
            .Caption   = "Total itens:"
            .Visible   = .T.
        ENDWITH

        THIS.AddObject("txt_4c_Totven", "TextBox")
        WITH THIS.txt_4c_Totven
            .Top       = 569
            .Left      = 249
            .Width     = 80
            .Height    = 23
            .Alignment = 3
            .Value     = 0
            .Format    = "K!"
            .BackColor = RGB(234, 255, 234)
            .ReadOnly  = .T.
            .Visible   = .T.
        ENDWITH

        THIS.AddObject("lbl_4c_Label3", "Label")
        WITH THIS.lbl_4c_Label3
            .Top       = 574
            .Left      = 176
            .Width     = 70
            .Height    = 17
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Alignment = 0
            .BackStyle = 0
            .ForeColor = RGB(0, 0, 0)
            .Caption   = "Total valor:"
            .Visible   = .T.
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarBotoesAcao - confirmar/btnCancelar do dump (cmd_4c_Confirmar/
    * cmd_4c_BtnCancelar), CommandButtons standalone (fora de CommandGroup),
    * filhos DIRETOS do form. FontName = "Comic Sans MS" - a classe fwbtng do
    * dump nao reescreve FontName/FontBold/FontItalic (herdados da classe),
    * mas a tabela de fontes usadas (SECAO 2, rodape) lista "Comic Sans MS"
    * e nenhum outro controle deste form usa essa fonte - e exatamente o
    * padrao canonico dos botoes CRUD do projeto (framework_frmcadastro_layout.md).
    * .Themes = .T. + .DisabledPicture (CLAUDE.md - standalone CommandButton
    * com .Picture definido exige isso para o icone renderizar).
    * cmd_4c_Confirmar.Enabled replica o When do dump ("Return
    * Inlist(ThisForm.Op_Escolha, [INSERIR], [ALTERAR])"), avaliado na
    * criacao (mesmo raciocinio de ConfigurarBarras). btnCancelar nao tem
    * When no dump - sempre habilitado.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarBotoesAcao()
        LOCAL loc_lHabilitado
        loc_lHabilitado = INLIST(THIS.this_cOpEscolha, "INSERIR", "ALTERAR")

        THIS.AddObject("cmd_4c_Confirmar", "CommandButton")
        WITH THIS.cmd_4c_Confirmar
            .Top            = 3
            .Left           = 848
            .Width          = 75
            .Height         = 75
            .FontName       = "Comic Sans MS"
            .FontSize       = 8
            .FontBold       = .T.
            .FontItalic     = .T.
            .Caption        = "Confirmar"
            .Picture        = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
            .DisabledPicture = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
            .PicturePosition = 13
            .ForeColor      = RGB(90, 90, 90)
            .BackColor      = RGB(255, 255, 255)
            .Themes         = .T.
            .WordWrap       = .T.
            .MousePointer   = 15
            .SpecialEffect  = 0
            .Enabled        = loc_lHabilitado
            .Visible        = .T.
        ENDWITH
        BINDEVENT(THIS.cmd_4c_Confirmar, "Click", THIS, "BtnConfirmarClick")

        THIS.AddObject("cmd_4c_BtnCancelar", "CommandButton")
        WITH THIS.cmd_4c_BtnCancelar
            .Top            = 3
            .Left           = 923
            .Width          = 75
            .Height         = 75
            .FontName       = "Comic Sans MS"
            .FontSize       = 8
            .FontBold       = .T.
            .FontItalic     = .T.
            .Caption        = "Retornar"
            .Picture        = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
            .DisabledPicture = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
            .PicturePosition = 13
            .Cancel         = .T.
            .ForeColor      = RGB(90, 90, 90)
            .BackColor      = RGB(255, 255, 255)
            .Themes         = .T.
            .WordWrap       = .T.
            .MousePointer   = 15
            .SpecialEffect  = 0
            .Visible        = .T.
        ENDWITH
        BINDEVENT(THIS.cmd_4c_BtnCancelar, "Click", THIS, "BtnCancelarClick")
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnConfirmarClick - equivalente ao confirmar.Click do dump (SECAO 3).
    * O SCAN sobre a grade de devolucao (localizar por codigo de barras em
    * crTpmMvItn, excluir item/componentes, estornar xBaixa, renumerar
    * CItens, avaliar exclusao de produto) ja foi inteiramente portado para
    * THIS.this_oBusinessObject.ConfirmarDevolucoes() (fase 1/2). Este
    * metodo so executa, depois, o que o legado fazia contra
    * "Thisform.parentform" - responsabilidade de UI/navegacao do form
    * chamador, nao do BO (ver cabecalho de ConfirmarDevolucoes no BO):
    *   - "Thisform.parentform.CItem = Cont"
    *   - "Thisform.parentform.ApaIte()" (so quando o BO sinaliza
    *     this_lChamouApaIte, equivalente ao ramo Else do "If xApaga.Total > 1")
    *   - "With Thisform.parentform.fwgrade/fwgradeR / If .Visible /
    *     .Refresh / .Produto.SetFocus / EndWith"
    *   - "If MessageBox('Deseja Excluir O Cadastro de Produto ? ',
    *     4+16+256,'') = 6 / =ThisForm.parentform.ExcluirPro(_cPro)" - uma
    *     pergunta por produto elegivel, acumulados pelo BO em
    *     this_cProdutosParaExcluir (AvaliarExclusaoProduto)
    * Leitura/chamada em THIS.this_oFormPai sempre via PEMSTATUS - o form
    * de Movimentacao (parentform) ainda nao foi migrado nesta task (ver
    * comentario da property this_oFormPai no topo do arquivo); a mensagem
    * de confirmacao usa MsgConfirma() (CLAUDE.md - MESSAGEBOX proibido).
    * "Set Confirm off" do legado nao tem equivalente na arquitetura nova
    * (SET global de navegacao de cursor, sem efeito aqui).
    *--------------------------------------------------------------------------
    PROCEDURE BtnConfirmarClick()
        LOCAL loc_oErro, loc_cCursor, loc_cProdutos, loc_nI, loc_cProduto

        loc_cCursor = THIS.this_cCursorDevolucao

        TRY
            IF THIS.this_oBusinessObject.ConfirmarDevolucoes(loc_cCursor)

                *-- "Thisform.parentform.CItem = Cont"
                IF VARTYPE(THIS.this_oFormPai) = "O" AND PEMSTATUS(THIS.this_oFormPai, "CItem", 5)
                    THIS.this_oFormPai.CItem = THIS.this_oBusinessObject.this_nNovoCItem
                ENDIF

                *-- "Thisform.parentform.ApaIte()"
                IF THIS.this_oBusinessObject.this_lChamouApaIte
                    IF VARTYPE(THIS.this_oFormPai) = "O" AND PEMSTATUS(THIS.this_oFormPai, "ApaIte", 5)
                        THIS.this_oFormPai.ApaIte()
                    ENDIF
                ENDIF

                *-- "With Thisform.parentform.fwgrade / If .Visible / .Refresh /
                *-- .Produto.SetFocus / EndWith" (e o mesmo bloco para fwgradeR)
                IF VARTYPE(THIS.this_oFormPai) = "O"
                    IF PEMSTATUS(THIS.this_oFormPai, "fwgrade", 5)
                        IF THIS.this_oFormPai.fwgrade.Visible
                            THIS.this_oFormPai.fwgrade.Refresh()
                            IF PEMSTATUS(THIS.this_oFormPai.fwgrade, "Produto", 5)
                                THIS.this_oFormPai.fwgrade.Produto.SetFocus()
                            ENDIF
                        ENDIF
                    ENDIF
                    IF PEMSTATUS(THIS.this_oFormPai, "fwgradeR", 5)
                        IF THIS.this_oFormPai.fwgradeR.Visible
                            THIS.this_oFormPai.fwgradeR.Refresh()
                            IF PEMSTATUS(THIS.this_oFormPai.fwgradeR, "Produto", 5)
                                THIS.this_oFormPai.fwgradeR.Produto.SetFocus()
                            ENDIF
                        ENDIF
                    ENDIF
                ENDIF

                *-- "If MessageBox('Deseja Excluir O Cadastro de Produto ? ',
                *-- 4+16+256,'') = 6 / =ThisForm.parentform.ExcluirPro(_cPro)"
                *-- - uma pergunta por produto elegivel acumulado pelo BO
                loc_cProdutos = THIS.this_oBusinessObject.this_cProdutosParaExcluir
                IF !EMPTY(loc_cProdutos)
                    FOR loc_nI = 1 TO GETWORDCOUNT(loc_cProdutos, ",")
                        loc_cProduto = GETWORDNUM(loc_cProdutos, loc_nI, ",")
                        IF !EMPTY(loc_cProduto)
                            IF MsgConfirma("Deseja Excluir O Cadastro de Produto ?", "")
                                IF VARTYPE(THIS.this_oFormPai) = "O" AND PEMSTATUS(THIS.this_oFormPai, "ExcluirPro", 5)
                                    THIS.this_oFormPai.ExcluirPro(loc_cProduto)
                                ENDIF
                            ENDIF
                        ENDIF
                    ENDFOR
                ENDIF

                THIS.FecharDialogo()
            ELSE
                MsgErro("N" + CHR(227) + "o foi poss" + CHR(237) + "vel confirmar a devolu" + CHR(231) + CHR(227) + "o.", "Confirmar")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Formsigopexi.BtnConfirmarClick")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnCancelarClick - equivalente ao btnCancelar.Click do dump: "SELECT
    * crSigOpExI / Zap" (THIS.this_oBusinessObject.LimparItensDevolucao(),
    * fase 1/2) seguido de Release(). "Set Confirm off" sem equivalente
    * (ver comentario de BtnConfirmarClick).
    *--------------------------------------------------------------------------
    PROCEDURE BtnCancelarClick()
        THIS.this_oBusinessObject.LimparItensDevolucao(THIS.this_cCursorDevolucao)
        THIS.FecharDialogo()
    ENDPROC

    *--------------------------------------------------------------------------
    * FecharDialogo - Metodo unico de encerramento deste dialogo filho MODAL,
    * chamado tanto por BtnConfirmarClick (apos confirmar com sucesso) quanto
    * por BtnCancelarClick (apos limpar a grade) - mesmo padrao canonico ja
    * adotado nos demais dialogos filho da familia (FormSigOpChb/
    * Formsigopcks/FormSigOpCoc/FormSIGPRTRF/FormSigOpCot). PUBLIC (sem
    * PROTECTED) - CLAUDE.md regra #3: TesteAutomatico.prg verifica a
    * existencia deste metodo por PEMSTATUS de fora da classe.
    *--------------------------------------------------------------------------
    PROCEDURE FecharDialogo()
        THIS.Release()
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarGrade - Liga grd_4c_Dados ao cursor de devolucao
    * (THIS.this_cCursorDevolucao, igual a "crSigOpExI" - aberto pelo form
    * de Movimentacao ANTES deste dialogo ser criado) e espelha os totais
    * calculados pelo BO (sigopexiBO.AtualizarTotais) em txt_4c_Totitens/
    * txt_4c_Totven - equivalente literal ao bloco "If Used([crSigOpExI])
    * ... EndIf" do Init legado (ver cabecalho do arquivo). So faz algo se
    * o cursor JA estiver aberto (CLAUDE.md regra #41 - Column.ControlSource
    * de cursor ainda inexistente derruba o Init); se nao estiver, a grade
    * fica com ControlSource vazio (ja deixado assim em
    * ConfigurarGradeDevolucoes). GO TOP + Grid.Refresh no fim (cursor
    * populado nao repinta a grade sozinho).
    *--------------------------------------------------------------------------
    PROCEDURE CarregarGrade()
        LOCAL loc_cCursor

        loc_cCursor = THIS.this_cCursorDevolucao

        IF USED(loc_cCursor)
            *-- Equivalente a "IF TYPE('crSigOpExI.CItens') = 'U' / SELECT * ,
            *-- 0000000000 as citens, SPACE(50) as dpros from crSigOpeXi into
            *-- cursor crSigOpeXi readwrite / ENDIF" do Init legado - acrescenta
            *-- as 2 colunas somente-memoria (citens/dpros, ver cabecalho do
            *-- BO) quando o cursor ainda nao as tem (o form de Movimentacao
            *-- pode te-lo aberto so com as colunas da tabela sigopexi).
            IF TYPE(loc_cCursor + ".citens") = "U"
                SELECT * , 0000000000 AS citens, SPACE(50) AS dpros ;
                    FROM (loc_cCursor) INTO CURSOR (loc_cCursor) READWRITE
            ENDIF

            *-- RecordSource/ControlSource RESETAM Column.Width e
            *-- Header1.Caption (Problema 48/FormCor Licoes Aprendidas) -
            *-- reconfigurar os dois IMEDIATAMENTE depois, na mesma ordem
            *-- em que foram definidos em ConfigurarGradeDevolucoes.
            *-- RecordSource fica FORA do WITH (referencia explicita) -
            *-- dentro do mesmo WITH que acessa .ColumnN, o VFP9 ainda nao
            *-- recriou as colunas e estoura "Unknown member COLUMN1".
            THIS.grd_4c_Dados.RecordSource = loc_cCursor

            WITH THIS.grd_4c_Dados
                .Column1.ControlSource = loc_cCursor + ".CItens"
                .Column2.ControlSource = loc_cCursor + ".CBars"
                .Column3.ControlSource = loc_cCursor + ".CPros"
                .Column4.ControlSource = loc_cCursor + ".DPros"

                .Column1.Width           = 31
                .Column1.Header1.Caption = "Item"

                .Column2.Width           = 108
                .Column2.Header1.Caption = "Barras"

                .Column3.Width           = 122
                .Column3.Header1.Caption = "Produto"

                .Column4.Width           = 513
                .Column4.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
            ENDWITH

            THIS.this_oBusinessObject.AtualizarTotais(loc_cCursor)
            THIS.txt_4c_Totitens.Value = THIS.this_oBusinessObject.this_nTotalItens
            THIS.txt_4c_Totven.Value   = THIS.this_oBusinessObject.this_nTotalValor

            SELECT (loc_cCursor)
            GO TOP
            THIS.grd_4c_Dados.Refresh()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * Destroy - Libera a referencia ao form chamador e chama DODEFAULT()
    * (CLAUDE.md regra #29 - Destroy sem DODEFAULT: FormBase.Destroy() faz o
    * RELEASE POPUP + CriarMenuPrincipal() que evita o menu "encolher" apos
    * fechar form modal, alem de liberar THIS.this_oBusinessObject).
    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
        THIS.this_oFormPai = .NULL.
        DODEFAULT()
    ENDPROC

ENDDEFINE

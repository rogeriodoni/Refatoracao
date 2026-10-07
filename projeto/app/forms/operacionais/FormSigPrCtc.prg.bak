*==============================================================================
* FormSigPrCtc.prg - Formulario Operacional: Cotacoes por Operacoes
* Herda de: FormBase
* Origem:  SIGPRCTC.SCX (dialogo modal filho, aberto por um form pai ainda
*          nao migrado - "LParameters poForm, pnDataSes, pcEscolha, pcEmps,
*          pcDopes, pnNumes". O comentario morto do Init legado
*          ("Thisform.ParentForm.Pagina.Lista.Grade...") mostra que o pai eh
*          um frmcadastro (tem .Pagina.Lista.Grade); nenhum dump ja migrado
*          neste pipeline instancia SIGPRCTC ainda, entao a assinatura do
*          Init abaixo eh a fonte da verdade ate o pai ser migrado.
* BO:      SigPrCtcBO (ver classes\SigPrCtcBO.prg)
*
* IMPORTANTE - formType: o task_state.json (etapa 03_gerarMetaPrompt) rotulou
* este form como "CRUD", mas analise.json (etapa 02b) e o dump do legado
* concordam: "OPERACIONAL". A arvore de objetos do SCX prova isso - raiz
* "Class: form / BaseClass: form" (generico, NAO frmcadastro) e ZERO
* "BaseClass: pageframe" - exatamente o ramo FLAT COM CONTAINER descrito em
* [[feedback_gate_fase3_exige_container_inexistente]] /
* [[feedback_gate_fase3_exige_pageframe_inexistente]]. Duas migracoes
* anteriores deste mesmo form documentam os dois erros classicos:
*   - task169: seguiu o legado (flat, Init com 6 parametros, sem PageFrame) e
*     foi REPROVADO pelo gate antigo, que exigia ConfigurarPageFrame.
*   - task272: seguiu o template generico de CRUD (PageFrame Page1/Page2,
*     5 botoes Incluir/Visualizar/Alterar/Excluir/Buscar, CarregarLista) e
*     PASSOU em todos os gates, mas inventou estrutura que o legado nao tem
*     (viola o PILAR 1) - o legado so tem cntSombra + Grid + 3 botoes
*     (Inserir/Excluir/Sair), sem PageFrame nenhum.
* Esta versao (task597) segue o legado, como task169, presumindo que o gate
* da Fase 3 ja foi corrigido (2026-09-25, ver memorias acima) para aceitar o
* ramo FLAT COM CONTAINER quando FormType = OPERACIONAL.
*
* Fase 3/8 (ESTE ARQUIVO): Estrutura base.
*   - DEFINE CLASS + propriedades visuais/estado (sem PageFrame - o legado
*     nao tem nenhum)
*   - Init(par_oFormPai, par_cEscolha, par_cEmps, par_cDopes, par_nNumes):
*     cria o BO, guarda o form pai (e o desabilita, como o legado faz),
*     monta this_cEmpDopNums (chave POSICIONAL - regra #42 CLAUDE.md, NUNCA
*     ALLTRIM nas partes) e o Caption dinamico ("Cotacoes " + pcEdn)
*   - InicializarForm/ConfigurarCabecalho (cnt_4c_Sombra + lbl_4c_LblSombra/
*     lbl_4c_LblTitulo - nomes EXATOS de mapeamento.json) / Destroy
*   - AtualizarBotoesFormPai: porta fiel de SIGPRCTC.mctrlbotoes. No legado
*     TODO o corpo esta comentado (*!*) - preservado como no-op fiel.
*
*   pnDataSes (DataSession do form pai) NAO tem equivalente aqui: o legado
*   usava "Set DataSession to pnDataSes" (este SCX tem DataSession=2 privada)
*   para compartilhar cursores (LocalCtMoe etc.) com a sessao do pai. Na
*   arquitetura nova nao ha DataSession privada por form nem cursor
*   compartilhado por sessao - cada SQLEXEC usa gnConnHandle global e cursor
*   com nome proprio. Omitido de proposito, nao esquecido.
*
* Fase 4/8 (ESTE ARQUIVO): Grid e botoes.
*   - ConfigurarGrid (grd_4c_Dados - 3 colunas: Moeda/Descricao/Cotacao,
*     larguras exatas do legado 50/200/95). Lookup fwbuscaext em SigCdMoe
*     (Column1.Text1.Valid/LostFocus/When legado) emulado via
*     ColMoedaLostFocus (FormBuscaAuxiliar) + ColMoedaGotFocus/
*     ColDescricaoGotFocus (gate de foco por celula, regra #3 CLAUDE.md -
*     BINDEVENT em "Valid"/"When" nao dispara/nao bloqueia de forma
*     confiavel em TextBox/Column)
*   - CarregarDados/SigPrCtcBO.CarregarGradeCotacoes: cursor_4c_Dados local e
*     editavel (equivalente a LocalCtMoe), populado pelo SELECT com JOIN em
*     SigCdMoe do Init legado
*   - ConfigurarBotoes (cmd_4c_CmdInserir/cmd_4c_CmdExcluir/cmd_4c_CmdSair -
*     nomes de mapeamento.json) + Shape1 (shp_4c_Shape1, decorativo atras
*     dos botoes) - AjustarBotoesPorAcesso espelha o bloco ativo (SEM *!*) do
*     Init legado: Visible/Enabled por fChecaAcesso+this_cEscolha e o calculo
*     de Left/Width do shape em cascata
*   - Handlers Click: BtnInserirClick (equivalente a cmdInserir.Click),
*     BtnExcluirClick (cmdExcluir.Click), BtnSairClick (cmdSair.Click - checa
*     duplicidade de moeda, grava em lote via SigPrCtcBO.SalvarGradeCotacoes,
*     reabilita o form pai via AtualizarBotoesFormPai(.T.), Release)
*
* Fase 5-6/8: sem campos de dados fora da grade e sem lookup de TEXTBOX solto
*   no form - o unico lookup do legado (fwbuscaext em SigCdMoe) ja foi
*   portado DENTRO da Column1.Text1 da grade na Fase 4, acima. Gate
*   consultado antes de gerar metodo vazio.
*
* Fase 7-8/8: o vocabulario CRUD do frmcadastro (BtnIncluirClick/
*   BtnAlterarClick/BtnVisualizarClick/CarregarLista/AlternarPagina/
*   FormParaBO/BOParaForm/HabilitarCampos/AjustarBotoesPorModo) NAO se aplica
*   - este dialogo nao tem Lista/Dados, nao tem modo de edicao por registro,
*     grava tudo em lote no Sair. Equivalentes reais ja cobertos na Fase 4:
*     BtnInserirClick/BtnExcluirClick/BtnSairClick.
*
* Layout OPERACIONAL flat (550x384, igual ao legado) - dialogo modal SEM
* PageFrame Lista/Dados do padrao CRUD.
*==============================================================================

DEFINE CLASS FormSigPrCtc AS FormBase

    *--------------------------------------------------------------------------
    * Propriedades visuais do form (SIGPRCTC.scx - SECAO 2)
    *--------------------------------------------------------------------------
    Width        = 550
    Height       = 384
    AutoCenter   = .T.
    Movable      = .T.
    BorderStyle  = 2
    ControlBox   = .F.
    Closable     = .F.
    MaxButton    = .F.
    MinButton    = .F.
    TitleBar     = 0
    ClipControls = .F.
    ShowWindow   = 1
    WindowType   = 1
    FontName     = "Tahoma"
    FontSize     = 8
    Caption      = ""

    *--------------------------------------------------------------------------
    * Propriedades de estado (equivalentes as customizadas do ClassInfo do
    * legado: parentform, pcescolha, pcedn, lhouveins, lhouveexcl)
    *--------------------------------------------------------------------------
    this_oBusinessObject = .NULL.
    this_oFormPai         = .NULL.
    this_cEscolha         = ""
    this_cEmpDopNums      = ""
    this_lHouveIns        = .F.
    this_lHouveExcl       = .F.

    *-- Guarda de reentrancia do gate de foco entre Column1(Moeda)/
    *-- Column2(Descricao) da grade (ColMoedaGotFocus/ColDescricaoGotFocus) -
    *-- sem ela, redirecionar o foco de uma celula bloqueada para outra
    *-- tambem bloqueada dispara GotFocus->SetFocus->GotFocus em loop
    this_lNavegandoGrade  = .F.

    *==========================================================================
    * Init - Equivalente a "LParameters poForm, pnDataSes, pcEscolha, pcEmps,
    * pcDopes, pnNumes" do legado (pnDataSes omitido - ver cabecalho do
    * arquivo). Guarda o form pai, desabilita-o, monta a chave posicional
    * EmpDopNums e o Caption dinamico ANTES de DODEFAULT() (FormBase.Init
    * chama InicializarForm em seguida, que precisa do Caption pronto para
    * ConfigurarCabecalho).
    *==========================================================================
    PROCEDURE Init(par_oFormPai, par_cEscolha, par_cEmps, par_cDopes, par_nNumes)
        THIS.this_oBusinessObject = CREATEOBJECT("SigPrCtcBO")
        IF VARTYPE(THIS.this_oBusinessObject) != "O"
            MsgErro("Erro ao criar SigPrCtcBO.", "Erro")
            RETURN .F.
        ENDIF

        IF VARTYPE(par_oFormPai) = "O"
            THIS.this_oFormPai = par_oFormPai
            THIS.this_oFormPai.Enabled = .F.
        ENDIF

        THIS.this_cEscolha = IIF(VARTYPE(par_cEscolha) = "C", par_cEscolha, "")

        *-- Chave POSICIONAL (Emps + Dopes + Str(Numes,6)) - NUNCA ALLTRIM nas
        *-- partes (regra #42 CLAUDE.md / Erro177): o padding faz parte da
        *-- chave, igual ao legado "ThisForm.pcEdn = pcEmps + pcDopes + Str(pnNumes,6)".
        THIS.this_cEmpDopNums = IIF(VARTYPE(par_cEmps) = "C", par_cEmps, "") + ;
                                IIF(VARTYPE(par_cDopes) = "C", par_cDopes, "") + ;
                                STR(IIF(VARTYPE(par_nNumes) = "N", par_nNumes, 0), 6)

        THIS.Caption = "Cota" + CHR(231) + CHR(245) + "es " + ;
                       ALLTRIM(PROPER(THIS.this_cEmpDopNums))

        THIS.AtualizarBotoesFormPai(.F.)

        RETURN DODEFAULT()
    ENDPROC

    *==========================================================================
    * InicializarForm - Monta a estrutura base do form (sem PageFrame - o
    * legado nao tem nenhum). Contrato do FormBase.Init: retorna .T./.F.
    *==========================================================================
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lSucesso, loc_oErro, loc_lModoValidacaoOuTeste

        loc_lSucesso = .F.
        loc_lModoValidacaoOuTeste = (TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI) OR ;
                                    (TYPE("gb_4c_ModoTeste")   = "L" AND gb_4c_ModoTeste)

        TRY
            *-- Picture nao pode ser literal de classe (depende de variavel
            *-- global) - atribuido em runtime (regra #21/#25 CLAUDE.md).
            *-- Arquivo confirmado em vbmp\new_background.jpg.
            THIS.Picture = gc_4c_CaminhoIcones + "new_background.jpg"

            THIS.ConfigurarCabecalho()

            *-- Grade de cotacoes (GradeSubN legado) - so estrutura, sem
            *-- ControlSource ainda (cursor_4c_Dados so existe depois de
            *-- CarregarDados - regra #41 CLAUDE.md)
            THIS.ConfigurarGrid()

            *-- Shape1 decorativo (Left/Width calculados em
            *-- AjustarBotoesPorAcesso, que depende dos botoes existirem)
            THIS.ConfigurarShape()

            *-- Botoes de acao (cmdInserir/cmdExcluir/cmdSair legados) -
            *-- criados DEPOIS do cabecalho para desenhar por cima dele
            *-- (Top=3, dentro da faixa Top=0..80 - regra #11 CLAUDE.md)
            THIS.ConfigurarBotoes()

            THIS.TornarControlesVisiveis(THIS)

            *-- Espelha o bloco "Acesso dos Botoes" do Init legado
            *-- (fChecaAcesso + shape1) - tem que rodar DEPOIS do
            *-- TornarControlesVisiveis, senao a visibilidade generica
            *-- sobrescreve o Visible calculado aqui
            THIS.AjustarBotoesPorAcesso()

            *-- Popula a grade (pulado em modo teste/validacao de UI - sem
            *-- conexao SQL disponivel)
            IF !loc_lModoValidacaoOuTeste
                THIS.CarregarDados()
            ENDIF

            loc_lSucesso = .T.

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Erro em FormSigPrCtc.InicializarForm")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * ConfigurarCabecalho - Container cinza com titulo (cntSombra legado).
    * Nomes EXATOS de mapeamento.json: cnt_4c_Sombra / lbl_4c_LblSombra /
    * lbl_4c_LblTitulo. Posicoes/fontes EXATAS do dump legado (FontSize=18,
    * unico entre os forms do padrao canonico - transcrito, nao "corrigido").
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarCabecalho()
        THIS.AddObject("cnt_4c_Sombra", "Container")
        WITH THIS.cnt_4c_Sombra
            .Top         = 0
            .Left        = 0
            .Width       = THIS.Width
            .Height      = 80
            .BackStyle   = 1
            .BackColor   = RGB(100, 100, 100)
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH

        THIS.cnt_4c_Sombra.AddObject("lbl_4c_LblSombra", "Label")
        WITH THIS.cnt_4c_Sombra.lbl_4c_LblSombra
            .Top       = 18
            .Left      = 10
            .Width     = THIS.Width - 20
            .Height    = 40
            .FontName  = "Tahoma"
            .FontSize  = 18
            .FontBold  = .T.
            .ForeColor = RGB(0, 0, 0)
            .BackStyle = 0
            .WordWrap  = .T.
            .AutoSize  = .F.
            .Alignment = 0
            .Caption   = THIS.Caption
            .Visible   = .T.
        ENDWITH

        THIS.cnt_4c_Sombra.AddObject("lbl_4c_LblTitulo", "Label")
        WITH THIS.cnt_4c_Sombra.lbl_4c_LblTitulo
            .Top       = 17
            .Left      = 10
            .Width     = THIS.Width - 20
            .Height    = 46
            .FontName  = "Tahoma"
            .FontSize  = 18
            .FontBold  = .T.
            .ForeColor = RGB(255, 255, 255)
            .BackStyle = 0
            .WordWrap  = .T.
            .AutoSize  = .F.
            .Alignment = 0
            .Caption   = THIS.Caption
            .Visible   = .T.
        ENDWITH
    ENDPROC

    *==========================================================================
    * ConfigurarGrid - Grade de cotacoes (GradeSubN legado): Column1=Moeda,
    * Column2=Descricao, Column3=Cotacao. Dimensoes/propriedades EXATAS do
    * SCX (form flat 550x384, sem PageFrame - nao ha compensacao de offset).
    * So estrutura aqui - RecordSource/ControlSource entram em CarregarDados,
    * depois que cursor_4c_Dados existir (regra #41 CLAUDE.md).
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarGrid()
        THIS.AddObject("grd_4c_Dados", "Grid")
        WITH THIS.grd_4c_Dados
            .Top           = 110
            .Left          = 85
            .Width         = 379
            .Height        = 243
            .ColumnCount   = 3
            .FontName      = "Tahoma"
            .FontSize      = 8
            .DeleteMark    = .F.
            .RecordMark    = .F.
            .RowHeight     = 16
            .ScrollBars    = 2
            .TabIndex      = 1
            .GridLineColor = RGB(238, 238, 238)
        ENDWITH

        *-- Column1 = Moeda (Column1.Header1/Column1.Text1 do legado) - lookup
        *-- fwbuscaext em SigCdMoe, transcrito como LostFocus (BINDEVENT em
        *-- "Valid" nao dispara de forma confiavel em TextBox - regra #3).
        *-- Editavel so quando a linha ainda nao tem moeda (When legado:
        *-- Return(Empty(LocalCtMoe.cMoes))) - emulado via GotFocus, ja que
        *-- BINDEVENT em "When" nao usa o retorno do delegate para bloquear a
        *-- entrada.
        WITH THIS.grd_4c_Dados.Column1
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Width     = 50
            .Movable   = .F.
            .Resizable = .F.
            .Header1.FontName  = "Tahoma"
            .Header1.FontSize  = 8
            .Header1.Alignment = 2
            .Header1.Caption   = "Moeda"
            .Text1.FontName    = "Tahoma"
            .Text1.FontSize    = 8
            .Text1.BorderStyle = 0
            .Text1.Margin      = 0
            .Text1.ForeColor   = RGB(0, 0, 0)
            .Text1.BackColor   = RGB(255, 255, 255)
        ENDWITH
        BINDEVENT(THIS.grd_4c_Dados.Column1.Text1, "LostFocus", THIS, "ColMoedaLostFocus")
        BINDEVENT(THIS.grd_4c_Dados.Column1.Text1, "GotFocus", THIS, "ColMoedaGotFocus")

        *-- Column2 = Descricao (Column2.Header1/Column2.Text1 do legado) -
        *-- somente exibicao (When legado: Return .f. - nunca recebe foco),
        *-- preenchida pelo lookup de Column1 (ColMoedaLostFocus)
        WITH THIS.grd_4c_Dados.Column2
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Width     = 200
            .Movable   = .F.
            .Resizable = .F.
            .Header1.FontName  = "Tahoma"
            .Header1.FontSize  = 8
            .Header1.Alignment = 2
            .Header1.Caption   = "Descri" + CHR(231) + CHR(227) + "o"
            .Text1.FontName    = "Tahoma"
            .Text1.FontSize    = 8
            .Text1.BorderStyle = 0
            .Text1.Margin      = 0
            .Text1.ForeColor   = RGB(0, 0, 0)
            .Text1.BackColor   = RGB(255, 255, 255)
        ENDWITH
        BINDEVENT(THIS.grd_4c_Dados.Column2.Text1, "GotFocus", THIS, "ColDescricaoGotFocus")

        *-- Column3 = Cotacao (Column3.Header1/Column3.Text1 do legado) - sem
        *-- When no legado, sempre editavel (linhas ja gravadas podem ter a
        *-- cotacao reajustada)
        WITH THIS.grd_4c_Dados.Column3
            .FontName      = "Tahoma"
            .FontSize      = 8
            .Width         = 95
            .Movable       = .F.
            .Resizable     = .F.
            .SelectOnEntry = .F.
            .InputMask     = "99999.9999999"
            .Header1.FontName  = "Tahoma"
            .Header1.FontSize  = 8
            .Header1.Alignment = 2
            .Header1.Caption   = "Cota" + CHR(231) + CHR(227) + "o"
            .Text1.FontName    = "Tahoma"
            .Text1.FontSize    = 8
            .Text1.BorderStyle = 0
            .Text1.Format      = "K"
            .Text1.Margin      = 0
            .Text1.ForeColor   = RGB(0, 0, 0)
            .Text1.BackColor   = RGB(255, 255, 255)
        ENDWITH
    ENDPROC

    *==========================================================================
    * ColMoedaLostFocus - Espelha SIGPRCTC.GradeSubN.Column1.Text1.LostFocus
    * (foco vai para o Sair se vazio) + .Valid (lookup fwbuscaext em SigCdMoe)
    * do legado, unificados aqui porque BINDEVENT em "Valid" nao dispara de
    * forma confiavel em TextBox (regra #3 CLAUDE.md). Contrato do
    * FormBuscaAuxiliar: this_lAchouRegistro ANTES do Show(), this_lSelecionou
    * ANTES de atribuir o valor, 1o argumento do Init eh gnConnHandle
    * (regra #37 CLAUDE.md).
    * PUBLIC - alvo de BINDEVENT (regra #3 CLAUDE.md)
    *==========================================================================
    PROCEDURE ColMoedaLostFocus()
        LOCAL loc_cValor, loc_oBusca

        IF !USED("cursor_4c_Dados") OR EOF("cursor_4c_Dados")
            RETURN
        ENDIF

        loc_cValor = ALLTRIM(THIS.grd_4c_Dados.Column1.Text1.Value)

        IF EMPTY(loc_cValor)
            THIS.grd_4c_Dados.Column1.Text1.Value = ""
            REPLACE cmoes WITH "", descrs WITH "" IN cursor_4c_Dados
            THIS.cmd_4c_CmdSair.SetFocus()
            THIS.grd_4c_Dados.Refresh()
            RETURN
        ENDIF

        loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
            "SigCdMoe", "cursor_4c_BuscaMoeda", "CMoes", loc_cValor, ;
            "Sele" + CHR(231) + CHR(227) + "o")

        IF VARTYPE(loc_oBusca) = "O"
            IF !loc_oBusca.this_lAchouRegistro
                loc_oBusca.mAddColuna("CMoes", "", "C" + CHR(243) + "digo")
                loc_oBusca.mAddColuna("DMoes", "", "Descri" + CHR(231) + CHR(227) + "o")
                loc_oBusca.Show()
            ENDIF

            IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaMoeda")
                SELECT cursor_4c_BuscaMoeda
                THIS.grd_4c_Dados.Column1.Text1.Value = ALLTRIM(cursor_4c_BuscaMoeda.CMoes)
                REPLACE cmoes  WITH ALLTRIM(cursor_4c_BuscaMoeda.CMoes), ;
                        descrs WITH ALLTRIM(cursor_4c_BuscaMoeda.DMoes) IN cursor_4c_Dados
            ELSE
                THIS.grd_4c_Dados.Column1.Text1.Value = ""
                REPLACE cmoes WITH "", descrs WITH "" IN cursor_4c_Dados
            ENDIF

            loc_oBusca.Release()
        ENDIF

        IF USED("cursor_4c_BuscaMoeda")
            USE IN cursor_4c_BuscaMoeda
        ENDIF

        THIS.grd_4c_Dados.Refresh()
    ENDPROC

    *==========================================================================
    * ColMoedaGotFocus - Emula SIGPRCTC.GradeSubN.Column1.Text1.When
    * (Return(Empty(LocalCtMoe.cMoes))): a celula so recebe foco quando a
    * linha corrente ainda nao tem moeda preenchida; caso contrario, o foco
    * eh redirecionado para a Cotacao da mesma linha (BINDEVENT em "When" nao
    * usa o retorno do delegate para bloquear a entrada).
    * PUBLIC - alvo de BINDEVENT (regra #3 CLAUDE.md)
    *==========================================================================
    PROCEDURE ColMoedaGotFocus()
        IF THIS.this_lNavegandoGrade OR !USED("cursor_4c_Dados") OR EOF("cursor_4c_Dados")
            RETURN
        ENDIF

        IF !EMPTY(ALLTRIM(cursor_4c_Dados.cmoes))
            THIS.this_lNavegandoGrade = .T.
            THIS.grd_4c_Dados.Column3.SetFocus()
            THIS.this_lNavegandoGrade = .F.
        ENDIF
    ENDPROC

    *==========================================================================
    * ColDescricaoGotFocus - Emula SIGPRCTC.GradeSubN.Column2.Text1.When
    * (Return .f. - a coluna nunca recebe foco, eh so exibicao). Redireciona
    * sempre para a Cotacao da mesma linha.
    * PUBLIC - alvo de BINDEVENT (regra #3 CLAUDE.md)
    *==========================================================================
    PROCEDURE ColDescricaoGotFocus()
        IF THIS.this_lNavegandoGrade
            RETURN
        ENDIF

        THIS.this_lNavegandoGrade = .T.
        THIS.grd_4c_Dados.Column3.SetFocus()
        THIS.this_lNavegandoGrade = .F.
    ENDPROC

    *==========================================================================
    * ConfigurarShape - Shape1 decorativo (Top/Height fixos do SCX; Left/
    * Width calculados em AjustarBotoesPorAcesso, que depende dos botoes
    * ja existirem).
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarShape()
        THIS.AddObject("shp_4c_Shape1", "Shape")
        WITH THIS.shp_4c_Shape1
            .Top         = 12
            .Height      = 110
            .BackStyle   = 0
            .BorderStyle = 0
            .BorderColor = RGB(136, 189, 188)
        ENDWITH
    ENDPROC

    *==========================================================================
    * ConfigurarBotoes - Botoes standalone (fwbtng do legado) - Width/Height
    * canonicos 75x75 (padrao do projeto para fwbtng migrado - ver
    * FormSIGPRCOT.ConfigurarBotoes), Themes=.T. + DisabledPicture
    * obrigatorios em CommandButton icone-only fora de CommandGroup (regra
    * feedback_icon_only_button_disable_runtime). Left = valor de DESENHO do
    * SCX (325/400/475) - Inserir/Excluir sao recalculados em cascata por
    * AjustarBotoesPorAcesso; Sair NUNCA se move.
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarBotoes()
        LOCAL loc_cIcones
        loc_cIcones = IIF(TYPE("gc_4c_CaminhoIcones") = "C", gc_4c_CaminhoIcones, "")

        THIS.AddObject("cmd_4c_CmdInserir", "CommandButton")
        WITH THIS.cmd_4c_CmdInserir
            .Top             = 3
            .Left            = 325
            .Width           = 75
            .Height          = 75
            .Caption         = "Inserir"
            .Picture         = loc_cIcones + "cadastro_inserir_60.jpg"
            .DisabledPicture = loc_cIcones + "cadastro_inserir_60.jpg"
            .Themes          = .T.
            .TabIndex        = 4
            .FontName        = "Comic Sans MS"
            .FontBold        = .T.
            .FontItalic      = .T.
            .FontSize        = 8
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .SpecialEffect   = 0
            .PicturePosition = 13
            .MousePointer    = 15
            .WordWrap        = .T.
            .AutoSize        = .F.
        ENDWITH
        BINDEVENT(THIS.cmd_4c_CmdInserir, "Click", THIS, "BtnInserirClick")

        THIS.AddObject("cmd_4c_CmdExcluir", "CommandButton")
        WITH THIS.cmd_4c_CmdExcluir
            .Top             = 3
            .Left            = 400
            .Width           = 75
            .Height          = 75
            .Caption         = "Excluir"
            .Picture         = loc_cIcones + "cadastro_excluir_60.jpg"
            .DisabledPicture = loc_cIcones + "cadastro_excluir_60.jpg"
            .Themes          = .T.
            .TabIndex        = 2
            .FontName        = "Comic Sans MS"
            .FontBold        = .T.
            .FontItalic      = .T.
            .FontSize        = 8
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .SpecialEffect   = 0
            .PicturePosition = 13
            .MousePointer    = 15
            .WordWrap        = .T.
            .AutoSize        = .F.
        ENDWITH
        BINDEVENT(THIS.cmd_4c_CmdExcluir, "Click", THIS, "BtnExcluirClick")

        THIS.AddObject("cmd_4c_CmdSair", "CommandButton")
        WITH THIS.cmd_4c_CmdSair
            .Top             = 3
            .Left            = 475
            .Width           = 75
            .Height          = 75
            .Caption         = "Encerrar"
            .Picture         = loc_cIcones + "cadastro_sair_60.jpg"
            .DisabledPicture = loc_cIcones + "cadastro_sair_60.jpg"
            .Themes          = .T.
            .Cancel          = .T.
            .TabIndex        = 3
            .FontName        = "Comic Sans MS"
            .FontBold        = .T.
            .FontItalic      = .T.
            .FontSize        = 8
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .SpecialEffect   = 0
            .PicturePosition = 13
            .MousePointer    = 15
            .WordWrap        = .T.
            .AutoSize        = .F.
        ENDWITH
        BINDEVENT(THIS.cmd_4c_CmdSair, "Click", THIS, "BtnSairClick")
    ENDPROC

    *==========================================================================
    * AjustarBotoesPorAcesso - Espelha o bloco ativo do Init legado (as
    * linhas SEM "*!*"):
    *   .cmdInserir.Visible = fChecaAcesso('SIGPRCTC','INSERIR') And ;
    *       Iif(Type('Thisform.PcEscolha')#'C', .T., InList(PcEscolha,'INSERIR','ALTERAR'))
    *   .cmdExcluir.Visible = fChecaAcesso('SIGPRCTC','EXCLUIR') And (mesma condicao)
    *   .shape1.Left/.Width em cascata conforme quem estiver visivel
    * this_cEscolha (Fase 3) normaliza par_cEscolha AUSENTE para "" - logo
    * "nao informado" (legado: Type()#'C') equivale a EMPTY() aqui.
    * Chamado DEPOIS de TornarControlesVisiveis, senao a visibilidade
    * generica sobrescreveria o Visible calculado aqui.
    *==========================================================================
    PROTECTED PROCEDURE AjustarBotoesPorAcesso()
        LOCAL loc_lPermiteEscolha

        loc_lPermiteEscolha = EMPTY(THIS.this_cEscolha) OR ;
            INLIST(THIS.this_cEscolha, "INSERIR", "ALTERAR")

        THIS.cmd_4c_CmdInserir.Visible = fChecaAcesso("SIGPRCTC", "INSERIR") AND loc_lPermiteEscolha
        THIS.cmd_4c_CmdInserir.Enabled = THIS.cmd_4c_CmdInserir.Visible

        THIS.cmd_4c_CmdExcluir.Visible = fChecaAcesso("SIGPRCTC", "EXCLUIR") AND loc_lPermiteEscolha
        THIS.cmd_4c_CmdExcluir.Enabled = THIS.cmd_4c_CmdExcluir.Visible

        THIS.shp_4c_Shape1.Left  = IIF(THIS.cmd_4c_CmdInserir.Visible, THIS.cmd_4c_CmdInserir.Left - 5, ;
                                     IIF(THIS.cmd_4c_CmdExcluir.Visible, THIS.cmd_4c_CmdExcluir.Left - 5, ;
                                     THIS.cmd_4c_CmdSair.Left - 5))
        THIS.shp_4c_Shape1.Width = IIF(THIS.cmd_4c_CmdInserir.Visible, 3, ;
                                     IIF(THIS.cmd_4c_CmdExcluir.Visible, 2, 1)) * THIS.cmd_4c_CmdSair.Width + 16
    ENDPROC

    *==========================================================================
    * CarregarDados - Popula cursor_4c_Dados (SigPrCtcBO.CarregarGradeCotacoes)
    * e vincula a grade. Espelha o bloco final do Init legado ("Select
    * LocalCtMoe / Goto Top / With Thisform.GradeSubN ... RecordSource ...").
    * RecordSource/ControlSource resetam Width e Header1.Caption -
    * reconfigurar SEMPRE depois de vincular (CLAUDE.md Problema 48).
    * PUBLIC - TesteAutomatico.prg chama metodos do form direto de fora da
    * classe (regra #3 CLAUDE.md)
    *==========================================================================
    PROCEDURE CarregarDados()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        IF VARTYPE(THIS.this_oBusinessObject) = "O"
            loc_lSucesso = THIS.this_oBusinessObject.CarregarGradeCotacoes(THIS.this_cEmpDopNums)
        ENDIF

        IF USED("cursor_4c_Dados")
            SELECT cursor_4c_Dados
            GO TOP

            THIS.grd_4c_Dados.RecordSource = ""
            THIS.grd_4c_Dados.RecordSource = "cursor_4c_Dados"
            THIS.grd_4c_Dados.Column1.ControlSource = "cursor_4c_Dados.cmoes"
            THIS.grd_4c_Dados.Column2.ControlSource = "cursor_4c_Dados.descrs"
            THIS.grd_4c_Dados.Column3.ControlSource = "cursor_4c_Dados.valos"

            THIS.grd_4c_Dados.Column1.Width           = 50
            THIS.grd_4c_Dados.Column1.Header1.Caption = "Moeda"
            THIS.grd_4c_Dados.Column2.Width           = 200
            THIS.grd_4c_Dados.Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
            THIS.grd_4c_Dados.Column3.Width           = 95
            THIS.grd_4c_Dados.Column3.Header1.Caption = "Cota" + CHR(231) + CHR(227) + "o"

            THIS.grd_4c_Dados.Refresh()
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * BtnInserirClick - Espelha SIGPRCTC.cmdInserir.Click do legado: garante
    * uma linha em branco (cmoes vazio) para o usuario preencher, sem
    * duplicar se ja existir uma pendente.
    * PUBLIC - alvo de BINDEVENT (regra #3 CLAUDE.md)
    *==========================================================================
    PROCEDURE BtnInserirClick()
        THIS.this_lHouveIns = .T.

        IF USED("cursor_4c_Dados")
            SELECT cursor_4c_Dados
            LOCATE FOR EMPTY(ALLTRIM(cmoes))

            IF !FOUND()
                INSERT INTO cursor_4c_Dados (empdopnums, pkchaves) ;
                    VALUES (THIS.this_cEmpDopNums, LEFT(fUniqueIds(), 20))
            ENDIF

            *-- Popular o cursor NAO repinta a grade (CLAUDE.md regra #21)
            THIS.grd_4c_Dados.Refresh()
            THIS.grd_4c_Dados.Column1.SetFocus()
        ENDIF
    ENDPROC

    *==========================================================================
    * BtnExcluirClick - Espelha SIGPRCTC.cmdExcluir.Click do legado: remove a
    * linha corrente da grade (local - a exclusao no banco so acontece no
    * Sair, via SalvarGradeCotacoes, igual ao legado).
    * PUBLIC - alvo de BINDEVENT (regra #3 CLAUDE.md)
    *==========================================================================
    PROCEDURE BtnExcluirClick()
        IF USED("cursor_4c_Dados")
            SELECT cursor_4c_Dados
            IF !EOF()
                THIS.this_lHouveExcl = .T.
                DELETE
                SKIP
                SKIP -1
            ENDIF
        ENDIF

        THIS.grd_4c_Dados.Refresh()
    ENDPROC

    *==========================================================================
    * BtnSairClick - Espelha SIGPRCTC.cmdSair.Click do legado: se houve
    * inclusao/exclusao E os botoes de edicao estao disponiveis, valida
    * duplicidade de moeda (Select cMoes,sum(1)... do legado - bloqueia o
    * fechamento, "Return .f." no legado) e sincroniza em lote com o banco
    * (SigPrCtcBO.SalvarGradeCotacoes). Falha de GRAVACAO (delete/insert) NAO
    * impede o fechamento - o proprio legado so avisa e segue para o Release.
    * PUBLIC - alvo de BINDEVENT (regra #3 CLAUDE.md)
    *==========================================================================
    PROCEDURE BtnSairClick()
        LOCAL loc_lPodeAlterar, loc_lHouveMudanca, loc_lDuplicado, loc_cMoedaDup

        loc_lPodeAlterar  = THIS.cmd_4c_CmdInserir.Visible OR THIS.cmd_4c_CmdExcluir.Visible
        loc_lHouveMudanca = THIS.this_lHouveExcl OR THIS.this_lHouveIns

        IF loc_lPodeAlterar AND loc_lHouveMudanca

            loc_lDuplicado = .F.
            IF USED("cursor_4c_Dados")
                SELECT cmoes FROM cursor_4c_Dados WHERE !EMPTY(ALLTRIM(cmoes)) ;
                    GROUP BY cmoes HAVING COUNT(*) > 1 INTO CURSOR cursor_4c_CtcDuplic

                IF RECCOUNT("cursor_4c_CtcDuplic") > 0
                    loc_cMoedaDup  = ALLTRIM(cursor_4c_CtcDuplic.cmoes)
                    loc_lDuplicado = .T.
                ENDIF

                IF USED("cursor_4c_CtcDuplic")
                    USE IN cursor_4c_CtcDuplic
                ENDIF
            ENDIF

            IF loc_lDuplicado
                MsgErro("Moedas " + loc_cMoedaDup + " Digitada em Duplicidade!!!!", ;
                        "Aten" + CHR(231) + CHR(227) + "o")
                RETURN
            ENDIF

            THIS.this_oBusinessObject.SalvarGradeCotacoes("cursor_4c_Dados", THIS.this_cEmpDopNums)
        ENDIF

        THIS.AtualizarBotoesFormPai(.T.)
        THIS.Release()
    ENDPROC

    *==========================================================================
    * AtualizarBotoesFormPai - Porta fiel de SIGPRCTC.mctrlbotoes. No legado
    * TODO o corpo (With Thisform.ParentForm.Pagina.Lista... Grupo_Op/
    * cmdFPOper/Grupo_Saida.Sair) esta comentado (*!*) e nunca executa -
    * preservado como no-op fiel, nao inventado. Chamado por THIS.Init(.F.)
    * e, na Fase 4, por BtnSairClick(.T.), igual ao legado.
    *==========================================================================
    PROTECTED PROCEDURE AtualizarBotoesFormPai(par_lHabilita)
        LOCAL loc_lHabilita
        loc_lHabilita = IIF(VARTYPE(par_lHabilita) = "L", par_lHabilita, .F.)
        *-- Corpo intencionalmente vazio: legado inteiro comentado (*!*).
    ENDPROC

    *==========================================================================
    * TornarControlesVisiveis - Recursivo, aplica Visible=.T. em toda a
    * hierarquia (nada a pular ainda - grid/botoes chegam na Fase 4).
    *==========================================================================
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

    *==========================================================================
    * Destroy - Reabilita o form pai (equivalente a "Thisform.ParentForm.
    * Enabled = .T." do cmdSair.Click legado - repetido aqui como rede de
    * seguranca para fechamento fora do botao Sair), libera referencias.
    *==========================================================================
    PROCEDURE Destroy()
        IF VARTYPE(THIS.this_oFormPai) = "O"
            THIS.this_oFormPai.Enabled = .T.
        ENDIF

        THIS.this_oBusinessObject = .NULL.
        THIS.this_oFormPai        = .NULL.

        DODEFAULT()
    ENDPROC

ENDDEFINE
